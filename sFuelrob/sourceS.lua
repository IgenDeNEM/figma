local availableFuelStations = exports.sFuel:getFuelStations()

local stationStatus = {}
local npcAimData = {}
local previousTarget = {}
local npcTimers = {}
local activeMinigames = {}
local playerCashTimers = {}

succesRobbed = {}

for stationId, _ in pairs(availableFuelStations) do
    npcAimData[stationId] = { [1] = true, [2] = true }
end

addEvent("requestFuelRobData", true)
addEventHandler("requestFuelRobData", root, function()
    triggerClientEvent(client, "gotFuelrobNPCAimAll", client, npcAimData)
end)

local function startAlarmAndDuckTimer(player, station, npcId)
    if not npcTimers[station] then npcTimers[station] = {} end
    if not isTimer(npcTimers[station][npcId]) then
        npcTimers[station][npcId] = setTimer(function(player, station)
            if not succesRobbed[station] and isElement(player) then
                triggerClientEvent("gotFuelrobAlarmState", player, station, true)
                triggerClientEvent("gotFuelrobNPCDuck", player, station, true)
                triggerClientEvent(player, "gotFuelRobMinigame", player, false)
            end
        end, 12000, 1, player, station)
    end
end

local function startResetTimer(player, station)
    setTimer(function(player, station)
        triggerClientEvent("gotFuelrobAlarmState", getRootElement(), station, false)
        triggerClientEvent("gotFuelrobNPCDuck", getRootElement(), station, false)
        triggerClientEvent("gotFuelrobNPCFear", getRootElement(), station, false)
        npcTimers[station] = nil
        stationStatus[station] = nil
        succesRobbed[station] = nil
        for i = 1, 3 do
            triggerClientEvent("gotFuelrobNPCFearLevel", getRootElement(), station, i, 1)
        end
    end, 60000 * 120, 1, player, station)
end

local function startAlarmResetTimer(client, station)
    setTimer(function(player, station)
        triggerClientEvent("gotFuelrobAlarmState", getRootElement(), station, false)
    end, 60000 * 15, 1, player, station)
end

addEventHandler("onElementDataChange", root, function(eData, oldValue, newValue)
    if source and getElementType(source) == "player" then
        if eData == "loggedIn" then
            if newValue and newValue == true then
              triggerClientEvent(source, "gotFuelrobNPCAimAll", source, npcAimData)
            end
        end
    end
end)

addEventHandler("onResourceStop", resourceRoot, function()
    for stationId, _ in pairs(availableFuelStations) do
        npcAimData[stationId] = { [1] = true, [2] = true }
    end

    --[[
    for k, v in ipairs(getElementsByType("player")) do
        triggerClientEvent(v, "gotFuelrobNPCAimAll", v, npcAimData)
    end
    ]]
end)

addEvent("onFuelPedAim", true)
addEventHandler("onFuelPedAim", root, function(beingTargeted)
    local station = getElementData(client, "currentStation")
    if not station then return end

    local weapon = getPedWeapon(client)
    local isWeaponValid = weapon >= 22 and weapon <= 34

    if not stationStatus[station] and isWeaponValid then
        stationStatus[station] = { fear = true }
        previousTarget[client] = 1

        triggerClientEvent("gotFuelrobNPCFear", client, station, true)
        triggerClientEvent("gotFuelrobNPCAim", client, station, 1, false)
        triggerClientEvent("gotFuelrobNPCAim", client, station, 2, false)

        if not npcTimers[station] or not npcTimers[station][previousTarget[client]] then
            startAlarmAndDuckTimer(client, station, previousTarget[client])
            startResetTimer(client, station)
            startAlarmResetTimer(client, station)
        end
    else
        if beingTargeted and isWeaponValid then
            if previousTarget[client] then
                triggerClientEvent("gotFuelrobNPCAim", client, station, previousTarget[client], false)

                if npcTimers[station] and not npcTimers[station][previousTarget[client]] then
                    startAlarmAndDuckTimer(client, station, previousTarget[client])
                    startResetTimer(client, station)
                    startAlarmResetTimer(client, station)
                end
            end

            previousTarget[client] = beingTargeted

            if npcTimers[station] and isTimer(npcTimers[station][beingTargeted]) then
                killTimer(npcTimers[station][beingTargeted])
                npcTimers[station][beingTargeted] = nil
            end

            triggerClientEvent("gotFuelrobNPCAim", client, station, beingTargeted, true)
        else
            if previousTarget[client] then
                triggerClientEvent("gotFuelrobNPCAim", client, station, previousTarget[client], false)

                if not npcTimers[station] or not npcTimers[station][previousTarget[client]] then
                    startAlarmAndDuckTimer(client, station, previousTarget[client])
                    startResetTimer(client, station)
                    startAlarmResetTimer(client, station)
                end

                previousTarget[client] = nil
            end
        end
    end
end)

