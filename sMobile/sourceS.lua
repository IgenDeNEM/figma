local seexports = {
    sGuis = false,
    sConnection = false,
    sPermission = false,
    sChat = false,
    sWeapons = false
}

local callDatas = {}

local callPrice = 50

local function sightlangProcessExports()
    for k in pairs(seexports) do
        local res = getResourceFromName(k)
        if res and getResourceState(res) == "running" then
            seexports[k] = exports[k]
        else
            seexports[k] = false
        end
    end
end
sightlangProcessExports()
if triggerServerEvent then
    addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
if triggerLatentClientEvent then
    addEventHandler("onResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end

function safeCall(resourceName, fnName, ...)
    local res = getResourceFromName(resourceName)
    if res and getResourceState(res) == "running" then
        return call(res, fnName, ...)
    end
end

local connection = nil

if seexports.sConnection then
    connection = exports.sConnection:getConnection()
end

mobilesInUse = {}
local playersDialing = {}

ads = {}
loadedAds = {}

function onstr()
    for i = 1, 9 do
        ads[i] = {}
    end
    dbQuery(function(qh)
        local result = dbPoll(qh, 0)
        for k, v in pairs(result or {}) do
            if v.endTime > getRealTime().timestamp then
                table.insert(ads[v.type], v.id)
                loadedAds[v.id] = {
                    id = v.id,
                    senderCharId = v.senderCharId,
                    category = v.type,
                    subCategory = v.subType,
                    phoneNumber = v.number or "N/A",
                    senderName = v.owner:gsub("_", " "),
                    title = v.adTitle,
                    adtext = v.adText,
                    price = v.price,
                    highlight = fromJSON(v.highlighted),
                    hasPhoto = v.photo1 ~= nil,
                    someFlag = true,
                    image = {v.photo1, v.photo2, v.photo3, v.photo4}
                }
                setTimer(cancelAdvertisement, (v.endTime - getRealTime().timestamp) * 1000, 1, v.id, v.type)
            end
        end
    end, connection, "SELECT * FROM phoneads")
end
addEventHandler("onResourceStart", resourceRoot, onstr)

function countAdsByCategory(cat)
    local count = 0
    for _, _ in pairs(ads[cat]) do
        count = count + 1
    end
    return count
end

addEvent("requestAdCategoryBadges", true)
function requestAdCategoryBadges()
    local counts = {}
    for i = 1, 9 do
        counts[i] = countAdsByCategory(i)
    end
    local ownAds = {}
    local ownIds = {}
    for k, v in pairs(loadedAds) do
        if tonumber(v.senderCharId) == getElementData(client, "char.ID") then
            table.insert(ownIds, v.id)
        end
    end
    counts[1] = #ownIds
    triggerLatentClientEvent(client, "loadedAdCategoryBadges", client, counts)
end
addEventHandler("requestAdCategoryBadges", root, requestAdCategoryBadges)

addEvent("requestAdsForCategory", true)
function requestAdsForCategory(cat, player)
    if player then
        client = player
    end
    local adsForCategory = ads[cat]
    local ownAds = {}
    local ownIds = {}
    for k, v in pairs(loadedAds) do
        if tonumber(v.senderCharId) == getElementData(client, "char.ID") then
            ownIds[v.id] = true
        end
    end
    if cat == 1 then
        for k, v in pairs(loadedAds) do
            if tonumber(v.senderCharId) == getElementData(client, "char.ID") then
                table.insert(ownAds, k)
            end
        end
        adsForCategory = ownAds
    end
    local dataH, data, subH, sub = {}, {}, {}, {}
    for _, ad in pairs(adsForCategory) do
        if loadedAds[ad] and loadedAds[ad].highlight then
            table.insert(dataH, 1, ad)
            table.insert(subH, 1, ad)
        else
            table.insert(dataH, ad)
            table.insert(subH, ad)
        end
    end

    triggerLatentClientEvent(client, "loadedAdsForCategory", client, cat, dataH, data, subH, sub, ownIds)
end
addEventHandler("requestAdsForCategory", root, requestAdsForCategory)


addEvent("tryToPostAd", true)
function tryToPostAd(selectedAdCategory, adSubcat, adName, adPrice, adDescription, photoData, adTime, specialData)
    local adPrice = adPrice or 0
    local adName = adName or ""
    local adDescription = adDescription or ""
    local sender = client
    local senderNumber = mobilesInUse[sender] and mobilesInUse[sender].num
    for k, v in pairs(getElementsByType("player")) do
        local item = exports.sItems:playerHasItemWithData(v, 9, senderNumber)

        if item then
            foundItem = item
            break
        end
    end
    if foundItem then
        local currentBalance = tonumber(foundItem.data3) or 0
        if currentBalance >= (adPricePerHour * adTime) then
            exports.sItems:updateItemData3(sender, foundItem.dbID, currentBalance - (adPricePerHour * adTime))
        else
            triggerLatentClientEvent(client, "newAdResponse", client, "Nincs elég egyenlege a számon!")
            return
        end
    end
    photos = {}
    for k, v in pairs(photoData) do
        photos[k] = ""
        photos[k] = v[1]
    end
    dbExec(connection, "INSERT INTO phoneads SET type = ?, subtype = ?, adtitle = ?, price = ?, adtext = ?, images = ?, endtime = ?, highlighted = ?, photo1 = ?, photo2 = ?, photo3 = ?, photo4 = ?, number = ?, owner = ?, senderCharId = ?", selectedAdCategory, adSubcat, adName, adPrice, adDescription, 1,
    getRealTime().timestamp + (adTime * 3600), toJSON(specialData), photos[1], photos[2], photos[3], photos[4], mobilesInUse[client].num, getElementData(client, "visibleName"), getElementData(client, "char.ID"))
    maxID = 1
    dbQuery(function(qh, player)
        local result, num_affected_rows, last_insert_id = dbPoll(qh, 0)
        maxID = last_insert_id
        newAdResponse(player, false, maxID)
    end, {client}, connection, "SELECT id FROM phoneads")
    table.insert(ads[selectedAdCategory], #ads[selectedAdCategory])
    --loadedAds[maxID] = {id = maxID, senderCharId = getElementData(client, "char.ID"), category = selectedAdCategory, subCategory = adSubcat, phoneNumber = mobilesInUse[client].num or "N/A", senderName = getElementData(client, "visibleName"), title = adName, description = adDescription, price = adPrice, highlight = false, photos[1] ~= nil, true, image = {photos[1], photos[2], photos[3], photos[4]}}
    onstr(client, response)
end
addEventHandler("tryToPostAd", root, tryToPostAd)

function newAdResponse(player, v, maxID)
    triggerLatentClientEvent(player, "newAdResponse", player, v, maxID)
end

function cancelAdvertisement(id, cat)
    loadedAds[id] = nil
    for k, v in pairs(ads[cat] or {}) do
        if v == id then
            table.remove(ads[cat], k)
            break
        end
    end

    countAdsByCategory(cat)
    if client then
        requestAdsForCategory(cat, client)
    end
    dbExec(connection, "DELETE FROM phoneads WHERE id = ?", id)
end
addEvent("tryToDeleteAd", true)
addEventHandler("tryToDeleteAd", root, cancelAdvertisement)



addEvent("requestMobileAdForList", true)
function requestMobileAdForList(id)
    local ad = loadedAds[id]
    triggerLatentClientEvent(client, "loadedMobileAdForList", client, id, ad.title, ad.adtext, ad.price, ad.highlight, ad.image[1] ~= nil, checkOnline(ad.senderCharId))
end
addEventHandler("requestMobileAdForList", root, requestMobileAdForList)

function checkOnline(id)
    local onl = false
    for k, v in pairs(getElementsByType("player")) do
        if getElementData(v, "char.ID") == id then
            onl = true
        end
    end
    return onl
end

addEvent("requestMobileAdThumb", true)
function requestMobileAdThumb(id)
    local ad = loadedAds[id]
    if ad and ad.image[1] then
        triggerLatentClientEvent(client, "loadedMobileAdThumb", 500000, client, id, ad.image[1])
    end
end
addEventHandler("requestMobileAdThumb", root, requestMobileAdThumb)

addEvent("loadSingleAd", true)
function loadSingleAd(id)
    local ad = loadedAds[id]
    local tempTable = deepcopy(ad)
    if ad.adtext == "" then
        ad.adtext = false
    end
    tempTable.description = ad.adtext
    triggerLatentClientEvent(client, "loadedSingleAd", 500000, client, tempTable, false, checkOnline(ad.senderCharId))
end
addEventHandler("loadSingleAd", root, loadSingleAd)

addEvent("requestSingleAdImage", true)
function requestSingleAdImage(id, i)
    local ad = loadedAds[id]
    triggerLatentClientEvent(client, "gotSingleAdImage", 500000, client, id, i, ad.image[i])
end
addEventHandler("requestSingleAdImage", root, requestSingleAdImage)

addEvent("setPhoneToUse", true)
addEventHandler("setPhoneToUse", getRootElement(), function(itemData)
    if client then
        exports.sAnticheat:anticheatBan(client, "AC #66 - sMobile @sourceS:258")
    else
        local data2 = fromJSON(itemData.data2)

        mobilesInUse[source] = {dbID = itemData.dbID, num = itemData.data1}
        for k, v in pairs(data2) do
            mobilesInUse[source][k] = v
        end

        triggerClientEvent(source, "openPhone", source, itemData.data1, data2.noti, data2.ringtone, data2.sound, data2.vibration, data2.location, data2.voice)
    end
end)

addEvent("syncRingtoneSound", true)
addEventHandler("syncRingtoneSound", root, 
    function (ringtoneId)
        local phoneData = mobilesInUse[source]
        
        phoneData.ringtone = ringtoneId

        local newPhoneData = {
            noti = phoneData.noti,
            ringtone = phoneData.ringtone,
            sound = phoneData.sound,
            vibration = phoneData.vibration,
            location = phoneData.location,
            voice = phoneData.voice
        }

        exports.sItems:updateItemData2(client, phoneData.dbID, toJSON(newPhoneData))
    end
)

addEvent("syncNotiSound", true)
addEventHandler("syncNotiSound", root, 
    function (notiId)
        local phoneData = mobilesInUse[source]
        
        phoneData.noti = notiId

        local newPhoneData = {
            noti = phoneData.noti,
            ringtone = phoneData.ringtone,
            sound = phoneData.sound,
            vibration = phoneData.vibration,
            location = phoneData.location,
            voice = phoneData.voice
        }
        exports.sItems:updateItemData2(client, phoneData.dbID, toJSON(newPhoneData))
    end
)

addEvent("syncVibrationState", true)
addEventHandler("syncVibrationState", root, 
    function (vibrationState)
        local phoneData = mobilesInUse[source]
        
        phoneData.vibration = vibrationState

        local newPhoneData = {
            noti = phoneData.noti,
            ringtone = phoneData.ringtone,
            sound = phoneData.sound,
            vibration = phoneData.vibration,
            location = phoneData.location,
            voice = phoneData.voice
        }

        exports.sItems:updateItemData2(client, phoneData.dbID, toJSON(newPhoneData))
    end
)

addEvent("syncSoundState", true)
addEventHandler("syncSoundState", root, 
    function (soundState)
        local phoneData = mobilesInUse[source]
        
        phoneData.sound = soundState

        local newPhoneData = {
            noti = phoneData.noti,
            ringtone = phoneData.ringtone,
            sound = phoneData.sound,
            vibration = phoneData.vibration,
            location = phoneData.location,
            voice = phoneData.voice
        }

        exports.sItems:updateItemData2(client, phoneData.dbID, toJSON(newPhoneData))
    end
)

addEvent("syncVoiceState", true)
addEventHandler("syncVoiceState", root, 
    function (voiceState)
        local phoneData = mobilesInUse[source]
        
        phoneData.voice = voiceState

        local newPhoneData = {
            noti = phoneData.noti,
            ringtone = phoneData.ringtone,
            sound = phoneData.sound,
            vibration = phoneData.vibration,
            location = phoneData.location,
            voice = phoneData.voice
        }

        exports.sItems:updateItemData2(client, phoneData.dbID, toJSON(newPhoneData))
    end
)

addEvent("setPhoneUnUse", true)
addEventHandler("setPhoneUnUse", getRootElement(), function()
    if client then
        exports.sAnticheat:anticheatBan(client, "AC #67 - sMobile @sourceS:373")
    else
        if playersDialing[source] or callDatas[source] then
            if callDatas[source][1] then
                local targetElement = callDatas[source][1]
                triggerLatentClientEvent(source, "hangedUpPhone", source)
                if isElement(targetElement) then
                    triggerLatentClientEvent(targetElement, "hangedUpPhone", targetElement)
                    triggerClientEvent(targetElement, "setVoiceCallPartner", targetElement, false)
                    triggerEvent("setVoiceCallPartner", targetElement, false)
                    triggerLatentClientEvent("callSoundForPlayer", targetElement)
                    triggerLatentClientEvent("callSoundForPlayer", source)
                    callDatas[source] = {targetElement, false}
                    callDatas[targetElement] = {source, false}
                end
                triggerClientEvent(source, "setVoiceCallPartner", source, false)
            else
                triggerLatentClientEvent(source, "hangedUpPhone", source)
                triggerClientEvent(source, "setVoiceCallPartner", source, false)
                callDatas[source] = {false, false}
                triggerEvent("setVoiceCallPartner", source, false)
            end
        end

        setElementData(source, "mobile", false)
        setElementData(source, "calling", false)
        mobilesInUse[source] = nil
    end
end)


function getPlayerCurrentNumber(sourceElement)
    if mobilesInUse[sourceElement] then
        return mobilesInUse[sourceElement].num
    end
end

addEvent("dialNumber", true)
addEventHandler("dialNumber", getRootElement(), function(targetNumber)
    if client and client == source then
        local clientNumber = mobilesInUse[client].num
        
        --[[if status == 112 then
            triggerLatentClientEvent(client, "phoneCallResponse", client, status, "emergency", 1, 1)
        elseif status == 1818 then
            triggerLatentClientEvent(client, "phoneCallResponse", client, status, "services", 1, 1)
        elseif status == 387579460801 then
            triggerLatentClientEvent(client, "phoneCallResponse", client, status, "moneyStackBuyer", 1, 1)
        else--]]


        if targetNumber == 112 then
            triggerLatentClientEvent(client, "phoneCallResponse", client, targetNumber, "emergency", 1, 1)
        elseif targetNumber == 5550161 then
            triggerLatentClientEvent(client, "phoneCallResponse", client, targetNumber, "jimmy", 1, 1)
        elseif targetNumber == 5550162 then
            triggerLatentClientEvent(client, "phoneCallResponse", client, targetNumber, "pötyi", 1, 1)
        elseif targetNumber == 1818 then
            triggerLatentClientEvent(client, "phoneCallResponse", client, targetNumber, "services", 1, 1)
        elseif targetNumber == 387579460801 then
            triggerLatentClientEvent(client, "phoneCallResponse", client, targetNumber, "moneyStackBuyer", 1, 1)
        elseif targetNumber == 73382228466 then

            if exports.sSummerevent:canCall(client) then
                triggerLatentClientEvent(client, "phoneCallResponse", client, targetNumber, "summer", 1, 1)
                exports.sSummerevent:startSummerCall(client)
            else
                triggerLatentClientEvent(client, "phoneCallResponse", client, targetNumber, "busy", 1, 1)
            end
        else
            local targetElement = findPlayerForPhone(targetNumber)

            local item = exports.sItems:playerHasItemWithData(client, 9, tonumber(clientNumber))

            local currentBalance = tonumber(item.data3) or 0

            if currentBalance < callPrice then
                exports.sGui:showInfobox(client, "e", "Nincs elegendő egyenleged a hívás indításához.")
                triggerLatentClientEvent(client, "phoneCallResponse", client, clientNumber, "busy", 1, 1)
                return
            end

            if isElement(targetElement) and targetElement ~= client then
                local item = exports.sItems:playerHasItemWithData(targetElement, 9, tonumber(targetNumber))


                local settings = fromJSON(item.data2)

                local sound = settings.sound or true
                local vibration = settings.sound or true

                callDatas[client] = {targetElement, false}
                callDatas[targetElement] = {client, false}

                triggerLatentClientEvent(targetElement, "phoneCallResponse", targetElement, clientNumber, "incoming", sound, vibration)
                if sound then

                    local ringtone = settings.ringtone or 1
                    callDatas[targetElement] = {client, true}
                    callDatas[client] = {targetElement, true}
                    triggerLatentClientEvent("callSoundForPlayer", targetElement, ringtone, vibration)
                end
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #68 - sMobile @sourceS:459")
    end
end)

addEvent("answerPhone", true)
addEventHandler("answerPhone", root, function()
    if client then
        local targetElement = callDatas[client][1]

        triggerLatentClientEvent(targetElement, "phoneCallResponse", targetElement, status, "incall", 1, 1)
        triggerLatentClientEvent(client, "phoneCallResponse", client, status, "incall", 1, 1)
        
        callDatas[client] = {targetElement, true}
        callDatas[targetElement] = {client, true}

        triggerClientEvent("callSoundForPlayer", client)
        triggerClientEvent("callSoundForPlayer", targetElement)

        triggerClientEvent(client, "setVoiceCallPartner", client, targetElement)
        triggerClientEvent(targetElement, "setVoiceCallPartner", targetElement, client)
        triggerEvent("setVoiceCallPartner", client, targetElement, client)
    else
        exports.sAnticheat:anticheatBan(client, "AC #70 - sMobile @sourceS:479")
    end
end)

function onQuit()
    if callDatas[source] and callDatas[source][2] then
        local targetElement = callDatas[source][1]
        triggerLatentClientEvent(source, "hangedUpPhone", source)
        if isElement(targetElement) then
            triggerLatentClientEvent(targetElement, "hangedUpPhone", targetElement)
            triggerClientEvent(targetElement, "setVoiceCallPartner", targetElement, false)
            triggerEvent("setVoiceCallPartner", targetElement, false)
            triggerLatentClientEvent("callSoundForPlayer", targetElement)
            triggerLatentClientEvent("callSoundForPlayer", source)
            callDatas[source] = {targetElement, false}
            callDatas[targetElement] = {source, false}
        end
        triggerClientEvent(source, "setVoiceCallPartner", source, false)
    end
end
addEventHandler("onPlayerQuit", root, onQuit)

function onWaste()
    if callDatas[source] and callDatas[source][2] then
        local targetElement = callDatas[source][1]
        triggerLatentClientEvent(source, "hangedUpPhone", source)
        if isElement(targetElement) then
            triggerLatentClientEvent(targetElement, "hangedUpPhone", targetElement)
            triggerClientEvent(targetElement, "setVoiceCallPartner", targetElement, false)
            triggerEvent("setVoiceCallPartner", targetElement, false)
            triggerLatentClientEvent("callSoundForPlayer", targetElement)
            triggerLatentClientEvent("callSoundForPlayer", source)
            callDatas[source] = {targetElement, false}
            callDatas[targetElement] = {source, false}
        end
        triggerClientEvent(source, "setVoiceCallPartner", source, false)
    end
end
addEventHandler("onPlayerWasted", root, onWaste)

addEvent("hangUpPhone", true)
addEventHandler("hangUpPhone", root, function()
    if client and client == source then
        if callDatas[client] and callDatas[client][2] then
            local targetElement = callDatas[client][1]
            if isElement(targetElement) then
                triggerLatentClientEvent(targetElement, "hangedUpPhone", targetElement)
            end
            triggerLatentClientEvent(client, "hangedUpPhone", client)
            if isElement(targetElement) then
                triggerClientEvent(targetElement, "setVoiceCallPartner", targetElement, false)
                triggerEvent("setVoiceCallPartner", targetElement, false)
            end
            triggerClientEvent(client, "setVoiceCallPartner", client, false)
    
            callDatas[client] = {targetElement, false}
            callDatas[targetElement] = {client, false}
            triggerLatentClientEvent("callSoundForPlayer", targetElement)
            triggerLatentClientEvent("callSoundForPlayer", client)
        else
            triggerLatentClientEvent(client, "hangedUpPhone", client)
            triggerClientEvent(client, "setVoiceCallPartner", client, false)
            callDatas[client] = {targetElement, false}
            triggerEvent("setVoiceCallPartner", client, false)
        end
    end
end)

addEvent("syncCameraShutterSound", true)
addEventHandler("syncCameraShutterSound", resourceRoot, function(playerElement)
    if client and client == source and mobilesInUse[client] then
        triggerClientEvent(playerElement, "syncCameraShutterSound", playerElement)
    else
        exports.sAnticheat:anticheatBan(client, "AC #71 - sMobile @sourceS:549")
    end
end)

function findPlayerForPhone(playerNumber, debugInfo)
    for _, playerElement in ipairs(getElementsByType("player")) do
        if exports.sItems:playerHasItemWithData(playerElement, 9, playerNumber) then
            local developmentMode = false
            if developmentMode then
            end
            return playerElement
        end
    end
end

--[[triggerServerEvent("syncLocationState", localPlayer, locationState)]]
local locationStates = {}
addEvent("syncLocationState", true)
addEventHandler("syncLocationState", root, function(locationState)
    locationStates[client] = locationState
end)

addEvent("tryToHighlightAd", true)
function tryToHighlightAd(id)
    local pp = exports.sCore:getPP(client)
    if pp >= 300 then
        local ad = loadedAds[id]
        ad.highlight = true
        dbExec(connection, "UPDATE phoneads SET highlighted = ? WHERE id = ?", toJSON(true), id)
        triggerLatentClientEvent(client, "loadedSingleAd", 500000, client, ad, true, checkOnline(ad.senderCharId))
        exports.sCore:takePP(client, 300)
        exports.sGui:showInfobox(client, "s", "Sikeresen kiemelted a hirdetést!")
    else
        exports.sGui:showInfobox(client, "e", "Nincs elég PrémiumPontod!")
    end
end
addEventHandler("tryToHighlightAd", root, tryToHighlightAd)

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

function sendEventSMS(targetPlayer, message, number)
    local senderNumber = number or 5552368
    local recipientNumber = getPhoneNumber(targetPlayer)
    if recipientNumber then
        local id = 1
        local msgType = 1
        local data = message
        triggerClientEvent(targetPlayer, "eventSendSMS", targetPlayer, tonumber(recipientNumber), msgType, data, senderNumber)
    end
end