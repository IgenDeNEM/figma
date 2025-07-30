dbConnection = exports.sConnection:getConnection()

developmentMode = true
resourceName = getResourceName(resource)
gamemodeRoot = getRootElement()
loadedPlayers = {}
doorRammerTicks = {}
doorDamagePeriod = 1800000
playersInMine = {}
playersCurrentMine = {}
local r1_0 = {}
local r2_0 = {}
local r3_0 = {}
local r4_0 = {}
local playerCarryingOreBox = {}
local r6_0 = {}
local r7_0 = {}
local mineShafts = {}
local r9_0 = {}
local mineShaftOres = {}
local mineShaftDepths = {}
local mineShaftLengths = {}
local mineJunctions = {}
local mineJunctionsAt = {}
local r15_0 = {}
local mineOpenShaftsAt = {}
local mineExtendableShaftsAt = {}
local mineFixOres = {}
local mineRails = {}
local mineRailsAt = {}
local mineRailSwitches = {}
local mineRailSwitchesAt = {}
local mineRailSwitchStates = {}
local mineTrainData = {}
local mineTrainPassengers = {}
local mineInventoryData = {}
local r27_0 = {}
local mineCartEmptying = {}
local mineSorterRunning = {}
local mineBufferContent = {}
local mineFoundryContent = {}
local mineOreBoxCarrying = {}
local r33_0 = {}
local r34_0 = {}
local mineLights = {}
mineOrders = {}
mineOrderPaid = {}
mineOrderTransit = {}
mineTankPreRequest = {}
local r36_0 = 3
local r37_0 = 2
local tunnelLength = 6
local r39_0 = 6
local r40_0 = 4
local r41_0 = r39_0 * r40_0
local r42_0 = r36_0 / r39_0
local r43_0 = r37_0 / r40_0
local r44_0 = math.floor(tunnelLength / wallMaximumDepth) * r41_0
local fixOres = {}
local r46_0 = nil
local r47_0 = 0
local r48_0 = 0
local r49_0 = {
	minerEvent = false,
	minerChest = false,
}
addEventHandler("onDatabaseConnected", gamemodeRoot, function(r0_2)
	-- line: [109, 115] id: 2
	dbConnection = r0_2
	if isElement(dbConnection) then
		loadMines()
	end
end)
addEventHandler("onResourceStart", resourceRoot, function()
	-- line: [119, 133] id: 3
	initlobbyCoords()
	if not dbConnection then
		dbConnection = exports.sConnection:getConnection()
	end
	initOres()
	if isElement(dbConnection) then
		loadMines()
	end
	setTimer(checkRents, 1800000, 0)
end, false)
addEventHandler("onResourceStop", resourceRoot, function()
	-- line: [137, 157] id: 4
	for r3_4, r4_4 in pairs(playersCurrentMine) do
		if developmentMode then
			setElementData(r3_4, "wasInMine", r4_4, false)
			setElementFrozen(r3_4, true)
		else
			setPlayerMine(r3_4, false, true)
		end
	end
	for r3_4, r4_4 in pairs(playersCurrentLobby) do
		if developmentMode then
			setElementData(r3_4, "wasInMineLobby", r4_4, false)
			setElementFrozen(r3_4, true)
		else
			setPlayerLobby(r3_4, false, true)
		end
	end
	doMineSaving()
end, false)
addEventHandler("onPlayerResourceStart", root, function(r0_5)
	-- line: [161, 184] id: 5
	if resource == r0_5 then
		table.insert(loadedPlayers, source)
		if next(r2_0) or next(r3_0) or next(r1_0) then
			triggerLatentClientEvent(source, "gotMineHandItems", source, r2_0, r3_0, r1_0)
		end
		if developmentMode then
			local r1_5 = getElementData(source, "wasInMine")
			local r2_5 = getElementData(source, "wasInMineLobby")
			if r1_5 then
				setPlayerMine(source, r1_5)
				setTimer(setElementFrozen, 1000, 1, source, false)
				removeElementData(source, "wasInMine")
			elseif r2_5 then
				setPlayerLobby(source, r2_5)
				setTimer(setElementFrozen, 1000, 1, source, false)
				removeElementData(source, "wasInMineLobby")
			end
		end
	end
end)
addEventHandler("onPlayerQuit", root, function()
	-- line: [188, 212] id: 6
	r1_0[source] = nil
	r2_0[source] = nil
	r3_0[source] = nil
	r6_0[source] = nil
	resetPlayerFixOre(source)
	resetPlayerOreBox(source)
	resetPlayerJerrycan(source)
	if playersCurrentMine[source] then
		setPlayerMine(source, false, true)
	end
	if playersCurrentLobby[source] then
		setPlayerLobby(source, false, true)
	end
	for r3_6 = #loadedPlayers, 1, -1 do
		if loadedPlayers[r3_6] == source then
			table.remove(loadedPlayers, r3_6)
			break
		end
	end
end, true, "high+1")
addEventHandler("onPlayerWasted", root, function()
	-- line: [216, 220] id: 7
	resetPlayerFixOre(source)
	resetPlayerOreBox(source)
	resetPlayerJerrycan(source)
end, true, "high+1")
function checkMinePermission(r0_8, r1_8, r2_8)
	-- line: [225, 247] id: 8
	return true
	--[[if not r2_8 then
		r2_8 = playersCurrentMine[r0_8]
	end
	if r2_8 then
		local r3_8 = loadedMinesData[r2_8]
		if r3_8 then
			local r4_8 = getElementData(r0_8, "char.ID")
			if r3_8.rentedBy == r4_8 then
				return true
			elseif r1_8 then
				local r5_8 = r3_8.workerPermissions[r4_8]
				if r5_8 then
					return bitTest(r5_8, r1_8)
				end
			end
		end
	end
	return false--]]
end
function addMineEventHandler(r0_9, r1_9, r2_9)
	-- line: [249, 266] id: 9
	addEvent(r0_9, true)
	addEventHandler(r0_9, r1_9, function(...)
		-- line: [252, 264] id: 10
		if client then
			local r1_10 = playersCurrentMine[client]
			if r1_10 and loadedMinesData[r1_10] then
				r2_9(r1_10, ...)
			end
		end
	end)
end
function addTrailerEventHandler(r0_11, r1_11, r2_11)
	-- line: [268, 289] id: 11
	addEvent(r0_11, true)
	addEventHandler(r0_11, r1_11, function(...)
		-- line: [271, 287] id: 12
		if client then
			local r1_12 = getPedOccupiedVehicle(client)
			if r1_12 and getPedOccupiedVehicleSeat(client) == 0 then
				local r3_12 = exports.sWorkaround:getAttachedTrailer(r1_12)
				if r3_12 then
					r2_11(r3_12, ...)
				end
			end
		end
	end)
end
function initMine(r0_13)
	-- line: [291, 503] id: 13
	if loadedMinesData[r0_13] then
		parseMine(r0_13)
		if not mineShafts[r0_13] then
			mineShafts[r0_13] = {
				{
					0,
					0,
					2,
					0,
					rngRandomSeed(),
					0
				}
			}
		end
		if not mineShaftDepths[r0_13] then
			mineShaftDepths[r0_13] = {
				{
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0
				}
			}
		end
		if not mineShaftLengths[r0_13] then
			mineShaftLengths[r0_13] = {
				tunnelLength
			}
		end
		if not r9_0[r0_13] then
			r9_0[r0_13] = {}
		end
		for r5_13, r6_13 in pairs(mineShafts[r0_13]) do
			r9_0[r0_13][r5_13] = rngCreate(r6_13[5])
			if r6_13[6] > 0 then
				rngSkip(r9_0[r0_13][r5_13], r6_13[6])
			end
		end
		if not r15_0[r0_13] then
			r15_0[r0_13] = {}
		end
		if not mineOpenShaftsAt[r0_13] then
			mineOpenShaftsAt[r0_13] = {}
		end
		if not mineExtendableShaftsAt[r0_13] then
			mineExtendableShaftsAt[r0_13] = {}
		end
		refreshMineShafts(r0_13)
		if not mineJunctions[r0_13] then
			mineJunctions[r0_13] = {}
		end
		if not mineJunctionsAt[r0_13] then
			mineJunctionsAt[r0_13] = {}
		end
		for r5_13 = 1, #mineJunctions[r0_13], 1 do
			local r6_13, r7_13 = unpack(mineJunctions[r0_13][r5_13])
			if not mineJunctionsAt[r0_13][r6_13] then
				mineJunctionsAt[r0_13][r6_13] = {}
			end
			mineJunctionsAt[r0_13][r6_13][r7_13] = r5_13
		end
		if not mineShaftOres[r0_13] then
			mineShaftOres[r0_13] = {}
			for r5_13 in pairs(mineShaftDepths[r0_13]) do
				local r6_13 = mineShaftOres[r0_13]
				r6_13[r5_13] = generateShaftOres(r0_13, r5_13)
			end
		end
		if not mineFixOres[r0_13] then
			mineFixOres[r0_13] = {}
		end
		if not mineRails[r0_13] then
			mineRails[r0_13] = {
				{
					-4,
					0,
					0,
					0,
					true
				}
			}
		end
		if not mineRailSwitches[r0_13] then
			mineRailSwitches[r0_13] = {}
		end
		if not mineRailsAt[r0_13] then
			mineRailsAt[r0_13] = {}
		end
		if not mineRailSwitchesAt[r0_13] then
			mineRailSwitchesAt[r0_13] = {}
		end
		if not mineRailSwitchStates[r0_13] then
			mineRailSwitchStates[r0_13] = {}
		end
		if not mineInventoryData[r0_13] then
			mineInventoryData[r0_13] = {
				mineLamps = 0,
				railIrons = 0,
				railWoods = 0,
				subCartNum = 0,
				dieselLoco = false,
				fuelTankLevel = 0,
				fuelTankOutside = false,
			}
		end
		local r2_13 = mineInventoryData[r0_13]
		if not mineTrainData[r0_13] then
			mineTrainData[r0_13] = {
				trackId = 1,
				routeId = -1,
				trackPosition = math.min(getMineTrainLength(r0_13), 12),
				trackDirection = 1,
				fuelLevel = 100,
				jerryCarry = nil,
				jerryContent = 0,
			}
		end
		if r2_13.dieselLoco then
			mineTrainPassengers[r0_13] = {}
		end
		for r6_13, r7_13 in pairs(mineRails[r0_13]) do
			if #r7_13 == 4 then
				local r8_13 = r7_13[1]
				local r9_13 = r7_13[2]
				if not mineRailsAt[r0_13][r8_13] then
					mineRailsAt[r0_13][r8_13] = {}
				end
				mineRailsAt[r0_13][r8_13][r9_13] = r6_13
			else
				local r8_13 = r7_13[1]
				local r9_13 = r7_13[3]
				local r10_13 = r7_13[3]
				if r10_13 < r7_13[1] then
					r10_13 = -1
				else
					r10_13 = 1
				end
				for r11_13 = r8_13, r9_13, r10_13 do
					if not mineRailsAt[r0_13][r11_13] then
						mineRailsAt[r0_13][r11_13] = {}
					end
					local r12_13 = r7_13[2]
					local r13_13 = r7_13[4]
					local r14_13 = r7_13[4]
					if r14_13 < r7_13[2] then
						r14_13 = -1
					else
						r14_13 = 1
					end
					for r15_13 = r12_13, r13_13, r14_13 do
						mineRailsAt[r0_13][r11_13][r15_13] = r6_13
					end
				end
			end
		end
		for r6_13, r7_13 in pairs(mineRailSwitches[r0_13]) do
			local r8_13 = r7_13[1]
			local r9_13 = r7_13[2]
			if 4 < #r7_13 and not mineRailSwitchStates[r0_13][r6_13] then
				mineRailSwitchStates[r0_13][r6_13] = 1
			end
			if mineRailsAt[r0_13][r8_13] then
				mineRailsAt[r0_13][r8_13][r9_13] = nil
			end
			if not mineRailSwitchesAt[r0_13][r8_13] then
				mineRailSwitchesAt[r0_13][r8_13] = {}
			end
			mineRailSwitchesAt[r0_13][r8_13][r9_13] = r6_13
		end
		if not mineCartEmptying[r0_13] then
			mineCartEmptying[r0_13] = {}
		end
		if not mineBufferContent[r0_13] then
			mineBufferContent[r0_13] = {}
		end
		if not mineFoundryContent[r0_13] then
			mineFoundryContent[r0_13] = {}
		end
		if not mineOreBoxCarrying[r0_13] then
			mineOreBoxCarrying[r0_13] = {}
		end
		if not r34_0[r0_13] then
			local r3_13 = {
				furnaceRunning = false,
				furnaceTemperature = {},
				furnaceLastRefresh = {},
				meltingOre = false,
				meltProgress = 0,
			}
			for r7_13, r8_13 in pairs(oreTypes) do
				if r8_13.meltingPoint then
					r3_13.furnaceTemperature[r7_13] = 0
				end
			end
			r34_0[r0_13] = r3_13
		end
		if not mineLights[r0_13] then
			mineLights[r0_13] = {}
		end
	end
end
function resetMine(r0_14, r1_14)
	-- line: [505, 600] id: 14
	if loadedMinesData[r0_14] then
		local r3_14 = getCorridorIdFromLobbyCorridor(getLobbyFromMineId(r0_14))
		for r7_14 = 1, #playersInMine[r0_14], 1 do
			local r8_14 = playersInMine[r0_14][r7_14]
			if isElement(r8_14) then
				setPlayerMine(r8_14, false)
				r4_0[r8_14] = nil
				playerCarryingOreBox[r8_14] = nil
				r6_0[r8_14] = nil
				if r1_14 == "expired" then
					exports.sGui:showInfobox(r8_14, "w", "Ki lettél teleportálva, mert lejárt a bánya bérleti ideje!")
				else
					exports.sGui:showInfobox(r8_14, "w", "Ki lettél teleportálva, mert a bánya bérletét lemondták!")
				end
			end
		end
		playersInMine[r0_14] = nil
		if isTimer(r33_0[r0_14]) then
			killTimer(r33_0[r0_14])
		end
		r7_0[r0_14] = nil
		mineShafts[r0_14] = nil
		r9_0[r0_14] = nil
		mineShaftOres[r0_14] = nil
		mineShaftDepths[r0_14] = nil
		mineShaftLengths[r0_14] = nil
		mineJunctions[r0_14] = nil
		mineJunctionsAt[r0_14] = nil
		r15_0[r0_14] = nil
		mineOpenShaftsAt[r0_14] = nil
		mineExtendableShaftsAt[r0_14] = nil
		mineFixOres[r0_14] = nil
		mineRails[r0_14] = nil
		mineRailsAt[r0_14] = nil
		mineRailSwitches[r0_14] = nil
		mineRailSwitchesAt[r0_14] = nil
		mineRailSwitchStates[r0_14] = nil
		mineTrainData[r0_14] = nil
		mineTrainPassengers[r0_14] = nil
		mineInventoryData[r0_14] = nil
		r27_0[r0_14] = nil
		mineCartEmptying[r0_14] = nil
		mineSorterRunning[r0_14] = nil
		mineBufferContent[r0_14] = nil
		mineFoundryContent[r0_14] = nil
		mineOreBoxCarrying[r0_14] = nil
		r34_0[r0_14] = nil
		mineLights[r0_14] = nil
		mineOrders[r0_14] = nil
		mineOrderPaid[r0_14] = nil
		mineOrderTransit[r0_14] = nil
		mineTankPreRequest[r0_14] = nil
		r33_0[r0_14] = nil
		if fixOres[r0_14] then
			fixOres[r0_14] = nil
			if not next(fixOres) then
				if isTimer(r46_0) then
					killTimer(r46_0)
				end
				r46_0 = nil
			end
		end
		loadedMinesData[r0_14] = nil
		if #playersInLobby[r3_14] > 0 then
			triggerClientEvent(playersInLobby[r3_14], "gotNewMineData", gamemodeRoot, r0_14, nil)
		end
		collectgarbage()
		if isElement(dbConnection) then
			dbExec(dbConnection, "DELETE FROM mines WHERE mineId = ?", r0_14)
		end
		if fileExists("data/" .. r0_14 .. ".see") then
			fileDelete("data/" .. r0_14 .. ".see")
		end
		return true
	end
	return false
end
function checkValidSpot(r0_15, r1_15, r2_15)
	-- line: [604, 606] id: 15
	local r3_15 = r15_0[r0_15][r1_15]
	if r3_15 then
		r3_15 = r15_0[r0_15][r1_15][r2_15] or mineJunctionsAt[r0_15][r1_15] and mineJunctionsAt[r0_15][r1_15][r2_15]
	else
		r3_15 = mineJunctionsAt[r0_15][r1_15] and mineJunctionsAt[r0_15][r1_15][r2_15]
	end
	return r3_15
end
function checkValidSpotEx(r0_16, r1_16, r2_16)
	-- line: [608, 615] id: 16
	if checkValidSpot(r0_16, r1_16, r2_16) and (not mineOpenShaftsAt[r0_16][r1_16] or not mineOpenShaftsAt[r0_16][r1_16][r2_16]) then
		return true
	end
	return false
end
function getMineTrainLength(r0_17)
	-- line: [619, 627] id: 17
	local r1_17 = mineInventoryData[r0_17]
	if r1_17 then
		local r2_17 = r1_17.dieselLoco
		if r2_17 then
			r2_17 = dieselLocoLength
		else
			r2_17 = mineCartLength
		end
		return r2_17 + mineCartLength * r1_17.subCartNum
	end
	return 0
end
function findRailAngle(r0_18, r1_18)
	-- line: [629, 639] id: 18
	local r2_18 = mineRails[r0_18][r1_18]
	if not r2_18 then
		return 
	elseif #r2_18 == 4 then
		return prad(r2_18[3])
	end
	return patan2(r2_18[4] - r2_18[2], r2_18[3] - r2_18[1])
