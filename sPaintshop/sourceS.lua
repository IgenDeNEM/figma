local brushSizes = {5, 15, 25, 50, 75}
local mixerData = {}
dbConnection = false
addEventHandler("onResourceStart", getRootElement(), function(resourceElement)
    if resourceElement == getThisResource() then
        setTimer(function()
            for k, v in pairs(getElementsByType("player")) do
                if getElementData(v, "currentPaintshopLobby") then
                    --exports.sPaintshop:enterPaintshopLobby(v, getElementData(v, "currentPaintshopLobby"))
                end
                if getElementData(v, "currentPaintshop") then
                    exports.sPaintshop:tryToEnterPaintshop(v, getElementData(v, "currentPaintshop"))
                end
            end
        end, 1000, 1)

        for _, v in pairs(getElementsByType("vehicle")) do
            setElementData(v, "paintshopTrailerBoxes", nil)
        end
        dbConnection = exports.sConnection:getConnection()
    else
        local resourceName = getResourceName(resourceElement)
        if resourceName == "sConnection" then
            dbConnection = exports.sConnection:getConnection()
        end
    end
end)

rentPrices = {
    premium = 500,
    normal = 60000
}

playersInWorkshop = {}

workshopCache = {}
garageCache = {}
garageTimers = {}
local certificationCache = {}
local lobbyCache = {}

function findOwnerOfGarage(garageIdentity)
    if garageCache[garageIdentity] then
        local owner = garageCache[garageIdentity].rentedBy
        for _, v in pairs(getElementsByType("player")) do
            if getElementData(v, "char.ID") == owner then
                return v
            end
        end
    end
    return false
end

function findOwnerOfPaintshop(garageIdentity)
    if workshopCache[garageIdentity] then
        local owner = workshopCache[garageIdentity].rentedBy
        for _, v in pairs(getElementsByType("player")) do
            if getElementData(v, "char.ID") == owner then
                return v
            end
        end
    end
    return false
end

function garageExpired(garageIdentity)
    local client = findOwnerOfGarage(garageIdentity)
    if client then
        exports.sGui:showInfobox(client, "e", "A garázsbérleted lejárt!")
    end
    if garageCache[garageIdentity] then
        garageCache[garageIdentity] = nil
    end
    if garageTimers[garageIdentity] then
        killTimer(garageTimers[garageIdentity])
        garageTimers[garageIdentity] = nil
    end
    dbExec(dbConnection, "DELETE FROM garages WHERE interiorId = ?", garageIdentity)

    triggerClientEvent("refreshGarageRented", getRootElement(), garageIdentity, false)
end

function paintshopExpired(garageIdentity)
    local client = findOwnerOfPaintshop(garageIdentity)
    if client then
        exports.sGui:showInfobox(client, "e", "A műhelybérleted lejárt!")
    end
    if workshopCache[garageIdentity] then
        workshopCache[garageIdentity] = nil
    end
    if workshopTimers[garageIdentity] then
        killTimer(workshopTimers[garageIdentity])
        workshopTimers[garageIdentity] = nil
    end
    dbExec(dbConnection, "DELETE FROM paintshops WHERE paintshopIdentity = ?", garageIdentity)

    triggerClientEvent("refreshPaintshopRented", getRootElement(), garageIdentity, false)
end

local renamedZoneNames = {
    ["Red County"] = "Blueberry Industrial Park",
    ["Los Santos International"] = "Ocean Docks Industrial Park"
}
addEventHandler("onResourceStart", getRootElement(), function(resourceElement)
    if resourceElement == getThisResource() then
        local databaseQuery = dbQuery(dbConnection, "SELECT * FROM paintshops")
        local queryResult, numRows = dbPoll(databaseQuery, -1)

        if numRows > 0 then
            for i, row in ipairs(queryResult) do
                if row.rentUntil > 0 and row.rentUntil > getRealTimestamp() then
                    local doorId, aisleId, insideId = getAisleFromWorkshop(row.paintshopIdentity)
                    local position = {garageDoors[doorId][1], garageDoors[doorId][2], garageDoors[doorId][3]}
                    local zoneName = exports.sRadar:getZoneName(position[1], position[2], position[3])
                    zoneName = renamedZoneNames[zoneName] and renamedZoneNames[zoneName] or zoneName 
                    workshopCache[row.paintshopIdentity] = {}
                    workshopCache[row.paintshopIdentity].rentedBy = row.rentedBy
                    workshopCache[row.paintshopIdentity].rentMode = row.rentMode
                    workshopCache[row.paintshopIdentity].rentUntil = row.rentUntil
                    workshopCache[row.paintshopIdentity].workshopName = tostring(row.paintshopName)
                    workshopCache[row.paintshopIdentity].ownerName = tostring(row.paintshopName)
                    workshopCache[row.paintshopIdentity].name = tostring(row.paintshopName)
                    workshopCache[row.paintshopIdentity].type = "workshop"
                    workshopCache[row.paintshopIdentity].id = row.paintshopIdentity
                    workshopCache[row.paintshopIdentity].pos = position
                    workshopCache[row.paintshopIdentity].locationName = zoneName


                    local lockedState = false
                    if row.lockedState == 1 then
                        lockedState = true
                    end
                    workshopCache[row.paintshopIdentity].locked = lockedState

                    -- // TODO: Befejezni a police lockot!
                    workshopCache[row.paintshopIdentity].policeLockDatas = {
                        policeLock = false,
                        policeLockBy = false,
                        policeLockGroup = false,
                    }
                    workshopTimers[row.paintshopIdentity] = setTimer(paintshopExpired, (row.rentUntil - getRealTimestamp()) * 1000, 1, row.paintshopIdentity)
                else
                    paintshopExpired(row.paintshopIdentity)
                end
            end
        end
    end

    if resourceElement == getThisResource() then
        local databaseQuery = dbQuery(dbConnection, "SELECT * FROM garages WHERE interiorId > 0")
        local queryResult, numRows = dbPoll(databaseQuery, -1)

        if numRows > 0 then
            for i, row in ipairs(queryResult) do
                if row.rentUntil > 0 and row.rentUntil > getRealTimestamp() then
                    garageCache[row.interiorId] = {}
                    garageCache[row.interiorId].rentedBy = row.rentedBy
                    garageCache[row.interiorId].rentMode = row.rentMode
                    garageCache[row.interiorId].rentUntil = row.rentUntil

                    local lockedState = false
                    if row.lockedState == 1 then
                        lockedState = true
                    end
                    garageCache[row.interiorId].locked = lockedState

                    -- // TODO: Befejezni a police lockot!
                    garageCache[row.interiorId].policeLockDatas = {
                        policeLock = false,
                        policeLockBy = false,
                        policeLockGroup = false,
                    }
                    garageTimers[row.interiorId] = setTimer(garageExpired, (row.rentUntil - getRealTimestamp()) * 1000, 1, row.interiorId)
                else
                    garageExpired(row.interiorId)
                end
            end
        end
    end
end)

function fetchWorkshop(workshopIdentity, newlyRented, rentDatas)
    local fetchedData = {}
    local newlyRented = newlyRented or false
    if isWorkshopIdValid(workshopIdentity) then
        if workshopCache[workshopIdentity] then
            fetchedData = workshopCache[workshopIdentity]
        else
            if newlyRented then
                workshopIdentity = rentDatas.workshopIdentity
                rentedBy = rentDatas.rentedBy
                isLocked = rentDatas.locked
                
                local lockedState = 0
                if isLocked then
                    lockedState = 1
                end
                
                workshopName = rentDatas.workshopName
                rentMode = rentDatas.rentMode
                rentUntil = rentDatas.rentUntil

                local qh = dbQuery(dbConnection, "INSERT INTO paintshops (paintshopIdentity, rentedBy, rentUntil, lockedState, paintshopName, rentMode) VALUES(?, ?, ?, ?, ?, ?)", workshopIdentity, rentedBy, rentUntil, lockedState, workshopName, rentMode)
                dbFree(qh)

                workshopCache[workshopIdentity] = {
                    workshopName = rentDatas.workshopName,
                    name = rentDatas.workshopName,
                    ownerName = rentDatas.workshopName,
                    rentedBy = rentDatas.rentedBy,
                    rentUntil = rentDatas.rentUntil,
                    rentMode = rentDatas.rentMode,
                    locked = rentDatas.locked,
                    id = workshopIdentity
                }
                fetchedData = {workshopCache[workshopIdentity]}
            else
                local databaseQuery = dbQuery(dbConnection, "SELECT * FROM paintshops WHERE paintshopIdentity = ?", workshopIdentity)
                local queryResult, numRows = dbPoll(databaseQuery, -1)
    
                if numRows > 0 then
                    for i, row in ipairs(queryResult) do
                        fetchedData.workshopName = row.paintshopName
                        fetchedData.rentedBy = row.rentedBy
                        fetchedData.rentUntil = row.rentUntil
                        fetchedData.rentMode = row.rentMode

                        local lockedState = false
                        if row.lockedState == 1 then
                            lockedState = true
                        end 
                        fetchedData.lockedState = lockedState

                        -- // TODO: policeLockDatas -> processJson func
                        -- // TODO: paintshopCertificate -> processJson func
                    end
                    if devState and devInfo == "fetchWorkshop" then
                        outputDebugString("sightPaintshop >> fetchWorkshop - Workshop has sucessfully query-ed from database!")
                    end
                end

                workshopCache[workshopIdentity] = {
                    workshopName = fetchedData.workshopName,
                    rentedBy = fetchedData.rentedBy,
                    name = fetchedData.workshopName,
                    ownerName = fetchedData.workshopName,
                    rentUntil = fetchedData.rentUntil,
                    rentMode = fetchedData.rentMode,
                    locked = fetchedData.lockedState,
                    type = "workshop",
                    id = workshopIdentity,
                }

                fetchedData = workshopCache[workshopIdentity]
    
                if devState and devInfo == "fetchWorkshop" then
                    outputDebugString("sightPaintshop >> fetchWorkshop - Unable to find workshop with this datas!")
                end
            end
        end
    end
    return fetchedData
end

function fetchGarage(workshopIdentity, newlyRented, rentDatas)
    local fetchedData = {}
    local newlyRented = newlyRented or false
    if isWorkshopIdValid(workshopIdentity) then
        if garageCache[workshopIdentity] then
            garageCache[workshopIdentity] = {
                workshopName = rentDatas.workshopName,
                name = rentDatas.workshopName,
                ownerName = rentDatas.workshopName,
                rentedBy = rentDatas.rentedBy,
                rentUntil = rentDatas.rentUntil,
                locked = rentDatas.locked
            }
            dbExec(dbConnection, "UPDATE garages SET rentUntil = ? WHERE interiorId = ?", rentDatas.rentUntil, workshopIdentity)
            fetchedData = garageCache[workshopIdentity]
        else
            if newlyRented then
                workshopIdentity = rentDatas.workshopIdentity
                rentedBy = rentDatas.rentedBy
                isLocked = rentDatas.locked
                
                local lockedState = 0
                if isLocked then
                    lockedState = 1
                end
                
                rentMode = rentDatas.rentMode
                rentUntil = rentDatas.rentUntil

                local qh = dbQuery(dbConnection, "INSERT INTO garages (interiorId, rentedBy, rentUntil, lockedState, rentMode) VALUES(?, ?, ?, ?, ?)", workshopIdentity, rentedBy, rentUntil, lockedState, rentMode)
                dbFree(qh)
                local qh = dbQuery(dbConnection, "SELECT * FROM garages WHERE interiorId = ?", workshopIdentity)
                exports.sGarages:fetchGarageDatas(qh)
                dbFree(qh)

                garageCache[workshopIdentity] = {
                    workshopName = rentDatas.workshopName,
                    name = rentDatas.workshopName,
                    ownerName = rentDatas.workshopName,
                    rentedBy = rentDatas.rentedBy,
                    rentUntil = rentDatas.rentUntil,
                    locked = rentDatas.locked
                }
                fetchedData = {garageCache[workshopIdentity]}
            else
                local databaseQuery = dbQuery(dbConnection, "SELECT * FROM garages WHERE interiorId = ?", workshopIdentity)
                local queryResult, numRows = dbPoll(databaseQuery, -1)
    
                if numRows > 0 then
                    for i, row in ipairs(queryResult) do
                        fetchedData.rentedBy = row.rentedBy
                        fetchedData.rentUntil = row.rentUntil
                        fetchedData.rentMode = row.rentMode

                        local lockedState = false
                        if row.lockedState == 1 then
                            lockedState = true
                        end 
                        fetchedData.lockedState = lockedState

                        -- // TODO: policeLockDatas -> processJson func
                        -- // TODO: paintshopCertificate -> processJson func
                    end
                    if devState and devInfo == "fetchWorkshop" then
                        outputDebugString("sightPaintshop >> fetchWorkshop - Workshop has sucessfully query-ed from database!")
                    end
                end

                garageCache[workshopIdentity] = {
                    rentedBy = fetchedData.rentedBy,
                    name = fetchedData.workshopName,
                    rentUntil = fetchedData.rentUntil,
                    rentMode = fetchedData.rentMode,
                    locked = fetchedData.lockedState
                }

                fetchedData = garageCache[workshopIdentity]
    
                if devState and devInfo == "fetchWorkshop" then
                    outputDebugString("sightPaintshop >> fetchWorkshop - Unable to find workshop with this datas!")
                end
            end
        end
    end
    return fetchedData
end


