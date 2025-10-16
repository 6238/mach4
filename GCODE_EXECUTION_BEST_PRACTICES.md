# G-code Execution Best Practices for Mach4

This document outlines best practices for executing G-code in Mach4 plugins and macros, balancing motion quality with UI responsiveness.

## Overview

The key challenge in Mach4 G-code execution is maintaining smooth motion quality while keeping the user interface responsive. This requires careful balance between:

- **Motion Quality**: Keeping the motion planner buffer full for smooth acceleration/deceleration
- **UI Responsiveness**: Avoiding long-running blocking operations that freeze the interface
- **Completion Detection**: Knowing when operations finish for proper sequencing
- **Buffer Management**: Not overwhelming the controller with too much G-code at once

## The Problem with Blocking Execution

### ❌ **Avoid: `mcCntlGcodeExecuteWait` for Production**

```lua
-- DON'T DO THIS for large programs:
for i, gcode in ipairs(large_gcode_program) do
    mc.mcCntlGcodeExecuteWait(inst, gcode)  -- BLOCKS UI
end
```

**Problems:**
- Freezes the entire Mach4 interface during execution
- No user interaction possible (no cancel, no status updates)
- Can appear to "hang" the system for long operations
- No timeout protection - could hang indefinitely

### ✅ **Use: Non-blocking Execution with Status Monitoring**

```lua
-- DO THIS instead:
mc.mcCntlGcodeExecute(inst, gcode_chunk)  -- Non-blocking
-- Monitor completion with timer-based polling
```

## Recommended Execution Patterns

### Pattern 1: Timer-Based Chunked Execution

**Best for: Medium to large G-code programs (100-10,000 lines)**

```lua
local function executeGcodeChunks(gcode_chunks, completion_callback)
    local inst = mc.mcGetInstance()
    local current_chunk = 1
    local executing = false
    
    -- Create timer for non-blocking status monitoring
    local timerPanel = wx.wxPanel()
    local timer = wx.wxTimer(timerPanel)
    
    local function submitNextChunk()
        if current_chunk <= #gcode_chunks and not executing then
            executing = true
            
            -- Submit chunk (non-blocking)
            local rc = mc.mcCntlGcodeExecute(inst, gcode_chunks[current_chunk])
            if rc ~= 0 then
                local error_msg = mc.mcCntlGetErrorString(inst, rc)
                wx.wxMessageBox("G-code Error: " .. error_msg, "Error", wx.wxOK)
                return
            end
            
            current_chunk = current_chunk + 1
            timer:Start(100)  -- Check completion every 100ms
            
            -- Optional: Update progress UI
            if progress_callback then
                progress_callback(current_chunk - 1, #gcode_chunks)
            end
        else
            -- All chunks complete
            if completion_callback then
                completion_callback()
            end
        end
    end
    
    -- Timer callback for completion detection
    timerPanel:Connect(wx.wxEVT_TIMER, function()
        local inCycle, rc = mc.mcCntlIsInCycle(inst)
        local isStill, rc2 = mc.mcCntlIsStill(inst)
        
        -- Both conditions must be true for safe continuation
        if not inCycle and isStill then
            timer:Stop()
            executing = false
            submitNextChunk()  -- Continue with next chunk
        end
    end)
    
    submitNextChunk()  -- Start the process
end
```

### Pattern 2: File-Based Execution for Large Programs

**Best for: Very large G-code programs (>10,000 lines)**

