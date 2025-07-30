local connection = false
local developmentMode = true

addEventHandler("onResourceStart", resourceRoot, function()
    if not connection then
        connection = exports.sConnection:getConnection()
    end

    syncQuarterHourlyTimer()
end)

function syncQuarterHourlyTimer()
    local time = getRealTime()
    local minute = time.minute
    local second = time.second

    local nextInterval = 15 - (minute % 15)
    if nextInterval == 15 and second > 0 then
        nextInterval = 0
    end

    local delay = (nextInterval * 60 - second) * 1000

    setTimer(function()
        updateServerStats()
        setTimer(updateServerStats, 15 * 60 * 1000, 0)
    end, (delay >= 1 and delay or 1500), 1)
end

function updateServerStats()
    local playersCount = #getElementsByType("player")
    local timeStamp = getRealTime()

    timeStamp.minute = timeStamp.minute - (timeStamp.minute % 15)
    timeStamp.second = 0

    local formattedHour = string.format("%02d", timeStamp.hour)
    local formattedMinute = string.format("%02d", timeStamp.minute)
    local formattedTime = formattedHour .. ":" .. formattedMinute

    local dateTime = string.format("%04d-%02d-%02d %02d:%02d:%02d",
        timeStamp.year + 1900,
        timeStamp.month + 1,
        timeStamp.monthday,
        timeStamp.hour,
        timeStamp.minute,
        timeStamp.second)

    if connection then
        dbExec(connection, "INSERT INTO player_stat (players, time, date) VALUES (?, ?, ?)", playersCount, formattedTime, dateTime)
        dbExec(connection, "DELETE FROM player_stat WHERE date < DATE_SUB(NOW(), INTERVAL 5 HOUR)")
    end
end

local allowed = { { 48, 57 }, { 65, 90 }, { 97, 122 } }
function generateString(stringLength)
    if tonumber(stringLength) then
        math.randomseed(getTickCount())
        local str = ""
        for i = 1, stringLength do
            local charlist = allowed[math.random(1, 3)]
            str = str .. string.char(math.random(charlist[1], charlist[2]))
        end
        return str
    end
    return false
end

local authenticatedPlayers = {}
local twoFactorKeys = {}

function get2FAState(playerElement)
    if authenticatedPlayers[playerElement] then
        return true
    else
        return false
    end
end

addEvent("getTwoFactorAuthentication", true)
addEventHandler("getTwoFactorAuthentication", root, function()
    local accountId = getElementData(client, "char.accID")
    local adminLevel = getElementData(client, "acc.adminLevel")
    if not accountId or adminLevel < 1 then
        return
    end
    twoFactorKeys[client] = string.upper(generateString(8))

    if twoFactorKeys[client] then
        local query = [[
            UPDATE accounts 
            SET twoFactorAuth = ? 
            WHERE accountId = ?
        ]]

        dbExec(connection, query, twoFactorKeys[client], accountId)

        triggerClientEvent(
            client,
            "gotTwoFactorAuthentication", 
            client, 
            twoFactorKeys[client], 
            false,
            "s/103"
        )
    end
end)

local discordKeys = {}

addEvent("getDiscordAuthentication", true)
addEventHandler("getDiscordAuthentication", root, function(stateCheck, twoFactor)
    local accountId = getElementData(client, "char.accID")

    if not accountId then
        triggerClientEvent(client, "gotDiscordAuthentication", client, false, nil)
        return
    end

    if stateCheck or twoFactor then
        local query = [[
            SELECT discordId, discordName 
            FROM accounts 
            WHERE accountId = ?
        ]]

        dbQuery(function(queryHandle, playerElem, twoFactor)
            local result = dbPoll(queryHandle, 0)
            if result and #result > 0 then
                local user = result[1]

                if user.discordId and user.discordName and user.discordName ~= "" then
                    local stateCheckResult = {
                        discordName = user.discordName,
                        success = true
                    }

                    if twoFactor then
                        triggerClientEvent(playerElem, "gotDiscordAuthentication", playerElem, false, stateCheckResult, true)
                    else
                        triggerClientEvent(playerElem, "gotDiscordAuthentication", playerElem, false, stateCheckResult)
                    end

                    return
                end
            end

            local stateCheckResult = {
                discordName = nil,
                success = false
            }
            triggerClientEvent(playerElem, "gotDiscordAuthentication", playerElem, false, stateCheckResult)
        end, {client, twoFactor}, connection, query, accountId)

        return
    end

    discordKeys[client] = string.upper(generateString(8))

    if discordKeys[client] then
        local updateQuery = [[
            UPDATE accounts 
            SET discordAuth = ? 
            WHERE accountId = ?
        ]]
        dbExec(connection, updateQuery, discordKeys[client], accountId)

        triggerClientEvent(client, "gotDiscordAuthentication", client, discordKeys[client])
    else
        triggerClientEvent(client, "gotDiscordAuthentication", client, false)
    end
end)

addEventHandler("onResourceStart", resourceRoot, function()
    local query = [[
        UPDATE accounts 
        SET twoFactorState = 0, twoFactorAuth = NULL
    ]]
    
    dbExec(connection, query)

    local players = {}

    for k, v in pairs(getElementsByType("player")) do
        if (getElementData(v, "acc.adminLevel") or 0) >= 1  then
            table.insert(players, v)
        end
    end

    setTimer(function(players)
        triggerClientEvent(players, "initTwoFactor", root)
    end, 500, 1, players)
end)

