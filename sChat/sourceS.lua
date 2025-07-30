addEvent("onOOCMessage", true)
addEventHandler("onOOCMessage", getRootElement(), function (playersTable, sourcePlayerName, message, color)
    if source ~= client then
        return
    end

    local spectatingTable = false

    local tempPlayers = {}
    local playerElements = getElementsByType("player")

    for k = 1, #playerElements do
        local element = playerElements[k]

        if element ~= client then
            local sourceX, sourceY, sourceZ = getElementPosition(client)
            local targetX, targetY, targetZ = getElementPosition(element)

            if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 12 then
                table.insert(tempPlayers, element)
            end
        end
    end
    table.insert(tempPlayers, client)
    table.insert(playersTable, client)

    local spectatingPlayers = exports.sAdministration:getSpectatePlayers(client)
    if spectatingPlayers then
        spectatingTable = {}

        table.insert(spectatingTable, spectatingPlayers)

        triggerClientEvent(spectatingTable, "onClientRecieveOOCMessage", client, message, sourcePlayerName, spectatingTable, color)
    end

    exports.sAnticheat:sendWebhookMessage("**"..getElementData(client, "visibleName"):gsub("_", " ").. "** : "..message.."", "ooc")

    if #tempPlayers == #playersTable then
        triggerClientEvent(playersTable, "onClientRecieveOOCMessage", client, message, sourcePlayerName, spectatingTable, color)
    end
end)

addEvent("onLocalMessage", true)
addEventHandler("onLocalMessage", getRootElement(), function(playersTable, sourcePlayerName, message, inVehicle, adminDuty, adminTitle, color, thePlayer, anim)
    if source ~= client then
        return
    end

    local tempPlayers = {}
    local playerElements = getElementsByType("player")
    
    triggerClientEvent("chatBubble", client, "say", message:gsub("^%l", string.upper))

    triggerClientEvent("applyChatAnim", client, anim, utf8.len(message) * 200)

    for k = 1, #playerElements do
        local element = playerElements[k]

        if element ~= client then
            local sourceX, sourceY, sourceZ = getElementPosition(client)
            local targetX, targetY, targetZ = getElementPosition(element)

            if thePlayer then
                local messageDistance = 12

                local vehicle = getPedOccupiedVehicle(element)
                if vehicle and not getElementData(vehicle, "vehicle.windowState") then
                    messageDistance = 8
                end

                if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= messageDistance then
                    table.insert(tempPlayers, element)
                end
            else
                local messageDistance = 4

                local vehicle = getPedOccupiedVehicle(element)
                if vehicle and not getElementData(vehicle, "vehicle.windowState") then
                    return
                end

                if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= messageDistance then
                    table.insert(tempPlayers, element)
                end
            end
        end
    end
    
    local spectatingPlayers = getElementData(client, "spectatingPlayers")
    if spectatingPlayers then
        spectatingTable = {}

        for k, player in pairs(spectatingPlayers) do
            if isElement(player) then
                table.insert(spectatingTable, player)
            end
        end

        for i = 1, #spectatingTable do
            local element = spectatingTable[i]
            
            if element then
                if adminDuty and adminDuty ~= 0 then
                    outputChatBox(color .. "[ADMIN] " .. adminTitle .. " " .. sourcePlayerName .. " mondja" .. inVehicle .. ": " .. firstToUpper(message), playersTable[i], 231, 217, 176, true)
                else
                    outputChatBox("#FFFFFF" .. sourcePlayerName .. " mondja" .. inVehicle .. ": " .. firstToUpper(message), playersTable[i], 231, 217, 176, true)
                end
            end 
        end
    end

    if #tempPlayers == #playersTable then
        for i = 1, #playersTable do
            local element = playersTable[i]
            
            if element then
                if adminDuty and adminDuty ~= 0 then
                    outputChatBox(color .. "[ADMIN] " .. adminTitle .. " " .. sourcePlayerName .. " mondja" .. inVehicle .. ": " .. firstToUpper(message), playersTable[i], 231, 217, 176, true)
                else
                    outputChatBox("#FFFFFF" .. sourcePlayerName .. " mondja" .. inVehicle .. ": " .. firstToUpper(message), playersTable[i], 231, 217, 176, true)
                end
            end 
        end
    end
    
end)

