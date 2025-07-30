playerForks = {}
animalOrders = {}
farmOrders = {}
trailerContents = {}
loadOutCols = {}
farmAnimalsMoveTimer = {}
sellAnimals = {}
sellMarkers = {}
sellCols = {}

addEvent("getTrailerContents", true)
addEventHandler("getTrailerContents", getRootElement(),
    function()  
        
    end
)

addEvent("getForkFromInterior", true)
addEventHandler("getForkFromInterior", getRootElement(),
    function()
        local farmId = getElementData(client, "currentFarm")

        if farmId and getPlayerPermission(farmId, client, "usetools") then
            setForkState(client, farmId, true)
        end
    end
)

addEvent("putForkToInterior", true)
addEventHandler("putForkToInterior", getRootElement(),
    function()
        local farmId = getElementData(client, "currentFarm")

        if farmId then
            setForkState(client, farmId, false)
        end
    end
)

addEvent("getHayToFork", true)
addEventHandler("getHayToFork", getRootElement(),
    function()
        local farmId = getElementData(client, "currentFarm")

        if farmId then
            local forkData = getElementData(client, "forkState")
                        
            if forkData[2] and (forkData[2][2] > 0) then
                animalData[farmId].hay = animalData[farmId].hay + ((1 / 7) * forkData[2][2])
                setForkState(client, farmId, true, {"", 0}, true, true)
                
                triggerClientEvent(farmPlayers[farmId], "syncHayAmount", client, animalData[farmId].hay, farmId)

                dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)
            else
                local hayMinus = 1 / 7

                animalData[farmId].hay = animalData[farmId].hay - hayMinus
                setForkState(client, farmId, true, {"", 1}, false)
                
                triggerClientEvent(farmPlayers[farmId], "syncHayAmount", client, animalData[farmId].hay, farmId)
                
                dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)
            end

            triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "szalma", farmId)
        end
    end
)

function setForkState(player, farmId, state, loadedState, downAnim, sync)
    local syncState = true

    if not playerTools[farmId] then
        playerTools[farmId] = {}
    end
    
    if not loadedState then
        if state then
            if farmDetails[farmId].fork > 0 then
                farmDetails[farmId].fork = farmDetails[farmId].fork - 1
                playerTools[farmId][player] = "fork"
            else
                syncState = false
            end
        else
            local forkData = getElementData(player, "forkState")

            if (forkData[2] and (forkData[2][2] <= 0)) or not forkData[2] then
                farmDetails[farmId].fork = farmDetails[farmId].fork + 1
                playerTools[farmId][player] = nil
                setElementData(player, "forkState", false)
            else
                exports.sGui:showInfobox(player, "e", "Előbb ürisd le a villádat!")
                syncState = false
            end
        end 
    end

    if syncState then
        if not state then
            setElementData(player, "forkState", false)
        else
            setElementData(player, "forkState", {state, loadedState})
        end
        triggerClientEvent(farmPlayers[farmId], "syncForkState", player, farmId, state, farmDetails[farmId].fork, loadedState, downAnim, sync)
        if loadedState and loadedState[1] == "_manure" or loadedState and loadedState[1] == "" then
            triggerClientEvent(farmPlayers[farmId], "playFarmSound", player, "szalma", farmId)
        else
            triggerClientEvent(farmPlayers[farmId], "playFarmSound", player, "szerszamle-fel", farmId)
        end
    end
end

addEventHandler("onElementClicked", resourceRoot,
    function(btn, state, player)
        local forkState = getElementData(player, "forkState")
        
        if btn == "right" and state == "down" then
            if forkState and forkState[1] then
                return
            end
            
            local farmId = getElementData(player, "currentFarm")
            
            if farmId and getPlayerPermission(farmId, player, "usetools") then
                if getElementModel(source) == 3910 then
                    if not getElementData(player, "currentBucket") then
                        setElementData(player, "currentFurik", source)
                        bindKey(player, "F", "down", unUseElements)

                        outputChatBox("#d75959[SighMTA - Farm]: #ffffffA talicskát az [F] gombabal tudod letenni.", player, 255, 255, 255, true)
                    end
                elseif getElementModel(source) == 3890 then
                    if not getElementData(player, "currentFurik") then
                        local bucketData = getElementData(source, "bucketData")

                        if bucketData then
                            setElementData(player, "currentBucket", bucketData)
                        else
                            setElementData(player, "currentBucket", {source, false, true, false, farmId})
                        end

                        exports.spattach:attach(source, player, 24, -0.05, 0.05, 0.05, 75, 180, 0)
                        bindKey(player, "F", "down", unUseElements)

                        outputChatBox("#d75959[SighMTA - Farm]: #ffffffA vödröt az [F] gombabal tudod letenni.", player, 255, 255, 255, true)
                    end
                end
            end
        elseif btn == "left" and state == "down" then
            local farmId = getElementData(player, "currentFarm")
            
            if farmId and getPlayerPermission(farmId, player, "usetools") then
                if getElementModel(source) == 3910 then
                    local forkData = getElementData(player, "forkState")

                    if forkData and forkData[2] and (forkData[2][2] > 0) then
                        if forkData[2][1] == "_manure" then
                            local manureContent = getElementData(source, "manureContent") or 0
                            
                            if manureContent < 1 then
                                local muchNum = 0
                                local addVal = (1 / 3) * forkData[2][2]
                                local manureContent = manureContent + addVal

                                if manureContent > 1 then
                                    muchNum = 1 / manureContent
                                    manureContent = 1
                                end

                                if muchNum > 0 then
                                    setForkState(player, farmId, true, {"_manure", muchNum}, true, true)
                                else
                                    setForkState(player, farmId, true, {"_manure", 0}, true, true, true)
                                end

                                setElementData(source, "manureContent", manureContent)
                            end
                        end
                    end
                end
            end
        end
    end
)