function fetchLobby(lobbyIdentity, garage)
    if isAisleIdValid(lobbyIdentity) then
        if not garage then
            lobbyCache[lobbyIdentity] = {}
            rented = {}
            for id = 1, 14 do
                rented[id] = false
            end
        
            certs = {}
            for id = 1, 14 do
                certs[id] = false
            end
        
            for workshopIdentity, workshopData in pairs(workshopCache) do
                local aisleDatas = {getAisleFromWorkshop(workshopIdentity)}
                if lobbyIdentity == aisleDatas[2] then
                    local doorId = aisleDatas[3]
                    rented[doorId] = {}
                    rented[doorId].rentedBy = workshopData.rentedBy
                    local pricetype = "money"
                    if workshopData.rentMode == 1 then
                        pricetype = "premium"
                    elseif workshopData.rentMode == 2 then
                        pricetype = "money"
                    end
                    rented[doorId].rentMode = pricetype
        
                    if workshopData.locked then
                        rented[doorId].locked = true
                    else
                        rented[doorId].locked = false
                    end
                    rented[doorId].workshopName = workshopData.workshopName:gsub("_", " ") or "Fényező"
        
                    rented[doorId].rentUntil = workshopData.rentUntil
                    pLock = workshopData.policeLockDatas
                    if pLock and pLock.policeLock then
                        lockedBy = pLock.policeLockBy
                        lockGroup = pLock.policeLockGroup

                        rented[doorId].policeLock = pLoock.policeLock
                        rented[doorId].policeLockBy = lockedBy
                        rented[doorId].policeLockGroup = lockGroup
                    else
                        rented[doorId].policeLock = false
                        rented[doorId].policeLockBy = false
                        rented[doorId].policeLockGroup = false
                    end

                    certs[doorId] = nil
                    local aisleWorkshops = getWorkshopsInAisle(lobbyIdentity)

                    for wsId, wsData in ipairs(aisleWorkshops) do
                        local workshopId = lobbyIdentity * 20 + doorId
                        local saved = getWorkshopSavedData(workshopId)
                        if saved and saved.cert then
                            certs[doorId] = {saved.cert[1], saved.cert[2]}
                        end
                    end

                    if not certs[doorId] then
                        certs[doorId] = {0, 0}
                    end
                end
            end
            lobbyCache[lobbyIdentity] = {rented, certs}
        elseif garage then
            lobbyCache[lobbyIdentity] = {}
            rented = {}
            for id = 1, 14 do
                rented[id] = false
            end
        
            certs = {}
            for id = 1, 14 do
                certs[id] = false
            end
        
            for workshopIdentity, workshopData in pairs(garageCache) do
                local aisleDatas = {getAisleFromWorkshop(workshopIdentity)}
                if lobbyIdentity == aisleDatas[2] then
                    local doorId = aisleDatas[3]
                    rented[doorId] = {}
                    rented[doorId].rentedBy = workshopData.rentedBy
                    local pricetype = workshopData.rentMode
                    rented[doorId].rentMode = pricetype
                    if workshopData.locked then
                        rented[doorId].locked = true
                    else
                        rented[doorId].locked = false
                    end
        
                    rented[doorId].rentUntil = workshopData.rentUntil
                    pLock = workshopData.policeLockDatas
                    if pLock and pLock.policeLock then
                        lockedBy = pLock.policeLockBy
                        lockGroup = pLock.policeLockGroup

                        rented[doorId].policeLock = pLoock.policeLock
                        rented[doorId].policeLockBy = lockedBy
                        rented[doorId].policeLockGroup = lockGroup
                    else
                        rented[doorId].policeLock = false
                        rented[doorId].policeLockBy = false
                        rented[doorId].policeLockGroup = false
                    end


                    certs[doorId] = {1, 1}
                end
            end
            lobbyCache[lobbyIdentity] = {rented, certs}
        end
    end
    return {rented, certs}
end

function getPlayersInVehicle(sourcePlayer, vehicleElement)
    local playerCounter = 0
    local functionDatas = {}
    local players = {}
    for vehicleSeat, playerElement in pairs(getVehicleOccupants(vehicleElement)) do
        playerCounter = playerCounter + 1
        players[playerCounter] = playerElement
    end
    if playerCounter > 1 then
        return {true, players}
    else
        return {false, sourcePlayer}
    end
end

function updateEnterPosition(sourceElement, elementDatas, lobbyIdentifier, garage)
    if garage then
        lobbyIdentifier = 65535 - lobbyIdentifier
    end
    if getElementType(sourceElement) == "player" then
        local lobbyEntrance = {
            lobbyX + (-55),
            lobbyY + lobbyInsideDoor[2],
            5041.20,
            270
        }

        setElementPosition(sourceElement, lobbyEntrance[1], lobbyEntrance[2], lobbyEntrance[3])
        setElementRotation(sourceElement, 0, 0, 270)
        setElementDimension(sourceElement, lobbyIdentifier)
    elseif getElementType(sourceElement) == "vehicle" then
        local lobbyEntrance = {
            -47.857192993164, -3.8920273780823 - 0.425, 5041.8515625, 270
        }

        local trailerPosition = {
            -57.231185913086, -3.8920273780823 - 0.425, 5041.83515625, 270
        }

        setElementDimension(sourceElement, lobbyIdentifier)
        setElementPosition(sourceElement, lobbyEntrance[1], lobbyEntrance[2] - 0.425, lobbyEntrance[3])
        setElementRotation(sourceElement, 0, 0, lobbyEntrance[4])
        
        if isElement(elementDatas.trailerElement) then
            setElementDimension(elementDatas.trailerElement, lobbyIdentifier)
            setElementPosition(elementDatas.trailerElement, trailerPosition[1], trailerPosition[2], trailerPosition[3])
            setElementRotation(elementDatas.trailerElement, 0, 0, trailerPosition[4])
        end
    end
end

playersInLobby = {}

function enterPaintshopLobby(sourceElement, lobbyIdentifier, positionData)
    local lobbyDatas = fetchLobby(lobbyIdentifier)

    if not playersInLobby[lobbyIdentifier] then
        playersInLobby[lobbyIdentifier] = {}
    end

    local sourceVehicle = getPedOccupiedVehicle(sourceElement)
    if sourceVehicle then
        local vehiclePassangers = getPlayersInVehicle(sourceElement, sourceVehicle)
        if vehiclePassangers[1] then
            for i = 1, #vehiclePassangers[2] do
                setElementData(vehiclePassangers[2][i], "currentPaintshopLobby", lobbyIdentifier)
                triggerClientEvent(vehiclePassangers[2][i], "startPaintshopLobbyLoading", vehiclePassangers[2][i], lobbyIdentifier)
                triggerClientEvent(vehiclePassangers[2][i], "loadedPaintshopLobby", vehiclePassangers[2][i], lobbyIdentifier, lobbyDatas[1], lobbyDatas[2])
            end
            local elementDatas = {
                trailerElement = getElementData(sourceVehicle, "towCar") or false
            }
            updateEnterPosition(sourceVehicle, elementDatas, lobbyIdentifier)
        else
            local elementDatas = {
                trailerElement = getElementData(sourceVehicle, "towCar") or false
            }
            updateEnterPosition(sourceVehicle, elementDatas, lobbyIdentifier)

            triggerClientEvent(sourceElement, "startPaintshopLobbyLoading", sourceElement, lobbyIdentifier)
            triggerClientEvent(sourceElement, "loadedPaintshopLobby", sourceElement, lobbyIdentifier, lobbyDatas[1], lobbyDatas[2])
            setElementData(sourceElement, "currentPaintshopLobby", lobbyIdentifier)
        end
    else
        setElementData(sourceElement, "currentPaintshopLobby", lobbyIdentifier)
        if positionData then
            triggerClientEvent(sourceElement, "startPaintshopLobbyLoading", sourceElement, lobbyIdentifier)
            setElementPosition(sourceElement, positionData[1], positionData[2], positionData[3])
            setElementRotation(sourceElement, 0, 0, positionData[4])
            setElementDimension(sourceElement, lobbyIdentifier)

            triggerClientEvent(sourceElement, "loadedPaintshopLobby", sourceElement, lobbyIdentifier, lobbyDatas[1], lobbyDatas[2])
        else
            updateEnterPosition(sourceElement, false, lobbyIdentifier)

            triggerClientEvent(sourceElement, "startPaintshopLobbyLoading", sourceElement, lobbyIdentifier)
            triggerClientEvent(sourceElement, "loadedPaintshopLobby", sourceElement, lobbyIdentifier, lobbyDatas[1], lobbyDatas[2])
        end
    end


    table.insert(playersInLobby[lobbyIdentifier], sourceElement)
end

addEvent("enterPaintshopLobby", true)
addEventHandler("enterPaintshopLobby", root, function(lobbyIdentifier)
    if client == source then
        if isAisleIdValid(lobbyIdentifier) then
            enterPaintshopLobby(client, lobbyIdentifier)
        else
            acBan(source, "paintShop >> falseTrigger - enterPaintshopLobby [2]")
        end
    else
        acBan(source, "paintShop >> falseTrigger - enterPaintshopLobby [1]")
    end
end)

function updateExitPosition(sourceElement, elementDatas, doorPosition)
    if getElementType(sourceElement) == "player" then
        setElementPosition(sourceElement, doorPosition[1], doorPosition[2], doorPosition[3] + 1)
        setElementRotation(sourceElement, 0, 0, doorPosition[4])
        
        setElementInterior(sourceElement, 0)
        setElementDimension(sourceElement, 0)
        
    elseif getElementType(sourceElement) == "vehicle" then
        setElementInterior(sourceElement, 0)
        setElementDimension(sourceElement, 0)

        if isElement(elementDatas.trailerElement) then
            local rotationRad = doorPosition[4] * (math.pi / 180)

            local vehiclePlaceDistance = 3

            local dirX = -math.sin(rotationRad)
            local dirY = math.cos(rotationRad)

            local newX = doorPosition[1] + dirX * vehiclePlaceDistance
            local newY = doorPosition[2] + dirY * vehiclePlaceDistance

            setElementInterior(elementDatas.trailerElement, 0)
            setElementDimension(elementDatas.trailerElement, 0)

            local vehiclePlaceDistance = 6

            local newX = doorPosition[1] + dirX * vehiclePlaceDistance
            local newY = doorPosition[2] + dirY * vehiclePlaceDistance

            setElementPosition(sourceElement, newX, newY, doorPosition[3] + 1)
            setElementRotation(sourceElement, 0, 0, doorPosition[4])
        else
            setElementPosition(sourceElement, doorPosition[1], doorPosition[2], doorPosition[3] + 1)
            setElementRotation(sourceElement, 0, 0, doorPosition[4])
        end
    end
end

function exitPaintshopLobby(sourceElement)
    local lobbyIdentifier = getElementDimension(sourceElement)
    if isAisleIdValid(lobbyIdentifier) then
        local doorIdentity = getDoorFromAisle(lobbyIdentifier)
        local doorPosition = {garageDoors[doorIdentity][1], garageDoors[doorIdentity][2], garageDoors[doorIdentity][3], (garageDoors[doorIdentity][4] or 0)}
        local sourceVehicle = getPedOccupiedVehicle(sourceElement)
        
        if sourceVehicle then
            local elementDatas = {
                trailerElement = getElementData(sourceVehicle, "towCar") or false
            }
            updateExitPosition(sourceVehicle, elementDatas, doorPosition)

            local vehiclePassangers = getPlayersInVehicle(sourceElement, sourceVehicle)
            if vehiclePassangers[1] then
                for i = 1, #vehiclePassangers[2] do
                    setElementData(vehiclePassangers[2][1], "currentPaintshopLobby", false)
                    triggerClientEvent(vehiclePassangers[2][i], "loadedPaintshopLobby", vehiclePassangers[2][i])
                end
            end

            triggerClientEvent(sourceElement, "loadedPaintshopLobby", sourceElement)
        else
            setElementData(sourceElement, "currentPaintshopLobby", false)
            updateExitPosition(sourceElement, false, doorPosition)
            triggerClientEvent(sourceElement, "loadedPaintshopLobby", sourceElement)
        end

        for playerIndex, playerElement in pairs(playersInLobby[lobbyIdentifier]) do
            if playerElement == sourceElement then
                setElementData(sourceElement, "currentPaintshopLobby", false)
                table.remove(playersInLobby[lobbyIdentifier], playerIndex)
            end
        end

        return true
    elseif isAisleIdValid(65535 - lobbyIdentifier) then
        lobbyIdentifier = 65535 - lobbyIdentifier
        local doorIdentity = getDoorFromAisle(lobbyIdentifier)
        local doorPosition = {garageDoors[doorIdentity][1], garageDoors[doorIdentity][2], garageDoors[doorIdentity][3], (garageDoors[doorIdentity][4] or 0)}
        local sourceVehicle = getPedOccupiedVehicle(sourceElement)
        
        if sourceVehicle then
            local elementDatas = {
                trailerElement = getElementData(sourceVehicle, "towCar") or false
            }
            updateExitPosition(sourceVehicle, elementDatas, doorPosition)

            local vehiclePassangers = getPlayersInVehicle(sourceElement, sourceVehicle)
            if vehiclePassangers[1] then
                for i = 1, #vehiclePassangers[2] do
                    triggerClientEvent(vehiclePassangers[2][i], "loadedPaintshopLobby", vehiclePassangers[2][i])
                end
            end

            triggerClientEvent(sourceElement, "loadedPaintshopLobby", sourceElement)
        else
            updateExitPosition(sourceElement, false, doorPosition)
            triggerClientEvent(sourceElement, "loadedPaintshopLobby", sourceElement)
        end
        if playersInLobby[lobbyIdentifier] then
            for playerIndex, playerElement in pairs(playersInLobby[lobbyIdentifier]) do
                if playerElement == sourceElement then
                    setElementData(sourceElement, "currentPaintshopLobby", false)
                    table.remove(playersInLobby[lobbyIdentifier], playerIndex)
                end
            end
        end

        return true
    else
        for lobbyIndex, lobbyData in pairs(playersInLobby) do
            for playerIndex, playerElement in pairs(lobbyData) do
                if playerElement == sourceElement then
                    setElementData(sourceElement, "currentPaintshopLobby", false)
                    table.remove(playersInLobby[lobbyIndex], playerIndex)
                end
            end
        end

        triggerClientEvent(sourceElement, "loadedPaintshopLobby", sourceElement)
    end
