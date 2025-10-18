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
    
    it("should execute box tube squaring operation with temp file execution", function()
        local inst = mc.mcGetInstance()
        
        -- Clear any previous G-code history
        MockMach4.clear_gcode_history()
        
        -- Load and execute the m200 macro (now using temp file pattern)
        dofile("../macros/m200.lua")
        m200()
        
        -- Get the G-code execution history
        local history = MockMach4.get_gcode_history()
        
        -- Test: Should have exactly 1 file load operation
        assert_equal(#history, 1, "Expected exactly 1 file load operation")
        
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
        assert_equal(file_calls, 1, "Expected exactly 1 file load execution")
        
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
