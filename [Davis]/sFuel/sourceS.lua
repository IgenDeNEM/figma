local stationDatas = {}
local fuelPrices = {}
local playerPistols = {}

local minFuelPrice, maxFuelPrice = 600, 900

addEventHandler("onResourceStart", resourceRoot,
    function ()
        for i = 1, #fuelStations do
            stationDatas[i] = {}

            stationDatas[i].pumpDatas = {}

            for j = 1, 6 do
                stationDatas[i].pumpDatas[j] = {}

                stationDatas[i].pumpDatas[j].fuelAmount = 0
                stationDatas[i].pumpDatas[j].pistolInVehicle = false
                stationDatas[i].pumpDatas[j].controller = false
                stationDatas[i].pumpDatas[j].pistolInHand = false
                stationDatas[i].pumpDatas[j].fueling = false
            end
        end

        changeFuelPrices()
        setTimer(changeFuelPrices, 60000, 0)
    end
)

local heliFuelPrice = 0
function getHeliFuelPrices()
  return heliFuelPrice
end

addEvent("requestFuelPrices", true)
addEventHandler("requestFuelPrices", root,
    function ()
        triggerClientEvent(client, "syncFuelPrices", client, fuelPrices)
    end 
)

addEvent("requestFuelStationSync", true)
addEventHandler("requestFuelStationSync", root,
    function (station)
        local stationData = stationDatas[station]

        if stationData then
            triggerClientEvent(client, "syncPumpDatas", client, station, getActiveFuelPumps(station), true)
        end
    end
)

addEvent("getFuelPistolToHand", true)
addEventHandler("getFuelPistolToHand", root,
    function (station, pump, fuelType)
        local data = stationDatas[station].pumpDatas
        
        if data[pump].controller and data[pump].controller == client then
            data[pump].pistolInHand = true
            data[pump].pistolInVehicle = false
            triggerClientEvent("stopFueling", client)
        else
            data[pump].controller = client
            data[pump].pistolInHand = true
            data[pump].fuelType = fuelType
            
            playerPistols[client] = {station, pump}
        end

        triggerClientEvent("syncPumpDatas", client, station, getActiveFuelPumps(station), true)
    end
)

addEvent("putBackFuelPistol", true)
addEventHandler("putBackFuelPistol", root,
    function (force)
        local pistolData = playerPistols[client]

        if pistolData then
            local station = pistolData[1]
            local pump = pistolData[2]
            
            local data = stationDatas[station].pumpDatas

            data[pump].pistolInHand = false
            data[pump].pistolInVehicle = false
            data[pump].fueling = false

            if data[pump].fuelAmount == 0 then
                data[pump].controller = false
            end

            triggerClientEvent("syncPumpDatas", client, station, getActiveFuelPumps(station), false)
        end
    end
)

addEvent("putFuelPistolInVehicle", true)
addEventHandler("putFuelPistolInVehicle", root,
    function (vehicle)
        local pistolData = playerPistols[client]

        if pistolData then
            local station = pistolData[1]
            local pump = pistolData[2]
            
            local data = stationDatas[station].pumpDatas

            data[pump].pistolInHand = false
            data[pump].pistolInVehicle = source
            data[pump].vehicle = source
            data[pump].maximumFuel = (exports.sVehicles:getTankSize(source) or 1000) - (getElementData(source, "vehicle.fuel") or 0)
            data[pump].fuelPrice = fuelPrices[station][data[pump].fuelType]

            if getElementModel(source) == 611 then
                data[pump].maximumFuel = 1000 - (getElementData(source, "vehicle.fuel") or 0)
            end

            triggerClientEvent("syncPumpDatas", client, station, getActiveFuelPumps(station), true)
        end
    end
)

addEvent("setVehicleFuelingState", true)
addEventHandler("setVehicleFuelingState", root,
    function (state)
        local pistolData = playerPistols[client]

        if pistolData then
            local station = pistolData[1]
            local pump = pistolData[2]
            
            local data = stationDatas[station].pumpDatas

            if not state then
                local sec = (getTickCount() - (data[pump].fueling or getTickCount())) / 1000

                if sec < 1 then
                    sec = sec * sec
                end

                data[pump].fuelAmount = data[pump].fuelAmount + sec * fuelFlow
                data[pump].maximumFuel = data[pump].maximumFuel - sec * fuelFlow
            end

            data[pump].fueling = state and getTickCount() or false

            triggerClientEvent("syncPumpDatas", client, station, getActiveFuelPumps(station), true)
        end
    end
)

