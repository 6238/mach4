# Operation Manual - Industrial

*Converted from PDF: Operation Manual - Industrial.pdf*
*Conversion date: /Users/chondl/learn/mach4/scripts*

---

<!-- Page 1 -->

Mach 4 Industrial
Mill Operations Guide
1


<!-- Page 2 -->

Copyright © 2 0 1 4 Newfangled Solutions, Artsoft USA, All Rights Reserved
The following are registered trademarks of Microsoft Corporation: Microsoft, Windows. Any other
trademarks used in this manual are the property of the respective trademark holder.
Table of Contents
1 Introducton................................................................................................................................................................. 4
1.1 Before You Begin.................................................................................................................................................. 4
1.2 What is Mach 4?.................................................................................................................................................... 4
1.3 How Do I Get My Drawing Into Mach 4? ............................................................................................................... 5
1.4 Typical CNC Cutng grocess ................................................................................................................................. 5
2 Screen Layout and Controls ......................................................................................................................................... 6
2.1 Menu Bar.............................................................................................................................................................. 7
2.1.1 File Menu.............................................................................................................................................................. 8
2.1.2 View Menu............................................................................................................................................................ 9
2.1.3 Confgure Menu.................................................................................................................................................... 9
2.1.4 Diagnostc Menu................................................................................................................................................. 1 0
2.1.5 Wizard Menu....................................................................................................................................................... 1 0
2.1.6 Operator Menu................................................................................................................................................... 1 1
2.1.7 Help Menu........................................................................................................................................................... 1 2
2.1.8 Operaton Mode Tabs ......................................................................................................................................... 1 3
2.1.9 grogram Run Tab................................................................................................................................................. 1 3
2.1.1 0 MDI Tab............................................................................................................................................................. 1 4
2.1.1 1 Tool gath Tab.................................................................................................................................................... 1 5
2.1.1 2 Diagnostc Tab................................................................................................................................................... 1 6
2.2 Operator Control Tabs ........................................................................................................................................ 1 6
2.2.1 File Ops Tab................................................................................................................................................. 1 7
2.2.2 Run Ops Tab................................................................................................................................................ 1 8
2.2.3 Tool gath Ops Tab ....................................................................................................................................... 1 8
2.2.4 Jogging Tab.................................................................................................................................................. 1 9
2.2.5 Trace
Tab...............................................................................................................................................................2 0
3 Getng Started........................................................................................................................................................... 2 0
3.1 Enabling the System ........................................................................................................................................... 2 2
3.2 Home the Machine ............................................................................................................................................. 2 3
3.3 Jogging................................................................................................................................................................ 2 3
3.4 Changing Tools.................................................................................................................................................... 2 4
3.5 Fixture Ofsets Tab .............................................................................................................................................. 2 6
3.5.1 grobing Tab................................................................................................................................................. 2 6
3.5.2 Inputng Fixture Ofset Values ................................................................................................................... 2 7
2


<!-- Page 3 -->

3.6 Tool Length Ofsets ............................................................................................................................................. 2 9
3.6.1 Master Tool................................................................................................................................................. 3 1
3.6.2 Tool Length from Gage Line ........................................................................................................................ 3 2
3.7 Tool Diameter Ofsets ......................................................................................................................................... 3 3
3.8 Tool Wear Ofsets............................................................................................................................................... 3 3
3.9 Tool Informaton................................................................................................................................................. 3 3
3.1 0 Creatng grograms ........................................................................................................................................... 3 4
3.1 0.1 Mill Wizard................................................................................................................................................ 3 4
4 Running the Machine ................................................................................................................................................. 3 8
4.1 Manual Data Input (MDI) .................................................................................................................................... 3 8
4.2 Loading a G Code grogram ................................................................................................................................. 3 9
4.3 Viewing the Tool gath ......................................................................................................................................... 3 9
4.4 Editng a G Code grogram ................................................................................................................................... 3 9
4.5 Closing a G Code grogram .................................................................................................................................. 3 9
4.6 Executng a G Code grogram .............................................................................................................................. 4 0
4.6.1 Cycle Start.................................................................................................................................................... 4 0
4.6.2 Feed Hold.................................................................................................................................................... 4 0
4.6.3 Stop............................................................................................................................................................. 4 0
4.6.4 Reset............................................................................................................................................................ 4 0
4.6.5 Startng from the Middle of a grogram ....................................................................................................... 4 0
5 Help, I’ve Crashed….................................................................................................................................................... 4 1
5.1 Limit Switches..................................................................................................................................................... 4 2
5.2 Sof Limits........................................................................................................................................................... 4 2
5.3 greventng the Inevitable ................................................................................................................................... 4 3
3


<!-- Page 4 -->

1 Introduction
The purpose of this manual is to teach the basic operaton and functonality of the Mach 4 CNC control
sofware. This manual is based on the core Mach 4 product using the standard screen set. The
appearance of the interface may vary depending on the machine builder. Mach 4 includes a screen
designer that allows manufactures and operators to create custom screen layouts for their specifc need.
More informaton on the screen designer can be found in the customizaton manual. grogramming and
confguraton also have their own respectve manuals which must be read before setng up and running
a Mach 4 controlled machine.
## 1.1 Before You Begin
Any machine tool is potentally dangerous. Computer controlled machines are
potentally more dangerous than manual ones because, for example, a computer is uuite
prepared to rotate an 8" unbalanced cast iron four-jaw chuck at 3 0 0 0 rpm, to plunge a
panel-felding router cuter deep into a piece of oak, or to mill away the clamps holding
your work to the table. Because we do not know the details of your machine or local
conditons we can accept no responsibility for the performance of any machine or any damage or injury
caused by its use. It is your responsibility to ensure that you understand the implicatons of what you
design and build and to comply with any legislaton and codes of practce applicable to your country or
state. If you are in any doubt, be sure to seek guidance from a professionally uualifed expert rather than
risk injury to yourself or to others.
1.2 What is Mach 4?
Mach 4 is sofware that operates on a personal computer to create a powerful and cost efcient CNC
controller. It makes up one small piece of a computer numerical control (CNC) machine. Machines can
range from basic mills and lathes to wood routers, plasma cuters, mult axis machining centers, uuiltng
machines, anything reuuiring moton control. The system is capable of interpretng multple
programming languages, the default and most common being G code, to provide instructons for
machine movement and other functons. These instructons are passed to an external moton device
which in turn controls all the inputs and output signals and moton.
Mach 4 is designed to be fexible and adaptable to a wide variety of machines. gart of this fexibility is
the ability for hardware and sofware developers to create addons or plugins for Mach 4 to expand its
capabilites. Addons are small programs installed into the Mach 4 directory that give Mach the ability to
talk to hardware devices such as moton controllers and pendants, communicate with other sofware,
add additonal wizards or conversatonal machining functons, or anything a developer can dream up.
Addons to Mach 4 are so diverse it would be impossible to cover them in this manual. The developer
should provide detailed informaton on the installaton, confguraton and use of their addon or plugin.
1.3 How Do I Get My Drawing Into Mach 4?
Mach 4 cannot directly interpret drawings. Mach 4 is moton (motor) control sofware.
General process
1) gart is drawn in a computer aided design (CAD) program.
4


