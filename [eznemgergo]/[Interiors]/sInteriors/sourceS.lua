local connection = false

local deletedInteriors = {}

local rentTimeDuration = 60 * 60 * 24 * 7

local intiReportPed = createPed(148, 1498.1278076172, -1800.2779541016, 24.02342414856)
setElementData(intiReportPed, "invulnerable", true)
setElementData(intiReportPed, "visibleName", "Ingatlanos Dezsőné")
setElementData(intiReportPed, "pedNameType", "Ingatlan bejelentés")
setElementFrozen(intiReportPed, true)

addEventHandler("onElementClicked", intiReportPed, function(theButton, theState, thePlayer)
        if theButton == "left" and theState == "down" and thePlayer then
            local interiors = getPlayersInterior(thePlayer)

            local intiCount = 0

            for k, v in pairs(interiors) do
                intiCount = intiCount + 1
                interiorList[k].reportTime = getRealTime().timestamp + 2629743
                dbExec(connection, "UPDATE interiors SET reportTime = ? WHERE interiorId = ?", interiorList[k].reportTime, k)
            end
            if intiCount > 0 then
                exports.sGui:showInfobox(thePlayer, "s", "Sikeresen bejelentetted ".. intiCount .. " db interiorodat!")
            end
        end
    end
)

function intiReportTimer()
    for k, v in pairs(interiorList) do
        if v.reportTime ~= 0 and v.reportTime < getRealTime().timestamp and v.ownerType == "player" then
            deletedInteriors[k] = deepcopy(interiorList[k])
            interiorList[k] = nil
            dbExec(connection, "UPDATE interiors SET deleted = 'Y' WHERE interiorId = ?", k)
            
            triggerLatentClientEvent(getRootElement(), "gotInteriorList", 100000, getRootElement(), interiorList)
        end
    end
end
setTimer(intiReportTimer, (1000 * 60) * 60, 0)

addEventHandler("onResourceStart", getRootElement(), function(res)
    local resName = getResourceName(res)

    if res == getThisResource() then
        connection = exports.sConnection:getConnection()

		if connection then
			dbQuery(loadAllInterior, connection, "SELECT * FROM interiors")
		end
    elseif resName == "sConnection" then
        connection = exports.sConnection:getConnection()
    end
end)

addEvent("requestInteriors", true)
addEventHandler("requestInteriors", getRootElement(), function()
    triggerClientEvent(client, "gotInteriorList", client, interiorList)
end)

addEvent("doorRam", true)
addEventHandler("doorRam", getRootElement(), function(interiorId, itemDbID)
    if interiorList[interiorId] and interiorList[interiorId].locked then
        interiorList[interiorId].locked = false
        triggerClientEvent(getRootElement(), "syncInteriorData", client, interiorId, {locked = interiorList[interiorId].locked})
        triggerClientEvent(getRootElement(), "playInteriorLockUnlock", client, interiorId)

        exports.sChat:localAction(client, "betörte egy ingatlan ajtaját.")

        local item = exports.sItems:hasItemEx(client, "dbID", itemDbID)
        if (item.data1 or 0) + 1 < 10 then
            exports.sItems:updateItemData1(client, itemDbID, (item.data1 or 0) + 1)
        else
            exports.sItems:takeItem(client, "dbID", itemDbID)
        end
        triggerClientEvent("playInteriorRam", client, interiorId)
    end
end)

addEvent("lockPoliceInterior", true)
addEventHandler("lockPoliceInterior", root, 
    function(markerType, interiorId, lockReason)
        interiorId = tonumber(interiorId)

        if interiorList[interiorId] then
            local selectedGroup = false
            local playerGroups = exports.sGroups:getPlayerGroups(client)

            for k, v in pairs(playerGroups) do
                if k then
                    if exports.sGroups:isLawEnforcementGroup(k) then
                        selectedGroup = k
                        break
                    end
                end
            end

            interiorList[interiorId].policeLock = lockReason
            interiorList[interiorId].policeLockGroup = selectedGroup
            interiorList[interiorId].policeLockBy = getElementData(client, "visibleName"):gsub("_", " ")

            exports.sConnection:dbUpdate("interiors", {
                ["policeLock"] = interiorList[interiorId].policeLock,
                ["policeLockGroup"] = interiorList[interiorId].policeLockGroup,
                ["policeLockBy"] = interiorList[interiorId].policeLockBy
            }, {interiorId = interiorId})

            triggerLatentClientEvent(getRootElement(), "syncInteriorData", 100000, client, interiorId, {
                policeLock = interiorList[interiorId].policeLock,
                policeLockGroup = interiorList[interiorId].policeLockGroup,
                policeLockBy = interiorList[interiorId].policeLockBy
            })
        end
    end
)

addEvent("unlockPoliceInterior", true)
addEventHandler("unlockPoliceInterior", root, 
    function(markerType, interiorId)
        interiorId = tonumber(interiorId)

        if interiorList[interiorId] then
            local selectedGroup = false
            
            interiorList[interiorId].policeLock = "N"
            interiorList[interiorId].policeLockGroup = "None"
            interiorList[interiorId].policeLockBy = "None"

            exports.sConnection:dbUpdate("interiors", {
                ["policeLock"] = interiorList[interiorId].policeLock,
                ["policeLockGroup"] = interiorList[interiorId].policeLockGroup,
                ["policeLockBy"] = interiorList[interiorId].policeLockBy
            }, {interiorId = interiorId})

            triggerLatentClientEvent(getRootElement(), "syncInteriorData", 100000, client, interiorId, {
                policeLock = false,
                policeLockGroup = false,
                policeLockBy = false
            })
        end
    end
)