function unUseElements(player, key, state)
    local furikState = getElementData(player, "currentFurik")
    local bucketState = getElementData(player, "currentBucket")
    local farmId = getElementData(player, "currentFarm")
    
    if furikState then
        local fx, fy = getPositionFromElementOffset(player, 0, 1.5, 0)
        
        if farmId then
            if 1 >= getDistanceBetweenPoints2D(fx, fy, furikBasePoses[farmId][1], furikBasePoses[farmId][2]) then
                setElementPosition(furikState, furikBasePoses[farmId][1], furikBasePoses[farmId][2], furikBasePoses[farmId][3])
                setElementRotation(furikState, furikBasePoses[farmId][4], furikBasePoses[farmId][5], furikBasePoses[farmId][6])
            end

            setElementData(player, "currentFurik", nil)
        else
            for k = 1, #trashPositions do
                if trashPositions[k] and 3 >= getDistanceBetweenPoints2D(fx, fy, trashPositions[k][1], trashPositions[k][2]) then
                    setElementData(furikState, "manureContent", 0)
                    triggerClientEvent("furikUritAnim", player)
                    break 
                end
            end

            setTimer(function(player)
                bindKey(player, "F", "down", unUseElements)
            end, 1000, 1, player)
        end
    elseif bucketState then
        local farmId = bucketState[5]

        if inWaterCol[player] then
            local currentFarm = false
            
            for k, v in pairs(farmExteriors) do
                local posX, posY, posZ = unpack(v.wateringPosition)

                if getDistanceBetweenPoints3D(posX, posY, posZ, getElementPosition(player)) <= 1 then
                    currentFarm = k
                    break
                end 
            end

            if currentFarm then
                local posX, posY, posZ = farmExteriors[currentFarm].wateringPosition[4], farmExteriors[currentFarm].wateringPosition[5], farmExteriors[currentFarm].wateringPosition[6]
                local farmId = bucketState[5]
                
                exports.spattach:detach(bucketState[1])
                setPedAnimation(player)
                setElementPosition(bucketState[1], posX, posY, posZ)
                setElementRotation(bucketState[1], 0, 0, 0) 
                setElementFrozen(player, true)
                
                setElementData(player, "currentBucket", {bucketState[1], {"water", 1}, true, 3000, farmId})
                triggerClientEvent("playFarmSound", player, "water", getElementDimension(player), 3000)
                
                setTimer(function(player, bucketObj)
                    setElementFrozen(player, false)
                    exports.spattach:attach(bucketObj, player, 24, -0.05, 0.05, 0.05, 75, 180, 0)
                    bindKey(player, "F", "down", unUseElements)
                    exports.sGui:showInfobox(player, "i", "Megtöltötted a vödröt")
                end, 3000, 1, player, bucketState[1])
            end
        else
            local x, y = getPositionFromElementOffset(player, 0.5, 0, 0)
            local z = bucketBasePoses[farmId][3]

            if bucketState[5] ~= getElementDimension(player) then
                x, y = bucketBasePoses[farmId][1], bucketBasePoses[farmId][2]
                outputChatBox("#d75959[SighMTA - Farm]: #ffffffMivel nem tartózkodsz a farmban, ezért a vödör az eredeti helyére került.", player, 255, 255, 255, true)

                if bucketState[2] and bucketState[2][1] == "csirketap" then
                    local val = (1 / 6) * bucketState[2][2]

                    animalData[farmId].chickenStock = animalData[farmId].chickenStock + val
                    triggerClientEvent(farmPlayers[farmId], "syncChickenFoodAmount", player, animalData[farmId].chickenStock, farmId)
                    setElementData(player, "currentBucket", {bucketState[1], false, true, false, farmId})

                    dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)
                elseif bucketState[2] and bucketState[2][1] == "pellet" then
                    local val = (1 / 6) * bucketState[2][2]

                    animalData[farmId].otherStock = animalData[farmId].otherStock + val
                    triggerClientEvent(farmPlayers[farmId], "syncOtherFoodAmount", player, animalData[farmId].otherStock, farmId)
                    setElementData(player, "currentBucket", {bucketState[1], false, true, false, farmId})

                    dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)
                elseif bucketState[2] and bucketState[2][1] == "water" then
                    setElementData(player, "currentBucket", {bucketState[1], false, true, false, farmId})
                end
            end
            exports.spattach:detach(bucketState[1])
            local bucketData = getElementData(player, "currentBucket")

            setElementPosition(bucketState[1], x, y, z)
            setElementRotation(bucketState[1], 0, 0, 0)
            setElementData(player, "currentBucket", nil)
            setElementData(bucketState[1], "bucketData", bucketData)
            setElementDimension(bucketState[1], farmId)
            setPedAnimation(player)
            setElementCollisionsEnabled(bucketState[1], true)
        end
    end

    unbindKey(player, "F", "down", unUseElements)
end


