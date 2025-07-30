local connection = false
playerGroups = {}
playerPermissions = {}

addEventHandler("onResourceStart", getRootElement(), function(res)
    local resName = getResourceName(res)

    if res == getThisResource() then
        connection = exports.sConnection:getConnection()

        loadGroups()

        for key, player in pairs(getElementsByType("player")) do
            setTimer(requestPlayerGroups, 2500, 1, player) 
        end
    elseif resName == "sConnection" then
        connection = exports.sConnection:getConnection()
    end
end)

addEventHandler("onElementDataChange", getRootElement(), function(dataName, oldValue, newValue)
    if dataName == "loggedIn" and newValue then
        setTimer(requestPlayerGroups, 2500, 1, source) 
        setTimer(refreshPlayerPermissions, 3000, 1, source)
    end
end)

function loadGroups()
    dbQuery(function(qh)
        local result = dbPoll(qh, 0)

        for i = 1, #result do
            loadGroup(result[i])
        end
    end, connection, "SELECT * FROM groups")
end

function loadGroup(data)
    local groupPrefix = data.groupPrefix

    if groupList[groupPrefix] then
        groupList[groupPrefix].rankNames = fromJSON(data.rankNames)
        groupList[groupPrefix].rankColors = fromJSON(data.rankColors)
        groupList[groupPrefix].rankSalaries = fromJSON(data.rankSalaries)
        groupList[groupPrefix].motd = data.motd
        groupList[groupPrefix].balance = data.balance
        groupList[groupPrefix].aid = data.aid
        groupList[groupPrefix].tax = data.tax
        groupList[groupPrefix].dutyCount = 0
        groupList[groupPrefix].members = {}

        dbQuery(function(qh)
            local result = dbPoll(qh, 0)

            if result then
                for i = 1, #result do
                    if result[i].online == 1 then
                        groupList[groupPrefix].dutyCount = groupList[groupPrefix].dutyCount + 1
                    end
                end
            end
        end, connection, "SELECT * FROM characters WHERE inDuty = ?", groupPrefix)

        if data.rankPermissions == "[ [ ] ]" then
            local temp = {}

            for rankId, rankName in pairs(groupList[groupPrefix].rankNames) do
                if not temp[rankId] then
                    temp[rankId] = {}
                end

                for permissionId, permissionName in pairs(groupList[groupPrefix].permissionList) do
                    if type(permissionName) == "table" then
                        for permissionId, permissionName in pairs(permissionName) do
                            temp[rankId][permissionName] = false
                        end
                    else
                        temp[rankId][permissionName] = false 
                    end
                end
            end

            groupList[groupPrefix].rankPermissions = temp
            dbExec(connection, "UPDATE groups SET rankPermissions = ? WHERE groupPrefix = ?", toJSON(temp), groupPrefix)
        else
            groupList[groupPrefix].rankPermissions = fromJSON(data.rankPermissions)
        end

        if data.rankSkins == "[ [ ] ]" then
            local temp = {}

            for rankId, rankName in pairs(groupList[groupPrefix].rankNames) do
                if not temp[rankId] then
                    temp[rankId] = {}
                end

                for i = 1, groupList[groupPrefix].skins do
                    temp[rankId][i] = false 
                end
            end

            groupList[groupPrefix].rankSkins = temp
            dbExec(connection, "UPDATE groups SET rankSkins = ? WHERE groupPrefix = ?", toJSON(temp), groupPrefix)
        else
            groupList[groupPrefix].rankSkins = fromJSON(data.rankSkins)
        end

        if data.rankItems == "[ [ ] ]" then
            local temp = {}

            for rankId, rankName in pairs(groupList[groupPrefix].rankNames) do
                if not temp[rankId] then
                    temp[rankId] = {}
                end

                for itemId, itemData in pairs(groupList[groupPrefix].items) do
                    temp[rankId][itemId] = false
                end
            end

            groupList[groupPrefix].rankItems = temp
            dbExec(connection, "UPDATE groups SET rankItems = ? WHERE groupPrefix = ?", toJSON(temp), groupPrefix)
        else
            local rankItems = fromJSON(data.rankItems)
            groupList[groupPrefix].rankItems = {}
            
            for rankId, rankData in pairs(rankItems) do
                if not groupList[groupPrefix].rankItems[rankId] then
                    groupList[groupPrefix].rankItems[rankId] = {}
                end

                for itemId, itemData in pairs(rankData) do
                    local itemId = tonumber(itemId)
                
                    if rankId and itemId then
                        groupList[groupPrefix].rankItems[rankId][itemId] = itemData
                    end
                end
            end 
        end

        requestGroupMembers(groupPrefix)
        requestGroupVehicles(groupPrefix)
        refreshGroupInteriors(groupPrefix)
        refreshGroupGates(groupPrefix)
    end
end

function requestGroupMembers(group)
    if groupList[group] then
        dbQuery(function(qh, group)
            local result = dbPoll(qh, 0)

            for i = 1, #result do
                if not groupList[group].members[i] then
                    groupList[group].members[i] = {}
                end

                if result[i].rank > #groupList[group].rankNames then
                    groupList[group].members[i][2] = 1
                    dbExec(connection, "UPDATE groupmembers SET rank = ? WHERE groupPrefix = ? AND characterId = ?", 1, group, result[i].characterId)
                else
                    groupList[group].members[i][2] = result[i].rank
                end

                groupList[group].members[i][3] = result[i].isLeader == 1
                groupList[group].members[i][4] = result[i].lastOnline
                groupList[group].members[i][5] = result[i].added
                groupList[group].members[i][6] = result[i].promoted
                groupList[group].members[i][7] = result[i].characterId
                
                for key, player in pairs(getElementsByType("player")) do
                    local characterId = getElementData(player, "char.ID") or false
                    
                    if characterId == result[i].characterId then
                        groupList[group].members[i][4] = player
                    end
                end

                dbQuery(function(qh, group)
                    local result = dbPoll(qh, 0)
                    if result and result[1] and result[1].name then
                        groupList[group].members[i][1] = result[1].name:gsub("_", " ")
                        groupList[group].members[i][4] = result[1].lastOnline
                    end
                end, {group}, connection, "SELECT characters.name AS name, accounts.lastOnline AS lastOnline FROM characters INNER JOIN accounts ON characters.accountId = accounts.accountId WHERE characters.characterId = ?", result[i].characterId)
                
            end
        end, {group}, connection, "SELECT * FROM groupmembers WHERE groupPrefix = ?", group)
    end
end

addCommandHandler("setvehiclegroup", function(sourcePlayer, commandName, vehicleIdentity, groupName)
    if exports.sPermission:hasPermission(sourcePlayer, "setvehiclegroup") then
        if vehicleIdentity and groupName then
            if not exports.sGroups:isGroupValid(groupName) and groupName and groupName ~= "0" then
                exports.sGui:showInfobox(sourcePlayer, "e", "Nem létezik ilyen frakció!")
                return
            end

            local vehicleIdentity = tonumber(vehicleIdentity)

            if groupName == "0" then

                local queryString = dbPrepareString(connection, "SELECT groupPrefix FROM ?? WHERE dbID=?", "vehicles", vehicleIdentity)
                local queryHandle = dbQuery(connection, queryString)
                
                if queryHandle then
                    queryResult = dbPoll(queryHandle, -1)
                    if queryResult then
                        queryResult = queryResult[1].groupPrefix
                    end
                    dbFree(queryHandle)
                end


                exports.sConnection:dbUpdate("vehicles", {
                    ["groupPrefix"] = 0
                }, {dbID = vehicleIdentity})

                if queryResult then
                    requestGroupVehicles(queryResult)
                end

                local queryString = dbPrepareString(connection, "SELECT characterId FROM ?? WHERE dbID=?", "vehicles", vehicleIdentity)
                local queryHandle = dbQuery(connection, queryString)
                
                if queryHandle then
                    queryResult = dbPoll(queryHandle, -1)
                end


                if queryResult then
                    local veh = findVehicleByID(vehicleIdentity)
                    local cID = queryResult[1].characterId
                    if veh and isElement(veh) then
                        setElementData(veh, "vehicle.owner", tonumber(cID))
                        setElementData(veh, "vehicle.group", 0)
                    end
                    dbFree(queryHandle)
                end
                outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]A jármű sikeresen levételre került a frakcióról!", sourcePlayer)
            else
                exports.sConnection:dbUpdate("vehicles", {
                    ["groupPrefix"] = groupName
                }, {dbID = vehicleIdentity})
                outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]A jármű sikeresen felvéve a frakcióra!", sourcePlayer)
                requestGroupVehicles(groupName)
                local veh = findVehicleByID(vehicleIdentity)

                setElementData(veh, "vehicle.group", groupName)
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/".. commandName .." [Jármű ID] [Frakció (0 - Levétel)]", sourcePlayer)
        end
    end
end)

function requestGroupVehicles(group)
    if groupList[group] then
        dbQuery(function(qh, group)
            local result = dbPoll(qh, 0)

            groupList[group].vehicles = {}

            for i = 1, #result do
                local id = tonumber(result[i].dbID)

                if not groupList[group].vehicles[id] then
                    groupList[group].vehicles[id] = {}
                end

                if result[i].customPlate then
                    if utf8.len(result[i].customPlate) > 0 then
                        plate = result[i].customPlate
                    else
                        plate = result[i].plate
                    end
                else
                    plate = result[i].plate
                end
                
                groupList[group].vehicles[id][1] = result[i].modelId
                groupList[group].vehicles[id][2] = plate
                groupList[group].vehicles[id][3] = result[i].dbID

                local customModel = result[i].customModel ~= "false" and result[i].customModel or false

                groupList[group].vehicles[id][4] = result[i].customModel
            end
            refreshGroupVehicles(group)
        end, {group}, connection, "SELECT * FROM vehicles WHERE groupPrefix = ?", group)
    end
end

function isValidGroup(groupName)
    return groupList[groupName] and true or false
end

function refreshGroupVehicles(group)
    dbQuery(function(qh, group)
        local result = dbPoll(qh, 0)

        if result and result[1] then
            local tempVehicleMembers = fromJSON(result[1].vehicleMembers) or {}

            dbQuery(function(qh2, group)
                local result2 = dbPoll(qh2, 0)
                local vehicleMembers = {}

                for vehicleId, vehicleData in pairs(groupList[group].vehicles) do
                    local vehicleIdStr = tostring(vehicleId)
                    local vehicleIdNum = tonumber(vehicleId)

                    if not vehicleMembers[vehicleIdNum] then
                        vehicleMembers[vehicleIdNum] = {}
                    end

                    for j = 1, #result2 do
                        local characterId = tonumber(result2[j].characterId)
                        if tempVehicleMembers[vehicleIdStr] and (tempVehicleMembers[vehicleIdStr][characterId] or (tempVehicleMembers[vehicleIdStr][tostring(characterId)])) then
                            vehicleMembers[vehicleIdNum][characterId] = true
                        else
                            vehicleMembers[vehicleIdNum][characterId] = false
                        end

                    end
                end
                groupList[group].vehicleMembers = vehicleMembers
                dbExec(connection, "UPDATE groups SET vehicleMembers = ? WHERE groupPrefix = ?", toJSON(vehicleMembers), group)
                dbFree(qh2)
            end, {group}, connection, "SELECT * FROM groupmembers WHERE groupPrefix = ?", group)
        end

        dbFree(qh)
    end, {group}, connection, "SELECT * FROM groups WHERE groupPrefix = ?", group)
end

function isVehicleInGroup(vehicleId)
    for groupName, groupData in pairs(groupList) do
        for groupVehicleId, vehicleData in pairs(groupData.vehicles) do
            if groupVehicleId == vehicleId then
                return true, groupName
            end
        end
    end
    return false
end

function convertKeys(table)
	local newTable = {}
	for key, value in pairs(table) do
		local numericKey = tonumber(key)
		if numericKey then
			key = numericKey
		end

		if type(value) == "table" then
			newTable[key] = convertKeys(value)
		else
			newTable[key] = value
		end
	end
	return newTable
end

function processJson(jsonTable)

    return convertKeys(jsonTable)
end

function refreshGroupGates(group)
    dbQuery(function(qh, group)
        local result = dbPoll(qh, 0)

        if result and result[1] then
            local tempGateMembers = processJson(fromJSON(result[1].gateMembers)) or {}

            dbQuery(function(qh2, group)
                local result2 = dbPoll(qh2, 0)
                local gateMembers = {}
                local groupGates = exports.sGates:getGroupGates(group)

                for _, gateId in pairs(groupGates) do
                    local gateIdStr = tostring(gateId)
                    local gateIdNum = tonumber(gateId)

                    for j = 1, #result2 do
                        local characterId = tonumber(result2[j].characterId)
                        local permissionState = false
                        if tempGateMembers[gateIdStr] and (tempGateMembers[gateIdStr][characterId] or tempGateMembers[gateIdStr][tostring(characterId)]) then
                            permissionState = tempGateMembers[gateIdNum][characterId]
                        end

                        if not gateMembers[gateIdNum] then
                            gateMembers[gateIdNum] = {}
                        end
                        gateMembers[gateIdNum][characterId] = permissionState
                    end
                end
                groupList[group].gateMembers = gateMembers
                dbExec(connection, "UPDATE groups SET gateMembers = ? WHERE groupPrefix = ?", toJSON(gateMembers), group)
                dbFree(qh2)
            end, {group}, connection, "SELECT * FROM groupmembers WHERE groupPrefix = ?", group)
        end

        dbFree(qh)
    end, {group}, connection, "SELECT * FROM groups WHERE groupPrefix = ?", group)
