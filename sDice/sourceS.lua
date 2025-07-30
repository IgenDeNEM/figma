
reelSymbols = reels
bettingStakes = stakes
paylinePositions = lines -- bettingLines

-------------------

local machinesPerDimension = {}

local syncZones = {}
local playerSyncZone = {}
local playersPerSyncZone = {}

local diceMachines = {}
local playerMachines = {}

local streamingData = {
	currentUser = "player",
	stakeLevel = "stake",
	totalBalance = "balance",

	reelsPosition = "reels",

	holdReels = "hold",
	holdSymbols = true,
	disableHold = true,

	diceSpin = "dice",
	diceRot = true,
	diceRounds = true,
	lastDice = true,
	
	riskSymbol = "risk",
	riskCount = true,
	riskValue = true,

	-- clockLine = true,
	clockLevel = true,
	clockBalance = true,
}

---------------------------------------------------------------------------------------------------

addEventHandler("onResourceStart", resourceRoot,
	function ()
		initSyncZones()
		initDiceMachines()
	end
)

addEventHandler("onResourceStop", resourceRoot,
	function ()
		for clientId in pairs(playerMachines) do
			playerExitSeeDice(clientId)
		end
	end
)

addEvent("requestDiceMachines", true)
addEventHandler("requestDiceMachines", root,
	function ()
		if client then
			local dimensionId = getElementDimension(client)

			if machinesPerDimension[dimensionId] then
				playerEnterSyncZone(client, getPlayerSyncZone(client), dimensionId)
			end
		end
	end
)

addEventHandler("onElementDimensionChange", root,
	function (oldDimension, newDimension)
		if getElementType(source) == "player" then
			if machinesPerDimension[oldDimension] then
				playerLeaveSyncZone(source, playerSyncZone[source], oldDimension)
			end

			if machinesPerDimension[newDimension] then
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

		playerExitSeeDice(source)
	end,
true, "high+1")

addEvent("tryToSitDownSeeDice", true)
addEventHandler("tryToSitDownSeeDice", root,
	function (machineId)
		if client then
			playerJoinSeeDice(client, machineId)
		end
	end
)

addEvent("tryToExitSeeDice", true)
addEventHandler("tryToExitSeeDice", root,
	function ()
		if client then
			playerExitSeeDice(client)
		end
	end
)

---------------------------------------------------------------------------------------------------

function initSyncZones()
	for i = 1, #diceMachineCoordinates do
		local dimensionId = diceMachineCoordinates[i][6]

		if not machinesPerDimension[dimensionId] then
			machinesPerDimension[dimensionId] = {}
		end

		table.insert(machinesPerDimension[dimensionId], i)
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
		for i = 1, #playersPerSyncZone[zoneId] do
			if playersPerSyncZone[zoneId][i] == clientId then
				return
			end
		end
		local seeDices = {}

		for i = 1, #machinesPerDimension[dimensionId] do
			local machineId = machinesPerDimension[dimensionId][i]

			if machineId then
				local machineData = diceMachines[machineId]
				if machineData then
					local broadcastData = {}
					for dataName, originName in pairs(streamingData) do
						local dataValue = machineData[dataName]

						if type(originName) == "string" then
							broadcastData[originName] = dataValue
						else
							broadcastData[dataName] = dataValue
						end
						machineData.streamedPlayers = playersPerSyncZone[zoneId]
					end
					seeDices[machineId] = broadcastData
				end
			end
		end
		triggerLatentClientEvent(clientId, "streamInSeeDices", clientId, seeDices)

		if not playerSyncZone[clientId] then
			table.insert(playersPerSyncZone[zoneId], clientId)
		end

		playerSyncZone[clientId] = zoneId
	end
end

function playerLeaveSyncZone(clientId, zoneId, dimensionId)
	if zoneId then
		triggerClientEvent(clientId, "streamOutSeeDices", clientId, dimensionId)

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

