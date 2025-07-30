local connection = exports.sConnection:getConnection()
local vehicleSelling = {}

function getVehicleElement(vehicleId)
    for k, v in ipairs(getElementsByType("vehicle")) do
        if getElementData(v, "vehicle.dbID") == vehicleId then
            return v
        end
    end
end

function isTuningValid(tuning, vehicleElement, desiredValue)
    if tuning == "driveType" then
        return getElementData(vehicleElement, tuning) == desiredValue and 0 or 1
    elseif tuning == "brake" then
        return getElementData(vehicleElement, "performance." .. "brakes") == desiredValue and 0 or 1
    elseif tuning == "backfire" then
        return getElementData(vehicleElement, tuning) == desiredValue and 0 or 1
    elseif tuning == "rideHeight" then
        return getElementData(vehicleElement, "rideTuning") == desiredValue and 0 or 1
    elseif tuning == "nitro" then
        return getElementData(vehicleElement, "nitro") == desiredValue and 0 or 1
    elseif tuning == "colors" then
        local vehColors = {getVehicleColor(vehicleElement, true)}
        local color = table.concat(vehColors, ',')
        return color == desiredValue and 0 or 1
    else
        return getElementData(vehicleElement, "performance." .. tuning) == desiredValue and 0 or 1
    end
end

addEvent("tryToSellVehicleToPlayer", true)
addEventHandler("tryToSellVehicleToPlayer", root, 
    function(vehicleId, sellPlayer, sellPrice)
        if exports.sItems:hasItem(client, 311) then
            local vehicleElement = getVehicleElement(vehicleId)
            local travelledDistance = getElementData(vehicleElement, "vehicle.distance")

            vehicleSelling[client] = {
                "seller",
                false,
                vehicleId,
                sellPrice,
                math.ceil(sellPrice * 0.025),
                getElementData(client, "char.name"):gsub("_", " "),
                getElementData(sellPlayer, "char.name"):gsub("_", " "),
                getVehiclePlateText(vehicleElement),
                math.floor(travelledDistance),
                getElementData(vehicleElement, "dieselFuel"),
                getElementModel(vehicleElement),
                false,
                sellPlayer
            }

            vehicleSelling[sellPlayer] = {
                "buyer",
                false,
                vehicleId,
                sellPrice,
                math.ceil(sellPrice * 0.025),
                getElementData(client, "char.name"):gsub("_", " "),
                getElementData(sellPlayer, "char.name"):gsub("_", " "),
                getVehiclePlateText(vehicleElement),
                math.floor(travelledDistance),
                getElementData(vehicleElement, "dieselFuel"),
                getElementModel(vehicleElement),
                false,
                client
            }

            local jsonData = false
            triggerClientEvent(client, "gotVehicleSellPaper", client, vehicleSelling[client], jsonData)

            dbQuery(function(qh, client, sellPlayer)
                local result = dbPoll(qh, 0)[1]
                if result then
                    jsonData = fromJSON(result.licenseData)
                    if jsonData then
                        jsonData = unpack(jsonData)
                        jsonData.vehicleId = getElementData(vehicleElement, "vehicle.dbID")
                        local realData = {}
                        for k, v in pairs(jsonData) do
                            local oldVal = k
                            realData[k] = jsonData[k]
                            realData[k .. "Invalidated"] = isTuningValid(oldVal, vehicleElement, v)
                        end
                        triggerClientEvent(client, "gotVehicleSellPaper", client, vehicleSelling[client], realData)
                    end
                end
            end, {client, sellPlayer}, connection, "SELECT licenseData FROM vehicles WHERE dbID = ?", getElementData(vehicleElement, "vehicle.dbID"))
        else
            triggerClientEvent(client, "gotVehicleSellPaper", client, false)
            exports.sGui:showInfobox(client, "e", "Nincs nálad üres adásvételi szerződés!")
        end
    end
)

addEvent("cancelVehicleSell", true)
addEventHandler("cancelVehicleSell", root, function()
    local clientTable = vehicleSelling[client]
    triggerClientEvent(clientTable[13], "gotVehicleSellPaper", clientTable[13], false)
    exports.sGui:showInfobox(clientTable[13], "e", "Elutasították az adásvételt!")
    vehicleSelling[client] = nil
end)

function findPlayerVehicles(player)
    local totalVehicles = 0
    local charID = getElementData(player, "char.ID")
    for k, v in pairs(getElementsByType("vehicle")) do
        if getElementData(v, "vehicle.owner") == charID then
            totalVehicles = totalVehicles + 1
        end
    end
    return totalVehicles
end


