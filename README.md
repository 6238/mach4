# Mach4 CNC Plugin - Box Tube Squaring

Advanced Mach4 plugin for Avid Benchtop Pro CNC that performs precise box tube end squaring operations.

## Quick Start - Test on Machine (Setup Required)

1. **Copy macro**: `src/macros/m200.lua` → `C:\Mach4Hobby\Profiles\[Profile]\Macros\m200.mcs`
2. **Set up G55 work coordinate** with tube positioned correctly
3. **Install 0.1575" flat end mill** (T1) and verify spindle speed
4. **Enable and home** your machine 
5. **Type `M200`** in Mach4's G-code input and press Enter

**Result**: Executes professional box tube end squaring operation with multiple adaptive passes and contour finishing.

## What's Included

- **Box tube squaring macro**: Production-ready 445-line G-code operation
- **Safety validation**: Machine state, G55 setup, and homing checks
- **Temp file execution**: Smooth motion quality following best practices
- **Testing framework**: 3 passing tests for offline development
- **Mock Mach4 API**: Develop without machine access

## File Structure

```
src/
├── macros/m200.lua       # Box tube squaring macro (copy to Mach4)
├── tests/                           # Testing framework + 3 tests
└── research/                        # G-code research and source files
```

## Current Capabilities

### M200 Box Tube Squaring Macro
- **Material**: 1" x 1" aluminum box tubing
- **Tool**: 0.1575" flat end mill (T1)
- **Operation**: Multi-pass adaptive squaring with contour finish
- **Coordinate System**: G55 work coordinate
- **Execution**: Non-blocking temp file pattern (445 lines)
- **Safety**: Comprehensive machine state and setup validation

### Development Testing

```bash
cd src/tests
lua test_runner.lua
```

Runs 3 tests covering temp file execution, safety validation, and G-code handling.

## Safety Notes

- **Critical**: Properly set G55 work coordinate before operation
- **Tool required**: 0.1575" flat end mill must be installed as T1
- **Spindle speed**: 18,000 RPM (verify machine capability)
- **Material positioning**: Secure 1" x 1" box tube in fixture
- **Emergency stop**: Always accessible during operation

## Current Limitations & Future Development

### Current State (v1.0)
- ✅ **Fixed size**: Optimized for 1" x 1" box tubing only
- ✅ **Fixed length**: No length customization options
- ✅ **Single operation**: Squares one end only
- ✅ **G55 coordinate**: Uses specific work coordinate system

### Future Enhancements (Planned)
- 🔄 **Variable tube sizes**: Support different box tube dimensions
- 🔄 **Custom length**: User-defined tube length input
- 🔄 **Dual-end operation**: Flip and square both ends
- 🔄 **Dynamic work coordinates**: Flexible coordinate system setup
- 🔄 **UI interface**: Screen controls for parameters

## Troubleshooting

**"Unknown M Code"**: File must be named `m200.mcs` in correct macros folder  
**"Machine not ready"**: Enable machine and clear alarms  
**Wrong movement**: Check units (inches vs mm) and soft limits