<!-- Page 5 -->

2) Resultng fle transferred into a computer aided manufacturing (CAM) program to create the tool
paths for machining.
3) The CAM program uses a post processor to generate a formated G code program from the tool paths
created in the sofware for Mach
4) The G code program is then loaded and executed by Mach 4.
*This is only one method of creatng a G code program, they can also be manually writen or created
with a wizard or conversatonal program. The wizards in Mach are essentally simple graphical CAM
programs designed to easily create programs for basic shapes and tasks.
## 1.4 Typical CNC Cutting Process
5


<!-- Page 6 -->

2 Screen Layout and Controls
The standard Mach 4 screen is designed to be easy to navigate for frst tme users. Figure 2-1 shows the
layout of the main page. This is the screen that will be loaded when Mach 4 Gui.exe is launched and the
Mach 4 Mill profle is selected. Each part will be discussed in more detail in separate sectons.
Figure 2-1: Mach 4 screen layout.
Menu Bar: Contains drop down menus similar to many programs. Optons here range from
loading programs, confguraton of Mach 4 and its plug-ins and exitng the program.
Operation Mode Tabs: These tabs select the operaton mode of Mach 4 and change the layout
of the upper half of the screen based on the selecton made.
Program Execution Controls: Cycle Start, Feed Hold and Stop butons to control the executon of
loaded G Code programs or MDI programming.
Reset: The Reset buton returns the control to its default state and rewinds the program.
Enable/Disable: The enable buton does just that, it enables Mach 4. The control must be
disabled before any confguraton changes can be made.
Status Bar: Shows the current state of the modal G Code groups.
Message History: Displays a window that shows the history of messages displayed in the
message bar and recent buton pushes.
Message Bar: Displays Mach 4 errors and comments from a program or script.
6


<!-- Page 7 -->

Operator Control Tabs: Display a variety of butons for control of loading and editng programs,
running of programs, tool path display and jogging.
Current Tool Data: Displays current tool number and ofset data.
Active Profile: Displays the name of the current profle.
Actual Feedrate: Displays the current actual feed rate, this could difer from the programmed
feed rate depending on the setng of the feed rate override controls.
Override Controls: grovide control over the feed rate, rapid and spindle speed overrides.
Spindle Control: Spindle on/of buton.
## 2.1 Menu Bar
The menu bar in Mach 4 consists of drop downs that provide access to, among other things,
confguraton setngs, diagnostcs, and ofset informaton.
2.1.1 File Menu
The fle menu contains commands for opening and closing G code fles and exitng the program (see
fgure 2-2).
Figure 2-2: File menu
New Gcode File: Selectng this opton opens the G code editor with a new blank fle. A program
can then be manually typed in by the user and saved for later executon.
Recent Files: Display a list of the most recently opened G code fles. Select one from the list to
load it into Mach 4 for executon.
Open Gcode File: Opens the “Select File” dialog, fgure 2-3. The user can then navigate to the
desired G code fle to select and open it in Mach 4.
7


<!-- Page 8 -->

Figure 2-3: Select file
Close Gcode File: Closes the currently loaded G code fle.
Exit: Exits Mach 4.
2.1.2 View Menu
The view menu, fgure 2-4, contains controls for changing the current display.
Figure 2-4: View menu
Load Screen: Opens a dialog that allows the user to choose a new screen, or display.
Full Screen: guts Mach 4 into full screen mode. Mach 4’s display will be enlarged to cover the
entre display.
Fixture Ofsets: Displays the fxture ofset table, more informaton is available in the fxture
ofset secton of this manual.
Tool Table: Displays the tool ofset table, more informaton is available in the tool ofset secton
of this manual.
8


<!-- Page 9 -->

Windows: grovides optons for what toolbars are displayed when in the screen editor mode.
The screen editor and its associated functons are explained in the customizaton manual.
2.1.3 Configure Menu
The confgure menu, fgure 2-5, provides access to Mach and glugins confguratons. Confguraton
setngs are disabled when Mach 4 is enabled. To allow access to these setngs, frst disable the
controller. More detailed informaton on these setngs can be found in the Mach 4 CNC Controller
Confguraton Manual.
Figure 2-5: Configure menu
Select Motion Dev: Use this menu opton to select the external moton device that is to be used.
Mach: Opens a window that displays all of Mach 4’s confguraton setngs. This is where all
motor and input and output setngs are entered.
Plugins: Opens a window that lists all installed plugins and provides access to each plugin’s
confguraton setngs.
PMC: grogrammable Machine Control is a later logic style control for Mach 4 interface.
2.1.4 Diagnostic Menu
The diagnostc menu, fgure 2-6, provides functons for logging and viewing the status of inputs and
outputs. Any installed plugins may have their own diagnostc, varying the contents of this menu based
on the machine confguraton. Some of the optons shown may not be discussed in this manual as they
are 3 rd party plugin diagnostcs. The menu items should be covered in detail in the manual provided by
the developer of the plugin.
Figure 2-6: Diagnostic menu
9


<!-- Page 10 -->

Logging: Opens the logging facility. This is handy error checking tool that logs events in Mach 4
in real tme. The machine builder can choose what gets logged, so each machine may log events
diferently.
Modbus: Opens a window that shows the current state of Modbus communicatons.
Regfile: Opens a window that displays the current value of a variety of registers and variables in
Mach 4. The contents and range of what is displayed here will vary with each machine build.
2.1.5 Wizard Menu
The wizard menu, fgure 2-7, provides access to the pick wizard window (fgure 2-8). Any installed
wizards can be found here. A wizard is a small program that allows a user to easily generate G code for
common or moderately complex machining processes. Wizards and their capabilites can be as varied as
the programmers that write them.
Figure 2-7: Wizard menu
Figure 2-8: Load wizard window
2.1.6 Operator Menu
The operator menu, fgure 2-9, provides the operator with optons for editng the Mach 4 interface and
Lua scriptng. The screen editor and an overview of Lua can be found in the customizaton manual.
1 0


<!-- Page 11 -->

Figure 2-9: Operator menu
Lock: Locks the screen from being edited, a password is reuuired to unlock.
Unlock: Unlocks the screen for editng, a password is reuuired.
DRO Auto Calc: A calculator for a DRO by double clicking in the box to preform any
mathematcally calculaton for values of the DRO
Jog Trace: An onscreen display in the toolpath window, showing jog movements
Edit Screen: Switches Mach 4 to the screen editng mode, see fgure 2-1 0.
Figure 2-1 0: Mach 4 screen editor
Edit/Debug Scripts: Opens the Lua editor for editng scripts saved as macros, such as custom M
codes.
1 1


<!-- Page 12 -->

Open Script Editor: Opens the Lua Script and enables for edits.
View Screen Script: Displays the Lua script that controls the screen.
Select Language: Allows for the selecton of diferent languages then the default.
2.1.7 Help Menu
The help menu, fgure 2-1 1, is where the operator will fnd the “About” page, fgure 2-1 2.
Figure 2-1 1: Help menu
Support: Allows for the current screen set to be emailed and shared. Support also provides
access to the Newfangled Solutons Website for additonal help.
About: Opens a window that displays informaton about Mach 4 and the computer it is installed
on. The about screen indicates what version of Mach 4 is installed, Lite, Hobby, Industrial, etc.
Next is the version number, followed by the build number. The g CID is reuuired for licensing.
The g CID is based on the confguraton of the computer Mach 4 is installed and the license will
be locked to that g CID / computer system. Copy the g CID number by clicking on the “Copy ID To
Clipboard” buton. Use the “Load License File” buton to load a license fle received from
Artsof.
Figure 2-1 2: About window
1 2


