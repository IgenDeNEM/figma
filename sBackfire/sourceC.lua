local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processsightlangStaticImage = {}
sightlangStaticImageToc[0] = true
sightlangStaticImageToc[1] = true
local sightlangStatImgPre
function sightlangStatImgPre()
  local now = getTickCount()
  if sightlangStaticImageUsed[0] then
    sightlangStaticImageUsed[0] = false
    sightlangStaticImageDel[0] = false
  elseif sightlangStaticImage[0] then
    if sightlangStaticImageDel[0] then
      if now >= sightlangStaticImageDel[0] then
        if isElement(sightlangStaticImage[0]) then
          destroyElement(sightlangStaticImage[0])
        end
        sightlangStaticImage[0] = nil
        sightlangStaticImageDel[0] = false
        sightlangStaticImageToc[0] = true
        return
      end
    else
      sightlangStaticImageDel[0] = now + 5000
    end
  else
    sightlangStaticImageToc[0] = true
  end
  if sightlangStaticImageUsed[1] then
    sightlangStaticImageUsed[1] = false
    sightlangStaticImageDel[1] = false
  elseif sightlangStaticImage[1] then
    if sightlangStaticImageDel[1] then
      if now >= sightlangStaticImageDel[1] then
        if isElement(sightlangStaticImage[1]) then
          destroyElement(sightlangStaticImage[1])
        end
        sightlangStaticImage[1] = nil
        sightlangStaticImageDel[1] = false
        sightlangStaticImageToc[1] = true
        return
      end
    else
      sightlangStaticImageDel[1] = now + 5000
    end
  else
    sightlangStaticImageToc[1] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/spark.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/fire.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState2 then
    sightlangCondHandlState2 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderInVeh, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderInVeh)
    end
  end
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderOldBackfire, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderOldBackfire)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderNewBackfire, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderNewBackfire)
    end
  end
end
local screenX, screenY = guiGetScreenSize()
local s = 1.25
local sparks = {}
local fires = {}
local backfireVeh = false
local backfireType = false
local spd = 0.5
local nm = 0.5
local snd = 1
addEvent("gotBackfireDataForVehicle", true)
addEventHandler("gotBackfireDataForVehicle", getRootElement(), function(bft, settings)
  if source == backfireVeh then
    backfireType = bft
    if bft == 2 and settings then
      snd = settings[1]
      spd = settings[2]
      nm = settings[3]
    else
      snd = 1
      spd = 0
      nm = 0
    end
  end
end)
function popVehicle(veh, dbl, i)
  local m = getElementMatrix(veh)
  if m then
    local vx, vy, vz = m[4][1], m[4][2], m[4][3]
    local x, y, z = getVehicleModelExhaustFumesPosition(getElementModel(veh))
    table.insert(fires, {
      veh,
      x,
      y,
      z,
      getTickCount()
    })
    spawnSpark(veh, math.random(10, 25), x, y, z)
    if dbl then
      spawnSpark(veh, math.random(10, 25), -x, y, z)
    end
    if dbl then
      table.insert(fires, {
        veh,
        -x,
        y,
        z,
        getTickCount()
      })
    end
    if not tonumber(i) or i < 1 or 12 < i then
      i = 1
    end
    local sound = playSound3D("files/" .. i .. ".wav", vx, vy, vz)
    attachElements(sound, veh, x, y, z)
    setSoundVolume(sound, 1 * math.random(75, 125) / 100)
    setElementDimension(sound, getElementDimension(veh))
    setElementInterior(sound, getElementInterior(veh))
    sightlangCondHandl0(true)
  end
end
function spawnSpark(veh, n, px, py, pz)
  for i = 1, n do
    local x = math.random(-2000, 2000) / 1500
    local y = -math.random(4000, 6000) / 1000
    local z = math.random(1000, 4000) / 1500
    table.insert(sparks, {
      px,
      py,
      pz,
      x,
      y,
      z,
      math.random(5, 25) / 100,
      getTickCount(),
      veh
    })
  end
