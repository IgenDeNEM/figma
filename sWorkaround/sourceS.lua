local trailerDetails = {}
local trailerElements = {}
local trailerContents = {}
local rentalTimeout = 15

local playerContainer = {}
local playerRentedTrailer = {}

local rentalTimer = false

local towedTrailerByTractor = {}
local towingTractorByTrailer = {}

local spawnPoints = {
	{ 2393.3037109375, -2125.1752929688, 13.51070690155, 0, 0, 270 },
	{ 2393.3037109375, -2128.6752929688, 13.51070690155, 0, 0, 270 },
	{ 2393.3037109375, -2118.1752929688, 13.51070690155, 0, 0, 270 },
	{ 2393.3037109375, -2114.6752929688, 13.51070690155, 0, 0, 270 },
	{ 2393.3037109375, -2107.6752929688, 13.51070690155, 0, 0, 270 },
	{ 2393.3037109375, -2104.1752929688, 13.51070690155, 0, 0, 270 },
	{ 2393.3037109375, -2097.1752929688, 13.51070690155, 0, 0, 270 },
	{ 2393.3037109375, -2093.6752929688, 13.51070690155, 0, 0, 270 },
	{ 2393.3037109375, -2086.6752929688, 13.51070690155, 0, 0, 270 },
	{ 2393.3037109375, -2083.1752929688, 13.51070690155, 0, 0, 270 },
	{ 2393.3037109375, -2076.1752929688, 13.51070690155, 0, 0, 270 },
	{ 2393.3037109375, -2072.6752929688, 13.51070690155, 0, 0, 270 }
}

function getPrioritySpawnPoint()
	local bestSpawnPoint = nil
	local bestScore = -1

	for i = 1, #spawnPoints do
		local spawnPointData = spawnPoints[i]

		if not spawnPointData.isReserved then
			local spawnPointScore = getTickCount() - (spawnPointData.lastUseTime or 0)

			if spawnPointScore > bestScore then
				bestSpawnPoint = i
				bestScore = spawnPointScore
			end
		end
	end

	if bestSpawnPoint then
		local spawnPointData = spawnPoints[bestSpawnPoint]

		spawnPointData.isReserved = true
		spawnPointData.lastUseTime = getTickCount()

		setTimer(
			function ()
				spawnPointData.isReserved = nil
			end,
		30 * 1000, 1)

		return spawnPointData
	end

	return false
end

function getAttachedTrailer(tractorVehicle)
	return getElementData(tractorVehicle, "towCar")
end

function getAttachedTractor(trailerVehicle)
	return towingTractorByTrailer[trailerVehicle]
end

function isTrailerEmpty(trailerVehicle)
	return trailerContents[trailerVehicle] == nil
end

function getTrailerData(trailerVehicle)
	return trailerContents[trailerVehicle] or getElementData(trailerVehicle, "mineOrderOnTrailer") or getElementData(trailerVehicle, "mineTankOnTrailer")
end

function setTrailerData(trailerVehicle, newContentData, otherVariant)
	if newContentData and tonumber(newContentData[1]) and not newContentData[2] then
    	setElementData(trailerVehicle, "mineTankOnTrailer", newContentData)
	else
		setElementData(trailerVehicle, "vehicle.fuel", trailerFuel)
    	setElementData(trailerVehicle, "mineOrderOnTrailer", newContentData)
		if not newContentData then
			setElementData(trailerVehicle, "mineTankOnTrailer", newContentData)
		end
	end
    trailerContents[trailerVehicle] = newContentData
    return true
end

function isValidClient(clientElement, sourceElement)
	if clientElement then
		if clientElement ~= sourceElement then
			return false
		end
	end

	return true
end

function canRentTrailer(playerSource)
	--[[
	if exports.see_farm:canRentTrailer(playerSource) then
		return true
	end

	if exports.see_paintshop:canRentTrailer(playerSource) then
		return true
	end

	if exports.see_mining:canRentTrailer(playerSource) then
		return true
	end
	]]

	return true
end

--Handlers
addEvent("canRentTrailer", true)
addEventHandler("canRentTrailer", root,
	function ()
		if isValidClient(client, source) then
			local characterId = getElementData(client, "char.ID")

			if characterId then
				triggerClientEvent(client, "canRentTrailer", client, canRentTrailer(client), playerRentedTrailer[characterId] ~= nil)
			end
		end
	end
)

local trailerModelsByType = {
	[1] = 608,
	[2] = 611
}

