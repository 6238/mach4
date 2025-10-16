# TouchOffHelp

*Converted from PDF: TouchOffHelp.pdf*
*Conversion date: /Users/chondl/learn/mach4/scripts*

---

<!-- Page 1 -->

Using The Mach 4 Touch Button Module
This document has been drafted to discuss the Touch Module user interface that is associated with the
Touch Button that is located in the Tool Information window.

This Document will cover the user Settings/Options fields, Status window, and the Functions Buttons.


<!-- Page 2 -->

## PRECAUTION
```
Before attempting to use any of the functions and features within the Touch Module, It is the users
```
responsibility to fully under stand how their machine will react to the functions and features within the
Module.
It is also a requirement for the user to have a probing device with a signal that Mach will be able to
interpret as such.
Settings/Options
When the “Touch Button” is clicked, the “Touch Off
UI” will open, as depicted above. This section of this
document will Discuss the user input fields that are
with in the Settings/Options window of the UI.
The first field is Probe Feed Rate. This is the actual
feed rate (speed) at which the probe travels toward the
current probe cycle's point of contact with the work
piece.
It is recommended that this feed rate be set very low.
Too high a rate could result in damaged tools, or
inaccurate probe contact and inaccurate offset settings
The second field is Retract Distance. This is the
distance the probe will retract after the probe makes
contact during a cycle. The retract distance may have
to be modified at times depending on the shape and
size of the part to
be probed.

