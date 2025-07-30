local connection = false

addEventHandler("onResourceStart", getRootElement(), function(res)
    local resName = getResourceName(res)

    if res == getThisResource() then
        connection = exports.sConnection:getConnection()
    elseif resName == "sConnection" then
        connection = exports.sConnection:getConnection()
    end
end)

local _addCommandHandler = addCommandHandler
function addCommandHandler(commandName, commandFunction, requiredPermission)
    local function permissionWrapper(playerSource, ...)
        if not requiredPermission or exports.sPermission:hasPermission(playerSource, requiredPermission) then
            commandFunction(playerSource, ...)
        end
    end

    if type(commandName) == "string" then
        _addCommandHandler(commandName, permissionWrapper)
    else
        for _, commandAlias in ipairs(commandName) do
            _addCommandHandler(commandAlias, permissionWrapper)
        end
    end
end

-- Formázás ha valamikor kellene írni legközelebb:
--Adminparancsokhoz általában ezek
-- [color=sightblue][SightMTA - Használat][color=hudwhite]
-- [color=sightgreen][SightMTA - Siker][color=hudwhite]
-- [color=sightred][SightMTA - Hiba][color=hudwhite]
-- [SightMTA] -> Ha a player látja
--Ha kifejezetten resourcehöz írod: // Szín: használat - sightblue ; hiba - sightred ; siker - sightgreen // 1-2 random színt bedobhatsz pl. sightyellow
-- [SightMTA - BlackJack]
-- [SightMTA - Farm]
-- [SightMTA - Horsee]
-- [SightMTA - Lefoglalás] (impound)
-- [SightMTA - Runcode]
-- [SightMTA - Interior]
-- [SightMTA - Discord]
-- [SightMTA - AranyBank] (goldrob)
-- [SightMTA - Luraph]
-- [SightMTA - Coupon]
-- [SightMTA - ShutDown]
-- [SightMTA - Bánya]
-- [SightMTA - Kick]
-- [SightMTA - Bank]
-- [SightMTA - Phone]
-- [SightMTA - Premium]
-- [SightMTA - PED]

-- [color=sightgreen][SightMTA - [color=sightblue]AdminNapló][color=hudwhite] -> Adminisztrátori logok
-- Ilyenek is léteznek: -- [color=sightgreen][SightMTA - [color=sightblue]AdminNapló][color=hudwhite] / SightMTA - Resources (resourcenapló) / SightMTA - Ban (?) 

local deathTypes = {
    [19] = "robbanás",
    [37] = "égés",
    [49] = "autóbaleset",
    [50] = "autóbaleset",
    [51] = "robbanás",
    [52] = "elütötték",
    [53] = "fulladás",
    [54] = "esés",
    [55] = "ismeretlen",
    [56] = "verekedés",
    [57] = "fegyver",
    [59] = "tank",
    [63] = "robbanás",
    [0] = "verekedés"
}

local weaponNames = {
    Rammed = "autóbaleset",
    shovel = "Csákány",
    ["colt 45"] = "Glock 17",
    silenced = "Hangtompítós Colt-45",
    rifle = "Vadász puska",
    sniper = "Remington 700",
    mp5 = "P90"
}


addEventHandler("onPlayerWasted", getRootElement(), function(_, playerKiller, weapon, bodypart)
    local x, y, z = getElementPosition(source)
    local int = getElementInterior(source)
    local dim = getElementInterior(source)
    setElementData(source, "deathPosition", {x, y, z, int, dim})
    
    local time = getRealTime(getRealTime().timestamp)

    time = "[" .. string.format("%04d.%02d.%02d %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second) .. "] "

    local killedName = getElementData(source, "visibleName"):gsub("_", " ")
    local deathText = ""
    local customText = getElementData(source, "customDeath") or false

    local isHeadshot = false
    local killerElement = false
    local zoneName = false
    local weaponName = false

    if type(customText) == "table" then
        killerElement = customText[1]
        isHeadshot = customText[2]
        weaponName = customText[3]
        zoneName = customText[4]
        customText = weaponName .. " - " .. zoneName
    end

    if customText then
        deathText = "(" .. customText .. ")"
    end

    if weapon and deathTypes[weapon] and deathText == "" then
        deathText = " ("..deathTypes[weapon]..")"
    end

    local adminPlayers = {}
    for playerIdentity, playerElement in ipairs(getElementsByType("player")) do
        if (getElementData(playerElement, "acc.adminLevel") or 0) >= 1 then
            table.insert(adminPlayers, playerElement)
        end
    end


    if isElement(killerElement) then
        local killerType = getElementType(killerElement)

        local killerName = ""

        if killerType == "player" then
            killerName = getElementData(killerElement, "visibleName"):gsub("_", " ")
        elseif killerType == "vehicle" then
            local vehdriver = getVehicleController(killerElement)

            if vehdriver then
                killerName = getElementData(vehdriver, "visibleName"):gsub("_", " ")
            else
                killerName = "Egy jármű"
            end
        end

        setElementData(source, "customDeath", false)
        local deathType = isHeadshot and "fejbelőtte" or "megölte"
        outputChatBox(time .. killerName .. " " .. deathType .. " " .. killedName .. "-t." .. deathText, adminPlayers, 175, 175, 175)
    else
        outputChatBox(time .. killedName .. " meghalt. " .. deathText, adminPlayers, 175, 175, 175)
    end
end, false, "high")

local damageNames = {
    [1] = "Jobb kéz",
    [2] = "Bal kéz",
    [3] = "Jobb láb",
    [4] = "Bal láb"   
}

local spectatedPlayers = {}

function logAdministrator(requiredLevel, message)
    for _, playerElement in pairs(getElementsByType("player")) do
        if getElementData(playerElement, "acc.adminLevel") >= requiredLevel then
            outputChatBox(message)
        end
    end
end
--kesz
function spectateCommand(client, commandName, targetPlayer)
    if exports.sPermission:hasPermission(client, "spectate") then
        local state = getElementData(client, "spectateTarget")
        local clientAdminLevel = getElementData(client, "acc.adminLevel")
        local adminNick = getElementData(client, "acc.adminNick")
        local adminTitle = getPlayerAdminTitle(client) .. " " .. adminNick

        if state then
            setElementData(client, "spectateTarget", false)
            setCameraTarget(client, client)
            setElementAlpha(client, 255)
            spectatedPlayers[state] = nil

            for k, v in pairs(getElementsByType("player")) do
                local adminLevel = getElementData(v, "acc.adminLevel")

                if adminLevel and adminLevel > 0 then
                    if not getElementData(v, "urmaChat") and ((clientAdminLevel <= 5 and adminLevel <= 5) or adminLevel > 5) then
                        outputChatBox("[color=hudwhite][TV] " .. adminTitle .. " [color=hudwhite]kikapcsolta a TV-zést.", v)
                    end
                    if getElementData(v, "urmaChat") then
                        outputChatBox("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló]: [TV] " .. adminTitle .. " kikapcsolta a TV-zést.", v, 255, 150, 0, true)
                    end
                end
            end
        else
            if exports.sPermission:hasPermission(client, "spectate") then
                if targetPlayer then
                    local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

                    if isElement(targetPlayer) and targetPlayer ~= client then
                        setElementData(client, "spectateTarget", targetPlayer)
                        setElementAlpha(client, 0)
                        setCameraTarget(client, targetPlayer)
                        spectatedPlayers[targetPlayer] = client

                        for k, v in pairs(getElementsByType("player")) do
                            local adminLevel = getElementData(v, "acc.adminLevel")
    
                            if adminLevel and adminLevel > 0 then
                                if not getElementData(v, "urmaChat") and ((clientAdminLevel <= 5 and adminLevel <= 5) or adminLevel > 5) then
                                    outputChatBox("[color=hudwhite][TV] " .. adminTitle .. " [color=hudwhite]elkezdte TV-zni [color=sightblue]" .. targetName .. " [color=hudwhite]játékost.", v)
                                end
                                if getElementData(v, "urmaChat") then
                                    outputChatBox("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló]: [TV] " .. adminTitle .. " elkezdte TV-zni " .. targetName .. " játékost.", v, 255, 150, 0, true)
                                end
                            end
                        end
                    end
                else
                    outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Név / ID]", client, 255, 255, 255, true)
                end
            end
        end
    end
end
addCommandHandler("spec", spectateCommand)
addCommandHandler("spectate", spectateCommand)
addCommandHandler("recon", spectateCommand)


function getSpectatePlayers(sourcePlayer)
    if spectatedPlayers[sourcePlayer] then
        return spectatedPlayers[sourcePlayer]
    end
end

addEvent("updateSpectatePosition", true)
addEventHandler("updateSpectatePosition", getRootElement(), function(int, dim)
    if exports.sPermission:hasPermission(client, "spectate") then
        if getElementData(client, "spectateTarget") then
            setElementInterior(client, int)
            setElementDimension(client, dim)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #72 - sAdministration @sourceS:197")
    end
end)

addEvent("markIntDim", true)
addEventHandler("markIntDim", getRootElement(), function(int, dim)
    if exports.sPermission:hasPermission(client, "gotomark") then
        setElementInterior(client, int)
        setElementDimension(client, dim)
    else
        exports.sAnticheat:anticheatBan(client, "AC #73 - sAdministration @sourceS:207")
    end
end)

addEvent("markVehicle", true)
addEventHandler("markVehicle", getRootElement(), function(x, y, z, int, dim)
    if exports.sPermission:hasPermission(client, "gotomark") then
        local veh = getPedOccupiedVehicle(client)
        if veh then
            setElementPosition(veh, x, y, z)
            setElementInterior(veh, int)
            setElementDimension(veh, dim)
        end

        setElementInterior(client, int)
        setElementDimension(client, dim)
    else
        exports.sAnticheat:anticheatBan(client, "AC #73 - sAdministration @sourceS:224")
    end
end)

addEventHandler("onElementDestroy", getRootElement(), function()
    if spectatedPlayers[source] then
        spectateCommand(spectatedPlayers[source])
    end
end)

addEventHandler("onElementQuit", getRootElement(), function()
    if spectatedPlayers[source] then
        spectateCommand(spectatedPlayers[source])
    end
end)
--kesz
addCommandHandler("crash", function (sourcePlayer, commandName, targetPlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "crashplayer") then
        if not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Játékos Név / ID].", sourcePlayer, 255, 255, 255, true)
        else
            local targetPlayerObj, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
            if targetPlayerObj then
                triggerClientEvent(targetPlayerObj, "onPlayerCrashFromServer", targetPlayerObj)
                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Kifagyasztottad a játékost", sourcePlayer, 255, 255, 255, true)

                local adminName = getElementData(sourcePlayer, "acc.adminNick") or getPlayerName(sourcePlayer)
                local adminRank = getPlayerAdminTitle(sourcePlayer)
                
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminRank .. " " .. adminName .. " #ffffffkifagyasztotta [color=sightgreen]" .. targetName .. " #ffffffjátékost.")
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található ilyen játékos.", sourcePlayer, 255, 255, 255, true)
            end
        end
    end
end)

addCommandHandler("forcereconnect", function(sourcePlayer, commandName, targetPlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "forcereconnect") then
        if not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Játékos Név / ID].", sourcePlayer, 255, 255, 255, true)
        else
            local targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

            if targetPlayer and isElement(targetPlayer) then
                if redirectPlayer(targetPlayer, "connect.sightmta.hu", 22003) then
                    local adminName = getElementData(sourcePlayer, "acc.adminNick") or getPlayerName(sourcePlayer)
                    local adminRank = getPlayerAdminTitle(sourcePlayer)

                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminRank .. " " .. adminName .. " [color=hudwhite]Újracsatlakoztatta [color=sightgreen]" .. targetName .. " [color=hudwhite]játékost.")
                else
                    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Sikertelen művelet, kérlek próbáld újra!", sourcePlayer, 255, 255, 255, true)
                end
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található ilyen játékos.", sourcePlayer, 255, 255, 255, true)
            end
        end
    end
end)
--kesz
addCommandHandler("goto", function(client, commandName, targetPlayer, silent)
    if exports.sPermission:hasPermission(client, "goto") then
        if targetPlayer then
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)
            local adminName = getElementData(client, "acc.adminNick")
            local title = getPlayerAdminTitle(client)

            if isElement(targetPlayer) then
                local x, y, z = getElementPosition(targetPlayer)
                local int = getElementInterior(targetPlayer)
                local dim = getElementDimension(targetPlayer)

                local psLobby = getElementData(targetPlayer, "currentPaintshopLobby")

                local ws = getElementData(targetPlayer, "currentPaintshop")

                if psLobby then
                    exports.sPaintshop:enterPaintshopLobby(client, psLobby)
                    setElementData(client, "currentPaintshopLobby", psLobby)
                else
                    if getElementData(client, "currentPaintshop") then
                        exports.sPaintshop:exitPaintWorkshop(client, true)
                        setElementData(client, "currentPaintshop", false)
                    end
                    if getElementData(client, "currentPaintshopLobby") then
                        exports.sPaintshop:exitPaintshopLobby(client)
                        setElementData(client, "currentPaintshopLobby", false)
                    end
                end

                if ws then
                    exports.sPaintshop:tryToEnterPaintshop(client, ws)
                    setElementData(client, "currentPaintshop", ws)
                else
                    if psLobby then
                        exports.sPaintshop:enterPaintshopLobby(client, psLobby)
                        setElementData(client, "currentPaintshopLobby", psLobby)
                        if not ws then
                            if getElementData(client, "currentPaintshop") then
                                exports.sPaintshop:exitPaintWorkshop(client)
                                setElementData(client, "currentPaintshop", false)
                            end
                        end
                    else
                        if getElementData(client, "currentPaintshop") then
                            exports.sPaintshop:exitPaintWorkshop(client, true)
                            setElementData(client, "currentPaintshop", false)
                        end
                        if getElementData(client, "currentPaintshopLobby") then
                            exports.sPaintshop:exitPaintshopLobby(client)
                            setElementData(client, "currentPaintshopLobby", false)
                        end
                    end
                end

                local veh = getPedOccupiedVehicle(client)
                if veh then
                    setElementPosition(veh, x + 1, y, z)
                    setElementInterior(veh, int)
                    setElementDimension(veh, dim)
                    setElementVelocity(veh, 0, 0, 0)
                    setElementAngularVelocity(veh, 0, 0, 0)

                    local occupants = getVehicleOccupants(veh)
                    for i = 0, 3 do
                        if occupants[i] then
                            setElementInterior(occupants[i], int)
                            setElementDimension(occupants[i], dim)
                        end
                    end
                else
                    setElementPosition(client, x + 1, y, z)
                    setElementInterior(client, int)
                    setElementDimension(client, dim)
                end

                if not (exports.sPermission:hasPermission(client, "gotoSilent") and silent == "1") then
                    outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. title .. " " .. adminName .. " [color=hudwhite]hozzád teleportált.", targetPlayer, 255, 255, 255, true)
                end
                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen elteleportáltál a kiválasztott játékoshoz. [color=sightgreen](".. targetName ..")", client, 255, 255, 255, true)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " ..title .. " " .. adminName .. " #ffffffelteleportált [color=sightgreen]" ..targetName .. " #ffffffjátékoshoz.")
            end
        else
            if exports.sPermission:hasPermission(client, "gotoSilent") then
                outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Név / ID] [Silent < 0 = nem - 1 = igen >]", client, 255, 255, 255, true)
            else
                outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Név / ID]", client, 255, 255, 255, true)
            end
        end
    end
end)

local resourceState = {}
addEventHandler("onResourceStart", root, function(startedResource)
    local resourceName = getResourceName(startedResource)

    local adminPlayers = {}

    for _, playerElement in pairs(getElementsByType("player")) do
        if (getElementData(playerElement, "acc.adminLevel") or 0) >= 8 then
            table.insert(adminPlayers, playerElement)
        end
    end

    if not resourceState[resourceName] then
        resourceState[resourceName] = {
            state = "started",
            timer = nil,
        }
    end

    resourceState[resourceName].state = "started"

    if isTimer(resourceState[resourceName].timer) then
        outputChatBox("[color=sightblue][SightMTA - Resources]: [color=hudwhite]Egy resource [color=sightyellow]újraindult[color=hudwhite]. [color=sightblue]("..resourceName..")", adminPlayers)
    
        killTimer(resourceState[resourceName].timer)
        resourceState[resourceName].timer = nil
    else
        outputChatBox("[color=sightblue][SightMTA - Resources]: [color=hudwhite]Egy resource [color=sightgreen]elindult. [color=sightblue]("..resourceName..")", adminPlayers)
    end
end)

