colShapeTables = {}
rouletteTableGroups = {}

local casinoZones = {}
local rouletteTableGroups = {}
local playersAtTables = {}

local usedRouletteMafias = {}


addEventHandler("onResourceStart", resourceRoot, function(res)
    if res == getThisResource() then
        for _, v in pairs(syncZoneCoords) do
            local startX, startY = v[1], v[2]
            local width, height = v[3], v[4]
            local interior = v[5]
            local dimension = v[6]
            local zoneName = v[7]
            
            local col = createColRectangle(startX, startY, width, height)
            setElementInterior(col, interior)
            setElementDimension(col, dimension)
            
            setElementData(col, "diceDimension", dimension)
            setElementData(col, "diceInterior", interior)
            
            casinoZones[dimension] = {
                col    = col,
                name   = zoneName,
                int = interior,
                players= {},
            }
            
            colShapeTables[dimension] = {}
        end

        for diceID, coords in pairs(rouletteTableCoords) do
            local mx, my, mz, mrz, mint, mdim = coords[1], coords[2], coords[3], coords[4], coords[5], coords[6]
            
            for _, zone in pairs(syncZoneCoords) do
                local zx, zy = zone[1], zone[2]
                local zw, zh = zone[3], zone[4]
                local zint, zdim = zone[5], zone[6]
                
                if zint == mint and zdim == mdim then
                    if (mx >= zx and mx <= zx + zw) and (my >= zy and my <= zy + zh) then
                        colShapeTables[zdim][diceID] = true
                    end
                end
            end
        end

        for k, v in pairs(rouletteTableCoords) do
            rouletteTableGroups[k] = {
                data = {
                    players = {}
                },
                spin = false,
                slow = false,
                bounce = false,
                n = false,
                cd = false,
                history = {},
                bets = {}
            }
        end
    end
end)

addEvent("requestRouletteMachine", true)
addEventHandler("requestRouletteMachine", root, function()
    local thePlayer = client
    local dim = getElementDimension(thePlayer)
    
    if colShapeTables[dim] then
        local rouletteToSend = {}
        for rouletteIdentity, _ in pairs(colShapeTables[dim]) do
            if rouletteTableGroups[rouletteIdentity] then
                rouletteToSend[rouletteIdentity] = rouletteTableGroups[rouletteIdentity]
            end
        end
        if next(rouletteToSend) then
            for rouletteIdentity, rouletteData in pairs(rouletteToSend) do
                triggerLatentClientEvent(thePlayer, "streamInRoulette", thePlayer, rouletteIdentity, rouletteData.data, rouletteData.spin, rouletteData.slow, rouletteData.bounce, rouletteData.n, rouletteData.cd and (getRealTime().timestamp - rouletteData.cd) * 1000, rouletteData.history)
            end
        end
    end
end)

addEventHandler("onElementDimensionChange", root, function(oldDimension, newDimension)
    if getElementType(source) ~= "player" then
        return
    end
    
    local player = source

    for colDimension, colData in pairs(casinoZones) do
        if isElementWithinColShape(player, colData.col) then
            if newDimension == colDimension then
                local rouletteToSend = {}
                if colShapeTables[colDimension] then
                    for diceID, _ in pairs(colShapeTables[colDimension]) do
                        if rouletteTableGroups[diceID] then
                            rouletteToSend[diceID] = rouletteTableGroups[diceID]
                        end
                    end
                end
                if next(rouletteToSend) then
                    for rouletteIdentity, rouletteData in pairs(rouletteToSend) do
                        triggerLatentClientEvent(player, "streamInRoulette", player, rouletteIdentity, rouletteData.data, rouletteData.spin, rouletteData.slow, rouletteData.bounce, rouletteData.n, rouletteData.cd and (getRealTime().timestamp - rouletteData.cd) * 1000, rouletteData.history)
                    end
                end
            else
                triggerClientEvent(player, "streamOutRoulettes", player)
            end
        end
    end
end)

addEvent("tryToSitDownRoulette", true)
addEventHandler("tryToSitDownRoulette", root,
    function (tableId, seatId)
        local tableData = rouletteTableGroups[tableId]

        if tableData then
            local casinoZone = casinoZones[getElementDimension(client)]

            tableData.data.players[seatId] = client
            tableData.bets[seatId] = {}

            playersAtTables[client] = {
                tableId = tableId,
                seatId = seatId
            }

            triggerClientEvent("gotRoulettePlayer", client, tableId, seatId, client)
        end
    end
)

