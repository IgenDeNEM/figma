local connection = false

local garageDatas = {}
local garageLifts = {}
local stopGarageCarLiftTimers = {}

local chargers = {}

function fetchGarageDatas(qh)
    local results = dbPoll(qh, -1)
    for i = 1, #results do
        local result = results[i]
        local interiorId = result.interiorId

        garageDatas[interiorId] = result
        garageLifts[interiorId] = {}
        stopGarageCarLiftTimers[interiorId] = {}
        sendGarageData(interiorId)
        for i = 1, 5 do
            if garageDatas[interiorId]["lift" .. i] > 0 then
                createGarageLift(interiorId, i, garageDatas[interiorId]["lift" .. i])
            end
        end
    end
end

function sendGarageData(interiorId, playersEntered, ownerCharID)
    if not playersEntered then
        playersEntered = {}

        for k, v in pairs(getElementsByType("player")) do
            local currentGarage = getElementData(v, "currentCustomGarage")
            
            if currentGarage and currentGarage == interiorId then
                table.insert(playersEntered, v)
            end
        end
    end

    for i = 1, #playersEntered do
        local player = playersEntered[i]
        local ownerType, ownerId = exports.sInteriors:getInteriorOwner(interiorId)
        
        local isOwner = false

        if ownerCharID then
            ownerType = "player"
            ownerId = ownerCharID
        end
        
        if ownerType == "player" then
            isOwner = ownerId == getElementData(player, "char.ID")
            if isOwner then
                setElementData(player, "paintshopGarage", ownerId)
            end
        end

        if ownerCharID then
            garageDatas[interiorId].interiorId = -math.abs(garageDatas[interiorId].interiorId)
        end
        triggerClientEvent(player, "loadedGarageData", getRootElement(), interiorId, garageDatas[interiorId], isOwner, false, true)
    end
end

function createGarageLift(interiorId, i, lift)
    if not garageLifts[interiorId][i] then
        garageLifts[interiorId][i] = {}
    elseif garageLifts[interiorId][i] then
        destroyElement(garageLifts[interiorId][i].block)
        destroyElement(garageLifts[interiorId][i].runway)
        destroyElement(garageLifts[interiorId][i].runwayColShape)
        garageLifts[interiorId][i].liftZ = garageDatas[interiorId]["lift" .. lift .. "Z"]
        garageLifts[interiorId][i] = {}
    end

    local liftLayout = liftLayout[i]
    local liftZ = garageDatas[interiorId]["lift" .. i .. "Z"]
    local lx, ly, lz = baseX + liftLayout[1], baseY + liftLayout[2], baseZ
    local lrz = liftLayout[3]


    if lift == 1 then
        runway = createObject((lift == 1 and 3907) or 3916, lx, ly, lz, 0, 0, lrz)
        block = createObject((lift == 1 and 3918) or 3897, lx, ly, lz + liftZ, 0, 0, lrz)
    else
        runway = createObject((lift == 1 and 3907) or 3916, lx, ly, lz + liftZ, 0, 0, lrz)
        block = createObject((lift == 1 and 3918) or 3897, lx, ly, lz, 0, 0, lrz)
    end
    garageLifts[interiorId][i].block = block
    processDimension(block, interiorId)
    if lift == 1 then
        garageLifts[interiorId][i].runway = block
    else
        garageLifts[interiorId][i].runway = runway
    end
    processDimension(runway, interiorId)
    local runwayColShape = createColSphere(lx, ly, lz - 1, 2)
    garageLifts[interiorId][i].runwayColShape = runwayColShape
    processDimension(runwayColShape, interiorId)
    attachElements(runwayColShape, runway, 0, 0, 2)

    local handleCol

    if lift == 1 then
        local x, y, z = getPositionFromElementOffset(block, 3, 0, 1.3)
        handleCol = createColSphere(x, y, z, 0.7)
    else
        local x, y, z = getPositionFromElementOffset(block, 2.6, -2.8, 1.3)
        handleCol = createColSphere(x, y, z, 0.7)
    end
    
    garageLifts[interiorId][i].handleCol = handleCol

    garageLifts[interiorId][i].liftZ = garageDatas[interiorId]["lift" .. lift .. "Z"]

    processDimension(handleCol, interiorId)
end

function syncGarageLiftSound(interiorId, lift, state)
    local syncPlayers = {}

    for k, v in pairs(getElementsByType("player")) do
        local currentCustomGarage = getElementData(v, "currentCustomGarage")
        
        if currentCustomGarage == interiorId then
            table.insert(syncPlayers, v)
        end
    end

    triggerClientEvent(syncPlayers, "toggleGarageLiftState", getRootElement(), lift, state)