<!-- Page 13 -->

2.1.8 Operation Mode Tabs
The operaton mode tabs allow the user to navigate between program run, manual data input (MDI) and
diagnostcs. Click on a tab to change the view in Mach 4 and change modes.
2.1.9 Program Run Tab
The program run tab, fgure 2-1 3, is the default on startup. This tab displays the current G code fle, a
plot of the tool path and current positon.
Figure 2-1 3: Program run tab
Operation Mode Selection: These are the tab markers, select the desired tab by clicking on its
name.
G Code Window: Displays the current G code fle.
Go to Zero: Moves machine to X 0, Y 0 in the actve fxture ofset.
Position Display Mode Selection: Changes the contents of the positon display. The “To Go”
buton changes the display to show the distance to go to the programmed point. The “Machine
Coordinates” buton changes the display to show the machine coordinate system. The LED
above each buton will light up when the buton is actvated. If neither LED is on the display
shows the current positon in the actve fxture ofset.
1 3


<!-- Page 14 -->

Reference All: References/Homes all axes in the order set on the Homing/Sof limits tab in the
Mach confguraton. The axes will move to the home switches and machine zero set.
Zero Axis: The zero axis butons will set the current positon to zero in the actve fxture ofset.
This sets the actve fxture ofset and will over write any data that was entered previously.
Reference Status LEDs: When an axis is referenced or homed its status LED will change from red
to green.
Position Display: The digital readouts (DROs) display positon data as selected by the display
mode butons.
Tool Path Window: The tool path window displays the programmed path for the currently
loaded G code fle . Below it are some basic controls for the display.
Display Mode: This buton toggles the display of the sof limits in the tool path window.
Showing the extents of the sof limits can provide visual reference of where the program is in
the machine travel and if it fts.
2.1.1 0 MDI Tab
Manual Data Input, or MDI, is a mode that allows the user to manually type in blocks of G code to be
executed. A block is a single line of G code containing multple words, each started with a leter or
symbol. The code is executed by pressing the cycle start buton.
Figure 2-1 4: MDI tab
Operation Mode Selection: These are the tab markers. Select the desired tab by clicking on its
name.
Reference All: References/Homes all axes in the order set on the Homing/Soflimits tab in the
Mach confguraton. The axes will move to the home switches and machine zero set.
Zero Axis: The zero axis butons will set the current positon to zero in the actve fxture ofset.
This sets the actve fxture ofset and will over write any data that was entered previously.
1 4


<!-- Page 15 -->

Reference Status LEDs: When an axis is referenced or homed its status LED will change from red
to green.
De-Ref All Axes: This buton sets all axes to an un-referenced state.
Manual Data Input Window: Manually input G code to be executed in this window. Multple
lines can be entered. The up and down arrows to the lef scroll through the history of executed
code.
Position Display Mode Selection: Changes the contents of the positon display. The “To Go”
buton changes the display to show the distance to go to the programmed point. The “Machine
Coordinates” buton changes the display to show the machine coordinate system. The LED
above each buton will light up when the buton is actvated. If neither LED is on the display
shows the current positon in the actve fxture ofset.
Position Display: The digital readouts (DROs) display positon data as selected by the display
mode butons.
2.1.1 1 Tool Path Tab
The tool path tab, fgure 2-1 5, is a simple display with a tool path window dominatng the screen.
Figure 2-1 5: Tool path tab
Operation Mode Selection: These are the tab markers. Select the desired tab by clicking on its
name.
G Code Window: Displays the current G code fle.
Position Display: The digital readouts (DROs) display positon data as selected by the display
mode butons. There are not positon display mode butons on this tab, the display will be
changed based on the state of the butons on the grogram Run or MDI pages.
Tool Path Window: The tool path window displays the programmed path for the currently
loaded G code fle.
1 5


<!-- Page 16 -->

2.1.1 2 Diagnostic Tab
In the diagnostc tab, fgure 2-1 6, the operator can view the status of inputs and outputs as well as
individual axis homing.
Figure 2-1 6: Diagnostic tab
Operation Mode Selection: These are the tab markers. Select the desired tab by clicking on its
name.
Input Status LEDs: LEDs show the status of a variety of inputs to Mach 4.
Output Status LEDs: LEDs show the status of a variety of outputs from Mach 4.
Axis Homing: Butons to home individual axes and status LEDs to show the reference status.
## 2.2 Operator Control Tabs
These tabs give the operator control of G code fle loading and editng, program executon opton, tool
path and jogging.
2.2.1 File Ops Tab
The fle operaton tab, fgure 2-1 7, displays controls to afect the current G code fle. Here the operator
can select which fle to load, where to start program executon and edit the G code fle.
Figure 2-1 7: File ops tab
1 6


<!-- Page 17 -->

Operator Control Selection: These are the tab markers. Select the desired tab by clicking on its
name.
Current G Code File: Displays the fle path and name of the current G code fle.
Edit G Code: The edit buton opens the current G code fle in the G code editor. The operator
can then make changes to the program. When the editor is closed the G code fle is reloaded
into Mach 4.
Load Recent G Code: Opens a window that displays a list of the most recently loaded G code
fles. A fle can be selected to be loaded into Mach 4.
Close G Code: Closes the current G code fle.
Load Wizards: The “Load Wizards” buton opens a window that displays all the installed wizards
available to the user, select one and press “OK” to run the wizard. “Load Last Wizard” loads the
last wizard that was run.
Load G Code: Opens a window to search for a G code fle to be loaded into Mach 4.
Run From Here: Opens a wizard to aid in startng program executon from anywhere in the
program. This functon is described in greater detail later in this manual.
Line: Displays the current line in the G code fle. This is the line being currently executed by the
controller.
Regenerate Tool Path: This buton regenerates or refreshes the display. When pushed the tool
path will be recalculated with any changes.
Set Next Line: Sets the line to start program executon from.
2.2.2 Run Ops Tab
The run operatons tab, fgure 2-1 8, gives the operator control of how a G code fle is executed. Optons
such as single block, block delete, and optonal stop can be turned on or of. The program can be
rewound or run in reverse.
Figure 2-1 8: Run ops tab
1 7


<!-- Page 18 -->

