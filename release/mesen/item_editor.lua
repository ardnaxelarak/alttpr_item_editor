
---------------------------------------------------------
----------------Auto generated code block----------------
---------------------------------------------------------

do
    local searchers = package.searchers or package.loaders
    local origin_seacher = searchers[2]
    searchers[2] = function(path)
        local files =
        {
------------------------
-- Modules part begin --
------------------------

["mesen.bit_wrapper"] = function()
--------------------
-- Module: 'mesen.bit_wrapper'
--------------------
local bit = {}

function bit.bor(a, b)
  return a | b
end

function bit.band(a, b)
  return a & b
end

function bit.bnot(a)
  return ~a
end

function bit.lshift(a, b)
  return a << b
end

function bit.rshift(a, b)
  return a >> b
end

return bit

end,

["mesen.graphics"] = function()
--------------------
-- Module: 'mesen.graphics'
--------------------
local graphics = {}

local transparent = 0xFF000000

local function convert_color(input)
  local alpha = input >> 24
  alpha = 0xFF - alpha
  return (input & 0x00FFFFFF) | (alpha << 24)
end

function graphics.draw_string(x, y, text, color)
  local c = color or 0xFFFFFFFF
  emu.drawString(x, y, text, convert_color(c), transparent)
end

function graphics.draw_rect(x, y, width, height, color, filled)
  emu.drawRectangle(x, y, width, height, convert_color(color), filled)
end

function graphics.draw_left_arrow(x, y, color)
  emu.drawLine(x, y - 3, x - 3, y, convert_color(color))
  emu.drawLine(x - 3, y, x, y + 3, convert_color(color))
  emu.drawLine(x, y + 3, x, y - 3, convert_color(color))
end

function graphics.draw_right_arrow(x, y, color)
  emu.drawLine(x, y - 3, x + 3, y, convert_color(color))
  emu.drawLine(x + 3, y, x, y + 3, convert_color(color))
  emu.drawLine(x, y + 3, x, y - 3, convert_color(color))
end

function graphics.clear()
  emu.clearScreen()
end

return graphics

end,

["mesen.memory"] = function()
--------------------
-- Module: 'mesen.memory'
--------------------
local memory = {}

function memory.read_wram(address)
  return emu.read(address, emu.memType.workRam)
end

function memory.read_wram_word(address)
  return emu.readWord(address, emu.memType.workRam)
end

function memory.read_rom(address)
  return emu.read(address, emu.memType.prgRom)
end

function memory.write_wram(address, value)
  return emu.write(address, value, emu.memType.workRam)
end

function memory.write_wram_word(address, value)
  return emu.writeWord(address, value, emu.memType.workRam)
end

return memory

end,

["mesen.controller"] = function()
--------------------
-- Module: 'mesen.controller'
--------------------
local controller = {}

function controller.get_inputs()
  local mem1 = emu.read(0xF0, emu.memType.workRam)
  local mem2 = emu.read(0xF2, emu.memType.workRam)
  return {
    a = mem2 & 0x80 > 0,
    x = mem2 & 0x40 > 0,
    l = mem2 & 0x20 > 0,
    r = mem2 & 0x10 > 0,
    b = mem1 & 0x80 > 0,
    y = mem1 & 0x40 > 0,
    start = mem1 & 0x10 > 0,
    select = mem1 & 0x20 > 0,
    up = mem1 & 0x08 > 0,
    down = mem1 & 0x04 > 0,
    left = mem1 & 0x02 > 0,
    right = mem1 & 0x01 > 0,
  }
end

return controller

end,

["items"] = function()
--------------------
-- Module: 'items'
--------------------
local Items = {}

local addresses = {
  bomb_max_base = 0x180034,
  arrow_max_base = 0x180035,
  special_weapons = 0x18002f,
  starting_sword = 0x180043,
  game_state = 0x0010,
  indoor_bit = 0x001B,
  equipped = 0x0202,
  current_dungeon = 0x040c,
  skull_woods_entrance = 0xf2c0,
  pyramid = 0xf2db,
  misery_mire_entrance = 0xf2f0,
  turtle_rock_entrance = 0xf2c7,
  bow = 0xf340,
  boomerang = 0xf341,
  hookshot = 0xf342,
  bombs = 0xf343,
  powder = 0xf344,
  firerod = 0xf345,
  icerod = 0xf346,
  bombos = 0xf347,
  ether = 0xf348,
  quake = 0xf349,
  lamp = 0xf34a,
  hammer = 0xf34b,
  flute = 0xf34c,
  net = 0xf34d,
  book = 0xf34e,
  bottles = 0xf34f,
  somaria = 0xf350,
  byrna = 0xf351,
  cape = 0xf352,
  mirror = 0xf353,
  glove = 0xf354,
  boots = 0xf355,
  flippers = 0xf356,
  pearl = 0xf357,
  sword = 0xf359,
  shield = 0xf35a,
  armor = 0xf35b,
  bottle1 = 0xf35c,
  bottle2 = 0xf35d,
  bottle3 = 0xf35e,
  bottle4 = 0xf35f,
  rupee_max = 0xf360,
  rupees = 0xf362,
  compass = 0xf364,
  big_key = 0xf366,
  map = 0xf368,
  health_piece = 0xf36b,
  health_max = 0xf36c,
  health_cur = 0xf36d,
  small_keys = 0xf36f,
  bomb_max_increase = 0xf370,
  arrow_max_increase = 0xf371,
  health_filler = 0xf372,
  magic_filler = 0xf373,
  bomb_filler = 0xf375,
  arrow_filler = 0xf376,
  arrows = 0xf377,
  abilities = 0xf379,
  magic_usage = 0xf37b,
  swap1 = 0xf38c,
  swap2 = 0xf38e,
  weapon_upgrades = 0xf38f,
  chapter = 0xf3c5,
  timer = 0xf43e,
  cucco_storm = 0x150c5,
  ice_physics = 0x150c7,
  infinite_arrows = 0x150c8,
  infinite_bombs = 0x150c9,
  infinite_magic = 0x150ca,
  ohko = 0x150cc,
}

local bottle_addresses = {
  addresses.bottle1,
  addresses.bottle2,
  addresses.bottle3,
  addresses.bottle4,
}

function Items:new(mem, bit)
  o = {}
  setmetatable(o, self)
  self.__index = self
  self.mem = mem
  self.bit = bit
  return o
end

function Items:is_indoors()
  return self.mem.read_wram(addresses.indoor_bit) == 1
end

function Items:set_health(value)
  self.mem.write_wram(addresses.health_cur, value)
end

function Items:get_health()
  return self.mem.read_wram(addresses.health_cur)
end

function Items:set_health_max(value)
  self.mem.write_wram(addresses.health_max, value)
end

function Items:get_health_max()
  return self.mem.read_wram(addresses.health_max)
end

function Items:fill_health()
  self.mem.write_wram(addresses.health_filler, self:get_health_max())
end

function Items:set_heart_containers(value)
  local new_max = self.bit.lshift(value + 3, 3)
  local current_max = self:get_health_max()
  local current = self:get_health()
  if new_max > current_max then
    self:set_health_max(new_max)
    self:set_health(current + new_max - current_max)
  else
    self:set_health(math.min(current, new_max))
    self:set_health_max(new_max)
  end
end

function Items:get_heart_containers()
  return self.bit.rshift(self:get_health_max(), 3) - 3
end

function Items:get_arrow_max()
  return self.mem.read_rom(addresses.arrow_max_base)
      + self.mem.read_wram(addresses.arrow_max_increase)
end

function Items:set_arrows(value)
  self.mem.write_wram(addresses.arrows, value)
end

function Items:get_arrows()
  return self.mem.read_wram(addresses.arrows)
end

function Items:fill_arrows()
  self.mem.write_wram(addresses.arrow_filler, self:get_arrow_max())
end

function Items:get_bomb_max()
  return self.mem.read_rom(addresses.bomb_max_base)
      + self.mem.read_wram(addresses.bomb_max_increase)
end

function Items:set_bombs(value)
  self.mem.write_wram(addresses.bombs, value)
end

function Items:get_bombs()
  return self.mem.read_wram(addresses.bombs)
end

function Items:fill_bombs()
  self.mem.write_wram(addresses.bomb_filler, self:get_bomb_max())
end

function Items:set_rupees(value)
  self.mem.write_wram_word(addresses.rupees, value)
end

function Items:get_rupees()
  return self.mem.read_wram_word(addresses.rupees)
end

function Items:set_rupee_max(value)
  self.mem.write_wram_word(addresses.rupee_max, value)
end

function Items:get_rupee_max()
  return self.mem.read_wram_word(addresses.rupee_max)
end

function Items:fill_rupees()
  self:set_rupee_max(999)
end

function Items:fill_magic()
  self.mem.write_wram(addresses.magic_filler, 128)
end

function Items:set_typical(address, value, max)
  max = max or 1
  if value > max or value < 0 then
    value = 0
  end
  self.mem.write_wram(address, value)
end

function Items:get_typical(address, max, default)
  max = max or 1
  default = default or 0
  value = self.mem.read_wram(address)
  if value > max or value < 0 then
    return default
  else
    return value
  end
end

function Items:set_bitwise(address, bitmask, value)
  local byte = self.mem.read_wram(address)

  if value >= 1 then
    byte = self.bit.bor(byte, bitmask)
  else
    byte = self.bit.band(byte, self.bit.bnot(bitmask))
  end

  self.mem.write_wram(address, byte)
end

function Items:get_bitwise(address, bitmask)
  local byte = self.mem.read_wram(address)
  if self.bit.band(byte, bitmask) > 0 then
    return 1
  else
    return 0
  end
end

function Items:set_dungeon_item(address, value)
  local dungeon = self:get_dungeon()
  if dungeon < 2 then
    return 0
  end

  local bit = 16 - dungeon
  local bitmask = self.bit.lshift(1, bit)

  local word = self.mem.read_wram_word(address)

  if value >= 1 then
    word = self.bit.bor(word, bitmask)
  else
    word = self.bit.band(word, self.bit.bnot(bitmask))
  end

  self.mem.write_wram_word(address, word)
end

function Items:get_dungeon_item(address)
  local dungeon = self:get_dungeon()
  if dungeon < 2 then
    return
  end

  local bit = 16 - dungeon
  local bitmask = self.bit.lshift(1, bit)

  local word = self.mem.read_wram_word(address)
  if self.bit.band(word, bitmask) > 0 then
    return 1
  else
    return 0
  end
end

function Items:set_bow(value)
  local arrows = self:get_arrows() > 0
  local towrite = 0
  if value == 1 then
    if arrows then
      towrite = 2
    else
      towrite = 1
    end
  elseif value == 2 then
    if arrows then
      towrite = 4
    else
      towrite = 3
    end
  end
  self.mem.write_wram(addresses.bow, towrite)

  local swap = self.mem.read_wram(addresses.swap2)

  swap = self.bit.band(swap, self.bit.bnot(192))
  if value >= 1 then
    swap = self.bit.bor(swap, 128)
  end
  if value >= 2 then
    swap = self.bit.bor(swap, 64)
  end

  self.mem.write_wram(addresses.swap2, swap)
end

function Items:get_bow()
  local value = self.mem.read_wram(addresses.bow)
  if value == 1 or value == 2 then
    return 1
  elseif value == 3 or value == 4 then
    return 2
  else
    return 0
  end
end

function Items:set_boomerang(value)
  local swap = self.mem.read_wram(addresses.swap1)
  local blue = self.bit.band(value, 1) > 0
  local red = self.bit.band(value, 2) > 0

  swap = self.bit.band(swap, self.bit.bnot(192))
  if blue then
    swap = self.bit.bor(swap, 128)
  end
  if red then
    swap = self.bit.bor(swap, 64)
  end

  self.mem.write_wram(addresses.swap1, swap)

  local bslot = self.mem.read_wram(addresses.boomerang)
  if bslot == 1 then
    if value == 0 then
      self.mem.write_wram(addresses.boomerang, 0)
    elseif value == 2 then
      self.mem.write_wram(addresses.boomerang, 2)
    end
  elseif bslot == 2 then
    if value == 0 then
      self.mem.write_wram(addresses.boomerang, 0)
    elseif value == 1 then
      self.mem.write_wram(addresses.boomerang, 1)
    end
  else
    if value == 1 then
      self.mem.write_wram(addresses.boomerang, 1)
    elseif value == 2 or value == 3 then
      self.mem.write_wram(addresses.boomerang, 2)
    end
  end
end

function Items:get_boomerang()
  local swap = self.mem.read_wram(addresses.swap1)
  local blue = self.bit.band(swap, 128) > 0
  local red = self.bit.band(swap, 64) > 0
  if blue and red then
    return 3
  elseif red then
    return 2
  elseif blue then
    return 1
  else
    return 0
  end
end

function Items:set_hookshot(value)
  self:set_typical(addresses.hookshot, value)
end

function Items:get_hookshot()
  return self:get_typical(addresses.hookshot)
end

function Items:set_mushroom(value)
  local swap = self.mem.read_wram(addresses.swap1)

  swap = self.bit.band(swap, self.bit.bnot(32))
  if value == 1 then
    swap = self.bit.bor(swap, 32)
  end

  self.mem.write_wram(addresses.swap1, swap)

  local slot = self.mem.read_wram(addresses.powder)
  if value == 1 and slot ~= 1 then
    self.mem.write_wram(addresses.powder, 1)
  elseif value == 0 and slot == 1 then
    if self.bit.band(swap, 16) > 0 then -- have powder
      self.mem.write_wram(addresses.powder, 2)
    else -- no powder
      self.mem.write_wram(addresses.powder, 0)
    end
  end
end

function Items:get_mushroom()
  local swap = self.mem.read_wram(addresses.swap1)
  local mushroom = self.bit.band(swap, 32) > 0
  if mushroom then
    return 1
  else
    return 0
  end
end

function Items:set_powder(value)
  local swap = self.mem.read_wram(addresses.swap1)

  swap = self.bit.band(swap, self.bit.bnot(16))
  if value == 1 then
    swap = self.bit.bor(swap, 16)
  end

  self.mem.write_wram(addresses.swap1, swap)

  local slot = self.mem.read_wram(addresses.powder)
  if value == 1 and slot ~= 2 then
    self.mem.write_wram(addresses.powder, 2)
  elseif value == 0 and slot == 2 then
    if self.bit.band(swap, 32) > 0 then -- have mushroom
      self.mem.write_wram(addresses.powder, 1)
    else -- no powder
      self.mem.write_wram(addresses.powder, 0)
    end
  end
end

function Items:get_powder()
  local swap = self.mem.read_wram(addresses.swap1)
  local powder = self.bit.band(swap, 16) > 0
  if powder then
    return 1
  else
    return 0
  end
end

function Items:set_firerod(value)
  self:set_typical(addresses.firerod, value)
end

function Items:get_firerod()
  return self:get_typical(addresses.firerod)
end

function Items:set_icerod(value)
  self:set_typical(addresses.icerod, value)
end

function Items:get_icerod()
  return self:get_typical(addresses.icerod)
end

function Items:set_bombos(value)
  self:set_typical(addresses.bombos, value)
end

function Items:get_bombos()
  return self:get_typical(addresses.bombos)
end

function Items:set_ether(value)
  self:set_typical(addresses.ether, value)
end

function Items:get_ether()
  return self:get_typical(addresses.ether)
end

function Items:set_quake(value)
  self:set_typical(addresses.quake, value)
end

function Items:get_quake()
  return self:get_typical(addresses.quake)
end

function Items:set_lamp(value)
  self:set_typical(addresses.lamp, value)
end

function Items:get_lamp()
  return self:get_typical(addresses.lamp)
end

function Items:set_hammer(value)
  self:set_typical(addresses.hammer, value)
end

function Items:get_hammer()
  return self:get_typical(addresses.hammer)
end

function Items:set_shovel(value)
  local swap = self.mem.read_wram(addresses.swap1)

  swap = self.bit.band(swap, self.bit.bnot(4))
  if value == 1 then
    swap = self.bit.bor(swap, 4)
  end

  self.mem.write_wram(addresses.swap1, swap)

  local slot = self.mem.read_wram(addresses.flute)
  if value == 1 and slot ~= 1 then
    self.mem.write_wram(addresses.flute, 1)
  elseif value == 0 and slot == 1 then
    if self.bit.band(swap, 1) > 0 then
      self.mem.write_wram(addresses.flute, 3)
    elseif self.bit.band(swap, 2) > 2 then
      self.mem.write_wram(addresses.flute, 2)
    else
      self.mem.write_wram(addresses.flute, 0)
    end
  end
end

function Items:get_shovel()
  local swap = self.mem.read_wram(addresses.swap1)
  local shovel = self.bit.band(swap, 4) > 0
  if shovel then
    return 1
  else
    return 0
  end
end

function Items:set_flute(value)
  local swap = self.mem.read_wram(addresses.swap1)

  swap = self.bit.band(swap, self.bit.bnot(3))
  if value == 2 then
    swap = self.bit.bor(swap, 1)
  elseif value == 1 then
    swap = self.bit.bor(swap, 2)
  end

  self.mem.write_wram(addresses.swap1, swap)

  local slot = self.mem.read_wram(addresses.flute)
  if value == 1 and slot ~= 2 then -- fake flute
    self.mem.write_wram(addresses.flute, 2)
  elseif value == 2 and slot ~= 3 then -- active flute
    self.mem.write_wram(addresses.flute, 3)
  elseif value == 0 then
    if slot == 2 or slot == 3 then
      if self.bit.band(swap, 4) > 0 then -- have shovel
        self.mem.write_wram(addresses.flute, 1)
      else -- no shovel
        self.mem.write_wram(addresses.flute, 0)
      end
    end
  end
end

function Items:get_flute()
  local swap = self.mem.read_wram(addresses.swap1)
  local flute = self.bit.band(swap, 1) > 0
  local fakeflute = self.bit.band(swap, 2) > 0
  if flute then
    return 2
  elseif fakeflute then
    return 1
  else
    return 0
  end
end

function Items:set_net(value)
  self:set_typical(addresses.net, value)
end

function Items:get_net()
  return self:get_typical(addresses.net)
end

function Items:set_book(value)
  self:set_typical(addresses.book, value)
end

function Items:get_book()
  return self:get_typical(addresses.book)
end

function Items:set_somaria(value)
  self:set_typical(addresses.somaria, value)
end

function Items:get_somaria()
  return self:get_typical(addresses.somaria)
end

function Items:set_byrna(value)
  self:set_typical(addresses.byrna, value)
end

function Items:get_byrna()
  return self:get_typical(addresses.byrna)
end

function Items:set_cape(value)
  self:set_typical(addresses.cape, value)
end

function Items:get_cape()
  return self:get_typical(addresses.cape)
end

function Items:set_mirror(value)
  if value == 1 then
    self.mem.write_wram(addresses.mirror, 2)
  else
    self.mem.write_wram(addresses.mirror, 0)
  end
end

function Items:get_mirror()
  value = self.mem.read_wram(addresses.mirror)
  if value == 2 then
    return 1
  else
    return 0
  end
end

function Items:set_boots(value)
  local abilities = self.mem.read_wram(addresses.abilities)
  if value == 1 then
    self.mem.write_wram(addresses.boots, 1)
    abilities = self.bit.bor(abilities, 4)
  else
    self.mem.write_wram(addresses.boots, 0)
    abilities = self.bit.band(abilities, self.bit.bnot(4))
  end
  self.mem.write_wram(addresses.abilities, abilities)
end

function Items:get_boots()
  return self:get_typical(addresses.boots)
end

function Items:set_glove(value)
  self:set_typical(addresses.glove, value, 2)
end

function Items:get_glove()
  return self:get_typical(addresses.glove, 2)
end

function Items:set_flippers(value)
  local abilities = self.mem.read_wram(addresses.abilities)
  if value == 1 then
    self.mem.write_wram(addresses.flippers, 1)
    abilities = self.bit.bor(abilities, 2)
  else
    self.mem.write_wram(addresses.flippers, 0)
    abilities = self.bit.band(abilities, self.bit.bnot(2))
  end
  self.mem.write_wram(addresses.abilities, abilities)
end

function Items:get_flippers()
  return self:get_typical(addresses.flippers)
end

function Items:set_pearl(value)
  self:set_typical(addresses.pearl, value)
end

function Items:get_pearl()
  return self:get_typical(addresses.pearl)
end

function Items:set_sword(value)
  self:set_typical(addresses.sword, value, 4)
end

function Items:get_sword()
  return self:get_typical(addresses.sword, 4)
end

function Items:get_swordless()
  return self.mem.read_rom(addresses.starting_sword) == 0xFF
end

function Items:set_weapon_upgrades(value)
  self:set_typical(addresses.weapon_upgrades, value, 5)
end

function Items:get_weapon_upgrades()
  return self:get_typical(addresses.weapon_upgrades, 5)
end

function Items:get_special_weapons()
  spw = self.mem.read_rom(addresses.special_weapons)
  return spw == 1 or spw == 3 or spw == 4 or spw == 5 or spw == 8
end

function Items:set_shield(value)
  self:set_typical(addresses.shield, value, 3)
end

function Items:get_shield()
  return self:get_typical(addresses.shield, 3)
end

function Items:set_armor(value)
  self:set_typical(addresses.armor, value, 2)
end

function Items:get_armor()
  return self:get_typical(addresses.armor, 2)
end

function Items:set_magic_usage(value)
  self:set_typical(addresses.magic_usage, value, 2)
end

function Items:get_magic_usage()
  return self:get_typical(addresses.magic_usage, 2)
end

function Items:set_bottle(address, value)
  local towrite = 2
  if value >= 0 and value <= 6 then
    towrite = value + 2
  end
  self.mem.write_wram(address, towrite)
end

function Items:get_bottle(address)
  value = self.mem.read_wram(address)
  if value >= 2 and value <= 8 then
    return value - 2
  else
    return 0
  end
end

function Items:set_bottle1(value)
  self:set_bottle(addresses.bottle1, value)
end

function Items:get_bottle1()
  return self:get_bottle(addresses.bottle1)
end

function Items:set_bottle2(value)
  self:set_bottle(addresses.bottle2, value)
end

function Items:get_bottle2()
  return self:get_bottle(addresses.bottle2)
end

function Items:set_bottle3(value)
  self:set_bottle(addresses.bottle3, value)
end

function Items:get_bottle3()
  return self:get_bottle(addresses.bottle3)
end

function Items:set_bottle4(value)
  self:set_bottle(addresses.bottle4, value)
end

function Items:get_bottle4()
  return self:get_bottle(addresses.bottle4)
end

function Items:get_bottles()
  local count = 0
  for i = 1, 4 do
    if self.mem.read_wram(bottle_addresses[i]) == 0 then
      return count
    end
    count = count + 1
  end
  return count
end

function Items:set_bottles(value)
  local old_bottles = self:get_bottles()
  if old_bottles > value then
    for i = value + 1, old_bottles do
      self.mem.write_wram(bottle_addresses[i], 0)
    end
  elseif old_bottles < value then
    for i = old_bottles + 1, value do
      self.mem.write_wram(bottle_addresses[i], 2)
    end
  end

  local bslot = self.mem.read_wram(addresses.bottles)
  if bslot > value then
    self.mem.write_wram(addresses.bottles, value)
  end
  if bslot == 0 and value > 0 then
    self.mem.write_wram(addresses.bottles, 1)
  end
end

function Items:set_infinite_arrows(value)
  self:set_typical(addresses.infinite_arrows, value)
end

function Items:get_infinite_arrows()
  return self:get_typical(addresses.infinite_arrows, 1, 1)
end

function Items:set_infinite_bombs(value)
  self:set_typical(addresses.infinite_bombs, value)
end

function Items:get_infinite_bombs()
  return self:get_typical(addresses.infinite_bombs, 1, 1)
end

function Items:set_infinite_magic(value)
  self:set_typical(addresses.infinite_magic, value)
end

function Items:get_infinite_magic()
  return self:get_typical(addresses.infinite_magic, 1, 1)
end

function Items:set_ice_physics(value)
  if value == 1 then
    self.mem.write_wram(addresses.ice_physics, 0x11)
  else
    self.mem.write_wram(addresses.ice_physics, 0x00)
  end
end

function Items:get_ice_physics()
  value = self.mem.read_wram(addresses.ice_physics)
  if value == 0x11 then
    return 1
  else
    return 0
  end
end

function Items:set_cucco_storm(value)
  self:set_typical(addresses.cucco_storm, value)
end

function Items:get_cucco_storm()
  return self:get_typical(addresses.cucco_storm, 1, 1)
end

function Items:set_ohko(value)
  self:set_typical(addresses.cucco_storm, value)
end

function Items:get_ohko()
  return self:get_typical(addresses.ohko, 1, 1)
end

function sequence(from, to)
  ret = {}
  for i = from, to do
    table.insert(ret, i)
  end
  return ret
end

function Items:get_dungeon()
  if not self:is_indoors() then
    return 0
  end
  value = self.mem.read_wram(addresses.current_dungeon)
  if value == 0xFF then
    return 1
  elseif value == 0x00 then
    return 2
  elseif value <= 0x1A then
    return self.bit.rshift(value, 1) + 1
  else
    return 1 -- idk, assume we're in cave state probably
  end
end

function Items:get_data()
  return {
    bow = {
        name = "Bow",
        get = function() return self:get_bow() end,
        set = function(value) self:set_bow(value) end,
        values = {"none", "regular", "silver"}},
    boomerang = {
        name = "Boomerang",
        get = function() return self:get_boomerang() end,
        set = function(value) return self:set_boomerang(value) end,
        values = {"none", "blue", "red", "both"}},
    hookshot = {
        name = "Hookshot",
        get = function() return self:get_hookshot() end,
        set = function(value) self:set_hookshot(value) end,
        values = {false, true}},
    mushroom = {
        name = "Mushroom",
        get = function() return self:get_mushroom() end,
        set = function(value) self:set_mushroom(value) end,
        values = {false, true}},
    powder = {
        name = "Magic Powder",
        get = function() return self:get_powder() end,
        set = function(value) self:set_powder(value) end,
        values = {false, true}},
    firerod = {
        name = "Fire Rod",
        get = function() return self:get_firerod() end,
        set = function(value) self:set_firerod(value) end,
        values = {false, true}},
    icerod = {
        name = "Ice Rod",
        get = function() return self:get_icerod() end,
        set = function(value) self:set_icerod(value) end,
        values = {false, true}},
    bombos = {
        name = "Bombos Medallion",
        get = function() return self:get_bombos() end,
        set = function(value) self:set_bombos(value) end,
        values = {false, true}},
    ether = {
        name = "Ether Medallion",
        get = function() return self:get_ether() end,
        set = function(value) self:set_ether(value) end,
        values = {false, true}},
    quake = {
        name = "Quake Medallion",
        get = function() return self:get_quake() end,
        set = function(value) self:set_quake(value) end,
        values = {false, true}},
    lamp = {
        name = "Lamp",
        get = function() return self:get_lamp() end,
        set = function(value) self:set_lamp(value) end,
        values = {false, true}},
    hammer = {
        name = "Magic Hammer",
        get = function() return self:get_hammer() end,
        set = function(value) self:set_hammer(value) end,
        values = {false, true}},
    shovel = {
        name = "Shovel",
        get = function() return self:get_shovel() end,
        set = function(value) self:set_shovel(value) end,
        values = {false, true}},
    flute = {
        name = "Flute",
        get = function() return self:get_flute() end,
        set = function(value) self:set_flute(value) end,
        values = {"none", "inactive", "active"}},
    net = {
        name = "Bug-Catching Net",
        get = function() return self:get_net() end,
        set = function(value) self:set_net(value) end,
        values = {false, true}},
    book = {
        name = "Book of Mudora",
        get = function() return self:get_book() end,
        set = function(value) self:set_book(value) end,
        values = {false, true}},
    somaria = {
        name = "Cane of Somaria",
        get = function() return self:get_somaria() end,
        set = function(value) self:set_somaria(value) end,
        values = {false, true}},
    byrna = {
        name = "Cane of Byrna",
        get = function() return self:get_byrna() end,
        set = function(value) self:set_byrna(value) end,
        values = {false, true}},
    cape = {
        name = "Magic Cape",
        get = function() return self:get_cape() end,
        set = function(value) self:set_cape(value) end,
        values = {false, true}},
    mirror = {
        name = "Magic Mirror",
        get = function() return self:get_mirror() end,
        set = function(value) self:set_mirror(value) end,
        values = {false, true}},
    boots = {
        name = "Pegasus Boots",
        get = function() return self:get_boots() end,
        set = function(value) self:set_boots(value) end,
        values = {false, true}},
    glove = {
        name = "Power Glove",
        get = function() return self:get_glove() end,
        set = function(value) self:set_glove(value) end,
        values = {"none", "glove", "mitt"}},
    flippers = {
        name = "Flippers",
        get = function() return self:get_flippers() end,
        set = function(value) self:set_flippers(value) end,
        values = {false, true}},
    pearl = {
        name = "Moon Pearl",
        get = function() return self:get_pearl() end,
        set = function(value) self:set_pearl(value) end,
        values = {false, true}},
    sword = {
        name = "Sword",
        get = function() return self:get_sword() end,
        set = function(value) self:set_sword(value) end,
        condition = function() return not self:get_swordless() and not self:get_special_weapons() end,
        values = {"none", "fighter", "master", "tempered", "golden"}},
    shield = {
        name = "Shield",
        get = function() return self:get_shield() end,
        set = function(value) self:set_shield(value) end,
        values = {"none", "blue", "red", "mirror"}},
    armor = {
        name = "Armor",
        get = function() return self:get_armor() end,
        set = function(value) self:set_armor(value) end,
        values = {"green", "blue", "red"}},
    magic_usage = {
        name = "Magic Usage",
        get = function() return self:get_magic_usage() end,
        set = function(value) self:set_magic_usage(value) end,
        values = {"standard", "1/2", "1/4"}},
    weapon_upgrades = {
        name = "Weapon Upgrades",
        get = function() return self:get_weapon_upgrades() end,
        set = function(value) self:set_weapon_upgrades(value) end,
        condition = function() return self:get_special_weapons() end,
        values = {"none", "L1", "L2", "L3", "L4", "L5"}},
    heart_containers = {
        name = "Heart Containers",
        get = function() return self:get_heart_containers() end,
        set = function(value) self:set_heart_containers(value) end,
        values = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}},
    bottles = {
        name = "Bottles",
        get = function() return self:get_bottles() end,
        set = function(value) self:set_bottles(value) end,
        values = {0, 1, 2, 3, 4}},
    bottle1 = {
        name = "Bottle 1",
        condition = function() return self:get_bottles() >= 1 end,
        get = function() return self:get_bottle1() end,
        set = function(value) self:set_bottle1(value) end,
        values = {"Empty", "Red", "Green", "Blue", "Fairy", "Bee", "Golden Bee"}},
    bottle2 = {
        name = "Bottle 2",
        condition = function() return self:get_bottles() >= 2 end,
        get = function() return self:get_bottle2() end,
        set = function(value) self:set_bottle2(value) end,
        values = {"Empty", "Red", "Green", "Blue", "Fairy", "Bee", "Golden Bee"}},
    bottle3 = {
        name = "Bottle 3",
        condition = function() return self:get_bottles() >= 3 end,
        get = function() return self:get_bottle3() end,
        set = function(value) self:set_bottle3(value) end,
        values = {"Empty", "Red", "Green", "Blue", "Fairy", "Bee", "Golden Bee"}},
    bottle4 = {
        name = "Bottle 4",
        condition = function() return self:get_bottles() >= 4 end,
        get = function() return self:get_bottle4() end,
        set = function(value) self:set_bottle4(value) end,
        values = {"Empty", "Red", "Green", "Blue", "Fairy", "Bee", "Golden Bee"}},
    ice_physics = {
        name = "Ice Physics",
        get = function() return self:get_ice_physics() end,
        set = function(value) self:set_ice_physics(value) end,
        values = {false, true}},
    cucco_storm = {
        name = "Cucco Storm",
        get = function() return self:get_cucco_storm() end,
        set = function(value) self:set_cucco_storm(value) end,
        values = {false, true}},
    infinite_arrows = {
        name = "Infinite Arrows",
        get = function() return self:get_infinite_arrows() end,
        set = function(value) self:set_infinite_arrows(value) end,
        values = {false, true}},
    infinite_bombs = {
        name = "Infinite Bombs",
        get = function() return self:get_infinite_bombs() end,
        set = function(value) self:set_infinite_bombs(value) end,
        values = {false, true}},
    infinite_magic = {
        name = "Infinite Magic",
        get = function() return self:get_infinite_magic() end,
        set = function(value) self:set_infinite_magic(value) end,
        values = {false, true}},
    fill_rupees = {
        name = "999 Rupees",
        action = function() self:fill_rupees() end},
    fill_arrows = {
        name = "Fill Arrows",
        action = function() self:fill_arrows() end},
    fill_bombs = {
        name = "Fill Bombs",
        action = function() self:fill_bombs() end},
    fill_magic = {
        name = "Fill Magic",
        action = function() self:fill_magic() end},
    fill_health = {
        name = "Fill Health",
        action = function() self:fill_health() end},
    chapter = {
        name = "Game State",
        get = function() return self:get_typical(addresses.chapter, 3) end,
        set = function(value) self:set_typical(addresses.chapter, value, 3) end,
        values = {"Start", "Uncle", "Zelda", "Agahnim"}},
    pyramid_hole = {
        name = "Pyramid Hole",
        get = function() return self:get_bitwise(addresses.pyramid, 0x20) end,
        set = function(value) self:set_bitwise(addresses.pyramid, 0x20, value) end,
        values = {"Closed", "Open"}},
    pyramid_fairy_entrance = {
        name = "Pyramid Fairy",
        get = function() return self:get_bitwise(addresses.pyramid, 0x02) end,
        set = function(value) self:set_bitwise(addresses.pyramid, 0x02, value) end,
        values = {"Closed", "Open"}},
    skull_woods_entrance = {
        name = "Skull Woods Back",
        get = function() return self:get_bitwise(addresses.skull_woods_entrance, 0x20) end,
        set = function(value) self:set_bitwise(addresses.skull_woods_entrance, 0x20, value) end,
        values = {"Closed", "Open"}},
    misery_mire_entrance = {
        name = "Misery Mire",
        get = function() return self:get_bitwise(addresses.misery_mire_entrance, 0x20) end,
        set = function(value) self:set_bitwise(addresses.misery_mire_entrance, 0x20, value) end,
        values = {"Closed", "Open"}},
    turtle_rock_entrance = {
        name = "Turtle Rock",
        get = function() return self:get_bitwise(addresses.turtle_rock_entrance, 0x20) end,
        set = function(value) self:set_bitwise(addresses.turtle_rock_entrance, 0x20, value) end,
        values = {"Closed", "Open"}},
    current_dungeon = {
        name = "Current Dungeon",
        get = function() return self:get_dungeon() end,
        can_set = function() return false end,
        values = {"Outdoors", "Cave", "H Castle", "Eastern", "Desert", "C Tower", "Swamp", "PoD", "Misery", "Skull", "Ice", "Hera", "Thieves", "Turtle", "G Tower"}},
    current_keys = {
        name = "Current Keys",
        get = function() return self:get_typical(addresses.small_keys, 255) end,
        set = function(value) self:set_typical(addresses.small_keys, value, 255) end,
        condition = function() return self:is_indoors() end,
        values = sequence(0, 255)},
    current_big_key = {
        name = "Big Key",
        get = function() return self:get_dungeon_item(addresses.big_key) end,
        set = function(value) self:set_dungeon_item(addresses.big_key, value) end,
        condition = function() return self:get_dungeon() >= 2 end,
        values = {false, true}},
    current_compass = {
        name = "Compass",
        get = function() return self:get_dungeon_item(addresses.compass) end,
        set = function(value) self:set_dungeon_item(addresses.compass, value) end,
        condition = function() return self:get_dungeon() >= 2 end,
        values = {false, true}},
    current_map = {
        name = "Map",
        get = function() return self:get_dungeon_item(addresses.map) end,
        set = function(value) self:set_dungeon_item(addresses.map, value) end,
        condition = function() return self:get_dungeon() >= 2 end,
        values = {false, true}},
  }
