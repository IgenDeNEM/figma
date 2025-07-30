addEvent("getVehicleOilLevel", true)
addEventHandler("getVehicleOilLevel", getRootElement(), function()
    local clientVehicle = getPedOccupiedVehicle(client)

    if clientVehicle then
        local currentOilLevel = getElementData(clientVehicle, "vehicle.oil") or 1000
        triggerClientEvent(client, "gotVehicleOilLevel", clientVehicle, currentOilLevel)
    end
end)

addEvent("getVehicleABS", true)
addEventHandler("getVehicleABS", getRootElement(), function()
    local clientVehicle = getPedOccupiedVehicle(client)

    if clientVehicle then
        local abs = getElementData(clientVehicle, "abs") or 0
        abs = abs > 0 and abs
        triggerClientEvent(client, "gotVehicleABS", clientVehicle, abs)
    end
end)

addEvent("getVehicleFuelLevel", true)
addEventHandler("getVehicleFuelLevel", getRootElement(), function()
    local vehicle = getPedOccupiedVehicle(client)

    if vehicle then
        local vehicleFuel = getElementData(vehicle, "vehicle.fuel") or 0
        triggerClientEvent(client, "gotVehicleFuelLevel", vehicle, vehicleFuel)
    end
end)

addEvent("getVehicleBatteryCharge", true)
addEventHandler("getVehicleBatteryCharge", getRootElement(), function()
    local clientVehicle = getPedOccupiedVehicle(client)

    if clientVehicle then

        local batteryCharge = getElementData(clientVehicle, "vehicle.batteryCharge") or 2048
        local maxBatteryCharge = getElementData(clientVehicle, "vehicle.maxBatteryCharge") or 2048
        local batteryRate = getElementData(clientVehicle, "vehicle.batteryRate") or 0
        triggerClientEvent(client, "gotVehicleBatteryCharge", clientVehicle, batteryCharge, maxBatteryCharge, 2048, batteryRate)
    end
end)

--[[
addEventHandler("onElementDataChange", getRootElement(), function(dataName, oldValue, newValue)
    if getElementType(source) == "vehicle" then
        if dataName == "vehicle.battery" then
            local batteryCharge = getElementData(source, "vehicle.batteryCharge") or 2048
            local batteryValue = (newValue / 100) * batteryCharge
            triggerClientEvent(getVehicleOccupants(source), "gotVehicleBatteryCharge", source, batteryValue, batteryCharge, 2048, 5)
        elseif dataName == "vehicle.batteryCharge" then
            local vehicleEngineBattery = getElementData(source, "vehicle.battery") or 0
            local batteryValue = (vehicleEngineBattery / 100) * newValue
            triggerClientEvent(getVehicleOccupants(source), "gotVehicleBatteryCharge", source, batteryValue, newValue, 2048, 5)
        end
    end
end)]]

addEvent("getVehicleCheckEngineLevel", true)
addEventHandler("getVehicleCheckEngineLevel", getRootElement(), function()
    if source and getElementType(source) == "vehicle" then
        local checkEngineLevel = getElementData(source, "vehicle.checkengine") or 0
        triggerClientEvent(source, "gotCheckEngineLightLevel", source, checkEngineLevel)
        local veh = source
        local errorCodes = getElementData(veh, "vehicle.errorCodes")
        if not errorCodes then
            errorCodes = {}
        end
        local vehHp = getElementHealth(veh)
        if not errorCodes[1] then
            if vehHp < 800 then
                errorCodes[1] = true
            end
        end
        if not errorCodes[2] then
            if vehHp < 500 then
                errorCodes[2] = true
            end
        end
        vehicleEngineBattery = getElementData(veh, "vehicle.batteryCharge") or 0
        vehicleEngineBattery = math.max(0, math.min(100, vehicleEngineBattery))
        if not errorCodes[3] then
            if vehicleEngineBattery < 10 then
                errorCodes[3] = true
            end
        end
        vehicleEngineBattery = getCondition(veh, 'vehicle.maxBatteryCharge', 0)
        if not errorCodes[4] then
            if vehicleEngineBattery < 20 then
                errorCodes[4] = true
            end
        end
        timingWear = getCondition(veh, 'vehicle.mechanic.engineTimingKit', 0)
        if not errorCodes[5] then
            if timingWear > 70 then
                errorCodes[5] = true
            end
        end
        faultyFuel = getElementData(veh, "vehicle.fueltype") == "faulty"
        if not errorCodes[6] then
            if faultyFuel then
                errorCodes[6] = true
            end
        end
        local faultyLight = false
        for i = 0, 3 do
            if getVehicleLightState(veh, i) == 1 then
                faultyLight = true
            end
        end
        if not errorCodes[7] then
            if faultyLight then
                errorCodes[7] = true
            end
        end
        local faultyFrontLeft = getCondition(veh, 'vehicle.mechanic.frontLeftSuspension', 0) > 20
        local faultyFrontRight = getCondition(veh, 'vehicle.mechanic.frontRightSuspension', 0) > 20
        if not errorCodes[8] then
            if faultyFrontLeft or faultyFrontRight then
                errorCodes[8] = true
            end
        end
        if not errorCodes[9] then
            if vehHp < 500 then
                errorCodes[9] = true
            end
        end
        setElementData(veh, "vehicle.errorCodes", errorCodes)
    end
end)

