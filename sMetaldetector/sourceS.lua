local debugMode = true

local playerContainer = {}
local playerUsingDetector = {}

local holeContainer = {}
local lootContainer = {}

local lootFillerQueue = {}
local lootFillerInterval = 100

local holeCheckTimer = false

local playersInZone = {}
local playerLoadedZones = {}

function shuffleTable(t)
	local j
	for i = #t, 2, -1 do
		j = math.random(i)
		t[i], t[j] = t[j], t[i]
	end
end

addEventHandler("onResourceStart", resourceRoot,
	function ()
		prepareLootFiller()
	end
)

function prepareLootFiller()
	lootCount = 0
	lootCountIsland = 0

	for zoneX in pairs(diggableZones) do
		for zoneY in pairs(diggableZones[zoneX]) do
			local gridX, gridY = convertToSync(zoneX, zoneY)
			local isIslandZone = islandSync[gridX] and islandSync[gridX][gridY]

			if math.random() < (isIslandZone and 0.0123 or 0.01) then
				table.insert(lootFillerQueue, {zoneX, zoneY})
			end
		end
	end

	shuffleTable(lootFillerQueue)

	if not lootFillerTimer then
		lootFillerTimer = setTimer(processLootFiller, lootFillerInterval, 0)
	end

	if debugMode then
		--outputDebugString("Loot filler queue prepared: " .. #lootFillerQueue)
	end
end

function processLootFiller()
	local maxProcessPerCycle = 200

	for i = #lootFillerQueue, math.max(#lootFillerQueue - maxProcessPerCycle, 1), -1 do
		local zoneData = lootFillerQueue[i]

		if zoneData then
			createLoot(zoneData[1], zoneData[2])
		end

		table.remove(lootFillerQueue, i)
	end

	if debugMode then
		--outputDebugString("Loot filler queue: " .. #lootFillerQueue)
	end

	if #lootFillerQueue == 0 then
		if debugMode then
			--outputDebugString("Loot filler queue processed, lootcount: " .. lootCount .. ", isle: " .. lootCountIsland)
		end

		if isTimer(lootFillerTimer) then
			killTimer(lootFillerTimer)
		end

		lootFillerTimer = nil
	end
end

function createLoot(diggableX, diggableY)
	if not (diggableX and diggableY) then
		return false
	end

	local zoneX = math.floor(diggableX / syncSize)
	local zoneY = math.floor(diggableY / syncSize)

	if not lootContainer[diggableX] then
		lootContainer[diggableX] = {}
	end

	if islandSync[zoneX] and islandSync[zoneX][zoneY] then
		lootCountIsland = lootCountIsland + 1
		lootContainer[diggableX][diggableY] = chooseIslandLoot()
	else
		lootCount = lootCount + 1
		lootContainer[diggableX][diggableY] = chooseRandomLoot()
	end

	return true
end

function checkDiggedHoles()
	local timeNow = getTickCount()

	for holeX in pairs(holeContainer) do
		for holeY in pairs(holeContainer[holeX]) do
			local holeData = holeContainer[holeX][holeY]

			if timeNow - holeData.lastDig > 3 * 60 * 1000 then
				local shouldGenNewLoot = false

				if holeData.dig >= holeData.digs and holeData.gotPickedUp then
					shouldGenNewLoot = true
				end

				if shouldGenNewLoot then
					local zoneX = math.floor(holeX / syncSize)
					local zoneY = math.floor(holeY / syncSize)

					local holeX = false
					local holeY = false

					if islandSync[zoneX] and islandSync[zoneX][zoneY] then
						holeX, holeY = findFreeDiggableZone(true)
					else
						holeX, holeY = findFreeDiggableZone(false)
					end

					if createLoot(holeX, holeY) then
						if isMetalLoot(holeX, holeY) then
							if playersInZone[zoneX] then
								if playersInZone[zoneX][zoneY] then
									triggerLatentClientEvent(playersInZone[zoneX][zoneY], "gotMetalDetectorLoot", resourceRoot, zoneX, zoneY, {{holeX, holeY}})
								end
							end
						end
					end
				end

				deleteHole(holeX, holeY)
			end
		end
	end
end

function findFreeDiggableZone(islandOnly)
	local freeZones = {}

	for zoneX in pairs(diggableZones) do
		for zoneY in pairs(diggableZones[zoneX]) do
			local gridX, gridY = convertToSync(zoneX, zoneY)
			local isIslandZone = islandSync[gridX] and islandSync[gridX][gridY]

			if (islandOnly and isIslandZone) or (not islandOnly and not isIslandZone) then
				local isLoot = lootContainer[zoneX] and lootContainer[zoneX][zoneY]
				local isHole = holeContainer[zoneX] and holeContainer[zoneX][zoneY]

				if not (isLoot or isHole) then
					table.insert(freeZones, {zoneX, zoneY})
				end
			end
		end
	end

	return unpack(freeZones[math.random(#freeZones)])
end

addEventHandler("onPlayerResourceStart", root,
	function (startedResource)
		if startedResource == resource then
			table.insert(playerContainer, source)

			if next(playerUsingDetector) then
				triggerClientEvent(source, "gotMetalDetectorPlayers", source, playerUsingDetector)
			end
		end
	end
)

addEventHandler("onPlayerQuit", root,
	function ()
		if playerUsingDetector[source] then
			playerUsingDetector[source] = nil
		end

		for i = #playerContainer, 1, -1 do
			if playerContainer[i] == source then
				table.remove(playerContainer, i)
				break
			end
		end

		if playerLoadedZones[source] then
			for i = 1, #playerLoadedZones[source] do
				local zoneX, zoneY = unpack(playerLoadedZones[source][i])

				if playersInZone[zoneX] then
					if playersInZone[zoneX][zoneY] then
						for i = #playersInZone[zoneX][zoneY], 1, -1 do
							if playersInZone[zoneX][zoneY][i] == source then
								table.remove(playersInZone[zoneX][zoneY], i)
								break
							end
						end

						if #playersInZone[zoneX][zoneY] == 0 then
							playersInZone[zoneX][zoneY] = nil
						end
					end

					if not next(playersInZone[zoneX]) then
						playersInZone[zoneX] = nil
					end
				end
			end

			playerLoadedZones[source] = nil
		end
	end
)

addEvent("useMetalDetector", true)
addEventHandler("useMetalDetector", root,
	function (inUse)
		if isElement(client) then
			if inUse then
				playerUsingDetector[client] = true
			else
				playerUsingDetector[client] = nil
			end

			--triggerClientEvent(playerContainer, "useMetalDetector", client, inUse)
		end
	end
)

addEvent("metalDetectorZoneLoaded", true)
addEventHandler("metalDetectorZoneLoaded", root,
	function (zoneX, zoneY)
		if isElement(client) then
			local lootToSync = {}
			local holeToSync = {}

			for cellX = 0, syncSize - 1 do
				local diggableX = zoneX * syncSize + cellX

				for cellY = 0, syncSize - 1 do
					local diggableY = zoneY * syncSize + cellY

					if holeContainer[diggableX] then
						if holeContainer[diggableX][diggableY] then
							table.insert(holeToSync, {diggableX, diggableY, holeContainer[diggableX][diggableY]})
						end
					end

					if lootContainer[diggableX] then
						local lootTypeId = lootContainer[diggableX][diggableY]

						if lootTypeId then
							local lootTypeDetails = lootTypes[lootTypeId]

							if lootTypeDetails[2] then
								table.insert(lootToSync, {diggableX, diggableY})
							end
						end
					end
				end
			end

			if #lootToSync > 0 then
				triggerLatentClientEvent(client, "gotMetalDetectorLoot", client, zoneX, zoneY, lootToSync)
			end

			if #holeToSync > 0 then
				triggerLatentClientEvent(client, "gotMetalDetectorHoles", client, zoneX, zoneY, holeToSync)
			end

			if not playersInZone[zoneX] then
				playersInZone[zoneX] = {}
			end

			if not playersInZone[zoneX][zoneY] then
				playersInZone[zoneX][zoneY] = {}
			end

			table.insert(playersInZone[zoneX][zoneY], client)

			if not playerLoadedZones[client] then
				playerLoadedZones[client] = {}
			end

			table.insert(playerLoadedZones[client], {zoneX, zoneY})
		end
	end
)

addEvent("metalDetectorZoneUnloaded", true)
addEventHandler("metalDetectorZoneUnloaded", root,
	function (zoneX, zoneY)
		if isElement(client) then
			if playerLoadedZones[client] then
				for i = #playerLoadedZones[client], 1, -1 do
					local v = playerLoadedZones[client][i]

					if v[1] == zoneX and v[2] == zoneY then
						table.remove(playerLoadedZones[client], i)
						break
					end
				end

				if #playerLoadedZones[client] == 0 then
					playerLoadedZones[client] = nil
				end
			end

			if playersInZone[zoneX] then
				if playersInZone[zoneX][zoneY] then
					for i = #playersInZone[zoneX][zoneY], 1, -1 do
						if playersInZone[zoneX][zoneY][i] == client then
							table.remove(playersInZone[zoneX][zoneY], i)
							break
						end
					end

					if #playersInZone[zoneX][zoneY] == 0 then
						playersInZone[zoneX][zoneY] = nil
					end
				end

				if not next(playersInZone[zoneX]) then
					playersInZone[zoneX] = nil
				end
			end
		end
	end
)

addEvent("syncMetalDetectorData", true)
addEventHandler("syncMetalDetectorData", root,
	function (syncList, cameraYaw, armPitch, metalDistance)
		if isElement(client) then
			triggerClientEvent(syncList, "syncMetalDetectorData", client, cameraYaw, armPitch, metalDistance)
		end
	end
)

addEvent("tryToDigHole", true)
addEventHandler("tryToDigHole", root,
	function (holeX, holeY)
		if isElement(client) then
			local zoneX, zoneY = convertToSync(holeX, holeY)

			if isHoleDiggable(holeX, holeY) then
				local hasShovel = exports.sItems:hasItem(client, 72)

				if hasShovel then
					local holeData = digHole(client, holeX, holeY)

					if holeData then
						local syncList = getPlayersWithinZone(zoneX, zoneY)

						if #syncList > 0 then
							triggerClientEvent(syncList, "gotHoleData", client, holeX, holeY, holeData, math.random(1, 5))
						end
					else
						triggerClientEvent(client, "showInfobox", client, "error", "Ezt a gödröt már valaki elkezdte ásni!")
					end
				else
					triggerClientEvent(client, "showInfobox", client, "error", "Nincs nálad ásó!")
				end
			else
				local holeData = holeContainer[holeX] and holeContainer[holeX][holeY]

				if holeData then
					if holeData.pickUp then
						local characterId = getElementData(client, "char.ID")

						if holeData.diggedBy == characterId then
							local syncList = getPlayersWithinZone(zoneX, zoneY)

							if #syncList > 0 then
								if lootContainer[holeX] then
									local lootTypeId = lootContainer[holeX][holeY]

									if lootTypeId then
										local lootItemId = lootTypes[lootTypeId][3]

										if exports.sItems:hasSpaceForItem(client, lootItemId) then
											exports.sItems:giveItem(client, lootItemId, 1)

											holeData.pickUp = nil
											holeData.gotPickedUp = true
											holeData.tex = "empty"

											triggerClientEvent(syncList, "gotHoleData", client, holeX, holeY, holeData)
											triggerClientEvent(syncList, "pickUpHoleItem", client, holeX, holeY, lootItemId)
											triggerClientEvent(syncList, "deleteMetalDetectorLoot", client, holeX, holeY)

											lootContainer[holeX][holeY] = nil

											if islandSync[zoneX] and islandSync[zoneX][zoneY] then
												lootCountIsland = lootCountIsland - 1
											else
												lootCount = lootCount - 1
											end

                                            exports.sChat:localAction(client, "kivesz egy tárgyat: " .. exports.sItems:getItemName(lootItemId) .. ".")
										else
											triggerClientEvent(client, "showInfobox", client, "error", "Nem fér el nálad a tárgy!")
										end
									end

									if not next(lootContainer[holeX]) then
										lootContainer[holeX] = nil
									end
								end
							end
						else
							triggerClientEvent(client, "showInfobox", client, "error", "Ezt a gödröt nem te ástad!")
						end
					end
				end
			end
		end
	end
)

addEvent("gotMetaldetectorUnUse", true)
addEventHandler("gotMetaldetectorUnUse", getRootElement(), function()
    playerUsingDetector[client] = nil
end)

function getPlayersWithinZone(zoneX, zoneY)
	local playerList = {}

	if playersInZone[zoneX] then
		if playersInZone[zoneX][zoneY] then
			for i = 1, #playersInZone[zoneX][zoneY] do
				table.insert(playerList, playersInZone[zoneX][zoneY][i])
			end
		end
	end

	return playerList
end

function digHole(playerSource, holeX, holeY)
	local characterId = getElementData(playerSource, "char.ID")

	if not holeContainer[holeX] then
		holeContainer[holeX] = {}
	end

	if not holeContainer[holeX][holeY] then
		holeContainer[holeX][holeY] = {}
	end

	local holeData = holeContainer[holeX][holeY]

	if holeData.diggedBy then
		if holeData.diggedBy ~= characterId then
			return false
		end
	end

	holeData.diggedBy = characterId

	if not holeData.digs then
		holeData.digs = math.random(5, 10)
	end

	holeData.lastDig = getTickCount()

	if holeData.dig then
		holeData.dig = holeData.dig + 1

		if holeData.dig > holeData.digs then
			holeData.dig = holeData.digs
		end
	else
		holeData.dig = 1
	end

	holeData.pickUp = nil
	holeData.tex = "empty"

	if holeData.dig >= holeData.digs then
		if lootContainer[holeX] then
			local lootTypeId = lootContainer[holeX][holeY]

			if lootTypeId then
				holeData.pickUp = true
				holeData.tex = lootTypes[lootTypeId][1]
			end
		end
	end

	holeContainer[holeX][holeY] = holeData

	if not holeCheckTimer then
		holeCheckTimer = setTimer(checkDiggedHoles, 60 * 1000, 0)
	end

	return holeData
end

function deleteHole(holeX, holeY)
	if not holeContainer[holeX] or not holeContainer[holeX][holeY] then
		return
	end

	local zoneX, zoneY = convertToSync(holeX, holeY)
	local syncList = getPlayersWithinZone(zoneX, zoneY)

	if #syncList > 0 then
		triggerLatentClientEvent(syncList, "gotHoleData", resourceRoot, holeX, holeY)
	end

	holeContainer[holeX][holeY] = nil

	if not next(holeContainer[holeX]) then
		holeContainer[holeX] = nil

		if holeCheckTimer then
			if isTimer(holeCheckTimer) then
				killTimer(holeCheckTimer)
			end

			holeCheckTimer = nil
		end
	end
end

function isHoleDiggable(holeX, holeY)
	if not diggableZones[holeX] or not diggableZones[holeX][holeY] then
		return false
	end

	if not holeContainer[holeX] or not holeContainer[holeX][holeY] then
		return true
	end

	if not holeContainer[holeX][holeY]["pickUp"] then
		return true
	end

	return false
end

function chooseRandomLoot()
	local randomSum = math.random(lootSum)
	local currentSum = 0

	for i = 1, #lootTypes do
		local lootInfo = lootTypes[i]

		if not lootInfo[5] then
			currentSum = currentSum + lootInfo[4]

			if randomSum <= currentSum then
				return i
			end
		end
	end

	return false
end

function chooseIslandLoot()
	local randomSum = math.random(lootSumIsland)
	local currentSum = 0

	for i = 1, #lootTypes do
		local lootInfo = lootTypes[i]

		currentSum = currentSum + lootInfo[4]

		if randomSum <= currentSum then
			return i
		end
	end

	return false
end

function isMetalLoot(diggableX, diggableY)
	if lootContainer[diggableX] then
		local lootTypeId = lootContainer[diggableX][diggableY]

		if lootTypeId then
			local lootTypeDetails = lootTypes[lootTypeId]

			if lootTypeDetails[2] then
				return true
			end
		end
	end

	return false
end

if debugMode then
    addCommandHandler("listpositions", function(client)
        for sx in pairs(lootContainer) do
            for sy in pairs(lootContainer[sx]) do
                local loot = lootContainer[sx][sy]

				local px, py = getElementPosition(client)
                if loot then
					if getDistanceBetweenPoints2D(px, py, sx, sy) < 200 then
						createBlip(sx, sy, 0, 0, 2, 255, 0, 0, 255, 0, 999999, getPlayerFromName("ezttehonnantudtad?"))
					end
                end
            end
        end
    end)
end