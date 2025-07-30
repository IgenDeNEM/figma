local tablesPerDimension = {}

local syncZones = {}
local playerSyncZone = {}
local playersPerSyncZone = {}

local rouletteGameTables = {}
local playerPlayingTables = {}

local streamingData = {
	currentPlayers = "players",
	currentBets = "bets",
	lastPos = true,
	lastNumber = true,
}

local pulseTimer = false

---------------------------------------------------------------------------------------------------

addEventHandler("onResourceStart", resourceRoot,
	function ()
		initSyncZones()
		initRouletteTables()
	end
)

addEventHandler("onResourceStop", resourceRoot,
	function ()
		for clientId in pairs(playerPlayingTables) do
			playerExitRoulette(clientId)
		end
	end
)

addEvent("requestRouletteMachine", true)
addEventHandler("requestRouletteMachine", root,
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

		playerExitRoulette(source)
	end,
true, "high+1")

addEvent("tryToSitDownRoulette", true)
addEventHandler("tryToSitDownRoulette", root,
	function (tableId, seatId)
		if client then
			playerJoinRoulette(client, tableId, seatId)
		end
	end
)

addEvent("tryToExitRoulette", true)
addEventHandler("tryToExitRoulette", root,
	function ()
		if client then
			playerExitRoulette(client)
		end
	end
)

---------------------------------------------------------------------------------------------------

