local sightexports = {sItems = false, sGui = false}
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
sightlangStaticImageToc[8] = true
sightlangStaticImageToc[9] = true
sightlangStaticImageToc[10] = true
sightlangStaticImageToc[11] = true
sightlangStaticImageToc[12] = true
sightlangStaticImageToc[13] = true
sightlangStaticImageToc[14] = true
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
  if sightlangStaticImageUsed[8] then
    sightlangStaticImageUsed[8] = false
    sightlangStaticImageDel[8] = false
  elseif sightlangStaticImage[8] then
    if sightlangStaticImageDel[8] then
      if now >= sightlangStaticImageDel[8] then
        if isElement(sightlangStaticImage[8]) then
          destroyElement(sightlangStaticImage[8])
        end
        sightlangStaticImage[8] = nil
        sightlangStaticImageDel[8] = false
        sightlangStaticImageToc[8] = true
        return
      end
    else
      sightlangStaticImageDel[8] = now + 5000
    end
  else
    sightlangStaticImageToc[8] = true
  end
  if sightlangStaticImageUsed[9] then
    sightlangStaticImageUsed[9] = false
    sightlangStaticImageDel[9] = false
  elseif sightlangStaticImage[9] then
    if sightlangStaticImageDel[9] then
      if now >= sightlangStaticImageDel[9] then
        if isElement(sightlangStaticImage[9]) then
          destroyElement(sightlangStaticImage[9])
        end
        sightlangStaticImage[9] = nil
        sightlangStaticImageDel[9] = false
        sightlangStaticImageToc[9] = true
        return
      end
    else
      sightlangStaticImageDel[9] = now + 5000
    end
  else
    sightlangStaticImageToc[9] = true
  end
  if sightlangStaticImageUsed[10] then
    sightlangStaticImageUsed[10] = false
    sightlangStaticImageDel[10] = false
  elseif sightlangStaticImage[10] then
    if sightlangStaticImageDel[10] then
      if now >= sightlangStaticImageDel[10] then
        if isElement(sightlangStaticImage[10]) then
          destroyElement(sightlangStaticImage[10])
        end
        sightlangStaticImage[10] = nil
        sightlangStaticImageDel[10] = false
        sightlangStaticImageToc[10] = true
        return
      end
    else
      sightlangStaticImageDel[10] = now + 5000
    end
  else
    sightlangStaticImageToc[10] = true
  end
  if sightlangStaticImageUsed[11] then
    sightlangStaticImageUsed[11] = false
    sightlangStaticImageDel[11] = false
  elseif sightlangStaticImage[11] then
    if sightlangStaticImageDel[11] then
      if now >= sightlangStaticImageDel[11] then
        if isElement(sightlangStaticImage[11]) then
          destroyElement(sightlangStaticImage[11])
        end
        sightlangStaticImage[11] = nil
        sightlangStaticImageDel[11] = false
        sightlangStaticImageToc[11] = true
        return
      end
    else
      sightlangStaticImageDel[11] = now + 5000
    end
  else
    sightlangStaticImageToc[11] = true
  end
  if sightlangStaticImageUsed[12] then
    sightlangStaticImageUsed[12] = false
    sightlangStaticImageDel[12] = false
  elseif sightlangStaticImage[12] then
    if sightlangStaticImageDel[12] then
      if now >= sightlangStaticImageDel[12] then
        if isElement(sightlangStaticImage[12]) then
          destroyElement(sightlangStaticImage[12])
        end
        sightlangStaticImage[12] = nil
        sightlangStaticImageDel[12] = false
        sightlangStaticImageToc[12] = true
        return
      end
    else
      sightlangStaticImageDel[12] = now + 5000
    end
  else
    sightlangStaticImageToc[12] = true
  end
  if sightlangStaticImageUsed[13] then
    sightlangStaticImageUsed[13] = false
    sightlangStaticImageDel[13] = false
  elseif sightlangStaticImage[13] then
    if sightlangStaticImageDel[13] then
      if now >= sightlangStaticImageDel[13] then
        if isElement(sightlangStaticImage[13]) then
          destroyElement(sightlangStaticImage[13])
        end
        sightlangStaticImage[13] = nil
        sightlangStaticImageDel[13] = false
        sightlangStaticImageToc[13] = true
        return
      end
    else
      sightlangStaticImageDel[13] = now + 5000
    end
  else
    sightlangStaticImageToc[13] = true
  end
  if sightlangStaticImageUsed[14] then
    sightlangStaticImageUsed[14] = false
    sightlangStaticImageDel[14] = false
  elseif sightlangStaticImage[14] then
    if sightlangStaticImageDel[14] then
      if now >= sightlangStaticImageDel[14] then
        if isElement(sightlangStaticImage[14]) then
          destroyElement(sightlangStaticImage[14])
        end
        sightlangStaticImage[14] = nil
        sightlangStaticImageDel[14] = false
        sightlangStaticImageToc[14] = true
        return
      end
    else
      sightlangStaticImageDel[14] = now + 5000
    end
  else
    sightlangStaticImageToc[14] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] and sightlangStaticImageToc[9] and sightlangStaticImageToc[10] and sightlangStaticImageToc[11] and sightlangStaticImageToc[12] and sightlangStaticImageToc[13] and sightlangStaticImageToc[14] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/bg3.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/bg2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/bat.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/bat2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/fog.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[5] = function()
  if not isElement(sightlangStaticImage[5]) then
    sightlangStaticImageToc[5] = false
    sightlangStaticImage[5] = dxCreateTexture("files/hdark.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[6] = function()
  if not isElement(sightlangStaticImage[6]) then
    sightlangStaticImageToc[6] = false
    sightlangStaticImage[6] = dxCreateTexture("files/hlight2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[7] = function()
  if not isElement(sightlangStaticImage[7]) then
    sightlangStaticImageToc[7] = false
    sightlangStaticImage[7] = dxCreateTexture("files/spiral.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[8] = function()
  if not isElement(sightlangStaticImage[8]) then
    sightlangStaticImageToc[8] = false
    sightlangStaticImage[8] = dxCreateTexture("files/spiral2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[9] = function()
  if not isElement(sightlangStaticImage[9]) then
    sightlangStaticImageToc[9] = false
    sightlangStaticImage[9] = dxCreateTexture("files/head.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[10] = function()
  if not isElement(sightlangStaticImage[10]) then
    sightlangStaticImageToc[10] = false
    sightlangStaticImage[10] = dxCreateTexture("files/hlight.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[11] = function()
  if not isElement(sightlangStaticImage[11]) then
    sightlangStaticImageToc[11] = false
    sightlangStaticImage[11] = dxCreateTexture("files/bg_654.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[12] = function()
  if not isElement(sightlangStaticImage[12]) then
    sightlangStaticImageToc[12] = false
    sightlangStaticImage[12] = dxCreateTexture("files/itemHover.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[13] = function()
  if not isElement(sightlangStaticImage[13]) then
    sightlangStaticImageToc[13] = false
    sightlangStaticImage[13] = dxCreateTexture("files/ibg.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[14] = function()
  if not isElement(sightlangStaticImage[14]) then
    sightlangStaticImageToc[14] = false
    sightlangStaticImage[14] = dxCreateTexture("files/win.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sItems")
    if res0 and getResourceState(res0) == "running" then
      loadedItems()
      sightlangWaiterState0 = true
    end
  end
end
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end
local font = false
local fontScale = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    font = sightexports.sGui:getFont("17/BebasNeueRegular.otf")
    fontScale = sightexports.sGui:getFontScale("17/BebasNeueRegular.otf")
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
function teaDecodeBinary(data, key)
  return decodeString(teaDecode(data, key))
end
function teaEncodeBinary(data, key)
  return teaEncode(encodeString(data), key)
end
local pumpkinNames = {}
function loadedItems()
  for item in pairs(pumpkinData) do
    pumpkinNames[item] = sightexports.sItems:getItemName(item)
  end
end
local screenX, screenY = guiGetScreenSize()
local minigameStarted = false
local itemList = {}
local itemEye = false
local targetAlpha = 0
local spinSpeed = 0
local targetSpinSpeed = false
local spinAcceleration = false
local spinDeceleration = false
local spinStop = false
local spinMin = 75
local spinMin2 = 12.5
local winItem = false
local winItemId = false
local pumpkinSleeping = 0
local fadeInSpeed = 3
local overallAlpha = 0
local overallTime = 0
local rotateEnded = false
local musicStart = false
local music = false
local music2 = false
local lastDistance = 0
local lastDistanceWay = false
function tryToStartPumpkinOpening(dbID)
  if not minigameStarted then
    triggerServerEvent("tryToStartPumpkinOpening", localPlayer, dbID)
  end
end
local lastBat = false
local bats = {}
local tecos, tesin = 0, 0
local ecos, esin = 0, 0
addEvent("startPumpkinOpening", true)
addEventHandler("startPumpkinOpening", getRootElement(), function(itemId, rnd1, rnd2, rnd3, rnd4, rnd5)
  if not minigameStarted then
    addEventHandler("onClientPreRender", getRootElement(), preRenderPumpkinOpen)
    addEventHandler("onClientRender", getRootElement(), renderPumpkinOpen)
    minigameStarted = true
  end
  bats = {}
  lastBat = 0
  itemList = {}
  itemEye = false
  targetAlpha = 0
  spinSpeed = 0
  targetSpinSpeed = rnd1
  spinAcceleration = rnd2
  spinDeceleration = rnd3
  spinStop = targetSpinSpeed / spinAcceleration * 1000 + rnd4
  spinMin = rnd5
  spinMin2 = 12.5
  winItem = itemId
  winItemId = false
  pumpkinSleeping = 6000
  fadeInSpeed = 3
  overallAlpha = 0
  local d = 384
  overallTime = 1 / fadeInSpeed * 1000 + pumpkinSleeping + spinStop + (targetSpinSpeed - spinMin) / spinDeceleration * 1000 + (d / spinMin * 7 + d / spinMin2) / 8 * 1000
  rotateEnded = false
  musicStart = false
  if isElement(music) then
    destroyElement(music)
  end
  music = false
  if isElement(music2) then
    destroyElement(music2)
  end
  music2 = false
  lastDistance = 0
  lastDistanceWay = false
  for i = 1, 25 do
  end
  local x = 0
  for i = 1, 13 do
    table.insert(itemList, {
      x,
      chooseFakeItem()
    })
    x = x + 64
  end
  itemList[1][3] = true
  musicStart = 750
  music = playSound("files/music.mp3", true)
  music2 = playSound("files/music2.mp3", true)
  setSoundVolume(music2, 0)
  tecos, tesin = 0, 0
  ecos, esin = 0, 0
  for i = 1, math.random(25, 30) do
    table.insert(bats, {
      screenX / 2 - 640 + 527.36,
      128.4,
      0.1 + 0.15 * math.random() - 0.075,
      math.random() > 0.5,
      math.random() * 16,
      math.random() * 1,
      0.3 + math.random() * 1,
      0,
      0
    })
  end
end)
function preRenderPumpkinOpen(delta)
  local now = getTickCount()
  local cx, cy = getCursorPosition()
  if cx then
    cx = cx * screenX
    cy = cy * screenY
  end
  if pumpkinSleeping <= 0 then
    local x = screenX / 2
    local ey = 231.5
    if itemEye and 0 < spinSpeed then
      local r = math.atan2(ey - 514, x - itemEye) + math.pi
      tecos = math.cos(r) * 8
      tesin = math.sin(r) * 8
    elseif cx then
      local r = math.atan2(ey - cy, x - cx) + math.pi
      tecos = math.cos(r) * 8
      tesin = math.sin(r) * 8
    end
  end
  if ecos < tecos then
    ecos = ecos + 40 * delta / 1000
    if ecos > tecos then
      ecos = tecos
    end
  elseif ecos > tecos then
    ecos = ecos - 40 * delta / 1000
    if ecos < tecos then
      ecos = tecos
    end
  end
  if esin < tesin then
    esin = esin + 40 * delta / 1000
    if esin > tesin then
      esin = tesin
    end
  elseif esin > tesin then
    esin = esin - 40 * delta / 1000
    if esin < tesin then
      esin = tesin
    end
  end
  local y = 472
  if 1000 < now - lastBat then
    lastBat = now + math.random() * 500 - 250
    table.insert(bats, {
      screenX / 2 - 640 + 527.36,
      128.4,
      0.2 + 0.15 * math.random() - 0.075,
      math.random() > 0.5,
      math.random() * 16,
      0.5 + math.random() * 0.65,
      0.5 + math.random() * 0.65,
      0,
      0
    })
  end
  for i = #bats, 1, -1 do
    local spdleft = bats[i][6]
    local spdtop = bats[i][7]
    bats[i][8] = bats[i][8] + 80 * delta / 1000 * spdtop
    bats[i][1] = bats[i][1] + 64 * spdleft * delta / 1000 * (bats[i][4] and 1 or -1)
    bats[i][2] = bats[i][2] + 64 * delta / 1000 - bats[i][8] * delta / 1000
    bats[i][3] = bats[i][3] + 0.25 * delta / 1000 * (spdleft + spdtop) / 2
    if bats[i][9] < 255 then
      bats[i][9] = bats[i][9] + 400 * delta / 1000 * (spdleft + spdtop) / 2
      if bats[i][9] > 255 then
        bats[i][9] = 255
      end
    end
    if 0 > bats[i][2] + 64 * bats[i][3] then
      table.remove(bats, i)
    end
  end
  if overallAlpha < 1 and not rotateEnded then
    overallAlpha = overallAlpha + fadeInSpeed * delta / 1000
    if 1 < overallAlpha then
      overallAlpha = 1
    end
  else
    if pumpkinSleeping <= 500 then
      targetAlpha = math.min(1, 1 - pumpkinSleeping / 500)
    end
    if musicStart and 0 < musicStart then
      musicStart = musicStart - delta
      if musicStart < 0 then
        musicStart = 0
      end
      setSoundVolume(music, 1 - musicStart / 750)
    end
    if 0 < pumpkinSleeping then
      pumpkinSleeping = pumpkinSleeping - delta
    else
      local md = 384
      local minX = md
      local foundEye = false
      if winItemId then
        local d = itemList[winItemId][1] - md
        if 0 <= d then
          spinSpeed = 0
          for i = 1, #itemList do
            itemList[i][1] = itemList[i][1] - d
          end
          if not rotateEnded then
            rotateEnded = now
          end
        else
          local p = math.min(1, -d / md * 2.25)
          spinSpeed = math.max(spinMin2, spinMin * p)
        end
      elseif spinStop < 0 then
        if spinSpeed > spinMin then
          spinSpeed = spinSpeed - spinDeceleration * delta / 1000
          if spinSpeed < spinMin then
            spinSpeed = spinMin
          end
        end
      else
        if spinSpeed < targetSpinSpeed then
          spinSpeed = spinSpeed + spinAcceleration * delta / 1000
          if spinSpeed > targetSpinSpeed then
            spinSpeed = targetSpinSpeed
          end
        end
        spinStop = spinStop - delta
      end
      for i = #itemList, 1, -1 do
        itemList[i][1] = itemList[i][1] + spinSpeed * delta / 1000
        minX = math.min(itemList[i][1], minX)
        if itemList[i][1] > md * 2 then
          if not winItemId then
            table.remove(itemList, i)
          end
        elseif itemList[i][3] then
          foundEye = true
          itemEye = screenX / 2 - md + itemList[i][1]
        end
      end
      minX = minX - 64
      if 0 < minX then
        if spinSpeed <= spinMin and not winItemId then
          table.insert(itemList, {minX, winItem})
          winItemId = #itemList
        else
          table.insert(itemList, {
            minX,
            chooseFakeItem()
          })
        end
        if not foundEye then
          itemList[#itemList][3] = true
        end
      end
    end
  end
  if rotateEnded then
    local d = now - rotateEnded
    if 10000 < d then
      overallAlpha = overallAlpha - fadeInSpeed * delta / 1000
      if overallAlpha < 0 then
        overallAlpha = 0
        removeEventHandler("onClientPreRender", getRootElement(), preRenderPumpkinOpen)
        removeEventHandler("onClientRender", getRootElement(), renderPumpkinOpen)
        minigameStarted = false
        if isElement(music) then
          destroyElement(music)
        end
        music = false
        if isElement(music2) then
          destroyElement(music2)
        end
        music2 = false
      else
        setSoundVolume(music, overallAlpha)
        setSoundVolume(music2, overallAlpha)
      end
    else
      local p = math.min(1, d / 500)
      setSoundVolume(music2, p)
    end
  end
end
local frame = 0
function renderPumpkinOpen()
  frame = frame + 0.5
  local now = getTickCount()
  local la2 = 0.5 + (math.cos(now * 0.0025) + 1) / 2 * 0.5
  local x, y = screenX / 2, 150
  local ix, iy = x - 250, y
  sightlangStaticImageUsed[0] = true
  if sightlangStaticImageToc[0] then
    processsightlangStaticImage[0]()
  end
  dxDrawImage(x - 640, 0, 1280, 600, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha))
  sightlangStaticImageUsed[1] = true
  if sightlangStaticImageToc[1] then
    processsightlangStaticImage[1]()
  end
  dxDrawImage(x - 640, 0, 1280, 600, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha))
  for i = 1, #bats do
    local f = math.floor((frame + bats[i][5]) % 16)
    local s = 128 * bats[i][3]
    local fx = f % 4
    local fy = math.floor(f / 4)
    local bx, by = bats[i][1], bats[i][2]
    local dir = bats[i][4]
    local a = bats[i][9] * overallAlpha
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImageSection(bx - s / 2 - s * (dir and 0 or 1), by - s / 2, (dir and 1 or -1) * s, s, fx * 128, fy * 128, 128, 128, sightlangStaticImage[2], 0, 0, 0, tocolor(0, 0, 0, a), false)
    sightlangStaticImageUsed[3] = true
    if sightlangStaticImageToc[3] then
      processsightlangStaticImage[3]()
    end
    dxDrawImageSection(bx - s / 2 - s * (dir and 0 or 1), by - s / 2, (dir and 1 or -1) * s, s, fx * 128, fy * 128, 128, 128, sightlangStaticImage[3], 0, 0, 0, tocolor(250, 40, 0, a), false)
  end
  local px, py = x - 175, iy + 120 - 175
  local ey = py + 136.5
  local la = 0
  local s2a = 0
  if pumpkinSleeping <= 0 then
    la = 1
  elseif pumpkinSleeping < 1000 then
    la = 1 - pumpkinSleeping / 1000
    s2a = 1 - la
  elseif pumpkinSleeping < 6000 then
    s2a = 1 - (pumpkinSleeping - 1000) / 5000
  end
  local sr = now % 4000 / 4000 * 360
  for i = 1, 2 do
    local fogP = (now + 5000 * i) % 10000 / 10000
    local a = math.sin(fogP * math.pi)
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImage(screenX / 2 - 600 * fogP, iy + 120 - 128, 600, 256, sightlangStaticImage[4], 0, 0, 0, tocolor(220, 220, 220, 200 * overallAlpha * a))
  end
  sightlangStaticImageUsed[5] = true
  if sightlangStaticImageToc[5] then
    processsightlangStaticImage[5]()
  end
  dxDrawImage(px, py, 350, 350, sightlangStaticImage[5], 0, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha))
  sightlangStaticImageUsed[6] = true
  if sightlangStaticImageToc[6] then
    processsightlangStaticImage[6]()
  end
  dxDrawImage(px, py, 350, 350, sightlangStaticImage[6], 0, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha * la))
  sightlangStaticImageUsed[7] = true
  if sightlangStaticImageToc[7] then
    processsightlangStaticImage[7]()
  end
  dxDrawImage(px + 119.00000000000001 - 50 + ecos, py + 136.5 - 50 + esin, 100, 100, sightlangStaticImage[7], -sr, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha * la))
  sightlangStaticImageUsed[7] = true
  if sightlangStaticImageToc[7] then
    processsightlangStaticImage[7]()
  end
  dxDrawImage(px + 230.99999999999997 - 50 + ecos + 100, py + 136.5 - 50 + esin, -100, 100, sightlangStaticImage[7], sr, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha * la))
  if 0 < s2a then
    sightlangStaticImageUsed[8] = true
    if sightlangStaticImageToc[8] then
      processsightlangStaticImage[8]()
    end
    dxDrawImage(px + 119.00000000000001 - 50 + ecos, py + 136.5 - 50 + esin, 100, 100, sightlangStaticImage[8], -sr, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha * s2a))
    sightlangStaticImageUsed[8] = true
    if sightlangStaticImageToc[8] then
      processsightlangStaticImage[8]()
    end
    dxDrawImage(px + 230.99999999999997 - 50 + ecos + 100, py + 136.5 - 50 + esin, -100, 100, sightlangStaticImage[8], sr, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha * s2a))
  end
  sightlangStaticImageUsed[9] = true
  if sightlangStaticImageToc[9] then
    processsightlangStaticImage[9]()
  end
  dxDrawImage(px, py, 350, 350, sightlangStaticImage[9], 0, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha))
  sightlangStaticImageUsed[10] = true
  if sightlangStaticImageToc[10] then
    processsightlangStaticImage[10]()
  end
  dxDrawImage(px, py, 350, 350, sightlangStaticImage[10], 0, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha * la * la2))
  sightlangStaticImageUsed[11] = true
  if sightlangStaticImageToc[11] then
    processsightlangStaticImage[11]()
  end
  dxDrawImage(x - 350, iy + 290 - 125, 700, 250, sightlangStaticImage[11], 0, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha))
  local md = 384
  x = x - md
  local nearestItemId = false
  local nearestD = md
  local rotateEndedP = 0
  if rotateEnded then
    rotateEndedP = math.min(1, (getTickCount() - rotateEnded) / 750)
  end
  for i = 1, #itemList do
    local x = x + itemList[i][1]
    local d = math.abs(x - screenX / 2) / md
    local a = math.min(255, 355 * (1 - d)) * (1 - rotateEndedP * 0.65) * overallAlpha
    if 0 < a then
      if nearestD > d then
        nearestD = d
        nearestItemId = itemList[i][2]
      end
      local s = 36 - 12 * d
      if goldItems[itemList[i][2]] and rotateEndedP < 1 then
        local gs = s * 1.8333333333333333
        sightlangStaticImageUsed[12] = true
        if sightlangStaticImageToc[12] then
          processsightlangStaticImage[12]()
        end
        dxDrawImage(x - gs / 2, iy + 290 - 125 + 199 - gs / 2, gs, gs, sightlangStaticImage[12], 0, 0, 0, tocolor(245, 206, 70, a * 0.75 * (1 - rotateEndedP)))
      end
      dxDrawImage(x - s / 2, iy + 290 - 125 + 199 - s / 2, s, s, ":sItems/files/items/" .. itemList[i][2] - 1 .. ".png", 0, 0, 0, tocolor(255, 255, 255, a))
    end
  end
  sightlangStaticImageUsed[13] = true
  if sightlangStaticImageToc[13] then
    processsightlangStaticImage[13]()
  end
  dxDrawImage(screenX / 2 - 24, iy + 290 - 125 + 199 - 24, 48, 48, sightlangStaticImage[13], 0, 0, 0, tocolor(255, 255, 255, 255 * targetAlpha * (1 - rotateEndedP)))
  if rotateEnded then
    local s = 100 + 300 * rotateEndedP
    if goldItems[winItem] then
      sightlangStaticImageUsed[14] = true
      if sightlangStaticImageToc[14] then
        processsightlangStaticImage[14]()
      end
      dxDrawImage(screenX / 2 - s / 2, iy + 290 - 125 + 199 - s / 2, s, s, sightlangStaticImage[14], getTickCount() / 40 % 360, 0, 0, tocolor(245, 206, 70, 255 * rotateEndedP * overallAlpha))
    else
      sightlangStaticImageUsed[14] = true
      if sightlangStaticImageToc[14] then
        processsightlangStaticImage[14]()
      end
      dxDrawImage(screenX / 2 - s / 2, iy + 290 - 125 + 199 - s / 2, s, s, sightlangStaticImage[14], getTickCount() / 40 % 360, 0, 0, tocolor(255, 255, 255, 255 * rotateEndedP * overallAlpha))
    end
    local s = 36 + 8 * rotateEndedP
    if goldItems[winItem] then
      local gs = s * 1.8333333333333333
      sightlangStaticImageUsed[12] = true
      if sightlangStaticImageToc[12] then
        processsightlangStaticImage[12]()
      end
      dxDrawImage(screenX / 2 - gs / 2, iy + 290 - 125 + 199 - gs / 2, gs, gs, sightlangStaticImage[12], 0, 0, 0, tocolor(245, 206, 70, 255 * overallAlpha))
    end
    dxDrawImage(screenX / 2 - s / 2, iy + 290 - 125 + 199 - s / 2, s, s, ":sItems/files/items/" .. winItem - 1 .. ".png", 0, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha))
  end
  local delta = nearestD - lastDistance
  lastDistance = nearestD
  local tmp = delta <= 0
  if lastDistanceWay ~= tmp then
    lastDistanceWay = tmp
    if tmp and 0 < spinSpeed then
      playSound("files/spin.mp3")
    end
  end
  if nearestItemId then
    local c = 64 / md
    local a = (0.5 - nearestD / c) / 0.5
    dxDrawText(pumpkinNames[nearestItemId], 1, iy + 290 - 125 + 230 + 1, screenX + 1, 0, tocolor(0, 0, 0, 150 * a * targetAlpha * overallAlpha), fontScale * (0.8 + rotateEndedP * 0.2), font, "center", "top")
    if goldItems[nearestItemId] then
      dxDrawText(pumpkinNames[nearestItemId], 0, iy + 290 - 125 + 230, screenX, 0, tocolor(245, 206, 70, 255 * a * targetAlpha * overallAlpha), fontScale * (0.8 + rotateEndedP * 0.2), font, "center", "top")
    else
      dxDrawText(pumpkinNames[nearestItemId], 0, iy + 290 - 125 + 230, screenX, 0, tocolor(255, 255, 255, 255 * a * targetAlpha * overallAlpha), fontScale * (0.8 + rotateEndedP * 0.2), font, "center", "top")
    end
  end
end
