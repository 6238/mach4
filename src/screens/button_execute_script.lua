-- button_execute_script.lua
-- Left Up Script for the "Execute Square Move" button
-- This script goes in the button's Left Up Script event

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