addCommandHandler("createinterior", function(thePlayer, commandName, gameInterior, interiorType, buyPrice, ...)
    if exports.sPermission:hasPermission(thePlayer, "createinterior") then
        gameInterior = tonumber(gameInterior)
        interiorType = tonumber(interiorType)
        buyPrice = tonumber(buyPrice)

        if not gameInterior or not interiorType or not buyPrice or not (...) then
            outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Belső Azonosító (0: DUMMY)] [Típus] [Ár] [Név]", thePlayer, 255, 255, 255, true)
            outputChatBox("[color=sightblue][SightMTA - Típusok]:[color=hudwhite] Ház (1), Biznisz (2), Egyedi Garázs (3), Garázs (4), Bérelhető (5), Lift (6), Lépcső (7), Ajtó (8), Középület (9)", thePlayer,  255, 255, 255, true)
        else
            gameInterior = tonumber(gameInterior)
            interiorType = tonumber(interiorType)
            buyPrice = tonumber(buyPrice)

            buyPrice = math.floor(buyPrice)

            if gameInteriors[gameInterior] or gameInterior == 0 then
                if interiorType >= 1 and interiorType <= 9 then
                    if interiorType == 1 then
                        interiorType = "house"
                    elseif interiorType == 2 then
                        interiorType = "business"
                    elseif interiorType == 3 then
                        interiorType = "garage"
                    elseif interiorType == 4 then
                        interiorType = "garage2"
                    elseif interiorType == 5 then
                        interiorType = "rentable"
                    elseif interiorType == 6 then
                        interiorType = "lift"
                    elseif interiorType == 7 then
                        interiorType = "stairs"
                    elseif interiorType == 8 then
                        interiorType = "door"
                    else
                        interiorType = "building"
                    end

                    if buyPrice >= 0 and buyPrice <= 100000000 then
                        local name = table.concat({...}, " ")

                        if utf8.len(name) == 0 and gameInterior ~= 0 then
                            name = gameInteriors[gameInterior]["name"]
                        end

                        if utf8.len(name) > 0 then
                            dbQuery(function(qh, interiorType)
                                local result, rows = dbPoll(qh, -1)
                                local nextInsertId = 1

                                if result[1] and result[1]["LAST_INSERT_ID()"] then
                                    nextInsertId = result[1]["LAST_INSERT_ID()"] + 1
                                end

                                local _, _, rot = getElementRotation(thePlayer)
                                local int, dim = getElementInterior(thePlayer), getElementDimension(thePlayer)
                                local posX, posY, posZ = getElementPosition(thePlayer)

                                local interiorDatas = {
                                    ["name"] = name,
                                    ["type"] = interiorType,
                                    ["dummy"] = "Y",
                                    ["price"] = buyPrice,
                                    ["owner"] = 0,
                                    ["gameInterior"] = gameInterior,
                                    ["outside"] = toJSON({posX, posY, posZ, int, dim, rot}),
                                    ["zone"] = exports.sRadar:getZoneName(posX, posY, posZ),
                                    ["policeLock"] = "N",
                                    ["policeLockBy"] = "None",
                                    ["policeLockGroup"] = "None",
                                }

                                if gameInteriors[gameInterior] then
                                    interiorDatas["dummy"] = "N"
                                    interiorDatas["inside"] = gameInterior
                                else
                                    interiorDatas["inside"] = toJSON({0, 0, 0, 0, nextInsertId, 0})
                                end

                                local columnNames = {}
                                local valueMarks = {}
                                local parameters = {}

                                for k, v in pairs(interiorDatas) do
                                    table.insert(columnNames, k)
                                    table.insert(valueMarks, "?")
                                    table.insert(parameters, v)
                                end

                                dbExec(connection, "INSERT INTO interiors (" .. table.concat(columnNames, ",") .. ") VALUES (" .. table.concat(valueMarks, ",") .. ")", unpack(parameters))
                                dbQuery(createInteriorCallback, {thePlayer}, connection, "SELECT * FROM interiors WHERE interiorId = LAST_INSERT_ID()")
                            end, {interiorType}, connection, "SELECT LAST_INSERT_ID() FROM interiors AS id")
                        end
                    else
                        outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Az ár nem lehet kisebb mint [color=sightblue]0 [color=hudwhite]és nem lehet nagyobb mint [color=sightblue]10 000 000 000[color=hudwhite].", 255, 255, 255, true)
                    end
                else
                    outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Érvénytelen interior típus.", 255, 255, 255, true)
                end
            else
                outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Érvénytelen interior azonosító.", 255, 255, 255, true)
            end
        end
    end
end)

function createInteriorCallback(queryHandle, sourcePlayer)
	local resultRows, numAffectedRows, lastInsertId = dbPoll(queryHandle, 0)

	if resultRows then
		local resultRow = resultRows[1]

		if resultRow then
			loadInterior(resultRow.interiorId, resultRow, true)

			if isElement(sourcePlayer) then
				outputChatBox("[color=sightgreen][SightMTA - Interior]:[color=hudwhite] Sikeresen létrehoztál egy interiort. [color=sightblue](" .. resultRow.interiorId .. ")", sourcePlayer, 255, 255, 255, true)

                if resultRow.type == "garage" then
                    triggerEvent("fetchNewGarage", getRootElement(), resultRow.interiorId)
                end
            end
		end
	end
