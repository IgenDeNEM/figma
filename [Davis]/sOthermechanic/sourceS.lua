local connection = exports.sConnection:getConnection()

local bikesInMechanic = {}

addEvent("requestInServiceBikeList", true)
function requestInServiceBikeList()
    triggerClientEvent(client, "gotServiceBikeList", client, getPlayerVehs(getElementData(client, "char.ID")))
end
addEventHandler("requestInServiceBikeList", root, requestInServiceBikeList)

addEvent("helicopterRepairJob", true)
addEventHandler("helicopterRepairJob", root, 
    function()
        local playerMoney = exports.sCore:getMoney(client)

        if playerMoney >= 75000 then
            local veh = getPedOccupiedVehicle(client)
            fixVehicle(veh)
            setVehicleEngineState(veh, true)
            exports.sCore:setMoney(client, playerMoney - 75000)
            triggerClientEvent(client, "gotHeliFixResponse", client)
        else
            triggerClientEvent(client, "showInfobox", client, "e", "Nincs elég pénzed a javításhoz!")
            triggerClientEvent(client, "gotHeliFixResponse", client)
        end
    end
)

addEvent("helicopterFueling", true)
addEventHandler("helicopterFueling", root, 
    function(liter)
        local liter = math.abs(liter)
        local vehicleElement = getPedOccupiedVehicle(client)

        local playerMoney = exports.sCore:getMoney(client)
        local price = exports.sFuel:getHeliFuelPrices()
        
        local currentFuel = getElementData(vehicleElement, "vehicle.fuel")

        local sum = math.floor(liter * price)

        if playerMoney >= sum then
            setElementData(vehicleElement, "vehicle.fuel", currentFuel + liter)
            exports.sCore:setMoney(client, playerMoney - sum)
            triggerClientEvent(client, "gotHeliFixResponse", client)
            exports.sCore:takeMoney(client, sum)
            triggerClientEvent(client, "showInfobox", client, "s", "Sikeresen megtankoltad a járművet!")
            
        else
            triggerClientEvent(client, "showInfobox", client, "e", "Nincs elég pénzed a tankoláshoz!")
            triggerClientEvent(client, "gotHeliFixResponse", client)
        end
    end
)

addEvent("resetHelicopterFix", true)
addEventHandler("resetHelicopterFix", root, 
    function(toReset)
        if toReset then
            local veh = getPedOccupiedVehicle(client)
            if veh == toReset then
                local colorR1, colorG1, colorB1, colorR2, colorG2, colorB2 = getVehicleColor(toReset, true)
                local variantData = getElementData(toReset, "vehicle.Variant")

                setVehicleVariant(toReset, (variantData or 0), 255)
                setVehicleColor(toReset, colorR1, colorG1, colorB1, colorR2, colorG2, colorB2)
            end
        end
    end
)

addEvent("buyHelicopterPlate", true)
addEventHandler("buyHelicopterPlate", root, 
    function(plateMode)
        local clientVehicle = getPedOccupiedVehicle(client)
        local clientPP = exports.sCore:getPP(client)
        local value = plateMode
        local plateMode = utf8.upper(plateMode)
        plateMode = plateMode:gsub("[^%a%d-]", "")
        plateFound = {}

        dbQuery(function(qh, client, vehicle, value, data)
            local result = dbPoll(qh, 0)
            local vehicleId = getElementData(vehicle, "vehicle.dbID") or false

            if vehicleId then
                if data and value then
                    plateFound[vehicle] = false

                    for i = 1, #result do
                        if result[i].plate then
                            if result[i].plate:gsub("-", "") == data:gsub("-", "") then
                                plateFound[vehicle] = true
                                break
                            end
                        end

                        if result[i].customPlate then
                            if result[i].customPlate:gsub("-", "") == data:gsub("-", "") then
                                plateFound[vehicle] = true
                                break
                            end
                        end
                    end

                    if plateFound[vehicle] then
                        exports.sGui:showInfobox(client, "e", "Ilyen rendszámmal már létezik jármű!")
                        triggerClientEvent(client, "gotHeliFixResponse", client, false)
                        plateFound[vehicle] = nil
                        return
                    end
                end

                local tuningPrice = {"pp", 1500}

                if tuningPrice and tuningPrice[1] == "pp" then
                    local premiumPoints = exports.sCore:getPP(client)

                    if (premiumPoints - tuningPrice[2]) < 0 then
                        exports.sGui:showInfobox(client, "e", "Nincs elég prémiumpontod!")
                        triggerClientEvent(client, "gotHeliFixResponse", client, false)
                        return
                    else
                        exports.sCore:setPP(client, premiumPoints - tuningPrice[2])
                        exports.sGui:showInfobox(client, "s", "Sikeresen megvásároltad a kiválasztott tuningot.")
                    end 
                end

                if value then
                    setVehiclePlateText(vehicle, data)
                    setElementData(vehicle, "customPlate", true)
                    dbExec(connection, "UPDATE vehicles SET customPlate = ? WHERE dbID = ?", data, vehicleId)
                else
                    local defaultPlate = getElementData(vehicle, "defaultPlate") or encodeDatabaseId(vehicleId)
    
                    setVehiclePlateText(vehicle, defaultPlate)
                    setElementData(vehicle, "customPlate", false)
                    dbExec(connection, "UPDATE vehicles SET customPlate = ? WHERE dbID = ?", "", vehicleId)
                    value = 0
                end

                plateFound[vehicle] = nil
                triggerClientEvent(client, "gotHeliFixResponse", client, true)
            end
        end, {client, clientVehicle, value, plateMode}, connection, "SELECT * FROM vehicles")
    end
)

