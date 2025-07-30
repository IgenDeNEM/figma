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
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), burnoutRender, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), burnoutRender)
    end
  end
end
function getElementSpeed(theElement, unit)
  local speedx, speedy, speedz = getElementVelocity(theElement)
  return (speedx ^ 2 + speedy ^ 2 + speedz ^ 2) ^ 0.5 * 180
end
local vehicleHeats = {}
local vehicle = false
local drive = false
addEventHandler("onClientVehicleEnter", getRootElement(), function(thePlayer, seat)
  if thePlayer == localPlayer and seat == 0 then
    vehicle = source
    local h = getVehicleHandling(source)
    drive = h.driveType
    sightlangCondHandl0(true)
  end
end)
function burnoutRender(delta)
  if isElement(vehicle) and getVehicleEngineState(vehicle) then
    if getPedOccupiedVehicle(localPlayer) == vehicle then
      local b1, b2, b3 = false, false, false
      for k in pairs(getBoundKeys("accelerate")) do
        if getKeyState(k) then
          b1 = true
        end
      end
      if drive == "awd" or drive == "rwd" then
        for k in pairs(getBoundKeys("brake_reverse")) do
          if getKeyState(k) then
            b2 = true
          end
        end
      end
      if drive == "awd" or drive == "fwd" then
        for k in pairs(getBoundKeys("handbrake")) do
          if getKeyState(k) then
            b3 = true
          end
        end
      end
      if not vehicleHeats[vehicle] then
        vehicleHeats[vehicle] = {}
        vehicleHeats[vehicle][1] = 0
        vehicleHeats[vehicle][2] = 0
        vehicleHeats[vehicle][3] = 0
        vehicleHeats[vehicle][4] = 0
      end
      if b1 and b2 and (not b2 or not b3) and getElementSpeed(vehicle) < 20 then
        vehicleHeats[vehicle][1] = vehicleHeats[vehicle][1] + delta / math.random(100, 2250) * 1000
        vehicleHeats[vehicle][2] = vehicleHeats[vehicle][2] + delta / math.random(100, 2250) * 1000
        if 100 < vehicleHeats[vehicle][1] / 10000 * 100 then
          triggerServerEvent("damageWheels", vehicle, 1)
          vehicleHeats[vehicle][1] = 0
          sightexports.sGui:showInfobox("e", "Túlmelegedett a gumid, és kidurrant!")
        end
        if 100 < vehicleHeats[vehicle][2] / 10000 * 100 then
          triggerServerEvent("damageWheels", vehicle, 2)
          vehicleHeats[vehicle][2] = 0
          sightexports.sGui:showInfobox("e", "Túlmelegedett a gumid, és kidurrant!")
        end
      else
        if vehicleHeats[vehicle][1] > 0 then
          vehicleHeats[vehicle][1] = vehicleHeats[vehicle][1] - delta / math.random(100, 1000) * 1000
        end
        if 0 < vehicleHeats[vehicle][2] then
          vehicleHeats[vehicle][2] = vehicleHeats[vehicle][2] - delta / math.random(100, 1000) * 1000
        end
      end
      if b1 and b3 and (not b2 or not b3) and getElementSpeed(vehicle) < 20 then
        vehicleHeats[vehicle][3] = vehicleHeats[vehicle][3] + delta / math.random(100, 2550) * 1000
        vehicleHeats[vehicle][4] = vehicleHeats[vehicle][4] + delta / math.random(100, 2250) * 1000
        if 100 < vehicleHeats[vehicle][3] / 10000 * 100 then
          triggerServerEvent("damageWheels", vehicle, 3)
          vehicleHeats[vehicle][3] = 0
          sightexports.sGui:showInfobox("e", "Túlmelegedett a gumid, és kidurrant!")
        end
        if 100 < vehicleHeats[vehicle][4] / 10000 * 100 then
          triggerServerEvent("damageWheels", vehicle, 4)
          vehicleHeats[vehicle][4] = 0
          sightexports.sGui:showInfobox("e", "Túlmelegedett a gumid, és kidurrant!")
        end
      else
        if 0 < vehicleHeats[vehicle][3] then
          vehicleHeats[vehicle][3] = vehicleHeats[vehicle][3] - delta / math.random(100, 1000) * 1000
        end
        if 0 < vehicleHeats[vehicle][4] then
          vehicleHeats[vehicle][4] = vehicleHeats[vehicle][4] - delta / math.random(100, 1000) * 1000
        end
      end
    else
      sightlangCondHandl0(false)
    end
  else
    sightlangCondHandl0(false)
  end
end
