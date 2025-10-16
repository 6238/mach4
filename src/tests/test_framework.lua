-- test_framework.lua
-- Custom Lua testing framework for Mach4 plugin development
-- Allows offline testing without Mach4 hardware

local TestFramework = {}
TestFramework.__index = TestFramework

-- Test suite state
local current_suite = nil
local test_results = {}
local test_stats = {
    total = 0,
    passed = 0,
    failed = 0,
    errors = 0
}

-- Color codes for terminal output
local COLORS = {
    red = "\27[31m",
    green = "\27[32m",
    yellow = "\27[33m",
    blue = "\27[34m",
    reset = "\27[0m"
}

-- Create a new test suite
function TestFramework.new(suite_name)
    local self = setmetatable({}, TestFramework)
    self.name = suite_name
    self.tests = {}
    self.setup_func = nil
    self.teardown_func = nil
    current_suite = self
    return self
end

-- Add setup function to run before each test
function TestFramework:setup(func)
    self.setup_func = func
end

-- Add teardown function to run after each test
function TestFramework:teardown(func)
    self.teardown_func = func
end

-- Add a test to the suite
function TestFramework:test(test_name, test_func)
    table.insert(self.tests, {
        name = test_name,
        func = test_func
    })
end

-- Assertion functions
local function assert_equal(actual, expected, message)
    if actual ~= expected then
        error(message or string.format("Expected %s, got %s", tostring(expected), tostring(actual)))
    end
end

local function assert_not_equal(actual, unexpected, message)
    if actual == unexpected then
        error(message or string.format("Expected not %s, but got %s", tostring(unexpected), tostring(actual)))
    end
end

local function assert_true(value, message)
    if not value then
        error(message or string.format("Expected true, got %s", tostring(value)))
    end
end

local function assert_false(value, message)
    if value then
        error(message or string.format("Expected false, got %s", tostring(value)))
    end
end

local function assert_nil(value, message)
    if value ~= nil then
        error(message or string.format("Expected nil, got %s", tostring(value)))
    end
end

local function assert_not_nil(value, message)
    if value == nil then
        error(message or "Expected not nil, got nil")
    end
end

local function assert_type(value, expected_type, message)
    local actual_type = type(value)
    if actual_type ~= expected_type then
        error(message or string.format("Expected type %s, got %s", expected_type, actual_type))
    end
end

local function assert_error(func, message)
    local success, _ = pcall(func)
    if success then
        error(message or "Expected function to throw an error, but it didn't")
    end
end

-- Export assertion functions globally for tests
_G.assert_equal = assert_equal
_G.assert_not_equal = assert_not_equal
_G.assert_true = assert_true
_G.assert_false = assert_false
_G.assert_nil = assert_nil
_G.assert_not_nil = assert_not_nil
_G.assert_type = assert_type
_G.assert_error = assert_error

-- Run a single test
local function run_test(suite, test)
    test_stats.total = test_stats.total + 1
    
    local result = {
        suite = suite.name,
        name = test.name,
        status = "passed",
        message = nil,
        error = nil
    }
    
    local success, error_msg = pcall(function()
        -- Run setup if available
        if suite.setup_func then
            suite.setup_func()
        end
        
        -- Run the test
        test.func()
        
        -- Run teardown if available
        if suite.teardown_func then
            suite.teardown_func()
        end
    end)
    
    if not success then
        result.status = "failed"
        result.error = error_msg
        test_stats.failed = test_stats.failed + 1
    else
        test_stats.passed = test_stats.passed + 1
    end
    
    table.insert(test_results, result)
    return result
end

-- Run all tests in a suite
function TestFramework:run()
    print(COLORS.blue .. "Running test suite: " .. self.name .. COLORS.reset)
    print("=" .. string.rep("=", string.len(self.name) + 19))
    
    for _, test in ipairs(self.tests) do
        local result = run_test(self, test)
        
        if result.status == "passed" then
            print(COLORS.green .. "✓ " .. test.name .. COLORS.reset)
        else
            print(COLORS.red .. "✗ " .. test.name .. COLORS.reset)
            print("  Error: " .. (result.error or "Unknown error"))
        end
    end
    
    print()
end

-- Run all registered test suites
function TestFramework.run_all()
    print(COLORS.yellow .. "Mach4 Plugin Test Runner" .. COLORS.reset)
    print("========================")
    print()
    
    -- Reset stats
    test_stats = {total = 0, passed = 0, failed = 0, errors = 0}
    test_results = {}
    
    -- This would be populated by requiring test files
    -- For now, we'll run the current suite if it exists
    if current_suite then
        current_suite:run()
    end
    
    -- Print summary
    print(COLORS.blue .. "Test Summary:" .. COLORS.reset)
    print(string.format("Total: %d, Passed: %d, Failed: %d", 
        test_stats.total, test_stats.passed, test_stats.failed))
    
    if test_stats.failed == 0 then
        print(COLORS.green .. "All tests passed!" .. COLORS.reset)
        return true
    else
        print(COLORS.red .. test_stats.failed .. " test(s) failed!" .. COLORS.reset)
        return false
    end
end

-- Helper function to create a test suite (syntactic sugar)
function describe(suite_name, suite_func)
    local suite = TestFramework.new(suite_name)
    suite_func()
    return suite
end

-- Helper function to add a test (syntactic sugar)
function it(test_name, test_func)
    if current_suite then
        current_suite:test(test_name, test_func)
    else
        error("Cannot define test outside of a test suite. Use describe() first.")
    end
end

-- Helper function for setup
function before_each(func)
    if current_suite then
        current_suite:setup(func)
    else
        error("Cannot define setup outside of a test suite. Use describe() first.")
    end
end

-- Helper function for teardown
function after_each(func)
    if current_suite then
        current_suite:teardown(func)
    else
        error("Cannot define teardown outside of a test suite. Use describe() first.")
    end
end

return TestFramework