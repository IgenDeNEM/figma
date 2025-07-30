local vehicleAppliedTexIds = {}
local vehicleAppliedWheels = {}
local vehicleAppliedHeadlights = {}
local getVehicleApplyInfo = function(model)
  return vehPjApplyInfo[model]
end
local function getVehicleAppliablePjs(model)
  local applyInfo = getVehicleApplyInfo(model)
  if not applyInfo then
    return false
  end
  return applyInfo.pjTexIds
end
local function getVehicleAppliableHeadlights(model)
  local applyInfo = getVehicleApplyInfo(model)
  if not applyInfo then
    return false
  end
  return applyInfo.headlightTexIds
end
local function getVehicleAppliableWheel(model)
  local applyInfo = getVehicleApplyInfo(model)
  if not applyInfo then
    return false
  end
  return applyInfo.wheelTexIds
end
function removeVehicleCurrentPjTexture(vehicle)
  local appliedTexId = vehicleAppliedTexIds[vehicle]
  if not appliedTexId then
    return false
  end
  local applyInfo = getVehicleApplyInfo(getElementData(vehicle, "vehicle.customModel") or getElementModel(vehicle))
  if not removeTextureFromElementTexture(vehicle, applyInfo.texName, appliedTexId) then
    return
  end
  vehicleAppliedTexIds[vehicle] = nil
  return true
end
function getVehiclePJ(model, pjid)
  local applyInfo = getVehicleApplyInfo(model)
  if not applyInfo then
    return false
  end
  if not applyInfo.pjTexIds then
    return false
  end
  local texid = applyInfo.pjTexIds[pjid]
  if not texid then
    return false
  end
  if not texid then
    return false
  end
  local file = textureFilePaths[texid]
  if not file then
    return false
  end
  return applyInfo.texName, file, textureDXT[texid] or "dxt1"
end
function getVehicleHeadlight(model, pjid)
  local applyInfo = getVehicleApplyInfo(model)
  if not applyInfo then
    return false
  end
  if not applyInfo.headlightTexIds then
    return false
  end
  local texid = applyInfo.headlightTexIds[pjid]
  if not texid then
    return false
  end
  if not texid then
    return false
  end
  local file = textureFilePaths[texid]
  if not file then
    return false
  end
  return applyInfo.headlightName, file, textureDXT[texid] or "dxt1"
end
function getVehicleWheel(model, wheelTuning, pjid)
  if wheelTuning and 0 < wheelTuning then
    model = wheelTuning
  end
  local applyInfo = getVehicleApplyInfo(model)
  if not applyInfo then
    return false
  end
  if not applyInfo.wheelTexIds then
    return false
  end
  local texid = applyInfo.wheelTexIds[pjid]
  if not texid then
    return false
  end
  if not texid then
    return false
  end
  local file = textureFilePaths[texid]
  if not file then
    return false
  end
  return applyInfo.wheelName, file, textureDXT[texid] or "dxt1"
end
local function applyVehiclePj(vehicle, pjid)
  removeVehicleCurrentPjTexture(vehicle)
  local applyInfo = getVehicleApplyInfo(getElementData(vehicle, "vehicle.customModel") or getElementModel(vehicle))
  if not applyInfo then
    return false
  end
  if not applyInfo.pjTexIds then
    return false
  end
  local texid = applyInfo.pjTexIds[pjid]
  if not texid then
    return false
  end
  if (vehicleAppliedTexIds[vehicle] or -1) == texid then
    return true
  end
  if pjid == 0 then
    return true
  end
  if not applyTextureToElementTexture(vehicle, applyInfo.texName, texid) then
    return false
  end
  vehicleAppliedTexIds[vehicle] = texid
  return true
end
function removeVehicleCurrentWheelTexture(vehicle)
  local appliedTexId = vehicleAppliedWheels[vehicle]
  if not appliedTexId then
    return false
  end
  if not removeTextureFromElementTexture(vehicle, "*", appliedTexId) then
    return
  end
  vehicleAppliedWheels[vehicle] = nil
  return true
end
local function applyVehicleWheel(vehicle, pjid)
  removeVehicleCurrentWheelTexture(vehicle)
  local model = false
  local wheelTuning = getVehicleUpgradeOnSlot(vehicle, 12)
  if 0 < wheelTuning then
    model = wheelTuning
  else
    model = getElementData(vehicle, "vehicle.customModel") or getElementModel(vehicle)
  end
  if not model then
    return false
  end
  local applyInfo = getVehicleApplyInfo(model)
  if not applyInfo then
    return false
  end
  if not applyInfo.wheelTexIds then
    return false
  end
  local texid = applyInfo.wheelTexIds[pjid]
  if not texid then
    return false
  end
  if (vehicleAppliedWheels[vehicle] or -1) == texid then
    return true
  end
  if pjid == 0 then
    return true
  end
  if not applyTextureToElementTexture(vehicle, applyInfo.wheelName, texid) then
    return false
  end
  vehicleAppliedWheels[vehicle] = texid
  return true
end
function removeVehicleCurrentHeadlightTexture(vehicle)
  local appliedTexId = vehicleAppliedHeadlights[vehicle]
  if not appliedTexId then
    return false
  end
  local applyInfo = getVehicleApplyInfo(getElementData(vehicle, "vehicle.customModel") or getElementModel(vehicle))
  if not removeTextureFromElementTexture(vehicle, applyInfo.headlightName, appliedTexId) then
    return
  end
  vehicleAppliedHeadlights[vehicle] = nil
  return true
