# Lathe GCode Programming

*Converted from PDF: Lathe GCode Programming.pdf*
*Conversion date: /Users/chondl/learn/mach4/scripts*

---

<!-- Page 1 -->

1

Mach 4 CNC Controller
Lathe Programming Guide
Version 1. 1
Build 3 7 5 7


<!-- Page 2 -->

2
Copyright © 2 0 1 4 Newfangled Solutions, Artsoft USA, All Rights Reserved
The following are registered trademarks of Microsoft Corporation: Microsoft, Windows. Any other
trademarks used in this manual are the property of the respective trademark holder.
Table of Contents
Chapter 1: Introduction ................................ ................................ ................................ ................................ 3
Glossary ................................ ................................ ................................ ................................ ..................... 4
Format ................................ ................................ ................................ ................................ ....................... 5
Chapter 2: G Codes ................................ ................................ ................................ ................................ ....... 7
G Code Descriptions and Examples ................................ ................................ ................................ ......... 1 0
Chapter 4: Hole Machining Canned Cycles ................................ ................................ ................................ . 5 3
Drilling ................................ ................................ ................................ ................................ ..................... 5 5
Tapping ................................ ................................ ................................ ................................ .................... 5 8
Boring ................................ ................................ ................................ ................................ ...................... 6 1
Chapter 5: Advanced Hole Machining Canned Cycles ................................ ................................ ................ 6 3
Advanced Drilling ................................ ................................ ................................ ................................ .... 6 4
Advanced Tapping ................................ ................................ ................................ ................................ ... 6 8
Advanced Boring ................................ ................................ ................................ ................................ ..... 7 0
Chapter 6: Tool Nose Radius Compen sation ................................ ................................ .............................. 7 6
Chapter 7: M Codes ................................ ................................ ................................ ................................ .... 8 1
M Code Descriptions ................................ ................................ ................................ ............................... 8 1


<!-- Page 3 -->

3
Chapter 1: Introduction
G Code is a speci al programming l anguage that is interpreted by Computer Numerical C ontrol (CNC)
machines to create motion and other tasks. It is a language that can be quit e complex at times and can
vary from machine to machine. The basics, however, are much simpler than it first appears and for the
most part follows an industry adopted standard. Mach 4 has made a large leap closer to this standard.
An important point to remember when reading this manual: In describing motion of a machine it will
always be described as tool movement relative to the work piece. In many machines the work piece will
move in more axes than the tool; however the program will always define tool movement around the
work piece. Axes directions follow the right hand rule, see figure A.

Figure A: Right hand rule.


<!-- Page 4 -->

