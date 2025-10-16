# Mach4 ENUM list for mc1

*Converted from PDF: Mach4 ENUM list for mc1.pdf*
*Conversion date: /Users/chondl/learn/mach4/scripts*

---

<!-- Page 1 -->

Mach 4 ENUM list for mc .VAR calls:
(it covers most all of the useable enums, enjoy Scott Shafer)

Controller modes :
mc.MC_MODE_MILL
mc.MC_MODE_LATHE_DIA
mc.MC_MODE_LATHE_RAD
mc.MC_MODE_TANGENTIAL

Axis Enums:
mc.X_AXIS
mc.Y_AXIS
mc.Z_AXIS
mc.A_AXIS
mc.B_AXIS
mc.C_AXIS
mc.S_AXIS
mc.AXIS 7
mc.AXIS 8
mc.AXIS 9
mc.AXIS 1 0
mc.AXIS 1 1

Motor Enums:
mc.MOTOR 0 to mc.MOTOR 3 1

Axis Bit Enums:
mc.X_AXIS_BIT
mc.Y_AXIS_BIT
mc.Z_AXIS_ BIT
mc.A_AXIS_BIT
mc.B_AXIS_BIT
mc.C_AXIS_BIT
mc.AXIS 6 _BIT
mc.AXIS 7 _BIT
mc.AXIS 8 _BIT
mc.AXIS 9 _BIT
mc.AXIS 1 0_BIT
mc.AXIS 1 1_BI T


<!-- Page 2 -->

Motor Bit Enums:
mc.MOT 0 R 0 _BIT to mc.MOT 0 R 3 1 _BIT

Spindle Control Enums:
mc.MC_SPINDLE_OFF
mc.MC_SPINDLE_FWD
mc.MC_SPINDLE_REV
mc.MC_SPINDLE_RPM
mc.MC_SPINDLE_CSS
mc.MC_SRA NGE 0 to mc.MC_SRANGE 1 9

Getting Offsets:
mc.MC_OFFSET_FIXTURE
mc.MC_OFFSET_AXIS
mc.MC_OFFSET_TOOL
mc.MC_OFFSET_WORK
mc.MC_OFFSET_HEAD
mc.MC_OFFSET_ALL

System Values :
mc.VAL_ACTIVE_TOOL
mc.VAL_AXIS_MACHINE_POS
mc.VAL_AXIS_POS
mc.VAL_AXIS_VEL
mc.VAL_BLOCK_DELETE
mc.VAL_CONTROLLER_MODE
mc.VAL_CYCLE_TIME
mc.VAL_DIA_REG
mc.VAL_DIST_TO_GO
mc.VAL_ENCODER_POS
mc.VAL_EXECUTION_NUM
mc.VAL_FIXTURE_POS
mc.VAL_FRO
mc.VAL_G_INTERPRETER_POS
mc.VAL_GCODE_LINE
mc.VAL_GCODE_LINE_COUNT
mc.VAL_GCODE_VAR
mc.VAL_TOOLPATH_PERCENT
mc.VAL_HEIGHT_REG
mc.VAL_MACHINE_POS


<!-- Page 3 -->

mc.VAL_MOTOR_PLAN_ABS
mc.VAL_MOTOR_PLAN_INC
mc.VAL_MOTOR_POS
mc.VAL_MOTOR_VEL
mc.VAL_NEXT_TOOL
mc.VAL_OPTIONAL_STOP
mc.VAL_PATHGENERATE
mc.VAL_REGISTER
mc.VAL_RRO
mc.VAL_SINGLE_BLOCK
mc.VAL_SLOW_JOG_RATE
mc.VAL_SOFTLIMIT
mc.VAL_SOFTLIMIT_MAX
mc.VAL_SOFTLIMIT_MIN
mc.VAL_SPINDLE_SPEED
mc.VAL_TOOLPATH_JOGFOLLOW
mc.VAL_VELOCITY
mc.VAL_TOOLOFFSETDIST
mc.VAL_SOFTLIMIT_USED
mc.VAL_SLOW_JOG_ACCEL
mc.VAL_JOG_INC
mc.VAL_AXIS_PROBE_POS
mc.VAL_AXIS_MACHINE_PROBE_POS
mc.VAL_JOG_TYPE
mc.VAL_AXIS_SCALE

