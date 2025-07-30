local dbConnection
local jailCollision

addEventHandler("onResourceStart", resourceRoot, function()
    if not dbConnection then
        dbConnection = exports.sConnection:getConnection()
    end

    if not jailCollision then
        jailCollision = createColSphere(0, 0, 100, 10)
    end

    setTimer(function()
        checkAndJailOnlinePlayers()
    end, 50, 1)
end)

local jailedPlayers = {}
local questionTimers = {}
local occupiedCells = {}

function isPlayerInJail(playerElement)
    if jailedPlayers[playerElement] then
        return true
    else
        return false
    end
    --TODO: Megírni, és a gethere-nél/társainál (Esetleg findplayernél.)
end

function checkAndJailOnlinePlayers(accountIdentity)
    local queryString
    if accountIdentity then
        queryString = string.format("SELECT * FROM JAILS WHERE inActive = 0 AND accountIdentity = %d", tonumber(accountIdentity))
    else
        queryString = "SELECT * FROM JAILS WHERE inActive = 0"
    end

    local query = dbQuery(dbConnection, queryString)
    local result, numRows = dbPoll(query, -1)

    if result and numRows > 0 then
        for _, row in ipairs(result) do
            local playerElement = findOnlinePlayer(row.accountIdentity)

            if playerElement then
                if tonumber(row.jailType) == 4 and tonumber(row.jailCell) then
                    placePlayerInJail(
                        nil,
                        playerElement,
                        tonumber(row.jailDuration),
                        tonumber(row.jailType),
                        tonumber(row.jailCell),
                        row.jailReason,
                        row.adminName,
                        row.jailFine
                    )
                else
                    placePlayerInJail(
                        nil,
                        playerElement,
                        tonumber(row.jailDuration),
                        tonumber(row.jailType),
                        false,
                        row.jailReason,
                        row.adminName,
                        row.jailFine
                    )
                end
            end
        end
    end
end

function startJailTimer(playerElement)
    if not isElement(playerElement) or not jailedPlayers[playerElement] then return end

    setTimer(function()
        fadeCamera(playerElement, true, 1)
    end, 1000, 1)

    jailedPlayers[playerElement].jailTimer = setTimer(function()
        if isElement(playerElement) and jailedPlayers[playerElement] then
            local jailData = jailedPlayers[playerElement]

            if (jailData.jailType == 2 or jailData.jailType == 3) and jailData.waitingForAnswer then
                return
            end

            jailedPlayers[playerElement].jailTime = jailedPlayers[playerElement].jailTime - 1
            triggerClientEvent(playerElement, "refreshJailTime", playerElement, jailedPlayers[playerElement].jailTime, jailData.jailType ~= 4 and jailCollision)

            local accID = getElementData(playerElement, "char.accID")
            dbExec(dbConnection, "UPDATE JAILS SET jailDuration = ? WHERE accountIdentity = ? AND inActive = 0", jailedPlayers[playerElement].jailTime, accID)

            if jailedPlayers[playerElement].jailTime <= 0 then
                fadeCamera(playerElement, false, 1)
                setTimer(function()
                    releasePlayerFromJail(playerElement)
                    fadeCamera(playerElement, true, 1)
                end, 1500, 1)
            end
        else
            jailedPlayers[playerElement] = nil
        end
    end, 60000, jailedPlayers[playerElement].jailTime)
end

function findOnlinePlayer(accountIdentity)
    local foundPlayer = false
    for _, playerElement in pairs(getElementsByType("player")) do
        if getElementData(playerElement, "char.accID") == accountIdentity then
            foundPlayer = playerElement
        end
    end
    return foundPlayer
end

function findJailForPlayer()
    local randomCell
    repeat
        randomCell = math.random(1, 65535)
    until not occupiedCells[randomCell]

    occupiedCells[randomCell] = true
    return randomCell
end

