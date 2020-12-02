local config = require("config")
local controller = require("controller")
local items = require("items")

local menu_drawer = {}

local none = {
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

local page1 = {
  {item = "bow"},
  {item = "boomerang"},
  {item = "hookshot"},
  {item = "mushroom"},
  {item = "powder"},
  {item = "firerod"},
  {item = "icerod"},
  {item = "bombos"},
  {item = "ether"},
  {item = "quake"},
}
local page2 = {
  {item = "lamp"},
  {item = "hammer"},
  {item = "shovel"},
  {item = "flute"},
  {item = "net"},
  {item = "book"},
  {item = "somaria"},
  {item = "byrna"},
  {item = "cape"},
  {item = "mirror"},
}
local page3 = {
  {item = "boots"},
  {item = "glove"},
  {item = "flippers"},
  {item = "pearl"},
  {item = "sword"},
  {item = "shield"},
  {item = "armor"},
  {item = "magic_usage"},
}
local page4 = {
  {item = "bottles"},
  {item = "bottle1", condition = function() return items.get_bottles() >= 1 end},
  {item = "bottle2", condition = function() return items.get_bottles() >= 2 end},
  {item = "bottle3", condition = function() return items.get_bottles() >= 3 end},
  {item = "bottle4", condition = function() return items.get_bottles() >= 4 end},
}
local page5 = {
  {action = "fill_rupees"},
  {action = "fill_arrows"},
  {action = "fill_bombs"},
  {action = "fill_magic"},
  {action = "fill_health"},
  {effect = "swordless"},
  {effect = "armorless"},
  {effect = "shieldfree"},
  {effect = "ice_physics"},
}

local pages = {
  page1,
  page2,
  page3,
  page4,
  page5,
}

local rightarrow = {{0, -3}, {3, 0}, {0, 3}}
local leftarrow = {{0, -3}, {-3, 0}, {0, 3}}
local menu = false
local menuindex = 1
local pagenum = 1
local menuselected = false

local delay = 30
local rep = 10

local function frames_to_time(frames)
  local seconds = math.floor(frames / 60)
  local minutes = math.floor(seconds / 60)
  local hours = math.floor(minutes / 60)
  seconds = seconds % 60
  minutes = minutes % 60
  if hours > 0 then
    return string.format("%d:%02d:%02d", hours, minutes, seconds)
  else
    return string.format("%d:%02d", minutes, seconds)
  end
end

local function check_menu(btns)
  for i1, v1 in ipairs(config.trigger_menu) do
    local any = false
    local all = true
    for i2, v2 in ipairs(v1) do
      if not btns[v2] then
        all = false
        break
      elseif btns[v2] == 1 then
        any = true
      end
    end
    if any and all then
      return true
    end
  end
  return false
end

local function get_repeat(framenum)
  if not framenum then
    return false
  elseif framenum == 1 then
    return true
  elseif framenum > delay + 1 and (framenum - delay - 1) % rep == 0 then
    return true
  else
    return false
  end
end

function menu_drawer.frame()
  items.frame_check()

  local btns = controller.get_buttons()
  if check_menu(btns) then
    if menu then
      menu = false
    else
      menu = true
      controller.refresh_bindings()
      menuindex = 1
      menuselected = false
    end
  end

  if menu then
    if menuselected then
      local entry = pages[pagenum][menuindex]
      if btns["P1 A"] == 1 or btns["P1 B"] == 1 then
        menuselected = false
      elseif btns["P1 Right"] == 1 then
        if entry.item then
          local item = items.item_data[entry.item]
          local itemindex = item.get()
          itemindex = itemindex + 1
          if itemindex >= #item.values then
            itemindex = 0
          end
          item.set(itemindex)
        end
      elseif btns["P1 Left"] == 1 then
        if entry.item then
          local item = items.item_data[entry.item]
          local itemindex = item.get()
          itemindex = itemindex - 1
          if itemindex < 0 then
            itemindex = #item.values - 1
          end
          item.set(itemindex)
        end
      end
    else
      local entry = pages[pagenum][menuindex]
      if btns["P1 A"] == 1 then
        if not entry.condition or entry.condition() then
          if entry.item then
            menuselected = true
          elseif entry.action then
            items.action_data[entry.action].action()
          elseif entry.effect then
            local effect = items.effects_data[entry.effect]
            if effect.is_active() then
              effect.cancel()
            else
              effect.start()
            end
          end
        end
      elseif btns["P1 R"] == 1 then
        pagenum = pagenum + 1
        if pagenum > #pages then
          pagenum = 1
        end
        menuindex = 1
      elseif btns["P1 L"] == 1 then
        pagenum = pagenum - 1
        if pagenum <= 0 then
          pagenum = #pages
        end
        menuindex = 1
      elseif get_repeat(btns["P1 Down"]) then
        menuindex = menuindex + 1
        if menuindex > #pages[pagenum] then
          menuindex = 1
        end
      elseif get_repeat(btns["P1 Up"]) then
        menuindex = menuindex - 1
        if menuindex <= 0 then
          menuindex = #pages[pagenum]
        end
      end
    end

    gui.drawRectangle(10, 10, 236, 204, nil, 0x80000000)
    gui.drawPolygon(leftarrow, 26, 25, "white", "white")
    gui.drawText(28, 18, "L", nil, nil, 11)
    gui.drawText(110, 18, pagenum .. "/" .. #pages, nil, nil, 11)
    gui.drawText(217, 18, "R", nil, nil, 11)
    gui.drawPolygon(rightarrow, 229, 25, "white", "white")
    local y = 45
    for i, v in ipairs(pages[pagenum]) do
      local skip = v.condition and not v.condition()
      local color = "white"
      if skip then
        color = 0xff999999
      end
      if i == menuindex then
        gui.drawPolygon(rightarrow, 15, y + 7, color, color)
        if menuselected then
          gui.drawPolygon(leftarrow, 147, y + 7, color, color)
          gui.drawPolygon(rightarrow, 230, y + 7, color, color)
        end
      end
      if v.item then
        local item = items.item_data[v.item]
        gui.drawText(20, y, item.name, color, nil, 12)
        if not skip then
          gui.drawText(150, y, tostring(item.values[item.get() + 1]), color, nil, 12)
        end
      elseif v.action then
        local action = items.action_data[v.action]
        gui.drawText(20, y, action.name, color, nil, 12)
      elseif v.effect then
        local effect = items.effects_data[v.effect]
        local active = effect.is_active()
        if active then
          gui.drawText(20, y, effect.cancel_name, color, nil, 12)
        else
          gui.drawText(20, y, effect.name, color, nil, 12)
        end
      end
      y = y + 12
    end
  else
    -- not menu, draw current effects on screen
    local y = 207
    for i, v in ipairs(items.get_effects()) do
      local text = v.name .. " - " .. frames_to_time(v.remaining)
      gui.drawRectangle(2, y, 7 * string.len(text) + 12, 14, 0xb0000000, 0xb0000000)
      gui.drawText(3, y - 1, v.name .. " - " .. frames_to_time(v.remaining))
      y = y - 15
    end
  end

  if menu then
    joypad.set(none)
  end
end

return menu_drawer