```lua
local function executeGcodeFile(filepath, progress_callback, completion_callback)
    local inst = mc.mcGetInstance()
    
    -- Load G-code file
    local rc = mc.mcCntlLoadGcodeFile(inst, filepath)
    if rc ~= mc.MERROR_NOERROR then
        local error_msg = mc.mcCntlGetErrorString(inst, rc)
        wx.wxMessageBox("File Load Error: " .. error_msg, "Error", wx.wxOK)
        return false
    end
    
    -- Get file information
    local fileName, rc1 = mc.mcCntlGetGcodeFileName(inst)
    local totalLines, rc2 = mc.mcCntlGetGcodeLineCount(inst)
    
    if rc1 ~= mc.MERROR_NOERROR or rc2 ~= mc.MERROR_NOERROR then
        wx.wxMessageBox("Failed to get file information", "Error", wx.wxOK)
        mc.mcCntlCloseGcodeFile(inst)
        return false
    end
    
    print("Loaded file: " .. fileName .. " (" .. totalLines .. " lines)")
    
    -- Start execution
    rc = mc.mcCntlCycleStart(inst)
    if rc ~= mc.MERROR_NOERROR then
        local error_msg = mc.mcCntlGetErrorString(inst, rc)
        wx.wxMessageBox("Cycle Start Error: " .. error_msg, "Error", wx.wxOK)
        mc.mcCntlCloseGcodeFile(inst)
        return false
    end
    
    -- Monitor execution with timer
    local timerPanel = wx.wxPanel()
    local timer = wx.wxTimer(timerPanel)
    
    timerPanel:Connect(wx.wxEVT_TIMER, function()
        local inCycle, rc = mc.mcCntlIsInCycle(inst)
        
        if inCycle then
            -- Update progress if callback provided
            if progress_callback then
                local currentLine, rc3 = mc.mcCntlGetGcodeLineNbr(inst)
                if rc3 == mc.MERROR_NOERROR then
                    local progress = (currentLine / totalLines) * 100
                    progress_callback(currentLine, totalLines, progress)
                end
            end
        else
            -- Execution complete
            timer:Stop()
            mc.mcCntlCloseGcodeFile(inst)  -- Clean up
            
            if completion_callback then
                completion_callback(true)  -- Success
            end
        end
    end)
    
    timer:Start(1000)  -- Check every 1 second for large programs
    return true
end
```

### Pattern 3: Simple Blocking for Quick Operations

**Best for: Small, quick operations (<5 seconds total)**

```lua
local function executeSimpleGcode(gcode_commands)
    local inst = mc.mcGetInstance()
    local gcode_program = table.concat(gcode_commands, "\n") .. "\n"
    
    -- Only use blocking execution for quick operations
    local rc = mc.mcCntlGcodeExecuteWait(inst, gcode_program)
    if rc ~= 0 then
        local error_msg = mc.mcCntlGetErrorString(inst, rc)
        wx.wxMessageBox("G-code Error: " .. error_msg, "Error", wx.wxOK)
        return false
    end
    
    return true
end
```

## G-code Chunking Strategies

### Optimal Chunk Sizes

**For Motion Quality:**
- **5-20 moves per chunk**: Maintains motion planner buffer depth
- **Complete operations**: Don't break in the middle of pockets, features, etc.
- **Include setup commands**: Each chunk should be self-contained

**For UI Responsiveness:**
- **1-5 second execution time per chunk**: Allows frequent UI updates
- **100ms polling interval**: Balance between responsiveness and overhead
- **Progress feedback**: Update progress bars/status between chunks

### Chunking Implementation

```lua
local function createLogicalChunks(gcode_lines, moves_per_chunk)
    local chunks = {}
    local current_chunk = {}
    local move_count = 0
    
    -- Always start chunks with modal commands
    local setup_commands = {"G90", "G94"}  -- Absolute mode, feed per minute
    
    for _, line in ipairs(gcode_lines) do
        -- Start new chunk if needed
        if move_count == 0 then
            current_chunk = {}
            for _, setup in ipairs(setup_commands) do
                table.insert(current_chunk, setup)
            end
        end
        
        table.insert(current_chunk, line)
        
        -- Count moves (G00, G01, G02, G03)
        if string.match(line, "^G0[0-3]") then
            move_count = move_count + 1
        end
        
        -- Complete chunk when we reach move limit
        if move_count >= moves_per_chunk then
            table.insert(chunks, table.concat(current_chunk, "\n") .. "\n")
            move_count = 0
        end
    end
    
    -- Add final chunk if needed
    if #current_chunk > 0 and move_count > 0 then
        table.insert(chunks, table.concat(current_chunk, "\n") .. "\n")
    end
    
    return chunks
end
```