Input Signals 0 -6 3:
mc.ISIG_INPUT 0 to mc.ISIG_INPUT 6 3

Input Motor Home 0 -3 2:
mc.ISIG_MOTOR 0 _HOME to mc.ISIG_MOTOR 3 1 _HOME

Input Motor Pos limit 0 -3 2:
mc.ISIG_MOTOR 0 _PLUS to mc.ISIG_MOTOR 3 1 _PLUS

Input Motor Min limit 0 -3 2:
mc.ISIG_MOTOR 0 _MINUS to mc.ISIG_MOTOR 3 1 _MINUS


<!-- Page 4 -->

Input Signals Other :
mc.ISIG_PROBE
mc.ISIG_INDEX
mc.ISIG_LIMITOVER
mc.ISIG_EMERGENCY
mc.ISIG_THCON
mc.ISIG_THCUP
mc.ISIG_THCDOWN
mc.ISIG_TIMING
mc.ISIG_JOGXP
mc.ISIG_JOGXN
mc.ISIG_JOGYP
mc.ISIG_JOGYN
mc.ISIG_JOGZP
mc.ISIG_JOGZN
mc.ISIG_JOGAP
mc.ISIG_JOGAN
mc.ISIG_JOGBP
mc.ISIG_JOGBN
mc.ISIG_JOGCP
mc.ISIG_JOGCN
mc.ISIG_SPINDLE_AT_SPEED
mc.ISIG_SPINDLE_AT_ZERO
mc.ISIG_PROBE 1
mc.ISIG_PROBE 2
mc.ISIG_PROBE 3

Output Signals Limit/Home:
mc.OSIG_XLI MITPLUS
mc.OSIG_XLIMITMINUS
mc.OSIG_XHOME
mc.OSIG_YLIMITPLUS
mc.OSIG_YLIMITMINUS
mc.OSIG_YHOME
mc.OSIG_ZLIMITPLUS
mc.OSIG_ZLIMITMINUS
mc.OSIG_ZHOME
mc.OSIG_ALIMITPLUS
mc.OSIG_ALIMITMINUS
mc.OSIG_AHOME


<!-- Page 5 -->

mc.OSIG_BLIMITPLUS
mc.OSIG_BLIMITMINUS
mc.OSIG_BHOME
mc.OSIG_CLIMITPLUS
mc.OSIG_CLIMITMINUS
mc.OSIG_CHOME

Output Signals Enable (0 -3 2):
mc.OSIG_ENABLE 0 to mc.OSIG_ ENABLE 3 1

Output Signals (0 -6 3):
mc.OSIG_OUTPUT 0 to mc.OSIG_OUTPUT 6 3

Output Signals Other:
mc.OSIG_RUNNING_GCODE
mc.OSIG_FEEDHOLD
mc.OSIG_BLOCK_DELETE
mc.OSIG_SINGLE_BLOCK
mc.OSIG_REVERSE_RUN
mc.OSIG_OPT_STOP
mc.OSIG_MACHINE_ENABLED
mc.OSIG_TOOL_CHANGE
mc.OSIG_DIST_TOGO
mc.OSIG_MACHINE_CORD
mc.OSIG_SOFTLIMITS_ON
mc.OSIG_JOG_INC
mc.OSIG_JOG_CONT
mc.OSIG_JOG_ENABLED
mc.OSIG_JOG_MPG
mc.OSIG_HOMED_X
mc.OSIG_HOMED_Y
mc.OSIG_HOMED_Z
mc.OSIG_HOMED_A
mc.OSIG_HOMED_B
mc.OSIG_HOMED_C
mc.OSIG_DWELL
mc.OSIG_TP_MOUSE_DN
mc.OSIG_LIMITOVER
mc.OSIG_CHARGE
mc.OSIG_CHARGE 2
mc.OSIG_CURRENTHILOW