4
Glossary
Block A single line of G Code
Canned Cycle Complex cycle defined by a single block of code
Dwell Program pause with a duration defined by “P” in milli seconds . If “P“ contains a
decimal point, the dwell is in seconds.
EOB End o f block. Required at the end of every block of G Code. In Mach 4 this is a
carriage return
Feedrate Velocity, set by F, at which an axis will move
```
Group Collection of G codes that control the same function or mode, i.e. G 9 0 and G 9 1
positioning modes
Moda l Active until a code from the same group is called
Normal A line perpendicular to a plane, pointing in the positive direction.
Origin Point in a coordinate system where X, Y and Z are zero
RPM Revolutions per minute
UPM Units per minute (inches, milli meters, degrees, etc)
Word A single word of G Code is a letter followed by a number. G 0 1, X 1.0, etc. are words

```
G Preparatory function, G followed by a numerical code, specifies machining modes
```
and functions
```
M Miscellaneous function, M followed by a num erical code, defines program flow and
```
can control auxiliary functions such as coolant . Can also perform machine specific
```
functions and macros user or builder.
X, Y, Z , C Absolute m ovement commands followed by a numerical value, define the end point
of a motion command in the user coordinate system.
U, V, W, H Incremental movement commands followed by a numerical value, define the
distance and direction to the end point of a motion command.
S Spindle speed, followed by numerical value of desired rpm or su rface speed
T Tool call, followed by next tool number and offset to be used
F Followed by a numerical value to define the feedrate. The magnitude and value of
which will be determined by the feed mode setting
P Followed by a numerical value, specifies d well time in milli seconds . (also used in
```
other functions) If P contains a decimal point, then the time is in seconds.
N Sequence numbers. Used for program organization and go to commands


<!-- Page 5 -->

5

Format
In writing G Code programs there are some rules to be a ware of as well as some general formatting
guidelines that should be followed or at least considered.
The first part of any progra m should be a safe start up block . This line of code is used to make sure that
some modes are disabled and others are set to t heir most common setting . An example safe start block
would look like this:
## G 0 0 G 1 8 G 5 4 G 4 0 G 8 0
This block of code tells the machine that we want to be in rapid mode and using absolute position in the
ZX plane of fixture offset 1. At the same time we want to cancel tool nose radius compensation and
make sure any active canned cycles are cancelled.
G 0 0 – Rapid mode
G 1 8 – ZX plane select
G 5 4 – Fixture offset 1
G 4 0 – Tool nose radius compensation cancel
G 8 0 – Canned cycle cancel
It is recommended that this sa fe start block be used at the start of the program and also before or
immediately following every tool change. It is common to restart a program from a tool change, having
the safe start line there can greatly reduce the chance of a machine not acting as e xpected, the results
of which can be aggravating at best and a crash at worst. The safe start block shown here is just an
example. Every machine and every programmer are a little different and each will have their own start
up block.
Jumping to the end of the program there is not a lot required. Typically there will be a couple blocks of
code to return the X and Z axes to a safe position. Shutting off the spindle and coolant or any other
accessories is also a good idea here. The final block in a program is a program end code, most commonly
M 3 0 but there are other options. Make sure this final block is followed by an end of block. It is easy to
forget this last EOB in a program for Mach because it is simply a carriage return and not always readily
apparent. One way to make sure that there is always an EOB on your program end block is to follow it
with %. Like this:
.
.
.
## M 3 0
%


<!-- Page 6 -->

6
This percent sign is a familiar symbol to CNC programmers in industry; however any symbol or character
can be used as it will not be re ad by the control because of the program end before it. If there is no EOB
following th e percent sign it will not even show up in the program when loaded into Mach.
In between the start and end is the body of the program. There are a few rules here. Each b lock of code
will contain a combination of words. Multiple G codes can be specified in a single block, however if more
than one from the same modal group is specified the last one in the block will be valid , with the
exception of group 0 0 . Modal G codes st ay active until another from the same group is called. For
example; G 0 1 is modal so it is not necessary to put it in consecutive blocks. Once activ e every successive
positioning block will be in the G 1 mode unless anothe r code from group one is called ( G 0 0, G 0 2, G 0 3,
etc.). All G codes not in group 0 behave this way. In the following example, the program on the right will
result in the exact same motion as the program on the left. Once specified, the G 1 will remain active for
successive blocks.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 -- Safe start line
T 0 1 0 1 -- Tool change
S 2 5 0 0 M 3 -- Start spindle
G 9 9 -- Feed per revolution mode
G 0 X 0.0 Z 1.0 G 0 X 0.0 Z 1.0 Rapid to XY position
G 1 Z 0.0 F 0.0 0 8 G 1 Z 0.0 F 0.0 0 8 Move to position at feedrate
G 1 X 1.0 X 1.0 Move to position at feedra te
G 1 Z -2.0 Z-2.0 Move to position at feedrate
G 1 X 1.5 X 1.5 Move to position at feedrate
G 1 Z -4.0 Z-4.0 Move to position at feedrate
G 0 G 5 3 X 0 Z 0 G 0 G 5 3 X 0 Z 0 Rapid return X and Z to home position
M 3 0 -- Program end and rewind

Only one M code can be specified in a single block. Sam e holds true for all other words.
Generally leading zeroes are not required in G Code. For example G 0 1 and G 1 are the same. The same
holds true for M codes, position commands, feedrates, etc. When specifying values for posi tion,
feedrate, variables, etc., it is good practice to always use a decimal point and trailing zero, instead of X 1
use X 1.0. Although the decimal point is not required (in Mach X 1 = X 1.0) it is HIGHLY recommended.


<!-- Page 7 -->

7
Chapter 2: G Code s
Code Group Descripti on Modal Page
G 0 0 1 Rapid Move Y 1 0
G 0 1 1 Linear Feed Move Y 1 0
G 0 2 1 Clockwise Arc Feed Move Y 1 1
G 0 3 1 Counter Clockwise Arc Feed Move Y 1 1
G 0 4 0 Dwell N 1 4
G 0 9 0 Exact stop N 1 5
G 1 0 0 Overview / Tool Offset Setting Y/N 1 6
G 1 0 L 2 0 Fixture Offset Setting Y/N 1 8
G 1 0 L 3 0 Tool Life Management Settin g Y 2 0
… 0 G 1 0 L 3 Format 1 - Delete and Add Y 2 1
… 0 G 1 0 L 3 Format 2 – Add or Change Y 2 2
… 0 G 1 0 L 3 Format 3 – Delete Group Y 2 3
G 1 0 L 2 0 Additional Fixture Offset Setting Y/N 2 4
G 1 1 0 G 1 0 Cancel N 2 5
G 1 2 1 Clockwise Circle Y 2 5
G 1 3 1 Counte r Clockwise Circle Y 2 5
G 1 7 2 XY Plane Select Y 2 6
G 1 8 2 ZX Plane Select Y 2 6
G 1 9 2 YZ Plane Select Y 2 6
G 2 0 6 Inch Y 2 7
G 2 1 6 Millimeter Y 2 7
G 2 8 0 Zero Return N 2 8
G 2 8.1 0 Home Axes N 2 9
G 3 0 0 2 nd, 3 rd, 4 th Zero Return N 2 9
```
G 3 1 1 Probe function N 2 9
G 3 2 1 Threading * N 3 1
G 3 4 1 Variable Lead Threading * N 3 3
G 3 5 1 Clockwise Circular Threading * N 3 4
G 3 6 1 Counterclockwise Circular Threading * N 3 4
G 4 0 7 Tool Nose Radius Compensation Can cel Y 3 5
G 4 1 7 Tool Nose Radius Compensation Left Y 3 5
G 4 2 7 Tool Nose Radius Compensation Right Y 3 5
G 5 0 0 Min/ Max Spindle Speed N 3 6
G 5 0 0 Local Coordinate System Setting N 3 6
G 5 0.1 1 1 Cancel Scaling Y 3 7
G 5 1.1 1 1 Scale Axes Y 3 7
G 5 2 0 Local Coordinate System Shift Y 3 8
G 5 3 0 Machine Coordinate System N 3 9


<!-- Page 8 -->

8
G 5 4 1 4 Fixture Offset 1 Y 3 9
G 5 4.1 1 4 Additional Fixture Offsets Y 3 9
G 5 5 1 4 Fixture Offset 2 Y 3 9
G 5 6 1 4 Fixture Offset 3 Y 3 9
G 5 7 1 4 Fixture Offset 4 Y 3 9
G 5 8 1 4 Fixture Offset 5 Y 3 9
G 5 9 1 4 Fixture Offset 6 Y 3 9
G 6 0 0 Unidirectional Approach N 4 0
G 6 1 1 5 Exact Stop Mode Y 4 0
G 6 4 1 5 Cutting Mode (Constant Velocity) Y 4 0
G 6 5 0 Macro Call N 4 1
G 6 6 1 2 Macro Modal Call Y 4 1
G 6 7 1 2 Macro Modal Call Cancel Y 4 2
G 7 3.1 9 High Speed Peck Drilling (Advan ced) Y 6 7
G 7 4.1 9 Reverse Tapping (Advanced) Y 6 9
G 7 6 0 Thread Cutting Cycle (Two block style) N 4 2
G 7 6 0 Thread Cutting Cycle (One block style) N 4 5
G 7 6.1 9 Fine Bo ring (Advanced) Y 7 0
G 8 0 9 Canned Cycle Cancel Y 5 4
G 8 1.1 9 Hole Drilling (Advanced) Y 6 4
G 8 2.1 9 Spot Face (Advanced) Y 6 5
G 8 3 9 Face Drilling Y 5 5
G 8 3. 1 9 Deep Hole Peck Drilling (Advanced) Y 6 6
G 8 4 9 Face Tapping Y 5 8
G 8 4.1 9 Tapping (Advanced) Y 6 8
G 8 4.2 9 Right Hand Rigid Tapping* (Advanced) Y 6 9
G 8 4.3 9 Left Hand Rigid Tapping* (Advanced) Y 6 9
G 8 5 9 Face Boring Y 6 1
G 8 5.1 9 Boring, Retract at Feedrate (Advanced) Y 7 1
G 8 6.1 9 Boring, Retract at Rapid (Advanced) Y 7 2
G 8 7 9 Side Drilling Y 5 5
G 8 7.1 9 Back Boring (Advanced) Y 7 3
G 8 8 9 Side Tapping Y 6 0
G 8 8.1 9 Boring, Manual Retract (Advanced) Y 7 4
G 8 9 9 Side Boring Y 6 2
G 8 9.1 9 Boring with Dwell (Advanced) Y 7 5
G 9 0.1 4 Arc Center Absolute Mode Y 4 8
G 9 1.1 4 Arc Center Incremental Mode Y 4 8
G 9 2 1 Simple Threading Cycle* Y 4 9
G 9 3 5 Inverse Time Feed Y 5 0
G 9 6 1 3 Constant Surface Speed * Y 5 0


<!-- Page 9 -->

9
G 9 7 1 3 Constant Speed Y 5 0
G 9 8 5 Feed Per Minute Y 5 0
G 9 8.1 1 0 Initial Point Return Y 5 0
G 9 9 5 Feed Per Revolution* Y 5 2
G 9 9.1 1 0 R Point Return Y 5 2
* Implementation based on machine and control configuration


<!-- Page 10 -->

1 0
G Code Descriptions and Examples

G 0 0 – Rapid move: Rapid moves are used to move from point to point in free space, not cutting
material. These moves do not require a feed rate input as they take place at max velocity of the
machine . For absolute positioning X and Z define the end point of the move in the user coordinate
system. For incremental positioning U and W define the distance and direction to move from the current
position.
Format: G 0 0 X__ Z__
Example: Program a rapid move to X 1. 0, Z 3.0. Then make an incremental move -0.5 in the X and -0.2 5 in
the Z.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1 .0 Z 3.0 Rapid to XZ position
U-0.5 W -0.2 5 Incremental move will end at X 0.5, Z 2.7 5
M 3 0 Program end and rewind

G 0 1 – Linear Feed Move: Linear feed moves ar e point to point moves in a straight line at a federate
specified by F. The moves are interpolated so all axes in motion reach the end point at the same time. .
For absolute positioning X and Z define the end point of the move in the user coordinate system . For
incremental positioning U and W define the distance and direction to move from the current position.
Format: G 0 1 X__ Z__ F__.
Example: Program a feed move from X 1.0, Z 3.0 to X 1 0.0, Z -1.0 at a feedrate of 1 5 .0 UPM.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
S 2 5 0 0 M 3 Start spindle
G 9 8 Feed per minute mode
G 0 X 1 .0 Z 3.0 Rapid to XZ position
G 1 X 1 0 .0 Z-1.0 F 1 5.0 Move to XZ position at feedrate
M 3 0 Program end and rewind
Note:
For clarity this manual assumes a basic 2 axis lathe, X and Z, unless
otherwise specified. More advanced machines may have Y and C
axes, or more as specified by the machine builder. Some examples
and formats may omit the Y, A, B and C axes for clarity. They can
be included in all motion moves.


<!-- Page 11 -->

1 1
G 0 2/G 0 3 – Arc Feed Move: Used to cut an arc at a federate specified b y F. An arc is defined by its start
and end points, its radius or center point, a direction, and a plane. Direction is determined by G 0 2,
clockwise, and G 0 3, counterclockwise , when viewed from the plane’s positive direction (If ZX plane is
selected look do wn so that the X axis positive direction is pointing forward , and the Z axis positive
direction is pointing to the right ). See figure 2 -1 for a graphic representation of the motion for G 0 2. The
start point is the current position of the machine. Specify th e end point with X and Z or U and W . For
absolute positioning X and Z define the end point of the move in the user coordinate system. For
incremental positioning U and W define the distance and direction to move from the current position.
K (Abs)
I (Abs)K (Inc)
I (Inc)
RStart
Point
Work
Zero X
Z

Figure 2 -1: Mot ion of tool tip for G 0 2 command.
Next is to specify the radius or the center point of the arc, on ly one or the other, not both.
 To specify the radius, use R and input the actual radius of the desired arc, see Format 2. When
an arc is created knowing only s tart and end points and a radius there are two possible
solutions, an arc with a sweep less than 1 8 0° and one with sweep greater than 1 8 0°. The sign of
the radius value, positive or negative, determines which arc will be cut, see figure 2 -2. A positive
value for R cuts an arc with sweep less than 1 8 0°. A negative value for R cuts an arc with sweep
greater than 1 8 0°.
 A more accurate and reliable way to define an arc is by specifying the center point, th is is done
with a ddresse s I, and K , see Format 1 . The ce nter point must be defined in the current plane. I
and K corresp ond to X and Z respectively . Mach has two settings for how I and K should be
specified, absolute and incremental. This setting can be changed by G code, G 9 0.1 and G 9 1.1, or
in the general tab in the Mach configuration. If arc center mode is set to incremental then I and
K are the distance and direction from the start point to the center point of the arc , I is a radius


<!-- Page 12 -->

1 2
value . If arc center mode is set to absolute then I and K are the absolute po sition of the arc
center point in the current user coordinate system , I is a diameter value .
Format 1: (G 1 8) G 0 2/0 3 X__ Z__ I__ K__ F__
Format 2: (G 1 8) G 0 2/0 3 X__ Z__ R__ F__

-R +R
Start Point End Point Start Point End Point
Figure 2 -2: Difference between negative and positive values for R

Figure 2 -2: Difference between positive and negative values of R

Example: Pro gram an arc centered at X 1.0, Z-0.2 in the ZX plane with radius 0.2. Start point at X 1.0, Z 0.0
and sweep 9 0 degrees counter clockwise. Feedrate 0.0 0 6 UPR. (Arc center mode set to incremental)
Format 1:
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Z 0.0 Position to X and Y start point
G 9 9 Feed per revolution mode
G 3 X 1.4 Z-0.2 I 0.0 K -0.2 F 0.0 0 6 Arc move
G 0 G 5 3 X 0.0 Return X to home
G 0 G 5 3 Z 0.0 Return Z to home
M 3 0 Program end and rewind
Format 2:
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 1.0 Z 0.0 Position to X and Y start point
G 9 9 Feed per revolution mode
G 3 X 1.4 Z -0.2 R 0.2 F 0.0 0 6 Arc move
G 0 G 5 3 X 0.0 Return X to home
G 0 G 5 3 Z 0.0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 13 -->

1 3

```
Lathes with Y axis capability can also make arc moves in other planes. The function of G 0 2 and G 0 3
remains the same, but t he format changes slightly to accommodate the additional axis and plane
options. For specifying the arc center position use J for the Y axis component.
Format 1: (G 1 7) G 0 2/0 3 X__ Y__ I__ J__ F__
(G 1 8) G 0 2/0 3 X__ Z__ I__ K__ F__
(G 1 9) G 0 2/0 3 Y__ Z__ J__ K__ F__
Format 2: (G 1 7) G 0 2/0 3 X__ Y__ R__ F__
(G 1 8) G 0 2/0 3 X__ Z__ R__ F__
(G 1 9) G 0 2/0 3 Y__ Z__ R__ F__
Helical int erpolations are also possible using G 0 2 and G 0 3; however a Y axis is required for the third
```
coordinate of the end point , not all lathes will support this functionality . The third coordinate will define
the height of the helix. See the following format for what this looks like in the XY plane:
Format 1: (G 1 7) G 0 2/0 3 X__ Y__ Z__ I__ J__ F__
Format 2: (G 1 7) G 0 2/0 3 X__ Y__ Z__ R__ F__
Example: Program a helix with radius 1.0 and center point 0 .0, 0.0 in the X,Y plane, start point 0 .0, .5,
height 1.0 with initia l Z at 0. 0. Feedrat e 1 0 .0 UPM. Arc sweep should be 2 7 0° clockwise .
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 X 0 .0 Y.5 Position to X and Y start point
G 0 Z.5 Activate tool offset 1 and move to Z rapid plane
G 9 8 Feed per minute mode
G 1 Z 0. 0 F 1 0. 0 Z plunge at feedrate
G 2 X -.5 Y 0 .0 Z-1.0 I 0 .0 J-.5 F 1 0. 0 Helical interpolation
G 0 Z.5 Retract Z to rapid plane
G 0 G 5 3 Z 0.0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 14 -->

1 4

G 0 4 – Dwell: A dwell is simply a pause in the pro gram. The duration of the dwell is specified by P in
milli seconds with no decimal point . If a decimal point i s used, then P specifies seconds. No machine
movement will take place during a dwell. No auxiliary codes will be turned off, i.e. if the spindle i s on it
will stay on, coolant will stay on, etc.
Format: G 0 4 P__
Example: Program a 5 second dwell after positioning to X 1.0, Z 1.0 (using no decimal point to specify
milliseconds).
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
S 2 5 0 0 M 3 Start spind le
G 0 X 1.0 Z 1.0 Rapid to XZ position
G 4 P 5 0 0 0 Dwell for 5 seconds
M 3 0 Program end and rewind

Example: Program a 5 second dwell after positioning to X 1 .0, Z 1.0 (using decimal point to specify
seconds) .
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool cha nge
S 2 5 0 0 M 3 Start spindle
G 0 X 1 .0 Z 1.0 Rapid to XZ position
G 4 P 5. Dwell for 5 seconds
M 3 0 Program end and rewind


<!-- Page 15 -->

1 5
G 0 9 – Exact Stop: G 0 9 is a non -modal exact stop. Machine accelerations cause corners to be slightly
```
rounded; when a true sharp corner is required G 0 9 should be used. Although similar to G 6 1 in function,
G 0 9 is not modal while G 6 1 is. When G 0 9 is included in a movement block, axis motion is decelerated to
the end point of motion and the position is checked to be exactly as specified. This position check at the
end of the move ensures that the machine actually reaches the desired position before moving onto the
next block
Format: G 0 1 G 0 9 X__ Z__ F__
Example: Program a stepped shaft, first diameter is 1.0 inch for 2.0 inch length, second di ameter is 1.5
inch for 2 inch length. Make a sharp corner at X 1.5, Z -2.0. Feedrate 0.0 0 8 IPR.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
S 2 5 0 0 M 3 Start spindle
G 9 9 Feed per revolution mode
G 0 X 0.0 Z 1.0 Rapid to XY position
G 1 Z 0.0 F 0.0 0 8 Mov e to position at feedrate
X 1.0 Move to position at feedrate
Z-2.0 Move to position at feedrate
G 9 X 1.5 Move to position at feedrate, exact stop active
Z-4.0 Move to position at feedrate
G 0 G 5 3 X 0 Z 0 Return X and Z to home position
M 3 0 Program end and rewind

Figure 9 -1 shows what this shaft would look like, slightly exaggerated.
Figure 9 -1: Shaft with sharp corner Without
Exact Stop With Exact
Stop

Figure 9 -1: Corners with and without exact stop.


<!-- Page 16 -->

1 6
G 1 0 – Overview: It is possible to set fixture and tool offsets in the program. This can be very useful for
```
programming mu ltiple fixtures that have known zero points, multi pallet machines, applying automatic
compensation of tool wear, and many other situations that require changing offset values. G 1 0 is also
one of the least understood G codes and is therefore underutilized. Changing offset values in a program
requires a bit of cautiousness, a mistake can easily result in ruined parts and damaged tools or
machines. When used properly however, G 1 0 can add flexibility and safety to a program and machine,
especially with automat ion and lights out capacity or inexperienced operators.
G 1 0 – Tool Offset Setting: G 1 0 (without an L__ word) is used to set tool offsets in a program. Tool
offset setting requires just as much care as setting of fixture offsets. Specifying in absolute ca uses the
current value to be over written with the value in the G 1 0 block, while incremental adds the value from
the G 1 0 block to the current value.
Format (Absolute): G 1 0 P__ X__ Y__ Z__ R__ Q__ T__
Format (Incremental): G 1 0 P__ U__ V__ W__ C__ Q __ T__

Or the modal version:
## G 1 0
## P__ X__ Y__ Z__ R__ Q__ T__
## P__ U__ V__ W__ C__ Q__ T__
…
## G 1 1
Not all values are required, if omitted that value simply will not be set. P__ specifies the offset that is to
be modified. It also determines if the work shift offset is modified or if tool geometry offsets or tool
wear offsets are modified. Specify P__ as follows:
 0: work shi ft offset is modified.
 1-9 9: The tool wear offset is modified.
 1 0 0 0 0+(1 -9 9): The tool geometry offset is modified.
The remaining arguments speci fy the type and value of offset to be set.
X(U) X offset
Y(V) Y offset
Z(W) Z offset
R(C) Tool nose radius
Q Imaginary Position
T Tool tip direction

It is possible to use X__ Y__ Z__ R__ and U__ V__ W__ C__ in the same G 1 0 block.


<!-- Page 17 -->

1 7
Example: Set X va lue of tool offset #5 to -5.0. Add .0 5 to Z axis wear offset #2.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 1 0 P 1 0 0 0 5 X-5.0 Set X axis offset #5 to -5.0
G 1 0 P 2 W.0 5 Add .0 5 to Z wear for offset #2
M 3 0 Program end and rewind

Example: Set X value of tool offse t #5 to -5.0. Add .0 5 to Z axis wear offset #2 using the modal variant.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 1 0 Start the G 1 0 sequence
P 1 0 0 0 5 X -5.0 Set X axis offset #5 to -5.0
P 2 W.0 5 Add .0 5 to Z wear for offset #2
G 1 1 Cancels the G 1 0 sequence
M 3 0 Program end and rewind


<!-- Page 18 -->

1 8
G 1 0 L 2 – Fixture Offset Setting: G 1 0 L 2 is used to set fixture offsets in a program.
Starting with fixture offset setting the G 1 0 block will look like the following:
Format (Absolute) : G 1 0 L 2 P__ X__ Y__ Z__ C__
Format ( Incremental ): G 1 0 L 2 P__ U__ V__ W__ H__
Or the modal version:
## G 1 0 L 2
## P__ X__ Y__ Z__ C__
…
## P__ U__ V__ W__ H__
…
## G 1 1
The value of P __ specifies which offset is being set. For the basic 6 fixture offsets P__ values are as
follows:
Fixture offset (G__) P__
Work Shif t 0
5 4 1
5 5 2
5 6 3
5 7 4
5 8 5
5 9 6

The data for the fixture offset is set by X, Y, Z, C and U, V, W, H.
X(U) X axis offset
Y(V) Y axis offset
Z(W) Z axis offset
C(H) C axis offset

All values do not need to be specified, only the ones to be set. If, for example, a Z is not programmed it
simply will not be changed in the fixture offset.
When specified in absolute mode (X, Y, Z, C) the values in the G 1 0 line will be directly input into the
fixture offset . When specified in incremental mode (U, V, W , H) the values will be added to the desired
```
fixture offset. This is a major difference in functionality and care should be taken to make sure the
correct arguments are used for the desired effect.


<!-- Page 19 -->

1 9
Example: Set G 5 6 fixture offset to X -8.0, Y-3.0, Z-5.0, C 4 5.0 in a program.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 1 0 L 2 P 3 X -8.0 Y-3.0 Z-5.0 C 4 5.0 Set G 5 6 fixture offset values
M 3 0 Program end and rewind

Example: Set G 5 6 fixture offset to X -8.0, Y -3.0, Z -5.0, C 4 5.0 in a program with the modal version .
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 1 0 L 2 Start the G 1 0 sequence
P 3 X -8.0 Y -3.0 Z -5.0 C 4 5.0 Set G 5 6 fixture offset values
P 3 U.1 V.1 W.1 H.1 Add .1 to G 5 6 fixture offset values
G 1 1 Cancel the G 1 0 L 2 sequence
M 3 0 Program end and rewind


<!-- Page 20 -->

2 0
G 1 0 L 3 – Tool Life Management Setting : Tool life management data can be registered, changed, or
deleted in a G code program. TLM is an Industrial only feature.
There are 3 G 1 0 L 3 program formats which provide for the following actions:
Function Description
Delete all too l groups and register new data Delete all existing tool group and tool data
before adding new tool group and tool data.
This effectively replaces the entire TLM data.
Add or change tool or group data Add or change TLM data for a tool group.
Delete tool or group data Delete TLM data for a tool group.
Specify the tool life count type How tool life is counted for an individual group
(time, frequency, and per cycle).
Specify the tool life value The time (minutes) or cycle count value.

G 1 0 L 3 is always modal and multiple lines are used in the formats. All formats of G 1 0 L 3 will require G 1 1
to cancel.

Tool groups are specified as positive integers from 1 to 9 9. A tool group is selected for a tool change
with the T word by specifying a 2 digit group n umber and 9 9. For example, for tool group 1, T 0 1 9 9
would be used.
The tool life count type is specified with a 1 (cycle count) or 2 (time). The time based life count is best
suited for cutting tools that can be characterized by the amount of cutting tim e they can endure and still
remain viable. The cycle based life count is best suited for tools that are typically used in canned cycles
that can typically be characterized by the number holes or bores they can endure and still remain viable.
The tool li fe value is a positive integer number that specifies the life of the tool (minutes or number of
cycles the tool is used). It will count up from 0 to the life count specified by the group, at which point,
the tool’s life will expire.
Unlike a Fanuc, the only limit to the number of tools in a tool group is the maximum tool setting for the
control, which is limited to 9 9 tools.


<!-- Page 21 -->

2 1
G 1 0 L 3 Format 1 - Register with deleting all groups: The G 1 0 L 3 line starts the sequence. The next line
specifies the group P_, the life count value L_, and the optional life count type Q_. If Q is not specified,
the value of bit 2 (0 == cycle or 1 == time) in system variable #6 8 0 0 will determine the life count type.
The next line(s) specify the tool number T_. T should be co mprised of a 2 digit tool number plus a two
digit offset number. The T_ line may be repeated for as many tools in the group as needed. Multiple
tool groups can be populated by adding a new P_ L_ line sequence with its’ own following T _ lines. The
G 1 0 fu nction is then canceled with G 1 1.
Format:
## G 1 0 L 3
P__ L__ [Q__]
## T__
…
P__ L__ [Q__]
## T__
…
## G 1 1
Example: Delete all tool group information and add new data.
G 1 0 L 3 Start the register with delete sequence (No P_
given). This will delete all preexisting TLM data.
P 1 L 1 0 0 0 Q 1 Select group 1 with a 1 0 0 0 life count and a cycle
based life count type.
T 0 1 0 1 Add too 1 1 to group 1 using offset from tool 1.
T 0 2 0 1 Add tool 2 but use tool 1 offset.
P 2 L 5 0 0 0 Q 2 Select group 2 with a 5 0 0 0 life count with a time
base d life count type.
T 0 3 0 3 Add tool 3 to group 2.
T 0 4 0 4 Add tool 4 to group 2
G 1 1 End G 1 0 sequence.


<!-- Page 22 -->

2 2
G 1 0 L 3 Format 2 – Add or change tool group : The G 1 0 L 3 P 1 line to starts the sequence. The next line
specifies the group P_, the life count value L_, and the optional life count type Q_. If Q is not specified,
the value of bit 2 (0 == cycle or 1 == time) in system variable #6 8 0 0 will determine the life count type. If
the group did not exist, it is added. If the group exists the L_, and Q_ values wil l be updated with the
specified values. The next l ines specify the tool number T_. T should be comprised of a 2 digit tool
number plus a two digit offset number. If the tool did not exist in the group, the tool will be added. If
the tool exists in the group, the values will be updated with the specified values. The T_ line may be
repeated for as many tools in the group as needed. Multiple tool groups can be populated by adding a
new P_ L_ line sequence with its’ own following T_ lines. The G 1 0 functi on is then canceled with G 1 1.
Format:
## G 1 0 L 3 P 1
P__ L__ [Q__]
## T__
…
## G 1 1
Example: Add or change tool group information.
G 1 0 L 3 P 1 Start the register or change tool group
sequence.
P 1 L 1 0 0 0 Q 1 Select group 1 with a 1 0 0 0 life count and a cycle
based life co unt type. Assume that the group
exists and that only the life count was updated.
T 0 1 0 1 Add too 1 1 to group 1 using offset from tool 1.
T 0 2 0 1 Add tool 2 but use tool 1 offset. Assume that
the tool already existed in the group, but was
using offset 2 .
P 2 L 5 0 0 0 Q 1 Select group 2 with a 5 0 0 0 life count with a cycle
based life count type. Assume that the group
didn’t exist therefore it will be added.
T 0 3 0 3 Add tool 3 to group 2.
T 0 4 0 4 Add tool 4 to group 2
G 1 1 End G 1 0 sequence.


<!-- Page 23 -->

2 3
G 1 0 L 3 Format 3 – Delete tool life data : The G 1 0 L 3 P 2 line to starts the sequence. The next line
specifies the group P_, to delete. Multiple groups can be specified for deletion on the following lines as
```
needed. The G 1 0 function is then canceled with G 1 1.
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


<!-- Page 24 -->

2 4
G 1 0 L 2 0 – Additional Fixture Offset Setting: Additional fixture offsets, G 5 4.1 Pxx, can also be set using
G 1 0. Setting of the se offsets is the same, except it is done using L 2 0. The legacy additional fixture offsets
(see fixture offset section of this manual for more details) can still be set with G 1 0. The following table
shows the additional fixture offset P number and its corresponding G 1 0 P number as well as the legacy
offsets . Note that G 5 4.1 P 1 is the same offset as G 5 9 P 7, so G 1 0 L 2 0 P 1 and G 1 0 L 2 P 7 both set the same
offset values.
Starting with fixture offset setting the G 1 0 L 2 0 block will look like the following:
Format (Absolute): G 1 0 L 2 0 P__ X__ Y__ Z__ C__
Format (Incremental): G 1 0 L 2 0 P__ U__ V__ W__ H__
Or the modal version:
## G 1 0 L 2 0
## P__ X__ Y__ Z__ C__
…
## P__ U__ V__ W__ H__
…
## G 1 1
The value of P__ specifies which offset is being set. Head shift is set using P 0. The following table
describes the use of P__ for the additional fixture offsets:
G 5 4.1 P__ G 1 0 L 2 0 P__ Legacy G 5 9 P__ Legacy G 1 0 L 2 P__
1 1 7 7
2 2 8 8
3 3 9 9
- - - -
- - - -
- - - -
2 4 8 2 4 8 2 5 4 2 5 4
Exam ple: Set G 5 4.1 P 5 fixture offset to X 3. 0, Y 3.4, Z -1 0.0 in a program.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start lin e
G 1 0 L 2 0 P 5 X 3.0 Y 3.4 Z -1 0.0 Set G 5 4.1 P 5 fixture offset values
M 3 0 Program end and rewind

Example: Set G 5 4.1 P 5 fixture offset to X 3.0, Y 3.4, Z -1 0.0 in a program.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start lin e
G 1 0 L 2 0 Start the G 1 0 L 2 0 sequence.
P 5 X 3.0 Y 3.4 Z -1 0.0 Set G 5 4.1 P 5 fixture offset values
P 5 U.1 V.1 Z -.1 Add .1 to the previously set values
G 1 1 Cancel the G 1 1 sequence
M 3 0 Program end and rewind


<!-- Page 25 -->

2 5
G 1 1 – Cancel Modal G 1 0: To end the G 1 0 modal state a G 1 1 must be called. G 1 1 should be specified on
its own line. The only G 1 0 that is always modal is G 1 0 L 3 (Tool Life Management) setting.
Format: G 1 1
G 1 2/G 1 3 – Circle Interpolation: These codes are used to cut a circle using the current position as the
center point. A word, I, defines the radius of the circle. G 1 2 will cut a circle in the clockwise direction
and G 1 3 will cut in the counterclockwise direction. It is also possible to cut a larger circular pocket by
specifying Q for the start radius and P for the step over amount. This ca n be useful for cutting a circular
pocket or an ID groove.
Format 1: G 1 2/1 3 I__ F__
Format 2: G 1 2/1 3 I__ Q__ P__ F__
See figure 1 2 -1 for a graphic of the motion. The tool wi ll move in the positive X direction
Figure 1 2 -1: Tool motion during circle interpolation Center Point I,K
Q P Center Point IKRadius

Figure 1 2 -1: Tool motion during circular interpolation
Example: Cut a 1.0 inch radius circle centered at X 1.5 Y 0.2 5. Lead -in along the X axis.
G 0 G 1 7 G 4 0 G 8 0 Safe start lin e, absolute mode, XY plane
G 0 X 1.5 Y.2 5 Move to initial position
G 1 3 I 1.0 F 3 0.0 Cut circle
G 0 G 5 3 Z 0.0 Z axis to machine zero
M 3 0 Program end and rewind

Example: Cut the same circle but lead -in at 4 5°. (X=1*Cos(4 5°)=.7 0 7 1, Y=1*Sin(4 5°)=.7 0 7 1)
G 0 G 1 7 G 4 0 G 8 0 Safe start lin e, absolute mode, XY pla ne
G 0 X 1.5 Y.2 5 Move to initial position
G 1 3 I 0.7 0 7 1 J 0.7 0 7 1 F 3 0.0 Cut circle
G 0 G 5 3 Z 0.0 Z axis to machine zero
M 3 0 Program end and rewind


<!-- Page 26 -->

2 6

G 1 7/G 1 8/G 1 9 – Plane Selection: All motion and positions lie in planes defined by the machines axes. In
3-dimen sional space, three axes (X, Y and Z ) define three available planes XY, ZX, and YZ , see figure 1 7 -1.
The third axis defines the top of the plane, this axis is also known as the normal , see figure 1 7 -2.
Selection of a plane is done by specifying one of thre e G codes: G 1 7 for XY, G 1 8 for ZX and G 1 9 for YZ.
These are modal G codes and will stay active until another plane is selected or the system is reset . Arcs,
circles and advanced drill cycles require the selection of a plane to fully define the motion. When in
lathe mode, Mach 4 will default to G 1 8, ZX plane.
Figure 1 7 -1: Planes

Figure 1 7 -1: Planes
All arc and circular motion will take place on a single plane. Direction of motion, clockwise or
counterclockwise, is as viewed from the n ormal direction, see figure 1 7 -2.
Advanced drill cycles also require the selection of a plane. In this case all hole positions will be located in
the selected plane and the normal axis will be the drilling axis. For example in the XY plane the Z axis is
the drilling axis. The standard lathe drillin g cycles do not require plane selection and will always operate
in the ZX plane regardless of plane selection.


<!-- Page 27 -->

2 7

Figure 1 7 -2: Plane orientation
Axis 1 + Direction
Axis 2 + Direction Axis 3 + Direction
(Normal)
Look at plane
from normal
direction
Figure 1 7 -2: Plane normal direction

G 2 0/G 2 1 – Unit selection: Programming units are selected using G 2 0 for inch and G 2 1 for millimeter.
Use th ese G codes to specify the units in the program only; the setting will not affect Mach configuration
settings , or offsets .


<!-- Page 28 -->

2 8
```
G 2 8 – Zero Return: This function is used to send one or more axes to the home position via an
```
intermediate point. Exercise caution when using this function. If not fully understood the resulting
motion may differ greatly from what is expected. When used correctly the intermediate point can be
useful for avoiding obstacles in the way of a direct path to the home position, see figure 2 8-1.
Figure 2 8 -1: Zero return via intermediate point Work Piece G 0 G 2 8 U 0.0 W 0.0
or
G 0 G 5 3 X 0.0 Z 0.0 Tool G 0 G 2 8 U 0.0 W 1.0
or
G 0 G 2 8 X 0.0 Z 0.5 Machine Home Z
X
Fixture Zero Z
X
Start point
X 0.0, Z -0.5

Figure 2 8 -1: Zero return via intermediate point
Forma t: G 2 8 X__ Z__ C__
Format 2: G 2 8 U__ W__ H__

This is not a modal code and will only be active in the block in which it is specified. Follow ing the G 2 8 are
the axes to be sent home. For example, t o send the Z axis back to the home position program: G 2 8 Z 0.
The value specified with the axis letter specifies the intermediate point.
Look at an example program:
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start lin e
G 0 X 1 .0 Z 1.0 Rapid position to point
G 2 8 Z 0 .0 Send Z ax is home via point Z 0
M 3 0 Program end and rewind


<!-- Page 29 -->

2 9
Reading through the program there is a safe start up block then, t he next line commands the machine to
move to the point X 1, Z 1. in the coordinate system set by the G 5 4 fixture offset. Now for the G 2 8 bl ock.
This line of code, G 2 8 Z 0, gives instructions to send the Z axis to the home position via the point Z 0. The
motion will be as follows: First the Z axis will plunge to the point Z 0 then return to home. If not intended
this motion could result in a brok en tool or scrapped part. To avoid this unintended motion use
incremental moves of 0 as follows :
## G 2 8 W 0
In this case the intermediate point is an incremental move of 0 inches resulting in no motion before the
Z axis returns home.
G 2 8.1 – Home Axis: G 2 8.1 physically homes the specified axes. If more than one axis is specified, then
the axes are homed in order specified by the control configuration. The values of the parameters are
ignored except in the case of P. If P is specified, the corresponding out of band axis is homed. Valid
values for P are P 6 through P 1 1. P can only be specified once.
Format: G 2 8.1 X__ Y__ Z__ A__ B__ C__ P__
```
G 3 0 – 1 st, 2 nd, 3 rd, 4 th Zero Return: G 3 0 functions the same way as G 2 8 , moving the machine to a zero
return point via an in termediate point. However, instead of sending the machine to the home position,
G 3 0 movement ends at a user definable 1 st, 2 nd, 3 rd, or 4 th zero return point, specified by P 1, P 2, P 3, or
P 4 respectively. If P is omitted the 1 st zero return point is selecte d. This is handy for tool changers that
are not located at the home position, tool setters, or any number of other applications. Just as with G 2 8,
incremental commands of zero are recommended to avoid unintended motion.
Format: G 3 0 P__ X__ Z__ C__
Format 2 : G 3 0 P__ U__ W__ H__
The zero return point is defined by # variables as follows:
Axis P 1 # Variables P 2 # Variables P 3 # Variables P 4 # Variables
## X 5 1 8 1 5 3 5 1 5 3 6 1 5 3 7 1
## Y 5 1 8 2 5 3 5 2 5 3 6 2 5 3 7 2
## Z 5 1 8 3 5 3 5 3 5 3 6 3 5 3 7 3
## A 5 1 8 4 5 3 5 4 5 3 6 4 5 3 7 4
## B 5 1 8 5 5 3 5 5 5 3 6 5 5 3 7 5
## C 5 1 8 6 5 3 5 6 5 3 6 6 5 3 7 6
The position values in the # variables can be set in a program, MDI mode or in the Regfile diagnostics
window .


<!-- Page 30 -->

3 0
```
G 3 1/ G 3 1.X – Probe function: Also known as skip function, G 3 1 allows the use of part and tool probes.
Multiple pro bes can be used, G 3 1 .0 (or G 3 1) for probe 0, G 3 1.1 probe 1, G 3 1.2 probe 2 and G 3 1.3 probe
3. Motion is defined along linear axes , in a similar format to G 0 1, with a feedrate.
Format: G 3 1 X__ Z__ F__
The machine will move toward the specified end point, at the same time it is looking for the probe input
to be activated. When the probe input is activated the current position is recorded to # variables
according to the table below an d motion is stopped . The recorded position can then be used to calculate
tool offsets, work offsets, measure parts, etc.
Axis Absolute Position
# Variables Machine Position
# Variables
## X 5 0 6 1 5 0 7 1
## Y 5 0 6 2 5 0 7 2
## Z 5 0 6 3 5 0 7 3
## A 5 0 6 4 5 0 7 4
## B 5 0 6 5 5 0 7 5
## C 5 0 6 6 5 0 7 6


<!-- Page 31 -->

3 1
G 3 2 – Threading: Equal lead straight, tapered and scroll t hreads ca n be cutting using the thread cutting
command. Spindle speed feedback from an encoder, index pulse, tachometer or other device is required
for this operation. The syncing of the feed axis to the spindle speed creates an accurate thread;
however, axis accel eration can cause variations in the thread lead especially at the start and end of the
thread. To avoid these errors, program a slightly longer thread to give the axis time to accelerate. The
amount of extra thread length will vary based on machine specifi cations.
Changes in spindle speed and feedrate will impact thread quality and accuracy. Using constant surface
speed mode can also result in variations in thread lead when cutting tapered or scroll threads, use G 9 7
constant RPM mode instead. During the thr eading move the spindle speed and feedrate overrides will
be disabled and the machine will run at 1 0 0%. Feed hold will be delayed, if pressed the machine will
stop at the end of the threading move.
Format: G 3 2 X__ Z__ F__
Straight thread Tapered thread Scroll thread
Figure 3 2 -1: Basic thread types

Figure 3 2 -1: Basic thread types
The G 3 2 threading cycle is a single linear move synced to the spindle speed. F specifies the lead or pitch
of the thread when in the feed per revolution (G 9 9) mode . For example a 2 0 TPI thread would have a
pitch of .0 5 inches, so program F.0 5. By default t he movement is basic linear move with synced feedrate.
By default the lead is assumed to be along the major axis of the current plane selection; for G 1 7 XY
plane lead is along the X axis, G 1 8 ZX plane is along the Z axis, G 1 9 is along the Y axis.


<!-- Page 32 -->

3 2
Example : Thread a ¼ -2 0 rod held in the spindle, 1” length of thread.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 0 X 1.0 Z 0.1 Rapid position
G 9 7 S 1 0 0 0 M 3 Start spindle at 1 0 0 0 RPM
G 0 X 0. 2 2 Move to start position for rough
G 3 2 X 0.2 2 Z-1.0 F.0 5 Cut straight thread
G 0 X 0.3 Retract X axis
Z 0.1 Retract Z axis
X 0.2 1 Move to start position for finish
G 3 2 X 0.2 1 Z -1.0 F.0 5 Cut straight thread
G 0 X 0.3 Retract X axis
Z 0.1 Retract Z axis
G 5 3 X 0.0 Z 0.0 M 5 Return home and stop spindle
M 3 0 Program end and rewind

Threads can also be cut with a taper by adding the proper end point.
Example: Cut same thread as previous example with 0.0 3 taper.
G 0 G 9 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 0 X 1.0 Z 0.1 Rapid position
G 9 7 S 1 0 0 0 M 3 Start spindle at 1 0 0 0 RPM
G 0 X 0.2 2 Move to start posi tion for rough
G 3 2 X 0.2 5 Z -1.0 F.0 5 Cut tapered thread
G 0 X 0.3 Retract X axis
Z 0.1 Retract Z axis
X 0.2 1 Move to start position for finish
G 3 2 X 0.2 4 Z -1.0 F.0 5 Cut tapered thread
G 0 X 0.3 Retract X axis
Z 0.1 Retract Z axis
G 5 3X 0.0 Z 0.0 M 5 Return home and stop spindle
M 3 0 Program end and rewind


<!-- Page 33 -->

3 3
G 3 4 – Variable Lead Threading: Threads with a variable lead, or pitch, can be cut by specifying the start
lead and the change in lead per revolution of the screw.
Format: X__ Z__ F__ K__
```
G 3 2 threading and G 3 4 variable lead threading are programmed and function the same way with the
exception of address K. K specifies the change in thread lead per revolution. All requirements are the
same, and not all machines will have this capability.
Figure 3 4 -1: Variable lead thread

Figure 3 4 -1: Variabl e lead thread
Example: Thread a ¼ rod held in the spindle, 1” length of thread. Start with 0.1 lead with a decrease in
lead of 0.0 2 per revolution.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 0 X 1.0 Z 0.1 Rapid position
G 9 7 S 1 0 0 0 M 3 Start spindle at 1 0 0 0 RPM
G 0 X 0.2 2 Move to start position for rough
G 3 2 X 0.2 2 Z -1.0 F 0.1 K -0.0 2 Cut variable lead thread
G 0 X 0.3 Retract X axis
Z 0.1 Retract Z axis
X 0.2 1 Move to start position for finish
G 3 2 X 0.2 1 Z -1.0 F 0.1 K -0.0 2 Cut variable lead thread
G 0 X 0.3 Retract X axis
Z 0.1 Retract Z axis
G 5 3 X 0.0 Z 0.0 M 5 Return home and stop spindle
M 3 0 Program end and rewind


<!-- Page 34 -->

3 4
G 3 5/G 3 6 – Circular Threading: Circular threading allows cutting threads along the profile of an arc.
These can be useful for a number of applications, incl uding by not limited to worm gears and screws , see
figure 3 5 -1. The thread follows an arc, defined in the same way as an arc is programmed with G 0 2/G 0 3.
The thread lead is along the major axis of the current plane selection; in the G 1 7 XY plane the X axis is
the major axis, G 1 8 ZX plane the Z axis is the major axis, and G 1 9 YZ plane the Y is the major axis. The
orientation of the major axis also limits the range of the specified arc. Figure 3 5 -2 shows the allowable
range shaded in gray.
Figure 3 5 -1: Circular thread examples

Figure 3 5 -1: Circu lar thread examples
Figure 3 5 -2: Circular thread arc allowable range
Plane Major Axis
•G 1 7 = X
•G 1 8 = Z
•G 1 9 = YPlane Secondary Axis
•G 1 7 = Y
•G 1 8 = X
•G 1 9 = Z
4 5°

Figure 3 5 -2: Circular thread allowable ranges


<!-- Page 35 -->

3 5
The progra mming format contains the same addresses as G 0 2/G 0 3 and G 3 2 ; they perform the same
```
function as well .
Format 1: (G 1 7) G 3 5/3 6 X__ Y__ I__ J__ F__ Q__
(G 1 8) G 3 5/3 6 X__ Z__ I__ K__ F__ Q__
(G 1 9) G 3 5/3 6 Y__ Z__ J__ K__ F__ Q__
Format 2: (G 1 7) G 3 5/3 6 X__ Y__ R__ F__ Q__
(G 1 8) G 3 5/3 6 X__ Z__ R__ F__ Q__
(G 1 9) G 3 5/3 6 Y__ Z__ R__ F__ Q__
Example: Thread a ¼ rod held in the spindle, 1” length of thread. Start with 0.1 lead wit h a decrease in
lead of 0.0 2 per revolution.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 0 X 1.0 Z 0.1 Rapid position
G 9 7 S 1 0 0 0 M 3 Start spindle at 1 0 0 0 RPM
G 0 X 0.2 2 Move to start position for rough
G 3 2 X 0.2 2 Z -1.0 F 0.1 K -0.0 2 Cut variable lead thread
G 0 X 0.3 Retract X axis
Z 0.1 Retract Z axis
X 0.2 1 Move to start position for finish
G 3 2 X 0.2 1 Z -1.0 F 0.1 K -0.0 2 Cut variable lead thread
G 0 X 0.3 Retract X axis
Z 0.1 Retract Z axis
G 5 3 X 0.0 Z 0.0 M 5 Return home and stop spindle
M 3 0 Program end and rewind

G 4 0 – Tool Nose Radius Compensation Cancel: Cancels the tool nose radius compensation mode.
G 4 1/G 4 2 – Tool Nose Radius Compensation Left/Right: Enables tool nose radius compensation to the
left (G 4 1) or right (G 4 2) of the cutter path by an amount spec ified by the tool nose radius and tip
direction .
Format: G 1 G 4 2 X__ Z__ F__
For detailed information see the tool nose radius compensation section of this manual.


<!-- Page 36 -->

3 6
G 5 0 – Minimum and Maximum Spindle Speed: In the G 9 6 constant surface sp eed (CSS) mode the
spindle RPM will vary based on current X position. The spindle speed will increase as the diameter gets
smaller and decrease as the diameter gets bigger. Machining in this mode can produce superior finishes
and accuracy. However, some se t ups can only handle a certain RPM range. Castings, or similar near net
shape stock, are a prime example of this. An unbalanced part can create harsh vibration when spun too
fast. In cases like these the maximum RPM can be limited using G 5 0 while still be ing able to take
advantage of the benefits of CSS mode. However, in CSS mode excessive decelerations can occur when
positioning the tool or moving away from the part for tool changes. In these cases the minimum speed
can be very useful.
Format: G 5 0 S__ Q__
In this format S specifies the maximum spindle speed and Q specifies the minimum speed.
G 5 0 – Local Coordinate System Setting: The coordinate system can be set by issuing G 5 0 in the
program. This is equivalent to G 9 2 in the mill interpreter. This functio n differs from G 5 2 (Local
Coordinate System Shift) in the way that it is specified. While G 5 2 is specified with shift values, G 5 0 is
specified with the desired axis position. The affect is global and should be used with caution.
Format: G 5 0 X__ Y__ Z__ A_ _ B__ C__
Using the above format specify a value for the desired axis. When G 5 0 is specified the position DRO’s
are updated to the values specified. The local coordinate system setting will be cancelled when a G 9 2.1
is specified or the system is reset.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 0 X 4.0 Y 0.0 Z 1.0 Rapid move, current position X 4, Y 0, Z 1
G 5 0 X 1.0 Y 2.0 Z 3.0 Set local coordinate system, current position X 1,
Y 2, Z 3
G 9 2.1 Cancel local coordinate system, current position
X 4, Y 0, Z 1
M 3 0 Program end and rewind


<!-- Page 37 -->

3 7
G 5 0.1 – Scaling Cancel: Cancels scaling .
```
G 5 1.1 – Scaling/Mirroring Function: When activated the scaling function multiplies all commanded
positions by the specified scale factor. The DROs and offsets are not affected, but motion commanded
from a program or the MDI screen is affected.
Format: G 5 1 X__ Z__ C__
Specify the axis to be scaled and the desired scale factor. For example:
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 0 X 4. 0 Y 0.0 Z 1.0 Rapid position to point (X position is 4.)
G 5 1 X 2. 0 Activate sca ling on X axis (scale factor = 2)
G 0 X 5. 0 Rapid position to point (X position is 1 0.)
G 5 0 Cancel Scaling
G 0 X 5. 0 Rapid position to point (X position is 5.)
M 3 0 Program end and rewind

When scaling is active position moves will be calculated by multipl ying the commanded position by the
scale factor. In the example above the scale factor on the X axis is set to 2, then a move to X 5. 0 is
commanded. The actual end position of this move will be 5 * 2 = 1 0. So the X axis moves to 1 0.
Exercise caution when us ing scaling, the results can be unpredictable depending on program complexity.
For example if G 5 2 X 2 Y 4 is programmed followed by an arc move in the XY plane, the arc will NOT be
scaled 2 x in the X axis and 4 x in the Y axis to obtain an ellipse. The start and end positions will be as
expected, but the motion from one to the other may not be. Check and double check the tool path
display before running the program.
To mirror a program, enter a negative scale value. For example:
G 0 G 9 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe sta rt line
G 0 X 4. 0 Y 0.0 Z 1.0 Rapid position to point (X position is 4.)
G 5 1 X -1.0 Mirror X axis (scale factor = 1)
G 0 X 5. 0 Rapid position to point (X position is -5.)
G 5 0 Cancel Scaling
G 0 X 5. 0 Rapid position to point (X position is 5.)
M 3 0 Program end and rewind


<!-- Page 38 -->

3 8
G 5 2 – Local Coordinate System Shift : The local coordinate system setting is a programmable work shift .
The setting is global; the entire system is shifted by the specified values. Every fixture offset will be
affected, although the actual fi xture offset values will not be changed.
Format: G 5 2 X__ Z__ C__
To activate a local coordinate system with G 5 2 use the above format. Setting of a local coordinate
system is just like setting a fixture offset. In the G 5 2 block specify the desired axes to set, and the value
of the shift . For example (see figure 5 2 -1 for the tool path) :
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 0 X -4.0 Y 0.0 Z 1.0 Rapid position to point
G 1 2 I 2.0 F 3 0.0 Cut circle with radius 2.0
G 5 2 X 7. 0 Local Coordinate system active, X offset = 7
G 0 X -4.0 Y 0.0 Z 1.0 Rapid to same start point
G 1 2 I 2.0 F 3 0.0 Cut same circle with radius 2.0
G 5 2 X 0. 0 Local coordinate system cancelled
M 3 0 Program end and rewind

Figure 5 2 -1: Example program tool path.

Figure 5 2 -1: Coordinate system shift example program path
Once set, the setting wil l remain until cancelled by another G 5 2 or the system is reset. As in the example
above, a local coordinate system can be cancelled by specifying the axis with a value of zero. This
effectively sets th e local coordinate system shift to zero, giving it no e ffect.


<!-- Page 39 -->

3 9
G 5 3 – Machine Coordinate System: Although the majority of machine positioning will take place in a
user created coordinate system it is sometimes beneficial to program positions in the machine
coordinate system. G 5 3 is a non -modal, only active for the block in which it is specified, G code that
allows the user to make positioning moves in the machine coordinate system. This can be useful for
moving to a load/unload position at the end of a program or moving to a tool change location in a tool
chang e macro. This is also a much safer way to move back to the machine home position, G 5 3 X 0 Y 0 Z 0,
than using G 2 8 as there is no intermediate position to be concerned with.
Format: G 5 3 X__ Z__ C__
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 0 X 4. 0 Y 0.0 Z 1.0 Rapid po sition in G 5 4
… Body of program
G 5 3 Z 0. 0 Return directly to Z home position
G 5 3 X 1 0. 0 Y 0.0 Move to load/unload position
M 3 0 Program end and rewind

In the example above, the last two positioning moves are made in the machine coordinate system.
These t wo blocks could be the same for every program in this machine.
G 5 4-G 5 9 – Fixture Offset : Fixture offsets are used to define the position of a work piece in the machine.
In a basic 2 axis lathe the fixture offset will most commonly be used to define the pos ition of the end of
the work piece in the Z axis, see figure 5 4 -1. The figure shows only one way of using the fixture offset,
there are almost as many methods of fixture and tool offset setting as there are machinist/operators.
Use a method that works the best for you and your machine. The G codes G 5 4 -5 9 are u sed to select the
active fixture offset in a program. It is a modal call so t he fixture offset will stay active until another is
called or the system is reset. It is possible to use multiple fixture of fsets in a single program.
Figure 5 4 -1: Fixture offset in machine coordinate system.X
ZMachine
Coordinate
System: X 0, Z 0 Z work offset

Figure 5 4 -1: Fixture offset


<!-- Page 40 -->

4 0
G 5 4.1 – Additional Fixture Offsets: Additional fixture offsets are provided for users with many
fixtures/parts/ setups. There are 2 4 8 additional offsets available.
Format: G 5 4.1 P__
P specifies the nu mber of the additional offset, 1 thru 2 4 8.
Previous version of Mach use G 5 9 P 7, P 8 and so on. These legacy offsets can still be used in place of the
G 5 4.1. G 5 9 P 7 = G 5 4.1 P 1, G 5 9 P 8 = G 5 4.1 P 2, and so on. G 5 4.1 is more consistent with industry
machines.
G 6 0 – Unidirectional Approach: In cases where mechanical backlash causes positioning errors
unidirectional approach can be used to increase accuracy. G 6 0 is a non -modal code, when specified in a
movement block motion will move to the end point from a paramet er defined distance and direction.
The distance and direction of the approach movement is specified by setting values in # variables as
shown in the following table:
Axis # Variable
## X 5 4 4 0
## Y 5 4 4 1
## Z 5 4 4 2
## A 5 4 4 3
## B 5 4 4 4
## C 5 4 4 5

Format: G 6 0 G 0/G 1 X__ Z__
When unidirectional approach is used in a drill cycle the Z axis motion is not affected. G 7 6.1 and G 8 7 .1
boring cycles have a tool shift that is also not affected by t he G 6 0 unidirectional approach.
G 6 1 – Exact Stop Mode: In exact stop mode the machine w ill decelerate to a complete stop at the end
of each commanded move , see figure 9 -1. This is a modal code, once activated it will remain on until
canceled. For sharp corners and simple positioning this mode works well. However, when the code gets
more comp lex the exact stop mode will produce jerky motion and witness marks on the work piece. For
most turning jobs use G 6 4.
G 6 4 – Constant Velocity Mode: In constant velocity mode Mach will try to maintain feedrate even
around sharp corners. As a result sharp co rners will be slightly rounded and the machine may never
reach the programmed point before a direction change. The magnitude of these position errors will be
determined by the acceleration capability of the machine and the programmed feedrate. In most case s
```
the error will be too small to notice or affect part function. Cutting will be faster and smoother with
better finishes and no witness marks from stopping. This will be the active mode for the majority of
machining time. It is modal and will be active un til exact stop mode is activated.


<!-- Page 41 -->

4 1
G 6 5 – Macro Call : Macros work like subprograms (see M 9 8 on page 8 2) but allow values to be passed
from the main program in the form of local variables. Macro programs can use these local variables
passe d to it to change part dimensions, select features, adjust feedrates, or anything else the user could
need to change.
Format: G 6 5 P____ A__ B__ C__ …
The desired program number to be called is specified by P. The remaining arguments are determined by
the macro program being called. The values of these arguments will be passed to local variables for use
in the macro program. The available arguments and corresponding variables are shown in the table
below :
Address Variable Address Variable Address Variable
A #1 I #4 T #2 0
B #2 J #5 U #2 1
C #3 K #6 V #2 2
D #7 M #1 3 W #2 3
E #8 Q #1 7 X #2 4
F #9 R #1 8 Y #2 5
H #1 1 S #1 9 Z #2 6

The G 6 5 macro call is non -modal and has no option for repeating, the macro subprogram will be run
only once per G 6 5 call. For more information on macro programming and the availability and use of #
variables see the Mach 4 Macro Programming Guide.
G 6 6 – Macro Modal Call: Sometimes it is useful to run the same macro in different positions (similar to
drilling canned cycles) or with diff erent parameters. G 6 6 is a modal macro call, the macro is called and
values passed in the same way as G 6 5. Execution of the macro does not occur in the same block as the
G 6 6. Macro execution occurs at every position move following G 6 6, prior to the G 6 7.
Format: G 6 6 P____ A__ B__ C__ …
## G 0 0 X__ Z__ C__
## G 6 7
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 0 X 4.0 Z 1.0 Rapid position in G 5 4
G 6 6 P 9 1 0 0 A 4.0 B 5.0 R 1.0 Modal macro call (macro program not executed)
G 0 X 3.0 Z 0.0 Macro 9 1 0 0 executed at X 3.0 Z 0.0
G 0 X 1.0 Z -2.0 Macro 9 1 0 0 executed at X 1.0 Z -2.0
G 6 7 Modal macro call cancel
G 5 3 Z 0.0 Return directly to Z home position
G 5 3 X 1 0.0 Move to load/unload position
M 3 0 Program end and rewind

More information on macro programming is available in the Mach 4 Macro Pro gramming Guide.


<!-- Page 42 -->

4 2
G 6 7 – Macro Modal Call Cancel: Cancels the macro modal call.
G 7 6 – Multiple Thread Cutting Cycle (two block type) : The multiple thread cutting cycle simplifies the
cutting of threads. This cycle is specified in two blocks and will rough and finish threads with or without
lead outs and with different infeed options. By comparison, using G 3 2 would require at least 3 blocks of
code per pass.
Format: G 7 6 P_ _ _ _ _ _ Q__ R__ K__
## G 7 6 X__ Z__ R__ P__ Q__ F__
First line:
 P: 6 digit number specify ing the number of finish passes, length of lead out, and the angle of the
threading tool. Each parameter is two digits. The number of finish passes can be specified from
0 1 to 9 9. The lead out is specified in the number of leads from 0.0 to 9.9 (0 0 to 9 9). Then the
tool angle. For example: P 0 5 3 0 6 0 = 0 5 finish passes, 3.0 leads to lead out, and a 6 0 degree tool.
 Q: Specifies the minimum cutting depth. If the calculated depth of cut becomes less than this
value, then the specified minimum is used.
 R: Finish a llowance.
 K: Infeed type. There are 4 possible infeed selections, 1 to 4. The 4 options are combinations of
two infeed types and two depth of cut types. The two infeed types are flank and alternat e flank ,
see figure 7 6 -1. In the flank infeed mode each dept h of cut moves down at the angle for the
thread, following the trailing flank of the tool. Alternat e flank changes from leading to trailing
flank for each pass. The two depth of cut types are constant volume and constant depth. In
constant volume the depth of cut will get smaller (down to the minimum specified by Q) for
each pass to maintain a constant volume of material being removed. This is usually better for
tool life and thread quality. Constant depth is just that. Each depth of cut is the same down to
the finish allowance.
o 1 constant volume flank infeed
o 2 constant volume alternat e flank infeed
o 3 constant depth flank infeed
o 4 constant depth alternat e flank infeed.

See Figure 7 6 -1 for a diagram of the infeed types.


<!-- Page 43 -->

4 3

Figure 7 6-1: Infeed types.
1: Constant volume flank infeed 2: Constant volume alternate flank infeed
3: Constant depth flank infeed 4: Constant depth alternate flank infeed 1 stpass
2 ndpass
3 rdpass
nthpass
finish pass
1 stpass
2 ndpass
3 rdpass
nthpass
finish pass 1 stpass
2 ndpass
3 rdpass
nthpass
finish pass
finish passnthpass 3 rdpass 2 ndpass 1 stpassnthpass
Figure 7 6 -1: Threading infeed types
Second line:
 X, Z: Coordinates of the end point of the thread. Can also be specified as U and W for
incremental distance and direction from the curr ent position.
 R: Taper amount in the X axis, specified in radius. If omitted or 0 is specified a straight thread
will be cut.
 P: Height of the thread in radius.
 Q: 1 st depth of cut in radius.
F: Lead of thread

Threading arguments Figure 7 6 -2: G 7 6
Figure 7 6-2: G 7 6 Arguments.


<!-- Page 44 -->

4 4
Exampl e: Cut a 1/2 -2 0 straight thread 1 inch long , starting at Z 0 with a 2 lead lead -out.
Setup:
 Finish passes, we’ll do 2
 Leadout, 2.0 from the description
 Angle, 6 0 degrees is the most common
 Minimum depth of cut, we’ll say 0.0 0 7 inch
 Finish allowance 0.0 0 5
 Alternate flank infeed at constant volume
So that gives us our first line of the G 7 6 call: G 7 6 P 0 2 2 0 6 0 Q 0.0 0 7 R 0.0 0 5 K 1
 X finish diameter is 0.4 3 3
 Z finish position is -1.0
 We want a straight thread so omit R
 P is the height of the thread, 0.0 4 3
 First depth of cut will be 0.0 2
 Lead at 2 0 thread per inch is 0.0 5
Second line will be G 7 6 X 0.4 3 3 Z -1.0 P 0.0 4 3 Q 0.0 2 F 0.0 5
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 0 X 1.0 Z 0.1 Rapid position in G 5 4
G 7 6 P 0 2 2 0 6 0 Q 0.0 0 7 R 0.0 0 5 K 1 First line of threading cycle
G 7 6 X 0.4 3 3 Z -1.0 P 0.0 4 3 Q 0.0 2 F 0.0 5 Second line of threading cycle, cut threads
G 5 3 Z 0.0 Return directly to Z home position
G 5 3 X 1 0.0 Move to load/unload position
M 3 0 Program end and rewind

To get thread dimensions, standard major/minor diameters, thread height, e tc., consult the Machinery’s
Handbook or similar.
Some precautions:
### 1. When threading the feed override is not effective. Threading moves will always take place at
1 0 0% feed.
### 2. Feed hold will NOT pause execution during a threading move. Motion will be stopped after the
tool retracts from the current cut.
### 3. Leave room for the machine to accelerate before starting into the cut or variations in thread
pitch could occur.
4. It is not suggested to use CSS mode during threading, use constant RPM (G 9 7).


<!-- Page 45 -->

4 5
G 7 6 – Multiple Thre ad Cutting Cycle (one block type): The multiple thread cutting cycle simplifies the
cutting of threads. This cycle is specified in two blocks and will rough and finish threads with or without
lead outs and with different infeed options. By comparison, usin g G 3 2 would require at least 3 blocks of
code per pass.
Format: G 7 6 X__ Z__ I__ K__ D__ A__ P__ F__

 X, Z: Coordinates of the end point of the thread. Can also be specified as U and W for
incremental distance and direction from the current position.
 I: Tap er amount in the X axis, specified in radius. If omitted or 0 is specified a straight thread will
be cut.
 K: Height of the thread in radius.
 D: 1 st depth of cut in radius.
 A: The tool angle.
 P: Infeed type. There are 4 possible infeed selections, 1 to 4. T he 4 options are combinations of
two infeed types and two depth of cut types. The two infeed types are flank and alternate flank,
see figure 7 6 -1. In the flank infeed mode each depth of cut moves down at the angle for the
thread, following the trailing fla nk of the tool. Alternate flank changes from leading to trailing
flank for each pass. The two depth of cut types are constant volume and constant depth. In
constant volume the depth of cut will get smaller (down to the minimum specified by Q) for
each pass to maintain a constant volume of material being removed. This is usually better for
tool life and thread quality. Constant depth is just that. Each depth of cut is the same down to
the finish allowance.
o 1 constant volume flank infeed
o 2 constant volume alt ernate flank infeed
o 3 constant depth flank infeed
o 4 constant depth alternate flank infeed.
See Figure 7 6 -1 for a diagram of the infeed types.


<!-- Page 46 -->

4 6

Figure 7 6-1: Infeed types.
1: Constant volume flank infeed 2: Constant volume alternate flank infeed
3: Constant depth flank infeed 4: Constant depth alternate flank infeed 1 stpass
2 ndpass
3 rdpass
nthpass
finish pass
1 stpass
2 ndpass
3 rdpass
nthpass
finish pass 1 stpass
2 ndpass
3 rdpass
nthpass
finish pass
finish passnthpass 3 rdpass 2 ndpass 1 stpassnthpass
Figure 7 6 -1: Threading infeed types
 F: Lead of thread
The leadout (thread finishing) is controlled by M 2 3 to turn on leadout and M 2 4 to turn off leadout. The
leadout is specified in the number of leads from 0.0 to 9.9 (0 0 to 9 9 integer value ) in parameter 5 1 4 4.
Example: Cut a 1/2 -2 0 straight thread 1 inch long, starting at Z 0 with a 2 lead lead -out.
Setup:
 Z finish position is -1.0
 X finish diameter is 0.4 3 3
 Leadout, 2.0 from the description
 A 6 0 degree tool angle, the most common
 Alternate flank infeed at co nstant volume
 We want a straight thread so omit I or specify I 0
 The height of the thread is 0.0 4 3
 First depth of cut will be 0.0 2
 Lead at 2 0 thread per inch is 0.0 5
So that gives us our line of the G 7 6 call: G 7 6 X 0.4 3 3 Z -1.0 A 6 0 I 0 K 0.0 4 3 D 0.0 2 P 2 F 0.0 5
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
M 2 3 Turn on lead out
#5 1 4 4=2 0 Lead out over two thread leads


<!-- Page 47 -->

4 7
G 0 X 1.0 Z 0.1 Rapid position in G 5 4
G 7 6 X 0.4 3 3 Z -1.0 A 6 0 I 0 K 0.0 4 3 D 0.0 2 P 2 F 0.0 5 Threading cycle
M 2 4 Turn off lead out
G 5 3 Z 0.0 Return directly to Z home po sition
G 5 3 X 1 0.0 Move to load/unload position
M 3 0 Program end and rewind

To get thread dimensions, standard major/minor diameters, thread height, etc., consult the Machinery’s
Handbook or similar.
Some precautions:
### 1. When threading the feed override is not effective. Threading moves will always take place at
1 0 0% feed.
### 2. Feed hold will NOT pause execution during a threading move. Motion will be stopped after the
tool retracts from the current cut.
### 3. Leave room for the machine to accelerate before starting in to the cut or variations in thread
pitch could occur.
4. It is not suggested to use CSS mode during threading, use constant RPM (G 9 7).
G 8 0-G 8 9 – Hole Machining Canned Cycles: Canned cycles are special G codes used to simplify
programming. See the Hole Machining Canned Cycles section of this manual for detailed information.
Standard Hole Machining Cycles
G 8 0 Canned Cycle Cancel G 8 0
G 8 1 Drilling G 8 1 X_ Y_ Z_ R_ F_
G 8 2 Spot Face G 8 2 X_ Y_ Z_ R_ P_ F_
G 8 3 Deep Hole Peck Drilli ng G 8 3 X_ Y_ Z_ R_ Q_ F_
G 8 4 Tapping G 8 4 X_ Y_ Z_ R_ F_
G 8 5 Boring , Retract at Feed, Spindle On G 8 5 X_ Y_ Z_ R_ F_
G 8 6 Boring , Ret ract at Rapid, Spindle Off G 8 6 X_ Y_ Z_ R_ F_
G 8 7 Back Boring G 8 7 X_ Y_ Z_ R_ I_ J_ F_
G 8 8 Boring , Manual Retract G 8 8 X_ Y_ Z_ R_ P_ F_
G 8 9 Boring , Dwell, R etract at Feed, Spindle On G 8 9 X_ Y_ Z_ R_ P_ F_


<!-- Page 48 -->

4 8
G 7 3.1 -G 8 9.1 – Advanced Hole Machining Canned Cycles: These canned cycles provide additional
```
functionality over the standard lathe cycles. See the Advanced Hole Machining Canned Cycles section of
this manual for detailed information.
Advanced Hole Machining Cycles
G 7 3.1 High Speed Peck G 7 3.1 X_ Y_ Z_ R_ Q_ F_
G 7 4.1 Reverse Tapping G 7 4.1 X_ Y_ Z_ R_ F_
G 7 6.1 Fine Boring G 7 6.1 X_ Y _ Z_ R_ I_ J_ P_ F_
G 8 1.1 Drilling G 8 1 X_ Y_ Z_ R_ F_
G 8 2.1 Spot Face G 8 2 X_ Y_ Z_ R_ P_ F_
G 8 3.1 Deep Hole Peck Drilling G 8 3.1 X_ Y_ Z_ R_ Q_ F_
G 8 4.1 Tapping G 8 4.1 X_ Y_ Z_ R_ F_
G 8 4.2 Right Hand Rigid Tapping G 8 4.2 X_ Y_ Z_ R_ P_ F_ J_
G 8 4.3 Left Hand Rigid Tapping G 8 4.3 X_ Y_ Z_ R_ P_ F_ J_
G 8 5.1 Boring, Retract at Feed, Spindle On G 8 5.1 X_ Y_ Z_ R_ F_
G 8 6.1 Boring, Retract at Rapid, Spindle Off G 8 6 X_ Y_ Z_ R_ F_
G 8 7.1 Back Boring G 8 7.1 X_ Y_ Z_ R_ I_ J_ F_
G 8 8.1 Boring, Manual Retract G 8 8.1 X_ Y_ Z_ R_ P_ F_
G 8 9.1 Boring, Dwell, Retract at Feed, Spindle On G 8 9.1 X_ Y_ Z_ R_ P_ F_

G 9 0.1/G 9 1.1 – Absolute/Incremental Arc Center Mode: This setting affects arcs when programmed in
the I, J, K format. In absolute arc center mode the I, J, K value s designate the position of the arc center in
the user coordinate system. In incremental arc center mode the I, J, K values designate the distance and
direction to the arc center fro m the start point. See figure 2-1 for a graphical description.
K (Abs)
I (Abs)K (Inc)
I (Inc)
RStart
Point
Work
Zero X
Z

Figure 2 -1: Arc center types


<!-- Page 49 -->

4 9
Example: Program an arc centered at 1 .0, 1.0 in the ZX plane with radius 2. Start point at 1.0,3.0 and
sweep 9 0 degrees counter clockwise. Program two times, once in incremental arc center mode and once
in absolute arc center mode.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 9 1.1 Incremental arc center mode
T 0 1 0 1 Tool change
G 0 X 1.0 Z 3.0 Position to X and Z start point
G 3 X 5.0 Z 1.0 I 0.0 K-2.0 F 1 0. 0 Arc move
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind

G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 9 0.1 Absolute arc center mode
T 0 1 0 1 Tool change
G 0 X 1.0 Z 3.0 Position to X and Z start point
G 3 X 5.0 Z 1.0 I 1.0 K 1.0 F 1 0. 0 Arc move
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind

Notice the difference in the I values of t he example programs. Both programs will produce the same arc.
G 9 2 – Simple Threading Cycle : G 9 2 is used for simple threading, however, multiple passes for threading
are possible by specifying the X locations of additional passes on following blocks . Strai ght threads are
made by specifying X, Z, and F. By adding a R value, a pipe or taper thread is cut. The amount of taper is
referenced from the target. That is, R is added to the value of X at the target. The thread leadout can be
controlled with either M 2 3 (leadout on ) or M 2 4 ( leadout off ) issued before the G 9 2. If M 2 3 is used, t he
leadout chamfer is controlled by parameter 5 1 3 0 (G 9 2 CHAMFER PITCH).

Parameter 5 1 3 0: An integer specifying .1 pitch increments. The default is 1 0, which is 1.0 pitch.
Format: G 5 0 X__ Z__ R__ F__
G 0 0 G 1 8 G 2 0 G 4 0 G 8 0 G 9 9 Safe start line
G 5 0 S 1 0 0 0 Limit spindle to 1 0 0 0 RPM
G 9 7 S 5 0 0 M 0 3 CSS off, spindle CW
G 0 0 G 5 4 X 0 Z 0.2 5 Rapid to 1 st position
M 0 8 Coolant on
M 2 3 Two axis chamfer exit
X 1.2 Z.2 Rapid to clear position
G 9 2 X .9 8 0 Z -1.0 F 0.0 8 3 3 Begin threading cycle
X.9 6 5 2 nd pass
X.9 5 5 3 rd pass
X.9 4 5 4 th pass
X.9 3 5 5 th pass
X.9 2 5 6 th pass


<!-- Page 50 -->

5 0
X.9 1 7 7 th pass
X.9 1 0 8 th pass
X.9 0 5 9 th pass
X.9 0 1 1 0 th pass
X.8 9 9 1 1 th pass
G 0 0 G 5 3 X 0 M 0 9 X home, coolant off
G 5 3 Z 0 M 0 5 Z hom e, spindle off
M 3 0 Program end and rewind

G 9 3 – Inverse Time Feed: Inverse time feed is most commonly used for machine movement containing
at least one rotary axis, however that is not the only application. Instead of specifying a velocity a time
to co mplete the movement is specified. The following formula is used to determine F:

When inverse time feed is active a n F word is required in every block of code c ontaining a feed move.
G 9 6 – Constant Surface Speed: Spindle speed can be specified two ways. One is constant surface speed.
In this mode the surface speed will be kept constant by varying the spindle RPM based on the current
cutting diameter . Maintaining a constant surface speed results in in superior surface finishes and more
consistent parts. Surface speed is specified in surface units per minute. In the inch mode this is surface
feet per minute, in millimeter mode it is surface meters per minute.
G 9 7 – Constant RPM: In this mode the spindle speed is specified in revolutions per minute . Spindle RPM
is maintained regardless of current cutting diameter.
G 9 8 – Feed per Minute : Sets the machine to feed per minute mode. Specify the desired feedrate in
units/mi nute, in the imperial system this is inches per minute, in the metric system this is millimeters
per minute. In this mode the feedrate is modal and not required in all feed move blocks.
G 9 8.1 – Initial Point Return: Specifies that a n advanced drilling canned cycle end at the initial Z level.
The machine will also return to the initial point before a rapid move to the next position. Initial point
return is useful for avoiding steps in parts or fixture clamps without adding a significant amount of cycle
time . See figure 9 8 1 -1.


<!-- Page 51 -->

5 1

Move at feedrate (F)
Move at rapid
Figure 9 8 1 -1: Initial and R point return setting.G 9 8.1
G 9 9.1 Initial Point
Retract Plane (R)
Figure 9 8 1 -1: Initial and Retract point return for advanced drilling cycles


<!-- Page 52 -->

5 2
G 9 9 – Feed per Revolution : In this mode the feed rate is specified in units/revolution ; for every
revolution of the spindle the machine will move the specif ied units. By specifying the feedrate in this
way if the spindle speed varies the chip load of the tool is kept constant. This can provide and increase in
surface finishes and tool life. Feed per rev mode requires RPM feedback from the spindle.
G 9 9.1 – R Point Return: Specifies that a n advanced drilling canned cycle end at the programmed R level,
see figure 9 8 1 -1. When drilling holes in a flat pla ne, G 9 9 .1 can be used to reduce excessive machine
movement decreasing cycle time.


<!-- Page 53 -->

5 3
Chapter 4 : Hole Machining Ca nned Cycles
Standard Hole Machining Cycles
G 8 0 Canned Cycle Cancel G 8 0
G 8 3 Face Drilling G 8 3 X_ Z_ R_ Q_ P_ F_
G 8 4 Face Tapping G 8 4 X_ Z_ R_ P_ F_
G 8 5 Face Boring G 8 5 X_ Z_ R_ P_ F_
G 8 7 Side Drilling G 8 7 Z_ X_ R_ Q_ P_ F_
G 8 8 Side Tapping G 8 8 Z_ X_ R _ P_ F_
G 8 9 Side Boring G 8 9 Z_ X_ R_ P_ F_

Canned cycles are used to reduce program complexity. For example peck drilling a 1 inch hole with .1
inch peck depth would use 3 0 lines of regular code, but with a canned cycle this same hole can be
competed in just 2 lines of code. More importantly if multiple holes are required only 1 extra line of
code per hole is needed. There are a variety of canned cycles for different hole types including drilling,
boring, and tapping.
There are two sets of hole machining canned cycles available for use, the standard lathe set and an
advanced set. This section focuses on the standard lathe cycles.
Axis positions can be programed in th e absolute or incremental modes; specify X, Y, Z, C for absolute
and U, V, W, H for increm ental. All active machine axes are allowed for positioning, some axes have
been left out of examples for clarity.
The basic format of a canned cycle is as follows:
Absolute:
Gcc Xxx Zzz Qqq Rrr Ppp Lll Fff
Xxn
## G 8 0
Incremental:
Gcc Uuu Www Qqq Rrr Ppp Lll Fff
Uun
## G 8 0

cc Number of t he desired canned cycle (i.e. 8 3, 8 4, 8 5 , etc).
xx X position of the center point of the first hole with respect to the current work zero point
uu Distance and direction along X axis to center point of first hole from the curren t position
zz Z position of bottom of hole with respect to the current work zero point
ww Distance and direction along Z axis, from point R, to bottom of hole
qq Peck increment if deep hole drilling, always p ositive
rr Retract plane, always programmed in incremental and always in radius values
pp Dwell , in milli seconds, at bottom of hole
ll Number of repetitions


<!-- Page 54 -->

5 4
ff Feedrate
xn Position of nth hole X axis, same rules as applied to xx
yn Position of nth hole Y axis, same rules as applied to yy

Plea se note that not all arguments will appear in all cycles, and there are a couple specia l cases that will
be discussed.

G 8 0 – Canned Cycle Cancel: To end a canned cycle a G 8 0 must be called. G 8 0 should be specified on its
own line to avoid any unintended m ovements. For example:
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
S 2 5 0 0 M 3 Start spindle
G 0 Z 1.0 Move to Z initial point
X 0.0 Move to X position
G 8 1 G 9 9 .1 X 0.0 Z-1.0 R.2 5 F 0.0 1 Drill cycle start
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind


<!-- Page 55 -->

5 5
Drilling
G 8 3 – Face Drilling : The face drilling cycle allows drilling holes in the face of a part; the Z axis is always
the drilling axis. Shallow holes can be straight drilled, or with the addition of address Q , deep er holes
can be peck drilled. For straight drilling cycle use format 1, for deep hole peck drilling cycle use format 2.
See figure 8 3 -1 for a graphic of the tool motion.
Format 1: G 8 3 X__ Z__ R__ P__ L__ F__
Format 2: G 8 3 X__ Z__ R__ Q__ P__ L__ F__
X – Position of hole
Z – End point of hole
R – Retract plane
Q – Peck depth
P – Dwell time
L – Number of repetitions
F – Feedrate
Move at feedrate (F)
Move at rapid Initial Point
Retract
Plane (R)Final Hole Depth
Peck Depth (Q)
1 st Peck
Nth Peck
Last Peck
Figure 8 3 -1: Motion of tool point for G 8 3 cycle.Face drilling with peck
(Format 2)
Initial Point
Retract
Plane (R) Final Hole
Depth Face drilling
(Format 1)
## ZX

Figure 8 3 -1: Motion of tool point in G 8 3 drilling cycle
Example: Drill a 0. 2 0 1 inch diameter hole, located at X 0.0, Z 0.0 to a depth of 1.0 inch with 0.2 5 inch
pecks. Spot to a depth of 0.1. Use initial point 0.5, retract plane 0.1.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 G 9 9 Safe start line
T 0 1 0 1 Tool change
G 9 7 S 2 5 0 0 M 3 Start spindle
G 0 Z 0.5 Move to Z initial point
X 0.0 Move to X position
G 8 3 X 0.0 Z-0.1 R-0.4 F 0.0 1 Drill cycle start


<!-- Page 56 -->

5 6
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home
G 0 G 5 4 G 1 8 G 4 0 G 8 0 G 9 9 Safe start line
T 0 2 0 2 Tool change
G 9 7 S 3 0 0 0 M 3 Start spindle
G 0 Z 0.5 Move to Z initial point
X 0.0 Move to X position
G 8 3 X 0.0 Z-1.0 R -0.4 Q 0.2 5 F 0.0 0 8 Drill cycle start
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind


<!-- Page 57 -->

5 7
G 8 7 – Side Drilling : The side drilling cycle allows drilling holes in the OD of a part; the X axis is always the
drilling ax is. Shallow holes can be straight drilled, or with the addition of address Q deep holes can be
peck drilled. For straight drilling cycle use format 1, for deep hole peck drilling cycle use format 2. See
figure 8 7 -1 for a graphic of the tool motion.
Format 1: G 8 7 Z__ X__ R__ P__ L__ F__
Format 2: G 8 7 Z__ X__ R__ Q__ P__ L__ F__
Z – Position of hole
X – End point of hole
R – Retract plane
Q – Peck depth
P – Dwell time
L – Number of repetitions
F – Feedrate
Move at feedrate (F)
Move at rapid
Figure 8 7 -1: Motion of tool point for G 8 7 cycle.Side drilling with peck
(Format 2)
Initial Point
Retract Plane (R)
Final Hole Depth Peck Depth (Q)
1 st Peck
Nth Peck
Last Peck
Initial Point
Retract Plane (R)
Final Hole Depth Side drilling
(Format 1)ZX

Figure 8 7 -1: Motion of tool point in G 8 7 drilling c ycle
Example: Drill a 0. 2 0 1 inch diameter hole, located at X 2.0, Z -1.0, C 0.0 to a depth of 1.0 inch with 0.2 5
inch pecks. Use initial point 3.0, retract plane 2.2.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 G 9 9 Safe start line
T 0 1 0 1 Tool change
G 9 7 S 2 5 0 0 M 3 Start spindle
G 0 Z -1.0 Move to Z position
X 3.0 C 0.0 Move to X and C initial position
G 8 7 Z-1.0 X 0.0 R-0.8 Q 0.2 5 F 0.0 0 8 Drill cycle start
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home


<!-- Page 58 -->

5 8
M 3 0 Program end and rewind

Tapping
G 8 4 – Face Tapping : A cycle for creating threaded holes in the face of a part using a tap; the Z axis is
always the tapping axis. For the tapping cycle the spindle is started in the clockwise direction. When the
bottom of the hole is reached the spindle reverses for retraction. Changes to feedra te or spindle speed
mid cycle can be damaging to the tool and work piece, for this reason the feedrate and spindle speed
overrides are disabled. The machine will run at 1 0 0% override for the duration of the cycle. Feed hold is
also disabled during the cycl e. If feed hold is pressed motion will stop when the tool reaches the retract
point.
Tapping requires synchronization of the spindle speed and feed rate to create the correct thread form.
The feedrate can be programmed in either feed per minute mode, G 9 8, or feed per revolution mode,
G 9 9. In the feed per rev mode the commanded feedrate will be simply the pitch of the thread. Metric
```
threads are classified with the thread pitch, i.e. M 8 x 1.2 5 mm thread has a 1.2 5 mm pitch. Unified threads
```
are classified by threa ds per inch which requires a bit of calculation to get the pitch, don’t worry it’s
easy. Simply divide 1 inch by the TPI. For a ¼ -2 0 fastener we would calculate 1/2 0 = .0 5, this is the pitch.
The catch is, to use feed per rev requires some form of rpm feed back from the machine, not every
machine will have this. For the machines without feedback the tapping cycle can be programmed in feed
per min mode (G 9 8). This method requires a little more math to obtain the correct feedrate based on
spindle rpm and pitch of the thread. The equation looks like this: RPM*Pitch=IPM. To tap that ¼ -2 0 hole
at 1 5 0 0 RPM we first need to calculate the pitch, remember 1/TPI = Pitch, so 1/2 0=.0 5. Now we
calculate the feed per min as 1 5 0 0 * .0 5=7 5 IPM. It is important to note that i f the spindle speed is
changed, the feed per minute must also be changed to match. For this reason, if the machine is capable
of feed per rev programming use it.
Format: G 8 4 X__ Z__ R__ P__ L__ F__
X – Position of hole
Z – End point of hole
R – Retract pla ne
P – Dwell time
L – Number of repetitions
F – Feedrate


<!-- Page 59 -->

5 9

Move at feedrate (F)
Move at rapid
Figure 8 4 -1: Motion of tool point for G 8 4 cycle.Initial Point
Retract Plane (R)
Final Tap Depth
Spindle FWD
Spindle REV Spindle FWDZX
Figure 8 4 -1: Motion of tool point in G 8 4 tapping cycle
Example:
Tap the hole from the G 8 3 example to a depth of .5 0 0 with a ¼ -2 0 tap using feed/min.
1/TPI = 1/2 0 = .0 5 Pitich
RPM*Pitch = 1 0 0 0*.0 5 = 5 0.0 UPM

G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 2 0 2 Tool change
G 9 7 S 1 0 0 0 M 3 Start spindle
G 0 Z 0.5 Move to Z initial point
X 0.0 Move to X position
G 9 8 Feed per minute mode
G 8 4 X 0.0 Z -0.5 R-0.4 F 5 0.0 Tap cycle start
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind


<!-- Page 60 -->

6 0
```
G 8 8 – Side Tapping : Same functionality as G 8 4 except the X axis is the tapping axis allowing the tapping
of holes on the OD of a part.
Format: G 8 8 Z__ X__ R__ P__ L__ F__
Z – Position of hole
X – End poi nt of hole
R – Retract plane
P – Dwell time
L – Number of repetitions
F – Feedrate
Move at feedrate (F)
Move at rapid
Figure 8 8 -1: Motion of tool point for G 8 8 cycle.Initial Point
Retract Plane (R)
Final Tap Depth Spindle FWD
Spindle REVSpindle FWDZX

Figure 8 8 -1: Motion of tool point in G 8 8 tapping cycle Example:
Tap the hole from the G 8 7 example to a depth of 0.3 7 5 with a ¼ -2 0 tap using feed/ rev.
1/TPI = 1/2 0 = .0 5 Pit ich

G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 2 0 2 Tool change
G 9 7 S 1 0 0 0 M 3 Start spindle
G 0 Z -1.0 Move to Z position
X 3.0 C 0.0 Move to X and C initial position
G 9 9 Feed per minute mode
G 8 4 Z -1.0 X 1.2 5 R-0.8 F 0.0 5 Tap cycle start
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind


<!-- Page 61 -->

6 1
Boring
G 8 5 – Face Boring : Boring a hole provides superior size and position accuracy as well as much finer
finishes. Generally a boring bar is used of either an adjustable or non -adjustable t ype. When the boring
cycle is activated the machine will drill down to the desired depth at the specified feedrate. The retract
move will be at twice the programmed feedrate. The G 8 5 cycle is for boring holes in the face of a part,
the Z axis will always b e the drilling axis.
Format 1: G 8 5 X__ Z__ R__ P__ L__ F__
X – Position of hole
Z – End point of hole
R – Retract plane
P – Dwell time
L – Number of repetitions
F – Feedrate
Move at feedrate (F)
Move at rapid
Figure 8 5 -1: Motion of tool point for G 8 5 cycle.Initial Point
Retract Plane (R)
Final Hole Depth ZX
Retract at feedrate x 2

Figure 8 5 -1: Motion of tool point in G 8 5 boring cycle
Example: Bore the hole fro m the G 8 3 example to a depth of 0.2 5 0.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 3 0 3 Tool change
G 9 7 S 7 5 0 M 3 Start spindle
G 0 Z 0.5 Move to Z initial point
X 0.0 Move to X position
G 8 5 X 0.0 Z -0.2 5 0 R -0.4 F 0.0 0 3 Bore cycle start
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind


<!-- Page 62 -->

6 2
G 8 9 – Side Boring : The side boring cycle is used to bore holes in the OD of a part; the X axis will always
```
be the boring axis. All other parameters and functions are the same as the G 8 5 face boring cycle.
Format 1: G 8 9 Z__ X__ R__ P__ L__ F__
Z – Position of hole
X – End point of hole
R – Retract plane
P – Dwell time
L – Number of repetitions
F – Feedrate
Move at feedrate (F)
Move at rapid
Figure 8 9 -1: Motion of tool point for G 8 9 cycle.Initial Point
Retract Plane (R)
Final Hole Depth ZX
Retract at feedrate x 2

Figure 8 9 -1: Motion of tool point in G 8 9 boring cycle
Example: Bore the hole from the G 8 7 exam ple to a depth of 0.2 5 0.
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 3 0 3 Tool change
G 9 7 S 7 5 0 M 3 Start spindle
G 0 Z-1.0 Move to Z position
X 3.0 C 0.0 Move to X and C initial position
G 8 9 Z-1.0 X 1.5 R-0.8 F 0.0 0 3 Bore cycle start
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind


<!-- Page 63 -->

6 3
Chapter 5: Advanced Hole Machining Canned Cycles
Advanced Hole Machining Cycles
G 7 3.1 High Speed Peck G 7 3.1 X_ Y_ Z_ R_ Q_ F_
G 7 4.1 Reverse Tapping G 7 4.1 X_ Y_ Z_ R_ F_
G 7 6.1 Fine Boring G 7 6.1 X_ Y_ Z_ R_ I_ J_ P_ F_
G 8 1.1 Drilling G 8 1.1 X_ Y_ Z_ R_ F_
G 8 2.1 Spot Face G 8 2.1 X_ Y_ Z_ R_ P_ F_
G 8 3.1 Deep Hole Peck Drilling G 8 3.1 X_ Y_ Z_ R_ Q_ F_
G 8 4.1 Tapping G 8 4.1 X_ Y_ Z_ R_ F_
G 8 4.2 Right Hand Rigid Tapping G 8 4.2 X_ Y_ Z_ R_ P_ F_ J_
G 8 4.3 Left Hand Rigid Tapping G 8 4.3 X_ Y_ Z_ R_ P_ F_ J_
G 8 5.1 Boring, Retract at Feed, Spindle On G 8 5.1 X_ Y_ Z_ R_ F_
G 8 6.1 Boring, Retract at Rapid, Spindle Off G 8 6.1 X_ Y_ Z_ R_ F_
G 8 7.1 Back Boring G 8 7.1 X_ Y_ Z_ R_ I_ J_ F_
G 8 8.1 Boring, Manual Retr act G 8 8.1 X_ Y_ Z_ R_ P_ F_
G 8 9.1 Boring, Dwell, Retract at Feed, Spindle On G 8 9.1 X_ Y_ Z_ R_ P_ F_

```
The advanced hole machining canned cycles are provided for increased functionality over the standard
```
cycles. These advanced canned cycles are functional ly the same as the milling canned cycles, which
provide more options such as high speed peck, absolute R point return, more boring cycles rigid tapping
and more. When compared to the standard lathe cycles there are some variances that will be covered in
this section.
Positioning will take place in the active plane, and the drilling operation will be on the normal axis. For
example in G 1 7 (XY Plane), hole position will be on the XY plane and the drilling axis will be Z. In G 1 8 (ZX
Plane) positioning will be on the ZX plane and the drilling axis will be Y. Specifying G 1 9 (YZ Plane) selects
the X axis for the drilling axis and positioning will be on the YZ plane. For the purposes of this manual all
advanced cycle examples and definitions will be in the XY plane (G 1 7).
Just as with the standard cycles, positions can be specified using absolute (X, Y, Z…) or incremental (U, V,
W…) commands. The R point is always absolute position unlike in the standard canned cycles.
When the canned cycle is complete the machine w ill return to a final position in the drilling axis, either
the initial point or the R point as determined by the G 9 8.1/G 9 9.1 setting.
Absolute:
Gcc G 9 8.1/9 9.1 Xxx Zzz Qqq Rrr Ppp Lll Fff
Xxn
## G 8 0
Incremental:
Gcc G 9 8.1/9 9.1 Uuu Www Qqq Rrr Ppp Lll Fff
Uun
## G 8 0


<!-- Page 64 -->

6 4
cc Number of t he desired canned cycle (i.e. 8 1.1, 8 4.1, 8 5.1 , etc).
xx X position of the center point of the first hole with respect to the current work zero point
uu Distance and direction along X axis to center point of first hole from the current position
zz Z position of bottom of hole with respect to the current work zero point
ww Distance and direction along Z axis, from point R, to bottom of hole
qq Peck increment if deep hole drilling, always positive
rr Retract plane,
pp Dwell, in milli seconds, at bottom of hole
ll Number of repetitions
ff Feedrate
xn Position of nth hole X axis, same rules as applied to xx
yn Position of nth hole Y axis, same rules as applied to yy

Please note that not all arguments will appear in all cycles, and there are a couple specia l cases that will
be discussed.
Advanced Drilling
G 8 1.1 – Drilling: This is a straight d rilling cycle. The tool moves to position, feeds to the bottom of the
hole then rapid retracts to either the R point or the initial point. This is an advanced canned cycle, this
means that the drilling axis is determined by the current plane selection. See figure 8 1 1-1 for a graphic
of the tool mo tion.
Format: G 8 1.1 X__ Y__ Z__ R__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
L – Number of repetitions
F – Feedrate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Hole Depth
Figure 8 1 -1: Motion of tool point for G 8 1 cycle.

Figure 8 1 1 -1: Motion of tool point for G 8 1.1 drilling cycle


<!-- Page 65 -->

6 5
Example: Create a program to drill a hole 0.5 inch deep in the face of a part at X 0.0, Z 0.0.
G 0 G 5 4 G 1 7 G 4 0 G 8 0 Safe start line , sele ct XY plane
T 0 1 0 1 Tool change
G 9 7 S 2 5 0 0 M 3 Start spindle
G 0 Z 0.5 Move to Z initial point
X 0.0 Move to X position of hole
G 8 1.1 G 9 9.1 X 0.0 Z-0.5 R.1 F 0.0 1 Drill cycle start
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind

G 8 2.1 – Spot Face: Spot face adds the ability to dwell at the bottom of the hole for a specified amount
of time. The actual tool motion is the same as a G 8 1 cycle, however with the dwell it is possible to attain
better accuracy and finish at the b ottom of the hole. This is useful for chamfering, co unter boring, and
spot facing.
Format: G 8 2.1 X__ Y__ Z__ R__ P__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
P – Dwell
L – Number of repetitions
F – Feedrate
Exampl e:
Create a chamfering program for the hole from the G 8 1.1 example , dwell for .2 seconds.

G 0 G 5 4 G 1 7 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
G 9 7 S 2 5 0 0 M 3 Start spindle
G 0 Z 1.0 Move to Z initial point
X 0.0 Move to X position of hole
G 8 2.1 G 9 9.1 X 0.0 Z-0.1 2 5 R.1 P 0.2 F 0.0 1 Drill cycle start
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind


<!-- Page 66 -->

6 6
G 8 3.1 – Peck Drilling: Peck drilling is a cycle used for drilling deep holes. The cycle allows for breaking
and clearing of chips and better application of coolant by fully retracting the tool from the hole between
pecks. This retract move and plunge to previous depth are rapid moves, each peck is a feed move at the
specified feed rate. See figure 8 3 1-1 for a graphic of the too l motion.
Format: G 8 3.1 X__ Y__ Z__ Q__ R__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
Q – Peck amount
R – Retract plane
L – Number of repetitions
F – Feedrate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Hole Depth Peck Depth (Q)
1 st Peck
Nth Peck
Last Peck
Figure 8 3 1 -1: Motion of tool point for G 8 3.1 cycle.

Figure 8 3 1 -1: Motion of tool point in G 8 3.1 drilling cycle
Example: Pec k drill a hole in the OD of a part at Z -1.5, starting on a 2.0 inch diameter and drilling a depth
of 0.7 5 inches with a 0.1 2 5 peck depth .
Note the plane selection to use the X axis as the drilling axis.

G 0 G 5 4 G 1 9 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool chan ge
G 9 7 S 2 5 0 0 M 3 Start spindle
G 0 Z -1.5 Move to Z position of hole
X 3.0 Move to X initial point
G 8 3.1 G 9 9.1 X 0.5 Z-1.5 R 2.2 Q 0.1 2 5 F 0.0 1 Drill cycle start
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind


<!-- Page 67 -->

6 7
G 7 3.1 – High Speed Peck: In materials that produce long stringy chips a high speed peck cycle can be
used to break them up. Unlike the G 8 3 .1 cycle that retracts completely out of the hole after each peck,
the G 7 3 .1 cycle only retracts 0.1 0 0 inch. See figure 7 3 1-1. This short retract helps to reduce cycle times
when a co mplete retract is unnecessary.
Format: G 7 3.1 X__ Y__ Z__ Q__ R__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
Q – Peck amount
R – Retract plane
L – Number of repetitions
F – Feedrate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Hole Depth Peck Depth (Q)
1 st Peck
Nth Peck
Last Peck
Figure 7 3 1 -1: Motion of tool point for G 7 3.1 cycle.

Figure 7 3 1 -1: Motion of tool point in G 7 3.1 drilling cycle
Example: Peck drill a hole in the OD of a part at Z -1.5, starting on a 2.0 inch diameter and drilling a depth
of 0.7 5 inches with a 0.1 2 5 peck depth.
Note the plane selection to use the X a xis as the drilling axis.

G 0 G 5 4 G 1 9 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
G 9 7 S 2 5 0 0 M 3 Start spindle
G 0 Z -1.5 Move to Z position of hole
X 3.0 Move to X initial point
G 7 3.1 G 9 9.1 X 0.5 Z -1.5 R 2.2 Q 0.1 2 5 F 0.0 1 Drill cycle start
G 8 0 Canned cycle c ancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind


<!-- Page 68 -->

6 8
Advanced Tapping
G 8 4.1 – Right Hand Tapping: The tapping cycle is used to crea te threaded holes using a tap. Set up of
the tapping cycle is the same as with G 8 4, and the same restriction s and warnings apply. This cycle is
meant to be used with a tapping head. Because it this is an advanced cycle the tapping axis is
determined by the current plane selection.
Format: G 8 4.1 X__ Y__ Z__ R__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
L – Number of repetitions
F – Feedrate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Tap Depth
Figure 8 4 1 -1: Motion of tool point for G 8 4.1 cycle.Spindle FWD
Spindle REVSpindle FWD

Figure 8 4 1 -1: Motion of tool point in G 8 4.1 tapping cycle
Example: Create a program to tap 3 holes in the face of a part to a depth of 0.5 0 0 with a ¼-2 0 tap, at a
1.7 5 inch bolt circ le diameter .
1/TPI = 1/2 0 = .0 5 Pitich

G 0 G 5 4 G 1 7 G 4 0 G 8 0 Safe start line
T 0 2 0 2 Tool change
G 9 7 S 1 0 0 0 M 3 Start spindle
G 0 Z 0.5 Move to Z initial point
X 1.7 5 C 0.0 Move to X and C position of first hole
G 9 9 Feed per rev mode
G 8 4.1 G 9 9.1 X 1.7 5 C 0.0 Z -0.5 R.1 5 F 0.0 5 Tap cycle start
C 1 2 0.0 Tap second hole
C 2 4 0.0 Tap third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind


<!-- Page 69 -->

6 9
G 7 4.1 – Left Hand Tapping: Left hand tapping is the same as right hand tapping (G 8 4 .1) except that it
will cut left hand threads. The spindle must be started in the reverse direction before calling the G 7 4 .1
cycle.
G 8 4.2/G 8 4.3 – Right and Left Hand Rigid Tapping: Rigid tapping can be performed on capable
machines. As the name implies the tap is held rigidly in the spindle, no tension/compression style
tapping holder is required. Holding the tap in this manner requires the machine to have precise control
of spindle speed, axis feed , and precise feedback of spindle RPM. The tapping axis will be electronically
geared to the spindle RPM. Use G 8 4.2 for right hand tapping and G 8 4.3 for left hand tapping. See figure
8 4 1-1 for a graphic of the motion.
Format: G 8 4.2/8 4.3 X__ Y__ Z__ R__ P__ L__ F__ J__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
P – Dwell in milli seconds
L – Number of repetitions
F – Feedrate
J – Spindle speed for retract
As wi th other tapping cycles the feedrate and spindle speed overrides are disabled and set to 1 0 0% for
the duration of the cycle. Feed hold is also disabled for the duration of the cycle. If the feed hold button
is pushed during a tapping cycle motion will stop when the machine reaches the retract position.
Example: Create the program to tap three holes in the OD of a 2.0 inch bar, evenly spaced, to a depth of
.5 0 0 with a 1/4-2 0 tap using feed/ rev. Locate the holes at Z -2.0 Tap a t 1 0 0 0 RPM, retract at 2 0 0 0 RPM .
Note the plane selection to tap with the X axis.

G 0 G 5 4 G 1 9 G 4 0 G 8 0 Safe start line
T 0 2 0 2 Tool change
G 9 7 S 1 0 0 0 M 3 Start spind le
G 0 Z -2.0 Move to Z position
X 3.0 C 0.0 Move to X and C initial position of first hole
G 9 9 Feed per revolution mode
G 8 4.1 G 9 9.1 X 1.0 C 0.0 Z -2.0 R 2.2 F 0.0 5 J 2 0 0 0 Tap cycle start
C 1 2 0.0 Tap second hole
C 2 4 0.0 Tap third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 70 -->

7 0
Advanced Boring
G 7 6.1 – Fine Boring: The fine boring cycle allows the user to stop the spindle and move the tool away
from the wall before retracting. This allows for a rapid retract without le aving a scratch on the wall.
Format: G 7 6.1 X__ Y__ Z__ R__ I__ J__ P__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
I – X shift distance and direction (Radius value)
J – Y shift distance and direction
P – Dwell in milliseconds
L – Number of repetitions
F – Feedrate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Hole Depth
Figure 7 6 1 -1: Motion of tool point for G 7 6.1 cycle Dwell, Stop spindle, Shift
amount I and J

Figure 7 6 1 -1: Motion of tool point in G 7 6.1 boring cycle
After feeding to the bottom of the hole, the machine with pause for the specified dwell time, then the
spindle will stop in the orient position be fore making the shift move defined by I and J. In machines with
```
a spindle orient function called by M 1 9 this will all be automatic. However, many machines are not
capable of orienting the spindle so the orientation must be done manually. Mak e an M code mac ro
program M 1 9.mc s to command a spindle stop and an M 0 mandatory program stop. This will allow the
operator to manually orient the spindle before the shift move is made. Here i s an example of the M 1 9
macro for the manual orient:

--Manual spindle orient macro
```
function m 1 9()
```
inst = mc.mc Get Instance () --Get mach instance number
mc.mc Spindle Set Direction (inst , 0) --Stop spindle
mc.mc Cntl Feed Hold (inst ) --Program stop
mc.mc Cntl Set Last Error (inst , "Orient spindle, press cycle start to continue" )
end


<!-- Page 71 -->

7 1
Example: Create a program to bore a 1.0 inch deep hole in the center of the face of the workpiece.

G 0 G 5 4 G 1 7 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
G 9 7 S 2 5 0 0 M 3 Start spindle
G 0 Z 0.5 Move to Z initial point
X 0.0 Move to X position of hole
G 9 8 Feed per minute
G 7 6.1 G 9 9.1 X 0.0 Z-1.0 R 0.1 I-.0 2 5 F 1 0.0 Fine bore cycle, shift X -.0 2 5 at bottom
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind

G 8 5.1 – Boring, Feedrate Retract: G 8 5.1 is a straight boring cycle, most commonly used for boring or
reaming. The retract move is at the programmed feedrate with the spindle on.
Format: G 8 5.1 X__ Y__ Z__ R__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
L – Number of repetitions
F – Feedrate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Hole Depth
Figure 8 5 1 -1: Motion of tool point for G 8 5.1 cycle

Figure 8 5 1 -1: Motion of tool point in G 8 5.1 boring cycle
Example: Create a program to ream a 0.2 5 inch deep hole in the OD of a 1 inch diameter workpiece,
located at Z -0.5.

G 0 G 5 4 G 1 9 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
G 9 7 S 2 5 0 0 M 3 Start spindle
G 0 Z -0.5 Move to Z position
X 2.0 Move to X initial point
G 9 9 Feed per rev
G 8 5.1 G 9 9.1 X 0.5 Z -0.5 R 1.2 F 1 0.0 Start boring cycle
G 8 0 Canned cycle cancel


<!-- Page 72 -->

7 2
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind

G 8 6.1 – Boring, Rapid Re tract: G 8 6 is a straight boring cycle. Before retracting from the hole the spindle
is stopped. The retract is then performed at the rapid rate. This will leave a scratch or multiple scratches
where the cutting edges are in contact with the wall.
Format: G 8 6 X__ Y__ Z__ R__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
L – Number of repetitions
F – Feedrate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Hole Depth
Figure 8 6 -1: Motion of tool point for G 8 6 cycle Spindle Stop

Figure 8 6 1 -1: Motion of tool point in G 8 6.1 boring cycle
Example: Create a program to bore 3 holes in the face of a part, 1.0 inch deep evenly spaced on a 2.0
inch bolt circle diameter.

G 0 G 5 4 G 1 7 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
G 9 7 S 2 5 0 0 M 3 Start spindle
G 0 Z 0.5 Move to Z initial position
X 2.0 C 0.0 Move to X and C positions of first hole
G 8 6.1 G 9 9.1 X 2.0 C 0.0 Z-1.0 R 0.1 F 0.0 0 4 Boring cycle start
C 1 2 0.0 Bore second hole
C 2 4 0.0 Bore third hole
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 73 -->

7 3
G 8 7.1 – Back Boring: Back boring is a useful cycle for spot facin g, counter boring or chamfering the back
side of a part. At the start of the cycle the spindle will be stopped at the orient position and the tool
offset from the hole center by the distance and direction defined by I and J. For machines that do not
have t he ability to orient the spindle, see the M 1 9 macro example in the G 7 6 .1 cycle description. The
tool can then be positioned to the R point below the work piece. Once at the R point the tool will be
positioned at the hole center and the spindle started to p erform the back boring operation. When the
specified Z point is reached the machine will orient the spindle, offset by amount I, J and retract back to
the initial point. In this cycle the R point will always be below the w ork piece, not a good point to end
the cycle. For that reason this canned cycled will always return to the initial point, it is not possible to
specify a G 9 9 .1 R point return.
Format: G 8 7.1 X__ Y__ Z__ R__ I__ J__ P__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
I – X shift distance and direction (Radius value)
J – Y shift distance and direction
P – Dwell in milli seconds
L – Number of repetitions
F – Feedrate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)Final Hole Depth
Figure 8 7 1 -1: Motion of tool point for G 8 7.1 cycle Spindle orient
and shift by I, J
Shift back
start spindle Spindle orient
and shift by I, J