addEvent("tryToUseStatsCard", true)
addEventHandler("tryToUseStatsCard", getRootElement(),
    function(farmId, animal)
        if farmId and animalData[farmId] and animal and animalData[farmId].animals[animal] then
            animalData[farmId].animals[animal].fat = 1
            animalData[farmId].animals[animal].health = 1
            animalData[farmId].animals[animal].mood = 1
            animalData[farmId].animals[animal].moodMinus = 0
            triggerClientEvent(farmPlayers[farmId], "fullStatAnimal", client, farmId, animal)
            local items = exports.sItems:getElementItems(client)

            for k, v in pairs(items) do
                if v.itemId == 590 then
                    exports.sItems:takeItem(client, "dbID", v.dbID)
                    break
                end
            end
        end
    end
)

addEvent("getChickenFoodToBucket", true)
addEventHandler("getChickenFoodToBucket", getRootElement(),
    function()  
       local farmId = getElementData(client, "currentFarm")

        if farmId then
            local currentBucket = getElementData(client, "currentBucket")
            
            if not currentBucket[2] or currentBucket[2][2] == 0 then
                animalData[farmId].chickenStock = animalData[farmId].chickenStock - (1 / 6)

                triggerClientEvent(farmPlayers[farmId], "syncChickenFoodAmount", client, animalData[farmId].chickenStock, farmId)
                setElementData(client, "currentBucket", {currentBucket[1], {"csirketap", 1}, true, 3000, farmId})

                dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)
                triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "tapki", farmId, 3000)
            elseif currentBucket[2][1] == "csirketap" then
                local val = (1 / 6) * currentBucket[2][2]

                animalData[farmId].chickenStock = animalData[farmId].chickenStock + val
                triggerClientEvent(farmPlayers[farmId], "syncChickenFoodAmount", client, animalData[farmId].chickenStock, farmId)
                setElementData(client, "currentBucket", {currentBucket[1], false, true, false, farmId})
                triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "tapvodorbe", farmId, 3000)

                dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)
            end
        end
    end
)

addEvent("getPelletToBucket", true)
addEventHandler("getPelletToBucket", getRootElement(),
    function()
        local farmId = getElementData(client, "currentFarm")

        if farmId then
            local currentBucket = getElementData(client, "currentBucket")

            if not currentBucket[2] or currentBucket[2][2] == 0 then
                animalData[farmId].otherStock = animalData[farmId].otherStock - (1 / 6)

                triggerClientEvent(farmPlayers[farmId], "syncOtherFoodAmount", client, animalData[farmId].otherStock, farmId)
                setElementData(client, "currentBucket", {currentBucket[1], {"pellet", 1}, true, 3000, farmId})

                dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)
                triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "tapki", farmId, 3000)
            elseif currentBucket[2][1] == "pellet" then
                local val = (1 / 6) * currentBucket[2][2]

                animalData[farmId].otherStock = animalData[farmId].otherStock + val
                triggerClientEvent(farmPlayers[farmId], "syncOtherFoodAmount", client, animalData[farmId].otherStock, farmId)
                setElementData(client, "currentBucket", {currentBucket[1], false, true, false, farmId})

                dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)
                triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "tapvodorbe", farmId, 3000)
            end
        end
    end
)

addEvent("putPelletInFeeder", true)
addEventHandler("putPelletInFeeder", getRootElement(),
    function()
        local farmId = getElementData(client, "currentFarm")
        local currentBucket = getElementData(client, "currentBucket")

        if farmId then
            if currentBucket[2][1] == "pellet" and animalData[farmId].food.otherFood < 255 then
                local addAmount = 255 / 4
                animalData[farmId].food.otherFood = animalData[farmId].food.otherFood + (addAmount * currentBucket[2][2])
                
                local muchNum = 0

                if animalData[farmId].food.otherFood > 255 then
                    muchNum = 255 / animalData[farmId].food.otherFood
                    animalData[farmId].food.otherFood = 255
                end

                triggerClientEvent(farmPlayers[farmId], "syncOtherFoodFeeder", client, animalData[farmId].food.otherFood, farmId)
                
                if muchNum > 0 then
                    setElementData(client, "currentBucket", {currentBucket[1], {"pellet", muchNum}, true, false, farmId})
                else
                    setElementData(client, "currentBucket", {currentBucket[1], false, true, false, farmId})
                end

                dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)
                triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "tapvodorbe", farmId, 3000)
            end
        end
    end
)

addEvent("putChickenFoodInFeeder", true)
addEventHandler("putChickenFoodInFeeder", getRootElement(),
    function()
        local farmId = getElementData(client, "currentFarm")
        local currentBucket = getElementData(client, "currentBucket")

        if farmId then
            if currentBucket[2][1] == "csirketap" and animalData[farmId].food.chickenFood < 255 then
                local addAmount = 255 / 2
                animalData[farmId].food.chickenFood = animalData[farmId].food.chickenFood + (addAmount * currentBucket[2][2])

                local muchNum = 0

                if animalData[farmId].food.chickenFood > 255 then
                    muchNum = 255 / animalData[farmId].food.chickenFood
                    animalData[farmId].food.chickenFood = 255
                end

                triggerClientEvent(farmPlayers[farmId], "syncChickenFoodFeeder", client, animalData[farmId].food.chickenFood, farmId)
                
                if muchNum > 0 then
                    setElementData(client, "currentBucket", {currentBucket[1], {"csirketap", muchNum}, true, false, farmId})
                else
                    setElementData(client, "currentBucket", {currentBucket[1], false, true, false, farmId})
                end

                dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)
                triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "tapvodorbe", farmId, 3000)
            end
        end
    end
)

