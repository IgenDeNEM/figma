connection = exports.sConnection:getConnection()

math.randomseed(getTickCount())

syncedDatas = {}
farmPlayers = {}
playerTools = {}
local farmTasks = {}
animalPositions = {}
farmPermissions = {}
animalData = {}
local waterCans = {}
local farmInventorys = {}

addEventHandler("onResourceStart", resourceRoot,
    function()
        dbQuery(loadFarms, connection, "SELECT * FROM farms WHERE ownerId > 0")
        
        setTimer(function()
            for _, v in pairs(getElementsByType("player")) do
                local farmId = getElementData(v, "currentFarm")

                if farmId then
                    triggerEvent("enterFarm", v, farmId)
                end
            end
        end, 5000, 1)
    end
)

function findById(id)
    for k, v in pairs(getElementsByType("player")) do
        if getElementData(v, "char.ID") == id then
            found = v
        end
    end
    return found
end

downTimers = {}

function loadFarms(qh)
    local result = dbPoll(qh, 0)

    if result then
        for i = 1, #result do
            local row = result[i]

            if row then
                local farmId = row.farmId

                if farmId then
                    if row.locked == 0 then
                        farmDetails[farmId].locked = false
                    else
                        farmDetails[farmId].locked = true
                    end

                    farmDetails[farmId].rentedBy = row.ownerId
                    farmDetails[farmId].tableText = row.tableText
                    farmDetails[farmId].type = row.type
                    farmDetails[farmId].expire = row.expire
                    if row.expire <= getRealTime().timestamp then
                        local owner = findById(row.ownerId)
                        if isElement(owner) and farmDetails[farmId].rentedBy then
                            exports.sGui:showInfobox(owner, "e", "A farm bérleted lejárt!")
                        end
                        farmDetails[farmId].rentedBy = false
                        triggerClientEvent("updateFarmDatas", resourceRoot, farmId, farmDetails[farmId])
                        dbExec(connection, "DELETE FROM farms where farmId = ?", farmId)
                    else
                        downTimers[farmId] = setTimer(function(ownerId, farmId)
                            local owner = findById(ownerId)
                            if isElement(owner) and farmDetails[farmId].rentedBy then
                                exports.sGui:showInfobox(owner, "e", "A farm bérleted lejárt!")
                            end
                            farmDetails[farmId].rentedBy = false
                            dbExec(connection, "DELETE FROM farms where farmId = ?", farmId)
                            killTimer(downTimers[farmId])
                            triggerClientEvent("updateFarmDatas", resourceRoot, farmId, farmDetails[farmId])
                        end, ((row.expire - getRealTime().timestamp) * (1000)), 1, row.ownerId, farmId)
                    end

                    if row.type == 2 then
                        if row.animalDatas and utfLen(row.animalDatas) > 0 then
                            animalData[farmId] = animalDataFromJson(row.animalDatas)
                        else
                            animalData[farmId] = defaultAnimalData()
                        end
                    end

                    local currentSize = farmDetails[farmId].size

                    if not syncedDatas[farmId] then
                        syncedDatas[farmId] = {}

                        for x = 1, farmSizeDetails[currentSize].size[1] do
                            for y = 1, farmSizeDetails[currentSize].size[2] do
                                if not syncedDatas[farmId][x] then
                                    syncedDatas[farmId][x] = {}
                                end

                                if not syncedDatas[farmId][x][y] then
                                    syncedDatas[farmId][x][y] = {}
                                end

                                syncedDatas[farmId][x][y] = initLandData(row.type)
                            end
                        end
                    end

                    if row.landDatas and utfLen(row.landDatas) > 0 then
                        landDataFromJson(syncedDatas[farmId], row.landDatas, row.type)
                    end

                    if row.permissions and utfLen(row.permissions) > 0 then
                        data = fromJSON(row.permissions)

                        farmPermissions[farmId] = {}
                        
                        for k, v in ipairs(data) do
                            local permDat = {}
                            
                            for k, v in pairs(v[3]) do
                                permDat[tonumber(k)] = v
                            end

                            farmPermissions[farmId][v[1]] = {v[1], v[2], permDat}
                        end
                    else
                        farmPermissions[farmId] = {}
                    end
                    
                end
            end
        end
    end
end

function findRotation(x1, y1, x2, y2)
    local t = -math.deg(math.atan2(x2 - x1, y2 - y1 ))
    return t < 0 and t + 360 or t
end

addEvent("getFarmDatas", true)
addEventHandler("getFarmDatas", getRootElement(),
    function()  
       for k, v in pairs(farmDetails) do
            if v and v.expire and v.expire <= getRealTime().timestamp then
                local owner = findById(v.ownerId)
                if isElement(owner) and farmDetails[k].rentedBy then
                    exports.sGui:showInfobox(owner, "e", "A farm bérleted lejárt!")
                end
                farmDetails[k].rentedBy = false
                dbExec(connection, "DELETE FROM farms where farmId = ?", k)
            end
        end
        triggerClientEvent(client, "gotFarmDatas", client, farmDetails)
    end
)