end

function loadInterior(interiorId, interiorData, syncTheInterior)
	if interiorId and interiorData then
		if interiorData.deleted == "Y" and not deletedInteriors[interiorId] then
			deletedInteriors[interiorId] = interiorData
			interiorList[interiorId] = nil
		else
			if not interiorList[interiorId] then
				interiorList[interiorId] = {}
			end

			local interiorOwner = interiorData.owner
            local interiorType = interiorData.type
            local price = interiorData.price

            interiorOwner = tonumber(interiorOwner) or interiorOwner
            ownerType = interiorData.ownerType or "player"

            if interiorOwner == 0 and ownableInteriorTypes[interiorType] then
                interiorOwner = false
            end

            if not ownableInteriorTypes[interiorType] then
                price = false
            end

			local inside = false

            if tonumber(interiorData.inside) then
                inside = tonumber(interiorData.inside)
            else
                if type(interiorData.inside) == "table" then
                    inside = interiorData.inside
                else
                    inside = (interiorData.inside and fromJSON(interiorData.inside)) or interiorData.inside
                end
            end

			local outside = false

            if type(interiorData.outside) == "table" then
                outside = interiorData.outside
            else
                outside = (interiorData.outside and fromJSON(interiorData.outside)) or interiorData.outside
            end

            if interiorData.reportTime == 0 then
                interiorData.reportTime = getRealTime().timestamp + 2629743
            end

            local reportTime = interiorData.reportTime
            if interiorData.policeLock ~= "N" then
                interiorList[interiorId] = {
                    outside = outside,
                    inside = inside,
                    name = interiorData.name,
                    zone = interiorData.zone,
                    type = interiorData.type,
                    ownerType = ownerType,
                    owner = interiorOwner,
                    editable = interiorData.editable,
                    locked = interiorData.locked == 1,
                    price = price,
                    reportTime = reportTime,
                    rentTime = interiorData.renewalTime,
                    policeLock = interiorData.policeLock,
                    policeLockBy = interiorData.policeLockBy,
                    policeLockGroup = interiorData.policeLockGroup,
                }
            else
                interiorList[interiorId] = {
                    outside = outside,
                    inside = inside,
                    name = interiorData.name,
                    zone = interiorData.zone,
                    type = interiorData.type,
                    ownerType = ownerType,
                    owner = interiorOwner,
                    editable = interiorData.editable,
                    locked = interiorData.locked == 1,
                    price = price,
                    reportTime = reportTime,
                    rentTime = interiorData.renewalTime
                }

            end
		end

		if syncTheInterior then
			triggerLatentClientEvent(getRootElement() or resourceRoot, "gotInteriorList", 100000, getRootElement() or resourceRoot, interiorList or {})
		end
        
        if deletedInteriors[interiorId] then
            deletedInteriors[interiorId] = nil
        end

		return true
	end

	return false
end

disabledInteriors = {
    [1] = true
}

