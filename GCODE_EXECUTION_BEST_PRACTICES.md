# G-code Execution Best Practices for Mach4

Field-tested patterns for running G-code from Mach4 Lua smoothly (no stutter), safely (no GUI hangs), and without flooding the interpreter.

## Core Rules (Why & When)

Based on guidance from Mach4's lead developer and MachSupport community:

1. **Don't drip-feed line-by-line** with repeated `mcCntlGcodeExecute()` calls. Concatenate multiple blocks into one string with `\n` separators instead. Otherwise your second call can't submit until the first completes, behaving like a block and risking hiccups.

2. **Use `mcCntlGcodeExecuteWait()` only inside macros (M-codes)**—never from GUI button handlers—because it blocks the event and freezes screen updates until motion finishes. For buttons or screen scripts, prefer non-blocking + PLC polling.

3. **200-line threshold rule**: If your G-code is less than 200 lines, concatenate and use `mcCntlGcodeExecute()`. If longer, create a temporary file and use file-based execution (`mcCntlLoadGcodeFile()` + `mcCntlCycleStart()`). **Never chunk programs** - this causes motion hiccups.

4. **Use PLC scripts for monitoring** - this is the preferred approach by Mach developers for watching run state and processing input events while keeping the UI responsive.

## Three Clean Patterns That Cover 99% of Cases

### Pattern A: Macro Pattern (Blocking, Simple, Reliable)

**Use for M-codes** (e.g., toolchange, probing) where blocking is OK, the motion is very short, and you want the motion to finish before continuing.

```lua
function m200()
    local inst = mc.mcGetInstance()

    -- Build one unit of work; multiple lines joined with \n
    local g = table.concat({
        "G90 G53 Z0.0",
        "G53 X10 Y10", 
        "G1 Z-5.0 F200",
        "G0 Z0.0"
    }, "\n")

    -- Blocking (MACRO ONLY): runs cleanly, no GUI events needed
    local rc = mc.mcCntlGcodeExecuteWait(inst, g)
    if rc ~= mc.MERROR_NOERROR then
        mc.mcCntlSetLastError(inst, "G-code execution failed")
    end
end

if (mc.mcInEditor()==1) then m200() end
```

**Why this works:** Mach's own scripting guide builds a G-code string and feeds it once to `ExecuteWait()` in macros; the interpreter runs it smoothly, then Lua continues.

### Pattern B: Screen/PLC Pattern (Non-blocking, Responsive GUI)

**Use for buttons, panels, or when you need to watch inputs/UI while motion runs.**

**Step 1 (Button Handler):** Submit a single concatenated string non-blocking

```lua
-- Button click handler
local inst = mc.mcGetInstance()
local g = "G90 G53 Z0.0\nG53 X10 Y10\nG1 Z-5.0 F200\nG0 Z0.0"
mc.mcCntlGcodeExecute(inst, g)  -- non-blocking submission
```

**Step 2 (PLC Script):** Poll machine state without freezing anything

```lua
-- PLC script (runs periodically) - PREFERRED MONITORING METHOD
local inst = mc.mcGetInstance()
local inCycle = mc.mcCntlIsInCycle(inst)  -- true/false

-- You can also check:
-- local state = mc.mcCntlGetState(inst)  -- MC_STATE_IDLE, MC_STATE_HOLD, etc.
-- local isStill = mc.mcAxisIsStill(inst, mc.X_AXIS)

-- When inCycle == false and axes are still, motion for the last job is done
if not inCycle then
    -- Motion complete - update UI, trigger next action, etc.
end
```

This pattern keeps the UI alive (no "Wait" inside button handlers) and is the **recommended approach by Mach developers**: use PLC/signal scripts to process input events and watch run state.

### Pattern C: Temp File Pattern (For Programs >200 Lines)

**For generated G-code longer than 200 lines**, create a temporary file instead of chunking:

**Step 1: Create temp file helpers** (put in module or screen load script)