end


function refreshGroupInteriors(group)
    dbQuery(function(qh, group)
        local result = dbPoll(qh, 0)

        if result and result[1] then
            local tempInteriorMembers = fromJSON(result[1].interiorMembers) or {}

            dbQuery(function(qh2, group)
                local result2 = dbPoll(qh2, 0)
                local interiorMembers = {}
                local groupInteriors = exports.sInteriors:getGroupInteriorsEx(group)

                for interiorId, interiorData in pairs(groupInteriors) do
                    local interiorIdStr = tostring(interiorId)
                    local interiorIdNum = tonumber(interiorId)

                    for j = 1, #result2 do
                        local characterId = tonumber(result2[j].characterId)
                        if tempInteriorMembers[interiorIdStr] and (tempInteriorMembers[interiorIdStr][characterId] or tempInteriorMembers[interiorIdStr][tostring(characterId)]) then
                            permissionState = true
                        else
                            permissionState = false
                        end

                        if not interiorMembers[interiorIdNum] then
                            interiorMembers[interiorIdNum] = {}
                        end

                        interiorMembers[interiorIdNum][characterId] = permissionState
                    end
                end

                if group then
                    groupList[group].interiorMembers = interiorMembers
                    dbExec(connection, "UPDATE groups SET interiorMembers = ? WHERE groupPrefix = ?", toJSON(interiorMembers), group)
                end

                dbFree(qh2)
            end, {group}, connection, "SELECT * FROM groupmembers WHERE groupPrefix = ?", group)
        end

        dbFree(qh)
    end, {group}, connection, "SELECT * FROM groups WHERE groupPrefix = ?", group)
end


--[[
function refreshGroupGates(group)
    local groupGates = exports.sGates:getGroupGates(group)
    groupList[group].gates = groupGates
end
]]

playerGroupsVehicles = {}

function getPlayerGroups(sourcePlayer)
    if playerGroups[sourcePlayer] then
        return playerGroups[sourcePlayer]
    end
end

function requestPlayerGroups(client)
    local characterId = getElementData(client, "char.ID") or false

    if characterId then
        dbQuery(function(qh, client, characterId)
            local result = dbPoll(qh, 0)
            local temp = {}

            playerGroups[client] = {}

            local groupInteriors = {}
            local groupVehicles = {}
            local groupGates = {}

            for i = 1, #result do
                table.insert(temp, result[i].groupPrefix)
                playerGroups[client][result[i].groupPrefix] = result[i]

                for j = 1, #groupList[result[i].groupPrefix].members do
                    if groupList[result[i].groupPrefix].members[j] and groupList[result[i].groupPrefix].members[j][7] then
                        if groupList[result[i].groupPrefix].members[j][7] == characterId then
                            groupList[result[i].groupPrefix].members[j][4] = client
                            groupList[result[i].groupPrefix].members[j][1] = getElementData(client, "visibleName"):gsub("_", " ")
                            
                            local groupMembers = getGroupMembers(result[i].groupPrefix)
                            triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, result[i].groupPrefix, {["gotMembers"] = groupList[result[i].groupPrefix].members})
    
                            break
                        end
                    end
                end

                local groupInteriorsEx = groupList[result[i].groupPrefix].interiorMembers 
                local groupVehiclesEx = groupList[result[i].groupPrefix].vehicleMembers 


                if groupInteriorsEx then
                    for vehicleId, vehicleData in pairs(groupInteriorsEx) do
                        for characterId, vehicleState in pairs(vehicleData) do
                            if (getElementData(client, "char.ID") == characterId and vehicleState) or playerGroups[client][result[i].groupPrefix].isLeader == 1 then
                                groupInteriors[vehicleId] = true
                            end
                        end
                    end
                end

                local groupGatesEx = groupList[result[i].groupPrefix].gateMembers 

                if groupVehiclesEx then
                    for vehicleId, vehicleData in pairs(groupVehiclesEx) do
                        for characterId, vehicleState in pairs(vehicleData) do
                            if (getElementData(client, "char.ID") == characterId and vehicleState) or playerGroups[client][result[i].groupPrefix].isLeader == 1 then
                                groupVehicles[vehicleId] = true
                            end
                        end
                    end
                end

                if groupGatesEx then
                    for gateId, gateData in pairs(groupGatesEx) do
                        for characterId, gateState in pairs(gateData) do
                            if (getElementData(client, "char.ID") == characterId and vehicleState) or playerGroups[client][result[i].groupPrefix].isLeader == 1 then
                                groupGates[gateId] = true
                            end
                        end
                    end
                end
            end

            playerGroupsVehicles[characterId] = groupVehicles
            

            triggerClientEvent(client, "gotPlayerGroupMembership", client, temp)
            triggerClientEvent(client, "gotPlayerGroupInteriors", client, groupInteriors)
            triggerClientEvent(client, "gotPlayerGroupVehicles", client, groupVehicles)
            triggerClientEvent(client, "gotPlayerGroupGates", client, groupGates)


        end, {client, characterId}, connection, "SELECT * FROM groupmembers WHERE characterId = ?", characterId)
    end
end

function findPlayerByCharID(charID)
    local player = false
    for k, v in pairs(getElementsByType("player")) do
        if charID == getElementData(v, "char.ID") then
            player = v
            break
        end
    end
    return player
end

function findVehicleByID(charID)
    local player = false
    for k, v in pairs(getElementsByType("vehicle")) do
        if charID == getElementData(v, "vehicle.dbID") then
            player = v
            break
        end
    end
    return player
end

function getPlayerVehicle(player, vehicleId, group)
    if not tonumber(player) then
        player = getElementData(player, "char.ID")
    end
    local playerElement = findPlayerByCharID(player)
    if not vehicleId then
        return false
    end
    --[[if playerElement then
        if playerGroups[playerElement] and playerGroups[playerElement][group] and playerGroups[playerElement][group].isLeader == 1 then
            return true
        end
    end
    if vehicleId then
        if playerGroupsVehicles[charID] and playerGroupsVehicles[charID].vehicleId then
            return true
        end
    end
    return false--]] -- majd ha jó lesz a vehicleMembers
    if group and playerElement and isPlayerInGroup(playerElement, group) then
        return true
    end
    return false
end

addEventHandler("onPlayerQuit", getRootElement(), function()
    if playerGroups[source] then
        for group in pairs(playerGroups[source]) do
            for i = 1, #groupList[group].members do
                if groupList[group].members[i][4] == source then
                    groupList[group].members[i][4] = getRealTime().timestamp
                    dbExec(connection, "UPDATE groupmembers SET lastOnline = ? WHERE characterId = ?", groupList[group].members[i][7], getElementData(source, "char.dbID"))

                    local groupMembers = getGroupMembers(group)
                    triggerClientEvent(groupMembers, "refreshPlayerGroupData", source, group, {["gotMembers"] = groupList[group].members})

                    break
                end
            end
        end

        playerGroups[source] = nil
        playerPermissions[source] = nil
    end
end)

addEvent("requestPlayerGroupList", true)
addEventHandler("requestPlayerGroupList", getRootElement(), function()
    if source == client then
        local characterId = getElementData(client, "char.ID") or false

        if characterId then
            dbQuery(function(qh, client)
                local result = dbPoll(qh, 0)
                local temp = {}

                for i = 1, #result do
                    local groupName = exports.sGroups:getGroupName(result[i].groupPrefix)
                    table.insert(temp, {result[i].groupPrefix, groupName})
                end

                triggerClientEvent(client, "gotPlayerGroupList", client, temp)
            end, {client}, connection, "SELECT * FROM groupmembers WHERE characterId = ?", characterId)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #20 - sGroups @sourceS:493")
    end
end)

addEvent("requestPlayerGroupData", true)
addEventHandler("requestPlayerGroupData", getRootElement(), function(group)
    if playerGroups[client] and playerGroups[client][group] then
        if groupList[group] then
            local temp = {}
            temp.name = groupList[group].name
            temp.rank = playerGroups[client][group].rank
            temp.isLeader = playerGroups[client][group].isLeader
            temp.added = playerGroups[client][group].added
            temp.promoted = playerGroups[client][group].promoted
            temp.gotMembers = groupList[group].members
            temp.members = groupList[group].members
            temp.gotVehicles = groupList[group].vehicles
            temp.rankColors = groupList[group].rankColors
            temp.salaries = groupList[group].rankSalaries
            temp.ranks = groupList[group].rankNames
            temp.permissions = groupList[group].permissions
            temp.rankPermissions = groupList[group].rankPermissions
            temp.skins = groupList[group].skins
            temp.rankSkins = groupList[group].rankSkins
            temp.items = groupList[group].items
            temp.rankItems = groupList[group].rankItems
            temp.motd = groupList[group].motd
            temp.dutyCount = groupList[group].dutyCount
            temp.voiceRadio = groupList[group].voiceRadio
            temp.protectedRadio = groupList[group].protectedRadio
            temp.balance = groupList[group].balance
            temp.aid = groupList[group].aid
            temp.tax = groupList[group].tax
            temp.vehicleMembers = groupList[group].vehicleMembers
            temp.interiorMembers = groupList[group].interiorMembers
            temp.gateMembers = groupList[group].gateMembers

            local impoundedVehicles = {}
            for vehicleIndex, vehicleElement in pairs(getElementsByType("vehicle")) do
                if getElementData(vehicleElement, "vehicle.impounded") then
                    impoundedVehicles[getElementData(vehicleElement, "vehicle.dbID")] = true
                end
            end

            for _, groupVehData in pairs(temp.gotVehicles) do
                if groupVehData[1] and impoundedVehicles[groupVehData[1]] then
                    groupVehData[5] = true
                else
                    groupVehData[5] = false
                end
            end

            local groupGates = exports.sGates:getGroupGates(group)
            temp.groupGates = {}
            for key, value in pairs(groupGates) do
                temp.groupGates[value] = true
            end
            triggerClientEvent(client, "gotPlayerGroupData", client, group, temp)
        end
    end
end)

addEvent("requestPlayerPermissions", true)
addEventHandler("requestPlayerPermissions", getRootElement(), function()
    if source == client then
        refreshPlayerPermissions(client)
    else
        exports.sAnticheat:anticheatBan(client, "AC #21 - sGroups @sourceS:546")
    end
end)

function refreshPlayerPermissions(client)
    if not client then
        for id, player in pairs(getElementsByType("player")) do
            local characterId = getElementData(player, "char.ID")

            if characterId then
                playerPermissions[player] = {}
    
                dbQuery(function(qh, client)
                    local result = dbPoll(qh, 0)
    
                    for i = 1, #result do
                        local group = result[i].groupPrefix
                        local rank = result[i].rank
    
                        for key, value in pairs(groupList[group].rankPermissions[rank]) do
                            if not playerPermissions[client][key] then
                                playerPermissions[client][key] = {}
                            end
    
                            if result[i].isLeader == 1 then
                                table.insert(playerPermissions[client][key], group)
                            elseif value then
                                table.insert(playerPermissions[client][key], group)
                            end
                        end
                    end
    
                    triggerClientEvent(client, "gotPlayerGroupPermissions", client, playerPermissions[client])
                end, {player}, connection, "SELECT * FROM groupmembers WHERE characterId = ?", characterId)   
            end
        end
    else
        local characterId = getElementData(client, "char.ID")

        if characterId then
            playerPermissions[client] = {}

            dbQuery(function(qh, client)
                local result = dbPoll(qh, 0)

                for i = 1, #result do
                    local group = result[i].groupPrefix
                    local rank = result[i].rank

                    for key, value in pairs(groupList[group].rankPermissions[rank]) do
                        if not playerPermissions[client][key] then
                            playerPermissions[client][key] = {}
                        end

                        if result[i].isLeader == 1 then
                            table.insert(playerPermissions[client][key], group)
                        elseif value then
                            table.insert(playerPermissions[client][key], group)
                        end
                    end
                end

                triggerClientEvent(client, "gotPlayerGroupPermissions", client, playerPermissions[client])
            end, {client}, connection, "SELECT * FROM groupmembers WHERE characterId = ?", characterId)
        end
    end
end

addEvent("editGroupMOTD", true)
addEventHandler("editGroupMOTD", getRootElement(), function(group, description)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and playerGroups[client][group].isLeader == 1 then
            if groupList[group] and groupList[group].motd then
                local oldDescription = groupList[group].motd
                groupList[group].motd = description
                dbExec(connection, "UPDATE groups SET motd = ? WHERE groupPrefix = ?", description, group)

                local groupMembers = getGroupMembers(group)
                triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, group, {["motd"] = description})
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #22 - sGroups @sourceS:636")
    end