addEvent("tryToExitRoulette", true)
addEventHandler("tryToExitRoulette", root,
    function ()
        local playerData = playersAtTables[client]

        if playerData then
            local tableData = rouletteTableGroups[playerData.tableId]

            if tableData then
                local casinoZone = casinoZones[getElementDimension(client)]
                
                triggerClientEvent("gotRoulettePlayer", client, playerData.tableId, playerData.seatId, false)
                
                tableData.data.players[playerData.seatId] = nil
                playersAtTables[client] = nil
            end
        end
    end
)

addCommandHandler("getmyroulette", 
    function(sourcePlayer, cmdName)
        if playersAtTables[sourcePlayer] then
            outputChatBox("Table: "..playersAtTables[sourcePlayer].tableId.." || Seat: "..playersAtTables[sourcePlayer].seatId, sourcePlayer, 255, 255, 255, true)
        end
    end
)

addCommandHandler("roulettemaffia", 
    function(sourcePlayer, cmdName, tableId, number)
        if not tableId or not number then
            outputChatBox("[color=sightgreen][SightMTA - RouletteMaffia]: [color=hudwhite]/"..cmdName.." [Asztal ID] [Nyerőszám]", sourcePlayer, 255, 255, 255, true)
            return
        end

        if not usedRouletteMafias[tonumber(tableId)] then
            usedRouletteMafias[tonumber(tableId)] = {}
        end

        if number ~= "random" then
            for k, v in ipairs(rouletteWheelNums) do
                if v == tonumber(number) then
                    outputChatBox("[color=sightgreen][SightMTA - RouletteMaffia]: [color=hudwhite]Roulette Maffia bekapcsolva, nyerőszám: "..number, sourcePlayer, 255, 255, 255, true)
                    usedRouletteMafias[tonumber(tableId)].win = k - 1
                end
            end
        else
            usedRouletteMafias[tonumber(tableId)].win = false
        end
    end
)

addEvent("tryToAddRouletteBet", true)
addEventHandler("tryToAddRouletteBet", root,
    function (betType, amount)
        local playerData = playersAtTables[client]

        if playerData then
            local tableData = rouletteTableGroups[playerData.tableId]

            if tableData then
                local casinoZone = casinoZones[getElementDimension(client)]

                if betType == "tier" or betType == "orphelins" or betType == "voisins" or betType == "zero" then
                    for i = 1, _G[betType .. "Amount"] do
                        local betName = _G[betType .. "Bets"][i]

                        if amount < 0 then
                            if not tableData.bets[playerData.seatId][betName] then
                                return
                            elseif tableData.bets[playerData.seatId][betName] < amount then
                                return
                            end
                        end

                        if betName then
                            if tableData.bets[playerData.seatId][betName] then                    
                                tableData.bets[playerData.seatId][betName] = tableData.bets[playerData.seatId][betName] + amount
                            else
                                tableData.bets[playerData.seatId][betName] = amount
                            end
                            
                            if tableData.bets[playerData.seatId][betName] <= 0 then
                                tableData.bets[playerData.seatId][betName] = nil
                            end
    
                            exports.sCore:setSSC(client, exports.sCore:getSSC(client) - amount)

                            triggerClientEvent("gotNewRouletteBet", client, playerData.tableId, playerData.seatId, betName, tableData.bets[playerData.seatId][betName], i ~= 1 and true)
                        end

                    end
                elseif string.sub(betType, 1, 1) == "n" then
                    local n = validBets[betType][2]

                    for i = 1, 3 do
                        local betName = i == 1 and neighbours[n][1] or i == 2 and n or neighbours[n][3]

                        if amount < 0 then
                            if not tableData.bets[playerData.seatId][betName] then
                                return
                            end
                        end
    
                        if tableData.bets[playerData.seatId][betName] then                    
                            tableData.bets[playerData.seatId][betName] = tableData.bets[playerData.seatId][betName] + amount
                        else 
                            tableData.bets[playerData.seatId][betName] = amount
                        end
    
                        if tableData.bets[playerData.seatId][betName] <= 0 then
                            tableData.bets[playerData.seatId][betName] = nil
                        end

                        exports.sCore:setSSC(client, exports.sCore:getSSC(client) - amount)
    
                        triggerClientEvent("gotNewRouletteBet", client, playerData.tableId, playerData.seatId, betName, tableData.bets[playerData.seatId][betName], false)    
                    end
                else
                    if amount < 0 then
                        if not tableData.bets[playerData.seatId][betType] then
                            return
                        end
                    end

                    if tableData.bets[playerData.seatId][betType] then                    
                        tableData.bets[playerData.seatId][betType] = tableData.bets[playerData.seatId][betType] + amount
                    else 
                        tableData.bets[playerData.seatId][betType] = amount
                    end

                    if tableData.bets[playerData.seatId][betType] <= 0 then
                        tableData.bets[playerData.seatId][betType] = nil
                    end

                    exports.sCore:setSSC(client, exports.sCore:getSSC(client) - amount)

                    triggerClientEvent("gotNewRouletteBet", client, playerData.tableId, playerData.seatId, betType, tableData.bets[playerData.seatId][betType], false)
                end

                triggerClientEvent(client, "refreshSSC", client, exports.sCore:getSSC(client))

                if not tableData.cd then
                    tableData.cd = getRealTime().timestamp
                    tableData.cdTimer = setTimer(spinUpBall, 65000, 1, playerData.tableId)
                end
            end
        end
    end
)

