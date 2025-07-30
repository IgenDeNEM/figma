local sightexports = {sChat = false, sGui = false}
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
    sightlangStaticImage[0] = dxCreateTexture("files/tow.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/tow2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local grey = false
local green = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    grey = sightexports.sGui:getColorCodeToColor("sightgrey1")
    green = sightexports.sGui:getColorCodeToColor("sightgreen")
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local screenX, screenY = guiGetScreenSize()
local towedVehicle = {}
local trailerList = {}
local trailerShapes = {}
local disableDetach = false
function setDisableDetach(state)
  disableDetach = state
end
addEventHandler("onClientTrailerDetach", getRootElement(), function(towedBy)
  if towedBy == getPedOccupiedVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer) == 0 and 0 >= getElementDimension(localPlayer) and not disableDetach then
    setElementData(towedBy, "towCar", false)
  end
end)
addEventHandler("onClientVehicleDataChange", getRootElement(), function(data, old, new)
  if data == "towCar" then
    if new then
      if isElementStreamedIn(source) then
        towedVehicle[source] = new
        local sound = playSound3D("files/towa.mp3", 0, 0, 0)
        setElementDimension(sound, getElementDimension(source))
        setElementInterior(sound, getElementInterior(source))
        attachElements(sound, new, 0, 2.25, 0)
        detachTrailerFromVehicle(source, new)
        attachTrailerToVehicle(source, new)
      end
    else
      if isElement(source) then
        detachTrailerFromVehicle(source)
      end
      if isElement(old) then
        local sound = playSound3D("files/towd.mp3", 0, 0, 0)
        setElementDimension(sound, getElementDimension(source))
        setElementInterior(sound, getElementInterior(source))
        attachElements(sound, old, 0, 2.25, 0)
      end
      towedVehicle[source] = nil
    end
  end
end)
addEventHandler("onClientVehicleDestroy", getRootElement(), function()
  if towedVehicle[source] then
    towedVehicle[source] = nil
  end
  local model = getElementModel(source)
  if model == 611 or model == 608 then
    for k = #trailerList, 1, -1 do
      if trailerList[k] == source then
        table.remove(trailerList, k)
      end
    end
    if isElement(trailerShapes[source]) then
      destroyElement(trailerShapes[source])
    end
    trailerShapes[source] = nil
  end
end)
addEventHandler("onClientElementDimensionChange", getRootElement(), function(oldDimension, newDimension)
  if isElement(trailerShapes[source]) then
    setElementDimension(trailerShapes[source], newDimension)
  end
end)
addEventHandler("onClientElementInteriorChange", getRootElement(), function(oldInterior, newInterior)
  if isElement(trailerShapes[source]) then
    setElementInterior(trailerShapes[source], newInterior)
  end
end)
addEventHandler("onClientVehicleStreamOut", getRootElement(), function()
  if towedVehicle[source] then
    towedVehicle[source] = nil
  end
  local model = getElementModel(source)
  if model == 611 or model == 608 then
    for k = #trailerList, 1, -1 do
      if trailerList[k] == source then
        table.remove(trailerList, k)
      end
    end
    if isElement(trailerShapes[source]) then
      destroyElement(trailerShapes[source])
    end
    trailerShapes[source] = nil
  end
end)
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
  if getElementData(source, "towCar") then
    towedVehicle[source] = getElementData(source, "towCar")
    if isElement(towedVehicle[source]) then
      detachTrailerFromVehicle(source, towedVehicle[source])
      attachTrailerToVehicle(source, towedVehicle[source])
    end
  end
  local model = getElementModel(source)
  if model == 611 or model == 608 then
    table.insert(trailerList, source)
    if isElement(trailerShapes[source]) then
      destroyElement(trailerShapes[source])
    end
    trailerShapes[source] = createColSphere(0, 0, 0, 10)
    setElementDimension(trailerShapes[source], getElementDimension(source))
    setElementInterior(trailerShapes[source], getElementInterior(source))
    attachElements(trailerShapes[source], source)
  end
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  for k, v in ipairs(getElementsByType("vehicle", getRootElement(), true)) do
    if getElementData(v, "towCar") then
      towedVehicle[v] = getElementData(v, "towCar")
      if isElement(v) and isElement(towedVehicle[v]) then
        detachTrailerFromVehicle(v, towedVehicle[v])
        attachTrailerToVehicle(v, towedVehicle[v])
      end
    end
    local model = getElementModel(v)
    if model == 611 or model == 608 then
      table.insert(trailerList, v)
      trailerShapes[v] = createColSphere(0, 0, 0, 10)
      setElementDimension(trailerShapes[v], getElementDimension(v))
      setElementInterior(trailerShapes[v], getElementInterior(v))
      attachElements(trailerShapes[v], v)
    end
  end
  setWorldSoundEnabled(5, 70, false)