end

function stopGarageCarLift(interiorId, lift)
    local runwayColShape = garageLifts[interiorId][lift].runwayColShape
    local runway = garageLifts[interiorId][lift].runway
    stopObject(runway)
    syncGarageLiftSound(interiorId, lift, false)

    local lx, ly, lz = getElementPosition(runway)
    garageLifts[interiorId][lift].liftZ = lz - baseZ

    local vehiclesTable = getAttachedElements(runway)

    for i = 1, #vehiclesTable do
        if getElementType(vehiclesTable[i]) == "vehicle" then
            detachElements(vehiclesTable[i], runway)
        end
    end

    dbExec(connection, "UPDATE garages SET lift" .. lift .. "Z = ? WHERE interiorId = ?", garageLifts[interiorId][lift].liftZ, interiorId)
end

addEvent("syncGarageDatas", true)
addEventHandler("syncGarageDatas", getRootElement(), function(playersEntered, interiorId, ownerCharID)
    if client then
        exports.sAnticheat:anticheatBan(client, "AC #56 - sGarages @sourceS:146")
    else
        sendGarageData(interiorId, playersEntered, ownerCharID)
        if chargers[interiorId] and chargers[interiorId][2] then
            triggerClientEvent("syncGarageCharging", chargers[interiorId][2], interiorId, chargers[interiorId][2], chargers[interiorId][2])
        end
        
        triggerLatentClientEvent(playersEntered, "interiorEnterCancelled", getRootElement(), interiorId)
    end
end)

addEvent("fetchNewGarage", true)
addEventHandler("fetchNewGarage", getRootElement(), function(interiorId)
    dbQuery(function(qh, interiorId)
        local qh = dbPoll(qh, 0)
        fetchGarageDatas(dbQuery(connection, "SELECT * FROM garages WHERE interiorId = ?", interiorId))
    end, {interiorId}, connection, "INSERT INTO garages (interiorId) VALUES (?)", interiorId)
end)