addEvent("onActionMessage", true)
addEventHandler("onActionMessage", getRootElement(), function (playersTable, sourcePlayerName, message)
    if source ~= client then
        return
    end

    local tempPlayers = {}
    local playerElements = getElementsByType("player")

    for k = 1, #playerElements do
        local element = playerElements[k]

        if element ~= client then
            local sourceX, sourceY, sourceZ = getElementPosition(client)
            local targetX, targetY, targetZ = getElementPosition(element)

            if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 12 then
                table.insert(tempPlayers, element)
            end
        end
    end
    
    local spectatingPlayers = getElementData(client, "spectatingPlayers")
    if spectatingPlayers then
        spectatingTable = {}

        for k, player in pairs(spectatingPlayers) do
            if isElement(player) then
                table.insert(spectatingTable, player)
            end
        end

        for i = 1, #spectatingTable do
            local element = spectatingTable[i]
            
            if element then
                outputChatBox("#C2A2DA*** " .. sourcePlayerName .. " #C2A2DA" .. message, element, 194, 162, 218, true)
            end 
        end
    end

    if #tempPlayers == #playersTable then
        for i = 1, #playersTable do
            local element = playersTable[i]
            
            if element then
                outputChatBox("#C2A2DA*** " .. sourcePlayerName .. " #C2A2DA" .. message, element, 194, 162, 218, true)
                exports.sAnticheat:sendWebhookMessage(message .. " ```asciidoc\n\n".. sourcePlayerName:gsub("_", " ") .. "```", "rp")

            end 
        end
    end

    triggerClientEvent("chatBubble", client, "me", message)
end)

addEvent("onActionMessageLow", true)
addEventHandler("onActionMessageLow", getRootElement(), function (playersTable, sourcePlayerName, message)
    if source ~= client then
        return
    end

    local tempPlayers = {}
    local playerElements = getElementsByType("player")

    for k = 1, #playerElements do
        local element = playerElements[k]

        if element ~= client then
            local sourceX, sourceY, sourceZ = getElementPosition(client)
            local targetX, targetY, targetZ = getElementPosition(element)

            if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 6 then
                table.insert(tempPlayers, element)
            end
        end
    end
    
    local spectatingPlayers = getElementData(client, "spectatingPlayers")
    if spectatingPlayers then
        spectatingTable = {}

        for k, player in pairs(spectatingPlayers) do
            if isElement(player) then
                table.insert(spectatingTable, player)
            end
        end

        for i = 1, #spectatingTable do
            local element = spectatingTable[i]
            
            if element then
                outputChatBox("#DBC5EB*** [LOW] " .. sourcePlayerName .. " #DBC5EB" .. message, element, 219, 197, 235, true)
            end 
        end
    end

    if #tempPlayers == #playersTable then
        for i = 1, #playersTable do
            local element = playersTable[i]
            
            if element then
                outputChatBox("#DBC5EB*** [LOW] " .. sourcePlayerName .. " #DBC5EB" .. message, element, 219, 197, 235, true)
                exports.sAnticheat:sendWebhookMessage(message .. " ```diff\n- " .. sourcePlayerName:gsub("_", " ") .. "[LOW]```", "rp")

            end 
        end
    end
    triggerClientEvent("chatBubble", client, "melow", message)
end)

addEvent("onActionMessageA", true)
addEventHandler("onActionMessageA", getRootElement(), function (playersTable, sourcePlayerName, message)
    if source ~= client then
        return
    end

    local tempPlayers = {}
    local playerElements = getElementsByType("player")

    for k = 1, #playerElements do
        local element = playerElements[k]

        if element ~= client then
            local sourceX, sourceY, sourceZ = getElementPosition(client)
            local targetX, targetY, targetZ = getElementPosition(element)

            if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 12 then
                table.insert(tempPlayers, element)
            end
        end
    end
    
    local spectatingPlayers = getElementData(client, "spectatingPlayers")
    if spectatingPlayers then
        spectatingTable = {}

        for k, player in pairs(spectatingPlayers) do
            if isElement(player) then
                table.insert(spectatingTable, player)
            end
        end

        for i = 1, #spectatingTable do
            local element = spectatingTable[i]
            
            if element then
                outputChatBox("#956CB4>> " .. sourcePlayerName .. " #956CB4" .. message, element, 194, 162, 218, true)
            end 
        end    
    end

    if #tempPlayers == #playersTable then
        for i = 1, #playersTable do
            local element = playersTable[i]
            
            if element then
                outputChatBox("#956CB4>> " .. sourcePlayerName .. " #956CB4" .. message, element, 194, 162, 218, true)
            end 
        end
    end
    triggerClientEvent("chatBubble", client, "ame", message)
end)

