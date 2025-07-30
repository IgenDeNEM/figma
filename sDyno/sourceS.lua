local sightDynoCols = {}
local vehiclesInSightDyno = {}

addEvent("exitFromDynoPad", true)
addEventHandler("exitFromDynoPad", getRootElement(), function()
    local pedveh = getPedOccupiedVehicle(client)

    if isElement(pedveh) and vehiclesInSightDyno[pedveh] then
        exports.sNocol:enableVehicleNoCol(pedveh, 10000)

        local pad = vehiclesInSightDyno[pedveh]
        local x, y, z = pads[pad][4], pads[pad][5], pads[pad][6]

        setElementPosition(pedveh, x, y, z)

        if pad == 2 then
            setElementRotation(pedveh, 0, 0, 135)
        else
            setElementRotation(pedveh, 0, 0, 0)
        end

        local occupants = getVehicleOccupants(pedveh)
        triggerClientEvent(occupants, "endDynoMode", pedveh)

        for k, v in pairs(occupants) do
            setElementDimension(v, 0)
        end

        setElementDimension(pedveh, 0)

        vehiclesInSightDyno[pedveh] = nil
    end
end)

addEvent("startDynoMeter", true)
addEventHandler("startDynoMeter", getRootElement(), function()
    local pedveh = getPedOccupiedVehicle(client)

    if isElement(pedveh) and vehiclesInSightDyno[pedveh] then
        if exports.sCore:takeMoney(client, 500) then
            setElementData(pedveh, "vehicle.handbrake", false)
            setElementFrozen(pedveh, false)
            triggerClientEvent(getVehicleOccupants(pedveh), "canStartDynoMeter", client)
        else
            exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
        end
    end
end)

addEvent("printDynoTicket", true)
addEventHandler("printDynoTicket", getRootElement(), function(lines, null100, null200, quarter, quarterSpeed, vmax, brake, maxSpeed)
    local pedveh = getPedOccupiedVehicle(client)

    if isElement(pedveh) and vehiclesInSightDyno[pedveh] then
        local modelId = getElementModel(pedveh)
        if getElementData(pedveh, "vehicle.customModel") then
            modelId = getElementData(pedveh, "vehicle.customModel")
        end
        local manufacturer = exports.sVehiclenames:getCustomVehicleManufacturer(modelId)
        local afterManufacturer = utf8.gsub(exports.sVehiclenames:getCustomVehicleName(modelId), manufacturer .. " ", "")
        afterManufacturer = utf8.sub(afterManufacturer, utf8.len(manufacturer) + 1, utf8.len(afterManufacturer))

        exports.sItems:giveItem(client, 438, 1, false, toJSON({
            lines = lines, 
            null100 = null100, 
            null200 = null200, 
            quarter = quarter, 
            quarterSpeed = quarterSpeed, 
            vmax = vmax, 
            brake = brake, 
            maxSpeed = maxSpeed,
            date = getRealTime().timestamp,
            make = utf8.upper(manufacturer),
            model = utf8.upper(afterManufacturer),
            plate = getVehiclePlateText(pedveh)
        }, true))

        exports.sGui:showInfobox(client, "s", "Sikeres nyomtatás!")
    end
end)

function isVehicleWheelPopped(vehicleElement)
    local wheelStates = {getVehicleWheelStates(vehicleElement)}
    local poppedWheel = false

    for _, wheelState in pairs(wheelStates) do
        if wheelState >= 1 then
            poppedWheel = true
        end
    end

    return poppedWheel
end

addEventHandler("onColShapeHit", getRootElement(), function(he, md)
    if md and sightDynoCols[source] then
        if getElementType(he) == "vehicle" then
            local controller = getVehicleController(he)
            if not isVehicleWheelPopped(he) then 
                local occupants = getVehicleOccupants(he)

                if isElement(controller) then
                    local dim = getElementData(controller, "playerID") + 1000

                    for k, v in pairs(occupants) do
                        setElementDimension(v, dim)
                    end

                    setElementDimension(he, dim)

                    vehiclesInSightDyno[he] = sightDynoCols[source]
                    triggerClientEvent(occupants, "startDynoMode", controller, he)
                end
            else
                exports.sGui:showInfobox(controller, "e", "Mérőpadozás előtt szereld meg a kerekett faszi!")
            end
        end
    end
end)

addEventHandler("onElementDestroy", getRootElement(), function()
    if vehiclesInSightDyno[source] then
        local pad = vehiclesInSightDyno[source]
        local x, y, z = pads[pad][4], pads[pad][5], pads[pad][6]

        setElementPosition(source, x, y, z)

        local occupants = getVehicleOccupants(source)
        triggerClientEvent(occupants, "endDynoMode", source)

        for k, v in pairs(occupants) do
            setElementDimension(v, 0)
        end

        setElementDimension(source, 0)
        setElementRotation(source, 0, 0, 0)

        vehiclesInSightDyno[source] = nil
    end
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
    if isElement(source) and getPedOccupiedVehicle(source) then
        local pedveh = getPedOccupiedVehicle(source)

        if isElement(pedveh) and vehiclesInSightDyno[pedveh] then
            local pad = vehiclesInSightDyno[pedveh]
            local x, y, z = pads[pad][4], pads[pad][5], pads[pad][6]

            setElementPosition(pedveh, x, y, z)

            local occupants = getVehicleOccupants(pedveh)
            triggerClientEvent(occupants, "endDynoMode", pedveh)

            for k, v in pairs(occupants) do
                setElementDimension(v, 0)
            end

            setElementDimension(pedveh, 0)
            setElementRotation(pedveh, 0, 0, 0)

            vehiclesInSightDyno[pedveh] = nil
        end
    end
end)

addEventHandler("onResourceStart", getRootElement(), function(res)
    if res == getThisResource() then
        for i = 1, #pads do
            local x, y, z = pads[i][1], pads[i][2], pads[i][3]
            local col = createColSphere(x, y, z, 2)
            sightDynoCols[col] = i
        end
    end
end)