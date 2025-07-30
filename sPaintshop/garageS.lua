-- garage @davis
addEvent("enterGarageLobby", true)
addEventHandler("enterGarageLobby", root, function(lobbyIdentifier)
    if client == source then
        if isAisleIdValid(lobbyIdentifier) then
            local lobbyDatas = fetchLobby(lobbyIdentifier, true)

            local sourceVehicle = getPedOccupiedVehicle(client)
            if sourceVehicle then
                local vehiclePassangers = getPlayersInVehicle(client, sourceVehicle)
                local elementDatas = {
                    trailerElement = getElementData(sourceVehicle, "towCar") or false
                }
                updateEnterPosition(sourceVehicle, elementDatas, lobbyIdentifier, true)
                if vehiclePassangers[1] then
                    for i = 1, #vehiclePassangers[2] do
                        triggerClientEvent(vehiclePassangers[2][i], "startPaintshopLobbyLoading", vehiclePassangers[2][i], lobbyIdentifier)
                        triggerClientEvent(vehiclePassangers[2][i], "loadedGaragesLobby", vehiclePassangers[2][i], lobbyIdentifier, lobbyDatas[1], lobbyDatas[2])
                    end
                else
                    local elementDatas = {
                        trailerElement = getElementData(sourceVehicle, "towCar") or false
                    }
                    updateEnterPosition(sourceVehicle, elementDatas, lobbyIdentifier, true)

                    triggerClientEvent(client, "startPaintshopLobbyLoading", client, lobbyIdentifier)
                    triggerClientEvent(client, "loadedGaragesLobby", client, lobbyIdentifier, lobbyDatas[1], lobbyDatas[2])
                end
            else
                updateEnterPosition(client, false, lobbyIdentifier, true)

                triggerClientEvent(client, "startPaintshopLobbyLoading", client, lobbyIdentifier)
                triggerClientEvent(client, "loadedGaragesLobby", client, lobbyIdentifier, lobbyDatas[1], lobbyDatas[2])
            end
        end
    end
end)