Operator Control Selection: These are the tab markers, select the desired tab by clicking on its
name.
Single Block: Actvates single block mode, the LED will light when actve. In single block mode
Mach 4 will execute only one line, or block, of code for every press of the cycle start buton.
Flood Coolant: Turns on the food coolant output.
Optional Stop: When actvated program executon will pause at M 0 1 in the program.
Block Delete: It is possible to skip lines, or blocks, or a program using the block delete. When
actvated any block startng with a slash, “/”, will be ignored by Mach 4.
Mist Coolant: Turn on the mist coolant output.
2.2.3 Tool Path Ops Tab
The tool path operaton tab, fgure 2-1 9, contains tools for controlling the tool path display.
Figure 2-1 9: Tool path ops tab
Operator Control Selection: These are the tab markers. Select the desired tab by clicking on its
name.
Regenerate Toolpath: Reloads the program and recalculates the tool path.
Display Mode: Toggles the display of the sof limits.
Jog Follow: When actve the center of the tool is locked to the center of the tool path display.
The display will follow tool movement.
Perspectives: Several butons allow for diferent perspectves of the toolpath including the
default Top view.
2.2.4 Jogging Tab
The jogging tab, fgure 2-2 0, displays controls for jogging the machine’s axes and changing the jog mode.
1 8


<!-- Page 19 -->

Figure 2-2 0: Jogging Tab
Operator Control Selection: These are the tab markers. Select the desired tab by clicking on its
name.
Soft Limits: Actvates or deactvates the sof limits. Sof limits are exactly as the same implies,
sofware limits to contain machine motons. These are usually set just inside of the actual limit
switches. Sof limits are set up in the Homing/Sof limits tab in the Mach confguraton.
Axes Limit Override: If a limit switched is tripped moton is disabled. This can cause a problem
trying to move the machine of the limit. The limit override essentally ignores the limit switches
untl they are deactvated. Extreme cauton should be used when actvatng the limit override, it
is possible to overrun the switch and cause damage to the machine.
Jog Butons: Butons to jog X, Y, s and A axes.
Cycle Incremental Jog Distance: In incremental jog mode each press of an axis jog buton will
move the machine on a specifed distance, this buton cycles through the distances defned in
the general confguraton. The current step distance in shown in the adjacent DRO.
Toggle Jog Mode: Toggles between contnuous and incremental jog modes.
Jog Rate: Sets the velocity for contnuous jog as a percentage of the machine’s max velocity.
Toggle Keyboard Jog: Turns on/of the ability to jog using the keyboard.
2.2.5 Trace Tab
1 9


<!-- Page 20 -->

Figure 2-2 1: Trace Tab
Trace tab gives users the opportunity to create a G Code fle using an existng template, with or without
preexistng dimensions set. By jogging axes to the desired shape using the on screen butons.
Start Trace: To begin jogging enable start trace. When End Trace is selected a prompt will
appear to close the profle with a line, to enclose the shape just made
Rapid End Point: Rapid end point allows for movement to a diferent area of the screen without
cutng the material
Line End Point: Straight movements from the current point to the selected point, in a direct cut
Arc Mid Point: Afer selectng the Arc Mid goint the buton will change to Arc End goint to allow
for a complete arc to be traced and fnished
2 Point Circle: Selectng the center of the circle and one additonal point along the outside of the
circle
3 Point Circle: Creatng a circle by selectng three points along the radius of the existng circle
Plate Alignment: Adjustng for an uneven material in the workspace to allow for the proper
alignment of the trace tool, regardless of the materials positon on the machine
For more informaton and descripton of how to use the trace tab, go to our ofcial You Tube page Mach
Support. Direct link: htps://www.youtube.com/watch?v=tt-4 hu KA 6 8j Itt=t 3 3 3 s
3 Getting Started
How to start Mach 4 will vary depending on the installaton. In all cases there will be a Mach 4 GUI.exe
located in the Mach 4 folder usually located on the C drive. Some machines may have a shortcut to this
executable on the desktop. When Mach 4 is started the user will be presented with an opton to choose
a profle, fgure 3-1.
2 0


<!-- Page 21 -->

Figure 3-1: Select profile window
In the select profle window, the user can choose a profle to open, create a new profle from scratch,
copy an existng profle, restore a profle or delete a profle. Once a machine is set up, using a shortcut
to run a specifc profle is ofen convenient. Create a shortcut to Mach 4 GUI.exe on the desktop. Right
click on the shortcut and select propertes. In the propertes dialog, fgure 3-2, the Target is the fle that
will be run. This should read the locaton of Mach 4 GUI.exe. Add “/p proflename” to the end of this line,
replacing “proflename” with the name of the desired profle. The shortcut will open Mach 4 into the
named profle.
Figure 3-2: Shortcut properties dialog
2 1


<!-- Page 22 -->

## 3.1 Enabling the System
Once open the user will be presented with Mach 4 in the disabled state. The system must be enabled
before any operaton of the machine can take place. Enable the controller by pressing the fashing
green enable buton in the lower lef corner of the screen. Figures 3-3 and 3-4 show Mach 4 in its
disabled and enabled states, respectvely.
Figure 3-3: Mach 4 main screen in disabled state
Figure 3-4: Mach 4 main screen in enabled state
2 2


<!-- Page 23 -->

Notce that when Mach 4 is disabled butons that control moton or program executon are unavailable
to the user, they are greyed out. On this main screen these controls are “Ref All Home”, “Goto sero”,
“Cycle Start”, and “Reset”. Once enabled these controls are made available to the user.
## 3.2 Home the Machine
The vast majority of machines running Mach sofware use incremental encoders for positon feedback,
some have no positon feedback to Mach. As a result, when Mach 4 is started and enabled, the control
has no idea where the machine is positoned. To determine the locaton of the machine Mach 4 uses a
referencing seuuence started by pressing the “Ref All Home” buton. Before pressing the reference all
buton ensure that no axis is on its home switch, jog the machine away from the switch if necessary.
Each axis is sent to its home positon, signaled by the actvaton of a switch, in the order set in the
homing and limits confguraton. When the home positon is found the DROs in Mach will be updated to
the desired machine positon, usually 0 for all axes. The machine is now ready to run.
## 3.3 Jogging
Manual jogging allows the operator to move the machine around using on screen controls, fgure 3-5,
the keyboard, or an atached control panel / pendant (see fgure 3-6). To view the onscreen controls,
click on the jogging tab on the screen.
Figure 3-5: Manual Jog buton
Jogging is enabled whenever the controller is enabled and a program is not being executed. However,
keyboard jog defaults to of for safety. The default screen provides controls for jogging 4 axes; X, Y, s,
and A. These controls work just like a physical buton, in contnuous jog mode the machine will move as
long as the buton is held down. Keyboard jogging is deactvated by default, this feature can be
actvated by pressing the “Keyboard Jog” buton. The default jog butons are lef arrow for X-, right
arrow for X+, up arrow for Y+, down arrow for Y-, page up for s+ and page down for s-.
There are 2 basic jog modes which are selectable by pressing the “Jog Mode” buton. The current
selecton will be indicated by an LED. Figure 3-5 shows the contnuous mode selected. In contnuous
mode the machine will move at the specifed jog rate as long as a jog buton is held down. The jog rate
can be changed by moving the slider at the botom of the jogging tab or by directly typing the desired
rate into the DRO in the botom right corner. The number shown in the DRO is a percentage of the max
velocity, or rapid rate, of the machine. Contnuous mode is useful for moving the machine relatvely
2 3


<!-- Page 24 -->

