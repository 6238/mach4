-- test_m200_upper_lower_half.lua
-- Tests for upper/lower half box tube end squaring functionality in M200 macro

local MockMach4 = require("mock_mach4_api")
_G.MockMach4 = MockMach4  -- Make it globally available for wx.wxMessageBox

describe("M200 Upper/Lower Half Operation Tests", function()
    before_each(function()
        MockMach4.reset_state()
        -- Enable machine for testing
        local inst = mc.mcGetInstance()
        mc.mcCntlEnable(inst, 1)
        
        -- Set up G55 work coordinates (non-zero to avoid warning)
        mc.mcCntlSetPoundVar(inst, 5221, 10.0)  -- G55 X offset
        mc.mcCntlSetPoundVar(inst, 5222, 20.0)  -- G55 Y offset
        mc.mcCntlSetPoundVar(inst, 5223, 5.0)   -- G55 Z offset
        
        -- Mock all axes as homed
        MockMach4.set_axis_homed(0, true)  -- X axis
        MockMach4.set_axis_homed(1, true)  -- Y axis  
        MockMach4.set_axis_homed(2, true)  -- Z axis
    end)
    
    it("should execute complete upper/lower half operation workflow", function()
        local inst = mc.mcGetInstance()
        
        -- Clear any previous G-code history
        MockMach4.clear_gcode_history()
        
        -- Mock user dialogs to always return OK/YES
        MockMach4.mock_dialog_response(wx.wxYES)    -- Initial confirmation
        MockMach4.mock_dialog_response(wx.wxOK)     -- Material positioning
        MockMach4.mock_dialog_response(wx.wxOK)     -- Material flip
        
        -- Load and execute the m200 macro
        dofile("../macros/m200.lua")
        m200()
        
        -- Get the G-code execution history
        local history = MockMach4.get_gcode_history()
        
        -- Test: Should have 4 operations total
        -- 1. Upper half cutting operation (file_load)
        -- 2. Safe positioning move (individual gcode)
        -- 3. Return to origin move (individual gcode)  
        -- 4. Lower half cutting operation (file_load)
        assert_true(#history >= 4, "Expected at least 4 G-code operations for upper/lower half workflow")
        
        -- Test: Should have exactly 2 file load operations (one for each cut)
        local file_calls = 0
        local positioning_calls = 0
        local return_calls = 0
        
        for i, call in ipairs(history) do
            if call.method == "file_load" then
                file_calls = file_calls + 1
                -- Verify temp file naming
                assert_true(call.filepath ~= nil, "Expected temp file path in file load call")
                assert_true(string.find(call.filepath, "BoxTube_", 1, true) ~= nil, "Expected BoxTube_ prefix")
            elseif call.method == "individual" then
                -- Check for safe positioning moves
                if string.find(call.gcode, "G53", 1, true) and string.find(call.gcode, "X0.5 Y23.5", 1, true) then
                    positioning_calls = positioning_calls + 1
                    -- Verify safe positioning sequence
                    assert_true(string.find(call.gcode, "Z%-0%.5") ~= nil, "Expected Z-0.5 in safe move")
                    assert_true(string.find(call.gcode, "F150", 1, true) ~= nil, "Expected F150 feed rate")
                elseif string.find(call.gcode, "G55", 1, true) and string.find(call.gcode, "X0 Y0", 1, true) then
                    return_calls = return_calls + 1
                    -- Verify return to origin sequence
                    assert_true(string.find(call.gcode, "G0 X0 Y0", 1, true) ~= nil, "Expected G0 X0 Y0 return move")
                end
            end
        end
        
        assert_equal(file_calls, 2, "Expected exactly 2 cutting operations (upper and lower halves)")
        assert_equal(positioning_calls, 1, "Expected exactly 1 safe positioning move")
        assert_equal(return_calls, 1, "Expected exactly 1 return to origin move")
    end)
    
    it("should handle user cancellation at initial confirmation", function()
        local inst = mc.mcGetInstance()
        
        -- Clear history
        MockMach4.clear_gcode_history()
        
        -- Mock user to cancel at initial confirmation
        MockMach4.mock_dialog_response(wx.wxNO)
        
        -- Load and execute the m200 macro
        dofile("../macros/m200.lua")
        m200()
        
        -- Get the execution history
        local history = MockMach4.get_gcode_history()
        
        -- Test: Should have no operations when cancelled early
        assert_equal(#history, 0, "Expected no operations when cancelled at confirmation")
    end)
    
    it("should handle user cancellation at upper half material positioning", function()
        local inst = mc.mcGetInstance()
        
        -- Clear history
        MockMach4.clear_gcode_history()
        
        -- Mock user responses: YES to start, CANCEL at positioning
        MockMach4.mock_dialog_response(wx.wxYES)     -- Initial confirmation
        MockMach4.mock_dialog_response(wx.wxCANCEL)  -- Material positioning
        
        -- Load and execute the m200 macro
        dofile("../macros/m200.lua")
        m200()
        
        -- Get the execution history
        local history = MockMach4.get_gcode_history()
        
        -- Test: Should have no operations when cancelled at positioning
        assert_equal(#history, 0, "Expected no operations when cancelled at upper half positioning")
    end)
    
    it("should handle user cancellation at material flip (between upper and lower halves)", function()
        local inst = mc.mcGetInstance()
        
        -- Clear history
        MockMach4.clear_gcode_history()
        
        -- Mock user responses: YES, OK, OK for first operation complete, then CANCEL at flip, OK for cancelled msg
        MockMach4.mock_dialog_response(wx.wxYES)     -- Initial confirmation
        MockMach4.mock_dialog_response(wx.wxOK)      -- Material positioning
        -- Note: executeAluminumCutting shows "Operation Complete" dialog after first cut
        MockMach4.mock_dialog_response(wx.wxOK)      -- First operation complete
        MockMach4.mock_dialog_response(wx.wxCANCEL)  -- Material flip (user cancels here)
        MockMach4.mock_dialog_response(wx.wxOK)      -- "Cancelled" message
        
        -- Load and execute the m200 macro
        dofile("../macros/m200.lua")
        m200()
        
        -- Get the execution history
        local history = MockMach4.get_gcode_history()
        
        -- Test: Should have upper half cut and positioning but not lower half cut
        local file_calls = 0
        local positioning_calls = 0
        
        for i, call in ipairs(history) do
            if call.method == "file_load" then
                file_calls = file_calls + 1
            elseif call.method == "individual" and string.find(call.gcode, "G53", 1, true) then
                positioning_calls = positioning_calls + 1
            end
        end
        
        assert_equal(file_calls, 1, "Expected only upper half cutting operation when cancelled at flip")
        assert_equal(positioning_calls, 1, "Expected safe positioning to complete before cancellation")
    end)
    
    it("should validate safe positioning move parameters", function()
        local inst = mc.mcGetInstance()
        
        -- Test individual function
        dofile("../macros/m200.lua")
        
        -- Clear history before testing function
        MockMach4.clear_gcode_history()
        
        -- Test the safe positioning function directly
        local result = moveMachineToSafePosition(inst)
        assert_true(result, "Safe positioning should succeed")
        
        -- Verify the G-code generated
        local history = MockMach4.get_gcode_history()
        assert_equal(#history, 1, "Expected exactly 1 G-code call for safe positioning")
        
        local call = history[1]
        assert_equal(call.method, "individual", "Expected individual G-code execution")
        
        -- Verify G-code content
        assert_true(string.find(call.gcode, "G90", 1, true) ~= nil, "Expected G90 absolute positioning")
        assert_true(string.find(call.gcode, "G53", 1, true) ~= nil, "Expected G53 machine coordinates")
        assert_true(string.find(call.gcode, "Z%-0%.5") ~= nil, "Expected Z-0.5 rapid move")
        assert_true(string.find(call.gcode, "X0%.5 Y23%.5") ~= nil and string.find(call.gcode, "F150") ~= nil, "Expected XY move at F150")
    end)
    
    it("should validate return to origin move parameters", function()
        local inst = mc.mcGetInstance()
        
        -- Test individual function
        dofile("../macros/m200.lua")
        
        -- Clear history before testing function
        MockMach4.clear_gcode_history()
        
        -- Test the return to origin function directly
        local result = returnToWorkOrigin(inst)
        assert_true(result, "Return to origin should succeed")
        
        -- Verify the G-code generated
        local history = MockMach4.get_gcode_history()
        assert_equal(#history, 1, "Expected exactly 1 G-code call for return to origin")
        
        local call = history[1]
        assert_equal(call.method, "individual", "Expected individual G-code execution")
        
        -- Verify G-code content
        assert_true(string.find(call.gcode, "G90", 1, true) ~= nil, "Expected G90 absolute positioning")
        assert_true(string.find(call.gcode, "G55", 1, true) ~= nil, "Expected G55 work coordinates")
        assert_true(string.find(call.gcode, "G0 X0 Y0", 1, true) ~= nil, "Expected move to work origin")
    end)
    
    it("should preserve existing single-operation functionality", function()
        -- This test ensures backward compatibility if needed
        local inst = mc.mcGetInstance()
        
        -- Clear history
        MockMach4.clear_gcode_history()
        
        -- Load the macro file
        dofile("../macros/m200.lua")
        
        -- Test individual cutting function directly (with default G52 offsets)
        executeAluminumCutting(inst, 0, 0, "test cutting operation")
        
        -- Verify cutting operation works independently
        local history = MockMach4.get_gcode_history()
        assert_equal(#history, 1, "Expected exactly 1 file load for single operation")
        
        local call = history[1]
        assert_equal(call.method, "file_load", "Expected file-based execution for cutting")
        assert_true(string.find(call.filepath, "BoxTube_", 1, true) ~= nil, "Expected BoxTube_ prefix")
    end)
    
    it("should handle G-code execution errors gracefully", function()
        local inst = mc.mcGetInstance()
        
        -- Mock G-code execution to fail
        MockMach4.set_gcode_execution_error(mc.MERROR_AXIS_NOT_HOMED)
        
        -- Load the macro file
        dofile("../macros/m200.lua")
        
        -- Test safe positioning with error condition
        local result = moveMachineToSafePosition(inst)
        assert_false(result, "Safe positioning should fail when G-code execution fails")
        
        -- Reset error condition
        MockMach4.set_gcode_execution_error(mc.MERROR_NOERROR)
        
        -- Test return to origin with error condition
        MockMach4.set_gcode_execution_error(mc.MERROR_AXIS_NOT_ENABLED)
        result = returnToWorkOrigin(inst)
        assert_false(result, "Return to origin should fail when G-code execution fails")
    end)
end)