function registerDiceEvent(eventName, baseElement, callbackFunction, ...)
	addEvent(eventName, true)
	addEventHandler(eventName, baseElement,
		function (...)
			if client then
				local machineId = playerMachines[client]
				if machineId then
					callbackFunction(diceMachines[machineId], ...)
				end
			end
		end
	)
end

function initDiceMachines()
	for i = 1, #diceMachineCoordinates do
		local interiorId, dimensionId = diceMachineCoordinates[i][5], diceMachineCoordinates[i][6]

		if not diceMachines[i] then
			local machineData = {}

			machineData.machineId = i

			machineData.stakeLevel = 1
			machineData.totalBalance = 0

			machineData.clockLine = false
			machineData.clockLevel = 0
			machineData.clockBalance = 0

			machineData.diceSpin = false
			machineData.diceRot = false
			machineData.diceRounds = 0
			machineData.lastDice = math.random(1, 6)

			machineData.holdReels = {}
			machineData.holdSymbols = {}
			machineData.disableHold = true

			machineData.reelsPosition = {}
			machineData.riggedSymbols = {}

			for reelId = 1, 3 do
				machineData.reelsPosition[reelId] = randomFillSymbol()
			end

			machineData.streamedPlayers = {}
			
			for j = 1, #syncZoneCoords do
				local zoneInterior, zoneDimension, zoneName = unpack(syncZoneCoords[j], 5)

				if zoneInterior == interiorId and zoneDimension == dimensionId then
					machineData.streamedPlayers = playersPerSyncZone[zoneName]
					break
				end
			end

			diceMachines[i] = machineData
		end
	end
end

function playerJoinSeeDice(clientId, machineId)
	local machineData = diceMachines[machineId]

	if machineData then
		if playerMachines[clientId] then
			return
		end

		if isElement(machineData.currentUser) then
			return exports.sGui:showInfobox(clientId, "e", "Ez a játékgép már foglalt!")
		end

		machineData.currentUser = clientId
		if #machineData.streamedPlayers > 0 then
			triggerClientEvent(machineData.streamedPlayers, "gotNewSeeDicePlayer", resourceRoot, machineId, clientId)
		end

		playerMachines[clientId] = machineId

		if isElement(clientId) then
			exports.sChat:localAction(clientId, "leül egy játékgéphez.")
		end
	end
end

function playerExitSeeDice(clientId)
	local machineId = playerMachines[clientId]
	if not machineId then
		return
	end

	local machineData = diceMachines[machineId]
	if not machineData then
		return
	end

	if eventName == "tryToExitSeeDice" then
		if machineData.riskValue then
			return
		end

		exports.sChat:localAction(clientId, "feláll egy játékgéptől.")
	elseif eventName == "onPlayerQuit" then
		if machineData.reelsRotating then
			stopReels(machineId)
		end
	end

	if machineData.totalBalance > 0 then
		local sscBalance = exports.sCore:getSSC(clientId)
		
		if sscBalance then
            exports.sCore:setSSC(clientId, sscBalance + machineData.totalBalance)
		end

		machineData.totalBalance = 0

		if eventName ~= "onResourceStop" then
			triggerClientEvent(machineData.streamedPlayers, "gotSeeDiceCollect", resourceRoot, machineId, machineData.totalBalance)
		end
	end

	machineData.currentUser = nil

	if eventName ~= "onResourceStop" then
		triggerClientEvent(machineData.streamedPlayers, "gotNewSeeDicePlayer", resourceRoot, machineId, false)
	end

	playerMachines[clientId] = nil
end

---------------------------------------------------------------------------------------------------

registerDiceEvent("tryToPayInSeeDice", root,
	function (machineData, payInAmount)
		payInAmount = tonumber(payInAmount) or 0

		if payInAmount < 1000 then
			exports.sGui:showInfobox(client, "e", "Minimum befizethető összeg: 1 000 SSC")
		else
            local sscBalance = exports.sCore:getSSC(client)

			if payInAmount > sscBalance then
				exports.sGui:showInfobox(client, "e", "Nincs elég SSC-d a befizetéshez!")
			else
				machineData.totalBalance = machineData.totalBalance + payInAmount

				if #machineData.streamedPlayers > 0 then
					triggerClientEvent(machineData.streamedPlayers, "gotSeeDicePayIn", resourceRoot, machineData.machineId, machineData.totalBalance)
				end

                exports.sCore:setSSC(client, sscBalance - payInAmount)
			end
		end
	end
)