end
local function applyVehicleHeadlight(vehicle, pjid)
  removeVehicleCurrentHeadlightTexture(vehicle)
  local applyInfo = getVehicleApplyInfo(getElementData(vehicle, "vehicle.customModel") or getElementModel(vehicle))
  if not applyInfo then
    return false
  end
  if not applyInfo.headlightTexIds then
    return false
  end
  local texid = applyInfo.headlightTexIds[pjid]
  if not texid then
    return false
  end
  if (vehicleAppliedHeadlights[vehicle] or -1) == texid then
    return true
  end
  if pjid == 0 then
    return true
  end
  if not applyTextureToElementTexture(vehicle, applyInfo.headlightName, texid) then
    return false
  end
  vehicleAppliedHeadlights[vehicle] = texid
  return true
end
function maybeApplyVehicleStoredPj(vehicle, input)
  local pjid = input or getElementData(vehicle, "vehicle.currentTexture")
  return pjid and pjid ~= 0 and applyVehiclePj(vehicle, pjid)
end
function maybeApplyVehicleStoredHeadlight(vehicle, input)
  local pjid = input or getElementData(vehicle, "vehicle.currentHeadlightTexture")
  return pjid and pjid ~= 0 and applyVehicleHeadlight(vehicle, pjid)
end
function maybeApplyVehicleStoredWheel(vehicle, input)
  local pjid = input or getElementData(vehicle, "vehicle.currentWheelTexture")
  return pjid and pjid ~= 0 and applyVehicleWheel(vehicle, pjid)
end
function vehicleDataChange(dataName, oldValue, newValue)
  if dataName == "vehicle.currentTexture" then
    applyVehiclePj(source, newValue or 0)
  elseif dataName == "vehicle.currentWheelTexture" then
    applyVehicleWheel(source, newValue or 0)
  elseif dataName == "vehicle.currentHeadlightTexture" then
    applyVehicleHeadlight(source, newValue or 0)
  end
end
local eventHandled = {}
local function onPjedVehicleStreamOutHandler()
  removeVehicleCurrentPjTexture(source)
  removeVehicleCurrentHeadlightTexture(source)
  removeVehicleCurrentWheelTexture(source)
  if eventHandled[source] then
    removeEventHandler("onClientElementStreamOut", source, onPjedVehicleStreamOutHandler)
    removeEventHandler("onClientElementDestroy", source, onPjedVehicleStreamOutHandler)
  end
  eventHandled[source] = nil
end
local function onVehicleStreamInHandler(pjid, whid, hlid)
  if not eventHandled[source] then
    eventHandled[source] = true
    addEventHandler("onClientElementStreamOut", source, onPjedVehicleStreamOutHandler)
    addEventHandler("onClientElementDestroy", source, onPjedVehicleStreamOutHandler)
  end
  maybeApplyVehicleStoredPj(source, pjid)
  maybeApplyVehicleStoredWheel(source, whid)
  maybeApplyVehicleStoredHeadlight(source, hlid)
end
local streamHandled = {}
function deHandleStream()
  if streamHandled[source] then
    removeEventHandler("onClientElementDataChange", source, vehicleDataChange)
    removeEventHandler("onClientElementDestroy", source, deHandleStream)
    removeEventHandler("onClientElementStreamOut", source, deHandleStream)
  end
  streamHandled[source] = nil
end
addEventHandler("onClientVehicleStreamIn", root, function()
  if not streamHandled[source] then
    streamHandled[source] = true
    addEventHandler("onClientElementDataChange", source, vehicleDataChange)
    addEventHandler("onClientElementDestroy", source, deHandleStream)
    addEventHandler("onClientElementStreamOut", source, deHandleStream)
  end
  local pjid = getElementData(source, "vehicle.currentTexture") or 0
  local whid = getElementData(source, "vehicle.currentWheelTexture") or 0
  local hlid = getElementData(source, "vehicle.currentHeadlightTexture") or 0
  if 0 < pjid or 0 < whid or 0 < hlid then
    onVehicleStreamInHandler(pjid, whid, hlid)
  end
end)
local function loadStreamedInVehiclePjs()
  local vehicles = getElementsByType("vehicle", root, true)
  for i = 1, #vehicles do
    source = vehicles[i]
    if not streamHandled[source] then
      streamHandled[source] = true
      addEventHandler("onClientElementDataChange", source, vehicleDataChange)
      addEventHandler("onClientElementDestroy", source, deHandleStream)
      addEventHandler("onClientElementStreamOut", source, deHandleStream)
    end
    local pjid = getElementData(source, "vehicle.currentTexture") or 0
    local whid = getElementData(source, "vehicle.currentWheelTexture") or 0
    local hlid = getElementData(source, "vehicle.currentHeadlightTexture") or 0
    if 0 < pjid or 0 < whid or 0 < hlid then
      onVehicleStreamInHandler(pjid, whid, hlid)
    end
  end
end
addEventHandler("onClientResourceStart", resourceRoot, loadStreamedInVehiclePjs)
function getPaintJobCount(model)
  local model = (model)
  if not model then
    return false
  end
  local appliablePjs = getVehicleAppliablePjs(model)
  if not appliablePjs then
    return false
  end
  local c = #appliablePjs
  if vehPjApplyInfo[model].protected then
    c = c - vehPjApplyInfo[model].protected
  end
  if c <= 0 then
    return false
  end
  return c
end
function getWheelPaintJobCount(model)
  local model = (model)
  if not model then
    return false
  end
  local appliablePjs = getVehicleAppliableWheel(model)
  if not appliablePjs then
    return false
  end
  local c = #appliablePjs
  return c
end
function getHeadlightPaintJobCount(model)
  local model = (model)
  if not model then
    return false
  end
  local appliablePjs = getVehicleAppliableHeadlights(model)
  if not appliablePjs then
    return false
  end
  local c = #appliablePjs
  return c
end