end)

function takeGroupBalance(groupPrefix, playerElement, paymentAmount)
    if playerGroups[playerElement] and playerGroups[playerElement][groupPrefix] then
        if groupList[groupPrefix].balance >= paymentAmount then
            local groupBalance = groupList[groupPrefix].balance
            local newGroupBalance = groupList[groupPrefix].balance - paymentAmount

            groupList[groupPrefix].balance = groupList[groupPrefix].balance - paymentAmount

            dbExec(connection, "UPDATE groups SET balance = ? WHERE groupPrefix = ?", groupList[groupPrefix].balance, groupPrefix)
            return true
        else
            return false
        end
    end
end

function addGroupBalance(groupPrefix, playerElement, paymentAmount)
    local groupBalance = groupList[groupPrefix].balance
    local newGroupBalance = groupList[groupPrefix].balance + paymentAmount

    groupList[groupPrefix].balance = groupList[groupPrefix].balance + paymentAmount

    dbExec(connection, "UPDATE groups SET balance = ? WHERE groupPrefix = ?", groupList[groupPrefix].balance, groupPrefix)
    return true
end

function giveGroupBalance(group, value)
    if group and value and groupList[group] then
        if tonumber(value) then
            groupList[group].balance = groupList[group].balance + value
            dbExec(connection, "UPDATE groups SET balance = ? WHERE groupPrefix = ?", groupList[group].balance, group)

            local groupMembers = getGroupMembers(group)
            triggerClientEvent(groupMembers, "refreshPlayerGroupData", root, group, {balance = groupList[group].balance})
        end
    end
end

function takeGroupBalance(group, value)
    if group and value and groupList[group] then
        if tonumber(value) then
            if groupList[group].balance >= value then
                groupList[group].balance = groupList[group].balance - value
                dbExec(connection, "UPDATE groups SET balance = ? WHERE groupPrefix = ?", groupList[group].balance, group)

                local groupMembers = getGroupMembers(group)
                triggerClientEvent(groupMembers, "refreshPlayerGroupData", root, group, {balance = groupList[group].balance})
            end
        end
    end
end