local jailTypeFunctions = {
    [1] = function(playerElement)
    end,
    [2] = function(playerElement)
        local randomQuestion = math.random(1, #adminJailQuestions)
        local theCorrectQuestion = adminJailQuestions[randomQuestion][5]

        exports.sGui:showInfobox(playerElement, "w", "A börtönidőd addig nem csökken, amíg nem válaszolsz a kérdésekre!")
        askJailQuestion(playerElement)
    end,
    [3] = function(playerElement)
        local randomQuestion = math.random(1, #adminJailQuestions)

        jailedPlayers[playerElement].playerQuestion = adminJailQuestions[randomQuestion][1]
        jailedPlayers[playerElement].waitingForAnswer = true

        exports.sGui:showInfobox(playerElement, "w", "A börtönidőd addig nem csökken, amíg nem válaszolsz a kérdésekre!")
        askJailQuestion(playerElement)
    end
}

function placePlayerInJail(adminPlayer, playerElement, jailTime, jailType, jailCell, jailReason, responsibleName, jailFine, lawJailer, hasBail)
    if not isElement(playerElement) then
        return
    end

    jailTime = tonumber(jailTime)

    if not jailTime then
        return
    end

    fadeCamera(playerElement, false, 1)

    setTimer(function()

        local jailFine = tonumber(jailFine) or false

        if not isElement(playerElement) then
            return
        end

        local adminJailCell = findJailForPlayer()
        if not adminJailCell then
            exports.sGui:showInfobox(adminPlayer, "e", "Hiba történt a börtönzés során!")
            return
        end

        if jailFine and jailFine > 0 and hasBail then
            triggerClientEvent(playerElement, "showBailWindow", playerElement, jailFine)
            setTimer(function(playerElement, jailFine, dbConnect)
                dbExec(dbConnection, "UPDATE jails SET jailBail = 0 WHERE accountIdentity = ?", getElementData(playerElement, "char.accID"))
            end, 60000 * 5, 1, playerElement, jailFine, dbConnection)
        end


        local playerName = getElementData(playerElement, "char.name"):gsub("_", " ")

        local adminDatas
        if adminPlayer then
            adminDatas = {
                adminRank = exports.sAdministration:getPlayerAdminTitle(adminPlayer),
                adminLevel = getElementData(adminPlayer, "acc.adminLevel"),
                adminName = getElementData(adminPlayer, "acc.adminNick"),
                guardLevel = getElementData(adminPlayer, "acc.guardLevel"),
            }

            --[[
            if adminDatas.guardLevel > 0 then
                local responsiblePlayer = getElementData(adminPlayer, "char.name"):gsub("_", " ")
                triggerClientEvent("broadcastAdminJailMessage", adminPlayer, "[color=sightyellow]Egy RP Őr", playerName, jailTime, jailReason)
                exports.sAdministration:showMessageForAdmins("[color=sightred][AdminJail]: [color=sightyellow]RP Őr - [color=sightblue]"..responsiblePlayer, 6)
            else
                triggerClientEvent("broadcastAdminJailMessage", adminPlayer, adminDatas.adminRank.." "..adminDatas.adminName, playerName, jailTime, jailReason)
            end
            ]]
        end

        local selectedGroup = false

        if jailFine and jailFine > 0 then
            exports.sCore:takeMoney(playerElement, jailFine)
        end

        if jailFine and jailFine > 0 and lawJailer then

            local playerGroups = exports.sGroups:getPlayerGroups(lawJailer)
            if playerGroups then
                for k, v in pairs(playerGroups) do
                    if exports.sGroups:isLawEnforcementGroup(k) then
                        selectedGroup = k
                    end
                end
            end
        end

        jailedPlayers[playerElement] = {
            jailReason = jailReason,
            adminName = responsibleName,
            jailTime = jailTime,
            jailType = jailType,
            jailCell = adminJailCell and adminJailCell or false,
            icJailCell = jailCell and jailCell or false,
            jailTimer = nil,
            playerQuestion = {},
        }

        if jailCell and jailCells[jailCell] then
            jailedPlayers[playerElement].icJailCell = jailCell
            if hasBail then
                jailedPlayers[playerElement].jailFine = jailFine
                jailedPlayers[playerElement].selectedGroup = selectedGroup
            end
        end

        if jailedPlayers[playerElement].icJailCell then
            local cellData = jailCells[jailedPlayers[playerElement].icJailCell]
            if cellData then
                removePedFromVehicle(playerElement)
                setElementPosition(playerElement, cellData.spawn[1], cellData.spawn[2], cellData.spawn[3])
                setPedRotation(playerElement, 270, true)
                setElementInterior(playerElement, 1)
                setElementDimension(playerElement, 1)
                triggerClientEvent(playerElement, "refreshJailTime", playerElement, jailTime, false)
            else
                outputChatBox("[color=sightred][SightMTA]: [color=hudwhite]Hiba: Nem található a kiválasztott börtöncella!", adminPlayer, 255, 0, 0, true)
            end
        else
            removePedFromVehicle(playerElement)
            setElementDimension(playerElement, adminJailCell)
            setElementInterior(playerElement, 1)
            setElementPosition(playerElement, 0.002356922486797, -1.1232511997223, 101.546875)
            triggerClientEvent(playerElement, "loadJailInDimension", playerElement, adminJailCell)
            setPedRotation(playerElement, 180, true)
            triggerClientEvent(playerElement, "refreshJailTime", playerElement, jailTime, jailCollision)

            local jailFunction = jailTypeFunctions[jailType]
            if jailFunction then
                jailFunction(playerElement)    
            end
        end

        startJailTimer(playerElement)

    end, 1500, 1)
end

addEvent("freeWithBail", true)
addEventHandler("freeWithBail", root, function()
    if client and client == source then

        if not jailedPlayers[client] then
            return
        end

        local jailBail = jailedPlayers[client].jailFine
        local jailGroup = jailedPlayers[client].selectedGroup

        fadeCamera(client, false, 1)
        setTimer(function(playerElement)
            releasePlayerFromJail(playerElement)
            fadeCamera(playerElement, true, 1)
        end, 1500, 1, client)

        if jailBail then
            exports.sCore:takeMoney(client, jailBail)
            exports.sGroups:addGroupBalance(jailGroup, client, jailBail)
        end
        
        local accID = getElementData(client, "char.accID")
        dbExec(dbConnection, "UPDATE JAILS SET jailDuration = ? WHERE accountIdentity = ? AND inActive = 0", 0, accID)
    end
end)

local mindenhatoSerialok = {
    ["FC543CC5BCCE7C48917D1F2EB849DC03"] = true
}

addCommandHandler("ajail", function(sourcePlayer, commandName, targetPlayer, jailTime, jailType, ...)
    if exports.sPermission:hasPermission(sourcePlayer, "ajail") then
        local jailReason = string.gsub(table.concat({...}, " "), "#%x%x%x%x%x%x", "")
        jailReason = jailReason ~= "" and jailReason or "Nincs"
        local jailTime = tonumber(jailTime)
        local jailType = tonumber(jailType)

        local adminLevel = getElementData(sourcePlayer, "acc.adminLevel")
        local guardLevel = getElementData(sourcePlayer, "acc.guardLevel")

        if guardLevel == 1 then
            return
        end
        if jailTime and adminLevel < 2 and guardLevel == 0 and jailTime > 60 then
            outputChatBox("[color=sightred][SightMTA]: [color=hudwhite]Maximum 60 perc jailt adhatsz!", sourcePlayer, 255, 0, 0, true)
            return
        end
        if jailTime and guardLevel > 1 and guardLevel < 3 and jailTime > 60 then
            outputChatBox("[color=sightred][SightMTA]: [color=hudwhite]Maximum 60 perc jailt adhatsz!", sourcePlayer, 255, 0, 0, true)
            return
        end

        if targetPlayer and jailTime and jailReason and jailType then
            targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

            if getElementData(targetPlayer, "acc.adminLevel") >= getElementData(sourcePlayer, "acc.adminLevel") then
                if not mindenhatoSerialok[getPlayerSerial(sourcePlayer)] then
                    outputChatBox("[color=sightgreen][SightMTA - Jail]: [color=hudwhite]Ez egy mindenható ember! ["..getElementData(sourcePlayer, "visibleName").."]", sourcePlayer)
                    return
                else
                    outputChatBox("[color=sightgreen][SightMTA - Jail]: [color=hudwhite]Mivel mindenható vagy ezért nem lett megkerülve a rendszer!", sourcePlayer)
                end
            end

            if jailedPlayers[targetPlayer] then
                exports.sGui:showInfobox(sourcePlayer, "e", "A játékos már börtönben van!, előtte vedd ki!")
                return
            end

            if not targetPlayer then
                outputChatBox("[color=sightred][SightMTA]: #ffffffA játékos nem található!", sourcePlayer, 255, 0, 0, true)
                return
            end

            local accountIdentity = getElementData(targetPlayer, "char.accID")
            local checkQuery = dbQuery(dbConnection, "SELECT dbID FROM JAILS WHERE inActive = 0 AND accountIdentity = ?", accountIdentity)
            local checkResult = dbPoll(checkQuery, -1)

            if checkResult and #checkResult > 0 then
                dbExec(dbConnection, "UPDATE JAILS SET inActive = 1 WHERE inActive = 0 AND accountIdentity = ?", accountIdentity)
            end

            dbExec(dbConnection, "INSERT INTO JAILS (jailType, adminAccountId, adminName, jailTime, accountIdentity, jailReason, jailDuration, inActive) VALUES (?, ?, ?, ?, ?, ?, ?, 0)",
                jailType,
                getElementData(sourcePlayer, "char.accID") or 0,
                getElementData(sourcePlayer, "acc.adminNick") or "Ismeretlen",
                getRealTime().timestamp,
                accountIdentity,
                jailReason,
                jailTime
            )

            local adminPlayer = sourcePlayer
            adminDatas = {
                adminRank = exports.sAdministration:getPlayerAdminTitle(adminPlayer),
                adminLevel = getElementData(adminPlayer, "acc.adminLevel"),
                adminName = getElementData(adminPlayer, "acc.adminNick"),
                guardLevel = getElementData(adminPlayer, "acc.guardLevel"),
            }

            local playerName = getElementData(targetPlayer, "char.name"):gsub("_", " ")

            if adminDatas.guardLevel > 0 then
                local responsiblePlayer = getElementData(adminPlayer, "char.name"):gsub("_", " ")
                triggerClientEvent("broadcastAdminJailMessage", adminPlayer, "[color=sightyellow]Egy RP Őr", playerName, jailTime, jailReason and jailReason or "Nincs")
                exports.sAdministration:showMessageForAdmins("[color=sightred][AdminJail]: [color=sightyellow]RP Őr - [color=sightblue]"..responsiblePlayer, 6)
            else
                triggerClientEvent("broadcastAdminJailMessage", adminPlayer, adminDatas.adminRank.." "..adminDatas.adminName, playerName, jailTime, jailReason and jailReason or "Nincs")
            end

            placePlayerInJail(sourcePlayer, targetPlayer, jailTime, jailType, false, jailReason, getElementData(sourcePlayer, "acc.adminNick"), false)
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/"..commandName.." [Játékos Név / ID] [Időtartam] [Típus (1: Normál, 2: Válaszolós, 3: Írós)] [Indok]", sourcePlayer)
        end
    end
end)

addCommandHandler("offajail", function(sourcePlayer, commandName, targetPlayer, jailTime, jailType, ...)
    if exports.sPermission:hasPermission(sourcePlayer, "offjail") then
        local jailReason = string.gsub(table.concat({...}, " "), "#%x%x%x%x%x%x", "")

        if targetPlayer and jailReason and tonumber(jailTime) and tonumber(jailType) then
            local accountId, playerName

            if tonumber(targetPlayer) then
                accountId = tonumber(targetPlayer)
                
                local onlinePlayer
                for _, player in ipairs(getElementsByType("player")) do
                    if getElementData(player, "char.accID") == accountId then
                        isOnline = true
                        onlinePlayer = player
                        break
                    end
                end

                if isOnline then
                    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A játékos online van! Használd a /ajail parancsot! [color=sightgreen][".. getElementData(onlinePlayer, "visibleName"):gsub("_"," ") .."]", sourcePlayer, 255, 0, 0, true)
                    return
                end

                local query = dbQuery(dbConnection, "SELECT name FROM characters WHERE accountId = ? LIMIT 1", accountId)
                local result, rows = dbPoll(query, -1)

                if result and rows > 0 then
                    playerName = result[1].name:gsub("_", " ")
                else
                    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található karakter ezzel az Account ID-val!", sourcePlayer, 255, 0, 0, true)
                    return
                end
            else
                local onlinePlayer
                for _, player in ipairs(getElementsByType("player")) do
                    if string.lower(getPlayerName(player)) == string.lower(targetPlayer) then
                        isOnline = true
                        onlinePlayer = player
                        break
                    end
                end

                if isOnline then
                    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A játékos online van! Használd a /ajail parancsot! [color=sightgreen][".. getElementData(onlinePlayer, "visibleName"):gsub("_"," ") .."]", sourcePlayer, 255, 0, 0, true)
                    return
                end

                local query = dbQuery(dbConnection, "SELECT accountId, name FROM characters WHERE name LIKE ? LIMIT 1", "%" .. targetPlayer .. "%")
                local result, rows = dbPoll(query, -1)

                if result and rows > 0 then
                    accountId = result[1].accountId
                    playerName = result[1].name:gsub("_", " ")
                else
                    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található a megadott játékos!", sourcePlayer, 255, 0, 0, true)
                    return
                end
            end

            local checkQuery = dbQuery(dbConnection, "SELECT dbID FROM JAILS WHERE inActive = 0 AND accountIdentity = ?", accountId)
            local checkResult, checkRows = dbPoll(checkQuery, -1)

            if checkResult and checkRows > 0 then
                dbExec(dbConnection, "UPDATE JAILS SET inActive = 1 WHERE inActive = 0 AND accountIdentity = ?", accountId)
            end

            dbExec(dbConnection, "INSERT INTO JAILS (jailType, adminAccountId, adminName, jailTime, accountIdentity, jailReason, jailDuration, inActive) VALUES (?, ?, ?, ?, ?, ?, ?, 0)",
                tonumber(jailType),
                getElementData(sourcePlayer, "char.accID") or 0,
                getElementData(sourcePlayer, "acc.adminNick") or "Ismeretlen",
                getRealTime().timestamp,
                accountId,
                jailReason,
                tonumber(jailTime)
            )

            triggerClientEvent(root, "broadcastOfflineAdminJailMessage", sourcePlayer, exports.sAdministration:getPlayerAdminTitle(sourcePlayer) .. " " .. getElementData(sourcePlayer, "acc.adminNick"), playerName, jailTime, jailReason)

            outputChatBox("[color=sightgreen][AdminJail]: [color=hudwhite]Sikeresen bebörtönözted az offline játékost: [color=sightgreen]" .. playerName, sourcePlayer, 255, 255, 255, true)
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/"..commandName.." [Játékos Név / Account ID] [Időtartam] [Típus (1: Normál, 2: Válaszolós, 3: Írós)] [Indok]", sourcePlayer, 255, 255, 255, true)
        end
    end
end)

startedUnjail = {}
unjailedPlayers = {}

addCommandHandler("unjail", function(sourcePlayer, commandName, targetPlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "unjail") then
        if targetPlayer then
            targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)


            if targetPlayer then
                local accID = getElementData(targetPlayer, "char.accID")
                local adminName = getElementData(sourcePlayer, "acc.adminNick")
                local adminRank = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)

                if (getElementData(sourcePlayer, "acc.guardLevel") or 0) > 0 then
                    adminRank = "Egy RP Őr"
                    adminName = ""
                end

                if unjailedPlayers[targetPlayer] then
                    outputChatBox("[color=sightred][SightMTA - Hiba]: #ffffffA kiválaszott játékos nincs börtönben.", sourcePlayer, 255, 0, 0, true)
                    return
                end

                if not jailedPlayers[targetPlayer] then
                    outputChatBox("[color=sightred][SightMTA - Hiba]: #ffffffA kiválaszott játékos nincs börtönben.", sourcePlayer, 255, 0, 0, true)
                    return
                end

                if not (startedUnjail[sourcePlayer] or false) then
                    if not (startedUnjail[sourcePlayer] == targetPlayer) then
                        local prefix = "[color=sightred][SightMTA]: [color=hudwhite]"

                        local lines = {
                            "Biztosan ki szeretnéd venni a játékost a jailből?",
                            "Általa bebörtönözve: [color=sightred]"..jailedPlayers[targetPlayer].adminName,
                            "Indok: [color=sightred]"..jailedPlayers[targetPlayer].jailReason,
                            "Hátralévő idő: [color=sightred]"..jailedPlayers[targetPlayer].jailTime,
                            "Ha biztos vagy benne, [color=sightyellow]írd be újra a parancsot [color=hudwhite]ezzel a játékossal!"
                        }

                        for _, text in ipairs(lines) do
                            outputChatBox(prefix .. text, sourcePlayer)
                        end
            
                        startedUnjail[sourcePlayer] = targetPlayer
                        setTimer(function(playerElement)
                            startedUnjail[playerElement] = false
                        end, 60000, 1, sourcePlayer)
                        return
                    end
                end

                unjailedPlayers[targetPlayer] = true
                fadeCamera(targetPlayer, false, 1)
                setTimer(function()
                    unjailedPlayers[targetPlayer] = false
                    releasePlayerFromJail(targetPlayer)
                    fadeCamera(targetPlayer, true, 1)
                end, 1500, 1)

                dbExec(dbConnection, "UPDATE JAILS SET inActive = 1 WHERE accountIdentity = ? AND inActive = 0", accID)

                startedUnjail[sourcePlayer] = false

                outputChatBox("[color=sightgreen][SightMTA - Admin]: #ffffffSikeresen kivetted [color=sightgreen]" .. targetName .. "#ffffff-t a börtönből.", sourcePlayer, 255, 255, 255)
                outputChatBox("[color=sightgreen][SightMTA - Admin]: " .. adminRank .. " " .. adminName .. " #ffffffkivett a börtönből.", targetPlayer, 255, 255, 255)
                exports.sAdministration:showMessageForAdmins("[color=sightyellow][SightMTA - Jail]: "..adminRank .. " " .. adminName .. " #ffffffkivette [color=sightgreen]" .. targetName .. "#ffffff-t a börtönből.", 6)
            else
                outputChatBox("[color=sightred][SightMTA]: #ffffffNem található a játékos!", sourcePlayer, 255, 0, 0, true)
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/"..commandName.." [Játékos Név / ID]", sourcePlayer, 255, 255, 255, true)
        end
    end
end)