end
function popDown(veh, dbl, n, snd, spd, nm)
  local t = 0
  popVehicle(veh, dbl, snd)
  spd = tonumber(spd)
  if not spd or spd < 0 or 1 < spd then
    spd = 0.5
  end
  nm = tonumber(nm)
  if not nm or nm < 0 or 1 < nm then
    nm = 0.5
  end
  n = tonumber(n)
  if not n or n < 200 or 400 < n then
    n = math.random(200, 400)
  end
  local no = n
  n = math.floor(n * (0.4 + 0.6 * spd) * (1 + 2 * nm) / 100 + 0.5)
  for i = 1, n do
    t = t + math.random(50 + 150 * (1 - spd), 125 + 200 * (1 - spd))
    setTimer(popVehicle, t, 1, veh, dbl, snd)
  end
  return t + 300, no
end
local oldEffects = {}
function popOld(veh, dbl)
  local x, y, z = getElementPosition(veh)
  local rx, ry, rz = getElementRotation(veh)
  local ox, oy, oz = getVehicleModelExhaustFumesPosition(getElementModel(veh))
  oy = oy - 0.1
  for k = 1, 3 do
    local eff = createEffect("gunflash", x, y, z, 0, 90, rz)
    setEffectSpeed(eff, 0.5)
    table.insert(oldEffects, {
      eff,
      veh,
      getTickCount(),
      ox,
      oy,
      oz
    })
  end
  if dbl then
    for k = 1, 3 do
      local eff = createEffect("gunflash", x, y, z, 0, 90, rz)
      setEffectSpeed(eff, 0.5)
      table.insert(oldEffects, {
        eff,
        veh,
        getTickCount(),
        -ox,
        oy,
        oz
      })
    end
  end
  sightlangCondHandl1(true)
  local s = playSound3D("files/old.mp3", x, y, z, false)
  setSoundVolume(s, 0.7)
  attachElements(s, veh)
  setElementDimension(s, getElementDimension(veh))
  setElementInterior(s, getElementInterior(veh))
end
function getPositionFromElementOffset(m, offX, offY, offZ)
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z
end
function getElementSpeed(element)
  local x, y, z = getElementVelocity(element)
  return (x ^ 2 + y ^ 2 + z ^ 2) ^ 0.5
end
function preRenderOldBackfire()
  local matrices = {}
  for k = #oldEffects, 1, -1 do
    if oldEffects[k] then
      if isElement(oldEffects[k][2]) then
        local rx, ry, rz = getElementRotation(oldEffects[k][2])
        if not matrices[oldEffects[k][2]] then
          matrices[oldEffects[k][2]] = getElementMatrix(oldEffects[k][2])
        end
        local x, y, z = getPositionFromElementOffset(matrices[oldEffects[k][2]], oldEffects[k][4], oldEffects[k][5], oldEffects[k][6])
        setElementPosition(oldEffects[k][1], x, y, z)
        setElementRotation(oldEffects[k][1], 0, 90, -rz - 90)
        if getTickCount() - oldEffects[k][3] > 250 then
          if isElement(oldEffects[k][1]) then
            destroyElement(oldEffects[k][1])
          end
          oldEffects[k][1] = nil
          table.remove(oldEffects, k)
        end
      else
        if isElement(oldEffects[k][1]) then
          destroyElement(oldEffects[k][1])
        end
        oldEffects[k][1] = nil
        table.remove(oldEffects, k)
      end
    end
  end
  if #oldEffects < 1 then
    sightlangCondHandl1(false)
  end
end
addEvent("syncBackfireState", true)
addEventHandler("syncBackfireState", getRootElement(), function(veh, bf, snd, n, spd, nm)
  if source ~= localPlayer and isElement(veh) then
    local dbl = bitAnd(getVehicleHandling(veh).modelFlags, 8192) == 8192
    if bf == 1 then
      popVehicle(veh, dbl, snd)
    elseif bf == 2 then
      popDown(veh, dbl, n, snd, spd, nm)
    elseif bf == 3 then
      popOld(veh, dbl)
    end
  end
end)
local tmp = 0
local canFire = 0
local lastPop = 0
addEventHandler("onClientResourceStart", resourceRoot, function()
  local pedveh = getPedOccupiedVehicle(localPlayer)
  if pedveh and getPedOccupiedVehicleSeat(localPlayer) == 0 then
    sightlangCondHandl2(true)
  end
end)
addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(veh, seat)
  if seat == 0 then
    sightlangCondHandl2(true)
  end
