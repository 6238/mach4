# Mach4 Scripting Manual

*Converted from PDF: Mach4 Scripting Manual.pdf*
*Conversion date: /Users/chondl/learn/mach4*

---

<!-- Page 1 -->

1

Mach 4 CNC Controller
Lua Scripting Guide


<!-- Page 2 -->

2
Copyright © 2 0 1 4 Newfangled Solutions, Artsoft USA, All Rights Reserved
The following are registered trademarks of Microsoft Corporation: Microsoft, Windows. Any other
trademarks used in this manual are the property of the respective trademark holder.
Table of Contents
1 Introduction ................................ ................................ ................................ ................................ .... 3
1.1 Before You Begin ................................ ................................ ................................ ...................... 3
1.2 What is Mach 4? ................................ ................................ ................................ ....................... 3
1.3 What is a Mach 4 Script? ................................ ................................ ................................ ........... 4
2 Script Editor ................................ ................................ ................................ ................................ ..... 5
2.1 File Menu ................................ ................................ ................................ ................................ . 6
2.2 Edit Menu ................................ ................................ ................................ ................................ 6
2.3 Search Menu ................................ ................................ ................................ ............................ 7
2.4 Debug Menu ................................ ................................ ................................ ............................ 8
2.5 Help Menu ................................ ................................ ................................ ............................... 8
2.6 Toolbar ................................ ................................ ................................ ................................ .... 9
3 Types of Scripts ................................ ................................ ................................ ................................ 9
3.1 M code s ................................ ................................ ................................ ................................ ... 9
Scriptable M codes ................................ ................................ ................................ .................. 9 3.1.1
M Code Macro Folder ................................ ................................ ................................ ............ 1 0 3.1.2
3.2 Screen Scripts ................................ ................................ ................................ ......................... 1 1
Screen Load Script ................................ ................................ ................................ ................. 1 1 3.2.1
Screen Unload Script ................................ ................................ ................................ ............. 1 1 3.2.2
PLC Script ................................ ................................ ................................ .............................. 1 1 3.2.3
Signal Script ................................ ................................ ................................ .......................... 1 2 3.2.4
3.3 Panels ................................ ................................ ................................ ................................ .... 1 3
4 Registers ................................ ................................ ................................ ................................ ........ 1 4
4.1 Creating Registers ................................ ................................ ................................ .................. 1 4
4.2 Viewing Registers ................................ ................................ ................................ ................... 1 5
4.3 Using Registers in Scripts ................................ ................................ ................................ ........ 1 5
4.4 Saving Registers to Machine.ini ................................ ................................ .............................. 1 7
4.5 Loading Registers From Machine.ini ................................ ................................ ....................... 1 8
5 Examples ................................ ................................ ................................ ................................ ....... 1 8
5.1 Using Signals ................................ ................................ ................................ .......................... 1 8


<!-- Page 3 -->

3
5.2 Readin g Data from an External File ................................ ................................ ......................... 1 9
5.3 Tool Change ................................ ................................ ................................ ........................... 2 0
5.4 Automatic Tool Height Setting ................................ ................................ ................................ 2 5
5.5 Wizards ................................ ................................ ................................ ................................ .. 2 7
5.6 Modbus ................................ ................................ ................................ ................................ .. 3 3

1 Introduction
The purpose of this manual is to teach the basics of scripting in Mach 4 using the Lua interface. Script s
```
add functionality to Mach 4 by providing the user with an interface to create custom M codes, macros to
control tool changers and other custom accessories, create programming wizards, custom button
```
functions, and much more. This manual will provide some basic programming knowledge as it pertains
to creating scripts for Mach 4. For more advanced Lua programming there are a variety of resources
available online and in print.

## 1.1 Before You Begin
Any machine tool is potentially dangerous. Computer controlled machines are
potentially more dangerous than manual ones because, f or example, a computer is
quite prepared to rotate an 8" unbalanced cast iron four -jaw chuck at 3 0 0 0 rpm, to
plunge a panel -fielding router cutter deep into a piece of oak, or to mill away the
clamps holding your work to the table. Because we do not know t he details of your
machine or local conditions we can accept no responsibility for the performance of
any machine or any damage or injury caused by its use. It is your responsibility to ensure that you understand the implications of what you design and bui ld and to comply with any legislation and codes
of practice applicable to your country or state. If you are in any doubt, be sure to seek guidance from a professionally qualified expert rather than risk injury to yourself or to others.
1.2 What is Mach 4? Note: Operators should be familiar with general CNC and machining practices before
operating any CNC machine. Some great resources for additional learning at the
machsupport.com forums, other user groups/forums, and books such as CNC
Programming Handbook and CNC Control Setup for Milling and Turning, both by Peter
Smid and Programming of CNC Machines by Ken Evans


<!-- Page 4 -->

4
Mach 4 is software that operates on a personal computer to create a powerful and cost efficient CNC
controller. It makes up one small piece of a computer numerical control (CNC) machine. Machines can
range from basic mills and lathes to wood routers, plasma c utters, multi axis machining centers, quilting
machines, anything requiring motion control. The system is capable of interpreting multiple
programming languages, the default and most common being G code, to provide instructions for
```
machine movement and ot her functions. These instructions are passed to an external motion device
which in turn controls all the inputs and output signals and motion.
Mach 4 is designed to be flexible and adaptable to a wide variety of machines. Part of this flexibility is
the a bility for hardware and software developers to create addons or plugins for Mach 4 to expand its
capabilities. Addons are small programs installed into the Mach 4 directory that give Mach the ability to
talk to hardware devices such as motion controllers an d pendants, communicate with other software,
```
add additional wizards or conversational machining functions, or anything a developer can dream up.
Addons to Mach 4 are so diverse it would be impossible to cover them in this manual. The developer should prov ide detailed information on the installation, configuration and use of their addon or plugin.
1.3 What is a Mach 4 Script?
Scripts in Mach 4 are written in the Lua programming language. Users and OEMs can create scripts to accomplish any number of tasks, limite d only by the programmer’s imagination. There are four types of
scripts in Mach 4: M codes, modules, screen, and panels. M codes, screen scripts and panel scripts are
each separate containers for code. They cannot interact with each other directly. For example, a
```
variable or function defined in an M code cannot be used in a script on the screen. However, modules
provide a place to put code that can be accessed by the others. An M code or screen script can call and
```
use functions and variables from a loaded module. Registers are a powerful way to pass data between
different processes in Mach 4 and can be used as a bridge between script types. What is an external motion device? Originally, Mach -series software only worked with
the parallel port (via the parallel port driver), which was a standard port on every PC.
Technologies have advanced over time, and not only is the parallel port becoming obsolete, but the Windows codebase has changed to the point where it is technical
impossible for the parallel port driver to work. An external motion device is a piece of hardware that is an improvement over the parallel port. It enables a PC running Mach 3/Mach 4 to control outputs and read inputs. They typically communicate with the
PC via an Ethernet or USB connection (but are not limited to those two means of communication). In order to control a machine using an external motion device, the developer o f the hardware must write a plugin (driver) for that specific device, so no
standard USB -to-parallel port adapters will work. There are many devices listed on our
Plugins page in the software and download section of our website
(www.machsupport.com).


<!-- Page 5 -->

5
2 Script Editor
Mach 4 includes a built in script editor. The editor can be found in the ‘Operator’ menu as ‘Edit/De bug
Scripts’ (see Figure 2 -1). Selecting ‘Edit/Debut Scripts’ will open a window to select the script to be
edited. By default the ‘Macros’ folder for the current profile will be shown. Select and open a file and it
will be opened in the editor.

Figur e 2-1: Operator Menu
The script editor is essentially a fancy text editor, with some features specific to programming scripts
and macros for Mach 4.

Figure 2-2: Script Editor


<!-- Page 6 -->

6
## 2.1 File Menu

Figure 2-3: Script editor file menu.
The file menu contains the controls “New”, “Open”, “Close”, “Save” and “Exit”. Selecting new will open
a blank file for creating a new script. Open will open a window to allow the user to find and select an
existing script to edit. The close option will close the currently active file. Save allows the user to save
the script, there is also a “Save As” option that will can save the document as a new name or in a new
location. Exit simply closes the editor and any open files.
## 2.2 Edit Menu

Figure 2-4: script editor edit menu.
The edit menu contains the typical Cut, Copy, Paste, Select All, Undo/Redo controls as well as a couple
specific to the script editor. When Auto Complete Identifiers is checked the auto complete window will
display when typing text in the editor. If the text being typed partially matches known commands then
the window will dis play the possible options. When Auto Complete Identifiers is not checked the auto
complete window will not be displayed automatically, but it can be manually shown with the Complete
Identifier (Ctrl+K) command. Comment/Uncomment will either add the “ - -“ characters to selected text
to change it to a comment, or remove the “ - -“.


<!-- Page 7 -->

7
Settings displays window that allows the operator to change the color and style of different types of text
in the program.

Figure 2-5: Script editor settings.
## 2.3 Search Menu

Figure 2-6: Script editor search menu
In the search menu the user can find commands to search for and replace text, jump to specific line numbers and sort lines in alphanumerical order. Numbers first, 0 to 9, then letters, A to Z.


<!-- Page 8 -->

8
## 2.4 Debug Menu

