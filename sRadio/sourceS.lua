local ecuVehicles = {}

addEventHandler("onResourceStart", getRootElement(), function(res)
    local resName = getResourceName(res)

    if res == getThisResource() then
        connection = exports.sConnection:getConnection()
    elseif resName == "sConnection" then
        connection = exports.sConnection:getConnection()
    end
end)

addEvent("requestECUData", true)
addEventHandler("requestECUData", getRootElement(), function()
	local validVehicle = getPedOccupiedVehicle(client)

	if source == validVehicle then
		local ecuTuning = getElementData(source, "performance.ecu") or false

		if (ecuTuning and tonumber(ecuTuning)) == 4 then
			local vehicleEcuData = exports.sVehicles:getVehicleEcuData(source)
			local balanceValue = vehicleEcuData.balanceValue
			local ecuValues = vehicleEcuData.customEcuValues

			ecuVehicles[source] = true
			triggerClientEvent(client, "gotVehicleEcuData", source, balanceValue, ecuValues)
		else
			triggerClientEvent(client, "gotVehicleEcuData", source, false, {})
		end
	end
end)

addEvent("saveEcuData", true)
addEventHandler("saveEcuData", getRootElement(), function(balanceValue, ecuValues)
	local validVehicle = getPedOccupiedVehicle(client)

	if source == validVehicle then
		local ecuTuning = getElementData(source, "performance.ecu") or false

		if (ecuTuning and tonumber(ecuTuning)) == 4 then
			local validEcuValue = 0
			local vehicleEcuData = exports.sVehicles:getVehicleEcuData(source)

			for i = 1, #ecuValues do
				local relativeValue = calculateRelativeValue(ecuValues[i], vehicleEcuData.ecuValues[i])
				validEcuValue = validEcuValue + relativeValue
			end
			
			local averageMultipler = validEcuValue / 6
			exports.sVehicles:saveVehicleEcuData(balanceValue, ecuValues, averageMultipler, client, source)
		end
	end
end)

function calculateRelativeValue(value, base)
    local difference = math.abs(value - base)
    local relativeValue = 1 / (difference + 1)
    return relativeValue
end

addEventHandler("onElementDataChange", getRootElement(), function(dataName, oldValue, newValue)
	if dataName == "performance.ecu" then
		if newValue ~= 4 then
			if ecuVehicles[source] then
				triggerClientEvent(getVehicleOccupants(source), "gotVehicleEcuData", source, false, {})
				exports.sTuning:makeTuning(source)
				ecuVehicles[source] = false
			end
		elseif newValue == 4 then
			local vehicleEcuData = exports.sVehicles:getVehicleEcuData(source)
			local balanceValue = vehicleEcuData.balanceValue
			local ecuValues = vehicleEcuData.customEcuValues

			ecuVehicles[source] = true
			triggerClientEvent(getVehicleOccupants(source), "gotVehicleEcuData", source, balanceValue, ecuValues)
		end
	end
end)

addEvent("requestAirrideData", true)
addEventHandler("requestAirrideData", getRootElement(), 
  function(player)
    if player then
        client = player
    end
    local level = getElementData(source, "airrideBias") or 0
    local bias = getElementData(source, "airrideBias") or 0
    local softness = getElementData(source, "airrideSoftness") or 0
    if getElementData(source, "rideTuning") ~= 5 then
        triggerClientEvent(client, "gotVehicleAirRide", source, false, bias, softness)
    else
        triggerClientEvent(client, "gotVehicleAirRide", source, level, bias, softness)
    end
  end
)

addEvent("saveVehicleAirrideFavorite", true)
addEventHandler("saveVehicleAirrideFavorite", getRootElement(), 
  function(id)
    local level = getElementData(source, "airrideLevel") or 0
    local bias = getElementData(source, "airrideBias") or 0
    local softness = getElementData(source, "airrideSoftness") or 0

    setElementData(source, "vehicle.airRideMemory:" .. id, {level, bias, softness})
  end
)

