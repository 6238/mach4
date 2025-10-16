# Newfangled Lathe Turret Standard

*Converted from PDF: Newfangled Lathe Turret Standard.pdf*
*Conversion date: /Users/chondl/learn/mach4/scripts*

---

<!-- Page 1 -->

Mach 4 Lathe Tool Direction
The purpose of this document is to clarify how cutting tools and their respective orientation will
be handled and configured within Mach 4 Lathe.
NOTE**
**During different segments of this article, please refer to the diagram labeled
“dwg 1-1” and “dwg 1-2”.**
## ADDRESSING TOOLS-
Any and all turning tools will be assigned and labeled by their cut direction (primary or
secondary), regardless of their position, tool number, or turret(s).
## PRIMARY TOOL DIRECTION-
Mach 4 Lathe addresses Primary tool cut direction as a tool that (when installed in its respective
tool station) produces a geometry that allows cutting in a standard orientation where the tool paths
(cuts) in X are negative values, toward center line X. (see dgw 1-1, CLx)
## SECONDARY TOOL DIRECTION-
Mach 4 Lathe addresses Secondary tool cut direction as a tool that (when installed in a tool
station) produces a geometry that allows cutting in a non-standard orientation where the tool paths
(cuts) in X are positive values, toward center line X. (see dgw 1-1, CLx).
___________________________________________________________________________________
The “Tool Direction” (TD) of a particular tool will not always be one way or the other. This will
be based on user discretion and/or the physical limitations of the Machine Tool.
Using TD eliminates the caveat of calling a specific turret or a special work station in a G Code
program. A user can easily transfer any program using TD from lathe to lathe seamlessly, as all
programs will be programmed in the primary tool direction. This will also eliminate users having to
define and configure Mach 4 Lathe for their turret layout, as each and every tool essentially becomes
independent in nature and more versatile.
```
The spindle function is automatically addressed as well, as the direction will be the same during
any and every part of all operations (unless defined by the user).
___________________________________________________________________________________
The image dwg 1-1 was drawn to depict all Turret configurations that users Mach 4 Lathe will
encounter. (Front, Rear, Dual independent, Dual same slide turrets)


<!-- Page 2 -->

Because of the intuitiveness of TD the associative tool tip quadrants (which the users would
normally have to change because spindle direction and/or turret station swap) will simply follow the
geometry state of the tool (see dwg 1-2). The tool quadrant of a tool will also determine the appropriate
application of G 4 1, and G 4 2 (see dwg 1-2).
In dgw 1-1, gang tools are depicted for the visual aid of understanding Tool Direction.
**NOTE **
**Tools 6, 7, 8, and 1 0 are depicted upside down in dwg 1-1, due to to the rotation of
the spindle in the drawing.**
Tool Direction concept in Mach 4 Lathe takes virtually all the limitations out of the use of
tooling. They will be limited to the users imagination and or the travel of the machine.
## TOOL DIRECTION EXAMPLE-
T#2 in dwg 1-1 is an indexable drill/ boring bar and we will assume there is an insert on the
back side with the same geometry as the insert that is viable on the top as shown in dwg 1-1. Tool
Direction gives this limitless possibilities without program or tool call out changes. A given part
(besides being drilled), could easily be rough bored using positive tool direction (the insert on the top
side). A user could then implement negative Tool Direction, (with the insert on the back side) and
finish bore the part.
In certain applications, a user may need to turn an outside diameter with an extended tool for
clearance purposes. With a spindle rotation swap, T#2 could be used to turn the OD in the positive
Tool Direction, with the insert on the back side of the drill. The negative Cut Direction instance would
occur with the insert on the top side of the drill on the back side of the part (opposite the rotation arrow
in dwg 1-1).
The concept and theory of Tool Direction in Mach 4 Lathe is intended to be adapted easily for
all users and their equipment for both hobby and industry. The intent of T#2 as the example was to
show the capabilities for just one tool. Not all tools will be able to be utilized in this manor, but
Primary and Secondary Direction settings with a single tool will always be an option.


<!-- Page 3 -->

dwg 1-2 depicts tool tip standard position numbers

