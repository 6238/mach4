# Mach4 Lua for Dummies 6_22_2020

*Converted from PDF: Mach4 Lua for Dummies 6_22_2020.pdf*
*Conversion date: /Users/chondl/learn/mach4/scripts*

---

<!-- Page 1 -->

Mach 4 Lua Programming for Dummies June 1 7, 2 0 2 0
• First a little background on some things that I had a hard time with at the start.
• My wording of these may not be correct but I hope it at least gives the correct
information in a way that people like me can understand.

• Mach 4 is not exactly one big program. It is made of several smaller programs
that work together. I have heard them referred to as “chunks” I believe.
Sometimes things done in one part are not immediately seen in another part.
Example: If running a macro the GUI LED’s and DRO’s are not updated until the
macro finishes running.
• Something that works in a button may not work in a macro.
Example: mc Axis Home works in a button but not in a macro.
I have been told both it will and it won’t but I could not get it
to work in a macro.
Also, readi ng and writing to a DRO will work realtime in a
button but not a macro.

• The mc calls can be found at C: \Mach 4 Hobby \Docs \Mach 4 Core APE.chm
• The scr calls can be found online at (thanks to Brett and Craig);
https://www.machsupport.com/forum/index.php?topic=3 9 7 6 2.0
• Whenever possible use the mc calls and codes to get and set variables \
information not the scr calls.

• Registers are a great way to get information from one part of Mach 4 to another.
They are updated immediately across all parts of Mach 4.
• The main part of Mach 4 has a PLC built in. The PLC runs constantly in the
background and can be used to do things depending on a register setting or a
physical button push on the machine. Example: I have a physical button on one
of my machines that is used as a pause button. I have also used it to look at a
register and when the register changed to 1 it did an action.
• In the following sections I will explain how to get to the PLC and how to ma ke
new registers as well as use the registers.
• I am going to try starting with the simplest and working my way up.

• Macros go in the macros folder of whatever profile you are using.
• Use macro numbers of 1 0 0 and up other than m 1 6 2 & m 1 6 3 (laser).


<!-- Page 2 -->

Mach 4 Lua Programming for Dummies June 1 7, 2 0 2 0
• Macros can use a name instead of a number.
```
Name()
Example:
```
toolheightset()
• Here is the format of a macro.
```
function m#()
your code
end
```
if (mc.mc In Editor() ==1) then
```
m#()
end
```
The last 3 lines let you run or step through the macro while in the editor.

Example: (for this example the Get Instance is not needed but….)
```
Function m 1 1 1()
```
local inst = mc.mc Get Instance()
mc.mc Cntl Gcode Execute (“G 0 X 1 0.0 5 0”)
end
```
if (mc.mc In Editor() ==1) then
```
m 1 1 1()
end

• Comments are very helpful in your code.
Put - - in front of anything you want to comment out.
Example:
-- this is a comment

• Some things need numbers (math calculations) and others need a string (registers) .
To change to a number.
local variable = tonumber(value)
Example:
local Number = tonumber(3.0)
or
local Num = 3.0
local Number = tonumber(Num)


<!-- Page 3 -->

Mach 4 Lua Programming for Dummies June 1 7, 2 0 2 0

To change to a string.
local variable = tostring(value)
Example:
local String = tostring(3.0)
or
local Str = 3.0
local String = tostring(Str)

