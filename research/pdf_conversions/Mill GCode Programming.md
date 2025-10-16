# Mill GCode Programming

*Converted from PDF: Mill GCode Programming.pdf*
*Conversion date: /Users/chondl/learn/mach4/scripts*

---

<!-- Page 1 -->

1

Mach 4 CNC Controller
Mill Programming Guide
Version 1. 1
Build 3 7 7 5

Copyright © 2 0 1 4 Newfangled Solutions, Artsoft USA, All Rights Reserved
The following are registered trademarks of Microsoft Corporation: Microsoft, Windows. Any other
trademarks used in this manual are the property of the respective trademark holder.


<!-- Page 2 -->

2
Table of Contents
Chapter 1: Introduction ................................ ................................ ................................ ................................ 6
Glossary ................................ ................................ ................................ ................................ ..................... 7
Format ................................ ................................ ................................ ................................ ....................... 9
Rotary vs. Linear ................................ ................................ ................................ ................................ ...... 1 0
Chapter 2: G Code List ................................ ................................ ................................ ................................ . 1 1
G Code Descriptions and Examples ................................ ................................ ................................ ......... 1 4
G 0 0 – Rapid Move ................................ ................................ ................................ ............................... 1 4
G 0 1 – Linear Feed Move ................................ ................................ ................................ ..................... 1 4
G 0 2/G 0 3 – Arc Feed Move ................................ ................................ ................................ .................. 1 5
G 0 4 – Dwell ................................ ................................ ................................ ................................ ......... 1 7
G 0 9 – Exact Stop ................................ ................................ ................................ ................................ . 1 8
G 1 0 L 1 – Tool Offset Setting ................................ ................................ ................................ ............... 1 9
G 1 0 L 2 – Fixture Offset Setting ................................ ................................ ................................ ........... 2 1
G 1 0 L 3 – Tool Life Management Setti ng ................................ ................................ ............................. 2 3
G 1 0 L 3 Format 1 - Register with deleting all groups ................................ ................................ ........... 2 4
G 1 0 L 3 Format 2 – Add or change tool group ................................ ................................ ..................... 2 5
G 1 0 L 3 Format 3 – Delete tool life data ................................ ................................ .............................. 2 6
G 1 0 L 1 0 – Geometry compensation value for H code ................................ ................................ ........ 2 6
G 1 0 L 1 1 – Wear compensation value for H code ................................ ................................ ............... 2 7
G 1 0 L 1 2 – Geometry compensation value for D code ................................ ................................ ........ 2 7
G 1 0 L 1 3 – Wear compensation value for D code ................................ ................................ ............... 2 8
G 1 0 L 2 0 – Additional Fixture Offset Setting ................................ ................................ ........................ 2 8
G 1 0 L 5 0 – Parameter Setting ................................ ................................ ................................ .............. 3 0
G 1 1 – Cancel Modal G 1 0 ................................ ................................ ................................ ..................... 3 0
G 1 2/G 1 3 – Circle Interpolation ................................ ................................ ................................ ........... 3 1
G 1 5/G 1 6 – Polar Coordinates ................................ ................................ ................................ ............. 3 2
G 1 7/G 1 8/G 1 9 – Plane Selection ................................ ................................ ................................ ......... 3 4
G 2 0/G 2 1 – Unit selection ................................ ................................ ................................ .................... 3 5
G 2 8 – Zero Return ................................ ................................ ................................ ............................... 3 6
G 2 8.1 – Home Axis ................................ ................................ ................................ .............................. 3 7


<!-- Page 3 -->

3
G 3 0 – 2 nd, 3 rd, 4 th Zero Return ................................ ................................ ................................ ......... 3 7
```
G 3 1/G 3 1.X – Probe function ................................ ................................ ................................ ............... 3 8
G 3 2 – Threading ................................ ................................ ................................ ................................ .. 3 9
G 4 0 – Cutter Compensation Cancel ................................ ................................ ................................ .... 4 0
G 4 0.1 – Arc Type Cutter C ompensation ................................ ................................ ............................. 4 0
G 4 0.2 – Line Offset Type Cutter Compensation ................................ ................................ ................. 4 2
G 4 1/G 4 2 – Cutter Compensation Left/Right ................................ ................................ ...................... 4 2
G 4 3/G 4 4 – Tool Length Offset ................................ ................................ ................................ ............ 4 2
G 4 9 – Tool Length Offset Cancel ................................ ................................ ................................ ......... 4 2
G 5 0 – Scaling Cancel ................................ ................................ ................................ ........................... 4 2
G 5 1 – Scaling/Mirroring Function ................................ ................................ ................................ ....... 4 3
G 5 2 – Local Coordinate System Shift ................................ ................................ ................................ .. 4 4
G 5 3 – Machine Coordinate System ................................ ................................ ................................ ..... 4 5
G 5 4-G 5 9 – Fixture Offset ................................ ................................ ................................ .................... 4 5
G 5 4.1 – Additional Fixture Offsets ................................ ................................ ................................ ...... 4 5
G 6 0 – Unidirectional Approach ................................ ................................ ................................ ........... 4 6
G 6 1 – Exact Stop Mode ................................ ................................ ................................ ....................... 4 7
G 6 4 – Constant Velocity Mode ................................ ................................ ................................ ........... 4 7
G 6 5 – Macro Call ................................ ................................ ................................ ................................ . 4 7
G 6 6 – Macro Modal Call ................................ ................................ ................................ ...................... 4 8
G 6 7 – Macro Modal Call Cancel ................................ ................................ ................................ .......... 4 8
G 6 8 – Coordinate System Rotation ................................ ................................ ................................ ..... 4 8
G 6 9 – Coordinate System Rotation Cancel ................................ ................................ ......................... 4 9
G 7 3-G 8 9 – Canned Cycles ................................ ................................ ................................ ................... 5 0
G 9 0/G 9 1 – Absolute/Incremental Position Mode ................................ ................................ .............. 5 0
G 9 0.1/G 9 1.1 – Absolute/Incremental Arc Center Mode ................................ ................................ .... 5 2
G 9 2 – Local Coordinate System Setting ................................ ................................ .............................. 5 3
G 9 3 – Inverse Time Feed ................................ ................................ ................................ ..................... 5 4
G 9 4 – Feed Per Minute ................................ ................................ ................................ ....................... 5 4
G 9 5 – Feed Per Revolution ................................ ................................ ................................ .................. 5 4
G 9 6 – Constant Surface Speed ................................ ................................ ................................ ............ 5 4
G 9 7 – Constant RPM ................................ ................................ ................................ ........................... 5 4


<!-- Page 4 -->

4
G 9 8 – Initial Point Return ................................ ................................ ................................ .................... 5 5
G 9 9 – R Point Return ................................ ................................ ................................ ........................... 5 5
Chapt er 3: Canned Cycles ................................ ................................ ................................ ........................... 5 6
G 8 0 – Canned Cycle Cancel ................................ ................................ ................................ ................. 5 8
Drilling ................................ ................................ ................................ ................................ ..................... 5 9
G 8 1 – Drilling ................................ ................................ ................................ ................................ ....... 5 9
G 8 2 – Spot Face ................................ ................................ ................................ ................................ .. 6 0
G 8 3 – Peck Drilling ................................ ................................ ................................ .............................. 6 1
G 7 3 – High Speed Peck ................................ ................................ ................................ ....................... 6 3
Tapping ................................ ................................ ................................ ................................ .................... 6 5
G 8 4 – Right Hand Tapping ................................ ................................ ................................ .................. 6 5
G 7 4 – Left Hand Tapping ................................ ................................ ................................ ..................... 6 6
G 8 4.2/G 8 4.3 – Right and Left Hand Rigid Tapping ................................ ................................ ............. 6 7
Boring ................................ ................................ ................................ ................................ ...................... 6 8
G 7 6 – Fine Borin g ................................ ................................ ................................ ................................ 6 8
G 8 5 – Boring, Feed rate Retract ................................ ................................ ................................ .......... 7 0
G 8 6 – Boring, Rapid Retract ................................ ................................ ................................ ................ 7 1
G 8 7 – Back Boring ................................ ................................ ................................ ............................... 7 2
G 8 8 – Boring, Manual Retract ................................ ................................ ................................ ............. 7 4
G 8 9 – Boring, Dwell & Feed rate Retract ................................ ................................ ............................ 7 5
Chapter 4: Cutter Compensation ................................ ................................ ................................ ................ 7 6
Chapter 5: M Code List ................................ ................................ ................................ ................................ 8 2
M Code Descriptions ................................ ................................ ................................ ............................... 8 2
M 0 0 – Mandatory Program Stop ................................ ................................ ................................ ........ 8 2
M 0 1 – Optional Program Stop ................................ ................................ ................................ ............ 8 2
M 0 2 – Program End ................................ ................................ ................................ ............................ 8 2
M 0 3 – Spindle Forward/Clockwise ................................ ................................ ................................ ..... 8 3
M 0 4 – Spindle Reverse/Counterclockwise ................................ ................................ ......................... 8 3
M 0 5 – Spindle S top ................................ ................................ ................................ ............................. 8 3
M 0 6 – Tool Change ................................ ................................ ................................ ............................. 8 3
M 0 7 – Mist Coolant On ................................ ................................ ................................ ....................... 8 3
M 0 8 – Flood Coolant On ................................ ................................ ................................ ..................... 8 3


<!-- Page 5 -->

5
M 0 9 – All Coolant Off ................................ ................................ ................................ .......................... 8 4
M 1 9 – Spindle Orient ................................ ................................ ................................ .......................... 8 4
M 3 0 – Program End and Rewind ................................ ................................ ................................ ........ 8 4
M 4 8 – Enable Feed rate/Spindle Speed Overrides ................................ ................................ ............. 8 4
M 4 9 – Disable Feed rate/Spindle Speed Overrides ................................ ................................ ............ 8 4
M 6 2 – Synchronized Output On ................................ ................................ ................................ ......... 8 4
M 6 3 – Synchronized Output Off ................................ ................................ ................................ ......... 8 4
M 6 4 – Immediate Output On ................................ ................................ ................................ .............. 8 4
M 6 5 – Immediate Output Off ................................ ................................ ................................ ............. 8 5
M 6 6 – Wait for Input ................................ ................................ ................................ .......................... 8 5
M 9 8 – Subprogram Call................................ ................................ ................................ ....................... 8 6
M 9 9 – Return From Subprogram / Rerun ................................ ................................ ........................... 8 8
Custom M Codes ................................ ................................ ................................ ................................ . 8 8
Chapter 6: Custom Macro ................................ ................................ ................................ ........................... 8 9
Variables ................................ ................................ ................................ ................................ ................. 8 9
System Variables ................................ ................................ ................................ ................................ ..... 9 1
Arithmetic and Logic ................................ ................................ ................................ ............................... 9 7


<!-- Page 6 -->

6
Chapter 1: Introduction
G Code is a special programming l anguage that is interpreted by Computer Numerical C ontrol (CNC)
machines to create motion and other tasks. It is a language that can be quit e complex at times and can
vary from machine to machine. The basics, however, are much simpler than it first appears and for the
most part follows an industry adopted standard. Mach 4 has made a large leap closer to this standard.
An important point to remember when readin g this manual: In describing motion of a machine it will
always be described as tool movement relative to the work piece. In many machines the work piece will
move in more axes than the tool; however the program will always define tool movement around th e
work piece. Axis directions follow the right hand rule, see figure A.
Figure A: Right hand rule


<!-- Page 7 -->

7
Glossary
Block A single line of G Code
Canned Cycle Complex cycle defined by a single block of code , used to simplify programming
Dwell Program pau se with a duration defined by “P” in seconds . If “P” contains a decimal
point, the time is in seconds.
EOB End of block. Required at the end of every block of G Code. In Mach 4 this is a
carriage return
Feed rate Velocity, set by F, at which an axis wi ll move
```
Group Collection of G codes that control the same function or mode, i.e. G 9 0 and G 9 1
positioning modes
Modal Active until a code from the same group is called
Normal A line perpendicular to a plane, pointing in the positive direction.
Origin Point in a coordinate system where X, Y and Z are zero
RPM Revolutions per minute
UPM Units per minute (inches, millimeters, degrees, etc)
Word A single word of G Code is a letter followed by a number. G 0 1, X 1.0, etc. are words

```
G Preparatory function, G followed by a numerical code, specifies machining modes
```
and functions
```
M Miscellaneous function, M followed by a numerical code, defines program flow and
```
can control auxiliary functions such as coolant . Can also perform machine specific
```
functions and ma cros user or builder.
X, Y, Z, A, B, C , U,
V, W Movement commands followed by a numerical value, define the end point of a
motion command . (A, B, C are rotary, U, V, W are linear replacements for A, B, C)
S Spindle speed, followed by numerical value of desired rpm or surface speed
T Tool call, followed by next tool number to be used
H Tool height offset to be used, generally matches the tool number
D Tool diameter offset to be used, generally matches the tool number


<!-- Page 8 -->

8
F Followed by a numerical value to define the feed rate. The magnitude and value of
which will be determined by the feed mode setting
P Followed by a numerical value, specifies dwell time in milli seconds . (also used in
```
other functions) If the value contains a decimal point, the dwell t ime is in seconds.
N Sequence numbers. Used for program organization and go to commands


<!-- Page 9 -->

9
Format
In writing G Code programs there are some rules to be aware of as well as some general formatting
guidelines that should be followed or at least considered .
The first part of any progra m should be a safe start up block . This line of code is used to make sure that
some modes are disabled and others are set to their most common setting . An example safe start block
would look like this:
## G 0 0 G 9 0 G 1 7 G 5 4 G 4 0 G 4 9 G 8 0
This block of code tells the machine that we want to be in rapid mode and using absolute position in the
XY plane of fixture offset 1. At the same time we want to cancel any tool diameter and length offsets
and make sure any active canned cycles ar e cancelled.
G 0 0 – Rapid mode
G 9 0 – Absolute position mode
G 1 7 – XY plane select
G 5 4 – Fixture offset 1
G 4 0 – Cutter compensation (tool diameter) cancel
G 4 9 – Length offset cancel
G 8 0 – Canned cycle cancel
It is recommended that this safe start block be us ed at the start of the program and also before or
immediately following every tool change. It is common to restart a program from a tool change, having
the safe start line there can greatly reduce the chance of a machine not acting as expected, the result s
of which can be aggravating at best and a crash at worst. The safe start block shown here is just an
example. Every machine and every programmer are a little different and each will have their own start
up block.
Jumping to the end of the program there is not a lot required. Typically there will be a couple blocks of
code to return the Z axis to the home position and maybe move the work piece closer to the operator
for easier loading and unloading of parts. Shutting off the spindle and coolant or any other accessories
is also a good idea here. The final block in a program is a program end code, most commonly M 3 0 but
there are other options. Make sure this final block is followed by an end of block. It is easy to forget this
last EOB in a program for Mach because it is just a carriage return and not always readily apparent. One
way to make sure that there is always an EOB on your program end block is to follow it with %. Like this:
.
.
.
## M 3 0
%


<!-- Page 10 -->

1 0
This percent sign is a familiar symbol to CNC programmer s in industry; however any symbol or character
can be used as it will not be read by the control because of the program end before it. If there is no EOB
following th e percent sign it will not show up in the program when loaded into Mach.
In between the s tart and end is the body of the program. There are a few rules here. Each block of code
will contain a combination of words. Multiple G codes can be specified in a single block, however if
more than one from the same modal group is specified the last on e in the block will be valid , with the
exception of group 0 0 . Modal G codes stay active until another from the same group is called. For
example; G 0 1 is modal so it is not necessary to put it in consecutive blocks. Once activ e every successive
positioni ng block will be in the G 1 mode unless anothe r code from group one is called ( G 0 0, G 0 2, G 0 3,
etc.). All G codes not in group 0 behave this way.
Only one M code can be specified in a single block. Sam e holds true for all other words.
Generally leading zer oes are not required in G Code. For example G 0 1 and G 1 are the same. The same
holds true for M codes, position commands, feed rates, etc. When specifying values for position, feed
rate, variables, etc., it is good practice to always use a decimal point and trailing zero, instead of X 1 use
X 1.0. Although the decimal point is not required (in Mach X 1 = X 1.0) it is HIGHLY recommended.
Rotary vs. Linear
Axis designations A, B, and C are typically rotary axes that are parallel to axes X, Y, and Z, respectiv ely.
Linear control of these axes are available with axis designation U, V, and W. Any movement command
that accepts A, B, or C axes will also accept U, V, or W.


<!-- Page 11 -->

