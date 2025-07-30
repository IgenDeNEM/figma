local connection = false

local queueCount = {}
local queueTimer = {}
local createdVehicles = {}

local jumperPairs = {}

local vehicleStartTimer = {}

local batteryTimers = {}

local vehicleEcuDatas = {}

function getVehicleEcuData(vehicle)
	return vehicleEcuDatas[vehicle]
end

function saveVehicleEcuData(balanceValue, ecuValues, multiplerValue, player, vehicle)
	local vehicleId = getElementData(vehicle, "vehicle.dbID")

	if vehicleId then
		local ecuSaveDatas = {}

		vehicleEcuDatas[vehicle].balanceValue = balanceValue
		vehicleEcuDatas[vehicle].averageMultipler = multiplerValue
		vehicleEcuDatas[vehicle].customEcuValues = ecuValues

		ecuSaveDatas["balanceValue"] = balanceValue
		ecuSaveDatas["averageMultipler"] = multiplerValue * 10
		ecuSaveDatas["customEcuValues"] = toJSON(ecuValues)

    	exports.sConnection:dbUpdate("vehicles", ecuSaveDatas, {dbID = vehicleId})
		exports.sTuning:makeTuning(vehicle)
	end

	if player and vehicle then
		triggerClientEvent(getVehicleOccupants(vehicle), "gotVehicleEcuData", vehicle, balanceValue, ecuValues)
	end
end

function generateVehicleEcuData(vehicle)
	local vehicleId = getElementData(vehicle, "vehicle.dbID")

	if vehicleId then
		local ecuValues = {}

		for i = 1, 6 do
		    ecuValues[i] = math.random(-1000, 1000) / 1000
		end

		if not vehicleEcuDatas[vehicle] then
			vehicleEcuDatas[vehicle] = {}
		end

		vehicleEcuDatas[vehicle].balanceValue = 0
		vehicleEcuDatas[vehicle].averageMultipler = 0
		vehicleEcuDatas[vehicle].ecuValues = ecuValues
		vehicleEcuDatas[vehicle].customEcuValues = {0, 0, 0, 0, 0, 0}
		dbExec(connection, "UPDATE vehicles SET ecuValues = ? WHERE dbID = ?", toJSON(ecuValues), vehicleId)
	end
end

addCommandHandler("loadbestecu", function(client)
	if exports.sPermission:hasPermission(client, "loadbestecu") then
		local vehicle = getPedOccupiedVehicle(client)

		if vehicle then
			local vehicleId = getElementData(vehicle, "vehicle.dbID")
			local bestEcu = vehicleEcuDatas[vehicle].ecuValues

			vehicleEcuDatas[vehicle].customEcuValues = bestEcu
			dbExec(connection, "UPDATE vehicles SET customEcuValues = ? WHERE dbID = ?", toJSON(bestEcu), vehicleId)
			triggerClientEvent(getVehicleOccupants(vehicle), "gotVehicleEcuData", vehicle, vehicleEcuDatas[vehicle].balanceValue, bestEcu)
			outputChatBox("[color=sightgreen][SightMTA - ECU]: [color=hudwhite]Az optimális ECU sikeresen betöltve.", client, 255, 255, 255, true)
		else
			outputChatBox("[color=sightred][SightMTA - ECU]: [color=hudwhite]Nem ülsz járműben.", client, 255, 255, 255, true)
		end
	end
end)

function createGroupVehicles()
	dbQuery(function(qh, client)
		local result = dbPoll(qh, 0)
		spawnPlayerVehicles(getRootElement(), result)
	end, connection, "SELECT * FROM vehicles WHERE groupPrefix IS NOT NULL AND groupPrefix != '0'")
end

addEventHandler("onResourceStart", getRootElement(), function(res)
    local resName = getResourceName(res)

    if res == getThisResource() then
        connection = exports.sConnection:getConnection()

        for key, player in pairs(getElementsByType("player")) do
        	requestPlayerVehicles(player)
        end
		createGroupVehicles()
    elseif resName == "sConnection" then
        connection = exports.sConnection:getConnection()
    end

	--[[
	for model, handlings in pairs(modelHandlingOverride) do
		if tonumber(model) then
						
			for property, value in pairs(getOriginalHandling(model)) do
				if tonumber(model) then
					setModelHandling(model, property, value)
				end
			end

			for property, value in pairs(handlings) do
				if tonumber(model) then
					setModelHandling(model, property, value)
				end
			end

			local modelFlags = getModelHandling(model).modelFlags
			
			if bitAnd(modelFlags, 0x1000) ~= 0x1000 then
				modelFlags = modelFlags + 0x1000
			end
			if tonumber(model) then
				setModelHandling(model, "modelFlags", modelFlags)
			end
		end

		for k, v in pairs(getElementsByType("vehicle")) do
			if getElementData(v, "vehicle.customModel") then
				for property, value in pairs(getOriginalHandling(445)) do
					setVehicleHandling(v, property, value)
				end

				for property, value in pairs(handlings) do
					setVehicleHandling(v, property, value)
				end

				local model = getElementData(v, "vehicle.customModel") or getElementModel(v)

				local modelFlags = modelHandlingOverride[model].modelFlags
				
				if bitAnd(modelFlags, 0x1000) ~= 0x1000 then
					modelFlags = modelFlags + 0x1000
				end
				setVehicleHandling(v, "modelFlags", modelFlags)
			end
		end

		if model == 598 then
		end
	end
	]]
end)

addEventHandler("onResourceStop", resourceRoot, function()
	for key, vehicle in pairs(getElementsByType("vehicle")) do
		if isElement(vehicle) then
			saveVehicle(vehicle)
		end
	end
end)

addEventHandler("onElementDataChange", getRootElement(), function(dataName, oldValue, newValue)
	local elementType = getElementType(source)

	if elementType == "player" then
		if dataName == "loggedIn" and newValue then
			requestPlayerVehicles(source)
		end
	elseif elementType == "vehicle" then
		local vehicleOccupants = getVehicleOccupants(source)
		if vehicleOccupants then
			if dataName == "vehicle.checkengine" then
				triggerClientEvent(vehicleOccupants, "gotCheckEngineLightLevel", source, newValue)
			elseif dataName == "vehicle.fuel" then 
				triggerClientEvent(vehicleOccupants, "gotVehicleFuelLevel", source, newValue)
			elseif dataName == "vehicle.oil" then 
				triggerClientEvent(vehicleOccupants, "gotVehicleOilLevel", source, newValue)
			elseif dataName == "vehicle.charging" then
				if newValue then
					setElementData(source, "vehicle.handbrake", true)
					setElementFrozen(source, true)
				end
			elseif dataName == "vehradio.menu" and newValue then 
				if (getElementData(source, "vehicle.batteryCharge") or 2048) < 0.1 then
					setElementData(source, "vehradio.menu", "off")
					setElementData(source, "vehradio.state", false)
				else
					if newValue == "home" and oldValue and oldValue == "off" then
						local batteryRate = (getElementData(source, "vehicle.batteryRate") or 0)

						local rate = math.abs(getBatteryValues(source, "radio"))
			
						local finalRate = batteryRate - rate
			
						setElementData(source, "vehicle.batteryRate", finalRate)
			
						local maxCharge = getElementData(source, "vehicle.maxBatteryCharge")
			
						local batteryCharge = getElementData(source, "vehicle.batteryCharge")
			
						triggerClientEvent(vehicleOccupants, "gotVehicleBatteryCharge", source, batteryCharge, maxCharge, 2048, finalRate)
					elseif newValue == "off" then
						local batteryRate = (getElementData(source, "vehicle.batteryRate") or 0)

						local rate = math.abs(getBatteryValues(source, "radio"))
			
						local finalRate = batteryRate + rate
			
						setElementData(source, "vehicle.batteryRate", finalRate)
			
						local maxCharge = getElementData(source, "vehicle.maxBatteryCharge")
			
						local batteryCharge = getElementData(source, "vehicle.batteryCharge")
			
						triggerClientEvent(vehicleOccupants, "gotVehicleBatteryCharge", source, batteryCharge, maxCharge, 2048, finalRate)
					end
				end
			end
		end
	end
end)

addEventHandler("onVehicleStartExit", getRootElement(),
  function(player)
    if player then
		if startingVehicles[source] then
			triggerClientEvent(getRootElement(), "carStartingSound", source, "startfail")
		end
      if exports.sSpeedo:getVehicleSpeed(source, "KMH") > 1 then
        cancelEvent()
		exports.sGui:showInfobox(player, "e", "Menet közben nem tudsz kiszállni!")
      end
    end
  end
)

addEventHandler("onVehicleStartEnter", root, function(player, seat, jacked)
	if jacked then
		cancelEvent()
	end

	if getVehicleType(source) == "Boat" then
		local hp = getElementHealth(source)
		if hp > 320 then
			setElementData(source, "vehicle.engine", true)
			setVehicleEngineState(source, true)
		else
			setElementData(source, "vehicle.engine", false)
			setVehicleEngineState(source, false)
		end
	end
end
)

addEventHandler("onPlayerQuit", getRootElement(), function()
	local playerVehicles = createdVehicles[source]

	if playerVehicles then
		for key, vehicle in pairs(playerVehicles) do
			if isElement(vehicle) then
				local deleted = true
				local groupId = getElementData(vehicle, "vehicle.group") or false
				local ts = getRealTime().timestamp
				local protected = getElementData(vehicle, "vehicleProtected") or false
				
				if groupId and groupId == 0 or groupId == "0" then
					groupId = false
				end

				if protected and protected >= ts then
					deleted = false
				end

				if groupId then
					deleted = false
				end

				saveVehicle(vehicle, deleted)

				if deleted then
					if isElement(vehicle) then
						triggerClientEvent(root, "disableCoronaSirens", root, vehicleElement)
					end
				end
			end
		end
		createdVehicles[source] = nil
	end
end)

