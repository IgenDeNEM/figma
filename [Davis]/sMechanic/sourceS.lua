local connection = exports.sConnection:getConnection()

local workshopCache = {}
local collisions = {}

local alignWheelSensors = {}
local alignedWheels = {}

function createCollisionFromWorkshop(workshop)
	local polygonData = workshop[3]
	local points = {}
	
	for _, point in ipairs(polygonData) do
		table.insert(points, point[1])
		table.insert(points, point[2])
	end
	
	local firstPoint = polygonData[1]
	local lastPoint = polygonData[#polygonData]
	if firstPoint[1] ~= lastPoint[1] or firstPoint[2] ~= lastPoint[2] then
		table.insert(points, firstPoint[1])
		table.insert(points, firstPoint[2])
	end
	
	local colPolygon = createColPolygon(unpack(points))
	
	if colPolygon then
		return colPolygon
	end
end


addEventHandler("onResourceStart", resourceRoot, 
function()
	for i = 1, #workshops do
		collisions[i] = createCollisionFromWorkshop(workshops[i])
		
		setElementData(collisions[i], "wsID", i)
	end
end
)

playerWorkshop = {}

addEventHandler("onColShapeHit", root, 
function(hitElement, matchingDimension)
	if hitElement and isElement(source) and matchingDimension and getElementDimension(source) == getElementDimension(hitElement) then
		local wsID = getElementData(source, "wsID")
		local x, y, z = getElementPosition(source)
		if wsID and z < 500 then
			setElementData(hitElement, "playerWorkshop", wsID, false)
			triggerClientEvent(hitElement, "playerWorkshopChange", hitElement, wsID)
		end
	end
end
)

preAlignVehicles = {}

addEvent("placeWheelAlignSensor", true)
addEventHandler("placeWheelAlignSensor", root, 
function(vehicleElement, wheelId)
	if vehicleElement then
		local playerWorkshop = getElementData(client, "playerWorkshop")
		
		if playerWorkshop then
			if not alignWheelSensors[playerWorkshop] then
				alignWheelSensors[playerWorkshop] = {false, false, false, false}
			end
			
			alignWheelSensors[playerWorkshop][wheelId] = true
			
			triggerClientEvent("placeWheelAlignSensor", client, vehicleElement, alignWheelSensors[playerWorkshop])
		end
	end
end
)

addEvent("wheelCalibrationDone", true)
addEventHandler("wheelCalibrationDone", root, 
function(vehicleElement)
	local pull = getElementData(vehicleElement, "vehicle.pulling") or 0
	local deg = pull / 100 * 16 * (1 + pull / 100)
	local deg = math.floor(math.floor(deg * 100) / 100)
	local alignResult = {deg, deg, deg, deg, deg}
	triggerClientEvent("wheelCalibrationDone", client, vehicleElement, {pull * 10, pull * 10, pull * 10, pull * 10, pull * 10})
	preAlignVehicles[vehicleElement] = alignResult
end
)

addEvent("resetVehicleWheelAlign", true)
addEventHandler("resetVehicleWheelAlign", root, 
function()
	local playerWorkshop = getElementData(client, "playerWorkshop")
		
	if playerWorkshop then
		alignWheelSensors[playerWorkshop] = {false, false, false, false}
	end
end
)

addEvent("removeWheelAlignSensor", true)
addEventHandler("removeWheelAlignSensor", root, 
function(vehicleElement, wheelId)
	if vehicleElement then
		local playerWorkshop = getElementData(client, "playerWorkshop")
		
		if playerWorkshop then
			alignWheelSensors[playerWorkshop][wheelId] = false
			
			triggerClientEvent("placeWheelAlignSensor", client, vehicleElement, alignWheelSensors[playerWorkshop])
		end
	end
end
)

vehicleExams = {}

addEvent("vehicleInspectStateChange", true)
addEventHandler("vehicleInspectStateChange", root, 
function(vehicleElement, inspectionState, started, examMode)
	if vehicleElement then
		triggerClientEvent("vehicleInspectStateChange", client, vehicleElement, inspectionState, started, examMode)
		if examMode then
			if not vehicleExams[vehicleElement] then
				triggerClientEvent(client, "mechanicInspectionExam", client)
				vehicleExams[vehicleElement] = "exam"
			end
		end
		if inspectionState then
			if not vehicleExams[vehicleElement] then
				triggerClientEvent(client, "mechanicInspection", client)
				vehicleExams[vehicleElement] = "inspection"
			end
		end
	end
end
)

addEvent("readVehicleErrorCodes", true)
addEventHandler("readVehicleErrorCodes", root, 
    function(vehicleElement)
		local errorCodes = {}
        if vehicleElement then
			local veh = vehicleElement
			local errorCodes = getElementData(veh, "vehicle.errorCodes") or {}
			local tempCodes = {}
			local count = 0
			for k, v in pairs(errorCodes) do
				count = count + 1
				tempCodes[count] = k
			end
			triggerClientEvent(client, "gotVehicleErrorCodes", client, tempCodes)
        else
            local playerVehicle = getPedOccupiedVehicle(client)

			if vehicleExams[playerVehicle] then
                local veh = playerVehicle
                pulling = getElementData(veh, "vehicle.pulling")
				if vehicleExams[playerVehicle] == "exam" then
					isExam = true
				else
					isExam = false
				end
				local veh = playerVehicle
				local errorCodes = getElementData(veh, "vehicle.errorCodes") or {}
				local tempCodes = {}
				local count = 0
				for k, v in pairs(errorCodes) do
					count = count + 1
					tempCodes[count] = k
				end
				local passed = true
				if pulling >= 0.02 then
					passed = false
				end
				if #tempCodes > 0 then
				end
				if passed then
					local vehColors = {getVehicleColor(veh, true)}
					local color = table.concat(vehColors, ',')
					local currentTime = getRealTime().timestamp
					local expireTime = currentTime + 2678400
					local customModel = getElementData(veh, "vehicle.customModel")
					local realName = exports.sVehiclenames:getCustomVehicleName(customModel) or exports.sVehiclenames:getCustomVehicleName(getElementModel(veh))
					exports.sItems:giveItem(client, 288, 1, false, toJSON({model = getElementData(veh, "vehicle.customModel") or getElementModel(veh), colors = color, owner = getElementData(client, "char.name"):gsub("_", " "),
					numberPlate = getVehiclePlateText(veh), isDiesel = getElementData(veh, "dieselFuel") and 1 or 0, driveType = getElementData(veh, "driveType"), expireDate = expireTime / 24 / 60 / 60,
					creationDate = getRealTime().timestamp, engine = getElementData(veh, "performance.engine"), turbo = getElementData(veh, "performance.turbo"), ecu = getElementData(veh, "performance.ecu"),
					transmission = getElementData(veh, "performance.transmission"), suspension = getElementData(veh, "performance.suspension"), brake = getElementData(veh, "performance.brakes"),
					tire = getElementData(veh, "performance.tire"), weightReduction = getElementData(veh, "performance.weightReduction"), rideHeight = getElementData(veh, "rideTuning"),
					paintjob = getElementData(veh, "paintjob"), backfire = getElementData(veh, "backfire"), wheelPaintjob = getElementData(veh, "wheelPaintjob") ~= 0 and 1,
					headlightPaintjob = getElementData(veh, "headlightPaintjob") ~= 0 and 1, lsdDoor = getElementData(veh, "lsdDoor"), nitro = getElementData(veh, "nitro"),
					spinner = getElementData(veh, "spinner") ~= 0, vehicleId = getElementData(veh, "vehicle.dbID")}), realName, getVehiclePlateText(veh))
				end
				triggerClientEvent(client, "gotVehicleErrorCodes", client, tempCodes)
				local fLs = math.floor(100 - getCondition(veh, "vehicle.mechanic.frontLeftSuspension", 0))
				local fRs = math.floor(100 - getCondition(veh, "vehicle.mechanic.frontRightSuspension", 0))
				local rLs = math.floor(100 - getCondition(veh, "vehicle.mechanic.rearLeftSuspension", 0))
				local rRs = math.floor(100 - getCondition(veh, "vehicle.mechanic.rearRightSuspension", 0))

				local fB = math.floor(100 - getCondition(veh, "vehicle.mechanic.frontBrakes", 0))
				local rB = math.floor(100 - getCondition(veh, "vehicle.mechanic.rearBrakes", 0))
				
				local examResult = {fB, rB, fLs, fRs, rB, rRs, 7, 100, 100, 100, true, tempCodes, passed, isExam}

                triggerClientEvent("vehicleInspectStateChange", client, veh, 7, true, examResult)
				local paperData = {}
				paperData[1] = {
					"inspection",
					examResult
				}
				local ws = getElementData(client, "playerWorkshop")
				local mechanicName = getElementData(client, "visibleName"):gsub("_", " ")
				local customerName = false
				local customModel = getElementData(veh, "vehicle.customModel")
				local realName = exports.sVehiclenames:getCustomVehicleName(customModel) or exports.sVehiclenames:getCustomVehicleName(getElementModel(veh))
				local vehicleMake = exports.sVehiclenames:getCustomVehicleManufacturer(customModel) or exports.sVehiclenames:getCustomVehicleManufacturer(getElementModel(veh))
				local vehicleModel = exports.sVehiclenames:getCustomVehicleName(customModel) or exports.sVehiclenames:getCustomVehicleName(getElementModel(veh))
				local plateText = getVehiclePlateText(veh)
				local vehicleOdometer = getElementData(veh, "vehicle.distance")
				local workshop = ws
				local mechanic = mechanicName
				local customer = customerName
				local created = getRealTime().timestamp
				local vehicleMake = vehicleMake
				local vehicleModel = vehicleModel
				local vehiclePlate = plateText
				local vehicleOdometer = vehicleOdometer
				dbQuery(function(qh, veh, player)
					local result, _, lastInsertId = dbPoll(qh, 0)
					exports.sItems:giveItem(player, 439, 1, false, lastInsertId, vehicleModel, getVehiclePlateText(veh))
				end, {veh, client}, connection, "INSERT INTO serviceInvoices (paperData, workshop, mechanic, customer, created, vehicleMake, vehicleModel, vehiclePlate, vehicleOdometer) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
				toJSON(paperData), workshop, mechanic, customer, created, vehicleMake, vehicleModel, vehiclePlate, vehicleOdometer)
				vehicleExams[veh] = nil
            else
				local veh = playerVehicle
				local errorCodes = getElementData(veh, "vehicle.errorCodes") or {}
				local tempCodes = {}
				local count = 0
				for k, v in pairs(errorCodes) do
					count = count + 1
					tempCodes[count] = k
				end
				triggerClientEvent(client, "gotVehicleErrorCodes", client, tempCodes)
			end
        end
    end
)

addEvent("alignWheelOnVehicle", true)
addEventHandler("alignWheelOnVehicle", root, 
function(vehicleElement, wheelId)
	if vehicleElement then
		local playerWorkshop = getElementData(client, "playerWorkshop")
		
		if playerWorkshop then
			if not alignedWheels[playerWorkshop] then
				alignedWheels[playerWorkshop] = {false, false, false, false}
			end
			
			alignedWheels[playerWorkshop][wheelId] = true
			setElementData(vehicleElement, "vehicle.pulling", 0)
			setPedAnimation(client, "BOMBER", "bom_plant_loop", -1, true, false)
			setTimer(
				function (thePlayer)
					if isElement(thePlayer) then
						setElementFrozen(thePlayer, false)
						setPedAnimation(thePlayer, false)
					end
				end,
			5500, 1, client)
			triggerClientEvent("alignWheelOnVehicle", client, vehicleElement, alignedWheels[playerWorkshop])
		end
	end
end
)

addEvent("checkVehiclePart", true)
addEventHandler("checkVehiclePart", root, 
function(vehicleElement, vehiclePart)
	if isElement(vehicleElement) then
		
		if vehiclePart == "frontLeftLight" then
			local lightState = getVehicleLightState(vehicleElement, 0)
			
			triggerClientEvent(client, "gotVehiclePartCondition", client, vehicleElement, vehiclePart, (lightState == 0 and 100 or 0))
		end
		
		if vehiclePart == "frontRightLight" then
			local lightState = getVehicleLightState(vehicleElement, 1)
			
			triggerClientEvent(client, "gotVehiclePartCondition", client, vehicleElement, vehiclePart, (lightState == 0 and 100 or 0))
		end
		
		if vehiclePart == "rearRightLight" then
			local lightState = getVehicleLightState(vehicleElement, 2)
			
			triggerClientEvent(client, "gotVehiclePartCondition", client, vehicleElement, vehiclePart, (lightState == 0 and 100 or 0))
		end
		
		if vehiclePart == "rearLeftLight" then
			local lightState = getVehicleLightState(vehicleElement, 3)
			
			triggerClientEvent(client, "gotVehiclePartCondition", client, vehicleElement, vehiclePart, (lightState == 0 and 100 or 0))
		end
		
		if vehiclePart == "frontTires" then
			local frontLeft, rearLeft, frontRight, rearRight = getVehicleWheelStates(vehicleElement)
			
			local goodWheels = 0
			if frontLeft == 0 then goodWheels = goodWheels + 1 end
			if frontRight == 0 then goodWheels = goodWheels + 1 end


			value = getCondition(vehicleElement, "vehicle.mechanic.frontTires", 0) / 100
			value = 100 / mapValue(value, 1, 0)
			if value <= 0 then
				value = 0.001
			end

			goodWheels = goodWheels / value

			if getElementData(vehicleElement, "frontWinter") then

				triggerClientEvent(client, "gotVehiclePartCondition", client, vehicleElement, vehiclePart, (goodWheels / 2) * (-100))
			else
				triggerClientEvent(client, "gotVehiclePartCondition", client, vehicleElement, vehiclePart, (goodWheels / 2) * 100)
			end
			
		elseif vehiclePart == "rearTires" then
			local frontLeft, rearLeft, frontRight, rearRight = getVehicleWheelStates(vehicleElement)
			
			local goodWheels = 0
			if rearLeft == 0 then goodWheels = goodWheels + 1 end
			if rearRight == 0 then goodWheels = goodWheels + 1 end

			value = getCondition(vehicleElement, "vehicle.mechanic.rearTires", 0) / 100
			value = 100 / mapValue(value, 1, 0)
			if value <= 0 then
				value = 0.001
			end

			goodWheels = goodWheels / value
			
			if getElementData(vehicleElement, "rearWinter") then

				triggerClientEvent(client, "gotVehiclePartCondition", client, vehicleElement, vehiclePart, (goodWheels / 2) * (-100))
			else
				triggerClientEvent(client, "gotVehiclePartCondition", client, vehicleElement, vehiclePart, (goodWheels / 2) * 100)
			end
			
		else
			value = getPart(vehicleElement, vehiclePart)
			triggerClientEvent("gotVehiclePartCondition", vehicleElement, vehicleElement, vehiclePart, value)
		end
	end
end
)

swapList = {}

addEvent("swapVehiclePart", true)
addEventHandler("swapVehiclePart", root, 
function(vehicleElement, vehiclePart, selectedToSwap)
	local ws = workshops[getElementData(client, "playerWorkshop")][#workshops[getElementData(client, "playerWorkshop")] - 1]
	local model = tostring(getElementModel(vehicleElement))
	local partData = partBackwards[selectedToSwap]
	if partData then
		local type = partData[4]
		if partStock[ws][model][vehiclePart] and partStock[ws][model][vehiclePart][type] and partStock[ws][model][vehiclePart][type][2] - 1 < 0 then
			exports.sGui:showInfobox(client, "e", "Nincs ebből az alkatrészből raktáron!")
			return
		end
	else
		exports.sGui:showInfobox(client, "e", "Nincs ebből az alkatrészből raktáron!")
		return
	end
	if isElement(vehicleElement) then
		if not swapList[client] then
			swapList[client] = {}
		end
		table.insert(swapList[client], {vehicleElement, vehiclePart, selectedToSwap})
		triggerClientEvent(client, "gotVehPartSwapped", client, vehicleElement, vehiclePart, selectedToSwap)
	end
end
)

addEvent("mechanicOfferResponse", true)
function mechanicOfferResponse(accepted, offerTotal)
	if accepted then
		if exports.sCore:getMoney(client) > offerTotal then
			triggerClientEvent("gotVehicleRepairJob", client, offerCache[client][1],  offerCache[client][2])
			
			for k, v in pairs(offerCache[client][2]) do
				if v[1] == "immaterial" then
					getPart(offerCache[client][1], v[2], true, true)
				end
			end
		else
			exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
		end
	else
		if offerCache[client] then
			if isElement(offerCache[client][6]) then
				offerCache[offerCache[client][6]] = nil
			end
			if offerCache[client] and offerCache[client][5] then
				if isElement(offerCache[client][5]) then
					offerCache[offerCache[client][5]] = nil
				end
			end
		end
	end
end
addEventHandler("mechanicOfferResponse", root, mechanicOfferResponse)

addEvent("tryToRepairPart", true)
function tryToRepairPart(closestVeh, hoveredPart)
	triggerClientEvent(client, "repairingPart", client, closestVeh, hoveredPart)
end
addEventHandler("tryToRepairPart", root, tryToRepairPart)

addEvent("syncSpectatorState", true)
function syncSpectatorState(veh, name, state, screw, arg)
	triggerClientEvent("syncSpectatorState", client, veh, name, state, screw, arg)
end
addEventHandler("syncSpectatorState", root, syncSpectatorState)

addEvent("syncSpectatorScrews", true)
function syncSpectatorScrews(s1, s2)
	triggerClientEvent("syncSpectatorScrews", client, s1, s2)
end
addEventHandler("syncSpectatorScrews", root, syncSpectatorScrews)

addEvent("impactGunState", true)
function impactGunState(click, deg)
	triggerClientEvent("impactGunState", client, click, deg)
end
addEventHandler("impactGunState", root, impactGunState)

addEvent("setWheelOffState", true)
function setWheelOffState(veh, wheel, state)
	triggerClientEvent("setWheelOffState", client, veh, wheel, state)
end
addEventHandler("setWheelOffState", root, setWheelOffState)

offerCache = {}

addEvent("tryToSendMechanicOffer", true)
addEventHandler("tryToSendMechanicOffer", root, 
function(clickedElement, closestVeh, immaterialsSelected, selectedPriceMargin, selectedWage)
	if isElement(clickedElement) then
		local partCache = {}
		if not swapList[client] then
			swapList[client] = {}
		end
		for k, v in pairs(immaterialsSelected) do
			if v then
				table.insert(partCache, {"immaterial", k})
			end
		end
		for k, v in pairs(swapList[client]) do
			table.insert(partCache, {"part", v[3], v[2]})
		end
		local offerDatas = {closestVeh, partCache, basePriceMargins[selectedPriceMargin], baseWages[selectedWage], clickedElement, client}
		if offerDatas then
			offerCache[client] = offerDatas
			offerCache[clickedElement] = offerDatas
			triggerClientEvent(clickedElement, "gotMechanicOffer", clickedElement, offerDatas)
		end
	end
end
)

function mapValue(value, min, max)
	return ((value - min) / (max - min)) * 100
end
function getPart(veh, part, repair, immaterial, quality)
	local value = 100
	if immaterial then
		for k, v in pairs(immaterials) do
			if k == part then
				local player = offerCache[client][5]
				local partPrice = (partPrices[v[2]] or 0)
				local selectedPriceMargin = offerCache[client][3] or 0
				local selectedWage = offerCache[client][4] or 0

				local price = v[2] + selectedWage * v[3]
				exports.sCore:takeMoney(player, price)
				exports.sGui:showInfobox(player, "i", "Levonásra került az autószerelés ára. (" .. exports.sGui:thousandsStepper(price) .. " $)")
				if k == 4 then
					local vehicleFuel = getElementData(veh, "vehicle.fuel") or 0
					local tankSize = exports.sVehicles:getTankSize(getElementModel(veh))
					if vehicleFuel + 5 <= tankSize then
						setElementData(veh, "vehicle.fuel", vehicleFuel + 5)
					else
						setElementData(veh, "vehicle.fuel", vehicleFuel + (tankSize - vehicleFuel))
					end
				end
				if k == 5 then
					setElementData(veh, "vehradio.broken", false)
				end

				local ws = workshops[getElementData(client, "playerWorkshop")][#workshops[getElementData(client, "playerWorkshop")] - 1]
				-- Frakció pénz
				exports.sGroups:addGroupBalance(ws, client, tonumber(price))
			end
			
		end
	else
		for k, v in pairs(listOfCarParts) do
			if v == part then
				if k <= 7 then
					value = getVehiclePanelState(veh, k - 1)
					value = mapValue(value, 3, 0)
					if repair then
						setVehiclePanelState(veh, k - 1, 0)
					end
				elseif k > 7 and k <= 13 then
					value = getVehicleDoorState(veh, k - 8)
					value = mapValue(value, 4, 0)
					if repair then
						setVehicleDoorState(veh, k - 8, 0)
					end
				elseif k > 13 and k <= 15 then
					local fl, rl, fr, rr = getVehicleWheelStates(veh)
					if (fl ~= 0 or fr ~= 0) and k == 14 then
						value = 0
					end
					if (rl ~= 0 or rr ~= 0) and k == 15 then
						value = 0
					end

					if repair then
						local winter = false
						for k, v in pairs(offerCache[client][2]) do
							local pb = partBackwards[v[2]]
							if pb then
								if pb[3] and pb[3] == "frontWinterTires" or pb[3] == "rearWinterTires" then
									if pb[3] and pb[3] == "frontWinterTires" then
										setElementData(veh, "frontWinter", true)
									end
									if pb[3] and pb[3] == "rearWinterTires" then
										setElementData(veh, "rearWinter", true)
									end
								end
								if pb[3] and pb[3] == "frontTires" then
									setElementData(veh, "frontWinter", false)
								end
								if pb[3] and pb[3] == "rearTires" then
									setElementData(veh, "rearWinter", false)
								end
							end
						end
						if getElementData(veh, "rearWinter") and getElementData(veh, "frontWinter") then
							setElementData(veh, "winterTires", true)
						else
							setElementData(veh, "winterTires", false)
						end

						if k == 14 then
							setVehicleWheelStates(veh, 0, rl, 0, rr)
						end
						if k == 15 then
							setVehicleWheelStates(veh, fl, 0, fr, 0)
						end
						exports.sTuning:makeTuning(veh)
					end
				elseif k > 15 and k <= 19 then
					value = getVehicleLightState(veh, k - 16)
					value = mapValue(value, 1, 0)
					if repair then
						setVehicleLightState(veh, k - 16, 0)
					end
				elseif k == 20 then
					value = math.floor(getElementData(veh, "vehicle.oil")) / 10
					if repair then
						setElementData(veh, "vehicle.oil", 1000)
					end
				elseif k == 22 then
					value = getCondition(veh, "vehicle.mechanic.engineGeneralKit", 0) / 100
					value = mapValue(value, 1, 0)
					if repair then
						setElementData(veh, "vehicle.oil", 1000)
						setElementData(veh, "vehicle.mechanic.engineGeneralKit", {quality, 0})
					end
					if repair then
						setElementHealth(veh, 1000)
					end
				elseif k == 21 then
					value = getElementHealth(veh) / 1000
					value = mapValue(value, 0.32, 1)
					if repair then
						setElementHealth(veh, 1000)
					end
				elseif k == 23 then
					value = getCondition(veh, "vehicle.mechanic.engineTimingKit", 0) / 100
					value = mapValue(value, 1, 0)
					if repair then
						setElementData(veh, "vehicle.mechanic.engineTimingKit", {quality, 0})
					end
				elseif k == 24 then
					-- battery
					local isVehEV = evVehicles[getElementData(veh, "vehicle.customModel")] and true or false
					if isVehEV then
						value = getElementHealth(veh) / 1000
						value = mapValue(value, 0.32, 1)
						if repair then
							setElementHealth(veh, 1000)
							setElementData(veh, "vehicle.maxBatteryCharge", 2048)
							setElementData(veh, "vehicle.batteryCharge", 2048)
						end
					else
						value = getElementData(veh, "vehicle.maxBatteryCharge") / 2048
						value = mapValue(value, 0, 1)
						if repair then
							setElementData(veh, "vehicle.maxBatteryCharge", 2048)
							setElementData(veh, "vehicle.batteryCharge", 2048)
						end
					end
				elseif k == 25 then
					value = getCondition(veh, "vehicle.mechanic.fuelRepairKit", 0) / 100
					value = mapValue(value, 1, 0)
					if repair then
						setElementData(veh, "vehicle.fueltype", nil)
					end
					-- fuelrepair
				elseif k == 26 then
					value = getCondition(veh, "vehicle.mechanic.frontBrakes", 0) / 100
					value = mapValue(value, 1, 0)
					-- front brakes
				elseif k == 27 then
					value = getCondition(veh, "vehicle.mechanic.rearBrakes", 0) / 100
					value = mapValue(value, 1, 0)
					-- rear brakes
				elseif k == 28 then
					value = getCondition(veh, "vehicle.mechanic.frontLeftSuspension", 0) / 100
					value = mapValue(value, 1, 0)
					-- bal első felfüggesztés
				elseif k == 29 then
					value = getCondition(veh, "vehicle.mechanic.frontRightSuspension", 0) / 100
					value = mapValue(value, 1, 0)
					-- jobb első felfüggesztés
				elseif k == 30 then
					value = getCondition(veh, "vehicle.mechanic.rearLeftSuspension", 0) / 100
					value = mapValue(value, 1, 0)
					-- bal hátsó felfüggesztés
				elseif k == 31 then
					-- jobb hátsó felfüggesztés
					value = getCondition(veh, "vehicle.mechanic.rearRightSuspension", 0) / 100
					value = mapValue(value, 1, 0)
				end
			end
			if repair then
				setElementData(veh, "vehicle.mechanic." .. part, {quality, 0})
			end
		end
		if value < 0 then
			value = 0
		end
		return value
	end
end

function getCondition(source, key, default)
    local data = getElementData(source, key)
    if type(data) == "table" and data[2] then
        return data[2]
    end
    return default
end

workPerf = {}

addEvent("checkMechanicStats", true)
function checkMechanicStats()
	if not workPerf[client] then
		workPerf[client] = {0, 0, 0}
	end
	local totalPrice = workPerf[client][1] or 0
	local partPrice = workPerf[client][2] or 0
	local profit = totalPrice - partPrice
	local wage = workPerf[client][3] or 0
	exports.sGui:showInfobox(client, "i", "Bevétel: " .. exports.sGui:thousandsStepper(totalPrice) .. " $")
	exports.sGui:showInfobox(client, "i", "Anyagköltség: " .. exports.sGui:thousandsStepper(partPrice) .. " $")
	exports.sGui:showInfobox(client, "i", "Profit: " .. exports.sGui:thousandsStepper(profit) .. " $")
	exports.sGui:showInfobox(client, "i", "Normaidő: " .. wage .. " h")
end
addEventHandler("checkMechanicStats", root, checkMechanicStats)

addEvent("createMechanicStockReport", true)
function createMechanicStockReport()

end
addEventHandler("createMechanicStockReport", root, createMechanicStockReport)

addEvent("createMechanicCheckout", true)
function createMechanicCheckout()
	if not workPerf[client] then
		workPerf[client] = {0, 0, 0}
	end
	local totalPrice = workPerf[client][1] or 0
	local partPrice = workPerf[client][2] or 0
	local profit = totalPrice - partPrice
	local wage = workPerf[client][3] or 0
	local mechanic = getElementData(client, "visibleName"):gsub("_", " ")
	local workData = {getRealTime().timestamp, getRealTime().timestamp, {mechanic, totalPrice, partPrice, wage}}
	local paperData = {}
	paperData[1] = {
		"checkout",
		workData
	}
	local ws = workshops[getElementData(client, "playerWorkshop")][#workshops[getElementData(client, "playerWorkshop")] - 1]
	dbQuery(function(qh, player)
		local result, _, lastInsertId = dbPoll(qh, 0)
		exports.sItems:giveItem(player, 439, 1, false, lastInsertId, "Kasszazárás", "")
	end, {client}, connection, "INSERT INTO serviceInvoices (paperData, workshop, mechanic, customer, created, vehicleMake, vehicleModel, vehiclePlate, vehicleOdometer) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
	toJSON(paperData), getElementData(client, "playerWorkshop"), mechanic, "NULL", getRealTime().timestamp, "vehicleMake", 2, "vehiclePlate", 2)
	exports.sGui:showInfobox(client, "i", "A kasszazárási papírt az inventorydban találod!")
end
addEventHandler("createMechanicCheckout", root, createMechanicCheckout)

addEvent("finalRepairPart", true)
function finalRepairPart(veh, part)
	for k, v in pairs(offerCache[client][2]) do
		if v[3] == part then
			offerCache[client][2][k][4] = true
			local player = offerCache[client][5]
			local partPrice = (partPrices[v[2]] or 0)
			local selectedPriceMargin = offerCache[client][3] or 0
			local selectedWage = offerCache[client][4] or 0
			
			local price = math.ceil(selectedWage * partTypes[v[3]].wage + ((selectedPriceMargin / 100) + 1) * partPrice)
			exports.sCore:takeMoney(player, price)
			exports.sGui:showInfobox(player, "i", "Levonásra került az autószerelés ára. (" .. exports.sGui:thousandsStepper(price) .. " $)")
			if not workPerf[client] then
				workPerf[client] = {0, 0, 0}
			end
			workPerf[client][1] = workPerf[client][1] + price
			workPerf[client][2] = workPerf[client][2] + partPrice
			workPerf[client][3] = workPerf[client][3] + partTypes[v[3]].wage
			local ws = workshops[getElementData(client, "playerWorkshop")][#workshops[getElementData(client, "playerWorkshop")] - 1]
			local model = tostring(getElementModel(veh))
			local foundQuality = 0
			for key, value in pairs(partStock[ws][model][part]) do
				if value[1] == v[2] then
					partStock[ws][model][part][key][2] = partStock[ws][model][part][key][2] - 1
					break
				end
				foundQuality = foundQuality + 1
			end

			-- Frakció pénz
			exports.sGroups:addGroupBalance(ws, client, tonumber(price))
			getPart(veh, part, true, false, foundQuality)
			break
		end
	end
	triggerClientEvent("gotVehicleRepairJob", client, veh, offerCache[client][2])
	triggerClientEvent("gotVehPartSwapped", client, veh, part)
end
addEventHandler("finalRepairPart", root, finalRepairPart)

addEvent("tryToEndRepairJob", true)
function tryToEndRepairJob(veh)
	local ws = getElementData(client, "playerWorkshop")
	local mechanicName = getElementData(client, "visibleName"):gsub("_", " ")
	local customerName = getElementData(offerCache[client][5], "visibleName"):gsub("_", " ")
	local customModel = getElementData(veh, "vehicle.customModel")
	local realName = exports.sVehiclenames:getCustomVehicleName(customModel) or exports.sVehiclenames:getCustomVehicleName(getElementModel(veh))
	local vehicleMake = exports.sVehiclenames:getCustomVehicleManufacturer(customModel) or exports.sVehiclenames:getCustomVehicleManufacturer(getElementModel(veh))
	local vehicleModel = exports.sVehiclenames:getCustomVehicleName(customModel) or exports.sVehiclenames:getCustomVehicleName(getElementModel(veh))
	local plateText = getVehiclePlateText(veh)
	local vehicleOdometer = getElementData(veh, "vehicle.distance")
	local paperData = {}
	local dataList = {}
	local allSum = 0
	local allPrice = 0
	for k, v in pairs(offerCache[client][2]) do
		local type = v[3]
		local product = v[2]
		if product and partBackwards[product] and partBackwards[product][4] then
			local selectedPriceMargin = offerCache[client][3] or 0
			local manufacturer = partBackwards[product][4]
			local partPrice = (partPrices[product] or 0)
			local selectedWage = offerCache[client][4] or 0
			local price = ((selectedPriceMargin / 100) + 1) * partPrice
			table.insert(dataList, {type, product, manufacturer, math.ceil(price)})
			allSum = allSum + selectedWage * partTypes[type].wage
			allPrice = allPrice + math.ceil(price)
		end
	end
	if allPrice ~= 0 then
		paperData[1] = {
			"invoice",
			{
				list = dataList,
				sum = {allSum, allSum + allPrice}
			},
		}
		if preAlignVehicles[veh] then
			paperData[2] = {
				"alignment",
				{
					preAlignVehicles[veh],
					{0, 0, 0, 0, 0},
				}
			}
			preAlignVehicles[veh] = nil
		end
	else
		if preAlignVehicles[veh] then
			paperData[1] = {
				"alignment",
				{
					preAlignVehicles[veh],
					{0, 0, 0, 0, 0},
				}
			}
			preAlignVehicles[veh] = nil
		end
	end
	local workshop = ws
	local mechanic = mechanicName
	local customer = customerName
	local created = getRealTime().timestamp
	local vehicleMake = vehicleMake
	local vehicleModel = vehicleModel
	local vehiclePlate = plateText
	local vehicleOdometer = vehicleOdometer

	local customModel = getElementData(veh, "vehicle.customModel")
	local realName = exports.sVehiclenames:getCustomVehicleName(customModel) or exports.sVehiclenames:getCustomVehicleName(getElementModel(veh))
	local vehicleMake = exports.sVehiclenames:getCustomVehicleManufacturer(customModel) or exports.sVehiclenames:getCustomVehicleManufacturer(getElementModel(veh))
	local vehicleModel = exports.sVehiclenames:getCustomVehicleName(customModel) or exports.sVehiclenames:getCustomVehicleName(getElementModel(veh))

	dbQuery(function(qh, veh, player)
		local result, _, lastInsertId = dbPoll(qh, 0)
		if next(paperData) then
			exports.sItems:giveItem(player, 439, 1, false, lastInsertId, vehicleModel, getVehiclePlateText(veh))
		end
	end, {veh, client}, connection, "INSERT INTO serviceInvoices (paperData, workshop, mechanic, customer, created, vehicleMake, vehicleModel, vehiclePlate, vehicleOdometer) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
	toJSON(paperData), workshop, mechanic, customer, created, vehicleMake, vehicleModel, vehiclePlate, vehicleOdometer)

	triggerClientEvent("gotVehicleRepairJob", client, veh)
	swapList[client] = nil
	offerCache[offerCache[client][5]] = nil
	offerCache[client] = nil
	exports.sGui:showInfobox(client, "s", "Befejezted a szerelést!")
	exports.sGui:showInfobox(client, "i", "A számlát az inventorydban találod!")
	local currentWorkshop = getElementData(client, "playerWorkshop")
	local px, py = getElementPosition(client)
	for i = 1, #workshops[currentWorkshop][6] do
		if workshops[currentWorkshop][6][i][4] then
			local x, y = workshops[currentWorkshop][6][i][1], workshops[currentWorkshop][6][i][2]
			local d = getDistanceBetweenPoints2D(x, y, px, py)
			if d < 3 then
				found = i
				break
			end
		end
	end
	if found then
		triggerClientEvent("krutonPrint", client, found, 1)
	end
end
addEventHandler("tryToEndRepairJob", root, tryToEndRepairJob)

addEventHandler("onColShapeLeave", root, 
function(leaveElement, matchingDimension)
	if leaveElement and matchingDimension then
		local wsID = getElementData(source, "wsID")
		
		if wsID then
			removeElementData(leaveElement, "playerWorkshop")
			triggerClientEvent(leaveElement, "playerWorkshopChange", leaveElement, false)
		end
	end
end
)

mechanicStock = {
	"APMS",
	"FIX",
	"BMS",
	"RING"
}

liftObjects = {}

function loadLifts()
	for k, v in pairs(lifts) do
		liftObjects[k] = {}
		local x, y, z, rz = v[1], v[2], v[3], v[4]
		liftObjects[k][1] = createObject(1278, x, y, z, 0, 0, rz)
		liftObjects[k][2] = createObject(1279, x, y, z, 0, 0, rz)
		liftObjects[k][3] = createColSphere(x, y, z + 2, 2)
		local colx, coly, colz = getPositionFromElementOffset(liftObjects[k][1], 3, 0, 1)
		liftObjects[k][4] = createColSphere(colx, coly, colz, 0.8)
		setElementData(liftObjects[k][4], "mechanicLift", k)
	end
end
addEventHandler("onResourceStart", resourceRoot, loadLifts)

addEvent("requestWorkshopCache", true)
function requestWorkshopCache(ws)
	local cache = offerCache[client] or {}
	triggerClientEvent(client, "gotRepairJobCache", client, ws, {cache})
end
addEventHandler("requestWorkshopCache", root, requestWorkshopCache)

partStock = {}

local file = fileOpen("stock.dat")
local content = fileRead(file, fileGetSize(file))
partStock = fromJSON(content)
fileClose(file)

-- > Alap stock létrehozásához
function createStockDefault()
	for _, i in pairs(mechanicStock) do
		if not partStock[i] then
			partStock[i] = {}
		end
		for _, vehId in pairs(vehicleIds) do
			partStock[i][vehId] = {}
			for k, v in pairs(perVehicleParts[vehId]) do
				if not partStock[i][vehId][k] then
					partStock[i][vehId][k] = {}
				end
				for keys, values in pairs(partTypes) do
					for ke, val in pairs(values.manufacturers) do
						if not partStock[i][vehId][keys] then
							partStock[i][vehId][keys] = {}
						end
						if not partStock[i][vehId][keys][val[1]] then
							partStock[i][vehId][keys][val[1]] = {}
						end
						if vehId == "model_s" or vehId == "model_y" or vehId == "leaf" then
							if keys == "engineGeneralKit" or keys == "oilChangeKit" or keys == "engineRepairKit" or keys == "engineTimingKit" or keys == "fuelRepairKit" then
								partStock[i][vehId][keys][val[1]] = {perVehicleParts[vehId][keys][val[1]], 0, 0, 0, 0, 0, 0}
							else
								partStock[i][vehId][keys][val[1]] = {perVehicleParts[vehId][keys][val[1]], 100, 0, 0, 0, 0, 0}
							end
						else
							partStock[i][vehId][keys][val[1]] = {perVehicleParts[vehId][keys][val[1]], 100, 0, 0, 0, 0, 0}
						end
					end
				end
			end
		end
	end
end
setTimer(function()
	--createStockDefault()
end, 5000, 1)

addEvent("requestMechanicLifts", true)
function requestMechanicLifts()
	triggerLatentClientEvent(client, "gotMechanicLifts", client, liftObjects)
end
addEventHandler("requestMechanicLifts", root, requestMechanicLifts)

function liftColHit(hitElement, matchDim)
	if hitElement and matchDim and getElementType(hitElement) == "player" and isElement(source) then
		local parentLift = getElementData(source, "mechanicLift")
		if parentLift then
			if lifts[parentLift] then
				if exports.sGroups:getPlayerPermission(hitElement, "vehicleExam") then
					triggerClientEvent(hitElement, "showLiftGui", hitElement, parentLift)
				end
			end
		end
	end
end
addEventHandler("onColShapeHit", root, liftColHit)

function liftColLeave(hitElement, matchDim)
	if hitElement and matchDim and getElementType(hitElement) == "player" then
		local parentLift = getElementData(source, "mechanicLift")
		if parentLift then
			if lifts[parentLift] then
				local group = lifts[parentLift][5]
				if exports.sGroups:getPlayerPermission(hitElement, "vehicleExam") then
					triggerClientEvent(hitElement, "hideLiftGui", hitElement)
				end
			end
		end
	end
end
addEventHandler("onColShapeLeave", root, liftColLeave)

addEvent("startCarLiftUp", true)
function startCarLiftUp(liftId)
	local colShape = liftObjects[liftId][3]
	local vehiclesTable = getElementsWithinColShape(colShape, "vehicle")
	local vehicleFound = false
	local multipleFound = false
	
	for i = 1, #vehiclesTable do
		local vehicleElement = vehiclesTable[i]
		
		if isElement(vehicleElement) and getElementDimension(vehicleElement) == getElementDimension(colShape) then
			if vehicleFound then
				multipleFound = true
				break
			else
				vehicleFound = vehicleElement
			end
		end
	end
	if multipleFound then
		exports.sGui:showInfobox(client, "e", "Egyszerre csak egy járművet bír el a lift!")
		return
	end
	if isElement(vehicleFound) then
		setElementFrozen(vehicleFound, true)
		setElementData(vehicleFound, "vehicle.handbrake", true)
		attachRotationAdjusted(vehicleFound, liftObjects[liftId][2])
	end
	setPedAnimation(client, "CASINO", "SLOT_PLYR", -1, false, false, false, false, 250, true)
	triggerClientEvent("toggleLiftState", client, liftId, true)
	local x, y, z = getElementPosition(liftObjects[liftId][2])
	moveObject(liftObjects[liftId][2], ((lifts[liftId][3] + 2.5 - z) * (4 * 1000)), x, y, (lifts[liftId][3]) + 2.5, 0, 0, 0, "Linear")
	
	if not isTimer(stopLiftTimers[liftId]) then
		if ((lifts[liftId][3] + 2.5 - z) * (4 * 1000)) > 0 then
			stopLiftTimers[liftId] = setTimer(stopGarageCarLift, ((lifts[liftId][3] + 2.5 - z) * (4 * 1000)), 1, liftId)
		end
	end
end
addEventHandler("startCarLiftUp", root, startCarLiftUp)

stopLiftTimers = {}

addEvent("startCarLiftDown", true)
function startCarLiftDown(liftId)
	local x, y, z = getElementPosition(liftObjects[liftId][2])
	if ((z - (lifts[liftId][3])) * (4 * 1000)) > 0 then
		triggerClientEvent("toggleLiftState", client, liftId, true)
		moveObject(liftObjects[liftId][2], ((z - (lifts[liftId][3])) * (4 * 1000)), x, y, (lifts[liftId][3]), 0, 0, 0, "Linear")
		
		local colShape = liftObjects[liftId][3]
		local vehiclesTable = getElementsWithinColShape(colShape, "vehicle")
		local vehicleFound = false
		local multipleFound = false
		
		for i = 1, #vehiclesTable do
			local vehicleElement = vehiclesTable[i]
			
			if isElement(vehicleElement) and getElementDimension(vehicleElement) == getElementDimension(colShape) then
				if vehicleFound then
					multipleFound = true
					break
				else
					vehicleFound = vehicleElement
				end
			end
		end
		if multipleFound then
			exports.sGui:showInfobox(client, "e", "Egyszerre csak egy járművet bír el a lift!")
			return
		end
		if isElement(vehicleFound) then
			setElementFrozen(vehicleFound, true)
			setElementData(vehicleFound, "vehicle.handbrake", true)
			attachRotationAdjusted(vehicleFound, liftObjects[liftId][2])
		end
		if isTimer(stopLiftTimers[liftId]) then
			killTimer(stopLiftTimers[liftId])
		end
		if not isTimer(stopLiftTimers[liftId]) then
			if ((z - (lifts[liftId][3])) * (4 * 1000)) > 0 then
				stopLiftTimers[liftId] = setTimer(stopGarageCarLift, ((z - (lifts[liftId][3])) * (4 * 1000)), 1, liftId)
			end
		end
		setPedAnimation(client, "CASINO", "SLOT_PLYR", -1, false, false, false, false, 250, true)
	end
end
addEventHandler("startCarLiftDown", root, startCarLiftDown)

addEvent("stopCarLift", true)
function stopCarLift(liftId)
	if isTimer(stopLiftTimers[liftId]) then
		killTimer(stopLiftTimers[liftId])
	end
	triggerClientEvent("toggleLiftState", client, liftId, false)
	stopObject(liftObjects[liftId][2])
	stopGarageCarLift(liftId)
end
addEventHandler("stopCarLift", root, stopCarLift)

function stopGarageCarLift(liftId)
	local runwayColShape = liftObjects[liftId][3]
	local runway = liftObjects[liftId][2]
	local vehiclesTable = getAttachedElements(runway)
	stopObject(runway)
	
	for i = 1, #vehiclesTable do
		if getElementType(vehiclesTable[i]) == "vehicle" then
			detachElements(vehiclesTable[i], runway)
		end
	end
	triggerClientEvent("toggleLiftState", runway, liftId, false)
end

addEvent("requestMechanicPartStock", true)
function requestMechanicPartStock(model, part)
	local ws = workshops[getElementData(client, "playerWorkshop")][#workshops[getElementData(client, "playerWorkshop")] - 1]
	local model = tostring(model)
	local stock = partStock[ws][model][part]
	local stockCache = {}
	for k, v in pairs(stock) do
		if v[3] == 0 and not ((string.find(part, "engine") or part == "oilChangeKit" or part == "fuelRepairKit") and (model == "model_s" or model == "model_y" or model == "leaf")) then
			stock[k][3] = math.random(100, 1000)
		end
		table.insert(stockCache, v)
	end
	triggerClientEvent(client, "gotMechanicPartStock", client, stockCache)
end
addEventHandler("requestMechanicPartStock", root, requestMechanicPartStock)

currentOrders = {}

orderTimers = {}

function gotOrder(ws, model, part, type, count, timestamp)
	partStock[ws][model][part][type][2] = partStock[ws][model][part][type][2] + count
	for k, v in pairs(currentOrders[ws]) do
		if v[3] == timestamp then
			table.remove(currentOrders[ws], k)
		end
	end
end

addEvent("finalOrderParts", true)
function finalOrderParts(parts)
	local ws = workshops[getElementData(client, "playerWorkshop")][#workshops[getElementData(client, "playerWorkshop")] - 1]
	if not currentOrders[ws] then
		currentOrders[ws] = {}
	end
	local orderedBy = getElementData(client, "visibleName")
	local timestamp = getRealTime().timestamp
	local price = 0
	for k, v in pairs(parts) do
		table.insert(currentOrders[ws], {k, orderedBy, timestamp, v, v})
		time = v * 10 -- Percben
		local partData = partBackwards[k]
		part = partData[3]
		local type = partData[4]
		model = tostring(partData[1])
		if partStock[ws] and partStock[ws][model] and partStock[ws][model][part] and partStock[ws][model][part][type] and partStock[ws][model][part][type][3] - v < 0 then
			exports.sGui:showInfobox(client, "e", "Nincs elég alkatrész raktáron!")
			triggerClientEvent(client, "finalOrderResponse", client, false)
			return
		end
		local current = partStock[ws][model][part][type][6] or 0
		partStock[ws][model][part][type][6] = partStock[ws][model][part][type][6] + v
		partStock[ws][model][part][type][4] = v
		price = price + partPrices[k]
		setTimer(gotOrder, time * 1000 * 60, 1, ws, model, part, type, v, timestamp)
	end
	exports.sGui:showInfobox(client, "s", "Sikeresen leadted a rendelést, végösszeg: " .. exports.sGui:thousandsStepper(price) .. " $!")
	triggerClientEvent(client, "finalOrderResponse", client, true)
	if model then
		local stock = partStock[ws][model][part]
		local stockCache = {}
		for k, v in pairs(stock) do
			if v[3] == 0 then
				stock[k][3] = math.random(100, 1000)
			end
			table.insert(stockCache, v)
		end
		triggerClientEvent(client, "gotMechanicPartStock", client, stockCache)
	end
end
addEventHandler("finalOrderParts", root, finalOrderParts)

addEvent("requestMechanicLastOrders", true)
function requestMechanicLastOrders()
	local ws = workshops[getElementData(client, "playerWorkshop")][#workshops[getElementData(client, "playerWorkshop")] - 1]
	if not currentOrders[ws] then
		currentOrders[ws] = {}
	end
	local last = currentOrders[ws]
	triggerClientEvent(client, "gotMechanicLastOrders", client, last)
end
addEventHandler("requestMechanicLastOrders", root, requestMechanicLastOrders)

addEvent("deleteVehicleErrorCodes", true)
function deleteVehicleErrorCodes(veh)
	if not veh then
		veh = getPedOccupiedVehicle(client)
	end
	setElementData(veh, "vehicle.errorCodes", {})
	setElementData(veh, "vehicle.checkengine", 0)
	triggerClientEvent(client, "gotCheckEngineLightLevel", client, 0)
end
addEventHandler("deleteVehicleErrorCodes", root, deleteVehicleErrorCodes)

function getPositionFromElementOffset(element,offX,offY,offZ) 
	local m = getElementMatrix ( element )
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1] 
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2] 
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3] 
	return x, y, z
end

function attachRotationAdjusted(sourceElement, targetElement)
	local sourcePosX, sourcePosY, sourcePosZ = getElementPosition(sourceElement)
	local sourceRotX, sourceRotY, sourceRotZ = getElementRotation(sourceElement)
	
	local targetPosX, targetPosY, targetPosZ = getElementPosition(targetElement)
	local targetRotX, targetRotY, targetRotZ = getElementRotation(targetElement)
	
	local offsetPosX = sourcePosX - targetPosX
	local offsetPosY = sourcePosY - targetPosY
	local offsetPosZ = sourcePosZ - targetPosZ
	
	local offsetRotX = sourceRotX - targetRotX
	local offsetRotY = sourceRotY - targetRotY
	local offsetRotZ = sourceRotZ - targetRotZ
	
	offsetPosX, offsetPosY, offsetPosZ = applyInverseRotation(offsetPosX, offsetPosY, offsetPosZ, targetRotX, targetRotY, targetRotZ)
	
	attachElements(sourceElement, targetElement, offsetPosX, offsetPosY, offsetPosZ + 0.01, offsetRotX, offsetRotY, offsetRotZ)
end

function applyInverseRotation(posX, posY, posZ, rotX, rotY, rotZ)
	rotX = math.rad(rotX)
	rotY = math.rad(rotY)
	rotZ = math.rad(rotZ)
	
	local tempY = posY
	posY =  math.cos(rotX) * tempY + math.sin(rotX) * posZ
	posZ = -math.sin(rotX) * tempY + math.cos(rotX) * posZ
	
	local tempX = posX
	posX =  math.cos(rotY) * tempX - math.sin(rotY) * posZ
	posZ =  math.sin(rotY) * tempX + math.cos(rotY) * posZ
	
	tempX = posX
	posX =  math.cos(rotZ) * tempX + math.sin(rotZ) * posY
	posY = -math.sin(rotZ) * tempX + math.cos(rotZ) * posY
	
	return posX, posY, posZ
end

function saveCache()
	if fileExists("stock.dat") then
		fileDelete("stock.dat")
	end
	local f = fileCreate("stock.dat")
	fileWrite(f, toJSON(partStock))
	fileClose(f)
end
addEventHandler("onResourceStop", resourceRoot, saveCache)

function convertKeys(table)
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

function processJson(jsonTable)
    return convertKeys(jsonTable)
end

function invoiceCallback(qh, player)
	local result = dbPoll(qh, 0)[1]
	result.paperData = fromJSON(result.paperData)
	result.paperData = processJson(result.paperData)
	triggerClientEvent(player, "gotServiceInvoice", player, result)
end

addEvent("requestServiceInvoice", true)
function requestServiceInvoice(id)
	dbQuery(invoiceCallback, {client}, connection, "SELECT * FROM serviceinvoices WHERE id = ?", tonumber(id))
end
addEventHandler("requestServiceInvoice", root, requestServiceInvoice)

addEvent("temporaryCosmeticFix", true)
addEventHandler("temporaryCosmeticFix", root, function()


end)