end
function processSwitch(r0_19, r1_19, r2_19, r3_19)
	-- line: [641, 683] id: 19
	local r4_19 = getNearTracks(mineRailsAt[r0_19], r1_19, r2_19, r3_19)
	if #r4_19 == 2 then
		local r5_19 = r4_19[1]
		local r6_19 = r4_19[2]
		if (patan2(r2_19 - r5_19.trackY, r1_19 - r5_19.trackX) - patan2(r2_19 - r6_19.trackY, r1_19 - r6_19.trackX) + PI) % TWO_PI - PI > 0 then
			return {
				r5_19.trackId,
				r6_19.trackId
			}
		else
			return {
				r6_19.trackId,
				r5_19.trackId
			}
		end
	elseif #r4_19 > 2 then
		local r5_19 = {}
		for r9_19 = 1, #r4_19, 1 do
			local r10_19 = r4_19[r9_19]
			if r10_19 then
				table.insert(r5_19, {
					r10_19.trackId,
					patan2(r2_19 - r10_19.trackY, r1_19 - r10_19.trackX)
				})
			end
		end
		table.sort(r5_19, function(r0_20, r1_20)
			-- line: [669, 671] id: 20
			return r1_20[2] < r0_20[2]
		end)
		while r5_19[1][2] % PI ~= r5_19[3][2] % PI do
			table.insert(r5_19, 1, table.remove(r5_19, #r5_19))
		end
		for r9_19 = 1, #r5_19, 1 do
			r5_19[r9_19] = r5_19[r9_19][1]
		end
		return r5_19
	end
end
function findFreeRailTrack(r0_21)
	-- line: [685, 693] id: 21
	local r1_21 = 1
	while mineRails[r0_21][r1_21] do
		r1_21 = r1_21 + 1
	end
	return r1_21
end
function findFreeRailSwitch(r0_22)
	-- line: [695, 703] id: 22
	local r1_22 = 1
	while mineRailSwitches[r0_22][r1_22] do
		r1_22 = r1_22 + 1
	end
	return r1_22
end
function resetPlayerJerrycan(r0_23)
	-- line: [707, 721] id: 23
	local r1_23 = playersCurrentMine[r0_23]
	if r1_23 then
		local r2_23 = mineTrainData[r1_23]
		if r2_23.jerryCarry == r0_23 then
			r2_23.jerryCarry = nil
			if #playersInMine[r1_23] > 0 then
				triggerClientEvent(playersInMine[r1_23], "gotMineJerrycan", r0_23, r1_23, false)
			end
		end
	end
end
function resetPlayerOreBox(r0_24)
	-- line: [723, 743] id: 24
	local r1_24 = playersCurrentMine[r0_24]
	if r1_24 then
		local r2_24 = playerCarryingOreBox[r0_24]
		if r2_24 then
			mineOreBoxCarrying[r1_24][r2_24] = nil
			if #playersInMine[r1_24] > 0 then
				triggerClientEvent(playersInMine[r1_24], "syncMineOreBoxCarry", r0_24, r1_24, false)
			end
			if eventName ~= "onPlayerQuit" then
				exports.sControls:toggleControl(r0_24, {
					"fire",
					"crouch",
					"aim_weapon",
					"jump",
					"jog"
				}, true, "mineOreCarry")
			end
		end
	end
	playerCarryingOreBox[r0_24] = nil
end
function resetPlayerFixOre(r0_25)
	-- line: [745, 771] id: 25
	local r1_25 = playersCurrentMine[r0_25]
	if r1_25 then
		local r2_25 = r4_0[r0_25]
		if r2_25 then
			local r3_25 = mineFixOres[r1_25][r2_25]
			if r3_25 then
				r3_25[4] = nil
				r3_25[5] = nil
				r3_25[6] = nil
				if #playersInMine[r1_25] > 0 then
					triggerClientEvent(playersInMine[r1_25], "syncFixOreState", resourceRoot, r1_25, r2_25, "ground", r3_25[1], r3_25[2])
				end
			end
			if eventName ~= "onPlayerQuit" then
				exports.sControls:toggleControl(r0_25, {
					"fire",
					"crouch",
					"aim_weapon",
					"jump",
					"jog"
				}, true, "mineOreCarry")
			end
		end
	end
	r4_0[r0_25] = nil
end
addEvent("syncMineTablet", true)
addEventHandler("syncMineTablet", root, function(r0_26)
	-- line: [777, 797] id: 26
	if r0_26 then
		r0_26 = true
	else
		r0_26 = nil
	end
	if client then
		if r0_26 and not playersCurrentMine[client] then
			return exports.sGui:showInfobox(client, "e", "Csak bányában veheted elő!")
		end
		r1_0[client] = r0_26
		if r0_26 then
			exports.sChat:localAction(client, "elővett egy MiguMoto Tabletet.")
		else
			exports.sChat:localAction(client, "elrakott egy MiguMoto Tabletet.")
		end
		if #loadedPlayers > 0 then
			triggerClientEvent(loadedPlayers, "syncMineTablet", client, r0_26)
		end
	end
end)
addMineEventHandler("renameMine", root, function(r0_27, r1_27)
	-- line: [803, 838] id: 27
	local r2_27 = loadedMinesData[r0_27]
	if not checkMinePermission(client) then
		triggerLatentClientEvent(client, "renameMineResponse", client, false, "Ehhez nincs jogosultságod!")
	elseif #r1_27 > 2 then
		triggerLatentClientEvent(client, "renameMineResponse", client, false, "A bánya neve túl hosszú!")
	else
		local r3_27 = getCorridorIdFromLobbyCorridor(getLobbyFromMineId(r0_27))
		if r3_27 then
			for i = 1, #r1_27 do
				r1_27[i] = utf8.upper(r1_27[i])
			end
			local r4_27 = table.concat(r1_27, "|")
			if table.concat(r2_27.mineName, "|") ~= r4_27 then
				r2_27.mineName = r1_27
				if isElement(dbConnection) then
					dbExec(dbConnection, "UPDATE mines SET mineName = ? WHERE mineId = ?", r4_27, r0_27)
				end
				if #playersInMine[r0_27] > 0 then
					triggerClientEvent(playersInMine[r0_27], "gotMineRentDataInside", client, r0_27, "mineName", r1_27)
				end
				if #playersInLobby[r3_27] > 0 then
					triggerClientEvent(playersInLobby[r3_27], "gotMineRentData", client, r0_27, "mineName", r4_27)
				end
			end
			triggerLatentClientEvent(client, "renameMineResponse", client, r1_27)
		else
			triggerLatentClientEvent(client, "renameMineResponse", client)
		end
	end
end)
addMineEventHandler("useMineFaucet", root, function(r0_28)
	-- line: [842, 855] id: 28
	if hasElementData(client, "mineDirtyFace") then
		removeElementData(client, "mineDirtyFace")
		setPedHeadingTo(client, minePosX - 27.3901, minePosY + 2.8282)
		setPedAnimation(client, "int_house", "wash_up", -1, false, false, false, false)
		if #playersInMine[r0_28] > 0 then
			triggerClientEvent(playersInMine[r0_28], "playMineFaucetSound", client, r0_28)
		end
		exports.sChat:localAction(client, "megmosakodott.")
	end
end)
addEvent("removeMineDirtyFace", true)
addEventHandler("removeMineDirtyFace", root, function()
	-- line: [860, 864] id: 29
	if client then
		removeElementData(client, "mineDirtyFace")
	end
end)
addMineEventHandler("buildMineLight", root, function(r0_30, r1_30, r2_30)
	-- line: [868, 894] id: 30
	local r3_30 = mineInventoryData[r0_30]
	if not checkMinePermission(client, permissionFlags.CONSTRUCT_LAMP) then
		exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
	elseif r3_30.mineLamps < 1 then
		exports.sGui:showInfobox(client, "e", "Nincs elég lámpa készleten!")
	elseif not mineLights[r0_30][r1_30] or not mineLights[r0_30][r1_30][r2_30] then
		r3_30.mineLamps = r3_30.mineLamps - 1
		if r3_30.mineLamps < 0 then
			r3_30.mineLamps = 0
		end
		if not mineLights[r0_30][r1_30] then
			mineLights[r0_30][r1_30] = {}
		end
		mineLights[r0_30][r1_30][r2_30] = true
		if #playersInMine[r0_30] > 0 then
			triggerClientEvent(playersInMine[r0_30], "buildMineLight", client, r0_30, r1_30, r2_30, r3_30.mineLamps)
		end
		exports.sChat:localAction(client, "felszerelt egy lámpát.")
	end
end)
addMineEventHandler("cancelMineOrder", root, function(r0_31)
	-- line: [900, 915] id: 31
	if not checkMinePermission(client, permissionFlags.ORDER) then
		exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
	elseif mineOrders[r0_31] then
		exports.sGui:showInfobox(client, "s", "Lemondtad a rendelést.")
		mineOrders[r0_31] = nil
		mineOrderPaid[r0_31] = nil
		if #playersInMine[r0_31] > 0 then
			triggerClientEvent(playersInMine[r0_31], "gotMineOrder", client, r0_31, mineOrders[r0_31], mineOrderPaid[r0_31])
		end
		triggerLatentClientEvent(client, "mineOrderResponse", client)
	end
end)
addMineEventHandler("createMineOrder", root, function(r0_32, r1_32)
	-- line: [919, 944] id: 32
	if not checkMinePermission(client, permissionFlags.ORDER) then
		triggerLatentClientEvent(client, "mineOrderResponse", client, false, "Ehhez nincs jogosultságod!")
	else
		local r2_32 = mineInventoryData[r0_32]
		if r2_32 then
			refreshOrderConstraints(r1_32, r2_32)
			if mineOrders[r0_32] then
				triggerLatentClientEvent(client, "mineOrderResponse", client, false, "Már van leadva rendelés!")
			elseif next(r1_32) then
				iprint(r1_32)
				mineOrders[r0_32] = r1_32
				mineOrderPaid[r0_32] = nil
				if #playersInMine[r0_32] > 0 then
					triggerClientEvent(playersInMine[r0_32], "gotMineOrder", client, r0_32, mineOrders[r0_32], mineOrderPaid[r0_32])
				end
				triggerLatentClientEvent(client, "mineOrderResponse", client, true, "Leadtad a rendelést. Átvenni a Sight Mining Co. telephelyén tudod.")
			else
				triggerLatentClientEvent(client, "mineOrderResponse", client, false)
			end
		end
	end
end)
addMineEventHandler("updateMinePermissions", root, function(r0_33, r1_33)
	-- line: [950, 966] id: 33
	local r2_33 = loadedMinesData[r0_33]
	if not checkMinePermission(client) then
		return 
	elseif next(r1_33) then
		for r6_33, r7_33 in pairs(r1_33) do
			if r2_33.workerPermissions[r6_33] then
				r2_33.workerPermissions[r6_33] = r7_33
			end
		end
		if #playersInMine[r0_33] > 0 then
			triggerClientEvent(playersInMine[r0_33], "updateMinePermissions", client, r0_33, r2_33.workerPermissions)
		end
	end
end)
addMineEventHandler("removeMinePermissions", root, function(r0_34, r1_34)
	-- line: [970, 1006] id: 34
	local r2_34 = loadedMinesData[r0_34]
	if not checkMinePermission(client) then
		exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
	elseif not r2_34.workerPermissions[r1_34] then
		exports.sGui:showInfobox(client, "e", "A kiválasztott játékos nem alkalmazottad!")
	else
		r2_34.workerNames[r1_34] = nil
		r2_34.workerPermissions[r1_34] = nil
		if #playersInMine[r0_34] > 0 then
			triggerClientEvent(playersInMine[r0_34], "removeMinePermissions", client, r0_34, r1_34)
		end
		for r6_34 = 1, #playersInMine[r0_34], 1 do
			if getElementData(playersInMine[r0_34], "char.ID") == r1_34 then
				local r8_34 = getCorridorIdFromLobbyCorridor(getLobbyFromMineId(r0_34))
				for r12_34 = #r2_34.workersInside, 1, -1 do
					if r2_34.workersInside[r12_34] == r1_34 then
						table.remove(r2_34.workersInside, r12_34)
						break
					end
				end
				if #playersInLobby[r8_34] > 0 then
					triggerClientEvent(playersInLobby[r8_34], "gotMineRentData", client, r0_34, "workersInside", r2_34.workersInside)
					break
				else
					break
				end
			end
		end
	end
end)
addMineEventHandler("addMinePermissions", root, function(r0_35, r1_35)
	-- line: [1010, 1063] id: 35
	local r2_35 = loadedMinesData[r0_35]
	if not checkMinePermission(client) then
		exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
	elseif not isElement(r1_35) then
		exports.sGui:showInfobox(client, "e", "A kiválasztott játékos nem található!")
	elseif r1_35 == client then
		exports.sGui:showInfobox(client, "e", "Saját magadat nem alkalmazhatod!")
	else
		local r3_35 = getElementData(r1_35, "char.ID")
		local r4_35 = getElementData(r1_35, "visibleName"):gsub("_", " ")
		if not r3_35 then
			exports.sGui:showInfobox(client, "e", "A kiválasztott játékos nincs bejelentkezve!")
		elseif r2_35.workerPermissions[r3_35] then
			exports.sGui:showInfobox(client, "e", "A kiválasztott játékos már alkalmazottad!")
		else
			local r5_35 = 0
			for r9_35 in pairs(r2_35.workerPermissions) do
				r5_35 = r5_35 + 1
				if maxWorkers <= r5_35 then
					return exports.sGui:showInfobox(client, "e", "Nem alkalmazhatsz több munkást!")
				end
			end
			r2_35.workerNames[r3_35] = r4_35
			r2_35.workerPermissions[r3_35] = 0
			if #playersInMine[r0_35] > 0 then
				triggerClientEvent(playersInMine[r0_35], "addMinePermissions", client, r0_35, r3_35, r4_35)
			end
			if r0_35 == playersCurrentMine[r1_35] then
				local r6_35 = getCorridorIdFromLobbyCorridor(getLobbyFromMineId(r0_35))
				for r10_35 = #r2_35.workersInside, 1, -1 do
					if r2_35.workersInside[r10_35] == r3_35 then
						table.remove(r2_35.workersInside, r10_35)
						break
					end
				end
				table.insert(r2_35.workersInside, r3_35)
				if #playersInLobby[r6_35] > 0 then
					triggerClientEvent(playersInLobby[r6_35], "gotMineRentData", client, r0_35, "workersInside", r2_35.workersInside)
				end
			end
		end
	end
end)
addTrailerEventHandler("deliverMineOrder", root, function(r0_36, r1_36)
	-- line: [1069, 1091] id: 36
	if mineOrders[r1_36] then
		local r2_36 = playersCurrentLobby[client]
		if r2_36 and r2_36 == getCorridorIdFromLobbyCorridor(getLobbyFromMineId(r1_36)) then
			local r4_36 = exports.sWorkaround:getTrailerData(r0_36) or {}
			if r4_36[1] == r1_36 and 2 <= #r4_36 then
				processTrailerData(r4_36)
				if isElement(client) then
					exports.sGui:showInfobox(client, "s", "Leszállítottad a rendelést.")
				end
				exports.sWorkaround:setTrailerData(r0_36, nil)
			end
		end
	end
end)
addEvent("trailerMineOrder", true)
addEventHandler("trailerMineOrder", root, function(r0_37, r1_37)
	iprint(r0_37, r1_37)
	-- line: [1096, 1132] id: 37
	if client then
		local r2_37 = mineOrders[r0_37]
		if r2_37 then
			if not checkMinePermission(client, permissionFlags.ORDER, r0_37) then
				exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
			elseif not mineOrderPaid[r0_37] then
				exports.sGui:showInfobox(client, "e", "A rendelés még nincs kifizetve!")
			elseif isElement(mineOrderTransit[r0_37]) then
				exports.sGui:showInfobox(client, "e", "A rendelést már átvették!")
			elseif isElement(r1_37) then
				if getElementModel(r1_37) ~= 611 then
					exports.sGui:showInfobox(client, "e", "Nem megfelelő utánfutó!")
				elseif not exports.sWorkaround:isTrailerEmpty(r1_37) then
					exports.sGui:showInfobox(client, "e", "Az utánfutó már foglalt!")
				else
					local r3_37 = {
						r0_37
					}
					for r7_37, r8_37 in pairs(r2_37) do
						for r12_37 = 1, r8_37, 1 do
							table.insert(r3_37, r7_37)
						end
					end
					if exports.sWorkaround:setTrailerData(r1_37, r3_37) then
						mineOrderTransit[r0_37] = r1_37
					end
					exports.sGui:showInfobox(client, "s", "Átvetted a rendelést. Vidd a bányába!")
				end
			end
		end
		triggerLatentClientEvent(client, "gotMineListForOrders", client, getPlayerMineOrders(client))
	end
end)
addEvent("payMineOrder", true)
addEventHandler("payMineOrder", root, function(r0_38)
	-- line: [1137, 1177] id: 38
	if client then
		local r1_38 = mineOrders[r0_38]
		if r1_38 then
			local r2_38, r3_38 = getOrderPrice(r1_38)
			if mineOrderPaid[r0_38] then
				exports.sGui:showInfobox(client, "e", "A rendelést már kifizették!")
			elseif not checkMinePermission(client, permissionFlags.ORDER, r0_38) then
				exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
			else
				local pp = exports.sCore:getPP(client) >= r2_38
				local money = exports.sCore:getMoney(client) >= r2_38
				if r3_38 and pp then
					exports.sCore:takePP(client, r2_38)
					mineOrderPaid[r0_38] = true
				elseif not r3_38 and exports.sCore:takeMoney(client, r2_38, eventName) and money then
					mineOrderPaid[r0_38] = true
				end
				if not mineOrderPaid[r0_38] then
					if r3_38 then
						exports.sGui:showInfobox(client, "e", "Nincs elég prémium pontod a rendelés kifizetésére!")
					else
						exports.sGui:showInfobox(client, "e", "Nincs elég pénzed a rendelés kifizetésére!")
					end
				else
					serializeMine(r0_38, true)
					if #playersInMine[r0_38] > 0 then
						triggerClientEvent(playersInMine[r0_38], "gotMineOrderPaid", client, r0_38, mineOrderPaid[r0_38])
					end
					exports.sGui:showInfobox(client, "s", "Kifizetted a rendelést. Már fel tudod rakodni.")
				end
			end
		end
		triggerLatentClientEvent(client, "gotMineListForOrders", client, getPlayerMineOrders(client))
	end
end)
addEvent("requestMineListForOrders", true)
addEventHandler("requestMineListForOrders", root, function()
	-- line: [1182, 1186] id: 39
	if client then
		triggerLatentClientEvent(client, "gotMineListForOrders", client, getPlayerMineOrders(client))
	end
end)
function getPlayerMineOrders(r0_40)
	-- line: [1189, 1216] id: 40
	local r1_40 = getElementData(r0_40, "char.ID")
	if r1_40 then
		local r2_40 = {}
		for r6_40 in pairs(mineOrders) do
			local r7_40 = loadedMinesData[r6_40]
			if r7_40.rentedBy == r1_40 or r7_40.workerPermissions[r1_40] then
				local r8_40, r9_40 = getOrderPrice(mineOrders[r6_40])
				local r10_40 = table.insert
				local r11_40 = r2_40
				local r12_40 = {
					mineId = r6_40,
					mineName = utf8.upper(table.concat(r7_40.mineName, " ")),
				}
				local r13_40 = formatNumber(r8_40)
				local r14_40 = nil	-- notice: implicit variable refs by block#[7]
				if r9_40 then
					r14_40 = " PP"
				else
					r14_40 = " $"
				end
				r12_40.totalPrice = r13_40 .. r14_40
				r12_40.isPremium = r9_40
				r12_40.isPaid = mineOrderPaid[r6_40]
				r12_40.inTransit = isElement(mineOrderTransit[r6_40])
				r10_40(r11_40, r12_40)
			end
		end
		return r2_40
	end
	return false
end
function processMineOrder(r0_41, r1_41)
	-- line: [1218, 1282] id: 41
	local r2_41 = mineInventoryData[r0_41]
	local r3_41 = false
	for r7_41, r8_41 in pairs(r1_41) do
		if r7_41 == "railIrons" then
			r2_41[r7_41] = math.min(r2_41[r7_41] + railIronStack * r8_41, 2 * railIronStack)
		elseif r7_41 == "railWoods" then
			r2_41[r7_41] = math.min(r2_41[r7_41] + railWoodStack * r8_41, 2 * railWoodStack)
		elseif r7_41 == "mineLamps" then
			r2_41[r7_41] = math.min(r2_41[r7_41] + mineLampStack * r8_41, 2 * mineLampStack)
		elseif r7_41 == "subCartNum" then
			if r2_41.dieselLoco then
				r2_41.subCartNum = math.min(6, r2_41.subCartNum + r8_41 + 1)
			else
				r2_41.subCartNum = math.min(1, r2_41.subCartNum + r8_41)
			end
			iprint(r2_41.subCartNum, r8_41)
			r3_41 = true
		elseif r7_41 == "dieselLoco" and not r2_41.dieselLoco then
			r2_41.dieselLoco = true
			if not mineTrainPassengers[r0_41] then
				mineTrainPassengers[r0_41] = {}
			end
			r2_41.subCartNum = r2_41.subCartNum + 1

			if r2_41.subCartNum < 1 then
				r2_41.subCartNum = 1
			end
			iprint(r2_41.subCartNum)
			r3_41 = true
		end
		if #playersInMine[r0_41] > 0 then
			triggerClientEvent(playersInMine[r0_41], "updateMineInventory", resourceRoot, r0_41, r7_41, r2_41[r7_41])
			if r7_41 == "dieselLoco" then
				iprint(r2_41.subCartNum, "triggered with")
				triggerClientEvent(playersInMine[r0_41], "updateMineInventory", resourceRoot, r0_41, "subCartNum", r2_41.subCartNum)
			end
		end
	end
	if r3_41 then
		local r4_41 = mineTrainData[r0_41]
		if r4_41 then
			local r5_41 = getMineTrainLength(r0_41)
			if r4_41.trackPosition - r5_41 < 0 then
				r4_41.trackPosition = r5_41
			end
			if #playersInMine[r0_41] > 0 then
				triggerClientEvent(playersInMine[r0_41], "mineRailSyncing", resourceRoot, r0_41, r4_41)
			end
		end
	end
	if #playersInMine[r0_41] > 0 then
		triggerClientEvent(playersInMine[r0_41], "gotMineOrder", resourceRoot, r0_41, nil, nil)
	end
	serializeMine(r0_41, true)
end
function processTrailerData(r0_42)
	-- line: [1284, 1307] id: 42
	local r1_42 = r0_42[1]
	if r1_42 then
		if #r0_42 == 1 then
			local r2_42 = mineInventoryData[r1_42]
			if r2_42.tankOutside then
				r2_42.tankOutside = false
				if #playersInMine[r1_42] > 0 then
					triggerClientEvent(playersInMine[r1_42], "updateMineInventory", resourceRoot, r1_42, "tankOutside", false)
				end
			end
		elseif #r0_42 >= 2 then
			mineOrderTransit[r1_42] = nil
			if mineOrders[r1_42] then
				processMineOrder(r1_42, mineOrders[r1_42])
				mineOrders[r1_42] = nil
			end
		end
	end
end
function canRentTrailer(r0_43)
	-- line: [1309, 1316] id: 43
	for r4_43 in pairs(mineOrders) do
		if checkMinePermission(r0_43, permissionFlags.ORDER, r4_43) then
			return true
		end
	end
	return false
end
addTrailerEventHandler("returnMineFuelTank", root, function(r0_44)
	-- line: [1321, 1344] id: 44
	local r1_44 = r6_0[client]
	if r1_44 then
		local r2_44 = playersCurrentLobby[client]
		if r2_44 and r2_44 == getCorridorIdFromLobbyCorridor(getLobbyFromMineId(r1_44)) then
			local r4_44 = exports.sWorkaround:getTrailerData(r0_44) or {}
			if r4_44[1] == r1_44 and #r4_44 == 1 then
				local r1_48 = mineInventoryData[r1_44]
				r1_48.fuelTankLevel = math.floor((r1_48.fuelTankLevel or 0) + getElementData(r0_44, "vehicle.fuel"))
				if r1_48.fuelTankLevel > 1000 then
					r1_48.fuelTankLevel = 1000
				end
				triggerClientEvent(playersInMine[r1_44], "updateMineInventory", client, r1_44, "fuelTankLevel", r1_48.fuelTankLevel)
				processTrailerData(r4_44)
				triggerClientEvent(client, "gotMineTankPreRequest", client, false)
				r6_0[client] = nil
				exports.sWorkaround:setTrailerData(r0_44, nil)
				setElementData(r0_44, "vehicle.fuel", 0)
			end
		end
	end
end)
addTrailerEventHandler("trailerMineTank", root, function(r0_45, r1_45)
	-- line: [1348, 1384] id: 45
	local r2_45 = playersCurrentLobby[client]
	if r2_45 and r2_45 == getCorridorIdFromLobbyCorridor(getLobbyFromMineId(r1_45)) and loadedMinesData[r1_45] then
		local r5_45 = mineInventoryData[r1_45]
		if not checkMinePermission(client, permissionFlags.ORDER, r1_45) then
			exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
		elseif r5_45.tankOutside then
			exports.sGui:showInfobox(client, "e", "A tartály már szállítás alatt van!")
		elseif getElementModel(r0_45) ~= 611 then
			exports.sGui:showInfobox(client, "e", "Nem megfelelő utánfutó!")
		elseif not exports.sWorkaround:isTrailerEmpty(r0_45) then
			exports.sGui:showInfobox(client, "e", "Az utánfutó már foglalt!")
		elseif r6_0[client] == r1_45 and exports.sWorkaround:setTrailerData(r0_45, {
			r1_45
		}) then
			r5_45.tankOutside = true
			if #playersInMine[r1_45] > 0 then
				triggerClientEvent(playersInMine[r1_45], "updateMineInventory", resourceRoot, r1_45, "tankOutside", true)
			end
			exports.sGui:showInfobox(client, "i", "A tartályt bármely benzinkúton meg tudod tankolni. Ide hozd vissza!")
		end
	end
end)
addMineEventHandler("requestMineFuelTank", root, function(r0_46)
	-- line: [1388, 1416] id: 46
	local r1_46 = mineInventoryData[r0_46]
	if not checkMinePermission(client, permissionFlags.ORDER) then
		exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
	elseif r1_46.tankOutside then
		exports.sGui:showInfobox(client, "e", "A tartály már szállítás alatt van!")
	elseif not r6_0[client] then
		r6_0[client] = r0_46
		if #playersInMine[r0_46] > 0 then
			triggerClientEvent(client, "gotMineTankPreRequest", client, r0_46)
		end
		exports.sGui:showInfobox(client, "i", "Megkezdted az üzemanyagtartály feltöltését. Állj a megjelölt helyre egy üres utánfutóval, a kék jelölést autóban ülve látod.")
	elseif r6_0[client] == r0_46 then
		r6_0[client] = nil
		if #playersInMine[r0_46] > 0 then
			triggerClientEvent(client, "gotMineTankPreRequest", client, false)
		end
		exports.sGui:showInfobox(client, "i", "Megszakítottad az üzemanyagtartály feltöltését.")
	else
		exports.sGui:showInfobox(client, "e", "Már egy másik bányában megkezdted az üzemanyagtartály feltöltését!")
	end
end)
addMineEventHandler("fillMineLocoTank", root, function(r0_47)
	-- line: [1422, 1459] id: 47
	if mineInventoryData[r0_47].dieselLoco then
		local r2_47 = mineTrainData[r0_47] 
		if r2_47.jerryCarry == client then
			if r2_47.jerryContent <= 0 then
				exports.sGui:showInfobox(client, "e", "A kanna üres!")
			elseif r2_47.fuelLevel >= 100 then
				exports.sGui:showInfobox(client, "e", "A tank tele van!")
			else
				local r3_47 = math.min(locoTankCapacity - r2_47.fuelLevel * locoTankCapacity / 100, r2_47.jerryContent)
				if r3_47 > 0 then
					r2_47.fuelLevel = r2_47.fuelLevel + r3_47 / locoTankCapacity * 100
					if r2_47.fuelLevel > 100 then
						r2_47.fuelLevel = 100
					end
					r2_47.jerryContent = r2_47.jerryContent - r3_47
					if r2_47.jerryContent < 0 then
						r2_47.jerryContent = 0
					end
					if #playersInMine[r0_47] > 0 then
						triggerClientEvent(playersInMine[r0_47], "syncMineLocoFuel", client, r0_47, r2_47.fuelLevel, r3_47 * 1000)
						triggerClientEvent(playersInMine[r0_47], "syncMineJerryContent", client, r0_47, r2_47.jerryContent)
					end
					exports.sChat:localAction(client, "megtankolta a mozdonyt.")
				end
			end
		end
	end
end)
addMineEventHandler("fillMineJerrycan", root, function(r0_48)
	-- line: [1463, 1500] id: 48
	local r1_48 = mineInventoryData[r0_48]
	if r1_48.dieselLoco then
		local r2_48 = mineTrainData[r0_48]
		if r1_48.fuelTankOutside then
			return 
		elseif r2_48.jerryCarry == client then
			if r1_48.fuelTankLevel <= 0 then
				exports.sGui:showInfobox(client, "e", "A tartály üres!")
			elseif jerryCanCapacity <= r2_48.jerryContent then
				exports.sGui:showInfobox(client, "e", "A kanna tele van!")
			else
				local r3_48 = math.min(jerryCanCapacity - r2_48.jerryContent, r1_48.fuelTankLevel)
				r2_48.jerryContent = r2_48.jerryContent + r3_48
				if jerryCanCapacity < r2_48.jerryContent then
					r2_48.jerryContent = jerryCanCapacity
				end
				r1_48.fuelTankLevel = r1_48.fuelTankLevel - r3_48
				if r1_48.fuelTankLevel < 0 then
					r1_48.fuelTankLevel = 0
				end
				if #playersInMine[r0_48] > 0 then
					triggerClientEvent(playersInMine[r0_48], "updateMineInventory", client, r0_48, "fuelTankLevel", r1_48.fuelTankLevel)
					triggerClientEvent(playersInMine[r0_48], "syncMineJerryContent", client, r0_48, r2_48.jerryContent)
				end
				exports.sChat:localAction(client, "megtankolta a kannát.")
			end
		end
	end
end)
addMineEventHandler("putMineJerrycan", root, function(r0_49)
	-- line: [1504, 1520] id: 49
	if mineInventoryData[r0_49].dieselLoco then
		local r2_49 = mineTrainData[r0_49]
		if r2_49.jerryCarry == client then
			r2_49.jerryCarry = nil
			if #playersInMine[r0_49] > 0 then
				triggerClientEvent(playersInMine[r0_49], "gotMineJerrycan", client, r0_49, false)
			end
			exports.sChat:localAction(client, "visszatette a kannát a mozdonyra.")
		end
	end
end)
addMineEventHandler("getMineJerrycan", root, function(r0_50)
	-- line: [1524, 1540] id: 50
	if mineInventoryData[r0_50].dieselLoco then
		local r2_50 = mineTrainData[r0_50]
		if not isElement(r2_50.jerryCarry) then
			r2_50.jerryCarry = client
			if #playersInMine[r0_50] > 0 then
				triggerClientEvent(playersInMine[r0_50], "gotMineJerrycan", client, r0_50, r2_50.jerryCarry)
			end
			exports.sChat:localAction(client, "levette a kannát a mozdonyról.")
		end
	end
end)
addMineEventHandler("takeMineIngot", root, function(r0_51, r1_51)
	-- line: [1546, 1576] id: 51
	local r2_51 = oreTypes[r1_51]
	if r2_51.meltingPoint then
		local r3_51 = r34_0[r0_51]
		if not checkMinePermission(client, permissionFlags.COLLECT_PRODUCT) then
			exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
		elseif r3_51.meltingOre == r1_51 then
			r3_51.meltProgress = math.min(1, r3_51.meltProgress + (getTickCount() - r3_51.meltingStart) / meltingTime)
			r3_51.meltingStart = getTickCount()
			if r3_51.meltProgress < 1 then
				exports.sGui:showInfobox(client, "e", "Előbb várd meg a fém kiöntését!")
			elseif exports.sItems:giveItem(client, r2_51.itemId, 1) then
				r3_51.meltingOre = false
				r3_51.meltProgress = 0
				r3_51.meltingStart = nil
				if #playersInMine[r0_51] > 0 then
					triggerClientEvent(playersInMine[r0_51], "syncMineOreMelting", client, r0_51, false)
					triggerClientEvent(playersInMine[r0_51], "syncMineOreItemOutput", client, r0_51, r1_51)
				end
				exports.sChat:localAction(client, "kivett egy " .. r2_51.actionName .. " az öntőformából.")
			else
				exports.sGui:showInfobox(client, "e", "Nincs elég hely az inventorydban!")
			end
		end
	end
end)
addMineEventHandler("makeMineIngot", root, function(r0_52, r1_52)
	-- line: [1580, 1626] id: 52
	local r2_52 = oreTypes[r1_52]
	if r2_52.meltingPoint then
		local r3_52 = r34_0[r0_52]
		if not checkMinePermission(client, permissionFlags.USE_FOUNDRY) then
			exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
		elseif r3_52.furnaceRunning ~= r1_52 then
			exports.sGui:showInfobox(client, "e", "Először kapcsold be a kohót!")
		elseif not r3_52.meltingOre then
			local r4_52 = r3_52.furnaceLastRefresh[r1_52]
			if r4_52 then
				r4_52 = getTickCount() - r3_52.furnaceLastRefresh[r1_52]
			else
				r4_52 = 0
			end
			r3_52.furnaceTemperature[r1_52] = math.min(1000, r3_52.furnaceTemperature[r1_52] + r4_52 / r2_52.furnaceSpeed)
			r3_52.furnaceLastRefresh[r1_52] = getTickCount()
			if r3_52.furnaceTemperature[r1_52] < 1000 then
				exports.sGui:showInfobox(client, "e", "Előbb várd meg amíg a kohó eléri a szükséges hőfokot!")
			else
				local r5_52 = mineFoundryContent[r0_52][r1_52] or 0
				if math.floor(r5_52) < 1 then
					exports.sGui:showInfobox(client, "e", "Nincs elég nyersanyag az öntés megkezdéséhez!")
				else
					r5_52 = r5_52 - 1
					if r5_52 <= 0 then
						mineFoundryContent[r0_52][r1_52] = nil
					else
						mineFoundryContent[r0_52][r1_52] = r5_52
					end
					r3_52.meltingOre = r1_52
					r3_52.meltProgress = 0
					r3_52.meltingStart = getTickCount()
					if #playersInMine[r0_52] > 0 then
						triggerClientEvent(playersInMine[r0_52], "syncMineOreMelting", client, r0_52, r1_52)
						triggerClientEvent(playersInMine[r0_52], "syncMineFoundryStorage", client, r0_52, r1_52, r5_52)
					end
					exports.sChat:localAction(client, "elkezdett kiönteni egy " .. r2_52.actionName .. ".")
				end
			end
		end
	end
end)
addMineEventHandler("fillMineFoundry", root, function(mineId, r1_53)
	local r2_53 = playerCarryingOreBox[client]
	if r2_53 then
		local r3_53 = oreTypes[r2_53]
		if r3_53 then
			local r4_53 = mineBufferContent[mineId][r2_53] or 0
			local r5_53 = mineFoundryContent[mineId][r2_53] or 0
			if r4_53 > 0 then
				local r6_53 = math.min(r1_53, r4_53)
				if r6_53 > 0 then
					iprint(foundryContent, deltaContent)
					r4_53 = r4_53 - r6_53
					r5_53 = r5_53 + r6_53 * (1 + math.random() * 3)
					if r4_53 <= 0 then
						mineBufferContent[mineId][r2_53] = nil
					else
						mineBufferContent[mineId][r2_53] = r4_53
					end
					mineFoundryContent[mineId][r2_53] = r5_53
					if #playersInMine[mineId] > 0 then
						triggerClientEvent(playersInMine[mineId], "syncMineFoundryStorage", client, mineId, r2_53, r5_53)
						triggerClientEvent(playersInMine[mineId], "syncMineOreStorageRemove", client, mineId, r2_53, r6_53, true)
					end
					exports.sChat:localAction(client, "beöntött egy adag nyersanyagot a " .. r3_53.ingotNamePrefix .. " " .. r3_53.ingotName:gsub("%L", string.lower) .. "kohóba.")
				end
			end
		end
	end
end)
addMineEventHandler("toggleMineFoundry", root, function(r0_54, r1_54)
	-- line: [1671, 1723] id: 54
	local r2_54 = oreTypes[r1_54]
	if r2_54 then
		local r3_54 = r34_0[r0_54]
		if not r2_54.meltingPoint then
			return 
		elseif not checkMinePermission(client, permissionFlags.USE_FOUNDRY) then
			exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
		elseif r3_54.meltingOre then
			if r3_54.meltProgress >= 0.9 then
				exports.sGui:showInfobox(client, "e", "Előbb vedd ki a kihűlt fémet az öntőformából!")
			else
				exports.sGui:showInfobox(client, "e", "Előbb várd meg a fém kiöntését!")
			end
		else
			local r4_54 = r3_54.furnaceRunning
			if r4_54 then
				local r5_54 = r3_54.furnaceLastRefresh[r4_54]
				if r5_54 then
					r5_54 = getTickCount() - r3_54.furnaceLastRefresh[r4_54]
				else
					r5_54 = 0
				end
				r3_54.furnaceRunning = nil
				r3_54.furnaceTemperature[r4_54] = math.min(1000, r3_54.furnaceTemperature[r4_54] + r5_54 / r2_54.furnaceSpeed)
				r3_54.furnaceLastRefresh[r4_54] = getTickCount()
				if #playersInMine[r0_54] > 0 then
					triggerClientEvent(playersInMine[r0_54], "syncMineFurnaceRunning", client, r0_54, false, false)
				end
				if r4_54 == r1_54 then
					exports.sChat:localAction(client, "kikapcsolja " .. r2_54.ingotNamePrefix .. " " .. r2_54.ingotName:gsub("%L", string.lower) .. "kohót.")
				end
			end
			if r1_54 ~= r4_54 then
				local r5_54 = r3_54.furnaceLastRefresh[r1_54]
				if r5_54 then
					r5_54 = getTickCount() - r3_54.furnaceLastRefresh[r1_54]
				else
					r5_54 = 0
				end
				r3_54.furnaceRunning = r1_54
				r3_54.furnaceTemperature[r1_54] = math.max(0, r3_54.furnaceTemperature[r1_54] - r5_54 / r2_54.furnaceSpeed * 10)
				r3_54.furnaceLastRefresh[r1_54] = getTickCount()
				if #playersInMine[r0_54] > 0 then
					triggerClientEvent(playersInMine[r0_54], "syncMineFurnaceRunning", client, r0_54, r1_54, r3_54.furnaceTemperature[r1_54])
				end
				exports.sChat:localAction(client, "bekapcsolja " .. r2_54.ingotNamePrefix .. " " .. r2_54.ingotName:gsub("%L", string.lower) .. "kohót.")
			end
			setPedAnimation(client, "CASINO", "SLOT_PLYR", -1, false, true, false, false)
		end
	end
end)
addMineEventHandler("putDownMineOreBox", root, function(r0_55)
	-- line: [1729, 1752] id: 55
	local r1_55 = playerCarryingOreBox[client]
	if r1_55 then
		playerCarryingOreBox[client] = nil
		setPedAnimation(client, "CARRY", "PUTDWN", -1, false, false, false, false)
		setTimer(function(r0_56)
			-- line: [1737, 1747] id: 56
			if isElement(r0_56) then
				exports.sControls:toggleControl(r0_56, {
					"fire",
					"crouch",
					"aim_weapon",
					"jump",
					"jog"
				}, true, "mineOreCarry")
				if #playersInMine[r0_55] > 0 then
					triggerClientEvent(playersInMine[r0_55], "syncMineOreBoxCarry", r0_56, r0_55, false)
				end
				exports.sChat:localAction(r0_56, "berakott egy ládát a válogatógépbe.")
			end
		end, 375, 1, client)
		mineOreBoxCarrying[r0_55][r1_55] = nil
	end
end)
addMineEventHandler("pickUpMineOreBox", root, function(r0_57, r1_57)
	-- line: [1756, 1783] id: 57
	if not checkMinePermission(client, permissionFlags.USE_FOUNDRY) then
		exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
	elseif r4_0[client] or playerCarryingOreBox[client] then
		return 
	elseif isElement(mineOreBoxCarrying[r0_57][r1_57]) then
		return 
	else
		playerCarryingOreBox[client] = r1_57
		setPedAnimation(client, "CARRY", "LIFTUP", -1, false, false, false, false)
		setTimer(function(r0_58)
			-- line: [1768, 1778] id: 58
			if isElement(r0_58) then
				exports.sControls:toggleControl(r0_58, {
					"fire",
					"crouch",
					"aim_weapon",
					"jump",
					"jog"
				}, false, "mineOreCarry")
				if #playersInMine[r0_57] > 0 then
					triggerClientEvent(playersInMine[r0_57], "syncMineOreBoxCarry", r0_58, r0_57, r1_57)
				end
				exports.sChat:localAction(r0_58, "kivett egy ládát a válogatógépből.")
			end
		end, 625, 1, client)
		mineOreBoxCarrying[r0_57][r1_57] = client
	end
end)
addEvent("syncBagWield", true)
addEventHandler("syncBagWield", root, function(r0_59)
	-- line: [1790, 1806] id: 59
	if r0_59 then
		r0_59 = true
	else
		r0_59 = nil
	end
	if client then
		r3_0[client] = r0_59
		if r0_59 then
			exports.sChat:localAction(client, "elővett egy zsákot.")
		else
			exports.sChat:localAction(client, "elrakott egy zsákot.")
		end
		if #loadedPlayers > 0 then
			triggerClientEvent(loadedPlayers, "syncBagWield", client, r0_59)
		end
	end
end)
addMineEventHandler("sackMineOre", root, function(r0_60, r1_60)
	-- line: [1812, 1847] id: 60
	local r2_60 = oreTypes[r1_60]
	if not checkMinePermission(client, permissionFlags.COLLECT_PRODUCT) then
		exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
	elseif mineSorterRunning[r0_60] then
		exports.sGui:showInfobox(client, "e", "Előbb kapcsold ki a válogatógépet!")
	elseif r2_60 and not r2_60.instantItem and not r2_60.meltingPoint then
		local r3_60 = mineBufferContent[r0_60][r1_60] or 0
		local itemData = exports.sItems:findPrimaryItem(client)
		
		if r3_60 < sackOreProportion then
			exports.sGui:showInfobox(client, "e", "Nincs elég mennyiség a zsákoláshoz!")
			--elseif not itemData then
				--exports.sGui:showInfobox(client, "e", "Nincs elég hely az inventorydban!")
			elseif not exports.sItems:hasSpaceForItem(client, r2_60.itemId, 1) then
				exports.sGui:showInfobox(client, "e", "Nincs elég hely az inventorydban!")
			elseif not itemData or itemData.itemId ~= 593 then
				exports.sGui:showInfobox(client, "e", "Nincs nálad zsák!")
			elseif not exports.sItems:giveItem(client, r2_60.itemId, 1) then
				exports.sGui:showInfobox(client, "e", "Nincs szabad hely az inventorydban!")
			else
				exports.sItems:takeItem(client, "dbID", itemData.dbID, 1)
				exports.sItems:unuseItem(client)
				mineBufferContent[r0_60][r1_60] = math.max(0, r3_60 - sackOreProportion)
				if mineBufferContent[r0_60][r1_60] <= 0 then
					mineBufferContent[r0_60][r1_60] = nil
				end
				if #playersInMine[r0_60] > 0 then
					triggerClientEvent(playersInMine[r0_60], "syncMineOreItemOutput", client, r0_60, r1_60)
					triggerClientEvent(playersInMine[r0_60], "syncMineOreStorageRemove", client, r0_60, r1_60, sackOreProportion, false)
					triggerClientEvent(playersInMine[r0_60], "syncBagWield", client, false)
				end
				exports.sChat:localAction(client, "kivett egy zsák " .. r2_60.actionName .. " a ládából.")
			end
		end
	end)
	addMineEventHandler("emptyMineCart", root, function(r0_61, r1_61)
		-- line: [1851, 1940] id: 61
		if not checkMinePermission(client, permissionFlags.USE_SORTER_MACHINE) then
			exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
		elseif not mineSorterRunning[r0_61] then
			exports.sGui:showInfobox(client, "e", "Előbb kapcsold be a válogatógépet!")
		elseif next(mineCartEmptying[r0_61]) then
			return 
		elseif r27_0[r0_61][r1_61] then
			local r2_61 = {}
			for r6_61, r7_61 in pairs(mineFixOres[r0_61]) do
				local r8_61 = r7_61[4]
				if r8_61 == "cart" then
					r8_61 = r7_61[5] == r1_61
				else
					-- goto label_52	-- block#10 is visited secondly
				end
				if r8_61 then
					local r9_61 = r7_61[3]
					local r10_61 = (4 + math.random() * 5) / 100
					table.insert(r2_61, {
						r6_61,
						r10_61,
						r7_61[6]
					})
					if not mineBufferContent[r0_61][r9_61] then
						mineBufferContent[r0_61][r9_61] = r10_61
					else
						mineBufferContent[r0_61][r9_61] = mineBufferContent[r0_61][r9_61] + r10_61
					end
					mineFixOres[r0_61][r6_61] = nil
					for r14_61 = #fixOres[r0_61], 1, -1 do
						if fixOres[r0_61][r14_61][1] == r6_61 then
							table.remove(fixOres[r0_61], r14_61)
							break
						end
					end
				end
			end
			if #fixOres[r0_61] == 0 then
				fixOres[r0_61] = nil
				if not next(fixOres) then
					if isTimer(r46_0) then
						killTimer(r46_0)
					end
					r46_0 = nil
				end
			end
			r27_0[r0_61][r1_61] = nil
			if #r2_61 > 0 then
				table.sort(r2_61, function(r0_62, r1_62)
					-- line: [1901, 1903] id: 62
					return r1_62[3] < r0_62[3]
				end)
				mineCartEmptying[r0_61][r1_61] = client
				if #playersInMine[r0_61] > 0 then
					triggerClientEvent(playersInMine[r0_61], "syncOreEmptying", resourceRoot, r0_61, r1_61, client)
				end
				setTimer(function()
					-- line: [1912, 1934] id: 63
					setTimer(function()
						-- line: [1914, 1932] id: 64
						local r0_64, r1_64 = unpack(table.remove(r2_61, 1))
						if #playersInMine[r0_61] > 0 then
							triggerClientEvent(playersInMine[r0_61], "syncFixOreState", resourceRoot, r0_61, r0_64, "conveyor", nil, nil, nil, nil, r1_64)
						end
						if #r2_61 == 0 then
							setTimer(function()
								-- line: [1923, 1929] id: 65
								mineCartEmptying[r0_61][r1_61] = nil
								if #playersInMine[r0_61] > 0 then
									triggerClientEvent(playersInMine[r0_61], "syncOreEmptying", resourceRoot, r0_61, r1_61, nil)
								end
							end, 500, 1)
						end
					end, 250, #r2_61)
				end, 1000, 1)
				exports.sChat:localAction(client, "kiöntött egy vagon követ.")
			end
			-- close: r2_61
		end
	end)
	addMineEventHandler("toggleMineSortingMachine", root, function(r0_66)
		-- line: [1944, 1967] id: 66
		if not checkMinePermission(client, permissionFlags.USE_SORTER_MACHINE) then
			exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
		elseif next(mineCartEmptying[r0_66]) then
			exports.sGui:showInfobox(client, "e", "A válogatógép jelenleg nem kapcsolható ki!")
		elseif next(mineOreBoxCarrying[r0_66]) then
			exports.sGui:showInfobox(client, "e", "A válogatógép nem kapcsolható be, amíg nincs minden láda a helyén!")
		else
			mineSorterRunning[r0_66] = not mineSorterRunning[r0_66]
			if mineSorterRunning[r0_66] then
				exports.sChat:localAction(client, "bekapcsolja a válogatógépet.")
			else
				exports.sChat:localAction(client, "kikapcsolja a válogatógépet.")
			end
			setPedHeadingTo(client, minePosX - 14.7006, minePosY + 6.7456)
			setPedAnimation(client, "CASINO", "SLOT_PLYR", -1, false, true, false, false)
			if #playersInMine[r0_66] > 0 then
				triggerClientEvent(playersInMine[r0_66], "syncMineSortingMachineState", client, r0_66, mineSorterRunning[r0_66])
			end
		end
	end)
	addMineEventHandler("giveInstantOre", root, function(r0_67)
		-- line: [1971, 2023] id: 67
		local r1_67 = r4_0[client]
		if r1_67 then
			local r2_67 = mineFixOres[r0_67][r1_67]
			if r2_67 then
				local r3_67 = r2_67[3]
				if oreTypes[r3_67] then
					local r4_67 = oreTypes[r3_67]
					if r4_67.instantItem then
						if exports.sItems:giveItem(client, r4_67.itemId, 1) then
							exports.sControls:toggleControl(client, {
								"fire",
								"crouch",
								"aim_weapon",
								"jump",
								"jog"
							}, true, "mineOreCarry")
							for r9_67 = #fixOres[r0_67], 1, -1 do
								if fixOres[r0_67][r9_67][1] == r1_67 then
									table.remove(fixOres[r0_67], r9_67)
									break
								end
							end
							exports.sGui:showInfobox(client, "i", "A tárgy átkerült az inventorydba.")
							if #fixOres[r0_67] == 0 then
								fixOres[r0_67] = nil
								if not next(fixOres) then
									if isTimer(r46_0) then
										killTimer(r46_0)
									end
									r46_0 = nil
								end
							end
							mineFixOres[r0_67][r1_67] = nil
							if #playersInMine[r0_67] > 0 then
								triggerClientEvent(playersInMine[r0_67], "syncFixOreState", client, r0_67, r1_67, "delete")
							end
							r4_0[client] = nil
						else
							exports.sGui:showInfobox(client, "e", "Nincs elég hely az inventorydban!")
						end
					end
				end
			end
		end
	end)
	addMineEventHandler("putOreInMineCart", root, function(r0_68, r1_68)
		-- line: [2027, 2076] id: 68
		local r2_68 = r4_0[client]
		if r2_68 then
			local r3_68 = mineFixOres[r0_68][r2_68]
			if r3_68 then
				local r4_68 = mineInventoryData[r0_68]
				if r4_68 then
					local r5_68 = nil	-- notice: implicit variable refs by block#[10]
					if r1_68 >= 1 then
						r5_68 = r4_68.subCartNum
						local r6_68 = r4_68.dieselLoco
						if r6_68 then
							r6_68 = 0 or 1
						else
							r6_68 = 1
						end
						r5_68 = r1_68 <= r5_68 + r6_68
					else
						-- goto label_27	-- block#8 is visited secondly
					end
					if r5_68 then
						if not r27_0[r0_68] then
							r27_0[r0_68] = {}
						end
						if not r27_0[r0_68][r1_68] then
							r27_0[r0_68][r1_68] = 1
						elseif r27_0[r0_68][r1_68] < #oreCartOffsets then
							r27_0[r0_68][r1_68] = r27_0[r0_68][r1_68] + 1
						else
							return exports.sGui:showInfobox(client, "e", "Ebbe a kocsiba nem fér több!")
						end
						r3_68[4] = "cart"
						r3_68[5] = r1_68
						r3_68[6] = r27_0[r0_68][r1_68]
						r4_0[client] = nil
						setPedAnimation(client, "CARRY", "PUTDWN", -1, false, false, false, false)
						setTimer(function(r0_69)
							-- line: [2060, 2064] id: 69
							if isElement(r0_69) then
								exports.sControls:toggleControl(r0_69, {
									"fire",
									"crouch",
									"aim_weapon",
									"jump",
									"jog"
								}, true, "mineOreCarry")
							end
						end, 375, 1, client)
						if #playersInMine[r0_68] > 0 then
							triggerClientEvent(playersInMine[r0_68], "syncFixOreState", client, r0_68, r2_68, "cart", nil, nil, r3_68[5], r3_68[6])
						end
						exports.sChat:localAction(client, "berakott egy követ a kocsiba.")
					end
				end
			end
		end
	end)
	addMineEventHandler("putDownMineFixOre", root, function(r0_70)
		-- line: [2080, 2118] id: 70
		local r1_70 = r4_0[client]
		if r1_70 then
			local r2_70 = mineFixOres[r0_70][r1_70]
			if r2_70 then
				local r3_70, r4_70, r5_70 = getElementPosition(client)
				local r6_70, r7_70, r8_70 = getElementRotation(client)
				local r9_70 = math.rad(r8_70)
				local r10_70 = math.cos(r9_70)
				r2_70[1] = r3_70 - math.sin(r9_70) * 0.45
				r2_70[2] = r4_70 + r10_70 * 0.45
				r2_70[4] = nil
				r2_70[5] = nil
				r2_70[6] = nil
				r4_0[client] = nil
				setPedAnimation(client, "CARRY", "PUTDWN", -1, false, false, false, false)
				setTimer(function(r0_71)
					-- line: [2104, 2114] id: 71
					if isElement(r0_71) then
						exports.sControls:toggleControl(r0_71, {
							"fire",
							"crouch",
							"aim_weapon",
							"jump",
							"jog"
						}, true, "mineOreCarry")
						if #playersInMine[r0_70] > 0 then
							triggerClientEvent(playersInMine[r0_70], "syncFixOreState", r0_71, r0_70, r1_70, "ground", r2_70[1], r2_70[2])
						end
						exports.sChat:localAction(r0_71, "lerakott egy követ a földre.")
					end
				end, 375, 1, client)
			end
			-- close: r2_70
		end
	end)
	addMineEventHandler("pickUpMineFixOre", root, function(r0_72, r1_72)
		-- line: [2122, 2179] id: 72
		if checkMinePermission(client, permissionFlags.PICK_ORES) then
			local r3_72 = mineFixOres[r0_72][r1_72]
			if r3_72 and not r4_0[client] and not playerCarryingOreBox[client] then
				local r4_72 = r3_72[4]
				if not r4_72 or r4_72 == "cart" then
					r4_0[client] = r1_72
					if r4_72 == "cart" then
						local r5_72 = r3_72[5]
						if r27_0[r0_72] and r27_0[r0_72][r5_72] then
							r27_0[r0_72][r5_72] = r27_0[r0_72][r5_72] - 1
							if r27_0[r0_72][r5_72] <= 0 then
								r27_0[r0_72][r5_72] = nil
							end
						end
					end
					r3_72[4] = "player"
					r3_72[5] = client
					r3_72[6] = nil
					setPedAnimation(client, "CARRY", "LIFTUP", -1, false, false, false, false)
					setTimer(function(r0_73)
						-- line: [2155, 2171] id: 73
						if isElement(r0_73) then
							setPedAnimation(r0_73, "CARRY", "CRRY_PRTIAL", 0, true, true, false, true)
							if #playersInMine[r0_72] > 0 then
								triggerClientEvent(playersInMine[r0_72], "syncFixOreState", r0_73, r0_72, r1_72, "player")
							end
							if r4_72 == "cart" then
								exports.sChat:localAction(r0_73, "kivett egy követ a kocsiból.")
							else
								exports.sChat:localAction(r0_73, "felvett egy követ a földről.")
							end
							exports.sControls:toggleControl(r0_73, {
								"fire",
								"crouch",
								"aim_weapon",
								"jump",
								"jog"
							}, false, "mineOreCarry")
						end
					end, 625, 1, client)
				end
				-- close: r4_72
			end
		else
			exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
		end
	end)
	addMineEventHandler("exitMineLoco", root, function(r0_74)
		-- line: [2185, 2199] id: 74
		local r1_74 = mineTrainPassengers[r0_74][client]
		if r1_74 then
			mineTrainPassengers[r0_74][client] = nil
			if #playersInMine[r0_74] > 0 then
				triggerClientEvent(playersInMine[r0_74], "syncMineLocoPassenger", resourceRoot, r0_74, r1_74)
			end
			if getElementHealth(client) > 0 then
				exports.sChat:localAction(client, "leszállt a mozdonyról.")
			end
		end
	end)
	addMineEventHandler("standMineLocoPassenger", root, function(r0_75, r1_75)
		-- line: [2203, 2219] id: 75
		for r5_75, r6_75 in pairs(mineTrainPassengers[r0_75]) do
			if r1_75 == r6_75 then
				return 
			end
		end
		if not mineTrainPassengers[r0_75][client] then
			mineTrainPassengers[r0_75][client] = r1_75
			if #playersInMine[r0_75] > 0 then
				triggerClientEvent(playersInMine[r0_75], "syncMineLocoPassenger", client, r0_75, r1_75)
			end
			exports.sChat:localAction(client, "felkapaszkodott a mozdonyra.")
		end
	end)
	addMineEventHandler("mineRailHorn", root, function(r0_76)
		-- line: [2223, 2237] id: 76
		local r1_76 = {}
		for r5_76 = 1, #playersInMine[r0_76], 1 do
			local r6_76 = playersInMine[r0_76][r5_76]
			if r6_76 ~= client then
				table.insert(r1_76, r6_76)
			end
		end
		if #r1_76 > 0 then
			triggerClientEvent(r1_76, "mineRailHorn", client, r0_76)
		end
	end)
	
	
	addMineEventHandler("mineRailSyncing", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_)
		if mineTrainData[_ARG_0_] and checkMinePermission(client, permissionFlags.USE_RAILCAR) then
			if not _ARG_7_ then
				mineTrainData[_ARG_0_].currentSyncer = client
			else
				mineTrainData[_ARG_0_].currentSyncer = false
			end
			mineTrainData[_ARG_0_].desiredSpeed = _ARG_1_ or mineTrainData[_ARG_0_].desiredSpeed or 0
			mineTrainData[_ARG_0_].currentSpeed = _ARG_2_ or mineTrainData[_ARG_0_].currentSpeed or 0
			mineTrainData[_ARG_0_].trackPosition = _ARG_3_ or mineTrainData[_ARG_0_].trackPosition
			mineTrainData[_ARG_0_].trackDirection = _ARG_4_ or mineTrainData[_ARG_0_].trackDirection
			mineTrainData[_ARG_0_].trackId = _ARG_5_ or mineTrainData[_ARG_0_].trackId
			mineTrainData[_ARG_0_].routeId = _ARG_6_ or mineTrainData[_ARG_0_].routeId
			if mineInventoryData[_ARG_0_].dieselLoco then
				if mineTrainData[_ARG_0_].lastFuelUpdate then
					mineTrainData[_ARG_0_].totalDistance, mineTrainData[_ARG_0_].fuelLevel = mineTrainData[_ARG_0_].totalDistance + math.abs(mineTrainData[_ARG_0_].currentSpeed) * (getTickCount() - mineTrainData[_ARG_0_].lastFuelUpdate) / 1000, math.max(0, mineTrainData[_ARG_0_].fuelLevel - math.random(2, 7) * ((mineTrainData[_ARG_0_].totalDistance + math.abs(mineTrainData[_ARG_0_].currentSpeed) * (getTickCount() - mineTrainData[_ARG_0_].lastFuelUpdate) / 1000 - mineTrainData[_ARG_0_].totalDistance) / 1000) * (1 + mineInventoryData[_ARG_0_].subCartNum))
					mineTrainData[_ARG_0_].lastFuelUpdate = getTickCount()
				else
					mineTrainData[_ARG_0_].totalDistance = 0
					mineTrainData[_ARG_0_].lastFuelUpdate = getTickCount()
				end
			end
			if 0 < #playersInMine[_ARG_0_] then
				triggerClientEvent(playersInMine[_ARG_0_], "mineRailSyncing", client, _ARG_0_, mineTrainData[_ARG_0_])
			end
			if mineInventoryData[_ARG_0_].dieselLoco then
				if mineTrainData[_ARG_0_].currentSyncer == client then
					if mineTrainData[_ARG_0_].currentSyncer ~= mineTrainData[_ARG_0_].currentSyncer then
						exports.sChat:localAction(client, "beszállt a mozdonyba.")
					end
				elseif mineTrainData[_ARG_0_].currentSyncer == client and 0 < getElementHealth(client) then
					exports.sChat:localAction(client, "kiszállt a mozdonyból.")
				end
			end
		end
	end)
	
	
	addMineEventHandler("setMineRailSwitch", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
		if mineRailSwitchesAt[_ARG_0_][_ARG_1_] then
			if checkMinePermission(client, permissionFlags.USE_SWITCHES) then
				iprint(mineRailSwitchStates[_ARG_0_][_ARG_1_], _ARG_2_)
				if mineRailSwitchStates[_ARG_0_][_ARG_1_] ~= _ARG_2_ then
					mineRailSwitchStates[_ARG_0_][_ARG_1_] = _ARG_2_
					if #playersInMine[_ARG_0_] > 0 then
						triggerClientEvent(playersInMine[_ARG_0_], "setMineRailSwitch", client, _ARG_0_, _ARG_1_, _ARG_2_)
					end
					exports.sChat:localAction(client, "átállította a váltót.")
				end
			else
				exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
			end
		end
	end)
	
	addMineEventHandler("createNewMineRailTrack", root,
	function (mineId, spotX, spotY)
		local railTracks = mineRails[mineId]
		
		if railTracks then
			local constructPermission = checkMinePermission(client, permissionFlags.CONSTRUCT_RAIL)
			
			if constructPermission then
				local constructionPossible = canConstructRail(mineRailsAt[mineId], mineRailSwitchesAt[mineId], spotX, spotY) and checkValidSpotEx(mineId, spotX, spotY)
				
				if constructionPossible then
					local constructionList = doConstructRail(mineId, mineRailsAt[mineId], mineRailSwitchesAt[mineId], spotX, spotY, mineJunctionsAt[mineId][spotX] and mineJunctionsAt[mineId][spotX][spotY])
					
					if #constructionList > 0 then
						local inventoryData = mineInventoryData[mineId]
						local constructionCost = findRailConstructionCost(constructionList)
						
						if constructionCost * railIronCost > inventoryData.railIrons or constructionCost * railWoodCost > inventoryData.railWoods then
							return exports.sGui:showInfobox(client, "e", "Nincs elég anyag az építéshez!")
						end
						
						inventoryData.railIrons = math.max(0, inventoryData.railIrons - constructionCost * railIronCost)
						inventoryData.railWoods = math.max(0, inventoryData.railWoods - constructionCost * railWoodCost)
						
						local constructionSpots = {}
						local constructionIterator = 1
						
						while constructionIterator <= #constructionList do
							local constructionData = constructionList[constructionIterator]
							
							if constructionData[1] == "extend" then
								local trackId = constructionData[2]
								local trackData = railTracks[trackId]
								
								if trackData then
									local trackRad = findRailAngle(mineId, trackId)
									local trackCos = pcos(trackRad)
									local trackSin = psin(trackRad)
									
									trackData[3] = spotX
									trackData[4] = spotY
									trackData[5] = not constructionData[3]
									
									if not mineRailsAt[mineId][spotX] then
										mineRailsAt[mineId][spotX] = {}
									end
									
									mineRailsAt[mineId][spotX][spotY] = trackId
									
									if not constructionSpots[spotX] then
										constructionSpots[spotX] = {}
									end
									
									constructionSpots[spotX][spotY] = true
								end
							elseif constructionData[1] == "single" then
								local trackX = constructionData[2]
								local trackY = constructionData[3]
								
								local trackId = findFreeRailTrack(mineId)
								local trackData = {trackX, trackY, constructionData[4] % 360, constructionData[5]}
								
								railTracks[trackId] = trackData
								constructionData[6] = trackId
								
								if not mineRailsAt[mineId][trackX] then
									mineRailsAt[mineId][trackX] = {}
								end
								
								mineRailsAt[mineId][trackX][trackY] = trackId
								
								if not constructionSpots[trackX] then
									constructionSpots[trackX] = {}
								end
								
								constructionSpots[trackX][trackY] = true
							elseif constructionData[1] == "linked" then
								local trackId = findFreeRailTrack(mineId)
								local trackData = {constructionData[2], constructionData[3], constructionData[4], constructionData[5], constructionData[6]}
								
								railTracks[trackId] = trackData
								constructionData[7] = trackId
								
								for trackX = trackData[1], trackData[3], (trackData[3] < trackData[1] and -1 or 1) do
									if not mineRailsAt[mineId][trackX] then
										mineRailsAt[mineId][trackX] = {}
									end
									
									if not constructionSpots[trackX] then
										constructionSpots[trackX] = {}
									end
									
									for trackY = trackData[2], trackData[4], (trackData[4] < trackData[2] and -1 or 1) do
										if not constructionSpots[trackX][trackY] then
											constructionSpots[trackX][trackY] = true
										end
										
										mineRailsAt[mineId][trackX][trackY] = trackId
									end
								end
							elseif constructionData[1] == "split" then
								local trackId = constructionData[2]
								local trackData = railTracks[trackId]
								
								if trackData then
									local splitX = constructionData[3]
									local splitY = constructionData[4]
									
									local trackRad = findRailAngle(mineId, trackId)
									local trackDeg = math.deg(trackRad) % 360
									
									local trackCos = pcos(trackRad)
									local trackSin = psin(trackRad)
									
									if #trackData > 4 then
										local trackLength = getDistanceBetweenPoints2D(splitX, splitY, trackData[3], trackData[4])
										
										if trackLength > 1 then
											local switchX = trackData[3] + trackCos
											local switchY = trackData[4] + trackSin
											
											table.insert(constructionList, constructionIterator + 1, {"linked", splitX + trackCos, splitY + trackSin, trackData[3], trackData[4], trackData[5]})
											
											if mineRailSwitchesAt[mineId][switchX] then
												local switchId = mineRailSwitchesAt[mineId][switchX][switchY]
												
												if switchId then
													table.insert(constructionList, {"extend-switch", switchId})
												end
											end
										elseif trackLength > 0 then
											local trackX = splitX + trackCos
											local trackY = splitY + trackSin
											
											table.insert(constructionList, constructionIterator + 1, {"single", trackX, trackY, trackDeg, trackData[5]})
											
											local switchX = trackX + trackCos
											local switchY = trackY + trackSin
											
											if mineRailSwitchesAt[mineId][switchX] then
												local switchId = mineRailSwitchesAt[mineId][switchX][switchY]
												
												if switchId then
													table.insert(constructionList, {"extend-switch", switchId})
												end
											end
										end
										
										trackData[3] = splitX - trackCos
										trackData[4] = splitY - trackSin
										trackData[5] = false
										
										if trackData[1] == trackData[3] and trackData[2] == trackData[4] then
											trackData[3] = trackDeg
											trackData[4] = false
											trackData[5] = nil
										end
									end
									
									if mineRailsAt[mineId][splitX] then
										mineRailsAt[mineId][splitX][splitY] = nil
									end
									
									if constructionSpots[splitX] then
										constructionSpots[splitX][splitY] = nil
									end
								end
							elseif constructionData[1] == "switch" then
								local trackX = constructionData[2]
								local trackY = constructionData[3]
								
								local trackIds = processSwitch(mineId, trackX, trackY, constructionSpots)
								
								local switchId = findFreeRailSwitch(mineId)
								local switchData = {trackX, trackY, unpack(trackIds)}
								
								constructionData[4] = trackIds
								constructionData[5] = switchId
								
								mineRailSwitches[mineId][switchId] = switchData
								
								if #trackIds > 2 then
									mineRailSwitchStates[mineId][switchId] = 1
								end
								
								if not mineRailSwitchesAt[mineId][trackX] then
									mineRailSwitchesAt[mineId][trackX] = {}
								end
								
								mineRailSwitchesAt[mineId][trackX][trackY] = switchId
								
								if mineRailsAt[mineId][trackX] then
									mineRailsAt[mineId][trackX][trackY] = nil
								end
							elseif constructionData[1] == "extend-switch" then
								local switchId = constructionData[2]
								local switchData = mineRailSwitches[mineId][switchId]
								
								if switchData then
									local trackIds = processSwitch(mineId, switchData[1], switchData[2], constructionSpots)
									
									for i = #switchData, 3, -1 do
										table.remove(switchData, i)
									end
									
									for i = 1, #trackIds do
										table.insert(switchData, trackIds[i])
									end
									
									constructionData[3] = trackIds
								end
							elseif constructionData[1] == "merge" then
								local targetTrackId = constructionData[2]
								local sourceTrackId = constructionData[3]
								
								local targetTrack = railTracks[targetTrackId]
								local sourceTrack = railTracks[sourceTrackId]
								
								local targetX = targetTrack[1]
								local targetY = targetTrack[2]
								
								local sourceX = sourceTrack[1]
								local sourceY = sourceTrack[2]
								
								constructionData[4] = sourceX
								constructionData[5] = sourceY
								
								for spotX = targetX, sourceX, (sourceX < targetX and -1 or 1) do
									if not mineRailsAt[mineId][spotX] then
										mineRailsAt[mineId][spotX] = {}
									end
									
									for spotY = targetY, sourceY, (sourceY < targetY and -1 or 1) do
										mineRailsAt[mineId][spotX][spotY] = targetTrackId
									end
								end
								
								for switchId, switchData in pairs(mineRailSwitches[mineId]) do
									local switchFound = false
									
									for i = 3, #switchData do
										if switchData[i] == sourceTrackId then
											switchData[i] = targetTrackId
											switchFound = true
											break
										end
									end
									
									if switchFound then
										break
									end
								end
								
								targetTrack[3] = sourceX
								targetTrack[4] = sourceY
								targetTrack[5] = false
								
								railTracks[sourceTrackId] = nil
							elseif constructionData[1] == "openup" then
								local trackId = constructionData[2]
								local trackData = railTracks[trackId]
								
								if trackData then
									if #trackData == 4 then
										trackData[4] = false
									else
										trackData[5] = false
									end
								end
							end
							
							constructionIterator = constructionIterator + 1
						end
						
						if #playersInMine[mineId] > 0 then
							triggerClientEvent(playersInMine[mineId], "executeMineRailConstruction", client, mineId, constructionList, spotX, spotY, inventoryData.railIrons, inventoryData.railWoods)
						end
						
						exports.sChat:localAction(client, "épített egy sínt.")
					end
				end
			else
				exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
			end
		end
	end
)

function isPlayerInMine(r0_80)
	-- line: [2618, 2620] id: 80
	return playersCurrentMine[r0_80] ~= nil
end
function getPlayerMine(r0_81)
	-- line: [2622, 2624] id: 81
	return playersCurrentMine[r0_81]
end
function setPlayerMine(r0_82, r1_82, r2_82)
	-- line: [2626, 2838] id: 82
	local r3_82 = playersCurrentMine[r0_82]
	if r3_82 ~= r1_82 then
		local r4_82 = false
		if r3_82 then
			local r5_82 = loadedMinesData[r3_82]
			if r5_82 then
				local r6_82, r7_82, r8_82 = getLobbyFromMineId(r3_82)
				local r9_82, r10_82, r11_82, r12_82, r13_82, r14_82 = unpack(mineCoords[r8_82])
				local r15_82 = getCorridorIdFromLobbyCorridor(r6_82, r7_82)
				resetPlayerFixOre(r0_82)
				resetPlayerOreBox(r0_82)
				resetPlayerJerrycan(r0_82)
				setPlayerLobby(r0_82, r15_82, r2_82)
				setElementPosition(r0_82, r9_82 - r12_82 * 2, r10_82 - r13_82 * 2, r11_82 + 1)
				setElementRotation(r0_82, 0, 0, r14_82 + 270, "default", true)
				if not r2_82 then
					triggerClientEvent(r0_82, "exitMine", r0_82, r3_82)
					if eventName == "tryToExitMine" and 0 < #playersInLobby[r15_82] then
						triggerClientEvent(playersInLobby[r15_82], "gotMineDoorSound", r0_82, r3_82, math.random(1, 4))
					end
				end
				local r16_82 = getElementData(r0_82, "char.ID")
				for r20_82 = #r5_82.workersInside, 1, -1 do
					if r5_82.workersInside[r20_82] == r16_82 then
						table.remove(r5_82.workersInside, r20_82)
						if #playersInLobby[r15_82] > 0 then
							triggerClientEvent(playersInLobby[r15_82], "gotMineRentData", r0_82, r3_82, "workersInside", r5_82.workersInside)
							break
						else
							break
						end
					end
				end
				playersCurrentMine[r0_82] = nil
				for r20_82 = #playersInMine[r3_82], 1, -1 do
					if playersInMine[r3_82][r20_82] == r0_82 then
						table.remove(playersInMine[r3_82], r20_82)
						break
					end
				end
				if #playersInMine[r3_82] > 0 then
					triggerClientEvent(playersInMine[r3_82], "otherPlayerExitedMine", r0_82, r3_82, r16_82)
				else
					serializeMine(r3_82)
				end
				r4_82 = true
			end
		end
		if r1_82 then
			local r5_82 = loadedMinesData[r1_82]
			if r5_82 then
				local r6_82 = getElementData(r0_82, "char.ID")
				if not playersCurrentMine[r0_82] then
					playersCurrentMine[r0_82] = r1_82
					if not playersInMine[r1_82] then
						playersInMine[r1_82] = {
							r0_82
						}
					else
						table.insert(playersInMine[r1_82], r0_82)
					end
					local r7_82 = {}
					for r11_82 = 1, #playersInMine[r1_82], 1 do
						local r12_82 = playersInMine[r1_82][r11_82]
						if r12_82 ~= r0_82 then
							table.insert(r7_82, r12_82)
						end
					end
					if eventName == "tryToEnterMine" and 0 < #playersInMine[r1_82] then
						triggerClientEvent(playersInMine[r1_82], "gotMineDoorSound", r0_82, r1_82, math.random(1, 4))
					end
					if isPedInVehicle(r0_82) then
						removePedFromVehicle(r0_82)
					end
					setPlayerLobby(r0_82, false)
					setElementInterior(r0_82, 0)
					setElementDimension(r0_82, r1_82)
					setElementPosition(r0_82, minePosX - 34.5877, minePosY + 0.045, minePosZ + 1)
					setElementRotation(r0_82, 0, 0, 270, "default", true)
					if r5_82.workerNames[r6_82] then
						local r8_82 = getElementData(r0_82, "visibleName")
						if r5_82.workerNames[r6_82] ~= r8_82 then
							r5_82.workerNames[r6_82] = r8_82
							if #r7_82 > 0 then
								triggerClientEvent(r7_82, "updateMineWorkerName", r0_82, r1_82, r6_82, r8_82:gsub("_", " "))
							end
						end
					end
					local r8_82 = {
						rentedBy = r5_82.rentedBy,
						mineName = r5_82.mineName,
						doorLocked = r5_82.isLocked,
						workerNames = r5_82.workerNames,
						workerPermissions = r5_82.workerPermissions,
						shaftList = mineShafts[r1_82],
						shaftDepths = mineShaftDepths[r1_82],
						shaftLengths = mineShaftLengths[r1_82],
						shaftOres = mineShaftOres[r1_82],
						junctionList = mineJunctions[r1_82],
						railTracks = mineRails[r1_82],
						railSwitches = mineRailSwitches[r1_82],
						railSwitchStates = mineRailSwitchStates[r1_82],
						inventoryData = mineInventoryData[r1_82],
						trainData = mineTrainData[r1_82],
						trainPassengers = mineTrainPassengers[r1_82],
						installedLights = mineLights[r1_82],
						fixOres = mineFixOres[r1_82],
						sorterRunning = mineSorterRunning[r1_82],
						cartEmptying = mineCartEmptying[r1_82],
						bufferContent = mineBufferContent[r1_82],
						foundryContent = mineFoundryContent[r1_82],
						oreBoxCarrying = mineOreBoxCarrying[r1_82],
						furnaceRunning = false,
						furnaceTemperature = {},
						orderData = mineOrders[r1_82],
						orderPaid = mineOrderPaid[r1_82],
					}
					local r9_82 = r34_0[r1_82]
					for r13_82, r14_82 in pairs(oreTypes) do
						if r14_82.meltingPoint then
							local r15_82 = r9_82.furnaceLastRefresh[r13_82]
							if r15_82 then
								r15_82 = getTickCount() - r9_82.furnaceLastRefresh[r13_82] or 0
							else
								r15_82 = 0
							end
							if r9_82.furnaceRunning == r13_82 then
								r9_82.furnaceTemperature[r13_82] = math.min(1000, r9_82.furnaceTemperature[r13_82] + r15_82 / r14_82.furnaceSpeed)
							else
								r9_82.furnaceTemperature[r13_82] = math.max(0, r9_82.furnaceTemperature[r13_82] - r15_82 / r14_82.furnaceSpeed * 10)
							end
							r9_82.furnaceLastRefresh[r13_82] = getTickCount()
						end
					end
					r8_82.furnaceRunning = r9_82.furnaceRunning
					for r13_82 in pairs(r9_82.furnaceTemperature) do
						local r14_82 = r8_82.furnaceTemperature
						r14_82[r13_82] = r9_82.furnaceTemperature[r13_82]
					end
					r8_82.meltingOre = r9_82.meltingOre
					if r9_82.meltingOre then
						r9_82.meltProgress = math.min(1, r9_82.meltProgress + (getTickCount() - r9_82.meltingStart) / meltingTime)
						r9_82.meltingStart = getTickCount()
					end
					r8_82.meltProgress = r9_82.meltProgress
					if r6_82 == r5_82.rentedBy or r5_82.workerPermissions[r6_82] then
						local r10_82 = getCorridorIdFromLobbyCorridor(getLobbyFromMineId(r1_82))
						for r14_82 = #r5_82.workersInside, 1, -1 do
							if r5_82.workersInside[r14_82] == r6_82 then
								table.remove(r5_82.workersInside, r14_82)
								break
							end
						end
						table.insert(r5_82.workersInside, r6_82)
						if #playersInLobby[r10_82] > 0 then
							triggerClientEvent(playersInLobby[r10_82], "gotMineRentData", r0_82, r1_82, "workersInside", r5_82.workersInside)
						end
					end
					if #r7_82 > 0 then
						triggerClientEvent(r7_82, "otherPlayerEnteredMine", r0_82, r1_82, r6_82)
					end
					r4_82 = triggerLatentClientEvent(r0_82, "enteredMine", r0_82, r1_82, r6_82, r8_82)
				end
			end
		end
		return r4_82
	end
	return false
end
addEvent("tryToEnterMine", true)
addEventHandler("tryToEnterMine", root, function(r0_83)
	if client then
		local r1_83 = loadedMinesData[r0_83]
		if r1_83 then
			local r2_83 = getCorridorIdFromLobbyCorridor(getLobbyFromMineId(r0_83))
			if r1_83.isLocked then
				triggerClientEvent(client, "mineEnterResponse", client, false, "Az ajtó zárva van!")
				if #playersInLobby[r2_83] > 0 then
					triggerClientEvent(playersInLobby[r2_83], "gotMineDoorSound", client, r0_83, 6)
				end
			elseif maxWorkersInside <= #playersInMine[r0_83] then
				triggerClientEvent(client, "mineEnterResponse", client, false, "Egyszerre csak " .. maxWorkersInside .. " ember lehet a munkaterületen!")
			else
				setPlayerMine(client, r0_83)
				if #playersInLobby[r2_83] > 0 then
					triggerClientEvent(playersInLobby[r2_83], "gotMineDoorSound", client, r0_83, math.random(1, 4))
				end
			end
		end
	end
end)
addEvent("tryToExitMine", true)
addEventHandler("tryToExitMine", root, function()
	-- line: [2873, 2897] id: 84
	if client then
		local r0_84 = playersCurrentMine[client]
		if r0_84 then
			local r1_84 = loadedMinesData[r0_84]
			if r1_84 then
				if r1_84.isLocked then
					triggerClientEvent(client, "mineExitResponse", client, false, "Az ajtó zárva van!")
					if #playersInMine[r0_84] > 0 then
						triggerClientEvent(playersInMine[r0_84], "gotMineDoorSound", client, r0_84, 6)
					end
				else
					setPlayerMine(client, false)
					if #playersInMine[r0_84] > 0 then
						triggerClientEvent(playersInMine[r0_84], "gotMineDoorSound", client, r0_84, math.random(1, 4))
					end
				end
			end
		end
	end
end)
addEvent("syncPickaxe", true)
addEventHandler("syncPickaxe", root, function(r0_85, pickaxeType)
	-- line: [2904, 2928] id: 85
	local r1_85 = type(r0_85) == "number"
	if client then
		if r1_85 then
			r2_0[client] = "default"
		else
			r2_0[client] = nil
		end
		if r1_85 then
			exports.sChat:localAction(client, "elővett egy csákányt.")
		else
			exports.sChat:localAction(client, "elrakott egy csákányt.")
		end
		if #loadedPlayers > 0 then
			triggerClientEvent(loadedPlayers, "syncPickaxe", client, r1_85, pickaxeType)
		end
	end
end)
addMineEventHandler("syncMineAim", root, function(r0_86, r1_86, r2_86)
	-- line: [2932, 2946] id: 86
	local r3_86 = {}
	for r7_86 = 1, #playersInMine[r0_86], 1 do
		local r8_86 = playersInMine[r0_86][r7_86]
		if r8_86 ~= client then
			table.insert(r3_86, r8_86)
		end
	end
	if #r3_86 > 0 then
		triggerClientEvent(r3_86, "syncMineAim", client, r0_86, r1_86, r2_86)
	end
end)
addMineEventHandler("syncMineHit", root, function(r0_87, r1_87)
	-- line: [2950, 2964] id: 87
	local r2_87 = {}
	for r6_87 = 1, #playersInMine[r0_87], 1 do
		local r7_87 = playersInMine[r0_87][r6_87]
		if r7_87 ~= client then
			table.insert(r2_87, r7_87)
		end
	end
	if #r2_87 > 0 then
		triggerClientEvent(r2_87, "syncMineHit", client, r0_87, r1_87)
	end
end)
addMineEventHandler("handleMineHit", root, function(r0_88, r1_88, r2_88, r3_88)
	-- line: [2970, 3000] id: 88
	local r4_88 = mineShaftDepths[r0_88][r1_88]
	if r4_88 then
		if not checkMinePermission(client, permissionFlags.MINING) then
			exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
		else
			local r5_88 = math.pow(wallMaximumDepth, 2) * math.max(0, math.min(1, r3_88)) / (math.random() + 2.5)
			if r5_88 > 0 then
				if r2_0[client] == "fortune" then
					r5_88 = r5_88 * 10
				end
				local r6_88 = r4_88[r2_88] + r5_88
				if r6_88 > wallMaximumDepth then
					local d = r6_88 - wallMaximumDepth
					r5_88 = r5_88 - d
				end
				iprint(r5_88)
				local r7_88 = doHandleMineHit(r0_88, r1_88, r2_88, r5_88)
				if type(r7_88) == "table" then
					triggerClientEvent(playersInMine[r0_88], "handleMineHit", client, r0_88, r1_88, r2_88, r5_88, r7_88, 0.5 < math.random())
				end
				setElementData(client, "mineDirtyFace", true, "broadcast", "deny")
			end
		end
	end
end)
addMineEventHandler("handleMineDetonate", root, function(r0_89, r1_89)
	-- line: [3004, 3076] id: 89
	if mineShafts[r0_89][r1_89] then
		local itemData = exports.sItems:hasItem(client, 720, 1)
		if not checkMinePermission(client, permissionFlags.USE_BOMB) then
			exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
		elseif r33_0[r0_89] then
			exports.sGui:showInfobox(client, "e", "Egyszerre maximum egy dinamit lehet meggyújtva a bányában!")
		elseif not itemData then
			exports.sGui:showInfobox(client, "e", "Nincs nálad meglévő járathoz való dinamit!")
		else
			setPedAnimation(client, "CASINO", "SLOT_PLYR", -1, false, true, false, false)
			if #playersInMine[r0_89] > 0 then
				triggerClientEvent(playersInMine[r0_89], "gotMineOpenShaftBomb", client, r0_89, r1_89)
			end
			exports.sItems:takeItem(client, "dbID", itemData.dbID, 1)
			r33_0[r0_89] = setTimer(function(r0_90, r0_89)
				-- line: [3020, 3070] id: 90
				local r1_90 = 3.5 + math.random() * 1
				if not isElement(r0_90) then
					r0_90 = resourceRoot
				end
				if #playersInMine[r0_89] > 0 then
					triggerClientEvent(playersInMine[r0_89], "detonateMineOpenShaftBomb", r0_90, r0_89, r1_89)
				end
				for r5_90 = 1, wallBlockCount, 1 do
					local r6_90 = -mineShaftDepths[r0_89][r1_89][r5_90]
					if r6_90 then
						doHandleMineHit(r0_89, r1_89, r5_90, r6_90, r0_90)
						if #playersInMine[r0_89] > 0 then
							triggerClientEvent(playersInMine[r0_89], "handleMineDetonate", r0_90, r0_89, r1_89, r5_90, r6_90, false)
						end
					end
				end
				if #playersInMine[r0_89] > 0 then
					triggerClientEvent(playersInMine[r0_89], "handleMineDetonate", r0_90, r0_89, r1_89)
				end
				for r5_90 = 1, wallBlockCount, 1 do
					local r6_90 = r1_90
					if r5_90 == math.ceil(wallBlockCount / 2) then
						r6_90 = r6_90 + wallMaximumDepth / 2
					end
					local r7_90 = doHandleMineHit(r0_89, r1_89, r5_90, r6_90, r0_90)
					if type(r7_90) == "table" then
						if #playersInMine[r0_89] > 0 then
							triggerClientEvent(playersInMine[r0_89], "handleMineDetonate", r0_90, r0_89, r1_89, r5_90, r6_90, r7_90)
						end
					else
						break
					end
				end
				if #playersInMine[r0_89] > 0 then
					triggerClientEvent(playersInMine[r0_89], "handleMineDetonate", r0_90, r0_89, r1_89)
				end
				r33_0[r0_89] = nil
			end, detonationTime, 1, client, r0_89)
			exports.sChat:localAction(client, "felszerelt egy dinamitot.")
		end
	end
end)
addMineEventHandler("createNewMineShaft", root, function(r0_91, r1_91, r2_91, r3_91)
	-- line: [3080, 3116] id: 91
	local r4_91 = nil	-- notice: implicit variable refs by block#[11, 12]
	if r3_91 then
		r4_91 = 1
	else
		r4_91 = 0
	end
	if mineShafts[r0_91][r1_91] then
		local itemData = exports.sItems:hasItem(client, 721, 1)
		if not checkMinePermission(client, permissionFlags.USE_BOMB) then
			exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
		elseif r33_0[r0_91] then
			exports.sGui:showInfobox(client, "e", "Egyszerre maximum egy dinamit lehet meggyújtva a bányában!")
		elseif not itemData then
			exports.sGui:showInfobox(client, "e", "Nincs nálad új járathoz való dinamit!")
		else
			setPedAnimation(client, "CASINO", "SLOT_PLYR", -1, false, true, false, false)
			if #playersInMine[r0_91] > 0 then
				triggerClientEvent(playersInMine[r0_91], "gotMineShaftBomb", client, r0_91, r1_91, r2_91, r4_91)
			end
			exports.sItems:takeItem(client, "dbID", itemData.dbID, 1)
			r33_0[r0_91] = setTimer(function(r0_92)
				-- line: [3098, 3110] id: 92
				r33_0[r0_91] = nil
				if not isElement(r0_92) then
					r0_92 = resourceRoot
				end
				if #playersInMine[r0_91] > 0 then
					triggerClientEvent(playersInMine[r0_91], "detonateMineShaftBomb", r0_92, r0_91, r1_91, r2_91, r4_91)
				end
				createOpenShaft(r0_91, r1_91, r2_91, r3_91)
			end, detonationTime, 1, client)
			exports.sChat:localAction(client, "felszerelt egy dinamitot.")
		end
	end
end)
addMineEventHandler("extendMineThreeJunction", root, function(r0_93, r1_93, r2_93)
	-- line: [3120, 3204] id: 93
	local r3_93 = mineJunctionsAt[r0_93][r1_93] and mineJunctionsAt[r0_93][r1_93][r2_93]
	if r3_93 then
		local r4_93 = mineJunctions[r0_93][r3_93]
		if r4_93 then
			local itemData = exports.sItems:hasItem(client, 721, 1)
			if not checkMinePermission(client, permissionFlags.USE_BOMB) then
				exports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
			elseif r33_0[r0_93] then
				exports.sGui:showInfobox(client, "e", "Egyszerre maximum egy dinamit lehet meggyújtva a bányában!")
			elseif not itemData then
				exports.sGui:showInfobox(client, "e", "Nincs nálad új járathoz való dinamit!")
			else
				setPedAnimation(client, "CASINO", "SLOT_PLYR", -1, false, true, false, false)
				if #playersInMine[r0_93] > 0 then
					triggerClientEvent(playersInMine[r0_93], "gotMineThreeJunctionBomb", client, r0_93, r1_93, r2_93)
				end
				exports.sItems:takeItem(client, "dbID", itemData.dbID, 1)
				r33_0[r0_93] = setTimer(function(r0_94)
					-- line: [3141, 3197] id: 94
					r33_0[r0_93] = nil
					if not isElement(r0_94) then
						r0_94 = resourceRoot
					end
					if #playersInMine[r0_93] > 0 then
						triggerClientEvent(playersInMine[r0_93], "detonateMineThreeJunctionBomb", r0_94, r0_93, r1_93, r2_93)
					end
					local r1_94 = r4_93[4]
					local r2_94 = prad(r1_94)
					local r3_94 = pcos(r2_94)
					local r4_94 = psin(r2_94)
					local r5_94 = r4_93[3]
					local r6_94 = false
					local r7_94 = false
					local r8_94 = r1_93 - r4_94
					local r9_94 = r2_93 + r3_94
					local r10_94 = mineOpenShaftsAt[r0_93][r8_94] and mineOpenShaftsAt[r0_93][r8_94][r9_94]
					if not r10_94 then
						r6_94 = #mineShafts[r0_93] + 1
						r7_94 = rngRandomSeed()
						mineShafts[r0_93][r6_94] = {
							r8_94,
							r9_94,
							1,
							(r1_94 + 90) % 360,
							r7_94,
							0
						}
						r9_0[r0_93][r6_94] = rngCreate(r7_94)
						mineShaftDepths[r0_93][r6_94] = {}
						mineShaftLengths[r0_93][r6_94] = 0
						for r14_94 = 1, wallBlockCount, 1 do
							mineShaftDepths[r0_93][r6_94][r14_94] = 0
						end
						if not mineShaftOres[r0_93][r6_94] then
							mineShaftOres[r0_93][r6_94] = generateShaftOres(r0_93, r6_94)
						end
					else
						mineShaftOres[r0_93][r10_94] = nil
						mineShaftDepths[r0_93][r10_94] = nil
						mineShaftLengths[r0_93][r10_94] = nil
					end
					r4_93[4] = nil
					if #playersInMine[r0_93] > 0 then
						triggerClientEvent(playersInMine[r0_93], "gotNewMineShaft", resourceRoot, r0_93, r1_93, r2_93, r1_94, false, false, true, false, r6_94, r5_94, r7_94, mineShaftOres[r0_93][r6_94], r10_94, nil)
					end
					refreshMineShafts(r0_93)
				end, detonationTime, 1, client)
				exports.sChat:localAction(client, "felszerelt egy dinamitot.")
			end
		end
		-- close: r4_93
	end
end)

function doHandleMineHit(mineId, shaftId, blockId, hitDepth, sourcePlayer)
	sourcePlayer = client or sourcePlayer
	
	local shaftData = mineShafts[mineId][shaftId]
	local shaftDepths = mineShaftDepths[mineId][shaftId]
	
	if not shaftDepths then
		return
	end
	
	local shaftMinDepth = false
	local shaftMaxDepth = false
	
	shaftDepths[blockId] = shaftDepths[blockId] + hitDepth
	
	for blockId = 1, wallBlockCount do
		shaftMinDepth = math.min(shaftDepths[blockId], shaftMinDepth or shaftDepths[blockId])
	end
	
	if shaftMinDepth > 0 then
		mineShaftLengths[mineId][shaftId] = math.max(0, mineShaftLengths[mineId][shaftId] + shaftMinDepth)
		
		for blockId = 1, wallBlockCount do
			shaftDepths[blockId] = shaftDepths[blockId] - shaftMinDepth
		end
	end
	
	if hitDepth <= 0 then
		return
	end
	
	for blockId = 1, wallBlockCount do
		shaftMaxDepth = math.max(shaftDepths[blockId], shaftMaxDepth or shaftDepths[blockId])
	end
	
	--------------------------------------------------
	
	local shaftLength = mineShaftLengths[mineId][shaftId]
	local shaftTunnels = shaftData[3]
	
	while shaftLength + shaftMaxDepth >= shaftTunnels * tunnelLength - wallMinimumDepth do
		local shaftDeg = shaftData[4]
		local shaftRad = prad(shaftDeg)
		
		local shaftCos = pcos(shaftRad)
		local shaftSin = psin(shaftRad)
		
		local shaftX = shaftData[1] + (shaftTunnels - 1) * shaftCos
		local shaftY = shaftData[2] + (shaftTunnels - 1) * shaftSin
		
		local aheadX = shaftX + shaftCos
		local aheadY = shaftY + shaftSin
		
		local aheadJunction = mineJunctionsAt[mineId][aheadX] and mineJunctionsAt[mineId][aheadX][aheadY]
		local aheadOpenShaft = mineOpenShaftsAt[mineId][aheadX] and mineOpenShaftsAt[mineId][aheadX][aheadY]
		local aheadExtendable = mineExtendableShaftsAt[mineId][aheadX] and mineExtendableShaftsAt[mineId][aheadX][aheadY]
		
		if aheadOpenShaft then
			local aheadOpenShaftData = mineShafts[mineId][aheadOpenShaft]
			
			if aheadOpenShaftData then
				local openShaftDeg = aheadOpenShaftData[4]
				local openShaftRad = prad((shaftDeg - openShaftDeg) % 360)
				local openShaftSin = psin(openShaftRad)
				
				-- Merge two open-shaft
				if openShaftSin == 0 then
					mineShaftOres[mineId][aheadOpenShaft] = nil
					mineShaftDepths[mineId][aheadOpenShaft] = nil
					mineShaftLengths[mineId][aheadOpenShaft] = nil
					
					mineShaftOres[mineId][shaftId] = nil
					mineShaftDepths[mineId][shaftId] = nil
					mineShaftLengths[mineId][shaftId] = nil
					
					refreshMineShafts(mineId)
					
					if #playersInMine[mineId] > 0 then
						triggerClientEvent(playersInMine[mineId], "closeMergedMineShafts", sourcePlayer, mineId, shaftId, aheadOpenShaft)
					end
					return
					-- Move open forward and create 3-way junction
				elseif aheadExtendable then
					local extendableShaftId, extendableTunnelId = unpack(aheadExtendable)
					local extendableShaftData = mineShafts[mineId][extendableShaftId]
					
					if extendableShaftData then
						local extendableDeg = extendableShaftData[4]
						local extendableRad = prad((shaftDeg - extendableDeg) % 360)
						local extendableSin = psin(extendableRad)
						
						createOpenShaft(mineId, extendableShaftId, extendableTunnelId, extendableSin < 0, true)
						return
					end
				end
			end
			-- Create 4-way-junction
		elseif aheadJunction then
			local aheadJunctionData = mineJunctions[mineId][aheadJunction]
			
			if aheadJunctionData then
				aheadJunctionData[4] = nil
				
				mineShaftOres[mineId][shaftId] = nil
				mineShaftDepths[mineId][shaftId] = nil
				mineShaftLengths[mineId][shaftId] = nil
				
				refreshMineShafts(mineId)
				
				if #playersInMine[mineId] > 0 then
					triggerClientEvent(playersInMine[mineId], "closeMergedMineShafts", sourcePlayer, mineId, shaftId, false, aheadJunctionData[1], aheadJunctionData[2], aheadJunctionData[3])
				end
				return
			end
			-- Create 3-way-junction
		elseif aheadExtendable then
			local extendableShaftId, extendableTunnelId = unpack(aheadExtendable)
			local extendableShaftData = mineShafts[mineId][extendableShaftId]
			
			if extendableShaftData then
				local extendableDeg = extendableShaftData[4]
				local extendableRad = prad((shaftDeg - extendableDeg) % 360)
				local extendableSin = psin(extendableRad)
				
				createOpenShaft(mineId, extendableShaftId, extendableTunnelId, extendableSin < 0)
				return
			end
			-- Extend open-shaft
		else
			shaftTunnels = shaftTunnels + 1
			
			if shaftData[3] ~= shaftTunnels then
				shaftData[3] = shaftTunnels
				
				local newOres = generateShaftOres(mineId, shaftId)
				
				if not mineShaftOres[mineId][shaftId] then
					mineShaftOres[mineId][shaftId] = {}
				end
				
				for i = 1, #newOres do
					table.insert(mineShaftOres[mineId][shaftId], newOres[i])
				end
				
				if #playersInMine[mineId] > 0 then
					triggerClientEvent(playersInMine[mineId], "gotExtendedMineShaft", sourcePlayer, mineId, shaftId, newOres)
				end
			end
			
			refreshMineShafts(mineId)
		end
	end
	
	local shaftOres = mineShaftOres[mineId][shaftId] or {}
	local fallingOres = {}
	
	for i = #shaftOres, 1, -1 do
		local orePosX, orePosY, orePosZ, oreDepth, oreBlock, oreType, oreId = unpack(shaftOres[i])
		
		if oreBlock == blockId then
			local shouldFall = oreDepth <= shaftLength + shaftDepths[blockId]
			
			if shouldFall then
				fallingOres[oreId] = true
				
				if oreTypes[oreType] then
					local fixOreId = 0
					
					while true do
						fixOreId = fixOreId + 1
						
						if not mineFixOres[mineId][fixOreId] then
							mineFixOres[mineId][fixOreId] = {orePosX, orePosY, oreType}
							
							if not fixOres[mineId] then
								fixOres[mineId] = {}
							end
							
							table.insert(fixOres[mineId], {fixOreId, getTickCount()})
							checkFixOreTimer()
							
							break
						end
					end
					
					fallingOres[oreId] = {fixOreId, oreType}
				end
				
				table.remove(shaftOres, i)
			end
		end
	end
	
	return fallingOres
end

function checkFixOreTimer()
	-- line: [3403, 3407] id: 96
	if not r46_0 then
		r46_0 = setTimer(checkFixOres, 60000, 0)
	end
end
function checkFixOres()
	-- line: [3409, 3456] id: 97
	if next(fixOres) then
		local r0_97 = getTickCount()
		local r1_97 = {}
		for r5_97 in pairs(fixOres) do
			for r9_97 = #fixOres[r5_97], 1, -1 do
				local r10_97, r11_97 = unpack(fixOres[r5_97][r9_97])
				if r0_97 - r11_97 >= 7200000 then
					table.remove(fixOres[r5_97], r9_97)
					if not r1_97[r5_97] then
						r1_97[r5_97] = {}
					end
					table.insert(r1_97[r5_97], r10_97)
					if mineFixOres[r5_97] then
						mineFixOres[r5_97][r10_97] = nil
					end
				end
			end
			if #fixOres[r5_97] == 0 then
				fixOres[r5_97] = nil
			end
		end
		for r5_97, r6_97 in pairs(r1_97) do
			if #playersInMine[r5_97] > 0 then
				triggerLatentClientEvent(playersInMine[r5_97], "syncFixOreDelete", resourceRoot, r5_97, r6_97)
			end
		end
		if not next(fixOres) then
			if isTimer(r46_0) then
				killTimer(r46_0)
			end
			r46_0 = nil
		end
	else
		if isTimer(r46_0) then
			killTimer(r46_0)
		end
		r46_0 = nil
	end
end
function createOpenShaft(r0_98, r1_98, r2_98, r3_98, r4_98)
	-- line: [3458, 3600] id: 98
	local r5_98 = mineShafts[r0_98][r1_98]
	local r6_98 = r5_98[3]
	local r7_98 = r5_98[4]
	local r8_98 = prad(r7_98)
	local r9_98 = pcos(r8_98)
	local r10_98 = psin(r8_98)
	local r11_98 = r5_98[1] + (r2_98 - 1) * r9_98
	local r12_98 = r5_98[2] + (r2_98 - 1) * r10_98
	local r13_98 = #mineShafts[r0_98] + 1
	mineShafts[r0_98][r13_98] = {
		r11_98 + r9_98,
		r12_98 + r10_98,
		math.max(1, r6_98 - r2_98),
		r7_98,
		r5_98[5],
		r2_98
	}
	r9_0[r0_98][r13_98] = r9_0[r0_98][r1_98]
	if r4_98 then
		mineShaftOres[r0_98][r13_98] = {}
		mineShaftDepths[r0_98][r13_98] = {}
		mineShaftLengths[r0_98][r13_98] = 0
		for r18_98 = 1, wallBlockCount, 1 do
			mineShaftDepths[r0_98][r13_98][r18_98] = 0
		end
	else
		mineShaftOres[r0_98][r13_98] = mineShaftOres[r0_98][r1_98]
		mineShaftDepths[r0_98][r13_98] = mineShaftDepths[r0_98][r1_98]
		if mineShaftLengths[r0_98][r1_98] then
			mineShaftLengths[r0_98][r13_98] = math.max(0, mineShaftLengths[r0_98][r1_98] - r2_98 * tunnelLength)
		end
	end
	local r15_98 = 0
	if mineShaftLengths[r0_98][r1_98] and mineShaftLengths[r0_98][r13_98] then
		r15_98 = mineShaftLengths[r0_98][r1_98] - mineShaftLengths[r0_98][r13_98]
	end
	mineShafts[r0_98][r1_98][3] = r2_98 - 1
	mineShaftOres[r0_98][r1_98] = nil
	mineShaftDepths[r0_98][r1_98] = nil
	mineShaftLengths[r0_98][r1_98] = nil
	if mineShaftOres[r0_98][r13_98] then
		for r19_98 = 1, #mineShaftOres[r0_98][r13_98], 1 do
			mineShaftOres[r0_98][r13_98][r19_98][4] = mineShaftOres[r0_98][r13_98][r19_98][4] - r15_98
		end
	end
	if r6_98 - r2_98 <= 0 and mineShaftOres[r0_98] and mineShaftOres[r0_98][r13_98] and #mineShaftOres[r0_98][r13_98] == 0 then
		mineShaftOres[r0_98][r13_98] = generateShaftOres(r0_98, r13_98)
	end
	refreshMineShafts(r0_98)
	local r16_98 = false
	local r17_98 = false
	local r18_98 = r11_98
	local r19_98 = r12_98
	local r20_98 = r7_98
	if r3_98 then
		r18_98 = r11_98 - r10_98
		r19_98 = r12_98 + r9_98
		r20_98 = (r7_98 + 90) % 360
	else
		r18_98 = r11_98 + r10_98
		r19_98 = r12_98 - r9_98
		r20_98 = (r7_98 - 90) % 360
	end
	local r21_98 = mineOpenShaftsAt[r0_98][r18_98] and mineOpenShaftsAt[r0_98][r18_98][r19_98]
	if not r21_98 then
		r16_98 = #mineShafts[r0_98] + 1
		r17_98 = rngRandomSeed()
		mineShafts[r0_98][r16_98] = {
			r18_98,
			r19_98,
			1,
			r20_98,
			r17_98,
			0
		}
		r9_0[r0_98][r16_98] = rngCreate(r17_98)
		mineShaftDepths[r0_98][r16_98] = {}
		mineShaftLengths[r0_98][r16_98] = 0
		for r25_98 = 1, wallBlockCount, 1 do
			mineShaftDepths[r0_98][r16_98][r25_98] = 0
		end
		if not mineShaftOres[r0_98][r16_98] then
			mineShaftOres[r0_98][r16_98] = generateShaftOres(r0_98, r16_98)
		end
	else
		mineShaftOres[r0_98][r21_98] = nil
		mineShaftDepths[r0_98][r21_98] = nil
		mineShaftLengths[r0_98][r21_98] = nil
	end
	local r22_98 = math.floor(rngGetValue(r9_0[r0_98][r13_98]) * 5) + 1
	if r3_98 then
		table.insert(mineJunctions[r0_98], {
			r11_98,
			r12_98,
			r22_98,
			(r7_98 + 180) % 360
		})
	else
		table.insert(mineJunctions[r0_98], {
			r11_98,
			r12_98,
			r22_98,
			r7_98
		})
	end
	if not mineJunctionsAt[r0_98][r11_98] then
		mineJunctionsAt[r0_98][r11_98] = {}
	end
	mineJunctionsAt[r0_98][r11_98][r12_98] = #mineJunctions[r0_98]
	if #playersInMine[r0_98] > 0 then
		local r23_98 = triggerClientEvent
		local r24_98 = playersInMine[r0_98]
		local r25_98 = "gotNewMineShaft"
		local r26_98 = client or resourceRoot
		r23_98(r24_98, r25_98, r26_98, r0_98, r11_98, r12_98, r7_98, r1_98, r2_98, r3_98, r13_98, r16_98, r22_98, r17_98, mineShaftOres[r0_98][r16_98] or mineShaftOres[r0_98][r13_98], r21_98, r4_98)
	end
	refreshMineShafts(r0_98)
	return r16_98
end
function refreshMineShafts(r0_99)
	-- line: [3602, 3649] id: 99
	r15_0[r0_99] = {}
	mineOpenShaftsAt[r0_99] = {}
	mineExtendableShaftsAt[r0_99] = {}
	for r4_99 = 1, #mineShafts[r0_99], 1 do
		local r5_99 = mineShafts[r0_99][r4_99]
		local r7_99 = prad(r5_99[4])
		local r8_99 = pcos(r7_99)
		local r9_99 = psin(r7_99)
		local r10_99 = r5_99[1]
		local r11_99 = r5_99[2]
		for r15_99 = 1, r5_99[3], 1 do
			if not r15_0[r0_99][r10_99] then
				r15_0[r0_99][r10_99] = {}
			end
			r15_0[r0_99][r10_99][r11_99] = r4_99
			if canExtendShaftAt(r10_99, r11_99) then
				if not mineExtendableShaftsAt[r0_99][r10_99] then
					mineExtendableShaftsAt[r0_99][r10_99] = {}
				end
				mineExtendableShaftsAt[r0_99][r10_99][r11_99] = {
					r4_99,
					r15_99
				}
			end
			r10_99 = r10_99 + r8_99
			r11_99 = r11_99 + r9_99
		end
		r10_99 = r10_99 - r8_99
		r11_99 = r11_99 - r9_99
		if mineShaftDepths[r0_99][r4_99] then
			if not mineOpenShaftsAt[r0_99][r10_99] then
				mineOpenShaftsAt[r0_99][r10_99] = {}
			end
			mineOpenShaftsAt[r0_99][r10_99][r11_99] = r4_99
		end
	end
end
function generateShaftOres(r0_100, r1_100)
	-- line: [3653, 3712] id: 100
	local r2_100 = {}
	local r3_100 = mineShafts[r0_100][r1_100]
	local r4_100 = r9_0[r0_100][r1_100]
	local r5_100 = prad(r3_100[4])
	local r6_100 = pcos(r5_100)
	local r7_100 = psin(r5_100)
	local r8_100 = mineShaftDepths[r0_100][r1_100]
	local r9_100 = mineShaftLengths[r0_100][r1_100]
	local r10_100 = math.floor(r9_100 / tunnelLength) + 1
	local r11_100 = false
	for r15_100 = 1, wallBlockCount, 1 do
		r11_100 = math.max(r8_100[r15_100], r11_100 or r8_100[r15_100])
	end
	r9_100 = r9_100 + r11_100
	local r12_100 = r3_100[1] * tunnelLength + (r9_100 - tunnelLength / 2) * r6_100
	local r13_100 = r3_100[2] * tunnelLength + (r9_100 - tunnelLength / 2) * r7_100
	local r14_100 = wallMeshHeight / 2
	for r19_100 = 1, math.floor((r3_100[3] * tunnelLength - r9_100) / wallMaximumDepth), 1 do
		for r23_100 = 1, r39_0, 1 do
			local r24_100 = nil	-- notice: implicit variable refs by block#[12]
			if r7_100 == 0 then
				r24_100 = r23_100 - 1
			else
				r24_100 = r39_0 - r23_100
			end
			for r28_100 = 1, r40_0, 1 do
				if rngGetValue(r4_100) > 0.9 then
					local r29_100 = rngGetValue(r4_100)
					local r32_100 = r24_100 * r42_0 - r36_0 / 2 + r42_0 / 2
					local r33_100 = (r19_100 - 1) * wallMaximumDepth + 0.5 + (r29_100 * 2 - 1) * 0.15
					table.insert(r2_100, {
						r12_100 + r32_100 * r7_100 + r33_100 * r6_100,
						r13_100 + r32_100 * r6_100 + r33_100 * r7_100,
						r14_100 + (r28_100 - 1) * r43_0 - r37_0 / 2 + r43_0 / 2,
						r9_100 + r33_100,
						4 - math.floor(r23_100 / 2 + 0.5) + math.floor(r28_100 / 2) * 3,
						chooseRandomOre(r29_100),
						(r10_100 - 1) * r44_0 + (r19_100 - 1) * r41_0 + (r23_100 - 1) * r40_0 + r28_100
					})
				end
			end
		end
	end
	return r2_100
end
function initOres()
	-- line: [3714, 3756] id: 101
	local r0_101 = 0
	local r1_101 = 0
	for r5_101, r6_101 in pairs(oreTypes) do
		if not r6_101.fixedBasePrice then
			r47_0 = r47_0 + r6_101.itemProbability
			if r6_101.meltingPoint then
				r1_101 = r1_101 + 1
			else
				r0_101 = r0_101 + 1
			end
		end
	end
	for r5_101, r6_101 in pairs(oreTypes) do
		if r6_101.fixedBasePrice then
			r6_101.orePrice = r6_101.fixedBasePrice
		else
			local r7_101 = 10000 / (r6_101.itemProbability / r47_0)
			if r6_101.meltingPoint then
				r6_101.orePrice = (r7_101 / 2.25) + 2500
			else
				r6_101.orePrice = r7_101 / 6
			end
		end
		r6_101.orePrice = math.floor(r6_101.orePrice * (globalPriceMultiplier))
	end
	r48_0 = r47_0 * 25 / (r1_101 + r0_101) * 1.4
	r47_0 = r47_0 + r48_0
	for r6_101, r7_101 in pairs(oreTypes) do
		if r7_101.fixedBasePrice then
			r47_0 = r47_0 + r7_101.itemProbability
		end
	end
	
end
function getOrePrice(r0_102)
	-- line: [3758, 3764] id: 102
	for r4_102, r5_102 in pairs(oreTypes) do
		if r5_102.forexIndex == r0_102 then
			return r5_102.orePrice
		end
	end
end
function chooseRandomOre(r0_103)
	-- line: [3766, 3787] id: 103
	local r1_103 = r47_0 * (r0_103 or math.random())
	local r2_103 = r48_0
	if r1_103 < r2_103 then
		return "rock"
	end
	for r6_103, r7_103 in pairs(oreTypes) do
		r2_103 = r2_103 + r7_103.itemProbability
		if r1_103 <= r2_103 then
			if r6_103 ~= "chest" or r49_0.minerChest then
				if r6_103 == "seerconium" and not r49_0.minerEvent then
					break
				else
					return r6_103
				end
			else
				break
			end
		end
	end
	return "rock"
end
local r50_0 = nil
local r51_0 = nil
local r52_0 = nil
function scheduleMineSaving()
	-- line: [3795, 3820] id: 104
	if r50_0 or not next(loadedMinesData) then
		return 
	end
	r50_0 = getTickCount()
	r52_0 = coroutine.create(doMineSaving)
	r51_0 = setTimer(function()
		-- line: [3803, 3818] id: 105
		local r0_105 = coroutine.status(r52_0)
		if r0_105 == "suspended" then
			r50_0 = getTickCount()
			coroutine.resume(r52_0)
		elseif r0_105 == "dead" then
			if isTimer(r51_0) then
				killTimer(r51_0)
			end
			r52_0 = nil
			r50_0 = nil
			r51_0 = nil
		end
	end, 1000, 0)
end
function doMineSaving()
	-- line: [3822, 3826] id: 106
	for r3_106 in pairs(loadedMinesData) do
		serializeMine(r3_106)
	end
end
function checkMineSavingTime(r0_107)
	-- line: [3828, 3842] id: 107
	if not loadedMinesData[r0_107] then
		return 
	end
	if not coroutine.running() then
		return 
	end
	if getTickCount() - r50_0 <= 100 then
		return 
	end
	coroutine.yield()
end
function serializeMine(r0_108, r1_108)
	-- line: [3844, 4059] id: 108
	if loadedMinesData[r0_108] then
		local r2_108 = r7_0[r0_108]
		local r3_108 = nil	-- notice: implicit variable refs by block#[7]
		if r2_108 then
			r2_108 = getTickCount()
			r3_108 = r7_0[r0_108]
			r2_108 = r2_108 - r3_108
		else
			r2_108 = math.huge
		end
		if r1_108 then
			r3_108 = 60000
		else
			r3_108 = 0
		end
		if r3_108 < r2_108 then
			r3_108 = fileCreate("data/" .. r0_108 .. ".see")
			if r3_108 then
				local r4_108 = false
				r7_0[r0_108] = getTickCount()
				if next(mineShafts[r0_108]) then
					fileWrite(r3_108, "#SHAFTS\n")
					for r8_108, r9_108 in ipairs(mineShafts[r0_108]) do
						fileWrite(r3_108, table.concat(r9_108, " ") .. "\n")
					end
					checkMineSavingTime(r0_108)
				end
				if next(mineShaftDepths[r0_108]) then
					fileWrite(r3_108, "#DEPTHS\n")
					for r8_108, r9_108 in pairs(mineShaftDepths[r0_108]) do
						fileWrite(r3_108, r8_108 .. " " .. table.concat(r9_108, " ") .. "\n")
					end
					checkMineSavingTime(r0_108)
				end
				if next(mineShaftLengths[r0_108]) then
					fileWrite(r3_108, "#LENGTHS\n")
					for r8_108, r9_108 in pairs(mineShaftLengths[r0_108]) do
						fileWrite(r3_108, table.concat({
							r8_108,
							r9_108
						}, " ") .. "\n")
					end
					checkMineSavingTime(r0_108)
				end
				if next(mineJunctions[r0_108]) then
					fileWrite(r3_108, "#JUNCTIONS\n")
					for r8_108, r9_108 in ipairs(mineJunctions[r0_108]) do
						fileWrite(r3_108, table.concat(r9_108, " ") .. "\n")
					end
					checkMineSavingTime(r0_108)
				end
				if next(mineShaftDepths[r0_108]) and next(mineShaftOres[r0_108]) then
					fileWrite(r3_108, "#ORES\n")
					for r8_108 in pairs(mineShaftDepths[r0_108]) do
						if mineShaftOres[r0_108][r8_108] then
							for r12_108, r13_108 in ipairs(mineShaftOres[r0_108][r8_108]) do
								fileWrite(r3_108, r8_108 .. " " .. table.concat(r13_108, " ") .. "\n")
							end
						end
					end
					checkMineSavingTime(r0_108)
				end
				if next(mineFixOres[r0_108]) then
					fileWrite(r3_108, "#FIXORES\n")
					for r8_108, r9_108 in pairs(mineFixOres[r0_108]) do
						if r9_108[4] == "player" then
							fileWrite(r3_108, table.concat({
								r9_108[1],
								r9_108[2],
								r9_108[3]
							}, " ") .. "\n")
						else
							fileWrite(r3_108, table.concat(r9_108, " ") .. "\n")
						end
					end
					checkMineSavingTime(r0_108)
				end
				if next(mineRails[r0_108]) then
					fileWrite(r3_108, "#RAILS\n")
					for r8_108, r9_108 in ipairs(mineRails[r0_108]) do
						if #r9_108 == 5 then
							local r10_108 = fileWrite
							local r11_108 = r3_108
							local r12_108 = table.concat
							local r13_108 = {}
							local r14_108 = r9_108[1]
							local r15_108 = r9_108[2]
							local r16_108 = r9_108[3]
							local r17_108 = r9_108[4]
							local r18_108 = r9_108[5]
							if r18_108 then
								r18_108 = 1
							else
								r18_108 = 0
							end
							-- setlist for #13 failed
							local list = {r9_108[1], r9_108[2], r9_108[3], r9_108[4], r18_108}
							fileWrite(r3_108, table.concat(list, " ") .. "\n")
						else
							local r10_108 = fileWrite
							local r11_108 = r3_108
							local r12_108 = table.concat
							local r13_108 = {}
							local r14_108 = r9_108[1]
							local r15_108 = r9_108[2]
							local r16_108 = r9_108[3]
							local r17_108 = r9_108[4]
							if r17_108 then
								r17_108 = 1
							else
								r17_108 = 0
							end
							-- setlist for #13 failed
							local list = {r9_108[1], r9_108[2], r9_108[3], r17_108}
							fileWrite(r3_108, table.concat(list, " ") .. "\n")
						end
					end
					checkMineSavingTime(r0_108)
				end
				if next(mineRailSwitches[r0_108]) then
					fileWrite(r3_108, "#RAILSWITCHES\n")
					for r8_108, r9_108 in ipairs(mineRailSwitches[r0_108]) do
						iprint(r9_108)
						fileWrite(r3_108, table.concat(r9_108, " ") .. "\n")
					end
					checkMineSavingTime(r0_108)
				end
				if next(mineRailSwitchStates[r0_108]) then
					fileWrite(r3_108, "#RAILSWITCHSTATES\n")
					for r8_108, r9_108 in pairs(mineRailSwitchStates[r0_108]) do
						fileWrite(r3_108, table.concat({
							r8_108,
							r9_108
						}, " ") .. "\n")
					end
					checkMineSavingTime(r0_108)
				end
				local r5_108 = mineTrainData[r0_108]
				if r5_108 then
					fileWrite(r3_108, "#TRAIN\n")
					local r6_108 = fileWrite
					local r7_108 = r3_108
					local r8_108 = table.concat
					local r9_108 = {}
					local r10_108 = r5_108.trackId or 1
					local r11_108 = r5_108.routeId or -1
					local r12_108 = r5_108.trackPosition or 0
					local r13_108 = r5_108.trackDirection or 1
					local r14_108 = r5_108.fuelLevel or 0
					local r15_108 = r5_108.jerryContent or 0
					-- setlist for #9 failed
					local list = {r10_108, r11_108, r12_108, r13_108, r14_108, r15_108}
					fileWrite(r3_108, table.concat(list, " ") .. "\n")
					checkMineSavingTime(r0_108)
				end
				local r6_108 = mineInventoryData[r0_108]
				if r6_108 then
					fileWrite(r3_108, "#INVENTORY\n")
					local r7_108 = fileWrite
					local r8_108 = r3_108
					local r9_108 = table.concat
					local r10_108 = {}
					local r11_108 = r6_108.railIrons or 0
					local r12_108 = r6_108.railWoods or 0
					local r13_108 = r6_108.mineLamps or 0
					local r14_108 = r6_108.subCartNum or 0
					local r15_108 = r6_108.dieselLoco
					if r15_108 then
						r15_108 = 1 or 0
					else
						r15_108 = 0
					end
					local r16_108 = r6_108.fuelTankLevel or 0
					-- setlist for #10 failed
					local list = {r11_108, r12_108, r13_108, r14_108, r15_108, r16_108}
					fileWrite(r3_108, table.concat(list, " ") .. "\n")
					checkMineSavingTime(r0_108)
				end
				if next(mineBufferContent[r0_108]) then
					fileWrite(r3_108, "#BUFFER\n")
					for r10_108, r11_108 in pairs(mineBufferContent[r0_108]) do
						fileWrite(r3_108, table.concat({
							r10_108,
							r11_108
						}, " ") .. "\n")
					end
					checkMineSavingTime(r0_108)
				end
				if next(mineFoundryContent[r0_108]) then
					fileWrite(r3_108, "#FOUNDRY\n")
					for r10_108, r11_108 in pairs(mineFoundryContent[r0_108]) do
						fileWrite(r3_108, table.concat({
							r10_108,
							r11_108
						}, " ") .. "\n")
					end
					checkMineSavingTime(r0_108)
				end
				if next(mineLights[r0_108]) then
					fileWrite(r3_108, "#LIGHTS\n")
					for r10_108 in pairs(mineLights[r0_108]) do
						for r14_108 in pairs(mineLights[r0_108][r10_108]) do
							fileWrite(r3_108, table.concat({
								r10_108,
								r14_108
							}, " ") .. "\n")
						end
					end
					checkMineSavingTime(r0_108)
				end
				local r7_108 = mineOrders[r0_108]
				if r7_108 then
					fileWrite(r3_108, "#ORDER\n")
					for r11_108, r12_108 in pairs(r7_108) do
						fileWrite(r3_108, table.concat({
							r11_108,
							r12_108
						}, " ") .. "\n")
					end
					if mineOrderPaid[r0_108] then
						fileWrite(r3_108, "paid\n")
					end
					checkMineSavingTime(r0_108)
				end
				local r8_108 = loadedMinesData[r0_108]
				if r8_108 and next(r8_108.workerPermissions) then
					fileWrite(r3_108, "#PERMISSIONS\n")
					for r12_108, r13_108 in pairs(r8_108.workerNames) do
						local r14_108 = fileWrite
						local r15_108 = r3_108
						local r16_108 = table.concat
						local r17_108 = {}
						local r18_108 = r12_108
						local r19_108 = r13_108:gsub(" ", "_")
						local r20_108 = r8_108.workerPermissions[r12_108] or 0
						-- setlist for #17 failed
						local list = {r18_108, r19_108, r20_108}
						fileWrite(r3_108, table.concat(list, " ") .. "\n")
					end
					checkMineSavingTime(r0_108)
				end
				fileClose(r3_108)
				if not r8_108 then
					fileDelete("data/" .. r0_108 .. ".see")
				end
				return true
			end
		end
	end
	return false
end
function parseMine(r0_109)
	local r1_109 = "data/" .. r0_109 .. ".see"
	if not fileExists(r1_109) then
		return false
	end
	local r2_109 = fileOpen(r1_109, true)
	if r2_109 then
		local r3_109 = fileGetContents(r2_109, false)
		if r3_109 then
			local r4_109 = loadedMinesData[r0_109]
			local r5_109 = false
			for r9_109, r10_109 in ipairs(split(r3_109, "\n")) do
				if string.sub(r10_109, 1, 1) == "#" then
					r5_109 = r10_109
				elseif r5_109 == "#SHAFTS" then
					local r11_109 = split(r10_109, " ")
					if not mineShafts[r0_109] then
						mineShafts[r0_109] = {}
					end
					for r15_109 = 1, #r11_109, 1 do
						r11_109[r15_109] = tonumber(r11_109[r15_109])
					end
					table.insert(mineShafts[r0_109], r11_109)
				elseif r5_109 == "#DEPTHS" then
					local r11_109 = split(r10_109, " ")
					if not mineShaftDepths[r0_109] then
						mineShaftDepths[r0_109] = {}
					end
					local r12_109 = tonumber(r11_109[1])
					if not mineShaftDepths[r0_109][r12_109] then
						mineShaftDepths[r0_109][r12_109] = {}
					end
					for r16_109 = 1, wallBlockCount, 1 do
						mineShaftDepths[r0_109][r12_109][r16_109] = tonumber(r11_109[1 + r16_109])
					end
				elseif r5_109 == "#LENGTHS" then
					local r11_109 = split(r10_109, " ")
					if not mineShaftLengths[r0_109] then
						mineShaftLengths[r0_109] = {}
					end
					mineShaftLengths[r0_109][tonumber(r11_109[1])] = tonumber(r11_109[2])
				elseif r5_109 == "#JUNCTIONS" then
					local r11_109 = split(r10_109, " ")
					if not mineJunctions[r0_109] then
						mineJunctions[r0_109] = {}
					end
					for r15_109 = 1, #r11_109, 1 do
						r11_109[r15_109] = tonumber(r11_109[r15_109])
					end
					table.insert(mineJunctions[r0_109], r11_109)
				elseif r5_109 == "#ORES" then
					local r11_109 = split(r10_109, " ")
					if not mineShaftOres[r0_109] then
						mineShaftOres[r0_109] = {}
					end
					local r12_109 = tonumber(table.remove(r11_109, 1))
					if not mineShaftOres[r0_109][r12_109] then
						mineShaftOres[r0_109][r12_109] = {}
					end
					for r16_109 = 1, #r11_109, 1 do
						r11_109[r16_109] = tonumber(r11_109[r16_109]) or r11_109[r16_109]
					end
					table.insert(mineShaftOres[r0_109][r12_109], r11_109)
				elseif r5_109 == "#FIXORES" then
					local r11_109, r12_109, r13_109, r14_109, r15_109, r16_109 = unpack(split(r10_109, " "))
					if r11_109 then
						r11_109 = tonumber(r11_109)
					end
					if r12_109 then
						r12_109 = tonumber(r12_109)
					end
					if r15_109 then
						r15_109 = tonumber(r15_109)
					end
					if r16_109 then
						r16_109 = tonumber(r16_109)
					end
					if not mineFixOres[r0_109] then
						mineFixOres[r0_109] = {}
					end
					table.insert(mineFixOres[r0_109], {
						r11_109,
						r12_109,
						r13_109,
						r14_109,
						r15_109,
						r16_109
					})
					if not fixOres[r0_109] then
						fixOres[r0_109] = {}
					end
					table.insert(fixOres[r0_109], {
						#mineFixOres[r0_109],
						getTickCount()
					})
					if r14_109 == "cart" then
						if not r27_0[r0_109] then
							r27_0[r0_109] = {}
						end
						if not r27_0[r0_109][r15_109] then
							r27_0[r0_109][r15_109] = 1
						else
							r27_0[r0_109][r15_109] = r27_0[r0_109][r15_109] + 1
						end
					end
					checkFixOreTimer()
				elseif r5_109 == "#RAILS" then
					local r11_109 = split(r10_109, " ")
					if not mineRails[r0_109] then
						mineRails[r0_109] = {}
					end
					for r15_109 = 1, #r11_109, 1 do
						r11_109[r15_109] = tonumber(r11_109[r15_109])
						if r15_109 == #r11_109 then
							r11_109[r15_109] = r11_109[r15_109] == 1
						end
					end
					table.insert(mineRails[r0_109], r11_109)
				elseif r5_109 == "#RAILSWITCHES" then
					local r11_109 = split(r10_109, " ")
					if not mineRailSwitches[r0_109] then
						mineRailSwitches[r0_109] = {}
					end
					for r15_109 = 1, #r11_109, 1 do
						r11_109[r15_109] = tonumber(r11_109[r15_109])
					end
					table.insert(mineRailSwitches[r0_109], r11_109)
				elseif r5_109 == "#RAILSWITCHSTATES" then
					local r11_109 = split(r10_109, " ")
					if not mineRailSwitchStates[r0_109] then
						mineRailSwitchStates[r0_109] = {}
					end
					mineRailSwitchStates[r0_109][tonumber(r11_109[1])] = tonumber(r11_109[2])
				elseif r5_109 == "#TRAIN" then
					local r11_109 = split(r10_109, " ")
					local r12_109 = mineTrainData
					local r13_109 = {
						trackId = tonumber(r11_109[1]) or 1,
						routeId = tonumber(r11_109[2]) or -1,
						trackPosition = tonumber(r11_109[3]) or 0,
						trackDirection = tonumber(r11_109[4]) or 1,
						fuelLevel = tonumber(r11_109[5]) or 0,
						jerryContent = tonumber(r11_109[6]) or 0,
					}
					r12_109[r0_109] = r13_109
				elseif r5_109 == "#INVENTORY" then
					local r11_109 = split(r10_109, " ")
					local r12_109 = mineInventoryData
					local r13_109 = {
						railIrons = tonumber(r11_109[1]),
						railWoods = tonumber(r11_109[2]),
						mineLamps = tonumber(r11_109[3]),
						subCartNum = tonumber(r11_109[4]),
            			dieselLoco = r11_109[5] == "1",
						fuelTankLevel = tonumber(r11_109[6]) or 0,
					}
					r12_109[r0_109] = r13_109
				elseif r5_109 == "#BUFFER" then
					local r11_109 = split(r10_109, " ")
					if not mineBufferContent[r0_109] then
						mineBufferContent[r0_109] = {}
					end
					mineBufferContent[r0_109][r11_109[1]] = tonumber(r11_109[2])
				elseif r5_109 == "#FOUNDRY" then
					local r11_109 = split(r10_109, " ")
					if not mineFoundryContent[r0_109] then
						mineFoundryContent[r0_109] = {}
					end
					mineFoundryContent[r0_109][r11_109[1]] = tonumber(r11_109[2])
				elseif r5_109 == "#LIGHTS" then
					local r11_109 = split(r10_109, " ")
					local r12_109 = tonumber(r11_109[1])
					local r13_109 = tonumber(r11_109[2])
					if not mineLights[r0_109] then
						mineLights[r0_109] = {}
					end
					if not mineLights[r0_109][r12_109] then
						mineLights[r0_109][r12_109] = {}
					end
					mineLights[r0_109][r12_109][r13_109] = true
				elseif r5_109 == "#PERMISSIONS" then
					local r11_109 = split(r10_109, " ")
					local r12_109 = tonumber(r11_109[1])
					if not r4_109.workerNames then
						r4_109.workerNames = {}
					end
					if not r4_109.workerPermissions then
						r4_109.workerPermissions = {}
					end
					r4_109.workerNames[r12_109] = r11_109[2]
					r4_109.workerPermissions[r12_109] = tonumber(r11_109[3])
				elseif r5_109 == "#ORDER" then
					local r11_109 = split(r10_109, " ")
					if not mineOrders[r0_109] then
						mineOrders[r0_109] = {}
					end
					if r11_109[1] == "paid" then
						mineOrderPaid[r0_109] = true
					else
						mineOrders[r0_109][r11_109[1]] = tonumber(r11_109[2])
					end
				end
			end
		end
		fileClose(r2_109)
		r2_109 = nil
		r3_109 = nil
		collectgarbage()
		return true
	end
	return false
end

--[[
				mineLamps = 0,
				railIrons = 0,
				railWoods = 0,
				subCartNum = 0,
				dieselLoco = false,
				fuelTankLevel = 0,
				fuelTankOutside = false,
]]

addCommandHandler("givemineloco", function(sourcePlayer, commandName)
	if exports.sPermission:hasPermission(sourcePlayer, "givemineloco") then
		local mineIdentity = playersCurrentMine[sourcePlayer]
		if not mineIdentity then
			exports.sGui:showInfobox(sourcePlayer, "e", "Nem vagy bányában!")
		elseif loadedMinesData[mineIdentity] then
			local inventoryData = mineInventoryData[mineIdentity]
			if inventoryData.dieselLoco then
				exports.sGui:showInfobox(sourcePlayer, "e", "Ebben a bányában már van egy MiguMoto mozdony!")
				return
			end

			inventoryData.dieselLoco = true
			if #playersInMine[mineIdentity] > 0 then
				triggerClientEvent(playersInMine[mineIdentity], "updateMineInventory", sourcePlayer, mineIdentity, "dieselLoco", inventoryData.dieselLoco)
			end
			exports.sGui:showInfobox(sourcePlayer, "s", "A kiválasztott tétel sikeresen módosítva!")
		end
	end
end)

addCommandHandler("removemineloco", function(sourcePlayer, commandName)
	if exports.sPermission:hasPermission(sourcePlayer, "removemineloco") then
		local mineIdentity = playersCurrentMine[sourcePlayer]
		if not mineIdentity then
			exports.sGui:showInfobox(sourcePlayer, "e", "Nem vagy bányában!")
		elseif loadedMinesData[mineIdentity] then
			local inventoryData = mineInventoryData[mineIdentity]
			if not inventoryData.dieselLoco then
				exports.sGui:showInfobox(sourcePlayer, "e", "Ebben a bányában még nincs MiguMoto mozdony!")
				return
			end

			inventoryData.dieselLoco = false
			if #playersInMine[mineIdentity] > 0 then
				triggerClientEvent(playersInMine[mineIdentity], "updateMineInventory", sourcePlayer, mineIdentity, "dieselLoco", inventoryData.dieselLoco)
			end
			exports.sGui:showInfobox(sourcePlayer, "s", "A kiválasztott tétel sikeresen módosítva.")
		end
	end
end)

--Ezek szarok xd
addCommandHandler("giveminecart", function(sourcePlayer, commandName, cartAmount)
	if exports.sPermission:hasPermission(sourcePlayer, "giveminecart") then
		local mineIdentity = playersCurrentMine[sourcePlayer]
		if not mineIdentity then
			exports.sGui:showInfobox(sourcePlayer, "e", "Nem vagy bányában!")
		elseif loadedMinesData[mineIdentity] then
			local inventoryData = mineInventoryData[mineIdentity]
			if not (cartAmount or tonumber(cartAmount)) then
				outputChatBox("[color=sightblue][SightMTA - Bánya]: [color=hudwhite]/"..commandName.." [Mennyiség]")
				return
			end

			if (inventoryData.subCartNum + cartAmount) > 6 then
				outputChatBox("[color=sightred][SightMTA - Bánya]: [color=hudwhite]Maximum 6 csille lehet a bányában!", sourcePlayer)
				return
			end

			inventoryData.subCartNum = inventoryData.subCartNum + math.floor(cartAmount)

			if #playersInMine[mineIdentity] > 0 then
				triggerClientEvent(playersInMine[mineIdentity], "updateMineInventory", sourcePlayer, mineIdentity, "subCartNum", inventoryData.subCartNum)
			end

			exports.sGui:showInfobox(sourcePlayer, "s", "Sikeresen megváltoztattad a bányában lévő csillék számát! ("..inventoryData.subCartNum - math.floor(cartAmount).." > "..inventoryData.subCartNum..")")
		end
	end
end)

addCommandHandler("takeminecart", function(sourcePlayer, commandName, cartAmount)
	if exports.sPermission:hasPermission(sourcePlayer, "takeminecart") then
		local mineIdentity = playersCurrentMine[sourcePlayer]
		if not mineIdentity then
			exports.sGui:showInfobox(sourcePlayer, "e", "Nem vagy bányában!")
		elseif loadedMinesData[mineIdentity] then
			local inventoryData = mineInventoryData[mineIdentity]
			if not (cartAmount or tonumber(cartAmount)) then
				outputChatBox("[color=sightblue][SightMTA - Bánya]: [color=hudwhite]/"..commandName.." [Mennyiség]")
				return
			end

			if (inventoryData.subCartNum - cartAmount) < 0 then
				outputChatBox("[color=sightred][SightMTA - Bánya]: [color=hudwhite]Minimum 1 csille kell a bányába!", sourcePlayer)
				return
			end

			inventoryData.subCartNum = inventoryData.subCartNum - math.floor(cartAmount)

			if #playersInMine[mineIdentity] > 0 then
				triggerClientEvent(playersInMine[mineIdentity], "updateMineInventory", sourcePlayer, mineIdentity, "subCartNum", inventoryData.subCartNum)
			end

			exports.sGui:showInfobox(sourcePlayer, "s", "Sikeresen megváltoztattad a bányában lévő csillék számát! ("..inventoryData.subCartNum + math.floor(cartAmount).." > "..inventoryData.subCartNum..")")
		end
	end
end)

addCommandHandler("setmineinventory", function(r0_110, r1_110, r2_110, r3_110)
	-- line: [4315, 4347] id: 110
	if exports.sPermission:hasPermission(r0_110, r1_110) then
		local r4_110 = playersCurrentMine[r0_110]
		if not r4_110 then
			exports.sGui:showInfobox(r0_110, "e", "Nem vagy bányában!")
		elseif loadedMinesData[r4_110] then
			local r5_110 = mineInventoryData[r4_110]
			if r2_110 ~= "railIrons" and r2_110 ~= "railWoods" and r2_110 ~= "mineLamps" then
				outputChatBox("[color=sightorange][SightMTA - Bánya]: [color=white]/" .. r1_110 .. " [railIrons | railWoods | mineLamps] [Mennyiség]", r0_110, 255, 255, 255, true)
			else
				local r6_110 = math.max(0, math.floor(tonumber(r3_110) or 0))
				if r2_110 == "railIrons" then
					r6_110 = math.min(r6_110, 2 * railIronStack)
				elseif r2_110 == "railWoods" then
					r6_110 = math.min(r6_110, 2 * railWoodStack)
				elseif r2_110 == "mineLamps" then
					r6_110 = math.min(r6_110, 2 * mineLampStack)
				end
				r5_110[r2_110] = r6_110
				if #playersInMine[r4_110] > 0 then
					triggerClientEvent(playersInMine[r4_110], "updateMineInventory", r0_110, r4_110, r2_110, r6_110)
				end
				exports.sGui:showInfobox(r0_110, "s", "A kiválasztott tétel sikeresen módosítva.")
			end
		end
	end
end)
addCommandHandler("setminefueltank", function(r0_111, r1_111, r2_111)
	if exports.sPermission:hasPermission(r0_111, r1_111) then
		local r3_111 = playersCurrentMine[r0_111]
		if not r3_111 then
			exports.sGui:showInfobox(r0_111, "e", "Nem vagy bányában!")
		elseif loadedMinesData[r3_111] then
			r2_111 = tonumber(r2_111)
			if not r2_111 then
				outputChatBox("[color=sightorange][SightMTA - Bánya]: [color=hudwhite]/" .. r1_111 .. " [Liter]", r0_111, 255, 255, 255, true)
			else
				local r4_111 = mineInventoryData[r3_111]
				r4_111.fuelTankLevel = r2_111
				if r4_111.fuelTankLevel < 0 then
					r4_111.fuelTankLevel = 0
				elseif fuelTankCapacity < r4_111.fuelTankLevel then
					r4_111.fuelTankLevel = fuelTankCapacity
				end
				if #playersInMine[r3_111] > 0 then
					triggerClientEvent(playersInMine[r3_111], "updateMineInventory", r0_111, r3_111, "fuelTankLevel", r4_111.fuelTankLevel)
				end
				exports.sGui:showInfobox(r0_111, "s", "Az üzemanyagtartály szintje sikeresen módosítva.")
			end
		end
	end
end)
addCommandHandler("mineevent", function(sourcePlayer, commandName, eventType)
	eventType = tonumber(eventType)
	if not eventType or eventType < 0 or eventType > 2 then
		outputChatBox("[color=sightorange][SightMTA - Bánya]: [color=hudwhite]/" .. commandName .. " [0: Nincs ; 1: Miner Event ; 2: Miner Chest Event]", sourcePlayer, 255, 255, 255, true)
	else
		local minerEventWas = activeEvents.minerEvent
		local minerChestWas = activeEvents.minerChest
		
		activeEvents.minerEvent = eventType == 1
		activeEvents.minerChest = eventType == 2
		
		if not activeEvents.minerEvent and minerEventWas then
			
		elseif not activeEvents.minerEvent and minerEventWas then
			
		end
		
		if activeEvents.minerEvent then
			
		elseif activeEvents.minerChest then
			
		end
	end
end)
addCommandHandler("forcesavemine", function(r0_113, r1_113, r2_113)
	if exports.sPermission:hasPermission(r0_113, r1_113) then
		r2_113 = tonumber(r2_113) or playersCurrentMine[r0_113]
		if not r2_113 then
			outputChatBox("[color=sightorange][SightMTA - Bánya]: [color=hudwhite]/" .. r1_113 .. " [ID]", r0_113, 255, 255, 255, true)
		elseif not loadedMinesData[r2_113] then
			outputChatBox("[color=sightred][SightMTA - Bánya]: [color=white]A kiválasztott bánya nem található!", r0_113, 255, 255, 255, true)
		elseif serializeMine(r2_113, true) then
			outputChatBox("[color=sightgreen][SightMTA - Bánya]: [color=white]A kiválasztott bánya sikeresen mentésre került.", r0_113, 255, 255, 255, true)
		else
			outputChatBox("[color=sightred][SightMTA - Bánya]: [color=white]A bánya mentése meghiúsult!", r0_113, 255, 255, 255, true)
		end
	end
end)
addCommandHandler("scheduleminesaving", function(r0_114, r1_114, r2_114)
	if exports.sPermission:hasPermission(r0_114, "forcesavemine") then
		scheduleMineSaving()
	end
end)


function getPlayerMines(charID)
    local properties = {}

    local charID = charID
    for k, v in pairs(loadedMinesData) do
        if v.rentedBy == charID then
            local door, aisle = getLobbyFromMineId(k)
			local name = table.concat(v.mineName, " ")
            table.insert(
                properties, 
                {
                    editable = "N",
                    inside = {0, 0, 0, 0, 4165, 0},
                    locked = v.isLocked,
                    name = name,
                    outside = {lobbyCoords[door][1], lobbyCoords[door][2], lobbyCoords[door][3] + 1, 0, 0, 0},
                    owner = charID,
                    price = 1,
                    reportTime = 3748382037,
                    type = "mine",
                    zone = lobbyCoords[door][5],
                    ownerType = "player",
                    id = k,
                    intiType = "mine",
                    locationName = formatCorridorNameMineId(k) .. " " .. formatMineName(k),
                    pos = {lobbyCoords[door][1], lobbyCoords[door][2], lobbyCoords[door][3] + 1, 0, 0, 0},
                    expire = v.rentUntil,
                    rentUntil = v.rentUntil
                }
            )
        end
    end

    return properties
end

--[[
{
  isLocked = false,
  mineId = 330,
  mineName = { "KALÁNYOS", "DEZSŐ" },
  ownerName = "Kalányos Dezső",
  permissions = "[ [ ] ]",
  rentMode = "cash",
  rentUntil = 1752691762,
  rentedBy = 1,
  workerNames = {},
  workerPermissions = {},
  workersInside = {}
}
  ]]

addCommandHandler("getmineinfo", function(sourcePlayer, commandName, mineIdentity)
	if exports.sPermission:hasPermission(sourcePlayer, "getmineinfo") then
		if not (mineIdentity and tonumber(mineIdentity)) then
			outputChatBox("[color=sightblue][SightMTA - Bánya]: [color=hudwhite]/"..commandName.." [Bánya ID]", sourcePlayer)
			return
		end

		local mineIdentity = tonumber(mineIdentity)
		local mineData = loadedMinesData[mineIdentity]

		local formattedName = mineData.mineName[1] .. " " .. (mineData.mineName[2] or "")
		local ownerName = mineData.ownerName .. " (" .. mineData.rentedBy .. ")"
		local rentMode = mineData.rentMode == "cash" and "Készpénz" or "Prémiumpont"
		local rentUntil = mineData.rentUntil - getRealTime().timestamp

		local delta = rentUntil / 3600
		if delta < 0.5 then
			delta = "kevesebb mint fél óra"
		elseif delta < 1 then
			delta = "kevesebb mint 1 óra"
		elseif delta < 24 then
			delta = math.floor(delta) .. " óra"
		else
			local days = math.floor(delta / 24)
			local hours = math.floor(delta) - days * 24
			if hours > 0 then
				delta = days .. " nap " .. hours .. " óra"
			else
				delta = days .. " nap"
			end
		end

		rentUntil = delta

		outputChatBox("[color=sightyellow][SightMTA - Bánya]: [color=hudwhite]Bánya adatok:", sourcePlayer)
		outputChatBox("[color=sightyellow]> [color=hudwhite]Bánya neve: [color=sightgreen]"..formattedName, sourcePlayer)
		outputChatBox("[color=sightyellow]> [color=hudwhite]Tulajdonos neve: [color=sightgreen]"..ownerName, sourcePlayer)
		outputChatBox("[color=sightyellow]> [color=hudwhite]Bérlés típusa: [color=sightgreen]"..rentMode, sourcePlayer)
		outputChatBox("[color=sightyellow]> [color=hudwhite]Bánya lejáratáig hátralévő idő: [color=sightgreen]"..rentUntil, sourcePlayer)
	end
end)