addEvent("onDoMessage", true)
addEventHandler("onDoMessage", getRootElement(), function (playersTable, sourcePlayerName, message, player)
    if client then
        if source ~= client then
            return
        end
    end
    if player then
        client = player
    end

    local tempPlayers = {}
    local playerElements = getElementsByType("player")

    for k = 1, #playerElements do
        local element = playerElements[k]

        if element ~= client then
            local sourceX, sourceY, sourceZ = getElementPosition(client)
            local targetX, targetY, targetZ = getElementPosition(element)

            if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 12 then
                table.insert(tempPlayers, element)
            end
        end
    end
    
    local spectatingPlayers = getElementData(client, "spectatingPlayers")
    if spectatingPlayers then
        spectatingTable = {}

        for k, player in pairs(spectatingPlayers) do
            if isElement(player) then
                table.insert(spectatingTable, player)
            end
        end

        for i = 1, #spectatingTable do
            local element = spectatingTable[i]
            
            if element then
                outputChatBox(" *" .. firstToUpper(message) .. " ((#FF2850" .. sourcePlayerName .. "))", element, 255, 40, 80, true)
            end 
        end
    end

    if #tempPlayers == #playersTable then
        for i = 1, #playersTable do
            local element = playersTable[i]
            
            if element then
                outputChatBox(" " .. firstToUpper(message) .. " ((#FF2850" .. sourcePlayerName .. "))", element, 255, 40, 80, true)
                exports.sAnticheat:sendWebhookMessage(message .. " ```diff\n- " .. sourcePlayerName:gsub("_", " ") .. "```", "rp")
            end 
        end
    end

    triggerClientEvent("chatBubble", client, "do", message)
end)

addEvent("onDoMessageLow", true)
addEventHandler("onDoMessageLow", getRootElement(), function (playersTable, sourcePlayerName, message)
    if source ~= client then
        return
    end

    local tempPlayers = {}
    local playerElements = getElementsByType("player")

    for k = 1, #playerElements do
        local element = playerElements[k]

        if element ~= client then
            local sourceX, sourceY, sourceZ = getElementPosition(client)
            local targetX, targetY, targetZ = getElementPosition(element)

            if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 12 then
                table.insert(tempPlayers, element)
            end
        end
    end
    
    local spectatingPlayers = getElementData(client, "spectatingPlayers")
    if spectatingPlayers then
        spectatingTable = {}

        for k, player in pairs(spectatingPlayers) do
            if isElement(player) then
                table.insert(spectatingTable, player)
            end
        end

        for i = 1, #spectatingTable do
            local element = spectatingTable[i]
            
            if element then
                outputChatBox("[LOW] *" .. firstToUpper(message) .. " ((#ff6682" .. sourcePlayerName .. "))", element, 255, 102, 130, true)
            end 
        end
    end

    if #tempPlayers == #playersTable then
        for i = 1, #playersTable do
            local element = playersTable[i]
            
            if element then
                outputChatBox("[LOW] *" .. firstToUpper(message) .. " ((#ff6682" .. sourcePlayerName .. "))", element, 255, 102, 130, true)
                exports.sAnticheat:sendWebhookMessage(message .. " ```diff\n- " .. sourcePlayerName:gsub("_", " ") .. "[LOW]```", "rp")
            end 
        end
    end
    triggerClientEvent("chatBubble", client, "dolow", message)
end)