addEvent("loadVehicleAirrideFavorite", true)
addEventHandler("loadVehicleAirrideFavorite", getRootElement(), 
  function(id, sync)
    local originalLimit = getHandlingProperty(source, "suspensionLowerLimit")
    
    local savedMemory = getElementData(source, "vehicle.airRideMemory:" .. id) or {0, 0, 0}
    local level = savedMemory[1]
    local bias = savedMemory[2]
    local softness = savedMemory[3]

    setElementData(source, "airrideBias", level)

    triggerClientEvent(sync, "airrideSound", source)
    triggerClientEvent(sync, "gotVehicleAirRide", source, level, bias, softness)

    local newLimit = originalLimit + (level) * 0.0175

    setVehicleHandling(source, "suspensionLowerLimit", newLimit)

    local originalLimit = getHandlingProperty(source, "suspensionFrontRearBias")
    local newLimit = (originalLimit + (-bias) * 0.0175)

    if bias == 0 then
      setVehicleHandling(source, "suspensionFrontRearBias", originalLimit)
    else
      setVehicleHandling(source, "suspensionFrontRearBias", newLimit)
    end

    local x, y, z = getElementPosition(source)
    setElementPosition(source, x, y, z + 0.01)
    setElementPosition(source, x, y, z)
  end
)

local customHandling = {}

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

addEvent("setVehicleAirRideLevel", true)
addEventHandler("setVehicleAirRideLevel", getRootElement(),
  function(airrideSettingLevel, sync)
    if source then
      local originalLimit = getHandlingProperty(source, "suspensionLowerLimit")
      local level = airrideSettingLevel or getElementData(source, "airrideLevel") or 2
      local bias = getElementData(source, "airrideBias") or 0
      local softness = getElementData(source, "airrideSoftness") or 0

      setElementData(source, "airrideLevel", level)
      triggerClientEvent(sync, "airrideSound", source)
      if getElementData(source, "rideTuning") ~= 5 then
        triggerClientEvent(sync, "gotVehicleAirRide", source, false, bias, softness)
      else
        triggerClientEvent(sync, "gotVehicleAirRide", source, level, bias, softness)
      end

      local newLimit = originalLimit + (level) * 0.0175

      setVehicleHandling(source, "suspensionLowerLimit", newLimit)

      local x, y, z = getElementPosition(source)
      setElementPosition(source, x, y, z + 0.01)
      setElementPosition(source, x, y, z)
    end
  end
)

addEvent("setVehicleAirRideBias", true)
addEventHandler("setVehicleAirRideBias", getRootElement(),
  function(airrideSettingBias, sync)
    if source then
      local originalLimit = getHandlingProperty(source, "suspensionFrontRearBias")
      local level = getElementData(source, "airrideLevel") or 0
      local bias = airrideSettingBias
      local softness = getElementData(source, "airrideSoftness") or 0

      setElementData(source, "airrideBias", bias)

      triggerClientEvent(sync, "airrideSound", source)
      triggerClientEvent(sync, "gotVehicleAirRide", source, level, bias, softness)

      local newLimit = (originalLimit + (-bias) * 0.0575)

      if bias == 0 then
        setVehicleHandling(source, "suspensionFrontRearBias", originalLimit)
      else
        setVehicleHandling(source, "suspensionFrontRearBias", newLimit)
      end

      local x, y, z = getElementPosition(source)
      setElementPosition(source, x, y, z + 0.01)
      setElementPosition(source, x, y, z)
    end
  end
)

addEvent("setVehicleAirRideSoftness", true)
addEventHandler("setVehicleAirRideSoftness", getRootElement(),
  function(airrideSettingSoftness, sync)
    if source then
      local originalLimit = getHandlingProperty(source, "suspensionForceLevel")
      local level = getElementData(source, "airrideLevel") or 0
      local bias = getElementData(source, "airrideBias")
      local softness = getElementData(source, "airrideSoftness") or 0

      setElementData(source, "airrideSoftness", airrideSettingSoftness)

      triggerClientEvent(sync, "airrideSound", source)
      triggerClientEvent(sync, "gotVehicleAirRide", source, level, bias, airrideSettingSoftness)

      local newLimit = (originalLimit + (-airrideSettingSoftness) * 0.175)

      if airrideSettingSoftness == 0 then
        setVehicleHandling(source, "suspensionForceLevel", originalLimit)
      else
        setVehicleHandling(source, "suspensionForceLevel", newLimit)
      end

      local x, y, z = getElementPosition(source)
      setElementPosition(source, x, y, z + 0.01)
      setElementPosition(source, x, y, z)
    end
  end
)


