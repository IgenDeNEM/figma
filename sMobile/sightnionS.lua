local sightnionPlayers = {}     -- Connected players: [playerElement] = char.ID
local sightnionMessages = {}    
local messageCounter = 0        

local lastPmTimestamps = {}     

function findPlayerById(charID)
    local foundPlayer = false
    for playerIdentity, playerElement in pairs(getElementsByType("player")) do
        if getElementData(playerElement, "char.ID") == charID then
            foundPlayer = playerElement
            break
        end
    end
    return foundPlayer
end

function table.size(tbl)
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    return count
end

addEvent("connectToSightNion", true)
addEventHandler("connectToSightNion", root, function()
    if exports.sGroups:getPlayerPermission(client, "nion") then
        local clientID = getElementData(client, "char.ID")
        sightnionPlayers[client] = clientID

        local lastMessageID = messageCounter
        local firstMessageID = 1
        triggerClientEvent(client, "gotSightNionConnected", client, clientID, lastMessageID, firstMessageID)

        local onlineCount = table.size(sightnionPlayers)
        for player in pairs(sightnionPlayers) do
            triggerClientEvent(player, "gotSightNionOnlineNum", player, onlineCount)
        end

        triggerClientEvent(client, "gotSightNionOnlineNum", client, onlineCount)
    else
        exports.sGui:showInfobox(client, "e", "Nincs jogosultságod a SightNion használatához!")
    end
end)

addEvent("disconnectFromSightNion", true)
addEventHandler("disconnectFromSightNion", root, function()
    sightnionPlayers[client] = nil

    local onlineCount = table.size(sightnionPlayers)
    for player in pairs(sightnionPlayers) do
        triggerClientEvent(player, "gotSightNionOnlineNum", player, onlineCount)
    end
end)

addEvent("requestSightNionMessages", true)
addEventHandler("requestSightNionMessages", root, function(requestedMessageIDs)
    local messagesToSend = {}
    for _, messageID in ipairs(requestedMessageIDs) do
        local message = sightnionMessages[messageID]
        if message then
            messagesToSend[messageID] = message
        end
    end
    triggerClientEvent(client, "gotSightNionMessages", client, messagesToSend)
end)

addEvent("sendSightNionChatMessage", true)
addEventHandler("sendSightNionChatMessage", root, function(messageInput)
    local senderID = getElementData(client, "char.ID")
    messageCounter = messageCounter + 1
    local messageID = messageCounter
    local timestamp = getRealTime().timestamp
    local messageData = {messageInput, senderID, timestamp, messageID}
    sightnionMessages[messageID] = messageData

    for player in pairs(sightnionPlayers) do
        triggerClientEvent(player, "gotSightNionMessages", player, {[messageID] = messageData})
    end
end)

local strawnionPmList = {}

addEvent("validateSightNionPM", true)
addEventHandler("validateSightNionPM", root, function(targetID)
    local clientID = getElementData(client, "char.ID")

    strawnionPmList[clientID] = strawnionPmList[clientID] or {}
    strawnionPmList[clientID][targetID] = strawnionPmList[clientID][targetID] or {}

    local conversation = strawnionPmList[clientID][targetID]
    local cache = {}

    local lastReceivedTimestamp = lastPmTimestamps[clientID] and lastPmTimestamps[clientID][targetID] or 0

    for _, msg in ipairs(conversation) do
        local text, senderID, timestamp = unpack(msg)
        if timestamp > lastReceivedTimestamp then
            table.insert(cache, {senderID, text, timestamp})
        end
    end

    triggerClientEvent(client, "gotSightNionPMValidation", client, targetID, true, true, cache)
end)