<!-- Page 6 -->

mc.OSIG_SPINDLEON
mc.OSIG_SPINDLEFWD
mc.OSIG_SPINDLEREV
mc.OSIG_COOLANTON
mc.OSIG_MISTON
mc.OSIG_DIGTRIGGER
mc.OSIG_ALARM
mc.OSIG_PRTSF

Tool Table Enums:
mc.TOOLS_START //Start of Tools in Parameter list
mc.TOOL_INC //Inc from tool to tool in the param list

mc.MTOOL_MILL_X /*X offset*/
mc.MTOOL_MILL_X_W /*X Wear offset*/
mc.MTOOL_MILL_Y /* offset*/
mc.MTOOL_MILL_Y_W /*Y Wear offset*/
mc.MTOOL_MILL_HEIGHT /*Tool height offset*/
mc.MTOOL_MILL_HEIGHT_ W /*Height wear Offset*/
mc.MTOOL_MILL_RAD /*Rad for comp*/
mc.MTOOL_MILL_RAD_W /*wear offset for comp*/
mc.MTOOL_MILL_POCKET /*Tool changer pocket*/
mc.MTOOL_LATHE_X mc.MTOOL_MILL_X /*X offset*/
mc.MTOOL_LATHE_X_W mc.MTOOL_MILL_X_W /*X Wear offset*/
mc.MTOOL_LATHE_Y mc.MTOOL_MILL_Y /*Y offset*/
mc.MTOOL_LATHE_Y_W mc.MTOOL_MILL_Y_W /*Y Wear offset*/
mc.MTOOL_LATHE_Z mc.MTOOL_MILL_HEIGHT /*Z offset*/
mc.MTOOL_LATHE _Z_W mc.MTOOL_MILL_HEIGHT_W /*Z wear offset*/
mc.MTOOL_LATHE_POCKET mc.MTOOL_MILL_POCKET
/*Pocket # (may not be needed)*/
mc.MTOOL_LATHE_TIPRAD mc.MTOOL_MILL_RAD /*Tip Rad for comp*/
mc.MTOOL_LATHE_TIPDIR mc.MTOOL_MILL_RAD_W /*Tool tip DIR*/
mc.MTOOL_LATHE_TOOLSLIDE /*Axis Slide number and - for reversed*/
mc.MTOOL_TYPE /*Type = 0 == MILL Type != 0 == Lathe*/

Jog Enums:
mc.MC_JOG_POS
mc.MC_JOG_NEG
mc.MC_JOG_STOP
mc.MC_JOG_TYPE_VEL
mc.MC_JOG_TYPE_IN C


<!-- Page 7 -->

Tool Path View Enums:
mc.MC_TPVIEW_TOP
mc.MC_TPVIEW_BOTTOM
mc.MC_TPVIEW_LEFT
mc.MC_TPVIEW_RIGHT
mc.MC_TPVIEW_ISO

Local Var Enums :
mc.SV_A
mc.SV_B
mc.SV_C
mc.SV_I
mc.SV_J
mc.SV_K
mc.SV_D
mc.SV_E
mc.SV_F
mc.SV_G
mc.SV_H
mc.SV_L
mc.SV_M
mc.SV_N
mc.SV_O
mc.SV_P
mc.SV_Q
mc.SV_R
mc.SV_S
mc.SV_T
mc.SV_U
mc.SV_V
mc.SV_W
mc.SV_X
mc.SV_Y
mc.SV_Z

Common vars (cleared on startup)
mc.SV_CMN 1 _START
mc.SV_CMN 1 _END


<!-- Page 8 -->