function saveVehicle(vehicle, delete)
	local vehicleId = getElementData(vehicle, "vehicle.dbID") or false

	if vehicleId then
		local saveDatas = {}

		local vx, vy, vz = getElementPosition(vehicle)
		local rx, ry, rz = getElementRotation(vehicle)
		local vdim, vint = getElementDimension(vehicle), getElementInterior(vehicle)

		local engineState = getElementData(vehicle, "vehicle.engine") or false
		local ignitionState = getElementData(vehicle, "vehicle.ignition") or false
		local handbrakeState = getElementData(vehicle, "vehicle.handbrake") or false
		local lockState = getElementData(vehicle, "vehicle.locked") or false

		if engineState then engineState = 1 else engineState = 0 end
		if ignitionState then ignitionState = 1 else ignitionState = 0 end
		if handbrakeState then handbrakeState = 1 else handbrakeState = 0 end
		if lockState then lockState = 1 else lockState = 0 end

	    saveDatas["health"] = getElementHealth(vehicle)
	    saveDatas["position"] = toJSON({vx, vy, vz, vdim, vint})
	    saveDatas["rotation"] = toJSON({rx, ry, rz})
	    saveDatas["engine"] = engineState
	    saveDatas["ignition"] = ignitionState
	    saveDatas["light"] = getElementData(vehicle, "vehicle.lights") or 0
	    saveDatas["handbrake"] = handbrakeState
	    saveDatas["locked"] = lockState
	    saveDatas["pulling"] = (tonumber(getElementData(vehicle, "vehicle.pulling")) * 10) or 0
	    saveDatas["currentFueled"] = toJSON((getElementData(vehicle, "vehicle.fuelType") or {1, "petrol", "petrol", 100}))
	    saveDatas["airrideMemory1"] = toJSON((getElementData(vehicle, "vehicle.airRideMemory:1") or {0, 0, 0}))
	    saveDatas["airrideMemory2"] = toJSON((getElementData(vehicle, "vehicle.airRideMemory:2") or {0, 0, 0}))
	    saveDatas["airrideMemory3"] = toJSON((getElementData(vehicle, "vehicle.airRideMemory:3") or {0, 0, 0}))
	    saveDatas["airrideMemory4"] = toJSON((getElementData(vehicle, "vehicle.airRideMemory:4") or {0, 0, 0}))

	    saveDatas["vehradio.wallpaper"] = getElementData(vehicle, "vehradio.wallpaper") or 0
	    saveDatas["vehradio.brightness"] = getElementData(vehicle, "vehradio.brightness") or 6
		local audio = getElementData(vehicle, "vehradio.sysAudio") and 1 or 0
	    saveDatas["vehradio.sysAudio"] = audio
	    saveDatas["vehradio.favorites"] = toJSON((getElementData(vehicle, "vehradio.favorites") or {}))
	    saveDatas["vehradio.station"] = (getElementData(vehicle, "vehradio.station") or 1)

	    saveDatas["batteryCharge"] = tonumber(getElementData(vehicle, "vehicle.batteryCharge") or 2048)
	    saveDatas["maxBatteryCharge"] = tonumber(getElementData(vehicle, "vehicle.maxBatteryCharge") or 2048)
	    saveDatas["batteryRate"] = tonumber(getElementData(vehicle, "vehicle.batteryRate") or 0)
	    saveDatas["winterTires"] = getElementData(vehicle, "winterTires") and 1 or 0
	    saveDatas["frontWinter"] = getElementData(vehicle, "frontWinter") and 1 or 0
	    saveDatas["rearWinter"] = getElementData(vehicle, "rearWinter") and 1 or 0

	    local vehicleDistance = getElementData(vehicle, "vehicle.distance") or 0
	    vehicleDistance = tonumber(vehicleDistance)

	   	local vehicleFuel = getElementData(vehicle, "vehicle.fuel") or 0
	    vehicleFuel = tonumber(vehicleFuel)

		local vehicleOil = getElementData(vehicle, "vehicle.oil") or 0
	    vehicleOil = tonumber(vehicleOil)

		local checkEngineLevel = getElementData(vehicle, "vehicle.checkengine") or 0
		checkEngineLevel = tonumber(checkEngineLevel)

	    saveDatas["distance"] = math.floor(vehicleDistance)
	    saveDatas["fuel"] = math.floor(vehicleFuel)
	    saveDatas["oil"] = math.floor(vehicleOil)
	    saveDatas["checkengine"] = math.floor(checkEngineLevel)

		local fl, rl, fr, rr = getVehicleWheelStates(vehicle)
		saveDatas["wheelStates"] = toJSON({fl, rl, fr, rr})
		
		local panelStates = {}
		for i = 2, 8 do
			table.insert(panelStates, i - 1, getVehiclePanelState(vehicle, i - 2))
		end
		saveDatas["panelStates"] = toJSON(panelStates)
		
		local doorStates = {}
		for i = 2, 7 do
			table.insert(doorStates, i - 1, getVehicleDoorState(vehicle, i - 2))
		end
		
		local lightStates = {}
		for i = 1, 4 do
			table.insert(lightStates, getVehicleDoorState(vehicle, i - 1))
		end
		saveDatas["doorStates"] = toJSON(doorStates)
		saveDatas["lightStates"] = toJSON(lightStates)

		local mechanicData = {
			frontLeftPanel = getElementData(vehicle, "vehicle.mechanic.frontLeftPanel") or {2, 0},
			frontRightPanel = getElementData(vehicle, "vehicle.mechanic.frontRightPanel") or {2, 0},
			rearLeftPanel = getElementData(vehicle, "vehicle.mechanic.rearLeftPanel") or {2, 0},
			rearRightPanel = getElementData(vehicle, "vehicle.mechanic.rearRightPanel") or {2, 0},
			windscreen = getElementData(vehicle, "vehicle.mechanic.windscreen") or {2, 0},
			frontBumper = getElementData(vehicle, "vehicle.mechanic.frontBumper") or {2, 0},
			rearBumper = getElementData(vehicle, "vehicle.mechanic.rearBumper") or {2, 0},
			hood = getElementData(vehicle, "vehicle.mechanic.hood") or {2, 0},
			trunk = getElementData(vehicle, "vehicle.mechanic.trunk") or {2, 0},
			frontLeftDoor = getElementData(vehicle, "vehicle.mechanic.frontLeftDoor") or {2, 0},
			frontRightDoor = getElementData(vehicle, "vehicle.mechanic.frontRightDoor") or {2, 0},
			rearLeftDoor = getElementData(vehicle, "vehicle.mechanic.rearLeftDoor") or {2, 0},
			rearRightDoor = getElementData(vehicle, "vehicle.mechanic.rearRightDoor") or {2, 0},
			frontTires = getElementData(vehicle, "vehicle.mechanic.frontTires") or {2, 0},
			rearTires = getElementData(vehicle, "vehicle.mechanic.rearTires") or {2, 0},
			frontLeftLight = getElementData(vehicle, "vehicle.mechanic.frontLeftLight") or {2, 0},
			frontRightLight = getElementData(vehicle, "vehicle.mechanic.frontRightLight") or {2, 0},
			rearLeftLight = getElementData(vehicle, "vehicle.mechanic.rearLeftLight") or {2, 0},
			rearRightLight = getElementData(vehicle, "vehicle.mechanic.rearRightLight") or {2, 0},
			oilChangeKit = getElementData(vehicle, "vehicle.mechanic.oilChangeKit") or {2, 0},
			engineRepairKit = getElementData(vehicle, "vehicle.mechanic.engineRepairKit") or {2, 0},
			engineGeneralKit = getElementData(vehicle, "vehicle.mechanic.engineGeneralKit") or {2, 0},
			engineTimingKit = getElementData(vehicle, "vehicle.mechanic.engineTimingKit") or {2, 0},
			battery = getElementData(vehicle, "vehicle.mechanic.battery") or {2, 0},
			fuelRepairKit = getElementData(vehicle, "vehicle.mechanic.fuelRepairKit") or {2, 0},
			frontBrakes = getElementData(vehicle, "vehicle.mechanic.frontBrakes") or {2, 0},
			rearBrakes = getElementData(vehicle, "vehicle.mechanic.rearBrakes") or {2, 0},
			frontLeftSuspension = getElementData(vehicle, "vehicle.mechanic.frontLeftSuspension") or {2, 0},
			frontRightSuspension = getElementData(vehicle, "vehicle.mechanic.frontRightSuspension") or {2, 0},
			rearLeftSuspension = getElementData(vehicle, "vehicle.mechanic.rearLeftSuspension") or {2, 0},
			rearRightSuspension = getElementData(vehicle, "vehicle.mechanic.rearRightSuspension") or {2, 0},
		}
		saveDatas["mechanicDatas"] = toJSON(mechanicData)
		local errorCodes = getElementData(vehicle, "vehicle.errorCodes") or {}
		saveDatas["errorCodes"] = (toJSON(errorCodes or {}) or "[ [ ] ]")

    	exports.sConnection:dbUpdate("vehicles", saveDatas, {dbID = vehicleId})

		if delete then
			destroyElement(vehicle)
		end
	    return true
	else
		return false
	end
end

function requestPlayerVehicles(client)
	local characterId = getElementData(client, "char.ID")
	
	if characterId then
		dbQuery(function(qh, client)
			local result = dbPoll(qh, 0)
			spawnPlayerVehicles(client, result)
		end, {client}, connection, "SELECT * FROM vehicles WHERE characterId = ? AND (groupPrefix IS NULL OR groupPrefix = '0')", characterId)
	end
end

function processJson(jsonTable)
    local function convertKeys(table)
        local newTable = {}
        for key, value in pairs(table) do
            local numericKey = tonumber(key)
            if numericKey then
                key = numericKey
            end

            if type(value) == "table" then
                newTable[key] = convertKeys(value)
            else
                newTable[key] = value
            end
        end
        return newTable
    end

    return convertKeys(jsonTable)
end

local spawnQueue = {}
local spawnQueueMax = {}
local savedQueue = {}