Figure 8 7 1 -1: Motion of tool point in G 8 7.1 boring cycle
Example: Create a program to back bore a thru hole in the center of the face of a workpiece . Thru depth
1.0 inch, back bore depth 0.1 5 0 inch.

G 0 G 5 4 G 1 7 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
G 9 7 S 2 5 0 0 M 3 Start spindle
G 0 Z 0.5 Move to Z initial point
X 0.0 Move to X position of ho le
G 8 7.1 G 9 8.1 X 0.0 Z-0.8 5 R-1.0 5 I -.1 0 F 0.0 0 8 Back b oring cycle start (Shift -.1 in X axis)
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return to home
M 3 0 Program end and rewind


<!-- Page 74 -->

7 4
G 8 8.1 – Boring, Manual Retract: This boring cycle features a manual retract . At the bottom of the hole
the specified dwell is performed, then the spindle is stopped and the program paused. The operator can
then manually retract the tool from the hole. After retracting the tool cycle start is pressed to continue
program operation.
Format: G 8 8.1 X__ Y__ Z__ R__ P__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
P – Dwell in milli seconds
L – Number of repetitions
F – Feedrate
Initial Point
Retract Plane (R)
Final Hole Depth
Figure 8 8 1 -1: Motion of tool point for G 8 8.1 cycle. Move at feedrate (F)
Move at rapid
Manual jog Press Cycle Start
Program Pause Manual
Retract