## Status Monitoring Functions

### Essential Status Checks

```lua
-- Motion completion detection
local function isMotionComplete(inst)
    local inCycle, rc1 = mc.mcCntlIsInCycle(inst)      -- Any G-code running?
    local isStill, rc2 = mc.mcCntlIsStill(inst)        -- All axes stopped?
    
    -- Both must be true for safe continuation
    return (not inCycle) and isStill
end

-- Individual axis status (if needed)
local function areAxesStill(inst, axes)
    for _, axis in ipairs(axes) do
        local still, rc = mc.mcAxisIsStill(inst, axis)
        if not still then
            return false
        end
    end
    return true
end

-- Machine state validation
local function isMachineReady(inst)
    local state, rc = mc.mcCntlGetState(inst)
    return state == mc.MC_STATE_IDLE  -- 3 = MACH_IDLE
end
```

## State Management Best Practices

### Save and Restore Machine State

```lua
local function saveMachineState(inst)
    return {
        feed = mc.mcCntlGetPoundVar(inst, 2134),      -- Current feed rate
        feedMode = mc.mcCntlGetPoundVar(inst, 4001),  -- Feed mode (G93/G94)
        absMode = mc.mcCntlGetPoundVar(inst, 4003),   -- Absolute/incremental
        spindleSpeed = mc.mcCntlGetPoundVar(inst, 2063), -- Spindle RPM
        coolant = mc.mcCntlGetPoundVar(inst, 4007),   -- Coolant state
    }
end

local function restoreMachineState(inst, state)
    mc.mcCntlSetPoundVar(inst, 2134, state.feed)
    mc.mcCntlSetPoundVar(inst, 4001, state.feedMode)
    mc.mcCntlSetPoundVar(inst, 4003, state.absMode)
    mc.mcCntlSetPoundVar(inst, 2063, state.spindleSpeed)
    mc.mcCntlSetPoundVar(inst, 4007, state.coolant)
end

-- Usage in macros
local function safeGcodeExecution(gcode_chunks)
    local inst = mc.mcGetInstance()
    local savedState = saveMachineState(inst)
    
    executeGcodeChunks(gcode_chunks, function()
        -- Completion callback
        restoreMachineState(inst, savedState)
        wx.wxMessageBox("Operation completed successfully!", "Success", wx.wxOK)
    end)
end
```

## Implementation Plan

### Phase 1: Core Infrastructure
1. **Create utility module** (`src/utils/gcode_execution.lua`)
   - Chunked execution functions
   - Status monitoring utilities
   - State management helpers

2. **Update mock API** for testing non-blocking patterns
   - Timer simulation
   - Status state tracking
   - Completion detection testing

### Phase 2: Enhanced M200 Macro
1. **Update M200 macro** to demonstrate non-blocking execution
   - Use timer-based polling instead of blocking wait
   - Add progress feedback
   - Implement proper state management

2. **Add cancellation support**
   - Allow user to abort long-running operations
   - Clean state restoration on cancel

### Phase 3: Production Features
1. **File-based execution support**
   - Large program handling
   - Progress monitoring
   - Memory-efficient processing

2. **Advanced chunking strategies**
   - Intelligent break points
   - Operation-aware chunking
   - Optimization for different move types

### Phase 4: Testing and Documentation
1. **Comprehensive test suite**
   - Non-blocking execution tests
   - Timer simulation tests
   - State management validation

2. **Example implementations**
   - Simple macro examples
   - Production program patterns
   - UI integration examples

## File-Based G-code Execution Details

### Core File Operations