addEvent("putWaterInOther", true)
addEventHandler("putWaterInOther", getRootElement(),
    function()
        local farmId = getElementData(client, "currentFarm")
        local currentBucket = getElementData(client, "currentBucket")

        if farmId then
            if currentBucket[2][1] == "water" and animalData[farmId].food.otherWater < 255 then
                local addAmount = 255 / 4
                animalData[farmId].food.otherWater = animalData[farmId].food.otherWater + (addAmount * currentBucket[2][2])

                if animalData[farmId].food.otherWater > 255 then
                    animalData[farmId].food.otherWater = 255
                end

                triggerClientEvent(farmPlayers[farmId], "syncOtherWater", client, animalData[farmId].food.otherWater, farmId)

                setElementData(client, "currentBucket", {currentBucket[1], false, true, false, farmId})

                dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)
                triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "waterout", farmId, 3000)
            end
        end
    end
)

addEvent("putWaterInChicken", true)
addEventHandler("putWaterInChicken", getRootElement(),
    function()
        local farmId = getElementData(client, "currentFarm")
        local currentBucket = getElementData(client, "currentBucket")

        if farmId then
            if currentBucket[2][1] == "water" and animalData[farmId].food.chickenWater < 255 then
                local addAmount = 255
                animalData[farmId].food.chickenWater = animalData[farmId].food.chickenWater + (addAmount * currentBucket[2][2])

                if animalData[farmId].food.chickenWater > 255 then
                    animalData[farmId].food.chickenWater = 255
                end

                triggerClientEvent(farmPlayers[farmId], "syncChickenWater", client, animalData[farmId].food.chickenWater, farmId)

                setElementData(client, "currentBucket", {currentBucket[1], false, true, false, farmId})

                dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)
                triggerClientEvent(farmPlayers[farmId], "playFarmSound", client, "waterout", farmId, 3000)
            end
        end
    end
)

addEvent("tryToResetTools", true)
addEventHandler("tryToResetTools", getRootElement(),
    function(farmId)
        local tempFurik = furikElements[farmId]
        local tempBucket = bucketElements[farmId]

        local x, y, z = bucketBasePoses[farmId][1], bucketBasePoses[farmId][2], bucketBasePoses[farmId][3]

        for k, v in pairs(getElementsByType("player")) do
            local bucket = getElementData(v, "currentBucket")
            local furik = getElementData(v, "currentFurik")
            
            if furik == tempFurik then
                removeElementData(v, "currentFurik")
            end

            if bucket and (bucket[1] == tempBucket) then
                if bucket[2] and bucket[2][1] == "csirketap" then
                    local val = (1 / 6) * bucket[2][2]

                    animalData[farmId].chickenStock = animalData[farmId].chickenStock + val
                    triggerClientEvent(farmPlayers[farmId], "syncChickenFoodAmount", resourceRoot, animalData[farmId].chickenStock, farmId)
                    setElementData(v, "currentBucket", {bucket[1], false, true, false, farmId})

                    dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)
                elseif bucket[2] and bucket[2][1] == "pellet" then
                    local val = (1 / 6) * bucket[2][2]

                    animalData[farmId].otherStock = animalData[farmId].otherStock + val
                    triggerClientEvent(farmPlayers[farmId], "syncOtherFoodAmount", resourceRoot, animalData[farmId].otherStock, farmId)
                    setElementData(v, "currentBucket", {bucket[1], false, true, false, farmId})

                    dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)
                elseif bucket[2] and bucket[2][1] == "water" then
                    setElementData(v, "currentBucket", {bucket[1], false, true, false, farmId})
                end

                exports.spattach:detach(bucket[1])
                setPedAnimation(v)
                local bucketData = getElementData(v, "currentBucket")
                
                setElementData(v, "currentBucket", nil)
                setElementData(bucket[1], "bucketData", bucketData)
            end
        end

        setElementPosition(tempFurik, furikBasePoses[farmId][1], furikBasePoses[farmId][2], furikBasePoses[farmId][3])
        setElementRotation(tempFurik, furikBasePoses[farmId][4], 0, 0)
        
        setElementPosition(tempBucket, x, y, z)
        setElementRotation(tempBucket, 0, 0, 0)
        setElementDimension(tempBucket, farmId)
    end
)

addEvent("getEggsFromCrate", true)
addEventHandler("getEggsFromCrate", getRootElement(),
    function(farmId, createId)
        if farmId and createId then
            if getPlayerPermission(farmId, client, "milkeggs", false) then
                local nemTudomMiez = 0
                triggerClientEvent(farmPlayers[farmId], "updateEggCrates", client, createId, nemTudomMiez, farmId)
                
                exports.sItems:giveItem(client, 587, animalData[farmId].eggCrates[createId])
                outputChatBox("#7cc576[SighMTA - Farm]: #ffffffBegyűjtöttél #7cc576" .. animalData[farmId].eggCrates[createId] .. " db #fffffftojást!", client, 255, 255, 255, true)
                animalData[farmId].eggCrates[createId] = 0

                setPedAnimation(client, "bomber", "bom_plant", -1, true, false, false)
                
                setTimer(function(client)
                    setPedAnimation(client, false)
                    triggerClientEvent(client, "freeUpFromTask", client)
                end, 3000, 1, client)
            end
        end 
    end
)