function spawnPlayerVehicles(client, datas, new, carshop)
    spawnQueue[client] = spawnQueue[client] or {}

	for i, data in ipairs(datas) do
        table.insert(spawnQueue[client], data)
    end
	
	if not savedQueue[client] then
		savedQueue[client] = #spawnQueue[client]
	end

	if new then
		if savedQueue[client] then
			savedQueue[client] = savedQueue[client] + 1
		end
	end

	local newCount = #spawnQueue[client]
    queueCount[client] = newCount
	if client ~= getRootElement() then
    	triggerClientEvent(client, "refreshVehiclesQueue", client, newCount, savedQueue[client])
	end
    
    if not (queueTimer[client] and isTimer(queueTimer[client])) then
        queueTimer[client] = setTimer(function()
            local data = table.remove(spawnQueue[client], 1)
            if data then
                local vehicleElements = getElementsByType("vehicle")
                local vehicleExists = false
                for _, vehicle in pairs(vehicleElements) do
                    local vehicleId = getElementData(vehicle, "vehicle.dbID") or false
                    if vehicleId and vehicleId == data.dbID then
                        vehicleExists = true
                        break
                    end
                end

                if not vehicleExists then
                    local position = fromJSON(data.position)
                    local rotation = fromJSON(data.rotation)
                    local color = fromJSON(data.color)

                    local vehicle = createVehicle(data.modelId, position[1], position[2], position[3])
					setTimer(function(vehicle, hp)
						if isElement(vehicle) then
							setElementHealth(vehicle, hp)
						end
					end, 1000, 1, vehicle, data.health)
                    setElementDimension(vehicle, position[4])
                    setElementInterior(vehicle, position[5])
                    setElementRotation(vehicle, rotation[1], rotation[2], rotation[3])
                    setVehicleColor(vehicle, unpack(color))
                    setVehicleHeadLightColor(vehicle, getColorFromString("#" .. data.headlightColor))

                    if data.customModel == "false" then
                        data.customModel = false
                    end

                    if data.customModel then
                        setElementData(vehicle, "vehicle.customModel", data.customModel)
                    end
                    setElementData(vehicle, "vehicle.dbID", data.dbID)
                    setElementData(vehicle, "vehicle.owner", data.characterId)
                    setElementData(vehicle, "vehicle.group", data.groupPrefix)
                    setElementData(vehicle, "vehicle.fuel", data.fuel)
                    setElementData(vehicle, "vehicle.oil", data.oil)
                    setElementData(vehicle, "vehicle.pulling", tonumber(data.pulling) / 10)
                    setElementData(vehicle, "vehicle.parkPosition", fromJSON(data.parkPosition))
                    setElementData(vehicle, "vehicle.distance", data.distance)
                    setElementData(vehicle, "vehicle.checkengine", data.checkengine)
                    setElementData(vehicle, "vehicle.impounded", data.impounded)

                    if not data.plate or utfLen(data.plate) == 0 then
                        data.plate = encodeDatabaseId(data.dbID)
                        dbExec(connection, "UPDATE vehicles SET plate = ? WHERE dbID = ?", data.plate, data.dbID)
                    end

                    local plateText = data.plate
                    
                    if data.customPlate and utfLen(data.customPlate) > 0 then
                        setElementData(vehicle, "customPlate", true)
                        setVehiclePlateText(vehicle, data.customPlate)
                        plateText = data.customPlate
                    else
                        setVehiclePlateText(vehicle, data.plate)
                    end
                    setElementData(vehicle, "defaultPlate", plateText)

                    setElementData(vehicle, "vehicle.ignition", data.ignition == 1)
                    setElementData(vehicle, "vehicle.engine", data.engine == 1)
                    setVehicleEngineState(vehicle, data.engine == 1)

                    setElementData(vehicle, "vehicle.lights", data.light)

                    local currentFueled = fromJSON(data.currentFueled) or {1, "petrol", "petrol", 100}
                    setElementData(vehicle, "vehicle.fuelType", currentFueled)

                    local mechanicData = fromJSON(data.mechanicDatas) or {}
                    local errorCodes = fromJSON(data.errorCodes) or {}
                    errorCodes = processJson(errorCodes)
                    setElementData(vehicle, "vehicle.errorCodes", errorCodes)
                    for k, v in pairs(mechanicData) do
                        setElementData(vehicle, "vehicle.mechanic." .. k, v)
                    end

                    setVehicleOverrideLights(vehicle, data.light == 1 and 2 or 1)

                    setElementData(vehicle, "vehicle.handbrake", data.handbrake == 1)
                    setElementFrozen(vehicle, data.handbrake == 1)

                    setElementData(vehicle, "vehicle.locked", data.locked == 1)
                    setVehicleLocked(vehicle, data.locked == 1)

                    vehicleEcuDatas[vehicle] = {}
                    vehicleEcuDatas[vehicle].balanceValue = data.balanceValue
                    vehicleEcuDatas[vehicle].averageMultipler = data.averageMultipler / 10
                    vehicleEcuDatas[vehicle].ecuValues = fromJSON(data.ecuValues)
                    vehicleEcuDatas[vehicle].customEcuValues = fromJSON(data.customEcuValues)

                    local performanceTuning = fromJSON(data.performanceTuning)
                    local customTurbo = fromJSON(data.customTurbo)
                    local customBackfire = fromJSON(data.customBackfire)

                    for key, value in pairs(performanceTuning) do
                        setElementData(vehicle, "performance." .. key, value)
                    end

                    if customTurbo and customTurbo[1] and customTurbo[2] and customTurbo[3] and customTurbo[4] then
                        setElementData(vehicle, "customTurbo", customTurbo)
                    end

                    if customBackfire and customBackfire[1] and customBackfire[2] and customBackfire[3] then
                        setElementData(vehicle, "customBackfire", customBackfire)
                    end

                    if tonumber(data.backfire) == 0 then data.backfire = false end
                    setElementData(vehicle, "backfire", data.backfire)

                    setElementData(vehicle, "nitro", data.nitro == 1)
                    setElementData(vehicle, "nitroLevel", fromJSON(data.nitroLevel))
                    
                    setElementData(vehicle, "traffipaxRadar", data.traffipaxRadar)
                    setElementData(vehicle, "driveType", data.driveType)
                    setElementData(vehicle, "customDriveType", data.customDriveType == 1)
                    setElementData(vehicle, "customHorn", data.customHorn)
                    setElementData(vehicle, "lsdDoor", data.lsdDoor == 1)
                    setElementData(vehicle, "steeringLock", data.steeringLock)
                    setElementData(vehicle, "offroadSetting", data.offroadSetting)
                    setElementData(vehicle, "abs", data.abs)
                    setElementData(vehicle, "haveAutomaticShifter", (data.automaticShifter or 0))
                    setElementData(vehicle, "vehicle.currentTexture", data.currentTexture)
                    setElementData(vehicle, "wheelPaintjob", data.currentWheelTexture)
                    setElementData(vehicle, "headlightPaintjob", data.currentHeadlightTexture)
                    setElementData(vehicle, "wheelwidth.front", data.wheelWidthFront)
                    setElementData(vehicle, "wheelwidth.rear", data.wheelWidthRear)

                    if data.spinnerColor[1] and data.spinnerColor[2] and data.spinnerColor[3] then
                        setElementData(vehicle, "spinner", {data.spinner, unpack(data.spinnerColor)})
                    else
                        setElementData(vehicle, "spinner", data.spinner)
                    end

                    if data.neon == "custom" then
                        data.neonData = fromJSON(data.neonData)
                        local neonSideColor = data.neonData[1] or "white"
                        local neonFrontColor = data.neonData[2] or "white"

                        setElementData(vehicle, "neon", data.neon)
                        setElementData(vehicle, "neonData", {neonSideColor, neonFrontColor})

                        if neonSideColor ~= "off" then
                            setElementData(vehicle, "neonSide", neonSideColor)
                        else
                            setElementData(vehicle, "neonSide", false)
                        end

                        if neonFrontColor ~= "off" then
                            setElementData(vehicle, "neonFront", neonFrontColor)
                        else
                            setElementData(vehicle, "neonFront", false)
                        end
                    elseif data.neon and data.neon ~= "" then
                        setElementData(vehicle, "neon", data.neon)
                    end    

                    local variant = fromJSON(data.variant)
                    if variant then
                        if variant[1] and variant[2] then
                            setElementData(vehicle, "vehicle.Variant", {variant[1], variant[2]})
                            setVehicleVariant(vehicle, variant[1], variant[2])
                        else
                            setVehicleVariant(vehicle, 255, 255)
                        end
                    else
                        setVehicleVariant(vehicle, 255, 255)
                    end
                    
                    setElementData(vehicle, "vehicle.opticalTunings", fromJSON(data.opticalTunings))
                    setElementData(vehicle, "rideTuning", data.airride or 0)

                    data.airrideDatas = fromJSON(data.airrideDatas)
                    local airrideLevel = data.airrideDatas[1] or 0
                    local airrideBias = data.airrideDatas[2] or 0
                    local airrideSoftness = data.airrideDatas[3] or 0

                    setElementData(vehicle, "rideTuning", data.airride or 0)
                    setElementData(vehicle, "airrideLevel", airrideLevel)
                    setElementData(vehicle, "airrideBias", airrideBias)
                    setElementData(vehicle, "airrideSoftness", airrideSoftness)
                    setElementData(vehicle, "vehicle.airRideMemory:1", fromJSON(data.airrideMemory1))
                    setElementData(vehicle, "vehicle.airRideMemory:2", fromJSON(data.airrideMemory2))
                    setElementData(vehicle, "vehicle.airRideMemory:3", fromJSON(data.airrideMemory3))
                    setElementData(vehicle, "vehicle.airRideMemory:4", fromJSON(data.airrideMemory4))

                    setElementData(vehicle, "vehradio.wallpaper", data["vehradio.wallpaper"])
                    setElementData(vehicle, "vehradio.brightness", data["vehradio.brightness"])

					local frontWheelTuning = fromJSON(data["frontWheelTuning"])
					local rearWheelTuning = fromJSON(data["rearWheelTuning"])

					local frontCount = 0
					local rearCount = 0

					for k, v in pairs(frontWheelTuning) do
						frontCount = frontCount + 1
					end	

					for k, v in pairs(rearWheelTuning) do
						rearCount = rearCount + 1
					end	

					if frontCount > 0 then
						setElementData(vehicle, "tuning.wheels.front", frontWheelTuning)
					end

					if rearCount > 0 then
						setElementData(vehicle, "tuning.wheels.back", rearWheelTuning)
					end

                    local audio = data["vehradio.sysAudio"] == 1 and true or false

                    local winterTire = data["winterTires"] == 1 and true or false

                    local frontWinter = data["frontWinter"] == 1 and true or false
                    local rearWinter = data["rearWinter"] == 1 and true or false

                    setElementData(vehicle, "vehradio.sysAudio", audio)


                    setElementData(vehicle, "winterTires", winterTire)

                    setElementData(vehicle, "frontWinter", frontWinter)
                    setElementData(vehicle, "rearWinter", rearWinter)

                    setElementData(vehicle, "vehradio.station", data["vehradio.station"])
                    setElementData(vehicle, "vehradio.favorites", processJson(fromJSON(data["vehradio.favorites"])))

                    setElementData(vehicle, "vehicle.currentTexture", tonumber(data.paintjob))

                    setElementData(vehicle, "vehicle.batteryCharge", tonumber(data.batteryCharge))
                    setElementData(vehicle, "vehicle.maxBatteryCharge", tonumber(data.maxBatteryCharge))
                    setElementData(vehicle, "vehicle.batteryRate", tonumber(data.batteryRate))

                    local wheelStates = fromJSON(data.wheelStates)
                    setVehicleWheelStates(vehicle, unpack(wheelStates))

					local doorStates = fromJSON(data.doorStates)
					for i = 1, #doorStates do
						setVehicleDoorState(vehicle, i - 1, doorStates[i])
					end

					local panelStates = fromJSON(data.panelStates)
                    for i = 1, #panelStates do
                        setVehiclePanelState(vehicle, i - 1, panelStates[i])
                    end

					local lightStates = fromJSON(data.lightStates)
                    for i = 1, #lightStates do
                        setVehicleLightState(vehicle, i - 1, lightStates[i])
                    end

                    if data.paintjob == -1 then
                        setElementData(vehicle, "customPaintjob", true)
                        setElementData(vehicle, "paintjob", data.paintjob)
                    else
                        setElementData(vehicle, "paintjob", data.paintjob)
                    end

                    if data.protected and data.protected > 0 then
                        local ts = getRealTime().timestamp
                        if data.protected >= ts then
                            setElementData(vehicle, "vehicleProtected", data.protected)
                        else
                            dbExec(connection, "UPDATE vehicles SET protected = ? WHERE dbID = ?", 0, data.dbID)
                        end
                    end

                    if not data.fuelType then
                        local fuelType = getAvailableFuelTypes(data.modelId)
                        dbExec(connection, "UPDATE vehicles SET fuelType = ? WHERE dbID = ?", fuelType[1], data.dbID)
                    end

                    if data.fuelType == "diesel" then
                        setElementData(vehicle, "dieselFuel", true)
                    end

                    if new then
                        generateVehicleEcuData(vehicle)
                        if not carshop then
                            warpPedIntoVehicle(client, vehicle)
                        end
                    end
                    
                    local modelFlags = getVehicleHandling(vehicle).modelFlags
                    if bitAnd(modelFlags, 0x1000) ~= 0x1000 then
                        modelFlags = modelFlags + 0x1000
                    end
                    setVehicleHandling(vehicle, "modelFlags", modelFlags)

                    exports.sNocol:enableVehicleNoCol(vehicle, 30000)
                    exports.sTuning:makeTuning(vehicle)

                    if carshop then
                        triggerClientEvent(client, "gotVehicleGPSMark", client, vehicle, true)
                        local vehColors = {getVehicleColor(vehicle, true)}
                        local color = table.concat(vehColors, ',')
                        local currentTime = getRealTime().timestamp
                        local expireTime = currentTime + 2678400
						local modelId = (getElementData(vehicle, "vehicle.customModel") or getElementModel(vehicle))
                        local vehicleRealName = exports.sVehiclenames:getCustomVehicleName(modelId) or getVehicleNameFromModel(modelId)
                        exports.sItems:giveItem(client, 288, 1, false, toJSON({model = modelId, colors = color, owner = getElementData(client, "char.name"):gsub("_", " "),
                        numberPlate = getVehiclePlateText(vehicle), isDiesel = getElementData(vehicle, "dieselFuel") and 1 or 0, driveType = getElementData(vehicle, "driveType"), expireDate = expireTime / 24 / 60 / 60,
                        creationDate = getRealTime().timestamp, engine = getElementData(vehicle, "performance.engine"), turbo = getElementData(vehicle, "performance.turbo"), ecu = getElementData(vehicle, "performance.ecu"),
                        transmission = getElementData(vehicle, "performance.transmission"), suspension = getElementData(vehicle, "performance.suspension"), brake = getElementData(vehicle, "performance.brakes"),
                        tire = getElementData(vehicle, "performance.tires"), weightReduction = getElementData(vehicle, "performance.weightReduction"), rideHeight = getElementData(vehicle, "rideTuning"),
                        paintjob = getElementData(vehicle, "paintjob"), backfire = getElementData(vehicle, "backfire"), wheelPaintjob = getElementData(vehicle, "wheelPaintjob") ~= 0 and 1,
                        headlightPaintjob = getElementData(vehicle, "headlightPaintjob") ~= 0 and 1, lsdDoor = getElementData(vehicle, "lsdDoor"), nitro = getElementData(vehicle, "nitro"),
                        spinner = getElementData(vehicle, "spinner") ~= 0, vehicleId = getElementData(vehicle, "vehicle.dbID")}), vehicleRealName, tostring(plateText))
                        exports.sGui:showInfobox(client, "i", "A műszaki adatlapot megtalálod az inventorydban.")
                        exports.sGui:showInfobox(client, "i", "A forgalmi engedélyt a városházán ezzel tudod kiváltani.")
                    end

                    plateText = nil

                    createdVehicles[client] = createdVehicles[client] or {}
                    table.insert(createdVehicles[client], vehicle)

                    if new and not carshop then
                        if data.groupPrefix and exports.sGroups:isValidGroup(data.groupPrefix) then
                            exports.sGroups:requestGroupVehicles(data.groupPrefix)
                        else
							if data.groupPrefix and data.groupPrefix ~= 0 and data.groupPrefix ~= "" and data.groupPrefix ~= "0" then
                            	outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem létezik ilyen frakció! Frakció lista megtekintéséhez használd a /grouplist parancsot!", client)
							end
                        end
                    end
                end
            end

            queueCount[client] = spawnQueue[client] and #spawnQueue[client] or 0
			if client ~= getRootElement() then
            	triggerClientEvent(client, "refreshVehiclesQueue", client, queueCount[client])
			end
            if queueCount[client] <= 0 then
                if isTimer(queueTimer[client]) then
                    killTimer(queueTimer[client])
                end
                queueTimer[client] = nil
            end
        end, 500, 0)
    end