**Loading G-code Files:**
```lua
-- Load a G-code file (supports .tap, .nc, .gcode, and text files)
local inst = mc.mcGetInstance()
local rc = mc.mcCntlLoadGcodeFile(inst, "C:/GCode/program.tap")

-- Check for errors
if rc == mc.MERROR_NOERROR then
    print("File loaded successfully")
elseif rc == mc.MERROR_FILE_INVALID then
    print("Invalid file specified")
elseif rc == mc.MERROR_FILE_EMPTY then
    print("Empty file specified")
elseif rc == mc.MERROR_FILE_BADSIZE then
    print("File too large")
else
    print("File load error: " .. rc)
end
```

**File Information Functions:**
```lua
-- Get file details
local fileName, rc1 = mc.mcCntlGetGcodeFileName(inst)      -- Current file name
local totalLines, rc2 = mc.mcCntlGetGcodeLineCount(inst)   -- Total lines
local currentLine, rc3 = mc.mcCntlGetGcodeLineNbr(inst)    -- Current executing line

-- Get specific line content
local lineContent, rc4 = mc.mcCntlGetGcodeLine(inst, 10)   -- Get line 10
```

**Execution Control:**
```lua
-- Start execution
mc.mcCntlCycleStart(inst)           -- Start from current line

-- Control execution
mc.mcCntlCycleStop(inst)            -- Stop execution immediately
mc.mcCntlFeedHold(inst)             -- Pause (maintain spindle/coolant)

-- Resume from feed hold
mc.mcCntlCycleStart(inst)           -- Resume execution

-- Emergency stop
mc.mcCntlEStop(inst)                -- Emergency stop everything

-- File positioning
mc.mcCntlRewindFile(inst)           -- Go to beginning
mc.mcCntlSetGcodeLineNbr(inst, 100) -- Start from line 100
```

**File Cleanup:**
```lua
-- Always close files when done
mc.mcCntlCloseGcodeFile(inst)
```

### Advanced File Execution Features

**Progress Monitoring:**
```lua
local function monitorFileProgress()
    local inst = mc.mcGetInstance()
    
    -- Create progress monitor timer
    local timerPanel = wx.wxPanel()
    local timer = wx.wxTimer(timerPanel)
    
    timerPanel:Connect(wx.wxEVT_TIMER, function()
        local inCycle, rc1 = mc.mcCntlIsInCycle(inst)
        
        if inCycle then
            -- Get progress information
            local currentLine, rc2 = mc.mcCntlGetGcodeLineNbr(inst)
            local totalLines, rc3 = mc.mcCntlGetGcodeLineCount(inst)
            
            if rc2 == mc.MERROR_NOERROR and rc3 == mc.MERROR_NOERROR then
                local progress = (currentLine / totalLines) * 100
                local timeRemaining = estimateTimeRemaining(currentLine, totalLines)
                
                -- Update progress display
                updateProgressBar(progress)
                updateStatusDisplay(string.format(
                    "Line %d of %d (%.1f%%) - Est. %s remaining",
                    currentLine, totalLines, progress, timeRemaining
                ))
                
                -- Optional: Log current G-code line being executed
                local lineContent, rc4 = mc.mcCntlGetGcodeLine(inst, currentLine)
                if rc4 == mc.MERROR_NOERROR then
                    print("Executing: " .. lineContent)
                end
            end
        else
            -- File execution complete
            timer:Stop()
            updateStatusDisplay("File execution completed")
            mc.mcCntlCloseGcodeFile(inst)
        end
    end)
    
    timer:Start(500)  -- Update every 500ms for responsive progress
end
```

**Feed Hold State Management:**
```lua
local function handleFeedHold()
    local inst = mc.mcGetInstance()
    
    -- Check if currently in feed hold
    local inFeedHold, rc = mc.mcCntlFeedHoldState(inst)
    
    if rc == mc.MERROR_NOERROR then
        if inFeedHold then
            print("System is in feed hold - press Cycle Start to resume")
            -- Could update UI buttons, show resume dialog, etc.
        else
            print("System is running normally")
        end
    end
end
```

