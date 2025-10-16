# Tool Offsets Mach4 Lathe

*Converted from PDF: Tool Offsets Mach4 Lathe.pdf*
*Conversion date: /Users/chondl/learn/mach4/scripts*

---

<!-- Page 1 -->

Newfangled Standard For Setting Tool Offsets In Mach 4 Lathe
This document has been drafted to discuss the supported, standard practice and procedure for setting
tool offsets in Mach 4 Lathe.
During this tutorial, offsets for the 4 tools pictured below will be set using the “ Tool Offset” setter
button.
From left to right, the tools depicted will be T 1, T 2, T 3, and T 4.
The concept of successful “tool offsets” in Mach 4 Lathe will be based on three major factors:
### 1. A reliable homing method for the X axis. (should be done with a limit switch to ensure
reliability.)
### 2. The use of a “Master Tool” in tool slot 1. (all other tools will reference Tool 1 in the Z
axis)
### 3. Establishing a fixture offset prior to setting the tool offset. This is the point the tools
will be compared to one another and in relationship to the Z axis, and then offsets will be
set.
Once a user has a lathe under power, homing/referencing should be the first action taken before moving
forward. Referencing X upon any start up will validate any previously set offsets or new offsets to be
entered. Home in X should be machine coordinate X Zero.


<!-- Page 2 -->

Because the Z tool offsets used in
Mach 4 Lathe are simply a relationship
between themselves, a fixture offset, and
the master tool, referencing/homing the Z
is not critical. If the machine has a limit or
home switch wired for the Z axis, homing
the Z upon start up will not interfere with
setting offsets. However, if homing the Z
is a habit continue to do it and proceed
with this tutorial.
Once the homing process is complete it is now safe to begin setting tool offsets. The term “ Master
Tool” will be used numerous times in this document. The master tool is Tool 1 and will ALWAYS
have 0 for its Z tool length offset value. All other tools will obtain a Z offset based on the master.
Any tool can be used as a master but it is highly recommended that Tool 1 is used. T ool 1 is used in
this document.
Tool 1 is an outside diameter turning tool with an indexable insert. It is
also a tool that is mostly used for finishing operations and is not subject to the
tool wear that roughing operations produce. This ensures reliable offsets and
a stable tool.
For instance, if a drill is used for Tool 1 and it had to be sharpened,
previously set tool offsets would no longer be accurate.
Setting the “Master Tool”
Once a decision has been made for a master tool, it should be loaded into the lathe's tool holder. To set
offsets for a specific tool, it should be called with a tool change and should
have its offsets active.
In the MDI Tab, call a tool change for Tool 1 ; T 0 1 0 1. Then hit Cycle Start.
Follow the prompts to complete the tool change. The DROs on the screen
should change and reflect Tool 1's offsets. The DRO values may not make
sense, as they are a reflection of the Machine Coordinates.
If the previous step is missed and a tool offset is not active,
Mach 4 will remind users to do so with this message box. If this
shows up, the previous step (calling a tool and its offset) must
be repeated.


<!-- Page 3 -->

Once the tool change is complete, a quick look at the tool information
box will confirm this.
Current tool is 1 and the active offset is also 1.
The master tool can now be set.
Knowing that there are three more tools that need to be set, a piece of stock was loaded in the lathe
chuck so a reference diameter could be established, as well as a fixture offset for Z.
Before setting offsets, look at the tools to be set up and the way they
will be used during operations. At this time Tool Direction should be
set. In the tool table, 7 columns to the right, there is one labeled
“Direction”.
If this field for the tool is empty, the direction should be changed to
either Primary or Secondary.
**There are two choices here that are discussed in a different document: “Primary”and “Secondary”
tool direction**
9 5% of tools will be “Primary Direction” tools.

Mach 4 Tool Direction Document


<!-- Page 4 -->