end


addEvent("syncPlayerAccelerate", true)
addEventHandler("syncPlayerAccelerate", getRootElement(), function(players, state)
	triggerClientEvent(players, "syncPlayerAccelerate", client, state)
end)

startingVehicles = {}

addEvent("tryVehicleEngine", true)
addEventHandler("tryVehicleEngine", getRootElement(), function(state, ignitionState)
	local vehicle = getPedOccupiedVehicle(client)

	if vehicle then
		if ignitionState then
			if getVehicleEngineState(vehicle) then
				return
			end
		end
		local havePermissionToStart = getVehicleKey(client, vehicle)

		local vehType = getVehicleType(vehicle)
		if vehType == "Boat" then
			return
		end

		if havePermissionToStart then
			local currentTimeStamp = exports.sCore:getRealTimestamp() or getRealTime().timestamp
			local vehicleDistance = getElementData(vehicle, "vehicle.distance") or 0
			local vehicleFuel = getElementData(vehicle, "vehicle.fuel") or 0

			local vehicleStartTime = 1000
			local vehicleEngineHealth = getElementHealth(vehicle)
			local vehicleEngineBattery = getElementData(vehicle, "vehicle.batteryCharge") or 2048
			local vehicleMaxBattery = getElementData(vehicle, "vehicle.maxBatteryCharge") or 2048

			vehicleEngineHealth = math.max(320, math.min(1000, vehicleEngineHealth))
			vehicleEngineBattery = math.max(0, math.min(2048, vehicleEngineBattery))
		    vehicleStartTime = 1000 - (vehicleEngineHealth - 320) - (vehicleEngineBattery - 2048)
		    vehicleStartTime = math.max(0, math.min(1000, vehicleStartTime))


			if exports.sSpeedo:isVehicleElectric(vehicle) or getVehicleType(vehicle) == "Helicopter" then
				vehicleStartTime = 1
			end

			if vehicleEngineHealth <= 320 then
				vehicleStartTime = 9999999
			end
			if vehicleEngineBattery < 5 or vehicleMaxBattery < 1 and not exports.sSpeedo:isVehicleElectric(vehicle) and getVehicleType(vehicle) ~= "Helicopter" then
				local foundJumperPair = false
				for k, v in pairs(jumperPairs) do
					if v[1] == vehicle or v[2] == vehicle then
						if getVehicleEngineState(v[1]) or getVehicleEngineState(v[2]) then
							foundJumperPair = true
						end
					end
				end
				if not foundJumperPair and not exports.sSpeedo:isVehicleElectric(vehicle) and getVehicleType(vehicle) ~= "Helicopter" then
					vehicleStartTime = 99999991
					setElementData(vehicle, "vehradio.menu", "off")
					setElementData(vehicle, "vehradio.state", false)
				end
			end

			local vehicleIgnitionState = getElementData(vehicle, "vehicle.ignition") or false
			local vehicleEngineState = getElementData(vehicle, "vehicle.engine") or false
			local vehicleOccupants = getVehicleOccupants(vehicle)

			local vehicleModel = getElementModel(vehicle)
			local customVehicleModel = getElementData(vehicle, "vehicle.customModel")
			local vehicleRealName = exports.sVehiclenames:getCustomVehicleName(customVehicleModel) or exports.sVehiclenames:getCustomVehicleName(vehicleModel) or getVehicleNameFromModel(vehicleModel)


			if source == localPlayer and getVehicleType(vehicle) == "Boat" then
				if vehicleFuel <= 0 and state then
					exports.sGui:showInfobox(client, "e", "Nincs elég üzemanyag a járműben!")
					return
				end
				
				triggerClientEvent(getRootElement(), "carStartingSound", vehicle, "starting")
				startingVehicles[vehicle] = true
				
				vehicleStartTimer[vehicle] = setTimer(function(client)
					setVehicleEngineState(vehicle, true)
					setElementData(vehicle, "vehicle.engine", true)
					setElementData(vehicle, "vehicle.gear", "N")
					if not exports.sSpeedo:isVehicleElectric(vehicle) then
	                	triggerClientEvent(getRootElement(), "carStartingSound", vehicle, "started")
						startingVehicles[vehicle] = nil
					else
	                	triggerClientEvent(getVehicleOccupants(vehicle), "carStartingSound", vehicle, "elon")
						startingVehicles[vehicle] = nil
					end					
					exports.sChat:localAction(client, "beindította egy " .. vehicleRealName .. " motorját.")
				
					if getVehicleType(vehicle) == "Helicopter" then
						setVehicleRotorState(vehicle, true)
					end

					setElementData(vehicle, "vehicle.startTime", currentTimeStamp)
					setElementData(vehicle, "vehicle.startDistance", vehicleDistance)
				
					local vehicleStartTime = getRealTime().timestamp - currentTimeStamp
					local vehicleStartDistance = getElementData(vehicle, "vehicle.startDistance") or 0
				
					if vehicleStartTime then
						triggerClientEvent(client, "gotJourneyData", vehicle, vehicleStartTime, (vehicleDistance - vehicleStartDistance))
					else
						triggerClientEvent(client, "gotJourneyData", vehicle, 0, 0)
					end
				end, vehicleStartTime, 1, client)
			end

			if exports.sSpeedo:isVehicleElectric(vehicle) then
				vehicleIgnitionState = true
				ignitionState = false
			end

			if vehicleIgnitionState and ignitionState and state then
				triggerClientEvent(vehicleOccupants, "carStartingSound", vehicle, "key")
				setElementData(vehicle, "vehicle.ignition", false)
			elseif not vehicleIgnitionState and state then
				triggerClientEvent(vehicleOccupants, "carStartingSound", vehicle, "key")
				setElementData(vehicle, "vehicle.ignition", true)
				local batteryLevel = getElementData(vehicle, "vehicle.batteryCharge") or 2048
				local maxBatteryCharge = getElementData(vehicle, "vehicle.maxBatteryCharge") or 2048
				local batteryRate = (getElementData(vehicle, "vehicle.batteryRate") or 0) - math.abs(getBatteryValues(vehicle, "ignition"))
				triggerClientEvent(vehicleOccupants, "gotVehicleBatteryCharge", vehicle, batteryLevel, maxBatteryCharge, 2048, batteryRate)
				setElementData(vehicle, "vehicle.batteryRate", batteryRate)
			elseif not vehicleEngineState and state then
				if vehicleFuel <= 0 and state and vehicleStartTime ~= 99999991 then
					vehicleStartTime = 9999999
			    end

				if getElementData(vehicle, "vehicle.fueltype") == "faulty" then
					if isTimer(vehicleStartTimer[vehicle]) then
						killTimer(vehicleStartTimer[vehicle])
					end
					exports.sGui:showInfobox(client, "e", "Rossz üzemanyagot tankoltál a járművedbe, ezért az lerobbant!")
	
					setElementHealth(vehicle, 250)
					setElementData(vehicle, "vehicle.fueltype", nil)

					setElementData(vehicle, "vehicle.engine", false)
					setElementData(vehicle, "vehicle.gear", "N")
					setElementData(vehicle, "vehicle.ignition", false)
					setVehicleEngineState(vehicle, false)
	
					setElementData(vehicle, "vehicle.startTime", nil)
					setElementData(vehicle, "vehicle.startDistance", nil)
					return
				end

				if not exports.sSpeedo:isVehicleElectric(vehicle) and vehicleStartTime < 99999991 then
            		triggerClientEvent(getRootElement(), "carStartingSound", vehicle, "starting")
					startingVehicles[vehicle] = true
				end

				setElementData(vehicle, "vehicle.batteryRate", 0)
				local batteryLevel = getElementData(vehicle, "vehicle.batteryCharge") or 2048
				local maxBatteryCharge = getElementData(vehicle, "vehicle.maxBatteryCharge") or 2048
				local batteryRate = (getElementData(vehicle, "vehicle.batteryRate") or 0) + math.abs(getBatteryValues(vehicle, "ignition")) - math.abs(getBatteryValues(vehicle, "starter"))
				triggerClientEvent(vehicleOccupants, "gotVehicleBatteryCharge", vehicle, batteryLevel, maxBatteryCharge, 2048, batteryRate)
				setElementData(vehicle, "vehicle.batteryRate", batteryRate)


            	vehicleStartTimer[vehicle] = setTimer(function(client)
					setVehicleEngineState(vehicle, true)
	                setElementData(vehicle, "vehicle.engine", true)
	                setElementData(vehicle, "vehicle.gear", "N")
					if not exports.sSpeedo:isVehicleElectric(vehicle) then
	                	triggerClientEvent(getRootElement(), "carStartingSound", vehicle, "started")
						startingVehicles[vehicle] = nil
					else
	                	triggerClientEvent(getVehicleOccupants(vehicle), "carStartingSound", vehicle, "elon")
						startingVehicles[vehicle] = nil
					end
                	exports.sChat:localAction(client, "beindította egy " .. vehicleRealName .. " motorját.")

					setElementData(vehicle, "vehicle.startTime", currentTimeStamp)
                	setElementData(vehicle, "vehicle.startDistance", vehicleDistance)

					local vehicleStartTime = getRealTime().timestamp - currentTimeStamp
					local vehicleStartDistance = getElementData(vehicle, "vehicle.startDistance") or 0
				
					if vehicleStartTime then
						triggerClientEvent(client, "gotJourneyData", vehicle, vehicleStartTime, (vehicleDistance - vehicleStartDistance))
					else
						triggerClientEvent(client, "gotJourneyData", vehicle, 0, 0)
					end
					if getVehicleType(vehicle) ~= "Helicopter" then
						setElementData(vehicle, "vehicle.batteryCharge", (getElementData(vehicle, "vehicle.batteryCharge") or 2048) - (math.abs(getBatteryValues(vehicle, "starter") * ((vehicleStartTime + 1) / (12)))))
						local batteryLevel = getElementData(vehicle, "vehicle.batteryCharge") or 2048
						local maxBatteryCharge = getElementData(vehicle, "vehicle.maxBatteryCharge") or 2048
						local batteryRate = (getElementData(vehicle, "vehicle.batteryRate") or 0) + math.abs(getBatteryValues(vehicle, "ignition")) + math.abs(getBatteryValues(vehicle, "starter")) + math.abs(getBatteryValues(vehicle, "engine"))
						if batteryLevel < 0 then
							batteryLevel = 0
							setElementData(vehicle, "vehicle.batteryCharge", 0)
						end
						local charge = maxBatteryCharge
						if charge < 0 then
							charge = 0
						end
						setElementData(vehicle, "vehicle.maxBatteryCharge", charge)
						triggerClientEvent(vehicleOccupants, "gotVehicleBatteryCharge", vehicle, batteryLevel, charge, 2048, batteryRate)
						setElementData(vehicle, "vehicle.batteryRate", batteryRate)
					end

				end, vehicleStartTime, 1, client)
			elseif vehicleEngineState and state then
				setElementData(vehicle, "vehicle.engine", false)
				setElementData(vehicle, "vehicle.gear", "N")
                setElementData(vehicle, "vehicle.ignition", false)
                setVehicleEngineState(vehicle, false)
				if not exports.sSpeedo:isVehicleElectric(vehicle) then
                	triggerClientEvent(vehicleOccupants, "carStartingSound", vehicle, "key")                	
				else
					triggerClientEvent(getVehicleOccupants(vehicle), "carStartingSound", vehicle, "eloff")
				end
                exports.sChat:localAction(client, "leállította egy " .. vehicleRealName .. " motorját.")

				local batteryLevel = getElementData(vehicle, "vehicle.batteryCharge") or 2048
				local maxBatteryCharge = getElementData(vehicle, "vehicle.maxBatteryCharge") or 2048
				local batteryRate = 0

				if (getElementData(vehicle, "vehicle.lights") or 0) == 1 then
					batteryRate = batteryRate - math.abs(getBatteryValues(vehicle, "lights"))
				end

				if (getElementData(vehicle, "vehradio.menu") or "off") ~= "off" then
					batteryRate = batteryRate - math.abs(getBatteryValues(vehicle, "radio"))
				end

				triggerClientEvent(vehicleOccupants, "gotVehicleBatteryCharge", vehicle, batteryLevel, maxBatteryCharge, 2048, batteryRate)

				setElementData(vehicle, "vehicle.batteryRate", batteryRate)

				setElementData(vehicle, "vehicle.startTime", nil)
                setElementData(vehicle, "vehicle.startDistance", nil)
			end

			if not state then
				if isTimer(vehicleStartTimer[vehicle]) then
		        	killTimer(vehicleStartTimer[vehicle])
		        end

        		triggerClientEvent(getRootElement(), "carStartingSound", vehicle, "startfail")
			end
		end
	end
end)

