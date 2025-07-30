local connection = false

addEventHandler("onDatabaseConnected", getRootElement(),
	function (db)
		connection = db
	end
)

addEventHandler("onResourceStart", getResourceRootElement(),
	function ()
		connection = exports.sConnection:getConnection()
	end
)

addEvent("carshopMarkerHit", true)
addEventHandler("carshopMarkerHit", getRootElement(),
	function()
		local vehicleIdCount = {}

		dbQuery(
			function (qh, thePlayer)
				if isElement(thePlayer) then
					local result = dbPoll(qh, 0)

					for i, v in pairs(carshopData) do
						vehicleIdCount[i] = 0
					end
					
					for k, v in pairs(result) do
						if v.modelId == 445 and v.customModel and v.customModel ~= "false" then
							if not vehicleIdCount[v.customModel] then
								vehicleIdCount[v.customModel] = 0
							end
							vehicleIdCount[v.customModel] = vehicleIdCount[v.customModel] + 1
						else
							if not vehicleIdCount[v.modelId] then
								vehicleIdCount[v.modelId] = 0
							end
							vehicleIdCount[v.modelId] = vehicleIdCount[v.modelId] + 1
						end
					end
					triggerClientEvent(thePlayer, "loadTheCarshop", thePlayer, vehicleIdCount)
					triggerClientEvent(thePlayer, "teleportInsideCarshop", thePlayer)

					local dim = 65535 - getElementData(thePlayer, "playerID") + 1

					setElementInterior(thePlayer, 11)
					setElementDimension(thePlayer, dim)
				end
			end, {source},
		connection, "SELECT modelId, customModel FROM vehicles WHERE (groupPrefix = 0 OR groupPrefix IS NULL) AND characterId > 0;")
	end
)

function countVehiclesForGuiShop(player)

	local vehicleIdCount = {}

	dbQuery(
		function (qh, thePlayer)
			if isElement(thePlayer) then
				local result = dbPoll(qh, 0)

				for i, v in pairs(carshopData) do
					vehicleIdCount[i] = 0
				end
				
				for k, v in pairs(result) do
					if v.modelId == 445 and v.customModel and v.customModel ~= "false" then
						if not vehicleIdCount[v.customModel] then
							vehicleIdCount[v.customModel] = 0
						end
						vehicleIdCount[v.customModel] = vehicleIdCount[v.customModel] + 1
					else
						if not vehicleIdCount[v.modelId] then
							vehicleIdCount[v.modelId] = 0
						end
						vehicleIdCount[v.modelId] = vehicleIdCount[v.modelId] + 1
					end
				end
				triggerClientEvent(thePlayer, "gotLimitsForGuiShop", thePlayer, vehicleIdCount)
			end
		end, {player},
	connection, "SELECT modelId, customModel FROM vehicles WHERE (groupPrefix = 0 OR groupPrefix IS NULL) AND characterId > 0;")
end

addEvent("requestLimitsForGuiShop", true)
addEventHandler("requestLimitsForGuiShop", root, function(vehicleType)
	countVehiclesForGuiShop(client)
end)

addEvent("playerExitCarshop", true)
addEventHandler("playerExitCarshop", getRootElement(),
	function()
		triggerClientEvent(client, "playerExitCarshop", client)

		setElementPosition(client, 2132.005859375, -1147.8797607422, 24.438808441162)
		setElementInterior(client, 0)
    	setElementDimension(client, 0)
	end
)
local vehiclePositions = {
	{2161.759765625, -1143.953125, 24.666027069092},
	{2161.7578125, -1148.4287109375, 24.118858337402},
	{2161.759765625, -1152.92578125, 23.788806915283},
	{2161.7587890625, -1157.9716796875, 23.720880508423},
	{2161.7578125, -1163.0673828125, 23.69806098938},
	{2161.7607421875, -1168.1171875, 23.694223403931},
	{2161.7607421875, -1172.966796875, 23.694732666016},
	{2161.7607421875, -1177.696796875, 23.694732666016},
	{2161.759765625, -1182.6669921875, 23.693477630615},
	{2161.759765625, -1187.5166015625, 23.697298049927},
	{2161.759765625, -1192.3671875, 23.703960418701},
	{2161.7490234375, -1197.1962890625, 23.772232055664},

	{2148.0138671875, -1133.830078125, 25.405611038208},
	{2148.01484375, -1138.76171875, 25.245876312256},
	{2148.016796875, -1143.412109375, 24.808980941772},
	{2148.0158203125, -1148.1328125, 24.226438522339},
	{2148.01484375, -1152.9912109375, 23.715579986572},
	{2148.01484375, -1157.4345703125, 23.624418258667},
	{2148.0138671875, -1161.734375, 23.604188919067},
	{2148.0216796875, -1166.3134765625, 23.617109298706},
	{2148.0216796875, -1170.953125, 23.617109298706},
	{2148.0216796875, -1175.5927734375, 23.617109298706},
	{2148.0158203125, -1180.2333984375, 23.596830368042},
	{2148.0158203125, -1184.873046875, 23.596832275391},
	{2148.01484375, -1189.7529296875, 23.612552642822},
	{2148.0138671875, -1194.40625, 23.623517990112},
	{2148.0158203125, -1199.068359375, 23.677993774414},
	{2148.016796875, -1203.7412109375, 23.637157440186},
}