Prep. Feed Rate is the feed rate, (speed) that the axis'
will move during any “non” probing move.
The Prep Distance is used as a variable for the distance the Axis travel in a a prep move.
```
Tool or Probe Diameter is the actual diameter of the tool or probe being used during the function.
When using tools for probing, this value will be changed frequently. It is vital for the correct value to
be placed in this field.


<!-- Page 3 -->

```
Touch Plate Height is a variable for the thickness of the touch plate being used in any of the functions.
**It is important to keep in mind that if a touch plate is used for setting more than one Axis, it
must maintain the same thickness for all of the axis' being probed**
Probe Code Options are the probe designations set up by the user in Mach 4.
G 3 1 (Probe)
G 3 1.1 (Probe 1)
G 3 1.2 (Probe 2)
G 3 1.3 (Probe 3)
The Probe Code indicator LED's are found on the Machine Diagnostics Tab In Mach 4. The
corresponding Led will light on a probe hit when wired/ mapped accordingly.
```
Corner Touch Option Outside With Z, is a setting for the corner touch functions. Users will manually
jog the probe over the corner of the part to be probed within the limits set in the prep distance, in a way
```
that the top of the part will be probed first. Next depending on function selected by the user, the probe
will travel to one of the sides that make up the corner of the part, travel in Z beyond the initial Z probe
contact point, probe feed rate until contact is made. A retract to the retract distance, and then in Z to the
Z contact point, plus the retract distance, for the prep move to the other side that makes up the corner
being probed.
```
When the function is complete, Z axis will travel to the retract point again and to the corner of the part
Center Touch Options, Inside With No Z, is an option for users when finding the center of a pocket. It
requires the user to manually jog the probe to the “approximate” center of the feature to be probed.
Unlike the With Z Setting, the user is also required to manually jog the z down into the feature that is
```
to be probed, deep enough for the probe to make contact with the inside walls during the function.
```
Measure Angle Options are for setting axis direction probe travel for the Measure Angle function.
```
Z Only Option “Material Top”. When this option is chosen, the Z Probe contact in the function will set
the current work coordinates Z to zero.
```
Z Only Option “Tool Length (TLO)” When this option is chosen, the Z Probe contact in the function,


<!-- Page 4 -->

will set the Tool Length Offset for the tool being used as a probe. Users must make sure that the tool
length off set for that tool has been made active prior to using this setting.
Status Window
In the middle of the Touch Modules UI, is the Status
Window.
From the top of the window, down to the middle there are
three DRO's. X, Y, and Z.
These DRO's are a mirror of the Current Position DRO's
found on Mach 4's Run, and Offsets Tabs.
There is a toggle button and a large LED in this window.
The toggle button is The
Work/Machine Toggle.
When the DRO's are
displaying the current
Work Coordinates, The
button will state that, and will show up in black and with
text.
When users toggle the
button to display the
Work Coordinates, the
button will state that, and
it will also change back ground colors from black to red.
The next item down is a large LED that is mapped to the
current active probe. When the Probe signal is inactive the LED is
light black and white.
When The active probe makes contact, this LED's background color
changes from black to blue. The text changes to indicate it is active.


<!-- Page 5 -->

Functions
The Functions window contains all of the
probing cycles that will run using user input
from the Settings/Options window.
This Icon represents the Find Y ++
```
Function. To use this function the
user will manually jog to a spot on
their part with the probe on the
positive Y surface. The Z axis
will have to also be
positioned below the top
of the work piece to
ensure the probe will
contact the side of the
work piece.
Once the probe is in position, click the Find Y++
Button. The cycle will travel in a negative
direction in the Y axis, at the Probe Feed Rate
until the probe makes contact with the work
piece.
The probe will then back off the work piece to
the Retract Distance at the Prep Feed Rate.
Taking into consideration Tool /Probe Diameter,
and Touch Plate height, the Y Offset for the
current work coordinate has been set to this
surface. Users can verify this by looking at the
History bar.
```
This Icon represents the Find Y-- Function. To use this function the user will manually
jog to a spot on their part with the probe on the Negative Y surface. The Z axis will have
to also be positioned below the top of the work piece to ensure the probe will contact the
side of the work piece.
Once the probe is in position, click the Find Y-- Button. The cycle will travel
in a Positive direction in the Y axis, at the Probe Feed Rate until the probe
makes contact with the work piece.
The probe will then back off the work piece to the Retract Distance at the Prep
Feed Rate. Taking into consideration Tool /Probe Diameter, and Touch Plate
height, the Y Offset for the current work coordinate has been set to this surface.
Users can verify this by looking at the History bar.


<!-- Page 6 -->

```
This Icon represents the Find X-- Function. To use this function the user will manually
jog to a spot on their part with the probe on the Negative X surface. The Z axis will have
to also be positioned below the top of the work piece to ensure the probe will contact the
side of the work piece.
Once the probe is in position, click the Find X-- Button. The cycle will travel
in a Positive direction in the X axis, at the Probe Feed Rate until the probe
makes contact with the work piece.
The probe will then back off the work piece to the Retract Distance at the Prep
Feed Rate. Taking into consideration Tool /Probe Diameter, and Touch Plate
height, the X Offset for the current work coordinate has been set to this
surface. Users can verify this by looking at the
History bar.
```
This Icon represents the Find X-- Function. To use this function the user will manually
jog to a spot on their part with the probe on the Negative X surface. The Z axis will have
to also be positioned below the top of the work piece to ensure the probe will contact the
side of the work piece.
Once the probe is in position, click the Find X-- Button. The cycle will
travel in a Positive direction in the X axis, at the Probe Feed Rate until the
probe makes contact with the work piece.
The probe will then back off the work piece to the Retract Distance at the
Prep Feed Rate. Taking into consideration Tool /Probe Diameter, and
Touch Plate height, the X Offset for the current work coordinate has been
set to this surface. Users can verify this by looking at the History bar.
```
This Icon represents the Find Top Left Corner Function. To use this function the user will
manually jog the Z axis over the top of the work surface , then position X, and Y so the
probe is positioned over the top left corner of the part .
Once the probe is in position, click the Find Top Left Corner Button. The cycle will
begin by
Invoked moves:
1) Traveling in a negative Z direction at the Probe Feed Rate until the
probe makes contact with the work piece.
2) Retract in Z to the Retract Distance at the Prep Feed Rate.
3) Positive in the Y direction to a clearance position determined by User
input from Setting/Options.
4) A negative Z travel below the now probed work surface.
5) At Probe Feed Rate, the probe will travel toward the work piece in a negative Y direction until the
probe makes contact with the work piece.


<!-- Page 7 -->

