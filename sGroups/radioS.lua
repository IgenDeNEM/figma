addCommandHandler("tuneradio",
function(player, cmd, radio1)
	local radioData = getElementData(player, "char.Radio") or {}
	local radio1 = tonumber(radio1)
	local radio2 = radioData[2] and tonumber(radioData[2]) or false
	
	if not radio1 then
		outputChatBox("[color=sightred][SightMTA - Rádió]: [color=hudwhite]/"..cmd.." [Frekvencia]", player)
		return
	end
	
	if protectedRadios[radio1] then
		if not isPlayerInGroup(player, protectedRadios[radio1]) then
			outputChatBox("[color=sightred][SightMTA - Rádió]: #ffffffEz védett frekvencia!", player)
		else
			outputChatBox("[color=sighgreen][SightMTA - Rádió]: #ffffffSikeresen beállítottad az elsődleges rádió frekvenciát", player)
			setElementData(player, "char.Radio", {radio1, radio2})
			triggerClientEvent(player, "gotWalkieTalkieFrequencies", player, radio1, radio2)
		end
	else
		outputChatBox("[color=sightgreen][SightMTA - Rádió]: #ffffffSikeresen beállítottad az elsődleges rádió frekvenciát", player)
		setElementData(player, "char.Radio", {radio1, radio2})
		triggerClientEvent(player, "gotWalkieTalkieFrequencies", player, radio1, radio2)
	end
end
)

addCommandHandler("tuneradio2",
function(player, cmd, radio2)
	local radioData = getElementData(player, "char.Radio") or {}
	local radio1 = radioData[1] and tonumber(radioData[1]) or false
	local radio2 = tonumber(radio2)
	
	if not radio2 then
		outputChatBox("[color=sightblue][SightMTA - Rádió]: [color=hudwhite]/"..cmd.." [Frekvencia]", player)
		return
	end
	
	if protectedRadios[radio2] and not isPlayerInGroup(player, protectedRadios[radio2]) then
		outputChatBox("[color=sightred][SightMTA - Rádió]: #ffffffEz védett frekvencia!", player)
	else
		outputChatBox("[color=sightgreen][SightMTA - Rádió]: #ffffffSikeresen beállítottad a másodlagos rádió frekvenciát", player)
		setElementData(player, "char.Radio", {radio1, radio2})
		triggerClientEvent(player, "gotWalkieTalkieFrequencies", player, radio1, radio2)
	end
end
)

addEventHandler("onResourceStart", resourceRoot,
function()
	setTimer(
	function()
		for k, v in pairs(getElementsByType("player")) do
			local radioData = getElementData(v, "char.Radio")
			if radioData then
				local radio1 = radioData[1] or false
				local radio2 = radioData[2]	or false
				
				if radio1 or radio2 then
					triggerClientEvent(v, "gotWalkieTalkieFrequencies", v, radio1, radio2)
				end
			end
		end
	end,
	1, 1)
end
)

function onAirRadio(sourcePlayer, message, vehs)
	if isElement(sourcePlayer) then
		local vehOfDriver = getPedOccupiedVehicle(sourcePlayer)
		local modelName = exports.sVehiclenames:getCustomVehicleName(getElementModel(vehOfDriver))
		local name = getElementData(sourcePlayer, "visibleName"):gsub("_", " ")
		local plate = getVehiclePlateText(vehOfDriver)
		
		plate = split(plate, "-")
		local tmp = {}
		
		for k = 1, #plate do
			if utf8.len(plate[k]) > 0 then
				table.insert(tmp, plate[k])
			end
		end
		plate = table.concat(plate, "-")
		for _, player in pairs(getElementsByType("player")) do
			local x, y, z = getElementPosition(player)
			for k = 1, #vehs do
				local veh = vehs[k]
				if getPedOccupiedVehicle(player) == veh then
					local x2, y2, z2 = getElementPosition(vehOfDriver)
					local dist = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
					local progress = 1 - dist / 1000
					local r, g, b = 49, 154, 215
					local model = getElementModel(vehOfDriver)
					if model == 497 or model == 488 or model == 425 or model == 548 or model == 520 then
						r, g, b = 215, 89, 89
					end
					outputChatBox("[Légi Rádió] " .. name .. " (" .. modelName .. "-" .. plate .. "): " .. message, player, r * progress, g * progress, b * progress)
					triggerClientEvent(player, "playWalkieTalkieSound", player)
				else
					local x2, y2, z2 = getElementPosition(veh)
					local dist = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
					if dist < 6 then
						local color = interpolateBetween(255, 0, 0, 50, 0, 0, dist / 6, "Linear")
						outputChatBox("[Légi Rádió] " .. name .. " (" .. modelName .. "-" .. plate .. "): " .. message, player, color, color, color)
					end
				end
			end
		end
	end
