local screenX, screenY = guiGetScreenSize()
local setDXAlpha = function(dx, alpha)
  local r, g, b = dx:color()
  dx:color(r, g, b, alpha)
end
function Animation.presets.dxTextFadeIn(time)
  return {
    from = 0,
    to = 255,
    time = time or 1000,
    fn = setDXAlpha
  }
end
function Animation.presets.dxTextFadeOut(time)
  return {
    from = 255,
    to = 0,
    time = time or 1000,
    fn = setDXAlpha
  }
end