addEventHandler("onResourceStop", root, function(stoppedResource)
    local resourceName = getResourceName(stoppedResource)

    if not resourceState[resourceName] then
        resourceState[resourceName] = {
            state = "stopped",
            timer = nil,
        }
    end

    local adminPlayers = {}

    for _, playerElement in pairs(getElementsByType("player")) do
        if (getElementData(playerElement, "acc.adminLevel") or 0) >= 8 then
            table.insert(adminPlayers, playerElement)
        end
    end

    resourceState[resourceName].state = "stopped"

    resourceState[resourceName].timer = setTimer(function()
        outputChatBox("[color=sightblue][SightMTA - Resources]: [color=hudwhite]Egy resource [color=sightred]leállt. [color=sightblue]("..resourceName..")", adminPlayer)
    end, 100, 1)
end)
--kesz
addCommandHandler("gethere", function(client, commandName, targetPlayer)
    if exports.sPermission:hasPermission(client, "gethere") then
        if targetPlayer then

            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)
            local adminName = getElementData(client, "acc.adminNick")
            local title = getPlayerAdminTitle(client)

            if exports.sJail:isPlayerInJail(targetPlayer) then
                exports.sCore:showInfobox(client, "e", "A játékos börtönben van!")
                return
            end

            if isElement(targetPlayer) then
                local x, y, z = getElementPosition(client)
                local int = getElementInterior(client)
                local dim = getElementDimension(client)
                local psLobby = getElementData(client, "currentPaintshopLobby")
                local ws = getElementData(client, "currentPaintshop")

                if psLobby then
                    exports.sPaintshop:enterPaintshopLobby(targetPlayer, psLobby)
                    setElementData(targetPlayer, "currentPaintshopLobby", psLobby)
                else
                    if getElementData(targetPlayer, "currentPaintshop") then
                        exports.sPaintshop:exitPaintWorkshop(targetPlayer, true)
                        setElementData(targetPlayer, "currentPaintshop", false)
                    end
                    if getElementData(targetPlayer, "currentPaintshopLobby") then
                        exports.sPaintshop:exitPaintshopLobby(targetPlayer)
                        setElementData(targetPlayer, "currentPaintshopLobby", false)
                    end
                end

                if ws then
                    exports.sPaintshop:tryToEnterPaintshop(targetPlayer, ws)
                    setElementData(targetPlayer, "currentPaintshop", ws)
                else
                    if psLobby then
                        exports.sPaintshop:enterPaintshopLobby(targetPlayer, psLobby)
                        setElementData(targetPlayer, "currentPaintshopLobby", psLobby)
                        if not ws then
                            if getElementData(targetPlayer, "currentPaintshop") then
                                outputChatBox("nincs ws-ben le kell venni")
                                exports.sPaintshop:exitPaintWorkshop(targetPlayer)
                                setElementData(targetPlayer, "currentPaintshop", false)
                            end
                        end
                    else
                        if getElementData(targetPlayer, "currentPaintshop") then
                            exports.sPaintshop:exitPaintWorkshop(targetPlayer, true)
                            setElementData(targetPlayer, "currentPaintshop", false)
                        end
                        if getElementData(targetPlayer, "currentPaintshopLobby") then
                            exports.sPaintshop:exitPaintshopLobby(targetPlayer)
                            setElementData(targetPlayer, "currentPaintshopLobby", false)
                        end
                    end
                end

                local veh = getPedOccupiedVehicle(targetPlayer)
                if veh then
                    setElementPosition(veh, x + 1, y, z)
                    setElementInterior(veh, int)
                    setElementDimension(veh, dim)
                    setElementVelocity(veh, 0, 0, 0)
                    setElementAngularVelocity(veh, 0, 0, 0)

                    local occupants = getVehicleOccupants(veh)
                    for i = 0, 3 do
                        if occupants[i] then
                            setElementInterior(occupants[i], int)
                            setElementDimension(occupants[i], dim)
                        end
                    end
                else
                    setElementPosition(targetPlayer, x + 1, y, z)
                    setElementInterior(targetPlayer, int)
                    setElementDimension(targetPlayer, dim)
                end

                outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. title .. " " .. adminName .. " [color=hudwhite]magához teleportált.", targetPlayer, 255, 255, 255, true)
                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen magadhoz teleportáltad a kiválasztott játékoshoz.", client, 255, 255, 255, true)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] ".. title .. " " .. adminName .. " #ffffffmagához teleportálta [color=sightgreen]".. targetName .. " #ffffffjátékost.")
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Név / ID]", client, 255, 255, 255, true)
        end
    end
end)

function vanishCommand(client)
    if exports.sPermission:hasPermission(client, "disappear") then
        setElementData(client, "fixedAlpha", (getElementAlpha(client) == 255 and true or false))
        setElementAlpha(client, ((getElementAlpha(client) == 255) and 0) or 255)
        if getElementAlpha(client) == 0 then
            exports.sClothesshop:processPlayerWeaponItems(exports.sItems:getElementItems(client), client, true)
        else
            exports.sClothesshop:storePlayerClothes(client)
        end
    end
end
addCommandHandler("vanish", vanishCommand)
--kesz
local protectedSerials = {
    ["09EB8783894AA4D8A60FAE972AE44984"] = {true, "eznemgergo"},
    --["7024D09B30BC0800637A8D8F4F19BA54"] = {true, "noffy"},
    --["C183F2A0E8D3ACC34094B3E980A6A8B4"] = {true, "davis"}
}

addCommandHandler("setadminlevel", function(client, commandName, targetPlayer, level)
    if exports.sPermission:hasPermission(client, "setadminlevel") then
        level = tonumber(level)
        if targetPlayer and level and level >= 0 and level <= 11 then
            local override = false

            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

			if exports.sPermission:hasPermission(client, "overrideSetAdminLevel") then
				override = true
			end

            local serial = getPlayerSerial(targetPlayer)

            if not serial then
                return
            end

            if protectedSerials[serial] and protectedSerials[serial][1] and client ~= targetPlayer then
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Az ő serialja protectelve van, ezért nem tudod őt lefokozni!", client)
                outputChatBox("[color=sightyellow][SightMTA - Figyelmeztetés]: [color=hudwhite]Egy felhasználó megpróbálta levenni az adminszinted ["..getElementData(client, "visibleName"):gsub("_", " ").."]!", targetPlayer)
                return
            end

            if not override then
                local adminLevel = getElementData(client, "acc.adminLevel") or 0
                
                if adminLevel <= level then
                    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Ehhez nincs jogosultságod!", client, 255, 255, 255, true)
                    return
                end
            end

            if targetPlayer then
                local adminName = getElementData(client, "acc.adminNick")
                local currentAdminLevel = getElementData(targetPlayer, "acc.adminLevel") or 0

                if level == currentAdminLevel then
                    outputChatBox("[color=sightred][SightMTA - Hiba]: #ffffffA kiválasztott játékos már a megadott szinten van.", client)
                    return
                end

                if level == 0 then
                    local characterName = getElementData(targetPlayer, "char.name")

                    setElementData(targetPlayer, "visibleName", characterName)
                    if getElementData(targetPlayer, "adminDuty") then
                        setElementData(targetPlayer, "adminDuty", false)
                        setElementData(targetPlayer, "invulnerable", false)
                        triggerClientEvent(root, "showInfobox", client, "o", getElementData(targetPlayer, "acc.adminNick") .. " kilépett az adminszolgálatból.")
                    end
                end

                local targetAdminNick = getElementData(targetPlayer, "acc.adminNick")

                exports.sAnticheat:sendWebhookMessage("**"..getElementData(client, "visibleName").."** megváltoztatta  **"..targetName.."** admin szintjét. (**" .. currentAdminLevel .. "** >> **" .. level .. ")**", "setadminlevel")
                setElementData(targetPlayer, "acc.adminLevel", level)
                dbExec(connection, "UPDATE accounts SET adminLevel = ? WHERE accountId = ?", level, getElementData(targetPlayer, "char.accID"))

                if getElementData(targetPlayer, "acc.adminNick") == "Admin" then 
                    outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. adminName .. " #ffffffmegváltoztatta [color=sightblue]" .. targetName .. " #ffffffadminisztrátori szintjét. [color=sightgreen](" .. currentAdminLevel .. " → " .. level .. ")")
                else
                    outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. adminName .. " #ffffffmegváltoztatta [color=sightblue]" .. targetAdminNick .. " #ffffffadminisztrátori szintjét. [color=sightgreen](" .. currentAdminLevel .. " → " .. level .. ")")
                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " ..adminName .. " #ffffffmegváltoztatta [color=sightblue]" ..(getElementData(targetPlayer, "acc.adminNick") == "Admin" and targetName or targetAdminNick) .." #ffffffadminisztrátori szintjét. [color=sightgreen](" .. currentAdminLevel .. " → " .. level .. ")")
                end
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Szint < 0 - 11 >]", client, 255, 255, 255, true)
        end
    end
end)
--kesz
addCommandHandler("setadminnick", function(client, commandName, targetPlayer, adminNick)
    if exports.sPermission:hasPermission(client, "setadminnick") then
        adminNick = adminNick and (utf8.len(adminNick) <= 32 and utf8.len(adminNick) > 0) and adminNick
        if targetPlayer and adminNick then
            local override = false
			if exports.sPermission:hasPermission(client, "overrideSetAdminLevel") then
				override = true
			end

            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                local adminName = getElementData(client, "acc.adminNick")
                local currentAdminLevel = getElementData(targetPlayer, "acc.adminLevel") or 0
                
                if not override then
                    local adminLevel = getElementData(client, "acc.adminLevel") or 0
                    
                    if adminLevel <= currentAdminLevel then
                        outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Ehhez nincs jogosultságod!", client, 255, 255, 255, true)
                        return
                    end
                end

                local targetAdminNick = getElementData(targetPlayer, "acc.adminNick")
                
                if adminNick == targetAdminNick then
                    outputChatBox("[color=sightred][SightMTA - Hiba]: #ffffffA kiválasztott játékosnak már a megadott neve van.", client)
                    return
                end

                setElementData(targetPlayer, "acc.adminNick", adminNick)

                if getElementData(targetPlayer, "adminDuty") then
                    setElementData(targetPlayer, "visibleName", adminNick)
                end

                dbExec(connection, "UPDATE accounts SET adminNick = ? WHERE accountId = ?", adminNick, getElementData(targetPlayer, "char.accID"))

                if targetAdminNick ~= "Admin" then
                    targetName = targetAdminNick
                end
                outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. adminName .. " #ffffffmegváltoztatta [color=sightblue]" .. targetName .. " #ffffffadminisztrátori nevét. [color=sightgreen](" .. adminNick .. ")")
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminName .." #ffffffmegváltoztatta [color=sightblue]" .. targetName ..    " #ffffffadminisztrátori nevét. [color=sightgreen](" .. adminNick .. ")")
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Új név]", client, 255, 255, 255, true)
        end
    end
end)

addCommandHandler("sethelperlevel", function(client, commandName, targetPlayer, level)
    if exports.sPermission:hasPermission(client, "sethelperlevel") then
        level = tonumber(level)
        if targetPlayer and level and level >= 0 and level <= 2 then
            local override = false
			if exports.sPermission:hasPermission(client, "grantPermanentHelper") then
				override = true
			end

            if not override and level > 1 then
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Ehhez nincs jogosultságod!", client, 255, 255, 255, true)
                return
            end

            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                local adminName = getElementData(client, "acc.adminNick")
                local currentHelperLevel = getElementData(targetPlayer, "acc.helperLevel") or 0

                if level == currentHelperLevel then
                    outputChatBox("[color=sightred][SightMTA - Hiba]: #ffffffA kiválasztott játékos már a megadott szinten van.", client)
                    return
                end

                setElementData(targetPlayer, "acc.helperLevel", level)

                if level >= 2 or level == 0 then
                    dbExec(connection, "UPDATE accounts SET helperLevel = ? WHERE accountId = ?", level, getElementData(targetPlayer, "char.accID"))
                end

                outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. adminName .. " #ffffffmegváltoztatta [color=sightblue]" .. targetName .. " #ffffffadminsegéd szintjét. [color=sightblue](" .. currentHelperLevel .. " → " .. level .. ")")
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " ..adminName .. " #ffffffmegváltoztatta [color=sightblue]" ..targetName .. " #ffffffadminsegéd szintjét. [color=sightblue](" .. currentHelperLevel .. " → " .. level .. ")")
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Szint < 0 - 2 >]", client, 255, 255, 255, true)
        end
    end
end)

addCommandHandler("aduty", function(client)
    if exports.sPermission:hasPermission(client, "adminDuty") then
        local adminDutyState = getElementData(client, "adminDuty")
        local adminName = getElementData(client, "acc.adminNick") or "Admin"
        processDutyCount(client, adminDutyState)
        if not adminDutyState then
            setElementData(client, "visibleName", adminName)
            setElementData(client, "adminDuty", true)
            setElementData(client, "invulnerable", true)

            triggerClientEvent(root, "showInfobox", client, "g", adminName .. " adminszolgálatba lépett.")
        else
            local characterName = getElementData(client, "char.name")

            setElementData(client, "visibleName", characterName)
            setElementData(client, "adminDuty", false)
            setElementData(client, "invulnerable", false)

            triggerClientEvent(root, "showInfobox", client, "o", adminName .. " kilépett az adminszolgálatból.")
        end
    end
end)

local dutyTimers = {}

function processDutyCount(player, dutyState)
    if dutyState then
        if dutyTimers[player] then
            return
        end

        createPlayerRecordIfNotExists(player)
        
        dutyTimers[player] = {}
        dutyTimers[player].dutyTime = 0
        dutyTimers[player].timer = setTimer(function()
            dutyTimers[player].dutyTime = dutyTimers[player].dutyTime + 1
            saveDutyTimeToDatabase(player, dutyTimers[player].dutyTime)
            dutyTimers[player].dutyTime = 0
        end, 60000, 0)
    else
        if dutyTimers[player] then
            if isTimer(dutyTimers[player].timer) then
                killTimer(dutyTimers[player].timer)
            end
            if dutyTimers[player].dutyTime > 0 then
                saveDutyTimeToDatabase(player, dutyTimers[player].dutyTime)
            end
            dutyTimers[player] = nil
        end
    end
end

function createPlayerRecordIfNotExists(player)
    local characterIdentity = getElementData(player, "char.accID")
    local adminName = getElementData(player, "acc.adminNick") or "Admin"
    if not characterIdentity then
        return
    end

    dbQuery(function(qh)
        local result = dbPoll(qh, 0)
        if #result == 0 then
            dbExec(connection, "INSERT INTO adminstats (characterIdentity, adminName, dutyTime) VALUES (?, ?, 0)", characterIdentity, adminName)
        end
    end, connection, "SELECT characterIdentity FROM adminstats WHERE characterIdentity = ?", characterIdentity)
end

function saveDutyTimeToDatabase(player, dutyTime)
    local characterIdentity = getElementData(player, "char.accID")
    if not characterIdentity then
        return
    end
    dbExec(connection, "UPDATE adminstats SET dutyTime = dutyTime + ? WHERE characterIdentity = ?", dutyTime, characterIdentity)
end

addEventHandler("onPlayerQuit", root, function()
    local player = source
    if dutyTimers[player] then
        if isTimer(dutyTimers[player].timer) then
            killTimer(dutyTimers[player].timer)
        end

        if dutyTimers[player].dutyTime > 0 then
            saveDutyTimeToDatabase(player, dutyTimers[player].dutyTime)
        end

        dutyTimers[player] = nil
    end
end)


addCommandHandler("a", function (client, commandName, ...)
    if exports.sPermission:hasPermission(client, "adminChat") then
        if not (...) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Üzenet]", client, 255, 255, 255, true)
        else
            local msg = string.gsub(table.concat({...}, " "), "#%x%x%x%x%x%x", "")

            if #msg > 0 and utf8.len(msg) > 0 then
                if utf8.len((utf8.gsub(msg, " ", "") or 0)) > 0 then
                    local adminName = getElementData(client, "acc.adminNick")
                    local adminRank = getPlayerAdminTitle(client)
                    local adminRank1 = getPlayerAdminTitleLOG(client)

                    showMessageForAdmins("[color=sightred-second][AdminChat]: " .. adminRank .. " " .. adminName .. ": #ffffff" .. msg)
                    exports.sAnticheat:sendWebhookMessage("**[" .. adminRank1 .. "] "..getElementData(client, "visibleName"):gsub("_", " ").. "** : "..msg.."", "adminchat")

                end
            end
        end
    end
end)

addCommandHandler("fa", function (client, commandName, ...)
    if exports.sPermission:hasPermission(client, "faChat") then
        if not (...) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Üzenet]", client, 255, 255, 255, true)
        else
            local msg = string.gsub(table.concat({...}, " "), "#%x%x%x%x%x%x", "")

            if #msg > 0 and utf8.len(msg) > 0 then
                if utf8.len((utf8.gsub(msg, " ", "") or 0)) > 0 then
                    local adminName = getElementData(client, "acc.adminNick")
                    local adminRank = getPlayerAdminTitle(client)
                    local adminRank1 = getPlayerAdminTitleLOG(client)

                    showMessageForAdmins("[color=sightred-second][FőAdmin chat]: " .. adminRank .. " " .. adminName .. ": #ffffff" .. msg)
                    exports.sAnticheat:sendWebhookMessage("**[" .. adminRank1 .. "] "..getElementData(client, "visibleName"):gsub("_", " ").. "** : "..msg.."", "adminchat")

                end
            end
        end
    end
end)

addCommandHandler("togonline", function(sourcePlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "togonline") then
        local onlineState = getElementData(sourcePlayer, "hideOnline") or false
        setElementData(sourcePlayer, "hideOnline", not onlineState)

        outputChatBox("[color=sightgreen][SightMTA - OnlineState]: [color=hudwhite]Sikeresen ".. (onlineState and "[color=sightred]kikapcsoltad" or "[color=sightgreen]bekapcsoltad") .."[color=hudwhite] az [color=sightgreen]Online [color=hudwhite]mód-ot", sourcePlayer)
    end
end)