Figure 8 8 1 -1: Motion of tool point in G 8 8.1 boring cycle
Example: Create a program to bore a 0.4 inch deep hole located at Z -1.2 5 in the OD of a 4.0 inch
diameter part.

G 0 G 5 4 G 1 9 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
G 9 7 S 2 5 0 0 M 3 Start spindle
G 0 Z -1.2 5 Move to Z position
X 5.0 Move to X initial position
G 8 8.1 G 9 9.1 X 3.2 Z-1.2 5 R 4.2 F 0.0 0 4 Boring cycle start, pause for manual retract
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 75 -->

7 5
```
G 8 9.1 – Boring, Dwell & Feedrate Retract: Same function as G 8 5 with the addition of a dwel l at the
bottom of the hole.
Format: G 8 9.1 X__ Y__ Z__ R__ P__ L__ F__
X, Y – Position of hole in XY plane
Z – End point of hole
R – Retract plane
P – Dwell in milli seconds
L – Number of repetitions
F – Feedrate
Move at feedrate (F)
Move at rapid Initial Point
Retract Plane (R)
Final Hole Depth
Figure 8 9 1 -1: Motion of tool point for G 8 9.1 cycle Dwell (P)

Figure 8 9 1 -1: Motion of tool point in G 8 9.1 boring cycle.
Example: Create a program to bore a 1.0 inch deep hole in the face of a workpiece. Dwell for 1.0 second
at the bottom.

G 0 G 5 4 G 1 7 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change
G 9 7 S 2 5 0 0 M 3 Start spindle
G 0 Z 0.5 Move to Z initial position
X 0.0 Move to X position of hole
G 8 9.1 G 9 9.1 X 0.0 Z-1.0 R 0.1 P 1.0 F 0.0 0 4 Boring cycle start
G 8 0 Canned cycle cancel
G 0 G 5 3 X 0.0 Z 0.0 Return Z to home
M 3 0 Program end and rewind


<!-- Page 76 -->

7 6
Chapter 6: Tool Nose Radius Compensation
Lathe tools generally have a slightly rounded nose instead of a sharp point, see figure 4 1 -1. This round
nose creates an offset between the programmed point and the actual cutting point when cutting tapers
and arcs. Tool nose radius compensation allows the programmer to program the ac tual shape of the
part, leaving the calculation of this offset amount to the machine control. Many modern Computer
Aided Manufacturing (CAM) systems will automatically compensate for this offset in the G code file, but
when manually programming a simple pr ofile, tool nose radius compensation is a must have.

Figure 4 1 -1: Difference between programmed and actual cut points
Profiles parallel to the X or Z axis, a simple cylinder, are not subject to this offset. When turning a
straight surface, the offset bet ween the programmed point and the actual cutting point is zero because
the lie on the same line . See figure 4 1 -2. However, when angles or arcs are introduced, the offset starts
to change and over or under cutting will occur , see figure 4 1 -3.

Figure 4 1 -2: Straight turning and facing


<!-- Page 77 -->

7 7

Uncut Area
Overcut Area
Uncut Area
Figure 4 1 -3: Tool nose radius effect of tapers and arcs
For the tool nose radius compensation to work correctly, it does require good input from the operator.
An accurate value for the nose radius needs to be input and also t he tip direction must be specified. If
these values are not correct, the resulting tool path could amplify the negative effects of no radius
compensation. The nose radius and tip direction are input in the desired tool offset under “Tip rad” and
“Tip” resp ectively. The nose radius of the cutter, if purchased, can usually found on the box or in the
```
manufacturers specs. Many inserts are classified with a standard ISO numbering system that contains
the nose radius size. For example a CNMG 3 3 2 insert has a 2/6 4 radius, or 0.0 3 1 3 inch, a DCGT 3 3 1 has a
1/6 4 radius, or 0.0 1 5 6 inch. Check the nose radius information and input it into the “Tip rad” for the
desired tool.
The tool tip direction is determined by how the to ol is positioned in the machine, see figures 4 1 -4 and
4 1-5.