addEvent("toggleVehicleLights", true)
addEventHandler("toggleVehicleLights", getRootElement(), function()
	local vehicle = getPedOccupiedVehicle(client)

	if vehicle then
		local vehicleLightState = getElementData(vehicle, "vehicle.lights") or 0
		local vehicleOccupants = getVehicleOccupants(vehicle)

		if vehicleLightState == 1 then
			setElementData(vehicle, "vehicle.lights", 0)
			setVehicleOverrideLights(vehicle, 1)

			local vehicleModel = getElementModel(vehicle)
			local customVehicleModel = getElementData(vehicle, "vehicle.customModel")
			local vehicleRealName = exports.sVehiclenames:getCustomVehicleName(customVehicleModel) or exports.sVehiclenames:getCustomVehicleName(vehicleModel) or getVehicleNameFromModel(vehicleModel)
			exports.sChat:localAction(client, "lekapcsolta egy ".. vehicleRealName .." lámpáit.")
			
			local batteryRate = (getElementData(vehicle, "vehicle.batteryRate") or 0)

			local rate = math.abs(getBatteryValues(vehicle, "lights"))

			local finalRate = batteryRate + rate

			setElementData(vehicle, "vehicle.batteryRate", finalRate)

			local maxCharge = getElementData(vehicle, "vehicle.maxBatteryCharge")

			local batteryCharge = getElementData(vehicle, "vehicle.batteryCharge")

			triggerClientEvent(vehicleOccupants, "gotVehicleBatteryCharge", vehicle, batteryCharge, maxCharge, 2048, finalRate)

		else
			setElementData(vehicle, "vehicle.lights", 1)
			setVehicleOverrideLights(vehicle, 2)

			local vehicleModel = getElementModel(vehicle)
			local customVehicleModel = getElementData(vehicle, "vehicle.customModel")
			local vehicleRealName = exports.sVehiclenames:getCustomVehicleName(customVehicleModel) or exports.sVehiclenames:getCustomVehicleName(vehicleModel) or getVehicleNameFromModel(vehicleModel)
			exports.sChat:localAction(client, "felkapcsolta egy ".. vehicleRealName .." lámpáit.")

			local batteryRate = (getElementData(vehicle, "vehicle.batteryRate") or 0)

			local rate = math.abs(getBatteryValues(vehicle, "lights"))

			local finalRate = batteryRate - rate

			setElementData(vehicle, "vehicle.batteryRate", finalRate)

			local maxCharge = getElementData(vehicle, "vehicle.maxBatteryCharge")

			local batteryCharge = getElementData(vehicle, "vehicle.batteryCharge")

			triggerClientEvent(vehicleOccupants, "gotVehicleBatteryCharge", vehicle, batteryCharge, maxCharge, 2048, finalRate)

		end

		triggerClientEvent(vehicleOccupants, "gotVehicleLightSwitch", vehicle)
	end
end)

