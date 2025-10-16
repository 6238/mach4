# Custom UI Setup - Automated Installation

The Hello World Plugin now supports **automated installation** that eliminates most manual setup steps.

## Quick Setup (Recommended)

1. **Load the installer** in Mach4 Operator console:
   ```lua
   local installer = require("deployment.auto_installer")
   installer.install()
   ```

2. **Create UI controls** in Screen Editor:
   - **Text Field**: Name `txtMoveSize`, default value `2.0`
   - **Button**: Name `btnExecuteMove`, label "Execute Square Move"

3. **Run installation script** (from Operator console):
   ```lua
   installer.verify_installation()
   ```

## Manual Setup (Fallback)

If automated installation fails, use the traditional method:

1. **Operator** → **Edit Screen**
2. **Add Text Field**: Name `txtMoveSize`, default value `2.0`
3. **Add Button**: Name `btnExecuteMove`, text "Execute Square Move"
4. **Button Script**: Copy `button_execute_script.lua` to button's Left Up Script
5. **Screen Script** (optional): Copy `screen_load_script.lua` to Screen Load Script
6. **Save**

## Layout
```
Square Size (inches): [2.0      ]
       [ Execute Square Move ]
```

## Features
- **Automated script injection** - no manual copying required
- **Input validation** and safety checks
- **Error handling** and user feedback
- **Register-based configuration** for persistent settings
- **M200 macro integration** for G-code compatibility

## Verification
Run `installer.verify_installation()` to check that all components are properly configured.