addEvent("enterFarm", true)
addEventHandler("enterFarm", getRootElement(), 
    function(farmId)
        if not client then
            client = source
        end

        local currentFarm = farmDetails[farmId]
        local intPosX, intPosY, intPosZ = getInteriorMarker(farmId)
        local farmRot = currentFarm.pos[4]
        local pos = {intPosX, intPosY, intPosZ, farmRot}
        local theType = currentFarm.type

        if not playerTools[farmId] then
            playerTools[farmId] = {}
        end

        if not getElementData(client, "rpc.action") then
            setElementData(client, "rpc.action", {"Bóklászik a farmban", "farm"})
        end

        local syncData = syncedDatas[farmId]

        local farmPerms = {}

        if farmPermissions[farmId] then
            farmPerms = farmPermissions[farmId]

            for k, v in pairs(farmPerms) do
                dbQuery(
                    function(qh, k, v, farmId)
                        local result = dbPoll(qh, 0)[1]

                        if result and result.name then
                            farmPerms[k] = {v[1], utf8.gsub(result.name, "_", " "), v[3]}
                        end
                    end,
                    {k, v, farmId}, connection, "SELECT name FROM characters WHERE characterId = ? LIMIT 1", v[1])
            end
        end

        if not farmPlayers[farmId] then
            farmPlayers[farmId] = {}
        end

        if theType == 2 then
            if not furikElements[farmId] then
                furikElements[farmId] = createObject(3910, furikBasePoses[farmId][1], furikBasePoses[farmId][2], furikBasePoses[farmId][3], furikBasePoses[farmId][4], furikBasePoses[farmId][5], furikBasePoses[farmId][6])
                setElementDimension(furikElements[farmId], farmId)
                setElementDoubleSided(furikElements[farmId], true)
            end

            if not bucketElements[farmId] then
                bucketElements[farmId] = createObject(3890, bucketBasePoses[farmId][1], bucketBasePoses[farmId][2], bucketBasePoses[farmId][3])
                setElementDimension(bucketElements[farmId], farmId)
                setElementDoubleSided(bucketElements[farmId], true)
            end

            local farmItems = {}
            local inventoryElement = false

            table.insert(farmPlayers[farmId], client)

            animalGrowth(animalData[farmId], syncedDatas[farmId])
            
            if #farmPlayers[farmId] == 1 then
                refreshAnimalsPosition(farmId)
            end
                
            farmItems = {
                food = animalData[farmId].food,
                animals = animalData[farmId].animals
            }
                
            inventoryElement = farmDetails[farmId].livestockData.animalsPosition
            
            local farmHoe = 2
            local farmMiniHoe = {}

            for k, v in pairs(playerTools[farmId]) do
                if v == "fork" and isElement(k) and getElementData(k, "forkState") then
                    farmMiniHoe[k] = getElementData(k, "forkState")[2]
                end
            end

            setElementPosition(client, intPosX, intPosY, intPosZ)
            setElementDimension(client, farmId)
            
            local buyPerm = false
            local sellPerm = false
            local feedPerm = false
            local milking = false
            
            if getPlayerPermission(farmId, client, "buyanimals", true) then
                buyPerm = true
            end

            if getPlayerPermission(farmId, client, "sellanimals", true) then
                sellPerm = true
            end

            if getPlayerPermission(farmId, client, "feedanimals", true) then
                feedPerm = true
            end

            if getPlayerPermission(farmId, client, "milkeggs", true) then
                milking = true
            end

            local finalPerms = {}

            local count = 0
            for k, v in pairs(farmPerms) do
                count = count + 1
                finalPerms[count] = v
            end
            local hoe, miniHoe, playerTools, own, inv, invEl, permDat = farmHoe, farmMiniHoe, playerTools[farmId], (getElementData(client, "char.ID") == currentFarm.rentedBy), farmItems, inventoryElement, finalPerms
            local hay, other, chick, bucket = animalData[farmId].hay, animalData[farmId].otherStock, animalData[farmId].chickenStock, false
            local bucketContent, eggCrates, slots = false, animalData[farmId].eggCrates, animalData[farmId].farmSlots

            setElementData(client, "currentFarm", farmId)

            hoe = farmDetails[farmId].fork or 2

            local miniHoe = {}

            for k, v in pairs(playerTools) do
                local forkData = getElementData(k, "forkState")
                miniHoe[k] = forkData[2]
            end

            triggerClientEvent(client, "enterFarm", client, farmId, pos, theType, syncData, hoe, miniHoe, playerTools, own, inv, invEl, permDat, hay, other, chick, buyPerm, sellPerm, bucket, bucketContent, eggCrates, milking, slots, feedPerm)
        elseif theType == 1 then
            if not crateElements[farmId] then
                crateElements[farmId] = createObject(1355, crateBasePoses[farmId][1], crateBasePoses[farmId][2], crateBasePoses[farmId][3], 0, 0, crateBasePoses[farmId][4])
                setElementDimension(crateElements[farmId], farmId)
                setElementDoubleSided(crateElements[farmId], true)
                setElementData(crateElements[farmId], "farmCreate", farmId)
            end
            
            for x = 1, farmSizeDetails[1].size[1] do
                for y = 1, farmSizeDetails[1].size[2] do
                    if syncedDatas[farmId][x][y].landState == "planted" then
                        calculatePlant(syncedDatas[farmId][x][y].plant)
                    end
                end
            end

            local farmHoe = farmDetails[farmId].hoe or 2
            local farmMiniHoe = farmDetails[farmId].miniHoe or 2
            local inv = farmInventorys[farmId] or {}
            local invEl = crateElements[farmId]

            local tempTools = {}
            if not tempTools[farmId] then
                tempTools[farmId] = {}
            end

            for k, v in pairs(farmPlayers[farmId]) do
                if not tempTools[farmId] then
                    tempTools[farmId] = {}
                end
                tempTools[farmId][v] = playerTools[v]
            end

            local finalPerms = {}

            local count = 0
            for k, v in pairs(farmPerms) do
                count = count + 1
                finalPerms[count] = v
            end

            triggerClientEvent(client, "enterFarm", client, farmId, pos, theType, syncData, farmHoe, farmMiniHoe, tempTools[farmId], (getElementData(client, "char.ID") == currentFarm.rentedBy), inv, invEl, finalPerms)

            setElementPosition(client, intPosX, intPosY, intPosZ)
            setElementDimension(client, farmId)
            
            setElementData(client, "currentFarm", farmId)
            
            table.insert(farmPlayers[farmId], client)
        else
            if getElementData(client, "char.ID") == currentFarm.rentedBy then
                triggerClientEvent(client, "promptFarmTypeChange", client, farmId)
            else
                exports.sGui:showInfobox(client, "e", "Nincs kiválasztva a farm típusa!")
            end
        end
    end
)

addEvent("exitFarm", true)
addEventHandler("exitFarm", getRootElement(),
    function(notFromMarker)
        local farmId = getElementData(client, "currentFarm")

        if farmId then
            if not notFromMarker then
                local currentFarm = farmDetails[farmId]
                
                setElementPosition(client, currentFarm.pos[1], currentFarm.pos[2], currentFarm.pos[3])
                setElementDimension(client, 0)
            end

            local currentAction = getElementData(client, "rpc.action")
            if currentAction and currentAction[2] == "farm" then
                setElementData(source, "rpc.action", false)
            end

            if getElementData(client, "forkState") then
                setForkState(client, farmId, false)
            end
            
            table.removeValue(farmPlayers[farmId], client)
            removeElementData(client, "currentFarm")

            triggerClientEvent(client, "exitFarm", client)
        end
    end
)

function reMap(value, low1, high1, low2, high2)
    return low2 + (value - low1) * (high2 - low2) / (high1 - low1)
end

