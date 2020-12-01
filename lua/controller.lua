local controller = {}

local buttons = {}

local snes_buttons = {
  "P1 Up",
  "P1 Down",
  "P1 Left",
  "P1 Right",
  "P1 Start",
  "P1 Select",
  "P1 A",
  "P1 B",
  "P1 X",
  "P1 Y",
  "P1 L",
  "P1 R",
}

local snes_bindings = {}

function controller.refresh_bindings()
  local bindings = client.getconfig().AllTrollers["SNES Controller"]
  snes_bindings = {}
  for k, v in pairs(snes_buttons) do
    local list = bindings[v]
    snes_bindings[v] = {}
    for substring in list:gmatch("[^,]+") do
      table.insert(snes_bindings[v], bizstring.trim(substring))
    end
  end
end

function controller.get_buttons()
  local current_input = input.get()
  for k, v in pairs(current_input) do
    if v then
      if buttons[k] then
        buttons[k] = buttons[k] + 1
      else
        buttons[k] = 1
      end
    else
      buttons[k] = false
    end
  end

  for k, v in pairs(snes_bindings) do
    local found = false
    for i, v2 in ipairs(v) do
      if current_input[v2] then
        found = true
        break
      end
    end

    if found then
      if buttons[k] then
        buttons[k] = buttons[k] + 1
      else
        buttons[k] = 1
      end
    else
      buttons[k] = false
    end
  end

  for k, v in pairs(buttons) do
    if v and not current_input[k] and not snes_bindings[k] then
      buttons[k] = false
    end
  end

  return buttons
end

return controller