addEvent("tryToBuyGarageItem", true)
addEventHandler("tryToBuyGarageItem", getRootElement(), function(item, value)
    if client == source then
        if garagePrices[item] then
            local paid = not garagePrices[item][value]

            if not paid then
                local priceType, price = unpack(garagePrices[item][value])
                
                if priceType == "cash" then
                    paid = exports.sCore:takeMoney(client, price)
                elseif priceType == "pp" then
                    paid = exports.sCore:takePP(client, price)
                end
            end

            if paid then
                local interiorId = getElementData(client, "currentCustomGarage")

                if interiorId then
                    garageDatas[interiorId][item] = value

                    dbExec(connection, "UPDATE garages SET " .. item .. " = ? WHERE interiorId = ?", value, interiorId)
                    
                    sendGarageData(interiorId, false, getElementData(client, "paintshopGarage"))

                    if utf8.sub(item, 1, 4) == "lift" then
                        local i = tonumber(utf8.sub(item, 5, 5))
                        
                        if value == 0 then
                            if isElement(garageLifts[interiorId][i].block) then
                                destroyElement(garageLifts[interiorId][i].block)
                            end
                            
                            if isElement(garageLifts[interiorId][i].runway) then
                                destroyElement(garageLifts[interiorId][i].runway)
                            end
                            
                            if isElement(garageLifts[interiorId][i].handleCol) then
                                destroyElement(garageLifts[interiorId][i].handleCol)
                            end
                        elseif value > 0 and value <= 2 then
                            createGarageLift(interiorId, i, value)
                        end
                    end

                    exports.sGui:showInfobox(client, "s", "Sikeres vásárlás!")
                end
            else
                exports.sGui:showInfobox(client, "e", "Nincs elég egyenleged!")
            end

            triggerClientEvent(client, "garageBuyItemResponse", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #57 - sGarages @sourceS:220")
    end
end)

local heavyVehicles = {
    [582] = true,
}

function isGarageHasCraft(garage)
    local interiorId = math.abs(garage)
    local data = garageDatas[interiorId]["workbench"]
    if data and data ~= 0 then
        return true
    end
    return false
end

addEvent("startGarageCarLiftUp", true)
addEventHandler("startGarageCarLiftUp", getRootElement(), function(lift)
    local interiorId = getElementData(client, "currentCustomGarage")

    if interiorId then
        local ownerType, ownerId = exports.sInteriors:getInteriorOwner(interiorId)
        
        local isOwner = false
        
        if ownerType == "player" then
            isOwner = ownerId == getElementData(client, "char.ID")
        end
        if getElementData(client, "paintshopGarage") and not isOwner then
            isOwner = getElementData(client, "paintshopGarage") == getElementData(client, "char.ID")
        end

        if isOwner then
            local liftData = garageLifts[interiorId] and garageLifts[interiorId][lift]

            if liftData then
                local time = reMap(garageLifts[interiorId][lift].liftZ, 0, liftMaxHeight, 10000, 0)

                if time > 0 then
                    local runway = liftData.runway
                    local runwayColShape = liftData.runwayColShape
                    
                    local vehiclesTable = getElementsWithinColShape(runwayColShape, "vehicle")
                    local vehicleFound = false
                    local multipleFound = false

                    for i = 1, #vehiclesTable do
                        local vehicleElement = vehiclesTable[i]

                        if isElement(vehicleElement) and getElementDimension(vehicleElement) == interiorId then
                            if vehicleFound then
                                multipleFound = true
                                break
                            else
                                vehicleFound = vehicleElement
                            end
                        end
                    end

                    if multipleFound then
                        exports.sGui:showInfobox(client, "e", "Egyszerre csak egy járművet bír el a lift!")
                        return
                    end

                    if vehicleFound then
                        if heavyVehicles[getElementModel(vehicleFound)] then
                            exports.sGui:showInfobox(client, "e", "A gépjármű meghaladta a 3.5 tonnás súlyhatárt.")
                            return
                        end
                    end

                    setPedAnimation(client, "CASINO", "SLOT_PLYR", -1, false, false, false, false, 250, true)

                    if isElement(vehicleFound) then
                        setElementFrozen(vehicleFound, true)
                        setElementData(vehicleFound, "vehicle.handbrake", true)
                        attachRotationAdjusted(vehicleFound, runway)
                    end

                    local x, y, z = getElementPosition(runway)

                    moveObject(runway, time, x, y, baseZ + liftMaxHeight)
                    syncGarageLiftSound(interiorId, lift, true)

                    stopGarageCarLiftTimers[interiorId][lift] = setTimer(stopGarageCarLift, time, 1, interiorId, lift)
                end
            end
        end
    end
end)

addEvent("startGarageCarLiftDown", true)
addEventHandler("startGarageCarLiftDown", getRootElement(), function(lift)
    local interiorId = getElementData(client, "currentCustomGarage")

    if interiorId then
        local ownerType, ownerId = exports.sInteriors:getInteriorOwner(interiorId)
        
        local isOwner = false
        
        if ownerType == "player" then
            isOwner = ownerId == getElementData(client, "char.ID")
        end
        if getElementData(client, "paintshopGarage") and not isOwner then
            isOwner = getElementData(client, "paintshopGarage") == getElementData(client, "char.ID")
        end

        if isOwner then
            local liftData = garageLifts[interiorId] and garageLifts[interiorId][lift]

            if liftData then
                local time = reMap(garageLifts[interiorId][lift].liftZ, 0, liftMaxHeight, 0, 10000)

                if time > 0 then
                    local runway = liftData.runway
                    local runwayColShape = liftData.runwayColShape
                    
                    local vehiclesTable = getElementsWithinColShape(runwayColShape, "vehicle")
                    local vehicleFound = false
                    local multipleFound = false

                    for i = 1, #vehiclesTable do
                        local vehicleElement = vehiclesTable[i]

                        if isElement(vehicleElement) and getElementDimension(vehicleElement) == interiorId then
                            if vehicleFound then
                                multipleFound = true
                                break
                            else
                                vehicleFound = vehicleElement
                            end
                        end
                    end

                    setPedAnimation(client, "CASINO", "SLOT_PLYR", -1, false, false, false, false, 250, true)

                    if isElement(vehicleFound) then
                        setElementFrozen(vehicleFound, true)
                        setElementData(vehicleFound, "vehicle.handbrake", true)
                        attachRotationAdjusted(vehicleFound, runway)
                    end

                    local x, y, z = getElementPosition(liftData.runway)

                    moveObject(liftData.runway, time, x, y, baseZ)
                    syncGarageLiftSound(interiorId, lift, true)

                    stopGarageCarLiftTimers[interiorId][lift] = setTimer(stopGarageCarLift, time, 1, interiorId, lift)
                end
            end
        end
    end
end)

addEvent("stopGarageCarLift", true)
addEventHandler("stopGarageCarLift", getRootElement(), function(lift)
    local interiorId = getElementData(client, "currentCustomGarage")

    if interiorId then
        local ownerType, ownerId = exports.sInteriors:getInteriorOwner(interiorId)
        
        local isOwner = false
        
        if ownerType == "player" then
            isOwner = ownerId == getElementData(client, "char.ID")
        end
        if getElementData(client, "paintshopGarage") and not isOwner then
            isOwner = getElementData(client, "paintshopGarage") == getElementData(client, "char.ID")
        end

        if isOwner then
            local liftData = garageLifts[interiorId] and garageLifts[interiorId][lift]

            if liftData then
                stopGarageCarLift(interiorId, lift)

                if isTimer(stopGarageCarLiftTimers[interiorId][lift]) then
                    killTimer(stopGarageCarLiftTimers[interiorId][lift])
                end
            end
        end
    end
end)

addEventHandler("onColShapeHit", resourceRoot, function(hitElement, md)
    if md and getElementType(hitElement) == "player" then
        local interiorId = getElementData(hitElement, "currentCustomGarage")

        if interiorId then
            local ownerType, ownerId = exports.sInteriors:getInteriorOwner(interiorId)
            
            local isOwner = false
            
            if ownerType == "player" then
                isOwner = ownerId == getElementData(hitElement, "char.ID")
            end
            if getElementData(hitElement, "paintshopGarage") and not isOwner then
                isOwner = getElementData(hitElement, "paintshopGarage") == getElementData(hitElement, "char.ID")
            end

            if isOwner then
                local lifts = garageLifts[interiorId]

                if lifts then
                    for i = 1, 5 do
                        local lift = lifts[i]

                        if lift then
                            if lift.handleCol == source then 
                                triggerClientEvent(hitElement, "showGarageLiftGui", hitElement, i)

                                break
                            end
                        end
                    end
                end
            end
        end
    end
end)

addEventHandler("onColShapeLeave", resourceRoot, function(hitElement, md)
    if md and getElementType(hitElement) == "player" then
        local interiorId = getElementData(hitElement, "currentCustomGarage")

        if interiorId then
            local ownerType, ownerId = exports.sInteriors:getInteriorOwner(interiorId)
            
            local isOwner = false
            
            if ownerType == "player" then
                isOwner = ownerId == getElementData(hitElement, "char.ID")
            end
            if getElementData(hitElement, "paintshopGarage") and not isOwner then
                isOwner = getElementData(hitElement, "paintshopGarage") == getElementData(hitElement, "char.ID")
            end

            if isOwner then
                local lifts = garageLifts[interiorId]

                if lifts then
                    for i = 1, 5 do
                        local lift = lifts[i]

                        if lift then
                            if lift.handleCol == source then 
                                triggerClientEvent(hitElement, "hideGarageLiftGui", hitElement)

                                break
                            end
                        end
                    end
                end
            end
        end
    end
end)

addEventHandler("onElementDimensionChange", getRootElement(), function(old, new)
    if getElementType(source) then
        if garageDatas[new] then
            local px, py, pz = getElementPosition(source)

            if getDistanceBetweenPoints3D(px, py, pz, baseX, baseY, baseZ) <= 50 and getElementData(source, "currentCustomGarage") ~= new then
                setElementData(source, "currentCustomGarage", new)

                sendGarageData(new, {source})
            end
        end
    end
end)

addEventHandler("onResourceStart", getRootElement(), function(res)
    if res == getThisResource() then
        connection = exports.sConnection:getConnection()
        setTimer(fetchGarageDatas, 500, 1, dbQuery(connection, "SELECT * FROM garages"))
    else
        local resName = getResourceName(res)

        if resName == "sConnection" then
            connection = exports.sConnection:getConnection()
        end
    end
end) 

function getPositionFromElementOffset(element, offX, offY, offZ)
    local m = getElementMatrix(element)
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z
end

function reMap(value, low1, high1, low2, high2)
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)
end