addEvent("requestTrailerRental", true)
addEventHandler("requestTrailerRental", root,
	function (trailerType)
		if isValidClient(client, source) then
			trailerType = trailerType and 1 or 2

			if trailerModelsByType[trailerType] then
				local characterId = getElementData(client, "char.ID")

				if canRentTrailer(client) then
					if not playerRentedTrailer[characterId] then
						local spawnPosition = getPrioritySpawnPoint()

						if spawnPosition then
							local trailerId = createTrailer(trailerType, spawnPosition)

							if trailerId then
								local trailerVehicle = trailerElements[trailerId]

								trailerDetails[trailerVehicle] = {
									trailerId = trailerId,
									trailerType = trailerType,
									rentedBy = characterId,
									rentTime = rentalTimeout,
									lastCheck = getTickCount(),
								}

								playerRentedTrailer[characterId] = trailerId

								if not rentalTimer then
									rentalTimer = setTimer(checkRents, 60 * 1000, 0)
								end

								exports.sGui:showInfobox(client, "s", "Kapott utánfutód rendszáma: " .. getVehiclePlateText(trailerVehicle):sub(2) .. ". Bérleted lejár " .. rentalTimeout .. " perc múlva!")
							else
								exports.sGui:showInfobox(client, "e", "Túl nagy a forgalom, kérlek próbáld újra!")
							end
						else
							exports.sGui:showInfobox(client, "e", "Túl nagy a forgalom, kérlek várj egy kicsit!")
						end
					else
						if playerRentedTrailer[characterId] then
							deleteTrailer(playerRentedTrailer[characterId], characterId)
							triggerClientEvent(client, "canRentTrailer", client, false, false)
						end
						--exports.sGui:showInfobox(client, "e", "Egyszerre csak egy utánfutó bérleted lehet!")
					end
				else
					exports.sGui:showInfobox(client, "e", "Nincs jogosultságod utánfutót bérelni!")
				end
			end
		end
	end
)

--attachHandlers
addEventHandler("onTrailerAttach", root, function(towingVehicle)
	if towingVehicle and not (towedTrailerByTractor[towingVehicle] or false) then
		towedTrailerByTractor[towingVehicle] = source
	else
		cancelEvent()
	end
end)

addEventHandler("onTrailerDetach", root, function(towingVehicle)
	if towingVehicle and towedTrailerByTractor[towingVehicle] then
		towedTrailerByTractor[towingVehicle] = false
	end
end)

--vehicleHandlers
addEventHandler("onPlayerVehicleEnter", root,
	function (sourceVehicle)
		local trailerVehicle = towedTrailerByTractor[sourceVehicle]

		if trailerVehicle then
			local trailerData = trailerDetails[trailerVehicle]

			if trailerData then
				local characterId = getElementData(source, "char.ID") or 0

				if trailerData.rentedBy == characterId then
					trailerData.rentTime = 0
				end
			end
		end
	end
)

addEventHandler("onPlayerVehicleExit", root,
	function (sourceVehicle, sourceSeatId, jackerPlayer, forcedByScript)
		local trailerVehicle = towedTrailerByTractor[sourceVehicle]

		if trailerVehicle then
			local trailerData = trailerDetails[trailerVehicle]

			if trailerData then
				local characterId = getElementData(source, "char.ID") or 0

				if trailerData.rentedBy == characterId then
					if not forcedByScript then
						trailerData.rentTime = rentalTimeout

						if isElement(source) then
							exports.sGui:showInfobox(source, "i", "Az utánfutó bérleted lejár " .. rentalTimeout .. " perc múlva.")
						end
					end
				end
			end
		end
	end
)

addEventHandler("onPlayerQuit", root,
	function ()
		if isElement(source) then
			local characterId = getElementData(source, "char.ID") or 0

			if playerRentedTrailer[characterId] then
				deleteTrailer(playerRentedTrailer[characterId], characterId)
			end
		end
	end

)