addEvent("startMilking", true)
addEventHandler("startMilking", getRootElement(),
    function(farmId, cowID)
        local bucketData = getElementData(client, "currentBucket")
        if getPlayerPermission(farmId, client, "milkeggs", false) then

            if 1 > (animalData[farmId].animals[cowID].milk or 0) then
                triggerClientEvent(client, "freeUpFromTask", client)
                return
            end

            if (bucketData and (bucketData[2] and bucketData[2][1] == "milk") or not bucketData[2]) then
                local bucketMilk = 0.5

                if bucketData[2] and bucketData[2][1] == "milk" and bucketData[2][2] then
                    bucketMilk = bucketMilk + bucketData[2][2]
                end

                setPedAnimation(client, "bomber", "bom_plant", -1, true, false, false)
                animalData[farmId].animals[cowID].milk = 0
                triggerClientEvent(farmPlayers[farmId], "updateCowMilk", client, cowID, animalData[farmId].animals[cowID].milk, farmId)

                setElementData(client, "currentBucket", {bucketData[1], {"milk", bucketMilk}, true, 3000, farmId})

                setTimer(function(client)
                    setPedAnimation(client, false)
                    triggerClientEvent(client, "freeUpFromTask", client)
                end, 3000, 1, client)
            else
                triggerClientEvent(client, "freeUpFromTask", client)
            end
        end
    end
)

addEvent("getMilkFromBucket", true)
addEventHandler("getMilkFromBucket", getRootElement(),
    function(farmId)
        if farmId then
            local bucketData = getElementData(client, "currentBucket")

            triggerClientEvent(farmPlayers[farmId], "bucketMilkAnim", client, farmId)
            setElementData(client, "currentBucket", {bucketData[1], false, true, false, farmId})
            
            local itemNum = 2

            if bucketData[2] and bucketData[2][2] then
                if bucketData[2][2] > 0.5 then
                    itemNum = 4
                end
            end

            exports.sItems:giveItem(client, 588, itemNum)
            outputChatBox("#7cc576[SighMTA - Farm]: #ffffffKimértél #7cc576" .. itemNum .. " üveg #fffffftejet!", client, 255, 255, 255, true)
            
            setTimer(function(client)
                setPedAnimation(client, false)
                triggerClientEvent(client, "freeUpFromTask", client)
            end, 3000, 1, client)
        end
    end
)

addEvent("checkCanSellAnimal", true)
addEventHandler("checkCanSellAnimal", getRootElement(),
    function(farmId)
        if farmId then
            if getPlayerPermission(farmId, client, "sellanimals", false) then
                if farmOrders[farmId] then
                    exports.sGui:showInfobox(client, "e", "Jelenleg van rendelésed!")
                else
                    triggerClientEvent(client, "gotAllowForAnimalSell", client)
                end
            end
        end
    end
)

addEvent("finalSellAnimals", true)
addEventHandler("finalSellAnimals", getRootElement(),
    function(farmId, animalTable)
        if farmId and animalTable then
            if getPlayerPermission(farmId, client, "sellanimals", false) then
                local animalNum = 0
                local animalId = 0
                local tempTable = {}

                for k, v in pairs(animalTable) do
                    animalNum = animalNum + 1
                    animalId = k

                    table.insert(tempTable, {animalData[farmId].animals[animalId].growth, animalData[farmId].animals[animalId].fat, animalData[farmId].animals[animalId].variation})
                end

                farmOrders[farmId] = {
                    [1] = "sellAnimal",
                    [2] = {animalData[farmId].animals[animalId].type, animalNum},
                    [3] = tempTable,
                    [4] = animalTable
                }

                local pos = farmDetails[farmId].loadpos
                sellMarkers[farmId] = createMarker(pos[1], pos[2], pos[3] - 1.5, "cylinder", 2.5, 124, 197, 118, 225, client)
                sellCols[farmId] = createColSphere(pos[1], pos[2], pos[3], 2)
                setElementData(sellCols[farmId], "farmSell", farmId)

                triggerClientEvent(client, "openShopPanel", client, farmOrders[farmId])
            end
        end
    end
)

addEvent("requestAnimalOrder", true)
addEventHandler("requestAnimalOrder", getRootElement(),
    function(farmId)
        if farmId then
            if getPlayerPermission(farmId, client, "buyanimals", false) then
                local orders = false

                if farmOrders[farmId] then
                    orders = farmOrders[farmId]
                end

                triggerClientEvent(client, "openShopPanel", client, orders)
            end
        end
    end
)

addEvent("cancelOrder", true)
addEventHandler("cancelOrder", getRootElement(),
    function(farmId)
        if farmId then
            if getPlayerPermission(farmId, client, "buyanimals", false) then
                farmOrders[farmId] = nil

                triggerClientEvent(client, "openShopPanel", client, farmOrders[farmId])
            end
        end
    end
)

addEvent("finalBuyHay", true)
addEventHandler("finalBuyHay", getRootElement(),  
    function(farmId, buyAmount)
        if farmId and buyAmount then
            farmOrders[farmId] = {
                [1] = "hay",
                [2] = buyAmount,
                [3] = false
            }
            
            triggerClientEvent(client, "openShopPanel", client, farmOrders[farmId])
            exports.sGui:showInfobox(client, "i", "Sikeresen megrendelted a szalmát. Menj el a mezőgazdasági nagykerbe egy utánfutóval!")
        end
    end
)

addEvent("finalOtherFoodBuy", true)
addEventHandler("finalOtherFoodBuy", getRootElement(),
    function(farmId, buyAmount)
        if farmId and buyAmount then
            farmOrders[farmId] = {
                [1] = "otherFood",
                [2] = buyAmount,
                [3] = false
            }

            triggerClientEvent(client, "openShopPanel", client, farmOrders[farmId])
            exports.sGui:showInfobox(client, "i", "Sikeresen megrendelted a tápot. Menj el a mezőgazdasági nagykerbe egy utánfutóval!")
        end
    end
)