function getRandomUsableInterior()
    local usableInteriors = {}
    for k, v in pairs(interiorList) do
        if v.ownerType == "player" and (v.type == "house" or v.type == "garage") and not disabledInteriors[k] then
            local x, y, z, int, dim = unpack(v.outside)
            if int == 0 and dim == 0 then
                table.insert(usableInteriors, k)
            end
        end
    end
    return usableInteriors[math.random(1, #usableInteriors)]
end

function loadAllInterior(queryHandle)
	local resultRows, numAffectedRows, lastInsertId = dbPoll(queryHandle, 0)

	if resultRows then
		for i, v in ipairs(resultRows) do
			loadInterior(v.interiorId, v)
		end
	end
end

addEvent("tryToBuyInterior", true)
addEventHandler("tryToBuyInterior", getRootElement(), function(interiorType, interiorId)
    if client ~= source then
        exports.sAnticheat:anticheatBan(client, "sInteriors >> tryToBuyInterior -> @sourceS.lua/237")
        return
    end

    local characterIdentity = getElementData(client, "char.ID")
    if characterIdentity then
        local interiorData = interiorList[interiorId]
        if interiorData then
            local succesMessage = "Sikeresen megvásároltad a kiválasztott ingatlant! (Azonosító - "..interiorId..")"
            if interiorData.owner == characterIdentity and interiorData.type == "rentable" then
                if exports.sCore:takeMoney(client, interiorData.price) then
                    newRenevalTime = getRealTime(interiorData.rentTime).timestamp + rentTimeDuration
                    succesMessage = "Sikeresen meghosszabítottad az ingatlan bérleti idejét!"

                    interiorData.rentTime = newRenevalTime

                    triggerClientEvent("syncInteriorData", client, interiorId, interiorList[interiorId])

                    dbExec(connection, "UPDATE interiors SET rentTime = ? WHERE interiorId = ?", interiorData.rentTime, interiorId)
                    exports.sGui:showInfobox(client, "s", succesMessage)
                    
                    return
                end
            end

            if exports.sItems:hasSpaceForItem(client, 2) then
                local buyPrice = interiorData.price
                local renewalTime = 0

                if interiorData.type == "rentable" then
                    buyPrice = buyPrice * 5
                    succesMessage = "Sikeresen kibérelted a kiválasztott ingatlant!"
                    renewalTime = getRealTime().timestamp + rentTimeDuration
                end

                if exports.sCore:takeMoney(client, buyPrice) then
                    interiorData.owner = characterIdentity
                    interiorData.rentTime = renewalTime

                    if not exports.sItems:playerHasItemWithData(client, 2, interiorId) then
                        exports.sItems:giveItem(client, 2, 1, false, interiorId)
                    end

                    exports.sDashboard:givePlayerAchievement(client, "house")

                    triggerClientEvent("syncInteriorData", client, interiorId, interiorList[interiorId])

                    dbExec(connection, "UPDATE interiors SET owner = ?, rentTime = ? WHERE interiorId = ?", characterIdentity, interiorData.rentTime, interiorId)

                    exports.sGui:showInfobox(client, "s", succesMessage)
                else
                    exports.sGui:showInfobox(client, "e", "Nincs elegendő pénzed az ingatlan kifizetéséhez!")
                end                        
            else
                exports.sGui:showInfobox(client, "e", "Nem fér el az inventorydban a kulcs!")
            end
        else
            exports.sAnticheat:anticheatBan(client, "sInteriors >> tryToBuyInterior -> @sourceS.lua/247")
        end
    end
end)

addEvent("tryToUnrentInterior", true)
addEventHandler("tryToUnrentInterior", getRootElement(), function(interiorType, interiorId)
    if client ~= source then
        exports.sAnticheat:anticheatBan(client, "sInteriors >> tryToUnrentInterior -> @sourceS.lua/300")
        return
    end

    if client then
        local interiorData = interiorList[interiorId]
        if getElementData(client, "char.ID") == interiorData.owner then

            interiorData.owner = false
            interiorData.rentTime = false
            interiorData.type = "rentable"

            
            dbExec(connection, "UPDATE interiors SET owner = 0, rentTime = 0, locked = 1 WHERE interiorId = ?", interiorId)

            exports.sGui:showInfobox(client, "s", "Sikeresen felmondtad az ingatlan bérlését! (Azonosító "..interiorId..")")

            exports.sCore:giveMoney(client, interiorData.price * 4)

            triggerClientEvent("syncInteriorData", client, interiorId, interiorList[interiorId])
        end
    end
end)

addEvent("teleportPlayerBetweenInterior", true)
addEventHandler("teleportPlayerBetweenInterior", getRootElement(), function(interiorType, interiorId)
    if client ~= source then
        exports.sAnticheat:anticheatBan(client, "sInteriors >> teleportPlayerBetweenInterior -> @sourceS.lua/260")
        return
    end

    local data = interiorList[interiorId]

    if data then
        if data.policeLock and data.policeLock ~= "N" then
            exports.sGui:showInfobox(client, "w", "Az épületet egy rendvédelmi szerv lezárta!")
            return
        end

        if data.locked then
            triggerClientEvent(getRootElement(), "playInteriorLocked", client, interiorId)
        else
            local x, y, z, int, dim, rz

            if interiorType == "outside" then
                local playersTable = getElementsByType("player")

                for i = 1, #playersTable do
                    local playerElement = playersTable[i]

                    if isElement(playerElement) then
                        local editingInterior = getElementData(playerElement, "editingInterior") or 0

                        if editingInterior > 0 and editingInterior == interiorId then
                            outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Az ingatlan szerkesztés alatt áll.", client, 255, 255, 255, true)
                            triggerLatentClientEvent(client, "interiorEnterCancelled", client, interiorId)
                            return
                        end
                    end
                end
                if interiorList[interiorId].editable ~= "N" then
                    setElementData(client, "currentCustomInterior", interiorId)
                    exports.sInterioredit:loadInterior(client, tonumber(interiorId), false, true)
                end
                x, y, z, int, dim, rz = getInteriorInsidePosition(interiorId)
            elseif interiorType == "inside" then
                x, y, z, int, dim, rz = getInteriorOutsidePosition(interiorId)
            end

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
                    table.insert(playersEntered, v)
                end
            else
                setElementPosition(client, x, y, z)
                setElementInterior(client, int)
                setElementDimension(client, dim)
                setElementRotation(client, 0, 0, rz)
                table.insert(playersEntered, client)
            end

            setElementData(client, "currentCustomGarage", false)

            if interiorType == "outside" then
                if data.type == "garage" then
                    triggerEvent("syncGarageDatas", getRootElement(), playersEntered, interiorId)
                    setElementData(client, "currentCustomGarage", interiorId)
                else
                    triggerLatentClientEvent(client, "interiorEnterCancelled", client, interiorId)
                end
            else
                triggerLatentClientEvent(client, "interiorEnterCancelled", client, interiorId)
            end

            triggerClientEvent(getRootElement(), "interiorEntered", getRootElement(), interiorId)
        end
    end
end)

function isElementInRange(ele, x, y, z, range)
    if isElement(ele) and type(x) == "number" and type(y) == "number" and type(z) == "number" and type(range) == "number" then
        return getDistanceBetweenPoints3D(x, y, z, getElementPosition(ele)) <= range
    end
    return false
end

addEvent("ringBellOnInterior", true)
addEventHandler("ringBellOnInterior", getRootElement(), function(interiorId)
    if client ~= source then
        exports.sAnticheat:anticheatBan(client, "sInteriors >> ringBellOnInterior -> @sourceS.lua/332")
        return
    end

    if not interiorList[interiorId] then
        exports.sAnticheat:anticheatBan(client, "sInteriors >> ringBellOnInterior -> @sourceS.lua/337")
        return
    end 
    
    x, y, z, int, dim, rz = getInteriorOutsidePosition(interiorId)
    if not isElementInRange(client, x, y, z, 1) then
        exports.sAnticheat:anticheatBan(client, "sInteriors >> ringBellOnInterior -> @sourceS.lua/342")
        return
    end
    
    if not getElementDimension(client) == dim then
        exports.sAnticheat:anticheatBan(client, "sInteriors >> ringBellOnInterior -> @sourceS.lua/347")
        return
    end

    if not getElementInterior(client) == int then
        exports.sAnticheat:anticheatBan(client, "sInteriors >> ringBellOnInterior -> @sourceS.lua/353")
        return
    end
    
    triggerClientEvent(getRootElement(), "playInteriorRing", client, interiorId)
end)

addEvent("knockOnInterior", true)
addEventHandler("knockOnInterior", getRootElement(), function(interiorId)
    if client ~= source then
        exports.sAnticheat:anticheatBan(client, "sInteriors >> knockOnInterior -> @sourceS.lua/332")
        return
    end

    if not interiorList[interiorId] then
        exports.sAnticheat:anticheatBan(client, "sInteriors >> knockOnInterior -> @sourceS.lua/337")
        return
    end 
    
    x, y, z, int, dim, rz = getInteriorOutsidePosition(interiorId)
    if not isElementInRange(client, x, y, z, 1) then
        exports.sAnticheat:anticheatBan(client, "sInteriors >> knockOnInterior -> @sourceS.lua/342")
        return
    end
    
    if not getElementDimension(client) == dim then
        exports.sAnticheat:anticheatBan(client, "sInteriors >> knockOnInterior -> @sourceS.lua/347")
        return
    end

    if not getElementInterior(client) == int then
        exports.sAnticheat:anticheatBan(client, "sInteriors >> knockOnInterior -> @sourceS.lua/353")
        return
    end
    
    triggerClientEvent(getRootElement(), "playInteriorKnock", client, interiorId)
end)

function isValidInterior(interiorIdentity)
    return interiorList[interiorIdentity] and true or false
end

addEvent("lockUnlockInterior", true)
addEventHandler("lockUnlockInterior", getRootElement(), function(interiorType, interiorId)
    if client == source then
        if interiorList[interiorId] then
            local canLock = true
            
            if exports.sItems:playerHasItemWithData(client, 2, interiorId) then
                canLock = true
            else
                local adminLevel = getElementData(client, "acc.adminLevel")

                if adminLevel > 0 and adminLevel <= 5 and getElementData(client, "adminDuty") then
                    canLock = true
                elseif adminLevel > 5 then
                    canLock = true
                end
            end

            if canLock then
                interiorList[interiorId].locked = not interiorList[interiorId].locked
                triggerClientEvent(getRootElement(), "syncInteriorData", client, interiorId, {locked = interiorList[interiorId].locked})
                triggerClientEvent(getRootElement(), "playInteriorLockUnlock", client, interiorId)

                if interiorList[interiorId].locked then
                    exports.sChat:localAction(client, "bezárt egy interiort.")
                else
                    exports.sChat:localAction(client, "kinyitott egy interiort.")
                end
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "sInteriors >> lockUnlockInterior -> @sourceS.lua/417")
    end
end)

addEvent("setEditableInteriorPosition", true)
addEventHandler("setEditableInteriorPosition", getRootElement(), function(editingInteriorID, x, y, pz, rz)
    if client and client == source then
        setElementPosition(client, x, y, 51)
        setElementRotation(client, 0, 0, pz)
        interiorList[editingInteriorID].inside = {x, y, 51, 1, editingInteriorID}
        triggerClientEvent(client, "syncInteriorData", client, editingInteriorID, interiorList[editingInteriorID])
    end
end)

addCommandHandler("deleteinterior", function(client, commandName, interiorId)
    if exports.sPermission:hasPermission(client, "deleteinterior") then
        interiorId = tonumber(interiorId)

        if interiorId then
            if interiorList[interiorId] then
                deletedInteriors[interiorId] = deepcopy(interiorList[interiorId])
                interiorList[interiorId] = nil
                dbExec(connection, "UPDATE interiors SET deleted = 'Y' WHERE interiorId = ?", interiorId)
                
                triggerLatentClientEvent(getRootElement(), "gotInteriorList", 100000, client, interiorList)

                outputChatBox("[color=sightgreen][SightMTA - Interior]:[color=hudwhite] A kiválasztott interior törölve lett!", client)
            else
                outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Ezzel az azonosítóval nem található interior!", client)
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]:[color=hudwhite] /" .. commandName .. " [Interior ID]", client)
        end
    end
end)

