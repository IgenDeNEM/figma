local sightexports = {
	sAdministration = false,
	sPermission = false,
	sDashboard = false,
	sGroups = false,
	sInteriors = false
}
local function sightlangProcessExports()
	for k in pairs(sightexports) do
		local res = getResourceFromName(k)
		if res and getResourceState(res) == "running" then
			sightexports[k] = exports[k]
		else
			sightexports[k] = false
		end
	end
end
sightlangProcessExports()
if triggerServerEvent then
	addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
	addEventHandler("onResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
	if not sightlangWaiterState0 then
		local res0 = getResourceFromName("sDashboard")
		if res0 and getResourceState(res0) == "running" then
			loadedChatAnims()
			sightlangWaiterState0 = true
		end
	end
end
if triggerServerEvent then
	addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
	addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientRender", getRootElement(), renderTalkAnims, true, prio)
		else
			removeEventHandler("onClientRender", getRootElement(), renderTalkAnims)
		end
	end
end
local togColorOOC = false
local colors = {}
colors[11] = "sightred"
colors[10] = "sightblue"
colors[9] = "sightgreen-second"
colors[8] = "sightorange-second"
colors[7] = "sightorange"
colors[6] = "sightyellow"
for i = 1, 5 do
	colors[i] = "sightgreen"
end
function onOOCChat(commandName, ...)
	local message = table.concat({
		...
	}, " ")
	if 0 < #message and 0 < utf8.len(message) and utf8.len(message) <= 128 then
		local playersTable = {}
		local nearbyPlayersCount = 1
		local sourcePlayerName = utf8.gsub(getElementData(localPlayer, "visibleName"), "_", " ")
		local sourceX, sourceY, sourceZ = getElementPosition(localPlayer)
		local players = getElementsByType("player", getRootElement(), true)
		for k = 1, #players do
			local v = players[k]
			if v ~= localPlayer then
				local targetX, targetY, targetZ = getElementPosition(v)
				if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 12 then
					table.insert(playersTable, v)
					nearbyPlayersCount = nearbyPlayersCount + 1
				end
			end
		end
		local spectatingPlayers = getElementData(localPlayer, "spectatingPlayers") or {}
		if spectatingPlayers then
			for m, n in pairs(spectatingPlayers) do
				if isElement(n) then
					nearbyPlayersCount = nearbyPlayersCount + 1
				end
			end
		end
		local adminDuty = getElementData(localPlayer, "adminDuty") or 0
		local adminLevel = getElementData(localPlayer, "acc.adminLevel") or 0
		local adminNick = getElementData(localPlayer, "acc.adminNick")
		local color = "#ffffff"
		local adminTitle = sightexports.sAdministration:getPlayerAdminTitle(localPlayer, true) or "Admin"
		if adminDuty ~= 0 or 6 <= adminLevel and not togColorOOC then
			color = colors[adminLevel]
			sourcePlayerName = adminTitle .. " " .. adminNick
		end
		if 0 < nearbyPlayersCount then
			triggerServerEvent("onOOCMessage", localPlayer, playersTable, sourcePlayerName, message, color)
		end
	end
end
addCommandHandler("b", onOOCChat)
addCommandHandler("LocalOOC", onOOCChat)
bindKey("b", "down", "chatbox", "LocalOOC ")
function togColorFA()
	if sightexports.sPermission:hasPermission(localPlayer, "togcolorooc") then
		togColorOOC = not togColorOOC
		local statusText = togColorOOC and "#d75959kikapcsolva" or "[color=sightgreen]bekapcsolva"
		outputChatBox("[color=sightgreen][SightMTA]: #ffffffOOC Chat szín " .. statusText, 255, 255, 255, true)
	end
end
addCommandHandler("togcolorooc", togColorFA)
function localActionC(thePlayer, message)
	localAction(thePlayer, message)
end
function localActionAC(thePlayer, message)
	localActionA(thePlayer, message)
end
function sendLocalDoC(thePlayer, message)
	localDo(thePlayer, message)
end
addEvent("sendLocalDoC", true)
addEventHandler("sendLocalDoC", root, sendLocalDoC)
function sendLocalSay(thePlayer, message)
	sendSay(thePlayer, message)
end
addCommandHandler("say", function(commandName, ...)
	if getElementData(localPlayer, "loggedIn") then
		local message = table.concat({
			...
		}, " ")
		sendSay(localPlayer, message)
	end
end)
local lastWindowSet = 0
addEvent("playWindowSound", true)
addEventHandler("playWindowSound", getRootElement(), function(type)
	if type == "2d" then
		playSound("files/window.mp3")
	else
		local x, y, z = getElementPosition(source)
		local s = playSound3D("files/window.mp3", x, y, z)
		setSoundMaxDistance(s, 5)
	end
end)
local noWindowVehicles = {
	[424] = true,
	[457] = true,
	[486] = true,
	[500] = true,
	[504] = true,
	[530] = true,
	[531] = true,
	[539] = true,
	[568] = true,
	[571] = true,
	[572] = true
}
addEventHandler("onClientElementDataChange", getRootElement(), function(data)
	if data == "vehicle.window.2" or data == "vehicle.window.3" or data == "vehicle.window.4" or data == "vehicle.window.5" then
		for k = 2, 5 do
			local state = getElementData(source, "vehicle.window." .. k)
			setVehicleWindowOpen(source, k, state)
		end
	end
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function(data)
	for k, v in ipairs(getElementsByType("vehicle")) do
		for k = 2, 5 do
			local state = getElementData(v, "vehicle.window." .. k)
			setVehicleWindowOpen(v, k, state)
		end
	end
end)
local smileysMeaning = {
	"nevet",
	"szakad a röhögéstől",
	"elpirul",
	"nyelvet ölt",
	"szomorú",
	"szomorú",
	"mosolyog",
	"vidám",
	"kacsint",
	"kacsint",
	"mérges",
	"nagyot kacsint",
	"nagyot kacsint",
	"szakad a röhögéstől",
	"szakad a röhögéstől",
	"szakad a röhögéstől",
	"vihog",
	"sír",
	"sóhajt",
	"meglepődik"
}
local smileys = {
	":D",
	"xD",
	":$",
	":P",
	":(",
	":-(",
	":)",
	":-)",
	";)",
	";-)",
	":@",
	";D",
	";-D",
	"xd",
	"XD",
	"Xd",
	"^^",
	":'(",
	"-.-",
	":O"
}
function literalize(str)
	return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c)
		return "%" .. c
	end)
