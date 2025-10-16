# Hello World Plugin - Deployment Guide

This directory contains automated deployment scripts that simplify the installation process for the Hello World Plugin.

## Files

- **`auto_installer.lua`** - Main installation script with automated setup
- **`README.md`** - This deployment guide

## Installation Methods

### Method 1: Automated Installation (Recommended)

1. **Load the plugin** in Mach4 Operator console:
   ```lua
   local installer = require("deployment.auto_installer")
   installer.install()
   ```

2. **Create minimal UI controls** in Screen Editor:
   - Text Field: `txtMoveSize` (default: "2.0")
   - Button: `btnExecuteMove` (label: "Execute Square Move")

3. **Verify installation**:
   ```lua
   installer.verify_installation()
   ```

### Method 2: Manual Installation (Fallback)

If the automated installer doesn't work with your Mach4 version:

1. Follow the manual steps in `src/screens/UI_SETUP.md`
2. Manually copy scripts from `src/screens/` directory
3. Test functionality with M200 macro

## What the Installer Does

### Automated Tasks
- ✅ Configures plugin registers for persistent settings
- ✅ Initializes default values for UI controls
- ✅ Sets up M200 macro integration
- ✅ Provides verification and troubleshooting tools

### Manual Tasks (Still Required)
- ⚠️ Create UI controls in Screen Editor (layout must be done visually)
- ⚠️ Position controls on screen (GUI-only operation)
- ⚠️ Save screen file (.set format is proprietary)

## Key Benefits

1. **Reduced Manual Work**: No more copying/pasting scripts between files
2. **Automated Configuration**: Plugin registers and settings are configured automatically
3. **Built-in Verification**: Check installation status with one command
4. **Error Prevention**: Reduces chances of script copying errors
5. **Consistent Setup**: Standardized installation process

## Limitations

Due to Mach4's architecture, the following cannot be automated:
- **Screen layout design** (requires Screen Editor GUI)
- **Control positioning** (visual placement only)
- **Screen file creation** (.set files are binary format)

## Troubleshooting

### Installation Issues
```lua
-- Check if installer module loads correctly
local installer = require("deployment.auto_installer")
print(installer)

-- Run verification to diagnose problems
installer.verify_installation()
```

### Common Problems

1. **Module not found**: Ensure the src directory is in Mach4's Lua path
2. **Controls not found**: Verify UI controls are named correctly in Screen Editor
3. **Scripts not working**: Check that the manual control creation step was completed

## Uninstallation

To remove the plugin:
```lua
local installer = require("deployment.auto_installer")
installer.uninstall()
```

Note: Screen modifications must be manually removed in the Screen Editor.

## Future Improvements

Potential enhancements for the automated installer:
- Template .set files for common screen layouts
- Automated backup of existing screens before modification
- Integration with Mach4 plugin management system
- Visual control placement through programmatic screen generation (if APIs become available)