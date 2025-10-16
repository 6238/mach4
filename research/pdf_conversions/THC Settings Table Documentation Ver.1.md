# THC Settings Table Documentation Ver.1

*Converted from PDF: THC Settings Table Documentation Ver.1.pdf*
*Conversion date: /Users/chondl/learn/mach4/scripts*

---

<!-- Page 1 -->

THC Settings Table
Documentation V.1

Introduction
The purpose of this documentation is to explain the basics of the new Torch Height Control Settings in
Mach 4. Each row in the table can be clicked on, Mach 4 will then register the settings aut omatically in the
THC Settings . The raw .CSV file can be edited to add custom materials/values so they can be used in
Mach 4.
Definitions:
Amperage ---The maximum amount of power a plasma unit is capable of. This value can be found in the
manual for the individual plasma unit.
Kerf Width ---In user-defined units (in/mm) , the width of material that is removed by the cut the plasma
unit makes.
Torch -On Height ---In user-defined units (in/mm) , the position (in the Z axis) at which the plasma unit is
instructed to turn on.
Pierce Height ---In user-defined units (in/mm) , the position (in the Z axis) at which the initial pierce
begins.


<!-- Page 2 -->

Cut Height ---In user-defined units (in/mm) , the height at which the THC is turned on. The value is
determined by physically measuring if you do not have the manual for the individual plasma unit.
Pierce Delay --- In milliseconds, Pierce Delay is the amount of time allotted for the THC to pierce
through the material. Example: 0.5 = ½ second should be 5 0 0 = 1/2 second. This value is determined in
the user manuals for individual plasma units.
Anti -Dive Rate ---Percentage of programmed (feed rate * (FRO / 1 0 0)) at which Anti Dive will be
disabled.
Target Voltage ---In volts, optimal voltage to cut at. Auto THC Adjust the torch up and down to try to get
to this point.

Please note that all of the values in the existing table are all default values based on standard plasma units.
To automatically configure the THC Settings using the Tables wizard, simply click on the row you want
and it will highlight in green, and you will see the values in the THC Settings.

Values for individual plasma units is not reflected in the default table, but can be added through editing
the table itself. You will find this table in the new C:\Mach 4 Hobby \Tables \ folder , as depicted i n Fig-1.0:


<!-- Page 3 -->

Fig-1.0
To edit this table so it reflects in Mach 4 for use for your individual plasma unit, double click the
Default Table.csv file to open it. This file requires spreadsheet software such as Microsoft Excel or
Open Office Calc to be able to edit. Once opened, the table will look like what is depicted in Fig-1.1:

Fig-1.1
Also shown in Fig -1.1, you will see spaces to add custo m materials/values for your plasma unit. Refer to
your indi vidual plasma unit ’s manual for these values. Be aware that while you can delete the provided
default values, it is not recommended. If you choose to do so for clarity in the wizard, make s ure you
copy these values in another spreadsheet or document so you will always have them.
From left to right, you would enter these values:
-Process (name of the material and thickness)
-Amperage (determined by your individual plasma unit ’s max output of power)
-Feed Rate (user defined)
-Kerf W idth (determined by the amount of material removed from the cut)
-Torch -On Height (determined by your individual plasma unit ’s product manual )
-Pierce Height (determined by your individual plasma unit ’s product manual )
-Cut Height (determined by your individual plasma unit ’s product manual )
-Pierce Delay (determined by your individual plasma unit ’s product manual )
-Anti-Dive Rate (norm ally 3 0 is the standard value)
-Adjust Rate (normally 1 0 0 is the s tandard value)
-Target Voltage (determined by your individual plasma unit ’s product manual )


<!-- Page 4 -->

When you are finished editing your custom values, click ‘File’, then ‘Save ’ or click the Floppy Disk icon
at the top right -hand corner of the window . 

Important to Note: Please do not change or modify the first three rows as shown in Fig-1.2. Also do not
add or delete any columns from the spreadsheet as any change like that will “break ” the Tables Wizard.

Fig-1.2