addCommandHandler("nocol", function(sourcePlayer, commandName, offcollisionTime)
    if exports.sPermission:hasPermission(sourcePlayer, "nocol") then
        if not offcollisionTime then
            outputChatBox("[color=sightblue][SightMTA - NoCol]: #ffffff/" .. commandName .. " [Idő (mp)]", sourcePlayer, 255, 255, 255, true)
            return
        end

        local offcollisionTime = tonumber(offcollisionTime)
        local sourceVehicle = getPedOccupiedVehicle(sourcePlayer)

        if not sourceVehicle then
            outputChatBox("[color=sightred][SightMTA - NoCol]: [color=hudwhite]A parancs használatához járműben kell ülnöd!", sourcePlayer)
            return
        end

        if sourceVehicle then
            exports.sNocol:enableVehicleNoCol(sourceVehicle, offcollisionTime * 1000)
            outputChatBox("[color=sightgreen][SightMTA - Nocol]: [color=hudwhite]Sikeresen kikapcsoltad a járműved collisionjét!", sourcePlayer)
        end
    end
end)

addCommandHandler("gc", function (client, commandName, ...)
    if exports.sPermission:hasPermission(client, "guardChat") then
        if not (...) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Üzenet]", client, 255, 255, 255, true)
        else
            local msg = string.gsub(table.concat({...}, " "), "#%x%x%x%x%x%x", "")

            if #msg > 0 and utf8.len(msg) > 0 then
                if utf8.len((utf8.gsub(msg, " ", "") or 0)) > 0 then
                    local adminName = getElementData(client, "acc.adminNick")
                    local adminRank = getPlayerAdminTitle(client)
                    local adminRank1 = getPlayerAdminTitleLOG(client)

                    if adminRank == "N/A" then
                        if (getElementData(client, "acc.guardLevel") or 0) > 0 then
                            adminRank = "Egy RP Őr"
                            adminName = ""
                        end
                    end
                    showMessageForAdmins("[color=sightred-second][GuardChat]: [color=sightyellow-second]" .. adminRank .. " " .. adminName .. ": #ffffff" .. msg)
                    exports.sAnticheat:sendWebhookMessage("**[" .. adminRank1 .. "] "..getElementData(client, "visibleName"):gsub("_", " ").. "** : "..msg.."", "adminchat")
                end
            end
        end
    end
end)

addCommandHandler("as", function (client, commandName, ...)
    if exports.sPermission:hasPermission(client, "helperChat") then
        if not (...) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Üzenet]", client, 255, 255, 255, true)
        else
            local msg = string.gsub(table.concat({...}, " "), "#%x%x%x%x%x%x", "")

            if #msg > 0 and utf8.len(msg) > 0 then
                if utf8.len((utf8.gsub(msg, " ", "") or 0)) > 0 then
                    local adminName = getElementData(client, "acc.adminNick")
                    local asLevel = getElementData(client, "acc.helperLevel")
                    local adminLevel = getElementData(client, "acc.adminLevel")

                    local adminRank = "N/A"

                    if adminLevel > 0 then
                        adminRank = getPlayerAdminTitle(client)
                    else
                        adminName = getElementData(client, "char.name"):gsub("_", " ")

                        if asLevel == 1 then
                            adminRank = "#D862A1I.D.G AdminSegéd"
                        elseif asLevel == 2 then
                            adminRank = "#D862A1 AdminSegéd"
                        end
                    end

                    showMessageForHelpers("[color=sightred-second][HelperChat]: " .. adminRank .. " " .. adminName .. ": #ffffff" .. msg)
                end
            end
        end
    end
end)

function showMessageForAdmins(message, minLevel)
    for k, v in pairs(getElementsByType("player")) do
        if getElementData(v, "loggedIn") then
            local adminLevel = tonumber(getElementData(v, "acc.adminLevel")) or 0
            local guardLevel = tonumber(getElementData(v, "acc.guardLevel")) or 0

            local minLevel = minLevel or 1

            local hasPermission = false
            if minLevel then
                hasPermission = adminLevel >= minLevel
            else
                hasPermission = adminLevel >= 1
            end

            if not hasPermission and guardLevel >= minLevel then
                hasPermission = true
            end

            if hasPermission and not getElementData(v, "urmaChat") then
                outputChatBox("[color=sightblue]" .. message, v, 255, 255, 255, true)
            end
        end
    end
end

function showMessageForHelpers(message, minLevel)
	for k, v in pairs(getElementsByType("player")) do
        if getElementData(v, "loggedIn") then
            local helperLevel = tonumber(getElementData(v, "acc.helperLevel")) or 0
            local adminLevel = tonumber(getElementData(v, "acc.adminLevel")) or 0

            if ((minLevel and helperLevel >= minLevel) or (not minLevel and helperLevel >= 1)) 
                or ((minLevel and adminLevel >= minLevel) or (not minLevel and adminLevel >= 1)) then
                if not getElementData(v, "urmaChat") then
                    outputChatBox("[color=sightblue]" .. message, v, 255, 255, 255, true)
                end
            end
        end
	end
end

addCommandHandler("asay", function(client, commandName, ...)
    if exports.sPermission:hasPermission(client, "asay") then
        if not (...) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Üzenet]", client, 255, 255, 255, true)
        else
            local msg = string.gsub(table.concat({...}, " "), "#%x%x%x%x%x%x", "")

            if #msg > 0 and utf8.len(msg) > 0 then
                if utf8.len((utf8.gsub(msg, " ", "") or 0)) > 0 then
                    local adminName = getElementData(client, "acc.adminNick")
                    local adminRank = getPlayerAdminTitle(client, true)

                    outputChatBox("[color=sightred]" .. adminRank .. " " .. adminName .. ": " .. msg)
                    triggerClientEvent(getRootElement(), "onAsay", client)
                end
            end
        end
    end
end)
--kesz
addCommandHandler({"vhspawn", "akspawn"}, function (client, commandName, targetPlayer)
    if exports.sPermission:hasPermission(client, "vhspawn") then
        if not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID]", client)
        else
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                if isPedInVehicle(targetPlayer) then
                    removePedFromVehicle(targetPlayer)
                end

                local targetPosition = commandName == "vhspawn" and {1484.6782226562, -1740.3259277344, 13.546875} or {2126.3303222656, -1118.9412841797, 25.353311538696}

                setElementPosition(targetPlayer, targetPosition[1], targetPosition[2], targetPosition[3])
                setElementInterior(targetPlayer, 0)
                setElementDimension(targetPlayer, 0)

                local adminName = getElementData(client, "acc.adminNick")
                local title = getPlayerAdminTitle(client)

                local playerPlacement = commandName == "vhspawn" and "városházára." or "autókereskedéshez."

                outputChatBox("[color=sightgreen][SightMTA]: " .. title .. " " .. adminName .. " #ffffffelteleportált téged a " .. playerPlacement, targetPlayer)
                outputChatBox("[color=sightgreen][SightMTA - Siker]: #ffffffSikeresen elteleportáltad a kiválasztott játékost a ".. playerPlacement .." [color=sightgreen](" .. targetName .. ")", client)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. title .. " " .. adminName .. " #ffffffelteleportálta [color=sightgreen]" .. targetName .. " #ffffffjátékost a " .. playerPlacement)
            end
        end
    end
end)
--kesz
addCommandHandler("sethp", function (client, commandName, targetPlayer, value)
    if exports.sPermission:hasPermission(client, "sethp") then
        value = tonumber(value)

        if not targetPlayer or not value or value < 0 or value > 100 then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Életerő < 0 - 100 >]", client)
        else
            targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                local adminName = getElementData(client, "acc.adminNick")
                local adminRank = getPlayerAdminTitle(client)
                local title = getPlayerAdminTitle(client)
                setElementData(targetPlayer, "customDeath", "sethp")

                setElementHealth(targetPlayer, value)
                outputChatBox("[color=sightgreen][SightMTA]: " .. title .. " " .. adminName .. "  #ffffffmegváltoztatta az életerődet. [color=sightgreen](" .. value .. ")", targetPlayer)
                outputChatBox("[color=sightgreen][SightMTA - Siker]: #ffffffMegváltoztattad [color=sightgreen]" .. targetName .. " #ffffffjátékos életerejét. [color=sightgreen](" .. value .. ")", client)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminRank .. " " .. adminName .. " #ffffffátállította [color=sightgreen]" .. targetName .. " #fffffféleterejét. [color=sightgreen](" .. value .. ")")
            end
        end
    end
end)
--kesz
addCommandHandler("setskin", function (client, commandName, targetPlayer, value)
    if exports.sPermission:hasPermission(client, "setskin") then
        value = tonumber(value) or value

        if not targetPlayer and (not value or value < 0) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Skin ID]", client)
        else
            targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                local adminName = getElementData(client, "acc.adminNick")
                local title = getPlayerAdminTitle(client)

                if value and type(value) == "number" then
                    if value <= 312 then
                        setElementModel(targetPlayer, value)
                        setElementData(targetPlayer, "char.skin", value)
                        setElementData(targetPlayer, "permGroupSkin", "N")
                    else
                        outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A maximális skin ID 312!", client, 255, 255, 255, true)
                        return
                    end
                elseif value and type(value) == "string" then
                    setElementData(targetPlayer, "permGroupSkin", value)
                end
                if value then
                    outputChatBox("[color=sightgreen][SightMTA]: " .. title .. " " .. adminName .." #ffffffmegváltoztatta a kinézeted [color=sightgreen](" .. value .. ")", targetPlayer)
                    outputChatBox("[color=sightgreen][SightMTA - Siker]: #ffffffSikeresen megváltoztattad [color=sightgreen]" .. targetName .. " #ffffffkinézetét. [color=sightgreen](" .. value .. ")", client)
                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. title .. " " .. adminName .. " #ffffffátállította [color=sightgreen]" .. targetName .. " #ffffffkinézetét. [color=sightgreen](" .. tostring(value) .. ")")
                end
            end
        end
    end
end)
--kesz
addCommandHandler("changename", function(client, commandName, targetPlayer, ...)
    if exports.sPermission:hasPermission(client, "changename") then
        local name = table.concat({...}, "_")
        name = (utf8.len(name) <= 64 and utf8.len(name) > 0) and name or false
        if targetPlayer and name then
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                local adminName = getElementData(client, "acc.adminNick")
                local currentAdminLevel = getElementData(targetPlayer, "acc.adminLevel") or 0

                local targetCurrentName = getElementData(targetPlayer, "char.name")
                
                if name == targetCurrentName then
                    outputChatBox("[color=sightred][SightMTA - Hiba]: #ffffffA kiválasztott játékosnak már a megadott neve van.", client)
                    return
                end

                setElementData(targetPlayer, "char.name", name)
                setElementData(targetPlayer, "visibleName", name)
                dbExec(connection, "UPDATE characters SET name = ?, lastNameChange = ? WHERE characterId = ?", name, getRealTime().timestamp, getElementData(targetPlayer, "char.ID"))

                outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. adminName .. " [color=hudwhite]megváltoztatta a neved. [color=sightblue](" .. string.gsub(name, "_", " ") .. ")", targetPlayer)
                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen megváltoztattad a kiválasztott játékos nevét! [color=sightgreen](" .. string.gsub(targetCurrentName, "_", " ") .. " #ffffff→ [color=sightgreen]" .. string.gsub(name, "_", " ") .. ")", client)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminName .. " #ffffffmegváltoztatta [color=sightgreen]" .. targetName .. " #ffffffnevét. ([color=sightgreen]" .. string.gsub(targetCurrentName, "_", " ") .. " #ffffff→ [color=sightgreen]" .. string.gsub(name, "_", " ") .. ")")
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Új név]", client, 255, 255, 255, true)
        end
    end
end)
--kesz
local maxAmount = 500000000

addCommandHandler("givemoney", function(client, commandName, targetPlayer, value)
    if exports.sPermission:hasPermission(client, "giveMoney") then
        value = tonumber(value) or 0


        if not targetPlayer or not value or value <= 0 then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Összeg]", client)
        else
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                local adminNick = getElementData(client, "acc.adminNick")
                local adminTitle = getPlayerAdminTitle(client) .. " " .. adminNick

                local targetMoneyValue = exports.sCore:getMoney(targetPlayer)
                local targetNewMoneyValue = targetMoneyValue + value

                if targetNewMoneyValue > maxAmount then
                    outputChatBox("atlesz irva: maximumot elerted.")
                    return
                end

                exports.sAnticheat:sendWebhookMessage("**"..adminNick.."** adott egy játékosnak ("..targetName..") **"..exports.sGui:thousandsStepper(value).." $**-t ", "amoney")
                exports.sCore:setMoney(targetPlayer, targetNewMoneyValue)

                outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. adminTitle .. " [color=hudwhite]pénzt adott neked. [color=sightblue](" .. exports.sGui:thousandsStepper(value) .. "$)", targetPlayer)
                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen adtál [color=sightblue]" .. targetName:gsub("_", " ") .. "[color=hudwhite]-nak/nek egy kis pénzt. [color=sightblue](" .. exports.sGui:thousandsStepper(value) .. "$)", client)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " #ffffffpénzt adott [color=sightblue]" .. targetName .. " #ffffffjátékosnak. [color=sightblue](" .. exports.sGui:thousandsStepper(value) .. "$)")
            end
        end
    end
end)
--kesz
addCommandHandler("givepp", function(client, commandName, targetPlayer, value)
    if exports.sPermission:hasPermission(client, "givepp") then
        value = tonumber(value) or 0

        if not targetPlayer or not value or value < 0 then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Összeg]", client)
        else
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                local adminNick = getElementData(client, "acc.adminNick")
                local adminTitle = getPlayerAdminTitle(client) .. " " .. adminNick

                local targetPPValue = exports.sCore:getPP(targetPlayer)
                local targetNewPPValue = targetPPValue + value

                if targetNewPPValue > maxAmount then
                    outputChatBox("atlesz irva: maximumot elerted.")
                    return
                end

                exports.sCore:setPP(targetPlayer, targetNewPPValue)

                outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. adminTitle .. " [color=hudwhite]prémiumpontot adott neked. [color=sightblue](" .. exports.sGui:thousandsStepper(value) .. " PP)", targetPlayer)
                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen adtál [color=sightblue]" .. targetName:gsub("_", " ") .. "[color=hudwhite]-nak/nek prémiumpontot. [color=sightblue](" .. exports.sGui:thousandsStepper(value) .. " PP)", client)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " #ffffffprémiumpontot adott [color=sightblue]" .. targetName .. " #ffffffjátékosnak. [color=sightblue](" .. exports.sGui:thousandsStepper(value) .. " PP)")
            end
        end
    end
end)
--kesz
addCommandHandler("setpp", function(client, commandName, targetPlayer, value)
    if exports.sPermission:hasPermission(client, "setpp") then
        value = tonumber(value) or 0

        if not targetPlayer or not value or value < 0 then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Összeg]", client)
        else
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                local adminNick = getElementData(client, "acc.adminNick")
                local adminTitle = getPlayerAdminTitle(client) .. " " .. adminNick
                local oldPP = exports.sCore:getPP(targetPlayer) or 0

                if value > maxAmount then
                    outputChatBox("atlesz irva: maximumot elerted.")
                    return
                end

                exports.sCore:setPP(targetPlayer, value)

                outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. adminTitle .. " [color=hudwhite]átállította a prémiumpontjaidat. ([color=sightgreen]" .. exports.sGui:thousandsStepper(oldPP) .. " #ffffff→ [color=sightgreen]" .. exports.sGui:thousandsStepper(value) .. " PP)", targetPlayer)
                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen átállítottad [color=sightblue]" .. targetName:gsub("_", " ") .. "[color=hudwhite]-nak/nek prémiumpontját. ([color=sightgreen]" .. exports.sGui:thousandsStepper(oldPP) .. " #ffffff→ [color=sightgreen]" .. exports.sGui:thousandsStepper(value) .. " PP)", client)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " #ffffffátállította [color=sightblue]" .. targetName .. " #ffffffprémiumpontját. ([color=sightgreen]" .. exports.sGui:thousandsStepper(oldPP) .. " #ffffff→ [color=sightgreen]" .. exports.sGui:thousandsStepper(value) .. " PP)")
            end
        end
    end
end)
--kesz
addCommandHandler("takemoney", function(client, commandName, targetPlayer, value)
    if exports.sPermission:hasPermission(client, "takemoney") then
        value = tonumber(value) or 0

        if not targetPlayer or not value or value <= 0 then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Összeg]", client)
        else
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                local adminNick = getElementData(client, "acc.adminNick")
                local adminTitle = getPlayerAdminTitle(client) .. " " .. adminNick

                local oldMoney = exports.sCore:getMoney(targetPlayer)
                local newMoney = oldMoney - value

                if newMoney > maxAmount then
                    outputChatBox("atlesz irva: maximumot elerted.")
                    return
                end

                exports.sCore:setMoney(targetPlayer, newMoney)
                exports.sAnticheat:sendWebhookMessage("**"..adminNick.."** elvett egy játékostól ("..targetName..") **"..exports.sGui:thousandsStepper(value).." $**-t ", "amoney")

                outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. adminTitle .. " [color=hudwhite]pénzt vett el tőled. ([color=sightgreen]" .. exports.sGui:thousandsStepper(oldMoney) .. " #ffffff→ [color=sightgreen]" .. exports.sGui:thousandsStepper(newMoney) .. " $)", targetPlayer)
                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen elvettél [color=sightblue]" .. targetName:gsub("_", " ") .. "[color=hudwhite]-tól/től pénzt. ([color=sightgreen]" .. exports.sGui:thousandsStepper(oldMoney) .. " #ffffff→ [color=sightgreen]" .. exports.sGui:thousandsStepper(newMoney) .. " $)", client)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]Adminnapló] " .. adminTitle .. "[color=hudwhite] elvett [color=sightblue]" .. targetName .. " #ffffffjátékostól pénzt. ([color=sightgreen]" .. exports.sGui:thousandsStepper(oldMoney) .. " #ffffff→ [color=sightgreen]" .. exports.sGui:thousandsStepper(newMoney) .. " $)")
            end
        end
    end
end)