end

function onBoatRadio(sourcePlayer, message, vehs)
	if isElement(sourcePlayer) then
		local vehOfDriver = getPedOccupiedVehicle(sourcePlayer)
		local modelName = exports.sVehiclenames:getCustomVehicleName(getElementModel(vehOfDriver))
		local name = getElementData(sourcePlayer, "visibleName"):gsub("_", " ")
		local plate = getVehiclePlateText(vehOfDriver)
		
		plate = split(plate, "-")
		local tmp = {}
		
		for k = 1, #plate do
			if utf8.len(plate[k]) > 0 then
				table.insert(tmp, plate[k])
			end
		end
		plate = table.concat(plate, "-")
		for _, player in pairs(getElementsByType("player")) do
			local x, y, z = getElementPosition(player)
			for k = 1, #vehs do
				local veh = vehs[k]
				if getPedOccupiedVehicle(player) == veh then
					local x2, y2, z2 = getElementPosition(vehOfDriver)
					local dist = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
					local progress = 1 - dist / 1000
					local r, g, b = 49, 154, 215
					local model = getElementModel(vehOfDriver)
					if model == 472 then
						r, g, b = 215, 89, 89
					end
					outputChatBox("[Hajó Rádió] " .. name .. " (" .. modelName .. "-" .. plate .. "): " .. message, player, r * progress, g * progress, b * progress)
					triggerClientEvent(player, "playWalkieTalkieSound", player)
				else
					local x2, y2, z2 = getElementPosition(veh)
					local dist = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
					if dist < 6 then
						local color = interpolateBetween(255, 0, 0, 50, 0, 0, dist / 6, "Linear")
						outputChatBox("[Hajó Rádió] " .. name .. " (" .. modelName .. "-" .. plate .. "): " .. message, player, color, color, color)
					end
				end
			end
		end
	end
end

addCommandHandler("ar", 
function(sourcePlayer, commandName, ...)
	local message = table.concat({...}, " ")
	
	if not (...) or utf8.len(message) < 1 then
		outputChatBox("[color=sightblue][SightMTA - Rádió]: [color=hudwhite]/" .. commandName .. " [Üzenet]", sourcePlayer, 0, 0, 0, true)
	else
		if not isPedInVehicle(sourcePlayer) then
			outputChatBox("[color=sightred][SightMTA - Rádió]: [color=hudwhite]Nem ülsz járműben!", sourcePlayer, 0, 0, 0, true)
			return
		end
		if getVehicleType(getPedOccupiedVehicle(sourcePlayer)) == "Plane" or getVehicleType(getPedOccupiedVehicle(sourcePlayer)) == "Helicopter" then

			local px, py, pz = getElementPosition(sourcePlayer)

			local streamedAirVehicles = {}
			for k, v in ipairs(getElementsByType("vehicle")) do
				if getVehicleType(v) == "Plane" or getVehicleType(v) == "Helicopter" then
					local x, y, z = getElementPosition(v)
					if getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 200 then
						table.insert(streamedAirVehicles, v)
					end
				end
			end
			onAirRadio(sourcePlayer, message, streamedAirVehicles)
		else
			outputChatBox("[color=sightred][SightMTA - Rádió]: [color=hudwhite]Ebben a járműben nincs légi rádió.", sourcePlayer, 0, 0, 0, true)
		end
	end
end)

