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