Figure 2-7: Script editor debug menu.
The debug menu contains the controls for running and debugging programs. Compile compiles the
current program into a .mcc file. Run will execute the script.
Start Debugging will start the debugger. Debugging helps in dia gnosing errors in the program. There are
a couple ways to run through the program in the debugging mode. The Start Debugging command will
change to Continue when in the debugging mode. When the debugger starts the program will pause at
the beginni ng and wait for input from the user. Continue will run through the complete program. The
other controls, Step Into, Step Over, and Step Out allow the user to step through the script line by line.
```
Step Into and Step Over differ in the way functions are e xecuted. Step Into will make a single step into
```
the function. Step Over will execute the entire function and pause at the end. If a function is stepped
```
into, the Step Out command will execute the remaining portion of the function and pause at the end.
The Console shows error messages and debugging data while running programs.
## 2.5 Help Menu
The Help Menu displays the About information.


<!-- Page 9 -->

9
## 2.6 Toolbar

Figure 2-8: Script editor toolbar
The toolbar in the script editor contains some of the most common controls. From left to right:
• Create new document
• Open existing document
• Save current document
• Save all open documents
• Cut
• Copy
• Paste
• Undo
• Redo
• Search for text
• Find and replace text

3 Types of Scripts
Scripts are divided into 4 types: M codes, screen, panel and modules. This chapter will discuss the
differences in and interactions between these types.
## 3.1 M codes
```
M codes, or miscellaneous functions, are used to create additional functionality in a machine. They are
```
specified in a G code program or in the MDI mode. The functions can range from turning on and off
coolant to changing tools, to custom code to engrave a serial number. With the ability to script custom
```
macro M codes the possible functions are as diverse and varie d as the machines and operators running
them.
```
Scripts cannot be written for all M codes, some have functions that are defined in Mach 4 and will only perform that function. Below is a list of the M codes and how they interact with user s cripts and
```
internal functions.
Scriptable M codes 3.1.1


<!-- Page 10 -->

1 0
User Scriptable/No Internal
Function User Scriptable And Internal
Function Internal Function Only
M 6 M 3 to M 5 M 0 0 to M 0 2
M 1 0 to M 4 5 M 7-M 9 M 4 6 to M 4 8
M 5 0 to M 6 1 M 3 0 M 6 2 to M 6 5
M 6 6 to M 9 5 M 4 7 M 9 6 to M 9 9
M 1 0 0 and up

M codes in the column “User Scriptable/No Internal Function” are completely open to user scripts.
```
There is not function associated to them in Mach 4.
```
M codes in the column “User Scriptable And Internal Function” have internal function s in Mach 4, but
```
also all ow user scripts. These codes are further divided into those that call the function internal to
Mach 4 OR a user script and those that run both. M 3 to M 5 and M 7 to M 9 are codes that control the
```
spindle and coo lant functions. If there is no user script for these codes they turn on/off their respective
signals as defined inside Mach 4. However, if a user script is present, the script will be run instead. This
gives the user the power to create custom codes for custom spindle and coolant applications, but if the
machine simply needs to turn on/off an output, no programming is required.
M 3 0 and M 4 7 are both codes that show up at the end of a program. As they are required to end and/or
```
rewind the G code execution their internal functions cannot be ignored. Ho wever, it is useful to have a
script execute at the end of a program, a parts counter for instance. For this reason both codes will execute a user script if it is present. After executing the script the M 3 0 and M 4 7 will execute the
```
internal function of e nding/rewinding the program.
```
The last column is “Internal Function Only.” M codes found in this column will only execute their internal functions and will NOT execute a user script, even if one is present.
Using custom M codes requires the scripts to be located in the ‘Macros’ folder located in the folder for
the desired profile. Navigate to the Mach 4 root directory, usually located on the C drive, open the
‘Profiles’ folder, then open the folder of the desired profile. The name of th e folder will be the name of
the profile, ‘Mach 4 Mill’ for example. The ‘Macros’ folder will be located in this profile folder.
Every script file in this folder will be compiled into one file. If a custom M code is desired it must have
an associated file in this folder named in the format M 3.mcs, replace the 3 with whatever M code is desired. The format of the script is important as well. Because all the fil es get compiled into one, each
```
M code must be its own function.
```
function m 3()
```
inst= mc.mc Get Instance()
mc.mc Cntl Set Last Error( inst, 'Spindle Clockwise')
mc.mc Spindle Set Direction( inst, 1)
end

```
if (mc.mc In Editor() == 1) then
```
m 3()
end
M Code Macro Folder 3.1.2


<!-- Page 11 -->

1 1
Above is an example of a custom script for the M code M 3. The name of this file is m 3.mcs. Reading
```
through the script the main chunk is the function m 3(). This is the function that will be called when an
M 3 is commanded in a G code file or MDI. The second part of this script is for debugging purposes.
When the script is open in t he editor nothing would happen when it was run unless there was some
```
code to call the m 3() function. However, if there was simply and m 3() line to call it, the M code would
be executed as soon as Mach 4 loads. The if statement checks to see if the script is open in the editor, if
```
it is, then the m 3() will be executed. Otherwise the function will need to be called from a G code
program or MDI command .
## 3.2 Screen Scripts
The screen contains scripts than run on load and unload and a plc script. Certain screen e lements (such
as buttons, panels, DROs, and tabs) can also execute user defined scripts. These scripts call all be set in
the screen editor (see the Mach 4 customization manual for more information of customizing the
screen).
The screen load script runs when the screen is loaded. This is a useful tool for loading saved settings or
data, setting a start -up state, initializing controls, etc.
```
Global functions that will be used in other scripts on the screen can also be run in the screen loa d script.
```
All scripts in the screen (with the exception of panels) will have access to global functions and variables
that are defined in the screen load script. This can reduce the amount of programming for the user.
A word of caution: The screen load s cript runs while the screen is being loaded. When trying to set the
state of screen elements use care, sometimes the target element has not been loaded when the screen
load script runs. If data it to be set on the screen, it is usually best to do that in the first run of the PLC
script.
The screen unload script runs when the screen is unloaded. This can be a useful tool for saving settings or data. Registers are a perfect example as their values are not saved by Mach 4 on exit. The best place
to store data with a profile is in the .ini file. Mach 4 provides an easy way to do this from a script with
the mc.mc Profile Write String(inst, section, key, value ) command. With this command it is possible to
write any data to the .ini file to b e saved and reloaded later. The register’s section shows specific
examples for saving and loading registers from the .ini file.
The PLC script continuously runs at an interval set in the screen. By default the PLC scripts run on a 5 0
milliseco nd interval. Although this is a script and not a ladder type program, it does provide a similar
```
functionality to a PLC, hence the name. This script can monitor the state of signals and inputs and
outputs and react very quickly. A common use for the PLC script is showing errors or faults from
external devices such as servo drives and VFDs. Screen Load Script 3.2.1
Screen Unload Script 3.2.2
PLC Script 3.2.3


<!-- Page 12 -->

1 2
The first run of the PLC script is also the best place to set data on the screen for the first time. This
ensures that the target element on the screen exists before d ata is being set. Running a section of the
code on the first run is easy to accomplish with a simple counter in the PLC script.
count = count + 1

With this count variable at the top of the PLC program it will count up by one every time the PLC script
runs. So, on the first run count will equal 1. So an if statement can run certain code only on the first
run.
The signal script is an a ll new concept in Mac h 4. This script is an event handler that can be used to
perform actions in response to state changes of signals in the signal library. Signals are internal triggers
for events in Mach 4 and are not to be confused with external inputs and outputs. Some signals are
completely internal and some are used to connect to external inputs and outputs . The signal script can
connect all signals to an action.
How does it work? A change in state of a signal is considered an event, on every event the signal script
runs. In the signal script two variables are used to determine which signal triggered the event and what
its new state is. The variable “sig” is the internal ID number of the signal, and the variable “state” is the
state of the s ignal after the event.
Now we know which signal triggered the event and what its state is, but we don’t know if it is the signal
we want. To do this we need a way of comparing the ID numbers of the signal we want to perform an
action and the signal that t riggered the event. This means knowing the ID number of the signal we
want. Mach 4 makes this easy on us by providing a complete set of signal definitions. They are all in the
format: mc.OSIG_MACHINE_ENABLED, mc.ISIG_INPUT 0, etc.
One application of this is to connect physical buttons on a control panel to actions in Mach 4. Let’s make a simple cycle start button that is setup on input 1. Since we will be using input 1, the ID number we’ll
be looking for is mc.ISIG_INPUT 1. In the signal script we could h ave this code:
if (sig == mc.ISIG_INPUT 1) then
```
local inst = mc.mc Get Instance()
mc.mc Cntl Cycle Start( inst)
end

Now, this would work, however remember that the signal script runs for every event. The events are
when the signal changes state. So thi s code would command the cycle start when the button is pressed,
and again when it is released. To avoid this we can look for the state to be what we want as well. That
would lead us to:
if (sig == mc.ISIG_INPUT 1) and (state == 1) then
```
local inst = mc.mc Get Instance()
mc.mc Cntl Cycle Start( inst)
end

```
Signal Table = {
```
[mc.ISIG_INPUT 1] = function (on_off)
if (on_off == 1) then Signal Script 3.2.4


<!-- Page 13 -->

