local Menu = {}

function Menu:new(gfx, items, input, mem)
  o = {}
  setmetatable(o, self)
  self.__index = self
  self.gfx = gfx
  self.items = items
  self.data = items:get_data()
  self.input = input
  self.mem = mem
  self.menu = false
  self.menuindex = 1
  self.pagenum = 1
  self.menuselected = false
  self.btns = {
    a = 0,
    b = 0,
    x = 0,
    y = 0,
    l = 0,
    y = 0,
    left = 0,
    right = 0,
    up = 0,
    down = 0,
    start = 0,
    select = 0,
  }
  return o
end

local page1 = {
  {type = "item", value = "bow"},
  {type = "item", value = "boomerang"},
  {type = "item", value = "hookshot"},
  {type = "item", value = "mushroom"},
  {type = "item", value = "powder"},
  {type = "item", value = "firerod"},
  {type = "item", value = "icerod"},
  {type = "item", value = "bombos"},
  {type = "item", value = "ether"},
  {type = "item", value = "quake"},
}
local page2 = {
  {type = "item", value = "lamp"},
  {type = "item", value = "hammer"},
  {type = "item", value = "shovel"},
  {type = "item", value = "flute"},
  {type = "item", value = "net"},
  {type = "item", value = "book"},
  {type = "item", value = "somaria"},
  {type = "item", value = "byrna"},
  {type = "item", value = "cape"},
  {type = "item", value = "mirror"},
}
local page3 = {
  {type = "item", value = "boots"},
  {type = "item", value = "glove"},
  {type = "item", value = "flippers"},
  {type = "item", value = "pearl"},
  {type = "item", value = "sword"},
  {type = "item", value = "shield"},
  {type = "item", value = "armor"},
  {type = "item", value = "magic_usage"},
  {type = "item", value = "bomb_upgrades"},
}
local page4 = {
  {type = "item", value = "heart_containers"},
  {type = "item", value = "bottles"},
  {type = "item", value = "bottle1"},
  {type = "item", value = "bottle2"},
  {type = "item", value = "bottle3"},
  {type = "item", value = "bottle4"},
}
local page5 = {
  {type = "action", value = "fill_rupees"},
  {type = "action", value = "fill_arrows"},
  {type = "action", value = "fill_bombs"},
  {type = "action", value = "fill_magic"},
  {type = "action", value = "fill_health"},
  {type = "item", value = "infinite_arrows"},
  {type = "item", value = "infinite_bombs"},
  {type = "item", value = "infinite_magic"},
  {type = "item", value = "ice_physics"},
  {type = "item", value = "cucco_storm"},
}

local pages = {
  page1,
  page2,
  page3,
  page4,
  page5,
}

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

local delay = 30
local rep = 10

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

function Menu:update_buttons()
  local btns = self.input.get_inputs()
  for k, v in pairs(btns) do
    if v then
      self.btns[k] = self.btns[k] + 1
    else
      self.btns[k] = 0
    end
  end
end

function Menu:check_menu()
  return self.btns.l > 0 and self.btns.r > 0
      and (self.btns.l == 1 or self.btns.r == 1)
end

function Menu:frame()
  self:update_buttons()
  if self:check_menu() then
    if self.menu then
      self.menu = false
    else
      local state = self.mem.read_wram_word(0x0010)
      if state ~= 0x0007 and state ~= 0x0009 and state ~= 0x000a and state ~= 0x010E then
        return
      end
      self.mem.write_wram_word(0x0010, 0x010E)
      self.menu = true
      self.menuindex = 1
      self.menuselected = false
    end
    self:clear_input()
    return
  end

  if self.menu then
    if self.menuselected then
      local entry = pages[self.pagenum][self.menuindex]
      if self.btns.a == 1 or self.btns.b == 1 then
        self.menuselected = false
      elseif self.btns.right == 1 then
        if entry.type == "item" then
          local item = self.data[entry.value]
          local itemindex = item.get()
          itemindex = itemindex + 1
          if itemindex >= #item.values then
            itemindex = 0
          end
          item.set(itemindex)
        end
      elseif self.btns.left == 1 then
        if entry.type == "item" then
          local item = self.data[entry.value]
          local itemindex = item.get()
          itemindex = itemindex - 1
          if itemindex < 0 then
            itemindex = #item.values - 1
          end
          item.set(itemindex)
        end
      end
    else
      local entry = pages[self.pagenum][self.menuindex]
      if self.btns.a == 1 then
        local data = self.data[entry.value]
        if not data.condition or data.condition() then
          if entry.type == "item" then
            self.menuselected = true
          elseif entry.type == "action" then
            data.action()
          end
        end
      elseif self.btns.r == 1 then
        self.pagenum = self.pagenum + 1
        if self.pagenum > #pages then
          self.pagenum = 1
        end
        self.menuindex = 1
      elseif self.btns.l == 1 then
        self.pagenum = self.pagenum - 1
        if self.pagenum <= 0 then
          self.pagenum = #pages
        end
        self.menuindex = 1
      elseif get_repeat(self.btns.down) then
        self.menuindex = self.menuindex + 1
        if self.menuindex > #pages[self.pagenum] then
          self.menuindex = 1
        end
      elseif get_repeat(self.btns.up) then
        self.menuindex = self.menuindex - 1
        if self.menuindex <= 0 then
          self.menuindex = #pages[self.pagenum]
        end
      end
    end

    self.gfx.draw_rect(30, 40, 196, 164, 0xA0000000, true)
    self.gfx.draw_rect(30, 40, 196, 164, 0xFFFFFFFF, false)
    self.gfx.draw_left_arrow(46, 55, 0xFFFFFFFF)
    self.gfx.draw_string(51, 52, "L")
    self.gfx.draw_string(115, 52, self.pagenum .. "/" .. #pages)
    self.gfx.draw_string(200, 52, "R")
    self.gfx.draw_right_arrow(209, 55, 0xFFFFFFFF)
    local y = 75
    for i, v in ipairs(pages[self.pagenum]) do
      local data = self.data[v.value]
      local skip = data.condition and not data.condition()
      local color = 0xFFFFFFFF
      if skip then
        color = 0xFF999999
      end
      if i == self.menuindex then
        self.gfx.draw_right_arrow(35, y + 3, color)
        if self.menuselected then
          self.gfx.draw_left_arrow(147, y + 3, color)
          self.gfx.draw_right_arrow(213, y + 3, color)
        end
      end
      if v.type == "item" then
        local item = self.data[v.value]
        self.gfx.draw_string(43, y, item.name, color)
        if not skip then
          self.gfx.draw_string(150, y, tostring(item.values[item.get() + 1]):upper(), color)
        end
      elseif v.type == "action" then
        local action = self.data[v.value]
        self.gfx.draw_string(43, y, action.name, color)
      end
      y = y + 12
    end
  end

  if self.menu then
    self:clear_input()
  end
end

function Menu:clear_input()
  self.mem.write_wram(0x00f0, 0x00)
  self.mem.write_wram(0x00f2, 0x00)
  self.mem.write_wram(0x00f4, 0x00)
  self.mem.write_wram(0x00f6, 0x00)
  self.mem.write_wram(0x00f8, 0x00)
  self.mem.write_wram(0x00fa, 0x00)
end

return function(gfx, items, input, mem)
  return Menu:new(gfx, items, input, mem)
end