--Trailer Handlers
function createTrailer(trailerType, spawnPosition)
	local vehicleElement = createVehicle(trailerModelsByType[trailerType], spawnPosition[1], spawnPosition[2], spawnPosition[3] - 0.5, 0, 0, spawnPosition[6])

	if isElement(vehicleElement) then
		local pj = math.random(1, 3)
		setElementData(vehicleElement, "vehicle.currentTexture", pj)
		setElementData(vehicleElement, "paintjob", pj)

		
		local trailerId = 1

		setElementFrozen(vehicleElement, true)
		setTimer(function()
			setElementFrozen(vehicleElement, false)
		end, 500, 1)

		for i = 1, #trailerElements + 1 do
			if not trailerElements[i] then
				trailerId = i
				break
			end
		end

		if not trailerElements[trailerId] then
			applyTrailerHandling(vehicleElement)

			setVehicleLocked(vehicleElement, true)
			setVehicleVariant(vehicleElement, 0, 255)
			setVehicleOverrideLights(vehicleElement, 1)
			setVehicleDamageProof(vehicleElement, true)
			setVehicleEngineState(vehicleElement, false)
			setVehicleFuelTankExplodable(vehicleElement, false)
			setVehicleColor(vehicleElement, 255, 255, 255, 255, 255, 255)
			setVehiclePlateText(vehicleElement, ("-TR-%03d"):format(trailerId))

			exports.sNocol:enableVehicleNoCol(vehicleElement, 30000)

			trailerElements[trailerId] = vehicleElement
		else
			destroyElement(vehicleElement)
		end

		return trailerId
	end

	return false
end

function deleteTrailer(trailerId, characterId)
	local trailerVehicle = trailerElements[trailerId]

	if trailerVehicle then
		local tractorVehicle = towingTractorByTrailer[trailerVehicle]

		if tractorVehicle then
			towedTrailerByTractor[tractorVehicle] = nil
		end

		towingTractorByTrailer[trailerVehicle] = nil

		local trailerData = trailerDetails[trailerVehicle]

		if trailerData then
			playerRentedTrailer[trailerData.rentedBy] = nil
		end

		if trailerData.sourceResourceRoot then
			removeEventHandler("onResourceStop", trailerData.sourceResourceRoot, externalResourceStop)
			trailerData.sourceResourceRoot = nil
		end

		local contentData = trailerContents[trailerVehicle]

		if contentData then
			if contentData.sourceResourceName == "see_farm" then
				exports[contentData.sourceResourceName]:performTrailerUnload(contentData)
			elseif contentData.sourceResourceName == "see_paintshop" then
				exports[contentData.sourceResourceName]:unloadTrailerContent(contentData)
			elseif contentData.sourceResourceName == "see_mining" then
				exports[contentData.sourceResourceName]:processTrailerData(contentData)
			end
		end

		setTrailerData(trailerVehicle, nil)

		if isElement(trailerVehicle) then
			destroyElement(trailerVehicle)
		end

		playerRentedTrailer[characterId] = nil
		trailerElements[trailerId] = nil
		trailerContents[trailerVehicle] = nil
		trailerDetails[trailerVehicle] = nil

		if not next(trailerDetails) then
			if rentalTimer then
				if isTimer(rentalTimer) then
					killTimer(rentalTimer)
				end
			end
			rentalTimer = nil
		end

		applyTractorHandling(tractorVehicle)

		return true
	end

	return false
end

function applyTrailerHandling(trailerVehicle)
	if isElement(trailerVehicle) then
		setVehicleOverrideLights(trailerVehicle, 1)

		if towingTractorByTrailer[trailerVehicle] then
			setVehicleHandling(trailerVehicle, "centerOfMass", nil, false)
		else
			setVehicleHandling(trailerVehicle, "centerOfMass", {0, 0.125, 0})
		end
	end
end

function applyTractorHandling(tractorVehicle)
	if isElement(tractorVehicle) then
		if towedTrailerByTractor[tractorVehicle] then
			exports.see_tuning:makeTuning(tractorVehicle)
		else
			exports.see_tuning:makeTuning(tractorVehicle, true)
		end
	end
end


--Notify
local notifyPeriods = {1, 5, 10}