Common vars (retained across startups)
mc.SV_CMN 2 _START
mc.SV_CMN 2 _END
mc.SV_CURRENT_TIP // Tool tip direction in Lathe mode for Tip Comp
mc.SV_FRO_ON_OFF // FRO On or Off
mc.SV_CUR_DIA_INDEX // Current Dia number (D)
mc.SV_CUR_TOOL_NUMBE R // Current tool number (T)
mc.SV_CUR_SELECTED_TOOL // Current tool that is selected (Next T number)
mc.SV_CUR_LENGTH_INDEX // Current Length number (H)
mc.SV_CUR_TOOL_XLENGTH_REGISTER
mc.SV_CUR_TOOLDIA_REGISTER // Register for the amount of tool dia offset
mc.SV_CUR_TOOL_ZLENGTH_REGISTER
mc.SV_CUR_TOOL_YLENGTH_REGISTER
mc.SV_CUR_SPINDLE_SPEED
mc.SV_TRAVER SE_RATE // Rate for traverse motions .. I do n't think this is needed here..
mc.SV_FEEDRATE // Feed rate in current units/min
mc.SV_ROTATION_X
mc.SV_ROTATI ON_Y
mc.SV_ROTATION
```
mc.SV_ALM // W: Writing to this var will produce a machine alarm.
mc.SV_CLOCK 1 // R: Time, in milliseconds, since t he machine was powered on.
mc.SV_CLOCK 2 // R: Accumulated time, in hours, of the machine. (Hour Meter)
mc.SV_CNTL 1 // R/W: bit 0 high suppresses single block (default == not set), bit 1 high
suppresses waits on MST codes (default == not set).
mc.SV_M_SBK
mc.SV_M_MST
mc.SV_M_FIN // Same as SV_M_MST.
mc.SV_CNTL 2 // R/W: bit 0 high disables feed hold (default == not set), bit 1
high disables FRO (default == not set), bit 2 high enables exact stop (default == not set).
mc.SV_M_FHD
mc.SV_M_OV
mc.SV_M_EST
mc.SV_SETDT // R/W: Settings Data (bit 2 = 0 Inch, bit 2 = 1 Metric)
```
mc.SV_MSGSTP // W: Writing to this var will produce a machine stop.
mc.SV_MR IMG // R: Status of Mirror Image.
mc.SV_PRSTR // R: Program restart (0 or 1)
mc.SV_DEFAULT_UNITS // Same as SV_SETDT R/W: (bit 2 = 0 Inch, bit 2 = 1 Metric)
mc.SV_D ATE // R: Current Date (YYYYMMDD)
mc.SV_TIME // R: Current Time (HHMMSS)
mc.SV_EMPTY // R: returns NIL


<!-- Page 9 -->

mc.SV_PI // R: returns pi. (3.1 4 1 5 9 2 6 5 3 5 8 9 7 9 3 2 3 8 4 6)
mc.SV_BA SE_LOG_E // R: returns base of natural logarithm E. 2.7 1 8 2 8 1 8 2 8 4 5 9 0 4 5 2 3 5 3 6)
mc.SV_PRTSA // R/W: T otal number of parts.
mc.SV_PRTSN // R/W: Number of required parts
mc.SV_MAINO // Main program number.
mc.SV_MOD_GROUP_ 1 // Group 1 // active G -code for motion
mc.SV_MOD_GROUP_ 2 // Group 2 // active plane, XY -, YZ-, or XZ -plane
mc.SV_MOD_GROUP_ 3 // Group 3 // absolute or incremental
mc.SV_MOD_GROUP_ 4 // Group 4 // Arc Center mode
mc.SV_MOD_GROUP_ 5 // Group 5 // G_ 9 3 (inverse time) or G_ 9 4 units/min
mc.SV_MOD_GROUP_ 6 // Group 6 // millimeters or inches
mc.SV_MOD_GROUP_ 7 // Group 7 // current cutter compensa tion side
mc.SV_MOD_GROUP_ 8 // Group 8 // not used
mc.SV_MOD_GROUP_ 9 // Group 9 // not used
mc.SV_MOD_GROUP_ 1 0 // Group 1 0 // for cycles, old_z or r_plane
mc.SV_MOD_GROUP_ 1 1 // Group 1 1 // Polar mode
mc.SV_MOD_GROUP_ 1 2 // Group 1 2 // active origin (1=G 5 4 to 9=G 5 9.3)
mc.SV_MOD_GROUP_ 1 3 // Group 1 3 // exact path or cutting mode
mc.SV_MOD_GROUP_ 1 4 // Group 1 4 // not used
mc.SV_MOD_GROUP_ 1 5 // Group 1 5 // not used
mc.SV_MOD_GROUP_ 1 6 // Group 1 6 // not used
mc.SV_MOD_GROUP_ 1 7 // Group 1 7 // not used
mc.SV_MOD_GROUP_ 1 8 // Group 1 8 // not used
mc.SV_MOD_GROUP_ 1 9 // Group 1 9 // not used
mc.SV_MOD_GROUP_ 2 0 // Group 2 0 // not used
mc.SV_MOD_GROUP_ 2 1 // Group 2 1 // not used
mc.SV_MOD_GROUP_ 2 2 // Group 2 2 // not used
mc.SV_BUFB // last buffered B code value.
mc.SV_BUFD // last buffered D code value.
mc.SV_BUFE // last buffered E code value.
mc.SV_BUFF // last buffered F code value.
mc.SV_BUFH // last buffered H code value.
mc.SV_BUFM // last buffered H code value.
mc.SV_BUFN // last buffered N code value.
mc.SV_BUFO // last buffered O code value.
mc.SV_BUFS // last buffered S code value.
mc.SV_BUFT // last buffered T code value.
mc.SV_ORIGIN_OFFSET_X
mc.SV_ORIGIN_OFFSET_Y
mc.SV_ORIGIN_OFFSET_Z
mc.SV_ORIGIN_OFFSET_A


