local superChargerPistolInUse = {}
local superChargerPistolInVehicle = {}

addEvent("requestSuperchargerSync", true)
addEventHandler("requestSuperchargerSync", getRootElement(), function()
    for charger, player in pairs(superChargerPistolInUse) do
        if isElement(player) then
            if getElementDimension(player) == getElementDimension(client) then
                triggerClientEvent(client, "syncSuperchargerUser", player, charger, player)
            end
        end
    end

    for charger, data in pairs(superChargerPistolInVehicle) do
        if isElement(data.vehicleElement) then
            if getElementDimension(data.vehicleElement) == getElementDimension(client) then
                if getElementDimension(client) == getElementDimension(data.vehicleElement) then
                    triggerClientEvent(client, "syncSuperchargerUser", client, charger, data.vehicleElement)
                end
            end
        end
    end
end)

function calculateChargingCost(currentCharge)
    local percentToCharge = 100 - currentCharge
    if percentToCharge <= 0 then
        return 0, 0
    end
    
    local secondsToCharge = (percentToCharge / 5) * 60
    local costToCharge = (secondsToCharge / 60) * 250
    return secondsToCharge, costToCharge
end

function calculatePercentageFilled(seconds, vehicle)
    percentPerSecond = 5 / 60
    if getElementDimension(vehicle) ~= 0 then
        percentPerSecond = 2.5 / 60
    end
    local percentageFilled = seconds * percentPerSecond
    return percentageFilled
end

addEvent("trySuperchargerPistolInHand", true)
addEventHandler("trySuperchargerPistolInHand", getRootElement(), function(charger)
    if client == source then
        if superChargerPistolInVehicle[charger] then
            local now = getTickCount()
            local elapsedTime = now - superChargerPistolInVehicle[charger].startedCharging
            local elapsedSeconds = elapsedTime / 1000

            local minutes = math.floor(elapsedSeconds / 60)
            local remainingSeconds = elapsedSeconds % 60
            local chargedTime = string.format("%02d:%02d", minutes, remainingSeconds)

            local batteryLevel = superChargerPistolInVehicle[charger].batteryLevel

            local vehicleElement = superChargerPistolInVehicle[charger].vehicleElement

            if vehicleElement and getElementData(vehicleElement, "vehicle.locked") then
                exports.sGui:showInfobox(client, "e", "Ez a jármű zárva van!")
                return
            end


            local newBatteryLevel = calculatePercentageFilled(elapsedSeconds, vehicleElement) + batteryLevel

            if isElement(vehicleElement) and getElementDimension(client) == getElementDimension(vehicleElement) then
                local remainingSeconds, remainingPrice = calculateChargingCost(newBatteryLevel)

                if newBatteryLevel >= 75 then
                    newBatteryLevel = 75
                    remainingSeconds = 0
                    remainingPrice = 0
                end

                setElementData(vehicleElement, "vehicle.fuel", newBatteryLevel)
                setElementData(vehicleElement, "vehicle.onCharging", false)

                local playerElement = superChargerPistolInVehicle[charger].chargerElement
                local totalCost = superChargerPistolInVehicle[charger].chargingCost - remainingPrice
                totalCost = math.floor(totalCost)
                
                local payedPrice = superChargerPistolInVehicle[charger].chargingCost - totalCost
                payedPrice = math.floor(payedPrice)

                setElementFrozen(vehicleElement, false)
                setElementData(vehicleElement, "vehicle.handbrake", false)

                if isElement(playerElement) then
                    if getElementInterior(playerElement) == 0 then
                        local moneyValue = exports.sCore:getMoney(playerElement)
                        exports.sCore:takeMoney(playerElement, payedPrice)

                        local vehiclePlate = getVehiclePlateText(vehicleElement):gsub("-", " ")
                        exports.sGui:showInfobox(playerElement, "i", vehiclePlate .. " rendszámú járműved töltése befejeződtt.")
                        exports.sGui:showInfobox(playerElement, "i", "Töltési idő: " .. chargedTime .. ", fizetendő: " .. thousandsStepper(totalCost) .. " $")
                        exports.sGui:showInfobox(playerElement, "i", "A töltési különbözetet visszakaptad. (" .. thousandsStepper(payedPrice) .. " $)")
                    end
                end
            end

            superChargerPistolInVehicle[charger] = nil
            superChargerPistolInUse[charger] = client
            setElementData(client, "currentCharger", charger)
            for k, v in pairs(getElementsByType("player")) do
                if getElementDimension(v) == getElementDimension(client) then
                    triggerClientEvent(v, "syncSuperchargerUser", client, charger, client)
                end
            end
        else
            local currentCharger = false

            for charger, player in pairs(superChargerPistolInUse) do
                if player == client then
                    currentCharger = charger
                end
            end

            if not currentCharger then
                currentCharger = getElementData(client, "currentCharger")
            end

            if currentCharger then
                superChargerPistolInUse[currentCharger] = nil
                setElementData(client, "currentCharger", false)
                for k, v in pairs(getElementsByType("player")) do
                    if getElementDimension(v) == getElementDimension(client) then
                        triggerClientEvent(v, "syncSuperchargerUser", client, currentCharger)
                    end
                end
            else
                if not charger then
                    charger = 92
                end
                setElementData(client, "currentCharger", charger)
                superChargerPistolInUse[charger] = client
                for k, v in pairs(getElementsByType("player")) do
                    if getElementDimension(v) == getElementDimension(client) then
                        triggerClientEvent(v, "syncSuperchargerUser", client, charger, client)
                    end
                end
            end
        end
    end
end)

