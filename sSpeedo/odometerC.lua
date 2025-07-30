local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderMileage, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderMileage)
    end
  end
end
currentMileage = 0
lastSave = 0
frontBrakeDistance = 0
rearBrakeDistance = 0
addEvent("gotVehicleOdometer", true)
addEventHandler("gotVehicleOdometer", getRootElement(), function(val, veh, force)
  if source ~= localPlayer and veh == currentVehicle and (currentSeat ~= 0 or force) then
    currentMileage = val
  end
end)
addEvent("requestOdometerSync", true)
addEventHandler("requestOdometerSync", getRootElement(), function()
  if currentVehicle then
    triggerEvent("syncOdometer", currentVehicle, currentMileage)
  end
end)
function preRenderMileage(delta)
  if currentMileage >= 0 then
    currentMileage = currentMileage + getVehicleSpeed(currentVehicle, "KM/H") * delta / 3600000
  end
  if currentSeat == 0 and currentMileage - lastSave > 5 then
    saveVehicleMileage()
  end
end
if isElement(currentVehicle) then
  triggerServerEvent("getVehicleOdometer", currentVehicle, true)
  lastSave = currentMileage
  sightlangCondHandl0(currentVehicle)
end
function startOdometer()
  triggerServerEvent("getVehicleOdometer", currentVehicle, true)
  lastSave = currentMileage
  frontBrakeDistance = 0
  rearBrakeDistance = 0
  sightlangCondHandl0(currentVehicle)
end
addEventHandler("onClientPlayerVehicleEnter", getRootElement(), function(vehicle, seat)
  if vehicle == currentVehicle and source ~= localPlayer and currentSeat == 0 then
    saveVehicleMileage()
  end
end, true, "low-99999999")
function saveVehicleMileage(exit)
  if isElement(currentVehicle) and tonumber(currentMileage) and currentMileage >= 0 and currentSeat == 0 then
    triggerServerEvent("setVehicleOdometer", currentVehicle, currentMileage, frontBrakeDistance, rearBrakeDistance)
    triggerEvent("syncOdometer", currentVehicle, currentMileage)
    lastSave = currentMileage
    frontBrakeDistance = 0
    rearBrakeDistance = 0
  end
  if exit then
    sightlangCondHandl0(false)
  end
end
addEventHandler("onClientResourceStop", getResourceRootElement(), saveVehicleMileage)