addEvent("depositGroupBalance", true)
addEventHandler("depositGroupBalance", getRootElement(), function(group, value)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and (playerGroups[client][group].isLeader == 1 or getPlayerPermissionInGroup(client, group, "manageGroupBalance")) then
            if tonumber(value) and value >= 1000 then
                if exports.sCore:takeMoney(client, value) then
                    groupList[group].balance = groupList[group].balance + value
                    dbExec(connection, "UPDATE groups SET balance = ? WHERE groupPrefix = ?", groupList[group].balance, group)

                    local groupMembers = getGroupMembers(group)
                    triggerClientEvent(client, "refreshGroupBalance", client, group, groupList[group].balance)
                else
                    exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
                    triggerClientEvent(client, "stopGroupLoader", client)
                end
            end
        else
            exports.sGui:showInfobox(client, "e", "A kiválasztott művelethez nincs jogosultságod!")
            triggerClientEvent(client, "stopGroupLoader", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #23 - sGroups @sourceS:671")
    end
end)

addEvent("withdrawGroupBalance", true)
addEventHandler("withdrawGroupBalance", getRootElement(), function(group, value)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and (playerGroups[client][group].isLeader == 1 or getPlayerPermissionInGroup(client, group, "manageGroupBalance")) then
            if tonumber(value) and value >= 1000 then
                if groupList[group].balance - value > 0 then
                    groupList[group].balance = groupList[group].balance - value
                    dbExec(connection, "UPDATE groups SET balance = ? WHERE groupPrefix = ?", groupList[group].balance, group)

                    local groupMembers = getGroupMembers(group)

                    triggerClientEvent(client, "refreshGroupBalance", client, group, groupList[group].balance)
                    exports.sCore:giveMoney(client, value)
                else
                    exports.sGui:showInfobox(client, "e", "Nincs elég pénz a frakciókasszán!")
                    triggerClientEvent(client, "stopGroupLoader", client)
                end
            end
        else
            exports.sGui:showInfobox(client, "e", "A kiválasztott művelethez nincs jogosultságod!")
            triggerClientEvent(client, "stopGroupLoader", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #24 - sGroups @sourceS:708")
    end
end)

addCommandHandler("groupmonetary", function(client, commandName)
    if exports.sPermission:hasPermission(client, "groupmonetary") then
        dbQuery(function(qh, client)
            local result = dbPoll(qh, 0)
            local data = {}

            for i = 1, #result do
                if result[i] then
                    table.insert(data, {result[i].groupPrefix, result[i].balance, result[i].aid, result[i].tax})
                end
            end

            triggerClientEvent(client, "groupMonetary", client, data)
        end, {client}, connection, "SELECT * FROM groups")
    end
end)


addEvent("saveGroupMonetary", true)
addEventHandler("saveGroupMonetary", getRootElement(), function(data)
    if client == source then
        if exports.sPermission:hasPermission(client, "groupmonetary") then
            for i = 1, #data do
                local groupPrefix = data[i][1]
                local monetaryType = data[i][2]

                if groupList[groupPrefix] and groupList[groupPrefix][monetaryType] then
                    groupList[groupPrefix][monetaryType] = data[i][3]
                    dbExec(connection, "UPDATE groups SET " .. monetaryType .. " = ? WHERE groupPrefix = ?", data[i][3], groupPrefix)

                    local groupMembers = getGroupMembers(groupPrefix)
                    triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, groupPrefix, {[monetaryType] = data[i][3]})
                end
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #25 - sGroups @sourceS:748")
    end
end)

addEvent("addPlayerToGroup", true)
addEventHandler("addPlayerToGroup", getRootElement(), function(group, player)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and (playerGroups[client][group].isLeader == 1 or getPlayerPermissionInGroup(client, group, "hireFire")) then
            dbQuery(function(qh, client, group, player)
                local result = dbPoll(qh, 0)
                if #result <= 0 then
                    table.insert(groupList[group].members, {getElementData(player, "visibleName"):gsub("_", " "), 1, false, player, getRealTime().timestamp, getRealTime().timestamp, getElementData(player, "char.ID")})
                    dbExec(connection, "INSERT INTO groupmembers (characterId, groupPrefix, added, promoted) VALUES (?, ?, ?, ?)", getElementData(player, "char.ID"), group, getRealTime().timestamp, getRealTime().timestamp)
                    requestPlayerGroups(player)
        
                    exports.sDashboard:givePlayerAchievement(player, "group")

                    local groupMembers = getGroupMembers(group)
                    triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, group, {["gotMembers"] = groupList[group].members})

                    exports.sGui:showInfobox(client, "s", "Sikeresen felvetted a kiválaszott játékost a frakcióba!")
                    exports.sGui:showInfobox(player, "s", "Felvettek ebbe a frakcióba: " .. getGroupName(group))

                    refreshPlayerPermissions()
                else
                    exports.sGui:showInfobox(client, "e", "A kiválasztott játékos már a frakció tagja!")
                    triggerClientEvent(client, "stopGroupLoader", client)
                end
            end, {client, group, player}, connection, "SELECT * FROM groupmembers WHERE characterId = ? AND groupPrefix = ?", getElementData(player, "char.ID"), group)
        else
            exports.sGui:showInfobox(client, "e", "A kiválasztott művelethez nincs jogosultságod!")
            triggerClientEvent(client, "stopGroupLoader", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #26 - sGroups @sourceS:781")        
    end
end)

addEvent("firePlayerFromGroup", true)
addEventHandler("firePlayerFromGroup", getRootElement(), function(group, player)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and (playerGroups[client][group].isLeader == 1 or getPlayerPermissionInGroup(client, group, "hireFire")) then
            if groupList[group].members[player] then
                if groupList[group].members[player][7] == getElementData(client, "char.ID") then
                    exports.sGui:showInfobox(client, "e", "Saját magadat nem rúghatod ki a frakcióból!")
                    triggerClientEvent(client, "stopGroupLoader", client)
                    return
                end
                
                exports.sGui:showInfobox(client, "s", "Sikeresen kirúgtad a kiválaszott játékost a frakcióból!")
                if isElement(groupList[group].members[player][4]) then
                    if groupList[group].protectedRadio then
                        local pr = groupList[group].protectedRadio
                        local pl = groupList[group].members[player][4]
                        local radioData = getElementData(pl, "char.Radio") or {}
                        local radio1 = tonumber(radio1)
                        local radio2 = radioData[2] and tonumber(radioData[2]) or false
                        if radio1 == pr then
                            setElementData(pl, "char.Radio", {false, radio2})
                            triggerClientEvent(pl, "gotWalkieTalkieFrequencies", pl, false, radio2)
                        end
                        if radio2 == pr then
                            setElementData(pl, "char.Radio", {radio1, false})
                            triggerClientEvent(pl, "gotWalkieTalkieFrequencies", pl, radio1, false)
                        end
                        if radio1 == pr and radio2 == pr then
                            setElementData(pl, "char.Radio", {false, false})
                            triggerClientEvent(pl, "gotWalkieTalkieFrequencies", pl, false, false)
                        end
                        local currentSelectedRadio = getElementData(pl, "voiceRadioChannel")
                        if currentSelectedRadio == group then
                            setElementData(pl, "voiceRadioChannel", false)
                        end
                    end


                    local characterId = getElementData(groupList[group].members[player][4], "char.ID")

                    dbQuery(function(qh, client)
                        local result = dbPoll(qh, 0)
                        local temp = {}
        
                        for i = 1, #result do
                            local groupName = exports.sGroups:getGroupName(result[i].groupPrefix)
                            table.insert(temp, {result[i].groupPrefix, groupName})
                        end

                        triggerClientEvent(client, "gotPlayerGroupList", client, temp)
                    end, {groupList[group].members[player][4]}, connection, "SELECT * FROM groupmembers WHERE characterId = ?", characterId)

                    dbExec(connection, "DELETE FROM groupmembers WHERE characterId = ? AND groupPrefix = ?", groupList[group].members[player][7], group)

                    playerGroups[groupList[group].members[player][4]][group] = nil
                    exports.sGui:showInfobox(groupList[group].members[player][4], "e", "Kirúgtak ebből a frakcióból: " .. getGroupName(group))
                    requestPlayerGroups(groupList[group].members[player][4])
                end
                table.remove(groupList[group].members, player)

                local groupMembers = getGroupMembers(group)
                triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, group, {["gotMembers"] = groupList[group].members})

                refreshPlayerPermissions()
            end
        else
            exports.sGui:showInfobox(client, "e", "A kiválasztott művelethez nincs jogosultságod!")
            triggerClientEvent(client, "stopGroupLoader", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #27 - sGroups @sourceS:815")
    end
end)

addEvent("groupMemberSetRank", true)
addEventHandler("groupMemberSetRank", getRootElement(), function(group, member, rank)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and playerGroups[client][group].isLeader == 1 then
            local rankCount = #groupList[group].rankNames

            if rank <= rankCount then
                groupList[group].members[member][2] = rank
                groupList[group].members[member][6] = getRealTime().timestamp
                
                local groupMembers = getGroupMembers(group)
                triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, group, {
                    ["gotMembers"] = groupList[group].members,
                    ["rank"] = rank,
                    ["promoted"] = groupList[group].members[member][6]
                })

                exports.sConnection:dbUpdate("groupmembers", {
                    ["rank"] = rank,
                    ["promoted"] = groupList[group].members[member][6]
                }, {characterId = groupList[group].members[member][7], groupPrefix = group})
                
                playerGroups[groupList[group].members[member][4]][group].rank = rank 

                if isElement(groupList[group].members[member][4]) then
                    exports.sGui:showInfobox(groupList[group].members[member][4], "i", "Megváltoztatták a rangod (" .. getGroupName(group) .. " frakció): " .. groupList[group].rankNames[rank])
                end

                refreshPlayerPermissions()
            end
        else
            exports.sGui:showInfobox(client, "e", "A kiválasztott művelethez nincs jogosultságod!")
            triggerClientEvent(client, "stopGroupLoader", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #28 - sGroups @sourceS:854") 
    end
end)

addEvent("refreshRankPermissions", true)
addEventHandler("refreshRankPermissions", getRootElement(), function(group, rank, permissions, items, skins)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and playerGroups[client][group].isLeader == 1 then
            groupList[group].rankItems[rank] = {}
            groupList[group].rankSkins[rank] = {}
            groupList[group].rankPermissions[rank] = {}

            for permissionId, permissionName in pairs(groupList[group].permissionList) do
                if type(permissionName) == "table" then
                    for permissionId, permissionName in pairs(permissionName) do
                        groupList[group].rankPermissions[rank][permissionName] = false
                    end
                else
                    groupList[group].rankPermissions[rank][permissionName] = false 
                end
            end

            for itemId, itemData in pairs(groupList[group].items) do
                groupList[group].rankItems[rank][itemId] = false
            end

            for i = 1, groupList[group].skins do
                groupList[group].rankSkins[rank][i] = false
            end

            for i = 1, #permissions do
                groupList[group].rankPermissions[rank][permissions[i]] = true
            end

            for i = 1, #items do
                groupList[group].rankItems[rank][items[i]] = true
            end

            for i = 1, #skins do
                groupList[group].rankSkins[rank][skins[i]] = true
            end

            exports.sConnection:dbUpdate("groups", {
                ["rankPermissions"] = toJSON(groupList[group].rankPermissions),
                ["rankSkins"] = toJSON(groupList[group].rankSkins),
                ["rankItems"] = toJSON(groupList[group].rankItems)
            }, {groupPrefix = group})
    
            local groupMembers = getGroupMembers(group)
            triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, group, {
                ["rankPermissions"] = groupList[group].rankPermissions,
                ["rankSkins"] = groupList[group].rankSkins,
                ["rankItems"] = groupList[group].rankItems
            })
            
            refreshPlayerPermissions()
        else
            exports.sGui:showInfobox(client, "e", "A kiválasztott művelethez nincs jogosultságod!")
            triggerClientEvent(client, "stopGroupLoader", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #29 - sGroups @sourceS:915")
    end
end)

addEvent("editGroupRank", true)
addEventHandler("editGroupRank", getRootElement(), function(group, rank, name, salary, color)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and playerGroups[client][group].isLeader == 1 then
            if tonumber(salary) and salary >= 0 and salary <= 100000 then
                groupList[group].rankNames[rank] = name
                groupList[group].rankColors[rank] = color
                groupList[group].rankSalaries[rank] = salary

                exports.sConnection:dbUpdate("groups", {
                    ["rankNames"] = toJSON(groupList[group].rankNames),
                    ["rankColors"] = toJSON(groupList[group].rankColors),
                    ["rankSalaries"] = toJSON(groupList[group].rankSalaries)
                }, {groupPrefix = group})

                local groupMembers = getGroupMembers(group)
                triggerClientEvent(groupMembers, "refreshPlayerGroupDataParamter", client, group, rank, {
                    ["ranks"] = name,
                    ["rankColors"] = color,
                    ["salaries"] = salary,
                })
                
                refreshPlayerPermissions()
            end
        else
            exports.sGui:showInfobox(client, "e", "A kiválasztott művelethez nincs jogosultságod!")
            triggerClientEvent(client, "stopGroupLoader", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #30 - sGroups @sourceS:948")
    end
end)

addEvent("editGroupGatesMembers", true)
addEventHandler("editGroupGatesMembers", getRootElement(), function(group, vehicle, members)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and (playerGroups[client][group].isLeader == 1 or getPlayerPermissionInGroup(client, group, "manageKeysGate")) then
            local characterIds = {}

            for playerId, playerData in pairs(groupList[group].members) do
                for i = 1, #members do
                    if playerId == members[i] then
                        characterIds[playerId] = playerData[7]
                    end
                end
            end

            for key, value in pairs(groupList[group].gateMembers[vehicle]) do
                groupList[group].gateMembers[vehicle][key] = false
                if getPlayerByCharID(key) then
                    requestPlayerGroups(getPlayerByCharID(key))
                end
            end

            for playerId, characterId in pairs(characterIds) do
                groupList[group].gateMembers[vehicle][characterId] = true

                if isPlayerInGroup(getPlayerByCharID(characterId), group) then
                    groupList[group].gateMembers[vehicle][characterId] = true
                end

                if getPlayerByCharID(characterId) then
                    requestPlayerGroups(getPlayerByCharID(characterId))
                end
            end

            exports.sConnection:dbUpdate("groups", {
                ["gateMembers"] = toJSON(groupList[group].gateMembers)
            }, {groupPrefix = group})

            local groupMembers = getGroupMembers(group)
            triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, group, {
                ["gateMembers"] = groupList[group].gateMembers
            })
        else
            exports.sGui:showInfobox(client, "e", "A kiválasztott művelethez nincs jogosultságod!")
            triggerClientEvent(client, "stopGroupLoader", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #35 - sGroups @sourceS:1253")
    end
end)

addEvent("deleteGroupRank", true)
addEventHandler("deleteGroupRank", getRootElement(), function(group, rank)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and playerGroups[client][group].isLeader == 1 then
            table.remove(groupList[group].rankNames, rank)
            table.remove(groupList[group].rankColors, rank)
            table.remove(groupList[group].rankSalaries, rank)
            table.remove(groupList[group].rankPermissions, rank)
            table.remove(groupList[group].rankSkins, rank)
            table.remove(groupList[group].rankItems, rank)

            dbQuery(function(qh, client, group, rank)
                local result = dbPoll(qh, 0)

                for i = 1, #result do
                    if rank > #groupList[group].rankNames then
                        dbExec(connection, "UPDATE groupmembers SET rank = ? WHERE groupPrefix = ? AND characterId = ?", 1, group, result[i].characterId)

                        for j = 1, #groupList[group].members do
                            if groupList[group].members[j][7] == result[i].characterId then
                                groupList[group].members[j][2] = 1
                            end
                        end
                    end
                end

                exports.sConnection:dbUpdate("groups", {
                    ["rankNames"] = toJSON(groupList[group].rankNames),
                    ["rankColors"] = toJSON(groupList[group].rankColors),
                    ["rankSalaries"] = toJSON(groupList[group].rankSalaries),
                    ["rankPermissions"] = toJSON(groupList[group].rankPermissions),
                    ["rankSkins"] = toJSON(groupList[group].rankSkins),
                    ["rankItems"] = toJSON(groupList[group].rankItems)
                }, {groupPrefix = group})

                local groupMembers = getGroupMembers(group)
                triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, group, {
                    ["ranks"] = groupList[group].rankNames,
                    ["rankColors"] = groupList[group].rankColors,
                    ["salaries"] = groupList[group].rankSalaries,
                    ["rankPermissions"] = groupList[group].rankPermissions,
                    ["rankSkins"] = groupList[group].rankSkins,
                    ["rankItems"] = groupList[group].rankItems,
                    ["gotMembers"] = groupList[group].members
                })
                
                refreshPlayerPermissions()
            end, {client, group, rank}, connection, "SELECT * FROM groupmembers WHERE groupPrefix = ? AND rank = ?", group, rank)
        else
            exports.sGui:showInfobox(client, "e", "A kiválasztott művelethez nincs jogosultságod!")
            triggerClientEvent(client, "stopGroupLoader", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #31 - sGroups @sourceS:1034")
    end
end)

addEvent("createNewGroupRank", true)
addEventHandler("createNewGroupRank", getRootElement(), function(group)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and playerGroups[client][group].isLeader == 1 then
            local rankId = #groupList[group].rankNames + 1
            if rankId > groupList[group].maxRanks then
                exports.sGui:showInfobox(client, "e", "A frakció elérte a maximum rang limitet!")
                triggerClientEvent(client, "stopGroupLoader", client)
                return
            end

            table.insert(groupList[group].rankNames, "Rang " .. rankId)
            table.insert(groupList[group].rankColors, "green")
            table.insert(groupList[group].rankSalaries, 0)

            groupList[group].rankSkins[rankId] = {}
            groupList[group].rankPermissions[rankId] = {}
            groupList[group].rankItems[rankId] = {}

            for i = 1, groupList[group].skins do
                groupList[group].rankSkins[rankId][i] = false
            end

            for permissionId, permissionName in pairs(groupList[group].permissionList) do
                if type(permissionName) == "table" then
                    for permissionId, permissionName in pairs(permissionName) do
                        groupList[group].rankPermissions[rankId][permissionName] = false
                    end
                else
                    groupList[group].rankPermissions[rankId][permissionName] = false 
                end
            end

            for itemId, itemData in pairs(groupList[group].items) do
                groupList[group].rankItems[rankId][itemId] = false
            end

            exports.sConnection:dbUpdate("groups", {
                ["rankNames"] = toJSON(groupList[group].rankNames),
                ["rankColors"] = toJSON(groupList[group].rankColors),
                ["rankSalaries"] = toJSON(groupList[group].rankSalaries),
                ["rankPermissions"] = toJSON(groupList[group].rankPermissions),
                ["rankSkins"] = toJSON(groupList[group].rankSkins),
                ["rankItems"] = toJSON(groupList[group].rankItems)
            }, {groupPrefix = group})

            local groupMembers = getGroupMembers(group)
            triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, group, {
                ["ranks"] = groupList[group].rankNames,
                ["rankColors"] = groupList[group].rankColors,
                ["salaries"] = groupList[group].rankSalaries,
                ["rankPermissions"] = groupList[group].rankPermissions,
                ["rankSkins"] = groupList[group].rankSkins,
                ["rankItems"] = groupList[group].rankItems
            })
        else
            exports.sGui:showInfobox(client, "e", "A kiválasztott művelethez nincs jogosultságod!")
            triggerClientEvent(client, "stopGroupLoader", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #32 - sGroups @sourceS:1098")
    end
end)

addEvent("moveRankDown", true)
addEventHandler("moveRankDown", getRootElement(), function(group, rank)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and playerGroups[client][group].isLeader == 1 then
            local rankNames = groupList[group].rankNames[rank]
            local rankColors = groupList[group].rankColors[rank]
            local rankSalaries = groupList[group].rankSalaries[rank]
            local rankPermissions = groupList[group].rankPermissions[rank]
            local rankSkins = groupList[group].rankSkins[rank]
            local rankItems = groupList[group].rankItems[rank]
            
            for i = 1, #groupList[group].rankNames do
                if i == rank then
                    rankPosition = i + 1
                end
            end

            table.remove(groupList[group].rankNames, rank)
            table.remove(groupList[group].rankColors, rank)
            table.remove(groupList[group].rankSalaries, rank)
            table.remove(groupList[group].rankPermissions, rank)
            table.remove(groupList[group].rankSkins, rank)
            table.remove(groupList[group].rankItems, rank)

            table.insert(groupList[group].rankNames, rankPosition, rankNames)
            table.insert(groupList[group].rankColors, rankPosition, rankColors)
            table.insert(groupList[group].rankSalaries, rankPosition, rankSalaries)
            table.insert(groupList[group].rankPermissions, rankPosition, rankPermissions)
            table.insert(groupList[group].rankSkins, rankPosition, rankSkins)
            table.insert(groupList[group].rankItems, rankPosition, rankItems)

            exports.sConnection:dbUpdate("groups", {
                ["rankNames"] = toJSON(groupList[group].rankNames),
                ["rankColors"] = toJSON(groupList[group].rankColors),
                ["rankSalaries"] = toJSON(groupList[group].rankSalaries),
                ["rankPermissions"] = toJSON(groupList[group].rankPermissions),
                ["rankSkins"] = toJSON(groupList[group].rankSkins),
                ["rankItems"] = toJSON(groupList[group].rankItems)
            }, {groupPrefix = group})

            local groupMembers = getGroupMembers(group)
            triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, group, {
                ["ranks"] = groupList[group].rankNames,
                ["rankColors"] = groupList[group].rankColors,
                ["salaries"] = groupList[group].rankSalaries,
                ["rankPermissions"] = groupList[group].rankPermissions,
                ["rankSkins"] = groupList[group].rankSkins,
                ["rankItems"] = groupList[group].rankItems
            })
        else
            exports.sGui:showInfobox(client, "e", "A kiválasztott művelethez nincs jogosultságod!")
            triggerClientEvent(client, "stopGroupLoader", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #33 - sGroups @sourceS:1156")
    end
end)

addEvent("moveRankUp", true)
addEventHandler("moveRankUp", getRootElement(), function(group, rank)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and playerGroups[client][group].isLeader == 1 then
            local rankNames = groupList[group].rankNames[rank]
            local rankColors = groupList[group].rankColors[rank]
            local rankSalaries = groupList[group].rankSalaries[rank]
            local rankPermissions = groupList[group].rankPermissions[rank]
            local rankSkins = groupList[group].rankSkins[rank]
            local rankItems = groupList[group].rankItems[rank]
            
            for i = 1, #groupList[group].rankNames do
                if i == rank then
                    rankPosition = i - 1
                end
            end

            table.remove(groupList[group].rankNames, rank)
            table.remove(groupList[group].rankColors, rank)
            table.remove(groupList[group].rankSalaries, rank)
            table.remove(groupList[group].rankPermissions, rank)
            table.remove(groupList[group].rankSkins, rank)
            table.remove(groupList[group].rankItems, rank)

            table.insert(groupList[group].rankNames, rankPosition, rankNames)
            table.insert(groupList[group].rankColors, rankPosition, rankColors)
            table.insert(groupList[group].rankSalaries, rankPosition, rankSalaries)
            table.insert(groupList[group].rankPermissions, rankPosition, rankPermissions)
            table.insert(groupList[group].rankSkins, rankPosition, rankSkins)
            table.insert(groupList[group].rankItems, rankPosition, rankItems)

            exports.sConnection:dbUpdate("groups", {
                ["rankNames"] = toJSON(groupList[group].rankNames),
                ["rankColors"] = toJSON(groupList[group].rankColors),
                ["rankSalaries"] = toJSON(groupList[group].rankSalaries),
                ["rankPermissions"] = toJSON(groupList[group].rankPermissions),
                ["rankSkins"] = toJSON(groupList[group].rankSkins),
                ["rankItems"] = toJSON(groupList[group].rankItems)
            }, {groupPrefix = group})

            local groupMembers = getGroupMembers(group)
            triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, group, {
                ["ranks"] = groupList[group].rankNames,
                ["rankColors"] = groupList[group].rankColors,
                ["salaries"] = groupList[group].rankSalaries,
                ["rankPermissions"] = groupList[group].rankPermissions,
                ["rankSkins"] = groupList[group].rankSkins,
                ["rankItems"] = groupList[group].rankItems
            })
        else
            exports.sGui:showInfobox(client, "e", "A kiválasztott művelethez nincs jogosultságod!")
            triggerClientEvent(client, "stopGroupLoader", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #34 - sGroups @sourceS:1214")
    end
end)

function getPlayerByCharID(id)
    local player = false
    for k, v in pairs(getElementsByType("player")) do
        if getElementData(v, "loggedIn") and id == getElementData(v, "char.ID") then
            player = v
            break 
        end
    end
    return player
end

addEvent("editGroupVehicleMembers", true)
addEventHandler("editGroupVehicleMembers", getRootElement(), function(group, vehicle, members)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and (playerGroups[client][group].isLeader == 1 or getPlayerPermissionInGroup(client, group, "manageKeysVehicle")) then
            local characterIds = {}

            for playerId, playerData in pairs(groupList[group].members) do
                for i = 1, #members do
                    if playerId == members[i] then
                        characterIds[playerId] = playerData[7]
                    end
                end
            end

            for key, value in pairs(groupList[group].vehicleMembers[vehicle]) do
                groupList[group].vehicleMembers[vehicle][key] = false
                if getPlayerByCharID(key) then
                    requestPlayerGroups(getPlayerByCharID(key))
                end
            end

            for playerId, characterId in pairs(characterIds) do
                groupList[group].vehicleMembers[vehicle][characterId] = true

                if isPlayerInGroup(getPlayerByCharID(characterId), group) then
                    groupList[group].vehicleMembers[vehicle][characterId] = true
                end

                if getPlayerByCharID(characterId) then
                    requestPlayerGroups(getPlayerByCharID(characterId))
                end
            end

            exports.sConnection:dbUpdate("groups", {
                ["vehicleMembers"] = toJSON(groupList[group].vehicleMembers)
            }, {groupPrefix = group})

            local groupMembers = getGroupMembers(group)
            triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, group, {
                ["vehicleMembers"] = groupList[group].vehicleMembers
            })
        else
            exports.sGui:showInfobox(client, "e", "A kiválasztott művelethez nincs jogosultságod!")
            triggerClientEvent(client, "stopGroupLoader", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #35 - sGroups @sourceS:1253")
    end
end)

addEvent("requestVehicleGroupData", true)
addEventHandler("requestVehicleGroupData", getRootElement(), function(group, vehicle)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] then
            dbQuery(function(qh, client)
                local result = dbPoll(qh, 0)
                local temp = {}

                if result[1].customPlate then
                    plate = result[1].customPlate
                else
                    plate = result[1].plate
                end

                if result[1].driveType == "set" then
                    driveType = "Állítható Meghajtás"
                elseif result[1].driveType == "handling" then
                    driveType = getModelHandling(result[1].modelId).driveType
                else
                    driveType = result[1].driveType
                end

                temp.plate = plate
                temp.impounded = result[1].impounded
                local eng = result[1].engine == 1 and 2 or 0
                temp.engine = eng
                temp.batteryCharge = 1
                temp.batteryRate = 0
                temp.odometer = result[1].distance
                temp.fuelLevel = result[1].fuel
                temp.fuelType = result[1].fuelType
                temp.tankSize = exports.sVehicles:getTankSize(result[1].modelId)
                temp.isElectric = exports.sSpeedo:isVehicleElectric(result[1].customModel)
                temp.forGroup = true
                temp.driveType = driveType

                local performanceTuning = fromJSON(result[1].performanceTuning)

                for key, value in pairs(performanceTuning) do
                    temp["performance." .. key] = value
                end

                temp.rideTuning = result[1].airride

                if result[1].nitro > 0 then
                    local nitroLevel = fromJSON(result[1].nitroLevel)

                    temp.nosFillType = nitroLevel[1]
                    temp.nosLevel = nitroLevel[2]
                end

                triggerClientEvent(client, "gotGroupVehicleDatas", client, vehicle, temp)
            end, {client}, connection, "SELECT * FROM vehicles WHERE dbID = ?", groupList[group].vehicles[vehicle][3])
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #36 - sGroups @sourceS:1307")
    end
end)

addEvent("editGroupInteriorMembers", true)
addEventHandler("editGroupInteriorMembers", getRootElement(), function(group, interior, members)
    if client == source then
        if playerGroups[client] and playerGroups[client][group] and (playerGroups[client][group].isLeader == 1 or getPlayerPermissionInGroup(client, group, "manageKeysInterior")) then
            local characterIds = {}

            for playerId, playerData in pairs(groupList[group].members) do
                for i = 1, #members do
                    if playerId == members[i] then
                        characterIds[playerId] = playerData[7]
                    end
                end
            end

            for key, value in pairs(groupList[group].interiorMembers[interior]) do
                groupList[group].interiorMembers[interior][key] = false

                if getPlayerByCharID(key) then
                    requestPlayerGroups(getPlayerByCharID(key))
                end
            end

            for playerId, characterId in pairs(characterIds) do
                groupList[group].interiorMembers[interior][characterId] = true
                if isPlayerInGroup(getPlayerByCharID(characterId), group) then
                    groupList[group].interiorMembers[interior][characterId] = true
                end
                if getPlayerByCharID(characterId) then
                    requestPlayerGroups(getPlayerByCharID(characterId))
                end
            end

            exports.sConnection:dbUpdate("groups", {
                ["interiorMembers"] = toJSON(groupList[group].interiorMembers)
            }, {groupPrefix = group})

            local groupMembers = getGroupMembers(group)
            triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, group, {
                ["interiorMembers"] = groupList[group].interiorMembers
            })

        else
            exports.sGui:showInfobox(client, "e", "A kiválasztott művelethez nincs jogosultságod!")
            triggerClientEvent(client, "stopGroupLoader", client)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #37 - sGroups @sourceS:1346")
    end
end)