end)
function getElementMatrix(element)
  local rx, ry, rz = getElementRotation(element, "ZXY")
  rx, ry, rz = math.rad(rx), math.rad(ry), math.rad(rz)
  local matrix = {}
  matrix[1] = {}
  matrix[1][1] = math.cos(rz) * math.cos(ry) - math.sin(rz) * math.sin(rx) * math.sin(ry)
  matrix[1][2] = math.cos(ry) * math.sin(rz) + math.cos(rz) * math.sin(rx) * math.sin(ry)
  matrix[1][3] = -math.cos(rx) * math.sin(ry)
  matrix[1][4] = 1
  matrix[2] = {}
  matrix[2][1] = -math.cos(rx) * math.sin(rz)
  matrix[2][2] = math.cos(rz) * math.cos(rx)
  matrix[2][3] = math.sin(rx)
  matrix[2][4] = 1
  matrix[3] = {}
  matrix[3][1] = math.cos(rz) * math.sin(ry) + math.cos(ry) * math.sin(rz) * math.sin(rx)
  matrix[3][2] = math.sin(rz) * math.sin(ry) - math.cos(rz) * math.cos(ry) * math.sin(rx)
  matrix[3][3] = math.cos(rx) * math.cos(ry)
  matrix[3][4] = 1
  matrix[4] = {}
  matrix[4][1], matrix[4][2], matrix[4][3] = getElementPosition(element)
  matrix[4][4] = 1
  return matrix
end
function getPositionFromElementOffset(element, offX, offY, offZ)
  local m = getElementMatrix(element)
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z
end
local towPoses = {
  [585] = -3.3647441864014,
  [405] = -3.2975299358368,
  [490] = -3.4374589920044,
  [580] = -3.2463500499725,
  [596] = -3.2158517837524,
  [483] = -3.1697101593018,
  [492] = -3.2344129085541,
  [421] = -2.9585883617401,
  [551] = -3.3679785728455,
  [420] = -3.2561321258545,
  [445] = -3.2223148345947,
  ["model_y"] = -3.2223148345947,
  ["model_s"] = -3.2223148345947,
  [598] = -3.1121556758881,
  [400] = -2.939249753952,
  [508] = -5.4017527699471,
  [467] = -3.4371404647827,
  [554] = -3.691978931427,
  [413] = -3.0250282287598,
  [495] = -3.9256961345673,
  ["dodge"] = -3.9256961345673,
  [470] = -3.2734982846305,
  [500] = -2.6629102230072,
  [546] = -2.696652173996,
  [516] = -3.4709255695343,
  [438] = -3.425999879837,
  [550] = -3.2059180736542,
  [507] = -3.4771547317505,
  [404] = -3.1522176265717,
  [582] = -3.5006923675537,
  [579] = -3.2629854679108,
  [529] = -2.7724599838257,
  [566] = -3.0670201778412,
  [597] = -2.8271546363831,
  [547] = -3.4631953239441,
  [418] = -3.3841907978058,
  [589] = -2.6758096218109,
  [458] = -3.2735304832458,
  [457] = -3.2735304832458,
  [422] = -3.1952430531383
  --[540] = -3.1952430531383 -- idg subaru 
}
function getTowPoses()
  return towPoses
