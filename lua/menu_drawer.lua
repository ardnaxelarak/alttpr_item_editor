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
        if entry.item then
          menuselected = true
        elseif entry.action then
          items.action_data[entry.action].action()
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
    gui.drawPolygon(leftarrow, 26, 25)
    gui.drawText(28, 18, "L", nil, nil, 11)
    gui.drawText(110, 18, pagenum .. "/" .. #pages, nil, nil, 11)
    gui.drawText(217, 18, "R", nil, nil, 11)
    gui.drawPolygon(rightarrow, 229, 25)
    local y = 45
    for i, v in ipairs(pages[pagenum]) do
      local skip = v.condition and not v.condition()
      if not skip then
        if i == menuindex then
          gui.drawPolygon(rightarrow, 15, y + 7, "white", "white")
          if menuselected then
            gui.drawPolygon(leftarrow, 147, y + 7, "white", "white")
            gui.drawPolygon(rightarrow, 230, y + 7, "white", "white")
          end
        end
        if v.item then
          local item = items.item_data[v.item]
          gui.drawText(20, y, item.name, nil, nil, 12)
          gui.drawText(150, y, tostring(item.values[item.get() + 1]), nil, nil, 12)
        elseif v.action then
          local action = items.action_data[v.action]
          gui.drawText(20, y, action.name, nil, nil, 12)
        end
        y = y + 12
      end
    end
  end

  if menu then
    joypad.set(none)
  end
end

return menu_drawer