large distances and rough positoning. When fnding the edge of a work piece, locatng a hole, or other
precision positon is reuuired, step jog is much more accurate. In step jog, the machine moves only by
the specifed increment amount, regardless of how long the jog buton is held down. The jog increment
can be changed by pressing the “Cycle Jog Inc” buton. This buton will change the DRO to the right of it
to show the current increment amount. The increment values can be changed on the General tab in the
Mach confguraton.
Figure 3-6: Control panel and pendant examples
## 3.4 Changing Tools
Tool changes will vary depending on machine confguraton. Some machines have automatc tool
changers, while others reuuire the operator to physically change the tool. Each type of tool changer
must be confgured properly in Mach 4, this is covered in the confguraton manual. For automatc tool
changers, a Lua script will likely be reuuired to command it or communicate between an external
controller and Mach 4. Scriptng is covered in a separate scriptng manual.
## 3.5 Fixture Ofsets Tab
Figure 3-7: Ofsets Tab
2 4


<!-- Page 25 -->

Fixture ofsets are used to tell the machine where a work piece is located. The values are stored in the
fxture ofset table, fgure 3-6. These values ofset the machine coordinate system to create a user
coordinate system at the desired point. Ofsets are actvated by calling the corresponding G code in the
program. See the programming manual for details on calling fxture ofsets. G 5 4-G 5 9 are the standard
fxture ofsets with G 5 4.1 g 1 through G 5 4.1 g 2 4 8. There are also two additonal ofsets in the table
Work Shif and Head Shif. Values in work shif will shif the entre table, this can be useful when test
running programs (the s axis can be lifed slightly more than the max depth of the program to run above
the part) or making adjustments without changing ofset values. The work shif is always actve, so
when changed, it is important to remember a change has been made. Changing fxture ofsets in the
program will not deactvate work shifs. Head shif is used for mult head/mult spindle machines and
not covered in this manual.
Figure 3-8: Fixture ofset table
There are a variety of ways to fnd a work piece in the machine; edge fnding is probably the most
commonly used method and will be covered in this manual. grobing is a great method when available,
sometmes all that is reuuired is to visually jog the machine to positon and zero it. The accuracy
reuuired is determined by the reuuired part accuracy.
3.5.1 Probing Tab
2 5


<!-- Page 26 -->

Figure 3-9: Probing Tab
Edge Finding
Edge fnders, fgure 3-1 0, come in many shapes and styles, each specialized for specifc applicatons. The
type used for examples in this manual are highlighted in fgure 3-1 0. The shaf diameters can vary, but
the tp diameter is 0.2 0 0 inch, making the math for calculatng the ofsets very easy.
Figure 3-1 0: Edge finders
An edge fnder is used by spinning it at a low Rg M, usually 1 0 0 0 is perfect. The tp of an edge fnder is
held in place under spring tension and is moveable. In fgure 3-1 1 all the edge fnders are shown with
the tp ofset. When spinning in free space, away from a part edge, the tp will move away from the
center line and wobble. Choose an axis to touch of frst. For this example, we will use the X axis and
make the lef edge of our part the fxture zero. Jog the machine to a positon that will allow the edge
fnder to come down below the surface of the part just to the lef of the work piece, see fgure 3-1 1
positon A.
2 6


<!-- Page 27 -->

Figure 3-1 1: Using an edge finder
When clear of the work piece, the edge fnder can be moved down in the s axis untl the tp is just below
the surface of the part, about .1 0 0 inch. The tp will be wobbling and appear bigger than it actually is.
Jog the machine, slowly and carefully, towards the part. When the edge fnder just starts to touch the
part stop and switch to incremental jog. A larger step amount of about 0.0 1 0 inch is appropriate here,
move one increment at a tme untl the edge fnder starts to look like fgure 3-1 1, positon B. As the
machine moves closer to the edge, the edge fnder will start spinning more truly. As the machine gets
closer, the edge fnder will get more sensitve to movement. Turn the step increment down to 0.0 0 1
inch and move in one increment at a tme. When the correct positon is reached, the edge fnder will
break, as shown in fgure 3-1 1 positon C.
3.5.2 Inputting Fixture Ofset Values
Now to input a value into the fxture ofset table. There are a couple ways to do this. The value can be
calculated manually and directly typed into the feld or the input box can be used to enter values. When
using the input box there are three ways to enter data, see fgure 3-1 2. The frst is the “Input” buton.
gressing input enters the value from the input box into the selected ofset, over writng any existng
value. Next, is the “Input +” buton. gressing the plus input adds the value in the input box to the value
in the selected ofset. For instance, if the current ofset is 1.5 and .1 is typed into the input box then
plus input is pressed the new value of the ofset will be 1.6. If input was pressed, the new ofset would
be .1. glay around with these input functons to get familiar with them and how they functon. The
third buton is the measure buton. This buton will do the math for us.
2 7


<!-- Page 28 -->

Figure 3-1 2: Fixture ofset table
Let’s frst input the ofset using the “Input” and “Input +” butons. The value we’re looking to enter into
the ofset is the machine positon of the X axis at the desired zero locaton on the work piece. The
positon we are looking for is the locaton of the edge of the part. The edge fnder was used to fnd the
edge, but the radius of the edge fnder has to be accounted for, see fgure 3-1 3.
Figure 3-1 3: Touch of location for 0.2 0 0 inch diameter edge finder
2 8


<!-- Page 29 -->

Select the desired ofset. In fgure 3-1 2 the X ofset of G 5 4 is selected. In the input box type in the
positon displayed in the X axis machine positon DRO and press the input buton. The data will be
writen to the ofset. Now turn of the machine positon to see the fxture ofset positon in the DRO. If
everything was entered correctly, the X DRO should now read 0.0 0 0 0. If not, make sure the desired
fxture ofset is actve by commanding it in the MDI mode. Now, although the data was input correctly
to obtain zero, the edge fnder radius has not been accounted for. The positon we are actually looking
for is -0.1 0 0 0 as shown in fgure 3-1 3. To make this adjustment type 0.1 0 0 0 into the input box and press
the “Input +” buton. The X DRO will update to show -0.1 0 0 0, this is the correct positon. Double check
your ofset data by commanding the fxture ofset in MDI to actvate it, jog the machine so the edge
fnder is just above the surface of the part and move to X 0.0 0 0 0; the edge of the part should be at the
center of the edge fnder.
The next method, and more reliable as human error is reduced, is to use the measure buton. With the
edge found with the edge fnder, type in the desired positon, in this case it is -0.1 0 0 0 and press the
“Measure” buton; the ofset value is calculated and input into the ofset. The X axis DRO will now read -
0.1 0 0 0. The math is completed by Mach 4, just input the value that the DRO should read at the current
positon.
Repeat the same process to fnd the Y axis positon. The s axis will be a litle diferent. A good way to
fnd the s axis positon is to use a fxed tool. The edge fnder is a good one, and a gage block. Move the
machine above the part and jog down slowly. When near the gage block height, use incremental mode
to avoid crushing anything. Slide the gage block under the edge fnder, if it slides freely pull it out and
step the s axis down. Keep stepping down untl the gage block just hits and won’t slide under. Go back
up one increment, usually around 0.0 0 1 but that will vary with desired accuracy. This is the touch of
positon. Entering the ofset data is the same as described above, only this tme instead of taking the
edge fnder radius into account the gage block thickness must be used. Select the s axis ofset in the
fxture ofset window, enter the gage block thickness in the input box and press the “Measure” buton.
Actvate the ofset and check the positon DRO. The s axis should show the gage block thickness.
## 3.6 Tool Length Ofsets
Tool length ofsets are used to tell the machine how long a tool is or where it is in relaton to the rest of
the machine or work piece and are stored in the tool ofset table, fgure 3-1 4. There are as many ways
to touch of tools are there are CNC machinists, this manual can’t atempt to cover them all. The
examples used here are to demonstrate how the ofset system works.
2 9