addEvent("getVehicleNosLevel", true)
addEventHandler("getVehicleNosLevel", getRootElement(), function()
    local vehicleNitro = getElementData(source, "nitro") or false

    if vehicleNitro then
        local vehicleNitroLevel = getElementData(source, "nitroLevel") or {1, 0}
        if not vehicleNitroLevel[2] then
            vehicleNitroLevel[2] = 0
        end
        triggerClientEvent(client, "gotVehicleNosLevel", source, (vehicleNitroLevel[2] or 0), vehicleNitroLevel[1] == 2, true, 1100, exports.sCore:getRealTimestamp())
    else
        triggerClientEvent(client, "gotVehicleNosLevel", source, 0, false, false)
    end
end)

function getCondition(source, key, default)
    local data = getElementData(source, key)
    if type(data) == "table" and data[2] then
        return data[2]
    end
    return default
end

addEvent("getVehicleBrakeState", true)
addEventHandler("getVehicleBrakeState", getRootElement(), function()
    local veh = getPedOccupiedVehicle(client)
    local fB = getCondition(veh, "vehicle.mechanic.frontBrakes", 0)
    local rB = getCondition(veh, "vehicle.mechanic.rearBrakes", 0)
    local fB = 100 - fB
    local rB = 100 - rB
    if veh then
        triggerClientEvent(client, "gotVehicleBrakeState", veh, fB, rB)
    end
end)

addEvent("getVehicleTimingState", true)
addEventHandler("getVehicleTimingState", getRootElement(), function()
    local clientVehicle = getPedOccupiedVehicle(client)

    local currentTimingWear = getCondition(clientVehicle, 'vehicle.mechanic.engineTimingKit', 0)

    if clientVehicle then
        currentTimingWear = 100 - currentTimingWear

        triggerClientEvent(client, "gotVehicleTimingState", clientVehicle, currentTimingWear)
    end

    local fl = getCondition(clientVehicle, 'vehicle.mechanic.frontLeftSuspension', 0)
    local rl = getCondition(clientVehicle, 'vehicle.mechanic.rearLeftSuspension', 0)
    local fr = getCondition(clientVehicle, 'vehicle.mechanic.frontRightSuspension', 0)
    local rr = getCondition(clientVehicle, 'vehicle.mechanic.rearRightSuspension', 0)
    local fl = 100 - fl
    local rl = 100 - rl
    local fr = 100 - fr
    local rr = 100 - rr

    triggerClientEvent(client, "gotVehicleSuspensionState", clientVehicle, fl, rl, fr, rr)
end)

addEvent("getVehicleSuspensionState", true)
addEventHandler("getVehicleSuspensionState", getRootElement(), function()
    local clientVehicle = getPedOccupiedVehicle(client)

    local fl = getCondition(clientVehicle, 'vehicle.mechanic.frontLeftSuspension', 0)
    local rl = getCondition(clientVehicle, 'vehicle.mechanic.rearLeftSuspension', 0)
    local fr = getCondition(clientVehicle, 'vehicle.mechanic.frontRightSuspension', 0)
    local rr = getCondition(clientVehicle, 'vehicle.mechanic.rearRightSuspension', 0)

    local fl = 100 - fl
    local rl = 100 - rl
    local fr = 100 - fr
    local rr = 100 - rr

    if clientVehicle then
        triggerClientEvent(client, "gotVehicleSuspensionState", clientVehicle, fl, rl, fr, rr)
    end
end)