function spinUpBall(tableId)
    local tableData = rouletteTableGroups[tableId]

    if tableData then
        local slowDown = math.random(5000, 10000)

        setTimer(slowDownBall, slowDown, 1, tableId)

        triggerClientEvent("rouletteSpinUpBall", root, tableId)
    end
end

function slowDownBall(tableId)
    local tableData = rouletteTableGroups[tableId]

    if tableData then
        local bounce = math.random(5000, 10000)

        setTimer(bounceBall, bounce, 1, tableId)

        triggerClientEvent("rouletteSlowDownBall", root, tableId)
    end
end

function bounceBall(tableId)
    local tableData = rouletteTableGroups[tableId]

    if tableData then
        math.randomseed(getTickCount())
        
        local winNum = math.random(0, 36)

        --[[if usedRouletteMafias[tableId].win ~= false then
            winNum = usedRouletteMafias[tableId].win
        end--]]

        local bounces = math.random(1, 4)
        local winNumEx = rouletteWheelNums[winNum + 1]

        local winnerBetsEx = {}

        for i = 1, #winnerBets[winNumEx] do
            winnerBetsEx[winnerBets[winNumEx][i]] = true
        end

        local bets = {}
        local wins = {}
        local winAmounts = {}
        local tablePlayers = tableData.data.players

        for k, v in pairs(tableData.bets) do
            bets[k] = 0
            winAmounts[k] = 0

            for bet, value in pairs(v) do
                bets[k] = bets[k] + 1

                if winnerBetsEx[bet] then
                    if not wins[k] then
                        wins[k] = 0
                    end

                    wins[k] = wins[k] + 1
                    winAmounts[k] = winAmounts[k] + value * (1 + payoutsForBets[bet])
                end
            end
        end

        setTimer(newRound, 20000, 1, tableId, winNum, winAmounts, tablePlayers)

        triggerClientEvent("rouletteBounceTheBall", resourceRoot, tableId, winNum, bounces, wins, bets)
    end
end

function newRound(tableId, winNum, winAmounts, tablePlayers)
    local tableData = rouletteTableGroups[tableId]

    if tableData then
        tableData.spin = false
        tableData.slow = false
        tableData.bounce = false
        tableData.n = false
        tableData.cd = false
    
        for k, v in pairs(tableData.bets) do
            tableData.bets[k] = {}
        end
        
        table.insert(tableData.history, winNum)

        for k, v in pairs(winAmounts) do
            local playerElement = tablePlayers[k]
            if playerElement and isElement(playerElement) then
                local playerSSC = exports.sCore:getSSC(playerElement) or 0
                local newSSC = playerSSC + v


                exports.sCore:giveSSC(playerElement, v)
                triggerClientEvent(playerElement, "refreshSSC", playerElement, newSSC)
            end
        end


        for k, v in pairs(tableData.data.players) do
            triggerClientEvent("rouletteNewRound", v, tableId)
        end
    end
end

function getTablesInCasino(dimension)
    local tables = {}

    for k, v in pairs(rouletteTableCoords) do
        if v[6] == dimension then
            tables[k] = {
                data = rouletteTableGroups[k].data,
                spin = rouletteTableGroups[k].spin,
                slow = rouletteTableGroups[k].slow,
                bounce = rouletteTableGroups[k].bounce,
                n = rouletteTableGroups[k].n,
                rouletteTableGroups[k].cd and (getRealTime().timestamp - rouletteTableGroups[k].cd) * 1000,
                history = rouletteTableGroups[k].history
            }
        end
    end

    return tables
end