1 1
Chapter 2: G Code List
Code Group Description Modal Page
G 0 0 1 Rapid Move Y 1 4
G 0 1 1 Linear Feed Move Y 1 4
G 0 2 1 Clockwise Arc Feed Move Y 1 5
G 0 3 1 Counter Clockwise Arc Feed Move Y 1 5
G 0 4 0 Dwell N 1 7
G 0 9 0 Exact stop N 1 8
G 1 0 L 1 0 Tool Offset Setting Y/N 1 9
G 1 0 L 2 0 Fixture Offset Setting Y/N 2 1
G 1 0 L 3 0 Tool Life Management Setting Y 2 3
… 0 G 1 0 L 3 Format 1 - Delete and Add Y 2 4
… 0 G 1 0 L 3 Format 2 – Add or Change Y 2 5
… 0 G 1 0 L 3 Format 3 – Delete Group Y 2 6
G 1 0 L 1 0 0 Geometry compensation value for H code Y/N 2 6
G 1 0 L 1 1 0 Wear compensation value for H code Y/N 2 7
G 1 0 L 1 2 0 Geometry compensation value for D code Y/N 2 7
G 1 0 L 1 3 0 Wear compensation value for D code Y/N 2 8
G 1 0 L 2 0 0 Additional Fixture Offset Setting Y/N 2 8
G 1 0 L 5 0 0 Parameter Setting Y 3 0
G 1 1 0 Cancel Modal G 1 0 N 3 0
G 1 2 1 Clockwise Circle Y 3 1
G 1 3 1 Counter Clockwise Circle Y 3 1
G 1 5 1 7 Polar Coordinate Cancel Y 3 2
G 1 6 1 7 Polar Coordinate Y 3 2
G 1 7 2 XY Plane Select Y 3 4
G 1 8 2 ZX Plane Select Y 3 4
G 1 9 2 YZ Plane Select Y 3 4
G 2 0 6 Inch Y 3 5
G 2 1 6 Millimeter Y 3 5
G 2 8 0 Zero Return N 3 6
G 2 8.1 0 Home Axis N 3 7
G 3 0 0 2 nd, 3 rd, 4 th Zero Return N 3 7
```
G 3 1 1 Probe function N 3 8
G 3 2 1 Threading* N 3 9
G 4 0 7 Cutter C ompensation Cancel Y 4 0
G 4 0.1 1 8 Arc Type Cutter Compensation Y 4 0
G 4 0.2 1 8 Line Offset Type Cutter Compensation Y 4 2
G 4 1 7 Cutter Compensation Left Y 4 2
G 4 2 7 Cutter Compensation Right Y 4 2


<!-- Page 12 -->

1 2
G 4 3 8 Tool Length Offset + Enable Y 4 2
G 4 4 8 Tool Length Offset - Enable Y 4 2
G 4 9 8 Tool Length Offset Cancel Y 4 2
G 5 0 1 1 Cancel Scaling Y 4 2
G 5 1 1 1 Scale Axes Y 4 3
G 5 2 0 Local Coordinate System Shift Y 4 4
G 5 3 0 Machine Coordinate System N 4 5
G 5 4 1 4 Fixture Offset 1 Y 4 5
G 5 4.1 1 4 Additi onal Fixture Offsets Y 4 5
G 5 5 1 4 Fixture Offset 2 Y 4 5
G 5 6 1 4 Fixture Offset 3 Y 4 5
G 5 7 1 4 Fixture Offset 4 Y 4 5
G 5 8 1 4 Fixture Offset 5 Y 4 5
G 5 9 1 4 Fixture Offset 6 Y 4 5
G 6 0 0 Unidirectional Approach N 4 6
G 6 1 1 5 Exact Stop Mode Y 4 7
G 6 4 1 5 Cutting Mode (Constant Velocity) Y 4 7
G 6 5 0 Macro Call N 4 7
G 6 6 1 2 Macro Modal Call Y 4 8
G 6 7 1 2 Macro Modal Call Cancel Y 4 8
G 6 8 1 6 Coordinate System Rotation Y 4 8
G 6 9 1 6 Coordinate System Rotation Cancel Y 4 9
G 7 3 9 High Speed Peck Drilling Y 6 3
G 7 4 9 LH Tapping * Y 6 6
G 7 6 9 Fine Boring * Y 6 8
G 8 0 9 Canned Cycle Cancel Y 5 8
G 8 1 9 Hole Drilling Y 5 9
G 8 2 9 Spot Face Y 6 0
G 8 3 9 Deep Hole Peck Drilling Y 6 1
G 8 4 9 RH Tapping Y 6 5
G 8 4.2 9 RH Rigid Tapping * Y 6 7
G 8 4.3 9 LH Rigid Tapping * Y 6 7
G 8 5 9 Boring , Retract at Feed, Spindle On Y 7 0
G 8 6 9 Boring, Retract at Rapid, Spindle Off Y 7 1
G 8 7 9 Back Boring* Y 7 2
G 8 8 9 Boring, Manual Retract Y 7 4
G 8 9 9 Boring, Dwell, Retract at F eed, Spindle On Y 7 5
G 9 0 3 Absolute Position Mode Y 5 0
G 9 0.1 4 Arc Center Absolute Mode Y 5 2
G 9 1 3 Incremental Position Mode Y 5 0
G 9 1.1 4 Arc Center Incrementa l Mode Y 5 2


<!-- Page 13 -->

1 3
G 9 2 0 Local Coordinate System Setting Y 5 3
G 9 2.1 0 Local Coordinate System Cancel Y 5 3
G 9 3 5 Inverse Time Feed Y 5 4
G 9 4 5 Feed per Minute Y 5 4
G 9 5 5 Feed per Revolution* Y 5 4
G 9 6 1 3 Constant Surface Speed* Y 5 4
G 9 7 1 3 Constant Speed Y 5 4
G 9 8 1 0 Initial Point Return Y 5 5
G 9 9 1 0 R Point Return Y 5 5
* Implementation based on machine and control configuration


<!-- Page 14 -->

1 4
G Code Descriptions and Examples

G 0 0 – Rapid Move
Rapid moves are used to move from point to point in free space, not cutting material. These m oves do
not require a feed rate input as they take place at max velocity of the machine. In absolute position
mode (G 9 0) X, Y and Z define the end point of the move in the user coordinate system. In incremental
position mode (G 9 1) X, Y and Z define the d istance and direction to move from the current position.
Format: G 0 0 X__ Y__ Z__
Example: Program a rapid move to X 1. 0, Y 3. 0
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1 .0 Y 3.0 Rapid to XY position
M 3 0 Progr am end and rewind

G 0 1 – Linear Feed Move
Linear feed moves are point to point moves in a straight line at a federate specified by F. The moves are
interpolated so all axes in motion reach the end point at the same time. In absolute position mode
(G 9 0) X, Y and Z define the end point of the move in the user coordinate system. In incremental position
mode (G 9 1) X, Y and Z define the distance and direction to move from the current position.
Format: G 0 1 X__ Y__ Z__ F__.
Example: Program a feed move from X 1 , Y 3, to X 1 0, Y -1 at a feed rate of 1 5 UPM.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 9 4 Feed per minute mode
G 0 X 1 .0 Y 3.0 Rapid to XY position
G 1 X 1 0 .0 Y-1.0 F 1 5.0 Move to XY position at feed rate
M 3 0 Progr am end and rewind

Note:
For clarity rotational moves have been omitted from this manual.
All motion commands can also contain A, B, and/or C axis motion.


<!-- Page 15 -->

1 5
G 0 2/G 0 3 – Arc Feed Move
Used to cut an arc at a federate specified by F . An arc is defined by its start and end points, its radius or
center point, a direction, and a plane. Direction is determined by G 0 2, clockwise, and G 0 3,
counte rclockwise , when viewed from the plane’s positive direction (If XY plane is selected look down so
that the X axis positive direction is pointing to the right, and the Y axis positive direction is pointing
forward) . See figure 2 -1 for a graphic representat ion of the motion of a G 0 2. The start point is the
current position of the machine. Specify the end point with X, Y, and Z. The values input for the end
point will depend on the current G 9 0/G 9 1 (abs/inc) setting of the machine. Only the two points in t he
current plane are required for an arc. Adding in the third point will c reate a helical interpolation.
Next is to specify the radius or the center point of the arc, on ly one or the other, not both.
 To specify the radius, use R and input the actual radiu s of the desired arc, see Format 2. When
an arc is created knowing only start and end points and a radius there are two possible
solutions, an arc with a sweep less than 1 8 0° and one with sweep greater than 1 8 0°. The sign of
the radius value, positive or negative, determines which arc will be cut, see figure 2 -2. A
positive value for R cuts an arc with sweep less than 1 8 0°. A negative value for R cuts an arc
with sweep greater than 1 8 0°.
 A more accurate and reliable way to define an arc is by specifying the center point, this is done
with arguments I, J, and K , see Format 1 . The center point must be defined in the current plane.
I, J, and K correspond to X, Y, Z respectively; the current plane selection will determine which
two are used . XY plane (G 1 7) would use I and J for example. Mach has two settings for how I, J,
and K should be specified, absolute and incremental. This setting can be changed by G code,
G 9 0.1 and G 9 1.1, or in the general tab in the Mach configuration. This setting is independent of
the G 9 0/G 9 1 setting. If arc center mode is set to incremental then I, J, K are the distance and
direction from the start point to the center point of the arc. If arc center mode is set to absolute
then I, J, K are the absolute position of the arc cen ter point in the current user coordinate
system .
Format 1: (G 1 7) G 0 2/0 3 X__ Y__ I__ J__ F__
(G 1 8) G 0 2/0 3 X__ Z__ I__ K__ F__
(G 1 9) G 0 2/0 3 Y__ Z__ J__ K__ F__
Format 2: (G 1 7) G 0 2/0 3 X__ Y__ R__ F__
(G 1 8) G 0 2/0 3 X__ Z__ R__ F__
(G 1 9) G 0 2/ 0 3 Y__ Z__ R__ F__

Example: Program an arc centered at 1 .0, 0.0 in the XY plane with radius 2. Start point at 3 .0,0.0 and
sweep 9 0 degrees counter clockwise. Feed rate 1 0 UPM. (Arc center mode set to incremental)
Format 1:
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change


<!-- Page 16 -->

1 6
S 2 5 0 0 M 3 Start spindle
G 0 X 3 .0 Y 0.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z rapid plane
G 9 4 Feed per minute mode
G 1 Z 0. 0 F 1 0. 0 Z plunge at feed rate
G 3 X 1.0 Y 2.0 I-2.0 J 0.0 F 1 0. 0 Arc move
G 0 Z.5 Retract Z to rapid plane
G 0 G 5 3 Z 0.0 Return Z to home
M 3 0 Program end and rewind
Format 2:
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 3 .0 Y 0.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z rapid plane
G 9 4 Feed per minute mode
G 1 Z 0. 0 F 1 0. 0 Z plunge at feed rate
G 3 X 1. 0 Y 2.0 R 2.0 F 1 0. 0 Arc move
G 0 Z.5 Retract Z to rapid plane
G 0 G 5 3 Z 0.0 Return Z to home
M 3 0 Program end and rewind

A helical interp olation is defined very similar to an arc. The only difference is the addition of the third
coordinate of the end point. This third coordinate will define the height of the helix. See the following
format for what this looks like in the XY plane:
Format 1: (G 1 7) G 0 2/0 3 X__ Y__ Z__ I__ J__ F__
Format 2: (G 1 7) G 0 2/0 3 X__ Y__ Z__ R__ F__
Example: Program a helix with radius 1.0 and center point 0 .0, 0.0 in the X,Y plane, start point 0 .0, .5,
height 1.0 with initial Z at 0. 0. Feed rate 1 0 UPM. Arc sweep s hould be 2 7 0° clockwise . See figure 2 -2
for the tool path.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 0 .0 Y.5 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z rapid plane
G 9 4 Feed per minute mode
G 1 Z 0. 0 F 1 0. 0 Z plunge at feed rate
G 2 X -.5 Y 0 .0 Z-1.0 I 0 .0 J-.5 F 1 0. 0 Helical interpolation
G 0 Z.5 Retract Z to rapid plane
G 0 G 5 3 Z 0.0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 17 -->

1 7
G 0 4 – Dwell
A dwell is simply a pause in the p rogram. The duration of the dwell is specified by P or X in milliseconds
with no decimal point. If a decimal point is used, then P or X specifies seconds. The dwell may also be
specified with U without a decimal point for milliseconds. No machine moveme nt will take place during
a dwell. No auxiliary codes will be turned off, i.e. if the spindle is on it will stay on, coolant will stay on,
etc.
The dwell must be the only G code in the block.
Format 1: G 0 4 P__
Format 2: G 0 4 X__
Format 3: G 0 4 U__
Example : Program a 5 second dwell after positioning to X 1.0, Z 1.0 (using no decimal point to specify
milliseconds).
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Z 1.0 Rapid to XZ position
G 4 P 5 0 0 0 Dwell for 5 seconds
M 3 0 Program end and rewind

Example: Program a 5 second dwell after positioning to X 1.0, Z 1.0 (using decimal point to specify
seconds).
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Z 1.0 Rapid to XZ position
G 4 P 5. Dwell for 5 seconds
M 3 0 Program end and rewind

Note: Setting P or X with a G code variable will imply a decimal
point and thus produce a dwell in seconds. (e.g. G 0 4 P#2)


<!-- Page 18 -->

1 8
G 0 9 – Exact Stop
G 0 9 is a non -modal exact stop. Machine accelerations cause corners to be slightly rounded; when a true
```
sharp corner is required G 0 9 should be used. Although similar to G 6 1 in function, G 0 9 is not modal
while G 6 1 is. When G 0 9 is included in a movement block, axis motion is decelerated to the end point of
motion and the position is checked to be exactly as specified. This position check at the end of the move
ensures that the machine ac tually reaches the desired position before moving onto the next block
Format: G 0 1 G 0 9 X__ Y__ F__
Example: Program a 2.0 inch square centered at X 0 .0, Y 0.0 with true sharp corners at X 1 .0, Y 1.0 and X -
1.0, Y-1.0, feed rate 1 5.0 UPM
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 9 4 Feed per minute mode
G 0 X -1.0 Y 1.0 Rapid to XY position
G 1 G 9 X 1 .0 F 1 5. 0 Move to position at feed rate, exact stop active
Y-1.0 Move to position at feed rate
G 9 X -1.0 Move to position at feed rate, exact stop active
Y 1.0 Move to position at feed rate
M 3 0 Program end and rewind

Figure 9 -1 shows what this square would look like, slightly exaggerated.
Figure 9 -1: Square with exact stop on two corners Without
Exact Stop With Exact
Stop


<!-- Page 19 -->

