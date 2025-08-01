scx, scy = guiGetScreenSize()
RTPool = {}
RTPool.list = {}
function RTPool.frameStart()
  for rt, info in pairs(RTPool.list) do
    info.bInUse = false
  end
end
function RTPool.GetUnused(sx, sy)
  for rt, info in pairs(RTPool.list) do
    if not info.bInUse and info.sx == sx and info.sy == sy then
      info.bInUse = true
      return rt
    end
  end
  local rt = dxCreateRenderTarget(sx, sy)
  if rt then
    RTPool.list[rt] = {
      bInUse = true,
      sx = sx,
      sy = sy
    }
  end
  return rt
end
function RTPool.clear()
  for rt, info in pairs(RTPool.list) do
    destroyElement(rt)
  end
  RTPool.list = {}
end