end

addEvent("exitPaintshopLobby", true)
addEventHandler("exitPaintshopLobby", root, function()
    if client == source then
        exitPaintshopLobby(client)
    else
        acBan(source, "paintShop >> falseTrigger - exitPaintshopLobby [1]")
    end
end)

addEvent("renamePaintshopWorkshop", true)
addEventHandler("renamePaintshopWorkshop", root, function(newWorkshopName)
    local workshopIdentity = getElementDimension(client)
    if isWorkshopIdValid(workshopIdentity) then
        if workshopCache[workshopIdentity].rentedBy == getElementData(client, "char.ID") then
            workshopCache[workshopIdentity].name = newWorkshopName
            workshopCache[workshopIdentity].workshopName = newWorkshopName
            triggerClientEvent("refreshPaintshopRented", client, workshopIdentity, workshopCache[workshopIdentity])
        else
            exports.sGui:showInfobox("e", "Csak a tulajdonos tudja átnevezni a fényezőműhelyt!")
        end
    else
    end
end)

local lastSaveTimes = {}
local workshopPerms = {}

function getWorkshopPermissions(workshopIdentity)
    if not workshopPerms[workshopIdentity] then
        workshopPerms[workshopIdentity] = {}
    end
    return workshopPerms[workshopIdentity]
end

addEvent("paintshopTryToAddPlayer", true)
addEventHandler("paintshopTryToAddPlayer", root, function(playerElement)
    local workshopOwner = client
    local workshopIdentity = getElementDimension(workshopOwner)
    if playerElement == workshopOwner then return end
    if workshopIdentity then
        if isWorkshopIdValid(workshopIdentity) and workshopCache[workshopIdentity] and workshopCache[workshopIdentity].rentedBy == getElementData(workshopOwner, "char.ID") then
            if playerElement then
                if getElementData(playerElement, "loggedIn") then
                    local characterIdentity = getElementData(playerElement, "char.ID")
                    local workshopData = getWorkshopSavedData(workshopIdentity)
                    permissionData = workshopData.workshopPermissions

                    permissionData[characterIdentity] = {
                        name = getElementData(playerElement, "char.name"):gsub("_", " "),
                        false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false
                    }

                    saveWorkshopData(workshopIdentity, {workshopPermissions = permissionData})

                    for _, player in ipairs(playersInWorkshop[workshopIdentity]) do
                        triggerClientEvent(player, "syncWorkshopPermissions", player, workshopIdentity, characterIdentity, permissionData[characterIdentity])
                    end

                    exports.sGui:showInfobox(workshopOwner, "s", "Sikeresen hozzáadtad a játékost a fényezőműhelyhez!")
                else
                    exports.sGui:showInfobox(workshopOwner, "e", "Amennyiben a játékos nincs bejelentkezve nem tudod hozzáadni!")
                end
            end
        end
    end
end)

addEvent("refreshWorkshopPermissions", true)
addEventHandler("refreshWorkshopPermissions", root, function(unsyncedPermissionData)
    local workshopOwner = client
    local workshopIdentity = getElementDimension(workshopOwner)
    if not workshopIdentity then
        return
    end

    local workshopData = getWorkshopSavedData(workshopIdentity)
    workshopPerms = workshopData.workshopPermissions

    for k, v in pairs(workshopPerms) do
        for e, d in pairs(unsyncedPermissionData) do

            if k == e then
                for key, value in pairs(d) do
                    if v[key] ~= value then
                        workshopPerms[k][key] = value
                        for _, player in ipairs(playersInWorkshop[workshopIdentity]) do
                            triggerClientEvent(player, "syncWorkshopPermissions", player, workshopIdentity, k, workshopPerms[k])
                        end
                    end
                end
            end
        end
    end

    saveWorkshopData(workshopIdentity, {workshopPermissions = workshopPerms})
end)

addEvent("firePaintshopPlayer", true)
addEventHandler("firePaintshopPlayer", root, function(id)

    local workshopIdentity = getElementDimension(client)
    if not workshopIdentity then
        return
    end

    local workshopPerms = getWorkshopPermissions(workshopIdentity)

    table.remove(workshopPerms, id)

    for _, player in ipairs(playersInWorkshop[workshopIdentity]) do
        triggerClientEvent(player, "syncWorkshopPermissions", player, workshopIdentity, id, nil)
    end
    saveWorkshopPerms(workshopIdentity)
end)

function saveWorkshopPerms(workshopIdentity)
    local data = getWorkshopPermissions(workshopIdentity)
    saveWorkshopData(workshopIdentity, {workshopPermissions = data})
end

addEvent("rentPaintshopWorkshop", true)
addEventHandler("rentPaintshopWorkshop", root, function(workshopIdentifier, premiumRent)
    if client == source then
        if workshopIdentifier and isWorkshopIdValid(workshopIdentifier) then
            if premiumRent then
                local premiumPoints = exports.sCore:getPP(client)
                if premiumPoints >= rentPrices.premium then

                    exports.sCore:takePP(client, rentPrices.premium)

                    local time = getRealTimestamp() + 604800
                    local dateString = string.format("%04d.%02d.%02d %02d:%02d", getRealTime(time).year + 1900, getRealTime(time).month + 1, getRealTime(time).monthday, getRealTime(time).hour, getRealTime(time).minute)

                    exports.sGui:showInfobox(client, "s", "Sikeresen kibérelted a műhelyt! Lejár: " .. dateString)

                    if isTimer(workshopTimers[workshopIdentifier]) then
                        killTimer(workshopTimers[workshopIdentifier])
                        workshopTimers[workshopIdentifier] = nil
                    end

                    workshopTimers[workshopIdentifier] = setTimer(paintshopExpired, (time - getRealTimestamp()) * 1000, 1, workshopIdentifier)

                    triggerClientEvent(client, "paintshopRentSuccess", client)

                    local rentDatas = {
                        workshopName = getElementData(client, "visibleName"):gsub("_", " "),
                        name = getElementData(client, "visibleName"):gsub("_", " "),
                        ownerName = getElementData(client, "visibleName"):gsub("_", " "),
                        rentedBy = getElementData(client, "char.ID"),
                        rentUntil = getRealTimestamp() + 604800,
                        workshopIdentity = workshopIdentifier,
                        rentMode = "pp",
                        locked = false,
                    }

                    local filePaths = {
                        "data/"..workshopIdentifier.."/workshopData.sight"
                    }
                    for k, v in pairs(workStateFlow) do
                        for index = 1, 2 do
                            local fileName = "data/workstatemasks/" .. workshopIdentifier .. "/" ..index.."_".. v ..".sight"

                            table.insert(filePaths, fileName)
                        end
                    end

                    for i = 1, #filePaths do
                        if fileExists(filePaths[i]) then
                            fileDelete(filePaths[i])
                        end
                    end

                    fetchWorkshop(workshopIdentifier, true, rentDatas)
                    triggerClientEvent("refreshPaintshopRented", client, workshopIdentifier, rentDatas)
                else
                    triggerClientEvent(client, "paintshopRentFail", client)
                end
            else
                local playerMoney = exports.sCore:getMoney(client)
                if playerMoney >= rentPrices.normal + 15000 then

                    local canRent = true
                    for k, v in pairs(workshopCache) do
                        local rentMode = v.rentMode
                        if rentMode == "money" and v.id ~= workshopIdentifier and v.rentedBy == getElementData(client, "char.ID") then
                            if not garageCache[workshopIdentifier] then
                                canRent = false
                            end
                        end
                    end
                    if not canRent then
                        exports.sGui:showInfobox(client, "e", "Ezt a műhelyt már csak PrémiumPontból tudod bérelni!")
                        triggerClientEvent(client, "paintshopRentFail", client)
                        return
                    end

                    triggerClientEvent(client, "paintshopRentSuccess", client)

                    if isTimer(workshopTimers[workshopIdentifier]) then
                        killTimer(workshopTimers[workshopIdentifier])
                        workshopTimers[workshopIdentifier] = nil
                    end

                    local time = getRealTimestamp() + 604800

                    workshopTimers[workshopIdentifier] = setTimer(paintshopExpired, (time - getRealTimestamp()) * 1000, 1, workshopIdentifier)

                    exports.sCore:takeMoney(client, rentPrices.normal + 15000)

                    local dateString = string.format("%04d.%02d.%02d %02d:%02d", getRealTime(time).year + 1900, getRealTime(time).month + 1, getRealTime(time).monthday, getRealTime(time).hour, getRealTime(time).minute)

                    exports.sGui:showInfobox(client, "s", "Sikeresen kibérelted a műhelyt! Lejár: " .. dateString)

                    local rentDatas = {
                        workshopName = getElementData(client, "visibleName"):gsub("_", " "),
                        name = getElementData(client, "visibleName"):gsub("_", " "),
                        ownerName = getElementData(client, "visibleName"):gsub("_", " "),
                        rentedBy = getElementData(client, "char.ID"),
                        rentUntil = getRealTimestamp() + 604800,
                        workshopIdentity = workshopIdentifier,
                        rentMode = "money",
                        locked = false,
                    }

                    
                    local filePaths = {
                        "data/"..workshopIdentifier.."/workshopData.sight"
                    }
                    
                    

                    for k, v in pairs(workStateFlow) do
                        for index = 1, 2 do
                            local fileName = "data/workstatemasks/" .. workshopIdentifier .. "/" ..index.."_".. v ..".sight"

                            table.insert(filePaths, fileName)
                        end
                    end

                    for i = 1, #filePaths do
                        if fileExists(filePaths[i]) then
                            fileDelete(filePaths[i])
                        end
                    end

                    fetchWorkshop(workshopIdentifier, true, rentDatas)
                    triggerClientEvent("refreshPaintshopRented", client, workshopIdentifier, rentDatas)
                else
                    triggerClientEvent(client, "paintshopRentFail", client)
                end
            end
        else
            if tonumber(workshopIdentifier) then
                acBan(source, "paintShop >> falseTrigger - rentPaintshopWorkshop [2.2 - workshopIdentifier not assigned!]")
            else
                acBan(source, "paintShop >> falseTrigger - rentPaintshopWorkshop [2.1 - workshopIdentifier is not valid!]")
            end
        end
    else
        acBan(source, "paintShop >> falseTrigger - rentPaintshopWorkshop [1]")
    end
end)

function tryToEnterPaintshop(sourceElement, workshopIdentity)
    if not playersInWorkshop[workshopIdentity] then
        playersInWorkshop[workshopIdentity] = {}
    end

    for playerIndex, playerElement in pairs(playersInWorkshop[workshopIdentity]) do
        if playerElement == sourceElement then
            return
        end
    end

    triggerClientEvent(sourceElement, "enteredPaintWorkshop", sourceElement, workshopIdentity)


    enterPosition = {
        -4.4145202636719, 15.332124710083, 5001, 180
    }
    
    setElementPosition(sourceElement, enterPosition[1], enterPosition[2], enterPosition[3])
    setElementRotation(sourceElement, 0, 0, enterPosition[4])
    setElementDimension(sourceElement, workshopIdentity)

    setElementData(sourceElement, "currentPaintshop", workshopIdentity)


    table.insert(playersInWorkshop[workshopIdentity], sourceElement)

    if #playersInWorkshop[workshopIdentity] >= 1 then
        handleWorkshopSubscribe(workshopIdentity, true)
    end
end

addEvent("tryToEnterPaintWorkshop", true)
addEventHandler("tryToEnterPaintWorkshop", getRootElement(), function(workshopIdentity)
    if client and source == client then
        tryToEnterPaintshop(client, workshopIdentity)
    else
        acBan(source, "paintShop >> falseTrigger - tryToEnterPaintWorkshop [1]")
    end
end)

local workshopSkins = {}
function getWorkshopSkins(workshopIdentity)
    local returnTable = {}
    if not workshopSkins[workshopIdentity] then
        workshopSkins[workshopIdentity] = {}
        returnTable = workshopSkins[workshopIdentity]
    else
        returnTable = workshopSkins[workshopIdentity]
    end
    return returnTable
end

workshopWorks = {}
function requestPaintshopWorks(workshopIdentity)
    local returnTable = {}
    if workshopIdentity then
        if not workshopWorks[workshopIdentity] then
            workshopWorks[workshopIdentity] = {} -- defaultTable
            returnTable = workshopWorks[workshopIdentity]
        else
            returnTable = workshopWorks[workshopIdentity]
        end
    end
    return returnTable
end

local workshopGuns = {}
function requestGunStates(workshopIdentity)
    local returnTable = {}
    local defaultTable = {
        {player = false, tank = false, mixer = false, paintLevel = 0, paintType = false}, {player = false, tank = false, mixer = false, paintLevel = 0, paintType = false}
    }

    if workshopIdentity then
        if not workshopGuns[workshopIdentity] then
            workshopGuns[workshopIdentity] = defaultTable
            returnTable = workshopGuns[workshopIdentity]
        else
            returnTable = workshopGuns[workshopIdentity]
        end
    end
    return returnTable
end

local workshopSanders = {}
function requestSanderStates(workshopIdentity)
    local returnTable = {}
    local defaultTable = {
        {player = false, socket = nil}, {player = false, socket = nil}, {player = false, socket = nil}, {player = false, socket = nil}
    }
    if workshopIdentity then
        if not workshopSanders[workshopIdentity] then
            workshopSanders[workshopIdentity] = defaultTable
            returnTable = workshopSanders[workshopIdentity]
        else
            returnTable = workshopSanders[workshopIdentity]
        end
    end
    return returnTable
end

function requestMixerTanks()
    local mixerTank = {
        primer = 0,
        base = {0, 0},
        color = {
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0
        }
    }
    return mixerTank
end

