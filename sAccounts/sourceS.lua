local connection = false

local registrationProcess = {}
local payDayTimer = {}
local paydayAmount = 60 * 60000

addEventHandler("onResourceStart", getRootElement(), function(res)
    local resName = getResourceName(res)

    if res == getThisResource() then
        for _, playerElement in pairs(getElementsByType("player")) do
            if payDayTimer[playerElement] and isTimer(payDayTimer[playerElement]) then
                killTimer(payDayTimer[playerElement])
            end

            payDayTimer[playerElement] = setTimer(processPayDay, paydayAmount, 0, playerElement)
        end
    end

    if res == getThisResource() then
        connection = exports.sConnection:getConnection()

        setTimer(processPlayedMinutes, 60000, 0)
    elseif resName == "sConnection" then
        connection = exports.sConnection:getConnection()
    end
end)

--[[
addCommandHandler("resetacc", function(l)
    triggerClientEvent(l, "receiveBanState", l, {}, getPlayerSerial(l))
end)
]]

addEvent("checkPlayerBanState", true)
addEventHandler("checkPlayerBanState", getRootElement(), function()
    fadeCamera(client, true)
    dbQuery(function(qh, client)
        local result = dbPoll(qh, 0)
        
        if #result == 0 then
            triggerClientEvent(client, "receiveBanState", client, {}, getPlayerSerial(client), "nincs")
        elseif result[1].suspended == 0 then
            triggerClientEvent(client, "receiveBanState", client, {}, getPlayerSerial(client), "nincs")
        end
    end, {client}, connection, "SELECT * FROM accounts WHERE serial = ?", getPlayerSerial(client))
end)