6) A positive Y Retract move will take place
7) A positive retract in Z.
8) X, Y position move back to the users start point for this cycle.
9) Then a prep. move in the negative X direction.
1 0) Prep move in Z below the work surface will prepare the probe for contacting the X surface.
1 1) The X axis will now travel at the Probe Feed Rate in a positive direction toward the X surface being
probed.
1 2) Once contact is made, a retract position in the X away from the probed surface,
1 3) then in the Z to the clearance point above the work surface will take place.
Taking into consideration Tool /Probe Diameter, and Touch Plate height, the X, Y , and Z Offsets for
the current work coordinate have been set..
1 4) The last and final move for this cycle is in both X, and Y. The move positions these axis' at the
newly set work coordinates X, Y Zero.
Users can verify this by looking at the History bar.
```
This Icon represents the Find Top Right Corner Function. To use this function the user
will manually jog the Z axis over the top of the work surface , then position X, and Y so
the probe is positioned over the top right corner of the part .
Once the probe is in position, click the Find Top Right Corner Button. The cycle will begin by
1) Traveling in a negative Z direction at the Probe Feed Rate until contact with
the probe is made.
2) Retract in Z to the Retract Distance at the Prep Feed Rate.
3) Positive in the Y direction to a clearance position determined by User input
from Setting/Options.
4) A negative Z travel below the now probed work surface.
5) At Probe Feed Rate, the probe will travel toward the work piece in a
negative Y direction until the probe makes contact with the work piece.
6) A positive Y Retract move will take place
7) A positive retract in Z.
8) X, Y position move back to the users start point for this cycle.
9) Then a prep. move in the positive X direction.
1 0) Prep move in Z below the work surface will prepare the probe for contacting the X surface.
1 1) The X axis will now travel at the Probe Feed Rate in a negative direction toward the X surface
being probed.
1 2) Once contact is made, a retract position in the X away from the probed surface,
1 3) Then in the Z to the clearance point above the work surface will take place.
Taking into consideration Tool /Probe Diameter, and Touch Plate height, the X, Y , and Z Offsets for
the current work coordinate have been set..
1 4) The last and final move for this cycle is in both X, and Y. The move positions these axis' at the
newly set work coordinates X, Y Zero.
Users can verify this by looking at the History bar.


<!-- Page 8 -->

```
This Icon represents the Find Bottom Left Corner Function. To use this function the user
will manually jog the Z axis over the top of the work surface , then position X, and Y so
the probe is positioned over the bottom left corner of the part part .
Once the probe is in position, click the Find Bottom Left Corner Button. The
cycle will begin by
1) Traveling in a negative Z direction at the Probe Feed Rate until contact with
the probe is made.
2) Retract in Z to the Retract Distance at the Prep Feed Rate.
3) Negative in the Y direction to a clearance position determined by User
input from Setting/Options.
4) A negative Z travel below the now probed work surface.
5) At Probe Feed Rate, the probe will travel toward the work piece in a positive Y direction until the
probe makes contact with the work piece.
6) A negative Y Retract move will take place
7) A positive retract in Z.
8) X, Y position move back to the users start point for this cycle.
9) Then a prep. move in the negative X direction.
1 0) Prep move in Z below the work surface will prepare the probe for contacting the X surface.
1 1) The X axis will now travel at the Probe Feed Rate in a positive direction toward the X surface being
probed.
1 2) Once contact is made, a retract position in the X away from the probed surface,
1 3) then in the Z to the clearance point above the work surface will take place.
Taking into consideration Tool /Probe Diameter, and Touch Plate height, the X, Y , and Z Offsets for
the current work coordinate have been set..
1 4) The last and final move for this cycle is in both X, and Y. The move positions these axis' at the
newly set work coordinates X, Y Zero.
Users can verify this by looking at the History bar.
```
This Icon represents the Find Bottom Right Corner Function. To use this function the
user will manually jog the Z axis over the top of the work surface , then position X, and
Y so the probe is positioned over the bottom right corner of the part part .
Once the probe is in position, click the Find Bottom Right Corner Button. The cycle will begin by
1) Traveling in a negative Z direction at the Probe Feed Rate until contact with the
probe is made.
2) Retract in Z to the Retract Distance at the Prep Feed Rate.
3) Negative in the Y direction to a clearance position determined by User input
from Setting/Options.
4) A negative Z travel below the now probed work surface.
U 5) At Probe Feed Rate, the probe will travel toward the work piece in a positive
Y direction until the probe makes contact with the work piece.
6) A negative Y Retract move will take place


<!-- Page 9 -->

7) A positive retract in Z.
8) X, Y position move back to the users start point for this cycle.
9) Then a prep. move in the positive X direction.
1 0) Prep move in Z below the work surface will prepare the probe for contacting the X surface.
1 1) The X axis will now travel at the Probe Feed Rate in a negative direction toward the X surface
being probed.
1 2) Once contact is made, a retract position in the X away from the probed surface,
1 3) then in the Z to the clearance point above the work surface will take place.
Taking into consideration Tool /Probe Diameter, and Touch Plate height, the X, Y , and Z Offsets for
the current work coordinate have been set..
1 4) The last and final move for this cycle is in both X, and Y. The move positions these axis' at the
newly set work coordinates X, Y Zero.
Users can verify this by looking at the History bar.
```
This Icon represents the Find Angle X++ Function. To use this function the user will
need to determine the direction and axis of the angle to be probed. In the
Settings/Options window, the Measure Angle Options drop down menu will have these
selections. When the correct angle has been chosen, the image on the Find Angle button
will change to reflect that.
This is X++ angle.
To set up to use this cycle, the user will jog the probe to the angled surface to be probed. A manual Z
position below the work surface is required as well to ensure probe contact.
When in position clicking on the Find Angle Button will start the cycle. The
cycle consists of two probing moves. Users will have to use caution where
they position for the first move. When the first probe contact has been made,
there will b a retract move to the start position. Depending on that distance,
and the severity of the angle being probed, this may cause unwanted probe
contact during the positioning move to the second probing position.
Enough clearance should be allowed for this when the user position their probe before running the
cycle.
Once the cycle has been run successfully, Users will be able to obtain the measured angle from the
history window for future reference.
```
If users need to probe the corner of a work piece with one of the corner functions, and the corner to be
probed is on angle, the Find Angle Function should be used first. Once the G 6 8 is set any of the Find
Corner Functions will be executed on the G 6 8 angle that is now set.


<!-- Page 10 -->

```
This Icon represents the Find Angle X-- Function. To use this function the user will
need to determine the direction and axis of the angle to be probed. In the
Settings/Options window, the Measure Angle Options drop down menu will have these
selections. When the correct angle has been chosen, the image on the Find Angle button
will change to reflect that.
This is X--angle.
To set up to use this cycle, the user will jog the probe to the angled surface to be
probed. A manual Z position below the work surface is required as well to
ensure probe contact.
When in position clicking on the Find Angle Button will start the cycle. The
cycle consists of two probing moves. Users will have to use caution where they
position for the first move. When the first probe contact has been made, there
will b a retract move to the start position. Depending on that distance, and the
severity of the angle being probed, this may cause unwanted probe contact during the positioning move
to the second probing position.
Enough clearance should be allowed for this when the user position their probe before running the
cycle.
Once the cycle has been run successfully, Users will be able to obtain the measured angle from the
history window for future reference.
```
If users need to probe the corner of a work piece with one of the corner functions, and the corner to be
probed is on angle, the Find Angle Function should be used first. Once the G 6 8 is set any of the Find
Corner Functions will be executed on the G 6 8 angle that is now set.
```
This Icon represents the Find Angle Y++ Function. To use this function the user will
need to determine the direction and axis of the angle to be probed. In the
Settings/Options window, the Measure Angle Options drop down menu will have these
selections. When the correct angle has been chosen, the image on the Find Angle button
will change to reflect that.
This is Y++ angle.
To set up to use this cycle, the user will jog the probe to the angled surface to
be probed. A manual Z position below the work surface is required as well to
ensure probe contact.
When in position clicking on the Find Angle Button will start the cycle. The
cycle consists of two probing moves. Users will have to use caution where
they position for the first move. When the first probe contact has been made,
there will b a retract move to the start position. Depending on that distance, and the severity of the
angle being probed, this may cause unwanted probe contact during the positioning move to the second
probing position.


