# Plasma_Configuration

*Converted from PDF: Plasma_Configuration.pdf*
*Conversion date: /Users/chondl/learn/mach4/scripts*

---

<!-- Page 1 -->

Mach 4 Plasma Configuration
This document covers basic configuration of Mach 4 Plasma.
A clear and full understanding of the plasma unit CNC pin out will be required. The plasma unit used
in this example will accept (Raw) and (Divided) voltages and will need to be wired to the correct
terminals.
Basic common signals will be required to be wired and mapped. These are usually included with a
supplied CNC interface cable for the plasma unit.
-Torch on (+) (-)
-Divided, or Raw voltage (+) (-)
-Arc OK (+) (-)
Once plasma signals are integrated to the your motion controller/breakout board, plasma configuration
will continue in Mach 4.


<!-- Page 2 -->

Plasma machine configuration is similar to that of a mill or a router. THC, however, is handled with an
out-of -band motor. For example, if Motor 2 in the profile is mapped to the Z axis, an out-of-band
motor must be enabled and its motor tuning settings must match those of Motor 2. If Motor 5 is used
as the OB motor and axis, it must be assigned as OB 1(6)
After the OB axis is set up, it needs to be assigned so it can be accessed by the THC Module.


<!-- Page 3 -->

In the Configure drop-down menu, open the Plasma Screen Configuration panel.
Default THC mode, THC Axis, and the Analog Register will be set here.
In our example, the motion controller outputs an analog signal. Analog should be selected as default.
Manual mode will still be available. The analog voltage is a register that can be found by going to
Diagnostics>Regfile and selecting your motion controller, then its plasma unit. If the Register is
clicked on with the diagnostics open, Mach 4 will display the full path name. When Mach 4 is restarted
and the THC tab is opened, THC Mode will be set to Analog.


<!-- Page 4 -->

If “Use Analog V oltage for Arc OK” is checked, Mach 4 will then monitor the values set for minimum
and maximum voltage entered.
The minimum voltage will be set to a reasonable value based on the cutting parameters. Once the
minimum voltage has been met or exceeded, Mach 4 will enable the Arc OK Signal, enabling THC.
The maximum voltage will be set to a reasonable value based on the cutting parameters. Once the
maximum voltage has been met or exceeded, Mach 4 will disable the Arc OK Signal, disabling THC.
The min and max values should be a tolerance range that will encapsulate the target voltage but allow it
to change while Mach 4 executes THC moves to obtain selected cut height.
## THC TAB
This tab contains run time info as well as DROs that will be used to set optimal cutting conditions.
THC Mode: a toggle button that will select either manual, digital, or analog mode for THC.
THC Enable: a toggle button that forces THC on. It should only be used in this way when turning the
torch on manually and cutting manually. Under normal conditions, THC is enabled when the torch is
on and it is turned off when the torch is off.
THC On: Arc OK and is associated with an LED.
Up/Down: buttons that control THC when in manual mode.
Target Voltage: the voltage Mach 4 will maintain during digital or analog plasma operation.
*This will depend on the plasma unit. Refer to the plasma user manual pertaining to material type
and thickness.*
Adjust Rate: the speed at which THC will move to achieve Target V oltage.
XY Blend Velocity: e quals the current blended velocity of X and Y; used for Anti Dive.


<!-- Page 5 -->

Anti Dive Rate: the rate at which XYBlended Vel will disable Anti Dive.
Anti Dive State: 1 is on, and 0 is off.
All of these values will be registers in Mach 4. To see these registers, go to
Diagnostics>i Regs 0>nf>thc. This is the location the THC module will access these values during
operation.
## THC CUT START SETTINGS
THC Cut Start Settings are settings for optimal torch firing sequence through final cut height where
THC will enable and maintain target voltage.
Omit Touch Off: For machines that do not have a probe input, there is a button on the THC Cut Start
to omit the material touch off as part of the M 3 sequence. Special attention must be taken when the
touch off has been omitted. The top of the material (“Z”) must be set manually in the current work
coordinate system prior to cutting.
Max Find Distance: distance the torch will travel to find the material top while looking for a probe
strike.
Touch Speed: units per minute Z axis will travel during the Max Find Move.
Probe Offset Z: A DRO that can be used to enter a compensating value for a plunger style probe. If
the probe is a solid strike style, 0 can be entered. If the torch tip hits the material top but continues to
travel -.0 4 to complete the probe strike, -.0 4 will be entered.


<!-- Page 6 -->

Torch On Height: Position the Z axis will be at when the plasma is told to fire (turn on); used in M 3.
Pierce Height: Position the Z axis will be at when a pierce begins; used in M 3.
THC On Delay(ms): Time in milliseconds the THC waits to start controlling height; used in M 3.
*2 0 0 0 = 2 Seconds
Pierce Delay: Time in milliseconds allowed to complete piercing material; used in M 3.
*This value can be found in user manuals for Plasma units.
Max: Maximum height THC will move the torch up to while trying to get to the target voltage.
Cut Height: Optimal position to run THC at; used in M 3.
*This value can be found in user manuals for plasma units
Min: Minimum height THC will move the torch down to while trying to get to the target voltage.
There are many variables involved in plasma Configuration, most of which have been create directly in
the screen for immediate use.
However, these are still approximations. It is strongly recommended to test cut when cutting new
material types, or thicknesses.