<!-- Page 30 -->

Figure 3-1 4: Tool ofset table
There are a couple of methods for touching of the tool. A gage block can be used as described for
setng the s fxture ofset in the previous chapter. A piece of paper can be used in place of a gage block,
using the same procedure. Electronic blocks and touch of devices are available, as are blocks with
indicators, and even automatc tool seters (see fgure 3-1 5). Another great method for high producton
environments is an ofine tool pre-seter outside the machine.
3 0


<!-- Page 31 -->

Figure 3-1 5: Types of tool setng devices
3.6.1 Master Tool
Setng up a master tool is a great way to do tool ofsets, especially on a knee mill type machine. This
method involves having a tool at a fxed length and a tool ofset value of zero. An edge fnder is great
for this. Select a holder and lock the edge fnder at a fxed length. Use the edge fnder to set a work
ofset at the top surface of a work piece or any fat surface to touch all the tools of. This allows the
operator to set up a library of tools with set ofsets. When a new part is set up, just touch of the s
fxture ofset and start machining. All the tools will follow the master tool. Make sure to disable tool
length ofsets (G 4 9) or actvate the tool length ofset for the master tool (G 4 3 Hhh, where hh is the
ofset number of the master tool) before setng the fxture ofset for touch of surface.
Once a surface is found using the master tool and the fxture ofset entered, bring each tool down to the
surface using the same method, some type of gage block or tool seter of known height. The positon
shown in the s axis DRO will show the diference in length between the master tool and the tool being
touched of. There are a few optons for inputng the value into the tool ofset table, just like when
setng fxture ofsets. The value can be entered directly into the ofset. A value can be typed into the
input box at the botom and then the “Input” buton will over write the existng data with the value in
the box, the “Input +” buton will add the value from the input box to the existng value, and the
“Measure” buton will calculate the ofset value using the data in the input box as the desired positon.
For this example, type in the gage block thickness then press the “Measure” buton. The value will be
set. Double check the data by actvatng the current tool ofset, MDI G 4 3 Hhh where hh is the ofset
number of the tool being touched of. The s axis DRO should read the gage block thickness if done
correctly.
3 1


<!-- Page 32 -->

3.6.2 Tool Length from Gage Line
Measuring the actual tool length from the spindle gage line (fgure 3-1 6) is the preferred method when
using automatc tool seters and manual electronic/light-up or indicator style seters. It is also
partcularly suited to machines with fxed tables like bed mills, vertcal and horizontal machining centers,
gantry mills, and routers, etc. The distance from the spindle gage line to the measurement point must
be known. When tools are touched of, the ofset value will be the distance from the tp of the tool to
the gage line. Because the ofset is simply a length measurement and not a machine positon, the ofset
value can also be measured outside the machine on a tool pre-seter.
Figure 3-1 6: Gage line and tool length
To use this type of tool ofset system, a fxed point in the machine should be chosen to measure tools. A
great positon is the table of a bed mill. The distance from the spindle gage line to this point must be
found. One way to do this, is remove any tool from the spindle then jog the s axis down. Generally, the
spindle cannot reach the table, but a 4” block usually provides enough height to obtain a measurement.
Use the same procedure as was used when touching of tools, step the spindle down in small increments
untl the block just slides under. The machine positon s axis DRO will read the distance the spindle
traveled down to reach this point. Record this number. For our example machine, let’s say it is -1 0.0 0 0 0.
If the gage block used is the same one that will be used to touch of tools, then this is the number that
will be used for tool touch ofs. If not, subtract the gage block thickness (-1 0.0 0 0 0-4.0 0 0 0=t-1 4.0 0 0 0) to
get down to the table and then add back the height of whatever gage will be used.
Now, we will explain how to touch of tools. A fxture ofset can be set at this positon or a macro can be
created. If a fxture ofset is used, it must be actve and tool height ofsets inactve when touching tools
to get the correct data. With this set up, the user positon s axis DRO will read the length of the tool.
This number should be directly input into the tool height ofset. With a macro (see customizaton
manual for more detailed informaton) a buton like the “Auto Tool sero” buton can be used to do the
math. The macro would take the absolute value of the diference between -1 0.0 0 0 0 and the machine
positon when the buton is pressed. The resultng number will be the length of the tool. For instance, if
a tool is touched of and the s axis machine positon is -8.5 0 0 0 the tool length, tool height ofset, is -
8.5 0 0 0+1 0.0 0 0 0=t 1.5 0 0 0. So, the tool in the spindle is 1.5 0 0 0 long, which is the tool ofset. This method
is a litle more complicated to set up, but once set can be a tme saver. Fixture s ofsets can be set with
any tool as long as the correct height ofset is actvated.
3 2


<!-- Page 33 -->

## 3.7 Tool Diameter Ofsets
Tool diameter ofsets allow the operator to make adjustments to the fnish size of parts provided that
the program contains the proper codes to actvate and use the diameter ofset. Data is entered in the
“Dia” column in the tool ofset table, fgure 3-1 4. Detailed informaton on the programming and use of
tool diameter ofsets can be found in the cuter compensaton secton of the Mach 4 programming
guide.
## 3.8 Tool Wear Ofsets
Cutng tools wear during use. This is true for everything from steak knives in the kitchen to high tech
coated carbide metal cutng tools. Wear and dull cutng edges induce defecton in the cutng tool and
machine that can throw of the precision of a part being cut. Mach 4 provides wear ofsets for both tool
length and diameter to compensate for this defecton, and sometmes actual reducton in length or
diameter of the cutng tool. These wear ofsets are found in the tool ofset table, fgure 3-1 4, in
columns labeled “Length Wear” and “Dia Wear”. When a tool ofset is called, Mach 4 adds the wear
ofset to the set ofset value to determine the actual ofset to be used. Using wear ofsets is
recommended for making small adjustments over making changes to the other ofsets. For example, a
CNC mill is facing a steel part and the fnished thickness is 0.0 0 5” too big. The operator adjusts the tool
length ofset, -0.0 0 5”, to cut deeper. The next part is an aluminum one, the operator doesn’t remember
the old ofset so just faces the part and it is 0.0 0 7” too small. The diference in material hardness can
afect the fnished size of the part. In this case, the operator would have had to record the previous
length ofset or remember the adjustment amount. Using wear ofsets, the operator could just zero out
the wear ofset, or even use it to cut a litle oversize and work down without doing a lot of math. The
original ofset is never changed, unless the tool is changed. Wear ofsets are a valuable resource, learn
them, understand them, and use them.
## 3.9 Tool Information
During operaton the current tool informaton is displayed on the main screen, fgure 3-1 7. This secton
of the screen shows the current tool number and its diameter and height ofset informaton. It is a uuick
way to check that the correct data has been input into the tool ofset. During a tool change the “Tool
Chng” LED will blink, indicatng that the machine is either changing the tool automatcally or waitng for
the user to manual change tools and press the cycle start buton.
Figure 3-1 7: Tool information
3 3