end
local talkingAnims = {}
function loadedChatAnims()
	talkingAnims = sightexports.sDashboard:getChatAnims()
end
local talkAnims = {}
function renderTalkAnims()
	for i = #talkAnims, 1, -1 do
		local player = talkAnims[i][1]
		if isElement(player) then
			if talkAnims[i][2] <= getTickCount() then
				if not talkAnims[i][3] then
					talkAnims[i][3] = 1
					setPedAnimation(player, talkingAnims[1][1], talkingAnims[1][2], 100, false, false, false, true)
				else
					setPedAnimation(player)
					table.remove(talkAnims, i)
				end
			end
		else
			table.remove(talkAnims, i)
		end
	end
	sightlangCondHandl0(0 < #talkAnims)
end
function applyChatAnim(player, animId, time)
	if getElementHealth(player) <= 20 then
		return
	end
	if getPedSimplestTask(player) == "TASK_SIMPLE_CAR_GET_IN" or getPedSimplestTask(player) == "TASK_SIMPLE_CAR_GET_OUT" or getPedSimplestTask(player) == "TASK_SIMPLE_GO_TO_POINT" then
		return
	end
	if getElementData(player, "customAnim") then
		return
	end
	local a1, a2 = getPedAnimation(player)
	if a1 then
		local talkAnim = false
		for i = 1, #talkingAnims do
			if a1 == talkingAnims[i][1] and a2 == talkingAnims[i][2] then
				talkAnim = true
				break
			end
		end
		if not talkAnim then
			return
		end
	end
	local anim = talkingAnims[animId] or {}
	if anim[1] then
		setPedAnimation(player, anim[1], anim[2], 0, true, true, false, true)
	end
	table.insert(talkAnims, {
		player,
		getTickCount() + time
	})
	sightlangCondHandl0(0 < #talkAnims)
end
addEvent("applyChatAnim", true)
addEventHandler("applyChatAnim", getRootElement(), function(id, time)
	applyChatAnim(source, id, time)
end)
function isWindowlessVehicle(veh)
	return getVehicleType(veh) == "Bike" or getVehicleType(veh) == "BMX" or getVehicleType(veh) == "Quad" or getVehicleType(veh) == "Boat"
end
function sendSay(thePlayer, message)
	if string.len(message) > 0 then
		message = utf8.gsub(message, "#%x%x%x%x%x%x", "")
		message = utf8.gsub(message, "%[color%=[a-zA-Z1-9%-]*%]", "")
		local playersTable = {}
		local nearbyPlayersCount = 0
		local invehicle = ""
		local adminDuty = getElementData(localPlayer, "adminDuty") or 0
		if thePlayer ~= localPlayer then
			adminDuty = 0
		end
		if adminDuty == 0 then
			local laughAnim = false
			for i = 1, #smileys do
				if utf8.find(message, smileys[i], 1, true) then
					localActionC(thePlayer, smileysMeaning[i])
					message = utf8.gsub(message, literalize(smileys[i]), "")
					if smileysMeaning[i] == "nevet" or smileysMeaning[i] == "szakad a röhögéstől" then
						laughAnim = true
					end
				end
			end
			if laughAnim then
				triggerServerEvent("laughAnim", thePlayer)
			end
		end
		local inVehicle = ""
		local msgForCount = utf8.gsub(message, " ", "")
		if 0 < utf8.len(msgForCount) then
			local sourcePlayerName = utf8.gsub(getElementData(thePlayer, "visibleName"), "_", " ")
			local sourceX, sourceY, sourceZ = getElementPosition(thePlayer)
			local veh = getPedOccupiedVehicle(thePlayer)
			if veh and isWindowlessVehicle(veh) then
				veh = false
			end
			if veh and not getElementData(veh, "vehicle.windowState") then
				inVehicle = " (járműben)"
				for k, v in pairs(getVehicleOccupants(veh)) do
					if v ~= thePlayer then
						table.insert(playersTable, {v, "#FFFFFF"})
						nearbyPlayersCount = nearbyPlayersCount + 1
					end
				end
			else
				local players = getElementsByType("player", getRootElement(), true)
				for k = 1, #players do
					local v = players[k]
					if v ~= localPlayer then
						local targetX, targetY, targetZ = getElementPosition(v)
						local max = 12
						local vh = getPedOccupiedVehicle(v)
						if vh and not getElementData(vh, "vehicle.windowState") then
							max = 8
						end
						if max >= getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) then
							local color = 255
							color = 50 + 205 * (1 - getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) / max)
							table.insert(playersTable, {
								v,
								string.format("#%.2X%.2X%.2X", color, color, color)
							})
							nearbyPlayersCount = nearbyPlayersCount + 1
						end
					end
				end
			end
			local adminLevel = getElementData(localPlayer, "acc.adminLevel") or 0
			local color = "#FFFFFF"
			local adminTitle = sightexports.sAdministration:getPlayerAdminTitle(localPlayer, true) or "Admin"
			if adminDuty == 0 or thePlayer ~= localPlayer then
				outputChatBox("#FFFFFF" .. sourcePlayerName .. " mondja" .. inVehicle .. ": " .. firstToUpper(message), 231, 217, 176, true)
			else
				sourcePlayerName = getElementData(localPlayer, "acc.adminNick") or "Admin"
				color = "#FFFFFF"
				if colors[adminLevel] then
					color = "[color=" .. colors[adminLevel] .. "]"
				end
				outputChatBox(color .. "[ADMIN] " .. adminTitle .. " " .. sourcePlayerName .. " mondja" .. inVehicle .. ": " .. firstToUpper(message), 231, 217, 176, true)
			end
			local spectatingPlayers = getElementData(localPlayer, "spectatingPlayers") or {}
			if spectatingPlayers then
				for m, n in pairs(spectatingPlayers) do
					if isElement(n) then
						nearbyPlayersCount = nearbyPlayersCount + 1
					end
				end
			end
			if 0 < nearbyPlayersCount then
				local anim = sightexports.sDashboard:getCurrentChatAnim()
				triggerServerEvent("onLocalMessage", localPlayer, playersTable, sourcePlayerName, message, inVehicle, adminDuty, adminTitle, color, thePlayer, anim)
				if anim then
					applyChatAnim(localPlayer, anim, utf8.len(message) * 200)
				end
			elseif sightexports.sDashboard:getCurrentChatAnim() then
				applyChatAnim(localPlayer, sightexports.sDashboard:getCurrentChatAnim(), utf8.len(message) * 200)
			end
		end
	end
