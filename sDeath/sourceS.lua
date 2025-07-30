local deathPeds = {}

local respawnTimers = {}

addEventHandler("onPlayerQuit", getRootElement(),
	function ()
		if deathPeds[source] then
			if isElement(deathPeds[source]) then
				destroyElement(deathPeds[source])
			end

			deathPeds[source] = nil
		end

		if isTimer(respawnTimers[source]) then
			killTimer(respawnTimers[source])
		end
	end
)

addEvent("reSpawnInDeath", true)
addEventHandler("reSpawnInDeath", getRootElement(),
	function(r)
		syncDead(client)
	end
)

local portalPositions = {
	{-2356.203125, 151.99604797363, 35.3125},
	{1240.5773925781, -1346.1657714844, 13.369402885437}, --Korház előtt
	{240.32102966309, 109.99873352051, 3.3528604507446},
	{-2407.9294433594, -600.53869628906, 132.6484375},
	{-2016.5489501953, -2112.5874023438, 67.659858703613},
	{1501.4858398438, 315.47766113281, 18.84167098999},
	{1477.6519775391, -1662.3060302734, 14.0546875},
	{-2642.7424316406, -313.19451904297, 7.1721291542053},
	{1656.9450683594, -978.32531738281, 29.460597991943},
	{357.3620300293, -79.708908081055, 1.3638534545898},
	{-993.72033691406, -672.81970214844, 32.0078125},
	{-2053.0029296875, -921.79595947266, 32.171875},
	{-2075.8032226562, 211.35530090332, 35.388793945312},
	{-2428.7983398438, 666.53643798828, 34.98588180542},
	{-2546.8413085938, 2281.6997070312, 4.8359375},
	{-2198.6223144531, 2402.5815429688, 4.9645404815674},
	{-1892.8074951172, 2531.259765625, 47.856006622314},
	{-1408.6555175781, 2641.0205078125, 55.6875},
	{-984.57037353516, 2223.7387695312, 81.322830200195},
	{-1061.8009033203, 1678.5074462891, 25.553615570068},
	{-638.74206542969, 1459.4040527344, 13.516027450562},
	{-771.19116210938, 747.34497070312, 18.394380569458},
	{-1077.9010009766, 52.577793121338, 14.947929382324},
	{-736.27984619141, 63.977275848389, 24.619735717773},
	{-675.21331787109, -821.21112060547, 99.163375854492},
	{-476.83923339844, -1540.3615722656, 11.81609249115},
	{-800.40808105469, -2171.1608886719, 21.485614776611},
	{-444.87322998047, -2709.0646972656, 165.91796875},
	{-1836.9689941406, -1969.4246826172, 88.61873626709},
	{-1051.0364990234, -862.29541015625, 136.06727600098}
}

local function findClosestPosition(player)
    local px, py, pz = getElementPosition(player)
    local minDistance = math.huge
    local closestPosition = nil
    
    for _, pos in ipairs(portalPositions) do
        local distance = getDistanceBetweenPoints3D(px, py, pz, pos[1], pos[2], pos[3])
        
        if distance < minDistance then
            minDistance = distance
            closestPosition = pos
        end
    end
    
    return closestPosition
end

addEvent("deathFoundPortal", true)
addEventHandler("deathFoundPortal", getRootElement(), function()
	if client and client == source then
		if not getElementData(client, "canNotSpawn") then
			local playerPos = {getElementPosition(client)}
			local int, dim = getElementInterior(client), getElementDimension(client)
			local skin = getElementModel(client)
			local rot = getPedRotation(client)

			destroyPlayerPed(client)

			setElementData(client, "isPlayerDeath", false)
			setElementData(client, "bodyDamage", false)
			setElementData(client, "bloodDamage", false)

			triggerClientEvent(client, "playerRespawnedFromDeath", client, false)

			exports.sAnticheat:sendWebhookMessage("**".. getElementData(client, "visibleName"):gsub("_", " ") .."** megtalálta a portált!", "ahelp")

			spawnPlayer(client, playerPos[1], playerPos[2], playerPos[3], 0, skin, 0, 0)

			outputChatBox("[color=sightgreen][SightMTA]: #ffffffGratulálok! Megtaláltad a portált így felsegítettek téged az Istenek.", client)
		end
	end
end)

