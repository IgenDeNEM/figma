local connection = false

addEventHandler("onResourceStart", getRootElement(), function(res)
    local resName = getResourceName(res)

    if res == getThisResource() then
        connection = exports.sConnection:getConnection()
    elseif resName == "sConnection" then
        connection = exports.sConnection:getConnection()
    end
end)

local rentedVehicles = {}

function givePlayerRentedVehicle(playerElement, vehicleElement)
    rentedVehicles[playerElement] = vehicleElement
    requestPlayerVehicleList(playerElement, vehicleElement)
end

function requestPlayerVehicleList(client, rentedVehicle)
    dbQuery(function(qh, client, rentedVehicle)
        local result = dbPoll(qh, 0)
        local temp = {}

        hasRentedVehicle = exports.sVehiclerent:getPlayerRentedVehicle(client)


        if hasRentedVehicle and isElement(hasRentedVehicle) then
            local rentedVehicle = hasRentedVehicle
            table.insert(temp, {
                vehicleId = 9000,
                model = getElementModel(rentedVehicle),
                odometer = getElementData(rentedVehicle, "vehicle.distance"),
                impounded = false,
                plate = getVehiclePlateText(rentedVehicle),
                customModel = getElementData(rentedVehicle, "vehicle.customModel"),
                inService = false,
                isElectric = getElementData(rentedVehicle, "vehicle.customModel") and getElementData(rentedVehicle, "vehicle.customModel") == "model_s",
                isRented = true,
                rentTime = exports.sVehiclerent:getVehicleRentTime(client)
            })
        end

        for i = 1, #result do
            if result[i] then
                if result[i].customPlate then
                    if utf8.len(result[i].customPlate) > 0 then
                        plate = result[i].customPlate
                    end
                else
                    plate = result[i].plate
                end
                local customModel = result[i].customModel ~= "false" and result[i].customModel or false
                if not result[i].groupPrefix or result[i].groupPrefix == 0 or result[i].groupPrefix == "0" then
                    table.insert(temp, {
                        vehicleId = result[i].dbID,
                        model = result[i].modelId,
                        odometer = result[i].distance,
                        impounded = result[i].impounded == 0 and false or (result[i].impounded > 0 and result[i].impounded),
                        plate = plate,
                        customModel = customModel,
                        inService = result[i].inService,
                        isElectric = customModel and customModel == "model_y" or customModel == "model_s" or customModel == "leaf"
                    })
                end
            end
        end

        triggerClientEvent(client, "gotPlayerVehicleList", client, temp, getElementData(client, "char.vehiclesSlot") or 0)
    end, {client, rentedVehicle}, connection, "SELECT * FROM vehicles WHERE characterId = ?", getElementData(client, "char.ID"))
end

addEvent("requestPlayerVehicleList", true)
addEventHandler("requestPlayerVehicleList", getRootElement(), function()
    requestPlayerVehicleList(client)
end)

addEvent("markVehicleOnGPS", true)
addEventHandler("markVehicleOnGPS", root, 
    function(vehicleId)
        if vehicleId then
            for k, v in ipairs(getElementsByType("vehicle")) do
                if getElementData(v, "vehicle.dbID") == vehicleId then
                    triggerClientEvent(client, "gotVehicleGPSMark", client, v)
                end
            end
        end
    end
)

addEvent("canStartVehicleSelling", true)
addEventHandler("canStartVehicleSelling", root, 
    function(vehicleId)
        for k, v in ipairs(getElementsByType("vehicle")) do
            if getElementData(v, "vehicle.dbID") == vehicleId then
                local clientX, clientY, clientZ = getElementPosition(client)
                local vehicleX, vehicleY, vehicleZ = getElementPosition(v)

                if getDistanceBetweenPoints3D(clientX, clientY, clientZ, vehicleX, vehicleY, vehicleZ) <= 10 then
                    triggerClientEvent(client, "canStartVehicleSelling", client)
                else
                    exports.sGui:showInfobox(client, "e", "A kiválasztott jármű túl messze van tőled!")
                end
            end
        end
    end
)