function checkRents()
	local currentTick = getTickCount()

	for trailerElement, trailerData in pairs(trailerDetails) do
		local elapsedMinutes = (currentTick - trailerData.lastCheck) / (60 * 1000)

		if trailerData.rentTime > 0 then
			trailerData.rentTime = trailerData.rentTime - elapsedMinutes
			trailerData.lastCheck = currentTick

			if not trailerData.wasNotifySent then
				trailerData.wasNotifySent = {}
			else
				for i = 1, #notifyPeriods do
					local notificationMinute = notifyPeriods[i]

					if trailerData.wasNotifySent[notificationMinute] then
						if trailerData.wasNotifySent[notificationMinute] < trailerData.rentTime then
							trailerData.wasNotifySent[notificationMinute] = nil
						end
					end
				end
			end

			if trailerData.rentTime <= 0 then
				notifyRenter(trailerData.rentedBy, 0)
			else
				for i = 1, #notifyPeriods do
					local notificationMinute = notifyPeriods[i]

					if trailerData.rentTime <= notificationMinute then
						if not trailerData.wasNotifySent[notificationMinute] then
							notifyRenter(trailerData.rentedBy, math.floor(trailerData.rentTime + 0.5))
							trailerData.wasNotifySent[notificationMinute] = trailerData.rentTime
						end
						break
					end
				end
			end

			if trailerData.rentTime <= 0 then
				deleteTrailer(trailerData.trailerI, trailerData.rentedBy)
			end
		else
			trailerData.lastCheck = currentTick
		end
	end

	if not next(trailerDetails) then
		if rentalTimer then
			if isTimer(rentalTimer) then
				killTimer(rentalTimer)
			end
		end
		rentalTimer = nil
	end
end

function notifyRenter(characterId, remainingTime)
	local playerContainer = getElementsByType("player")

	for i = 1, #playerContainer do
		local playerElement = playerContainer[i]

		if getElementData(playerElement, "char.ID") == characterId then
			if remainingTime <= 0 then
				exports.sGui:showInfobox(playerElement, "e", "Lejárt az utánfutó bérleted!")
			else
				exports.sGui:showInfobox(playerElement, "w", "Utánfutó bérleted lejár " .. remainingTime .. " perc múlva!")
			end

			break
		end
	end
end

addCommandHandler("gototrailer",
	function (sourcePlayer, commandName, trailerId)
		local adminLevel = getElementData(sourcePlayer, "acc.adminLevel") or 0

		if adminLevel > 0 then
			trailerId = tonumber(trailerId)

			if trailerId then
				local trailerVehicle = trailerElements[trailerId]

				if isElement(trailerVehicle) then
					local trailerPosX, trailerPosY, trailerPosZ = getElementPosition(trailerVehicle)
					local trailerRotX, trailerRotY, trailerRotZ = getElementRotation(trailerVehicle)

					trailerPosX = trailerPosX + math.cos(math.rad(trailerRotZ)) * 2
					trailerPosY = trailerPosY + math.sin(math.rad(trailerRotZ)) * 2

					setElementPosition(sourcePlayer, trailerPosX, trailerPosY, trailerPosZ)
					setElementRotation(sourcePlayer, 0, 0, trailerRotZ, "default", true)

					setElementInterior(sourcePlayer, getElementInterior(trailerVehicle))
					setElementDimension(sourcePlayer, getElementDimension(trailerVehicle))

					outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Elteleportáltál a kiválasztott utánfutóhoz.", sourcePlayer, 255, 255, 255, true)
				else
					outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A kiválasztott utánfutó nem található.", sourcePlayer, 255, 255, 255, true)
				end
			else
				outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Utánfutó Azonosító]", sourcePlayer, 255, 255, 255, true)
			end
		end
	end
)

addCommandHandler("gettrailer",
	function (sourcePlayer, commandName, trailerId)
		local adminLevel = getElementData(sourcePlayer, "acc.adminLevel") or 0

		if adminLevel > 0 then
			trailerId = tonumber(trailerId)

			if trailerId then
				local trailerVehicle = trailerElements[trailerId]

				if isElement(trailerVehicle) then
					local tractorVehicle = towingTractorByTrailer[trailerVehicle]

					if isElement(tractorVehicle) then
						outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A kiválasztott utánfutó jelenleg vontatva van.", sourcePlayer, 255, 255, 255, true)
					else
						local sourcePosX, sourcePosY, sourcePosZ = getElementPosition(sourcePlayer)
						local sourceRotX, sourceRotY, sourceRotZ = getElementRotation(sourcePlayer)

						sourcePosX = sourcePosX + math.cos(math.rad(sourceRotZ)) * 2
						sourcePosY = sourcePosY + math.sin(math.rad(sourceRotZ)) * 2

						setElementPosition(trailerVehicle, sourcePosX, sourcePosY, sourcePosZ)
						setElementRotation(trailerVehicle, 0, 0, sourceRotZ)

						setElementInterior(trailerVehicle, getElementInterior(sourcePlayer))
						setElementDimension(trailerVehicle, getElementDimension(sourcePlayer))

						outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Magadhoz teleportáltad a kiválasztott utánfutót.", sourcePlayer, 255, 255, 255, true)
					end
				else
					outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A kiválasztott utánfutó nem található.", sourcePlayer, 255, 255, 255, true)
				end
			else
				outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Utánfutó Azonosító]", sourcePlayer, 255, 255, 255, true)
			end
		end
	end
)

