local pulseTimer = false

local syncZones = {}
local playerSyncZone = {}
local playersPerSyncZone = {}

local fortuneCupTables = {}
local playerPlayingTables = {}

local countdownStarted = {}
local horseRaceStarted = {}

local streamingData = {
	currentPlayers = "players",
	playerBets = "bets",
	playerSideBets = "sideBets",
	gameHistory = "history",
	cupName = true,
	cupTheme = "theme",
	cupBackground = "bg",
	bettingEnabled = "betting",
	matchTime = true,
	matchFinishOrder = "place",
	horseNames = "names",
	horseKeyframes = "speed",
	horseFinishTime = "finishTime",
	horseFinalPosition = "endPos",
	horseOdds = "odds",
	horseSideOdds = "sideOdds",
	winnerId = "winner",
	runnerUp = true,
	winCount = true,
	loseCount = true,
}

---------------------------------------------------------------------------------------------------

addEventHandler("onResourceStart", resourceRoot,
	function ()
		initSyncZones()
		initHorseTables()
	end
)

addEventHandler("onResourceStop", resourceRoot,
	function ()
		for clientId in pairs(playerPlayingTables) do
			playerExitFortuneCup(clientId)
		end
	end
)

addEvent("requestHorseeTables", true)
addEventHandler("requestHorseeTables", root,
	function ()
		if client then
			local dimensionId = getElementDimension(client)
			if tablesPerDimension[dimensionId] then
				playerEnterSyncZone(client, getPlayerSyncZone(client), dimensionId)
			end
		end
	end
)

addEventHandler("onElementDimensionChange", root,
	function (oldDimension, newDimension)
		if getElementType(source) == "player" then
			if tablesPerDimension[oldDimension] then
				playerLeaveSyncZone(source, playerSyncZone[source], oldDimension)
			end

			if tablesPerDimension[newDimension] then
				playerEnterSyncZone(source, getPlayerSyncZone(source), newDimension)
			end
		end
	end
)

addEventHandler("onPlayerQuit", root,
	function ()
		local currentSyncZone = playerSyncZone[source]
		
		if currentSyncZone then
			playerSyncZone[source] = nil
			
			for i = #playersPerSyncZone[currentSyncZone], 1, -1 do
				if playersPerSyncZone[currentSyncZone][i] == source then
					table.remove(playersPerSyncZone[currentSyncZone], i)
					break
				end
			end
		end

		playerExitFortuneCup(source)
	end,
true, "high+1")

addEvent("tryToSitDownHorsee", true)
addEventHandler("tryToSitDownHorsee", root,
	function (tableId, seatId)
		if client then
			playerJoinFortuneCup(client, tableId, seatId)
		end
	end
)

addEvent("tryToExitHorsee", true)
addEventHandler("tryToExitHorsee", root,
	function ()
		if client then
			playerExitFortuneCup(client)
		end
	end
)

---------------------------------------------------------------------------------------------------


function initSyncZones()
	for i, v in pairs(syncZoneCoords) do
		local zoneDetails = syncZoneCoords[i]

		if zoneDetails then
			zoneDetails[8] = getElementByID("casinoSyncZone"..i)

			if zoneDetails[8] then
				syncZones[zoneDetails[8]] = zoneDetails[7]
			end

			if not playersPerSyncZone[zoneDetails[7]] then
				playersPerSyncZone[zoneDetails[7]] = {}
			end
		end
	end
end

function getPlayerSyncZone(clientId)
	local playerX, playerY, playerZ = getElementPosition(clientId)

	for zoneShape, zoneName in pairs(syncZones) do
		if isInsideColShape(zoneShape, playerX, playerY, playerZ) then
			return zoneName
		end
	end

	return false
end