addEvent("flashVehicleLights", true)
addEventHandler("flashVehicleLights", getRootElement(), function(state)
	local vehicle = getPedOccupiedVehicle(client)

	if vehicle then
		local vehicleLightState = getVehicleOverrideLights(vehicle)

		if state then
	        if vehicleLightState == 1 then
				setVehicleOverrideLights(vehicle, 2)
	        else
				setVehicleOverrideLights(vehicle, 1)
	        end
		else
			if vehicleLightState == 2 then
				setVehicleOverrideLights(vehicle, 1)
	        else
				setVehicleOverrideLights(vehicle, 2)
	        end
		end
	end
end)

addEvent("lockUnlockVehicle", true)
addEventHandler("lockUnlockVehicle", getRootElement(), function(vehicle, occupant, players)
	if vehicle then
		local havePermissionToStart = getVehicleKey(client, vehicle)

		if havePermissionToStart then
			local vehicleLockState = getElementData(vehicle, "vehicle.locked") or isVehicleLocked(vehicle)
			local vehicleOccupants = getVehicleOccupants(vehicle)

			local vehicleModel = getElementModel(vehicle)
			local customVehicleModel = getElementData(vehicle, "vehicle.customModel")
			local vehicleRealName = exports.sVehiclenames:getCustomVehicleName(customVehicleModel) or exports.sVehiclenames:getCustomVehicleName(vehicleModel) or getVehicleNameFromModel(vehicleModel)

			if getElementData(client, "isPlayerDeath") or getElementHealth(client) == 0 then
				return
			end

			if vehicleLockState then
				setElementData(vehicle, "vehicle.locked", false)
				setVehicleLocked(vehicle, false)
				exports.sChat:localAction(client, "kinyitotta egy " .. vehicleRealName .. " ajtaját.")
			else
				setElementData(vehicle, "vehicle.locked", true)
				setVehicleLocked(vehicle, true)
				exports.sChat:localAction(client, "bezárta egy " .. vehicleRealName .. " ajtaját.")

				for i = 0, 5 do
					setVehicleDoorOpenRatio(vehicle, i, 0)
				end

			end

			if occupant then
				local vehicleNewLockState = getElementData(vehicle, "vehicle.locked") or isVehicleLocked(vehicle)
	        	triggerClientEvent(vehicleOccupants, "vehicleLockSoundEffect", vehicle, occupant, vehicleNewLockState)
	      	end

	      	--setPedAnimation(client, "GHANDS", "gsign3LH", 2000, false, false, false)

	      	if players then
				local vehicleNewLockState = getElementData(vehicle, "vehicle.locked") or isVehicleLocked(vehicle)
	        	triggerClientEvent(players, "vehicleLockSoundEffect", vehicle, occupant, vehicleNewLockState)
	        	processLockEffect(vehicle)
	      	end
	    end
	end
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

addEvent("damageVehicleSuspension", true)
addEventHandler("damageVehicleSuspension", getRootElement(), function(vehicle, wheel, damage)
	local validVehicle = getPedOccupiedVehicle(client)
	if (vehicle and vehicle == validVehicle) and wheel and damage then
		local wheelState = getElementData(vehicle, "vehicle.wheelState:" .. wheel) or 0

		local damage = damage / 10
		local finalDamage = damage + wheelState

		local currentWheelPulling = getElementData(vehicle, "vehicle.pulling") or 0
		local wheelPullingDamage = ((damage / 20) / (getQuality(vehicle, "vehicle.mechanic.frontLeftSuspension", 2) + getQuality(vehicle, "vehicle.mechanic.frontRightSuspension", 2)))
		if wheel == 1 or wheel == 3 then
			local finalPullingValue = currentWheelPulling - wheelPullingDamage
			if finalPullingValue > 0.3 then
				finalPullingValue = 0.3
			end
			if finalPullingValue < -0.3 then
				finalPullingValue = -0.3
			end
			setElementData(vehicle, "vehicle.pulling", finalPullingValue)
		elseif wheel == 2 or wheel == 4 then
			local finalPullingValue = currentWheelPulling + wheelPullingDamage
			if finalPullingValue > 0.3 then
				finalPullingValue = 0.3
			end
			if finalPullingValue < -0.3 then
				finalPullingValue = -0.3
			end
			setElementData(vehicle, "vehicle.pulling", finalPullingValue)
		end

		if finalDamage >= 35 then
        	local fl, rl, fr, rr = getVehicleWheelStates(vehicle)


			local rearRightSuspensionQuality = getQuality(vehicle, 'vehicle.mechanic.rearRightSuspension', 2)
			local rearLeftSuspensionQuality = getQuality(vehicle, 'vehicle.mechanic.rearLeftSuspension', 2)
			local frontRightSuspensionQuality = getQuality(vehicle, 'vehicle.mechanic.frontRightSuspension', 2)
			local frontLeftSuspensionQuality = getQuality(vehicle, 'vehicle.mechanic.frontLeftSuspension', 2)

			if wheel == 1 then
	          	setVehicleWheelStates(vehicle, 1)
				setElementData(vehicle, "vehicle.mechanic.frontLeftSuspension", {frontLeftSuspensionQuality, 100})
			elseif wheel == 2 then
				setElementData(vehicle, "vehicle.mechanic.frontRightSuspension", {rearLeftSuspensionQuality, 100})
	          	setVehicleWheelStates(vehicle, fl, rl, 1)
			elseif wheel == 3 then
				setElementData(vehicle, "vehicle.mechanic.rearLeftSuspension", {frontRightSuspensionQuality, 100})
	          	setVehicleWheelStates(vehicle, fl, 1)
			elseif wheel == 4 then
				setElementData(vehicle, "vehicle.mechanic.rearRightSuspension", {rearRightSuspensionQuality, 100})
	          	setVehicleWheelStates(vehicle, fl, rl, fr, 1)
			end

			local fl = getCondition(vehicle, 'vehicle.mechanic.frontLeftSuspension', 0)
			local rl = getCondition(vehicle, 'vehicle.mechanic.rearLeftSuspension', 0)
			local fr = getCondition(vehicle, 'vehicle.mechanic.frontRightSuspension', 0)
			local rr = getCondition(vehicle, 'vehicle.mechanic.rearRightSuspension', 0)
		
			local fl = 100 - fl
			local rl = 100 - rl
			local fr = 100 - fr
			local rr = 100 - rr

			triggerClientEvent(source, "gotVehicleSuspensionState", vehicle, fl, rl, fr, rr)
		end
	end
end)

addEvent("damageBikeWheels", true)
addEventHandler("damageBikeWheels", getRootElement(), function(bike, wheel)
	local validBike = getPedOccupiedVehicle(client)

	if (bike and bike == validBike) and wheel then
        local fl, rl, fr, rr = getVehicleWheelStates(validBike)

		if wheel == 1 then
	        setVehicleWheelStates(validBike, 1)
		elseif wheel == 2 then
	        setVehicleWheelStates(validBike, fl, 1)
		end
	end
end)

addEvent("requestJumpstartPairList", true)
addEventHandler("requestJumpstartPairList", getRootElement(), function()
	triggerClientEvent(client, "gotJumpstartPairs", client, jumperPairs)
end)

addEvent("addJumpstarter", true)
addEventHandler("addJumpstarter", getRootElement(), function(veh, vehTo)
	table.insert(jumperPairs, {veh, vehTo, client})
	triggerClientEvent("addJumpstartPair", client, {veh, vehTo, client})
	local itemId = getElementData(client, "usingJumperCable")
	if itemId then
		exports.sItems:takeItem(client, "dbID", itemId)
		setElementData(client, "usingJumperCable", false, false)
	end

	setElementData(veh, "vehicle.charging", true)
	setElementData(vehTo, "vehicle.charging", true)
end)

addEvent("removeJumpstarter", true)
addEventHandler("removeJumpstarter", getRootElement(), function(veh)
	for k, v in pairs(jumperPairs) do
		if v[3] == client then
			triggerClientEvent("deleteJumpstartPair", client, v[1])
			triggerClientEvent("deleteJumpstartPair", client, v[2])

			setElementData(v[1], "vehicle.charging", false)
			setElementData(v[2], "vehicle.charging", false)

			if not getElementData(client, "usingJumperCable") then
				exports.sItems:giveItem(client, 441, 1)
			end
			table.remove(jumperPairs, k)
			break
		end
	end
end)

addEventHandler("onVehicleExplode", getRootElement(), function()
	resetVehicle(source)
end)

addEventHandler("onVehicleDamage", root, function(loss)
	local checkEngineLevel = 0
	local vehicleOccupants = getVehicleOccupants(source)
	local vehicleHealth = getElementHealth(source)
	local vehicleWheelStates = {getVehicleWheelStates(source)}

	for i = 1, 4 do
		local vehiclePanelStates = getVehiclePanelState(source, i)
		
		if vehiclePanelStates > 0 then
			checkEngineLevel = 1
			break
		end
	end

	for i = 0, 3 do
		local vehiclePanelStates = getVehicleLightState(source, i)
		
		if vehiclePanelStates > 0 then
			checkEngineLevel = 1
			break
		end
	end

	if vehicleHealth <= 500 then
		checkEngineLevel = 2
	end

	for i = 1, #vehicleWheelStates do
		if vehicleWheelStates[i] > 0 then
			checkEngineLevel = 2
			break
		end
	end

	setElementData(source, "vehicle.checkengine", checkEngineLevel)
	if vehicleOccupants then
		triggerClientEvent(vehicleOccupants, "gotCheckEngineLightLevel", source, checkEngineLevel)
	end

	if vehicleHealth <= 320 then
		setTimer(function(vehicleElement)
			if vehicleHealth <= 320 then
				setElementHealth(vehicleElement, 320)
			end
		end, 1000, 1, source)
		setElementHealth(source, 320)
		cancelEvent()
	end

	if vehicleHealth <= 320 then
		setElementHealth(source, 320)
		setElementData(source, "vehicle.engine", false)
		setElementData(source, "vehicle.gear", "N")
		setElementData(source, "vehicle.ignition", false)
		setVehicleEngineState(source, false)
		
		setElementData(source, "vehicle.batteryRate", 0)

		setElementData(source, "vehicle.startTime", nil)
		setElementData(source, "vehicle.startDistance", nil)
	end
end)

local customModels = {
	["model_s"] = true,
	["model_y"] = true,
	["leaf"] = true,
	["primo2"] = true,
	["audirs7"] = true,
	["dodge"] = true,
}

addCommandHandler("makeveh", function(client, commandName, targetPlayer, modelId, groupName, r, g, b)
	if exports.sPermission:hasPermission(client, "makeveh") then
		if not (targetPlayer and modelId) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Név / ID] [Model ID] [Frakció ID] [Szín 1] [Szín 2] [Szín 3]", client, 255, 255, 255, true)
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " Model ID helyére ha custom: model_s, model_y, leaf, primo2 (G20), dodge(RAM), audirs7(rs7)", client, 255, 255, 255, true)
		else
			local customModel = false
			local validModelId = false
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
				if not tonumber(modelId) and tostring(modelId) then
					if getVehicleModelFromName(modelId) then
						validModelId = getVehicleModelFromName(modelId)
	                	modelId = getVehicleModelFromName(modelId)
					end
	            elseif getVehicleNameFromModel(modelId) then
	                validModelId = getVehicleNameFromModel(modelId)
	            end
	            if not validModelId then
					customModel = modelId
					if customModels[customModel] then
						customModel = customModel
						validModelId = 445
						modelId = 445
					else
						customModel = false
						validModelId = false
					end
				end
	            if not validModelId then
	                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Ilyen modellel nem létezik jármű.", client, 255, 255, 255, true)
	                return
	            end

				if groupName and not exports.sGroups:isValidGroup(groupName) and groupName ~= 0 and groupName ~= "" then
					outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem létezik ilyen frakció! Frakció listához használd a /grouplist parancsot!", client)
					outputChatBox("[color=sightblue][SightMTA - Infó]: [color=hudwhite]Amennyiben nem akarod frakcióhoz kötni, a frakciónév legyen [color=sightblue]0[color=hudwhite]!", client)
					return
				end

				if groupName == 0 then
					groupName = nil
				end

            	local px, py, pz = getElementPosition(targetPlayer)
            	local rx, ry, rz = getElementRotation(targetPlayer)
            	local dim, int = getElementDimension(targetPlayer), getElementInterior(targetPlayer)

            	local r, g, b = r or 255, g or 255, b or 255
            	r, g, b = tonumber(r) or r, tonumber(g) or g, tonumber(b) or b
            	local characterId = getElementData(targetPlayer, "char.ID") or false

            	local validVehicleColor = {}

            	if r and not tonumber(r) then
            		validVehicleColor[1], validVehicleColor[2], validVehicleColor[3] = getColorFromString(r)
            	end
            	
            	if g and not tonumber(g) then
            		validVehicleColor[4], validVehicleColor[5], validVehicleColor[6] = getColorFromString(g)
            	end

            	if b and not tonumber(b) then
            		validVehicleColor[7], validVehicleColor[8], validVehicleColor[9] = getColorFromString(b)
            	end

            	if tonumber(r) and tonumber(g) and tonumber(b) then
            		validVehicleColor = {r, g, b}
            	else
            		if not validVehicleColor[1] and not validVehicleColor[2] and not validVehicleColor[3] then
            			validVehicleColor = {255, 255, 255}
            		end
            	end

            	if characterId then
            		local vehicleDatas = {}

            		vehicleDatas["characterId"] = characterId
            		vehicleDatas["modelId"] = modelId
					if customModel then
            			vehicleDatas["customModel"] = customModel or false
					end
            		vehicleDatas["color"] = toJSON(validVehicleColor)
            		vehicleDatas["groupPrefix"] = groupName
        			vehicleDatas["position"] = toJSON({px, py, pz, dim, int})
        			vehicleDatas["parkPosition"] = toJSON({px, py, pz, dim, int})
        			vehicleDatas["rotation"] = toJSON({rx, ry, rz})
        			vehicleDatas["fuel"] = getTankSize(modelId)


    				dbInsert("vehicles", vehicleDatas)
					
					dbQuery(function(qh, client, targetPlayer)
		                local result = dbPoll(qh, 0)

		                if result then
							exports.sGui:showInfobox(client, "s", "Sikeres jármű létrehozás! ID: " .. result[1].dbID)
							exports.sItems:giveItem(targetPlayer, 1, 1, false, result[1].dbID)
							spawnPlayerVehicles(targetPlayer, {result[1]}, true)
		                end
		            end, {client, targetPlayer}, connection, "SELECT * FROM vehicles WHERE dbID = LAST_INSERT_ID()")
            	end
	        end
		end
	end
