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
local trailerAttachments = {}
local trailerShaders = {}
local trailerTextures = {}
local trailerStreamOutTime = {}
local plateText = {}
local myVehicle = false
local myTrailer = false
local myMarker = false
local myBlip = false
addEvent("gotAttachedPaintshopVehicle", true)
addEventHandler("gotAttachedPaintshopVehicle", getRootElement(), function(data, pj, plate)
  if isElement(source) and trailerAttachments[source] then
    if isElement(trailerTextures[source]) then
      destroyElement(trailerTextures[source])
    end
    trailerTextures[source] = nil
    if pj then
      if not isElement(trailerShaders[source]) then
        local model = getElementModel(trailerAttachments[source])
        trailerShaders[source] = dxCreateShader(textureChanger)
        engineApplyShaderToWorldTexture(trailerShaders[source], mapNames[model][1], trailerAttachments[source])
        engineApplyShaderToWorldTexture(trailerShaders[source], mapNames[model][2], trailerAttachments[source])
      end
      trailerTextures[source] = dxCreateTexture(data, "dxt1")
      dxSetShaderValue(trailerShaders[source], "gTexture", trailerTextures[source])
    else
      local r, g, b = hexToRGB(data)
      setVehicleColor(trailerAttachments[source], r, g, b, 255, 255, 255, 255, 255, 255, 255, 255, 255)
      if isElement(trailerShaders[source]) then
        destroyElement(trailerShaders[source])
      end
      trailerShaders[source] = nil
    end
    plateText[source] = convertPlate(plate)
    setVehiclePlateText(trailerAttachments[source], plateText[source])
    data = nil
    collectgarbage("collect")
  end
end)
function trailerStreamOut(veh)
  if isElement(trailerAttachments[veh]) then
    destroyElement(trailerAttachments[veh])
  end
  trailerAttachments[veh] = nil
  if isElement(trailerShaders[veh]) then
    destroyElement(trailerShaders[veh])
  end
  trailerShaders[veh] = nil
  if isElement(trailerTextures[veh]) then
    trailerStreamOutTime[veh] = getTickCount()
  end
end
function setElementCollisionsEnabledEx(el, state)
  if isElement(el) then
    setElementCollisionsEnabled(el, state)
  end