<!-- Page 78 -->

7 8

+Z+X 1 2
3 4 5 6
7
8 9 0
Figure 4 1 -4: Tool tip number orientation

Figure 4 1 -5: Tool tip orientation
For most OD turning tools the tool tip will be 2 or 3 depending on if it is a front or rear turret tool.
G 4 1 and G 4 2 are used to activate tool nose radius compensat ion. The offset used will be the offset
number specified in the last T code called. G 4 1 will offset to the left of the path and G 4 2 will offset to
the right of the path, see figure 4 1 -6. When activating G 4 1 or G 4 2, it is always recommended to activate
on a lead -in perpendicular to the path and a distance longer than the radius. This will greatly reduce the
chances of a gouge or unexpected result. Also, nose radius compensation may only be activated on a
linear move, no arcs.
Format: G 0 0/0 1 G 4 1/4 2 X__ Z__ F_ _


<!-- Page 79 -->

7 9

## G 4 1G 4 2
Figure 4 1 -6: Nose radius compensation direction
Example program: To show how to use tool nose radius comp, let’s make a quick program. This will be a
simple OD profile with a couple tapers and an arc. Because we are using tip compensation we’ll be abl e
to program the part dimensions as shown, no extra calculations necessary. See figure 4 1 -7 for part
dimensions.