end
addCommandHandler("c", function(commandName, ...)
	if getElementData(localPlayer, "loggedIn") then
		local message = table.concat({
			...
		}, " ")
		if not (...) then
			outputChatBox("[color=sightgreen][SightMTA - Chat]: #ffffff/" .. commandName .. " [szöveg]", 255, 194, 14, true)
		else
			local playersTable = {}
			message = utf8.gsub(message, "#%x%x%x%x%x%x", "")
			message = utf8.gsub(message, "%[color%=[a-zA-Z1-9%-]*%]", "")
			local nearbyPlayersCount = 0
			local invehicle = ""
			local thePlayer = localPlayer
			local laughAnim = false
			for i = 1, #smileys do
				if utf8.find(message, smileys[i], 1, true) then
					localActionLow(thePlayer, smileysMeaning[i])
					message = utf8.gsub(message, literalize(smileys[i]), "")
					if smileysMeaning[i] == "nevet" or smileysMeaning[i] == "szakad a röhögéstől" then
						laughAnim = true
					end
				end
			end
			if laughAnim then
				triggerServerEvent("laughAnim", thePlayer)
			end
			local inVehicle = " (suttogva)"
			local msgForCount = utf8.gsub(message, " ", "")
			if 0 < utf8.len(msgForCount) then
				local sourcePlayerName = utf8.gsub(getElementData(thePlayer, "visibleName"), "_", " ")
				local sourceX, sourceY, sourceZ = getElementPosition(thePlayer)
				local veh = getPedOccupiedVehicle(thePlayer)
				if veh and not getElementData(veh, "vehicle.windowState") then
					inVehicle = " (suttogva, járműben)"
					for k, v in pairs(getVehicleOccupants(veh)) do
						if v ~= thePlayer then
							table.insert(playersTable, {v, "#FFFFFF"})
							nearbyPlayersCount = nearbyPlayersCount + 1
						end
					end
				else
					local players = getElementsByType("player", getRootElement(), true)
					for k = 1, #players do
						local v = players[k]
						if v ~= localPlayer then
							local targetX, targetY, targetZ = getElementPosition(v)
							local max = 4
							local vh = getPedOccupiedVehicle(v)
							if vh and not getElementData(vh, "vehicle.windowState") then
								return
							end
							if max >= getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) then
								local color = 255
								color = 70 + 185 * (getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) / max)
								table.insert(playersTable, {
									v,
									string.format("#%.2X%.2X%.2X", color, color, color)
								})
								nearbyPlayersCount = nearbyPlayersCount + 1
							end
						end
					end
				end
				outputChatBox("#FFFFFF" .. sourcePlayerName .. " mondja" .. inVehicle .. ": " .. firstToUpper(message), 231, 217, 176, true)
				local spectatingPlayers = getElementData(localPlayer, "spectatingPlayers") or {}
				if spectatingPlayers then
					for m, n in pairs(spectatingPlayers) do
						if isElement(n) then
							nearbyPlayersCount = nearbyPlayersCount + 1
						end
					end
				end
				if 0 < nearbyPlayersCount then
					triggerServerEvent("onLocalMessage", localPlayer, playersTable, sourcePlayerName, message, inVehicle, 0, 0, color, true)
				end
			end
		end
	end