function initSyncZones()
	for i = 1, #rouletteTableCoords do
		local dimensionId = rouletteTableCoords[i][6]

		if not tablesPerDimension[dimensionId] then
			tablesPerDimension[dimensionId] = {}
		end

		table.insert(tablesPerDimension[dimensionId], i)
	end

	for i = 1, #syncZoneCoords do
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
			local rouletteTableId = tablesPerDimension[dimensionId][i]

			if rouletteTableId then
				local rouletteTable = rouletteGameTables[rouletteTableId]

				if rouletteTable then
					local broadcastData = {}

					for dataName, originName in pairs(streamingData) do
						local dataValue = rouletteTable[dataName]

						if type(originName) == "string" then
							broadcastData[originName] = dataValue
						else
							broadcastData[dataName] = dataValue
						end
						rouletteTable.streamedPlayers = playersPerSyncZone[zoneId]
					end

					triggerLatentClientEvent(clientId, "streamInRoulette", clientId,
						rouletteTableId,
						broadcastData,
						rouletteTable.spinUpStarted    and currentTime - rouletteTable.spinUpStarted,
						rouletteTable.slowDownStarted  and currentTime - rouletteTable.slowDownStarted,
						rouletteTable.bounceStarted    and currentTime - rouletteTable.bounceStarted,
						rouletteTable.bounceStarted    and               rouletteTable.bounceNum,
						rouletteTable.bettingStarted   and currentTime - rouletteTable.bettingStarted,
						rouletteTable.gameHistory
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
		triggerClientEvent(clientId, "streamOutRoulettes", clientId)

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

function registerRouletteEvent(eventName, baseElement, callbackFunction, ...)
	addEvent(eventName, true)
	addEventHandler(eventName, baseElement,
		function (...)
			if client then
				local tableId = playerPlayingTables[client]
				if tableId then
					callbackFunction(rouletteGameTables[tableId], ...)
				end
			end
		end
	)
end

function initRouletteTables()
	for i = 1, #rouletteTableCoords do
		local interiorId, dimensionId = rouletteTableCoords[i][5], rouletteTableCoords[i][6]

		if not rouletteGameTables[i] then
			local rouletteTable = {}

			rouletteTable.tableId = i

			rouletteTable.currentPlayers = {}
			rouletteTable.streamedPlayers = {}
			
			for j = 1, #syncZoneCoords do
				local zoneInterior, zoneDimension, zoneName = unpack(syncZoneCoords[j], 5)

				if zoneInterior == interiorId and zoneDimension == dimensionId then
					rouletteTable.streamedPlayers = playersPerSyncZone[zoneName]
					break
				end
			end

			rouletteTable.bettingEnabled = true

			rouletteTable.lastPos = math.random(0, 36)
			rouletteTable.lastNumber = rouletteWheelNums[rouletteTable.lastPos + 1]

			rouletteTable.currentBets = {}
			rouletteTable.gameHistory = {rouletteTable.lastNumber}
			
			for seatId = 1, 8 do
				rouletteTable.currentBets[seatId] = {}
			end
			
			rouletteGameTables[i] = rouletteTable
		end
	end
end

function playerJoinRoulette(clientId, tableId, seatId)
	local rouletteTable = rouletteGameTables[tableId]

	if rouletteTable then
		if playerPlayingTables[clientId] then
			return
		end

		if rouletteTable.currentPlayers[seatId] then
			return exports.sGui:showInfobox(clientId, "e", "Ez a hely már foglalt!")
		end

		rouletteTable.currentPlayers[seatId] = clientId

		if #rouletteTable.streamedPlayers > 0 then
			triggerClientEvent(rouletteTable.streamedPlayers, "gotRoulettePlayer", resourceRoot, tableId, seatId, clientId)
		end

		playerPlayingTables[clientId] = tableId
	end
end

function playerExitRoulette(clientId)
	local tableId = playerPlayingTables[clientId]
	if not tableId then
		return
	end

	local rouletteTable = rouletteGameTables[tableId]
	if not rouletteTable then
		return
	end

	if eventName == "tryToExitRoulette" then
		for seatId, userId in pairs(rouletteTable.currentPlayers) do
			if userId == clientId then
				if next(rouletteTable.currentBets[seatId]) then
					return exports.sGui:showInfobox(clientId, "e", "Amíg érvényes téted van az asztalon, nem állhatsz fel!")
				end
			end
		end
	end

	for seatId, userId in pairs(rouletteTable.currentPlayers) do
		if userId == clientId then
			local totalBets = 0

			if rouletteTable.winnerPlayers then
				totalBets = rouletteTable.winnerPlayers[clientId] or 0
			else
				for betType, betAmount in pairs(rouletteTable.currentBets[seatId]) do
					totalBets = totalBets + betAmount
				end
			end

			if totalBets > 0 then
                exports.sCore:setSSC(clientId, exports.sCore:getSSC(clientId) + totalBets)
			end

			if eventName ~= "onResourceStop" then
				triggerClientEvent(rouletteTable.streamedPlayers, "gotRoulettePlayer", resourceRoot, tableId, seatId, false)
			end

			rouletteTable.currentBets[seatId] = {}
			rouletteTable.currentPlayers[seatId] = nil

			break
		end
	end

	playerPlayingTables[clientId] = nil
end

---------------------------------------------------------------------------------------------------

registerRouletteEvent("tryToAddRouletteBet", root,
	function (rouletteTable, selectedBet, selectedCoin)
		if not rouletteTable.bettingEnabled then
			return
		end

		if rouletteTable.bettingStarted then
			if getTickCount() - rouletteTable.bettingStarted > countdownTime * 1000 then
				return
			end
		end

		local validCoin = false

		for i = 1, #coinValues do
			if coinValues[i] == math.abs(selectedCoin) then
				validCoin = true
				break
			end
		end

		local seatId = false

		for spotId, userId in pairs(rouletteTable.currentPlayers) do
			if userId == client then
				seatId = spotId
				break
			end
		end

		if validCoin then
			local slotCoins = exports.sCore:getSSC(client) or 0
			local betFields = {}

			if validBets[selectedBet] then
				local betTable = validBets[selectedBet]

				if type(betTable) == "table" and betTable[1] == "n" then
					local betNumber = betTable[2]

					if selectedCoin <= 0 or slotCoins >= selectedCoin * 3 then
						for i = 1, #neighbours[betNumber] do
							table.insert(betFields, neighbours[betNumber][i])
						end
					end
				elseif selectedCoin <= 0 or slotCoins >= selectedCoin then
					table.insert(betFields, selectedBet)
				end
			else
				local betAmount = _G[selectedBet.."Amount"]
				local betsTable = _G[selectedBet.."Bets"]
	
				if selectedCoin <= 0 or slotCoins >= selectedCoin * betAmount then
					for i = 1, #betsTable do
						table.insert(betFields, betsTable[i])
					end
				end
			end

			if #betFields > 0 then
				local currentBets = rouletteTable.currentBets[seatId]

				if selectedCoin > 0 then
					local totalBets = 0
					local coinAmount = 0

					for i = 1, #betFields do
						local betType = betFields[i]

						coinAmount = coinAmount + selectedCoin

						if currentBets[betType] then
							totalBets = totalBets + currentBets[betType]
						end
					end

					if totalBets + coinAmount >= minBet then
                        exports.sCore:setSSC(client, slotCoins - coinAmount)

						for i = 1, #betFields do
							local betType = betFields[i]
							local betWas = currentBets[betType]

							if not currentBets[betType] then
								currentBets[betType] = selectedCoin
							else
								currentBets[betType] = currentBets[betType] + selectedCoin
							end

							if not rouletteTable.bettingStarted then
								rouletteTable.bettingStarted = getTickCount()

								if not pulseTimer then
									pulseTimer = setTimer(doPulse, 1000, 0)
								end
							end

							if currentBets[betType] ~= betWas then
								triggerClientEvent(rouletteTable.streamedPlayers, "gotNewRouletteBet", client, rouletteTable.tableId, seatId, betType, currentBets[betType], i ~= 1)
							end
						end
					else
						exports.sGui:showInfobox(client, "e", "Minimum tét: " .. minBet .. " SSC")
					end
				else
					local totalCoins = 0

					for i = 1, #betFields do
						local betType = betFields[i]
						local betWas = currentBets[betType]

						if currentBets[betType] then
							local coinAmount = math.min(currentBets[betType], math.abs(selectedCoin))

							if currentBets[betType] - coinAmount < minBet then
								coinAmount = currentBets[betType]
							end
							
							currentBets[betType] = currentBets[betType] - coinAmount

							if currentBets[betType] <= 0 then
								currentBets[betType] = nil
							end

							totalCoins = totalCoins + coinAmount
						end

						if currentBets[betType] ~= betWas then
							triggerClientEvent(rouletteTable.streamedPlayers, "gotNewRouletteBet", client, rouletteTable.tableId, seatId, betType, currentBets[betType], i ~= 1)
						end
					end

					if totalCoins > 0 then
                        exports.sCore:setSSC(client, slotCoins + totalCoins)
					end
				end
			else
				exports.sGui:showInfobox(client, "e", "Nincs elegendő SSC egyenleged!")
			end
		end
	end
)

function doPulse()
	local currentTime = getTickCount()

	local rouletteCount = 0
	local inactiveCount = 0

	for rouletteTableId, rouletteTable in pairs(rouletteGameTables) do
		rouletteCount = rouletteCount + 1

		if rouletteTable.bettingStarted then
			if currentTime - rouletteTable.bettingStarted > countdownTime * 1000 + 2500 then
				spinUpBall(rouletteTable)
			end
		elseif rouletteTable.spinUpStarted then
			if currentTime - rouletteTable.spinUpStarted > rouletteTable.spinUpDuration then
				slowDownBall(rouletteTable)
			end
		elseif rouletteTable.slowDownStarted then
			if currentTime - rouletteTable.slowDownStarted > rouletteTable.slowDownDuration then
				bounceBall(rouletteTable)
			end
		elseif rouletteTable.bounceStarted then
			if currentTime > rouletteTable.bounceEnded then
				startNewRound(rouletteTable)
			end
		else
			inactiveCount = inactiveCount + 1
		end
	end

	if rouletteCount == inactiveCount then
		killTimer(pulseTimer)
		pulseTimer = nil
	end
end

function spinUpBall(rouletteTable)
	if rouletteTable.bettingStarted then
		rouletteTable.bettingEnabled = false

		rouletteTable.spinUpStarted = getTickCount()
		rouletteTable.spinUpDuration = math.random(3000, 6000)

		rouletteTable.bettingStarted = nil

		if #rouletteTable.streamedPlayers > 0 then
			triggerClientEvent(rouletteTable.streamedPlayers, "rouletteSpinUpBall", resourceRoot, rouletteTable.tableId)
		end
	end
end

function slowDownBall(rouletteTable)
	if rouletteTable.spinUpStarted then
		rouletteTable.bettingEnabled = false

		rouletteTable.slowDownStarted = getTickCount()
		rouletteTable.slowDownDuration = math.random(3000, 6000)
		
		rouletteTable.spinUpStarted = nil
		rouletteTable.spinUpDuration = nil

		if #rouletteTable.streamedPlayers > 0 then
			triggerClientEvent(rouletteTable.streamedPlayers, "rouletteSlowDownBall", resourceRoot, rouletteTable.tableId)
		end
	end
end

function bounceBall(rouletteTable)
	if rouletteTable.slowDownStarted then
		local winPos = rouletteTable.riggedNum or math.random(0, 36)
		local winNum = rouletteWheelNums[winPos + 1]

		local betTable = {}
		local winTable = {}

		local winCount = 0

		rouletteTable.winnerPlayers = {}

		for seatId = 1, 8 do
			local totalWins = 0
			local totalBets = 0
			local totalPayout = 0

			for betType, betAmount in pairs(rouletteTable.currentBets[seatId]) do
				totalBets = totalBets + betAmount

				for i = 1, #winnerBets[winNum] do
					local winnerBetType = winnerBets[winNum][i]

					if betType == winnerBetType then
						totalWins = totalWins + 1
						totalPayout = totalPayout + betAmount * (payoutsForBets[betType] + 1)
					end
				end
			end

			if totalPayout > 0 then
				local clientId = rouletteTable.currentPlayers[seatId]

				if isElement(clientId) then
					rouletteTable.winnerPlayers[clientId] = totalPayout
				end
			end

			winTable[seatId] = totalWins
			betTable[seatId] = totalBets

			if totalBets <= 0 then
				winTable[seatId] = nil
				betTable[seatId] = nil
			else
				if winTable[seatId] <= 0 then
					winTable[seatId] = nil
				end
	
				if betTable[seatId] <= 0 then
					betTable[seatId] = nil
				end
			end

			if totalWins > 0 then
				winCount = winCount + 1
			end
		end

		rouletteTable.bettingEnabled = false
	
		rouletteTable.bounceStarted = getTickCount()
		rouletteTable.bounceNum = math.random(1, 4)

		rouletteTable.slowDownStarted = nil
		rouletteTable.slowDownDuration = nil

		rouletteTable.lastPos = winPos
		rouletteTable.riggedNum = nil

		local totalTime = (pif + oneRad * winPos) / (wrSpeedRad + slowSpeed)
		local bounceTime = 0.45 * math.pow(1 / 1.165, rouletteTable.bounceNum)
		for i = 1, rouletteTable.bounceNum do
			bounceTime = bounceTime * 1.15
			totalTime = totalTime + bounceTime
		end
		totalTime = totalTime + bounceTime * 1.25
		rouletteTable.bounceEnded = rouletteTable.bounceStarted + totalTime * 1000 + 1000 + 3500 + 450 * winCount + 2000

		if #rouletteTable.streamedPlayers > 0 then
			triggerClientEvent(rouletteTable.streamedPlayers, "rouletteBounceTheBall", resourceRoot, rouletteTable.tableId, rouletteTable.lastPos, rouletteTable.bounceNum, winTable, betTable)
		end
	end
end

function startNewRound(rouletteTable)
	if rouletteTable.bounceStarted then
		table.insert(rouletteTable.gameHistory, rouletteWheelNums[rouletteTable.lastPos + 1])

		if #rouletteTable.gameHistory > 25 then
			table.remove(rouletteTable.gameHistory, 1)
		end

		rouletteTable.bettingEnabled = true
		rouletteTable.gameStageTimer = nil

		rouletteTable.bounceStarted = nil
		rouletteTable.bounceEnded = nil
		rouletteTable.bounceNum = nil

		for seatId = 1, 8 do
			rouletteTable.currentBets[seatId] = {}
		end

		for clientId, totalPayout in pairs(rouletteTable.winnerPlayers) do
			if isElement(clientId) then
                exports.sCore:setSSC(clientId, exports.sCore:getSSC(clientId) + totalPayout)
			end
		end

		rouletteTable.winnerPlayers = nil

		if #rouletteTable.streamedPlayers > 0 then
			triggerClientEvent(rouletteTable.streamedPlayers, "rouletteNewRound", resourceRoot, rouletteTable.tableId)
		end
	end
end

---------------------------------------------------------------------------------------------------

addCommandHandler("rulettmaffia",
	function (clientId, commandName, desiredNum)
		if exports.sPermission:hasPermission(clientId, "rulettmaffia") then
			local rouletteTableId = playerPlayingTables[clientId]

			if rouletteTableId then
				local rouletteTable = rouletteGameTables[rouletteTableId]

				if rouletteTable then
					rouletteTable.riggedNum = tonumber(desiredNum) or 10

					if rouletteTable.riggedNum then
						outputChatBox("[color=sightgreen][SightMTA - Roulette]: [color=hudwhite]Sikeresen beállítottad a rouletten a következő számot! ["..riggedNum.."]", sourcePlayer)

						rouletteTable.riggedNum = rouletteWheelNumsReverse[rouletteTable.riggedNum] - 1
					end
				end
			end
		end
	end
)