addEvent("previewHelicopterVariant", true)
addEventHandler("previewHelicopterVariant", root, 
    function(vehicleElement, previewData)
        if vehicleElement then
            local veh = getPedOccupiedVehicle(client)
            if vehicleElement == veh then
                setVehicleVariant(vehicleElement, previewData, 255)
            end
        end
    end
)

function getCondition(source, key, default)
    local data = getElementData(source, key)
    if type(data) == "table" and data[2] then
        return data[2]
    end
    return default
end

addEvent("requestBikeConditions", true)
addEventHandler("requestBikeConditions", root, 
    function()
        local vehicleElement = getPedOccupiedVehicle(client)
        if vehicleElement then
            local currentEngineWear = getCondition(vehicleElement, 'vehicle.mechanic.engineGeneralKit', 0)
            local currentTimingWear = getCondition(vehicleElement, 'vehicle.mechanic.engineTimingKit', 0)

            local rearBrakesWear = getCondition(vehicleElement, 'vehicle.mechanic.rearBrakes', 0)
            local frontBrakesWear = getCondition(vehicleElement, 'vehicle.mechanic.frontBrakes', 0)

            local currentOilLevel = (getElementData(vehicleElement, "vehicle.oil") or 10000) / 10

            local front = getVehicleWheelStates(vehicleElement)
            local _, rear = getVehicleWheelStates(vehicleElement)
            local dat = {
                math.floor(getElementHealth(vehicleElement) / 10),
                math.floor(100 - currentEngineWear),
                math.floor(100 - currentTimingWear),
                {front == 0 and 100 or 0, rear == 0 and 100 or 0},
                {math.floor(100 - frontBrakesWear), math.floor(100 - rearBrakesWear)},
                math.floor(currentOilLevel)

            }
            triggerClientEvent(client, "gotBikeConditions", client, vehicleElement, dat)
        end
    end
)

