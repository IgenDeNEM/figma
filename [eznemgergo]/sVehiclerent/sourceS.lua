local playerWhoTriggered = {}
local rentedVehicles = {}
local vehiclePositions = {
    [1] = {1560.0399169922, -2322.466796875, 13.237958908081}
}

local renewTime = 60000 * 10
local declineRenew = 60000

local rentTimers = {}
local warnTimers = {}
local deleteTimers = {}

local rentableVehicles = {
	[1] = { -- Volkswagen Golf I
        vehicleModel = 410,
        vehiclePrice = 1200,
        cautionAmount = 2000,
        "Kompakt és legendás.",
	},
	[2] = { -- Mercedes-Benz 300 SEL
        vehicleModel = 516,
        vehiclePrice = 1800,
        cautionAmount = 3000,
        "Elegáns és időtálló.",
	},
    [3] = { -- BMW M5
        vehicleModel = 445,
        vehiclePrice = 3000,
        cautionAmount = 5000,
		"Erő és luxus egyben.",
	},
    [4] = { -- Model S
        vehicleName = "Tesla Model S",
        vehiclePrice = 300,
        vehicleModel = "model_s",
        isPremium = true,
        cautionAmount = 8000,
		"Modern és villámgyors.",
	},
}

addEvent("requestRentableVehicles", true)
addEventHandler("requestRentableVehicles", getRootElement(), function()
    if client and client == source then
        if not playerWhoTriggered[client] then
            triggerLatentClientEvent(client, "gotRentableVehicles", client, rentableVehicles)
        else
            exports.sAnticheat:anticheatBan(client, "AC #82 - sVehiclerent @sourceS:49")
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #83 - sVehiclerent @sourceS:52")
    end
end)

local waitForReconnect = {}

addEventHandler("onPlayerQuit", root, function()
    if source and isElement(source) and rentTimers[source] then
        setTimerPaused(rentTimers[source], true)

        waitForReconnect[source] = setTimer(function(client)
            local rentDetails = rentedVehicles[client]

            rentTimers[client] = false
            destroyElement(rentDetails.vehElement)
            rentedVehicles[client] = false
        end, 60000 * 15, 1, source)
    end
end)

addEventHandler("onElementDataChange", root, function(eData, _, newValue)
    if source and getElementType(source) == "player" then
        if eData and eData == "loggedIn" then
            if newValue then
                if waitForReconnect[source] then
                    killTimer(waitForReconnect[source])
                    waitForReconnect[source] = false
                    setTimerPaused(rentTimers[source], false)
                end
            end
        end
    end
end)