```lua
local function make_temp_gcode_file(prefix, gcode_text)
    local std = wx.wxStandardPaths.Get()
    local tempDir = std:GetTempDir()

    -- Create a unique temp file path (empty file gets created)
    local tempPath = wx.wxFileName.CreateTempFileName(prefix or "Mach4_")

    -- Sanity check the directory and file
    if (not tempPath) or (tempPath == "") then
        error("Failed to create a temp file name in: " .. tostring(tempDir))
    end

    -- Write G-code in binary to avoid newline surprises
    local f, err = io.open(tempPath, "wb")
    if not f then
        error("Unable to open temp file for write: " .. tostring(err))
    end
    f:write(gcode_text)
    f:close()

    return tempPath
end

-- Run a temp G-code file and schedule cleanup
local function run_temp_gcode_file(tempPath)
    local inst = mc.mcGetInstance()

    -- Load + start
    local rc1 = mc.mcCntlLoadGcodeFile(inst, tempPath)
    if rc1 ~= mc.MERROR_NOERROR then
        wx.wxRemoveFile(tempPath)  -- best effort cleanup
        error("mcCntlLoadGcodeFile failed, rc=" .. tostring(rc1))
    end
    mc.mcCntlCycleStart(inst)

    -- Stash the path for PLC cleanup (global is fine; a register works too)
    _G.__pendingTempGcodeToDelete = tempPath
end
```

**Step 2: PLC cleanup script** (runs every tick for safe file deletion)

```lua
-- Put this in your PLC script
do
    local inst = mc.mcGetInstance()
    if _G.__pendingTempGcodeToDelete then
        -- Wait until program finishes and machine is still
        local inCycle = (mc.mcCntlIsInCycle(inst) == 1)
        local state = mc.mcCntlGetState(inst)  -- e.g., MC_STATE_IDLE when done
        if (not inCycle) and (state == mc.MC_STATE_IDLE) then
            -- Close the file in Mach so Windows releases the handle
            mc.mcCntlCloseGcodeFile(inst)
            -- A tiny delay helps on some systems before removing the file
            wx.wxMilliSleep(10)
            wx.wxRemoveFile(_G.__pendingTempGcodeToDelete)
            _G.__pendingTempGcodeToDelete = nil
        end
    end
end
```

**Step 3: Usage example**

```lua
-- Build the G-code text (join lines with \n)
local g = table.concat({
    "G90 G53 Z0",
    "G53 X10 Y10", 
    "G1 Z-5.0 F200",
    "G0 Z0"
}, "\n")

local path = make_temp_gcode_file("Mach4Job_", g)
run_temp_gcode_file(path)
-- PLC will close & delete once motion finishes
```

**Why this approach:**
- **Temp location**: `wxStandardPaths:GetTempDir()` returns the correct per-user temp directory on Windows
- **Unique file**: `wxFileName.CreateTempFileName()` creates a unique temp file path safely  
- **Avoids `os.tmpname()`**: Known to be awkward/unsafe on Windows and can crash in some embedders
- **Safe cleanup**: Only removes after motion completes and Mach releases the file handle

## Don't Block the Motion Thread (and Don't Starve the GUI)

**Key Guidelines:**

1. **Avoid `ExecuteWait()` in GUI callbacks** - It will freeze DRO refresh until the motion finishes. Use non-blocking + PLC polling instead.

2. **Throttle your loops** - If you spin-wait in Lua, add a tiny sleep (e.g., `wx.wxMilliSleep(20)`) in polling loops so you don't hog the PLC timeslice.

3. **Use PLC scripts for state monitoring** - This follows general Lua/Mach practice with periodic PLC behavior and non-blocking designs.

## Status & Safety Checks You'll Actually Use

**Is the program running?**
```lua
local inCycle = mc.mcCntlIsInCycle(inst)  -- boolean
```