local _addCommandHandler = addCommandHandler
function addCommandHandler(cmd, ...)
	if type(cmd) == "string" then
		_addCommandHandler(cmd, ...)
	else
		for k, v in ipairs(cmd) do
			_addCommandHandler(v, ...)
		end
	end
end

addCommandHandler({"addgroup", "setplayergroup", "setplayerfaction", "setgroup", "addplayergroup", "addplayerfaction"}, function(client, commandName, targetPlayer, group)
    if exports.sPermission:hasPermission(client, "addgroup") then
        if not (targetPlayer and group) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Játékos Név / ID] [Frakció]", client, 255, 255, 255, true)
        else
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if isElement(targetPlayer) then
                if groupList[group] then
                    local adminName = getElementData(client, "acc.adminNick")
                    local title = exports.sAdministration:getPlayerAdminTitle(client)

                    if isPlayerInGroup(targetPlayer, group) then
                        exports.sGui:showInfobox(client, "e", "A kiválasztott játékos már a frakció tagja!")
                        return
                    end

                    outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]Sikeresen felvetted a kiválasztott játékost a frakcióba! [color=sightblue](" .. targetName .. " | " .. getGroupName(group) .. ")", client)
                    outputChatBox("[color=sightgreen][SightMTA]: " .. title .. " " .. adminName .. "[color=hudwhite] felvett egy frakcióba. [color=sightblue](" .. getGroupName(group) .. ")", targetPlayer)

                    table.insert(groupList[group].members, {getElementData(targetPlayer, "visibleName"):gsub("_", " "), 1, false, targetPlayer, getRealTime().timestamp, getRealTime().timestamp, getElementData(targetPlayer, "char.ID")})
                    dbExec(connection, "INSERT INTO groupmembers (characterId, groupPrefix, added, promoted) VALUES (?, ?, ?, ?)", getElementData(targetPlayer, "char.ID"), group, getRealTime().timestamp, getRealTime().timestamp)
        
                    local groupMembers = getGroupMembers(group)
                    triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, group, {["gotMembers"] = groupList[group].members})

                    local characterId = getElementData(client, "char.ID") or false

                    if characterId then
                        dbQuery(function(qh, client)
                            local result = dbPoll(qh, 0)
                            local temp = {}
            
                            for i = 1, #result do
                                local groupName = exports.sGroups:getGroupName(result[i].groupPrefix)
                                table.insert(temp, {result[i].groupPrefix, groupName})
                            end

                            triggerClientEvent(client, "gotPlayerGroupList", client, temp)
                        end, {client}, connection, "SELECT * FROM groupmembers WHERE characterId = ?", characterId)
                    end

                    requestPlayerGroups(targetPlayer)
                    refreshPlayerPermissions(targetPlayer)
                else
                    exports.sGui:showInfobox(client, "e", "Nem létezik ilyen frakció!")
                end
            end
        end
    end
end)

addCommandHandler({"removegroup", "removeplayergroup", "removeplayerfaction"}, function(client, commandName, targetPlayer, group)
    if exports.sPermission:hasPermission(client, "removegroup") then
        if not (targetPlayer and group) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Játékos Név / ID] [Frakció]", client, 255, 255, 255, true)
        else
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if isElement(targetPlayer) then
                if groupList[group] then
                    local adminName = getElementData(client, "acc.adminNick")
                    local title = exports.sAdministration:getPlayerAdminTitle(client)
                    
                    if isPlayerInGroup(targetPlayer, group) then
                        for key, value in pairs(groupList[group].members) do
                            if value[7] == getElementData(targetPlayer, "char.ID") then
                                player = key
                            end
                        end

                        outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]Sikeresen kirúgtad a kiválasztott játékost a frakcióból! [color=sightblue](" .. targetName .. " | " .. getGroupName(group) .. ")", client)
                        outputChatBox("[color=sightgreen][SightMTA]: " .. title .. " " .. adminName .. "[color=hudwhite] kirúgott egy frakcióból. [color=sightblue](" .. getGroupName(group) .. ")", targetPlayer)

                        playerGroups[targetPlayer][group] = nil

                        dbExec(connection, "DELETE FROM groupmembers WHERE characterId = ? AND groupPrefix = ?", getElementData(targetPlayer, "char.ID"), group)
                        table.remove(groupList[group].members, player)
                        local groupMembers = getGroupMembers(group)

                        triggerClientEvent(groupMembers, "refreshPlayerGroupData", client, group, {["gotMembers"] = groupList[group].members})
                        triggerClientEvent(client, "gotPlayerGroupMembership", client, playerGroups)
                        
                        local characterId = getElementData(client, "char.ID") or false

                        if characterId then
                            dbQuery(function(qh, client)
                                local result = dbPoll(qh, 0)
                                local temp = {}
                
                                for i = 1, #result do
                                    local groupName = exports.sGroups:getGroupName(result[i].groupPrefix)
                                    table.insert(temp, {result[i].groupPrefix, groupName})
                                end

                                triggerClientEvent(client, "gotPlayerGroupList", client, temp)
                            end, {client}, connection, "SELECT * FROM groupmembers WHERE characterId = ?", characterId)
                        end

                        requestPlayerGroups(targetPlayer)
                        refreshPlayerPermissions(targetPlayer)
                    else
                        exports.sGui:showInfobox(client, "e", "A kiválasztott játékos nem a frakció tagja!")
                    end
                else
                    exports.sGui:showInfobox(client, "e", "Nem létezik ilyen frakció!")
                end
            end
        end
    end
end)

addCommandHandler({"setleader", "setgroupleader", "setplayerleader"}, function(client, commandName, targetPlayer, group, state)
    if exports.sPermission:hasPermission(client, "setleader") then
        local state = tonumber(state)
        if not (targetPlayer and group and state) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Játékos Név / ID] [Frakció] [0 - Elvétel | 1 - Adás]", client, 255, 255, 255, true)
        else
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if isElement(targetPlayer) then
                if groupList[group] then
                    local adminName = getElementData(client, "acc.adminNick")
                    local title = exports.sAdministration:getPlayerAdminTitle(client)
                    
                    if isPlayerInGroup(targetPlayer, group) then
                        if state == 1 or state == 0 then
                            local player = false
                            for key, value in pairs(groupList[group].members) do
                                if value[7] == getElementData(targetPlayer, "char.ID") then
                                    player = key
                                end
                            end
                            if player then
                            
                                groupList[group].members[player][3] = state == 1
                                playerGroups[targetPlayer][group].isLeader = 1
                                dbExec(connection, "UPDATE groupmembers SET isLeader = ? WHERE groupPrefix = ? AND characterId = ?", state, group, getElementData(targetPlayer, "char.ID"))

                                local groupMembers = getGroupMembers(group)
                                triggerClientEvent(groupMembers, "refreshPlayerGroupData", targetPlayer, group, {
                                    ["gotMembers"] = groupList[group].members,
                                    ["isLeader"] = playerGroups[targetPlayer][group].isLeader
                                })

                                outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]Sikeresen leader jogot adtál a kiválasztott játékosnak! [color=sightblue](" .. targetName .. " | " .. getGroupName(group) .. ")", client)
                                outputChatBox("[color=sightgreen][SightMTA]: " .. title .. " " .. adminName .. "[color=hudwhite] leader jogot adott neked egy frakcióba. [color=sightblue](" .. getGroupName(group) .. ")", targetPlayer)
                            
                                requestPlayerGroups(targetPlayer)
                                refreshPlayerPermissions(targetPlayer)
                            end
                        end
                    else
                        exports.sGui:showInfobox(client, "e", "A kiválasztott játékos nem a frakció tagja!")
                    end
                else
                    exports.sGui:showInfobox(client, "e", "Nem létezik ilyen frakció!")
                end
            end
        end
    end
