addEvent("requestBackfireData", true)
addEventHandler("requestBackfireData", getRootElement(), function(veh)
    local backfire = getElementData(veh, "backfire") or false
    local backfireData = getElementData(veh, "customBackfire") or {0, 0, 0}

    if backfireData then
        triggerClientEvent(root, "gotBackfireDataForVehicle", veh, backfire, backfireData)
    end
end)

addEvent("syncBackfireState", true)
addEventHandler("syncBackfireState", getRootElement(), function(veh, sync, bf, n)
    local backfire = getElementData(veh, "backfire") or false
    local backfireData = getElementData(veh, "customBackfire") or {0, 0, 0}

    if backfireData then
        triggerClientEvent(sync, "syncBackfireState", client, veh, bf, backfireData[1], n, backfireData[2], backfireData[3])
    end
end)

addEventHandler("onElementDataChange", getRootElement(), function(dataName, oldValue, newValue)
    local elementType = getElementType(source)

    if elementType == "vehicle" then
        if dataName == "backfire" then
            local backfireData = getElementData(source, "customBackfire") or {0, 0, 0}
            triggerClientEvent(root, "gotBackfireDataForVehicle", source, newValue, backfireData)
        elseif dataName == "customBackfire" then
            local backfire = getElementData(source, "backfire") or false
            triggerClientEvent(root, "gotBackfireDataForVehicle", source, backfire, newValue)
        end
    end
end)