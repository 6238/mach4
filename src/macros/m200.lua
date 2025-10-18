-- m200_aluminum_cutting.lua
-- Multi-pass aluminum box tubing end cutting macro for Mach4
-- Cuts 1" x 1" aluminum box tubing using variable feed rates for optimal performance
-- 
-- UPPER/LOWER HALF OPERATION: This macro performs cutting operations on both the upper
-- and lower halves of a single box tube end, with a material flip operation between cuts.
--
-- MOTION EXECUTION: Uses non-blocking G-code execution with polling for safe positioning
-- moves to maintain UI responsiveness, following Mach4 best practices.

function m200()
    local inst = mc.mcGetInstance()
    
    -- Safety check - only accept state 200 (this machine's ready state)
    local state, rc = mc.mcCntlGetState(inst)
    if rc ~= 0 or state ~= 200 then
        wx.wxMessageBox(string.format("Machine is not ready (state = %d). Please enable and home the machine first.", state), "Error", wx.wxOK)
        return
    end
    
    -- Display upper/lower half cutting operation confirmation
    local result = wx.wxMessageBox(
        "About to execute UPPER/LOWER HALF box tube end squaring:\n" ..
        "• Work coordinate: G55\n" ..
        "• Tool: T1 (0.1575\" flat end mill)\n" ..
        "• Spindle: 18,000 RPM\n" ..
        "• Multiple adaptive passes + contour finish\n" ..
        "• TWO cutting operations with material flip\n\n" ..
        "This process will:\n" ..
        "1. Cut upper half of tube end\n" ..
        "2. Move machine to safe position\n" ..
        "3. Prompt to flip material 180°\n" ..
        "4. Cut lower half of same tube end\n\n" ..
        "Continue with upper/lower half squaring operation?",
        "Upper/Lower Half Box Tube End Squaring", 
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
    
    -- Step 1: Prompt user for initial material positioning
    if not promptUserForMaterialPositioning() then
        return
    end
    
    -- Step 2: Execute upper half cutting operation with G52 local coordinate offset
    executeAluminumCutting(inst, 0, 0.125, "upper half cutting")
    
    -- Step 3: Move machine to safe position for material flip
    if not moveMachineToSafePosition(inst) then
        return
    end
    
    -- Step 4: Prompt user to flip material
    if not promptUserForMaterialFlip() then
        return
    end
    
    -- Step 5: Return to work coordinate origin and execute lower half cutting operation
    if not returnToWorkOrigin(inst) then
        return
    end
    
    executeAluminumCutting(inst, 0, 0, "lower half cutting")
    
    wx.wxMessageBox("Upper/lower half box tube end squaring completed successfully!\nBoth halves of the tube end have been squared.", "Operation Complete", wx.wxOK)
end

function executeAluminumCutting(inst, g52_x_offset, g52_y_offset, operation_description)
    g52_x_offset = g52_x_offset or 0
    g52_y_offset = g52_y_offset or 0
    operation_description = operation_description or "box tube end squaring"
    
    print(string.format("Starting %s operation using temp file (445 lines > 200 threshold)", operation_description))
    print(string.format("Using G52 local coordinate offset: X%.3f Y%.3f", g52_x_offset, g52_y_offset))
    
    -- Complete G-code program with G52 local coordinate system management
    -- Following G52 safety practices: clear before, set offset, clear after
    local g52_setup = string.format("G52 X%.3f Y%.3f", g52_x_offset, g52_y_offset)
    local gcode_program = [[G90 G94 G91.1 G40 G49 G17
G20
G28 G91 Z0.
G90

T1 M6
S18000 M3
G17 G90 G94
G55
G52 X0 Y0 Z0
]] .. g52_setup .. [[
G0 X1.1756 Y-0.1112
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
X1.162 Y-0.1031 Z0.45
G3 X1.0789 Y-0.0787 I-0.0892 J-0.15
G1 X1.0708
X1.0693 Y-0.0788
X1.0647 Y-0.0827
X1.0606 Y-0.087
X1.0563 Y-0.0923
X1.0517 Y-0.099
X1.0468 Y-0.1077
X1.0416 Y-0.119
X1.0361 Y-0.1338
X1.0303 Y-0.1542
X1.0248 Y-0.1823
X1.0201 Y-0.1958
X1.0119 Y-0.2076
X0.9914 Y-0.2275
X0.9661 Y-0.241
X0.9525 Y-0.2455
X0.9453 Y-0.2456
X0.9383 Y-0.2444
X0.9249 Y-0.2392
X0.9027 Y-0.2211
X0.8874 Y-0.1969
X0.8774 Y-0.1701
X0.8708 Y-0.1422
X0.8666 Y-0.1138
X0.8664 Y-0.112
X0.8645 Y-0.1032
X0.8604 Y-0.0952
X0.8545 Y-0.0883
X0.8472 Y-0.0831
X0.8388 Y-0.0798
X0.8298 Y-0.0787
G3 X0.816 Y-0.101 I0.0005 J-0.0157
G1 X0.8173 Y-0.1038 Z0.4503
X0.8185 Y-0.1065 Z0.4512
X0.8197 Y-0.109 Z0.4527
X0.8207 Y-0.1111 Z0.4546
X0.8215 Y-0.1129 Z0.457
X0.8221 Y-0.1142 Z0.4597
X0.8224 Y-0.1151 Z0.4627
X0.8226 Y-0.1153 Z0.4657
G0 Z1.14
X1.114 Y-0.0955
Z0.4815
G1 Z0.4657 F75.
X1.1138 Y-0.0953 Z0.4627
X1.113 Y-0.0949 Z0.4597
X1.1118 Y-0.0941 Z0.457
X1.1101 Y-0.0931 Z0.4546
X1.108 Y-0.0919 Z0.4527
X1.1057 Y-0.0905 Z0.4512
X1.1031 Y-0.089 Z0.4503
X1.1005 Y-0.0875 Z0.45
G3 X1.0708 Y-0.0787 I-0.0318 J-0.0536
G1 X1.05
X1.044 Y-0.079
X1.0383 Y-0.0809
X1.0329 Y-0.0834
X1.0277 Y-0.0864
X1.0227 Y-0.0898
X1.018 Y-0.0935
X1.0136 Y-0.0975
X1.0075 Y-0.1014
X1.0009 Y-0.104
X0.9938 Y-0.1053
X0.9867 Y-0.1052
X0.9796 Y-0.1037
X0.9665 Y-0.098
X0.9557 Y-0.0882
X0.9483 Y-0.0831
X0.9399 Y-0.0798
X0.931 Y-0.0787
G3 X0.9158 Y-0.095 Z0.458 I0.0005 J-0.0157
X0.9316 Y-0.1102 I0.0157 J0.0005
G1 X1.0495
G3 X1.0652 Y-0.095 I0. J0.0157
X1.05 Y-0.0787 Z0.45 I-0.0157 J0.0005
G1 X0.8776
G3 X0.8638 Y-0.101 I0.0005 J-0.0157
G1 X0.8651 Y-0.1038 Z0.4503
X0.8663 Y-0.1065 Z0.4512
X0.8674 Y-0.109 Z0.4527
X0.8684 Y-0.1111 Z0.4546
X0.8692 Y-0.1129 Z0.457
X0.8698 Y-0.1142 Z0.4597
X0.8702 Y-0.1151 Z0.4627
X0.8703 Y-0.1153 Z0.4657
G0 Z1.25

G0 Z1.28
X1.1765 Y-0.1112
Z1.28
Z1.14
Z0.8665
G1 Z0.8507 F75.
X1.1762 Y-0.111 Z0.8477
X1.1755 Y-0.1106 Z0.8447
X1.1742 Y-0.1098 Z0.842
X1.1725 Y-0.1088 Z0.8396
X1.1705 Y-0.1076 Z0.8377
X1.1681 Y-0.1062 Z0.8362
X1.1656 Y-0.1047 Z0.8353
X1.163 Y-0.1031 Z0.835
G3 X1.0799 Y-0.0787 I-0.0892 J-0.15
G1 X1.0718
X1.0703 Y-0.0788
X1.0656 Y-0.0825
X1.0613 Y-0.0868
X1.0572 Y-0.0918
X1.0526 Y-0.0983
X1.0478 Y-0.1066
X1.0426 Y-0.1173
X1.0371 Y-0.1314
X1.0314 Y-0.1505
X1.0255 Y-0.1785
X1.0222 Y-0.1924
X1.0147 Y-0.2046
X0.9951 Y-0.2255
X0.9702 Y-0.2397
X0.9431 Y-0.249
X0.9151 Y-0.2551
X0.8867 Y-0.259
X0.8582 Y-0.2615
X0.8296 Y-0.2631
X0.801 Y-0.2641
X0.7723 Y-0.2647
X0.7437 Y-0.2651
X0.715 Y-0.2653
X0.6864 Y-0.2655
X0.6291 Y-0.2656
X0.5145 Y-0.2657
X0.0704
X0.0566 Y-0.262
X0.0445 Y-0.2543
X0.0239 Y-0.2344
X0.0099 Y-0.2094
X0.0007 Y-0.1823
X-0.0053 Y-0.1543
X-0.0091 Y-0.1259
X-0.0103 Y-0.1124
X-0.0122 Y-0.1035
X-0.0162 Y-0.0953
X-0.022 Y-0.0884
X-0.0294 Y-0.0832
X-0.0379 Y-0.0799
X-0.0469 Y-0.0787
G3 X-0.0607 Y-0.101 I0.0005 J-0.0157
G1 X-0.0594 Y-0.1038 Z0.8353
X-0.0582 Y-0.1065 Z0.8362
X-0.057 Y-0.109 Z0.8377
X-0.056 Y-0.1111 Z0.8396
X-0.0552 Y-0.1129 Z0.842
X-0.0546 Y-0.1142 Z0.8447
X-0.0543 Y-0.1151 Z0.8477
X-0.0541 Y-0.1153 Z0.8507
G0 Z1.14
X1.115 Y-0.0955
Z0.8665
G1 Z0.8507 F75.
X1.1147 Y-0.0953 Z0.8477
X1.1139 Y-0.0949 Z0.8447
X1.1127 Y-0.0941 Z0.842
X1.111 Y-0.0931 Z0.8396
X1.1089 Y-0.0919 Z0.8377
X1.1066 Y-0.0905 Z0.8362
X1.1041 Y-0.089 Z0.8353
X1.1014 Y-0.0875 Z0.835
G3 X1.0718 Y-0.0787 I-0.0318 J-0.0536
G1 X1.0493
X1.0433 Y-0.079
X1.0378 Y-0.0815
X1.0326 Y-0.0844
X1.0271 Y-0.0881
X1.0213 Y-0.0928
X1.0154 Y-0.0983
X1.0089 Y-0.1056
X0.9915 Y-0.1284
X0.9712 Y-0.1486
X0.9473 Y-0.1644
X0.9211 Y-0.176
X0.8937 Y-0.1844
X0.8657 Y-0.1903
X0.8373 Y-0.1943
X0.8088 Y-0.1971
X0.7802 Y-0.199
X0.7516 Y-0.2002
X0.7229 Y-0.2011
X0.6943 Y-0.2017
X0.6657 Y-0.202
X0.637 Y-0.2023
X0.6084 Y-0.2024
X0.5511 Y-0.2026
X0.4651 Y-0.2027
X0.15 Y-0.2028
X0.1361 Y-0.1992
X0.1233 Y-0.1927
X0.1005 Y-0.1754
X0.0837 Y-0.1522
X0.0704 Y-0.1268
X0.0587 Y-0.1043
X0.0536 Y-0.096
X0.0477 Y-0.0889
X0.0403 Y-0.0834
X0.0316 Y-0.0799
X0.0224 Y-0.0787
X0.0027
G3 X-0.0111 Y-0.101 I0.0005 J-0.0157
G1 X-0.0098 Y-0.1038 Z0.8353
X-0.0086 Y-0.1065 Z0.8362
X-0.0075 Y-0.109 Z0.8377
X-0.0065 Y-0.1111 Z0.8396
X-0.0057 Y-0.1129 Z0.842
X-0.0051 Y-0.1142 Z0.8447
X-0.0047 Y-0.1151 Z0.8477
X-0.0046 Y-0.1153 Z0.8507
G0 Z1.14
X1.0925 Y-0.0955
Z0.8665
G1 Z0.8507 F75.
X1.0923 Y-0.0953 Z0.8477
X1.0915 Y-0.0949 Z0.8447
X1.0902 Y-0.0941 Z0.842
X1.0886 Y-0.0931 Z0.8396
X1.0865 Y-0.0919 Z0.8377
X1.0842 Y-0.0905 Z0.8362
X1.0816 Y-0.089 Z0.8353
X1.079 Y-0.0875 Z0.835
G3 X1.0493 Y-0.0787 I-0.0318 J-0.0536
G1 X1.0168
X1.0108 Y-0.079
X1.0032 Y-0.0803
X0.9896 Y-0.0838
X0.9625 Y-0.093
X0.9356 Y-0.1029
X0.9083 Y-0.1117
X0.8806 Y-0.1189
X0.8525 Y-0.1245
X0.8242 Y-0.1288
X0.7957 Y-0.1319
X0.7672 Y-0.1342
X0.7386 Y-0.1359
X0.7099 Y-0.1371
X0.6813 Y-0.1379
X0.6527 Y-0.1385
X0.624 Y-0.1389
X0.5954 Y-0.1392
X0.5667 Y-0.1394
X0.5381 Y-0.1395
X0.4808 Y-0.1396
X0.3662 Y-0.1397
X0.2229 Y-0.1398
X0.1948 Y-0.1343
X0.17 Y-0.1199
X0.1484 Y-0.1011
X0.1371 Y-0.0896
X0.1295 Y-0.0837
X0.1205 Y-0.08
X0.111 Y-0.0787
X0.0224
G3 X0.0086 Y-0.101 I0.0005 J-0.0157
G1 X0.0099 Y-0.1038 Z0.8353
X0.0111 Y-0.1065 Z0.8362
X0.0123 Y-0.109 Z0.8377
X0.0133 Y-0.1111 Z0.8396
X0.0141 Y-0.1129 Z0.842
X0.0147 Y-0.1142 Z0.8447
X0.0151 Y-0.1151 Z0.8477
X0.0152 Y-0.1153 Z0.8507
G0 Z1.14
X1.06 Y-0.0955
Z0.8665
G1 Z0.8507 F75.
X1.0598 Y-0.0953 Z0.8477
X1.059 Y-0.0949 Z0.8447
X1.0577 Y-0.0941 Z0.842
X1.0561 Y-0.0931 Z0.8396
X1.054 Y-0.0919 Z0.8377
X1.0517 Y-0.0905 Z0.8362
X1.0491 Y-0.089 Z0.8353
X1.0465 Y-0.0875 Z0.835
G3 X1.0168 Y-0.0787 I-0.0318 J-0.0536
G1 X0.111
G3 X0.0972 Y-0.101 I0.0005 J-0.0157
G1 X0.0985 Y-0.1038 Z0.8353
X0.0997 Y-0.1065 Z0.8362
X0.1008 Y-0.109 Z0.8377
X0.1018 Y-0.1111 Z0.8396
X0.1026 Y-0.1129 Z0.842
X0.1032 Y-0.1142 Z0.8447
X0.1036 Y-0.1151 Z0.8477
X0.1037 Y-0.1153 Z0.8507
G0 Z1.28

G0 X0.3012 Y-0.1112
Z1.24
Z1.14
Z0.4915
G1 Z0.4757 F75.
X0.301 Y-0.111 Z0.4727
X0.3002 Y-0.1106 Z0.4697
X0.299 Y-0.1098 Z0.467
X0.2973 Y-0.1088 Z0.4646
X0.2952 Y-0.1076 Z0.4627
X0.2929 Y-0.1062 Z0.4612
X0.2903 Y-0.1047 Z0.4603
X0.2877 Y-0.1031 Z0.46
G3 X0.2046 Y-0.0787 I-0.0892 J-0.15
G1 X0.1968
X0.1953 Y-0.0788
X0.1906 Y-0.0825
X0.1863 Y-0.0868
X0.1822 Y-0.0918
X0.1777 Y-0.0983
X0.1728 Y-0.1066
X0.1676 Y-0.1172
X0.1622 Y-0.1313
X0.1565 Y-0.1503
X0.1505 Y-0.1784
X0.1473 Y-0.1923
X0.1398 Y-0.2046
X0.1202 Y-0.2254
X0.0953 Y-0.2396
X0.0818 Y-0.2443
X0.0749 Y-0.2463
X0.0678 Y-0.2468
X0.0606 Y-0.246
X0.0538 Y-0.2438
X0.0413 Y-0.2368
X0.0217 Y-0.2159
X0.0085 Y-0.1905
X-0.0003 Y-0.1632
X-0.0059 Y-0.1351
X-0.009 Y-0.1109
X-0.0111 Y-0.1023
X-0.0153 Y-0.0945
X-0.0211 Y-0.0879
X-0.0284 Y-0.0829
X-0.0367 Y-0.0798
X-0.0454 Y-0.0787
G3 X-0.0592 Y-0.101 I0.0005 J-0.0157
G1 X-0.0579 Y-0.1038 Z0.4603
X-0.0567 Y-0.1065 Z0.4612
X-0.0556 Y-0.109 Z0.4627
X-0.0546 Y-0.1111 Z0.4646
X-0.0538 Y-0.1129 Z0.467
X-0.0532 Y-0.1142 Z0.4697
X-0.0528 Y-0.1151 Z0.4727
X-0.0527 Y-0.1153 Z0.4757
G0 Z1.14
X0.24 Y-0.0955
Z0.4915
G1 Z0.4757 F75.
X0.2397 Y-0.0953 Z0.4727
X0.239 Y-0.0949 Z0.4697
X0.2377 Y-0.0941 Z0.467
X0.236 Y-0.0931 Z0.4646
X0.234 Y-0.0919 Z0.4627
X0.2316 Y-0.0905 Z0.4612
X0.2291 Y-0.089 Z0.4603
X0.2265 Y-0.0875 Z0.46
G3 X0.1968 Y-0.0787 I-0.0318 J-0.0536
G1 X0.1737
X0.1677 Y-0.079
X0.1621 Y-0.0811
X0.1567 Y-0.0838
X0.1516 Y-0.0869
X0.1467 Y-0.0904
X0.1421 Y-0.0942
X0.1377 Y-0.0983
X0.1317 Y-0.1022
X0.1251 Y-0.105
X0.1181 Y-0.1064
X0.1109
X0.1039 Y-0.105
X0.0973 Y-0.1023
X0.0733 Y-0.0866
X0.0678 Y-0.0823
X0.0614 Y-0.0797
X0.0544 Y-0.0787
G3 X0.0392 Y-0.095 Z0.468 I0.0005 J-0.0157
X0.055 Y-0.1102 I0.0157 J0.0005
G1 X0.1732
G3 X0.1889 Y-0.095 I0. J0.0157
X0.1737 Y-0.0787 Z0.46 I-0.0157 J0.0005
G1 X0.0019
G3 X-0.0118 Y-0.101 I0.0005 J-0.0157
G1 X-0.0106 Y-0.1038 Z0.4603
X-0.0093 Y-0.1065 Z0.4612
X-0.0082 Y-0.109 Z0.4627
X-0.0072 Y-0.1111 Z0.4646
X-0.0064 Y-0.1129 Z0.467
X-0.0058 Y-0.1142 Z0.4697
X-0.0054 Y-0.1151 Z0.4727
X-0.0053 Y-0.1153 Z0.4757
G0 Z1.24

G0 Z1.6
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
G17

M5
G28 G91 Z0.
G90
G52 X0 Y0 Z0
M30]]

    -- Create temp file and execute using file-based pattern (>200 lines)
    local tempPath = makeTempGcodeFile("BoxTube_", gcode_program)
    runTempGcodeFile(tempPath)
end

-- Temp file helpers following GCODE_EXECUTION_BEST_PRACTICES (Pattern C)

-- Create a temporary G-code file
function makeTempGcodeFile(prefix, gcode_text)
    local std = wx.wxStandardPaths.Get()
    local tempDir = std:GetTempDir()

    -- Create a unique temp file path (empty file gets created)
    local tempPath = wx.wxFileName.CreateTempFileName(prefix or "Mach4_")

    -- Sanity check the directory and file
    if (not tempPath) or (tempPath == "") then
        error("Failed to create a temp file name in: " .. tostring(tempDir))
    end

    -- Write G-code in binary to avoid newline surprises
    local f, err = io.open(tempPath, "wb")
    if not f then
        error("Unable to open temp file for write: " .. tostring(err))
    end
    f:write(gcode_text)
    f:close()

    print(string.format("Created temp G-code file: %s", tempPath))
    return tempPath
end

-- Run a temp G-code file, wait for completion, and clean up
function runTempGcodeFile(tempPath)
    local inst = mc.mcGetInstance()

    -- Load + start
    local rc1 = mc.mcCntlLoadGcodeFile(inst, tempPath)
    if rc1 ~= 0 then
        wx.wxRemoveFile(tempPath)  -- best effort cleanup
        local error_msg, _ = mc.mcCntlGetErrorString(inst, rc1)
        wx.wxMessageBox(string.format("Failed to load G-code file:\n%s", error_msg), "File Load Error", wx.wxOK)
        return
    end
    
    mc.mcCntlCycleStart(inst)
    print("Started G-code file execution - waiting for completion...")
    
    -- Wait for motion to complete (following runAndWait pattern from best practices)
    while mc.mcCntlIsInCycle(inst) do
        wx.wxMilliSleep(20)  -- yield time; don't starve UI/PLC
    end
    
    -- Optional: ensure all axes stopped  
    for a=0,5 do
        if mc.mcAxisIsStill(inst, a) == 0 then
            wx.wxMilliSleep(10)
        end
    end
    
    print("G-code execution completed - cleaning up temp file")
    
    -- Close the file so Windows releases the handle
    mc.mcCntlCloseGcodeFile(inst)
    
    -- A tiny delay helps on some systems before removing the file
    wx.wxMilliSleep(10)
    
    -- Clean up the temp file
    wx.wxRemoveFile(tempPath)
    print("Temp file cleaned up: " .. tempPath)
    
    -- Show completion message
    wx.wxMessageBox("Box tube end squaring operation completed successfully!", "Operation Complete", wx.wxOK)
end


-- Upper/lower half cutting operation helper functions

-- Execute G-code with non-blocking pattern and polling
-- This helper function eliminates duplication in movement operations
-- @param inst: Mach4 instance
-- @param gcode: G-code string to execute (can be multi-line)
-- @param description: Description of the operation for error messages
-- @param axes_to_check: Array of axis indices to check for stillness (e.g., {0,1,2} for X,Y,Z)
-- @return: true on success, false on error
function executeGcodeWithPolling(inst, gcode, description, axes_to_check)
    -- Submit G-code non-blocking to keep UI responsive
    local rc = mc.mcCntlGcodeExecute(inst, gcode)
    if rc ~= mc.MERROR_NOERROR then
        local error_msg, _ = mc.mcCntlGetErrorString(inst, rc)
        wx.wxMessageBox(string.format("Failed to submit %s:\n%s", description, error_msg), "Movement Error", wx.wxOK)
        return false
    end
    
    -- Poll until motion completes (keeps UI responsive)
    while mc.mcCntlIsInCycle(inst) do
        wx.wxMilliSleep(20)  -- Yield time to prevent UI freezing
    end
    
    -- Optional: ensure specified axes are stopped
    if axes_to_check then
        for _, axis in ipairs(axes_to_check) do
            local still, _ = mc.mcAxisIsStill(inst, axis)
            if not still then
                wx.wxMilliSleep(10)
            end
        end
    end
    
    return true
end

-- Prompt user for initial material positioning
function promptUserForMaterialPositioning()
    local result = wx.wxMessageBox(
        "MATERIAL POSITIONING - UPPER HALF\n\n" ..
        "Please position the box tube for UPPER HALF cutting:\n\n" ..
        "1. Secure material in vise or clamping system\n" ..
        "2. Ensure tube end is positioned at G55 origin\n" ..
        "3. Orient tube so UPPER HALF will be cut first\n" ..
        "4. Verify tool clearance and spindle is running\n\n" ..
        "Click OK when material is properly positioned and secured.",
        "Position Material - Upper Half",
        wx.wxOK | wx.wxCANCEL | wx.wxICON_INFORMATION
    )
    
    if result ~= wx.wxOK then
        wx.wxMessageBox("Operation cancelled by user.", "Cancelled", wx.wxOK)
        return false
    end
    
    return true
end

-- Move machine to safe position for material flip
function moveMachineToSafePosition(inst)
    print("Moving machine to safe position: Z=-0.5, then X=0.5, Y=23.5 at 150 IPM")
    
    -- Build safe positioning move sequence using machine coordinates (G53)
    -- Move Z first for safety, then XY at specified feed rate
    local safe_move_gcode = table.concat({
        "G90",                    -- Absolute positioning
        "G53",                    -- Machine coordinate system
        "G0 Z-0.5",              -- Move Z to safe height first
        "G1 X0.5 Y23.5 F150"     -- Move XY to safe position at 150 IPM
    }, "\n")
    
    -- Execute using helper function with non-blocking pattern
    local success = executeGcodeWithPolling(inst, safe_move_gcode, "safe position move", {0, 1, 2})  -- Check X, Y, Z axes
    
    if success then
        print("Machine successfully positioned at safe location")
    end
    
    return success
end

-- Prompt user to flip material
function promptUserForMaterialFlip()
    local result = wx.wxMessageBox(
        "MATERIAL FLIP REQUIRED\n\n" ..
        "The machine is now at a safe position.\n\n" ..
        "Please flip the material to cut the LOWER HALF:\n\n" ..
        "1. Carefully flip the box tube material 180 degrees\n" ..
        "2. Keep the SAME END positioned at G55 origin\n" ..
        "3. Re-secure material in vise or clamping system\n" ..
        "4. Verify tool clearance before continuing\n\n" ..
        "Click OK when material is flipped and secured for lower half cut.",
        "Flip Material - Lower Half",
        wx.wxOK | wx.wxCANCEL | wx.wxICON_INFORMATION
    )
    
    if result ~= wx.wxOK then
        wx.wxMessageBox("Operation cancelled by user.", "Cancelled", wx.wxOK)
        return false
    end
    
    return true
end

-- Return machine to work coordinate origin (G55 0,0)
function returnToWorkOrigin(inst)
    print("Returning machine to G55 work coordinate origin (0,0)")
    
    -- Build return-to-origin move using work coordinates
    local return_gcode = table.concat({
        "G90",                    -- Absolute positioning
        "G55",                    -- Work coordinate system
        "G0 X0 Y0"               -- Move to work origin
    }, "\n")
    
    -- Execute using helper function with non-blocking pattern
    local success = executeGcodeWithPolling(inst, return_gcode, "return to origin move", {0, 1})  -- Check X, Y axes only
    
    if success then
        print("Machine returned to G55 work coordinate origin")
    end
    
    return success
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