1 3
mc.mc Cntl Cycle Start( inst)
end
end
```
}

This code would look for the input 1 signal to change to an active state. When the signal changes to the
off state the cycle start will not run. This is relatively simple, but if when connecting a lot of signals the
script can get very complex, and checking many if statements can bog things down, slowing t he reaction
to state changes. To make things run more efficiently we can use a table for all the signals we want to
use, and index that table from the signal script. The best place to create the table is in the screen load
script, where it will be loaded when Mach 4 is started and can then be accessed by the signal script, or
any other script in the screen. The table in the screen load script could look something like this:
```
This table contains a function with a name matching the ID number of signal connec ted to input 1. That
```
function will command a cycle start when the state of the signal is equal to 1, or the signal is active.
Now that we have a table we need some code to index it in the signal script.
This code, which lives in the signal script, will look into the table, Signal Table, for an entry matching the
signal ID number that is stored in the variable sig. If there is no entry nothing is done. If there is, then
```
the state is passed into the function and the desired action is performed.
This seems more complex than the if statements at first glance, but it really isn’t. The only code that will
```
be in the signal script is that shown above. The signal table will grow as functions are added in, but it is
no more difficult or complex than the many if s tatements that would be required. And, as said before,
the table is much faster to index and thus far more efficient and reactive to events.
if (Signal Table[ sig] ~= nil) then
Signal Table[ sig](state)
end

## 3.3 Panels
Although panels are located on the screen, they deserve their own section as they are a separate entity. Unlike all the other screen elements they do not share the same global space, and thus cannot access
```
functions or variables in the screen load script like buttons and other controls can. However, they can
load and utilize modules just as any other script in Mach 4 can.
Panels are simply and environment to run a self -contained Lua program. Elements of a panel are not
defined in the screen designer, they are defined in the code contained in the panel. The easiest way to
create an interface in a panel is to use a form designer capable of outputting Lua code, wx Form Builder
for example.
The mouse wheel as MPG code is a great example of how panels can be used. A video tutorial about
this code can be found here : https://www.youtube.com/watch?v=MRya RQwh YWk
. A link to the code is
in the description.
Wizards are another example of what can be shown in a panel. Mach 4 comes with an example bolt hole
circle wizard that can be displayed in its own dedicated frame or in a panel on the Mach 4 screen. The code for this wizard can be found in the “Wizards” folder in the Mach 4 directory on your computer, the
file name is “Bolt Hole Circle.mcs”.


<!-- Page 14 -->

1 4
4 Registers
Registers are a very powerful tool in Mach 4. They are completely user definable and can be accessed
from anywhere in Mach 4. Scripts can use them to record and save data or to transfer data to another
script or c ommunicate with a plugin. Registers can contain numbers or strings.
## 4.1 Creating Registers
Registers are created in the Regfile plugin. Select “Plugins…” from the “Configure” menu to display the
plugin configuration window, figure 4 -1.

Figure 4-1: Configure plugins window.
In the configure plugins window find the Regfile plugin, row 6 in this case, and click on the “Configure…” button. This will open the register configuration window, figure 4 -2.

Figure 4-2: Register file configuration window.
In this window new registers can be created as well as assigned initial, or default, values. To add a
register click on the icon with the green plus sign (top left corn er of the tab). A new row will be added,
simply give it a name, an initial value, and a description. The name will be used to look up the register,


<!-- Page 15 -->

1 5
so use something simple. The description is optional but accurate descriptions are certainly beneficial i n
the long run.
The initial value is the value that will be assigned to the register when Mach 4 loads. The registers are
not saved by default when Mach 4 is closed. If a register, or many, needs to be saved on exit the Screen
Unload script is a great plac e to do this. Also, to load the saved value use the Screen Load script. Saving
registers to and loading them from the Machine.ini file will be covered in the next sections.
## 4.2 Viewing Registers
The Regfile configuration window shows the registers and their default values. A diagnostics window is provided to show the registers and their values in real time. The diagnostics window can be found by
selecting “Regfile” from the “Diagnostic” menu in Mach 4.

Figure 4-3: Register diagnostics window.
The diagnostics window displays all the registers in Mach 4 and also provides a display for the pound
variables. If the “i Regs 0” category is expanded we will see the registers and associated values from the
previous section.
The register diagnostics window is not limited to only viewing register values, they can be changed as
well. Double click on any value and an input window will pop up to allow the user to change the value.
## 4.3 Using Registers in S cripts
There are several commands available for working with registers, for clarity and simplicity we will be
using only the necessary few here:
• hreg = mc.mc Reg Get Handle(inst, path)
• val = mc.mc Reg Get Value(hreg)
• string = mc.mc Reg Get Value String(hreg)
• mc.mc Re g Set Value(hreg)
• mc.mc Reg Set Value String(hreg)
The first step in using registers in scripts is to get the handle. The handle is basically an ID number
assigned to the register internally in Mach. There is now what to know this except to ask Mach for it.


<!-- Page 16 -->

1 6
```
The mc Reg Get Handle function returns the ID or handle. There are two arguments required for this
```
function, the current instance number of Mach we are working in and the path of the register. The
```
instance can be found using the mc.Get Instance function in th e format:
```
inst = mc.mc Get Instance()

The path is the register type followed by the register name. For example, the path for the first register
in figure 4 -2 is “i Regs 0/Test 1.” So to get the handle of the Test 1 register the code would look like:
```
inst = mc.mc Get Instance()
hreg = mc.mc Reg Get Handle( inst, "i Regs 0/Test 1")

Now to get the value. Here we are discussing two ways to retrieve the value, as a number or as a string.
If the register’s value is an unknown type then use mc Reg Get Value String. Using mc Re g Get Value will
result in an error if the register contains a string, but mc Reg Get Value String can read a number or a
string as a string. The only catch there is that math cannot be performed on a string, even if it is a sting
of only numbers. Strings cont aining only numbers can be converted to a number format by using the
tonumber(“string”) command. Let’s use mc Reg Get Value String to retrieve the value of Test 1 and then
convert it to a number for computation later. Ofcourse this only works for values that are numbers, the
```
tonumber(“string”) function will create an error if the string contains more than just numbers.
```
inst = mc.mc Get Instance()
hreg = mc.mc Reg Get Handle( inst, "i Regs 0/Test 1")
val = mc.mc Reg Get Value String( hreg)
val = tonumber( val)

```
It would save a line of code to use the mc Reg Get Value(hreg) function, but there is a reason for using the
```
string method shown above. Every time a register is called it requires two lines of code, as well as the current instance. There is an easier way, c reate our own function. Remember that all the contents of
the macros folder are rolled into one large file, and the screen has access to all the elements of the
screen, and the modules can be loaded and used everywhere. With the standard method shown abo ve
this code would have to be used every time register information was needed, in every M code, every
```
button, every script in Mach 4. Making a function to call the register is much easier and can make the
code a lot cleaner. Let’s use a button on the scre en as an example. We would like a button to get the
```
value of a register and display it in a message box to the user. Or first step will to be to create a function
```
in the screen load script to get and return the value of the register. This function can b e used by our
new button and any other button we decide to add to the screen. In the screen load script we will make
```
a function as shown below.
```
function Get Register( regname)
```
local inst = mc.mc Get Instance()
local hreg = mc.mc Reg Get Handle( inst, string.format( "i Regs 0/%s", regname))
return mc.mc Reg Get Value String( hreg)
end

```
With this function in the screen load script, our button can call it. To get the value of the “Test 1”
register and display it in a message box the button script will be:
regval = Get Register( "Test 1")
wx.wx Message Box( regval)


<!-- Page 17 -->

1 7

