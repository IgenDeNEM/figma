suitZones = {
    {962.97387695312, -974.81433105469, 38.931407928467},
    {1037.1910400391, -954.728515625, 42.533374786377},
}

suitPositions = {
    [1] = {
        {963.41516113281, -969.25952148438, 38.938411712646},
        {958.20104980469, -972.56506347656, 38.82523727417},
    },
    [2] = {
        {1037.1910400391, -954.728515625, 42.533374786377},
        {1039.1755371094, -967.27294921875, 42.53466796875},
    },
}

suitcasePlayers = {}

missionPlayers = {}

missionColshapes = {}

dropOffColshapes = {}

dropOffBlips = {}

dropOffInts = {}

caseTimers = {}

addEvent("requestSummerEventBags", true)
addEventHandler("requestSummerEventBags", root, function()
    triggerClientEvent(client, "gotSummerEventBags", client, missionPlayers)
end)

function getPlayerMobile(player)
    local currentNum = false
    local items = exports.sItems:getElementItems(player)
    for k, v in pairs(items) do
        if v.itemId == 9 then
            currentNum = v.data1
        end
    end
    return currentNum
end

function sendSummerSMS(player)
    if isElement(player) then
        dropOffInts[player] = nil
        local recipientNumber = getPlayerMobile(player)
        if recipientNumber then
            local charID = getElementData(player, "char.ID")
            if not missionPlayers[charID] then
                local timestamp = getRealTime().timestamp
                local message = {
                    sender = 73382228466,
                    recipient = recipientNumber,
                    timestamp = timestamp,
                    msgType = 1,
                    id = 1,
                    state = 1,
                    text = "Üdv. Egy ügyfelünk utazás közben elvesztette a csomagját. Amennyiben tud segíteni a poggyász megtalálásában, kérem hívjon."
                }

                if not getElementData(player, "smsInbox") then
                    setElementData(player, "smsInbox", {})
                end
                local inbox = getElementData(player, "smsInbox")
                table.insert(inbox, message)
                setElementData(player, "smsInbox", inbox)
                cacheEntry = { 73382228466, timestamp, 1, message.text }

                gotEvent[charID] = true

                triggerClientEvent(player, "gotSMSCache", player, { cacheEntry }, true, true, true)
            end
        end
    end
end

function canCall(player)

    local charID = getElementData(player, "char.ID")
    
    if isElement(missionColshapes[charID]) then
        return false
    end

    if missionPlayers[charID] then
        return false
    end

    if not gotEvent[charID] then
        return false
    end

    if isElement(dropOffBlips[player]) then
        return false
    end

    if dropOffInts[player] then
        return false
    end

    return true
end

function onStart()
    for k, player in pairs(getElementsByType("player")) do
        setElementData(player, "carryingSummerEvent", false)
        caseTimers[player] = setTimer(sendSummerSMS, math.random((1000 * 60) * 20, (1000 * 60) * 30), 1, player)
    end
end
addEventHandler("onResourceStart", resourceRoot, onStart)


addEventHandler("onElementDataChange", getRootElement(), function(dataName, oldValue, newValue)
	local elementType = getElementType(source)

	if elementType == "player" then
		if dataName == "loggedIn" and newValue then
            caseTimers[source] = setTimer(sendSummerSMS, math.random((1000 * 60) * 20, (1000 * 60) * 30), 1, source)
            setTimer(function(player)
                local charID = getElementData(player, "char.ID")
                if missionPlayers[charID] then
                    x, y, rx, ry = unpack(missionPlayers[charID])
                    triggerClientEvent(player, "gotSummerEventBag", player, getElementData(player, "char.ID"), x, y, rx, ry)
                end
            end, 15000, 1, source)
        end
    end
end)

function startSummerCall(player)
    local charID = getElementData(player, "char.ID")
    local randZone = math.random(1, #suitZones)

    local randCase = math.random(1, #suitPositions[randZone])

    local zone = suitZones[randZone]

    local case = suitPositions[randZone][randCase]

    local interior = exports.sInteriors:getRandomUsableInterior()

    local x, y, z = exports.sInteriors:getInteriorOutsidePosition(interior)

    local x, y = getRandomPosition()

    local hX, hY, hZ = exports.sMetaldetector:findNearestHoleCoord(x, y)
    if not hX then
        x, y = getRandomPosition()
        hX, hY, hZ = exports.sMetaldetector:findNearestHoleCoord(x, y)
    end
    missionColshapes[charID] = createColSphere(hX, hY, hZ, 1.5)

    local rx, ry = 0, 0
    triggerClientEvent("gotSummerEventBag", player, getElementData(player, "char.ID"), x, y, rx, ry)

    missionPlayers[charID] = {x, y, rx, ry}
end

gotEvent = {}

function suitCaseColHit(hitElement)
    if getElementType(hitElement) == "player" then
        local player = hitElement
        charID = getElementData(player, "char.ID")
        if missionColshapes[charID] and source == missionColshapes[charID] then
            triggerClientEvent("gotSummerEventBag", player, charID)

            setElementData(player, "carryingSummerEvent", true)
            destroyElement(missionColshapes[charID])
            missionColshapes[charID] = nil

            local interior = exports.sInteriors:getRandomUsableInterior()
            local x, y, z = exports.sInteriors:getInteriorOutsidePosition(interior)

            triggerClientEvent(player, "markEventInterior", player, interior, "summerevent")

            exports.sGui:showInfobox(player, "i", "Vidd el a poggyászt a nyaralók szállására! Keresd a zöld bőrönd ikont a térképen.")

            dropOffBlips[player] = createBlip(x, y, z, 32, 2, 78, 205, 196, 255, 0, 99999, player)

            setElementData(dropOffBlips[player], "tooltipText", "A nyaralók szállása (" .. interior .. ")")

            dropOffColshapes[player] = createColSphere(x, y, z, 1.5)

            dropOffInts[player] = interior
        else
            if getElementData(hitElement, "carryingSummerEvent")  then
                if dropOffColshapes[player] and source == dropOffColshapes[player] then

                    gotEvent[charID] = nil

                    setElementData(player, "carryingSummerEvent", false)
                    exports.sGui:showInfobox(player, "s", "Eljuttattad a poggyászt. Jutalmad egy Vacation Chest.")

                    exports.sItems:giveItem(player, 751, 1)

                    local interior = dropOffInts[player]
                    triggerClientEvent(player, "deMarkEventInterior", player, interior)

                    if isElement(dropOffBlips[player]) then
                        destroyElement(dropOffBlips[player])
                    end

                    if isElement(dropOffColshapes[player]) then
                        destroyElement(dropOffColshapes[player])
                    end
                    missionPlayers[charID] = nil

                    if isTimer(caseTimers[player]) then
                        killTimer(caseTimers[player])
                    end
                    
                    caseTimers[player] = setTimer(sendSummerSMS, math.random((1000 * 60) * 20, (1000 * 60) * 30), 1, player)
                end
            end
        end
    end
end
addEventHandler("onColShapeHit", root, suitCaseColHit)

function getRandomPosition()
    local minX = -2621.5075683594
    local maxX = 2737.0185546875
    local minY = -2839.5927734375
    local maxY = 300.68179321289

    local x = math.random() * (maxX - minX) + minX
    local y = math.random() * (maxY - minY) + minY

    return x, y
end