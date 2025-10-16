# 4 Registers

---
**Navigation:** ← [Previous: 3 Types of Scripts](types_of_scripts.md) | [Next: 5 Examples](examples.md) → | [📋 Table of Contents](table_of_contents.md)
---

# Registers
Registers are a very powerful tool in Mach4.  They are completely user definable and can be accessed from anywhere in Mach4.  Scripts can use them to record and save data or to transfer data to another script or communicate with a plugin.  Registers can contain numbers or strings.
## Creating Registers
Registers are created in the Regfile plugin.  Select “Plugins…” from the “Configure” menu to display the plugin configuration window, figure 4-1.
![Image 7263](images/image_7263.png)
*Figure 49: Configure plugins window.*
In the configure plugins window find the Regfile plugin, row 6 in this case, and click on the “Configure…” button.  This will open the register configuration window, figure 4-2.
![Image 7264](images/image_7264.png)
*Figure 410: Register file configuration window.*
In this window new registers can be created as well as assigned initial, or default, values.  To add a register click on the icon with the green plus sign (top left corner of the tab).  A new row will be added, simply give it a name, an initial value, and a description.  The name will be used to look up the register, so use something simple.  The description is optional but accurate descriptions are certainly beneficial in the long run.
The initial value is the value that will be assigned to the register when Mach4 loads.  The registers are not saved by default when Mach4 is closed.  If a register, or many, needs to be saved on exit the Screen Unload script is a great place to do this.  Also, to load the saved value use the Screen Load script.  Saving registers to and loading them from the Machine.ini file will be covered in the next sections.
## Viewing Registers
The Regfile configuration window shows the registers and their default values.  A diagnostics window is provided to show the registers and their values in real time.  The diagnostics window can be found by selecting “Regfile” from the “Diagnostic” menu in Mach4.
![Image 7265](images/image_7265.png)
*Figure 411: Register diagnostics window.*
The diagnostics window displays all the registers in Mach4 and also provides a display for the pound variables.  If the “iRegs0” category is expanded we will see the registers and associated values from the previous section.
The register diagnostics window is not limited to only viewing register values, they can be changed as well.  Double click on any value and an input window will pop up to allow the user to change the value.
## Using Registers in Scripts
There are several commands available for working with registers, for clarity and simplicity we will be using only the necessary few here:
•       hreg = mc.mcRegGetHandle(inst, path)
•       val = mc.mcRegGetValue(hreg)
•       string = mc.mcRegGetValueString(hreg)
•       mc.mcRegSetValue(hreg)
•       mc.mcRegSetValueString(hreg)
The first step in using registers in scripts is to get the handle.  The handle is basically an ID number assigned to the register internally in Mach.  There is now what to know this except to ask Mach for it.  The mcRegGetHandle function returns the ID or handle.  There are two arguments required for this function, the current instance number of Mach we are working in and the path of the register.  The instance can be found using the mc.GetInstance function in the format:
inst **=** mc.mcGetInstance**()**
The path is the register type followed by the register name.  For example, the path for the first register in figure 4-2 is “iRegs0/Test1.”  So to get the handle of the Test1 register the code would look like:
inst **=** mc.mcGetInstance**()
**hreg **=** mc.mcRegGetHandle**(**inst**,** "iRegs0/Test1"**)**
Now to get the value.  Here we are discussing two ways to retrieve the value, as a number or as a string.  If the register’s value is an unknown type then use mcRegGetValueString.  Using mcRegGetValue will result in an error if the register contains a string, but mcRegGetValueString can read a number or a string as a string.  The only catch there is that math cannot be performed on a string, even if it is a sting of only numbers.  Strings containing only numbers can be converted to a number format by using the tonumber(“string”) command.  Let’s use mcRegGetValueString to retrieve the value of Test1 and then convert it to a number for computation later.  Ofcourse this only works for values that are numbers, the tonumber(“string”) function will create an error if the string contains more than just numbers.
inst **=** mc.mcGetInstance**()
**hreg **=** mc.mcRegGetHandle**(**inst**,** "iRegs0/Test1"**)
**val **=** mc.mcRegGetValueString**(**hreg**) **val **=** **tonumber****(**val**)**
It would save a line of code to use the mcRegGetValue(hreg) function, but there is a reason for using the string method shown above.  Every time a register is called it requires two lines of code, as well as the current instance.  There is an easier way, create our own function.  Remember that all the contents of the macros folder are rolled into one large file, and the screen has access to all the elements of the screen, and the modules can be loaded and used everywhere.  With the standard method shown above this code would have to be used every time register information was needed, in every M code, every button, every script in Mach4.  Making a function to call the register is much easier and can make the code a lot cleaner.  Let’s use a button on the screen as an example.  We would like a button to get the value of a register and display it in a message box to the user.  Or first step will to be to create a function in the screen load script to get and return the value of the register.  This function can be used by our new button and any other button we decide to add to the screen.  In the screen load script we will make a function as shown below.
**function** GetRegister**(**regname**)
**    **local** inst **= **mc.mcGetInstance**()**
**    local** hreg **=** mc.mcRegGetHandle**(**inst**,** **string.format****(**"iRegs0/%s"**,** regname**))
**    **return** mc.mcRegGetValueString**(**hreg**)**
**end**
With this function in the screen load script, our button can call it.  To get the value of the “Test1” register and display it in a message box the button script will be:
regval **=** GetRegister**(**"Test1"**)
**wx.wxMessageBox**(**regval**)**
Now with that function created, any time we want to retrieve the value of a register we simple call the GetRegister(regname) function with the name of the register to get.  In the screen of course.  Try adding this function to the screen load script then create a button on the screen to use the GetRegister function.
A similar process can be used in the macros.  For example a file can be created named “macrofunctions” that contains the GetRegister function and any others that will be frequently used.  The functions in this file can be accessed by any of the other macros.
Another approach is to use a module.  The module can contain these functions then be loaded by the screen load script or in a macro.  The functions contained in the module can be used anywhere it is loaded.
A function for writing to registers is also useful, and if very similar to the GetRegister function above.
**function** WriteRegister**(**regname**,** regvalue**) **    **local** inst **=** mc.mcGetInstance**()**
**local** hreg **=** mc.mcRegGetHandle**(**inst**,** **string.format****(**"iRegs0/%s"**,** regname**))**
mc.mcRegSetValueString**(**hreg**,** **tostring****(**regvalue**))**
**end**
Using WriteRegister is also very simple.
WriteRegister**(**"Test1"**,** 12**)**
The example will write a value of 12 to the instance register “Test1”.  Again, this function does everything as a string, this way strings or numbers can be sent and set to the registers.  If a number is passed into the function it will be converted to a string with the tostring function.
## Saving Registers to Machine.ini
Since register values are not saved when Mach is closed it is necessary to create code to save any desired registers.  The easiest and most convenient place is in the Machine.ini file.  One place for a register save script is in the screen unload script.  This script runs when the screen is unloaded/Mach4 is closed.  
Another place to save registers is in the code immediately following when they are set.  The best time and place to save registers to the .ini file will vary depending on the application.
To save a register to the .ini file use mc.mcProfileWriteString().  To use this we need to define a section in the .ini file to place the data, specify a name for the data and then the value.  For this example let’s assume the register ‘Test1’ equals 6.
**local** inst **=** mc.mcGetInstance**()
****local** hreg **=** mc.mcRegGetHandle**(**inst**,** "iRegs0/Test1"**)
****local** val **=** mc.mcRegGetValue**(**hreg**)
**val **=** **tostring****(**val**) **mc.mcProfileWriteString**(**inst**,** "Registers"**,** "Test1"**,** val**)**
This little bit of code gets the value of register ‘Test1’ and then writes it to the Machine.ini file in a section labeled as “Registers” with a name “Test1”.  The Machine.ini file will contain a section like this:
**[Registers] Test1 = 6**
If the section “Registers” does not exist it will be created, if it does the key “Test1” will be added to it.  Writing data to the Machine.ini file is very useful for saving registers, but that is not the only application for it.  Any data can be saved for use later, custom screens may have configuration data that needs to be stored, wizards may have information to store for next time, etc.
## Loading Registers From Machine.ini
After data is saved to the Machine.ini file it is very useful to retrieve it.  For registers, this means that they can be initialized with saved values when Mach4 starts.
Like with saving to the Machine.ini file there is a function for loading from it, mc.mcProfileGetString().  For example, to get the previously saved value for “Test1” and set it to the register of the same name the code could be:
**local** inst **=** mc.mcGetInstance**()
****local** val **=** mc.mcProfileGetString**(**inst**,** "Registers"**,** "Test1"**,** "nf"**)**
**local** hreg **=** mc.mcRegGetHandle**(**inst**,** "iRegs0/Test1"**)
**mc.mcRegSetValueString**(**hreg**,** val**)**
In this code the variable ‘val’ is set to the value found in the Machine.ini file under the section “Registers” and key “Test1”.  If there is no value found, ‘val’ will be set to “nf”, the default value we defined in the mc.mcProfileGetString() function.  This default value can be defined as anything, it will only be used if there is no value found in the Machine.ini file.  A unique value here can be useful to perform a specific action if the key does not exist in the .ini file or if a simple default value is desired.

---
**Navigation:** ← [Previous: 3 Types of Scripts](types_of_scripts.md) | [Next: 5 Examples](examples.md) → | [📋 Table of Contents](table_of_contents.md)
---