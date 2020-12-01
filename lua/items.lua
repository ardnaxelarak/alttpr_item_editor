local items = {}

local addresses = {
  equipped = 0x7e0202,
  bow = 0x7ef340,
  boomerang = 0x7ef341,
  hookshot = 0x7ef342,
  bombs = 0x7ef343,
  powder = 0x7ef344,
  firerod = 0x7ef345,
  icerod = 0x7ef346,
  bombos = 0x7ef347,
  ether = 0x7ef348,
  quake = 0x7ef349,
  lamp = 0x7ef34a,
  hammer = 0x7ef34b,
  flute = 0x7ef34c,
  net = 0x7ef34d,
  book = 0x7ef34e,
  bottles = 0x7ef34f,
  somaria = 0x7ef350,
  byrna = 0x7ef351,
  cape = 0x7ef352,
  mirror = 0x7ef353,
  glove = 0x7ef354,
  boots = 0x7ef355,
  flippers = 0x7ef356,
  pearl = 0x7ef357,
  sword = 0x7ef359,
  shield = 0x7ef35a,
  armor = 0x7ef35b,
  bottle1 = 0x7ef35c,
  bottle2 = 0x7ef35d,
  bottle3 = 0x7ef35e,
  bottle4 = 0x7ef35f,
  rupees = 0x7ef362,
  healthpiece = 0x7ef36b,
  healthmax = 0x7ef36c,
  healthcur = 0x7ef36d,
  arrows = 0x7ef377,
  abilities = 0x7ef379,
  magic_usage = 0x7ef37b,
  swap1 = 0x7ef38c,
  swap2 = 0x7ef38e,
}

local bottle_addresses = {
  addresses.bottle1,
  addresses.bottle2,
  addresses.bottle3,
  addresses.bottle4,
}

local function set_arrows(value)
  return memory.writebyte(addresses.arrows, value)
end

local function get_arrows()
  return memory.readbyte(addresses.arrows)
end

local function set_bombs(value)
  return memory.writebyte(addresses.bombs, value)
end

local function get_bombs()
  return memory.readbyte(addresses.bombs)
end

local function set_rupees(value)
  memory.write_u16_le(addresses.rupees, value)
end

local function get_rupees()
  return memory.read_u16_le(addresses.rupees)
end

local function set_typical(address, value, max)
  max = max or 1
  if value > max or value < 0 then
    value = 0
  end
  memory.writebyte(address, value)
end

local function get_typical(address, max)
  max = max or 1
  value = memory.readbyte(address)
  if value > max or value < 0 then
    return 0
  else
    return value
  end
end

local function set_bow(value)
  local arrows = get_arrows() > 0
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
  memory.writebyte(addresses.bow, towrite)

  local swap = memory.readbyte(addresses.swap2)

  swap = bit.band(swap, bit.bnot(192))
  if value >= 1 then
    swap = bit.bor(swap, 128)
  end
  if value >= 2 then
    swap = bit.bor(swap, 64)
  end

  memory.writebyte(addresses.swap2, swap)
end

local function get_bow()
  local value = memory.readbyte(addresses.bow)
  if value == 1 or value == 2 then
    return 1
  elseif value == 3 or value == 4 then
    return 2
  else
    return 0
  end
end

local function set_boomerang(value)
  local swap = memory.readbyte(addresses.swap1)
  local blue = bit.band(value, 1) > 0
  local red = bit.band(value, 2) > 0

  swap = bit.band(swap, bit.bnot(192))
  if blue then
    swap = bit.bor(swap, 128)
  end
  if red then
    swap = bit.bor(swap, 64)
  end

  memory.writebyte(addresses.swap1, swap)

  local bslot = memory.readbyte(addresses.boomerang)
  if bslot == 1 then
    if value == 0 then
      memory.writebyte(addresses.boomerang, 0)
    elseif value == 2 then
      memory.writebyte(addresses.boomerang, 2)
    end
  elseif bslot == 2 then
    if value == 0 then
      memory.writebyte(addresses.boomerang, 0)
    elseif value == 1 then
      memory.writebyte(addresses.boomerang, 1)
    end
  else
    if value == 1 then
      memory.writebyte(addresses.boomerang, 1)
    elseif value == 2 or value == 3 then
      memory.writebyte(addresses.boomerang, 2)
    end
  end
end

local function get_boomerang()
  local swap = memory.readbyte(addresses.swap1)
  local blue = bit.band(swap, 128) > 0
  local red = bit.band(swap, 64) > 0
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

