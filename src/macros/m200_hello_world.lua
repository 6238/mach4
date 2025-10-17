-- m200_aluminum_cutting.lua
-- Multi-pass aluminum box tubing end cutting macro for Mach4
-- Cuts 1" x 1" aluminum box tubing using variable feed rates for optimal performance

function m200()
    local inst = mc.mcGetInstance()
    
    -- Safety check - only accept state 200 (this machine's ready state)
    local state, rc = mc.mcCntlGetState(inst)
    if rc ~= 0 or state ~= 200 then
        wx.wxMessageBox(string.format("Machine is not ready (state = %d). Please enable and home the machine first.", state), "Error", wx.wxOK)
        return
    end
    
    -- Display operation confirmation
    local result = wx.wxMessageBox(
        "About to execute box tube end squaring operation:\n" ..
        "• Work coordinate: G55\n" ..
        "• Tool: T1 (0.1575\" flat end mill)\n" ..
        "• Spindle: 18,000 RPM\n" ..
        "• Multiple adaptive passes + contour finish\n" ..
        "• Non-blocking execution with 26 chunks\n\n" ..
        "Ensure material is properly secured and\n" ..
        "spindle is running at appropriate speed.\n\n" ..
        "Continue with squaring operation?",
        "Box Tube End Squaring Operation", 
        wx.wxYES_NO | wx.wxICON_QUESTION
    )
    
    if result ~= wx.wxYES then
        wx.wxMessageBox("Operation cancelled by user.", "Cancelled", wx.wxOK)
        return
    end
    
    -- Comprehensive safety validation
    if not validateG55Setup(inst) then
        return
    end
    
    if not validateMachineReadiness(inst) then
        return
    end
    
    -- Execute box tube squaring operation
    executeAluminumCutting(inst)
end

function executeAluminumCutting(inst)
    print("Starting box tube end squaring operation using chunked G-code execution")
    
    -- Break G-code into logical chunks for non-blocking execution
    local gcode_chunks = {
        -- Chunk 1: Setup and tool change
        [[G90 G94 G91.1 G40 G49 G17
G20
G28 G91 Z0.
G90
T1 M6
S18000 M3
G17 G90 G94
G55]],
        
        -- Chunk 2: First adaptive pass start
        [[G0 X1.1756 Y-0.1112
G0 Z1.25
Z1.14
Z0.4815
G1 Z0.4657 F75.
X1.1753 Y-0.111 Z0.4627
X1.1745 Y-0.1106 Z0.4597
X1.1733 Y-0.1098 Z0.457
X1.1716 Y-0.1088 Z0.4546
X1.1696 Y-0.1076 Z0.4527
X1.1672 Y-0.1062 Z0.4512
X1.1647 Y-0.1047 Z0.4503
X1.162 Y-0.1031 Z0.45]],
        
        -- Chunk 3: First adaptive arc and linear moves
        [[G3 X1.0789 Y-0.0787 I-0.0892 J-0.15
G1 X1.0708
X1.0693 Y-0.0788
X1.0647 Y-0.0827
X1.0606 Y-0.087
X1.0563 Y-0.0923
X1.0517 Y-0.099
X1.0468 Y-0.1077
X1.0416 Y-0.119
X1.0361 Y-0.1338
X1.0303 Y-0.1542]],
        
        -- Chunk 4: Continue first adaptive pass
        [[G1 X1.0248 Y-0.1823
X1.0201 Y-0.1958
X1.0119 Y-0.2076
X0.9914 Y-0.2275
X0.9661 Y-0.241
X0.9525 Y-0.2455
X0.9453 Y-0.2456
X0.9383 Y-0.2444
X0.9249 Y-0.2392
X0.9027 Y-0.2211]],
        
        -- Chunk 5: Complete first adaptive pass
        [[G1 X0.8874 Y-0.1969
X0.8774 Y-0.1701
X0.8708 Y-0.1422
X0.8666 Y-0.1138
X0.8664 Y-0.112
X0.8645 Y-0.1032
X0.8604 Y-0.0952
X0.8545 Y-0.0883
X0.8472 Y-0.0831
X0.8388 Y-0.0798
X0.8298 Y-0.0787]],
        
        -- Chunk 6: First adaptive retract and second pass setup
        [[G3 X0.816 Y-0.101 I0.0005 J-0.0157
G1 X0.8173 Y-0.1038 Z0.4503
X0.8185 Y-0.1065 Z0.4512
X0.8197 Y-0.109 Z0.4527
X0.8207 Y-0.1111 Z0.4546
X0.8215 Y-0.1129 Z0.457
X0.8221 Y-0.1142 Z0.4597
X0.8224 Y-0.1151 Z0.4627
X0.8226 Y-0.1153 Z0.4657
G0 Z1.14]],
        
        -- Chunk 7: Second adaptive pass setup
        [[G0 X1.114 Y-0.0955
Z0.4815
G1 Z0.4657 F75.
X1.1138 Y-0.0953 Z0.4627
X1.113 Y-0.0949 Z0.4597
X1.1118 Y-0.0941 Z0.457
X1.1101 Y-0.0931 Z0.4546
X1.108 Y-0.0919 Z0.4527
X1.1057 Y-0.0905 Z0.4512
X1.1031 Y-0.089 Z0.4503
X1.1005 Y-0.0875 Z0.45]],
        
        -- Chunk 8: Second adaptive arc and moves
        [[G3 X1.0708 Y-0.0787 I-0.0318 J-0.0536
G1 X1.05
X1.044 Y-0.079
X1.0383 Y-0.0809
X1.0329 Y-0.0834
X1.0277 Y-0.0864
X1.0227 Y-0.0898
X1.018 Y-0.0935
X1.0136 Y-0.0975
X1.0075 Y-0.1014]],
        
        -- Chunk 9: Continue second adaptive pass
        [[G1 X1.0009 Y-0.104
X0.9938 Y-0.1053
X0.9867 Y-0.1052
X0.9796 Y-0.1037
X0.9665 Y-0.098
X0.9557 Y-0.0882
X0.9483 Y-0.0831
X0.9399 Y-0.0798
X0.931 Y-0.0787]],
        
        -- Chunk 10: Second adaptive arcs
        [[G3 X0.9158 Y-0.095 Z0.458 I0.0005 J-0.0157
X0.9316 Y-0.1102 I0.0157 J0.0005
G1 X1.0495
G3 X1.0652 Y-0.095 I0. J0.0157
X1.05 Y-0.0787 Z0.45 I-0.0157 J0.0005
G1 X0.8776]],
        
        -- Chunk 11: Second adaptive retract
        [[G3 X0.8638 Y-0.101 I0.0005 J-0.0157
G1 X0.8651 Y-0.1038 Z0.4503
X0.8663 Y-0.1065 Z0.4512
X0.8674 Y-0.109 Z0.4527
X0.8684 Y-0.1111 Z0.4546
X0.8692 Y-0.1129 Z0.457
X0.8698 Y-0.1142 Z0.4597
X0.8702 Y-0.1151 Z0.4627
X0.8703 Y-0.1153 Z0.4657
G0 Z1.25]],
        
        -- Chunk 12: Third adaptive pass setup (deeper)
        [[G0 Z1.28
X1.1765 Y-0.1112
Z1.28
Z1.14
Z0.8665
G1 Z0.8507 F75.
X1.1762 Y-0.111 Z0.8477
X1.1755 Y-0.1106 Z0.8447
X1.1742 Y-0.1098 Z0.842
X1.1725 Y-0.1088 Z0.8396]],
        
        -- Chunk 13: Third adaptive pass continues (first section)
        [[G1 X1.1705 Y-0.1076 Z0.8377
X1.1681 Y-0.1062 Z0.8362
X1.1656 Y-0.1047 Z0.8353
X1.163 Y-0.1031 Z0.835
G3 X1.0799 Y-0.0787 I-0.0892 J-0.15
G1 X1.0718
X1.0703 Y-0.0788
X1.0656 Y-0.0825
X1.0613 Y-0.0868
X1.0572 Y-0.0918]],
        
        -- Chunk 14: Third adaptive pass (long cutting section)
        [[G1 X1.0526 Y-0.0983
X1.0478 Y-0.1066
X1.0426 Y-0.1173
X1.0371 Y-0.1314
X1.0314 Y-0.1505
X1.0255 Y-0.1785
X1.0222 Y-0.1924
X1.0147 Y-0.2046
X0.9951 Y-0.2255
X0.9702 Y-0.2397]],
        
        -- Chunk 15: Third adaptive pass (more cutting)
        [[G1 X0.9431 Y-0.249
X0.9151 Y-0.2551
X0.8867 Y-0.259
X0.8582 Y-0.2615
X0.8296 Y-0.2631
X0.801 Y-0.2641
X0.7723 Y-0.2647
X0.7437 Y-0.2651
X0.715 Y-0.2653
X0.6864 Y-0.2655]],
        
        -- Chunk 16: Third adaptive pass (final long cut)
        [[G1 X0.6291 Y-0.2656
X0.5145 Y-0.2657
X0.0704
X0.0566 Y-0.262
X0.0445 Y-0.2543
X0.0239 Y-0.2344
X0.0099 Y-0.2094
X0.0007 Y-0.1823
X-0.0053 Y-0.1543
X-0.0091 Y-0.1259]],
        
        -- Chunk 17: Third adaptive pass (final section)
        [[G1 X-0.0103 Y-0.1124
X-0.0122 Y-0.1035
X-0.0162 Y-0.0953
X-0.022 Y-0.0884
X-0.0294 Y-0.0832
X-0.0379 Y-0.0799
X-0.0469 Y-0.0787]],
        
        -- Chunk 18: Third adaptive retract
        [[G3 X-0.0607 Y-0.101 I0.0005 J-0.0157
G1 X-0.0594 Y-0.1038 Z0.8353
X-0.0582 Y-0.1065 Z0.8362
X-0.057 Y-0.109 Z0.8377
X-0.056 Y-0.1111 Z0.8396
X-0.0552 Y-0.1129 Z0.842
X-0.0546 Y-0.1142 Z0.8447
X-0.0543 Y-0.1151 Z0.8477
X-0.0541 Y-0.1153 Z0.8507
G0 Z1.14]],
        
        -- Chunk 19: Fourth adaptive section
        [[G0 X1.115 Y-0.0955
Z0.8665
G1 Z0.8507 F75.
X1.1147 Y-0.0953 Z0.8477
X1.1139 Y-0.0949 Z0.8447
X1.1127 Y-0.0941 Z0.842
X1.111 Y-0.0931 Z0.8396
X1.1089 Y-0.0919 Z0.8377
X1.1066 Y-0.0905 Z0.8362
X1.1041 Y-0.089 Z0.8353
X1.1014 Y-0.0875 Z0.835]],
        
        -- Chunk 20: Fourth adaptive cutting (long section)
        [[G3 X1.0718 Y-0.0787 I-0.0318 J-0.0536
G1 X1.0493
X1.0433 Y-0.079
X1.0378 Y-0.0815
X1.0326 Y-0.0844
X1.0271 Y-0.0881
X1.0213 Y-0.0928
X1.0154 Y-0.0983
X1.0089 Y-0.1056
X0.9915 Y-0.1284]],
        
        -- Chunk 21: Fourth adaptive extensive cutting
        [[G1 X0.9712 Y-0.1486
X0.9473 Y-0.1644
X0.9211 Y-0.176
X0.8937 Y-0.1844
X0.8657 Y-0.1903
X0.8373 Y-0.1943
X0.8088 Y-0.1971
X0.7802 Y-0.199
X0.7516 Y-0.2002
X0.7229 Y-0.2011]],
        
        -- Chunk 22: Fourth adaptive more cutting
        [[G1 X0.6943 Y-0.2017
X0.6657 Y-0.202
X0.637 Y-0.2023
X0.6084 Y-0.2024
X0.5511 Y-0.2026
X0.4651 Y-0.2027
X0.15 Y-0.2028
X0.1361 Y-0.1992
X0.1233 Y-0.1927
X0.1005 Y-0.1754]],
        
        -- Chunk 23: Fourth adaptive final section
        [[G1 X0.0837 Y-0.1522
X0.0704 Y-0.1268
X0.0587 Y-0.1043
X0.0536 Y-0.096
X0.0477 Y-0.0889
X0.0403 Y-0.0834
X0.0316 Y-0.0799
X0.0224 Y-0.0787
X0.0027]],
        
        -- Chunk 24: Fourth adaptive retract
        [[G3 X-0.0111 Y-0.101 I0.0005 J-0.0157
G1 X-0.0098 Y-0.1038 Z0.8353
X-0.0086 Y-0.1065 Z0.8362
X-0.0075 Y-0.109 Z0.8377
X-0.0065 Y-0.1111 Z0.8396
X-0.0057 Y-0.1129 Z0.842
X-0.0051 Y-0.1142 Z0.8447
X-0.0047 Y-0.1151 Z0.8477
X-0.0046 Y-0.1153 Z0.8507
G0 Z1.14]],
        
        -- Chunk 25: Final contour operation
        [[G0 Z1.6
X1.1 Y-0.3787
Z1.6
Z1.1
G1 Z1.09 F100.
Z0.56
G19 G3 Y-0.2787 Z0.46 J0.1 K0. F24.
G1 Y-0.1787
G17 G3 X1. Y-0.0787 I-0.1 J0.
G1 X0.
G3 X-0.1 Y-0.1787 I0. J-0.1
G1 Y-0.2787
G19 G2 Y-0.3787 Z0.56 J0. K0.1
G0 Z1.6
G17]],
        
        -- Chunk 26: Cleanup and shutdown
        [[M5
G28 G91 Z0.
G90
M30]]
    }
    
    -- Execute chunks with non-blocking timer-based monitoring
    executeGcodeChunks(gcode_chunks, function()
        wx.wxMessageBox("Box tube end squaring operation completed successfully!", "Success", wx.wxOK)
    end)
end

-- Non-blocking chunked G-code execution function
function executeGcodeChunks(gcode_chunks, completion_callback)
    local inst = mc.mcGetInstance()
    local current_chunk = 1
    local executing = false
    
    -- Create timer for non-blocking status monitoring
    local timerPanel = wx.wxPanel()
    local timer = wx.wxTimer(timerPanel)
    
    local function submitNextChunk()
        if current_chunk <= #gcode_chunks and not executing then
            executing = true
            
            print(string.format("Executing chunk %d of %d", current_chunk, #gcode_chunks))
            
            -- Submit chunk (non-blocking)
            local rc = mc.mcCntlGcodeExecute(inst, gcode_chunks[current_chunk])
            if rc ~= 0 then
                local error_msg, _ = mc.mcCntlGetErrorString(inst, rc)
                wx.wxMessageBox(string.format("G-code Error on chunk %d:\n%s", current_chunk, error_msg), "Error", wx.wxOK)
                return
            end
            
            current_chunk = current_chunk + 1
            timer:Start(100)  -- Check completion every 100ms
            
        elseif current_chunk > #gcode_chunks then
            -- All chunks complete
            print("All G-code chunks executed successfully")
            if completion_callback then
                completion_callback()
            end
        end
    end
    
    -- Timer callback for completion detection
    timerPanel:Connect(wx.wxEVT_TIMER, function()
        local inCycle, rc = mc.mcCntlIsInCycle(inst)
        local isStill, rc2 = mc.mcCntlIsStill(inst)
        
        -- Both conditions must be true for safe continuation
        if not inCycle and isStill then
            timer:Stop()
            executing = false
            
            -- Check for emergency stop before continuing
            local state, rc3 = mc.mcCntlGetState(inst)
            if state == 200 then  -- Machine ready state
                submitNextChunk()  -- Continue with next chunk
            else
                wx.wxMessageBox(string.format("Machine not ready (state = %d). Operation stopped.", state), "Machine State Error", wx.wxOK)
                return
            end
        end
        
        -- Allow UI to remain responsive
        wx.wxSafeYield()
    end)
    
    submitNextChunk()  -- Start the process
end


-- Validation function for G55 work coordinate system
function validateG55Setup(inst)
    -- Check if G55 work coordinate is properly set
    local g55_x, rc1 = mc.mcCntlGetPoundVar(inst, 5221)  -- G55 X offset
    local g55_y, rc2 = mc.mcCntlGetPoundVar(inst, 5222)  -- G55 Y offset
    local g55_z, rc3 = mc.mcCntlGetPoundVar(inst, 5223)  -- G55 Z offset
    
    if rc1 ~= 0 or rc2 ~= 0 or rc3 ~= 0 then
        wx.wxMessageBox("Unable to read G55 work coordinate offsets.\nPlease verify G55 is properly set.", "G55 Error", wx.wxOK)
        return false
    end
    
    print(string.format("G55 Work Coordinates: X=%.4f, Y=%.4f, Z=%.4f", g55_x, g55_y, g55_z))
    
    -- Warn if all offsets are zero (may indicate G55 not set)
    if g55_x == 0 and g55_y == 0 and g55_z == 0 then
        local result = wx.wxMessageBox(
            "G55 work coordinate offsets are all zero.\n" ..
            "This may indicate G55 has not been properly set.\n\n" ..
            "Continue anyway?",
            "G55 Warning",
            wx.wxYES_NO | wx.wxICON_WARNING
        )
        if result ~= wx.wxYES then
            return false
        end
    end
    
    return true
end


-- Enhanced machine readiness validation
function validateMachineReadiness(inst)
    -- Check machine state
    local state, rc = mc.mcCntlGetState(inst)
    if rc ~= 0 then
        wx.wxMessageBox("Unable to determine machine state.", "Machine State Error", wx.wxOK)
        return false
    end
    
    -- Verify machine is in proper state (200 = ready for this machine)
    if state ~= 200 then
        wx.wxMessageBox(string.format("Machine is not ready (state = %d).\nPlease enable and home the machine first.", state), "Machine Not Ready", wx.wxOK)
        return false
    end
    
    -- Check if axes are homed
    local x_homed, rc1 = mc.mcAxisIsHomed(inst, 0)  -- X axis
    local y_homed, rc2 = mc.mcAxisIsHomed(inst, 1)  -- Y axis
    local z_homed, rc3 = mc.mcAxisIsHomed(inst, 2)  -- Z axis
    
    if not (x_homed and y_homed and z_homed) then
        wx.wxMessageBox("Not all axes are homed.\nPlease home all axes before cutting.", "Homing Required", wx.wxOK)
        return false
    end
    
    -- Check feed hold state
    local in_feed_hold, rc5 = mc.mcCntlFeedHoldState(inst)
    if rc5 == 0 and in_feed_hold then
        wx.wxMessageBox("Machine is in feed hold state.\nPlease clear feed hold before starting.", "Feed Hold Active", wx.wxOK)
        return false
    end
    
    print("Machine readiness validation passed")
    return true
end

-- Allow running from editor
if (mc.mcInEditor() == 1) then
    m200()
end