**Controller state machine:**
```lua  
local state = mc.mcCntlGetState(inst)  -- Returns codes like MC_STATE_IDLE, MC_STATE_HOLD, etc.
-- Handy to gate starts/stops or show progress
```

**Motion finished?**
```lua
local isStill = mc.mcAxisIsStill(inst, mc.X_AXIS)  -- or all axes
-- Good after a FeedHold before resuming logic
```

**Pause/Resume/Stop:**
```lua
mc.mcCntlFeedHold(inst)     -- Pause
mc.mcCntlCycleStart(inst)   -- Resume  
mc.mcCntlCycleStop(inst)    -- Stop
-- Wire these to inputs in the signal script for hard, reliable control
```

## A Tiny Utility You Can Drop In

This works in macros when you want mostly non-blocking execution but still wait for completion safely. It concatenates for smoothness, executes non-blocking, then polls:

```lua
local function runAndWait(inst, lines)
    -- lines: array of g-code blocks
    local g = table.concat(lines, "\n")
    local rc = mc.mcCntlGcodeExecute(inst, g)  -- submit, don't block GUI
    if rc ~= mc.MERROR_NOERROR then
        mc.mcCntlSetLastError(inst, "G-code submit failed")
        return rc
    end
    
    -- Poll until motion completes (PLC-friendly if you move this logic there)
    while mc.mcCntlIsInCycle(inst) do
        wx.wxMilliSleep(20)  -- yield time; don't starve UI/PLC
    end
    
    -- Optional: ensure all axes stopped
    for a=0,5 do
        if mc.mcAxisIsStill(inst, a) == 0 then
            wx.wxMilliSleep(10)
        end
    end
    return rc
end
```

If you call this from a PLC or coroutine context, it stays responsive. If you must call from a macro and want strict blocking, use `ExecuteWait()` instead (simpler and safer there).

## Error Handling (Fail Safe)

Wrap critical sequences with checks and aborts; use structured patterns for validating signals and bailing out cleanly (set last error, e-stop or cycle stop). Use this style when probing, ATC, etc.

```lua
-- Example error handling pattern
local function safeOperation(inst)
    local rc = mc.mcCntlGcodeExecute(inst, gcode_string)
    if rc ~= mc.MERROR_NOERROR then
        mc.mcCntlSetLastError(inst, "Operation failed: " .. mc.mcCntlGetErrorString(inst, rc))
        mc.mcCntlCycleStop(inst)  -- Stop any motion
        return false
    end
    return true
end
```

## Quick Decision Guide

| G-code Length | Use Case | Pattern | Method |
|---------------|----------|---------|--------|
| <200 lines | M-code macro (toolchange, probe) | Macro Pattern | Build one string → `mcCntlGcodeExecuteWait()` |
| <200 lines | Screen button / wizard action | Screen/PLC Pattern | Build one string → `mcCntlGcodeExecute()` → monitor in PLC |
| >200 lines | Any generated or long program | Temp File Pattern | Create temp file → `LoadGcodeFile()` → `CycleStart()` → PLC cleanup |

## Authoritative References

**Mach4 Scripting Guide** - Examples of building/feeding G-code strings and typical macro structure  
*Source: MachSupport official documentation*

**MachSupport Forum (smurph)** - Authoritative guidance on Execute vs ExecuteWait, and why GUI freezes with Wait  
*Source: MachSupport forum posts from lead developer*

**Core API Documentation** - Function signatures and usage for `mcCntlIsInCycle`, `mcAxisIsStill`, etc.  
*Source: Mach4 Core API Reference*

**State Codes Reference** - Machine states (idle/hold/subrun/etc.) via `mcCntlGetState()`  
*Source: IndustryArena and Mach4 documentation*

**Error Handling Patterns** - Structured checks and abort sequences for safe operation  
*Source: Warp9 documentation and examples*

---

Following these field-tested patterns ensures smooth motion quality while maintaining responsive user interfaces in Mach4 plugin development.
