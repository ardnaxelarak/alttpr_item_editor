local config = require("config")

local network = require("network")
local json = require("json")
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
  local json_data = json.decode(data)
  if twitch and json_data.type == "reward" then
    for i, v in ipairs(twitch.redeems) do
      if v.key.title and v.key.title == json_data.data.redeem_title then
        items.receive_data(v.value)
      end
    end
  end
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