addCommandHandler("takepp", function(client, commandName, targetPlayer, value)
    if exports.sPermission:hasPermission(client, "takepp") then
        value = tonumber(value) or 0

        if not targetPlayer or not value or value <= 0 then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Összeg]", client)
        else
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                local adminNick = getElementData(client, "acc.adminNick")
                local adminTitle = getPlayerAdminTitle(client) .. " " .. adminNick

                local oldPP = exports.sCore:getPP(targetPlayer)
                local newPP = oldPP - value

                if newPP > maxAmount then
                    outputChatBox("atlesz irva: maximumot elerted.")
                    return
                end

                exports.sCore:setPP(targetPlayer, newPP)
                exports.sAnticheat:sendWebhookMessage("**"..adminNick.."** elvett egy játékostól ("..targetName..") **"..exports.sGui:thousandsStepper(value).." PP**-t ", "amoney")

                outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. adminTitle .. " [color=hudwhite]PP-t vett el tőled. ([color=sightgreen]" .. exports.sGui:thousandsStepper(oldPP) .. " #ffffff→ [color=sightgreen]" .. exports.sGui:thousandsStepper(newPP) .. " PP)", targetPlayer)
                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen elvettél [color=sightblue]" .. targetName:gsub("_", " ") .. "[color=hudwhite]-tól/től PP-t. ([color=sightgreen]" .. exports.sGui:thousandsStepper(oldPP) .. " #ffffff→ [color=sightgreen]" .. exports.sGui:thousandsStepper(newPP) .. " PP)", client)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]Adminnapló] " .. adminTitle .. "[color=hudwhite] elvett [color=sightblue]" .. targetName .. " #ffffffjátékostól PP-t. ([color=sightgreen]" .. exports.sGui:thousandsStepper(oldPP) .. " #ffffff→ [color=sightgreen]" .. exports.sGui:thousandsStepper(newPP) .. " PP)")
            end
        end
    end
end)
--kesz
addCommandHandler({"freeze", "unfreeze"}, function(client, commandName, targetPlayer)
    if exports.sPermission:hasPermission(client, "freeze") then

        if not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID]", client)
        else
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                local adminNick = getElementData(client, "acc.adminNick")
                local adminTitle = getPlayerAdminTitle(client) .. " " .. adminNick

                local TargetVeh = getPedOccupiedVehicle(targetPlayer);

                if not isElementFrozen(targetPlayer) then
                    if TargetVeh then 
                        setElementFrozen(TargetVeh, true);
                    end
                    setElementFrozen(targetPlayer, true);

                    outputChatBox("[color=sightgreen][SightMTA]: " .. adminTitle .. " [color=hudwhite]lefagyasztott téged.", targetPlayer)
                    outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]sikeresen lefagyasztottad a kiválasztott játékost. ([color=sightblue]" .. targetName:gsub("_", " ") .. "[color=hudwhite])", client)
                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " #fffffflefagyasztotta [color=sightblue]" .. targetName .. " #ffffffjátékost.")    
                else
                    if TargetVeh then 
                        setElementFrozen(TargetVeh, false);
                    end
                    setElementFrozen(targetPlayer, false);

                    outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. adminTitle .. " [color=hudwhite]kiolvasztott téged.", targetPlayer)
                    outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]sikeresen kiolvasztottad a kiválasztott játékost. ([color=sightblue]" .. targetName:gsub("_", " ") .. "[color=hudwhite])", client)
                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " #ffffffkiolvasztotta [color=sightblue]" .. targetName .. " #ffffffjátékost.")
                end
            end
        end
    end
end)

addCommandHandler("togalog", function(client)
    local urmaState = not getElementData(client, "urmaChat")
    
    setElementData(client, "urmaChat", urmaState)
    outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]Admin Napló " .. ((not urmaState and "[color=sightgreen]bekapcsolva") or "[color=sightred]kikapcsolva") .. "[color=hudwhite].", client)
end)

function findPlayerByAccID(accID)
    local found = false
    for k, v in pairs(getElementsByType("player")) do
        if getElementData(v, "char.accID") == accID then
            found = true
            break
        end
    end
    return found
end

function getPlayerByAccID(accID)
    for _, player in ipairs(getElementsByType("player")) do
        if getElementData(player, "char.accID") == accID then
            return player
        end
    end
    return nil 
end
--
addCommandHandler({"giveofflinepp", "giveopp"}, 
	function(sourcePlayer, commandName, accID, ppNumber)
		if getElementData(sourcePlayer, "acc.adminLevel") >= 7 then
            local accID = tonumber(accID)
			if not accID or not ppNumber then
				outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Account ID] [Mennyiség]", sourcePlayer)
			else
				dbQuery(
					function(qh, sourcePlayer)
						local result = dbPoll(qh, 0)[1]
						
						if not result then
							outputChatBox("[color=sightred][SightMTA - Hiba]:[color=hudwhite] Nincs ilyen [color=sightred]AccountID[color=hudwhite]-vel rendelkező játékos!", sourcePlayer)
						else	
							dbQuery(
								function(qh, sourcePlayer)
									local resultt = dbPoll(qh, 0)[1]
									
									if not resultt then
										outputChatBox("[color=sightred][SightMTA - Hiba]: #ffffffNincs ilyen accountID!", sourcePlayer)
									else	
                                        local onlinePlayer = getPlayerByAccID(accID)
                                        if onlinePlayer then
                                            local onlineID = getElementData(onlinePlayer, "playerID") or "?"
                                            outputChatBox("[color=sightred][SightMTA - Hiba]: #ffffffA játékos fent van a szerveren! (ID: "..onlineID..")", sourcePlayer)
										else
											local sqlPPValue = tonumber(result.premiumPoints)
											local givePPValue = sqlPPValue+ppNumber
											dbExec(connection, "UPDATE accounts SET premiumPoints = ? WHERE accountId = ?", givePPValue, accID)
                                            outputChatBox("[color=sightgreen][SightMTA - Siker]:[color=hudwhite] A(z) [color=sightgreen]"..accID.."[color=hudwhite] AccountID-hez tartozó játékos PP egyenlege megnövelve [color=sightgreen]"..exports.sGui:thousandsStepper(ppNumber).."[color=hudwhite] ponttal. Új egyenlege: [color=sightgreen]"..exports.sGui:thousandsStepper(givePPValue).."[color=hudwhite].", sourcePlayer)
                                            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. getElementData(sourcePlayer, "acc.adminNick") .. " #ffffffprémiumpontot adott egy offline fióknak. ([color=sightgreen]accID: " .. tostring(accID) .. " [color=sightgreen]" .. exports.sGui:thousandsStepper(sqlPPValue) .. " #ffffff→ [color=sightgreen]" .. exports.sGui:thousandsStepper(givePPValue) .. " PP)")
                                        end
									end		
								end, {sourcePlayer}, connection, "SELECT online from accounts WHERE accountId = ?", accID)
						end			
					end, {sourcePlayer}, connection, "SELECT premiumPoints from accounts WHERE accountID = ?", accID)
			end
		end
	end
)
--kesz
addCommandHandler("setguardlevel", function(client, commandName, targetArg, levelArg)
    if exports.sPermission:hasPermission(client, "setguardlevel") then
        if not targetArg or not levelArg then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Szint < 0 - 4 >]", client)
            return
        end

        local level = tonumber(levelArg)
        if not level or level < 0 or level > 4 then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Szint < 0 - 4 >]", client)
            return
        end

        local target, targetName = exports.sCore:findPlayer(client, targetArg)

        if target then
            local oldLevel = tonumber(getElementData(target, "acc.guardLevel")) or 0
            dbExec(connection, "UPDATE accounts SET guardLevel = ? WHERE accountId = ?", level, getElementData(target, "char.accID"))
            setElementData(target, "acc.guardLevel", level)

            outputChatBox("[color=sightgreen][SightMTA - Siker][color=hudwhite] Sikeresen megváltoztattad [color=sightgreen]" .. targetName .. "[color=hudwhite] RP Őr szintjét! [color=sightgreen](" .. oldLevel .. " → " .. level .. ")", client)
            outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]Egy admin megváltoztatta az RP Őr szintedet! [color=sightgreen](" .. oldLevel .. " → " .. level .. ")", target)
            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. (getElementData(client, "acc.adminNick") or getPlayerName(client)) .. " #ffffffmegváltoztatta [color=sightgreen]" .. targetName .. " #ffffffRP Őr szintjét. [color=sightgreen](" .. oldLevel .. " → " .. level .. ")")
        end
    end
end)
--kesz
addCommandHandler({"getip", "getplayerip"}, function(sourcePlayer, sourceCommand, targetArg)
    if exports.sPermission:hasPermission(sourcePlayer, "getip") then
        if not targetArg then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/getip [Játékos Név / ID]", sourcePlayer)
            return
        end

        local targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetArg)

        if not targetPlayer or not isElement(targetPlayer) then
            return
        end

        local adminLevel = getElementData(sourcePlayer, "acc.adminLevel") or 0
        local targetAdminLevel = getElementData(targetPlayer, "acc.adminLevel") or 0

        if adminLevel <= targetAdminLevel then
            return
        end

        local ip = getPlayerIP(targetPlayer)
        outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A játékos IP címe: [color=sightgreen]" .. ip, sourcePlayer)
        showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. (getElementData(sourcePlayer, "acc.adminNick") or getPlayerName(sourcePlayer)) .. " #fffffflekérte [color=sightgreen]" .. targetName .. " #ffffffIP címét. [color=sightgreen](" .. ip .. ")")
    end
end)
--kesz
addCommandHandler("getaccid", function(sourcePlayer, sourceCommand, ...)
    if exports.sPermission:hasPermission(sourcePlayer, "getaccid") then
        local targetPlayer = table.concat({...}, " ")
        if not targetPlayer or targetPlayer == "" then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/getaccid [Játékos Név / ID]", sourcePlayer)
            return
        end

        dbQuery(function(qh)
            local result = dbPoll(qh, 0)
            if result and #result > 0 then
                local accID = result[1].accountId
                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A játékos account ID-je: [color=sightgreen]" .. accID, sourcePlayer)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. (getElementData(sourcePlayer, "acc.adminNick") or getPlayerName(sourcePlayer)) .. " #fffffflekérte [color=sightgreen]" .. targetPlayer:gsub("_", " ") .. " #ffffffAccountID-jét. [color=sightgreen](" .. accID .. ")")
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található ez az AccountID.", sourcePlayer)
            end
        end, {sourcePlayer}, connection, "SELECT accountId FROM CHARACTERS WHERE name = ?", targetPlayer:gsub(" ", "_"))
    end
end)
--kesz
addCommandHandler({"getserial", "serial"}, function(sourcePlayer, sourceCommand, targetArg)
    if exports.sPermission:hasPermission(sourcePlayer, "getserial") then
        if not targetArg then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/getserial [Játékos Név / ID]", sourcePlayer)
            return
        end
        
        local targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetArg)

        if not targetPlayer or not isElement(targetPlayer) then
            return
        end

        local serial = getPlayerSerial(targetPlayer)
        outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A játékos serialja: [color=sightgreen]" .. serial, sourcePlayer)
        showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. (getElementData(sourcePlayer, "acc.adminNick") or getPlayerName(sourcePlayer)) .. " #fffffflekérte [color=sightgreen]" .. targetName .. " #ffffffserialját. [color=sightgreen](" .. serial .. ")")
    end
end)
--kesz
addCommandHandler("setbankmoney", function(sourcePlayer, sourceCommand, targetPlayer, amount)
    if exports.sPermission:hasPermission(sourcePlayer, "setbankmoney") then
        if not targetPlayer or not amount then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/setbankmoney [Játékos Név / ID] [Összeg]", sourcePlayer)
            return
        end
        
        amount = tonumber(amount)
        targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

        if targetName and amount then
            local oldAmount = exports.sCore:getBankMoney(targetPlayer) or 0
            exports.sCore:setBankMoney(targetPlayer, amount)
            local adminNick = getElementData(sourcePlayer, "acc.adminNick") or getPlayerName(sourcePlayer)
            local adminTitle = getPlayerAdminTitle and getPlayerAdminTitle(sourcePlayer) or ""
            outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A kiválasztott játékos [color=sightgreen](" .. targetName .. ")[color=hudwhite] bankszámla egyenlege módosítva! [color=sightgreen](" .. exports.sGui:thousandsStepper(oldAmount) .. " → " .. exports.sGui:thousandsStepper(amount) .. ")", sourcePlayer)
            outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]" .. adminTitle .. " " .. adminNick .. "[color=hudwhite] módosította a bankszámlád egyenlegét! [color=sightgreen](" .. exports.sGui:thousandsStepper(oldAmount) .. " → " .. exports.sGui:thousandsStepper(amount) .. ")", targetPlayer)
            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminNick .. " #ffffffátállította [color=sightgreen]" .. targetName .. " #ffffffbanki egyenlegét. [color=sightgreen](" .. exports.sGui:thousandsStepper(oldAmount) .. " #ffffff→ [color=sightgreen]" .. exports.sGui:thousandsStepper(amount) .. ")")
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Érvénytelen összeg.", sourcePlayer)
        end
    end
end)
--kesz
addCommandHandler("setmoney", function(sourcePlayer, sourceCommand, targetPlayer, amount)
    if exports.sPermission:hasPermission(sourcePlayer, "setmoney") then
        if not targetPlayer or not amount then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/setmoney [Játékos Név / ID] [Összeg]", sourcePlayer)
            return
        end
        
        amount = tonumber(amount)
        targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

        if targetName and amount then
            local oldAmount = exports.sCore:getMoney(targetPlayer) or 0
            exports.sCore:setMoney(targetPlayer, amount)
            local adminNick = getElementData(sourcePlayer, "acc.adminNick") or getPlayerName(sourcePlayer)
            local adminTitle = getPlayerAdminTitle and getPlayerAdminTitle(sourcePlayer) or ""
            outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A kiválasztott játékos [color=sightgreen](" .. targetName .. ")[color=hudwhite] egyenlege módosítva! [color=sightgreen](" .. exports.sGui:thousandsStepper(oldAmount) .. " → " .. exports.sGui:thousandsStepper(amount) .. ")", sourcePlayer)
            outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]" .. adminTitle .. " " .. adminNick .. "[color=hudwhite] módosította a készpénz egyenleged! [color=sightgreen](" .. exports.sGui:thousandsStepper(oldAmount) .. " → " .. exports.sGui:thousandsStepper(amount) .. ")", targetPlayer)
            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminNick .. " #ffffffátállította [color=sightgreen]" .. targetName .. " #ffffffkészpénzét. [color=sightgreen](" .. exports.sGui:thousandsStepper(oldAmount) .. " #ffffff→ [color=sightgreen]" .. exports.sGui:thousandsStepper(amount) .. ")")
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Érvénytelen összeg.", sourcePlayer)
        end
    end
end)
--kesz
addCommandHandler("setplayedtime", function(sourcePlayer, sourceCommand, targetPlayer, minutes)
    if exports.sPermission:hasPermission(sourcePlayer, "manageplaytime") then
        if not targetPlayer or not minutes then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/setplayedtime [Játékos Név / ID] [Perc]", sourcePlayer)
            return
        end

        minutes = tonumber(minutes)
        targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

        if targetPlayer and minutes then
            local oldMinutes = exports.sCore:getPlayedMinutes(targetPlayer) or 0
            exports.sCore:setPlayedMinutes(targetPlayer, minutes)
            local adminNick = getElementData(sourcePlayer, "acc.adminNick") or getPlayerName(sourcePlayer)
            local adminTitle = getPlayerAdminTitle and getPlayerAdminTitle(sourcePlayer) or ""
            outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A kiválasztott játékos [color=sightgreen](" .. targetName .. ")[color=hudwhite] játszott ideje módosítva! [color=sightgreen](" .. exports.sGui:thousandsStepper(oldMinutes) .. "p → " .. exports.sGui:thousandsStepper(minutes) .. "p)", sourcePlayer)
            outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]" .. adminTitle .. " " .. adminNick .. "[color=hudwhite] módosította a játszott idődet! [color=sightgreen](" .. exports.sGui:thousandsStepper(oldMinutes) .. "p → " .. exports.sGui:thousandsStepper(minutes) .. "p)", targetPlayer)
            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminNick .. " #ffffffátállította [color=sightgreen]" .. targetName .. " #ffffffjátszott idejét. [color=sightgreen](" .. exports.sGui:thousandsStepper(oldMinutes) .. "p #ffffff→ [color=sightgreen]" .. exports.sGui:thousandsStepper(minutes) .. "p)")
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Érvénytelen érték.", sourcePlayer)
        end
    end
