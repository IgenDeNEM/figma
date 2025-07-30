local connection = false
local playerInteriors = {}

addEventHandler("onResourceStart", resourceRoot, function(res)
    local resName = getResourceName(res)

    for playerIdentity, playerElement in ipairs(getElementsByType("player")) do
        local interiorTable = exports.sInteriors:getPlayerInteriors(playerElement)
        local rentables = exports.sPaintshop:requestPlayerRentedGarages(getElementData(playerElement, "char.ID"))
        --local mines = exports.sMining:getPlayerMines(getElementData(playerElement, "char.ID"))
        local mines = {}

        for k, v in pairs(rentables) do
            table.insert(interiorTable, v)
        end
        
        for k, v in pairs(mines) do
            table.insert(interiorTable, v)
        end

        playerInteriors[playerElement] = {}
        if interiorTable then
            for k, v in ipairs(interiorTable) do
                if v.owner == getElementData(playerElement, "char.ID") then
                    local tableDatas = {
                        name = v.name,
                        interiorId = k,
                        type = v.type,
                        id = v.gameInterior,
                        editable = v.dummy or "N",
                        report = 2,
                        locked = v.locked,
                        outside = v.outside,
                        expire = v.rentTime,
                        pos = v.outside,
                    }
                    table.insert(playerInteriors[playerElement], k, tableDatas)
                end
            end
        end
        local playerElement = playerElement
        setTimer(function()
            triggerClientEvent(playerElement, "gotInteriorLimitForDashboard", playerElement, getElementData(playerElement, "char.interiorsSlot"))
            triggerClientEvent(playerElement, "gotInteriorList", playerElement, interiorTable)
        end, 50, 1)
    end

    if res == getThisResource() then
        connection = exports.sConnection:getConnection()
    elseif resName == "sConnection" then
        connection = exports.sConnection:getConnection()
    end
end)

--[[
    editable = "N",
    inside = { 0, 0, 0, 0, 4165, 0 },
    locked = false,
    name = "PLACEHOLDER",
    outside = { 2429.0439453125, -2482.7109375, 13.631611824036, 0, 0, 254.57083129883 },
    owner = 2,
    ownerType = "player",
    price = 1,
    reportTime = 1748382037,
    type = "garage",
    zone = "Ocean Docks"]]


addEvent("requestInteriorsForDashboard", true)
addEventHandler("requestInteriorsForDashboard", getRootElement(), function()
    local interiorTable = exports.sInteriors:getPlayerInteriors(client)
    if client then
        playerInteriors[client] = {}
        if playerInteriors[client] then
            local playerElement = client
            triggerClientEvent(client, "gotInteriorLimitForDashboard", client, getElementData(client, "char.interiorsSlot"))
            local rentables = exports.sPaintshop:requestPlayerRentedGarages(getElementData(client, "char.ID"))
            --local mines = exports.sMining:getPlayerMines(getElementData(client, "char.ID"))
            local mines = {}
            for k, v in pairs(rentables) do
                table.insert(interiorTable, v)
            end
            
            for k, v in pairs(mines) do
                table.insert(interiorTable, v)
            end
            triggerClientEvent(client, "gotInteriorList", client, interiorTable)
        else
            if interiorTable then
                for k, v in ipairs(interiorTable) do
                    if v.owner == getElementData(client, "char.ID") then
                        local tableDatas = {
                            name = v.name,
                            interiorId = k,
                            type = v.type,
                            id = v.gameInterior,
                            editable = v.dummy or "N",
                            report = 2,
                            locked = v.locked,
                            outside = v.outside,
                            expire = v.rentTime,
                            pos = v.outside,
                        }
                        table.insert(playerInteriors[client], k, tableDatas)
                    end
                end
            end
            triggerClientEvent(client, "gotInteriorLimitForDashboard", client, getElementData(client, "char.interiorsSlot"))
            
            local rentables = exports.sPaintshop:requestPlayerRentedGarages(getElementData(client, "char.ID"))
            --local mines = exports.sMining:getPlayerMines(getElementData(client, "char.ID"))
            local mines = {}
            for k, v in pairs(rentables) do
                table.insert(interiorTable, v)
            end
            
            for k, v in pairs(mines) do
                table.insert(interiorTable, v)
            end
            triggerClientEvent(client, "gotInteriorList", client, interiorTable)
        end
    end
end)

