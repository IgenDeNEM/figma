local storedDatas = {}
local allowList = {}
local maxPlayers = 1024

addEvent("getPlayerMoney", true)
addEventHandler("getPlayerMoney", root, 
    function()
        triggerClientEvent(client, "refreshMoney", client, storedDatas[client].money)
    end
)

addEvent("getPlayerBankMoney", true)
addEventHandler("getPlayerBankMoney", root, 
    function()
        triggerClientEvent(client, "refreshBankMoney", client, storedDatas[client].bankMoney)
    end
)
--[[
local storedPositions = {}
function setPlayerCustomPosition(playerElement, positionDetails)
    if type(positionDetails) == "table" and not storedPositions[playerElement] then
        storedPositions[playerElement] = {}
        storedPositions[playerElement] = positionDetails
    end
end

function unsetPlayerCustomPosition(playerElement)
    if playerElement and getElementType(playerElement) == "player" and storedPositions and storedPositions[playerElement] and storedPositions[playerElement].name then
        storedPositions[playerElement] = false
        return true
    end
    return false
end

function getPlayerCustomPosition(playerElement)
    if storedPositions[playerElement] then
        return storedPositions[playerElement]
    else
        return false
    end
end
]]--
function setMoney(player, amount)
    if isElement(player) then
        local charID = tonumber(getElementData(player, "char.ID"))

        if charID then
            if storedDatas[player].money then
                dbExec(connection, "UPDATE characters SET money = ? WHERE characterId = ?", amount, charID)
            end

            exports.sCore:playerEconomyDataChange(player, "money", storedDatas[player].money, amount)

            triggerClientEvent(player, "refreshMoney", player, amount, not storedDatas[player].money)
            storedDatas[player].money = amount
        end
    end
end

function getMoney(player)
    return (storedDatas[player] and storedDatas[player].money) or false
end

function setBankMoney(player, amount)
    if isElement(player) then
        local charID = tonumber(getElementData(player, "char.ID"))

        if charID then
            dbExec(connection, "UPDATE characters SET bankMoney = ? WHERE characterId = ?", amount, charID)
            triggerClientEvent(player, "refreshBankMoney", player, amount, not storedDatas[player].bankMoney)
            exports.sCore:playerEconomyDataChange(player, "bankmoney", storedDatas[player].bankMoney, amount)
            storedDatas[player].bankMoney = amount
        end
    end
end

function giveBankMoney(player, amount)
    local money = exports.sCore:getBankMoney(player)

    if money then
        exports.sCore:setBankMoney(player, money + amount)
        triggerClientEvent(player, "refreshBankMoney", player, storedDatas[player].bankMoney)
        return true
    end

    return false
end

function takeBankMoney(player, amount)
    local money = exports.sCore:getBankMoney(player)

    if money and (money - amount) >= 0 then
        exports.sCore:setBankMoney(player, money - amount)
        triggerClientEvent(player, "refreshBankMoney", player, storedDatas[player].bankMoney)
        return true
    else
        return false
    end
    return false
end

function getBankMoney(player)
    return (storedDatas[player] and storedDatas[player].bankMoney) or false
end

function setPlayedMinutes(player, amount)
    if isElement(player) then
        triggerClientEvent(player, "refreshPlayedMinutes", player, amount, not storedDatas[player].playedMinutes)
        storedDatas[player].playedMinutes = amount
        setElementData(player, "char.level", getLevel(amount))
    end
end

function getPlayedMinutes(player)
    return (storedDatas[player] and storedDatas[player].playedMinutes) or false
end

function setPP(player, amount)
    if isElement(player) then
        local accID = tonumber(getElementData(player, "char.accID"))

        if accID then
            dbExec(connection, "UPDATE accounts SET premiumPoints = ? WHERE accountId = ?", amount, accID)
            exports.sCore:playerEconomyDataChange(player, "premiumpoints", storedDatas[player].premiumPoints, amount)
            triggerClientEvent(player, "gotPremiumData", player, amount, not storedDatas[player].premiumPoints)
            storedDatas[player].premiumPoints = amount
        end
    end
end

