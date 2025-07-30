local oldRPH = updateElementRpHAnim
local updateRPHList = {}
function updateElementRpHAnim(el)
  updateRPHList[el] = true
end
local oldCar = 0
addEventHandler("onClientVehicleEnter", getRootElement(), function(player, seat)
  if player == localPlayer then
    local dbId = getElementData(source, "vehicle.dbID")
    oldCar = dbId
  end
end)
addCommandHandler("oldcar", function()
  outputChatBox("[color=sightgreen][SightMTA]: #FFFFFFElőző járműved: [color=sightblue]" .. oldCar, 255, 255, 255, true)
end)
addEventHandler("onClientPedsProcessed", getRootElement(), function()
  for el in pairs(updateRPHList) do
    updateRPHList[el] = nil
    oldRPH(el)
  end
end, true, "low-99999999")
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  engineSetAsynchronousLoading(true, true)
  for k, v in pairs(getElementsByType("player")) do
    setPedVoice(v, "PED_TYPE_DISABLED")
  end
  for k, v in pairs(getElementsByType("ped")) do
    setPedVoice(v, "PED_TYPE_DISABLED")
  end
  setAmbientSoundEnabled("general", true)
  setAmbientSoundEnabled("gunfire", false)
  setWorldSpecialPropertyEnabled("extraairresistance", false)
  setPedTargetingMarkerEnabled(false)
end)
addEventHandler("onClientElementStreamIn", getRootElement(), function()
  local elementType = getElementType(source)
  if elementType == "ped" or elementType == "player" then
    setPedVoice(source, "PED_TYPE_DISABLED")
  end
end)
local urmaChat = false
addEventHandler("onClientElementDataChange", localPlayer, function(dataName, oldValue, newValue)
  if dataName == "urmaChat" then
    urmaChat = newValue or false
  end
end)
addEvent("sendMessageToAdmins", true)
addEventHandler("sendMessageToAdmins", getRootElement(), function(message)
  if (getElementData(localPlayer, "acc.adminLevel") or 0) >= 1 and not urmaChat then
    outputChatBox("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló[color=sightgreen]]: #ffffff" .. message, 255, 255, 255, true)
  end
end)
local charMoney = 0
addEvent("refreshMoney", true)
addEventHandler("refreshMoney", root, function(amount)
  charMoney = amount
end)
function getMoney()
  return charMoney
end
local bankMoney = 0
addEvent("refreshBankMoney", true)
addEventHandler("refreshBankMoney", root, function(amount)
  bankMoney = amount
end)
function getBankMoney()
  return bankMoney
end
addEvent("onClientLocalColShapeHit", false)
addEvent("onClientLocalColShapeLeave", false)
addEventHandler("onClientElementColShapeHit", localPlayer, function(shape, md)
  if isElement(shape) then
    triggerEvent("onClientLocalColShapeHit", shape, md)
  end
end)
addEventHandler("onClientElementColShapeLeave", localPlayer, function(shape, md)
  if isElement(shape) then
    triggerEvent("onClientLocalColShapeLeave", shape, md)
  end
end)
addEvent("onClientPlayerStreamIn", false)
addEvent("onClientPedStreamIn", false)
addEvent("onClientVehicleStreamIn", false)
addEvent("onClientObjectStreamIn", false)
addEvent("onClientPlayerStreamOut", false)
addEvent("onClientPedStreamOut", false)
addEvent("onClientVehicleStreamOut", false)
addEvent("onClientObjectStreamOut", false)
addEvent("onClientPedDestroy", false)
addEvent("onClientVehicleDestroy", false)
addEvent("onClientObjectDestroy", false)
addEvent("onClientPlayerDataChange", false)
addEvent("onClientPedDataChange", false)
addEvent("onClientVehicleDataChange", false)
addEvent("onClientObjectDataChange", false)
addEvent("onClientPlayerModelChange", false)
addEvent("onClientPedModelChange", false)
addEvent("onClientVehicleModelChange", false)
addEvent("onClientObjectModelChange", false)
addEventHandler("onClientElementModelChange", getRootElement(), function(old, new)
  local elType = getElementType(source)
  if elType == "player" then
    triggerEvent("onClientPlayerModelChange", source, old, new)
  elseif elType == "ped" then
    triggerEvent("onClientPedModelChange", source, old, new)
  elseif elType == "vehicle" then
    triggerEvent("onClientVehicleModelChange", source, old, new)
  elseif elType == "object" then
    triggerEvent("onClientObjectModelChange", source, old, new)
  end
end)
addEventHandler("onClientElementDataChange", getRootElement(), function(data, old, new)
  local elType = getElementType(source)
  if elType == "player" then
    triggerEvent("onClientPlayerDataChange", source, data, old, new)
  elseif elType == "ped" then
    triggerEvent("onClientPedDataChange", source, data, old, new)
  elseif elType == "vehicle" then
    triggerEvent("onClientVehicleDataChange", source, data, old, new)
  elseif elType == "object" then
    triggerEvent("onClientObjectDataChange", source, data, old, new)
  end
end)
addEventHandler("onClientElementStreamIn", getRootElement(), function()
  local elType = getElementType(source)
  if elType == "player" then
    triggerEvent("onClientPlayerStreamIn", source)
  elseif elType == "ped" then
    triggerEvent("onClientPedStreamIn", source)
  elseif elType == "vehicle" then
    triggerEvent("onClientVehicleStreamIn", source)
  elseif elType == "object" then
    triggerEvent("onClientObjectStreamIn", source)
  end
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
  local elType = getElementType(source)
  if elType == "player" then
    triggerEvent("onClientPlayerStreamOut", source)
  elseif elType == "ped" then
    triggerEvent("onClientPedStreamOut", source)
  elseif elType == "vehicle" then
    triggerEvent("onClientVehicleStreamOut", source)
  elseif elType == "object" then
    triggerEvent("onClientObjectStreamOut", source)
  end
end)
addEventHandler("onClientElementDestroy", getRootElement(), function()
  local elType = getElementType(source)
  if elType == "ped" then
    triggerEvent("onClientPedDestroy", source)
  elseif elType == "vehicle" then
    triggerEvent("onClientVehicleDestroy", source)
  elseif elType == "object" then
    triggerEvent("onClientObjectDestroy", source)
  end
end)


addEvent("refreshPlayedMinutes", true)
addEvent("gotPremiumData", true)
addEvent("refreshSSC", true)
setOcclusionsEnabled(false)
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
  if getVehicleType(source) == "Helicopter" then
    setHeliBladeCollisionsEnabled(source, false)
  end
end)