**Error Recovery and File Restart:**
```lua
local function restartFromLine(lineNumber)
    local inst = mc.mcGetInstance()
    
    -- Stop current execution
    mc.mcCntlCycleStop(inst)
    
    -- Wait for stop to complete
    while true do
        local inCycle, rc = mc.mcCntlIsInCycle(inst)
        if not inCycle then break end
        -- Small delay to avoid busy waiting
        os.execute("sleep 0.1")
    end
    
    -- Set starting line
    local rc = mc.mcCntlSetGcodeLineNbr(inst, lineNumber)
    if rc == mc.MERROR_NOERROR then
        print("Restarting from line " .. lineNumber)
        mc.mcCntlCycleStart(inst)
    else
        print("Failed to set starting line")
    end
end
```

### Complete File-Based Execution Example

```lua
-- Complete production-ready file execution system
local function executeProductionFile(filePath, options)
    local inst = mc.mcGetInstance()
    options = options or {}
    
    -- Default options
    local progressUpdateInterval = options.progressInterval or 1000  -- 1 second
    local enableProgressLogging = options.enableLogging or false
    local autoCloseOnComplete = options.autoClose or true
    
    -- Step 1: Load file
    print("Loading G-code file: " .. filePath)
    local rc = mc.mcCntlLoadGcodeFile(inst, filePath)
    
    if rc ~= mc.MERROR_NOERROR then
        local errorMsg = getFileErrorMessage(rc)
        wx.wxMessageBox("File Load Error: " .. errorMsg, "Error", wx.wxOK)
        return false
    end
    
    -- Step 2: Get file information
    local fileName, rc1 = mc.mcCntlGetGcodeFileName(inst)
    local totalLines, rc2 = mc.mcCntlGetGcodeLineCount(inst)
    
    if rc1 ~= mc.MERROR_NOERROR or rc2 ~= mc.MERROR_NOERROR then
        wx.wxMessageBox("Failed to read file information", "Error", wx.wxOK)
        mc.mcCntlCloseGcodeFile(inst)
        return false
    end
    
    -- Step 3: Pre-execution validation
    if totalLines == 0 then
        wx.wxMessageBox("File is empty", "Warning", wx.wxOK)
        mc.mcCntlCloseGcodeFile(inst)
        return false
    end
    
    print(string.format("File loaded: %s (%d lines)", fileName, totalLines))
    
    -- Step 4: Start execution
    local startTime = os.time()
    rc = mc.mcCntlCycleStart(inst)
    
    if rc ~= mc.MERROR_NOERROR then
        local error_msg = mc.mcCntlGetErrorString(inst, rc)
        wx.wxMessageBox("Cycle Start Error: " .. error_msg, "Error", wx.wxOK)
        mc.mcCntlCloseGcodeFile(inst)
        return false
    end
    
    -- Step 5: Monitor execution
    local timerPanel = wx.wxPanel()
    local timer = wx.wxTimer(timerPanel)
    local lastProgressUpdate = 0
    
    timerPanel:Connect(wx.wxEVT_TIMER, function()
        local inCycle, rc = mc.mcCntlIsInCycle(inst)
        
        if inCycle then
            -- Get current progress
            local currentLine, rc3 = mc.mcCntlGetGcodeLineNbr(inst)
            
            if rc3 == mc.MERROR_NOERROR then
                local progress = (currentLine / totalLines) * 100
                local elapsedTime = os.time() - startTime
                local estimatedTotal = (elapsedTime / progress) * 100
                local remaining = estimatedTotal - elapsedTime
                
                -- Update progress (avoid spam)
                if currentLine ~= lastProgressUpdate then
                    lastProgressUpdate = currentLine
                    
                    -- Update UI
                    if options.progressCallback then
                        options.progressCallback({
                            currentLine = currentLine,
                            totalLines = totalLines,
                            progress = progress,
                            elapsedTime = elapsedTime,
                            estimatedRemaining = remaining
                        })
                    end
                    
                    -- Optional detailed logging
                    if enableProgressLogging then
                        local lineContent, rc4 = mc.mcCntlGetGcodeLine(inst, currentLine)
                        if rc4 == mc.MERROR_NOERROR then
                            print(string.format("[%d/%d] %s", currentLine, totalLines, lineContent))
                        end
                    end
                end
            end
            
            -- Check for emergency conditions
            local state, rcState = mc.mcCntlGetState(inst)
            if state == mc.MC_STATE_ESTOP then
                timer:Stop()
                wx.wxMessageBox("Emergency stop activated", "E-Stop", wx.wxOK)
                return
            end
            
        else
            -- Execution completed
            timer:Stop()
            local endTime = os.time()
            local totalTime = endTime - startTime
            
            print(string.format("File execution completed in %d seconds", totalTime))
            
            -- Cleanup
            if autoCloseOnComplete then
                mc.mcCntlCloseGcodeFile(inst)
            end
            
            -- Success callback
            if options.completionCallback then
                options.completionCallback({
                    success = true,
                    totalTime = totalTime,
                    linesExecuted = totalLines
                })
            end
        end
    end)
    
    timer:Start(progressUpdateInterval)
    return true
end

-- Helper function for error messages
local function getFileErrorMessage(errorCode)
    local errorMessages = {
        [mc.MERROR_INVALID_INSTANCE] = "Invalid machine instance",
        [mc.MERROR_INVALID_ARG] = "Invalid file path",
        [mc.MERROR_INVALID_DIR] = "Invalid directory",
        [mc.MERROR_FILE_EXCEPTION] = "File processing exception",
        [mc.MERROR_FILE_EMPTY] = "File is empty",
        [mc.MERROR_FILE_SHARING] = "File sharing violation - file may be open elsewhere",
        [mc.MERROR_FILE_INVALID] = "Invalid file format",
        [mc.MERROR_FILE_BADSIZE] = "File too large for system memory"
    }
    
    return errorMessages[errorCode] or ("Unknown error code: " .. errorCode)
end

-- Usage example
executeProductionFile("C:/GCode/large_program.tap", {
    progressInterval = 500,  -- Update every 500ms
    enableLogging = false,   -- Don't log every line
    autoClose = true,        -- Auto-close file when done
    
    progressCallback = function(info)
        -- Update your progress bar here
        updateProgressBar(info.progress)
        updateTimeDisplay(info.estimatedRemaining)
    end,
    
    completionCallback = function(result)
        if result.success then
            wx.wxMessageBox("Program completed successfully!", "Complete", wx.wxOK)
        end
    end
})
```