local function getTableSize(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

function getRentedOwner(vehicleElement, playerElement)
    if vehicleElement and playerElement then
        local type = getElementType
        if type(vehicleElement) == "vehicle" and type(playerElement) == "player" then
            if rentedVehicles[playerElement] and rentedVehicles[playerElement].activeRent then
                if rentedVehicles[playerElement].vehElement == vehicleElement then
                    return true
                end
            end
        else
        end
    end
    return false
end

local function findVehicleDetails(vehicleElement)
    for vehicleIndex, vehicleData in pairs(rentableVehicles) do
        if vehicleData.vehicleModel == getElementModel(vehicleElement) or vehicleData.vehicleModel == getElementData(vehicleElement, "vehicle.customModel") then
            return vehicleData
        end
    end
    return false
end

local function findVehicleDetailsByModel(vehicleModel)
    for vehicleIndex, vehicleData in pairs(rentableVehicles) do
        if vehicleData.vehicleModel == vehicleModel then
            return vehicleData
        end
    end
    return false
end

addEvent("continueVehicleRent", true)
addEventHandler("continueVehicleRent", getRootElement(), function()
    if client and client == source then
        if rentedVehicles[client] and rentedVehicles[client].activeRent then
            local rentDetails = rentedVehicles[client]
            local rentedVehicle = rentDetails.vehElement
            if rentedVehicle and isElement(rentedVehicle) then
                local vehicleData = findVehicleDetails(rentedVehicle)
                local vehiclePrice = vehicleData.vehiclePrice
                local priceType = vehicleData.isPremium

                local playerCurrency
                if priceType then
                    playerCurrency = exports.sCore:getPP(client)
                    if playerCurrency >= vehicleData.vehiclePrice then
                        exports.sCore:takePP(client, vehicleData.vehiclePrice)
                        triggerClientEvent(client, "continueRentResponse", client, true)

                        if isTimer(deleteTimers[client]) then
                            killTimer(deleteTimers[client])
                        end

                        if isTimer(warnTimers[client]) then
                            killTimer(warnTimers[client])
                        end

                        rentTimers[client] = setTimer(function(playerElement, vehDetails)
                            triggerClientEvent(playerElement, "tryToRenewRent", playerElement, vehDetails)

                            warnTimers[playerElement] = setTimer(function(playerElement)
                                exports.sGui:showInfobox(playerElement, "e", "A bérelt járműved 10 másodpercen belül törlődni fog, amennyiben nem hosszabítod meg.")
                            end, 50000, 1, playerElement)

                            deleteTimers[playerElement] = setTimer(function(playerElement)
                                triggerEvent("stopVehicleRent", playerElement, true)
                                triggerClientEvent(playerElement, "continueRentResponse", playerElement, false, true)
                            end, declineRenew, 1, playerElement)
                        end, renewTime, 1, client, rentedVehicles[client])
                    else
                        triggerClientEvent(client, "continueRentResponse", client, false)
                    end
                else
                    playerCurrency = exports.sCore:getMoney(client)
                    if playerCurrency >= vehicleData.vehiclePrice then
                        exports.sCore:takeMoney(client, vehicleData.vehiclePrice)
                        triggerClientEvent(client, "continueRentResponse", client, true)

                        if isTimer(deleteTimers[client]) then
                            killTimer(deleteTimers[client])
                        end

                        if isTimer(warnTimers[client]) then
                            killTimer(warnTimers[client])
                        end

                        rentTimers[client] = setTimer(function(playerElement, vehDetails)
                            triggerClientEvent(playerElement, "tryToRenewRent", playerElement, vehDetails)
                            
                            warnTimers[playerElement] = setTimer(function(playerElement)
                                exports.sGui:showInfobox(playerElement, "e", "A bérelt járműved 10 másodpercen belül törlődni fog, amennyiben nem hosszabítod meg.")
                            end, 50000, 1, playerElement)

                            deleteTimers[playerElement] = setTimer(function(playerElement)
                                triggerEvent("stopVehicleRent", playerElement, true)
                                triggerClientEvent(playerElement, "continueRentResponse", playerElement, false, true)
                            end, declineRenew, 1, playerElement)
                        end, renewTime, 1, client, rentedVehicles[client])
                    else
                        triggerClientEvent(client, "continueRentResponse", client, false)
                    end
                end
            end
        else
            exports.sAnticheat:anticheatBan(client, "AC #84 - sVehiclerent @sourceS:194")
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #85 - sVehiclerent @sourceS:197")
    end
end)

addEvent("stopVehicleRent", true)
addEventHandler("stopVehicleRent", getRootElement(), function(isOverdue)
    if not client then client = source end

    if client and client == source then
        if rentedVehicles[client] and rentedVehicles[client].activeRent then
            local rentedVehicle = rentedVehicles[client].vehElement
            if rentedVehicle and isElement(rentedVehicle) then
                local rentDetails = rentedVehicles[client]

                if isTimer(deleteTimers[client]) then
                    killTimer(deleteTimers[client])
                end

                local vehicleData = findVehicleDetails(rentedVehicle)

                local vehicleHealth = getElementHealth(rentedVehicle) / 10
                local vehicleCaution = vehicleData.cautionAmount
                local calculatedPrice = vehicleCaution / 100 * vehicleHealth
                local damagePenalty = vehicleCaution - calculatedPrice
                
                exports.sCore:giveMoney(client, calculatedPrice - (damagePenalty or 0))

                if isOverdue then
                    outputChatBox("[color=sightblue][SightMTA - Autóbérlés]: [color=hudwhite]Lejárt a válasz időd, ezért az autót elvették tőled!", client)
                else
                    outputChatBox("[color=sightblue][SightMTA - Autóbérlés]: [color=hudwhite]Sikeresen leadtad a bérelt járműved!", client)
                end

                outputChatBox("[color=sightblue][SightMTA - Autóbérlés]: [color=hudwhite]Bérelt jármű rendszáma: [color=sightgreen]" .. getVehiclePlateText(rentedVehicle) .. "[color=hudwhite].", client)
                outputChatBox("[color=sightblue][SightMTA - Autóbérlés]: [color=hudwhite]A kaucióból visszakaptál: [color=sightgreen]" .. exports.sGui:thousandsStepper(calculatedPrice) .. " $[color=hudwhite].", client)
                
                if damagePenalty > 0 then
                    outputChatBox("[color=sightblue][SightMTA - Autóbérlés]: [color=hudwhite]Az autó sérülése miatt [color=sightred]" .. exports.sGui:thousandsStepper(damagePenalty) .. " $[color=hudwhite] levonásra került a kauciódból.", client)
                end

                if isTimer(rentTimers[client]) then
                    killTimer(rentTimers[client])
                end

                rentTimers[client] = false

                if isTimer(warnTimers[client]) then
                    killTimer(warnTimers[client])
                end

                warnTimers[client] = nil

                if isTimer(deleteTimers[client]) then
                    killTimer(deleteTimers[client])
                end

                deleteTimers[client] = nil

                destroyElement(rentDetails.vehElement)
                rentedVehicles[client] = false
            end
        end
    end
end)

addEvent("cancelVehicleRent", true)
addEventHandler("cancelVehicleRent", getRootElement(), function(isOverdue)
    if client and client == source then
        if rentedVehicles[client] and rentedVehicles[client].activeRent then
            local rentDetails = rentedVehicles[client]
            local rentedVehicle = rentDetails.vehElement
            if rentedVehicle and isElement(rentedVehicle) then
                local vehicleData = findVehicleDetails(rentedVehicle)
                local vehicleHealth = getElementHealth(rentedVehicle) / 10
                local vehicleCaution = vehicleData.cautionAmount

                local rentTime = nil
                local returnPrice = 0
                
                if rentDetails and rentDetails.rentTime then
                    local rentHour = rentDetails.rentTime[1] or 0
                    local rentMinute = rentDetails.rentTime[2] or 0
                
                    local currentTime = getRealTime()
                    local currentHour = currentTime.hour
                    local currentMinute = currentTime.minute
                
                    local rentStartTotalMinutes = (rentHour * 60) + rentMinute
                    local currentTotalMinutes = (currentHour * 60) + currentMinute
                
                    rentTime = currentTotalMinutes - rentStartTotalMinutes
                
                    if rentTime < 0 then
                        rentTime = rentTime + (24 * 60)
                    end
                
                    local rentUnitsPassed = math.floor(rentTime / 10)
                    local remainingTime = 10 - (rentTime % 10)
                
                    local pricePerUnit = vehicleData.vehiclePrice / 10
                    returnPrice = remainingTime * pricePerUnit
                end

                local calculatedPrice = vehicleCaution / 100 * vehicleHealth
                local damagePenalty = vehicleCaution - calculatedPrice
                local cautionRefund = math.max(0, calculatedPrice)
                if vehicleData.isPremium then
                    decrasedAmount = 1
                    refundColor = "sightpurple-second" 
                    currency = "PP" 
                else
                    decrasedAmount = 0.7
                    refundColor = "sightgreen"
                    currency = "$"
                end

                local rentRefund = (returnPrice) * decrasedAmount

                damagePenalty = math.floor(damagePenalty)
                rentRefund = math.floor(rentRefund)
                cautionRefund = math.floor(cautionRefund)

                outputChatBox("[color=sightblue][SightMTA - Autóbérlés]: [color=hudwhite]Sikeresen leadtad a bérelt járműved!", client)
                outputChatBox("[color=sightblue][SightMTA - Autóbérlés]: [color=hudwhite]Bérelt jármű rendszáma: [color=sightgreen]" .. getVehiclePlateText(rentedVehicle) .. "[color=hudwhite].", client)
                outputChatBox("[color=sightblue][SightMTA - Autóbérlés]: [color=hudwhite]A bérlésedből visszakaptál: [color="..refundColor.."]" .. exports.sGui:thousandsStepper(rentRefund) .. " " .. currency .. "[color=hudwhite].", client)
                outputChatBox("[color=sightblue][SightMTA - Autóbérlés]: [color=hudwhite]A kaucióból visszakaptál: [color=sightgreen]" .. exports.sGui:thousandsStepper(cautionRefund) .. " $[color=hudwhite].", client)
                
                if damagePenalty > 0 then
                    outputChatBox("[color=sightblue][SightMTA - Autóbérlés]: [color=hudwhite]Az autó sérülése miatt [color=sightred]" .. exports.sGui:thousandsStepper(damagePenalty) .. " $[color=hudwhite] levonásra került a kauciódból.", client)
                end

                if currency == "PP" then
                    exports.sCore:givePP(client, rentRefund)
                else
                    exports.sCore:giveMoney(client, rentRefund)
                end

                exports.sCore:giveMoney(client, cautionRefund - damagePenalty)

                if isTimer(rentTimers[client]) then
                    killTimer(rentTimers[client])
                end

                rentTimers[client] = false

                if isTimer(warnTimers[client]) then
                    killTimer(warnTimers[client])
                end

                warnTimers[client] = nil

                if isTimer(deleteTimers[client]) then
                    killTimer(deleteTimers[client])
                end

                deleteTimers[client] = nil

                destroyElement(rentDetails.vehElement)
                rentedVehicles[client] = false
            end
        else
        exports.sAnticheat:anticheatBan(client, "AC #86 - sVehiclerent @sourceS:358")
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #87 - sVehiclerent @sourceS:361")
    end
end)

addEvent("getRentDetails", true)
addEventHandler("getRentDetails", getRootElement(), function(vehicleElement)
    if client and client == source then
        if rentedVehicles[client] and rentedVehicles[client].vehElement == vehicleElement then
            triggerLatentClientEvent(client, "gotRentDetails", client, rentedVehicles[client])
        else
        exports.sAnticheat:anticheatBan(client, "AC #88 - sVehiclerent @sourceS:371")
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #89 - sVehiclerent @sourceS:374")
    end
end)

function getVehicleRentTime(playerElement)
    local temp = {"0", "0"}
    if rentedVehicles[playerElement].rentTime[1] <= 9 then
        temp[1] = "0" .. tostring(rentedVehicles[playerElement].rentTime[1])
    else
        temp[1] = tostring(rentedVehicles[playerElement].rentTime[1])
    end
    if rentedVehicles[playerElement].rentTime[2] <= 9 then
        temp[2] = "0" .. tostring(rentedVehicles[playerElement].rentTime[2])
    else
        temp[2] = tostring(rentedVehicles[playerElement].rentTime[2])
    end

    return temp
end

function getPlayerRentedVehicle(playerElement)
    if rentedVehicles[playerElement] then
        return rentedVehicles[playerElement].vehElement
    end
    return false
end

local function isValidVehicleIdentity(vehicleModel) 
    for vehicleIndex, vehicleData in pairs(rentableVehicles) do
        if vehicleData.vehicleModel == vehicleModel then
            return true
        end
    end
    return false
end

addEvent("tryToRentVehicle", true)
addEventHandler("tryToRentVehicle", getRootElement(), function(vehicleIdentity)
    if client and client == source then
        if not rentedVehicles[client] then


            local vehDetails = findVehicleDetailsByModel(vehicleIdentity)

            if vehDetails.isPremium then
                local playerCurrency = exports.sCore:getPP(client)
                if playerCurrency < 300 then
                    exports.sGui:showInfobox(client, "e", "Nincs elég fedezeted a bérlés megkezdéséhez")
                    return
                end
            else
                local playerCurrency = exports.sCore:getMoney(client)
                if playerCurrency < vehDetails.vehiclePrice + vehDetails.cautionAmount then
                    exports.sGui:showInfobox(client, "e", "Nincs elég fedezeted a bérlés megkezdéséhez")
                    return
                end
            end

            local playerMoney = exports.sCore:getMoney(client)
            if playerMoney < vehDetails.cautionAmount then
                exports.sGui:showInfobox(client, "e", "Nincs elég fedezeted a kaució kifizetéséhez!")
                return
            end

            if vehicleIdentity and isValidVehicleIdentity(vehicleIdentity) then
                local realTime = getRealTime()
                
                local realHour = realTime.hour
                local realMinute = realTime.minute

                local vehiclePlate = nil
                plateNumber = getTableSize(rentedVehicles) + 1

                if plateNumber <= 9 then
                    vehiclePlate = "RENT-00"..plateNumber
                elseif plateNumber <= 99 then
                    vehiclePlate = "RENT-0"..plateNumber
                else
                    vehiclePlate = "RENT-"..plateNumber
                end

                rentedVehicles[client] = {
                    activeRent = true,
                    vehElement = nil,
                    rentTime = {realHour, realMinute},
                    vehiclePlate = vehiclePlate,
                }

                if vehicleIdentity ~= "model_s" then
                    rentedVehicles[client].vehElement = createVehicle(tonumber(vehicleIdentity), vehiclePositions[1][1], vehiclePositions[1][2], vehiclePositions[1][3], 0, 0, 90, vehiclePlate)
                else
                    rentedVehicles[client].vehElement = createVehicle(445, vehiclePositions[1][1], vehiclePositions[1][2], vehiclePositions[1][3], 0, 0, 90, vehiclePlate)
                    setElementData(rentedVehicles[client].vehElement, "vehicle.customModel", "model_s")
                end

                local vehElement = rentedVehicles[client].vehElement

                setVehicleColor(vehElement, math.random(0, 255), math.random(0, 255), math.random(0, 255))

                warpPedIntoVehicle(client, vehElement)

                setElementData(vehElement, "vehicle.owner", -1)
                setElementData(vehElement, "vehicle.dbID", -1)
                setElementData(vehElement, "vehicle.fuel", exports.sVehicles:getTankSize(vehElement))
                setElementData(vehElement, "vehicle.distance", 0)

                setElementData(vehElement, "vehicle.errorCodes", {})
                setElementData(vehElement, "vehicle.checkengine", 0)

                setElementData(vehElement, 'vehicle.batteryCharge', 2048)
                setElementData(vehElement, 'vehradio.broken', false)
                setElementData(vehElement, 'vehicle.maxBatteryCharge', 2048)
                local batteryRate = getElementData(vehElement, "vehicle.batteryRate")
                triggerClientEvent(getVehicleOccupants(vehElement), "gotVehicleBatteryCharge", vehElement, 2048, 2048, 2048, batteryRate)

                local priceColor = vehDetails.isPremium and "[color=sightpurple-second]" or "[color=sightgreen]"
                local currency = vehDetails.isPremium and "PP" or "$"
                
                rentedVehicles[client].vehiclePrice = vehDetails.vehiclePrice
                outputChatBox("[color=sightblue][SightMTA - Autóbérlés] [color=hudwhite]Sikeresen kibérelted a kiválasztott járművet! [color=sightblue]["..vehiclePlate.." - ".. exports.sVehiclenames:getCustomVehicleName(vehicleIdentity).."]", client)
                outputChatBox("[color=sightblue][SightMTA - Autóbérlés] [color=hudwhite]A kaució összege: [color=sightgreen]" .. vehDetails.cautionAmount .. "$[color=hudwhite], amelyet a bérlés végén visszakapsz, ha az autót megfelelő állapotban adod le.", client)
                outputChatBox("[color=sightblue][SightMTA - Autóbérlés] [color=hudwhite]A bérlés költsége: " .. priceColor .. vehDetails.vehiclePrice .. " " .. currency .. "[color=hudwhite] minden 10 perces időszakonként.", client)
                outputChatBox("[color=sightblue][SightMTA - Autóbérlés] [color=hudwhite]A jármű leadásához keresd fel a bérlés helyszínét és add le az autót!", client)

                if vehDetails.isPremium then
                    exports.sCore:takePP(client, vehDetails.vehiclePrice)
                else
                    exports.sCore:takeMoney(client, vehDetails.vehiclePrice)
                end

                rentTimers[client] = setTimer(function(playerElement, vehDetails)
                    triggerClientEvent(playerElement, "tryToRenewRent", playerElement, vehDetails)

                    warnTimers[playerElement] = setTimer(function(playerElement)
                        exports.sGui:showInfobox(playerElement, "e", "A bérelt járműved 10 másodpercen belül törlődni fog, amennyiben nem hosszabítod meg.")
                    end, 50000, 1, playerElement)

                    deleteTimers[playerElement] = setTimer(function(playerElement)
                        triggerEvent("stopVehicleRent", playerElement)
                        triggerClientEvent(playerElement, "continueRentResponse", playerElement, false, true)
                    end, declineRenew, 1, playerElement)
                end, renewTime, 1, client, rentedVehicles[client])

                exports.sCore:takeMoney(client, vehDetails.cautionAmount)

                exports.sDashboard:givePlayerRentedVehicle(client, vehElement)
                triggerClientEvent(client, "gotRentedVehicle", client, rentedVehicles[client].vehElement)
            else
                exports.sAnticheat:anticheatBan(client, "AC #90 - sVehiclerent @sourceS:522")
            end
        else
            exports.sAnticheat:anticheatBan(client, "AC #91 - sVehiclerent @sourceS:525")
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #92 - sVehiclerent @sourceS:528")
    end
end)

local colPositions = {
    [1] = {1181.4132080078, -1442.6794433594 - 25, 8.8604011535645},
    [2] = {1075.8741455078, -1455.3349609375, 8.8604011535645},
    [3] = {1075.9553222656, -1561.9008789062, 8.8202247619629},
    [4] = {1180.8981933594, -1561.9007568359, 8.8202247619629},
}

col = createColPolygon(
    1148.859375, -1509.0291748047,
    colPositions[1][1], colPositions[1][2],
    colPositions[2][1], colPositions[2][2],
    colPositions[3][1], colPositions[3][2],
    colPositions[4][1], colPositions[4][2]
)
setColPolygonHeight(col, 8, 12)

addEventHandler("onColShapeHit", root, function(playerElement, matchingDimension)
    if source == col then
        if getElementDimension(playerElement) ~= 123 then
            if getElementType(playerElement) == "player" and not getPedOccupiedVehicle(playerElement) then
                setElementDimension(playerElement, 123)
            end
        end
    end
end)

addEventHandler("onColShapeLeave", root, function(playerElement, matchingDimension)
    if source == col then
        if getElementDimension(playerElement) == 123 then
            if getElementType(playerElement) == "player" and not getPedOccupiedVehicle(playerElement) then
                setElementDimension(playerElement, 0)
            end
        end
    end
end)

--[[
bankFearCol = createColPolygon(568.7102, -1616.8914, 568.7102, -1616.8914, 568.7114, -1640.1138, 577.7846, -1640.1141, 577.7849, -1645.5198, 585.2414, -1645.5203, 603.6266, -1645.5208, 603.6263, -1640.1171, 607.9957, -1640.1162, 611.8016, -1639.0635, 615.0181, -1636.772, 617.2568, -1633.5189, 618.2029, -1630.0201, 618.1862, -1627.5571, 617.2573, -1624.0781, 615.0189, -1620.8253, 611.8026, -1618.5342, 608.0201, -1617.4899, 605.6265, -1617.4901, 583.9078, -1617.4895, 583.9074, -1616.8921)
setColPolygonHeight(bankFearCol, 15, 21)
]]