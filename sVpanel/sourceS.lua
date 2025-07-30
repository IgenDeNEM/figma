function sendVenomValues(client, pedveh)
    local data = {}

    for i = 1, #tuningValues do
        data[tuningValues[i][1]] = getElementData(pedveh, "performance." .. tuningValues[i][1], tuningValue) or 0
    end

    triggerClientEvent(client, "gotVenomValues", client, pedveh, data)
end

addEvent("requestVenomValues", true)
addEventHandler("requestVenomValues", getRootElement(), function(pedveh)
    if client == source then
        local pedveh = pedveh == getPedOccupiedVehicle(client) and pedveh

        if isElement(pedveh) then
            sendVenomValues(client, pedveh)
        end
    else
        exports.sAnticheat:anticheatBan(client, "sVpanel >> requestVenomValue -> @sourceS.lua/20")
    end
end)

addEvent("setVenomValue", true)
addEventHandler("setVenomValue", getRootElement(), function(pedveh, tuningData, tuningValue)
    if client == source then
        if exports.sPermission:hasPermission(client, "canUseVpanel") then
            local pedveh = pedveh == getPedOccupiedVehicle(client) and pedveh

            if isElement(pedveh) then
                setElementData(pedveh, "performance." .. tuningData, tuningValue)
                sendVenomValues(client, pedveh)
                exports.sTuning:makeTuning(pedveh)
            else
                exports.sGui:showInfobox(client, "e", "Nem ülsz járműben!")
            end
        else
            exports.sAnticheat:anticheatBan(client, "sVpanel >> setVenomValue -> @sourceS.lua/39")
        end
    else
        exports.sAnticheat:anticheatBan(client, "sVpanel >> setVenomValue -> @sourceS.lua/42")
    end
end)