end)

function createPermVehicle(data, dtype)
	local vehicleDatas = {}

	vehicleDatas["characterId"] = getElementData(data.targetPlayer, "char.ID")
	vehicleDatas["modelId"] = data.modelId
	vehicleDatas["color"] = toJSON(data.color)
	vehicleDatas["groupPrefix"] = 0
	vehicleDatas["position"] = toJSON({data.posX, data.posY, data.posZ, data.dimension, data.interior})
	vehicleDatas["parkPosition"] = toJSON({data.posX, data.posY, data.posZ, data.dimension, data.interior})
	vehicleDatas["rotation"] = toJSON({data.rotX, data.rotY, data.rotZ})
	vehicleDatas["fuel"] = getTankSize(data.modelId)
	vehicleDatas["fuelType"] = data.fuelType

	if data.customModel then
		vehicleDatas["customModel"] = data.customModel
	end

	dbInsert("vehicles", vehicleDatas)

	dbQuery(function(qh, client, targetPlayer)
		local result = dbPoll(qh, 0)

		if result then
			if dtype == "carshop" then
				exports.sGui:showInfobox(client, "s", "Sikeres vásárlás! Az autód megtalálod a parkolóban")
			else
				exports.sGui:showInfobox(client, "s", "Sikeres jármű létrehozás! ID: " .. result[1].dbID)
			end
			exports.sItems:giveItem(data.targetPlayer, 1, 1, false, result[1].dbID)
			spawnPlayerVehicles(data.targetPlayer, {result[1]}, true, dtype == "carshop" and true or false)
		end
	end, {client, data.targetPlayer}, connection, "SELECT * FROM vehicles WHERE dbID = LAST_INSERT_ID()")
end

addCommandHandler("delveh", function(client, commandName, vehicleId)
	if exports.sPermission:hasPermission(client, "delveh") then
		local vehicleId = tonumber(vehicleId)

		if not vehicleId then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Jármű ID]", client, 255, 255, 255, true)
		else
			local targetVehicle = findVehicleById(client, vehicleId)

			if not targetVehicle then
				return
			end
			
			if isElement(targetVehicle) then
				triggerClientEvent(root, "disableCoronaSirens", root, vehicleElement)
			end

			for player, data in pairs(createdVehicles) do
				for id, vehicle in pairs(data) do
					if targetVehicle == vehicle then
						table.remove(createdVehicles[player], id)
					end
				end
			end
			local group = getElementData(targetVehicle, "vehicle.group")

			if group == 0 or group == "0" then
				group = false
			end

			dbExec(connection, "DELETE FROM vehicles WHERE dbID = ?", vehicleId)
			exports.sGui:showInfobox(client, "s", "Sikeresen kitörölted a " .. vehicleId .. " id-vel rendelkező járművet!")
			destroyElement(targetVehicle)

			if group then
				exports.sGroups:requestGroupVehicles(group)
			end
		end
	end
end)

