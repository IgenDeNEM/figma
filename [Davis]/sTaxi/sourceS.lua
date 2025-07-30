local taxiFares = {}
local taxiStats = {}
local occupieds = {}

addEvent("updateTaxiFares", true)
function updateTaxiFares(fare, minFare)

    local currentTaxi = source
    if not fare then
        if taxiFares[currentTaxi][1] then
            fare = taxiFares[currentTaxi][1]
        else
            fare = 500
        end
    end
    if not minFare then
        if taxiFares[currentTaxi][2] then
            minFare = taxiFares[currentTaxi][2]
        else
            minFare = 50
        end
    end
    taxiFares[currentTaxi] = {fare, minFare}
    triggerClientEvent("gotTaxiFares", currentTaxi, fare, minFare)
end
addEventHandler("updateTaxiFares", root, updateTaxiFares)

addEvent("requestTaxiFare", true)
function requestTaxiFare()
    local taxi = source
    local fare = 500
    local minFare = 50
    if taxiFares[taxi] then
        fare = taxiFares[taxi][1]
        minFare = taxiFares[taxi][2]
    end

    if taxiFares[taxi] then
        fare = taxiFares[taxi][1]
        minFare = taxiFares[taxi][2]
    end

    triggerClientEvent("gotTaxiFares", taxi, fare, minFare)
end
addEventHandler("requestTaxiFare", root, requestTaxiFare)

addEvent("syncTaxiOccupied", true)
function syncTaxiOccupied(currentTaxiTiming, currentTaxiDistance, currentTaxiTime, price)
    local taxi = source
    local price = tonumber(price) or 0

    if not occupieds[taxi] then
        occupieds[taxi] = {0, 0, 0, 0}
    end

    if not taxiFares[taxi] then
        taxiFares[taxi] = {500, 50}
    end

    if not currentTaxiTiming then
        if currentTaxiDistance then
            occupieds[taxi][1] = currentTaxiTiming
            occupieds[taxi][5] = currentTaxiDistance
            occupieds[taxi][6] = currentTaxiTime

            occupieds[taxi][9] = math.ceil((taxiFares[taxi][1] * (currentTaxiDistance or 0) + taxiFares[taxi][2] * (currentTaxiTime or 0) / 60000) / 10) * 10
            
        end
        local timing, dist, min = occupieds[taxi][1], occupieds[taxi][5], occupieds[taxi][6]
        triggerClientEvent("taxiSyncOccupied", taxi, client, timing, dist, min, true)
    else
        triggerClientEvent("taxiSyncOccupied", taxi, client, currentTaxiTiming, currentTaxiDistance, currentTaxiTime)
        local tempTime = getRealTime().timestamp
        occupieds[taxi] = {
            currentTaxiTiming, getElementData(getVehicleController(taxi), "visibleName"):gsub("_", " "), tempTime, 0,
            currentTaxiDistance, currentTaxiTime or 0,
            taxiFares[taxi][1], taxiFares[taxi][2],
            math.ceil((taxiFares[taxi][1] * (currentTaxiDistance or 0) + taxiFares[taxi][2] * (currentTaxiTime or 0) / 60000) / 10) * 10,
            getElementData(getVehicleController(taxi), "visibleName"):gsub("_", " "), tempTime, getRealTime().timestamp
        }
    end
end
addEventHandler("syncTaxiOccupied", root, syncTaxiOccupied)

addEvent("printTaxiReceipt", true)
function printTaxiReceipt()
    occupieds[source][1] = "receipt"
    occupieds[source][4] = getRealTime().timestamp

    occupieds[source]["recepitType"] = "receipt"

    triggerClientEvent("syncTaxiReceipt", source, occupieds[source], true)
end
addEventHandler("printTaxiReceipt", root, printTaxiReceipt)

addEvent("processTaxiReceipt", true)
function processTaxiReceipt()
    local taxi = source
    if occupieds[taxi]["recepitType"] == "receipt" then
        for _, occupant in pairs(getVehicleOccupants(taxi)) do
            triggerClientEvent(occupant, "taxiSyncOccupied", taxi, occupant)
        end

        local passengerMoney = exports.sCore:getMoney(client)
        local fare = math.ceil((taxiFares[taxi][1] * occupieds[taxi][5] + taxiFares[taxi][2] * occupieds[taxi][6] / 60000) / 10) * 10
        exports.sCore:setMoney(client, passengerMoney - fare)
        for _, occupant in pairs(getVehicleOccupants(taxi)) do
            if occupant == getVehicleController(taxi) then
                local driverMoney = exports.sCore:getMoney(occupant)

                local totalCheckOut = getElementData(occupant, "char.totalTaxiCheckOut") or {}
                table.insert(totalCheckOut, {getRealTime().timestamp, fare, occupieds[taxi][5], occupieds[taxi][6] / 1000})
                setElementData(occupant, "char.totalTaxiCheckOut", totalCheckOut)
            end
        end
        exports.sChat:localAction(client, "kifizette az utazást.")
        occupieds[taxi] = {}

        triggerClientEvent("syncTaxiReceipt", taxi, false, true)
    else
        occupieds[taxi] = {}

        triggerClientEvent("syncTaxiReceipt", taxi, false, true)
        exports.sChat:localAction(client, "letépte a kasszazárási lapot.")
    end
end
addEventHandler("processTaxiReceipt", root, processTaxiReceipt)

addEvent("printTaxiCheckout", true)
function printTaxiCheckout()
    local taxi = source
    local driver = getVehicleController(taxi)
    local driverName = getElementData(driver, "visibleName"):gsub("_", " ")
    local driverCharID = getElementData(driver, "char.ID")
    local totalCheckOut = getElementData(driver, "char.totalTaxiCheckOut") or {}

    local totalPrice = 0

    local totalDrive = 0

    local totalTime = 0
    
    local firstDrive = false
    local lastDrive = false

    for k, v in pairs(totalCheckOut) do
        if v then
            if v[2] then
                if not v[3] then
                    v[3] = 0
                end
                if not v[4] then
                    v[4] = 0
                end
                totalPrice = totalPrice + v[2]
                totalTime = totalTime + v[4]
                totalDrive = totalDrive + v[3]
                if not firstDrive then
                    firstDrive = v[1]
                end
            end
        end
    end

    if #totalCheckOut > 0 then
        lastDrive = totalCheckOut[#totalCheckOut][1]
    end

    local time = getRealTime()

    local formattedTime = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)


    checkOutData = {"checkout", driverName, driverCharID, firstDrive, lastDrive, totalDrive, totalTime, totalPrice}

    triggerClientEvent("syncTaxiReceipt", taxi, checkOutData, true)
    table.remove(checkOutData, 1)
    exports.sItems:giveItem(driver, 595, 1, false, driverName .. " (" .. driverCharID .. ") " .. formattedTime, totalPrice, toJSON(checkOutData))

    setElementData(driver, "char.totalTaxiCheckOut", {})
    occupieds[taxi]["recepitType"] = "checkout"
end
addEventHandler("printTaxiCheckout", root, printTaxiCheckout)
