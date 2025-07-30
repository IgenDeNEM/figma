local sightexports = {sGui = false}
local function sightlangProcessExports()
  for k in pairs(sightexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      sightexports[k] = exports[k]
    else
      sightexports[k] = false
    end
  end
end
sightlangProcessExports()
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processsightlangStaticImage = {}
sightlangStaticImageToc[0] = true
sightlangStaticImageToc[1] = true
sightlangStaticImageToc[2] = true
sightlangStaticImageToc[3] = true
sightlangStaticImageToc[4] = true
sightlangStaticImageToc[5] = true
sightlangStaticImageToc[6] = true
sightlangStaticImageToc[7] = true
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
  if sightlangStaticImageUsed[2] then
    sightlangStaticImageUsed[2] = false
    sightlangStaticImageDel[2] = false
  elseif sightlangStaticImage[2] then
    if sightlangStaticImageDel[2] then
      if now >= sightlangStaticImageDel[2] then
        if isElement(sightlangStaticImage[2]) then
          destroyElement(sightlangStaticImage[2])
        end
        sightlangStaticImage[2] = nil
        sightlangStaticImageDel[2] = false
        sightlangStaticImageToc[2] = true
        return
      end
    else
      sightlangStaticImageDel[2] = now + 5000
    end
  else
    sightlangStaticImageToc[2] = true
  end
  if sightlangStaticImageUsed[3] then
    sightlangStaticImageUsed[3] = false
    sightlangStaticImageDel[3] = false
  elseif sightlangStaticImage[3] then
    if sightlangStaticImageDel[3] then
      if now >= sightlangStaticImageDel[3] then
        if isElement(sightlangStaticImage[3]) then
          destroyElement(sightlangStaticImage[3])
        end
        sightlangStaticImage[3] = nil
        sightlangStaticImageDel[3] = false
        sightlangStaticImageToc[3] = true
        return
      end
    else
      sightlangStaticImageDel[3] = now + 5000
    end
  else
    sightlangStaticImageToc[3] = true
  end
  if sightlangStaticImageUsed[4] then
    sightlangStaticImageUsed[4] = false
    sightlangStaticImageDel[4] = false
  elseif sightlangStaticImage[4] then
    if sightlangStaticImageDel[4] then
      if now >= sightlangStaticImageDel[4] then
        if isElement(sightlangStaticImage[4]) then
          destroyElement(sightlangStaticImage[4])
        end
        sightlangStaticImage[4] = nil
        sightlangStaticImageDel[4] = false
        sightlangStaticImageToc[4] = true
        return
      end
    else
      sightlangStaticImageDel[4] = now + 5000
    end
  else
    sightlangStaticImageToc[4] = true
  end
  if sightlangStaticImageUsed[5] then
    sightlangStaticImageUsed[5] = false
    sightlangStaticImageDel[5] = false
  elseif sightlangStaticImage[5] then
    if sightlangStaticImageDel[5] then
      if now >= sightlangStaticImageDel[5] then
        if isElement(sightlangStaticImage[5]) then
          destroyElement(sightlangStaticImage[5])
        end
        sightlangStaticImage[5] = nil
        sightlangStaticImageDel[5] = false
        sightlangStaticImageToc[5] = true
        return
      end
    else
      sightlangStaticImageDel[5] = now + 5000
    end
  else
    sightlangStaticImageToc[5] = true
  end
  if sightlangStaticImageUsed[6] then
    sightlangStaticImageUsed[6] = false
    sightlangStaticImageDel[6] = false
  elseif sightlangStaticImage[6] then
    if sightlangStaticImageDel[6] then
      if now >= sightlangStaticImageDel[6] then
        if isElement(sightlangStaticImage[6]) then
          destroyElement(sightlangStaticImage[6])
        end
        sightlangStaticImage[6] = nil
        sightlangStaticImageDel[6] = false
        sightlangStaticImageToc[6] = true
        return
      end
    else
      sightlangStaticImageDel[6] = now + 5000
    end
  else
    sightlangStaticImageToc[6] = true
  end
  if sightlangStaticImageUsed[7] then
    sightlangStaticImageUsed[7] = false
    sightlangStaticImageDel[7] = false
  elseif sightlangStaticImage[7] then
    if sightlangStaticImageDel[7] then
      if now >= sightlangStaticImageDel[7] then
        if isElement(sightlangStaticImage[7]) then
          destroyElement(sightlangStaticImage[7])
        end
        sightlangStaticImage[7] = nil
        sightlangStaticImageDel[7] = false
        sightlangStaticImageToc[7] = true
        return
      end
    else
      sightlangStaticImageDel[7] = now + 5000
    end
  else
    sightlangStaticImageToc[7] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/lock.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/lpin2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/lpin.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/lwheel4.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/lwheel3.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[5] = function()
  if not isElement(sightlangStaticImage[5]) then
    sightlangStaticImageToc[5] = false
    sightlangStaticImage[5] = dxCreateTexture("files/lwheel2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[6] = function()
  if not isElement(sightlangStaticImage[6]) then
    sightlangStaticImageToc[6] = false
    sightlangStaticImage[6] = dxCreateTexture("files/lwheel1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[7] = function()
  if not isElement(sightlangStaticImage[7]) then
    sightlangStaticImageToc[7] = false
    sightlangStaticImage[7] = dxCreateTexture("files/larrow.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local x, y = screenX / 2, screenY - 128 - 200 - 32
local currentPin = 1
local direction = 0
local minDeg = math.random(30, 45)
bigWheelRot = 0
wrSpeed = 0
local targetPin = math.random(minDeg, 360) + 360
local targetPinProgress = 0
local pinProgress = 0
bigDoorSpeed = 0
wheelMinigame = false
function refreshBigDoorPos()
  local r = math.pi - math.pi / 2 * (bigDoorOpen and 1.5 or 0)
  local x = 0.148923 * math.cos(r)
  local z = 0.148923 * math.sin(r)
  local d = math.deg(math.asin(z / 1.05406))
  local l = math.sqrt(1.1110424836 - z * z)
  attachElements(vaultPins[1], vaultBigDoor, 1.60936 + x, 0.025, 0.108106 + z, 0, -d, 0)
  attachElements(vaultPins[2], vaultBigDoor, 1.60936 - x, 0.025, 0.108106 - z, 0, 180 - d, 0)
  attachElements(vaultPins[3], vaultBigDoor, 0.5552999999999999 - l + x, 0, 0.108106, 0, 180, 0)
  attachElements(vaultPins[4], vaultBigDoor, 2.66342 + l - x, 0, 0.108106, 0, 0, 0)
  attachElements(vaultPins[5], vaultBigDoor, 1.60936 + x, 0.025, -0.782258 + z, 0, -d, 0)
  attachElements(vaultPins[6], vaultBigDoor, 1.60936 - x, 0.025, -0.782258 - z, 0, 180 - d, 0)
  attachElements(vaultPins[7], vaultBigDoor, 0.5552999999999999 - l + x, 0, -0.782258, 0, 180, 0)
  attachElements(vaultPins[8], vaultBigDoor, 2.66342 + l - x, 0, -0.782258, 0, 0, 0)
  attachElements(vaultWheel, vaultBigDoor, 1.597, 0.125, -0.34905, 0, bigWheelRot, 0)
  setElementPosition(vaultBigDoor, vaultBigDoorPos[1], vaultBigDoorPos[2] - (bigDoorOpen and 0.375 or 0), vaultBigDoorPos[3])
  setElementRotation(vaultBigDoor, 0, 0, vaultBigDoorPos[4] + (bigDoorOpen and -130 or 0))
end
function pinSound(id)
  local s = false
  if id == 1 then
    s = playSound3D("files/wnext.mp3", vaultBigDoorPos[1] - 1.597, vaultBigDoorPos[2] + 0.125, vaultBigDoorPos[3] - 0.34905)
  elseif id == 2 then
    s = playSound3D("files/wpin2.mp3", vaultBigDoorPos[1] - 1.597, vaultBigDoorPos[2] + 0.125, vaultBigDoorPos[3] - 0.34905)
  elseif id == 3 then
    s = playSound3D("files/wpin.mp3", vaultBigDoorPos[1] - 1.597, vaultBigDoorPos[2] + 0.125, vaultBigDoorPos[3] - 0.34905)
  end
  if s then
    setSoundMaxDistance(s, 30)
    setSoundVolume(s, 1.5)
  end
end
addEvent("goldrobWheelPinSound", true)
addEventHandler("goldrobWheelPinSound", getRootElement(), function(id)
  if source ~= localPlayer then
    pinSound(id)
  end
end)
addEvent("gotGoldrobWheelSpeed", true)
addEventHandler("gotGoldrobWheelSpeed", getRootElement(), function(spd)
  if source ~= localPlayer then
    bigDoorSpeed = spd or 0
  end
end)
function preRenderWheelMinigame(delta)
  local targetDirection = currentPin % 2 == 0 and math.pi or 0
  if targetDirection < direction then
    direction = direction - math.pi * 3 * delta / 1000
    if targetDirection > direction then
      direction = targetDirection
    end
  end
  if targetDirection > direction then
    direction = direction + math.pi * 3 * delta / 1000
    if targetDirection < direction then
      direction = targetDirection
    end
  end
  local tSpeed = 0
  if getKeyState("a") or getKeyState("arrow_l") then
    tSpeed = -1
  elseif getKeyState("d") or getKeyState("arrow_r") then
    tSpeed = 1
  elseif getKeyState("space") and 1 <= pinProgress and wrSpeed == 0 then
    targetPinProgress = 0
    pinProgress = 0
    minDeg = math.random(30, 45)
    targetPin = math.random(minDeg, 360) + 360
    currentPin = currentPin + 1
    pinSound(1)
    triggerServerEvent("goldrobWheelPinSound", localPlayer, 1)
    if 6 <= currentPin then
      stopWheelMinigame(true)
      return
    end
  elseif getKeyState("backspace") then
    stopWheelMinigame()
    return
  end
  if bigDoorSpeed ~= tSpeed then
    bigDoorSpeed = tSpeed
    triggerServerEvent("updateGoldrobWheelSpeed", localPlayer, tSpeed ~= 0 and tSpeed)
  end
  local wrs = wrSpeed * delta / 1000
  local spd = currentPin % 2 == 0 and 1 or -1
  local new = targetPin + spd * wrs
  if 1 <= targetPinProgress then
    if targetPin < -minDeg or targetPin > minDeg then
      targetPinProgress = 0
      new = new + 360
      pinSound(2)
      triggerServerEvent("goldrobWheelPinSound", localPlayer, 2)
    end
  elseif targetPin > minDeg and new < minDeg then
    targetPinProgress = 1
    pinSound(3)
    triggerServerEvent("goldrobWheelPinSound", localPlayer, 3)
  end
  targetPin = new
  if 720 <= targetPin then
    targetPin = targetPin - 360
  elseif targetPin <= -360 then
    targetPin = targetPin + 720
  end
  if pinProgress > targetPinProgress then
    pinProgress = pinProgress - 4 * delta / 1000
    if pinProgress < targetPinProgress then
      pinProgress = targetPinProgress
    end
  end
  if pinProgress < targetPinProgress then
    pinProgress = pinProgress + 4 * delta / 1000
    if pinProgress > targetPinProgress then
      pinProgress = targetPinProgress
    end
  end
  local px, py, pz = getElementPosition(localPlayer)
  if getDistanceBetweenPoints3D(px, py, pz, vaultBigDoorWheelPos[1], vaultBigDoorWheelPos[2], vaultBigDoorWheelPos[3]) > 1.5 then
    stopWheelMinigame()
  end
end
function renderWheelMinigame()
  sightlangStaticImageUsed[0] = true
  if sightlangStaticImageToc[0] then
    processsightlangStaticImage[0]()
  end
  dxDrawImage(x - 128 - 24, y - 128, 48, 96, sightlangStaticImage[0])
  for i = 1, 5 do
    local p = i >= currentPin and 0 or 1
    if i == currentPin then
      p = pinProgress
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
      end
      dxDrawImage(x - 128 - 24 + 9 * p, y - 128 + 13 * (i - 1), 48, 96, sightlangStaticImage[1], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3]))
    end
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImage(x - 128 - 24 + 9 * p, y - 128 + 13 * (i - 1), 48, 96, sightlangStaticImage[2])
  end
  sightlangStaticImageUsed[3] = true
  if sightlangStaticImageToc[3] then
    processsightlangStaticImage[3]()
  end
  dxDrawImage(x - 128, y - 128, 256, 256, sightlangStaticImage[3])
  sightlangStaticImageUsed[4] = true
  if sightlangStaticImageToc[4] then
    processsightlangStaticImage[4]()
  end
  dxDrawImage(x - 128, y - 128, 256, 256, sightlangStaticImage[4], bigWheelRot)
  sightlangStaticImageUsed[5] = true
  if sightlangStaticImageToc[5] then
    processsightlangStaticImage[5]()
  end
  dxDrawImage(x - 128, y - 128, 256, 256, sightlangStaticImage[5])
  sightlangStaticImageUsed[6] = true
  if sightlangStaticImageToc[6] then
    processsightlangStaticImage[6]()
  end
  dxDrawImage(x - 128, y - 128, 256, 256, sightlangStaticImage[6], bigWheelRot)
  local as = 256 * math.cos(direction)
  sightlangStaticImageUsed[7] = true
  if sightlangStaticImageToc[7] then
    processsightlangStaticImage[7]()
  end
  dxDrawImage(x - as / 2, y - 128, as, 256, sightlangStaticImage[7], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3]))