addEvent("tryRegistration", true)
addEventHandler("tryRegistration", getRootElement(), function()
    dbQuery(function(qh, client)
        local result = dbPoll(qh, 0)

        if #result > 0 then
            exports.sGui:showInfobox(client, "e", "Ehhez a számítógéphez már van account társítva!")
        else
            registrationProcess[client] = true 
        end
        triggerClientEvent(client, "registrationResponse", client, #result == 0)
    end, {client}, connection, "SELECT * FROM accounts WHERE serial = ?", getPlayerSerial(client))
end)

addEvent("tryEndRegistration", true)
addEventHandler("tryEndRegistration", getRootElement(), function(username, password, email, inviteCode)
    if registrationProcess[client] then
        inviteCode = inviteCode or "N/A"
        dbQuery(function(qh, client, username, password, email, inviteCode)
            local result = dbPoll(qh, 0)

            if #result > 0 then
                if result[1].username == username then
                    exports.sGui:showInfobox(client, "e", "Ez a felhasználónév már használatban van!")
                elseif result[1].email == email then
                    exports.sGui:showInfobox(client, "e", "Ez az email cím már használatban van!")
                end
                
                triggerClientEvent(client, "registrationEndResponse", client, false)
            else
                --[[
                if inviteCode and inviteCode ~= "N/A" then
                    if not exports.sDashboard:isInviteCodeOccupied(inviteCode) then
                        triggerClientEvent(client, "registrationEndResponse", client, false)
                        return
                    end
                end
                ]]
                dbExec(connection, "INSERT INTO accounts (username, password, email, serial, invitedBy, inviteCode) VALUES (?,?,?,?,?,?)", username, passwordHash(password, "bcrypt", {}), email, getPlayerSerial(client), inviteCode, exports.sDashboard:generateInviteCode())
                triggerClientEvent(client, "registrationEndResponse", client, true, getPlayerSerial(client), "nincs", username)
                registrationProcess[client] = nil
            end
        end, {client, username, password, email, inviteCode}, connection, "SELECT * FROM accounts WHERE username OR email = ?", getPlayerSerial(client))
    else
        exports.sAnticheat:anticheatBan(client, "AC #58 - sAccounts @sourceS:81")
    end
end)

addEvent("tryLogin", true)
addEventHandler("tryLogin", getRootElement(), function(username, password)
    dbQuery(function(qh, client)
        local result = dbPoll(qh, 0)

        if #result > 0 then
            if passwordVerify(password, result[1].password) then
                setElementData(client, "char.accID", result[1].accountId)
                setElementData(client, "acc.adminLevel", result[1].adminLevel)
                setElementData(client, "acc.guardLevel", result[1].guardLevel)
                setElementData(client, "acc.adminNick", result[1].adminNick)
                setElementData(client, "acc.helperLevel", result[1].helperLevel)
                setElementData(client, "acc.Name", result[1].username, false)
                setElementData(client, "char.achievements", result[1].achievements)
                triggerClientEvent(client, "gotLocalUserName", client, result[1].username)
                exports.sCore:setPP(client, result[1].premiumPoints)
                exports.sGroups:refreshPlayerPermissions(client)

                handlePlayerLogin(client)

                dbQuery(function(qh, client)
                    local result = dbPoll(qh, 0)
                    triggerClientEvent(client, "loginResponse", client, true, result)
                end, {client}, connection, "SELECT * FROM characters WHERE accountId = ?", result[1].accountId)
            else
                triggerClientEvent(client, "loginResponse", client, false)
                exports.sGui:showInfobox(client, "e", "Helytelen jelszó!")
            end
        else
            triggerClientEvent(client, "loginResponse", client, false)
            exports.sGui:showInfobox(client, "e", "Helytelen felhasználónév")
        end
    end, {client}, connection, "SELECT * FROM accounts WHERE serial = ?", getPlayerSerial(client))
end)

function handlePlayerLogin(player)
    local playerId = getElementData(player, "char.accID")
    if not playerId then 
        return 
    end

    local result = dbPoll(dbQuery(connection, "SELECT loginStreak, lastOnline FROM accounts WHERE accountId = ?", playerId), -1)

    local now = getRealTime()
    local today = getDayOfYear(now)
    local currentTimestamp = now.timestamp

    local newStreak = "000000000000000000000000000000"
    
    if result and #result > 0 then
        local lastOnline = tonumber(result[1].lastOnline or 0)
        local currentStreak = tostring(result[1].loginStreak or newStreak)
        
        if lastOnline == 0 then
            newStreak = "1" .. string.rep("0", 29)
        else
            local lastTime = getRealTime(lastOnline)
            local lastDay = getDayOfYear(lastTime)
            local lastYear = lastTime.year

            if today == lastDay then
                newStreak = currentStreak
            elseif today == lastDay + 1 or (now.year > lastYear and today == 1 and lastDay >= 365) then
                newStreak = "1" .. currentStreak:sub(1, 29)
            else
                newStreak = "1" .. string.rep("0", 29)
            end
        end
    else
        newStreak = "1" .. string.rep("0", 29)
    end

    dbExec(connection, "UPDATE accounts SET loginStreak = ?, lastOnline = ?, online = 'Y' WHERE accountId = ?", newStreak, currentTimestamp, playerId)
end


function getDayOfYear(rt)
	local monthDays = {31,28,31,30,31,30,31,31,30,31,30,31}
    local rt = getRealTime()
	local dayCount = rt.monthday

	for i = 1, rt.month do
		dayCount = dayCount + monthDays[i]
	end

	local year = rt.year + 1900
	if rt.month > 1 and (year % 4 == 0 and (year % 100 ~= 0 or year % 400 == 0)) then
		dayCount = dayCount + 1
	end

	return dayCount
end

addEvent("checkCharacterName", true)
addEventHandler("checkCharacterName", getRootElement(), function(name)
    dbQuery(function(qh, client)    
        local result = dbPoll(qh, 0)
        triggerClientEvent(client, "characterNameResponse", client, #result > 0)
    end, {client}, connection, "SELECT * FROM characters WHERE name = ?", name)
end)

addEvent("tryCharacterCreation", true)
addEventHandler("tryCharacterCreation", getRootElement(), function(name, skin)
    local accID = tonumber(getElementData(client, "char.accID"))

    if accID then
        dbQuery(function(qh, client, accID, name, skin)
            local result = dbPoll(qh, 0)

            if #result > 0 then
                dbQuery(function(qh, client, accID, name, skin, maxCharacters)    
                    local result, _, last = dbPoll(qh, 0)
                    if #result < maxCharacters then
                        triggerClientEvent(client, "successCharCreation", client)
                        dbExec(connection, "INSERT INTO characters (accountId, name, skin) VALUES (?,?,?)", accID, name, skin)

                        dbQuery(function(qh, client)
                            local result = dbPoll(qh, 0)

                            if #result > 0 then
                                setElementData(client, "char.ID", result[1].characterId)
                                setElementData(client, "char.vehiclesSlot", result[1].vehiclesSlot)
                            end
                        end, {client}, connection, "SELECT * FROM characters WHERE name = ?", name)
                    else
                        exports.sAnticheat:anticheatBan(client, "AC #59 - sAccounts @sourceS:215")
                    end
                end, {client, accID, name, skin, result[1].maxCharacters}, connection, "SELECT * FROM characters WHERE accountId = ?", accID)
            end
        end, {client, accID, name, skin}, connection, "SELECT * FROM accounts WHERE accountId = ?", accID)
    end
end)

addEvent("setCharacterCreationStage", true)
addEventHandler("setCharacterCreationStage", getRootElement(), function(stage)
    local charID = getElementData(client, "char.ID")
    if charID then
        dbExec(connection, "UPDATE characters SET creationStage = ? WHERE characterId = ?", stage, charID)

        if stage == 7 then
            selectCharacter(charID, false, client)
        end
    else
    end
end)

function convertKeys(table)
	local newTable = {}
	for key, value in pairs(table) do
		local numericKey = tonumber(key)
		if numericKey then
			key = numericKey
		end

		if type(value) == "table" then
			newTable[key] = convertKeys(value)
		else
			newTable[key] = value
		end
	end
	return newTable
end

function processJson(jsonTable)
    return convertKeys(jsonTable)
end

function selectCharacter(charID, skip, clientEx)
    local client = client or clientEx
    local skip = skip or false
    
    local accID = tonumber(getElementData(client, "char.accID"))
    setPlayerBlurLevel(client, 0)
    if accID then
        dbQuery(function(qh, client, skip, accID)
            local result = dbPoll(qh, 0)

            if #result > 0 then
                local data = result[1]

                if data.accountId == accID then
                    local radioData = fromJSON(data.radioFreq)

                    setElementData(client, "char.ID", data.characterId)
                    setElementData(client, "char.name", data.name)
                    setElementData(client, "char.skills", fromJSON(data.skills) or {})
                    setElementData(client, "playerRecipes", processJson(fromJSON(data.playerRecipes) or {}))
                    setElementData(client, "char.weaponPos", fromJSON(data.weaponPos) or {})
                    setElementData(client, "visibleName", data.name)
                    setElementData(client, "permGroupSkin", data.permGroupSkin)
                    setElementData(client, "loggedIn", true)
                    setElementData(client, "char.Thirst", data.thirst)
                    setElementData(client, "char.Hunger", data.hunger)
                    setElementData(client, "char.Radio", {radioData[1], radioData[2]})
                    triggerClientEvent(client, "gotWalkieTalkieFrequencies", client, (radioData[1] or false), (radioData[2] or false))
                    exports.sCore:setMoney(client, data.money)
                    exports.sCore:setBankMoney(client, data.bankMoney)
                    exports.sCore:setPlayedMinutes(client, data.playedMinutes)
                    exports.sCore:setSSC(client, data.coins)
                    setElementData(client, "char.vehiclesSlot", (data.vehiclesSlot or 2))
                    setElementData(client, "char.interiorsSlot", (data.interiorsSlot or 2))
                    setElementData(client, "char.skin", data.skin)

                    setElementData(client, "char.totalTaxiCheckOut", fromJSON(data.totalTaxiCheckOut))

                    local bloodDamage = fromJSON(data.bloodDamage)
                    local bodyDamage = fromJSON(data.bodyDamage)

                    if bloodDamage and #bloodDamage > 0 then
                        realBloodDamge = unpack(bloodDamage)
                    end
                    if bodyDamage and #bodyDamage > 0 then
                        realBodyDamge = unpack(bodyDamage)
                    end

                    if not realBloodDamge then
                        setElementData(client, "bloodDamage", realBloodDamge)
                    else
                        setElementData(client, "bloodDamage", bloodDamage)
                    end

                    if not realBodyDamge then
                        setElementData(client, "bodyDamage", realBodyDamge)
                    else
                        setElementData(client, "bodyDamage", bodyDamage)
                    end

                    local playerRadio = fromJSON(data.radioFreq) or {0, 0}

                    if data.facePaint ~= 0 then
                        setElementData(client, "facePaint", data.facePaint)
                    end

                    triggerClientEvent(client, "syncNeeds", client, data.hunger, data.thirst)

                    spawnPlayer(client, data.x, data.y, data.z, data.r, data.skin, data.interior, data.dimension)
                    
                    payDayTimer[client] = setTimer(processPayDay, 60 * 60000, 0, client)
                    triggerClientEvent(client, "characterSelected", client, data.x, data.y, data.z, data.r, data.interior, data.dimension, data.creationStage, data.inDeath == 1)

                    if exports.sGroups:isGroupValid(data.voiceRadio) and exports.sGroups:isPlayerInGroup(client, data.voiceRadio) then
                        setElementData(client, "voiceRadioChannel", data.voiceRadio)
                    end
                    
                    dbExec(connection, "UPDATE characters SET online = 1 WHERE characterId = ?", data.characterId)
                end
            end
        end, {client, skip, accID}, connection, "SELECT * FROM characters WHERE characterId = ?", charID)
    end
end
addEvent("selectCharacter", true)
addEventHandler("selectCharacter", getRootElement(), selectCharacter)

gotPictureFromPlayer = {}
local lastLoginPictureRequest = {}

addEvent("gotLoginPicture", true)
addEventHandler("gotLoginPicture", getRootElement(), function(imagePixels)
    if not gotPictureFromPlayer[client] and ((lastLoginPictureRequest[client] or true) ~= true and lastLoginPictureRequest[client] >= getTickCount() + 50000) then
        
        local playerPicture = fileCreate("server/" .. getElementData(client, "char.ID") .. ".jpg")
        fileWrite(playerPicture, imagePixels)
        fileClose(playerPicture)
        
        lastLoginPictureRequest[client] = getTickCount()
        gotPictureFromPlayer[client] = true
    end
end)

function processPlayedMinutes()
    for k, v in pairs(getElementsByType("player")) do
        local charID = tonumber(getElementData(v, "char.ID"))

        if charID then
            if tonumber(getElementData(v, "afkMinutes")) == 0 then
                local playedMinutes = exports.sCore:getPlayedMinutes(v)

                local playerFacepaint = tonumber(getElementData(v, "facePaint"))

                if playedMinutes then
                    exports.sCore:setPlayedMinutes(v, playedMinutes + 1)
                    dbExec(connection, "UPDATE characters SET playedMinutes = ? WHERE characterId = ?", playedMinutes + 1, charID)
                end

                if playedMinutes and not getElementData(v, "isPlayerDeath") and not exports.sJail:isPlayerInJail(v) then
                    local amount = -0.7
                    local currentThirst = getElementData(v, "char.Thirst") or 100
                    if currentThirst + amount < 0 then
                        setElementData(v, "customDeath", "szomjan halt")
                        setElementHealth(v, 0)
                    else
                        setElementData(v, "char.Thirst", currentThirst + amount)
                    end

                    local currentHunger = getElementData(v, "char.Hunger") or 100
                    local amount = -0.35
                    if currentHunger + amount < 0 then
                        setElementData(v, "customDeath", "éhen halt")
                        setElementHealth(v, 0)
                    else
                        setElementData(v, "char.Hunger", currentHunger + amount)
                    end
                    triggerClientEvent(v, "syncNeeds", v, currentHunger, currentThirst)
                end
                if playerFacepaint then
                    if playerFacepaint ~= 0 then
                        setElementData(v, "facePaint", playerFacepaint - 1)
                        if getElementData(v, "facePaint") == 0 then
                            outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]Lekopott a [color=sightpurple-second]festék[color=hudwhite] az arcodról.", v)
                            setElementData(v, "facePaint", false)
                        end
                    end
                end
            end
        end
    end
end

local afkTimers = {}

addEventHandler("onElementDataChange", getRootElement(), function(dataName, oldValue, newValue)
    if dataName == "afk" and source == client then
        if newValue then
            afkTimers[client] = setTimer(processAfk, 60000, 0, client)
            if isTimer(payDayTimer[client]) then
                setTimerPaused(payDayTimer[client], true)
            end
        else
            if isTimer(afkTimers[client]) then
                killTimer(afkTimers[client])
            end
            afkTimers[client] = nil

            if isTimer(payDayTimer[client]) then
                setTimerPaused(payDayTimer[client], false)
            end

            if getElementAlpha(client) ~= 0 then
                setElementAlpha(client, 255)
            end
            
            setTimer(function(client)
                if isElement(client) then
                    setElementData(client, "afkMinutes", 0)
                end
            end, 5000, 1, client)
        end
    end
end)

function processAfk(client)
    if not client then
        return
    end

    local afkMinutes = getElementData(client, "afkMinutes") or 0

    if afkMinutes >= 20 then
        if getElementAlpha(client) ~= 0 then
            setElementAlpha(client, 255)
        end
    end

    if afkMinutes then
        setElementData(client, "afkMinutes", afkMinutes + 1)
    end
end

addEventHandler("onPlayerQuit", getRootElement(), function()
    if isTimer(afkTimers[source]) then
        killTimer(afkTimers[source])
    end
    afkTimers[source] = nil
    
    if isTimer(payDayTimer[source]) then
        killTimer(payDayTimer[source])
    end
    payDayTimer[source] = nil

    local currentTimestamp = getRealTime().timestamp
    local playerId = getElementData(source, "char.accID") 

    dbExec(connection, "UPDATE accounts SET lastOnline = ?, online = 'N' WHERE accountId = ?", currentTimestamp, playerId)

    setElementData(source, "afkMinutes", false)
    setElementData(source, "afk", false)

    savePlayer(source, true, true)
end)

function savePlayer(player, loggedOut, saveVehicles)
    local charID = tonumber(getElementData(player, "char.ID"))

    if charID and getElementData(player, "loggedIn") then
        local x, y, z = getElementPosition(player)
        local int = getElementInterior(player)
        local dim = getElementDimension(player)

        local radioData = getElementData(player, "char.Radio") or {}

        local datas = {
            ["x"] = x,
            ["y"] = y,
            ["z"] = z,
            ["interior"] = int,
            ["dimension"] = dim,
            ["skin"] = getElementModel(player),
            ["permGroupSkin"] = getElementData(player, "permGroupSkin") or "N",
            ["health"] = getElementHealth(player),
            ["armor"] = getPedArmor(player),
            ["hunger"] = getElementData(player, "char.Hunger") or 100,
            ["thirst"] = getElementData(player, "char.Thirst") or 100,
            ["money"] = exports.sCore:getMoney(player),
            ["bankMoney"] = exports.sCore:getBankMoney(player),
            ["coins"] = exports.sCore:getSSC(player),
            ["vehiclesSlot"] = getElementData(player, "char.vehiclesSlot") or 2,
            ["facePaint"] = getElementData(player, "facePaint") or 0,
            ["totalTaxiCheckOut"] = toJSON(getElementData(player, "char.totalTaxiCheckOut")) or "[ [ ] ]",
            ["playerRecipes"] = toJSON((getElementData(player, "playerRecipes") or {})),
            ["bloodDamage"] = toJSON(getElementData(player, "bloodDamage") or {}) or "[ [ false ] ]",
            ["bodyDamage"] = toJSON(getElementData(player, "bodyDamage") or {}) or "[ [ false ] ]",
            ["radioFreq"] = toJSON({radioData[1], radioData[2]}),
            ["voiceRadio"] = getElementData(player, "voiceRadioChannel") or "0"
        }

        if loggedOut then
            datas["lastOnline"] = "%CURRENT_TIMESTAMP%"
            datas["online"] = 0
        end

        dbUpdate("characters", datas, {characterId = charID})
    end
end

setTimer(function()
    for k, v in pairs(getElementsByType("player")) do
        if v then
            savePlayer(v, false, false)
        end
    end
end, 60000 * 5, 0)

function dbUpdate(tableName, setFields, whereFields)
	if tableName and setFields and type(setFields) == "table" and whereFields and type(whereFields) == "table" then
		local columns = {}
		local values = {}
		local wheres = {}

		for column, value in pairs(setFields) do
            if value then
                if string.sub(value, 0, 1) == "%" and string.sub(value, string.len(value)) == "%" then
                    table.insert(columns, string.format("`%s`=%s", column, string.gsub(value, "%%", "")))
                else
                    table.insert(columns, string.format("`%s`=?", column))
                    table.insert(values, value)
                end
            end
		end

		for column, value in pairs(whereFields) do
			table.insert(wheres, string.format("`%s`=?", column))
			table.insert(values, value)
		end

		local queryString = dbPrepareString(connection, "UPDATE ?? SET " .. table.concat(columns, ", ") .. " WHERE " .. table.concat(wheres, " AND ") .. ";", tableName, unpack(values))

		return dbExec(connection, queryString)
	end

	return false
end

addCommandHandler("saveme", function(client)
    if exports.sPermission:hasPermission(client, "saveBandwith") then
        savePlayer(client)
    end
end)

addEventHandler("onResourceStop", resourceRoot, function()
    for k, v in pairs(getElementsByType("player")) do
        savePlayer(v, true)
    end
end)

function math.round(num, decimals)
    decimals = math.pow(10, decimals or 0)
    num = num * decimals
    if num >= 0 then num = math.floor(num + 0.5) else num = math.ceil(num - 0.5) end
    return num / decimals
end

local function getFactionPayments(playerElement)
    local factionPayments = {}
    local playerGroups = exports.sGroups:getPlayerGroups(playerElement) or {}
    for groupName in pairs(playerGroups) do
        local playerRank, rankPayment = exports.sGroups:getPlayerRank(groupName, playerElement)
        if rankPayment > 0 then
            table.insert(factionPayments, {name = exports.sGroups:getGroupName(groupName), amount = rankPayment, groupPrefix = groupName})
        end
    end
    return factionPayments
end

function isVehicleInGarage(vehicleElement)
    if isElement(vehicleElement) and exports.sInteriors:isValidInterior(getElementDimension(vehicleElement)) then
        return true
    end
    return false
end

local function buildPaydayMessage(playerElement)
    local lines = {}

    local factionPayments = getFactionPayments(playerElement)
    local totalFactionPay = 0

    table.insert(lines, "[color=sightgreen]  * Frakció bér:")

    for _, factionData in ipairs(factionPayments) do
        local factionName = factionData.name
        local factionPay  = factionData.amount
        local groupPrefix = factionData.groupPrefix

        local paymentState = exports.sGroups:takeGroupBalance(groupPrefix, playerElement, factionPay)

        table.insert(lines, ("[color=sightred]     * %s: [color=hudwhite]%s $ %s"):format(factionName, exports.sGui:thousandsStepper(factionPay), (paymentState and "" or "[color=sightred][Nem került hozzáírásra, nincs elég fedezete a frakciónak!]")))
        totalFactionPay = totalFactionPay + (paymentState and factionPay or 0)
    end

    table.insert(lines, ("[color=sightgreen]     * Összesen: [color=hudwhite]%s $"):format(exports.sGui:thousandsStepper(totalFactionPay)))

    local interestRate = 0.001
    local bankMoney = exports.sCore:getBankMoney(playerElement) or 0
    local bankInterest = bankMoney * interestRate
    
    if bankInterest > 100000 then
        bankInterest = 100000
    end

    bankInterest = math.floor(bankInterest)

    table.insert(lines, ("[color=sightgreen]  * Kamat: [color=hudwhite]%s $"):format(exports.sGui:thousandsStepper(bankInterest)))


    table.insert(lines, "")
    local incomeTax = 200
    table.insert(lines, ("[color=sightred]  * Jövedelemadó: [color=hudwhite]%s $"):format(exports.sGui:thousandsStepper(incomeTax)))

    local playerVehicles = exports.sVehicles:getPlayerVehicles(playerElement)

    local playerVehicleCount = 0
    local playerAirplaneCount = 0
    local playerBoatCount = 0
    local playerBikeCount = 0
    
    local vehicleTax = 0
    local airplaneTax = 0
    local boatTax = 0
    local bikeTax = 0
    
    for _, vehicleElement in ipairs(playerVehicles) do
        local vehicleType = getVehicleType(getElementModel(vehicleElement))
        if vehicleType == ("Automobile" or "Monster Truck" or "Quad" or "Bike") then
            local taxAmount = isVehicleInGarage(vehicleElement) and (2500 * 0.1) or 2500
            vehicleTax = vehicleTax + taxAmount
            playerVehicleCount = playerVehicleCount + 1
        end

        if vehicleType == "Plane" then
            local taxAmount = isVehicleInGarage(vehicleElement) and (15000 * 0.1) or 15000
            airplaneTax = airplaneTax + taxAmount
            playerAirplaneCount = playerAirplaneCount + 1
        end

        if vehicleType == "Boat" then
            local taxAmount = isVehicleInGarage(vehicleElement) and (1000 * 0.1) or 1000
            boatTax = boatTax + taxAmount
            playerBoatCount = playerBoatCount + 1
        end

        if vehicleType == "BMX" then
            local taxAmount = isVehicleInGarage(vehicleElement) and (250 * 0.1) or 250
            bikeTax = bikeTax + taxAmount
            playerBikeCount = playerBikeCount + 1
        end
    end

    local playerLevel = exports.sCore:getLevel(exports.sCore:getPlayedMinutes(playerElement)) or 1
    local taxDiscount = 1

    if playerLevel <= 5 then
        taxDiscount = 0.85
    elseif playerLevel <= 10 then
        taxDiscount = 0.65 
    end

    local totalVehicleTaxWithoutDiscount = math.floor(vehicleTax + airplaneTax + boatTax + bikeTax)
    local totalVehicleTax = math.floor(vehicleTax + airplaneTax + boatTax + bikeTax) * (taxDiscount)

    table.insert(lines, "[color=sightred]  * Gépjárműadó:")
    table.insert(lines, ("[color=sightred]      * Személygépjármű (%d db): [color=hudwhite]%s $"):format(playerVehicleCount, exports.sGui:thousandsStepper(vehicleTax)))
    table.insert(lines, ("[color=sightred]      * Légijármű (%d db): [color=hudwhite]%s $"):format(playerAirplaneCount, exports.sGui:thousandsStepper(airplaneTax)))
    table.insert(lines, ("[color=sightred]      * Vízi jármű (%d db): [color=hudwhite]%s $"):format(playerBoatCount, exports.sGui:thousandsStepper(boatTax)))
    table.insert(lines, ("[color=sightred]      * Motorkerékpár (%d db): [color=hudwhite]%s $"):format(playerBikeCount, exports.sGui:thousandsStepper(bikeTax)))
    table.insert(lines, ("[color=sightgreen]      * Adókedvezmény: [color=hudwhite]%s $"):format(exports.sGui:thousandsStepper(totalVehicleTaxWithoutDiscount - totalVehicleTax)))
    table.insert(lines, ("[color=sightred]    * Összesen: [color=hudwhite]%s $"):format(exports.sGui:thousandsStepper(totalVehicleTax)))

    local playerProperties = exports.sInteriors:getPlayersInterior(playerElement)

    local propertyCount = #playerProperties
    local propertyTax = math.floor(propertyCount * 12500)
    table.insert(lines, ("[color=sightred]  * Ingatlanadó (%d db): [color=hudwhite]%s $"):format(propertyCount, exports.sGui:thousandsStepper(propertyTax)))

    if bankInterest < 0 then
        bankInterest = 0
    end

    local totalIncome = math.floor(totalFactionPay + bankInterest)
    local totalTax = math.floor(incomeTax + totalVehicleTax + propertyTax)
    local finalAmount = math.floor(totalIncome - totalTax)
    
    table.insert(lines, "")
    table.insert(lines, ("[color=sightblue]  * Összes jóváírás: [color=hudwhite]%s $"):format(exports.sGui:thousandsStepper(math.round(finalAmount))))
    table.insert(lines, "")
    
    local remainingTax = math.round(finalAmount)
    local bankBalance = exports.sCore:getBankMoney(playerElement)
    local playerBalance = exports.sCore:getMoney(playerElement)
    
    local newBankBalance = bankBalance + remainingTax
    
    local requiredFromPlayer = 0
    if newBankBalance < -20000 then
        requiredFromPlayer = math.abs(newBankBalance + 20000)
        newBankBalance = -20000
        exports.sGui:showInfobox(playerElement, "w", "Mivel a banki tartozásod 20.000$ fölé nőtt, levonásra került a tartozás összege a készpénzedből.")
    end
    
    local newPlayerBalance = playerBalance - requiredFromPlayer
    
    exports.sCore:setBankMoney(playerElement, newBankBalance)
    exports.sCore:setMoney(playerElement, newPlayerBalance)

    return lines
end

function processPayDay(playerElement)
    if getElementData(playerElement, "loggedIn") then
        local paydayLines = buildPaydayMessage(playerElement)
        triggerClientEvent(playerElement, "gotPaydayData", playerElement, paydayLines)
    end
end

addCommandHandler("payday", function(sourcePlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "payday") then
        processPayDay(sourcePlayer)
    end
end)