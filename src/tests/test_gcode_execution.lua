-- test_gcode_execution.lua
-- Tests specifically for G-code execution methods

local MockMach4 = require("mock_mach4_api")

describe("G-code Execution Method Tests", function()
    before_each(function()
        MockMach4.reset_state()
        -- Enable machine for testing
        local inst = mc.mcGetInstance()
        mc.mcCntlEnable(inst, 1)
    end)
    
    it("should execute upper/lower half box tube end squaring with temp file execution", function()
        local inst = mc.mcGetInstance()
        
        -- Clear any previous G-code history
        MockMach4.clear_gcode_history()
        
        -- Mock user dialogs for upper/lower half operation
        MockMach4.mock_dialog_response(wx.wxYES)    -- Initial confirmation
        MockMach4.mock_dialog_response(wx.wxOK)     -- Material positioning
        MockMach4.mock_dialog_response(wx.wxOK)     -- Material flip
        
        -- Load and execute the m200 macro (now using upper/lower half workflow)
        dofile("../macros/m200.lua")
        m200()
        
        -- Get the G-code execution history
        local history = MockMach4.get_gcode_history()
        
        -- Test: Should have 4 operations (2 cuts, 1 safe move, 1 return)
        assert_true(#history >= 4, "Expected at least 4 operations for upper/lower half workflow")
        
        -- Test: Should use 'file_load' method for temp file execution
        local file_calls = 0
        for i, call in ipairs(history) do
            if call.method == "file_load" then
                file_calls = file_calls + 1
                -- Test: Should have a temp file path
                assert_true(call.filepath ~= nil, "Expected temp file path in file load call")
                assert_true(string.find(call.filepath, "BoxTube_", 1, true) ~= nil, "Expected BoxTube_ prefix in temp file")
                assert_true(string.find(call.filepath, ".tmp", 1, true) ~= nil, "Expected .tmp extension in temp file")
            end
        end
        assert_equal(file_calls, 2, "Expected exactly 2 file load executions for upper/lower half operation")
        
        -- Test: No global cleanup variable should be set (cleanup is handled directly)
        assert_true(_G.__pendingTempGcodeToDelete == nil, "Expected no global cleanup variable with integrated cleanup")
    end)
    
    it("should demonstrate old sequential method inefficiency", function()
        -- This test simulates what would happen with the old code
        local inst = mc.mcGetInstance()
        
        -- Clear any previous G-code history
        MockMach4.clear_gcode_history()
        
        -- Simulate the old sequential execution method
        local gcode_commands = {
            "G90",
            "G01 F100", 
            "X3.000 Y2.000",
            "X3.000 Y4.000",
            "X1.000 Y4.000",
            "X1.000 Y2.000"
        }
        
        -- Execute each command individually (old method)
        for i, gcode in ipairs(gcode_commands) do
            mc.mcCntlGcodeExecute(inst, gcode)
        end
        
        -- Get the execution history
        local history = MockMach4.get_gcode_history()
        
        -- Test: Old method would have multiple individual calls
        assert_equal(#history, #gcode_commands, "Old method should have multiple calls")
        
        -- Test: All calls should be 'individual' method
        for i, call in ipairs(history) do
            assert_equal(call.method, "individual", 
                string.format("Old method call %d should be individual", i))
        end
    end)
    
    it("should handle G-code execution properly", function()
        local inst = mc.mcGetInstance()
        
        -- Clear history
        MockMach4.clear_gcode_history()
        
        -- Test with empty G-code program
        local rc = mc.mcCntlGcodeExecuteWait(inst, "")
        assert_equal(rc, 0, "Empty G-code program should not cause error")
        
        -- Test with valid G-code program
        local valid_gcode = "G90\nG01 X1.0 Y1.0 F100\n"
        rc = mc.mcCntlGcodeExecuteWait(inst, valid_gcode)
        assert_equal(rc, 0, "Valid G-code program should execute successfully")
    end)
end)