<!-- Page 10 -->

mc.SV_ORIGIN_OFFSET_B
mc.SV_ORIGIN_OFFSET_C
mc.SV_LAST_OUTPUT_X
mc.SV_LAST_OUTPUT_Y
mc.SV_LAST_OUT PUT_Z
mc.SV_LAST_OUTPUT_A
mc.SV_LAST_OUTPUT_B
mc.SV_LAST_OUTPUT_C
mc.SV_CURRENT_MACH_X
mc.SV_CURRENT_MACH_Y
mc.SV_CURRENT_MACH_Z
mc.SV_CURRENT_MACH_A
mc.SV_CURRENT_MACH_B
mc.SV_CURRENT_MACH_C
mc.SV_AXIS_OFFSET_X // Used to save the offset wit h the G 9 2.3 command
mc.SV_AXIS_OFFSET_Y
mc.SV_AXIS_OFFSET_Z
mc.SV_AXIS_OFFSET_A
mc.SV_AXIS_OFFSET_B
mc.SV_AXIS_OFFSET_C
mc.SV_CURRENT_ABS_X
mc.SV_CURRENT_ABS_Y
mc.SV_CURRENT_ABS_Z
mc.SV_CURRENT_ABS_A
mc.SV_CURRENT_ABS_B
mc.SV_CURRENT_ABS_C
mc.SV_G 9 2_OFFSET_X // Used to save the offset with the G 9 2.3 command
mc.SV_G 9 2_OFFSET_Y
mc.SV_G 9 2_OFFSET_Z
mc.SV_G 9 2_OFFSET_A
mc.SV_G 9 2_OFFSET _B
mc.SV_G 9 2_OFFSET_C
mc.SV_PROBE_POS_X // G 3 1 Skip signal
mc.SV_PROBE_POS_Y
mc.SV_PROBE_POS_Z
mc.SV_PROBE_POS_A
mc.SV_PROBE_POS_B
mc.SV_PROBE_POS_C


<!-- Page 11 -->