--[[
addEvent("requestAirrideData", true)
addEventHandler("requestAirrideData", getRootElement(), function()
	local validVehicle = getPedOccupiedVehicle(client)
	
	if validVehicle == source then
		local vehicleId = getElementData(source, "vehicle.dbID") or false
		local airrideState = getElementData(source, "rideTuning") or 0

		if vehicleId then
			if airrideState == 5 then
				local bias = getElementData(source, "airrideBias") or 0
				local level = getElementData(source, "airrideLevel") or 0
				local softness = getElementData(source, "airrideSoftness") or 0
				triggerClientEvent(client, "gotVehicleAirRide", source, level, bias, softness)
			else
				triggerClientEvent(client, "gotVehicleAirRide", source, false, false, false)
			end
		else
			triggerClientEvent(client, "gotVehicleAirRide", source, false, false, false)
		end
	end
end)

local lastAirrideInteract = {}

addEvent("setVehicleAirRideBias", true)
addEventHandler("setVehicleAirRideBias", getRootElement(), function(bias, sync)
	local validVehicle = getPedOccupiedVehicle(client)
	
	if validVehicle == source then
		local vehicleId = getElementData(source, "vehicle.dbID") or false
		local airrideState = getElementData(source, "rideTuning") or 0

		if vehicleId then
			if airrideState == 5 then
				local bias2 = getElementData(source, "airrideBias") or 0
				local level = getElementData(source, "airrideLevel") or 0
				local softness = getElementData(source, "airrideSoftness") or 0
				
				if lastAirrideInteract[client] and (getTickCount() - lastAirrideInteract[client]) < 1000 then
					triggerClientEvent(getVehicleOccupants(source), "gotVehicleAirRide", source, level, bias2, softness)
					return
				end

				lastAirrideInteract[client] = getTickCount()
				
				local centerOfMass = exports.sVehicles:getModelHandlingOverride(getElementModel(source)).centerOfMass

				if not centerOfMass then
					centerOfMass = getModelHandling(getElementModel(source)).centerOfMass
				end

				if centerOfMass then
					centerOfMass[2] = centerOfMass[2] + bias / 10
					
					setVehicleHandling(source, "centerOfMass", centerOfMass)
					setElementData(source, "airrideBias", bias)
					dbExec(connection, "UPDATE vehicles SET airrideDatas = ? WHERE dbID = ?", toJSON({level, bias, softness}), vehicleId)

					if sync then
						triggerClientEvent(sync, "airrideSound", client)
					end

					triggerClientEvent(getVehicleOccupants(source), "gotVehicleAirRide", source, level, bias, softness)
				end
			else
				triggerClientEvent(getVehicleOccupants(source), "gotVehicleAirRide", source, false, false, false)
				setElementData(source, "vehradio.menu", "home")	
			end
		else
			triggerClientEvent(getVehicleOccupants(source), "gotVehicleAirRide", source, false, false, false)
			setElementData(source, "vehradio.menu", "home")	
		end
	end
end)

addEvent("setVehicleAirRideLevel", true)
addEventHandler("setVehicleAirRideLevel", getRootElement(), function(level, sync)
	local validVehicle = getPedOccupiedVehicle(client)
	
	if validVehicle == source then
		local vehicleId = getElementData(source, "vehicle.dbID") or false
		local airrideState = getElementData(source, "rideTuning") or 0

		if vehicleId then
			if airrideState == 5 then
				local bias = getElementData(source, "airrideBias") or 0
				local level2 = getElementData(source, "airrideLevel") or 0
				local softness = getElementData(source, "airrideSoftness") or 0
				
				if lastAirrideInteract[client] and (getTickCount() - lastAirrideInteract[client]) < 1000 then
					triggerClientEvent(getVehicleOccupants(source), "gotVehicleAirRide", source, level2, bias, softness)
					return
				end

				lastAirrideInteract[client] = getTickCount()
				
				local suspensionLowerLimit = exports.sVehicles:getModelHandlingOverride(getElementModel(source)).suspensionLowerLimit

				if not suspensionLowerLimit then
					suspensionLowerLimit = getModelHandling(getElementModel(source)).suspensionLowerLimit
				end

				local suspensionLowerLimit = suspensionLowerLimit + level * 0.015
				setVehicleHandling(source, "suspensionLowerLimit", suspensionLowerLimit)
				setElementData(source, "airrideLevel", level)
				dbExec(connection, "UPDATE vehicles SET airrideDatas = ? WHERE dbID = ?", toJSON({level, bias, softness}), vehicleId)

				if sync then
					triggerClientEvent(sync, "airrideSound", client)
				end

				triggerClientEvent(getVehicleOccupants(source), "gotVehicleAirRide", source, level, bias, softness)
			else
				triggerClientEvent(getVehicleOccupants(source), "gotVehicleAirRide", source, false, false, false)
				setElementData(source, "vehradio.menu", "home")	
			end
		else
			triggerClientEvent(getVehicleOccupants(source), "gotVehicleAirRide", source, false, false, false)
			setElementData(source, "vehradio.menu", "home")	
		end
	end
end)

addEvent("setVehicleAirRideSoftness", true)
addEventHandler("setVehicleAirRideSoftness", getRootElement(), function(softness, sync)
	local validVehicle = getPedOccupiedVehicle(client)
	
	if validVehicle == source then
		local vehicleId = getElementData(source, "vehicle.dbID") or false
		local airrideState = getElementData(source, "rideTuning") or 0

		if vehicleId then
			if airrideState == 5 then
				local bias = getElementData(source, "airrideBias") or 0
				local level = getElementData(source, "airrideLevel") or 0
				local softness2 = getElementData(source, "airrideSoftness") or 0

				if lastAirrideInteract[client] and (getTickCount() - lastAirrideInteract[client]) < 1000 then
					triggerClientEvent(getVehicleOccupants(source), "gotVehicleAirRide", source, level2, bias, softness)
					return
				end

				lastAirrideInteract[client] = getTickCount()

				
			end
		end
	end
end)
]]