local boatPositions = {
	{728.18560791016, -1649.3654785156, 0.94486737251282}
}

local heliPositions = {
	{1888.8072509766, -2200.6127929688, 16.367897033691}
}

addEvent("tryToBuyCarshopVehicle", true)
addEventHandler("tryToBuyCarshopVehicle", getRootElement(),
	function(modelId, vehColor, fuelType, selectedPayment)

		local vehicleIdCount = {}

		dbQuery(
			function (qh, client, modelId, vehColor, fuelType, selectedPayment)
				if isElement(client) then
					local result = dbPoll(qh, 0)

					for i, v in pairs(carshopData) do
						vehicleIdCount[i] = 0
					end
					
					for k, v in pairs(result) do
						if v.modelId == 445 and v.customModel and v.customModel ~= "false" then
							if not vehicleIdCount[v.customModel] then
								vehicleIdCount[v.customModel] = 0
							end
							vehicleIdCount[v.customModel] = vehicleIdCount[v.customModel] + 1
						else
							if not vehicleIdCount[v.modelId] then
								vehicleIdCount[v.modelId] = 0
							end
							vehicleIdCount[v.modelId] = vehicleIdCount[v.modelId] + 1
						end
					end

					if selectedPayment == "cash" then
						if (carshopData[modelId] and carshopData[modelId].limit ~= -1) or (boatshopData[modelId] and boatshopData[modelId].limit ~= -1) or (helishopData[modelId] and helishopData[modelId].limit ~= -1) then
							
							if carshopData[modelId] then
								limit = carshopData[modelId].limit or 0
							elseif boatshopData[modelId] then
								limit = boatshopData[modelId].limit or 0
							elseif helishopData[modelId] then
								limit = helishopData[modelId].limit or 0
							end

							if (vehicleIdCount[modelId] or 0) >= (limit) then
								triggerClientEvent(client, "carshopBuyResponse", client, false)
								exports.sGui:showInfobox(client, "e", "Ennek a járműnek betelt a limitje!")
								return
							end
						end
					end

					local charID = getElementData(client, "char.ID")

					local carCount = 0

					for k, v in pairs(getElementsByType("vehicle")) do
						if getElementData(v, "vehicle.owner") == charID then
							local group = getElementData(v, "vehicle.group")
							if not group or not exports.sGroups:isGroupValid(group) then
								carCount = carCount + 1
							end
						end
					end

					local slotLimit = getElementData(client, "char.vehiclesSlot")

					if slotLimit < carCount + 1 then
						triggerClientEvent(client, "carshopBuyResponse", client, false)
						exports.sGui:showInfobox(client, "e", "Nincs elég slotod!")
						return
					end

					local customVeh = false
					if not tonumber(modelId) then
						customVeh = modelId
						modelId = 445
					end
					local vehiclePrice = getCarshopPremium(modelId)

					if selectedPayment == "cash" then
						vehiclePrice = getCarshopPrice(modelId)
					end

					local currentBalance = selectedPayment == "cash" and exports.sCore:getMoney(client) or exports.sCore:getPP(client)
					local newBalance = currentBalance

					newBalance = newBalance - vehiclePrice


					if newBalance >= 0 then
						exports.sDashboard:givePlayerAchievement(client, "vehicle")

						triggerClientEvent(client, "carshopBuyResponse", client, true)
						if selectedPayment == "cash" then
							exports.sCore:setMoney(client, newBalance) 
						else
							exports.sCore:setPP(client, newBalance)
						end

						local positionTable = vehiclePositions

						if getVehicleType(modelId) == "Boat" then
							positionTable = boatPositions
						elseif getVehicleType(modelId) == "Helicopter" then
							positionTable = heliPositions
						end
							

						local selectedPosition = math.random(1, #positionTable)
						local vehicleColor = colorTable[vehColor]

						local selectedPosition = math.random(1, #positionTable)
						if selectedPosition <= 12 then
							vehicleRotation = 90
						else
							vehicleRotation = 270
						end
						if fuelType then
							fuelType = "diesel"
						elseif fuelType then
							fuelType = "petrol"
						end

						exports.sVehicles:createPermVehicle({
								modelId = modelId,
								color = {vehicleColor[1] or 255, vehicleColor[2] or 255, vehicleColor[3] or 255, 255, 255, 255, 255, 255, 255},
								targetPlayer = client,
								fuelType = fuelType,
								posX = positionTable[selectedPosition][1],
								posY = positionTable[selectedPosition][2],
								posZ = positionTable[selectedPosition][3],
								rotX = 0,
								rotY = 0,
								rotZ = vehicleRotation,
								interior = 0,
								dimension = 0,
								customModel = customVeh
							}, "carshop")
					else
						triggerClientEvent(client, "carshopBuyResponse", client, false)
						if selectedPayment == "cash" then
							exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
						else
							exports.sGui:showInfobox(client, "e", "Nincs elég PrémiumPontod!")
						end
					end

				end
			end, {client, modelId, vehColor, fuelType, selectedPayment},
		connection, "SELECT modelId, customModel FROM vehicles WHERE (groupPrefix = 0 OR groupPrefix IS NULL) AND characterId > 0;")

	end
)