registerDiceEvent("tryToSetSeeDiceStake", root,
	function (machineData)
		if not machineData.riskValue and not machineData.diceSpin and not machineData.reelsRotating then
			machineData.stakeLevel = machineData.stakeLevel + 1

			if machineData.stakeLevel > #bettingStakes then
				machineData.stakeLevel = 1
			end

			triggerClientEvent(machineData.streamedPlayers, "setSeeDiceStake", resourceRoot, machineData.machineId, machineData.stakeLevel)
		end
	end
)

registerDiceEvent("tryToRotateSeeDice", root,
	function (machineData)
		if not machineData.reelsRotating then
			if machineData.diceRounds == 0 then
				if machineData.totalBalance < bettingStakes[machineData.stakeLevel] then
					return exports.sGui:showInfobox(client, "e", "Nincs elég egyenleged!")
				end
			end

			if not machineData.heldReels then
				machineData.heldReels = {}
			end

			if next(machineData.heldReels) then
				machineData.heldReels = {}
				machineData.holdReels = {}
				machineData.holdSymbols = {}
				machineData.disableHold = true
			end

			for reelId = 1, 3 do
				if machineData.holdReels[reelId] then
					machineData.heldReels[reelId] = true
				end
			end

			machineData.initialSpin = true

			if next(machineData.holdReels) and not machineData.disableHold then
				machineData.initialSpin = false
			end

			local winLines, winSymbols = generateResult(machineData)

			if machineData.diceRounds > 0 then
				machineData.diceRot = true
				machineData.diceRounds = math.max(0, machineData.diceRounds - 1)
			else
				machineData.diceRot = false
				machineData.diceRounds = 0
				machineData.totalBalance = math.max(0, machineData.totalBalance - bettingStakes[machineData.stakeLevel])
			end

			triggerClientEvent(machineData.streamedPlayers, "startSeeDiceRotation", resourceRoot, machineData.machineId, machineData.holdReels, machineData.disableHold, winLines, winSymbols, machineData.diceSpin, machineData.diceRot, machineData.diceRounds, machineData.riskValue, machineData.totalBalance, machineData.clockBalance)
		
			if not winLines and not machineData.clockLine then
				evaluateSymbols(machineData)
			end

			machineData.reelsRotating = true
			machineData.reelsRotateTimer = setTimer(stopReels, math.random(1500, 2500), 1, machineData.machineId)
		end
	end
)

registerDiceEvent("tryToStopSeeDice", root,
	function (machineData)
		if machineData.reelsRotateTimer and not machineData.reelsStopTimer and machineData.diceRounds == 0 then
			stopReels(machineData.machineId)
		end
	end
)

registerDiceEvent("tryToHoldSeeDice", root,
	function (machineData, selectedReel)
		if not machineData.disableHold and not machineData.riskValue and not machineData.reelsRotating and not machineData.diceSpin then
			if selectedReel then
				local totalHeldCount = 0

				for reelId = 1, 3 do
					if machineData.holdReels[reelId] then
						totalHeldCount = totalHeldCount + 1
					end
				end

				if machineData.holdReels[selectedReel] or totalHeldCount < 2 then
					machineData.holdReels[selectedReel] = not machineData.holdReels[selectedReel]
					machineData.holdSymbols[selectedReel] = nil
				else
					return
				end
			else
				for reelId = 1, 3 do
					machineData.holdReels[reelId] = nil
					machineData.holdSymbols[reelId] = nil
				end
			end

			triggerClientEvent(machineData.streamedPlayers, "gotSeeDiceHold", resourceRoot, machineData.machineId, selectedReel, selectedReel and machineData.holdReels[selectedReel])
		end
	end
)

