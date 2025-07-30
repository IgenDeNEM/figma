screenWidth, screenHeight = guiGetScreenSize()
railTracks = {}
railsAt = {}
railEndsAt = {}

railSwitches = {}
railSwitchesAt = {}
railSwitchEnds = {}
railSwitchRoutes = {}
railSwitchStates = {}
railSwitchFading = {}
railSwitchBusy = {}

locoSeatByPassenger = {}
locoPassengerBySeat = {}

local baseRailCar = false
local subCartObjects = {}
local cartWheelObjects = {}
      cartTurtleObjects = {}
isDieselLocomotive = false

local firstRailCarX = 0
local firstRailCarY = 0
local firstRailCarRad = 0
local firstRailCarCos = 0
local firstRailCarSin = 0
local firstRailCarTrack = 1
local firstRailCarTrackRoute = -1
local firstRailCarTrackPosition = 0
local firstRailCarTrackDirection = 1

local lastRailCarX = 0
local lastRailCarY = 0
local lastRailCarRad = 0
local lastRailCarCos = 0
local lastRailCarSin = 0
local lastRailCarTrack = 1
local lastRailCarTrackRoute = -1
local lastRailCarTrackPosition = 0
local lastRailCarTrackDirection = 1

local railCarWheelRadius = 0.89492512
local railCarRollSound = false
railCarSyncedBy = false
local railCarLastSyncTime = 0
local railCarCurrentSpeed = 0
local railCarDesiredSpeed = 0
local railCarWheelRotProg = 0

local syncedDesiredSpeed = railCarDesiredSpeed
local syncedTrackPosition = firstRailCarTrackPosition
local syncedTrackDirection = firstRailCarTrackDirection

locoFuel = 0
locoDisplayedFuel = locoFuel

local locoExitProcess = false
local locoExitForce = false
local locoEngineStart = false
local locoCurrentThrottle = 0
local locoDesiredThrottle = 0
local locoEngineRev = 0

local locoIsBraking = false
local locoBrakePower = 0

local locoEngineSound = false
local locoBrakeSound = false

local lastLocoHorn = 0

local panelPosX = screenWidth - 192
local panelPosY = screenHeight - 256
local panelDragDrop = false
local panelThrottleControls = false

cartMaxSlots = {}
cartLastSlot = {}
cartTurtleRotation = {}
cartTurtleEmptying = {}

local railSmokePoints = {
	v4_mine_rail = {
		{-2.7286, 0},
		{2.7714, 0},
		{-1.2286, 0},
		{1.2714, 0},
		{0.021402, 0}
	},
	v4_mine_rail_end = {
		{2.82019, 0},
		{-1.67981, 0},
		{1.32019, 0},
		{-0.179807, 0},
		{0.570193, 0}
	},
	v4_mine_rail_left = {
		{0.028462, -2.67386},
		{2.82019, -0.019153},
		{0.23591, -1.12799},
		{1.32763, -0.157055},
		{0.71569, -0.46093}
	},
	v4_mine_rail_3way = {
		{-2.90245, 0},
		{2.76207, 0},
		{0, -2.90245},
		{-1.13111, -0.24241},
		{1.13094, -0.241961},
		{-0.100686, 0.016167},
		{0, -1.41191}
	},
	v4_mine_rail_crossing = {
		{-2.82019, 0},
		{2.67981, 0},
		{0, 2.82019},
		{0, -2.82019},
		{-0.849488, 0},
		{0.849537, 0},
		{0, 1.46045},
		{0, -1.50049}
	},
}

function isRailCarStationary()
	return railCarCurrentSpeed == 0
end

function findRailAngle(mineId, railId)
	return railTracks[railId]["angleRad"]
end

local function spawnRailSmoke(railObject)
	local railModel = railModels[getElementModel(railObject)]
	local railMatrix = getElementMatrix(railObject)
	
	for i = 1, #railSmokePoints[railModel] do
		local offsetTable = railSmokePoints[railModel][i]

		spawnSmokeExSm(
			railMatrix[4][1] + offsetTable[1] * railMatrix[1][1] + offsetTable[2] * railMatrix[2][1],
			railMatrix[4][2] + offsetTable[1] * railMatrix[1][2] + offsetTable[2] * railMatrix[2][2],
			railMatrix[4][3] + offsetTable[1] * railMatrix[1][3] + offsetTable[2] * railMatrix[2][3] + 0.25
		)
	end
end

local function createRailObject(trackX, trackY, trackDeg, isTermination)
	local objectModel = isTermination and modelIds.v4_mine_rail_end or modelIds.v4_mine_rail
	local objectElement = createObject(objectModel, minePosX + trackX * 6, minePosY + trackY * 6, minePosZ, 0, 0, trackDeg)

	if isElement(objectElement) then
		setElementInterior(objectElement, 0)
		setElementDimension(objectElement, currentMine)

		if eventName == "executeMineRailConstruction" then
			spawnRailSmoke(objectElement)
		end
	end

	return objectElement
end

local function createRailSwitchObject(switchX, switchY, switchDeg, switchType)
	local modelName = false

	if switchType == 2 then
		modelName = "v4_mine_rail_left"
	elseif switchType == 3 then
		modelName = "v4_mine_rail_3way"
	elseif switchType == 4 then
		modelName = "v4_mine_rail_crossing"
	end

	if modelName then
		local objectElement = createObject(modelIds[modelName], minePosX + switchX * 6, minePosY + switchY * 6, minePosZ, 0, 0, switchDeg)

		if isElement(objectElement) then
			setElementInterior(objectElement, 0)
			setElementDimension(objectElement, currentMine)

			if eventName == "executeMineRailConstruction" then
				spawnRailSmoke(objectElement)
			end
		end

		return objectElement
	end
end

local function createSingleRail(railId, storedData)
	local isTermination = storedData[4]

	local railDeg = storedData[3]
	local railRad = prad(railDeg)

	local railCos = pcos(railRad)
	local railSin = psin(railRad)

	local railX = storedData[1]
	local railY = storedData[2]

	local railData = {
		spotX = railX,
		spotY = railY,

		startPosX = minePosX + railX * 6 - railCos * 3,
		startPosY = minePosY + railY * 6 - railSin * 3,

		finalPosX = minePosX + railX * 6 + railCos * (isTermination and -0.5 or 3),
		finalPosY = minePosY + railY * 6 + railSin * (isTermination and -0.5 or 3),

		angleDeg = railDeg,
		angleRad = railRad,
		angleCos = railCos,
		angleSin = railSin,

		objectList = {},
	}

	railData.segmentLength = getDistanceBetweenPoints2D(railData.startPosX, railData.startPosY, railData.finalPosX, railData.finalPosY)

	if isTermination then
		railData.objectList[1] = createRailObject(railX, railY, railDeg + 180, true)
	else
		railData.objectList[1] = createRailObject(railX, railY, railDeg)
	end

	if not railsAt[railX] then
		railsAt[railX] = {}
	end

	railsAt[railX][railY] = railId

	if isTermination then
		if not railEndsAt[railX] then
			railEndsAt[railX] = {}
		end

		railEndsAt[railX][railY] = railId
	end

	railTracks[railId] = railData

	return railX, railY
end

local function createMultiRails(railId, storedData)
	local railStartX = storedData[1]
	local railStartY = storedData[2]

	local railEndX = storedData[3]
	local railEndY = storedData[4]

	local isTermination = storedData[5]

	local railDirSignX = railEndX < railStartX and -1 or 1
	local railDirSignY = railEndY < railStartY and -1 or 1

	local railRad = math.atan2(railEndY - railStartY, railEndX - railStartX)
	local railDeg = math.deg(railRad)

	local railCos = pcos(railRad)
	local railSin = psin(railRad)

	local railData = {
		spotX = railEndX,
		spotY = railEndY,

		startPosX = minePosX + railStartX * 6 - railCos * 3 - railCos * (railId == 1 and -3.5 or 0),
		startPosY = minePosY + railStartY * 6 - railSin * 3 - railSin * (railId == 1 and -3.5 or 0),

		finalPosX = minePosX + railEndX * 6 + railCos * (isTermination and -0.5 or 3),
		finalPosY = minePosY + railEndY * 6 + railSin * (isTermination and -0.5 or 3),

		angleDeg = railDeg,
		angleRad = railRad,
		angleCos = railCos,
		angleSin = railSin,

		objectList = {},
	}

	railData.segmentLength = getDistanceBetweenPoints2D(railData.startPosX, railData.startPosY, railData.finalPosX, railData.finalPosY)

	for railX = railStartX, railEndX, railDirSignX do
		if not railsAt[railX] then
			railsAt[railX] = {}
		end

		for railY = railStartY, railEndY, railDirSignY do
			railsAt[railX][railY] = railId

			if railId == 1 and railX == railStartX and railY == railStartY then
				table.insert(railData.objectList, createRailObject(railX, railY, railDeg, true))
			elseif isTermination and railX == railEndX and railY == railEndY then
				table.insert(railData.objectList, createRailObject(railX, railY, railDeg + 180, true))

				if not railEndsAt[railX] then
					railEndsAt[railX] = {}
				end

				railEndsAt[railX][railY] = railId
			else
				table.insert(railData.objectList, createRailObject(railX, railY, railDeg))
			end
		end
	end

	railTracks[railId] = railData

	return railStartX, railStartY
end

function createRail(trackId, trackData)
	if #trackData == 4 then
		return createSingleRail(trackId, trackData)
	else
		return createMultiRails(trackId, trackData)
	end
end