addCommandHandler("resetinterior", function(client, commandName, interiorId)
    if exports.sPermission:hasPermission(client, "resetinterior") then
        interiorId = tonumber(interiorId)

        if interiorId then
            if deletedInteriors[interiorId] then
                loadInterior(interiorId, deletedInteriors[interiorId], true)
                dbExec(connection, "UPDATE interiors SET deleted = 'N' WHERE interiorId = ?", interiorId)

                outputChatBox("[color=sightgreen][SightMTA - Interior]:[color=hudwhite] A kiválasztott interior visszaállítva!", client)
            else
                outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Ezzel az azonosítóval nem található interior!", client)
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Interior ID]", client)
        end
    end
end)

addCommandHandler("setinteriorentrance", function(client, commandName, interiorId)
    if exports.sPermission:hasPermission(client, "setinteriorentrance") then
        interiorId = tonumber(interiorId)

        if interiorId then
            if interiorList[interiorId] then
                local x, y, z = getElementPosition(client)
                local int = getElementInterior(client)
                local dim = getElementDimension(client)
                local _, _, rz = getElementRotation(client)

                interiorList[interiorId].outside = {x, y, z, int, dim, rz}

                dbExec(connection, "UPDATE interiors SET outside = ? WHERE interiorId = ?", toJSON(interiorList[interiorId].outside, true), interiorId)

                triggerLatentClientEvent(getRootElement(), "syncInteriorData", 100000, client, interiorId, {outside = interiorList[interiorId].outside})
                outputChatBox("[color=sightgreen][SightMTA - Interior]:[color=hudwhite] Sikeresen átraktad az interior pozícióját!", client)
            else
                outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Ezzel az azonosítóval interior nem található!", client)
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Interior ID]", client)
        end
    else
        outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Nincs ehhez jogosultságod!")
    end
