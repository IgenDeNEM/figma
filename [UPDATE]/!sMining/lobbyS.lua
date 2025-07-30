local minesLoaded = false
local minesLoading = false

playersInLobby = {}
playersCurrentLobby = {}

loadedMinesData = {}

function loadMines()
	if not (minesLoading or minesLoaded) then
		minesLoading = true
		dbQuery(
			function (queryHandle)
				local queryData = dbPoll(queryHandle, 0)

				if type(queryData) == "table" then
					minesLoading = false

					for rowId, rowData in pairs(queryData) do
						loadedMinesData[rowData.mineId] = {
							workersInside = {},
							workerPermissions = {},
							workerNames = {},
						}

						initMine(rowData.mineId)

						for dataName, dataValue in pairs(rowData) do
							if dataName == "isLocked" then
								loadedMinesData[rowData.mineId][dataName] = dataValue == 1
							elseif dataName == "ownerName" then
								loadedMinesData[rowData.mineId][dataName] = dataValue:gsub("_", " ")
							elseif dataName == "mineName" then
								loadedMinesData[rowData.mineId][dataName] = split(dataValue, "|")
							else
								loadedMinesData[rowData.mineId][dataName] = dataValue
							end
						end

						playersInMine[rowData.mineId] = {}
					end

					minesLoaded = true
				end
			end,
		dbConnection, "SELECT mines.*, characters.name AS ownerName FROM mines LEFT JOIN characters ON mines.rentedBy = characters.characterId")
	end
end

function initlobbyCoords()
	for mineIndex = 1, #lobbyCoords do
		local mineLobby = lobbyCoords[mineIndex]

		if mineLobby then
			local baseIndex = getLobbyCorridorBaseId(mineIndex)

			for lobbyIndex = 1, mineLobby[6] do
				local lobbyId = baseIndex + lobbyIndex

				if not playersInLobby[lobbyId] then
					playersInLobby[lobbyId] = {}
				end
			end
		end
	end
end

function getLobbyMineList(lobbyId)
	local lobbyBaseId = getLobbyMineBaseId(getLobbyFromCorridor(lobbyId))
	local lobbyMineIds = {}

	for doorIndex = 1, #mineCoords do
		table.insert(lobbyMineIds, lobbyBaseId + doorIndex)
	end

	return lobbyMineIds
end

function isPlayerInLobby(clientId)
	return playersCurrentLobby[clientId] ~= nil
end

function getPlayerLobby(clientId)
	return playersCurrentLobby[clientId]
end