end)
-- kesz
addCommandHandler("sethunger", function(sourcePlayer, sourceCommand, targetPlayer, hunger)
    if exports.sPermission:hasPermission(sourcePlayer, "sethunger") then
        if not targetPlayer or not hunger then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/sethunger [Játékos Név / ID] [Éhség < 0 - 100 >]", sourcePlayer)
            return
        end
        
        hunger = tonumber(hunger)
        targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

        if isElement(targetPlayer) and hunger then
            if hunger > 100 then hunger = 100 end
            if hunger < 0 then hunger = 0 end
            
            local oldHunger = getElementData(targetPlayer, "char.Hunger") or 0
            setElementData(targetPlayer, "char.Hunger", hunger)
            local currentThirst = getElementData(targetPlayer, "char.Thirst")
            triggerClientEvent(targetPlayer, "syncNeeds", targetPlayer, hunger, currentThirst)
            local adminNick = getElementData(sourcePlayer, "acc.adminNick") or getPlayerName(sourcePlayer)
            local adminTitle = getPlayerAdminTitle and getPlayerAdminTitle(sourcePlayer) or ""
            outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A kiválasztott játékos [color=sightgreen](" .. targetName .. ")[color=hudwhite] éhség szintje módosítva! [color=sightgreen](" .. oldHunger .. "% → " .. hunger .. "%)", sourcePlayer)
            outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]" .. adminTitle .. " " .. adminNick .. "[color=hudwhite] módosította az éhség szinted! [color=sightgreen](" .. oldHunger .. "% → " .. hunger .. "%)", targetPlayer)
            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminNick .. " #ffffffátállította [color=sightgreen]" .. targetName .. " #fffffféhség szintjét. [color=sightgreen](" .. oldHunger .. "% #ffffff→ [color=sightgreen]" .. hunger .. "%)")
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Érvénytelen érték.", sourcePlayer)
        end
    end
end)
--kesz
addCommandHandler("setthirst", function(sourcePlayer, sourceCommand, targetPlayer, thirst)
    if exports.sPermission:hasPermission(sourcePlayer, "setthirst") then
        if not targetPlayer or not thirst then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/setthirst [Játékos Név / ID] [Szomjúság < 0 - 100 >]", sourcePlayer)
            return
        end
        
        thirst = tonumber(thirst)
        targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

        if thirst then
            if thirst > 100 then thirst = 100 end
            if thirst < 0 then thirst = 0 end

            local oldThirst = getElementData(targetPlayer, "char.Thirst") or 0
            setElementData(targetPlayer, "char.Thirst", thirst)
            local currentHunger = getElementData(targetPlayer, "char.Hunger")
            triggerClientEvent(targetPlayer, "syncNeeds", targetPlayer, currentHunger, thirst)
            local adminNick = getElementData(sourcePlayer, "acc.adminNick") or getPlayerName(sourcePlayer)
            local adminTitle = getPlayerAdminTitle and getPlayerAdminTitle(sourcePlayer) or ""
            outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]A kiválasztott játékos [color=sightgreen](" .. targetName .. ")[color=hudwhite] szomjúsága módosítva! [color=sightgreen](" .. oldThirst .. "% → " .. thirst .. "%)", sourcePlayer)
            outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]" .. adminTitle .. " " .. adminNick .. "[color=hudwhite] módosította a szomjúságod! [color=sightgreen](" .. oldThirst .. "% → " .. thirst .. "%)", targetPlayer)
            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminNick .. " #ffffffátállította [color=sightgreen]" .. targetName .. " #ffffffszomjúságát. [color=sightgreen](" .. oldThirst .. "% #ffffff→ [color=sightgreen]" .. thirst .. "%)")
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Érvénytelen érték.", sourcePlayer)
        end
    end
end)
-- kesz
addCommandHandler("adutyba", function(sourcePlayer, sourceCommand, targetPlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "forcea") then
        if targetPlayer then
            targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
            if not targetPlayer then
                outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/adutyba [Játékos Név / ID]", sourcePlayer)
                return
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/adutyba [Játékos Név / ID]", sourcePlayer)
            return
        end

        local playerName = getPlayerName(targetPlayer):gsub("_", " ")
        local dutyStatus = getElementData(targetPlayer, "adminDuty")

        local adminNick = getElementData(sourcePlayer, "acc.adminNick") or getPlayerName(sourcePlayer)
        local adminTitle = getPlayerAdminTitle and getPlayerAdminTitle(sourcePlayer) or ""

        executeCommandHandler("aduty", targetPlayer)

        if dutyStatus then
            outputChatBox("[color=sightred][SightMTA - Siker]: [color=hudwhite]Kivetted szolgálatból [color=sightred]" .. playerName .. "[color=hudwhite]-t!", sourcePlayer)
            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminNick .. " #ffffffkivette szolgálatból [color=sightred]" .. playerName .. "#ffffff-t.")
        else

            outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Szolgálatba léptetted [color=sightgreen]" .. playerName .. "[color=hudwhite]-t!", sourcePlayer)
            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminNick .. " #ffffffszolgálatba léptette [color=sightgreen]" .. playerName .. "#ffffff-t.")
        end
    end
end)
--kesz
addCommandHandler("setserverpassword", function(sourcePlayer, sourceCommand, password)
    if exports.sPermission:hasPermission(sourcePlayer, "changeserverpassword") then
        if not password then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/setserverpassword [Jelszó]", sourcePlayer)
            return
        end

        local oldPassword = currentServerPassword or "NO PASSWORD"
        setServerPassword(password)
        currentServerPassword = password
        outputChatBox("[color=sightgreen][SightMTA -Siker]: [color=hudwhite]A szerver jelszava módosítva! [color=sightgreen](" .. oldPassword .. " → " .. password .. ")", sourcePlayer)
        showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminNick .. " #ffffffmódosította a szerver jelszavát. [color=sightgreen](" .. oldPassword .. " #ffffff→ [color=sightgreen]" .. password .. ")")
    end
end)
--kesz
addCommandHandler("removeserverpassword", function(sourcePlayer, sourceCommand)
    if exports.sPermission:hasPermission(sourcePlayer, "changeserverpassword") then
        setServerPassword(nil)
        local adminNick = getElementData(sourcePlayer, "acc.adminNick") or getPlayerName(sourcePlayer)
        local adminTitle = getPlayerAdminTitle and getPlayerAdminTitle(sourcePlayer) or ""
        outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A szerver jelszava eltávolítva!", sourcePlayer)
        showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminNick .. "[color=hudwhite] eltávolította a szerver jelszavát.")
    end
end)
--
addCommandHandler("asegit",
    function (sourcePlayer, commandName, targetPlayer, silent)
        if exports.sPermission:hasPermission(sourcePlayer, "asegit") then

            if not targetPlayer then
                outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [silent=1]", sourcePlayer)
            else
                targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

                if targetPlayer then
                    local adminName = getElementData(sourcePlayer, "acc.adminNick")
                    local title = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)

                    local deathPos = getElementData(targetPlayer, "deathPosition")

                    local x, y, z = getElementPosition(targetPlayer)
                    local int = getElementInterior(targetPlayer)
                    local dim = getElementDimension(targetPlayer)
                    local skin = getElementModel(targetPlayer)
                    local rot = getPedRotation(targetPlayer)

                    if deathPos then
                        x, y, z, int, dim = unpack(deathPos)
                    end
                    exports.sDeath:destroyPlayerPed(targetPlayer)

                    setElementData(targetPlayer, "isPlayerDeath", false)
                    setElementData(targetPlayer, "deathPosition", false)
                    setElementData(targetPlayer, "bodyDamage", false)
                    setElementData(targetPlayer, "char.Hunger", 100)
                    setElementData(targetPlayer, "char.Thirst", 100)
                    triggerClientEvent(targetPlayer, "playerRespawnedFromDeath", targetPlayer, false)
                    triggerClientEvent(targetPlayer, "syncNeeds", targetPlayer, 100, 100)
                    setElementData(targetPlayer, "bloodDamage", false)

                    triggerEvent("stopRespawnTimer", targetPlayer, targetPlayer)

                    setElementDimension(targetPlayer, 0)
                    setElementInterior(targetPlayer, 0)

                    exports.sAnticheat:sendWebhookMessage("**".. getElementData(sourcePlayer, "visibleName"):gsub("_", " ") .."** felélesztette **"..targetName.."-t.**", "ahelp")

                    setElementData(targetPlayer, "customDeath", nil)

                    spawnPlayer(targetPlayer, x, y, z, rot, skin, int, dim)

                    outputChatBox("[color=sightgreen][SightMTA - Siker]: #ffffffSikeresen felsegítetted a kiválasztott játékost. [color=sightgreen](" .. targetName .. ")", sourcePlayer)
                    if not (exports.sPermission:hasPermission(sourcePlayer, "hiddenAsegit") and silent == "1") then
                        outputChatBox("[color=sightgreen][SightMTA]: " .. title .. " " .. adminName .. " #fffffffelsegített téged.", targetPlayer)
                    end

                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. title .. " " .. adminName .. " #fffffffelsegítette [color=sightgreen]" .. targetName .. "[color=hudwhite] játékost.")

                    exports.sControls:toggleAllControls(targetPlayer, true)

                    local adminAccID = getElementData(sourcePlayer, "char.accID")
                    local connection = exports.sConnection:getConnection()
    
                    if adminAccID and connection then
                        dbQuery(function(queryHandle)
                            local result = dbPoll(queryHandle, 0)
                            local playerFixesData = {}

                            if result and #result > 0 then
                                local jsonData = result[1].playerFixes
                                if jsonData and jsonData ~= "" then
                                    playerFixesData = fromJSON(jsonData)
                                    if not playerFixesData then
                                        playerFixesData = {}
                                    end
                                end
                            else
                                dbExec(connection, "INSERT INTO adminstats (characterIdentity, playerFixes) VALUES (?, ?)", adminAccID, "[]")
                            end

                            local newFixData = {
                                action = "asegit",
                                targetPlayerName = targetName,
                                timestamp = getRealTime().timestamp
                            }

                            table.insert(playerFixesData, newFixData)

                            local newJsonData = toJSON(playerFixesData)

                            dbExec(connection, "UPDATE adminstats SET playerFixes = ? WHERE characterIdentity = ?", newJsonData, adminAccID)
                        end, connection, "SELECT playerFixes FROM adminstats WHERE characterIdentity = ?", adminAccID)
                    end
                end
            end
        end
    end
)
--
addCommandHandler("agyogyit", function(sourcePlayer, commandName, targetPlayer, silent)
    if exports.sPermission:hasPermission(sourcePlayer, "agyogyit") then
        if not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [silent=1]", sourcePlayer)
        else
            targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

            if targetPlayer then
                local adminName = getElementData(sourcePlayer, "acc.adminNick")
                local title = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)

                setElementHealth(targetPlayer, 100)
                setElementData(targetPlayer, "char.Hunger", 100)
                setElementData(targetPlayer, "char.Thirst", 100)
                setElementData(targetPlayer, "bodyDamage", false)
                setElementData(targetPlayer, "bloodDamage", false)

                exports.sAnticheat:sendWebhookMessage("**".. getElementData(sourcePlayer, "visibleName"):gsub("_", " ") .."** meggyógyította **"..targetName.."-t.**", "ahelp")


                triggerClientEvent(targetPlayer, "syncNeeds", targetPlayer, 100, 100)
                
                outputChatBox("[color=sightgreen][SightMTA - Siker]: #ffffffSikeresen meggyógyítottad a kiválasztott játékost. [color=sightgreen](" .. targetName .. ")", sourcePlayer)
                if not (exports.sPermission:hasPermission(sourcePlayer, "hiddenAgyogyit") and silent == "1") then
                    outputChatBox("[color=sightgreen][SightMTA]: " .. title .. " " .. adminName .. " #ffffffmeggyógyított téged.", targetPlayer)
                end

                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. title .. " " .. adminName .. " #ffffffmeggyógyította [color=sightgreen]" .. targetName .. "[color=hudwhite] játékost.")

                local adminAccID = getElementData(sourcePlayer, "char.accID")
                local connection = exports.sConnection:getConnection()
    
                if adminAccID and connection then
                    dbQuery(function(queryHandle)
                        local result = dbPoll(queryHandle, 0)
                        local playerFixesData = {}

                        if result and #result > 0 then
                            local jsonData = result[1].playerFixes
                            if jsonData and jsonData ~= "" then
                                playerFixesData = fromJSON(jsonData)
                                if not playerFixesData then
                                    playerFixesData = {}
                                end
                            end
                        else
                            dbExec(connection, "INSERT INTO adminstats (characterIdentity, playerFixes) VALUES (?, ?)", adminAccID, "[]")
                        end

                        local newFixData = {
                            action = "agyogyit",
                            targetPlayerName = targetName,
                            timestamp = getRealTime().timestamp
                        }

                        table.insert(playerFixesData, newFixData)

                        local newJsonData = toJSON(playerFixesData)

                        dbExec(connection, "UPDATE adminstats SET playerFixes = ? WHERE characterIdentity = ?", newJsonData, adminAccID)
                    end, connection, "SELECT playerFixes FROM adminstats WHERE characterIdentity = ?", adminAccID)
                end
            end
        end
    end
end)
-- kesz
addCommandHandler("setdim", function(sourcePlayer, commandName, targetPlayer, targetDimension)
    if exports.sPermission:hasPermission(sourcePlayer, "agyogyit") then
        if not targetPlayer or not targetDimension then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Dimenzió]", sourcePlayer)
        else
            targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

            if targetPlayer then
                local adminName = getElementData(sourcePlayer, "acc.adminNick")
                local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
                local oldDimension = getElementDimension(targetPlayer)

                if targetPlayer == sourcePlayer then
                    outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen megváltoztattad a dimenziódat! [color=sightgreen]["..oldDimension.." → "..targetDimension.."]", targetPlayer)
                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffmegváltoztatta a saját dimenzióját. [color=sightgreen]("..oldDimension.." #ffffff→ [color=sightgreen]"..targetDimension..")")
                else
                    outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen megváltoztattad a következő játékosnak a dimenzióját! [color=sightgreen] "..targetName.." [color=sightgreen]("..oldDimension.." →"..targetDimension..")", sourcePlayer)
                    outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]" .. title .. " " .. adminName .. " [color=hudwhite]megváltoztatta a dimenziódat! [color=sightgreen][" .. oldDimension .. " → " .. targetDimension .. "]", targetPlayer)
                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffmegváltoztatta [color=sightgreen]"..targetName.." #ffffffdimenzióját. [color=sightgreen]("..oldDimension.." #ffffff→ [color=sightgreen]"..targetDimension..")")
                end

                setElementDimension(targetPlayer, tonumber(targetDimension))
            end
        end
    end
end)
--kesz
addCommandHandler("setint", function(sourcePlayer, commandName, targetPlayer, targetInterior)
    if exports.sPermission:hasPermission(sourcePlayer, "agyogyit") then
        if not targetPlayer or not targetInterior then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Interior]", sourcePlayer)
        else
            targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

            if targetPlayer then
                local adminName = getElementData(sourcePlayer, "acc.adminNick")
                local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
                local oldInterior = getElementInterior(targetPlayer)

                if targetPlayer == sourcePlayer then
                    outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen megváltoztattad a interiorodat! [color=sightgreen]["..oldInterior.." → "..targetInterior.."]", targetPlayer)
                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffmegváltoztatta a saját interiorját. [color=sightgreen]["..oldInterior.." #ffffff→ [color=sightgreen]"..targetInterior.."]")
                else
                    outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen megváltoztattad a következő játékosnak a interiorját! [color=sightgreen] "..targetName.." [color=sightgreen]["..oldInterior.." → "..targetInterior.."] ", sourcePlayer)
                    outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]" .. title .. " " .. adminName .. " megváltoztatta a interiorodat! [color=sightgreen][" .. oldInterior .. " → " .. targetInterior .. "]", targetPlayer)
                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffmegváltoztatta [color=sightgreen]"..targetName.." #ffffffinteriorját. [color=sightgreen]("..oldInterior.." #ffffff→ [color=sightgreen]"..targetInterior..")")
                end

                setElementInterior(targetPlayer, tonumber(targetInterior))
            end
        end
    end
end)

