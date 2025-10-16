# Mach4CoreAPI

*Converted from PDF: Mach4CoreAPI.pdf*
*Conversion date: /Users/chondl/learn/mach4*

---

<!-- Page 2 -->

Mach 4 Core API
Build 3 7 9 7
Authors: Brian Barker , Steve Murphree
©Copyright: Newfangled Solutions™ 2 0 1 3-2 0 1 8
Rev:2.0 1
2 0 1 8-0 5-1 4


<!-- Page 3 -->

Contents
Getting Started
API Error Return Codes
API Reference by Category
Alphabetical API Refernce
Plugin Development


<!-- Page 4 -->

Getting Started
Supported Platforms
Compiling
Linking


<!-- Page 5 -->

Supported Platforms
At this time the only supported platforms are W indows, Linux, Mac. The
only plugins that will be suported for both W indows, Linux and Mac will
need to be programmed in C++ or C.

Windows:
Plugins can be writen in any language that supports interfacing to a flat C
API interface. T ests have been done with C++, C# and VB. Other languges
such as Action Script, Delphi, Python and etc could be supported but are
not tested due to the limited use in the windows world.

Linux:
GUIs need to be written in C or C++ with wx W idgets if they are to have a
toolpath display . No testing has been conducted to see if other languages
(wy Python, wx Perl...) with wx W igets will work. Any language with wx
should work but it is out of the scope of this help manual to assist with that
process.

Mac:
More work needs to be done on this platform :)


<!-- Page 6 -->

Compiling
Include the Mach API.h file in your source files.

For the W indows Operationg System:
The dynamic C runtime should be used. /MD and /MDd for V isual Studio.
There are a few environment variables that can be used:
MACHSDK should point to the Mach SDK folder . This environment
variable can then be used in your projects to point to the inlude and lib
directories in your project. e.g $(MACHSDK)\include and
$(MACHSDK)\lib.
M 4 HOBBY or should point to the Mach installation directory . Plugin
projects can then use this environment variable to copy the resulting
plugin the Plugins folder . e.g. In the post build event, add copy
"$(Target Path)" "$(M 4 HOBBY)Plugins"
Several compile time definitions are required or can be useful:
Define MACH_ST ATIC in your project or define MACH_ST ATIC
in your code before the Mach API.h file is included. This is r equir ed!
_ATL_XP_T ARGETING : If you are using VS 2 0 1 3, it will not
compile an executable that runs on windows XP by default. Defining
_ATL_XP_T ARGETING will correct this in conjuction with setting
the linker minimum version to 5.0 1.
FAST_DEBUG : A link library (Mach APIfd.lib) that uses the non
debug version of the CR T (/MD) is provided for speed. Your code
should then also be compiled with /MD and define F AST_DEBUG but
you should turn on symbol information and link with debugging info.
This keeps the debug CR T heap walking/memory checking routines
from slowing things down in the debugger . Of course, it is a good idea


<!-- Page 7 -->

to check you project with full debug settings periodically to check for
memory leaks and such.
_CR T_SECURE_NO_W ARNINGS :, if you use a lot of the old C
```
style functions that are considered as insecure, this will reduce your
warning messages.


<!-- Page 8 -->

Linking
For the W indows Operationg System:
For a Relase tar get, add Mach API.lib to your library list.
For a Fast Debug tar get, add Mach APIfd.lib to your library list.
For a Debug tar get, add Mach APId.lib to your library list.


<!-- Page 9 -->

API Err or Return Codes
Return Codes by Number
Return Codes by Definition


<!-- Page 10 -->

Return Codes by Number
Error
Number Error Definition Error Description
0 MERROR_NOERROR No Error .
-1 MERROR_INV ALID_INST ANCEAn invalid instance numer
or handle was specified.
-2 MERROR_INV ALID_ARGAn invalid ar gument was
specified.
-3 MERROR_INV ALID_DIRAn invalide directory was
specified.
-4 MERROR_INV ALID_PROFILEAn invlaid profile was
specified.
-5 MERROR_FILE_EXCEPTIONAn exception was
encountered when
processing the file.
-6 MERROR_FILE_EMPTYAn empty file was
specified.
-7 MERROR_FILE_SHARINGA file sharing violation
occurred.
-8 MERROR_FILE_INV ALIDAn invalid file was
specified.
-9 MERROR_FILE_BADSIZEThe file specified it too
large.
-1 0 MERROR_REGEN_DONEThe tool path regeneration
is complete.
```
-1 1 MERROR_NODA TAThe API function returned
no data.
-1 2 MERROR_GRID_ACTIVEThe grid is active. (not
used)
```
-1 3 MERROR_NOT_IMPLEMENTEDThe function is not
implemented in this version
of the API.
-1 4 MERROR_MOT OR_NOT_FOUNDThe specified motor was not
found.
-2 MERROR_INV ALID_P ARAMSame as
## MERROR_INV ALID_ARG


<!-- Page 11 -->

-1 6 MERROR_AXIS_NOT_FOUND The specified axis was not
found.
-1 7 MERROR_API_INITThe API failed to initialize
properly .
```
-1 8 MERROR_NOT_NOWThe API function cannot be
called at this time.
-1 9 MERROR_NOT_CREA TED The object was not created.
-2 0 MERROR_SIGNAL_NOT_FOUNDThe specified signal was not
found.
-2 1 MERROR_IO_NOT_FOUNDThe specified input or
output was not found.
-2 2 MERROR_SPIN_RANGE_NOT_FOUNDThe specified spindle range
was not found.
-2 3 MERROR_PLUGIN_NOT_FOUNDThe specified plugin was
not found.
-2 4 MERROR_DEVICE_NOT_FOUNDThe specified device was
not found.
-2 5 MERROR_INV ALID_ST ATEThe state of the control is
```
invalid for the API function.
-2 6 MERROR_AXIS_NOT_ENABLEDThe specified axis is not
enabled.
-2 7 MERROR_REG_NOT_FOUNDThe specified register was
not found.
-2 8 MERROR_IPC_NOT_READYThe Interprocess
Communication subsystem
is not ready .
-2 9 MERROR_NO_ROOM_A VALABLEThere are no more slots
available for another
override axis.
-3 0 MERROR_NOT_COMPILEDThe macros did not compile
correctly .
-3 1 MERROR_NOT_ENABLED The control is not enabled.
-3 2 MERROR_SCRIPT_KILLEDThe current running script
has been killed.
-3 3 MERROR_FILE_NOT_FOUNDThe specified file cannot be
found.
-3 4 MERROR_LIC_FEA TURE_NOT_FOUNDThe specified license
feature was not found.
-3 5 MERROR_LIC_REQUIREMENT_NOT_FOUNDThe specified license
requirement was not found.
-3 6 MERROR_LIC_EXPIRED The license has expired.


<!-- Page 12 -->

-3 7 MERROR_LIC_BAD_ID A bad ID was found in the
license file.
-3 8 MERROR_LIC_BAD_KEYA bad KEY was found in
the license file.
-3 9 MERROR_T OOLP ATH_NOT_FOUNDNo tool paths exists.
(informational and not
indicative of an error)
-4 0 MERROR_TIMED_OUT The operation timed out.
-4 1 MERROR_SOFTLIMITSA machine soft limit was
violated.
-4 2 MERROR_FILE_BADFORMA TThe format specifid is
invalid.
-4 3 MERROR_INV ALID_TYPEThe type specified is
invalid.
-4 4 MERROR_TLM_ALLOC_F AILEDThere is not enough
memory available for the
operation.
-4 5 MERROR_TLM_T OOL_UNMANAGEDThe specified tool is
unmanaged.
-4 6 MERROR_TLM_GROUP_EXPIREDThe specified tool group is
expired.
-4 7 MERROR_TLM_GROUP_NOT_FOUNDThe specified tool group
was not found.
-4 8 MERROR_TLM_GROUP_ADDEDThe specified tool group
was added.
-4 9 MERROR_TLM_GROUP_CHANGEDThe specified tool group
was changed.
-5 0 MERROR_TLM_T OOL_NOT_FOUNDThe specified tool was not
found.
-5 1 MERROR_TLM_T OOL_ADDEDThe specified tool was
added.
-5 2 MERROR_TLM_T OOL_CHANGEDThe specified tool was
changed.
-5 3 MERROR_TLM_T OOL_EXPIREDThe specified tool has
expired.
-5 4 MERROR_WIN_NOT_FOUNDThe specified window was
not found.


<!-- Page 13 -->

Return Codes by Definition
Error Definition Error
Number Error Description
MERROR_NOERROR 0 No Error .
MERROR_INV ALID_INST ANCE -1 An invalid instance numer
or handle was specified.
MERROR_INV ALID_ARG -2 An invalid ar gument was
specified.
MERROR_INV ALID_DIR -3 An invalide directory was
specified.
MERROR_INV ALID_PROFILE -4 An invlaid profile was
specified.
MERROR_FILE_EXCEPTION -5 An exception was
encountered when
processing the file.
MERROR_FILE_EMPTY -6 An empty file was
specified.
MERROR_FILE_SHARING -7 A file sharing violation
occurred.
MERROR_FILE_INV ALID -8 An invalid file was
specified.
MERROR_FILE_BADSIZE -9 The file specified it too
large.
MERROR_REGEN_DONE -1 0 The tool path regeneration
is complete.
```
MERROR_NODA TA -1 1 The API function returned
no data.
MERROR_GRID_ACTIVE -1 2 The grid is active. (not
used)
```
MERROR_NOT_IMPLEMENTED -1 3 The function is not
implemented in this version
of the API.
MERROR_MOT OR_NOT_FOUND -1 4 The specified motor was not
found.
MERROR_INV ALID_P ARAM -2 Same as
## MERROR_INV ALID_ARG


<!-- Page 14 -->

MERROR_AXIS_NOT_FOUND -1 6 The specified axis was not
found.
MERROR_API_INIT -1 7 The API failed to initialize
properly .
```
MERROR_NOT_NOW -1 8 The API function cannot be
called at this time.
MERROR_NOT_CREA TED -1 9 The object was not created.
MERROR_SIGNAL_NOT_FOUND -2 0 The specified signal was not
found.
MERROR_IO_NOT_FOUND -2 1 The specified input or
output was not found.
MERROR_SPIN_RANGE_NOT_FOUND -2 2 The specified spindle range
was not found.
MERROR_PLUGIN_NOT_FOUND -2 3 The specified plugin was
not found.
MERROR_DEVICE_NOT_FOUND -2 4 The specified device was
not found.
MERROR_INV ALID_ST ATE -2 5 The state of the control is
```
invalid for the API function.
MERROR_AXIS_NOT_ENABLED -2 6 The specified axis is not
enabled.
MERROR_REG_NOT_FOUND -2 7 The specified register was
not found.
MERROR_IPC_NOT_READY -2 8 The Interprocess
Communication subsystem
is not ready .
MERROR_NO_ROOM_A VALABLE -2 9 There are no more slots
available for another
override axis.
MERROR_NOT_COMPILED -3 0 The macros did not compile
correctly .
MERROR_NOT_ENABLED -3 1 The control is not enabled.
MERROR_SCRIPT_KILLED -3 2 The current running script
has been killed.
MERROR_FILE_NOT_FOUND -3 3 The specified file cannot be
found.
MERROR_LIC_FEA TURE_NOT_FOUND -3 4 The specified license
feature was not found.
MERROR_LIC_REQUIREMENT_NOT_FOUND -3 5 The specified license
requirement was not found.
MERROR_LIC_EXPIRED -3 6 The license has expired.


<!-- Page 15 -->

MERROR_LIC_BAD_ID -3 7 A bad ID was found in the
license file.
MERROR_LIC_BAD_KEY -3 8 A bad KEY was found in
the license file.
MERROR_T OOLP ATH_NOT_FOUND -3 9 No tool paths exists.
(informational and not
indicative of an error)
MERROR_TIMED_OUT -4 0 The operation timed out.
MERROR_SOFTLIMITS -4 1 A machine soft limit was
violated.
MERROR_FILE_BADFORMA T -4 2 The format specifid is
invalid.
MERROR_INV ALID_TYPE -4 3 The type specified is
invalid.
MERROR_TLM_ALLOC_F AILED -4 4 There is not enough
memory available for the
operation.
MERROR_TLM_T OOL_UNMANAGED -4 5 The specified tool is
unmanaged.
MERROR_TLM_GROUP_EXPIRED -4 6 The specified tool group is
expired.
MERROR_TLM_GROUP_NOT_FOUND -4 7 The specified tool group
was not found.
MERROR_TLM_GROUP_ADDED -4 8 The specified tool group
was added.
MERROR_TLM_GROUP_CHANGED -4 9 The specified tool group
was changed.
MERROR_TLM_T OOL_NOT_FOUND -5 0 The specified tool was not
found.
MERROR_TLM_T OOL_ADDED -5 1 The specified tool was
added.
MERROR_TLM_T OOL_CHANGED -5 2 The specified tool was
changed.
MERROR_TLM_T OOL_EXPIRED -5 3 The specified tool has
expired.
MERROR_WIN_NOT_FOUND -5 4 The specified window was
not found.


<!-- Page 16 -->

API Refer ence by Category
The API documentation has been devided up into categories to help quickly
locate API information for a given programming task.

```
Plugins and Devices : API functions that are primarily used to create
plugins with devices.
```
Mach I/O : API functions that are primarily used to interface with I/O
and to create I/O plugins.
```
Mach Signals : API functions that work with Mach Signals.
```
Mach Registers : API functions that work with Mach Registers.
```
Motors : API functions that work with Motors.
```
Screw Mapping : API functions that work with Motor screw maps.
```
Axes : API functions that work with Axes.
```
Motion : API functions that are primarily used to create motion plugins.
```
Operation : API functions that are used to operate the machine (Cycle
start, Feed Hold, etc...).
```
GUI: API functions that are specific to GUI programming.
```
Profile (INI) Settings : API functions for profile INI manipulation.
```
General : General API functions.


<!-- Page 17 -->

```
Gcode File : API functions to manipulate Gcode files.
```
Tool Of fsets: API functions dealing with tool of fsets and tool selection.
```
Jogging : Jogging API functions.
```
MPGs : API functions for working with MPGs.
```
Soft Limits : API functions for working with Soft Limits.
```
Spindle : Spindle API functions.
```
Scripting : API functions used for manipulating scripts.
```
Status Messages : API functions for reporting error and status
messages.
```
License : API functions for working with license files.


<!-- Page 18 -->

Plugins and Devices
The Mach core uses loadable modules know as "plugins" that provide
interfaces to devices and/or provides services. When the core is initialized,
the Plugins directory searched and each plugin found is loaded with the
following sequence:

### 1. The mc Plugin Load() entry point is called. The plugin should register
itself with the core and provide its capabilites at this time.
```
2. The mc Plugin Init() entry point is called for each Core instance.
Devices should be registered at this time as well as any I/O and
registers that belong to the device.

mc Device Get Handle
mc Device Get Info
mc Device Get Info Struct
mc Device Get Next Handle
mc Device Register
mc Plugin Configure
mc Plugin Core Load
mc Plugin Core Unload


<!-- Page 19 -->

mc Plugin Diagnostic
mc Plugin Enable
mc Plugin Get Enabled
mc Plugin Get Info Struct
mc Plugin Get License Feature
mc Plugin Get Next Handle
mc Plugin Get V alid
mc Plugin Install
mc Plugin Register
mc Plugin Remove


<!-- Page 20 -->

int mc Device Get Handle(
MINST ANCE m Inst, int devid, HMCDEV *h Dev);
h Dev , rc = mc.mc Device Get Handle(
number m Inst, number devid)
int m Inst = 0;
int devid = 0;
HMCDEV h Dev;
//See if we can find a device with an I of zero int rc = <font
color="blue">mc Device Get Handle(m Inst, devid, &h Dev);</font> if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// W e found it!</font> }


<!-- Page 21 -->

mc Device Get Info(
HMCDEV h Dev , char *name Buf, size_t name Buflen, char *desc Buf,
size_t desc Buflen, int *type, int *id);
```
name Buf, desc Buf, type, id, rc = mc.mc Device Get Info(HMCDEV h Dev}
int m Inst=0;
HMCSIG h Dev = 0;
devinfo_t devinf;
char name Buf[8 0];
char desc Buf[8 0];
int type = 0;
int id = 0;
//Look for all the IO devices and get their devinfo_t struct while
(mc Device Get Next Handle(m Inst, DEV_TYPE_IO, h Dev , &h Dev) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
<font color="blue">mc Device Get Info(h Dev , name Buf, sizeof(name Buf),
desc Buf, sizeof(desc Buf), &type, &id);</font> <font color="green">// do
```
something with the device info.</font> } else {
```
break; }
```
}


<!-- Page 22 -->

int mc Device Get Info Struct(
HMCSIG h Dev , devinfo_t *devinf);
N/A
```
struct devinfo {
```
char dev Name[8 0]; char dev Desc[8 0]; int dev T ype; int dev Id; };
```
typedef struct devinfo devinfo_t;
int m Inst=0;
HMCSIG h Dev = 0; devinfo_t devinf;
//Look for all the IO devices and get their devinfo_t struct while
(mc Device Get Next Handle(m Inst, DEV_TYPE_IO, h Dev , &h Dev) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
<font color="blue">mc Device Get Info Struct(h Dev , devinf); </font> <font
```
color="green">// Do something with the device info.</font> } else {
```
break; }
```
}


<!-- Page 23 -->

int mc Device Get Next Handle(
MINST ANCE m Inst, int devtype, HMCDEV start Dev , HMCDEV
*h Dev);
h Dev , rc = mc.mc Device Get Next Handle(
number m Inst, number devtype, number start Dev)
int m Inst=0;
HMCDEV h Dev;
<font color="green">//Look for all the IO devices</font> while (<font
color="blue">mc Device Get Next Handle(m Inst, DEV_TYPE_IO, h Dev ,
```
&h Dev)</font> == MERROR_NOERROR) {
```
if (h Sig != 0) {
```
<font color="green">// Do something with h Dev .</font> } else {
```
break; }
```
}


<!-- Page 24 -->

mc Device Register(
```
MINST ANCE m Inst, HMCPLUG plugid, const char *Device Name,
```
const char *Device Desc, int T ype, HMCDEV *h Dev);
N/A
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id; m_timer = new sim T imer(this); m_cycletime
= .0 0 1;
<font color="blue">mc Device Register(m_cid, m_id, "Sim 0",
"Simulation Device", DEV_TYPE_MOTION | DEV_TYPE_IO,
&m_h Dev);</font>
mc Register Io(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); mc Register Io(m_h Dev , "Output 0", "Output 0",
IO_TYPE_OUTPUT , &m_Output 0);
```
if (!m_timer ->Start(1 0, wx TIMER_ONE_SHOT)) {
```
wx Message Box(wx T("T imer could not start!"), wx T("T imer")); }
```
}


<!-- Page 25 -->

int mc Plugin Configure(
MINST ANCE m Inst, int plug Id);
N/A
MINST ANCE m Inst = 0;
HMCPLUG h Plug = 0;
pluginfo_t pluginf;

<font color="green">// Loop through all of the plugins looking for
plugins<br/>// that have configuration dialogs.</font> while
(mc Plugin Get Next Handle(PLUG_TYPE_CONFIG, h Plug, &h Plug) ==
```
MERROR_NOERROR) {
<font color="green">// Get the plugin info that contains the plugin ID.
</font> rc = mc Plugin Get Info Struct(h Plug, &pluginf); if (rc ==
```
MERROR_NOERROR) {
int plugin Id = pluginf.plug Id; <font color="green">// Call the
configuration dialog.</font> rc = <font
```
color="blue">mc Plugin Configure(m Inst, plugin Id);</font>; }
```
}


<!-- Page 26 -->

int mc Plugin Core Load(
```
const char *short Name);
N/A
<font color="green">// Load the mc Galil plugin.</font> int rc =
mc Plugin Core Load("mc Galil");


<!-- Page 27 -->

int mc Plugin Core Unload(
```
const char *short Name);
N/A
<font color="green">// Unload the mc Galil plugin.</font> int rc =
mc Plugin Core Unload("mc Galil");


<!-- Page 28 -->

int mc Plugin Diagnostic(
MINST ANCE m Inst, int plugin Id);
N/A
MINST ANCE m Inst = 0;
HMCPLUG h Plug = 0;
pluginfo_t pluginf;

<font color="green">// Loop through all of the plugins looking for
plugins<br/>// that have diagnostic dialogs.</font> while
(mc Plugin Get Next Handle(PLUG_TYPE_DIAG, h Plug, &h Plug) ==
```
MERROR_NOERROR) {
<font color="green">// Get the plugin info that contains the plugin ID.
</font> rc = mc Plugin Get Info Struct(h Plug, &pluginf); if (rc ==
```
MERROR_NOERROR) {
int plugin Id = pluginf.plug Id; <font color="green">// Call the diagnostics
dialog.</font> rc = <font color="blue">mc Plugin Diagnostic(m Inst,
```
plugin Id);</font>; }
```
}


<!-- Page 29 -->

int mc Plugin Enable(
HMCPLUG h Plug, BOOL enable);
N/A
HMCPLUG h Plug = 0; <font color="green">// Loop through all of the
plugins looking for plugins<br/>// that have configuration dialogs.</font>
while (mc Plugin Get Next Handle(PLUG_TYPE_CONFIG, h Plug, &h Plug)
```
== MERROR_NOERROR) {
<font color="green">// Enable the plugin.</font> rc = <font
```
color="blue">mc Plugin Enable(h Plug, TRUE)</font>; }


<!-- Page 30 -->

int mc Plugin Get Enabled(
HMCPLUG h Plug, BOOL *enabled);
N/A
HMCPLUG h Plug = 0;
BOOL enabled = F ALSE;
<font color="green">// Loop through all of the plugins looking for
plugins<br/>// that have configuration dialogs.</font> while
(mc Plugin Get Next Handle(PLUG_TYPE_CONFIG, h Plug, &h Plug) ==
```
MERROR_NOERROR) {
<font color="green">// See if the plugin is enabled..</font> rc = <font
color="blue">mc Plugin Get Enabled(h Plug, &enabled)</font>; if (rc ==
```
MERROR_NOERROR) {
```
if (enabled == TRUE) {
```
<font color="green">// The plugin is enabled!!!</font> } else {
```
<font color="green">// The plugin is not enabled!!!</font> }
```
}
```
}


<!-- Page 31 -->

mc Plugin Get Info Struct(HMCPLUG h Plug, pluginfo_t *pluginf);
N/A
HMCPLUG h Plug = 0; pluginfo_t pluginf;
<font color="green">// Loop through all of the plugins.
while (mc Plugin Get Next Handle(PLUG_TYPE_ALL, h Plug, &h Plug) ==
```
MERROR_NOERROR) {
<font color="green">// Get the plugin info that contains the plugin ID.
</font> rc = <font color="blue">mc Plugin Get Info Struct(h Plug, &pluginf)
```
</font>; if (rc == MERROR_NOERROR) {
int plugin Id = pluginf.plug Id; ...
```
}
```
}

</font>


<!-- Page 32 -->

int mc Plugin Get License Feature(
HMCPLUG h Plug, int index, char *buf, int buf Size, BOOL *status);
N/A
HMCPLUG h Plug = 0;
<font color="green">// Loop through all of the plugins.
while (mc Plugin Get Next Handle(PLUG_TYPE_ALL, h Plug, &h Plug) ==
```
MERROR_NOERROR) {
<font color="green">// Get all of the plugin license features</font> int
index = 0; char buf[8 0]; BOOL licensed = F ALSE; while (<font
color="blue">mc Plugin Get License Feature(h Plug, index, buf, sizeof(buf),
```
&licensed)</font> == MERROR_NOERROR) {
printf("license feature %s is %s.\n", buf, licensed == TRUE ? "licensed" :
```
"not licensed"); index++; }
```
}

</font>


<!-- Page 33 -->

int mc Plugin Get Next Handle(
int plug T ype, HMCPLUG start Plug, HMCPLUG *h Plug);
N/A
HMCPLUG h Plug = 0;
<font color="green">// Loop through all of the plugins looking for
plugins<br/>// that have configuration dialogs and privide I/O.</font> int
attr = PLUG_TYPE_CONFIG | PLUG_TYPE_IO; while (<font
color="blue">mc Plugin Get Next Handle(attr , h Plug, &h Plug)</font> ==
```
MERROR_NOERROR) {
<font color="green">// Enable the plugin.</font> rc =
```
mc Plugin Enable(h Plug, TRUE); }


<!-- Page 34 -->

int mc Plugin Get V alid(
HMCPLUG h Plug, BOOL *valid);
N/A
HMCPLUG h Plug = 0;
BOOL valid = F ALSE;
<font color="green">// Loop through all of the plugins checking to see if
they are valid.</font> while (mc Plugin Get Next Handle(PLUG_TYPE_ALL,
```
h Plug, &h Plug) == MERROR_NOERROR) {
<font color="green">// Check the plugin validity .</font> rc = <font
color="blue">mc Plugin Get V alid(h Plug, &valid)</font>; if (rc ==
```
MERROR_NOERROR) {
```
if (valid == TRUE) {
```
<font color="green">// The plugin is valid and will function.</font> }
```
else {
```
<font color="green">// The plugin is invalid and will not function.
```
</font> }
```
}
```
}


<!-- Page 35 -->

int mc Plugin Install(
```
const char *m 4 plug);
N/A
<font color="green">// Install the W indows mc Galil plugin from an
installation archive.</font> int rc = mc Plugin Install("mc Galil.m 4 Plugw");
```
if (rc == MERROR_NOERROR) {
```
<font color="green">//The plugin installed successfully .</font> }


<!-- Page 36 -->

int mc Plugin Register(
```
HMCPLUG h Plug, const char *Developer Id, const char *Desc, const
char *V ersion, int T ype);
N/A
```
<font color="green">// This function gets called (only once) when the
Plugin is loaded by Mach Core.</font> MCP_API int MCP_APIENTR Y
```
mc Plugin Load(HMCPLUG id) {
...
<font color="blue">mc Plugin Register(id, "Newfangled", "Simulator -
Newfangled Solutions", MC_VERSION_STR, PLUG_TYPE_MOTION |
PLUG_TYPE_IO | PLUG_TYPE_REG | PLUG_TYPE_CONFIG |
```
PLUG_TYPE_DIAG)</font>; return(MERROR_NOERROR); }


<!-- Page 37 -->

```
int mc Plugin Remove(const char *short Name);
N/A
<font color="green">// Remove the mc Galil plugin.</font> MINST ANCE
m Inst = 0; int rc = mc Plugin Remove("mc Galil");


<!-- Page 38 -->

Mach I/O
I/O is registered by devices that are registered by plugins. The Mach core
```
signals can then be mapped to the I/O. The mc Io Get Handle() function can
be used to get a handle to an I/O object. It takes a path in the form of
"device/io Name ". Once a handle is obtained, the state can be checked or set
depending if the I/O object is an input or an output. Scripts can operate with
I/O directly or through the signal interface, whichever is the most useful for
a given task.

mc Io Get Handle
mc Io Get Info Struct
mc Io Get Next Handle
mc Io Get State
mc Io Get T ype
mc Io Get User Data
mc Io Is Enabled
mc Io Register
mc Io Set Desc
mc Io Set Name
mc Io Set State


<!-- Page 39 -->

mc Io Set T ype
mc Io Set User Data
mc Io Sync Signal
mc Io Unregister


<!-- Page 40 -->

mc Io Get Handle(
```
MINST ANCE m Inst, const char *path, HMCIO *h Io);
h Io, rc = mc.mc Io Get Handle(
number m Inst, string path)
HMCIO h Io;
char *path = "Sim 0/Input 0";
<font color="blue">mc Io Get Handle(m_cid, path, &h Io);</font>


<!-- Page 41 -->

int mc Io Get Info Struct(
HMCIO h Io, ioinfo_t *ioinf);
ioinf, rc = mc.mc Io Get Info Struct(
number h Io)
```
struct ioinfo {
char io Name[8 0]; char io Desc[8 0]; int io T ype; HMCDEV io Dev;
HMCSIG io Mapped Signals[MAX_MAPPED_SIGNAL]; void
```
*io User Data; int io Input; };
```
typedef struct ioinfo ioinfo_t;
HMCDEV h Dev = 0;
devinfo_t devinf;
int rc;

<font color="green">// Get all IO information from every registered device.
</font> while (mc Device Get Next Handle(0, DEV_TYPE_IO, h Dev ,
```
&h Dev) == MERROR_NOERROR) {
```
if (mc Device Get Info Struct(h Dev , &devinf) == MERROR_NOERROR) {
HMCIO h Io = 0; while (mc Io Get Next Handle(h Dev , h Io, &h Io) ==
```
MERROR_NOERROR) {
ioinfo_t ioinf; rc = <font color="blue">mc Io Get Info Struct(h Io, &ioinf);
</font> if (rc ==


<!-- Page 42 -->

```
MERROR_NOERROR No Error .) {
```
<font color="green">// IO information successfuly retrieved.</font> }
```
}
```
}
```
}


<!-- Page 43 -->

mc Io Get Next Handle(
HMCDEV h Dev , HMCIO start Io) HMCIO *h Io)
HMCDEV h Dev = 0;
devinfo_t devinf;
int rc;

<font color="green">// Get all IO information from every registered device.
</font> while (mc Device Get Next Handle(0, DEV_TYPE_IO, h Dev ,
&h Dev) ==

```
MERROR_NOERROR No Error .) {
if (mc Device Get Info Struct(h Dev , &devinf) ==

```
MERROR_NOERROR No Error .) {
HMCIO h Io = 0; while (<font color="blue">mc Io Get Next Handle(h Dev ,
h Io, &h Io)</font> ==

```
MERROR_NOERROR No Error .) {
ioinfo_t ioinf; rc = mc Io Get Info Struct(h Io, &ioinf); if (rc ==

```
MERROR_NOERROR No Error .) {


<!-- Page 44 -->

```
<font color="green">// IO information successfuly retrieved.</font> }
```
}
```
}
```
}


<!-- Page 45 -->

mc Io Get State(
HMCIO h Io,
bool *state);
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id;
m_timer = new sim T imer(this); m_cycletime = .0 0 1; bool oldstate =
false; bool newstate = false;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
mc Io Register(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); <font color="blue">mc Io Get State(m_Input 0, &oldstate);
```
</font> newstate = sim Get IO(0); fi (newstate != oldstate) {
```
mc Io Set State(m_Input 0, newstate); }
```
}


<!-- Page 46 -->

mc Io Get T ype(
HMCIO h Io, int *type);
type, rc = mc Io Get T ype(
number h Io)
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id; m_timer = new sim T imer(this); m_cycletime
= .0 0 1; bool oldstate = false; bool newstate = false;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
mc Io Register(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); <font color="blue">mc Io Get T ype(m_Input 0, &type);</font>
```
<font color="green">// type will equal IO_TYPE_INPUT</font> }


<!-- Page 47 -->

mc Io Get User Data(
HMCIO h Io, void **data);
N/A
```
struct my Data {
```
int my Port Number; int my Pin Number; };

```
void Get User Data(void) {
MINST ANCE m Inst = 0; HMCIO h Io; void *data; if
(mc Io Get Handle(m Inst, "Sim 0/Input 0", &h Io) == MERROR_NOERROR)
```
{
<font color="blue">mc Io Get User Data(h Io, &data);</font> <font
color="green">// type cast the pointer</font> struct my Data *m Data =
```
(struct my Data *)data; }
```
}


<!-- Page 48 -->

mc Io Is Enabled (
HMCIO h Io, bool *enabled);
HMCIO h Io;
char *path = "Sim 0/Input 0"; bool enabled; mc Io Get Handle(m_cid, path,
&h Io);<font color="green">//Get the handle</font> mc Io Is Enabled(h Io ,
&enabled);<font color="green">//Get the enabled state of the IO</font>


<!-- Page 49 -->

mc Io Register(
```
HMCDEV h Dev , const char *Io Name, const char *Io Desc, int T ype,
HMCIO *h Io);
N/A
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id; m_timer = new sim T imer(this); m_cycletime
= .0 0 1;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
<font color="blue">mc Io Register(m_h Dev , "Input 0", "Input 0",
IO_TYPE_INPUT , &m_Input 0); mc Io Register(m_h Dev , "Output 0",
"Output 0", IO_TYPE_OUTPUT , &m_Output 0);</font>
```
if (!m_timer ->Start(1 0, wx TIMER_ONE_SHOT)) {
```
wx Message Box(wx T("T imer could not start!"), wx T("T imer")); }
```
}


<!-- Page 50 -->

mc Io Set Desc(
```
HMCIO h Io, const char *desc);
rc = mc.mc Io Set Desc(
number h Io, string desc)
HMCIO h Io;
char *path = "Sim 0/Input 0";
```
if (mc Io Get Handle(m_cid, path, &h Io) == MERROR_NOERROR) {
```
<font color="blue">mc Io Set Desc(h Io, "my mew description);</font> }


<!-- Page 51 -->

mc Io Set Name(
```
HMCIO h Io, const char *name);
rc = mc.mc Io Set Name(
number h Io, string name)
HMCIO h Io;
char *path = "Sim 0/Input 0";
```
if (mc Io Get Handle(m_cid, path, &h Io) == MERROR_NOERROR) {
<font color="blue">mc Io Set Name(h Io, "Limit 0++");</font> <font
```
color="green">// The name is changed from Input 0 to Limit 0++</font> }


<!-- Page 52 -->

mc Io Set State(
HMCIO h Io,
bool state);
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id;
m_timer = new sim T imer(this); m_cycletime = .0 0 1; bool oldstate =
false; bool newstate = false;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
mc Io Register(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); <font color="blue">mc Io Get State(m_Input 0, &oldstate);
```
</font> newstate = sim Get IO(0); if (newstate != oldstate) {
```
mc Io Set State(m_Input 0, newstate); }
```
}


<!-- Page 53 -->

mc Io Set T ype(
HMCIO h Io,
int type);
rc = mc Io Set T ype(
number h Io
number type)
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id;
m_timer = new sim T imer(this); m_cycletime = .0 0 1; bool oldstate =
false; bool newstate = false;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
mc Io Register(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); <font color="blue">mc Io Set T ype(m_Input 0,
IO_TYPE_OUTPUT);</font> <font color="green">// change the type to
```
IO_TYPE_OUTPUT</font> }


<!-- Page 54 -->

mc Io Set User Data(
HMCIO h Io, void **data);
N/A
```
struct my Data {
```
int my Port Number; int my Pin Number; };

struct my Data data;
```
void Get User Data(void) {
MINST ANCE m Inst = 0; HMCIO h Io; struct my Data data;
data.my Port Number = 1; data.my Pin Number = 1 2; if
(mc Io Get Handle(m Inst, "Sim 0/Input 0", &h Io) == MERROR_NOERROR)
```
{
```
<font color="blue">mc Io Set User Data(h Io, &data);</font> }
```
}


<!-- Page 55 -->

mc Io Sync Signal(
HMCIO h Io,
BOOL state);
N/A
N/A


<!-- Page 56 -->

mc Io Unregister(
HMCDEV h Dev , HMCIO h Io);
N/A

N/A


<!-- Page 57 -->

Mach Signals
The Mach core communicates with the outside world via a signal
mechanism. All signals are "owned" by the core. The core drives output
signals and input signals direct the core. This means that a user should
never set an output signal and the core will never set an input signal.
It is important to note that signals are not I/O. However , output signals can
drive outputs and inputs can drive input signals if they are mapped to
```
repective I/O objects. This mapping is performed with mc Signal Map(). The
I/O device has no need to know what signals to which any I/O may be
```
mapped. This allows for abstraction of the signal functions.
Signals operations use a handle that represents the signal object in the core.
```
This handle can be obtained via mc Signal Get Handle() by providing a signal
ID. Signal IDs are defined in the Mach API.h header file. Input signal ID
definitions begin with ISIG and output signal ID definitions begin with
OSIG .
The state of input and output signals can be retieved via
```
mc Signal Get State(). The the state of input signals can be set via
```
mc Signal Set State().
```
Signal information can be retireve via mc Signal Get Info() and
```
mc Signal Get Info Struct().

Input Signals
Output Signals
mc Signal Enable


<!-- Page 58 -->

mc Signal Get Handle
mc Signal Get Info
mc Signal Get Info Struct
mc Signal Get Next Handle
mc Signal Get State
mc Signal Handle W ait
mc Signal Map
mc Signal Set Active Low
mc Signal Set State
mc Signal Unmap
mc Signal W ait


<!-- Page 59 -->

Input Signals
Signal Description
ISIG_PROBE Probe
ISIG_PROBE 1 Probe 1
ISIG_PROBE 2 Probe 2
ISIG_PROBE 3 Probe 3
ISIG_INDEX Index
ISIG_INPUT 0 Input #0
ISIG_INPUT 1 Input #1
ISIG_INPUT 2 Input #2
ISIG_INPUT 3 Input #3
ISIG_INPUT 4 Input #4
ISIG_INPUT 5 Input #5
ISIG_INPUT 6 Input #6
ISIG_INPUT 7 Input #7
ISIG_INPUT 8 Input #8
ISIG_INPUT 9 Input #9
ISIG_INPUT 1 0 Input #1 0
ISIG_INPUT 1 1 Input #1 1
ISIG_INPUT 1 2 Input #1 2
ISIG_INPUT 1 3 Input #1 3
ISIG_INPUT 1 4 Input #1 4
ISIG_INPUT 1 5 Input #1 5
ISIG_INPUT 1 6 Input #1 6
ISIG_INPUT 1 7 Input #1 7


<!-- Page 60 -->

ISIG_INPUT 1 8 Input #1 8
ISIG_INPUT 1 9 Input #1 9
ISIG_INPUT 2 0 Input #2 0
ISIG_INPUT 2 1 Input #2 1
ISIG_INPUT 2 2 Input #2 2
ISIG_INPUT 2 3 Input #2 3
ISIG_INPUT 2 4 Input #2 4
ISIG_INPUT 2 5 Input #2 5
ISIG_INPUT 2 6 Input #2 6
ISIG_INPUT 2 7 Input #2 7
ISIG_INPUT 2 8 Input #2 8
ISIG_INPUT 2 9 Input #2 9
ISIG_INPUT 3 0 Input #3 0
ISIG_INPUT 3 1 Input #3 1
ISIG_INPUT 3 2 Input #3 2
ISIG_INPUT 3 3 Input #3 3
ISIG_INPUT 3 4 Input #3 4
ISIG_INPUT 3 5 Input #3 5
ISIG_INPUT 3 6 Input #3 6
ISIG_INPUT 3 7 Input #3 7
ISIG_INPUT 3 8 Input #3 8
ISIG_INPUT 3 9 Input #3 9
ISIG_INPUT 4 0 Input #4 0
ISIG_INPUT 4 1 Input #4 1
ISIG_INPUT 4 2 Input #4 2
ISIG_INPUT 4 3 Input #4 3
ISIG_INPUT 4 4 Input #4 4
ISIG_INPUT 4 5 Input #4 5
ISIG_INPUT 4 6 Input #4 6


<!-- Page 61 -->

ISIG_INPUT 4 7 Input #4 7
ISIG_INPUT 4 8 Input #4 8
ISIG_INPUT 4 9 Input #4 9
ISIG_INPUT 5 0 Input #5 0
ISIG_INPUT 5 1 Input #5 1
ISIG_INPUT 5 2 Input #5 2
ISIG_INPUT 5 3 Input #5 3
ISIG_INPUT 5 4 Input #5 4
ISIG_INPUT 5 5 Input #5 5
ISIG_INPUT 5 6 Input #5 6
ISIG_INPUT 5 7 Input #5 7
ISIG_INPUT 5 8 Input #5 8
ISIG_INPUT 5 9 Input #5 9
ISIG_INPUT 6 0 Input #6 0
ISIG_INPUT 6 1 Input #6 1
ISIG_INPUT 6 2 Input #6 2
ISIG_INPUT 6 3 Input #6 3
ISIG_LIMIT OVER Limit Override
ISIG_EMERGENCY E-Stop
ISIG_THCON THC On
ISIG_THCUP THC Up
ISIG_THCDOWN THC Down
ISIG_TIMING Timing
ISIG_JOGXP Jog X+
ISIG_JOGXN Jog X-
ISIG_JOGYP Jog Y+
ISIG_JOGYN Jog Y -
ISIG_JOGZP Jog Z+


<!-- Page 62 -->

ISIG_JOGZN Jog Z-
ISIG_JOGAP Jog A+
ISIG_JOGAN Jog A-
ISIG_JOGBP Jog B+
ISIG_JOGBN Jog B-
ISIG_JOGCP Jog C+
ISIG_JOGCN Jog C-
ISIG_SPINDLE_A T_SPEED Spindle At Speed
ISIG_SPINDLE_A T_ZERO Spindle At Zero
ISIG_MOT OR 0 _HOME Motor 0 Home
ISIG_MOT OR 0 _PLUS Motor 0 ++
ISIG_MOT OR 0 _MINUS Motor 0 --
ISIG_MOT OR 1 _HOME Motor 1 Home
ISIG_MOT OR 1 _PLUS Motor 1 ++
ISIG_MOT OR 1 _MINUS Motor 1 --
ISIG_MOT OR 2 _HOME Motor 2 Home
ISIG_MOT OR 2 _PLUS Motor 2 ++
ISIG_MOT OR 2 _MINUS Motor 2 --
ISIG_MOT OR 3 _HOME Motor 3 Home
ISIG_MOT OR 3 _PLUS Motor 3 ++
ISIG_MOT OR 3 _MINUS Motor 3 --
ISIG_MOT OR 4 _HOME Motor 4 Home
ISIG_MOT OR 4 _PLUS Motor 4 ++
ISIG_MOT OR 4 _MINUS Motor 4 --
ISIG_MOT OR 5 _HOME Motor 5 Home
ISIG_MOT OR 5 _PLUS Motor 5 ++
ISIG_MOT OR 5 _MINUS Motor 5 --
ISIG_MOT OR 6 _HOME Motor 6 Home
ISIG_MOT OR 6 _PLUS Motor 6 ++


<!-- Page 63 -->

ISIG_MOT OR 6 _MINUS Motor 6 --
ISIG_MOT OR 7 _HOME Motor 7 Home
ISIG_MOT OR 7 _PLUS Motor 7 ++
ISIG_MOT OR 7 _MINUS Motor 7 --
ISIG_MOT OR 8 _HOME Motor 8 Home
ISIG_MOT OR 8 _PLUS Motor 8 ++
ISIG_MOT OR 8 _MINUS Motor 8 --
ISIG_MOT OR 9 _HOME Motor 9 Home
ISIG_MOT OR 9 _PLUS Motor 9 ++
ISIG_MOT OR 9 _MINUS Motor 9 --
ISIG_MOT OR 1 0_HOME Motor 1 0 Home
ISIG_MOT OR 1 0_PLUS Motor 1 0 ++
ISIG_MOT OR 1 0_MINUS Motor 1 0 --
ISIG_MOT OR 1 1_HOME Motor 1 1 Home
ISIG_MOT OR 1 1_PLUS Motor 1 1 ++
ISIG_MOT OR 1 1_MINUS Motor 1 1 --
ISIG_MOT OR 1 2_HOME Motor 1 2 Home
ISIG_MOT OR 1 2_PLUS Motor 1 2 ++
ISIG_MOT OR 1 2_MINUS Motor 1 2 --
ISIG_MOT OR 1 3_HOME Motor 1 3 Home
ISIG_MOT OR 1 3_PLUS Motor 1 3 ++
ISIG_MOT OR 1 3_MINUS Motor 1 3 --
ISIG_MOT OR 1 4_HOME Motor 1 4 Home
ISIG_MOT OR 1 4_PLUS Motor 1 4 ++
ISIG_MOT OR 1 4_MINUS Motor 1 4 --
ISIG_MOT OR 1 5_HOME Motor 1 5 Home
ISIG_MOT OR 1 5_PLUS Motor 1 5 ++
ISIG_MOT OR 1 5_MINUS Motor 1 5 --


<!-- Page 64 -->

ISIG_MOT OR 1 6_HOME Motor 1 6 Home
ISIG_MOT OR 1 6_PLUS Motor 1 6 ++
ISIG_MOT OR 1 6_MINUS Motor 1 6 --
ISIG_MOT OR 1 7_HOME Motor 1 7 Home
ISIG_MOT OR 1 7_PLUS Motor 1 7 ++
ISIG_MOT OR 1 7_MINUS Motor 1 7 --
ISIG_MOT OR 1 8_HOME Motor 1 8 Home
ISIG_MOT OR 1 8_PLUS Motor 1 8 ++
ISIG_MOT OR 1 8_MINUS Motor 1 8 --
ISIG_MOT OR 1 9_HOME Motor 1 9 Home
ISIG_MOT OR 1 9_PLUS Motor 1 9 ++
ISIG_MOT OR 1 9_MINUS Motor 1 9 --
ISIG_MOT OR 2 0_HOME Motor 2 0 Home
ISIG_MOT OR 2 0_PLUS Motor 2 0 ++
ISIG_MOT OR 2 0_MINUS Motor 2 0 --
ISIG_MOT OR 2 1_HOME Motor 2 1 Home
ISIG_MOT OR 2 1_PLUS Motor 2 1 ++
ISIG_MOT OR 2 1_MINUS Motor 2 1 --
ISIG_MOT OR 2 2_HOME Motor 2 2 Home
ISIG_MOT OR 2 2_PLUS Motor 2 2 ++
ISIG_MOT OR 2 2_MINUS Motor 2 2 --
ISIG_MOT OR 2 3_HOME Motor 2 3 Home
ISIG_MOT OR 2 3_PLUS Motor 2 3 ++
ISIG_MOT OR 2 3_MINUS Motor 2 3 --
ISIG_MOT OR 2 4_HOME Motor 2 4 Home
ISIG_MOT OR 2 4_PLUS Motor 2 4 ++
ISIG_MOT OR 2 4_MINUS Motor 2 4 --
ISIG_MOT OR 2 5_HOME Motor 2 5 Home
ISIG_MOT OR 2 5_PLUS Motor 2 5 ++


<!-- Page 65 -->

ISIG_MOT OR 2 5_MINUS Motor 2 5 --
ISIG_MOT OR 2 6_HOME Motor 2 6 Home
ISIG_MOT OR 2 6_PLUS Motor 2 6 ++
ISIG_MOT OR 2 6_MINUS Motor 2 6 --
ISIG_MOT OR 2 7_HOME Motor 2 7 Home
ISIG_MOT OR 2 7_PLUS Motor 2 7 ++
ISIG_MOT OR 2 7_MINUS Motor 2 7 --
ISIG_MOT OR 2 8_HOME Motor 2 8 Home
ISIG_MOT OR 2 8_PLUS Motor 2 8 ++
ISIG_MOT OR 2 8_MINUS Motor 2 8 --
ISIG_MOT OR 2 9_HOME Motor 2 9 Home
ISIG_MOT OR 2 9_PLUS Motor 2 9 ++
ISIG_MOT OR 2 9_MINUS Motor 2 9 --
ISIG_MOT OR 3 0_HOME Motor 3 0 Home
ISIG_MOT OR 3 0_PLUS Motor 3 0 ++
ISIG_MOT OR 3 0_MINUS Motor 3 0 --
ISIG_MOT OR 3 1_HOME Motor 3 1 Home
ISIG_MOT OR 3 1_PLUS Motor 3 1 ++
ISIG_MOT OR 3 1_MINUS Motor 3 1 --


<!-- Page 66 -->

Output Signals
Signal Description
OSIG_DIGTRIGGER Digitize T rigger
OSIG_SPINDLEON Spindle On
OSIG_SPINDLEFWD Spindle Fwd
OSIG_SPINDLEREV Spindle Rev
OSIG_COOLANT ON Coolant On
OSIG_MIST ON Mist On
OSIG_CHARGE Char ge Pump #1
OSIG_CHARGE 2 Char ge Pump #2
OSIG_CURRENTHILOW Current Hi/Low
OSIG_ENABLE 0 Enable #0
OSIG_ENABLE 1 Enable #1
OSIG_ENABLE 2 Enable #2
OSIG_ENABLE 3 Enable #3
OSIG_ENABLE 4 Enable #4
OSIG_ENABLE 5 Enable #5
OSIG_ENABLE 6 Enable #6
OSIG_ENABLE 7 Enable #7
OSIG_ENABLE 8 Enable #8
OSIG_ENABLE 9 Enable #9
OSIG_ENABLE 1 0 Enable #1 0
OSIG_ENABLE 1 1 Enable #1 1
OSIG_ENABLE 1 2 Enable #1 2
OSIG_ENABLE 1 3 Enable #1 3


<!-- Page 67 -->

OSIG_ENABLE 1 4 Enable #1 4
OSIG_ENABLE 1 5 Enable #1 5
OSIG_ENABLE 1 6 Enable #1 6
OSIG_ENABLE 1 7 Enable #1 7
OSIG_ENABLE 1 8 Enable #1 8
OSIG_ENABLE 1 9 Enable #1 9
OSIG_ENABLE 2 0 Enable #2 0
OSIG_ENABLE 2 1 Enable #2 1
OSIG_ENABLE 2 2 Enable #2 2
OSIG_ENABLE 2 3 Enable #2 3
OSIG_ENABLE 2 4 Enable #2 4
OSIG_ENABLE 2 5 Enable #2 5
OSIG_ENABLE 2 6 Enable #2 6
OSIG_ENABLE 2 7 Enable #2 7
OSIG_ENABLE 2 8 Enable #2 8
OSIG_ENABLE 2 9 Enable #2 9
OSIG_ENABLE 3 0 Enable #3 0
OSIG_ENABLE 3 1 Enable #3 1
OSIG_XLIMITPLUS X ++
## OSIG_XLIMITMINUS X --
OSIG_XHOME X Home
OSIG_YLIMITPLUS Y ++
## OSIG_YLIMITMINUS Y --
OSIG_YHOME Y Home
OSIG_ZLIMITPLUS Z ++
## OSIG_ZLIMITMINUS Z --
OSIG_ZHOME Z Home
OSIG_ALIMITPLUS A ++
## OSIG_ALIMITMINUS A --


<!-- Page 68 -->

OSIG_AHOME A Home
OSIG_BLIMITPLUS B ++
## OSIG_BLIMITMINUS B --
OSIG_BHOME B Home
OSIG_CLIMITPLUS C ++
## OSIG_CLIMITMINUS C --
OSIG_CHOME C Home
OSIG_OUTPUT 0 Output #0
OSIG_OUTPUT 1 Output #1
OSIG_OUTPUT 2 Output #2
OSIG_OUTPUT 3 Output #3
OSIG_OUTPUT 4 Output #4
OSIG_OUTPUT 5 Output #5
OSIG_OUTPUT 6 Output #6
OSIG_OUTPUT 7 Output #7
OSIG_OUTPUT 8 Output #8
OSIG_OUTPUT 9 Output #9
OSIG_OUTPUT 1 0 Output #1 0
OSIG_OUTPUT 1 1 Output #1 1
OSIG_OUTPUT 1 2 Output #1 2
OSIG_OUTPUT 1 3 Output #1 3
OSIG_OUTPUT 1 4 Output #1 4
OSIG_OUTPUT 1 5 Output #1 5
OSIG_OUTPUT 1 6 Output #1 6
OSIG_OUTPUT 1 7 Output #1 7
OSIG_OUTPUT 1 8 Output #1 8
OSIG_OUTPUT 1 9 Output #1 9
OSIG_OUTPUT 2 0 Output #2 0


<!-- Page 69 -->

OSIG_OUTPUT 2 1 Output #2 1
OSIG_OUTPUT 2 2 Output #2 2
OSIG_OUTPUT 2 3 Output #2 3
OSIG_OUTPUT 2 4 Output #2 4
OSIG_OUTPUT 2 5 Output #2 5
OSIG_OUTPUT 2 6 Output #2 6
OSIG_OUTPUT 2 7 Output #2 7
OSIG_OUTPUT 2 8 Output #2 8
OSIG_OUTPUT 2 9 Output #2 9
OSIG_OUTPUT 3 0 Output #3 0
OSIG_OUTPUT 3 1 Output #3 1
OSIG_OUTPUT 3 2 Output #3 2
OSIG_OUTPUT 3 3 Output #3 3
OSIG_OUTPUT 3 4 Output #3 4
OSIG_OUTPUT 3 5 Output #3 5
OSIG_OUTPUT 3 6 Output #3 6
OSIG_OUTPUT 3 7 Output #3 7
OSIG_OUTPUT 3 8 Output #3 8
OSIG_OUTPUT 3 9 Output #3 9
OSIG_OUTPUT 4 0 Output #4 0
OSIG_OUTPUT 4 1 Output #4 1
OSIG_OUTPUT 4 2 Output #4 2
OSIG_OUTPUT 4 3 Output #4 3
OSIG_OUTPUT 4 4 Output #4 4
OSIG_OUTPUT 4 5 Output #4 5
OSIG_OUTPUT 4 6 Output #4 6
OSIG_OUTPUT 4 7 Output #4 7
OSIG_OUTPUT 4 8 Output #4 8
OSIG_OUTPUT 4 9 Output #4 9


<!-- Page 70 -->

OSIG_OUTPUT 5 0 Output #5 0
OSIG_OUTPUT 5 1 Output #5 1
OSIG_OUTPUT 5 2 Output #5 2
OSIG_OUTPUT 5 3 Output #5 3
OSIG_OUTPUT 5 4 Output #5 4
OSIG_OUTPUT 5 5 Output #5 5
OSIG_OUTPUT 5 6 Output #5 6
OSIG_OUTPUT 5 7 Output #5 7
OSIG_OUTPUT 5 8 Output #5 8
OSIG_OUTPUT 5 9 Output #5 9
OSIG_OUTPUT 6 0 Output #6 0
OSIG_OUTPUT 6 1 Output #6 1
OSIG_OUTPUT 6 2 Output #6 2
OSIG_OUTPUT 6 3 Output #6 3
OSIG_RUNNING_GCODE Gcode Running
OSIG_FEEDHOLD Feed Hold
OSIG_BLOCK_DELETE Block Delete
OSIG_SINGLE_BLOCK Single Block
OSIG_REVERSE_RUN Reverse Run
OSIG_OPT_ST OP Opt Stop
OSIG_MACHINE_ENABLED Machine Enabled
OSIG_T OOL_CHANGE Tool Change
OSIG_DIST_T OGO Dist T o Go
OSIG_MACHINE_CORD Machine Coord
OSIG_SOFTLIMITS_ON Softlimits On
OSIG_JOG_INC Jog Inc
OSIG_JOG_CONT Jog Cont
OSIG_JOG_ENABLED Jog Enabled


<!-- Page 71 -->

OSIG_JOG_MPG Jog MPG
OSIG_HOMED_X X Homed
OSIG_HOMED_Y Y Homed
OSIG_HOMED_Z Z Homed
OSIG_HOMED_A A Homed
OSIG_HOMED_B B Homed
OSIG_HOMED_C C Homed
OSIG_DWELL Dwell
OSIG_TP_MOUSE_DN Toolpath Mouse Down
OSIG_LIMIT OVER Limit Override
OSIG_ALARM Alarm
OSIG_PR TSF Parts Finished


<!-- Page 72 -->

int mc Signal Enable(
HMCSIG h Sig, BOOL enabled);
rc = mc.mc Signal Enable(
number h Sig, number enabled)
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id;
m_timer = new sim T imer(this); m_cycletime = .0 0 1; HMCSIG h Sig;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
mc Io Register(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); mc Io Register(m_h Dev , "Output 0", "Output 0",
IO_TYPE_OUTPUT , &m_Output 0)
if (mc Signal Get Handle(m_cid, ISIG_INPUT 1, int sigid, &h Sig) ==
```
MERROR_NOERROR) {
```
if (mc Signal Map(h Sig, m_Input 0) == MERROR_NOERROR) {
<font color="green">// Signal mapped successfuly</font> <font
color="blue">mc Signal Enable(h Sig, TRUE);</font> <font
```
color="green">// Enable the signal.</font> }
```
}
```
}


<!-- Page 73 -->

int mc Signal Get Handle(
MINST ANCE m Inst, int sigid,
HMCSIG *h Sig);
h Sig, rc = mc.mc Signal Get Handle(
number m Inst, number sigid)
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id;
m_timer = new sim T imer(this); m_cycletime = .0 0 1; HMCSIG h Sig;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
mc Io Register(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); mc Io Register(m_h Dev , "Output 0", "Output 0",
IO_TYPE_OUTPUT , &m_Output 0)
if (<font color="blue">mc Signal Get Handle(m_cid, ISIG_INPUT 1,
```
&h Sig)</font> == MERROR_NOERROR) {
```
if (mc Signal Map(h Sig, m_Input 0) == MERROR_NOERROR) {
<font color="green">// Signal mapped successfuly .</font>
mc Signal Enable(h Sig, true); <font color="green">// Enable the signal.
```
</font> }
```
}
```
}


<!-- Page 74 -->

int mc Signal Get Info(
HMCSIG h Sig, int *enabled, char *name, size_t namelen, char *desc,
size_t desclen, int *activelow);
enabled, name, desc, activelow , rc = mc.mc Signal Get Info(number h Sig)
HMCSIG h Sig = 0;
int enabled = 0;
int name Len = 2 0
char name Buf[name Len]; int desc Len = 4 0;
char desc Buf[desc Len]; int active Low = 0;

while (mc Signal Get Next Handle(0, SIG_TYPE_INPUT , h Sig, &h Sig) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
<font color="blue">mc Signal Get Info(h Sig, &enabled, name Buf,
```
name Len, desc Buf, desc Len, &active Low)</font>; } else {
```
break; }
```
}


<!-- Page 75 -->

int mc Signal Get Info Struct(
HMCSIG h Sig, siginfo_t *siginf);
siginf, rc = mc.mc Signal Get Info Struct(
number h Sig)
```
struct siginfo {
char sig Name[8 0]; char sig Desc[8 0]; int sig Enabled; int sig Active Low;
```
HMCIO sig Mapped Io Handle; };
```
typedef struct siginfo siginfo_t;
HMCSIG h Sig = 0;
siginfo_t siginf;

while (mc Signal Get Next Handle(0, SIG_TYPE_INPUT , h Sig, &h Sig) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
```
<font color="blue">mc Signal Get Info Struct(h Sig, &siginf);</font> } else
```
{
```
break; }
```
}


<!-- Page 76 -->

int mc Signal Get Next Handle(
MINST ANCE m Inst, int sigtype, HMCSIG start Sig, HMCSIG *h Sig);
h Sig, rc = mc.mc Signal Get Next Handle(
number m Inst, number sigtype, number start Sig)
HMCSIG h Sig = 0;

while (<font color="blue">mc Signal Get Next Handle(0,
```
SIG_TYPE_INPUT , h Sig, &h Sig)</font> == MERROR_NOERROR) {
```
if (h Sig != 0) {
```
<font color="green">// Do something with h Sig.</font> } else {
```
break; }
```
}


<!-- Page 77 -->

int mc Signal Get State(
HMCSIG h Sig, BOOL *state)
state, rc = mc.mc Signal Get State(
number h Sig)
HMCSIG h Sig = 0;
BOOL sig State = F ALSE;
<font color="green">// Get the state of all input signals.</font> while
(mc Signal Get Next Handle(0, SIG_TYPE_INPUT , h Sig, &h Sig) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
```
<font color="blue">mc Signal Get State(h Sig, &sig State);</font> } else {
```
break; }
```
}


<!-- Page 78 -->

int mc Signal Handle W ait(
HMCSIG h Sig, int wait Mode, double timeout Secs);
rc = mc.mc Signal Handle W ait(
number h Sig, number wait Mode, number timeout Secs);
MINST ANCE m Inst = 0;
HMCSIG h Sig;
int rc;
rc = mc Signal Get Handle(m Inst, ISIG_INPUT 1 &h Sig); if (rc ==
```
MERROR_NOERROR) {
rc = <font color="blue">mc Signal Handle W ait(h Sig,
```
WAIT_MODE_HIGH, .5)</font>; switch (rc) {
case MERROR_NOERROR: <font color="green">// Signal changed
state from low to high</font> break; case MERROR_TIMED_OUT : <font
color="green">// The signal didn't change state in the alotted time.</font>
break; case MERROR_NOT_ENABLED: <font color="green">// The
```
control was not enabled at the time of the function call or the control was
```
disabled during the function call.</font> break; }
```
}


<!-- Page 79 -->

int mc Signal Map(
HMCSIG h Sig, HMCIO h Io);
rc = mc.mc Signal Map(
number h Sig, number h Io)
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id; m_timer = new sim T imer(this); m_cycletime
= .0 0 1; HMCSIG h Sig;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
mc Io Register(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); mc Io Register(m_h Dev , "Output 0", "Output 0",
IO_TYPE_OUTPUT , &m_Output 0)
if (mc Signal Get Handle(m_cid, ISIG_INPUT 1, &h Sig) ==
```
MERROR_NOERROR) {
if (<font color="blue">mc Signal Map(h Sig, m_Input 0)</font> ==
```
MERROR_NOERROR) {
```
<font color="green">// Signal mapped successfuly</font> }
```
}
```
}


<!-- Page 80 -->

int mc Signal Set Active Low(
HMCSIG h Sig, BOOL activelow);
rc = mc.mc Signal Set Active Low(
number h Sig, number activelow)
HMCSIG h Sig = 0;
BOOL active Low = TRUE;

<font color="green">// Set all input signals active low .</font> while
(mc Signal Get Next Handle(0, SIG_TYPE_INPUT , h Sig, &h Sig) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
```
<font color="blue">mc Signal Set Active Low(h Sig, active Low);</font> }
```
else {
```
break; }
```
}


<!-- Page 81 -->

int mc Signal Set State(
HMCSIG h Sig, BOOL enabled);
rc = mc.mc Signal Set State(
number h Sig, number enabled)
HMCSIG h Sig = 0;

<font color="green">// Set all output signals inactive.</font> while
(mc Signal Get Next Handle(0, SIG_TYPE_OUTPUT , h Sig, &h Sig) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
```
<font color="blue">mc Signal Set State(h Sig, F ALSE);</font> } else {
```
break; }
```
}


<!-- Page 82 -->

int mc Signal Unmap(
HMCSIG h Sig);
rc = mc.mc Signal Unmap(
number h Sig)
MINST ANCE m Inst = 0; HMCSIG h Sig;

if (mc Signal Get Handle(m Inst, ISIG_INPUT 1, &h Sig) ==
```
MERROR_NOERROR) {
if (<font color="blue">mc Signal Unmap(h Sig)</font> ==
```
MERROR_NOERROR) {
```
<font color="green">// Signal now has no I/O mappings</font> }
```
}


<!-- Page 83 -->

int mc Signal W ait(
MINST ANCE m Inst, int sig Id, int wait Mode, double timeout Secs);
rc = mc.mc Signal W ait(
number m Inst, number sig Id, number wait Mode, number timeout Secs);
MINST ANCE m Inst = 0; HMCSIG h Sig;
int rc;

rc = <font color="blue">mc Signal W ait(m Inst, ISIG_INPUT 1,
```
WAIT_MODE_HIGH, .5)</font>; switch (rc) {
case MERROR_NOERROR: <font color="green">// Signal changed state
from low to high</font> break; case MERROR_TIMED_OUT : <font
color="green">// The signal didn't change state in the alotted time.</font>
break; case MERROR_NOT_ENABLED: <font color="green">// The
```
control was not enabled at the time of the function call or the control was
```
disabled during the function call.</font> break; }


<!-- Page 84 -->

Mach Registers
Mach registers are multi-purpose storage locations that can be defined
(registered) by plugins. The parent to a register is a plugin device. Registers
can contain data of any type, even string data.
Registers provide a uniquie storage location that is owned by the plugin that
creates it. This is in contrast to Mach 3 DROs and LEDs that could be
overwritten if two plugins wrote to the same DRO number not knowing that
the other plugin also used that same DRO number . However , registers can
be written and read from any script or plugin. But the name of the register
has to be known!
The maximum string length is 4 0 9 6 bytes for registers other than
REG_TYPE_COMMAND type registers and 1 0 2 4 bytes for the
REG_TYPE_COMMAND type registers.
When a register is registered to the system, you must specify the register
type. The dif ferent types are discussed below:
REG_TYPE_NONE specifies a register that is not typed. This kind of
register is basically just a data container that will not notify any process if
the data it stores changes.
REG_TYPE_INPUT specifies a register that can be mapped to a Mach
input signal or an analog object. Mach and any GUI front end is notified if
the data in this type of register is changed with a MSG_REG_CHANGED
message. This type of register usually contains boolean data if mapped to a
signal or ADC values.
REG_TYPE_INPUT_NUMERIC specifies a register that the same as
REG_TYPE_INPUT but can ONL Y contain numeric data. Registers of
this type typically can process faster than REG_TYPE_INPUT registers
REG_TYPE_OUTPUT specifies a register that can be mapped to a Mach
output signal or an analog object. The plugin that owns this register is


<!-- Page 85 -->

notified with a MSG_REG_CHANGED synchronous message. All other
plugins and the GUI are notified asynchronously with
MSG_REG_CHANGED .
REG_TYPE_OUTPUT_NUMERIC specifies a register that the same as
REG_TYPE_OUTPUT but can ONL Y contain numeric data. Registers of
this type typically can process faster than REG_TYPE_OUTPUT registers
REG_TYPE_HOLDING specifies a general purpose register that cannot
be mapped to either an input or output signal. The plugin that owns this
register is notified with a MSG_REG_CHANGED synchronous message.
All other plugins and the GUI are notified asynchronously with
MSG_REG_CHANGED . This type of register usually contains boolean
data.
REG_TYPE_COMMAND specifies a special purpose register that can be
used to implement a simple command/response communication mechanism.
Only the plugin that owns the register is notified with a
MSG_REG_COMMAND synchronous message. It works with
mc Reg Send Command
on the client side of the communication and
mc Reg Get Command
and
mc Reg Set Response
on the plguin side.
REG_TYPE_ENCODER specifies a register that can be mapped to a
MPG or used to display the encoder counts in the GUI. Only Mach and the
GUI are notified with a MSG_REG_CHANGED synchronous message.

mc Reg Get Command
mc Reg Get Handle
mc Reg Get Info
mc Reg Get Info Struct
mc Reg Get Next Handle


<!-- Page 86 -->

mc Reg Get User Data
mc Reg Get V alue
mc Reg Get V alue Long
mc Reg Get V alue String
mc Reg Get V alue String Clear
mc Reg Register
mc Reg Send Command
mc Reg Set Desc
mc Reg Set Name
mc Reg Set Response
mc Reg Set T ype
mc Reg Set User Data
mc Reg Set V alue
mc Reg Set V alue Long
mc Reg Set V alue String
mc Reg Unregister


<!-- Page 87 -->

int mc Reg Get Command(
HMCREG h Reg,
char *cmd,
size_t cmd Len)
N/A
<font color="green">// Retrieve the register command.</font> int
```
sim Control::Process Msg(long msg, long param 1, long param 2) {
HMCREG h Reg = (HMCREG)param 1; long Reg V al;
```
switch (msg) {
case MSG_REG_COMMAND: mc Reg Get V alue Long(h Reg, &Reg V al);
```
if (h Reg = m_Reg Command) { <font color="green">// Is this our command
register?</font> char command[1 0 2 4]; mc Reg Get Command(h Reg,
command, sizeof(command)); wx String cmd(command);
```
cmd.Make Upper(); if (cmd == wx T("THC ON")) {
```
m_thc = true; mc Reg Set Response(h Reg, "OK"); } else if (cmd ==
```
wx T("THC OFF")) {
m_thc = false; mc Motion Sync(m_cid); mc Reg Set Response(h Reg, "OK");
```
} else if (cmd == wx T("THC ST ATUS")) {
```
if (m_thc) {
```
mc Reg Set Response(h Reg, "1"); } else {
```
mc Reg Set Response(h Reg, "0"); }
```
}
```
}


<!-- Page 88 -->

break;
default:
;
```
}
```
return(MERROR_NOERROR); }


<!-- Page 89 -->

int mc Reg Get Handle(
```
MINST ANCE m Inst, const char *path, HMCREG *h Reg);
h Reg, rc = mc.mc Reg Get Handle(
number m Inst, string path)
<font color="green">// Get the register handle.</font> MINST ANCE m Inst
= 0; HMCREG h Reg;
int rc;
double value;
if (<font color="blue">mc Reg Get Handle(m Inst, "core/global/V ersion",
```
&h Reg)</font> == MERROR_NOERROR) {
```
rc = mc Reg Get V alue(h Reg, &value); }


<!-- Page 90 -->

int mc Reg Get Info(
HMCREG h Reg, char *name Buf, size_t name Buflen, char *desc Buf,
size_t desc Buflen, int *type, HMCDEV *h Dev);
name Buf, desc Buf, type, h Dev , rc = mc.mc Reg Get Info(
number h Reg)
HMCREG h Reg = 0; char name[8 0];
char desc[8 0];
int type;
HMCDEV h Dev;

while (mc Signal Get Next Handle(h Dev , h Reg, &h Reg) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
<font color="green">// Get the info on the register .</font>
mc Reg Get Info(h Reg, name, sizeof(name), desc, sizeof(desc), &type,
```
&h Dev)); } else {
```
break; }
```
}


<!-- Page 91 -->

int mc Reg Get Info Struct(
HMCREG h Reg, reginfo_t *reginf);
reginf, rc = mc.mc Reg Get Info Struct(
number h Reg)
```
struct reginfo {
char reg Name[8 0]; char reg Desc[8 0]; int reg T ype; HMCDEV reg Dev;
```
void *reg User Data; int reg Input; };
```
typedef struct reginfo reginfo_t;
HMCREG h Reg = 0;
reginfo_t reginf;

while (mc Signal Get Next Handle(h Dev , h Reg, &h Reg) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
<font color="green">// Get the info on the register .</font>
```
mc Reg Get Info Struct(h Reg, ®inf); } else {
```
break; }
```
}


<!-- Page 92 -->

int mc Reg Get Next Handle(
HMCDEV h Dev , HMCREG start Reg, HMCREG *h Reg);
h Reg, rc = mc.mc Reg Get Next Handle(
number h Dev , number start Reg)
HMCSIG h Reg = 0;
HMCDEV h Dev;
mc Device Get Handle(0, 0,&h Dev); while (<font
color="blue">mc Register Get Next Handle(h Dev , h Reg, &h Reg)</font> ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
```
<font color="green">// do something with h Reg.</font> } else {
```
break; }
```
}


<!-- Page 93 -->

int mc Reg Get User Data(
HMCREG h Reg, void **data);
N/A
```
struct my Data Struct {
int my Int; char my String[8 0]; ...
```
};

HMCREG h Reg;
int m Inst=0;
my Data Struct *data = NULL; void *data Ptr; <font color="green">// Get the
handle to holding register 1 on SIM 0.</font> if (mc Reg Get Handle(m Inst,
```
"SIM 0/Holding Reg 1", &h Reg) == MERROR_NOERROR) {
```
mc Reg Get User Data(h Reg, &data Ptr); data = (my Data Struct *) data Ptr; }


<!-- Page 94 -->

int mc Reg Get V alue(
HMCREG h Reg, double *value);
value, rc = mc Reg Get V alue(
number h Reg)
<font color="green">// Get the register value.</font> MINST ANCE m Inst
= 0; HMCREG h Reg; int rc;
double value; if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg)
```
== MERROR_NOERROR) {
```
rc = mc Reg Get V alue(h Reg, &value); }


<!-- Page 95 -->

int mc Reg Get V alue Long(
HMCREG h Reg, double *value);
value, rc = mc Reg Get V alue Long(
number h Reg)
<font color="green">// Get the register value.</font> MINST ANCE m Inst
= 0; HMCREG h Reg; int rc;
long value; if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg) ==
```
MERROR_NOERROR) {
```
rc = mc Reg Get V alue Long(h Reg, &value); }


<!-- Page 96 -->

int mc Reg Get V alue String(
HMCREG h Reg, char *buf, size_t buf Size);
buf, rc = mc Reg Get V alue String(
number h Reg)
<font color="green">// Get the register value.</font> MINST ANCE m Inst
= 0; HMCREG h Reg;
int rc;
char value[8 0]; if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg)
```
== MERROR_NOERROR) {
```
rc = mc Reg Get V alue String(h Reg, &value, sizeof(value)); }


<!-- Page 97 -->

int mc Reg Get V alue String Clear(
HMCREG h Reg, char *buf, size_t buf Size);
buf, rc = mc Reg Get V alue String(
number h Reg)
<font color="green">// Get the register value and clear it.</font>
MINST ANCE m Inst = 0; HMCREG h Reg;
int rc;
char value[8 0]; if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg)
```
== MERROR_NOERROR) {
```
rc = mc Reg Get V alue String Clear(h Reg, &value, sizeof(value)); }


<!-- Page 98 -->

mc Reg Register
C/C++ Syntax:
int mc Reg Register(
HMCDEV h Dev,
```
const char *reg Name,
```
const char *reg Desc,
int reg Type,
HMCREG *h Reg);

LUA Syntax:
N/A

Description: Adds a register to the core.

Parameters:
Parameter Description
h Dev The handle of the register's parent device.
reg Name A string buf fer specifying the name of the
register .
reg Desc A string buf fer specifying the description
of the register .
reg Type REG_TYPE_NONE,
REG_TYPE_INPUT ,
REG_TYPE_OUTPUT ,
REG_TYPE_HOLDING,
REG_TYPE_COMMAND,
REG_TYPE_ENCODER.
h Reg The address of a HMCREG that receives
the register handle.


<!-- Page 99 -->

Returns:
Return Code Description
MERROR_NOERROR No Error .
MERROR_DEVICE_NOT_FOUNDThe h Dev
parameter was 0
or invlaid.
MERROR_INV ALID_ARGreg Name ,
reg Desc , or h Reg
is NULL.
Notes:
The h Dev parameter MUST be a valid device handle. Otherwise, the
```
function will crash.
Registers can contain data of any type, even string data. The maximum
string length is 4 0 9 6 bytes for registers other than
REG_TYPE_COMMAND type registers and 1 0 2 4 bytes for the
REG_TYPE_COMMAND type registers.
REG_TYPE_NONE specifies a register that is not typed. This kind of
register is basically just a data container that will not notify any process if
the data it stores changes.
REG_TYPE_INPUT specifies a register that can be mapped to a Mach
input signal. Mach and any GUI front end is notified if the data in this type
of register is changed with a MSG_REG_CHANGED message. This type
of register usually contains boolean data.
REG_TYPE_OUTPUT specifies a register that can be mapped to a Mach
output signal. The plugin that owns this register is notified with a
MSG_REG_CHANGED synchronous message. All other plugins and the
GUI are notified asynchronously with MSG_REG_CHANGED .
REG_TYPE_HOLDING specifies a general purpose register that cannot
be mapped to either an input or output signal. The plugin that owns this


<!-- Page 100 -->

register is notified with a MSG_REG_CHANGED synchronous message.
All other plugins and the GUI are notified asynchronously with
MSG_REG_CHANGED . This type of register usually contains boolean
data.
REG_TYPE_COMMAND specifies a special purpose register that can be
used to implement a simple command/response communication mechanism.
Only the plugin that owns the register is notified with a
MSG_REG_COMMAND synchronous message. It works with
mc Reg Send Command
on the client side of the communication and
mc Reg Get Command
and
mc Reg Set Response
on the plguin side.
REG_TYPE_ENCODER specifies a register that can be mapped to a
MPG or used to display the encoder counts in the GUI. Only Mach and the
GUI are notified with a MSG_REG_CHANGED synchronous message.

Usage:
HMCREG m_h Reg;
HMCDEV m_h Dev; // Contains the device handle from the device
registration.
int rc = mc Reg Register(m_h Dev, "Holding Reg 1", "Holding Reg 1",
REG_TYPE_HOLDING, &h Reg) ;


<!-- Page 101 -->

int mc Reg Send Command(
```
HMCREG h Reg, const char *command, char *response, size_t
response Len);
response, rc = mc.mc Reg Send Command(
h Reg, command)
<font color="green">// Send a command via a register .</font>
MINST ANCE m Inst = 0;
if (mc Reg Get Handle(m Inst, "Sim 0/Sim Command", &h Reg) ==
```
MERROR_NOERROR) {
char response[1 0 2 4]; rc = <font
color="blue">mc Reg Send Command(h Reg, "THC ON", response,
```
sizeof(response))</font>; if (rc == MERROR_NOERROR) {
```
<font color="green">// check response.</font> }
```
}


<!-- Page 102 -->

int mc Reg Set Desc(
```
HMCREG h Reg, const char *desc);
rc = mc.mc Reg Set Desc(
number h Reg, string desc)
<font color="green">// Set/change the description of the register .</font>
MINST ANCE m Inst = 0; if (mc Reg Get Handle(m Inst,
```
"core/global/V ersion", &h Reg) == MERROR_NOERROR) {
```
rc = <font color="blue">mc Reg Set Desc(h Reg, "Core V ersion")</font>; }


<!-- Page 103 -->

int mc Reg Set Name(
```
HMCREG h Reg, const char *name);
rc = mc.mc Reg Set Name(
number h Reg, string name)
<font color="green">// Set/change the name of the register .</font>
MINST ANCE m Inst = 0; if (mc Reg Get Handle(m Inst,
```
"core/global/V ersion", &h Reg) == MERROR_NOERROR) {
rc = <font color="blue">mc Reg Set Name(h Reg, "V ersion 2")</font>;
<font color="green">// The register path is now "core/global/V ersion 2"
```
</font> }


<!-- Page 104 -->

int mc Reg Set Response(
HMCREG h Reg,
char *response);
N/A
<font color="green">// Set the response to a register command.</font> int
```
sim Control::Process Msg(long msg, long param 1, long param 2) {
HMCREG h Reg = (HMCREG)param 1; long Reg V al;
```
switch (msg) {
case MSG_REG_COMMAND: mc Reg Get V alue Long(h Reg, &Reg V al);
```
if (h Reg = m_Reg Command) { <font color="green">// Is this our command
register?</font> char command[1 0 2 4]; mc Reg Get Command(h Reg,
command, sizeof(command)); wx String cmd(command);
```
cmd.Make Upper(); if (cmd == wx T("THC ON")) {
```
m_thc = true; mc Reg Set Response(h Reg, "OK"); } else if (cmd ==
```
wx T("THC OFF")) {
m_thc = false; mc Motion Sync(m_cid); mc Reg Set Response(h Reg, "OK");
```
} else if (cmd == wx T("THC ST ATUS")) {
```
if (m_thc) {
```
mc Reg Set Response(h Reg, "1"); } else {
```
mc Reg Set Response(h Reg, "0"); }
```
}
```
}
break;


<!-- Page 105 -->

default:
;
```
}
```
return(MERROR_NOERROR); }


<!-- Page 106 -->

int mc Reg Set T ype(
HMCREG h Reg, int reg T ype);
rc = mc.mc Reg Set T ype(
number h Reg, number reg T ype)
<font color="green">// Set the register type.</font> MINST ANCE m Inst =
0; if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg) ==
```
MERROR_NOERROR) {
rc = <font color="blue">mc Reg Set T ype(h Reg, REG_TYPE_HOLDING)
```
</font>; }


<!-- Page 107 -->

mc Reg Set User Data(
HMCREG h Reg, void *data);
## MSG_REG_CHANGED

HMCREG h Reg;
int m Inst=0;
Register Struct Reg Struct; //User data is set to where the data struct is saved.
<font color="green">// Get the handle to holding register 1 on SIM 0.
</font> mc Reg Get Handle(m Inst, "SIM 0/Holding Reg 1", &h Reg);
mc Reg Set User Data(h Reg, (void *)&Reg Struct);


<!-- Page 108 -->

int mc Reg Set V alue(
HMCREG h Reg, double value);
rc = mc.mc Reg Set V alue(
number h Reg, number value)
<font color="green">// Set the register value.</font> MINST ANCE m Inst =
0; if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg) ==
```
MERROR_NOERROR) {
```
rc = <font color="blue">mc Reg Set V alue(h Reg, 4.0)</font>; }


<!-- Page 109 -->

int mc Reg Set V alue Long(
HMCREG h Reg, double value);
rc = mc.mc Reg Set V alue Long(
number h Reg, number value)
<font color="green">// Set the register value.</font> MINST ANCE m Inst =
0;
if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg) ==
```
MERROR_NOERROR) {
```
rc = <font color="blue">mc Reg Set V alue Long(h Reg, 4)</font>; }


<!-- Page 110 -->

int mc Reg Set V alue String(
```
HMCREG h Reg, const char *value);
rc = mc.mc Reg Set V alue String(
number h Reg, string value)
<font color="green">// Set the register value.</font> MINST ANCE m Inst =
0;
if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg) ==
```
MERROR_NOERROR) {
```
rc = <font color="blue">mc Reg Set V alue String(h Reg, "4.0")</font>; }


<!-- Page 111 -->

int mc Reg Unregister(
HMCDEV h Dev , HMCREG h Reg);
N/A
MINST ANCE m Inst = 0; HMCREG h Reg char *path = "Sim 0/Register 1";
mc Reg Get Handle(m Inst, path, &h Reg); <font
color="blue">mc Reg Unregister(m_h Dev , h Reg);</font>


<!-- Page 112 -->

Mach Analog Objects
Mach analog objects form a layer that is superimposed over mapped
registers. It is desinged to allow for defining the register in terms of
voltages instead of a raw numeric value


<!-- Page 113 -->

Motors

mc Motor Get Axis
mc Motor Get Counts Per Unit
mc Motor Get Info Struct
mc Motor Get Max Accel
mc Motor Get Max V el
mc Motor Get Pos
mc Motor Get V el
mc Motor Is Homed
mc Motor Is Still
mc Motor Register
mc Motor Set Home Pos
mc Motor Set Info Struct
mc Motor Set Max Accel
mc Motor Set Max V el
mc Motor Unregister


<!-- Page 114 -->

int mc Motor Get Axis(
MINST ANCE m Inst, int motor Id, int *axis Id)
axis Id, rc = mc.mc Motor Get Axis(
number m Inst, number motor Id)
<font color="green">// Get the parent axis for motor 0.</font>
MINST ANCE m Inst = 0; int axis Id = -1;
int rc = mc Motor Get Axis(m Inst, 0, &axis Id);


<!-- Page 115 -->

int mc Motor Get Counts Per Unit(
MINST ANCE m Inst, int motor Id, double *counts)
counts, rc = mc.mc Motor Get Counts Per Unit(
number m Inst, number motor Id)
<font color="green">// Get the counts per unit for motor 0.</font>
MINST ANCE m Inst = 0;
double counts = 0.0;
int rc = mc Motor Get Counts Per Unit(m Inst, 0, &counts);


<!-- Page 116 -->

mc Motor Get Info Struct(
MINST ANCE m Inst, int motor Id,
motorinfo_t *minf);
N/A
```
struct motorinfo {
double Counts Per Unit; // Number of encoder counts or steps per unit.
double Max V elocity; // Max velocity of the axis.
double Max Acceleration; // Max rate to accelerate.
BOOL Reverse; // Is the axis reversed?
double Backlash Amount; // The amount of backlash in counts.
double Current V elocity; // The speed the axis is moving, This could be
reported by the motion deivce.
int Current Position; // The Current Position (From the motion device).
BOOL Homed; // T rue if the axis has been homed.
long Soft Max Limit; // Count for the max travel.
long Soft Min Limit; // Count for the min travel.
BOOL Can Home; // Can this motor home?
BOOL Enabled; // Is this motor enabled?
long Enable Delay; // ms to delay the enable signal for this motor .
int Axis Id; // -1 if no axis has mapped this motor .


<!-- Page 117 -->

```
};
```
typedef struct motorinfo motorinfo_t;
MINST ANCE m Inst = 0;
int m = 2;
motorinfo_t minf;
mc Motor Get Info Struct(m Inst, m, &minf); <font color="green">// Get data
for motor 2.</font>


<!-- Page 118 -->

int mc Motor Get Max Accel(
MINST ANCE m Inst, int motor Id, double *max Accel);
max Accel, rc = mc.mc Motor Get Max Accel(
number m Inst, number motor Id)
<font color="green">// Get the max accel for motor 0.</font>
MINST ANCE m Inst = 0;
double max Accel = 0.0;
int rc = mc Motor Get Max Accel(m Inst, 0, &max Accel);


<!-- Page 119 -->

int mc Motor Get Max V el(
MINST ANCE m Inst, int motor Id, double *max V el)
max V el, rc = mc.mc Motor Get Max V el(
number m Inst, number motor Id)
<font color="green">// Get the max vel for motor 0.</font> MINST ANCE
m Inst = 0;
double max V el = 0.0;
int rc = mc Motor Get Max V el(m Inst, 0, &max V el);


<!-- Page 120 -->

int mc Motor Get Pos(
MINST ANCE m Inst, int motor Id, double *val);
val, rc = mc.mc Motor Get Pos(
number m Inst, number motor Id)
MINST ANCE m Inst = 0; double Motor 1 Pos = 0; <font color="green">//
Get the position of the Motor 1.</font> mc Motor Get Pos(m Inst, 1,
&Motor 1 Pos);


<!-- Page 121 -->

int mc Motor Get V el(
MINST ANCE m Inst, int motor , double *velocity);
velocity , rc = mc.mc Motor Get V el(
number m Inst, number motor)
MINST ANCE m Inst = 0; int m = MOT OR 2;
double Current V el = 0; mc Motor Set V el(m Inst, m, &Current V el); <font
color="green">// Get the current speed of motor 2.</font>


<!-- Page 122 -->

int mc Motor Is Homed(
MINST ANCE m Inst, int motor Id, BOOL *homed);
homed, rc = mc.mc Motor Is Homed(
number m Inst, number motor Id)
MINST ANCE m Inst = 0; int m = MOT OR 2;
int Homed = 0;
mc Motor Is Homed(m Inst, m, &Homed); <font color="green">// Get the
homed state of motor 2.</font>


<!-- Page 123 -->

int mc Motor Is Still(
MINST ANCE m Inst, int motor Id, BOOL *still);
still, rc = mc.mc Motor Is Still(
number m Inst, number motor Id)
MINST ANCE m Inst = 0; int m = MOT OR 0;
int still = 0;
mc Motor Set Still(m Inst, m, &still); <font color="green">// Get the state if
MOT OR 0 is still</font>


<!-- Page 124 -->

mc Motor Register(
MINST ANCE m Inst, int motor Id);
N/A
```
MINST ANCE m Inst = 0; for (int m = MOT OR 0; m < MOT OR 4; m++) {
mc Motor Register(m Inst, m);<font color="green">// Register motor 0 -
```
motor 2 in the core.</font> }


<!-- Page 125 -->

int mc Motor Set Counts Per Unit(
MINST ANCE m Inst, int motor Id, double counts);
rc = mc.mc Motor Set Counts Per Unit(
number m Inst, number motor Id, number counts)
<font color="green">// Set the counts for motor 0.</font> MINST ANCE
m Inst = 0;
int rc = mc Motor Set Counts Per Unit(m Inst, 0, 1 0 2 4);


<!-- Page 126 -->

int mc Motor Set Home Pos(
MINST ANCE m Inst, int motor Id, int count);
rc = mc.mc Motor Set Home Pos(
number m Inst, number motor Id, number count)
MINST ANCE m Inst = 0;
int m = MOT OR 2;
int count = 1 2 0 0;
mc Motor Set Home Pos(m Inst, m, count); <font color="green">// Set the
Home position of motor 2.</font>


<!-- Page 127 -->

int mc Motor Set Info Struct(
MINST ANCE m Inst, int moto Id,
motorinfo_t *minf);
N/A
```
struct motorinfo {
double Counts Per Unit; // Number of encoder counts or steps per unit.
double Max V elocity; // Max velocity of the axis.
double Max Acceleration; // Max rate to accelerate.
BOOL Reverse; // Is the axis reversed?
double Backlash Amount; // The amount of backlash in counts.
double Current V elocity; // The speed the axis is moving, This could be
reported by the motion deivce.
int Current Position; // The Current Position (From the motion device).
BOOL Homed; // T rue if the axis has been homed.
long Soft Max Limit; // Count for the max travel.
long Soft Min Limit; // Count for the min travel.
BOOL Can Home; // Can this motor home?
BOOL Enabled; // Is this motor enabled?
long Enable Delay; // ms to delay the enable signal for this motor .
```
};


<!-- Page 128 -->

```
typedef struct motorinfo motorinfo_t;
MINST ANCE m Inst = 0;
int m = MOT OR 2;
motorinfo_t minf;
mc Motor Get Info Struct(m Inst, m, &minf); <font color="green">// Get data
for motor 2.</font> minf.Counts Per Unit /= 2;<font color="green">//Divid
motor counts per unit by 2.</font> mc Motor Set Info Struct(m Inst, m,
&minf); <font color="green">// Set data for motor 2.</font>


<!-- Page 129 -->

int mc Motor Set Max Accel(
MINST ANCE m Inst, int motor Id, double max Accel);
rc = mc.mc Motor Set Max Accel(
number m Inst, number motor Id, number max Accel)
<font color="green">// Set a new accel value for motor 0.</font>
MINST ANCE m Inst = 0;
int mc Motor Set Max Accel(m Inst, 0, 7 5);


<!-- Page 130 -->

int mc Motor Set Max V el(
MINST ANCE m Inst, int motor Id, double max V el);
rc = mc.mc Motor Set Max V el(
number m Inst, number motor Id, number max V el)
<font color="green">// Set the maximum velocity for motor 0.</font>
MINST ANCE m Inst = 0;
int rc = mc Motor Set Max V el(m Inst, 0, 5 0 0);


<!-- Page 131 -->

int mc Motor Unregister(
MINST ANCE m Inst, int motor Id);
N/A
MINST ANCE m Inst = 0; int m = MOT OR 2; mc Motor Unregister(m Inst,
m);<font color="green">// Unregister motor 2 from the Core.</font>


<!-- Page 132 -->

MINST ANCE m Inst = 0;
int rc = mc Motor Map Set Definition(m Inst, 0, <font color="green">// Motor
ID.</font> 4 8 0 0 0 0, <font color="green">// Length or screw in counts.
</font> 4 8); <font color="green">// Number of measured points.</font>
rc = mc Motor Map Set Point(m Inst,
0, <font color="green">// Our first measured point.</font> 4); <font
color="green">// The error , in counts.</font>
Repeat the same procedure for every point ending at point 2 3. All points
will need to be measured.
Measuring at random intervals is not supported. The measuring points are
evenly spread across the length of the srew . The points in between the
measuring points are interpolated to spread the error across the measurment
distance. There is no limit to the number of points a map can contain and
increasing that number will not slow the system down. About the only
impact the number of measuring points will have is in the measurement
process itself. More measuring points will of course yield finer resoultion
but the user may reach a point of dimisihing returns.

mc Motor Map Get Definition
mc Motor Map Get Length
mc Motor Map Get Point
mc Motor Map Get Point Count
mc Motor Map Get Start
mc Motor Map Set Definition
mc Motor Map Set Length
mc Motor Map Set Point
mc Motor Map Set Point Count
mc Motor Map Set Start


<!-- Page 133 -->

int mc Motor Map Get Definition(
MINST ANCE m Inst, int motor Id, long *length Counts, long *num Points);
length Counts, num Points, rc = mc.mc Motor Map Get Definition(
number m Inst, number motor Id)
<font color="green">// </font> MINST ANCE m Inst = 0;
long length Counts;
long num Points;
int rc = mc Motor Map Get Definition(m Inst, 0, &length Counts,
&num Points);


<!-- Page 134 -->

int mc Motor Map Get Length(
MINST ANCE m Inst, int motor Id, int *length);
length, rc = mc Motor Map Get Length(
number m Inst, number motor Id)
<font color="green">// Get the screw length for motor zero.</font>
MINST ANCE m Inst = 0;
int length;
int rc = mc Motor Map Get Length(m Inst, 0, &length);


<!-- Page 135 -->

int mc Motor Map Get Point(
MINST ANCE m Inst, int motor Id, int point, int *error);
error , rc = mc.mc Motor Map Get Point(
numbser m Inst, numbser motor Id, numbser point)
<font color="green">// Get the screw map error for motor 0, measurement
point 1 0.</font> MINST ANCE m Inst = 0;
int screw Err;
int rc = mc Motor Map Get Point(m Inst, 0, 1 0, &screw Err);


<!-- Page 136 -->

int mc Motor Map Get Point Count(
MINST ANCE m Inst, int motor Id, int *points);
points, rc = mc.mc Motor Map Get Point Count(
number m Inst, number motor Id)
<font color="green">// Get the number of measurement points.</font>
MINST ANCE m Inst = 0;
int points;
int rc = mc Motor Map Get Point Count(m Inst, 0, &points);


<!-- Page 137 -->

int mc Motor Map Get Start(
MINST ANCE m Inst, int motor Id, int *start Point);
start Point, rc = mc.mc Motor Map Get Start(
number m Inst, number motor Id)
<font color="green">// Get the starting point for the motor 0 screw map.
</font> MINST ANCE m Inst = 0;
int start Point;
int rc = mc Motor Map Get Start(m Inst, 0, &start Point);


<!-- Page 138 -->

int mc Motor Map Set Definition(
MINST ANCE m Inst, int motor Id, long length Counts, long num Points);
rc = mc.mc Motor Map Set Definition(
number m Inst, number motor Id, number length Counts, number
num Points)
<font color="green">// Set the screw map definition for motor 0.</font>
MINST ANCE m Inst = 0;
int rc = mc Motor Map Set Definition(m Inst, 0, 2 0 0 0 0, 2 0);


<!-- Page 139 -->

int mc Motor Map Set Length(
MINST ANCE m Inst, int motor Id, int length);
rc = mc.mc Motor Map Set Length(
number m Inst, number motor Id, number length);
<font color="green">// Set the screw length for the motor 0 screw map.
</font> MINST ANCE m Inst = 0;
int rc = mc Motor Map Set Length(m Inst, 0, 2 0 0 0 0);


<!-- Page 140 -->

int mc Motor Map Set Point(
MINST ANCE m Inst, int motor Id, int point, int error);
rc = mc.mc Motor Map Set Point(
number m Inst, number motor Id, number point, number error);
<font color="green">// Set the error in motor 0 screw map.</font>
MINST ANCE m Inst = 0;
int rc = mc Motor Map Set Point(m Inst, 0, 5, 1 2);


<!-- Page 141 -->

int mc Motor Map Set Point Count(
MINST ANCE m Inst, int motor Id, int points);
rc = mc.mc Motor Map Set Point Count(
number m Inst, number motor Id, number points);
<font color="green">// Set the number of measured points in the screw map
for motor 0.</font> MINST ANCE m Inst = 0;
int rc = mc Motor Map Set Point Count(m Inst, 0, 2 0);


<!-- Page 142 -->

int mc Motor Map Set Start(
MINST ANCE m Inst, int motor Id, int start);
rc = mc.mc Motor Map Set Start(
number m Inst, number motor Id, number start)
<font color="green">// Set the starting point number for the motor 0 screw
map. (usually 0)</font> MINST ANCE m Inst = 0;
int rc = mc Motor Map Set Start(m Inst, 0, 0);


<!-- Page 143 -->

Axes

mc Axis Deref
mc Axis Deref All
mc Axis Enable
mc Axis Get Home Dir
mc Axis Get Home In Place
mc Axis Get Home Of fset
mc Axis Get Home Order
mc Axis Get Home Speed
mc Axis Get Info Struct
mc Axis Get Machine Pos
mc Axis Get Motor Id
mc Axis Get Override Axis
mc Axis Get Pos
mc Axis Get Probe Pos
mc Axis Get Probe Pos All
mc Axis Get Scale


<!-- Page 144 -->

mc Axis Get Softlimit Enable
mc Axis Get Softlimit Max
mc Axis Get Softlimit Min
mc Axis Get Spindle
mc Axis Get V el
mc Axis Home
mc Axis Home All
mc Axis Home Complete
mc Axis Home Complete W ith Status
mc Axis Is Enabled
mc Axis Is Homed
mc Axis Is Still
mc Axis Map Motor
mc Axis Register
mc Axis Remove Override Axis
mc Axis Remove Override Axis Sync
mc Axis Set Home Dir
mc Axis Set Home In Place
mc Axis Set Home Of fset
mc Axis Set Home Order


<!-- Page 145 -->

mc Axis Set Home Speed
mc Axis Set Info Struct
mc Axis Set Machine Pos
mc Axis Set Override Axis
mc Axis Set Pos
mc Axis Set Softlimit Enable
mc Axis Set Softlimit Max
mc Axis Set Softlimit Min
mc Axis Set Spindle
mc Axis Set V el
mc Axis Unmap Motor
mc Axis Unmap Motors
mc Axis Unregister


<!-- Page 146 -->

int mc Axis Deref(
MINST ANCE m Inst, int axis Id);
rc = mc.mc Axis Deref(
number m Inst, number axis Id)
int m Inst = 0;
<font color="green">// Set AXIS 0 to deref (could have used X_AXIS).
</font> mc Axis Deref(m Inst, AXIS 0);


<!-- Page 147 -->

int mc Axis Deref All(
MINST ANCE m Inst);
rc = mc.mc Axis Deref All(
number m Inst)
int m Inst = 0;
<font color="green">// Set all axis to deref.</font>
mc Axis Deref All(m Inst);


<!-- Page 148 -->

int mc Axis Enable(
MINST ANCE m Inst, int axis Id, BOOL enabled);
rc = mc.mc Axis Enable(
number m Inst, number axis Id, number enabled);
int m Inst = 0;
<font color="green">// Set Y_AXIS to be disabled.</font>
mc Axis Enable(m Inst, Y_AXIS, false);


<!-- Page 149 -->

int mc Axis Get Home Dir(
MINST ANCE m Inst, int axis Id, int *dir);
dir, rc = mc.mc Axis Get Home Dir(
number m Inst, number axis Id)
int m Inst=0;
int dir = 0;
<font color="green">// Get Home of fset of the X axis.</font>
mc Axis Get Home Dir(m Inst, X_AXIS, &dir);


<!-- Page 150 -->

int mc Axis Get Home In Place(
MINST ANCE m Inst, int axis Id, BOOL *home In Place);
home In Place, rc = mc.mc Axis Get Home In Place(
number m Inst, number axis Id)
<font color="green">// Get the Home In Place flag for the X axis.</font>
MINST ANCE m Inst = 0;
BOOL hip = F ALSE;
mc Axis Get Home In Place(m Inst, X_AXIS, &hip);


<!-- Page 151 -->

int mc Axis Get Home Of fset(
MINST ANCE m Inst, int axis Id, double *of fset);
offset, rc = mc.mc Axis Get Home Of fset(
number m Inst, number axis Id)
int m Inst=0;
int of fset = 0;
<font color="green">// Get Home of fset of the X axis.</font>
mc Axis Get Home Order(m Inst, X_AXIS, &of fset);


<!-- Page 152 -->

int mc Axis Get Home Order(
MINST ANCE m Inst, int axis Id, int *order);
order , rc = mc.mc Axis Get Home Order(
number m Inst, number axis Id)
int m Inst=0;
double XAxis Pos = 0;
int order = 0;
<font color="green">// Get Home order of the X axis.</font>
mc Axis Get Home Order(m Inst, X_AXIS, &order);


<!-- Page 153 -->

int mc Axis Get Home Speed(
MINST ANCE m Inst, int axis Id, double *percent);
percent, rc = mc.mc Axis Get Home Speed(
number m Inst, number axis Id)
int m Inst=0;
int rc = 0;
double XAxis Pos = 0; double percent = 0; double max V el = 0
double home V el = 0;
<font color="green">// Get home speed percentage of the X axis.</font>
mc Axis Get Home Speed(m Inst, X_AXIS, &percent); mc Axis Get V el(m Inst,
X_AXIS, &max V el); home V el = max V el * percent;


<!-- Page 154 -->

int mc Axis Get Info Struct(
MINST ANCE m Inst,
int axis Id,
axisinfo_t *ainf);
ainf, rc = mc.mc Axis Get Info Struct(number m Inst, number axis Id)
```
struct axisinfo {
BOOL Out Of Band Axis; // Is this an out of band axis?
BOOL Is Still; // Set high when the axis is not moving BOOL Jogging; //
Used to tell to jog...
BOOL Homing; // Used to tell the state of the home operation.
int Id; // Axis Id
BOOL Is Spindle; // Does this axis control a spindle?
BOOL Enabled; // Is axis enabled?
BOOL Softlimit Enabled; // Softlimits enabled?
double Soft Max Limit; // Count for the max travel.
double Soft Min Limit; // Count for the m.
BOOL V elocity Mode; // Used to make the axis move at a fixed speed
BOOL Buf fer Jog; // Buf fer all jogs?
double Pos; // Position in user units.
double Mpos; // Machine position in user units.
int Home Order; // The order in which to home the axis.


<!-- Page 155 -->

int Home Dir; // The direction the axis homes.
double Home Of fset; // The of fset from the the limits switch.
double Home Speed Percent;// The percentage of the max velocity at
which to home.
BOOL Softlimit Used; // Use Softlimits?
BOOL Home In Place; // Zero the axis in place when Refed?
int Motor Id[MC_MAX_AXIS_MOT ORS]; //child motor ID array .
```
};
```
typedef struct axisinfo axisinfo_t;
int m Inst = 0;
axisinfo_t ainf;
<font color="green">// Get Y_AXIS info structure.</font>
mc Axis Get Info Struct(m Inst, Y_AXIS, &ainf);


<!-- Page 156 -->

int mc Axis Get Machine Pos(
MINST ANCE m Inst, int axis Id, double *val);
val, rc = mc.mc Axis Get Machine Pos(
number m Inst, number axis Id)
int m Inst=0;
double XAxis Machine Pos = 0; int Axis Number = X_AXIS;
mc Axis Get Machine Pos(m Inst, Axis Number , &XAxis Machine Pos); <font
color="green">// Get the position of the X axis in Machine Pos.</font>


<!-- Page 157 -->

int mc Axis Get Motor Id(
MINST ANCE m Inst, int axis, int child Id, int *motor Id);
motor Id, rc = mc.mc Axis Get Motor Id(
number m Inst, number axis, number child Id)
int m Inst=0;
```
int motor Ids[]={-1,-1,-1,-1,-1}
int id;
<font color="green">// Get all the motor ID's for the X axis up to 5 motors.
```
</font> for(int i = 0; i < 5; i++){
if (mc Axis Get Motor Id(m Inst, X_AXIS, i, &id) ==

```
MERROR_NOERROR No Error .) {
```
motor Ids[i] = id; }
```
}


<!-- Page 158 -->

int mc Axis Get Override Axis(
MINST ANCE m Inst, int axis, int *axis 1, int *axis 2, int *axis 3, int
*axis 4);
axis 1, axis 2, axis 3, axis 4, rc = mc.mc Axis Get Override Axis(
number m Inst, number axis)
int m Inst = 0;
int ora[4];
<font color="green">// Get the override axis for the Z axis.</font>
mc Axis Get Override Axis(m Inst, ZAXIS, &ora[0], &ora[1], &ora[2],
&ora[3]);


<!-- Page 159 -->

int mc Axis Get Pos(
MINST ANCE m Inst, int axis Id, double *val);
val, rc = mc.mc Axis Get Pos(
number m Inst, number axis Id)
int m Inst=0;
double XAxis Pos = 0;
int Axis Number = X_AXIS; <font color="green">// Get the position of the
X axis.</font> mc Axis Get Pos(m Inst, Axis Number , &XAxis Pos);


<!-- Page 160 -->

int mc Axis Get Probe Pos(
MINST ANCE m Inst, int axis Id, BOOL machine Pos, double *val);
val, rc = mc.mc Axis Get Probe Pos(
number m Inst, number axis Id, number machine Pos)
<font color="green">// Get the last probe strike position for the X
axis</font> MINST ANCE m Inst = 0;
double x Probe Pos = 0;
mc Axis Get Probe Pos(m Inst, X_AXIS, F ALSE, &x Prob Pos);


<!-- Page 161 -->

int mc Axis Get Probe Pos All(
MINST ANCE m Inst, BOOL machine Pos, double *x, double *y , double
*z, double *a, double *b, double *c);
x, y, z, a, b, c, rc = mc.mc Axis Get Probe Pos All(
number m Inst, number machine Pos)
<font color="green">// Get the last probe strike position for the X, Y , and Z
axes.</font> MINST ANCE m Inst = 0;
double x, y , z;
int rc = mc Axis Get Probe Pos All(m Inst, F ALSE, &x, &y , &z, NULL,
```
NULL, NULL); if (rc == MERROR_NOERROR) {
// Process probe positions...
```
}


<!-- Page 162 -->

int mc Axis Get Scale(
MINST ANCE m Inst, int axis Id, double *scale V al);
scale V al, rc = mc.mc Axis Get Probe Pos(
number m Inst, number axis Id)
<font color="green">// Get the scale value for the X axis</font>
MINST ANCE m Inst = 0; double scale = 0;
mc Axis Get Scale(m Inst, X_AXIS, &scale);


<!-- Page 163 -->

int mc Axis Get Softlimit Enable(
MINST ANCE m Inst, int axis Id, int *enable);
enable, rc = mc.mc Axis Get Softlimit Enable(
number m Inst, number axis Id)
<font color="green">// Get master soft limit enable state for axis 0.</font>
int m Inst = 0;
int enable = 0;
mc Axis Get Softlimit Enable(m Inst, 0, &enable);


<!-- Page 164 -->

int mc Axis Set Softlimit Max(
MINST ANCE m Inst, int axis Id, double max);
rc = mc.mc Axis Set Softlimit Max(
number m Inst, number axis Id, number max);
int m Inst=0;
int axis = Y_AXIS;
double max = 2 0;
mc Axis Get Softlimit Max( m Inst, axis, max);<font color="green">// Set the
max distance of the softlimit for the Y axis to 2 0 units.</font>


<!-- Page 165 -->

int mc Axis Set Softlimit Min(
MINST ANCE m Inst, int axis Id, double min);
rc = mc.mc Axis Set Softlimit Min(
number m Inst, number axis Id, number min);
int m Inst=0;
int axis = Y_AXIS;
double min = 2 0;
mc Axis Get Softlimit Min( m Inst, axis, min);<font color="green">// Set the
min distance of the softlimit for the Y axis to 2 0 units.</font>


<!-- Page 166 -->

int mc Axis Get Spindle(
MINST ANCE m Inst, int axis Id, bool *spindle);
spindle, rc = mc Axis Get Spindle(
number m Inst, number axis Id)
<font color="green">// Find the spindle axis</font> int m Inst = 0;
int axis Id;
bool is Spindle = false; for (axis Id = MC_MAX_COORD_AXES; axis Id <
```
MC_MAX_AXES; axis Id++) {
```
mc Axis Get Spindle(m Inst, axis Id, &is Spindle); if (is Spindle) {
```
<font color="green">// Spindle found!</font> break; }
```
}


<!-- Page 167 -->

int mc Axis Get V el(
MINST ANCE m Inst, int axis Id, double *velocity);
velocity , rc = mc.mc Axis Get V el(
number m Inst, number axis Id)
int m Inst=0;
int axis = Y_AXIS;
double Current V el = 0; mc Axis Get V el(m Inst, axis, &Current V el); <font
color="green">// Get the current speed of the Y axis.</font>


<!-- Page 168 -->

int mc Axis Home(
MINST ANCE m Inst, int axis Id);
rc = mc.mc Axis Home(
number m Inst, number axis Id)
int m Inst=0;
int Axis Number = X_AXIS; <font color="green">// Set the X axis to home.
</font> mc Axis Set Pos(m Inst, Axis Number);


<!-- Page 169 -->

int mc Axis Home All(
MINST ANCE m Inst);
rc = mc.mc Axis Home All(
number m Inst)
int m Inst=0;
<font color="green">// Home all coordinated axes.</font>
mc Axis Home All(m Inst);


<!-- Page 170 -->

int mc Axis Home Complete(
MINST ANCE m Inst, int axis Id);
rc = mc.mc Axis Home Complete(
number m Inst, number axis Id);
int m Inst=0;
int Axis Number = X_AXIS; <font color="green">// Mark the X axis home
operation as complete.</font> mc Axis Home Complete(m Inst,
Axis Number);


<!-- Page 171 -->

int mc Axis Home Complete W ith Status(
MINST ANCE m Inst, int axis Id BOOL success);
rc = mc.mc Axis Home Complete W ith Status(
number m Inst, number axis Id number success);
int m Inst=0;
int Axis Number = X_AXIS; <font color="green">// Mark the X axis
homing operation as finished and that it completed with success.</font>
mc Axis Home Complete W ith Status(m Inst, Axis Number , TRUE);


<!-- Page 172 -->

int mc Axis Is Enabled(
MINST ANCE m Inst, int axis Id, BOOL *enabled);
enabled, rc = mc.mc Axis Is Enabled(
number m Inst, number axis Id)
<font color="green">// Find all enabled axes.</font> int m Inst = 0;
int axis Id;
BOOL enabled = F ALSE;
```
for (axis Id = 0; axis Id < MC_MAX_AXES; axis Id++) {
enabled = false; mc Axis Is Enabled(m Inst, axis Id, &enabled); if (enabled
```
== TRUE) {
```
<font color="green">// Axis is enabled!</font> }
```
}


<!-- Page 173 -->

int mc Axis Is Homed(
MINST ANCE m Inst, int axis Id, BOOL *homed);
homed, rc= mc.mc Axis Is Homed(
number m Inst, number axis Id)
int m Inst = 0;
BOOL homed = F ALSE; <font color="green">// Get the homed state of Z
axis.</font> mc Axis Is Homed(m Inst, Z_AXIS, &homed); if (rc ==
```
MERROR_NOERROR && homed == TRUE) {
```
<font color="green">// Z is homed.</font> }


<!-- Page 174 -->

int mc Axis Is Homin(
MINST ANCE m Inst, int axis Id, BOOL *homing);
homing, rc= mc.mc Axis Is Homed(
number m Inst, number axis Id)
int m Inst = 0;
BOOL homing = F ALSE; <font color="green">// Get the homing state of Z
axis.</font> mc Axis Is Homing(m Inst, Z_AXIS, &homing); if (rc ==
```
MERROR_NOERROR && homing == TRUE) {
```
<font color="green">// Z is in a home operation.</font> }


<!-- Page 175 -->

int mc Axis Is Still(
MINST ANCE m Inst, int axis Id, BOOL *still);
still, rc = mc.mc Axis Is Still(
number m Inst, number axis Id)
int m Inst=0;
int Axis Number = X_AXIS; int still = 0;
<font color="green">// Get the is moving state of the axis vlue of 1 is
stopped.</font> mc Axis Is Still(m Inst, Axis Number , &still);


<!-- Page 176 -->

int mc Axis Map Motor(
MINST ANCE m Inst, int axis Id, int motor Id);
rc = mc.mc Axis Map Motor(
number m Inst, number axis Id, number motor Id)
int m Inst=0;
int Axis Number = X_AXIS; int Motor Number = MOT OR 5
<font color="green">// Map motor 5 to the X axis.</font>
mc Axis Map Motor(m Inst, Axis Number , Motor Number);


<!-- Page 177 -->

int mc Axis Register(
MINST ANCE m Inst, int axis Id);
rc = mc.mc Axis Register(
number m Inst, number axis Id);
int m Inst=0;
```
for (int a = AXIS 0; < AXIS 4; a++) {
<font color="green">// Register axis 0 - axis 2 to the core.</font> if(
mc Axis Register(m Inst, a) !=

```
MERROR_NOERROR No Error .){
```
return(false); }
```
}


<!-- Page 178 -->

int mc Axis Remove Override Axis(
MINST ANCE m Inst, int axis Id, int axis T o Override Id);
rc = mc.mc Axis Remove Override Axis(
number m Inst, number axis Id, number axis T o Override Id)
int m Inst = 0;
int homed = 0;
<font color="green">// Remove axis 8 from the Z axis.</font>
mc Axis Remove Override Axis( m Inst, AXIS_ 8, ZAXIS );


<!-- Page 179 -->

int mc Axis Remove Override Axis Sync(
MINST ANCE m Inst, int axis Id,
int axis T o Override Id);
rc = mc.mc Axis Remove Override Axis Sync(
number m Inst, number axis Id, number axis T o Override Id)
int m Inst = 0;
int homed = 0;
<font color="green">// Remove axis 8 from the Z axis.</font>
mc Axis Remove Override Axis Sync( m Inst, AXIS_ 8, ZAXIS );


<!-- Page 180 -->

int mc Axis Set Home Dir(
MINST ANCE m Inst, int axis Id, int dir);
rc = mc.mc Axis Set Home Dir(
number m Inst, number axis Id, number dir)
<font color="green">// Set axis 0 homing directio to POS.</font> int m Inst
= 0;
mc Axis Set Home Dir(m Inst, 0, 1);


<!-- Page 181 -->

int mc Axis Set Home In Place(
MINST ANCE m Inst, int axis Id, BOOL home In Place);
rc = mc.mc Axis Get Home In Place(
number m Inst, number axis Id, number home In Place)
<font color="green">// Set the Home In Place flag for the X axis.</font>
MINST ANCE m Inst = 0;
BOOL hip = F ALSE;
mc Axis Get Home In Place(m Inst, X_AXIS, hip);


<!-- Page 182 -->

int mc Axis Set Home Of fset(
MINST ANCE m Inst, int axis Id, double of fset);
rc = mc Axis Set Home Of fset(
number m Inst, number axis Id, number of fset);
<font color="green">// Set the home of fset for axis 0.</font> int m Inst = 0;
mc Axis Set Home Of fset(m Inst, 0, 1.5 <font color="green">/* inches
*/</font>);


<!-- Page 183 -->

int mc Axis Set Home Order(
MINST ANCE m Inst, int axis Id, int order);
rc = mc.mc Axis Set Home Order(
number m Inst, number axis Id, number order)
int m Inst=0;
<font color="green">// Set the order of homming so the Z axis will home
first then the X and Y .</font> mc Axis Set Home Order(m Inst, Z_AXIS , 0);
mc Axis Set Home Order(m Inst, X_AXIS , 1); mc Axis Set Home Order(m Inst,
Y_AXIS , 1);


<!-- Page 184 -->

int mc Axis Set Home Speed(
MINST ANCE m Inst, int axis, double percent);
rc = mc.mc Axis Set Home Speed(
number m Inst, number axis, number percent);
<font color="green">// Set the homing speed for axis 0 as a percentage of
the max velocity .</font> int m Inst = 0;
mc Axis Set Home Speed(m Inst, 0, 2 0.5 <font color="green">/* percent
*/</font>);


<!-- Page 185 -->

int mc Axis Set Info Struct(
MINST ANCE m Inst, int axis ID,
axisinfo_t *ainf);
N/A
```
struct axisinfo {
bool Out Of Band Axis; bool Is Still; // Set high when the axis is not
moving int Jogging; // Used to tell to jog...
int Homing; // Used to tell the state of the home operation.
int Id; // Axis Id bool Is Spindle; // Does this axis control a spindle?
bool Enabled; // Is axis enabled?
bool Softlimit Enabled; // Softlimits enabled?
double Soft Max Limit; // Count for the max travel.
double Soft Min Limit; // Count for the min travel.
bool V elocity Mode; // Used to make the axis move at a fixed speed bool
Buffer Jog; double Pos; // Position in user units.
double Mpos; // Machine position in user units.
int Home Order; // The order in which to home the axis.
```
};
int m Inst = 0;
axisinfo_t ainf;


<!-- Page 186 -->

mc Axis Get Info Struct(m Inst, Y_AXIS, &ainf);<font color="green">// Get
Y_AXIS info structure.</font> ainf.Home Order = 1;<font color="green">//
Set Y_AXIS home order to 1.</font> mc Axis Set Info Struct(m Inst,
Y_AXIS, &ainf);<font color="green">// Set Y_AXIS info structure.</font>


<!-- Page 187 -->

int mc Axis Set Machine Pos(
MINST ANCE m Inst, int axis, double val);
rc = mc.mc Axis Set Machine Pos(
number m Inst, number axis, number val)
<font color="green">// Set axis 0 fisxture of fset.</font> int m Inst = 0;
mc Axis Set Machine Pos(m Inst, 0, 0.0 <font color="green">/* set part zero
*/</font>);


<!-- Page 188 -->

int mc Axis Set Override Axis(
MINST ANCE m Inst, int axis Td, int axis T o Override Id);
rc = mc.mc Axis Set Override Axis(
number m Inst, number axis Id, number axis T o Override Id)
int m Inst = 0;
int homed = 0;
<font color="green">// Set the axis 8 to be the override axis for the Z axis.
</font> mc Axis Set Override Axis(m Inst, AXIS_ 8, ZAXIS);


<!-- Page 189 -->

int mc Axis Set Pos(
MINST ANCE m Inst, int axis Id, double val);
rc = mc.mc Axis Set Pos(
number m Inst, number axis Id, number val);
int m Inst=0;
double XAxis Pos = .5;
int Axis Number = X_AXIS; <font color="green">// Set the position of the
X axis by changing the fixture of fset.</font> mc Axis Set Pos(m Inst,
Axis Number , XAxis Pos);


<!-- Page 190 -->

int mc Axis Set Softlimit Enable(
MINST ANCE m Inst, int axis, int enabel);
rc = mc.mc Axis Set Softlimit Enable(
number m Inst, number axis, number enabel)
<font color="green">// Diable softlimits on axis 0</font> MINST ANCE
m Inst = 0;
mc Axis Set Softlimit Enable(m Inst, 0,0);


<!-- Page 191 -->

int mc Axis Set Softlimit Max(
MINST ANCE m Inst, int axis Id, double max);
rc = mc.mc Axis Set Softlimit Max(
number m Inst, number axis Id, number max);
int m Inst=0;
int axis = Y_AXIS;
double max = 2 0;
mc Axis Get Softlimit Max( m Inst, axis, max);<font color="green">// Set the
max distance of the softlimit for the Y axis to 2 0 units.</font>


<!-- Page 192 -->

int mc Axis Set Softlimit Min(
MINST ANCE m Inst, int axis Id, double min);
rc = mc.mc Axis Set Softlimit Min(
number m Inst, number axis Id, number min);
int m Inst=0;
int axis = Y_AXIS;
double min = 2 0;
mc Axis Get Softlimit Min( m Inst, axis, min);<font color="green">// Set the
min distance of the softlimit for the Y axis to 2 0 units.</font>


<!-- Page 193 -->

int mc Axis Set Spindle(
MINST ANCE m Inst, int axis Id, BOOL spindle);
rc = mc.mc Axis Set Spindle(
number m Inst, number axis Id, number spindle)
<font color="green">// Set axis 6 as a spindle axis.</font> MINST ANCE
m Inst = 0;
mc Axis Set Spindle(m Inst, 6, true);


<!-- Page 194 -->

mc Axis Set V el
C/C++ Syntax:
int mc Axis Set Vel(
MINSTANCE m Inst,
int axis,
double velocity);

Description: Not used at this time.


<!-- Page 195 -->

int mc Axis Unmap Motor(
MINST ANCE m Inst, int axis Id, int motor);
rc = mc.mc Axis Unmap Motor(
number m Inst, number axis Id, number motor)
int m Inst = 0;
<font color="green">// Remove motor 6 from the Y axis.</font>
mc Axis Unmap Motor(m Inst, Y_AXIS, MOT OR 6);


<!-- Page 196 -->

int mc Axis Unmap Motors(
MINST ANCE m Inst, int axis Id);
rc = mc.mc Axis Unmap Motors(
number m Inst, number axis Id)
int m Inst = 0;
<font color="green">// Remove all motors from the Y axis.</font>
mc Axis Unmap Motors(m Inst, Y_AXIS);


<!-- Page 197 -->

int mc Axis Unregister(
MINST ANCE m Inst, int axis Id);
rc = mc.mc Axis Unregister(
number m Inst, number axis Id)
int m Inst=0;
<font color="green">// Remove AXIS 7 from frome the system.</font>
mc Axis Unregister(m Inst, AXIS 7);


<!-- Page 198 -->

Motion

mc Motion Clear Planner
mc Motion Cycle Planner
mc Motion Cycle Planner Ex
mc Motion Get Abs Pos
mc Motion Get Abs Pos Fract
mc Motion Get Backlash Abs
mc Motion Get Backlash Inc
mc Motion Get Inc Pos
mc Motion Get Move ID
mc Motion Get Pos
mc Motion Get Probe Params
mc Motion Get Rigid T ap Params
mc Motion Get Sync Output
mc Motion Get Thread Params
mc Motion Get Threading Rate
mc Motion Get V el
mc Motion Set Cycle T ime
mc Motion Set Move ID
mc Motion Set Pos
mc Motion Set Probe Complete
mc Motion Set Probe Pos
mc Motion Set Still
mc Motion Set Threading Rate
mc Motion Set V el
mc Motion Sync
mc Motion Thread Complete


<!-- Page 199 -->

int mc Motion Clear Planner(
MINST ANCE m Inst);
rc = mc.mc Motion Clear Planner(
number m Inst)
<font color="green">// Clear the planner .</font> MINST ANCE m Inst = 0;
int rc = mc Motion Clear Planner(m Inst);


<!-- Page 200 -->

mc Motion Cycle Planner
C/C++ Syntax:
int mc Motion Cycle Planner(MINSTANCE m Inst);

LUA Syntax:
N/A

Description: Cycle the core planner .

Parameters:
Parameter Description
m Inst The controller instance.

Returns:
Return Code Description
MERROR_NOERROR No Error .
MERROR_INV ALID_INST ANCEThe m Inst
parameter was out
of range.
Notes:
```
This function is depricated in favor of mc Motion Cycle Planner Ex().
Usage:
None.


<!-- Page 201 -->

int mc Motion Cycle Planner Ex(
MINST ANCE m Inst, execution_t *ex Info);
N/A
<font color="green">// Cycle the core planner .</font> MINST ANCE m Inst
= 0; execution_t ex Info; int rc = mc Motion Cycle Planner Ex(m Inst,
&ex Info); <font color="green">// For more information, see the Sim plugin
example.

</font>


<!-- Page 202 -->

int mc Motion Get Abs Pos(
MINST ANCE m Inst, int motor Id, double *val);
N/A
None.


<!-- Page 203 -->

int mc Motion Get Abs Pos Fract(
MINST ANCE m Inst, int motor Id, double *val);
N/A
None.


<!-- Page 204 -->

int mc Motion Get Backlash Abs(
MINST ANCE m Inst, int motor Id, double *pos);
N/A
None.


<!-- Page 205 -->

int mc Motion Get Backlash Inc(
MINST ANCE m Inst, int motor Id, double *pos);
N/A
None.


<!-- Page 206 -->

int mc Motion Get Inc Pos(
MINST ANCE m Inst, int motor Id, double *val);
N/A
None.


<!-- Page 207 -->

int mc Motion Get Move ID(
MINST ANCE m Inst, int motor Id, long *val);
N/A
None.


<!-- Page 208 -->

int mc Motion Get Pos(
MINST ANCE m Inst, int motor Id, double *pos);
pos, rc = mc.mc Motion Get Pos(
number m Inst, number motor Id)
<font color="green">// Get the motor 0 position.</font> MINST ANCE
m Inst = 0;
double pos;
int rc = mc Motion Get Pos(m Inst, 0, &pos);


<!-- Page 209 -->

int mc Motion Get Probe Params(
MINST ANCE m Inst, probe_t *probe Info);
N/A
<font color="green">// Get the probing parameters from the core.</font>
MINST ANCE m Inst = 0; probe_t p Info; int
mc Motion Get Probe Params(m Inst, &p Info);


<!-- Page 210 -->

int mc Motion Get Rigid T ap Params(
MINST ANCE m Inst, tap_t *tap Info);
N/A
<font color="green">// Get the tpping parameters from the core.</font>
MINST ANCE m Inst = 0; tap_t tap Info; int rc =
mc Motion Get Rigid T ap Params(m Inst, &tap Info);


<!-- Page 211 -->

int mc Motion Get Sync Output(
MINST ANCE m Inst, int output Queue, HMCIO *h Io, BOOL *state);
N/A
<font color="green">// Retrieve the coordinated outputs/</font>
MINST ANCE m Inst = 0; execution_t ex;
mc Motion Cycle Planner Ex(m Inst, &ex); if (ex.ex Output Queue !=
```
EX_NONE) {
HMCIO h Io; BOOL state; while (mc Motion Get Sync Output(m_cid,
```
ex.ex Output Queue, &h Io, &state) == MERROR_NOERROR) {
<font color="green">// Pair setting the output along with the moves in
```
(execution_t)ex.</font> }
```
}


<!-- Page 212 -->

int mc Motion Get Thread Params(
MINST ANCE m Inst, thread_t *thread Info);
<font color="green">// </font> MINST ANCE m Inst = 0;
thread_t thread Info;
int mc Motion Get Thread Params(m Inst, &thread Info);


<!-- Page 213 -->

int mc Motion Get Threading Rate(
MINST ANCE m Inst, double *ratio);
N/A
<font color="green">// Get the current threading rate from the core.</font>
MINST ANCE m Inst = 0; double ratio; int rc =
mc Motion Get Threading Rate(m Inst, &ratio);


<!-- Page 214 -->

int mc Motion Get V el(MINST ANCE m Inst, int motor Id, double *velocity);
velocity , rc = mc.mc Motion Get V el(
number m Inst, number motor Id)
<font color="green">// Get the motor velocity for motor 1</font>
MINST ANCE m Inst = 0;
double vel;
int rc = mc Motion Get V el(m Inst, 1, &vel);


<!-- Page 215 -->

int mc Motion Set Cycle T ime(
MINST ANCE m Inst, double secs);
N/A
<font color="green">// Set the cycle time slice.</font> MINST ANCE m Inst
= 0; int mc Motion Set Cycle T ime(m Inst, .0 0 1);


<!-- Page 216 -->

int mc Motion Set Move ID(
MINST ANCE m Inst, int id);
N/A
<font color="green">// Set the currently executing movement ID.</font>
MINST ANCE m Inst = 0; int move Id = 1 0 0 0 1; <font color="green">//
Should be obtained from the motion controller .</font> int
mc Motion Set Move ID(m Inst, move Id);


<!-- Page 217 -->

int mc Motion Set Pos(
MINST ANCE m Inst, int motor Id double val);
N/A
<font color="green">// Set the motor position for motor 1.</font>
MINST ANCE m Inst = 0; motor Counts = 3 2 4 2 5 5; <font color="green">//
Should be retrieved from the motion controller .</font> int
mc Motion Set Pos(m Inst, 1, motor Counts);


<!-- Page 218 -->

int mc Motion Set Probe Complete(
MINST ANCE m Inst);
N/A
<font color="green">// Complete a probe operation.</font> MINST ANCE
m Inst = 0; int rc = mc Motion Set Probe Complete(m Inst);


<!-- Page 219 -->

int mc Motion Set Probe Pos(
MINST ANCE m Inst, int motor Id, double val);
N/A
<font color="green">// Set the probed position for motor 0.</font>
MINST ANCE m Inst = 0; double probed Pos = 2 3 1 4 1 3 4; <font
color="green">// Should be reteived from motion controller latch registers.
</font> int rc = mc Motion Set Probe Pos(m Inst, 0, double val);


<!-- Page 220 -->

int mc Motion Set Still(
MINST ANCE m Inst, int motor Id);
N/A
<font color="green">// Motor stop report example.</font> MINST ANCE
m Inst = 0; execution_t ex;
```
mc Motion Cycle Planner Ex(m_cid, &ex); switch(ex.ex T ype) {
case EX_ST OP_REQ:
// See if we need to report when the motors are still.
```
for (i = 0; i < 8; i++) {
```
if (ex.ex Motors[i].report Stopped == TRUE) {
<font color="green">// Report when this motor has completed all
```
previous moves!</font> }
```
}
break; ...
```
}


<!-- Page 221 -->

int mc Motion Set Threading Rate(
MINST ANCE m Inst, double ratio);
N/A
<font color="green">// Set the threading ratio.</font> MINST ANCE m Inst
= 0; int rc = mc Motion Set Threading Rate(m Inst, 1.2);


<!-- Page 222 -->

int mc Motion Set V el(
MINST ANCE m Inst, int motor Id, double velocity);
N/A
<font color="green">// Report the velocity for motor 0.</font>
MINST ANCE m Inst = 0; double vel = 2 3 4 2 4 2 0;<font color="green">//
Should be obtained from the motion controller .</font> int
mc Motion Set V el(m Inst, 0, vel);


<!-- Page 223 -->

int mc Motion Sync(
MINST ANCE m Inst);
N/A
<font color="green">// Synch core planner positions with the last reported
motor positions.</font> MINST ANCE m Inst = 0; int rc =
mc Motion Sync(m Inst);


<!-- Page 224 -->

int mc Motion Thread Complete(
MINST ANCE m Inst);
N/A
<font color="green">// Report that the threading op is complete.</font>
MINST ANCE m Inst = 0; int rc = mc Motion Thread Complete(m Inst);


<!-- Page 225 -->

Operation

mc Cntl Cycle Start
mc Cntl Cycle Stop
mc Cntl Dry Run T o Line
mc Cntl EStop
mc Cntl Feed Hold
mc Cntl Feed Hold State
mc Cntl Get Block Delete
mc Cntl Get Enable FRO
mc Cntl Get FRO
mc Cntl Get Optional Stop
mc Cntl Get RRO
mc Cntl Get Single Block
mc Cntl Goto Zero
mc Cntl Is In Cycle
mc Cntl Reset
mc Cntl Set Block Delete
mc Cntl Set Enable FRO
mc Cntl Set FRO
mc Cntl Set Optional Stop
mc Cntl Set RRO
mc Cntl Set Reset Codes
mc Cntl Set Single Block
mc Cntl Start Motion Dev
mc Cntl Stop Motion Dev
mc Cntl T ool Change Manual
mc Cntl W ait On Cycle Start


<!-- Page 226 -->

int mc Cntl Cycle Start(
MINST ANCE m Inst);
rc = mc.mc Cntl Cycle Start(
number m Inst)
int m Inst=0;
<font color="green">// Start controller 0's Gcode file.</font>
mc Cntl Cycle Start(m Inst);


<!-- Page 227 -->

int mc Cntl Cycle Stop(
MINST ANCE m Inst);
rc = mc.mc Cntl Cycle Stop(
number m Inst)
int m Inst=0;
<font color="green">// Stop controller 0's Gcode file.</font>
mc Cntl Cycle Stop(m Inst);


<!-- Page 228 -->

int mc Cntl Dry Run T o Line(
MINST ANCE m Inst, int line);
rc = mc.mc Cntl Dry Run T o Line(
number m Inst, number line)
<font color="green">// Dry run to line 3 8</font> MINST ANCE m Inst = 0;
int rc = mc Cntl Dry Run T o Line(m Inst, 3 8);


<!-- Page 229 -->

int mc Cntl EStop(
MINST ANCE m Inst);
rc = mc.mc Cntl EStop(
number m Inst)
<font color="green">// Put the control in the default state when e-stop is
asserted.</font> MINST ANCE m Inst = 0; int rc = mc Cntl EStop(m Inst);


<!-- Page 230 -->

int mc Cntl Feed Hold(
MINST ANCE m Inst);
rc = mc.mc Cntl Feed Hold(
number m Inst)
int m Inst = 0; int rc;
rc = mc Cntl Feed Hold(m Inst); <font color="green">// Pause the motion of
```
controller 0.</font> if (rc == MERROR_NOERROR) {
```
<font color="green">// Feed hold was successful.</font> }


<!-- Page 231 -->

int mc Cntl Feed Hold State(
MINST ANCE m Inst, BOOL *In Feed Hold);
In Feed Hold, rc = mc.mc Cntl Feed Hold State(
number m Inst)
int m Inst = 0; int rc;
BOOL fh State; rc = mc Cntl Feed Hold State(m Inst, &fh State); <font
color="green">// Pause the motion of controller 0.</font> if (rc ==
```
MERROR_NOERROR && fh State == TRUE) {
```
<font color="green">// The control is in Feedhold.</font> }


<!-- Page 232 -->

int mc Cntl Get Block Delete(
MINST ANCE m Inst, int delete Id, BOOL *val);
val, rc = mc.mc Cntl Get Block Delete(
number m Inst, number delete Id)
<font color="green">// Is block delete 0 on?</font> MINST ANCE m Inst =
0;
BOOL val;
int rc = mc Cntl Get Block Delete(m Inst, 0, &val); if (rc ==
```
MERROR_NOERROR) {
```
if (val == TRUE) {
```
<font color="green">// Is block delete 0 is on!</font> } else {
```
<font color="green">// Is block delete 0 is of f!</font> }
```
}


<!-- Page 233 -->

int mc Cntl Get Enable FRO(
MINST ANCE m Inst, BOOL *enable);
eanbled, rc = mc.mc Cntl Get Enable FRO(
number m Inst)
<font color="green">// Get the current FRO status</font> MINST ANCE
m Inst = 0;
BOOL enabled;
int rc = mc Cntl Get Enable FRO(m Inst, &enabled); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> if (enabled == TRUE) {
```
<font color="green">// Feed Rate Override is enabled!</font> } else {
```
<font color="green">// Feed Rate Override is disabled!</font> }
```
}


<!-- Page 234 -->

int mc Cntl Get FRO(
MINST ANCE m Inst, double *percent);
percent, rc = mc.mc Cntl Get FRO(
number m Inst)
<font color="green">// Get the current FRO</font> MINST ANCE m Inst =
0; double fro;
```
int rc = mc Cntl Get FRO(m Inst, &fro); if (rc == MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 235 -->

int mc Cntl Get Optional Stop(
MINST ANCE m Inst, BOOL *stop);
stop, rc = mc.mc Cntl Get Optional Stop(
number m Inst)
<font color="green">// See if optional stop is in ef fect.</font>
MINST ANCE m Inst = 0;
BOOL op Stop = F ALSE;
int rc = mc Cntl Get Optional Stop(m Inst, &op Stop); if (rc ==
```
MERROR_NOERROR) {
```
if (op Stop == TRUE) {
<font color="green">// Optional Stop is in ef fect!
```
} else {
<font color="green">// Optional Stop is not in ef fect!
```
}
```
}

</font></font>


<!-- Page 236 -->

int mc Cntl Get RRO(
MINST ANCE m Inst, double *percent);
percent, rc = mc.mc Cntl Get RRO(
number m Inst)
<font color="green">// Get the current RRO</font> MINST ANCE m Inst =
0; double rro;
```
int rc = mc Cntl Get RRO(m Inst, &rro); if (rc == MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 237 -->

int mc Cntl Get Single Block(
MINST ANCE m Inst, BOOL *sb State);
sb State, rc = mc.mc Cntl Get Single Block(
number m Inst)
<font color="green">// Get the state of single block.</font> int m Inst=0;
BOOL Is On = F ALSE; mc Cntl Get Single Block(m Inst, &Is On);


<!-- Page 238 -->

int mc Cntl Goto Zero(
MINST ANCE m Inst);
rc = mc.mc Cntl Goto Zero(
number m Inst)
int m Inst = 0;
mc Cntl Goto Zero(m Inst); <font color="green">// Move controller instance 0
to x,y ,z,a,b,c zero.</font>


<!-- Page 239 -->

int mc Cntl Is In Cycle(
MINST ANCE m Inst, BOOL *cycle);
cycle, rc = mc.mc Cntl Is In Cycle(
number m Inst)
int m Inst = 0;
BOOL In Cycle = F ALSE; bool Running File = false;
int rc = mc Cntl Is In Cycle(m Inst, &In Cycle); <font color="green">// See if a
G code file is running.</font> if(rc == MERROR_NOERROR && In Cycle
```
== TRUE){
```
Running File = true; }


<!-- Page 240 -->

int mc Cntl Reset(
MINST ANCE m Inst);
rc = mc.mc Cntl Reset(
number m Inst)
MINST ANCE m Inst = 0; mc Cntl Reset(m Inst); <font color="green">//
Reset controller instance 0.</font>


<!-- Page 241 -->

int mc Cntl Set Block Delete(
MINST ANCE m Inst, int delete ID, BOOL enabled);
rc = mc.mc Cntl Set Block Delete(
number m Inst, number delete ID, number enabled)
MINST ANCE m Inst = 0;
<font color="green">// Enable block delete level 0.</font>
mc Cntl Set Block Delete(m Inst, 0, TRUE);


<!-- Page 242 -->

int mc Cntl Set Enable FRO(
MINST ANCE m Inst, BOOL enable);
rc = mc.mc Cntl Set Enable FRO(
number m Inst, number enable);
<font color="green">// Enable feed rate override</font> MINST ANCE
m Inst = 0;
int rc = mc Cntl Set Enable FRO(m Inst, TRUE);


<!-- Page 243 -->

int mc Cntl Set FRO(
MINST ANCE m Inst, double percent);
rc = mc.mc Cntl Set FRO(
number m Inst, number percent);
<font color="green">// Set feed rate override to 1 5 0%</font>
MINST ANCE m Inst = 0; int rc = mc Cntl Set FRO(m Inst, 1 5 0.0);


<!-- Page 244 -->

int mc Cntl Set Optional Stop(
MINST ANCE m Inst, BOOL enable);
rc = mc.mc Cntl Set Optional Stop(
number m Inst number enable)
<font color="green">// Enable optional stop.</font> MINST ANCE m Inst =
0;
int rc = mc Cntl Set Optional Stop(m Inst, TRUE);


<!-- Page 245 -->

int mc Cntl Set RRO(
MINST ANCE m Inst, double percent);
rc = mc.mc Cntl Set RRO(
number m Inst, number percent);
<font color="green">// Set feed rapid override to 5 0%</font>
MINST ANCE m Inst = 0; int rc = mc Cntl Set RRO(m Inst, 5 0.0);


<!-- Page 246 -->

int mc Cntl Set Reset Codes(
```
MINST ANCE m Inst, const char *reset Codes);
rc = mc.mc Cntl Set Reset Codes(
number m Inst, string reset Codes)
<font color="green">// Set the G code used to reset the controller instance
0.</font> MINST ANCE m Inst = 0;
int rc = mc Cntl Set Reset Codes(m Inst, "G 4 0 G 2 0 G 9 0 G 5 2 X 0 Y 0
Z 0\n G 9 2.1 G 6 9");


<!-- Page 247 -->

int mc Cntl Set Single Block(
MINST ANCE m Inst, BOOL enable);
<font color="green">// Enable single block mode.</font> MINST ANCE
m Inst = 0;
mc Cntl Set Single Block(m Inst, TRUE);


<!-- Page 248 -->

int mc Cntl Start Motion Dev(
MINST ANCE m Inst);
rc = mc.mc Cntl Start Motion Dev(
number m Inst)
<font color="green">// Start the selected motion device.</font>
MINST ANCE m Inst = 0;
int rc = mc Cntl Start Motion Dev(m Inst);


<!-- Page 249 -->

int mc Cntl Stop Motion Dev(
MINST ANCE m Inst);
rc = mc.mc Cntl Stop Motion Dev(
number m Inst);
<font color="green">// Stop the selected motion device.</font>
MINST ANCE m Inst = 0;
int rc = mc Cntl Stop Motion Dev(m Inst);


<!-- Page 250 -->

int mc Cntl T ool Change Manual(
MINST ANCE m Inst);
rc = mc.mc Cntl T ool Change Manual(
number m Inst)
<font color="green">-- LUA example</font> local inst =
```
mc.mc Get Instance(); local rc = mc.mc Cntl T ool Change Manual(inst);


<!-- Page 251 -->

int mc Cntl W ait On Cycle Start(
```
MINST ANCE m Inst, const char *msg, int time Out Ms);
rc = mc.mc Cntl W ait On Cycle Start(
number m Inst, string msg, number time Out Ms);
<font color="green">-- LUA example</font> local inst =
```
mc.mc Get Instance();
local rc = mc.mc Cntl W ait On Cycle Start(inst, "Please press Cycle Start.",
1 0 0 0);


<!-- Page 252 -->

## GUI

mc Cntl Cleanup
mc Cntl Init
mc Fixture Load File
mc Fixture Save File
mc Gui Get W indow Handle
mc Gui Set Focus
mc Gui Set W indow Handle
mc Tool Path Create
mc Tool Path Delete
mc Tool Path Generate
mc Tool Path Generate Abort
mc Tool Path Generated Percent
mc Tool Path Get AAxis Position
mc Tool Path Get ARotation Axis
mc Tool Path Get Axis Color
mc Tool Path Get Back Color
mc Tool Path Get Draw Limits
mc Tool Path Get Execution
mc Tool Path Get Follow Mode
mc Tool Path Get Generating
mc Tool Path Get Left Mouse Dn
mc Tool Path Get Left Mouse Up
mc Tool Path Get Path Color
mc Tool Path Is Signal Mouse Clicks
mc Tool Path Set AAxis Position
mc Tool Path Set ARotation Axis
mc Tool Path Set Axis Color
mc Tool Path Set Back Color
mc Tool Path Set Draw Limits
mc Tool Path Set Follow Mode


<!-- Page 253 -->

mc Tool Path Set Path Color
mc Tool Path Set Signal Mouse Clicks
mc Tool Path Set V iew
mc Tool Path Set Zoom
mc Tool Path Update


<!-- Page 254 -->

int mc Cntl Cleanup(MINST ANCE m Inst);
N/A
None.
<font color="green">// Cleanup core instance 0</font> MINST ANCE
m Inst = 0; int rc = mc Cntl Cleanup(m Inst);


<!-- Page 255 -->

MINST ANCE mc Cntl Init(
```
const char *Profile Name, int Controller ID);
N/A
MINST ANCE m Inst; m Inst = mc Cntl Init("Mach 4 Mill", m Inst); if (m Inst
```
>= 0) {
```
<font color="green">// A valid instance has been initialized!</font> }


<!-- Page 256 -->

int mc Fixture Load File(
```
MINST ANCE m Inst, const char *File T o Load);
rc = mc.mc Fixture Load File(
number m Inst, string File T o Load);
<font color="green">// Load a fixture table file.</font> MINST ANCE
m Inst = 0;
int rc = mc Fixture Load File(m Inst, "My Fixture T able.dat");


<!-- Page 257 -->

int mc Fixture Save File(
MINST ANCE m Inst);
rc = mc.mc Fixture Save File(
number m Inst),
<font color="green">// Save the fixture table file.</font> MINST ANCE
m Inst = 0;
int rc = mc Fixture Save File(m Inst);


<!-- Page 258 -->

int mc Gui Get W indow Handle(
MINST ANCE m Inst, void **handle);
N/A
<font color="green">// </font> MINST ANCE m Inst = 0; void *gui Handle;
rc = mc Gui Get W indow Handle(m Inst, &gui Handle);


<!-- Page 259 -->

int mc Gui Set Callback(
MINST ANCE m Inst, void *fp);
N/A
<font color="green">/* In the GUI code */</font> MCP_API <font
color="blue">int</font> MCP_APIENTR Y mc GUIMsg(MINST ANCE
m Inst, <font color="blue">long</font> msg, <font
color="blue">long</font> wparam, <font color="blue">long</font>
```
lparam) {
<font color="green">// Process messages...</font>
```
return(MERROR_NOERROR); }

MINST ANCE m Inst = 0; mc Gui Set Callback(m Inst, &mc GUIMsg);


<!-- Page 260 -->

int mc Gui Set Focus(
MINST ANCE m Inst, BOOL focus);
N/A
<font color="green">// Set focus to the GUI's main window</font>
MINST ANCE m Inst = 0; int rc = mc Gui Set Focus(m Inst, TRUE);


<!-- Page 261 -->

int mc Gui Set W indow Handle(
MINST ANCE m Inst, void *handle);
N/A
<font color="green">// Set the GUI main window handle.</font>
MINST ANCE m Inst = 0; mc Gui Set W indow Handle(0, this);


<!-- Page 262 -->

int mc T ool Path Create(
MINST ANCE m Inst, void *window);
N/A
wx Panel* m_tp TP;

MINST ANCE m Inst = 0; m_tp TP = new wx Panel(item Panel 1 2 9,
ID_T OOLP ATH_P ANEL, wx Default Position, wx Default Size,
```
wx TAB_TRA VERSAL ); rc = m_tp TP->Show(); <font color="green">//
Pass the handle of the tool path.</font> mc T ool Path Create(m Inst, m_tp TP-
```
>Get HWND());


<!-- Page 263 -->

int mc T ool Path Delete(
MINST ANCE m Inst, void *parent);
N/A
<font color="green">// Delete an existing tool path.</font> MINST ANCE
m Inst = 0; HWND parent; <font color="green">// A previously valid
window handle.</font> int rc = mc T ool Path Delete(m Inst, parent);


<!-- Page 264 -->

int mc T ool Path Generate(
MINST ANCE m Inst);
rc = mc.mc T ool Path Generate(
number m Inst)
MINST ANCE m Inst = 0;
<font color="green">// Regenerate the toolpaths for controller instance
0</font> int rc = mc T ool Path Generate(m Inst);


<!-- Page 265 -->

int mc T ool Path Generate Abort(
MINST ANCE m Inst);
rc = mc.mc T ool Path Generate Abort(
number m Inst);
MINST ANCE m Inst = 0;
<font color="green">// Abort the regeneration of the toolpath for controller
0.</font> int rc = mc T ool Path Generate Abort(m Inst);


<!-- Page 266 -->

int mc T ool Path Generated Percent(
MINST ANCE m Inst, double *percent);
percent, rc = mc.mc T ool Path Generated Percent(
number m Inst)
MINST ANCE m Inst = 0;
double pdone = 0;

```
while (pdone != 1 0 0) {
<font color="green">// Get the percent of the file that is loaded.</font>
mc Tool Path Generated Percent(m Inst, &pdone); <font color="green">// Post
```
the pdone to some dialog.</font> Sleep(2 5 0); }


<!-- Page 267 -->

mc Tool Path Get AAxis Position(MINST ANCE m Inst, double *x Pos, double
*y Pos, double *z Pos);
mc Tool Path Get AAxis Position(MINST ANCE m Inst, double *x Pos, double
*y Pos, double *z Pos);
<font color="green">// </font> MINST ANCE m Inst = 0;
mc Tool Path Get AAxis Position(MINST ANCE m Inst, double *x Pos, double
*y Pos, double *z Pos);


<!-- Page 268 -->

mc Tool Path Get ARotation Axis
C/C++ Syntax:
mc Tool Path Get ARotation Axis(MINSTANCE m Inst, int *axis);

LUA Syntax:
mc Tool Path Get ARotation Axis(MINSTANCE m Inst, int *axis);

Description:

Parameters:
Parameter Description
m Inst The controller instance.

Returns:
Return Code Description
MERROR_NOERROR No Error .
MERROR_INV ALID_INST ANCEThe m Inst
parameter was out
of range.
Notes:
Usage:
//
MINSTANCE m Inst = 0;
mc Tool Path Get ARotation Axis(MINSTANCE m Inst, int *axis);


<!-- Page 269 -->

int mc T ool Path Get Axis Color(
MINST ANCE m Inst, unsigned long *axiscolor , unsigned long
*limitcolor);
axiscolor , limitcolor , rc = mc.mc T ool Path Get Axis Color(
number m Inst)
<font color="green">// Get the axis and limit colors.</font> MINST ANCE
m Inst = 0;
int rc = mc T ool Path Get Axis Color(MINST ANCE m Inst, unsigned long
*axiscolor , unsigned long *limitcolor);


<!-- Page 270 -->

int mc T ool Path Get Back Color(
MINST ANCE m Inst, unsigned long *topcolor , unsigned long *botcolor);
topcolor , botcolor , rc = mc.mc T ool Path Get Back Color(
number m Inst)
MINST ANCE m Inst = 0;
unsigned long topcol, botcol;

<font color="green">// Get the tool background top and bottom
colors</font> int rc = mc T ool Path Get Back Color(m_inst, &topcol,
&botcol);


<!-- Page 271 -->

int mc T ool Path Get Draw Limits(
MINST ANCE m Inst, BOOL *drawlimits);
drawlimits, rc = mc T ool Path Get Draw Limits(
number m Inst)
MINST ANCE m Inst = 0;
BOOL drawlimits = F ALSE;
<font color="green">// See if the soft limits bounding box is beeing shown
in the toolpath.</font> int rc = mc T ool Path Get Draw Limits(m Inst,
&drawlimits);


<!-- Page 272 -->

int mc T ool Path Get Execution(
MINST ANCE m Inst, unsigned long ex Num, void **data, unsigned long
*len);
N/A


<!-- Page 273 -->

struct Executions
```
{
bool linear : 1; //Is this a linear move?
bool rapid : 1; //Is it a Rapid move?
bool inc : 1; //Is this an inc move?
bool comp : 1; bool rotation : 1; //arc direction bool Used Axis 0 : 1; bool
Used Axis 1 : 1; bool Used Axis 2 : 1; bool Used Axis 3 : 1; bool Used Axis 4 :
1; bool Used Axis 5 : 1; bool Used Axis 6 : 1; bool Used Axis 7 : 1; bool
Used Axis 8 : 1; bool Used Axis 9 : 1; bool Used Axis 1 0 : 1; float end[6]; float
center[3]; float normal[3]; unsigned int Line Number; // Line number in the
file...
unsigned int Execution ID; // Number of the move from the Gcode
interperter float Feed Rate; // Feedrate of the move unsigned char
Tool Number; // T ool number of the move used to show of fsets..
unsigned char Fixture; // The fixture.
```
};
<font color="green">// </font> MINST ANCE m Inst = 0;
unsigned long ex Num = 0;
unsigned long len;
void *data;
int rc;
struct Executions *ex;


<!-- Page 274 -->

<font color="green">// Get the length of the move execution structure first.
</font> while (mc T ool Path Get Execution(m Inst, ex Num, NULL, &len) ==
```
MERROR_NOERROR) {
<font color="green">// Allocate some mem to receive the data.</font>
```
data = malloc(len); if (data != NULL) {
<font color="green">// Get the data.</font> if
(mc T ool Path Get Execution(m Inst, ex Num, &data, &len) ==
```
MERROR_NOERROR) {
<font color="green">// cast the void pointer to the current structure.
</font> ex = (struct Executions *)data; ...
```
free(data); }
```
}
```
}


<!-- Page 275 -->

int mc T ool Path Get Follow Mode(
MINST ANCE m Inst, BOOL *enabled);
enabled, rc = mc.mc T ool Path Get Follow Mode(
number m Inst)
<font color="green">// See if jog follow is enabled.</font> MINST ANCE
m Inst = 0;
BOOL enabled = F ALSE;
int rc = mc T ool Path Get Follow Mode(m Inst, &enabled);


<!-- Page 276 -->

int mc T ool Path Get Generating(
MINST ANCE m Inst, int *path Generating);
path Generating, rc = mc.mc T ool Path Get Generating(
number m Inst)
MINST ANCE m Inst = 0;
BOOL Is Gen = F ALSE;
<font color="green">// See if the tool path is generating.</font> int rc =
mc Get Path Generating(m Inst, &Is Gen);


<!-- Page 277 -->

int mc T ool Path Get Left Mouse Dn(
MINST ANCE m Inst, double *x, double *y , double *z);
x, y, z, rc = mc.mc T ool Path Get Left Mouse Dn(
number m Inst)
<font color="green">// Get the mouse coordinates in the tool path.</font>
MINST ANCE m Inst = 0;
double x, y , z;
int rc = mc T ool Path Get Left Mouse Dn(MINST ANCE m Inst, double *x,
double *y , double *z);


<!-- Page 278 -->

int mc T ool Path Get Left Mouse Up(
MINST ANCE m Inst, double *x, double *y , double *z);
x, y, z, rc = mc.mc T ool Path Get Left Mouse Up(
number m Inst)
<font color="green">// Get the mouse coordinates in the tool path.</font>
MINST ANCE m Inst = 0;
double x, y , z;
int rc = mc T ool Path Get Left Mouse Up(MINST ANCE m Inst, double *x,
double *y , double *z);


<!-- Page 279 -->

int mc T ool Path Get Path Color(
MINST ANCE m Inst, unsigned long *rapidcolor , unsigned long
*linecolor , unsigned long *arccolor , unsigned long *highlightcolor);
rapidcolor , linecolor , arccolor , highlightcolor , rc =
mc Tool Path Get Path Color(
number m Inst)
MINST ANCE m Inst = 0;
unsigned long rapcol, lincol, arccol, highcol; <font color="green">// Get the
tool path colors</font> int rc = mc T ool Path Get Path Color(m_inst, &rapcol,
&lincol, &arccol, &highcol);


<!-- Page 280 -->

int mc T ool Path Is Signal Mouse Clicks(
MINST ANCE m Inst, BOOL *enabled);
enabled, rc = mc T ool Path Is Signal Mouse Clicks(
number m Inst)
<font color="green">// See if we are signaling mouse click events in the
tool path.</font> MINST ANCE m Inst = 0;
BOOL enabled = F ALSE;
int rc = mc T ool Path Is Signal Mouse Clicks(m Inst, &enabled);


<!-- Page 281 -->

mc Tool Path Set AAxis Position(MINST ANCE m Inst, double x Pos, double
y Pos, double z Pos);
mc Tool Path Set AAxis Position(MINST ANCE m Inst, double x Pos, double
y Pos, double z Pos);
<font color="green">// </font> MINST ANCE m Inst = 0;
mc Tool Path Set AAxis Position(MINST ANCE m Inst, double x Pos, double
y Pos, double z Pos);


<!-- Page 282 -->

mc Tool Path Set ARotation Axis
C/C++ Syntax:
mc Tool Path Set ARotation Axis(MINSTANCE m Inst, int axis);

LUA Syntax:
mc Tool Path Set ARotation Axis(MINSTANCE m Inst, int axis);

Description:

Parameters:
Parameter Description
m Inst The controller instance.

Returns:
Return Code Description
MERROR_NOERROR No Error .
MERROR_INV ALID_INST ANCEThe m Inst
parameter was out
of range.
Notes:
Usage:
//
MINSTANCE m Inst = 0;
mc Tool Path Set ARotation Axis(MINSTANCE m Inst, int axis);


<!-- Page 283 -->

int mc T ool Path Set Axis Color(
MINST ANCE m Inst, unsigned long axiscolor , unsigned long limitcolor);
rc = mc.mc T ool Path Set Axis Color(
number m Inst, number axiscolor , number limitcolor)
MINST ANCE m Inst = 0;
unsigned long axiscolor;
unsigned long limitcolor;

//red
axiscolor = (2 5 5<<0);//red axiscolor += (0<<8);//green axiscolor +=
(0<<1 6);//blue
//Yellow
limitcolor = (2 5 5<<0);//red limitcolor += (2 5 5<<8);//green limitcolor +=
(1 2 8<<1 6);//blue
<font color="green">// Set the axis and limit colors</font> int rc =
mc Tool Path Set Axis Color(m Inst, axiscolor , limitcolor);


<!-- Page 284 -->

int mc T ool Path Set Back Color(
MINST ANCE m Inst, unsigned long topcolor , unsigned long botcolor);
rc = mc.mc T ool Path Set Back Color(
number m Inst, number topcolor , number botcolor)
MINST ANCE m Inst = 0;
unsigned long topcolor;


<!-- Page 285 -->

unsigned long botcolor

//Dark Blue T op
topcolor = (2 8<<0); topcolor += (2 8<<8); topcolor += (2 1 3<<1 6); //Light
Blue Bottom
botcolor = (1 6 4<<0); botcolor += (1 5 6<<8); botcolor += (2 2 8<<1 6);
<font color="green">// Set the background color</font> int rc =
mc Tool Path Set Back Color(m Inst, topcolor , botcolor);


<!-- Page 286 -->

int mc T ool Path Set Draw Limits(
MINST ANCE m Inst, BOOL drawlimits);
rc = mc.mc T ool Path Set Draw Limits(
number m Inst, number drawlimits)
<font color="green">// T urn on soft limits in the tool path.</font>
MINST ANCE m Inst = 0;
int rc = mc T ool Path Set Draw Limits(m Inst, TRUE);


<!-- Page 287 -->

int mc T ool Path Set Follow Mode(
MINST ANCE m Inst, BOOL enabled);
rc = mc.mc T ool Path Set Follow Mode(
number m Inst, number enabled)
<font color="green">// T urn on tool path jog following.</font>
MINST ANCE m Inst = 0;
int rc = mc T ool Path Set Follow Mode(m Inst, TRUE);


<!-- Page 288 -->

int mc T ool Path Set Path Color(
MINST ANCE m Inst, unsigned long rapidcolor , unsigned long linecolor ,
unsigned long arccolor , unsigned long highlightcolor);
rc = mc.mc T ool Path Set Path Color(
number m Inst, number rapidcolor , number linecolor , number arccolor ,
number highlightcolor)
<font color="green">// Set the tool path colors</font> MINST ANCE m Inst
= 0;
unsigned long rapidcolor;
unsigned long linecolor;
unsigned long arccolor;
unsigned long highlightcolor;

rapidcolor = (2 5 4<<0);//Red rapidcolor += (0<<8);//Green rapidcolor +=
(0<<1 6);//Blue
linecolor = (0<<0);//Red
linecolor += (2 5 4<<8);//Green linecolor += (0<<1 6);//Blue
arccolor = (0<<0);//Red
arccolor += (2 5 4<<8);//Green arccolor += (0<<1 6);//Blue
highlightcolor = (2 5 4<<0);//Red highlightcolor += (2 5 4<<8);//Green
highlightcolor += (2 5 4<<1 6);//Blue


<!-- Page 289 -->

int rc = mc T ool Path Set Path Color(m Inst, rapidcolor , linecolor , arccolor ,
highlightcolor);


<!-- Page 290 -->

int mc T ool Path Set Signal Mouse Clicks(
MINST ANCE m Inst, BOOL enabled);
rc = mc.mc T ool Path Set Signal Mouse Clicks(
number m Inst, number enabled)
<font color="green">// T urn on mouse click events in the tool path.</font>
MINST ANCE m Inst = 0;
int rc = mc T ool Path Set Signal Mouse Clicks(m Inst, TRUE);


<!-- Page 291 -->

int mc T ool Path Set V iew(
MINST ANCE m Inst, void *parent, int view);
N/A
<font color="green">// Set the tool path orientation to the ISO view .</font>
MINST ANCE m Inst = 0;
HWND parent; <font color="green">// A valid window handle.</font> int
rc = mc T ool Path Set V iew(m Inst, parent, MCTPVIEW_ISO);


<!-- Page 292 -->

int mc T ool Path Set Zoom(
MINST ANCE m Inst, void *parent, double zoom);
N/A
<font color="green">// Set the toop path zoom percentage to 1 5 0%</font>
MINST ANCE m Inst = 0;
HWND parent; <font color="green">// A valid window handle.</font> int
rc = mc T ool Path Set Zoom(m Inst, parent, 1.5);


<!-- Page 293 -->

int mc T ool Path Update(
MINST ANCE m Inst, void *parent);
N/A
MINST ANCE m Inst = 0; HWND parent; <font color="green">// A valid
window handle.</font> int mc T ool Path Update(m Inst, parent);


<!-- Page 294 -->

Profile (INI) Settings

mc Profile Delete Key
mc Profile Delete Section
mc Profile Exists
mc Profile Flush
mc Profile Get Double
mc Profile Get Int
mc Profile Get Name
mc Profile Get String
mc Profile Reload
mc Profile Save
mc Profile W rite Double
mc Profile W rite Int
mc Profile W rite String


<!-- Page 295 -->

int mc Profile Delete Key(
```
MINST ANCE m Inst, const char *section, const char *key);
rc = mc.mc Profile Delete Key(
number m Inst, string section, string key)
MINST ANCE m Inst = 0;
mc Profile Delete Key(m Inst , "P_Port", "Frequency");


<!-- Page 296 -->

int mc Profile Delete Section(
```
MINST ANCE m Inst, const char *section);
rc = mc.mc Profile Delete Section(
number m Inst, string section)
MINST ANCE m Inst = 0;
mc Profile Delete Key(m Inst , "P_Port");


<!-- Page 297 -->

int mc Profile Exists(
```
MINST ANCE m Inst, const char *section, const char *key);
rc = mc.mc Profile Exists(
number m Inst, string section, string key)
MINST ANCE m Inst = 0;
mc Profile W rite Int(m Inst, "P_Port", "Frequency");


<!-- Page 298 -->

int mc Profile Flush(
INST ANCE m Inst);
rc = mc.mc Profile Flush(
number m Inst)
MINST ANCE m Inst = 0; mc Profile Flush(m Inst); <font color="green">//
Flush changes to the INI file.</font>


<!-- Page 299 -->

mc Profile Get Double(
```
MINST ANCE m Inst, const char *section, const char *key , double
*retval, double defval);
retval, rc = mc.mc Profile Get Double(
number m Inst, string section, string key , number defval)
double rval=0;
MINST ANCE m Inst = 0;
mc Profile Get Double(m Inst , "P_Port", "Frequency", &rval, 2 5.3 4);


<!-- Page 300 -->

int mc Profile Get Int(
```
MINST ANCE m Inst, const char *section, const char *key , long *retval,
long defval);
retval, rc = mc.mc Profile Get Int(
number m Inst, string section, string key , number defval)
long rval=0;
int m Inst=0;
mc Profile Get Int(m Inst , "P_Port", "Frequency", &rval, 2 5 0 0 0);


<!-- Page 301 -->

int mc Profile Get Name(
MINST ANCE m Inst, char *buf f, size_t bufsize);
name, rc = mc.mc Profile Get Name(
number m Inst)
MINST ANCE m Inst = 0; char buf f[8 0];
memset(buf f, 0, 8 0); mc Profile Get Name(m Inst, buf f, 8 0);


<!-- Page 302 -->

int mc Profile Get String(
```
MINST ANCE m Inst, const char *section, const char *key , char *buf f,
```
long buf fsize, const char *defval);
buff, rc = mc.mc Profile Get String(
MINST ANCE m Inst, string section, string key , string defval);
MINST ANCE m_inst = 0;
char *key = "Buf fered T ime"; char buf f[8 0];
memset(buf f, 0, 8 0);
mc Profile Get String(m Inst , "Some Section", key , buff, 8 0, "0.1 0 0");


<!-- Page 303 -->

int mc Profile Reload(
INST ANCE m Inst);
rc = mc.mc Profile Reload(
number m Inst)
MINST ANCE m Inst = 0; mc Profile Reload(m Inst); <font color="green">//
Reload the settings from the INI file.</font>


<!-- Page 304 -->

int mc Profile Save(
INST ANCE m Inst);
rc = mc.mc Profile Save(
number m Inst)
MINST ANCE m Inst = 0; mc Profile Save(m Inst); <font color="green">//
Flush the settings to the INI file.</font>


<!-- Page 305 -->

int mc Profile W rite Double(
```
MINST ANCE m Inst, const char *section, const char *key , double val);
rc = mc.mc Profile W rite Double(
number m Inst, string section, string key , double val)
MINST ANCE m Inst=0;
mc Profile W rite Double(m_cid , "P_Port", "Frequency", 4 5 0 0 0);


<!-- Page 306 -->

int mc Profile W rite Int(
```
MINST ANCE m Inst, const char *section, const char *key , long val);
int mc Profile W rite Int(
number m Inst, string section, string key , number val)
MINST ANCE m Inst = 0;
mc Profile W rite Int(m_cid , "P_Port", "Frequency", 4 5 0 0 0);


<!-- Page 307 -->

int mc Profile W rite String(
```
MINST ANCE m Inst, const char *section, const char *key , const char
*val);
rc = mc.mc Profile W rite String(
number m Inst, string section, string key , string val)
MINST ANCE m_inst = 0;
char *key = "Buf fered T ime"
double Buf f Time = .2 5 0;
char val[8 0];
sprintf(val, "%.4 f", Buf f Time); mc Profile W rite String(m Inst, "Darwin", key ,
val);


<!-- Page 308 -->

General

mc Cntl Config Start
mc Cntl Config Stop
mc Cntl Create Local V ars
mc Cntl Enable
mc Cntl Gcode Execute
mc Cntl Gcode Execute W ait
mc Cntl Gcode Interp Get Data
mc Cntl Gcode Interp Get Pos
mc Cntl Get Build
mc Cntl Get Computer ID
mc Cntl Get Coolant Delay
mc Cntl Get Cwd
mc Cntl Get Dia Mode
mc Cntl Get Dist T o Go
mc Cntl Get Instance Handle
mc Cntl Get Local Comment


<!-- Page 309 -->

mc Cntl Get Local V ar
mc Cntl Get Local V ar Flag
mc Cntl Get Logging
mc Cntl Get Mach Dir
mc Cntl Get Mist Delay
mc Cntl Get Modal Group
mc Cntl Get Mode
mc Cntl Get Of fset
mc Cntl Get Pound V ar
mc Cntl Get Register
mc Cntl Get Run T ime
mc Cntl Get Spindle Speed
mc Cntl Get State
mc Cntl Get State Name
mc Cntl Get Stats
mc Cntl Get T ool Of fset
mc Cntl Get Units Current
mc Cntl Get Units Default
mc Cntl Get V alue
mc Cntl Get V ersion


<!-- Page 310 -->

mc Cntl Is Still
mc Cntl Machine State Clear
mc Cntl Machine State Pop
mc Cntl Machine State Push
mc Cntl Macro Alarm
mc Cntl Macro Stop
mc Cntl Mdi Execute
mc Cntl Plugin Config
mc Cntl Plugin Diag
mc Cntl Probe File Close
mc Cntl Probe File Open
mc Cntl Probe Get Strike Status
mc Cntl Set Coolant Delay
mc Cntl Set Dia Mode
mc Cntl Set Mist Delay
mc Cntl Set Mode
mc Cntl Set Pound V ar
mc Cntl Set Stats
mc Cntl Set V alue
mc File Hold Aquire


<!-- Page 311 -->

mc File Hold Reason
mc File Hold Release


<!-- Page 312 -->

int mc Cntl Config Start(
MINST ANCE m Inst);
rc = mc.mc Cntl Config Start(
number m Inst);
<font color="green">// Enter the configure state</font> MINST ANCE
m Inst = 0;
```
if (mc Cntl Config Start(m Inst) == MERRROR_NOERROR) {
```
<font color="green">// Successfully entered the configure state!</font> }


<!-- Page 313 -->

int mc Cntl Config Stop(
MINST ANCE m Inst);
rc = mc.mc Cntl Config Stop(
number m Inst);
<font color="green">// Leave the configure state.</font> MINST ANCE
m Inst = 0; int rc = mc Cntl Config Stop(m Inst); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Successfully exited the configure state.</font> }


<!-- Page 314 -->

int mc Cntl Create Local V ars(
MINST ANCE m Inst,
```
const char *line Params, unsigned long *handle)
h Params, rc = mc.mc Cntl Create Local V ars(
number m Inst,
string line Params);
<font color="green">--Example m 1 9 script that takes parameters</font>
```
<br/> function m 1 9(h Param) <font color="green">--h Param is a handle to
all parameters on same line as m 1 9 --The R and P params are optional. M 1 9
R 9 0 P 0 for example.</font> <font color="green">--R is angle from 0 to
3 6 0.</font> <font color="green">--P is direction: 0 == shortest angle, 1 ==
clockwise, 2 == counterclockwise</font> <font color="green">--Fanuc
```
uses S for angle</font> local inst = mc.mc Get Instance() local pcall Ret =
true
local stat = 1
local msg Pre = "M 1 9 macro says "
local msg = "M 1 9 Completed successfully"
```
local var R = 0
```
local var P = 0
if (h Param ~= nil) then local rc, flag R, flag P
flag R, rc = mc.mc Cntl Get Local V ar Flag(inst, h Param, mc.SV_R) flag P , rc
= mc.mc Cntl Get Local V ar Flag(inst, h Param, mc.SV_P) if (flag R == 1) then
<font color="green">--Check that the flag has been set so we do not get an
```
unexpected value for mc.SV_R</font> var R = mc.mc Cntl Get Local V ar(inst,
```
h Param, mc.SV_R) if (var R < 0) or (var R > 3 6 0) then <font


<!-- Page 315 -->

```
color="green">--It is out of range</font> msg = string.format("var R == " ..
```
var R .. " and is out of range (0-3 6 0)") mc.mc Cntl Cycle Stop(inst) return
end
end

if (flag P == 1) then <font color="green">--Check that the flag has been
```
set so we do not get an unexpected value for mc.SV_P</font> var P =
mc.mc Cntl Get Local V ar(inst, h Param, mc.SV_P) <font color="green">--
```
fixup the values to pass to the spindleorient script.</font> if (var P == 0)
then
```
var P = mc.MC_SPINDLE_ST OP <font color="green">-- 0</font> elseif
```
(var P == 1) then var P = mc.MC_SPINDLE_FWD <font color="green">--
```
1</font> elseif (var P == 2) then var P = mc.MC_SPINDLE_REV <font
color="green">-- -1</font> else
```
msg = string.format("var P == " .. var P .. " and is out of range (0-2)")
mc.mc Cntl Cycle Stop(inst) return
end
end
end

```
pcall Ret, stat, msg = pcall(spindleorient, var R, var P); <font
color="green">--Call the spindleorient.mcs script</font>
mc.mc Cntl Set Last Error(inst, msg Pre .. msg)
if (pcall Ret == false) then mc.mc Cntl Cycle Stop(inst) end


<!-- Page 316 -->

end

```
if (mc.mc In Editor() == 1) then
<font color="green">--W e are testing the script in the editor .</font>
```
<font color="green">--Fab up some paramters to pass to our m 1 9()
```
function.</font> local inst = mc.mc Get Instance() local h Params, rc = <font
color="blue">mc.mc Cntl Create Local V ars</font>(inst, "R 3 2 0 P 0")<font
color="green">--Like we are testing "M 1 9 R 3 2 0 P 0".</font>
```
m 1 9(h Params) <font color="green">--Call m 1 9() with h Params.</font> end


<!-- Page 317 -->

int mc Cntl Enable(
MINST ANCE m Inst, BOOL state);
rc = mc.mc Cntl Enable(
number m Inst, number state)
<font color="green">// Enable the control.</font> MINST ANCE m Inst = 0;
int rc = mc Cntl Enable(m Inst, TRUE);


<!-- Page 318 -->

int mc Cntl Gcode Execute(
```
MINST ANCE m Inst, const char *commands);
rc = mc.mc Cntl Gcode Execute(
number m Inst, string commands)
<font color="green">// Execute spindle stop and rapid to 0, 0.</font>
MINST ANCE m Inst = 0;
int rc;
rc = mc Cntl Gcode Execute(m Inst, "M 0 5\n G 0 0 X 0 Y 0"); if (rc ==
```
MERROR_NOERROR) {
<font color="green">// The G code was submitted for processing.</font>
```
<font color="green">// However , the function return immediately and does
```
not wait on the G code to finish.</font> }


<!-- Page 319 -->

int mc Cntl Gcode Execute W ait(
```
MINST ANCE m Inst, const char *commands);
rc = mc.mc Cntl Gcode Execute W ait(
number m Inst, string commands)
<font color="green">// Execute spindle stop and rapid to 0, 0.</font>
MINST ANCE m Inst = 0;
int rc;
rc = mc Cntl Gcode Execute W ait(m Inst, "M 0 5\n G 0 0 X 0 Y 0"); if (rc ==
```
MERROR_NOERROR) {
<font color="green">// The G code was submitted for processing and has
```
completed.</font> }


<!-- Page 320 -->

int mc Cntl Gcode Interp Get Data(
MINST ANCE m Inst, interperter_t *data);
N/A
```
struct Interperter_info {
double Modal Groups[MC_MAX_GROUPS]; double Feed Rate; double
Spindle Speed; int Spindle Direction; BOOL Mist; BOOL Flood; int
```
Tool Number; int Height Register; int Dia Register; };
```
typedef struct Interperter_info interperter_t;
<font color="green">// Get the interpreter information.</font>
MINST ANCE m Inst = 0;
interperter_t data;
int rc;
rc = mc Cntl Gcode Interp Get Data(m Inst, &data); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 321 -->

int mc Cntl Gcode Interp Get Pos(
MINST ANCE m Inst, int axis Id, double *pos);
pos, rc = mc.mc Cntl Gcode Interp Get Pos(
number m Inst, number axis Id)
<font color="green">// Get the current buf fered X axis position.</font>
MINST ANCE m Inst = 0; double pos;
int rc;
rc = int mc Cntl Gcode Interp Get Pos(m Inst, X_AXIS, &pos); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 322 -->

int mc Cntl Get Build(
MINST ANCE m Inst, char *buf, size_t bufsize);
build, rc = mc.mc Cntl Get Build(
number m Inst)
<font color="green">// Get the core's build number</font> MINST ANCE
m Inst = 0; char build Buf[8 0];
int rc = mc Cntl Get Build(m Inst, build Buf, sizeof(build Buf)); if (rc ==
```
MERROR_NOERROR) {
```
printf("The current build is %s.n", build Buf); }


<!-- Page 323 -->

int mc Cntl Get Computer ID(
MINST ANCE m Inst, char *buf, size_t buf Size);
buf, rc = mc.mc Cntl Get Computer ID(
number m Inst)
<font color="green">// Get the ID(s) for this host</font> MINST ANCE
m Inst = 0;
int rc = mc Cntl Get Computer ID(m Inst, buf, sizeof(buf)); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Parse buf to get the ID(s)</font> }


<!-- Page 324 -->

int mc Cntl Get Coolant Delay(
MINST ANCE m Inst, double *secs);
sec, rc = mc.mc Cntl Get Coolant Delay(
number m Inst)
<font color="green">// Get the coolant delay .</font> MINST ANCE m Inst =
0;
double secs;
int rc = mc Cntl Get Coolant Delay(m Inst, &secs); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 325 -->

int mc Cntl Get Cwd(
MINST ANCE m Inst, char *buf, size_t buf Size);
buf, rc = mc.mc Cntl Get Cwd(
number m Inst)
<font color="green">// Get current working directory .</font>
MINST ANCE m Inst = 0;
char cur Dir[2 5 5];
int rc = mc Cntl Get Cwd(m Inst, cur Dir , sizeof(cur Dir)); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 326 -->

int mc Cntl Get Dia Mode(
MINST ANCE m Inst, BOOL *dia);
dia, rc = mc.mc Cntl Get Dia Mode(
number m Inst)
<font color="green">// Get the lathe diameter mode.</font> MINST ANCE
m Inst = 0; BOOL Dia;
int rc = mc Cntl Get Dia Mode(m Inst, &Dia); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 327 -->

int mc Cntl Get Dist T o Go(
MINST ANCE m Inst, int axis Id, double *togo);
togo, rc = int mc Cntl Get Dist T o Go(
number m Inst, number axis Id)
int m Inst=0;
int axis = Y_AXIS;
double togo=0;
mc Cntl Get Dist T o Go(m Inst, axis, &togo);


<!-- Page 328 -->

```
int mc Cntl Get Instance Handle(MINST ANCE m Inst, const char *owner ,
HMINST ANCE *h Inst);
h Inst, rc = mc.mc Cntl Get Instance Handle(
number m Inst, string owner) or

h Inst = mc.mc Get Instance(string owner)
MINST ANCE m Inst=0;
HMINST ANCE h Inst;
mc Cntl Get Instance Handle(m Inst, "My Description", &h Inst);
mc Cntl Cycle Start(h Inst); <font color="green">//W ill show in the log as
coming from "My Description"</font>


<!-- Page 329 -->

comment, rc = mc.mc Cntl Get Local Comment(
number m Inst,
number h V ars)
```
<font color="green">-- Get local variables.</font> function m 7 0 0(h V ars)
```
local inst = mc.mc Get Instance() <font color="green">-- Get the current
instance</font> local nil Pound V ar = mc.mc Cntl Get Pound V ar(inst, 0) local
comment = <font color="blue">mc.mc Cntl Get Local Comment</font>(inst,
h Vars) local message = ""
if h V ars ~= nil then local flag, retval, rc flag, rc =
mc.mc Cntl Get Local V ar Flag(inst, h V ars, mc.SV_A) if (flag == 1) then
retval, rc = mc.mc Cntl Get Local V ar(inst, h V ars, mc.SV_A) if rc ==
mc.MERROR_NOERROR then message = message .. "A" .. ":" ..
tostring(retval) .. ", "
end
end
flag, rc = mc.mc Cntl Get Local V ar Flag(inst, h V ars, mc.SV_A) if (flag ==
1) then retval, rc = mc.mc Cntl Get Local V ar(inst, h V ars, mc.SV_B) if rc ==
mc.MERROR_NOERROR then message = message .. "B" .. ":" ..
tostring(retval) end
end
mc.mc Cntl Set Last Error(inst, message) end


<!-- Page 330 -->

end

```
if (mc.mc In Editor() == 1) then
<font color="green">--W e are testing the script in the editor .</font>
```
<font color="green">--Fab up some paramters to pass to our m 7 0 0()
```
function.</font> local inst = mc.mc Get Instance() local h Params, rc = <font
color="blue">mc.mc Cntl Create Local V ars</font>(inst, "A 2 3 B 6 (my
Comment)")<font color="green">--Like we are testing "M 7 0 0 A 2 3 B 6 (my
Comment)".</font> m 7 0 0(h Params) <font color="green">-- Call m 7 0 0
with h Params.</font> end


<!-- Page 331 -->

retval, rc = mc.mc Cntl Get Local V ar(
number m Inst,
number h V ars,
```
number var Number)
```
<font color="green">-- Get local variables.</font> function m 7 0 0(h V ars)
```
local inst = mc.mc Get Instance() -- Get the current instance local
nil Pound V ar = mc.mc Cntl Get Pound V ar(inst, h V ars, 0) local message = ""
if h V ars ~= nil then local flag, retval, rc flag, rc =
mc.mc Cntl Get Local V ar Flag(inst, h V ars, mc.SV_A) if (flag == 1) then
retval, rc = mc.mc Cntl Get Local V ar(inst, h V ars, mc.SV_A) if rc ==
mc.MERROR_NOERROR then message = message .. "A" .. ":" ..
tostring(retval) .. ", "
end
end
flag, rc = mc.mc Cntl Get Local V ar Flag(inst, h V ars, mc.SV_A) if (flag ==
1) then retval, rc = mc.mc Cntl Get Local V ar(inst, h V ars, mc.SV_B) if rc ==
mc.MERROR_NOERROR then message = message .. "B" .. ":" ..
tostring(retval) end
end
mc.mc Cntl Set Last Error(inst, message) end


<!-- Page 332 -->

end

```
if (mc.mc In Editor() == 1) then
m 7 0 0(nil) <font color="green">-- W e can't test this in the editor!</font>
end


<!-- Page 333 -->

int mc Cntl Get Local V ar Flag(
MINST ANCE m Inst, HMCV ARS h V ars,
```
int var Number ,
int *retval);
retval, rc = mc.mc Cntl Get Local V ar Flag(
number m Inst,
number h V ars,
```
number var Number)
```
<font color="green">-- Get local variables.</font> function m 7 0 0(h V ars)
```
local inst = mc.mc Get Instance() -- Get the current instance local
nil Pound V ar = mc.mc Cntl Get Pound V ar(inst,0) local message = ""
if h V ars ~= nil then local flag, retval, rc flag, rc =
mc.mc Cntl Get Local V ar Flag(inst, h V ars, mc.SV_A) if (flag == 1) then
retval, rc = mc.mc Cntl Get Local V ar(inst, h V ars, mc.SV_A) if rc ==
mc.MERROR_NOERROR then message = message .. "A" .. ":" ..
tostring(retval) .. ", "
end
end
flag, rc = mc.mc Cntl Get Local V ar Flag(inst, h V ars, mc.SV_A) if (flag ==
1) then retval, rc = mc.mc Cntl Get Local V ar(inst, h V ars, mc.SV_B) if rc ==
mc.MERROR_NOERROR then message = message .. "B" .. ":" ..
tostring(retval) end
end


<!-- Page 334 -->

mc.mc Cntl Set Last Error(inst, message) end


<!-- Page 335 -->

end

```
if (mc.mc In Editor() == 1) then
m 7 0 0(nil) <font color="green">-- W e can't test this in the editor!</font>
end


<!-- Page 336 -->

int mc Cntl Get Logging(
MINST ANCE m Inst, BOOL *enabled);
enabled, rc = mc.mc Cntl Get Logging(
number m Inst)
<font color="green">// Check is logging is enabled.</font> MINST ANCE
m Inst = 0; BOOL enabled = F ALSE; int rc = mc Cntl Get Logging(m Inst,
```
&enabled); if (rc == MERROR_NOERROR && enabled == TRUE) {
<font color="green">// Logging is enabled!
```
}

</font>


<!-- Page 337 -->

mc Cntl Get Mach Dir
C/C++ Syntax:

LUA Syntax:

Description:

Parameters:
Parameter Description
m Inst The controller instance.

Returns:
Return Code Description
MERROR_NOERROR No Error .
MERROR_INV ALID_INST ANCEThe m Inst
parameter was out
of range.
Notes:
Usage:
//
MINSTANCE m Inst = 0;


<!-- Page 338 -->

int mc Cntl Get Mist Delay(
MINST ANCE m Inst, double *secs);
secs, rc = mc Cntl Get Mist Delay(
number m Inst)
<font color="green">// Get the mist delay .</font> MINST ANCE m Inst = 0;
double secs;
int rc = mc Cntl Get Mist Delay(m Inst, &secs); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 339 -->

int mc Cntl Get Modal Group(
MINST ANCE m Inst, int group, double *val);
val, rc = mc.mc Cntl Get Modal Group(
number m Inst, number group)
<font color="green">// Get the modal code for modal group 1.</font>
MINST ANCE m Inst = 0;
int rc = mc Cntl Get Modal Group(m Inst, 1); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 340 -->

mc Cntl Get Mode


<!-- Page 341 -->

int mc Cntl Get Of fset(
MINST ANCE m Inst, int axis Id, int type,
double *of fset);
offset, rc = mc.mc Cntl Get Of fset(
number m Inst, number axis Id, number type)
<font color="green">// </font> MINST ANCE m Inst = 0;


<!-- Page 342 -->

int mc Cntl Get Pound V ar(
MINST ANCE m Inst, int param, double *value);
value, rc = mc.mc Cntl Get Pound V ar(
number m Inst, number param)
int m Inst=0;
double Pound V ar=5 0;
dobule V alue=0;
<font color="green">;// Get the value of #5 0.</font>
mc Cntl Get Pound V ar(m Inst, Pound V ar, &V alue);


<!-- Page 343 -->

mc Cntl Get Register
C/C++ Syntax:

LUA Syntax:

Description:

Parameters:
Parameter Description
m Inst The controller instance.

Returns:
Return Code Description
MERROR_NOERROR No Error .
MERROR_INV ALID_INST ANCEThe m Inst
parameter was out
of range.
Notes:
Usage:
//
MINSTANCE m Inst = 0;


<!-- Page 344 -->

int mc Cntl Get Run T ime(
MINST ANCE m Inst, double *time);
int mc Cntl Get Run T ime(MINST ANCE m Inst, double *time)
<font color="green">// Get the control run time in seconds.</font>
MINST ANCE m Inst = 0; double time;
int rc = mc Cntl Get Run T ime(m Inst, &time); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 345 -->

mc Cntl Get Spindle Speed
C/C++ Syntax:
mc Cntl Set Spindle Speed(
MINSTANCE m Inst,
double secs);

Notes: Not used at this time
## END_FUNTION


<!-- Page 346 -->

int mc Cntl Get State(
MINST ANCE m Inst, mc State *state);
mc State, rc = mc.mc Cntl Get State(
MINST ANCE m Inst)
<font color="green">// Get the state of controller instance 0.</font>
MINST ANCE m Inst = 0; mc State state;
char state Name[8 0]; int rc = <font color="blue">mc Cntl Get State(m Inst,
```
&state)</font>; if (rc == MERROR_NOERROR) {
<font color="green">// Success!</font> rc =
```
mc Cntl Get State Name(m Inst, state, state Name, sizeof(state Name)); }


<!-- Page 347 -->

int mc Cntl Get State Name(
MINST ANCE m Inst, mc State state, char *buf, size_t buf Size);
buf, rc = mc.mc Cntl Get State Name(
number m Inst, number state)
<font color="green">// Get the state name for controller instance 0.</font>
MINST ANCE m Inst = 0;
mc State state;
char state Name[8 0];
```
int rc = mc Cntl Get State(m Inst, &state); if (rc == MERROR_NOERROR) {
<font color="green">// Success!</font> rc = <font
color="blue">mc Cntl Get State Name(m Inst, state, state Name,
```
sizeof(state Name))</font>; }


<!-- Page 348 -->

int mc Cntl Get Stats(
MINST ANCE m Inst, mstats_t *stats);
N/A
```
struct mstats {
int cannon_buf_depth; int la_cannon_buf_depth; double total T ime;
double session T ime; double spindle T ime; long m 3 count; long m 4 count;
long m 6 count; double x Distance; double y Distance; double z Distance;
```
double a Distance; double b Distance; double c Distance; };
```
typedef struct mstats mstats_t;
<font color="green">// Get controller statistics.</font> MINST ANCE m Inst
= 0; mstats_t stats;
```
int rc = mc Cntl Get Stats(m Inst, &stats); if (rc == MERROR_NOERROR) {
```
printf("M 3 count = %dn", stats.m 3 Count); }


<!-- Page 349 -->

int mc Cntl Get T ool Of fset(
MINST ANCE m Inst, int axis Id, double *of fset);
offset, rc = mc.mc Cntl Get T ool Of fset(
number m Inst, number axis Id)
int m Inst=0;
int toolnum = 5; double val = 0; mc Cntl Get T ool Of fset(m Inst, Z_AXIS,
&val); <font color="green">// Get the tool of fset distance for the Z axis..
</font>


<!-- Page 350 -->

int mc Cntl Get Units Current(
MINST ANCE m Inst, int *units);
units, rc = mc.mc Cntl Get Units Current(
number m Inst)
<font color="green">// Get the current machine units.</font>
MINST ANCE m Inst = 0;
int units;
int rc = mc Cntl Get Units Current(m Inst, &units); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 351 -->

int mc Cntl Get Units Default(
MINST ANCE m Inst, int *units);
units, rc = mc.mc Cntl Get Units Default(
number m Inst)
<font color="green">// Get the default machine units.</font> MINST ANCE
m Inst = 0;
int units;
int rc = mc Cntl Get Units Default(m Inst, &units); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 352 -->

int mc Cntl Get V alue(
MINST ANCE m Inst, int val Id, int param, double *value);
value, rc = mc.mc Cntl Get V alue(
number m Inst, number val Id, number param)
int m Inst = 0;
int motor = 1;
double value = 0;
<font color="green">// Get the motor velocity of motor 1.</font> int rc =
mc Cntl Get V alue(m Inst, V AL_MOT OR_VEL, motor , &value);


<!-- Page 353 -->

int mc Cntl Get V ersion(
MINST ANCE m Inst, char *buf, size_t buf Size);
buf, rc = mc.mc Cntl Get V ersion(
number m Inst)
<font color="green">// Get the core version string.</font> MINST ANCE
m Inst = 0; char ver[8 0];
int rc = mc Cntl Get V ersion(m Inst, ver , sizeof(ver)): if (rc ==
```
MERROR_NOERROR) {
```
printf("The core version is %sn", ver); }


<!-- Page 354 -->

int mc Cntl Is Still(
MINST ANCE m Inst, BOOL *still);
still, rc = mc.mc Cntl Is Still(
number m Inst)
<font color="green">// See if the control axes are still.</font>
MINST ANCE m Inst = 0;
BOOL still;
```
int rc = mc Cntl Is Still(m Inst, &still); if (rc == MERROR_NOERROR) {
```
if (still == TRUE) {
```
<font color="green">// All axes are still.</font> } else {
```
<font color="green">// At least one axis is moving!</font> }
```
}


<!-- Page 355 -->

int mc Cntl Machine State Clear(
MINST ANCE m Inst);
rc = mc.mc Cntl Machine State Clear(
number m Inst)
```
<font color="green">-- LUA example</font> function test()
```
local inst = mc.mc Get Instance(); <font color="green">-- push control
state to the stack.</font> mc.mc Cntl Machine State Push(inst); <font
color="green">-- put machine in G 2 0, and G 9 0 mode.</font>
mc.mc Cntl Gcode Execute W ait(inst, "G 2 0n G 9 0"); <font color="green">--
push control state to the stack.</font> mc.mc Cntl Machine State Push(inst);
<font color="green">-- put machine in G 2 1, and G 9 1 mode.</font>
mc.mc Cntl Gcode Execute W ait(inst, "G 2 1n G 9 1"); <font color="green">--
clear the machine state stack and leave the machine in G 2 1 and G 9 1 modes.
</font> mc.mc Cntl Machine State Clear(inst); end


<!-- Page 356 -->

int mc Cntl Machine State Pop(
MINST ANCE m Inst);
rc = mc.mc Cntl Machine State Pop(
number m Inst)
```
<font color="green">-- LUA example</font> function test()
```
<font color="green">-- LUA example</font> function test()
```
local inst = mc.mc Get Instance(); <font color="green">-- push control
state to the stack saving original modes.</font>
mc.mc Cntl Machine State Push(inst); <font color="green">-- put machine in
G 2 0, and G 9 0 mode.</font> mc.mc Cntl Gcode Execute W ait(inst,
"G 2 0n G 9 0"); <font color="green">-- push control state to the stack.</font>
mc.mc Cntl Machine State Push(inst); <font color="green">-- put machine in
G 2 1, and G 9 1 mode.</font> mc.mc Cntl Gcode Execute W ait(inst,
"G 2 1n G 9 1"); <font color="green">-- restore the machine state stack to G 2 0
and G 9 0 modes.</font> mc.mc Cntl Machine State Pop(inst); <font
color="green">-- restore the machine state stack to original modes.</font>
mc.mc Cntl Machine State Pop(inst); end


<!-- Page 357 -->

int mc Cntl Machine State Push(
MINST ANCE m Inst);
rc = mc.mc Cntl Machine State Push(
number m Inst)
```
<font color="green">-- LUA example</font> function test()
```
local inst = mc.mc Get Instance(); <font color="green">-- push control
state to the stack saving original modes.</font>
mc.mc Cntl Machine State Push(inst); <font color="green">-- put machine in
G 2 0, and G 9 0 mode.</font> mc.mc Cntl Gcode Execute W ait(inst,
"G 2 0n G 9 0"); <font color="green">-- push control state to the stack.</font>
mc.mc Cntl Machine State Push(inst); <font color="green">-- put machine in
G 2 1, and G 9 1 mode.</font> mc.mc Cntl Gcode Execute W ait(inst,
"G 2 1n G 9 1"); <font color="green">-- restore the machine state stack to G 2 0
and G 9 0 modes.</font> mc.mc Cntl Machine State Pop(inst); <font
color="green">-- restore the machine state stack to original modes.</font>
mc.mc Cntl Machine State Pop(inst); end


<!-- Page 358 -->

int mc Cntl Macro Alarm(
```
MINST ANCE m Inst int error , const char *message);
rc = mc.mc Cntl Macro Alarm(
number m Inst number error string message)
```
<font color="green">-- LUA example</font> function test()
```
local inst = mc.mc Get Instance(); mc.mc Cntl Macro Alarm(inst, 1 9, "T est
Alram") end


<!-- Page 359 -->

int mc Cntl Macro Stop(
```
MINST ANCE m Inst int error , const char *message);
rc = mc.mc Cntl Macro Stop(
number m Inst number error string message)
```
<font color="green">-- LUA example</font> function test()
```
local inst = mc.mc Get Instance(); mc.mc Cntl Macro Stop(inst, 1 9, "T est
Stop") end


<!-- Page 360 -->

int mc Cntl Mdi Execute(
```
MINST ANCE m Inst, const char *commands);
rc = mc.mc Cntl Mdi Execute(
number m Inst, string commands)
MINST ANCE m Inst = 0;
int rc;
<font color="green">// Move the machine back to xy then z zero.</font>
<font color="green">// Correct example.</font> rc =
mc Cntl Mdi Execute(m Inst, "G 0 0 G 9 0 X 0.0 Y 0.0\n Z 0.0");
<font color="green">// Incorrect example.</font> rc =
mc Cntl Mdi Execute(m Inst, "G 0 0 G 9 0 X 0.0 Y 0.0"); rc =
mc Cntl Mdi Execute(m Inst, "Z 0.0");


<!-- Page 361 -->

mc Cntl Plugin Config
C/C++ Syntax:

LUA Syntax:

Description:

Parameters:
Parameter Description
m Inst The controller instance.

Returns:
Return Code Description
MERROR_NOERROR No Error .
MERROR_INV ALID_INST ANCEThe m Inst
parameter was out
of range.
Notes:
Usage:
//
MINSTANCE m Inst = 0;


<!-- Page 362 -->

mc Cntl Plugin Diag
C/C++ Syntax:

LUA Syntax:

Description:

Parameters:
Parameter Description
m Inst The controller instance.

Returns:
Return Code Description
MERROR_NOERROR No Error .
MERROR_INV ALID_INST ANCEThe m Inst
parameter was out
of range.
Notes:
Usage:
//
MINSTANCE m Inst = 0;


<!-- Page 363 -->

int mc Cntl Probe File Close(
MINST ANCE m Inst);
rc = mc.mc Cntl Probe File Close(
number m Inst)
<font color="green">-- probe file close LUA macro example.</font>
```
function m 1 1 2()
```
local inst=mc.mc Get Instance(); local rc =
mc.mc Cntl Probe File Close(inst); end

```
if (mc.mc In Editor() == 1) then m 1 1 2() end


<!-- Page 364 -->

int mc Cntl Probe File Open(
```
MINST ANCE m Inst, const char *file Name, const char *format, BOOL
over W rite);
rc = mc.mc Cntl Probe File Open(
number m Inst, string file Name, string format, number over W rite);
<font color="green">-- probe file open LUA macro example.</font>
```
function m 1 1 1()
```
local inst = mc.mc Get Instance(); local rc =
mc.mc Cntl Probe File Open(inst, 'probetest.csv', '%.4 AXIS_X, %.4 AXIS_Y ,
%.4 AXIS_Z\r\n', TRUE); end

```
if (mc.mc In Editor() == 1) then m 1 1 1() end


<!-- Page 365 -->

int mc Cntl Probe Get Strike Status(
MINST ANCE m Inst, BOOL *did Strike);
didstrike, rc = mc.mc Cntl Probe Get Strike Status(
number m Inst)
<font color="green">-- probe get strike status example.</font>
```
local inst = mc.mc Get Instance()
local did Strike, rc = mc.mc Cntl Probe Get Strike Status(inst)


<!-- Page 366 -->

int mc Cntl Set Coolant Delay(
MINST ANCE m Inst, double secs);
rc = mc.mc Cntl Set Coolant Delay(
number m Inst, number secs);
<font color="green">// Set 3/4 second coolant delay .</font> MINST ANCE
m Inst = 0;
int rc = mc Cntl Set Coolant Delay(m Inst, .7 5 0);


<!-- Page 367 -->

int mc Cntl Set Dia Mode(
MINST ANCE m Inst, BOOL enable);
rc = mc.mc Cntl Set Dia Mode(
number m Inst, number enable);
<font color="green">// Enable diamter mode</font> MINST ANCE m Inst =
0; int rc = mc Cntl Set Dia Mode(m Inst, TRUE);


<!-- Page 368 -->

int mc Cntl Set Mist Delay(
MINST ANCE m Inst, double secs);
rc = mc.mc Cntl Set Mist Delay(
number m Inst, number secs);
<font color="green">// Set the mist delay to 3/4 of a second.</font>
MINST ANCE m Inst = 0;
int rc = mc Cntl Set Mist Delay(m Inst, .7 5 0);


<!-- Page 369 -->

int mc Cntl Set Mode(
MINST ANCE m Inst, double mode);
rc = mc.mc Cntl Set Mode(
number m Inst, number mode)
<font color="green">// Set the interpreter mode to Lathe Diameter .</font>
MINST ANCE m Inst = 0; int rc = mc Cntl Set Mode(m Inst,
MC_MODE_LA THE_DIA);


<!-- Page 370 -->

mc Cntl Set Pound V ar(
MINST ANCE m Inst, int param, double value);
mc Cntl Set Pound V ar(
number m Inst, number param, number value)
MINST ANCE m Inst = 0; int Pound V ar = 5 0;
dobule V alue=2 1;
<font color="green">// Set the value of #5 0 to 2 1.</font> int rc =
mc Cntl Set Pound V ar(m Inst, Pound V ar, Value);


<!-- Page 371 -->

int mc Cntl Set Stats(
MINST ANCE m Inst, mstats_t *stats);
N/A
<font color="green">// </font> MINST ANCE m Inst = 0;


<!-- Page 372 -->

int mc Cntl Set V alue(
MINST ANCE m Inst, int val Id, int param, double value);
rc = mc.mc Cntl Set V alue(
number m Inst, number val Id, number param, number value)
MINST ANCE m Inst = 0; int motor = 1;
value=1 0 0 0.0;
<font color="green">// Set the V elocity of the motor to 1 0 0 0.0 .</font> in
rc = mc Cntl Set V alue(m Inst, V AL_MOT OR_VEL, motor , value);


<!-- Page 373 -->

int mc File Hold Aquire(
```
MINST ANCE m Inst, const char *reason, int Jog Axis Bits);
rc = mc.mc File Hold Aquire(
number m Inst, string reason, number Jog Axis Bits)
<font color="green">-- LUA example</font> local inst =
```
mc.mc Get Instance();
local rc = mc.mc File Hold Aquire(inst, "My hold reason", 0);


<!-- Page 374 -->

int mc File Hold Reason(
MINST ANCE m Inst, char *buf, long buf Size);
reason, rc = mc.mc File Hold Reason(
number m Inst)
<font color="green">-- LUA example</font> local inst =
```
mc.mc Get Instance(); local rc = mc.mc File Hold Aquire(inst, "My hold
reason", 0); loacl reason
reason, rc = mc.mc File Hold Reason(inst);


<!-- Page 375 -->

int mc File Hold Release(
MINST ANCE m Inst);
rc = mc.mc File Hold Release(
number m Inst)
<font color="green">-- LUA example</font> local inst =
```
mc.mc Get Instance(); local rc = mc.mc File Hold Aquire(inst, "My hold
reason", 0); loacl reason
reason, rc = mc.mc File Hold Reason(inst); <font color="green">-- Do some
script magic...</font> rc = mc.mc File Hold Release(inst); <font
color="green">-- G code processing resumes.</font>


<!-- Page 376 -->

Gcode File

mc Cntl Get Gcode Line
mc Cntl Get Gcode Line Count
mc Cntl Get Gcode Line Nbr
mc Cntl Rewind File
mc Cntl Set Gcode Line Nbr
mc Cntl Load Gcode File
mc Cntl Load Gcode String
mc Cntl Close Gcode File
mc Cntl Get Gcode File Name


<!-- Page 377 -->

int mc Cntl Get Gcode Line(
MINST ANCE m Inst, int Line Number , char *buf, long buf Size);
buff, rc = mc.mc Cntl Get Gcode Line(
number m Inst, number Line Number)
int m Inst=0;
int Line Number = 5; char gline[1 2 8];
gline[0] = '0';
mc Cntl Get Gcode Line(m Inst, Line Number , gline , 1 2 8); <font
color="green">// Get line number 5 from the Gocde file loaded into
controller 0.</font>


<!-- Page 378 -->

int mc Cntl Get Gcode Line Count(
MINST ANCE m Inst, double *count);
count, rc = mc.mc Cntl Get Gcode Line Count(
number m Inst)
int m Inst=0;
double count=0; mc Cntl Get Gcode Line Count(m Inst, &count);


<!-- Page 379 -->

int mc Cntl Get Gcode Line Nbr(
MINST ANCE m Inst, double *val);
val, rc = mc.mc Cntl Get Gcode Line Nbr(
number m Inst)
int m Inst=0;
double dline=0; mc Cntl Get Gcode Line Nbr(m Inst, &dline); <font
color="green">//Get the current running line number</font>


<!-- Page 380 -->

int mc Cntl Rewind File(
MINST ANCE m Inst);
rc = mc.mc Cntl Rewind File(
number m Inst)
MINST ANCE m Inst = 0; mc Cntl Rewind File(m Inst); <font
color="green">// Rewind controller 0's Gcode file.</font>


<!-- Page 381 -->

int mc Cntl Set Gcode Line Nbr(
MINST ANCE m Inst, double line);
int m Inst=0; mc Cntl Set Gcode Line Nbr(m Inst, 1 0); <font color="green">//
Set the Gcode file to be at line 1 0.</font>


<!-- Page 382 -->

int mc Cntl Load Gcode File(
```
MINST ANCE m Inst, const char *File T o Load);
rc = mc.mc Cntl Load Gcode File(
number m Inst, string File T o Load)
int m Inst=0;
char File[1 2 8] = "C:Some Gocdefile.tap"; int rc =
mc Cntl Load Gcode File(m Inst, &char); <font color="green">// Load
```
Some Gocdefile.tap file.</font> if (rc == MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 383 -->

int mc Cntl Load Gcode String(
```
MINST ANCE m Inst, const char *g Code);
rc = mc.mc Cntl Load Gcode String(
```
MINST ANCE m Inst, const char *g Code);
<font color="green">// Load G code from a string.</font> MINST ANCE
m Inst = 0;
char *g Code = "%n O 1 0 0 1n G 9 0 G 9 4 G 9 1.1 G 4 0 G 4 9 G 1 7n G 2 0"
int rc = mc Cntl Load Gcode String(m Inst, g Code);


<!-- Page 384 -->

int mc Cntl Close GCode File(
MINST ANCE m Inst);
rc = mc.mc Cntl Close GCode File(
number m Inst)
int m Inst=0;
mc Cntl Close GCode File(m Inst); <font color="green">// Close the Gcode
file in controller 0.</font>


<!-- Page 385 -->

int mc Cntl Get Gcode File Name(
MINST ANCE m Inst, char *buf, size_t buf Size);
buf, rc = mc.mc Cntl Get Gcode File Name(
number m Inst)
<font color="green">// Get the currently loaded G code file name.</font>
MINST ANCE m Inst = 0;
char g Code File Name[2 5 5];
int rc = mc Cntl Get Gcode File Name(m Inst, g Code File Name,
```
sizeof(g Code File Name)); if (rc == MERROR_NOERROR) {
```
<font color="green">// Success.</font> }


<!-- Page 386 -->

T ools

mc Tool Get Current
mc Tool Get Data
mc Tool Get Data Ex Dbl
mc Tool Get Data Ex Int
mc Tool Get Data Ex Str
mc Tool Get Desc
mc Tool Get Selected
mc Tool Load File
mc Tool Save File
mc Tool Set Current
mc Tool Set Data
mc Tool Set Data Ex Dbl
mc Tool Set Data Ex Int
mc Tool Set Data Ex Str
mc Tool Set Desc


<!-- Page 387 -->

int mc T ool Get Current(
MINST ANCE m Inst, int *toolnum);
toolnum, rc = mc.mc T ool Get Current(
number m Inst)
<font color="green">// Get the current tool.</font> MINST ANCE m Inst =
0; int toolnum = 0;
int rc = mc T ool Get Current(m Inst, &toolnum);


<!-- Page 388 -->

int mc T ool Get Data(
MINST ANCE m Inst, int type, int tool Number , double *value);
value, rc = mc.mc T ool Get Data(
number m Inst, number type, number tool Number)
MINST ANCE m Inst = 0; int toolnum = 5;
double val = 0;
<font color="green">// Get the tool height of fset for tool number 5.</font>
int rc = mc T ool Get Data(m Inst, MT OOL_MILL_HEIGHT , toolnum, &val);


<!-- Page 389 -->

int mc T ool Get Data Ex Dbl(
```
MINST ANCE m Inst, int toolnum, const char *field Name, double
*value);
value, rc = mc.mc T ool Get Data Ex Dbl(
number m Inst, number tool Number , string field Name)
MINST ANCE m Inst = 0;
int toolnum = 5;
double val = 0;
<font color="green">// Get the contents of "My User Field" for tool number
5.</font> int rc = mc T ool Get Data Ex Dbl(m Inst, toolnum, "My User Field",
&val);


<!-- Page 390 -->

int mc T ool Get Data Ex Int(
```
MINST ANCE m Inst, int toolnum, const char *field Name, int *value);
value, rc = mc.mc T ool Get Data Ex Int(
number m Inst, number tool Number , string field Name)
MINST ANCE m Inst = 0;
int toolnum = 5;
int val = 0;
<font color="green">// Get the contents of "My User Field" for tool number
5.</font> int rc = mc T ool Get Data Ex Int(m Inst, toolnum, "My User Field",
&val);


<!-- Page 391 -->

int mc T ool Get Data Ex Str(
```
MINST ANCE m Inst, int toolnum, const char *field Name, char *value,
size_t value Len);
value, rc = mc.mc T ool Get Data Ex Str(
number m Inst, number tool Number , string field Name)
MINST ANCE m Inst = 0;
int toolnum = 5;
char val[1 2 8];
<font color="green">// Get the contents of "My User Field" for tool number
5.</font> int rc = mc T ool Get Data Ex Str(m Inst, toolnum, "My User Field",
val, sizeof(val));


<!-- Page 392 -->

int mc T ool Get Desc(
MINST ANCE m Inst, int toolnum, char *buf f, size_t bufsize);
buff, rc = mc.mc T ool Get Desc(
number m Inst, number toolnum)
MINST ANCE m Inst = 0; char desc[1 2 8];
int toolnum = 5;
<font color="green">// Get the description of tool number 5 for controller
0.</font> int rc = mc T ool Get Desc(m Inst, toolnum, desc, sizeof(desc));


<!-- Page 393 -->

int mc T ool Get Selected(
MINST ANCE m Inst, int *toolnum);
toolnum, rc = mc.mc T ool Get Selected(
number m Inst)
<font color="green">// Get the selected tool number .</font> MINST ANCE
m Inst = 0;
int toolnum = 0;
int rc = mc T ool Get Selected(m Inst, &toolnum);


<!-- Page 394 -->

int mc T ool Load File(
```
MINST ANCE m Inst, const char *File T o Load);
rc = mc.mc T ool Load File(
number m Inst, string File T o Load)
<font color="green">// Load a tool table.</font> MINST ANCE m Inst = 0;
int rc = mc T ool Load File(m Inst, "tooltable.tls");


<!-- Page 395 -->

int mc T ool Save File(
MINST ANCE m Inst);
rc = mc T ool Save File(
number m Inst)
<font color="green">// Save the previously loaded tool table file.</font>
MINST ANCE m Inst = 0; int rc = mc T ool Save File(m Inst);


<!-- Page 396 -->

int mc T ool Set Current(
MINST ANCE m Inst, int toolnum);
rc = mc.mc T ool Set Current(
number m Inst, number toolnum)
<font color="green">// Set the current tool to tool #1.</font> MINST ANCE
m Inst = 0; int rc = mc T ool Set Current(m Inst, 1);


<!-- Page 397 -->

int mc T ool Set Data(
MINST ANCE m Inst, int T ype, int T oolnumber , double val);
rc = mc.mc T ool Set Data(
number m Inst, number T ype, number T oolnumber , number val);
MINST ANCE m Inst = 0; int toolnum = 5;
double val = 0;
<font color="green">// Set the tool height wear of fset to zero.</font> int rc
= mc T ool Set Data(m Inst, MT OOL_MILL_HEIGHT_W , toolnum, val);


<!-- Page 398 -->

int mc T ool Set Data Ex Dbl(
```
MINST ANCE m Inst, int tool Num, const char *field Name, double value);
rc = mc.mc T ool Set Data Ex Dbl(
number m Inst, number tool Num, string field Name, number val);
MINST ANCE m Inst = 0;
int toolnum = 5;
double val = 0;
<font color="green">// Set the user field "My User Field" to zero.</font> int
rc = mc T ool Set Data Ex Dbl(m Inst, toolnum, "My User Field", val);


<!-- Page 399 -->

int mc T ool Set Data Ex Int(
```
MINST ANCE m Inst, int tool Num, const char *field Name, int value);
rc = mc.mc T ool Set Data Ex Int(
number m Inst, number tool Num, string field Name, number val);
MINST ANCE m Inst = 0;
int toolnum = 5;
int val = 0;
<font color="green">// Set the user field "My User Field" to zero.</font> int
rc = mc T ool Set Data Ex Int(m Inst, toolnum, "My User Field", val);


<!-- Page 400 -->

int mc T ool Set Data Ex Str(
```
MINST ANCE m Inst, int tool Num, const char *field Name, const char
*value);
rc = mc.mc T ool Set Data Ex Str(
number m Inst, number tool Num, string field Name, string val);
MINST ANCE m Inst = 0;
int toolnum = 5;
char val[1 2 8];
<font color="green">// Set the user field "My User Field" to zero.</font>
strcpy(val, "0");
int rc = mc T ool Set Data Ex Str(m Inst, toolnum, "My User Field", val);


<!-- Page 401 -->

int mc T ool Set Desc(
```
MINST ANCE m Inst, int toolnum, const char *tdsc);
rc = mc.mc T ool Set Desc(
number m Inst, number toolnum, string tdsc);
MINST ANCE m Inst = 0;
char desc[1 2 8] = "My Best 1/2 inch endmill"; int toolnum = 5;
<font color="green">// Set the description of tool number 5.</font> int rc =
mc Tool Set Desc(m Inst, toolnum, desc);


<!-- Page 402 -->

Jogging

mc Jog Abs Start
mc Jog Abs Stop
mc Jog Get Accel
mc Jog Get Feed Rate
mc Jog Get Follow Mode
mc Jog Get Inc
mc Jog Get Rate
mc Jog Get Units Mode
mc Jog Get V elocity
mc Jog Inc Start
mc Jog Inc Stop
mc Jog Is Jogging
mc Jog Is Stopping
mc Jog Set Accel
mc Jog Set Feed Rate
mc Jog Set Follow Mode
mc Jog Set Inc
mc Jog Set Rate
mc Jog Set T race Enable
mc Jog Set T ype
mc Jog Set Units Mode
mc Jog V elocity Start
mc Jog V elocity Stop


<!-- Page 403 -->

int mc Jog Abs Start(
MINST ANCE m Inst, int axis Id, double pos);
rc = mc.mc Jog Abs Start(
number m Inst, number axis Id, number pos)
MINST ANCE m Inst = 0;
int axis = Z_AXIS;
double Jog T o Pos = 5.0; <font color="green">// Jog controller 0 to position
5.0 in the Z axis.</font> mc Jog Abs Start(m Inst, axis, Jogpos);


<!-- Page 404 -->

int mc Jog Abs Stop(
MINST ANCE m Inst, int axis Id, double incr);
rc = mc.mc Jog Abs Stop(
number m Inst, number axis Id, number incr)
<font color="green">// Stop the incremental jog on the Z axis.</font>
MINST ANCE m Inst = 0; int axis = Z_AXIS;
double Joginc = .1 0 0; int rc = mc Jog Abs Stop(m Inst, axis, Joginc);


<!-- Page 405 -->

int mc Jog Get Accel(
MINST ANCE m Inst, int axis Id, double *percent);
percent, rc = mc.mc Jog Get Accel(
number m Inst, number axis)
<font color="green">// Get the jog accel percentage for the X axis.</font>
MINST ANCE m Inst = 0;
double accel;
int rc = mc Jog Get Accel(m Inst, X_AXIS, &accel);


<!-- Page 406 -->

int mc Jog Get Fee Rate(
MINST ANCE m Inst, int axis Id, double *feed Rate);
feed Rate, rc = mc.mc Jog Set Feed Rate(
number m Inst, number axis Id)
<font color="green">// Set the jog rate to 7 5% of the Z axis maximum
velocity .</font> MINST ANCE m Inst = 0;
int axis = Z_AXIS;
double feed Rate = 0.0;
int rc = mc Jog Set Units Mode(m Inst, axis, MC_UNITS_INCH); rc =
mc Jog Set Feed Rate(m Inst, axis, &feed Rate); <font color="green">// Get the
feed rate in inches per minute.</font>


<!-- Page 407 -->

mc Jog Get Follow Mode(
MINST ANCE m Inst, double *mode_on);
int m Inst=0;
double jfstat=0; mc Jog Get Follow Mode(m Inst, &jfstate);


<!-- Page 408 -->

int mc Jog Get Inc(
MINST ANCE m Inst, int axis Id, double *increment);
increment, rc = mc.mc Jog Get Inc(
number m Inst, number axis Id)
<font color="green">// </font> MINST ANCE m Inst = 0;


<!-- Page 409 -->

int mc Jog Get Rate(
MINST ANCE m Inst, int axis Id, double *percent);
percent, rc = mc.mc Jog Get Rate(
number m Inst, number axis Id)
<font color="green">// Get the current jog rate for the X axis</font>
MINST ANCE m Inst = 0;
double jog Rate;
int rc = mc Jog Get Rate(m Inst, X_AXIS, &jog Rate);


<!-- Page 410 -->

int mc Jog Get T race Enable(MINST ANCE m Inst, BOOL *enable);
enable, rc = mc.mc Jog Get T race Enable(number m Inst)
<font color="green">// Get jog trace enable status.</font> MINST ANCE
m Inst = 0;
int enabled = MC_F ALSE; int rc = mc Jog Get T race Enable(m Inst,
&enabled);


<!-- Page 411 -->

int mc Jog Get T ype(MINST ANCE m Inst, int axis Id, int *type);
type, rc = mc.mc Jog Get T ype(
number m Inst, number axis Id)
<font color="green">// Get the X axis jog type. </font> MINST ANCE
m Inst = 0;
int type = 0;
int rc = mc Jog Get T ype(m Inst, X_AXIS, &type);


<!-- Page 412 -->

mc Jog Get Units Mode(
MINST ANCE m Inst, int axis Id, int *mode);
int m Inst = 0; int mode = 0; mc Jog Get Units Mode(m Inst, X_AXIS,
&mode);


<!-- Page 413 -->

int mc Jog Get V elocity(
MINST ANCE m Inst, int axis Id, double *vel);
vel, rc = mc.mc Jog Get V elocity(
number m Inst, number axis Id),
<font color="green">// Get the current jog velocity setting for the X
axis</font> MINST ANCE m Inst = 0; double jog V el;
int rc = mc Jog Get V elocity(m Inst, X_AXIS, &jog V el);


<!-- Page 414 -->

int mc Jog Inc Start(
MINST ANCE m Inst, int axis Id, double dist);
rc = mc.mc Jog Inc Start(
number m Inst, number axis Id, number dist)
MINST ANCE m Inst = 0; int axis = Z_AXIS;
double Joginc = .1 0 0; <font color="green">// Jog controller 0 .1 in the Z
axis.</font> mc Jog Inc Start(m Inst, axis, Joginc);


<!-- Page 415 -->

int mc Jog Inc Stop(
MINST ANCE m Inst, int axis Id, double incr);
rc = mc.mc Jog Inc Stop(
number m Inst, number axis Id, number incr)
<font color="green">// Stop the incremental jog on the Z axis.</font>
MINST ANCE m Inst = 0; int axis = Z_AXIS;
double Joginc = .1 0 0; int rc = mc Jog Inc Stop(m Inst, axis, Joginc);


<!-- Page 416 -->

int mc Jog Is Jogging(
MINST ANCE m Inst, int axis Id, BOOL *jogging);
jogging, rc = mc.mc Jog Is Jogging(
number m Inst, number axis Id)
<font color="green">// See if the X axis is jogging.</font> MINST ANCE
m Inst = 0;
BOOL jogging = F ALSE;
int rc = mc Jog Is Jogging(m Inst, X_AXIS, &jogging);


<!-- Page 417 -->

int mc Jog Is Stopping(
MINST ANCE m Inst, int axis Id, BOOL *stopping);
stopping, rc = mc.mc Jog Is Stopping(
number m Inst, number axis Id)
<font color="green">// See if the X axis is stopping.</font> MINST ANCE
m Inst = 0;
BOOL stopping = F ALSE;
int rc = mc Jog Is Stopping(m Inst, X_AXIS, &stopping);


<!-- Page 418 -->

int mc Jog Set Accel(
MINST ANCE m Inst, int axis Id, double percent);
rc = mc.mc Jog Set Accel(
number m Inst, number axis Id, double percent)
<font color="green">// Set the X axis jog accel percentage to 7 5%.</font>
MINST ANCE m Inst = 0;
int mc Jog Set Accel(m Inst, X_AXIS, 7 5);


<!-- Page 419 -->

int mc Jog Set Fee Rate(
MINST ANCE m Inst, int axis Id, double feed Rate);
rc = mc.mc Jog Set Feed Rate(
number m Inst, number axis Id, number feed Rate)
<font color="green">// Set the jog rate to 7 5% of the Z axis maximum
velocity .</font> MINST ANCE m Inst = 0;
int axis = Z_AXIS;
int rc = mc Jog Set Units Mode(m Inst, axis, MC_UNITS_INCH); rc =
mc Jog Set Feed Rate(m Inst, axis, 2 0); <font color="green">// 2 0 inches per
minute.</font>


<!-- Page 420 -->

mc Jog Set Follow Mode(
MINST ANCE m Inst, double mode_on);
int m Inst=0; mc Jog Get Follow Mode(m Inst, MC_ON);


<!-- Page 421 -->

int mc Jog Set Inc(
MINST ANCE m Inst, int axis Id, double increment);
rc = mc.mc Jog Set Inc(
number m Inst, number axis Id, number increment)
<font color="green">// Set the X axis jog increment to .0 1 0"</font>
MINST ANCE m Inst = 0;
int rc = mc Jog Set Inc(m Inst, X_AXIS, .0 1 0);


<!-- Page 422 -->

int mc Jog Set Rate(
MINST ANCE m Inst, int axis Id, double percent);
rc = mc.mc Jog Set Rate(
number m Inst, number axis Id, number percent)
<font color="green">// Set the jog rate to 7 5% of the Z axis maximum
velocity .</font> MINST ANCE m Inst = 0; int axis = Z_AXIS;
int rc = mc Jog Set Rate(m Inst, axis, 7 5);


<!-- Page 423 -->

int mc Jog Set T race Enable(
MINST ANCE m Inst, BOOL enable);
rc = mc.mc Jog Set T race Enable(
number m Inst, number enable)
<font color="green">//Set jog tracing.</font> MINST ANCE m Inst = 0;
int rc = mc Jog Set T race Enable(m Inst, MC_TRUE);


<!-- Page 424 -->

int mc Jog Set T ype(MINST ANCE m Inst, int axis Id, int type);
rc = mc.mc Jog Set T ype(
number m Inst, number axis Id, number type)
<font color="green">// Set the X axis jog type to velocity mode. </font>
MINST ANCE m Inst = 0;
int rc = mc Jog Set T ype(m Inst, X_AXIS, MC_JOG_TYPE_VEL);


<!-- Page 425 -->

mc Jog Set Units Mode(
MINST ANCE m Inst, int axis Id, int mode);
int m Inst = 0;
mc Jog Set Units Mode(m Inst, X_AXIS, MC_UNITS_INCH);


<!-- Page 426 -->

int mc Jog V elocity Start(
MINST ANCE m Inst, int axis Id, double dir);
rc = mc.mc Jog V elocity Start(
number m Inst, number axis Id, number dir);
int m Inst=0;
int axis = Z_AXIS;
int rc = mc Jog V elocity Start(m Inst, axis, MC_JOG_POS); <font
color="green">// Start Z axis jogging for 5 sec.</font> if (rc ==
```
MERROR_NOERROR) {
```
Sleep(5 0 0 0); }
rc = mc Jog V elocity Start(m Inst, axis, MC_JOG_POS); <font
color="green">// Reverse axis and jog the axis Back.</font> if (rc ==
```
MERROR_NOERROR) {
```
Sleep(5 0 0 0); }
mc Jog V elocity Stop(m Inst, axis); <font color="green">// Stop the axis.
</font>


<!-- Page 427 -->

mc Jog V elocity Stop(
MINST ANCE m Inst, int axis Id);
mc Jog V elocity Stop(
number m Inst, number axis Id)
MINST ANCE m Inst = 0; int axis = Z_AXIS;
int rc;
<font color="green">// Jog axis at 1 0 % max velocity .</font> rc =
mc Jog Set Rate(m Inst, axis, 1 0); rc = mc Jog V elocity Start(m Inst, axis,
```
MC_JOG_POS); if (rc == MERROR_NOERROR) {
```
Sleep(5 0 0 0); }
<font color="green">// Stop the axis.</font> rc =
mc Jog V elocity Stop(m Inst, axis);


<!-- Page 428 -->

MPGs

mc Mpg Get Accel
mc Mpg Get Axis
mc Mpg Get Counts Per Detent
mc Mpg Get Enable
mc Mpg Get Encoder Reg
mc Mpg Get Inc
mc Mpg Get Reversed
mc Mpg Get Rate
mc Mpg Get Shuttle Mode
mc Mpg Get Shuttle Percent
mc Mpg Move Counts
mc Mpg Set Accel
mc Mpg Set Axis
mc Mpg Set Counts Per Detent
mc Mpg Set Enable
mc Mpg Set Encoder Reg
mc Mpg Set Inc
mc Mpg Set Reversed
mc Mpg Set Rate
mc Mpg Set Shuttle Mode
mc Mpg Set Shuttle Percent


<!-- Page 429 -->

int mc Mpg Get Accel(
MINST ANCE m Inst, int mpg, double *percent Max Accel);
percent Max Accel, rc = mc.mc Mpg Get Accel(
number m Inst, number mpg)
<font color="green">// Get the current accel for MPG 0.</font>
MINST ANCE m Inst = 0;
double percent Max Accel = 0; int rc;
rc = mc Mpg Get Accel(m Inst, 0, &percent Max Accel);


<!-- Page 430 -->

int mc Mpg Get Axis(
MINST ANCE m Inst, int mpg, int *axis Id);
axis Id, rc = mc.mc Mpg Get Axis(
number m Inst, number mpg)
<font color="green">// Get the currently selected axis for MPG 0.</font>
MINST ANCE m Inst = 0; int axis Id;
int rc = mc Mpg Get Axis(m Inst, 0, &axis Id);


<!-- Page 431 -->

int mc Mpg Get Counts Per Detent(
MINST ANCE m Inst, int mpg, int *pulses);
pulses, rc = mc.mc Mpg Get Counts Per Detent(
number m Inst, number mpg)
<font color="green">// Get the counts per detent for MPG 0.</font>
MINST ANCE m Inst = 0;
int cnts;
int rc = mc Mpg Get Counts Per Detent(m Inst, 0, &cnts);


<!-- Page 432 -->

int mc Mpg Get Enable(
MINST ANCE m Inst, int mpg, BOOL *enabled);
enabled, rc = mc.mc Mpg Get Enable(
number m Inst, number mpg)
<font color="green">// Get the enabled status of MPG 0.</font>
MINST ANCE m Inst = 0;
BOOL enabled = MC_F ALSE;

int rc = mc Mpg Get Enable(m Inst, 0, &enabled);


<!-- Page 433 -->

int mc Mpg Get Encoder Reg(
MINST ANCE m Inst, int mpg, HMCREG *h Reg);
h Reg, rc = mc.mc Mpg Get Encoder Reg(
number m Inst, number mpg)
<font color="green">// Get the current encoder associated with MPG 0.
</font> MINST ANCE m Inst = 0;
HMCREG h Reg = 0;

int rc = mc Mpg Get Encoder Reg(m Inst, 0, &h Reg);


<!-- Page 434 -->

int mc Mpg Get Inc(
MINST ANCE m Inst, int mpg, double *inc);
inc, rc = mc.mc Mpg Get Inc(
number m Inst, number mpg)
<font color="green">// Get the incremnt for MPG 0.</font> MINST ANCE
m Inst = 0; double inc;
int rc = mc Mpg Get Inc(m Inst, 0, &inc);


<!-- Page 435 -->

int mc Mpg Get Reversed(
MINST ANCE m Inst, int mpg, BOOL *reversed);
reversed, rc = mc.mc Mpg Get Reversed(
number m Inst, number mpg)
<font color="green">// Get the reversed status of MPG 0.</font>
MINST ANCE m Inst = 0;
BOOL reversed = MC_F ALSE;

int rc = mc Mpg Get Reversed(m Inst, 0, &reversed);


<!-- Page 436 -->

int mc Mpg Get Rate(
MINST ANCE m Inst, int mpg, double *percent Max V el);
percent Max V el, rc = mc.mc Mpg Get Rate(
number m Inst, number mpg)
<font color="green">// Get the velocity percentage for MPG 0.</font>
MINST ANCE m Inst = 0; double vel Percent;
int rc = mc Mpg Get Rate(m Inst, 0, &vel Percent);


<!-- Page 437 -->

int mc Mpg Get Shuttle Mode(
MINST ANCE m Inst, BOOL *on);
on, rc = mc.mc Mpg Get Shuttle Mode(
number m Inst)
<font color="green">// Check the state of MPG shuttle mode.</font>
MINST ANCE m Inst = 0;
BOOL enabled = F ALSE;
int rc = mc Mpg Get Shuttle Mode(m Inst, &enabled);


<!-- Page 438 -->

int mc Mpg Get Shuttle Percent(
MINST ANCE m Inst, int mpg, double *percent);
percent, rc = mc.mc Mpg Get Shuttle Percent(
number m Inst, number mpg)
<font color="green">// Get the shuttle percentage for MPG 0.</font>
MINST ANCE m Inst = 0;
double percent;
int rc = mc Mpg Get Shuttle Percentage(m Inst, 0, &percent);


<!-- Page 439 -->

int mc Mpg Move Counts(
MINST ANCE m Inst, int mpg, int delta Counts);
rc = mc.mc Mpg Move Counts(
number m Inst, number mpg, number delta Counts)
<font color="green">// Move the MPG 0 "n" counts.</font> MINST ANCE
m Inst = 0;
int n = 1 6;
int rc = mc Mpg Move Counts(m Inst, 0, n);


<!-- Page 440 -->

int mc Mpg Set Accel(
MINST ANCE m Inst, int mpg, double percent Max Accel);
rc = mc.mc Mpg Set Accel(
number m Inst, number mpg, number percent Max Accel)
<font color="green">// Set the acceleration value for MPG 0.</font>
MINST ANCE m Inst = 0;
int rc = mc Mpg Set Accel(m Inst, 0, 2 0.5);


<!-- Page 441 -->

int mc Mpg Set Axis(
MINST ANCE m Inst, int mpg, int axis Id);
rc = mc.mc Mpg Set Axis(
number m Inst, number mpg, number axis)
<font color="green">// Set MPG 0 to move the X axis.</font>
MINST ANCE m Inst = 0; int rc = mc Mpg Set Axis(m Inst, 0, X_AXIS);


<!-- Page 442 -->

int mc Mpg Set Counts Per Detent(
MINST ANCE m Inst, int mpg, int pulses);
rc = mc.mc Mpg Set Counts Per Detent(
number m Inst, number mpg, number pulses);
<font color="green">// Set the number of counts per detent for MPG 0.
</font> MINST ANCE m Inst = 0;
int rc = mc Mpg Set Counts Per Detent(m Inst, 0, 4);


<!-- Page 443 -->

int mc Mpg Set Enable(
MINST ANCE m Inst, int mpg, BOOL enabled);
rc = mc.mc Mpg Set Enable(
number m Inst, number mpg number enabled)
<font color="green">// Set the enabled status of MPG 0.</font>
MINST ANCE m Inst = 0;
BOOL enabled = MC_F ALSE;
int rc = mc Mpg Set Enable(m Inst, 0, MC_TRUE);


<!-- Page 444 -->

int mc Mpg Set Encoder Reg(
MINST ANCE m Inst, int mpg, HMCREG h Reg);
rc = mc.mc Mpg Set Encoder Reg(
number m Inst, number mpg number h Reg)
<font color="green">// Associate an encoder with MPG 0.</font>
MINST ANCE m Inst = 0;
HMCREG h Reg = 0;


<!-- Page 445 -->

int rc
rc = mc Reg Get Handle(m Inst, "/Sim 0/Encoder 0", &h Reg); if (rc ==
```
MERROR_NOERROR) {
```
rc = mc Mpg Set Encoder Reg(m Inst, 0, h Reg); }


<!-- Page 446 -->

int mc Mpg Set Inc(
MINST ANCE m Inst, int mpg, double inc);
rc = mc.mc Mpg Set Inc(
number m Inst, number mpg, number inc);
<font color="green">// Set the increment to .0 0 1 for MPG 0.</font>
MINST ANCE m Inst = 0;
int rc = mc Mpg Set Inc(m Inst, 0, .0 0 1);


<!-- Page 447 -->

int mc Mpg Set Reversed(
MINST ANCE m Inst, int mpg, BOOL reversed);
rc = mc.mc Mpg Get Reversed(
number m Inst, number mpg number reversed)
<font color="green">// Get the reversed status of MPG 0.</font>
MINST ANCE m Inst = 0;
BOOL reversed = MC_F ALSE;
int rc = mc Mpg Set Reversed(m Inst, 0, reversed); <font color="green">//
MC_TRUE</font>


<!-- Page 448 -->

int mc Mpg Set Rate(
MINST ANCE m Inst, int mpg, double percent Max V el);
rc = mc.mc Mpg Set Rate(
number m Inst, number mpg, number percent Max V el)
<font color="green">// Set the rate for MPG 0 to 2 5.0%</font>
MINST ANCE m Inst = 0;
int rc = mc Mpg Set Rate(m Inst, 0, 2 5.0);


<!-- Page 449 -->

int mc Mpg Set Shuttle Mode(
MINST ANCE m Inst, BOOL on);
rc = mc.mc Mpg Set Shuttle Mode(
number m Inst, number on);
<font color="green">// T urn on MPG shuttle mode.</font> MINST ANCE
m Inst = 0;
int rc = mc Mpg Set Shuttle Mode(m Inst, MC_ON);


<!-- Page 450 -->

int mc Mpg Set Shuttle Percent(
MINST ANCE m Inst, int mpg, double percent);
rc = mc.mc Mpg Get Shuttle Percent(
number m Inst, number mpg number percent)
<font color="green">// Set the shuttle percentage for MPG 0.</font>
MINST ANCE m Inst = 0;
double percent = 2 0 0.5;
int rc = mc Mpg Get Shuttle Percentage(m Inst, 0, percent);


<!-- Page 451 -->

Soft Limits

mc Soft Limit Get State
mc Soft Limit Max Mins Clear
mc Soft Limit Set State


<!-- Page 452 -->

int mc Soft Limit Get State(
MINST ANCE m Inst, int axis, double *ison);
ison, rc = mc.mc Soft Limit Get State(
number m Inst, number axis)
int m Inst = 0;
int axis = Z_AXIS;
dobule Is On = 0; <font color="green">// DO_OFF to turn of f.</font>
mc Soft Limit Set State(m Inst, axis, &Is On); <font color="green">// Get the
softlimit for the Z axis return will be 1 or 0 1==on.</font>


<!-- Page 453 -->

int mc Soft Limit Set State(
MINST ANCE m Inst, int axis, int on);
rc = mc.mc Soft Limit Set State(
number m Inst, number axis, number on)
int m Inst=0;
int axis = Z_AXIS;
int T urn On = MC_ON; <font color="green">// MC_OFF to turn of f.</font>
mc Soft Limit Set State(m Inst, axis, T urn On); <font color="green">// Set the
softlimit forthe Z axis to be ON.</font>


<!-- Page 454 -->

int mc Soft Limit Set State(
MINST ANCE m Inst, int axis, int on);
rc = mc.mc Soft Limit Set State(
number m Inst, number axis, number on)
int m Inst=0;
int axis = Z_AXIS;
int T urn On = MC_ON; <font color="green">// MC_OFF to turn of f.</font>
mc Soft Limit Set State(m Inst, axis, T urn On); <font color="green">// Set the
softlimit forthe Z axis to be ON.</font>


<!-- Page 455 -->

Spindle

mc Spindle Calc CSST o RPM
mc Spindle Get Accel T ime
mc Spindle Get Command RPM
mc Spindle Get Current Range
mc Spindle Get Decel T ime
mc Spindle Get Direction
mc Spindle Get Feedback Ratio
mc Spindle Get Max RPM
mc Spindle Get Min RPM
mc Spindle Get Motor Accel
mc Spindle Get Motor Max RPM
mc Spindle Get Motor RPM
mc Spindle Get Override
mc Spindle Get Override Enable
mc Spindle Get Reverse
mc Spindle Get Sensor RPM
mc Spindle Get Speed Check Enable
mc Spindle Get Speed Check Percent
mc Spindle Get T rue RPM
mc Spindle Set Accel T ime
mc Spindle Set Command RPM
mc Spindle Set Decel T ime
mc Spindle Set Direction
mc Spindle Set Direction W ait
mc Spindle Set Feedback Ratio
mc Spindle Set Max RPM
mc Spindle Set Min RPM
mc Spindle Set Motor Accel
mc Spindle Set Motor Max RPM
mc Spindle Set Override


<!-- Page 456 -->

mc Spindle Set Override Enable
mc Spindle Set Range
mc Spindle Set Reverse
mc Spindle Set Sensor RPM
mc Spindle Set Speed Check Enable
mc Spindle Set Speed Check Percent
mc Spindle Speed Check


<!-- Page 457 -->

int mc Spindle Calc CSST o RPM(
MINST ANCE m Inst, double Dia Of Cut, BOOL Inch);
rc = mc.mc Spindle Calc CSST o RPM(
number m Inst, number Dia Of Cut, number Inch);
<font color="green">// make the spindle speed calc the correct RPM for a
.5 5 0" inch cut.</font> MINST ANCE m Inst = 0;
int rc = mc Spindle Calc CSST o RPM(m Inst, .5 5 0, TRUE);


<!-- Page 458 -->

int mc Spindle Get Accel T ime(
MINST ANCE m Inst, int Range, double *Sec);
Sec, rc = mc.mc Spindle Get Accel T ime(
number m Inst, number Range)
<font color="green">// Get the accel time for spindle range 2.</font>
MINST ANCE m Inst = 0;
double sec = 0;
int rc = mc Spindle Get Accel T ime(m Inst, 2, &sec);


<!-- Page 459 -->

int mc Spindle Get Command RPM(
MINST ANCE m Inst, double *RPM);
RPM, rc = mc.mc Spindle Get Command RPM(
number m Inst)
<font color="green">// Get the current commanded RPM</font>
MINST ANCE m Inst = 0; double rpm = 0.0;
int rc = mc Spindle Get Command RPM(m Inst, &rpm);


<!-- Page 460 -->

int mc Spindle Get Current Range(
MINST ANCE m Inst, int *Range);
Range, rc = mc.mc Spindle Get Current Range(
number m Inst)
<font color="green">// Get the current spindle range.</font> MINST ANCE
m Inst = 0;
int range = 0;
int rc = mc Spindle Get Current Range(m Inst, &range);


<!-- Page 461 -->

int mc Spindle Get Decel T ime(
MINST ANCE m Inst, int Range, double *Sec);
Sec, rc = mc.mc Spindle Get Decel T ime(
number m Inst, number Range)
<font color="green">// Get the decel. time for spindle range 3</font>
MINST ANCE m Inst = 0;
double sec = 0.0;
int rc = mc Spindle Get Decel T ime(m Inst, 3, &ec);


<!-- Page 462 -->

int mc Spindle Get Direction(
MINST ANCE m Inst, int *dir);
dir, rc = mc.mc Spindle Get Direction(
number m Inst)
<font color="green">// Get the current spindle direction.</font>
MINST ANCE m Inst = 0;
int dir = MC_SPINDLE_OFF; int rc = mc Spindle Get Direction(m Inst,
&dir);


<!-- Page 463 -->

int mc Spindle Get Feedback Ratio(
MINST ANCE m Inst, int Range, double *Ratio);
Ratio, rc = mc.mc Spindle Get Feedback Ratio(
number m Inst, number Range)
<font color="green">// Get the feedback ratio for spindle range 0.</font>
MINST ANCE m Inst = 0;
double ratio = 0.0;
int rc = mc Spindle Get Feedback Ratio(m Inst, 0, &ratio);


<!-- Page 464 -->

int mc Spindle Get Max RPM(
MINST ANCE m Inst, int Range, double *Max RPM);
Max RPM, rc = mc.mc Spindle Get Max RPM(
number m Inst, number Range)
<font color="green">// Get the max RPM for range 0.</font>
MINST ANCE m Inst = 0;
double mrpm = 0.0
int rc = mc Spindle Get Max RPM(m Inst, 0, &mrpm);


<!-- Page 465 -->

int mc Spindle Get Min RPM(
MINST ANCE m Inst, int Range, double *Min RPM);
Min RPM, rc = mc.mc Spindle Get Min RPM(
number m Inst, number Range)
<font color="green">// Get the min RPM for range 0.</font> MINST ANCE
m Inst = 0;
double mrpm = 0.0
int rc = mc Spindle Get Min RPM(m Inst, 0, &mrpm);


<!-- Page 466 -->

int mc Spindle Get Motor Accel(
MINST ANCE m Inst, int Range, double *Accel);
Accel, rc = mc.mc Spindle Get Motor Accel(
number m Inst, number Range)
<font color="green">// Get the spindle acceleration for range 1.</font>
MINST ANCE m Inst = 0;
double accel = 0.0;
int rc = mc Spindle Get Motor Accel(m Inst, 1, &accel);


<!-- Page 467 -->

int mc Spindle Get Motor Max RPM(
MINST ANCE m Inst, double *RPM);
RPM, rc = mc.mc Spindle Get Motor Max RPM(
number m Inst)
<font color="green">// Get the maximum spindle motor RPM.</font>
MINST ANCE m Inst = 0;
double rpm = 0.0;
int rc = mc Spindle Get Motor Max RPM(m Inst, &rpm);


<!-- Page 468 -->

int mc Spindle Get Motor RPM(
MINST ANCE m Inst, double *RPM);
rpm, rc = mc.mc Spindle Get Motor RPM(
number m Inst)
<font color="green">// Get the current motor RPM.</font> MINST ANCE
m Inst = 0;
double rpm = 0.0;
int rc = mc Spindle Get Motor RPM(m Inst, &rpm);


<!-- Page 469 -->

int mc Spindle Get Override(
MINST ANCE m Inst, double *percent);
percent, rc = mc Spindle Get Override(
number m Inst)
<font color="green">// Get the spindle override. .5 == 5 0%</font>
MINST ANCE m Inst = 0;
double percent = 0.0;
int rc = mc Spindle Get Override(m Inst, &percent);


<!-- Page 470 -->

int mc Spindle Get Override Enable(
MINST ANCE m Inst, BOOL *enabled);
enabled, rc = mc Spindle Get Override Enable(
number m Inst)
<font color="green">// Get the spindle override status.</font>
MINST ANCE m Inst = 0;
BOOL enabled = F ALSE;
int rc = mc Spindle Get Override Enable(m Inst, &enabled);


<!-- Page 471 -->

int mc Spindle Get Reverse(
MINST ANCE m Inst, int Range, BOOL *Reversed);
Rreversed, rc = mc.mc Spindle Get Reverse(
number m Inst, number Range)
<font color="green">// See if the spindle is reversed in range 1</font>
MINST ANCE m Inst = 0;
BOOL reversed = F ALSE; int mc Spindle Get Reverse(m Inst, 1, &reversed);


<!-- Page 472 -->

int mc Spindle Get Sensor RPM(
MINST ANCE m Inst, double *RPM);
RPM, rc = mc.mc Spindle Get Sensor RPM(
number m Inst)
<font color="green">// Get the spindle sensor RPM.</font> MINST ANCE
m Inst = 0;
double rpm = 0.0;
int rc = mc Spindle Get Sensor RPM(m Inst, &rpm);


<!-- Page 473 -->

int mc Spindle Get Speed Check Enable(
MINST ANCE m Inst, BOOL *enabled);
enabled, rc = mc.mc Spindle Get Speed Check Enable(
number m Inst)
<font color="green">// Check the staus of spindle speed check.</font>
MINST ANCE m Inst = 0;
BOOL enabled = F ALSE;
int rc = mc Spindle Get Speed Check Enable(m Inst, &enabled);


<!-- Page 474 -->

int mc Spindle Get Speed Check Percent(
MINST ANCE m Inst, double *percent);
percent, rc = mc.mc Spindle Get Speed Check Percent(
number m Inst)
<font color="green">// Get the speed check percentage.</font>
MINST ANCE m Inst = 0;
double percent = 0.0;
int rc = mc Spindle Get Speed Check Percent(m Inst, &percent);


<!-- Page 475 -->

int mc Spindle Get T rue RPM(
MINST ANCE m Inst, double *RPM);
RPM, rc = mc.mc Spindle Get T rue RPM(
number m Inst)
<font color="green">// Get the true spindle RPM.</font> MINST ANCE
m Inst = 0;
double rpm = 0.0;
int rc = mc Spindle Get T rue RPM(m Inst, &rpm);


<!-- Page 476 -->

int mc Spindle Set Accel T ime(
MINST ANCE m Inst, int Range, double Sec);
rc = mc.mc Spindle Set Accel T ime(
number m Inst, number Range, number Sec);
<font color="green">// Set the accel. time for spindle range 0.</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Accel T ime(m Inst, 0, 5.0);


<!-- Page 477 -->

int mc Spindle Set Command RPM(
MINST ANCE m Inst, double RPM);
rc = mc.mc Spindle Set Command RPM(
number m Inst, number RPM)
<font color="green">// Set the spindle RPM to 5 0 0 0.</font> MINST ANCE
m Inst = 0;
int rc = mc Spindle Set Command RPM(m Inst, 5 0 0 0);


<!-- Page 478 -->

int mc Spindle Set Decel T ime(
MINST ANCE m Inst, int Range, double Sec);
rc = mc.mc Spindle Set Decel T ime(
number m Inst, number Range, number Sec)
<font color="green">// Set the decel. time for spindle range 0.</font>
MINST ANCE m Inst = 0;
in rc = mc Spindle Set Decel T ime(m Inst, 0, 5);


<!-- Page 479 -->

int mc Spindle Set Direction(
MINST ANCE m Inst, int dir);
rc = mc.mc Spindle Set Direction(
number m Inst, number dir)
<font color="green">// Set the spindle direction to FWD</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Direction(m Inst, MC_SPINDLE_FWD);


<!-- Page 480 -->

int mc Spindle Set Direction W ait(
MINST ANCE m Inst, int dir);
rc = mc.mc Spindle Set Direction W ait(
number m Inst, number dir)
<font color="green">// Set the spindle direction to FWD and wait</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Direction W ait(m Inst, MC_SPINDLE_FWD);


<!-- Page 481 -->

int mc Spindle Set Feedback Ratio(
MINST ANCE m Inst, int Range, double Ratio);
rc = mc.mc Spindle Set Feedback Ratio(
number m Inst, number Range, number Ratio)
<font color="green">// Set the feedback ratio for spindle range 0.</font>
MINST ANCE m Inst = 0;
int mc Spindle Set Feedback Ratio(m Inst, 0, 1.2); <font color="green">// 1.2 :
1</font>


<!-- Page 482 -->

int mc Spindle Set Max RPM(
MINST ANCE m Inst, int Range, double RPM);
rc = mc.mc Spindle Set Max RPM(
number m Inst, number Range, number RPM);
<font color="green">// Set the max RPM for spindle range 0 to
5 0 0 0</font> MINST ANCE m Inst = 0;
int mc Spindle Set Max RPM(m Inst, 0, 5 0 0 0);


<!-- Page 483 -->

int mc Spindle Set Min RPM(
MINST ANCE m Inst, int Range, double RPM);
rc = mc.mc Spindle Set Min RPM(
number m Inst, number Range, number RPM);
<font color="green">// Set the min RPM for spindle range 0 to 6 0</font>
MINST ANCE m Inst = 0;
int mc Spindle Set Min RPM(m Inst, 0, 6 0);


<!-- Page 484 -->

int mc Spindle Set Motor Accel(
MINST ANCE m Inst, int Range, double Accel);
rc = mc.mc Spindle Set Motor Accel(
number m Inst, number Range, number Accel);
<font color="green">// Set the acceleration for the spindle motor for range
0</font> MINST ANCE m Inst = 0;
int rc = mc Spindle Set Motor Accel(m Inst, 0, 1 0 0 0 0);


<!-- Page 485 -->

int mc Spindle Set Motor Max RPM(
MINST ANCE m Inst, double RPM);
rc = mc.mc Spindle Set Motor Max RPM(
number m Inst, number RPM)
<font color="green">// Cap the spindle motor RPM to 6 0 0 0.</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Motor Max RPM(m Inst, 6 0 0 0);


<!-- Page 486 -->

int mc Spindle Set Override(
MINST ANCE m Inst, double percent);
rc = mc.mc Spindle Set Override(
number m Inst, number percent)
<font color="green">// Set the spindle override to 5 0% (.5 == 5 0%)</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Override(m Inst, 0.5);


<!-- Page 487 -->

int mc Spindle Set Override Enable(
MINST ANCE m Inst, BOOL enable);
rc = mc.mc Spindle Set Override Enable(
number m Inst, number enable)
<font color="green">// Enable spindle override.</font> MINST ANCE
m Inst = 0;
int rc = mc Spindle Set Override Enable(m Inst, TRUE);


<!-- Page 488 -->

int mc Spindle Set Range(
MINST ANCE m Inst, int Range);
rc = mc.mc Spindle Set Range(
number m Inst, number Range)
<font color="green">// Set the current spindle range to the first range (0).
</font> MINST ANCE m Inst = 0;
mc Spindle Set Range(m Inst, 0);


<!-- Page 489 -->

int mc Spindle Set Reverse(
MINST ANCE m Inst, int Range, BOOL Reversed);
rc = mc.mc Spindle Set Reverse(
number m Inst, number Range, number Reversed)
<font color="green">// Set spindle range 1 as being reversed.</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Reverse(m Inst, 1, TRUE);


<!-- Page 490 -->

int mc Spindle Set Sensor RPM(
MINST ANCE m Inst, double RPM);
rc = mc.mc Spindle Set Sensor RPM(
number m Inst, number RPM)
<font color="green">// Set the spindle sensor RPM to 1 0 0 0</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Sensor RPM(m Inst, 1 0 0 0);


<!-- Page 491 -->

int mc Spindle Set Speed Check Enable(
MINST ANCE m Inst, BOOL enable);
rc = mc.mc Spindle Set Speed Check Enable(
number m Inst, number enable)
<font color="green">// Enable spindle speed checking.</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Speed Check Enable(m Inst, TRUE);


<!-- Page 492 -->

int mc Spindle Set Speed Check Percent(
MINST ANCE m Inst, double percent);
rc = mc.mc Spindle Set Speed Check Percent(
number m Inst, number percent)
<font color="green">// Set the speed check percentage to 5%. 1 0 0 == 1 0 0%
</font> MINST ANCE m Inst = 0;
int rc = mc Spindle Set Speed Check Percent(m Inst, 5);


<!-- Page 493 -->

int mc Spindle Speed Check(
MINST ANCE m Inst, int *Speed Ok);
Speed Ok, rc = mc.mc Spindle Speed Check(
number m Inst)
<font color="green">// Check to see if the spidnle speed is in the allowed
range.</font> MINST ANCE m Inst = 0; BOOL speed Ok;
int rc = mc Spindle Speed Check(m Inst, &speed Ok);


<!-- Page 494 -->

Scripting

mc Script Debug
mc Script Engine Register
mc Script Execute
mc Script Execute If Exists
mc Script Execute Private
mc Script Get Extensions


<!-- Page 495 -->

int mc Script Debug(
```
MINST ANCE m Inst, const char *filename);
N/A
<font color="green">// Debug the M 6 macro</font> MINST ANCE m Inst =
0; int rc = mc Script Debug(m Inst, "m 6.mcs");


<!-- Page 496 -->

int mc Script Engine Register(
```
MINST ANCE m Inst, HMCPLUG plugid, const char *Engine Name,
```
const char *Engine Desc, const char *File Extensions);
N/A
<font color="green">// Register the LUA script engine.</font>
MINST ANCE m Inst = 0;
```
HMCPLUG id; <font color="green">// From mc Plugin Init()</font>; int rc
= mc Script Engine Register(m Inst, id, "wx Lua", "wx Lua script engine",
"mcs|lua|wx.lua");


<!-- Page 497 -->

int mc Script Execute(
```
MINST ANCE m Inst, const char *filename, BOOL async);
rc = mc.mc Script Execute(
number m Inst, string filename, number async)
<font color="green">// Execute the M 6 script and wait on it to complete.
</font> MINST ANCE m Inst = 0;
rc = mc Script Execute(m Inst, "m 6.mcs", F ALSE);


<!-- Page 498 -->

int mc Script Execute If Exists(
```
MINST ANCE m Inst, const char *filename, BOOL async);
rc = mc.mc Script Execute If Exists(
number m Inst, string filename, number async)
<font color="green">// Execute the M 6 script and wait on it to complete.
</font> MINST ANCE m Inst = 0;
rc = mc Script Execute(m Inst, "m 6.mcs", F ALSE);


<!-- Page 499 -->

int mc Script Execute Private(
```
MINST ANCE m Inst, const char *filename, BOOL async);
rc = mc.mc Script Execute Private(
number m Inst, string filename, BOOL async)
<font color="green">// Execute my Script.mcs asynchronously in it's own
private environment.</font> MINST ANCE m Inst = 0;
int rc = mc Script Execute Private(m Inst, "my Script.mcs", TRUE);


<!-- Page 500 -->

int mc Script Get Extensions(MINST ANCE m Inst, char *buf, long bufsize);
N/A
<font color="green">// Retrieve all of the registered script extensions.
</font> MINST ANCE m Inst = 0; mc Script Get Extensions(MINST ANCE
m Inst, char *buf, long bufsize);


<!-- Page 501 -->

Status Messages

mc Cntl Get Last Error
mc Cntl Get Last Log Msg
mc Cntl Log
mc Cntl Set Last Error
mc Cntl Set Logging


<!-- Page 502 -->

int mc Cntl Get Last Error(
MINST ANCE m Inst, char *buf, size_t buf Size);
buf, rc = mc.mc Cntl Get Last Error(
MINST ANCE m Inst)
int m Inst=0;
char error[1 2 8]; mc Cntl Get Last Error(m Inst, error , 1 2 8); <font
color="green">// Receives the last error messge for controller instance 0.
</font>


<!-- Page 503 -->

int mc Cntl Get Last Log Msg(
MINST ANCE m Inst, char *buf, size_t buf Size);
buf, rc = mc.mc Cntl Get Last Log Msg(
number m Inst)
int m Inst=0;
char msg[1 2 8]; mc Cntl Get Last Log Msg(m Inst, msg, 1 2 8); <font
color="green">// Receives the last log messge for controller instance 0.
</font>


<!-- Page 504 -->

int mc Cntl Log(
```
MINST ANCE m Inst, const char *message, const char *file, int line);
rc = mc.mc Cntl Log(
number m Inst, string message, string file, number line)
<font color="green">// Load G code from a string.</font> MINST ANCE
m Inst = 0; BOOL test = TRUE;
int rc;
```
if (test == TRUE) {
<font color="green">// File and line info in the log.</font>
```
mc Cntl Log(m Inst, "test == TRUE!", __FILE__, __LINE__); } else {
<font color="green">// No file and line info in the log.</font>
```
mc Cntl Log(m Inst, "test == F ALSE!", NULL, 0); }


<!-- Page 505 -->

int mc Cntl Set Last Error(
```
MINST ANCE m Inst, const char *emsg);
rc = mc.mc Cntl Set Last Error(
number m Inst, string emsg)
MINST ANCE m Inst = 0;
char *erbuf = "T ool no longer in the spindle"; <font color="green">// Send
an error messge for controller 0.</font> int rc = mc Cntl Set Last Error(m Inst,
erbuf);


<!-- Page 506 -->

int mc Cntl Set Logging(
MINST ANCE m Inst, BOOL enable);
rc = mc.mc Cntl Set Logging(
number m Inst, number enable)
<font color="green">// Enable logging.</font> MINST ANCE m Inst = 0;
int rc = mc Cntl Set Logging(m Inst, enable);


<!-- Page 507 -->

License

mc Cntl Check License Feature
mc Cntl Get License Data
mc Cntl Get License Data Len
mc Cntl Get License Modules


<!-- Page 508 -->

int mc Cntl Check License Feature(
```
MINST ANCE m Inst, const char *lic File, const char *requirement, const
char *feature);
rc = mc Cntl Check License Feature(
number m Inst, string lic File, string requirement, string feature);
<font color="green">// Check the Darwin Lic.dat file for feature
M 4 _DAR WIN</font> MINST ANCE m Inst = 0;
int rc = mc Cntl Check License Feature(m Inst, "Darwin Lic.dat",
```
"NF_DAR WIN", "M 4 _DAR WIN"); if (rc != MERROR_NOERROR) {
```
<font color="green">// Feature found!!!</font> return; }


<!-- Page 509 -->

int mc Cntl Get License Data(
MINST ANCE m Inst, int index, char *buf, long buf Size);
buf, rc = mc.mc Cntl Get License Data(
number m Inst, number index)
<font color="green">// Get the license data at index 1.</font>
MINST ANCE m Inst = 0;
long len;
char *data;
long data Len = 0;
int index = 1;
int rc = mc Cntl Get License Data Len(m Inst, index, &data Len); if (rc ==
```
MERROR_NOERROR && data Len > 0) {
data = (char *)malloc(data Len + 1); memset(data, 0, data Len + 1); rc =
<font color="blue">mc Cntl Get License Data(m Inst, index, data, data Len)
```
</font>; if (rc == MERROR_NOERROR) {
```
<font color="green">// Success!</font> }
```
}


<!-- Page 510 -->

int mc Cntl Get License Data Len(
MINST ANCE m Inst, int index, long *buf Size);
buf Size, rc = mc.mc Cntl Get License Data(
number m Inst, number index)
<font color="green">// Get the license data at index 1.</font>
MINST ANCE m Inst = 0;
long len;
char *data;
long data Len = 0;
int index = 1;
int rc = <font color="blue">mc Cntl Get License Data Len(m Inst, index,
```
&data Len)</font>; if (rc == MERROR_NOERROR && data Len > 0) {
data = (char *)malloc(data Len + 1); memset(data, 0, data Len + 1); rc =
mc Cntl Get License Data(m Inst, index, data, data Len); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }
```
}


<!-- Page 511 -->

int mc Cntl Get License Modules(
MINST ANCE m Inst, unsigned long long *modules)
N/A
<font color="green">// Retrieve the licensed modules.</font>
MINST ANCE m Inst = 0;
unsigned long long modules = 0; int rc = mc Cntl Get License Modules(m Inst,
&modules);


<!-- Page 512 -->

Alphabetical API Refernce
mc Axis Deref
mc Axis Deref All
mc Axis E 2 nable
mc Axis Get Home Dir
mc Axis Get Home In Place
mc Axis Get Home Of fset
mc Axis Get Home Order
mc Axis Get Home Speed
mc Axis Get Info Struct
mc Axis Get Machine Pos
mc Axis Get Motor Id
mc Axis Get Override Axis
mc Axis Get Pos
mc Axis Get Probe Pos
mc Axis Get Probe Pos All
mc Axis Get Scale
mc Axis Get Softlimit Enable


<!-- Page 513 -->

mc Axis Get Softlimit Max
mc Axis Get Softlimit Min
mc Axis Get Spindle
mc Axis Get V el
mc Axis Home
mc Axis Home All
mc Axis Home Complete
mc Axis Home Complete W ith Status
mc Axis Is Enabled
mc Axis Is Homed
mc Axis Is Homing
mc Axis Is Still
mc Axis Map Motor
mc Axis Register
mc Axis Remove Override Axis
mc Axis Remove Override Axis Sync
mc Axis Set Home Dir
mc Axis Set Home In Place
mc Axis Set Home Of fset
mc Axis Set Home Order


<!-- Page 514 -->

mc Axis Set Home Speed
mc Axis Set Info Struct
mc Axis Set Machine Pos
mc Axis Set Override Axis
mc Axis Set Pos
mc Axis Set Softlimit Enable
mc Axis Set Softlimit Max
mc Axis Set Softlimit Min
mc Axis Set Spindle
mc Axis Set V el
mc Axis Unmap Motor
mc Axis Unmap Motors
mc Axis Unregister
mc Cntl Check License Feature
mc Cntl Cleanup
mc Cntl Close GCode File
mc Cntl Compile Scripts
mc Cntl Config Start
mc Cntl Config Stop
mc Cntl Create Local V ars


<!-- Page 515 -->

mc Cntl Cycle Start
mc Cntl Cycle Stop
mc Cntl Dry Run T o Line
mc Cntl EStop
mc Cntl Enable
mc Cntl Feed Hold
mc Cntl Feed Hold State
mc Cntl Gcode Execute
mc Cntl Gcode Execute W ait
mc Cntl Gcode Interp Get Data
mc Cntl Gcode Interp Get Pos
mc Cntl Get Block Delete
mc Cntl Get Build
mc Cntl Get Computer ID
mc Cntl Get Coolant Delay
mc Cntl Get Cwd
mc Cntl Get Dia Mode
mc Cntl Get Dist T o Go
mc Cntl Get Enable FRO
mc Cntl Get FRO


<!-- Page 516 -->

mc Cntl Get Gcode File Name
mc Cntl Get Gcode Line
mc Cntl Get Gcode Line Count
mc Cntl Get Gcode Line Nbr
mc Cntl Get Instance Handle
mc Cntl Get Last Error
mc Cntl Get Last Log Msg
mc Cntl Get License Data
mc Cntl Get License Data Len
mc Cntl Get License Modules
mc Cntl Get Local Comment
mc Cntl Get Local V ar
mc Cntl Get Logging
mc Cntl Get Mach Dir
mc Cntl Get Mist Delay
mc Cntl Get Modal Group
mc Cntl Get Mode
mc Cntl Get Of fset
mc Cntl Get Optional Stop
mc Cntl Get Pound V ar


<!-- Page 517 -->

mc Cntl Get RRO
mc Cntl Get Run T ime
mc Cntl Get Single Block
mc Cntl Get State
mc Cntl Get State Name
mc Cntl Get Stats
mc Cntl Get T ool Of fset
mc Cntl Get Units Current
mc Cntl Get Units Default
mc Cntl Get V alue
mc Cntl Get V ersion
mc Cntl Goto Zero
mc Cntl Init
mc Cntl Is In Cycle
mc Cntl Is Still
mc Cntl Load Gcode File
mc Cntl Load Gcode String
mc Cntl Log
mc Cntl Machine State Clear
mc Cntl Machine State Pop


<!-- Page 518 -->

mc Cntl Machine State Push
mc Cntl Macro Alarm
mc Cntl Macro Stop
mc Cntl Mdi Execute
mc Cntl Probe File Close
mc Cntl Probe File Open
mc Cntl Probe Get Strike Status
mc Cntl Reset
mc Cntl Rewind File
mc Cntl Set Block Delete
mc Cntl Set Coolant Delay
mc Cntl Set Dia Mode
mc Cntl Set Enable FRO
mc Cntl Set FRO
mc Cntl Set Gcode Line Nbr
mc Cntl Set Last Error
mc Cntl Set Logging
mc Cntl Set Mist Delay
mc Cntl Set Mode
mc Cntl Set Optional Stop


<!-- Page 519 -->

mc Cntl Set Pound V ar
mc Cntl Set RRO
mc Cntl Set Reset Codes
mc Cntl Set Single Block
mc Cntl Set Stats
mc Cntl Set V alue
mc Cntl Start Motion Dev
mc Cntl Stop Motion Dev
mc Cntl T ool Change Manual
mc Cntl W ait On Cycle Start
mc Device Get Handle
mc Device Get Info
mc Device Get Info Struct
mc Device Get Next Handle
mc Device Register
mc File Hold Aquire
mc File Hold Reason
mc File Hold Release
mc Fixture Load File
mc Fixture Save File


<!-- Page 520 -->

mc Gui Get W indow Handle
mc Gui Set Callback
mc Gui Set Focus
mc Gui Set W indow Handle
mc Io Get Handle
mc Io Get Info Struct
mc Io Get Next Handle
mc Io Get State
mc Io Get T ype
mc Io Get User Data
mc Io Is Enabled
mc Io Register
mc Io Set Desc
mc Io Set Name
mc Io Set State
mc Io Set T ype
mc Io Set User Data
mc Io Sync Signal
mc Io Unregister
mc Jog Abs Start


<!-- Page 521 -->

mc Jog Abs Stop
mc Jog Get Accel
mc Jog Get Feed Rate
mc Jog Get Follow Mode
mc Jog Get Inc
mc Jog Get Rate
mc Jog Get T race Enable
mc Jog Get T ype
mc Jogget Units Mode
mc Jog Get V elocity
mc Jog Inc Start
mc Jog Inc Stop
mc Jog Is Jogging
mc Jog Is Stopping
mc Jog Set Accel
mc Jog Set Feed Rate
mc Jog Set Follow Mode
mc Jog Set Inc
mc Jog Set Rate
mc Jog Set T race Enable


<!-- Page 522 -->

mc Jog Set T ype
mc Jog Set Units Mode
mc Jog V elocity Start
mc Jog V elocity Stop
mc Motion Clear Planner
mc Motion Cycle Planner
mc Motion Cycle Planner Ex
mc Motion Get Abs Pos
mc Motion Get Abs Pos Fract
mc Motion Get Backlash Abs
mc Motion Get Backlash Inc
mc Motion Get Inc Pos
mc Motion Get Move ID
mc Motion Get Pos
mc Motion Get Probe Params
mc Motion Get Rigid T ap Params
mc Motion Get Sync Output
mc Motion Get Thread Params
mc Motion Get Threading Rate
mc Motion Get V el


<!-- Page 523 -->

mc Motion Set Cycle T ime
mc Motion Set Move ID
mc Motion Set Pos
mc Motion Set Probe Complete
mc Motion Set Probe Pos
mc Motion Set Still
mc Motion Set Threading Rate
mc Motion Set V el
mc Motion Sync
mc Motion Thread Complete
mc Motor Get Axis
mc Motor Get Counts Per Unit
mc Motor Get Info Struct
mc Motor Get Pos
mc Motor Get V el
mc Motor Is Homed
mc Motor Is Still
mc Motor Map Get Definition
mc Motor Map Get Length
mc Motor Map Get NPoints


<!-- Page 524 -->

mc Motor Map Get Point
mc Motor Map Get Point Count
mc Motor Map Get Start
mc Motor Map Set Definition
mc Motor Map Set Length
mc Motor Map Set NPoints
mc Motor Map Set Point
mc Motor Map Set Point Count
mc Motor Map Set Start
mc Motor Register
mc Motor Set Counts Per Unit
mc Motor Set Home Pos
mc Motor Set Info Struct
mc Motor Unregister
mc Mpg Get Accel
mc Mpg Get Axis
mc Mpg Get Counts Per Detent
mc Mpg Get Enable
mc Mpg Get Encoder Reg
mc Mpg Get Inc


<!-- Page 525 -->

mc Mpg Get Reversed
mc Mpg Get Rate
mc Mpg Get Shuttle Mode
mc Mpg Get Shuttle Percent
mc Mpg Move Counts
mc Mpg Set Accel
mc Mpg Set Axis
mc Mpg Set Counts Per Detent
mc Mpg Set Enable
mc Mpg Set Encoder Reg
mc Mpg Set Inc
mc Mpg Set Reversed
mc Mpg Set Rate
mc Mpg Set Shuttle Mode
mc Mpg Set Shuttle Percent
mc Plugin Configure
mc Plugin Core Load
mc Plugin Core Unload
mc Plugin Diagnostic
mc Plugin Enable


<!-- Page 526 -->

mc Plugin Get Enabled
mc Plugin Get Info Struct
mc Plugin Get License Feature
mc Plugin Get Next Handle
mc Plugin Get V alid
mc Plugin Install
mc Plugin Register
mc Plugin Remove
mc Profile Delete Key
mc Profile Delete Section
mc Profile Exists
mc Profile Flush
mc Profile Get Double
mc Profile Get Int
mc Profile Get Name
mc Profile Get String
mc Profile Reload
mc Profile Save
mc Profile W rite Double
mc Profile W rite Int


<!-- Page 527 -->

mc Profile W rite String
mc Reg Get Command
mc Reg Get Handle
mc Reg Get Info
mc Reg Get Info Struct
mc Reg Get Next Handle
mc Reg Get User Data
mc Reg Get V alue
mc Reg Get V alue Long
mc Reg Get V alue String
mc Reg Get V alue String Clear
mc Reg Register
mc Reg Send Command
mc Reg Set Desc
mc Reg Set Name
mc Reg Set Response
mc Reg Set T ype
mc Reg Set User Data
mc Reg Set V alue
mc Reg Set V alue Long


<!-- Page 528 -->

mc Reg Set V alue String
mc Reg Unregister
mc Script Debug
mc Script Engine Register
mc Script Execute
mc Script Execute If Exists
mc Script Execute Private
mc Script Get Extensions
mc Signal Enable
mc Signal Get Handle
mc Signal Get Info
mc Signal Get Info Struct
mc Signal Get Next Handle
mc Signal Get State
mc Signal Handle W ait
mc Signal Map
mc Signal Set Active Low
mc Signal Set State
mc Signal Unmap
mc Signal W ait


<!-- Page 529 -->

mc Soft Limit Get State
mc Soft Limit Max Mins Clear
mc Soft Limit Set State
mc Spindle Calc CSST o RPM
mc Spindle Get Accel T ime
mc Spindle Get Command RPM
mc Spindle Get Current Range
mc Spindle Get Decel T ime
mc Spindle Get Direction
mc Spindle Get Feedback Ratio
mc Spindle Get Max RPM
mc Spindle Get Min RPM
mc Spindle Get Motor Accel
mc Spindle Get Motor Max RPM
mc Spindle Get Motor RPM
mc Spindle Get Override
mc Spindle Get Override Enable
mc Spindle Get Reverse
mc Spindle Get Sensor RPM
mc Spindle Get Speed Check Enable


<!-- Page 530 -->

mc Spindle Get Speed Check Percent
mc Spindle Get T rue RPM
mc Spindle Set Accel T ime
mc Spindle Set Command RPM
mc Spindle Set Decel T ime
mc Spindle Set Direction
mc Spindle Set Direction W ait
mc Spindle Set Feedback Ratio
mc Spindle Set Max RPM
mc Spindle Set Min RPM
mc Spindle Set Motor Accel
mc Spindle Set Motor Max RPM
mc Spindle Set Override
mc Spindle Set Override Enable
mc Spindle Set Range
mc Spindle Set Reverse
mc Spindle Set Sensor RPM
mc Spindle Set Speed Check Enable
mc Spindle Set Speed Check Percent
mc Spindle Speed Check


<!-- Page 531 -->

mc Tool Get Current
mc Tool Get Data
mc Tool Get Data Ex Dbl
mc Tool Get Data Ex Int
mc Tool Get Data Ex Str
mc Tool Get Desc
mc Tool Get Selected
mc Tool Load File
mc Tool Path Create
mc Tool Path Delete
mc Tool Path Generate
mc Tool Path Generate Abort
mc Tool Path Generated Percent
mc Tool Path Get AAxis Position
mc Tool Path Get ARotation Axis
mc Tool Path Get Axis Color
mc Tool Path Get Back Color
mc Tool Path Get Draw Limits
mc Tool Path Get Execution
mc Tool Path Get Follow Mode


<!-- Page 532 -->

mc Tool Path Get Generating
mc Tool Path Get Left Mouse Dn
mc Tool Path Get Left Mouse Up
mc Tool Path Get Path Color
mc Tool Path Is Signal Mouse Clicks
mc Tool Path Set AAxis Position
mc Tool Path Set ARotation Axis
mc Tool Path Set Axis Color
mc Tool Path Set Back Color
mc Tool Path Set Draw Limits
mc Tool Path Set Follow Mode
mc Tool Path Set Path Color
mc Tool Path Set Signal Mouse Clicks
mc Tool Path Set V iew
mc Tool Path Set Zoom
mc Tool Path Update
mc Tool Save File
mc Tool Set Current
mc Tool Set Data
mc Tool Set Data Ex Dbl


<!-- Page 533 -->

mc Tool Set Data Ex Int
mc Tool Set Data Ex Str
mc Tool Set Desc


<!-- Page 534 -->

int mc Axis Deref(
MINST ANCE m Inst, int axis Id);
rc = mc.mc Axis Deref(
number m Inst, number axis Id)
int m Inst = 0;
<font color="green">// Set AXIS 0 to deref (could have used X_AXIS).
</font> mc Axis Deref(m Inst, AXIS 0);


<!-- Page 535 -->

int mc Axis Deref All(
MINST ANCE m Inst);
rc = mc.mc Axis Deref All(
number m Inst)
int m Inst = 0;
<font color="green">// Set all axis to deref.</font>
mc Axis Deref All(m Inst);


<!-- Page 536 -->

int mc Axis Enable(
MINST ANCE m Inst, int axis Id, BOOL enabled);
rc = mc.mc Axis Enable(
number m Inst, number axis Id, number enabled);
int m Inst = 0;
<font color="green">// Set Y_AXIS to be disabled.</font>
mc Axis Enable(m Inst, Y_AXIS, false);


<!-- Page 537 -->

int mc Axis Get Home Dir(
MINST ANCE m Inst, int axis Id, int *dir);
dir, rc = mc.mc Axis Get Home Dir(
number m Inst, number axis Id)
int m Inst=0;
int dir = 0;
<font color="green">// Get Home of fset of the X axis.</font>
mc Axis Get Home Dir(m Inst, X_AXIS, &dir);


<!-- Page 538 -->

int mc Axis Get Home In Place(
MINST ANCE m Inst, int axis Id, BOOL *home In Place);
home In Place, rc = mc.mc Axis Get Home In Place(
number m Inst, number axis Id)
<font color="green">// Get the Home In Place flag for the X axis.</font>
MINST ANCE m Inst = 0;
BOOL hip = F ALSE;
mc Axis Get Home In Place(m Inst, X_AXIS, &hip);


<!-- Page 539 -->

int mc Axis Get Home Of fset(
MINST ANCE m Inst, int axis Id, double *of fset);
offset, rc = mc.mc Axis Get Home Of fset(
number m Inst, number axis Id)
int m Inst=0;
int of fset = 0;
<font color="green">// Get Home of fset of the X axis.</font>
mc Axis Get Home Order(m Inst, X_AXIS, &of fset);


<!-- Page 540 -->

int mc Axis Get Home Order(
MINST ANCE m Inst, int axis Id, int *order);
order , rc = mc.mc Axis Get Home Order(
number m Inst, number axis Id)
int m Inst=0;
double XAxis Pos = 0;
int order = 0;
<font color="green">// Get Home order of the X axis.</font>
mc Axis Get Home Order(m Inst, X_AXIS, &order);


<!-- Page 541 -->

int mc Axis Get Home Speed(
MINST ANCE m Inst, int axis Id, double *percent);
percent, rc = mc.mc Axis Get Home Speed(
number m Inst, number axis Id)
int m Inst=0;
int rc = 0;
double XAxis Pos = 0; double percent = 0; double max V el = 0
double home V el = 0;
<font color="green">// Get home speed percentage of the X axis.</font>
mc Axis Get Home Speed(m Inst, X_AXIS, &percent); mc Axis Get V el(m Inst,
X_AXIS, &max V el); home V el = max V el * percent;


<!-- Page 542 -->

int mc Axis Get Info Struct(
MINST ANCE m Inst,
int axis Id,
axisinfo_t *ainf);
ainf, rc = mc.mc Axis Get Info Struct(number m Inst, number axis Id)
```
struct axisinfo {
BOOL Out Of Band Axis; // Is this an out of band axis?
BOOL Is Still; // Set high when the axis is not moving BOOL Jogging; //
Used to tell to jog...
BOOL Homing; // Used to tell the state of the home operation.
int Id; // Axis Id
BOOL Is Spindle; // Does this axis control a spindle?
BOOL Enabled; // Is axis enabled?
BOOL Softlimit Enabled; // Softlimits enabled?
double Soft Max Limit; // Count for the max travel.
double Soft Min Limit; // Count for the m.
BOOL V elocity Mode; // Used to make the axis move at a fixed speed
BOOL Buf fer Jog; // Buf fer all jogs?
double Pos; // Position in user units.
double Mpos; // Machine position in user units.
int Home Order; // The order in which to home the axis.


<!-- Page 543 -->

int Home Dir; // The direction the axis homes.
double Home Of fset; // The of fset from the the limits switch.
double Home Speed Percent;// The percentage of the max velocity at
which to home.
BOOL Softlimit Used; // Use Softlimits?
BOOL Home In Place; // Zero the axis in place when Refed?
int Motor Id[MC_MAX_AXIS_MOT ORS]; //child motor ID array .
```
};
```
typedef struct axisinfo axisinfo_t;
int m Inst = 0;
axisinfo_t ainf;
<font color="green">// Get Y_AXIS info structure.</font>
mc Axis Get Info Struct(m Inst, Y_AXIS, &ainf);


<!-- Page 544 -->

int mc Axis Get Machine Pos(
MINST ANCE m Inst, int axis Id, double *val);
val, rc = mc.mc Axis Get Machine Pos(
number m Inst, number axis Id)
int m Inst=0;
double XAxis Machine Pos = 0; int Axis Number = X_AXIS;
mc Axis Get Machine Pos(m Inst, Axis Number , &XAxis Machine Pos); <font
color="green">// Get the position of the X axis in Machine Pos.</font>


<!-- Page 545 -->

int mc Axis Get Motor Id(
MINST ANCE m Inst, int axis, int child Id, int *motor Id);
motor Id, rc = mc.mc Axis Get Motor Id(
number m Inst, number axis, number child Id)
int m Inst=0;
```
int motor Ids[]={-1,-1,-1,-1,-1}
int id;
<font color="green">// Get all the motor ID's for the X axis up to 5 motors.
```
</font> for(int i = 0; i < 5; i++){
if (mc Axis Get Motor Id(m Inst, X_AXIS, i, &id) ==

```
MERROR_NOERROR No Error .) {
```
motor Ids[i] = id; }
```
}


<!-- Page 546 -->

int mc Axis Get Override Axis(
MINST ANCE m Inst, int axis, int *axis 1, int *axis 2, int *axis 3, int
*axis 4);
axis 1, axis 2, axis 3, axis 4, rc = mc.mc Axis Get Override Axis(
number m Inst, number axis)
int m Inst = 0;
int ora[4];
<font color="green">// Get the override axis for the Z axis.</font>
mc Axis Get Override Axis(m Inst, ZAXIS, &ora[0], &ora[1], &ora[2],
&ora[3]);


<!-- Page 547 -->

int mc Axis Get Pos(
MINST ANCE m Inst, int axis Id, double *val);
val, rc = mc.mc Axis Get Pos(
number m Inst, number axis Id)
int m Inst=0;
double XAxis Pos = 0;
int Axis Number = X_AXIS; <font color="green">// Get the position of the
X axis.</font> mc Axis Get Pos(m Inst, Axis Number , &XAxis Pos);


<!-- Page 548 -->

int mc Axis Get Probe Pos(
MINST ANCE m Inst, int axis Id, BOOL machine Pos, double *val);
val, rc = mc.mc Axis Get Probe Pos(
number m Inst, number axis Id, number machine Pos)
<font color="green">// Get the last probe strike position for the X
axis</font> MINST ANCE m Inst = 0;
double x Probe Pos = 0;
mc Axis Get Probe Pos(m Inst, X_AXIS, F ALSE, &x Prob Pos);


<!-- Page 549 -->

int mc Axis Get Probe Pos All(
MINST ANCE m Inst, BOOL machine Pos, double *x, double *y , double
*z, double *a, double *b, double *c);
x, y, z, a, b, c, rc = mc.mc Axis Get Probe Pos All(
number m Inst, number machine Pos)
<font color="green">// Get the last probe strike position for the X, Y , and Z
axes.</font> MINST ANCE m Inst = 0;
double x, y , z;
int rc = mc Axis Get Probe Pos All(m Inst, F ALSE, &x, &y , &z, NULL,
```
NULL, NULL); if (rc == MERROR_NOERROR) {
// Process probe positions...
```
}


<!-- Page 550 -->

int mc Axis Get Scale(
MINST ANCE m Inst, int axis Id, double *scale V al);
scale V al, rc = mc.mc Axis Get Probe Pos(
number m Inst, number axis Id)
<font color="green">// Get the scale value for the X axis</font>
MINST ANCE m Inst = 0; double scale = 0;
mc Axis Get Scale(m Inst, X_AXIS, &scale);


<!-- Page 551 -->

int mc Axis Get Softlimit Enable(
MINST ANCE m Inst, int axis Id, int *enable);
enable, rc = mc.mc Axis Get Softlimit Enable(
number m Inst, number axis Id)
<font color="green">// Get master soft limit enable state for axis 0.</font>
int m Inst = 0;
int enable = 0;
mc Axis Get Softlimit Enable(m Inst, 0, &enable);


<!-- Page 552 -->

int mc Axis Get Softlimit Max(
MINST ANCE m Inst, int axis Id, double *max);
max, rc = mc.mc Axis Get Softlimit Min(
number m Inst, number axis Id)
int m Inst=0;
int axis = Y_AXIS; double min = 0;
mc Axis Get Softlimit Max(m Inst, axis, &min);<font color="green">// Get the
max distance of the softlimit for the Y axis.</font>


<!-- Page 553 -->

int mc Axis Get Softlimit Min(
MINST ANCE m Inst, int axis Id, double *min);
min, rc = mc.mc Axis Get Softlimit Min(
number m Inst, number axis Id)
int m Inst=0;
int axis = Y_AXIS; double min = 0;
mc Axis Get Softlimit Min(m Inst, axis, &min);<font color="green">// Get the
min distance of the softlimit for the Y axis.</font>


<!-- Page 554 -->

int mc Axis Get Spindle(
MINST ANCE m Inst, int axis Id, bool *spindle);
spindle, rc = mc Axis Get Spindle(
number m Inst, number axis Id)
<font color="green">// Find the spindle axis</font> int m Inst = 0;
int axis Id;
bool is Spindle = false; for (axis Id = MC_MAX_COORD_AXES; axis Id <
```
MC_MAX_AXES; axis Id++) {
```
mc Axis Get Spindle(m Inst, axis Id, &is Spindle); if (is Spindle) {
```
<font color="green">// Spindle found!</font> break; }
```
}


<!-- Page 555 -->

int mc Axis Get V el(
MINST ANCE m Inst, int axis Id, double *velocity);
velocity , rc = mc.mc Axis Get V el(
number m Inst, number axis Id)
int m Inst=0;
int axis = Y_AXIS;
double Current V el = 0; mc Axis Get V el(m Inst, axis, &Current V el); <font
color="green">// Get the current speed of the Y axis.</font>


<!-- Page 556 -->

int mc Axis Home(
MINST ANCE m Inst, int axis Id);
rc = mc.mc Axis Home(
number m Inst, number axis Id)
int m Inst=0;
int Axis Number = X_AXIS; <font color="green">// Set the X axis to home.
</font> mc Axis Set Pos(m Inst, Axis Number);


<!-- Page 557 -->

int mc Axis Home All(
MINST ANCE m Inst);
rc = mc.mc Axis Home All(
number m Inst)
int m Inst=0;
<font color="green">// Home all coordinated axes.</font>
mc Axis Home All(m Inst);


<!-- Page 558 -->

int mc Axis Home Complete(
MINST ANCE m Inst, int axis Id);
rc = mc.mc Axis Home Complete(
number m Inst, number axis Id);
int m Inst=0;
int Axis Number = X_AXIS; <font color="green">// Mark the X axis home
operation as complete.</font> mc Axis Home Complete(m Inst,
Axis Number);


<!-- Page 559 -->

int mc Axis Home Complete W ith Status(
MINST ANCE m Inst, int axis Id BOOL success);
rc = mc.mc Axis Home Complete W ith Status(
number m Inst, number axis Id number success);
int m Inst=0;
int Axis Number = X_AXIS; <font color="green">// Mark the X axis
homing operation as finished and that it completed with success.</font>
mc Axis Home Complete W ith Status(m Inst, Axis Number , TRUE);


<!-- Page 560 -->

int mc Axis Is Enabled(
MINST ANCE m Inst, int axis Id, BOOL *enabled);
enabled, rc = mc.mc Axis Is Enabled(
number m Inst, number axis Id)
<font color="green">// Find all enabled axes.</font> int m Inst = 0;
int axis Id;
BOOL enabled = F ALSE;
```
for (axis Id = 0; axis Id < MC_MAX_AXES; axis Id++) {
enabled = false; mc Axis Is Enabled(m Inst, axis Id, &enabled); if (enabled
```
== TRUE) {
```
<font color="green">// Axis is enabled!</font> }
```
}


<!-- Page 561 -->

int mc Axis Is Homed(
MINST ANCE m Inst, int axis Id, BOOL *homed);
homed, rc= mc.mc Axis Is Homed(
number m Inst, number axis Id)
int m Inst = 0;
BOOL homed = F ALSE; <font color="green">// Get the homed state of Z
axis.</font> mc Axis Is Homed(m Inst, Z_AXIS, &homed); if (rc ==
```
MERROR_NOERROR && homed == TRUE) {
```
<font color="green">// Z is homed.</font> }


<!-- Page 562 -->

int mc Axis Is Homin(
MINST ANCE m Inst, int axis Id, BOOL *homing);
homing, rc= mc.mc Axis Is Homed(
number m Inst, number axis Id)
int m Inst = 0;
BOOL homing = F ALSE; <font color="green">// Get the homing state of Z
axis.</font> mc Axis Is Homing(m Inst, Z_AXIS, &homing); if (rc ==
```
MERROR_NOERROR && homing == TRUE) {
```
<font color="green">// Z is in a home operation.</font> }


<!-- Page 563 -->

int mc Axis Is Still(
MINST ANCE m Inst, int axis Id, BOOL *still);
still, rc = mc.mc Axis Is Still(
number m Inst, number axis Id)
int m Inst=0;
int Axis Number = X_AXIS; int still = 0;
<font color="green">// Get the is moving state of the axis vlue of 1 is
stopped.</font> mc Axis Is Still(m Inst, Axis Number , &still);


<!-- Page 564 -->

int mc Axis Map Motor(
MINST ANCE m Inst, int axis Id, int motor Id);
rc = mc.mc Axis Map Motor(
number m Inst, number axis Id, number motor Id)
int m Inst=0;
int Axis Number = X_AXIS; int Motor Number = MOT OR 5
<font color="green">// Map motor 5 to the X axis.</font>
mc Axis Map Motor(m Inst, Axis Number , Motor Number);


<!-- Page 565 -->

int mc Axis Register(
MINST ANCE m Inst, int axis Id);
rc = mc.mc Axis Register(
number m Inst, number axis Id);
int m Inst=0;
```
for (int a = AXIS 0; < AXIS 4; a++) {
<font color="green">// Register axis 0 - axis 2 to the core.</font> if(
mc Axis Register(m Inst, a) !=

```
MERROR_NOERROR No Error .){
```
return(false); }
```
}


<!-- Page 566 -->

int mc Axis Remove Override Axis(
MINST ANCE m Inst, int axis Id, int axis T o Override Id);
rc = mc.mc Axis Remove Override Axis(
number m Inst, number axis Id, number axis T o Override Id)
int m Inst = 0;
int homed = 0;
<font color="green">// Remove axis 8 from the Z axis.</font>
mc Axis Remove Override Axis( m Inst, AXIS_ 8, ZAXIS );


<!-- Page 567 -->

int mc Axis Remove Override Axis Sync(
MINST ANCE m Inst, int axis Id,
int axis T o Override Id);
rc = mc.mc Axis Remove Override Axis Sync(
number m Inst, number axis Id, number axis T o Override Id)
int m Inst = 0;
int homed = 0;
<font color="green">// Remove axis 8 from the Z axis.</font>
mc Axis Remove Override Axis Sync( m Inst, AXIS_ 8, ZAXIS );


<!-- Page 568 -->

int mc Axis Set Home Dir(
MINST ANCE m Inst, int axis Id, int dir);
rc = mc.mc Axis Set Home Dir(
number m Inst, number axis Id, number dir)
<font color="green">// Set axis 0 homing directio to POS.</font> int m Inst
= 0;
mc Axis Set Home Dir(m Inst, 0, 1);


<!-- Page 569 -->

int mc Axis Set Home In Place(
MINST ANCE m Inst, int axis Id, BOOL home In Place);
rc = mc.mc Axis Get Home In Place(
number m Inst, number axis Id, number home In Place)
<font color="green">// Set the Home In Place flag for the X axis.</font>
MINST ANCE m Inst = 0;
BOOL hip = F ALSE;
mc Axis Get Home In Place(m Inst, X_AXIS, hip);


<!-- Page 570 -->

int mc Axis Set Home Of fset(
MINST ANCE m Inst, int axis Id, double of fset);
rc = mc Axis Set Home Of fset(
number m Inst, number axis Id, number of fset);
<font color="green">// Set the home of fset for axis 0.</font> int m Inst = 0;
mc Axis Set Home Of fset(m Inst, 0, 1.5 <font color="green">/* inches
*/</font>);


<!-- Page 571 -->

int mc Axis Set Home Order(
MINST ANCE m Inst, int axis Id, int order);
rc = mc.mc Axis Set Home Order(
number m Inst, number axis Id, number order)
int m Inst=0;
<font color="green">// Set the order of homming so the Z axis will home
first then the X and Y .</font> mc Axis Set Home Order(m Inst, Z_AXIS , 0);
mc Axis Set Home Order(m Inst, X_AXIS , 1); mc Axis Set Home Order(m Inst,
Y_AXIS , 1);


<!-- Page 572 -->

int mc Axis Set Home Speed(
MINST ANCE m Inst, int axis, double percent);
rc = mc.mc Axis Set Home Speed(
number m Inst, number axis, number percent);
<font color="green">// Set the homing speed for axis 0 as a percentage of
the max velocity .</font> int m Inst = 0;
mc Axis Set Home Speed(m Inst, 0, 2 0.5 <font color="green">/* percent
*/</font>);


<!-- Page 573 -->

int mc Axis Set Info Struct(
MINST ANCE m Inst, int axis ID,
axisinfo_t *ainf);
N/A
```
struct axisinfo {
bool Out Of Band Axis; bool Is Still; // Set high when the axis is not
moving int Jogging; // Used to tell to jog...
int Homing; // Used to tell the state of the home operation.
int Id; // Axis Id bool Is Spindle; // Does this axis control a spindle?
bool Enabled; // Is axis enabled?
bool Softlimit Enabled; // Softlimits enabled?
double Soft Max Limit; // Count for the max travel.
double Soft Min Limit; // Count for the min travel.
bool V elocity Mode; // Used to make the axis move at a fixed speed bool
Buffer Jog; double Pos; // Position in user units.
double Mpos; // Machine position in user units.
int Home Order; // The order in which to home the axis.
```
};
int m Inst = 0;
axisinfo_t ainf;


<!-- Page 574 -->

mc Axis Get Info Struct(m Inst, Y_AXIS, &ainf);<font color="green">// Get
Y_AXIS info structure.</font> ainf.Home Order = 1;<font color="green">//
Set Y_AXIS home order to 1.</font> mc Axis Set Info Struct(m Inst,
Y_AXIS, &ainf);<font color="green">// Set Y_AXIS info structure.</font>


<!-- Page 575 -->

int mc Axis Set Machine Pos(
MINST ANCE m Inst, int axis, double val);
rc = mc.mc Axis Set Machine Pos(
number m Inst, number axis, number val)
<font color="green">// Set axis 0 fisxture of fset.</font> int m Inst = 0;
mc Axis Set Machine Pos(m Inst, 0, 0.0 <font color="green">/* set part zero
*/</font>);


<!-- Page 576 -->

int mc Axis Set Override Axis(
MINST ANCE m Inst, int axis Td, int axis T o Override Id);
rc = mc.mc Axis Set Override Axis(
number m Inst, number axis Id, number axis T o Override Id)
int m Inst = 0;
int homed = 0;
<font color="green">// Set the axis 8 to be the override axis for the Z axis.
</font> mc Axis Set Override Axis(m Inst, AXIS_ 8, ZAXIS);


<!-- Page 577 -->

int mc Axis Set Pos(
MINST ANCE m Inst, int axis Id, double val);
rc = mc.mc Axis Set Pos(
number m Inst, number axis Id, number val);
int m Inst=0;
double XAxis Pos = .5;
int Axis Number = X_AXIS; <font color="green">// Set the position of the
X axis by changing the fixture of fset.</font> mc Axis Set Pos(m Inst,
Axis Number , XAxis Pos);


<!-- Page 578 -->

int mc Axis Set Softlimit Enable(
MINST ANCE m Inst, int axis, int enabel);
rc = mc.mc Axis Set Softlimit Enable(
number m Inst, number axis, number enabel)
<font color="green">// Diable softlimits on axis 0</font> MINST ANCE
m Inst = 0;
mc Axis Set Softlimit Enable(m Inst, 0,0);


<!-- Page 579 -->

int mc Axis Set Softlimit Max(
MINST ANCE m Inst, int axis Id, double max);
rc = mc.mc Axis Set Softlimit Max(
number m Inst, number axis Id, number max);
int m Inst=0;
int axis = Y_AXIS;
double max = 2 0;
mc Axis Get Softlimit Max( m Inst, axis, max);<font color="green">// Set the
max distance of the softlimit for the Y axis to 2 0 units.</font>


<!-- Page 580 -->

int mc Axis Set Softlimit Min(
MINST ANCE m Inst, int axis Id, double min);
rc = mc.mc Axis Set Softlimit Min(
number m Inst, number axis Id, number min);
int m Inst=0;
int axis = Y_AXIS;
double min = 2 0;
mc Axis Get Softlimit Min( m Inst, axis, min);<font color="green">// Set the
min distance of the softlimit for the Y axis to 2 0 units.</font>


<!-- Page 581 -->

int mc Axis Set Spindle(
MINST ANCE m Inst, int axis Id, BOOL spindle);
rc = mc.mc Axis Set Spindle(
number m Inst, number axis Id, number spindle)
<font color="green">// Set axis 6 as a spindle axis.</font> MINST ANCE
m Inst = 0;
mc Axis Set Spindle(m Inst, 6, true);


<!-- Page 582 -->

mc Axis Set V el
C/C++ Syntax:
int mc Axis Set Vel(
MINSTANCE m Inst,
int axis,
double velocity);

Description: Not used at this time.


<!-- Page 583 -->

int mc Axis Unmap Motor(
MINST ANCE m Inst, int axis Id, int motor);
rc = mc.mc Axis Unmap Motor(
number m Inst, number axis Id, number motor)
int m Inst = 0;
<font color="green">// Remove motor 6 from the Y axis.</font>
mc Axis Unmap Motor(m Inst, Y_AXIS, MOT OR 6);


<!-- Page 584 -->

int mc Axis Unmap Motors(
MINST ANCE m Inst, int axis Id);
rc = mc.mc Axis Unmap Motors(
number m Inst, number axis Id)
int m Inst = 0;
<font color="green">// Remove all motors from the Y axis.</font>
mc Axis Unmap Motors(m Inst, Y_AXIS);


<!-- Page 585 -->

int mc Axis Unregister(
MINST ANCE m Inst, int axis Id);
rc = mc.mc Axis Unregister(
number m Inst, number axis Id)
int m Inst=0;
<font color="green">// Remove AXIS 7 from frome the system.</font>
mc Axis Unregister(m Inst, AXIS 7);


<!-- Page 586 -->

int mc Cntl Check License Feature(
```
MINST ANCE m Inst, const char *lic File, const char *requirement, const
char *feature);
rc = mc Cntl Check License Feature(
number m Inst, string lic File, string requirement, string feature);
<font color="green">// Check the Darwin Lic.dat file for feature
M 4 _DAR WIN</font> MINST ANCE m Inst = 0;
int rc = mc Cntl Check License Feature(m Inst, "Darwin Lic.dat",
```
"NF_DAR WIN", "M 4 _DAR WIN"); if (rc != MERROR_NOERROR) {
```
<font color="green">// Feature found!!!</font> return; }


<!-- Page 587 -->

int mc Cntl Cleanup(MINST ANCE m Inst);
N/A
None.
<font color="green">// Cleanup core instance 0</font> MINST ANCE
m Inst = 0; int rc = mc Cntl Cleanup(m Inst);


<!-- Page 588 -->

int mc Cntl Close GCode File(
MINST ANCE m Inst);
rc = mc.mc Cntl Close GCode File(
number m Inst)
int m Inst=0;
mc Cntl Close GCode File(m Inst); <font color="green">// Close the Gcode
file in controller 0.</font>


<!-- Page 589 -->

int mc Cntl Compile Scripts(
MINST ANCE m Inst);
rc = mc.mc Cntl Compile Scripts(
number m Inst);
<font color="green">// Compaile all scripts</font> MINST ANCE m Inst =
0;
int rc = mc Cntl Compile Scripts(m Inst);


<!-- Page 590 -->

int mc Cntl Config Start(
MINST ANCE m Inst);
rc = mc.mc Cntl Config Start(
number m Inst);
<font color="green">// Enter the configure state</font> MINST ANCE
m Inst = 0;
```
if (mc Cntl Config Start(m Inst) == MERRROR_NOERROR) {
```
<font color="green">// Successfully entered the configure state!</font> }


<!-- Page 591 -->

int mc Cntl Config Stop(
MINST ANCE m Inst);
rc = mc.mc Cntl Config Stop(
number m Inst);
<font color="green">// Leave the configure state.</font> MINST ANCE
m Inst = 0; int rc = mc Cntl Config Stop(m Inst); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Successfully exited the configure state.</font> }


<!-- Page 592 -->

int mc Cntl Create Local V ars(
MINST ANCE m Inst,
```
const char *line Params, unsigned long *handle)
h Params, rc = mc.mc Cntl Create Local V ars(
number m Inst,
string line Params);
<font color="green">--Example m 1 9 script that takes parameters</font>
```
<br/> function m 1 9(h Param) <font color="green">--h Param is a handle to
all parameters on same line as m 1 9 --The R and P params are optional. M 1 9
R 9 0 P 0 for example.</font> <font color="green">--R is angle from 0 to
3 6 0.</font> <font color="green">--P is direction: 0 == shortest angle, 1 ==
clockwise, 2 == counterclockwise</font> <font color="green">--Fanuc
```
uses S for angle</font> local inst = mc.mc Get Instance() local pcall Ret =
true
local stat = 1
local msg Pre = "M 1 9 macro says "
local msg = "M 1 9 Completed successfully"
```
local var R = 0
```
local var P = 0
if (h Param ~= nil) then local rc, flag R, flag P
flag R, rc = mc.mc Cntl Get Local V ar Flag(inst, h Param, mc.SV_R) flag P , rc
= mc.mc Cntl Get Local V ar Flag(inst, h Param, mc.SV_P) if (flag R == 1) then
<font color="green">--Check that the flag has been set so we do not get an
```
unexpected value for mc.SV_R</font> var R = mc.mc Cntl Get Local V ar(inst,
```
h Param, mc.SV_R) if (var R < 0) or (var R > 3 6 0) then <font


<!-- Page 593 -->

```
color="green">--It is out of range</font> msg = string.format("var R == " ..
```
var R .. " and is out of range (0-3 6 0)") mc.mc Cntl Cycle Stop(inst) return
end
end

if (flag P == 1) then <font color="green">--Check that the flag has been
```
set so we do not get an unexpected value for mc.SV_P</font> var P =
mc.mc Cntl Get Local V ar(inst, h Param, mc.SV_P) <font color="green">--
```
fixup the values to pass to the spindleorient script.</font> if (var P == 0)
then
```
var P = mc.MC_SPINDLE_ST OP <font color="green">-- 0</font> elseif
```
(var P == 1) then var P = mc.MC_SPINDLE_FWD <font color="green">--
```
1</font> elseif (var P == 2) then var P = mc.MC_SPINDLE_REV <font
color="green">-- -1</font> else
```
msg = string.format("var P == " .. var P .. " and is out of range (0-2)")
mc.mc Cntl Cycle Stop(inst) return
end
end
end

```
pcall Ret, stat, msg = pcall(spindleorient, var R, var P); <font
color="green">--Call the spindleorient.mcs script</font>
mc.mc Cntl Set Last Error(inst, msg Pre .. msg)
if (pcall Ret == false) then mc.mc Cntl Cycle Stop(inst) end


<!-- Page 594 -->

end

```
if (mc.mc In Editor() == 1) then
<font color="green">--W e are testing the script in the editor .</font>
```
<font color="green">--Fab up some paramters to pass to our m 1 9()
```
function.</font> local inst = mc.mc Get Instance() local h Params, rc = <font
color="blue">mc.mc Cntl Create Local V ars</font>(inst, "R 3 2 0 P 0")<font
color="green">--Like we are testing "M 1 9 R 3 2 0 P 0".</font>
```
m 1 9(h Params) <font color="green">--Call m 1 9() with h Params.</font> end


<!-- Page 595 -->

int mc Cntl Cycle Start(
MINST ANCE m Inst);
rc = mc.mc Cntl Cycle Start(
number m Inst)
int m Inst=0;
<font color="green">// Start controller 0's Gcode file.</font>
mc Cntl Cycle Start(m Inst);


<!-- Page 596 -->

int mc Cntl Cycle Stop(
MINST ANCE m Inst);
rc = mc.mc Cntl Cycle Stop(
number m Inst)
int m Inst=0;
<font color="green">// Stop controller 0's Gcode file.</font>
mc Cntl Cycle Stop(m Inst);


<!-- Page 597 -->

int mc Cntl Dry Run T o Line(
MINST ANCE m Inst, int line);
rc = mc.mc Cntl Dry Run T o Line(
number m Inst, number line)
<font color="green">// Dry run to line 3 8</font> MINST ANCE m Inst = 0;
int rc = mc Cntl Dry Run T o Line(m Inst, 3 8);


<!-- Page 598 -->

int mc Cntl EStop(
MINST ANCE m Inst);
rc = mc.mc Cntl EStop(
number m Inst)
<font color="green">// Put the control in the default state when e-stop is
asserted.</font> MINST ANCE m Inst = 0; int rc = mc Cntl EStop(m Inst);


<!-- Page 599 -->

int mc Cntl Enable(
MINST ANCE m Inst, BOOL state);
rc = mc.mc Cntl Enable(
number m Inst, number state)
<font color="green">// Enable the control.</font> MINST ANCE m Inst = 0;
int rc = mc Cntl Enable(m Inst, TRUE);


<!-- Page 600 -->

int mc Cntl Feed Hold(
MINST ANCE m Inst);
rc = mc.mc Cntl Feed Hold(
number m Inst)
int m Inst = 0; int rc;
rc = mc Cntl Feed Hold(m Inst); <font color="green">// Pause the motion of
```
controller 0.</font> if (rc == MERROR_NOERROR) {
```
<font color="green">// Feed hold was successful.</font> }


<!-- Page 601 -->

int mc Cntl Feed Hold State(
MINST ANCE m Inst, BOOL *In Feed Hold);
In Feed Hold, rc = mc.mc Cntl Feed Hold State(
number m Inst)
int m Inst = 0; int rc;
BOOL fh State; rc = mc Cntl Feed Hold State(m Inst, &fh State); <font
color="green">// Pause the motion of controller 0.</font> if (rc ==
```
MERROR_NOERROR && fh State == TRUE) {
```
<font color="green">// The control is in Feedhold.</font> }


<!-- Page 602 -->

int mc Cntl Gcode Execute(
```
MINST ANCE m Inst, const char *commands);
rc = mc.mc Cntl Gcode Execute(
number m Inst, string commands)
<font color="green">// Execute spindle stop and rapid to 0, 0.</font>
MINST ANCE m Inst = 0;
int rc;
rc = mc Cntl Gcode Execute(m Inst, "M 0 5\n G 0 0 X 0 Y 0"); if (rc ==
```
MERROR_NOERROR) {
<font color="green">// The G code was submitted for processing.</font>
```
<font color="green">// However , the function return immediately and does
```
not wait on the G code to finish.</font> }


<!-- Page 603 -->

int mc Cntl Gcode Execute W ait(
```
MINST ANCE m Inst, const char *commands);
rc = mc.mc Cntl Gcode Execute W ait(
number m Inst, string commands)
<font color="green">// Execute spindle stop and rapid to 0, 0.</font>
MINST ANCE m Inst = 0;
int rc;
rc = mc Cntl Gcode Execute W ait(m Inst, "M 0 5\n G 0 0 X 0 Y 0"); if (rc ==
```
MERROR_NOERROR) {
<font color="green">// The G code was submitted for processing and has
```
completed.</font> }


<!-- Page 604 -->

int mc Cntl Gcode Interp Get Data(
MINST ANCE m Inst, interperter_t *data);
N/A
```
struct Interperter_info {
double Modal Groups[MC_MAX_GROUPS]; double Feed Rate; double
Spindle Speed; int Spindle Direction; BOOL Mist; BOOL Flood; int
```
Tool Number; int Height Register; int Dia Register; };
```
typedef struct Interperter_info interperter_t;
<font color="green">// Get the interpreter information.</font>
MINST ANCE m Inst = 0;
interperter_t data;
int rc;
rc = mc Cntl Gcode Interp Get Data(m Inst, &data); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 605 -->

int mc Cntl Gcode Interp Get Pos(
MINST ANCE m Inst, int axis Id, double *pos);
pos, rc = mc.mc Cntl Gcode Interp Get Pos(
number m Inst, number axis Id)
<font color="green">// Get the current buf fered X axis position.</font>
MINST ANCE m Inst = 0; double pos;
int rc;
rc = int mc Cntl Gcode Interp Get Pos(m Inst, X_AXIS, &pos); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 606 -->

int mc Cntl Get Block Delete(
MINST ANCE m Inst, int delete Id, BOOL *val);
val, rc = mc.mc Cntl Get Block Delete(
number m Inst, number delete Id)
<font color="green">// Is block delete 0 on?</font> MINST ANCE m Inst =
0;
BOOL val;
int rc = mc Cntl Get Block Delete(m Inst, 0, &val); if (rc ==
```
MERROR_NOERROR) {
```
if (val == TRUE) {
```
<font color="green">// Is block delete 0 is on!</font> } else {
```
<font color="green">// Is block delete 0 is of f!</font> }
```
}


<!-- Page 607 -->

int mc Cntl Get Build(
MINST ANCE m Inst, char *buf, size_t bufsize);
build, rc = mc.mc Cntl Get Build(
number m Inst)
<font color="green">// Get the core's build number</font> MINST ANCE
m Inst = 0; char build Buf[8 0];
int rc = mc Cntl Get Build(m Inst, build Buf, sizeof(build Buf)); if (rc ==
```
MERROR_NOERROR) {
```
printf("The current build is %s.n", build Buf); }


<!-- Page 608 -->

int mc Cntl Get Computer ID(
MINST ANCE m Inst, char *buf, size_t buf Size);
buf, rc = mc.mc Cntl Get Computer ID(
number m Inst)
<font color="green">// Get the ID(s) for this host</font> MINST ANCE
m Inst = 0;
int rc = mc Cntl Get Computer ID(m Inst, buf, sizeof(buf)); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Parse buf to get the ID(s)</font> }


<!-- Page 609 -->

int mc Cntl Get Coolant Delay(
MINST ANCE m Inst, double *secs);
sec, rc = mc.mc Cntl Get Coolant Delay(
number m Inst)
<font color="green">// Get the coolant delay .</font> MINST ANCE m Inst =
0;
double secs;
int rc = mc Cntl Get Coolant Delay(m Inst, &secs); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 610 -->

int mc Cntl Get Cwd(
MINST ANCE m Inst, char *buf, size_t buf Size);
buf, rc = mc.mc Cntl Get Cwd(
number m Inst)
<font color="green">// Get current working directory .</font>
MINST ANCE m Inst = 0;
char cur Dir[2 5 5];
int rc = mc Cntl Get Cwd(m Inst, cur Dir , sizeof(cur Dir)); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 611 -->

int mc Cntl Get Dia Mode(
MINST ANCE m Inst, BOOL *dia);
dia, rc = mc.mc Cntl Get Dia Mode(
number m Inst)
<font color="green">// Get the lathe diameter mode.</font> MINST ANCE
m Inst = 0; BOOL Dia;
int rc = mc Cntl Get Dia Mode(m Inst, &Dia); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 612 -->

int mc Cntl Get Dist T o Go(
MINST ANCE m Inst, int axis Id, double *togo);
togo, rc = int mc Cntl Get Dist T o Go(
number m Inst, number axis Id)
int m Inst=0;
int axis = Y_AXIS;
double togo=0;
mc Cntl Get Dist T o Go(m Inst, axis, &togo);


<!-- Page 613 -->

int mc Cntl Get Enable FRO(
MINST ANCE m Inst, BOOL *enable);
eanbled, rc = mc.mc Cntl Get Enable FRO(
number m Inst)
<font color="green">// Get the current FRO status</font> MINST ANCE
m Inst = 0;
BOOL enabled;
int rc = mc Cntl Get Enable FRO(m Inst, &enabled); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> if (enabled == TRUE) {
```
<font color="green">// Feed Rate Override is enabled!</font> } else {
```
<font color="green">// Feed Rate Override is disabled!</font> }
```
}


<!-- Page 614 -->

int mc Cntl Get FRO(
MINST ANCE m Inst, double *percent);
percent, rc = mc.mc Cntl Get FRO(
number m Inst)
<font color="green">// Get the current FRO</font> MINST ANCE m Inst =
0; double fro;
```
int rc = mc Cntl Get FRO(m Inst, &fro); if (rc == MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 615 -->

int mc Cntl Get Gcode File Name(
MINST ANCE m Inst, char *buf, size_t buf Size);
buf, rc = mc.mc Cntl Get Gcode File Name(
number m Inst)
<font color="green">// Get the currently loaded G code file name.</font>
MINST ANCE m Inst = 0;
char g Code File Name[2 5 5];
int rc = mc Cntl Get Gcode File Name(m Inst, g Code File Name,
```
sizeof(g Code File Name)); if (rc == MERROR_NOERROR) {
```
<font color="green">// Success.</font> }


<!-- Page 616 -->

int mc Cntl Get Gcode Line(
MINST ANCE m Inst, int Line Number , char *buf, long buf Size);
buff, rc = mc.mc Cntl Get Gcode Line(
number m Inst, number Line Number)
int m Inst=0;
int Line Number = 5; char gline[1 2 8];
gline[0] = '0';
mc Cntl Get Gcode Line(m Inst, Line Number , gline , 1 2 8); <font
color="green">// Get line number 5 from the Gocde file loaded into
controller 0.</font>


<!-- Page 617 -->

int mc Cntl Get Gcode Line Count(
MINST ANCE m Inst, double *count);
count, rc = mc.mc Cntl Get Gcode Line Count(
number m Inst)
int m Inst=0;
double count=0; mc Cntl Get Gcode Line Count(m Inst, &count);


<!-- Page 618 -->

int mc Cntl Get Gcode Line Nbr(
MINST ANCE m Inst, double *val);
val, rc = mc.mc Cntl Get Gcode Line Nbr(
number m Inst)
int m Inst=0;
double dline=0; mc Cntl Get Gcode Line Nbr(m Inst, &dline); <font
color="green">//Get the current running line number</font>


<!-- Page 619 -->

```
int mc Cntl Get Instance Handle(MINST ANCE m Inst, const char *owner ,
HMINST ANCE *h Inst);
h Inst, rc = mc.mc Cntl Get Instance Handle(
number m Inst, string owner) or

h Inst = mc.mc Get Instance(string owner)
MINST ANCE m Inst=0;
HMINST ANCE h Inst;
mc Cntl Get Instance Handle(m Inst, "My Description", &h Inst);
mc Cntl Cycle Start(h Inst); <font color="green">//W ill show in the log as
coming from "My Description"</font>


<!-- Page 620 -->

int mc Cntl Get Last Error(
MINST ANCE m Inst, char *buf, size_t buf Size);
buf, rc = mc.mc Cntl Get Last Error(
MINST ANCE m Inst)
int m Inst=0;
char error[1 2 8]; mc Cntl Get Last Error(m Inst, error , 1 2 8); <font
color="green">// Receives the last error messge for controller instance 0.
</font>


<!-- Page 621 -->

int mc Cntl Get Last Log Msg(
MINST ANCE m Inst, char *buf, size_t buf Size);
buf, rc = mc.mc Cntl Get Last Log Msg(
number m Inst)
int m Inst=0;
char msg[1 2 8]; mc Cntl Get Last Log Msg(m Inst, msg, 1 2 8); <font
color="green">// Receives the last log messge for controller instance 0.
</font>


<!-- Page 622 -->

int mc Cntl Get License Data(
MINST ANCE m Inst, int index, char *buf, long buf Size);
buf, rc = mc.mc Cntl Get License Data(
number m Inst, number index)
<font color="green">// Get the license data at index 1.</font>
MINST ANCE m Inst = 0;
long len;
char *data;
long data Len = 0;
int index = 1;
int rc = mc Cntl Get License Data Len(m Inst, index, &data Len); if (rc ==
```
MERROR_NOERROR && data Len > 0) {
data = (char *)malloc(data Len + 1); memset(data, 0, data Len + 1); rc =
<font color="blue">mc Cntl Get License Data(m Inst, index, data, data Len)
```
</font>; if (rc == MERROR_NOERROR) {
```
<font color="green">// Success!</font> }
```
}


<!-- Page 623 -->

int mc Cntl Get License Data Len(
MINST ANCE m Inst, int index, long *buf Size);
buf Size, rc = mc.mc Cntl Get License Data(
number m Inst, number index)
<font color="green">// Get the license data at index 1.</font>
MINST ANCE m Inst = 0;
long len;
char *data;
long data Len = 0;
int index = 1;
int rc = <font color="blue">mc Cntl Get License Data Len(m Inst, index,
```
&data Len)</font>; if (rc == MERROR_NOERROR && data Len > 0) {
data = (char *)malloc(data Len + 1); memset(data, 0, data Len + 1); rc =
mc Cntl Get License Data(m Inst, index, data, data Len); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }
```
}


<!-- Page 624 -->

int mc Cntl Get License Modules(
MINST ANCE m Inst, unsigned long long *modules)
N/A
<font color="green">// Retrieve the licensed modules.</font>
MINST ANCE m Inst = 0;
unsigned long long modules = 0; int rc = mc Cntl Get License Modules(m Inst,
&modules);


<!-- Page 625 -->

comment, rc = mc.mc Cntl Get Local Comment(
number m Inst,
number h V ars)
```
<font color="green">-- Get local variables.</font> function m 7 0 0(h V ars)
```
local inst = mc.mc Get Instance() <font color="green">-- Get the current
instance</font> local nil Pound V ar = mc.mc Cntl Get Pound V ar(inst, 0) local
comment = <font color="blue">mc.mc Cntl Get Local Comment</font>(inst,
h Vars) local message = ""
if h V ars ~= nil then local flag, retval, rc flag, rc =
mc.mc Cntl Get Local V ar Flag(inst, h V ars, mc.SV_A) if (flag == 1) then
retval, rc = mc.mc Cntl Get Local V ar(inst, h V ars, mc.SV_A) if rc ==
mc.MERROR_NOERROR then message = message .. "A" .. ":" ..
tostring(retval) .. ", "
end
end
flag, rc = mc.mc Cntl Get Local V ar Flag(inst, h V ars, mc.SV_A) if (flag ==
1) then retval, rc = mc.mc Cntl Get Local V ar(inst, h V ars, mc.SV_B) if rc ==
mc.MERROR_NOERROR then message = message .. "B" .. ":" ..
tostring(retval) end
end
mc.mc Cntl Set Last Error(inst, message) end


<!-- Page 626 -->

end

```
if (mc.mc In Editor() == 1) then
<font color="green">--W e are testing the script in the editor .</font>
```
<font color="green">--Fab up some paramters to pass to our m 7 0 0()
```
function.</font> local inst = mc.mc Get Instance() local h Params, rc = <font
color="blue">mc.mc Cntl Create Local V ars</font>(inst, "A 2 3 B 6 (my
Comment)")<font color="green">--Like we are testing "M 7 0 0 A 2 3 B 6 (my
Comment)".</font> m 7 0 0(h Params) <font color="green">-- Call m 7 0 0
with h Params.</font> end


<!-- Page 627 -->

retval, rc = mc.mc Cntl Get Local V ar(
number m Inst,
number h V ars,
```
number var Number)
```
<font color="green">-- Get local variables.</font> function m 7 0 0(h V ars)
```
local inst = mc.mc Get Instance() -- Get the current instance local
nil Pound V ar = mc.mc Cntl Get Pound V ar(inst, h V ars, 0) local message = ""
if h V ars ~= nil then local flag, retval, rc flag, rc =
mc.mc Cntl Get Local V ar Flag(inst, h V ars, mc.SV_A) if (flag == 1) then
retval, rc = mc.mc Cntl Get Local V ar(inst, h V ars, mc.SV_A) if rc ==
mc.MERROR_NOERROR then message = message .. "A" .. ":" ..
tostring(retval) .. ", "
end
end
flag, rc = mc.mc Cntl Get Local V ar Flag(inst, h V ars, mc.SV_A) if (flag ==
1) then retval, rc = mc.mc Cntl Get Local V ar(inst, h V ars, mc.SV_B) if rc ==
mc.MERROR_NOERROR then message = message .. "B" .. ":" ..
tostring(retval) end
end
mc.mc Cntl Set Last Error(inst, message) end


<!-- Page 628 -->

end

```
if (mc.mc In Editor() == 1) then
m 7 0 0(nil) <font color="green">-- W e can't test this in the editor!</font>
end


<!-- Page 629 -->

int mc Cntl Get Local V ar Flag(
MINST ANCE m Inst, HMCV ARS h V ars,
```
int var Number ,
int *retval);
retval, rc = mc.mc Cntl Get Local V ar Flag(
number m Inst,
number h V ars,
```
number var Number)
```
<font color="green">-- Get local variables.</font> function m 7 0 0(h V ars)
```
local inst = mc.mc Get Instance() -- Get the current instance local
nil Pound V ar = mc.mc Cntl Get Pound V ar(inst,0) local message = ""
if h V ars ~= nil then local flag, retval, rc flag, rc =
mc.mc Cntl Get Local V ar Flag(inst, h V ars, mc.SV_A) if (flag == 1) then
retval, rc = mc.mc Cntl Get Local V ar(inst, h V ars, mc.SV_A) if rc ==
mc.MERROR_NOERROR then message = message .. "A" .. ":" ..
tostring(retval) .. ", "
end
end
flag, rc = mc.mc Cntl Get Local V ar Flag(inst, h V ars, mc.SV_A) if (flag ==
1) then retval, rc = mc.mc Cntl Get Local V ar(inst, h V ars, mc.SV_B) if rc ==
mc.MERROR_NOERROR then message = message .. "B" .. ":" ..
tostring(retval) end
end


<!-- Page 630 -->

mc.mc Cntl Set Last Error(inst, message) end


<!-- Page 631 -->

end

```
if (mc.mc In Editor() == 1) then
m 7 0 0(nil) <font color="green">-- W e can't test this in the editor!</font>
end


<!-- Page 632 -->

int mc Cntl Get Logging(
MINST ANCE m Inst, BOOL *enabled);
enabled, rc = mc.mc Cntl Get Logging(
number m Inst)
<font color="green">// Check is logging is enabled.</font> MINST ANCE
m Inst = 0; BOOL enabled = F ALSE; int rc = mc Cntl Get Logging(m Inst,
```
&enabled); if (rc == MERROR_NOERROR && enabled == TRUE) {
<font color="green">// Logging is enabled!
```
}

</font>


<!-- Page 633 -->

int mc Cntl Get Mach Dir(
MINST ANCE m Inst, char *buf, size_t buf Size);
buf, rc = int mc Cntl Get Mach Dir(
number m Inst)
<font color="green">// Get the Mach core installation directory .</font>
MINST ANCE m Inst = 0; char inst Dir[2 5 5];
memset(inst Dir , 0, sizeof(inst Dir); int rc = mc Cntl Get Mach Dir(m Inst,
inst Dir , sizeof(inst Dir));


<!-- Page 634 -->

int mc Cntl Get Mist Delay(
MINST ANCE m Inst, double *secs);
secs, rc = mc Cntl Get Mist Delay(
number m Inst)
<font color="green">// Get the mist delay .</font> MINST ANCE m Inst = 0;
double secs;
int rc = mc Cntl Get Mist Delay(m Inst, &secs); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 635 -->

int mc Cntl Get Modal Group(
MINST ANCE m Inst, int group, double *val);
val, rc = mc.mc Cntl Get Modal Group(
number m Inst, number group)
<font color="green">// Get the modal code for modal group 1.</font>
MINST ANCE m Inst = 0;
int rc = mc Cntl Get Modal Group(m Inst, 1); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 636 -->

int mc Cntl Get Mode(
MINST ANCE m Inst, int *mode);
mode, rc = mc Cntl Get Mode(
number m Inst)
<font color="green">// Get the control mode.</font> MINST ANCE m Inst =
0; int mode;
int rc = mc Cntl Get Mode(m Inst, &mode); if (rc == MERROR_NOERROR)
```
{
```
<font color="green">// Success!</font> }


<!-- Page 637 -->

int mc Cntl Get Of fset(
MINST ANCE m Inst, int axis Id, int type,
double *of fset);
offset, rc = mc.mc Cntl Get Of fset(
number m Inst, number axis Id, number type)
<font color="green">// </font> MINST ANCE m Inst = 0;


<!-- Page 638 -->

int mc Cntl Get Optional Stop(
MINST ANCE m Inst, BOOL *stop);
stop, rc = mc.mc Cntl Get Optional Stop(
number m Inst)
<font color="green">// See if optional stop is in ef fect.</font>
MINST ANCE m Inst = 0;
BOOL op Stop = F ALSE;
int rc = mc Cntl Get Optional Stop(m Inst, &op Stop); if (rc ==
```
MERROR_NOERROR) {
```
if (op Stop == TRUE) {
<font color="green">// Optional Stop is in ef fect!
```
} else {
<font color="green">// Optional Stop is not in ef fect!
```
}
```
}

</font></font>


<!-- Page 639 -->

int mc Cntl Get Pound V ar(
MINST ANCE m Inst, int param, double *value);
value, rc = mc.mc Cntl Get Pound V ar(
number m Inst, number param)
int m Inst=0;
double Pound V ar=5 0;
dobule V alue=0;
<font color="green">;// Get the value of #5 0.</font>
mc Cntl Get Pound V ar(m Inst, Pound V ar, &V alue);


<!-- Page 640 -->

int mc Cntl Get RRO(
MINST ANCE m Inst, double *percent);
percent, rc = mc.mc Cntl Get RRO(
number m Inst)
<font color="green">// Get the current RRO</font> MINST ANCE m Inst =
0; double rro;
```
int rc = mc Cntl Get RRO(m Inst, &rro); if (rc == MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 641 -->

int mc Cntl Get Run T ime(
MINST ANCE m Inst, double *time);
int mc Cntl Get Run T ime(MINST ANCE m Inst, double *time)
<font color="green">// Get the control run time in seconds.</font>
MINST ANCE m Inst = 0; double time;
int rc = mc Cntl Get Run T ime(m Inst, &time); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 642 -->

int mc Cntl Get Single Block(
MINST ANCE m Inst, BOOL *sb State);
sb State, rc = mc.mc Cntl Get Single Block(
number m Inst)
<font color="green">// Get the state of single block.</font> int m Inst=0;
BOOL Is On = F ALSE; mc Cntl Get Single Block(m Inst, &Is On);


<!-- Page 643 -->

int mc Cntl Get State(
MINST ANCE m Inst, mc State *state);
mc State, rc = mc.mc Cntl Get State(
MINST ANCE m Inst)
<font color="green">// Get the state of controller instance 0.</font>
MINST ANCE m Inst = 0; mc State state;
char state Name[8 0]; int rc = <font color="blue">mc Cntl Get State(m Inst,
```
&state)</font>; if (rc == MERROR_NOERROR) {
<font color="green">// Success!</font> rc =
```
mc Cntl Get State Name(m Inst, state, state Name, sizeof(state Name)); }


<!-- Page 644 -->

int mc Cntl Get State Name(
MINST ANCE m Inst, mc State state, char *buf, size_t buf Size);
buf, rc = mc.mc Cntl Get State Name(
number m Inst, number state)
<font color="green">// Get the state name for controller instance 0.</font>
MINST ANCE m Inst = 0;
mc State state;
char state Name[8 0];
```
int rc = mc Cntl Get State(m Inst, &state); if (rc == MERROR_NOERROR) {
<font color="green">// Success!</font> rc = <font
color="blue">mc Cntl Get State Name(m Inst, state, state Name,
```
sizeof(state Name))</font>; }


<!-- Page 645 -->

int mc Cntl Get Stats(
MINST ANCE m Inst, mstats_t *stats);
N/A
```
struct mstats {
int cannon_buf_depth; int la_cannon_buf_depth; double total T ime;
double session T ime; double spindle T ime; long m 3 count; long m 4 count;
long m 6 count; double x Distance; double y Distance; double z Distance;
```
double a Distance; double b Distance; double c Distance; };
```
typedef struct mstats mstats_t;
<font color="green">// Get controller statistics.</font> MINST ANCE m Inst
= 0; mstats_t stats;
```
int rc = mc Cntl Get Stats(m Inst, &stats); if (rc == MERROR_NOERROR) {
```
printf("M 3 count = %dn", stats.m 3 Count); }


<!-- Page 646 -->

int mc Cntl Get T ool Of fset(
MINST ANCE m Inst, int axis Id, double *of fset);
offset, rc = mc.mc Cntl Get T ool Of fset(
number m Inst, number axis Id)
int m Inst=0;
int toolnum = 5; double val = 0; mc Cntl Get T ool Of fset(m Inst, Z_AXIS,
&val); <font color="green">// Get the tool of fset distance for the Z axis..
</font>


<!-- Page 647 -->

int mc Cntl Get Units Current(
MINST ANCE m Inst, int *units);
units, rc = mc.mc Cntl Get Units Current(
number m Inst)
<font color="green">// Get the current machine units.</font>
MINST ANCE m Inst = 0;
int units;
int rc = mc Cntl Get Units Current(m Inst, &units); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 648 -->

int mc Cntl Get Units Default(
MINST ANCE m Inst, int *units);
units, rc = mc.mc Cntl Get Units Default(
number m Inst)
<font color="green">// Get the default machine units.</font> MINST ANCE
m Inst = 0;
int units;
int rc = mc Cntl Get Units Default(m Inst, &units); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 649 -->

int mc Cntl Get V alue(
MINST ANCE m Inst, int val Id, int param, double *value);
value, rc = mc.mc Cntl Get V alue(
number m Inst, number val Id, number param)
int m Inst = 0;
int motor = 1;
double value = 0;
<font color="green">// Get the motor velocity of motor 1.</font> int rc =
mc Cntl Get V alue(m Inst, V AL_MOT OR_VEL, motor , &value);


<!-- Page 650 -->

int mc Cntl Get V ersion(
MINST ANCE m Inst, char *buf, size_t buf Size);
buf, rc = mc.mc Cntl Get V ersion(
number m Inst)
<font color="green">// Get the core version string.</font> MINST ANCE
m Inst = 0; char ver[8 0];
int rc = mc Cntl Get V ersion(m Inst, ver , sizeof(ver)): if (rc ==
```
MERROR_NOERROR) {
```
printf("The core version is %sn", ver); }


<!-- Page 651 -->

int mc Cntl Goto Zero(
MINST ANCE m Inst);
rc = mc.mc Cntl Goto Zero(
number m Inst)
int m Inst = 0;
mc Cntl Goto Zero(m Inst); <font color="green">// Move controller instance 0
to x,y ,z,a,b,c zero.</font>


<!-- Page 652 -->

MINST ANCE mc Cntl Init(
```
const char *Profile Name, int Controller ID);
N/A
MINST ANCE m Inst; m Inst = mc Cntl Init("Mach 4 Mill", m Inst); if (m Inst
```
>= 0) {
```
<font color="green">// A valid instance has been initialized!</font> }


<!-- Page 653 -->

int mc Cntl Is In Cycle(
MINST ANCE m Inst, BOOL *cycle);
cycle, rc = mc.mc Cntl Is In Cycle(
number m Inst)
int m Inst = 0;
BOOL In Cycle = F ALSE; bool Running File = false;
int rc = mc Cntl Is In Cycle(m Inst, &In Cycle); <font color="green">// See if a
G code file is running.</font> if(rc == MERROR_NOERROR && In Cycle
```
== TRUE){
```
Running File = true; }


<!-- Page 654 -->

int mc Cntl Is Still(
MINST ANCE m Inst, BOOL *still);
still, rc = mc.mc Cntl Is Still(
number m Inst)
<font color="green">// See if the control axes are still.</font>
MINST ANCE m Inst = 0;
BOOL still;
```
int rc = mc Cntl Is Still(m Inst, &still); if (rc == MERROR_NOERROR) {
```
if (still == TRUE) {
```
<font color="green">// All axes are still.</font> } else {
```
<font color="green">// At least one axis is moving!</font> }
```
}


<!-- Page 655 -->

int mc Cntl Load Gcode File(
```
MINST ANCE m Inst, const char *File T o Load);
rc = mc.mc Cntl Load Gcode File(
number m Inst, string File T o Load)
int m Inst=0;
char File[1 2 8] = "C:Some Gocdefile.tap"; int rc =
mc Cntl Load Gcode File(m Inst, &char); <font color="green">// Load
```
Some Gocdefile.tap file.</font> if (rc == MERROR_NOERROR) {
```
<font color="green">// Success!</font> }


<!-- Page 656 -->

int mc Cntl Load Gcode String(
```
MINST ANCE m Inst, const char *g Code);
rc = mc.mc Cntl Load Gcode String(
```
MINST ANCE m Inst, const char *g Code);
<font color="green">// Load G code from a string.</font> MINST ANCE
m Inst = 0;
char *g Code = "%n O 1 0 0 1n G 9 0 G 9 4 G 9 1.1 G 4 0 G 4 9 G 1 7n G 2 0"
int rc = mc Cntl Load Gcode String(m Inst, g Code);


<!-- Page 657 -->

int mc Cntl Log(
```
MINST ANCE m Inst, const char *message, const char *file, int line);
rc = mc.mc Cntl Log(
number m Inst, string message, string file, number line)
<font color="green">// Load G code from a string.</font> MINST ANCE
m Inst = 0; BOOL test = TRUE;
int rc;
```
if (test == TRUE) {
<font color="green">// File and line info in the log.</font>
```
mc Cntl Log(m Inst, "test == TRUE!", __FILE__, __LINE__); } else {
<font color="green">// No file and line info in the log.</font>
```
mc Cntl Log(m Inst, "test == F ALSE!", NULL, 0); }


<!-- Page 658 -->

int mc Cntl Machine State Clear(
MINST ANCE m Inst);
rc = mc.mc Cntl Machine State Clear(
number m Inst)
```
<font color="green">-- LUA example</font> function test()
```
local inst = mc.mc Get Instance(); <font color="green">-- push control
state to the stack.</font> mc.mc Cntl Machine State Push(inst); <font
color="green">-- put machine in G 2 0, and G 9 0 mode.</font>
mc.mc Cntl Gcode Execute W ait(inst, "G 2 0n G 9 0"); <font color="green">--
push control state to the stack.</font> mc.mc Cntl Machine State Push(inst);
<font color="green">-- put machine in G 2 1, and G 9 1 mode.</font>
mc.mc Cntl Gcode Execute W ait(inst, "G 2 1n G 9 1"); <font color="green">--
clear the machine state stack and leave the machine in G 2 1 and G 9 1 modes.
</font> mc.mc Cntl Machine State Clear(inst); end


<!-- Page 659 -->

int mc Cntl Machine State Pop(
MINST ANCE m Inst);
rc = mc.mc Cntl Machine State Pop(
number m Inst)
```
<font color="green">-- LUA example</font> function test()
```
<font color="green">-- LUA example</font> function test()
```
local inst = mc.mc Get Instance(); <font color="green">-- push control
state to the stack saving original modes.</font>
mc.mc Cntl Machine State Push(inst); <font color="green">-- put machine in
G 2 0, and G 9 0 mode.</font> mc.mc Cntl Gcode Execute W ait(inst,
"G 2 0n G 9 0"); <font color="green">-- push control state to the stack.</font>
mc.mc Cntl Machine State Push(inst); <font color="green">-- put machine in
G 2 1, and G 9 1 mode.</font> mc.mc Cntl Gcode Execute W ait(inst,
"G 2 1n G 9 1"); <font color="green">-- restore the machine state stack to G 2 0
and G 9 0 modes.</font> mc.mc Cntl Machine State Pop(inst); <font
color="green">-- restore the machine state stack to original modes.</font>
mc.mc Cntl Machine State Pop(inst); end


<!-- Page 660 -->

int mc Cntl Machine State Push(
MINST ANCE m Inst);
rc = mc.mc Cntl Machine State Push(
number m Inst)
```
<font color="green">-- LUA example</font> function test()
```
local inst = mc.mc Get Instance(); <font color="green">-- push control
state to the stack saving original modes.</font>
mc.mc Cntl Machine State Push(inst); <font color="green">-- put machine in
G 2 0, and G 9 0 mode.</font> mc.mc Cntl Gcode Execute W ait(inst,
"G 2 0n G 9 0"); <font color="green">-- push control state to the stack.</font>
mc.mc Cntl Machine State Push(inst); <font color="green">-- put machine in
G 2 1, and G 9 1 mode.</font> mc.mc Cntl Gcode Execute W ait(inst,
"G 2 1n G 9 1"); <font color="green">-- restore the machine state stack to G 2 0
and G 9 0 modes.</font> mc.mc Cntl Machine State Pop(inst); <font
color="green">-- restore the machine state stack to original modes.</font>
mc.mc Cntl Machine State Pop(inst); end


<!-- Page 661 -->

int mc Cntl Macro Alarm(
```
MINST ANCE m Inst int error , const char *message);
rc = mc.mc Cntl Macro Alarm(
number m Inst number error string message)
```
<font color="green">-- LUA example</font> function test()
```
local inst = mc.mc Get Instance(); mc.mc Cntl Macro Alarm(inst, 1 9, "T est
Alram") end


<!-- Page 662 -->

int mc Cntl Macro Stop(
```
MINST ANCE m Inst int error , const char *message);
rc = mc.mc Cntl Macro Stop(
number m Inst number error string message)
```
<font color="green">-- LUA example</font> function test()
```
local inst = mc.mc Get Instance(); mc.mc Cntl Macro Stop(inst, 1 9, "T est
Stop") end


<!-- Page 663 -->

int mc Cntl Mdi Execute(
```
MINST ANCE m Inst, const char *commands);
rc = mc.mc Cntl Mdi Execute(
number m Inst, string commands)
MINST ANCE m Inst = 0;
int rc;
<font color="green">// Move the machine back to xy then z zero.</font>
<font color="green">// Correct example.</font> rc =
mc Cntl Mdi Execute(m Inst, "G 0 0 G 9 0 X 0.0 Y 0.0\n Z 0.0");
<font color="green">// Incorrect example.</font> rc =
mc Cntl Mdi Execute(m Inst, "G 0 0 G 9 0 X 0.0 Y 0.0"); rc =
mc Cntl Mdi Execute(m Inst, "Z 0.0");


<!-- Page 664 -->

int mc Cntl Probe File Close(
MINST ANCE m Inst);
rc = mc.mc Cntl Probe File Close(
number m Inst)
<font color="green">-- probe file close LUA macro example.</font>
```
function m 1 1 2()
```
local inst=mc.mc Get Instance(); local rc =
mc.mc Cntl Probe File Close(inst); end

```
if (mc.mc In Editor() == 1) then m 1 1 2() end


<!-- Page 665 -->

int mc Cntl Probe File Open(
```
MINST ANCE m Inst, const char *file Name, const char *format, BOOL
over W rite);
rc = mc.mc Cntl Probe File Open(
number m Inst, string file Name, string format, number over W rite);
<font color="green">-- probe file open LUA macro example.</font>
```
function m 1 1 1()
```
local inst = mc.mc Get Instance(); local rc =
mc.mc Cntl Probe File Open(inst, 'probetest.csv', '%.4 AXIS_X, %.4 AXIS_Y ,
%.4 AXIS_Z\r\n', TRUE); end

```
if (mc.mc In Editor() == 1) then m 1 1 1() end


<!-- Page 666 -->

int mc Cntl Probe Get Strike Status(
MINST ANCE m Inst, BOOL *did Strike);
didstrike, rc = mc.mc Cntl Probe Get Strike Status(
number m Inst)
<font color="green">-- probe get strike status example.</font>
```
local inst = mc.mc Get Instance()
local did Strike, rc = mc.mc Cntl Probe Get Strike Status(inst)


<!-- Page 667 -->

int mc Cntl Reset(
MINST ANCE m Inst);
rc = mc.mc Cntl Reset(
number m Inst)
MINST ANCE m Inst = 0; mc Cntl Reset(m Inst); <font color="green">//
Reset controller instance 0.</font>


<!-- Page 668 -->

int mc Cntl Rewind File(
MINST ANCE m Inst);
rc = mc.mc Cntl Rewind File(
number m Inst)
MINST ANCE m Inst = 0; mc Cntl Rewind File(m Inst); <font
color="green">// Rewind controller 0's Gcode file.</font>


<!-- Page 669 -->

int mc Cntl Set Block Delete(
MINST ANCE m Inst, int delete ID, BOOL enabled);
rc = mc.mc Cntl Set Block Delete(
number m Inst, number delete ID, number enabled)
MINST ANCE m Inst = 0;
<font color="green">// Enable block delete level 0.</font>
mc Cntl Set Block Delete(m Inst, 0, TRUE);


<!-- Page 670 -->

int mc Cntl Set Coolant Delay(
MINST ANCE m Inst, double secs);
rc = mc.mc Cntl Set Coolant Delay(
number m Inst, number secs);
<font color="green">// Set 3/4 second coolant delay .</font> MINST ANCE
m Inst = 0;
int rc = mc Cntl Set Coolant Delay(m Inst, .7 5 0);


<!-- Page 671 -->

int mc Cntl Set Dia Mode(
MINST ANCE m Inst, BOOL enable);
rc = mc.mc Cntl Set Dia Mode(
number m Inst, number enable);
<font color="green">// Enable diamter mode</font> MINST ANCE m Inst =
0; int rc = mc Cntl Set Dia Mode(m Inst, TRUE);


<!-- Page 672 -->

int mc Cntl Set Enable FRO(
MINST ANCE m Inst, BOOL enable);
rc = mc.mc Cntl Set Enable FRO(
number m Inst, number enable);
<font color="green">// Enable feed rate override</font> MINST ANCE
m Inst = 0;
int rc = mc Cntl Set Enable FRO(m Inst, TRUE);


<!-- Page 673 -->

int mc Cntl Set FRO(
MINST ANCE m Inst, double percent);
rc = mc.mc Cntl Set FRO(
number m Inst, number percent);
<font color="green">// Set feed rate override to 1 5 0%</font>
MINST ANCE m Inst = 0; int rc = mc Cntl Set FRO(m Inst, 1 5 0.0);


<!-- Page 674 -->

int mc Cntl Set Gcode Line Nbr(
MINST ANCE m Inst, double line);
int m Inst=0; mc Cntl Set Gcode Line Nbr(m Inst, 1 0); <font color="green">//
Set the Gcode file to be at line 1 0.</font>


<!-- Page 675 -->

int mc Cntl Set Last Error(
```
MINST ANCE m Inst, const char *emsg);
rc = mc.mc Cntl Set Last Error(
number m Inst, string emsg)
MINST ANCE m Inst = 0;
char *erbuf = "T ool no longer in the spindle"; <font color="green">// Send
an error messge for controller 0.</font> int rc = mc Cntl Set Last Error(m Inst,
erbuf);


<!-- Page 676 -->

int mc Cntl Set Logging(
MINST ANCE m Inst, BOOL enable);
rc = mc.mc Cntl Set Logging(
number m Inst, number enable)
<font color="green">// Enable logging.</font> MINST ANCE m Inst = 0;
int rc = mc Cntl Set Logging(m Inst, enable);


<!-- Page 677 -->

int mc Cntl Set Mist Delay(
MINST ANCE m Inst, double secs);
rc = mc.mc Cntl Set Mist Delay(
number m Inst, number secs);
<font color="green">// Set the mist delay to 3/4 of a second.</font>
MINST ANCE m Inst = 0;
int rc = mc Cntl Set Mist Delay(m Inst, .7 5 0);


<!-- Page 678 -->

int mc Cntl Set Mode(
MINST ANCE m Inst, double mode);
rc = mc.mc Cntl Set Mode(
number m Inst, number mode)
<font color="green">// Set the interpreter mode to Lathe Diameter .</font>
MINST ANCE m Inst = 0; int rc = mc Cntl Set Mode(m Inst,
MC_MODE_LA THE_DIA);


<!-- Page 679 -->

int mc Cntl Set Optional Stop(
MINST ANCE m Inst, BOOL enable);
rc = mc.mc Cntl Set Optional Stop(
number m Inst number enable)
<font color="green">// Enable optional stop.</font> MINST ANCE m Inst =
0;
int rc = mc Cntl Set Optional Stop(m Inst, TRUE);


<!-- Page 680 -->

mc Cntl Set Pound V ar(
MINST ANCE m Inst, int param, double value);
mc Cntl Set Pound V ar(
number m Inst, number param, number value)
MINST ANCE m Inst = 0; int Pound V ar = 5 0;
dobule V alue=2 1;
<font color="green">// Set the value of #5 0 to 2 1.</font> int rc =
mc Cntl Set Pound V ar(m Inst, Pound V ar, Value);


<!-- Page 681 -->

int mc Cntl Set RRO(
MINST ANCE m Inst, double percent);
rc = mc.mc Cntl Set RRO(
number m Inst, number percent);
<font color="green">// Set feed rapid override to 5 0%</font>
MINST ANCE m Inst = 0; int rc = mc Cntl Set RRO(m Inst, 5 0.0);


<!-- Page 682 -->

int mc Cntl Set Reset Codes(
```
MINST ANCE m Inst, const char *reset Codes);
rc = mc.mc Cntl Set Reset Codes(
number m Inst, string reset Codes)
<font color="green">// Set the G code used to reset the controller instance
0.</font> MINST ANCE m Inst = 0;
int rc = mc Cntl Set Reset Codes(m Inst, "G 4 0 G 2 0 G 9 0 G 5 2 X 0 Y 0
Z 0\n G 9 2.1 G 6 9");


<!-- Page 683 -->

int mc Cntl Set Single Block(
MINST ANCE m Inst, BOOL enable);
<font color="green">// Enable single block mode.</font> MINST ANCE
m Inst = 0;
mc Cntl Set Single Block(m Inst, TRUE);


<!-- Page 684 -->

int mc Cntl Set Stats(
MINST ANCE m Inst, mstats_t *stats);
N/A
<font color="green">// </font> MINST ANCE m Inst = 0;


<!-- Page 685 -->

int mc Cntl Set V alue(
MINST ANCE m Inst, int val Id, int param, double value);
rc = mc.mc Cntl Set V alue(
number m Inst, number val Id, number param, number value)
MINST ANCE m Inst = 0; int motor = 1;
value=1 0 0 0.0;
<font color="green">// Set the V elocity of the motor to 1 0 0 0.0 .</font> in
rc = mc Cntl Set V alue(m Inst, V AL_MOT OR_VEL, motor , value);


<!-- Page 686 -->

int mc Cntl Start Motion Dev(
MINST ANCE m Inst);
rc = mc.mc Cntl Start Motion Dev(
number m Inst)
<font color="green">// Start the selected motion device.</font>
MINST ANCE m Inst = 0;
int rc = mc Cntl Start Motion Dev(m Inst);


<!-- Page 687 -->

int mc Cntl Stop Motion Dev(
MINST ANCE m Inst);
rc = mc.mc Cntl Stop Motion Dev(
number m Inst);
<font color="green">// Stop the selected motion device.</font>
MINST ANCE m Inst = 0;
int rc = mc Cntl Stop Motion Dev(m Inst);


<!-- Page 688 -->

int mc Cntl T ool Change Manual(
MINST ANCE m Inst);
rc = mc.mc Cntl T ool Change Manual(
number m Inst)
<font color="green">-- LUA example</font> local inst =
```
mc.mc Get Instance(); local rc = mc.mc Cntl T ool Change Manual(inst);


<!-- Page 689 -->

int mc Cntl W ait On Cycle Start(
```
MINST ANCE m Inst, const char *msg, int time Out Ms);
rc = mc.mc Cntl W ait On Cycle Start(
number m Inst, string msg, number time Out Ms);
<font color="green">-- LUA example</font> local inst =
```
mc.mc Get Instance();
local rc = mc.mc Cntl W ait On Cycle Start(inst, "Please press Cycle Start.",
1 0 0 0);


<!-- Page 690 -->

int mc Device Get Handle(
MINST ANCE m Inst, int devid, HMCDEV *h Dev);
h Dev , rc = mc.mc Device Get Handle(
number m Inst, number devid)
int m Inst = 0;
int devid = 0;
HMCDEV h Dev;
//See if we can find a device with an I of zero int rc = <font
color="blue">mc Device Get Handle(m Inst, devid, &h Dev);</font> if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// W e found it!</font> }


<!-- Page 691 -->

int mc Device Get Info(
HMCDEV h Dev , char *name Buf, size_t name Buflen, char *desc Buf,
size_t desc Buflen, int *type, int *id);
```
name Buf, desc Buf, type, id, rc = mc.mc Device Get Info(HMCDEV h Dev}
int m Inst=0;
HMCSIG h Dev = 0;
devinfo_t devinf;
char name Buf[8 0];
char desc Buf[8 0];
int type = 0;
int id = 0;
//Look for all the IO devices and get their devinfo_t struct while
(mc Device Get Next Handle(m Inst, DEV_TYPE_IO, h Dev , &h Dev) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
<font color="blue">mc Device Get Info(h Dev , name Buf, sizeof(name Buf),
desc Buf, sizeof(desc Buf), &type, &id);</font> <font color="green">// do
```
something with the device info.</font> } else {
```
break; }
```
}


<!-- Page 692 -->

int mc Device Get Info Struct(
HMCSIG h Dev , devinfo_t *devinf);
N/A
```
struct devinfo {
```
char dev Name[8 0]; char dev Desc[8 0]; int dev T ype; int dev Id; };
```
typedef struct devinfo devinfo_t;
int m Inst=0;
HMCSIG h Dev = 0; devinfo_t devinf;
//Look for all the IO devices and get their devinfo_t struct while
(mc Device Get Next Handle(m Inst, DEV_TYPE_IO, h Dev , &h Dev) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
<font color="blue">mc Device Get Info Struct(h Dev , devinf); </font> <font
```
color="green">// Do something with the device info.</font> } else {
```
break; }
```
}


<!-- Page 693 -->

int mc Device Get Next Handle(
MINST ANCE m Inst, int devtype, HMCDEV start Dev , HMCDEV
*h Dev);
h Dev , rc = mc.mc Device Get Next Handle(
number m Inst, number devtype, number start Dev)
int m Inst=0;
HMCDEV h Dev;
<font color="green">//Look for all the IO devices</font> while (<font
color="blue">mc Device Get Next Handle(m Inst, DEV_TYPE_IO, h Dev ,
```
&h Dev)</font> == MERROR_NOERROR) {
```
if (h Sig != 0) {
```
<font color="green">// Do something with h Dev .</font> } else {
```
break; }
```
}


<!-- Page 694 -->

mc Device Register(
```
MINST ANCE m Inst, HMCPLUG plugid, const char *Device Name,
```
const char *Device Desc, int T ype, HMCDEV *h Dev);
N/A
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id; m_timer = new sim T imer(this); m_cycletime
= .0 0 1;
<font color="blue">mc Device Register(m_cid, m_id, "Sim 0",
"Simulation Device", DEV_TYPE_MOTION | DEV_TYPE_IO,
&m_h Dev);</font>
mc Register Io(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); mc Register Io(m_h Dev , "Output 0", "Output 0",
IO_TYPE_OUTPUT , &m_Output 0);
```
if (!m_timer ->Start(1 0, wx TIMER_ONE_SHOT)) {
```
wx Message Box(wx T("T imer could not start!"), wx T("T imer")); }
```
}


<!-- Page 695 -->

int mc File Hold Aquire(
```
MINST ANCE m Inst, const char *reason, int Jog Axis Bits);
rc = mc.mc File Hold Aquire(
number m Inst, string reason, number Jog Axis Bits)
<font color="green">-- LUA example</font> local inst =
```
mc.mc Get Instance();
local rc = mc.mc File Hold Aquire(inst, "My hold reason", 0);


<!-- Page 696 -->

int mc File Hold Reason(
MINST ANCE m Inst, char *buf, long buf Size);
reason, rc = mc.mc File Hold Reason(
number m Inst)
<font color="green">-- LUA example</font> local inst =
```
mc.mc Get Instance(); local rc = mc.mc File Hold Aquire(inst, "My hold
reason", 0); loacl reason
reason, rc = mc.mc File Hold Reason(inst);


<!-- Page 697 -->

int mc File Hold Release(
MINST ANCE m Inst);
rc = mc.mc File Hold Release(
number m Inst)
<font color="green">-- LUA example</font> local inst =
```
mc.mc Get Instance(); local rc = mc.mc File Hold Aquire(inst, "My hold
reason", 0); loacl reason
reason, rc = mc.mc File Hold Reason(inst); <font color="green">-- Do some
script magic...</font> rc = mc.mc File Hold Release(inst); <font
color="green">-- G code processing resumes.</font>


<!-- Page 698 -->

int mc Fixture Load File(
```
MINST ANCE m Inst, const char *File T o Load);
rc = mc.mc Fixture Load File(
number m Inst, string File T o Load);
<font color="green">// Load a fixture table file.</font> MINST ANCE
m Inst = 0;
int rc = mc Fixture Load File(m Inst, "My Fixture T able.dat");


<!-- Page 699 -->

int mc Fixture Save File(
MINST ANCE m Inst);
rc = mc.mc Fixture Save File(
number m Inst),
<font color="green">// Save the fixture table file.</font> MINST ANCE
m Inst = 0;
int rc = mc Fixture Save File(m Inst);


<!-- Page 700 -->

int mc Gui Get W indow Handle(
MINST ANCE m Inst, void **handle);
N/A
<font color="green">// </font> MINST ANCE m Inst = 0; void *gui Handle;
rc = mc Gui Get W indow Handle(m Inst, &gui Handle);


<!-- Page 701 -->

int mc Gui Set Callback(
MINST ANCE m Inst, void *fp);
N/A
<font color="green">/* In the GUI code */</font> MCP_API <font
color="blue">int</font> MCP_APIENTR Y mc GUIMsg(MINST ANCE
m Inst, <font color="blue">long</font> msg, <font
color="blue">long</font> wparam, <font color="blue">long</font>
```
lparam) {
<font color="green">// Process messages...</font>
```
return(MERROR_NOERROR); }

MINST ANCE m Inst = 0; mc Gui Set Callback(m Inst, &mc GUIMsg);


<!-- Page 702 -->

int mc Gui Set Focus(
MINST ANCE m Inst, BOOL focus);
N/A
<font color="green">// Set focus to the GUI's main window</font>
MINST ANCE m Inst = 0; int rc = mc Gui Set Focus(m Inst, TRUE);


<!-- Page 703 -->

int mc Gui Set W indow Handle(
MINST ANCE m Inst, void *handle);
N/A
<font color="green">// Set the GUI main window handle.</font>
MINST ANCE m Inst = 0; mc Gui Set W indow Handle(0, this);


<!-- Page 704 -->

mc Io Get Handle(
```
MINST ANCE m Inst, const char *path, HMCIO *h Io);
h Io, rc = mc.mc Io Get Handle(
number m Inst, string path)
HMCIO h Io;
char *path = "Sim 0/Input 0";
<font color="blue">mc Io Get Handle(m_cid, path, &h Io);</font>


<!-- Page 705 -->

int mc Io Get Info Struct(
HMCIO h Io, ioinfo_t *ioinf);
ioinf, rc = mc.mc Io Get Info Struct(
number h Io)
```
struct ioinfo {
char io Name[8 0]; char io Desc[8 0]; int io T ype; HMCDEV io Dev;
HMCSIG io Mapped Signals[MAX_MAPPED_SIGNAL]; void
```
*io User Data; int io Input; };
```
typedef struct ioinfo ioinfo_t;
HMCDEV h Dev = 0;
devinfo_t devinf;
int rc;

<font color="green">// Get all IO information from every registered device.
</font> while (mc Device Get Next Handle(0, DEV_TYPE_IO, h Dev ,
```
&h Dev) == MERROR_NOERROR) {
```
if (mc Device Get Info Struct(h Dev , &devinf) == MERROR_NOERROR) {
HMCIO h Io = 0; while (mc Io Get Next Handle(h Dev , h Io, &h Io) ==
```
MERROR_NOERROR) {
ioinfo_t ioinf; rc = <font color="blue">mc Io Get Info Struct(h Io, &ioinf);
</font> if (rc ==


<!-- Page 706 -->

```
MERROR_NOERROR No Error .) {
```
<font color="green">// IO information successfuly retrieved.</font> }
```
}
```
}
```
}


<!-- Page 707 -->

mc Io Get Next Handle(
HMCDEV h Dev , HMCIO start Io HMCIO *h Io)
h Io, rc = mc.mc Io Get Next Handle(
number h Dev , number start Io)
HMCDEV h Dev = 0;
devinfo_t devinf;
int rc;

<font color="green">// Get all IO information from every registered device.
</font> while (mc Device Get Next Handle(0, DEV_TYPE_IO, h Dev ,
```
&h Dev) == MERROR_NOERROR) {
```
if (mc Device Get Info Struct(h Dev , &devinf) == MERROR_NOERROR) {
HMCIO h Io = 0; while (<font color="blue">mc Io Get Next Handle(h Dev ,
```
h Io, &h Io)</font> == MERROR_NOERROR) {
ioinfo_t ioinf; rc = mc Io Get Info Struct(h Io, &ioinf); if (rc ==
```
MERROR_NOERROR) {
```
<font color="green">// IO information successfuly retrieved.</font> }
```
}
```
}
```
}


<!-- Page 708 -->

mc Io Get State(
HMCIO h Io, BOOL *state);
state, rc = mc Io Get State(
number h Io)
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id; m_timer = new sim T imer(this); m_cycletime
= .0 0 1; bool oldstate = false; bool newstate = false;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
mc Io Register(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); <font color="blue">mc Io Get State(m_Input 0, &oldstate);
```
</font> newstate = sim Get IO(0); if (newstate != oldstate) {
```
mc Io Set State(m_Input 0, newstate); }
```
}


<!-- Page 709 -->

mc Io Get T ype(
HMCIO h Io, int *type);
type, rc = mc Io Get T ype(
number h Io)
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id; m_timer = new sim T imer(this); m_cycletime
= .0 0 1; bool oldstate = false; bool newstate = false;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
mc Io Register(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); <font color="blue">mc Io Get T ype(m_Input 0, &type);</font>
```
<font color="green">// type will equal IO_TYPE_INPUT</font> }


<!-- Page 710 -->

mc Io Get User Data(
HMCIO h Io, void **data);
N/A
```
struct my Data {
```
int my Port Number; int my Pin Number; };

```
void Get User Data(void) {
MINST ANCE m Inst = 0; HMCIO h Io; void *data; if
(mc Io Get Handle(m Inst, "Sim 0/Input 0", &h Io) == MERROR_NOERROR)
```
{
<font color="blue">mc Io Get User Data(h Io, &data);</font> <font
color="green">// type cast the pointer</font> struct my Data *m Data =
```
(struct my Data *)data; }
```
}


<!-- Page 711 -->

mc Io Is Enabled(
HMCIO h Io, BOOL *enabled);
enabled, rc = mc Io Is Enabled(
number h Io)
HMCIO h Io;
char *path = "Sim 0/Input 0"; BOOL enabled; mc Io Get Handle(m_cid, path,
&h Io);<font color="green">//Get the handle</font> mc Io Is Enabled(h Io ,
&enabled);<font color="green">//Get the enabled state of the IO</font>


<!-- Page 712 -->

mc Io Register(
```
HMCDEV h Dev , const char *Io Name, const char *Io Desc, int T ype,
HMCIO *h Io);
N/A
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id; m_timer = new sim T imer(this); m_cycletime
= .0 0 1;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
<font color="blue">mc Io Register(m_h Dev , "Input 0", "Input 0",
IO_TYPE_INPUT , &m_Input 0); mc Io Register(m_h Dev , "Output 0",
"Output 0", IO_TYPE_OUTPUT , &m_Output 0);</font>
```
if (!m_timer ->Start(1 0, wx TIMER_ONE_SHOT)) {
```
wx Message Box(wx T("T imer could not start!"), wx T("T imer")); }
```
}


<!-- Page 713 -->

mc Io Set Desc(
```
HMCIO h Io, const char *desc);
rc = mc.mc Io Set Desc(
number h Io, string desc)
HMCIO h Io;
char *path = "Sim 0/Input 0";
```
if (mc Io Get Handle(m_cid, path, &h Io) == MERROR_NOERROR) {
```
<font color="blue">mc Io Set Desc(h Io, "my mew description);</font> }


<!-- Page 714 -->

mc Io Set Name(
```
HMCIO h Io, const char *name);
rc = mc.mc Io Set Name(
number h Io, string name)
HMCIO h Io;
char *path = "Sim 0/Input 0";
```
if (mc Io Get Handle(m_cid, path, &h Io) == MERROR_NOERROR) {
<font color="blue">mc Io Set Name(h Io, "Limit 0++");</font> <font
```
color="green">// The name is changed from Input 0 to Limit 0++</font> }


<!-- Page 715 -->

mc Io Set State(
HMCIO h Io,
bool state);
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id;
m_timer = new sim T imer(this); m_cycletime = .0 0 1; bool oldstate =
false; bool newstate = false;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
mc Io Register(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); <font color="blue">mc Io Get State(m_Input 0, &oldstate);
```
</font> newstate = sim Get IO(0); if (newstate != oldstate) {
```
mc Io Set State(m_Input 0, newstate); }
```
}


<!-- Page 716 -->

mc Io Set T ype(
HMCIO h Io,
int type);
rc = mc Io Set T ype(
number h Io
number type)
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id;
m_timer = new sim T imer(this); m_cycletime = .0 0 1; bool oldstate =
false; bool newstate = false;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
mc Io Register(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); <font color="blue">mc Io Set T ype(m_Input 0,
IO_TYPE_OUTPUT);</font> <font color="green">// change the type to
```
IO_TYPE_OUTPUT</font> }


<!-- Page 717 -->

mc Io Set User Data(
HMCIO h Io, void **data);
N/A
```
struct my Data {
```
int my Port Number; int my Pin Number; };

struct my Data data;
```
void Get User Data(void) {
MINST ANCE m Inst = 0; HMCIO h Io; struct my Data data;
data.my Port Number = 1; data.my Pin Number = 1 2; if
(mc Io Get Handle(m Inst, "Sim 0/Input 0", &h Io) == MERROR_NOERROR)
```
{
```
<font color="blue">mc Io Set User Data(h Io, &data);</font> }
```
}


<!-- Page 718 -->

mc Io Sync Signal(
HMCIO h Io,
BOOL state);
N/A
N/A


<!-- Page 719 -->

mc Io Unregister(
HMCDEV h Dev , HMCIO h Io);
N/A

N/A


<!-- Page 720 -->

int mc Jog Abs Start(
MINST ANCE m Inst, int axis Id, double pos);
rc = mc.mc Jog Abs Start(
number m Inst, number axis Id, number pos)
MINST ANCE m Inst = 0;
int axis = Z_AXIS;
double Jog T o Pos = 5.0; <font color="green">// Jog controller 0 to position
5.0 in the Z axis.</font> mc Jog Abs Start(m Inst, axis, Jogpos);


<!-- Page 721 -->

int mc Jog Abs Stop(
MINST ANCE m Inst, int axis Id, double incr);
rc = mc.mc Jog Abs Stop(
number m Inst, number axis Id, number incr)
<font color="green">// Stop the incremental jog on the Z axis.</font>
MINST ANCE m Inst = 0; int axis = Z_AXIS;
double Joginc = .1 0 0; int rc = mc Jog Abs Stop(m Inst, axis, Joginc);


<!-- Page 722 -->

int mc Jog Get Accel(
MINST ANCE m Inst, int axis Id, double *percent);
percent, rc = mc.mc Jog Get Accel(
number m Inst, number axis)
<font color="green">// Get the jog accel percentage for the X axis.</font>
MINST ANCE m Inst = 0;
double accel;
int rc = mc Jog Get Accel(m Inst, X_AXIS, &accel);


<!-- Page 723 -->

int mc Jog Get Fee Rate(
MINST ANCE m Inst, int axis Id, double *feed Rate);
feed Rate, rc = mc.mc Jog Set Feed Rate(
number m Inst, number axis Id)
<font color="green">// Set the jog rate to 7 5% of the Z axis maximum
velocity .</font> MINST ANCE m Inst = 0;
int axis = Z_AXIS;
double feed Rate = 0.0;
int rc = mc Jog Set Units Mode(m Inst, axis, MC_UNITS_INCH); rc =
mc Jog Set Feed Rate(m Inst, axis, &feed Rate); <font color="green">// Get the
feed rate in inches per minute.</font>


<!-- Page 724 -->

mc Jog Get Follow Mode(
MINST ANCE m Inst, double *mode_on);
int m Inst=0;
double jfstat=0; mc Jog Get Follow Mode(m Inst, &jfstate);


<!-- Page 725 -->

int mc Jog Get Inc(
MINST ANCE m Inst, int axis Id, double *increment);
increment, rc = mc.mc Jog Get Inc(
number m Inst, number axis Id)
<font color="green">// Get the jog increment for the X axis.</font>
MINST ANCE m Inst = 0;
double inc;
int rc = mc Jog Get Inc Accel(m Inst, X_AXIS, &inc);


<!-- Page 726 -->

int mc Jog Get Rate(
MINST ANCE m Inst, int axis Id, double *percent);
percent, rc = mc.mc Jog Get Rate(
number m Inst, number axis Id)
<font color="green">// Get the current jog rate for the X axis</font>
MINST ANCE m Inst = 0;
double jog Rate;
int rc = mc Jog Get Rate(m Inst, X_AXIS, &jog Rate);


<!-- Page 727 -->

int mc Jog Get T race Enable(MINST ANCE m Inst, BOOL *enable);
enable, rc = mc.mc Jog Get T race Enable(number m Inst)
<font color="green">// Get jog trace enable status.</font> MINST ANCE
m Inst = 0;
int enabled = MC_F ALSE; int rc = mc Jog Get T race Enable(m Inst,
&enabled);


<!-- Page 728 -->

int mc Jog Get T ype(MINST ANCE m Inst, int axis Id, int *type);
type, rc = mc.mc Jog Get T ype(
number m Inst, number axis Id)
<font color="green">// Get the X axis jog type. </font> MINST ANCE
m Inst = 0;
int type = 0;
int rc = mc Jog Get T ype(m Inst, X_AXIS, &type);


<!-- Page 729 -->

mc Jog Get Units Mode(
MINST ANCE m Inst, int axis Id, int *mode);
int m Inst = 0; int mode = 0; mc Jog Get Units Mode(m Inst, X_AXIS,
&mode);


<!-- Page 730 -->

int mc Jog Get V elocity(
MINST ANCE m Inst, int axis Id, double *vel);
vel, rc = mc.mc Jog Get V elocity(
number m Inst, number axis Id),
<font color="green">// Get the current jog velocity setting for the X
axis</font> MINST ANCE m Inst = 0; double jog V el;
int rc = mc Jog Get V elocity(m Inst, X_AXIS, &jog V el);


<!-- Page 731 -->

int mc Jog Inc Start(
MINST ANCE m Inst, int axis Id, double dist);
rc = mc.mc Jog Inc Start(
number m Inst, number axis Id, number dist)
MINST ANCE m Inst = 0; int axis = Z_AXIS;
double Joginc = .1 0 0; <font color="green">// Jog controller 0 .1 in the Z
axis.</font> mc Jog Inc Start(m Inst, axis, Joginc);


<!-- Page 732 -->

int mc Jog Inc Stop(
MINST ANCE m Inst, int axis Id, double incr);
rc = mc.mc Jog Inc Stop(
number m Inst, number axis Id, number incr)
<font color="green">// Stop the incremental jog on the Z axis.</font>
MINST ANCE m Inst = 0; int axis = Z_AXIS;
double Joginc = .1 0 0; int rc = mc Jog Inc Stop(m Inst, axis, Joginc);


<!-- Page 733 -->

int mc Jog Is Jogging(
MINST ANCE m Inst, int axis Id, BOOL *jogging);
jogging, rc = mc.mc Jog Is Jogging(
number m Inst, number axis Id)
<font color="green">// See if the X axis is jogging.</font> MINST ANCE
m Inst = 0;
BOOL jogging = F ALSE;
int rc = mc Jog Is Jogging(m Inst, X_AXIS, &jogging);


<!-- Page 734 -->

int mc Jog Is Stopping(
MINST ANCE m Inst, int axis Id, BOOL *stopping);
stopping, rc = mc.mc Jog Is Stopping(
number m Inst, number axis Id)
<font color="green">// See if the X axis is stopping.</font> MINST ANCE
m Inst = 0;
BOOL stopping = F ALSE;
int rc = mc Jog Is Stopping(m Inst, X_AXIS, &stopping);


<!-- Page 735 -->

int mc Jog Set Accel(
MINST ANCE m Inst, int axis Id, double percent);
rc = mc.mc Jog Set Accel(
number m Inst, number axis Id, double percent)
<font color="green">// Set the X axis jog accel percentage to 7 5%.</font>
MINST ANCE m Inst = 0;
int mc Jog Set Accel(m Inst, X_AXIS, 7 5);


<!-- Page 736 -->

int mc Jog Set Fee Rate(
MINST ANCE m Inst, int axis Id, double feed Rate);
rc = mc.mc Jog Set Feed Rate(
number m Inst, number axis Id, number feed Rate)
<font color="green">// Set the jog rate to 7 5% of the Z axis maximum
velocity .</font> MINST ANCE m Inst = 0;
int axis = Z_AXIS;
int rc = mc Jog Set Units Mode(m Inst, axis, MC_UNITS_INCH); rc =
mc Jog Set Feed Rate(m Inst, axis, 2 0); <font color="green">// 2 0 inches per
minute.</font>


<!-- Page 737 -->

mc Jog Set Follow Mode(
MINST ANCE m Inst, double mode_on);
int m Inst=0; mc Jog Get Follow Mode(m Inst, MC_ON);


<!-- Page 738 -->

int mc Jog Set Inc(
MINST ANCE m Inst, int axis Id, double increment);
rc = mc.mc Jog Set Inc(
number m Inst, number axis Id, number increment)
<font color="green">// Set the X axis jog increment to .0 1 0"</font>
MINST ANCE m Inst = 0;
int rc = mc Jog Set Inc(m Inst, X_AXIS, .0 1 0);


<!-- Page 739 -->

int mc Jog Set Rate(
MINST ANCE m Inst, int axis Id, double percent);
rc = mc.mc Jog Set Rate(
number m Inst, number axis Id, number percent)
<font color="green">// Set the jog rate to 7 5% of the Z axis maximum
velocity .</font> MINST ANCE m Inst = 0; int axis = Z_AXIS;
int rc = mc Jog Set Rate(m Inst, axis, 7 5);


<!-- Page 740 -->

int mc Jog Set T race Enable(
MINST ANCE m Inst, BOOL enable);
rc = mc.mc Jog Set T race Enable(
number m Inst, number enable)
<font color="green">//Set jog tracing.</font> MINST ANCE m Inst = 0;
int rc = mc Jog Set T race Enable(m Inst, MC_TRUE);


<!-- Page 741 -->

int mc Jog Set T ype(MINST ANCE m Inst, int axis Id, int type);
rc = mc.mc Jog Set T ype(
number m Inst, number axis Id, number type)
<font color="green">// Set the X axis jog type to velocity mode. </font>
MINST ANCE m Inst = 0;
int rc = mc Jog Set T ype(m Inst, X_AXIS, MC_JOG_TYPE_VEL);


<!-- Page 742 -->

mc Jog Set Units Mode(
MINST ANCE m Inst, int axis Id, int mode);
int m Inst = 0;
mc Jog Set Units Mode(m Inst, X_AXIS, MC_UNITS_INCH);


<!-- Page 743 -->

int mc Jog V elocity Start(
MINST ANCE m Inst, int axis Id, double dir);
rc = mc.mc Jog V elocity Start(
number m Inst, number axis Id, number dir);
int m Inst=0;
int axis = Z_AXIS;
int rc = mc Jog V elocity Start(m Inst, axis, MC_JOG_POS); <font
color="green">// Start Z axis jogging for 5 sec.</font> if (rc ==
```
MERROR_NOERROR) {
```
Sleep(5 0 0 0); }
rc = mc Jog V elocity Start(m Inst, axis, MC_JOG_POS); <font
color="green">// Reverse axis and jog the axis Back.</font> if (rc ==
```
MERROR_NOERROR) {
```
Sleep(5 0 0 0); }
mc Jog V elocity Stop(m Inst, axis); <font color="green">// Stop the axis.
</font>


<!-- Page 744 -->

mc Jog V elocity Stop(
MINST ANCE m Inst, int axis Id);
mc Jog V elocity Stop(
number m Inst, number axis Id)
MINST ANCE m Inst = 0; int axis = Z_AXIS;
int rc;
<font color="green">// Jog axis at 1 0 % max velocity .</font> rc =
mc Jog Set Rate(m Inst, axis, 1 0); rc = mc Jog V elocity Start(m Inst, axis,
```
MC_JOG_POS); if (rc == MERROR_NOERROR) {
```
Sleep(5 0 0 0); }
<font color="green">// Stop the axis.</font> rc =
mc Jog V elocity Stop(m Inst, axis);


<!-- Page 745 -->

int mc Motion Clear Planner(
MINST ANCE m Inst);
rc = mc.mc Motion Clear Planner(
number m Inst)
<font color="green">// Clear the planner .</font> MINST ANCE m Inst = 0;
int rc = mc Motion Clear Planner(m Inst);


<!-- Page 746 -->

mc Motion Cycle Planner
C/C++ Syntax:
int mc Motion Cycle Planner(MINSTANCE m Inst);

LUA Syntax:
N/A

Description: Cycle the core planner .

Parameters:
Parameter Description
m Inst The controller instance.

Returns:
Return Code Description
MERROR_NOERROR No Error .
MERROR_INV ALID_INST ANCEThe m Inst
parameter was out
of range.
Notes:
```
This function is depricated in favor of mc Motion Cycle Planner Ex().
Usage:
None.


<!-- Page 747 -->

int mc Motion Cycle Planner Ex(
MINST ANCE m Inst, execution_t *ex Info);
N/A
<font color="green">// Cycle the core planner .</font> MINST ANCE m Inst
= 0; execution_t ex Info; int rc = mc Motion Cycle Planner Ex(m Inst,
&ex Info); <font color="green">// For more information, see the Sim plugin
example.

</font>


<!-- Page 748 -->

int mc Motion Get Abs Pos(
MINST ANCE m Inst, int motor Id, double *val);
N/A
None.


<!-- Page 749 -->

int mc Motion Get Abs Pos Fract(
MINST ANCE m Inst, int motor Id, double *val);
N/A
None.


<!-- Page 750 -->

int mc Motion Get Backlash Abs(
MINST ANCE m Inst, int motor Id, double *pos);
N/A
None.


<!-- Page 751 -->

int mc Motion Get Backlash Inc(
MINST ANCE m Inst, int motor Id, double *pos);
N/A
None.


<!-- Page 752 -->

int mc Motion Get Inc Pos(
MINST ANCE m Inst, int motor Id, double *val);
N/A
None.


<!-- Page 753 -->

int mc Motion Get Move ID(
MINST ANCE m Inst, int motor Id, long *val);
N/A
None.


<!-- Page 754 -->

int mc Motion Get Pos(
MINST ANCE m Inst, int motor Id, double *pos);
pos, rc = mc.mc Motion Get Pos(
number m Inst, number motor Id)
<font color="green">// Get the motor 0 position.</font> MINST ANCE
m Inst = 0;
double pos;
int rc = mc Motion Get Pos(m Inst, 0, &pos);


<!-- Page 755 -->

int mc Motion Get Probe Params(
MINST ANCE m Inst, probe_t *probe Info);
N/A
<font color="green">// Get the probing parameters from the core.</font>
MINST ANCE m Inst = 0; probe_t p Info; int
mc Motion Get Probe Params(m Inst, &p Info);


<!-- Page 756 -->

int mc Motion Get Rigid T ap Params(
MINST ANCE m Inst, tap_t *tap Info);
N/A
<font color="green">// Get the tpping parameters from the core.</font>
MINST ANCE m Inst = 0; tap_t tap Info; int rc =
mc Motion Get Rigid T ap Params(m Inst, &tap Info);


<!-- Page 757 -->

int mc Motion Get Sync Output(
MINST ANCE m Inst, int output Queue, HMCIO *h Io, BOOL *state);
N/A
<font color="green">// Retrieve the coordinated outputs/</font>
MINST ANCE m Inst = 0; execution_t ex;
mc Motion Cycle Planner Ex(m Inst, &ex); if (ex.ex Output Queue !=
```
EX_NONE) {
HMCIO h Io; BOOL state; while (mc Motion Get Sync Output(m_cid,
```
ex.ex Output Queue, &h Io, &state) == MERROR_NOERROR) {
<font color="green">// Pair setting the output along with the moves in
```
(execution_t)ex.</font> }
```
}


<!-- Page 758 -->

int mc Motion Get Thread Params(
MINST ANCE m Inst, thread_t *thread Info);
<font color="green">// </font> MINST ANCE m Inst = 0;
thread_t thread Info;
int mc Motion Get Thread Params(m Inst, &thread Info);


<!-- Page 759 -->

int mc Motion Get Threading Rate(
MINST ANCE m Inst, double *ratio);
N/A
<font color="green">// Get the current threading rate from the core.</font>
MINST ANCE m Inst = 0; double ratio; int rc =
mc Motion Get Threading Rate(m Inst, &ratio);


<!-- Page 760 -->

int mc Motion Get V el(MINST ANCE m Inst, int motor Id, double *velocity);
velocity , rc = mc.mc Motion Get V el(
number m Inst, number motor Id)
<font color="green">// Get the motor velocity for motor 1</font>
MINST ANCE m Inst = 0;
double vel;
int rc = mc Motion Get V el(m Inst, 1, &vel);


<!-- Page 761 -->

int mc Motion Set Cycle T ime(
MINST ANCE m Inst, double secs);
N/A
<font color="green">// Set the cycle time slice.</font> MINST ANCE m Inst
= 0; int mc Motion Set Cycle T ime(m Inst, .0 0 1);


<!-- Page 762 -->

int mc Motion Set Move ID(
MINST ANCE m Inst, int id);
N/A
<font color="green">// Set the currently executing movement ID.</font>
MINST ANCE m Inst = 0; int move Id = 1 0 0 0 1; <font color="green">//
Should be obtained from the motion controller .</font> int
mc Motion Set Move ID(m Inst, move Id);


<!-- Page 763 -->

int mc Motion Set Pos(
MINST ANCE m Inst, int motor Id double val);
N/A
<font color="green">// Set the motor position for motor 1.</font>
MINST ANCE m Inst = 0; motor Counts = 3 2 4 2 5 5; <font color="green">//
Should be retrieved from the motion controller .</font> int
mc Motion Set Pos(m Inst, 1, motor Counts);


<!-- Page 764 -->

int mc Motion Set Probe Complete(
MINST ANCE m Inst);
N/A
<font color="green">// Complete a probe operation.</font> MINST ANCE
m Inst = 0; int rc = mc Motion Set Probe Complete(m Inst);


<!-- Page 765 -->

int mc Motion Set Probe Pos(
MINST ANCE m Inst, int motor Id, double val);
N/A
<font color="green">// Set the probed position for motor 0.</font>
MINST ANCE m Inst = 0; double probed Pos = 2 3 1 4 1 3 4; <font
color="green">// Should be reteived from motion controller latch registers.
</font> int rc = mc Motion Set Probe Pos(m Inst, 0, double val);


<!-- Page 766 -->

int mc Motion Set Still(
MINST ANCE m Inst, int motor Id);
N/A
<font color="green">// Motor stop report example.</font> MINST ANCE
m Inst = 0; execution_t ex;
```
mc Motion Cycle Planner Ex(m_cid, &ex); switch(ex.ex T ype) {
case EX_ST OP_REQ:
// See if we need to report when the motors are still.
```
for (i = 0; i < 8; i++) {
```
if (ex.ex Motors[i].report Stopped == TRUE) {
<font color="green">// Report when this motor has completed all
```
previous moves!</font> }
```
}
break; ...
```
}


<!-- Page 767 -->

int mc Motion Set Threading Rate(
MINST ANCE m Inst, double ratio);
N/A
<font color="green">// Set the threading ratio.</font> MINST ANCE m Inst
= 0; int rc = mc Motion Set Threading Rate(m Inst, 1.2);


<!-- Page 768 -->

int mc Motion Set V el(
MINST ANCE m Inst, int motor Id, double velocity);
N/A
<font color="green">// Report the velocity for motor 0.</font>
MINST ANCE m Inst = 0; double vel = 2 3 4 2 4 2 0;<font color="green">//
Should be obtained from the motion controller .</font> int
mc Motion Set V el(m Inst, 0, vel);


<!-- Page 769 -->

int mc Motion Sync(
MINST ANCE m Inst);
N/A
<font color="green">// Synch core planner positions with the last reported
motor positions.</font> MINST ANCE m Inst = 0; int rc =
mc Motion Sync(m Inst);


<!-- Page 770 -->

int mc Motion Thread Complete(
MINST ANCE m Inst);
N/A
<font color="green">// Report that the threading op is complete.</font>
MINST ANCE m Inst = 0; int rc = mc Motion Thread Complete(m Inst);


<!-- Page 771 -->

int mc Motor Get Axis(
MINST ANCE m Inst, int motor Id, int *axis Id)
axis Id, rc = mc.mc Motor Get Axis(
number m Inst, number motor Id)
<font color="green">// Get the parent axis for motor 0.</font>
MINST ANCE m Inst = 0; int axis Id = -1;
int rc = mc Motor Get Axis(m Inst, 0, &axis Id);


<!-- Page 772 -->

int mc Motor Get Counts Per Unit(
MINST ANCE m Inst, int motor Id, double *counts)
counts, rc = mc.mc Motor Get Counts Per Unit(
number m Inst, number motor Id)
<font color="green">// Get the counts per unit for motor 0.</font>
MINST ANCE m Inst = 0;
double counts = 0.0;
int rc = mc Motor Get Counts Per Unit(m Inst, 0, &counts);


<!-- Page 773 -->

mc Motor Get Info Struct(
MINST ANCE m Inst, int motor Id,
motorinfo_t *minf);
N/A
```
struct motorinfo {
double Counts Per Unit; // Number of encoder counts or steps per unit.
double Max V elocity; // Max velocity of the axis.
double Max Acceleration; // Max rate to accelerate.
BOOL Reverse; // Is the axis reversed?
double Backlash Amount; // The amount of backlash in counts.
double Current V elocity; // The speed the axis is moving, This could be
reported by the motion deivce.
int Current Position; // The Current Position (From the motion device).
BOOL Homed; // T rue if the axis has been homed.
long Soft Max Limit; // Count for the max travel.
long Soft Min Limit; // Count for the min travel.
BOOL Can Home; // Can this motor home?
BOOL Enabled; // Is this motor enabled?
long Enable Delay; // ms to delay the enable signal for this motor .
int Axis Id; // -1 if no axis has mapped this motor .


<!-- Page 774 -->

```
};
```
typedef struct motorinfo motorinfo_t;
MINST ANCE m Inst = 0;
int m = 2;
motorinfo_t minf;
mc Motor Get Info Struct(m Inst, m, &minf); <font color="green">// Get data
for motor 2.</font>


<!-- Page 775 -->

int mc Motor Get Max Accel(
MINST ANCE m Inst, int motor Id, double *max Accel);
max Accel, rc = mc.mc Motor Get Max Accel(
number m Inst, number motor Id)
<font color="green">// Get the max accel for motor 0.</font>
MINST ANCE m Inst = 0;
double max Accel = 0.0;
int rc = mc Motor Get Max Accel(m Inst, 0, &max Accel);


<!-- Page 776 -->

int mc Motor Get Max V el(
MINST ANCE m Inst, int motor Id, double *max V el)
max V el, rc = mc.mc Motor Get Max V el(
number m Inst, number motor Id)
<font color="green">// Get the max vel for motor 0.</font> MINST ANCE
m Inst = 0;
double max V el = 0.0;
int rc = mc Motor Get Max V el(m Inst, 0, &max V el);


<!-- Page 777 -->

int mc Motor Get Pos(
MINST ANCE m Inst, int motor Id, double *val);
val, rc = mc.mc Motor Get Pos(
number m Inst, number motor Id)
MINST ANCE m Inst = 0; double Motor 1 Pos = 0; <font color="green">//
Get the position of the Motor 1.</font> mc Motor Get Pos(m Inst, 1,
&Motor 1 Pos);


<!-- Page 778 -->

int mc Motor Get V el(
MINST ANCE m Inst, int motor , double *velocity);
velocity , rc = mc.mc Motor Get V el(
number m Inst, number motor)
MINST ANCE m Inst = 0; int m = MOT OR 2;
double Current V el = 0; mc Motor Set V el(m Inst, m, &Current V el); <font
color="green">// Get the current speed of motor 2.</font>


<!-- Page 779 -->

int mc Motor Is Homed(
MINST ANCE m Inst, int motor Id, BOOL *homed);
homed, rc = mc.mc Motor Is Homed(
number m Inst, number motor Id)
MINST ANCE m Inst = 0; int m = MOT OR 2;
int Homed = 0;
mc Motor Is Homed(m Inst, m, &Homed); <font color="green">// Get the
homed state of motor 2.</font>


<!-- Page 780 -->

int mc Motor Is Still(
MINST ANCE m Inst, int motor Id, BOOL *still);
still, rc = mc.mc Motor Is Still(
number m Inst, number motor Id)
MINST ANCE m Inst = 0; int m = MOT OR 0;
int still = 0;
mc Motor Set Still(m Inst, m, &still); <font color="green">// Get the state if
MOT OR 0 is still</font>


<!-- Page 781 -->

int mc Motor Map Get Definition(
MINST ANCE m Inst, int motor Id, long *length Counts, long *num Points);
length Counts, num Points, rc = mc.mc Motor Map Get Definition(
number m Inst, number motor Id)
<font color="green">// </font> MINST ANCE m Inst = 0;
long length Counts;
long num Points;
int rc = mc Motor Map Get Definition(m Inst, 0, &length Counts,
&num Points);


<!-- Page 782 -->

int mc Motor Map Get Length(
MINST ANCE m Inst, int motor Id, int *length);
length, rc = mc Motor Map Get Length(
number m Inst, number motor Id)
<font color="green">// Get the screw length for motor zero.</font>
MINST ANCE m Inst = 0;
int length;
int rc = mc Motor Map Get Length(m Inst, 0, &length);


<!-- Page 783 -->

int mc Motor Map Get NPoints(
MINST ANCE m Inst, int motor Id, int *points);
points, rc = mc.mc Motor Map Get NPoints(
number m Inst, number motor Id)
Description: Retrieve the number of measurement points in the screw map
for the given motor .

Parameters:
Parameter Description
m Inst The controller instance.
motor Id The motor id.
pointsthe address of an integer to receive the
number of measurement points.

Returns:
Return Code Description
MERROR_NOERROR No Error .
MERROR_INV ALID_INST ANCEThe m Inst
parameter was
out of range.
MERROR_MOT OR_NOT_FOUNDThe motor
specified by
motor Id was not
found.
MERROR_INV ALID_ARG points is NULL.
Notes:
```
Depricated. Use mc Moto Map Get Point Count() instead.


<!-- Page 784 -->

int mc Motor Map Get Point(
MINST ANCE m Inst, int motor Id, int point, int *error);
error , rc = mc.mc Motor Map Get Point(
numbser m Inst, numbser motor Id, numbser point)
<font color="green">// Get the screw map error for motor 0, measurement
point 1 0.</font> MINST ANCE m Inst = 0;
int screw Err;
int rc = mc Motor Map Get Point(m Inst, 0, 1 0, &screw Err);


<!-- Page 785 -->

int mc Motor Map Get Point Count(
MINST ANCE m Inst, int motor Id, int *points);
points, rc = mc.mc Motor Map Get Point Count(
number m Inst, number motor Id)
<font color="green">// Get the number of measurement points.</font>
MINST ANCE m Inst = 0;
int points;
int rc = mc Motor Map Get Point Count(m Inst, 0, &points);


<!-- Page 786 -->

int mc Motor Map Get Start(
MINST ANCE m Inst, int motor Id, int *start Point);
start Point, rc = mc.mc Motor Map Get Start(
number m Inst, number motor Id)
<font color="green">// Get the starting point for the motor 0 screw map.
</font> MINST ANCE m Inst = 0;
int start Point;
int rc = mc Motor Map Get Start(m Inst, 0, &start Point);


<!-- Page 787 -->

int mc Motor Map Set Definition(
MINST ANCE m Inst, int motor Id, long length Counts, long num Points);
rc = mc.mc Motor Map Set Definition(
number m Inst, number motor Id, number length Counts, number
num Points)
<font color="green">// Set the screw map definition for motor 0.</font>
MINST ANCE m Inst = 0;
int rc = mc Motor Map Set Definition(m Inst, 0, 2 0 0 0 0, 2 0);


<!-- Page 788 -->

int mc Motor Map Set Length(
MINST ANCE m Inst, int motor Id, int length);
rc = mc.mc Motor Map Set Length(
number m Inst, number motor Id, number length);
<font color="green">// Set the screw length for the motor 0 screw map.
</font> MINST ANCE m Inst = 0;
int rc = mc Motor Map Set Length(m Inst, 0, 2 0 0 0 0);


<!-- Page 789 -->

int mc Motor Map Set NPoints(
MINST ANCE m Inst, int motor Id, int points);
rc = mc.mc Motor Map Set NPoints(
number m Inst, number motor Id, number points);
Description: Set the number of measured points for the screw map of the
given motor .

Parameters:
Parameter Description
m Inst The controller instance.
motor Id The motor id.
points An integer specifying the number of
measured points.

Returns:
Return Code Description
MERROR_NOERROR No Error .
MERROR_INV ALID_INST ANCEThe m Inst
parameter was
out of range.
MERROR_MOT OR_NOT_FOUNDThe motor
specified by
motor Id was not
found.
MERROR_INV ALID_ARG points is <= 0.
Notes:
```
Depricated. Use mc Motor Map Set Point Count() instead.


<!-- Page 790 -->

int mc Motor Map Set Point(
MINST ANCE m Inst, int motor Id, int point, int error);
rc = mc.mc Motor Map Set Point(
number m Inst, number motor Id, number point, number error);
<font color="green">// Set the error in motor 0 screw map.</font>
MINST ANCE m Inst = 0;
int rc = mc Motor Map Set Point(m Inst, 0, 5, 1 2);


<!-- Page 791 -->

int mc Motor Map Set Point Count(
MINST ANCE m Inst, int motor Id, int points);
rc = mc.mc Motor Map Set Point Count(
number m Inst, number motor Id, number points);
<font color="green">// Set the number of measured points in the screw map
for motor 0.</font> MINST ANCE m Inst = 0;
int rc = mc Motor Map Set Point Count(m Inst, 0, 2 0);


<!-- Page 792 -->

int mc Motor Map Set Start(
MINST ANCE m Inst, int motor Id, int start);
rc = mc.mc Motor Map Set Start(
number m Inst, number motor Id, number start)
<font color="green">// Set the starting point number for the motor 0 screw
map. (usually 0)</font> MINST ANCE m Inst = 0;
int rc = mc Motor Map Set Start(m Inst, 0, 0);


<!-- Page 793 -->

mc Motor Register(
MINST ANCE m Inst, int motor Id);
N/A
```
MINST ANCE m Inst = 0; for (int m = MOT OR 0; m < MOT OR 4; m++) {
mc Motor Register(m Inst, m);<font color="green">// Register motor 0 -
```
motor 2 in the core.</font> }


<!-- Page 794 -->

int mc Motor Set Counts Per Unit(
MINST ANCE m Inst, int motor Id, double counts);
rc = mc.mc Motor Set Counts Per Unit(
number m Inst, number motor Id, number counts)
<font color="green">// Set the counts for motor 0.</font> MINST ANCE
m Inst = 0;
int rc = mc Motor Set Counts Per Unit(m Inst, 0, 1 0 2 4);


<!-- Page 795 -->

int mc Motor Set Home Pos(
MINST ANCE m Inst, int motor Id, int count);
rc = mc.mc Motor Set Home Pos(
number m Inst, number motor Id, number count)
MINST ANCE m Inst = 0;
int m = MOT OR 2;
int count = 1 2 0 0;
mc Motor Set Home Pos(m Inst, m, count); <font color="green">// Set the
Home position of motor 2.</font>


<!-- Page 796 -->

int mc Motor Set Info Struct(
MINST ANCE m Inst, int moto Id,
motorinfo_t *minf);
N/A
```
struct motorinfo {
double Counts Per Unit; // Number of encoder counts or steps per unit.
double Max V elocity; // Max velocity of the axis.
double Max Acceleration; // Max rate to accelerate.
BOOL Reverse; // Is the axis reversed?
double Backlash Amount; // The amount of backlash in counts.
double Current V elocity; // The speed the axis is moving, This could be
reported by the motion deivce.
int Current Position; // The Current Position (From the motion device).
BOOL Homed; // T rue if the axis has been homed.
long Soft Max Limit; // Count for the max travel.
long Soft Min Limit; // Count for the min travel.
BOOL Can Home; // Can this motor home?
BOOL Enabled; // Is this motor enabled?
long Enable Delay; // ms to delay the enable signal for this motor .
```
};


<!-- Page 797 -->

```
typedef struct motorinfo motorinfo_t;
MINST ANCE m Inst = 0;
int m = MOT OR 2;
motorinfo_t minf;
mc Motor Get Info Struct(m Inst, m, &minf); <font color="green">// Get data
for motor 2.</font> minf.Counts Per Unit /= 2;<font color="green">//Divid
motor counts per unit by 2.</font> mc Motor Set Info Struct(m Inst, m,
&minf); <font color="green">// Set data for motor 2.</font>


<!-- Page 798 -->

int mc Motor Set Max Accel(
MINST ANCE m Inst, int motor Id, double max Accel);
rc = mc.mc Motor Set Max Accel(
number m Inst, number motor Id, number max Accel)
<font color="green">// Set a new accel value for motor 0.</font>
MINST ANCE m Inst = 0;
int mc Motor Set Max Accel(m Inst, 0, 7 5);


<!-- Page 799 -->

int mc Motor Set Max V el(
MINST ANCE m Inst, int motor Id, double max V el);
rc = mc.mc Motor Set Max V el(
number m Inst, number motor Id, number max V el)
<font color="green">// Set the maximum velocity for motor 0.</font>
MINST ANCE m Inst = 0;
int rc = mc Motor Set Max V el(m Inst, 0, 5 0 0);


<!-- Page 800 -->

int mc Motor Unregister(
MINST ANCE m Inst, int motor Id);
N/A
MINST ANCE m Inst = 0; int m = MOT OR 2; mc Motor Unregister(m Inst,
m);<font color="green">// Unregister motor 2 from the Core.</font>


<!-- Page 801 -->

int mc Mpg Get Accel(
MINST ANCE m Inst, int mpg, double *percent Max Accel);
percent Max Accel, rc = mc.mc Mpg Get Accel(
number m Inst, number mpg)
<font color="green">// Get the current accel for MPG 0.</font>
MINST ANCE m Inst = 0;
double percent Max Accel = 0; int rc;
rc = mc Mpg Get Accel(m Inst, 0, &percent Max Accel);


<!-- Page 802 -->

int mc Mpg Get Axis(
MINST ANCE m Inst, int mpg, int *axis Id);
axis Id, rc = mc.mc Mpg Get Axis(
number m Inst, number mpg)
<font color="green">// Get the currently selected axis for MPG 0.</font>
MINST ANCE m Inst = 0; int axis Id;
int rc = mc Mpg Get Axis(m Inst, 0, &axis Id);


<!-- Page 803 -->

int mc Mpg Get Counts Per Detent(
MINST ANCE m Inst, int mpg, int *pulses);
pulses, rc = mc.mc Mpg Get Counts Per Detent(
number m Inst, number mpg)
<font color="green">// Get the counts per detent for MPG 0.</font>
MINST ANCE m Inst = 0;
int cnts;
int rc = mc Mpg Get Counts Per Detent(m Inst, 0, &cnts);


<!-- Page 804 -->

int mc Mpg Get Enable(
MINST ANCE m Inst, int mpg, BOOL *enabled);
enabled, rc = mc.mc Mpg Get Enable(
number m Inst, number mpg)
<font color="green">// Get the enabled status of MPG 0.</font>
MINST ANCE m Inst = 0;
BOOL enabled = MC_F ALSE;

int rc = mc Mpg Get Enable(m Inst, 0, &enabled);


<!-- Page 805 -->

int mc Mpg Get Encoder Reg(
MINST ANCE m Inst, int mpg, HMCREG *h Reg);
h Reg, rc = mc.mc Mpg Get Encoder Reg(
number m Inst, number mpg)
<font color="green">// Get the current encoder associated with MPG 0.
</font> MINST ANCE m Inst = 0;
HMCREG h Reg = 0;

int rc = mc Mpg Get Encoder Reg(m Inst, 0, &h Reg);


<!-- Page 806 -->

int mc Mpg Get Inc(
MINST ANCE m Inst, int mpg, double *inc);
inc, rc = mc.mc Mpg Get Inc(
number m Inst, number mpg)
<font color="green">// Get the incremnt for MPG 0.</font> MINST ANCE
m Inst = 0; double inc;
int rc = mc Mpg Get Inc(m Inst, 0, &inc);


<!-- Page 807 -->

int mc Mpg Get Rate(
MINST ANCE m Inst, int mpg, double *percent Max V el);
percent Max V el, rc = mc.mc Mpg Get Rate(
number m Inst, number mpg)
<font color="green">// Get the velocity percentage for MPG 0.</font>
MINST ANCE m Inst = 0; double vel Percent;
int rc = mc Mpg Get Rate(m Inst, 0, &vel Percent);


<!-- Page 808 -->

int mc Mpg Get Reversed(
MINST ANCE m Inst, int mpg, BOOL *reversed);
reversed, rc = mc.mc Mpg Get Reversed(
number m Inst, number mpg)
<font color="green">// Get the reversed status of MPG 0.</font>
MINST ANCE m Inst = 0;
BOOL reversed = MC_F ALSE;

int rc = mc Mpg Get Reversed(m Inst, 0, &reversed);


<!-- Page 809 -->

int mc Mpg Get Shuttle Mode(
MINST ANCE m Inst, BOOL *on);
on, rc = mc.mc Mpg Get Shuttle Mode(
number m Inst)
<font color="green">// Check the state of MPG shuttle mode.</font>
MINST ANCE m Inst = 0;
BOOL enabled = F ALSE;
int rc = mc Mpg Get Shuttle Mode(m Inst, &enabled);


<!-- Page 810 -->

int mc Mpg Get Shuttle Percent(
MINST ANCE m Inst, int mpg, double *percent);
percent, rc = mc.mc Mpg Get Shuttle Percent(
number m Inst, number mpg)
<font color="green">// Get the shuttle percentage for MPG 0.</font>
MINST ANCE m Inst = 0;
double percent;
int rc = mc Mpg Get Shuttle Percentage(m Inst, 0, &percent);


<!-- Page 811 -->

int mc Mpg Move Counts(
MINST ANCE m Inst, int mpg, int delta Counts);
rc = mc.mc Mpg Move Counts(
number m Inst, number mpg, number delta Counts)
<font color="green">// Move the MPG 0 "n" counts.</font> MINST ANCE
m Inst = 0;
int n = 1 6;
int rc = mc Mpg Move Counts(m Inst, 0, n);


<!-- Page 812 -->

int mc Mpg Set Accel(
MINST ANCE m Inst, int mpg, double percent Max Accel);
rc = mc.mc Mpg Set Accel(
number m Inst, number mpg, number percent Max Accel)
<font color="green">// Set the acceleration value for MPG 0.</font>
MINST ANCE m Inst = 0;
int rc = mc Mpg Set Accel(m Inst, 0, 2 0.5);


<!-- Page 813 -->

int mc Mpg Set Axis(
MINST ANCE m Inst, int mpg, int axis Id);
rc = mc.mc Mpg Set Axis(
number m Inst, number mpg, number axis)
<font color="green">// Set MPG 0 to move the X axis.</font>
MINST ANCE m Inst = 0; int rc = mc Mpg Set Axis(m Inst, 0, X_AXIS);


<!-- Page 814 -->

int mc Mpg Set Counts Per Detent(
MINST ANCE m Inst, int mpg, int pulses);
rc = mc.mc Mpg Set Counts Per Detent(
number m Inst, number mpg, number pulses);
<font color="green">// Set the number of counts per detent for MPG 0.
</font> MINST ANCE m Inst = 0;
int rc = mc Mpg Set Counts Per Detent(m Inst, 0, 4);


<!-- Page 815 -->

int mc Mpg Set Enable(
MINST ANCE m Inst, int mpg, BOOL enabled);
rc = mc.mc Mpg Set Enable(
number m Inst, number mpg number enabled)
<font color="green">// Set the enabled status of MPG 0.</font>
MINST ANCE m Inst = 0;
BOOL enabled = MC_F ALSE;
int rc = mc Mpg Set Enable(m Inst, 0, MC_TRUE);


<!-- Page 816 -->

int mc Mpg Set Encoder Reg(
MINST ANCE m Inst, int mpg, HMCREG h Reg);
rc = mc.mc Mpg Set Encoder Reg(
number m Inst, number mpg number h Reg)
<font color="green">// Associate an encoder with MPG 0.</font>
MINST ANCE m Inst = 0;
HMCREG h Reg = 0;


<!-- Page 817 -->

int rc
rc = mc Reg Get Handle(m Inst, "/Sim 0/Encoder 0", &h Reg); if (rc ==
```
MERROR_NOERROR) {
```
rc = mc Mpg Set Encoder Reg(m Inst, 0, h Reg); }


<!-- Page 818 -->

int mc Mpg Set Inc(
MINST ANCE m Inst, int mpg, double inc);
rc = mc.mc Mpg Set Inc(
number m Inst, number mpg, number inc);
<font color="green">// Set the increment to .0 0 1 for MPG 0.</font>
MINST ANCE m Inst = 0;
int rc = mc Mpg Set Inc(m Inst, 0, .0 0 1);


<!-- Page 819 -->

int mc Mpg Set Rate(
MINST ANCE m Inst, int mpg, double percent Max V el);
rc = mc.mc Mpg Set Rate(
number m Inst, number mpg, number percent Max V el)
<font color="green">// Set the rate for MPG 0 to 2 5.0%</font>
MINST ANCE m Inst = 0;
int rc = mc Mpg Set Rate(m Inst, 0, 2 5.0);


<!-- Page 820 -->

int mc Mpg Set Reversed(
MINST ANCE m Inst, int mpg, BOOL reversed);
rc = mc.mc Mpg Get Reversed(
number m Inst, number mpg number reversed)
<font color="green">// Get the reversed status of MPG 0.</font>
MINST ANCE m Inst = 0;
BOOL reversed = MC_F ALSE;
int rc = mc Mpg Set Reversed(m Inst, 0, reversed); <font color="green">//
MC_TRUE</font>


<!-- Page 821 -->

int mc Mpg Set Shuttle Mode(
MINST ANCE m Inst, BOOL on);
rc = mc.mc Mpg Set Shuttle Mode(
number m Inst, number on);
<font color="green">// T urn on MPG shuttle mode.</font> MINST ANCE
m Inst = 0;
int rc = mc Mpg Set Shuttle Mode(m Inst, MC_ON);


<!-- Page 822 -->

int mc Mpg Set Shuttle Percent(
MINST ANCE m Inst, int mpg, double percent);
rc = mc.mc Mpg Get Shuttle Percent(
number m Inst, number mpg number percent)
<font color="green">// Set the shuttle percentage for MPG 0.</font>
MINST ANCE m Inst = 0;
double percent = 2 0 0.5;
int rc = mc Mpg Get Shuttle Percentage(m Inst, 0, percent);


<!-- Page 823 -->

int mc Plugin Configure(
MINST ANCE m Inst, int plug Id);
N/A
MINST ANCE m Inst = 0;
HMCPLUG h Plug = 0;
pluginfo_t pluginf;

<font color="green">// Loop through all of the plugins looking for
plugins<br/>// that have configuration dialogs.</font> while
(mc Plugin Get Next Handle(PLUG_TYPE_CONFIG, h Plug, &h Plug) ==
```
MERROR_NOERROR) {
<font color="green">// Get the plugin info that contains the plugin ID.
</font> rc = mc Plugin Get Info Struct(h Plug, &pluginf); if (rc ==
```
MERROR_NOERROR) {
int plugin Id = pluginf.plug Id; <font color="green">// Call the
configuration dialog.</font> rc = <font
```
color="blue">mc Plugin Configure(m Inst, plugin Id);</font>; }
```
}


<!-- Page 824 -->

int mc Plugin Core Load(
```
const char *short Name);
N/A
<font color="green">// Load the mc Galil plugin.</font> int rc =
mc Plugin Core Load("mc Galil");


<!-- Page 825 -->

int mc Plugin Core Unload(
```
const char *short Name);
N/A
<font color="green">// Unload the mc Galil plugin.</font> int rc =
mc Plugin Core Unload("mc Galil");


<!-- Page 826 -->

int mc Plugin Diagnostic(
MINST ANCE m Inst, int plugin Id);
N/A
MINST ANCE m Inst = 0;
HMCPLUG h Plug = 0;
pluginfo_t pluginf;

<font color="green">// Loop through all of the plugins looking for
plugins<br/>// that have diagnostic dialogs.</font> while
(mc Plugin Get Next Handle(PLUG_TYPE_DIAG, h Plug, &h Plug) ==
```
MERROR_NOERROR) {
<font color="green">// Get the plugin info that contains the plugin ID.
</font> rc = mc Plugin Get Info Struct(h Plug, &pluginf); if (rc ==
```
MERROR_NOERROR) {
int plugin Id = pluginf.plug Id; <font color="green">// Call the diagnostics
dialog.</font> rc = <font color="blue">mc Plugin Diagnostic(m Inst,
```
plugin Id);</font>; }
```
}


<!-- Page 827 -->

int mc Plugin Enable(
HMCPLUG h Plug, BOOL enable);
N/A
HMCPLUG h Plug = 0; <font color="green">// Loop through all of the
plugins looking for plugins<br/>// that have configuration dialogs.</font>
while (mc Plugin Get Next Handle(PLUG_TYPE_CONFIG, h Plug, &h Plug)
```
== MERROR_NOERROR) {
<font color="green">// Enable the plugin.</font> rc = <font
```
color="blue">mc Plugin Enable(h Plug, TRUE)</font>; }


<!-- Page 828 -->

int mc Plugin Get Enabled(
HMCPLUG h Plug, BOOL *enabled);
N/A
HMCPLUG h Plug = 0;
BOOL enabled = F ALSE;
<font color="green">// Loop through all of the plugins looking for
plugins<br/>// that have configuration dialogs.</font> while
(mc Plugin Get Next Handle(PLUG_TYPE_CONFIG, h Plug, &h Plug) ==
```
MERROR_NOERROR) {
<font color="green">// See if the plugin is enabled..</font> rc = <font
color="blue">mc Plugin Get Enabled(h Plug, &enabled)</font>; if (rc ==
```
MERROR_NOERROR) {
```
if (enabled == TRUE) {
```
<font color="green">// The plugin is enabled!!!</font> } else {
```
<font color="green">// The plugin is not enabled!!!</font> }
```
}
```
}


<!-- Page 829 -->

mc Plugin Get Info Struct(HMCPLUG h Plug, pluginfo_t *pluginf);
N/A
HMCPLUG h Plug = 0; pluginfo_t pluginf;
<font color="green">// Loop through all of the plugins.
while (mc Plugin Get Next Handle(PLUG_TYPE_ALL, h Plug, &h Plug) ==
```
MERROR_NOERROR) {
<font color="green">// Get the plugin info that contains the plugin ID.
</font> rc = <font color="blue">mc Plugin Get Info Struct(h Plug, &pluginf)
```
</font>; if (rc == MERROR_NOERROR) {
int plugin Id = pluginf.plug Id; ...
```
}
```
}

</font>


<!-- Page 830 -->

int mc Plugin Get License Feature(
HMCPLUG h Plug, int index, char *buf, int buf Size, BOOL *status);
N/A
HMCPLUG h Plug = 0;
<font color="green">// Loop through all of the plugins.
while (mc Plugin Get Next Handle(PLUG_TYPE_ALL, h Plug, &h Plug) ==
```
MERROR_NOERROR) {
<font color="green">// Get all of the plugin license features</font> int
index = 0; char buf[8 0]; BOOL licensed = F ALSE; while (<font
color="blue">mc Plugin Get License Feature(h Plug, index, buf, sizeof(buf),
```
&licensed)</font> == MERROR_NOERROR) {
printf("license feature %s is %s.\n", buf, licensed == TRUE ? "licensed" :
```
"not licensed"); index++; }
```
}

</font>


<!-- Page 831 -->

int mc Plugin Get Next Handle(
int plug T ype, HMCPLUG start Plug, HMCPLUG *h Plug);
N/A
HMCPLUG h Plug = 0;
<font color="green">// Loop through all of the plugins looking for
plugins<br/>// that have configuration dialogs and privide I/O.</font> int
attr = PLUG_TYPE_CONFIG | PLUG_TYPE_IO; while (<font
color="blue">mc Plugin Get Next Handle(attr , h Plug, &h Plug)</font> ==
```
MERROR_NOERROR) {
<font color="green">// Enable the plugin.</font> rc =
```
mc Plugin Enable(h Plug, TRUE); }


<!-- Page 832 -->

int mc Plugin Get V alid(
HMCPLUG h Plug, BOOL *valid);
N/A
HMCPLUG h Plug = 0;
BOOL valid = F ALSE;
<font color="green">// Loop through all of the plugins checking to see if
they are valid.</font> while (mc Plugin Get Next Handle(PLUG_TYPE_ALL,
```
h Plug, &h Plug) == MERROR_NOERROR) {
<font color="green">// Check the plugin validity .</font> rc = <font
color="blue">mc Plugin Get V alid(h Plug, &valid)</font>; if (rc ==
```
MERROR_NOERROR) {
```
if (valid == TRUE) {
```
<font color="green">// The plugin is valid and will function.</font> }
```
else {
```
<font color="green">// The plugin is invalid and will not function.
```
</font> }
```
}
```
}


<!-- Page 833 -->

int mc Plugin Install(
```
const char *m 4 plug);
N/A
<font color="green">// Install the W indows mc Galil plugin from an
installation archive.</font> int rc = mc Plugin Install("mc Galil.m 4 Plugw");
```
if (rc == MERROR_NOERROR) {
```
<font color="green">//The plugin installed successfully .</font> }


<!-- Page 834 -->

int mc Plugin Register(
```
HMCPLUG h Plug, const char *Developer Id, const char *Desc, const
char *V ersion, int T ype);
N/A
```
<font color="green">// This function gets called (only once) when the
Plugin is loaded by Mach Core.</font> MCP_API int MCP_APIENTR Y
```
mc Plugin Load(HMCPLUG id) {
...
<font color="blue">mc Plugin Register(id, "Newfangled", "Simulator -
Newfangled Solutions", MC_VERSION_STR, PLUG_TYPE_MOTION |
PLUG_TYPE_IO | PLUG_TYPE_REG | PLUG_TYPE_CONFIG |
```
PLUG_TYPE_DIAG)</font>; return(MERROR_NOERROR); }


<!-- Page 835 -->

```
int mc Plugin Remove(const char *short Name);
N/A
<font color="green">// Remove the mc Galil plugin.</font> MINST ANCE
m Inst = 0; int rc = mc Plugin Remove("mc Galil");


<!-- Page 836 -->

int mc Profile Delete Key(
```
MINST ANCE m Inst, const char *section, const char *key);
rc = mc.mc Profile Delete Key(
number m Inst, string section, string key)
MINST ANCE m Inst = 0;
mc Profile Delete Key(m Inst , "P_Port", "Frequency");


<!-- Page 837 -->

int mc Profile Delete Section(
```
MINST ANCE m Inst, const char *section);
rc = mc.mc Profile Delete Section(
number m Inst, string section)
MINST ANCE m Inst = 0;
mc Profile Delete Key(m Inst , "P_Port");


<!-- Page 838 -->

int mc Profile Exists(
```
MINST ANCE m Inst, const char *section, const char *key);
rc = mc.mc Profile Exists(
number m Inst, string section, string key)
MINST ANCE m Inst = 0;
mc Profile W rite Int(m Inst, "P_Port", "Frequency");


<!-- Page 839 -->

int mc Profile Flush(
INST ANCE m Inst);
rc = mc.mc Profile Flush(
number m Inst)
MINST ANCE m Inst = 0; mc Profile Flush(m Inst); <font color="green">//
Flush changes to the INI file.</font>


<!-- Page 840 -->

mc Profile Get Double(
```
MINST ANCE m Inst, const char *section, const char *key , double
*retval, double defval);
retval, rc = mc.mc Profile Get Double(
number m Inst, string section, string key , number defval)
double rval=0;
MINST ANCE m Inst = 0;
mc Profile Get Double(m Inst , "P_Port", "Frequency", &rval, 2 5.3 4);


<!-- Page 841 -->

int mc Profile Get Int(
```
MINST ANCE m Inst, const char *section, const char *key , long *retval,
long defval);
retval, rc = mc.mc Profile Get Int(
number m Inst, string section, string key , number defval)
long rval=0;
int m Inst=0;
mc Profile Get Int(m Inst , "P_Port", "Frequency", &rval, 2 5 0 0 0);


<!-- Page 842 -->

int mc Profile Get Name(
MINST ANCE m Inst, char *buf f, size_t bufsize);
name, rc = mc.mc Profile Get Name(
number m Inst)
MINST ANCE m Inst = 0; char buf f[8 0];
memset(buf f, 0, 8 0); mc Profile Get Name(m Inst, buf f, 8 0);


<!-- Page 843 -->

int mc Profile Get String(
```
MINST ANCE m Inst, const char *section, const char *key , char *buf f,
```
long buf fsize, const char *defval);
buff, rc = mc.mc Profile Get String(
MINST ANCE m Inst, string section, string key , string defval);
MINST ANCE m_inst = 0;
char *key = "Buf fered T ime"; char buf f[8 0];
memset(buf f, 0, 8 0);
mc Profile Get String(m Inst , "Some Section", key , buff, 8 0, "0.1 0 0");


<!-- Page 844 -->

int mc Profile Reload(
INST ANCE m Inst);
rc = mc.mc Profile Reload(
number m Inst)
MINST ANCE m Inst = 0; mc Profile Reload(m Inst); <font color="green">//
Reload the settings from the INI file.</font>


<!-- Page 845 -->

int mc Profile Save(
INST ANCE m Inst);
rc = mc.mc Profile Save(
number m Inst)
MINST ANCE m Inst = 0; mc Profile Save(m Inst); <font color="green">//
Flush the settings to the INI file.</font>


<!-- Page 846 -->

int mc Profile W rite Double(
```
MINST ANCE m Inst, const char *section, const char *key , double val);
rc = mc.mc Profile W rite Double(
number m Inst, string section, string key , double val)
MINST ANCE m Inst=0;
mc Profile W rite Double(m_cid , "P_Port", "Frequency", 4 5 0 0 0);


<!-- Page 847 -->

int mc Profile W rite Int(
```
MINST ANCE m Inst, const char *section, const char *key , long val);
int mc Profile W rite Int(
number m Inst, string section, string key , number val)
MINST ANCE m Inst = 0;
mc Profile W rite Int(m_cid , "P_Port", "Frequency", 4 5 0 0 0);


<!-- Page 848 -->

int mc Profile W rite String(
```
MINST ANCE m Inst, const char *section, const char *key , const char
*val);
rc = mc.mc Profile W rite String(
number m Inst, string section, string key , string val)
MINST ANCE m_inst = 0;
char *key = "Buf fered T ime"
double Buf f Time = .2 5 0;
char val[8 0];
sprintf(val, "%.4 f", Buf f Time); mc Profile W rite String(m Inst, "Darwin", key ,
val);


<!-- Page 849 -->

int mc Reg Get Command(
HMCREG h Reg,
char *cmd,
size_t cmd Len)
N/A
<font color="green">// Retrieve the register command.</font> int
```
sim Control::Process Msg(long msg, long param 1, long param 2) {
HMCREG h Reg = (HMCREG)param 1; long Reg V al;
```
switch (msg) {
case MSG_REG_COMMAND: mc Reg Get V alue Long(h Reg, &Reg V al);
```
if (h Reg = m_Reg Command) { <font color="green">// Is this our command
register?</font> char command[1 0 2 4]; mc Reg Get Command(h Reg,
command, sizeof(command)); wx String cmd(command);
```
cmd.Make Upper(); if (cmd == wx T("THC ON")) {
```
m_thc = true; mc Reg Set Response(h Reg, "OK"); } else if (cmd ==
```
wx T("THC OFF")) {
m_thc = false; mc Motion Sync(m_cid); mc Reg Set Response(h Reg, "OK");
```
} else if (cmd == wx T("THC ST ATUS")) {
```
if (m_thc) {
```
mc Reg Set Response(h Reg, "1"); } else {
```
mc Reg Set Response(h Reg, "0"); }
```
}
```
}


<!-- Page 850 -->

break;
default:
;
```
}
```
return(MERROR_NOERROR); }


<!-- Page 851 -->

int mc Reg Get Handle(
```
MINST ANCE m Inst, const char *path, HMCREG *h Reg);
h Reg, rc = mc.mc Reg Get Handle(
number m Inst, string path)
<font color="green">// Get the register handle.</font> MINST ANCE m Inst
= 0; HMCREG h Reg;
int rc;
double value;
if (<font color="blue">mc Reg Get Handle(m Inst, "core/global/V ersion",
```
&h Reg)</font> == MERROR_NOERROR) {
```
rc = mc Reg Get V alue(h Reg, &value); }


<!-- Page 852 -->

int mc Reg Get Info(
HMCREG h Reg, char *name Buf, size_t name Buflen, char *desc Buf,
size_t desc Buflen, int *type, HMCDEV *h Dev);
name Buf, desc Buf, type, h Dev , rc = mc.mc Reg Get Info(
number h Reg)
HMCREG h Reg = 0; char name[8 0];
char desc[8 0];
int type;
HMCDEV h Dev;

while (mc Signal Get Next Handle(h Dev , h Reg, &h Reg) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
<font color="green">// Get the info on the register .</font>
mc Reg Get Info(h Reg, name, sizeof(name), desc, sizeof(desc), &type,
```
&h Dev)); } else {
```
break; }
```
}


<!-- Page 853 -->

int mc Reg Get Info Struct(
HMCREG h Reg, reginfo_t *reginf);
reginf, rc = mc.mc Reg Get Info Struct(
number h Reg)
```
struct reginfo {
char reg Name[8 0]; char reg Desc[8 0]; int reg T ype; HMCDEV reg Dev;
```
void *reg User Data; int reg Input; };
```
typedef struct reginfo reginfo_t;
HMCREG h Reg = 0;
reginfo_t reginf;

while (mc Signal Get Next Handle(h Dev , h Reg, &h Reg) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
<font color="green">// Get the info on the register .</font>
```
mc Reg Get Info Struct(h Reg, ®inf); } else {
```
break; }
```
}


<!-- Page 854 -->

int mc Reg Get Next Handle(
HMCDEV h Dev , HMCREG start Reg, HMCREG *h Reg);
h Reg, rc = mc.mc Reg Get Next Handle(
number h Dev , number start Reg)
HMCSIG h Reg = 0;
HMCDEV h Dev;
mc Device Get Handle(0, 0,&h Dev); while (<font
color="blue">mc Register Get Next Handle(h Dev , h Reg, &h Reg)</font> ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
```
<font color="green">// do something with h Reg.</font> } else {
```
break; }
```
}


<!-- Page 855 -->

int mc Reg Get User Data(
HMCREG h Reg, void **data);
N/A
```
struct my Data Struct {
int my Int; char my String[8 0]; ...
```
};

HMCREG h Reg;
int m Inst=0;
my Data Struct *data = NULL; void *data Ptr; <font color="green">// Get the
handle to holding register 1 on SIM 0.</font> if (mc Reg Get Handle(m Inst,
```
"SIM 0/Holding Reg 1", &h Reg) == MERROR_NOERROR) {
```
mc Reg Get User Data(h Reg, &data Ptr); data = (my Data Struct *) data Ptr; }


<!-- Page 856 -->

int mc Reg Get V alue(
HMCREG h Reg, double *value);
value, rc = mc Reg Get V alue(
number h Reg)
<font color="green">// Get the register value.</font> MINST ANCE m Inst
= 0; HMCREG h Reg; int rc;
double value; if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg)
```
== MERROR_NOERROR) {
```
rc = mc Reg Get V alue(h Reg, &value); }


<!-- Page 857 -->

int mc Reg Get V alue Long(
HMCREG h Reg, double *value);
value, rc = mc Reg Get V alue Long(
number h Reg)
<font color="green">// Get the register value.</font> MINST ANCE m Inst
= 0; HMCREG h Reg; int rc;
long value; if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg) ==
```
MERROR_NOERROR) {
```
rc = mc Reg Get V alue Long(h Reg, &value); }


<!-- Page 858 -->

int mc Reg Get V alue String(
HMCREG h Reg, char *buf, size_t buf Size);
buf, rc = mc Reg Get V alue String(
number h Reg)
<font color="green">// Get the register value.</font> MINST ANCE m Inst
= 0; HMCREG h Reg;
int rc;
char value[8 0]; if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg)
```
== MERROR_NOERROR) {
```
rc = mc Reg Get V alue String(h Reg, &value, sizeof(value)); }


<!-- Page 859 -->

int mc Reg Get V alue String Clear(
HMCREG h Reg, char *buf, size_t buf Size);
buf, rc = mc Reg Get V alue String(
number h Reg)
<font color="green">// Get the register value and clear it.</font>
MINST ANCE m Inst = 0; HMCREG h Reg;
int rc;
char value[8 0]; if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg)
```
== MERROR_NOERROR) {
```
rc = mc Reg Get V alue String Clear(h Reg, &value, sizeof(value)); }


<!-- Page 860 -->

mc Reg Register
C/C++ Syntax:
int mc Reg Register(
HMCDEV h Dev,
```
const char *reg Name,
```
const char *reg Desc,
int reg Type,
HMCREG *h Reg);

LUA Syntax:
N/A

Description: Adds a register to the core.

Parameters:
Parameter Description
h Dev The handle of the register's parent device.
reg Name A string buf fer specifying the name of the
register .
reg Desc A string buf fer specifying the description
of the register .
reg Type REG_TYPE_NONE,
REG_TYPE_INPUT ,
REG_TYPE_OUTPUT ,
REG_TYPE_HOLDING,
REG_TYPE_COMMAND,
REG_TYPE_ENCODER.
h Reg The address of a HMCREG that receives
the register handle.


<!-- Page 861 -->

Returns:
Return Code Description
MERROR_NOERROR No Error .
MERROR_DEVICE_NOT_FOUNDThe h Dev
parameter was 0
or invlaid.
MERROR_INV ALID_ARGreg Name ,
reg Desc , or h Reg
is NULL.
Notes:
The h Dev parameter MUST be a valid device handle. Otherwise, the
```
function will crash.
Registers can contain data of any type, even string data. The maximum
string length is 4 0 9 6 bytes for registers other than
REG_TYPE_COMMAND type registers and 1 0 2 4 bytes for the
REG_TYPE_COMMAND type registers.
REG_TYPE_NONE specifies a register that is not typed. This kind of
register is basically just a data container that will not notify any process if
the data it stores changes.
REG_TYPE_INPUT specifies a register that can be mapped to a Mach
input signal. Mach and any GUI front end is notified if the data in this type
of register is changed with a MSG_REG_CHANGED message. This type
of register usually contains boolean data.
REG_TYPE_OUTPUT specifies a register that can be mapped to a Mach
output signal. The plugin that owns this register is notified with a
MSG_REG_CHANGED synchronous message. All other plugins and the
GUI are notified asynchronously with MSG_REG_CHANGED .
REG_TYPE_HOLDING specifies a general purpose register that cannot
be mapped to either an input or output signal. The plugin that owns this


<!-- Page 862 -->

register is notified with a MSG_REG_CHANGED synchronous message.
All other plugins and the GUI are notified asynchronously with
MSG_REG_CHANGED . This type of register usually contains boolean
data.
REG_TYPE_COMMAND specifies a special purpose register that can be
used to implement a simple command/response communication mechanism.
Only the plugin that owns the register is notified with a
MSG_REG_COMMAND synchronous message. It works with
mc Reg Send Command
on the client side of the communication and
mc Reg Get Command
and
mc Reg Set Response
on the plguin side.
REG_TYPE_ENCODER specifies a register that can be mapped to a
MPG or used to display the encoder counts in the GUI. Only Mach and the
GUI are notified with a MSG_REG_CHANGED synchronous message.

Usage:
HMCREG m_h Reg;
HMCDEV m_h Dev; // Contains the device handle from the device
registration.
int rc = mc Reg Register(m_h Dev, "Holding Reg 1", "Holding Reg 1",
REG_TYPE_HOLDING, &h Reg) ;


<!-- Page 863 -->

int mc Reg Send Command(
```
HMCREG h Reg, const char *command, char *response, size_t
response Len);
response, rc = mc.mc Reg Send Command(
h Reg, command)
<font color="green">// Send a command via a register .</font>
MINST ANCE m Inst = 0;
if (mc Reg Get Handle(m Inst, "Sim 0/Sim Command", &h Reg) ==
```
MERROR_NOERROR) {
char response[1 0 2 4]; rc = <font
color="blue">mc Reg Send Command(h Reg, "THC ON", response,
```
sizeof(response))</font>; if (rc == MERROR_NOERROR) {
```
<font color="green">// check response.</font> }
```
}


<!-- Page 864 -->

int mc Reg Set Desc(
```
HMCREG h Reg, const char *desc);
rc = mc.mc Reg Set Desc(
number h Reg, string desc)
<font color="green">// Set/change the description of the register .</font>
MINST ANCE m Inst = 0; if (mc Reg Get Handle(m Inst,
```
"core/global/V ersion", &h Reg) == MERROR_NOERROR) {
```
rc = <font color="blue">mc Reg Set Desc(h Reg, "Core V ersion")</font>; }


<!-- Page 865 -->

int mc Reg Set Name(
```
HMCREG h Reg, const char *name);
rc = mc.mc Reg Set Name(
number h Reg, string name)
<font color="green">// Set/change the name of the register .</font>
MINST ANCE m Inst = 0; if (mc Reg Get Handle(m Inst,
```
"core/global/V ersion", &h Reg) == MERROR_NOERROR) {
rc = <font color="blue">mc Reg Set Name(h Reg, "V ersion 2")</font>;
<font color="green">// The register path is now "core/global/V ersion 2"
```
</font> }


<!-- Page 866 -->

int mc Reg Set Response(
HMCREG h Reg,
char *response);
N/A
<font color="green">// Set the response to a register command.</font> int
```
sim Control::Process Msg(long msg, long param 1, long param 2) {
HMCREG h Reg = (HMCREG)param 1; long Reg V al;
```
switch (msg) {
case MSG_REG_COMMAND: mc Reg Get V alue Long(h Reg, &Reg V al);
```
if (h Reg = m_Reg Command) { <font color="green">// Is this our command
register?</font> char command[1 0 2 4]; mc Reg Get Command(h Reg,
command, sizeof(command)); wx String cmd(command);
```
cmd.Make Upper(); if (cmd == wx T("THC ON")) {
```
m_thc = true; mc Reg Set Response(h Reg, "OK"); } else if (cmd ==
```
wx T("THC OFF")) {
m_thc = false; mc Motion Sync(m_cid); mc Reg Set Response(h Reg, "OK");
```
} else if (cmd == wx T("THC ST ATUS")) {
```
if (m_thc) {
```
mc Reg Set Response(h Reg, "1"); } else {
```
mc Reg Set Response(h Reg, "0"); }
```
}
```
}
break;


<!-- Page 867 -->

default:
;
```
}
```
return(MERROR_NOERROR); }


<!-- Page 868 -->

int mc Reg Set T ype(
HMCREG h Reg, int reg T ype);
rc = mc.mc Reg Set T ype(
number h Reg, number reg T ype)
<font color="green">// Set the register type.</font> MINST ANCE m Inst =
0; if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg) ==
```
MERROR_NOERROR) {
rc = <font color="blue">mc Reg Set T ype(h Reg, REG_TYPE_HOLDING)
```
</font>; }


<!-- Page 869 -->

int mc Reg Set User Data(
HMCREG h Reg, void *data);
N/A
```
struct my Data Struct {
int my Int; char my String[8 0]; ...
```
};

HMCREG h Reg;
MINST ANCE m Inst = 0; my Data Struct data; <font color="green">// Get
the handle to holding register 1 on SIM 0.</font> mc Reg Get Handle(m Inst,
"SIM 0/Holding Reg 1", &h Reg); <font color="green">// Set the user data
pointer to the address of data.</font> <font
color="blue">mc Reg Set User Data(h Reg, &data)</font>;


<!-- Page 870 -->

int mc Reg Set V alue(
HMCREG h Reg, double value);
rc = mc.mc Reg Set V alue(
number h Reg, number value)
<font color="green">// Set the register value.</font> MINST ANCE m Inst =
0; if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg) ==
```
MERROR_NOERROR) {
```
rc = <font color="blue">mc Reg Set V alue(h Reg, 4.0)</font>; }


<!-- Page 871 -->

int mc Reg Set V alue Long(
HMCREG h Reg, double value);
rc = mc.mc Reg Set V alue Long(
number h Reg, number value)
<font color="green">// Set the register value.</font> MINST ANCE m Inst =
0;
if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg) ==
```
MERROR_NOERROR) {
```
rc = <font color="blue">mc Reg Set V alue Long(h Reg, 4)</font>; }


<!-- Page 872 -->

int mc Reg Set V alue String(
```
HMCREG h Reg, const char *value);
rc = mc.mc Reg Set V alue String(
number h Reg, string value)
<font color="green">// Set the register value.</font> MINST ANCE m Inst =
0;
if (mc Reg Get Handle(m Inst, "core/global/V ersion", &h Reg) ==
```
MERROR_NOERROR) {
```
rc = <font color="blue">mc Reg Set V alue String(h Reg, "4.0")</font>; }


<!-- Page 873 -->

int mc Reg Unregister(
HMCDEV h Dev , HMCREG h Reg);
N/A
MINST ANCE m Inst = 0; HMCREG h Reg char *path = "Sim 0/Register 1";
mc Reg Get Handle(m Inst, path, &h Reg); <font
color="blue">mc Reg Unregister(m_h Dev , h Reg);</font>


<!-- Page 874 -->

int mc Script Debug(
```
MINST ANCE m Inst, const char *filename);
N/A
<font color="green">// Debug the M 6 macro</font> MINST ANCE m Inst =
0; int rc = mc Script Debug(m Inst, "m 6.mcs");


<!-- Page 875 -->

int mc Script Engine Register(
```
MINST ANCE m Inst, HMCPLUG plugid, const char *Engine Name,
```
const char *Engine Desc, const char *File Extensions);
N/A
<font color="green">// Register the LUA script engine.</font>
MINST ANCE m Inst = 0;
```
HMCPLUG id; <font color="green">// From mc Plugin Init()</font>; int rc
= mc Script Engine Register(m Inst, id, "wx Lua", "wx Lua script engine",
"mcs|lua|wx.lua");


<!-- Page 876 -->

int mc Script Execute(
```
MINST ANCE m Inst, const char *filename, BOOL async);
rc = mc.mc Script Execute(
number m Inst, string filename, number async)
<font color="green">// Execute the M 6 script and wait on it to complete.
</font> MINST ANCE m Inst = 0;
rc = mc Script Execute(m Inst, "m 6.mcs", F ALSE);


<!-- Page 877 -->

int mc Script Execute If Exists(
```
MINST ANCE m Inst, const char *filename, BOOL async);
rc = mc.mc Script Execute If Exists(
number m Inst, string filename, number async)
<font color="green">// Execute the M 6 script and wait on it to complete.
</font> MINST ANCE m Inst = 0;
rc = mc Script Execute(m Inst, "m 6.mcs", F ALSE);


<!-- Page 878 -->

int mc Script Execute Private(
```
MINST ANCE m Inst, const char *filename, BOOL async);
rc = mc.mc Script Execute Private(
number m Inst, string filename, BOOL async)
<font color="green">// Execute my Script.mcs asynchronously in it's own
private environment.</font> MINST ANCE m Inst = 0;
int rc = mc Script Execute Private(m Inst, "my Script.mcs", TRUE);


<!-- Page 879 -->

int mc Script Get Extensions(MINST ANCE m Inst, char *buf, long bufsize);
N/A
<font color="green">// Retrieve all of the registered script extensions.
</font> MINST ANCE m Inst = 0; mc Script Get Extensions(MINST ANCE
m Inst, char *buf, long bufsize);


<!-- Page 880 -->

int mc Signal Enable(
HMCSIG h Sig, BOOL enabled);
rc = mc.mc Signal Enable(
number h Sig, number enabled)
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id;
m_timer = new sim T imer(this); m_cycletime = .0 0 1; HMCSIG h Sig;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
mc Io Register(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); mc Io Register(m_h Dev , "Output 0", "Output 0",
IO_TYPE_OUTPUT , &m_Output 0)
if (mc Signal Get Handle(m_cid, ISIG_INPUT 1, int sigid, &h Sig) ==
```
MERROR_NOERROR) {
```
if (mc Signal Map(h Sig, m_Input 0) == MERROR_NOERROR) {
<font color="green">// Signal mapped successfuly</font> <font
color="blue">mc Signal Enable(h Sig, TRUE);</font> <font
```
color="green">// Enable the signal.</font> }
```
}
```
}


<!-- Page 881 -->

int mc Signal Get Handle(
MINST ANCE m Inst, int sigid,
HMCSIG *h Sig);
h Sig, rc = mc.mc Signal Get Handle(
number m Inst, number sigid)
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id;
m_timer = new sim T imer(this); m_cycletime = .0 0 1; HMCSIG h Sig;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
mc Io Register(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); mc Io Register(m_h Dev , "Output 0", "Output 0",
IO_TYPE_OUTPUT , &m_Output 0)
if (<font color="blue">mc Signal Get Handle(m_cid, ISIG_INPUT 1,
```
&h Sig)</font> == MERROR_NOERROR) {
```
if (mc Signal Map(h Sig, m_Input 0) == MERROR_NOERROR) {
<font color="green">// Signal mapped successfuly .</font>
mc Signal Enable(h Sig, true); <font color="green">// Enable the signal.
```
</font> }
```
}
```
}


<!-- Page 882 -->

int mc Signal Get Info(
HMCSIG h Sig, int *enabled, char *name, size_t namelen, char *desc,
size_t desclen, int *activelow);
enabled, name, desc, activelow , rc = mc.mc Signal Get Info(number h Sig)
HMCSIG h Sig = 0;
int enabled = 0;
int name Len = 2 0
char name Buf[name Len]; int desc Len = 4 0;
char desc Buf[desc Len]; int active Low = 0;

while (mc Signal Get Next Handle(0, SIG_TYPE_INPUT , h Sig, &h Sig) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
<font color="blue">mc Signal Get Info(h Sig, &enabled, name Buf,
```
name Len, desc Buf, desc Len, &active Low)</font>; } else {
```
break; }
```
}


<!-- Page 883 -->

int mc Signal Get Info Struct(
HMCSIG h Sig, siginfo_t *siginf);
siginf, rc = mc.mc Signal Get Info Struct(
number h Sig)
```
struct siginfo {
char sig Name[8 0]; char sig Desc[8 0]; int sig Enabled; int sig Active Low;
```
HMCIO sig Mapped Io Handle; };
```
typedef struct siginfo siginfo_t;
HMCSIG h Sig = 0;
siginfo_t siginf;

while (mc Signal Get Next Handle(0, SIG_TYPE_INPUT , h Sig, &h Sig) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
```
<font color="blue">mc Signal Get Info Struct(h Sig, &siginf);</font> } else
```
{
```
break; }
```
}


<!-- Page 884 -->

int mc Signal Get Next Handle(
MINST ANCE m Inst, int sigtype, HMCSIG start Sig, HMCSIG *h Sig);
h Sig, rc = mc.mc Signal Get Next Handle(
number m Inst, number sigtype, number start Sig)
HMCSIG h Sig = 0;

while (<font color="blue">mc Signal Get Next Handle(0,
```
SIG_TYPE_INPUT , h Sig, &h Sig)</font> == MERROR_NOERROR) {
```
if (h Sig != 0) {
```
<font color="green">// Do something with h Sig.</font> } else {
```
break; }
```
}


<!-- Page 885 -->

int mc Signal Get State(
HMCSIG h Sig, BOOL *state)
state, rc = mc.mc Signal Get State(
number h Sig)
HMCSIG h Sig = 0;
BOOL sig State = F ALSE;
<font color="green">// Get the state of all input signals.</font> while
(mc Signal Get Next Handle(0, SIG_TYPE_INPUT , h Sig, &h Sig) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
```
<font color="blue">mc Signal Get State(h Sig, &sig State);</font> } else {
```
break; }
```
}


<!-- Page 886 -->

int mc Signal Handle W ait(
HMCSIG h Sig, int wait Mode, double timeout Secs);
rc = mc.mc Signal Handle W ait(
number h Sig, number wait Mode, number timeout Secs);
MINST ANCE m Inst = 0;
HMCSIG h Sig;
int rc;
rc = mc Signal Get Handle(m Inst, ISIG_INPUT 1 &h Sig); if (rc ==
```
MERROR_NOERROR) {
rc = <font color="blue">mc Signal Handle W ait(h Sig,
```
WAIT_MODE_HIGH, .5)</font>; switch (rc) {
case MERROR_NOERROR: <font color="green">// Signal changed
state from low to high</font> break; case MERROR_TIMED_OUT : <font
color="green">// The signal didn't change state in the alotted time.</font>
break; case MERROR_NOT_ENABLED: <font color="green">// The
```
control was not enabled at the time of the function call or the control was
```
disabled during the function call.</font> break; }
```
}


<!-- Page 887 -->

int mc Signal Map(
HMCSIG h Sig, HMCIO h Io);
rc = mc.mc Signal Map(
number h Sig, number h Io)
```
sim Control::sim Control(MINST ANCE m Inst, HMCPLUG id) {
m_cid = m Inst; m_id = id; m_timer = new sim T imer(this); m_cycletime
= .0 0 1; HMCSIG h Sig;
mc Device Register(m_cid, m_id, "Sim 0", "Simulation Device",
DEV_TYPE_MOTION | DEV_TYPE_IO, &m_h Dev);
mc Io Register(m_h Dev , "Input 0", "Input 0", IO_TYPE_INPUT ,
&m_Input 0); mc Io Register(m_h Dev , "Output 0", "Output 0",
IO_TYPE_OUTPUT , &m_Output 0)
if (mc Signal Get Handle(m_cid, ISIG_INPUT 1, &h Sig) ==
```
MERROR_NOERROR) {
if (<font color="blue">mc Signal Map(h Sig, m_Input 0)</font> ==
```
MERROR_NOERROR) {
```
<font color="green">// Signal mapped successfuly</font> }
```
}
```
}


<!-- Page 888 -->

int mc Signal Set Active Low(
HMCSIG h Sig, BOOL activelow);
rc = mc.mc Signal Set Active Low(
number h Sig, number activelow)
HMCSIG h Sig = 0;
BOOL active Low = TRUE;

<font color="green">// Set all input signals active low .</font> while
(mc Signal Get Next Handle(0, SIG_TYPE_INPUT , h Sig, &h Sig) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
```
<font color="blue">mc Signal Set Active Low(h Sig, active Low);</font> }
```
else {
```
break; }
```
}


<!-- Page 889 -->

int mc Signal Set State(
HMCSIG h Sig, BOOL enabled);
rc = mc.mc Signal Set State(
number h Sig, number enabled)
HMCSIG h Sig = 0;

<font color="green">// Set all output signals inactive.</font> while
(mc Signal Get Next Handle(0, SIG_TYPE_OUTPUT , h Sig, &h Sig) ==
```
MERROR_NOERROR) {
```
if (h Sig != 0) {
```
<font color="blue">mc Signal Set State(h Sig, F ALSE);</font> } else {
```
break; }
```
}


<!-- Page 890 -->

int mc Signal Unmap(
HMCSIG h Sig);
rc = mc.mc Signal Unmap(
number h Sig)
MINST ANCE m Inst = 0; HMCSIG h Sig;

if (mc Signal Get Handle(m Inst, ISIG_INPUT 1, &h Sig) ==
```
MERROR_NOERROR) {
if (<font color="blue">mc Signal Unmap(h Sig)</font> ==
```
MERROR_NOERROR) {
```
<font color="green">// Signal now has no I/O mappings</font> }
```
}


<!-- Page 891 -->

int mc Signal W ait(
MINST ANCE m Inst, int sig Id, int wait Mode, double timeout Secs);
rc = mc.mc Signal W ait(
number m Inst, number sig Id, number wait Mode, number timeout Secs);
MINST ANCE m Inst = 0; HMCSIG h Sig;
int rc;

rc = <font color="blue">mc Signal W ait(m Inst, ISIG_INPUT 1,
```
WAIT_MODE_HIGH, .5)</font>; switch (rc) {
case MERROR_NOERROR: <font color="green">// Signal changed state
from low to high</font> break; case MERROR_TIMED_OUT : <font
color="green">// The signal didn't change state in the alotted time.</font>
break; case MERROR_NOT_ENABLED: <font color="green">// The
```
control was not enabled at the time of the function call or the control was
```
disabled during the function call.</font> break; }


<!-- Page 892 -->

int mc Soft Limit Get State(
MINST ANCE m Inst, int axis, double *ison);
ison, rc = mc.mc Soft Limit Get State(
number m Inst, number axis)
int m Inst = 0;
int axis = Z_AXIS;
dobule Is On = 0; <font color="green">// DO_OFF to turn of f.</font>
mc Soft Limit Set State(m Inst, axis, &Is On); <font color="green">// Get the
softlimit for the Z axis return will be 1 or 0 1==on.</font>


<!-- Page 893 -->

int mc Soft Limit Max Mins Clear(
MINST ANCE m Inst);
rc = mc.mc Soft Limit Max Mins Clear(
number m Inst)
int m Inst=0;
<font color="green">// Clear the Softlimits for the file so they will be
recalculated when a regen is done.</font>
mc Soft Limit Max Mins Clear(m Inst);


<!-- Page 894 -->

int mc Soft Limit Set State(
MINST ANCE m Inst, int axis, int on);
rc = mc.mc Soft Limit Set State(
number m Inst, number axis, number on)
int m Inst=0;
int axis = Z_AXIS;
int T urn On = MC_ON; <font color="green">// MC_OFF to turn of f.</font>
mc Soft Limit Set State(m Inst, axis, T urn On); <font color="green">// Set the
softlimit forthe Z axis to be ON.</font>


<!-- Page 895 -->

int mc Spindle Calc CSST o RPM(
MINST ANCE m Inst, double Dia Of Cut, BOOL Inch);
rc = mc.mc Spindle Calc CSST o RPM(
number m Inst, number Dia Of Cut, number Inch);
<font color="green">// make the spindle speed calc the correct RPM for a
.5 5 0" inch cut.</font> MINST ANCE m Inst = 0;
int rc = mc Spindle Calc CSST o RPM(m Inst, .5 5 0, TRUE);


<!-- Page 896 -->

int mc Spindle Get Accel T ime(
MINST ANCE m Inst, int Range, double *Sec);
Sec, rc = mc.mc Spindle Get Accel T ime(
number m Inst, number Range)
<font color="green">// Get the accel time for spindle range 2.</font>
MINST ANCE m Inst = 0;
double sec = 0;
int rc = mc Spindle Get Accel T ime(m Inst, 2, &sec);


<!-- Page 897 -->

int mc Spindle Get Command RPM(
MINST ANCE m Inst, double *RPM);
RPM, rc = mc.mc Spindle Get Command RPM(
number m Inst)
<font color="green">// Get the current commanded RPM</font>
MINST ANCE m Inst = 0; double rpm = 0.0;
int rc = mc Spindle Get Command RPM(m Inst, &rpm);


<!-- Page 898 -->

int mc Spindle Get Current Range(
MINST ANCE m Inst, int *Range);
Range, rc = mc.mc Spindle Get Current Range(
number m Inst)
<font color="green">// Get the current spindle range.</font> MINST ANCE
m Inst = 0;
int range = 0;
int rc = mc Spindle Get Current Range(m Inst, &range);


<!-- Page 899 -->

int mc Spindle Get Decel T ime(
MINST ANCE m Inst, int Range, double *Sec);
Sec, rc = mc.mc Spindle Get Decel T ime(
number m Inst, number Range)
<font color="green">// Get the decel. time for spindle range 3</font>
MINST ANCE m Inst = 0;
double sec = 0.0;
int rc = mc Spindle Get Decel T ime(m Inst, 3, &ec);


<!-- Page 900 -->

int mc Spindle Get Direction(
MINST ANCE m Inst, int *dir);
dir, rc = mc.mc Spindle Get Direction(
number m Inst)
<font color="green">// Get the current spindle direction.</font>
MINST ANCE m Inst = 0;
int dir = MC_SPINDLE_OFF; int rc = mc Spindle Get Direction(m Inst,
&dir);


<!-- Page 901 -->

int mc Spindle Get Feedback Ratio(
MINST ANCE m Inst, int Range, double *Ratio);
Ratio, rc = mc.mc Spindle Get Feedback Ratio(
number m Inst, number Range)
<font color="green">// Get the feedback ratio for spindle range 0.</font>
MINST ANCE m Inst = 0;
double ratio = 0.0;
int rc = mc Spindle Get Feedback Ratio(m Inst, 0, &ratio);


<!-- Page 902 -->

int mc Spindle Get Max RPM(
MINST ANCE m Inst, int Range, double *Max RPM);
Max RPM, rc = mc.mc Spindle Get Max RPM(
number m Inst, number Range)
<font color="green">// Get the max RPM for range 0.</font>
MINST ANCE m Inst = 0;
double mrpm = 0.0
int rc = mc Spindle Get Max RPM(m Inst, 0, &mrpm);


<!-- Page 903 -->

int mc Spindle Get Min RPM(
MINST ANCE m Inst, int Range, double *Min RPM);
Min RPM, rc = mc.mc Spindle Get Min RPM(
number m Inst, number Range)
<font color="green">// Get the min RPM for range 0.</font> MINST ANCE
m Inst = 0;
double mrpm = 0.0
int rc = mc Spindle Get Min RPM(m Inst, 0, &mrpm);


<!-- Page 904 -->

int mc Spindle Get Motor Accel(
MINST ANCE m Inst, int Range, double *Accel);
Accel, rc = mc.mc Spindle Get Motor Accel(
number m Inst, number Range)
<font color="green">// Get the spindle acceleration for range 1.</font>
MINST ANCE m Inst = 0;
double accel = 0.0;
int rc = mc Spindle Get Motor Accel(m Inst, 1, &accel);


<!-- Page 905 -->

int mc Spindle Get Motor Max RPM(
MINST ANCE m Inst, double *RPM);
RPM, rc = mc.mc Spindle Get Motor Max RPM(
number m Inst)
<font color="green">// Get the maximum spindle motor RPM.</font>
MINST ANCE m Inst = 0;
double rpm = 0.0;
int rc = mc Spindle Get Motor Max RPM(m Inst, &rpm);


<!-- Page 906 -->

int mc Spindle Get Motor RPM(
MINST ANCE m Inst, double *RPM);
rpm, rc = mc.mc Spindle Get Motor RPM(
number m Inst)
<font color="green">// Get the current motor RPM.</font> MINST ANCE
m Inst = 0;
double rpm = 0.0;
int rc = mc Spindle Get Motor RPM(m Inst, &rpm);


<!-- Page 907 -->

int mc Spindle Get Override(
MINST ANCE m Inst, double *percent);
percent, rc = mc Spindle Get Override(
number m Inst)
<font color="green">// Get the spindle override. .5 == 5 0%</font>
MINST ANCE m Inst = 0;
double percent = 0.0;
int rc = mc Spindle Get Override(m Inst, &percent);


<!-- Page 908 -->

int mc Spindle Get Override Enable(
MINST ANCE m Inst, BOOL *enabled);
enabled, rc = mc Spindle Get Override Enable(
number m Inst)
<font color="green">// Get the spindle override status.</font>
MINST ANCE m Inst = 0;
BOOL enabled = F ALSE;
int rc = mc Spindle Get Override Enable(m Inst, &enabled);


<!-- Page 909 -->

int mc Spindle Get Reverse(
MINST ANCE m Inst, int Range, BOOL *Reversed);
Rreversed, rc = mc.mc Spindle Get Reverse(
number m Inst, number Range)
<font color="green">// See if the spindle is reversed in range 1</font>
MINST ANCE m Inst = 0;
BOOL reversed = F ALSE; int mc Spindle Get Reverse(m Inst, 1, &reversed);


<!-- Page 910 -->

int mc Spindle Get Sensor RPM(
MINST ANCE m Inst, double *RPM);
RPM, rc = mc.mc Spindle Get Sensor RPM(
number m Inst)
<font color="green">// Get the spindle sensor RPM.</font> MINST ANCE
m Inst = 0;
double rpm = 0.0;
int rc = mc Spindle Get Sensor RPM(m Inst, &rpm);


<!-- Page 911 -->

int mc Spindle Get Speed Check Enable(
MINST ANCE m Inst, BOOL *enabled);
enabled, rc = mc.mc Spindle Get Speed Check Enable(
number m Inst)
<font color="green">// Check the staus of spindle speed check.</font>
MINST ANCE m Inst = 0;
BOOL enabled = F ALSE;
int rc = mc Spindle Get Speed Check Enable(m Inst, &enabled);


<!-- Page 912 -->

int mc Spindle Get Speed Check Percent(
MINST ANCE m Inst, double *percent);
percent, rc = mc.mc Spindle Get Speed Check Percent(
number m Inst)
<font color="green">// Get the speed check percentage.</font>
MINST ANCE m Inst = 0;
double percent = 0.0;
int rc = mc Spindle Get Speed Check Percent(m Inst, &percent);


<!-- Page 913 -->

int mc Spindle Get T rue RPM(
MINST ANCE m Inst, double *RPM);
RPM, rc = mc.mc Spindle Get T rue RPM(
number m Inst)
<font color="green">// Get the true spindle RPM.</font> MINST ANCE
m Inst = 0;
double rpm = 0.0;
int rc = mc Spindle Get T rue RPM(m Inst, &rpm);


<!-- Page 914 -->

int mc Spindle Set Accel T ime(
MINST ANCE m Inst, int Range, double Sec);
rc = mc.mc Spindle Set Accel T ime(
number m Inst, number Range, number Sec);
<font color="green">// Set the accel. time for spindle range 0.</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Accel T ime(m Inst, 0, 5.0);


<!-- Page 915 -->

int mc Spindle Set Command RPM(
MINST ANCE m Inst, double RPM);
rc = mc.mc Spindle Set Command RPM(
number m Inst, number RPM)
<font color="green">// Set the spindle RPM to 5 0 0 0.</font> MINST ANCE
m Inst = 0;
int rc = mc Spindle Set Command RPM(m Inst, 5 0 0 0);


<!-- Page 916 -->

int mc Spindle Set Decel T ime(
MINST ANCE m Inst, int Range, double Sec);
rc = mc.mc Spindle Set Decel T ime(
number m Inst, number Range, number Sec)
<font color="green">// Set the decel. time for spindle range 0.</font>
MINST ANCE m Inst = 0;
in rc = mc Spindle Set Decel T ime(m Inst, 0, 5);


<!-- Page 917 -->

int mc Spindle Set Direction(
MINST ANCE m Inst, int dir);
rc = mc.mc Spindle Set Direction(
number m Inst, number dir)
<font color="green">// Set the spindle direction to FWD</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Direction(m Inst, MC_SPINDLE_FWD);


<!-- Page 918 -->

int mc Spindle Set Direction W ait(
MINST ANCE m Inst, int dir);
rc = mc.mc Spindle Set Direction W ait(
number m Inst, number dir)
<font color="green">// Set the spindle direction to FWD and wait</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Direction W ait(m Inst, MC_SPINDLE_FWD);


<!-- Page 919 -->

int mc Spindle Set Feedback Ratio(
MINST ANCE m Inst, int Range, double Ratio);
rc = mc.mc Spindle Set Feedback Ratio(
number m Inst, number Range, number Ratio)
<font color="green">// Set the feedback ratio for spindle range 0.</font>
MINST ANCE m Inst = 0;
int mc Spindle Set Feedback Ratio(m Inst, 0, 1.2); <font color="green">// 1.2 :
1</font>


<!-- Page 920 -->

int mc Spindle Set Max RPM(
MINST ANCE m Inst, int Range, double RPM);
rc = mc.mc Spindle Set Max RPM(
number m Inst, number Range, number RPM);
<font color="green">// Set the max RPM for spindle range 0 to
5 0 0 0</font> MINST ANCE m Inst = 0;
int mc Spindle Set Max RPM(m Inst, 0, 5 0 0 0);


<!-- Page 921 -->

int mc Spindle Set Min RPM(
MINST ANCE m Inst, int Range, double RPM);
rc = mc.mc Spindle Set Min RPM(
number m Inst, number Range, number RPM);
<font color="green">// Set the min RPM for spindle range 0 to 6 0</font>
MINST ANCE m Inst = 0;
int mc Spindle Set Min RPM(m Inst, 0, 6 0);


<!-- Page 922 -->

int mc Spindle Set Motor Accel(
MINST ANCE m Inst, int Range, double Accel);
rc = mc.mc Spindle Set Motor Accel(
number m Inst, number Range, number Accel);
<font color="green">// Set the acceleration for the spindle motor for range
0</font> MINST ANCE m Inst = 0;
int rc = mc Spindle Set Motor Accel(m Inst, 0, 1 0 0 0 0);


<!-- Page 923 -->

int mc Spindle Set Motor Max RPM(
MINST ANCE m Inst, double RPM);
rc = mc.mc Spindle Set Motor Max RPM(
number m Inst, number RPM)
<font color="green">// Cap the spindle motor RPM to 6 0 0 0.</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Motor Max RPM(m Inst, 6 0 0 0);


<!-- Page 924 -->

int mc Spindle Set Override(
MINST ANCE m Inst, double percent);
rc = mc.mc Spindle Set Override(
number m Inst, number percent)
<font color="green">// Set the spindle override to 5 0% (.5 == 5 0%)</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Override(m Inst, 0.5);


<!-- Page 925 -->

int mc Spindle Set Override Enable(
MINST ANCE m Inst, BOOL enable);
rc = mc.mc Spindle Set Override Enable(
number m Inst, number enable)
<font color="green">// Enable spindle override.</font> MINST ANCE
m Inst = 0;
int rc = mc Spindle Set Override Enable(m Inst, TRUE);


<!-- Page 926 -->

int mc Spindle Set Range(
MINST ANCE m Inst, int Range);
rc = mc.mc Spindle Set Range(
number m Inst, number Range)
<font color="green">// Set the current spindle range to the first range (0).
</font> MINST ANCE m Inst = 0;
mc Spindle Set Range(m Inst, 0);


<!-- Page 927 -->

int mc Spindle Set Reverse(
MINST ANCE m Inst, int Range, BOOL Reversed);
rc = mc.mc Spindle Set Reverse(
number m Inst, number Range, number Reversed)
<font color="green">// Set spindle range 1 as being reversed.</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Reverse(m Inst, 1, TRUE);


<!-- Page 928 -->

int mc Spindle Set Sensor RPM(
MINST ANCE m Inst, double RPM);
rc = mc.mc Spindle Set Sensor RPM(
number m Inst, number RPM)
<font color="green">// Set the spindle sensor RPM to 1 0 0 0</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Sensor RPM(m Inst, 1 0 0 0);


<!-- Page 929 -->

int mc Spindle Set Speed Check Enable(
MINST ANCE m Inst, BOOL enable);
rc = mc.mc Spindle Set Speed Check Enable(
number m Inst, number enable)
<font color="green">// Enable spindle speed checking.</font>
MINST ANCE m Inst = 0;
int rc = mc Spindle Set Speed Check Enable(m Inst, TRUE);


<!-- Page 930 -->

int mc Spindle Set Speed Check Percent(
MINST ANCE m Inst, double percent);
rc = mc.mc Spindle Set Speed Check Percent(
number m Inst, number percent)
<font color="green">// Set the speed check percentage to 5%. 1 0 0 == 1 0 0%
</font> MINST ANCE m Inst = 0;
int rc = mc Spindle Set Speed Check Percent(m Inst, 5);


<!-- Page 931 -->

int mc Spindle Speed Check(
MINST ANCE m Inst, int *Speed Ok);
Speed Ok, rc = mc.mc Spindle Speed Check(
number m Inst)
<font color="green">// Check to see if the spidnle speed is in the allowed
range.</font> MINST ANCE m Inst = 0; BOOL speed Ok;
int rc = mc Spindle Speed Check(m Inst, &speed Ok);


<!-- Page 932 -->

int mc T ool Get Current(
MINST ANCE m Inst, int *toolnum);
toolnum, rc = mc.mc T ool Get Current(
number m Inst)
<font color="green">// Get the current tool.</font> MINST ANCE m Inst =
0; int toolnum = 0;
int rc = mc T ool Get Current(m Inst, &toolnum);


<!-- Page 933 -->

int mc T ool Get Data(
MINST ANCE m Inst, int type, int tool Number , double *value);
value, rc = mc.mc T ool Get Data(
number m Inst, number type, number tool Number)
MINST ANCE m Inst = 0; int toolnum = 5;
double val = 0;
<font color="green">// Get the tool height of fset for tool number 5.</font>
int rc = mc T ool Get Data(m Inst, MT OOL_MILL_HEIGHT , toolnum, &val);


<!-- Page 934 -->

int mc T ool Get Data Ex Dbl(
```
MINST ANCE m Inst, int toolnum, const char *field Name, double
*value);
value, rc = mc.mc T ool Get Data Ex Dbl(
number m Inst, number tool Number , string field Name)
MINST ANCE m Inst = 0;
int toolnum = 5;
double val = 0;
<font color="green">// Get the contents of "My User Field" for tool number
5.</font> int rc = mc T ool Get Data Ex Dbl(m Inst, toolnum, "My User Field",
&val);


<!-- Page 935 -->

int mc T ool Get Data Ex Int(
```
MINST ANCE m Inst, int toolnum, const char *field Name, int *value);
value, rc = mc.mc T ool Get Data Ex Int(
number m Inst, number tool Number , string field Name)
MINST ANCE m Inst = 0;
int toolnum = 5;
int val = 0;
<font color="green">// Get the contents of "My User Field" for tool number
5.</font> int rc = mc T ool Get Data Ex Int(m Inst, toolnum, "My User Field",
&val);


<!-- Page 936 -->

int mc T ool Get Data Ex Str(
```
MINST ANCE m Inst, int toolnum, const char *field Name, char *value,
size_t value Len);
value, rc = mc.mc T ool Get Data Ex Str(
number m Inst, number tool Number , string field Name)
MINST ANCE m Inst = 0;
int toolnum = 5;
char val[1 2 8];
<font color="green">// Get the contents of "My User Field" for tool number
5.</font> int rc = mc T ool Get Data Ex Str(m Inst, toolnum, "My User Field",
val, sizeof(val));


<!-- Page 937 -->

int mc T ool Get Desc(
MINST ANCE m Inst, int toolnum, char *buf f, size_t bufsize);
buff, rc = mc.mc T ool Get Desc(
number m Inst, number toolnum)
MINST ANCE m Inst = 0; char desc[1 2 8];
int toolnum = 5;
<font color="green">// Get the description of tool number 5 for controller
0.</font> int rc = mc T ool Get Desc(m Inst, toolnum, desc, sizeof(desc));


<!-- Page 938 -->

int mc T ool Get Selected(
MINST ANCE m Inst, int *toolnum);
toolnum, rc = mc.mc T ool Get Selected(
number m Inst)
<font color="green">// Get the selected tool number .</font> MINST ANCE
m Inst = 0;
int toolnum = 0;
int rc = mc T ool Get Selected(m Inst, &toolnum);


<!-- Page 939 -->

int mc T ool Load File(
```
MINST ANCE m Inst, const char *File T o Load);
rc = mc.mc T ool Load File(
number m Inst, string File T o Load)
<font color="green">// Load a tool table.</font> MINST ANCE m Inst = 0;
int rc = mc T ool Load File(m Inst, "tooltable.tls");


<!-- Page 940 -->

int mc T ool Path Create(
MINST ANCE m Inst, void *window);
N/A
wx Panel* m_tp TP;

MINST ANCE m Inst = 0; m_tp TP = new wx Panel(item Panel 1 2 9,
ID_T OOLP ATH_P ANEL, wx Default Position, wx Default Size,
```
wx TAB_TRA VERSAL ); rc = m_tp TP->Show(); <font color="green">//
Pass the handle of the tool path.</font> mc T ool Path Create(m Inst, m_tp TP-
```
>Get HWND());


<!-- Page 941 -->

int mc T ool Path Delete(
MINST ANCE m Inst, void *parent);
N/A
<font color="green">// Delete an existing tool path.</font> MINST ANCE
m Inst = 0; HWND parent; <font color="green">// A previously valid
window handle.</font> int rc = mc T ool Path Delete(m Inst, parent);


<!-- Page 942 -->

int mc T ool Path Generate(
MINST ANCE m Inst);
rc = mc.mc T ool Path Generate(
number m Inst)
MINST ANCE m Inst = 0;
<font color="green">// Regenerate the toolpaths for controller instance
0</font> int rc = mc T ool Path Generate(m Inst);


<!-- Page 943 -->

int mc T ool Path Generate Abort(
MINST ANCE m Inst);
rc = mc.mc T ool Path Generate Abort(
number m Inst);
MINST ANCE m Inst = 0;
<font color="green">// Abort the regeneration of the toolpath for controller
0.</font> int rc = mc T ool Path Generate Abort(m Inst);


<!-- Page 944 -->

int mc T ool Path Generated Percent(
MINST ANCE m Inst, double *percent);
percent, rc = mc.mc T ool Path Generated Percent(
number m Inst)
MINST ANCE m Inst = 0;
double pdone = 0;

```
while (pdone != 1 0 0) {
<font color="green">// Get the percent of the file that is loaded.</font>
mc Tool Path Generated Percent(m Inst, &pdone); <font color="green">// Post
```
the pdone to some dialog.</font> Sleep(2 5 0); }


<!-- Page 945 -->

mc Tool Path Get AAxis Position(MINST ANCE m Inst, double *x Pos, double
*y Pos, double *z Pos);
mc Tool Path Get AAxis Position(MINST ANCE m Inst, double *x Pos, double
*y Pos, double *z Pos);
<font color="green">// </font> MINST ANCE m Inst = 0;
mc Tool Path Get AAxis Position(MINST ANCE m Inst, double *x Pos, double
*y Pos, double *z Pos);


<!-- Page 946 -->

mc Tool Path Get ARotation Axis
C/C++ Syntax:
mc Tool Path Get ARotation Axis(MINSTANCE m Inst, int *axis);

LUA Syntax:
mc Tool Path Get ARotation Axis(MINSTANCE m Inst, int *axis);

Description:

Parameters:
Parameter Description
m Inst The controller instance.

Returns:
Return Code Description
MERROR_NOERROR No Error .
MERROR_INV ALID_INST ANCEThe m Inst
parameter was out
of range.
Notes:
Usage:
//
MINSTANCE m Inst = 0;
mc Tool Path Get ARotation Axis(MINSTANCE m Inst, int *axis);


<!-- Page 947 -->

int mc T ool Path Get Axis Color(
MINST ANCE m Inst, unsigned long *axiscolor , unsigned long
*limitcolor);
axiscolor , limitcolor , rc = mc.mc T ool Path Get Axis Color(
number m Inst)
<font color="green">// Get the axis and limit colors.</font> MINST ANCE
m Inst = 0;
int rc = mc T ool Path Get Axis Color(MINST ANCE m Inst, unsigned long
*axiscolor , unsigned long *limitcolor);


<!-- Page 948 -->

int mc T ool Path Get Back Color(
MINST ANCE m Inst, unsigned long *topcolor , unsigned long *botcolor);
topcolor , botcolor , rc = mc.mc T ool Path Get Back Color(
number m Inst)
MINST ANCE m Inst = 0;
unsigned long topcol, botcol;

<font color="green">// Get the tool background top and bottom
colors</font> int rc = mc T ool Path Get Back Color(m_inst, &topcol,
&botcol);


<!-- Page 949 -->

int mc T ool Path Get Draw Limits(
MINST ANCE m Inst, BOOL *drawlimits);
drawlimits, rc = mc T ool Path Get Draw Limits(
number m Inst)
MINST ANCE m Inst = 0;
BOOL drawlimits = F ALSE;
<font color="green">// See if the soft limits bounding box is beeing shown
in the toolpath.</font> int rc = mc T ool Path Get Draw Limits(m Inst,
&drawlimits);


<!-- Page 950 -->

int mc T ool Path Get Execution(
MINST ANCE m Inst, unsigned long ex Num, void **data, unsigned long
*len);
N/A


<!-- Page 951 -->

struct Executions
```
{
bool linear : 1; //Is this a linear move?
bool rapid : 1; //Is it a Rapid move?
bool inc : 1; //Is this an inc move?
bool comp : 1; bool rotation : 1; //arc direction bool Used Axis 0 : 1; bool
Used Axis 1 : 1; bool Used Axis 2 : 1; bool Used Axis 3 : 1; bool Used Axis 4 :
1; bool Used Axis 5 : 1; bool Used Axis 6 : 1; bool Used Axis 7 : 1; bool
Used Axis 8 : 1; bool Used Axis 9 : 1; bool Used Axis 1 0 : 1; float end[6]; float
center[3]; float normal[3]; unsigned int Line Number; // Line number in the
file...
unsigned int Execution ID; // Number of the move from the Gcode
interperter float Feed Rate; // Feedrate of the move unsigned char
Tool Number; // T ool number of the move used to show of fsets..
unsigned char Fixture; // The fixture.
```
};
<font color="green">// </font> MINST ANCE m Inst = 0;
unsigned long ex Num = 0;
unsigned long len;
void *data;
int rc;
struct Executions *ex;


<!-- Page 952 -->

<font color="green">// Get the length of the move execution structure first.
</font> while (mc T ool Path Get Execution(m Inst, ex Num, NULL, &len) ==
```
MERROR_NOERROR) {
<font color="green">// Allocate some mem to receive the data.</font>
```
data = malloc(len); if (data != NULL) {
<font color="green">// Get the data.</font> if
(mc T ool Path Get Execution(m Inst, ex Num, &data, &len) ==
```
MERROR_NOERROR) {
<font color="green">// cast the void pointer to the current structure.
</font> ex = (struct Executions *)data; ...
```
free(data); }
```
}
```
}


<!-- Page 953 -->

int mc T ool Path Get Follow Mode(
MINST ANCE m Inst, BOOL *enabled);
enabled, rc = mc.mc T ool Path Get Follow Mode(
number m Inst)
<font color="green">// See if jog follow is enabled.</font> MINST ANCE
m Inst = 0;
BOOL enabled = F ALSE;
int rc = mc T ool Path Get Follow Mode(m Inst, &enabled);


<!-- Page 954 -->

int mc T ool Path Get Generating(
MINST ANCE m Inst, int *path Generating);
path Generating, rc = mc.mc T ool Path Get Generating(
number m Inst)
MINST ANCE m Inst = 0;
BOOL Is Gen = F ALSE;
<font color="green">// See if the tool path is generating.</font> int rc =
mc Get Path Generating(m Inst, &Is Gen);


<!-- Page 955 -->

int mc T ool Path Get Left Mouse Dn(
MINST ANCE m Inst, double *x, double *y , double *z);
x, y, z, rc = mc.mc T ool Path Get Left Mouse Dn(
number m Inst)
<font color="green">// Get the mouse coordinates in the tool path.</font>
MINST ANCE m Inst = 0;
double x, y , z;
int rc = mc T ool Path Get Left Mouse Dn(MINST ANCE m Inst, double *x,
double *y , double *z);


<!-- Page 956 -->

int mc T ool Path Get Left Mouse Up(
MINST ANCE m Inst, double *x, double *y , double *z);
x, y, z, rc = mc.mc T ool Path Get Left Mouse Up(
number m Inst)
<font color="green">// Get the mouse coordinates in the tool path.</font>
MINST ANCE m Inst = 0;
double x, y , z;
int rc = mc T ool Path Get Left Mouse Up(MINST ANCE m Inst, double *x,
double *y , double *z);


<!-- Page 957 -->

int mc T ool Path Get Path Color(
MINST ANCE m Inst, unsigned long *rapidcolor , unsigned long
*linecolor , unsigned long *arccolor , unsigned long *highlightcolor);
rapidcolor , linecolor , arccolor , highlightcolor , rc =
mc Tool Path Get Path Color(
number m Inst)
MINST ANCE m Inst = 0;
unsigned long rapcol, lincol, arccol, highcol; <font color="green">// Get the
tool path colors</font> int rc = mc T ool Path Get Path Color(m_inst, &rapcol,
&lincol, &arccol, &highcol);


<!-- Page 958 -->

int mc T ool Path Is Signal Mouse Clicks(
MINST ANCE m Inst, BOOL *enabled);
enabled, rc = mc T ool Path Is Signal Mouse Clicks(
number m Inst)
<font color="green">// See if we are signaling mouse click events in the
tool path.</font> MINST ANCE m Inst = 0;
BOOL enabled = F ALSE;
int rc = mc T ool Path Is Signal Mouse Clicks(m Inst, &enabled);


<!-- Page 959 -->

mc Tool Path Set AAxis Position(MINST ANCE m Inst, double x Pos, double
y Pos, double z Pos);
mc Tool Path Set AAxis Position(MINST ANCE m Inst, double x Pos, double
y Pos, double z Pos);
<font color="green">// </font> MINST ANCE m Inst = 0;
mc Tool Path Set AAxis Position(MINST ANCE m Inst, double x Pos, double
y Pos, double z Pos);


<!-- Page 960 -->

mc Tool Path Set ARotation Axis
C/C++ Syntax:
mc Tool Path Set ARotation Axis(MINSTANCE m Inst, int axis);

LUA Syntax:
mc Tool Path Set ARotation Axis(MINSTANCE m Inst, int axis);

Description:

Parameters:
Parameter Description
m Inst The controller instance.

Returns:
Return Code Description
MERROR_NOERROR No Error .
MERROR_INV ALID_INST ANCEThe m Inst
parameter was out
of range.
Notes:
Usage:
//
MINSTANCE m Inst = 0;
mc Tool Path Set ARotation Axis(MINSTANCE m Inst, int axis);


<!-- Page 961 -->

int mc T ool Path Set Axis Color(
MINST ANCE m Inst, unsigned long axiscolor , unsigned long limitcolor);
rc = mc.mc T ool Path Set Axis Color(
number m Inst, number axiscolor , number limitcolor)
MINST ANCE m Inst = 0;
unsigned long axiscolor;
unsigned long limitcolor;

//red
axiscolor = (2 5 5<<0);//red axiscolor += (0<<8);//green axiscolor +=
(0<<1 6);//blue
//Yellow
limitcolor = (2 5 5<<0);//red limitcolor += (2 5 5<<8);//green limitcolor +=
(1 2 8<<1 6);//blue
<font color="green">// Set the axis and limit colors</font> int rc =
mc Tool Path Set Axis Color(m Inst, axiscolor , limitcolor);


<!-- Page 962 -->

int mc T ool Path Set Back Color(
MINST ANCE m Inst, unsigned long topcolor , unsigned long botcolor);
rc = mc.mc T ool Path Set Back Color(
number m Inst, number topcolor , number botcolor)
MINST ANCE m Inst = 0;
unsigned long topcolor;


<!-- Page 963 -->

unsigned long botcolor

//Dark Blue T op
topcolor = (2 8<<0); topcolor += (2 8<<8); topcolor += (2 1 3<<1 6); //Light
Blue Bottom
botcolor = (1 6 4<<0); botcolor += (1 5 6<<8); botcolor += (2 2 8<<1 6);
<font color="green">// Set the background color</font> int rc =
mc Tool Path Set Back Color(m Inst, topcolor , botcolor);


<!-- Page 964 -->

int mc T ool Path Set Draw Limits(
MINST ANCE m Inst, BOOL drawlimits);
rc = mc.mc T ool Path Set Draw Limits(
number m Inst, number drawlimits)
<font color="green">// T urn on soft limits in the tool path.</font>
MINST ANCE m Inst = 0;
int rc = mc T ool Path Set Draw Limits(m Inst, TRUE);


<!-- Page 965 -->

int mc T ool Path Set Follow Mode(
MINST ANCE m Inst, BOOL enabled);
rc = mc.mc T ool Path Set Follow Mode(
number m Inst, number enabled)
<font color="green">// T urn on tool path jog following.</font>
MINST ANCE m Inst = 0;
int rc = mc T ool Path Set Follow Mode(m Inst, TRUE);


<!-- Page 966 -->

int mc T ool Path Set Path Color(
MINST ANCE m Inst, unsigned long rapidcolor , unsigned long linecolor ,
unsigned long arccolor , unsigned long highlightcolor);
rc = mc.mc T ool Path Set Path Color(
number m Inst, number rapidcolor , number linecolor , number arccolor ,
number highlightcolor)
<font color="green">// Set the tool path colors</font> MINST ANCE m Inst
= 0;
unsigned long rapidcolor;
unsigned long linecolor;
unsigned long arccolor;
unsigned long highlightcolor;

rapidcolor = (2 5 4<<0);//Red rapidcolor += (0<<8);//Green rapidcolor +=
(0<<1 6);//Blue
linecolor = (0<<0);//Red
linecolor += (2 5 4<<8);//Green linecolor += (0<<1 6);//Blue
arccolor = (0<<0);//Red
arccolor += (2 5 4<<8);//Green arccolor += (0<<1 6);//Blue
highlightcolor = (2 5 4<<0);//Red highlightcolor += (2 5 4<<8);//Green
highlightcolor += (2 5 4<<1 6);//Blue


<!-- Page 967 -->

int rc = mc T ool Path Set Path Color(m Inst, rapidcolor , linecolor , arccolor ,
highlightcolor);


<!-- Page 968 -->

int mc T ool Path Set Signal Mouse Clicks(
MINST ANCE m Inst, BOOL enabled);
rc = mc.mc T ool Path Set Signal Mouse Clicks(
number m Inst, number enabled)
<font color="green">// T urn on mouse click events in the tool path.</font>
MINST ANCE m Inst = 0;
int rc = mc T ool Path Set Signal Mouse Clicks(m Inst, TRUE);


<!-- Page 969 -->

int mc T ool Path Set V iew(
MINST ANCE m Inst, void *parent, int view);
N/A
<font color="green">// Set the tool path orientation to the ISO view .</font>
MINST ANCE m Inst = 0;
HWND parent; <font color="green">// A valid window handle.</font> int
rc = mc T ool Path Set V iew(m Inst, parent, MCTPVIEW_ISO);


<!-- Page 970 -->

int mc T ool Path Set Zoom(
MINST ANCE m Inst, void *parent, double zoom);
N/A
<font color="green">// Set the toop path zoom percentage to 1 5 0%</font>
MINST ANCE m Inst = 0;
HWND parent; <font color="green">// A valid window handle.</font> int
rc = mc T ool Path Set Zoom(m Inst, parent, 1.5);


<!-- Page 971 -->

int mc T ool Path Update(
MINST ANCE m Inst, void *parent);
N/A
MINST ANCE m Inst = 0; HWND parent; <font color="green">// A valid
window handle.</font> int mc T ool Path Update(m Inst, parent);


<!-- Page 972 -->

int mc T ool Save File(
MINST ANCE m Inst);
rc = mc T ool Save File(
number m Inst)
<font color="green">// Save the previously loaded tool table file.</font>
MINST ANCE m Inst = 0; int rc = mc T ool Save File(m Inst);


<!-- Page 973 -->

int mc T ool Set Current(
MINST ANCE m Inst, int toolnum);
rc = mc.mc T ool Set Current(
number m Inst, number toolnum)
<font color="green">// Set the current tool to tool #1.</font> MINST ANCE
m Inst = 0; int rc = mc T ool Set Current(m Inst, 1);


<!-- Page 974 -->

int mc T ool Set Data(
MINST ANCE m Inst, int T ype, int T oolnumber , double val);
rc = mc.mc T ool Set Data(
number m Inst, number T ype, number T oolnumber , number val);
MINST ANCE m Inst = 0; int toolnum = 5;
double val = 0;
<font color="green">// Set the tool height wear of fset to zero.</font> int rc
= mc T ool Set Data(m Inst, MT OOL_MILL_HEIGHT_W , toolnum, val);


<!-- Page 975 -->

int mc T ool Set Data Ex Dbl(
```
MINST ANCE m Inst, int tool Num, const char *field Name, double value);
rc = mc.mc T ool Set Data Ex Dbl(
number m Inst, number tool Num, string field Name, number val);
MINST ANCE m Inst = 0;
int toolnum = 5;
double val = 0;
<font color="green">// Set the user field "My User Field" to zero.</font> int
rc = mc T ool Set Data Ex Dbl(m Inst, toolnum, "My User Field", val);


<!-- Page 976 -->

int mc T ool Set Data Ex Int(
```
MINST ANCE m Inst, int tool Num, const char *field Name, int value);
rc = mc.mc T ool Set Data Ex Int(
number m Inst, number tool Num, string field Name, number val);
MINST ANCE m Inst = 0;
int toolnum = 5;
int val = 0;
<font color="green">// Set the user field "My User Field" to zero.</font> int
rc = mc T ool Set Data Ex Int(m Inst, toolnum, "My User Field", val);


<!-- Page 977 -->

int mc T ool Set Data Ex Str(
```
MINST ANCE m Inst, int tool Num, const char *field Name, const char
*value);
rc = mc.mc T ool Set Data Ex Str(
number m Inst, number tool Num, string field Name, string val);
MINST ANCE m Inst = 0;
int toolnum = 5;
char val[1 2 8];
<font color="green">// Set the user field "My User Field" to zero.</font>
strcpy(val, "0");
int rc = mc T ool Set Data Ex Str(m Inst, toolnum, "My User Field", val);


<!-- Page 978 -->

int mc T ool Set Desc(
```
MINST ANCE m Inst, int toolnum, const char *tdsc);
rc = mc.mc T ool Set Desc(
number m Inst, number toolnum, string tdsc);
MINST ANCE m Inst = 0;
char desc[1 2 8] = "My Best 1/2 inch endmill"; int toolnum = 5;
<font color="green">// Set the description of tool number 5.</font> int rc =
mc Tool Set Desc(m Inst, toolnum, desc);


<!-- Page 979 -->

Plugin Development
The following topics will discuss things common to all plugins.
General Plugin Design Suggestions
```
The following topics will discuss some of the special function interfaces
that are vaiable to a motion plugin.

Probing
Rigid T apping
Threading


<!-- Page 980 -->

General Plugin Design Suggestions


<!-- Page 981 -->

Registering I/O:
```
I/O should be registered in the mc Plugin Init() plugin entry point. It should
not depend on the device actually working or in a "connected" state.
Instead, I/O sonfiguration should be done from the profile configuration. A
"fresh" config could just have a minimal amount of defaults that may be
common to the dif ferent devices (if the plugin supports multiple devices).
Using this method assures that a device connection failure does not wipe
the Core user mappings. Of course you should have a message notifying the
user of the connection failure and you should also prevent the plugin from
```
trying to function in this state.


<!-- Page 982 -->

Configuration Dialogs:
Typical config dialogs really should do only two things which are reading
and writing settings to the profile. The plugin should read the settings from
the profile upon startup and after a config change. Meaning it is usually not
```
a good idea to pass pointers to control structures or classes from the plugin
and have the configuration dialog modify them. It is much better to isolate
the config dialog from the plugin in this manner . You should create a plugin
config dialog with the goal of it being able to work autonomously to the
extent where the dialog could be used in a separate config executable.


<!-- Page 983 -->

Detecting signal, I/O, and register changes:
The Core uses a messaging system to keep the plugins informed of signal
and register changes. It is not necessary to poll signal states or registers at
all. If the Core changes an output signal, it sends a MSG_SIG_CHANGED
message to the plugin. All you have to do is watch for any given signal you
are interested in. The signal ID will be passed in param 1 and the state
passed in param 2. The same for registers except your plugin will only
receive register changes for registers that your plugin created via the
```
mc Plugin Msg() (synchronous) callback. The register handle will be passed
```
in param 1. You must then call mc Register Get*() functions to retrieve the
new value of the register since they can contain any type of data like strings
or double values that cannot be passed in param 2.
It is also not necessary to poll the state of outputs that your plugin created.
If a user has mapped them to a Core signal, and the Core changes the state
of the output via changing its mapped signal, then your plugin will get a
```
MSG_IO_CHANGED message via the mc Plugin Msg() callback. The
handle to the IO object will be passed in param 1 and the state will be passed
in param 2.


<!-- Page 984 -->

Detecting configuration changes:
The Core sends a MSG_CONFIG_END to the plugins at startup when all of
the device, axis, and motor information is available. This is the point at
which the Core has everything loaded and configured and is ready for
operation. If the user enters the Core configuration dialog, The Core will
send a MSG_CONFIG_ST ART. It will also send a MSG_CONFIG_END
when the user is finished the configuring process. You can use the
MSG_CONFIG_END message in your plugin to do any housekeeping that
needs to be done after configuration changes. If you see a
MSG_CONFIG_ST ART, you can put your device into a benign state, if you
wish, but MSG_CONFIG_END must take it out of this state.


<!-- Page 985 -->

Controlling the interoperability with other Core
devices:
Every now and then, it may be desirable to have your plugin only work if
other devices are present. Similarly , you may wish to disable other devices
that you deem necessary . As an example, if you wanted the Core to only run
with your plugin, then in your plugin, you can loop through all of the Core
devices and disable any other motion device (DEV_TYPE_MOTION flag)
it finds. You might want to leave Sim operational though.


<!-- Page 986 -->

Probing


<!-- Page 987 -->

Motion plugin pr obing pr ocedur e.
The probe moves are really just G 0 1 moves in exeact stop mode with the
addition of being marked as EX_PROBE in the execution_t struct
from

```
mc Motion Cycle Planner Ex ().
When executing a G 3 1, the core considers the move as an exact stop move
and therefore will request a motor stop report. It waits on one of two
conditions:
### 1. A probe strike condition where the motion plugin calls

```
mc Motion Set Probe Complete ().
### 2. An end of move condition where the motion plugin reports the motors
as being still.
Until either of these conditions are satisfied, the core will generate
no more moves after the EX_PROBE marked moves. In other words, all
you
will get out of

```
mc Motion Cycle Planner Ex () will be EX_NONE type data. In


<!-- Page 988 -->

the event of a probe strike, this makes it safe to clear the planner and
be sure that future moves are not removed by accident.
A motion plugin should implement probing in the following way:
### 1. Upon seeing the first move marked as EX_PROBE , the plugin should
arm position latches on the hardware.
2. Then consume the EX_PROBE marked moves as normal.
## 3. If the probe stikes, the plugin should:
Cancel any motor stop report requests (retrieved from then
execution_t::move_t::ex Motors structure). (see below . VER Y
important!)
Report the latched positions via

```
mc Motion Set Probe Pos () for each motor .
Clear the hardware of any additional moves.
Call

```
mc Motion Clear Planner () to clear the Mach planner of any
unretrieved EX_PROBE moves.
Update Mach with the hardware's current position via

```
mc Motion Set Pos ().
Call


<!-- Page 989 -->

```
mc Motion Set Probe Complete ().
If any motor stop report requests has been received, do not
acknowledge them.

```
mc Motion Set Probe Complete () does this for you and a position
sync as well.
### 4. If no probe strike, then the move continues to it's end point as if it is a
regular move.
The plugin should ack any motor stop report requests with

```
mc Motion Set Still ().
The positions latches should be disarmed (if needed) when a
MSG_PROBE_DONE is seen.
### 5. In the event that the probe move is aborted, the plugin should:
Call

```
mc Motion Clear Planner () to clear the Mach planner of any
unretrieved EX_PROBE moves.
Call

```
mc Motor Set Pos () for each controlled motor .
Call


<!-- Page 990 -->

mc Motion Sync .
Call

```
mc Motion Set Still () for each controlled motor .


<!-- Page 991 -->

Probe Operation Overview.
### 1. Upon executing G 3 1, the core will mark those moves as EX_PROBE
in the data stream.
### 2. If the probe strikes before the end of the G 3 1 move, the plugin aborts
the rest of
the probe moves as described above. If a probe data file has been
opened via

```
mc Cntl Probe File Open (), then the positions recorded by the motion
plugin are inserted
into the probe data file in the specified format.
### 3. If the probe doesn't strike and the G 3 1 move reaches its end point and
a probe
data file has been opened via

```
mc Cntl Probe File Open (), then the end point positions
are inserted into the probe data file in the specified format.


<!-- Page 992 -->

Using the probe data file routines.
```
int mc Cntl Probe File Open(MINSTANCE inst, const char *filename,
```
const char *format);
The format ar gument is a printf style format with expanding macros for the
axis
values. AXIS_X , AXIS_Y , AXIS_Z , AXIS_A , AXIS_B , AXIS_C . It is
used in the
following manner:

mc Cntl Probe File Open(inst, "my Probe File.csv", "%.4 AXIS_X,
%.4 AXIS_Y, %.4 AXIS_Z");
This will produce a probe file in CSV format like so:

1.0 0 0 0, 2.0 0 0 0, -1.4 3 5 6
1.0 1 0 0, 2.0 0 0 0, -1.4 3 4 3
1.0 2 0 0, 2.0 0 0 0, -1.4 3 2 4
...
A format of "X%.4 AXIS_X, Y%.4 AXIS_Y , Z%.4 AXIS_Z" would yield:

X 1.0 0 0 0, Y 2.0 0 0 0, Z-1.4 3 5 6
X 1.0 1 0 0, Y 2.0 0 0 0, Z-1.4 3 4 3
X 1.0 2 0 0, Y 2.0 0 0 0, Z-1.4 3 2 4
...


<!-- Page 993 -->

A format of "X%.4 AXIS_X\t Y%.4 AXIS_Y\t Z%.4 AXIS_Z" would yield
a tab delimited file:

X 1.0 0 0 0 Y 2.0 0 0 0 Z-1.4 3 5 6
X 1.0 1 0 0 Y 2.0 0 0 0 Z-1.4 3 4 3
X 1.0 2 0 0 Y 2.0 0 0 0 Z-1.4 3 2 4
...

int mc Cntl Probe File Close(MINSTANCE inst); Closes the probe data
file.


<!-- Page 994 -->

Rigid T apping


<!-- Page 995 -->

Motion plugin rigid tapping
procedur e.
A plugin must use either one of two rigid tapping interfaces. (Or none is
rigid tapping is not supported.) This interface is defined when the motion
plugin registers its motion device with

```
mc Device Register () using the Type parameter bitwise values of
DEV_TYPE_R TAP or DEV_TYPE_R TAP 2.

DEV_TYPE_R TAP: This interface is defined if the motion controller
is capable of precisely controlling the spindle speed with regard to the
Z movement profile. The core profiles the Z moves and they are output
with EX_R TAP movement types in the execution_t struct from

```
mc Motion Cycle Planner Ex ().
DEV_TYPE_R TAP 2: This interface is defined if the motion
controller wants to handle the complete coordination of the rigid tap
move. With this interface, no Z move is profiled by the core. Instead,
the complete move points are provided in the tap_t structure.


<!-- Page 996 -->

Using the DEV_TYPE_RTAP 2 interface
When DEV_TYPE_R TAP 2 is selected, the core will output one place
holder move with EX_R TAP from

```
mc Motion Cycle Planner Ex (). When this is seen by the plugin, it should:
## 1. Retrieve the tap_t struct information with

```
mc Motion Get Rigid T ap Params ().
### 2. Profile the moves and synchronize the spindle according to the tap_t
struct information
### 3. Acknowledge any MSG_REPOR T_MOT OR_ST OP messages with

```
mc Motion Set Still ().


<!-- Page 997 -->

Threading


<!-- Page 998 -->

Motion plugin thr eading
procedur e.
A plugin must use either one of two threading interfaces. (Or none if
threading is not supported.) This interface is defined when the motion
plugin registers its motion device with

```
mc Device Register () using the Type parameter bitwise values of
DEV_TYPE_THREAD or DEV_TYPE_THREAD 2 .

DEV_TYPE_THREAD : This interface is defined if the motion
controller is capable of shrinking or expanding the time of the way
points in regard to the spindle speed. The core profiles the moves and
they are output with EX_THREAD movement types in the
execution_t struct from

```
mc Motion Cycle Planner Ex (). Only the G 3 2 moves are marked with
EX_THREAD .
The challenge is to to derive a ratio from the programmed spindle
speed and the actual spindle speed. If the speed is slow by 1%, then the
way point timeslice time should be increase by 1%, etc... The higher
the frequency that the actual spindle speed can be read, the greater the
thread accuracy .
The entry and exit moves from a G 7 6 are considered "normal"
movement types and do not require any spindle synchronization.


<!-- Page 999 -->

DEV_TYPE_THREAD 2 : This interface is defined if the motion
controller wants to handle the complete coordination of the threading
tap move. With this interface, no moves are profiled by the core.
Instead, the complete move points are provided in the tap_t structure.


<!-- Page 1000 -->

Using the DEV_TYPE_THREAD 2 interface (Not
implemented currently)
When DEV_TYPE_THREAD 2 is selected, the core will send a
synchronous MSG_THREAD_ST ART message. When this is seen by the
plugin, it should:
## 1. Retrieve the thread_t struct information with

```
mc Motion Get Thread Params ().
### 2. Profile the moves and synchronize the spindle according to the
thread_t struct information
### 3. Acknowledge any MSG_REPOR T_MOT OR_ST OP messages with

```
mc Motion Set Still ().

