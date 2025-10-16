# Tool Offsets Mach4 Mill

*Converted from PDF: Tool Offsets Mach4 Mill.pdf*
*Conversion date: /Users/chondl/learn/mach4/scripts*

---

<!-- Page 1 -->

Newfangled Standard For Setting Tool Offsets In Mach 4 Mill
This document has been drafted to discuss the supported standard practice and procedure for setting
tool offsets in Mach 4 Mill.
During this tutorial, offsets for the four tools pictured below will be set using the “Z Offset” and the
“Tool Offset” buttons found on the Offsets tab. The Offsets tab can be found several tabs to the right of
the Program Run tab.
From left to right, the tools depicted will be T 1, T 2, T 3, and T 4.
This document will cover setting tool offsets for machines with only one dedicated tool holder or those
that have multiple tools in holders.


<!-- Page 2 -->

The concept of successful “tool offsets” in Mach 4 Mill will be based on three factors:
### 1. A reliable homing method. (either with wired switches or a consistent home-in-place
method)
### 2. The use of a “Master Tool” in tool slot 1. (all other tools will reference Tool 1 in the Z
axis)
### 3. Establishing a fixture offset prior to setting the tool offset. This is the point the tools
will be compared to one another in relationship to the Z axis and then offsets will be set.
Once the machine is under power, homing/referencing should be the first action taken before moving
forward.
Referencing upon any start up will validate any previously set offsets or new offsets to be entered.
```
{ CAUTION USING HOME-IN-PLACE: THE METHOD USED TO GET THE PHYSICAL HOME
```
POSITION MUST BE ACCURATE AND RELIABLE}

Once the homing process is complete, it's now safe to begin setting tool offsets. The term “ Master
Tool” will be used numerous times in this document. The master tool is Tool 1 and will ALWAYS have
zero for its Z tool offset value. All other tools will obtain a Z offset from the master. Any tool can be
used as a master but it is highly recommended to use tool 1. Tool 1 is used in this document.
**IMPORTANT**
For machines that do not have more than one “dedicated” tool holder and/or automatic tool
changers, it is recommended t read and understand the method for setting the “master tool”.


<!-- Page 3 -->

Choosing a Milling Master Tool
In this set up, Tool 1 is a center drill. This is a tool that would be
common in a multi-tool milling machine for tool slot 1. Used to spot
drill any holes, it does not see the abuse that some other tools in a mill
would and would stay stable as a master tool for quite some time.
Please note that the master tool does not have to be limited to a center or
spot drill, but it is a good idea to choose a tool that will stay fairly stable,
especially if users plan on keeping the tool loaded in their machine for a
period of time.
Setting the “Master Tool”
Once a decision has been made on a master tool, that tool should be loaded into the machine's tool
holder. To set offsets for a specific tool, it should be called with a tool change and have its offsets
active.
In the MDI Tab, call a tool change for Tool 1 ; T 1 M 6. Then hit
Cycle Start and follow the prompts to complete the tool change.
Once the tool change is complete in the MDI tab, enter G 4 3 H 1, and
hit Cycle Start. This will activate the tool offset for tool 1. These
commands can also be on the same line.


<!-- Page 4 -->

Once the tool change and activating the offset is complete, a quick
look at the tool information box will confirm this.
Current tool is 1, and the active offset is also 1.
The master tool can now be set.
Tool 1 was loaded in to the tool holder and has
been manually jogged down to the top of the
piece of material that is slated to be machined.
In the picture, a shim is used to finish bringing
the tool down onto the work piece. This is
used as an indicator to know when the tool
begins to touch, and to avoid damaging the tool
on the work piece.
Since Tool 1 is the “Master Tool”, (as discussed
earlier) it will not have a tool offset for Z. It is a
good practice to open the tool table and make sure
there is not an offset in tool 1's length.
During this tutorial, the Z Offset and the Tool Offset buttons will be used to set both the G 5 4 Z offset
and the length offsets for the three other tools. These buttons are located on the Offsets Tab.


<!-- Page 5 -->

