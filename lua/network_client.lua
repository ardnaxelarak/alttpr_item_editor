local socket
local tcp
local client
local callback

local network = {}

function network.register(callbk, username)
  socket = require("socket.core")
  tcp = socket.tcp()
  client, err = tcp:connect("twitchbot.birdfruit.kiwi", 3535)
  if username then
    res, err = tcp:send("{\"twitch_username\": \"" .. username .. "\"}");
    if err then
      console.log(err)
    end
  end
  tcp:settimeout(0.01)
  callback = callbk
end

function network.check()
  local data = tcp:receive()
  if data then
    callback(data)
  end
end

function network.close()
  tcp:close()
end

return network