end)
function preRenderInVeh(delta)
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh ~= backfireVeh then
    backfireVeh = veh
    if veh and getVehicleController(veh) == localPlayer then
      tmp = getVehicleCurrentGear(veh)
      canFire = 0
      backfireType = false
      if isElement(veh) then
        triggerServerEvent("requestBackfireData", localPlayer, veh)
      end
    else
      sightlangCondHandl2(false)
      return
    end
  end
  if backfireType then
    local dbl = bitAnd(getVehicleHandling(veh).modelFlags, 8192) == 8192
    local gear = getVehicleCurrentGear(veh)
    if gear ~= tmp then
      if backfireType == 2 then
        if gear > tmp then
          popVehicle(veh, dbl, snd)
          triggerServerEvent("syncBackfireState", localPlayer, veh, getElementsByType("player", getRootElement(), true), 1)
        end
      else
        popOld(veh, dbl)
        triggerServerEvent("syncBackfireState", localPlayer, veh, getElementsByType("player", getRootElement(), true), 3)
      end
      tmp = gear
    end
    if backfireType == 2 then
      local accel = getAnalogControlState("accelerate")
      if 0 < lastPop then
        lastPop = lastPop - delta
      end
      if 0 < accel then
        canFire = canFire + accel * delta / 1000
      else
        if 1 <= canFire and lastPop <= 0 then
          local n = 0
          lastPop, n = popDown(veh, dbl, false, snd, spd, nm)
          triggerServerEvent("syncBackfireState", localPlayer, veh, getElementsByType("player", getRootElement(), true), 2, n)
        end
        canFire = 0
      end
    end
  end