function createRailSwitch(switchId, creationData, switchState)
	local switchData = {}

	local spotX = creationData[1]
	local spotY = creationData[2]

	local switchPosX = minePosX + spotX * 6
	local switchPosY = minePosY + spotY * 6

	local trackAheadId = creationData[4]
	local trackAhead = railTracks[trackAheadId]

	local trackRad = math.atan2(trackAhead.startPosY - switchPosY, trackAhead.startPosX - switchPosX)
	local trackDeg = math.deg(trackRad) + 90
	local trackCos = math.cos(trackRad)
	local trackSin = math.sin(trackRad)

	table.remove(creationData, 1) -- spotX
	table.remove(creationData, 1) -- spotY

	if railSwitches[switchId] then
		if isElement(railSwitches[switchId]["objectElement"]) then
			destroyElement(railSwitches[switchId]["objectElement"])
		end
	end

	local switchData = {
		trackIds = creationData,

		spotX = spotX,
		spotY = spotY,

		worldX = switchPosX,
		worldY = switchPosY,

		angleRad = trackRad,
		angleDeg = trackDeg,
		angleCos = trackCos,
		angleSin = trackSin,

		objectElement = createRailSwitchObject(spotX, spotY, trackDeg, #creationData)
	}

	railSwitches[switchId] = switchData

	if #switchData.trackIds >= 3 then
		if switchState then
			railSwitchStates[switchId] = switchState
		elseif not railSwitchStates[switchId] then
			railSwitchStates[switchId] = 1
		end
	end

	railSwitchRoutes[switchId] = {}

	if not railSwitchesAt[spotX] then
		railSwitchesAt[spotX] = {}
	end

	railSwitchesAt[spotX][spotY] = switchId

	if railsAt[spotX] then
		railsAt[spotX][spotY] = nil
	end

	processRailSwitchRoutes(switchId)
	processRailSwitchEnds(switchId)

	return spotX, spotY
end

function processRailSwitchEnds(switchId)
	local switchData = railSwitches[switchId]

	if switchData then
		for routeId = 1, #switchData.trackIds do
			local trackId = switchData.trackIds[routeId]
			local trackData = railTracks[trackId]

			if trackData then
				local trackDirection = 0

				if getDistanceBetweenPoints2D(switchData.worldX, switchData.worldY, trackData.startPosX, trackData.startPosY) < getDistanceBetweenPoints2D(switchData.worldX, switchData.worldY, trackData.finalPosX, trackData.finalPosY) then
					trackDirection = 2
				else
					trackDirection = 1
				end

				if not railSwitchEnds[trackId] then
					railSwitchEnds[trackId] = {}
				end

				railSwitchEnds[trackId][trackDirection] = {switchId = switchId, routeId = routeId}
			end
		end
	end
end

function processRailSwitchRoutes(switchId)
	local switchData = railSwitches[switchId]

	if switchData then
		local switchType = #switchData.trackIds
		local switchRoute = railSwitchStates[switchId] or 1

		if switchMatrix[switchType][switchRoute] then
			local directionX = switchData.angleCos
			local directionY = switchData.angleSin

			for sourceRoute = 1, 4 do
				local targetRoute = switchMatrix[switchType][switchRoute][sourceRoute]

				directionX, directionY = directionY, -directionX

				if targetRoute then
					-- Straight Route
					if sourceRoute % 2 == targetRoute % 2 then
						railSwitchRoutes[switchId][sourceRoute] = {
							targetRoute = targetRoute,

							offsetX = -directionX * 3,
							offsetY = -directionY * 3,

							curveAngle = nil,
							curveDirSign = nil
						}
					-- Curved Route
					else
						local curvatureOffset = (math.abs(targetRoute - sourceRoute) > 1 and -1 or 1) * (sourceRoute < targetRoute and -1 or 1) * 2

						railSwitchRoutes[switchId][sourceRoute] = {
							targetRoute = targetRoute,

							offsetX = -directionX * 2 + directionY * curvatureOffset,
							offsetY = -directionY * 2 - directionX * curvatureOffset,

							curveAngle = math.atan2(-directionX * curvatureOffset, directionY * curvatureOffset) + PI,
							curveDirSign = -curvatureOffset / 2
						}
					end
				else
					railSwitchRoutes[switchId][sourceRoute] = nil
				end
			end
		end
	end
end

function extendRail(trackId, noTermination)
	local trackData = railTracks[trackId]

	if trackData then
		local trackX = trackData.spotX
		local trackY = trackData.spotY

		local trackCos = trackData.angleCos
		local trackSin = trackData.angleSin

		if railEndsAt[trackX] then
			railEndsAt[trackX][trackY] = nil
		end

		if isElement(trackData.objectList[#trackData.objectList]) then
			destroyElement(trackData.objectList[#trackData.objectList])
		end

		trackData.objectList[#trackData.objectList] = createRailObject(trackX, trackY, trackData.angleDeg)

		trackX = trackX + trackCos
		trackY = trackY + trackSin

		trackData.spotX = trackX
		trackData.spotY = trackY

		trackData.finalPosX = minePosX + trackX * 6 + trackCos * (noTermination and 3 or -0.5)
		trackData.finalPosY = minePosY + trackY * 6 + trackSin * (noTermination and 3 or -0.5)

		local trackLengthWas = trackData.segmentLength
		local trackLengthNew = getDistanceBetweenPoints2D(trackData.startPosX, trackData.startPosY, trackData.finalPosX, trackData.finalPosY)

		trackData.segmentLength = trackLengthNew

		if noTermination then
			table.insert(trackData.objectList, createRailObject(trackX, trackY, trackData.angleDeg))
		else
			table.insert(trackData.objectList, createRailObject(trackX, trackY, trackData.angleDeg + 180, true))
		end

		if not railEndsAt[trackX] then
			railEndsAt[trackX] = {}
		end

		railEndsAt[trackX][trackY] = trackId

		if not railsAt[trackX] then
			railsAt[trackX] = {}
		end

		railsAt[trackX][trackY] = trackId

		if firstRailCarTrackDirection == 2 and firstRailCarTrack == trackId then
			firstRailCarTrackPosition = firstRailCarTrackPosition + trackLengthNew - trackLengthWas
		end

		return trackX, trackY
	end
end

function splitRail(trackId, trackX, trackY)
	local trackData = railTracks[trackId]

	if trackData then
		local trackLength = 1 + getDistanceBetweenPoints2D(trackX, trackY, trackData.spotX, trackData.spotY)

		local trackCos = trackData.angleCos
		local trackSin = trackData.angleSin

		trackData.spotX = trackX - trackCos
		trackData.spotY = trackY - trackSin

		trackData.finalPosX = minePosX + trackX * 6 + trackCos * (3 - 6)
		trackData.finalPosY = minePosY + trackY * 6 + trackSin * (3 - 6)

		trackData.segmentLength = getDistanceBetweenPoints2D(trackData.startPosX, trackData.startPosY, trackData.finalPosX, trackData.finalPosY)

		if railsAt[trackX] then
			railsAt[trackX][trackY] = nil
		end

		if railEndsAt[trackX] then
			railEndsAt[trackX][trackY] = nil
		end

		for i = #trackData.objectList, #trackData.objectList - trackLength, -1 do
			if isElement(trackData.objectList[i]) then
				destroyElement(trackData.objectList[i])
			end

			trackData.objectList[i] = nil
		end

		table.insert(trackData.objectList, createRailObject(trackData.spotX, trackData.spotY, trackData.angleDeg))
	end

	return trackX, trackY
end

function mergeRails(targetTrackId, sourceTrackId, finalSpotX, finalSpotY)
	local targetTrack = railTracks[targetTrackId]
	local sourceTrack = railTracks[sourceTrackId]

	local sourceX = sourceTrack.spotX
	local sourceY = sourceTrack.spotY

	local targetX = targetTrack.spotX
	local targetY = targetTrack.spotY

	if isElement(sourceTrack.objectList[#sourceTrack.objectList]) then
		destroyElement(sourceTrack.objectList[#sourceTrack.objectList])
	end

	sourceTrack.objectList[#sourceTrack.objectList] = createRailObject(sourceX, sourceY, sourceTrack.angleDeg)

	local trackCos = targetTrack.angleCos
	local trackSin = targetTrack.angleSin

	if isElement(targetTrack.objectList[#targetTrack.objectList]) then
		destroyElement(targetTrack.objectList[#targetTrack.objectList])
	end

	targetTrack.objectList[#targetTrack.objectList] = createRailObject(targetX, targetY, sourceTrack.angleDeg)
	targetTrack.objectList[#targetTrack.objectList + 1] = createRailObject(targetX + trackCos, targetY + trackSin, sourceTrack.angleDeg)

	if railEndsAt[sourceX] then
		railEndsAt[sourceX][sourceY] = nil
	end

	if railEndsAt[targetX] then
		railEndsAt[targetX][targetY] = nil
	end

	while #sourceTrack.objectList > 0 do
		local closestDistance = false
		local closestObjectId = false

		for i = 1, #sourceTrack.objectList do
			local objectPosX, objectPosY = getElementPosition(sourceTrack.objectList[i])
			local objectDistance = getDistanceBetweenPoints2D(objectPosX, objectPosY, targetTrack.finalPosX, targetTrack.finalPosY)

			if not closestDistance or objectDistance < closestDistance then
				closestDistance = objectDistance
				closestObjectId = i
			end
		end

		table.insert(targetTrack.objectList, table.remove(sourceTrack.objectList, closestObjectId))
	end

	targetX = targetX - trackCos
	targetY = targetY - trackSin

	for spotX = targetX, finalSpotX, (finalSpotX < targetX and -1 or 1) do
		if not railsAt[spotX] then
			railsAt[spotX] = {}
		end

		for spotY = targetY, finalSpotY, (finalSpotY < targetY and -1 or 1) do
			railsAt[spotX][spotY] = targetTrackId
		end
	end

	targetTrack.spotX = finalSpotX
	targetTrack.spotY = finalSpotY

	targetTrack.finalPosX = minePosX + finalSpotX * 6 + trackCos * 3
	targetTrack.finalPosY = minePosY + finalSpotY * 6 + trackSin * 3

	targetTrack.segmentLength = getDistanceBetweenPoints2D(targetTrack.startPosX, targetTrack.startPosY, targetTrack.finalPosX, targetTrack.finalPosY)

	if firstRailCarTrackRoute <= 0 then
		if firstRailCarTrack == sourceTrackId then
			firstRailCarTrack = targetTrackId

			if firstRailCarTrackDirection == 2 then
				firstRailCarTrackDirection = 1
			else
				firstRailCarTrackDirection = 2
			end

			if not railCarSyncedBy then
				if source == localPlayer then
					triggerServerEvent("mineRailSyncing", localPlayer, nil, nil, nil, firstRailCarTrackDirection, firstRailCarTrack, nil, true)
				end
			elseif railCarSyncedBy == localPlayer then
				isRailCarControllable = true
			end
		end
	end

	railTracks[sourceTrackId] = nil

	for switchId, switchData in pairs(railSwitches) do
		local switchFound = false

		for routeId = 1, #switchData.trackIds do
			if switchData.trackIds[routeId] == sourceTrackId then
				switchData.trackIds[routeId] = targetTrackId
				switchFound = true
				break
			end
		end

		if switchFound then
			processRailSwitchEnds(switchId)
			break
		end
	end
end

function openUpRail(trackId)
	local trackData = railTracks[trackId]

	if trackData then
		local trackX = trackData.spotX
		local trackY = trackData.spotY

		local trackCos = trackData.angleCos
		local trackSin = trackData.angleSin

		if railEndsAt[trackX] then
			railEndsAt[trackX][trackY] = nil
		end

		trackData.finalPosX = minePosX + trackX * 6 + trackCos * 3
		trackData.finalPosY = minePosY + trackY * 6 + trackSin * 3

		trackData.segmentLength = getDistanceBetweenPoints2D(trackData.startPosX, trackData.startPosY, trackData.finalPosX, trackData.finalPosY)

		if isElement(trackData.objectList[#trackData.objectList]) then
			destroyElement(trackData.objectList[#trackData.objectList])
		end

		trackData.objectList[#trackData.objectList] = createRailObject(trackX, trackY, trackData.angleDeg)

		return trackX, trackY
	end
end

function initMineTrain(dieselLoco, subCartNum, fuelLevel)
	local baseRailCarModel = dieselLoco and "v4_mine_urmamoto" or "v4_mine_cart1"

	if not baseRailCar then
		baseRailCar = createObject(modelIds[baseRailCarModel], minePosX, minePosY, minePosZ, 0, 0, 0)

		if isElement(baseRailCar) then
			setElementInterior(baseRailCar, 0)
			setElementDimension(baseRailCar, currentMine)
		end
	elseif isElement(baseRailCar) then
		setElementModel(baseRailCar, modelIds[baseRailCarModel])
	end

	isDieselLocomotive = dieselLoco

	for i = 1, 2 do
		if not cartWheelObjects[i] then
			cartWheelObjects[i] = createObject(modelIds.v4_mine_cart1_wheels, minePosX, minePosY, minePosZ, 0, 0, 0)

			if isElement(cartWheelObjects[i]) then
				setElementInterior(cartWheelObjects[i], 0)
				setElementDimension(cartWheelObjects[i], currentMine)
				attachElements(cartWheelObjects[i], baseRailCar)
			end
		end
	end

	locoFuel = fuelLevel or locoFuel
	locoDisplayedFuel = fuelLevel or locoDisplayedFuel

	if not dieselLoco then
		if not cartTurtleObjects[1] then
			cartTurtleObjects[1] = createObject(modelIds.v4_mine_cart1_turtle, minePosX, minePosY, minePosZ, 0, 0, 0)

			if isElement(cartTurtleObjects[1]) then
				setElementInterior(cartTurtleObjects[1], 0)
				setElementDimension(cartTurtleObjects[1], currentMine)
				attachElements(cartTurtleObjects[1], baseRailCar, 0.0212, 0, 0.8012)
			end
		end
	else
		if isElement(cartTurtleObjects[1]) then
			destroyElement(cartTurtleObjects[1])
		end

		cartTurtleObjects[1] = nil
	end

	for i = 1, subCartNum do
		if not subCartObjects[i] then
			subCartObjects[i] = createObject(modelIds.v4_mine_cart1, minePosX, minePosY, minePosZ, 0, 0, 0)

			if isElement(subCartObjects[i]) then
				setElementInterior(subCartObjects[i], 0)
				setElementDimension(subCartObjects[i], currentMine)
			end
		end

		for j = i*2+1, i*2+2 do
			if not cartWheelObjects[j] then
				cartWheelObjects[j] = createObject(modelIds.v4_mine_cart1_wheels, minePosX, minePosY, minePosZ, 0, 0, 0)

				if isElement(cartWheelObjects[j]) then
					setElementInterior(cartWheelObjects[j], 0)
					setElementDimension(cartWheelObjects[j], currentMine)
					attachElements(cartWheelObjects[j], subCartObjects[i])
				end
			end
		end

		local turtleId = i + (dieselLoco and 0 or 1)

		if not cartTurtleObjects[turtleId] then
			cartTurtleObjects[turtleId] = createObject(modelIds.v4_mine_cart1_turtle, minePosX, minePosY, minePosZ, 0, 0, 0)

			if isElement(cartTurtleObjects[turtleId]) then
				setElementInterior(cartTurtleObjects[turtleId], 0)
				setElementDimension(cartTurtleObjects[turtleId], currentMine)
				attachElements(cartTurtleObjects[turtleId], subCartObjects[i], 0.0212, 0, 0.8012)
			end
		end
	end

	if not railCarRollSound then
		railCarRollSound = playSound3D("files/sounds/railcartroll.mp3", 0, 0, 0, true)

		if isElement(railCarRollSound) then
			setElementInterior(railCarRollSound, 0)
			setElementDimension(railCarRollSound, currentMine)
			setSoundMaxDistance(railCarRollSound, 60)
		end
	end

	if dieselLoco then
		if not currentMineInventory.jerryCan then
			currentMineInventory.jerryCan = createObject(modelIds.v4_mine_jerrycan, 0, 0, 0)
		end

		if isElement(currentMineInventory.jerryCan) then
			if not currentMineInventory.jerrySound then
				currentMineInventory.jerrySound = playSound3D("files/sounds/dispensefuel.wav", 0, 0, 0, true)
			end

			setElementInterior(currentMineInventory.jerryCan, 0)
			setElementDimension(currentMineInventory.jerryCan, currentMine)

			if isElement(currentMineInventory.jerrySound) then
				setElementInterior(currentMineInventory.jerrySound, 0)
				setElementDimension(currentMineInventory.jerrySound, currentMine)
				setSoundVolume(currentMineInventory.jerrySound, 0)
				attachElements(currentMineInventory.jerrySound, currentMineInventory.jerryCan)
			end

			processJerrycanSync(currentMineInventory.jerryCarry)
		end
	else
		if isElement(currentMineInventory.jerryCan) then
			destroyElement(currentMineInventory.jerryCan)
		end

		if isElement(currentMineInventory.jerrySound) then
			destroyElement(currentMineInventory.jerrySound)
		end

		currentMineInventory.jerryCan = nil
		currentMineInventory.jerrySound = nil
	end

	for fixOreId in pairs(fixOreCarts) do
		attachFixOreToCart(fixOreId, unpack(fixOreCarts[fixOreId]))
	end

	forceRefreshTrain = true
end

function deleteMineTrain()
	if isElement(baseRailCar) then
		destroyElement(baseRailCar)
	end
	baseRailCar = nil

	for i = #subCartObjects, 1, -1 do
		if isElement(subCartObjects[i]) then
			destroyElement(subCartObjects[i])
		end
		subCartObjects[i] = nil
	end

	for i = #cartWheelObjects, 1, -1 do
		if isElement(cartWheelObjects[i]) then
			destroyElement(cartWheelObjects[i])
		end
		cartWheelObjects[i] = nil
	end

	for i = #cartTurtleObjects, 1, -1 do
		if isElement(cartTurtleObjects[i]) then
			destroyElement(cartTurtleObjects[i])
		end
		cartTurtleObjects[i] = nil
	end

	if isElement(railCarRollSound) then
		destroyElement(railCarRollSound)
	end
	railCarRollSound = nil
end

function driveLocomotive()
	locoExitProcess = false

	isRailCarController = true
	isRailCarControllable = true

	locoCurrentThrottle = 0
	locoDesiredThrottle = 0

	panelThrottleControls = false
end

function forceExitLoco()
	if isRailCarController then
		locoExitForce = true
		locoExitProcess = true
		locoDesiredThrottle = 0
	elseif locoSeatByPassenger[localPlayer] then
		triggerServerEvent("exitMineLoco", localPlayer)
	end
end

function playLocoHorn()
	local soundEffect = playSound3D("files/sounds/locohorn.mp3", firstRailCarX, firstRailCarY, minePosZ + 1, false)

	if isElement(soundEffect) then
		setSoundVolume(soundEffect, 2)
		setElementInterior(soundEffect, 0)
		setElementDimension(soundEffect, currentMine)
		setSoundMaxDistance(soundEffect, 100)
	end
end

function processLocoPassenger(clientId, spotId)
	local previousPassenger = locoPassengerBySeat[spotId]

	if previousPassenger then
		locoSeatByPassenger[previousPassenger] = nil
		setPedAnimation(previousPassenger)
		detachElements(previousPassenger, baseRailCar)
	end

	if isElement(clientId) then
		if clientId ~= resourceRoot then
			locoPassengerBySeat[spotId] = clientId
			locoSeatByPassenger[clientId] = spotId

			if clientId == localPlayer then
				exports.sGui:showInfobox("i", "A [Backspace] gomb megnyomásával tudsz leszállni a mozdonyról.")
			end
		else
			locoPassengerBySeat[spotId] = nil
		end
	else
		locoPassengerBySeat[spotId] = nil
	end
end

function isRailCarSyncer(clientId)
	return railCarSyncedBy == clientId
end

function pedsProcessedTrain(animatedPlayers)
	if not isDieselLocomotive then
		if railCarSyncedBy and math.abs(railCarDesiredSpeed) > 0 then
			setElementBoneRotation(railCarSyncedBy, 2, 0, 20, 0)
			setElementBoneRotation(railCarSyncedBy, 3, 0, 15, 0)
			setElementBoneRotation(railCarSyncedBy, 22, 13.043463333793, -49.565267148225, -20.869540338931)
			setElementBoneRotation(railCarSyncedBy, 23, -33.912973818572, -57.391204833984, 0.000054732612909447)
			setElementBoneRotation(railCarSyncedBy, 32, -13.043463333793, -49.565267148225, 20.869540338931)
			setElementBoneRotation(railCarSyncedBy, 33, -33.912973818572, -57.391204833984, 0.000054732612909447)
			animatedPlayers[railCarSyncedBy] = true
		end
	end
end

function doRailCarInteraction(keyName)
	if isDieselLocomotive then
		if keyName == "backspace" then
			if isRailCarController then
				if railCarCurrentSpeed == 0 then
					locoExitProcess = true
				else
					exports.sGui:showInfobox("e", "Előbb állj meg a vonattal!")
				end
			elseif locoSeatByPassenger[localPlayer] then
				if railCarCurrentSpeed == 0 then
					triggerServerEvent("exitMineLoco", localPlayer)
				else
					exports.sGui:showInfobox("e", "Menet közben nem ugorhatsz le!")
				end
			end
		elseif isRailCarController then
			if keyName == "h" then
				if mineTick - lastLocoHorn > 1000 then
					playLocoHorn()
					triggerServerEvent("mineRailHorn", localPlayer)
					lastLocoHorn = mineTick
				end
			elseif keyName == "lshift" then
				if locoEngineStart and not locoExitForce then
					local elapsedTime = mineTick - locoEngineStart

					if elapsedTime > 1600 then
						if not next(cartTurtleEmptying) then
							if locoDesiredThrottle < 4 then
								locoDesiredThrottle = locoDesiredThrottle + 1

								if railCarCurrentSpeed > 0 and locoDesiredThrottle < 0 then
									locoDesiredThrottle = 0
								elseif railCarCurrentSpeed < 0 and locoDesiredThrottle > 0 then
									locoDesiredThrottle = 0
								end
							end
						else
							locoDesiredThrottle = 0
						end
					end
				end
			elseif keyName == "lctrl" then
				if locoEngineStart and not locoExitForce then
					local elapsedTime = mineTick - locoEngineStart

					if elapsedTime > 1600 then
						if not next(cartTurtleEmptying) then
							if locoDesiredThrottle > -4 then
								locoDesiredThrottle = locoDesiredThrottle - 1

								if railCarCurrentSpeed > 0 and locoDesiredThrottle < 0 then
									locoDesiredThrottle = 0
								elseif railCarCurrentSpeed < 0 and locoDesiredThrottle > 0 then
									locoDesiredThrottle = 0
								end
							end
						else
							locoDesiredThrottle = 0
						end
					end
				end
			elseif keyName == "n" then
				locoDesiredThrottle = 0
			end
		end
	end
end

function renderTrain()
	if isDieselLocomotive then
		if isRailCarController then
			local fuelDialAngle = locoEngineRev * 2.5 * math.sin(mineTick / 10 * PI) - 120 * (1 - locoDisplayedFuel / 100)
			local throttleAngle = locoCurrentThrottle * 20 - math.sin(locoCurrentThrottle % 1 * PI) * 20 / 3

			dxDrawImage(panelPosX - 180, panelPosY - 256, 360, 512, "files/textures/locomotive/base.png")
			dxDrawImage(panelPosX - 32, panelPosY - 102.912, 64, 64, "files/textures/locomotive/dial.png", fuelDialAngle)
			dxDrawImage(panelPosX - 180, panelPosY - 256, 360, 512, "files/textures/locomotive/fore.png")
			dxDrawImage(panelPosX - 124, panelPosY + 29, 256, 64, "files/textures/locomotive/throttle2.png", throttleAngle, 0, 0, tocolor(0, 0, 0, 110))
			dxDrawImage(panelPosX - 128, panelPosY + 25, 256, 64, "files/textures/locomotive/throttle.png", throttleAngle)

			if cursorX and not locoExitForce then
				local throttleX = panelPosX
				local throttleY = panelPosY + 57

				local deltaX = throttleX - cursorX
				local deltaY = throttleY - cursorY

				local selectedThrottle = math.min(4, math.max(-4, math.floor(math.deg(math.atan2(deltaY, deltaX)) / 20 + 0.5)))
				
				if panelDragDrop then
					if not getKeyState("mouse1") then
						panelDragDrop = false
					else
						panelPosX = math.min(screenWidth - 180, math.max(180, cursorX - panelDragDrop[1]))
						panelPosY = math.min(screenHeight - 256, math.max(256, cursorY - panelDragDrop[2]))
					end
				elseif panelThrottleControls then
					if not getKeyState("mouse1") or not locoEngineStart or locoFuel <= 0 then
						panelThrottleControls = false
					end
					
					locoDesiredThrottle = selectedThrottle
					
					if railCarCurrentSpeed > 0 and locoDesiredThrottle < 0 then
						locoDesiredThrottle = 0
					elseif railCarCurrentSpeed < 0 and locoDesiredThrottle > 0 then
						locoDesiredThrottle = 0
					end
				elseif getKeyState("mouse1") then
					if getDistanceBetweenPoints2D(throttleX, throttleY, cursorX, cursorY) <= 128 then
						if isLocoHasFuel() and locoEngineStart and mineTick - locoEngineStart >= 1600 then
							panelThrottleControls = selectedThrottle == locoDesiredThrottle
						end
					elseif cursorX >= panelPosX - 180 and cursorY >= panelPosY - 256 and cursorX <= panelPosX + 180 and cursorY <= panelPosY + 256 then
						panelDragDrop = {cursorX - panelPosX, cursorY - panelPosY}
					end
				end
			else
				panelDragDrop = false
				panelThrottleControls = false
			end

			freeFromAction = false
		elseif freeFromAction then
			if not locoSeatByPassenger[localPlayer] then
				if railCarCurrentSpeed == 0 and not railCarSyncedBy then
					renderActionButton("joyIcon", firstRailCarX + firstRailCarCos * 0.75, firstRailCarY + firstRailCarSin * 0.75, minePosZ + 1.25, 2.0, 2.5, true, "driveDieselLoco")
				end

				if math.abs(railCarCurrentSpeed) < 0.1 then
					if currentMineInventory.jerryCarry ~= localPlayer then
						for i = 1, #locoPassengerSpots do
							local spotData = locoPassengerSpots[i]

							if spotData then
								renderActionButton("rideIcon", firstRailCarX + firstRailCarCos * spotData[1] - firstRailCarSin * spotData[2], firstRailCarY + firstRailCarSin * spotData[1] + firstRailCarCos * spotData[2], minePosZ + spotData[3], 2.0, 2.5, false, "dieselLocoPassenger", i)
							end
						end
					end

					if not currentMineInventory.jerryCarry then
						renderActionButton("fuelIcon", firstRailCarX + firstRailCarCos * 0.2962 + firstRailCarSin * 0.3895, firstRailCarY + firstRailCarSin * 0.2962 - firstRailCarCos * 0.3895, minePosZ + 1.0215, 1.0, 1.25, false, "getJerryCan")
					end
				end
			end
		elseif currentMineInventory.jerryCarry == localPlayer then
			if isElement(currentMineInventory.jerryCan) then
				local jerryPosX, jerryPosY, jerryPosZ = getElementPosition(currentMineInventory.jerryCan)
				local jerryScrX, jerryScrY, jerryScrZ = getScreenFromWorldPosition(jerryPosX, jerryPosY, jerryPosZ, 16)

				if jerryScrX then
					local displayedText = string.format("%s/%s L", math.floor(currentMineInventory.displayedJerryContent * 10) / 10, jerryCanCapacity)

					dxDrawText(displayedText, jerryScrX + 1, jerryScrY, jerryScrX + 1, jerryScrY + 1, tocolor(0, 0, 0, 204), guiFontScales.oreFont, guiFonts.oreFont, "center", "center")
					dxDrawText(displayedText, jerryScrX, jerryScrY, jerryScrX, jerryScrY, tocolor(255, 255, 255), guiFontScales.oreFont, guiFonts.oreFont, "center", "center")
				end
			end

			if locoFuel == locoDisplayedFuel then
				renderActionButton("fuelIcon", firstRailCarX + firstRailCarCos * 0.2962 + firstRailCarSin * 0.3895, firstRailCarY + firstRailCarSin * 0.2962 - firstRailCarCos * 0.3895, minePosZ + 1.0215, 1.0, 1.25, false, "putJerryCan")
			end

			local tankPosX = firstRailCarX - firstRailCarCos * 0.0399 + firstRailCarSin * 0.5469
			local tankPosY = firstRailCarY - firstRailCarSin * 0.0399 - firstRailCarCos * 0.5469
			local tankPosZ = minePosZ + 1.0215
			local tankDistance = getDistanceBetweenPoints2D(tankPosX, tankPosY, selfPosX, selfPosY)

			if tankDistance < 1.25 then
				local tankScrX, tankScrY

				if locoFuel == locoDisplayedFuel then
					tankScrX, tankScrY = renderActionButton("fuelIcon", tankPosX, tankPosY, tankPosZ, 1.0, 1.25, false, "fillLocoTank")
				end

				if not tankScrX then
					tankScrX, tankScrY = getScreenFromWorldPosition(tankPosX, tankPosY, tankPosZ, 16)
				else
					tankScrY = tankScrY - 32
				end

				if tankScrX then
					local distanceFade = (1 - math.max(0, (tankDistance - 1) / 0.25)) * 255

					if distanceFade > 0 then
						local displayedText = string.format("%s/%s L", math.floor(locoDisplayedFuel / 100 * locoTankCapacity * 10) / 10, locoTankCapacity)

						dxDrawText(displayedText, tankScrX + 1, tankScrY, tankScrX + 1, tankScrY + 1, tocolor(0, 0, 0, distanceFade), guiFontScales.oreFont, guiFonts.oreFont, "center", "center")
						dxDrawText(displayedText, tankScrX, tankScrY, tankScrX, tankScrY, tocolor(255, 255, 255, distanceFade), guiFontScales.oreFont, guiFonts.oreFont, "center", "center")
					end
				end
			end
		end
	end
end

function processRailCars(deltaTime)
	if locoDesiredThrottle ~= 0 then
		if next(cartTurtleEmptying) then
			locoDesiredThrottle = 0
		end
	end

	if locoExitForce then
		locoExitProcess = true
		locoDesiredThrottle = 0
	end

	local currentAcceleration = 0
	local currentPreviousSpeed = railCarCurrentSpeed

	locoIsBraking = false

	if railCarDesiredSpeed ~= railCarCurrentSpeed then
		local absoluteCurrentSpeed = math.abs(railCarCurrentSpeed)
		local absoluteDesiredSpeed = math.abs(railCarDesiredSpeed)

		if absoluteCurrentSpeed < absoluteDesiredSpeed then
			currentAcceleration = isDieselLocomotive and 0.85 or 1
		else
			currentAcceleration = isDieselLocomotive and 1.125 or 0.75
		end

		local directionSign = railCarDesiredSpeed < railCarCurrentSpeed and -1 or 1

		if #subCartObjects > 0 then
			currentAcceleration = currentAcceleration / (#subCartObjects / 2 + 1)
		end

		railCarCurrentSpeed = railCarCurrentSpeed + currentAcceleration * deltaTime * directionSign

		if railCarCurrentSpeed * directionSign > railCarDesiredSpeed * directionSign then
			railCarCurrentSpeed = railCarDesiredSpeed
		elseif absoluteDesiredSpeed <= absoluteCurrentSpeed then
			locoIsBraking = true
		end
	end

	if locoFuel ~= locoDisplayedFuel then
		if locoDisplayedFuel < locoFuel then
			locoDisplayedFuel = locoDisplayedFuel + 2.5 * deltaTime

			if locoDisplayedFuel > locoFuel then
				locoDisplayedFuel = locoFuel
			end
		else
			locoDisplayedFuel = locoFuel
		end
	end

	local railCarDesiredTargetSpeed = railCarDesiredSpeed
	local firstRailCarTrackPositionPortion = 0

	if forceRefreshTrain or railCarCurrentSpeed ~= 0 or currentPreviousSpeed ~= 0 then
		forceRefreshTrain = false

		if firstRailCarTrackRoute > 0 and firstRailCarTrackDirection == 2 then
			firstRailCarTrackPosition = firstRailCarTrackPosition - currentPreviousSpeed * deltaTime + currentAcceleration * 0.5 * deltaTime * deltaTime
		else
			firstRailCarTrackPosition = firstRailCarTrackPosition + currentPreviousSpeed * deltaTime + currentAcceleration * 0.5 * deltaTime * deltaTime
		end

		railCarWheelRotProg = (railCarWheelRotProg + (currentPreviousSpeed * deltaTime + currentAcceleration * 0.5 * deltaTime * deltaTime) / railCarWheelRadius) % 1

		for i = 1, #cartWheelObjects do
			if isElement(cartWheelObjects[i]) then
				if i % 2 == 0 then
					setElementAttachedOffsets(cartWheelObjects[i], -0.375, 0, 0.2718, 0, railCarWheelRotProg * 360, 0)
				else
					setElementAttachedOffsets(cartWheelObjects[i], 0.375, 0, 0.2718, 0, railCarWheelRotProg * 360, 0)
				end
			end
		end

		railSwitchBusy = {}

		while true do
			if firstRailCarTrackRoute > 0 then
				local switchRoutes = railSwitchRoutes[firstRailCarTrack]

				if switchRoutes then
					local switchRouteData = switchRoutes[firstRailCarTrackRoute]

					if switchRouteData then
						railSwitchBusy[firstRailCarTrack] = true

						if switchRouteData.curveAngle then
							if firstRailCarTrackPosition > PI + 2 then
								local targetTrack = railSwitches[firstRailCarTrack]["trackIds"][switchRouteData.targetRoute]

								if targetTrack then
									local targetTrackData = railTracks[targetTrack]
									local targetTrackPosition = firstRailCarTrackPosition - (PI + 2)
									local targetTrackDirection = railSwitchEnds[targetTrack] and railSwitchEnds[targetTrack][1] and railSwitchEnds[targetTrack][1]["switchId"] == firstRailCarTrack

									if firstRailCarTrackDirection == 2 then
										targetTrackPosition = targetTrackData.segmentLength - targetTrackPosition
										targetTrackDirection = not targetTrackDirection
									end

									firstRailCarTrack = targetTrack
									firstRailCarTrackRoute = -1
									firstRailCarTrackPosition = targetTrackPosition
									firstRailCarTrackDirection = targetTrackDirection and 2 or 1
								else
									firstRailCarTrackPosition = PI + 2
									firstRailCarTrackPositionPortion = 1
									railCarCurrentSpeed = math.min(0, railCarCurrentSpeed)
									railCarDesiredTargetSpeed = math.min(0, railCarDesiredTargetSpeed)
									break
								end
							elseif firstRailCarTrackPosition >= PI + 1 then
								firstRailCarTrackPositionPortion = firstRailCarTrackPosition - (PI + 1) + 2
								break
							elseif firstRailCarTrackPosition >= 1 then
								firstRailCarTrackPositionPortion = (firstRailCarTrackPosition - 1) / PI + 1
								break
							elseif firstRailCarTrackPosition >= 0 then
								firstRailCarTrackPositionPortion = firstRailCarTrackPosition
								break
							elseif firstRailCarTrackPosition < 0 then
								local trackId = railSwitches[firstRailCarTrack]["trackIds"][firstRailCarTrackRoute]

								if trackId then
									local trackData = railTracks[trackId]
									local trackPosition = math.abs(firstRailCarTrackPosition)
									local trackDirection = railSwitchEnds[trackId] and railSwitchEnds[trackId][1] and railSwitchEnds[trackId][1]["switchId"] == firstRailCarTrack

									if firstRailCarTrackDirection == 1 then
										trackPosition = trackData.segmentLength - trackPosition
										trackDirection = not trackDirection
									end

									firstRailCarTrack = trackId
									firstRailCarTrackRoute = -1
									firstRailCarTrackPosition = trackPosition
									firstRailCarTrackDirection = trackDirection and 2 or 1
								else
									firstRailCarTrackPosition = 0
									firstRailCarTrackPositionPortion = 0
									railCarCurrentSpeed = math.max(0, railCarCurrentSpeed)
									railCarDesiredTargetSpeed = math.max(0, railCarDesiredTargetSpeed)
									break
								end
							else
								break
							end
						else
							firstRailCarTrackPositionPortion = firstRailCarTrackPosition / 6

							if firstRailCarTrackPositionPortion > 1 then
								local trackId = railSwitches[firstRailCarTrack]["trackIds"][switchRouteData.targetRoute]

								if trackId then
									local trackData = railTracks[trackId]
									local trackPosition = firstRailCarTrackPosition - 6
									local trackDirection = railSwitchEnds[trackId] and railSwitchEnds[trackId][1] and railSwitchEnds[trackId][1]["switchId"] == firstRailCarTrack

									if firstRailCarTrackDirection == 2 then
										trackPosition = trackData.segmentLength - trackPosition
										trackDirection = not trackDirection
									end

									firstRailCarTrack = trackId
									firstRailCarTrackRoute = -1
									firstRailCarTrackPosition = trackPosition
									firstRailCarTrackDirection = trackDirection and 2 or 1
								else
									firstRailCarTrackPosition = 6
									firstRailCarTrackPositionPortion = 1
									railCarCurrentSpeed = math.min(0, railCarCurrentSpeed)
									railCarDesiredTargetSpeed = math.min(0, railCarDesiredTargetSpeed)
									break
								end
							elseif firstRailCarTrackPositionPortion < 0 then
								local trackId = railSwitches[firstRailCarTrack]["trackIds"][firstRailCarTrackRoute]

								if trackId then
									local trackData = railTracks[trackId]
									local trackPosition = math.abs(firstRailCarTrackPosition)
									local trackDirection = railSwitchEnds[trackId] and railSwitchEnds[trackId][1] and railSwitchEnds[trackId][1]["switchId"] == firstRailCarTrack

									if firstRailCarTrackDirection == 1 then
										trackPosition = trackData.segmentLength - trackPosition
										trackDirection = not trackDirection
									end

									firstRailCarTrack = trackId
									firstRailCarTrackRoute = -1
									firstRailCarTrackPosition = trackPosition
									firstRailCarTrackDirection = trackDirection and 2 or 1
								else
									firstRailCarTrackPosition = 0
									firstRailCarTrackPositionPortion = 0
									railCarCurrentSpeed = math.max(0, railCarCurrentSpeed)
									railCarDesiredTargetSpeed = math.max(0, railCarDesiredTargetSpeed)
									break
								end
							else
								break
							end
						end
					else
						for routeId in pairs(switchRoutes) do
							firstRailCarTrackRoute = routeId
						end
					end
				else
					firstRailCarTrackRoute = -1
				end
			else
				local trackData = railTracks[firstRailCarTrack]

				if trackData then
					firstRailCarTrackPositionPortion = firstRailCarTrackPosition / trackData.segmentLength

					if firstRailCarTrackPositionPortion > 1 then
						local switchEnds = railSwitchEnds[firstRailCarTrack]

						if switchEnds then
							local switchEndData = railSwitchEnds[firstRailCarTrack][firstRailCarTrackDirection]

							if switchEndData then
								local switchData = railSwitches[switchEndData.switchId]

								if switchData then
									local switchType = #switchData.trackIds
									local switchState = railSwitchStates[switchEndData.switchId] or 1
									local switchTargetRoute = switchMatrix[switchType] and switchMatrix[switchType][switchState] and switchMatrix[switchType][switchState][switchEndData.routeId]

									if switchTargetRoute then
										firstRailCarTrack = switchEndData.switchId
										firstRailCarTrackRoute = switchEndData.routeId
										firstRailCarTrackPosition = firstRailCarTrackPosition - trackData.segmentLength
										firstRailCarTrackDirection = 1
									else
										firstRailCarTrackPosition = trackData.segmentLength
										firstRailCarTrackPositionPortion = 1
										railCarCurrentSpeed = math.min(0, railCarCurrentSpeed)
										railCarDesiredTargetSpeed = math.min(0, railCarDesiredTargetSpeed)
										break
									end
								else
									firstRailCarTrackPosition = trackData.segmentLength
									firstRailCarTrackPositionPortion = 1
									railCarCurrentSpeed = math.min(0, railCarCurrentSpeed)
									railCarDesiredTargetSpeed = math.min(0, railCarDesiredTargetSpeed)
									break
								end
							else
								firstRailCarTrackPosition = trackData.segmentLength
								firstRailCarTrackPositionPortion = 1
								railCarCurrentSpeed = math.min(0, railCarCurrentSpeed)
								railCarDesiredTargetSpeed = math.min(0, railCarDesiredTargetSpeed)
								break
							end
						else
							firstRailCarTrackPosition = trackData.segmentLength
							firstRailCarTrackPositionPortion = 1
							railCarCurrentSpeed = math.min(0, railCarCurrentSpeed)
							railCarDesiredTargetSpeed = math.min(0, railCarDesiredTargetSpeed)
							break
						end
					elseif firstRailCarTrackPositionPortion < 0 then
						local switchEnds = railSwitchEnds[firstRailCarTrack]

						if switchEnds then
							local switchEndData = railSwitchEnds[firstRailCarTrack][firstRailCarTrackDirection == 2 and 1 or 2]

							if switchEndData then
								local switchData = railSwitches[switchEndData.switchId]

								if switchData then
									local switchType = #switchData.trackIds
									local switchState = railSwitchStates[switchEndData.switchId] or 1
									local switchTargetRoute = switchMatrix[switchType] and switchMatrix[switchType][switchState] and switchMatrix[switchType][switchState][switchEndData.routeId]

									if switchTargetRoute then
										firstRailCarTrack = switchEndData.switchId
										firstRailCarTrackRoute = switchEndData.routeId
										firstRailCarTrackPosition = math.abs(firstRailCarTrackPosition)
										firstRailCarTrackDirection = 2
									else
										firstRailCarTrackPosition = 0
										firstRailCarTrackPositionPortion = 0
										railCarCurrentSpeed = math.max(0, railCarCurrentSpeed)
										railCarDesiredTargetSpeed = math.max(0, railCarDesiredTargetSpeed)
										break
									end
								else
									firstRailCarTrackPosition = 0
									firstRailCarTrackPositionPortion = 0
									railCarCurrentSpeed = math.max(0, railCarCurrentSpeed)
									railCarDesiredTargetSpeed = math.max(0, railCarDesiredTargetSpeed)
									break
								end
							else
								firstRailCarTrackPosition = 0
								firstRailCarTrackPositionPortion = 0
								railCarCurrentSpeed = math.max(0, railCarCurrentSpeed)
								railCarDesiredTargetSpeed = math.max(0, railCarDesiredTargetSpeed)
								break
							end
						else
							firstRailCarTrackPosition = 0
							firstRailCarTrackPositionPortion = 0
							railCarCurrentSpeed = math.max(0, railCarCurrentSpeed)
							railCarDesiredTargetSpeed = math.max(0, railCarDesiredTargetSpeed)
							break
						end
					else
						break
					end
				else
					break
				end
			end
		end

		local railCarX, railCarY, railCarRad, railCarCos, railCarSin = processRailCar(baseRailCar, firstRailCarTrackPositionPortion, firstRailCarTrack, firstRailCarTrackRoute, firstRailCarTrackDirection)

		if railCarX then
			firstRailCarX = railCarX
			firstRailCarY = railCarY
		end

		if railCarRad then
			firstRailCarRad = railCarRad
			firstRailCarCos = railCarCos
			firstRailCarSin = railCarSin
		else
			railCarRad = firstRailCarRad
			railCarCos = firstRailCarCos
			railCarSin = firstRailCarSin
		end

		lastRailCarTrack = firstRailCarTrack
		lastRailCarTrackRoute = firstRailCarTrackRoute
		lastRailCarTrackPosition = firstRailCarTrackPosition
		lastRailCarTrackDirection = firstRailCarTrackDirection

		local subCartTrack = firstRailCarTrack
		local subCartTrackRoute = firstRailCarTrackRoute
		local subCartTrackPosition = firstRailCarTrackPosition
		local subCartTrackDirection = firstRailCarTrackDirection
		local subCartTrackPositionPortion = firstRailCarTrackPositionPortion

		local sumCartPosX = firstRailCarX
		local sumCartPosY = firstRailCarY

		local cartPosListX = {firstRailCarX}
		local cartPosListY = {firstRailCarY}

		local numCarts = 1

		for i = 1, #subCartObjects do
			local railCarLength = (isDieselLocomotive and i == 1) and dieselLocoLength or mineCartLength

			if subCartTrackRoute > 0 and subCartTrackDirection == 2 then
				railCarLength = -railCarLength
			end

			subCartTrackPosition = subCartTrackPosition - railCarLength

			while true do
				if subCartTrackRoute > 0 then
					local switchRouteData = railSwitchRoutes[subCartTrack][subCartTrackRoute]

					if switchRouteData then
						railSwitchBusy[subCartTrack] = true

						if switchRouteData.curveAngle then
							if subCartTrackPosition > PI + 2 then
								local targetTrack = railSwitches[subCartTrack]["trackIds"][switchRouteData.targetRoute]

								if targetTrack then
									local targetTrackData = railTracks[targetTrack]
									local targetTrackPosition = subCartTrackPosition - (PI + 2)
									local targetTrackDirection = railSwitchEnds[targetTrack] and railSwitchEnds[targetTrack][1] and railSwitchEnds[targetTrack][1]["switchId"] == subCartTrack

									if subCartTrackDirection == 2 then
										targetTrackPosition = targetTrackData.segmentLength - targetTrackPosition
										targetTrackDirection = not targetTrackDirection
									end

									subCartTrack = targetTrack
									subCartTrackRoute = -1
									subCartTrackPosition = targetTrackPosition
									subCartTrackDirection = targetTrackDirection and 2 or 1
								else
									break
								end
							elseif subCartTrackPosition >= PI + 1 then
								subCartTrackPositionPortion = subCartTrackPosition - (PI + 1) + 2
								break
							elseif subCartTrackPosition >= 1 then
								subCartTrackPositionPortion = (subCartTrackPosition - 1) / PI + 1
								break
							elseif subCartTrackPosition >= 0 then
								subCartTrackPositionPortion = subCartTrackPosition
								break
							elseif subCartTrackPosition < 0 then
								local trackId = railSwitches[subCartTrack]["trackIds"][subCartTrackRoute]

								if trackId then
									local trackData = railTracks[trackId]
									local trackPosition = math.abs(subCartTrackPosition)
									local trackDirection = railSwitchEnds[trackId] and railSwitchEnds[trackId][1] and railSwitchEnds[trackId][1]["switchId"] == subCartTrack

									if subCartTrackDirection == 1 then
										trackPosition = trackData.segmentLength - trackPosition
										trackDirection = not trackDirection
									end

									subCartTrack = trackId
									subCartTrackRoute = -1
									subCartTrackPosition = trackPosition
									subCartTrackDirection = trackDirection and 2 or 1
								else
									break
								end
							else
								break
							end
						else
							subCartTrackPositionPortion = subCartTrackPosition / 6

							if subCartTrackPositionPortion > 1 then
								local trackId = railSwitches[subCartTrack]["trackIds"][switchRouteData.targetRoute]

								if trackId then
									local trackData = railTracks[trackId]
									local trackPosition = subCartTrackPosition - 6
									local trackDirection = railSwitchEnds[trackId] and railSwitchEnds[trackId][1] and railSwitchEnds[trackId][1]["switchId"] == subCartTrack

									if subCartTrackDirection == 2 then
										trackPosition = trackData.segmentLength - trackPosition
										trackDirection = not trackDirection
									end

									subCartTrack = trackId
									subCartTrackRoute = -1
									subCartTrackPosition = trackPosition
									subCartTrackDirection = trackDirection and 2 or 1
								else
									break
								end
							elseif subCartTrackPositionPortion < 0 then
								local trackId = railSwitches[subCartTrack]["trackIds"][subCartTrackRoute]

								if trackId then
									local trackData = railTracks[trackId]
									local trackPosition = math.abs(subCartTrackPosition)
									local trackDirection = railSwitchEnds[trackId] and railSwitchEnds[trackId][1] and railSwitchEnds[trackId][1]["switchId"] == subCartTrack

									if subCartTrackDirection == 1 then
										trackPosition = trackData.segmentLength - trackPosition
										trackDirection = not trackDirection
									end

									subCartTrack = trackId
									subCartTrackRoute = -1
									subCartTrackPosition = trackPosition
									subCartTrackDirection = trackDirection and 2 or 1
								else
									break
								end
							else
								break
							end
						end
					else
						break
					end
				else
					local trackData = railTracks[subCartTrack]

					if trackData then
						subCartTrackPositionPortion = subCartTrackPosition / trackData.segmentLength

						if subCartTrackPositionPortion < 0 then
							local switchEnds = railSwitchEnds[subCartTrack]

							if switchEnds then
								local switchEndData = railSwitchEnds[subCartTrack][subCartTrackDirection == 2 and 1 or 2]

								if switchEndData then
									local switchData = railSwitches[switchEndData.switchId]

									if switchData then
										local switchType = #switchData.trackIds
										local switchState = railSwitchStates[switchEndData.switchId] or 1
										local switchTargetRoute = switchMatrix[switchType] and switchMatrix[switchType][switchState] and switchMatrix[switchType][switchState][switchEndData.routeId]

										if switchTargetRoute then
											local switchRouteData = railSwitchRoutes[switchEndData.switchId][switchTargetRoute]

											if switchRouteData then
												subCartTrackDirection = 1

												if switchRouteData.curveAngle then
													subCartTrackPosition = subCartTrackPosition + (PI + 2)
												else
													subCartTrackPosition = subCartTrackPosition + 6
												end

												subCartTrack = switchEndData.switchId
												subCartTrackRoute = switchTargetRoute
											else
												railCarCurrentSpeed = math.max(0, railCarCurrentSpeed)
												railCarDesiredTargetSpeed = math.max(0, railCarDesiredTargetSpeed)
												firstRailCarTrackPosition = firstRailCarTrackPosition - subCartTrackPosition
												subCartTrackPosition = 0
												break
											end
										else
											railCarCurrentSpeed = math.max(0, railCarCurrentSpeed)
											railCarDesiredTargetSpeed = math.max(0, railCarDesiredTargetSpeed)
											firstRailCarTrackPosition = firstRailCarTrackPosition - subCartTrackPosition
											subCartTrackPosition = 0
											break
										end
									else
										railCarCurrentSpeed = math.max(0, railCarCurrentSpeed)
										railCarDesiredTargetSpeed = math.max(0, railCarDesiredTargetSpeed)
										firstRailCarTrackPosition = firstRailCarTrackPosition - subCartTrackPosition
										subCartTrackPosition = 0
										break
									end
								else
									railCarCurrentSpeed = math.max(0, railCarCurrentSpeed)
									railCarDesiredTargetSpeed = math.max(0, railCarDesiredTargetSpeed)
									firstRailCarTrackPosition = firstRailCarTrackPosition - subCartTrackPosition
									subCartTrackPosition = 0
									break
								end
							else
								railCarCurrentSpeed = math.max(0, railCarCurrentSpeed)
								railCarDesiredTargetSpeed = math.max(0, railCarDesiredTargetSpeed)
								firstRailCarTrackPosition = firstRailCarTrackPosition - subCartTrackPosition
								subCartTrackPosition = 0
								break
							end
						else
							break
						end
					else
						break
					end
				end
			end

			lastRailCarTrack = subCartTrack
			lastRailCarTrackRoute = subCartTrackRoute
			lastRailCarTrackPosition = subCartTrackPosition
			lastRailCarTrackDirection = subCartTrackDirection

			railCarX, railCarY, railCarRad, railCarCos, railCarSin = processRailCar(subCartObjects[i], subCartTrackPositionPortion, subCartTrack, subCartTrackRoute, subCartTrackDirection)

			sumCartPosX = sumCartPosX + railCarX
			sumCartPosY = sumCartPosY + railCarY

			local railCarId = i + (isDieselLocomotive and 0 or 1)

			cartPosListX[railCarId] = railCarX
			cartPosListY[railCarId] = railCarY

			numCarts = numCarts + 1
		end

		if isElement(railCarRollSound) then
			setElementPosition(railCarRollSound, sumCartPosX / numCarts, sumCartPosY / numCarts, minePosZ)
		end

		lastRailCarX = railCarX
		lastRailCarY = railCarY

		if railCarRad then
			lastRailCarRad = railCarRad
			lastRailCarCos = railCarCos
			lastRailCarSin = railCarSin
		else
			lastRailCarRad = firstRailCarRad
			lastRailCarCos = firstRailCarCos
			lastRailCarSin = firstRailCarSin
		end

		if railCarDesiredSpeed ~= railCarDesiredTargetSpeed then
			railCarDesiredSpeed = railCarDesiredTargetSpeed

			if isRailCarController and not isDieselLocomotive then
				exports.sControls:toggleControl({"fire", "crouch", "aim_weapon", "jump", "jog"}, math.abs(railCarDesiredSpeed) <= 0, "minecartPush")
			end
		end

		for fixOreId in pairs(fixOreCarts) do
			local cartId = fixOreCarts[fixOreId][1]

			if not cartPosListX[cartId] then
				if isElement(cartTurtleObjects[cartId]) then
					cartPosListX[cartId], cartPosListY[cartId] = getElementPosition(cartTurtleObjects[cartId])
				end
			end

			setFixOrePosition(fixOreId, cartPosListX[cartId], cartPosListY[cartId])
		end
	end

	local canPushCart = false

	if not isDieselLocomotive and not carryingFixOre and not emptyingTurtle and getKeyState("space") then
		canPushCart = checkMinePermission(permissionFlags.USE_RAILCAR)
	end

	if isRailCarController then
		local desiredSpeed = 0
		local removeSyncer = false

		if isDieselLocomotive then
			if locoDesiredThrottle < 0 then
				if not isLastRailCarAtTrackEnd() then
					desiredSpeed = locoDesiredThrottle
				end
			elseif locoDesiredThrottle > 0 then
				if not isFirstRailCarAtTrackEnd() then
					desiredSpeed = locoDesiredThrottle
				end
			end
		elseif canPushCart then
			if getDistanceBetweenPoints2D(selfPosX, selfPosY, firstRailCarX + firstRailCarCos, firstRailCarY + firstRailCarSin) <= 0.5 then
				if not isLastRailCarAtTrackEnd() then
					desiredSpeed = -1.5
				end
			elseif getDistanceBetweenPoints2D(selfPosX, selfPosY, lastRailCarX - lastRailCarCos, lastRailCarY - lastRailCarSin) <= 0.5 then
				if not isFirstRailCarAtTrackEnd() then
					desiredSpeed = 1.5
				end
			end
		end

		if railCarDesiredSpeed ~= desiredSpeed then
			railCarDesiredSpeed = desiredSpeed

			if not isDieselLocomotive then
				exports.sControls:toggleControl({"fire", "crouch", "aim_weapon", "jump", "jog"}, math.abs(desiredSpeed) <= 0, "minecartPush")
			end
		end

		if math.abs(railCarCurrentSpeed) <= 0 then
			if isDieselLocomotive then
				removeSyncer = locoExitProcess
			elseif desiredSpeed == 0 then
				removeSyncer = true
			end
		end

		if removeSyncer and not isDieselLocomotive then
			isRailCarControllable = false
		end

		local desiredSpeedChanged = railCarDesiredSpeed ~= syncedDesiredSpeed
		local currentSpeedChanged = railCarCurrentSpeed ~= syncedRailCarCurrentSpeed

		local trackPositionChanged = firstRailCarTrackPosition ~= syncedTrackPosition
		local trackDirectionChanged = firstRailCarTrackDirection ~= syncedTrackDirection

		local trackChanged = firstRailCarTrack ~= syncedRailCarTrack
		local routeChanged = firstRailCarTrackRoute ~= syncedRailCarTrackRoute

		local syncDelta = mineTick - railCarLastSyncTime

		if (desiredSpeedChanged or (currentSpeedChanged or trackPositionChanged) and syncDelta > 5000) or (trackChanged or routeChanged or trackDirectionChanged or isRailCarControllable or locoExitProcess or syncDelta > 50000) and syncDelta >= 50 then
			if removeSyncer then
				if railCarDesiredSpeed ~= 0 then
					railCarDesiredSpeed = 0
					desiredSpeedChanged = true
				end
			end

			syncedDesiredSpeed = railCarDesiredSpeed
			syncedRailCarCurrentSpeed = railCarCurrentSpeed

			syncedTrackPosition = firstRailCarTrackPosition
			syncedTrackDirection = firstRailCarTrackDirection

			syncedRailCarTrack = firstRailCarTrack
			syncedRailCarTrackRoute = firstRailCarTrackRoute

			triggerServerEvent("mineRailSyncing",
				localPlayer,
				desiredSpeedChanged and railCarDesiredSpeed,
				currentSpeedChanged and railCarCurrentSpeed,
				trackPositionChanged and firstRailCarTrackPosition,
				trackDirectionChanged and firstRailCarTrackDirection,
				trackChanged and firstRailCarTrack,
				routeChanged and firstRailCarTrackRoute,
				removeSyncer
			)

			railCarLastSyncTime = mineTick
			isRailCarControllable = false

			if removeSyncer then
				isRailCarController = false
			end

			locoExitProcess = false
		end
	elseif not railCarSyncedBy and not isDieselLocomotive then
		if canPushCart then
			if getDistanceBetweenPoints2D(selfPosX, selfPosY, firstRailCarX + firstRailCarCos, firstRailCarY + firstRailCarSin) <= 0.5 then
				if not isLastRailCarAtTrackEnd() then
					isRailCarController = true
					isRailCarControllable = true
				end
			elseif getDistanceBetweenPoints2D(selfPosX, selfPosY, lastRailCarX - lastRailCarCos, lastRailCarY - lastRailCarSin) <= 0.5 then
				if not isFirstRailCarAtTrackEnd() then
					isRailCarController = true
					isRailCarControllable = true
				end
			end
		end
	end

	if isElement(railCarRollSound) then
		setSoundSpeed(railCarRollSound, 0.65 + math.abs(railCarCurrentSpeed) / 4)
		setSoundVolume(railCarRollSound, math.min(1, math.abs(railCarCurrentSpeed) * 0.9))
	end

	if isDieselLocomotive then
		preRenderDieselLoco(deltaTime)
	end
end

function preRenderDieselLoco(deltaTime)
	if isElement(railCarSyncedBy) then
		attachElements(railCarSyncedBy, baseRailCar, 0.5823, 0.4, 1.28)
		setElementRotation(railCarSyncedBy, 0, 0, math.deg(firstRailCarRad), "default", true)

		if isElementStreamedIn(railCarSyncedBy) then
			local animBlock, animName = getPedAnimation(railCarSyncedBy)

			animBlock = animBlock and utf8.lower(animBlock)
			animName = animName and utf8.lower(animName)

			if animBlock ~= "ped" or animName ~= "seat_idle" then
				setPedAnimation(railCarSyncedBy, "ped", "seat_idle", -1, true, false, false)
			end
		end
	end

	for spotId, clientId in pairs(locoPassengerBySeat) do
		local spotData = locoPassengerSpots[spotId]

		if spotData then
			attachElements(clientId, baseRailCar, spotData[1], spotData[2], spotData[3])
			setElementRotation(clientId, 0, 0, math.deg(firstRailCarRad) + spotData[4], "default", true)

			if isElementStreamedIn(clientId) then
				local animBlock, animName = getPedAnimation(clientId)

				animBlock = animBlock and utf8.lower(animBlock)
				animName = animName and utf8.lower(animName)

				if animBlock ~= spotData[5] or animName ~= spotData[6] then
					setPedAnimation(clientId, spotData[5], spotData[6], -1, true, false, false)
				end
			end
		end
	end

	if railCarSyncedBy and isLocoHasFuel() then
		if not locoEngineStart then
			locoEngineStart = mineTick

			if not locoEngineSound then
				locoEngineSound = playSound3D("files/sounds/locoloop.mp3", 0, 0, 0, true)

				if isElement(locoEngineSound) then
					setElementInterior(locoEngineSound, 0)
					setElementDimension(locoEngineSound, currentMine)
					attachElements(locoEngineSound, baseRailCar, -0.5, 0, 1)
					setSoundVolume(locoEngineSound, 0)
					setSoundMaxDistance(locoEngineSound, 40)
				end
			end

			if not locoBrakeSound then
				locoBrakeSound = playSound3D("files/sounds/locobrake.mp3", 0, 0, 0, true)

				if isElement(locoBrakeSound) then
					setElementInterior(locoBrakeSound, 0)
					setElementDimension(locoBrakeSound, currentMine)
					attachElements(locoBrakeSound, baseRailCar, -0.5, 0, 1)
					setSoundVolume(locoBrakeSound, 0)
					setSoundMaxDistance(locoBrakeSound, 60)
				end
			end

			local engineStartSound = playSound3D("files/sounds/locostart.mp3", 0, 0, 0, false)

			if isElement(engineStartSound) then
				setElementInterior(engineStartSound, 0)
				setElementDimension(engineStartSound, currentMine)
				attachElements(engineStartSound, baseRailCar, -0.5, 0, 1)
				setSoundMaxDistance(engineStartSound, 40)
			end
		end

		local elapsedTime = mineTick - locoEngineStart

		if elapsedTime > 1580 then
			locoEngineRev = 1 + math.abs(railCarCurrentSpeed / 8)

			if isElement(locoEngineSound) then
				setSoundVolume(locoEngineSound, math.min(1, elapsedTime / 190))
			end

			if locoIsBraking then
				if locoBrakePower < 1 then
					locoBrakePower = locoBrakePower + 2 * deltaTime

					if locoBrakePower > 1 then
						locoBrakePower = 1
					end
				end
			elseif locoBrakePower > 0 then
				locoBrakePower = locoBrakePower - 2 * deltaTime

				if locoBrakePower < 0 then
					locoBrakePower = 0
				end
			end

			if locoBrakePower > 0 then
				if isElement(locoBrakeSound) then
					setSoundVolume(locoBrakeSound, math.min(1, math.abs(railCarCurrentSpeed) * 2) * locoBrakePower)
				end

				if math.random() <= locoBrakePower * math.abs(railCarCurrentSpeed / 4) then
					local offsetX = firstRailCarSin * 0.35
					local offsetY = firstRailCarCos * 0.35
					local offsetZ = 0.14

					for i = 1, 2 do
						local wheelX, wheelY, wheelZ = getElementPosition(cartWheelObjects[i])

						if wheelZ then
							local sparkAngle = firstRailCarRad + math.pi / 7 * (math.random() * 2 - 1)
							local sparkVectorX = math.cos(sparkAngle) * (railCarCurrentSpeed > 0 and -3 or 3)
							local sparkVectorY = math.sin(sparkAngle) * (railCarCurrentSpeed > 0 and -3 or 3)

							spawnSparkParticle(wheelX - offsetX, wheelY + offsetY, wheelZ - offsetZ, sparkVectorX, sparkVectorY, math.random() * 0.25, 250 + math.random() * 500, 200 + math.random() * 55, 0.025 + math.random() * 0.025, 0.001 + math.random() * 0.001)
							spawnSparkParticle(wheelX + offsetX, wheelY - offsetY, wheelZ - offsetZ, sparkVectorX, sparkVectorY, math.random() * 0.25, 250 + math.random() * 500, 200 + math.random() * 55, 0.025 + math.random() * 0.025, 0.001 + math.random() * 0.001)
						end
					end
				end
			elseif isElement(locoBrakeSound) then
				setSoundVolume(locoBrakeSound, 0)
			end
		else
			locoEngineRev = elapsedTime / 1580
		end

		if isElement(locoEngineSound) then
			setSoundSpeed(locoEngineSound, locoEngineRev)
		end
	elseif locoEngineStart then
		locoDesiredThrottle = 0

		if locoEngineRev > 1 then
			locoEngineRev = locoEngineRev - deltaTime

			if locoEngineRev < 1 then
				locoEngineRev = 1
			end
		end

		if isElement(locoEngineSound) then
			setSoundSpeed(locoEngineSound, locoEngineRev)
		end

		if locoBrakePower < 1 then
			locoBrakePower = locoBrakePower + 2 * deltaTime

			if locoBrakePower > 1 then
				locoBrakePower = 1
			end
		end

		if isElement(locoBrakeSound) then
			setSoundVolume(locoBrakeSound, math.min(1, math.abs(railCarCurrentSpeed) * 2) * locoBrakePower)
		end

		if locoEngineRev <= 1 then
			local elapsedTime = mineTick - locoEngineStart

			if elapsedTime > 1580 then
				local engineStopSound = playSound3D("files/sounds/locostop.mp3", 0, 0, 0, false)

				if isElement(engineStopSound) then
					setElementInterior(engineStopSound, 0)
					setElementDimension(engineStopSound, currentMine)
					attachElements(engineStopSound, baseRailCar)
					setSoundMaxDistance(engineStopSound, 40)
				end

				locoEngineStart = false

				if isElement(locoEngineSound) then
					destroyElement(locoEngineSound)
				end

				locoEngineSound = nil
			end
		end
	else
		if locoBrakeSound then
			if railCarCurrentSpeed ~= 0 then
				if locoBrakePower < 1 then
					locoBrakePower = locoBrakePower + 2 * deltaTime

					if locoBrakePower > 1 then
						locoBrakePower = 1
					end
				end

				if isElement(locoBrakeSound) then
					setSoundVolume(locoBrakeSound, math.min(1, math.abs(railCarCurrentSpeed) * 2) * locoBrakePower)
				end
			elseif railCarCurrentSpeed == 0 then
				if isElement(locoBrakeSound) then
					destroyElement(locoBrakeSound)
				end

				locoBrakeSound = nil
			end
		end

		if locoEngineRev > 0 then
			locoEngineRev = locoEngineRev - 4 * deltaTime

			if locoEngineRev < 0 then
				locoEngineRev = 0
			end
		end
	end

	if isRailCarController then
		local throttleWas = locoCurrentThrottle

		if locoCurrentThrottle > locoDesiredThrottle then
			locoCurrentThrottle = locoCurrentThrottle - 10 * deltaTime

			if locoCurrentThrottle < locoDesiredThrottle then
				locoCurrentThrottle = locoDesiredThrottle
			end

			if math.floor(locoCurrentThrottle) ~= math.floor(throttleWas) then
				playSound("files/sounds/locothrottle.mp3")
			end
		elseif locoCurrentThrottle < locoDesiredThrottle then
			locoCurrentThrottle = locoCurrentThrottle + 10 * deltaTime

			if locoCurrentThrottle > locoDesiredThrottle then
				locoCurrentThrottle = locoDesiredThrottle
			end

			if math.floor(locoCurrentThrottle) ~= math.floor(throttleWas) then
				playSound("files/sounds/locothrottle.mp3")
			end
		end
	end
end

function isLocoHasFuel()
	return locoFuel > 0 and locoFuel <= locoDisplayedFuel
end

function isFirstRailCarAtTrackEnd()
	local trackLength = 0

	if firstRailCarTrackRoute <= 0 then
		if railTracks[firstRailCarTrack] then
			trackLength = railTracks[firstRailCarTrack]["segmentLength"]
		end
	elseif railSwitchRoutes[firstRailCarTrack] and railSwitchRoutes[firstRailCarTrack][firstRailCarTrackRoute] and railSwitchRoutes[firstRailCarTrack][firstRailCarTrackRoute]["curveAngle"] then
		trackLength = PI + 2
	else
		trackLength = 6
	end

	if firstRailCarTrackPosition < trackLength then
		return false
	elseif firstRailCarTrackRoute > 0 then
		local switchRoutes = railSwitchRoutes[firstRailCarTrack]

		if switchRoutes then
			local switchRouteData = switchRoutes[firstRailCarTrackRoute]

			if switchRouteData and switchRouteData.curveAngle then
				local targetTrack = railSwitches[firstRailCarTrack]["trackIds"][switchRouteData.targetRoute]

				if targetTrack then
					return false
				end
			end
		end
	elseif railTracks[firstRailCarTrack] then
		local switchEnds = railSwitchEnds[firstRailCarTrack]

		if switchEnds then
			local switchEndData = railSwitchEnds[firstRailCarTrack][firstRailCarTrackDirection]

			if switchEndData then
				local switchData = railSwitches[switchEndData.switchId]

				if switchData then
					local switchType = #switchData.trackIds
					local switchState = railSwitchStates[switchEndData.switchId] or 1

					if switchMatrix[switchType] and switchMatrix[switchType][switchState] and switchMatrix[switchType][switchState][switchEndData.routeId] then
						return false
					end
				end
			end
		end
	end

	return true
end

function isLastRailCarAtTrackEnd()
	if lastRailCarTrackPosition > 0 then
		return false
	elseif lastRailCarTrackRoute > 0 then
		if railSwitches[lastRailCarTrack]["trackIds"][lastRailCarTrackRoute] then
			return false
		end
	elseif railTracks[lastRailCarTrack] then
		local switchEnds = railSwitchEnds[lastRailCarTrack]

		if switchEnds then
			local switchEndData = switchEnds[lastRailCarTrackDirection == 2 and 1 or 2]

			if switchEndData then
				local switchData = railSwitches[switchEndData.switchId]

				if switchData then
					local switchType = #switchData.trackIds
					local switchState = railSwitchStates[switchEndData.switchId] or 1

					if switchMatrix[switchType] and switchMatrix[switchType][switchState] and switchMatrix[switchType][switchState][switchEndData.routeId] then
						return false
					end
				end
			end
		end
	end
	return true
end

function processRailCar(objectElement, positionPortion, trackId, routeId, trackDirection)
	local posX, posY, radZ, cosZ, sinZ

	if routeId > 0 then
		local switchData = railSwitches[trackId]

		if switchData then
			posX = switchData.worldX
			posY = switchData.worldY

			if railSwitchRoutes[trackId] then
				local switchRouteData = railSwitchRoutes[trackId][routeId]

				if switchRouteData then
					posX = posX + switchRouteData.offsetX
					posY = posY + switchRouteData.offsetY

					if switchRouteData.curveAngle then
						local rotZ = switchRouteData.curveAngle
						local rotX = 0

						if positionPortion >= 2 then
							rotZ = rotZ + switchRouteData.curveDirSign * PI_2
						elseif positionPortion >= 1 then
							rotZ = rotZ + switchRouteData.curveDirSign * PI_2 * (positionPortion - 1)
						end

						if positionPortion >= 1 and positionPortion < 2 then
							rotX = -switchRouteData.curveDirSign * 3.5 * math.sin((positionPortion - 1) * PI)
						end

						local cosAngle = math.cos(rotZ)
						local sinAngle = math.sin(rotZ)

						posX = posX + cosAngle * 2
						posY = posY + sinAngle * 2

						if positionPortion >= 2 then
							posX = posX - sinAngle * (positionPortion - 2) * switchRouteData.curveDirSign
							posY = posY + cosAngle * (positionPortion - 2) * switchRouteData.curveDirSign
						elseif positionPortion <= 1 then
							posX = posX + sinAngle * (1 - positionPortion) * switchRouteData.curveDirSign
							posY = posY - cosAngle * (1 - positionPortion) * switchRouteData.curveDirSign
						end

						rotZ = rotZ + switchRouteData.curveDirSign * PI_2

						if trackDirection == 2 then
							rotZ = rotZ + PI
							rotX = -rotX
						end

						radZ = rotZ
						cosZ = math.cos(rotZ)
						sinZ = math.sin(rotZ)

						if isElement(objectElement) then
							setElementRotation(objectElement, rotX, 0, math.deg(rotZ))
						end
					else
						local trackRad = math.atan2(-switchRouteData.offsetY, -switchRouteData.offsetX)

						if trackDirection == 2 then
							trackRad = trackRad + PI
						end

						posX = posX - switchRouteData.offsetX * 2 * positionPortion
						posY = posY - switchRouteData.offsetY * 2 * positionPortion

						radZ = trackRad
						cosZ = math.cos(trackRad)
						sinZ = math.sin(trackRad)

						if isElement(objectElement) then
							setElementRotation(objectElement, 0, 0, math.deg(trackRad))
						end
					end
				end
			end

			if isElement(objectElement) then
				setElementPosition(objectElement, posX, posY, minePosZ)
			end
		end
	else
		local trackData = railTracks[trackId]

		if trackData then
			if trackDirection == 1 then
				posX = trackData.startPosX * (1 - positionPortion) + trackData.finalPosX * positionPortion
				posY = trackData.startPosY * (1 - positionPortion) + trackData.finalPosY * positionPortion
			else
				posX = trackData.finalPosX * (1 - positionPortion) + trackData.startPosX * positionPortion
				posY = trackData.finalPosY * (1 - positionPortion) + trackData.startPosY * positionPortion
			end

			if isElement(objectElement) then
				setElementPosition(objectElement, posX, posY, minePosZ)

				if trackDirection == 1 then
					setElementRotation(objectElement, 0, 0, trackData.angleDeg)
				else
					setElementRotation(objectElement, 0, 0, trackData.angleDeg + 180)
				end
			end

			radZ = trackData.angleRad + (trackDirection == 2 and PI or 0)
			cosZ = trackData.angleCos * (trackDirection == 2 and -1 or 1)
			sinZ = trackData.angleSin * (trackDirection == 2 and -1 or 1)
		end
	end

	return posX, posY, radZ, cosZ, sinZ
end

function processRailCarSync(syncData, forceRefresh)
	local previousSyncer = false

	if isElement(railCarSyncedBy) then
		previousSyncer = railCarSyncedBy
	end

	if isDieselLocomotive then
		if not isElement(syncData.currentSyncer) or syncData.currentSyncer ~= railCarSyncedBy then
			if isElement(railCarSyncedBy) then
				detachElements(railCarSyncedBy, baseRailCar)
				setElementPosition(railCarSyncedBy, firstRailCarX + firstRailCarCos * 1.65, firstRailCarY + firstRailCarSin * 1.65, minePosZ + 1)
				setPedAnimation(railCarSyncedBy)
			end
		end
	end

	if not isElement(syncData.currentSyncer) then
		railCarSyncedBy = nil
		isRailCarController = false
	elseif syncData.currentSyncer ~= railCarSyncedBy then
		railCarSyncedBy = syncData.currentSyncer

		if railCarSyncedBy == localPlayer then
			if isDieselLocomotive then
				exports.sGui:showInfobox("i", "A [Backspace] gomb megnyomásával tudsz kiszállni a mozdonyból.")
			end
		end

		if railCarSyncedBy ~= previousSyncer then
			processTablet(railCarSyncedBy)
		end
	end

	if previousSyncer then
		processTablet(previousSyncer)
	end

	if not isRailCarController or forceRefresh then
		if syncData.desiredSpeed then
			railCarDesiredSpeed = syncData.desiredSpeed
		end

		if syncData.currentSpeed then
			railCarCurrentSpeed = syncData.currentSpeed
		end

		if syncData.trackPosition then
			firstRailCarTrackPosition = syncData.trackPosition
		end

		if syncData.trackDirection then
			firstRailCarTrackDirection = syncData.trackDirection
		end

		if syncData.routeId then
			firstRailCarTrackRoute = syncData.routeId
		end

		if syncData.trackId then
			firstRailCarTrack = syncData.trackId

			if firstRailCarTrackRoute <= 0 then
				local trackData = railTracks[firstRailCarTrack]

				if trackData then
					if isElement(baseRailCar) then
						setElementRotation(baseRailCar, 0, 0, trackData.angleDeg + (firstRailCarTrackDirection == 2 and 180 or 0))
					end

					firstRailCarRad = trackData.angleRad + (firstRailCarTrackDirection == 2 and PI or 0)
					firstRailCarCos = trackData.angleCos * (firstRailCarTrackDirection == 2 and -1 or 1)
					firstRailCarSin = trackData.angleSin * (firstRailCarTrackDirection == 2 and -1 or 1)
				end
			end
		end

		forceRefreshTrain = true
	end

	if syncData.fuelLevel then
		locoFuel = syncData.fuelLevel
	end
end

function processJerrycanSync(carryingPlayer)
	local previousCarryingPlayer = false

	if isElement(currentMineInventory.jerryCarry) then
		if currentMineInventory.jerryCarry ~= carryingPlayer then
			previousCarryingPlayer = currentMineInventory.jerryCarry
		end
	end

	if carryingPlayer or previousCarryingPlayer then
		local soundEffect = playSound3D(
			"files/sounds/boxpick.mp3",
			firstRailCarX + firstRailCarCos * 0.2962 + firstRailCarSin * 0.3895,
			firstRailCarY + firstRailCarSin * 0.2962 - firstRailCarCos * 0.3895,
			minePosZ + 1.0215
		)

		if isElement(soundEffect) then
			setElementInterior(soundEffect, 0)
			setElementDimension(soundEffect, currentMine)
		end
	end

	currentMineInventory.jerryCarry = carryingPlayer

	if isElement(currentMineInventory.jerryCan) then
		detachElements(currentMineInventory.jerryCan, baseRailCar)
		exports.sPattach:detach(currentMineInventory.jerryCan)

		if isElement(carryingPlayer) then
			exports.sPattach:setRotationQuaternion(currentMineInventory.jerryCan, {
				-0.65756056016113,
				-0.00059150496394346,
				-0.74986380237192,
				-0.072924877338126
			})
			exports.sPattach:attach(currentMineInventory.jerryCan, carryingPlayer, 24, -0.024296469110261, 0.022205276760886, 0.054280599316097, -90, 0, 180)
			processTablet(carryingPlayer)
		else
			setElementInterior(currentMineInventory.jerryCan, 0)
			setElementDimension(currentMineInventory.jerryCan, currentMine)
			attachElements(currentMineInventory.jerryCan, baseRailCar, 0.2962, -0.3895, 1.0215, 0, 0, 86.193)
		end
	end

	if previousCarryingPlayer then
		processTablet(previousCarryingPlayer)
	end
end

function processLocoFuelSync(fuelLevel, fuelingTime)
	locoFuel = fuelLevel

	if isElement(source) and fuelingTime then
		local tankX = firstRailCarX - firstRailCarCos * 0.0399 + firstRailCarSin * 0.5469
		local tankY = firstRailCarY - firstRailCarSin * 0.0399 - firstRailCarCos * 0.5469
		local tankZ = minePosZ + 1.0215

		setPedHeadingTo(source, tankX, tankY)
		setPedAnimation(source, "mining_fill_diesel", "idle_armed", -1, true, false, false, false, 250, false)

		setTimer(
			function (clientId)
				if isElement(clientId) then
					setPedAnimation(clientId)
				end
			end,
		fuelingTime, 1, source)
	end
end

function getRelativeFirstRailCarPosition()
	return convertMineCoordinates(firstRailCarX - minePosX, firstRailCarY - minePosY)
end

function getFirstRailCarPosition()
	return firstRailCarX, firstRailCarY, firstRailCarCos, firstRailCarSin
end

function getLocoEngineRev()
	return locoEngineRev
end