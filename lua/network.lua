local socket
local tcp
local clients = {}
local callback

local network = {}

function network.register(callbk)
  socket = require("socket.core")
  tcp = socket.tcp()
  assert(tcp:bind("localhost", 2134))
  assert(tcp:listen())
  assert(tcp:settimeout(0.001))
  callback = callbk
end


function network.check()
  local client, err = tcp:accept()
  if err then
    if err ~= "timeout" then
      console.log(err)
    end
  end
  if client then
    assert(client:settimeout(0.001))
    table.insert(clients, client)
  end

  for k, v in pairs(clients) do
    local data = v:receive()
    if data then
      callback(data)
    end
  end
end

function network.close()
  for k, v in pairs(clients) do
    v:close()
  end
  tcp:close()
end

return network