function playerEnterSyncZone(clientId, zoneId, dimensionId)
	if zoneId then
		local currentTime = getTickCount()
		for i = 1, #playersPerSyncZone[zoneId] do
			if playersPerSyncZone[zoneId][i] == clientId then
				return
			end
		end

		for i = 1, #tablesPerDimension[dimensionId] do
			local tableId = tablesPerDimension[dimensionId][i]

			if tableId then
				local tableData = fortuneCupTables[tableId]

				if tableData then
					local broadcastData = {}

					for dataName, originName in pairs(streamingData) do
						local dataValue = tableData[dataName]

						if type(originName) == "string" then
							broadcastData[originName] = dataValue
						else
							broadcastData[dataName] = dataValue
						end
					end
					tableData.streamedPlayers = playersPerSyncZone[zoneId]
					triggerLatentClientEvent(clientId, "gotHorseeTableData", clientId,
						tableId,
						broadcastData,
						countdownStarted[tableId] and currentTime - countdownStarted[tableId],
						horseRaceStarted[tableId] and currentTime - horseRaceStarted[tableId]
					)
				end
			end
		end

		if not playerSyncZone[clientId] then
			table.insert(playersPerSyncZone[zoneId], clientId)
		end

		playerSyncZone[clientId] = zoneId
	end
end

function playerLeaveSyncZone(clientId, zoneId, dimensionId)
	if zoneId then
		triggerClientEvent(clientId, "streamOutHorsee", clientId, dimensionId)

		for i = #playersPerSyncZone[zoneId], 1, -1 do
			if playersPerSyncZone[zoneId][i] == clientId then
				table.remove(playersPerSyncZone[zoneId], i)
				break
			end
		end

		playerSyncZone[clientId] = nil
	end
end

---------------------------------------------------------------------------------------------------

function playerJoinFortuneCup(clientId, tableId, seatId)
	local tableData = fortuneCupTables[tableId]

	if tableData then
		if playerPlayingTables[clientId] then
			return
		end

		if tableData.currentPlayers[seatId] then
			return exports.sGui:showInfobox(clientId, "e", "Ez a hely már foglalt!")
		end

		tableData.currentPlayers[seatId] = clientId

		if #tableData.streamedPlayers > 0 then
			triggerClientEvent(tableData.streamedPlayers, "gotHorseePlayer", resourceRoot, tableId, seatId, clientId)
		end

		playerPlayingTables[clientId] = tableId
	end
end

function playerExitFortuneCup(clientId)
	local tableId = playerPlayingTables[clientId]
	if not tableId then
		return
	end

	local tableData = fortuneCupTables[tableId]
	if not tableData then
		return
	end

	if eventName == "tryToExitHorsee" then
		local betsOnTable = false

		for seatId, userId in pairs(tableData.currentPlayers) do
			if userId == clientId then
				if next(tableData.playerBets[seatId]) then
					betsOnTable = true
					break
				elseif tableData.playerSideBets[seatId] then
					for quinellaA in pairs(tableData.playerSideBets[seatId]) do
						if next(tableData.playerSideBets[seatId][quinellaA]) then
							betsOnTable = true
							break
						end
					end
				end
			end
		end

		if betsOnTable then
			return exports.sGui:showInfobox(clientId, "e", "Amíg érvényes téted van az asztalon, nem állhatsz fel!")
		end
	end

	for seatId, userId in pairs(tableData.currentPlayers) do
		if userId == clientId then
			local totalBets = 0

			if tableData.winnerPlayers then
				totalBets = tableData.winnerPlayers[clientId] or 0
			else
				local winnerId = tableData.matchFinishOrder[1]
				local runnerUp = tableData.matchFinishOrder[2]

				local quinellaA = math.max(winnerId, runnerUp)
				local quinellaB = math.min(winnerId, runnerUp)

				for horseId, horseBet in pairs(tableData.playerBets[seatId]) do
					totalBets = totalBets + horseBet
				end
	
				for horseId, quinellaBet in pairs(tableData.playerSideBets[seatId][quinellaA]) do
					totalBets = totalBets + quinellaBet
				end
			end

			if totalBets > 0 then
                exports.sCore:setSSC(clientId, exports.sCore:getSSC(clientId) + totalBets)
				--setElementData(clientId, "char.slotCoins", (getElementData(clientId, "char.slotCoins") or 0) + totalBets)
			end

			if eventName ~= "onResourceStop" then
				triggerClientEvent(tableData.streamedPlayers, "gotHorseePlayer", resourceRoot, tableId, seatId, false)
			end

			tableData.playerBets[seatId] = {}
			tableData.playerSideBets[seatId] = {}
			tableData.currentPlayers[seatId] = nil

			for quinellaA = 1, horseNum do
				tableData.playerSideBets[seatId][quinellaA] = {}
			end

			break
		end
	end

	playerPlayingTables[clientId] = nil