<!-- Page 34 -->

The “Tool” DRO shows the currently selected tool, this DRO will be updated at every tool change. It can
also be changed by the user by clicking on the DRO, typing in the desired tool number, and pressing
enter or return on the keyboard. The “Diameter” and “Height” ofset DROs will update to show
informaton for the selected tool number. These DROs are read only and not user editable.
3.1 0 Creating Programs
grograms are reuuired for automatc operaton of the machine. The most common format is G code.
This type of programming uses a system of G codes (G 0 1, G 1 0, G 8 1, etc.) to specify the desired functon.
gositon codes (X, Y, s, etc.) are used to tell the machine where to go, or where an operaton is to take
place. Other codes startng with M, T, S, F and a few others enable control of just about every aspect of
the controller and machine. The Mach 4 grogramming Guide is a complete descripton of the reuuired G
code format.
grograms can be created by using the wizards, a CAM (computer aided manufacturing) system, or by
manually typing it. There are a variety of CAM systems that can be used for generatng programs from
2 D or 3 D drawings. When CAD models are available using a CAM package is usually the best and
uuickest way to generate a G code program for machining. However, some of these sofware packages
can be very expensive. For this reason, Mach 4 includes the ability to run wizards, a form of
conversatonal programming. Wizards can be created by anyone with some computer programming skill
for just about any task needed.
3.1 0.1 Mill Wizard
Mill Wizard provides the user with a set of tools to generate G code fles for common milling jobs. The
close link with Mach 4 allows created G code to be loaded into Mach 4 with the push of a single buton.
Mill Wizard can create programs with multple tools and features. Features and shapes include
rectangles, circles, links, slots, hole paterns, engraving, gears, splines and more. Figure 3-1 8 shows the
main screen and all the available operatons.
Jobs can be created using the stock materials or the user can add special materials to the table. Tools
can be added to a table for later use. Operatons can be modifed and re-ordered as desired. Complete
documentaton is provided in the help menu of the sofware. The follow fgures give a basic idea of
what the sofware looks like.
3 4


<!-- Page 35 -->

Figure 3-1 8: Mill Wizard main screen
Figure 3-1 9: New job window, select material, units, etc.
3 5


<!-- Page 36 -->

Figure 3-2 0: New tool window, select tool and set feed and speed
Figure 3-2 1: Circular pocket wizard
3 6


<!-- Page 37 -->

Figure 3-2 2: Hole circle wizard
Figure 3-2 3: Text engraving wizard
3 7


<!-- Page 38 -->

Figure 3-2 4: Rectangle cutng wizard, cut inside, outside or groove
4 Running the Machine
## 4.1 Manual Data Input (MDI)
Manual Data Input (MDI) mode allows the operator to manually enter G code to be executed. The
operator should have a solid understanding of G code and machine programming before atemptng to
command the machine using the MDI mode. This is useful for actvatng or deactvatng fxture ofsets,
tool ofsets, positoning modes, tool changes, moving to known positons, etc. In Mach 4, MDI programs
can be multple lines and a history of commands is saved that can be navigated using the up and down
arrows adjacent to the MDI window.
Figure 4-1: MDI screen
3 8


<!-- Page 39 -->

To enter code into the MDI window, select the window and type in the desired code. gress the “Cycle
Start” buton to execute the code in the window. Once executed, the code will be stored in the history
where it will remain untl Mach 4 is shut down. gress the up arrow on the lef of the MDI window to
scroll through the history. The most recent code is shown frst. The tool path window on this page
shows the tool path of the currently loaded G code fle and not the MDI program.
Some examples:
Change to tool number 1 0: T 1 0 M 6
Actvate tool length ofset number 6: G 4 3 H 6
Move to machine zero positon: G 5 3 G 9 0 G 0 X 0 Y 0 s 0
Move to part zero positon: G 5 4 G 9 0 X 0 Y 0 s 0
## 4.2 Loading a G Code Program
G code programs contain code for cutng a part. The frst step to running a program is to load it into
Mach 4. In the File Ops tab in the operator control secton of the screen press the “Load G Code” buton.
A window will open that will allow the operator to navigate to the desired fle and open it. By default
Mach 4 will show .tap and .nc fles. Any basic text format can be opened and the default fle types can be
changed in the Mach confguraton on the General tab. When the fle loads, Mach 4 will uuickly run
through it to generate a tool path for the tool path window. If there are any major code errors or
unknown codes they will be found on this inital run through. The tool path window will show the actual
tool path including cuter comp and any other adjustments made in the program. Check it to make sure
it looks as intended before running.
## 4.3 Viewing the Tool Path
The tool path window shows the programmed path exactly as it will be run by the machine. It is possible
to pan rotate and zoom the tool path window using the mouse. Move the mouse pointer into the tool
path window and perform the following:
Rotate – Lef click and drag
gan – Lef + right click and drag
soom – Right click and drag or scroll wheel
Reset View – Double lef click
## 4.4 Editing a G Code Program
To edit the currently loaded G code fle press the “Edit G Code” buton in the File Ops tab. Mach 4 will
open the fle in the included G code editor: GC Edit. When the desired changes are made, save the fle
and close the window. Mach 4 will re-load the fle and re-generate the tool path.
## 4.5 Closing a G Code Program
To close a G code program, press the “Close G Code” buton in the File Ops tab.
3 9


<!-- Page 40 -->

## 4.6 Executing a G Code Program
4.6.1 Cycle Start
gressing the cycle start buton will start program executon from the current line shown in the File Ops
tab. The program will run untl a program pause or end G code is read or executon is stopped by the
operator.
4.6.2 Feed Hold
The feed hold buton will immediately pause the program, press cycle start to contnue. Feed hold will
only pause axis moton. If the spindle is running it will stay on and any actve outputs will remain actve
(coolant, air blow, etc).
4.6.3 Stop
The stop buton will immediately end program executon. All moton will stop as well as the spindle and
other outputs. This is similar to commanding a program stop in the G code program. Although program
executon is halted by pressing the stop buton, the program is not rewound.
4.6.4 Reset
To rewind a program back to the beginning press the reset buton. This will also return the controller to
its default state.
4.6.5 Starting from the Middle of a Program
There are a couple ways to start executon from a point other than the beginning of a program. If the
desired start point is a safe start line or other safe positon, not including any moton, the desired start
line can be selected and cycle start pressed. Select the desired start line in the G code window and then
press the “Set Next Line” buton. When the cycle start buton is pressed the program will begin
executon from this selected line.
grograms can also be started from any positon in the program, including in the middle of a cut. To do
this, select the point to start by scrolling through the G code program in the G code window and select
the desired line. Manually jog the machine close to the start point. Next, press the “Run From Here”
buton in the File Ops tab. A window will open, fgure 4-2, to start the process of restartng the
program.
4 0


<!-- Page 41 -->