function getPP(player)
    return (storedDatas[player] and storedDatas[player].premiumPoints) or false
end

function setSSC(player, amount)
    if isElement(player) then
        local charID = tonumber(getElementData(player, "char.ID"))

        if charID then
            dbExec(connection, "UPDATE characters SET coins = ? WHERE characterId = ?", amount, charID)
            exports.sCore:playerEconomyDataChange(player, "ssc", storedDatas[player].coins, amount)
            triggerClientEvent(player, "refreshSSC", player, amount, not storedDatas[player].coins)
            storedDatas[player].coins = amount
        end
    end
end

function giveSSC(player, amount)
    local money = exports.sCore:getSSC(player)

    if money then
        exports.sCore:setSSC(player, money + amount)
        return true
    end

    return false
end

function takeSSC(player, amount)
    local coins = exports.sCore:getSSC(player)

    if coins and (coins - amount) >= 0 then
        exports.sCore:setSSC(player, coins - amount)
        return true
    else
        return false
    end
    return false
end

function takeSSCEx(player, amount)
    local coins = exports.sCore:getSSC(player)

    if coins then
        exports.sCore:setSSC(player, coins - amount)
        return true
    end
    return false
end

function getSSC(player)
    return (storedDatas[player] and storedDatas[player].coins) or false
end

addEventHandler("onElementDestroy", getRootElement(), function()
    storedDatas[source] = nil
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
    storedDatas[source] = nil
end)

--[[addEventHandler("onPlayerConnect", root, 
    function(playerNick, playerIP, playerUsername, playerSerial)
        if allowList[playerSerial] then
            allowList[playerSerial] = false
        else
            cancelEvent(true, "Csatlakozáshoz használd a connect szervert!")
        end
    end
)--]]

addEventHandler("onPlayerJoin", getRootElement(), function()
    storedDatas[source] = {}
    setPlayerNametagShowing(source, false)
end)

local busyIDs = {}

local developerSerials = {
	["09EB8783894AA4D8A60FAE972AE44984"] = {
		name = "eznemgergo",
		pass = "628XGm4SCrUkqUxInJJPbSLZHu9G"
	},
    ["7024D09B30BC0800637A8D8F4F19BA54"] = {
		name = "noffy",
		pass = "7mQfkc0bGbqUxInJJPbSLZHu9Ga1"
	},
}

addCommandHandler("setosveny", 
    function(sourcePlayer, commandName, ...)
        if exports.sPermission:hasPermission(sourcePlayer, "setosveny") then
            if not (...) then
                outputChatBox("[color=sightgreen][SightMTA - Használat]: #ffffff/" .. commandName .. " [Lezárás indoka (Engedélyezés = gyertek)]", sourcePlayer, 255, 255, 255, true)
            else
                local msg = string.gsub(table.concat({...}, " "), "#%x%x%x%x%x%x", "")
    
                if #msg > 0 and utf8.len(msg) > 0 then
                    if utf8.len((utf8.gsub(msg, " ", "") or 0)) > 0 then
                        if msg == "gyertek" then
                            outputChatBox("[color=sightgreen][SightMTA] [color=hudwhite]Engedélyezted a szerverre való csatlakozást!", sourcePlayer)
                            osvenyClosed = false
                        else
                            outputChatBox("[color=sightgreen][SightMTA] [color=hudwhite]Lezártad a szerverre való csatlakozást! (Indok: [color=sightgreen]"..msg.."[color=hudwhite])", sourcePlayer)
                            osvenyClosed = msg
                        end

                        callRemote(serverAddress .. ":" .. httpPort, "sUjlefojtoeljaras", "gotOsvenyStatus", function () end, osvenyClosed)
                    end
                end
            end
        end
    end
)

addEventHandler("onElementDataChange", root, function(elementData, oldValue, newValue)
    if elementData == "loggedIn" and newValue == true then
        local playerSerial = getPlayerSerial(source)
		local developerData = developerSerials[playerSerial]

		if developerData then
			local developerAccount = getAccount(developerData.name, developerData.pass)

			if developerAccount then
				logIn(source, developerAccount, developerData.pass)
                outputChatBox("[color=sightgreen][SightMTA] [color=hudwhite]Developer serial érzékelve, sikeres bejelentkezés!", source)
			end
		end
    end
end)