end)

addCommandHandler("setinteriorexit", function(client, commandName, interiorId)
    if exports.sPermission:hasPermission(client, "setinteriorexit") then
        interiorId = tonumber(interiorId)

        if interiorId then
            if interiorList[interiorId] then
                local x, y, z = getElementPosition(client)
                local int = getElementInterior(client)
                local dim = getElementDimension(client)
                local _, _, rz = getElementRotation(client)

                interiorList[interiorId].inside = {x, y, z, int, dim, rz}

                dbExec(connection, "UPDATE interiors SET inside = ? WHERE interiorId = ?", toJSON(interiorList[interiorId].inside, true), interiorId)

                triggerLatentClientEvent(getRootElement(), "syncInteriorData", 100000, client, interiorId, {inside = interiorList[interiorId].inside})
            else
                outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Ezzel az azonosítóval interior nem található!", client)
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Interior ID]", client)
        end
    end
end)

addCommandHandler("setinteriorname", 
    function(client, commandName, interiorId, ...)
        if exports.sPermission:hasPermission(client, "setinteriorname") then
            interiorId = tonumber(interiorId)

            if interiorId and (...) then
                local name = table.concat({...}, " ")

                interiorList[interiorId].name = name

                exports.sConnection:dbUpdate("interiors", {
                    ["name"] = interiorList[interiorId].name
                }, {interiorId = interiorId})

                triggerLatentClientEvent(getRootElement(), "syncInteriorData", 100000, client, interiorId, {
                    name = interiorList[interiorId].name                
                })
            else
                outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Interior ID] [Név]", client)
            end
        end
    end
)

addCommandHandler("setinteriorgroup", function(client, commandName, interiorId, groupName)
    if exports.sPermission:hasPermission(client, "setinteriorgroup") then
        interiorId = tonumber(interiorId)

        if interiorId and groupName then
            if interiorList[interiorId] then
                local x, y, z = getElementPosition(client)
                local int = getElementInterior(client)
                local dim = getElementDimension(client)
                local _, _, rz = getElementRotation(client)

                local ownerType = "group"

                if tostring(groupName) == "0" then
                    if interiorList[interiorId].ownerType == "group" then
                        groupName = false
                        ownerType = "player"
                    else
                        exports.sGui:showInfobox(client, "e", "A kiválasztott interior nincs frakció néven!")
                        return
                    end
                end

                if not exports.sGroups:isGroupValid(groupName) and groupName then
                    exports.sGui:showInfobox(client, "e", "Nincs ilyen frakció!")
                    return
                end

                interiorList[interiorId].ownerType = ownerType
                interiorList[interiorId].owner = groupName

                if ownerType == "player" then
                    exports.sGui:showInfobox(client, "s", "Sikeresen levetted a frakcióról az interiort!")
                else
                    exports.sGui:showInfobox(client, "s", "Sikeresen frakcióhoz kötötted a kiválasztott interiort!")
                end

                exports.sConnection:dbUpdate("interiors", {
                    ["ownerType"] = interiorList[interiorId].ownerType,
                    ["owner"] = interiorList[interiorId].owner and interiorList[interiorId].owner or 0
                }, {interiorId = interiorId})

                triggerLatentClientEvent(getRootElement(), "syncInteriorData", 100000, client, interiorId, {
                    ownerType = interiorList[interiorId].ownerType,
                    owner = interiorList[interiorId].owner
                })

                exports.sGroups:refreshGroupInteriors(groupName)
            else
                outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Ezzel az azonosítóval interior nem található!", client)
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Interior ID] [Frakció | (0 - Levétel)]", client)
        end
    end
end)



addCommandHandler("setinterioreditable",
	function(thePlayer, commandName, interiorId, x, y)
		if exports.sPermission:hasPermission(thePlayer, commandName) then
			interiorId = tonumber(interiorId)
			x = tonumber(x)
			y = tonumber(y)

			if not (interiorId and x and y) then
				outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Interior ID] [X] [Y]", thePlayer, 255, 255, 255, true)
			else
				if x > 13 or y > 13 or x < 2 or y < 2 then
					outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] A méret 2 és 13 között lehet!", thePlayer, 255, 255, 255, true)
					return
				end

				if interiorList[interiorId] then

					local inside = gameInteriors["e"]["position"]
					inside[5] = interiorId
					inside[4] = 1

					interiorList[interiorId].inside = inside
					interiorList[interiorId].rotation = gameInteriors.e.rotation
					interiorList[interiorId].editable = x .. "x" .. y
                    
                    outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] Sikeresen megváltoztattad a kiválasztott interior [color=sightblue]("..interiorId..") [color=hudwhite]méretét! [color=sightblue]("..x.."x"..y..")", thePlayer)

					triggerClientEvent("syncInteriorData", thePlayer, interiorId, interiorList[interiorId])
                    dbExec(connection, "UPDATE interiors SET editable = ?, inside = ? WHERE interiorId = ?", interiorList[interiorId].editable, toJSON(interiorList[interiorId].inside), interiorId)
					dbExec(connection, "INSERT INTO interior_datas SET interiorId = ? ON DUPLICATE KEY UPDATE interiorId = interiorId", interiorId)
				else
					outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] A kiválasztott interior nem létezik.", thePlayer, 255, 255, 255, true)
				end
			end
		end
	end
)