end

---------------------------------------------------------------------------------------------------

function registerFortuneCupEvent(eventName, baseElement, callbackFunction, ...)
	addEvent(eventName, true)
	addEventHandler(eventName, baseElement,
		function (...)
			if client then
				local tableId = playerPlayingTables[client]
				if tableId then
					callbackFunction(fortuneCupTables[tableId], ...)
				end
			end
		end
	)
end

function initHorseTables()
	for i = 1, #tableList do
		local interiorId, dimensionId = tableList[i][5], tableList[i][6]

		if not fortuneCupTables[i] then
			local tableData = {}

			tableData.tableId = i

			tableData.currentPlayers = {}
			tableData.streamedPlayers = {}

			tableData.gameHistory = {}
			
			for j = 1, #syncZoneCoords do
				local zoneInterior, zoneDimension, zoneName = unpack(syncZoneCoords[j], 5)

				if zoneInterior == interiorId and zoneDimension == dimensionId then
					tableData.streamedPlayers = playersPerSyncZone[zoneName]
					break
				end
			end
			
			fortuneCupTables[i] = tableData
		end
	end

	for tableId in pairs(fortuneCupTables) do
		generateMatch(fortuneCupTables[tableId], true)
	end
end

---------------------------------------------------------------------------------------------------

function getPlayerTableSeat(clientId, tableData)
	for spotId, userId in pairs(tableData.currentPlayers) do
		if userId == clientId then
			return spotId
		end
	end
end

function isValidCoin(coinValue)
	for i = 1, #coinValues do
		if coinValues[i] == math.abs(coinValue) then
			return true
		end
	end
	return false
end