• One thing that is needed at the start of any code is the following.
```
Local inst = mc.mc Get Instance()

• How to make the program pause for a set amount of time in a button, macro or
in the PLC.
I use this to allow air cylinders to complete their stroke.
wx.wx Sleep (seconds)
wx.wx Milli Sleep(milliseconds)
Example:
wx.wx Sleep(1)
wx.wx Milli Sleep(1 0 0 0)

• How to read a DRO’s value.
local variable = scr.Get Property(‘DRO Name’, ‘Value’)
Example:
local Start Pos = scr.Get Property (‘dro Current Pos Y’, ‘Value’)

• How to write to a DRO.
scr.Set Property(‘DRO Name’, ‘Value’, tostring(variable))
Example:
local Temp = 3.0 0
scr.Set Property (‘dro Temp Pos’, ‘Value’, tostring(Temp))
**If the DRO has a n mc call use that instead**

• How to get a LED’s state.
local variable = scr.Get Property(‘LED Name’, ‘Value’)
Example:
local Start Set = scr.Get Property (‘ LEDStart Complete’, ‘Value’)


<!-- Page 4 -->

Mach 4 Lua Programming for Dummies June 1 7, 2 0 2 0

• How to set a LED’s state.
scr.Set Property(‘LED Name’, ‘Value’, ‘State’)
Examples:
scr.Set Property (‘ LEDStart Complete’, ‘Value’, ‘1’)
LED set to on.
scr.Set Property (‘LEDStart Complete’, ‘Value’, ‘0’)
LED set to off.

• How to set a buttons state .
scr.Set Property(‘ Button Name’, ‘ Button State ’, ‘State’)
Examples:
scr.Set Property (‘ Tang Knife Up Dn ’, ‘Button State ’, ‘1’)
Button set to on.
scr.Set Property (‘ Tang Knife Up Dn ’, ‘Button State ’, ‘0’)
Button set to off.

• How to get an input or output state.
variable = mc.mc Signal Get Handle(inst, signal name)
variable 2 = mc.mc Signal Get St ate(variable)
Examples:
hsig = mc.mc Signal Get Handle(inst, mc.ISIG_MOTOR 0 _HOME)
Mat Home = mc.mc Signal Get State(hsig)
Returns a 1 or 0 depending on if motor 0 has been homed.
hsig 2 = mc.mc Signal Get Handle(inst, mc.OSIG_OUTPUT 8)
Arm Down = mc.mc Signal Get State(hsig 2)
Returns a 1 or 0 depending on if output 8 is activated or not.

• How to set an output state.
variable = mc.mc Signal Get Handle(inst, signal name)
mc.mc Signal Set State(variable, state)
Examples:
notch = mc.mc Signal Get Handle(inst , mc.OSIG_OUTPUT 8)
mc.mc Signal Set State(notch, 1)
Turns output 8 active or on.
mc.mc Signal Set State(notch, 0)
Turns output 8 inactive or off.
• How to run G Code in a button , macro or screen script .


<!-- Page 5 -->

Mach 4 Lua Programming for Dummies June 1 7, 2 0 2 0
This can be done directly using G Code or using variables .
mc.mc Cntl Gcode Execute(inst, “g code”)
mc.mc Cntl Gcode Execute Wait (inst, “g code”)
**only use the “Wait” version in a macro**
Example:
mc.mc Cntl Gcode Execute(inst, “G 1 X 2 2.3 7 5 F 2 0 0.0”)
or
local variable = “g code to run”
mc.mc Cntl Gcode Execute Wait (inst, variable)
Example:
local Clear Position = “G 1 X 2 2.3 7 5 F 2 0 0.0”
mc.mc Cntl Gcode Execute Wait (inst, Clear Position)
or
local variable = value
local variable 2 = stringformat(“G 0” .. variable .. “X” .. variable)
mc.mc Cntl Gcode Execute( inst, variable 2)
Example:
local zero = 0
local Go To Zero = stringformat(“G 0 X” .. zero .. “Y” .. zero)
mc.mc Cntl Gcode Execute(inst, Go To Zero)

```
• To run a function from a button.
```
function name()
Example:
```
function toolcal()

```
• To call an m code or function from an m code or function .
**This will not work while in editor**
```
**all functions & m code macros are compiled into a single file called mc Lua.mcc**
```
**so a function or m code can call another function or m code **
**Do not use Gcode Execute com mand**
```
m#()
or
```
name()
Example:
```
m 1 0 1()
or
```
settool()


<!-- Page 6 -->

Mach 4 Lua Programming for Dummies June 1 7, 2 0 2 0

• Message box
```
This can be used to let you know an action has been completed or anything else
you need to know is done or needs doing such as a note to change the tool.
wx.wx Message Box (‘message’)
Example:
```
local inst = mc.mc Get Instance()
wx.wx Message Box(‘ Hello, now click the button’ )

• How to turn on Registers.
Go to Configure, Control, Plugins tab then place a green check next to Regfile.

• How to make a new Register.
Go to Configure, Plugins then Regfile.
Click on the green plus sign.
Give the register a name. (no spaces)
Give the register a starting value.
Put in a longer description.
Persistant
A green check will keep value on exit from Mach 4.
A red x will start every new start of Mach 4 with the starting value.

• How to read a Register.
local variable = mc.mc Reg Get Handle(inst, ‘path’)
local variable 2 = mc.mc Reg Get Value(variable)
Examples:
local hreg = mc.mc Reg Get Handle(inst, ‘Encoder_ 0’)
local Enc Raw Val = mc.mc Reg Get Value(hreg)
or
local hreg = mc.mc Reg Get Handle(inst, ‘ ESS/Enc Raw’ )
local Enc Raw Val = mc.mc Reg Get Value(hreg)
or
local hreg = mc.mc Reg Get Handle(inst, ‘i Regs 0/Notch Time ’)
local Enc Raw Val = mc.mc Reg Get Value(hreg)


<!-- Page 7 -->

Mach 4 Lua Programming for Dummies June 1 7, 2 0 2 0
• How to write to a Register. (this might be wrong)
local variable = mc.mc Reg Get Handle(inst, ‘path’)
local mc.mc Reg Set Value(variable, value)
or
local variable = mc.mc Reg Get Handle(inst, ‘path’)
local mc.mc Reg Set Value(variable, tostring(value))
Example:
local hreg = mc.mc Reg Get Handle(i nst, ‘ESS/Enc Raw’)
local mc.mc Reg Set Value(hreg, 2 3.3 5)
or
local Num = 2 3.3 5
local hreg = mc.mc Reg Get Handle(inst, ‘ESS/Enc Raw’)
local mc.mc Reg Set Value(hreg, tostring(Num ))

