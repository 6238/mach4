#!/usr/bin/env lua

-- test_runner.lua
-- Main test runner for the Mach4 plugin test suite

-- Initialize mock Mach4 API for testing
local mock_mach4 = require("mock_mach4_api")
mock_mach4.init()

-- Load the test framework
local test_framework = require("test_framework")

-- Function to run all tests
function run_all_tests()
    print("Starting Mach4 Plugin Test Suite")
    print("================================")
    print()
    
    -- Load and run individual test files
    local test_files = {
        "test_hello_world",
        "test_ui_functionality",
        "test_gcode_execution",
        -- Add more test files as they are created
    }
    
    local all_passed = true
    
    for _, test_file in ipairs(test_files) do
        local success, result = pcall(function()
            print("Loading test file: " .. test_file .. ".lua")
            require(test_file)
        end)
        
        if not success then
            print("Error loading test file " .. test_file .. ": " .. result)
            all_passed = false
        end
    end
    
    -- Run all tests
    local tests_passed = test_framework.run_all()
    
    if all_passed and tests_passed then
        print("\n🎉 All tests completed successfully!")
        os.exit(0)
    else
        print("\n❌ Some tests failed or had errors!")
        os.exit(1)
    end
end

-- Run tests if this file is executed directly
if arg and arg[0] and string.match(arg[0], "test_runner%.lua$") then
    run_all_tests()
end

return {
    run_all_tests = run_all_tests
}