local bit = require("mesen.bit_wrapper")
local mem = require("mesen.memory")
local gfx = require("mesen.graphics")
local input = require("mesen.controller")
local items = require("items")(mem, bit)
local menu = require("menu_drawer")(gfx, items, input, mem)

function on_frame()
  menu:frame()
end

emu.addEventCallback(on_frame, emu.eventType.startFrame)
