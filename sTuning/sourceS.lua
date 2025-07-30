local connection = false

local isWinter = false

function isInWinter()
	return isWinter
end

local tuningValues = {}
local createdWorkshops = {}
local carsInWorkshop = {}
local previewDatas = {}

local tuningIdToDataKeys = {
	["headlightPaintjob"] = "vehicle.currentHeadlightTexture",
}

local monitoredDataKeys = {
	["performance.engine"] = true,
	["performance.turbo"] = true,
	["performance.ecu"] = true,
	["performance.transmission"] = true,
	["performance.suspension"] = true,
	["performance.brakes"] = true,
	["performance.tire"] = true,
	["performance.weightReduction"] = true,
	["turbo"] = true,
	["customTurbo"] = true,
	["backfire"] = true,
	["customBackfire"] = true,
	["nitro"] = true,
	["nitroLevel"] = true,
	["traffipaxRadar"] = true,
	["driveType"] = true,
	["steeringLock"] = true,
	["abs"] = true,
	["automaticShifter"] = true,
	["offroadSetting"] = true,
	["lsdDoor"] = true,
	["customHorn"] = true,
	["paintjob"] = true,
	["headlightPaintjob"] = true,
	["wheelPaintjob"] = true,
	["wheelwidth.front"] = true,
	["wheelwidth.rear"] = true,
	["spinner"] = true,
	["frontwheels"] = true,
	["rearwheels"] = true,
	["neon"] = true,
	["rideTuning"] = true,
	["customPlate"] = true,
}
--[[ -- @noffy 2025.04.19 - 17:48:28
local performanceTuningValues = {
	engine = {maxVelocity = {5, 10, 17.5}, engineAcceleration = {17.5, 25, 35}},
	turbo = {engineAcceleration = {17.5, 25, 35}},
	ecu = {maxVelocity = {5, 10, 17.5}, engineAcceleration = {17.5, 25, 35}},
	transmission = {maxVelocity = {5, 10, 17.5}, engineAcceleration = {17.5, 25, 35}},
	suspension = {suspensionForceLevel = {5, 10, 20}, tractionMultiplier = {5, 10, 20}},
	brakes = {brakeDeceleration = {15, 20, 35}},
	tire = {tractionMultiplier = {5, 10, 20}, tractionLoss = {5, 10, 20}},
	weightReduction = {mass = {5, 10, 20}}
}
]]--

local performanceTuningValues = {
	engine = {maxVelocity = {3, 5, 9}, engineAcceleration = {8, 10, 12}},
	turbo = {engineAcceleration = {5, 8, 11}},
	ecu = {maxVelocity = {5, 7, 9}, engineAcceleration = {8, 10, 11}},
	transmission = {maxVelocity = {3, 6, 7.5}, engineAcceleration = {7.5, 9, 11}},
	suspension = {suspensionForceLevel = {5, 10, 20}, tractionMultiplier = {5, 10, 20}},
	brakes = {brakeDeceleration = {10, 15, 20}},
	tire = {tractionMultiplier = {5, 10, 20}, tractionLoss = {5, 10, 20}},
	weightReduction = {mass = {5, 10, 15}}
}

local handlingFlags = {
	_1G_BOOST = 1,
	_2G_BOOST = 2,
	NPC_ANTI_ROLL = 4,
	NPC_NEUTRAL_HANDL = 8,
	NO_HANDBRAKE = 16,
	STEER_REARWHEELS = 32,
	HB_REARWHEEL_STEER = 64,
	ALT_STEER_OPT = 128,
	WHEEL_F_NARROW2 = 256,
	WHEEL_F_NARROW = 512,
	WHEEL_F_WIDE = 1024,
	WHEEL_F_WIDE2 = 2048,
	WHEEL_R_NARROW2 = 4096,
	WHEEL_R_NARROW = 8192,
	WHEEL_R_WIDE = 16384,
	WHEEL_R_WIDE2 = 32768,
	HYDRAULIC_GEOM = 65536,
	HYDRAULIC_INST = 131072,
	HYDRAULIC_NONE = 262144,
	NOS_INST = 524288,
	OFFROAD_ABILITY = 1048576,
	OFFROAD_ABILITY2 = 2097152,
	HALOGEN_LIGHTS = 4194304,
	PROC_REARWHEEL_1ST = 8388608,
	USE_MAXSP_LIMIT = 16777216,
	LOW_RIDER = 33554432,
	STREET_RACER = 67108864,
	SWINGING_CHASSIS = 268435456
}

function isFlagSet(val, flag)
	return bitAnd(val, flag) == flag
end

function getVehicleMonitoredDatas(vehicle, tuning)
	if vehicle then
		if not tuningValues[vehicle] then
			tuningValues[vehicle] = {}
		end
		
		for data, value in pairs(monitoredDataKeys) do
			local dataValue = getElementData(vehicle, data)
			tuningValues[vehicle][data] = dataValue
		end
		
		if tuning then
			makeTuning(vehicle)
		end
	end
end

addEventHandler("onElementDataChange", getRootElement(), function(dataName, oldValue, newValue)
	local elementType = getElementType(source)
	
	if elementType == "vehicle" then
		local vehicleOccupants = getVehicleOccupants(source)
		
		if not vehicleOccupants then
			vehicleOccupants = source
		end
		
		if dataName == "neon" then
			if newValue == "custom" then
				local neonData = getElementData(source, "neonData") or {"white", "white"}
				triggerClientEvent(getVehicleOccupants(source), "gotVehicleNeon", source, newValue, neonData[1], neonData[2])
				setElementData(source, "neonSide", neonData[1])
				setElementData(source, "neonFront", neonData[2])
			elseif oldValue == "custom" then
				local currentMenu = getElementData(source, "vehradio.menu") or "home"
				
				if currentMenu == "neon" then
					setElementData(source, "vehradio.menu", "home")	
				end
				
				triggerClientEvent(getVehicleOccupants(source), "gotVehicleNeon", source, false, newValue, false)
			end
			
			if newValue ~= "custom" and newValue then
				setElementData(source, "neonSide", newValue)
				setElementData(source, "neonFront", false)
				triggerClientEvent(getVehicleOccupants(source), "gotVehicleNeon", source, false, false, false)
			end
		end
		
		if dataName == "rideTuning" then
			if newValue == 5 then
				local bias = getElementData(source, "airrideBias") or 0
				local level = getElementData(source, "airrideLevel") or 0
				local softness = getElementData(source, "airrideSoftness") or 0
				
				triggerClientEvent(getVehicleOccupants(source), "gotVehicleAirRide", source, level, bias, softness)
			elseif oldValue == 5 then
				local currentMenu = getElementData(source, "vehradio.menu") or "home"
				
				if currentMenu == "airride" then
					setElementData(source, "vehradio.menu", "home")	
				end
				
				triggerClientEvent(getVehicleOccupants(source), "gotVehicleAirRide", source, 0, 0, 0)
			end
			
			makeTuning(source)
		end
		
		if dataName == "headlightPaintjob" then
			setElementData(source, "vehicle.currentHeadlightTexture", newValue)
		end
		
		if dataName == "wheelPaintjob" then
			setElementData(source, "vehicle.currentWheelTexture", newValue)
		end
		
		if dataName == "wheelwidth.front" then
			makeTuning(source)
		end
		
		if dataName == "wheelwidth.rear" then
			makeTuning(source)
		end
		
		if dataName == "vehicle.opticalTunings" then
			local vehicleUpgrades = getVehicleUpgrades(source)
			
			for key, value in pairs(vehicleUpgrades) do
				removeVehicleUpgrade(source, key)
			end
			
			for key, value in pairs(newValue) do
				if value then
					addVehicleUpgrade(source, value)
				end
			end
		end
		
		if dataName == "spinner" then
			setElementData(source, "tuningSpinners", newValue)
		end
		
		if dataName == "prerformance.turbo" then
			if newValue == 3 then
				setElementData(source, "oldTurboSound", true)
			end
		end
		
		if dataName == "driveType" then
			local customDriveType = getElementData(source, "customDriveType") or false
			
			if newValue == "handling" then
				newValue = getVehicleHandling(source).driveType
			end
			
			setVehicleHandling(source, "driveType", newValue)
			if customDriveType then
				triggerClientEvent(vehicleOccupants, "gotVehicleDriveTypeData", source, newValue)
			end
		elseif dataName == "customDriveType" and newValue then
			local driveType = getElementData(source, "driveType") or "awd"
			triggerClientEvent(vehicleOccupants, "gotVehicleDriveTypeData", source, driveType)
		elseif dataName == "steeringLock" then
			makeTuning(source)
		elseif dataName == "abs" then
			triggerClientEvent(vehicleOccupants, "gotVehicleABS", source, newValue)
		elseif dataName == "automaticShifter" then
			triggerClientEvent(vehicleOccupants, "updateShifter", source, newValue)
		end
		
		if monitoredDataKeys[dataName] then
			if not tuningValues[source] then
				tuningValues[source] = {}
			end
			
			tuningValues[source][dataName] = newValue
		end
	end
end)