addEvent("onMegaPhoneMessage", true)
addEventHandler("onMegaPhoneMessage", getRootElement(), function (nearby, visibleName, msg)
    if isElement(source) and client == source then
        local pedVehicle = getPedOccupiedVehicle(client)
        if pedVehicle then
            vehicleId = getElementData(pedVehicle, "vehicle.dbID")
            inGroup, groupName = exports.sGroups:isVehicleInGroup(vehicleId)
        end

        if inGroup then
            if exports.sGroups:isLegalGroup(groupName) then
                allowedVehicle = true
            end
        end

        --if not exports.sItems:usingMegaphone(client) and not allowedVehicle then
        if not exports.sGroups:getPlayerPermission(client, "megaphone") then
            exports.sAnticheat:anticheatBan(client, "AC #8 - sChat @sourceS:424")
            return 
        end
        
        local sourcePlayerName = utf8.gsub(getElementData(client, "visibleName") or getPlayerName(client), "_", " ")
        local sourceX, sourceY, sourceZ = getElementPosition(client)

        outputChatBox(sourcePlayerName .. " <O: " .. firstToUpper(msg), client, 255, 255, 0, true)
        triggerClientEvent("chatBubble", client, "megaphone", msg)
        
        local playersTable = {}
        local nearbyPlayersCount = 0

        local players = getElementsByType("player")
        for _, targetPlayer in ipairs(players) do
            if targetPlayer ~= client then
                local targetX, targetY, targetZ = getElementPosition(targetPlayer)
                if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 60 then
                    table.insert(playersTable, {
                        player = targetPlayer,
                        intensity = 1 - (getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) / 60)
                    })
                    nearbyPlayersCount = nearbyPlayersCount + 1
                end
            end
        end

        for k, v in pairs(playersTable) do
            if isElement(v.player) then
                outputChatBox(sourcePlayerName .. " <O: " .. firstToUpper(msg), v.player, 255 * v.intensity, 255 * v.intensity, 0 * v.intensity, true)
            end
        end
    end
end)

addEvent("onTryMessage", true)
addEventHandler("onTryMessage", getRootElement(), function (playersTable, sourcePlayerName, message, number, commandName)
    if source ~= client then
        return
    end

    local tempPlayers = {}
    local playerElements = getElementsByType("player")

    for k = 1, #playerElements do
        local element = playerElements[k]

        if element ~= client then
            local sourceX, sourceY, sourceZ = getElementPosition(client)
            local targetX, targetY, targetZ = getElementPosition(element)

            if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 12 then
                table.insert(tempPlayers, element)
            end
        end
    end
    
    local spectatingPlayers = getElementData(client, "spectatingPlayers")
    if spectatingPlayers then
        spectatingTable = {}

        for k, player in pairs(spectatingPlayers) do
            if isElement(player) then
                table.insert(spectatingTable, player)
            end
        end

        for i = 1, #spectatingTable do
            local element = spectatingTable[i]
            
            if element then
                if commandName == "megprobal" or commandName == "megpróbál" then
                    if number == 1 then
                        outputChatBox("[color=sightgreen] *** " .. sourcePlayerName .. " megpróbál " .. message .. " és sikerül neki.", element, 0, 230, 0, true)
                    elseif number == 2 then
                        outputChatBox("[color=sightred] *** " .. sourcePlayerName .. " megpróbál " .. message .. ", de sajnos nem sikerül neki.", element, 230, 0, 0, true)
                    end
                elseif commandName == "megprobalja" or commandName == "megpróbálja" then
                    if number == 1 then
                        outputChatBox("[color=sightgreen] *** " .. sourcePlayerName .. " megpróbálja " .. message .. " és sikerül neki.", element, 0, 230, 0, true)
                    elseif number == 2 then
                        outputChatBox("[color=sightred] *** " .. sourcePlayerName .. " megpróbálja " .. message .. ", de sajnos nem sikerül neki.", element, 230, 0, 0, true)
                    end
                end
            end 
        end
    end

    if #tempPlayers == #playersTable then
        for i = 1, #playersTable do
            local element = playersTable[i]
            
            if element then
                if commandName == "megprobal" or commandName == "megpróbál" then
                    if number == 1 then
                        outputChatBox("[color=sightgreen] *** " .. sourcePlayerName .. " megpróbál " .. message .. " és sikerül neki.", element, 0, 230, 0, true)
                        exports.sAnticheat:sendWebhookMessage(message .. " ```diff\n+ " .. sourcePlayerName:gsub("_", " ") .. "[TRY-SUCCESS]```", "rp")

                    elseif number == 2 then
                        outputChatBox("[color=sightred] *** " .. sourcePlayerName .. " megpróbál " .. message .. ", de sajnos nem sikerül neki.", element, 230, 0, 0, true)
                        exports.sAnticheat:sendWebhookMessage(message .. " ```diff\n- " .. sourcePlayerName:gsub("_", " ") .. "[TRY-FAIL]```", "rp")
                    end
                elseif commandName == "megprobalja" or commandName == "megpróbálja" then
                    if number == 1 then
                        outputChatBox("[color=sightgreen] *** " .. sourcePlayerName .. " megpróbálja " .. message .. " és sikerül neki.", element, 0, 230, 0, true)
                        exports.sAnticheat:sendWebhookMessage(message .. " ```diff\n+ " .. sourcePlayerName:gsub("_", " ") .. "[TRY-SUCCESS]```", "rp")
                    elseif number == 2 then
                        outputChatBox("[color=sightred] *** " .. sourcePlayerName .. " megpróbálja " .. message .. ", de sajnos nem sikerül neki.", element, 230, 0, 0, true)
                        exports.sAnticheat:sendWebhookMessage(message .. " ```diff\n- " .. sourcePlayerName:gsub("_", " ") .. "[TRY-FAIL]```", "rp")
                    end
                end
            end 
        end
    end
end)