addEvent("getVehicleCruiseState", true)
addEventHandler("getVehicleCruiseState", getRootElement(), function()
    local clientVehicle = getPedOccupiedVehicle(client)

    if clientVehicle then
        local cruiseState = getElementData(clientVehicle, "vehicle.cruiseState") or false
        local new = false
        local enter = false

        if cruiseState then
            new = cruiseState
            enter = true
        end

        triggerClientEvent(client, "gotVehicleCruise", clientVehicle, new, enter)
    end
end)


addEvent("setVehicleCruiseSpeed", true)
addEventHandler("setVehicleCruiseSpeed", getRootElement(),
	function(cruiseSpeed)
		local vehicle = getPedOccupiedVehicle(client)

		if vehicle then
			local occupants = getVehicleOccupants(vehicle)
            setElementData(vehicle, "vehicle.cruiseState", cruiseSpeed)
			triggerClientEvent(occupants, "gotVehicleCruise", vehicle, cruiseSpeed)
            if cruiseSpeed then
                if not getElementData(vehicle, "vehicle.cruiseState") then
                    exports.sGui:showInfobox(client, "i", "Tempomat bekapcsolva.")
                end
            else
                exports.sGui:showInfobox(client, "i", "Tempomat kikapcsolva.")
                if isVehicleElectric(getPedOccupiedVehicle(client)) then
                    triggerClientEvent(client, "setAutoPilot", getPedOccupiedVehicle(client), cruiseDistance)
                end
            end
		end
	end
)

addEvent("syncVehicleCurrentGear", true)
addEventHandler("syncVehicleCurrentGear", getRootElement(), function(gear)
    --local clientVehicle = getPedOccupiedVehicle(client)
--
    --if clientVehicle then
    --    local currentSpeed = getVehicleSpeed(clientVehicle)
    --    local currentGear = getElementData(clientVehicle, "vehicle.gear") or "N"
    --    
    --    if gear == 0 then
    --        currentSelectedGear = "N"
--
    --        if currentGear == "R" then
    --            currentSelectedGear = "R"
    --        end
    --    elseif gear >= 1 then
    --        currentSelectedGear = "D"
--
    --        if currentGear == "N" then
    --            currentSelectedGear = "N"
    --        elseif currentGear == "R" then
    --            currentSelectedGear = "R"
    --        end
    --    elseif gear == 0 and currentSpeaed > 0 then
    --        currentSelectedGear = "R"
--
    --        if currentGear == "R" then
    --            currentSelectedGear = "R"
    --        end
    --    end
--
    --    setElementData(clientVehicle, "vehicle.gear", currentSelectedGear)
    --end
end)

addEvent("setHandbrakeState", true)
addEventHandler("setHandbrakeState", getRootElement(), function(state, veh)
    local clientVehicle = getPedOccupiedVehicle(client)
    clientVehicle = veh or clientVehicle

    if clientVehicle then
        local currentSpeed = getVehicleSpeed(clientVehicle)
        if getElementData(clientVehicle, "vehicle.onCharging") then
            setElementFrozen(clientVehicle, true)
            setElementData(clientVehicle, "vehicle.handbrake", true)
            return
        end
        if not getElementData(clientVehicle, "vehicle.onCharging") then
            if currentSpeed < 3 and not getElementData(clientVehicle, "vehicle.charging") and not getElementData(clientVehicle, "vehicle.onCharging") then

                if state then
                    exports.sGui:showInfobox(client, "i", "Behúztad a kéziféket.")
                else
                    exports.sGui:showInfobox(client, "i", "Kiengedted a kéziféket.")
                end
            end
        end

        setElementFrozen(clientVehicle, state)
        setElementData(clientVehicle, "vehicle.handbrake", state)
    end
end)