Figure 4 1 -7: Example program part dimensions
G 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
T 0 1 0 1 Tool change , select tool 0 1, offset 0 1.
G 9 6 S 1 0 0 0 M 3 Start spindle
G 0 Z 0.0 Move to Z to face part
X 3.7 Move to X start position
G 1 X -0.0 3 5 F 0.0 1 0 Face part (move past center line a bit more than
the nose radius)
G 0 U 0.1 W 0.0 5 Retract off the face
G 0 X 1.5 Z 0.1 Position to start lead -in
G 0 1 G 4 2 X 1.0 F 0.0 2 5 Activate tool nose radius compensation
X 1.0 Z 0.0 F 0.0 1 5 Move to start of cut
X 1.7 5 Z -0.3 1 F 0.0 0 8 Start cut
Z-1.8 8 Cut


<!-- Page 80 -->

8 0
G 0 2 X 2.5 Z -2.5 8 I 0.8 5 Cut radius
G 0 1 X 3.2 5 Z -2.8 3 Cut 2 nd taper
G 0 1 Z -4.3 3 Finish cut
G 0 1 G 4 0 X 3.7 5 Lead -out and cancel tool nos e radius
compensation
G 0 G 5 3 X 0.0 Z 0.0 M 5 Return home and stop spindle
M 3 0 End program and rewind


