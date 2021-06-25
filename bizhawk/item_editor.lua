local mem = require('bizhawk.mem')
local gfx = require('bizhawk.gfx')
local ctrl = require('bizhawk.controller')
local items = require('items')(mem, bit)
local menu = require('menu_drawer')(gfx, items, ctrl, mem)

ctrl.refresh_bindings()

function on_frame()
  menu:frame()
  if menu.menu then
    ctrl:clear_inputs()
  end
end

event.onframestart(on_frame)