addEvent("shoutNormal", true)
addEventHandler("shoutNormal", getRootElement(), function (playersTable, message)
    if source ~= client then
        return
    end
    
    local tempPlayers = {}
    local playerElements = getElementsByType("player")

    for k = 1, #playerElements do
        local element = playerElements[k]

        if element ~= client then
            local sourceX, sourceY, sourceZ = getElementPosition(client)
            local targetX, targetY, targetZ = getElementPosition(element)

            if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 30 then
                table.insert(tempPlayers, element)
            end
        end
    end
    
    local spectatingPlayers = getElementData(client, "spectatingPlayers")
    if spectatingPlayers then
        spectatingTable = {}

        for k, player in pairs(spectatingPlayers) do
            if isElement(player) then
                table.insert(spectatingTable, player)
            end
        end
        
        for i = 1, #spectatingTable do
            local element = spectatingTable[i]
            
            if element then
                outputChatBox("#FFFFF0" .. getElementData(client, "visibleName"):gsub("_", " ") .. " ordítja: " .. message, element, 194, 162, 218, true)
            end 
        end
    end

    if #tempPlayers == #playersTable then
        for i = 1, #playersTable do
            local element = playersTable[i]
            
            if element then
                outputChatBox("#FFFFF0" .. getElementData(client, "visibleName"):gsub("_", " ") .. " ordítja: " .. message, element, 194, 162, 218, true)
            end 
        end
    end
    setPedAnimation(client, "RIOT", "RIOT_shout", -1, false, false, false, false, 250, true)
end)

function isElementInRange(ele, x, y, z, range)
    if isElement(ele) and type(x) == "number" and type(y) == "number" and type(z) == "number" and type(range) == "number" then
        return getDistanceBetweenPoints3D(x, y, z, getElementPosition(ele)) <= range -- returns true if it the range of the element to the main point is smaller than (or as big as) the maximum range.
    end
    return false
end

function firstToUpper(text)
	return (text:gsub("^%l", string.upper))
end

function RGBToHex(r, g, b)
	return string.format("#%.2X%.2X%.2X", r, g, b)
end

