local sightexports = {
  sModloader = false,
  sGui = false,
  sPattach = false
}
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
    sightlangStaticImage[0] = dxCreateTexture("files/bag.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/fade.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local btnBcg = false
local btnCol = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    btnBcg = sightexports.sGui:getColorCodeToColor("sightgrey1")
    btnCol = sightexports.sGui:getColorCodeToColor("sightgreen")
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local sightlangModloaderLoaded = function()
  modloaderListener()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderBagEffect, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderBagEffect)
    end
  end
end
local screenX, screenY = guiGetScreenSize()
local bagMode = false
local bagObjects = {}
local bagWields = {}
local objId = false
function modloaderListener()
  objId = sightexports.sModloader:getModelId("v4_burlap_sack")
  for client, object in pairs(bagObjects) do
    if isElement(object) then
      setElementModel(object, objId)
    end
  end
  for client, object in pairs(bagWields) do
    if isElement(object) then
      setElementModel(object, objId)
    end
  end
end
addEventHandler("onClientClick", getRootElement(), function(btn, state)
  if state == "up" and playerHover then
    triggerServerEvent("doBagPlayer", localPlayer, playerHover)
  end
end)
addEventHandler("onClientRender", getRootElement(), function()
  if isPedInVehicle(localPlayer) then
    if playerHover then
      sightexports.sGui:setCursorType("normal")
      sightexports.sGui:showTooltip()
      playerHover = false
    end
    return
  end
  local cx, cy = getCursorPosition()
  if cx then
    cx = cx * screenX
    cy = cy * screenY
  else
    if playerHover then
      sightexports.sGui:setCursorType("normal")
      sightexports.sGui:showTooltip()
      playerHover = false
    end
    return
  end
  local tmpPlayer = false
  local tmpVisz = false
  local x, y, z = getElementPosition(localPlayer)
  local players = getElementsByType("player", getRootElement(), true)
  for i = 1, #players do
    local client = players[i]
    if client ~= localPlayer then
      local px, py, pz = getPedBonePosition(client, 8)
      if px == px and py == py and pz == pz and (getDistanceBetweenPoints3D(x, y, z, px, py, pz) or 999) <= 2 then
        local x, y = getScreenFromWorldPosition(px, py, pz, 128)
        if x then
          if bagObjects[client] then
            dxDrawRectangle(x - 16, y - 16, 32, 32, btnBcg)
            if cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
              tmpPlayer = client
              tmpVisz = false
              sightlangStaticImageUsed[0] = true
              if sightlangStaticImageToc[0] then
                processsightlangStaticImage[0]()
              end
              dxDrawImage(x - 12, y - 12, 24, 24, sightlangStaticImage[0], 0, 0, 0, btnCol)
            else
              sightlangStaticImageUsed[0] = true
              if sightlangStaticImageToc[0] then
                processsightlangStaticImage[0]()
              end
              dxDrawImage(x - 12, y - 12, 24, 24, sightlangStaticImage[0])
            end
          elseif bagMode then
            dxDrawRectangle(x - 16, y - 16, 32, 32, btnBcg)
            if cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
              tmpPlayer = client
              tmpVisz = false
              sightlangStaticImageUsed[0] = true
              if sightlangStaticImageToc[0] then
                processsightlangStaticImage[0]()
              end
              dxDrawImage(x - 12, y - 12, 24, 24, sightlangStaticImage[0], 0, 0, 0, btnCol)
            else
              sightlangStaticImageUsed[0] = true
              if sightlangStaticImageToc[0] then
                processsightlangStaticImage[0]()
              end
              dxDrawImage(x - 12, y - 12, 24, 24, sightlangStaticImage[0])
            end
          end
        end
      end
    end
  end
  if tmpPlayer ~= playerHover then
    playerHover = tmpPlayer
    if playerHover then
      sightexports.sGui:setCursorType("link")
      if bagObjects[playerHover] then
        sightexports.sGui:showTooltip("Zsák levétele")
      else
        sightexports.sGui:showTooltip("Zsák ráhúzása")
      end
    else
      sightexports.sGui:setCursorType("normal")
      sightexports.sGui:showTooltip()
    end
  end
end)
function setBagMode(state)
  bagMode = state
  triggerServerEvent("processBagWield", localPlayer, state)