function attachRotationAdjusted(sourceElement, targetElement)
	local sourcePosX, sourcePosY, sourcePosZ = getElementPosition(sourceElement)
	local sourceRotX, sourceRotY, sourceRotZ = getElementRotation(sourceElement)

	local targetPosX, targetPosY, targetPosZ = getElementPosition(targetElement)
	local targetRotX, targetRotY, targetRotZ = getElementRotation(targetElement)

	local offsetPosX = sourcePosX - targetPosX
	local offsetPosY = sourcePosY - targetPosY
	local offsetPosZ = sourcePosZ - targetPosZ

	local offsetRotX = sourceRotX - targetRotX
	local offsetRotY = sourceRotY - targetRotY
	local offsetRotZ = sourceRotZ - targetRotZ

	offsetPosX, offsetPosY, offsetPosZ = applyInverseRotation(offsetPosX, offsetPosY, offsetPosZ, targetRotX, targetRotY, targetRotZ)

	attachElements(sourceElement, targetElement, offsetPosX, offsetPosY, offsetPosZ + 0.01, offsetRotX, offsetRotY, offsetRotZ)
end

function applyInverseRotation(posX, posY, posZ, rotX, rotY, rotZ)
	rotX = math.rad(rotX)
	rotY = math.rad(rotY)
	rotZ = math.rad(rotZ)

	local tempY = posY
	posY =  math.cos(rotX) * tempY + math.sin(rotX) * posZ
	posZ = -math.sin(rotX) * tempY + math.cos(rotX) * posZ

	local tempX = posX
	posX =  math.cos(rotY) * tempX - math.sin(rotY) * posZ
	posZ =  math.sin(rotY) * tempX + math.cos(rotY) * posZ

	tempX = posX
	posX =  math.cos(rotZ) * tempX + math.sin(rotZ) * posY
	posY = -math.sin(rotZ) * tempX + math.cos(rotZ) * posY

	return posX, posY, posZ
