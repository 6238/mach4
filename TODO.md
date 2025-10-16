# TODO

## YouTube Transcript Downloads

### Retry Failed Downloads (IP Blocked)
The following 10 videos from playlist PL7IitnI6IOQAUp6rOgtcQLwz7U8E4XHvq failed to download due to YouTube IP rate limiting. Retry these later (wait seve
al hours or use different IP):

1. `TMzAT0eb3p0` - https://www.youtube.com/watch?v=TMzAT0eb3p0
2. `QPHtXEufFwM` - https://www.youtube.com/watch?v=QPHtXEufFwM
3. `t2xQYvAXT8o` - https://www.youtube.com/watch?v=t2xQYvAXT8o
4. `_0WhzbFvoAM` - https://www.youtube.com/watch?v=_0WhzbFvoAM
5. `mZ7IAkK55pk` - https://www.youtube.com/watch?v=mZ7IAkK55pk
6. `wNPMqjkcJ_8` - https://www.youtube.com/watch?v=wNPMqjkcJ_8
7. `AthCnSaqV08` - https://www.youtube.com/watch?v=AthCnSaqV08
8. `eaYf73sQTDg` - https://www.youtube.com/watch?v=eaYf73sQTDg
9. `ry80BT3xGIo` - https://www.youtube.com/watch?v=ry80BT3xGIo
10. `ab6PXwBP62A` - https://www.youtube.com/watch?v=ab6PXwBP62A
11. `G85p1VsD3lk` - https://www.youtube.com/watch?v=G85p1VsD3lk

**Command to retry individually:**
```bash
source scripts/venv/bin/activate && python3 scripts/youtube_transcripts.py "VIDEO_URL"
```

# TODO - Mach4 Plugin Development

## ⏳ IMMEDIATE - Phase 1: Machine Validation

### Test Hello World Version on Hardware
- [ ] **Copy macro to machine**: `src/macros/m200_hello_world.lua` → Mach4 macros folder as `m200.mcs`
- [ ] **Test basic execution**: Run `M200` command and verify 2x2 inch square movement
- [ ] **Verify safety systems**: Test with machine disabled, verify error handling
- [ ] **Test custom UI**: Set up text field + button interface per `src/screens/UI_SETUP.md`
- [ ] **Document findings**: Note any Avid Benchtop Pro specific issues or requirements

**Success Criteria**: Hello World version executes safely on machine without errors

## 📋 NEXT - Phase 2: Real Application Features

### Replace Hello World with Production Logic
- [ ] **Update UI inputs**: 
  - Length input field
  - X offset input field  
  - Y offset input field
  - Remove "square size" concept
- [ ] **Create cutting G-code generation**:
  - Replace simple movement with actual cutting operations
  - Use length and offset inputs for real machining
  - Generate appropriate feeds, speeds, and toolpaths
- [ ] **Implement two-step process**:
  - Step 1: Execute first cutting operation
  - Auto-move to safe position (x=0, y=25)
  - Pause for operator intervention (flip part, re-extrude)
  - Step 2: Execute second cutting operation
- [ ] **Add progress feedback**: Status messages and progress indicators

### Enhanced Testing
- [ ] **Update test suite**: Modify tests for new inputs and cutting operations
- [ ] **Add cutting G-code tests**: Verify proper toolpath generation
- [ ] **Test two-step workflow**: Mock the pause/resume cycle

## 🚀 FUTURE - Phase 3: Advanced Features

### Polish and Enhancement
- [ ] **G-code preview**: Show toolpath before execution
- [ ] **Job management**: Save/load previous job parameters
- [ ] **Enhanced error recovery**: Better handling of interrupted operations
- [ ] **User documentation**: Complete setup and operation manual

## 🧪 ONGOING - Development Infrastructure

### Test Coverage Maintenance
- [ ] **Keep tests updated**: Maintain 100% test coverage as features are added
- [ ] **Performance testing**: Ensure G-code generation is fast enough for production
- [ ] **Safety validation**: Regular review of safety checks and error handling

### Code Quality
- [ ] **Code review**: Regular review of Lua code quality and patterns
- [ ] **Documentation**: Keep inline documentation updated
- [ ] **Refactoring**: Maintain clean, readable code structure

## 📚 RESEARCH - Advanced G-Code Generation (Desk Work)

### Separate Development Track (Offline)
- [ ] **Study cutting operations**: Research proper feeds, speeds, and toolpaths for material cutting
- [ ] **G-code pattern library**: Create reusable G-code generation modules
- [ ] **Advanced testing**: Build comprehensive G-code validation tools
- [ ] **Safety analysis**: Deep dive into CNC safety best practices

**Note**: This track can proceed in parallel with machine testing, using the established testing framework

## 🔄 BLOCKED/WAITING

### YouTube Transcript Downloads (IP Rate Limited)
The following videos failed to download due to YouTube IP blocking. Retry when IP block is lifted:

**Failed Video IDs**: TMzAT0eb3p0, QPHtXEufFwM, t2xQYvAXT8o, _0WhzbFvoAM, mZ7IAkK55pk, wNPMqjkcJ_8, AthCnSaqV08, eaYf73sQTDg, ry80BT3xGIo, ab6PXwBP62A, G85p1VsD3lk

**Retry Command**:
```bash
source scripts/venv/bin/activate
for vid in TMzAT0eb3p0 QPHtXEufFwM t2xQYvAXT8o _0WhzbFvoAM mZ7IAkK55pk wNPMqjkcJ_8 AthCnSaqV08 eaYf73sQTDg ry80BT3xGIo ab6PXwBP62A G85p1VsD3lk; do
  python3 scripts/youtube_transcripts.py "https://www.youtube.com/watch?v=$vid"
  sleep 10  # Add delay between requests
done
```

## ✅ COMPLETED

### Hello World Version (Session Complete)
- [x] Custom Lua testing framework for offline development
- [x] Mock Mach4 API layer for testing without machine
- [x] Simple macro with 2x2 inch square movement
- [x] Custom UI with text input and button
- [x] Complete safety validation and error handling
- [x] 9 passing tests with full coverage
- [x] Documentation cleanup and consolidation

### Research Foundation
- [x] Mach4 plugin development research
- [x] Lua scripting capabilities analysis
- [x] Screen Editor and UI development understanding
- [x] PDF documentation conversion and analysis
- [x] YouTube transcript collection (partial - 11 videos blocked)

## 🎯 SUCCESS METRICS

**Phase 1 Success**: Hello World macro runs safely on Avid Benchtop Pro
**Phase 2 Success**: Two-step cutting process works with real material
**Phase 3 Success**: Production-ready plugin with enhanced features

**Quality Goals**: 
- Maintain 100% test coverage
- Zero safety incidents during development
- Clean, maintainable code structure
- Comprehensive documentation
