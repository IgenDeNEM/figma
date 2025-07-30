local tabletCalls = {}
local tabletReports = {}
local tabletDuty = {}

local playerGroups = {}

function getPrefix(id)
    return emergencyCallList[id][1]
end

function findCall(currentEmergencyGroup, emergencyType, playerElement)
    local found = false
    for callIndex, callData in pairs(tabletCalls[currentEmergencyGroup]) do
        if playerElement == callData.caller then
            found = callIndex
            break
        end
    end
    return found
end

function registerPlayerDuty(playerElement, groupPrefix, registerState)
    if registerState then
        playerGroups[playerElement] = groupPrefix
        triggerClientEvent("newTabletDutyPlayer", playerElement, groupPrefix, playerElement, getElementData(playerElement, "char.name"):gsub("_", " "))
    else
        playerGroups[playerElement] = false
        triggerClientEvent("deleteTabletDutyPlayer", playerElement, groupPrefix, playerElement)
    end
end

addEvent("deleteGroupCallTablet", true)
addEventHandler("deleteGroupCallTablet", root, function()
    if client and client == source then
        setElementData(client, "tablet", false)
    else
        exports.sAnticheat:anticheatBan(client, "AC #60 - sGroupcall @sourceS:37")
    end
end)

addEventHandler("onResourceStart", resourceRoot, function()
    setTimer(function()
        handleSubscriptions()
    end, 5000, 0)
end)

addEvent("sendEmergencyCall", true)
addEventHandler("sendEmergencyCall", root,
    function(currentEmergencyGroup, emergencyType, reason)
        if emergencyType == "call" then
            if not tabletCalls[currentEmergencyGroup] then
                tabletCalls[currentEmergencyGroup] = {}
            end
            local x, y, z = getElementPosition(client)
            local newCallId = #tabletCalls[currentEmergencyGroup] + 1

            local newCall = {
                id = newCallId, 
                name = getElementData(client, "visibleName"),
                number = exports.sMobile:getPlayerCurrentNumber(client), 
                ts = getRealTime().timestamp, 
                locationX = x, 
                locationY = y, 
                locationZ = z,
                accepted = false, 
                reason = reason, 
                locationOnline = true, 
                caller = client, 
                prefix = getPrefix(currentEmergencyGroup)
            }
            if currentEmergencyGroup == 3 then
                triggerEvent("firemanWarnSoundEx", client)
            end

            tabletCalls[currentEmergencyGroup][newCallId] = newCall

            triggerClientEvent(client, "gotGroupCall", client, currentEmergencyGroup, reason, getRealTime().timestamp)

            triggerClientEvent("gotTabletNewCall", client, currentEmergencyGroup, newCallId, newCall)

            triggerClientEvent("gotGroupCallNoti", client, currentEmergencyGroup, 1, newCallId, getElementData(client, "visibleName"))

            exports.sGui:showInfobox(client, "s", "Sikeresen kihívtad a szervezetet!")

        elseif emergencyType == "report" then
            if not tabletReports[currentEmergencyGroup] then
                tabletReports[currentEmergencyGroup] = {}
            end

            local x, y, z = getElementPosition(client)

            local newReportId = #tabletReports[currentEmergencyGroup] + 1

            local newReport = {
                id = newReportId, 
                name = getElementData(client, "visibleName"),
                number = exports.sMobile:getPlayerCurrentNumber(client), 
                ts = getRealTime().timestamp, 
                locationX = x, 
                locationY = y, 
                locationZ = z,
                accepted = false, 
                reason = reason, 
                locationOnline = true, 
                caller = client, 
                prefix = getPrefix(currentEmergencyGroup)
            }

            tabletReports[currentEmergencyGroup][newReportId] = newReport

            triggerClientEvent(client, "gotGroupCallReport", client, currentEmergencyGroup, reason, getRealTime().timestamp)
            triggerClientEvent("gotTabletNewReport", client, currentEmergencyGroup, newReportId, newReport)
            triggerClientEvent("gotGroupCallNoti", client, currentEmergencyGroup, 2, newReportId, getElementData(client, "visibleName"))

            exports.sGui:showInfobox(client, "s", "Sikeresen tettél egy bejelentést!")
        end
    end
)