addEvent("sendJailAnswer", true)
addEventHandler("sendJailAnswer", root, function(pickedQuestion)
    if pickedQuestion and jailedPlayers[client] then
        local jailData = jailedPlayers[client]
        local accountIdentity = getElementData(client, "char.accID")

        if jailData.playerQuestion == pickedQuestion then
            jailData.jailTime = jailData.jailTime - 2
            exports.sGui:showInfobox(client, "s", "Jó válasz! 2 perc levonva az idődből!")
        else
            jailData.jailTime = jailData.jailTime + 5
            exports.sGui:showInfobox(client, "e", "Rossz válasz! 5 perc hozzáadva az idődhöz!")
        end

        jailData.waitingForAnswer = false

        if jailData.jailTime <= 0 then
            releasePlayerFromJail(client)
            dbExec(dbConnection, "UPDATE JAILS SET inActive = 1 WHERE accountIdentity = ? AND inActive = 0", accountIdentity)
        else
            dbExec(dbConnection, "UPDATE JAILS SET jailDuration = ? WHERE accountIdentity = ? AND inActive = 0", jailData.jailTime, accountIdentity)
            triggerClientEvent(client, "refreshJailTime", client, jailData.jailTime)

            setTimer(function()
                if isElement(client) and jailedPlayers[client] then
                    askJailQuestion(client)
                end
            end, 300000, 1)
        end
    end
end)