addEventHandler("onResourceStop", getRootElement(), function(res)
	if res == getThisResource() or getResourceName(res) == "sVehicles" then
		for key, vehicle in pairs(getElementsByType("vehicle")) do
			if carsInWorkshop[vehicle] then
				if getResourceName(res) == "sVehicles" then
					exitTuning(vehicle, true)
				else
					exitTuning(vehicle)
				end
			end
		end
	end
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
	local vehicle = getPedOccupiedVehicle(source)
	
	if vehicle and carsInWorkshop[vehicle] then
		exitTuning(vehicle, true)
	end
end)

function exitTuning(source, gui)
	if carsInWorkshop[source] then
		local vehicleDriver = getVehicleOccupant(source)
		local vehicleOccupants = getVehicleOccupants(source)
		
		if carsInWorkshop[source] then
			if gui then
				triggerClientEvent(vehicleOccupants, "tuningGuiState", source, false, vehicleDriver, false, false)
			end
			
			local workshopPosition = workshopLocations[carsInWorkshop[source]]
			local randomParkPosition = math.random(1, #workshopPosition[13])
			local selectedParkPosition = workshopPosition[13][randomParkPosition]
			
			setElementPosition(source, selectedParkPosition[1], selectedParkPosition[2], selectedParkPosition[3])
			setElementRotation(source, 0, 0, selectedParkPosition[4])
			setElementInterior(source, 0)
			setElementDimension(source, 0)
			
			for key, player in pairs(vehicleOccupants) do
				setCameraTarget(player, player)
				setElementInterior(player, 0)
				setElementDimension(player, 0)
			end
			
			carsInWorkshop[source] = nil
		end
	end
end

addEventHandler("onResourceStart", resourceRoot, function()
	for key, vehicle in pairs(getElementsByType("vehicle")) do
		getVehicleMonitoredDatas(vehicle, true)
	end
	
	for id, position in pairs(workshopLocations) do
		local workshopCol = createColSphere(position[1], position[2], position[3], 1.5)
		setElementData(workshopCol, "workshopId", id)
		createdWorkshops[id] = workshopCol
	end
end)

addEventHandler("onResourceStart", getRootElement(), function(res)
	local resName = getResourceName(res)
	
	if res == getThisResource() then
		connection = exports.sConnection:getConnection()
	elseif resName == "sConnection" then
		connection = exports.sConnection:getConnection()
	end
end)

addEventHandler("onColShapeHit", resourceRoot, function(hitElement, matchingDimension)
	local workshopId = getElementData(source, "workshopId") or false
	
	if workshopId then
		if hitElement and matchingDimension then
			local elementType = getElementType(hitElement)
			local elementVehicle = getPedOccupiedVehicle(hitElement)
			if elementVehicle then
				local vehicleController = getVehicleController(elementVehicle)
				if elementType == "player" and elementVehicle and vehicleController == hitElement then
					local vehicleOccupants = getVehicleOccupants(elementVehicle)
					
					if vehicleOccupants then
						local tuningDimension = getElementData(hitElement, "char.ID") + 251
						setElementDimension(elementVehicle, tuningDimension)
						setElementInterior(elementVehicle, 1)
						
						for key, player in pairs(vehicleOccupants) do
							setElementDimension(player, tuningDimension)
							setElementInterior(player, 1)
							
							local scenario = {}
							for i = 1, 11 do
								if i <= 4 then
									scenario[i] = math.random(1, 5)
								elseif i <= 8 then
									scenario[i] = math.random(1, 4)
								else
									scenario[i] = math.random(1, 3)
								end
							end
							
							if player ~= hitElement then
								triggerClientEvent(player, "tuningGuiState", elementVehicle, workshopId, false, scenario, false)
							else
								triggerClientEvent(player, "tuningGuiState", elementVehicle, workshopId, true, scenario, false)
							end
						end
						
						carsInWorkshop[elementVehicle] = workshopId
					end
				end
			end
		end
	end
end)

addCommandHandler("atuning", function(hitElement)
	local adminlevel = getElementData(hitElement, "acc.adminLevel")

	if adminlevel and adminlevel > 6 then
		local workshopId = 1
		
		if workshopId then
			if hitElement then
				local elementType = getElementType(hitElement)
				local elementVehicle = getPedOccupiedVehicle(hitElement)
				if elementVehicle then
					local vehicleController = getVehicleController(elementVehicle)
					if elementType == "player" and elementVehicle and vehicleController == hitElement then
						local vehicleOccupants = getVehicleOccupants(elementVehicle)
						
						if vehicleOccupants then
							local tuningDimension = getElementData(hitElement, "char.ID") + 251
							setElementDimension(elementVehicle, tuningDimension)
							setElementInterior(elementVehicle, 1)
							
							for key, player in pairs(vehicleOccupants) do
								setElementDimension(player, tuningDimension)
								setElementInterior(player, 1)
								
								local scenario = {}
								for i = 1, 11 do
									if i <= 4 then
										scenario[i] = math.random(1, 5)
									elseif i <= 8 then
										scenario[i] = math.random(1, 4)
									else
										scenario[i] = math.random(1, 3)
									end
								end
								
								if player ~= hitElement then
									triggerClientEvent(player, "tuningGuiState", elementVehicle, workshopId, false, scenario, false)
								else
									triggerClientEvent(player, "tuningGuiState", elementVehicle, workshopId, true, scenario, false)
								end
							end
							
							carsInWorkshop[elementVehicle] = workshopId
						end
					end
				end
			end
		end
	end
end)

addEvent("tryToExitTuningWorkshop", true)
addEventHandler("tryToExitTuningWorkshop", getRootElement(), function()
	local clientVehicle = getPedOccupiedVehicle(client)
	
	if clientVehicle then
		local vehicleOccupants = getVehicleOccupants(clientVehicle)
		local workshopId = carsInWorkshop[clientVehicle]
		
		if workshopId then
			triggerClientEvent(vehicleOccupants, "tuningGuiState", clientVehicle, false, client, false, false)
			carsInWorkshop[clientVehicle] = nil
			
			local workshopPosition = workshopLocations[workshopId]
			local randomParkPosition = math.random(1, #workshopPosition[13])
			local selectedParkPosition = workshopPosition[13][randomParkPosition]
			
			setElementPosition(clientVehicle, selectedParkPosition[1], selectedParkPosition[2], selectedParkPosition[3])
			setElementRotation(clientVehicle, 0, 0, selectedParkPosition[4])
			setElementInterior(clientVehicle, 0)
			setElementDimension(clientVehicle, 0)
			exports.sNocol:enableVehicleNoCol(clientVehicle, 5000)
			
			for key, player in pairs(vehicleOccupants) do
				setElementInterior(player, 0)
				setElementDimension(player, 0)
			end
		end
	end
end)

addEvent("syncTuningMusic", true)
addEventHandler("syncTuningMusic", getRootElement(), function(id)
	local clientVehicle = getPedOccupiedVehicle(client)
	
	if clientVehicle then
		if carsInWorkshop[clientVehicle] then
			local vehicleOccupants = getVehicleOccupants(clientVehicle)
			triggerClientEvent(vehicleOccupants, "gotTuningMusic", client, id)
		end
	end
end)

addEvent("requestTuningValuesFromServer", true)
addEventHandler("requestTuningValuesFromServer", getRootElement(), function(tuningId)
	local clientVehicle = getPedOccupiedVehicle(client)
	
	if clientVehicle then
		if carsInWorkshop[clientVehicle] then
			local customDriveType = getElementData(clientVehicle, "customDriveType") or false
			local tempValues = {}
			
			if tuningId then
				local tuningDetalist = split(tuningId, ".")
				
				if tuningDetalist[1] == "optical" then
					local opticals = getElementData(clientVehicle, "vehicle.opticalTunings") or {}
					
					for key, value in pairs(opticals) do
						if key == tuningDetalist[2] then
							tuningValue = value
						end
					end
				else
					tuningValue = tuningValues[clientVehicle][tuningId]
				end
				
				if tuningValue then
					if tuningId == "driveType" and customDriveType then
						tuningValue = "set"
					end
					
					table.insert(tempValues, {tuningId, tuningValue})
				end
			else
				if tuningValues[clientVehicle] then
					for key, value in pairs(tuningValues[clientVehicle]) do
						if key == "driveType" and customDriveType then
							tuningValue = "set"
						end
						
						table.insert(tempValues, {key, value})
					end
				end
			end
			
			triggerClientEvent(client, "gotTuningValuesFromServer", client, clientVehicle, tempValues)
		end
	end
end)

addEvent("syncTuningSpectatorData", true)
addEventHandler("syncTuningSpectatorData", getRootElement(), function(data, value, arg)
	local clientVehicle = getPedOccupiedVehicle(client)
	
	if clientVehicle then
		if carsInWorkshop[clientVehicle] then
			local vehicleOccupants = getVehicleOccupants(clientVehicle)
			triggerClientEvent(vehicleOccupants, "syncTuningSpectatorData", clientVehicle, data, value, arg)
		end
	end
end)

addEvent("previewTuningServer", true)
addEventHandler("previewTuningServer", getRootElement(), function(tuningId, value)
	local clientVehicle = getPedOccupiedVehicle(client)
	if clientVehicle then
		if carsInWorkshop[clientVehicle] then
			if not previewDatas[clientVehicle] then
				previewDatas[clientVehicle] = {}
			end
			
			if tuningId == "customPlate" then
				if previewDatas[clientVehicle].newPlateText then
					previewDatas[clientVehicle].plate = nil
					previewDatas[clientVehicle].newPlateText = nil
				else
					if not previewDatas[clientVehicle].plate then
						previewDatas[clientVehicle].plate = getVehiclePlateText(clientVehicle)
					end
					
					if value == "reset" then
						setVehiclePlateText(clientVehicle, previewDatas[clientVehicle].plate)
						previewDatas[clientVehicle].plate = nil
					end
				end
			elseif tuningId == "variant" then
				if not previewDatas[clientVehicle].variant then
					previewDatas[clientVehicle].variant = {getVehicleVariant(clientVehicle)}
				end
				
				if not previewDatas[clientVehicle].variantReset then
					previewDatas[clientVehicle].variantReset = true
				end
				
				previewDatas[clientVehicle].variantState = value
				
				if previewDatas[clientVehicle].variantReset == "buyed" then
					previewDatas[clientVehicle].variantState = nil
					previewDatas[clientVehicle].variant = nil
					previewDatas[clientVehicle].variantReset = nil
				end
				
				if previewDatas[clientVehicle].variantState == "reset" and previewDatas[clientVehicle].variantReset ~= "buyed" then
					setVehicleVariant(clientVehicle, previewDatas[clientVehicle].variant[1], previewDatas[clientVehicle].variant[2])
					previewDatas[clientVehicle].variant = nil
					previewDatas[clientVehicle].variantReset = nil
				elseif tonumber(value) then
					local variant = value - 1
					
					if variant < 0 then
						setVehicleVariant(clientVehicle, 255, 255)
					else
						setVehicleVariant(clientVehicle, variant, 255)
					end
				end
			elseif tuningId == "color" then
				if value ~= "reset" and not previewDatas[clientVehicle].color then
					previewDatas[clientVehicle].color = {getVehicleColor(clientVehicle, true)}
				else
					if previewDatas[clientVehicle] and previewDatas[clientVehicle].color then
						setVehicleColor(clientVehicle, unpack(previewDatas[clientVehicle].color))
					end
					previewDatas[clientVehicle].color = {getVehicleColor(clientVehicle, true)}
				end
			elseif tuningId == "headlightColor" then
				if not previewDatas[clientVehicle].originalHeadlightColor then
					previewDatas[clientVehicle].originalHeadlightColor = {getVehicleHeadLightColor(clientVehicle)}
				end
				
				if not previewDatas[clientVehicle].headlightColorState then
					if value ~= "reset" and getColorFromString("#" .. value) then
						setVehicleHeadLightColor(clientVehicle, getColorFromString("#" .. value))
					else
						setVehicleHeadLightColor(clientVehicle, unpack(previewDatas[clientVehicle].originalHeadlightColor))
					end
				else
					previewDatas[clientVehicle].originalHeadlightColor = nil
					previewDatas[clientVehicle].headlightColorState = nil
				end
			elseif tuningId == "wheelwidth.front" then
				if not previewDatas[clientVehicle].wheelWidthFront then
					local wheelHandlingFlags = {
						[1] = "WHEEL_F_NARROW2",
						[2] = "WHEEL_F_NARROW",
						[3] = "WHEEL_F_WIDE",
						[4] = "WHEEL_F_WIDE2",
					}
					
					setVehicleHandling(clientVehicle, "handlingFlags", handlingFlags[wheelHandlingFlags[value]])
				end
			elseif tuningId == "wheelwidth.rear" then
				if not previewDatas[clientVehicle].wheelWidthRear then
					local wheelHandlingFlags = {
						[1] = "WHEEL_R_NARROW2",
						[2] = "WHEEL_R_NARROW",
						[3] = "WHEEL_R_WIDE",
						[4] = "WHEEL_R_WIDE2",
					}
					
					setVehicleHandling(clientVehicle, "handlingFlags", handlingFlags[wheelHandlingFlags[value]])
				end
			elseif tuningId == "rideTuning" then
				if not previewDatas[clientVehicle].canResetRidePreview then
					local suspensionLowerLimit = exports.sVehicles:getModelHandlingOverride(getElementModel(clientVehicle)).suspensionLowerLimit
					
					if not suspensionLowerLimit then
						suspensionLowerLimit = getModelHandling(getElementModel(clientVehicle)).suspensionLowerLimit
					end
					
					if value ~= 5 and value and value ~= "reset" then
						suspensionLowerLimit = suspensionLowerLimit + value * 0.015
					end
					
					setVehicleHandling(clientVehicle, "suspensionLowerLimit", suspensionLowerLimit)
					setElementVelocity(clientVehicle, 0, 0, 0.02)
					previewDatas[clientVehicle].cantResetRidePreview = false
				end
			else
				local tuningDetalist = split(tuningId, ".")
				
				if tuningDetalist[1] == "optical" then
					if previewDatas[clientVehicle].buyedOptical and value == "reset" then
						previewDatas[clientVehicle].buyedOptical = nil
						previewDatas[clientVehicle].lastUpgrade = nil
						return
					end
					
					local opticals = getElementData(clientVehicle, "vehicle.opticalTunings") or {}
					
					for key, value in pairs(opticals) do
						if key == tuningDetalist[2] then
							previewDatas[clientVehicle].buyedUpgrade = value
						end
					end
					
					if previewDatas[clientVehicle].lastUpgrade and not previewDatas[clientVehicle].buyedUpgrade then
						removeVehicleUpgrade(clientVehicle, previewDatas[clientVehicle].lastUpgrade)
					elseif previewDatas[clientVehicle].buyedUpgrade then
						addVehicleUpgrade(clientVehicle, previewDatas[clientVehicle].buyedUpgrade)
					end
					
					previewDatas[clientVehicle].lastUpgrade = value
					
					if value and value ~= "reset" then
						addVehicleUpgrade(clientVehicle, value)
					elseif value == "reset" then
						previewDatas[clientVehicle].lastUpgrade = nil
					end
				end
			end
		end
	end
end)

local plateFound = {}

local spinnerVehicles = {
	[596] = true,
}

addEvent("tryToBuyTuning", true)
addEventHandler("tryToBuyTuning", getRootElement(), function(tuningId, value, data, acceptedPrompt)
	local clientVehicle = getPedOccupiedVehicle(client)
	
	if clientVehicle then
		local vehicleId = getElementData(clientVehicle, "vehicle.dbID") or false
		
		if vehicleId and carsInWorkshop[clientVehicle] then
			local modelId = getElementModel(clientVehicle)
			
			--[[if tuningId == "spinner" and not spinnerVehicles[modelId] then
				triggerClientEvent(client, "tuningTryToBuyResponse", client, false)
				exports.sGui:showInfobox(client, "e", "Ez az alkatrész nem kompatibilis a járműveddel!")
				return
			end--]]
			
			local tuningPrice = tuningPrices[tuningId]
			
			if tuningPrice then
				tuningPrice = getTuningPrice(tuningId, value, clientVehicle)
				
				if tuningPrice and tuningId ~= "customPlate" and ((tuningId ~= "automaticShifter" and tuningId ~= "abs") and not acceptedPrompt) then
					if tuningPrice[1] and tuningPrice[1] == "pp" then
						local premiumPoints = exports.sCore:getPP(client)
						
						if (premiumPoints - tuningPrice[2]) < 0 then
							exports.sGui:showInfobox(client, "e", "Nincs elég prémiumpontod!")
							triggerClientEvent(client, "tuningTryToBuyResponse", client, false)
							return
						else
							exports.sCore:setPP(client, premiumPoints - tuningPrice[2])
							exports.sGui:showInfobox(client, "s", "Sikeresen megvásároltad a kiválasztott tuningot.")
						end 
					elseif tuningPrice[1] and tuningPrice[1] == "cash" or tonumber(tuningPrice) then
						local currentMoney = exports.sCore:getMoney(client)
						
						if (currentMoney - tuningPrice[2]) < 0 then
							exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
							triggerClientEvent(client, "tuningTryToBuyResponse", client, false)
							return
						else
							exports.sCore:setMoney(client, currentMoney - tuningPrice[2])
							exports.sGui:showInfobox(client, "s", "Sikeresen megvásároltad a kiválasztott tuningot.")
						end
					end
				end
			end
		end
		
		local vehicleOccupants = getVehicleOccupants(clientVehicle)
		
		if tuningId == "backfire" then
			setElementData(clientVehicle, "backfire", value)
			if value then cvalue = 1 else cvalue = 0 end
			
			if value == 2 and data then
				cvalue = 2
				setElementData(clientVehicle, "customBackfire", data)
				dbExec(connection, "UPDATE vehicles SET customBackfire = ? WHERE dbID = ?", toJSON(data), vehicleId)
			end
			
			dbExec(connection, "UPDATE vehicles SET backfire = ? WHERE dbID = ?", cvalue, vehicleId)
		elseif tuningId == "nitro" then
			setElementData(clientVehicle, "nitro", value)
			setElementData(clientVehicle, "nitroLevel", {2, 4})
			if value then cvalue = 1 else cvalue = 0 end
			dbExec(connection, "UPDATE vehicles SET nitro = ? WHERE dbID = ?", cvalue, vehicleId)
			dbExec(connection, "UPDATE vehicles SET nitroLevel = ? WHERE dbID = ?", toJSON({1, 4}), vehicleId)
		elseif tuningId == "nosrefill" then
			local nitroLevel = {value, 4}
			setElementData(clientVehicle, "nitroLevel", nitroLevel)
			dbExec(connection, "UPDATE vehicles SET nitroLevel = ? WHERE dbID = ?", toJSON(nitroLevel), vehicleId)
		elseif tuningId == "traffipaxRadar" then
			setElementData(clientVehicle, "traffipaxRadar", value)
			dbExec(connection, "UPDATE vehicles SET traffipaxRadar = ? WHERE dbID = ?", value, vehicleId)
		elseif tuningId == "customPlate" then
			dbQuery(function(qh, client, vehicle, tuningId, value, data)
				local result = dbPoll(qh, 0)
				local vehicleId = getElementData(vehicle, "vehicle.dbID") or false
				
				if vehicleId then
					if data and value then
						plateFound[vehicle] = false
						
						for i = 1, #result do
							if result[i].plate then
								if result[i].plate:gsub("-", "") == data:gsub("-", "") then
									plateFound[vehicle] = true
									break
								end
							end
							
							if result[i].customPlate then
								if result[i].customPlate:gsub("-", "") == data:gsub("-", "") then
									plateFound[vehicle] = true
									break
								end
							end
						end
						
						if plateFound[vehicle] then
							exports.sGui:showInfobox(client, "e", "Ilyen rendszámmal már létezik jármű!")
							triggerClientEvent(client, "tuningTryToBuyResponse", client, false)
							plateFound[vehicle] = nil
							return
						end
					end
					
					local tuningPrice = getTuningPrice(tuningId, value, vehicle)
					
					if tuningPrice and tuningPrice[1] == "pp" then
						local premiumPoints = exports.sCore:getPP(client)
						
						if (premiumPoints - tuningPrice[2]) < 0 then
							exports.sGui:showInfobox(client, "e", "Nincs elég prémiumpontod!")
							triggerClientEvent(client, "tuningTryToBuyResponse", client, false)
							return
						else
							exports.sCore:setPP(client, premiumPoints - tuningPrice[2])
							exports.sGui:showInfobox(client, "s", "Sikeresen megvásároltad a kiválasztott tuningot.")
						end 
					end
					
					if value then
						setVehiclePlateText(vehicle, data)
						setElementData(vehicle, "customPlate", true)
						dbExec(connection, "UPDATE vehicles SET customPlate = ? WHERE dbID = ?", data, vehicleId)
						triggerClientEvent("applyVehiclePlate", vehicle, vehicle, true)
					else
						local defaultPlate = getElementData(vehicle, "defaultPlate") or encodeDatabaseId(vehicleId)
						
						setVehiclePlateText(vehicle, defaultPlate)
						setElementData(vehicle, "customPlate", false)
						dbExec(connection, "UPDATE vehicles SET customPlate = ? WHERE dbID = ?", "", vehicleId)
						triggerClientEvent("applyVehiclePlate", vehicle, vehicle, true)
						value = 0
					end
					
					plateFound[vehicle] = nil
					previewDatas[vehicle].newPlateText = true
					triggerClientEvent(client, "tuningTryToBuyResponse", client, true)
					triggerClientEvent(getVehicleOccupants(vehicle), "gotTuningValuesFromServer", client, vehicle, {{tuningId, value}})
				end
			end, {client, clientVehicle, tuningId, value, data}, connection, "SELECT * FROM vehicles")
		elseif tuningId == "driveType" then	
			if value == "set" then
				local driveType = getElementData(clientVehicle, "driveType")
				
				setElementData(clientVehicle, "customDriveType", true)
				setElementData(clientVehicle, "driveType", driveType)
				dbExec(connection, "UPDATE vehicles SET driveType = ? WHERE dbID = ?", driveType, vehicleId)
				dbExec(connection, "UPDATE vehicles SET customDriveType = ? WHERE dbID = ?", 1, vehicleId)
			else
				local customDriveType = getElementData(clientVehicle, "customDriveType") or false
				
				if customDriveType then
					setElementData(clientVehicle, "customDriveType", false)
					dbExec(connection, "UPDATE vehicles SET customDriveType = ? WHERE dbID = ?", 0, vehicleId)
				end
				
				setElementData(clientVehicle, "driveType", value)
				dbExec(connection, "UPDATE vehicles SET driveType = ? WHERE dbID = ?", value, vehicleId)
			end
		elseif tuningId == "customHorn" then
			setElementData(clientVehicle, "customHorn", value)
			dbExec(connection, "UPDATE vehicles SET customHorn = ? WHERE dbID = ?", value, vehicleId)
		elseif tuningId == "lsdDoor" then
			setElementData(clientVehicle, "lsdDoor", value)
			if value then cvalue = 1 else cvalue = 0 end
			dbExec(connection, "UPDATE vehicles SET lsdDoor = ? WHERE dbID = ?", cvalue, vehicleId)
		elseif tuningId == "steeringLock" then
			setElementData(clientVehicle, "steeringLock", value)
			dbExec(connection, "UPDATE vehicles SET steeringLock = ? WHERE dbID = ?", value, vehicleId)
		elseif tuningId == "variant" then
			local cvalue = value - 1
			
			if cvalue < 0 then
				setVehicleVariant(clientVehicle, 255, 255)
			else
				setVehicleVariant(clientVehicle, cvalue, 255)
			end
			previewDatas[clientVehicle].variantReset = "buyed"
			
			local variantData = toJSON({cvalue, 255})
			dbExec(connection, "UPDATE vehicles SET variant = ? WHERE dbID = ?", variantData, vehicleId)
		elseif tuningId == "offroadSetting" then
			setElementData(clientVehicle, "offroadSetting", value)
			dbExec(connection, "UPDATE vehicles SET offroadSetting = ? WHERE dbID = ?", value, vehicleId)
		elseif tuningId == "abs" then
			local automaticShifter = getElementData(clientVehicle, "haveAutomaticShifter")
			if automaticShifter and automaticShifter > 0 and not acceptedPrompt and value and value > 0 then
				triggerClientEvent(client, "warnPlayerTuning", client, "Automata váltó", "ABS", {"haveAutomaticShifter", tuningId, value})
				--triggerClientEvent(client, "tuningTryToBuyResponse", client, false)
				return
			else

				local tuningPrice = tuningPrices[tuningId]
			
				if tuningPrice then
					tuningPrice = getTuningPrice(tuningId, value, clientVehicle)
					
					if tuningPrice and tuningId ~= "customPlate" then
						if tuningPrice[1] and tuningPrice[1] == "pp" then
							local premiumPoints = exports.sCore:getPP(client)
							
							if (premiumPoints - tuningPrice[2]) < 0 then
								exports.sGui:showInfobox(client, "e", "Nincs elég prémiumpontod!")
								triggerClientEvent(client, "tuningTryToBuyResponse", client, false)
								return
							else
								exports.sCore:setPP(client, premiumPoints - tuningPrice[2])
								exports.sGui:showInfobox(client, "s", "Sikeresen megvásároltad a kiválasztott tuningot.")
							end 
						elseif tuningPrice[1] and tuningPrice[1] == "cash" or tonumber(tuningPrice) then
							local currentMoney = exports.sCore:getMoney(client)
							
							if (currentMoney - tuningPrice[2]) < 0 then
								exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
								triggerClientEvent(client, "tuningTryToBuyResponse", client, false)
								return
							else
								exports.sCore:setMoney(client, currentMoney - tuningPrice[2])
								exports.sGui:showInfobox(client, "s", "Sikeresen megvásároltad a kiválasztott tuningot.")
							end
						end
					end
				end

				if acceptedPrompt then
					setElementData(clientVehicle, "haveAutomaticShifter", false)
					triggerClientEvent(client, "updateShifter", client, false)
				end
				setElementData(clientVehicle, "abs", value)
				dbExec(connection, "UPDATE vehicles SET abs = ? WHERE dbID = ?", value, vehicleId)
			end
		elseif tuningId == "automaticShifter" then
			local abs = getElementData(clientVehicle, "abs")
			if abs and abs > 0 and value and value ~= "set" and value > 0 and not acceptedPrompt then
				triggerClientEvent(client, "warnPlayerTuning", client, "ABS", "Automata váltó", {"abs", tuningId, value})
				--triggerClientEvent(client, "tuningTryToBuyResponse", client, false)
				return
			else

				local tuningPrice = tuningPrices[tuningId]
			
				if tuningPrice then
					tuningPrice = getTuningPrice(tuningId, value, clientVehicle)
					
					if tuningPrice and tuningId ~= "customPlate" then
						if tuningPrice[1] and tuningPrice[1] == "pp" then
							local premiumPoints = exports.sCore:getPP(client)
							
							if (premiumPoints - tuningPrice[2]) < 0 then
								exports.sGui:showInfobox(client, "e", "Nincs elég prémiumpontod!")
								triggerClientEvent(client, "tuningTryToBuyResponse", client, false)
								return
							else
								exports.sCore:setPP(client, premiumPoints - tuningPrice[2])
								exports.sGui:showInfobox(client, "s", "Sikeresen megvásároltad a kiválasztott tuningot.")
							end 
						elseif tuningPrice[1] and tuningPrice[1] == "cash" or tonumber(tuningPrice) then
							local currentMoney = exports.sCore:getMoney(client)
							
							if (currentMoney - tuningPrice[2]) < 0 then
								exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
								triggerClientEvent(client, "tuningTryToBuyResponse", client, false)
								return
							else
								exports.sCore:setMoney(client, currentMoney - tuningPrice[2])
								exports.sGui:showInfobox(client, "s", "Sikeresen megvásároltad a kiválasztott tuningot.")
							end
						end
					end
				end

				if acceptedPrompt then
					setElementData(clientVehicle, "abs", false)
				end
				triggerClientEvent(client, "updateShifter", client, value)
				setElementData(clientVehicle, "haveAutomaticShifter", value)
				dbExec(connection, "UPDATE vehicles SET automaticShifter = ? WHERE dbID = ?", value, vehicleId)
			end
		elseif tuningId == "color" then
			local vehicleColor = previewDatas[clientVehicle].color
			
			if value == 1 then
				vehicleColor[1] = data[1]
				vehicleColor[2] = data[2]
				vehicleColor[3] = data[3]
			elseif value == 2 then
				vehicleColor[4] = data[1]
				vehicleColor[5] = data[2]
				vehicleColor[6] = data[3]
			elseif value == 3 then
				vehicleColor[7] = data[1]
				vehicleColor[8] = data[2]
				vehicleColor[9] = data[3]
			elseif value == 4 then
				vehicleColor[10] = data[1]
				vehicleColor[11] = data[2]
				vehicleColor[12] = data[3]
			end
			
			previewDatas[clientVehicle].color = vehicleColor
			setVehicleColor(clientVehicle, unpack(vehicleColor))
			dbExec(connection, "UPDATE vehicles SET color = ? WHERE dbID = ?", toJSON(vehicleColor), vehicleId)
		elseif tuningId == "headlightPaintjob" then
			setElementData(clientVehicle, "headlightPaintjob", value)
			if not value then value = 0 end
			dbExec(connection, "UPDATE vehicles SET currentHeadlightTexture = ? WHERE dbID = ?", value, vehicleId)
		elseif tuningId == "wheelPaintjob" then
			setElementData(clientVehicle, "wheelPaintjob", value)
			if not value then value = 0 end
			dbExec(connection, "UPDATE vehicles SET currentWheelTexture = ? WHERE dbID = ?", value, vehicleId)
		elseif tuningId == "headlightColor" then
			setElementData(clientVehicle, "headlightColor", value)
			previewDatas[clientVehicle].headlightColorState = true
			setVehicleHeadLightColor(clientVehicle,  getColorFromString("#" .. value))
			dbExec(connection, "UPDATE vehicles SET headlightColor = ? WHERE dbID = ?", value, vehicleId)
		elseif tuningId == "wheelwidth.front" then
			previewDatas[clientVehicle].wheelWidthFront = true
			setElementData(clientVehicle, "wheelwidth.front", value)
			dbExec(connection, "UPDATE vehicles SET wheelWidthFront = ? WHERE dbID = ?", value, vehicleId)
		elseif tuningId == "wheelwidth.rear" then
			previewDatas[clientVehicle].wheelWidthRear = true
			setElementData(clientVehicle, "wheelwidth.rear", value)
			dbExec(connection, "UPDATE vehicles SET wheelWidthRear = ? WHERE dbID = ?", value, vehicleId)
		elseif tuningId == "spinner" then
			if data then
				setElementData(clientVehicle, "spinner", {value, unpack(data)})
				dbExec(connection, "UPDATE vehicles SET spinner = ? WHERE dbID = ?", value, vehicleId)
				dbExec(connection, "UPDATE vehicles SET spinnerColor = ? WHERE dbID = ?", toJSON(data), vehicleId)
			else
				setElementData(clientVehicle, "spinner", value)
				dbExec(connection, "UPDATE vehicles SET spinner = ? WHERE dbID = ?", value, vehicleId)
				dbExec(connection, "UPDATE vehicles SET spinnerColor = ? WHERE dbID = ?", toJSON({}), vehicleId)
			end
		elseif tuningId == "neon" then
			setElementData(clientVehicle, "neon", value)
			if not value then value = "" end
			dbExec(connection, "UPDATE vehicles SET neon = ? WHERE dbID = ?", value, vehicleId)
		elseif tuningId == "rideTuning" then
			if not value then value = 0 end
			setElementData(clientVehicle, "rideTuning", value)
			dbExec(connection, "UPDATE vehicles SET airride = ? WHERE dbID = ?", value, vehicleId)
		elseif monitoredDataKeys[tuningId] then
			local tempValues = {}
			local splittedDataValue = split(tuningId, ".")
			
			if splittedDataValue[1] == "performance" then
				setElementData(clientVehicle, tuningId, value)
				
				if splittedDataValue[2] == "turbo" and data then
					setElementData(clientVehicle, "customTurbo", data)
					dbExec(connection, "UPDATE vehicles SET customTurbo = ? WHERE dbID = ?", toJSON(data), vehicleId)
				end
				
				for key, value in pairs(monitoredDataKeys) do
					local splittedKeyValue = split(key, ".")
					
					if splittedKeyValue[1] == "performance" then
						local dataValue = getElementData(clientVehicle, key) or false
						
						if dataValue then
							tempValues[splittedKeyValue[2]] = dataValue
						end
					end
				end
				
				dbExec(connection, "UPDATE vehicles SET performanceTuning = ? WHERE dbID = ?", toJSON(tempValues), vehicleId)
			end
		else
			local tuningDetalist = split(tuningId, ".")
			
			if tuningDetalist[1] == "optical" then
				local opticals = getElementData(clientVehicle, "vehicle.opticalTunings") or {}
				
				if not value then
					for key, value in pairs(opticals) do
						if key == tuningDetalist[2] then
							removeVehicleUpgrade(clientVehicle, value)
							opticals[key] = nil
						end
					end
				end
				
				opticals[tuningDetalist[2]] = value
				previewDatas[clientVehicle].buyedOptical = true
				setElementData(clientVehicle, "vehicle.opticalTunings", opticals)
				dbExec(connection, "UPDATE vehicles SET opticalTunings = ? WHERE dbID = ?", toJSON(opticals), vehicleId)
			end
		end
		
		if tuningId ~= "color" and tuningId ~= "customPlate" then
			triggerClientEvent(vehicleOccupants, "gotTuningValuesFromServer", client, clientVehicle, {{tuningId, value}})
		end
		
		makeTuning(clientVehicle)
		
		if tuningId ~= "customPlate" then
			triggerClientEvent(client, "tuningTryToBuyResponse", client, true)
		end
		
		if tuningId == "paintjob" then
			if not value then
				setElementData(clientVehicle, "paintjob", false)
				setElementData(clientVehicle, "customPaintjob", false)
				triggerClientEvent(root, "paintjobRefreshedOnVehicle", clientVehicle)
				dbExec(connection, "UPDATE vehicles SET paintjob = ? WHERE dbID = ?", 0, vehicleId)
			end
		end
	end
end)

addEvent("syncTuningSpectatorAltHandler", true)
addEventHandler("syncTuningSpectatorAltHandler", getRootElement(), function(index, data)
	local clientVehicle = getPedOccupiedVehicle(client)
	
	if clientVehicle and carsInWorkshop[clientVehicle] then
		local vehicleOccupants = getVehicleOccupants(clientVehicle)
		triggerClientEvent(vehicleOccupants, "syncTuningSpectatorAltHandler", clientVehicle, index, data)
	end
end)

function makeTuning(vehicle)
	if vehicle then
		local performanceTuningDataValues = {}
		local vehicleModel = getElementData(vehicle, "vehicle.customModel") or getElementModel(vehicle)
		if not tonumber(vehicleModel) then
			originalHandling = getOriginalHandling(445)
		else
			originalHandling = getOriginalHandling(vehicleModel)
		end
		
		for propertyName, propertyValue in pairs(originalHandling) do
			setVehicleHandling(vehicle, propertyName, propertyValue)
		end
		local modelHandlingOverride = exports.sVehicles:getModelHandlingOverride(vehicleModel)
		
		if modelHandlingOverride then
			for propertyName, propertyValue in pairs(modelHandlingOverride) do
				setVehicleHandling(vehicle, propertyName, propertyValue)
			end
		end
		
		for key in pairs(monitoredDataKeys) do
			local splittedDataValue = split(key, ".")
			
			if splittedDataValue[1] == "performance" then
				local dataValue = getElementData(vehicle, key) or 0
				local dataName = gettok(key, 2, ".")
				
				if dataValue > 0 then
					performanceTuningDataValues[dataName] = dataValue
				end
			end
		end
		
		local currentHandling = getVehicleHandling(vehicle)
		local appliedHandling = {}
		
		for tuningName, tuningValue in pairs(performanceTuningDataValues) do
			for propertyName, propertyValue in pairs(performanceTuningValues[tuningName]) do
				local tmp = propertyValue[math.min(#propertyValue, tuningValue)]
				
				if currentHandling[propertyName] and tmp then
					if not appliedHandling[propertyName] then
						appliedHandling[propertyName] = currentHandling[propertyName]
					end
					
					appliedHandling[propertyName] = appliedHandling[propertyName] + (appliedHandling[propertyName] * (tmp / 135))
				end
			end
		end
		
		for propertyName, propertyValue in pairs(appliedHandling) do
			setVehicleHandling(vehicle, propertyName, propertyValue)
		end
		
		local driveType = getElementData(vehicle, "driveType") or "awd"
		local currentDriveType = "awd"
		
		if driveType == "handling" then
			if modelHandlingOverride and modelHandlingOverride.driveType then
				currentDriveType = modelHandlingOverride.driveType
			elseif originalHandling.driveType then
				currentDriveType = originalHandling.driveType
			else
				currentDriveType = "awd"
			end
		else
			currentDriveType = driveType
		end
		setVehicleHandling(vehicle, "driveType", currentDriveType)
		setElementData(vehicle, "driveType", currentDriveType)
		
		local steeringLock = getElementData(vehicle, "steeringLock") or 0
		local currentSteeringLock = getVehicleHandling(vehicle).steeringLock
		steeringLock = currentSteeringLock + ((steeringLock / 10) * currentSteeringLock)

		if steeringLock > 60 then
			steeringLock = 60
		end
		
		setVehicleHandling(vehicle, "steeringLock", steeringLock)
		
		local ecuTuning = getElementData(vehicle, "performance.ecu") or false
		
		if (ecuTuning and tonumber(ecuTuning)) == 4 then
			local ecuDatas = exports.sVehicles:getVehicleEcuData(vehicle)
			local currentHandling = getVehicleHandling(vehicle)
			
			local maxVelocity = currentHandling.maxVelocity
			local engineAcceleration = currentHandling.engineAcceleration
			local engineInertia = currentHandling.engineInertia

			local multipler = ecuDatas.averageMultipler -- 0.0 - 1.0
			local balance = ecuDatas.balanceValue       -- -1.0 - 1.0

			local baseVelocityBonus = maxVelocity * 0.08 * multipler

			local baseAccelerationBonus = 0
			if balance <= 0 then
				baseAccelerationBonus = engineAcceleration * 0.08 * multipler
			end

			local velocityAdjustment = 0
			local accelerationAdjustment = 0
			
			if balance >= 0 then
				-- Végsebesség mód (0 - 1)
				velocityAdjustment = maxVelocity * 0.15 * balance * multipler
				
				accelerationAdjustment = engineAcceleration * 0.15 * balance * multipler
			else
				-- Gyorsulás mód (-1 - 0)
				velocityAdjustment = maxVelocity * 0.05 * balance * multipler
				accelerationAdjustment = engineAcceleration * 0.30 * -balance * multipler
			end

			local inertiaChange = 0
			if balance < 0 then
				inertiaChange = -engineInertia * 0.25 * -balance * multipler
			elseif balance > 0 then

				inertiaChange = engineInertia * (1.2 + (balance * 0.7)) * multipler
			end

			engineInertia = engineInertia + inertiaChange
			
			maxVelocity = maxVelocity + baseVelocityBonus + velocityAdjustment
			engineAcceleration = engineAcceleration + baseAccelerationBonus + accelerationAdjustment

			if balance > 0 then
				local currentDragCoeff = getVehicleHandling(vehicle).dragCoeff
				local dragAdjustment = -currentDragCoeff * 0.25 * balance * multipler
				setVehicleHandling(vehicle, "dragCoeff", currentDragCoeff + dragAdjustment)
			end

			setVehicleHandling(vehicle, "maxVelocity", maxVelocity)
			setVehicleHandling(vehicle, "engineAcceleration", engineAcceleration)
			setVehicleHandling(vehicle, "engineInertia", engineInertia)
		end
		local currentHandling = getVehicleHandling(vehicle)
		local correctFuel = exports.sVehicles:getFuelType(vehicle) or "petrol"
		local vehicleFueled = (getElementData(vehicle, "vehicle.fuelType") or {1, "petrol", "petrol", 100})
		
		if getElementData(vehicle, "dieselFuel") then
			local maxVelocity = currentHandling.maxVelocity
			local engineAcceleration = currentHandling.engineAcceleration
			local engineInertia = currentHandling.engineInertia
			
			setVehicleHandling(vehicle, "maxVelocity", maxVelocity - 5)
			setVehicleHandling(vehicle, "engineAcceleration", engineAcceleration - 2)
			setVehicleHandling(vehicle, "engineInertia", engineInertia - 2)
			
		end
		if correctFuel == vehicleFueled[2] then
			local fuelQuality = ((vehicleFueled[1] or 1) - 1) * 4
			local maxVelocity = currentHandling.maxVelocity
			local engineAcceleration = currentHandling.engineAcceleration
			local engineInertia = currentHandling.engineInertia
			
			engineInertia = engineInertia + fuelQuality
			engineAcceleration = engineAcceleration + fuelQuality
			maxVelocity = maxVelocity + fuelQuality
			
			setVehicleHandling(vehicle, "maxVelocity", maxVelocity)
			setVehicleHandling(vehicle, "engineAcceleration", engineAcceleration)
			setVehicleHandling(vehicle, "engineInertia", engineInertia)
		end
		
		if exports.sSpeedo:isVehicleElectric(vehicle) then
			if getElementData(vehicle, "vehicle.fuel") < 60 then
				local currentHandling = getVehicleHandling(vehicle)
				local maxVelocity = currentHandling.maxVelocity
				
				local minusVelocity = (75 - (75 - getElementData(vehicle, "vehicle.fuel")) - 75)
				setVehicleHandling(vehicle, "maxVelocity", maxVelocity + minusVelocity)
				
				local engineAcceleration = currentHandling.engineAcceleration
				local minusAcceleration = (75 - (75 - getElementData(vehicle, "vehicle.fuel")) - 75) / 10
				setVehicleHandling(vehicle, "engineAcceleration", engineAcceleration + minusAcceleration)
			end
		end
		
		local value = getVehicleHandling(vehicle).handlingFlags
		local flagsSet = {}
		
		for k, v in pairs(handlingFlags) do
			if isFlagSet(value, v) then
				flagsSet[k] = true
			end
		end
		
		local offroadSetting = getElementData(vehicle, "offroadSetting") or 0
		
		local wheelwidthFront = getElementData(vehicle, "wheelwidth.front") or 0
		local wheelwidthRear = getElementData(vehicle, "wheelwidth.rear") or 0
		
		local frontWheelHandlingFlags = {
			[1] = "WHEEL_F_NARROW2",
			[2] = "WHEEL_F_NARROW",
			[3] = "WHEEL_F_WIDE",
			[4] = "WHEEL_F_WIDE2",
		}
		
		local rearWheelHandlingFlags = {
			[1] = "WHEEL_R_NARROW2",
			[2] = "WHEEL_R_NARROW",
			[3] = "WHEEL_R_WIDE",
			[4] = "WHEEL_R_WIDE2",
		}
		
		if frontWheelHandlingFlags[wheelwidthFront] then
			flagsSet[frontWheelHandlingFlags[wheelwidthFront]] = true
		end
		
		if rearWheelHandlingFlags[wheelwidthRear] then
			flagsSet[rearWheelHandlingFlags[wheelwidthRear]] = true
		end
		
		flagsSet.OFFROAD_ABILITY = offroadSetting == 1
		flagsSet.OFFROAD_ABILITY2 = offroadSetting == 2
		
		flagsSet.USE_MAXSP_LIMIT = true
		
		local flagsValue = 0
		
		for k, v in pairs(flagsSet) do
			if v then
				flagsValue = flagsValue + handlingFlags[k]
			end
		end
		
		setVehicleHandling(vehicle, "handlingFlags", flagsValue)
		
		local airrideState = getElementData(vehicle, "rideTuning") or 0
		if airrideState == 5 then
			local airrideBias = getElementData(vehicle, "airrideBias") or 0
			local airrideLevel = getElementData(vehicle, "airrideLevel") or 0
			local airrideSoftness = getElementData(vehicle, "airrideSoftness") or 0
			
			local handling = getOriginalHandling(getElementModel(vehicle))
			
			local suspensionLowerLimit = handling.suspensionLowerLimit + (airrideLevel * 0.0175)
			local suspensionFrontRearBias = airrideBias == 0 and handling.suspensionFrontRearBias or (handling.suspensionFrontRearBias + (-airrideBias * 0.0575))
			local suspensionForceLevel = airrideSoftness == 0 and handling.suspensionForceLevel or (handling.suspensionForceLevel + (-airrideSoftness * 0.175))
			
			setVehicleHandling(vehicle, "suspensionLowerLimit", suspensionLowerLimit)
			setVehicleHandling(vehicle, "suspensionFrontRearBias", suspensionFrontRearBias)
			setVehicleHandling(vehicle, "suspensionForceLevel", suspensionForceLevel)
			
			triggerClientEvent(getVehicleOccupants(vehicle), "gotVehicleAirRide", vehicle, airrideLevel, airrideBias, airrideSoftness)
			
		elseif airrideState ~= 0 then
			local suspensionLowerLimit = getVehicleHandling(vehicle).suspensionLowerLimit
			suspensionLowerLimit = suspensionLowerLimit + (airrideState * 0.015)
			setVehicleHandling(vehicle, "suspensionLowerLimit", suspensionLowerLimit)
		end
		
		local modelFlags = getVehicleHandling(vehicle).modelFlags
		
		if bitAnd(modelFlags, 0x1000) ~= 0x1000 then
			modelFlags = modelFlags + 0x1000
		end
		
		setVehicleHandling(vehicle, "modelFlags", modelFlags)

		if isWinter then
			if not getElementData(vehicle, "winterTires") then
				local tractionLoss = getVehicleHandling(vehicle).tractionLoss
				local tractionMultiplier = getVehicleHandling(vehicle).tractionMultiplier

				setVehicleHandling(vehicle, "tractionLoss", tractionLoss + 0.45)
				setVehicleHandling(vehicle, "tractionMultiplier", tractionMultiplier - 0.45)
			end
		else
			if getElementData(vehicle, "winterTires") then
				local tractionLoss = getVehicleHandling(vehicle).tractionLoss
				local tractionMultiplier = getVehicleHandling(vehicle).tractionMultiplier

				setVehicleHandling(vehicle, "tractionLoss", tractionLoss + 0.45)

				setVehicleHandling(vehicle, "tractionMultiplier", tractionMultiplier - 0.45)
			end
		end
		if not isWinter then
			if getElementData(vehicle, "frontWinter") and not getElementData(vehicle, "rearWinter") then
				setVehicleHandling(vehicle, "tractionBias", 0.35)
			end
			if getElementData(vehicle, "rearWinter") and not getElementData(vehicle, "frontWinter") then
				setVehicleHandling(vehicle, "tractionBias", 0.65)
			end
		else
			if getElementData(vehicle, "frontWinter") and not getElementData(vehicle, "rearWinter") then
				setVehicleHandling(vehicle, "tractionBias", 0.65)
			end
			if getElementData(vehicle, "rearWinter") and not getElementData(vehicle, "frontWinter") then
				setVehicleHandling(vehicle, "tractionBias", 0.35)
			end
		end
	end
end

function getHandlingProperty(model, property)
	if isElement(model) then
		model = getElementModel(model)
	end
	
	if customHandling[model] then
		if customHandling[model][property] then
			return customHandling[model][property]
		else
			return getOriginalHandling(model)[property]
		end
	else
		return getOriginalHandling(model)[property]
	end
	
	return false
end

function encodeDatabaseId(databaseId)
	local n3 = databaseId % 10
	databaseId = (databaseId - n3) / 10
	
	local n1 = databaseId % 10
	databaseId = (databaseId - n1) / 10
	
	local n2 = databaseId % 10
	databaseId = (databaseId - n2) / 10
	
	local c1 = databaseId % 14
	databaseId = (databaseId - c1) / 14
	
	local c2 = databaseId % 14
	databaseId = (databaseId - c2) / 14
	
	return "" .. string.format("%c%c-%c%c-%c%c",
	databaseId + string.byte("A"),
	c2 + string.byte("A"),
	c1 + string.byte("A"),
	n2 + string.byte("A"),
	n1 + string.byte("0"),
	n3 + string.byte("0")
)
end