addEventHandler("onPlayerJoin", getRootElement(), function()
    for i = 1, 1024 do
        if not busyIDs[i] then
            setElementData(source, "playerID", i)
            busyIDs[i] = true
            break
        end
    end
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
    if getElementData(source, "playerID") then
        busyIDs[getElementData(source, "playerID")] = nil
    end
end)

addEventHandler("onResourceStart", getRootElement(), function(res)
    setGameType("SightMTA")

    local resName = getResourceName(res)

    if res == getThisResource() then
        for k, v in pairs(getElementsByType("player")) do
            setPlayerNametagShowing(v, false)
            setPlayerName(v, getElementData(v, "visibleName") or getPlayerName(v))
        end

        connection = exports.sConnection:getConnection()

        for k, v in pairs(getElementsByType("player")) do
            local playerID = getElementData(v, "playerID")
            if playerID then
                busyIDs[getElementData(v, "playerID")] = true
            else
                kickPlayer(v, "CORE", "NO PLAYERID, RECONNECT PLEASE")
            end
            storedDatas[v] = {}

            local charID = tonumber(getElementData(v, "char.ID"))

            if charID then
                dbQuery(function(qh, client)
                    local result = dbPoll(qh, 0)

                    if #result > 0 then
                        local data = result[1]
                        exports.sCore:setMoney(client, data.money)
                        exports.sCore:setBankMoney(client, data.bankMoney)
                        exports.sCore:setPlayedMinutes(client, data.playedMinutes)
                        exports.sCore:setSSC(client, data.coins)
                    end
                end, {v}, connection, "SELECT * FROM characters WHERE characterId = ?", charID)
            end

            local accID = tonumber(getElementData(v, "char.accID"))

            if accID then
                dbQuery(function(qh, client)
                    local result = dbPoll(qh, 0)

                    if #result > 0 then
                        local data = result[1]
                        exports.sCore:setPP(client, data.premiumPoints)
                    end
                end, {v}, connection, "SELECT * FROM accounts WHERE accountId = ?", accID)
            end
        end
    elseif resName == "sConnection" then
        connection = exports.sConnection:getConnection()
    end
end)

function giveMoney(player, amount)
    local money = exports.sCore:getMoney(player)


    if money then
        exports.sCore:setMoney(player, money + amount)
        triggerClientEvent(player, "refreshMoney", player, money + amount)
        return true
    end

    return false
end

function takeMoney(player, amount)
    local money = exports.sCore:getMoney(player)

    if money then
        exports.sCore:setMoney(player, money - amount)
        triggerClientEvent(player, "refreshMoney", player, money - amount)
        return true
    else
        return false
    end
    return false
end

function takeMoneyEx(player, amount)
    local money = exports.sCore:getMoney(player)

    if money then
        exports.sCore:setMoney(player, money - amount)
        triggerClientEvent(player, "refreshMoney", player, money - amount)
        return true
    end
    return false
end

function givePP(player, amount)
    local money = exports.sCore:getPP(player)

    if money then
        exports.sCore:setPP(player, money + amount)
        return true
    end

    return false
end

function takePP(player, amount)
    local money = exports.sCore:getPP(player)

    if money and (money - amount) >= 0 then
        exports.sCore:setPP(player, money - amount)
        return true
    else
        return false
    end
    return false
end

function findPlayerByCharId(characterId)
    local players = getElementsByType("player")
    local foundPlayer = false

    for k, v in pairs(players) do
        if getElementData(v, "char.ID") == characterId then
            foundPlayer = v
            break
        end
    end    
    return foundPlayer 
end