registerDiceEvent("tryToGambleSeeDice", root,
	function (machineData, gambleSymbol)
		if machineData.riskValue then
			local baseChance = 0.6
			local winningChance = baseChance - (0.05 * machineData.riskCount)
			local gambleSuccess = math.random() <= winningChance

			if gambleSuccess then
				machineData.riskCount = machineData.riskCount + 1

				if machineData.riskCount >= 7 then
					machineData.totalBalance = machineData.totalBalance + machineData.riskValue

					machineData.riskSymbol = false
					machineData.riskCount = nil
					machineData.riskValue = false
					
					return triggerClientEvent(machineData.streamedPlayers, "gotSeeDiceCollect", resourceRoot, machineData.machineId, machineData.totalBalance)
				else
					machineData.riskSymbol = gambleSymbol
					machineData.riskValue = machineData.riskValue * 2
				end
			else
				machineData.riskSymbol = gambleSymbol == 2 and 1 or 2
				machineData.riskCount = nil
				machineData.riskValue = false
			end

			triggerClientEvent(machineData.streamedPlayers, "gotSeeDiceGamble", resourceRoot, machineData.machineId, machineData.riskValue, gambleSuccess, machineData.riskSymbol)
		end
	end
)

registerDiceEvent("tryToCollectSeeDice", root,
	function (machineData)
		if machineData.riskValue then
			machineData.totalBalance = machineData.totalBalance + machineData.riskValue

			machineData.riskSymbol = false
			machineData.riskCount = nil
			machineData.riskValue = false

			triggerClientEvent(machineData.streamedPlayers, "gotSeeDiceCollect", resourceRoot, machineData.machineId, machineData.totalBalance)
		end
	end
)

registerDiceEvent("tryToStopSeeDiceRoll", root,
	function (machineData)
		if machineData.diceSpin then
			machineData.diceSpin = false
			machineData.diceRounds = math.min(machineData.diceRounds + math.random(1, 6), 6) -- TODO: use weight random instead
			machineData.lastDice = machineData.diceRounds

			if #machineData.streamedPlayers > 0 then
				triggerClientEvent(machineData.streamedPlayers, "stopSeeDiceRoll", resourceRoot, machineData.machineId, machineData.diceRounds)
			end
		end
	end
)