end)
function localActionLow(playerSource, message)
	if string.len(message) > 0 then
		local playersTable = {}
		local nearbyPlayersCount = 0
		local sourcePlayerName = utf8.gsub(getElementData(playerSource, "visibleName"), "_", " ")
		local sourceX, sourceY, sourceZ = getElementPosition(playerSource)
		local thePlayer = getElementType(playerSource) == "ped" and localPlayer or playerSource
		local players = getElementsByType("player", getRootElement(), true)
		for k = 1, #players do
			local v = players[k]
			if v ~= thePlayer then
				local targetX, targetY, targetZ = getElementPosition(v)
				if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 6 then
					table.insert(playersTable, v)
					nearbyPlayersCount = nearbyPlayersCount + 1
				end
			end
		end
		local spectatingPlayers = getElementData(localPlayer, "spectatingPlayers") or {}
		if spectatingPlayers then
			for m, n in pairs(spectatingPlayers) do
				if isElement(n) then
					nearbyPlayersCount = nearbyPlayersCount + 1
				end
			end
		end
		outputChatBox("#DBC5EB*** [LOW] " .. sourcePlayerName .. " #DBC5EB" .. message, 219, 197, 235, true)
		if 0 < nearbyPlayersCount then
			triggerServerEvent("onActionMessageLow", thePlayer, playersTable, sourcePlayerName, message)
		end
	end