end
function stopWheelMinigame(success)
  if wheelMinigame then
    removeEventHandler("onClientPreRender", getRootElement(), preRenderWheelMinigame)
    removeEventHandler("onClientRender", getRootElement(), renderWheelMinigame)
  end
  wheelMinigame = false
  showCursor(false)
  triggerServerEvent("goldrobWheelMinigameEnd", localPlayer, success)
end
addEvent("startWheelMinigame", true)
addEventHandler("startWheelMinigame", getRootElement(), function()
  showCursor(true)
  currentPin = 1
  direction = 0
  minDeg = math.random(30, 45)
  targetPin = math.random(minDeg, 360) + 360
  targetPinProgress = 0
  pinProgress = 0
  if not wheelMinigame then
    addEventHandler("onClientPreRender", getRootElement(), preRenderWheelMinigame)
    addEventHandler("onClientRender", getRootElement(), renderWheelMinigame)
  end
  sightexports.sGui:showInfobox("i", "Használd a nyíl gombokat a kerék forgatásához! A zöld nyíl mutatja a helyes irányt.")
  sightexports.sGui:showInfobox("i", "Amikor kikattan a csap, állítsd meg a kereket, és nyomj SPACE gombot.")
  sightexports.sGui:showInfobox("i", "A Backspace gombbal tudod megszakítani a folyamatot.")
  wheelMinigame = true
end)
