-- m200_aluminum_cutting.lua
-- Multi-pass aluminum box tubing end cutting macro for Mach4
-- Cuts 1" x 1" aluminum box tubing using variable feed rates for optimal performance

function m200()
    local inst = mc.mcGetInstance()
    
    -- Safety check - only accept state 200 (this machine's ready state)
    local state, rc = mc.mcCntlGetState(inst)
    if rc ~= 0 or state ~= 200 then
        wx.wxMessageBox(string.format("Machine is not ready (state = %d). Please enable and home the machine first.", state), "Error", wx.wxOK)
        return
    end
    
    -- Display operation confirmation
    local result = wx.wxMessageBox(
        "About to cut aluminum box tubing end:\n" ..
        "• Material: 1\" x 1\" aluminum box tubing\n" ..
        "• Work coordinate: G56\n" ..
        "• Cut area: Y = -1/8\" to +1/8\"\n" ..
        "• Cut depth: Z = 1\" to 3/8\"\n" ..
        "• 3 passes with variable feed rates\n\n" ..
        "Ensure material is properly secured and\n" ..
        "spindle is running at appropriate speed.\n\n" ..
        "Continue with cutting operation?",
        "Aluminum Cutting Operation", 
        wx.wxYES_NO | wx.wxICON_QUESTION
    )
    
    if result ~= wx.wxYES then
        wx.wxMessageBox("Operation cancelled by user.", "Cancelled", wx.wxOK)
        return
    end
    
    -- Comprehensive safety validation
    if not validateG56Setup(inst) then
        return
    end
    
    if not validateMachineReadiness(inst) then
        return
    end
    
    -- Execute aluminum cutting operation
    executeAluminumCutting(inst)
end

function executeAluminumCutting(inst)
    -- Material and tool parameters
    local TOOL_DIAMETER = 0.157  -- 4mm in inches
    local TOOL_RADIUS = TOOL_DIAMETER / 2
    local SAFETY_CLEARANCE = 0.020
    local STEPOVER = 0.047  -- 30% of tool diameter
    
    -- Material boundaries (G56 coordinates)
    local MATERIAL_X_MIN = 0.0
    local MATERIAL_X_MAX = 1.0
    local MATERIAL_Z_TOP = 1.0
    local CUTTING_DEPTH = 0.375
    local SAFE_HEIGHT = 1.25
    
    -- Calculate precise cutting boundaries
    local X_START = MATERIAL_X_MAX + TOOL_RADIUS + SAFETY_CLEARANCE  -- 1.0985"
    local X_END = MATERIAL_X_MIN - TOOL_RADIUS - SAFETY_CLEARANCE    -- -0.0985"
    
    -- Y positions for 3 passes (cutting Y = -1/8" to +1/8")
    local Y_CUT_START = -0.125
    local Y_CUT_END = 0.125
    local Y_PASS_1 = Y_CUT_START + TOOL_RADIUS  -- -0.0465"
    local Y_PASS_2 = 0.0005                     -- Center pass
    local Y_PASS_3 = Y_CUT_END - TOOL_RADIUS    -- +0.0465"
    
    local y_positions = {Y_PASS_1, Y_PASS_2, Y_PASS_3}
    
    print("Starting aluminum cutting operation:")
    print(string.format("X range: %.4f\" to %.4f\"", X_START, X_END))
    print(string.format("Y passes: %.4f\", %.4f\", %.4f\"", Y_PASS_1, Y_PASS_2, Y_PASS_3))
    print(string.format("Z cutting depth: %.3f\"", CUTTING_DEPTH))
    
    -- Execute cutting passes
    for pass = 1, 3 do
        local y_pos = y_positions[pass]
        print(string.format("Executing pass %d of 3 at Y = %.4f\"", pass, y_pos))
        
        local success = executeCuttingPass(inst, pass, y_pos, X_START, X_END, CUTTING_DEPTH, SAFE_HEIGHT)
        if not success then
            wx.wxMessageBox(string.format("Error during pass %d. Operation stopped.", pass), "Cutting Error", wx.wxOK)
            return
        end
    end
    
    -- Final cleanup - return to origin
    local cleanup_commands = {
        string.format("G00 Z%.3f", SAFE_HEIGHT),  -- Return to safe height
        "G00 X0 Y0"  -- Return to origin
    }
    local cleanup_program = table.concat(cleanup_commands, "\n") .. "\n"
    mc.mcCntlGcodeExecuteWait(inst, cleanup_program)
    
    wx.wxMessageBox("Aluminum cutting operation completed successfully!\n3 passes executed.", "Success", wx.wxOK)
end

function executeCuttingPass(inst, pass_number, y_pos, x_start, x_end, cutting_depth, safe_height)
    -- Feed rates for different cutting conditions
    local PLUNGE_FEED = 100.0    -- Fast plunge rate (in air outside material)
    local HEAVY_FEED = 20.0      -- Feed rate through walls (full engagement)
    local FAST_FEED = 50.0       -- Feed rate through hollow center (light engagement)
    
    -- Box tubing wall boundaries (assuming 1/8" wall thickness)
    local WALL_THICKNESS = 0.125
    local FIRST_WALL_END = 1.0 - WALL_THICKNESS  -- 0.875"
    local SECOND_WALL_START = WALL_THICKNESS     -- 0.125"
    
    -- Generate G-code for this pass with variable feed rates
    local gcode_commands = {
        "G56",  -- Work coordinate system
        "G90",  -- Absolute positioning
        "G94",  -- Feed per minute mode
        
        -- Rapid to start position outside material
        string.format("G00 X%.4f Y%.4f Z%.3f", x_start, y_pos, safe_height),
        
        -- Plunge to cutting depth outside material (fast - in air)
        string.format("G01 Z%.3f F%.1f", cutting_depth, PLUNGE_FEED),
        
        -- Zone 1: Heavy cutting through first wall (full engagement)
        string.format("G01 X%.4f F%.1f", FIRST_WALL_END, HEAVY_FEED),
        
        -- Zone 2: Fast cutting through hollow center (light engagement)
        string.format("G01 X%.4f F%.1f", SECOND_WALL_START, FAST_FEED),
        
        -- Zone 3: Heavy cutting through second wall (full engagement)
        string.format("G01 X%.4f F%.1f", x_end, HEAVY_FEED),
        
        -- Retract to safe height
        string.format("G00 Z%.3f", safe_height)
    }
    
    -- Create complete G-code program for this pass
    local gcode_program = table.concat(gcode_commands, "\n") .. "\n"
    
    print(string.format("Pass %d G-code:", pass_number))
    print(gcode_program)
    
    -- Execute the cutting pass using non-blocking execution for better UI responsiveness
    return executeGcodeWithProgress(inst, gcode_program, pass_number)
end

function executeGcodeWithProgress(inst, gcode_program, pass_number)
    -- Execute G-code using non-blocking method for better UI responsiveness
    local rc = mc.mcCntlGcodeExecute(inst, gcode_program)
    if rc ~= 0 then
        local error_msg, _ = mc.mcCntlGetErrorString(inst, rc)
        wx.wxMessageBox(string.format("Error executing pass %d:\n%s", pass_number, error_msg), "G-code Error", wx.wxOK)
        return false
    end
    
    -- Wait for completion with progress monitoring
    local start_time = os.time()
    local timeout = 300  -- 5 minute timeout
    
    while true do
        local inCycle, rc1 = mc.mcCntlIsInCycle(inst)
        local isStill, rc2 = mc.mcCntlIsStill(inst)
        
        -- Check for completion (both conditions must be true)
        if not inCycle and isStill then
            print(string.format("Pass %d completed successfully", pass_number))
            return true
        end
        
        -- Check for timeout
        if os.time() - start_time > timeout then
            wx.wxMessageBox(string.format("Timeout waiting for pass %d to complete", pass_number), "Timeout Error", wx.wxOK)
            return false
        end
        
        -- Check for emergency stop
        local state, rc3 = mc.mcCntlGetState(inst)
        if state == mc.MC_STATE_ESTOP then
            wx.wxMessageBox("Emergency stop activated during cutting", "E-Stop", wx.wxOK)
            return false
        end
        
        -- Small delay to prevent busy waiting
        mc.mcCntlSetLastError(inst, "Pass " .. pass_number .. " in progress...")
        
        -- Allow other processes to run
        wx.wxSafeYield()
        
        -- Brief pause
        local pause_start = os.clock()
        while os.clock() - pause_start < 0.1 do end
    end
end

-- Validation function for G56 work coordinate system
function validateG56Setup(inst)
    -- Check if G56 work coordinate is properly set
    local g56_x, rc1 = mc.mcCntlGetPoundVar(inst, 5241)  -- G56 X offset
    local g56_y, rc2 = mc.mcCntlGetPoundVar(inst, 5242)  -- G56 Y offset
    local g56_z, rc3 = mc.mcCntlGetPoundVar(inst, 5243)  -- G56 Z offset
    
    if rc1 ~= 0 or rc2 ~= 0 or rc3 ~= 0 then
        wx.wxMessageBox("Unable to read G56 work coordinate offsets.\nPlease verify G56 is properly set.", "G56 Error", wx.wxOK)
        return false
    end
    
    print(string.format("G56 Work Coordinates: X=%.4f, Y=%.4f, Z=%.4f", g56_x, g56_y, g56_z))
    
    -- Warn if all offsets are zero (may indicate G56 not set)
    if g56_x == 0 and g56_y == 0 and g56_z == 0 then
        local result = wx.wxMessageBox(
            "G56 work coordinate offsets are all zero.\n" ..
            "This may indicate G56 has not been properly set.\n\n" ..
            "Continue anyway?",
            "G56 Warning",
            wx.wxYES_NO | wx.wxICON_WARNING
        )
        if result ~= wx.wxYES then
            return false
        end
    end
    
    return true
end


-- Enhanced machine readiness validation
function validateMachineReadiness(inst)
    -- Check machine state
    local state, rc = mc.mcCntlGetState(inst)
    if rc ~= 0 then
        wx.wxMessageBox("Unable to determine machine state.", "Machine State Error", wx.wxOK)
        return false
    end
    
    -- Verify machine is in proper state (200 = ready for this machine)
    if state ~= 200 then
        wx.wxMessageBox(string.format("Machine is not ready (state = %d).\nPlease enable and home the machine first.", state), "Machine Not Ready", wx.wxOK)
        return false
    end
    
    -- Check if axes are homed
    local x_homed, rc1 = mc.mcAxisIsHomed(inst, 0)  -- X axis
    local y_homed, rc2 = mc.mcAxisIsHomed(inst, 1)  -- Y axis
    local z_homed, rc3 = mc.mcAxisIsHomed(inst, 2)  -- Z axis
    
    if not (x_homed and y_homed and z_homed) then
        wx.wxMessageBox("Not all axes are homed.\nPlease home all axes before cutting.", "Homing Required", wx.wxOK)
        return false
    end
    
    -- Check feed hold state
    local in_feed_hold, rc5 = mc.mcCntlFeedHoldState(inst)
    if rc5 == 0 and in_feed_hold then
        wx.wxMessageBox("Machine is in feed hold state.\nPlease clear feed hold before starting.", "Feed Hold Active", wx.wxOK)
        return false
    end
    
    print("Machine readiness validation passed")
    return true
end

-- Allow running from editor
if (mc.mcInEditor() == 1) then
    m200()
end