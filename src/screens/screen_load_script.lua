-- screen_load_script.lua
-- Screen Load Script for Hello World UI
-- This goes in the Screen Load Script of your custom Mach4 screen

local inst = mc.mcGetInstance()

-- Initialize any screen variables or settings here
print("Hello World Plugin Screen Loaded")

-- Set default values for the text input
local default_size = "2.0"
scr.SetProperty("txtMoveSize", "Value", default_size)

-- Set button text
scr.SetProperty("btnExecuteMove", "Label", "Execute Square Move")

-- Initialize register for storing move size (if needed for future features)
local reg_handle, rc = mc.mcRegGetHandle(inst, "plugins/helloworld/move_size")
if rc == 0 then
    mc.mcRegSetValueString(reg_handle, default_size)
end