addEvent("shoutInterior", true)
addEventHandler("shoutInterior", getRootElement(), function(message, interiorIdentity, shoutState)
    if isElement(source) and client == source then
        local intX, intY, intZ = exports.sInteriors:getInteriorInsidePosition(interiorIdentity)
        local extX, extY, extZ, extDim, extInt = exports.sInteriors:getInteriorOutsidePosition(interiorIdentity)
        local px, py, pz = getElementPosition(source)
        local visibleName = getElementData(source, "visibleName"):gsub("_", " ")
        local affected = {}

        for k, v in ipairs(getElementsByType("player")) do
            if getElementData(v, "loggedIn") then
                if shoutState == "outside" then
                    if getElementDimension(v) == interiorIdentity then
                        local tx, ty, tz = getElementPosition(v)
                        local dist = getDistanceBetweenPoints3D(intX, intY, intZ, tx, ty, tz)
                        if dist <= 20 then
                            table.insert(affected, {v, RGBToHex(interpolateBetween(255, 255, 255, 50, 50, 50, dist / 20, "Linear")), nil, true})
                        end
                    else
                        local tx, ty, tz = getElementPosition(v)
                        local dist = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz)
                        if dist <= 20 then
                            table.insert(affected, {v, RGBToHex(interpolateBetween(255, 255, 255, 50, 50, 50, dist / 20, "Linear"))})
                        end
                    end
                elseif shoutState == "inside" then
                    if getElementDimension(v) == extDim then
                        local tx, ty, tz = getElementPosition(v)
                        local dist = getDistanceBetweenPoints3D(extX, extY, extZ, tx, ty, tz)
                        if dist <= 20 then
                            table.insert(affected, {v, RGBToHex(interpolateBetween(255, 255, 255, 50, 50, 50, dist / 20, "Linear")), false, true})
                        end
                    else
                        local tx, ty, tz = getElementPosition(v)
                        local dist = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz)
                        if dist <= 20 then
                            table.insert(affected, {v, RGBToHex(interpolateBetween(255, 255, 255, 50, 50, 50, dist / 20, "Linear")), nil, true})
                        end
                    end
                else
                    if getElementDimension(v) == interiorIdentity then
                        local tx, ty, tz = getElementPosition(v)
                        local dist = getDistanceBetweenPoints3D(intX, intY, intZ, tx, ty, tz)
                        if dist <= 20 then
                            table.insert(affected, {v, RGBToHex(interpolateBetween(255, 255, 255, 50, 50, 50, dist / 20, "Linear")), false, true})
                        end
                    else
                        local tx, ty, tz = getElementPosition(v)
                        local dist = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz)
                        if dist <= 20 then
                            table.insert(affected, {v, RGBToHex(interpolateBetween(255, 255, 255, 50, 50, 50, dist / 20, "Linear")), nil, true})
                        end
                    end
                end
            end
        end

        if #affected > 0 then
            msg = firstToUpper(message)

            for i = 1, #affected do
                local dat = affected[i]

                if isElement(dat[1]) then
                    if dat[3] then
                        outputChatBox("[>o<] " .. dat[2] .. visibleName .. " ordítja: " .. msg, dat[1], 231, 217, 176, true)
                    else
                        if dat[4] then
                            if shoutState == "outside" then
                                outputChatBox(dat[2] .. visibleName .. " ordítja ((kívülről)): " .. msg, dat[1], 231, 217, 176, true)
                            else
                                outputChatBox(dat[2] .. visibleName .. " ordítja ((bentről)): " .. msg, dat[1], 231, 217, 176, true)
                            end
                        else
                            outputChatBox(dat[2] .. visibleName .. " ordítja: " .. msg, dat[1], 231, 217, 176, true)
                        end
                    end
                end
            end
        end

        setPedAnimation(source, "RIOT", "RIOT_shout", -1, false, false, false, false, 250, true)
    end
end)

addEvent("laughAnim", true)
addEventHandler("laughAnim", getRootElement(), function ()
    if source ~= client then
        return
    end

    setPedAnimation(client, "rapping", "laugh_01", -1, false, false, false, false, 250, true)
end)

function firstToUpper(str)
    return (utf8.gsub(str, "^%l", utf8.upper))
end

addEventHandler("onPlayerChat", getRootElement(), function()
    cancelEvent()
end)

function sendLocalDo(player, message)
    local tempPlayers = {}
    local playerElements = getElementsByType("player")
    local sourcePlayerName = getElementData(player, "visibleName"):gsub("_", " ")

    for k = 1, #playerElements do
        local element = playerElements[k]

        if element ~= player then
            local sourceX, sourceY, sourceZ = getElementPosition(player)
            local targetX, targetY, targetZ = getElementPosition(element)

            if getElementDimension(element) == getElementDimension(player) and getElementInterior(element) == getElementInterior(player) then
                if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 12 then
                    table.insert(tempPlayers, element)
                end
            end
        end
    end
    table.insert(tempPlayers, player)

    for i = 1, #tempPlayers do
        local element = tempPlayers[i]
        
        if element then
            outputChatBox(" *" .. firstToUpper(message) .. " ((#FF2850" .. sourcePlayerName .. "))", element, 255, 40, 80, true)
        end 
    end
end

function localAction(player, message)
    local tempPlayers = {}
    local playerElements = getElementsByType("player")
    local sourcePlayerName = getElementData(player, "visibleName"):gsub("_", " ")

    for k = 1, #playerElements do
        local element = playerElements[k]

        if element ~= player then
            local sourceX, sourceY, sourceZ = getElementPosition(player)
            local targetX, targetY, targetZ = getElementPosition(element)

            if getElementDimension(element) == getElementDimension(player) and getElementInterior(element) == getElementInterior(player) then
                if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 12 then
                    table.insert(tempPlayers, element)
                end
            end
        end
    end
    table.insert(tempPlayers, player)

    for i = 1, #tempPlayers do
        local element = tempPlayers[i]
        
        if element then
            outputChatBox("#C2A2DA** " .. sourcePlayerName .. " #C2A2DA" .. message, element, 194, 162, 218, true)

        end 
    end
end