lastRespawnTimers = {}

function setLastRespawnTime(player)
	if isElement(player) then
		local lastRespawn = getElementData(player, "lastRespawn") or 0
		if lastRespawn >= 15 then
			setElementData(player, "lastRespawn", false)
			if isTimer(lastRespawnTimers[player]) then
				killTimer(lastRespawnTimers[player])
			end
		else
			setElementData(player, "lastRespawn", lastRespawn + 1)
		end
	else
		if isTimer(lastRespawnTimers[player]) then
			killTimer(lastRespawnTimers[player])
		end
	end
end

addEventHandler("onElementDataChange", getRootElement(),
	function(key, old, new)
		if key == "isPlayerDeath" and new then
			--syncDead(source)
		elseif key == "isPlayerDeath" and not new then
			if isElement(source) then
				if isTimer(lastRespawnTimers[source]) then
					killTimer(lastRespawnTimers[source])
				end
				setElementData(source, "lastRespawn", 0)
				lastRespawnTimers[source] = setTimer(setLastRespawnTime, (1000 * 60), 16, source)
			end
		end
	end
)

function stopRespawnTimer(player)
	if isTimer(respawnTimers[player]) then
		killTimer(respawnTimers[player])
	end
end
addEvent("stopRespawnTimer", true)
addEventHandler("stopRespawnTimer", root, stopRespawnTimer)


function syncDead(source)
	local x, y, z = getElementPosition(source)
	local rot = getElementRotation(source)
	local skin = getElementModel(source)
	local int = getElementInterior(source)	
	local dim = getElementData(source, "playerID")
	local headless = isPedHeadless(source)

	local deathPed = createPed(skin, x, y, z, rot)
	local playerId = getElementData(source, "playerID")
	
	setElementData(source, "c_isDead", false)

	if isElement(deathPed) then
		setElementInterior(deathPed, int)
		setElementDimension(deathPed, getElementDimension(source))
		
		setElementFrozen(deathPed, true)
		setPedAnimation(deathPed, "ped", "FLOOR_hit_f", -1, false, false, false)
		setElementData(deathPed, "activeAnimation", {"ped", "FLOOR_hit_f", -1, false, false, false})
		setElementData(deathPed, "invulnerable", true)
		setPedHeadless(deathPed, headless)

		local visibleName = getElementData(source, "visibleName"):gsub("_", " ")
		local deathReason = getElementData(source, "deathReason") or "ismeretlen"
		local bulletDamages = getElementData(source, "bulletDamages") or false

		setElementData(source, "currentPaintshopLobby", false)
        setElementData(source, "currentPaintshop", false)

		setElementData(source, "bodyDamage", false)
		setElementData(source, "bloodDamage", false)

		setElementData(deathPed, "deathPed", {source, playerId, deathReason, getElementData(source, "groupSkin") or getElementData(source, "permGroupSkin")})
		setElementData(deathPed, "visibleName", visibleName)

		deathPeds[source] = deathPed
	end

	respawnTimers[source] = setTimer(function(playerElement)
		local playerPos = {1178.2321777344, -1323.8402099609, 14.109904289246}
		local int, dim = getElementInterior(playerElement), getElementDimension(playerElement)
		local skin = getElementModel(playerElement)
		local rot = getPedRotation(playerElement)

		destroyPlayerPed(playerElement)

		setElementData(playerElement, "isPlayerDeath", false)
		setElementData(playerElement, "bodyDamage", false)
		setElementData(playerElement, "bloodDamage", false)

		setElementData(playerElement, "char.Thirst", 100)
		setElementData(playerElement, "char.Hunger", 100)
		triggerClientEvent(playerElement, "syncNeeds", playerElement, 100, 100)

		exports.sControls:toggleAllControls(playerElement, true)


		triggerClientEvent(playerElement, "playerRespawnedFromDeath", playerElement, false)

		spawnPlayer(playerElement, playerPos[1], playerPos[2], playerPos[3], 0, skin, 0, 0)
	end, 960000, 1, source)

	spawnPlayer(source, x, y, z, rot, skin, int, dim)

	local position = findClosestPosition(source)

	if exports.sItems:hasItem(source, 361) then
		exports.sItems:takeItem(source, "itemId", 361)
	end

	triggerClientEvent(source, "spawnedInDeath", source, position[1], position[2], position[3])
	setElementData(source, "isPlayerDeath", true)