addEvent("ppBoostFarm", true)
addEventHandler("ppBoostFarm", getRootElement(), function(farmId, x, y)
    if exports.sItems:hasItem(client, 405) then

        triggerClientEvent(farmPlayers[farmId], "boostPlant", client, x, y, 3)

        syncedDatas[farmId][x][y].plant.growRate = 3
        syncedDatas[farmId][x][y].plant.boosted = 1

        local items = exports.sItems:getElementItems(client)

        for k, v in pairs(items) do
            if v.itemId == 405 then
                exports.sItems:takeItem(client, "dbID", v.dbID)
                break
            end
        end

        exports.sGui:showInfobox(client, "s", "Sikeresen felhasználtál egy prémium növénytápszert!")
    end
end)


addEvent("farmTask", true)
addEventHandler("farmTask", getRootElement(),
    function(farmId, x, y, taskName, selectedPlant)
        local time = false

        if taskTimes[taskName] then
            time = taskTimes[taskName]
        end
        

        local forkData = getElementData(client, "forkState")

        if getPlayerPermission(farmId, client, taskName) then
            if taskName == "placehay" and forkData then
                if forkData[2] and (forkData[2][2] > 0) then
                    local hayMinus =  forkData[2][2] - (1 / 4)

                    setForkState(client, farmId, true, {"", hayMinus}, true, true)

                    syncedDatas[farmId][x][y].hay = true
                    syncedDatas[farmId][x][y].dirt = 0

                    triggerClientEvent(farmPlayers[farmId], "refreshFarmHay", client, x, y, 255, time, farmId)
                    triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "szalma", farmId)
                end
            elseif taskName == "removedirt" and forkData then
                if not forkData[2] or (forkData[2][2] < 1) then
                    local forkPlus = 1 / 4
                    local hayDirt = syncedDatas[farmId][x][y].dirt

                    if forkData[2] and forkData[2][2] then
                        forkPlus = forkData[2][2] + forkPlus

                        if forkData[2][3] then
                            hayDirt = (hayDirt + forkData[2][3]) / 2
                        end
                    end

                    setForkState(client, farmId, true, {"_manure", forkPlus, hayDirt}, false, true)
                    triggerClientEvent(farmPlayers[farmId], "cleanFarmDirt", client, x, y, time, farmId)

                    syncedDatas[farmId][x][y].dirt = 0
                    syncedDatas[farmId][x][y].hay = false
                end
            elseif taskName == "placemanure" and forkData then
                if not syncedDatas[farmId][x][y].hay then
                    local hayMinus =  forkData[2][2] - (1 / 4)
                    local hayDirt = forkData[2][3]

                    triggerClientEvent(farmPlayers[farmId], "setFarmDirt", client, x, y, time, hayDirt, farmId, true)

                    syncedDatas[farmId][x][y].hay = true
                    syncedDatas[farmId][x][y].dirt = hayDirt

                    if hayMinus == 0 then
                        hayDirt = nil
                    end

                    setForkState(client, farmId, true, {"_manure", hayMinus, hayDirt}, true, false)
                    triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "szalma", farmId)
                end
            elseif taskName == "cultivate" then
                if not (syncedDatas[farmId][x][y] and syncedDatas[farmId][x][y].landState) then
                    syncedDatas[farmId][x][y].landState = "cultivated:0"
                end

                local from = syncedDatas[farmId][x][y].landState:find("cultivated") and (tonumber(split(syncedDatas[farmId][x][y].landState, ":")[2]) or 0)

                syncedDatas[farmId][x][y].landState = "cultivated:" .. (from + 1)
                
                triggerClientEvent(farmPlayers[farmId], "refreshFarmLandState", client, x, y, syncedDatas[farmId][x][y].landState, time, farmId)
                setPedAnimation(client, "BASEBALL", "BAT_4", -1, false, false, false, false)
                triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "hoe" .. math.random(1, 5), farmId)
            elseif taskName == "dighole" then
                triggerClientEvent(farmPlayers[farmId], "refreshFarmLandState", client, x, y, "hole", time, farmId)
                setPedAnimation(client, "bomber", "bom_plant", -1, true, false, false)

                syncedDatas[farmId][x][y].landState = "hole"
                triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "shovel" .. math.random(1, 5), farmId, time)
            elseif taskName == "fillHole" then
                triggerClientEvent(farmPlayers[farmId], "refreshFarmLandState", client, x, y, false, time, farmId)
                setPedAnimation(client, "bomber", "bom_plant", -1, true, false, false)
                syncedDatas[farmId][x][y].landState = false
                triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "hole", farmId, time)
            elseif taskName == "water" then
                time = (255 - syncedDatas[farmId][x][y].wetness) * time
                if syncedDatas[farmId][x][y].plant and plantDetails[syncedDatas[farmId][x][y].plant.type] and plantDetails[syncedDatas[farmId][x][y].plant.type].SHTG then
                    if not exports.sItems:hasItem(client, 429) then
                        exports.sGui:showInfobox(client, "e", "Nincs nálad SHTG tápoldat!")
                        triggerClientEvent(client, "freeUpFromTask", client)
                        return
                    end
                else
                    if not exports.sItems:hasItem(client, 55) then
                        exports.sGui:showInfobox(client, "e", "Nincs nálad vizes kanna!")
                        triggerClientEvent(client, "freeUpFromTask", client)
                        return
                    end
                end
                syncedDatas[farmId][x][y].currentDryFactor = syncedDatas[farmId][x][y].currentDryFactor * math.random(90, 110) / 100
                syncedDatas[farmId][x][y].fromWetness = 255
                syncedDatas[farmId][x][y].wetness = 255
                
                triggerClientEvent(farmPlayers[farmId], "waterFarmLand", client, x, y, time, syncedDatas[farmId][x][y].fromWetness, syncedDatas[farmId][x][y].currentDryFactor)

                local landX, landY = getLandPosition(farmId, x, y)
                local posX, posY, posZ = getElementPosition(client)
                local rot = findRotation(posX, posY, landX, landY)
                
                triggerClientEvent(farmPlayers[farmId], "playerCanEffect", client, time, rot)
                setPedAnimation(client, "sword", "sword_idle", -1, true, false, false)

                waterCans[client] = createObject(globalModels.kanna, posX, posY, posZ)
                setElementDimension(waterCans[client], farmId)

                processBoneAttach(waterCans[client], client, "kanna")

                triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "ontozes", farmId, time)
                local playerItems = exports.sItems:getElementItems(client)
                if syncedDatas[farmId][x][y].plant and plantDetails[syncedDatas[farmId][x][y].plant.type] and plantDetails[syncedDatas[farmId][x][y].plant.type].SHTG then
                    for k2, v2 in pairs(playerItems) do
                        if v2.itemId == 429 then
                            if v2.amount == 1 then
                                exports.sItems:giveItem(client, 373, 1)
                            end
                            exports.sItems:takeItem(client, "dbID", v2.dbID, 1)
                            break
                        end
                    end
                else
                    for k2, v2 in pairs(playerItems) do
                        if v2.itemId == 55 then
                            if v2.amount == 1 then
                                exports.sItems:giveItem(client, 373, 1)
                            end
                            exports.sItems:takeItem(client, "dbID", v2.dbID, 1)
                            break
                        end
                    end
                end
            elseif taskName == "plant" then
                if selectedPlant then
                    if not exports.sItems:hasItem(client, plantDetails[selectedPlant].seeds) then
                        triggerClientEvent(client, "freeUpFromTask", client)
                        return
                    end
                    triggerClientEvent(farmPlayers[farmId], "refreshFarmLandState", client, x, y, "planted", time, farmId)
                    triggerClientEvent(farmPlayers[farmId], "plantToLand", client, x, y, rottenStart, growRate, selectedPlant)
                    local playerItems = exports.sItems:getElementItems(client)
                    for k2, v2 in pairs(playerItems) do
                        if v2.itemId == plantDetails[selectedPlant].seeds then
                            exports.sItems:takeItem(client, "dbID", v2.dbID, 1)
                            break
                        end
                    end

                    syncedDatas[farmId][x][y].landState = "planted"
                    syncedDatas[farmId][x][y].plant = initPlantData(selectedPlant)
                    syncedDatas[farmId][x][y].plant.startTime = getTickCount()
                    syncedDatas[farmId][x][y].plant.startRotten = rottenStart
                    syncedDatas[farmId][x][y].plant.growRate = growRate

                    setPedAnimation(client, "bomber", "bom_plant", -1, true, false, false)

                    triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "plant", farmId, time)
                end
            elseif taskName == "harvest" then
                triggerClientEvent(farmPlayers[farmId], "refreshFarmLandState", client, x, y, false, time, farmId)

                setPedAnimation(client, "bomber", "bom_plant", -1, true, false, false)
                triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "szuret" .. math.random(1, 2), farmId, time)
                
                setTimer(function(farmId, x, y, client)
                    triggerClientEvent(farmPlayers[farmId], "plantToLand", client, x, y, false, false, false)
                    local harvestTable = syncedDatas[farmId][x][y].plant
                    local plantToGiveTable = plantDetails[harvestTable.type].yield
                    if syncedDatas[farmId][x][y].plant.rotten == 1 then
                        syncedDatas[farmId][x][y].plant = false
                        syncedDatas[farmId][x][y].landState = false
                        exports.sItems:giveItem(client, 374, 1)
                    else
                        for itemToGive, ammountToGive in pairs(plantToGiveTable) do
                            if type(itemToGive) == "string" then
                                local tbl = plantDetails[harvestTable.type].yield.seeds
                                if tbl then
                                    for k, v in pairs(tbl) do
                                        local rand = math.random(1, #plantDetails[harvestTable.type].yield.seeds)
                                        if plantDetails[harvestTable.type].yield.seeds[rand] > 0 then
                                            exports.sItems:giveItem(client, plantDetails[harvestTable.type].seeds, plantDetails[harvestTable.type].yield.seeds[rand])
                                            break
                                        end
                                    end
                                end
                            elseif tonumber(itemToGive) then
                                exports.sItems:giveItem(client, itemToGive, 1)
                            end
                        end
                        syncedDatas[farmId][x][y].plant = false
                        syncedDatas[farmId][x][y].landState = false
                    end
                end, time, 1, farmId, x, y, client)
                
            end
        end

        if time then
            local landX, landY = getLandPosition(farmId, x, y)
            local posX, posY = getElementPosition(client)
            setElementRotation(client, 0, 0, findRotation(posX, posY, landX, landY))

            setTimer(
                function(player)
                    triggerClientEvent(player, "freeUpFromTask", player)
                    setPedAnimation(player, false)

                    if isElement(waterCans[player]) then
                        destroyElement(waterCans[player])
                    end

                    waterCans[player] = nil
                end, 
            time + 500, 1, client)
        else
            triggerClientEvent(client, "freeUpFromTask", client)
        end
    end
)