<!-- Page 81 -->

8 1
Chapter 7: M Code s
Code Description Page
M 0 0 Mandatory Program Stop 8 1
M 0 1 Optional Program Stop 8 1
M 0 2 Progr am End 8 1
M 0 3 Spindle Forward/Clockwise 8 1
M 0 4 Spindle Reverse/Counterclockwise 8 1
M 0 5 Spindle Stop 8 1
M 0 7 Mist Coolant On 8 2
M 0 8 Flood Coolant On 8 2
M 0 9 All Coolant Off 8 2
M 1 9 Spindle Orient 8 2
M 2 3 Single Line G 7 6 Leadout On 8 2
M 2 4 Single Line G 7 6 Leadout Off 8 2
M 3 0 Program End and Rewind 8 2
M 9 8 Subprogram Call 8 2
M 9 9 Return From Subprogram / Rewind 8 3
M??? Custom Macro M Codes 8 3

M Code Descriptions
M 0 0 – Mandatory Program Stop: To pause a program at any point specify an M 0 0. All motion will be
halted and the spindle stopped. To resume operation press the cycle start button.
M 0 1 – Optional Program Stop: Program pauses same as M 0 0, but only when the optional stop switch is
turned on. This allows the operator to stop and check program points when needed, but also to run
without stops.
M 0 2 – Program End: Ends the program at the M 0 2 block. All program operation will be ended and
defaults (G 5 4, G 1 7, G 9 0, etc .) reset. The program will not rewind and if the cycle start button is pressed
program operation will begin with the next block following the M 0 2.
M 0 3 – Spindle Forward/Clockwise: Turns the spindle on in the forward direction at the designated
speed. M 0 3 is usually combined with an S word to define the speed. If an S word is not specified the last
spindle speed is used.
M 0 4 – Spindle Reverse/Counterclockwise: Turns the spindle on in the reverse direction at the
designated speed. M 0 4 is usually combined with an S word to define the speed. If an S word is not
specifie d the last spindle speed is used.
M 0 5 – Spindle Stop: Stops spindle rotation.