addEventHandler("onVehicleStartExit", root, function(ped)
    if isElement(ped) and isElement(source) then
        if getElementData(source, "vehicle.locked") then
            exports.sGui:showInfobox(ped, "e", "Előbb nyisd ki az ajtót!")
            cancelEvent()
        end
    end
end)

addEventHandler("onResourceStart", getRootElement(), function()
    local vehicleElements = getElementsByType("vehicle")

    for key, vehicle in pairs(vehicleElements) do
        local handbrakeState = getElementData(vehicle, "vehicle.handbrake") or false
        setElementFrozen(vehicle, handbrakeState)
    end
end)

addEvent("syncVehicleBeltSound", true)
addEventHandler("syncVehicleBeltSound", getRootElement(), function(currentVehicle, players)
    if client ~= source then
        return
    end

    triggerClientEvent(players, "syncVehicleBeltSound", currentVehicle, math.random(1, 2))
end)

addEvent("syncVehicleBrakeNoise", true)
addEventHandler("syncVehicleBrakeNoise", getRootElement(), function(currentVehicle, players)
    triggerClientEvent(players, "syncVehicleBrakeNoise", currentVehicle, math.random(1, 3))
end)


addEvent("syncVehicleKnockSound", true)
addEventHandler("syncVehicleKnockSound", getRootElement(), function(currentVehicle, players, vol, x, y, z)
    if exports.sSpeedo:getVehicleSpeed(currentVehicle, "KMH") > 1 then
 
        local fl = getCondition(currentVehicle, 'vehicle.mechanic.frontLeftSuspension', 0)
        local rl = getCondition(currentVehicle, 'vehicle.mechanic.rearLeftSuspension', 0)
        local fr = getCondition(currentVehicle, 'vehicle.mechanic.frontRightSuspension', 0)
        local rr = getCondition(currentVehicle, 'vehicle.mechanic.rearRightSuspension', 0)

        local fl = 100 - fl
        local rl = 100 - rl
        local fr = 100 - fr
        local rr = 100 - rr

        if fl <= 50 or rl <= 50 or fr <= 50 or rr <= 50 then
            triggerClientEvent(players, "syncVehicleKnockSound", currentVehicle, math.random(1, 4), vol, x, y, z)
        end
    end
end)

local cruiseDistanceState = {}

addEvent("setVehicleCruiseDistance", true)
addEventHandler("setVehicleCruiseDistance", getRootElement(), function(cruiseDistance)
    if not cruiseDistanceState[client] then
        cruiseDistanceState[client] = true
    else
        cruiseDistanceState[client] = false
    end

    triggerClientEvent("gotVehicleCruiseDistance", getPedOccupiedVehicle(client), cruiseDistance, cruiseDistanceState[client])
    if cruiseDistance then
        exports.sGui:showInfobox(client, "i", "Távolságtartó tempomat: " .. cruiseDistance .. ".")
		if isVehicleElectric(getPedOccupiedVehicle(client)) and getElementData(getPedOccupiedVehicle(client), "gpsTarget") then
            triggerClientEvent(client, "setAutoPilot", getPedOccupiedVehicle(client), cruiseDistance)
        end
    else
		if isVehicleElectric(getPedOccupiedVehicle(client)) then
            triggerClientEvent(client, "setAutoPilot", getPedOccupiedVehicle(client), cruiseDistance)
        end
        exports.sGui:showInfobox(client, "i", "Távolságtartó tempomat: " .. "kikapcsolva.")
    end
end)

addEvent("removePlayerFromVehicle", true)
addEventHandler("removePlayerFromVehicle", getRootElement(), function(vehicleElement, playerElement)
    if source and source == client then
        if vehicleElement and isElement(vehicleElement) and getElementType(vehicleElement) == "vehicle" then
            removePedFromVehicle(playerElement)       
            exports.sChat:localAction(client, "kirángatta "..getElementData(playerElement, "visibleName"):gsub("_", " ").."-t a járműből.")     
        else
            exports.sAnticheat:anticheatBan(client, "sSpeedo >> removePlayerFromVehicle -> @sourceS.lua/255")
        end
    else
        exports.sAnticheat:anticheatBan(client, "sSpeedo >> removePlayerFromVehicle -> @sourceS.lua/258")
    end
end)