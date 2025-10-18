# TODO - Mach4 Box Tube Squaring Plugin

## ✅ COMPLETED (v1.0)

### Core Functionality Complete
- **M200 Macro**: Production-ready box tube squaring operation
- **Fixed 1x1 Operation**: Optimized for 1" x 1" aluminum box tubing
- **Safety Systems**: Machine state validation, G55 setup checks, homing verification
- **Temp File Execution**: 445-line G-code using best practices for smooth motion
- **Testing Framework**: 3 comprehensive tests covering execution and validation

## 🚀 NEXT PHASE - Parameterization & Flexibility

### High Priority - Core Enhancements
- [ ] **Automate tube flip**: Pause the script after cutting half, prompt the user to flip, and then cut the second half
- [ ] **Variable Tube Sizes**: Add support for different box tube dimensions (2" x 1")
- [ ] **Custom Length Input**: Allow user to specify tube length for operation planning
- [ ] **Dual-End Operation**: Cut tube to length and square both ends

### Medium Priority - Operation Enhancements  
- [ ] **Add UI for hole patterns **: Allow operator to specify whole patterns, and then script will cut those whole patterns.


## 📋 DEVELOPMENT NOTES

### Current Architecture
- **Single G-code String**: Complete 445-line program stored as string for easy verification
- **Temp File Pattern**: Following GCODE_EXECUTION_BEST_PRACTICES for >200 line programs
- **Integrated Cleanup**: No separate PLC scripts needed
- **G55 Coordinate System**: Hard-coded but easily parameterizable

### Implementation Strategy for Next Phase
1. **Start with tube size parameterization** - most impactful change
2. **Extract G-code generation logic** - separate from execution logic
3. **Create parameter validation** - ensure safe operation limits
4. **Maintain testing coverage** - add tests for new functionality