addEvent("rentFarm", true)
addEventHandler("rentFarm", getRootElement(),
    function(currentFarm, buyType)
        local haveMoney = false
        if not buyType then
            if hasFarm(getElementData(client, "char.ID")) then
                triggerClientEvent(client, "showInfobox", client, "error",
                "Mivel már van egy farmod ezt csak PP-ből bérelheted ki!", 4000)
                triggerClientEvent("updateFarmDatas", client, currentFarm, farmDetails[currentFarm])
                return
            end
            money = exports.sCore:getMoney(client)
            if money >= 6000 then
                haveMoney = true
            end
        end
        if buyType then
            pp = exports.sCore:getPP(client) or 0
            if pp >= 1200 then
                haveMoney = true
            end
        end

        if haveMoney then
            local charID = getElementData(client, "char.ID")

            if charID then
                if not buyType then
                    exports.sCore:takeMoney(client, 6000)
                else
                    exports.sCore:takePP(client, 1200)
                end
                triggerClientEvent(client, "showInfobox", client, "success",
                "Sikeresen kibérelted a farmot!", 4000)
                farmDetails[currentFarm].rentedBy = charID
                
                local visibleName = getElementData(client, "visibleName")
                farmDetails[currentFarm].tableText = table.concat(split(visibleName, "_"), "/")
                farmDetails[currentFarm].type = 0
                
                triggerClientEvent("updateFarmDatas", client, currentFarm, farmDetails[currentFarm])

                dbExec(connection, "INSERT INTO farms (farmId, tableText, ownerId, expire) VALUES(?, ?, ?, ?)", currentFarm, farmDetails[currentFarm].tableText, charID, getRealTime().timestamp + 604800)
                downTimers[currentFarm] = setTimer(function(ownerId, farmId)
                    local owner = findById(ownerId)
                    if isElement(owner) and farmDetails[farmId].rentedBy then
                        exports.sGui:showInfobox(owner, "e", "A farm bérleted lejárt!")
                    end
                    farmDetails[farmId].rentedBy = false
                    dbExec(connection, "DELETE FROM farms where farmId = ?", farmId)
                    triggerClientEvent("updateFarmDatas", resourceRoot, farmId, farmDetails[farmId])
                    killTimer(downTimers[farmId])
                end, 604800 * 1000, 1, charID, currentFarm)
            end
        else
            triggerClientEvent(client, "showInfobox", client, "error",
            "Nincs elég pénzed!", 4000)
            triggerClientEvent("updateFarmDatas", client, currentFarm, farmDetails[currentFarm])
        end
    end
)