end
local bagChange = getTickCount()
local bagState = false
function renderBagEffect()
  local time = getTickCount() - bagChange
  local progress
  if bagState then
    progress = (getTickCount() - bagChange) / 800
  else
    progress = 1 - (getTickCount() - bagChange) / 800
  end
  progress = getEasingValue(math.max(math.min(progress, 1), 0), "OutQuad")
  dxDrawRectangle(0, 0, screenX, -128 + (screenY + 128) * progress, tocolor(0, 0, 0, 255))
  sightlangStaticImageUsed[1] = true
  if sightlangStaticImageToc[1] then
    processsightlangStaticImage[1]()
  end
  dxDrawImageSection(0, -128 + (screenY + 128) * progress - 16, screenX, 128, 0, 0, screenX, 128, sightlangStaticImage[1], 0, 0, 0, tocolor(0, 0, 0, 255))
  if progress == 0 and not bagState then
    sightlangCondHandl0(false)
  end
end
addEvent("setBagEffect", true)
addEventHandler("setBagEffect", getRootElement(), function(state)
  bagChange = getTickCount()
  bagState = state
  sightlangCondHandl0(true, "low-9")
end)
function getBagState()
  return bagState
end
local bagQ = {
  0.44214577883097,
  -0.53113912008666,
  -0.32544425242357,
  0.64535601332906
}
function processBagObject(player, state)
  if not state then
    if isElement(bagObjects[player]) then
      destroyElement(bagObjects[player])
    end
    bagObjects[player] = nil
    bagObjects[player] = nil
  elseif objId then
    bagObjects[player] = createObject(objId, 0, 0, 0)
    sightexports.sPattach:attach(bagObjects[player], player, 8, -0.010956378660147, -0.056919475022095, -0.032652539816318, 0, 0, 0)
    sightexports.sPattach:setRotationQuaternion(bagObjects[player], bagQ)
    setObjectScale(bagObjects[player], 1.2, 1.2, 1.2)
  end
end
local bagWieldQ = {
  0.74603372741722,
  -0.55551711504458,
  0.13616751367391,
  -0.34101733191787
}
function processBagWield(player)
  local data = getElementData(player, "bagWield")
  if data then
    if objId then
      bagWields[player] = createObject(objId, 0, 0, 0)
      sightexports.sPattach:attach(bagWields[player], player, 25, -0.056322265779161, -0.091659694702951, -0.017693201914203, 0, 0, 0)
      sightexports.sPattach:setRotationQuaternion(bagWields[player], bagWieldQ)
      setObjectScale(bagWields[player], 0.62763045756295, 1, 0.85229540297405)
    end
  elseif bagWields[player] then
    if isElement(bagWields[player]) then
      destroyElement(bagWields[player])
    end
    bagWields[player] = nil
    bagWields[player] = nil
  end
end
addEventHandler("onClientPlayerDataChange", getRootElement(), function(dataName, oldValue, newValue)
  if dataName == "bagged" then
    processBagObject(source, newValue)
    local x, y, z = getElementPosition(source)
    local int, dim = getElementInterior(source), getElementDimension(source)
    local sound = playSound3D(newValue and "files/maskon.wav" or "files/maskoff.wav", x, y, z, false)
    setElementInterior(sound, int)
    setElementDimension(sound, dim)
  elseif dataName == "bagWield" then
    processBagWield(source)
  end
end)
addEventHandler("onPlayerStreamIn", getRootElement(), function()
  local bagged = getElementData(source, "bagged")
  if bagged then
    processBagObject(source, bagged)
  end
  processBagWield(source)
end)
addEventHandler("onPlayerStreamOut", getRootElement(), function()
  if isElement(bagObjects[source]) then
    destroyElement(bagObjects[source])
  end
  bagObjects[source] = nil
  bagObjects[source] = nil
  if isElement(bagWields[source]) then
    destroyElement(bagWields[source])
  end
  bagWields[source] = nil
  bagWields[source] = nil
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
  if isElement(bagObjects[source]) then
    destroyElement(bagObjects[source])
  end
  bagObjects[source] = nil
  bagObjects[source] = nil
  if isElement(bagWields[source]) then
    destroyElement(bagWields[source])
  end
  bagWields[source] = nil
  bagWields[source] = nil
end)