registerFortuneCupEvent("horseePlaceBet", root,
	function (tableData, horseA, horseB, coinAmount)
		if not tableData.bettingEnabled then
			return
		elseif isValidCoin(coinAmount) then
			local seatId = getPlayerTableSeat(client, tableData)

			if seatId then
                local slotCoins = exports.sCore:getSSC(client)
				--local slotCoins = getElementData(client, "char.slotCoins") or 0

				if horseA then
					local playerBets = tableData.playerBets[seatId]
					local playerSideBets = tableData.playerSideBets[seatId]

					if horseB then
						local previousQuinellaBet = playerSideBets[horseA][horseB]

						if coinAmount > 0 then
							if (previousQuinellaBet or 0) + coinAmount < minBetSide then
								coinAmount = minBetSide
							end

							if slotCoins >= coinAmount then
                                exports.sCore:setSSC(client, slotCoins - coinAmount)
                                --setElementData(client, "char.slotCoins", slotCoins - coinAmount)

								if not previousQuinellaBet then
									playerSideBets[horseA][horseB] = coinAmount
								else
									playerSideBets[horseA][horseB] = playerSideBets[horseA][horseB] + coinAmount
								end

								if not countdownStarted[tableData.tableId] then
									countdownStarted[tableData.tableId] = getTickCount()
								end
			
								if not pulseTimer then
									pulseTimer = setTimer(doPulse, 1000, 0)
								end
							else
								exports.sGui:showInfobox(client, "e", "Nincs elegendő SSC egyenleged!")
							end
						elseif previousQuinellaBet then
							coinAmount = math.abs(coinAmount)

							if previousQuinellaBet - coinAmount < minBetSide then
								coinAmount = previousQuinellaBet
							end
							
							playerSideBets[horseA][horseB] = playerSideBets[horseA][horseB] - coinAmount

							if playerSideBets[horseA][horseB] <= 0 then
								playerSideBets[horseA][horseB] = nil
							end

                            exports.sCore:setSSC(client, slotCoins + coinAmount)
							--setElementData(client, "char.slotCoins", slotCoins + coinAmount)
						end

						local currentQuinellaBet = playerSideBets[horseA][horseB]

						if currentQuinellaBet ~= previousQuinellaBet then
							triggerClientEvent(tableData.streamedPlayers, "gotNewHorseeBet", client, tableData.tableId, seatId, horseA, horseB, currentQuinellaBet)
						end
					else
						local previousHorseBet = playerBets[horseA]

						if coinAmount > 0 then
							if (previousHorseBet or 0) + coinAmount < minBet then
								coinAmount = minBet
							end

							if slotCoins >= coinAmount then
								exports.sCore:setSSC(client, slotCoins - coinAmount)
                                --setElementData(client, "char.slotCoins", slotCoins - coinAmount)

								if not previousHorseBet then
									playerBets[horseA] = coinAmount
								else
									playerBets[horseA] = playerBets[horseA] + coinAmount
								end

								if not countdownStarted[tableData.tableId] then
									countdownStarted[tableData.tableId] = getTickCount()
								end
			
								if not pulseTimer then
									pulseTimer = setTimer(doPulse, 1000, 0)
								end
							else
								exports.sGui:showInfobox(client, "e", "Nincs elegendő SSC egyenleged!")
							end
						elseif previousHorseBet then
							coinAmount = math.abs(coinAmount)

							if previousHorseBet - coinAmount < minBet then
								coinAmount = previousHorseBet
							end
							
							playerBets[horseA] = playerBets[horseA] - coinAmount

							if playerBets[horseA] <= 0 then
								playerBets[horseA] = nil
							end

                            exports.sCore:setSSC(client, slotCoins + coinAmount)
							--setElementData(client, "char.slotCoins", slotCoins + coinAmount)
						end

						local currentHorseBet = playerBets[horseA]

						if currentHorseBet ~= previousHorseBet then
							triggerClientEvent(tableData.streamedPlayers, "gotNewHorseeBet", client, tableData.tableId, seatId, horseA, false, currentHorseBet)
						end
					end
				end
			end
		end
	end
)

function doPulse()
	local currentTime = getTickCount()

	for tableId in pairs(countdownStarted) do
		local tableData = fortuneCupTables[tableId]

		if tableData then
			local elapsedTime = currentTime - countdownStarted[tableId]

			if elapsedTime > countdownTime * 1000 then
				startMatch(tableData)
				countdownStarted[tableId] = nil
			end
		end
	end

	for tableId in pairs(horseRaceStarted) do
		local tableData = fortuneCupTables[tableId]

		if tableData then
			local elapsedTime = currentTime - horseRaceStarted[tableId]

			if elapsedTime > tableData.matchTime + 8000 + goHomeTime * 1000 then
				generateMatch(tableData)
				horseRaceStarted[tableId] = nil
			elseif elapsedTime > tableData.matchTime + 8000 + 4500 then
				payoutWinners(tableData)
			end
		end
	end

	if not (next(countdownStarted) or next(horseRaceStarted)) then
		killTimer(pulseTimer)
		pulseTimer = nil
	end
end

