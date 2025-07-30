addEvent("getVehicleOdometer", true)
addEventHandler("getVehicleOdometer", getRootElement(), function(force)
    local distance = getElementData(source, "vehicle.distance") or 0
    local force = force or false
    triggerClientEvent(client, "gotVehicleOdometer", source, distance, source, force)
end)

function getQuality(source, key, default)
    local data = getElementData(source, key)
    if type(data) == "table" and data[1] then
        return data[1]
    end
    return default
end

function getCondition(source, key, default)
    local data = getElementData(source, key)
    if type(data) == "table" and data[2] then
        return data[2]
    end
    return default
end

addEvent("setElectricDatas", true)
addEventHandler("setElectricDatas", getRootElement(), function(charge)
	local veh = getPedOccupiedVehicle(client)
	if not veh then
		return
	end
	local controller = getVehicleController(veh)
	local fuel = getElementData(veh, "vehicle.fuel")

	local batteryTuning = getElementData(veh, "performance.turbo") or 1

	if batteryTuning < 1 then
		batteryTuning = 1
	end

	if charge ~= 0 then

		charge = charge / batteryTuning

		local charge = tonumber(charge)

		if charge > 100 then
			charge = 0
		end

		if isVehicleElectric(veh) and controller and fuel and charge and tonumber(charge) and charge <= 100 then
			local currentCharge = getElementData(veh, "vehicle.fuel")
			if currentCharge - charge <= 0 then
				setElementData(veh, "vehicle.engine", false)
				setElementData(veh, "vehicle.ignition", false)
				setVehicleEngineState(veh, false)

				setElementData(veh, "vehicle.startTime", nil)
				setElementData(veh, "vehicle.startDistance", nil)
				
				exports.sGui:showInfobox(controller, "e", "Lemerült az akkumulátor!")
				return
			end
			if currentCharge - charge > 75 then
				setElementData(veh, "vehicle.fuel", 75)
				return
			end
			local finalCharge = math.round(fuel - charge, 3)
			setElementData(veh, "vehicle.fuel", finalCharge)

			exports.sTuning:makeTuning(veh)
		end

		local currentCharge = getElementData(veh, "vehicle.fuel")

		if currentCharge - charge <= 0 then
			setElementData(veh, "vehicle.engine", false)
			setElementData(veh, "vehicle.ignition", false)
			setVehicleEngineState(veh, false)

			setElementData(veh, "vehicle.startTime", nil)
			setElementData(veh, "vehicle.startDistance", nil)
			
			exports.sGui:showInfobox(controller, "e", "Lemerült az akkumulátor!")
			return
		end
	end
end)

function math.round(num, decimals)
    decimals = math.pow(10, decimals or 0)
    num = num * decimals
    if num >= 0 then num = math.floor(num + 0.5) else num = math.ceil(num - 0.5) end
    return num / decimals
end