addEvent("rentGarage", true)
addEventHandler("rentGarage", root, function(workshopIdentifier, premiumRent)
    if client == source then
        if workshopIdentifier and isWorkshopIdValid(workshopIdentifier) then
            if premiumRent then
                local premiumPoints = exports.sCore:getPP(client)
                if premiumPoints >= rentPrices.premium then
                    triggerClientEvent(client, "paintshopRentSuccess", client)

                    local rentDatas = {
                        workshopName = getElementData(client, "visibleName"):gsub("_", " "),
                        name = getElementData(client, "visibleName"):gsub("_", " "),
                        ownerName = getElementData(client, "visibleName"):gsub("_", " "),
                        rentedBy = getElementData(client, "char.ID"),
                        rentUntil = getRealTimestamp() + 1209600,
                        workshopIdentity = workshopIdentifier,
                        rentMode = "pp",
                        locked = false,
                    }

                    fetchGarage(workshopIdentifier, true, rentDatas)
                    triggerClientEvent("refreshGarageRented", client, workshopIdentifier, rentDatas)

                    exports.sCore:takePP(client, rentPrices.premium)

                    local time = getRealTimestamp() + 1209600
                    local dateString = string.format("%04d.%02d.%02d %02d:%02d", getRealTime(time).year + 1900, getRealTime(time).month + 1, getRealTime(time).monthday, getRealTime(time).hour, getRealTime(time).minute)

                    exports.sGui:showInfobox(client, "s", "Sikeresen kibérelted a garázst! Lejár: " .. dateString)

                    if isTimer(garageTimers[workshopIdentifier]) then
                        killTimer(garageTimers[workshopIdentifier])
                        garageTimers[workshopIdentifier] = nil
                    end

                    garageTimers[workshopIdentifier] = setTimer(garageExpired, (time - getRealTimestamp()) * 1000, 1, workshopIdentifier)
                else
                    exports.sGui:showInfobox(client, "e", "Nincs elég PrémiumPontod a garázs bérléséhez!")
                    triggerClientEvent(client, "paintshopRentFail", client)
                end
            else
                if exports.sCore:getMoney(client) >= rentPrices.normal then
                    dbQuery(function(qh, client, workshopIdentifier)
                        local result = dbPoll(qh, 0)

                        local canRent = true
                        for k, v in pairs(result) do
                            local rentMode = v.rentMode
                            if rentMode == "money" and v.interiorId ~= workshopIdentifier then
                                if not garageCache[workshopIdentifier] then
                                    canRent = false
                                end
                            end
                        end
                        if not canRent then
                            exports.sGui:showInfobox(client, "e", "Ezt a garázst már csak PrémiumPontból tudod bérelni!")
                            triggerClientEvent(client, "paintshopRentFail", client)
                            return
                        end
                        local rentDatas = {
                            workshopName = getElementData(client, "visibleName"):gsub("_", " "),
                            name = getElementData(client, "visibleName"):gsub("_", " "),
                            ownerName = getElementData(client, "visibleName"):gsub("_", " "),
                            rentedBy = getElementData(client, "char.ID"),
                            rentUntil = getRealTimestamp() + 1209600,
                            workshopIdentity = workshopIdentifier,
                            rentMode = "money",
                            locked = false,
                        }

                        fetchGarage(workshopIdentifier, true, rentDatas)
                        triggerClientEvent("refreshGarageRented", client, workshopIdentifier, rentDatas)

                        exports.sCore:takeMoney(client, rentPrices.normal)

                        local time = getRealTimestamp() + 1209600
                        local dateString = string.format("%04d.%02d.%02d %02d:%02d", getRealTime(time).year + 1900, getRealTime(time).month + 1, getRealTime(time).monthday, getRealTime(time).hour, getRealTime(time).minute)

                        exports.sGui:showInfobox(client, "s", "Sikeresen kibérelted a garázst! Lejár: " .. dateString)

                        if isTimer(garageTimers[workshopIdentifier]) then
                            killTimer(garageTimers[workshopIdentifier])
                            garageTimers[workshopIdentifier] = nil
                        end

                        garageTimers[workshopIdentifier] = setTimer(garageExpired, (time - getRealTimestamp()) * 1000, 1, workshopIdentifier)
                    end, {client, workshopIdentifier}, dbConnection, "SELECT * FROM garages WHERE rentedBy = ?", getElementData(client, "char.ID"))
                else
                    exports.sGui:showInfobox(client, "e", "Nincs elég pénzed a garázs bérléséhez!")
                    triggerClientEvent(client, "paintshopRentFail", client)
                end
            end
        else
            if tonumber(workshopIdentifier) then
                acBan(source, "paintShop >> falseTrigger - rentGarage [2.2 - workshopIdentifier not assigned!]")
            else
                acBan(source, "paintShop >> falseTrigger - rentGarage [2.1 - workshopIdentifier is not valid!]")
            end
        end
    else
        acBan(source, "paintShop >> falseTrigger - rentGarage [1]")
    end
end)

addEvent("tryToEnterRentGarage", true)
addEventHandler("tryToEnterRentGarage", root, function(workshopIdentifier)

    local int = 1
    local dim = tonumber(workshopIdentifier)
    local interiorId = -tonumber(workshopIdentifier)

    local x, y, z, rz = 621.785, -26, 1000.9199829102, 180

    if not rz then rz = 0 end
    rz = rz - 180

    local veh = getPedOccupiedVehicle(client)
    local playersEntered = {}

    if isElement(veh) then
        setElementPosition(veh, x, y, z)
        setElementInterior(veh, int)
        setElementDimension(veh, dim)
        setElementRotation(veh, 0, 0, rz)

        local occupants = getVehicleOccupants(veh)

        for k, v in pairs(occupants) do
            setElementInterior(v, int)
            setElementDimension(v, dim)
            setElementData(v, "currentCustomGarage", false)
            setElementData(v, "currentCustomGarage", math.abs(interiorId))
            table.insert(playersEntered, v)
        end
    else
        setElementPosition(client, x, y, z)
        setElementInterior(client, int)
        setElementDimension(client, dim)
        setElementRotation(client, 0, 0, rz)
        setElementData(client, "currentCustomGarage", false)
        setElementData(client, "currentCustomGarage", math.abs(interiorId))
        table.insert(playersEntered, client)
    end


    triggerClientEvent(playersEntered, "startRentableGarageLoad", getRootElement(), interiorId)
    triggerClientEvent(playersEntered, "loadedGaragesLobby", client, false)
    triggerEvent("syncGarageDatas", client, playersEntered, math.abs(interiorId), garageCache[workshopIdentifier].rentedBy)
end)