addCommandHandler("hr", 
function(sourcePlayer, commandName, ...)
	local message = table.concat({...}, " ")
	
	if not (...) or utf8.len(message) < 1 then
		outputChatBox("[color=sightblue][SightMTA - Rádió]: [color=hudwhite]/" .. commandName .. " [Üzenet]", sourcePlayer, 0, 0, 0, true)
	else
		if not isPedInVehicle(sourcePlayer) then
			outputChatBox("[color=sightred][SightMTA]: [color=hudwhite]Nem ülsz járműben!", sourcePlayer, 0, 0, 0, true)
			return
		end
		if getVehicleType(getPedOccupiedVehicle(sourcePlayer)) == "Boat" then

			local px, py, pz = getElementPosition(sourcePlayer)

			local streamedAirVehicles = {}
			for k, v in ipairs(getElementsByType("vehicle")) do
				if getVehicleType(v) == "Boat" then
					local x, y, z = getElementPosition(v)
					if getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 200 then
						table.insert(streamedAirVehicles, v)
					end
				end
			end
			onBoatRadio(sourcePlayer, message, streamedAirVehicles)
		else
			outputChatBox("[color=sightblue][SightMTA]: [color=hudwhite]Ebben a járműben nincs hajó rádió.", sourcePlayer, 0, 0, 0, true)
		end
	end
end)

addEvent("sendWalkieTalkieMessage", true)
addEventHandler("sendWalkieTalkieMessage", getRootElement(),
function(playersTable, transmitFreq, message, radioType)
	local item = exports.sItems:hasItem(client, 4)
	
	if exports.sJail:isPlayerInJail(client) then
        exports.sGui:showInfobox(client, "e", "Börtönben nem használhatod a rádiót!")
        return
    end

	if item then
		local groupId = protectedRadios[transmitFreq]
		
		if groupId then
			local playerFaction = isPlayerInGroup(client, groupId)
			
			if not playerFaction then
				outputChatBox("[color=sightred][SightMTA - Rádió]: #ffffffEzt a frekvenciát csak az adott csoport tagjai használhatják!")
				return
			end
		end
		
		local affected = {}
		local players = getElementsByType("player")
		
		local selectedRadioType = "[R1] "
		
		if radioType == "r2" then
			selectedRadioType = "[R2] "
		end
		
		local color = "[color=sightblue-second]"
		
		for i = 1, #players do
			local targetPlayer = players[i]
			if exports.sItems:hasItem(targetPlayer, 4) then
				local radioData = getElementData(targetPlayer, "char.Radio") or {}
				if selectedRadioType == "[R1] " and radioData[1] and radioData[1] == transmitFreq then
					table.insert(affected, targetPlayer)
				elseif selectedRadioType == "[R2] " and radioData[2] and radioData[2] == transmitFreq then
					table.insert(affected, targetPlayer)
					color = "[color=sightblue]"
				end  
			end
		end
		
		local playerRank = ""
		local playerName = getElementData(client, "visibleName"):gsub("_", " ")
		
		if groupId then
			playerRank = getPlayerRank(groupId, client)
		end
		
		for i = 1, #affected do
			local targetPlayer = affected[i]
			if groupId and isPlayerInGroup(targetPlayer, groupId) then
				outputChatBox(color.. selectedRadioType .. playerRank .. " " .. playerName .. " mondja: " .. message,  targetPlayer, 0, 0, 0, true)
			elseif not protectedRadios[transmitFreq] then
				outputChatBox(color.. selectedRadioType .. playerName .. " mondja: " .. message,  targetPlayer, 0, 0, 0, true)
			else
				
			end
		end
		triggerClientEvent(affected, "playWalkieTalkieSound", client)
	else
		outputChatBox("[color=sightred][SightMTA - Rádió]: #ffffffNincs nálad rádió!", client)
	end
end
)

local _addCommandHandler = addCommandHandler
function addCommandHandler(cmd, ...)
	if type(cmd) == "string" then
		_addCommandHandler(cmd, ...)
	else
		for k, v in ipairs(cmd) do
			_addCommandHandler(v, ...)
		end
	end