```
Now with that function created, any time we want to retrieve the value of a register we simple call the
```
Get Register(regname ) function with the name of the register to get. In the screen of course. Try adding
```
this function to the screen load script then create a button on the screen to use the Get Register
```
function.
```
A similar process can be used in the macros. For example a file can be created named “macrofunctions”
```
that contains the Get Register function and any others that will be frequently used. The functions in this
file can be accessed by any of the other macros.
```
Another approach is to use a module. The module can conta in these functions then be loaded by the
```
screen load script or in a macro. The functions contained in the module can be used anywhere it is
loaded.
```
A function for writing to registers is also useful, and if very similar to the Get Register function above.
```
function Write Register( regname, regvalue)
```
local inst = mc.mc Get Instance()
local hreg = mc.mc Reg Get Handle( inst, string.format( "i Regs 0/%s", regname))
mc.mc Reg Set Value String( hreg, tostring( regvalue))
end

Using Write Register is also very simple.
Write Register( "Test 1", 1 2)

```
The example will write a value of 1 2 to the instance register “Test 1”. Again, this function does
everything as a string, this way strings or numbers can be sent and set to the registers. If a number is
```
passed into the function it will be converted to a string with the tostring function.
## 4.4 Saving Registers to Machine.ini
Since register values are not saved when Mach is closed it is necessary to create code to save any
desired registers. The easiest and most convenient place is in the Machine.ini file. One place for a
register save script is in the screen unload script. This script runs when the screen is unloaded/Mach 4 is
closed. Another place to save registers is in the code immediately following when they are set. The best
time and place to save registers to the .ini file will vary depending on the application.
```
To save a register to the .ini file use mc.mc Profile Write String(). To use this we need to define a section
in the .ini file to place the data, specify a name for the data and then the value. For this example let’s
assume the register ‘Test 1’ equals 6.
```
local inst = mc.mc Get Instance()

local hreg = mc.mc Reg Get Handle( inst, "i Regs 0/Test 1")
local val = mc.mc Reg Get Value( hreg)
val = tostring( val)

mc.mc Profile Write String( inst, "Registers", "Test 1", val)


<!-- Page 18 -->

1 8
This little bit of code gets the value of register ‘Test 1’ and then writes it to the Machine.ini file in a
section labeled as “Registers” with a name “Test 1”. The Machine.ini file will contain a section like this:
[Regist ers]
Test 1 = 6
If the section “Registers” does not exist it will be created, if it does the key “Test 1” will be added to it.
Writing data to the Machine.ini file is very useful for saving registers, but that is not the only application for it. Any data c an be saved for use later, custom screens may have configuration data that needs to be
stored, wizards may have information to store for next time, etc.
## 4.5 Loading Registers From Machine.ini
After data is saved to the Machine.ini file it is very useful to ret rieve it. For registers, this means that
they can be initialized with saved values when Mach 4 starts.
```
Like with saving to the Machine.ini file there is a function for loading from it, mc.mc Profile Get String().
For example, to get the previously saved valu e for “Test 1” and set it to the register of the same name
the code could be:
```
local inst = mc.mc Get Instance()

local val = mc.mc Profile Get String( inst, "Registers", "Test 1", "nf")

local hreg = mc.mc Reg Get Handle( inst, "i Regs 0/Test 1")
mc.mc Reg Set Value String( hreg, val)

In this code the variable ‘val’ is set to the value found in the Machine.ini file under the section
“Registers” and key “Test 1”. If there is no value found, ‘val’ will be set to “nf”, the default value we
```
defined in the mc.mc Profile Get String() function. This default value can be defined as anything, it will
only be used if there is no value found in the Machine.ini file. A unique value here can be useful to perform a specific action if the key does not exist in the .ini file or if a simple de fault value is desired.
5 Examples
The following examples are to provide some guidance on the creation of scripts. They are not specific to
any one machine and are not guar anteed to work on any machine.
## 5.1 Using Signals
Signals are internal triggers for events in Mach 4. They can be tied to external I/O, or internal events
such as running a Gcode file, jogging, feed hold, soft limit state, enabled state, etc. A common use for
signals in scripts will be to read the state of inputs, and set outputs active or inactive. Turning on/off
```
coolant, clamping fixtures, and special spindle functions, are all examples of when signals might be used
in a script. Here is a quick script for turning the spindle on, in the forward directi on, Mach signal
OSIG_SPINDLEFWD.
```
local inst = mc.mc Get Instance()
local hsig = mc.mc Signal Get Handle( inst, mc.OSIG_SPINDLEFWD)
local spinstate = mc.mc Signal Get State( hsig)
if (spindstate == 0) then
mc.mc Signal Set State( hsig, 1)


<!-- Page 19 -->

1 9
else
mc.mc Signal Set State( hsig, 0)
end

To use a signal we first need to know the handle, or Mach’s internal reference ID for the signal. Once we
know the handle, the state can be read and/or written to. By reading the state of OSIG_SPINDLEFWD we know if the spindle is on in the forward direction or not. We can then decide what to do based on
that information. This script will turn the spindle on in the forward direction if it is currently not running in forward, and will stop it if it is running in forward. This is a very sim ple example, but it shows the
basics of how to use signals.
## 5.2 Reading Data from an External File
Lua scripts are also capable of reading data from an external file, a .csv for example. This can be
extremely useful for providing a table of shapes for a wizard, or materials, positions for a tool changer,
etc. Having data in an external file can make it easier to edit by providing a formatted Excel spreadsheet for example, or make it more difficult by making the file read only.
For an example let’s make a .csv file that contains X, Y and Z positions of tools in a rack style tool
changer, we’ll call it “Tool Change Positions.csv”. This is what it will look like:
Looking at this table we can see that tool number 1 is at the position X 3.5, Y 2, Z -1 0. If we can read this
data into a table in a script it can be used to find the tool position in a tool change routine. Below is
what that script could look like.
For this a table makes the most sense for storing the tool position data. We can start by defining the
table TC_Positions.
Then we can find the .csv file and store the path to a variable, in this case CSVPath.
Next we open the file to read the data. Because we are going to have multiple pieces of data, tool
number and three positions, for each entry we will create a table for each entry within the TCPositions table. The variable Tool Num sets the ID of each entry, or line in the .csv. So we start with Tool Num = 0, the header information will land here. Then we increment Tool Num by 1 and run it again, so all the data
from the tool number 1 line in the .csv will be in the table TCPositions[1] table and so on. This loo p will
run until there is no more data in the .csv.
Just before incrementing Tool Num, we can set a max tool number in TCPositions so we know how many
tools have been defined. We will call this TCPositions[“Max”]. The value of this will be equal to the la st
tool number entered. So in this example TCPositions[“Max”] = 6. Tool_Number,X_Position,Y_Posi tion,Z_Position
1,3.5,2,- 1 0
2,5,2,-1 0
3,6.5,2,- 1 0
4,8,2,-1 0
5,9.5,2,- 1 0
6,1 1,2,-1 0


<!-- Page 20 -->

2 0
Now the position data can be used in a tool change script. The following lines show how to read and use
the data. This example script checks to make sure the selected tool number is grea ter than 0 but less
than or equal to the maximum. So if a user tried to select tool number 1 0 they would get the “ERROR:
Tool number out of range!” message. If the selected tool number is within the valid range then the tool
position data will be display ed in the message bar on the Mach 4 screen.
```
local TC_Positions = {}
```
local inst = mc.mc Get Instance()

```
local CSVPath = wx.wx Get Cwd() .. "\\Profiles\ \Your Profile\ \Modules\ \Tool Change Positions.csv"

Tool Num = 0;
--[[
Open the file and read out the data
--]]
io.input( io.open( CSVPath, "r"))
local line;
for line in io.lines( CSVPath) do
tkz = wx.wx String Tokenizer( line, ",");
```
TC_Positions[ Tool Num] = {}-- make a blank table in the positions table to hold the tool data
```
local token = tkz:Get Next Token();

TC_Positions[ Tool Num] ["Tool_Number"] = token;
```
TC_Positions[ Tool Num] ["X_Position"] = tkz:Get Next Token();
```
TC_Positions[ Tool Num] ["Y_Position"] = tkz:Get Next Token();
```
TC_Positions[ Tool Num] ["Z_Position"] = tkz:Get Next Token();
TC_Positions[ "Max"] = Tool Num --Set the max tool number
Tool Num = Tool Num + 1 --Increment the tool number
end
```
io.close()

--Read tool data
local Selected Tool Num = 1
local Max Tool Num = TC_Positions[ "Max"]

if (Selected Tool Num <= Max Tool Num) and (Selected Tool Num > 0) then
local Num = TC_Positions[ Selected Tool Num].Tool_Number
local XPos = TC_Positions[ Selected Tool Num].X_Position
local YPos = TC_Positions[ Selected Tool Num].Y_Position
local ZPos = TC_Positions[ Selected Tool Num].Z_Position

mc.mc Cntl Set Last Error( inst, string.format( "Tool: %.0 f | X: %.3 f | Y: %.3 f | Z: %.3 f", Num,
XPos, YPos, ZPos))
else
mc.mc Cntl Set Last Error( inst, "ERROR: Tool number out of range!")
end

## 5.3 Modules
Modules are scripts that can be accessed fro m any other script in Mach 4. This is useful if you have
```
functions or data that could be used in multiple types of scripts all throughout your Mach interface. This
```
could be reading and storing data for wizards, commonly used functions, or all of the speci al scripts and
```
functions used in the screen. For developers putting special or custom scripts in a module has the
benefit of being able to compile it so pieces of the code cannot be copied and reused somewhere.
```
Screen buttons that require lengthy scripts can be simple function calls to code in a compiled module.
For an example, the tool change position script from the previous section could be converted into a
module to be used by the tool change routine. This will simplify the tool change script itself and also
allow access to the data in other scripts.


<!-- Page 21 -->

2 1
The first step will be making some slight changes to the tool change positions script from the previous
example. It will be saved in the Modules folder as Tool Change Positions.lua.
```
local TC_Positions = {}
```
local inst = mc.mc Get Instance()

```
local CSVPath = wx.wx Get Cwd() .. "\\Profiles\ \Your Profile\ \Modules\ \Tool Change Positions.csv"