function stopReels(machineId)
	local machineData = diceMachines[machineId]

	if machineData then
		local reelsRotating = {}

		for reelId = 1, 3 do
			if machineData.initialSpin or (not machineData.initialSpin and not machineData.heldReels[reelId]) then
				table.insert(reelsRotating, reelId)
			end
		end

		local nextReelToStop = 1

		if isTimer(machineData.reelsRotateTimer) then
			killTimer(machineData.reelsRotateTimer)
		end

		machineData.reelsStopTimer = setTimer(
			function ()
				local reelId = reelsRotating[nextReelToStop]

				if reelId then
					triggerClientEvent(machineData.streamedPlayers, "stopSeeDiceRotation", resourceRoot, machineData.machineId, reelId, machineData.reelsPosition[reelId], machineData.holdSymbols[reelId], machineData.clockLine and machineData.clockLevel, machineData.clockLine)

					if nextReelToStop == #reelsRotating then
						machineData.reelsRotating = false
						machineData.reelsStopTimer = nil
					end
				end

				nextReelToStop = nextReelToStop + 1
			end,
		math.random(200, 400), #reelsRotating)

		machineData.reelsRotateTimer = nil
	end
end

function setLineWithSymbols(machineData, lineId, lineSymbols, isRigging)
	for reelId = 1, 3 do
		for offsetId = 0, #reelSymbols[reelId] - 3 do
			local symbolId = offsetId + paylinePositions[lineId][reelId]

			if reelSymbols[reelId][symbolId] == lineSymbols[reelId] then
				if isRigging then
					machineData.riggedSymbols[reelId] = offsetId
				else
					machineData.reelsPosition[reelId] = offsetId
				end

				break
			end
		end
	end
end

function generateResult(machineData)
	local winLines = false
	local winSymbols = {}

	for reelId = 1, 3 do
		if machineData.riggedSymbols[reelId] then
			machineData.reelsPosition[reelId] = machineData.riggedSymbols[reelId]
			machineData.riggedSymbols[reelId] = nil
		elseif not machineData.holdReels[reelId] then
			machineData.reelsPosition[reelId] = math.random(0, #reelSymbols[reelId] - 3)

			if machineData.reelsPosition[reelId] >= 2 then
				machineData.reelsPosition[reelId] = machineData.reelsPosition[reelId] - math.random(0, 2)
			end
		end
	end

	if machineData.diceRounds > 0 then
		local winLine = math.random(1, 5)
		local winSymbol = math.random(1, 9)

		setLineWithSymbols(machineData, winLine, {winSymbol, winSymbol, winSymbol})
	end

	machineData.clockLine = false

	for lineId = 1, 5 do
		local symbolMatch = true
		local firstSymbol = reelSymbols[1][machineData.reelsPosition[1] + paylinePositions[lineId][1]]

		for reelId = 2, 3 do
			local reelSymbol = reelSymbols[reelId][machineData.reelsPosition[reelId] + paylinePositions[lineId][reelId]]

			if reelSymbol ~= firstSymbol then
				symbolMatch = false
				break
			end
		end

		if symbolMatch then
			if firstSymbol == 10 then
				break	
			elseif firstSymbol == 11 then
				machineData.clockLine = lineId
				break
			else
				table.insert(winSymbols, firstSymbol)

				if not winLines then
					winLines = {}
				end

				table.insert(winLines, lineId)
			end
		end
	end

	local diceCount = 0

	for rowId = 1, 3 do
		for reelId = 1, 3 do
			local reelSymbol = reelSymbols[reelId][machineData.reelsPosition[reelId] + rowId]

			if reelSymbol == 10 then
				diceCount = diceCount + 1

				if diceCount == 3 then
					break
				end
			end
		end
	end

	machineData.diceSpin = diceCount == 3

	if machineData.disableHold then
		machineData.holdReels = {}
		machineData.disableHold = false
	end

	local selectedStake = bettingStakes[machineData.stakeLevel]

	if winLines then
		machineData.riskCount = 1
		machineData.riskValue = 0

		for i = 1, #winSymbols do
			machineData.riskValue = machineData.riskValue + symbolPayout[winSymbols[i]] * selectedStake
		end

		machineData.disableHold = true
	end

	machineData.clockBalance = selectedStake * (150 + math.random(0, 10) * 25)

	if machineData.clockLine then
		machineData.clockLevel = machineData.clockLevel + 1

		if machineData.clockLevel == 3 then
			machineData.clockResetTimer = setTimer(
				function ()
					machineData.totalBalance = machineData.totalBalance + machineData.clockBalance

					machineData.clockLevel = 0
					machineData.clockBalance = 0
					machineData.clockResetTimer = nil

					if #machineData.streamedPlayers > 0 then
						triggerClientEvent(machineData.streamedPlayers, "gotSeeDiceCollect", resourceRoot, machineData.machineId, machineData.totalBalance)
					end
				end,
			30 * 1000, 1)
		end
	end

	if not machineData.initialSpin then
		machineData.disableHold = true
	end

	return winLines, winSymbols
end

function evaluateSymbols(machineData)
	machineData.holdReels = {}
	machineData.holdSymbols = {}

	if machineData.initialSpin and not machineData.diceSpin then
		local foundDiceCount = 0
		local foundDiceSpots = {}

		for rowId = 1, 3 do
			for reelId = 1, 3 do
				local reelSymbol = reelSymbols[reelId][machineData.reelsPosition[reelId] + rowId]
				
				if reelSymbol == 10 then
					if not foundDiceSpots[reelId] then
						foundDiceCount = foundDiceCount + 1
					end

					foundDiceSpots[reelId] = rowId
				end
			end
		end

		if foundDiceCount == 2 then
			for reelId, rowId in pairs(foundDiceSpots) do
				machineData.holdReels[reelId] = true

				if not machineData.holdSymbols[reelId] then
					machineData.holdSymbols[reelId] = {}
				end

				machineData.holdSymbols[reelId][rowId] = 10
			end
		end

		for lineId = 1, 5 do
			for reelA = 1, 2 do
				for reelB = reelA + 1, 3 do
					local rowA = paylinePositions[lineId][reelA]
					local rowB = paylinePositions[lineId][reelB]

					local symbolA = reelSymbols[reelA][machineData.reelsPosition[reelA] + rowA]
					local symbolB = reelSymbols[reelB][machineData.reelsPosition[reelB] + rowB]

					if symbolA == symbolB then
						holdMatchingSymbols(machineData, reelA, reelB, rowA, rowB, symbolA)
					end
				end
			end
		end
	end

	machineData.disableHold = not next(machineData.holdReels)
end

function holdMatchingSymbols(machineData, colA, colB, rowA, rowB, symbolId)
	local heldCount = 0

	for reelId = 1, 3 do
		if machineData.holdReels[reelId] then
			heldCount = heldCount + 1
		end
	end

	local function setSymbolHoldAt(colId, rowId, verifyIt)
		if verifyIt then
			if machineData.holdSymbols[colId] then
				for _, holdSymbols in pairs(machineData.holdSymbols) do
					for _, holdSymbolId in pairs(holdSymbols) do
						if holdSymbolId == symbolId then
							machineData.holdSymbols[colId][rowId] = symbolId
						end
					end
				end
			end
		else
			machineData.holdReels[colId] = true

			if not machineData.holdSymbols[colId] then
				machineData.holdSymbols[colId] = {}
			end

			machineData.holdSymbols[colId][rowId] = symbolId
		end
	end

	local canHoldA = isSymbolHoldable(machineData.holdSymbols[colA], symbolId)
	local canHoldB = isSymbolHoldable(machineData.holdSymbols[colB], symbolId)

	if heldCount < 2 then
		if canHoldA then
			setSymbolHoldAt(colA, rowA)
		end

		if canHoldB then
			setSymbolHoldAt(colB, rowB)
		end
	else
		local canHoldBoth = canHoldA and canHoldB

		if canHoldBoth then
			machineData.holdReels = {}
			machineData.holdSymbols = {}
		end

		setSymbolHoldAt(colA, rowA, not canHoldBoth)
		setSymbolHoldAt(colB, rowB, not canHoldBoth)
	end
end

function isSymbolHoldable(existingSymbols, newSymbolId)
	local newSymbolPayout = symbolPayout[newSymbolId]

	for _, existingSymbolId in pairs(existingSymbols or {}) do
		local existingSymbolPayout = symbolPayout[existingSymbolId]

		if newSymbolPayout ~= 0 and (existingSymbolPayout == 0 or newSymbolPayout <= existingSymbolPayout) then
			return false
		end
	end

	return true
end

---------------------------------------------------------------------------------------------------

--Használat: [color=sightblue][SightMTA - Használat]: [color=hudwhite]/commandName [Argument Formázott neve]
--Hiba: [color=sightred][SightMTA - Hiba]: [color=hudwhite]Hiba rövid leírása.
--Siker: [color=sightgreen][SightMTA - Dice]: [color=hudwhite]Siker rövid leírása.

addCommandHandler("dicemaffia",
	function (clientId, commandName, symbolId)
		if exports.sPermission:hasPermission(clientId, "dicemaffia") then
			symbolId = tonumber(symbolId) or 10

			local machineId = playerMachines[clientId]

			if machineId then
				local machineData = diceMachines[machineId]

				if machineData then
					outputChatBox("[color=sightgreen][SightMTA - Dice]: [color=hudwhite]Sikeresen beállítottad a gépeden a következő sort! ["..symbolId.."]", sourcePlayer)

					setLineWithSymbols(machineData, math.random(1, 5), {symbolId, symbolId, symbolId}, true)
				end
			end
		end
	end
)