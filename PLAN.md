# Mach4 CNC Plugin Development Plan

## Project Objective
Create a Mach4 plugin for Avid Benchtop Pro CNC that accepts user inputs and generates/executes G-code for a two-step cutting process with operator intervention.

## Current Status: ✅ Hello World Version Complete

### ✅ Completed Research Phase
**Key Findings:**
- Mach4 uses Lua scripting as primary development language
- Screen Editor (.set files) for custom UI development
- Macros (m###.mcs) for G-code generation and execution
- Registers for data persistence between operations

### ✅ Completed Implementation - Hello World Version
**What's Working:**
- **Testing Framework**: Custom Lua test suite with mock Mach4 API for offline development
- **Basic Macro**: Simple 2x2 inch square movement (`m200_hello_world.lua`)
- **Custom UI**: Text input + button with validation and safety checks
- **Safety Systems**: Machine state verification, input validation, error handling
- **9 Passing Tests**: Complete test coverage of core functionality

**Proven Integration:**
- ✅ Lua scripting works with Mach4
- ✅ G-code generation and execution
- ✅ Custom UI integration via Screen Editor
- ✅ Offline development and testing capability

## Project Requirements (Clarified)

### User Inputs (Simple)
- **Length**: Size of the part/operation
- **X/Y Position**: Work offset for part location

### Two-Step Process
1. **Step 1**: Execute first cutting operation
2. **Automatic Move**: Tool moves to safe position (x=0, y=25)
3. **Operator Intervention**: Reach in, flip part, re-extrude
4. **Step 2**: Execute second cutting operation

### Target Hardware
- **Machine**: Avid Benchtop Pro CNC
- **Operation**: 3-axis mill only (no rotary, no plasma)

## Next Development Phases

### Phase 1: Machine Validation ⏳ CURRENT
**Goal**: Verify Hello World version works on actual hardware
**Tasks**:
- [ ] Test basic macro (`M200`) on Avid Benchtop Pro
- [ ] Verify G-code execution and safety systems
- [ ] Test custom UI integration
- [ ] Document any machine-specific issues

### Phase 2: Real Application Features
**Goal**: Replace Hello World with actual application logic
**Tasks**:
- [ ] Add real user inputs (length, X offset, Y offset)
- [ ] Replace square movement with actual cutting G-code
- [ ] Implement two-step process with pause/resume
- [ ] Add progress feedback and status display

### Phase 3: Advanced Features
**Goal**: Polish and enhance the working application
**Tasks**:
- [ ] Add G-code preview capability
- [ ] Implement job history and recall
- [ ] Enhanced error handling and recovery
- [ ] User manual and documentation

## Architecture Decisions Made

### Technology Stack
- **Primary Language**: Lua (Mach4 native)
- **UI Framework**: Mach4 Screen Editor (.set files)
- **Data Storage**: Mach4 registers
- **Testing**: Custom Lua framework with mock API

### File Structure
```
src/
├── macros/           # M-code macros for G-code execution
├── screens/          # UI components and setup instructions
└── tests/            # Testing framework and test suite
```

### Development Workflow
1. **Test-Driven**: Write tests first, implement functionality
2. **Offline-First**: Develop without machine using mock API
3. **Incremental**: Small, validated changes
4. **Safety-First**: Comprehensive validation at every step

## Success Criteria

### Hello World (✅ Complete)
- [x] Basic G-code generation and execution
- [x] Custom UI integration
- [x] Safety checks and error handling
- [x] Offline testing capability

### Production Version (Next)
- [ ] Real cutting operations (not just movement)
- [ ] Two-step process with operator intervention
- [ ] Machine-specific validation on Avid Benchtop Pro
- [ ] User-friendly interface with proper inputs

## Risk Mitigation

### Proven Solutions
- **Integration Risk**: ✅ Solved with Hello World version
- **Testing Without Machine**: ✅ Mock API enables offline development
- **Lua Learning Curve**: ✅ Test framework provides examples and patterns
- **Safety Concerns**: ✅ Multi-layer validation and machine state checking

### Remaining Risks
- **Machine-Specific Issues**: Will be discovered during Phase 1 testing
- **G-code Complexity**: Mitigated by incremental development approach
- **User Interface Complexity**: Keep simple, expand gradually

## Notes
- Hello World approach proved successful for rapid validation
- Testing framework provides confidence for complex feature development
- Clear separation between logic and UI enables parallel development
- Ready to move from proof-of-concept to production implementation