Tool Num = 0;
--[[
Open the file and read out the data
--]]
io.input( io.open( CSVPath, "r"))
local line;
for line in io.lines( CSVPath) do
tkz = wx.wx String Tokenizer( line, ",");
```
TC_Positions[ Tool Num] = {}-- make a blank table in the positions table to hold the tool data
```
local token = tkz:Get Next Token();
TC_Positions[ Tool Num] ["Tool_Number"] = token;
```
TC_Positions[ Tool Num] ["X_Position"] = tkz:Get Next Token();
```
TC_Positions[ Tool Num] ["Y_Position"] = tkz:Get Next Token();
```
TC_Positions[ Tool Num] ["Z_Position"] = tkz:Get Next Token();
TC_Positions[ "Max"] = Tool Num
Tool Num = Tool Num + 1;
end
```
io.close()
```
function TC_Positions.Get Tool Data( Selected Tool Num)
local Max Tool Num = TC_Positions[ "Max"]
if (Selected Tool Num <= Max Tool Num) and (Selected Tool Num > 0) then
return TC_Positions[ Selected Tool Num]
else
return nil
end
end
return TC_Positions

Reading through this new script we can see that it is mostly the same. The difference is an addition of a
```
function, TC_Positions.Get Tool Data(Selected Tool Num), to return the data associated with the desired
tool number back to the main program. This module can stay in the modules folder, and could also be
compiled and saved as a .mcc file instead of the .lua or .mcs formats. Any of the three formats are
acceptable. A compiled .mcc file has the benefit and drawback of not being editable or even viewable.
```
The function TC_Positions.Get Tool Data(Selected Tool Num) checks the selected tool number against the
max tool number and zero. If the selected tool number is in the valid range then the data is returned
using the return command: return TC_Positions[Selected Tool Num] . If the selected tool number is
outside the valid range then “nil” is returned. In the main program we can use this difference in
returned value to check if the tool number was valid or not.
The last line in the module is return TC_Positions . This line sends the table TC_Positions, with all of its
contents, back to the script that loaded the module.
Now for the main script, this is what would appear in the tool change script to get the tool change positions.
```
local inst = mc.mc Get Instance()
```
package.path = wx.wx Get Cwd() .. "\\Profiles\ \Your Profile\ \Modules\ \?.lua;"
if(package.loaded.Tool Change Positions == nil) then
tcp = require "Tool Change Positions"
end

local Selected Tool = mc.mc Tool Get Selected( inst)


<!-- Page 22 -->

2 2

Tool Data = tcp.Get Tool Data( Selected Tool)

if (Tool Data ~= nil) then
Num = Tool Data.Tool_Number
XPos = Tool Data.X_Position
YPos = Tool Data.Y_Position
ZPos = Tool Data.Z_Position

mc.mc Cntl Set Last Error( inst, string.format( "Tool: %.0 f | X: %.3 f | Y: %.3 f | Z: %.3 f", Num,
XPos, YPos, ZPos))
else
mc.mc Cntl Set Last Error( inst, "ERROR: Tool number out of range!")
end

The first part of this script set the file path for the module, or package, to load. The “?.lua” is like a wild
car. It’s looking for any file with the extension .lua, if you’re module is compiled this would need to be
changed to .mcc. The following if statement checks to see if the desired module, in this case
Tool Change Positions, is loaded to the variable “tcp”. Whatever is returned at the end of the module, in
our module the table “TC_Positions” is returned on the last line, is now contained in the variable tcp.
```
Now tool data can be retrieved by using the TC_Positions.Get Tool Data(Selected Tool) function. To call it
from the main script replace the variable name in the module with the new variable name that the
module was loaded to in the main script, tcp. So to get tool data for a selected tool we would call the
```
function tcp.Get Tool Data(Selcted Tool). In this example sc ript the command
mc.mc Tool Get Selected(inst) is used to get the currently selected tool from Mach, the last T number
commanded in a program or in MDI. So in the case of a tool change; if T 4 M 6 is commanded in a
program then calling mc.mc Tool Get Selected(ins t) in the M 6 macro will return a value of 4. Passing this
```
into our Get Tool Data function will return the position values for the selected tool provided that it is
within the acceptable range.
```
Now we can check to see if we got valid data back and use it if we did. If the function returns nil, then
we know that the tool number was outside the acceptable range and we can error and/or abort the
process.
## 5.4 Tool Change
In the previous examples we’ve been building up to a tool change macro for a rack style tool changer.
It’s time to put it all together. We will use the module for getting the tool position data, and the main
script from the last example will be the bones of our tool change script.
A couple thoughts before we write the script. 1.) A tool change routine should only execute if the tool
actually needs changing, there is no sense doing anything if the tool we want to change to is already in
the spindle. 2.) We will be moving the machine around and changing modal states and feedrates. It is a
good i dea to store the state of the machine prior to changing anything so it can be returned to that state
when the tool change is complete. This helps to avoid accidents from a machine unknowingly being
changed into incremental mode when it is expected to be i n absolute, bad feedrates being used because
they weren’t specified after a tool change, or any of a host of other possible issues. Best to avoid such
problems.
Let’s create an m 6 tool change script to use our module and change tools.
```
local inst = mc.mc Get Instance()


<!-- Page 23 -->

2 3
```
package.path = wx.wx Get Cwd() .. "\\Profiles\ \Your Profile\ \Modules\ \?.lua;"
if(package.loaded.Tool Change Positions == nil) then
tcp = require "Tool Change Positions"
end

```
function m 6()
------ Get and compare next and current tools ------
local Selected Tool = mc.mc Tool Get Selected( inst)
local Current Tool = mc.mc Tool Get Current( inst)
if (Selected Tool == Current Tool) then
mc.mc Cntl Set Last Error( inst, "Next tool = Current tool")
do return end
end

------ Get current state ------
local Cur Feed = mc.mc Cntl Get Pound Var( inst, 2 1 3 4)
local Cur Feed Mode = mc.mc Cntl Get Pound Var( inst, 4 0 0 1)
local Cur Abs Mode = mc.mc Cntl Get Pound Var( inst, 4 0 0 3)

------ Get position data for current tool ------
Tool Data = tcp.Get Tool Data( Current Tool)
if (Tool Data ~= nil) then
Num 1 = Tool Data.Tool_Number
XPos 1 = Tool Data.X_Position
YPos 1 = Tool Data.Y_Position
ZPos 1 = Tool Data.Z_Position
else
mc.mc Cntl EStop(inst)
mc.mc Cntl Set Last Error( inst, "ERROR: Tool number out of range!")
do return end
end

------ Get position data for next tool ------
Tool Data = tcp.Get Tool Data( Selected Tool)
if (Tool Data ~= nil) then
Num 2 = Tool Data.Tool_Number
XPos 2 = Tool Data.X_Position
YPos 2 = Tool Data.Y_Position
ZPos 2 = Tool Data.Z_Position
else
mc.mc Cntl EStop(inst)
mc.mc Cntl Set Last Error( inst, "ERROR: Tool number out of range!")
do return end
end

------ Move to current tool change position ------
local GCode = ""
GCode = GCode .. "G 0 0 G 9 0 G 5 3 Z 0.0\ n"
GCode = GCode .. string.format( "G 0 0 G 9 0 G 5 3 X%.4 f Y%.4 f\ n", XPos 1, YPos 1)
GCode = GCode .. string.format( "G 0 0 G 9 0 G 5 3 Z%.4 f\n", ZPos 1 + 1.0)
GCode = GCode .. string.format( "G 0 1 G 9 0 G 5 3 Z%.4 f F 1 5.0\ n", ZPos 1)
mc.mc Cntl Gcode Execute Wait( inst, GCode)

------ Release drawbar ------
local Draw Bar Out = mc.OSIG_OUTPUT 4
local hsig = mc.mc Signal Get Handle( inst, Draw Bar Out)
mc.mc Signal Set State( hsig, 1)

------ Move to next tool change position ------
GCode = ""
GCode = GCode .. string.format( "G 0 1 G 9 0 G 5 3 Z%.4 f\ n F 1 5.0", ZPos 1 + 1.0)
GCode = GCode .. "G 0 0 G 9 0 G 5 3 Z 0.0\ n"
GCode = GCode .. string.format( "G 0 0 G 9 0 G 5 3 X%.4 f Y%.4 f\ n", XPos 2, YPos 2)
GCode = GCode .. string.format( "G 0 0 G 9 0 G 5 3 Z%.4 f\ n", ZPos 2 + 1.0)
GCode = GCode .. string.format( "G 0 1 G 9 0 G 5 3 Z%.4 f F 1 5.0\ n", ZPos 2)
mc.mc Cntl Gcode Execute Wait( inst, GCode)

------ Clamp drawbar ------
mc.mc Signal Set State( hsig, 0)

------ Move Z to home position ------


<!-- Page 24 -->

2 4
mc.mc Cntl Gcode Execute Wait( inst, "G 0 0 G 9 0 G 5 3 Z 0.0\ n")

------ Reset state ------
mc.mc Cntl Set Pound Var( inst, 2 1 3 4, Cur Feed)
mc.mc Cntl Set Pound Var( inst, 4 0 0 1, Cur Feed Mode)
mc.mc Cntl Set Pound Var( inst, 4 0 0 3, Cur Abs Mode)

------ Set new tool ------
mc.mc Tool Set Current( inst, Selected Tool)
mc.mc Cntl Set Last Error( inst, string.format( "Tool change - Tool: %.0 f", Selected Tool))

end

```
if (mc.mc In Editor() == 1) then
```
m 6()
end