Figure 4-2: Run from here window
In the run from here window, there is a positon read out showing distance to go. These distances are
how far the machine needs to travel to reach the start point. Before startng executon, the machine
must be moved to the start point. The axes can be moved using the controls in the “Move Axis to Start
gositon” secton of the window. Enabled axes will be available for selecton. Select one or multple
axes to move and press the “Move Selected” buton. The selected axes will move to their start
positons. Another buton, “Move Unselected” will move the unselected axes. Use this buton to move
any remaining axes to their start positons. Once the machine is in the start positon, press the “OK”
buton. Mach 4 will scan the preceding part of the program to get the machine into the proper state:
coolant/spindle on or of and setng up cuter comp if actve. gress cycle start to start machine moton
and run the rest of the program.
5 Help, I’ve Crashed…
It happens to everyone who has ever run a CNC machine. The machine is running great, the part is
being cut exactly as we expected. Then, CRASH. A tool breaks, the work piece comes out of the vise or
chuck, the machine hits a clamp, or any number of seemingly impossible feats for a machine to perform.
Sometmes it’s very minor, sometmes it’s very serious. These moments are extremely frustratng for
operators and programmers, it is usually best to take a minute to survey the situaton before taking
acton. Before atemptng to move a machine that has been crashed take a good look at everything
involved. Make sure there is no major damage to the machine, if there is don’t try to jog it which could
cause even more damage. If something happened while cutng a part, check the tool and where in cut
it stopped. Sometmes it is best to loosen a tool in its holder so the s axis can be jogged up to remove
the tool. End mills can be easily damaged when jogged along a part edge or ripped out of a pocket when
they’re not spinning. Also, if the tool is currently welded to the part (which does happen) trying to pull it
out with the machine can potentally cause damage to the machine or it could break, sending small very
sharp bits of carbide or tool steel fying in every directon, could cause harm to humans and other things
nearby. If a tool is stuck in a part try to loosen or remove it from the spindle or unclamp the part before
atemptng recovery.
4 1


<!-- Page 42 -->

## 5.1 Limit Switches
Limit switches are physical switches that mark the end of a machine’s range of moton. Sometmes one
or more of these will double as a home switch. The hard limit switches are basically the last line of
defense before major damage occurs. Without these switches the machine could slam into a hard stop
at the end of travel or even send the table right of the end of the rails, depending on the confguraton.
Running a machine without limit switches is risking damage to ball screws and nuts, bearings, castngs,
people, foors and walls.
When Mach senses that a limit switch is actvated it immediately disables all moton. In this state
jogging is disabled. At frst it can seem impossible to recover from this situaton. On small machines one
soluton could be to turn the ball screw or slide the axis by hand, on bigger machines this is not possible.
In this case jogging the machine of the limit is the only opton.
Figure 5-1: Limit override on program run screen
When a machine is on a limit switch it can be jogged by temporarily overriding the limit switches. gress
the “Limit Override” buton on the program run screen, fgure 5-1. This will re-enable axis moton and
jogging so the machine can be moved away from the limit switch. As soon as the switch is deactvated
the limit override is automatcally turned of.
When the limit override buton is pushed the machine can be moved in any directon
and regardless of the state of the limit switches. Exercise EXTREME cauton to avoid
serious damage to human operator or machine. Check and double check which axis
should be moved and in which directon. Start movement with a very small move, just
bump the axis, to verify your choice of directon is correct. Then move the machine the
rest of the way of the switch.
## 5.2 Soft Limits
Running into machine hard limits can be prevented by using sof limits. Sof limits are sofware end of
travel switches. They are generally set up by the machine builder to be about ¼ to 1 inch from the
physical switch depending on machine size, velocity and acceleraton. When an axis is moved into the
sof limit it is decelerated to a stop. Generally there is a deceleraton window of about a ½ inch. Inside
this window axis velocity is reduced. When a machine runs into a sof limit it can simply be jogged the
other way, no risky limit override buton.
4 2


<!-- Page 43 -->

Sof limits can be displayed in the tool path display by pressing the “Display Mode” buton. The sof
limits show up as dashed yellow lines, fgure 5-2. When the cycle start buton is pressed to run a
program, Mach automatcally checks if the tool path extends beyond the sof limits, if it does a warning
is issued.
## 5.3 Preventing the Inevitable
As always, the best method of crash recovery is to avoid the crash in the frst place. Most crashes are
due to human error and operator complacency. As humans we have a tendency to get overly confdent
and stop paying complete atenton to what we’re doing. This is especially common when running
producton type parts, large volumes and very repettve. Always remain focused on the work at hand,
CNC machines can be very dangerous and reuuire 1 0 0% of your respect and atenton. They will not
think twice about removing parts of your body.
New programs are always a huge source of crashes involving the tool and work piece or work holding
devices. Usually these crashes are minor, at worst resultng in a broken tool. However, the worst
crashes can result in broken spindles, damaged bearings, cracked or bent castngs and machine frames,
bent tool changer arms, or even fre. However, these types of collisions can almost always be avoided
by dry running the program, either without a part or above the part. grocedures for checking programs
can be found in text books or talking to experienced operators.
Jogging is another source of crashes. We’ve all done it, jogging tool towards a part to check or set the
height and bang, we jogged too far and crushed the tool into about 1,0 0 0 pieces. These crashes are
usually very minor as the velocites tend to be low and the buton pushes are short, but they do happen.
Biggest thing to avoiding these is pay atenton and take your tme. This usually happens when you’re
rushing that last job and you don’t want to switch to incremental jog just yet, one more bump of the jog
buton will get it that much closer. Now a new tool needs to be put in and touched of. Take the extra
tme and use the incremental jog when nearing a part. This prevents crashes caused by holding the jog
buton down a millisecond too long.
Computers. They make this technology possible, they can also bring it crumbling down and make us
want to leap out of tall buildings. Computers can crash and fail, when set up properly this will simply
cause the machine to stop, hopefully avoiding any damage. When a computer locks up the charge
pump signal from Mach to the hardware moton control stops as well, this tells the moton controller
that Mach is no longer in control of the system. In this situaton the moton controller will essentally hit
the emergency stop buton ending all moton and shutng down all outputs. Using a good, reliable
computer can almost completely avoid these situatons. Keep the computer running the machine
cleaned up (inside and out) and don’t use it for any unnecessary tasks. It is best if this computer is 1 0 0%
dedicated to running the machine and nothing else. Keep the control sofware and any plugins up to
date with the most current stable releases. Don’t move too fast for the computer. Many tmes a
computer crash is caused when the computer is “thinking” and the user is frustrated and clicks on
```
something 1,0 0 0,0 0 0,0 0 0 tmes. Don’t do it, let the computer react to your input before moving on. Be
deliberate and precise in your actons.
Sometmes, it’s just out of our control. CNC machines are a complex web of mechanical and electrical
systems. These systems can fail. No machine is ever failure proof. Motor drivers can fail, causing the
motor to stop or go max Rg M untl something stops it. Wires can corrode and break, welds can crack, or
4 3


<!-- Page 44 -->

lightening can strike. Whatever the failure, use the same processes described above. Step back and
take it all in before taking acton.
4 4