function findPlayer(sourcePlayer, partialNick)
	if not partialNick and not isElement(sourcePlayer) and type(sourcePlayer) == "string" then
		partialNick = sourcePlayer
		sourcePlayer = nil
	end
	
	local candidates = {}
	local matchPlayer = nil
	local matchNickAccuracy = -1

	partialNick = string.lower(partialNick)
	
	if sourcePlayer and (partialNick == "*" or partialNick == "me") then
		return sourcePlayer, string.gsub(getElementData(sourcePlayer, "visibleName") or getPlayerName(sourcePlayer), "_", " ")
	elseif tonumber(partialNick) then
		local players = getElementsByType("player")

		for i = 1, #players do
			local player = players[i]

			if isElement(player) then
				if getElementData(player, "loggedIn") then
					if getElementData(player, "playerID") == tonumber(partialNick) then
						matchPlayer = player
						break
					end
				end
			end
		end

		candidates = {matchPlayer}
	else
		local players = getElementsByType("player")

		partialNick = string.gsub(partialNick, "-", "%%-")

		for i = 1, #players do
			local player = players[i]

			if isElement(player) then
				local playerName = getElementData(player, "visibleName")

				if not playerName then
					playerName = getElementData(player, "visibleName") or getPlayerName(player)
				end

				playerName = string.gsub(playerName, "_", " ")
				playerName = string.lower(playerName)

				if playerName then
					local startPos, endPos = string.find(playerName, tostring(partialNick))

					if startPos and endPos then
						if endPos - startPos > matchNickAccuracy then
							matchNickAccuracy = endPos - startPos
							matchPlayer = player
							candidates = {player}
						elseif endPos - startPos == matchNickAccuracy then
							matchPlayer = nil
							table.insert(candidates, player)
						end
					end
				end
			end
		end
	end
	
	if not matchPlayer or not isElement(matchPlayer) then
		if isElement(sourcePlayer) then
			if #candidates == 0 then
                outputChatBox("[color=sightred][SightMTA]: #ffffffA kiválasztott játékos nem található.", sourcePlayer, 255, 255, 255, true)
			else
                outputChatBox("[color=sightyellow][SightMTA]: #FFFFFFTöbb játékos található ezzel a névrészlettel:", sourcePlayer, 255, 255, 255, true)
			
				for i = 1, #candidates do
					local player = candidates[i]

					if isElement(player) then
						local playerId = getElementData(player, "playerID")
						local playerName = string.gsub(getElementData(player, "visibleName") or getPlayerName(player), "_", " ")

                        outputChatBox(string.format("  [color=sightyellow](%d) %s", tonumber(getElementData(player, "playerID")) or 0, playerName:gsub("_", " ")), sourcePlayer, 255, 255, 255, true)
					end
				end
			end
		end
		
		return false
	else
		if getElementData(matchPlayer, "loggedIn") then
			local playerName = getElementData(matchPlayer, "visibleName")

			if not playerName then
				playerName = getElementData(matchPlayer, "visibleName") or getPlayerName(matchPlayer)
			end

			return matchPlayer, string.gsub(playerName, "_", " ")
		else
            outputChatBox("[color=sightred][SightMTA]: #ffffffA kiválasztott játékos nincs bejelentkezve.", sourcePlayer, 255, 255, 255, true)
			return false
		end
	end
end

function findPlayerLvl(sourcePlayer, commandName, targetPlayer)
    if not targetPlayer then
        outputChatBox("[color=sightyellow][Használat]: #ffffff/" .. commandName .. " [Név / ID]", sourcePlayer, 0, 0, 0, true)
    else
        targetPlayer, targetName = findPlayer(sourcePlayer, targetPlayer)

        if targetPlayer then
            outputChatBox("[color=sightgreen][SightMTA]: #ffffff" .. targetName .. " szintje: [color=sightblue]" .. getLevel(exports.sCore:getPlayedMinutes(targetPlayer) or 0) .. ".", sourcePlayer, 0, 0, 0, true)
        end
    end
end
addCommandHandler("lvl", findPlayerLvl)
addCommandHandler("szint", findPlayerLvl)