end)

function isPlayerInGroup(client, group)
    if playerGroups[client] and playerGroups[client][group] then
        return true
    end

    return false
end

function getGroupSkins(groupId)
    return groupSkins[groupId]
end

function getPlayerGroupSkins(client)
    local groupSkins = {}
    if playerGroups[client] then
        local groups = getGroups()
        for k, v in pairs(groups) do
			if exports.sGroups:isPlayerInGroup(client, k) and not groups[k].legal then
                local rankName, salary, rank = getPlayerRank(k, client)
                local skins = groupList[k].rankSkins[rank]
                if playerGroups[client][k].isLeader and playerGroups[client][k].isLeader == 1 then
                    skins = {}
                    for i = 1, groupList[k].skins do
                        table.insert(skins, {k, i})
                    end
                end
                for i = 1, #skins do
                    if skins[i] then
                        table.insert(groupSkins, {k, i})
                    end
                end
            end
        end
    end
    return groupSkins
end

function getGroupMembers(group)
    if groupList[group] and groupList[group].members then
        local members = {}

        for key, value in pairs(groupList[group].members) do
            if isElement(value[4]) then
                table.insert(members, value[4])
            end
        end
        return members
    end

    return false
end

function getPlayerPermission(element, permission)
    return playerPermissions[element][permission] and playerPermissions[element][permission][1]
end

function getPlayerPermissionInGroup(element, prefix, permission)
    local result = false

    if playerPermissions[element][permission] then
        for i = 1, #playerPermissions[element][permission] do
            if playerPermissions[element][permission][i] == prefix then
                result = true
                break
            elseif playerGroups[element][prefix].isLeader == 1 then
                result = true
                break
            end
        end
    end

    return result
end

function getPlayerVehiclePermission(sourceElement, vehicleElement)
    local result = false

    local charID = getElementData(sourceElement, "char.ID")
    local vehID = getElementData(vehicleElement, "vehicle.dbID")
    local group = getElementData(vehicleElement, "vehicle.group")
    
    if group and groupList[group] and groupList[group].vehicleMembers then
        local members = groupList[group].vehicleMembers

        if members[vehID][charID] or playerGroups[sourceElement][group].isLeader == 1 then
            return true
        end
    end
    return false
end

local dutyDetails = {}

function getPlayerRank(groupId, playerElement)
    local playerData = playerGroups[playerElement][groupId] or false
    if playerData then
        return groupList[groupId].rankNames[playerData.rank], (groupList[groupId].rankSalaries[playerData.rank] or 0), playerData.rank
    end
end

function getGroupRankName(groupId, rankIndex)
    return groupList[groupId].rankNames[rankIndex]
end

function sendGroupMessage(playerElement, group, color, prefix, message, sound)
    triggerClientEvent("gotGroupMessage", playerElement, group, color, prefix, message, sound)
end

addEvent("requestMyDutyData", true)
addEventHandler("requestMyDutyData", root,
    function (dutyMarker)
        if getElementData(client, "inDuty") then
            local groupData = groupList[dutyMarker]

            groupList[dutyMarker].dutyCount = groupList[dutyMarker].dutyCount - 1
            setElementData(client, "wrenchState", false)
            exports.sItems:takeDutyItems(client, getElementData(client, "inDuty"))

            setElementData(client, "inDuty", false)

            setElementData(client, "groupSkin", false)
            setElementData(client, "permGroupSkin", false)
            
            dutyDetails[client] = nil

            triggerClientEvent("groupDutySound", client)
            triggerClientEvent(client, "showInfobox", client, "i", "Leadtad a szolgálatot.")
            exports.sGroupcall:registerPlayerDuty(client, dutyMarker, false)
            exports.sChat:localAction(client, "leadta a szolgálatot.")
        else
            local inGroup = false

            for k, v in pairs(playerGroups[client]) do
                if k == dutyMarker then
                    inGroup = true
                    
                    break
                end
            end

            if inGroup then
                local groupData = groupList[dutyMarker]
                local myGroupData = {}

                for k, v in pairs(groupList[dutyMarker].members) do
                    if v[7] == getElementData(client, "char.ID") then
                        myGroupData = v
                        
                        break
                    end
                end

                if myGroupData then
                    local availableSkins = {}
                    local availableItems = {}

                    if myGroupData[3] then
                        for i = 1, groupData.skins do
                            table.insert(availableSkins, i)
                        end

                        for k, v in pairs(groupData.items) do
                            availableItems[k] = v[1]
                        end
                    else
                        for k, v in pairs(groupData.rankSkins[myGroupData[2]]) do
                            table.insert(availableSkins, k)
                        end

                        for k, v in pairs(groupData.rankItems[myGroupData[2]]) do
                            availableItems[k] = groupData.items[k][1]
                        end
                    end

                    triggerClientEvent(client, "gotDutyData", client, dutyMarker, availableSkins, availableItems)
                end
            end
        end
    end
)

addEvent("tryToGroupDuty", true)
addEventHandler("tryToGroupDuty", root,
    function (group, dutySkin, items)
        if source ~= client then
            return
        end

        local groupData = groupList[group]

        if groupData then
            if dutySkin then
                setElementData(client, "groupSkin", string.upper(group) .. dutySkin)
            else
                setElementModel(client, getElementData(client, "char.skin"))
            end

            if items then
                for k, v in pairs(items) do
                    local data1, data2, data3 = group, false, "duty:" .. group

                    if k == 127 then
                        data1 = group
                    end

                    exports.sItems:giveItem(client, k, v, false, data1, data2, data3)
                end
            end

            groupList[group].dutyCount = groupList[group].dutyCount + 1

            setElementData(client, "inDuty", group)
            dutyDetails[client] = group


            triggerClientEvent("groupDutySound", client, true)
            triggerClientEvent(client, "showInfobox", client, "i", "Szolgálatba álltál.")
            exports.sGroupcall:registerPlayerDuty(client, group, true)
            exports.sChat:localAction(client, "szolgálatba állt.")
        end
    end
)

addCommandHandler("gov", 
    function(sourcePlayer, commandName, groupPrefix, ...)
        local message = utf8.gsub(table.concat({...}, " "), "#%x%x%x%x%x%x", "")

        if groupPrefix and message then
            for k, v in pairs(playerGroups[sourcePlayer]) do
                if k == groupPrefix then
                    if groupList[groupPrefix].gov and getPlayerPermissionInGroup(sourcePlayer, groupPrefix, "gov") then
                        outputChatBox(groupList[groupPrefix].gov, root, 255, 255, 255, true)
                        outputChatBox(message, root, 255, 255, 255, true)
                    end
                end
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/"..commandName.." [Frakció Prefix] [Üzenet]", sourcePlayer, 255, 255, 255, true)
        end
    end
)

local ongoingSearches = {}
local blipElement = {}

addCommandHandler("lenyomoz", function(sourcePlayer, commandName, telephoneNumber)
    if not exports.sGroups:getPlayerPermission(sourcePlayer, "lenyomoz") then
        return
    end

    if not ongoingSearches[sourcePlayer] then
        ongoingSearches[sourcePlayer] = {false, nil}
    end

    if ongoingSearches[sourcePlayer][1] then
        outputChatBox("[color=sightblue][SightMTA]: [color=hudwhite]Sikeresen leállítottad a keresést!", sourcePlayer)
        triggerClientEvent("sendMessageToAdmins", sourcePlayer, "[color=sightblue]" .. getElementData(sourcePlayer, "char.name"):gsub("_", " ") .. "[color=hudwhite] nevű játékos leállította a lenyomozást!")        
        local targetPlayer = ongoingSearches[sourcePlayer][2]
        if targetPlayer and blipElement[targetPlayer] and isElement(blipElement[targetPlayer].blip) then
            destroyElement(blipElement[targetPlayer].blip)
            blipElement[targetPlayer] = nil
        end
        ongoingSearches[sourcePlayer] = {false, nil}
        return
    end

    local telephoneNumber = tonumber(telephoneNumber)

    if not telephoneNumber then
        outputChatBox("[color=sightred][SightMTA]: [color=hudwhite]/"..commandName.." [Telefonszám]", sourcePlayer, 255, 255, 255, true)
        return
    end

    local playerElement = exports.sMobile:findPlayerForPhone(telephoneNumber)

    if playerElement then
        outputChatBox("[color=sightblue][SightMTA]: [color=hudwhite]Sikeresen elindítottad a játékos keresését!", sourcePlayer)
        triggerClientEvent("sendMessageToAdmins", sourcePlayer, "[color=sightblue]" .. getElementData(sourcePlayer, "char.name"):gsub("_", " ") .. "[color=hudwhite] nevű játékos használta a lenyomoz parancsot!")
        ongoingSearches[sourcePlayer] = {true, playerElement}
        local playerPosition = {getElementPosition(playerElement)}
        blipElement[playerElement] = {}
        blipElement[playerElement].blip = createBlipAttachedTo(playerElement, 22, 16, 243, 90, 90, 255, 0, 16383, sourcePlayer)
        setElementData(blipElement[playerElement].blip, "tooltipText", "Lenyomozott játékos (("..getElementData(playerElement, "visibleName"):gsub("_", " ").."))")
        blipElement[playerElement].finder = sourcePlayer
    else
        outputChatBox("[color=sightred][SightMTA]: [color=hudwhite]Nem található játékos!", sourcePlayer)
    end
end)

addEventHandler("onPlayerQuit", resourceRoot, function(quitType)
    local normalNames = {
        ["Unknown"] = "Ismeretlen",
        ["Quit"] = "Kilépett",
        ["Kicked"] = "Kikickelték",
        ["Banned"] = "Kibannolták",
        ["Bad Connection"] = "Rossz kapcsolat",
        ["Timed out"] = "Crash"
    }
    if blipElement[source] and blipElement[source].blip and isElement(blipElement[source].blip) then
        local finder = blipElement[source].finder
        if isElement(finder) then
            outputChatBox("[color=sightred][SightMTA]: [color=hudwhite]Megszakadt a kapcsolat, amivel bemérhetted volna a játékost! [".. normalNames[quitType] .."]", finder)
        end
        destroyElement(blipElement[source].blip)
        blipElement[source] = nil
    end

    for player, searchData in pairs(ongoingSearches) do
        if searchData[2] == source then
            ongoingSearches[player] = {false, nil}
        end
    end
end)

function removeBlipOnPhoneDrop(targetPlayer)
    if blipElement[targetPlayer] and blipElement[targetPlayer].blip and isElement(blipElement[targetPlayer].blip) then
        local finder = blipElement[targetPlayer].finder
        if isElement(finder) then
            outputChatBox("[color=sightred][SightMTA]: [color=hudwhite]A játékos kidobta a telefont, a keresés megszakadt!", finder)
        end
        destroyElement(blipElement[targetPlayer].blip)
        blipElement[targetPlayer] = nil
    end

    for player, searchData in pairs(ongoingSearches) do
        if searchData[2] == targetPlayer then
            ongoingSearches[player] = {false, nil}
        end
    end
end

addCommandHandler("alnev", 
    function(sourcePlayer, commandName, ...)
        if not exports.sGroups:getPlayerPermission(sourcePlayer, "alnev") and not exports.sPermission:hasPermission(sourcePlayer, "falnev") then
            return
        end
        local message = utf8.gsub(table.concat({...}, " "), "#%x%x%x%x%x%x", "")

        if #message > 1 then
            setElementData(sourcePlayer, "fakeNameState", true, false)
            setElementData(sourcePlayer, "visibleName", message)

            outputChatBox("[color=sightgreen][SightMTA - Frakció]: [color=hudwhite]Sikeresen használtad az álnév parancsot!", sourcePlayer, 255, 255, 255, true)
            triggerClientEvent("sendMessageToAdmins", sourcePlayer, "[color=sightblue]" .. getElementData(sourcePlayer, "char.name"):gsub("_", " ") .. "[color=hudwhite] nevű játékos használta az álnév parancsot! [color=sightgreen](" .. message:gsub("_", " ") .. ")")
        else
            if getElementData(sourcePlayer, "fakeNameState") then
                setElementData(sourcePlayer, "visibleName", getElementData(sourcePlayer, "char.name"))
                setElementData(sourcePlayer, "fakeNameState", false, false)

                outputChatBox("[color=sightred][SightMTA - Frakció]: [color=hudwhite]Sikeresen kikapcsoltad az álnevet!", sourcePlayer, 255, 255, 255, true)
            else
                outputChatBox("[color=sightred][SightMTA - Frakció]: [color=hudwhite]/"..commandName.." [Név [(6-24 kar.)]", sourcePlayer, 255, 255, 255, true)
            end
        end
    end
)

