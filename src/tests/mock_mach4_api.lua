-- mock_mach4_api.lua
-- Mock implementation of Mach4 API for offline testing
-- Simulates core Mach4 functions without requiring actual hardware

local MockMach4 = {}

-- Mock state to simulate machine state
local mock_state = {
    instance = 0,
    registers = {},
    position = {x = 0.0, y = 0.0, z = 0.0},
    machine_enabled = false,
    spindle_running = false,
    gcode_executing = false,
    gcode_history = {},
    last_error = nil,
    work_offsets = {
        x = 0.0,
        y = 0.0,
        z = 0.0
    }
}

-- Mock constants (matching Mach4 constants)
local MC_ON = 1
local MC_OFF = 0

-- Mock mc (Mach Core) API
local mc = {}

-- Error constants
mc.MERROR_NOERROR = 0
mc.MERROR_AXIS_NOT_HOMED = -17
mc.MERROR_AXIS_NOT_ENABLED = -18

-- Instance management
function mc.mcGetInstance()
    return mock_state.instance
end

-- Register operations
function mc.mcRegGetHandle(inst, reg_path)
    -- Create register if it doesn't exist
    if not mock_state.registers[reg_path] then
        mock_state.registers[reg_path] = {
            value = 0.0,
            handle = #mock_state.registers + 1
        }
    end
    return mock_state.registers[reg_path].handle, 0  -- handle, error_code
end

function mc.mcRegGetValue(handle)
    -- Find register by handle
    for path, reg in pairs(mock_state.registers) do
        if reg.handle == handle then
            return reg.value, 0  -- value, error_code
        end
    end
    return 0.0, -1  -- not found
end

function mc.mcRegSetValue(handle, value)
    -- Find register by handle and set value
    for path, reg in pairs(mock_state.registers) do
        if reg.handle == handle then
            reg.value = value
            return 0  -- success
        end
    end
    return -1  -- not found
end

function mc.mcRegGetValueString(handle)
    local value, rc = mc.mcRegGetValue(handle)
    return tostring(value), rc
end

function mc.mcRegSetValueString(handle, value)
    return mc.mcRegSetValue(handle, tonumber(value) or 0)
end

-- Position operations
function mc.mcAxisGetPos(inst, axis)
    local axes = {'x', 'y', 'z'}
    local axis_name = axes[axis + 1]  -- Lua is 1-indexed, Mach4 is 0-indexed
    if axis_name and mock_state.position[axis_name] then
        return mock_state.position[axis_name], 0
    end
    return 0.0, -1
end

function mc.mcAxisSetPos(inst, axis, position)
    local axes = {'x', 'y', 'z'}
    local axis_name = axes[axis + 1]
    if axis_name then
        mock_state.position[axis_name] = position
        return 0
    end
    return -1
end

-- Work offset operations
function mc.mcCntlGetPoundVar(inst, var_num)
    -- Common G-code pound variables
    if var_num >= 5221 and var_num <= 5223 then  -- G54 X, Y, Z offsets
        local offset_names = {'x', 'y', 'z'}
        local offset_name = offset_names[var_num - 5220]
        return mock_state.work_offsets[offset_name] or 0.0, 0
    end
    return 0.0, 0
end

function mc.mcCntlSetPoundVar(inst, var_num, value)
    if var_num >= 5221 and var_num <= 5223 then
        local offset_names = {'x', 'y', 'z'}
        local offset_name = offset_names[var_num - 5220]
        mock_state.work_offsets[offset_name] = value
        return 0
    end
    return 0
end

-- G-code execution
function mc.mcCntlGcodeExecute(inst, gcode)
    -- Check for mock execution error
    if mock_state.gcode_execution_error and mock_state.gcode_execution_error ~= mc.MERROR_NOERROR then
        return mock_state.gcode_execution_error
    end
    
    -- Simulate G-code execution (individual commands or concatenated strings)
    table.insert(mock_state.gcode_history, {
        gcode = gcode,
        timestamp = os.time(),
        method = "individual",
        line_count = select(2, string.gsub(gcode, '\n', '\n')) + 1
    })
    
    -- Parse all G-code commands in the string for position simulation
    for line in gcode:gmatch("[^\r\n]+") do
        local x_match = string.match(line, "X([%-+]?[%d%.]+)")
        local y_match = string.match(line, "Y([%-+]?[%d%.]+)")
        local z_match = string.match(line, "Z([%-+]?[%d%.]+)")
        
        if x_match then mock_state.position.x = tonumber(x_match) end
        if y_match then mock_state.position.y = tonumber(y_match) end
        if z_match then mock_state.position.z = tonumber(z_match) end
    end
    
    -- For testing purposes, simulate very quick execution completion
    -- Real macro would poll and wait for completion
    mock_state.gcode_executing = false
    return mc.MERROR_NOERROR or 0
