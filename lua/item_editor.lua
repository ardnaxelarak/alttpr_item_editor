local config = require("config")

if config.use_network then
  local network = require("network")
end

local controller = require("controller")
local items = require("items")
local menu = require("menu_drawer")

local itemlist = {}

function gameloop()
  if track_items then
    for k, v in pairs(items.addresses) do
      old = itemlist[k]
      itemlist[k] = memory.readbyte(v)
      if old ~= nil and itemlist[k] ~= old then
        console.log(k .. " = " .. itemlist[k])
      end
    end
  end
  if config.use_network then
    network.check()
  end
  menu.frame()
end

function on_data(data)
  console.log(data)
end

function on_exit()
  if config.use_network then
    network.close()
  end
end

controller.refresh_bindings()

if config.use_network then
  network.register(on_data)
end

event.onexit(on_exit)

while true do
  gameloop()
  emu.frameadvance()
end