addEvent("unRentFarm", true)
function unRentFarm(farmId)
    if isElement(furikElements[farmId]) then
        destroyElement(furikElements[farmId])
    end
    if isElement(bucketElements[farmId]) then
        destroyElement(bucketElements[farmId])
    end
    triggerClientEvent(client, "showInfobox", client, "success",
    "Sikeresen lemondtad a farmbérleted!", 4000)
    exports.sCore:giveMoney(client, 4000)
    farmDetails[farmId].rentedBy = false
    syncedDatas[farmId] = false
    triggerClientEvent("updateFarmDatas", resourceRoot, farmId, farmDetails[farmId])
    dbExec(connection, "DELETE FROM farms where farmId = ?", farmId)
end
addEventHandler("unRentFarm", root, unRentFarm)

addEvent("renewFarm", true)
function renewFarm(farmId)
    triggerClientEvent(client, "showInfobox", client, "success",
    "Sikeresen meghosszabbítottad a farmbérleted!", 4000)
    exports.sCore:takeMoney(client, 2000)
    farmDetails[farmId].expire = getRealTime().timestamp + 604800
    triggerClientEvent("updateFarmDatas", client, farmId, farmDetails[farmId])
    if isTimer(downTimers[farmId]) then
        killTimer(downTimers[farmId])
    end
    downTimers[farmId] = setTimer(function(ownerId, farmId)
        local owner = findById(ownerId)
        if isElement(owner) and farmDetails[farmId].rentedBy then
            exports.sGui:showInfobox(owner, "e", "A farm bérleted lejárt!")
        end
        farmDetails[farmId].rentedBy = false
        dbExec(connection, "DELETE FROM farms where farmId = ?", farmId)
        triggerClientEvent("updateFarmDatas", resourceRoot, farmId, farmDetails[farmId])
        killTimer(downTimers[farmId])
    end, 604800 * 1000, 1, getElementData(client, "char.ID"), farmId)
end
addEventHandler("renewFarm", root, renewFarm)

addEvent("editTableText", true)
addEventHandler("editTableText", getRootElement(),
    function(tableText)
        local farmId = getElementData(client, "currentFarm")

        if farmId then
            farmDetails[farmId].tableText = tableText
            triggerClientEvent("syncFarmOverrideChange", client, farmId, "tableText", tableText)
        end
    end
)

addEvent("changeFarmType", true)
addEventHandler("changeFarmType", getRootElement(),
    function(farmId, farmType)
        if farmType then
            farmDetails[farmId].type = farmType
            triggerClientEvent("updateFarmDatas", client, farmId, farmDetails[farmId])

            if farmType == 2 then
                animalData[farmId] = defaultAnimalData()
                
                dbExec(connection, "UPDATE farms SET type = ?, animalDatas = ? WHERE farmId = ?", farmType, animalDataToJson(animalData[farmId]), farmId)
            else
                dbExec(connection, "UPDATE farms SET type = ? WHERE farmId = ?", farmType, farmId)
            end

            if not syncedDatas[farmId] then
                syncedDatas[farmId] = {}

                for x = 1, farmSizeDetails[1].size[1] do
                    for y = 1, farmSizeDetails[1].size[2] do
                        if not syncedDatas[farmId][x] then
                            syncedDatas[farmId][x] = {}
                        end

                        if not syncedDatas[farmId][x][y] then
                            syncedDatas[farmId][x][y] = {}
                        end

                        syncedDatas[farmId][x][y] = initLandData(farmType)
                    end
                end
            end
        end
    end
)

addEvent("lockFarm", true)
addEventHandler("lockFarm", getRootElement(),
    function(farmId)
        if farmId then
            if getPlayerPermission(farmId, client, "lock") then
                if (farmDetails[farmId].lockedTick and getTickCount() - farmDetails[farmId].lockedTick > 3000) or not farmDetails[farmId].lockedTick then
                    farmDetails[farmId].lockedTick = getTickCount()
                    farmDetails[farmId].locked = not farmDetails[farmId].locked
                    if farmDetails[farmId].locked then
                        exports.sChat:localAction(client, "bezárta egy farm ajtaját.")
                    else
                        exports.sChat:localAction(client, "kinyitotta egy farm ajtaját.")
                    end
                    triggerClientEvent("playLockSoundFarm", client, farmId)
                    triggerClientEvent("syncFarmOverrideChange", client, farmId, "locked", farmDetails[farmId].locked)
                end
            end
        end
    end
)

addEvent("addFarmPermission", true)
addEventHandler("addFarmPermission", getRootElement(),
    function(memberName)
        if memberName then
            local farmId = getElementData(client, "currentFarm")

            if farmId then
                local player, playerName = exports.sCore:findPlayer(client, memberName)

                if not farmPermissions[farmId] then
                    farmPermissions[farmId] = {}
                end
                
                local charId = getElementData(player, "char.ID")

                if client == player then
                    exports.sGui:showInfobox(client, "e", "Saját magadat nem adhatod hozzá!")
                    charId = false
                end

                if charId then
                    local tempTable = {}
                    farmPermissions[farmId][charId] = {charId, playerName, {}}

                    for k, v in pairs(farmPermissions[farmId]) do
                        table.insert(tempTable, v)
                    end
                    
                    triggerClientEvent(farmPlayers[farmId], "updatePermissionData", client, tempTable)
                    tempTable = nil
                end
            end
        end
    end
)   

addEvent("toggleFarmPermission", true)
addEventHandler("toggleFarmPermission", getRootElement(),
    function(charId, hoverId)
        if charId and hoverId then
            local farmId = getElementData(client, "currentFarm")

            if farmId then
                local hoverId = tonumber(hoverId)
                local charId = tonumber(charId)
                local tempTable = {}
                
                farmPermissions[farmId][charId][3][hoverId] = not farmPermissions[farmId][charId][3][hoverId]

                for k, v in pairs(farmPermissions[farmId]) do
                    table.insert(tempTable, v)
                end
                
                triggerClientEvent(farmPlayers[farmId], "updatePermissionData", client, tempTable)
                tempTable = nil
            end
        end
    end
)

