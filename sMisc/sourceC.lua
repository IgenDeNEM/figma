local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderOstor, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderOstor)
    end
  end
end
local csapasok = {}
function renderOstor()
  for k = #csapasok, 1, -1 do
    local progress = math.max(0, (getTickCount() - csapasok[k][4]) / 400)
    if isElement(csapasok[k][5]) then
      local x, y, z = csapasok[k][1], csapasok[k][2], csapasok[k][3]
      local x2, y2, z2 = getPedBonePosition(csapasok[k][5], 25)
      if x2 and y2 and z2 then
        local rx, ry, rz = getElementRotation(csapasok[k][5])
        rz = math.rad(rz)
        local drawX = x2 + 0 * math.cos(rz) - 0.75 * math.sin(rz)
        local drawY = y2 + 0 * math.sin(rz) + 0.75 * math.cos(rz)
        local x, y, z = interpolateBetween(drawX, drawY, z2 + 2, x, y, z, progress, "InOutQuad")
        dxDrawLine3D(x2, y2, z2, drawX, drawY, z2, tocolor(79, 29, 0))
        dxDrawLine3D(drawX, drawY, z2, x, y, z, tocolor(0, 0, 0))
        if 1 <= progress then
          fxAddPunchImpact(x, y, z, 0, 0, 1)
          if csapasok[k][6] and isElement(csapasok[k][6]) and getElementType(csapasok[k][6]) == "player" then
            fxAddBlood(x, y, z, 0, 0, 1)
          end
        end
      end
    end
    if 1.1 < progress then
      table.remove(csapasok, k)
    end
  end
  sightlangCondHandl0(0 < #csapasok)
end
addEvent("ostorCsapas", true)
addEventHandler("ostorCsapas", getRootElement(), function(x, y, z, clickedElement)
  table.insert(csapasok, {
    x,
    y,
    z,
    getTickCount() + 50,
    source,
    clickedElement
  })
  sightlangCondHandl0(true)
  playSound3D("files/Ustor.mp3", x, y, z)
  if isElement(clickedElement) and getElementType(clickedElement) == "player" then
    setTimer(function()
      if getElementHealth(clickedElement) > 0 then
        setPedAnimation(clickedElement, "chainsaw", "csaw_hit_2", -1, false, true, false, false)
      end
      playSound3D("files/oa.mp3", x, y, z)
    end, 300, 1, x, y, z)
  end
end)