Next, set a fixture (G 5 4) offset for Z. This will establish a
reference surface on the Z axis so the Z offsets for tools 2-4 can
be set later. So with Tool 1 on the surface of the stock, use the
“Set Z” button from the Offsets Tab.
Once this button is hit, users should see the Z DRO with
a value of Zero.
This action has now set the fixture offset for G 5 4. It has also established a reference point to which all
remaining tools offset will be set.
This can also be verified by opening the fixture
table and looking at the Z column in the G 5 4
row.
In this tutorial, there is a value of zero in the
Gage Block Height.
(See NOTE 1 at the bottom of this document
for an explanation on using gage block
values when setting a fixture offset.)
Mentioned at the top of this tutorial, machines that are limited to one dedicated tool holder will
be addressed now. Tool 1 is set as the “Master Tool”, and a fixture offset (G 5 4) has been set. In this
case, the tool and fixture set up is done and ready to run the associated program.
Parts programmed using multiple tools will require multiple programs for the individual tools needed
for to complete the job.
Moving forward, this tutorial will discuss setting three more tool offsets (as seen in the image at the top
of this document).
Tool 2


<!-- Page 6 -->

Tool 2 is a drill in this tutorial.

This tool should be called now using M 6.
Its height offset should be activated using G 4 3.
A quick glance at the Tool Information window will verify the tool and the active offset.
Tool 2 has been called and its offsets are active. Using the same method as Tool 1, manually jog tool 2
in position on the work surface using a shim.
Upon reaching the surface of the part with Tool 2, in this
example the Z DRO ends up with a positive value of .
1 7 8 1. This value is the direct difference between the
actual lengths of Tool 1 and Tool 2.


<!-- Page 7 -->

Unlike Tool 1 (the master tool), Tool 2 is going to have a
length offset assigned to it. It will be the value that is in
the Z DRO. To set this offset for Tool 2, the “Tool Offset”
set button will be used. This is located to the right of the
“Z Offset” set button in the Offsets tab.
This tutorial uses a value of zero in the gage block height
for setting the tool offsets.
(See NOTE 2 at the bottom of this document for an
explanation on using gage block values when setting a
tool offset.)
When Tool 2 is in the desired position to set its tool offset,
click on the “Set Tool” button in the Tool Offset window
on the Offsets tab.
There are a few ways to verify this offset has been
set. Since Tool 2's offsets were activated in prior steps,
the Z DRO should display a value of zero.
If the “Tool Offsets Table” button is clicked, the tool table
will open and will be displayed on the screen.
A quick glance at the length column in the Tool 2
row shows that the value that was in the Z DRO,
has been set.
As stated before, this is the actual difference in
physical length between Tool 1 and Tool 2. Mach 4
will now use this value for Tool 2 when it is called
and its Z offset is made active with a G 4 3 H 2.
When in an active offset state, Tool 2 will now
display zero in the Z DRO when the tool is on the
work surface every time that it--and its offsets--are
called in a program.


<!-- Page 8 -->

Tool 3 is an end mill in this tutorial.

This tool should be called using M 6.
Its height offset should be activated using G 4 3.
Aquick glance at the Tool Information window will verify the
tool and the active offset.
Tool 3 has been called and its offsets are active. Using the same
method as the previous tool, manually jog Tool 3 in position on
the work surface using a shim.


<!-- Page 9 -->

Upon reaching the surface of the part with Tool 3,the Z
DRO ends up with a negative value: -2.6 7 8 2. This value
is the direct difference between the actual length of Tool 1
and Tool 3.
Tool 3 is ready to have a length offset applied. It will be the value
that is shown in the Z DRO. To set this offset for Tool 3, the “Set
Tool” button will be used. This is located to the right of the “Z
Offset” set button in the Offsets tab.
This tutorial uses a value of zero in the gage block height for setting the tool offsets.
(See NOTE 2 at the bottom of this document for an explanation on using gage block values when
setting a tool offset.)
. There are a few ways to verify this offset has been set. Since Tool 3's
offsets were activated in prior steps, the Z DRO should display a
value of zero.
If the “Tool Table” button is clicked, the tool table will
open and will be displayed on the screen.
A quick glance at the length column in the Tool 3
row shows that the value that was in the Z DRO, has
been set.
As stated before, this is the actual difference in
physical length between Tool 1 and Tool 3. Mach 4
will now use this value for Tool 3 when it is called
and its Z offset is made active with a G 4 3 H 3.
When in an active offset state, Tool 3 will now
display zero in the Z DRO when the tool is on the
work surface every time that it--and its offsets--are
called in a program.
Tool 4