function destroyVehicle(vehicleElement, playerElement)
	if isElement(vehicleElement) then
		local vehicleIdentity = getElementData(vehicleElement, "vehicle.dbID")

		if isElement(vehicleElement) then
			triggerClientEvent(root, "disableCoronaSirens", root, vehicleElement)
			destroyElement(vehicleElement)
		end

		for player, data in pairs(createdVehicles) do
			for id, vehicle in pairs(data) do
				if vehicleElement == vehicle then
					table.remove(createdVehicles[player], id)
				end
			end
		end

		dbExec(connection, "DELETE FROM vehicles WHERE dbID = ?", vehicleIdentity)
		exports.sGui:showInfobox(playerElement, "s", "Sikeresen kitörölted a " .. vehicleIdentity .. " id-vel rendelkező járművet!")
	end
end

addCommandHandler("protect", function(client, commandName)
	if (getElementData(client, "loggedIn") or false) then
		local vehicle = getPedOccupiedVehicle(client)

		if vehicle then
			local protected = getElementData(vehicle, "vehicleProtected") or false

			if protected and protected > getRealTime().timestamp then
				protected = protected
			else
				protected = false
			end

			triggerClientEvent(client, "showProtectPrompt", client, vehicle, protected)
		else
			exports.sGui:showInfobox(client, "e", "Nem ülsz járműben.")
		end
	end
end)

addEvent("tryToBuyProtect", true)
addEventHandler("tryToBuyProtect", getRootElement(), function(vehicle)
	if source == client then
		local vehicleId = getElementData(vehicle, "vehicle.dbID") or false

		if vehicleId then
			local currentPremiumPoint = exports.sCore:getPP(client) or 0

			if exports.sCore:takePP(client, 300) then
				local ts = getRealTime().timestamp + 604800

				setElementData(vehicle, "vehicleProtected", ts)
				dbExec(connection, "UPDATE vehicles SET protected = ? WHERE dbID = ?", ts, vehicleId)
				
				local timeFormat = getRealTime(ts)
				local protectDate = string.format("%04d. %02d. %02d. %02d:%02d", timeFormat.year + 1900, timeFormat.month + 1, timeFormat.monthday, timeFormat.hour, timeFormat.minute)
				
				exports.sGui:showInfobox(client, "s", "Sikeresen megvásároltad a protectet a járműre!")
				outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]Protect érvényessége:[color=sightblue] " .. protectDate .. ".", client, 255, 255, 255, true)

			else
				exports.sGui:showInfobox(client, "e", "Nincs elég prémiumpontod!")
			end
		end
	else
        exports.sAnticheat:anticheatBan(client, "AC #56 - sVehicles @sourceS:1519")
	end
end)

function processBatteries()
	local vehicleElements = getElementsByType("vehicle")
	for key, vehicle in pairs(vehicleElements) do
		if not exports.sSpeedo:isVehicleElectric(vehicle) and getVehicleType(vehicle) ~= "Helicopter" then
			local oldRate = getElementData(vehicle, "vehicle.batteryRate") or 0
			if oldRate ~= 0 then
				local rate = oldRate / 6
				local batteryCharge = getElementData(vehicle, "vehicle.batteryCharge") or 2048
				local calculatedCharge = rate + batteryCharge
				if calculatedCharge > 2048 then
					calculatedCharge = 2048
				end
				if calculatedCharge < 0 then
					calculatedCharge = 0
				end
				setElementData(vehicle, "vehicle.batteryCharge", calculatedCharge)

				local vehicleOccupants = getVehicleOccupants(vehicle)

				local maxCharge = getElementData(vehicle, "vehicle.maxBatteryCharge") or 2048
				
				if #vehicleOccupants then

					triggerClientEvent(vehicleOccupants, "gotVehicleBatteryCharge", vehicle, calculatedCharge, maxCharge, 2048, oldRate)
				end
			end
		end
	end
end
setTimer(processBatteries, (1000 * 10), 0)

function findVehicleById(client, vehicleId)
	if vehicleId then
		local vehicleFound = false
		local vehicleElements = getElementsByType("vehicle")

		for key, vehicle in pairs(vehicleElements) do
			if getElementData(vehicle, "vehicle.dbID") == vehicleId then
				vehicleFound = vehicle
			end
		end

		if not vehicleFound and client then
			exports.sGui:showInfobox(client, "e", "Ilyen id-vel jármű nem található!")
		end

		return vehicleFound
	end
end

function getPlayerVehicles(playerElement)
	local playerVehicles = {}
	local vehicleElements = getElementsByType("vehicle")
	for _, vehicleElement in pairs(vehicleElements) do
		if isElement(playerElement) and isElement(vehicleElement) and getElementData(vehicleElement, "vehicle.dbID") and getElementData(vehicleElement, "vehicle.owner") == getElementData(playerElement, "char.ID") then
			table.insert(playerVehicles, vehicleElement)
		end
	end

	return playerVehicles
end

function resetVehicle(vehicle)
	if vehicle then
	    setElementData(vehicle, "vehicle.engine", false)
	    setElementData(vehicle, "vehicle.ignition", false)

	    respawnVehicle(vehicle)
	    fixVehicle(vehicle)
	    setVehicleDamageProof(vehicle, false)

	    local parkPosition = getElementData(vehicle, "vehicle.parkPosition") or false

	    if parkPosition then
	    	setElementPosition(vehicle, parkPosition[1], parkPosition[2], parkPosition[3])
	    	setElementDimension(vehicle, parkPosition[4])
	    	setElementInterior(vehicle, parkPosition[5])
	    end
	end
end

function processLockEffect(vehicle)
	if vehicle then
		local vehicleLightState = getVehicleOverrideLights(vehicle)

		if vehicleLightState == 0 or vehicleLightState == 1 then
			setVehicleOverrideLights(vehicle, 2)
		else
			setVehicleOverrideLights(vehicle, 1)
		end

		setTimer(function(vehicle)
			local vehicleLightState = getVehicleOverrideLights(vehicle)

			if vehicleLightState == 0 or vehicleLightState == 1 then
				setVehicleOverrideLights(vehicle, 2)
			else
          		setVehicleOverrideLights(vehicle, 1)
        	end
		end, 182.857142857, 3, vehicle)
	end
end

function getVehicleKey(client, veh)
  	local jobVeh = false
  	local vehicleId = getElementData(veh, "vehicle.dbID")

  	if jobVeh and jobVeh == veh then
    	return true
  	end

	if not vehicleId then
		return true
	end

	if exports.sItems:playerHasItemWithData(client, 1, vehicleId) then
		return true
	end

	if getElementData(client, "adminDuty") then
		return true
	end

	if exports.sPermission:hasPermission(client, "superUnlock") then
		return true
	end

	if exports.sVehiclerent:getRentedOwner(veh, client) then
		return true
	end

	if exports.sGroups:getPlayerVehiclePermission(client, veh) then
		return true
	end
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

function hex2rgb(hex) 
  hex = hex:gsub("#","") 
  return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6)) 
end 

function dbInsert(tableName, insertValues, callback)
    if tableName and insertValues and type(insertValues) == "table" then
        local columns = {}
        local values = {}

        for column, value in pairs(insertValues) do
            table.insert(columns, "`" .. column .. "`")
            table.insert(values, value)
        end

        local placeholders = ("?, "):rep(#columns):sub(1, -3)
        local query = "INSERT INTO " .. tableName .. " (" .. table.concat(columns, ", ") .. ") VALUES (" .. placeholders .. ")"

        dbQuery(function(qh)
            local _, numRows = dbPoll(qh, 0)
            if numRows > 0 then
                if callback then callback(true) end
            else
                if callback then callback(false) end
            end
        end, {}, connection, query, unpack(values))
    else
        if callback then callback(false) end
    end
end

addEvent("doServerChanges", true)
addEventHandler("doServerChanges", getRootElement(),
	function (vehicle, door, player)
		if isElement(source) and door then
			local doorRatio = getVehicleDoorOpenRatio(vehicle, door)

			if doorRatio <= 0 then
				setVehicleDoorOpenRatio(vehicle, door, 1, 500)

				triggerClientEvent(getElementsByType("player"), "playDoorEffect", source, vehicle, "open")

				local vehModel = getElementModel(vehicle)
				if vehModel == 407 then
					if door == 1 then
						exports.sChat:localAction(player, "felhúzza a rolót.")
					end
				end

			elseif doorRatio > 0 then
				setVehicleDoorOpenRatio(vehicle, door, 0, 250)

				setTimer(triggerClientEvent, 250, 1, getElementsByType("player"), "playDoorEffect", source, vehicle, "close")

				local vehModel = getElementModel(vehicle)
				if vehModel == 407 then
					if door == 1 then
						exports.sChat:localAction(player, "lehúzza a rolót.")
					end
				end
			end

			setPedAnimation(source, "ped", "CAR_open_LHS", 300, false, false, true, false)
		end
	end
)

addEventHandler("onResourceStart", resourceRoot,
	function ()
		for k, v in pairs(getElementsByType("vehicle")) do
			exports.sTuning:makeTuning(v)
		end
	end
)

addCommandHandler("setfueltype", function(sourcePlayer, commandName, targetVehicle, fuelType)
	if exports.sPermission:hasPermission("setfueltype") then
		if not (fuelType or tonumber(fuelType)) or not not (targetVehicle or tonumber(targetVehicle)) then
			outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/"..commandName.." [Autó azonosítója] [Típus (1 - Dízel, 2 - Benzines)]")
			return
		end

		local fuelType = tonumber(fuelType)
		local targetVehicle = findVehicleById(sourcePlayer, targetVehicle)

		if targetVehicle then
			local vehicleFuel = getElementData(vehicle, "vehicle.fuelType")
			--getElementData(vehicle, "vehicle.fuelType") or {1, "petrol", "petrol", 100}
            --setElementData(data[pump].vehicle, "vehicle.fuelType", {qualityLevel, fuelType, data[pump].fuelType, data[pump].fuelAmount})

			local formattedFuelNames = {
				[1] = "diesel",
				[2] = "petrol"
			}

			setElementData(targetVehicle, "vehicle.fuelType", {1, formattedFuelNames[fuelType], formattedFuelNames[fuelType], vehicleFuel[4]})
		end
	end
end)