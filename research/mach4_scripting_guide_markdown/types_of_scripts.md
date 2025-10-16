# 3 Types of Scripts

---
**Navigation:** ← [Previous: 2 Script Editor](script_editor.md) | [Next: 4 Registers](registers.md) → | [📋 Table of Contents](table_of_contents.md)
---

# Types of Scripts
Scripts are divided into 4 types: M codes, screen, panel and modules.  This chapter will discuss the differences in and interactions between these types.
## M codes
M codes, or miscellaneous functions, are used to create additional functionality in a machine.  They are specified in a G code program or in the MDI mode.  The functions can range from turning on and off coolant to changing tools, to custom code to engrave a serial number.  With the ability to script custom macro M codes the possible functions are as diverse and varied as the machines and operators running them.  M code scripts use a .mcs file extension.
### Scriptable M codes
Scripts cannot be written for all M codes, some have functions that are defined in Mach4 and will only perform that function.  Below is a list of the M codes and how they interact with user scripts and internal functions.
**User Scriptable/No Internal Function**
**User Scriptable And Internal Function**
**Internal Function Only**
M6
M3 to M5
M00 to M02
M10 to M45
M7-M9
M46 to M48
M50 to M61
M30
M62 to M65
M66 to M95
M47
M96 to M99
M100 and up
M codes in the column “User Scriptable/No Internal Function” are completely open to user scripts.  There is not function associated to them in Mach4.
M codes in the column “User Scriptable And Internal Function” have internal functions in Mach4, but also allow user scripts.  These codes are further divided into those that call the function internal to Mach4 OR a user script and those that run both.  M3 to M5 and M7 to M9 are codes that control the spindle and coolant functions.  If there is no user script for these codes they turn on/off their respective signals as defined inside Mach4.  However, if a user script is present, the script will be run instead.  This gives the user the power to create custom codes for custom spindle and coolant applications, but if the machine simply needs to turn on/off an output, no programming is required.
M30 and M47 are both codes that show up at the end of a program.  As they are required to end and/or rewind the G code execution their internal functions cannot be ignored.  However, it is useful to have a script execute at the end of a program, a parts counter for instance.  For this reason both codes will execute a user script if it is present.  After executing the script the M30 and M47 will execute the internal function of ending/rewinding the program.
The last column is “Internal Function Only.”  M codes found in this column will only execute their internal functions and will NOT execute a user script, even if one is present.
### M Code Macro Folder
Using custom M codes requires the scripts to be located in the ‘Macros’ folder located in the folder for the desired profile.  Navigate to the Mach4 root directory, usually located on the C drive, open the ‘Profiles’ folder, then open the folder of the desired profile.  The name of the folder will be the name of the profile, ‘Mach4Mill’ for example.  The ‘Macros’ folder will be located in this profile folder.
Every script file in this folder will be compiled into one file.  If a custom M code is desired it must have an associated file in this folder named in the format M3.mcs, replace the 3 with whatever M code is desired.  The format of the script is important as well.  Because all the files get compiled into one, each M code must be its own function.
**function** m3**()**
inst**=**mc.mcGetInstance**()**
mc.mcCntlSetLastError**(**inst**,** 'Spindle Clockwise'**)**
mc.mcSpindleSetDirection**(**inst**,** 1**) ****end**
**if** **(**mc.mcInEditor**()** **==** 1**)** **then**
m3**()**
**end**
Above is an example of a custom script for the M code M3.  The name of this file is m3.mcs (Note the lower case file name).  Reading through the script the main chunk is the function m3() (Note the lower case function name).  This is the function that will be called when an M3 is commanded in a G code file or MDI.  The second part of this script is for debugging purposes.  When the script is open in the editor nothing would happen when it was run unless there was some code to call the m3() function.  However, if there was simply and m3() line to call it, the M code would be executed as soon as Mach4 loads.  The if statement checks to see if the script is open in the editor, if it is, then the m3() will be executed.  Otherwise the function will need to be called from a G code program or MDI command.
Again, it is important to note that the M code script file names needs to be lower case as well as the functions names inside the modules.  Mixing in upper case letters will not work.
## Screen Scripts
The screen contains scripts than run on load and unload and a plc script.  Certain screen elements (such as buttons, panels, DROs, and tabs) can also execute user defined scripts.  These scripts call all be set in the screen editor (see the Mach4 customization manual for more information of customizing the screen).
### Screen Load Script
The screen load script runs when the screen is loaded.  This is a useful tool for loading saved settings or data, setting a start-up state, initializing controls, etc.
Global functions that will be used in other scripts on the screen can also be run in the screen load script. All scripts in the screen (with the exception of panels) will have access to global functions and variables that are defined in the screen load script.  This can reduce the amount of programming for the user.
A word of caution: The screen load script runs while the screen is being loaded.  When trying to set the state of screen elements use care, sometimes the target element has not been loaded when the screen load script runs.  If data it to be set on the screen, it is usually best to do that in the first run of the PLC script.
### Screen Unload Script
The screen unload script runs when the screen is unloaded.  This can be a useful tool for saving settings or data.  Registers are a perfect example as their values are not saved by Mach4 on exit.  The best place to store data with a profile is in the .ini file.  Mach4 provides an easy way to do this from a script with the mc.mcProfileWriteString(inst, section, key, value) command.  With this command it is possible to write any data to the .ini file to be saved and reloaded later.  The register’s section shows specific examples for saving and loading registers from the .ini file.
### PLC Script
The PLC script continuously runs at an interval set in the screen.  By default the PLC scripts run on a 50 millisecond interval.  Although this is a script and not a ladder type program, it does provide a similar functionality to a PLC, hence the name.  This script can monitor the state of signals and inputs and outputs and react very quickly.  A common use for the PLC script is showing errors or faults from external devices such as servo drives and VFDs.
The first run of the PLC script is also the best place to set data on the screen for the first time.  This ensures that the target element on the screen exists before data is being set.  Running a section of the code on the first run is easy to accomplish with a simple counter in the PLC script.
count **=** count **+** 1
With this count variable at the top of the PLC program it will count up by one every time the PLC script runs.  So, on the first run count will equal 1.  So an if statement can run certain code only on the first run.
### Signal Script
The signal script is an all new concept in Mach4.  This script is an event handler that can be used to perform actions in response to state changes of signals in the signal library.  Signals are internal triggers for events in Mach4 and are not to be confused with external inputs and outputs.  Some signals are completely internal and some are used to connect to external inputs and outputs.  The signal script can connect all signals to an action.
How does it work?  A change in state of a signal is considered an event, on every event the signal script runs.  In the signal script two variables are used to determine which signal triggered the event and what its new state is.  The variable “sig” is the internal ID number of the signal, and the variable “state” is the state of the signal after the event.
Now we know which signal triggered the event and what its state is, but we don’t know if it is the signal we want.  To do this we need a way of comparing the ID numbers of the signal we want to perform an action and the signal that triggered the event.  This means knowing the ID number of the signal we want. Mach4 makes this easy on us by providing a complete set of signal definitions.  They are all in the format: mc.OSIG_MACHINE_ENABLED, mc.ISIG_INPUT0, etc.
One application of this is to connect physical buttons on a control panel to actions in Mach4.  Let’s make a simple cycle start button that is setup on input 1.  Since we will be using input 1, the ID number we’ll be looking for is mc.ISIG_INPUT1.  In the signal script we could have this code:
**if** **(**sig **==** mc.ISIG_INPUT1**)** **then **    
**    local** inst **=** mc.mcGetInstance**() **    
mc.mcCntlCycleStart**(**inst**) 
****end**
Now, this would work, however remember that the signal script runs for every event.  The events are when the signal changes state.  So this code would command the cycle start when the button is pressed, and again when it is released.  To avoid this we can look for the state to be what we want as well.  That would lead us to:
**if** **(**sig **==** mc.ISIG_INPUT1**)** **and** **(**state **==** 1**)** **then**
**local** inst **=** mc.mcGetInstance**() **    
mc.mcCntlCycleStart**(**inst**) 
****end**
SignalTable **=** **{**
**[**mc.ISIG_INPUT1**]** **=** **function** **(**on_off**)
**        **if** **(**on_off **==** 1**)** **then
**            mc.mcCntlCycleStart**(**inst**)
**        **end **    
**end
****}**
This code would look for the input 1 signal to change to an active state.  When the signal changes to the off state the cycle start will not run.  This is relatively simple, but if when connecting a lot of signals the script can get very complex, and checking many if statements can bog things down, slowing the reaction to state changes.  To make things run more efficiently we can use a table for all the signals we want to use, and index that table from the signal script.  The best place to create the table is in the screen load script, where it will be loaded when Mach4 is started and can then be accessed by the signal script, or any other script in the screen.  The table in the screen load script could look something like this:
This table contains a function with a name matching the ID number of signal connected to input 1.  That function will command a cycle start when the state of the signal is equal to 1, or the signal is active.  Now that we have a table we need some code to index it in the signal script.
This code, which lives in the signal script, will look into the table, SignalTable, for an entry matching the signal ID number that is stored in the variable sig.  If there is no entry nothing is done.  If there is, then the state is passed into the function and the desired action is performed.
This seems more complex than the if statements at first glance, but it really isn’t.  The only code that will be in the signal script is that shown above.  The signal table will grow as functions are added in, but it is no more difficult or complex than the many if statements that would be required.  And, as said before, the table is much faster to index and thus far more efficient and reactive to events.
**if** **(**SignalTable**[**sig**]** **~=** **nil****)** **then**
SignalTable**[**sig**](**state**)
****end**
## Panels
Although panels are located on the screen, they deserve their own section as they are a separate entity.  Unlike all the other screen elements they do not share the same global space, and thus cannot access functions or variables in the screen load script like buttons and other controls can.  However, they can load and utilize modules just as any other script in Mach4 can.
Panels are simply and environment to run a self-contained Lua program.  Elements of a panel are not defined in the screen designer, they are defined in the code contained in the panel.  The easiest way to create an interface in a panel is to use a form designer capable of outputting Lua code, wxFormBuilder for example.
The mouse wheel as MPG code is a great example of how panels can be used.  A video tutorial about this code can be found here: [https://www.youtube.com/watch?v=MRyaRQwhYWk](https://www.youtube.com/watch?v=MRyaRQwhYWk).  A link to the code is in the description.
Wizards are another example of what can be shown in a panel.  Mach4 comes with an example bolt hole circle wizard that can be displayed in its own dedicated frame or in a panel on the Mach4 screen.  The code for this wizard can be found in the “Wizards” folder in the Mach4 directory on your computer, the file name is “BoltHoleCircle.mcs”.
If you try to display and scale an image in a panel on the screen you may find that the images only scales to the correct size after resizing the screen. If you run into this issue the way to fix it is the get the parent of the panel, and catch the OnIdle event from it. In the event, resize the images and then use a flag to only run your code in the OnIdle event once. This will prevent you’re code from creating an unneeded update loop of resizing the images inside the Idle event.
mcParent = mcLuaPanelParent:GetParent()
FirstTime = true
mcParent:Connect( wx.wxEVT_IDLE, function(event)     if FirstTime == true then
FirstTime = false
--Run Resizing code
end     event:Skip()
end)

---
**Navigation:** ← [Previous: 2 Script Editor](script_editor.md) | [Next: 4 Registers](registers.md) → | [📋 Table of Contents](table_of_contents.md)
---