function setPlayerLobby(sourcePlayer, lobbyId, skipSync)
	local lobbyWas = playersCurrentLobby[sourcePlayer]

	if eventName == "onResourceStop" or eventName == "onPlayerQuit" then
		if isPedInVehicle(sourcePlayer) then
			removePedFromVehicle(sourcePlayer)
		end
	end
	iprint(lobbyWas , lobbyId)
	if lobbyWas ~= lobbyId then
		local currentVehicle = getPedOccupiedVehicle(sourcePlayer)
		local currentVehicleSeat = false

		if isElement(currentVehicle) then
			currentVehicleSeat = getPedOccupiedVehicleSeat(sourcePlayer)
		end

		if lobbyWas then
			local mineLobby = lobbyCoords[getLobbyFromCorridor(lobbyWas)]

			for i = #playersInLobby[lobbyWas], 1, -1 do
				if playersInLobby[lobbyWas][i] == sourcePlayer then
					table.remove(playersInLobby[lobbyWas], i)
					break
				end
			end

			-- if #playersInLobby[lobbyWas] == 0 then
			-- 	local lobbyMineIds = getLobbyMineList(lobbyWas)

			-- 	for i = 1, #lobbyMineIds do
			-- 		local mineId = lobbyMineIds[i]

			-- 		if isElement(mineOrderColShapes[mineId]) then
			-- 			destroyElement(mineOrderColShapes[mineId])
			-- 		end

			-- 		mineOrderColShapes[mineId] = nil
			-- 	end
			-- end

			setElementInterior(sourcePlayer, 0)
			setElementDimension(sourcePlayer, 0)

			setElementPosition(sourcePlayer, mineLobby[1], mineLobby[2], mineLobby[3])
			setElementRotation(sourcePlayer, 0, 0, mineLobby[4], "default", true)

			triggerClientEvent(sourcePlayer, "mineLobbyExitResponse", sourcePlayer, lobbyWas)
			triggerClientEvent(sourcePlayer, "mineLobbyExited", sourcePlayer)

			playersCurrentLobby[sourcePlayer] = nil
		end
		if lobbyId then
			playersCurrentLobby[sourcePlayer] = lobbyId

			if not playersInLobby[lobbyId] then
				playersInLobby[lobbyId] = {sourcePlayer}
			else
				table.insert(playersInLobby[lobbyId], sourcePlayer)
			end

			setElementInterior(sourcePlayer, 0)
			setElementDimension(sourcePlayer, lobbyId)

			setElementPosition(sourcePlayer, lobbyExitX, lobbyExitY, lobbyExitZ)
			setElementRotation(sourcePlayer, 0, 0, lobbyExitAngle, "default", true)

			-- local lobbyMineIds = getLobbyMineList(lobbyId)

			-- for i = 1, #lobbyMineIds do
			-- 	local mineId = lobbyMineIds[i]

			-- 	if mineOrders[mineId] then
			-- 		local mineIndex, lobbyIndex, doorIndex = getLobbyFromMineId(mineId)
					
			-- 		if isElement(mineOrderTransit[mineId]) then
			-- 			local markerPosX, markerPosY, markerPosZ, markerCos, markerSin, markerAngle = unpack(mineCoords[doorIndex])

			-- 			if not mineOrderColShapes[mineId] then
			-- 				mineOrderColShapes[mineId] = createColSphere(markerPosX, markerPosY, markerPosZ, 2.5)

			-- 				if isElement(mineOrderColShapes[mineId]) then
			-- 					setElementData(mineOrderColShapes[mineId], "mineId", mineId, false)
			-- 					addEventHandler("onColShapeHit", mineOrderColShapes[mineId], handleMineColShapeEnter)
			-- 					setElementInterior(mineOrderColShapes[mineId], 0)
			-- 					setElementDimension(mineOrderColShapes[mineId], lobbyId)
			-- 				end
			-- 			end
			-- 		end
			-- 	end
			-- end

			if not skipSync then
				local characterId = getElementData(sourcePlayer, "char.ID")
	
				if characterId then
					local mineIndex, lobbyIndex = getLobbyFromCorridor(lobbyId)
					local baseIndex = getLobbyMineBaseId(mineIndex, lobbyIndex)
					local minesToSync = {}
	
					for doorIndex = 1, #mineCoords do
						local mineId = baseIndex + doorIndex
						local mineData = loadedMinesData[mineId]
	
						if mineData then
							minesToSync[mineId] = {}
	
							for dataName, dataValue in pairs(mineData) do
								minesToSync[mineId][dataName] = dataValue
							end
	
							minesToSync[mineId]["canLock"] = checkMinePermission(sourcePlayer, permissionFlags.OPEN_CLOSE, mineId)
							minesToSync[mineId]["canManage"] = characterId == mineData.rentedBy
						end
					end
	
					triggerClientEvent(sourcePlayer, "mineLobbyEnterResponse", sourcePlayer, lobbyId)
					triggerClientEvent(sourcePlayer, "mineLobbyLoaded", sourcePlayer, lobbyId, minesToSync, characterId)
				end
			end
		end

		if currentVehicleSeat then
			warpPedIntoVehicle(sourcePlayer, currentVehicle, currentVehicleSeat)
		end

		return true
	end

	return false
end

function handleMineColShapeEnter(enteredElement, matchingDimension)
	if not matchingDimension then
		return
	elseif not isElement(enteredElement) then
		return
	elseif getElementType(enteredElement) ~= "vehicle" then
		return
	elseif getElementModel(enteredElement) == 611 then
		local trailerData = exports.sWorkaround:getTrailerData(enteredElement)

		if not trailerData then
			return
		elseif trailerData.sourceResourceName ~= resourceName then
			return
		else
			local mineId = getElementData(source, "mineId")
			
			if trailerData[1] ~= mineId then
				return
			elseif #trailerData >= 2 then
				local towingTractor = exports.sWorkaround:getAttachedTractor(enteredElement)
				local tractorDriver = false

				if towingTractor then
					tractorDriver = getVehicleController(towingTractor)
				end

				if mineOrders[mineId] then
					processTrailerData(trailerData)

					if isElement(tractorDriver) then
						exports.sGui:showInfobox(tractorDriver, "s", "Leszállítottad a rendelést.")
					end
				end

				exports.sWorkaround:setTrailerData(enteredElement, nil)
			end
		end
	end