<!-- Page 82 -->

8 2
M 0 7 – Mist Coolant On: Turns on the mist coolant output.
M 0 8 – Flood Coolant On: Turns on the flood coolant output.
M 0 9 – All Coolant Off: Turns off all coolant outputs.
M 1 9 – Spindle Orient: Although this code is not built into Mach and is completely user defined, it is
required to orient the spindle for some machining cycles, G 7 6 and G 8 7 for example. Tool changers
usually will require a spindle orientation, and although this ori entation could be any M code defined by
the user or even built into the M 6, M 1 9 is recommended as it is an industry standard M code.
M 2 3 – Thread Leadout On: Turns on thread lead out for the single line G 7 6 threading cycle.
M 2 4 – Thread Leadout Off: Turns off thread lead out for the single line G 7 6 threading cycle.
M 3 0 – Program End and Rewind: Ends the current program and rewinds back to the beginning. Pressing
the cycle start button will start program execution from the first block. All defaults (G 5 4, G 1 7 , G 9 0, etc.)
will be reset.
M 9 8 – Subprogram Call: Subprograms are external programs referenced by the current running
program. When called program execution will continue in the subprogram. This allows the user to
reduce program length and complexity by p roviding the ability to easily repeat sections of code, run the
same section of code in multiple locations or in multiple fixture offsets, the possibilities are limited only
by the program mer. To call a subprogram command M 9 8 with the program number as sh own.
Format: M 9 8 P____ Q__ L__
P specifies the number of the progr am to be called. This is a four digit integer number. When the M 9 8 is
read Mach scans the current file for a block containing the program number in the following form:
Format: O 1 2 3 4
Note tha t the letter “O” is used to specify the program number 1 2 3 4, NOT the number “0”. Program
execution will continue with the block following the O number. For this method the subprogram should
be below the end of the current program:
(MAIN PROGRAM) Main progr am header
G 0 G 9 0 G 5 4 G 1 8 G 4 0 G 8 0 Safe start line
G 0 X 4.0 Y 0.0 Z 1.0 Rapid move
T 1 M 6 Tool change to tool 1
G 0 X 1 0.0 Y -5.0 Z 1.0 Rapid move
M 9 8 P 1 0 0 0 Call subprogram number 1 0 0 0
M 3 0 Program end and rewind

O 1 0 0 0 (SUB PROGRAM BEGIN) Subprogram number
G 1 2 I -0.2 5 Cut circle
M 9 9 Return to main program


<!-- Page 83 -->

8 3
There are limitations to this method; mainly the subprogram must be pasted into every program that it
is to be called from. Mach also allows a subprogram to be called from an external file. This way, mult iple
programs can call the same subprogram, without having the program in the main file. If a change needs
to be made to the subprogram it on ly needs to be done in one file, not every file in which the sub is
called. If the control does not find the progra m number in the current file it will then search for it in the
Mach 4 \Subroutines directory. This time it will be searching filenames. The files in this directory should
be named with the program number as follows:
Format: O____
Note the letter “O” followed by four numbers, and no file extension; O 1 2 3 4 not O 1 2 3 4.txt. When the
program is loaded this file will be found and loaded into the memory, the tool path display will reflect
what is in the subprogram. When running the file the M 9 8 block will be read and program execution will
continue with the first block of the subprogram file.
The arguments Q and L are optional. Q specifies the sequence number in the subprogram to start at. If Q
is omitted then execution will start at the beginning of the sub program ; see figure 1 9 8 -1. L is the
number of repetitions. For example, if L=2 the subprogram is run two times before execution of the
main program continues. If L is omitted the program will run only once.

M 9 9 – Return From Subprogram / Rewind: To return to the m ain program from a subprogram an M 9 9
is used.
Format: M 9 9 P__
M 9 9 specified in a subprogram will return to the main program at the block immediately following the
M 9 8 subprogram call. The addition of a P in the M 9 9 block will return to a desired sequence n umber in
the main program. See figure 1 9 9 -1.

If M 9 9 is specified in a main program (not in a subprogram) a program rewind is performed . Execution
will continue from the first block of the program.
```
Custom M Codes: Every machine is a little different and ha s different functions and options. Custom M
codes allow the user to create simple programming calls for complex processes, activating or
deactivating outputs, reading inputs, performing math, or whatever else the user and machine could
require. These M cod es are programmed in Lua and placed in the macros folder under each profile.
Every profile can have its own unique set of M codes. The file name must be the macro to be called. For
example to make a tool change macro, M 6, add a Lua script with the filenam e M 6.mcs to the macros
folder in the desired profile. When an M 6 is called in a program or in MDI the macro will be executed.

