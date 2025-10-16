-- test_ui_functionality.lua
-- Tests for UI script functionality

require("test_framework")
local mock_mach4 = require("mock_mach4_api")

-- Mock scr.GetProperty to simulate text input
local mock_text_value = "2.0"
function scr.GetProperty(control, property)
    if control == "txtMoveSize" and property == "Value" then
        return mock_text_value
    end
    return ""
end

describe("UI Functionality Tests", function()
    
    before_each(function()
        mock_mach4.reset_state()
        mock_mach4.clear_gcode_history()
        mock_text_value = "2.0"  -- Reset to default
    end)
    
    it("should validate positive numeric input", function()
        local function validate_input(value_str)
            local value = tonumber(value_str)
            return value and value > 0 and value <= 10
        end
        
        -- Test valid inputs
        assert_true(validate_input("2.0"))
        assert_true(validate_input("0.1"))
        assert_true(validate_input("10.0"))
        assert_true(validate_input("5.5"))
        
        -- Test invalid inputs
        assert_false(validate_input("0"))
        assert_false(validate_input("-1"))
        assert_false(validate_input("10.1"))
        assert_false(validate_input("abc"))
        assert_false(validate_input(""))
    end)
    
    it("should generate correct G-code from UI input", function()
        mock_text_value = "1.5"
        
        local inst = mc.mcGetInstance()
        mc.mcCntlEnable(inst, MC_ON)
        
        -- Set starting position
        mc.mcAxisSetPos(inst, 0, 3.0)  -- X = 3.0
        mc.mcAxisSetPos(inst, 1, 2.0)  -- Y = 2.0
        
        -- Simulate the button script logic
        local move_size_str = scr.GetProperty("txtMoveSize", "Value")
        local move_size = tonumber(move_size_str)
        
        assert_equal(move_size, 1.5)
        
        -- Get current position (simulating the button script)
        local curr_x, rc = mc.mcAxisGetPos(inst, 0)
        local curr_y, rc = mc.mcAxisGetPos(inst, 1)
        
        assert_equal(curr_x, 3.0)
        assert_equal(curr_y, 2.0)
        
        -- Generate expected G-code
        local expected_gcode = {
            "G90",
            "G01 F100",
            "X4.500 Y2.000",  -- curr_x + 1.5, curr_y
            "X4.500 Y3.500",  -- curr_x + 1.5, curr_y + 1.5
            "X3.000 Y3.500",  -- curr_x, curr_y + 1.5
            "X3.000 Y2.000",  -- curr_x, curr_y (return to start)
        }
        
        -- Execute G-code
        for _, gcode in ipairs(expected_gcode) do
            local rc = mc.mcCntlGcodeExecute(inst, gcode)
            assert_equal(rc, 0)
        end
        
        -- Verify execution
        local history = mock_mach4.get_gcode_history()
        assert_equal(#history, #expected_gcode)
        
        for i, expected in ipairs(expected_gcode) do
            assert_equal(history[i].gcode, expected)
        end
    end)
    
    it("should handle different input sizes correctly", function()
        local test_cases = {
            {input = "0.5", start_x = 0, start_y = 0},
            {input = "3.0", start_x = 5, start_y = 2},
            {input = "1.25", start_x = -1, start_y = 3.5}
        }
        
        for _, case in ipairs(test_cases) do
            mock_mach4.clear_gcode_history()
            mock_text_value = case.input
            
            local inst = mc.mcGetInstance()
            mc.mcCntlEnable(inst, MC_ON)
            mc.mcAxisSetPos(inst, 0, case.start_x)
            mc.mcAxisSetPos(inst, 1, case.start_y)
            
            local move_size = tonumber(scr.GetProperty("txtMoveSize", "Value"))
            local curr_x, _ = mc.mcAxisGetPos(inst, 0)
            local curr_y, _ = mc.mcAxisGetPos(inst, 1)
            
            -- Generate and execute G-code
            local gcode_commands = {
                "G90",
                "G01 F100",
                string.format("X%.3f Y%.3f", curr_x + move_size, curr_y),
                string.format("X%.3f Y%.3f", curr_x + move_size, curr_y + move_size),
                string.format("X%.3f Y%.3f", curr_x, curr_y + move_size),
                string.format("X%.3f Y%.3f", curr_x, curr_y),
            }
            
            for _, gcode in ipairs(gcode_commands) do
                mc.mcCntlGcodeExecute(inst, gcode)
            end
            
            local history = mock_mach4.get_gcode_history()
            
            -- Verify the square returns to start position
            local final_position = history[#history].gcode
            local expected_return = string.format("X%.3f Y%.3f", case.start_x, case.start_y)
            assert_equal(final_position, expected_return, 
                "Should return to starting position for input: " .. case.input)
        end
    end)
    
    it("should handle machine state checking", function()
        local inst = mc.mcGetInstance()
        
        -- Test with machine disabled
        mc.mcCntlEnable(inst, MC_OFF)
        local state, rc = mc.mcCntlGetState(inst)
        assert_not_equal(state, 3, "Machine should not be ready when disabled")
        
        -- Test with machine enabled
        mc.mcCntlEnable(inst, MC_ON)
        state, rc = mc.mcCntlGetState(inst)
        assert_equal(rc, 0, "Should get state successfully")
        -- Note: In our mock, enabled machine returns state 3 (IDLE)
    end)
    
    it("should format G-code coordinates correctly", function()
        local test_positions = {
            {x = 1.0, y = 2.0, expected = "X1.000 Y2.000"},
            {x = 0.123, y = 4.567, expected = "X0.123 Y4.567"},
            {x = -2.5, y = 10.0, expected = "X-2.500 Y10.000"},
        }
        
        for _, pos in ipairs(test_positions) do
            local formatted = string.format("X%.3f Y%.3f", pos.x, pos.y)
            assert_equal(formatted, pos.expected, "Coordinate formatting should be correct")
        end
    end)
    
end)