addCommandHandler("createtrailer",
	function (sourcePlayer, commandName, trailerType)
		local adminLevel = getElementData(sourcePlayer, "acc.adminLevel") or 0

		if adminLevel > 3 then
			local characterId = getElementData(sourcePlayer, "char.ID") or 0
			
			if not playerRentedTrailer[characterId] then
				trailerType = tonumber(trailerType)

				if trailerModelsByType[trailerType] then
					local spawnPosition = getPrioritySpawnPoint()

					if spawnPosition then
						local trailerId = createTrailer(trailerType, spawnPosition)

						if trailerId then
							local trailerVehicle = trailerElements[trailerId]

							trailerDetails[trailerVehicle] = {
								trailerId = trailerId,
								trailerType = trailerType,
								rentedBy = characterId,
								rentTime = rentalTimeout,
								lastCheck = getTickCount(),
							}

							playerRentedTrailer[characterId] = trailerId

							if not rentalTimer then
								rentalTimer = setTimer(checkRents, 60 * 1000, 0)
							end

							executeCommandHandler("gettrailer", sourcePlayer, tostring(trailerId))
						else
							outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Az utánfutó létrehozása meghiúsult!", sourcePlayer, 255, 255, 255, true)
						end
					else
						outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Az utánfutó létrehozása meghiúsult!", sourcePlayer, 255, 255, 255, true)
					end
				else
					outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Utánfutó típus [1 / 2]]", sourcePlayer, 255, 255, 255, true)
				end
			else
				outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Már van egy utánfutód!", sourcePlayer, 255, 255, 255, true)
			end
		end
	end
)

addCommandHandler("deletetrailer",
	function (sourcePlayer, commandName, trailerId)
		local adminLevel = getElementData(sourcePlayer, "acc.adminLevel") or 0

		if adminLevel > 3 then
			trailerId = tonumber(trailerId)

			if trailerId then
				if deleteTrailer(trailerId, getElementData(sourcePlayer, "char.ID")) then
					outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A kiválasztott utánfutó sikeresen törlésre került.", sourcePlayer, 255, 255, 255, true)
				else
					outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A kiválasztott utánfutó nem található.", sourcePlayer, 255, 255, 255, true)
				end
			else
				outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Utánfutó Azonosító]", sourcePlayer, 255, 255, 255, true)
			end
		end
	end
)

addCommandHandler("nearbytrailers",
	function (sourcePlayer, commandName)
		local adminLevel = getElementData(sourcePlayer, "acc.adminLevel") or 0

		if adminLevel > 0 then
			local sourcePosX, sourcePosY, sourcePosZ = getElementPosition(sourcePlayer)

			local sourceInterior = getElementInterior(sourcePlayer)
			local sourceDimension = getElementDimension(sourcePlayer)

			local nearbyTrailers = {}

			for trailerId, trailerVehicle in pairs(trailerElements) do
				local trailerPosX, trailerPosY, trailerPosZ = getElementPosition(trailerVehicle)

				local matchingInterior = sourceInterior == getElementInterior(trailerVehicle)
				local matchingDimension = sourceDimension == getElementDimension(trailerVehicle)

				if matchingInterior and matchingDimension then
					local currentDistance = getDistanceBetweenPoints3D(sourcePosX, sourcePosY, sourcePosZ, trailerPosX, trailerPosY, trailerPosZ)

					if currentDistance <= 15 then
						table.insert(nearbyTrailers, {trailerId, currentDistance})
					end
				end
			end

			table.sort(nearbyTrailers,
				function (a, b)
					return a[2] < b[2]
				end
			)

			if #nearbyTrailers > 0 then
				outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A közeledben lévő utánfutók:", sourcePlayer, 255, 255, 255, true)

				for nearbyIndex, nearbyData in ipairs(nearbyTrailers) do
					outputChatBox("  - Azonosító: [color=sightblue-second]" .. nearbyData[1] .. "[color=hudwhite] <> Távolság: [color=sightblue-second]" .. math.floor(nearbyData[2]), sourcePlayer, 255, 255, 255, true)
				end
			else
				outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A közeledben nem található egyetlen utánfutó sem.", sourcePlayer, 255, 255, 255, true)
			end
		end
	end
)