local function set_hookshot(value)
  set_typical(addresses.hookshot, value)
end

local function get_hookshot()
  return get_typical(addresses.hookshot)
end

local function set_mushroom(value)
  local swap = memory.readbyte(addresses.swap1)

  swap = bit.band(swap, bit.bnot(32))
  if value == 1 then
    swap = bit.bor(swap, 32)
  end

  memory.writebyte(addresses.swap1, swap)

  local slot = memory.readbyte(addresses.powder)
  if value == 1 and slot ~= 1 then
    memory.writebyte(addresses.powder, 1)
  elseif value == 0 and slot == 1 then
    if bit.band(swap, 16) > 0 then -- have powder
      memory.writebyte(addresses.powder, 2)
    else -- no powder
      memory.writebyte(addresses.powder, 0)
    end
  end
end

local function get_mushroom()
  local swap = memory.readbyte(addresses.swap1)
  local mushroom = bit.band(swap, 32) > 0
  if mushroom then
    return 1
  else
    return 0
  end
end

local function set_powder(value)
  local swap = memory.readbyte(addresses.swap1)

  swap = bit.band(swap, bit.bnot(16))
  if value == 1 then
    swap = bit.bor(swap, 16)
  end

  memory.writebyte(addresses.swap1, swap)

  local slot = memory.readbyte(addresses.powder)
  if value == 1 and slot ~= 2 then
    memory.writebyte(addresses.powder, 2)
  elseif value == 0 and slot == 2 then
    if bit.band(swap, 32) > 0 then -- have mushroom
      memory.writebyte(addresses.powder, 1)
    else -- no powder
      memory.writebyte(addresses.powder, 0)
    end
  end
end

local function get_powder()
  local swap = memory.readbyte(addresses.swap1)
  local powder = bit.band(swap, 16) > 0
  if powder then
    return 1
  else
    return 0
  end
end

local function set_firerod(value)
  set_typical(addresses.firerod, value)
end

local function get_firerod()
  return get_typical(addresses.firerod)
end

local function set_icerod(value)
  set_typical(addresses.icerod, value)
end

local function get_icerod()
  return get_typical(addresses.icerod)
end

local function set_bombos(value)
  set_typical(addresses.bombos, value)
end

local function get_bombos()
  return get_typical(addresses.bombos)
end

local function set_ether(value)
  set_typical(addresses.ether, value)
end

local function get_ether()
  return get_typical(addresses.ether)
end

local function set_quake(value)
  set_typical(addresses.quake, value)
end

local function get_quake()
  return get_typical(addresses.quake)
end

local function set_lamp(value)
  set_typical(addresses.lamp, value)
end

local function get_lamp()
  return get_typical(addresses.lamp)
end

local function set_hammer(value)
  set_typical(addresses.hammer, value)
end

local function get_hammer()
  return get_typical(addresses.hammer)
end

local function set_shovel(value)
  local swap = memory.readbyte(addresses.swap1)

  swap = bit.band(swap, bit.bnot(4))
  if value == 1 then
    swap = bit.bor(swap, 4)
  end

  memory.writebyte(addresses.swap1, swap)

  local slot = memory.readbyte(addresses.flute)
  if value == 1 and slot ~= 1 then
    memory.writebyte(addresses.flute, 1)
  elseif value == 0 and slot == 1 then
    if bit.band(swap, 1) > 0 then
      memory.writebyte(addresses.flute, 3)
    elseif bit.band(swap, 2) > 2 then
      memory.writebyte(addresses.flute, 2)
    else
      memory.writebyte(addresses.flute, 0)
    end
  end
end

local function get_shovel()
  local swap = memory.readbyte(addresses.swap1)
  local shovel = bit.band(swap, 4) > 0
  if shovel then
    return 1
  else
    return 0
  end
end

local function set_flute(value)
  local swap = memory.readbyte(addresses.swap1)

  swap = bit.band(swap, bit.bnot(3))
  if value == 2 then
    swap = bit.bor(swap, 1)
  elseif value == 1 then
    swap = bit.bor(swap, 2)
  end

  memory.writebyte(addresses.swap1, swap)

  local slot = memory.readbyte(addresses.flute)
  if value == 1 and slot ~= 2 then -- fake flute
    memory.writebyte(addresses.flute, 2)
  elseif value == 2 and slot ~= 3 then -- active flute
    memory.writebyte(addresses.flute, 3)
  elseif value == 0 then
    if slot == 2 or slot == 3 then
      if bit.band(swap, 4) > 0 then -- have shovel
        memory.writebyte(addresses.flute, 1)
      else -- no shovel
        memory.writebyte(addresses.flute, 0)
      end
    end
  end