addEventHandler("onPlayerWasted", root, 
    function()
        for k, v in pairs(tabletCalls) do
            for k2, v2 in pairs(v) do
                if v2.caller == source then
                    local callId = v2.id

                    tabletCalls[k2][callId] = nil
                    triggerClientEvent("gotGroupCallNoti", source, k2, 3, callId, "spawn")

                    local currentTabletGroup = k2

                    triggerClientEvent(v2.caller, "gotGroupCall", v2.caller, currentTabletGroup, true, true, true)
                    triggerClientEvent(v2.caller, "hangedUpPhone", v2.caller)
                    triggerClientEvent("gotTabletCallDeleted", source, currentTabletGroup, callId)
                end
            end
        end
    end
)

addEventHandler("onPlayerQuit", root, 
    function()
        for k, v in pairs(tabletCalls) do
            for k2, v2 in pairs(v) do
                if v2.caller == source then
                    local callId = v2.id

                    tabletCalls[k2][callId] = nil
                    triggerClientEvent("gotGroupCallNoti", source, k2, 3, callId, "spawn")

                    local currentTabletGroup = k2
                    groupCallSubscriptions[source] = nil
                    triggerClientEvent(v2.caller, "gotGroupCall", v2.caller, currentTabletGroup, true, true, true)
                    triggerClientEvent(v2.caller, "hangedUpPhone", v2.caller)
                    triggerClientEvent("gotTabletCallDeleted", source, currentTabletGroup, callId)
                end
            end
        end
    end
)

addEvent("acceptGroupCall", true)
addEventHandler("acceptGroupCall", root,
    function(currentTabletGroup, callId)
        local groupCalls = tabletCalls[currentTabletGroup]

        groupCalls[callId].accepted = true

        triggerClientEvent("gotTabletCallAccepted", client, currentTabletGroup, callId, true, groupCalls[callId].prefix)

        triggerClientEvent(groupCalls[callId].caller, "gotGroupCallAccepted", groupCalls[callId].caller, currentTabletGroup, true)
        triggerClientEvent(groupCalls[callId].caller, "showInfobox", groupCalls[callId].caller, "s", "Elfogadták a következő hívásod: " .. groupCalls[callId].prefix, 4000)
        
        triggerClientEvent("gotGroupCallNoti", client, currentTabletGroup, 4, callId, getElementData(client, "visibleName"):gsub("_", " "))
    end
)

addEvent("deleteGroupCall", true)
addEventHandler("deleteGroupCall", root, 
    function(currentTabletGroup, callId)
        local groupCalls = tabletCalls[currentTabletGroup]

        triggerClientEvent(groupCalls[callId].caller, "showInfobox", groupCalls[callId].caller, "w", "Törölték a következő hívásod: " .. groupCalls[callId].prefix .. "", 4000)
        triggerClientEvent(groupCalls[callId].caller, "gotGroupCall", groupCalls[callId].caller, currentTabletGroup, false, false, false)
        triggerClientEvent(groupCalls[callId].caller, "hangedUpPhone", groupCalls[callId].caller)

        groupCalls[callId] = nil

        triggerClientEvent("gotTabletCallDeleted", client, currentTabletGroup, callId)
        triggerClientEvent("gotGroupCallNoti", client, currentTabletGroup, 3, callId, getElementData(client, "visibleName"):gsub("_", " "))
    end
)

addEvent("deleteGroupReport", true)
addEventHandler("deleteGroupReport", root, 
    function(currentTabletGroup, callId)
        local groupReports = tabletReports[currentTabletGroup]

        triggerClientEvent(groupReports[callId].caller, "showInfobox", groupReports[callId].caller, "warning", "Törölték a következő bejelentésed: " .. groupReports[callId].prefix .. "", 4000)

        groupReports[callId] = nil

        triggerClientEvent("gotTabletReportDeleted", client, currentTabletGroup, callId)
        triggerClientEvent("gotGroupCallNoti", client, currentTabletGroup, 5, callId, getElementData(client, "visibleName"):gsub("_", " "))
    end
)