addEvent("removeFarmPermission", true)
addEventHandler("removeFarmPermission", getRootElement(),
    function(charId)
        if charId then
            local farmId = getElementData(client, "currentFarm")

            if farmId then
                local charId = tonumber(charId)
                local tempTable = {}

                farmPermissions[farmId][charId] = nil

                for k, v in pairs(farmPermissions[farmId]) do
                    table.insert(tempTable, v)
                end

                triggerClientEvent(farmPlayers[farmId], "updatePermissionData", client, tempTable)
                tempTable = nil
            end
        end
    end
)

addEvent("getHoeFromInterior", true)
addEventHandler("getHoeFromInterior", getRootElement(),
    function()
        local farmId = getElementData(client, "currentFarm")

        if farmId then
            if getPlayerPermission(farmId, client, "usetools") then
                if farmDetails[farmId].hoe > 0 then
                    playerTools[client] = "hoe"
                    farmDetails[farmId].hoe = farmDetails[farmId].hoe - 1

                    triggerClientEvent(farmPlayers[farmId], "syncHoeState", client, farmId, true, farmDetails[farmId].hoe)
                    triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "szerszamle-fel", farmId)
                end
            end
        end
    end
)

addEvent("putHoeToInterior", true)
addEventHandler("putHoeToInterior", getRootElement(),
    function()
        local farmId = getElementData(client, "currentFarm")

        if farmId then
            if getPlayerPermission(farmId, client, "usetools") then
                if playerTools[client] == "hoe" then
                    playerTools[client] = nil
                    farmDetails[farmId].hoe = farmDetails[farmId].hoe + 1

                    triggerClientEvent(farmPlayers[farmId], "syncHoeState", client, farmId, false, farmDetails[farmId].hoe)
                    triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "szerszamle-fel", farmId)
                end
            end
        end
    end
)

addEvent("getMiniHoeFromInterior", true)
addEventHandler("getMiniHoeFromInterior", getRootElement(),
    function()
        local farmId = getElementData(client, "currentFarm")

        if farmId then
            if getPlayerPermission(farmId, client, "usetools") then
                if farmDetails[farmId].miniHoe > 0 then
                    playerTools[client] = "minihoe"
                    farmDetails[farmId].miniHoe = farmDetails[farmId].miniHoe - 1

                    triggerClientEvent(farmPlayers[farmId], "syncMiniHoeState", client, farmId, true, farmDetails[farmId].miniHoe)
                    triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "szerszamle-fel", farmId)
                end
            end
        end
    end
)

addEvent("putMiniHoeToInterior", true)
addEventHandler("putMiniHoeToInterior", getRootElement(),
    function()
        local farmId = getElementData(client, "currentFarm")

        if farmId then
            if getPlayerPermission(farmId, client, "usetools") then
                if playerTools[client] == "minihoe" then
                    playerTools[client] = nil
                    farmDetails[farmId].miniHoe = farmDetails[farmId].miniHoe + 1

                    triggerClientEvent(farmPlayers[farmId], "syncMiniHoeState", client, farmId, false, farmDetails[farmId].miniHoe)
                    triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "szerszamle-fel", farmId)
                end
            end
        end
    end
)

addEvent("tryToChargeCan", true)
addEventHandler("tryToChargeCan", getRootElement(),
    function(itemId)
        if itemId then
            if waterCans[source] then
                return
            end
            --if inWaterCol[source] then
                local currentFarm = false

                for k, v in pairs(farmExteriors) do
                    local posX, posY, posZ = unpack(v.wateringPosition)

                    if getDistanceBetweenPoints3D(posX, posY, posZ, getElementPosition(source)) <= 1 then
                        currentFarm = k
                        break
                    end
                end
                if currentFarm then
                    local posX, posY, posZ = farmExteriors[currentFarm].wateringPosition[4], farmExteriors[currentFarm].wateringPosition[5], farmExteriors[currentFarm].wateringPosition[6]
                    local rotX, rotY, rotZ = farmExteriors[currentFarm].pos[4], farmExteriors[currentFarm].pos[5], farmExteriors[currentFarm].pos[6]
                    
                    waterCans[source] = createObject(globalModels.kanna, posX, posY, posZ, 0, 90, rotZ - 180 -90)
                    setElementCollisionsEnabled(waterCans[source], false)
                    local posX, posY, posZ = getPositionFromElementOffset(waterCans[source], 0.15, 0, -0.3)
                    setElementPosition(waterCans[source], posX, posY, posZ)
                    setElementFrozen(source, true)

                    triggerClientEvent("playFarmSound", source, "water", getElementDimension(source), 10000)
                    
                    exports.sItems:takeItem(source, "dbID", itemId)

                    setTimer(function(player)
                        setElementFrozen(player, false)
                        exports.sGui:showInfobox(player, "i", "Megtöltötted a kannát!")

                        if isElement(waterCans[player]) then
                            destroyElement(waterCans[player])
                        end

                        waterCans[player] = nil
                        exports.sItems:giveItem(player, 55, 8)
                    end, 10000, 1, source)
                end
            --end
       end
    end
)

addEvent("sellFarmItem", true)
addEventHandler("sellFarmItem", getRootElement(),
    function(dealItems, price)
        if exports.sItems:hasItemEx(client, "dbID", dealItems) then
            local dealItemsNum = exports.sItems:getItemCountEx(client, dealItems)
            exports.sCore:giveMoney(client, math.floor(price * dealItemsNum))
            exports.sItems:takeItem(client, "dbID", dealItems)
        end
    end
)

