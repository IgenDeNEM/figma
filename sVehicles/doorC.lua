local player = getLocalPlayer()
function getPlayerToVehicleRelatedPosition()
  local camTarget = getPedTarget(player)
  if camTarget and getElementType(camTarget) == "vehicle" then
    local vx, vy, vz = getElementPosition(camTarget)
    local rxv, ryv, rzv = getElementRotation(camTarget)
    local px, py, pz = getElementPosition(player)
    local anglePlayerToVehicle = math.atan2(px - vx, py - vy)
    local formattedAnglePlayerToVehicle = math.deg(anglePlayerToVehicle) + 180
    local vehicleRelatedPosition = formattedAnglePlayerToVehicle + rzv
    if vehicleRelatedPosition < 0 then
      vehicleRelatedPosition = vehicleRelatedPosition + 360
    elseif 360 < vehicleRelatedPosition then
      vehicleRelatedPosition = vehicleRelatedPosition - 360
    end
    return math.floor(vehicleRelatedPosition) + 0.5
  else
    return false
  end
end
function getDoor(vehicle)
  if vehicle then
    local pos = getPlayerToVehicleRelatedPosition()
    if 120 <= pos and pos <= 240 then
      return 0
    end
    if 330 <= pos and pos <= 360 or 0 <= pos and pos <= 30 then
      return 1
    end
    if 85 <= pos and pos <= 120 then
      return 2
    end
    if 240 <= pos and pos <= 285 then
      return 3
    end
    if 30 <= pos and pos <= 75 then
      return 4
    end
    if 275 <= pos and pos <= 330 then
      return 5
    end
  end
  return nil
end
function onDoorOpen()
  local ws = exports.sPaintshop:isPlayerInWorkshop()
  if ws then return end
  if getPedWeapon(localPlayer) == 0 and not isCursorShowing() and not getPedOccupiedVehicle(localPlayer) then
    local camTarget = getPedTarget(player)
    if isElement(camTarget) and getElementType(camTarget) == "vehicle" then
      local sourceX, sourceY, sourceZ = getElementPosition(localPlayer)
      local targetX, targetY, targetZ = getElementPosition(camTarget)
      if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 5 then
        if not isVehicleLocked(camTarget) then
          local door = getDoor(camTarget)
          if door then
            if door == 4 then
              if not getVehicleComponentPosition(camTarget, "door_lr_dummy") then
                door = 2
              end
            elseif door == 5 and not getVehicleComponentPosition(camTarget, "door_rr_dummy") then
              door = 3
            end
            triggerServerEvent("doServerChanges", localPlayer, camTarget, door, player)
          end
        else
          outputChatBox("#f35a5a[SightMTA]: #FFFFFFA jármű be van zárva!", 255, 255, 255, true)
        end
      end
    end
  end
end
bindKey("mouse2", "down", onDoorOpen)
addEvent("playDoorEffect", true)
addEventHandler("playDoorEffect", getRootElement(), function(vehicleElement, soundType)
  if isElement(vehicleElement) and soundType then
    local posX, posY, posZ = getElementPosition(vehicleElement)
    local interior = getElementInterior(vehicleElement)
    local dimension = getElementDimension(vehicleElement)
    local soundElement = playSound3D("files/door" .. soundType .. ".mp3", posX, posY, posZ)
    setElementInterior(soundElement, interior)
    setElementDimension(soundElement, dimension)
    attachElements(soundElement, vehicleElement)
  end
end)