addEvent("requestVehiclePreviewData", true)
addEventHandler("requestVehiclePreviewData", getRootElement(), function(vehicleId)
    dbQuery(function(qh, client)
        local result = dbPoll(qh, 0)
        local temp = {}

        for i = 1, #result do
            if result[i] and result[i].dbID == vehicleId then
                local performance = fromJSON(result[i].performanceTuning)

                local spinner = fromJSON(result[i].spinnerColor)
                table.insert(spinner, 1, result[i].spinner)

                local opticalTunings = fromJSON(result[i].opticalTunings)

                local driveType = result[i].driveType

                if driveType == "handling" then
                    driveType = getModelHandling(result[i].modelId).driveType
                end
                
                fuelRate = false

                plate = result[i].plate
                local customModel = result[i].customModel ~= "false" and result[i].customModel or false
                for k, v in ipairs(getElementsByType("vehicle")) do
                    if getElementData(v, "vehicle.dbID") == vehicleId then
                        fuelLevel = getElementData(v, "vehicle.fuel")
                        local chargingState = getElementData(v, "vehicle.onCharging")
                        if chargingState then
                            if chargingState[3] then
                                fuelRate = 0.04
                            else
                                fuelRate = 0.08
                            end
                        end
                    end
                end
                local variant = result[i].variant and fromJSON(result[i].variant) or {255, 255}
                variant = variant[1]
                if spinner and spinner[1] == 0 then
                    spinner = false
                end

                
                temp = {
                    frontWheelWidth = result[i].wheelWidthFront,
                    rearWheelWidth = result[i].wheelWidthRear,
                    model = result[i].modelId,
                    spinner = spinner,
                    traffiRadar = result[i].traffipaxRadar,
                    currentVariant = variant,
                    offroadSetting = result[i].offroadSetting,
                    optical14 = opticalTunings[14],
                    optical15 = opticalTunings[15],
                    optical3 = opticalTunings[3],
                    optical0 = opticalTunings[0],
                    optical2 = opticalTunings[2],
                    optical7 = opticalTunings[7],
                    optical12 = opticalTunings[12],
                    optical13 = opticalTunings[13],
                    rideHeight = getModelHandling(result[i].modelId).suspensionLowerLimit,
                    customPaintjob = result[i].paintjob == -1,
                    paintjob = result[i].paintjob > 0 and result[i].paintjob,
                    wheelPaintjob = result[i].currentWheelTexture > 0 and result[i].currentWheelTexture,
                    headlightPaintjob = result[i].currentHeadlightTexture > 0 and result[i].currentHeadlightTexture,
                    col = fromJSON(result[i].color),
                    health = result[i].health,
                    panelState = {[0] = 0, 0, 0, 0, 0, 0, 0},
                    doorState = {[0] = 0, 0, 0, 0, 0, 0},
                    abs = result[i].abs > 0 and result[i].abs,
                    engine = result[i].engine,
                    batteryCharge = 100,
                    batteryRate = 30,
                    fuelType = result[i].fuelType,
                    fuelLevel = fuelLevel,
                    fuelRate = fuelRate,
                    backfire = result[i].backfire > 0 and result[i].backfire,
                    impounded = result[i].impounded == 0 and false or result[i].impounded,
                    lsdDoor = result[i].lsdDoor == 1,
                    nosFillType = fromJSON(result[i].nitroLevel)[1],
                    nosLevel = fromJSON(result[i].nitroLevel)[2],
                    vehicleId = result[i].dbID,
                    driveType = driveType,
                    plate = plate,
                    customModel = customModel,
                    tankSize = exports.sVehicles:getTankSize(result[i].modelId),
                    inService = result[i].inService,
                    isElectric = customModel and customModel == "model_y" or customModel == "model_s" or customModel == "leaf",
                    odometer = result[i].distance,
                    rideTuning = (result[i].airride and result[i].airride > 0) and result[i].airride or "Gyári",
                    protected = result[i].protected
                }

                local performanceTuning = fromJSON(result[i].performanceTuning)

                for key, value in pairs(performanceTuning) do
                    temp["performance." .. key] = value
                end
            end
        end

        if temp.customPaintjob then
            if fileExists(":sCustompj/server/" .. temp.vehicleId .. ".png") then
                local file = fileOpen(":sCustompj/server/" .. temp.vehicleId .. ".png")
                local content = fileRead(file, fileGetSize(file))
                fileClose(file)
                
                triggerClientEvent(client, "gotPreviewVehicleCustomPaintjob", client, temp.vehicleId, content)

                content = nil
                collectgarbage("collect")
            end
        end

        triggerClientEvent(client, "gotPreviewVehicleDatas", client, temp.vehicleId, temp)
    end, {client}, connection, "SELECT * FROM vehicles WHERE characterId = ?", getElementData(client, "char.ID"))
end)

