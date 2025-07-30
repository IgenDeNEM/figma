local phoneNumbers = {}

addEventHandler("onPlayerJoin", root, function()
    local player = source
    local phoneNumber = getElementData(player, "phoneNumber")
    if phoneNumber then
        phoneNumbers[phoneNumber] = player
    end
end)

addEventHandler("onPlayerQuit", root, function()
    local player = source
    local phoneNumber = getElementData(player, "phoneNumber")
    if phoneNumber then
        phoneNumbers[phoneNumber] = nil
    end
end)

local SMSPrice = 5

addEvent("tryToSendSMS", true)
addEventHandler("tryToSendSMS", root, function(num, id, msgType, data)
    local sender = client
    local senderNumber = mobilesInUse[sender] and mobilesInUse[sender].num
    local recipientNumber = tonumber(num)
    if recipientNumber == 131 then
        local timestamp = getRealTime().timestamp

        for k, v in pairs(getElementsByType("player")) do
            local item = exports.sItems:playerHasItemWithData(v, 9, senderNumber)

            if item then
                foundItem = item
                break
            end
        end
        if foundItem then
            local newBalance = tonumber(foundItem.data3) or 0
            local message = {
                sender = 131,
                recipient = recipientNumber,
                timestamp = timestamp,
                msgType = 1,
                id = 1,
                state = 1,
                text = "Az ön elérhető egyenlege a " .. exports.sMobile:formatPhoneNumber(senderNumber) .. " telefonszámon: " .. exports.sGui:thousandsStepper(newBalance) .. " $ Sight-COM"
            }

            if not getElementData(sender, "smsInbox") then
                setElementData(sender, "smsInbox", {})
            end
            local inbox = getElementData(sender, "smsInbox")
            table.insert(inbox, message)
            setElementData(sender, "smsInbox", inbox)
            cacheEntry = { 131, timestamp, 1, message.text }

            local item = foundItem

            local settings = fromJSON(item.data2)
        
            local noti = settings.noti or false
        
            local vibration = settings.sound or false

            triggerClientEvent(sender, "gotSMSCache", sender, { cacheEntry }, true, noti, vibration)
            triggerClientEvent(sender, "smsSendRespone", sender, num, id, 1)
            return
        end

        return
    end

    for k, v in pairs(getElementsByType("player")) do
        local item = exports.sItems:playerHasItemWithData(v, 9, senderNumber)

        if item then
            foundItem = item
            break
        end
    end
    if foundItem then
        local currentBalance = tonumber(foundItem.data3) or 0
        if currentBalance >= smsPrice then
            exports.sItems:updateItemData3(sender, foundItem.dbID, currentBalance - smsPrice)
        else
            exports.sGui:showInfobox(sender, "e", "Nincs elegendő összeged az SMS elküldéséhez.")
            return
        end
    end
    local recipient = findPlayerForPhone(recipientNumber)
    
    if not recipient then
        triggerClientEvent(sender, "smsSendRespone", sender, num, id, -1)
        return
    end

    if recipient == client then
        return
    end

    local item = exports.sItems:playerHasItemWithData(recipient, 9, num)

    local settings = fromJSON(item.data2)

    local noti = settings.noti or 1

    local vibration = settings.sound or true

    triggerClientEvent(recipient, "gotSMSCache", recipient, { cacheEntry }, true, settings.noti, settings.sound)
    triggerClientEvent(sender, "smsSendRespone", sender, num, id, 1)

    triggerClientEvent("notiSoundForPlayer", recipient, noti, vibration)

    local message = {
        sender = senderNumber,
        recipient = recipientNumber,
        timestamp = getRealTime().timestamp,
        msgType = msgType,
        id = id,
        state = 1,
    }
    if msgType == 1 then
        message.text = data
    elseif msgType == 2 then
        local imageData = data[2]
        local metadata = data[3]
        local timestamp = getRealTime().timestamp
        imageFilename = "sms_pics/" .. senderNumber .. "_" .. recipientNumber .. "_" .. timestamp .. ".dds"
        local file = fileCreate(imageFilename)
        if file then
            fileWrite(file, imageData)
            fileClose(file)
            message.imageFilename = imageFilename
            message.metadata = metadata
        else
            triggerClientEvent(sender, "smsSendRespone", sender, num, id, -1)
            return
        end
    elseif msgType == 3 then
        message.location = data
    else
        triggerClientEvent(sender, "smsSendRespone", sender, num, id, -1)
        return
    end

    if not getElementData(recipient, "smsInbox") then
        setElementData(recipient, "smsInbox", {})
    end
    local inbox = getElementData(recipient, "smsInbox")
    table.insert(inbox, message)
    setElementData(recipient, "smsInbox", inbox)

    local cacheEntry = {}
    if msgType == 1 then
        cacheEntry = { senderNumber, message.timestamp, msgType, message.text }
    elseif msgType == 2 then
        local cData = imageFilename .. "#" .. "#" .. "asd" .. "#" .. data[3][2] .. "#" .. data[3][3] .. "#" .. data[3][4] .. "#" .. data[3][5] .. "#" .. data[3][6] .. "#" .. data[3][7] .. "#" .. data[3][8] .. "#" .. data[3][9] .. "#" .. data[3][10]
        cacheEntry = { senderNumber, message.timestamp, msgType, cData, {data[4], data[4]}}
    elseif msgType == 3 then
        cacheEntry = { senderNumber, message.timestamp, msgType, message.location }
    end
end)

addEvent("requestSMSPhoto", true)
addEventHandler("requestSMSPhoto", root, function(imageFilename)
    local player = client

    local inbox = getElementData(player, "smsInbox")
    if not inbox then
        triggerClientEvent(player, "smsPhotoDownloaded", player, imageFilename, nil)
        return
    end
    local found = false
    local imageData = nil
    for _, message in ipairs(inbox) do
        if message.msgType == 2 and message.imageFilename == imageFilename then
            local file = fileOpen(message.imageFilename)
            if file then
                imageData = fileRead(file, fileGetSize(file))
                fileClose(file)
                found = true
                break
            end
        end
    end

    if found and imageData then
        local speed = 500000
        triggerLatentClientEvent(player, "smsPhotoDownloaded", speed, false, player, imageFilename, imageData)
    else
        triggerClientEvent(player, "smsPhotoDownloaded", player, imageFilename, nil)
    end
end)