addEvent("finalChickenFoodBuy", true)
addEventHandler("finalChickenFoodBuy", getRootElement(),
    function(farmId, buyAmount)
        if farmId and buyAmount then
            farmOrders[farmId] = {
                [1] = "chickenFood",
                [2] = buyAmount,
                [3] = false
            }

            triggerClientEvent(client, "openShopPanel", client, farmOrders[farmId])
            exports.sGui:showInfobox(client, "i", "Sikeresen megrendelted a tápot. Menj el a mezőgazdasági nagykerbe egy utánfutóval!")
        end
    end
)

addEvent("finalOrderAnimals", true)
addEventHandler("finalOrderAnimals", getRootElement(),
    function(farmId, animalName, order)
        if farmId and animalName and order then
            farmOrders[farmId] = {
                [1] = "animal",
                [2] = {animalName, order},
                [3] = false
            }

            triggerClientEvent(client, "openShopPanel", client, farmOrders[farmId])

            if #order > 1 then
                exports.sGui:showInfobox(client, "i", "Sikeresen megrendelted az állatokat. Menj el a mezőgazdasági nagykerbe egy utánfutóval!")
            else
                exports.sGui:showInfobox(client, "i", "Sikeresen megrendelted az állatot. Menj el a mezőgazdasági nagykerbe egy utánfutóval!")
            end
        end
    end
)

function getPlayerOrdersFarm(player)
    local tempTable = {}
    
    for k, v in pairs(farmDetails) do
        if v.type == 2 and v.rentedBy then
            if getPlayerPermission(k, player, "buyanimals", true, true) then
                table.insert(tempTable, k)
            end
        end
    end
    
    return tempTable
end

addEvent("checkOrderNpc", true)
addEventHandler("checkOrderNpc", getRootElement(),
    function(shop)
        local clientFarms = getPlayerOrdersFarm(client)
        local tempOrder = {}
        
        if shop then
            for k, v in pairs(clientFarms) do
                if farmOrders[v] and not farmOrders[v][3] then
                    table.insert(tempOrder, {
                        v,
                        farmDetails[v].tableText,
                        farmOrders[v][1],
                        farmOrders[v][2]
                    })
                end
            end
            
            triggerClientEvent(client, "orderNPCGot", client, tempOrder)
        else
            for k, v in pairs(clientFarms) do
                if farmOrders[v] and farmOrders[v][5] then
                    table.insert(tempOrder, {
                        v,
                        farmDetails[v].tableText,
                        farmOrders[v][1],
                        farmOrders[v][2]
                    })
                end
            end

            triggerClientEvent(client, "orderNPCGot", client, tempOrder)
        end
    end
)

addEvent("animalSellMinigameEnded", true)
addEventHandler("animalSellMinigameEnded", getRootElement(),
    function(farmId, minigameStat)
        if farmId and minigameStat then
            local price = 0
            
            for k, v in pairs(farmOrders[farmId][4]) do
                price = price + getAnimalPrice(farmId, k)
                table.remove(animalData[farmId].animals, k)
            end
            exports.sCore:giveMoney(client, math.floor(price * minigameStat))
            triggerClientEvent("refreshTrailerContents", farmOrders[farmId][5], {{farmOrders[farmId][5]}})
            
            trailerContents[farmOrders[farmId][5]] = nil
            farmOrders[farmId] = nil
         end
    end
)

addEvent("startShearing", true)
addEventHandler("startShearing", root, function(farmId, sheepId)
    if getPlayerPermission(farmId, client, "milkeggs", false) then
        if 1 > (animalData[farmId].animals[sheepId].wool or 0) then
            triggerClientEvent(client, "freeUpFromTask", client)
            return
        end

        setPedAnimation(client, "bomber", "bom_plant", -1, true, false, false)
        animalData[farmId].animals[sheepId].wool = 0
        triggerClientEvent(farmPlayers[farmId], "updateSheepWool", client, sheepId, animalData[farmId].animals[sheepId].wool, farmId)

        exports.sItems:giveItem(client, 585, 1)

        setTimer(function(client)
            setPedAnimation(client, false)
            triggerClientEvent(client, "freeUpFromTask", client)
        end, 5000, 1, client)
    end
end)


