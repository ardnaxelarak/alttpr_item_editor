local controller = {}

local button_map = {
  a = "Joy1 But2",
  b = "Joy1 But1",
  x = "Joy1 But4",
  y = "Joy1 But3",
  l = "Joy1 But5",
  r = "Joy1 But6",
  up = "Joy1 Y+",
  down = "Joy1 Y-",
  right = "Joy1 X+",
  left = "Joy1 X-",
  select = "Joy1 But7",
  start = "Joy1 But8",
}

function controller.get_inputs()
  local inputs = {}
  for k, v in pairs(button_map) do
    inputs[k] = emu.isKeyPressed(v)
  end
  return inputs
end

return controller
