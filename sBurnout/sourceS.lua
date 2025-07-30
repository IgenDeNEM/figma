addEvent("damageWheels", true)
addEventHandler("damageWheels", getRootElement(), function(damaged)
    local veh = getPedOccupiedVehicle(client)

    if veh == source then
        if damaged == 1 then
            setVehicleWheelStates(veh, -1, 1, -1, -1)
        elseif damaged == 2 then
            setVehicleWheelStates(veh, -1, -1, -1, 1)
        elseif damaged == 3 then
            setVehicleWheelStates(veh, 1, -1, -1, -1)
        elseif damaged == 4 then
            setVehicleWheelStates(veh, -1, -1, 1, -1)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #9 - sBurnout @sourceS:16")
    end
end)