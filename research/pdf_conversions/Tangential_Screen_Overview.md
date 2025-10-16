# Tangential_Screen_Overview

*Converted from PDF: Tangential_Screen_Overview.pdf*
*Conversion date: /Users/chondl/learn/mach4/scripts*

---

<!-- Page 1 -->

## MACH 4 TANGENTIAL
The Tangential Profile is intended to operate machinery equipped with a rotational axis
independent of, but usually associated with the Z axis direction. Machines include, but
are not limited to, drag knife, oscillating knife, water jet, and crease rollers.
Unlike a milling machine or a router, a tangential machine interprets g code a bit
differently. Operating in Tangential Mode, an axis (usually A) will rotate to interpolate
G 0 2 and G 0 3 (arc moves), while a mill/router will interpolate arcs using the X and Y .


<!-- Page 2 -->

Tangential-Specific Features:
Retract Button –
```
Although this is a standard function in Mach 4 Router, while in Tangential Mode, users will
not need to turn on the spindle before continuing the g code file with the Cycle Start
Button. The Retract Button is found in the Control Group.
Vacuum Table-
Standard Mach 4 Vacuum On/Off toggle, which is also associated with M 1 1 2 and M 1 1 3 macros
for on/off.
G Code Extents Buttons –
The Extents buttons can be found in the Jogging Tab. Users can click on any of the Extents
buttons and the machine will travel to the farthest points of the current g code file in
relations to the current work coordinates. Use extreme caution. There are no Z moves.
These buttons are intended for use with nesting checks and maximum material usage.


<!-- Page 3 -->

Tangential Tab-
This tab is a facility to set Parameters that control tangential operation as well as an
Enabled/Disabled button.
Lift Angle DRO –
This is a user input DRO for setting the max angle to enable knife lift to complete direction
changes. These can include arcs and/or linear moves. When Mach 4 interprets that the lift
angle will be exceeded, motion in X and Y will stop and the knife will “exit,” or lift out of
the material (controlled by Lift Distance). The A axis will rotate and knife will re-enter the
material to complete the move.
Lift angle is represented by Parameter 5 0 0.
Found in C Drive> Mach 4> Profiles>Mach 4 _Tangential> parameters
Parameters can be set via G Code as well
EX: Set Parameter 5 0 0 to 2 0.0 0 0
G 1 0 L 5 0 (L 5 0 Specifies Parameter Setting Mode )
N 5 0 0 R 2 0 (N Specifies the Parameter number, R Specifies the new Parameter Value. )
G 1 1 (Ends the G 1 0 Sequence)


<!-- Page 4 -->

Lift Distance DRO –
This is user input DRO that will control the distance the knife will “exit” or lift out of the
material when lift angle has forced the lift for rotation.
Lift Distance is represented by Parameter 5 0 1.
Parameters can be set via G Code as well
EX: Set Parameter 5 0 1 to -3 2.0 0 0
G 1 0 L 5 0 (L 5 0 Specifies Parameter Setting Mode )
N 5 0 1 R-3 2.0 0 0 (N Specifies the Parameter numb er, R Specifies the new Parameter Value. )
G 1 1 (Ends the G 1 0 Sequence)
Arc Smoothing DRO –
Arc Smoothing is a user input angular value for setting the resolution tolerance in arc-to-arc
transitions. This value should be treated as a motor tuning constant. The value will
also differ from machine to machine depending on, but not limited to, steps per unit,
motor type, and drive and/or motor resolution.
Obtaining an Arc Smoothing value is simi lar to X, Y , and Z motor tuning .
Once a value has been ac hieved that eliminates “jerky” motion when cutting ellipses and
large continuous arcs, that value will become a constant and will remain a constant until
changed by the user.
Arc Smoothing is represented by Parameter 5 1 0.
Parameters can be set via G Code as well
EX: Set Parameter 5 1 0 to 5.0 0 0
G 1 0 L 5 0 (L 5 0 Specifies Parameter Setting Mode )
N 5 1 0 R 5.0 0 0 (N Specifies the Parameter number, R Specifies the new Parameter Value.)
G 1 1 (Ends the G 1 0 Sequence)
Enable Plane DRO –
Arc Smoothing is a user in put that will set the value at which Tangential rotation is enabled
or disabled during operation.
Config 1)
If the top of the material to be processed is Z zero in the current work coordinate system,


<!-- Page 5 -->

zero would be entered for the Enable Plane. During operations, anytime Z travels below
zero (negative values), Tangential rotation will be enabled.
Config 2)
If the machine table is Z zero in th e current work coordinate system and the material to be
processed has a thickness of .5 0 0, .5 0 0 would be entered in the Enable Plane DRO . During
operations, anytime Z travels below .5 0 0 (positive values), Tangential rotation will be
enabled.
Config 3)
If Tangential rotation needs to stay e nabled all of the time, a value larger than needed or
that represents the actual travel of the Z axis can be entered to accomplish this.
Enable Plane is represented by Parameter 5 1 1.
Parameters can be set via G Code as well
EX: Set Parameter 5 1 1 to .5 0 0
G 1 0 L 5 0 (L 5 0 Specifies Parameter Setting Mode )
N 5 1 1 R.5 0 0 (N Specifies the Parameter number, R Specifies the new Parameter Value.)
G 1 1 (Ends the G 1 0 Sequence)
********************!!THE NEXT SECTION IS EXTREMELY IMPORTANT!!***********************
Tangential Enabled Button –
The Tangential Enabled/Disabled Button will toggle Mach 4 in and out of tangential mode.
Users can take advantage of this feature when a milling head is also installed on the
machine or if tangential moments need to be disabled for any operations at all.
Tangential Enabled/Disabled is represented by Parameter 5 0 2.
Parameters can be set via G Code as well
EX: Set Parameter 5 0 2 to 0
G 1 0 L 5 0 (L 5 0 Specifies Parameter Setting Mode )
N 5 0 2 R 0 (N Specifies the Parameter number, R Specifies the new Parameter Value. )
G 1 1 (Ends the G 1 0 Sequence)
Tangential should not be disabled, unless users have full understanding of what the
results will be.


<!-- Page 6 -->

Tool Information-
Current Tool -
Displays the current tool.
Active Offset -
This DRO will display the active length offset (if active; G 4 3 Hxx) number for the current
tool in use.