addEvent("exitRentGarage", true)
addEventHandler("exitRentGarage", root, function()
    local workshopIdentity = getElementDimension(client)
    local _, aisleIdentity, doorIdentity = getAisleFromWorkshop(workshopIdentity)

    local exitPositionData = {}
    for doorNum = 1, #aisleDoors do
        if doorNum == doorIdentity then
            local x, y, z, rz = unpack(aisleDoors[doorNum])
            x = x + lobbyX
            y = y + lobbyY
            z = z + lobbyZ + 1
            local rad = math.rad(rz) - math.pi / 2
            x = x + math.cos(rad) * 6.66072
            y = y + math.sin(rad) * 6.66072
            exitPositionData = {x, y, z, rz}
        end
    end
    local veh = getPedOccupiedVehicle(client)

    local x, y, z = exitPositionData[1], exitPositionData[2], exitPositionData[3]
    local dim = 65535 - aisleIdentity
    local int = 0
    local rz = exitPositionData[4]

    if isElement(veh) then
        setElementPosition(veh, x, y, z)
        setElementInterior(veh, int)
        setElementDimension(veh, dim)
        setElementRotation(veh, 0, 0, rz)

        local occupants = getVehicleOccupants(veh)
        setElementData(client, "paintshopGarage", false)
        setElementData(client, "currentCustomGarage", false)

        for k, v in pairs(occupants) do
            setElementInterior(v, int)
            setElementDimension(v, dim)
            setElementData(v, "paintshopGarage", false)
            setElementData(v, "currentCustomGarage", false)
        end
    else
        setElementPosition(client, x, y, z)
        setElementInterior(client, int)
        setElementDimension(client, dim)
        setElementRotation(client, 0, 0, rz)
        setElementData(client, "paintshopGarage", false)
        setElementData(client, "currentCustomGarage", false)
    end

    local lobbyDatas = fetchLobby(aisleIdentity, true)
    triggerClientEvent(client, "loadedGaragesLobby", client, aisleIdentity, lobbyDatas[1], lobbyDatas[2])
end)
addEvent("tryToLockUnlockRentGarage", true)
addEventHandler("tryToLockUnlockRentGarage", root, function(garageIdentity)
    if not garageIdentity then
        garageIdentity = getElementDimension(client)
    end
    if garageCache[garageIdentity].rentedBy == getElementData(client, "char.ID") then
        garageCache[garageIdentity].locked = not garageCache[garageIdentity].locked

        local state = garageCache[garageIdentity].locked and 1 or 0

        if state == 1 then
            exports.sChat:localAction(client, "bezárta egy garázs ajtaját.")
        else
            exports.sChat:localAction(client, "kinyitotta egy garázs ajtaját.")
        end

        dbExec(dbConnection, "UPDATE garages SET lockedState = ? WHERE interiorId = ?", state, garageIdentity)
        triggerClientEvent("refreshGarageLocked", client, garageIdentity, garageCache[garageIdentity].locked)
    end
end)

addEvent("unrentGarage", true)
addEventHandler("unrentGarage", root, function(garageIdentity)
    dbQuery(function(qh, client, garageIdentity)
        local result = dbPoll(qh, 0)
        if result[1] then
            local rentMode = result[1].rentMode
            if rentMode == "money" then
                exports.sCore:giveMoney(client, rentPrices.normal - 20000)
            end

            dbExec(dbConnection, "DELETE FROM garages WHERE interiorId = ?", garageIdentity)

            exports.sGui:showInfobox(client, "s", "Sikeresen lemondtad a bérletet, visszakaptad a kauciót!")

            triggerClientEvent("refreshGarageRented", client, garageIdentity, false)

            garageCache[garageIdentity] = nil

            if garageTimers[garageIdentity] then
                killTimer(garageTimers[garageIdentity])
                garageTimers[garageIdentity] = nil
            end
        end
    end, {client, garageIdentity}, dbConnection, "SELECT rentMode FROM garages WHERE interiorId = ?", garageIdentity)
end)