addEvent("acceptBikeRepairOffer", true)
addEventHandler("acceptBikeRepairOffer", root, 
    function(vehicleElement, options)

        local veh = getPedOccupiedVehicle(client)

        if vehicleElement == veh then

            local sumTime = 0
            local sum = 0

            local playerMoney = exports.sCore:getMoney(client)

            local dataList = {}

            for k, v in pairs(options) do
                sumTime = sumTime + bikeOptions[k].time
                sum = sum + getItemPrice(vehicleElement, bikeOptions[k].price)
                table.insert(dataList, {bikeOptions[k].name, false, "-", math.ceil(getItemPrice(vehicleElement, bikeOptions[k].price))})
            end

            if playerMoney >= sum then
                exports.sCore:takeMoney(client, sum)
                local passed = true

                local veh = vehicleElement

                local errorCodes = getElementData(veh, "vehicle.errorCodes") or {}
				local tempCodes = {}
				local count = 0
                local pulling = getElementData(veh, "vehicle.pulling")

				for k, v in pairs(errorCodes) do
					count = count + 1
					tempCodes[count] = k
				end

				local passed = true

				if pulling >= 0.02 then
					passed = false
				end
				if #tempCodes > 0 then
				end

                if options[7] then
                    if passed then
                        exports.sGui:showInfobox(client, "s", "Sikeres műszaki vizsga!")
                        outputChatBox("[color=sightgreen][SightMTA - Műszaki vizsga]:#ffffff Megjegyzések:", client, 255, 255, 255)
                        local vehColors = {getVehicleColor(veh, true)}
                        local color = table.concat(vehColors, ',')
                        local currentTime = getRealTime().timestamp
                        local expireTime = currentTime + 2678400
                        local customModel = getElementData(veh, "vehicle.customModel")
                        local realName = exports.sVehiclenames:getCustomVehicleName(customModel) or exports.sVehiclenames:getCustomVehicleName(getElementModel(veh))
                        exports.sItems:giveItem(client, 288, 1, false, toJSON({model = getElementData(veh, "vehicle.customModel") or getElementModel(veh), colors = color, owner = getElementData(client, "char.name"):gsub("_", " "),
                        numberPlate = getVehiclePlateText(veh), isDiesel = getElementData(veh, "dieselFuel") and 1 or 0, driveType = getElementData(veh, "driveType"), expireDate = expireTime / 24 / 60 / 60,
                        creationDate = getRealTime().timestamp, engine = getElementData(veh, "performance.engine"), turbo = getElementData(veh, "performance.turbo"), ecu = getElementData(veh, "performance.ecu"),
                        transmission = getElementData(veh, "performance.transmission"), suspension = getElementData(veh, "performance.suspension"), brake = getElementData(veh, "performance.brakes"),
                        tire = getElementData(veh, "performance.tire"), weightReduction = getElementData(veh, "performance.weightReduction"), rideHeight = getElementData(veh, "rideTuning"),
                        paintjob = getElementData(veh, "paintjob"), backfire = getElementData(veh, "backfire"), wheelPaintjob = getElementData(veh, "wheelPaintjob") ~= 0 and 1,
                        headlightPaintjob = getElementData(veh, "headlightPaintjob") ~= 0 and 1, lsdDoor = getElementData(veh, "lsdDoor"), nitro = getElementData(veh, "nitro"),
                        spinner = getElementData(veh, "spinner") ~= 0, vehicleId = getElementData(veh, "vehicle.dbID")}), realName, getVehiclePlateText(veh))

                        exports.sGui:showInfobox(client, "i", "A műszaki adatlapot megtalálód az inventorydban.")
                        exports.sGui:showInfobox(client, "i", "A forgalmi engedélyt a városházán ezzel tudod kiváltani.")

                    else
                        exports.sGui:showInfobox(client, "e", "Sikertelen műszaki vizsga!")
                        outputChatBox("[color=sightgreen][SightMTA - Műszaki vizsga]:#ffffff Megjegyzések: Hibakódok, futómű.", client, 255, 255, 255)
                    end
    
                end
                if options[1] or options[2] or options[3] or options[4] or options[5] or options[6] then
                    exports.sGui:showInfobox(client, "i", "Megkezdődött a motorod szerelése!")
                end

                if options[1] or options[2] or options[3] or options[4] or options[5] or options[6] or options[7] then
                    local customModel = getElementData(veh, "vehicle.customModel")
                    local realName = exports.sVehiclenames:getCustomVehicleName(customModel) or exports.sVehiclenames:getCustomVehicleName(getElementModel(veh))
                    local vehicleMake = exports.sVehiclenames:getCustomVehicleManufacturer(customModel) or exports.sVehiclenames:getCustomVehicleManufacturer(getElementModel(veh))
                    local vehicleModel = exports.sVehiclenames:getCustomVehicleName(customModel) or exports.sVehiclenames:getCustomVehicleName(getElementModel(veh))
                    local plateText = getVehiclePlateText(veh)
                    local vehicleOdometer = getElementData(veh, "vehicle.distance")
                    local workshop = false

                    local mechanic = false
                    local customer = getElementData(client, "visibleName"):gsub("_", " ")

                    local created = getRealTime().timestamp
                    local vehicleMake = vehicleMake
                    local vehicleModel = vehicleModel
                    local vehiclePlate = plateText
                    local vehicleOdometer = vehicleOdometer

                    local paperData = {}

                    

                    paperData[1] = {
                        "invoice",
                        {
                            list = dataList,
                            sum = {0, sum}
                        },
                    }

                    dbQuery(function(qh, veh, player)
                        local result, _, lastInsertId = dbPoll(qh, 0)
                        exports.sItems:giveItem(player, 439, 1, false, lastInsertId, vehicleModel, getVehiclePlateText(veh))
                    end, {veh, client}, connection, "INSERT INTO serviceInvoices (paperData, workshop, mechanic, customer, created, vehicleMake, vehicleModel, vehiclePlate, vehicleOdometer) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    toJSON(paperData), workshop, mechanic, customer, created, vehicleMake, vehicleModel, vehiclePlate, vehicleOdometer)

                    if options[1] then
                        fixVehicle(veh)
                    end
                    if options[2] then
						setElementData(veh, "vehicle.mechanic.engineGeneralKit", {1, 0})
                    end
                    if options[3] then
						setElementData(veh, "vehicle.mechanic.engineTimingKit", {1, 0})
                    end

                    if options[4] then
                        setVehicleWheelStates(veh, 0, 0, 0, 0)
                    end
                    if options[5] then
						setElementData(veh, "vehicle.mechanic.frontBrakes", {1, 0})
						setElementData(veh, "vehicle.mechanic.rearBrakes", {1, 0})
                    end
                    if options[6] then
                        setElementData(veh, "vehicle.oil", 1000)
                        setVehicleWheelStates(veh, 0, 0, 0, 0)
                    end

                    local endTime = getRealTime().timestamp + (sumTime * 3600)

                    local vehdbID = getElementData(veh, "vehicle.dbID")

                    table.insert(bikesInMechanic, {vehdbID, getElementModel(veh), endTime, getElementData(veh, "vehicle.owner")})
                    triggerClientEvent(client, "gotServiceBikeList", client, getPlayerVehs(getElementData(client, "char.ID")))

                    local occupants = getVehicleOccupants(veh)
                    for k, v in pairs(occupants) do
                        removePedFromVehicle(v)
                    end

                    setElementDimension(veh, vehdbID)

                    setElementPosition(veh, 978.00579833984, -1006.2356567383, 49.771335601807)

                    setElementData(veh, "inService", endTime / 60)

                    dbExec(connection, "UPDATE vehicles SET inService = ? WHERE dbID = ?", endTime / 60, vehdbID)

                end
                exports.sGui:showInfobox(client, "i", "A számlát az inventorydban találod!")
            else
                exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
            end
        end
    end
)

function getPlayerVehs(id)
    local vehs = {}
    for k, v in pairs(bikesInMechanic) do
        local veh = findVehicle(v[1])
        if veh then
            local group = getElementData(veh, "vehicle.group")
            if v[4] == id or exports.sGroups:getPlayerVehicle(id, v[1], group) then
            --if v[4] == id then
                local temp = deepcopy(v)
                
                temp[3] = math.ceil((bikesInMechanic[k][3] - getRealTime().timestamp) / 60)

                table.insert(vehs, temp)
            end
        end
    end
    return vehs
end

addEvent("pickUpBikeInSerivce", true)
function pickUpBikeInSerivce(id)
    local x, y, z = getElementPosition(client)
    local veh = findVehicle(id)

    local found = false

    for k, v in pairs(bikesInMechanic) do
        if v[1] == id then
            table.removeValue(bikesInMechanic, v)
            found = true
        end
    end

    if not found then
        return
    end

    setElementPosition(veh, x, y, z)
    setElementDimension(veh, 0)
    setElementInterior(veh, 0)
    warpPedIntoVehicle(client, veh)
    setElementData(veh, "vehicleNoCol", true)
    setTimer(giveBackCol, 1000 * 35, 1, veh)
    setVehicleDamageProof(veh, false)

    triggerClientEvent(client, "gotServiceBikeList", client, getPlayerVehs(getElementData(client, "char.ID")))

    local vehdbID = getElementData(veh, "vehicle.dbID")

    setElementData(veh, "inService", false)

    dbExec(connection, "UPDATE vehicles SET inService = NULL WHERE dbID = ?", vehdbID)
end
addEventHandler("pickUpBikeInSerivce", root, pickUpBikeInSerivce)

function giveBackCol(veh)
    setElementData(veh, "vehicleNoCol", false)
end

function findVehicle(id)
    local veh = false
    for k, v in pairs(getElementsByType("vehicle")) do
        if getElementData(v, "vehicle.dbID") == id then
            veh = v
        end
    end
    return veh
end

function table.removeValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            table.remove(tab, index)
            return index
        end
    end
    return false
end

addEvent("helicopterVariant", true)
addEventHandler("helicopterVariant", root, 
    function(variant)
        local clientVehicle = getPedOccupiedVehicle(client)
        local clientMoney = exports.sCore:getMoney(client)

        if clientMoney >= 15000 then
            setElementData(clientVehicle, "vehicle.Variant", variant)
            setVehicleVariant(clientVehicle, variant, 255)

            exports.sCore:setMoney(client, clientMoney - 15000)
        end

        triggerClientEvent(client, "gotHeliFixResponse", client)
    end
)

addEvent("helicopterColor", true)
addEventHandler("helicopterColor", root, 
    function(type, r, g, b)
        local clientVehicle = getPedOccupiedVehicle(client)
        local clientMoney = exports.sCore:getMoney(client)
        local colorR1, colorG1, colorB1, colorR2, colorG2, colorB2 = getVehicleColor(clientVehicle, true)

        if clientMoney >= 15000 then
            if type == 1 then
                setVehicleColor(clientVehicle, r, g, b, colorR2, colorG2, colorB2)
            else
                setVehicleColor(clientVehicle, colorR1, colorG1, colorB1, r, g, b)
            end

            exports.sCore:setMoney(client, clientMoney - 15000)
        end

        triggerClientEvent(client, "gotHeliFixResponse", client)
    end
)

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

function saveCache()
	if fileExists("bikes.dat") then
		fileDelete("bikes.dat")
	end
	local f = fileCreate("bikes.dat")
	fileWrite(f, toJSON(bikesInMechanic))
	fileClose(f)
end
addEventHandler("onResourceStop", resourceRoot, saveCache)

addEventHandler("onResourceStart", resourceRoot, 
	function()
        local f = fileOpen("bikes.dat")
        local read = fromJSON(fileRead(f, fileGetSize(f)))
        bikesInMechanic = processJson(read)
        fileClose(f)
	end
)

function processJson(jsonTable)
    local function convertKeys(table)
        local newTable = {}
        for key, value in pairs(table) do
            local numericKey = tonumber(key)
            if numericKey then
                key = numericKey
            end

            if type(value) == "table" then
                newTable[key] = convertKeys(value)
            else
                newTable[key] = value
            end
        end
        return newTable
    end

    return convertKeys(jsonTable)
end

playersInColshapes = {}

doorObjects = {}

doorColshapes = {}

doorPositions = {
    {5856, 1024.98, -1029.35, 32 + 1.2, 90},
    {10575, -2716.35, 217.477, 4.3 + 1.2, 180},
}

doorOpened = {}

for i = 1, #doorPositions do
    local model, x, y, z, rz = doorPositions[i][1], doorPositions[i][2], doorPositions[i][3], doorPositions[i][4], doorPositions[i][5]
    doorObjects[i] = createObject(model, x, y, z)
    setElementRotation(doorObjects[i], 0, 0, rz)
    doorColshapes[i] = createColSphere(x, y, z, 5)
    setElementData(doorColshapes[i], "mechanicDoorColshape", i)
    playersInColshapes[i] = {}
    doorOpened[i] = false
end

function openDoor(i, obj)
    if not doorOpened[i] then
        local model, x, y, z, rz = doorPositions[i][1], doorPositions[i][2], doorPositions[i][3], doorPositions[i][4], doorPositions[i][5]
        stopObject(obj)

        local targetX, targetY, targetZ = x, y, z + 2
        local targetRotX, targetRotY, targetRotZ = 0, 75, rz

        local curRotX, curRotY, curRotZ = getElementRotation(obj)
        local diffRotX = targetRotX - curRotX
        local diffRotY = targetRotY - curRotY
        local diffRotZ = targetRotZ - curRotZ

        moveObject(obj, 5000, targetX, targetY, targetZ, diffRotX, diffRotY, diffRotZ, "InOutQuad")
        doorOpened[i] = true
    end
end


function closeDoor(i, obj)
    if doorOpened[i] then
        local model, x, y, z, rz = doorPositions[i][1], doorPositions[i][2], doorPositions[i][3], doorPositions[i][4], doorPositions[i][5]
        stopObject(obj)
        local curRotX, curRotY, curRotZ = getElementRotation(obj)
        
        local targetRotX = 0
        local targetRotY = 0
        local targetRotZ = rz
        
        local diffRotX = targetRotX - curRotX
        local diffRotY = targetRotY - curRotY
        local diffRotZ = targetRotZ - curRotZ
        
        moveObject(obj, 5000, x, y, z, diffRotX, diffRotY, diffRotZ, "InOutQuad")
        
        doorOpened[i] = false
    end
end


function colHit(hitElement, matchDim)
    if hitElement and matchDim and isElement(source) then
        local mechDoor = getElementData(source, "mechanicDoorColshape")
        if mechDoor then
            openDoor(mechDoor, doorObjects[mechDoor])
            table.insert(playersInColshapes[mechDoor], hitElement)
        end
    end
end
addEventHandler("onColShapeHit", root, colHit)

function colLeave(hitElement, matchDim)
    if hitElement and matchDim then
        local mechDoor = getElementData(source, "mechanicDoorColshape")
        if mechDoor then
            openDoor(mechDoor, doorObjects[mechDoor])
            table.removeValue(playersInColshapes[mechDoor], hitElement)
            if #playersInColshapes[mechDoor] == 0 then
                closeDoor(mechDoor, doorObjects[mechDoor])
            end
        end
    end
end
addEventHandler("onColShapeLeave", root, colLeave)