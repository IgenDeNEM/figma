addEvent("syncChatState", true)
addEventHandler("syncChatState", getRootElement(), function(players, state)
    --TODO Optimalizalni (Lehetseges.) -> Szar a clientside is, mindkettonel.
    triggerClientEvent(players, "syncChatState", source, state)
end)

addEvent("syncConsoleState", true)
addEventHandler("syncConsoleState", getRootElement(), function(players, state)
    --TODO Optimalizalni (Lehetseges.)
    triggerClientEvent(players, "syncConsoleState", source, state)
end)

addCommandHandler("anames", function(client)
    if exports.sPermission:hasPermission(client, "anames") then
        local duty = getElementData(client, "adminDuty") or false
        local state = getElementData(client, "anamesState") or 0

        if state > 0 then
            setElementData(client, "anamesState", 0)
        else
            if duty then
                if exports.sPermission:hasPermission(client, "superAnames") then
                    setElementData(client, "anamesState", 3)
                else
                    setElementData(client, "anamesState", 1)
                end
            elseif exports.sPermission:hasPermission(client, "offdutyAnames") then
                setElementData(client, "anamesState", 3)
            end

        end
    end
end)

local placedDoMessages = {}
local doId = 0
local playerDoData = {}

addCommandHandler("placedo", function(sourcePlayer, sourceCommand, ...)
    if not getElementData(sourcePlayer, "loggedIn") then
        return
    end

    if not playerDoData[sourcePlayer] then
        playerDoData[sourcePlayer] = {
            lastPlacedTime = 0,
            activeDoCount = 0,
            messages = {}
        }
    end

    local playerData = playerDoData[sourcePlayer]
    local currentTime = getTickCount()

    if currentTime - playerData.lastPlacedTime < 3 * 60 * 1000 then
        outputChatBox("[color=sightred][SightMTA - Hiba] [color=sighthudwhite]Nem hozhatsz létre ilyen rövid időközönként placedo-t!", sourcePlayer)
        return
    end

    if playerData.activeDoCount >= 5 then
        local oldestMessageId = table.remove(playerData.messages, 1)
        for index, data in ipairs(placedDoMessages) do
            if data.messageId == oldestMessageId then
                table.remove(placedDoMessages, index)
                triggerClientEvent(getRootElement(), "processDoRequest", sourcePlayer, false, {true, oldestMessageId})
                break
            end
        end
        playerData.activeDoCount = playerData.activeDoCount - 1
    end

    local messageText = table.concat({...}, " ")
    if messageText == "" then
        outputChatBox("[color=sightblue][SightMTA - Használat] [color=sighthudwhite]/placedo [üzenet]", sourcePlayer)
        return
    end

    local x, y, z = getElementPosition(sourcePlayer)
    local int = getElementInterior(sourcePlayer)
    local dim = getElementDimension(sourcePlayer)
    local charName = getElementData(sourcePlayer, "char.name")
    local charId = getElementData(sourcePlayer, "char.ID")

    local messageData = {
        position = {x, y, z},
        interior = int,
        dimension = dim,
        messageText = messageText,
        charName = charName,
        characterId = charId,
        messageId = doId,
        ownerPlayer = sourcePlayer
    }

    table.insert(placedDoMessages, messageData)
    table.insert(playerData.messages, doId)

    playerData.lastPlacedTime = currentTime
    playerData.activeDoCount = playerData.activeDoCount + 1

    triggerClientEvent(getRootElement(), "processDoRequest", sourcePlayer, messageData, {false, false})

    doId = doId + 1
end)

addEvent("tryToDeletePlacedo", true)
addEventHandler("tryToDeletePlacedo", getRootElement(), function(messageId)
    if client ~= source then
        exports.sAnticheat:anticheatBan(client, "AC #52 - sNames @sourceS:107")
        return
    end

    local messageIndex = nil
    local messageData = nil

    for index, data in ipairs(placedDoMessages) do
        if data.messageId == messageId then
            messageIndex = index
            messageData = data
            break
        end
    end

    if not messageData then
        outputChatBox("[color=sightred][SightMTA] [color=sighthudwhite]Nem található a placedo üzenet.", client)
        return
    end

    local clientCharId = getElementData(client, "char.ID")
    local clientAdminLevel = getElementData(client, "acc.adminLevel") or 0

    if clientCharId == messageData.characterId or clientAdminLevel >= 5 then
        table.remove(placedDoMessages, messageIndex)
        outputChatBox("[color=sightgreen][SightMTA] [color=sighthudwhite]Sikeresen kitöröltél egy placedo-t!", client)

        local ownerPlayer = messageData.ownerPlayer
        if isElement(ownerPlayer) and playerDoData[ownerPlayer] then
            playerDoData[ownerPlayer].activeDoCount = math.max(0, playerDoData[ownerPlayer].activeDoCount - 1)
            for i, id in ipairs(playerDoData[ownerPlayer].messages) do
                if id == messageId then
                    table.remove(playerDoData[ownerPlayer].messages, i)
                    break
                end
            end
        else
            for player, data in pairs(playerDoData) do
                local playerCharId = getElementData(player, "char.ID")
                if playerCharId == messageData.characterId then
                    data.activeDoCount = math.max(0, data.activeDoCount - 1)
                    for i, id in ipairs(data.messages) do
                        if id == messageId then
                            table.remove(data.messages, i)
                            break
                        end
                    end
                    break
                end
            end
        end

        triggerClientEvent(getRootElement(), "processDoRequest", client, false, {true, messageId})
    else
        exports.sAnticheat:anticheatBan(client, "AC #53 - sNames @sourceS:161")
        return
    end
end)
