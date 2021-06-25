local controller = {}

local snes_bindings = {}

local no_inputs = {
  ["P1 Start"] = false,
  ["P1 Select"] = false,
  ["P1 Up"] = false,
  ["P1 Down"] = false,
  ["P1 Left"] = false,
  ["P1 Right"] = false,
  ["P1 Y"] = false,
  ["P1 B"] = false,
  ["P1 X"] = false,
  ["P1 A"] = false,
  ["P1 L"] = false,
  ["P1 R"] = false,
}

function controller.refresh_bindings()
  local bindings = client.getconfig().AllTrollers["SNES Controller"]
  snes_bindings = {}
  for k, v in pairs(no_inputs) do
    local list = bindings[k]
    snes_bindings[k] = {}
    for substring in list:gmatch("[^,]+") do
      table.insert(snes_bindings[k], bizstring.trim(substring))
    end
  end
end

function controller.get_inputs()
  local inputs = {}
  local current_input = input.get()

  for k, v in pairs(snes_bindings) do
    local found = false
    for i, v2 in ipairs(v) do
      if current_input[v2] then
        found = true
        break
      end
    end

    inputs[string.sub(k:lower(), 4)] = found
  end

  return inputs
end

function controller.clear_inputs()
  joypad.set(no_inputs)
end

return controller