local workshopStock = {}
function requestStockData(workshopIdentity)
    local returnTable = {}
    local defaultTable = {
        {3, 1}, {3, 1}, {3, 1}, {3, 4}, {3, true}, {3, 4}, {3, 4}, {3, 4}, {3, 4}, {3, 4}, {3, 4}, {3, 4}, {3, 4}, {3, 4}, {3, 4}, {3, 4}, {3, 4},
    }

    local workshopData = getWorkshopSavedData(workshopIdentity)
    local stockData = workshopData.stockData

    if workshopIdentity then
        if not stockData then
            stockData = defaultTable
            returnTable = stockData
        else
            returnTable = stockData
        end
    end
    return returnTable
end

function updateStockData(workshopIdentity, newStockData)

    local workshopData = getWorkshopSavedData(workshopIdentity)

    if workshopIdentity then
        local save = newStockData
        saveWorkshopData(workshopIdentity, {stockData = save})
    end
end

--[[local permTable = {
    [2] = {
        name = "Dennis_Mercury",
        true, -- >> openClose
        true, -- >> useSkin
        true, -- >> useSander
        true, -- >> usePaintgun
        true, -- >> toggleDry
        true, -- >> nextState
        true, -- >> sendOffer
        true, -- >> startJob
        true, -- >> cancelJob
        true, -- >> useMixer
        true, -- >> mixerMaintance
        true, -- >> createOrder
        true, -- >> transportOrder
        true, -- >> tranportIn
        true  -- >> transportOut
    },
}--]]

addEvent("tryToBuyPaintshopUpgrade", true)
addEventHandler("tryToBuyPaintshopUpgrade", root, function(levelIdentity)
    if client and client == source then
        local workshopIdentity = getElementDimension(client)
        local workshopData = getWorkshopSavedData(workshopIdentity)
        local workshopPoints = workshopData.workshopPoint or 0
        local upgradePrice = possibleUpgrades[levelIdentity].levelPrice[workshopData.upgrades[levelIdentity] + 1]
        if workshopPoints >= upgradePrice then
            triggerClientEvent(client, "gotPaintshopUpgradeBuy", client, true)

            workshopData.workshopPoint = workshopData.workshopPoint - upgradePrice

            triggerClientEvent(playersInWorkshop[workshopIdentity], "syncWorkshopPointBuy", client, workshopIdentity, workshopData.workshopPoint)

            workshopData.upgrades[levelIdentity] = workshopData.upgrades[levelIdentity] + 1
            saveWorkshopData(workshopIdentity, workshopData)

            triggerClientEvent(playersInWorkshop[workshopIdentity], "syncWorkshopUpgrades", client, workshopIdentity, levelIdentity, workshopData.upgrades[levelIdentity])
        else
            triggerClientEvent(client, "gotPaintshopUpgradeBuy", client, false)
        end
    end
end)

addEvent("tryToBuyPaintshopPoint", true)
addEventHandler("tryToBuyPaintshopPoint", root, function(pointIndex)
    if client and client == source then
        local workshopIdentity = getElementDimension(client)
        local clientPP = exports.sCore:getPP(client)

        local workshopData = getWorkshopSavedData(workshopIdentity)

        local currentPoints = workshopData.workshopPoint or 0 

        if clientPP >= possiblePoints[pointIndex].price then
            currentPoints = currentPoints + possiblePoints[pointIndex].amount
            triggerClientEvent(client, "workshopPointBuyResponse", client, workshopIdentity, true)
            triggerClientEvent(playersInWorkshop[workshopIdentity], "syncWorkshopPointBuy", client, workshopIdentity, currentPoints)

            workshopData.workshopPoint = currentPoints
            saveWorkshopData(workshopIdentity, workshopData)
        else
            triggerClientEvent(client, "workshopPointBuyResponse", client, workshopIdentity, false)
        end
    end
end)

addEvent("requestPaintshopInit", true)
addEventHandler("requestPaintshopInit", root, function()
    if client and client == source then
        local workshopIdentity = getElementDimension(client)

        local gunState = requestGunStates(workshopIdentity)
        local workshopSkins = getWorkshopSkins(workshopIdentity)
        local sanderState = requestSanderStates(workshopIdentity)

        local workshopData = getWorkshopSavedData(workshopIdentity)

        local workshopRating = workshopData.cert

        gunState[1].paintLevel = workshopData.gunStates[1].paintLevel
        gunState[1].paintType = workshopData.gunStates[1].paintType
        gunState[1].paintMetal = workshopData.gunStates[1].paintMetal
        gunState[1].mixer = workshopData.gunStates[1].mixer

        gunState[2].paintLevel = workshopData.gunStates[2].paintLevel
        gunState[2].paintType = workshopData.gunStates[2].paintType
        gunState[2].paintMetal = workshopData.gunStates[2].paintMetal
        gunState[2].mixer = workshopData.gunStates[2].mixer

        local paintshopWorks = workshopData.paintshopWorks
        local workshopPermissions = workshopData.workshopPermissions or {}
        local mixerTank = workshopData.mixerTank
        mixerData[workshopIdentity] = mixerTank

        local stockData = workshopData.stockData
        local maintanceData = workshopData.maintanceData
        local paintshopMails = workshopData.mails

        local openedBoxes = {}

        for k, v in pairs(stockData) do
            if v[1] < 4 and v[1] > 0 then
                if not v[2] then
                    v[2] = true
                    v[1] = v[1] - 1
                end
            elseif v[1] == 4 then
                v[1] = v[1] - 1
                if not v[2] then
                    v[2] = true
                end
            end
        end
        updateStockData(workshopIdentity, stockData)
        local upgradeLevels = workshopData.upgrades
        local workshopPoints = workshopData.workshopPoint or 0

        if not workshopRating then
            workshopRating = {}
        end

        if not workshopRating[1] then
            workshopRating[1] = 0
        end

        if not workshopRating[2] then
            workshopRating[2] = 0
        end

        local tempSkins = {}

        for k, v in pairs(workshopSkins) do
            if v then
                tempSkins[k] = v
            end
        end
        triggerClientEvent(client, "gotPaintshopInit", client, workshopIdentity, paintshopWorks, gunState, sanderState, mixerTank, stockData, maintanceData, paintshopMails, orderState, workshopCache[workshopIdentity], workshopRating[2], workshopRating[1], workshopPermissions, tempSkins, upgradeLevels, workshopPoints)
    end
end)

function exitPaintWorkshop(sourceElement, withoutLobby)
    local workshopIdentity = getElementData(sourceElement, "currentPaintshop")
    local _, aisleIdentity, doorIdentity = getAisleFromWorkshop(workshopIdentity)

    local exitPositionData = {}
    for doorNum = 1, #aisleDoors do
        if doorNum == doorIdentity then
            local x, y, z, rz = unpack(aisleDoors[doorNum])
            x = x + lobbyX
            y = y + lobbyY
            z = z + lobbyZ + 1
            local rad = math.rad(rz) - math.pi / 2
            x = x + math.cos(rad) * 1.254387 - math.sin(rad) * 4.62655
            y = y + math.sin(rad) * 1.254387 + math.cos(rad) * 4.62655
            exitPositionData = {x, y, z, rz}
        end
    end

    triggerClientEvent(sourceElement, "exitedPaintWorkshop", sourceElement, aisleIdentity)
    if not withoutLobby then
        enterPaintshopLobby(sourceElement, aisleIdentity, {exitPositionData[1], exitPositionData[2], exitPositionData[3], exitPositionData[4]})
    end
    if playersInWorkshop[workshopIdentity] then
        for playerIndex, playerElement in pairs(playersInWorkshop[workshopIdentity]) do
            if playerElement == sourceElement then
                setElementData(sourceElement, "currentPaintshop", false)
                table.remove(playersInWorkshop[workshopIdentity], playerIndex)
            end
        end
    end
    setElementData(sourceElement, "currentPaintshop", false)
    if #playersInWorkshop[workshopIdentity] <= 0 then
        handleWorkshopSubscribe(workshopIdentity, false)
    end

    for k, v in pairs(playersInWorkshop[workshopIdentity]) do
        if isElement(v) then
            triggerClientEvent(client, "setPaintshopWorkSkin", v, workshopIdentity, getElementData(v, "char.skin"))
        end
    end
end

addEvent("exitPaintWorkshop", true)
addEventHandler("exitPaintWorkshop", root, function()
    if client and client == source then
        local workshopIdentity = getElementDimension(client)
        local workshopSkins = getWorkshopSkins(workshopIdentity)

        if workshopSkins[client] then
            exports.sGui:showInfobox(client, "e", "Öltözz át, mielőtt kimennél!")
            triggerClientEvent(sourceElement, "exitedPaintWorkshop", sourceElement, false)
            return
        end

        exitPaintWorkshop(client)
    else
    end
end)

addEvent("paintshopSetWorkSkin", true)
addEventHandler("paintshopSetWorkSkin", getRootElement(), function()
    local workshopIdentity = getElementDimension(client)
    local workshopSkins = getWorkshopSkins(workshopIdentity)

    local skin = workshopSkins[client]
    local skinId = true

    if skin then
        workshopSkins[client] = nil
        skinId = getElementData(client, "char.skin")
        setElementModel(client, skinId)
    else
        workshopSkins[client] = true
    end

    triggerClientEvent(playersInWorkshop[workshopIdentity], "setPaintshopWorkSkin", client, workshopIdentity, skinId)
end)

addEvent("tryToPickPaintShopSander", true)
addEventHandler("tryToPickPaintShopSander", getRootElement(), function(sanderIdentity)
    local workshopIdentity = getElementDimension(client)
    local sanderState = requestSanderStates(workshopIdentity)
    sanderState[sanderIdentity].socket = false

    if sanderState[sanderIdentity].player == client then
        sanderState[sanderIdentity].player = false
    else
        sanderState[sanderIdentity].player = client
    end

    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintSanderData", client, workshopIdentity, sanderIdentity, sanderState[sanderIdentity])
end)

addEvent("tryToUsePaintShopSocket", true)
addEventHandler("tryToUsePaintShopSocket", getRootElement(), function(sanderIdentity, socketIdentity)
    local workshopIdentity = getElementDimension(client)
    local sanderState = requestSanderStates(workshopIdentity)

    if socketIdentity then
        if sanderState[sanderIdentity].socket then
            sanderState[sanderIdentity].socket = false
        else
            sanderState[sanderIdentity].socket = socketIdentity
        end
    else
        sanderState[sanderIdentity].socket = false
    end

    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintSanderData", client, workshopIdentity, sanderIdentity, sanderState[sanderIdentity])
end)


addEvent("tryToPickPaintShopGun", true)
addEventHandler("tryToPickPaintShopGun", getRootElement(), function(gunIdentity, gunTank)
    local workshopIdentity = getElementDimension(client)
    local gunState = requestGunStates(workshopIdentity)

    gunState[gunIdentity].tank = gunTank and gunTank or false

    if gunState[gunIdentity].player == client then
        gunState[gunIdentity].player = false
        gunState[gunIdentity].tank = false
    else
        gunState[gunIdentity].player = client
    end

    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintGunData", client, workshopIdentity, gunIdentity, gunState[gunIdentity])
end)

addEvent("putBackPaintShopGun", true)
addEventHandler("putBackPaintShopGun", getRootElement(), function()
    local workshopIdentity = getElementDimension(client)
    local gunState = requestGunStates(workshopIdentity)
    local selectedGun = false

    for gunIdentity, gunData in ipairs(gunState) do
        if gunData.player == client then
            selectedGun = gunIdentity
        end
    end

    gunState[selectedGun].player = false
    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintGunData", client, workshopIdentity, selectedGun, gunState[selectedGun])
end)

addEvent("syncPaintshopPaintAnim", true)
addEventHandler("syncPaintshopPaintAnim", getRootElement(), function(animData)
    local workshopIdentity = getElementDimension(client)

    triggerClientEvent(playersInWorkshop[workshopIdentity], "syncPaintshopPaintAnim", client, workshopIdentity, animData)
end)

function getWorkstateMask(vehicleIdentity, workshopIdentity)
    local actualWorkId = vehicleIdentity * workshopIdentity
    if actualWorkId then
        if fileExists("data/workstatemasks/"..actualWorkId..".sight") then
            local saveFile = fileOpen("data/workstatemasks/"..actualWorkId..".sight")
            local fileSize = fileGetSize(saveFile)
            saveFile = fileRead(saveFile, fileSize)
            return saveFile, fileSize > 0 and true or false
        else
            local saveFile = fileCreate("data/workstatemasks"..actualWorkId..".sight")
            local fileSize = fileGetSize(saveFile)
            return saveFile, fileSize > 0 and true or false
        end
        fileClose(saveFile)
    end
end

local workStateMasks = {}
local workMasksCache = {} 

function fromUInt32(str)
    local byte1, byte2, byte3, byte4 = string.byte(str, 1, 4)
    if byte1 and byte2 and byte3 and byte4 then
        return byte4 * 0x1000000 + byte3 * 0x10000 + byte2 * 0x100 + byte1
    end
    return false
end

local uint32Cache = {}
function toUInt32(number)
    number = math.floor(number) % 0x100000000
    if not uint32Cache[number] then
        local byte4 = string.char(number % 256)
        local byte3 = string.char(math.floor(number / 0x100) % 256)
        local byte2 = string.char(math.floor(number / 0x10000) % 256)
        local byte1 = string.char(math.floor(number / 0x1000000) % 256)
        uint32Cache[number] = byte4 .. byte3 .. byte2 .. byte1
    end
    return uint32Cache[number]
end

function getWorkStateMask(vehicleIdentity, workshopIdentity)
    local actualIdentity = vehicleIdentity * workshopIdentity
    if fileExists("data/workstatemasks/"..actualIdentity..".sight") then
        local saveFile = fileOpen("data/workstatemasks/"..actualIdentity..".sight")
        local fileSize = fileGetSize(saveFile)
        saveFile = fileRead(saveFile, fileSize)
        return saveFile, false
    else
        local saveFile = fileCreate("data/workstatemasks/"..actualIdentity..".sight")
        local fileSize = fileGetSize(saveFile)
        return saveFile, true
    end