addEvent("placeItemToFarmCrate", true)
addEventHandler("placeItemToFarmCrate", getRootElement(),
    function(element, dbID)
        if dbID then
            local itemData = exports.sItems:hasItemEx(client, "dbID", dbID)
            local itemId = itemData.itemId
            local itemNum = itemData.amount

            if itemNum then
                if (itemId >= 375 and itemId <= 389) then
                    exports.sItems:takeItem(client, "dbID", dbID)
                    local farmId = getElementData(element, "farmCreate")

                    if farmId then
                        if not farmInventorys[farmId] then
                            farmInventorys[farmId] = {}
                        end

                        if farmInventorys[farmId][itemId] then
                            farmInventorys[farmId][itemId] = itemNum + farmInventorys[farmId][itemId]
                        else
                            farmInventorys[farmId][itemId] = itemNum
                        end

                        local allWeight = 0

                        for k, v in pairs(farmInventorys[farmId]) do
                            local itemWeight = exports.sItems:getItemWeight(k)

                            allWeight = (itemWeight * v) + allWeight
                        end

                        local weightPercent = allWeight / 25

                        if weightPercent >= 1 then
                            farmInventorys[farmId][itemId] = farmInventorys[farmId][itemId] - itemNum
                            return
                        end

                        triggerClientEvent(farmPlayers[farmId], "updateFarmInventroy", client, farmInventorys[farmId])

                        local addVal = weightPercent
                        local posX, posY, posZ = getPositionFromElementOffset(element, 0, 0, -0.2)

                        if not crateElements2[farmId] then
                            local rotX, rotY, rotZ = getElementRotation(element)

                            crateElements2[farmId] = createObject(globalModels.crate2, posX, posY, posZ, rotX, rotY, rotZ)
                            setElementDimension(crateElements2[farmId], farmId)
                            setElementDoubleSided(crateElements2[farmId], true)

                            setObjectScale(crateElements2[farmId], 1, 1, addVal)
                        else
                            setElementPosition(crateElements2[farmId], posX, posY, posZ)
                            setObjectScale(crateElements2[farmId], 1, 1, addVal)
                        end
                    end
                end
            end
        end
    end
)

addEventHandler("onElementClicked", resourceRoot,
    function(btn, state, player)
        if btn == "right" and state == "down" then
            local farmId = getElementData(source, "farmCreate")
            
            if farmId and getPlayerPermission(farmId, player, "movecrate", false) then
                if not playerTools[source] then
                    setPedAnimation(player, "carry", "liftup", -1, false, false, false, false)
                    
                    setTimer(function(source, player, farmId)
                        setPedAnimation(player, "carry", "crry_prtial", 0, true, true, false, true)
                        --exports.spattach:attach(source, player, 25, 0.22, 0, 0, 95, -75, 10) -- boneID X Y Z rotX rotY rotZ //szar
                        
                        processBoneAttach(source, player, "crate2")

                        if crateElements2[farmId] then
                            processBoneAttach(source, player, "crate2")
                          
                            --exports.spattach:attach(crateElements2[farmId], player, 24, 0.22, 0, 0, 0, 0, 0)    
                        end
                        
                        bindKey(player, "F", "down", unUseCrate, source, farmId)
                        setElementData(player, "currentCrate", source)
                        setElementData(player, "currentCrateItems", farmInventorys[farmId])
                    end, 1500, 1, source, player, farmId)
                end
            end
        end
    end
)

function unUseCrate(player, key, state, object, farmId, trunk)
    if getElementData(player, "currentCrate") then
        if getElementDimension(player) ~= farmId then
            exports.spattach:detach(object)
            local _, _, rotZ = getElementRotation(player)
            setElementRotation(object, 0, 0, rotZ)

            local x, y = crateBasePoses[farmId][1], crateBasePoses[farmId][2], crateBasePoses[farmId][3], 0, 0, crateBasePoses[farmId][4]
            local z = crateBasePoses[farmId][3]
            
            setElementPosition(object, x, y, z)

            setElementCollisionsEnabled(object, true)

            setElementDimension(object, farmId)
            setElementInterior(object, 0)

            setPedAnimation(player, "carry", "putdwn", -1, false, false, false, false)

            if trunk then
                farmInventorys[farmId] = {}
                destroyElement(crateElements2[farmId])
                crateElements2[farmId] = false
            end

            if crateElements2[farmId] then
                local x, y, z = crateBasePoses[farmId][1], crateBasePoses[farmId][2], crateBasePoses[farmId][3], 0, 0, crateBasePoses[farmId][4]
                
                exports.spattach:detach(crateElements2[farmId])
                setElementRotation(crateElements2[farmId], 0, 0, rotZ)
                setElementPosition(crateElements2[farmId], x, y, z)
                setElementCollisionsEnabled(crateElements2[farmId], true)
                setElementDimension(crateElements2[farmId], farmId)
                setElementInterior(crateElements2[farmId], 0)
            end
            setElementData(player, "currentCrate", false)
            setElementData(player, "currentCrateItems", false)
            playerTools[player] = false
        else
            exports.spattach:detach(object)
            local _, _, rotZ = getElementRotation(player)
            setElementRotation(object, 0, 0, rotZ)

            local x, y = getPositionFromElementOffset(player, 0, 0.7, 0)
            local z = crateBasePoses[farmId][3]
            
            setElementPosition(object, x, y, z)

            setElementCollisionsEnabled(object, true)


            setPedAnimation(player, "carry", "putdwn", -1, false, false, false, false)

            if crateElements2[farmId] then
                local x, y, z = getPositionFromElementOffset(object, 0, 0, -0.2)
                
                exports.spattach:detach(crateElements2[farmId])
                setElementRotation(crateElements2[farmId], 0, 0, rotZ)
                setElementPosition(crateElements2[farmId], x, y, z)
                setElementCollisionsEnabled(crateElements2[farmId], true)
            end
            setElementData(player, "currentCrate", false)
            setElementData(player, "currentCrateItems", false)
            playerTools[player] = false
        end
    end
end

function getPlayerPermission(farmId, player, permissionName, skip, skipAdmin)
    local returnVal = false
    local permissionName = farmPermissionGroupsEx[permissionName]
    local charId = getElementData(player, "char.ID")

    if (farmPermissions[farmId] and farmPermissions[farmId][charId] and farmPermissions[farmId][charId][3][permissionName]) or (charId == farmDetails[farmId].rentedBy) then
        returnVal = true
    elseif (getElementData(player, "acc.adminLevel") or 0) >= 6 and not skipAdmin then
        returnVal = true
    else
        if not skip then
            exports.sGui:showInfobox(player, "e", "Nincs ehhez jogosultságod!")
        end
    end

    return returnVal
end

