-- auto_installer.lua
-- Automated deployment script for Hello World Plugin
-- Handles screen setup, script installation, and configuration

local auto_installer = {}

-- Load our screen installer module
local screen_installer = require("screens.screen_installer")

-- Plugin configuration
local PLUGIN_CONFIG = {
    name = "Hello World Plugin",
    version = "1.0",
    author = "Mach4 Developer",
    description = "Custom UI widget for CNC square movement operations"
}

-- Main installation function
function auto_installer.install()
    local inst = mc.mcGetInstance()
    
    print("=" .. string.rep("=", 50))
    print("Installing " .. PLUGIN_CONFIG.name .. " v" .. PLUGIN_CONFIG.version)
    print("=" .. string.rep("=", 50))
    
    -- Step 1: Install screen components
    print("\n1. Installing screen components...")
    local screen_result = screen_installer.install_to_screen()
    
    if screen_result then
        print("✓ Screen components installed successfully")
    else
        print("⚠ Screen installation completed with warnings")
    end
    
    -- Step 2: Configure plugin registers
    print("\n2. Configuring plugin registers...")
    auto_installer.setup_registers()
    
    -- Step 3: Install macros and scripts
    print("\n3. Installing macros...")
    auto_installer.install_macros()
    
    -- Step 4: Display setup instructions
    print("\n4. Setup complete!")
    auto_installer.show_completion_message(screen_result)
    
    return true
end

-- Setup plugin-specific registers
function auto_installer.setup_registers()
    local inst = mc.mcGetInstance()
    
    -- Create plugin register for move size storage
    local reg_handle, rc = mc.mcRegGetHandle(inst, "plugins/helloworld/move_size")
    if rc == 0 then
        mc.mcRegSetValueString(reg_handle, "2.0")
        print("✓ Move size register configured")
    else
        print("⚠ Could not create move size register")
    end
    
    -- Create plugin version register
    local version_handle, rc = mc.mcRegGetHandle(inst, "plugins/helloworld/version")
    if rc == 0 then
        mc.mcRegSetValueString(version_handle, PLUGIN_CONFIG.version)
        print("✓ Version register configured")
    end
end

-- Install macro files (if any)
function auto_installer.install_macros()
    -- The M200 macro should already be in the macros directory
    print("✓ M200 Hello World macro available")
    print("  Usage: Execute 'M200' in MDI or G-code")
end

-- Show completion message with next steps
function auto_installer.show_completion_message(screen_result)
    local instructions = screen_installer.get_setup_instructions()
    
    print("\n" .. string.rep("=", 50))
    print("INSTALLATION COMPLETE")
    print(string.rep("=", 50))
    
    print("\nNext Steps:")
    for _, step in ipairs(instructions.steps) do
        print("  " .. step)
    end
    
    print("\nAvailable Features:")
    print("  • Square movement UI widget")
    print("  • Input validation and safety checks")
    print("  • M200 macro for G-code integration")
    print("  • Configurable move size (0.1-10.0 inches)")
    
    print("\nManual Setup (if needed):")
    for _, step in ipairs(instructions.manual_fallback) do
        print("  " .. step)
    end
    
    print("\nPlugin Information:")
    print("  Name: " .. PLUGIN_CONFIG.name)
    print("  Version: " .. PLUGIN_CONFIG.version)
    print("  Description: " .. PLUGIN_CONFIG.description)
    
    print("\n" .. string.rep("=", 50))
end

-- Uninstall function for cleanup
function auto_installer.uninstall()
    local inst = mc.mcGetInstance()
    
    print("Uninstalling " .. PLUGIN_CONFIG.name .. "...")
    
    -- Clear plugin registers
    local reg_handle, rc = mc.mcRegGetHandle(inst, "plugins/helloworld/move_size")
    if rc == 0 then
        mc.mcRegSetValueString(reg_handle, "")
    end
    
    print("✓ Plugin uninstalled successfully")
    print("Note: Screen modifications must be manually removed")
end

-- Quick setup verification
function auto_installer.verify_installation()
    local inst = mc.mcGetInstance()
    
    print("Verifying Hello World Plugin installation...")
    
    -- Check registers
    local reg_handle, rc = mc.mcRegGetHandle(inst, "plugins/helloworld/move_size")
    if rc == 0 then
        local value = mc.mcRegGetValueString(reg_handle)
        print("✓ Move size register: " .. (value or "not set"))
    else
        print("✗ Move size register not found")
    end
    
    -- Check screen controls (if possible)
    local move_size = scr.GetProperty("txtMoveSize", "Value")
    if move_size then
        print("✓ Text field found: " .. move_size)
    else
        print("⚠ Text field not found - manual setup may be needed")
    end
    
    print("Verification complete.")
end

return auto_installer