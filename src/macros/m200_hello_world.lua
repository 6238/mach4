-- m200_hello_world.lua
-- Simple "Hello World" macro for Mach4 plugin development
-- Demonstrates basic G-code generation and execution

function m200()
    local inst = mc.mcGetInstance()
    
    -- Simple safety check
    local state, rc = mc.mcCntlGetState(inst)
    if rc ~= 0 or state ~= 3 then  -- 3 = MACH_IDLE
        wx.wxMessageBox("Machine is not ready. Please enable and home the machine first.", "Error", wx.wxOK)
        return
    end
    
    -- Display a hello world message
    wx.wxMessageBox("Hello World! About to move tool 2 inches in X and Y.", "Mach4 Plugin Test", wx.wxOK)
    
    -- Get current position
    local curr_x, rc = mc.mcAxisGetPos(inst, 0)  -- X axis
    local curr_y, rc = mc.mcAxisGetPos(inst, 1)  -- Y axis
    
    -- Generate simple G-code for a 2x2 inch square movement
    local gcode_commands = {
        "G90",  -- Absolute positioning
        "G01 F100",  -- Linear move at 100 units/min feed rate
        string.format("X%.3f Y%.3f", curr_x + 2.0, curr_y),      -- Move 2" in X
        string.format("X%.3f Y%.3f", curr_x + 2.0, curr_y + 2.0), -- Move 2" in Y
        string.format("X%.3f Y%.3f", curr_x, curr_y + 2.0),       -- Move back in X
        string.format("X%.3f Y%.3f", curr_x, curr_y),             -- Return to start
    }
    
    -- Concatenate all G-code commands into a single string
    local gcode_program = table.concat(gcode_commands, "\n") .. "\n"
    
    print("Executing G-code program:")
    print(gcode_program)
    
    -- Execute the entire G-code program and wait for completion
    local rc = mc.mcCntlGcodeExecuteWait(inst, gcode_program)
    if rc ~= 0 then
        local error_msg, _ = mc.mcCntlGetErrorString(inst, rc)
        wx.wxMessageBox("Error executing G-code program:\n" .. error_msg, "G-code Error", wx.wxOK)
        return
    end
    
    wx.wxMessageBox("Hello World test completed! Tool moved in a 2x2 inch square.", "Success", wx.wxOK)
end

-- Allow running from editor
if (mc.mcInEditor() == 1) then
    m200()
end