addEvent("sendSightNionPMMessage", true)
addEventHandler("sendSightNionPMMessage", root, function(targetID, messageText)
    local senderID = getElementData(client, "char.ID")
    local timestamp = getRealTime().timestamp
    local messageData = {messageText, senderID, timestamp}

    strawnionPmList[senderID] = strawnionPmList[senderID] or {}
    strawnionPmList[senderID][targetID] = strawnionPmList[senderID][targetID] or {}
    strawnionPmList[targetID] = strawnionPmList[targetID] or {}
    strawnionPmList[targetID][senderID] = strawnionPmList[targetID][senderID] or {}

    table.insert(strawnionPmList[senderID][targetID], messageData)
    table.insert(strawnionPmList[targetID][senderID], messageData)

    lastPmTimestamps[senderID] = lastPmTimestamps[senderID] or {}
    lastPmTimestamps[senderID][targetID] = timestamp

    triggerClientEvent(client, "gotSightNionPMMessage", client, targetID, senderID, messageText, timestamp)


    local recipientPlayer = findPlayerById(targetID)
    if recipientPlayer then
        lastPmTimestamps[targetID] = lastPmTimestamps[targetID] or {}
        lastPmTimestamps[targetID][senderID] = timestamp

        triggerClientEvent(recipientPlayer, "gotSightNionPMMessage", recipientPlayer, senderID, senderID, messageText, timestamp)
    end

    if recipientPlayer then
        outputChatBox("[color=sightyellow][SightMTA - Nion]:#ffffff Válasz érkezett egy privát beszélgetésedben (ID: ".. targetID ..")", recipientPlayer)
    end
end)

addEvent("requestSightNionPmList", true)
addEventHandler("requestSightNionPmList", root, function()
    local clientID = getElementData(client, "char.ID")
    local pmList = {}

    if strawnionPmList[clientID] then
        for otherID, messages in pairs(strawnionPmList[clientID]) do
            if #messages > 0 then
                local lastMessage = messages[#messages]
                local text, senderID, timestamp = unpack(lastMessage)
                local isOutgoing = senderID == clientID
                table.insert(pmList, {otherID, timestamp, text, isOutgoing})
            end
        end
    end

    table.sort(pmList, function(a, b) return a[2] > b[2] end)

    triggerClientEvent(client, "gotsightNionPmList", client, pmList)
end)

addCommandHandler("delnionmessage", function(sourcePlayer, commandName, messageId)
    if exports.sPermission:hasPermission(sourcePlayer, "delnion") then
        if not (messageId or tonumber(messageId)) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/"..commandName.." [Üzenet ID]", sourcePlayer)
            return
        end

        local messageId = tonumber(messageId)

        if sightnionMessages[messageId] then
            outputChatBox("[color=sightgreen][SightMTA - Nion]: [color=hudwhite]Sikeresen kitöröltél egy üzenetet a SightNion chat-ből ["..messageId.." - "..unpack(sightnionMessages[messageId]).."]", sourcePlayer)
            triggerClientEvent("deleteSightNionMessage", sourcePlayer, messageId)
            sightnionMessages[messageId] = nil
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található üzenet ezzel az ID-vel!", sourcePlayer)
        end
    end
end)

addCommandHandler("anoid", function(sourcePlayer, commandName, targetAnoid)
    if exports.sPermission:hasPermission(sourcePlayer, "anoid") then
        if not (targetAnoid or tonumber(targetAnoid)) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/"..commandName.." [Ano ID]", sourcePlayer)
            return
        end

        local targetAnoid = tonumber(targetAnoid)
        local foundPlayer = false

        for _, playerElement in pairs(getElementsByType("player")) do
            if getElementData(playerElement, "char.ID") == targetAnoid then
                foundPlayer = playerElement
                break
            end
        end

        if not foundPlayer then
            outputChatBox("[color=sightgreen][SightMTA - Nion]: [color=hudwhite]Account ID: "..targetAnoid, sourcePlayer)
        else
            local foundPlayerName = getElementData(foundPlayer, "visibleName")
            outputChatBox("[color=sightgreen][SightMTA - Nion]: [color=hudwhite]Játékos neve: "..foundPlayerName:gsub("_", " ").." Account ID: "..targetAnoid, sourcePlayer)
        end
    end
end)