end
function localActionA(playerSource, message)
	if string.len(message) > 0 then
		local playersTable = {}
		message = utf8.gsub(message, "#%x%x%x%x%x%x", "")
		message = utf8.gsub(message, "%[color%=[a-zA-Z1-9%-]*%]", "")
		local nearbyPlayersCount = 0
		local sourcePlayerName = utf8.gsub(getElementData(playerSource, "visibleName"), "_", " ")
		local sourceX, sourceY, sourceZ = getElementPosition(playerSource)
		local thePlayer = getElementType(playerSource) == "ped" and localPlayer or playerSource
		local players = getElementsByType("player", getRootElement(), true)
		for k = 1, #players do
			local v = players[k]
			if v ~= thePlayer then
				local targetX, targetY, targetZ = getElementPosition(v)
				if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 12 then
					table.insert(playersTable, v)
					nearbyPlayersCount = nearbyPlayersCount + 1
				end
			end
		end
		local spectatingPlayers = getElementData(localPlayer, "spectatingPlayers") or {}
		if spectatingPlayers then
			for m, n in pairs(spectatingPlayers) do
				if isElement(n) then
					nearbyPlayersCount = nearbyPlayersCount + 1
				end
			end
		end
		outputChatBox("#956CB4>> " .. sourcePlayerName .. " #956CB4" .. message, 194, 162, 218, true)
		if 0 < nearbyPlayersCount then
			triggerServerEvent("onActionMessageA", thePlayer, playersTable, sourcePlayerName, message)
		end
	end
end
function localAction(playerSource, message)
	if string.len(message) > 0 then
		local playersTable = {}
		message = utf8.gsub(message, "#%x%x%x%x%x%x", "")
		message = utf8.gsub(message, "%[color%=[a-zA-Z1-9%-]*%]", "")
		local nearbyPlayersCount = 0
		local sourcePlayerName = utf8.gsub(getElementData(playerSource, "visibleName"), "_", " ")
		local sourceX, sourceY, sourceZ = getElementPosition(playerSource)
		local thePlayer = getElementType(playerSource) == "ped" and localPlayer or playerSource
		local players = getElementsByType("player", getRootElement(), true)
		for k = 1, #players do
			local v = players[k]
			if v ~= thePlayer then
				local targetX, targetY, targetZ = getElementPosition(v)
				if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 12 then
					table.insert(playersTable, v)
					nearbyPlayersCount = nearbyPlayersCount + 1
				end
			end
		end
		local spectatingPlayers = getElementData(localPlayer, "spectatingPlayers") or {}
		if spectatingPlayers then
			for m, n in pairs(spectatingPlayers) do
				if isElement(n) then
					nearbyPlayersCount = nearbyPlayersCount + 1
				end
			end
		end
		outputChatBox("#C2A2DA*** " .. sourcePlayerName .. " #C2A2DA" .. message, 194, 162, 218, true)
		if 0 < nearbyPlayersCount then
			triggerServerEvent("onActionMessage", thePlayer, playersTable, sourcePlayerName, message)
		end
	end