addEvent("buyVehicleSlot", true)
addEventHandler("buyVehicleSlot", getRootElement(), function(amount)
    if client == source then
        if amount > 0 then

            local pp = exports.sCore:getPP(client)
            
            if pp >= (amount * 100) then
                local newAmount = (getElementData(client, "char.vehiclesSlot") or 0) + amount

                exports.sCore:takePP(client, amount * 100)

                setElementData(client, "char.vehiclesSlot", newAmount)

                dbExec(connection, "UPDATE characters SET vehiclesSlot = ? WHERE characterId = ?", newAmount, getElementData(client, "char.ID"))

                triggerClientEvent(client, "changeVehicleSlotAmount", client, newAmount)
                requestPlayerVehicleList(client)
                exports.sGui:showInfobox(client, "s", "Sikeres vásárlás!")
            else
                exports.sGui:showInfobox(client, "e", "Nincs elég PrémiumPontod!")
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #62 - sDashboard @sourceS:249")
    end
end)

addCommandHandler("addvehlimit", function(sourcePlayer, commandName, targetPlayer, limitAmount)
    if exports.sPermission:hasPermission(sourcePlayer, "addvehlimit") then
        if not targetPlayer or not tonumber(limitAmount) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/"..commandName.." [Játékos Név / ID] [Mennyiség]", sourcePlayer)
            return
        end

        local limitAmount = tonumber(limitAmount)
        local targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
        local newAmount = (getElementData(targetPlayer, "char.vehiclesSlot") or 0) + limitAmount

        if targetPlayer and isElement(targetPlayer) then
            setElementData(targetPlayer, "char.vehiclesSlot", newAmount)

            dbExec(connection, "UPDATE characters SET vehiclesSlot = ? WHERE characterId = ?", newAmount, getElementData(targetPlayer, "char.ID"))

            triggerClientEvent(targetPlayer, "changeVehicleSlotAmount", targetPlayer, newAmount)

            local adminRank = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
            local adminName = adminRank .. " " .. getElementData(sourcePlayer, "acc.adminNick")

            local oldAmount = newAmount - limitAmount

            outputChatBox("[color=sightgreen][SightMTA - Slot]: [color=hudwhite]Sikeresen megváltoztattad [color=sightgreen]"..targetName.." [color=hudwhite]járműveinek a maximális számát! ("..oldAmount.." > "..limitAmount..")", sourcePlayer)
            outputChatBox("[color=sightgreen][SightMTA - Slot]: [color=hudwhite]"..adminName.."[color=hudwhite] hozzáadott a maximális járműved számaihoz! [color=sightgreen]("..oldAmount.." > "..newAmount..")", targetPlayer)
        end
    end
end)

addCommandHandler("setvehlimit", function(sourcePlayer, commandName, targetPlayer, limitAmount)
    if exports.sPermission:hasPermission(sourcePlayer, "setvehlimit") then
        if not targetPlayer or not tonumber(limitAmount) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/"..commandName.." [Játékos Név / ID] [Mennyiség]", sourcePlayer)
            return
        end

        local limitAmount = tonumber(limitAmount)
        local targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
        local oldAmount = (getElementData(targetPlayer, "char.vehiclesSlot") or 0)

        if targetPlayer and isElement(targetPlayer) then
            setElementData(targetPlayer, "char.vehiclesSlot", limitAmount)

            dbExec(connection, "UPDATE characters SET vehiclesSlot = ? WHERE characterId = ?", limitAmount, getElementData(sourcePlayer, "char.ID"))

            triggerClientEvent(targetPlayer, "changeVehicleSlotAmount", targetPlayer, limitAmount)

            local adminRank = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
            local adminName = adminRank .. " " .. getElementData(sourcePlayer, "acc.adminNick")

            outputChatBox("[color=sightgreen][SightMTA - Slot]: [color=hudwhite]Sikeresen megváltoztattad [color=sightgreen]"..targetName.." [color=hudwhite]járműveinek a maximális számát! ("..oldAmount.." > "..limitAmount..")", sourcePlayer)
            outputChatBox("[color=sightgreen][SightMTA - Slot]: [color=hudwhite]"..adminName.."[color=hudwhite] megváltoztatta a maximális járműved számait! [color=sightgreen]("..oldAmount.." > "..limitAmount..")", targetPlayer)
        end
    end
end)