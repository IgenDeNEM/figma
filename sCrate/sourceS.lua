local openingCrates = {}

addEvent("syncCrateFlexPos", true)
addEventHandler("syncCrateFlexPos", root, 
    function(syncList, flexX, flexY, syncTime, cutting, flexNX, flexNY)
        triggerClientEvent(syncList, "syncCrateFlexPos", client, flexX, flexY, syncTime, cutting, flexNX, flexNY)
    end
)

addEvent("rotateCrateOpening", true)
addEventHandler("rotateCrateOpening", root, 
    function(syncList, rot)
        triggerClientEvent(syncList, "rotateCrateOpening", client, rot)
    end
)

addEvent("tryToExitCrateOpening", true)
addEventHandler("tryToExitCrateOpening", root, 
    function(syncList, flexX, syncTime, cutting, flexNX, flexNY)
        triggerClientEvent(client, "endCrateOpening", client, nil, nil, nil, nil)
        triggerClientEvent("clientCrateOpeningState", client)
        setElementFrozen(client, false)
        exports.sClothesshop:storePlayerClothes(client)
        openingCrates[client] = nil
    end
)

addEvent("syncCrateOpened", true)
addEventHandler("syncCrateOpened", root, 
    function(syncList, atm)
        local playerOpeningData = openingCrates[client]

        if atm then
            triggerClientEvent(syncList, "syncCrateOpened", client, nil, atm, playerOpeningData[3])

            local playerMoney = exports.sCore:getMoney(client)

            exports.sCore:setMoney(client, playerMoney + playerOpeningData[3])

            exports.sItems:takeItem(client, "dbID", playerOpeningData[2], 1)
        else
            if playerOpeningData[3] then
                setElementData(client, "facePaint", 180)

                triggerClientEvent(syncList, "syncCrateOpened", client, nil, atm, playerOpeningData[3])
                
                exports.sItems:takeItem(client, "dbID", playerOpeningData[2], 1)
            else
                triggerClientEvent(syncList, "syncCrateOpened", client, playerOpeningData[4], atm)

                for i = 1, #playerOpeningData[4] do
                    setTimer(function(client, crateData)
                        if crateData[1] == 299 then
                            exports.sItems:giveItem(client, crateData[1], crateData[2], false, bpIds[math.random(1, #bpIds)])
                            exports.sGui:showInfobox(client, "s", "Kivettél egy tárgyat a ládából: " .. crateData[2] .. " db " .. exports.sItems:getItemName(crateData[1]))
                        else
                            if crateData[3] == "weapon" then
                                exports.sItems:giveItem(client, crateData[1], crateData[2], false, math.random(30, 70))
                            else
                                exports.sItems:giveItem(client, crateData[1], crateData[2])
                            end
                            exports.sGui:showInfobox(client, "s", "Kivettél egy tárgyat a ládából: " .. crateData[2] .. " db " .. exports.sItems:getItemName(crateData[1]))
                        end
                    end, 10000 + 500 * i, 1, client, playerOpeningData[4][i])
                end
                exports.sItems:takeItem(client, "dbID", playerOpeningData[2], 1)
            end
        end
        setTimer(function(client)
            triggerClientEvent("clientCrateOpeningState", client)
            exports.sClothesshop:storePlayerClothes(client)
        end, 10000, 1, client)
        openingCrates[client] = nil
    end
)

function startCrateOpening(element, crateType, openingPlace, dbID)
    if openingCrates[element] then
        return
    end
    local atmMoney = false

    if crateType == "atm" then
        atmMoney = math.random(75000, 150000)
    end

    openingCrates[element] = {crateType, dbID, atmMoney, false}

    local crItems = {}

    if crateType ~= "atm" then
        local randomOverAllItemMin = crateItemNum[crateType][1]
        local randomOverAllItemMax = crateItemNum[crateType][2]
        for i = 1, math.random(randomOverAllItemMin, randomOverAllItemMax) do
            if not crItems[i] then
                crItems[i] = {}
            end
            crItems[i][1] = pickItem(crateType)
            if lootAmounts[crItems[i][1]] then
                itemRandomNum = math.random(lootAmounts[crItems[i][1]][1], lootAmounts[crItems[i][1]][2])
            else
                itemRandomNum = 1
            end
            crItems[i][2] = itemRandomNum
            crItems[i][3] = crateType
        end
        openingCrates[element][4] = crItems
    end


    local syncList = getElementsByType("player")
    for _, playerElement in pairs(syncList) do
        if playerElement ~= element then
            triggerClientEvent(playerElement, "clientCrateOpeningState", element, openingPlace, crateType, 0)
        end
    end
    exports.sClothesshop:processPlayerWeaponItems(exports.sItems:getElementItems(element), element, true)

    triggerClientEvent(element, "startCrateOpening", element, openingPlace, crateType, 0, crateType ~= "atm" and crItems or {}, crateType == "atm" and atmMoney)
end