end
addEvent("localActionC", true)
addEventHandler("localActionC", getRootElement(), function(message)
	localAction(localPlayer, message)
end)
addEvent("localChatC", true)
addEventHandler("localChatC", getRootElement(), function(message)
	sendSay(localPlayer, message)
end)
addCommandHandler("me", function(commandName, ...)
	if getElementData(localPlayer, "loggedIn") then
		if not (...) then
			outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Üzenet]", 255, 255, 255, true)
		else
			local message = table.concat({
				...
			}, " ")
			if 0 < #message and 0 < string.len(message) then
				localAction(localPlayer, message)
			end
		end
	end
end)
addCommandHandler("melow", function(commandName, ...)
	if getElementData(localPlayer, "loggedIn") then
		if not (...) then
			outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Üzenet]", 255, 255, 255, true)
		else
			local message = table.concat({
				...
			}, " ")
			message = utf8.gsub(message, "#%x%x%x%x%x%x", "")
			message = utf8.gsub(message, "%[color%=[a-zA-Z1-9%-]*%]", "")
			if 0 < #message and 0 < string.len(message) then
				localActionLow(localPlayer, message)
			end
		end
	end
end)
addCommandHandler("ame", function(commandName, ...)
	if getElementData(localPlayer, "loggedIn") then
		if not (...) then
			outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Üzenet]", 255, 255, 255, true)
		else
			local message = table.concat({
				...
			}, " ")
			message = utf8.gsub(message, "#%x%x%x%x%x%x", "")
			message = utf8.gsub(message, "%[color%=[a-zA-Z1-9%-]*%]", "")
			if 0 < #message and 0 < string.len(message) then
				localActionA(localPlayer, message)
			end
		end
	end
end)
function localDo(playerSource, message)
	if string.len(message) > 0 then
		local playersTable = {}
		message = utf8.gsub(message, "#%x%x%x%x%x%x", "")
		message = utf8.gsub(message, "%[color%=[a-zA-Z1-9%-]*%]", "")
		local nearbyPlayersCount = 0
		local sourcePlayerName = utf8.gsub(getElementData(playerSource, "visibleName"), "_", " ")
		local sourceX, sourceY, sourceZ = getElementPosition(playerSource)
		local thePlayer = getElementType(playerSource) == "ped" and localPlayer or playerSource
		local players = getElementsByType("player", getRootElement(), true)
		for k = 1, #players do
			local v = players[k]
			if v ~= thePlayer then
				local targetX, targetY, targetZ = getElementPosition(v)
				if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 12 then
					table.insert(playersTable, v)
					nearbyPlayersCount = nearbyPlayersCount + 1
				end
			end
		end
		local spectatingPlayers = getElementData(localPlayer, "spectatingPlayers") or {}
		if spectatingPlayers then
			for m, n in pairs(spectatingPlayers) do
				if isElement(n) then
					nearbyPlayersCount = nearbyPlayersCount + 1
				end
			end
		end
		outputChatBox(" *" .. firstToUpper(message) .. " ((#FF2850" .. sourcePlayerName .. "))", 255, 40, 80, true)
		if 0 < nearbyPlayersCount then
			triggerServerEvent("onDoMessage", thePlayer, playersTable, sourcePlayerName, message)
		end
	end