Each section of the tool change macro is labeled to make it easier to follow. We’ve combined all the
code examples from the previous examples to arrive here, with a couple new addition s. Let’s walk
through it.
The first section of the code loads the module we will be using to look up the tool positions. This is
```
positioned outside the m 6() function so that it can be available to all M codes without having to call it in
every macro it i s used in.
```
Next is the m 6() function. Recall that an M code requires a function of the same name to call. In this
```
case an M 6 in the program will call the m 6() function.
```
Now, inside the function is the meat of the tool change. The first section, “Get and compare next and
current tools,” gets the next tool and current tool and compares them to make sure a tool change
should happen. If the current tool in the spindle is the tool to be changed to exit the script.
Previously we talked about getting the curre nt state of the machine prior to changing anything so we
can set it back the way we found it when the script exits. The next section, “Get current state,” retrieves
that data for us and saves it for later.
The next two sections, “Get position data…,” does just what it says. This is the section of the script that
```
accesses the “Tool Change Positions” module that we created. These two sections function just like the code we developed in the module example. After getting the tool position data it is checked t o make
sure a valid selection was made. This error also needs to stop the machine or it will just keep running
the program when the script is exited, this is big potential for a crash. In this example and E -stop
command is given when an invalid tool is s elected to make sure the machine is incapable of continuing
when the script is exited. This way if the selection is invalid we exit the script with an error rather than
get part way thru a tool chang e and then error for bad data.
If the tool selection is valid for both tools we move ahead to the next sections which perform the actual tool change motion. The “Move to current tool change position,” executes a short G code program to move the machine to the spot in the rack for the tool currently in the spin dle.
The “Release drawbar” section does just that. Using the code from the example in section 5.1 we can
make a bit of code to activate the output that controls the drawbar.
After releasing the tool the sections, “Move to next tool change position”, “Clam p drawbar”, and “Move
to Z home position” continue the rest of the machine motion to pick up the next tool and return home.


<!-- Page 25 -->

2 5
After all the motion of actually changing tools, we can “Reset state” back to what it was before entering
the macro. The last thing to do is reset the current tool to the new tool in the “Set new tool” section.
```
That ends the m 6() function.
Below that is an if statement to check if the script is open in an editor. As discussed before this is for
debugging, so when in the editor the f unction will be called.
## 5.5 Automatic Tool Height Setting
There are several ways to create an automat ic tool height setting process. It could be written in G code
or in a Lua script. Since this is a Lua scripting manual we’ll show one way to set tools using a Lua script.
This example puts the auto tool height setting script in an M code for easy access from anywhere in
Mach. It can be executed from a button or in a program. The following program is an example of an M
code for automatically setting the heig ht of a tool. There are a number of necessary parameters that
are stored in registers, so it is necessary to get those values before performing the operation. This script
follows the same format as the tool change macro example in section 5.4.
A brief ru n through: As before the first step in the script is getting and defining necessary variables and
```
the current state of the machine. Register values are retrieved using the Get Register() function created
in section 4.3. It is not defined in this script s o it must be defined in an M code header file or a loaded
module to allow access to it.
The next sections calculate the position on the touch off sensor and use a G 3 1 probing move the tool
into the sensor. The state of the sensor’s signal is checked befor e movement to make sure it is not
already active, and the checked again after it is touched to make sure that it was indeed contacted. This
is all error checking and although it is not required it is strongly suggested.
Following the actually tool touch o ff movement, the offset length is calculated and set and then
everything returned to its previous state.
-----------------------------------------------------------------------------
-- Auto Tool Setting Macro
-----------------------------------------------------------------------------
--[[
Requires the following instance registers to be defined
TS_XPos-----------X position of probe (machine position)
TS_YPos-----------Y position of probe (machine position)
TS_Type-----------Offset type (1 or 2)
TS_Touch Pos-------Z position of touch off surface (machine position)
TS_Probe H---------Height of probe above touch off surface
TS_Default L-------Default tool length guess
TS_Retract--------Retract distance after probe touch

Offset Type 1-----Length of tool from gauge line to tip
Offset Type 2-----Distance from tip of tool to the touch position
]]
```
--The function Get Register() must be defined for use by macros
```
function m 1 0 0 5()
```
local inst = mc.mc Get Instance()

------------- Define Vars -------------
local Probe Signal = mc.ISIG_DIGITIZE

------------- Get current state -------------
local Cur Tool = mc.mc Tool Get Current( inst)
local Cur HNum = mc.mc Cntl Get Pound Var( inst, 2 0 3 2)
local Cur Feed = mc.mc Cntl Get Pound Var( inst, 2 1 3 4)
local Cur ZOffset = mc.mc Cntl Get Pound Var( inst, 4 1 0 2)


<!-- Page 26 -->

2 6
local Cur Feed Mode = mc.mc Cntl Get Pound Var( inst, 4 0 0 1)
local Cur Abs Mode = mc.mc Cntl Get Pound Var( inst, 4 0 0 3)

------------- Get touch off parameters -------------
local Xpos = Get Register( "TS_XPos", 1)
local Ypos = Get Register( "TS_YPos", 1)
local Offset Type = Get Register( "TS_Type", 1)
local Touch Pos = Get Register( "TS_Touch Pos", 1)
local Probe Height = Get Register( "TS_Probe H", 1)
local Retract Distance = Get Register( "TS_Retract", 1)
local Tool Length Guess = Get Register( "TS_Default L", 1)

------------- Check Probe -------------
local hsig = mc.mc Signal Get Handle( inst, Probe Signal)
local Probe State = mc.mc Signal Get State( hsig)
if (Probe State == true) then
mc.mc Cntl Set Last Error( inst, "ERROR: Probe signal is activated")
do return end
end

------------- Calculations for Gcode -------------
local Start Height = Touch Pos + Probe Height + Tool Length Guess + .5

------------- Generate GCode -------------
Auto Tool Set GCode = ""
Auto Tool Set GCode = Auto Tool Set GCode .. "G 0 0 G 8 0 G 4 0 G 4 9 G 9 0\ n"
Auto Tool Set GCode = Auto Tool Set GCode .. "G 0 0 G 5 3 Z 0.0\ n"
Auto Tool Set GCode = Auto Tool Set GCode .. string.format( "G 0 0 G 5 3 X%.4 f Y%.4 f\ n", Xpos, Ypos)
Auto Tool Set GCode = Auto Tool Set GCode .. string.format( "G 0 0 G 5 3 Z%.4 f\ n", Start Height)
Auto Tool Set GCode = Auto Tool Set GCode .. "G 9 1 G 3 1 Z- 2.0 F 2 5.\n"

mc.mc Cntl Gcode Execute Wait( inst, Auto Tool Set GCode)

--Check probe contact
Probe State = mc.mc Signal Get State( hsig)
if (Probe State ~= 1) then
mc.mc Cntl Set Last Error( inst, "ERROR: No contact with probe")
mc.mc Cntl Gcode Execute Wait( inst, "G 0 G 9 0 G 5 3 Z 0.0\ n")
do return end
end

Auto Tool Set GCode = ""
Auto Tool Set GCode = Auto Tool Set GCode .. string.format( "G 9 1 G 0 0 Z%.4 f\ n", Retract Distance)
Auto Tool Set GCode = Auto Tool Set GCode .. "G 9 1 G 3 1 Z- 1.0 F 1 0.\ n"

mc.mc Cntl Gcode Execute Wait( inst, Auto Tool Set GCode)

--Check probe contact
Probe State = mc.mc Signal Get State( hsig)
if (Probe State ~= 1) then
mc.mc Cntl Set Last Error( inst, "ERROR: No contact with probe")
mc.mc Cntl Gcode Execute Wait( inst, "G 0 G 9 0 G 5 3 Z 0.0\ n")
do return end
end

Auto Tool Set GCode = ""
Auto Tool Set GCode = Auto Tool Set GCode .. "G 9 0 G 0 0 G 5 3 Z 0.0\ n"

mc.mc Cntl Gcode Execute Wait( inst, Auto Tool Set GCode)

------------- Get touch position and set offset -------------
local ZProbed = mc.mc Cntl Get Pound Var( inst, 5 0 6 3)
local ZOffset = ZProbed - Probe Height + Cur ZOffset
if (Offset Type == 1) then
ZOffset = math.abs( Touch Pos - ZOffset)
end

mc.mc Tool Set Data( inst, mc.MTOOL_MILL_HEIGHT, Cur Tool, ZOffset)
mc.mc Cntl Set Last Error( inst, string.format( "Auto tool setting complete, Offset = %.4 f",
ZOffset))


<!-- Page 27 -->

2 7
------------- Set previous state -------------
mc.mc Cntl Set Pound Var( inst, 2 1 3 4, Cur Feed)
mc.mc Cntl Set Pound Var( inst, 4 0 0 1, Cur Feed Mode)
mc.mc Cntl Set Pound Var( inst, 4 0 0 3, Cur Abs Mode)

end

```
if (mc.mc In Editor() == 1) then
```
m 1 0 0 5()
end

## 5.6 Wizards
```
Wizards are tools that can be created and used to perform common function. In Mach 4 a wizard is
usually a graphical interface for creating G code files, very similar to conversation programming on some
machines. Lua gives the programmer the ability to cr eate a wizard for anything; hole patterns, fac ing,
engraving, spirals, loops, play music. Included with Mach 4 is a bolt circle wizard designed to show users
how wizards can be built. It is written to be easy for a user to modify to create their own wizar d.
Wizard scripts should be located in the “Wizards” folder in the Mach 4 root directory. The “Load
Wizards” button on the default Mach 4 screen will load the scripts located here. When the “Bolt Hole Circle” wizard is run it will open a window:

Figure 5-1: Bolt Hole Circle Wizard
```
This window is created using the functions and variables laid out in the script. There is a lot going on is
this script to create the window layout and setup the buttons. Because a lot of the programming for the
window itself is out of the scope of this manual, we will stick to discussing how and where to modify this
```
to create anoth er wizard. The only parts to worry about are the functions: Setupinputs(), Save Settings(),


<!-- Page 28 -->

2 8
```
Gen Gcode(), and variables “m_ini Name” and “m_image”. Following is the code to create the bolt circle
wizard:
-----------------------------------------------------------------------------
-- Name: Bolt Holelua
-- Author: B Barker
-- Modified by:
-- Created: 0 8/0 3/2 0 1 3
-- Copyright: (c) 2 0 1 3 Newfangled Solutions. All rights reserved.
-- Licence: BSD license
-----------------------------------------------------------------------------

