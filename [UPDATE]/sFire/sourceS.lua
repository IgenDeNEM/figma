firetruckDatas = {}

usingNozzles = {}

refillTanks = {}

refillingNozzles = {}

refillTimings = {}

loadedFires = {}

usingPumps = {}

fireSpread = {}

fireSpreadTimer = false

bigFireId = 0

local fireTiming = (1800000) * 1 --30p -> 15-30p között (/2)

local spreadTiming = (60000) * 1 -- szinten zenesz, tuz terjedes

local minFire, maxFire = 25, 50

for k, v in pairs(getElementsByType("vehicle")) do
    for i = 1, 3 do
        setElementData(v, "fireNozzle:" .. i, false)
    end
    setElementData(v, "refill", false)
end

function createRandomFire()
    local randomFire = math.random(1, #fireZones)

    local size = math.random(minFire, maxFire)

    bigFireId = bigFireId + 1

    for i = 1, size do
        local baseX, baseY, baseZ, hp = fireZones[randomFire][1], fireZones[randomFire][2], fireZones[randomFire][3] - 0.5, fireZones[randomFire][4]
        
        local offsetX = math.random(-150, 150) / 20
        local offsetY = math.random(-150, 150) / 20

        local x = baseX + offsetX
        local y = baseY + offsetY
        local z = baseZ

        local fireId = #loadedFires + 1
        loadedFires[fireId] = {x, y, z, hp}
        
        triggerClientEvent("createFire", getRootElement(), fireId, x, y, z, hp)
    end
    
    fireSpread[bigFireId] = {size, randomFire}

    fireSpreadTimer = setTimer(spreadFire, math.random(spreadTiming / 2, spreadTiming), 0, bigFireId, randomFire)
    
    triggerClientEvent("firemanWarnSound", getRootElement())
end

function spreadFire(bigFireId, fireId)
    if fireSpread[bigFireId] and fireSpread[bigFireId][1] < maxFire then
        fireSpread[bigFireId][1] = fireSpread[bigFireId][1] + 1
        local baseX, baseY, baseZ, hp = fireZones[fireId][1], fireZones[fireId][2], fireZones[fireId][3] - 0.5, fireZones[fireId][4]

        local offsetX = math.random(-150, 150) / 20
        local offsetY = math.random(-150, 150) / 20

        local x = baseX + offsetX
        local y = baseY + offsetY
        local z = baseZ

        local fireId = #loadedFires + 1
        loadedFires[fireId] = {x, y, z, hp}
        
        triggerClientEvent("createFire", getRootElement(), fireId, x, y, z, hp)
    else
        if isTimer(fireSpreadTimer) then
            killTimer(fireSpreadTimer)
        end
    end
end

setTimer(createRandomFire, math.random(fireTiming / 2, fireTiming), 1)

--[[ezt jó lenne permissionösre írni mert kretének gyújtogatnak majd (egyszerre 1 tűz lehet szóval semmi értelme)
addCommandHandler("generatefire", function()
    createRandomFire()
end)--]]

addEvent("requestFires", true)
addEventHandler("requestFires", root, function()
    triggerClientEvent(client, "gotFires", client, loadedFires)
end)

pumpTimers = {}

addEvent("syncUsingPump", true)
addEventHandler("syncUsingPump", root, function(state)
    if state then
        local nozzleUsed = usingNozzles[client]
        if nozzleUsed and state then
            local vehicleElement, nozzleId = nozzleUsed[1], nozzleUsed[2]
            usingPumps[client] = {vehicleElement, state}
        end
    else
        usingPumps[client] = nil
    end
    triggerClientEvent("syncUsingPump", client, state)

end)

function processPumpTimers()
    for k, v in pairs(usingPumps) do
        if isElement(k) then
            if isElement(v[1]) and v[2] then
                if getElementData(v[1], "fireWater") >= 0.0008 then
                    setElementData(v[1], "fireWater", getElementData(v[1], "fireWater") - 0.0008)
                end
            end
        else
            usingPumps[k] = nil
        end
    end
end
setTimer(processPumpTimers, 1000, 0)

addEvent("doSyncFireHealth", true)
addEventHandler("doSyncFireHealth", root, function(data)
    --usingPumps[client] = state
    for k, v in pairs(data) do
        if loadedFires[k] then
            loadedFires[k][4] = loadedFires[k][4] - v
            if loadedFires[k][4] <= 0 then
                loadedFires[k] = nil
                triggerClientEvent("doDeleteFire", client, k)

                if fireSpread[bigFireId] then
                    fireSpread[bigFireId][1] = fireSpread[bigFireId][1] - 1
                end

                local activeFires = 0
                for key, value in pairs(loadedFires) do
                    activeFires = activeFires + 1
                end

                if activeFires == 0 then
                    setTimer(createRandomFire, math.random(fireTiming / 2, fireTiming), 1)
                    if isTimer(fireSpreadTimer) then
                        killTimer(fireSpreadTimer)
                    end
                end
                break
            else
                local sync = {}
                sync[k] = loadedFires[k][4]
                triggerClientEvent("doSyncFireHealth", client, sync)
            end
        end
    end
end)

addEvent("firemanWarnSoundEx", true)
addEventHandler("firemanWarnSoundEx", root, function()
    triggerClientEvent("firemanWarnSoundEx", source)
end)

function checkClosestRefill(x, y, z)
    local closestX, closestY, closestZ = nil, nil, nil
    local shortestDistance = nil

    for _, posData in ipairs(refillPositions) do
        local pos = posData.objectPosition
        local px, py, pz = pos[1], pos[2], pos[3]

        local dist = getDistanceBetweenPoints3D(x, y, z, px, py, pz)

        if not shortestDistance or dist < shortestDistance then
            shortestDistance = dist
            closestX, closestY, closestZ = px, py, pz
        end
    end

    if closestX and closestY and closestZ then
        return closestX, closestY, closestZ
    else
        return false
    end
end

local refillingStates = {}

addEvent("firetruckResetRefillNozzle", true)
addEventHandler("firetruckResetRefillNozzle", root, function(vehicleElement)
    local px, py, pz = getElementPosition(vehicleElement)
    local x, y, z = checkClosestRefill(px, py, pz)
    refillingStates[vehicleElement] = false
    setElementData(vehicleElement, "fireNozzle:" .. 1, {x, y, z})
end)

addEvent("firetruckUseNozzle", true)
addEventHandler("firetruckUseNozzle", root, function(vehicleElement, nozzle)
    if not firetruckDatas[vehicleElement] then
        firetruckDatas[vehicleElement] = {}
    end
    local waterTankId = false
    if refillTanks[vehicleElement] and refillTanks[vehicleElement][nozzle] then
        waterTankId = refillTanks[vehicleElement][nozzle]
    end
    if not firetruckDatas[vehicleElement][nozzle] and not usingNozzles[client] and not waterTankId then
        firetruckDatas[vehicleElement][nozzle] = client

        local oldData = getElementData(vehicleElement, "fireNozzle:" .. nozzle)
        if type(oldData) == "table" then
            giveWeapon(client, 37, 999999999, true)
            exports.sItems:enableWeaponFire(client, false)
            exports.sChat:localAction(client, "felvett egy tömlőt.")
        else
            giveWeapon(client, 37, 999999999, true)
            exports.sItems:enableWeaponFire(client, false)
            exports.sChat:localAction(client, "felszerelt egy tömlőt egy tűzoltóautóra.")
        end

        setElementData(vehicleElement, "fireNozzle:" .. nozzle, false)
        setElementData(vehicleElement, "fireNozzle:" .. nozzle, client)
        usingNozzles[client] = {vehicleElement, nozzle}
    else
        if refillTanks[vehicleElement] and refillTanks[vehicleElement][nozzle] then
            local waterTankId = refillTanks[vehicleElement][nozzle]
            local vehicleElement, nozzle, refillStarted = refillingNozzles[waterTankId][1], refillingNozzles[waterTankId][2], refillingNozzles[waterTankId][3]
            usingNozzles[client] = {vehicleElement, nozzle}
            firetruckDatas[vehicleElement][nozzle] = client

            local realProgress = math.min((getRealTime().timestamp - refillStarted) * (750 / 60) / 3000, 1.0) + (getElementData(vehicleElement, "refill") or 0)

            if realProgress > 1 then
                realProgress = 1
            end

            setElementData(vehicleElement, "fireWater", realProgress)

            if not refillingStates[vehicleElement] then
                giveWeapon(client, 37, 999999999, true)
                exports.sItems:enableWeaponFire(client, false)
                exports.sChat:localAction(client, "felvett egy tömlőt.")
            else
                giveWeapon(client, 37, 999999999, true)
                exports.sItems:enableWeaponFire(client, false)
                exports.sChat:localAction(client, "leszerelt egy tömlőt egy tartályról.")
                refillingStates[vehicleElement] = false
            end
            setElementData(vehicleElement, "fireNozzle:" .. nozzle, false)

            setElementData(vehicleElement, "fireNozzle:" .. nozzle, client)

            refillingNozzles[waterTankId] = nil

            refillTanks[vehicleElement][nozzle] = nil
        end
    end
end)

addEvent("firetruckUnuseNozzle", true)
addEventHandler("firetruckUnuseNozzle", root, function(tooFar)
    if tooFar then
        if usingNozzles[client] then
            local nozzleUsed = usingNozzles[client]
            local vehicleElement, nozzleId = nozzleUsed[1], nozzleUsed[2]
            local x, y, z = getElementPosition(client)
            setElementData(vehicleElement, "fireNozzle:" .. nozzleId, false)
            setElementData(vehicleElement, "fireNozzle:" .. nozzleId, {x, y, z - 1})
            usingNozzles[client] = nil
            firetruckDatas[vehicleElement][nozzleId] = nil
            takeAllWeapons(client)
            exports.sItems:enableWeaponFire(client, true)
            exports.sChat:localAction(client, "eldobott egy tömlőt.")
        end
    else
        if usingNozzles[client] then
            local nozzleUsed = usingNozzles[client]
            local vehicleElement, nozzleId = nozzleUsed[1], nozzleUsed[2]
            setElementData(vehicleElement, "fireNozzle:" .. nozzleId, false)
            usingNozzles[client] = nil
            firetruckDatas[vehicleElement][nozzleId] = nil
            takeAllWeapons(client)
            exports.sItems:enableWeaponFire(client, true)
            exports.sChat:localAction(client, "leszerelt egy tömlőt egy tűzoltóautóról.")
        end
    end
end)

addEvent("firetruckRefillNozzle", true)
addEventHandler("firetruckRefillNozzle", root, function(waterTankId)
    if usingNozzles[client] then
        local nozzleUsed = usingNozzles[client]
        local vehicleElement, nozzleId = nozzleUsed[1], nozzleUsed[2]
        setElementData(vehicleElement, "fireNozzle:" .. nozzleId, waterTankId)
        setElementData(vehicleElement, "refill", (getElementData(vehicleElement, "fireWater") or 0))
        setElementData(vehicleElement, "fireWater", 1)
        usingNozzles[client] = nil
        firetruckDatas[vehicleElement][nozzleId] = nil
        refillingNozzles[waterTankId] = {vehicleElement, nozzleId, getRealTime().timestamp}
        
        refillingStates[vehicleElement] = true
        exports.sChat:localAction(client, "felszerelt egy tömlőt egy tartályra.")

        takeAllWeapons(client)
        exports.sItems:enableWeaponFire(client, true)

        if not refillTanks[vehicleElement] then
            refillTanks[vehicleElement] = {}
        end
        refillTanks[vehicleElement][nozzleId] = waterTankId
    end
end)

addEventHandler("onPlayerQuit", root, function()
    local nozzleUsed = usingNozzles[source]
    if nozzleUsed then
        local vehicleElement, nozzleId = nozzleUsed[1], nozzleUsed[2]
        setElementData(vehicleElement, "fireNozzle:" .. nozzleId, false)
        usingNozzles[source] = nil
        firetruckDatas[vehicleElement][nozzleId] = nil
    end
end)