### File Path Requirements and Best Practices

**Supported File Formats:**
- **Primary**: `.tap` and `.nc` files (industry standard)
- **Secondary**: `.gcode`, `.txt`, and other text formats
- **Configuration**: Default extensions can be changed in Mach4 General settings

**File Path Guidelines:**
```lua
-- ✅ GOOD: Absolute paths with forward slashes
local goodPaths = {
    "C:/GCode/program.tap",
    "D:/Projects/part123.nc",
    "/home/user/gcode/test.tap"  -- Linux style
}

-- ✅ ACCEPTABLE: Backslashes (Windows)
local windowsPaths = {
    "C:\\GCode\\program.tap",
    "D:\\Projects\\part123.nc"
}

-- ❌ AVOID: Relative paths (unreliable)
local badPaths = {
    "program.tap",           -- Current directory dependency
    "../gcode/program.tap",  -- Relative navigation
    "~/gcode/program.tap"    -- Home directory shortcut
}
```

**File Validation:**
```lua
local function validateGcodeFile(filePath)
    -- Check if file exists (platform-dependent)
    local file = io.open(filePath, "r")
    if not file then
        return false, "File not found: " .. filePath
    end
    file:close()
    
    -- Check file extension
    local validExtensions = {".tap", ".nc", ".gcode", ".txt"}
    local extension = string.match(filePath, "%.([^%.]+)$")
    
    if extension then
        extension = "." .. string.lower(extension)
        for _, valid in ipairs(validExtensions) do
            if extension == valid then
                return true, "Valid G-code file"
            end
        end
    end
    
    return false, "Invalid file extension. Expected: .tap, .nc, .gcode, or .txt"
end

-- Usage
local isValid, message = validateGcodeFile("C:/GCode/program.tap")
if not isValid then
    wx.wxMessageBox(message, "File Validation Error", wx.wxOK)
    return
end
```