end
local trailerOffsets = false
local lowerLimit = false
trailerOffsets = {
  [561] = { -- mappa
    0,
    -1,
    0.65
  },
  [580] = { -- mappa
    0,
    -1.1,
    0.725
  },
  [551] = { -- mappa
    0,
    -1,
    0.625
  },
  [547] = { -- mappa
    0,
    -1,
    0.5
  },
  [560] = { -- mappa
    0,
    -1.15,
    0.575
  },
  [558] = { -- mappa
    0,
    -1.05,
    0.665
  },
  [533] = { -- van
    0,
    -1,
    0.5
  },
  [541] = { -- mappa
    0,
    -1,
    0.6
  },
  [429] = { -- mappa
    0,
    -1,
    0.6
  },
  [516] = { -- van
    0,
    -1,
    0.95
  },
  [602] = { -- van
    0,
    -1,
    0.8
  },
  [562] = { -- van
    0,
    -1,
    0.675
  },
  [445] = { -- mappa
    0,
    -1,
    0.85
  },
  [495] = { -- mappa
    0,
    -1.1,
    0.975
  },
  [507] = { -- van
    0,
    -0.825,
    0.85
  },
  [589] = { -- van
    0,
    -1.1,
    0.815
  },
  [458] = { -- mappa
    0,
    -0.9,
    0.65
  },
  [567] = {
    0,
    -0.95,
    0.9
  }
}
lowerLimit = {
  [429] = -0.1,
  [560] = -0.1,
  [445] = -0.1
}
function trailerStreamIn(veh)
  if isElement(trailerAttachments[veh]) then
    destroyElement(trailerAttachments[veh])
  end
  trailerAttachments[veh] = nil
  if isElement(trailerShaders[veh]) then
    destroyElement(trailerShaders[veh])
  end
  trailerShaders[veh] = nil
  local model = getElementData(veh, "paintshopCarModel")
  if model and mapNames[model] and trailerOffsets[model] then
    trailerStreamOutTime[veh] = nil
    local x, y, z = getElementPosition(veh)
    trailerAttachments[veh] = createVehicle(model, x, y, z)
    setVehicleHandling(trailerAttachments[veh], "modelFlags", 110000)
    setVehicleHandling(trailerAttachments[veh], "handlingFlags", 0)
    setVehicleHandling(trailerAttachments[veh], "suspensionLowerLimit", lowerLimit[model] or 0.01)
    setVehicleVariant(trailerAttachments[veh], 255, 255)
    setVehicleColor(trailerAttachments[veh], 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255)
    setElementCollidableWith(veh, trailerAttachments[veh], false)
    setTimer(setElementCollisionsEnabledEx, 1000, 1, trailerAttachments[veh], false)
    setVehicleDamageProof(trailerAttachments[veh], true)
    setVehiclePlateText(trailerAttachments[veh], plateText[veh] or "")
    setElementInterior(trailerAttachments[veh], getElementInterior(veh))
    setElementDimension(trailerAttachments[veh], getElementDimension(veh))
    attachElements(trailerAttachments[veh], veh, trailerOffsets[model][1], trailerOffsets[model][2], trailerOffsets[model][3])
    trailerShaders[veh] = dxCreateShader(textureChanger)
    engineApplyShaderToWorldTexture(trailerShaders[veh], mapNames[model][1], trailerAttachments[veh])
    engineApplyShaderToWorldTexture(trailerShaders[veh], mapNames[model][2], trailerAttachments[veh])
    if isElement(trailerTextures[veh]) then
      dxSetShaderValue(trailerShaders[veh], "gTexture", trailerTextures[veh])
    else
      triggerServerEvent("getAttachedPaintshopVehicle", veh)
    end
  else
    handleTextureDestroy(veh)
  end
end
function handleTextureDestroy(veh)
  if isElement(trailerTextures[veh]) then
    destroyElement(trailerTextures[veh])
  end
  trailerTextures[veh] = nil
  trailerStreamOutTime[veh] = nil
  plateText[veh] = nil
end
local boxTrailerOffsets = {
  {
    0.535478,
    1.47774,
    0.277653,
    270
  },
  {
    0,
    1.47774,
    0.277653,
    90
  },
  {
    -0.535478,
    1.47774,
    0.277653,
    270
  },
  {
    0.535478,
    0.945899,
    0.277653,
    270
  },
  {
    0,
    0.945899,
    0.277653,
    270
  },
  {
    -0.535478,
    0.945899,
    0.277653,
    0
  },
  {
    0.535478,
    0.412759,
    0.277653,
    90
  },
  {
    0,
    0.412759,
    0.277653,
    270
  },
  {
    -0.535478,
    0.412759,
    0.277653,
    90
  },
  {
    0.535478,
    -0.134733,
    0.277653,
    180
  },
  {
    0,
    -0.134733,
    0.277653,
    90
  },
  {
    -0.535478,
    -0.134733,
    0.277653,
    180
  },
  {
    0.535478,
    -0.670109,
    0.277653,
    90
  },
  {
    0,
    -0.670109,
    0.277653,
    180
  },
  {
    -0.535478,
    -0.670109,
    0.277653,
    270
  },
  {
    0.535478,
    1.47774,
    0.772653,
    270
  },
  {
    0,
    1.47774,
    0.772653,
    180
  },
  {
    -0.535478,
    1.47774,
    0.772653,
    180
  },
  {
    0.535478,
    0.945899,
    0.772653,
    0
  },
  {
    0,
    0.945899,
    0.772653,
    180
  },
  {
    -0.535478,
    0.945899,
    0.772653,
    0
  },
  {
    0.535478,
    0.412759,
    0.772653,
    0
  },
  {
    0,
    0.412759,
    0.772653,
    0
  },
  {
    -0.535478,
    0.412759,
    0.772653,
    270
  },
  {
    0.535478,
    -0.134733,
    0.772653,
    0
  },
  {
    0,
    -0.134733,
    0.772653,
    90
  },
  {
    -0.535478,
    -0.134733,
    0.772653,
    0
  },
  {
    0.535478,
    -0.670109,
    0.772653,
    0
  },
  {
    0,
    -0.670109,
    0.772653,
    270
  },
  {
    -0.535478,
    -0.670109,
    0.772653,
    0
  }
}
local transferBoxes = {}
function trailerExStreamOut(veh)
  if transferBoxes[veh] then
    for i = 1, #transferBoxes[veh] do
      if isElement(transferBoxes[veh][i]) then
        destroyElement(transferBoxes[veh][i])
      end
    end
  end
  transferBoxes[veh] = nil
  if myTrailer == veh then
    if isElement(myMarker) then
      destroyElement(myMarker)
    end
    myMarker = nil
    if isElement(myBlip) then
      destroyElement(myBlip)
    end
    myBlip = nil
  end
