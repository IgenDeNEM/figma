local connection = false

addEventHandler("onResourceStart", getRootElement(), function(res)
    local resName = getResourceName(res)

    if res == getThisResource() then
        connection = exports.sConnection:getConnection()
    elseif resName == "sConnection" then
        connection = exports.sConnection:getConnection()
    end
end)

local nitroState = {}
local nitroHandling = {}
local lastNitroTick = {}

addCommandHandler("nitro", function(client, commandName)
	local clientVehicle = getPedOccupiedVehicle(client)

	if clientVehicle and getVehicleController(clientVehicle) == client then
		local vehicleNitro = getElementData(clientVehicle, "nitro") or false
		local vehicleNitroDatas = getElementData(clientVehicle, "nitroLevel") or false

		if vehicleNitro and vehicleNitroDatas and vehicleNitroDatas[2] > 0 then
			local now = getTickCount()
			
			if lastNitroTick[client] and now - lastNitroTick[client] < 15000 then
				return
			else
				lastNitroTick[client] = getTickCount()
			end

			if not lastNitroTick[client] then
				lastNitroTick[client] = now
			end

			if not nitroState[clientVehicle] then
				toggleNitro(clientVehicle, true)
			end
		end
	end
end)

function toggleNitro(vehicle, state)
	local vehicleOccupants = getVehicleOccupants(vehicle)
	local vehicleNitroDatas = getElementData(vehicle, "nitroLevel") or false

	if state then
		if vehicleNitroDatas then
			if vehicleNitroDatas[2] > 0 then
				triggerClientEvent(vehicleOccupants, "nosEffectState", vehicle, true, vehicleNitroDatas[1] == 2)
				triggerClientEvent(vehicleOccupants, "gotVehicleNosLevel", vehicle, vehicleNitroDatas[2] - 1, vehicleNitroDatas[1] == 2, true, 2640 * (vehicleNitroDatas[1] == 2 and 1 or 0.6), 10000)

				nitroHandling[vehicle] = {}
				nitroHandling[vehicle].handling = getVehicleHandling(vehicle)
				nitroHandling[vehicle].acceleration = nitroHandling[vehicle].handling.engineAcceleration
				nitroHandling[vehicle].velocity = nitroHandling[vehicle].handling.maxVelocity

				if vehicleNitroDatas[1] == 2 then
					setVehicleHandling(vehicle, "engineAcceleration", nitroHandling[vehicle].acceleration + 20)
					setVehicleHandling(vehicle, "maxVelocity", nitroHandling[vehicle].velocity + 100)
				else
					setVehicleHandling(vehicle, "engineAcceleration", nitroHandling[vehicle].acceleration + 10)
					setVehicleHandling(vehicle, "maxVelocity", nitroHandling[vehicle].velocity + 50)
				end



				nitroState[vehicle] = setTimer(function()
					toggleNitro(vehicle, false)
				end, 3000,1)
			end
		end
	else
		local vehicleId = getElementData(vehicle, "vehicle.dbID") or false
		
		if isTimer(nitroState[vehicle]) then
			killTimer(nitroState[vehicle])
		end
		nitroState[vehicle] = nil
		
		setVehicleHandling(vehicle, "engineAcceleration", nitroHandling[vehicle].acceleration)
		setVehicleHandling(vehicle, "maxVelocity", nitroHandling[vehicle].velocity)

		setElementData(vehicle, "nitroLevel", {vehicleNitroDatas[1], vehicleNitroDatas[2] - 1})
		triggerClientEvent(vehicleOccupants, "nosEffectState", vehicle, false, false)

		if vehicleId then
			dbExec(connection, "UPDATE vehicles SET nitroLevel = ? WHERE dbID = ?", toJSON({vehicleNitroDatas[1], vehicleNitroDatas[2] - 1}), vehicleId)
		end
		
		nitroHandling[vehicle] = nil
	end
end

addEventHandler("onElementDataChange", getRootElement(), function(dataName, oldValue, newValue)
	if getElementType(source) == "vehicle" then
		if dataName == "nitroLevel" and newValue[2] and newValue[2] > 0 then
			local vehicleNitro = getElementData(source, "nitro") or false
			
			if vehicleNitro then
				local vehicleOccupants = getVehicleOccupants(source)
				if not newValue[2] then
					newValue[2] = 0
				end
				triggerClientEvent(vehicleOccupants, "gotVehicleNosLevel", source, newValue[2], newValue[1] == 2, true, 2640 * (newValue[1] == 2 and 1 or 0.6), 10000)
			end
		elseif dataName == "nitro" then
			if newValue then
				local vehicleNitroDatas = getElementData(source, "nitroLevel") or false
				local vehicleOccupants = getVehicleOccupants(source)

				if vehicleNitroDatas then
					if not vehicleNitroDatas[2] then
						vehicleNitroDatas[2] = 0
					end
					triggerClientEvent(vehicleOccupants, "gotVehicleNosLevel", source, vehicleNitroDatas[2], vehicleNitroDatas[1] == 2, true, 2640 * (vehicleNitroDatas[1] == 2 and 1 or 0.6), 10000)
				else
					triggerClientEvent(vehicleOccupants, "gotVehicleNosLevel", source, 0, false)
				end
			end
		end
	end
end)