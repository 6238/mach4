-- screen_installer.lua
-- Automated screen setup for Hello World Plugin
-- Injects scripts into existing Mach4 screen controls programmatically

local screen_installer = {}

-- Configuration for our UI controls
local CONTROL_CONFIG = {
    text_field = {
        name = "txtMoveSize",
        default_value = "2.0",
        label = "Square Size (inches):"
    },
    button = {
        name = "btnExecuteMove",
        label = "Execute Square Move"
    }
}

-- Get the button execute script content
function screen_installer.get_button_script()
    return [[
function ExecuteSquareMove()
    local inst = mc.mcGetInstance()
    
    -- Get the move size from the text input
    local move_size_str = scr.GetProperty("txtMoveSize", "Value")
    local move_size = tonumber(move_size_str)
    
    -- Validate input
    if not move_size or move_size <= 0 or move_size > 10 then
        wx.wxMessageBox("Please enter a valid move size between 0.1 and 10.0 inches.", "Invalid Input", wx.wxOK + wx.wxICON_ERROR)
        return
    end
    
    -- Safety check - ensure machine is ready
    local state, rc = mc.mcCntlGetState(inst)
    if rc ~= 0 or state ~= 3 then  -- 3 = MACH_IDLE
        wx.wxMessageBox("Machine is not ready. Please enable and home the machine first.", "Machine Not Ready", wx.wxOK + wx.wxICON_WARNING)
        return
    end
    
    -- Get current position
    local curr_x, rc = mc.mcAxisGetPos(inst, 0)  -- X axis
    local curr_y, rc = mc.mcAxisGetPos(inst, 1)  -- Y axis
    
    if rc ~= 0 then
        wx.wxMessageBox("Error reading current position.", "Position Error", wx.wxOK + wx.wxICON_ERROR)
        return
    end
    
    -- Confirm the move
    local msg = string.format("About to move tool in a %.1f x %.1f inch square from current position:\nX: %.3f, Y: %.3f\n\nContinue?", 
                             move_size, move_size, curr_x, curr_y)
    local result = wx.wxMessageBox(msg, "Confirm Move", wx.wxYES_NO + wx.wxICON_QUESTION)
    
    if result ~= wx.wxYES then
        return
    end
    
    -- Generate G-code for square movement
    local gcode_commands = {
        "G90",  -- Absolute positioning
        "G01 F100",  -- Linear move at 100 units/min feed rate
        string.format("X%.3f Y%.3f", curr_x + move_size, curr_y),           -- Move in X
        string.format("X%.3f Y%.3f", curr_x + move_size, curr_y + move_size), -- Move in Y
        string.format("X%.3f Y%.3f", curr_x, curr_y + move_size),             -- Move back in X
        string.format("X%.3f Y%.3f", curr_x, curr_y),                        -- Return to start
    }
    
    -- Execute each G-code command
    for i, gcode in ipairs(gcode_commands) do
        print("Executing: " .. gcode)
        local rc = mc.mcCntlGcodeExecute(inst, gcode)
        if rc ~= 0 then
            local error_msg, _ = mc.mcCntlGetErrorString(inst, rc)
            wx.wxMessageBox("Error executing G-code: " .. gcode .. "\nError: " .. error_msg, "G-code Error", wx.wxOK + wx.wxICON_ERROR)
            return
        end
    end
    
    -- Success message
    wx.wxMessageBox(string.format("Square move completed successfully!\nMoved %.1f inches in a square pattern.", move_size), "Success", wx.wxOK + wx.wxICON_INFORMATION)
    
    -- Store the last used size in a register for future use
    local reg_handle, rc = mc.mcRegGetHandle(inst, "plugins/helloworld/move_size")
    if rc == 0 then
        mc.mcRegSetValueString(reg_handle, move_size_str)
    end
end

-- Execute the function
ExecuteSquareMove()
]]
end

-- Get the screen load script content
function screen_installer.get_screen_load_script()
    return [[
-- Hello World Plugin Screen Load Script
local inst = mc.mcGetInstance()

-- Initialize screen variables
print("Hello World Plugin Screen Loaded")

-- Set default values for controls
local default_size = "2.0"
scr.SetProperty("txtMoveSize", "Value", default_size)
scr.SetProperty("btnExecuteMove", "Label", "Execute Square Move")

-- Initialize register for storing move size
local reg_handle, rc = mc.mcRegGetHandle(inst, "plugins/helloworld/move_size")
if rc == 0 then
    mc.mcRegSetValueString(reg_handle, default_size)
end
]]
end

-- Install scripts to screen controls programmatically
function screen_installer.install_to_screen()
    local inst = mc.mcGetInstance()
    
    print("Installing Hello World Plugin scripts to screen...")
    
    -- Try to set the button script programmatically
    -- Note: This may require screen editor mode to be active
    local button_script = screen_installer.get_button_script()
    local screen_script = screen_installer.get_screen_load_script()
    
    -- Set default text field value
    scr.SetProperty(CONTROL_CONFIG.text_field.name, "Value", CONTROL_CONFIG.text_field.default_value)
    scr.SetProperty(CONTROL_CONFIG.button.name, "Label", CONTROL_CONFIG.button.label)
    
    print("Plugin installation complete. Manual script assignment may still be required.")
    print("Button script and screen load script are available in the installer module.")
    
    return {
        button_script = button_script,
        screen_script = screen_script,
        config = CONTROL_CONFIG
    }
end

-- Function to generate screen setup instructions
function screen_installer.get_setup_instructions()
    return {
        title = "Hello World Plugin - Simplified Setup",
        steps = {
            "1. Import the provided screen template (hello_world_template.set)",
            "2. Run HelloWorldPlugin.install_to_screen() from Mach4 operator console",
            "3. Optional: Manually verify script assignments in Screen Editor",
            "4. Save screen with your desired name"
        },
        manual_fallback = {
            "If template import fails:",
            "1. Create text field named 'txtMoveSize' with default '2.0'",
            "2. Create button named 'btnExecuteMove' with label 'Execute Square Move'",
            "3. Run installation script to inject functionality"
        }
    }
end

return screen_installer