end
boxBlipData = false
local currentMarker = false
local currentBlip = false
currentMarkerWS = false
function processCarBlip(dim)
  if currentMarkerWS then
    local doorId, aisleId, insideId = unpack(currentMarkerWS)
    if dim == aisleId then
      local x, y, z, rz = unpack(aisleDoors[insideId])
      x = x + lobbyX
      y = y + lobbyY
      z = z + lobbyZ + 1
      local rad = math.rad(rz) - math.pi / 2
      x = x + math.cos(rad) * 6.66072
      y = y + math.sin(rad) * 6.66072
      setElementPosition(currentBlip, x, y, z)
    else
      setElementPosition(currentBlip, garageDoors[doorId][1], garageDoors[doorId][2], garageDoors[doorId][3])
    end
  end
end
function processBoxBlip(dim)
  local doorId, aisleId, insideId = unpack(boxBlipData)
  if dim == aisleId then
    local x, y, z, rz = unpack(aisleDoors[insideId])
    x = x + lobbyX
    y = y + lobbyY
    z = z + lobbyZ + 1
    local rad = math.rad(rz) - math.pi / 2
    x = x + math.cos(rad) * 6.66072
    y = y + math.sin(rad) * 6.66072
    setElementPosition(myBlip, x, y, z)
  else
    setElementPosition(myBlip, garageDoors[doorId][1], garageDoors[doorId][2], garageDoors[doorId][3])
  end
end
addEventHandler("onClientElementDimensionChange", getRootElement(), function(oldDimension, newDimension)
  if source == localPlayer then
    if boxBlipData then
      processBoxBlip(newDimension)
    end
    if currentMarkerWS then
      processCarBlip(newDimension)
    end
  elseif transferBoxes[source] then
    trailerExStreamIn(source)
  elseif trailerAttachments[source] then
    trailerStreamIn(source)
  end
end)
function createMyMarker(data)
  if isElement(myMarker) then
    destroyElement(myMarker)
  end
  myMarker = nil
  if isElement(myBlip) then
    destroyElement(myBlip)
  end
  myBlip = nil
  boxBlipData = false
  if isElement(myTrailer) then
    local data = data or getElementData(myTrailer, "paintshopTrailerBoxes")
    if data and data.ws then
      local doorId, aisleId, insideId = getAisleFromWorkshop(data.ws)
      if aisleDoors[insideId] then
        boxBlipData = {
          doorId,
          aisleId,
          insideId
        }
        local x, y, z, rz = unpack(aisleDoors[insideId])
        x = x + lobbyX
        y = y + lobbyY
        z = z + lobbyZ + 1
        local rad = math.rad(rz) - math.pi / 2
        x = x + math.cos(rad) * 6.66072
        y = y + math.sin(rad) * 6.66072
        myBlip = createBlip(x, y, z, 18, 2, green[1], green[2], green[3])
        myMarker = createMarker(x, y, z - 1, "cylinder", 2.5, green[1], green[2], green[3])
        setElementInterior(myMarker, targetIntLobby)
        setElementDimension(myMarker, aisleId)
        processBoxBlip(getElementDimension(localPlayer))
        setElementData(myBlip, "tooltipText", "Fényezőműhely")
      end
    end
  end
