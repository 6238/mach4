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
    
    it("should execute aluminum cutting operation", function()
        local inst = mc.mcGetInstance()
        
        -- Clear any previous G-code history
        MockMach4.clear_gcode_history()
        
        -- Load and execute the m200 macro (now aluminum cutting)
        dofile("../macros/m200_hello_world.lua")
        m200()
        
        -- Get the G-code execution history
        local history = MockMach4.get_gcode_history()
        
        -- Test: Should have 3 cutting passes + 1 cleanup = 4 total calls
        assert_true(#history >= 3, "Expected at least 3 cutting passes")
        
        -- Test: Should use 'individual' method for cutting passes
        local individual_passes = 0
        for i, call in ipairs(history) do
            if call.method == "individual" then
                individual_passes = individual_passes + 1
            end
        end
        assert_true(individual_passes >= 3, "Expected at least 3 individual cutting passes")
        
        -- Test: Should contain aluminum cutting G-code commands
        local all_gcode = ""
        for _, call in ipairs(history) do
            all_gcode = all_gcode .. call.gcode .. "\n"
        end
        
        -- Check for key aluminum cutting commands
        local expected_commands = {"G56", "G90", "G94", "G00", "G01"}
        
        for _, expected in ipairs(expected_commands) do
            assert_true(string.find(all_gcode, expected, 1, true) ~= nil, 
                "G-code missing expected aluminum cutting command: " .. expected)
        end
        
        -- Test: Should contain variable feed rates
        assert_true(string.find(all_gcode, "F100", 1, true) ~= nil, "Missing fast plunge feed rate")
        assert_true(string.find(all_gcode, "F20", 1, true) ~= nil, "Missing heavy cutting feed rate") 
        assert_true(string.find(all_gcode, "F50", 1, true) ~= nil, "Missing fast cutting feed rate")
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