addEvent("tryStartFuelFearMinigame", true)
addEventHandler("tryStartFuelFearMinigame", root, function()
    local station = getElementData(client, "currentStation")
    if station and not activeMinigames[station] then
        activeMinigames[station] = true
        triggerClientEvent(client, "gotFuelRobMinigame", client, true)
    end
end)

addEvent("fuelRobMinigameResult", true)
addEventHandler("fuelRobMinigameResult", root, function(result)
    local station = getElementData(client, "currentStation")
    if result then
        triggerClientEvent("gotFuelrobDrawerOpen", client, station, true)
        triggerClientEvent("gotFuelrobSyncedBoxData", client, station, {})
        succesRobbed[station] = true
        for i = 1, 3 do
            triggerClientEvent("gotFuelrobNPCFearLevel", client, station, i, false)
            triggerClientEvent("gotFuelrobNPCDuck", client, station, i, true)

            if isTimer(npcTimers[station][i]) then
                killTimer(npcTimers[station][i])
            end
        end
    else

        for i = 1, 3 do
            triggerClientEvent("gotFuelrobNPCFearLevel", client, station, i, false)
            triggerClientEvent("gotFuelrobNPCDuck", client, station, i, true)
            triggerClientEvent("gotFuelrobAlarmState", client, station, true)

            if isTimer(npcTimers[station][i]) then
                killTimer(npcTimers[station][i])
            end
        end

        succesRobbed[station] = nil
    end
end)

addEvent("tryToGetOutFuelBox", true)
addEventHandler("tryToGetOutFuelBox", root, function(box)
    if isTimer(playerCashTimers[client]) then
        triggerClientEvent(client, "showInfobox", client, "error", "Várj egy kicsit!", 4000)
        return
    end

    local station = getElementData(client, "currentStation")
    local amount = math.random(1000, 50000)
    amount = amount * 2
    triggerClientEvent("fuelrobGetOutBox", client, station, box, amount)
    if amount >= 15000 and amount < 50000 then
        itemId = 716 -- Közepes
    elseif amount >= 50000 then
        itemId = 717 -- Nagy
    else
        itemId = 715 -- Kicsi
    end
    exports.sItems:giveItem(client, itemId, 1, false, amount)
    playerCashTimers[client] = setTimer(function() end, 3800, 1)
    triggerClientEvent(client, "showInfobox", client, "success", "A lopott pénzköteg az inventorydba került!", 4000)
end)

function refreshCasettes()
    casettes = {}
    for k, v in pairs(getElementsByType("player")) do
        if exports.sItems:hasItem(v, 715) or exports.sItems:hasItem(v, 716) or exports.sItems:hasItem(v, 717) then
            local px, py, pz = getElementPosition(v)
            local dim = getElementDimension(v)
            local live = dim == 0
            casettes[v] = {px, py, pz, live}

            if dim ~= 0 then
                if exports.sInteriors:isValidInterior(dim) then
                    local x, y, z = exports.sInteriors:getInteriorOutsidePosition(dim)
                    casettes[v] = {x, y, z, false}
                end
            end

            triggerClientEvent(getRootElement(), "gotFuelrobCasetteData", getRootElement(), v, casettes[v])
        else
            triggerClientEvent(getRootElement(), "gotFuelrobCasetteData", getRootElement(), v, false)
        end
    end
end
setTimer(refreshCasettes, 5000, 0)