end

function teleportVehicle(sourceVehicle, warpPosX, warpPosY, warpPosZ, warpRotZ, warpInterior, warpDimension)
	if isElement(sourceVehicle) then
		local trailerElement = exports.sWorkaround:getAttachedTrailer(sourceVehicle)

		setElementFrozen(sourceVehicle, true)

		if isElement(trailerElement) then
			setElementFrozen(trailerElement, true)
			
			exports.sNocol:enableVehicleNoCol(trailerElement, 30000)

			setElementInterior(trailerElement, warpInterior)
			setElementDimension(trailerElement, warpDimension)

			setElementPosition(trailerElement, warpPosX, warpPosY, warpPosZ)
			setElementRotation(trailerElement, 0, 0, warpRotZ)

			local tractorModelId = getElementModel(sourceVehicle)
			local tractorTowBarOffset = 0

			local trailerModelId = getElementModel(trailerElement)
			local trailerHitchOffset = 0

			local safeAngle = math.rad(warpRotZ - 90)
			local safeDistance = 0

			warpPosX = warpPosX + safeDistance * math.cos(safeAngle)
			warpPosY = warpPosY + safeDistance * math.sin(safeAngle)
		end

		exports.sNocol:enableVehicleNoCol(sourceVehicle, 30000)
		--exports.sNocol:disableCollision(sourceVehicle, 30)

		setElementInterior(sourceVehicle, warpInterior)
		setElementDimension(sourceVehicle, warpDimension)

		setElementPosition(sourceVehicle, warpPosX, warpPosY, warpPosZ)
		setElementRotation(sourceVehicle, 0, 0, warpRotZ)

		setElementFrozen(sourceVehicle, false)

		if isElement(trailerElement) then
			setElementFrozen(trailerElement, false)
			setTimer(
				function ()
					if isElement(sourceVehicle) and isElement(trailerElement) then
						attachTrailerToVehicle(sourceVehicle, trailerElement)
					end
				end,
			500, 3)
		end
	end
end

addEvent("tryToEnterMineLobby", true)
addEventHandler("tryToEnterMineLobby", root,
	function (lobbyId)
		if client then
			if isValidLobbyCorridor(lobbyId) then
				if not playersCurrentLobby[client] then
					iprint(minesLoaded)
					if minesLoaded then
						local currentVehicle = getPedOccupiedVehicle(client)

						if isElement(currentVehicle) then
							teleportVehicle(currentVehicle, lobbyExitX, lobbyExitY, lobbyExitZ, lobbyExitAngle, 0, lobbyId)

							for i = 0, getVehicleMaxPassengers(currentVehicle) + 1 do
								local occupantPlayer = getVehicleOccupant(currentVehicle, i)

								if isElement(occupantPlayer) then
									setPlayerLobby(occupantPlayer, lobbyId)
								end
							end
						else
							setPlayerLobby(client, lobbyId)
						end

						if #loadedPlayers > 0 then
							triggerClientEvent(loadedPlayers, "gotMineLobbyDoorSound", currentVehicle or client, lobbyId)
						end
					else
						triggerClientEvent(client, "mineLobbyEnterResponse", client, false)
					end
				else
					triggerClientEvent(client, "mineLobbyEnterResponse", client, false)
				end
			else
				triggerClientEvent(client, "mineLobbyEnterResponse", client, false)
			end
		end
	end
)

addEvent("tryToExitMineLobby", true)
addEventHandler("tryToExitMineLobby", root,
	function ()
		if client then
			local lobbyId = playersCurrentLobby[client]

			if lobbyId then
				local mineLobby = lobbyCoords[getLobbyFromCorridor(lobbyId)]

				if mineLobby then
					local currentVehicle = getPedOccupiedVehicle(client)

					if isElement(currentVehicle) then
						teleportVehicle(currentVehicle, mineLobby[1], mineLobby[2], mineLobby[3] + 1, mineLobby[4], 0, 0)

						for i = 0, getVehicleMaxPassengers(currentVehicle) + 1 do
							local occupantPlayer = getVehicleOccupant(currentVehicle, i)

							if isElement(occupantPlayer) then
								setPlayerLobby(occupantPlayer, false)
							end
						end
					else
						setPlayerLobby(client, false)
					end

					if #loadedPlayers > 0 then
						triggerClientEvent(loadedPlayers, "gotMineLobbyDoorSound", vehicle or client, lobbyId)
					end
				else
					triggerClientEvent(client, "mineLobbyExitResponse", client, false)
				end
			else
				triggerClientEvent(client, "mineLobbyExitResponse", client, false)
			end
		end
	end
)