end

local function get_flute()
  local swap = memory.readbyte(addresses.swap1)
  local flute = bit.band(swap, 1) > 0
  local fakeflute = bit.band(swap, 2) > 0
  if flute then
    return 2
  elseif fakeflute then
    return 1
  else
    return 0
  end
end

local function set_net(value)
  set_typical(addresses.net, value)
end

local function get_net()
  return get_typical(addresses.net)
end

local function set_book(value)
  set_typical(addresses.book, value)
end

local function get_book()
  return get_typical(addresses.book)
end

local function set_somaria(value)
  set_typical(addresses.somaria, value)
end

local function get_somaria()
  return get_typical(addresses.somaria)
end

local function set_byrna(value)
  set_typical(addresses.byrna, value)
end

local function get_byrna()
  return get_typical(addresses.byrna)
end

local function set_cape(value)
  set_typical(addresses.cape, value)
end

local function get_cape()
  return get_typical(addresses.cape)
end

local function set_mirror(value)
  if value == 1 then
    memory.writebyte(addresses.mirror, 2)
  else
    memory.writebyte(addresses.mirror, 0)
  end
end

local function get_mirror()
  value = memory.readbyte(addresses.mirror)
  if value == 2 then
    return 1
  else
    return 0
  end
end

local function set_boots(value)
  local abilities = memory.readbyte(addresses.abilities)
  if value == 1 then
    memory.writebyte(addresses.boots, 1)
    abilities = bit.bor(abilities, 4)
  else
    memory.writebyte(addresses.boots, 0)
    abilities = bit.band(abilities, bit.bnot(4))
  end
  memory.writebyte(addresses.abilities, abilities)
end

local function get_boots()
  return get_typical(addresses.boots)
end

local function set_glove(value)
  set_typical(addresses.glove, value, 2)
end

local function get_glove()
  return get_typical(addresses.glove, 2)
end

local function set_flippers(value)
  local abilities = memory.readbyte(addresses.abilities)
  if value == 1 then
    memory.writebyte(addresses.flippers, 1)
    abilities = bit.bor(abilities, 2)
  else
    memory.writebyte(addresses.flippers, 0)
    abilities = bit.band(abilities, bit.bnot(2))
  end
  memory.writebyte(addresses.abilities, abilities)
end

local function get_flippers()
  return get_typical(addresses.flippers)
end

local function set_pearl(value)
  set_typical(addresses.pearl, value)
end

local function get_pearl()
  return get_typical(addresses.pearl)
end

local function set_sword(value)
  set_typical(addresses.sword, value, 4)
end

local function get_sword()
  return get_typical(addresses.sword, 4)
end

local function set_shield(value)
  set_typical(addresses.shield, value, 3)
end

local function get_shield()
  return get_typical(addresses.shield, 3)
end

local function set_armor(value)
  set_typical(addresses.armor, value, 2)
end

local function get_armor()
  return get_typical(addresses.armor, 2)
end

local function set_magic_usage(value)
  set_typical(addresses.magic_usage, value, 2)
end

local function get_magic_usage()
  return get_typical(addresses.magic_usage, 2)
end

local function set_bottle(address, value)
  local towrite = 2
  if value >= 0 and value <= 6 then
    towrite = value + 2
  end
  memory.writebyte(address, towrite)
end

local function get_bottle(address)
  value = memory.readbyte(address)
  if value >= 2 and value <= 8 then
    return value - 2
  else
    return 0
  end
end

local function set_bottle1(value)
  set_bottle(addresses.bottle1, value)
end

local function get_bottle1()
  return get_bottle(addresses.bottle1)
end

local function set_bottle2(value)
  set_bottle(addresses.bottle2, value)
end

local function get_bottle2()
  return get_bottle(addresses.bottle2)
end

local function set_bottle3(value)
  set_bottle(addresses.bottle3, value)
end

local function get_bottle3()
  return get_bottle(addresses.bottle3)
end

local function set_bottle4(value)
  set_bottle(addresses.bottle4, value)
end

local function get_bottle4()
  return get_bottle(addresses.bottle4)
end

local function get_bottles()
  local count = 0
  for i = 1, 4 do
    if memory.readbyte(bottle_addresses[i]) == 0 then
      return count
    end
    count = count + 1
  end
  return count
end