function findCall(currentEmergencyGroup, emergencyType, searchElement)
    local found = false

    for k, v in pairs(tabletCalls[currentEmergencyGroup]) do
        if searchElement == v.caller then
            found = k
        end
    end

    return found
end

local groupCallSubscriptions = {}
local groupReportSubscriptions = {}

addEvent("addGroupCallSubscription", true)
addEventHandler("addGroupCallSubscription", root, function(tabletGroup, callIdentity)
    groupCallSubscriptions[client] = {callIdentity, tabletGroup}
end)

addEvent("deleteGroupCallSubscription", true)
addEventHandler("deleteGroupCallSubscription", root, function()
    groupCallSubscriptions[client] = nil
end)

addEvent("addGroupReportSubscription", true)
addEventHandler("addGroupReportSubscription", root, function(tabletGroup, callIdentity)
    groupReportSubscriptions[client] = {callIdentity, tabletGroup}
end)

addEvent("deleteGroupReportSubscription", true)
addEventHandler("deleteGroupReportSubscription", root, function()
    groupCallSubscriptions[client] = nil
end)

function findPlayerByName(playerName)
    if not playerName then return end
    foundPlayer = false
    for _, playerElement in pairs(getElementsByType("player")) do
        if getElementData(playerElement, "char.name") == playerName then
            foundPlayer = playerElement
            break
        end
    end
    return foundPlayer
end

function handleSubscriptions()

    for subElement, subData in pairs(groupCallSubscriptions) do
        if subElement then
            local playerElement = findPlayerByName((tabletCalls[subData[2]][subData[1]].name or false))
            if playerElement then
                local playerPosition = {getElementPosition(playerElement)}

                triggerClientEvent(subElement, "gotTabletSingleLocationUpdate", subElement, subData[2], subData[1], playerPosition[1], playerPosition[2], playerPosition[3])
            end
        end
    end

    for subElement, subData in pairs(groupReportSubscriptions) do
        if subElement then
            if subData and subData[2] and subData[1] and tabletCalls[subData[2]][subData[1]] and tabletCalls[subData[2]][subData[1]].name then
                local playerElement = findPlayerByName((tabletCalls[subData[2]][subData[1]].name or false))
                if playerElement then
                    local playerPosition = {getElementPosition(playerElement)}

                    triggerClientEvent(subElement, "gotTabletSingleLocationUpdate", subElement, subData[2], subData[1], playerPosition[1], playerPosition[2], playerPosition[3])
                end
            end
        end
    end
end

addEvent("cancelEmergencyCall", true)
addEventHandler("cancelEmergencyCall", root, 
    function(currentEmergencyGroup, emergencyType, val)
        local callId = findCall(currentEmergencyGroup, emergencyType, client)

        local groupCalls = tabletCalls[currentEmergencyGroup]

        exports.sGui:showInfobox(client, "i", "Lemondtad a következő hívásod: " .. groupCalls[callId].prefix .. ".")

        triggerClientEvent(groupCalls[callId].caller, "gotGroupCall", groupCalls[callId].caller, currentEmergencyGroup, false, false, false)
        triggerClientEvent("gotGroupCallNoti", client, currentEmergencyGroup, 3, callId, false)
        triggerClientEvent(groupCalls[callId].caller, "hangedUpPhone", groupCalls[callId].caller)

        groupCalls[callId] = nil

        triggerClientEvent("gotTabletCallDeleted", client, currentEmergencyGroup, callId)

    end
)

addEvent("requestTabletInitData", true)
function requestTabletInitData(currentTabletGroup, group, player)
    if player then
        client = player
    end

    local groupCalls = tabletCalls[currentTabletGroup]
    local groupReports = tabletReports[currentTabletGroup]
    local groupDuty = tabletDuty[currentTabletGroup]

    if not groupCalls then
        groupCalls = {}
    end

    if not groupReports then
        groupReports = {}
    end

    if not groupDuty then
        groupDuty = {}
    end

    setElementData(client, "tablet", true)
    triggerClientEvent(client, "gotTabletInitData", client, currentTabletGroup, groupCalls, groupReports, groupDuty)
end
addEventHandler("requestTabletInitData", root, requestTabletInitData)