end
function processTransferBoxes()
  for veh in pairs(transferBoxes) do
    trailerExStreamIn(veh)
  end
end
function trailerExStreamIn(veh)
  trailerExStreamOut(veh)
  local data = getElementData(veh, "paintshopTrailerBoxes")
  if data then
    local j = 1
    local x, y, z = getElementPosition(veh)
    transferBoxes[veh] = {}
    if myTrailer == veh and data.ws then
      createMyMarker(data)
    end
    local dimension = getElementDimension(veh)
    local interior = getElementInterior(veh)
    for i = 1, 17 do
      if data[i] and 0 < data[i] then
        for k = 1, data[i] do
          if boxTrailerOffsets[j] then
            local box = false
            if i == 1 then
              box = createObject(models.spray_basebox, x, y, z)
              engineApplyShaderToWorldTexture(colorPrimerShader, "base_canister_tag", box)
            elseif i == 2 then
              box = createObject(models.spray_basebox, x, y, z)
              engineApplyShaderToWorldTexture(colorBaseShaders[1], "base_canister_tag", box)
            elseif i == 3 then
              box = createObject(models.spray_basebox, x, y, z)
              engineApplyShaderToWorldTexture(colorBaseShaders[2], "base_canister_tag", box)
            else
              box = createObject(models.spray_paintbox, x, y, z)
              engineApplyShaderToWorldTexture(colorPaletteShaders[i - 3], "color_canister_tag", box)
            end
            setElementCollisionsEnabled(box, false)
            setElementDimension(box, dimension)
            setElementInterior(box, interior)
            attachElements(box, veh, boxTrailerOffsets[j][1], boxTrailerOffsets[j][2], boxTrailerOffsets[j][3], 0, 0, boxTrailerOffsets[j][4])
            table.insert(transferBoxes[veh], box)
          end
          j = j + 1
        end
      end
    end
  end