end

local secondaryEmergency = {}

addCommandHandler("togd2", function(sourcePlayer, commandName)
	for k, v in pairs(playerGroups[sourcePlayer]) do
		if getDepRadio(k) then
			groupId = k
			break
		end
	end
	
	if not groupId then
		return
	end
	
	if not exports.sItems:hasItem(sourcePlayer, 4) then
		return
	end
	
	local radioState = secondaryEmergency[sourcePlayer] or true
	radioState = not radioState
end)

addCommandHandler({"d", "d2"}, function (sourcePlayer, commandName, ...)
	local groupId = false

	if exports.sJail:isPlayerInJail(sourcePlayer) then
        exports.sGui:showInfobox(sourcePlayer, "e", "Börtönben nem használhatod a rádiót!")
        return
    end

	
	for k, v in pairs(playerGroups[sourcePlayer]) do
		if getDepRadio(k) then
			groupId = k
			break
		end
	end
	
	if groupId then
		if not (...) then
			outputChatBox("[color=sightblue][Használat]: [color=hudwhite]/" .. commandName .. " [Üzenet]", sourcePlayer, 0, 0, 0, true)
		else
			if not exports.sItems:hasItem(sourcePlayer, 4) then
				outputChatBox("[color=sightred][SightMTA - Rádió]: [color=hudwhite]Nincs rádiód!", sourcePlayer, 0, 0, 0, true)
				return
			end
			
			if not (secondaryEmergency[sourcePlayer] or true) and commandName == "d2" then
				outputChatBox("[color=sightred][SightMTA - Rádió]: [color=hudwhite]Nincs bekapcsolva a másodlagos sürgősségi rádió! Bekapcsoláshoz: [color=sightgreen]/togd2", sourcePlayer)
				return
			end
			
			local affected = {}
			local players = getElementsByType("player")
			
			for i = 1, #players do
				local targetPlayer = players[i]
				
				if targetPlayer ~= sourcePlayer then
					if exports.sItems:hasItem(targetPlayer, 4) then
						if getPlayerPermission(targetPlayer, "departmentRadio") then
							table.insert(affected, targetPlayer)
						end
					end
				end
			end
			
			local playerName = getElementData(sourcePlayer, "visibleName"):gsub("_", " ")
			local message = utf8.gsub(table.concat({...}, " "), "#%x%x%x%x%x%x", "")
			
			local groupPrefix = groupId
			local playerRankNum = playerGroups[sourcePlayer][groupId].rank
			
			local playerRank = groupList[groupId].rankNames[playerRankNum]
			
			table.insert(affected, sourcePlayer)
			
			for i = 1, #affected do
				local targetPlayer = affected[i]
				
				if commandName == "d" then
					local radioMessage = "#d75959[" .. groupPrefix .. "] " .. playerRank .. " " .. playerName .. ": " .. message
					triggerClientEvent(targetPlayer, "gotGroupMessage", sourcePlayer, "department", nil, nil, radioMessage, "gta")
				elseif commandName == "d2" then
					local radioMessage = "#d75959[D2] [" .. groupPrefix .. "] " .. playerRank .. " " .. playerName .. ": " .. message
					triggerClientEvent(targetPlayer, "gotGroupMessage", sourcePlayer, "department2", nil, nil, radioMessage, "gta")
				elseif commandName == "ar" then
					local radioMessage = "#d75959[Légi Rádió] [" .. groupPrefix .. "] " .. playerRank .. " " .. playerName .. ": " .. message
					triggerClientEvent(targetPlayer, "gotGroupMessage", sourcePlayer, "department_airfield", nil, nil, radioMessage, "gta")
				elseif commandName == "hr" then
					local radioMessage = "#d75959[Hajó Rádió] [" .. groupPrefix .. "] " .. playerRank .. " " .. playerName .. ": " .. message
					triggerClientEvent(targetPlayer, "gotGroupMessage", sourcePlayer, "department_airfield", nil, nil, radioMessage, "gta")
				end
			end
		end
	end
end)