1 9
G 1 0 L 1 – Tool Offset Setting
Tool offset setting with G 1 0 L 1 is a superset of the common G 1 0 L 1 used on older Fanuc controllers and
it is the only way to set the X and Y offsets and wear values from a program. For compatibility with
newer controls, a more modern way of setting height and diameter offsets and their respective wear
offsets is provided by G 1 0 L 1 0, G 1 0 L 1 1, G 1 0 L 1 2, and G 1 0 L 1 3.
Format: G 1 0 L 1 P__ Z__ W__ D__ R__ X__ U__ Y__ V__ Q__
Or the modal version:
## G 1 0 L 1
## P__ Z__ W__ D__ R__ X__ U__ Y__ V__ Q__
…
## G 1 1
The multiline modal version must be can celed with G 1 1.
L 1 specifies tool offset setting, P is the offset number to be set (offset #1 = P 1, offset #2 = P 2, etc.). The
remaining arguments specify the offset type and the value of the offset.
Z Height offset
W Height wear offset
D Diameter offse t
R Diameter wear offset
X X offset
U X wear offset
Y Y offset
V Y wear offset
Q Tool pocket

All values do not need to be specified, only the ones to be set. If, for example, a Z is not programmed it
simply will not be changed in the tool offset.
In G 9 0, absolute, mode the values in the G 1 0 line will be directly input into the tool offset. When in
G 9 1, incremental, mode the values will be added to the desired tool offset. This is a major difference in
```
functionality and care should be taken to ma ke sure the right mode is active for the desired effect.

Example: Set height of tool offset #5 to 1.5. Add .0 5 to offset #2 diameter wear.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 1 0 L 1 P 5 Z 1.5 Set tool offset 5 height to 1.5
G 9 1 Set incremental to add to offset
G 1 0 L 1 P 2 R.0 5 Add .0 5 to tool offset #2 diameter wear
M 3 0 Program end and rewind


<!-- Page 20 -->

2 0

Example: Modal use of G 1 0 L 1.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 1 0 L 1 Start G 1 0 L 1 sequence.
P 5 Z 1.5 Set tool offset 5 height to 1.5
P 2 R.0 5 Set tool offset #2 diameter wear to .0 5
G 1 1 Cancel G 1 0 L 1
M 3 0 Program end and rewind


<!-- Page 21 -->

2 1
G 1 0 L 2 – Fixture Offset Setting
It is possible to set fixture and tool offsets in the program. This can be very useful for programming
```
multiple fixtures that have kno wn zero points, multi pallet machines, applying automatic compensation
of tool wear, and many other situations that require changing offset values. G 1 0 is also one of the least
understood G codes and is therefor e underutilized. Changing offset values in a program requires a bit of
cautiousness, a mistake can easily result in ruined parts and damaged tools. When used properly
however, G 1 0 can add flexibility and safety to a program and machine, especially with aut omation and
lights out capacity or inexper ienced operators.
Starting with fixture offset setting the G 1 0 block will look like the following:
Format: G 1 0 L 2 P__ X__ Y__ Z__ A__ B__ C__
Or the modal version:
## G 1 0 L 2
## P__ X__ Y__ Z__ A__ B__ C__
…
## G 1 1
The multiline modal version must be canceled wit h G 1 1.
L 2 is the designation for fixture offset setting . The value of P specifies which offset is being set. For the
basic 6 fixture offsets P values are as follows:
Fixture offset (G__) P__
5 4 1
5 5 2
5 6 3
5 7 4
5 8 5
5 9 6


<!-- Page 22 -->

2 2
The data for the fixture offset is set by X, Y, Z, A, B, C.
X X axis offset
Y Y axis offset
Z Z axis offset
A A axis offset
B B axis offset
C C axis offset

All values do not need to be specified, only the ones to be set. If, for example, a Z is not programmed it
simply wi ll not be changed in the fixture offset.
In G 9 0, absolute, mode the values in the G 1 0 line will be directly input into the fixture offset . When in
G 9 1, incremental, mode the values will be added to the desired fixture offset. This is a major difference
```
in functionality and care should be taken to make sure the right mode is active for the desired effect.

Example: Set G 5 6 fixture offset to X -8.0, Y-3.0, Z-5.0, A 4 5.0 in a program.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 1 0 L 2 P 3 X -8.0 Y-3.0 Z-5.0 A 4 5.0 Set G 5 6 fixture offset values
M 3 0 Program end and rewind

Example: The modal version of G 1 0 L 2.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 1 0 L 2 P 3 X -8.0 Y -3.0 Z -5.0 A 4 5.0
P 3 X -8.0 Y -3.0 Z -5.0 A 4 5.0 Set G 5 6 fixture offset values
P 4 X -2.0 Y -1.0 Z -3.0 A 1 5.0 Set G 5 7 fixture offset values
G 1 1 Cancel G 1 0 L 1 2
M 3 0 Program end and rewind

Work shift is set using G 1 0 L 2 P 0.
Example: Set Work Shift offset to X -7.0, Y -2.0, Z -3.0, A 1 5.0 in a program.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 1 0 L 2 P 0 X -7.0 Y -2.0 Z -3.0 A 1 1 5.0 Set Work Shift offset values
M 3 0 Program end and rewind


<!-- Page 23 -->

2 3
G 1 0 L 3 – Tool Life Management Setting
Tool life management data can be registered, changed, or deleted in a G code program. TLM is an
Industrial only feature.
There are 3 G 1 0 L 3 program formats which provide for the following actions:
Function Description
Delete all tool groups and register new data Delete all existing tool group and tool data
before adding new tool group and tool data.
This effectively replaces the entir e TLM data.
Add or change tool or group data Add or change TLM data for a tool group.
Delete tool or group data Delete TLM data for a tool group.
Specify the tool life count type How tool life is counted for an individual group
(time, frequency, and per cycle).
Specify the tool life value The time (minutes) or cycle count value.

G 1 0 L 3 is always modal and multiple lines are used in the formats. All formats of G 1 0 L 3 will require G 1 1
to cancel.

Tool groups are specified as positive integers from 1 to 9 9 9. A tool group is selected for a tool change
with the T word by addling the tool cancel number (usually 1 0 0 for a machine with 9 9 maximum tools or
1 0 0 0 for a machine with 9 9 9 maximum tools) that is defined in system variable #6 8 1 0 to the desired
tool group number. For example, to select a tool from group 2 on a 9 9 max tool machine with a tool
cancel number defined as 1 0 0, specify T 1 0 2.
The tool life count type is specified with a 1 (cycle count) or 2 (time) . The time based life count is best
suited for cutting tools that can be characterized by the amount of cutting time they can endure and still
remain viable. The cycle based life count is best suited for tools that are typically used in canned cycles
that can typically be characterized by the number holes or bores they can endure and still remain viable.
The tool life value is a positive integer number that specifies the life of the tool (minutes or number of
cycles the tool is used). It will count up from 0 to the life count specified by t he group, at which point,
the tool’s life will expire .
Unlike a Fanuc, the only limit to the number of tools in a tool group is the maximum tool setting for the
control, which is limited to 9 9 9 tools.


<!-- Page 24 -->

2 4
G 1 0 L 3 Format 1 - Register with deleting all gr oups
The G 1 0 L 3 line starts the sequence . The next line specifies the group P_, the life count value L_ , and
the optional life count type Q_ . If Q is not specified, the value of bit 2 (0 == cycle or 1 == time ) in system
variable #6 8 0 0 will determine the life count type. The next line(s) specify the tool number T_, the
optional H code for the height offset H_, and the optional D code for the diameter offset D_. If H or D is
not specified, the value for T will be used. The T_ H_ D_ line may be repeated f or as many tools in the
group as needed. Multiple tool groups can be populated by adding a new P_ L_ line sequence with its’
```
own following T_ H_ D_ lines. The G 1 0 function is then canceled with G 1 1.
Format:
## G 1 0 L 3
P__ L__ [Q__]
T__ [H__] [D__]
…
## G 1 1
Example: Delete all tool group information and add new data.
G 1 0 L 3 Start the register with delete sequence (No P_
given). This will delete all preexisting TLM data.
P 1 L 1 0 0 0 Q 1 Select group 1 with a 1 0 0 0 life count and a cycle
based life count type.
T 1 Add too 1 1 to group 1 using H and D offsets
from tool 1.
T 2 H 1 D 1 Add tool 2 but use tool 1 H and D offsets.
P 2 L 5 0 0 0 Q 2 Select group 2 with a 5 0 0 0 life count with a time
based life count type.
T 3 Add tool 3 to group 2.
T 4 Add tool 4 to group 2
G 1 1 End G 1 0 sequence.


<!-- Page 25 -->

2 5
G 1 0 L 3 Format 2 – Add or change tool group
The G 1 0 L 3 P 1 line to starts the sequence. The next line specifies the group P_, the life count value L_,
and the optional life count type Q_. If Q is not specified, the value of bit 2 (0 == cycle or 1 == time ) in
system variable #6 8 0 0 will determine the life count type. If the group did not exist, it is added. If the
group exists the L_, and Q_ values will be updated with the specified values. The next lines specify the
tool number T_, the optional H code for the height offset H_, and the optional D c ode for the diameter
offset D_ . If H or D is not specified, the value for T will be used. If the tool did not exist in the group, the
tool will be added. If the tool exists in the group, the values will be updated with the specified values.
The T_ H_ D_ line may be repeated for as many tools in the group as needed. Multiple tool groups can
be populated by adding a new P_ L_ line sequence with its’ own following T_ H_ D_ lines. The G 1 0
func tion is then canceled with G 1 1.
Format:
## G 1 0 L 3 P 1
P__ L__ [Q__]
T__ [H__] [D__]
…
## G 1 1
Example: Add or change tool group information.
G 1 0 L 3 P 1 Start the register or change tool group
sequence.
P 1 L 1 0 0 0 Q 1 Select group 1 with a 1 0 0 0 life count and a cycle
based life count type. Assume that the group
exists and that only the life count was updated.
T 1 Add too 1 1 to group 1 using H and D offsets
from tool 1.
T 2 H 1 D 1 Add tool 2 but use tool 1 H and D offsets.
Assume that the tool already existed in the
group, but H and D were changed.
P 2 L 5 0 0 0 Q 1 Select group 2 with a 5 0 0 0 life count with a cycle
based life count type. Assume that the group
didn’t exist therefore it will be added.
T 3 Add tool 3 to group 2.
T 4 Add tool 4 to group 2
G 1 1 End G 1 0 sequenc e.


<!-- Page 26 -->

2 6
G 1 0 L 3 Format 3 – Delete tool life data
The G 1 0 L 3 P 2 line to starts the sequence. The next line specifies the group P_, to delete. Multiple
```
groups can be specified for del etion on the following lines as needed. The G 1 0 function is then
cancele d with G 1 1.
Format:
## G 1 0 L 3 P 2
## P__
…
## P__
…
## G 1 1
Example: Delete selected tool groups.
G 1 0 L 3 P 2 Start the d elete tool life data sequence.
P 1 Delete group 1.
P 2 Delete group 2.
G 1 1 End G 1 0 sequence.

G 1 0 L 1 0 – Geometry compensation value for H code
The H code offset can be se t individually with G 1 0 L 1 0.
The G 1 0 block will look like the following:
Format: G 1 0 L 1 0 P__ R__
Or the modal version:
## G 1 0 L 1 0
## P__ R__
…
## G 1 1
The multiline modal version must be canceled with G 1 1.
L 1 0 specifies setting the H code o ffset, P is again the offset number to be set (offset #1 = P 1, offset #2 =
P 2, etc.). R is the offset value.
In G 9 0, absolute, mode the values in the G 1 0 line will be directly input into the tool offset. When in
G 9 1, incremental, mode the values will be added to the desired tool offset. This is a major difference in
```
functionality and care should be taken to make sure the right mode is active for the desired effect.


<!-- Page 27 -->

2 7
G 1 0 L 1 1 – Wear compensation value for H code
The H code wear offset can be se t individ ually with G 1 0 L 1 1.
The G 1 0 block will look like the following:
Format: G 1 0 L 1 1 P__ R__
Or the modal version:
## G 1 0 L 1 1
## P__ R__
…
## G 1 1
The multiline modal version must be canceled with G 1 1.
L 1 1 specifies setting the H code wear offset, P is again the offse t number to be set (offset #1 = P 1, offset
#2 = P 2, etc.). R is the offset value.
In G 9 0, absolute, mode the values in the G 1 0 line will be directly input into the tool offset. When in
G 9 1, incremental, mode the values will be added to the desired tool o ffset. This is a major difference in
```
functionality and care should be taken to make sure the right mode is active for the desired effect.

G 1 0 L 1 2 – Geometry compensation value for D code
The D code offset can be se t individually with G 1 0 L 1 2.
The G 1 0 b lock will look like the following:
Format: G 1 0 L 1 2 P__ R__
Or the modal version:
## G 1 0 L 1 2
## P__ R__
…
## G 1 1
The multiline modal version must be canceled with G 1 1.
L 1 2 specifies setting the D code offset, P is again the offset number to be set (offset #1 = P 1, offset #2 =
P 2, etc.). R is the offset value.
In G 9 0, absolute, mode the values in the G 1 0 line will be directly input into the tool offset. When in
G 9 1, incremental, mode the values will be added to the desired tool offset. This is a major difference in
```
functionality and care should be taken to make sure the right mode is active for the desired effect.


<!-- Page 28 -->

2 8
G 1 0 L 1 3 – Wear compensation value for D code
The D code wear offset can be se t individually with G 1 0 L 1 3.
The G 1 0 block will look like the following:
Format: G 1 3 L 1 1 P__ R__
Or the modal version:
## G 1 0 L 1 3
## P__ R__
…
## G 1 1
The multiline modal version must be canceled with G 1 1.
L 1 3 specifies setting the D code wear offset, P is again the offset number to be set (offset #1 = P 1, offset
#2 = P 2, etc.). R is the offset value.
In G 9 0, absolute, mode the values in the G 1 0 line will be directly input into the tool offset. When in
G 9 1, incremental, mode the values will be added to the desired tool offset. This is a major difference in
```
functionality and care sho uld be taken to make sure the right mode is active for the desired effect.

G 1 0 L 2 0 – Additional Fixture Offset Setting
Additional fixture offsets, G 5 4.1 Pxx, can also be set using G 1 0 . Setting of the se offsets is the same,
except it is done using L 2 0. T he legacy additional fixture offsets (see fixture offset section of this manual
for more details) can still be set with G 1 0. The following table shows the additional fixture offset P
number and its corresponding G 1 0 P number as well as the legacy offsets . Note that G 5 4.1 P 1 is the
same offset as G 5 9 P 7, so G 1 0 L 2 0 P 1 and G 1 0 L 2 P 7 both set the same offset values.
Starting with additional fixture offset setting the G 1 0 block will look like the following:
Format: G 1 0 L 2 0 P__ X__ Y__ Z__ A__ B__ C__
Or the modal version:
## G 1 0 L 2 0
## P__ X__ Y__ Z__ A__ B__ C__
…
## G 1 1
The multiline modal version must be canceled with G 1 1.


<!-- Page 29 -->

2 9
G 5 4.1 P__ G 1 0 L 2 0 P__ Legacy G 5 9 P__ Legacy G 1 0 L 2 P__
1 1 7 7
2 2 8 8
3 3 9 9
- - - -
- - - -
- - - -
2 4 8 2 4 8 2 5 4 2 5 4

Example: Set G 5 4.1 P 5 fixture offset to X 3. 0, Y 3.4, Z -1 0.0 in a program.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start lin e
G 1 0 L 2 0 P 5 X 3.0 Y 3.4 Z -1 0.0 Set G 5 4.1 P 5 fixture offset values
M 3 0 Program end and rewind

Example: The modal version of G 1 0 L 2 0.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start lin e
G 1 0 L 2 0 Start the G 1 0 L 2 0 sequence
P 5 X 3.0 Y 3.4 Z -1 0.0 Set G 5 4.1 P 5 fixture offset values
P 6 X 2.0 Y 2.1 Z -8.0 Set G 5 4.1 P 6 fixture offset values
G 1 1 Cancel G 1 0 L 2 0
M 3 0 Program end and rewind

Head shift is set using G 1 0 L 2 0 P 0. Notice the L 2 0 for head shift. All other values are set in the same
format as the other fixture offsets.
Example: Set Head Shift offset to X -3.0, Y 1.5, Z -8.0 in a program.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start lin e
G 1 0 L 2 0 P 0 X -3.0 Y 1 1.5 Z -8.0 Set Head Shift offset values
M 3 0 Program end and rewind


<!-- Page 30 -->

3 0
G 1 0 L 5 0 – Parameter Setting
G 1 0 L 5 0 enables setting machine control parameters programmatically and is modal.

Format: G 1 0 L 5 0
## N__ R__
…
## N__ R__
## G 1 1

L 5 0 specifies parameter setting mode, N specifies the parameter number, and R specified the new
parameter value. R may be entered as a decimal number or a binary number. Binary numbers are read
from the heist bit to the lowest bit and must be at least 8 characters long with leading zeros, if required.

Example: Set parameter 6 7 1 2 (total parts machined) to 5 via binary and then to 1 0 1 via
decimal.
G 1 0 L 5 0 Start the parameter setting sequence.
N 6 0 1 2 R 0 0 0 0 0 1 0 1 Set 6 7 1 2 = 5. (0 b 0 0 0 0 0 0 0 1 0 1 == 5)
N 6 0 1 2 R 1 0 1 Set 6 7 1 2 = 1 0 1
G 1 1 End G 1 0 sequence.

```
Parameters ma y be read in G code programs via the PRM[] function.

Example: Read parameter 6 7 1 2 as a number and as a bit value.
#1 0 0=PRM[6 0 1 2] Read parameter 6 0 1 2 into common variable
#1 0 0.
#1 0 1=PRM[6 0 1 2, 2] Read bit 1 of parameter 6 7 1 2 into common
variable #1 0 0. I f bit 2 is set, #1 0 1 will be 1,
otherwise #1 0 1 will be 0.

G 1 1 – Cancel Modal G 1 0
To end the G 1 0 modal state a G 1 1 must be called. G 1 1 should be specified on its own line. The only
G 1 0 that is always modal is G 1 0 L 3 (Tool Life Management) setting.
Form at: G 1 1


<!-- Page 31 -->

3 1
G 1 2/G 1 3 – Circle Interpolation
These codes are used to cut a circle using the current position as the center point. Words , I and J, define
the radius of the circle and the lead -in direction . G 1 2 will cut a circle in the clockwise direction and G 1 3
will cut in the counterclockwise direction. It is also possible to cut a larger circular pocket by specifying
Q for the start radius and P for the step over amount. This ca n be useful for cutting a circular pocket or
an ID groove.
Format 1: G 1 2/1 3 I __ J__ F__
Format 2: G 1 2/1 3 I__ J__ P__ Q__
See figure 1 2 -1 for a graphi c of the motion. The current position will be the center of the circle.

Example: Cut a 1.0 inch radius circle centered at X 1.5 Y 0.2 5. Lead -in along the X axis.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start lin e, absolute mode, XY plane
G 0 X 1.5 Y.2 5 Move to initial position
G 1 3 I 1.0 F 3 0.0 Cut circle
G 0 G 5 3 Z 0.0 Z axis to machine zero
M 3 0 Program end and rewind

Figure 1 2 - 1: Tool motion during circle interpolation Center Point I,J Q P Center Point I J Radius


<!-- Page 32 -->

3 2
Example: Cut the same circle but lead -in at 4 5°. (X= 1*Cos(4 5°)=.7 0 7 1, Y=1* Sin(4 5°)=.7 0 7 1 )
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start lin e, absolute mode, XY plane
G 0 X 1.5 Y.2 5 Move to initial position
G 1 3 I 0.7 0 7 1 J 0.7 0 7 1 F 3 0.0 Cut circle
G 0 G 5 3 Z 0.0 Z axis to machine zero
M 3 0 Program end and rewin d

G 1 5/G 1 6 – Polar Coordinates
To enable polar coordinate positioning command G 1 6 in a program. The setting is modal and will
remain active until G 1 5, polar coordinate cancel, is commanded or the system is reset. In the polar
coordinate mode movement en d points are specified as a radius and angle, the origin of which is
determined by the absolute/incremental position mode setting (see G 9 0/G 9 1). In absolute position
mode the origin for positioning is the zero point of the user coordinate system. In incr emental position
mode the origin is the current position.
Format: G 1 6 X__ Y__ Z__
The current plane setting determines which word is radius and which is angle.
G 1 7 – XY Plane – X is radius, Y is angle
G 1 8 – ZX Plane – Z is radius, X is angle
G 1 9 – YZ Pla ne – Y is radius, Z is angle
Linear and arc moves can be programmed in the polar coordinate mode. When programming arc moves
with G 0 2 and G 0 3 use R to specify the arc radius.
Example: See figure 1 5 -1 for the tool path display of the following program.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start lin e, absolute mode, XY plane
G 1 6 Enable polar coordinate mode
G 0 X 1.0 Y 4 5.0 Move to radius 1 and 4 5° from origin
G 3 X 1.0 Y 1 3 5.0 R 0.7 5 F 6 0.0 Arc move of radius .7 5, endpoint at radius 1.0
and angle 1 3 5°
G 1 X 2.2 5 Y 1 8 0. 0 Linear move to radius 2.2 5 angle 1 8 0°
G 3 X 2.2 5 Y 0 R 5.0 Arc move of radius 5., endpoint at radius 2.2 5,
angle 0
G 1 X 1.0 Y 4 5.0 Linear move to radius 1.0, angle 4 5°
G 1 5 Disable polar coordinate mode
G 0 G 5 3 Z 0.0 Z axis to machine zero
M 3 0 Program end an d rewind


<!-- Page 33 -->

3 3

Angle Radius
Figure 1 5 - 1: Tool path of polar coordinate mode example


<!-- Page 34 -->

3 4
G 1 7/G 1 8/G 1 9 – Plane Selection
Arcs, circles and drill cycles require the selection of a plane. The three axes X, Y and Z define three
available planes XY, ZX, and YZ , see figure 1 7 -1. The third axis defines the t op of the plane, this axis is
also known as the normal see figure 1 7 -2. Selection of a plane is done by specifying one of three G
codes: G 1 7 for XY, G 1 8 for ZX and G 1 9 for YZ. These are modal G codes and will stay active until another
plane is selected or the system is reset . The default plane selection is G 1 7.
All arc and circular motion will take place on a single plane. Direction of motion, clockwise or
counterclockwise, is as viewed from the n ormal direction, see figure 1 7 -2.
Canned drill cycles als o require the selection of a plane. In this case all hole positions will be located in
the selected plane and the normal axis will be the drilling axis. For example in the XY plane the Z axis is
the drilling axis.

Figure 1 7 -1: Planes


<!-- Page 35 -->

3 5

Figure 1 7 -2: Plane orientation
Axis 1 + Direction
Axis 2 + Direction Axis 3 + Direction
(Normal)
Look at plane
from normal
direction
G 2 0/G 2 1 – Unit selection
Programming units are selected using G 2 0 for inch and G 2 1 for millimeter. Use these G codes to specify
the units in the program only; the setting will not affect Mach DRO’s , configuration settings , or offsets .


<!-- Page 36 -->

3 6
G 2 8 – Zero Return
```
This function is used to send one or more axes to the home position via an intermediate point. Exercise
```
caution when using this function. If not fully understood the resulting motion may differ greatly from
what is expected. When used correctly the intermediate point can be useful for av oiding obstacles in
the way of a direct path to the home position, see figure 2 8 -1.
Figure 2 8 -1: Zero return via intermediate point Work Piece G 0 G 9 1 G 2 8 Y 0.0 Z 0.0
or
G 0 G 9 0 G 5 3 Y 0.0 Z 0.0 Tool G 0 G 9 1 G 2 8 Y 0.0 Z 1.0
or
G 0 G 9 0 G 2 8 Y -2.0 Z 0.5 Machine Home Z
Y
Fixture Zero Z
Y
Start point
Y-2.0, Z -0.5

Format: G 2 8 X__ Y__ Z__ A__ B__ C__
This is not a modal code and will only be active in the block in which it is specified. Follow ing the G 2 8
are the axes to be sen t home. For example, to send the Z axis back to the home position program: G 2 8
Z 0. The value specified with the axis letter specifies the intermediate point.
Look at an example program:
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start lin e
G 0 X 1 .0 Y.5 Z 1.0 Rapid p osition to point
G 2 8 Z 0 .0 Send Z axis home via point Z 0
M 3 0 Program end and rewind


<!-- Page 37 -->

3 7
Reading through the program there is a safe start up block that sets the machine to absolute position
mode. The next line causes the machine to move to the point X 1, Y.5, Z 1. in the coordinate system set
by the G 5 4 fixture offset. Now for the G 2 8 block. This line of code, G 2 8 Z 0, gives instructions to send
the Z axis to the home position via the point Z 0. The motion will be as follows: First the Z axis will
plunge t o the point Z 0 then return to home. If not intended this motion could result in a broken tool or
scrapped part. To avoid this unintended motion the common programming format is as follows:
## G 9 1 G 2 8 Z 0
In this case the intermediate point is an incremental move of 0 inches resulting in no motion before the
Z axis returns home.
G 2 8.1 – Home Axis
G 2 8.1 physically homes the specified axes. If more than one axis is specified, then the axes are homed
in order specified by the control configuration. The values of the parameters are ignored except in the
case of P. If P is specified, the corresponding out of band axis is homed. Valid values for P are P 6
through P 1 1. P can only be specified once.
Format: G 2 8.1 X__ Y__ Z__ A__ B__ C__ P__
G 3 0 – 2 nd, 3 rd, 4 th Zero Return
```
G 3 0 functions the same way as G 2 8 , moving the machine to a zero return point via an intermediate
point. However, instead of sending the machine to the home position, G 3 0 movement ends at a user
definable 2 nd, 3 rd, or 4 th zero return point, specified by P 2, P 3, or P 4 respectively. If P is omitted the 2 nd
zero return point is selected. This is handy for tool changers that are not located at the home position
or any number of other applications.
Format: G 3 0 P__ X__ Y__ Z__ A__ B__ C__
The 2 nd zero return point is defined by # variables as follows:
Axis P 2 # Variables P 3 # Variables P 4 # Variables
## X 5 3 0 1 5 3 1 1 5 3 2 1
## Y 5 3 0 2 5 3 1 2 5 3 2 2
## Z 5 3 0 3 5 3 1 3 5 3 2 3
## A 5 3 0 4 5 3 1 4 5 3 2 4
## B 5 3 0 5 5 3 1 5 5 3 2 5
## C 5 3 0 6 5 3 1 6 5 3 2 6
The position values in the # varia bles can be set in a program or in MDI mode.


<!-- Page 38 -->

3 8
```
G 3 1/G 3 1.X – Probe function
```
Also known as skip function, G 3 1 allows the use of part and tool probes. Multiple probes can be used,
```
G 3 1 for probe 1, G 3 1.1 probe 2, G 3 1.2 probe 3 and G 3 1.3 probe 4 . Motion is def ined along linear axes ,
in a similar format to G 0 1, with a feed rate.
Format: G 3 1 X__ Y__ Z__ F__
The machine will move toward the specified end point, at the same time it is looking for the probe input
to be activated. When the probe input is activate d the current position is recorded to # variables
according to the table below an d motion is stopped . The recorded position can then be used to
calculate tool offsets, work offsets, measure parts, etc.
Axis G 3 1 User Position
Variables G 3 1 Machine
Position Variables
X #5 0 6 1 #5 0 7 1
Y #5 0 6 2 #5 0 7 2
Z #5 0 6 3 #5 0 7 3
A #5 0 6 4 #5 0 7 4
B #5 0 6 5 #5 0 7 5
C #5 0 6 6 #5 0 7 6


<!-- Page 39 -->

3 9
G 3 2 – Threading
It is possible to cut threads using a spindle to rotate the work piece and a non rota ting threading tool.
Equal lead straight, tapere d and scroll threads can be cutting using this command. Spindle speed
feedback from an encoder, index pulse, tachometer or other device is required for this operation. The
syncing of the feed axis to the spindle speed creates an accurate thread; however, axis acceleration can
cause variations in the thread lead especially at the start and end of the t hread. The compensate
program a slightly longer thread to give the axis time to accelerate. The amount of extra thread length
will vary based on machine sp ecifications. Changes in spindle speed and feed rate will impact thread
quality and accuracy. Using constant surface speed mode can also result in variations in thread lead
when cutting tapered or scroll threads, use G 9 7 constant RPM mode instead. Durin g the threading
move the spindle speed and feed rate overrides will be disabled and the machine will run at 1 0 0%. Feed
hold will be delayed, if pressed the machine will stop at the end of the threading move.
Format: G 3 2 X__ Y__ Z__ F__
The G 3 2 threadin g cycle is a single linear move synced to the spindle speed. F specifies the lead or pitch
of the thread. For example a 2 0 TPI thread would have a pitch of .0 5 inches, so program F.0 5. By
default the movement is basic linear move with synced feed rate. Machine builders and advanced users
have the added option to create custom M codes to specify the feed vector to create custom threads.
Example: Thread a ¼ -2 0 rod held in the spindle, 1” length of thread.
G 0 G 9 0 G 5 4 G 1 8 G 4 0 G 4 9 G 8 0 Safe start line
G 0 X 0. 3 Y 0.0 Z 0.1 Rapid position
G 9 7 S 1 0 0 0 M 3 Start spindle at 1 0 0 0 RPM
G 0 X 0. 2 2 Move to start position for rough
G 3 2 X 0.2 2 Z -1.0 F.0 5 Cut straight thread
G 0 X 0.3 Retract X axis
Z 0.1 Retract Z axis
X 0.2 1 Move to start position for finish
G 3 2 X 0.2 1 Z -1.0 F .0 5 Cut straight thread
G 0 X 0.3 Retract X axis
Z 0.1 Retract Z axis
G 5 3 Z 0.0 M 5 Z home and stop spindle
M 3 0 Program end and rewind


<!-- Page 40 -->

4 0
Threads can also be cut with a taper by adding the proper end point.
Example: Cut same thread as previous example with 0.0 3 taper.
G 0 G 9 0 G 5 4 G 1 8 G 4 0 G 4 9 G 8 0 Safe start line
G 0 X 0.3 Y 0.0 Z 0.1 Rapid position
G 9 7 S 1 0 0 0 M 3 Start spindle at 1 0 0 0 RPM
G 0 X 0.2 2 Move to start position for rough
G 3 2 X 0.2 5 Z -1.0 F.0 5 Cut tapered thread
G 0 X 0.3 Retract X axis
Z 0.1 Retract Z ax is
X 0.2 1 Move to start position for finish
G 3 2 X 0.2 4 Z -1.0 F.0 5 Cut tapered thread
G 0 X 0.3 Retract X axis
Z 0.1 Retract Z axis
G 5 3 Z 0.0 M 5 Z home and stop spindle
M 3 0 Program end and rewind
Straight thread Tapered thread Scroll thread
Figure 3 2 -1: Basic thread types

G 4 0 – Cutter Compensation Cancel
G 4 0 c ancels the cutter co mpensation mode.
G 4 0.1 – Arc Type Cutter Compensation
G 4 0.1 s elects the arc type cutter compensation mode. In this mode, external corners will generate a
rounded path, this provides smoother motion at high feed rates, see figure 4 0 1 -1, G 4 0.1. Cutter comp
modes can be changed on the fly, figure 4 0 1 -2. See the cutter compensation section of this manual for
more details and limitations.


<!-- Page 41 -->

4 1


<!-- Page 42 -->

4 2
G 4 0.2 – Line Offset Type Cutter Compensation
G 4 0.2 s elects the line offset type cu tter compensation mode. In this mode, external corners will
generate a square path, see figure 4 0 1 -1, G 4 0.2. Cutter comp modes can be changed on the fly, figure
4 0 1-2. See the cutter compensation section of this man ual for more details and limitations.
G 4 1/G 4 2 – Cutter Compensation Left/Right
Enables cutter compensation to the left (G 4 1) or right (G 4 2) of the cutter path by an amount specified in
an offset selected by D.
Format: G 1 G 4 2 D__ X__ Y__ Z__ F__
For det ailed information see the cutter compensation section of this manual.
G 4 3/G 4 4 – Tool Length Offset
Activates a tool length offset selected with H . When activated the position DROs will be updated to
display the positi on of the program point of the tool, generally the tip. The tool offset can be applied in
the positive direction with G 4 3 or in the negative direction with G 4 4. Generally G 4 3 will be used to
apply the tool offset. There are a number of ways of touching off a tool and determining the offset
value, see tool offsets in the operation manual for more details, but they are all called and applied the
same way.
Format: G 4 3 H__ X__ Y__ Z__
If axis positions are specified in the same block as G 4 3 the machine wi ll move to the commanded point.
If the axes are omitted there will be no motion.
G 4 9 – Tool Length Offset Cancel
G 4 9 c ancels the tool length offset. If no motion is commanded in the G 4 9 block there will be no motion
of the machine.
G 5 0 – Scaling Cancel
G 5 0 cancels scaling.


<!-- Page 43 -->

4 3
G 5 1 – Scaling/Mirroring Function
```
When activated the scaling function multiplies all commanded positions by the specified scale factor.
The DROs and offsets are not affected, but motion commanded from a program or the MDI screen is
affected.
Format: G 5 1 X__ Y__ Z__ A__ B__ C__
Specify the axis to be scaled and the desired scale factor. For example:
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 0 X 4. 0 Y 0.0 Z 1.0 Rapid position to point (X position is 4.)
G 5 1 X 2. 0 Activate scaling o n X axis (scale factor = 2)
G 0 X 5. 0 Rapid position to point (X position is 1 0.)
G 5 0 Cancel Scaling
G 0 X 5. 0 Rapid position to point (X position is 5.)
M 3 0 Program end and rewind

When scaling is active position moves will be calculated by multiplying t he commanded position by the
scale factor. In the example above the scale factor on the X axis is set to 2, then a move to X 5. is
commanded. The actual end position of this move will be 5 * 2 = 1 0. So the X axis moves to 1 0.
Exercise caution when using scaling, the results can be unpredictable depending on program complexity.
For example if G 5 2 X 2 Y 4 is programmed followed by an arc move in the XY plane, the arc will NOT be
scaled 2 x in the X axis and 4 x in the Y axis to obtain an ellipse. The start an d end positions will be as
expected, but the motion from one to the other may not be. Check and double check the tool path
display before running the program.
To mirror a program, enter a negative scale value. For example:
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 0 X 4. 0 Y 0.0 Z 1.0 Rapid position to point (X position is 4.)
G 5 1 X -1.0 Mirror X axis (scale factor = 1)
G 0 X 5. 0 Rapid position to point (X position is -5.)
G 5 0 Cancel Scaling
G 0 X 5. 0 Rapid position to point (X position is 5.)
M 3 0 Program end and rewind


<!-- Page 44 -->

4 4
G 5 2 – Local Coordinate System Shift
The local coordinate system setting is a programmable work shift . The setting is global; the entire
system is shifted by the specified values. Every fixture offset will be affected, although the actu al fixture
offset values will not be changed.
Format: G 5 2 X__ Y__ Z__ A__ B__ C__
To activate a local coordinate system with G 5 2 use the above format. Setting of a local coordinate
system is just like setting a fixture offset. In the G 5 2 block speci fy the desired axes to set, and the value
of the shift . For example (see figure 5 2 -1 for the tool path) :
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 0 X -4.0 Y 0.0 Z 1.0 Rapid position to point
G 1 2 I 2.0 F 3 0.0 Cut circle with radius 2.0
G 5 2 X 7. 0 Local Coo rdinate system active, X offset = 7
G 0 X -4.0 Y 0.0 Z 1.0 Rapid to same start point
G 1 2 I 2.0 F 3 0.0 Cut same circle with radius 2.0
G 5 2 X 0. 0 Local coordinate system cancelled
M 3 0 Program end and rewind
Figure 5 2 -1: Example program tool path.

Once set, the setting will remain until cancelled b y another G 5 2 or the system is reset. As in the
example above, a local coordinate system can be cancelled by specifying the axis with a value of zero.
This effectively sets th e local coordinate system shift to zero, giving it no effect.


<!-- Page 45 -->

4 5
G 5 3 – Machine C oordinate System
Although the majority of machine positioning will take place in a user created coordinate system it is
sometimes beneficial to program positions in the machine coordinate system. G 5 3 is a non modal, only
active for the block in which it i s specified, G code that allows the user to make positioning moves in the
machine coordinate system. This can be useful for moving to a load/unload position at the end of a
program or moving to a tool change location in a tool change macro. This is also a much safer way to
move back to the machine home position, G 5 3 X 0 Y 0 Z 0, than using G 2 8 as there is no intermediate
position to be concerned with.
Format: G 5 3 X__ Y__ Z__ A__ B__ C__
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 0 X 4. 0 Y 0.0 Z 1.0 Rapid position in G 5 4
… Body of program
G 5 3 Z 0. 0 Return directly to Z home position
G 5 3 X 1 0. 0 Y 0.0 Move to load/unload position
M 3 0 Program end and rewind

In the example above, the last two positioning moves are made in the machine coordinate system.
These two blocks could be the same for every program in this machine.
G 5 4 -G 5 9 – Fixture Offset
These G codes are u sed to select the active fixture offset in a program. The fixture offset will stay active
until another is called or the system is reset. It is possible to use multiple fixture offsets in a single
program.
G 5 4.1 – Additional Fixture Offsets
Additional fixture offsets are provided for users with many fixtures/parts/ setups. There are 2 4 8
additional offsets available.
Format: G 5 4.1 P__
P specifies the number of the additional offset, 1 thru 2 4 8.
Previous version of Mach use G 5 9 P 7, P 8 and so on. These legacy offsets can still be used in place of the
G 5 4.1. G 5 9 P 7 = G 5 4.1 P 1, G 5 9 P 8 = G 5 4.1 P 2, and so on. G 5 4.1 is more consistent with industry
machines.
Please see the fixture offset section of the Mach 4 Mill Operations Guide for more detail on setting up
fixture offsets .


<!-- Page 46 -->

4 6
G 6 0 – Unidirectional Approach
In cases where mechanical backlash causes positioning errors unidirectional approach can be used to
increase accuracy. G 6 0 is a non -modal code, when specified in a movement block motion will move to
the end point from a parameter defined distance and direction , see figure 6 0 -1. The distance and
direction of the approach movement is specified by set ting values in # variables as shown in the
following table:
Axis # Variable
## X 5 4 4 0
## Y 5 4 4 1
## Z 5 4 4 2
## A 5 4 4 3
## B 5 4 4 4
## C 5 4 4 5

Format: G 6 0 G 0/G 1 X__ Y__ Z__
When unidirectional approach is used in a drill cycle the Z axis motion is not affected. G 7 6 and G 8 7
boring cycles have a tool shift that is also not affected by the G 6 0 unidirectional approach.
Figure 6 0 -1: Unidirectional approach.Note: Example assumes X and Y
unidirectional approach
parameters are set to positive
values XY
## G 0 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0
G 0 X 2.0 Y 0 Z 1.
## S 1 0 0 0 M 3
## G 6 0 X 0
G 8 1 Z -0.5 F 2 0.
G 6 0 Y -1.0
G 6 0 X 1.0
G 6 0 X 1.5 Y -1.5
## M 3 0 1
2
3
4
5 1 Position to start point, X 2.0, Y 0.0
2 Move to X 0.0 with unidirectional approach
Start point
End point
Approach distance (X)
3 Move to Y -1.0 with
unidirectional approach Start point
End point
Approach
distance (Y)
4 Move to X 1.0 with unidirectional approach
Start point
End point
Approach distance (X)
5 Move to X 1.5, Y -1.5 with unidirectional approach
End point Start point
Approach distance (X)Approach
distance (Y)


<!-- Page 47 -->

4 7
G 6 1 – Exact Stop Mode
In exact stop mode the machine will decelerate to a complete stop at the end of each commanded
move , see figure 9 -1. This is a moda l code, once activated it will remain on until canceled. For sharp
corners and simple positioning this mode works well. However, when the code gets more complex, or in
side milling with arcs, the exact stop mode will produce jerky motion and witness mark s on the work
piece. For most milling jobs use G 6 4.
G 6 4 – Constant Velocity Mode
In constant velocity mode Mach will try to maintain feed rate even around sharp corners. As a result
sharp corners will be slightly rounded and the machine may never reach t he programmed point before a
direction change. The magnitude of these position errors will be determined by the acceleration
capability of the machine and the programmed feed rate. In most cases the error will be too small to
notice or affect part functi on. Cutting will be faster and smoother with better finishes and no witness
marks from stopping. This will be the active mode for the majority of machining time. It is modal and
will be active until exact stop mode is activated.
G 6 5 – Macro Call
Macros work like subprograms (see M 9 8 on page 8 6) but allow values to be passed from the main
program in the form of local variables. Macro programs can use these local variables passed to it to
change part dimensions, select features, adjust feed rates, or anything else the user could need to
change.
Format: G 6 5 P____ A__ B__ C__ …
The desired program number to be called is specified by P. The remaining arguments are determined by
the macro program being called. The values of these argu ments will be passed to local variables for use
in the macro program. The available arguments and corresponding variables are shown in the table
below.
Address Variable Address Variable Address Variable
A #1 I #4 T #2 0
B #2 J #5 U #2 1
C #3 K #6 V #2 2
D #7 M #1 3 W #2 3
E #8 Q #1 7 X #2 4
F #9 R #1 8 Y #2 5
H #1 1 S #1 9 Z #2 6

The G 6 5 macro call is non modal and has no option for repeating, the macro subprogram will be run
only once per G 6 5 call. For more information on macro programming and the availabil ity and use of #
variables see the Mach 4 Macro Programming Guide.


<!-- Page 48 -->

4 8
G 6 6 – Macro Modal Call
Sometimes it is useful to run the same macro in different positions (similar to drilling canned cycles) or
with different parameters. G 6 6 is a modal macro call, th e macro is called and values passed in the same
way as G 6 5, but G 6 6 remains active until cancelled . The block(s) following the G 6 6 can contain new
positions and variables to run the macro again.
Format: G 6 6 P____ A__ B__ C__ …
A__ B__ C__ …
## G 6 7
More information on macro programming is available in the Mach 4 Macro Programming Guide.
G 6 7 – Macro Modal Call Cancel
G 6 7 c ancels the macro modal call.
G 6 8 – Coordinate System Rotation
It is possible to rotate a program around a specified point using th e coordinate system rotation
command. It is specified as follows:
Format: G 6 8 X__ Y__ R__
The command is only available in the XY (G 1 7) plane and is modal. X and Y specify the point around
which the program will be rotated, and R specifies the angle. A positive value for R will rotate the
program counter clockwise when looking at the plane from the positive direction.
Once the rotation command is given, all command moves will take place in this rotated system. In
effect, the X and Y axes of the machine will rotate the amount specified by R.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 0 X 0 .0 Y 0.0 Z 1.0 Rapid position to point
G 6 8 X 0 .0 Y 0.0 R 4 5. 0 Rotate 4 5° counter clockwise about X 0, Y 0
G 0 X 1. 0 Rapid position to X 1.
G 6 9 Cancel rotation
M 3 0 Program en d and rewind

In the example above, the machine will move to X 0, Y 0 then initiate the coordinate rotation of 4 5°. The
next move is a purely X axis move to X 1. However, because the coordinate system has been rotated the
current X axis is actually 4 5° fro m the machine actual X axis. When the move takes place both X and Y
axes will move to the programmed point. In this case the DROs will read X.7 0 7 1 and Y.7 0 7 1. See figure
6 8-1.


<!-- Page 49 -->

4 9

Figure 6 8 -1: Coordinate system rotation (G 6 8 X 0 Y 0 R 4 5)+Y
+X
X.7 0 7 1 Y .7 0 7 1 X(Rotated)1.0 4 5°
```
The coordinates X.7 0 7 1 and Y.7 0 7 1 can be proven using simple geometry or tr igonometry functions.
```
Coordinate system rotation is useful in many applications. Combined with a part probe the function can
provide a lot of power and accuracy. When probing a part to find its location, it is also possible to
determine if the part is cl amped square to the axes or if it is oriented at some angle. If the part is
skewed at an angle it can be automatically compensated for, resulting in higher quality parts.
Limitations: In coordinate system rotation mode, G codes related to reference posit ion return (G 2 7,
G 2 8, G 2 9, G 3 0, etc …) and those for changing the coordinate system (G 5 2 to G 5 9, G 9 2, etc … and
including manual DRO editing of the current coordinate system ) must not be specified. C orrect
movement will not be performed. If any of these G codes is necessary, specify it only after canceling
coordinate system rotation mode.

The first move command after the coordinate system rotation cancel command (G 6 9) must be specified
with absolute values. If an incremental move command is specified, corr ect movement will not be
performed.

By default, the coordinate system for the part is rotated but the axis position displays are not. Setting
parameter 1 8 0 0 to 1 will all the axis position displays to include the rotation.
G 6 9 – Coordinate System Rotation Cancel
```
G 6 9 c ancels a coordinate system rotation comma nd. The machine returns back to normal function.


<!-- Page 50 -->

5 0
G 7 3 -G 8 9 – Canned Cycles
Canned cycles are special G codes used to simplify programming. See the Canned Cycles section of this
manual for detailed information.
G code Description Format Page
G 7 3 High Speed Peck G 7 3 X_ Y_ Z_ R_ Q_ F_ 6 3
G 7 4 Reverse Tapping G 7 4 X_ Y_ Z_ R_ F_ 6 6
G 7 6 Fine Boring G 7 6 X_ Y_ Z_ R_ I_ J_ P_ F_
## G 7 6 X_ Y_ Z_ R_ Q_ P_ F_ 6 8
G 8 0 Canned Cycle Cancel G 8 0 5 8
G 8 1 Drilling G 8 1 X_ Y_ Z_ R_ F_ 5 9
G 8 2 Spot Face G 8 2 X_ Y_ Z_ R_ P_ F_ 6 0
G 8 3 Deep Hole Peck Drilling G 8 3 X_ Y_ Z_ R_ Q_ F_ 6 1
G 8 4 Tapping G 8 4 X_ Y_ Z_ R_ F_ 6 5
G 8 5 Boring, Retract at Feed, Spindle On G 8 5 X_ Y_ Z_ R_ F_ 7 0
G 8 6 Boring, Retract at Rapid, Spindle Off G 8 6 X_ Y_ Z_ R_ F_ 7 1
G 8 7 Back Boring G 8 7 X_ Y_ Z_ R_ I_ J_ F_
## G 8 7 X _ Y_ Z_ R_ Q_ F_ 7 2
G 8 8 Boring, Manual Retract G 8 8 X_ Y_ Z_ R_ P_ F_ 7 4
G 8 9 Boring, Dwell, Retract at Feed,
Spindle On G 8 9 X_ Y_ Z_ R_ P_ F_ 7 5

G 9 0/G 9 1 – Absolute/Incremental Position Mode
In absolute position mode, the machine will move to the commanded position in the active work piece
coordinate system.
Example: Write a program to move to the hole positions in figure 9 0 -1 in absolute position mode .
Assume the machine starts at position X 0, Y 0 , end the program at X 0, Y 0.


<!-- Page 51 -->

5 1
Figure 9 0 -1: Hole pattern example
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 9 0 Absolute position mode
G 0 X 1.0 Y-1.0 Rapid to 1 st hole
X 2.0 Rapid to 2 nd hole
X 3.0 Rapid to 3 rd hole
X 0.0 Y 0.0 Rapid back to 0, 0
M 3 0 Program end and rewind

In incremental position mode , commanded moves are interpreted as distance and direction from the
current position. A command of X 1 will move 1 in the positive direction, NOT necessarily to the point X 1
in the user coordinate sy stem.
Example: Write a program to move to the hole positions in figure 9 0 -1 in incremental position mode.
Assume the machine starts at position X 0, Y 0, end the program at X 0, Y 0.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 9 1 Incremental position mode
G 0 X 1. 0 Y-1.0 Rapid to 1 st hole
X 1.0 Rapid to 2 nd hole
X 1.0 Rapid to 3 rd hole
X-3.0 Y 1.0 Rapid back to 0, 0
M 3 0 Program end and rewind

Compare this to the program from G 9 0. Because the starting point is X 0, Y 0 in both examples the move
to the 1 st hole is the same. However, if the machine started at X 1, Y 1 the absolute position program
would still be correct, the incremental program would be shifted by the start location. For this reason it
is important to ensure the proper mode is enabled for the pr ogram in use. A good safe start line will
always contain a G 9 0 or G 9 1. These G codes are modal and will stay active until the other is specified.


<!-- Page 52 -->

5 2
G 9 0.1/G 9 1.1 – Absolute/Incremental Arc Center Mode
This setting affects arcs when programmed in the I, J, K format. In absolute arc center mode the I, J, K
values designate the position of the arc center in the user coordinate system. In incremental arc center
mode the I, J, K values designate the distance and direction to the arc center fro m the start point . See
figure 2-1 for a graphical description.
Figure 2 -1: Path of tool point in circular and helical interpolation (G 0 2).I (Abs)
J (Abs)I (Inc)
J (Inc)
RStart
Point
Work
Zero Y
X

Example: Program an arc centered at 1 .0, 0.0 in the XY plane with radius 2. Start point at 3 .0,0.0 and
sweep 9 0 degrees counter clockwise. Program two times, once in incremental arc center mode and
once in absolute arc center mode.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 9 1.1 Incremental arc center mode
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 3 .0 Y 0.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z rapid plane
G 1 Z 0. 0 F 1 0. 0 Z plunge at feed rate
G 3 X 1. 0 Y 2.0 I-2.0 J 0.0 F 1 0. 0 Arc move
G 0 Z.5 Retract Z to rapid plane
G 0 G 5 3 Z 0.0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 53 -->

5 3
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 9 0.1 Absolute arc center mode
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 3 .0 Y 0.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z rapid plane
G 1 Z 0. 0 F 1 0. 0 Z plunge at feed rate
G 3 X 1. 0 Y 2.0 I 1.0 J 0.0 F 1 0. 0 Arc move
G 0 Z.5 Retract Z to rapid plane
G 0 G 5 3 Z 0.0 Return Z to home
M 3 0 Program end and rewind

Notice the difference in the I values of the example programs. Both programs will produce the same
arc.
G 9 2 – Local Coordinate System Setting
```
The coordinate system can be set by issuing G 9 2 in the progr am. This function differs from G 5 2 (Local
Coordinate System Shift) in the way tha t it is specified. While G 5 2 i s specified with shift values, G 9 2 is
specified with the desired axis position. The affect is global and should be used with caution.
Format: G 9 2 X__ Y__ Z__ A__ B__ C__
Using the above format specify a value for the desired axis. When G 9 2 is specified the position DRO’s
are updated to the values specified. The local coordinate system setting will be cancelled when a G 9 2.1
is specified o r the system is reset.
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 0 X 4. 0 Y 0.0 Z 1.0 Rapid move, current position X 4, Y 0, Z 1
G 9 2 X 1. 0 Y 2.0 Z 3.0 Set local coordinate system, current position X 1,
Y 2, Z 3
G 9 2.1 Cancel local coordinate system, current positio n
X 4, Y 0, Z 1
M 3 0 Program end and rewind

G 9 2 was used for fixture offset setting before fixture offsets were available. It is recommended that the
fixture offsets be used instead of using G 9 2. The offset amount of the G 9 2 setting is not immediately
known by the user, because of this the result s can be unpredictable when fixture offsets and G 9 2 are
combined.


<!-- Page 54 -->

5 4
G 9 3 – Inverse Time Feed
Inverse time feed is most commonly used for machine movement containing at least one rotary axis,
however that is not the only application. Instead of specifying a velocity a time to complete the
movement is specified. The following formula is used to determine F:

When inverse time feed is active a n F word is required in every block of code containing a feed move.
G 9 4 – Feed Per Minute
G 9 4 is the m ost common feed rate setting. Specify the desired feed rate in units/minute. In this mode
the feed rate is modal and not required i n all feed move blocks.
G 9 5 – Feed Per Revolution
On mills , the feed per revolution setting is most commonly used for tapping cycles. In this mode the
feed rate is specified in units/revolution of the spindle. In the case of tapping the feed rate can be set as
the pitch of the tap. For every revolution of the spindle the machine will move the specified units. Feed
per rev mode requires RPM feedback from the spindle.
G 9 6 – Constant Surface Speed
Spindle speed can be specified two ways. One is constant s urface speed. In this mode Mach will try to
keep the surface speed constan t based on cutting diameter. S urface speed is specified in surface units
per minute. In the inch mode this is surface feet per minute, in millimeter mode it is surface meters per
minute.
G 9 7 – Constant RPM
In this mode the spindle speed is specified in revolutions per minute. This is the most common setting
for milling machines.


<!-- Page 55 -->

5 5
G 9 8 – Initial Point Return
G 9 8 s pecifies that a canned cycle end at the initial Z level. The machine will also return to the initial
point before a rapid move to the next position. Initial point return is useful for avoiding steps in parts or
fixture clamps without adding a significant amoun t of cycle time. See figure 9 8 -1.
Move at feedrate (F)
Move at rapid
Figure 9 8 -1: Initial and R point return setting.Initial Point
Retract Plane (R)G 9 8 G 9 9

G 9 9 – R Point Return
G 9 9 s pecifies that a canned cycle end at the programmed R level, see figure 9 8 -1. When drilling holes in
a flat plate, G 9 9 can be used to reduce excessive machine movement decreasing cycle time.


<!-- Page 56 -->

5 6
Chapter 3: Canned Cycles
G 7 3 High Speed Peck G 7 3 X_ Y_ Z_ R_ Q_ F_
G 7 4 Reverse Tapping G 7 4 X_ Y_ Z_ R_ F_
G 7 6 Fine Boring G 7 6 X_ Y_ Z_ R_ I_ J_ P_ F_
## G 7 6 X_ Y_ Z_ R_ Q_ P_ F_
G 8 0 Canned Cycle Cancel G 8 0
G 8 1 Drilling G 8 1 X_ Y_ Z_ R_ F_
G 8 2 Spot Face G 8 2 X_ Y_ Z_ R_ P_ F_
G 8 3 Deep Hole Peck Drilling G 8 3 X_ Y_ Z_ R_ Q_ F_
G 8 4 Tapping G 8 4 X_ Y_ Z_ R_ F_
G 8 5 Boring, Retract at Feed, Spindle On G 8 5 X_ Y_ Z_ R_ F_
G 8 6 Boring, Retract at Rapid, Spindle Off G 8 6 X_ Y_ Z_ R_ F_
G 8 7 Back Boring G 8 7 X_ Y_ Z_ R_ I_ J_ F_
## G 8 7 X_ Y_ Z_ R_ Q_ F_
G 8 8 Boring, Manual Retract G 8 8 X_ Y_ Z_ R_ P_ F_
G 8 9 Boring, Dwell, Retract at Feed, Spindle On G 8 9 X_ Y_ Z_ R_ P_ F_

Canned cycles are used to reduce program complexity. For example peck drilling a 1 inch hole with .1
inch peck depth would use 3 0 lines of regular code, but with a canned cycle this same hole can be
competed in just 2 lines of code. More importantly if multiple holes are required only 1 extra line of
code per hole is needed. There are a variety of canned cycles for different hole types including drilling,
boring, and tapping.
Hole machining cycles all behave similarly and mostly contain the same parameters. The meaning of
each parameter can change depending on two settings. The first is the absolute or incremental mode
setting (G 9 0/G 9 1) as defined earlier in thi s manual. The second is the return point selection G 9 8 initial
point return or G 9 9 R point return.
Plane selection (G 1 7/G 1 8/G 1 9) can also have an effect on hole machining cycles. Positioning will take
place in the active plane, and the drilling operation will be on the normal axis. For example in G 1 7 (XY
Plane) hole position will be on the XY plane and the drilling axis will be Z. In G 1 8 ( ZX Plane) positioning
will be on the ZX plane and the drilling axis will be Y. For the purposes of this manual all examples and
definitions will be in the XY plane (G 1 7).


<!-- Page 57 -->

5 7
The basic format of a canned cycle is as follows:
Gcc G 9 8/9 9 X xx Yyy Zzz Qqq Rrr Ppp Lll Fff
Xxn Yyn
## G 8 0

cc Number of the desired cann ed cycle (i.e. 8 1, 8 3, 7 4, etc)
xx In G 9 0: X positio n of the center point of the first hole with respect to the current work zero point
In G 9 1: Distance and direction along X axis to center point of first hole from the current position
yy In G 9 0: Y position of the center point of the first hole with resp ect to the current work zero point
In G 9 1: Distance and direction along Y axis to center point of first hole from the current position
zz In G 9 0: Z position of bottom of hole with respect to the current work zero point
In G 9 1: Distance and direction a long Z axis, from point R, to bottom of hole
qq Peck increment if deep hole drilling, always p ositive
rr Retract plane, retract position between pecks, in G 9 9 mode this is the rapid plane
pp Dwell , in milli seconds, at bottom of hole
ll Number of repeti tions
ff Feed rate
xn Position of nth hole X axis, same rules as applied to xx
yn Position of nth hole Y axis, same rules as applied to yy
Please note that not all arguments will appear in all cycles, and there are a couple special cases that will
be d iscussed.
Figure 2: Example hole pattern


<!-- Page 58 -->

5 8
G 8 0 – Canned Cycle Cancel
To end a canned cycle a G 8 0 must be called. G 8 0 should be specified on its own line to avoid any
unintended movements. For example:
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Y -1.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z initial point
G 8 1 G 9 9 X 1.0 Y -1.0 Z -1.0 R.2 5 F 1 0 Drill cycle start
X 2.0 Y -1.0 Drill second hole
X 3.0 Y -1.0 Drill third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 Z 0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 59 -->

5 9
Drilling
G 8 1 – Drilling
This is a straight drilling cycle. The tool simply moves to position, feeds to the bottom of the hole then
rapid retracts to either the R point o r the initial point. See figure 8 1 -1 for a graphic of the tool motion.
The format is as follows:
## G 8 1 X __ Y__ Z__ R__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
L – Number of repetitions
F – Feed rate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Hole Depth (Z)
Figure 8 1 -1: Motion of tool point for G 8 1 cycle. End Z position will be determined by G 9 8/9 9 setting.

Examp le: Create the program for the holes shown in Figure 2.

G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Y -1.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z initial point
G 8 1 G 9 9 X 1.0 Y -1.0 Z -1.0 R.2 5 F 1 0 Drill cycle start
X 2.0 Y -1.0 Drill second hole
X 3.0 Y -1.0 Drill third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 Z 0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 60 -->

6 0
G 8 2 – Spot Face
Spot face adds the ability to dwell at the bottom of the hole for a specified amount of time. The actual
tool motion is the same as a G 8 1 cycle, however with the dwell it is possible to attain better accuracy
and finish at the bottom of the hole. This is useful for ch amfering, counter boring, and spot facing. The
format is as follows:
## G 8 2 X__ Y __ Z__ R__ P__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
P – Dwell
L – Number of repetitions
F – Feed rate
Example:
Create a cha mfering program for the holes shown in figure 2, dwell for .2 seconds.

G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Y -1.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z in itial point
G 8 2 G 9 9 X 1.0 Y -1.0 Z -.2 0 0 P.2 R.2 5 F 1 0 Spot drill cycle start
X 2.0 Y -1.0 Drill second hole
X 3.0 Y -1.0 Drill third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 Z 0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 61 -->

6 1
G 8 3 – Peck Drilling
Peck drilling is a cycle used for drilling deep holes. The cycle allows for breaking and clearing of chips
and better application of coolant by fully retracting the tool from the hole between pecks. The retract
amount i s controlled by parameter 5 1 1 5. This retract move a nd plunge to previous depth are rapid
moves, each peck is a feed move at the specified feed rate. See figure 8 3 -1 for a graphic of the tool
motion.
Parameter 5 1 1 5: Integer value 0 to 3 2 7 6 7
Unit of Data:
Increment System IS-B Unit
Inch Input 0.0 0 0 1 inch
Millimeter input 0.0 0 1 mm
Default: 1 0 0 (0.0 1 0 0 inch) for inch machines. 2 5 0 (.2 5 mm) for metric machines.
The format is as follows:
## G 8 3 X__ Y__ Z__ Q__ R __ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
Q – Peck amount
R – Retract plane
L – Number of repetitions
F – Feed rate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Hole Depth (Z)Peck Depth (Q)
1 st Peck
Nth Peck
Last Peck
Figure 8 3 -1: Motion of tool point for G 8 3 cycle. End Z position will be determined by G 9 8/9 9 setting.


<!-- Page 62 -->

6 2
Example:
Create the program for the holes shown in figure 2 using a .1 peck depth.

G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Y -1.0 Position to X a nd Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z initial point
G 8 3 G 9 9 X 1.0 Y -1.0 Z -1.0 Q.1 R.2 5 F 1 0 Peck drill cycle start
X 2.0 Y -1.0 Drill second hole
X 3.0 Y -1.0 Drill third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 Z 0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 63 -->

6 3
G 7 3 – High Speed Peck
In materials that produce long stringy chips a high speed peck cycle can be used to break them up.
Unlike the G 8 3 cycle that retracts completely out of the hole after each peck, the G 7 3 cycle only retra cts
by a preset amount in parameter 5 1 1 4 . See figure 7 3 -1. This short retract helps to reduce cycle times
when a complete retract is unnecessary.
Parameter 5 1 1 4: Integer value 0 to 3 2 7 6 7
Unit of Data:
Increment System IS-B Unit
Inch Input 0.0 0 0 1 inch
Millimeter input 0.0 0 1 mm
Default: 2 5 0 (0.0 2 5 0 inch) for inch machines. 6 0 0 (.6 mm) for metric machines.
The format:
## G 7 3 X__ Y __ Z__ Q__ R__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
Q – Peck amount
R – Retract plane
L – Number of repetitions
F – Feed rate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Hole Depth (Z)Peck Depth (Q)
1 st Peck
Nth Peck
Last Peck
Figure 7 3 -1: Motion of tool point for G 7 3 cycle. End Z position will be determined by G 9 8/9 9 setting.


<!-- Page 64 -->

6 4
Example:
Create the program for the holes shown in figure 2 using a . 0 2 5 peck depth.

G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Y -1.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z initial point
G 7 3 G 9 9 X 1.0 Y -1.0 Z -1.0 Q.1 R.2 5 F 1 0 Peck drill cycle start
X 2.0 Y -1.0 Drill second hole
X 3.0 Y -1.0 Drill third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 Z 0 Return Z to home
M 3 0 Program end a nd rewind


<!-- Page 65 -->

6 5
Tapping
G 8 4 – Right Hand Tapping
The tapping cycle is used to create threaded holes using a tap. Tapping requires that the spindle rpm
and Z axis feed rate be matched, related by the pitch of the thread being cut. There are two ways to
achieve this synchronization of spindle speed and Z axis feed rate . From the programming side it is
easier to program the feed rate in units per revolution (G 9 5). In the feed per rev mode the commanded
```
feed rate will be simply the pitch of the thread. Metri c threads are classified with the thread pitch, i.e.
```
M 8 x 1.2 5 mm thread has a 1.2 5 mm pitch. Unified threads are classified by threads per inch which
requires a bit of calculation to get the pitch, don’t worry it’s easy. Simply divide 1 inch by the TPI. Fo r a
¼-2 0 fastener we would calculate 1/2 0 = .0 5, this is the pitch. The catch is, to use feed per rev requires
some form of rpm feedback from the machine, not every machine will have this. For the machines
without feedback the tapping cycle can be progra mmed in feed per min mode (G 9 4). This method
requires a little more math to obtain the correct feed rate based on spindle rpm and pitch of the thread.
The equation looks li ke this: RPM*Pitch=I PM. T o tap that ¼ -2 0 hole at 1 5 0 0 RPM we first need to
calcul ate the pitch, remember 1/TPI = Pitch, so 1/2 0=.0 5. Now we calc ulate the feed per min as 1 5 0 0 *
.0 5=7 5 IPM. It is important to note that if the spindle speed is changed, the feed per minute must also
be changed to match. Now that the math is done, check out the format of the code:
## G 8 4 X__ Y__ Z__ R__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
L – Number of repetitions
F – Feed rate

The motion of the tapping cycle is straight forward, but does require some addition al description. See
Figure 8 4 -1 for a graphic of the tool motion. The movement is very similar to a straight drill cycle, action
of the spindle being the major difference. The spindle must be started in the forward direction prior to
calling the G 8 4 cycle. The machine will then move to the hole position then the Z axis will move down to
the R plane. The Z will feed down to the specified depth then the spindle and Z axis will stop then
reverse direction to retract out of the hole. Due to slight variations of spindle speed, feed rate and
accelerations in some machines it is recommended that a special tapping head be used. A tapping head
allows the tap to float a little bit, compensating for those variations, especially at the bottom of the
hole.
Changes to feed rate or spindle speed mid cycle can be damaging to the tool and work piece, for this
reason the feed rate and spindle speed overrides are disabled. The machine will run at 1 0 0% override
for the duration of the cycle. Feed hold is also di sabled during the cycle. If feed hold is pressed motion
will stop at the end of the tapping cycle.


<!-- Page 66 -->

6 6

Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Tap Depth (Z)
Figure 8 4 -1: Motion of tool point for G 8 4 cycle. End Z position will be determined by G 9 8/9 9 setting.Spindle FWD
Spindle REVSpindle FWD
Example:
Create the program to tap the holes shown in figure 2 to a depth of .5 0 0 with a 3/8 -1 6 tap using
feed/min.
1/1 6=.0 6 2 5
1 0 0 0*.0 6 2 5=6 2.5

G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 1 0 0 0 M 3 Start spindle
G 0 X 1.0 Y -1.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z initial point
G 8 4 G 9 9 X 1.0 Y -1.0 Z -.5 0 0 R.2 5 F 6 2.5 Tapping cycle start
X 2.0 Y -1.0 Tap second hole
X 3.0 Y -1.0 Tap third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 Z 0 Return Z to home
M 3 0 Program end and rewind

G 7 4 – Left Hand Tapping
Left hand tapping is the same as right hand tapping (G 8 4) except that it will cut left hand threads. T he
spindle must be started in the reverse direction before calling the G 7 4 cycle.


<!-- Page 67 -->

6 7
G 8 4.2/G 8 4.3 – Right and Left Hand Rigid Tapping
Rigid tapping can be performed on capable machines. As the name implies the tap is held rigidly in the
spindle, no tension/ compression style tapping holder is required. Holding the tap in this manner
requires the machine to have precise control of spindle speed, axis feed , and precise feedback of spindle
RPM. The tapping axis will be electronically geared to the spindle RPM. Use G 8 4.2 for right hand
tapping and G 8 4.3 for left hand tapping. See figure 8 4 -1 for a graphic of the motion.
Format: G 8 4.2/8 4.3 X__ Y__ Z__ R__ P__ L__ F__ J__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
P – Dwell in milli seconds
L – Number of repetitions
F – Feed rate
J – Spindle speed for retract
As will other tapping cycles the feed rate and spindle speed overrides are disabled and set to 1 0 0% for
the duration of the cycle. Feed hold is also no effective until the end of the tapping cycle.
Example:
Create the program to tap the holes shown in figure 2 to a depth of .5 0 0 with a 3/8 -1 6 tap using
feed/min. Tap at 1 0 0 0 RPM, retract at 2 0 0 0 RPM
1/1 6=.0 6 2 5
1 0 0 0*.0 6 2 5=6 2.5

G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 1 0 0 0 M 3 Start spindle
G 0 X 1.0 Y -1.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z initial point
G 8 4.2 G 9 9 X 1.0 Y -1.0 Z -.5 0 0 R.2 5 F 6 2.5 J 2 0 0 0 Rigid tapping cycle start
X 2.0 Y -1.0 Tap second hole
X 3.0 Y-1.0 Tap third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 Z 0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 68 -->

6 8
Boring
G 7 6 – Fine Boring
The fine boring cycle allows the user to stop the spindle and move the tool away from the wall before
retracting. This al lows for a rapid retract without leaving a scratch on the wall.
## G 7 6 X__ Y__ Z__ R__ I__ J__ P__ L__ F__
or
## G 7 6 X__ Y__ Z__ R__ Q__ P__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
I – X shift dist ance and direction
J – Y shift distance and direction
Q – Shift distance (Always positive. Direction and axis are defined by bits 5 and 4 in parameter 5 1 0 1)
P – Dwell in milli seconds
L – Number of repetitions
F – Feed rate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Hole Depth (Z)
Figure 7 6 -1: Motion of tool point for G 7 6 cycle. End Z position will be determined by G 9 8/9 9 setting.Dwell, Stop spindle, Shift
amount I and J

After feeding to the bottom of the hole, the machine with pause for the specified dwell time, then the
spindle will stop in the orient position before making the shift move defined by I and J. In machines with
```
a spindle orient function called by M 1 9 this will all be automatic. Howeve r, many machines are not
capable of orienting the spindle so the orientation must be done manually. Because of the vast variety
of machines that handle spindle orientation differently, the spindleorient.mcs script controls how the


<!-- Page 69 -->

6 9
spindle is oriented, aut omatically or manually. If the machine is not capable of automatic spindle
orientation, the spindle orient script should command a spindle stop and a mandatory program stop.
This will allow the operator to manually orient the spindle before the shift mov e is made. Here i s an
example of the spindleorient.mcs macro for the manual orient:
```
function spindleorient(orientation, direction)
```
local inst = mc.mc Get Instance() -- Get the current instance
local rc = mc.mc Cntl Wait On Cycle Start(inst, "Press Cycl e Start when the spindle is oriented.", 0)
if rc ~= mc.MERROR_NOERROR then
mc.mc Cntl Set Last Error(inst, "Spindle Orient Error")
return
end
end

```
if (mc.mc In Editor() == 1) then
spindleorient(0.0, 1)
end

Example:
Create t he program to fine bore the holes shown in figure 2.

G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Y -1.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z initial point
G 7 6 G 9 9 X 1.0 Y -1.0 Z -1.0 R.2 5 I-.0 2 5 J 0 F 1 0.0 Fine bore cycle, shift X -.0 2 5 at bottom
X 2.0 Y -1.0 Bore second hole
X 3.0 Y -1.0 Bore third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 Z 0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 70 -->

7 0
G 8 5 – Boring, Feed rate Retract
G 8 5 is a straight boring cycle, most commonly used for boring or reaming. The retract is at the
programmed feed rate with the spindle on.
## G 8 5 X__ Y__ Z__ R__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
L – Number of repetitions
F – Feed rate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Hole Depth (Z)
Figure 8 5 -1: Motion of tool point for G 8 5 cycle. End Z position will be determined by G 9 8/9 9 setting.

Example:
Create the program to bore the holes shown in figure 2.

G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Y -1.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z initial point
G 8 5 G 9 9 X 1.0 Y -1.0 Z -1.0 R.2 5 F 1 0.0 Boring cycle start
X 2.0 Y -1.0 Bore second hole
X 3.0 Y -1.0 Bore third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 Z 0 Return Z to home
M 3 0 Program en d and rewind


<!-- Page 71 -->

7 1
G 8 6 – Boring, Rapid Retract
G 8 6 is a straight boring cycle. Before retracting from the hole the spindle is stopped. The retract is then
performed at the rapid rate. This will leave a scratch or multiple scratches where the cutting edges a re
in contact with the wall.
## G 8 6 X__ Y__ Z__ R__ P__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
P – Dwell in milliseconds
L – Number of repetitions
F – Feed rate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Hole Depth (Z)
Figure 8 6 -1: Motion of tool point for G 8 6 cycle. End Z position will be determined by G 9 8/9 9 setting.Dwell, Spindle Stop

Example: Create the program to bore the holes shown in figure 2.

G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Y -1.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z initial point
G 8 6 G 9 9 X 1.0 Y -1.0 Z -1.0 R.2 5 F 1 0.0 Boring cycle start
X 2.0 Y -1.0 Bore second hole
X 3.0 Y -1.0 Bore third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 Z 0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 72 -->

7 2
G 8 7 – Back Boring
G 8 7 is a back boring cycle. This is a useful c ycle for spot facing, counter boring or chamfering the back
side of a part. At the start of the cycle the spindle will be stopped at the orient position and the tool
offset from the hole center by the distance and direction defined by I and J. For machin es that do not
have the ability to orient the spindle, see the M 1 9 macro example in the G 7 6 cycle description. The tool
can then be positioned to the R point below the work piece. Once at the R point the tool will be
positioned at the hole center and the spindle started to perform the back boring operation. When the
specified Z point is reached the machine will orient the spindle, offset by amount I, J and retract back to
the initial point. In this cycle the R point will always be below the work piece, not a good point the end
the cycle. For that reason this canned cycled will always return to the initial point, it is not possible to
specify a G 9 9 R point return.
## G 8 7 X__ Y__ Z__ R__ I__ J__ P__ L__ F__
## G 8 7 X__ Y__ Z__ R__ Q__ P__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
I – X shift distance and direction
J – Y shift distance and direction
Q – Shift distance (Always positive. Direction and axis are defined by bits 5 and 4 in parameter 5 1 0 1)
P – Dwell in milli seconds
L – Number of repetitions
F – Feed rate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)Final Hole Depth (Z)
Figure 8 7 -1: Motion of tool point for G 8 7 cycle. End Z position will be determined by G 9 8/9 9 setting.Spindle orient
and shift by I, J
Shift back
start spindle Spindle orient
and shift by I, J


<!-- Page 73 -->

7 3
Example:
Create the program to back bore thru holes at the same positions shown in figure 2. Thru depth 1 inch,
back bore depth .1 5 0 inch.

G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Y -1.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z initial point
G 8 7 G 9 8 X 1.0 Y -1.0 Z -0.8 5 R-1.0 5 I -.1 0 F 1 0.0 Back b oring cycle start (Shift -.1 in X axis)
X 2.0 Y -1.0 Bore second hole
X 3.0 Y -1.0 Bore third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 Z 0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 74 -->

7 4
G 8 8 – Boring, Manual Retract
This boring cycle features a manual retract. At the bottom of the hole the specified dwell is p erformed,
then the spindle is stopped and the program paused. The operator can then manually retract the tool
from the hole. After retracting the tool cycle start is pressed to continue program operation.
## G 8 8 X__ Y__ Z__ R__ P__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
P – Dwell in milli seconds
L – Number of repetitions
F – Feed rate
Initial Point
Retract Plane (R)
Final Hole Depth (Z)
Figure 8 8 -1: Motion of tool point for G 8 5 cycle. Move at feedrate (F)
Move at rapid
Manual jog

Example:
Create the program to bore the holes shown in figure 2.

G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Y -1.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z initial point
G 8 8 G 9 9 X 1.0 Y -1.0 Z -1.0 R.2 5 F 1 0.0 Boring cycle start, pause for manual retract
X 2.0 Y -1.0 Bore second hole , pause for manual retract
X 3.0 Y -1.0 Bore third hole , pause for manual retract
G 8 0 Canned cycle cancel
G 0 G 5 3 Z 0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 75 -->

7 5
G 8 9 – Boring, Dwell & Feed rate Retract
```
Same function as G 8 5 with the addition of a dwell at the bottom of the hole.
## G 8 9 X__ Y__ Z__ R__ P__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
P – Dwell in milli seconds
L – Number of repetitions
F – Feed rate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Hole Depth (Z)
Figure 8 9 -1: Motion of tool point for G 8 9 cycle. End Z position will be determined by G 9 8/9 9 setting.Dwell (P)

Example:
Create the program to bore the holes show n in figure 2.

G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 M 6 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Y -1.0 Position to X and Y start point
G 4 3 H 1 Z.5 Activate tool offset 1 and move to Z initial point
G 8 9 G 9 9 X 1.0 Y -1.0 Z -1.0 R.2 5 P.2 5 0 F 1 0.0 Boring cycle start
X 2.0 Y -1.0 Bore second hole
X 3.0 Y -1.0 Bore third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 Z 0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 76 -->

7 6
Chapter 4: Cutter Compensation
Cutter compensation provides the user with the ability to adjust the tool path for variations in tool
cutter diameter. It can be used in two ways. First, when programming by hand, without the aid of CAM
(Computer Aided Manufacturing) software, it is much easier to program the actual part dimensions, part
line programm ing. This saves the programmer for having to calculate to correct path at the center of
the tool when the edge is doing the cutting. When given a proper diameter offset, cutter compensation
will make the appropriate tool path adjustments to cut the part correctly. Essentially the machine does
the math for the programmer. Second, with the more widespread use of CAM systems the tool path is
already adjusted for the tool diameter and the part should, in theory, be cut perfectly to size. In practice
howeve r, there are many factors that determine the finished size of a machined part, cutter and
machine deflection, machine positioning accuracy, cutter diameter variations, etc. Cutter compensation
allows for fine tuning the tool path, and adjustment of part d imensions, without having to change the
program itself.
There are two G codes used to enable cutter compensation. G 4 1 offsets the tool to the left of the tool
path and G 4 2 offsets the tool to the right of the tool path. This is only true for positive dia meter offset
values. If negative offset is specified the offset direction will be reversed, see figure 4 1 -1. There are two
ways to call the offset value with G 4 1 and G 4 2.
Format 1: G 0 0/G 0 1 G 4 1/G 4 2 D__ X__ Y__ F__
Format 2: G 0 0/G 0 1 G 4 1/G 4 2 P__ X__ Y_ _ F__
Use D to call a diameter offset from a specific tool offset number. For example, D 2 will use the diameter
offset value of tool offset number 2. An alternative is to use P. The value specified with P will be the
actual offset value. For example, P.0 5 will offset the tool path .0 5 to the left or right.
Cutter compensation only works on the two in plane axes, so for G 1 7 (XY plane) the X and Y axes are
affected by the comp, G 1 8 ZX and G 1 9 YZ.


<!-- Page 77 -->

7 7

Figure 4 1 -1: Cutter compensation offset direction.Programmed tool path
Cutter comp tool path G 4 1 + Offset
G 4 2 -Offset G 4 2 + Offset
G 4 1 -Offset Work Piece Climb Milling Conventional Milling
## G 4 0 G 4 0
There are two types of milling, which style is used dete rmines how the tool should be compensated.
The two types are climb milling and conventional milling, see figure 4 1 -1. Conventional milling is the
standard in manual machines, but with CNC it is possible and recommended to climb mill when possible.
This manual will assume the tool will always be climb milling. With that assumption if G 4 1 is used for
outside features, the profile of a part, then a positive offset will make the part bigger and a negative
offset will make the part smaller. For inside featu res, a hole, G 4 2 will make the hole bigger with a
positive offset and smaller with a negative offset, see figure 4 1 -2. This method tends to make the offset
values more intuitive for the operator. If conventional milling is used, this description will be reversed.


<!-- Page 78 -->

7 8

Figure 4 1 -2: Cutter compensation OD and ID features.Programmed tool path
Cutter comp tool path
Part Edges Climb milling
outside of part:
G 4 1 with a
positive offset
makes part
dimensions
bigger.
Climb milling
inside of part:
G 4 2 with a
positive offset
makes hole
dimensions
bigger.
Cutter comp should be enabled on a linear lead -in move; an error will be produced if cutter comp is
enabled in a block with an arc. If there is a value other than zero in the offset then this lead -in move
may not be parallel to the programmed path, see figure 4 1 -1, 4 1 -6 and 4 1 -7. The end point of the start
block is the point at a 9 0° angle to the movement in the next block and at the offset distance. See figure
4 1-3 for examples. This linear move must be longer than the offset amount, if it is not there will be an
error. Also, if there are any segments of the tool path shorter than the offset amount a gouge is likely,
see figure 4 1 -4. The tool path display in Mach will display the actual tool path with comp, check to make
sure there are no gouges or abnormalities before running a part.


<!-- Page 79 -->

7 9

Figure 4 1 -3: Cutter compensation start blocks.Programmed tool path
Cutter comp tool path
Tool Path 1: No cutter comp
## G 0 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0
G 0 X 0 Y 0 Z 1.
## S 1 0 0 0 M 3
G 1 G 4 1 P 0 Y .5 F 2 5.
X 1.5
Y .6
X 2.0
G 4 0 Y 1.2 5
M 3 0Tool Path 2: Comp radius .0 5
## G 0 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0
G 0 X 0 Y 0 Z 1.
## S 1 0 0 0 M 3
G 1 G 4 1 P 0 .0 5 Y .5 F 2 5.
X 1.5
Y .6
X 2.0
G 4 0 Y 1.2 5
M 3 0Tool Path 3: Comp radius .1 5
## G 0 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0
G 0 X 0 Y 0 Z 1.
## S 1 0 0 0 M 3
G 1 G 4 1 P 0 .1 5 Y .5 F 2 5.
X 1.5
Y .6
X 2.0
G 4 0 Y 1.2 5
## M 3 0
Figure 4 1 -4: Cutter compensation radius and gouge.
1 2
3 Gouge

Figure 4 1 -4 shows three tool paths generated by the same program with different cutter compensation
offset values. The gouge is created when an offset value greater than the step of .1 0 is input. When th is
happens the compensated tool path over laps and is reversed, causing a gouge. Another example of this
is in small grooves as shown in figure 4 1 -5.


<!-- Page 80 -->

8 0

Figure 4 1 -5: Cutter compensation in narrow groove.Programmed tool path
Cutter comp tool path Overcuts part at
these corners.
Cutter compensation is cancelled by specifying G 4 0 in the program, or when the control is reset. When
G 4 0 is specified it should be on a lead -out move following the same rules as when compensation is
enabled. The path will be determined as shown in figure 4 1 -3. Errors will occur if the lead -out distance
is smaller than the offset amount or if G 4 0 is spec ified on a block containing an arc move.


<!-- Page 81 -->

8 1

Figure 4 1 -6: G 4 1 cutter compensation path.Programmed tool path
Cutter comp tool path 1 2 3 4 5
## G 0 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0
G 0 X 1.5 Y -.7 5 Z 1.
## S 1 0 0 0 M 3
G 1 Z -.2 5 F 3 0.
G 4 1 P .1 0 Y 0
X.5
## Y 1
## G 4 0 X 0
## G 0 G 5 3 Z 0
## M 3 0 1
2
3
4
5
Figure 4 1 -7: G 4 2 cutter compensation path.Programmed tool path
Cutter comp tool path G 0 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0
G 0 X 1.5 Y -.7 5 Z 1.
## S 1 0 0 0 M 3
G 1 Z -.2 5 F 3 0.
G 4 2 P .1 0 Y 0
X.5
## Y 1
## G 4 0 X 0
## G 0 G 5 3 Z 0
## M 3 0 1
2
3
4
5
1 2 3 4 5


<!-- Page 82 -->

8 2
Chapter 5: M Code List
Code Description Page
M 0 0 Mandatory Program Stop 8 2
M 0 1 Optional Program Stop 8 2
M 0 2 Program End 8 2
M 0 3 Spindle Forward/C lockwise 8 3
M 0 4 Spindle Reverse/Counterclockwise 8 3
M 0 5 Spindle Stop 8 3
M 0 6 Tool Change 8 3
M 0 7 Mist Coolant On 8 3
M 0 8 Flood Coolant On 8 3
M 0 9 All Coolant Off 8 4
M 1 9 Spindle Orient 8 4
M 3 0 Program End and Rewind 8 4
M 4 8 Enable Feed/Speed Overrides 8 4
M 4 9 Disable Feed/Speed Overrides 8 4
M 6 2 Synchronized Output On 8 4
M 6 3 Synchronized Output Off 8 4
M 6 4 Immediate Output On 8 4
M 6 5 Immediate Output Off 8 5
M 6 6 Wait For Input 8 5
M 9 8 Subpr ogram Call 8 6
M 9 9 Return From Subprogram / Rewind 8 8
M??? Custom Macro M Codes 8 8

M Code Descriptions
M 0 0 – Mandatory Program Stop
To pause a program at any point , specify M 0 0. All motio n will be halted and the spindle stopped. To
resume operation press the cycle start button.
M 0 1 – Optional Program Stop
The p rogram pauses same as M 0 0, but only when the optional stop switch is turned on. This allows the
operator to stop and check progra m points when needed, but also to run without stops.
M 0 2 – Program End
M 0 2 ends the program. All program operation will be ended and defaults (G 5 4, G 1 7, G 9 0, etc .) reset.
The program will not rewind and if the cycle start button is pressed program operat ion will begin with
the next block following the M 0 2.


<!-- Page 83 -->

8 3
M 0 3 – Spindle Forward/Clockwise
M 0 3 starts the spindle in the forward direction at the designated speed. M 0 3 is usually combined with
an S word to define the speed. If an S word is not specified the last spindle speed is used.
M 0 4 – Spindle Reverse/Counterclockwise
M 0 4 starts the spindle in the reverse direction at the designated speed. M 0 4 is usually combined with
an S word to define the speed. If an S word is not specified the last spindle speed i s used.
M 0 5 – Spindle Stop
Stops spindle rotation.
M 0 6 – Tool Change
M 0 6 starts a tool change operation to change to the tool number specified by T. The T word can specify
if the too l is the “tool to use ” or the “next tool ”. This is configured in the con trol parameters. Typically,
for a car ousel type tool changer, the tool specified by T on the M 0 6 would be the tool to use. On the
other hand, if the tool changer has a preload “tool arm”, then the tool specified by T on the M 6 line is
the next tool.
If T on M 0 6 line is the “tool to use”, T must appear in the same block as the M 0 6 or above it in the
program. For example:
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 0 X 4. 0 Y 0.0 Z 1.0 T 1 Rapid move, pre call tool 1
M 6 Tool change to tool 1
G 0 X 1 0. 0 Y-5.0 Z 1.0 Rapid move
T 2 M 6 Tool change to tool 2
M 3 0 Program end and rewind

If T on M 0 6 line is the “next tool”, the “tool to use” T must appear above the M 6 block and the T in the
same block as the M 0 6 is the “next tool”. For example:
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
T 1 Preload T 1
G 0 X 4.0 Y 0.0 Z 1.0 Rapid move
M 6 T 2 Tool change to tool 1, preload T 2
G 0 X 1 0.0 Y -5.0 Z 1.0 Rapid move
M 6 Tool change to tool 2
M 3 0 Program end and rewind

M 0 7 – Mist Coolant On
Turns on the mist coolant output.
M 0 8 – Flood Coolant On
Turns on the flood coolant output.


<!-- Page 84 -->

8 4
M 0 9 – All Coolant Off
Turns off all coolant outputs.
M 1 9 – Spindle Orient
Although this code is not built into Mach and is completely user defined, it is required to orient the
spindle for some machin ing cycles, G 7 6 and G 8 7 for example. Tool changers usually will require a
spindle orientation, and although this orientation could be any M code defined by the user or even built
into the M 6, M 1 9 is recommended as it is an industry standard M code. Usual ly, it would call the
spindleorient.mcs macro
M 3 0 – Program End and Rewind
Ends the current program and rewinds back to the beginning. Pressing the cycle start button will start
program execution from the first block. All defaults (G 5 4, G 1 7, G 9 0, etc.) w ill be reset.
M 4 8 – Enable Feed rate/Spindle Speed Overrides
Enables the feed rate and spindle speed overrides after an M 4 9 has been issued.
M 4 9 – Disable Feed rate/Spindle Speed Overrides
Disables the feed rate and spindle speed overrides. This can be be neficial in production environments
and also in programs or macros that are sensitive to feed rate and spindle speed by preventing
accidental overrides.
M 6 2 – Synchronized Output On
Turns on an output synchronized with the start of the next motion command. If no motion is
commanded, the output will not turn on. It is best to specify motion immediately following the M 6 2
command.
Format: M 6 2 P__
P specifies the output number to turn on. For example: Output 0 = 0, Output 3 = 3, Output 1 0 = 1 0, etc.
M 6 3 – Synchr onized Output Off
Turns off an output synchronized with the start of the next motion command. If no motion is
commanded, the output will not turn off. It is best to specify motion immediately following the M 6 3
command.
Format: M 6 3 P__
P specifies the out put number to turn off. For example: Output 0 = 0, Output 3 = 3, Output 1 0 = 1 0, etc.
M 6 4 – Immediate Output On
The specified output is turned on immediately.
Format: M 6 4 P__
P specifies the output number to turn on. For example: Output 0 = 0, Output 3 = 3, Out put 1 0 = 1 0, etc.


<!-- Page 85 -->

8 5
M 6 5 – Immediate Output Off
The specified output is turned off immediately.
Format: M 6 5 P__
P specifies the output number to turn on. For example: Output 0 = 0, Output 3 = 3, Output 1 0 = 1 0, etc.
M 6 6 – Wait for Input
When specified, program ex ecution will be paused until the selected input is activated. There are 5 wait
modes:
 Mode 0: No wait. Current state of the input is written to #5 3 9 9 : low = 0, high = 1.
 Mode 1: Wait for the input to change state from low to high. If the input is high w hen called,
the program will wait until the input goes low, then back to high.
 Mode 2: Wait for the input to change state from high to low. If the input is low when called, the
program will wait until the input goes high, then back to low.
 Mode 3: Wait un til the input is in the high state. If the input is high when called, the program
will immediately continue.
 Mode 4: Wait until the input is in the low state. If the input low when called, the program will
immediately continue.
Format: M 6 6 P__ L__ Q__
P specifies the desired input number. For example: Input 0 = 0, Input 4 = 4, Input 1 2 = 1 2, etc.
L specifies the mode, 0 thru 4.
Q specifies how long to wait, in seconds, for the input . If the mode is not satisfied in the specified time
then #5 3 9 9 will be set to -1.0 and program execution will continue.


<!-- Page 86 -->

8 6
M 9 8 – Subprogram Call
Subprograms are external programs referenced by the current running program. When called program
execution will continue in the subprogram. This allows the user to reduce program lengt h and
complexity by providing the ability to easily repeat sections of code, run the same section of code in
multiple locations or in multiple fixture offsets, the possibilities are limited only by the program mer. To
call a subprogram command M 9 8 with th e program number as shown.
Format: M 9 8 P____ Q__ L__
P specifies the number of the progr am to be called. This is a four digit integer number. When the M 9 8
is read Mach scans the current file for a block containing the program number in the following fo rm:
Format: O 1 2 3 4
Note that the letter “O” is used to specify the program number 1 2 3 4, NOT the number “0”. Program
execution will continue with the block following the O number. For this method the subprogram should
be below the end of the current progra m:
(MAIN PROGRAM) Main program header
G 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0 Safe start line
G 0 X 4.0 Y 0.0 Z 1.0 Rapid move
T 1 M 6 Tool change to tool 1
G 0 X 1 0.0 Y -5.0 Z 1.0 Rapid move
M 9 8 P 1 0 0 0 Call subprogram number 1 0 0 0
M 3 0 Program end and rewind

O 1 0 0 0 (SUB P ROGRAM BEGIN) Subprogram number
G 1 2 I -0.2 5 Cut circle
M 9 9 Return to main program

There are limitations to this method; mainly the subprogram must be pasted into every program that it
is to be called from. Mach also allows a subprogram to be called fro m an external file. This way,
multiple programs can call the same subprogram, without having the program in the main file. If a
change needs to be made to the subprogram it on ly needs to be done in one file, not every file in which
the sub is called. If the control does not find the program number in the current file it will then search
for it in the Mach 4 \Subroutines directory. This time it will be searching filenames. The files in this
directory should be named with the program number as follows:
Format: O____
Note the letter “O” followed by four numbers, and no file extension; O 1 2 3 4 not O 1 2 3 4.txt. When the
program is loaded this file will be found and loaded into the memory, the tool path display will reflect
what is in the subprogram. When running the file the M 9 8 block will be read and program execution
will continue with the first block of the subprogram file.


<!-- Page 87 -->

8 7
The arguments Q and L are optional. Q specifies the sequence number in the subprogram to start at. If
Q is omitted then execution will s tart at the beginning of the sub program ; see figure 1 9 8 -1. L is the
number of repetitions. For example, if L=2 the subprogram is run two times before execution of the
main program continues. If L is omitted the program will run only once.
Figure 1 9 8 -1: Subprogram call O 1 0 0 0 (MAIN PROGRAM)
## G 0 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0
G 0 X 2.0 Y 0.0 Z 1.0
## S 1 0 0 0 M 3
## N 1 0
## M 9 8 P 1 0 1 0 Q 1 0
G 0 X -2.0 Y 1.0 Z 1.0
## N 1 5
## M 9 8 P 1 0 1 0
G 0 G 5 3 Z 0.0
M 3 0O 1 0 1 0 (SUB PROGRAM 1)
G 1 Z -0.5 F 3 0.0
G 1 2 I 0.2 5
G 0 Z 1.0
## N 1 0
G 1 Z -0.1 5 F 2 5.0
G 1 3 I 0.3 0
G 0 Z 1.0
## M 9 9


<!-- Page 88 -->

8 8
M 9 9 – Return From Subprogram / Rerun
To return to the main program from a subprogram an M 9 9 is used.
Format: M 9 9 P__
M 9 9 specified in a subprogram will return to the main program at the block immediately following the
M 9 8 subprogram call. The addition of a P in t he M 9 9 block will return to a desired sequence number in
the main program. See figure 1 9 9 -1.
Figure 1 9 9 -1: Return from sub program O 1 0 0 0 (MAIN PROGRAM)
## G 0 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0
G 0 X 2.0 Y 0.0 Z 1.0
## S 1 0 0 0 M 3
## N 1 0
## M 9 8 P 1 0 1 0
G 0 X -2.0 Y 1.0 Z 1.0
## N 1 5
## M 9 8 P 1 0 1 1
G 0 X -1.5
## N 2 0
## M 9 8 P 1 0 1 2
## N 2 5
G 0 G 5 3 Z 0.0
M 3 0O 1 0 1 0 (SUB PROGRAM 1)
## G 0 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0
G 1 Z -0.5 F 3 0.0
G 1 2 I 0.2 5
G 0 Z 1.0
## M 9 9 P 2 0
O 1 0 1 2 (SUB PROGRAM 2)
## G 0 0 G 9 0 G 5 4 G 1 7 G 4 0 G 4 9 G 8 0
G 1 Z -0.5 F 3 0.0
G 1 3 I -0.3 5
G 0 Z 1.0
## M 9 9

If M 9 9 is specified in a main program (not in a subprogram) a program rewind is performed . Execution
will continue from the first block of the program.
Custom M Codes
```
Every machine is a little different and has different functions and options. Custom M codes allow the
user to create simple programming calls for complex processes, activating or deactivating outputs,
reading inputs, performing math, or whatever e lse the user and machine could require. These M codes
are programmed in Lua and placed in the macros folder under each profile. Every profile can have its
own unique set of M codes. The file name must be the macro to be called. For example to make a t ool
change macro, M 6, add a Lua script with the filename M 6.mcs to the macros folder in the desired
profile. When an M 6 is called in a program or in MDI the macro will be executed.


<!-- Page 89 -->

8 9
Chapter 6: Custom Macro
Parts of this chapter are taken from Fanuc docum entation. Parametric G code programs are possible
with custom macro programming. The term custom macro defines anything that is not literal NC code.
Example:
G 9 0 G 0 X 1 0 Regular NC code. Rapid to X 1 0
G 0 X#1 5 0 Custom macro. Rapid move X to the locatio n
specified by #1 5 0.

Variables
An ordinary machining program specifies a G code and the travel distance directly with a numeric value;
examples are G 1 0 0 and X 1 0 0.0.

With a custom macro, numeric values can be specified directly or using a variable number . When a
variable number is used, the variable value can be changed by a program or using operations on the MDI
panel.

Example:

#1 0 0=#2+2 0 0 Set #1 0 0 equal to the contents of #2 plus 2 0 0.
G 0 X#1 0 0 Rapid move X to the location specified by #1 0 0.

 Variabl e representation
When specifying a variable, specify a number sign (#) followed by a variable number.
Example: #1

An expression can be used to specify a variable number. In such a case, the expression must be
enclosed in brackets.
Example: #[#1+#2 –1 2]


<!-- Page 90 -->

9 0
 Types of variables

```
Variables are classified into four types by variable number.

Variable number Type of variable Function
#0 Always null ( NIL)
This variable is always NIL. No value
can be assigned to this variable.
#1 – #3 3 Local
variables Local variab les can only be used
within a macro to hold data such as
the results of operations. When the
power is turned off, local variables are
initialized to null. When a macro is
called, arguments are assigned to
local variables.
#1 0 0 – #1 4 9 (#1 9 9)
#5 0 0 – #5 3 1 (# 9 9 9) Common
variables Common variables can be shared
among different macro programs.
When the power is turned off,
variables #1 0 0 to #1 4 9 are initialized
to null. Variables #5 0 0 to #5 3 1 hold
data even when the power is removed .
#1 0 0 0 – System variables
System variables are used to read and
write a variety of NC data items such
as the current position and tool
compensation values.

 Referencing variables
To reference the value of a variable in a program, specify a word address followed by the variable
number. When an expression is used to specify a variable, enclose the expression in brackets.
Example: G 0 1X[#1+#2]F#3

To reverse the sign of a referenced variable value, prefix a minus sign ( –) to #.
Example: G 0 0X –#1

 Common variables (multi -instance/path)

For multi –path/instance control s, macro variables are provided for each path. Some common
variables, however, can be used for both paths, by setting parameters No. 6 0 3 6 and 6 0 3 7
accordingly.

 Undefined variables
When the value of a variable is not defined , such a variable is referred to as a “NIL” variable.
Variable #0 is always a null variable. It cannot be written to, but it can be read.

When an undefined variable is quoted, the address itself is also ignored.
Example: When #1 is 0 and #2 is null, the r esult of executing G 0 0X#1 Y#2 will be the same as
when G 0 0 X 0 is executed.


<!-- Page 91 -->

9 1
System Variables
System variables can be used to read and write internal NC data such as tool compensation values and
current position data. Note, however, that some system variab les can only be read. System variables are
essential for automation and general –purpose program development.

 Interface signals

Signals can be exchanged between the hardware inputs and outputs and custom macros.

Variable Number Function
#1 0 0 0–#1 0 3 1
#1 0 3 2 3 2 input signals can be mapped to hardware input s that can be read as
macro variables . Variables #1 0 0 0 to #1 0 3 1 are used to read the status
of an input. 1 is high, 0 is low. These system variables are read only.

Variable #1 0 3 2 is used to read all 3 2 inputs at one time.
#1 1 0 0–#1 1 3 1
#1 1 3 2 3 2 output signals can be mapped to hardware outputs that can be set
as macro variables. Variables #1 1 0 0 to #1 1 3 1 are used to set the
status of an ou tput. 1 is high, 0 is low. These system variables can be
read and w ritten.

Variable #1 1 3 2 is used to set all 3 2 outputs at one time.

 Tool compensation values

Tool compensation values can be read and written using system variables . The control uses the
tool compensation Type C memory layout.

Compensation
number Tool length compensation (H) Cutter compensation (D)
Geometric
compensation Wear
compensation Geometric
compensation Wear
compensation
1
:
5 0 1
:
9 9 9 #1 1 0 0 1
:
#1 1 5 0 1
:
#1 1 9 9 9 #1 0 0 0 1
:
#1 0 5 0 1
:
#1 0 9 9 9 #1 3 0 0 1
:
#1 3 5 0 1
:
#1 3 9 9 9 #1 2 0 0 1
:
#1 2 5 0 1
:
#1 2 9 9 9

 Macro alarm

Variable
number Function
#3 0 0 0 When a value is assigned to variable #3 0 0 0, the control stops with an
alarm. After the expression, an alarm message can be described in a
comment.
Example: #3 0 0 0=1 9 (M 1 9 Failure!)

Alarm conditions must be cleared by a control reset.


<!-- Page 92 -->

9 2
 Macro s top

Variable
number Function
#3 0 0 6 When a value is assigned to variable #3 0 0 6, the control stops (without an
alarm). After the expression, an alarm message can be described in a
comment.
Example: #3 0 0 6=2 1 (Oil Level Low!)

 Time information

Variable
number Function
```
#3 0 0 1 This variable functions as a timer that counts in 1 –millisecond increments
at all times. When the power is turned on, the value of this variable is
reset to 0. When 2 1 4 7 4 8 3 6 4 8 milliseconds is reached, the va lue of this
timer returns to 0.
```
#3 0 0 2 This variable functions as a timer that counts in 1 –hour increments when
the cycle start lamp is on. This timer preserves its value even when the
power is turned off. When 9 5 4 4.3 7 1 7 6 7 hours is reached, the value of th is
timer returns to 0.
#3 0 1 1 This variable can be used to read the current date (year/month/day).
Year/month/day information is converted to an ISO date format. For
example, February 2 1, 2 0 1 1 is represented as 2 0 1 1 0 2 2 1.
#3 0 1 2 This variable can be used t o read the current time
(hours/minutes/seconds). Hours/minutes/seconds information is
converted to a 2 4 hour ISO time format. For example, 1 2 minutes and 4 3
seconds after 3 p.m. is represented as 1 5 1 2 4 3.

 Number of machine parts

The number (target numbe r) of parts required and the number (completed number) of machined
parts can be read and written.

Variable
number Function
#3 9 0 1 Number of machined parts (completed number)
#3 9 0 2 Number of required parts (target number)


<!-- Page 93 -->

9 3
 Modal information

Modal info rmation specified in blocks up to the immediately preceding block can be read.

Variable
number Function
#4 0 0 1
#4 0 0 2
#4 0 0 3
#4 0 0 4
#4 0 0 5
#4 0 0 6
#4 0 0 7
#4 0 0 8
#4 0 0 9
#4 0 1 0
#4 0 1 1
#4 0 1 2
#4 0 1 3
#4 0 1 4
#4 0 1 5
#4 0 1 6
:
#4 0 2 2
#4 1 0 2
#4 1 0 7
#4 1 0 9
#4 1 1 1
#4 1 1 3
#4 1 1 4
#4 1 1 5
#4 1 1 9
#4 1 2 0
#4 1 3 0 G 0 0, G 0 1, G 0 2, G 0 3, G 3 3 (Group 0 1)
G 1 7, G 1 8, G 1 9 (Group 0 2)
G 9 0, G 9 1 (Group 0 3)
(Group 0 4)
G 9 4, G 9 5 (Group 0 5)
G 2 0, G 2 1 (Group 0 6)
G 4 0, G 4 1, G 4 2 (Group 0 7)
G 4 3, G 4 4, G 4 9 (Group 0 8)
G 7 3, G 7 4, G 7 6, G 8 0 –G 8 9 (Group 0 9)
G 9 8, G 9 9 (Group 1 0)
G 5 0, G 5 1 (Group 1 1)
G 6 6, G 6 7 (Group 1 2)
G 9 6,G 9 7 (Group 1 3)
G 5 4–G 5 9 (Group 1 4)
G 6 1–G 6 4 (Group 1 5)
G 6 8, G 6 9 (Group 1 6)
: :
(Group 2 2)
B code
D code
F code
H code
M code
Sequence number
Program number
S code
T code
P code (number of the currently selected additional
work piece coordinate system)

Example:
When #1=#4 0 0 1; is executed, the resulting value in #1 is 0, 1, 2, 3, or 3 3.


<!-- Page 94 -->

9 4
 Current Position

Position information cannot be written but can be read. The ranges are for 6 axes of information.

Variable
number Position
information Coordinate
system
#4 1 4 0–#4 1 4 5 Origin Offset Machine coordinate system
#5 0 0 1–#5 0 0 6 Block end point Workpiece coordinate system
#5 0 2 1–#5 0 2 6 Current position Machine coordinate system
#5 0 3 0–#5 0 3 5 Axis offset
#5 0 4 1–#5 0 4 6 Current posi tion Workpiece coordinate system
#5 0 5 0–#5 0 4 5 G 9 2.3 offset
#5 0 6 1–#5 0 6 6 Skip signal position Workpiece coordinate system
#5 0 7 1–#5 0 7 6 Skip signal position Machine coordinate system
#5 0 8 1–#5 0 8 6 Head shift offset
#5 1 5 7 Programmed X (comp) Workpiece coord inate system
#5 1 5 8 Programmed Y (comp) Workpiece coordinate system
#5 1 5 9 Programmed Z (comp) Workpiece coordinate system
#5 1 8 1–#5 2 8 6 G 3 0 Positions Workpiece coordinate system

```
The tool position where the skip signal is turned on in a G 3 1 (skip function ) block is held in
variables #5 0 6 1 to #5 0 6 6. When the skip signal is not turned on in a G 3 1 block, the end point of
the specified block is held in these variables.


<!-- Page 95 -->

9 5
 Workpiece coordinate system values (fixture offsets)

Fixture offsets values can be read and written.

Variable
number Function
#5 2 0 1
:
#5 2 0 6 First–axis external workpiece zero point offset value (Work shift)
:
Fourth–axis external workpiece zero point offset value (Work shift)
#5 2 2 1
:
#5 2 2 6 First–axis G 5 4 workpiece zero point offset value
:
Fourth–axis G 5 4 workpiece zero point offset value
#5 2 4 1
:
#5 2 4 6 First–axis G 5 5 workpiece zero point offset value
:
Fourth–axis G 5 5 workpiece zero point offset value
#5 2 6 1
:
#5 2 6 6 First–axis G 5 6 workpiece zero point offset value
:
Fourth–axis G 5 6 workpi ece zero point offset value
#5 2 8 1
:
#5 2 8 6 First–axis G 5 7 workpiece zero point offset value
:
Fourth–axis G 5 7 workpiece zero point offset value
#5 3 0 1
:
#5 3 0 6 First–axis G 5 8 workpiece zero point offset value
:
Fourth–axis G 5 8 workpiece zero point offset va lue
#5 3 2 1
:
#5 3 2 6 First–axis G 5 9 workpiece zero point offset value
:
Fourth–axis G 5 9 workpiece zero point offset value
#7 0 0 1
:
#7 0 0 6 First–axis workpiece zero point offset value (G 5 4.1 P 1)
:
Fourth–axis workpiece zero point offset value
#7 0 2 1
:
#7 0 2 6 First–axis workpiece zero point offset value (G 5 4.1 P 2)
:
Fourth–axis workpiece zero point offset value
: :
#7 9 8 1
:
#7 9 8 6 First–axis workpiece zero point offset value (G 5 4.1 P 5 0)
:
Fourth–axis workpiece zero point offset value
#8 0 0 1
:
#8 0 0 6 First–axis wor kpiece zero point offset value (G 5 4.1 P 5 1)
:
Fourth–axis workpiece zero point offset value
#7 0 2 1
:
#7 0 2 6 First–axis workpiece zero point offset value (G 5 4.1 P 5 2)
:
Fourth–axis workpiece zero point offset value
: :
#7 9 8 1
:
#7 9 8 6 First–axis workpiece zero point offset value (G 5 4.1 P 1 0 0)
:
Fourth–axis workpiece zero point offset value


<!-- Page 96 -->

9 6
The following variables can also be used for fixture offsets :

Axis
Function Variable
number
X axis External workpiece zero point offset (Work
shift)
G 5 4 workpiece zero point offset
G 5 5 workpiece zero point offset
G 5 6 workpiece zero point offset
G 5 7 workpiece zero point offset
G 5 8 workpiece zero point offset
G 5 9 workpiece zero point offset #2 5 0 0
#2 5 0 1
#2 5 0 2
#2 5 0 3
#2 5 0 4
#2 5 0 5
#2 5 0 6 #5 2 0 1
#5 2 2 1
#5 2 4 1
#5 2 6 1
#5 2 8 1
#5 3 0 1
#5 3 2 1
Y axis External workpiece zero point offset (Work
shift)
G 5 4 workpiece zero point offset
G 5 5 workpiece zero point offset
G 5 6 workpiece zero point offset
G 5 7 workpiece zero point offset
G 5 8 workpiece zero point offset
G 5 9 workpiece zero point offset #2 6 0 0
#2 6 0 1
#2 6 0 2
#2 6 0 3
#2 6 0 4
#2 6 0 5
#2 6 0 6 #5 2 0 2
#5 2 2 2
#5 2 4 2
#5 2 6 2
#5 2 8 2
#5 3 0 2
#5 3 2 2
Z axis External workpiece zero point offset (Work
shift)
G 5 4 workpiece zero point offset
G 5 5 workpiece zero point offset
G 5 6 workpiece zero point offset
G 5 7 workpiece zero poi nt offset
G 5 8 workpiece zero point offset
G 5 9 workpiece zero point offset #2 7 0 0
#2 7 0 1
#2 7 0 2
#2 7 0 3
#2 7 0 4
#2 7 0 5
#2 7 0 6 #5 2 0 3
#5 2 2 3
#5 2 4 3
#5 2 6 3
#5 2 8 3
#5 3 0 3
#5 3 2 3
A axis External workpiece zero point offset (Work
shift)
G 5 4 workpiece zero point offset
G 5 5 work piece zero point offset
G 5 6 workpiece zero point offset
G 5 7 workpiece zero point offset
G 5 8 workpiece zero point offset
G 5 9 workpiece zero point offset #2 8 0 0
#2 8 0 1
#2 8 0 2
#2 8 0 3
#2 8 0 4
#2 8 0 5
#2 8 0 6 #5 2 0 4
#5 2 2 4
#5 2 4 4
#5 2 6 4
#5 2 8 4
#5 3 0 4
#5 3 2 4
B axis External wor kpiece zero point offset (Work
shift)
G 5 4 workpiece zero point offset
G 5 5 workpiece zero point offset
G 5 6 workpiece zero point offset
G 5 7 workpiece zero point offset
G 5 8 workpiece zero point offset
G 5 9 workpiece zero point offset #2 9 0 0
#2 9 0 1
#2 9 0 2
#2 9 0 3
#2 9 0 4
#2 9 0 5
#2 9 0 6 #5 2 0 5
#5 2 2 5
#5 2 4 5
#5 2 6 5
#5 2 8 5
#5 3 0 5
#5 3 2 5


<!-- Page 97 -->

9 7
Arithmetic and Logic
The operations listed in the following table can be performed on variables. The expression to the right of
```
the operator can contain constants and/or variables combined by a function or operator. Variables #j and
#k in an expression can be replaced with a constant. Variables on the left can also be replaced with an
expression.

Function Format Comments
Definition #i=#j
Sum
Difference
Product
Quotient #i=#j+#k
#i=#j–#k
#i=#j*#k
#i=#j/#k
Sine
Arcsine
Cosine
Arccosine
Tangent
Arctangent #i=SIN[#j]
#i=ASIN[#j]
#i=COS[#j]
#i=ACOS[#j]
#i=TAN[#j]
#i=ATAN[#j]/[#k] or #i=ATAN[#j] An angle is specified in degrees.
4 5 degrees and 1 5 minutes is
represented as 4 5.2 5 degrees.
Square r oot
Absolute value
Rounding off
Rounding down
Rounding up
Natural logarithm
```
Exponential function
Modulus #i=SQRT[#j]
#i=ABS[#j]
#i=ROUND[#j]
#i=FIX[#j]
#i=FUP[#j]
#i=LN[#j]
#i=EXP[#j]
#i=MOD[#j]
## OR
## XOR
AND #i=#j OR #k
#i=#j XOR #k
#i=#j AND #k A logical operation is performed on
binary numbers bit by bit.
Conversion from BCD to BIN
Conversion from BIN to BCD #i=BIN[#j]
#i=BCD[#j]
Read parameter value
Read parameter bit #i=PRM[#j]
#i=PRM[#j, #k] If the whole parameter address is to
be read, only #j need to be specified.
To read a bit of the parameter,
specify the parameter address with
#j and the bit number with #k.

 Abbreviations
```
When a function is specified in a program, the first two characters of the function name can be
used to specify the functio n.

Example:
ROUND RO
FIX FI
ATAN  AT, etc…


<!-- Page 98 -->

9 8
 Priority of operations
The order of operations is as follows:
## 1. Functions
### 2. Operations such as multiplication and division (*, /, AND)
### 3. Operations such as addition and subtraction (+, –, OR, XOR)

 Bracket nest ing

Brackets are used to change the order of operations. Brackets can be used to a depth of ten levels
```
including the brackets used to enclose a function.

When a depth of ten levels is exceeded, an error occurs.

Example: #1=SIN[ [ [#2+#3] *#4 +#5] *#6]

1. The content of #3 is added to the content of #2 .
2. The result of operation 1 is multiplied by the content of #4 .
3. The content of #5 is added to t he result of operation 2 .
4. The result of operation 3 is multiplied by the content of #6.
```
5. The result of operation 4 is the value passed to the SIN[] function.

