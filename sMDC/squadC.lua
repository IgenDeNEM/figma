local seexports = {
  sGui = false,
  sGroups = false,
  sNames = false
}

local function sightlangProcessExports()
  for k in pairs(seexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      seexports[k] = exports[k]
    else
      seexports[k] = false
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

local sightlangGuiRefreshColors = function()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    refreshColors()
  end
end

addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local red = {255,255,255}

local blue = {255,255,255}

local vehicleBlips = {}
squads = {}
local backups = {}

function refreshColors()
  red = seexports.sGui:getColorCode("sightred")
  blue = seexports.sGui:getColorCode("sightblue")
  for veh, blip in pairs(vehicleBlips) do
    setBlipColor(blip, blue[1], blue[2], blue[3], 255)
  end
  for veh in pairs(squads) do
    refreshSquad(veh)
  end
end

local permState = false

if getElementData(localPlayer, "loggedIn") then
  permState = seexports.sGroups:getPlayerPermission("squad") and true or false
end

addEventHandler("onClientElementDimensionChange", getRootElement(), function()
  if squads[source] then
    refreshSquad(source)
  end
end)

addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(veh)
  if squads[veh] then
    refreshSquad(veh)
  end
end)

addEventHandler("onClientPlayerVehicleExit", localPlayer, function(veh)
  if squads[veh] then
    refreshSquad(veh)
  end
end)

function refreshSquad(veh)
  if permState then
    if isElement(veh) and squads[veh] then
      if getElementDimension(veh) == 0 then
        local col = {
          255,
          255,
          255
        }
        col = squads[veh][3] and seexports.sGui:getColorCode("sight" .. definedSquadColors[squads[veh][3] or 1]) or col
        if not isElement(vehicleBlips[veh]) then
          vehicleBlips[veh] = createBlipAttachedTo(veh, 5, 2, col[1], col[2], col[3])
        else
          setBlipColor(vehicleBlips[veh], col[1], col[2], col[3], 255)
          setBlipIcon(vehicleBlips[veh], 5)
        end
        setElementData(vehicleBlips[veh], "tooltipText", (squads[veh][4] and "Erősítés" or "Egység") .. ": " .. squads[veh][1] .. "-" .. squads[veh][2])
        setElementData(vehicleBlips[veh], "disableBlipSticky", not squads[veh][4])
        setElementData(vehicleBlips[veh], "disableBlip3D", veh == getPedOccupiedVehicle(localPlayer))
        backups[veh] = squads[veh][4] and true or nil
      else
        if isElement(vehicleBlips[veh]) then
          destroyElement(vehicleBlips[veh])
        end
        vehicleBlips[veh] = nil
      end
    else
      if isElement(vehicleBlips[veh]) then
        destroyElement(vehicleBlips[veh])
      end
      vehicleBlips[veh] = nil
      squads[veh] = nil
      backups[veh] = nil
    end
    if isElement(veh) then
      if squads[veh] then
        seexports.sNames:setVehicleSquad(veh, definedSquadColors[squads[veh][3] or 1], squads[veh][1] .. "-" .. squads[veh][2])
      else
        seexports.sNames:setVehicleSquad(veh)
      end
      if veh == mdcVeh and not activeMdcApp and mdcWindow then
        createDesktop()
      end
    end
  end
end
addEvent("gotPlayerGroupPermissions", true)
addEventHandler("gotPlayerGroupPermissions", getRootElement(), function()

  local tmp = seexports.sGroups:getPlayerPermission("squad") and true or false
  if tmp ~= permState then
    permState = tmp
    if permState then
      addEventHandler("onClientPreRender", getRootElement(), squadsPreRender)
      for veh in pairs(squads) do
        refreshSquad(veh)
      end
    else
      removeEventHandler("onClientPreRender", getRootElement(), squadsPreRender)
      for veh in pairs(squads) do
        if isElement(vehicleBlips[veh]) then
          destroyElement(vehicleBlips[veh])
        end
        vehicleBlips[veh] = nil
      end
    end
  end
end)

addEventHandler("onClientElementDestroy", getRootElement(), function(data)
  if squads[source] then
    squads[source] = nil
    refreshSquad(source)
  end
end)

addEvent("refreshSquads", true)
addEventHandler("refreshSquads", getRootElement(), function(data)
  squads = data
  for veh in pairs(squads) do
    refreshSquad(veh)
  end
end)

addEvent("refreshSquad", true)
addEventHandler("refreshSquad", getRootElement(), function(data)
  if data and data[4] then
    local color = "sight" .. definedSquadColors[data[3] or 1]
    seexports.sGroups:sendGroupMessage("department", false, false, "[color=sightred][SightMTA - Egység]: " .. seexports.sGui:getColorCodeHex(color) .. data[1] .. "-" .. data[2] .. "#ffffff erősítést hívott!", "backup.mp3")
  elseif data and not squads[source] then
    local color = "sight" .. definedSquadColors[data[3] or 1]
    seexports.sGroups:sendGroupMessage("department", false, false, "[color=sightblue][SightMTA - Egység]: " .. seexports.sGui:getColorCodeHex(color) .. data[1] .. "-" .. data[2] .. "#ffffff szolgálatba állt.")
  elseif squads[source] and not data then
    local data = squads[source]
    local color = "sight" .. definedSquadColors[data[3] or 1]
    seexports.sGroups:sendGroupMessage("department", false, false, "[color=sightblue][SightMTA - Egység]: " .. seexports.sGui:getColorCodeHex(color) .. data[1] .. "-" .. data[2] .. "#ffffff kiállt a szolgálatból.")
  end
  if squads[source] and squads[source][4] and data then
    local color = "sight" .. definedSquadColors[1]
    if data and data[3] then
      color = "sight" .. definedSquadColors[data[3]]
    end
    seexports.sGroups:sendGroupMessage("department", false, false, "[color=sightred][SightMTA - Egység]: " .. seexports.sGui:getColorCodeHex(color) .. data[1] .. "-" .. data[2] .. "#ffffff lemondta az erősítést.")
  elseif squads[source] and squads[source][4] then
    local color = "sight" .. definedSquadColors[1]
    if squads[source][3] then
      color = "sight" .. definedSquadColors[squads[source][3]]
    end
    seexports.sGroups:sendGroupMessage("department", false, false, "[color=sightred][SightMTA - Egység]: " .. seexports.sGui:getColorCodeHex(color) .. squads[source][1] .. "-" .. squads[source][2] .. "#ffffff lemondta az erősítést.")
  end
  squads[source] = data
  refreshSquad(source)
end)

triggerServerEvent("requestSquads", localPlayer)

function squadsPreRender()
  for veh in pairs(backups) do
    local blip = vehicleBlips[veh]
    if blip then
      local delta = getTickCount() % 500
      if 250 < delta then
        setBlipColor(blip, red[1], red[2], red[3], 255)
      else
        setBlipColor(blip, blue[1], blue[2], blue[3], 255)
      end
      setBlipIcon(blip, delta % 250 > 125 and 7 or 6)
    end
  end
end
if permState then
  addEventHandler("onClientPreRender", getRootElement(), squadsPreRender)
end
