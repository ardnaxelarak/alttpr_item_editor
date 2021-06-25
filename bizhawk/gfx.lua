local gfx = {}

local transparent = 0x00000000

function gfx.draw_string(x, y, text, color)
  local c = color or 0xFFFFFF
  gui.pixelText(x, y - 1, text, color, transparent, "fceux")
end

function gfx.draw_rect(x, y, width, height, color, filled)
  if (filled) then
    gui.drawRectangle(x, y, width, height, color, color)
  else
    gui.drawRectangle(x, y, width, height, color, transparent)
  end
end

function gfx.draw_left_arrow(x, y, color)
  gui.drawLine(x, y - 3, x - 3, y, color)
  gui.drawLine(x - 3, y, x, y + 3, color)
  gui.drawLine(x, y + 3, x, y - 3, color)
end

function gfx.draw_right_arrow(x, y, color)
  gui.drawLine(x, y - 3, x + 3, y, color)
  gui.drawLine(x + 3, y, x, y + 3, color)
  gui.drawLine(x, y + 3, x, y - 3, color)
end

return gfx
