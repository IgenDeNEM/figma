addEvent("requestFishingEvent", true)

local playerSyncers = {}
local playerFishingDatas = {}
local fishWaitTimers = {}
local fishGetOutStart = {}
local dropoffCols = {}
local dropoffSells = {}
local fishSelling = {}
local playerHasBait = {}
local fishGetAwayTimers = {}

function fishWaitTimer(client)
    fishWaitTimers[client] = nil

    local fish = chooseRandomFish()
    local weight = fishTypes[fish].weight

    if type(weight) == "table" then
        weight = math.random(weight[1] * 10, weight[2] * 10) / 10
    end
    
    updatePlayerFishingData(client, "fish", fish)
    updatePlayerFishingData(client, "fishWeight", weight)
    updatePlayerFishingData(client, "mode", "catching", true)

    fishGetOutStart[client] = getTickCount()
    playerHasBait[client] = false
end

function getPlayerFishingDatas(player)
    return playerFishingDatas[player]
end

function getPlayerFishingData(player, data)
    return playerFishingDatas[player] and playerFishingDatas[player][data]
end

function updatePlayerFishingData(client, data, value, multi)
    if not playerFishingDatas[client] then
        playerFishingDatas[client] = {}
    end

    playerFishingDatas[client][data] = value

    if data == "mode" then
        if value == "waiting" and not multi and playerHasBait[client] then
            local timer = 10000
            fishWaitTimers[client] = setTimer(fishWaitTimer, timer, 1, client)
        elseif value == "idle" then
            if playerFishingDatas[client].fish then
                local fish = playerFishingDatas[client].fish

                if fishTypes[fish].item then
                    local weight = playerFishingDatas[client].fishWeight
                    local start = fishGetOutStart[client]
                    if start then
                    
                        triggerClientEvent(client, "gotFishWin", client, fish, weight, (getTickCount() - start) / 1000, exports.sItems:getItemName(614 + getElementData(client, "usingFishingRod")))

                        exports.sItems:giveItem(client, fishTypes[fish].item, 1, false, weight)

                        exports.sGui:showInfobox(client, "s", "Kifogtál egy " .. fishTypes[fish].nameEx .. "!")
                        exports.sGui:showInfobox(client, "i", "Súly: " .. weight .. " kg, hossz: " .. calculateFishLength(fish, weight) .. " cm")
                    end
                end
                
                fishGetOutStart[client] = nil
            end
        elseif value == "catching" then
            if not fishGetAwayTimers[client] then
                fishGetAwayTimers[client] = setTimer(fishGetAwayTimer, 5000, 1, client)
            end
        elseif value == "catched" then
            if isTimer(fishGetAwayTimers[client]) then
                killTimer(fishGetAwayTimers[client])
            end
            fishGetAwayTimers[client] = nil
        elseif value == "throw" then

            local bait = exports.sItems:hasItem(client, 630)

            if not isElementWithinColShape(client, deniedCollision) then
                if not playerHasBait[client] then
                    if bait then
                        if bait.data1 and bait.data1 == 19 then
                            exports.sChat:localAction(client, "horogra tűzött egy csalit, majd eldobta az üres dobozt.")
                        else
                            exports.sChat:localAction(client, "horogra tűzött egy csalit.")
                        end
                        exports.sItems:addItemDose(client, bait.dbID)
                        
                        playerHasBait[client] = true
                    else
                        exports.sGui:showInfobox(client, "w", "Nincs nálad csali!")
                    end
                end
            else
                updatePlayerFishingData(client, "mode", "idle", true)
                exports.sGui:showInfobox(client, "e", "Ebben a tóban nincs hal!")
            end 
        else
            if isTimer(fishWaitTimers[client]) then
                killTimer(fishWaitTimers[client])
            end
            fishWaitTimers[client] = nil
        end
    end
    
    if multi then
        triggerClientEvent(client, "syncMultiFishingData", client, playerFishingDatas[client])
    else
        triggerClientEvent(playerSyncers[client], "syncFishingData", client, data, value)
    end
end