function generateMatch(tableData, firstMatch)
	-- Add the previous match to the history
	if not firstMatch then
		local quinellaA = math.max(tableData.winnerId, tableData.runnerUp)
		local quinellaB = math.min(tableData.winnerId, tableData.runnerUp)

		table.insert(tableData.gameHistory, {
			tableData.cupName,
			tableData.winnerId,
			tableData.runnerUp,
			tableData.horseNames[tableData.winnerId],
			tableData.horseNames[tableData.runnerUp],
			tableData.horseOdds[tableData.winnerId],
			tableData.horseSideOdds[quinellaA][quinellaB]
		})

		while #tableData.gameHistory > 20 do
			table.remove(tableData.gameHistory, 1)
		end
	end

	-- Reset variables
	local lastCupName = tableData.cupName
	local lastCupTheme = tableData.cupTheme
	local lastCupBackground = tableData.cupBackground

	while tableData.cupName == lastCupName do
		tableData.cupName = math.random(1, #cupNames)
	end

	while tableData.cupTheme == lastCupTheme do
		tableData.cupTheme = math.random(1, 4)
	end

	while tableData.cupBackground == lastCupBackground do
		tableData.cupBackground = math.random(1, 6)
	end

	local availableHorseNames = {}
	local nameUsedInLastMatch = {}

	if tableData.horseNames then
		for horseId = 1, horseNum do
			nameUsedInLastMatch[tableData.horseNames[horseId]] = true
		end
	end

	for nameId = 1, #horseNames do
		if not nameUsedInLastMatch[nameId] then
			table.insert(availableHorseNames, nameId)
		end
	end

	tableData.winnerId = nil
	tableData.runnerUp = nil

	tableData.winCount = nil
	tableData.loseCount = nil

	tableData.horseNames = {}

	for horseId = 1, horseNum do
		tableData.horseNames[horseId] = table.remove(availableHorseNames, math.random(1, #availableHorseNames))
	end

	tableData.playerBets = {}
	tableData.playerSideBets = {}

	for seatId = 1, seats do
		tableData.playerBets[seatId] = {}
		tableData.playerSideBets[seatId] = {}
	end

	for horseId = 1, horseNum do
		for seatId = 1, seats do
			tableData.playerSideBets[seatId][horseId] = {}
		end
	end

	tableData.horseOdds = {}
	tableData.horseSideOdds = {}

	for horseId = 1, horseNum do
		tableData.horseOdds[horseId] = 0
	end

	for horseA = 1, horseNum do
		tableData.horseSideOdds[horseA] = {}

		for horseB = 1, horseA - 1 do
			tableData.horseSideOdds[horseA][horseB] = 0
		end
	end

	tableData.matchTime = 0 -- overall time
	tableData.horseKeyframes = {} -- [horse] = {{t, a, p, v}, ...}
	tableData.horseFinishTime = {} -- [horse] = time
	tableData.horseFinalPosition = {} -- [horse] = position

	-- Simulate a race
	local actionsSum = 0
	local actionWeights = {
		increaseSpeed = 3,
		decreaseSpeed = 3,
		keepSameSpeed = 5
	}

	for actionName, actionWeight in pairs(actionWeights) do
		actionsSum = actionsSum + actionWeight
	end

	for horseId = 1, horseNum do
		local simulationTime = 0
		local actualPosition = 0
		local actualVelocity = 0
		
		tableData.horseKeyframes[horseId] = {}

		while true do
			local selectedAction = false

			if actualVelocity == 0 then
				selectedAction = "increaseSpeed"
			else
				local cumulativeSum = math.random() * actionsSum

				for actionName, actionWeight in pairs(actionWeights) do
					cumulativeSum = cumulativeSum - actionWeight

					if cumulativeSum <= 0 then
						selectedAction = actionName
						break
					end
				end
			end

			local targetVelocity

			if selectedAction == "increaseSpeed" then
				if actualVelocity == 0 then
					targetVelocity = (25 + math.random() * 15) / 1000
				else
					targetVelocity = math.min(45 / 1000, actualVelocity + math.random(5, 10) / 1000)
				end
			elseif selectedAction == "decreaseSpeed" then
				targetVelocity = math.max(25 / 1000, actualVelocity - math.random(5, 10) / 1000)
			else
				targetVelocity = actualVelocity
			end

			local keyframeDuration = actualVelocity == 0 and 3 or math.random(1000, 2000) / 1000
			local accelerationRate = (targetVelocity - actualVelocity) / keyframeDuration

			local futurePosition = actualPosition + actualVelocity * keyframeDuration + 0.5 * accelerationRate * keyframeDuration ^ 2
			local futureVelocity = actualVelocity + accelerationRate * keyframeDuration

			if futurePosition >= 1 then
				local finishLineDistance = 1 - (futurePosition - 1) / (futurePosition - actualPosition)

				if finishLineDistance >= 0 then
					tableData.horseFinishTime[horseId] = simulationTime + keyframeDuration * finishLineDistance
				end
			end

			table.insert(tableData.horseKeyframes[horseId], {1000 * keyframeDuration, accelerationRate, actualPosition, actualVelocity})
			simulationTime = simulationTime + keyframeDuration

			actualPosition = futurePosition
			actualVelocity = futureVelocity
			
			if actualPosition >= 1 then
				break
			end
		end

		local decelerationTime = math.random(2000, 4000) / 1000
		local decelerationRate = -actualVelocity / decelerationTime

		table.insert(tableData.horseKeyframes[horseId], {1000 * decelerationTime, decelerationRate, actualPosition, actualVelocity})
		simulationTime = simulationTime + decelerationTime

		actualPosition = actualPosition + actualVelocity * decelerationTime + 0.5 * decelerationRate * decelerationTime ^ 2
		actualVelocity = 0

		tableData.horseFinalPosition[horseId] = actualPosition

		if simulationTime > tableData.matchTime then
			tableData.matchTime = simulationTime
		end
	end

	-- Determine the finish order
	tableData.matchFinishOrder = {} -- [place] = horse

	for horseId = 1, horseNum do
		table.insert(tableData.matchFinishOrder, horseId)
	end

	table.sort(tableData.matchFinishOrder, function (horseA, horseB)
		return tableData.horseFinishTime[horseA] < tableData.horseFinishTime[horseB]
	end)

	-- Handle rigged next winner
	if tableData.riggedWinner then
		local winnerHorse = tableData.matchFinishOrder[1]
		local winnerIndex = 1

		local riggedHorse = tableData.riggedWinner
		local riggedIndex = 1

		for i = 1, horseNum do
			if tableData.matchFinishOrder[i] == riggedHorse then
				riggedIndex = i
				break
			end
		end

		table.swap(tableData.horseKeyframes,     riggedHorse, winnerHorse)
		table.swap(tableData.horseFinishTime,    riggedHorse, winnerHorse)
		table.swap(tableData.horseFinalPosition, riggedHorse, winnerHorse)
		table.swap(tableData.matchFinishOrder,   winnerIndex, riggedIndex)

		tableData.riggedWinner = nil
	end

	-- Calculate the odds (TODO: Better formula needed!)
	for rankId = 1, horseNum do
		local horseId = tableData.matchFinishOrder[rankId]

		if horseId then
			tableData.horseOdds[horseId] = math.pow(2, 1 + tableData.horseFinishTime[horseId] / tableData.matchTime)
		end
	end

	-- Odds faking
	if math.random() < 0.35 then
		table.swap(tableData.horseOdds, tableData.matchFinishOrder[1], tableData.matchFinishOrder[2])
	end

	for horseA = horseNum, 2, -1 do
		local horseB = math.random(horseA)

		if math.random() < 0.1 then
			table.swap(tableData.horseOdds, horseA, horseB)
		end
	end

	-- Calculate the side odds
	local exponentialPower = 0.75
	local randomScaleFactor = math.random() + 1 -- 1..2
	local randomBonusFactor = math.random() -- 0..1

	for horseA = 1, horseNum do
		local oddsA = tableData.horseOdds[horseA]

		for horseB = 1, horseA - 1 do
			local oddsB = tableData.horseOdds[horseB]

			tableData.horseSideOdds[horseA][horseB] = randomScaleFactor * math.pow(oddsA*oddsB, exponentialPower) + randomBonusFactor * (oddsA+oddsB)
		end
	end

	-- Sync if it is not the initial match
	tableData.matchTime = tableData.matchTime * 1000

	if not firstMatch then
		triggerClientEvent(tableData.streamedPlayers, "newHorseeMatch", resourceRoot, tableData.tableId, tableData.horseOdds, tableData.horseSideOdds, tableData.horseNames, tableData.cupName, tableData.cupBackground, tableData.cupTheme)
	end

	tableData.bettingEnabled = true
end

function startMatch(tableData)
	if not horseRaceStarted[tableData.tableId] then
		tableData.bettingEnabled = false

		tableData.winCount = {}
		tableData.loseCount = {}

		tableData.winnerId = tableData.matchFinishOrder[1]
		tableData.runnerUp = tableData.matchFinishOrder[2]
		
		local quinellaA = math.max(tableData.winnerId, tableData.runnerUp)
		local quinellaB = math.min(tableData.winnerId, tableData.runnerUp)

		tableData.winnerPlayers = {}

		for seatId, clientId in pairs(tableData.currentPlayers) do
			local totalPayout = 0

			for horseId, horseBets in pairs(tableData.playerBets[seatId]) do
				if horseId == tableData.winnerId then
					totalPayout = totalPayout + horseBets * floorOdds(tableData.horseOdds[horseId])

					if not tableData.winCount[seatId] then
						tableData.winCount[seatId] = 1
					else
						tableData.winCount[seatId] = tableData.winCount[seatId] + 1
					end
				elseif not tableData.loseCount[seatId] then
					tableData.loseCount[seatId] = 1
				else
					tableData.loseCount[seatId] = tableData.loseCount[seatId] + 1
				end
			end

			for horseId, quinellaBets in pairs(tableData.playerSideBets[seatId][quinellaA]) do
				if horseId == quinellaB then
					totalPayout = totalPayout + quinellaBets * floorOdds(tableData.horseSideOdds[quinellaA][quinellaB])
					
					if not tableData.winCount[seatId] then
						tableData.winCount[seatId] = 1
					else
						tableData.winCount[seatId] = tableData.winCount[seatId] + 1
					end
				elseif not tableData.loseCount[seatId] then
					tableData.loseCount[seatId] = 1
				else
					tableData.loseCount[seatId] = tableData.loseCount[seatId] + 1
				end
			end

			if totalPayout > 0 then
				tableData.winnerPlayers[clientId] = totalPayout
			end
		end

		horseRaceStarted[tableData.tableId] = getTickCount()

		if not pulseTimer then
			pulseTimer = setTimer(doPulse, 1000, 0)
		end
		
		triggerClientEvent(tableData.streamedPlayers, "startHorseeMatch", resourceRoot, tableData.tableId, tableData.matchTime, tableData.horseKeyframes, tableData.horseFinishTime, tableData.horseFinalPosition, tableData.matchFinishOrder, tableData.winCount, tableData.loseCount)
	end
end

function payoutWinners(tableData)
	if tableData.winnerPlayers then
		for clientId, totalPayout in pairs(tableData.winnerPlayers) do
			if isElement(clientId) then
                exports.sCore:setSSC(clientId, exports.sCore:getSSC(clientId) + totalPayout)
				--setElementData(clientId, "char.slotCoins", (getElementData(clientId, "char.slotCoins") or 0) + totalPayout)
			end
		end
		tableData.winnerPlayers = nil
	end
end

function table.swap(t, a, b)
	t[a], t[b] = t[b], t[a]
end

---------------------------------------------------------------------------------------------------

addCommandHandler("horseemaffia",
	function (clientId, commandName, nextWinner)
		if exports.sPermission:hasPermission(clientId, "horseemaffia") then
			local tableId = playerPlayingTables[clientId]

			if tableId then
				local tableData = fortuneCupTables[tableId]

				if tableData then
					outputChatBox("[color=sightyellow][SightMTA - Horsee]: [color=hudwhite]Sikeresen beállítottad az asztal nyertes lovát! [color=sightyellow]("..nextWinner..")", sourcePlayer)

					tableData.riggedWinner = tonumber(nextWinner)
				end
			end
		end
	end
)

addCommandHandler("horseewinners",
	function (clientId, commandName)
		if exports.sPermission:hasPermission(clientId, "horseemaffia") then
			local tableId = playerPlayingTables[clientId]

			if tableId then
				local tableData = fortuneCupTables[tableId]

				if tableData then
					outputChatBox("[color=sightyellow][SightMTA - Horsee]: [color=white]Jövőbeli rangsor:", clientId, 255, 255, 255, true)

					for rankId = 1, horseNum do
						outputChatBox(("    %d. [color=sightyellow]%s"):format(rankId, horseNames[tableData.horseNames[tableData.matchFinishOrder[rankId]]]), clientId, 255, 255, 255, true)
					end
				end
			end
		end
	end
)