```
function Get Next ID()
m_id = m_id+1
return m_id
end
```
--global var to hold the frame
mainframe = nil
panel = nil
m_id = 0
m_ini Name = "Circle Hole Pat"

```
ID_GENGCODE_BUT = Get Next ID()
```
ID_CLOSE_BUTTON = Get Next ID()
```
m_image = wx.wx Get Cwd() .. "\\Wizards\ \Holes New.png"

```
function Setupinputs()
--Add all the inputs
local val
m_center_x = Add Input Control( "Hole Center X", nil)
m_center_x: Set Value( mc.mc Profile Get String( 0 , tostring( m_ini Name), "Xcenter", "0.0 0 0") )
m_center_y = Add Input Control( "Hole Center Y", nil)
m_center_y: Set Value( mc.mc Profile Get String( 0 , tostring( m_ini Name), "Ycenter", "0.0 0 0") )
m_circle_dia = Add Input Control( "Bolt Circle Dia", nil)
m_circle_dia: Set Value( mc.mc Profile Get String( 0 , tostring( m_ini Name), "Dia", "5.0") )
m_Num Holes = Add Input Control( "Number Of Holes", nil)
m_Num Holes: Set Value( mc.mc Profile Get String( 0 , tostring( m_ini Name), "Holes", "5") )
m_Start Angle = Add Input Control( "Start Angle", nil)
m_Start Angle: Set Value( mc.mc Profile Get String( 0 , tostring( m_ini Name), "Startangle", "0.0 0 0")
)
m_z_depth = Add Input Control( "Hole Depth", nil)
m_z_depth: Set Value( mc.mc Profile Get String( 0 , tostring( m_ini Name), "Depth", "-1.1 2 0 0") )
m_rapid_height = Add Input Control( "Rapid Height", nil)
m_rapid_height: Set Value( mc.mc Profile Get String( 0 , tostring( m_ini Name), "Rapid Height",
"1.0 0 0") )
m_retract_height = Add Input Control( "Retract Height", nil)
m_retract_height: Set Value( mc.mc Profile Get String( 0 , tostring( m_ini Name), "Retract Height",
".1 0 0") )
m_peck_depth = Add Input Control( "Peck Depth", nil)
m_peck_depth: Set Value( mc.mc Profile Get String( 0 , tostring( m_ini Name), "Peck Depth", ".1 2 5") )
m_feedrate = Add Input Control( "Feedrate", nil)
m_feedrate: Set Value( mc.mc Profile Get String( 0 , tostring( m_ini Name), "Feed", "1 0") )
```
m_cycletype, ID_CYCLE_TYPE = Add Select Control( "Drill cylce", {"G 8 1 Single pass", "G 8 3 Peck
```
Drill", "G 7 3 High speed Peck"}, ID_CYCLE_TYPE)
local val = mc.mc Profile Get String( 0 , tostring( m_ini Name), "Cycle", "0")
m_cycletype: Set Selection( tonumber( val))
```
m_spindle = Add Select Control( "Spindle Dir", {"None", "CW", "CCW"}, nil)

m_Test = Add Check Control( "Check me")

m_Test 2 = Add Radio Control( "Radio killed the video star")
Add Radio Control( "yes")
Add Radio Control( "No ")
Add Radio Control( "okay")

end
```
function Save Settings()

```
mc.mc Profile Write String( 0 , tostring( m_ini Name), "Xcenter", tostring( m_center_x: Get Value()))


<!-- Page 29 -->

2 9
```
mc.mc Profile Write String( 0 , tostring( m_ini Name), "Ycenter", tostring( m_center_y: Get Value()))
```
mc.mc Profile Write String( 0 , tostring( m_ini Name), "Dia", tostring( m_circle_dia: Get Value()))
```
mc.mc Profile Write String( 0 , tostring( m_ini Name), "Holes", tostring( m_Num Holes: Get Value()))
```
mc.mc Profile Write String( 0 , tostring( m_ini Name), "Depth", tostring( m_z_depth: Get Value()))
mc.mc Profile Write String( 0 , tostring( m_ini Name), "Rapid Height",
```
tostring( m_rapid_height: Get Value()))
mc.mc Profile Write String( 0 , tostring( m_ini Name), "Retract Height",
```
tostring( m_retract_height: Get Value()))
mc.mc Profile Write String( 0 , tostring( m_ini Name), "Peck Depth",
```
tostring( m_peck_depth: Get Value()))
```
mc.mc Profile Write String( 0 , tostring( m_ini Name), "Feed", tostring( m_feedrate: Get Value()))
mc.mc Profile Write String( 0 , tostring( m_ini Name), "Cycle",
```
tostring( m_cycletype: Get Current Selection()))
end
```
function Gen Gcode()
```
local x_center = m_center_x: Get Value()
```
local y_center = m_center_y: Get Value()
```
local numberofholes = m_Num Holes: Get Value()
```
local dia = m_circle_dia: Get Value()
```
local st Angle = (math.pi/ 1 8 0)*m_Start Angle: Get Value()
```
local Rapid Height = m_rapid_height: Get Value()
```
local retheight = m_retract_height: Get Value()
```
local peck = m_peck_depth: Get Value()
```
local feed = m_feedrate: Get Value()
```
local depth = m_z_depth: Get Value()
local gcode = string.format( "G 0 0 Z%.4 f\ n", Rapid Height)

```
local drilltype = m_cycletype: Get Current Selection()

local x = x_center+(dia/ 2)*math.cos( st Angle);
local y = y_center+(dia/ 2)*math.sin( st Angle);

```
local spin = m_spindle: Get Current Selection()
if( spin == 0)then
gcode = gcode .. "(No Spindle M Code)\ n"
elseif( spin == 1) then
gcode = gcode .. "M 0 3 (Spinle CW)\ n"
elseif( spin == 2) then
gcode = gcode .. "M 0 4 (Spinle CCW)\ n"
end

if( drilltype == 0)then
gcode = gcode .. string.format( "G 8 1 X%.4 f Y%.4 f Z%.4 f R%.4 f F%.4 f\ n", x, y, depth,
retheight, feed )
elseif( drilltype == 1) then
gcode = gcode .. string.format( "G 8 3 X%.4 f Y%.4 f Z%.4 f R%.4 f Q%.4 f F%.4 f\ n", x, y,
depth, retheight, peck, feed )
elseif( drilltype == 2) then
gcode = gcode .. string.format( "G 7 3 X%.4 f Y%.4 f Z%.4 f R%.4 f Q%.4 f F%.4 f\ n", x, y,
depth, retheight, peck, feed )
end

local Step Ang= (2*math.pi)/numberofholes;
local i
for i=1, numberofholes- 1, 1 do
x =x_center+(dia/ 2)*math.cos( st Angle+(Step Ang* i));
y =y_center+(dia/ 2)*math.sin( st Angle+(Step Ang* i));
gcode = gcode .. string.format( "X%.4 f Y%.4 f\ n", x, y )
end
gcode = gcode .. "G 8 0\n M 0 5\n M 3 0"

local file = wx.wx File Dialog( panel, "Select Gcode File", "", "", "Text files
(*.txt)|*.txt|Tap files (*.tap)|*.tap",
wx.wx FD_SAVE, wx.wx Default Position, wx.wx Default Size, "File Dialog"
);
```
if( file:Show Modal() == wx.wx ID_OK) then
```
local path = file:Get Path()
--wx.wx Message Box(tostring(path))
io.output( io.open( path,"w"))
io.write( gcode)
```
io.close()


<!-- Page 30 -->

3 0
mc.mc Cntl Load Gcode File( 0, tostring( path))
end
```
Save Settings()
end
```
function main()

if(mc Lua Panel Parent == nil)then
-- create the wx Frame window
mainframe = wx.wx Frame( wx.NULL, -- no parent
wx.wx ID_ANY, -- whatever for wx Window ID
"Mach 4 Bolt Hole Wizard", -- frame caption
wx.wx Default Position, -- place the frame in default position
wx.wx Default Size, -- default frame size
wx.wx DEFAULT_FRAME_STYLE ) -- use default frame styles

-- create a panel in the frame
panel = wx.wx Panel( mainframe, wx.wx ID_ANY)

-- create a simple file menu with an exit
```
local file Menu = wx.wx Menu()
file Menu: Append(wx.wx ID_EXIT, "E&xit", "Quit the wizard")

-- create a simple help menu
```
local help Menu = wx.wx Menu()
help Menu: Append(wx.wx ID_ABOUT, "&About", "About Bolt Hole Wizard")