--kesz
addCommandHandler("ban",
	function (sourcePlayer, commandName, targetPlayer, time, ...)
		if exports.sPermission:hasPermission(sourcePlayer, "ban") then
            local reason = table.concat({...}, " ")
            local time = tonumber(time)
			if not targetPlayer or not reason or not time then
				outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Óra < 0 = örök >] [Indok]", sourcePlayer)
			else
                local adminName = getElementData(sourcePlayer, "acc.adminNick")
                local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)

                targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
                targetName = targetName:gsub("_", " ")

				if targetPlayer and (getElementData(targetPlayer, "acc.adminLevel") or 0) <= getElementData(sourcePlayer, "acc.adminLevel") then
                    if time == 0 then
                        outputChatBox("[color=sightred][SightMTA - Ban]: [color=sightblue]" .. targetName .. " #ffffffki lett tiltva a szerverről [color=sightblue]" .. getElementData(sourcePlayer, "acc.adminNick") .. " #ffffffáltal. (örökre)", root, 255, 255, 255, true)
                        time = 99999
                    else
                        outputChatBox("[color=sightred][SightMTA - Ban]: [color=sightblue]" .. targetName .. " #ffffffki lett tiltva a szerverről [color=sightblue]" .. getElementData(sourcePlayer, "acc.adminNick") .. " #ffffffáltal. (" .. time .. " óra)", root, 255, 255, 255, true)
                    end
                    outputChatBox("[color=sightred][SightMTA - Ban]: [color=sightblue]Indok: #ffffff" .. reason, root, 255, 255, 255, true)
                    dbExec(connection, "UPDATE accounts SET suspended = ? WHERE accountId = ?", 1, getElementData(targetPlayer, "char.accID"))
                    dbExec(connection, "INSERT INTO bans SET serial = ?, playerName = ?, playerAccountId = ?, adminAccountId = ?, banReason = ?, banTimestamp = ?, expireTimestamp = ?, deactivated = ?, deactivatedBy = ?, deactivateReason = ?, deactivateTimestamp = ?, adminName = ?",
                    getPlayerSerial(targetPlayer), targetName, getElementData(targetPlayer, "char.accID"), getElementData(sourcePlayer, "char.accID"), reason, getRealTime().timestamp,
                    getRealTime().timestamp + (time * (60 * 60)), 0, 0, 0, 0, getElementData(sourcePlayer, "acc.adminNick"))
                    kickPlayer(targetPlayer, "Ki lettél tiltva a szerverről!")

                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffkitiltotta [color=sightgreen]" .. targetName .. " #ffffffjátékost. [color=sightgreen]Indok: #ffffff" .. reason .. " [color=sightgreen](" .. (time == 99999 and "örökre" or (time .. " óra")) .. ")")
				end
			end
		end
	end
)

-- kesz
addCommandHandler("oban",
	function (sourcePlayer, commandName, targetPlayer, time, ...)
		if exports.sPermission:hasPermission(sourcePlayer, "ban") then
            local time = tonumber(time)
            if ... and targetPlayer then
                reason = table.concat({...}, " ")
            end
			if not targetPlayer or not reason or not time then
				outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Játékos Név pl. (John_Doe)] [Óra < 0 = örök >] [Indok]", sourcePlayer)
			else

				if targetPlayer then
                    local displayName = targetPlayer:gsub("_", " ")
                    local adminName = getElementData(sourcePlayer, "acc.adminNick")
                    local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)

                    if time == 0 then
                        outputChatBox("[color=sightred][SightMTA - Ban]: [color=sightblue]" .. displayName .. " #ffffffki lett tiltva a szerverről [color=sightblue]" .. getElementData(sourcePlayer, "acc.adminNick") .. " #ffffffáltal. (örökre)", root, 255, 255, 255, true)
                        time = 99999
                    else
                        outputChatBox("[color=sightred][SightMTA - Ban]: [color=sightblue]" .. displayName .. " #ffffffki lett tiltva a szerverről [color=sightblue]" .. getElementData(sourcePlayer, "acc.adminNick") .. " #ffffffáltal. (" .. time .. " óra)", root, 255, 255, 255, true)
                    end
                    outputChatBox("[color=sightred][SightMTA - Ban]: [color=sightblue]Indok: #ffffff" .. reason, root, 255, 255, 255, true)

					dbQuery(function(qh, targetPlayer, sourcePlayer)
						local result = dbPoll(qh, 0)[1]
						accid = result.accountId
						dbQuery(function(qh, targetPlayer, sourcePlayer, accid)
							local result = dbPoll(qh, 0)[1]
							serial = result.serial
							dbExec(connection, "INSERT INTO bans SET serial = ?, playerName = ?, playerAccountId = ?, adminAccountId = ?, banReason = ?, banTimestamp = ?, expireTimestamp = ?, deactivated = ?, deactivatedBy = ?, deactivateReason = ?, deactivateTimestamp = ?, adminName = ?",
							serial, targetPlayer, accid, getElementData(sourcePlayer, "char.accID"), reason, getRealTime().timestamp,
							getRealTime().timestamp + (time * (60 * 60)), 0, 0, 0, 0, getElementData(sourcePlayer, "acc.adminNick"))

							showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffkitiltotta [color=sightgreen]" .. targetPlayer:gsub("_", " ") .. " #ffffffjátékost. [color=sightgreen]Indok: #ffffff" .. reason .. " [color=sightgreen](" .. (time == 99999 and "örökre" or (time .. " óra")) .. ")")

						end, {targetPlayer, sourcePlayer, accid}, connection, "SELECT * FROM accounts WHERE accountId = ?", accid)
					end, {targetPlayer, sourcePlayer}, connection, "SELECT * FROM characters WHERE name = ?", targetPlayer)
				end
			end
		end
	end
)
--kesz
addCommandHandler("unban",
	function (sourcePlayer, commandName, targetPlayer, ...)
		if exports.sPermission:hasPermission(sourcePlayer, "ban") then
            local reason = table.concat({...}, " ")
			if not targetPlayer or not reason then
				outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Serial] [Indok]", sourcePlayer)
			else
				dbQuery(function(qh)
					local result = dbPoll(qh, 0)
					if result and #result > 0 then
						dbExec(connection, "UPDATE bans SET deactivated = ?, deactivatedBy = ?, deactivateReason = ?, deactivateTimestamp = ?, active = 0 WHERE serial = ? AND deactivated = 0 AND active = 1",
							1, getElementData(sourcePlayer, "acc.adminNick"), reason, getRealTime().timestamp, targetPlayer)
						dbExec(connection, "UPDATE accounts SET suspended = ? WHERE serial = ?", 0, targetPlayer)

                        local adminName = getElementData(sourcePlayer, "acc.adminNick")
                        local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
						showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffeloldotta [color=sightgreen]" .. targetPlayer .. " #ffffffserialhoz tartozó tiltást. [color=sightgreen]Indok: #ffffff" .. reason)
					else
						outputChatBox("[color=sightred][SightMTA - Hiba]: #ffffffNem található aktív tiltás ezzel a seriallal: [color=sightred]" .. targetPlayer, sourcePlayer)
					end
				end, connection, "SELECT * FROM bans WHERE serial = ? AND deactivated = 0 AND active = 1", targetPlayer)
			end
		end
	end
)


addCommandHandler("stats", 
    function(sourcePlayer, commandName, targetPlayer)
        if exports.sPermission:hasPermission(sourcePlayer, "stats") then
            if not targetPlayer then
                outputChatBox("[color=sightgreen][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID]", sourcePlayer)
            else
                targetPlayer, targetCName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

                if targetPlayer then
                    local targetName = getElementData(targetPlayer, "char.name"):gsub("_", " ")
                    local targetAccountId, targetCharacterId = getElementData(targetPlayer, "char.accID"), getElementData(targetPlayer, "char.ID")
                    local targetLevel, targetId = getElementData(targetPlayer, "char.level"), getElementData(targetPlayer, "playerID")
                    local targetMoney, targetBankMoney = exports.sCore:getMoney(targetPlayer), exports.sCore:getBankMoney(targetPlayer)
                    local targetPP, targetSSC = exports.sCore:getPP(targetPlayer), exports.sCore:getSSC(targetPlayer)
                    local targetHealth, targetHunger, targetThirst = getElementHealth(targetPlayer), getElementData(targetPlayer, "char.Hunger"), getElementData(targetPlayer, "char.Thirst")
                    local boneDamages = getElementData(targetPlayer, "bodyDamage") or {false, false, false, false}
                    local targetAnimals = exports.sAnimals:getPlayerAnimals(targetCharacterId)
                    local targetGroups = exports.sGroups:getPlayerGroups(targetPlayer)
                    local targetSSC = exports.sCore:getSSC(targetPlayer)

                    local adminName = getElementData(targetPlayer, "acc.adminNick")
                    local adminRank = getPlayerAdminTitle(targetPlayer)

                    outputChatBox("[color=sightgreen]============[color=hudwhite][ [color=sightblue]"..targetName.." adatai [color=hudwhite]][color=sightgreen]============", sourcePlayer, 255, 255, 255, true)
                    outputChatBox("AccountID: [color=sightblue]"..targetAccountId.."[color=hudwhite] | CharacterID: [color=sightblue]"..targetCharacterId, sourcePlayer, 255, 255, 255, true)
                    outputChatBox("Szint: [color=sightblue]"..targetLevel.."[color=hudwhite] | ID: [color=sightblue]"..targetId, sourcePlayer, 255, 255, 255, true)
                    outputChatBox("Pénz: [color=sightgreen]"..exports.sGui:thousandsStepper(targetMoney).." $[color=hudwhite] | Banki egyenleg: [color=sightgreen]"..exports.sGui:thousandsStepper(targetBankMoney).." $", sourcePlayer, 255, 255, 255, true)
                    outputChatBox("PrémiumPont: [color=sightblue]"..exports.sGui:thousandsStepper(targetPP).." PP[color=hudwhite] | SSC: [color=sightyellow]"..exports.sGui:thousandsStepper(targetSSC).." SSC", sourcePlayer, 255, 255, 255, true)
                    outputChatBox("HP: [color=sightred]"..targetHealth.."[color=sightred]%[color=hudwhite] | Éhség: [color=sightyellow]"..targetHunger.."[color=sightyellow]%[color=hudwhite] | Szomjúság: [color=sightblue]"..targetThirst.."[color=sightblue]%", sourcePlayer, 255, 255, 255, true)
                    if (getElementData(targetPlayer, "acc.adminLevel") or 0) > 1 then
                        outputChatBox("ADMIN: [color=sightred]"..adminRank.."[color=hudwhite] | Admin név: [color=sightblue]"..adminName, sourcePlayer, 255, 255, 255, true)
                    end
                    if getElementData(targetPlayer, "acc.adminJail") and getElementData(targetPlayer, "acc.adminJailTime") and getElementData(targetPlayer, "acc.adminJailReason") then
                        outputChatBox("Jail idő (perc): [color=sightred]"..getElementData(targetPlayer, "acc.adminJailTime").."[color=hudwhite] | Indok: [color=sightblue]"..getElementData(targetPlayer, "acc.adminJailReason"), sourcePlayer, 255, 255, 255, true)
                    end
                    exports.sAnticheat:sendWebhookMessage("**" .. getElementData(sourcePlayer, "visibleName"):gsub("_", " ") .. "** lekérte **" .. targetName .. "** játékos adatait.", "astats")

                    local tmpBone = {}

                    for k, v in ipairs(boneDamages) do
                        if v then
                            table.insert(tmpBone, k)
                        end
                    end

                    outputChatBox("Állatok:", sourcePlayer, 255, 255, 255, true)

                    for k, v in ipairs(targetAnimals) do
                        if k > 0 then
                            outputChatBox("  [color=hudwhite]Név: [color=sightblue]"..(v.name).."[color=hudwhite] | [color=hudwhite]Típus: [color=sightblue]"..(v.type), sourcePlayer, 255, 255, 255, true)
                        end
                    end

                    outputChatBox("Frakciók:", sourcePlayer, 255, 255, 255, true)

                    for k, v in pairs(targetGroups) do
                        if v.isLeader then
                            outputChatBox("  [color=sightblue]"..exports.sGroups:getGroupName(k).." [color=hudwhite]| [color=hudwhite]Rang: [color=sightblue]"..exports.sGroups:getGroupRankName(k, v.rank) .. "*", sourcePlayer, 255, 255, 255, true)
                        else
                            outputChatBox("  [color=sightblue]"..exports.sGroups:getGroupName(k).." [color=hudwhite]| [color=hudwhite]Rang: [color=sightblue]"..exports.sGroups:getGroupRankName(k, v.rank), sourcePlayer, 255, 255, 255, true)
                        end
                    end

                    local adminName = getElementData(sourcePlayer, "acc.adminNick")
                    local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #fffffflekérte [color=sightgreen]" .. targetName .. " #ffffffjátékos adatait.")
                end
            end
        end
    end
)

addCommandHandler("getradio", 
    function(sourcePlayer, commandName, targetPlayer)
        if exports.sPermission:hasPermission(sourcePlayer, "getradio") then
            if not targetPlayer then
                outputChatBox("[color=sightblue][SightMTA - Radio]: #ffffff/" .. commandName .. " [Játékos Név / ID]", sourcePlayer)
            else
                targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

                if targetPlayer then
                    local targetName = getElementData(targetPlayer, "char.name"):gsub("_", " ")
                    local freqs = getElementData(targetPlayer, "char.Radio") or {}
                    local freq1 = "Nincs"
                    local freq2 = "Nincs"
                    if freqs and freqs[1] then
                        freq1 = freqs[1]
                    end
                    if freqs and freqs[2] then
                        freq2 = freqs[2]
                    end
                    outputChatBox("[color=sightgreen][SightMTA - Radio]:[color=sightblue] " .. targetName .. " [color=hudwhite]rádiófrekvenciái: \n[color=sightblue]R1: [color=hudwhite]" .. freq1 .. "\n[color=sightblue]R2: [color=hudwhite]" .. freq2, sourcePlayer)
                end
            end
        end
    end
)

addCommandHandler("getradiomembers", 
    function(sourcePlayer, commandName, radioFreq)
        if exports.sPermission:hasPermission(sourcePlayer, "getradiomembers") then
            local freq = tonumber(radioFreq)
            if not freq then
                outputChatBox("[color=sightblue][SightMTA - Radio]: #ffffff/" .. commandName .. " [Frekvencia]", sourcePlayer)
            else
                local counter = 0
                for k, v in pairs(getElementsByType("player")) do
                    local playerFreqs = getElementData(v, "char.Radio") or {}
                    if (playerFreqs[1] and playerFreqs[1] == freq) or (playerFreqs[2] and playerFreqs[2] == freq) then
                        local playerName = getElementData(v, "char.name"):gsub("_", " ")
                        outputChatBox("[color=sightgreen][SightMTA - Radio]: [color=hudwhite]" .. playerName, sourcePlayer)
                        counter = counter + 1
                    end
                end
                if counter == 0 then
                    outputChatBox("[color=sightred][SightMTA - Radio]: [color=hudwhite]Ezen a frekvencián nincs senki.", sourcePlayer)
                end
            end
        end
    end
)

addCommandHandler("gotoatm", 
    function(sourcePlayer, commandName, atmId)
        if exports.sPermission:hasPermission(sourcePlayer, "gotoatm") then
            local atmId = tonumber(atmId)
            if not atmId then
                outputChatBox("[color=sightblue][SightMTA - Bank]: #ffffff/" .. commandName .. " [ATM ID]", sourcePlayer)
            else
                local position = exports.sBank:getATMPosition(atmId)
                if position then
                    local x, y, z = position[1], position[2], position[3]
                    setElementPosition(sourcePlayer, x, y, z + 1)
                    outputChatBox("[color=sightgreen][SightMTA - Bank]: [color=hudwhite]Sikeresen elteleportáltál az ATM-hez!", sourcePlayer)
                else
                    outputChatBox("[color=sightred][SightMTA - ATM]: [color=hudwhite]Nem található ATM ezzel az azonosítóval.", sourcePlayer)
                end
            end
        end
    end
)

addCommandHandler("getphoneowner", 
    function(sourcePlayer, commandName, phoneNumber)
        if exports.sPermission:hasPermission(sourcePlayer, "getphoneowner") then
            local phoneNumber = tonumber(phoneNumber)
            if not phoneNumber then
                outputChatBox("[color=sightblue][SightMTA - Phone]: #ffffff/" .. commandName .. " [Telefonszám (pl. 3873294576)]", sourcePlayer)
            else
                local found = false
                for k, v in pairs(getElementsByType("player")) do
                    if tonumber(getPlayerMobile(v)) == phoneNumber then
                        outputChatBox("[color=sightgreen][SightMTA - Phone]: [color=hudwhite]A telefonszám tulajdonosa: [color=sightblue]" .. getElementData(v, "char.name"):gsub("_", " "), sourcePlayer)
                        found = true
                        break
                    end
                end
                if not found then
                    outputChatBox("[color=sightred][SightMTA - Phone]: [color=hudwhite]Nem található a telefonszám tulajdonosa.", sourcePlayer)
                end
            end
        end
    end
)

addCommandHandler("avariant", 
    function(sourcePlayer, commandName, targetPlayer, variant)
        if exports.sPermission:hasPermission(sourcePlayer, "avariant") then
            local variant = tonumber(variant)
            if not targetPlayer or not variant then
                outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Variáns (0 - 255)]", sourcePlayer)
            else
                targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

                if targetPlayer then
                    local vehicle = getPedOccupiedVehicle(targetPlayer)
                    if vehicle then
                        local vehicleId = getElementData(vehicle, "vehicle.dbID")
                        local variantData = toJSON({variant, 255})
                        dbExec(connection, "UPDATE vehicles SET variant = ? WHERE dbID = ?", variantData, vehicleId)
                        setVehicleVariant(vehicle, variant, 255)
                        outputChatBox("[color=sightgreen][SightMTA - Admin]: [color=hudwhite]Sikeresen beállítottad a variánst!", sourcePlayer)
                    else
                        outputChatBox("[color=sightred][SightMTA - Admin]: [color=hudwhite]A parancs használatához autóban kell ülni!", sourcePlayer)
                    end
                end
            end
        end
    end
)