end
addEvent("localDoC", true)
addEventHandler("localDoC", getRootElement(), function(message)
	localDo(localPlayer, message)
end)
function localDoLow(playerSource, message)
	if string.len(message) > 0 then
		local playersTable = {}
		local nearbyPlayersCount = 0
		local sourcePlayerName = utf8.gsub(getElementData(playerSource, "visibleName"), "_", " ")
		local sourceX, sourceY, sourceZ = getElementPosition(playerSource)
		local thePlayer = getElementType(playerSource) == "ped" and localPlayer or playerSource
		local players = getElementsByType("player", getRootElement(), true)
		for k = 1, #players do
			local v = players[k]
			if v ~= thePlayer then
				local targetX, targetY, targetZ = getElementPosition(v)
				if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 12 then
					table.insert(playersTable, v)
					nearbyPlayersCount = nearbyPlayersCount + 1
				end
			end
		end
		local spectatingPlayers = getElementData(localPlayer, "spectatingPlayers") or {}
		if spectatingPlayers then
			for m, n in pairs(spectatingPlayers) do
				if isElement(n) then
					nearbyPlayersCount = nearbyPlayersCount + 1
				end
			end
		end
		outputChatBox("[LOW] *" .. firstToUpper(message) .. " ((#ff6682" .. sourcePlayerName .. "))", 255, 102, 130, true)
		if 0 < nearbyPlayersCount then
			triggerServerEvent("onDoMessageLow", thePlayer, playersTable, sourcePlayerName, message)
		end
	end
end
addCommandHandler("dolow", function(commandName, ...)
	if getElementData(localPlayer, "loggedIn") then
		if not (...) then
			outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Üzenet]", 255, 255, 255, true)
		else
			local message = table.concat({
				...
			}, " ")
			message = utf8.gsub(message, "#%x%x%x%x%x%x", "")
			message = utf8.gsub(message, "%[color%=[a-zA-Z1-9%-]*%]", "")
			if 0 < #message and 0 < string.len(message) then
				localDoLow(localPlayer, message)
			end
		end
	end
end)
addCommandHandler("do", function(commandName, ...)
	if getElementData(localPlayer, "loggedIn") then
		if not (...) then
			outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Üzenet]", 255, 255, 255, true)
		else
			local message = table.concat({
				...
			}, " ")
			if 0 < #message and 0 < string.len(message) then
				localDo(localPlayer, message)
			end
		end
	end
end)
addCommandHandler("m", function(commandName, ...)
	if getElementData(localPlayer, "loggedIn") and sightexports.sGroups:getPlayerPermission("megaphone") then
		if not (...) then
			outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Üzenet]", 255, 255, 255, true)
		else
			local message = table.concat({
				...
			}, " ")
			if 0 < #message and 0 < utfLen(message) then
				triggerServerEvent("onMegaPhoneMessage", localPlayer, playersTable, sourcePlayerName, message, commandName)
			end
		end
	end