function findPlayerId(sourcePlayer, commandName, targetPlayer)
    if not targetPlayer then
        outputChatBox("[color=sightyellow][Használat]: #ffffff/" .. commandName .. " [Név / ID]", sourcePlayer, 0, 0, 0, true)
    else
        targetPlayer, targetName = findPlayer(sourcePlayer, targetPlayer)

        if targetPlayer then
            outputChatBox("[color=sightgreen][SightMTA]: #ffffff" .. targetName .. " játékos azonosítója: [color=sightblue]" .. getElementData(targetPlayer, "playerID") .. ".", sourcePlayer, 0, 0, 0, true)
        end
    end
end
addCommandHandler("id", findPlayerId)

addEventHandler("onElementDataChange", getRootElement(), function(dataName, oldValue, newValue)
    if dataName == "visibleName" and getElementType(source) == "player" then
        setPlayerName(source, newValue)
    end
end)

function getRealTimestamp()
    return getRealTime().timestamp
end

local jobMultipliers = {}
local jobList = {
    [1] = "Áruszállító",
    [2] = "Raktáros",
    [3] = "Teszt",
}

function loadJobMultipliers()
    if fileExists("jobMultiplier.json") then
        local openedFile = fileOpen("jobMultiplier.json")
        local fileData = fileRead(openedFile, fileGetSize(openedFile))
        fileClose(openedFile)
        jobMultipliers = fromJSON(fileData) or {}
    else
        jobMultipliers = {}
    end
end

function saveJobMultiplier(jobIdentity, jobMultiplier)
    jobMultipliers[jobIdentity] = jobMultiplier
    
    local file
    if fileExists("jobMultiplier.json") then
        file = fileOpen("jobMultiplier.json")
        fileSetPos(file, 0) 
    else
        file = fileCreate("jobMultiplier.json")
    end
    
    fileWrite(file, toJSON(jobMultipliers, true)) 
    fileClose(file)
end

function getJobMultiplier(jobIdentity)
    return jobMultipliers[tostring(jobIdentity)] or 1
end

addCommandHandler("setjobmultiplier", function(sourcePlayer, commandName, targetJob, targetMultiplier)
    if exports.sPermission:hasPermission(sourcePlayer, "runcode") then
        local multiplier = tonumber(targetMultiplier)
        if targetJob and multiplier and multiplier > 1 and multiplier <= 5 then
            if jobMultipliers[targetJob] then
                outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]Sikeresen megváltoztattad a munka szorzóját! [color=sightgreen]["..jobList[tonumber(targetJob)].."] ("..jobMultipliers[targetJob].." >> "..multiplier..")", sourcePlayer)
            else
                outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]Sikeresen beállítottad egy munkának a szorzóját! [color=sightgreen]["..jobList[tonumber(targetJob)].." (1 >> "..multiplier..")]", sourcePlayer)
            end
            saveJobMultiplier(targetJob, multiplier)
        else
            outputChatBox("[color=sightgreen][SightMTA - Használat]: [color=hudwhite]/"..commandName.." [Munka ID] [Szorzó (max 5)]")
        end
    end
end)

addCommandHandler("getjobmultiplier", function(sourcePlayer, commandName)
    if exports.sPermission:hasPermission(sourcePlayer, "runcode") then
        outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]A jelenlegi munkák szorzói: ")
        for jobIdentity, jobName in pairs(jobList) do
            outputChatBox("[color=sightgreen]  * [color=hudwhite]".. jobName .." [color=sightgreen]"..jobMultipliers[tostring(jobIdentity)] or 1, sourcePlayer)
        end
    end
end)

addCommandHandler("resetallmultipliers", function(sourcePlayer, commandName)
    if exports.sPermission:hasPermission(sourcePlayer, "runcode") then
        for jobIdentity, _ in pairs(jobMultipliers) do
            jobMultipliers[jobIdentity] = 1
        end

        local file
        if fileExists("jobMultiplier.json") then
            file = fileOpen("jobMultiplier.json")
            fileSetPos(file, 0) 
        else
            file = fileCreate("jobMultiplier.json")
        end
        
        fileWrite(file, toJSON(jobMultipliers, true)) 
        fileClose(file)

        outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]Minden munkaszorzó sikeresen alaphelyzetbe lett állítva (1-re)!", sourcePlayer)
    end
end)

addEventHandler("onResourceStart", resourceRoot, loadJobMultipliers)