<!-- Page 10 -->

Tool 4 is also an end mill in this tutorial.

This tool should be called with M 6.
It's height offset should be activated using G 4 3.
A quick glance at the Tool Information window will verify
the tool and the active offset.
Tool 4 has been called and its offsets are active. Using
the same method as the previous tool, manually jog
Tool 4 in position on the work surface using a shim.
Upon reaching the surface of the part with Tool 4 in
this tutorial, the Z DRO displays a negative value:
-1.8 5 9 4.
This value is the direct difference between the actual lengths of Tool 1, and Tool 4.


<!-- Page 11 -->

Tool 4 is ready to have a length offset applied. It will be the
value that is shown in the Z DRO. To set this offset for Tool
4, the “Set Tool” button will be used. This is located to the
right of the “Z Offset” set button in the Offsets tab.
This tutorial uses a value of zero in the gage block height for
setting the tool offsets.
(See NOTE 2 at the bottom of this document for an
explanation on using gage block values when setting a
tool offset.)
Now that Tool 4 is in the desired position to set its tool offset, click on the “Set Tool” button in
the Tool Offset window on the Offsets tab.
There are a few ways to verify this offset has been set. Since Tool 4's
offsets were activated in prior steps, the Z DRO should display a
value of zero.
If the “Tool Table” button is clicked, the tool table will
open and will be displayed on the screen.
A quick glance at the length column
in the Tool 4 row shows that the
value that was in the Z DRO, has
been set.
As stated before, this is the actual
difference in physical length
between Tool 1 and Tool 4. Mach 4
will now use this value for Tool 4
when it is called and its Z offset is
made active with a G 4 3 H 4.
When in an active offset state, Tool
4 will now display zero in the Z
DRO when the tool is on the work
surface when it's offsets are activated after a tool change.


<!-- Page 12 -->

NOTE 1:
As stated above, there were values of zero in the gauge block DRO's for
both “Set Z”, and for “Set Tool” Buttons. “Set Z” will be discussed here.
There are many ways that a value can be used in the Gage Block DRO for
“Set Z”. One common way will be discussed, but does not limit the use.
The picture on the left depicts a T Slot cut part. In this case, the tool needs
to be referenced from the bottom of the T Slot. If (G 5 4) Z is at the bottom
of the slot, the tools will not physically fit down inside the opening for this
and a value would be used now in the Gage Block DRO “Set Z”.
Essentially, if the total depth to the bottom of the T Slot is .5 0 0, the user would simply put a
positive .5 0 0 value in the Gage Block DRO. This means the actual fixture G 5 4 Z Zero is .5 0 0 above
where it actually is. Hitting Enter with the Set Z button, now will set the Z DRO that was previously
zero, to .5 0 0. Now the fixture offset for Z is set for zero at the bottom of the T Slot.
NOTE 2:
In this section, the Gage Block DRO that is associated with the “Set Tool”
button will be discussed. For this example a T Slot cutter will be used . On a
few occasions, users would need to add a value to the Gage Block Height DRO
while setting a tool length.
If the top of this cutter is what is to be referenced for a length offset and the
only available place to touch this tool to the work piece is from the bottom
(like a normal cutting tool), the easiest option would be to use a value in the
Gage Block Height DRO.
In the case of the T Slot cutter, the height for the cutting length is .5 inches.
Jog down to the top of the work piece and, before clicking the “Set Tool”
button, enter a .5 0 0 value in the DRO, then click the Set button.
In this case, a .5 0 0 value passed to the tool table and appear in the Z DRO.
A quick check by jogging the T Slot cutter to Z zero, will reveal that the Tool Reference Surface (as
depicted in the picture on the left) is now Z zero.
Tools 1-4, as well as a “Fixture” Offset, have been set. These tool offsets are now written and stored in
the tool table. Practicing this “Master Tool” method will allow multiple tools to be set up in the tool
table, regardless of how many of them can be mounted on a machine at one time.
This method also allows for very quick transfer from part to part, even if the parts are not similar.
The setting of a Zero Fixture Zero with the master tool will set all preset tools for any job with one
click.
This document's procedures for setting fixture and tool offsets in Mach 4 Mill are the practiced
and supported methods of Newfangled Solutions.