addEvent("buyInteriorSlot", true)
addEventHandler("buyInteriorSlot", getRootElement(), function(slotAmount)
    if client == source then
        if slotAmount > 0 then
            if exports.sCore:takePP(client, slotAmount * 100) then
                local newAmount = (getElementData(client, "char.interiorsSlot") or 0) + slotAmount
                setElementData(client, "char.interiorsSlot", newAmount)
                dbExec(connection, "UPDATE characters SET interiorsSlot = ? WHERE characterId = ?", newAmount, getElementData(client, "char.ID"))

                triggerClientEvent(client, "gotInteriorLimitForDashboard", client, newAmount)
                exports.sGui:showInfobox(client, "s", "Sikeres vásárlás!")
            else
                exports.sGui:showInfobox(client, "e", "Nincs elég PrémiumPontod!")
            end
        end
    end
end)

addCommandHandler("addinteriorlimit", function(sourcePlayer, commandName, targetPlayer, limitAmount)
    if exports.sPermission:hasPermission(sourcePlayer, "addinteriorlimit") then
        if not targetPlayer or not tonumber(limitAmount) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/"..commandName.." [Játékos Név / ID] [Mennyiség]", sourcePlayer)
            return
        end

        local limitAmount = tonumber(limitAmount)
        local targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
        local newAmount = (getElementData(targetPlayer, "char.interiorsSlot") or 0) + limitAmount

        if targetPlayer and isElement(targetPlayer) then
            setElementData(targetPlayer, "char.interiorsSlot", newAmount)

            dbExec(connection, "UPDATE characters SET interiorsSlot = ? WHERE characterId = ?", newAmount, getElementData(targetPlayer, "char.ID"))

            triggerClientEvent(targetPlayer, "gotInteriorLimitForDashboard", targetPlayer, newAmount)

            local adminRank = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
            local adminName = adminRank .. " " .. getElementData(sourcePlayer, "acc.adminNick")

            local oldAmount = newAmount - limitAmount

            outputChatBox("[color=sightgreen][SightMTA - Slot]: [color=hudwhite]Sikeresen megváltoztattad [color=sightgreen]"..targetName.." [color=hudwhite]interiorjai a maximális számát! ("..oldAmount.." > "..limitAmount..")", sourcePlayer)
            outputChatBox("[color=sightgreen][SightMTA - Slot]: [color=hudwhite]"..adminName.."[color=hudwhite] hozzáadott a maximális interiorjaid számaihoz! [color=sightgreen]("..oldAmount.." > "..newAmount..")", targetPlayer)
        end
    end
end)

addCommandHandler("setinteriorlimit", function(sourcePlayer, commandName, targetPlayer, limitAmount)
    if exports.sPermission:hasPermission(sourcePlayer, "setinteriorlimit") then
        if not targetPlayer or not tonumber(limitAmount) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/"..commandName.." [Játékos Név / ID] [Mennyiség]", sourcePlayer)
            return
        end

        local limitAmount = tonumber(limitAmount)
        local targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
        local oldAmount = (getElementData(targetPlayer, "char.interiorsSlot") or 0)

        if targetPlayer and isElement(targetPlayer) then
            setElementData(targetPlayer, "char.interiorsSlot", limitAmount)

            dbExec(connection, "UPDATE characters SET interiorsSlot = ? WHERE characterId = ?", limitAmount, getElementData(sourcePlayer, "char.ID"))

            triggerClientEvent(targetPlayer, "gotInteriorLimitForDashboard", targetPlayer, limitAmount)

            local adminRank = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
            local adminName = adminRank .. " " .. getElementData(sourcePlayer, "acc.adminNick")

            outputChatBox("[color=sightgreen][SightMTA - Slot]: [color=hudwhite]Sikeresen megváltoztattad [color=sightgreen]"..targetName.." [color=hudwhite]interiorjai a maximális számát! ("..oldAmount.." > "..limitAmount..")", sourcePlayer)
            outputChatBox("[color=sightgreen][SightMTA - Slot]: [color=hudwhite]"..adminName.."[color=hudwhite] megváltoztatta a maximális interiorjaid számait! [color=sightgreen]("..oldAmount.." > "..limitAmount..")", targetPlayer)
        end
    end
end)