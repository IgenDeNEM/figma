local sightexports = {
  sGroups = false,
  sChat = false,
  sPermission = false,
  sGui = false,
  sHud = false
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
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] and sightlangStaticImageToc[9] and sightlangStaticImageToc[10] and sightlangStaticImageToc[11] and sightlangStaticImageToc[12] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/images/trash.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/images/lock1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/images/lock2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/images/background.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/images/colorPicker.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[5] = function()
  if not isElement(sightlangStaticImage[5]) then
    sightlangStaticImageToc[5] = false
    sightlangStaticImage[5] = dxCreateTexture("files/images/done.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[6] = function()
  if not isElement(sightlangStaticImage[6]) then
    sightlangStaticImageToc[6] = false
    sightlangStaticImage[6] = dxCreateTexture("files/images/light.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[7] = function()
  if not isElement(sightlangStaticImage[7]) then
    sightlangStaticImageToc[7] = false
    sightlangStaticImage[7] = dxCreateTexture("files/images/clear.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[8] = function()
  if not isElement(sightlangStaticImage[8]) then
    sightlangStaticImageToc[8] = false
    sightlangStaticImage[8] = dxCreateTexture("files/images/arrow_left.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[9] = function()
  if not isElement(sightlangStaticImage[9]) then
    sightlangStaticImageToc[9] = false
    sightlangStaticImage[9] = dxCreateTexture("files/images/arrow_right.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[10] = function()
  if not isElement(sightlangStaticImage[10]) then
    sightlangStaticImageToc[10] = false
    sightlangStaticImage[10] = dxCreateTexture("files/images/save.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[11] = function()
  if not isElement(sightlangStaticImage[11]) then
    sightlangStaticImageToc[11] = false
    sightlangStaticImage[11] = dxCreateTexture("files/images/palette.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[12] = function()
  if not isElement(sightlangStaticImage[12]) then
    sightlangStaticImageToc[12] = false
    sightlangStaticImage[12] = dxCreateTexture("files/images/brush.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sGroups")
    if res0 and getResourceState(res0) == "running" then
      recalcPermission()
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
local OpenSansSB = false
local red = false
local red2 = false
local green = false
local blue = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    OpenSansSB = sightexports.sGui:getFont("8/Ubuntu-R.ttf")
    red = sightexports.sGui:getColorCode("sightred")
    red2 = sightexports.sGui:getColorCode("sightred-second")
    green = sightexports.sGui:getColorCode("sightgreen")
    blue = sightexports.sGui:getColorCode("sightblue")
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderGClean, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderGClean)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderGInfo, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderGInfo)
    end
  end
end
local screenWidth, screenHeight = guiGetScreenSize()
local containerTable = {}
local indexFile = false
local indexTable = {}
local panelState = false
function reMap(x, in_min, in_max, out_min, out_max)
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end
local fontSizeMultipler = 1
local renderData = {}
renderData.panelWidth = 600
renderData.panelHeight = 500
renderData.panelPosX = screenWidth / 2 - renderData.panelWidth / 2
renderData.panelPosY = screenHeight / 2 - renderData.panelHeight / 2
renderData.paintAreaWidth = 580
renderData.paintAreaHeight = 360
renderData.paintAreaPosX = renderData.panelPosX + 10
renderData.paintAreaPosY = renderData.panelPosY + 40
local paintArea = false
local paintPixels = ""
local previousX, previousY = 0, 0
local brushSize = 4
local editBrushSize = false
local minimumBrushSize = 1
local maximumBrushSize = 24
local isDrawing = false
local undoHistory = {}
local maximumUndoSteps = 10
local currentUndoStep = 1
local activeButton = false
local buttons = {}
local emptyPaintArea = ""
local paletteColors = {
  tocolor(0, 0, 0, 255),
  tocolor(255, 255, 255, 255),
  tocolor(0, 118, 180, 255),
  tocolor(11, 63, 111, 255),
  tocolor(215, 89, 89, 255),
  tocolor(76, 26, 44, 255),
  tocolor(105, 186, 72, 255),
  tocolor(1, 66, 39, 255),
  tocolor(110, 106, 97, 255),
  tocolor(246, 75, 29, 255)
}
local selectedColor = 1
local activeMenu = "none"
local currentLuminance = 127.5
local colorH, colorS, colorL = 0.5, 0.5, 0.5
local finishedTexture = false
local savedGraffiti = {}
local serverGraffiti = {}
local graffitiTextures = {}
local selectedGraffiti = false
local debugMode = false
local tempTexture = false
local maximumRenderDistance = 30
local maximumCleanDistance = 3
local streamThread = false
local defaultScale = 1
local minScale = 0.17
local scaleMultipler = (screenWidth + 1920) / 3840
local button3D = {}
local active3DButton = false
local graffitiClean = false
local allowedToSpray = false
function recalcPermission()
  allowedToSpray = sightexports.sGroups:getPlayerPermission("graffiti")
end
addEventHandler("onClientResourceStart", getRootElement(), function(resourceElement)
  if source == getResourceRootElement() then
    savedGraffiti = {}
    if fileExists("local.json") then
      local indexFile = fileOpen("local.json")
      if indexFile then
        local indexContent = fileRead(indexFile, fileGetSize(indexFile))
        savedGraffiti = fromJSON(indexContent) or {}
        fileClose(indexFile)
        indexContent = nil
        collectgarbage("collect")
      end
    end
    serverGraffiti = {}
    if fileExists("server.json") then
      local indexFile = fileOpen("server.json")
      if indexFile then
        local indexContent = fileRead(indexFile, fileGetSize(indexFile))
        serverGraffiti = processJson(fromJSON(indexContent)) or {}
        fileClose(indexFile)
        indexContent = nil
        collectgarbage("collect")
      end
    end
    for k, v in pairs(serverGraffiti) do
      if fileExists("files/server_graffiti/" .. v.fileName .. ".png") then
        graffitiTextures[v.fileName] = dxCreateTexture("files/server_graffiti/" .. v.fileName .. ".png", "dxt3")
      end
    end
    streamThread = coroutine.create(streamGraffiti)
    paintArea = dxCreateRenderTarget(renderData.paintAreaWidth, renderData.paintAreaHeight, true)
    if isElement(paintArea) then
      panelState = false
      debugMode = true
      local currentPixels = dxGetTexturePixels(paintArea)
      if currentPixels then
        table.insert(undoHistory, 1, currentPixels)
        currentUndoStep = 1
        emptyPaintArea = currentPixels
        paintPixels = currentPixels
      end
    end
    setTimer(triggerServerEvent, 1000, 1, "requestGraffitiList", localPlayer)
  end
end)
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  if isElement(paintArea) then
    destroyElement(paintArea)
  end
  if fileExists("local.json") then
    fileDelete("local.json")
  end
  local indexFile = fileCreate("local.json")
  if indexFile then
    local jsonData = toJSON(savedGraffiti)
    fileWrite(indexFile, jsonData)
    fileClose(indexFile)
  end
  if fileExists("server.json") then
    fileDelete("server.json")
  end
  local indexFile = fileCreate("server.json")
  if indexFile then
    local jsonData = toJSON(serverGraffiti)
    fileWrite(indexFile, jsonData)
    fileClose(indexFile)
  end
end)
addEventHandler("onClientElementDataChange", localPlayer, function(dataName, oldValue)
  if dataName == "graffitiClean" then
    graffitiClean = getElementData(localPlayer, "graffitiClean")
  end
end)
local visibleGraffiti = {}
function streamGraffiti()
  while true do
    local updated = 0
    local cameraX, cameraY, cameraZ = getCameraMatrix()
    local lInt, lDim = getElementInterior(localPlayer), getElementDimension(localPlayer)
    for k, v in pairs(serverGraffiti) do
      local positionX, positionY, positionZ = v.x1 - cameraX, v.y1 - cameraY, v.z1 - cameraZ
      local currentDistance = positionX * positionX + positionY * positionY + positionZ * positionZ
      local visibleDistance = v.size * maximumRenderDistance
      local intDimCheck = false
      local int, dim = v.int, v.dim
      if int == lInt and dim == lDim then
        intDimCheck = true
      end
      if visibleGraffiti[v.fileName] then
        if currentDistance > visibleDistance * visibleDistance then
          visibleGraffiti[v.fileName] = nil
        end
        if not intDimCheck then
          visibleGraffiti[v.fileName] = nil
        end
      elseif intDimCheck and currentDistance <= visibleDistance * visibleDistance then
        visibleGraffiti[v.fileName] = true
      end
      updated = updated + 1
      if updated == 64 then
        coroutine.yield()
        updated = 0
        cameraX, cameraY, cameraZ = getCameraMatrix()
      end
    end
    coroutine.yield()
  end
end
local sprayX, sprayY, sprayZ = 0, 0, 0
local sprayHit = false
local sprayPercentage = 0
local sprayComplete = false
local sprayPositions = false
local lastTick = 0
addEventHandler("onClientPlayerWeaponSwitch", localPlayer, function(oldWeapon, newWeapon)
  if getPedWeapon(localPlayer, newWeapon) == 41 then
    allowedToSpray = sightexports.sGroups:getPlayerPermission("graffiti")
  end
end)
addEventHandler("onClientPlayerWeaponFire", localPlayer, function(weapon, ammo, ammoInClip, hitX_, hitY_, hitZ_, hitElement)
  if weapon == 41 then
    if selectedGraffiti and not sprayHit and not graffitiClean and allowedToSpray then
      if lastTick + 1000 <= getTickCount() then
        sprayX, sprayY, sprayZ = hitX_, hitY_, hitZ_
        local boneX, boneY, boneZ = getPedBonePosition(localPlayer, 23)
        local hitX, hitY, hitZ = sprayX - boneX, sprayY - boneY, sprayZ - boneZ
        local hitDistance = 2 / math.sqrt(hitX * hitX + hitY * hitY + hitZ * hitZ)
        hitX, hitY, hitZ = hitX * hitDistance, hitY * hitDistance, hitZ * hitDistance
        local wall, worldX, worldY, worldZ, hitElement, normalX, normalY, normalZ = processLineOfSight(boneX, boneY, boneZ, boneX + hitX, boneY + hitY, boneZ + hitZ, true, true, false, true, false, false, false, false)
        if wall then
          local size = 2
          local xx, xy, xz, yx, yy, yz
          do
            local screenWidth, screenHeight = screenWidth * 0.5, screenHeight * 0.5
            local x1, y1, z1 = getWorldFromScreenPosition(screenWidth, screenHeight, 1)
            local cux, cuy, cuz = getWorldFromScreenPosition(screenWidth, 0, 1)
            cux, cuy, cuz = cux - x1, cuy - y1, cuz - z1
            xx, xy, xz = normalY * cuz - normalZ * cuy, normalZ * cux - normalX * cuz, normalX * cuy - normalY * cux
            yx, yy, yz = xy * normalZ - xz * normalY, xz * normalX - xx * normalZ, xx * normalY - xy * normalX
          end
          local xlen = size * 0.5 / math.sqrt(xx * xx + xy * xy + xz * xz)
          local ylen = size * 0.5 / math.sqrt(yx * yx + yy * yy + yz * yz)
          xx, xy, xz = xx * xlen, xy * xlen, xz * xlen
          yx, yy, yz = yx * ylen, yy * ylen, yz * ylen
          local cx, cy, cz = worldX + normalX, worldY + normalY, worldZ + normalZ
          local bx, by, bz = worldX - normalX * 0.01, worldY - normalY * 0.01, worldZ - normalZ * 0.01
          local col, x, y, z, hit
          col, x, y, z, hit = processLineOfSight(cx, cy, cz, bx + xx + yx, by + xy + yy, bz + xz + yz, true, true, false, true, false, false, false, false)
          if not col or hit ~= hitElement then
            return
          end
          col, x, y, z, hit = processLineOfSight(cx, cy, cz, bx + xx - yx, by + xy - yy, bz + xz - yz, true, true, false, true, false, false, false, false)
          if not col or hit ~= hitElement then
            return
          end
          col, x, y, z, hit = processLineOfSight(cx, cy, cz, bx - xx + yx, by - xy + yy, bz - xz + yz, true, true, false, true, false, false, false, false)
          if not col or hit ~= hitElement then
            return
          end
          col, x, y, z, hit = processLineOfSight(cx, cy, cz, bx - xx - yx, by - xy - yy, bz - xz - yz, true, true, false, true, false, false, false, false)
          if not col or hit ~= hitElement then
            return
          end
          local fx, fy, fz = worldX + normalX * 0.01, worldY + normalY * 0.01, worldZ + normalZ * 0.01
          if not isLineOfSightClear(cx, cy, cz, fx + xx + yx, fy + xy + yy, fz + xz + yz, true, true, false, true, false, true, false) then
            return
          end
          if not isLineOfSightClear(cx, cy, cz, fx + xx - yx, fy + xy - yy, fz + xz - yz, true, true, false, true, false, true, false) then
            return
          end
          if not isLineOfSightClear(cx, cy, cz, fx - xx + yx, fy - xy + yy, fz - xz + yz, true, true, false, true, false, true, false) then
            return
          end
          if not isLineOfSightClear(cx, cy, cz, fx - xx - yx, fy - xy - yy, fz - xz - yz, true, true, false, true, false, true, false) then
            return
          end
          local normalDistance = 1 / math.sqrt(normalX * normalX + normalY * normalY + normalZ * normalZ)
          normalX, normalY, normalZ, normalDistance = normalX * normalDistance, normalY * normalDistance, normalZ * normalDistance, 1
          local firstOffset = normalDistance * 0.01
          local secondOffset = normalDistance * 0.04
          local x1, y1, z1 = worldX + normalX * firstOffset + yx, worldY + normalY * firstOffset + yy, worldZ + normalZ * firstOffset + yz
          local x2, y2, z2 = worldX + normalX * secondOffset - yx, worldY + normalY * secondOffset - yy, worldZ + normalZ * secondOffset - yz
          local visibility = 100
          sprayPositions = {
            x1,
            y1,
            z1,
            x2,
            y2,
            z2,
            x1 + normalX,
            y1 + normalY,
            z1 + normalZ,
            size,
            worldX,
            worldY,
            worldZ
          }
          tempTexture = dxCreateTexture(selectedGraffiti, "dxt3")
          sprayHit = true
          sightexports.sChat:localActionC(localPlayer, "elkezd felfújni egy graffit.")
          lastTick = getTickCount()
        end
      end
    elseif selectedGraffiti and sprayHit and not sprayComplete and sprayPositions and not graffitiClean then
      local positionX, positionY, positionZ = getElementPosition(localPlayer)
      if getDistanceBetweenPoints3D(positionX, positionY, positionZ, sprayPositions[1], sprayPositions[2], sprayPositions[3]) <= 3 then
        sprayPercentage = sprayPercentage + 0.5
        if 100 <= sprayPercentage then
          sprayComplete = true
          local dataContainer = {
            size = sprayPositions[10],
            int = getElementInterior(localPlayer),
            dim = getElementDimension(localPlayer),
            x1 = sprayPositions[1],
            y1 = sprayPositions[2],
            z1 = sprayPositions[3],
            x2 = sprayPositions[4],
            y2 = sprayPositions[5],
            z2 = sprayPositions[6],
            x3 = sprayPositions[7],
            y3 = sprayPositions[8],
            z3 = sprayPositions[9],
            cx = sprayPositions[11],
            cy = sprayPositions[12],
            cz = sprayPositions[13]
          }
          triggerServerEvent("createGraffiti", localPlayer, selectedGraffiti, dataContainer)
          sightexports.sChat:localActionC(localPlayer, "befejezte a graffiti felfújását.")
        end
      end
    end
  end
end)
local statusWidth = 400
local statusHeight = 22
local statusPosX = screenWidth / 2 - statusWidth / 2
local statusPosY = 0
local adminMode = false
local cleanTime = 10000
local cleanTimer = false
addEventHandler("onClientPreRender", getRootElement(), function()
  coroutine.resume(streamThread)
  for k, v in pairs(visibleGraffiti) do
    local data = serverGraffiti[k]
    if data and graffitiTextures[data.fileName] then
      dxDrawMaterialLine3D(data.x1, data.y1, data.z1, data.x2, data.y2, data.z2, graffitiTextures[data.fileName], data.size, tocolor(255, 255, 255, 128), data.x3, data.y3, data.z3)
    end
  end
end)
local canProtect = false
addEventHandler("onClientRender", getRootElement(), function()
  if tempTexture and sprayPositions then
    dxDrawMaterialLine3D(sprayPositions[1], sprayPositions[2], sprayPositions[3], reMap(sprayPercentage, 0, 100, sprayPositions[1], sprayPositions[4]), reMap(sprayPercentage, 0, 100, sprayPositions[2], sprayPositions[5]), reMap(sprayPercentage, 0, 100, sprayPositions[3], sprayPositions[6]), tempTexture, reMap(sprayPercentage, 0, 100, 0, sprayPositions[10]), tocolor(255, 255, 255, 128), sprayPositions[7], sprayPositions[8], sprayPositions[9])
    local positionX, positionY, positionZ = getElementPosition(localPlayer)
    if 3 >= getDistanceBetweenPoints3D(positionX, positionY, positionZ, sprayPositions[1], sprayPositions[2], sprayPositions[3]) then
      dxDrawRectangle(statusPosX, statusPosY, statusWidth, statusHeight, tocolor(0, 0, 0, 160))
      dxDrawRectangle(statusPosX, statusPosY + statusHeight - 2, statusWidth, 2, tocolor(0, 0, 0, 200))
      dxDrawRectangle(statusPosX, statusPosY + 2, 2, statusHeight - 4, tocolor(0, 0, 0, 200))
      dxDrawRectangle(statusPosX + statusWidth - 2, statusPosY + 2, 2, statusHeight - 4, tocolor(0, 0, 0, 200))
      dxDrawRectangle(statusPosX, statusPosY, reMap(sprayPercentage, 0, 100, 0, statusWidth), statusHeight, tocolor(green[1], green[2], green[3], 160))
      dxDrawText("Fújás: " .. math.floor(sprayPercentage) .. "%", statusPosX, statusPosY, statusPosX + statusWidth, statusPosY + statusHeight, tocolor(255, 255, 255, 255), 1, OpenSansSB, "center", "center", false, false, false, true, true)
    end
  end
end)
addEvent("protectGraffiti", true)
addEventHandler("protectGraffiti", getRootElement(), function(fileName, state)
  serverGraffiti[fileName].protected = state
end)
function renderGInfo()
  local camX, camY, camZ, lookX, lookY, lookZ = getCameraMatrix()
  local cursorX, cursorY = getCursorPosition()
  button3D = {}
  for k, v in pairs(visibleGraffiti) do
    local data = serverGraffiti[k]
    if data and graffitiTextures[data.fileName] then
      local worldX, worldY = getScreenFromWorldPosition(data.cx, data.cy, data.cz + 0.38, 0, false)
      if worldX and worldY then
        local currentDistance = getDistanceBetweenPoints3D(camX, camY, camZ, data.cx, data.cy, data.cz)
        if currentDistance <= maximumRenderDistance then
          local scaleProgress = currentDistance / maximumRenderDistance
          local scale = interpolateBetween(defaultScale, 0, 0, minScale, 0, 0, scaleProgress, "OutQuad")
          local textScale = scale * scaleMultipler
          local distance = currentDistance - maximumRenderDistance / 3
          local optimalDistance = maximumRenderDistance - maximumRenderDistance / 3
          if distance < 0 then
            distance = 0
          end
          local alphaProgress = distance / optimalDistance
          local textAlpha = interpolateBetween(255, 0, 0, 0, 0, 0, alphaProgress, "Linear")
          local timeData = getRealTime(data.fileName)
          local timeText = timeData.year + 1900 .. "/" .. timeData.month + 1 .. "/" .. timeData.monthday .. " " .. timeData.hour .. ":" .. timeData.minute .. ":" .. timeData.second
          local visibleText = data.characterName .. " (" .. data.characterId .. ")\n" .. timeText
          local minusX = 0
          if data.protected then
            visibleText = visibleText .. [=[

[PROTECTED]]=]
          end
          if visibleText then
            local textWidth = dxGetTextWidth(visibleText:gsub("#%x%x%x%x%x%x", ""), textScale, OpenSansSB)
            local textPosX = worldX - textWidth / 2
            if textPosX then
              dxDrawText(visibleText, textPosX + 1, worldY + 1, 100, 100, tocolor(0, 0, 0, textAlpha), textScale, OpenSansSB, "left", "top", false, false, false, true, true)
              dxDrawText(visibleText, textPosX, worldY, 100, 100, tocolor(255, 255, 255, textAlpha), textScale, OpenSansSB, "left", "top", false, false, false, true, true)
              if scaleProgress < 1 then
                local scale = interpolateBetween(0.85, 0, 0, 0.15, 0, 0, scaleProgress, "OutQuad")
                local trashWidth = scale * 64
                local trashHeight = scale * 64
                if not data.protected then
                  minusX = trashWidth * 0.39
                end
                local trashAlpha = textAlpha - 100
                if trashAlpha < 0 then
                  trashAlpha = 0
                end
                trashPosX = textPosX - trashWidth
                trashPosY = worldY
                if isCursorWithinArea_Size(cursorX, cursorY, trashPosX, trashPosY, trashWidth, trashHeight) then
                  sightlangStaticImageUsed[0] = true
                  if sightlangStaticImageToc[0] then
                    processsightlangStaticImage[0]()
                  end
                  dxDrawImage(trashPosX + 1, trashPosY + 1, trashWidth, trashHeight, sightlangStaticImage[0], 0, 0, 0, tocolor(0, 0, 0, trashAlpha))
                  sightlangStaticImageUsed[0] = true
                  if sightlangStaticImageToc[0] then
                    processsightlangStaticImage[0]()
                  end
                  dxDrawImage(trashPosX, trashPosY, trashWidth, trashHeight, sightlangStaticImage[0], 0, 0, 0, tocolor(red2[1], red2[2], red2[3], trashAlpha))
                else
                  sightlangStaticImageUsed[0] = true
                  if sightlangStaticImageToc[0] then
                    processsightlangStaticImage[0]()
                  end
                  dxDrawImage(trashPosX + 1, trashPosY + 1, trashWidth, trashHeight, sightlangStaticImage[0], 0, 0, 0, tocolor(0, 0, 0, trashAlpha))
                  sightlangStaticImageUsed[0] = true
                  if sightlangStaticImageToc[0] then
                    processsightlangStaticImage[0]()
                  end
                  dxDrawImage(trashPosX, trashPosY, trashWidth, trashHeight, sightlangStaticImage[0], 0, 0, 0, tocolor(red[1], red[2], red[3], trashAlpha))
                end
                button3D["trash|" .. data.fileName] = {
                  trashPosX,
                  trashPosY,
                  trashPosX + trashWidth,
                  trashPosY + trashHeight
                }
                if canProtect then
                  local trashPosX = trashPosX - trashWidth
                  if isCursorWithinArea_Size(cursorX, cursorY, trashPosX, trashPosY, trashWidth, trashHeight) then
                    if minusX == 0 then
                      minusX = trashWidth * 0.39
                    else
                      minusX = 0
                    end
                    sightlangStaticImageUsed[1] = true
                    if sightlangStaticImageToc[1] then
                      processsightlangStaticImage[1]()
                    end
                    dxDrawImage(trashPosX + 1, trashPosY + 1, trashWidth, trashHeight, sightlangStaticImage[1], 0, 0, 0, tocolor(0, 0, 0, trashAlpha))
                    sightlangStaticImageUsed[2] = true
                    if sightlangStaticImageToc[2] then
                      processsightlangStaticImage[2]()
                    end
                    dxDrawImage(trashPosX - minusX + 1, trashPosY + 1, trashWidth, trashHeight, sightlangStaticImage[2], 0, 0, 0, tocolor(0, 0, 0, trashAlpha))
                    sightlangStaticImageUsed[1] = true
                    if sightlangStaticImageToc[1] then
                      processsightlangStaticImage[1]()
                    end
                    dxDrawImage(trashPosX, trashPosY, trashWidth, trashHeight, sightlangStaticImage[1], 0, 0, 0, tocolor(green[1], green[2], green[3], trashAlpha))
                    sightlangStaticImageUsed[2] = true
                    if sightlangStaticImageToc[2] then
                      processsightlangStaticImage[2]()
                    end
                    dxDrawImage(trashPosX - minusX, trashPosY, trashWidth, trashHeight, sightlangStaticImage[2], 0, 0, 0, tocolor(green[1], green[2], green[3], trashAlpha))
                  else
                    sightlangStaticImageUsed[1] = true
                    if sightlangStaticImageToc[1] then
                      processsightlangStaticImage[1]()
                    end
                    dxDrawImage(trashPosX + 1, trashPosY + 1, trashWidth, trashHeight, sightlangStaticImage[1], 0, 0, 0, tocolor(0, 0, 0, trashAlpha))
                    sightlangStaticImageUsed[2] = true
                    if sightlangStaticImageToc[2] then
                      processsightlangStaticImage[2]()
                    end
                    dxDrawImage(trashPosX - minusX + 1, trashPosY + 1, trashWidth, trashHeight, sightlangStaticImage[2], 0, 0, 0, tocolor(0, 0, 0, trashAlpha))
                    sightlangStaticImageUsed[1] = true
                    if sightlangStaticImageToc[1] then
                      processsightlangStaticImage[1]()
                    end
                    dxDrawImage(trashPosX, trashPosY, trashWidth, trashHeight, sightlangStaticImage[1], 0, 0, 0, tocolor(red[1], red[2], red[3], trashAlpha))
                    sightlangStaticImageUsed[2] = true
                    if sightlangStaticImageToc[2] then
                      processsightlangStaticImage[2]()
                    end
                    dxDrawImage(trashPosX - minusX, trashPosY, trashWidth, trashHeight, sightlangStaticImage[2], 0, 0, 0, tocolor(red[1], red[2], red[3], trashAlpha))
                  end
                  button3D["protect|" .. data.fileName] = {
                    trashPosX,
                    trashPosY,
                    trashPosX + trashWidth,
                    trashPosY + trashHeight
                  }
                end
              end
            end
          end
        end
      end
    end
  end
  active3DButton = false
  for k, v in pairs(button3D) do
    if cursorX >= v[1] and cursorY >= v[2] and cursorX <= v[3] and cursorY <= v[4] then
      active3DButton = k
      break
    end
  end
end
addCommandHandler("ginfo", function()
  if sightexports.sPermission:hasPermission(localPlayer, "adminDeleteGraffiti") then
    canProtect = false
    if sightexports.sPermission:hasPermission(localPlayer, "protectGraffiti") then
      canProtect = true
    end
    adminMode = not adminMode
    sightlangCondHandl0(adminMode)
  end
end)
function renderGClean()
  local camX, camY, camZ, lookX, lookY, lookZ = getCameraMatrix()
  local cursorX, cursorY = getCursorPosition()
  local positionX, positionY, positionZ = getElementPosition(localPlayer)
  button3D = {}
  for k, v in pairs(visibleGraffiti) do
    local data = serverGraffiti[k]
    if data and graffitiTextures[data.fileName] then
      local worldX, worldY = getScreenFromWorldPosition(data.cx, data.cy, data.cz + 0.38, 0, false)
      if worldX and worldY then
        local currentDistance = getDistanceBetweenPoints3D(positionX, positionY, positionZ, data.cx, data.cy, data.cz)
        if currentDistance <= maximumCleanDistance then
          local scaleProgress = currentDistance / maximumRenderDistance
          local scale = interpolateBetween(defaultScale, 0, 0, minScale, 0, 0, scaleProgress, "OutQuad")
          local textScale = scale * scaleMultipler
          local distance = currentDistance - maximumRenderDistance / 3
          local optimalDistance = maximumRenderDistance - maximumRenderDistance / 3
          if distance < 0 then
            distance = 0
          end
          local alphaProgress = distance / optimalDistance
          local textAlpha = interpolateBetween(255, 0, 0, 0, 0, 0, alphaProgress, "Linear")
          if scaleProgress < 1 then
            local scale = interpolateBetween(0.85, 0, 0, 0.15, 0, 0, scaleProgress, "OutQuad")
            local trashWidth = scale * 64
            local trashHeight = scale * 64
            local trashAlpha = textAlpha - 100
            if trashAlpha < 0 then
              trashAlpha = 0
            end
            trashPosX = worldX - trashWidth / 2
            trashPosY = worldY
            if isCursorWithinArea_Size(cursorX, cursorY, trashPosX, trashPosY, trashWidth, trashHeight) then
              sightlangStaticImageUsed[0] = true
              if sightlangStaticImageToc[0] then
                processsightlangStaticImage[0]()
              end
              dxDrawImage(trashPosX + 1, trashPosY + 1, trashWidth, trashHeight, sightlangStaticImage[0], 0, 0, 0, tocolor(0, 0, 0, trashAlpha))
              sightlangStaticImageUsed[0] = true
              if sightlangStaticImageToc[0] then
                processsightlangStaticImage[0]()
              end
              dxDrawImage(trashPosX, trashPosY, trashWidth, trashHeight, sightlangStaticImage[0], 0, 0, 0, tocolor(green[1], green[2], green[3], trashAlpha))
            else
              sightlangStaticImageUsed[0] = true
              if sightlangStaticImageToc[0] then
                processsightlangStaticImage[0]()
              end
              dxDrawImage(trashPosX + 1, trashPosY + 1, trashWidth, trashHeight, sightlangStaticImage[0], 0, 0, 0, tocolor(0, 0, 0, trashAlpha))
              sightlangStaticImageUsed[0] = true
              if sightlangStaticImageToc[0] then
                processsightlangStaticImage[0]()
              end
              dxDrawImage(trashPosX, trashPosY, trashWidth, trashHeight, sightlangStaticImage[0], 0, 0, 0, tocolor(green[1], green[2], green[3], trashAlpha))
            end
            button3D["clean|" .. data.fileName] = {
              trashPosX,
              trashPosY,
              trashPosX + trashWidth,
              trashPosY + trashHeight
            }
          end
        end
      end
    end
  end
  active3DButton = false
  for k, v in pairs(button3D) do
    if cursorX >= v[1] and cursorY >= v[2] and cursorX <= v[3] and cursorY <= v[4] then
      active3DButton = k
      break
    end
  end
  if cleanTimer then
    local timerMs, _, _ = getTimerDetails(cleanTimer)
    dxDrawRectangle(statusPosX, statusPosY, statusWidth, statusHeight, tocolor(0, 0, 0, 160))
    dxDrawRectangle(statusPosX, statusPosY + statusHeight - 2, statusWidth, 2, tocolor(0, 0, 0, 200))
    dxDrawRectangle(statusPosX, statusPosY + 2, 2, statusHeight - 4, tocolor(0, 0, 0, 200))
    dxDrawRectangle(statusPosX + statusWidth - 2, statusPosY + 2, 2, statusHeight - 4, tocolor(0, 0, 0, 200))
    local time = cleanTime - timerMs
    dxDrawRectangle(statusPosX, statusPosY, reMap(time, 0, cleanTime, 0, statusWidth), statusHeight, tocolor(green[1], green[2], green[3], 160))
    dxDrawText("Tisztítás: " .. math.floor(reMap(time, 0, cleanTime, 0, 100)) .. "%", statusPosX, statusPosY, statusPosX + statusWidth, statusPosY + statusHeight, tocolor(255, 255, 255, 255), 1, OpenSansSB, "center", "center", false, false, false, true, true)
  end
end
function gCleanMode()
  if graffitiClean then
    graffitiClean = false
    sightexports.sGui:showInfobox("s", "Kikapcsoltad a graffiti tisztítás módot.")
  elseif getPedWeapon(localPlayer) == 41 then
    if sightexports.sGroups:getPlayerPermission("graffitiClean") then
      graffitiClean = true
      sightexports.sGui:showInfobox("s", "Bekapcsoltad a graffiti tisztítás módot.")
    else
      sightexports.sGui:showInfobox("e", "Nem használhatod ezt a parancsot.")
    end
  else
    sightexports.sGui:showInfobox("e", "A tisztitáshoz egy spray can-nek kell a kezedben lennie.")
  end
  sightlangCondHandl1(graffitiClean)
end
addCommandHandler("gclean", gCleanMode)
addCommandHandler("tisztitas", gCleanMode)
addCommandHandler("tisztítas", gCleanMode)
addEvent("requestGraffitiList", true)
addEventHandler("requestGraffitiList", getRootElement(), function(graffitiList)
  if graffitiList then
    local clientList = {}
    for k, v in pairs(graffitiList) do
      local found = false
      for m, n in pairs(serverGraffiti) do
        if v.fileName == n.fileName and fileExists("files/server_graffiti/" .. v.fileName .. ".png") then
          found = true
          break
        end
      end
      if not found then
        table.insert(clientList, v.fileName)
      end
    end
    triggerServerEvent("requestGraffiti", localPlayer, clientList)
    for k, v in pairs(serverGraffiti) do
      local found = false
      for m, n in pairs(graffitiList) do
        if v.fileName == n.fileName then
          found = true
          break
        end
      end
      if not found then
        if fileExists("files/server_graffiti/" .. v.fileName .. ".png") then
          fileDelete("files/server_graffiti/" .. v.fileName .. ".png")
        end
        serverGraffiti[v.fileName] = nil
      end
    end
  end
end)
addEvent("requestGraffiti", true)
addEventHandler("requestGraffiti", getRootElement(), function(graffitiContainer)
  if graffitiContainer then
    for k, v in pairs(graffitiContainer) do
      local convertedFile = fileCreate("files/server_graffiti/" .. v[2].fileName .. ".png")
      if convertedFile then
        fileWrite(convertedFile, v[1])
        fileClose(convertedFile)
        serverGraffiti[v[2].fileName] = v[2]
        graffitiTextures[v[2].fileName] = dxCreateTexture("files/server_graffiti/" .. v[2].fileName .. ".png", "dxt3")
      end
    end
  end
end)
addEventHandler("onClientMinimize", getRootElement(), function()
  if panelState and isElement(paintArea) then
    paintPixels = dxGetTexturePixels(paintArea)
  end
end)
addEventHandler("onClientRestore", getRootElement(), function(didClearRenderTargets)
  if didClearRenderTargets and panelState then
    dxSetTexturePixels(paintArea, paintPixels)
  end
end)
local graffitiWindow
function closePanel()
  isDrawing = false
  activeMenu = "none"
  panelState = false
  sightexports.sHud:setHudEnabled(true, 0)
  if graffitiWindow then
    sightexports.sGui:deleteGuiElement(graffitiWindow)
  end
  graffitiWindow = nil
  removeEventHandler("onClientRender", getRootElement(), renderGraffiti)
end
addEvent("closeGraffitiPanel")
addEventHandler("closeGraffitiPanel", getRootElement(), closePanel)
function showGraffitiWindow(state)
  if state then
    if graffitiWindow then
      sightexports.sGui:deleteGuiElement(graffitiWindow)
    end
    graffitiWindow = nil
    graffitiWindow = sightexports.sGui:createGuiElement("window", renderData.panelPosX, renderData.panelPosY, renderData.panelWidth, renderData.panelHeight)
    sightexports.sGui:setGuiBackground(graffitiWindow, "solid", "sightgrey1")
    sightexports.sGui:setWindowTitle(graffitiWindow, "16/BebasNeueRegular.otf", "Graffiti")
    sightexports.sGui:setWindowCloseButton(graffitiWindow, "closeGraffitiPanel")
  end
end
addEventHandler("onClientClick", getRootElement(), function(button, state, cursorX, cursorY)
  if panelState then
    if button == "left" then
      if not isDrawing then
        if state == "down" then
          if isCursorWithinArea_Size(cursorX, cursorY, renderData.paintAreaPosX, renderData.paintAreaPosY, renderData.paintAreaWidth, renderData.paintAreaHeight) then
            isDrawing = true
          elseif activeButton then
            if activeButton == "clear" then
              local currentPixels = dxGetTexturePixels(paintArea)
              if currentPixels then
                table.insert(undoHistory, 1, currentPixels)
                currentUndoStep = 1
                if #undoHistory > maximumUndoSteps then
                  table.remove(undoHistory, #undoHistory)
                end
                dxSetTexturePixels(paintArea, emptyPaintArea)
              end
            elseif activeButton == "undo" then
              undoLastStep()
            elseif activeButton == "redo" then
              redoLastStep()
            elseif activeButton == "save" then
              closePanel()
              sightexports.sGui:setCursorType("normal")
              local currentPixels = dxGetTexturePixels(paintArea)
              if currentPixels then
                local imageIdentifier = getRealTime().timestamp
                local convertedPixels = dxConvertPixels(currentPixels, "png")
                local convertedFile = fileCreate("files/saved_graffiti/" .. imageIdentifier .. ".png")
                if convertedFile then
                  fileWrite(convertedFile, convertedPixels)
                  fileClose(convertedFile)
                  table.insert(savedGraffiti, imageIdentifier)
                  selectedGraffiti = convertedPixels
                end
              end
            elseif activeButton == "done" then
              activeMenu = "none"
            elseif activeButton == "brush" then
              editBrushSize = not editBrushSize
            elseif activeButton == "palette" then
              activeMenu = "colorPicker"
            elseif string.find(activeButton, "palette_color|") and activeMenu == "none" then
              local color = string.gsub(activeButton, "palette_color|", "")
              selectedColor = tonumber(color)
            end
          end
        end
      elseif state == "up" then
        isDrawing = false
        local currentPixels = dxGetTexturePixels(paintArea)
        if currentPixels then
          table.insert(undoHistory, 1, currentPixels)
          currentUndoStep = 1
          if #undoHistory > maximumUndoSteps then
            table.remove(undoHistory, #undoHistory)
          end
        end
      end
    end
  elseif button == "left" and state == "up" and active3DButton and not panelState then
    if string.find(active3DButton, "trash|") then
      if adminMode then
        local fileName = string.gsub(active3DButton, "trash|", "")
        local fileName = tonumber(fileName)
        if serverGraffiti[fileName].protected then
          sightexports.sGui:showInfobox("e", "Ezt a graffitit nem lehet törölni, mivel le van védve.")
          return
        end
        triggerServerEvent("deleteGraffiti", localPlayer, fileName)
      end
    elseif string.find(active3DButton, "protect|") then
      if adminMode then
        local fileName = string.gsub(active3DButton, "protect|", "")
        triggerServerEvent("protectGraffiti", localPlayer, fileName)
      end
    elseif string.find(active3DButton, "clean|") and graffitiClean then
      if not getPedOccupiedVehicle(localPlayer) then
        if not isTimer(cleanTimer) then
          if getPedWeapon(localPlayer) == 41 then
            if sightexports.sGroups:getPlayerPermission("graffitiClean") then
              local fileName = string.gsub(active3DButton, "clean|", "")
              local fileName = tonumber(fileName)
              if serverGraffiti[fileName].protected then
                sightexports.sGui:showInfobox("e", "Ezt a graffitit nem lehet lemosni, mivel le van védve.")
                return
              end
              setElementFrozen(localPlayer, true)
              triggerServerEvent("graffitiCleanAnimation", localPlayer)
              sightexports.sChat:localActionC(localPlayer, "elkezd letörölni egy graffit.")
              cleanTimer = setTimer(cleanGraffiti, cleanTime, 1, fileName)
            else
              sightexports.sGui:showInfobox("e", "Nem használhatod ezt a funkciót.")
            end
          else
            sightexports.sGui:showInfobox("e", "A tisztitáshoz egy spray can-nek kell a kezedben lennie.")
          end
        else
          sightexports.sGui:showInfobox("e", "Már folyamatban van egy másik graffiti tisztítása.")
        end
      else
        sightexports.sGui:showInfobox("e", "Járműben nem használhatod ezt a funkciót.")
      end
    end
  end
end)
function cleanGraffiti(fileName)
  triggerServerEvent("cleanGraffiti", localPlayer, fileName)
  if isTimer(cleanTimer) then
    killTimer(cleanTimer)
  end
  sightexports.sChat:localActionC(localPlayer, "befejezte a graffiti törlését.")
  setElementFrozen(localPlayer, false)
  cleanTimer = false
end
addEventHandler("onClientKey", getRootElement(), function(keyName, isPressed)
  if keyName == "mouse1" and not isPressed then
    lastTick = getTickCount()
    if sprayComplete then
      sprayHit = false
      sprayPositions = false
      sprayComplete = false
      sprayPercentage = 0
    end
  end
end)
addEvent("createGraffiti", true)
addEventHandler("createGraffiti", getRootElement(), function(convertedPixels, dataContainer, fileName)
  if convertedPixels and dataContainer and fileName then
    local convertedFile = fileCreate("files/server_graffiti/" .. fileName .. ".png")
    if convertedFile then
      fileWrite(convertedFile, convertedPixels)
      fileClose(convertedFile)
      serverGraffiti[fileName] = dataContainer
      graffitiTextures[fileName] = dxCreateTexture("files/server_graffiti/" .. fileName .. ".png", "dxt3")
      if source == localPlayer then
        sprayPositions = false
        sprayPercentage = 0
        if isElement(tempTexture) then
          destroyElement(tempTexture)
          tempTexture = false
        end
      end
    end
  end
end)
addEvent("deleteGraffiti", true)
addEventHandler("deleteGraffiti", getRootElement(), function(fileName)
  if fileName then
    if serverGraffiti[fileName] then
      serverGraffiti[fileName] = nil
    end
    if visibleGraffiti[fileName] then
      visibleGraffiti[fileName] = nil
    end
    if isElement(graffitiTextures[fileName]) then
      destroyElement(graffitiTextures[fileName])
      graffitiTextures[fileName] = nil
    end
    if fileExists("files/server_graffiti/" .. fileName .. ".png") then
      fileDelete("files/server_graffiti/" .. fileName .. ".png")
    end
  end
end)
local tmp
function renderGraffiti()
  buttons = {}
  local cursorX, cursorY = getCursorPosition()
  dxSetBlendMode("blend")
  renderData.panelPosX, renderData.panelPosY = sightexports.sGui:getGuiPosition(graffitiWindow)
  renderData.paintAreaPosX = renderData.panelPosX + 10
  renderData.paintAreaPosY = renderData.panelPosY + 40
  if activeMenu == "none" then
    sightlangStaticImageUsed[3] = true
    if sightlangStaticImageToc[3] then
      processsightlangStaticImage[3]()
    end
    dxDrawImage(renderData.paintAreaPosX, renderData.paintAreaPosY, renderData.paintAreaWidth, renderData.paintAreaHeight, sightlangStaticImage[3])
    dxDrawImage(renderData.paintAreaPosX, renderData.paintAreaPosY, renderData.paintAreaWidth, renderData.paintAreaHeight, paintArea)
    local targetX = cursorX - renderData.paintAreaPosX
    local targetY = cursorY - renderData.paintAreaPosY
    local color = paletteColors[selectedColor]
    if isCursorWithinArea_Size(cursorX, cursorY, renderData.paintAreaPosX, renderData.paintAreaPosY, renderData.paintAreaWidth, renderData.paintAreaHeight) then
      if isDrawing then
        dxSetRenderTarget(paintArea)
        dxSetBlendMode("modulate_add")
        dxDrawLine(previousX, previousY, targetX, targetY, color, brushSize * 2)
        drawCircle(previousX, previousY, brushSize, color)
        drawCircle(targetX, targetY, brushSize, color)
        dxSetRenderTarget()
      end
      drawCircle(cursorX, cursorY, brushSize, color)
    end
    if editBrushSize then
      local brushX, brushY = renderData.paintAreaPosX + renderData.paintAreaWidth - 280, renderData.paintAreaPosY + renderData.paintAreaHeight + 16
      dxDrawRectangle(brushX, brushY, 200, 20, tocolor(0, 0, 0, 160))
      dxDrawRectangle(brushX, brushY, reMap(brushSize, minimumBrushSize, maximumBrushSize, 0, 200), 20, tocolor(124, 197, 118, 200))
      if getKeyState("mouse1") and isCursorWithinArea_Size(cursorX, cursorY, brushX, brushY, 200, 20) then
        brushSize = reMap(cursorX - brushX, 0, 200, minimumBrushSize, maximumBrushSize)
      end
    end
    previousX, previousY = targetX, targetY
  elseif activeMenu == "colorPicker" then
    sightlangStaticImageUsed[4] = true
    if sightlangStaticImageToc[4] then
      processsightlangStaticImage[4]()
    end
    dxDrawImage(renderData.paintAreaPosX, renderData.paintAreaPosY, renderData.paintAreaWidth, renderData.paintAreaHeight, sightlangStaticImage[4])
    if isDrawing and isCursorWithinArea_Size(cursorX, cursorY, renderData.paintAreaPosX, renderData.paintAreaPosY, renderData.paintAreaWidth, renderData.paintAreaHeight) then
      colorH = (cursorX - renderData.paintAreaPosX) / renderData.paintAreaWidth
      colorS = (renderData.paintAreaHeight - cursorY + renderData.paintAreaPosY) / renderData.paintAreaWidth
      local colorR, colorG, colorB = convertHSLToRGB(colorH, colorS, reMap(currentLuminance, 0, 255, 0, 1))
      paletteColors[selectedColor] = tocolor(colorR * 255, colorG * 255, colorB * 255, 255)
    end
    buttons.done = {
      renderData.paintAreaPosX + 168,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 10,
      renderData.paintAreaPosX + 200,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 42
    }
    local saveColor = tocolor(255, 255, 255, 255)
    if activeButton == "done" then
      saveColor = tocolor(124, 197, 118, 255)
    end
    sightlangStaticImageUsed[5] = true
    if sightlangStaticImageToc[5] then
      processsightlangStaticImage[5]()
    end
    dxDrawImage(renderData.paintAreaPosX + 168, renderData.paintAreaPosY + renderData.paintAreaHeight + 10, 32, 32, sightlangStaticImage[5], 0, 0, 0, saveColor)
    buttons.light = {
      renderData.paintAreaPosX + renderData.paintAreaWidth - 112,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 10,
      renderData.paintAreaPosX + renderData.paintAreaWidth - 80,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 42
    }
    sightlangStaticImageUsed[6] = true
    if sightlangStaticImageToc[6] then
      processsightlangStaticImage[6]()
    end
    dxDrawImage(renderData.paintAreaPosX + renderData.paintAreaWidth - 112, renderData.paintAreaPosY + renderData.paintAreaHeight + 10, 32, 32, sightlangStaticImage[6], 0, 0, 0, tocolor(255, 255, 255, 255))
    local luminanceX, luminanceY = renderData.paintAreaPosX + renderData.paintAreaWidth - 322, renderData.paintAreaPosY + renderData.paintAreaHeight + 16
    dxDrawRectangle(luminanceX, luminanceY, 200, 20, tocolor(0, 0, 0, 160))
    dxDrawRectangle(luminanceX, luminanceY, reMap(currentLuminance, 0, 255, 0, 200), 20, tocolor(124, 197, 118, 200))
    if getKeyState("mouse1") and isCursorWithinArea_Size(cursorX, cursorY, luminanceX, luminanceY, 200, 20) then
      currentLuminance = reMap(cursorX - luminanceX, 0, 200, 0, 255)
      local colorR, colorG, colorB = convertHSLToRGB(colorH, colorS, reMap(currentLuminance, 0, 255, 0, 1))
      paletteColors[selectedColor] = tocolor(colorR * 255, colorG * 255, colorB * 255, 255)
    end
  elseif activeMenu == "save" then
  end
  if activeMenu ~= "none" then
    sightlangStaticImageUsed[7] = true
    if sightlangStaticImageToc[7] then
      processsightlangStaticImage[7]()
    end
    dxDrawImage(renderData.paintAreaPosX, renderData.paintAreaPosY + renderData.paintAreaHeight + 10, 32, 32, sightlangStaticImage[7], 0, 0, 0, tocolor(100, 100, 100, 255))
  else
    buttons.clear = {
      renderData.paintAreaPosX,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 10,
      renderData.paintAreaPosX + 32,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 42
    }
    local clearColor = tocolor(255, 255, 255, 255)
    if activeButton == "clear" then
      clearColor = tocolor(215, 89, 89, 255)
    end
    sightlangStaticImageUsed[7] = true
    if sightlangStaticImageToc[7] then
      processsightlangStaticImage[7]()
    end
    dxDrawImage(renderData.paintAreaPosX, renderData.paintAreaPosY + renderData.paintAreaHeight + 10, 32, 32, sightlangStaticImage[7], 0, 0, 0, clearColor)
  end
  if activeMenu ~= "none" then
    sightlangStaticImageUsed[8] = true
    if sightlangStaticImageToc[8] then
      processsightlangStaticImage[8]()
    end
    dxDrawImage(renderData.paintAreaPosX + 42, renderData.paintAreaPosY + renderData.paintAreaHeight + 10, 32, 32, sightlangStaticImage[8], 0, 0, 0, tocolor(100, 100, 100, 255))
  else
    buttons.undo = {
      renderData.paintAreaPosX + 42,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 10,
      renderData.paintAreaPosX + 74,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 42
    }
    local undoColor = tocolor(255, 255, 255, 255)
    if activeButton == "undo" then
      undoColor = tocolor(blue[1], blue[2], blue[3], 255)
    end
    sightlangStaticImageUsed[8] = true
    if sightlangStaticImageToc[8] then
      processsightlangStaticImage[8]()
    end
    dxDrawImage(renderData.paintAreaPosX + 42, renderData.paintAreaPosY + renderData.paintAreaHeight + 10, 32, 32, sightlangStaticImage[8], 0, 0, 0, undoColor)
  end
  if activeMenu ~= "none" then
    sightlangStaticImageUsed[9] = true
    if sightlangStaticImageToc[9] then
      processsightlangStaticImage[9]()
    end
    dxDrawImage(renderData.paintAreaPosX + 84, renderData.paintAreaPosY + renderData.paintAreaHeight + 10, 32, 32, sightlangStaticImage[9], 0, 0, 0, tocolor(100, 100, 100, 255))
  else
    buttons.redo = {
      renderData.paintAreaPosX + 84,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 10,
      renderData.paintAreaPosX + 116,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 42
    }
    local redoColor = tocolor(255, 255, 255, 255)
    if activeButton == "redo" then
      redoColor = tocolor(blue[1], blue[2], blue[3], 255)
    end
    sightlangStaticImageUsed[9] = true
    if sightlangStaticImageToc[9] then
      processsightlangStaticImage[9]()
    end
    dxDrawImage(renderData.paintAreaPosX + 84, renderData.paintAreaPosY + renderData.paintAreaHeight + 10, 32, 32, sightlangStaticImage[9], 0, 0, 0, redoColor)
  end
  if activeMenu ~= "none" then
    sightlangStaticImageUsed[10] = true
    if sightlangStaticImageToc[10] then
      processsightlangStaticImage[10]()
    end
    dxDrawImage(renderData.paintAreaPosX + 126, renderData.paintAreaPosY + renderData.paintAreaHeight + 10, 32, 32, sightlangStaticImage[10], 0, 0, 0, tocolor(100, 100, 100, 255))
  else
    buttons.save = {
      renderData.paintAreaPosX + 126,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 10,
      renderData.paintAreaPosX + 158,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 42
    }
    local saveColor = tocolor(255, 255, 255, 255)
    if activeButton == "save" then
      saveColor = tocolor(green[1], green[2], green[3], 255)
    end
    sightlangStaticImageUsed[10] = true
    if sightlangStaticImageToc[10] then
      processsightlangStaticImage[10]()
    end
    dxDrawImage(renderData.paintAreaPosX + 126, renderData.paintAreaPosY + renderData.paintAreaHeight + 10, 32, 32, sightlangStaticImage[10], 0, 0, 0, saveColor)
  end
  if activeMenu ~= "none" then
    sightlangStaticImageUsed[11] = true
    if sightlangStaticImageToc[11] then
      processsightlangStaticImage[11]()
    end
    dxDrawImage(renderData.paintAreaPosX + renderData.paintAreaWidth - 32, renderData.paintAreaPosY + renderData.paintAreaHeight + 10, 32, 32, sightlangStaticImage[11], 0, 0, 0, tocolor(100, 100, 100, 255))
  else
    buttons.palette = {
      renderData.paintAreaPosX + renderData.paintAreaWidth - 32,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 10,
      renderData.paintAreaPosX + renderData.paintAreaWidth,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 42
    }
    local paletteColor = paletteColors[selectedColor]
    if activeButton == "palette" then
      paletteColor = tocolor(green[1], green[2], green[3], 255)
    end
    sightlangStaticImageUsed[11] = true
    if sightlangStaticImageToc[11] then
      processsightlangStaticImage[11]()
    end
    dxDrawImage(renderData.paintAreaPosX + renderData.paintAreaWidth - 32, renderData.paintAreaPosY + renderData.paintAreaHeight + 10, 32, 32, sightlangStaticImage[11], 0, 0, 0, paletteColor)
  end
  if activeMenu ~= "none" then
    sightlangStaticImageUsed[12] = true
    if sightlangStaticImageToc[12] then
      processsightlangStaticImage[12]()
    end
    dxDrawImage(renderData.paintAreaPosX + renderData.paintAreaWidth - 72, renderData.paintAreaPosY + renderData.paintAreaHeight + 10, 32, 32, sightlangStaticImage[12], 0, 0, 0, tocolor(100, 100, 100, 255))
  else
    buttons.brush = {
      renderData.paintAreaPosX + renderData.paintAreaWidth - 72,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 10,
      renderData.paintAreaPosX + renderData.paintAreaWidth - 40,
      renderData.paintAreaPosY + renderData.paintAreaHeight + 42
    }
    local brushColor = tocolor(255, 255, 255, 255)
    if activeButton == "brush" then
      brushColor = tocolor(green[1], green[2], green[3], 255)
    end
    sightlangStaticImageUsed[12] = true
    if sightlangStaticImageToc[12] then
      processsightlangStaticImage[12]()
    end
    dxDrawImage(renderData.paintAreaPosX + renderData.paintAreaWidth - 72, renderData.paintAreaPosY + renderData.paintAreaHeight + 10, 32, 32, sightlangStaticImage[12], 0, 0, 0, brushColor)
  end
  local colorWidth = math.floor(renderData.paintAreaWidth / #paletteColors)
  local marginWidth = 2
  for i = 0, #paletteColors - 1 do
    local colorPosX = renderData.paintAreaPosX + i * colorWidth
    local colorPosY = renderData.paintAreaPosY + renderData.paintAreaHeight + 52
    dxDrawRectangle(colorPosX, colorPosY, colorWidth, 40, paletteColors[i + 1])
    buttons["palette_color|" .. i + 1] = {
      colorPosX,
      colorPosY,
      colorPosX + colorWidth,
      colorPosY + 40
    }
  end
  activeButton = false
  for k, v in pairs(buttons) do
    if cursorX >= v[1] and cursorY >= v[2] and cursorX <= v[3] and cursorY <= v[4] then
      activeButton = k
      break
    end
  end
  if activeButton ~= tmp then
    if activeButton then
      sightexports.sGui:setCursorType("link")
    else
      sightexports.sGui:setCursorType("normal")
    end
    tmp = activeButton
  end
end
addCommandHandler("graffiti", function()
  if sightexports.sGroups:getPlayerPermission("graffiti") then
    isDrawing = false
    activeMenu = "none"
    panelState = not panelState
    if panelState then
      sightexports.sHud:setHudEnabled(false, 0)
    else
      sightexports.sHud:setHudEnabled(true, 0)
    end
    if panelState then
      addEventHandler("onClientRender", getRootElement(), renderGraffiti, true, "low-9999")
    else
      removeEventHandler("onClientRender", getRootElement(), renderGraffiti)
    end
    showGraffitiWindow(panelState)
    sprayHit = false
    sprayPositions = false
    sprayComplete = false
    sprayPercentage = 0
    if isElement(tempTexture) then
      destroyElement(tempTexture)
      tempTexture = false
    end
  end
end)
function convertHSLToRGB(h, s, l)
  local m2
  if l < 0.5 then
    m2 = l * (s + 1)
  else
    m2 = l + s - l * s
  end
  local m1 = l * 2 - m2
  local hue2rgb = function(m1, m2, h)
    if h < 0 then
      h = h + 1
    elseif 1 < h then
      h = h - 1
    end
    if 1 > h * 6 then
      return m1 + (m2 - m1) * h * 6
    elseif 1 > h * 2 then
      return m2
    elseif 2 > h * 3 then
      return m1 + (m2 - m1) * (0.6666666666666666 - h) * 6
    else
      return m1
    end
  end
  local r = hue2rgb(m1, m2, h + 0.3333333333333333)
  local g = hue2rgb(m1, m2, h)
  local b = hue2rgb(m1, m2, h - 0.3333333333333333)
  return r, g, b
end
function convertRGBToHSL(r, g, b)
  local max = math.max(r, g, b)
  local min = math.min(r, g, b)
  local l = (min + max) / 2
  local h, s
  if max == min then
    h = 0
    s = 0
  else
    local d = max - min
    if l < 0.5 then
      s = d / (max + min)
    else
      s = d / (2 - max - min)
    end
    if max == r then
      h = (g - b) / d
      if g < b then
        h = h + 6
      end
    elseif max == g then
      h = (b - r) / d + 2
    else
      h = (r - g) / d + 4
    end
    h = h / 6
  end
  return h, s, l
end
function undoLastStep()
  if undoHistory[currentUndoStep + 1] then
    currentUndoStep = currentUndoStep + 1
    dxSetTexturePixels(paintArea, undoHistory[currentUndoStep])
  end
end
function redoLastStep()
  if undoHistory[currentUndoStep - 1] then
    currentUndoStep = currentUndoStep - 1
    dxSetTexturePixels(paintArea, undoHistory[currentUndoStep])
  end
end
function drawCircle(x, y, r, color)
  for yoff = math.floor(-r) + 0.5, r + 0.5 do
    local xoff = math.sqrt(r * r - yoff * yoff)
    if not isNaN(xoff) then
      dxDrawRectangle(x - xoff, y + yoff, 2 * xoff, 1, color)
    end
  end
end
local _getCursorPosition = getCursorPosition
function getCursorPosition()
  if isCursorShowing() then
    local screenX, screenY, worldX, worldY, worldZ = _getCursorPosition()
    return screenX * screenWidth, screenY * screenHeight
  else
    return 0, 0
  end
end
function isCursorWithinArea_Size(clickX, clickY, startX, startY, sizeX, sizeY)
  return startX <= clickX and clickX <= startX + sizeX and startY <= clickY and clickY <= startY + sizeY
end
function isCursorWithinArea_End(clickX, clickY, startX, startY, endX, endY)
  return startX <= clickX and clickX <= endX and startY <= clickY and clickY <= endY
end
function firstToUpper(text)
  return (utf8.gsub(text, "^%l", utf8.upper))
end
function isNaN(n)
  return n ~= n
end

function processJson(jsonTable)
  local function convertKeys(table)
      local newTable = {}
      for key, value in pairs(table) do
          local numericKey = tonumber(key)
          if numericKey then
              key = numericKey
          end

          if type(value) == "table" then
              newTable[key] = convertKeys(value)
          else
              newTable[key] = value
          end
      end
      return newTable
  end

  return convertKeys(jsonTable)
end