end

local imageSize = {1024, 1024}

function getPaintshopWorkProgress(state, workshopIdentity, vehicleIdentity)
    if not vehicleIdentity or not workshopIdentity then
        return false
    end

    local fileName = "data/workstatemasks/" .. workshopIdentity .. "/" .. vehicleIdentity .. "_".. state ..".sight"
    if not fileExists(fileName) then
        return false
    end

    local theFile = fileOpen(fileName, true)
    if not theFile then
        outputDebugString("file open err: " .. fileName)
        return false
    end

    local fileBuffer = {}
    while not fileIsEOF(theFile) do
        fileBuffer[#fileBuffer + 1] = fileRead(theFile, 256000)
    end

    fileBuffer = table.concat(fileBuffer)

    local result = {}
    local pos = 1

   for pos = 1, #fileBuffer - 4, 5 do
        local chunk5 = fileBuffer:sub(pos, pos + 4)
        
        local pixelID = fromUInt32(chunk5:sub(1, 4))
        local value = string.byte(chunk5:sub(5, 5))
        
        result[pixelID] = value
    end
    return result
end

function savePaintshopWorkProgress(state, workshopIdentity, vehicleIdentity, pixelValuePairs)
    if not vehicleIdentity or type(pixelValuePairs) ~= "table" then
        return false
    end

    local fileName = "data/workstatemasks/" .. workshopIdentity .. "/" ..vehicleIdentity.."_".. state ..".sight"
    local theFile

    if fileExists(fileName) then
        theFile = fileOpen(fileName)
        if theFile then
            fileSetPos(theFile, fileGetSize(theFile))
        else
            outputDebugString("file open err: " .. fileName)
            return false
        end
    else
        theFile = fileCreate(fileName)
        if not theFile then
            outputDebugString("file create err: " .. fileName)
            return false
        end
    end

    for pID, val in pairs(pixelValuePairs) do
        fileWrite(theFile, toUInt32(pID))
        fileWrite(theFile, string.char(val))
    end

    fileClose(theFile)
    return true
end

addEvent("requestPaintshopWorkData", true)
addEventHandler("requestPaintshopWorkData", getRootElement(), function(vehicleIdentity)
    workshopIdentity = getElementDimension(client)

    vehiclesState = requestPaintshopWorks(workshopIdentity)
    local loadingStart = getTickCount()

    local vehDatas = getWorkshopSavedData(workshopIdentity)

    vehiclesState[vehicleIdentity] = vehDatas.paintshopWorks[vehicleIdentity]

    local workData = getPaintshopWorkProgress(vehiclesState[vehicleIdentity].state, workshopIdentity, vehicleIdentity) or {}

    if hasContent then
        local maskData = requestedData
    end

    if workData then
        unsyncedData = workData
    else
        unsyncedData = false
    end

    local mask = vehiclesState[vehicleIdentity].state == "primer" and "assets/brushes/paintbrush.dds" or false
    
    local sendData = {}

    if vehiclesState[vehicleIdentity].state == "paint" then
        for k, v in pairs(workData) do
            sendData[k] = 0
        end
    else
        for k, v in pairs(workData) do
            sendData[k] = 255 - v
        end
    end
    
    local vehicleState = vehiclesState[vehicleIdentity].state

    local tableToSend = {
        color = vehiclesState[vehicleIdentity].color:gsub("#", ""),
        transportTrailer = vehiclesState[vehicleIdentity].transportTrailer,
        model = vehiclesState[vehicleIdentity].model,
        state = vehiclesState[vehicleIdentity].state,
        checking = false,
        dryingState = vehiclesState[vehicleIdentity].dryingState,
        metal = vehiclesState[vehicleIdentity].metal,
        partNames = vehiclesState[vehicleIdentity].partNames,
        lastPercent = vehiclesState[vehicleIdentity].lastPercent,
        sandingQuality = vehiclesState[vehicleIdentity].sandingQuality,
        primerQuality = vehiclesState[vehicleIdentity].primerQuality,
        paintQuality = vehiclesState[vehicleIdentity].paintQuality,
        price = vehiclesState[vehicleIdentity].price,
    }

    local workshopData = getWorkshopSavedData(workshopIdentity)
    local levelAmount = {5, 15, 25, 50, 75}
    local sandingLevel = workshopData.upgrades[5]
    local upgradedSize = levelAmount[sandingLevel] or 0  
    
    if not workData then
        workData = {}
    end

    local mask = vehiclesState[vehicleIdentity].state == "primer" and "assets/brushes/paintbrush.dds" or false
    
    local processedData = {}

    local sendProcessedData = {}

    if vehiclesState[vehicleIdentity].state == "primer" then
        local oldData = getPaintshopWorkProgress("sanding", workshopIdentity, vehicleIdentity) or {}
        for k, v in pairs(oldData) do
            processedData[k] = v
            sendProcessedData[k] = 0
        end
        for k, v in pairs(workData) do
            sendProcessedData[k] = v
        end
    else
        if vehiclesState[vehicleIdentity].state == "primerDry" then
            workData = getPaintshopWorkProgress("primer", workshopIdentity, vehicleIdentity) or {}
        elseif vehiclesState[vehicleIdentity].state == "break" then
            workData = getPaintshopWorkProgress("primer", workshopIdentity, vehicleIdentity) or {}
        elseif vehiclesState[vehicleIdentity].state == "paint" then
            oldData = getPaintshopWorkProgress("primer", workshopIdentity, vehicleIdentity) or {}
        elseif vehiclesState[vehicleIdentity].state == "paintDry" then
            oldData = getPaintshopWorkProgress("paint", workshopIdentity, vehicleIdentity) or {}
        end

        if oldData then
            for k, v in pairs(oldData) do
                processedData[k] = v
                sendProcessedData[k] = 0
            end
        end

        for k, v in pairs(workData) do
            processedData[k] = v
            sendProcessedData[k] = v
        end
    end
    
    local bufferChunk = 5012
    local chunkResults = {}
    for offset = 0, biggestSync - 1, bufferChunk do
        local endi = math.min(offset + bufferChunk - 1, biggestSync - 1)

        local chunkBuffers = {}
        for i = offset, endi do
            chunkBuffers[i - offset + 1] = string.char(sendProcessedData[i] or 0)
        end

        chunkResults[#chunkResults + 1] = table.concat(chunkBuffers)
    end

    local sendDataStr = table.concat(chunkResults)

    local maskPath = "paintjobs/"..vehiclesState[vehicleIdentity].model.."/"..vehiclesState[vehicleIdentity].dataPath
    maskPath = maskPath:gsub(".png", "")
    maskPath = maskPath .. "_MASK.png"

    local maskFile = fileOpen(maskPath, true)
    local fileBuffer = {}

    if not maskFile then
        return false
    end

    while not fileIsEOF(maskFile) do
        fileBuffer[#fileBuffer + 1] = fileRead(maskFile, 128000)
    end

    fileBuffer = table.concat(fileBuffer)

    local maskContent = fileBuffer

    fileClose(maskFile)

    local paintjobPath = "paintjobs/"..vehiclesState[vehicleIdentity].model.."/"..vehiclesState[vehicleIdentity].dataPath

    local paintjobDataFile = fileOpen(paintjobPath, true)

    local fileBuffer = {}
    while not fileIsEOF(paintjobDataFile) do
        fileBuffer[#fileBuffer + 1] = fileRead(paintjobDataFile, 128000)
    end

    fileBuffer = table.concat(fileBuffer)
    local paintjobData = fileBuffer
    fileBuffer = {}

    fileClose(paintjobDataFile)
    --triggerClientEvent(client, "refreshPaintshopWorks", client, workshopIdentity, vehicleIdentity, tableToSend)
    
    local bootData = workshopData.boothDatas or {}
    if bootData.started then

        local levelAmount = {5, 10, 15, 20, 25}
        levelAmount[0] = 0

        local boothLevel = workshopData.upgrades[2] or 0
        local percentElapsed = levelAmount[boothLevel] or 0

        local totalDryingTime = 900

        dryingElapsed = math.floor(totalDryingTime * (percentElapsed / 100))

        local totalElapsed = dryingElapsed or 0
        totalElapsed = totalElapsed + (getRealTime().timestamp - bootData.started)
    
        local progress = math.min(totalElapsed / 900, 1)
        bootData.dryingProgress = progress


        triggerClientEvent(client, "refreshPaintshopWorks", client, workshopIdentity, vehicleIdentity, bootData)
    end

    triggerLatentClientEvent(client, "gotPaintshopWorkData", 500000, client, workshopIdentity, vehicleIdentity, vehiclesState[vehicleIdentity].state, paintjobData, maskContent, sendDataStr, processedData)
end)

addEvent("syncPaintshopSandingParticle", true)
addEventHandler("syncPaintshopSandingParticle", getRootElement(), function(x, y, z, a, n)
    local workshopIdentity = getElementDimension(client)
    local syncWith = {}

    for k, v in pairs(playersInWorkshop[workshopIdentity]) do
        if v ~= client then
            table.insert(syncWith, v)
        end
    end

    triggerClientEvent(playersInWorkshop[workshopIdentity], "syncPaintshopSandingParticle", client, workshopIdentity, x, y, z, a, n)
end)

addEvent("tryToUsePaintBooth", true)
addEventHandler("tryToUsePaintBooth", getRootElement(), function()
    local workshopIdentity = getElementDimension(client)
    local vehiclesState = requestPaintshopWorks(workshopIdentity)
    local workshopData = getWorkshopSavedData(workshopIdentity)

    local vehicleIdentity = false

    for k, v in pairs(vehiclesState) do
        if v.state == "primerDry" or v.state == "paintDry" then
            vehicleIdentity = k
        end
    end
    if vehicleIdentity then
        local workshop = workshopCache[workshopIdentity]
        local enabled = not workshop.boothDrying
    
        if enabled then
            workshop.boothClosed = true
            workshop.boothDrying = true
            workshop.dryingState = 0
    
            if not workshop.dryingTimeStamp then
                workshop.dryingTimeStamp = getRealTime().timestamp
            end

            local levelAmount = {5, 10, 15, 20, 25}
            levelAmount[0] = 0

            local boothLevel = workshopData.upgrades[2] or 0
            local percentElapsed = levelAmount[boothLevel] or 0

            local totalDryingTime = 900

            workshop.dryingElapsed = math.floor(totalDryingTime * (percentElapsed / 100))

            if not workshop.dryingElapsed then
                workshop.dryingElapsed = 0
            end
        else
            if workshop.dryingTimeStamp then
                local elapsed = getRealTime().timestamp - workshop.dryingTimeStamp
                workshop.dryingElapsed = (workshop.dryingElapsed or 0) + elapsed
                workshop.dryingTimeStamp = false
            end
    
            workshop.boothClosed = false
            workshop.boothDrying = false
            workshop.dryingState = false
        end
    
        local totalElapsed = workshop.dryingElapsed or 0
        if workshop.dryingTimeStamp then
            totalElapsed = totalElapsed + (getRealTime().timestamp - workshop.dryingTimeStamp)
        end
    
        local progress = math.min(totalElapsed / 900, 1)
    
        local tableToSend = {
            boothClosed = workshop.boothClosed,
            boothDrying = workshop.boothDrying,
            dryingState = workshop.dryingState,
            dryingProgress = progress,
            lastPercent = progress,
            vehId = vehicleIdentity,
            started = getRealTime().timestamp
        }
        saveWorkshopData(workshopIdentity, {boothDatas = tableToSend})
        triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopWorks", client, workshopIdentity, vehicleIdentity, tableToSend)
    else
        for k, v in pairs(vehiclesState) do
            if v.state == "primer" or v.state == "paint" then
                vehicleIdentity = k
            end
        end
        local workshop = workshopCache[workshopIdentity]
        local enabled = not workshop.boothClosed

        local tableToSend = {
            boothClosed = enabled,
            vehId = vehicleIdentity
        }
        workshop.boothClosed = enabled
        triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopWorks", client, workshopIdentity, vehicleIdentity, tableToSend)
        saveWorkshopData(workshopIdentity, {boothDatas = tableToSend})
    end
end)

local heldCasettes = {}

addEvent("tryToUsePaintStockBox", true)
addEventHandler("tryToUsePaintStockBox", getRootElement(), function(boxIdentity)
    local workshopIdentity = getElementDimension(client)
    local boxCache = requestStockData(workshopIdentity)
    local takenFromBox = false
    local hasPlayerBox = false

    local mixerData = getMixerData(workshopIdentity)
    local alreadyInMixer = false
    
    if boxIdentity == 1 then
        alreadyInMixer = (mixerData.primer or 0) > 0
    elseif boxIdentity == 2 then
        alreadyInMixer = (mixerData.base and mixerData.base[1] or 0) > 0
    elseif boxIdentity == 3 then
        alreadyInMixer = (mixerData.base and mixerData.base[2] or 0) > 0
    else
        local colourIndex = boxIdentity - 3
        alreadyInMixer = (mixerData.color and mixerData.color[colourIndex] or 0) > 0
    end
    
    if alreadyInMixer then
        exports.sGui:showInfobox(client, "e", "Ebből a festékből/alapozóból már van a mixerben!")
        return
    end

    if heldCasettes[workshopIdentity] then
        for _, casetteData in pairs(heldCasettes[workshopIdentity]) do
            if casetteData[1] == client then
                exports.sGui:showInfobox(client, "e", "Már van a kezedben egy kazetta!")
                return
            end
        end
    end

    local differentPackages = {
        [1] = 1,
        [2] = 1,
        [3] = 1,
    }

    if boxCache[boxIdentity] then
        if boxCache[boxIdentity][2] == true then
            boxCache[boxIdentity][2] = differentPackages[boxIdentity] and differentPackages[boxIdentity] or 4
            setPedAnimation(client, "bomber", "bom_plant", -1, true, false, false)
            setTimer(function(client)
                setPedAnimation(client)
            end, 5000, 1, client)
        elseif tonumber(boxCache[boxIdentity][2]) then
            takenFromBox = true
            boxCache[boxIdentity][2] = boxCache[boxIdentity][2] - 1
            setPedAnimation(client, "bomber", "bom_plant", -1, true, false, false)
            setTimer(function(client)
                setPedAnimation(client)
            end, 5000, 1, client)
            if boxCache[boxIdentity][2] == 0 then
                if boxCache[boxIdentity][1] >= 1 then
                    boxCache[boxIdentity] = {boxCache[boxIdentity][1] - 1, true}
                else
                    boxCache[boxIdentity] = {0, false}
                end
            end
        end
    end   

    if takenFromBox then
        if not heldCasettes[workshopIdentity] then
            heldCasettes[workshopIdentity] = {}
        end
    
        table.insert(heldCasettes[workshopIdentity], {client, boxIdentity})
    
        triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintShopMixerMaintenance", client, workshopIdentity, boxIdentity, client)
    end

    updateStockData(workshopIdentity, boxCache)    
    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopStockData", client, workshopIdentity, boxIdentity, boxCache[boxIdentity])
end)

local formattedNames = {
    [1] = {1, "primer"},
    [2] = {1, "base"},
    [3] = {2, "base"},
}

function getMixerData(workshopIdentity)
    if not mixerData[workshopIdentity] then
        mixerData[workshopIdentity] = {
            primer = 0,
            base = {[1] = 0, [2] = 0},
            color = {}
        }
        
        for i = 1, 14 do
            mixerData[workshopIdentity]["color"][i] = 0
        end
    end
    return mixerData[workshopIdentity]
end

function updateWorkshopMixer(workshopIdentity, sourcePlayer, casetteIdentity, newValue, decraseValue)
    local mixerData = getMixerData(workshopIdentity)

    local updatedData = {}

    if mixerData then
        if formattedNames[casetteIdentity] then
            local tableIndex = formattedNames[casetteIdentity][1]
            local formattedName = formattedNames[casetteIdentity][2]
            
            if not mixerData[formattedName] then
                mixerData[formattedName] = {}
            end
            
            if formattedName == "primer" then
                if decraseValue then
                    mixerData[formattedName] = (mixerData[formattedName] or 0) - decraseValue
                else
                    mixerData[formattedName] = newValue
                end
                updatedData = { primer = mixerData[formattedName] }
            else
                if decraseValue then
                    mixerData[formattedName][tableIndex] = (mixerData[formattedName][tableIndex] or 0) - decraseValue
                else
                    mixerData[formattedName][tableIndex] = newValue
                end
                updatedData[formattedName] = {}
                updatedData[formattedName][tableIndex] = mixerData[formattedName][tableIndex]
            end
        elseif casetteIdentity > 3 then
            local colorIndex = casetteIdentity - 3
            
            if not mixerData["color"] then
                mixerData["color"] = {}
            end
            
            if decraseValue then
                mixerData["color"][colorIndex] = (mixerData["color"][colorIndex] or 0) - decraseValue
            else
                mixerData["color"][colorIndex] = newValue
            end
            updatedData["color"] = {}
            updatedData["color"][colorIndex] = mixerData["color"][colorIndex]
        end
        
        if sourcePlayer then
            if not newValue then
                return
            end
            triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintMixerTankData", sourcePlayer, workshopIdentity, updatedData)
        end

        for _, colorData in pairs(mixerData) do
            for colorIndex, colorDetails in pairs(mixerData) do
            end
        end

        saveWorkshopData(workshopIdentity, {mixerTank = mixerData})
    end
end

addCommandHandler("fillMix", function(sp, cmd, wsId)
    if (getElementData(sp, "acc.adminLevel") or 0) > 6 then
        if not wsId then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/fillMix [műhelyID]", sp, 255, 255, 255, true)
            return
        end

        wsId = tonumber(wsId)
        if not wsId then
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A műhelyID-nek számnak kell lennie!", sp, 255, 255, 255, true)

            return
        end

        local customCasettes = {
            [1] = mixerTankMaximum.primer,
            [2] = mixerTankMaximum.base,
            [3] = mixerTankMaximum.base,
        }

        for i = 1, 17 do
            updateWorkshopMixer(wsId, sp, i, customCasettes[i] and customCasettes[i] or 200)

            local workshopData = getWorkshopSavedData(wsId)
            local maintanceData = workshopData.maintanceData
            maintanceData[i] = true
            saveWorkshopData(wsId, {maintanceData = maintanceData})
            triggerClientEvent(playersInWorkshop[wsId], "refreshPaintShopMixerMaintenance", sp, wsId, i, true)
        end

        outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]Sikeresen feltöltötted a(z) [color=sightgreen]"..wsId.."[color=hudwhite] műhely keverőgépét!", sp, 255, 255, 255, true)
    end
end)

local mixerTankData = {}
function ensureMixerTable(id)
    if not mixerTankData[id] then
        mixerTankData[id] = {false, false}
    end
    return mixerTankData[id]
end

addEvent("tryToStartPaintMixing", true)
addEventHandler("tryToStartPaintMixing", root, function(mixerGun, recipe, isMetal)
    if client ~= source then return end
    local wid = getElementDimension(client)
    local slotTbl = ensureMixerTable(wid)
    if slotTbl[2] ~= mixerGun then 
        return 
    end

    local guns = requestGunStates(wid)
    local takeDown = {}
    
    for cid,cval in pairs(validColors) do
        if cid == recipe then
            for i=1,17 do if cval[i] ~= 0 then takeDown[i] = cval[i] end end
        end
    end

    for cid,val in pairs(takeDown) do
        updateWorkshopMixer(wid, client, cid, false, val)
    end

    guns[mixerGun].paintType  = recipe
    guns[mixerGun].paintMetal  = isMetal
    guns[mixerGun].paintLevel = 1

    local saveTable = {}
    for gunId, gunData in pairs(guns) do
        saveTable[gunId] = {}
        saveTable[gunId].paintType = gunData.paintType
        saveTable[gunId].paintLevel = gunData.paintLevel
        saveTable[gunId].paintMetal  = gunData.paintMetal
    end
    saveWorkshopData(wid, {gunStates = saveTable})


    triggerClientEvent(playersInWorkshop[wid], "startPaintMixer", client, wid, recipe, isMetal)
    triggerClientEvent(playersInWorkshop[wid], "refreshPaintGunData", client, wid, mixerGun, guns[mixerGun])
end)

addEvent("tryToUsePaintShopMixerMachine", true)
addEventHandler("tryToUsePaintShopMixerMachine", root, function(tankInHand)
    local wid = getElementDimension(client)
    local guns = requestGunStates(wid)
    local slotTbl = ensureMixerTable(wid)
    local selTank = tankInHand or slotTbl[2]

    if tankInHand then                               -- BETESZ
        if guns[selTank].paintLevel > 0 then
            exports.sGui:showInfobox(client,"e","Ebben a tartályban még van festék!")
            return
        end
        if slotTbl[2] then
            exports.sGui:showInfobox(client,"e","A keverőben már van tartály!")
            return
        end
        guns[selTank].tank = "mixer"
        guns[selTank].player = false
        slotTbl[2] = selTank
    else                                             -- KIVESZ
        if not selTank then return end
        slotTbl[2]  = false
        guns[selTank].player = client
    end

    local saveTable = {}
    for gunId, gunData in pairs(guns) do
        saveTable[gunId] = {}
        saveTable[gunId].paintType = gunData.paintType
        saveTable[gunId].paintLevel = gunData.paintLevel
        saveTable[gunId].paintMetal  = gunData.paintMetal
    end
    saveWorkshopData(wid, {gunStates = saveTable})

    triggerClientEvent(playersInWorkshop[wid], "refreshPaintGunData", client, wid, selTank, guns[selTank])
end)

addEvent("emptyPaintTankToTrash", true)
addEventHandler("emptyPaintTankToTrash", root, function(tankInHand)
    local wid = getElementDimension(client)
    local guns = requestGunStates(wid)
    local t = tankInHand
    
    if not t then return end
    
    guns[t].paintLevel = 0
    guns[t].paintType = false
    guns[t].paintMetal = false
    guns[t].tank = "primer"
    guns[t].player = client
    
    local saveTable = {}
    for gunId, gunData in pairs(guns) do
        saveTable[gunId] = {}
        saveTable[gunId].paintType = gunData.paintType
        saveTable[gunId].paintLevel = gunData.paintLevel
        saveTable[gunId].paintMetal  = gunData.paintMetal
    end
    saveWorkshopData(wid, {gunStates = saveTable})

    triggerClientEvent(playersInWorkshop[wid],"refreshPaintGunData",client,wid,t,guns[t])
end)

addEvent("tryToUsePaintShopPrimerMachine", true)
addEventHandler("tryToUsePaintShopPrimerMachine", root, function(tankInHand)
    local wid = getElementDimension(client)
    local guns = requestGunStates(wid)
    local slotTbl = ensureMixerTable(wid)
    local workshopData = getWorkshopSavedData(wid)
    local mixerTank = workshopData.mixerTank
    local selTank = tankInHand or slotTbl[1]

    if tankInHand then                               -- BETESZ
        if guns[selTank].paintLevel > 0 then
            exports.sGui:showInfobox(client,"e","Ebben a tartályban már van alapozó!")
            return
        end
        if slotTbl[1] then
            exports.sGui:showInfobox(client,"e","A primer gépben már van tartály!")
            return
        end
        guns[selTank].tank = "primer"
        guns[selTank].paintType = "primer"
        guns[selTank].paintMetal = false
        guns[selTank].paintLevel = 1
        guns[selTank].player = false
        slotTbl[1] = selTank

        mixerTank.primer = mixerTank.primer - 1

        saveWorkshopData(wid, {mixerTank = mixerTank})
        triggerClientEvent(playersInWorkshop[wid], "startPaintMixer", client, wid, "primer")
    else                                             -- KIVESZ
        if not selTank then
            return
        end
        slotTbl[1] = false
        guns[selTank].player = client
        guns[selTank].tank = "primer"
    end

    local saveTable = {}
    for gunId, gunData in pairs(guns) do
        saveTable[gunId] = {}
        saveTable[gunId].paintType = gunData.paintType
        saveTable[gunId].paintLevel = gunData.paintLevel
        saveTable[gunId].paintMetal = gunData.paintMetal
    end
    saveWorkshopData(wid, {gunStates = saveTable})

    triggerClientEvent(playersInWorkshop[wid],"refreshPaintGunData", client, wid, selTank, guns[selTank])
end)

addEvent("tryToToggleMixerMaintenanceMode", true)
addEventHandler("tryToToggleMixerMaintenanceMode", getRootElement(), function()
    local workshopIdentity = getElementDimension(client)

    local workshopData = getWorkshopSavedData(workshopIdentity)
    local maintanceData = workshopData.maintanceData
    local state = false
    if not maintanceData then
        maintanceData = {}
    end
    for i = 1, 17 do
        if not maintanceData[i] then
            state = true
            maintanceData[i] = true
        end
    end
    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintShopMixerMaintenanceAll", client, workshopIdentity, state and maintanceData or false)

    if not state then
        maintanceData = false 
    end
    saveWorkshopData(workshopIdentity, {maintanceData = maintanceData})
end)

addEvent("emptyPaintCasetteToTrash", true)
addEventHandler("emptyPaintCasetteToTrash", getRootElement(), function(playerHoldingCasette)
    if client and client == source then
        local workshopIdentity = getElementDimension(client)

        local foundCasette = false
        local matchingCasette = false

        if heldCasettes[workshopIdentity] then
            for _, casetteData in pairs(heldCasettes[workshopIdentity]) do
                if casetteData[1] == client then
                    foundCasette = true
                    if casetteData[2] == playerHoldingCasette then
                        matchingCasette = true
                    end

                    casetteData[1] = nil
                    casetteData[2] = nil
                    casetteData[3] = nil
                end
            end
        end

        if not matchingCasette then
        end

        if foundCasette then
            exports.sGui:showInfobox(client, "s", "Sikeresen kidobtad a kukába a kazettát!")
            triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintShopMixerMaintenance", client, workshopIdentity, playerHoldingCasette, false)
        end
    end
end)

addEvent("tryGetOutPaintMachineCasette", true)
addEventHandler("tryGetOutPaintMachineCasette", getRootElement(), function(machineSlot)
    if client == source then
        local foundCasette = false
        if heldCasettes[workshopIdentity] then
            for _, casetteData in pairs(heldCasettes[workshopIdentity]) do
                if casetteData[1] == client then
                    foundCasette = true
                    break
                end
            end
        end
        
        if not foundCasette then
            local workshopIdentity = getElementDimension(client)

            updateWorkshopMixer(workshopIdentity, sourcePlayer, machineSlot, 0)

            local workshopData = getWorkshopSavedData(workshopIdentity)
            local maintanceData = workshopData.maintanceData
            maintanceData[machineSlot] = false
            saveWorkshopData(workshopIdentity, {maintanceData = maintanceData})

            if not heldCasettes[workshopIdentity] then
                heldCasettes[workshopIdentity] = {}
            end

            table.insert(heldCasettes[workshopIdentity], {client, machineSlot, "used"})
    
            triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintShopMixerMaintenance", client, workshopIdentity, machineSlot, client)
        else
            exports.sGui:showInfobox(client, "e", "Már van a kezedben egy kazetta!")
        end
    end
end)

addEvent("tryPutInPaintMachineCasette", true)
addEventHandler("tryPutInPaintMachineCasette", getRootElement(), function(machineSlot)
    local playerCasette = nil
    local workshopIdentity = getElementDimension(client)
    
    local currentMixerData = getMixerData(workshopIdentity, client)
    
    for _, casetteData in pairs(heldCasettes[workshopIdentity]) do
        if casetteData[1] == client then
            if casetteData[3] and casetteData[3] == "used" then
                exports.sGui:showInfobox(client, "e", "Használt kazettát csak kidobni lehet!")
                return
            end
            playerCasette = casetteData[2]
            casetteData[1] = nil
            casetteData[2] = nil
            casetteData[3] = nil
        end
    end

    local customCasettes = {
        [1] = mixerTankMaximum.primer,
        [2] = mixerTankMaximum.base,
        [3] = mixerTankMaximum.base,
    }

    local workshopData = getWorkshopSavedData(workshopIdentity)

    local maintanceData = workshopData.maintanceData
    maintanceData[playerCasette] = true
    saveWorkshopData(workshopIdentity, {maintanceData = maintanceData})
    
    updateWorkshopMixer(workshopIdentity, client, machineSlot, customCasettes[playerCasette] and customCasettes[playerCasette] or mixerTankMaximum.color)
    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintShopMixerMaintenance", client, workshopIdentity, playerCasette, true)
end)

function calculateMaskCoverage(maskData, workMaskData)
    local overallSum, coveredSum = 0, 0
    for i = 1, #maskData do
        if maskData[i] < 128 then
            overallSum = overallSum + 1
            if workMaskData[i] and workMaskData[i] < 128 then
                coveredSum = coveredSum + 1
            end
        end
    end
    return (coveredSum / overallSum) * 100
end

sync = {}

function coordToSync(x, y)
    return x * 1025 + y
end
biggestSync = coordToSync(1023, 1023)

addEvent("syncPaintshopData", true)
addEventHandler("syncPaintshopData", getRootElement(), function(dataIdentity, unsyncedData, unsyncedPaintGunId, unsyncedPaintDelta)
    local workshopIdentity = getElementDimension(client)
    local vehiclesState = requestPaintshopWorks(workshopIdentity)

    local workVehicleId = dataIdentity

    if not sync[dataIdentity] then
        sync[dataIdentity] = {}
    end

    savePaintshopWorkProgress(vehiclesState[dataIdentity].state, workshopIdentity, workVehicleId, unsyncedData)

    triggerClientEvent(playersInWorkshop[workshopIdentity], "gotPaintshopSyncedData", client, workshopIdentity, workVehicleId, unsyncedData)
end)

function reMap(value, low1, high1, low2, high2)
    return low2 + (value - low1) * (high2 - low2) / (high1 - low1)
end


local workStateProgress = {}

lastChecks = {}

workMaskCache = {}

addEvent("tryToCheckPaintshopProgress", true)
addEventHandler("tryToCheckPaintshopProgress", getRootElement(), function(vehicleIdentity)
    local workshopIdentity = getElementDimension(client)
    if lastChecks[workshopIdentity] then
        if getTickCount() - lastChecks[workshopIdentity] < 60000 then
            exports.sGui:showInfobox(client, "e", "Ilyen gyorsan nem frissítheted!")
            return
        end
    end
    sourcePlayer = client

    local tableToSend = {
        color = vehiclesState[vehicleIdentity].color:gsub("#", ""),
        transportTrailer = vehiclesState[vehicleIdentity].transportTrailer,
        model = vehiclesState[vehicleIdentity].model,
        state = vehiclesState[vehicleIdentity].state,
        checking = true,
        dryingState = vehiclesState[vehicleIdentity].dryingState,
        metal = vehiclesState[vehicleIdentity].metal,
        partNames = vehiclesState[vehicleIdentity].partNames,
        lastPercent = vehiclesState[vehicleIdentity].lastPercent,
        sandingQuality = vehiclesState[vehicleIdentity].sandingQuality,
        primerQuality = vehiclesState[vehicleIdentity].primerQuality,
        paintQuality = vehiclesState[vehicleIdentity].paintQuality,
        price = vehiclesState[vehicleIdentity].price
    }

    triggerLatentClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopWorks", 15000000, sourcePlayer, workshopIdentity, vehicleIdentity, tableToSend)
            

    lastChecks[workshopIdentity] = getTickCount()
    local vehiclesState = requestPaintshopWorks(workshopIdentity)
    local workData = getPaintshopWorkProgress(vehiclesState[vehicleIdentity].state, workshopIdentity, vehicleIdentity)
    local vehiclePixels = {}

    if not workData then workData = {} end

    local isPrimer = vehiclesState[vehicleIdentity].state == "primer"

    local name = vehiclesState[vehicleIdentity].dataPath:gsub(".png", "")
    local name = name .. "_MASK" .. ".sight"

    local maskPath = "paintjobs/"..vehiclesState[vehicleIdentity].model.."/"..name

    local maskFile = fileOpen(maskPath, true)

    if not workMaskCache[maskPath] then
        workMaskCache[maskPath] = {}
    end

    local fileBuffer = ""

    while not fileIsEOF(maskFile) do
        fileBuffer = fileBuffer .. fileRead(maskFile, 512000)
    end

    fileClose(maskFile)
    workMaskCache[maskPath] = fromJSON(fileBuffer)

    local coroutineProcess = coroutine.create(function()
        local workshopData = getWorkshopSavedData(workshopIdentity)
        local sandingSize, primerSize = brushSizes[(workshopData.upgrades[5])] or 0, brushSizes[(workshopData.upgrades[6])] or 0
        local brushSize = isPrimer and 48 * (1 + (primerSize / 100)) or 32 * (1 + (sandingSize / 100))
        local halfBrush = math.floor(brushSize / 2)

        local i = 0
        local j = 0

        local xCache, yCache = {}, {}

        for pixelID, v in pairs(workData) do
            local x = xCache[pixelID] or ((pixelID - 1) % 1024)
            local y = yCache[pixelID] or math.floor((pixelID - 1) / 1024)

            xCache[pixelID] = x
            yCache[pixelID] = y


            local startX = math.max(x - halfBrush, 0)
            local endX = math.min(x + (brushSize - halfBrush) - 1, 1023)
            local startY = math.max(y - halfBrush, 0)
            local endY = math.min(y + (brushSize - halfBrush) - 1, 1023)

            for row = startY, endY do
                j = j + 1
                for col = startX, endX do
                    local pixelIdentity = row * 1024 + col + 1
                    if not vehiclePixels[pixelIdentity] or vehiclePixels[pixelIdentity] < v then
                        vehiclePixels[pixelIdentity] = v
                        if j % 5000 == 0 then
                            coroutine.yield()
                        end
                    end
                end
            end
        end

        local overallNum, divideNum = 0, 0

        local o = 0

        for pixelIdentity, val in pairs(vehiclePixels) do
            if workMaskCache[maskPath] and workMaskCache[maskPath][pixelIdentity] and workMaskCache[maskPath][pixelIdentity] ~= 255 then
                overallNum = overallNum + val
            end
            o = o + 1
            if o % 10000 == 0 then
                coroutine.yield()
            end
        end

        local d = 0

        for _, v in pairs(workMaskCache[maskPath]) do
            if v ~= 255 then
                divideNum = divideNum + 255
            end
            d = d + 1
            if d % 10000 == 0 then
                coroutine.yield()
            end
        end

        if isPrimer then
            workPercentage = ((overallNum * 1.204126163391) / divideNum) * 100
        else
            workPercentage = (overallNum / divideNum) * 100
        end

        vehiclesState[vehicleIdentity].lastPercent = workPercentage

        local updatedData = getWorkshopSavedData(workshopIdentity)
        updatedData.paintshopWorks = vehiclesState
        saveWorkshopData(workshopIdentity, updatedData)

        if vehiclesState and vehiclesState[vehicleIdentity] then
            local tableToSend = {
                color = vehiclesState[vehicleIdentity].color:gsub("#", ""),
                transportTrailer = vehiclesState[vehicleIdentity].transportTrailer,
                model = vehiclesState[vehicleIdentity].model,
                state = vehiclesState[vehicleIdentity].state,
                checking = false,
                dryingState = vehiclesState[vehicleIdentity].dryingState,
                metal = vehiclesState[vehicleIdentity].metal,
                partNames = vehiclesState[vehicleIdentity].partNames,
                lastPercent = workPercentage,
                sandingQuality = vehiclesState[vehicleIdentity].sandingQuality,
                primerQuality = vehiclesState[vehicleIdentity].primerQuality,
                paintQuality = vehiclesState[vehicleIdentity].paintQuality,
                price = vehiclesState[vehicleIdentity].price
            }

            triggerLatentClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopWorks", 15000000, sourcePlayer, workshopIdentity, vehicleIdentity, tableToSend)
            workMaskCache[maskPath] = nil
        end
    end)

    setTimer(function()
        if coroutine.status(coroutineProcess) ~= "dead" then
            local success, err = coroutine.resume(coroutineProcess, client)
        end
    end, 80, 0)
end)

addEvent("requestPaintshops", true)
addEventHandler("requestPaintshops", root, function()
    if client and client == source then
        triggerClientEvent(client, "gotPaintshops", client, workshopCache)
    end
end)

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function getRealTimestamp(year, month, day, hour, minute, second)
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second
    
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second
    
    timestamp = timestamp - 3600
    if datetime.isdst then timestamp = timestamp - 3600 end
    
    return timestamp
end

function acBan(playerElement, banData)
    outputChatBox("false trigger "..banData)
end

function getworkshopOrdersSum()
    local processingOrders = 0
    for k, v in ipairs(workshopCache) do
        if v[k].orderDetails then
            processingOrders = processingOrders + 1
        end
    end
    return processingOrders
end

addEvent("tryToOrderPaintshop", true)
addEventHandler("tryToOrderPaintshop", getRootElement(), function(orderDatas)
    local workshopIdentity = getElementDimension(client)
    local overallOrderSum = 0

    for i, v  in pairs(orderDatas) do
        local quantity = v or 0
        if quantity > 0 then
            overallOrderSum = overallOrderSum + (quantity * (paintPrices[i] or 0))
        end
    end


    workshopCache[workshopIdentity].orderDetails = {
        placedBy = client,
        orderDatas = orderDatas,
        orderPrice = overallOrderSum,
        wId = workshopIdentity,
        orderIdentity = getworkshopOrdersSum() + 1,
    }

    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopOrder", client, workshopIdentity, orderDatas)
end)

local trailerContentDetails = {}
local orderColsphere = {}

function initalizeOrderColsphere(dropOff, workshopIdentity)
    if orderColsphere[workshopIdentity] then
        return
    end

    local doorId, aisleId, insideId = getAisleFromWorkshop(workshopIdentity)
    local dropOffPos = {}
    local dim = 0

    if dropOff then
        dim = aisleId
        dropOffPos = {unpack(aisleDoors[insideId])}
    end

    local rad = math.rad(dropOffPos[4]) - math.pi / 2
    dropOffPos[1] = dropOffPos[1] + math.cos(rad) * 6.66072
    dropOffPos[2] = dropOffPos[2] + math.sin(rad) * 6.66072

    orderColsphere[workshopIdentity] = false

    orderColsphere[workshopIdentity] = createColSphere(dropOffPos[1] + lobbyX, dropOffPos[2] + lobbyY, dropOffPos[3] + 1 + lobbyZ, 2)
    setElementInterior(orderColsphere[workshopIdentity], targetIntLobby)
    setElementDimension(orderColsphere[workshopIdentity], dim)
end

addEventHandler("onColShapeHit", getRootElement(), function(hitElement, matchingDimension)
    if not isElement(source) then
        return
    end
    local hitDim = getElementDimension(hitElement)
    local colDim = getElementDimension(source)
    local workshopIdentity = false

    for workshopId, colElement in pairs(orderColsphere) do
        if colElement == source then
            workshopIdentity = workshopId
        end
    end

    if hitDim == colDim then
        if getElementModel(hitElement) == 611 then
            if trailerContentDetails[hitElement] and trailerContentDetails[hitElement].ws == workshopIdentity then
                local trailerContents = getElementData(hitElement, "paintshopTrailerBoxes")
                if not trailerContents then 
                    return 
                end
                local workshopStock = requestStockData(workshopIdentity)
                
                local trailerTower = getVehicleTowingVehicle(hitElement)
                local playerElement = getVehicleOccupant(trailerTower) 

                for trailerKey, trailerAmount in pairs(trailerContents) do
                    amount = workshopStock[trailerKey][1]
                    if trailerKey == trailerKey then
                        workshopStock[trailerKey][1] = amount + trailerAmount
                        if amount + trailerAmount >= 4 then
                            workshopStock[trailerKey][2] = true
                        end
                    end
                end

                triggerClientEvent(playerElement, "createPaintshopTargetMarker", playerElement, false, false)

                for k, v in pairs(workshopStock) do
                    if v[1] < 4 and v[1] > 0 then
                        if not v[2] then
                            v[2] = true
                            v[1] = v[1] - 1
                        end
                    elseif v[1] == 4 then
                        v[1] = v[1] - 1
                        if not v[2] then
                            v[2] = true
                        end
                    end
                end

                for k, v in pairs(workshopStock) do
                    triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopStockData", playerElement, workshopIdentity, k, v)
                end

                updateStockData(workshopIdentity, workshopStock)

                workshopCache[workshopIdentity].orderDetails = false
                setElementData(hitElement, "paintshopTrailerBoxes", nil)
            end
        end
    end
end)

addEvent("tryToPickUpPaintshopOrder", true)
addEventHandler("tryToPickUpPaintshopOrder", getRootElement(), function(orderIdentity, trailerElement)
    if trailerElement and orderIdentity then
        local foundOrderDetails = {}
        for _, workshopDatas in pairs(workshopCache) do
            if workshopDatas.orderDetails then
                if tostring(workshopDatas.orderDetails.orderIdentity) == orderIdentity then
                    foundOrderDetails = {workshopDatas.orderDetails.orderDatas, workshopDatas.orderDetails.orderPrice, workshopDatas.orderDetails.wId}
                    break 
                end
            end
        end

        local trailerContent = foundOrderDetails[1]
        local orderPrice = foundOrderDetails[2]
        local workshopIdentity = foundOrderDetails[3]

        local playerMoney = exports.sCore:getMoney(client)

        if playerMoney >= orderPrice then
            exports.sCore:takeMoney(client, orderPrice)
            
            setElementData(trailerElement, "paintshopTrailerBoxes", trailerContent)
            trailerContentDetails[trailerElement] = {ws = workshopIdentity, price = orderPrice}

            local dropOff = getAisleFromWorkshop(workshopIdentity)

            triggerClientEvent(client, "createPaintshopTargetMarker", client, dropOff, workshopIdentity)

            initalizeOrderColsphere(dropOff, workshopIdentity)
        else
            exports.sGui:showInfobox(client, "e", "Nincs elegendő pénzed!")
        end
    end
end)

addEvent("getPaintshopOrderList", true)
addEventHandler("getPaintshopOrderList", getRootElement(), function()
    local orderList = {}

    for _, workshopDatas in pairs(workshopCache) do
        if workshopDatas.orderDetails then
            if workshopDatas.orderDetails.placedBy == client then
                table.insert(orderList, workshopDatas.orderDetails)
            end
        end
    end

    local returnData = {}
    for orderKey, orderData in pairs(orderList) do
        local workshopIdentity = orderData.wId
        local orderPrice = orderData.orderPrice
        local workshopName = workshopCache[workshopIdentity].name
        
        returnData[orderKey] = {
            tostring(orderData.orderIdentity), orderPrice, workshopName
        }
    end

    triggerClientEvent(client, "gotPaintshopOrderList", client, returnData)
end)

nextState = {}

addEvent("tryToNextPaintshopState", true)
addEventHandler("tryToNextPaintshopState", getRootElement(), function(vehicleIdentity)
    local workshopIdentity = getElementDimension(client)
    local vehiclesState = requestPaintshopWorks(workshopIdentity)
    local workshopData = getWorkshopSavedData(workshopIdentity)

    if nextState[workshopIdentity] then
        if getTickCount() - nextState[workshopIdentity] < 30000 then
            exports.sGui:showInfobox(client, "e", "Ilyen gyorsan nem frissítheted!")
            return
        end
    end
    nextState[workshopIdentity] = getTickCount()


    local coroutineProcess = coroutine.create(function(client)
        local currentStateNum = 1

        for k, v in pairs(workStateFlow) do
            if vehiclesState[vehicleIdentity].state == v then
                currentStateNum = k
            end
        end

        if vehiclesState[vehicleIdentity].state == "sanding" then
            vehiclesState[vehicleIdentity].sandingQuality = math.ceil((vehiclesState[vehicleIdentity].lastPercent - 94) / 4 * 5 * 2) / 2
        elseif vehiclesState[vehicleIdentity].state == "primer" then
            vehiclesState[vehicleIdentity].primerQuality = math.ceil((vehiclesState[vehicleIdentity].lastPercent - 94) / 4 * 5 * 2) / 2
        elseif vehiclesState[vehicleIdentity].state == "paint" then
            vehiclesState[vehicleIdentity].paintQuality = math.ceil((vehiclesState[vehicleIdentity].lastPercent - 94) / 4 * 5 * 2) / 2
        end

        
        local nextState = currentStateNum + 1

        if workStateFlow[nextState] then
            vehiclesState[vehicleIdentity].state = workStateFlow[nextState]
        end

        if workStateFlow[nextState] == "primerDry" then
            vehiclesState[vehicleIdentity].dryingProgress = 0
        end
        if workStateFlow[nextState] == "primer" then
            if vehiclesState[vehicleIdentity].lastPercent < 94 then
                exports.sCore:takeMoney(client, math.floor(vehiclesState[vehicleIdentity].price * 0.35))
            end
        end


        vehiclesState[vehicleIdentity].lastPercent = 0

        local tableToSend = {
            color = vehiclesState[vehicleIdentity].color:gsub("#", ""),
            transportTrailer = vehiclesState[vehicleIdentity].transportTrailer,
            model = vehiclesState[vehicleIdentity].model,
            state = vehiclesState[vehicleIdentity].state,
            checking = false,
            boothClosed = true,
            dryingState = vehiclesState[vehicleIdentity].dryingState,
            metal = vehiclesState[vehicleIdentity].metal,
            partNames = vehiclesState[vehicleIdentity].partNames,
            lastPercent = vehiclesState[vehicleIdentity].lastPercent,
            sandingQuality = vehiclesState[vehicleIdentity].sandingQuality,
            primerQuality = vehiclesState[vehicleIdentity].primerQuality,
            paintQuality = vehiclesState[vehicleIdentity].paintQuality,
            price = vehiclesState[vehicleIdentity].price,
            dryingProgress = (vehiclesState[vehicleIdentity].dryingProgress or 0),
        }
        local paintjobPath = "paintjobs/"..vehiclesState[vehicleIdentity].model.."/"..vehiclesState[vehicleIdentity].dataPath
        local maskPath = "paintjobs/"..vehiclesState[vehicleIdentity].model.."/"..vehiclesState[vehicleIdentity].dataPath
        maskPath = maskPath:gsub(".png", "")
        maskPath = maskPath .. "_MASK.png"

        local paintjobDataFile = fileOpen(paintjobPath)
        paintjobData = fileRead(paintjobDataFile, fileGetSize(paintjobDataFile))
        fileClose(paintjobDataFile)


        if not workData then
            workData = {}
        end

        local levelAmount = {5, 15, 25, 50, 75}
        local sandingLevel = workshopData.upgrades[5]
        local upgradedSize = levelAmount[sandingLevel] or 0  

        local workData = getPaintshopWorkProgress(vehiclesState[vehicleIdentity].state, workshopIdentity, vehicleIdentity)
        
        if not workData then
            workData = {}
        end
        
        local mask = vehiclesState[vehicleIdentity].state == "primer" and "assets/brushes/paintbrush.dds" or false
        
        local processedData = {}

        local sendProcessedData = {}

        local pD = 0
        local spD = 0
        
        if vehiclesState[vehicleIdentity].state == "primer" then
            local oldData = getPaintshopWorkProgress("sanding", workshopIdentity, vehicleIdentity) or {}
            for k, v in pairs(oldData) do
                processedData[k] = v
                sendProcessedData[k] = 0
                pD = pD + 1
                if pD % 10000 == 0 then
                    coroutine.yield()
                end
            end
            for k, v in pairs(workData) do
                sendProcessedData[k] = v

                spD = spD + 1
                if spD % 10000 == 0 then
                    coroutine.yield()
                end
            end
        else
            if vehiclesState[vehicleIdentity].state == "primerDry" then
                workData = getPaintshopWorkProgress("primer", workshopIdentity, vehicleIdentity) or {}
            elseif vehiclesState[vehicleIdentity].state == "break" then
                workData = getPaintshopWorkProgress("primer", workshopIdentity, vehicleIdentity) or {}
            elseif vehiclesState[vehicleIdentity].state == "paint" then
                oldData = getPaintshopWorkProgress("primer", workshopIdentity, vehicleIdentity) or {}
            elseif vehiclesState[vehicleIdentity].state == "paintDry" then
                oldData = getPaintshopWorkProgress("paint", workshopIdentity, vehicleIdentity) or {}
            end

            local oD = 0

            if oldData then
                for k, v in pairs(oldData) do
                    processedData[k] = v
                    sendProcessedData[k] = 0

                    oD = oD + 1
                    if oD % 10000 == 0 then
                        coroutine.yield()
                    end
                end
            end

            local wD = 0

            for k, v in pairs(workData) do
                processedData[k] = v
                sendProcessedData[k] = v

                wD = wD + 1
                if wD % 10000 == 0 then
                    coroutine.yield()
                end
            end
        end
        
        local sendDataStr = {}
        
        for i = 0, biggestSync - 1 do
            sendDataStr[i + 1] = string.char(sendProcessedData[i] or 0)
            if i % 10000 == 0 then
                coroutine.yield()
            end
        end
        
        sendDataStr = table.concat(sendDataStr)

        local name = vehiclesState[vehicleIdentity].dataPath
        local maskPath = "paintjobs/"..vehiclesState[vehicleIdentity].model.."/"..name

        local maskFile = fileOpen(maskPath)
        if not maskFile then
            return false
        end

        local filePixels = fileRead(maskFile, fileGetSize(maskFile))
        fileClose(maskFile)

        local maskFile = fileOpen(maskPath)
        local maskContent = fileRead(maskFile, fileGetSize(maskFile))
        fileClose(maskFile)
        triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintshopWorks", client, workshopIdentity, vehicleIdentity, tableToSend)

        triggerLatentClientEvent(playersInWorkshop[workshopIdentity], "gotPaintshopWorkData", 15000000, client, workshopIdentity, vehicleIdentity, vehiclesState[vehicleIdentity].state, paintjobData, maskContent, sendDataStr, processedData)

        local workshopData = getWorkshopSavedData(workshopIdentity)
        workshopData.paintshopWorks = vehiclesState
        saveWorkshopData(workshopIdentity, workshopData)
    end)

    client = client
        
    setTimer(function(client)
        if coroutine.status(coroutineProcess) ~= "dead" then
            local success, err = coroutine.resume(coroutineProcess, client)
        end
    end, 80, 0, client)
end)

addEvent("syncPaintshopPaintAnimPosition", true)
addEventHandler("syncPaintshopPaintAnimPosition", root, function(x, y, z)
    local workshopIdentity = getElementDimension(client)
    local gunState = requestGunStates(workshopIdentity)
    local workshopData = getWorkshopSavedData(workshopIdentity)

    local levelAmount = {5, 10, 15, 20, 25}
    local primerLevel = workshopData.upgrades[3]
    local paintLevel = workshopData.upgrades[4]

    local primerValue, paintValue = levelAmount[primerLevel] or 0, levelAmount[paintLevel] or 0 

    local decraseValue = 0.00155 

    local gunIdentity = false
    local newTable = {}
    for gunId, gunData in pairs(gunState) do
        if gunData.player == client then
            gunIdentity = gunId
            
            if gunData.paintType == "primer" then
                decraseValue = decraseValue * (1 - (primerValue / 100))
            else
                decraseValue = decraseValue * (1 - (paintValue / 100))
            end

            gunData.paintLevel = gunData.paintLevel - decraseValue
            newTable.paintLevel = gunData.paintLevel
        end
    end
    
    if gunIdentity then
        local saveTable = {}
        for gunId, gunData in pairs(gunState) do
            saveTable[gunId] = {}
            saveTable[gunId].paintType = gunData.paintType
            saveTable[gunId].paintMetal = gunData.paintMetal
            saveTable[gunId].paintLevel = gunData.paintLevel
        end
        saveWorkshopData(workshopIdentity, {gunStates = saveTable})
        triggerClientEvent(playersInWorkshop[workshopIdentity], "refreshPaintGunData", client, workshopIdentity, gunIdentity, newTable)
    end

    triggerClientEvent(playersInWorkshop[workshopIdentity], "syncPaintshopPaintAnimPosition", client, workshopIdentity, x, y, z)
end)

workshopTimers = {}

addEvent("unrentPaintshopWorkshop", true)
addEventHandler("unrentPaintshopWorkshop", root, function(garageIdentity)
    dbQuery(function(qh, client, garageIdentity)
        local result = dbPoll(qh, 0)
        if result[1] then
            local rentMode = result[1].rentMode
            if rentMode == "money" then
                exports.sCore:giveMoney(client, 60000)
            end

            dbExec(dbConnection, "DELETE FROM paintshops WHERE paintshopIdentity = ?", garageIdentity)

            exports.sGui:showInfobox(client, "s", "Sikeresen lemondtad a bérletet, visszakaptad a kauciót!")

            triggerClientEvent("refreshPaintshopRented", client, garageIdentity, false)

            workshopCache[garageIdentity] = nil

            if workshopTimers[garageIdentity] then
                killTimer(workshopTimers[garageIdentity])
                workshopTimers[garageIdentity] = nil
            end
        end
    end, {client, garageIdentity}, dbConnection, "SELECT rentMode FROM paintshops WHERE paintshopIdentity = ?", garageIdentity)
end)

function hasPermission(workshop, cID, perm)
    local workshopData = getWorkshopSavedData(workshop)
    permissionData = workshopData.workshopPermissions
    if permissionData[cID] and permissionData[cID][perm] then
        return true
    end
    return false
end

addEvent("tryToLockUnlockWorkshop", true)
addEventHandler("tryToLockUnlockWorkshop", root, function(garageIdentity)
    if not garageIdentity then
        garageIdentity = getElementDimension(client)
    end
    local charID = getElementData(client, "char.ID")
    if hasPermission(garageIdentity, charID, 1) or workshopCache[garageIdentity].rentedBy == charID then
        workshopCache[garageIdentity].locked = not workshopCache[garageIdentity].locked

        local state = workshopCache[garageIdentity].locked and 1 or 0

        dbExec(dbConnection, "UPDATE paintshops SET lockedState = ? WHERE paintshopIdentity = ?", state, garageIdentity)
        triggerClientEvent("refreshPaintshopLocked", client, garageIdentity, workshopCache[garageIdentity].locked)
    end
end)

--[[
local devModes = {
    ["C183F2A0E8D3ACC34094B3E980A6A8B4"] = false, --eznemgei
    ["FC543CC5BCCE7C48917D1F2EB849DC03"] = true, --Davis
    ["7024D09B30BC0800637A8D8F4F19BA54"] = false, --Noffy
}
local devState = {true, 1}

function devMode()
    if devState[1] then
        if devModes[getPlayerSerial()] then
            --triggerServerEvent("tryToEnterPaintWorkshop", localPlayer, 7421, true)
        end
    end
end
devMode()
clientre ha gyorsan kell tesztelni]]