local function set_bottles(value)
  local old_bottles = get_bottles()
  if old_bottles > value then
    for i = value + 1, old_bottles do
      memory.writebyte(bottle_addresses[i], 0)
    end
  elseif old_bottles < value then
    for i = old_bottles + 1, value do
      memory.writebyte(bottle_addresses[i], 2)
    end
  end

  local bslot = memory.readbyte(addresses.bottles)
  if bslot > value then
    memory.writebyte(addresses.bottles, value)
  end
  if bslot == 0 and value > 0 then
    memory.writebyte(addresses.bottles, 1)
  end
end

items.item_data = {
  bow = {name = "Bow", get = get_bow, set = set_bow, values = {"none", "regular", "silver"}},
  boomerang = {name = "Boomerang", get = get_boomerang, set = set_boomerang, values = {"none", "blue", "red", "both"}},
  hookshot = {name = "Hookshot", get = get_hookshot, set = set_hookshot, values = {false, true}},
  mushroom = {name = "Mushroom", get = get_mushroom, set = set_mushroom, values = {false, true}},
  powder = {name = "Magic Powder", get = get_powder, set = set_powder, values = {false, true}},
  firerod = {name = "Fire Rod", get = get_firerod, set = set_firerod, values = {false, true}},
  icerod = {name = "Ice Rod", get = get_icerod, set = set_icerod, values = {false, true}},
  bombos = {name = "Bombos Medallion", get = get_bombos, set = set_bombos, values = {false, true}},
  ether = {name = "Ether Medallion", get = get_ether, set = set_ether, values = {false, true}},
  quake = {name = "Quake Medallion", get = get_quake, set = set_quake, values = {false, true}},
  lamp = {name = "Lamp", get = get_lamp, set = set_lamp, values = {false, true}},
  hammer = {name = "Magic Hammer", get = get_hammer, set = set_hammer, values = {false, true}},
  shovel = {name = "Shovel", get = get_shovel, set = set_shovel, values = {false, true}},
  flute = {name = "Flute", get = get_flute, set = set_flute, values = {"none", "inactive", "active"}},
  net = {name = "Bug-Catching Net", get = get_net, set = set_net, values = {false, true}},
  book = {name = "Book of Mudora", get = get_book, set = set_book, values = {false, true}},
  somaria = {name = "Cane of Somaria", get = get_somaria, set = set_somaria, values = {false, true}},
  byrna = {name = "Cane of Byrna", get = get_byrna, set = set_byrna, values = {false, true}},
  cape = {name = "Magic Cape", get = get_cape, set = set_cape, values = {false, true}},
  mirror = {name = "Magic Mirror", get = get_mirror, set = set_mirror, values = {false, true}},
  boots = {name = "Pegasus Boots", get = get_boots, set = set_boots, values = {false, true}},
  glove = {name = "Power Glove", get = get_glove, set = set_glove, values = {"none", "glove", "mitt"}},
  flippers = {name = "Flippers", get = get_flippers, set = set_flippers, values = {false, true}},
  pearl = {name = "Moon Pearl", get = get_pearl, set = set_pearl, values = {false, true}},
  sword = {name = "Sword", get = get_sword, set = set_sword, values = {"none", "fighter", "master", "tempered", "golden"}},
  shield = {name = "Shield", get = get_shield, set = set_shield, values = {"none", "blue", "red", "mirror"}},
  armor = {name = "Armor", get = get_armor, set = set_armor, values = {"green", "blue", "red"}},
  magic_usage = {name = "Magic Usage", get = get_magic_usage, set = set_magic_usage, values = {"standard", "1/2", "1/4"}},
  bottles = {name = "Bottles", get = get_bottles, set = set_bottles, values = {0, 1, 2, 3, 4}},
  bottle1 = {name = "Bottle 1", get = get_bottle1, set = set_bottle1, values = {"Empty", "Red", "Green", "Blue", "Fairy", "Bee", "Golden Bee"}},
  bottle2 = {name = "Bottle 2", get = get_bottle2, set = set_bottle2, values = {"Empty", "Red", "Green", "Blue", "Fairy", "Bee", "Golden Bee"}},
  bottle3 = {name = "Bottle 3", get = get_bottle3, set = set_bottle3, values = {"Empty", "Red", "Green", "Blue", "Fairy", "Bee", "Golden Bee"}},
  bottle4 = {name = "Bottle 4", get = get_bottle4, set = set_bottle4, values = {"Empty", "Red", "Green", "Blue", "Fairy", "Bee", "Golden Bee"}},
}

items.addresses = addresses

items.get_bottles = get_bottles

return items;