addEvent("loadUpOrder", true)
addEventHandler("loadUpOrder", getRootElement(),
    function(farmId, trailer, loadingOrderCol)
        if farmId and trailer and loadingOrderCol then
            if loadingOrderCol == 4 then
                local price = 0
                local animalNum = 0
                
                for k, v in pairs(farmOrders[farmId][4]) do
                    price = price + getAnimalPrice(farmId, k)
                    animalNum = animalNum + 1
                end
                
                triggerClientEvent(client, "startAnimalSelling2", client, farmId, price, 100, loadingOrderCol, animalNum)
            else
                local orderPrice = 0
                for k, v in pairs(farmOrders[farmId]) do
                    if type(v) == "table" then
                        for key, value in pairs(v[2]) do
                            orderPrice = orderPrice + value[4]
                        end
                    else
                        if k == 1 and v == "hay" then
                            orderPrice = balePrice * farmOrders[farmId][2] + orderPrice
                        end
                        if k == 1 and v == "otherFood" then
                            orderPrice = otherFoodPrice * farmOrders[farmId][2] + orderPrice
                        end
                        if k == 1 and v == "chickenFood" then
                            orderPrice = chickenFoodPrice * farmOrders[farmId][2] + orderPrice
                        end
                    end
                end
                local money = exports.sCore:getMoney(client)
                if money >= orderPrice then
                    exports.sCore:takeMoney(client, orderPrice)
                    farmOrders[farmId][3] = farmId

                    trailerContents[trailer] = {
                        [1] = trailer,
                        [2] = farmOrders[farmId],
                    }

                    local colX, colY, colZ = unpack(farmDetails[farmId].loadpos)

                    loadOutCols[farmId] = createColSphere(colX, colY, colZ, 2)
                    setElementData(loadOutCols[farmId], "loadOut", trailer)

                    triggerClientEvent("refreshTrailerContents", client, {trailerContents[trailer]})

                    local ordersName = false
                    local orderPrice = 0

                    if farmOrders[farmId][1] == "hay" then
                        if farmOrders[farmId][2] > 1 then
                            ordersName = "a szalmákat"
                        else
                            ordersName = "a szalmát"
                        end

                        orderPrice = balePrice * farmOrders[farmId][2]
                    elseif farmOrders[farmId][1] == "chickenFood" or farmOrders[farmId][1] == "otherFood" then
                        if farmOrders[farmId][2] > 1 then
                            ordersName = "a tápokat"
                        else
                            ordersName = "a tápot"
                        end

                        if farmOrders[farmId][1] == "otherFood" then
                            orderPrice = otherFoodPrice * farmOrders[farmId][2]
                        else
                            orderPrice = chickenFoodPrice * farmOrders[farmId][2]
                        end

                    elseif farmOrders[farmId][1] == "animal" then
                        if #farmOrders[farmId][2][2] > 1 then
                            ordersName = "az állatokat"
                        else
                            ordersName = "az állatot"
                        end
                    end

                    if ordersName then
                        exports.sGui:showInfobox(client, "i", "Sikeresen felpakoltad " .. ordersName .. ". Vidd el a farmra!")
                    end

                    setElementVelocity(trailer, 0, 0, -0.05)
                else
                    exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
                end
            end
        end
    end
)

addEventHandler("onElementDimensionChange", getRootElement(), 
    function(oldDim, newDim)
        if newDim then
            if getElementType(source) == "player" then
                local bucketState = getElementData(source, "currentBucket")
                local create = getElementData(source, "currentCrate")    
            
                
                if bucketState and bucketState[1] then
                    setElementDimension(bucketState[1], newDim)
                elseif create then
                    setElementDimension(create, newDim)
                end
            end
        end
    end
)

addEventHandler("onVehicleStartEnter", getRootElement(), 
    function(thePlayer)
        if thePlayer then
            if getElementData(thePlayer, "currentBucket") or getElementData(thePlayer, "currentFurik") then
                cancelEvent()
            end
        end
    end
)

addEventHandler("onColShapeHit", resourceRoot,
    function(hitElement, matchingDimension)
        if matchingDimension then
            if hitElement and getElementType(hitElement) == "vehicle" then
                if getElementModel(hitElement) == 611 then
                    if getElementData(source, "loadOut") == hitElement then
                        if trailerContents[hitElement] then
                            local trailerLod = trailerContents[hitElement][2]

                            if trailerLod then
                                local farmId = trailerLod[3]

                                if farmId then
                                    if trailerLod[1] == "hay" then
                                        animalData[farmId].hay = animalData[farmId].hay + trailerLod[2]

                                        triggerClientEvent(farmPlayers[farmId], "syncHayAmount", resourceRoot, animalData[farmId].hay, farmId)
                                    elseif trailerLod[1] == "chickenFood" then
                                        animalData[farmId].chickenStock = animalData[farmId].chickenStock + trailerLod[2]
                                        
                                        triggerClientEvent(farmPlayers[farmId], "syncChickenFoodAmount", resourceRoot, animalData[farmId].chickenStock, farmId)
                                    elseif trailerLod[1] == "otherFood" then
                                        animalData[farmId].otherStock = animalData[farmId].otherStock + trailerLod[2]

                                        triggerClientEvent(farmPlayers[farmId], "syncOtherFoodAmount", resourceRoot, animalData[farmId].otherStock, farmId)
                                    elseif trailerLod[1] == "animal" then
                                        local animalName, animalStats = trailerLod[2][1], trailerLod[2][2]

                                        for k, v in pairs(animalStats) do
                                            local growth, fat, variation = unpack(v)

                                            local animalTable = newAnimal(animalName, variation, growth, fat)

                                            table.insert(animalData[farmId].animals, animalTable)

                                            if not animalPositions[farmId] then
                                                animalPositions[farmId] = {}
                                            end
                                            
                                            table.insert(animalPositions[farmId], {0, 0, 1, 0, 1})
                                        end
                                    end

                                    dbExec(connection, "UPDATE farms SET animalDatas = ? WHERE farmId = ?", animalDataToJson(animalData[farmId]), farmId)

                                    farmOrders[farmId] = nil

                                    if loadOutCols[farmId] then
                                        if isElement(loadOutCols[farmId]) then
                                            destroyElement(loadOutCols[farmId])
                                        end
                                        
                                        loadOutCols[farmId] = nil
                                    end
                                end
                            end
                            
                            trailerContents[hitElement] = nil
                            
                            triggerClientEvent("refreshTrailerContents", hitElement, {{hitElement}})
                        end
                    elseif getElementData(source, "farmSell") then
                        if trailerContents[hitElement] then

                        else
                            outputChatBox("halo valaki belment a col ba helo")
                            
                            local vehicle = getVehicleTowingVehicle(hitElement)

                            if vehicle then
                                local controller = getVehicleController(vehicle)

                                if controller then
                                    local farmId = getElementData(source, "farmSell")

                                    if farmId then
                                        if getPlayerPermission(farmId, controller, "sellanimals", true, true) then
                                            trailerContents[hitElement] = {
                                                [1] = hitElement,
                                                [2] = {
                                                    [1] = "animal",
                                                    [2] = {farmOrders[farmId][2][1], farmOrders[farmId][3]}
                                                },
                                            }

                                            farmOrders[farmId][5] = hitElement
                                            
                                            destroyElement(sellMarkers[farmId])
                                            destroyElement(sellCols[farmId])

                                            triggerClientEvent("refreshTrailerContents", controller, {trailerContents[hitElement]})

                                            for k, v in pairs(farmOrders[farmId][4]) do
                                                animalData[farmId].animals[k].forSale = true
                                            end
                                        else
                                            
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
)