end

addEventHandler("onResourceStart", resourceRoot,
	function()
 		for key, value in pairs(getElementsByType("player")) do
 			if getElementData(value, "isPlayerDeath") then
 				setElementHealth(value, 0)
 			end
 		end
 	end
)

function destroyPlayerPed(targetPlayer)
    if targetPlayer and getElementType(targetPlayer) == "player" then
        if deathPeds[targetPlayer] then
            x, y, z = getElementPosition(deathPeds[targetPlayer])
           int = getElementInterior(deathPeds[targetPlayer])
           dim = getElementDimension(deathPeds[targetPlayer])
           rot = getPedRotation(deathPeds[targetPlayer])
       end

       if isElement(deathPeds[targetPlayer]) then
           destroyElement(deathPeds[targetPlayer])
       end

       deathPeds[targetPlayer] = nil
    end
end

local carriedPeds = {}

addEvent("startBodyCarry", true)
addEventHandler("startBodyCarry", getRootElement(),
	function(element)
		if element == client then
			exports.sAnticheat:anticheatBan(client, "AC #123 - sDeath @sourceS:225")
			return
		end

		if getElementHealth(element) > 20 and getElementType(element) ~= "ped" then
			exports.sAnticheat:anticheatBan(client, "AC #124 - sDeath @sourceS:231")
			return
		end

		setElementData(element, "deathPedCarriedBy", client)
		setElementData(client, "carryingOther", element)

		setElementFrozen(element, false)

		carriedPeds[client] = element

		triggerClientEvent(client, "showInfobox", client, "info", "Letenni az [F] gombbal tudod.")
		setPedAnimation(client, "CARRY", "liftup", -1, false, false, false, false)
		bindKey(client, "F", "down", dropBody)
	end
)

addEvent("setStage2AnimAnimation", true)
addEventHandler("setStage2AnimAnimation", getRootElement(),
	function()
		setPedAnimation(client, "CRACK", "crckdeth2", -1, true)
	end
)


function dropBody(player, key, state)
	if carriedPeds[player] then
		if isElement(carriedPeds[player]) then
			setElementData(carriedPeds[player], "deathPedCarriedBy", nil)
		end

		if getElementType(carriedPeds[player]) == "ped" then

			local x, y, z = getElementPosition(player)
			local int = getElementInterior(player)
			local dim = getElementDimension(player)

			setElementPosition(carriedPeds[player], x, y, z)
			setElementInterior(carriedPeds[player], int)
			setElementDimension(carriedPeds[player], dim)

			setTimer(function(ped)
				setPedAnimation(ped, "ped", "FLOOR_hit_f", -1, false, false, false)
			end, 1000, 1, carriedPeds[player])
		end

		carriedPeds[player] = nil
	 	unbindKey(player, "F", "down", dropBody)
	 	setElementData(player, "carryingOther", false)
		setPedAnimation(player, "CARRY", "putdwn", -1, false, false, false, false)
	end
end

function Spawn()
	setElementData(source, "canNotSpawn", false)
end
addEventHandler("onPlayerSpawn", root, Spawn)