adminCols = {
    center = nil,
    points = {},
    colShape = nil
}
-- // noffy 2025.04.01 // top5 quality of life command
addCommandHandler("admincolcreate", function(sourcePlayer, command, arg)
    if arg == "center" then
        local x, y, _ = getElementPosition(sourcePlayer)
        adminCols.center = {x, y}
        adminCols.points = {}
        if adminCols.colShape then destroyElement(adminCols.colShape) end
        adminCols.colShape = nil
        outputChatBox("[color=sightgreen][SightMTA - Colcreator]: [color=hudwhite]Középpont beállítva: {" .. x .. ", " .. y .. "}", sourcePlayer, 0, 255, 0)
    elseif arg == "point" then
        if not adminCols.center then
            outputChatBox("[color=sightred][SightMTA - Colcreator]: [color=hudwhite]Először állítsd be a középpontot: /admincolcreate center", sourcePlayer, 255, 0, 0)
            return
        end
        local x, y, _ = getElementPosition(sourcePlayer)
        table.insert(adminCols.points, {x, y})
        outputChatBox("[color=sightblue][SightMTA - Colcreator]: [color=hudwhite]Pont hozzáadva: {" .. x .. ", " .. y .. "}", sourcePlayer, 0, 255, 255)
        updateColPolygon()
    elseif arg == "save" then
        if #adminCols.points < 3 then
            outputChatBox("[color=sightred][SightMTA - Colcreator]: [color=hudwhite]Legalább 3 pont szükséges!", sourcePlayer, 255, 0, 0)
            return
        end
        outputConsole("ColPolygon adatok:")
        outputConsole("Középpont: {" .. adminCols.center[1] .. ", " .. adminCols.center[2] .. "}")
        outputConsole("Pontok:")
        for _, point in ipairs(adminCols.points) do
            outputConsole("{" .. point[1] .. ", " .. point[2] .. "}")
        end
        outputChatBox("[color=sightgreen][SightMTA - Colcreator]: [color=hudwhite]ColPolygon mentve és kiírva konzolba.", sourcePlayer, 0, 255, 0)
    end
end)

function updateColPolygon()
    if adminCols.colShape then destroyElement(adminCols.colShape) end
    if #adminCols.points >= 3 then
        adminCols.colShape = createColPolygon(adminCols.center[1], adminCols.center[2], unpack(flattenPoints(adminCols.points)))
    end
end
--]]
local restrictedAirspaces = {
    ["Katonaság"] = {
        center = {-1516.427734375, 325.9580078125},
        restrictedPoints = {
            {-1721.396484375, 240.58984375},
            {-1720.966796875, 261.408203125},
            {-1734.5732421875, 263.3974609375},
            {-1712.4130859375, 292.1494140625},
            {-1681.8203125, 323.490234375},
            {-1636.9541015625, 364.6640625},
            {-1602.470703125, 401.21484375},
            {-1571.947265625, 440.8173828125},
            {-1552.193359375, 473.4677734375},
            {-1547.462890625, 481.44140625},
            {-1547.01171875, 493.91796875},
            {-1519.52734375, 493.6748046875},
            {-1518.986328125, 482.107421875},
            {-1464.548828125, 543.8818359375},
            {-1196.2109375, 562.88671875},
            {-1217.7490234375, 378.2724609375},
            {-1312.4794921875, 370.43359375},
            {-1313.65234375, 264.208984375},
            {-1435.1416015625, 262.5400390625},
            {-1435.990234375, 238.5341796875},
        },
    },
    ["Pénzszállító mélygarázs"] = {
        center = {-1762.71484375, 1041.103515625},
        restrictedPoints = {
            {-1782.0693359375, 963.9091796875},
            {-1726.3525390625, 964.0126953125},
            {-1726.78125, 1090.6796875},
            {-1781.525390625, 1090.6396484375},
        },
    },
    ["Országos-Katasztrófavédelmi Főigazgatóság"] = {
        center = {-2060.8896484375, 71.1845703125},
        restrictedPoints = {
            {-2097.1279296875, 100.11328125},
            {-2097.1767578125, 39.9365234375},
            {-2017.484375, 38.1162109375},
            {-2016.890625, 98.19140625},
        },
    },
    ["San-Fierro Korház"] = {
        center = {-2619.248046875, 636.2314453125},
        restrictedPoints = {
            {-2537.357421875, 697.6455078125},
            {-2537.1875, 578.716796875},
            {-2740.513671875, 578.708984375},
            {-2739.6982421875, 697.076171875},
        },
    },
    ["Nemzeti Adó- és Vámhivatal"] = {
        center = {-1626.228515625, 689.4169921875},
        restrictedPoints = {
            {-1571.91015625, 646.19921875},
            {-1571.36328125, 719.01953125},
            {-1701.525390625, 718.47265625},
            {-1701.400390625, 679.896484375},
            {-1681.8798828125, 679.9130859375},
            {-1661.5341796875, 676.244140625},
            {-1641.1318359375, 676.216796875},
            {-1641.3486328125, 646.4482421875},
        },
    },
    ["Tierra Robada Korház"] = {
        center = {-1514.6220703125, 2522.0537109375},
        restrictedPoints = {
            {-1496.3134765625, 2537.3837890625},
            {-1533.0830078125, 2537.3837890625},
            {-1533.0830078125, 2517.2939453125},
            {-1528.0830078125, 2516.677734375},
            {-1528.2548828125, 2509.1640625},
            {-1501.2919921875, 2509.2587890625},
            {-1501.2001953125, 2516.841796875},
            {-1496.3134765625, 2517.29296875},
        },
    },
    ["Montgomery Korház"] = {
        center = {1241.52734375, 313.4453125},
        restrictedPoints = {
            {1231.72265625, 339.4892578125},
            {1211.50390625, 294.9912109375},
            {1251.7001953125, 276.990234375},
            {1272.1845703125, 321.9814453125},
        },
    },
    ["Dillimore Rendőrség"] = {
        center = {618.3447265625, -586.3291015625},
        restrictedPoints = {
            {643.9453125, -608.5966796875},
            {643.7646484375, -613.6865234375},
            {607.2001953125, -613.83984375},
            {607.1572265625, -582.9951171875},
            {602.06640625, -582.96484375},
            {602.06640625, -540.390625},
            {631.552734375, -540.2294921875},
            {631.650390625, -583.853515625},
            {632.2548828125, -594.04296875},
            {632.986328125, -597.7119140625},
            {637.056640625, -603.9794921875},
        },
    },
    ["Sight-City Aranyraktár"] = {
        center = {579.3779296875, -1631.4921875},
        restrictedPoints = {
            {616.982421875, -1602.5498046875},
            {619.2412109375, -1666.8876953125},
            {553.966796875, -1658.341796875},
            {553.775390625, -1603.71484375},
        },
    },
    ["Los Santos Korház"] = {
        center = {1139.6279296875, -1327.728515625},
        restrictedPoints = {
            {1185.3857421875, -1384.8310546875},
            {1185.599609375, -1291.0458984375},
            {1107.41796875, -1291.3681640625},
            {1107.3291015625, -1310.181640625},
            {1089.796875, -1310.23046875},
            {1089.5947265625, -1329.5966796875},
            {1082.107421875, -1330.01171875},
            {1082.216796875, -1350.3515625},
            {1080.2685546875, -1350.4609375},
            {1080.1640625, -1357.5380859375},
            {1082.0625, -1357.5576171875},
            {1082.09375, -1362.453125},
            {1089.44921875, -1362.0927734375},
            {1089.4873046875, -1335.46484375},
            {1131.34765625, -1335.5107421875},
            {1131.0185546875, -1347.78515625},
            {1137.0703125, -1347.40625},
            {1137.21875, -1369.5830078125},
            {1150.48046875, -1369.2705078125},
            {1150.3681640625, -1384.7060546875},
        },
    },
    ["Mentőszolgálati Központ"] = {
        center = {1236.2255859375, -1659.7177734375},
        restrictedPoints = {
            {1289.3330078125, -1704.140625},
            {1271.05859375, -1703.970703125},
            {1271.3876953125, -1701.9287109375},
            {1163.4169921875, -1702.763671875},
            {1162.724609375, -1633.84375},
            {1160.03515625, -1633.7119140625},
            {1160.0224609375, -1589.16015625},
            {1166.5576171875, -1582.6708984375},
            {1247.849609375, -1582.0224609375},
            {1247.6767578125, -1581.353515625},
            {1266.5439453125, -1581.259765625},
            {1266.6337890625, -1582.1259765625},
            {1280.3525390625, -1582.3544921875},
            {1287.4697265625, -1589.234375},
        },
    },
    ["Városháza"] = {
        center = {1481.2763671875, -1790.10546875},
        restrictedPoints = {
            {1399.796875, -1742.9443359375},
            {1399.6435546875, -1834.9443359375},
            {1559.0498046875, -1835.1103515625},
            {1559.0478515625, -1742.79296875},
        },
    },
    ["Országos Rendőr-főkapitányság"] = {
        center = {1564.650390625, -1675.3837890625},
        restrictedPoints = {
            {1539.7587890625, -1602.439453125},
            {1608.4775390625, -1602.513671875},
            {1607.939453125, -1638.46875},
            {1603.5654296875, -1638.0517578125},
            {1577.7890625, -1637.3720703125},
            {1577.5078125, -1714.1630859375},
            {1542.7646484375, -1714.10546875},
        },
    },
    ["Terrorelhárítási Központ"] = {
        center = {1502.791015625, -1496.099609375},
        restrictedPoints = {
            {1439.8291015625, -1582.4326171875},
            {1555.6201171875, -1582.5576171875},
            {1555.5322265625, -1506.73828125},
            {1555.4931640625, -1469.400390625},
            {1546.740234375, -1470.005859375},
            {1546.7314453125, -1450.6416015625},
            {1464.8798828125, -1450.7578125},
            {1462.5029296875, -1489.8037109375},
        },
    },
    ["Nemzeti Nyomozó Iroda"] = {
        center = {2040.0205078125, -1406.9501953125},
        restrictedPoints = {
            {1997.630859375, -1449.8515625},
            {2095.4306640625, -1450.7236328125},
            {2095.322265625, -1398.9228515625},
            {2052.6669921875, -1398.9541015625},
            {2052.826171875, -1357.7373046875},
            {1997.27734375, -1358.1083984375},
        },
    },
    ["Honvédség ZERO Támaszpont"] = {
        center = {361.8515625, -91.751953125},
        restrictedPoints = {
            {343.3046875, -131.29296875},
            {366.0380859375, -131.935546875},
            {378.28125, -126.0693359375},
            {382.263671875, -117.4541015625},
            {383.75, -106.03125},
            {378.408203125, -99.57421875},
            {378.560546875, -64.5693359375},
            {343.0166015625, -64.2744140625},
        },
    },
}
local restrictedColShapes = {}
local restrictedTimers = {}

addEventHandler("onResourceStart", resourceRoot, function()
    createRestrictedAirspaces()
end)

function createRestrictedAirspaces()
    for name, data in pairs(restrictedAirspaces) do
        if data.center and data.restrictedPoints and #data.restrictedPoints >= 3 then
            local centerX, centerY = data.center[1], data.center[2]
            local flatPoints = flattenPoints(data.restrictedPoints)

            local colShape = createColPolygon(centerX, centerY, unpack(flatPoints))
            if colShape then
                restrictedColShapes[colShape] = name
            end
        end
    end
end

addEventHandler("onColShapeLeave", root, function(sourceElement, matchingDimension)
    if getElementType(sourceElement) == "player" and matchingDimension then
        local zoneName = restrictedColShapes[source]
        if zoneName then
            local playerVehicle = getPedOccupiedVehicle(sourceElement)
            if playerVehicle then
                vehicleDatas = {
                    vehicleGroupData = {isVehicleInGroup(getElementData(playerVehicle, "vehicle.dbID"))}
                }

                if vehicleDatas.vehicleGroupData[1] then
                    if isLawEnforcementGroup(vehicleDatas.vehicleGroupData[2]) then
                        return
                    end
                end

                if getVehicleType(playerVehicle) == "Plane" or getVehicleType(playerVehicle) == "Helicopter" then
                    exports.sGui:showInfobox(sourceElement, "w", "Elhagytad a védett légteret! ("..zoneName..")")
                end
            end
        end
    end
end)