addEvent("acceptVehicleSell", true)
addEventHandler("acceptVehicleSell", root, 
    function()
        local clientTable = vehicleSelling[client]
        local sellTable = vehicleSelling[clientTable[13]]

        if clientTable[1] == "seller" then

            if exports.sItems:hasItem(client, 311) then
                if exports.sItems:hasItem(client, 312) then

                    clientTable[2] = true

                    triggerClientEvent(client, "vehicleSellAcceptResponse", client, true)
                    exports.sGui:showInfobox(client, "s", "Sikeresen küldtél egy adásvételi ajánlatot!")
                    setTimer(function(buyerElement, table, seller)
                        buyerElement = buyerElement
                        seller = seller
                        triggerClientEvent(seller, "gotVehicleSellPaper", seller, false)
                        exports.sGui:showInfobox(buyerElement, "i", "Adásvételi ajánlatot kaptál tőle: "..getElementData(seller, "char.name"):gsub("_", " ")..".")
                        exports.sGui:showInfobox(buyerElement, "i", "Az ajánlat megtekintéséhez nyomj [E] gombot.")
                        exports.sGui:showInfobox(buyerElement, "w", "Az ajánlat 5 perc múlva lejárt")

                        local function openVehBuy()
                            vehicleElement = getVehicleElement(table[3])
                            local jsonData = false
                            triggerClientEvent(buyerElement, "gotVehicleSellPaper", buyerElement, vehicleSelling[buyerElement], jsonData)
                
                            dbQuery(function(qh, client, sellPlayer)
                                local result = dbPoll(qh, 0)[1]
                                if result then
                                    jsonData = fromJSON(result.licenseData)
                                    if jsonData then
                                        jsonData = unpack(jsonData)
                                        jsonData.vehicleId = getElementData(vehicleElement, "vehicle.dbID")
                                        local realData = {}
                                        for k, v in pairs(jsonData) do
                                            local oldVal = k
                                            realData[k] = jsonData[k]
                                            realData[k .. "Invalidated"] = isTuningValid(oldVal, vehicleElement, v)
                                        end
                                    else
                                        exports.sGui:showInfobox(client, "w", "Nem található a járműhöz forgalmi engedély!")
                                    end
                                    triggerClientEvent(client, "gotVehicleSellPaper", client, vehicleSelling[client], realData)
                                else
                                    exports.sGui:showInfobox(client, "w", "Nem található a járműhöz forgalmi engedély!")
                                end
                            end, {buyerElement, seller}, connection, "SELECT licenseData FROM vehicles WHERE dbID = ?", getElementData(vehicleElement, "vehicle.dbID"))
                        end

                        bindKey(buyerElement, "e", "down", openVehBuy)

                        setTimer(function(seller, buyer)
                            if isElement(seller) then
                                vehicleSelling[seller] = nil
                            end
                            if isElement(buyer) then
                                vehicleSelling[buyer] = nil
                            end

                            unbindKey(buyerElement, "e", "down", openVehBuy)
                        end, 300000, 1, buyerElement, client)
                    
                    end, 3580, 1, clientTable[13], sellTable, client)
                else
                    exports.sGui:showInfobox(client, "e", "Nincs nálad toll!")
                    triggerClientEvent(client, "vehicleSellAcceptResponse", client, false)
                end
            else
                exports.sGui:showInfobox(client, "e", "Nincs nálad üres adásvételi szerződés!")
                triggerClientEvent(client, "vehicleSellAcceptResponse", client, false)
            end
        elseif clientTable[1] == "buyer" then
            if getElementData(client, "char.vehiclesSlot") > findPlayerVehicles(client) then
                if exports.sItems:hasItem(client, 312) then
                    triggerClientEvent(client, "vehicleSellAcceptResponse", client, true)

                    local sellerMoney = exports.sCore:getMoney(clientTable[13])
                    local buyerMoney = exports.sCore:getMoney(client)

                    if buyerMoney >= sellTable[4] then
                        setTimer(function(sellerElement, buyerElement, sellTable, clientTable)
                            exports.sCore:takeMoney(buyerElement, sellTable[4])
                            exports.sCore:giveMoney(sellerElement, (sellTable[4] - sellTable[5]))
                            clientTable[2] = true
                            sellTable[2] = true
                            clientTable[13] = "geci"
                            sellTable[13] = "gecifasz"
                            exports.sItems:giveItem(buyerElement, 309, 1, false, toJSON(clientTable), clientTable[8], exports.sVehiclenames:getCustomVehicleName(getElementModel(getVehicleElement(sellTable[3]))))
                            exports.sItems:giveItem(sellerElement, 309, 1, false, toJSON(sellTable), sellTable[8], exports.sVehiclenames:getCustomVehicleName(getElementModel(getVehicleElement(sellTable[3]))))

                            exports.sGui:showInfobox(buyerElement, "s", "Elfogadtad az ajánlatot ("..exports.sVehiclenames:getCustomVehicleName(getElementModel(getVehicleElement(sellTable[3])))..")!")

                            exports.sGui:showInfobox(sellerElement, "s", "A vevő elfogadta az ajánlatod ("..exports.sVehiclenames:getCustomVehicleName(getElementModel(getVehicleElement(sellTable[3])))..")! Ne felejtsd a kulcsot és a forgalmi engedélyt átadni!")
                            exports.sGui:showInfobox(sellerElement, "i", "A vagyonátruházási illeték levonásra került a vételárból ("..exports.sGui:thousandsStepper(sellTable[5])..")!")
                            unbindKey(buyerElement, "e", "down", openVehBuy)
                            unbindKey(sellerElement, "e", "down", openVehBuy)
                            vehicleSelling[buyerElement] = nil
                            vehicleSelling[sellerElement] = nil
                        end, 3850, 1, clientTable[13], client, sellTable, clientTable)

                        dbExec(connection, "UPDATE vehicles SET characterId = ? WHERE dbID = ?", getElementData(sellTable[13], "char.ID"), sellTable[3])
                        setElementData(getVehicleElement(sellTable[3]), "vehicle.owner", getElementData(client, "char.ID"))
                    else
                        exports.sGui:showInfobox(client, "e", "Nincs elégendő pénzed a jármű megvásárlásához!")
                        triggerClientEvent(client, "vehicleSellAcceptResponse", client, false)
                    end
                else
                    triggerClientEvent(client, "vehicleSellAcceptResponse", client, false)
                    exports.sGui:showInfobox(client, "e", "Nincs nálad toll!")
                end
            else
                triggerClientEvent(client, "vehicleSellAcceptResponse", client, false)
                exports.sGui:showInfobox(client, "e", "Nincs elég slotod!")
            end
        end
    end
)
