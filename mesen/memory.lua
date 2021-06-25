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