end

-- File-based G-code execution
function mc.mcCntlLoadGcodeFile(inst, filepath)
    -- Simulate loading a G-code file
    table.insert(mock_state.gcode_history, {
        gcode = "FILE_LOAD: " .. filepath,
        timestamp = os.time(),
        method = "file_load",
        filepath = filepath
    })
    
    print("MOCK: Loaded G-code file: " .. filepath)
    return 0  -- Success
end

function mc.mcCntlCycleStart(inst)
    -- Simulate starting the loaded program
    mock_state.gcode_executing = true
    print("MOCK: Started G-code execution")
    
    -- For testing, immediately complete the cycle
    mock_state.gcode_executing = false
    return 0
end

function mc.mcCntlCloseGcodeFile(inst)
    -- Simulate closing the G-code file
    print("MOCK: Closed G-code file")
    return 0
end

function mc.mcCntlGcodeExecuteWait(inst, gcode_program)
    -- Check for mock execution error
    if mock_state.gcode_execution_error and mock_state.gcode_execution_error ~= mc.MERROR_NOERROR then
        return mock_state.gcode_execution_error
    end
    
    -- Simulate bulk G-code program execution (but track as "individual" for consolidated strings)
    table.insert(mock_state.gcode_history, {
        gcode = gcode_program,
        timestamp = os.time(),
        method = "individual",  -- Use "individual" for concatenated G-code strings
        line_count = select(2, string.gsub(gcode_program, '\n', '\n')) + 1
    })
    
    -- Parse all G-code commands in the program for position simulation
    for line in gcode_program:gmatch("[^\r\n]+") do
        local x_match = string.match(line, "X([%-+]?[%d%.]+)")
        local y_match = string.match(line, "Y([%-+]?[%d%.]+)")
        local z_match = string.match(line, "Z([%-+]?[%d%.]+)")
        
        if x_match then mock_state.position.x = tonumber(x_match) end
        if y_match then mock_state.position.y = tonumber(y_match) end
        if z_match then mock_state.position.z = tonumber(z_match) end
    end
    
    mock_state.gcode_executing = false  -- Program completed
    return mc.MERROR_NOERROR or 0
end

-- Machine state
function mc.mcCntlGetState(inst)
    return mock_state.machine_enabled and 200 or 0, 0  -- 200 = Avid Benchtop Pro ready state, 0 = MACH_OFFLINE
end

function mc.mcCntlEnable(inst, enable)
    mock_state.machine_enabled = (enable == MC_ON)
    return 0
end

-- Axis homing (for aluminum cutting macro validation)
function mc.mcAxisIsHomed(inst, axis)
    -- Check if axis homing state is mocked
    if mock_state.axes_homed and mock_state.axes_homed[axis] ~= nil then
        return mock_state.axes_homed[axis], 0
    end
    -- Mock assumes all axes are homed when machine is enabled
    return mock_state.machine_enabled, 0
end

-- Feed hold state (for aluminum cutting macro validation)
function mc.mcCntlFeedHoldState(inst)
    return false, 0  -- Not in feed hold
end

-- Completion monitoring (for aluminum cutting macro execution)
function mc.mcCntlIsInCycle(inst)
    return mock_state.gcode_executing, 0
end

function mc.mcCntlIsStill(inst)
    return not mock_state.gcode_executing, 0
end

-- Individual axis still check
function mc.mcAxisIsStill(inst, axis)
    return not mock_state.gcode_executing, 0
end

-- Spindle control
function mc.mcSpindleSetDirection(inst, direction)
    mock_state.spindle_running = (direction ~= 0)
    return 0
end

-- Error handling
function mc.mcCntlGetErrorString(inst, error_code)
    local error_messages = {
        [0] = "Success",
        [-1] = "General error",
        [-2] = "Invalid parameter",
        [-3] = "Not implemented",
        [-17] = "Axis not homed",
        [-18] = "Axis not enabled"
    }
    return error_messages[error_code] or "Unknown error", 0
end

-- Editor detection
function mc.mcInEditor()
    return 0  -- Return 0 (false) when running in test mode
end

-- Screen/UI related functions
local scr = {}

function scr.GetProperty(control_name, property)
    -- Mock screen control properties
    return "", 0
end

function scr.SetProperty(control_name, property, value)
    -- Mock setting screen control properties
    return 0
end

-- Export mock APIs globally (same way real Mach4 does)
_G.mc = mc
_G.scr = scr

-- Mock wx (wxWidgets) for message boxes
local wx = {}

-- wx constants for dialog responses
wx.wxYES = 5
wx.wxNO = 6
wx.wxOK = 4
wx.wxCANCEL = 16
wx.wxYES_NO = 12
wx.wxOK_CANCEL = 36
wx.wxICON_QUESTION = 256
wx.wxICON_WARNING = 512
wx.wxICON_INFORMATION = 128

