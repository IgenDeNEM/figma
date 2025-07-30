local dropOffBlips = {}
local dropOffCols = {}
local dropOffInts = {}
local dropOffPeds = {}

local deletingProcess = {}
local deliveryList = {}
local acceptedDeliveries = {}
local deliveryTimers = {}

local subscribedPlayers = {}
local bannedPlayers = {}
local nextId = 1

local eventInteriors = {}

addEventHandler("onResourceStart", root, function(startedResource)
    local resName = getResourceName(startedResource)
    if resName == "sInteriors" then
        eventInteriors = exports.sInteriors:getPlayerInteriors()
    end
end)

local eventInteriors = {
    --Interior ID, Rotation
    {72, 324},  -- Faház
    {108, 180}, -- Feldolgozó üzem
    {109, 90}   -- Blueberry ház
    --beírni majd még ha lesz több inti
}

function selectRandomItem()
    local totalWeight = 0
    local weightedItems = {}

    for i = 1, #wantedItems do
        local item = wantedItems[i]
        totalWeight = totalWeight + item[6]
        table.insert(weightedItems, {
            data = item,
            weight = item[6]
        })
    end

    local rand = math.random() * totalWeight
    local accum = 0
    local selectedItem = nil

    for _, entry in ipairs(weightedItems) do
        accum = accum + entry.weight
        if rand <= accum then
            selectedItem = entry.data
            break
        end
    end

    if not selectedItem then
        return nil
    end

    local amount = 1
    if selectedItem[7] == "ammo" then
        amount = math.random(selectedItem[2], selectedItem[3])
    end

    local price = math.random(selectedItem[4], selectedItem[5])

    local warnMessage = false
    if selectedItem[7] ~= "ammo" then
        warnMessage = math.random(1, #warnMessages[selectedItem[7]])
    end

    return {
        itemID = selectedItem[1],
        amount = amount,
        price = price,
        multiplier = selectedItem[6],
        warnmsg = warnMessage,
        category = selectedItem[7]
    }
end

function handleDeliveryList()
    for i = 1, 15 do
        if not deliveryList[i] then
            local selectedItem = selectRandomItem()
            deliveryList[i] = {
                valid = getTickCount() + math.random(250000, 1200000), 
                itemId = selectedItem.itemID, 
                amount = selectedItem.amount, 
                price = selectedItem.amount * selectedItem.price, 
                id = i, 
                msg = math.random(1, #adMessages),
                wmsg = selectedItem.warnmsg,
                category = selectedItem.category
            }

            for playerElement, playerData in pairs(subscribedPlayers) do
                local playerIdentity = getElementData(playerElement, "char.ID") or false
                if playerIdentity and not (bannedPlayers[playerIdentity] or false) then
                    triggerClientEvent(playerElement, "createNewDealerAdvertisement", playerElement, getTickCount(), deliveryList[i])
                end
            end
        elseif deliveryList[i] then
            local remainingTime = deliveryList[i].valid
            if remainingTime <= getTickCount() then
                deliveryList[i] = nil
            end
        end
    end
end

setTimer(handleDeliveryList, 1000, 0)
addEvent("removeDealerAdvertisementSubscription", true)
addEventHandler("removeDealerAdvertisementSubscription", root, function()
    if client and client == source then
        subscribedPlayers[client] = nil
    end
end)

addEvent("tryToStartDealerDelivery", true)
addEventHandler("tryToStartDealerDelivery", root, function(deliveryId)
    if client and client == source then
        if deletingProcess[client] then
            triggerClientEvent(client, "updateDealerDelivery", client, false, false)
            exports.sGui:showInfobox(client, "e", "Várj egy kicsit!")
            return
        end

        if deliveryList[deliveryId] then
            deliveryList[deliveryId].respone = math.random(1, #responseMessages)
            deliveryList[deliveryId].buyerResponse = math.random(1, #buyerResponseMessages)
            deliveryList[deliveryId].valid = ((deliveryList[deliveryId].valid - getTickCount()) / 1000) + math.random(850, 1500)
            deliveryList[deliveryId].started = getRealTime().timestamp

            local playerId = getElementData(client, "char.ID")

            deliveryTimers[playerId] = setTimer(function(playerElement, playerIdentity)
                if playerElement and isElement(playerElement) then
                    exports.sGui:showInfobox(playerElement, "e", "Mivel nem teljesítetted időben a feladatot, ezért kitiltottak 24 órára a marketről!")
                    triggerClientEvent(playerElement, "dealerAdvertisementSubscriptionFail", playerElement, getRealTime().timestamp + 86400)                    
                    triggerClientEvent(playerElement, "updateDealerDelivery", playerElement, false, false)

                    subscribedPlayers[playerElement] = nil
                    cleanupMarketDeal(playerElement)
                end
                
                bannedPlayers[playerIdentity] = getRealTime().timestamp
            end, deliveryList[deliveryId].valid * 1000, 1, client, playerId)

            deliveryList[deliveryId].seller = client

            if not acceptedDeliveries[playerId] then
                acceptedDeliveries[playerId] = {}
            end
            acceptedDeliveries[playerId] = deliveryList[deliveryId]
            deliveryList[deliveryId] = false

            local randomInt = math.random(1, #eventInteriors)
            local interior = eventInteriors[randomInt][1]
            local rotation = eventInteriors[randomInt][2]

            acceptedDeliveries[playerId].interiorId = interior

            local sellerResponseMessage = formatResponseMessage(acceptedDeliveries[playerId])
            local buyerResponseMessage = formatBuyerResponseMessage(acceptedDeliveries[playerId])
            local textLength = utf8.len(sellerResponseMessage) * 75
            local totalTime = (textLength * (0.75 + 0.25 * math.random())) + (textLength * (0.75 + 0.25 * math.random()) / 3) + (300 + 600 * math.random()) + (utf8.len(buyerResponseMessage) * 75 * (0.75 + 0.25 * math.random()))
            triggerClientEvent("removeDealerAdvertisement", client, deliveryId)

            triggerClientEvent(client, "updateDealerDelivery", client, acceptedDeliveries[playerId], true)

            setTimer(function(playerElement)
                local x, y, z = exports.sInteriors:getInteriorOutsidePosition(interior)
                dropOffBlips[playerElement] = createBlip(x, y, z, 33, 2, 78, 205, 196, 255, 0, 99999, playerElement)
                
                setElementData(dropOffBlips[playerElement], "tooltipText", "SightNion Market megbízás ("..eventInteriors[randomInt][1]..")")
                setElementData(dropOffBlips[playerElement], "disableBlipSticky", true)

                dropOffCols[playerElement] = createColSphere(x, y, z, 1)
                dropOffInts[playerElement] = {interior, rotation}

                triggerClientEvent(playerElement, "markEventInterior", playerElement, interior, "nionmarket")
            end, totalTime, 1, client)
        end
    end
end)

addEvent("addDealerAdvertisementSubscription", true)
addEventHandler("addDealerAdvertisementSubscription", root, function()
    if client and client == source then
        local playerId = getElementData(client, "char.ID")
        if bannedPlayers[playerId] then
            if bannedPlayers[playerId] + 86400 <= getRealTime().timestamp then
                bannedPlayers[playerId] = false
            end
        end

        if not bannedPlayers[playerId] then
            subscribedPlayers[client] = true
            triggerClientEvent(client, "sendDealerAdvertisementList", client, getTickCount(), deliveryList)
        else
            triggerClientEvent(client, "dealerAdvertisementSubscriptionFail", client, bannedPlayers[playerId] + 86400)
        end
    end
end)

local availableSkins = {
--Női
    11,
    12,
    13,
    93,
    100,
    140,
    145,
    190,
    199,
    211,
--Férfi
    1,
    2,
    7,
    10,
    17,
    18,
    19,
    21,
    23,
    24,
    27,
    28,
    29,
    30,
    36,
    39,
    46,
    47,
    48,
    49,
    51,
    52,
    53,
    59,
    60,
    61,
    75,
    84,
    87,
    88,
    98,
    101,
    102,
    109,
    110,
    111,
    112,
    115,
    116,
    120,
    124,
    125,
    126,
    127,
    130,
    132,
    134,
    144,
    155,
    163,
    170,
    186,
    201,
    203,
    212,
    264,
    290,
    292
}

function getDealDetails(playerElement)
    local playerId = getElementData(playerElement, "char.ID")
    return acceptedDeliveries[playerId] and acceptedDeliveries[playerId] or false
end

local chatAnims = {
  {
    "GANGS",
    "prtial_gngtlkA"
  },
  {
    "GANGS",
    "prtial_gngtlkB"
  },
  {
    "GANGS",
    "prtial_gngtlkC"
  },
  {
    "GANGS",
    "prtial_gngtlkD"
  },
  {
    "GANGS",
    "prtial_gngtlkE"
  },
  {
    "GANGS",
    "prtial_gngtlkF"
  },
  {
    "GANGS",
    "prtial_gngtlkG"
  },
  {
    "GANGS",
    "prtial_gngtlkH"
  },
}
local hitColshapes = {}

addEventHandler("onColShapeHit", root, function(playerElement, matchingDimension)
    if playerElement and getElementType(playerElement) == "player" then
        if dropOffCols[playerElement] and source == dropOffCols[playerElement] and not dropOffPeds[playerElement] and not (hitColshapes[playerElement] or false) then
            exports.sGui:showInfobox(playerElement, "i", "Várd meg amíg a vevő kijön a házból, majd húzd rá az eladni kívánt tárgyat.")
            triggerClientEvent(getRootElement(), "playInteriorKnock", playerElement, dropOffInts[playerElement][1])
            
            hitColshapes[playerElement] = true

            setTimer(function(playerElement)
                local intPosition = {exports.sInteriors:getInteriorOutsidePosition(dropOffInts[playerElement][1])}
                local playerPosition = {getElementPosition(playerElement)}
                
                local pedRotation = math.deg(math.atan2(playerPosition[2] - intPosition[2], playerPosition[1] - intPosition[1])) + 270

                dropOffPeds[playerElement] = createPed(availableSkins[math.random(1, #availableSkins)], intPosition[1], intPosition[2], intPosition[3], pedRotation)
                setElementData(dropOffPeds[playerElement], "visibleName", "Ismeretlen vevő")
                setElementData(dropOffPeds[playerElement], "sightmarket:buyerped", getElementData(playerElement, "char.ID"))
                setElementFrozen(dropOffPeds[playerElement], true)

                local selectedAnimation = math.random(#chatAnims)
                local animData = chatAnims[selectedAnimation]

                setTimer(function(playerElem)
                    setPedAnimation(dropOffPeds[playerElem], animData[1], animData[2], math.random(150, 300), false, false, true)
                    triggerClientEvent("npcChatBubble", dropOffPeds[playerElem], "say", welcomeMessages[math.random(#welcomeMessages)])
                end, 500, 1, playerElement)
            end, math.random(3000, 8000), 1, playerElement)
        end
    end
end)


function cleanupMarketDeal(playerElement)
    local playerId = getElementData(playerElement, "char.ID")

    if isElement(dropOffPeds[playerElement]) then
        destroyElement(dropOffPeds[playerElement])
        dropOffPeds[playerElement] = false
    end

    if isElement(dropOffCols[playerElement]) then
        destroyElement(dropOffCols[playerElement])
        dropOffCols[playerElement] = false
    end

    if isElement(dropOffBlips[playerElement]) then
        destroyElement(dropOffBlips[playerElement])
        dropOffBlips[playerElement] = false
    end

    acceptedDeliveries[playerId] = false
    hitColshapes[playerElement] = false
    dropOffInts[playerElement] = false
    deletingProcess[playerElement] = false
end

addEvent("gotDealStatus", false)
addEventHandler("gotDealStatus", root, function(status, state)
    local playerId = getElementData(source, "char.ID")
    local deliveryData = acceptedDeliveries[playerId]
    if deliveryData then
        if status then
            local price = deliveryData.price or false

            if deliveryData.category == "weapon" then
                local responseMessage = successResponseMessages[math.random(1, #successResponseMessages)]
                triggerClientEvent("npcChatBubble", dropOffPeds[source], "say", responseMessage)
                if state and state ~= 0 then
                    price = math.floor(deliveryData.price * ((100 - state) / 100))
                    exports.sGui:showInfobox(source, "s", "Sikeresen teljesítetted a megbízást. A vevőtől "..exports.sGui:thousandsStepper(price).."$ összeget kaptál.")
                    exports.sGui:showInfobox(source, "w", "Mivel a fegyver nem 100%-os volt, ezért nem teljes árat fizetett a vásárló!")
                else
                    exports.sGui:showInfobox(source, "s", "Sikeresen teljesítetted a megbízást. A vevőtől "..exports.sGui:thousandsStepper(price).."$ összeget kaptál.")
                end
            else
                local responseMessage = successResponseMessages[math.random(1, #successResponseMessages)]
                triggerClientEvent("npcChatBubble", dropOffPeds[source], "say", responseMessage)
            end

            local playerId = getElementData(source, "char.ID")
            if isTimer(deliveryTimers[playerId]) then
                killTimer(deliveryTimers[playerId])
            end

            deliveryTimers[playerId] = nil

            exports.sCore:giveMoney(source, price)

            deletingProcess[source] = true

            setTimer(function(playerElement)
                triggerClientEvent(playerElement, "deMarkEventInterior", playerElement, deliveryData.interiorId)
                cleanupMarketDeal(playerElement)
            end, 5000, 1, source)
            triggerClientEvent(source, "updateDealerDelivery", source, false, false)
        else
            local failResponseMessage = formatFailResponseMessage(deliveryData)

            setTimer(function(responseMessage, playerElement)
                triggerClientEvent("npcChatBubble", dropOffPeds[playerElement], "say", responseMessage)
            end, 50, 1, failResponseMessage, source)
        end
    end
end)