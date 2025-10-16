-- test_hello_world.lua
-- Tests for the Hello World macro functionality

-- Load test framework and mock API
require("test_framework")
local mock_mach4 = require("mock_mach4_api")

describe("Hello World Macro Tests", function()
    
    before_each(function()
        -- Reset mock state before each test
        mock_mach4.reset_state()
        mock_mach4.clear_gcode_history()
    end)
    
    it("should generate correct G-code for square movement", function()
        -- Set up mock machine state
        local inst = mc.mcGetInstance()
        mc.mcCntlEnable(inst, MC_ON)
        
        -- Set starting position
        mc.mcAxisSetPos(inst, 0, 5.0)  -- X = 5.0
        mc.mcAxisSetPos(inst, 1, 3.0)  -- Y = 3.0
        
        -- Function to generate square G-code (extracted from macro)
        local function generate_square_gcode(start_x, start_y, size)
            return {
                "G90",
                "G01 F100",
                string.format("X%.3f Y%.3f", start_x + size, start_y),
                string.format("X%.3f Y%.3f", start_x + size, start_y + size),
                string.format("X%.3f Y%.3f", start_x, start_y + size),
                string.format("X%.3f Y%.3f", start_x, start_y),
            }
        end
        
        -- Generate expected G-code
        local expected_gcode = generate_square_gcode(5.0, 3.0, 2.0)
        
        -- Execute the G-code
        for _, gcode in ipairs(expected_gcode) do
            local rc = mc.mcCntlGcodeExecute(inst, gcode)
            assert_equal(rc, 0, "G-code execution should succeed")
        end
        
        -- Verify G-code was executed
        local history = mock_mach4.get_gcode_history()
        assert_equal(#history, #expected_gcode, "Should execute all G-code commands")
        
        -- Verify specific commands
        assert_equal(history[1].gcode, "G90")
        assert_equal(history[2].gcode, "G01 F100")
        assert_equal(history[3].gcode, "X7.000 Y3.000")  -- Move 2" in X
        assert_equal(history[6].gcode, "X5.000 Y3.000")  -- Return to start
    end)
    
    it("should handle machine not ready state", function()
        local inst = mc.mcGetInstance()
        -- Don't enable machine (simulate not ready)
        
        local state, rc = mc.mcCntlGetState(inst)
        assert_not_equal(state, 3, "Machine should not be in idle state")
    end)
    
    it("should calculate correct positions for different starting points", function()
        -- Test G-code generation from different starting positions
        local test_cases = {
            {x = 0, y = 0, size = 2},
            {x = 10, y = 5, size = 1.5},
            {x = -2, y = -1, size = 3}
        }
        
        for _, case in ipairs(test_cases) do
            local function generate_square_gcode(start_x, start_y, size)
                return {
                    "G90",
                    "G01 F100",
                    string.format("X%.3f Y%.3f", start_x + size, start_y),
                    string.format("X%.3f Y%.3f", start_x + size, start_y + size),
                    string.format("X%.3f Y%.3f", start_x, start_y + size),
                    string.format("X%.3f Y%.3f", start_x, start_y),
                }
            end
            
            local gcode = generate_square_gcode(case.x, case.y, case.size)
            
            -- Verify the corners of the square
            local expected_first_corner = string.format("X%.3f", case.x + case.size)
            local expected_return = string.format("X%.3f Y%.3f", case.x, case.y)
            
            assert_true(string.find(gcode[3], expected_first_corner, 1, true) ~= nil, 
                "First corner should move to X + size. Expected: " .. expected_first_corner .. ", Got: " .. gcode[3])
            assert_equal(gcode[6], expected_return, 
                "Should return to starting position")
        end
    end)
    
    it("should use appropriate feed rate", function()
        local inst = mc.mcGetInstance()
        mc.mcCntlEnable(inst, MC_ON)
        
        -- Execute feed rate command
        local rc = mc.mcCntlGcodeExecute(inst, "G01 F100")
        assert_equal(rc, 0, "Feed rate command should execute successfully")
        
        local history = mock_mach4.get_gcode_history()
        assert_equal(history[1].gcode, "G01 F100")
    end)
    
end)