function fishGetAwayTimer(client)
    if fishGetOutStart[client] then
        exports.sGui:showInfobox(client, "w", "Elúszott a hal, és elvitte a csalit!")
        playerHasBait[client] = false
        fishGetOutStart[client] = false
        fishGetAwayTimers[client] = false
        updatePlayerFishingData(client, "mode", "waiting", true)
    end
end

function removePlayerBait(client)
    playerHasBait[client] = false
end

function chooseRandomFish()
	local selectedWeight = math.random(1, chanceSum)
	local iteratedWeight = 0

	for k, v in pairs(chances) do
		iteratedWeight = iteratedWeight + v

		if selectedWeight <= iteratedWeight then
			return k
		end
	end

	return false
end

function isPlayerStandingInDropOffCol(client)
    local dropoffCol = false

    for col, i in pairs(dropoffCols) do
        local within = isElementWithinColShape(client, col)

        if within then
            dropoffCol = i

            break
        end
    end

    return dropoffCol
end

addEvent("refreshPlayerFishingSyncers", true)
addEventHandler("refreshPlayerFishingSyncers", getRootElement(), function(players)
    if source == client then
        playerSyncers[client] = players
    else
        exports.sAnticheat:anticheatBan(client, "AC #19 - sFishing @sourceS:164")
    end
end)

addEvent("addPlayerFishingSyncer", true)
addEventHandler("addPlayerFishingSyncer", getRootElement(), function(player)
    if source == client then
        if not playerSyncers[source] then
            playerSyncers[source] = {}
        end

        table.remove(playerSyncers[source], player)
    else
        exports.sAnticheat:anticheatBan(client, "AC #18 - sFishing @sourceS:177")
    end
end)

addEvent("removedPlayerFishingSyncer", true)
addEventHandler("removedPlayerFishingSyncer", getRootElement(), function()
    if playerSyncers[source] then
        for i = 1, #playerSyncers[source] do
            if playerSyncers[source][i] == source then
                table.remove(playerSyncers[source], i)
                break
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #18 - sFishing @sourceS:177")
    end
end)

addEvent("syncFishingData", true)
addEventHandler("syncFishingData", getRootElement(), function(data, value)
    if source == client then
        updatePlayerFishingData(client, data, value)
    else
        exports.sAnticheat:anticheatBan(client, "AC #16 - sFishing @sourceS:202")
    end
end)

addEventHandler("onElementDataChange", getRootElement(), function(data, old, new)
    if data == "usingFishingRod" and not new then
        playerFishingDatas[source] = nil
    end
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
    playerSyncers[source] = nil
    playerFishingDatas[source] = nil

    if isTimer(fishWaitTimers[source]) then
        killTimer(fishWaitTimers[source])
    end
    fishWaitTimers[source] = nil
    
    fishGetOutStart[source] = nil

    for dropoffCol = 1, #dropoffSells do
        local client, fish, weight, itemData = unpack(dropoffSells[dropoffCol])

        if source == client then
            triggerClientEvent(getRootElement(), "refreshFishStand", source, dropoffCol, false, false)
        end
    end
    
    fishSelling[source] = nil
    playerHasBait[source] = nil

    if isTimer(fishGetAwayTimers[source]) then
        killTimer(fishGetAwayTimers[source])
    end
    fishGetAwayTimers[source] = nil
end)

addEvent("requestFishStand", true)
addEventHandler("requestFishStand", getRootElement(), function()

end)

addEventHandler("onColShapeHit", getRootElement(), function(he, md)
    if dropoffCols[source] and md then
        if getElementType(he) == "player" then
            exports.sGui:showInfobox(he, "i", "A hal eladásához kattints rá jobb klikkel az inventoryban.")
        end
    end
end)

addEvent("sellFishItemUse", true)
addEventHandler("sellFishItemUse", getRootElement(), function(itemData)
    local dropoffCol = exports.sFishing:isPlayerStandingInDropOffCol(source)

    if dropoffCol then
        local fish = false
        local weight = tonumber(itemData.data1)

        for k, v in pairs(fishTypes) do
            if v.item == itemData.itemId then
                fish = k

                break
            end
        end

        if fish and weight and not dropoffSells[dropoffCol] then
            dropoffSells[dropoffCol] = {source, fish, weight, itemData}

            triggerClientEvent(getRootElement(), "refreshFishStand", source, dropoffCol, fish, weight)
        end
    end
end)