addEvent("tryToBreakInRentable", true)
addEventHandler("tryToBreakInRentable", root, function(currentGarage, currentPaintshop, itemDbId)
    if client == source then
        if currentGarage then
            if garageCache[currentGarage].locked then
                exports.sChat:localAction(client, "betörte egy ingatlan ajtaját.")

                garageCache[currentGarage].locked = false

                local state = garageCache[currentGarage].locked and 1 or 0
            
                dbExec(dbConnection, "UPDATE garages SET lockedState = ? WHERE interiorId = ?", state, currentGarage)
                triggerClientEvent("refreshGarageLocked", client, currentGarage, garageCache[currentGarage].locked)
            
                local item = exports.sItems:hasItemEx(client, "dbID", itemDbId)
                if (item.data1 or 0) + 1 < 10 then
                    exports.sItems:updateItemData1(client, itemDbId, (item.data1 or 0) + 1)
                else
                    exports.sItems:takeItem(client, "dbID", itemDbId)
                end
            else
                exports.sGui:showInfobox(client, "e", "Ez a garázs nyitva van!")
            end
        elseif currentPaintshop then
            if workshopCache[currentPaintshop].locked then
                exports.sChat:localAction(client, "betörte egy ingatlan ajtaját.")

                workshopCache[currentPaintshop].locked = false

                local state = workshopCache[currentPaintshop].locked and 1 or 0
            
                dbExec(dbConnection, "UPDATE paintshops SET lockedState = ? WHERE paintshopIdentity = ?", state, currentPaintshop)
                triggerClientEvent("refreshPaintshopLocked", client, currentPaintshop, workshopCache[currentPaintshop].locked)
            
                local item = exports.sItems:hasItemEx(client, "dbID", itemDbId)
                if (item.data1 or 0) + 1 < 10 then
                    exports.sItems:updateItemData1(client, itemDbId, (item.data1 or 0) + 1)
                else
                    exports.sItems:takeItem(client, "dbID", itemDbId)
                end
            else
                exports.sGui:showInfobox(client, "e", "Ez a műhely nyitva van!")
            end
        end
    end
end)

function requestPlayerRentedGarages(charID)
    local properties = {}

    local charID = charID
    for k, v in pairs(garageCache) do
        if v.rentedBy == charID then
            local door, aisle = getAisleFromWorkshop(k)
            table.insert(
                properties, 
                {
                    editable = "N",
                    inside = {0, 0, 0, 0, 4165, 0},
                    locked = v.locked,
                    name = formatGarageName(k),
                    outside = {garageDoors[door][1], garageDoors[door][2], garageDoors[door][3] + 1, 0, 0, 0},
                    owner = charID,
                    price = 1,
                    reportTime = 3748382037,
                    type = "otherRentable",
                    zone = garageDoors[door][7],
                    ownerType = "player",
                    id = k,
                    intiType = "otherRentable",
                    locationName = garageDoors[door][7],
                    pos = {garageDoors[door][1], garageDoors[door][2], garageDoors[door][3] + 1, 0, 0, 0},
                    expire = v.rentUntil,
                    rentUntil = v.rentUntil
                }
            )
        end
    end

    for k, v in pairs(workshopCache) do
        if v.rentedBy == charID then
            local door, aisle = getAisleFromWorkshop(k)
            table.insert(
                properties, 
                {
                    editable = "N",
                    inside = {0, 0, 0, 0, 4165, 0},
                    locked = v.locked,
                    name = formatShopName(k),
                    outside = {garageDoors[door][1], garageDoors[door][2], garageDoors[door][3] + 1, 0, 0, 0},
                    owner = charID,
                    price = 1,
                    reportTime = 3748382037,
                    type = "workshop",
                    zone = garageDoors[door][7],
                    ownerType = "player",
                    id = k,
                    intiType = "workshop",
                    locationName = garageDoors[door][7],
                    pos = {garageDoors[door][1], garageDoors[door][2], garageDoors[door][3] + 1, 0, 0, 0},
                    expire = v.rentUntil,
                    rentUntil = v.rentUntil
                }
            )
        end
    end

    return properties
end