Tool 1 is loaded in the tool holder and has been used to turn a
1.0” diameter. When the cut is complete, X should not be
moved. Move the tool off the part with the Z axis while the
spindle is still turning.
A reminder: this diameter will be used to set the remaining
tools as well.
Now that the diameter has been turned and measured, enter
the turned diameter in the X DRO above the “SET X
OFFSET” button and then hit enter to set the value in the
DRO.
After the 1.0” value is set in the X DRO, click the “SET X OFFSET” button under the X DRO
in the “Tool Offset Setters” box.
With Tool 1 and the offsets active, this will set the X offset to 1.0.
The “CURRENT X” DRO at the top of the screen should reflect this change and read 1.0.
This has now set the X offset, or diameter,
for Tool 1.
----------------------------------------------------------------------------------------------------------------------------
ALL X OFFSETS SHOULD BE SET USING THIS METHOD.
## THE OFFSETS SET WITH THE SET X BUTTON WILL BE PLACED
IN THE TOOL TABLE BY DEFAULT. DO NOT SET V ALUES FOR X
```
USING THE FIXTURE OFFSET {G 5 4}. THIS WILL CORRUPT ANY
## V ALUES THERE AFTER USING THE SET X BUTTON OR AFTER
HOMING, CAUSING A MACHINE CRASH.
----------------------------------------------------------------------------------------------------------------------------


<!-- Page 5 -->

Since Tool 1 is the “Master Tool” (as discussed earlier), it will not have a tool offset for Z. Next, set a
fixture (G 5 4) offset for Z. This will establish a reference surface on the part in the Z axis to set tools
2-4. Z tool length offsets can be set later.
Tool 1 has been touched off the face of the work piece and is in
position to set the fixture, or G 5 4, offset.
By clicking on the “Zero Fixture Z” button next to the Current Z DRO, the fixture offset has been set
with the Master Tool.
The Current Z DRO should display zero.
In this case, this is just a reference surface
for setting Tools 2-4. If Tools 1-4 had been
set previously., their respective offset
values would have been logged and stored
in the tool table.
This will become the method for setting a Z Fixture offset for any part set up. The values for tool offset
X and Z are stored in the tool table.
A glance at the
“Current Z DRO”
states that G 5 4, or
Z fixture offset, is
zero. Opening
the Fixture
Offsets Table, you
see that the Z
fixture offset for G 5 4 has been set to.5 6 3 7? Why?


<!-- Page 6 -->

If the “Machine Pos
Toggle” button is pressed,
the Z DRO should now
display .5 6 3 7. This is the
relationship between the
Master Tool, Fixture Offset,
and machine coordinates.
This verifies that the fixture offset (G 5 4) that was set is valid and accurate.
Currently, the Master Tool's X offset has been set. A fixture offset (G 5 4) has been established
also maintaining zero for the Master Tool's Z tool length offset.
A quick look at the Tool Table
will verify this.
Move Tool 1 to a safe distance
away from the part to load Tool 2
in the holder.
Tool 2
In the MDI Tab, call a tool change for Tool 2 ; T 0 2 0 2.
Then hit Cycle Start Follow the prompts to complete the tool change.
Tool 2 has been called and its offsets are active.
The offset in X should be set on the turned 1.0” diameter in the
lathe (this value should still be in the SET X OFFSET DRO).
With Tool 2 on the 1.0” diameter,
Click the “SET X OFFSET” Button.
The X, or diameter, offset change should take place.


<!-- Page 7 -->

The 1.0” value should be present in the Current X DRO.
Tool 2 should now be moved into position to set the Z tool offset .
When setting the Master Tool, the “SET OFFSET Z” button was
not used. A fixture offset was set, leaving zero for a value in the
Tool 1's Z offset.
If “SET Z OFFSET” is clicked, while
setting the fixture offset for Tool 1, the
Master Tool, Mach 4 will ask to
continue with this action. The Z Offset
for this tool should be zero.
Setting Z for any tool after the Master
Tool, will use the “SET Z OFFSET”
rather then the “ZERO FIXTURE Z”.
Why? The Master Tool does not (and
should not) have a length associated
with it. It has, however, been used to
establish a reference point for the
fixture, or (G 5 4). Using the “SET Z OFFSET” button for tools after 1 will set their Z offsets in
relationship to the Master Tool's length of zero. Therefore, once these values are established, the math
will be be done by Mach 4 as a comparison between the called tool Z offset that will show up in the
“Current Z DRO”, the Master Tool's”offset, and the Fixture Z offset (G 5 4). Once set, this will happen
every time the tool is called.
With Tool 2 in place to set it's Z Length offset, the
“Current Z DRO” has a value of -.6 5 3 (in this example).
This is the actual difference in length between Tool 2 and
the Master Tool.


<!-- Page 8 -->

To set Tool 2's Z offset (or the current fixture offset) to zero , click on the “SET Z OFFSET” button.
Normally, the value in the “SET Z OFFSET DRO” should be left at zero. There are a few instances
where the user would have to enter a value in this DRO.
If the tool being set can be set from the “common surface”, then there is no need for a value in the
DRO. If the tool being set physically cannot be set from the “common surface”, then the value of the
difference from the surface the user can use and the “common surface” should be entered in the DRO.
Example: if a tool has geometry that requires the user to use a .5 0 0 gauge block between it, and the
“common surface”, then the .5 0 0 gauge block thickness should be entered into the “SET Z OFFSET”
DRO. The math done in this case will take into consideration the .5 0 0 value and will set the tool's Z
offset to the actual “common surface.” There are many other situations like this which will be
discussed in advanced Lathe tool documents and/or videos.
Once “SET Z OFFSET” is clicked, the “Current Z DRO”
now has a value of zero. This has set Tool 2's Z length
offset to be zero at the fixture offset zero (G 5 4).
Also a quick look at the tool table will show -.6 5 3 has been set for Tool 2 in the Z. This is the
difference as seen before in the “Current Z DRO.” When Tool 2 is called, Mach 4 will now use this
value from the tool table in the calculations to keep Tool 2's Z at fixture Z zero (or G 5 4). The new
value is highlighted in green.
The Master Tool, a
fixture offset, and
Tool 2's offset have
now been set. The next
two tools will mimic
the process of Tool 2's offset set up.
## TOOL 3


<!-- Page 9 -->

In the MDI Tab, call a tool change for Tool 3 ; T 0 3 0 3. Then hit Cycle
Start. Follow the prompts to complete the tool change.
Jog Tool 3 to the 1.0” turned diameter.
Set the X DRO to 1.0”.
Click the “SET X OFFSET” button. X for Tool 3 is set and should
reflect in the current X DRO.
Jog Tool 3 into position to set the Z tool offset.
Current Z DRO displays the difference in Z as compared
to the Master Tool.


<!-- Page 10 -->

Click on the “SET Z OFFSET” button.
The “Current Z DRO” should reflect this change.
A quick look at the Tool Table shows Tool 3's Z offset is now set to -.2 5 2 3.
Tool 3's offsets are now set.
## TOOL 4
In the MDI Tab, call a tool change for Tool 4 ; T 0 4 0 4. Then hit Cycle
Start. Follow the prompts to complete the tool change.
Jog Tool 4 to the 1.0” turned diameter.


<!-- Page 11 -->

Be sure the SET X DRO is set to 1.0” then click the “SET X OFFSET”
button.
X for Tool 4 is set, and should
reflect in the “Current X DRO.”
--------------------------------This is an ID cutting tool----------------------------------
The gauge block depicted is used to align the cutting tip with the 1.0”
diameter.
Jog Tool 4 into position to set the Z tool offset.
“Current Z DRO” displays the difference in Z as
compared to the Master Tool.
Click on the “SET Z OFFSET” button.
The “Current Z DRO” should reflect this change.


<!-- Page 12 -->

A quick look at the Tool Table. 1.1 5 6 5 has been set to Tool 4's Z offset table.
Tool 4's offsets are now set.
Tools 1-4, as well as a fixture offset, have been set. These tools' offsets are now written and stored in
the tool table. They will not change unless they are changed by the user. Practicing this Master Tool
method will allow users to easily have multiple tools set up in their tool table regardless of how many
of them can be mounted on a machine at one time.
This method also allows for very quick transfer from part to part, even if the parts are not similar.
The setting of a Z Fixture Zero with the master tool will set all preset tools for any job with one click.
This document's procedures for setting fixture and tool offsets in Mach 4 Lathe are the practiced
and supported methods of Newfangled Solutions.
**Click on the link below to view to associated video**
## MACH SUPPORT CHANNEL