addCommandHandler("getinterioreditable",
	function(thePlayer, commandName, interiorId)
		if exports.sPermission:hasPermission(thePlayer, "getinterioreditable") then
			interiorId = tonumber(interiorId)
            if interiorList[interiorId] then
                local editable = interiorList[interiorId].editable
                if editable then
                    outputChatBox("[color=sightgreen][SightMTA - Interior]:[color=hudwhite] Az interior mérete: " .. editable, thePlayer, 255, 255, 255, true)
                else
                    outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Az interior nem szerkeszthető!", thePlayer, 255, 255, 255, true)
                end
            else
                outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] A kiválasztott interior nem létezik.", thePlayer, 255, 255, 255, true)
            end
        end
    end
)

function getInteriorSize(interiorId)
    interiorId = tonumber(interiorId)

    if interiorList[interiorId] then
        if interiorList[interiorId].editable == "N" then
            return false
        else
            return interiorList[interiorId].editable
        end
    else
        return false
    end
end

function warpElement(sourceElement, posX, posY, posZ, rotX, rotY, rotZ, interior, dimension)
	if isElement(sourceElement) then
		local elementType = getElementType(sourceElement)

		setElementPosition(sourceElement, posX, posY, posZ)

		if elementType == "vehicle" then
			setElementVelocity(sourceElement, 0, 0, 0)
			setElementAngularVelocity(sourceElement, 0, 0, 0)
			setElementRotation(sourceElement, rotX, rotY, rotZ)
		else
			setElementRotation(sourceElement, rotX, rotY, rotZ, "default", true)
			setCameraInterior(sourceElement, interior)
		end

		setElementInterior(sourceElement, interior)
		setElementDimension(sourceElement, dimension)

		if elementType == "player" then
			setCameraTarget(sourceElement, sourceElement)
		end
	end
end

addEvent("editInterior", true)
addEventHandler("editInterior", getRootElement(),
	function (interiorId)
		if isElement(source) and client and client == source then
			local int = interiorList[interiorId]

			if int and int.owner == getElementData(client, "char.ID") then
				if int.editable ~= "N" then
					local playersTable = getElementsByType("player")

					for i = 1, #playersTable do
						local playerElement = playersTable[i]

						if isElement(playerElement) then
							local customInterior = getElementData(playerElement, "currentCustomInterior") or 0

                            if customInterior > 0 and customInterior == interiorId then
								warpElement(playerElement, int.outside[1], int.outside[2], int.outside[3], 0, 0, 0, int.outside[4], int.outside[5])
								
								exports.sGui:showInfobox(playerElement, "i", "Az interior szerkesztés alatt áll.\nEzért automatikusan kikerültél az ingatlanból.")
							end
						end
					end

					exports.sInterioredit:loadInterior(source, interiorId, true, true)
				end
			end
        else
            exports.sAnticheat:anticheatBan(client, "sInteriors >> editInterior -> @sourceS.lua/618")
		end
	end
)


function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

function getPlayerInteriors()
    return interiorList
end

function getPlayersInterior(playerElement)
    local playerInteriors = {}

    for _, interiorData in pairs(interiorList) do
        if interiorData.owner == getElementData(playerElement, "char.ID") then
            table.insert(playerInteriors, interiorData)
        end
    end

    return playerInteriors
end

addCommandHandler("getinteriorowner", 
function (sourcePlayer, commandName, veh)
        if exports.sPermission:hasPermission(sourcePlayer, "getinteriorowner") then
            local veh = tonumber(veh)
            if veh then
                if not interiorList[veh] then
                    outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Nem létezik ilyen interior!", sourcePlayer)
                    return
                end
                local owner = interiorList[veh].owner
                outputChatBox("[color=sightgreen][SightMTA - Interior]:[color=hudwhite] Az interior tulajdonosa: [color=sightgreen]".. owner .."", sourcePlayer, 255, 150, 0)
            else
				outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Interior ID]", sourcePlayer)
            end
        end
    end
)

addCommandHandler("gotointerior", 
function (sourcePlayer, commandName, id)
        if exports.sPermission:hasPermission(sourcePlayer, "gotointerior") then
            local id = tonumber(id)
            if id then
                pos = interiorList[id].outside
                warpElement(sourcePlayer, pos[1], pos[2], pos[3], 0, 0, 0, pos[4], pos[5])
                outputChatBox("[color=sightgreen][SightMTA - Interior]:[color=hudwhite] Elteleportáltál a(z) "..id.." azonosítójú interiorhoz!", sourcePlayer, 255, 150, 0)
            else
				outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Interior ID]", sourcePlayer)
            end
        end
    end
)

addCommandHandler("changelock2int", 
function (sourcePlayer, commandName, id)
        if exports.sPermission:hasPermission(sourcePlayer, "changelock2int") then
            local id = tonumber(id)
            if id then
                exports.sItems:giveItem(sourcePlayer, 2, 1, false, id)
                outputChatBox("[color=sightgreen][SightMTA - Interior]:[color=hudwhite] Sikeresen másoltál egy kulcsot!", sourcePlayer, 255, 150, 0)
            else
				outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Interior ID]", sourcePlayer)
            end
        end
    end
)

