local mem = {}

function mem.read_wram(address)
  return memory.read_u8(address, "WRAM")
end

function mem.read_wram_word(address)
  return memory.read_u16_le(address, "WRAM")
end

function mem.read_rom(address)
  return memory.read_u8(address, "CARTROM")
end

function mem.write_wram(address, value)
  return memory.write_u8(address, value, "WRAM")
end

function mem.write_wram_word(address, value)
  return memory.write_u16_le(address, value, "WRAM")
end

return mem