addEventHandler("onColShapeHit", root, function(sourceElement, matchingDimension)
    if getElementType(sourceElement) == "player" and matchingDimension then
        local zoneName = restrictedColShapes[source]
        if zoneName then
            local playerVehicle = getPedOccupiedVehicle(sourceElement)
            local vehicleDatas

            if playerVehicle then
                vehicleDatas = {
                    vehiclePlate = getElementData(playerVehicle, "defaultPlate") or "Ismeretlen",
                    vehicleName = exports.sVehiclenames:getCustomVehicleName(getElementModel(playerVehicle)),
                    vehicleGroupData = {isVehicleInGroup(getElementData(playerVehicle, "vehicle.dbID"))}
                }
            else
                return
            end

            if vehicleDatas.vehicleGroupData[1] then
                if isLawEnforcementGroup(vehicleDatas.vehicleGroupData[2]) then
                    return
                end
            end

            if getVehicleType(playerVehicle) == "Plane" or getVehicleType(playerVehicle) == "Helicopter" then
                exports.sGui:showInfobox(sourceElement, "w", "Védett légtérbe léptél! ("..zoneName..")")
            else
                return
            end

            if getVehicleController(playerVehicle) ~= sourceElement then
                return
            end

            local restrictedTimers = {}

            local affectedPlayers = {}
            
            for _, playerElement in ipairs(getElementsByType("player")) do
                if playerElement then
                    if exports.sItems:hasItem(playerElement, 4) then
                        if getPlayerPermission(playerElement, "departmentRadio") then
                            table.insert(affectedPlayers, playerElement)
            
                            local playerID = getElementData(playerElement, "char.ID")
            
                            if not restrictedTimers[sourceElement] then
                                restrictedTimers[sourceElement] = {
                                    blipElement = {},
                                    Timer = {}
                                }
                            end
            
                            if not restrictedTimers[sourceElement].blipElement[playerID] then
                                local blip = createBlipAttachedTo(getPedOccupiedVehicle(sourceElement), 28, 2, 243, 90, 90, 255, 0, 16383, playerElement)
                                setElementData(blip, "tooltipText", "Légitérsértő (("..vehicleDatas.vehiclePlate.."))")
                                restrictedTimers[sourceElement].blipElement[playerID] = blip
                            end
            
                            if isTimer(restrictedTimers[sourceElement].Timer[playerID]) then
                                resetTimer(restrictedTimers[sourceElement].Timer[playerID])
                            else
                                restrictedTimers[sourceElement].Timer[playerID] = setTimer(function()
                                    if restrictedTimers[sourceElement] and restrictedTimers[sourceElement].blipElement[playerID] then
                                        local blip = restrictedTimers[sourceElement].blipElement[playerID]
                                        if isElement(blip) then
                                            destroyElement(blip)
                                        end
                                        restrictedTimers[sourceElement].blipElement[playerID] = nil
                                    end
                                end, 30000, 1)
                            end
                        end
                    end
                end
            end

            local alertMessage = "[color=sightgreen][SightMTA - Légtér]: [color=hudwhite]Egy jármű lépett be "..zoneName.. " védett légtérbe. Típusa: "..vehicleDatas.vehicleName.." Lajtsromjel: "..vehicleDatas.vehiclePlate
            triggerClientEvent(affectedPlayers, "gotGroupMessage", sourceElement, "department_airfield", nil, nil, alertMessage)
        end
    end
end)

local nameTables = {
    {"RING", "PF", "TAXI", "TOW", "FIX", "APMS", "BMS"}
}

addCommandHandler("jelvenyelvetel", function(sourcePlayer, commandName, targetPlayer, groupPrefix)
    if isPlayerInGroup(sourcePlayer, groupPrefix) then
        if getPlayerPermissionInGroup(sourcePlayer, groupPrefix, "badge") then
            if not (targetPlayer and groupPrefix) then
                outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Név / ID] [Frakció]", sourcePlayer, 255, 255, 255, true)
            else
                local targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
    
                if isElement(targetPlayer) then
                    local items = exports.sItems:getElementItems(targetPlayer)
                    local takenCount = 0
                    for k, v in pairs(items) do
                        if v.itemId == 206 or v.itemId == 443 then
                            if v.data3 == groupPrefix then
                                exports.sItems:takeItem(targetPlayer, "dbID", v.dbID)
                                takenCount = takenCount + 1
                            end
                        end
                    end
                    if takenCount > 0 then
                        outputChatBox("[color=sightblue][SightMTA - Jelvény]: [color=hudwhite]A kiválasztott játékostól [color=sightgreen]" .. takenCount .." [color=hudwhite]db jelvény/névkitűző elvételre került!", sourcePlayer, 255, 255, 255, true)
                    else
                        outputChatBox("[color=sightblue][SightMTA - Jelvény]: [color=hudwhite]Nem volt ilyen jelvény/névkitűző a játékosnál!", sourcePlayer, 255, 255, 255, true)
                    end
                end
            end
        end
    else
        if not groupPrefix then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Játékos] [Frakció]", sourcePlayer, 255, 255, 255, true)
        end
    end
end)

addCommandHandler({"jelvenyadas", "givebadge"}, function(sourcePlayer, commandName, groupPrefix, badgeNumber, ...)
    if isPlayerInGroup(sourcePlayer, groupPrefix) then
        if getPlayerPermissionInGroup(sourcePlayer, groupPrefix, "badge") then
            local badgeNumber = tonumber(badgeNumber)
            if groupPrefix then
                local badgePrefix = groupList[groupPrefix].badge
                if badgePrefix then
                    local rankDetails = utf8.gsub(table.concat({...}, " "), "#%x%x%x%x%x%x", "")
                    if groupList[groupPrefix].badgeEx or false then
                        exports.sItems:giveItem(sourcePlayer, 443, 1, false, badgePrefix, "" .. rankDetails, groupPrefix)
                    else
                        exports.sItems:giveItem(sourcePlayer, 206, 1, false, badgePrefix, "["..badgeNumber.."] " .. rankDetails, groupPrefix)
                    end

                    local badgeType = (groupList[groupPrefix].badgeEx or false) and "Névkitüző" or "Jelvény"
                    local embedColor = (groupList[groupPrefix].badgeEx or false) and "sightblue" or "sightgreen"

                    outputChatBox("[color=sightblue][SightMTA - Jelvény]: [color=hudwhite]Sikeresen létrehoztál egy ".. ((groupList[groupPrefix].badgeEx or false) and "névkitűzőt" or "jelvényt") .."! ["..badgePrefix.." - "..rankDetails.."]", sourcePlayer)
                    
                    local embedDatas = {
                        username = "SightMTA - ".. badgeType .."[Létrehozás]",
                        title = "Egy játékos létrehozott egy jelvényt!",
                        color = (groupList[groupPrefix].badgeEx or false) and "sightblue" or "sightgreen",
                
                        embedData = {
                            embedFields = {
                                {    
                                    name = "Játékos neve - [Account ID]",
                                    value = "```"..getElementData(sourcePlayer, "visibleName"):gsub("_", " ").." - ["..getElementData(sourcePlayer, "char.ID").."]```",
                                    inline = true
                                },
                                {
                                    name = "Frakcióneve - Prefix",
                                    value = "```"..badgePrefix.. " - "..groupPrefix.."```",
                                    inline = true
                                },
                                {
                                    name = badgeType .." neve",
                                    value = "```"..rankDetails.."```",
                                    inline = true
                                },
                                {
                                    name = badgeType .." száma",
                                    value = "```"..badgeNumber.."```",
                                    inline = true
                                },
                            },
                        },
                    }
                    exports.sAnticheat:sendEmbedMessage(embedDatas, "badgecreate")
                else
                    outputChatBox("[color=sightred][SightMTA - Jelvény]: [color=hudwhite]A frakciónak nincs beállítva jelvény előnév!, kérd egy fejlesztő segítségét!", sourcePlayer)
                end
            else
                outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Frakció] [Jelvény szám (Kitűzőnél 0!)] [Jelvény név]", sourcePlayer, 255, 255, 255, true)
            end
        end
    else
        if not groupPrefix then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Frakció] [Jelvény szám (Kitűzőnél 0!)] [Jelvény név]", sourcePlayer, 255, 255, 255, true)
        end
    end
end)

function flattenPoints(points)
    local flatTable = {}
    for _, point in ipairs(points) do
        table.insert(flatTable, point[1])
        table.insert(flatTable, point[2])
    end
    return flatTable
end

local playerBlips = {}
local coordTick = {}

addCommandHandler("sharecoords", function(sourcePlayer, commandName, ...)
    local playerGroups = getPlayerGroups(sourcePlayer)
    local selectedGroup

    if playerGroups then
        for k, v in pairs(playerGroups) do
            if isLawEnforcementGroup(k) then
                selectedGroup = k
            end
        end
    end

    if (coordTick[sourcePlayer] or 0) + 5000 > getTickCount() and not playerBlips[sourcePlayer] then
        outputChatBox("[color=sightred][SightMTA - Police]: [color=hudwhite]Nem tudsz ilyen gyorsan létrehozni új pozíció megosztást", sourcePlayer)
        return
    end

    local affectedPlayers = {}
    local addedPlayers = {}

    for _, playerElement in pairs(getElementsByType("player")) do
        local groupMember = getPlayerGroups(playerElement)
        if groupMember then
            for groupPrefix, groupData in pairs(groupMember) do
                if isLawEnforcementGroup(groupPrefix) then
                    if playerElement ~= sourcePlayer then
                        table.insert(affectedPlayers, {playerElement, groupPrefix})
                        addedPlayers[playerElement] = true
                    end
                end
            end
        end
    end

    if playerBlips[sourcePlayer] then
        for _, blipElement in pairs(playerBlips[sourcePlayer]) do
            if blipElement and isElement(blipElement) then
                destroyElement(blipElement) 
            end
        end

        local coordDetails = {sourcePlayer, "red", "Koordináta", "[color=sightblue]"..getElementData(sourcePlayer, "visibleName"):gsub("_"," ").." [color=hudwhite]törölte a megosztott GPS koordinátát."}
        for _, affectedData in pairs(affectedPlayers) do
            triggerClientEvent(affectedData[1], "gotGroupMessage", coordDetails[1], affectedData[2], coordDetails[2], coordDetails[3], coordDetails[4], "gta")
        end
        triggerClientEvent(coordDetails[1], "gotGroupMessage", coordDetails[1], selectedGroup, coordDetails[2], coordDetails[3], coordDetails[4], "gta")

        playerBlips[sourcePlayer] = nil
        return
    end

    local coordMessage = utf8.gsub(table.concat({...}, " "), "#%x%x%x%x%x%x", "")
    local coordLength = string.len(coordMessage)

    if coordLength > 0 then
        if selectedGroup then
            local coordColor = {49, 154, 215, 255}
            local blipPosition = {getElementPosition(sourcePlayer)} 

            local coordDetails = {sourcePlayer, "red", "Koordináta", "[color=sightblue]"..getElementData(sourcePlayer, "visibleName"):gsub("_"," ").." [color=hudwhite]GPS koordinátát osztott meg: [color=sightblue]"..selectedGroup.." jel ("..coordMessage..")."}
            triggerClientEvent(coordDetails[1], "gotGroupMessage", coordDetails[1], selectedGroup, coordDetails[2], coordDetails[3], coordDetails[4], "gta")

            for _, affectedData in pairs(affectedPlayers) do
                local coordBlip = createBlip(blipPosition[1], blipPosition[2], blipPosition[3] - 1, 21, 10, coordColor[1], coordColor[2], coordColor[3], coordColor[4], 0, 16383, affectedPlayer)
                setElementData(coordBlip, "tooltipText", selectedGroup .. " jel ("..getElementData(sourcePlayer, "visibleName"):gsub("_", " ").." - "..coordMessage..")")

                triggerClientEvent(affectedData[1], "gotGroupMessage", coordDetails[1], affectedData[2], coordDetails[2], coordDetails[3], coordDetails[4], "gta")

                if not playerBlips[sourcePlayer] then
                    playerBlips[sourcePlayer] = {}
                end
                table.insert(playerBlips[sourcePlayer], coordBlip)

                coordTick[sourcePlayer] = getTickCount()

                setTimer(function()
                    if isElement(coordBlip) then
                        destroyElement(coordBlip)
                    end
                    playerBlips[sourcePlayer] = nil
                end, 300000, 1)
            end
        end
    else
        outputChatBox("[color=sightred][SightMTA - Police]: [color=hudwhite]Használat: /sharecords [Indok]", sourcePlayer)
    end
end)

addEvent("selectNewRadioGroup", true)
addEventHandler("selectNewRadioGroup", root, function()
    local groups = getPlayerGroups(client)

    if not groups then
        return
    end

    local radioGroupList = {}
    for k, v in pairs(groups) do
        if groupList[k].voiceRadio then
            table.insert(radioGroupList, v.groupPrefix)
        end
    end


    local currentSelectedRadio = getElementData(client, "voiceRadioChannel")
    local nextGroup = false

    if currentSelectedRadio == false or currentSelectedRadio == nil then
        nextGroup = radioGroupList[1]
    else
        local foundIndex = nil
        for i, prefix in ipairs(radioGroupList) do
            if prefix == currentSelectedRadio then
                foundIndex = i
                break
            end
        end

        if foundIndex and foundIndex < #radioGroupList then
            nextGroup = radioGroupList[foundIndex + 1]
        else
            nextGroup = false
        end
    end

    setElementData(client, "voiceRadioChannel", nextGroup)
end)