function saveFarm(farmId)
    if farmDetails[farmId] then
        local farmType = farmDetails[farmId].type
        local tempTable = {}

        if farmType == 2 then
            animalGrowth(animalData[farmId], syncedDatas[farmId])
            
            if farmPermissions[farmId] then
                for k, v in pairs(farmPermissions[farmId]) do
                    table.insert(tempTable, v)
                end
            end
            
            local lockedState = 0
            
            if farmDetails[farmId].locked then
                lockedState = 1
            end
            
            dbExec(connection, "UPDATE farms SET landDatas = ?, animalDatas = ?, permissions = ?, locked = ?, tableText = ? WHERE farmId = ?", landDataToJson(syncedDatas[farmId], farmType), animalDataToJson(animalData[farmId]), toJSON(tempTable, true), lockedState, farmDetails[farmId].tableText, farmId)
            
        elseif farmType == 1 then
            for x = 1, farmSizeDetails[1].size[1] do
                for y = 1, farmSizeDetails[1].size[2] do
                    if syncedDatas[farmId][x][y].landState == "planted" then
                        calculatePlant(syncedDatas[farmId][x][y].plant)
                    end
                end
            end
            
            if farmPermissions[farmId] then
                for k, v in pairs(farmPermissions[farmId]) do
                    table.insert(tempTable, v)
                end
            end

            local lockedState = 0

            if farmDetails[farmId].locked then
                lockedState = 1
            end

            dbExec(connection, "UPDATE farms SET landDatas = ?, permissions = ?, locked = ?, tableText = ? WHERE farmId = ?", landDataToJson(syncedDatas[farmId], farmType), toJSON(tempTable, true), lockedState, farmDetails[farmId].tableText, farmId)

        end
    end
end

function saveAllFarms()
    for k, v in pairs(farmDetails) do
        if v.rentedBy then
            saveFarm(k)
        end
    end
end
setTimer(saveAllFarms, 1000 * 60 * 60, 1)

addEventHandler("onResourceStop", resourceRoot,
    function()
        for k, v in pairs(getElementsByType("player")) do
            removeElementData(v, "forkState")
            removeElementData(v, "currentFurik")
            removeElementData(v, "currentBucket")
            removeElementData(v, "currentCrate")
        end

        saveAllFarms()
    end
)

function table.removeValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            table.remove(tab, index)
            return index
        end
    end
    
    return false
end

function findOwner(id)
    local co = coroutine.create(function()
        local qh = dbQuery(connection, "SELECT name FROM characters WHERE characterId = ?", id)
        local result = dbPoll(qh, -1)
        coroutine.yield(result)
        dbFree(qh)
    end)
    local _, name = coroutine.resume(co)
    return name[1]["name"]
end

function getFarmOwner(sourcePlayer, commandName, farmId)
    if exports.sPermission:hasPermission(sourcePlayer, "getfarmowner") then
        local farmId = tonumber(farmId)
        if (farmId) then
            outputChatBox("[color=sightgreen][SightMTA - Farm]:[color=hudwhite] A farm tulajdonosa: [color=sightgreen]" .. findOwner(farmDetails[farmId].rentedBy):gsub("_", " ") or "Ismeretlen", sourcePlayer, 255, 255, 255, true)
        else
            outputChatBox("[color=sightblue][SightMTA - Farm]:[color=hudwhite] /getfarmowner [Farm ID]", sourcePlayer, 255, 255, 255, true)
        end
    end
end
addCommandHandler("getfarmowner", getFarmOwner)

function hasFarm(id)
    local found = false
    for k, v in pairs(farmDetails) do
        if v.rentedBy == id then
            found = true
        end
    end
    return found
end

function renameFarm(sourcePlayer, commandName, farmId, ...)
    if exports.sPermission:hasPermission(sourcePlayer, "renamefarm") then
        local farmId = tonumber(farmId)
        local name = table.concat({...}, " ")
        if (farmId) and name then
            farmDetails[farmId].tableText = name
            
            triggerClientEvent("updateFarmDatas", sourcePlayer, farmId, farmDetails[farmId])
            outputChatBox("[color=sightgreen][SightMTA - Farm]:[color=hudwhite] Sikeresen megváltoztattad a farm nevét!", sourcePlayer, 255, 255, 255, true)
        else
            outputChatBox("[color=sightblue][SightMTA - Farm]:[color=hudwhite] /renamefarm [Farm ID] [név]", sourcePlayer, 255, 255, 255, true)
        end
    end
end
addCommandHandler("renamefarm", renameFarm)

addEvent("breakInFarm", true)
addEventHandler("breakInFarm", root, function(farmId, itemDbID)

    exports.sChat:localAction(client, "betörte egy farm ajtaját.")

    farmDetails[farmId].lockedTick = getTickCount()
    farmDetails[farmId].locked = false

    local item = exports.sItems:hasItemEx(client, "dbID", itemDbID)
    if (item.data1 or 0) + 1 < 10 then
        exports.sItems:updateItemData1(client, itemDbID, (item.data1 or 0) + 1)
    else
        exports.sItems:takeItem(client, "dbID", itemDbID)
    end

    triggerClientEvent("syncFarmOverrideChange", client, farmId, "locked", farmDetails[farmId].locked)

    triggerClientEvent("playRamSoundFarm", client, farmId)
end)

addCommandHandler("resettools", function(sourcePlayer, commandName, farmId)
    if exports.sPermission:hasPermission(sourcePlayer, "resettools") then
        local farmId = tonumber(farmId)
        if farmId then
            if farmDetails[farmId] then
                farmDetails[farmId].hoe = 2
                farmDetails[farmId].fork = 2
                farmDetails[farmId].miniHoe = 2
                triggerClientEvent(farmPlayers[farmId], "syncHoeState", sourcePlayer, farmId, false, farmDetails[farmId].hoe)
                triggerClientEvent(farmPlayers[farmId], "syncForkState", sourcePlayer, farmId, false, farmDetails[farmId].fork, loadedState, false, false)
                triggerClientEvent(farmPlayers[farmId], "syncMiniHoeState", sourcePlayer, farmId, false, farmDetails[farmId].miniHoe)
                 outputChatBox("[color=sightgreen][SightMTA - Farm]:[color=hudwhite] Sikeresen visszaállítottad az eszközöket a kiválasztott farmban.", sourcePlayer, 255, 255, 255, true)
            else
                outputChatBox("[color=sightred][SightMTA - Farm]:[color=hudwhite] Nem található farm ezzel az ID-vel!", sourcePlayer, 255, 255, 255, true)
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Farm]:[color=hudwhite] /resettools [Farm ID]", sourcePlayer, 255, 255, 255, true)
        end
    end
end)