addCommandHandler("setAbs", 
    function(sourcePlayer, commandName, targetPlayer, abs)
        if exports.sPermission:hasPermission(sourcePlayer, "setAbs") then
            local abs = tonumber(abs)
            if not targetPlayer or not abs then
                outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [ABS (0 - 3)]", sourcePlayer)
            else
                targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

                if targetPlayer then
                    local vehicle = getPedOccupiedVehicle(targetPlayer)
                    if vehicle then
                        local vehicleId = getElementData(vehicle, "vehicle.dbID")
                        setElementData(vehicle, "abs", abs)
                        dbExec(connection, "UPDATE vehicles SET abs = ? WHERE dbID = ?", abs, vehicleId)
                        outputChatBox("[color=sightgreen][SightMTA - Admin]: [color=hudwhite]Sikeresen beállítottad az ABS-t.", sourcePlayer)
                    else
                        outputChatBox("[color=sightred][SightMTA - Admin]: [color=hudwhite]A parancs használatához autóban kell ülni!", sourcePlayer)
                    end
                end
            end
        end
    end
)

addCommandHandler("bizonylat", 
    function(sourcePlayer, commandName, targetPlayer, weapon, serial, price)
        if exports.sPermission:hasPermission(sourcePlayer, "bizonylat") then
            local serial = tonumber(serial)
            local price = tonumber(price)
            local weapon = tonumber(weapon)
            if not targetPlayer or not serial or not price or not weapon then
                outputChatBox("[color=sightblue][SightMTA - Premium]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Fegyver item ID] [Sorozatszám (csak szám)] [Vételár]", sourcePlayer)
            else
                targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

                if targetPlayer then
                    local serial = exports.sItems:formatSerial(weapon, serial)
                    exports.sItems:giveItem(targetPlayer, 583, 1, false, toJSON({
                        item = weapon,
                        serial = serial,
                        buyer = string.gsub(getElementData(targetPlayer, "char.name"), "_", " "),
                        acc = getElementData(targetPlayer, "char.accID"),
                        price = price,
                        ts = getRealTime().timestamp
                    }, true))
                    outputChatBox("[color=sightgreen][SightMTA - Premium]: [color=hudwhite]Sikeresen készítettél egy bizonylatot!", sourcePlayer)
                end
            end
        end
    end
)

addCommandHandler("getinteriorpeds", 
    function(sourcePlayer, commandName)
        if exports.sPermission:hasPermission(sourcePlayer, "getinteriorpeds") then
            local dim = getElementDimension(sourcePlayer)
            local int = getElementInterior(sourcePlayer)
            
            local peds = exports.sPeds:getInteriorPeds(int, dim)
            
            local px, py, pz = getElementPosition(sourcePlayer)

            if peds and #peds > 0 then
                for k, v in pairs(peds) do
                    local x, y, z = v.posX, v.posY, v.posZ
                    local dist = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
                    outputChatBox("   [color=sightgreen]" .. v.name .. "#ffffff - ID: [color=sightblue]" .. v.id .. "[color=hudwhite] Távolság: [color=sightgreen]" .. math.floor(dist) .. "[color=hudwhite] m", sourcePlayer)
                end
            else
                outputChatBox("[color=sightred][SightMTA - PED]: [color=hudwhite]Nem található az interiorban egy PED sem.", sourcePlayer)
            end
        end
    end
)

addCommandHandler("gotoped", 
    function(sourcePlayer, commandName, pedId)
        if exports.sPermission:hasPermission(sourcePlayer, "gotoped") then
            local pedId = tonumber(pedId)
            if not pedId then
                outputChatBox("[color=sightblue][SightMTA - PED]:[color=hudwhite] /" .. commandName .. " [Ped ID]", sourcePlayer)
            else
                local pedDatas = exports.sPeds:getPedDetailsByID(pedId)
                if pedDatas then

                    local x, y, z, int, dim = pedDatas.posX, pedDatas.posY, pedDatas.posZ, pedDatas.interior, pedDatas.dimension

                    setElementPosition(sourcePlayer, x, y, z)
                    setElementDimension(sourcePlayer, dim)
                    setElementInterior(sourcePlayer, int)

                    outputChatBox("[color=sightgreen][SightMTA - PED]: [color=hudwhite]Sikeresen elteleportáltál a kiválasztott PED-hez.", sourcePlayer)
                else
                    outputChatBox("[color=sightred][SightMTA - PED]: [color=hudwhite]Nem található PED ezzel az ID-vel.", sourcePlayer)
                end
            end
        end
    end
)

addCommandHandler("moveped", 
    function(sourcePlayer, commandName, pedId)
        if exports.sPermission:hasPermission(sourcePlayer, "moveped") then
            local pedId = tonumber(pedId)
            if not pedId then
                outputChatBox("[color=sightblue][SightMTA - PED]:[color=hudwhite] /" .. commandName .. " [Ped ID]", sourcePlayer)
            else
                local pedDatas = exports.sPeds:getPedDetailsByID(pedId)
                if pedDatas then

                    local success = exports.sPeds:setPedPosition(sourcePlayer, pedId)

                    if success then
                        outputChatBox("[color=sightgreen][SightMTA - PED]:[color=hudwhite] Sikeresen megváltoztattad a PED pozícióját!", sourcePlayer)
                    else
                        outputChatBox("[color=sightred][SightMTA - PED]:[color=hudwhite] Nem sikerült a kiválasztott PED mozgatása!", sourcePlayer)
                    end
                else
                    outputChatBox("[color=sightred][SightMTA - PED]:[color=hudwhite] Nem található PED ezzel az ID-vel!", sourcePlayer)
                end
            end
        end
    end
)

addCommandHandler("rotateped", 
    function(sourcePlayer, commandName, pedId)
        if exports.sPermission:hasPermission(sourcePlayer, "rotateped") then
            local pedId = tonumber(pedId)
            if not pedId then
                outputChatBox("[color=sightblue][SightMTA - PED]:[color=hudwhite] /" .. commandName .. " [Ped ID]", sourcePlayer)
            else
                local pedDatas = exports.sPeds:getPedDetailsByID(pedId)
                if pedDatas then

                    local success = exports.sPeds:setPedRotation(sourcePlayer, pedId)

                    if success then
                        outputChatBox("[color=sightgreen][SightMTA - PED]:[color=hudwhite] Sikeresen megváltoztattad a PED rotációját!", sourcePlayer)
                    else
                        outputChatBox("[color=sightred][SightMTA - PED]:[color=hudwhite] Nem sikerült a kiválasztott PED forgatása!", sourcePlayer)
                    end
                else
                    outputChatBox("[color=sightred][SightMTA - PED]:[color=hudwhite] Nem található PED ezzel az ID-vel!", sourcePlayer)
                end
            end
        end
    end
)

addCommandHandler("deleteped", 
    function(sourcePlayer, commandName, pedId)
        if exports.sPermission:hasPermission(sourcePlayer, "deleteped") then
            local pedId = tonumber(pedId)
            if not pedId then
                outputChatBox("[color=sightblue][SightMTA - PED]:[color=hudwhite] /" .. commandName .. " [Ped ID]", sourcePlayer)
            else
                local pedDatas = exports.sPeds:getPedDetailsByID(pedId)
                if pedDatas then

                    local success = exports.sPeds:deletePed(sourcePlayer, pedId)

                    if success then
                        outputChatBox("[color=sightgreen][SightMTA - PED]:[color=hudwhite] Sikeresen kitörölted a kiválaszott PED-et!", sourcePlayer)
                    else
                        outputChatBox("[color=sightred][SightMTA - PED]:[color=hudwhite] Nem sikerült a kiválasztott PED törlése!", sourcePlayer)
                    end
                else
                    outputChatBox("[color=sightred][SightMTA - PED]:[color=hudwhite] Nem található PED ezzel az ID-vel!", sourcePlayer)
                end
            end
        end
    end
)

local lawEnforcementGroups = {
    ["PD"] = true,
    ["NAV"] = true,
    ["TEK"] = true,
    ["ARMY"] = true,
    ["OPSZ"] = true,
    ["NNI"] = true,
}


addCommandHandler("getlawduty", 
    function(sourcePlayer, commandName)
        if exports.sPermission:hasPermission(sourcePlayer, "getlawduty") then
            local count = 0
            for k, v in pairs(getElementsByType("player")) do
                local dutyData = getElementData(v, "inDuty")
                if dutyData and lawEnforcementGroups[dutyData] then
                    count = count + 1
                end
            end
            outputChatBox("[color=sightgreen][SightMTA - Police]: [color=hudwhite]Szolgálatban lévő rendvédelmi frakciótagok száma: [color=sightblue]" .. count, sourcePlayer)
        end
    end
)

addCommandHandler("changelock2gate", 
    function(sourcePlayer, commandName, gateId)
        if exports.sPermission:hasPermission(sourcePlayer, "changelock2gate") then
            local gateId = tonumber(gateId)
            if not gateId then
                outputChatBox("[color=sightblue][SightMTA - Gate]:[color=hudwhite] /" .. commandName .. " [Gate ID]", sourcePlayer)
            else
                local gateDatas = exports.sGates:getGateDetails(gateId)
                if gateDatas then
                    exports.sItems:giveItem(sourcePlayer, 3, 1, false, gateId)                    
                    outputChatBox("[color=sightgreen][SightMTA - Gate]:[color=hudwhite] Sikeresen másoltál egy kulcsot a kapuhoz.", sourcePlayer)
                else
                    outputChatBox("[color=sightred][SightMTA - Gate]:[color=hudwhite] Nem található kapu ezzel az ID-vel.", sourcePlayer)
                end
            end
        end
    end
)

addCommandHandler("gotogate", 
    function(sourcePlayer, commandName, gateId)
        if exports.sPermission:hasPermission(sourcePlayer, "gotogate") then
            local gateId = tonumber(gateId)
            if not gateId then
                outputChatBox("[color=sightblue][SightMTA - Gate]:[color=hudwhite] /" .. commandName .. " [Gate ID]", sourcePlayer)
            else
                local gateDatas = exports.sGates:getGateDetails(gateId)
                if gateDatas then
                    local pos = gateDatas.closed
                    local x, y, z = pos[1], pos[2], pos[3]
                    local int, dim = gateDatas.int, gateDatas.dim
                    
                    setElementPosition(sourcePlayer, x, y, z)
                    setElementInterior(sourcePlayer, int)
                    setElementDimension(sourcePlayer, dim)

                    outputChatBox("[color=sightgreen][SightMTA - Gate]:[color=hudwhite] Sikeresen elteleportáltál a kapuhoz!", sourcePlayer)
                else
                    outputChatBox("[color=sightred][SightMTA - Gate]:[color=hudwhite] Nem található kapu ezzel az ID-vel!", sourcePlayer)
                end
            end
        end
    end
)

addCommandHandler("anamesstate", 
    function(sourcePlayer, commandName, targetPlayer)
        if exports.sPermission:hasPermission(sourcePlayer, "anamesstate") then
            if not targetPlayer then
                outputChatBox("[color=sightgreen][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID]", sourcePlayer)
            else
                targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

                if targetPlayer then
                    local state = getElementData(targetPlayer, "anamesState")
                    if state and state > 0 then
                        outputChatBox("[color=sightgreen][SightMTA - Admin]: [color=hudwhite][color=sightblue]" .. targetName .. "[color=hudwhite] anames állapota [color=sightgreen]bekapcsolva.", sourcePlayer)
                    else
                        outputChatBox("[color=sightgreen][SightMTA - Admin]: [color=hudwhite][color=sightblue]" .. targetName .. "[color=hudwhite] anames állapota [color=sightred]kikapcsolva.", sourcePlayer)
                    end
                end
            end
        end
    end
)

function getPlayerVehicles(charID)
    local vehicles = {}

    for k, v in pairs(getElementsByType("vehicle")) do
        if getElementData(v, "vehicle.owner") == charID then
            table.insert(vehicles, v)
        end
    end
    return vehicles
end

--kesz
addCommandHandler("eco", 
    function(sourcePlayer, commandName, targetPlayer)
        if exports.sPermission:hasPermission(sourcePlayer, "eco") then
            if not targetPlayer then
                outputChatBox("[color=sightgreen][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID]", sourcePlayer)
            else
                targetPlayer, targetCName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

                if targetPlayer then
                    local targetName = getElementData(targetPlayer, "char.name"):gsub("_", " ")
                    local targetMoney = exports.sCore:getMoney(targetPlayer)
                    local targetPP = exports.sCore:getPP(targetPlayer)
                    local targetBankMoney = exports.sCore:getBankMoney(targetPlayer)
                    local targetSSC = exports.sCore:getSSC(targetPlayer)
                    local charID = getElementData(targetPlayer, "char.ID")

                    outputChatBox("[color=sightgreen]============[color=hudwhite][ [color=sightblue]"..targetName.." vagyona [color=hudwhite]][color=sightgreen]============", sourcePlayer, 255, 255, 255, true)
                    outputChatBox("Pénz: [color=sightgreen]"..exports.sGui:thousandsStepper(targetMoney).." $", sourcePlayer, 255, 255, 255, true)
                    outputChatBox("PrémiumPont: [color=sightblue]"..exports.sGui:thousandsStepper(targetPP).." PP[color=hudwhite]", sourcePlayer, 255, 255, 255, true)
                    outputChatBox("Banki egyenleg: [color=sightgreen]"..exports.sGui:thousandsStepper(targetBankMoney).." $", sourcePlayer, 255, 255, 255, true)
                    outputChatBox("SSC: [color=sightyellow]"..exports.sGui:thousandsStepper(targetSSC).." SSC", sourcePlayer, 255, 255, 255, true)

                    local playerVehicles = getPlayerVehicles(charID) or {}

                    outputChatBox("[color=sightgreen]============[color=hudwhite][ [color=sightblue]"..targetName.." járművei [color=hudwhite]][color=sightgreen]============", sourcePlayer, 255, 255, 255, true)

                    for k, v in pairs(playerVehicles) do
                        local vehicleID = getElementData(v, "vehicle.dbID")
                        local model = getElementData(v, "vehicle.customModel") or getElementModel(v)
                        local vehicleRealName = exports.sVehicleNames:getCustomVehicleName(model)
                        outputChatBox(" [color=sightyellow]" .. vehicleRealName .. "[color=hudwhite] (" .. vehicleID .. ")", sourcePlayer)
                    end

                    outputChatBox("[color=hudwhite]Összesen: [color=sightblue]" .. #playerVehicles .. "[color=hudwhite] db jármű.", sourcePlayer)

                    exports.sAnticheat:sendWebhookMessage("**" .. getElementData(sourcePlayer, "visibleName"):gsub("_", " ") .. "** lekérte **" .. targetName .. "** vagyonát.", "astats")

                    local adminName = getElementData(sourcePlayer, "acc.adminNick")
                    local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #fffffflekérte [color=sightgreen]" .. targetName .. " #ffffffvagyonát.")
                end
            end
        end
    end
)
--ebbe beleirni meg hogy lassa az adminchaten melyik volt
addCommandHandler("kick", function(sourcePlayer, commandName, targetPlayer, ...)
    if exports.sPermission:hasPermission(sourcePlayer, "kick") then
        local reason = table.concat({...}, " ")
        if not targetPlayer or not reason then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID] [Indok]", sourcePlayer)
        else
            local targetPlayer, targetCName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

            if targetPlayer then
                local adminName = getElementData(sourcePlayer, "acc.adminNick")
                local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
                local kickedPlayerName = getElementData(targetPlayer, "visibleName"):gsub("_", " ")

                local showName = adminName
                if (getElementData(sourcePlayer, "acc.guardLevel") or 0) > 0 then
                    showName = "Egy RP Őr"
                end

                kickPlayer(targetPlayer, showName, reason)
                triggerClientEvent("kickMsg", sourcePlayer, kickedPlayerName, showName, reason)

                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffkirúgta [color=sightgreen]" .. kickedPlayerName .. " #ffffffjátékost. [color=sightgreen]Indok: #ffffff" .. reason)
            end
        end
    end
end)
-- kesz
addCommandHandler({"gotoxyz", "gotopos", "setpos"}, 
    function(sourcePlayer, commandName, positionX, positionY, positionZ)
        if getElementData(sourcePlayer, "acc.adminLevel") >= 1 then
            if positionX and positionY and positionZ then
                setElementPosition(sourcePlayer, positionX, positionY, positionZ)

                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen elteleportáltál a megadott koordinátára.", sourcePlayer, 255, 255, 255, true)
            else
                outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/"..commandName.." [X] [Y] [Z]", sourcePlayer, 255, 255, 255, true)
            end
        end
    end
)
--kesz
addCommandHandler({"rtc2", "resetvehicle"}, function(sourcePlayer, commandName, givenDistance)
    local despawnDistance = tonumber(givenDistance)
    if not exports.sPermission:hasPermission(sourcePlayer, "rtc") then
        return
    end
    if not despawnDistance then
        outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Távolság (Méter)]", sourcePlayer)
        return
    end

    if despawnDistance < 0 then
        outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A minimális rádiusz [color=sightred]1 [color=hudwhite]méter", sourcePlayer)
        return
    end

    if despawnDistance >= 11 then
        outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A maximális rádiusz [color=sightred]10 [color=hudwhite]méter", sourcePlayer)
        return
    end

    local playerPosition = {getElementPosition(sourcePlayer)}
    local vehicleCount = 0
    for _, vehicleElement in ipairs(getElementsByType("vehicle")) do
        local vehPosition = {getElementPosition(vehicleElement)}
        local checkedDistance = getDistanceBetweenPoints3D(playerPosition[1], playerPosition[2], playerPosition[3], vehPosition[1], vehPosition[2], vehPosition[3])
        if checkedDistance <= despawnDistance and getElementDimension(vehicleElement) == getElementDimension(sourcePlayer) and getElementInterior(vehicleElement) == getElementInterior(sourcePlayer) then
            local groupId = getElementData(vehicleElement, "vehicle.group") or 0
            local jobVehID = getElementData(vehicleElement, "jobVehicleID") or 0

            if groupId == 0 or jobVehID == 0 then
                exports.sImpound:impoundTheVehicle(vehicleElement, true)
            end
            setElementDimension(vehicleElement, 1)
            vehicleCount = vehicleCount + 1
        end
    end

    outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen áthelyeztél [color=sightgreen]"..vehicleCount.." [color=hudwhite]járművet! [Rádiusz: "..despawnDistance.."]", sourcePlayer)

    local adminName = getElementData(sourcePlayer, "acc.adminNick")
    local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffáthelyezett [color=sightgreen]" .. vehicleCount .. " #ffffffjárművet [color=sightgreen]" .. despawnDistance .. "m #ffffffrádiuszon belül.")