addEvent("putSuperchargerPistolInVehicle", true)
addEventHandler("putSuperchargerPistolInVehicle", getRootElement(), function(hoveredElement)
    if client == source then
        local hoveredElementModel = getElementData(hoveredElement, "vehicle.customModel") or getElementModel(hoveredElement)
        if not chargingPortRotation[hoveredElementModel] then
            return
        end

        for charger, data in pairs(superChargerPistolInVehicle) do
            if data.vehicleElement == hoveredElement then
                return
            end
        end

        local currentCharger = false

        for charger, player in pairs(superChargerPistolInUse) do
            if player == client then
                currentCharger = charger
            end
        end

        if currentCharger then
            local vehiclePlate = getVehiclePlateText(hoveredElement):gsub("-", " ")
            local currentBatteryLevel  = getElementData(hoveredElement, "vehicle.fuel") or 0

            local chargingTime, chargingCost = calculateChargingCost(currentBatteryLevel)
            chargingCost = math.floor(chargingCost)

            local moneyValue = exports.sCore:getMoney(client)
            if getElementInterior(client) == 0 then

                exports.sCore:takeMoney(client, chargingCost)

                exports.sGui:showInfobox(client, "i", vehiclePlate .. " rendszámú járműved töltése elkezdődött. Töltési díj 250 $/perc")
                exports.sGui:showInfobox(client, "i", "Zárolásra került " .. thousandsStepper(chargingCost) .. " $, melyet a töltés befejezésekor visszakapsz.")
            end

            inGarage = false

            if getElementDimension(hoveredElement) ~= 0 then
                inGarage = true
            end
            setElementData(hoveredElement, "vehicle.onCharging", {true, getRealTime().timestamp, inGarage})

            setElementFrozen(hoveredElement, true)
            setElementData(hoveredElement, "vehicle.handbrake", true)

            superChargerPistolInVehicle[currentCharger] = {
                chargerElement = client,
                vehicleElement = hoveredElement,
                startedCharging = getTickCount(),
                batteryLevel = currentBatteryLevel,
                chargingCost = chargingCost,
                chargingTime = chargingTime
            }

            for k, v in pairs(getElementsByType("player")) do
                if getElementDimension(v) == getElementDimension(client) then
                    triggerClientEvent(v, "syncSuperchargerUser", client, currentCharger, hoveredElement)
                end
            end
        end
    end
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
    for charger, player in pairs(superChargerPistolInUse) do
        if player == source then
            superChargerPistolInUse[charger] = nil
            triggerClientEvent(root, "syncSuperchargerUser", root, charger)
        end
    end
end)

addEventHandler("onElementDestroy", getRootElement(), function()
    for charger, data in pairs(superChargerPistolInVehicle) do
        if data.vehicleElement == source then
            superChargerPistolInVehicle[charger] = nil
            triggerClientEvent(root, "syncSuperchargerUser", root, charger)
        end
    end
end)

function thousandsStepper(amount)
    local formatted = amount

    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1 %2")

        if k == 0 then
            break
        end
    end

    return formatted
end