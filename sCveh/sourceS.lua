addEvent("openTheDoor", true)
addEventHandler("openTheDoor", getRootElement(), function(val, syncPlayers, syncPlayersEx, openRatio)
    local veh = getPedOccupiedVehicle(client)
    if veh and veh == source then
        if openRatio > 0 then
            setVehicleDoorOpenRatio(veh, val, 0, 250)
        else
            setVehicleDoorOpenRatio(veh, val, 1, 500)
        end
        
        triggerClientEvent(syncPlayers, "playTheDoorSound", veh, veh, openRatio, true)
        triggerClientEvent(syncPlayersEx, "playTheDoorSound", veh, veh, openRatio, false)
    else
        exports.sAnticheat:anticheatBan(client, "AC #54 - sCveh @sourceS:14")
    end
end)

addEvent("playWindowSound", true)
addEventHandler("playWindowSound", getRootElement(), function(syncPlayers)
    local veh = getPedOccupiedVehicle(client)
    if veh and veh == source then
        local occupants = {}
        local affecteds = {}

        for i = 1, #syncPlayers do
            local data = syncPlayers[i]

            if isElement(data[1]) then
                if data[2] == "2d" then
                    table.insert(occupants, data[1])
                elseif data[2] == "3d" then
                    table.insert(affecteds, data[2])
                end
            end
        end

        triggerClientEvent(occupants, "playWindowSound", veh, "2d")
        triggerClientEvent(affecteds, "playWindowSound", veh, "3d")
    else
        exports.sAnticheat:anticheatBan(client, "AC #55 - sCveh @sourceS:40")
    end
end)