end)
function tryCommand(commandName, ...)
	if getElementData(localPlayer, "loggedIn") then
		if not (...) then
			outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Üzenet]", 255, 255, 255, true)
		else
			local message = table.concat({
				...
			}, " ")
			if 0 < #message and 0 < string.len(message) then
				local playersTable = {}
				message = utf8.gsub(message, "#%x%x%x%x%x%x", "")
				message = utf8.gsub(message, "%[color%=[a-zA-Z1-9%-]*%]", "")
				local number = math.random(1, 2)
				local nearbyPlayersCount = 0
				local sourcePlayerName = utf8.gsub(getElementData(localPlayer, "visibleName"), "_", " ")
				local sourceX, sourceY, sourceZ = getElementPosition(localPlayer)
				local players = getElementsByType("player", getRootElement(), true)
				for k = 1, #players do
					local v = players[k]
					if v ~= localPlayer then
						local targetX, targetY, targetZ = getElementPosition(v)
						if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 12 then
							table.insert(playersTable, v)
							nearbyPlayersCount = nearbyPlayersCount + 1
						end
					end
				end
				if commandName == "megprobal" or commandName == "megpróbál" then
					if number == 1 then
						outputChatBox("[color=sightgreen] *** " .. sourcePlayerName .. " megpróbál " .. message .. " és sikerül neki.", 0, 230, 0, true)
					elseif number == 2 then
						outputChatBox("[color=sightred] *** " .. sourcePlayerName .. " megpróbál " .. message .. ", de sajnos nem sikerül neki.", 230, 0, 0, true)
					end
				elseif commandName == "megprobalja" or commandName == "megpróbálja" then
					if number == 1 then
						outputChatBox("[color=sightgreen] *** " .. sourcePlayerName .. " megpróbálja " .. message .. " és sikerül neki.", 0, 230, 0, true)
					elseif number == 2 then
						outputChatBox("[color=sightred] *** " .. sourcePlayerName .. " megpróbálja " .. message .. ", de sajnos nem sikerül neki.", 230, 0, 0, true)
					end
				end
				local spectatingPlayers = getElementData(localPlayer, "spectatingPlayers") or {}
				if spectatingPlayers then
					for m, n in pairs(spectatingPlayers) do
						if isElement(n) then
							nearbyPlayersCount = nearbyPlayersCount + 1
						end
					end
				end
				if 0 < nearbyPlayersCount then
					triggerServerEvent("onTryMessage", localPlayer, playersTable, sourcePlayerName, message, number, commandName)
				end
			end
		end
	end
end
addCommandHandler("megprobal", tryCommand)
addCommandHandler("megpróbál", tryCommand)
addCommandHandler("megprobalja", tryCommand)
addCommandHandler("megpróbálja", tryCommand)
function firstToUpper(str)
	return (utf8.gsub(str, "^%l", utf8.upper))
end
function RGBToHex(red, green, blue, alpha)
	if red < 0 or 255 < red or green < 0 or 255 < green or blue < 0 or 255 < blue or alpha and (alpha < 0 or 255 < alpha) then
		return nil
	end
	if alpha then
		return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)
	else
		return string.format("#%.2X%.2X%.2X", red, green, blue)
	end
end
addCommandHandler("s", function(commandName, ...)
	if getElementData(localPlayer, "loggedIn") then
		if not (...) then
			outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Üzenet]", 255, 255, 255, true)
		else
			local message = table.concat({
				...
			}, " ")
			message = utf8.gsub(message, "#%x%x%x%x%x%x", "")
			message = utf8.gsub(message, "%[color%=[a-zA-Z1-9%-]*%]", "")
			if 0 < #message and 0 < string.len(message) then
				local interior, theType = sightexports.sInteriors:getCurrentStandingInterior()
				if interior then
					triggerServerEvent("shoutInterior", localPlayer, message, interior, theType)
				else
					local playersTable = {}
					local nearbyPlayersCount = 0
					local sourcePlayerName = utf8.gsub(getElementData(localPlayer, "visibleName"), "_", " ")
					local sourceX, sourceY, sourceZ = getElementPosition(localPlayer)
					local players = getElementsByType("player", getRootElement(), true)
					for k = 1, #players do
						local v = players[k]
						if v ~= localPlayer then
							local targetX, targetY, targetZ = getElementPosition(v)
							if getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) <= 30 then
								table.insert(playersTable, v)
								nearbyPlayersCount = nearbyPlayersCount + 1
							end
						end
					end
					local nameData = getElementData(localPlayer, "visibleName") or getPlayerName(localPlayer)
					local name = utf8.gsub(nameData, "_", " ")
					outputChatBox("#FFFFF0" .. name .. " ordítja: " .. message, 194, 162, 218, true)
					triggerServerEvent("shoutNormal", localPlayer, playersTable, message)
				end
			end
		end
	end
end)
function clearChat()
	clearChatBox()
	outputChatBox("[color=sightgreen][SighMTA]: [color=hudwhite]Jó szórakozást kívánunk!")
end
addCommandHandler("clearchat", clearChat)
addCommandHandler("cc", clearChat)