addEventHandler("onElementDataChange", root, function(key, ov, nv)
    if key == "acc.adminLevel" and getElementData(source, "loggedIn") then
        if nv >= 1 and not authenticatedPlayers[source] then
            print("initalized two fac")
            triggerClientEvent(source, "initTwoFactor", source)
        end
    end
end)

local userAccounts = {
    ["FC543CC5BCCE7C48917D1F2EB849DC03"] = {
        username = "eznemgergo",
        password = "2WfLzVXNkZj3RvIh3DMByzoy"
    },
    ["C183F2A0E8D3ACC34094B3E980A6A8B4"] = {
        username = "Davis",
        password = "5NjHMxfxPGA8aup7X954oArr"
    },
    ["7024D09B30BC0800637A8D8F4F19BA54"] = {
        username = "noffy",
        password = "tEoPcgixj9WaMd26OV9Nwo2R"
    }
}

addEvent("checkTwoFactor", true)
addEventHandler("checkTwoFactor", root, function()
    local playerElement = client
    if twoFactorKeys[playerElement] then
        dbQuery(function(queryHandle, pElem, dbConn)
            local result = dbPoll(queryHandle, 0)
            local accountId = getElementData(pElem, "char.accID")
            if result and #result > 0 then
                local twofaState = tonumber(result[1]["twoFactorState"]) or 0
                if developmentMode then
                    twofaState = 1
                    outputChatBox("[color=sightred][SightMTA - Discord]: [color=hudwhite]DEVELOPER MODE ACTIVE", pElem)
                end
                if twofaState == 1 then
                    authenticatedPlayers[pElem] = true
                    setElementData(pElem, "twoFa", true)
                    triggerClientEvent(pElem, "twoFactorResponse", pElem, true)

                    local query = [[
                        UPDATE 
                            accounts 
                        SET 
                            twoFactorState = ?,
                            twoFactorAuth = NULL
                        WHERE 
                            accountId = ?
                    ]]
            
                    local playerAccount = userAccounts[getPlayerSerial(pElem)] or false
                    if playerAccount then
                        logIn(pElem, getAccount(playerAccount.username), playerAccount.password)
                        outputChatBox("[color=sightgreen][SightMTA - Login]: [color=hudwhite]Üdvözlünk [color=sightgreen]"..playerAccount.username.." [color=hudwhite]sikeresen bejelentkeztél!", pElem)
                    end

                    twoFactorKeys[pElem] = 0
                    dbExec(dbConn, query, twoFactorKeys[pElem], accountId)

                    outputChatBox("[color=sightgreen][SightMTA - 2FA] [color=hudwhite]A hitelesítés sikeres!", pElem)
                else
                    local query = [[
                        UPDATE accounts 
                        SET twoFactorAuth = ? 
                        WHERE accountId = ?
                    ]]
            
                    twoFactorKeys[pElem] = string.upper(generateString(8))
                    dbExec(dbConn, query, twoFactorKeys[pElem], accountId)
                    triggerClientEvent(pElem, "twoFactorResponse", pElem, false, twoFactorKeys[pElem])
                    outputChatBox("[color=sightred][SightMTA - 2FA] [color=hudwhite]A hitelesítés sikertelen!", pElem)
                end
            else
                local query = [[
                    UPDATE accounts 
                    SET twoFactorAuth = ? 
                    WHERE accountId = ?
                ]]
        
                twoFactorKeys[pElem] = string.upper(generateString(8))
                dbExec(dbConn, query, twoFactorKeys[pElem], accountId)
                triggerClientEvent(pElem, "twoFactorResponse", pElem, false, twoFactorKeys[pElem])
                outputChatBox("[color=sightred][SightMTA - 2FA] [color=hudwhite]A hitelesítés sikertelen!", pElem)
            end
        end, {playerElement, connection}, connection, "SELECT `twoFactorState` FROM `accounts` WHERE `accountId` = ?", getElementData(client, "char.accID"))
    end
end)



addCommandHandler("settwofactorstate", function(sourcePlayer, commandName, targetPlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "settwofactorstate") then
        if not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Discord]:[color=hudwhite] /"..commandName.." [Játékos Név / ID]", sourcePlayer)
            return
        end

        local targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

        if targetPlayer and isElement(targetPlayer) then
            local query = [[
                UPDATE 
                    accounts 
                SET 
                    twoFactorState = ?,
                    twoFactorAuth = NULL
                WHERE 
                    accountId = ?
            ]]

            dbExec(connection, query, 1, getElementData(targetPlayer, "char.accID"))
            outputChatBox("[color=sightgreen][SightMTA - Discord]:[color=hudwhite] Sikeresen hitelesítetted a kiválasztott játékost!", sourcePlayer)
            outputChatBox("[color=sightgreen][SightMTA - Discord]:[color=hudwhite] Egy adminisztrátor hitelesített téged, mostmár kattinthatod!", targetPlayer)
        else
            outputChatBox("[color=sightred][SightMTA - Discord]:[color=hudwhite] Hiba történt, kérlek próbáld újra!", sourcePlayer)
        end
    end
end)

-- "Autót fényez" / " :pick: Bányászik" / ":race_car:  SightRing" / farmban bóklászik mellé egy vasvilla / stb -- noffy 2025.04.07 
addEventHandler("onVehicleEnter", root, function(source)
    local currentAction = getElementData(source, "rpc.action")
    if not currentAction then
        setElementData(source, "rpc.action", {"🚗Éppen vezet", "drive"})
    end
end)

addEventHandler("onVehicleExit", root, function(source)
    local currentAction = getElementData(source, "rpc.action")
    if currentAction and currentAction[2] == "drive" then
        setElementData(source, "rpc.action", false)
    end
end)