end
setTimer(function()
  local now = getTickCount()
  for veh in pairs(trailerStreamOutTime) do
    if 20000 < now - trailerStreamOutTime[veh] then
      handleTextureDestroy(veh)
    end
  end
end, 15000, 0)
addEventHandler("onClientElementDataChange", getRootElement(), function(data, old, new)
  if data == "paintshopCarModel" and getElementModel(source) == 608 then
    if isElementStreamedIn(source) then
      trailerStreamIn(source)
    end
  elseif data == "paintshopTrailerBoxes" and getElementModel(source) == 611 then
    if isElementStreamedIn(source) then
      trailerExStreamIn(source)
    end
  elseif data == "towCar" and source == myVehicle then
    myTrailer = new
  end
end)
addEventHandler("onClientElementStreamIn", getRootElement(), function()
  if getElementModel(source) == 608 then
    trailerStreamIn(source)
  elseif getElementModel(source) == 611 then
    trailerExStreamIn(source)
  end
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
  if getElementModel(source) == 608 then
    trailerStreamOut(source)
  elseif getElementModel(source) == 611 then
    trailerExStreamOut(source)
  end
end)
addEventHandler("onClientElementDestroy", getRootElement(), function()
  if getElementModel(source) == 608 then
    trailerStreamOut(source)
    handleTextureDestroy(source)
  elseif getElementModel(source) == 611 then
    trailerExStreamOut(source)
  end
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  local vehs = getElementsByType("vehicle", getRootElement(), true)
  for i = 1, #vehs do
    if getElementModel(vehs[i]) == 608 then
      trailerStreamIn(vehs[i])
    elseif getElementModel(vehs[i]) == 611 then
      trailerExStreamIn(vehs[i])
    end
  end
end)
local stripe = dxCreateTexture("files/stripe.png", "dxt1")
local whiteText = dxCreateTexture("files/w.png", "dxt1")
addEvent("createPaintshopTargetMarker", true)
addEventHandler("createPaintshopTargetMarker", getRootElement(), function(dropoff, ws)
  if isElement(currentMarker) then
    destroyElement(currentMarker)
  end
  currentMarker = nil
  if isElement(currentBlip) then
    destroyElement(currentBlip)
  end
  currentBlip = nil
  if dropoff or ws then
    local x, y, z, dim = 0, 0, 0, 0
    if ws then
      local rz = 0
      local doorId, aisleId, insideId = getAisleFromWorkshop(ws)
      currentMarkerWS = {
        doorId,
        aisleId,
        insideId
      }
      x, y, z, rz = unpack(aisleDoors[insideId])
      x = x + lobbyX
      y = y + lobbyY
      z = z + lobbyZ + 1
      local rad = math.rad(rz) - math.pi / 2
      x = x + math.cos(rad) * 6.66072
      y = y + math.sin(rad) * 6.66072
      dim = aisleId
    else
      currentMarkerWS = false
      x, y, z = unpack(dropoffPoses[dropoff] or dropoffPoses[1])
    end
    currentBlip = createBlip(x, y, z, 1, 2, green[1], green[2], green[3])
    currentMarker = createMarker(x, y, z - 1, "cylinder", 2.5, green[1], green[2], green[3])
    setElementData(currentBlip, "tooltipText", "Autószállítás (fényezés)")
    setElementInterior(currentMarker, targetIntLobby)
    setElementDimension(currentMarker, dim)
    processCarBlip(getElementDimension(localPlayer))
  else
    currentMarkerWS = false
  end
end)
local orderZoneX, orderZoneY
local orderNpcs = {}
local orderLoadPoses = false
orderZoneX, orderZoneY = -1917.015625, 292.727539062
orderLoadPoses = {
  {
    -1914.8583,
    281.2438,
    -1910.8583,
    286.5305,
    40.067,
    -1922.990234375,
    288.416015625,
    41.046875,
    256.76263427734,
    50,
    "Farkas Tóni"
  },
  {
    -1914.8583,
    300.817,
    -1910.8583,
    306.1036,
    40.067,
    -1922.7685546875,
    298.7578125,
    41.046875,
    299.6923828125,
    305,
    "Masinás Miklós"
  }
}
for i = 1, #orderLoadPoses do
  local npc = createPed(orderLoadPoses[i][10], orderLoadPoses[i][6], orderLoadPoses[i][7], orderLoadPoses[i][8], orderLoadPoses[i][9])
  setElementFrozen(npc, true)
  setElementData(npc, "visibleName", orderLoadPoses[i][11])
  setElementData(npc, "pedNameType", "MiguItalia rendelés átvétel")
  setElementData(npc, "invulnerable", true)
  orderNpcs[npc] = i