addEvent("startFishSelling", true)
addEventHandler("startFishSelling", getRootElement(), function()
    if client == source then
        fishSelling[client] = true
    else
        exports.sAnticheat:anticheatBan(client, "AC #15 - sFishing @sourceS:282")
    end
end)

addEvent("closeFishSelling", true)
addEventHandler("closeFishSelling", getRootElement(), function(slider)
    if client == source then
        for dropoffCol = 1, #dropoffPoses do
            if dropoffSells[dropoffCol] then
                local source, fish, weight, itemData = unpack(dropoffSells[dropoffCol])

                if source == client then
                    if fishSelling[client] and slider and slider > 0 then
                        if slider >= 0 or slider <= 1 then
                            local fishType = fishTypes[fish]
                            
                            if fishType then
                                local sellingPriceFrom = math.floor(fishType.price * weight * 0.7)
                                local sellingPriceTo = math.floor(fishType.price * weight * 1)
                                local price = math.floor(sellingPriceFrom + (sellingPriceTo - sellingPriceFrom) * slider)

                                if exports.sItems:takeItem(client, "dbID", itemData.dbID) then
                                    exports.sCore:giveMoney(client, price)

                                    outputChatBox("[color=sightblue][SightMTA - Horgászat]: [color=hudwhite]Eladtál egy " .. fishTypes[fish].nameEx .. ".", client)
                                    outputChatBox("[color=sightblue][SightMTA - Horgászat]: [color=hudwhite]Súly: [color=sightblue]" .. itemData.data1 .. " kg[color=hudwhite], hossz: [color=sightblue]" .. calculateFishLength(fish, itemData.data1) .. "cm", client)
                                    outputChatBox("[color=sightblue][SightMTA - Horgászat]: [color=hudwhite]Eladási ár: [color=sightgreen]" .. thousandsStepper(price) .. " $", client)
                                end
                            end   
                        else
                            exports.sAnticheat:anticheatBan(client, "AC #12 - sFishing @sourceS:312")
                        end
                    end

                    fishSelling[client] = nil
                    dropoffSells[dropoffCol] = nil

                    triggerClientEvent(getRootElement(), "refreshFishStand", source, dropoffCol, false, false)
                end
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #14 - sFishing @sourceS:324")
    end
end)

local collisionDatas = {
    --// * Közép
    -2427.7585449219, -270.69564819336,
    --// * Szélei
    -2541.6013183594, -344.88174438477,
    -2525.078125, -241.24931335449,
    -2357.1076660156, -207.74516296387,
    -2353.6691894531, -286.61682128906,
}

addEventHandler("onResourceStart", getRootElement(), function(res)
    if res == getThisResource() then
        for i = 1, #dropoffPoses do
            local x, y, z, r = unpack(dropoffPoses[i])
            local rad = math.rad(r)
            local cos = math.cos(rad)
            local sin = math.sin(rad)
            local col = createColSphere(x + cos * 5 - sin * 2, y + sin * 7 + cos * 2, z + 0.925, 2)
            dropoffCols[col] = i
        end

        if collisionDatas then
            deniedCollision = createColPolygon(collisionDatas[1], collisionDatas[2], collisionDatas[3], collisionDatas[4], collisionDatas[5], collisionDatas[6], collisionDatas[7], collisionDatas[8], collisionDatas[9], collisionDatas[10])
        end
    else
        local resName = getResourceName(res)


    end
end)

addEvent("damageFishingLine", true)
addEventHandler("damageFishingLine", getRootElement(), function(rodDbID, tear)
    if source == client then
        updatePlayerFishingData(client, "mode", "idle", true)
    else
        exports.sAnticheat:anticheatBan(client, "AC #13 - sFishing @sourceS:364")
    end
end)

function thousandsStepper(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1 %2")
        if k == 0 then
            break
        end
    end
    return formatted
end