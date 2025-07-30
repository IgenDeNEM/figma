function handleCasinoColors()
    currentFirstColor = currentFirstColor + 1
    if currentFirstColor > #firstFloor then
        currentFirstColor = 1
    end

    currentRoom = currentRoom + 1
    if currentRoom > #roomColors then
        currentRoom = 1
    end
end

function syncCasinoColors(syncTo)
    triggerClientEvent(syncTo, "syncCasinoColors", getRootElement(), currentFirstColor, currentRoom)
end

addEvent("syncCasinoColors", true)
addEventHandler("syncCasinoColors", getRootElement(), function()
    syncCasinoColors(client)
end)

addEvent("buySSC", true)
addEventHandler("buySSC", getRootElement(), function(amount)
    if client == source then
        if amount > 5000000 or amount < 1000 then
            exports.sAnticheat:anticheatBan(client, "AC #2 - sCasino @sourceS:26")
        else
            if exports.sCore:getMoney(client) >= amount * 5 and exports.sCore:takeMoney(client, amount * 5) then
                exports.sCore:giveSSC(client, amount)
            else
                exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #3 - sCasino @sourceS:35")
    end
end)

addEvent("sellSSC", true)
addEventHandler("sellSSC", getRootElement(), function(amount)
    if client == source then
        if amount > 5000000 or amount < 1000 then
            exports.sAnticheat:anticheatBan(client, "AC #4 - sCasino @sourceS:43")
        else
            if exports.sCore:getSSC(client) >= amount and exports.sCore:takeSSC(client, amount) then
                local tax = math.ceil(amount * 5 * 0.1)
                exports.sCore:giveMoney(client, amount * 5 - tax)
            else
                exports.sGui:showInfobox(client, "e", "Nincs elég SSC-d!")
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #5 - sCasino @sourceS:51")
    end
end)

addEventHandler("onResourceStart", getRootElement(), function(res)
    if res == getThisResource() then
        handleCasinoColors()
        setTimer(handleCasinoColors, 60000, 0)
    end

    for i = 1, #syncZoneCoords do
        local zoneDetails = syncZoneCoords[i]

        if zoneDetails then
            zoneDetails[8] = createColRectangle(zoneDetails[1], zoneDetails[2], zoneDetails[3], zoneDetails[4])

            if isElement(zoneDetails[8]) then
                setElementID(zoneDetails[8], "casinoSyncZone"..i)
                setElementInterior(zoneDetails[8], zoneDetails[5])
                setElementDimension(zoneDetails[8], zoneDetails[6])
            end
        end
    end
end)

addEvent("requestSSC", true)
addEventHandler("requestSSC", getRootElement(), function()
    triggerClientEvent(client, "refreshSSC", client, exports.sCore:getSSC(client) or 0)
end)