-- create a menu bar and append the file and help menus
```
local menu Bar = wx.wx Menu Bar()
menu Bar: Append(file Menu, "&File")
menu Bar: Append(help Menu, "&Help")

-- attach the menu bar into the frame
mainframe: Set Menu Bar( menu Bar)

-- create a simple status bar
mainframe: Create Status Bar( 1)
mainframe: Set Status Text( "No Error.")

-- connect the selection event of the exit menu item to an
-- event handler that closes the window
mainframe: Connect( wx.wx ID_EXIT,
wx.wx EVT_COMMAND_MENU_SELECTED,
```
function (event)
mainframe: Close(true)
end )

-- connect the selection event of the about menu item
mainframe: Connect( wx.wx ID_ABOUT, wx.wx EVT_COMMAND_MENU_SELECTED,
```
function (event)
wx.wx Message Box( "Bolt Hole pattern wizard \n\n Author: Brian Barker\ n Date:
8/3/1 3\n This wizard is to be used as an example of how to make a wizard",
"About wx Lua",
wx.wx OK + wx.wx ICON_INFORMATION,
mainframe)
end )

else
panel = mc Lua Panel Parent
end

--Set up the main sizer so we can start adding controls
local main Sizer = wx.wx Box Sizer( wx.wx VERTICAL)
local Inputs Grid Sizer = wx.wx Flex Grid Sizer( 2, 4, 0, 0 )
Inputs Grid Sizer: Add Growable Col( 1, 0)

```
function Add Input Control( name_string, width)
if( width == nil)then
width = 1 0 0
end
```
local text Ctrl ID = Get Next ID()
local static Text = wx.wx Static Text( panel, wx.wx ID_ANY, name_string)


<!-- Page 31 -->

3 1
local text Ctrl = wx.wx Text Ctrl( panel, text Ctrl ID, "0.0 0 0", wx.wx Default Position,
wx.wx Size( width, -1), wx.wx TE_PROCESS_ENTER ,wx.wx Text Validator( wx.wx FILTER_NUMERIC))
Inputs Grid Sizer: Add( static Text, 0, wx.wx ALIGN_CENTER_VERTICAL+ wx.wx ALL+ wx.wx ALIGN_RIGHT,
2)
Inputs Grid Sizer: Add( text Ctrl, 0, wx.wx GROW+ wx.wx ALIGN_CENTER+ wx.wx ALL+ wx.wx ALIGN_LEFT,
2)
return text Ctrl, text Ctrl ID
end

```
function Add Check Control( name_string)
```
local ID = Get Next ID()
local static Text = wx.wx Static Text( panel, wx.wx ID_ANY, name_string)
local Ctrl = wx.wx Check Box( panel, ID, "", wx.wx Default Position, wx.wx Default Size,
wx.wx TE_PROCESS_ENTER ,wx.wx Text Validator( wx.wx FILTER_NUMERIC))
Inputs Grid Sizer: Add( static Text, 0, wx.wx ALIGN_CENTER_VERTICAL+ wx.wx ALL+ wx.wx ALIGN_RIGHT,
2)
Inputs Grid Sizer: Add( Ctrl, 0, wx.wx GROW+ wx.wx ALIGN_CENTER+ wx.wx ALL+ wx.wx ALIGN_LEFT, 2)
return Ctrl, ID
end

```
function Add Radio Control( name_string)
```
local ID = Get Next ID()
local sizer = wx.wx Box Sizer( wx.wx HORIZONTAL )
local Ctrl = wx.wx Radio Button( panel, ID, name_string, wx.wx Default Position,
wx.wx Default Size, wx.wx TE_PROCESS_ENTER ,wx.wx Text Validator( wx.wx FILTER_NUMERIC))
Inputs Grid Sizer: Add( sizer, 0, wx.wx ALIGN_CENTER_VERTICAL+ wx.wx ALL+ wx.wx ALIGN_RIGHT, 2)
Inputs Grid Sizer: Add( Ctrl, 0, wx.wx GROW+ wx.wx ALIGN_CENTER+ wx.wx ALL+ wx.wx ALIGN_LEFT, 2)
return Ctrl, ID
end

```
function Add Select Control( name_string, selections, sel Ctrl ID)
```
local sel Ctrl ID = Get Next ID()
local static Text = wx.wx Static Text( panel, wx.wx ID_ANY, name_string )
local sel Ctrl = wx.wx Combo Box( panel, sel Ctrl ID, "", wx.wx Default Position,
wx.wx Size( 1 0 0, -1), selections)
sel Ctrl: Set Selection( 0)
Inputs Grid Sizer: Add( static Text, 0, wx.wx ALIGN_CENTER_VERTICAL+ wx.wx ALL+ wx.wx ALIGN_RIGHT,
2)
Inputs Grid Sizer: Add( sel Ctrl, 0, wx.wx GROW+ wx.wx ALIGN_CENTER, 2)
return sel Ctrl, sel Ctrl ID
end
-- Add image to the top
local hbmp = wx.wx Bitmap( m_image)
local Top Image = wx.wx Static Bitmap( panel, wx.wx ID_ANY, hbmp )
--Setup the inputs
```
Setupinputs()

-- make the bottom buttons
local button Sizer = wx.wx Box Sizer( wx.wx HORIZONTAL )
local gen Gcode = wx.wx Button( panel, ID_GENGCODE_BUT, "&Post Gcode")
gen Gcode: Set Background Colour( wx.wx Colour( 0,2 5 5, 1 2 8))

button Sizer: Add( gen Gcode, 0, wx.wx ALIGN_CENTER+ wx.wx ALL, 2 )
if(mc Lua Panel Parent == nil)then
local close Button = wx.wx Button( panel, ID_CLOSE_BUTTON, "E&xit")
button Sizer: Add( close Button, 0, wx.wx ALIGN_CENTER+ wx.wx ALL, 2 )
end

--Set up the sizers
main Sizer: Add( Top Image, 0, wx.wx ALIGN_CENTER+ wx.wx ALL, 2 )
main Sizer: Add( Inputs Grid Sizer, 0, wx.wx ALIGN_CENTER+ wx.wx ALL, 2 )
main Sizer: Add( button Sizer, 0, wx.wx ALIGN_CENTER+ wx.wx ALL, 2 )

panel: Set Sizer( main Sizer )

panel: Connect( ID_GENGCODE_BUT, wx.wx EVT_COMMAND_BUTTON_CLICKED,
```
function( event)
```
Gen Gcode()
end)

panel: Connect( ID_CYCLE_TYPE, wx.wx EVT_COMMAND_COMBOBOX_SELECTED,


<!-- Page 32 -->

3 2
```
function( event)
```
if( m_cycletype: Get Current Selection() == 0)then
m_peck_depth: Set Editable( false)
m_peck_depth: Set Background Colour( wx.wx Colour( "LIGHT GRAY"))
else
m_peck_depth: Set Editable( true)
m_peck_depth: Set Background Colour( wx.wx Colour( wx.wx Null Colour))
end

end)

-- Connect a handler for pressing enter in the textctrls
panel: Connect( wx.wx ID_ANY, wx.wx EVT_COMMAND_TEXT_ENTER,
```
function( event)
-- Send "fake" button press to do calculation.
-- Button ids have been set to be - 1 from textctrl ids.
```
-- dialog:Process Event(wx.wx Command Event(wx.wx EVT_COMMAND_BUTTON_CLICKED, event:Get Id()-
1))
end)

-- show the frame window

if(mc Lua Panel Parent == nil)then
panel: Connect( ID_CLOSE_BUTTON, wx.wx EVT_COMMAND_BUTTON_CLICKED,
```
function( event) mainframe: Destroy() end)
```
panel: Fit()
```
mainframe: Fit()
mainframe: Show(true)
end
end

```
main()

```
wx.wx Get App():Main Loop()

First is “m_ini Name”. Variable values from the input boxes will be stored in a section in the machine.ini
file. Set “m_ini Name” to be something descriptive, usually similar to the name of the wizard. This helps
with organization in the .ini file.
m_ini Name = "Circle Hole Pat"

Next is “m_image.” This variable sets the pa th to the image to be displayed at the top of the wizard
window. Change the file path and name to match the location of the desired image.
```
m_image = wx.wx Get Cwd() .. \\Wizards\ \Holes New.png
```
The first function is Setupinputs(). This function defines the inputs to be displayed at the bottom of the
wizard window. The formatting is already done, all that is required is to add or remove lines and
rename them to the desired variable and descripti on. Generally each input will have two lines of code,
```
the first calls the function Add Input Control() to add the label and input box to the wizard window. In
the snippet below “m_center_x” will be assigned the value of whatever is input into the input box
labeled “Hole Center X”. The second line sets the value of “m_center_x” and the input box to the last
value that was saved in the machine.ini file, in the “Circle Hole Pat” section with the handle “Xcenter”. If
there is no value in the .ini then a default value of 0.0 0 will be assigned.
m_center_x = Add Input Control( "Hole Center X", nil)
m_center_x: Set Value( mc.mc Profile Get String( 0 , tostring( m_ini Name), "Xcenter", "0.0 0 0") )


<!-- Page 33 -->

3 3

Drop down selection boxes are also possible using the following format:
```
m_spindle = Add Select Control( "Spindle Dir", {"None", "CW", "CCW"}, nil)
```
Radio controls and check boxes also have functions for easy creation.
m_Test = Add Check Control( "Check me")

m_Test 2 = Add Radio Control( "Radio killed the video star")

## 5.7 Modbus