end)
----
addCommandHandler("setpaintedtime", function(sourcePlayer, commandName, targetPlayer, paintedTime)
    if exports.sPermission:hasPermission(sourcePlayer, "setpaintedtime") then
        if not paintedTime or not tonumber(paintedTime) or not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Használat]:[color=hudwhite] /"..commandName.." [Játékos Név / ID] [Idő (perc)]", sourcePlayer)
            return
        end
    end

    local adminName = getElementData(sourcePlayer, "acc.adminNick")
    local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
    targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

    if targetPlayer then
        local paintedTime = tonumber(paintedTime)
        local oldTime = getElementData(targetPlayer, "facePaint") or 0

        if paintedTime == 0 then
            setElementData(targetPlayer, "facePaint", false)
            outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite][color=sightgreen]".. adminTitle.." ".. adminName .." [color=hudwhite]átállította az arcfestésed idejét.", targetPlayer)
            outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Átállítottad [color=sightgreen]".. targetName .."[color=hudwhite] arcfestésének idejét. ([color=sightgreen]".. oldTime .." → ".. paintedTime .."[color=hudwhite])", sourcePlayer)
        else
            setElementData(targetPlayer, "facePaint", paintedTime)
            outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite][color=sightgreen]".. adminTitle.." ".. adminName .." [color=hudwhite]átállította az arcfestésed idejét.", targetPlayer)
            outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Átállítottad [color=sightgreen]".. targetName .."[color=hudwhite] arcfestésének idejét. ([color=sightgreen]".. oldTime .." → ".. paintedTime .."[color=hudwhite])", sourcePlayer)
        end

        showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffátállította [color=sightgreen]" .. targetName .. " #ffffffarcfestésének idejét. [color=sightgreen](" .. oldTime .. " → " .. paintedTime .. ")")
    end
end)
--kesz
addCommandHandler("abekot", function(sourcePlayer, commandName, targetPlayer)
    if not exports.sPermission:hasPermission(sourcePlayer, "abekot") then
        return
    end

    if not targetPlayer then
        outputChatBox("[color=sightblue][SightMTA - Használat]:[color=hudwhite] /"..commandName.." [Játékos név / ID]", sourcePlayer)
        return
    end

    targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

    if targetPlayer then
        local vehicle = getPedOccupiedVehicle(targetPlayer)
        if vehicle then
            local adminName = getElementData(sourcePlayer, "acc.adminNick")
            local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
            local isBelted = getElementData(targetPlayer, "seatBelt")

            if isBelted then
                setElementData(targetPlayer, "seatBelt", false)
                outputChatBox("[color=sightgreen][SightMTA - Siker]:[color=hudwhite] Sikeresen kikötötted [color=sightgreen]"..targetName.."[color=hudwhite] övét!", sourcePlayer)
                outputChatBox("[color=sightred][SightMTA]:[color=hudwhite] ".. adminTitle.." ".. adminName .."[color=hudwhite] kikapcsolta az övedet.", targetPlayer)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffkikapcsolta [color=sightgreen]" .. targetName .. " #ffffffbiztonsági övét.")
            else
                setElementData(targetPlayer, "seatBelt", vehicle)
                outputChatBox("[color=sightgreen][SightMTA - Siker]:[color=hudwhite] Sikeresen bekötötted [color=sightgreen]".. targetName.."[color=hudwhite] övét!", sourcePlayer)
                outputChatBox("[color=sightgreen][SightMTA]:[color=hudwhite] ".. adminTitle.." ".. adminName .."[color=hudwhite] bekapcsolta az övedet.", targetPlayer)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffbekapcsolta [color=sightgreen]" .. targetName .. " #ffffffbiztonsági övét.")
            end
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]:[color=hudwhite] A játékos nincs autóban!", sourcePlayer)
        end
    end
end)
--
addCommandHandler("akiszed", function(sourcePlayer, commandName, targetPlayer)
    if not exports.sPermission:hasPermission(sourcePlayer, "akiszed") then
        return
    end

    if not targetPlayer then
        outputChatBox("[color=sightblue][SightMTA - Használat]:[color=hudwhite] /"..commandName.." [Játékos név / ID]", sourcePlayer)
        return
    end

    targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

    if targetPlayer then
        local vehicle = getPedOccupiedVehicle(targetPlayer)
        if vehicle then
            removePedFromVehicle(targetPlayer)

            local adminName = getElementData(sourcePlayer, "acc.adminNick")
            local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)

            outputChatBox("[color=sightgreen][SightMTA - Siker]:[color=hudwhite] Sikeresen kivetted [color=sightgreen]"..targetName.."[color=hudwhite] játékost az autóból!", sourcePlayer)
            outputChatBox("[color=sightred][SightMTA]:[color=hudwhite] ".. adminTitle.." ".. adminName .."[color=hudwhite] kivett téged az autóból.", targetPlayer)
            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffkivette [color=sightgreen]" .. targetName .. " #ffffffjátékost az autóból.")
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]:[color=hudwhite] A kiválasztott játékos nincs autóban!", sourcePlayer)
        end
    end
end)
--
addCommandHandler({"auncuff", "acuff"}, function(sourcePlayer, commandName, targetPlayer)
    if not exports.sPermission:hasPermission(sourcePlayer, "auncuff") then
        return
    end
    if not targetPlayer then
        outputChatBox("[color=sightblue][SightMTA - Használat]:[color=hudwhite] /"..commandName.." [Játékos név / ID]", sourcePlayer)
        return
    end
    targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

    client = getElementData(targetPlayer, "cuffedBy")

    if targetPlayer then
        if isElement(client) then
            local playerCuff = getElementData(targetPlayer, "cuffed") 

            if playerCuff then
                exports.sControls:toggleControl(targetPlayer, {
                    "aim_weapon",
                    "sprint",
                    "fire",
                    "enter_exit",
                    "jump",
                    "crouch",
                    "jog"
                }, true)

                setElementData(targetPlayer, "carryingOther2", false)
                setElementData(client, "carryingOther2", false)

                setElementData(targetPlayer, "cuffedBy", false)

                setElementData(targetPlayer, "carryingOther", false)
                setElementData(client, "carryingOther", false)

                detachElements(client, targetPlayer)
                detachElements(targetPlayer, client)

                local visibleName = getElementData(sourcePlayer, "visibleName"):gsub("_"," ")
                outputChatBox("[color=sightgreen][SightMTA]:[color=sightblue] ".. visibleName .. "" .. "[color=hudwhite] levette rólad a bilincset!", targetPlayer)
                outputChatBox("[color=sightgreen][SightMTA - Siker]:[color=hudwhite] Sikeresen levetted róla a bilincset!", sourcePlayer)

                local adminName = getElementData(sourcePlayer, "acc.adminNick")
                local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] "..adminTitle.." "..adminName.." #fffffflevette [color=sightgreen]"..targetName.." #ffffffbilincsét.")
            else
                exports.sControls:toggleControl(targetPlayer, {
                    "aim_weapon",
                    "sprint",
                    "fire",
                    "enter_exit",
                    "jump",
                    "crouch",
                    "jog"
                }, false)
                setElementData(targetPlayer, "cuffedBy", sourcePlayer)

                outputChatBox("[color=sightgreen][SightMTA - Siker]:[color=hudwhite] Sikeresen megbilincselted!", sourcePlayer)
                local visibleName = getElementData(sourcePlayer, "visibleName"):gsub("_"," ")
                outputChatBox("[color=sightred][SightMTA]:[color=sightblue] ".. visibleName .. "" .. "[color=hudwhite] megbilincselt téged!", targetPlayer)

                local adminName = getElementData(sourcePlayer, "acc.adminNick")
                local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] "..adminTitle.." "..adminName.." #ffffffmegbilincselte [color=sightgreen]"..targetName.."#ffffff játékost.")
            end

            setElementData(targetPlayer, "cuffed", not playerCuff)
        else
            exports.sControls:toggleControl(targetPlayer, {
                "aim_weapon",
                "sprint",
                "fire",
                "enter_exit",
                "jump",
                "crouch",
                "jog"
            }, false)

            setElementData(targetPlayer, "cuffedBy", sourcePlayer)

            outputChatBox("[color=sightgreen][SightMTA - Siker]:[color=hudwhite] Sikeresen megbilincselted!", sourcePlayer)
            local visibleName = getElementData(sourcePlayer, "visibleName"):gsub("_"," ")
            outputChatBox("[color=sightred][SightMTA]:[color=sightblue] ".. visibleName .. "" .. "[color=hudwhite] megbilincselt téged!", targetPlayer)

            setElementData(targetPlayer, "cuffed", true)

            local adminName = getElementData(sourcePlayer, "acc.adminNick")
            local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] "..adminTitle.." "..adminName.." #ffffffmegbilincselte [color=sightgreen]"..targetName.."#ffffff játékost.")
        end
    end
end)
--
addCommandHandler("pm", function(sourcePlayer, commandName, targetPlayer, ...)
    if not exports.sPermission:hasPermission(sourcePlayer, "pm") then
        return
    end
    
    local duty = getElementData(sourcePlayer, "adminDuty")

    if not duty then
        if not exports.sPermission:hasPermission(sourcePlayer, "pmOffDuty") then
            return
        end
    end

    if not (...) then
        outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos név / ID] [Üzenet]", sourcePlayer, 255, 255, 255, true)
    else
        local msg = string.gsub(table.concat({...}, " "), "#%x%x%x%x%x%x", "")

        if not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Használat]:[color=hudwhite] /"..commandName.." [Játékos név / ID] [Üzenet]", sourcePlayer)
            return
        end

        targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

        if targetPlayer then
            local adminNick = getElementData(sourcePlayer, "acc.adminNick")
            local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
            local adminDisplay = adminTitle .. " " .. adminNick

            outputChatBox("[color=sightorange][Küldött üzenet]: " .. adminDisplay .. ": [color=hudwhite]" .. msg, sourcePlayer)
            outputChatBox("[color=sightorange][Fogadott üzenet]: " .. adminDisplay .. ": [color=hudwhite]" .. msg, targetPlayer)

            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminNick .. "[color=hudwhite] üzenetet küldött [color=sightgreen]" .. targetName .. "#ffffff játékosnak. [color=sightgreen]Üzenet: [color=hudwhite]" .. msg)
        end
    end
end)
----
addCommandHandler({"getcarowner", "getvehowner"}, function(sourcePlayer, commandName, vehId)
    if not exports.sPermission:hasPermission(sourcePlayer, "getcarowner") then
        return
    end

    local vehId = tonumber(vehId)

    if not vehId then
        outputChatBox("[color=sightblue][SightMTA - Használat]:[color=hudwhite] /"..commandName.." [Autó ID]", sourcePlayer)
        return
    end

    dbQuery(function(qh, sourcePlayer)
        local result = dbPoll(qh, 0)[1]
        if result then
            local name = result.name:gsub("_", " ")
            outputChatBox("[color=sightgreen][SightMTA - Siker]:[color=hudwhite] A kiválasztott jármű tulajdonosa: [color=sightgreen]"..name.."[color=hudwhite].", sourcePlayer)
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]:[color=hudwhite] A kiválasztott jármű nem található.", sourcePlayer)
        end
    end, {sourcePlayer}, connection, "SELECT vehicles.characterId, characters.name FROM vehicles INNER JOIN characters ON vehicles.characterId = characters.characterId WHERE vehicles.dbID = ?", vehId)
end)
----
addCommandHandler("changelock2", function(sourcePlayer, commandName)
    if not exports.sPermission:hasPermission(sourcePlayer, "changelock2") then
        return
    end

    local vehicle = getPedOccupiedVehicle(sourcePlayer)
    if not vehicle then
        outputChatBox("[color=sightred][SightMTA - Hiba]:[color=hudwhite] Parancs használatához autóban kell ülnöd.", sourcePlayer)
        return
    end

    local vehicleID = tonumber(getElementData(vehicle, "vehicle.dbID"))
    if not vehicleID then 
        return
    end

    exports.sItems:giveItem(sourcePlayer, 1, 1, false, vehicleID)
    outputChatBox("[color=sightgreen][SightMTA - Siker]:[color=hudwhite] A kiválasztott járműhöz sikeresen másoltál egy kulcsot!", sourcePlayer)

    local adminName = getElementData(sourcePlayer, "acc.adminNick")
    local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffkulcsot másolt a(z) [color=sightgreen]" .. vehicleID .. " [color=hudwhite]azonosítójú járműhöz.")
end)

----
addCommandHandler({"setvehicleowner", "setvehowner"}, function(sourcePlayer, commandName, targetPlayer, vehId)
    if not exports.sPermission:hasPermission(sourcePlayer, "setvehicleowner") then
        return
    end
    
    local vehId = tonumber(vehId)

    if targetPlayer then
        targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
    end

    if not vehId or not isElement(targetPlayer) then
        outputChatBox("[color=sightblue][SightMTA - Használat]:[color=hudwhite] /"..commandName.." [Játékos Név /ID] [Autó ID]", sourcePlayer)
        return
    end

    local vehicle = findVehicle(sourcePlayer, vehId)
    local charID = tonumber(getElementData(targetPlayer, "char.ID"))
    local ownerCharId = getElementData(vehicle, "vehicle.owner") or 0
    local oldOwner = exports.sCore:findPlayerByCharId(ownerCharId)
    local oldOwnerName = oldOwner and getElementData(oldOwner,"visibleName"):gsub("_", " ") or "Ismeretlen"
    local newOwner = targetName

    dbExec(connection, "UPDATE vehicles SET characterId = ? WHERE dbID = ?", charID, vehId)
    setElementData(vehicle, "vehicle.owner", charID)
    outputChatBox("[color=sightgreen][SightMTA - Siker]:[color=hudwhite] A kiválasztott járművet sikeresen átírtad[color=sightgreen] ("..oldOwnerName.." → "..newOwner..") ", sourcePlayer)

    local adminName = getElementData(sourcePlayer, "acc.adminNick")
    local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffátírta a(z) [color=sightgreen]" .. vehId .. " [color=hudwhite] azonosítójú járművet [color=sightgreen](" .. oldOwnerName .. " #ffffff→ [color=sightgreen]" .. newOwner .. ")")
end)


function getPlayerMobile(player)
    local currentNum = false
    local items = exports.sItems:getElementItems(player)
    for k, v in pairs(items) do
        if v.itemId == 9 then
            currentNum = v.data1
        end
    end
    return currentNum
end

addCommandHandler("connectdiscord", function(sourcePlayer, commandName, accountId, playerDiscordId, playerDiscordName)
    if exports.sPermission:hasPermission(sourcePlayer, "connectdiscord") then
        if not (accountId or tonumber(accountId)) or not (playerDiscordId or tonumber(playerDiscordId)) or not playerDiscordName then
            outputChatBox("[color=sightblue][SightMTA - Discord]: [color=hudwhite]/"..commandName.." [AccountID] [Discord ID] [Discord Név]", sourcePlayer)
            return
        end

        local playerDiscordId = tonumber(playerDiscordId)
        local accountID = tonumber(accountId)


        local query = [[
            UPDATE accounts
            SET
            discordId = ?, discordName = ?
            WHERE
            accountId = ?
        ]]

        dbExec(connection, query, playerDiscordId, playerDiscordName, accountID)
        outputChatBox("[color=sightgreen][SightMTA - Hitelesítés]: [color=hudwhite]Sikeresen csatlakoztattad a kiválasztott játékos discordját!", sourcePlayer)
        outputChatBox("[color=sightgreen][SightMTA - Hitelesítés]: [color=hudwhite]Egy adminisztrátor csatlakoztatta a discord fiókod!", targetPlayer)
    end
end)