addEvent("lockUnlockMine", true)
addEventHandler("lockUnlockMine", root,
	function (mineId)
		mineId = tonumber(mineId) or 0

		if client then
			mineId = playersCurrentMine[client] or mineId

			if mineId then
				local mineData = loadedMinesData[mineId]

				if mineData then
					local mineIndex, lobbyIndex, doorIndex = getLobbyFromMineId(mineId)
					local lobbyId = getCorridorIdFromLobbyCorridor(mineIndex, lobbyIndex)

					if checkMinePermission(client, permissionFlags.OPEN_CLOSE, mineId) then
						local remainingTime = 0

						if doorRammerTicks[mineId] then
							remainingTime = (doorRammerTicks[mineId] + doorDamagePeriod) - getTickCount()
						end

						if remainingTime <= 0 then
							mineData.isLocked = not mineData.isLocked

							if mineData.isLocked then
								exports.sChat:localAction(client, "bezárja egy bánya ajtaját.")
							else
								exports.sChat:localAction(client, "kinyitja egy bánya ajtaját.")
							end

							triggerClientEvent("gotMineDoorSound", client, mineId, 5)

							doorRammerTicks[mineId] = nil

							if isElement(dbConnection) then
								dbExec(dbConnection, "UPDATE mines SET isLocked = ? WHERE mineId = ?", mineData.isLocked, mineId)
							end

							if playersCurrentMine[client] then
								if #playersInMine[mineId] > 0 then
									triggerClientEvent(playersInMine[mineId], "gotMineDoorLocked", client, mineId, mineData.isLocked)
								end
							elseif #playersInLobby[lobbyId] > 0 then
								triggerClientEvent(playersInLobby[lobbyId], "gotMineDoorLocked", client, mineId, mineData.isLocked)
							end
						else
							exports.sGui:showInfobox(client, "e", "Az ajtó be van törve! Nem használhatod a zárat még " .. math.floor(remainingTime / 1000 + 0.5) .. " másodpercig.")
						end
					else
						exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
					end
				end
			end
		end
	end
)

addEvent("rentMineWithCash", true)
addEventHandler("rentMineWithCash", root, function(mineId)
	triggerEvent("rentMine", client, mineId, false)
end)

addEvent("rentMineWithPP", true)
addEventHandler("rentMineWithPP", root, function(mineId)
	triggerEvent("rentMine", client, mineId, true)
end)