end
function getVehicleSpeed(currentElement)
  if isElement(currentElement) then
    local x, y, z = getElementVelocity(currentElement)
    return math.sqrt(x ^ 2 + y ^ 2 + z ^ 2) * 187.5
  end
end
local decoupleHover = false
local coupleHoverVeh = false
local coupleHoverTrailer = false
local lastClick = 0
addEventHandler("onClientClick", getRootElement(), function(button, state)
  if state == "up" and getTickCount() - lastClick > 500 then
    if coupleHoverVeh and coupleHoverTrailer then
      sightexports.sChat:localActionC(localPlayer, "felakasztott egy utánfutót.")
      setElementData(coupleHoverVeh, "towCar", coupleHoverTrailer)
      detachTrailerFromVehicle(coupleHoverVeh, coupleHoverTrailer)
      attachTrailerToVehicle(coupleHoverVeh, coupleHoverTrailer)
      lastClick = getTickCount()
    elseif decoupleHover then
      sightexports.sChat:localActionC(localPlayer, "leakasztott egy utánfutót.")
      setElementData(decoupleHover, "towCar", false)
      lastClick = getTickCount()
    end
  end
end)
addEventHandler("onClientResotre", getRootElement(), function()
  detachTrailerFromVehicle(source, towedVehicle[source])
  attachTrailerToVehicle(source, towedVehicle[source])
end)
addEventHandler("onClientRender", getRootElement(), function()
  local pedveh = getPedOccupiedVehicle(localPlayer)
  local pedvehO = pedveh
  if getPedOccupiedVehicleSeat(localPlayer) ~= 0 or 0 < getElementDimension(localPlayer) or disableDetach then
    pedveh = false
  end
  if tonumber(disableDetach) then
    disableDetach = disableDetach - 1
    if disableDetach < 0 then
      disableDetach = false
    end
  end
  local px, py, pz = getElementPosition(localPlayer)
  local cx, cy = getCursorPosition()
  if cx then
    cx = cx * screenX
    cy = cy * screenY
  end
  decoupleHoverTmp = false
  coupleHoverTmpVeh = false
  coupleHoverTmpTrailer = false
  local trailerAttached = {}
  for k, v in pairs(towedVehicle) do
    local x, y, z = getPositionFromElementOffset(k, 0, towPoses[getElementData(k, "vehicle.customModel") or getElementModel(k)] or -1, 0)
    if not isElement(k) then
      towedVehicle[k] = nil
    end
    if not isElement(v) then
      towedVehicle[k] = nil
    end
    if towedVehicle[k] then
      if not pedveh and getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 1.5 and getVehicleSpeed(k) < 5 then
        local sx, sy = getScreenFromWorldPosition(x, y, z, 128)
        if sx then
          dxDrawRectangle(sx - 24, sy - 24, 48, 48, grey)
          if cx and cx >= sx - 24 and cy >= sy - 24 and cx <= sx + 24 and cy <= sy + 24 then
            decoupleHoverTmp = k
            sightlangStaticImageUsed[0] = true
            if sightlangStaticImageToc[0] then
              processsightlangStaticImage[0]()
            end
            dxDrawImage(sx - 24 + 4, sy - 24 + 4, 40, 40, sightlangStaticImage[0], 0, 0, 0, green)
          else
            sightlangStaticImageUsed[0] = true
            if sightlangStaticImageToc[0] then
              processsightlangStaticImage[0]()
            end
            dxDrawImage(sx - 24 + 4, sy - 24 + 4, 40, 40, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255))
          end
        end
      end
      setVehicleLightState(v, 0, 1)
      setVehicleLightState(v, 1, 1)
      setVehicleLightState(v, 2, getVehicleLightState(k, 2))
      setVehicleLightState(v, 3, getVehicleLightState(k, 3))
      trailerAttached[v] = true
      setVehicleOverrideLights(v, getVehicleOverrideLights(k))
      if getElementHealth(v) < 750 then
        fixVehicle(v)
      end
      if k ~= pedveh then
        local x2, y2, z2
        if getElementModel(v) == 611 then
          x2, y2, z2 = getPositionFromElementOffset(v, 0, 2.25, 0)
        else
          x2, y2, z2 = getPositionFromElementOffset(v, 0, 2.36106, 0)
        end
        z2 = z
        local dist = getDistanceBetweenPoints2D(x, y, x2, y2)
        if 0.25 <= dist then
          detachTrailerFromVehicle(k, v)
          attachTrailerToVehicle(k, v)
        end
      end
    end
  end
  local ovehModels = {}
  local ovehs = false
  if pedvehO then
    cx = false
    ovehs = {false, pedvehO}
    ovehModels = {
      false,
      getElementData(pedvehO, "vehicle.customModel") or getElementModel(pedvehO)
    }
  end
  for k = 1, #trailerList do
    if trailerList[k] and not trailerAttached[trailerList[k]] then
      local rx, ry, rz = getElementRotation(trailerList[k])
      if 10 < rx and getVehicleSpeed(trailerList[k]) < 2 then
        setElementRotation(trailerList[k], 0, ry, rz)
      end
      if getElementHealth(trailerList[k]) < 750 then
        fixVehicle(trailerList[k])
      end
      setVehicleOverrideLights(trailerList[k], 1)
      local vehs = false
      local vehModels = {}
      if ovehs then
        vehs = ovehs
        vehModels = ovehModels
      else
        vehs = getElementsWithinColShape(trailerShapes[trailerList[k]], "vehicle")
        for i = 1, #vehs do
          if vehs[i] and vehs[i] ~= trailerList[k] then
            vehModels[i] = getElementData(vehs[i], "vehicle.customModel") or getElementModel(vehs[i])
          end
        end
      end
      if 1 < #vehs then
        local x2, y2, z2 = getPositionFromElementOffset(trailerList[k], 0, 2.25, 0)
        for i = 1, #vehs do
          if vehs[i] and vehs[i] ~= trailerList[k] and towPoses[vehModels[i]] then
            local x, y, z = getPositionFromElementOffset(vehs[i], 0, towPoses[vehModels[i]] or -1, 0)
            if (vehs[i] == pedvehO or getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 1.5) and getDistanceBetweenPoints2D(x, y, x2, y2) < 0.5 then
              local sx, sy = getScreenFromWorldPosition(x, y, z, 128)
              if sx then
                dxDrawRectangle(sx - 24, sy - 24, 48, 48, grey)
                if cx and cx >= sx - 24 and cy >= sy - 24 and cx <= sx + 24 and cy <= sy + 24 then
                  coupleHoverTmpVeh = vehs[i]
                  coupleHoverTmpTrailer = trailerList[k]
                  sightlangStaticImageUsed[1] = true
                  if sightlangStaticImageToc[1] then
                    processsightlangStaticImage[1]()
                  end
                  dxDrawImage(sx - 24 + 4, sy - 24 + 4, 40, 40, sightlangStaticImage[1], 0, 0, 0, green)
                  break
                end
                sightlangStaticImageUsed[1] = true
                if sightlangStaticImageToc[1] then
                  processsightlangStaticImage[1]()
                end
                dxDrawImage(sx - 24 + 4, sy - 24 + 4, 40, 40, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
              end
              break
            end
          end
        end
      end
    end
  end
  if decoupleHoverTmp ~= decoupleHover or coupleHoverTmpVeh ~= coupleHoverVeh or coupleHoverTmpTrailer ~= coupleHoverTrailer then
    decoupleHover = decoupleHoverTmp
    coupleHoverVeh = coupleHoverTmpVeh
    coupleHoverTrailer = coupleHoverTmpTrailer
    sightexports.sGui:setCursorType((decoupleHover or coupleHoverVeh) and "link" or "normal")
    if decoupleHover then
      sightexports.sGui:showTooltip("Utánfutó leakasztása")
    elseif coupleHoverVeh then
      sightexports.sGui:showTooltip("Utánfutó felakasztása")
    else
      sightexports.sGui:showTooltip()
    end
  end
end)

function getAttachedTrailer(tractorVehicle)
	return getElementData(tractorVehicle, "towCar")
end