end
function preRenderNewBackfire(delta)
  local vehMatrixes = {}
  local now = getTickCount()
  local cx, cy, cz = getCameraMatrix()
  local x, y, z = getWorldFromScreenPosition(screenX / 2, 0, 128)
  local x2, y2, z2 = getWorldFromScreenPosition(screenX / 2, screenY / 2, 128)
  x = x2 - x
  y = y2 - y
  z = z2 - z
  local len = math.sqrt(x * x + y * y + z * z) * 2
  x = x / len
  y = y / len
  z = z / len
  for i = #sparks, 1, -1 do
    if isElement(sparks[i][9]) then
      if vehMatrixes[sparks[i][9]] == nil then
        local x, y, z = getElementPosition(sparks[i][9])
        if getDistanceBetweenPoints3D(cx, cy, cz, x, y, z) <= 90 then
          vehMatrixes[sparks[i][9]] = getElementMatrix(sparks[i][9])
        else
          vehMatrixes[sparks[i][9]] = false
        end
      end
      m = vehMatrixes[sparks[i][9]]
      local p = (now - sparks[i][8]) / 250
      if 3 < p then
        table.remove(sparks, i)
      elseif m then
        local sx = sparks[i][1] * m[1][1] + sparks[i][2] * m[2][1] + sparks[i][3] * m[3][1] + m[4][1]
        local sy = sparks[i][1] * m[1][2] + sparks[i][2] * m[2][2] + sparks[i][3] * m[3][2] + m[4][2]
        local sz = sparks[i][1] * m[1][3] + sparks[i][2] * m[2][3] + sparks[i][3] * m[3][3] + m[4][3]
        sparks[i][1] = sparks[i][1] + sparks[i][4] * delta / 1000
        sparks[i][2] = sparks[i][2] + sparks[i][5] * delta / 1000
        sparks[i][3] = sparks[i][3] + sparks[i][6] * delta / 1000
        if sparks[i][6] > -0.5 then
          sparks[i][6] = sparks[i][6] - 5 * delta / 1000
        end
        local size = 0.1 * sparks[i][7]
        local a = (175 + math.sin(p * 2 * math.pi) * 25) * (1 - math.max(0, p - 2))
        sightlangStaticImageUsed[0] = true
        if sightlangStaticImageToc[0] then
          processsightlangStaticImage[0]()
        end
        dxDrawMaterialSectionLine3D(sx + x * size, sy + y * size, sz + z * size, sx - x * size, sy - y * size, sz - z * size, 16 * math.random(0, 7), 0, 16, 16, sightlangStaticImage[0], size, tocolor(255, 255, 255, a))
      end
    else
      table.remove(sparks, i)
    end
  end
  for i = #fires, 1, -1 do
    if isElement(fires[i][1]) then
      local p = (now - fires[i][5]) / 100
      local p2 = 1
      if 1 < p then
        p2 = 2 - p
      end
      if 1 < p then
        p = 1
      end
      if p2 < 0 then
        p2 = 0
      end
      if vehMatrixes[fires[i][1]] == nil then
        local x, y, z = getElementPosition(fires[i][1])
        if getDistanceBetweenPoints3D(cx, cy, cz, x, y, z) <= 90 then
          vehMatrixes[fires[i][1]] = getElementMatrix(fires[i][1])
        else
          vehMatrixes[fires[i][1]] = false
        end
      end
      local m = vehMatrixes[fires[i][1]]
      if m then
        local fx = fires[i][2]
        local fy = fires[i][3]
        local fz = fires[i][4]
        local x = fx * m[1][1] + fy * m[2][1] + fz * m[3][1] + m[4][1]
        local y = fx * m[1][2] + fy * m[2][2] + fz * m[3][2] + m[4][2]
        local z = fx * m[1][3] + fy * m[2][3] + fz * m[3][3] + m[4][3]
        local sp = s * p
        local rx, ry, rz = -m[2][1], -m[2][2], -m[2][3]
        sightlangStaticImageUsed[1] = true
        if sightlangStaticImageToc[1] then
          processsightlangStaticImage[1]()
        end
        dxDrawMaterialSectionLine3D(x + rx * sp, y + ry * sp, z + rz * sp, x + rx * (s * (1 - p2)), y + ry * (s * (1 - p2)), z + rz * (s * (1 - p2)), math.random(0, 7) * 128, 256 * (1 - p), 128, 256 * p * p2, sightlangStaticImage[1], s / 2, tocolor(255, 255, 255, 200), false, x, y, z + 1)
        sightlangStaticImageUsed[1] = true
        if sightlangStaticImageToc[1] then
          processsightlangStaticImage[1]()
        end
        dxDrawMaterialSectionLine3D(x + rx * sp, y + ry * sp, z + rz * sp, x + rx * (s * (1 - p2)), y + ry * (s * (1 - p2)), z + rz * (s * (1 - p2)), math.random(0, 7) * 128, 256 * (1 - p), 128, 256 * p * p2, sightlangStaticImage[1], s / 2, tocolor(255, 255, 255, 200), false, x + 1, y, z)
        sightlangStaticImageUsed[1] = true
        if sightlangStaticImageToc[1] then
          processsightlangStaticImage[1]()
        end
        dxDrawMaterialSectionLine3D(x + rx * sp, y + ry * sp, z + rz * sp, x + rx * (s * (1 - p2)), y + ry * (s * (1 - p2)), z + rz * (s * (1 - p2)), math.random(0, 7) * 128, 256 * (1 - p), 128, 256 * p * p2, sightlangStaticImage[1], s / 2, tocolor(255, 255, 255, 200), false, x + 1, y, z + 1)
        sightlangStaticImageUsed[1] = true
        if sightlangStaticImageToc[1] then
          processsightlangStaticImage[1]()
        end
        dxDrawMaterialSectionLine3D(x + rx * sp, y + ry * sp, z + rz * sp, x + rx * (s * (1 - p2)), y + ry * (s * (1 - p2)), z + rz * (s * (1 - p2)), math.random(0, 7) * 128, 256 * (1 - p), 128, 256 * p * p2, sightlangStaticImage[1], s / 2, tocolor(255, 255, 255, 200), false, x - 1, y, z + 1)
      end
      if p2 <= 0 then
        table.remove(fires, i)
      end
    else
      table.remove(fires, i)
    end
  end
  if #fires <= 0 and #sparks <= 0 then
    sightlangCondHandl0(false)
  end
end