<!-- Page 11 -->

Enough clearance should be allowed for this when the user position their probe before running the
cycle.
Once the cycle has been run successfully, Users will be able to obtain the measured angle from the
history window for future reference.
```
If users need to probe the corner of a work piece with one of the corner functions, and the corner to be
probed is on angle, the Find Angle Function should be used first. Once the G 6 8 is set any of the Find
Corner Functions will be executed on the G 6 8 angle that is now set.
```
This Icon represents the Find Angle Y-- Function. To use this function the user will need
to determine the direction and axis of the angle to be probed. In the Settings/Options
window, the Measure Angle Options drop down menu will have these selections. When
the correct angle has been chosen, the image on the Find Angle button will change to
reflect that.
This is Y-- angle.
To set up to use this cycle, the user will jog the probe to the angled surface to
be probed. A manual Z position below the work surface is required as well to
ensure probe contact.
When in position clicking on the Find Angle Button will start the cycle. The
cycle consists of two probing moves. Users will have to use caution where they
position for the first move. When the first probe contact has been made, there
will b a retract move to the start position. Depending on that distance, and the
severity of the angle being probed, this may cause unwanted probe contact during the positioning move
to the second probing position.
Enough clearance should be allowed for this when the user position their probe before running the
cycle.
Once the cycle has been run successfully, Users will be able to obtain the measured angle from the
history window for future reference.
**PRECAUTION**
```
If users need to probe the corner of a work piece with one of the corner functions, and the corner to be
probed is on angle, the Find Angle Function should be used first. Once the G 6 8 is set any of the Find
Corner Functions will be executed on the G 6 8 angle that the machine is now set to. If users only wish
to find and angle, but proceed without a G 6 8 rotation, A G 6 9 in MDI followed by Cycle Start is
required. This will cancel the rotation.
```
This Icon represents the Find Center Function. To use this function the user will need to
determine the center of the pocket to be probed.


