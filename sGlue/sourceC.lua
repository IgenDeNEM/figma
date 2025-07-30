local sightexports = {sPermission = false, sGui = false}
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
local glueState = false
local glueModels = {
  [548] = true, -- Cargobob (ARMY Helikopter)
  [508] = true, -- Camper
  [505] = true, -- Hummer (ARMY)
  [578] = true, -- Trailer (Nem PARK.F.)
  [577] = true, -- Repülő (Szigetes)
  [406] = true, -- Dömper
  [433] = true, -- Barracks (ARMY)
  [427] = true, -- Enforcer (Nem PSZ)
  [407] = true, -- Tűzoltó (FD)
  [416] = true, -- Sprinter (EMS)
  [590] = true, -- Vonatszerelvény (Kocsi)
  [538] = true, -- Vonat (Highspeed)
  [570] = true, -- Vonat (Highspeed fehér)
  [569] = true, -- Vonatszerelvény (Platós)
  [537] = true, -- Vonat (Teher)
  [449] = true, -- Villamos (SF)
  [495] = true, -- Ford F-150 Raptor
  [608] = true, -- Trailer (Farmos)
  [611] = true, -- Trailer (Autófényezős)
  [563] = true, -- Raindance (Tűzőltő helikopter)
  [478] = true, -- Walton
  [554] = true, -- Chevrolet Silverado 1500LT
  [422] = true, -- Bobcat
  [528] = true, -- FBI Truck
  [497] = true  -- Police Maverick (PD Helikopter)
}
addCommandHandler("glue", function()
  if glueState then
    triggerServerEvent("unGluePlayer", localPlayer)
    glueState = false
  elseif not getPedOccupiedVehicle(localPlayer) then
    local vehicle = getPedContactElement(localPlayer)
    if vehicle and getElementType(vehicle) == "vehicle" then
      local model = getElementModel(vehicle)
      if getVehicleType(vehicle) == "Boat" or glueModels[model] or sightexports.sPermission:hasPermission(localPlayer, "superGlue") then
        sightexports.sGui:showInfobox("i", "Használtad a /glue parancsot.")
        local px, py, pz = getElementPosition(localPlayer)
        local vx, vy, vz = getElementPosition(vehicle)
        local sx = px - vx
        local sy = py - vy
        local sz = pz - vz
        local rotpX, rotpY, rotpZ = getElementRotation(localPlayer)
        local rotvX, rotvY, rotvZ = getElementRotation(vehicle)
        local t = math.rad(rotvX)
        local p = math.rad(rotvY)
        local f = math.rad(rotvZ)
        local ct = math.cos(t)
        local st = math.sin(t)
        local cp = math.cos(p)
        local sp = math.sin(p)
        local cf = math.cos(f)
        local sf = math.sin(f)
        local z = ct * cp * sz + (sf * st * cp + cf * sp) * sx + (-cf * st * cp + sf * sp) * sy
        local x = -ct * sp * sz + (-sf * st * sp + cf * cp) * sx + (cf * st * sp + sf * cp) * sy
        local y = st * sz - sf * ct * sx + cf * ct * sy
        local rotX = rotpX - rotvX
        local rotY = rotpY - rotvY
        local rotZ = rotpZ - rotvZ
        local slot = getPedWeaponSlot(localPlayer)
        triggerServerEvent("gluePlayer", localPlayer, slot, vehicle, x, y, z, rotX, rotY, rotZ)
        glueState = true
      end
    end
  end
end)
addEventHandler("onClientPlayerWasted", getRootElement(), function()
  if source == localPlayer and glueState then
    triggerServerEvent("unGluePlayer", localPlayer)
    glueState = false
  end
end)
local playerGlueState = {}
local playerRotations = {}
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  local players = getElementsByType("player")
  for k = 1, #players do
    playerGlueState[players[k]] = getElementData(players[k], "playerGlueState")
    playerRotations[players[k]] = getElementData(players[k], "playerGlueRotation")
  end
end)
addEventHandler("onClientElementDataChange", getRootElement(), function(dataName, oldValue)
  if dataName == "playerGlueState" then
    playerGlueState[source] = getElementData(source, "playerGlueState")
    if isElement(playerGlueState[source]) then
      glueState = true
    end
  elseif dataName == "playerGlueRotation" then
    playerRotations[source] = getElementData(source, "playerGlueRotation")
    if not tonumber(playerRotations[source]) then
      playerRotations[source] = nil
    end
  elseif source == localPlayer and (dataName == "cuffed" or dataName == "tazed") and glueState then
    triggerServerEvent("unGluePlayer", localPlayer)
    glueState = false
  end
end)
addEventHandler("onClientRender", getRootElement(), function()
  for player, rotation in pairs(playerRotations) do
    if isElement(player) then
      if rotation and isElement(playerGlueState[player]) then
        local rx, ry, rz = getElementRotation(playerGlueState[player])
        setElementRotation(player, 0, 0, rz + rotation)
      else
        playerRotations[player] = nil
      end
    else
      playerRotations[player] = nil
    end
  end
end, true, "HIGH+9999999")
