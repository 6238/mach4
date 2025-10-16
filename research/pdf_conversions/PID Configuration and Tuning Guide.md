# PID Configuration and Tuning Guide

*Converted from PDF: PID Configuration and Tuning Guide.pdf*
*Conversion date: /Users/chondl/learn/mach4/scripts*

---

<!-- Page 1 -->

PID Configuration and
Tuning Guide – Ver-1.0

Introduction:
The purpose of this guide is to explain the process and where to find the appropriate registers to adjust the
PID settings. Please remember that you will always want to create good initial voltages (cut height, pierce
height, probe offset -Z). Once feedback is present, the scale factor must be derived to scale the actual
voltage to where it should be. This should be done in Manual THC Mode using multimeters or a scope.
The
Register Definition s:
PIDdval: Derivitave Value – Result of time and distance – returns readable data
PIDimax: Integral Max – Maximum “wind -up” of the integral gain.
PIDival: Integral Value – Result of time and distance – returns readable data
PIDkd: Derivative Value
PIDki : Integral Value
PIDkp: Proportional Value
THCActual Scaled: Voltage – After it has been scaled, multiplies volts coming in
THCActual Scaled Factor: Used to get voltage in range that falls in line with the plasma unit

You can locate these values within Mach 4 by clicking on ‘ Diagnostic ’ > ‘Regfile – Newfangled
Solutions ’, then click on the plus sign beside ‘ i Regs 0 ’ then ‘ nf’ and finally, ‘ thc’ (as depicted in Fig-1.0).


<!-- Page 2 -->

Fig-1.0

Tuning the PID configuration:
Tuning the PID is defined as adjusting the gain term in each of the three branches of the controller;
Proportional, integral, and derivative (PID). The gain (proportional) is essentially how fast your tool
moves to your desired (or target) location and is defined as a multiplier in which how to calculate the
speed.
Each branch of the controller has its own purpose. The proportional branch calculates present error in
order to reach its target value, the integral branch keeps a record of these calculations, and the derivative
```
branch predicts future errors that occur... so that the proportional gain may function accordingly without
overshooting or undershooting its target (desired) value.


<!-- Page 3 -->

An error can be interpreted as the present position of your tool in re lation to the desired position. So if
your tool is at X 0 1 and your desired value is X 5 0, your error is 4 9 (or 5 0 minus 1). You will want the
error to decrease over time to get to where you want and eventually reach an error of 0. Your gain is how
fast your tool reaches 0.
An important term to remember, Deadband, is a tolerance factor for Target voltage. If the Actual voltage
does not rise above or drop below the dead band tolerance + Target Voltage, there will not be any THC
move ment. Example: if the dead band is set to 5 v, the tolerance is + - 5 actual volts above or below the
target. You can se e the Dead Band Width in Fig -1.0.
Words of Wisdom:
You start with a default set of values in Mach 4 ( Fig-1.0), and you can tune them by replacing the values
with your own. Please remember that when tuning your PID configurations, that you are entering the
values for your specific machine for optimal operation and output. Every machine is different and this
needs to be considered before operating in a live environment. Testing, fine -tuning, and experimentation
with your machine’s unique measurem ents and specifications is imperative.