end

return function(mem, bit)
  return Items:new(mem, bit)
end

end,

["menu_drawer"] = function()
--------------------
-- Module: 'menu_drawer'
--------------------
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
  self.sincelastmenu = 100
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
  {type = "item", value = "weapon_upgrades"},
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
local page6 = {
  {type = "item", value = "chapter"},
  {type = "item", value = "skull_woods_entrance"},
  {type = "item", value = "misery_mire_entrance"},
  {type = "item", value = "turtle_rock_entrance"},
  {type = "item", value = "pyramid_fairy_entrance"},
  {type = "item", value = "pyramid_hole"},
}

local dungeonPage = {
  {type = "item", value = "current_dungeon"},
  {type = "item", value = "current_keys"},
  {type = "item", value = "current_map"},
  {type = "item", value = "current_compass"},
  {type = "item", value = "current_big_key"},
}

local pages = {
  page1,
  page2,
  page3,
  page4,
  page5,
  page6,
  dungeonPage,
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
  self.sincelastmenu = self.sincelastmenu + 1
  if self:check_menu() and self.sincelastmenu > 5 then
    self.sincelastmenu = 0
    if self.menu then
      self.menu = false
      self.gfx.clear()
    else
      local state = self.mem.read_wram_word(0x0010)
      if state ~= 0x0007 and state ~= 0x0009 and state ~= 0x000a and state ~= 0x010E then
        return
      end
      local module = self.mem.read_wram(0x0010)
      if module ~= 0x0E then
        self.mem.write_wram(0x010C, module)
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
          if entry.type == "item" and (data.can_set == nil or data.can_set()) then
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
      local noset = data.can_set and not data.can_set()
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
          if noset then
            color = 0xFF999999
          end
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

end,

----------------------
-- Modules part end --
----------------------
        }
        if files[path] then
            return files[path]
        else
            return origin_seacher(path)
        end
    end
end
---------------------------------------------------------
----------------Auto generated code block----------------
---------------------------------------------------------
local bit = require("mesen.bit_wrapper")
local mem = require("mesen.memory")
local gfx = require("mesen.graphics")
local input = require("mesen.controller")
local items = require("items")(mem, bit)
local menu = require("menu_drawer")(gfx, items, input, mem)

function on_frame()
  menu:frame()
end

emu.addEventCallback(on_frame, emu.eventType.startFrame)