end
local currentOrderZone = false
local pickUpZone = false
local pickUpWS = false
local pickUpCol = false
local foundTrailer = false
local orderListWindow = false
local orderListButtons = {}
addEvent("paintshopOrderPickupYes", false)
addEventHandler("paintshopOrderPickupYes", getRootElement(), function()
  triggerServerEvent("tryToPickUpPaintshopOrder", localPlayer, pickUpWS, foundTrailer)
  deletePaintshopOrderList()
  if isElement(pickUpCol) then
    destroyElement(pickUpCol)
  end
  pickUpCol = nil
  pickUpZone = false
  pickUpWS = false
  foundTrailer = false
end)
addEvent("paintshopOrderPickupNo", false)
addEventHandler("paintshopOrderPickupNo", getRootElement(), function()
  deletePaintshopOrderList()
  if isElement(pickUpCol) then
    destroyElement(pickUpCol)
  end
  pickUpCol = nil
  pickUpWS = false
  pickUpZone = false
  foundTrailer = false
end)
addEventHandler("onClientClick", getRootElement(), function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
  if state == "down" and orderNpcs[clickedElement] and not orderListWindow then
    local px, py = getElementPosition(localPlayer)
    if getDistanceBetweenPoints2D(px, py, orderLoadPoses[orderNpcs[clickedElement]][6], orderLoadPoses[orderNpcs[clickedElement]][7]) > 2 then
      return
    end
    if pickUpZone then
      if pickUpZone == orderNpcs[clickedElement] then
        if foundTrailer then
          local titleBarHeight = sightexports.sGui:getTitleBarHeight()
          local pw = 350
          local ph = titleBarHeight + 100
          deletePaintshopOrderList()
          orderListWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
          sightexports.sGui:setWindowTitle(orderListWindow, "16/BebasNeueRegular.otf", "Rendelés átvétele")
          sightexports.sGui:setWindowCloseButton(orderListWindow, "closePaintshopOrderList")
          local plate = getVehiclePlateText(foundTrailer)
          local numberPlate = split(plate, "-")
          numberPlate = table.concat(numberPlate, "-")
          local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - 8 - 32 - 8 - titleBarHeight, orderListWindow)
          sightexports.sGui:setLabelAlignment(label, "center", "center")
          sightexports.sGui:setLabelText(label, "Felrakodás a következő utánfutóra: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. numberPlate)
          sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
          local w = (pw - 24) / 2
          local btn = sightexports.sGui:createGuiElement("button", 8, ph - 8 - 32, w, 32, orderListWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
          sightexports.sGui:setGuiHover(btn, "gradient", {
            "sightgreen",
            "sightgreen-second"
          }, false, true)
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonText(btn, "Igen")
          sightexports.sGui:setClickEvent(btn, "paintshopOrderPickupYes")
          local btn = sightexports.sGui:createGuiElement("button", pw - w - 8, ph - 8 - 32, w, 32, orderListWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
          sightexports.sGui:setGuiHover(btn, "gradient", {
            "sightred",
            "sightred-second"
          }, false, true)
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonText(btn, "Nem")
          sightexports.sGui:setClickEvent(btn, "paintshopOrderPickupNo")
        else
          sightexports.sGui:showInfobox("e", "Nincs üres utánfutó a felvevő zónában!")
        end
      end
    else
      triggerServerEvent("getPaintshopOrderList", localPlayer)
      currentOrderZone = orderNpcs[clickedElement]
    end
  end
end, true, "high+99999999")
function deletePaintshopOrderList()
  if orderListWindow then
    sightexports.sGui:deleteGuiElement(orderListWindow)
  end
  orderListWindow = false
  orderListButtons = {}
end
addEvent("selectPaintshopOrderPickup", false)
addEventHandler("selectPaintshopOrderPickup", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if orderListButtons[el] then
    pickUpWS = orderListButtons[el]
    pickUpZone = currentOrderZone
    local x = math.min(orderLoadPoses[currentOrderZone][1], orderLoadPoses[currentOrderZone][3])
    local y = math.min(orderLoadPoses[currentOrderZone][2], orderLoadPoses[currentOrderZone][4])
    local sx = math.max(orderLoadPoses[currentOrderZone][1], orderLoadPoses[currentOrderZone][3])
    local sy = math.max(orderLoadPoses[currentOrderZone][2], orderLoadPoses[currentOrderZone][4])
    if isElement(pickUpCol) then
      destroyElement(pickUpCol)
    end
    pickUpCol = createColRectangle(x, y, sx - x, sy - y)
    deletePaintshopOrderList()
    sightexports.sGui:showInfobox("i", "Állj a négyzetre az utánfutóddal, majd gyere vissza a rendelés felvételéhez!")
  end
end)
addEvent("closePaintshopOrderList", false)
addEventHandler("closePaintshopOrderList", getRootElement(), function()
  deletePaintshopOrderList()
  currentOrderZone = false
end)
addEvent("gotPaintshopOrderList", true)
addEventHandler("gotPaintshopOrderList", getRootElement(), function(orders)
  deletePaintshopOrderList()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local pw = 350
  local ph = titleBarHeight + 32 + #orders * 66
  orderListWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowTitle(orderListWindow, "16/BebasNeueRegular.otf", "Rendelés átvétele")
  sightexports.sGui:setWindowCloseButton(orderListWindow, "closePaintshopOrderList")
  local y = titleBarHeight
  local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, orderListWindow)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, "Átvehető rendelések:")
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  y = y + 32

  for i = 1, #orders do
    local border = sightexports.sGui:createGuiElement("hr", 0, y - 1, pw, 2, orderListWindow)
    y = y + 8
    local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 29, orderListWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, (orders[i][3] or "IDK") .. " (#" .. (orders[i][1] or "IDK") .. ")")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    local label = sightexports.sGui:createGuiElement("label", 8, y + 29, 0, 21, orderListWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(orders[i][2]) .. " $")
    sightexports.sGui:setLabelColor(label, "sightgreen")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    local btn = sightexports.sGui:createGuiElement("button", pw - 96 - 8, y + 29, 96, 21, orderListWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
    sightexports.sGui:setButtonText(btn, "Átvétel")
    sightexports.sGui:setClickEvent(btn, "selectPaintshopOrderPickup")
    orderListButtons[btn] = orders[i][1]
    y = y + 58
  end
end)
addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(veh)
  myVehicle = veh
  myTrailer = getElementData(veh, "towCar")
  createMyMarker()