function refreshAnimalsPosition(farmId, skipSync)
    local currentTick = getTickCount()
    local farmId = tonumber((farmId))

    if farmId then
        local farmData = farmDetails[farmId]

        if farmData then
            local livestockData = farmData.livestockData

            if not farmData.livestockData then
                farmData.livestockData = {}
                livestockData = farmData.livestockData
            end

            if livestockData then
                local farmSize = farmDetails[farmId].size
                local landSizeX, landSizeY = farmSizeDetails[farmSize].size[1], farmSizeDetails[farmSize].size[2]

                if not livestockData.animalsPosition then
                    livestockData.animalsPosition = {}
                end

                local animalsToRefresh = {}

                if #animalData[farmId].animals > 0 then
                    local possibleAnimals = {}

                    for i = 1, #animalData[farmId].animals do
                        local animalData = animalData[farmId].animals[i]

                        if animalData then
                            local wasAnimalPosition = livestockData.animalsPosition[i] ~= nil

                            if not wasAnimalPosition then
                                table.insert(animalsToRefresh, i)
                            elseif animalData.isForSale ~= "transporting" then
                                table.insert(possibleAnimals, i)
                            end
                        end
                    end

                    if #possibleAnimals > 0 then
                        local numAnimalsToRefresh = math.random(1, math.min(8, #possibleAnimals))

                        for i = 1, numAnimalsToRefresh do
                            local animalIndex = table.remove(possibleAnimals, math.random(1, #possibleAnimals))

                            if animalIndex then
                                table.insert(animalsToRefresh, animalIndex)
                            end
                        end
                    end
                end

                for i = 1, #animalsToRefresh do
                    local animalIndex = animalsToRefresh[i]

                    if animalIndex then
                        local animalData = animalData[farmId].animals[animalIndex]

                        if animalData then
                            local animalTypeInfo = animalTypes[animalData.type]

                            if animalTypeInfo then
                                local rangeMinX = animalTypeInfo.moveRange[1]
                                local rangeMinY = animalTypeInfo.moveRange[2]

                                local rangeMaxX = animalTypeInfo.moveRange[3]
                                local rangeMaxY = animalTypeInfo.moveRange[4]

                                livestockData.animalsPosition[animalIndex] = {
                                    getInterpolatedValue(rangeMinX, rangeMaxX, math.random()),
                                    getInterpolatedValue(rangeMinY, rangeMaxY, math.random()),
                                    getInterpolatedValue(0.25, 1.25, 1 - animalData.growth),
                                    5000 / #animalsToRefresh * i,
                                    math.random(0, 2),
                                    currentTick,
                                }
                            end
                        end
                    end
                end
                
                if #farmPlayers[farmId] > 0 then
                    if not skipSync then
                        triggerClientEvent(farmPlayers[farmId], "updateFarmAnimalPositions", resourceRoot, livestockData.animalsPosition, farmId)
                    end

                    if not farmAnimalsMoveTimer[farmId] then
                        farmAnimalsMoveTimer[farmId] = setTimer(refreshAnimalsPosition, 5000, 0, farmId)
                    end
                else
                    if farmAnimalsMoveTimer[farmId] then
                        if isTimer(farmAnimalsMoveTimer[farmId]) then
                            killTimer(farmAnimalsMoveTimer[farmId])
                        end

                        farmAnimalsMoveTimer[farmId] = nil
                    end
                end
            end
        end
    end
end

function getInterpolatedValue(rangeMinX, rangeMaxX, t)
    return rangeMinX * (1 - t) + rangeMaxX * t
end

function getAnimalPrice(farmId, tableId)
    local price = 0
    local animals = animalData[farmId].animals

    if 1 <= ((animals[tableId] and animals[tableId].growth) or 100) then
        local sellPrice = animalTypes[animals[tableId].type].sellPrice
        local life = math.min(1, animals[tableId].life / animalTypes[animals[tableId].type].lifeExpectancy)
        local tmp = animals[tableId].fat * 2 + animals[tableId].health * 5 + animals[tableId].mood * 0.5 + math.max(0, 1 - animals[tableId].moodMinus) * 3

        tmp = tmp / 10.5
        if life > 0.65 then
            life = (life - 0.65) / 0.35
            life = 1 - life
            tmp = tmp * life
        end
        
        tmp = math.floor(sellPrice * (tmp * 0.8 + 0.2))
        
        return tmp
    end
end

addEvent("makeMilkaCow", true)
addEventHandler("makeMilkaCow", root, function(farmId, cowId)
    animalData[farmId].animals[cowId].variation = 1
    triggerClientEvent(farmPlayers[farmId], "refreshCowVariation", resourceRoot, farmId, cowId, 1)
    saveFarm(farmId)

    local itemData = exports.sItems:findPrimaryItem(client)
    exports.sItems:takeItem(client, "dbID", itemData.dbID)
end)