addEvent("setVehicleOdometer", true)
addEventHandler("setVehicleOdometer", getRootElement(), function(currentVehicleMileage)
	local currentFuelLevel = getElementData(source, "vehicle.fuel") or 0
    local currentOilLevel = getElementData(source, "vehicle.oil") or 1000
    local currentEngineWear = getCondition(source, 'vehicle.mechanic.engineGeneralKit', 0)
    local currentTimingWear = getCondition(source, 'vehicle.mechanic.engineTimingKit', 0)
	local oldVehicleMileage = getElementData(source, "vehicle.distance") or 0
	
	local rearRightSuspensionQuality = getQuality(source, 'vehicle.mechanic.rearRightSuspension', 2)
	local rearLeftSuspensionQuality = getQuality(source, 'vehicle.mechanic.rearLeftSuspension', 2)
	local frontRightSuspensionQuality = getQuality(source, 'vehicle.mechanic.frontRightSuspension', 2)
	local frontLeftSuspensionQuality = getQuality(source, 'vehicle.mechanic.frontLeftSuspension', 2)
	local rearBrakesQuality = getQuality(source, 'vehicle.mechanic.rearBrakes', 2)
	local frontBrakesQuality = getQuality(source, 'vehicle.mechanic.frontBrakes', 2)
	local frontTiresQuality = getQuality(source, 'vehicle.mechanic.frontTires', 2)
	local rearTiresQuality = getQuality(source, 'vehicle.mechanic.rearTires', 2)
	local engineTimingKitQuality = getQuality(source, 'vehicle.mechanic.engineTimingKit', 2)
	local engineGeneralKitQuality = getQuality(source, 'vehicle.mechanic.engineGeneralKit', 2)
	local engineRepairKitQuality = getQuality(source, 'vehicle.mechanic.engineRepairKit', 2)
	local oilChangeKitQuality = getQuality(source, 'vehicle.mechanic.oilChangeKit', 2)

	local frontWheelsQuality = getQuality(source, 'vehicle.mechanic.frontTires', 2)
	local rearWheelsQuality = getQuality(source, 'vehicle.mechanic.rearTires', 2)
	
	local rearRightSuspensionWear = getCondition(source, 'vehicle.mechanic.rearRightSuspension', 0)
	local rearLeftSuspensionWear = getCondition(source, 'vehicle.mechanic.rearLeftSuspension', 0)
	local frontRightSuspensionWear = getCondition(source, 'vehicle.mechanic.frontRightSuspension', 0)
	local frontLeftSuspensionWear = getCondition(source, 'vehicle.mechanic.frontLeftSuspension', 0)
	local rearBrakesWear = getCondition(source, 'vehicle.mechanic.rearBrakes', 0)
	local frontBrakesWear = getCondition(source, 'vehicle.mechanic.frontBrakes', 0)
	local frontTiresWear = getCondition(source, 'vehicle.mechanic.frontTires', 0)
	local rearTiresWear = getCondition(source, 'vehicle.mechanic.rearTires', 0)
	local engineRepairKitWear = getCondition(source, 'vehicle.mechanic.engineRepairKit', 0)
	local oilChangeKitWear = getCondition(source, 'vehicle.mechanic.oilChangeKit', 0)

	local frontWheelsWear = getCondition(source, 'vehicle.mechanic.frontTires', 0)
	local rearWheelsWear = getCondition(source, 'vehicle.mechanic.rearTires', 0)

	if currentFuelLevel and oldVehicleMileage then
		local vehicleModel = getElementModel(source)
		local vehicleOccupants = getVehicleOccupants(source)

		local distanceTraveled = currentVehicleMileage - oldVehicleMileage
        local lossOil = currentOilLevel - distanceTraveled
        local lossWear = currentEngineWear + (distanceTraveled / (math.random(5, 15) * engineGeneralKitQuality))
        local lossTiming = currentTimingWear + (distanceTraveled / (math.random(2, 8) * engineTimingKitQuality))

		local lossRRSuspension = rearRightSuspensionWear + (distanceTraveled / (math.random(1, 5) * rearRightSuspensionQuality))
		local lossRLSuspension = rearLeftSuspensionWear + (distanceTraveled / (math.random(1, 5) * rearLeftSuspensionQuality))
		local lossFRSuspension = frontRightSuspensionWear + (distanceTraveled / (math.random(1, 5) * frontRightSuspensionQuality))
		local lossFLSuspension = frontLeftSuspensionWear + (distanceTraveled / (math.random(1, 5) * frontLeftSuspensionQuality))

		local lossFWheels = frontWheelsWear + (distanceTraveled / (math.random(1, 5) * frontWheelsQuality))
		local lossRWheels = rearWheelsWear + (distanceTraveled / (math.random(1, 5) * rearWheelsQuality))

		local lossRearBrakes = rearBrakesWear + (distanceTraveled / (math.random(2, 5) * rearBrakesQuality))
		local lossFrontBrakes = frontBrakesWear + (distanceTraveled / (math.random(2, 4) * frontBrakesQuality))
		local lossRRSuspension = math.abs(lossRRSuspension)
		local lossRLSuspension = math.abs(lossRLSuspension)
		local lossFRSuspension = math.abs(lossFRSuspension)
		local lossFLSuspension = math.abs(lossFLSuspension)
		local lossFWheels = math.abs(lossFWheels)

		local lossRWheels = math.abs(lossRWheels)

		local lossRearBrakes = math.abs(lossRearBrakes)
		local lossFrontBrakes = math.abs(lossFrontBrakes)

		if not exports.sTuning:isInWinter() then
			if getElementData(source, "frontWinter") then
				lossFWheels = frontWheelsWear + ((distanceTraveled / (math.random(1, 2) * frontWheelsQuality)) * 10)
			else
				lossFWheels = frontWheelsWear + (distanceTraveled / (math.random(1, 5) * frontWheelsQuality))
			end
			if getElementData(source, "rearWinter") then
				lossRWheels = rearWheelsWear + ((distanceTraveled / (math.random(1, 5) * rearWheelsQuality)) * 10)
			else
				lossRWheels = rearWheelsWear + (distanceTraveled / (math.random(1, 5) * rearWheelsQuality))
			end
		end

		if lossRRSuspension > 100 then
			lossRRSuspension = 100
		end
		if lossRLSuspension > 100 then
			lossRLSuspension = 100
		end
		if lossFRSuspension > 100 then
			lossFRSuspension = 100
		end
		if lossFLSuspension > 100 then
			lossFLSuspension = 100
		end

		if lossRearBrakes > 100 then
			lossRearBrakes = 100
		end
		if lossFrontBrakes > 100 then
			lossFrontBrakes = 100
		end

		if lossFWheels > 100 then
			lossFWheels = 100
		end
		if lossRWheels > 100 then
			lossRWheels = 100
		end

		setElementData(source, "vehicle.mechanic.rearRightSuspension", {rearRightSuspensionQuality, lossRRSuspension})
		setElementData(source, "vehicle.mechanic.rearLeftSuspension", {rearLeftSuspensionQuality, lossRLSuspension})
		setElementData(source, "vehicle.mechanic.frontRightSuspension", {frontRightSuspensionQuality, lossFRSuspension})
		setElementData(source, "vehicle.mechanic.frontLeftSuspension", {frontLeftSuspensionQuality, lossFLSuspension})
		setElementData(source, "vehicle.mechanic.rearBrakes", {rearBrakesQuality, lossRearBrakes})
		setElementData(source, "vehicle.mechanic.frontBrakes", {frontBrakesQuality, lossFrontBrakes})

		setElementData(source, "vehicle.mechanic.frontTires", {frontWheelsQuality, lossFWheels})
		setElementData(source, "vehicle.mechanic.rearTires", {rearWheelsQuality, lossRWheels})

		local fuelConsumption = exports.sVehicles:getFuelConsumption(vehicleModel)
		local vehicleDriver = getVehicleController(source)
		if fuelConsumption and distanceTraveled then
			local distanceTraveled = distanceTraveled / 100
			local lossFuel = distanceTraveled * fuelConsumption
			lossFuel = currentFuelLevel - lossFuel
			if not isVehicleElectric(source) then
				if lossFuel and lossFuel < 0 then
					lossFuel = 0

					setElementData(source, "vehicle.engine", false)
					setElementData(source, "vehicle.ignition", false)
					setVehicleEngineState(source, false)

					setElementData(source, "vehicle.startTime", nil)
					setElementData(source, "vehicle.startDistance", nil)
					
					exports.sGui:showInfobox(vehicleDriver, "e", "Elfogyott az üzemanyag a járművedből!")
				end
			end
			if not isVehicleElectric(source) then
				if lossOil and lossOil < 0 then
					lossOil = 0

					setElementData(source, "vehicle.engine", false)
					setElementData(source, "vehicle.ignition", false)
					setVehicleEngineState(source, false)

					setElementData(source, "vehicle.startTime", nil)
					setElementData(source, "vehicle.startDistance", nil)

					setElementHealth(source, 320)
					exports.sGui:showInfobox(vehicleDriver, "e", "Elfogyott az olaj a járművedből!")
				end
				
				if lossWear and lossWear >= 100 then
					lossWear = 100

					setElementData(source, "vehicle.engine", false)
					setElementData(source, "vehicle.ignition", false)
					setVehicleEngineState(source, false)

					setElementData(source, "vehicle.startTime", nil)
					setElementData(source, "vehicle.startDistance", nil)

					setElementHealth(source, 320)
					exports.sGui:showInfobox(vehicleDriver, "e", "A jármű motorja túlságosan elkopott!")
				end

				if lossTiming and lossTiming >= 100 then
					lossTiming = 100

					setElementData(source, "vehicle.engine", false)
					setElementData(source, "vehicle.ignition", false)
					setVehicleEngineState(source, false)

					setElementData(source, "vehicle.startTime", nil)
					setElementData(source, "vehicle.startDistance", nil)

					setElementHealth(source, 320)
					exports.sGui:showInfobox(vehicleDriver, "e", "A jármű vezérlése tönkrement!")
				end
			end

			setElementData(source, "vehicle.distance", currentVehicleMileage)
			if not isVehicleElectric(source) then
				setElementData(source, "vehicle.fuel", lossFuel)
				setElementData(source, "vehicle.oil", lossOil)
				lossWear = math.abs(lossWear)
				lossTiming = math.abs(lossTiming)
				setElementData(source, "vehicle.mechanic.engineGeneralKit", {engineGeneralKitQuality, lossWear})
				setElementData(source, "vehicle.mechanic.engineTimingKit", {engineTimingKitQuality, lossTiming})
			end

			triggerClientEvent(vehicleOccupants, "gotVehicleFuelLevel", source, lossFuel)
			triggerClientEvent(vehicleOccupants, "gotVehicleOilLevel", source, lossOil)
			triggerClientEvent(vehicleOccupants, "gotVehicleOdometer", client, distanceTraveled, source, true)
		end
	end
end)