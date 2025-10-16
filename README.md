# Mach4 CNC Plugin - Hello World Version

Simple Mach4 plugin for Avid Benchtop Pro CNC that demonstrates basic G-code generation and execution.

## Quick Start - Test on Machine (5 minutes)

1. **Copy macro**: `src/macros/m200_hello_world.lua` → `C:\Mach4Hobby\Profiles\[Profile]\Macros\m200.mcs`
2. **Enable and home** your machine
3. **Move to safe position** (3"+ clearance in X/Y)
4. **Type `M200`** in Mach4's G-code input and press Enter

**Result**: Tool moves in a 2x2 inch square pattern and returns to start.

## What's Included

- **Hello World macro**: Simple square movement test
- **UI components**: Text input + button for custom interface  
- **Testing framework**: 9 passing tests for offline development
- **Mock Mach4 API**: Develop without machine access

## File Structure

```
src/
├── macros/m200_hello_world.lua       # Main macro (copy to Mach4)
├── screens/                          # UI components + installer
├── deployment/                       # Automated installation scripts
└── tests/                           # Testing framework + 9 tests
```

## Add Custom UI

### Quick Setup (Automated)
1. **Run installer** in Mach4 Operator console:
   ```lua
   local installer = require("deployment.auto_installer")
   installer.install()
   ```
2. **Create UI controls** in Screen Editor: text field `txtMoveSize`, button `btnExecuteMove`
3. **Verify**: `installer.verify_installation()`

### Manual Setup (Fallback)
See `src/screens/UI_SETUP.md` for detailed Screen Editor instructions.

## Development Testing

```bash
cd src/tests
lua test_runner.lua
```

Runs 9 tests covering G-code generation, input validation, and safety checks.

## Safety Notes

- Start with small values (0.5-1.0 inches)
- Keep spindle OFF during initial testing
- Ensure adequate clearance around starting position
- Emergency stop accessible

## Next Steps

Once basic version works on your machine:
- Add real inputs (length, X/Y offsets)
- Implement two-step cutting process (cut → flip → cut)
- Replace simple movement with actual machining operations

## Troubleshooting

**"Unknown M Code"**: File must be named `m200.mcs` in correct macros folder  
**"Machine not ready"**: Enable machine and clear alarms  
**Wrong movement**: Check units (inches vs mm) and soft limits