## Quick Reference

### When to Use Each Pattern

| Use Case | Pattern | Execution Method | Monitoring |
|----------|---------|------------------|------------|
| Quick macros (<5 sec) | Simple Blocking | `mcCntlGcodeExecuteWait` | None needed |
| Medium programs (100-1000 lines) | Chunked Execution | `mcCntlGcodeExecute` + chunks | 100ms timer |
| Large programs (>1000 lines) | File-Based | `mcCntlLoadGcodeFile` | 1000ms timer |
| Dynamic generation | Chunked Execution | `mcCntlGcodeExecute` + chunks | 100ms timer |

### Key Functions

```lua
-- String-based execution
mc.mcCntlGcodeExecute(inst, gcode_string)     -- Non-blocking
mc.mcCntlGcodeExecuteWait(inst, gcode_string) -- Blocking (macros only)

-- File-based execution
mc.mcCntlLoadGcodeFile(inst, filepath)        -- Load G-code file
mc.mcCntlCycleStart(inst)                     -- Start/resume execution
mc.mcCntlCycleStop(inst)                      -- Stop execution
mc.mcCntlFeedHold(inst)                       -- Pause (spindle continues)
mc.mcCntlCloseGcodeFile(inst)                 -- Unload file

-- File information
mc.mcCntlGetGcodeFileName(inst)               -- Current file name
mc.mcCntlGetGcodeLineCount(inst)              -- Total lines in file
mc.mcCntlGetGcodeLineNbr(inst)                -- Current executing line
mc.mcCntlGetGcodeLine(inst, lineNumber)       -- Get specific line content

-- File positioning
mc.mcCntlRewindFile(inst)                     -- Go to beginning
mc.mcCntlSetGcodeLineNbr(inst, lineNumber)    -- Set starting line

-- Status monitoring
mc.mcCntlIsInCycle(inst)                      -- G-code running?
mc.mcCntlIsStill(inst)                        -- All axes stopped?
mc.mcAxisIsStill(inst, axis)                  -- Specific axis stopped?
mc.mcCntlGetState(inst)                       -- Machine state
mc.mcCntlFeedHoldState(inst)                  -- In feed hold?

-- Emergency controls
mc.mcCntlEStop(inst)                          -- Emergency stop

-- Timer creation (for non-blocking monitoring)
local timer = wx.wxTimer(wx.wxPanel())
timer:Connect(wx.wxEVT_TIMER, callback_function)
timer:Start(interval_ms)
timer:Stop()

-- Error handling
mc.mcCntlGetErrorString(inst, error_code)     -- Get error description
```

## Common Pitfalls to Avoid

1. **Don't use `mcCntlGcodeExecuteWait` for production programs**
2. **Always check both `IsInCycle` AND `IsStill` for completion**
3. **Don't submit chunks too rapidly** - respect motion planner timing
4. **Always save/restore machine state** in macros
5. **Provide user feedback** for operations longer than 2-3 seconds
6. **Implement cancellation** for long-running operations
7. **Test with realistic G-code sizes** - not just tiny examples

Following these patterns ensures smooth motion quality while maintaining responsive user interfaces in Mach4 plugin development.