addEvent("rentMine", true)
addEventHandler("rentMine", root,
	function (mineId, ppMode)
		mineId = tonumber(mineId)
		if not client then
			client = source
		end
		if client then
			local characterId = getElementData(client, "char.ID")

			if characterId then
				local mineIndex, lobbyIndex, doorIndex = getLobbyFromMineId(mineId)
				local lobbyId = getCorridorIdFromLobbyCorridor(mineIndex, lobbyIndex)

				if lobbyId == playersCurrentLobby[client] then
					local mineData = loadedMinesData[mineId]

					if mineData then
						if mineData.rentedBy == characterId then
							local remainingTime = mineData.rentUntil - os.time()

							if remainingTime < renewalDuration then
								if not ppMode and mineData.rentMode == "pp" then
									exports.sGui:showInfobox(client, "e", "Mivel PP-vel bérelted a bányát, csak azzal hosszabbíthatod meg! (/rentmine pp)")
								else
									local payoutSucceded = false

									if ppMode then
										payoutSucceded = exports.sCore:getPP(client) >= ppRentPrice
									else
										payoutSucceded = exports.sCore:getMoney(client) >= rentPrice
									end

									if payoutSucceded then
										if ppMode then
											exports.sCore:takePP(client, ppRentPrice)
										else
											exports.sCore:takeMoney(client, rentPrice)
										end
										mineData.rentUntil = os.time() + rentDuration

										if #playersInLobby[lobbyId] > 0 then
											triggerClientEvent(playersInLobby[lobbyId], "gotMineRentData", client, mineId, "rentUntil", mineData.rentUntil)
										end

										if isElement(dbConnection) then
											dbExec(dbConnection, "UPDATE mines SET rentUntil = ? WHERE mineId = ?", mineData.rentUntil, mineId)
										end

										exports.sGui:showInfobox(client, "s", "Sikeresen meghosszabbítottad a bánya bérleted! Lejár: " .. os.date("%Y.%m.%d. %H:%M", mineData.rentUntil))
									elseif ppMode then
										exports.sGui:showInfobox(client, "e", "Nincs elég prémium pontod, hogy kifizesd a bérleti díjat.")
									else
										exports.sGui:showInfobox(client, "e", "Nincs elég pénzed, hogy kifizesd a bérleti díjat.")
									end
								end
							else
								exports.sGui:showInfobox(client, "e", "Még nem tudod meghosszabbítani a bérleted. Legkorábbi időpont: " .. os.date("%Y.%m.%d. %H:%M", mineData.rentUntil - renewalDuration))
							end
						else
							exports.sGui:showInfobox(client, "e", "Ez a bánya nem kiadó!")
						end
					elseif isElement(dbConnection) then
						dbQuery(
							function (queryHandle, clientPlayer)
								local queryData = dbPoll(queryHandle, 0)

								if isElement(clientPlayer) then
									if queryData then
										local maxRentableMines = 0
										if not ppMode and #queryData > maxRentableMines then
											exports.sGui:showInfobox(clientPlayer, "e", "Maximum 1 bányát bérelhetsz készpénzzel!")
										else
											local payoutSucceded = false

											if ppMode then
												payoutSucceded = exports.sCore:getPP(clientPlayer) >= ppRentPrice + ppRentDeposit
											else
												payoutSucceded = exports.sCore:getMoney(clientPlayer) >= rentPrice + rentDeposit
											end

											if payoutSucceded then
												if ppMode then
													exports.sCore:takePP(clientPlayer, ppRentPrice + ppRentDeposit)
												else
													exports.sCore:takeMoney(clientPlayer, rentPrice + rentDeposit)
												end
												local characterName = getElementData(clientPlayer, "visibleName")
												local characterNameParts = split(characterName, "_")

												mineData = {
													rentedBy = characterId,
													rentUntil = os.time() + rentDuration,
													rentMode = ppMode and "pp" or "cash",
													isLocked = false,
													mineName = {utf8.upper(characterNameParts[1]), utf8.upper(characterNameParts[#characterNameParts])},
													workersInside = {},
													workerNames = {},
													workerPermissions = {},
												}

												loadedMinesData[mineId] = mineData
												playersInMine[mineId] = {}

												initMine(mineId)

												if #playersInLobby[lobbyId] > 0 then
													triggerClientEvent(playersInLobby[lobbyId], "gotNewMineData", clientPlayer, mineId, mineData)
												end
												mineData.canManage = true
												mineData.canLock = true
												triggerClientEvent(clientPlayer, "gotNewMineData", clientPlayer, mineId, mineData)

												if isElement(dbConnection) then
													dbExec(dbConnection, "INSERT INTO mines (mineId, rentedBy, rentMode, rentUntil, mineName) VALUES (?,?,?,?,?)", mineId, mineData.rentedBy, mineData.rentMode, mineData.rentUntil, table.concat(mineData.mineName, "|"))
												end

												exports.sGui:showInfobox(clientPlayer, "s", "Sikeresen kibérelted a bányát! Lejár: " .. os.date("%Y.%m.%d. %H:%M", mineData.rentUntil))
											elseif ppMode then
												exports.sGui:showInfobox(clientPlayer, "e", "Nincs elég prémium pontod, hogy kifizesd a bérleti díjat és kauciót.")
											else
												exports.sGui:showInfobox(clientPlayer, "e", "Nincs elég pénzed, hogy kifizesd a bérleti díjat és kauciót.")
											end
										end
									else
										exports.sGui:showInfobox(clientPlayer, "e", "A bánya ellenőrzése meghiúsult!")
									end
								end
							end,
						{client}, dbConnection, "SELECT mineId FROM mines WHERE rentMode = 'cash' AND rentedBy = ?", characterId)
					else
						exports.sGui:showInfobox(client, "e", "A bánya ellenőrzése meghiúsult!")
					end
				end
			end
		end
	end
)

addEvent("unrentMine", true)
addEventHandler("unrentMine", root,
	function (mineId)
		mineId = tonumber(mineId)

		if client then
			local characterId = getElementData(client, "char.ID")

			if characterId then
				local mineIndex, lobbyIndex, doorIndex = getLobbyFromMineId(mineId)
				local lobbyId = getCorridorIdFromLobbyCorridor(mineIndex, lobbyIndex)

				if lobbyId == playersCurrentLobby[client] then
					local mineData = loadedMinesData[mineId]

					if mineData then
						if mineData.rentedBy == characterId then
							local remainingTime = mineData.rentUntil - os.time()
							local minRentalTime = 60

							if remainingTime < rentDuration - minRentalTime then
								exports.sGui:showInfobox(client, "s", "Sikeresen lemondtad a bánya bérletét!")

								if mineData.rentMode == "pp" then
									local payoutAmount = math.floor(ppRentDeposit)

									if payoutAmount > 0 then
										exports.sCore:givePP(client, payoutAmount)
									end
								else
									local payoutAmount = math.floor(rentDeposit)

									if payoutAmount > 0 then
										exports.sCore:giveMoney(client, payoutAmount)
									end
								end

								resetMine(mineId, "unrent")
							else
								exports.sGui:showInfobox(client, "e", "Ilyen gyorsan nem mondhatod le a bánya bérletét!")
							end
						else
							exports.sGui:showInfobox(client, "e", "Ezt a bányát nem te bérled!")
						end
					end
				end
			end
		end
	end
)

function checkRents()
	local playersByCharacterId = {}
	local playersOnServer = getElementsByType("player")

	for i = 1, #playersOnServer do
		local playerElement = playersOnServer[i]

		if isElement(playerElement) then
			local characterId = getElementData(playerElement, "char.ID")

			if characterId then
				playersByCharacterId[characterId] = playerElement
			end
		end
	end

	dbQuery(
		function (queryHandle)
			local queryData = dbPoll(queryHandle, 0)

			if queryData then
				for rowId, rowData in pairs(queryData) do
					local playerElement = playersByCharacterId[rowData.rentedBy]
					local remainingTime = rowData.rentUntil - os.time()

					if remainingTime <= 0 then
						resetMine(rowData.mineId, "expired")

						if isElement(playerElement) then
							exports.sGui:showInfobox(playerElement, "w", "A bányád (" .. formatMineName(rowData.mineId) .. ") bérlete lejárt!")
						end
					elseif remainingTime < renewalDuration then
						if isElement(playerElement) then
							exports.sGui:showInfobox(playerElement, "w", "A bányád (" .. formatMineName(rowData.mineId) .. ") bérlete kb " .. secondsToTimeString(remainingTime) .. " múlva lejár!")
						end
					end
				end

				scheduleMineSaving()
			end
		end,
	dbConnection, "SELECT mineId, rentedBy, rentUntil FROM mines WHERE UNIX_TIMESTAMP() >= rentUntil - ?", renewalDuration)
end

function secondsToTimeString(remainingSeconds)
	local timeParts = {}
	local timeUnits = {
		{unitSeconds = 604800, unitName = "hét"},
		{unitSeconds = 86400, unitName = "nap"},
		{unitSeconds = 3600, unitName = "óra"},
		{unitSeconds = 60, unitName = "perc"},
		{unitSeconds = 1, unitName = "másodperc"},
	}

	for i = 1, #timeUnits do
		local timeUnit = timeUnits[i]

		if remainingSeconds >= timeUnit.unitSeconds and #timeParts < 2 then
			local remainingUnit = math.floor(remainingSeconds / timeUnit.unitSeconds)

			if remainingUnit > 0 then
				table.insert(timeParts, ("%d %s"):format(remainingUnit, timeUnit.unitName))
			end

			remainingSeconds = remainingSeconds % timeUnit.unitSeconds
		end
	end

	if #timeParts == 0 then
		return "0 másodperc"
	elseif #timeParts == 1 then
		return timeParts[1]
	else
		return table.concat(timeParts, " és ")
	end
end
loadMines()


