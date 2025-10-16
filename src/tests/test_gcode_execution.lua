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
    
    it("should use bulk execution method", function()
        local inst = mc.mcGetInstance()
        
        -- Clear any previous G-code history
        MockMach4.clear_gcode_history()
        
        -- Set initial position
        mc.mcAxisSetPos(inst, 0, 1.0)  -- X = 1.0
        mc.mcAxisSetPos(inst, 1, 2.0)  -- Y = 2.0
        
        -- Load and execute the m200 macro
        dofile("../macros/m200_hello_world.lua")
        m200()
        
        -- Get the G-code execution history
        local history = MockMach4.get_gcode_history()
        
        -- Test: Should have exactly 1 execution call (bulk method)
        assert_equal(#history, 1, "Expected 1 G-code execution call")
        
        -- Test: Should use 'bulk' method
        assert_equal(history[1].method, "bulk", "Expected bulk execution method")
        
        -- Test: Should contain multiple G-code lines
        assert_true(history[1].line_count and history[1].line_count >= 5, "Expected at least 5 G-code lines")
        
        -- Test: Should contain all expected G-code commands
        local gcode_program = history[1].gcode
        local expected_commands = {"G90", "G01 F100", "X3.000 Y2.000", "X3.000 Y4.000", "X1.000 Y4.000", "X1.000 Y2.000"}
        
        for _, expected in ipairs(expected_commands) do
            assert_true(string.find(gcode_program, expected, 1, true) ~= nil, 
                "G-code program missing expected command: " .. expected)
        end
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