function wx.wxMessageBox(message, caption, style)
    print("MOCK MESSAGE BOX: " .. (caption or "Message"))
    print("  " .. message)
    
    -- Use mocked response if available
    local response = _G.MockMach4 and _G.MockMach4.get_next_dialog_response() or nil
    
    if response then
        print("  [MOCK RESPONSE: " .. response .. "]")
        return response
    end
    
    -- For testing, automatically approve cutting operations
    if caption and (string.find(caption, "Aluminum Cutting Operation") or string.find(caption, "Box Tube End Squaring Operation") or string.find(caption, "Operation Complete")) then
        print("  [MOCK AUTO-APPROVING cutting operation]")
        return wx.wxYES
    end
    
    -- Default to OK/YES for other dialogs
    return style and (style & wx.wxYES_NO == wx.wxYES_NO) and wx.wxYES or wx.wxOK
end

-- Mock wxSafeYield for progress monitoring
function wx.wxSafeYield()
    -- No-op for testing
end

-- Mock wxMilliSleep for waiting in loops
function wx.wxMilliSleep(ms)
    -- For testing, just print that we're waiting
    -- In real usage, this would pause execution
    -- print("MOCK: Sleeping " .. ms .. "ms")
end

-- Mock wxPanel for timer creation
function wx.wxPanel()
    local panel = {}
    
    -- Mock Connect method for event handling
    function panel:Connect(event_type, callback)
        -- For testing, we don't actually connect events
        -- In real usage, this would connect the timer event to the callback
    end
    
    return panel
end

-- Mock wxTimer for non-blocking execution
function wx.wxTimer(parent)
    local timer = {}
    local running = false
    
    function timer:Start(interval)
        running = true
        -- For testing, immediately simulate completion
        -- In real usage, this would start a timer that fires at intervals
    end
    
    function timer:Stop()
        running = false
    end
    
    function timer:IsRunning()
        return running
    end
    
    return timer
end

-- Mock timer event type
wx.wxEVT_TIMER = 10001

-- Mock wxStandardPaths for temp file creation
local wxStandardPaths = {}
function wxStandardPaths.Get()
    local std = {}
    function std:GetTempDir()
        -- Return a mock temp directory
        return "/tmp"
    end
    return std
end
wx.wxStandardPaths = wxStandardPaths

-- Mock wxFileName for temp file creation
local wxFileName = {}
function wxFileName.CreateTempFileName(prefix)
    -- Create a mock temp file path
    local timestamp = os.time()
    local random = math.random(1000, 9999)
    return string.format("/tmp/%s%d_%d.tmp", prefix or "test_", timestamp, random)
end
wx.wxFileName = wxFileName

-- Mock file removal function
function wx.wxRemoveFile(filepath)
    print("MOCK: Removing file: " .. filepath)
    return true
end

_G.wx = wx

-- Mock constants
_G.MC_ON = MC_ON
_G.MC_OFF = MC_OFF

-- Utility functions for testing
MockMach4.reset_state = function()
    mock_state = {
        instance = 0,
        registers = {},
        position = {x = 0.0, y = 0.0, z = 0.0},
        machine_enabled = false,
        spindle_running = false,
        gcode_executing = false,
        gcode_history = {},
        last_error = nil,
        work_offsets = {
            x = 0.0,
            y = 0.0,
            z = 0.0
        },
        axes_homed = {},
        gcode_execution_error = nil
    }
    MockMach4.clear_dialog_responses()
end

MockMach4.get_state = function()
    return mock_state
end

MockMach4.get_gcode_history = function()
    return mock_state.gcode_history
end

MockMach4.clear_gcode_history = function()
    mock_state.gcode_history = {}
end

-- Dialog response mocking for testing user interactions
local mock_dialog_responses = {}
local dialog_response_index = 1

function MockMach4.mock_dialog_response(response)
    table.insert(mock_dialog_responses, response)
end

function MockMach4.get_next_dialog_response()
    if dialog_response_index <= #mock_dialog_responses then
        local response = mock_dialog_responses[dialog_response_index]
        dialog_response_index = dialog_response_index + 1
        return response
    end
    -- Default response if no more mocked responses
    return wx.wxOK
end

function MockMach4.clear_dialog_responses()
    mock_dialog_responses = {}
    dialog_response_index = 1
end

function MockMach4.set_axis_homed(axis, homed)
    mock_state.axes_homed = mock_state.axes_homed or {}
    mock_state.axes_homed[axis] = homed
end

function MockMach4.set_gcode_execution_error(error_code)
    mock_state.gcode_execution_error = error_code
end

-- Check if we're running in mock mode
function MockMach4.is_mock_mode()
    return true
end

-- Initialize mock mode
function MockMach4.init()
    print("Mock Mach4 API initialized - Running in offline test mode")
end

return MockMach4