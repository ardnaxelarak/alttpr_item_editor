local controller = {}

function controller.get_inputs()
  local mem1 = emu.read(0xF8, emu.memType.workRam)
  local mem2 = emu.read(0xFA, emu.memType.workRam)
  return {
    a = mem2 & 0x80 > 0,
    x = mem2 & 0x40 > 0,
    l = mem2 & 0x20 > 0,
    r = mem2 & 0x10 > 0,
    b = mem1 & 0x80 > 0,
    y = mem1 & 0x40 > 0,
    start = mem1 & 0x20 > 0,
    select = mem1 & 0x10 > 0,
    up = mem1 & 0x08 > 0,
    down = mem1 & 0x04 > 0,
    left = mem1 & 0x02 > 0,
    right = mem1 & 0x01 > 0,
  }
end

return controller