local charset = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890!-"
math.randomseed(os.clock())
function randomString(length)
	local ret = {}
	local r
	for i = 1, length do
		r = math.random(1, #charset)
		table.insert(ret, charset:sub(r, r))
	end
	return table.concat(ret)
end

function askJailQuestion(playerElement)
    if not isElement(playerElement) or not jailedPlayers[playerElement] then return end

    local jailData = jailedPlayers[playerElement]
    local randomQuestion = math.random(1, #adminJailQuestions)

    if jailData.jailType == 2 then
        local correctAnswer = adminJailQuestions[randomQuestion][5]
        jailData.playerQuestion = adminJailQuestions[randomQuestion][correctAnswer + 1]
        triggerClientEvent(playerElement, "gotJailQuestion", playerElement, 2, randomQuestion)
    elseif jailData.jailType == 3 then
        jailData.playerQuestion = randomString(8)
        triggerClientEvent(playerElement, "gotJailQuestion", playerElement, 3, jailData.playerQuestion)
    end

    jailedPlayers[playerElement].waitingForAnswer = true
end

addEvent("leftJailCol", true)
addEventHandler("leftJailCol", getRootElement(), function()
    if client and client == source then
        setElementDimension(client, jailedPlayers[client].jailCell)
        setElementInterior(client, 1)
        setElementPosition(client, 0.002356922486797, -1.1232511997223, 101.546875)
        setPedRotation(client, 180, true)
    else
        exports.sAnticheat:anticheatBan(client, "AC #65 - sJail @sourceS:553")
    end
end)

function releasePlayerFromJail(playerElement)
    if isElement(playerElement) and jailedPlayers[playerElement] then
        local accID = getElementData(playerElement, "char.accID")

        local spawnPosition = {1481.1533203125, -1756.5223388672, 17.59375, 0}

        if jailedPlayers[playerElement].icJailCell then
            local jailCell = jailedPlayers[playerElement].icJailCell
            spawnPosition = jailCells[jailCell].dropoff
        end

        jailedPlayers[playerElement] = nil
        occupiedCells[getElementDimension(playerElement)] = false

        setElementDimension(playerElement, spawnPosition[6] and spawnPosition[6] or 0)
        setElementInterior(playerElement, spawnPosition[5] and spawnPosition[5] or 0)
        setElementPosition(playerElement, spawnPosition[1], spawnPosition[2], spawnPosition[3])
        setPedRotation(playerElement, spawnPosition[4], true)

        exports.sGui:showInfobox(playerElement, "i", "Szabadultál a börtonből, Ezentúl viselkedj normálisan.")
        triggerClientEvent(playerElement, "refreshJailTime", playerElement, false)

        dbExec(dbConnection, "UPDATE JAILS SET inActive = 1 WHERE accountIdentity = ? AND inActive = 0", accID)
    end
end


addEvent("tryToJailPlayer", true)
addEventHandler("tryToJailPlayer", getRootElement(), function(jailPlayer, jailCell, jailTime, jailFine, jailReason, jailBail)
    if isElement(jailPlayer) then
        if exports.sGroups:getPlayerPermission(client, "jail") then
            local x, y, z = getElementPosition(client)
            local px, py, pz = getElementPosition(jailPlayer)
            if getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 30 then
                if getElementDimension(client) ~= 0 then
                    local accID = getElementData(jailPlayer, "char.accID")
                    local jailedName = getElementData(jailPlayer, "char.name")

                    local jailerIdentity = getElementData(client, "char.accID")
                    local jailerName = getElementData(client, "char.name"):gsub("_", " ") or "Ismeretlen"

                    local jailTime = tonumber(jailTime) or 0
                    local jailFine = tonumber(jailFine) or 0
                    local jailReason = jailReason or "Nincs megadva indok"

                    local columnNames = {}
                    local valueMarks = {}
                    local parameters = {}

                    local jailDatas = {
                        recordType = "jail",
                        punishedName = jailedName:gsub(" ", "_"),
                        recordBy = jailerName:gsub(" ", "_"),
                        description = jailReason,
                        recordTime = getRealTime().timestamp,
                        recordPunishment = jailTime .. "p",
                    }

                    for k, v in pairs(jailDatas) do
                        table.insert(columnNames, k)
                        table.insert(valueMarks, "?")
                        table.insert(parameters, v)
                    end

                    dbExec(dbConnection, "INSERT INTO mdc_records (" .. table.concat(columnNames, ",") .. ") VALUES (" .. table.concat(valueMarks, ",") .. ")", unpack(parameters))

                    outputChatBox("[color=sightred][SightMTA - Börtön]: [color=sightblue]"..jailerName.." [color=hudwhite]börtönbe zárt.", jailPlayer, 255, 255, 255, true)
                    outputChatBox("[color=sightred][SightMTA - Börtön]: [color=hudwhite]Idő: [color=sightblue]"..jailTime.." perc", jailPlayer, 255, 255, 255, true)
                    outputChatBox("[color=sightred][SightMTA - Börtön]: [color=hudwhite]Bírság: [color=sightblue]"..exports.sGui:thousandsStepper(jailFine).." $", jailPlayer, 255, 255, 255, true)
                    outputChatBox("[color=sightred][SightMTA - Börtön]: [color=hudwhite]Indok: [color=sightblue]"..jailReason, jailPlayer, 255, 255, 255, true)

                    placePlayerInJail(nil, jailPlayer, jailTime, 4, jailCell, jailReason, jailerName, jailFine, client, jailBail)


                    dbExec(dbConnection, "INSERT INTO JAILS (jailType, adminAccountId, adminName, jailTime, accountIdentity, jailReason, jailDuration, inActive, jailCell, jailBail) VALUES (?, ?, ?, ?, ?, ?, ?, 0, ?, ?)",
                        4, --Jailtype
                        jailerIdentity, --adminAccountId
                        "IC_"..jailerName, --adminName
                        getRealTime().timestamp, --jailTime
                        accID, --accountIdentity
                        jailReason, --jailReason
                        jailTime, --jailDuration
                        jailCell, --jailCell
                        jailFine or 0
                    )

                    outputChatBox("[color=sightgreen][SightMTA - Börtön]: [color=hudwhite]A kiválasztott játékos bebörtönzésre került!", client, 0, 255, 0, true)
                else
                    exports.sAnticheat:anticheatBan(client, "AC #119 - sJail @sourceS:638")
                end
            else
                exports.sAnticheat:anticheatBan(client, "AC #120 - sJail @sourceS:641")
            end
        else
            exports.sAnticheat:anticheatBan(client, "AC #121 - sJail @sourceS:644")
        end
    else
        outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A játékos nem található!", client, 255, 0, 0, true)
    end
end)

addCommandHandler("jailed", function(sourcePlayer, cmd)
    if exports.sPermission:hasPermission(sourcePlayer, "jailed") then
        local jailedList = {}

        for player, jailData in pairs(jailedPlayers) do
            if isElement(player) and jailData.jailType ~= 4 then
                local ID = getElementData(player, "playerID") or "N/A"
                local playerName = getElementData(player, "visibleName"):gsub("_", " ")
                local adminJailBy = jailData.adminName or "Ismeretlen"

                local info = string.format(
                    "[color=sightgreen][SightMTA]: #ffffffNév: [color=sightgreen]%s (ID: %s)\n[color=sightgreen][SightMTA]: #ffffffÁltala: [color=sightblue]%s #ffffff| Indok: %s\n[color=sightgreen][SightMTA]: #ffffffIdő: %d perc | Típus: %d",
                    playerName, ID, adminJailBy, jailData.jailReason or "Nincs indok", jailData.jailTime or 0, jailData.jailType or 0
                )

                table.insert(jailedList, info .. " \n ")
            end
        end

        if #jailedList > 0 then
            for _, msg in ipairs(jailedList) do
                outputChatBox(msg, sourcePlayer, 255, 255, 255, true)
            end
        else
            outputChatBox("[color=sightgreen][SightMTA]: #ffffffNincs online játékos admin jailben.", sourcePlayer, 255, 255, 255, true)
        end
    end
end)

addCommandHandler("prisoners", function(sourcePlayer)
    if exports.sGroups:getPlayerPermission(sourcePlayer, "prisoners") then
        local jailedList = {}

        for player, jailData in pairs(jailedPlayers) do
            if isElement(player) and jailData.jailType == 4 then
                local ID = getElementData(player, "playerID") or "N/A"
                local playerName = getElementData(player, "visibleName"):gsub("_", " ")
                local adminJailBy = jailData.adminName or "Ismeretlen"

                local info = string.format(
                    "[color=sightgreen][SightMTA]: #ffffffNév: [color=sightgreen]%s (ID: %s)\n[color=sightgreen][SightMTA]: #ffffffÁltala: [color=sightblue]%s #ffffff| Indok: %s\n[color=sightgreen][SightMTA]: #ffffffIdő: %d perc",
                    playerName, ID, adminJailBy, jailData.jailReason or "Nincs indok", jailData.jailTime or 0
                )

                table.insert(jailedList, info .. " \n ")
            end
        end

        if #jailedList > 0 then
            for _, msg in ipairs(jailedList) do
                outputChatBox(msg, sourcePlayer, 255, 255, 255, true)
            end
        else
            outputChatBox("[color=sightgreen][SightMTA]: #ffffffNincs online játékos börtönben.", sourcePlayer, 255, 255, 255, true)
        end
    end
end)