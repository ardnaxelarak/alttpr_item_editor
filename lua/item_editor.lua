local config = require("config")

local network
local json
if config.use_network then
  network = require("network_client")
  json = require("json")
end
local controller = require("controller")
local items = require("items")
local menu = require("menu_drawer")
local twitch = require("twitch-integration")

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
  local json_data = json.decode(data)
  if json_data.type == "redemption" then
    items.receive_data(json_data.value)
  end
end

function on_exit()
  if config.use_network then
    network.close()
  end
end

controller.refresh_bindings()

if config.use_network then
  network.register(on_data, config.twitch_username)
end

event.onexit(on_exit)

while true do
  gameloop()
  emu.frameadvance()
end