addCommandHandler("setinteriorowner", 
function (sourcePlayer, commandName, id, targetPlayer)
        if exports.sPermission:hasPermission(sourcePlayer, "setinteriorowner") then
            local id = tonumber(id)
            if id and targetPlayer then
                if not interiorList[id] then
                    outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Nem létezik ilyen interior!", sourcePlayer)
                    return
                end
                targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
                if not targetPlayer then
                    return
                end
                local charId = getElementData(targetPlayer, "char.ID")
                interiorList[id].owner = charId
                dbExec(connection, "UPDATE interiors SET owner = ? WHERE interiorId = ?", charId, id)
                triggerClientEvent("syncInteriorData", sourcePlayer, id, interiorList[id])
                outputChatBox("[color=sightgreen][SightMTA - Interior]:[color=hudwhite] Sikeresen megváltoztattad a tulajdonost!", sourcePlayer, 255, 150, 0)
            else
				outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Interior ID] [Játékos Név / ID]", sourcePlayer)
            end
        end
    end
)

addCommandHandler("setinteriorprice", 
function (sourcePlayer, commandName, id, price)
        if exports.sPermission:hasPermission(sourcePlayer, "setinteriorprice") then
            local id = tonumber(id)
            local price = tonumber(price)
            if id and price then
                if not interiorList[id] then
                    outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Nem létezik ilyen interior!", sourcePlayer)
                    return
                end
                interiorList[id].price = price
                dbExec(connection, "UPDATE interiors SET price = ? WHERE interiorId = ?", price, id)
                triggerClientEvent("syncInteriorData", sourcePlayer, id, interiorList[id])
                outputChatBox("[color=sightgreen][SightMTA - Interior]:[color=hudwhite] Sikeresen megváltoztattad az interior árát!", sourcePlayer, 255, 150, 0)
            else
				outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Interior ID] [Ár]", sourcePlayer)
            end
        end
    end
)

addCommandHandler("setinteriorid", 
function (sourcePlayer, commandName, id, inside)
        if exports.sPermission:hasPermission(sourcePlayer, "setinteriorid") then
            local id = tonumber(id)
            local inside = tonumber(inside)
            if id and inside then
                if not interiorList[id] then
                    outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Nem létezik ilyen interior!", sourcePlayer)
                    return
                end
                interiorList[id].inside = inside
                dbExec(connection, "UPDATE interiors SET inside = ? WHERE interiorId = ?", inside, id)
                triggerClientEvent("syncInteriorData", sourcePlayer, id, interiorList[id])
                outputChatBox("[color=sightgreen][SightMTA - Interior]:[color=hudwhite] Sikeresen megváltoztattad az interior belsejét!", sourcePlayer, 255, 150, 0)
            else
				outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Interior ID] [Belső ID]", sourcePlayer)
            end
        end
    end
)

addCommandHandler("setinteriorunowned", 
function (sourcePlayer, commandName, id, targetPlayer)
        if exports.sPermission:hasPermission(sourcePlayer, "setinteriorunowned") then
            local id = tonumber(id)
            if id then
                if not interiorList[id] then
                    outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Nem létezik ilyen interior!", sourcePlayer)
                    return
                end
                interiorList[id].owner = false
                dbExec(connection, "UPDATE interiors SET owner = ? WHERE interiorId = ?", 0, id)
                triggerClientEvent("syncInteriorData", sourcePlayer, id, interiorList[id])
                outputChatBox("[color=sightgreen][SightMTA - Interior]:[color=hudwhite] Sikeresen megváltoztattad az interior tulajdonosát!", sourcePlayer, 255, 150, 0)
            else
				outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Interior ID]", sourcePlayer)
            end
        end
    end
)

function getGroupInteriors(group)
    local ints = {}
    for k, v in pairs(interiorList) do
        if v.ownerType == "group" and v.owner == group then
            v.id = k
            table.insert(ints, v)
        end
    end
    return ints
end

addCommandHandler("groupinteriors", 
function (sourcePlayer, commandName, group)
        if exports.sPermission:hasPermission(sourcePlayer, "groupinteriors") then
            if group and exports.sGroups:isGroupValid(group) then
                local groupInteriors = getGroupInteriors(group)
                if groupInteriors and #groupInteriors > 0 then
                    local groupName = exports.sGroups:getGroupName(group)
                    if groupName then
                        outputChatBox("[color=sightgreen][SightMTA - Interior]:[color=hudwhite] A(z)[color=sightgreen] " .. groupName .. "[color=hudwhite] interiorjai:", sourcePlayer, 255, 150, 0)
                        for k, v in pairs(groupInteriors) do
                            outputChatBox("  [color=sightblue]Név: [color=hudwhite]" .. v.name .. "[color=sightblue] ID:[color=hudwhite] " .. v.id, sourcePlayer, 255, 255, 255)
                        end
                    end
                else
                    outputChatBox("[color=sightred][SightMTA - Interior]:[color=hudwhite] Ennek a frakciónak egyetlen interiorja sincs!", sourcePlayer)
                end
            else
				outputChatBox("[color=sightblue][SightMTA - Interior]:[color=hudwhite] /" .. commandName .. " [Frakció prefix (pl. PD, NAV)]", sourcePlayer)
            end
        end
    end
)