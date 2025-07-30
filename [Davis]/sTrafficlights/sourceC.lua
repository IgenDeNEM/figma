local trafficLightCols = {}

addEventHandler("onClientResourceStart", root, function()
  triggerServerEvent("requestTrafficColshapes", localPlayer)
end)

addEvent("gotTrafficColshapes", true)
addEventHandler("gotTrafficColshapes", root, function(trafficColshapes)
  trafficLightCols = trafficColshapes
end)
------------------ ---------------------
function canAutoCamCapture()
  local veh = getPedOccupiedVehicle(localPlayer)
  local model = getElementModel(veh)
  if model == 525 or model == 408 then
    return false
  end
  if getVehicleSirensOn(veh) then
    return true
  end
  if getVehicleType(veh) == "Helicopter" then
    return true
  end
  return false
end

function getRotationBetweenPointss(x, y, x2, y2)
  return math.deg(math.atan2(y2 - y, x2 - x)) + 180
end

local lastCapture = 0

addEventHandler("onClientColShapeHit", 
getRootElement(), function(hitElement)
  if trafficLightCols[source] and isPedInVehicle(localPlayer) and hitElement == getPedOccupiedVehicle(localPlayer) and not canAutoCamCapture() and getPedOccupiedVehicleSeat(localPlayer) == 0 then
    local state = getTrafficLightState()
    local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
    local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(localPlayer))
    local facing = "N"
    if 45 < rz and rz <= 135 then
      facing = "W"
    elseif 135 < rz and rz <= 225 then
      facing = "S"
    elseif 225 < rz and rz <= 315 then
      facing = "E"
    end
    local red = false
    if state == 2 then
      red = true
    elseif state == 3 or state == 4 then
      if facing == "N" or facing == "S" then
        red = true
      end
    elseif (state == 0 or state == 1) and (facing == "E" or facing == "W") then
      red = true
    end
    if red and not getElementData(getPedOccupiedVehicle(localPlayer), "vehicle.sirenstate") then
      if getTickCount() - lastCapture < 10000 then
        return
      end
      lastCapture = getTickCount()

      triggerServerEvent("changeForRedLights", localPlayer, red, lastCapture)
      triggerEvent("flashTheScreen", localPlayer)
      exports.sGui:showInfobox("w", "Mivel áthaladtál a piros lámpán, 5 000$ büntetést kaptál")
    end
  end
end)

function getElementSpeed(theElement, unit)
  assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
  local elementType = getElementType(theElement)
  assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
  assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
  unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
  local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
  return (Vector3(getElementVelocity(theElement)) * mult).length
end