<!-- Page 12 -->

To set up to use this cycle, the user will jog their probe to the
“approximate” center of the pocket that to be probed. A manual jog in Z
below the top of the work surface to ensure contact with the probe, is
required as well.
Once in position, clicking the Find Center Button will start the cycle. The
cycle consists of four probe moves.
### 1. The first one is a negative move on the X axis until contact with the
probe has been made.
2. The next move is positive on the X axis until the probe has made contact.
3. A position to the start point is next to set up the first Y probe move. This will be in the negative
direction.
4. The final probe move will be in the positive direction on the Y axis.
When the final probe move is done, the probe will be positioned at the newly set work coordinates
X 0., Y 0.
The offsets are now set for the center of the pocket that has been probed. Users can verify this by
glancing at the history window.
This Icon represents the Find Z Function. Z will be the only axis that will move with this
```
function To use this function and the associated actions the user will need to have the
appropriate tool and its offsets active.
```
There are two different actions with in this function. The actions for Find Z can be set in
the Z Only Options in the Setting/Options window.
The first action is Material Top. When this has been selected,
the user will need to jog the probe to a clearance point over the
top of the work piece. Once in position, clicking the Find Z Button will probe the top of the work
piece. With the Material Top selected, The current work coordinates Z offset has just been set. Users
can verify this in the history window.
```
The second setting for the Find Z function is Tool Length
(TLO).
When this option has been chosen, users will need to make sure
that the tool and the corresponding offsets for that tool are active!!
once the tool or probe is in position, clicking the Find Z Button, will start the cycle. When complete,
the current tool's length offset will be set. Users can verify this by viewing the history window.


<!-- Page 13 -->

```
The last icon in the Functions Window does not have any function associated with it. It
simply depicts the axis directions designated for the probing cycles.
This document is intended for users to better understand the Touch Module and the expected outcomes
of its cycles within Mach 4. Beyond this document, there are help tips built into the Touch module as
well. These can be read by hovering over any of the buttons, or icons while in the Module.
It is still the end users responsibility to Wire and map a successful Probe Signal In Mach 4 .
Understand, and read any and all the documents associated with the “Touch” module.
Touch Module Video

