local anticheatFunctions = {}
local anticheatKicks = {}
local anticheatGsubs = {
    ["  "] = "",
    ["{"] = "```",
    ["}"] = "```",
}

anticheatFunctions["webhookCallBack"] = function(data, info)

end

anticheatFunctions["sendWebhookMessage"] = function(message)
    if message then
        local data = {
            embeds = {
                {
                    title = "**Anti-Cheat Alert**",
                    description = "",
                    fields = {
                        {
                            name = "**Alert Details**",
                            value = "```" .. message .. "```",
                            inline = false
                        }
                    },
                    color = 16711680,
                    footer = {
                        text = "Anti-Cheat System",
                    },
                    timestamp = getRealTime().timestamp
                }
            }
        }

        local jsonData = toJSON(data, true)
        local contentLength = tostring(#jsonData)

        local sendOptions = {
            method = "POST",
            headers = {
                ["Content-Type"] = "application/json",
                ["Content-Length"] = contentLength,
            },
            postData = jsonData
        }

        fetchRemote("https://discord.com/api/webhooks/1359847978558296154/6SjCdFn0yhyUGnse-doOoeS2_RUWdxNng8x4BydeG7r0Zy0Y7xEg71hxthYEJN6f_xep", sendOptions, anticheatFunctions["webhookCallBack"])
    end
end

local responseTicks = {}
local validPlayers = {}

aesKey = "jCaL5JIdUkHNojmu"

function onPlayerResourceStart(startedResource)
	local resourceName = getResourceName(startedResource)
    if resourceName == "sLast" or (startedResource == getThisResource() and getElementData(source, "loggedIn")) then

        local player = source

        triggerClientEvent(player, "startHeartBeat", player)
        validPlayers[player] = {true, false}

        local serial = getPlayerSerial(player)

        local hashedSerial, iv = encodeString("aes128", serial, {key = aesKey})

        triggerClientEvent(player, "onPlayerCacheInfo", player, serial, {hashedSerial, iv}, aesKey)

        setTimer(function(player)
            anticheatFunctions.processPlayer(player)
        end, 100000, 1, player)
    end
end
addEventHandler("onPlayerResourceStart", root, onPlayerResourceStart)


anticheatFunctions["processPlayer"] = function(playerElement)
    if validPlayers[playerElement] and validPlayers[playerElement][2] then
        validPlayers[playerElement] = {true, false}
    else
        if not validPlayers[playerElement] then
        else
            anticheatBan(playerElement, "0x04 - removeDebugHook - FRENK", {
                banReason = "removeDebughook",
            }, true)
        end
    end
end


addEvent("sendACHeartBeat", true)
addEventHandler("sendACHeartBeat", root, function()
    local tbl = {"got heartbeat from", inspect(client), getRealTime().timestamp}
end)

addEvent(getResourceName(getThisResource()).."::gotFrenkStatus", true)
addEventHandler(getResourceName(getThisResource()).."::gotFrenkStatus", root, function()
    if validPlayers[client] then
        local anticheatState = validPlayers[client] and validPlayers[client][2]
        if not anticheatState then
            validPlayers[client][2] = true
        end
    end
end)

anticheatFunctions["banPlayer"] = function(player, reason, details)
    if player and reason then
        local details = details or {}
        
        details.playerSerial = getPlayerSerial(player)
        details.playerIP = getPlayerIP(player)
        details.playerName = getPlayerName(player)

        table.sort(details, function(a, b)
            return a > b
        end)

        local message = inspect(details)

        for key, value in pairs(anticheatGsubs) do
            message = message:gsub(key, value)
        end
        
        local serial = getPlayerSerial(player)
        if anticheatKicks[serial] then
            --print("Ban : ", reason)
            banPlayer(player, true, false, true, config.name, reason)
        else
            anticheatKicks[serial] = true
            --print("Kick : ", reason)
            kickPlayer(player, reason)
        end

        if reason == "addDebugHook" then

            local embedDatas = {
                username = "SightMTA - Anticheat [DEBUGHOOK ALERT]",
                title = "Megpróbált hozzáadni egy debughookot!",

                color = "sightred",
                embedData = {
                    embedFields = {
                        {
                            name = "Játékos neve - [Serialja]",
                            value = "```"..getElementData(player, "visibleName"):gsub("_", " ").. " - ".. getPlayerSerial(player).."```",
                            inline = true
                        },
                    },
                },
            }

            exports.sAnticheat:sendEmbedMessage(embedDatas, "anticheat")
        end

        if reason == "removeDebugHook" then

            local embedDatas = {
                username = "SightMTA - Anticheat [DEBUGHOOK ALERT]",
                title = "Megpróbált eltávolítani egy debughookot!",

                color = "sightred",
                embedData = {
                    embedFields = {
                        {
                            name = "Játékos neve - [Serialja]",
                            value = "```"..getElementData(player, "visibleName"):gsub("_", " ").. " - ".. getPlayerSerial(player).."```",
                            inline = true
                        },
                    },
                },
            }

            exports.sAnticheat:sendEmbedMessage(embedDatas, "anticheat")
        end

        if reason == "changedSerial#1" then

            local embedDatas = {
                username = "SightMTA - Anticheat [SERIALCHANGE ALERT]",
                title = "Clientside serial nem egyezik meg a serverside seriallal!",

                color = "sightred",
                embedData = {
                    embedFields = {
                        {
                            name = "Játékos neve - [Serialja]",
                            value = "```"..getElementData(player, "visibleName"):gsub("_", " ").. " - ".. getPlayerSerial(player).."```",
                            inline = true
                        },
                    },
                },
            }

            exports.sAnticheat:sendEmbedMessage(embedDatas, "anticheat")
        end
    end
end

local limits = {
    ["money"] = 100000000,
    ["bankmoney"] = 1000000,
    ["premiumpoints"] = 1000000,
    ["ssc"] = 1000000,
}

function playerEconomyDataChange(source, dataName, oldValue, newValue)
    if limits[dataName] then
        if newValue > limits[dataName] then
            for key, player in pairs(getElementsByType("player")) do
                local adminLevel = getElementData(player, "acc.adminLevel") or 0

                if adminLevel >= 7 then
                    local playerName = getElementData(source, "visibleName"):gsub("_", " ")
                    local playerID = getElementData(source, "playerID")
                end
            end
        end
    end

    if client then
        local type = getElementType(source)

        if dataName and config.protectedElementDatas[type] and config.protectedElementDatas[type][dataName] then
            --setElementData(source, dataName, oldValue)

            --AC ALERTET VAGY VALAMIT IRNI
            --[[
            anticheatFunctions.banPlayer(client, "0x01", {
                banReason = "Suspicious E-DATA CHANGE",
                dataName = dataName,
                dataOldValue = oldValue,
                dataNewValue = newValue
            })
                ]]
        end
    end
end

addEventHandler("onPlayerTriggerEventThreshold", getRootElement(), function()
    --anticheatFunctions.banPlayer(source, "0x02", {
    --    banReason = "Player has been reached event limit"
    --})
end)

addEventHandler("onPlayerWeaponSwitch", getRootElement(), function(previousWeaponID, currentWeaponID)
    if config.blockedWeapons[previousWeaponID] or config.blockedWeapons[currentWeaponID] then
        anticheatFunctions.banPlayer(source, "0x03", {
            banReason = "Player switched to an illegal weapon",
            previousWeapon = getWeaponNameFromID(previousWeaponID) .. " (" .. previousWeaponID .. ")",
            currentWeapon = getWeaponNameFromID(currentWeaponID) .. " (" .. currentWeaponID .. ")"
        })
    end
end)

addEventHandler("onPlayerWeaponFire", getRootElement(), function()
    local weapon = getPedWeapon(source)

    if config.blockedWeapons[weapon] then
        anticheatFunctions.banPlayer(source, "0x04", {
            banReason = "Player fired an illegal weapon",
            firedWeapon = getWeaponNameFromID(weapon) .. " (" .. weapon .. ")",
        })
    end
end)

addEvent("sight::reportPlayer", true)
addEventHandler("sight::reportPlayer", getRootElement(), function(reason, details)
    anticheatFunctions.banPlayer(client, reason, details)
end)

local vpnConfiguration = {}
vpnConfiguration.startCheck = true
vpnConfiguration.avoidedIp = {
    "127.0.0.1",
}
vpnConfiguration.avoidedSerials = {
    "7F32DDC85AAC02BCAC80C701B4C278B3",
}

addEventHandler("onResourceStart", getRootElement(), function(res)
    if res == getThisResource() and vpnConfiguration.startCheck then
        local players = getElementsByType("player")

        setTimer(function()
            for _, playerElement in pairs(getElementsByType("player")) do
                anticheatFunctions.processPlayer(playerElement)
            end
        end, 108000, 0)

        for i = 1, #players do
            if players[i] then
                setTimer(checkVPN, i * 100, 1, players[i])
            end
        end
    end
end)

local fetchUsages = 0

function checkVPN(player)
    if isElement(player) then
        local ip = getPlayerIP(player)

        for key, serial in pairs(vpnConfiguration.avoidedSerials) do
            if serial == getPlayerSerial(player) then
                return false 
            end
        end

        for key, ip2 in pairs(vpnConfiguration.avoidedIp) do
            if ip == ip2 then
                return false
            end
        end

        fetchRemote("http://proxy.mind-media.com/block/proxycheck.php?ip=" .. ip, function(response, error)
            if error == 0 then
                if response == "Y" then
                    anticheatFunctions.banPlayer(player, "0x08", {
                        banReason = "ANITVPN",
                    })
                end
            else
                logVPNCheck("fetch-fail", {tostring(ip), "proxy.mind-media"}, player)
            end
        end)

        fetchRemote("https://api.ipdetective.io/ip/".. ip .."?info=true", {
            method = "GET",
            headers = {
                ["x-api-key"] = "bb2fa1f0-d80b-4d1e-a7e5-706d69d1cd77"
            }
        }, function(response, error)
            fetchUsages = fetchUsages + 1
            if error.statusCode == 200 then
                local response = fromJSON(response)
                if response then
                    if response.bot then
                        anticheatFunctions.banPlayer(player, "0x08", {
                            banReason = "ANITVPN",
                        })
                    else
                        logVPNCheck("connection-info", {tostring(response.country_name), tostring(response.ip)}, player)
                        if fetchUsages == 900 then
                            logVPNCheck("fetch-count-alert", {fetchUsages}, player)
                        end
                    end
                else
                    logVPNCheck("fetch-fail", {tostring(ip), "ipdetective [2]"}, player)
                end
            else
                logVPNCheck("fetch-fail", {tostring(ip), "ipdetective ["..error.statusCode.."]"}, player)
            end
        end)
    end
end

function logVPNCheck(reportType, reportDetails, userElem)
    local reportTypeTexts = {
        ["connection-info"] = {
            "Egy játékos csatlakozott a szerverre.",
            embedFields = {
                {
                    name = "Játékos neve",
                    value = "```"..getPlayerName(userElem):gsub("_", " ").."```",
                    inline = true
                },
                {
                    name = "Ország",
                    value = "```"..reportDetails[1].."```",
                    inline = true
                },
                {
                    name = "Játékos IP címe",
                    value = "```"..(reportDetails[2] or "Ismeretlen").."```",
                }
            },
        },
        ["fetch-fail"] = {
            "IP Cím lekérési hiba",
            embedFields = {
                {
                    name = "Játékos neve",
                    value = "```"..getPlayerName(userElem):gsub("_", " ").."```",
                    inline = true
                },
                {
                    name = "IP Cím",
                    value = "```"..reportDetails[1].."```",
                    inline = true
                },
                {
                    name = "VPN Checker",
                    value = "```"..(reportDetails[2] or "Ismeretlen").."```"
                }
            },
        },
        ["fetch-count-alert"] = {
            "API Kérések száma magas!",
            embedFields = {
                {
                    name = "Jelenlegi szám",
                    value = "```"..reportDetails[1].."```",
                    inline = true
                },
                {
                    name = "Megengedett",
                    value = "```1000```",
                    inline = true
                },
            },
        },
    }

    local embedDatas = {
        username = "SightMTA - Log [Anticheat]",
        title = reportTypeTexts[reportType][1].." | SightMTA | sightmta.hu",
        color = "sightred",

        embedData = {
            embedFields = reportTypeTexts[reportType].embedFields
        },
    }

    exports.sAnticheat:sendEmbedMessage(embedDatas, "vpnlog")
end

addEventHandler("onPlayerJoin", getRootElement(), function()
	checkVPN(source)
end)

function anticheatBan(playerElement, banReason, onlyKick)
    --outputChatBox("[color=sightred]Anticheat - BAN: "..inspect(playerElement).. " - "..banReason)
    if isElement(playerElement) then
        if onlyKick then
            redirectPlayer(playerElement, "212.73.137.123", 22003)
        else
            banPlayer(playerElement, true, true, true, "frenk (AC)", banReason)
        end
    end
end

local highStackAlerts = {
    --ItemID - Amount
    [1] = 20,
    [2] = 1,
}

local exceptionPlayers = {
    ["FC543CC5BCCE7C48917D1F2EB849DC03"] = true,  --* eznemgergo
    ["7024D09B30BC0800637A8D8F4F19BA54"] = true,  --* noffy
    ["C183F2A0E8D3ACC34094B3E980A6A8B4"] = true,  --* Davis
}

function getStackAlerts(itemId)
    if highStackAlerts[itemId] then
        return highStackAlerts[itemId]
    else
        return 30
    end
end

function getAdminPlayers()
    local adminPlayers = {}
    for k, v in ipairs(getElementsByType("player")) do
        if getElementData(v, "acc.adminLevel") and getElementData(v, "acc.adminLevel") >= 1 then
            table.insert(adminPlayers, v)
        end
    end
    return adminPlayers
end

--StackAlert
function stackAlert(playerElement, itemData, targetId, targetType)

    if exceptionPlayers[getPlayerSerial(playerElement)] then
        return
    end

    local embedDatas = {
        username = "SightMTA - Items [STACK ALERT]",
        title = "Egy játékosnak nagyobb stackje van egy itemből!",

        color = "sightred",
        embedData = {
            embedFields = {
                {
                    name = "Játékos neve - [Account ID]",
                    value = "```"..getElementData(playerElement, "visibleName"):gsub("_", " ").. " - ".. getElementData(playerElement, "char.ID").."```",
                    inline = true
                },
                {
                    name = "Item adatai - [Item neve - Mennyiség]",
                    value = "```".. exports.sItems:getItemName(tonumber(itemData.itemId)) .." - "..tostring(itemData.amount).."```",
                    inline = true
                },
                {
                    name = "",
                    value = "",
                    inline = false
                }
            },
        },
    }

    if targetId and targetType then
        table.insert(embedDatas.embedData.embedFields, {
            name = targetType == "vehicle" and "Jármű" or "Széf" .. " ID",
            value = "```"..tostring(targetId).."```",
        })
    end
    exports.sAnticheat:sendEmbedMessage(embedDatas, "stackalert")

    outputChatBox("[color=sightred][SightMTA - Stack Alert]: [color=hudwhite]Egy játékos nagy mennyiségű azonos típusú itemmel rendelkezik! [color=sightred][" .. getElementData(playerElement, "char.name"):gsub("_", " ") .. " l " .. exports.sItems:getItemName(tonumber(itemData.itemId)) .. " l " .. tostring(itemData.amount) .. "]", getAdminPlayers())
end