end


addEvent("tryToGetJumperFromGarage", true)
addEventHandler("tryToGetJumperFromGarage", root, function(putDown)
    local interiorId = getElementData(client, "currentCustomGarage")

    if not interiorId then
        return
    end

    if not putDown then
        if chargers[interiorId] then
            exports.sGui:showInfobox(client, "e", "Ez a töltő használatban van!")
            return
        end
        chargers[interiorId] = true
        setElementData(client, "jumperInHand", "charger")
    else
        if chargers[interiorId] then
            setElementData(client, "jumperInHand", false)
            chargers[interiorId] = false
        end
    end
end)

addEvent("tryToPutOnCharger", true)
addEventHandler("tryToPutOnCharger", root, function(veh)
    local interiorId = getElementData(client, "currentCustomGarage")

    if not interiorId then
        return
    end
    if veh then
        if chargers[interiorId] then

            chargers[interiorId] = {interiorId, veh, veh}

            triggerClientEvent("syncGarageCharging", client, interiorId, veh, veh)
            setElementData(client, "jumperInHand", false)

            local vehicleOccupants = getVehicleOccupants(veh)

            local batteryRate = (getElementData(veh, "vehicle.batteryRate") or 0)

            local rate = math.abs(exports.sVehicles:getBatteryValues(veh, "charger"))

            local finalRate = batteryRate + rate

            setElementData(veh, "vehicle.batteryRate", finalRate)

            local maxCharge = getElementData(veh, "vehicle.maxBatteryCharge")

            local batteryCharge = getElementData(veh, "vehicle.batteryCharge")

            triggerClientEvent(vehicleOccupants, "gotVehicleBatteryCharge", veh, batteryCharge, maxCharge, 2048, finalRate)
            setElementData(veh, "vehicle.charging", true)
        end
    end
end)

addEvent("onPlayerJumperDrop", true)
addEventHandler("onPlayerJumperDrop", root, function(veh)
    local interiorId = getElementData(client, "currentCustomGarage")

    if interiorId then
        chargers[interiorId] = false
        setElementData(client, "jumperInHand", false)
    else
        setElementData(client, "jumperInHand", false)
        setElementData(client, "usingJumperCable", false)
    end

end)

addEvent("removeVehicleFromCharger", true)
addEventHandler("removeVehicleFromCharger", root, function(veh)
    local interiorId = getElementData(client, "currentCustomGarage")

    if not interiorId then
        return
    end

    if veh then
        if chargers[interiorId] then

            chargers[interiorId] = true

            triggerClientEvent("syncGarageCharging", client, interiorId, nil, veh)
            setElementData(client, "jumperInHand", "charger")

            
            local vehicleOccupants = getVehicleOccupants(veh)

            local batteryRate = (getElementData(veh, "vehicle.batteryRate") or 0)

            local rate = math.abs(exports.sVehicles:getBatteryValues(veh, "charger"))

            local finalRate = batteryRate - rate

            setElementData(veh, "vehicle.batteryRate", finalRate)

            local maxCharge = getElementData(veh, "vehicle.maxBatteryCharge")

            local batteryCharge = getElementData(veh, "vehicle.batteryCharge")

            triggerClientEvent(vehicleOccupants, "gotVehicleBatteryCharge", veh, batteryCharge, maxCharge, 2048, finalRate)

            setElementData(veh, "vehicle.charging", false)
        end
    end
end)