end)
addEventHandler("onClientPreRender", getRootElement(), function()
  if myVehicle and getPedOccupiedVehicle(localPlayer) ~= myVehicle then
    myVehicle = false
    myTrailer = false
    createMyMarker()
  end
  local px, py, pz = getElementPosition(localPlayer)
  if orderListWindow then
    local i = currentOrderZone or pickUpZone
    if getDistanceBetweenPoints2D(px, py, orderLoadPoses[i][6], orderLoadPoses[i][7]) > 2 then
      deletePaintshopOrderList()
      currentOrderZone = false
    end
  end
  foundTrailer = false
  if getDistanceBetweenPoints2D(px, py, orderZoneX, orderZoneY) < 150 then
    local b = 0.075
    for i = 1, #orderLoadPoses do
      local w = orderLoadPoses[i][3] - orderLoadPoses[i][1]
      local x = orderLoadPoses[i][1] + w / 2
      local y1 = orderLoadPoses[i][2]
      local y2 = orderLoadPoses[i][4]
      local h = y2 - y1
      local yc = y1 + h / 2
      local z = orderLoadPoses[i][5]
      local c = tocolor(255, 255, 255)
      if i == pickUpZone then
        local vehs = getElementsWithinColShape(pickUpCol, "vehicle")
        for i = 1, #vehs do
          if getElementModel(vehs[i]) == 611 and not transferBoxes[vehs[i]] then
            foundTrailer = vehs[i]
            break
          end
        end
        if foundTrailer then
          c = tocolor(green[1], green[2], green[3])
        else
          c = tocolor(red[1], red[2], red[3])
        end
      end
      dxDrawMaterialSectionLine3D(x, y1 + b * 2, z, x, y2 - b * 2, z, 0, 0, 64 * (w - b * 4) * 1.5, 64 * (h - b * 4) * 1.5, stripe, w - b * 4, c, x, yc, z + 1)
      dxDrawMaterialLine3D(orderLoadPoses[i][1], y1 + b, z, orderLoadPoses[i][3], y1 + b, z, whiteText, b * 2, c, orderLoadPoses[i][1] + w / 2, y1 + b, z + 1)
      dxDrawMaterialLine3D(orderLoadPoses[i][1], y2 - b, z, orderLoadPoses[i][3], y2 - b, z, whiteText, b * 2, c, orderLoadPoses[i][1] + w / 2, y2 - b, z + 1)
      dxDrawMaterialLine3D(orderLoadPoses[i][1] + b, y1, z, orderLoadPoses[i][1] + b, y2, z, whiteText, b * 2, c, orderLoadPoses[i][1] + b, y1 + h / 2, z + 1)
      dxDrawMaterialLine3D(orderLoadPoses[i][3] - b, y1, z, orderLoadPoses[i][3] - b, y2, z, whiteText, b * 2, c, orderLoadPoses[i][3] - b, y1 + h / 2, z + 1)
    end
  end
end)