addEvent("requestNeonData", true)
addEventHandler("requestNeonData", getRootElement(), function()
	local validVehicle = getPedOccupiedVehicle(client)
	
	if validVehicle == source then
		local neon = getElementData(source, "neon") or ""
		if neon == "custom" then
			local neonData = getElementData(source, "neonData") or {"white", "white"}
			triggerClientEvent(client, "gotVehicleNeon", validVehicle, neon, neonData[1], neonData[2])
		else
			triggerClientEvent(client, "gotVehicleNeon", validVehicle, false)
		end
	end
end)

addEvent("refreshNeonColor", true)
addEventHandler("refreshNeonColor", getRootElement(), function(side, color)
	local validVehicle = getPedOccupiedVehicle(client)
	
	if validVehicle == source then
		local vehicleId = getElementData(source, "vehicle.dbID") or false
		local neon = getElementData(source, "neon") or ""
		local neonData = getElementData(source, "neonData") or {"white", "white"}

		if vehicleId and neon == "custom" then
			if side == "side" then
				if color == "off" then
					setElementData(source, "neonSide", false)
				else
					setElementData(source, "neonSide", color)
				end
				neonData[1] = color
			elseif side == "front" then
				if color == "off" then
					setElementData(source, "neonFront", false)
				else
					setElementData(source, "neonFront", color)
				end
				neonData[2] = color
			end

			setElementData(source, "neonData", neonData)
			dbExec(connection, "UPDATE vehicles SET neonData = ? WHERE dbID = ?", toJSON(neonData), vehicleId)
			triggerClientEvent(getVehicleOccupants(source), "gotVehicleNeon", source, neon, neonData[1], neonData[2])
		end
	end
end)

local validDriveTypes = {
	["awd"] = true,
	["fwd"] = true,
	["rwd"] = true,
}

addEvent("requestDriveTypeData", true)
addEventHandler("requestDriveTypeData", getRootElement(), function()
	local clientVehicle = source

	if clientVehicle then
		local driveType = getElementData(clientVehicle, "driveType") or false
		local customDriveType = getElementData(clientVehicle, "customDriveType") or false

		if driveType == "handling" then
			driveType = getVehicleHandling(clientVehicle).driveType
		end

		if driveType and customDriveType and validDriveTypes[driveType] then
			triggerClientEvent(client, "gotVehicleDriveTypeData", clientVehicle, driveType)
		else
			triggerClientEvent(client, "gotVehicleDriveTypeData", clientVehicle, false)
		end
	end
end)

addEvent("setCurrentVehicleDriveType", true)
addEventHandler("setCurrentVehicleDriveType", getRootElement(), function(type)
	local clientVehicle = getPedOccupiedVehicle(client)

	if clientVehicle and validDriveTypes[type] then
		local vehicleId = getElementData(clientVehicle, "vehicle.dbID") or false

		if vehicleId then
			setVehicleHandling(clientVehicle, "driveType", type)
			setElementData(clientVehicle, "driveType", type)
			dbExec(connection, "UPDATE vehicles SET driveType = ? WHERE dbID = ?", type, vehicleId)
		end
	end
end)

addEvent("requestJourneyData", true)
addEventHandler("requestJourneyData", getRootElement(), function()
	local currentTimeStamp = getRealTime().timestamp
	local vehicleStartTime = getElementData(source, "vehicle.startTime")
	local vehicleStartDistance = getElementData(source, "vehicle.startDistance") or 0
	local vehicleDistance = getElementData(source, "vehicle.distance") or 0

    if vehicleStartTime then
      	triggerClientEvent(client, "gotJourneyData", source, (currentTimeStamp - vehicleStartTime), (vehicleDistance - vehicleStartDistance))
    else
      	triggerClientEvent(client, "gotJourneyData", source, 0, 0)
    end
end)