addEvent("payTheFuel", true)
addEventHandler("payTheFuel", root,
    function ()
        local pistolData = playerPistols[client]

        if pistolData then
            local station = pistolData[1]
            local pump = pistolData[2]
            
            local data = stationDatas[station].pumpDatas

            --[[
                fuelType 
                    1- prémiumDízel
                    2- Dízel
                    3- RacingBenzin
                    4- prémiumBenzin
                    5- Benzin
            ]]

            local price = math.floor(data[pump].fuelAmount * data[pump].fuelPrice) or 0
            local playerMoney = exports.sCore:getMoney(client) or 0
            
            if playerMoney >= price then
                local currentFuel = (getElementData(data[pump].vehicle, "vehicle.fuel") or 0)
                local newFuel = currentFuel + (data[pump].fuelAmount or 0)
                local maxFuel = exports.sVehicles:getTankSize(data[pump].vehicle)
                if newFuel > maxFuel then
                    newFuel = maxFuel
                end
                local fuelType = exports.sVehicles:getFuelType(data[pump].vehicle)
                local fuelTypeList = {
                    [1] = "diesel",
                    [2] = "diesel",
                    [3] = "petrol",
                    [4] = "petrol",
                    [5] = "petrol",
                }
                if (currentFuel / 20) < data[pump].fuelAmount then
                    if fuelTypeList[data[pump].fuelType] ~= fuelType then
                        setElementData(data[pump].vehicle, "vehicle.fueltype", "faulty")
                    end
                end

                exports.sCore:takeMoney(client, price)
                setElementData(data[pump].vehicle, "vehicle.fuel", newFuel)

                local qualityLevel = 1
                local fuelType = fuelTypeList[data[pump].fuelType]
                if fuelType == "diesel" then
                    if data[pump].fuelType == 2 then
                        qualityLevel = 1
                    elseif data[pump].fuelType == 1 then
                        qualityLevel = 2
                    end
                elseif fuelType == "petrol" then
                    if data[pump].fuelType == 5 then
                        qualityLevel = 1
                    elseif data[pump].fuelType == 4 then
                        qualityLevel = 2
                    elseif data[pump].fuelType == 3 then
                        qualityLevel = 3
                    end
                end

                setElementData(data[pump].vehicle, "vehicle.fuelType", {qualityLevel, fuelType, data[pump].fuelType, data[pump].fuelAmount})
                exports.sTuning:makeTuning(data[pump].vehicle)
                
                data[pump].fuelAmount = 0
                data[pump].pistolInVehicle = false
                data[pump].controller = false
                data[pump].pistolInHand = false
                data[pump].fueling = false
                data[pump].vehicle = false

                playerPistols[client] = nil
                
                triggerClientEvent("syncPumpDatas", client, station, getActiveFuelPumps(station), true)
                triggerClientEvent(client, "showInfobox", client, "success", "Sikeresen kifizetted az üzemanyagot! (" .. exports.sGui:thousandsStepper(price) .. " $)!")
            else
                triggerClientEvent(client, "showInfobox", client, "error", "Nics elég pézed a tankolás kifizetésére")
            end
        end
    end
)

function changeFuelPrices()
    for i = 1, #fuelStations do
        fuelPrices[i] = {}

        for j = 1, #fuelTypes do
            if j == 1 then
                fuelPrices[i][j] = math.random(400, 500)
            elseif j == 2 then
                fuelPrices[i][j] = math.random(300, 400)
            elseif j == 3 then
                fuelPrices[i][j] = math.random(600, 700)
            elseif j == 4 then
                fuelPrices[i][j] = math.random(400, 500)
            elseif j == 5 then
                fuelPrices[i][j] = math.random(300, 400)
            end
        end
    end

    local sum = 0
    for i = 1, #fuelStations do
        sum = sum + fuelPrices[i][3]
    end
    heliFuelPrice = math.floor(sum / #fuelStations * 1.1)
end

function getActiveFuelPumps(station)
    local stationData = stationDatas[station]

    if stationData then
        local pumpDatas = {}

        for k, v in pairs(stationData.pumpDatas) do
            if v.controller then
                pumpDatas[k] = v
            else
                pumpDatas[k] = false
            end
        end

        return pumpDatas
    end
end