mc.SV_PROBE_MACH_POS_X // G 3 1 Skip signal machine position
mc.SV_PROBE_MACH_POS_Y
mc.SV_PROBE_MACH_POS_Z
mc.SV_PROBE_MACH_POS_A
mc.SV_PROBE_MACH_POS_B
mc.SV_PROBE_MACH_POS_C
mc.SV_HEAD_SHIFT_X
mc.SV_HEAD_SHIFT_Y
mc.SV_HEAD_SHIFT_Z
mc.SV_HEAD_SHIFT_A
mc.SV_HEAD_SHIFT_B
mc.SV_HEAD_SHIFT_C
/* Turn Registers only */
/* G 7 6 Parameters */
mc.SV_G 7 6_MIN_PASS_DEPTH
mc.SV_G 7 6_FINISH_DEPTH
mc.SV_G 7 6_FINISH_PASSES
mc.SV_G 7 6_THREAD_ANGLE
mc.SV_G 7 6_CHAMFER_AMOUNT
mc.SV_G 7 6_CUTTING_METHOD
/* End of Turn Registers */
mc.SV_CUR_COMP_X // Program x, used when cutter comp on
mc.SV_CUR_COMP_Y // Program y, used when cutter comp on
mc.SV_CUR_COMP_Z // Program z, used when cutter comp on
mc.SV_G_ 3 0_XPOS
mc.SV_G_ 3 0_YPOS
mc.SV_G_ 3 0_ZPOS
mc.SV_G_ 3 0_APOS
mc.SV_G_ 3 0_BPOS
mc.SV_G_ 3 0_CPOS
mc.SV_WORK_SHIFT_X
mc.SV_WORK_SHIFT_Y
mc.SV_WORK_SHIFT_Z
mc.SV_WORK_SHIFT _A
mc.SV_WORK_SHIFT_B
mc.SV_WORK_SHIFT_C
mc.SV_FIXTURES_START // Fixture start in Parameter list
mc.SV_FIXTURES_INC // (2 0)Increment from fixture to fixture (does not define a
system var!)


<!-- Page 12 -->

mc.SV_G_ 3 0_P 2 _XPOS
mc.SV_G_ 3 0_P 2 _YPOS
mc.SV_G_ 3 0_P 2 _ZPOS
mc.SV_G_ 3 0_P 2 _APOS
mc.SV_G_ 3 0_P 2 _BPOS
mc.SV_G_ 3 0_P 2 _CPOS
mc.SV_G_ 3 0_P 3 _XPOS
mc.SV_G_ 3 0_P 3 _YPOS
mc.SV_G_ 3 0_P 3 _ZPOS
mc.SV_G_ 3 0_P 3 _APOS
mc.SV_G_ 3 0_P 3 _BPOS
mc.SV_G_ 3 0_P 3 _CPOS
mc.SV_G_ 3 0_P 4 _XPOS
mc.SV_G_ 3 0_P 4 _YPOS
mc.SV_G_ 3 0_P 4 _ZPOS
mc.SV_G_ 3 0_P 4 _APOS
mc.SV_G_ 3 0_P 4 _BPOS
mc.SV_G_ 3 0_P 4 _CPOS
mc.SV_ROTATION_G 6 8_NO_R
mc.SV_A PPROACH_DIST_X // Approch distance for the G 6 0 Unidirectional approch
comm and
mc.SV_APPROACH_DIST_Y
mc.SV_APPROACH_DIST_Z
mc.SV_APPROACH_DIST_A
mc.SV_APPROACH_DIST_B
mc.SV_APPROACH_DIST_C
```
mc.SV_CMN_RO_START // The starting commnon var (#5 0 0 -#9 9 9) to write protect.
```
mc.SV_CMN_RO_END // The ending commnon var (#5 0 0 -#9 9 9) to write protect.
mc.SV_PRTCNTL // Setting to 1 only allows M co de specified by #6 7 1 0 to increment part
count. (default 0)
mc.SV_PRTINCM // Set to a M code that will incremnt part counts with or without M 0 2 and
M 3 0 according to #6 7 0 0.
mc.SV_PRTSA 2 // R/W: T otal number of parts. Will change/reflect #3 9 0 1 as well. (cleared on
file load).
mc.SV_PRTST // R/W: Total number of parts machined.
mc.SV_PRTSN 2 // R/W: Number of required parts Wi ll change/reflect #3 9 0 2 as well
mc.SV_FIXTURE_EXPAND // Fixtures after G 5 4.1

