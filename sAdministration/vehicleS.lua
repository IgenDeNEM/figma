local connection = false

addEventHandler("onResourceStart", getRootElement(), function(res)
    local resName = getResourceName(res)

    if res == getThisResource() then
        connection = exports.sConnection:getConnection()
    elseif resName == "sConnection" then
        connection = exports.sConnection:getConnection()
    end
end)

function gotocarCommand(client, commandName, targetVehicle)
    if exports.sPermission:hasPermission(client, "gotocar") then
        targetVehicle = tonumber(targetVehicle)

        if targetVehicle then
            local veh = findVehicle(client, targetVehicle)

            if isElement(veh) then
                local x, y, z = getElementPosition(veh)
                local int = getElementInterior(veh)
                local dim = getElementDimension(veh)
                local rx, ry, rz = getElementRotation(veh)

                x = x + math.cos(math.rad(rz)) * 2
                y = y + math.sin(math.rad(rz)) * 2

                setElementPosition(client, x, y, z)
                setElementRotation(client, 0, 0, rz)
                setElementInterior(client, int)
                setElementDimension(client, dim)
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Jármű azonosító]", client, 255, 255, 255, true)
        end
    end
end
addCommandHandler("gotocar", gotocarCommand)
addCommandHandler("gotoveh", gotocarCommand)

function getcarCommand(client, commandName, targetVehicle)
    if exports.sPermission:hasPermission(client, "getcar") then
        targetVehicle = tonumber(targetVehicle)

        if targetVehicle then
            local veh = findVehicle(client, targetVehicle)

            if veh then
                if getElementData(veh, "vehicle.impounded") and getElementData(veh, "vehicle.impounded") == 1 or getElementData(veh, "vehicle.impounded") == 2 then
                    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Ez a jármű levan foglalva!", client)
                    return
                end
                local service = getElementData(veh, "inService")
                if service then
                    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Ez a jármű szervízben van!", client)
                    return
                end
            end

            if isElement(veh) then
                local x, y, z = getElementPosition(client)
                local int = getElementInterior(client)
                local dim = getElementDimension(client)
                local rx, ry, rz = getElementRotation(client)

                x = x + math.cos(math.rad(rz)) * 2
                y = y + math.sin(math.rad(rz)) * 2

                setElementPosition(veh, x, y, z)
                setElementRotation(veh, 0, 0, rz)
                setElementInterior(veh, int)
                setElementDimension(veh, dim)

                exports.sNocol:enableVehicleNoCol(veh, 10000)
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Jármű azonosító]", client, 255, 255, 255, true)
        end
    end
end
addCommandHandler("getcar", getcarCommand)
addCommandHandler("getveh", getcarCommand)

local fixTypes = {"global", "obd", "battery", "batteryCharge", "engineGeneral", "engineSimple", "tyre", "chassis", "suspension"}
local validFixTypes = {
    global = true,
    obd = true,
    battery = true,
    batteryCharge = true,
    engineGeneral = true,
    engineSimple = true,
    tyre = true,
    chassis = true,
    suspension = true
}
local fixTypeNames = {
    global = "Full szervíz",
    obd = "Hibakód",
    battery = "Akkumlátor",
    batteryCharge = "Akkumlátor töltöttség",
    engineGeneral = "Motor nagyszervíz",
    engineSimple = "Motor kisszervíz",
    tyre = "Kerekek",
    chassis = "Kasztni",
    suspension = "Felfüggesztés"
}

function getCondition(source, key, default)
    local data = getElementData(source, key)
    if type(data) == "table" and data[2] then
        return data[2]
    end
    return default
end

function fixvehCommand(client, commandName, fixType, targetPlayer, silent)
    if exports.sPermission:hasPermission(client, "fixveh") then
        local silent = tonumber(silent)
        if targetPlayer and validFixTypes[fixType] then
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if isElement(targetPlayer) then
                local veh = getPedOccupiedVehicle(targetPlayer)

                if isElement(veh) then

                    if silent and not exports.sPermission:hasPermission(client, "hiddenFixveh") then
                        silent = false
                    end

                    local adminNick = getElementData(client, "acc.adminNick")
                    local adminTitle = getPlayerAdminTitle(client) .. " " .. adminNick
                    triggerClientEvent(getRootElement(), "sendMessageToAdmins", client, adminTitle .. "[color=hudwhite] megjavította [color=sightblue]" .. targetName .. " [color=hudwhite]járművét. [color=sightgreen](" .. fixTypeNames[fixType] .. ")")

                    if not silent then
                        outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. adminNick .. "[color=hudwhite] megjavította a járművedet. [color=sightgreen](" .. fixTypeNames[fixType] .. ")", targetPlayer)
                    end
                    if fixType == "global" then
                        setElementData(veh, "vehicle.checkengine", 0)
                        triggerClientEvent(getVehicleOccupants(veh), "gotCheckEngineLightLevel", veh, 0)
                        fixVehicle(veh)

                        
                        setElementData(veh, 'vehicle.batteryCharge', 2048)
                        setElementData(veh, 'vehradio.broken', false)
                        setElementData(veh, 'vehicle.maxBatteryCharge', 2048)
                        local batteryRate = getElementData(veh, "vehicle.batteryRate")
                        triggerClientEvent(getVehicleOccupants(veh), "gotVehicleBatteryCharge", veh, 2048, 2048, 2048, batteryRate)

                        setElementData(veh, 'vehicle.mechanic.rearRightPanel', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.rearRightSuspension', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.rearLeftSuspension', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.frontRightSuspension', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.frontLeftSuspension', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.rearLeftDoor', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.rearBrakes', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.frontBrakes', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.trunk', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.frontBumper', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.windscreen', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.frontRightLight', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.frontTires', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.frontRightPanel', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.frontLeftPanel', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.fuelRepairKit', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.hood', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.frontLeftLight', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.battery', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.engineTimingKit', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.rearLeftLight', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.rearRightLight', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.rearBumper', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.rearRightDoor', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.engineGeneralKit', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.engineRepairKit', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.oilChangeKit', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.rearLeftPanel', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.rearTires', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.frontRightDoor', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.frontLeftDoor', {2, 0})

                        setElementData(veh, "vehicle.errorCodes", {})
                        setElementData(veh, "vehicle.checkengine", 0)

                        local fl = getCondition(veh, 'vehicle.mechanic.frontLeftSuspension', 0)
                        local rl = getCondition(veh, 'vehicle.mechanic.rearLeftSuspension', 0)
                        local fr = getCondition(veh, 'vehicle.mechanic.frontRightSuspension', 0)
                        local rr = getCondition(veh, 'vehicle.mechanic.rearRightSuspension', 0)
                    
                        local fl = 100 - fl
                        local rl = 100 - rl
                        local fr = 100 - fr
                        local rr = 100 - rr

                        setElementData(veh, "vehicle.pulling", 0)
                        triggerClientEvent(getVehicleOccupants(veh), "gotVehicleSuspensionState", veh, fl, rl, fr, rr)

                        local currentTimingWear = getCondition(veh, 'vehicle.mechanic.engineTimingKit', 0)

                        if clientVehicle then
                            currentTimingWear = 100 - currentTimingWear
                    
                            triggerClientEvent(getVehicleOccupants(veh), "gotVehicleTimingState", veh, currentTimingWear)
                        end

                        setElementData(veh, "vehicle.oil", 1000)
                        local vehicleOccupants = getVehicleOccupants(veh)
                        triggerClientEvent(vehicleOccupants, "gotVehicleOilLevel", veh, 1000)

                    elseif fixType == "obd" then
                        setElementData(veh, "vehicle.errorCodes", {})
                        setElementData(veh, "vehicle.checkengine", 0)
                        triggerClientEvent(getVehicleOccupants(veh), "gotCheckEngineLightLevel", veh, 0)
                    elseif fixType == "battery" then
                        setElementData(veh, 'vehicle.batteryCharge', 2048)
                        setElementData(veh, 'vehicle.maxBatteryCharge', 2048)
                        local batteryRate = getElementData(veh, "vehicle.batteryRate")
                        triggerClientEvent(getVehicleOccupants(veh), "gotVehicleBatteryCharge", veh, 2048, 2048, 2048, batteryRate)
                    elseif fixType == "batteryCharge" then
                        setElementData(veh, 'vehicle.batteryCharge', 2048)
                        setElementData(veh, 'vehicle.maxBatteryCharge', 2048)
                        local batteryRate = getElementData(veh, "vehicle.batteryRate")
                        triggerClientEvent(getVehicleOccupants(veh), "gotVehicleBatteryCharge", veh, 2048, 2048, 2048, batteryRate)
                    elseif fixType == "engineGeneral" then
                        setElementHealth(veh, 1000)
                        setElementData(veh, 'vehicle.mechanic.engineGeneralKit', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.engineRepairKit', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.engineTimingKit', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.oilChangeKit', {2, 0})

                        setElementData(veh, "vehicle.oil", 1000)
                        local vehicleOccupants = getVehicleOccupants(veh)
                        triggerClientEvent(vehicleOccupants, "gotVehicleOilLevel", veh, 1000)
                    elseif fixType == "engineSimple" then
                        setElementHealth(veh, 1000)
                        setElementData(veh, 'vehicle.mechanic.engineRepairKit', {2, 0})
                        setElementData(veh, "vehicle.oil", 1000)
                        local vehicleOccupants = getVehicleOccupants(veh)
                        triggerClientEvent(vehicleOccupants, "gotVehicleOilLevel", veh, 1000)
                    elseif fixType == "tyre" then
                        setVehicleWheelStates(veh, 0, 0, 0, 0)
                    elseif fixType == "chassis" then
                        for i = 0, 6 do
                            setVehiclePanelState(veh, i, 0)
                        end
                        for i = 0, 5 do
                            setVehicleDoorState(veh, i, 0)
                        end
                        setElementData(veh, 'vehradio.broken', false)
                    elseif fixType == "suspension" then
                        setElementData(veh, 'vehicle.mechanic.rearRightSuspension', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.rearLeftSuspension', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.frontRightSuspension', {2, 0})
                        setElementData(veh, 'vehicle.mechanic.frontLeftSuspension', {2, 0})
                        

                        local fl = getCondition(veh, 'vehicle.mechanic.frontLeftSuspension', 0)
                        local rl = getCondition(veh, 'vehicle.mechanic.rearLeftSuspension', 0)
                        local fr = getCondition(veh, 'vehicle.mechanic.frontRightSuspension', 0)
                        local rr = getCondition(veh, 'vehicle.mechanic.rearRightSuspension', 0)
                    
                        local fl = 100 - fl
                        local rl = 100 - rl
                        local fr = 100 - fr
                        local rr = 100 - rr

                        setElementData(veh, "vehicle.pulling", 0)
                        triggerClientEvent(getVehicleOccupants(veh), "gotVehicleSuspensionState", veh, fl, rl, fr, rr)
                    end

                    local adminAccID = getElementData(client, "char.accID")
                    local connection = exports.sConnection:getConnection()

                    if adminAccID and connection then
                        dbQuery(function(queryHandle)
                            local result = dbPoll(queryHandle, 0)
                            local playerFixesData = {}

                            if result and #result > 0 then
                                local jsonData = result[1].vehicleFixes
                                if jsonData and jsonData ~= "" then
                                    playerFixesData = fromJSON(jsonData)
                                    if not playerFixesData then
                                        playerFixesData = {}
                                    end
                                end
                            else
                                dbExec(connection, "INSERT INTO adminstats (characterIdentity, vehicleFixes) VALUES (?, ?)", adminAccID, "[]")
                            end

                            local newFixData = {
                                fixTypeName = fixTypeNames[fixType],
                                vehicleId = getElementData(veh, "vehicle.dbID") or -1,
                                targetPlayerName = targetName,
                                timestamp = getRealTime().timestamp
                            }

                            table.insert(playerFixesData, newFixData)

                            local newJsonData = toJSON(playerFixesData)

                            dbExec(connection, "UPDATE adminstats SET vehicleFixes = ? WHERE characterIdentity = ?", newJsonData, adminAccID)
                        end, connection, "SELECT vehicleFixes FROM adminstats WHERE characterIdentity = ?", adminAccID)
                    else
                        outputDebugString("[fixvehCommand] Error: Could not retrieve admin account ID or database connection.", 1)
                    end
                else
                    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A kiválasztott játékos nem ül járműben!", client, 255, 255, 255, true)
                end
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Szerelési típus] [Játékos Név / ID] [silent = 1]", client, 255, 255, 255, true)
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]Szerelési típusok:", client, 255, 255, 255, true)
            for i = 1, #fixTypes do
                outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]" .. fixTypes[i], client, 255, 255, 255, true)
            end
        end
    end
end
addCommandHandler("fixcar", fixvehCommand)
addCommandHandler("fixveh", fixvehCommand)

function findVehicle(client, targetVehicle)
    local vehicleId = tonumber(targetVehicle)

    if vehicleId then
        local foundVehicle = false

        for k, v in pairs(getElementsByType("vehicle")) do
            if getElementData(v, "vehicle.dbID") == vehicleId then
                foundVehicle = v

                break
            end
        end

        if isElement(foundVehicle) then
            return foundVehicle
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nincs találat a kiválasztott járműre!", client)
        end
    else
        outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nincs találat a kiválasztott járműre!", client)
    end
end

addCommandHandler("startveh", function(sourcePlayer, sourceCommand, targetPlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "forcestartvehicle") then
        if not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/startveh [Játékos Név / ID]", sourcePlayer)
            return
        end
        
        targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
        if  isElement(targetPlayer) then

            local veh = getPedOccupiedVehicle(targetPlayer)

            if veh then
                local vehicleDistance = getElementData(veh, "vehicle.distance") or 0
                local currentTimeStamp = getRealTime().timestamp
                setElementData(veh, "vehicle.ignition", true)
                setElementData(veh, "vehicle.startTime", currentTimeStamp)
                setElementData(veh, "vehicle.startDistance", vehicleDistance)
                setVehicleEngineState(veh, true)
                setElementData(veh, "vehicle.engine", true)
                setElementData(veh, "vehicle.gear", "N")
                
                local vehicleOccupants = getVehicleOccupants(veh)
                local batteryLevel = getElementData(veh, "vehicle.batteryCharge") or 2048
                local maxBatteryCharge = getElementData(veh, "vehicle.maxBatteryCharge") or 2048
                local batteryRate = math.abs(exports.sVehicles:getBatteryValues(veh, "engine"))
                if batteryLevel < 0 then
                    batteryLevel = 0
                    setElementData(veh, "vehicle.batteryCharge", 0)
                end
                local charge = maxBatteryCharge
                if charge < 0 then charge = 0 end
                setElementData(veh, "vehicle.maxBatteryCharge", charge)
                triggerClientEvent(vehicleOccupants, "gotVehicleBatteryCharge", veh, batteryLevel, charge, 2048, batteryRate)
                setElementData(veh, "vehicle.batteryRate", batteryRate)
                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A jármű sikeresen beindítva!", sourcePlayer)
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A játékos nem ül járműben.", sourcePlayer)
            end
        end
    end
end)

addCommandHandler("blowveh", function(sourcePlayer, sourceCommand, vehicleId)
    if not exports.sPermission:hasPermission(sourcePlayer, "blowvehicle") then
        return
    end

    local vehicleId = tonumber(vehicleId)
    if not vehicleId then
        outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/blowveh [Jármű ID]", sourcePlayer)
        return
    end

    for _, vehicle in ipairs(getElementsByType("vehicle")) do
        if tonumber(getElementData(vehicle, "vehicle.dbID")) == vehicleId then
            blowVehicle(vehicle)
            outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A(z) [color=sightgreen]" .. vehicleId .. " [color=hudwhite]azonosítóval rendelkező jármű felrobbantva!", sourcePlayer)

            local adminName = getElementData(sourcePlayer, "acc.adminNick")
            local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #fffffffelrobbantotta a(z) [color=sightgreen]" .. vehicleId .. " [color=hudwhite] azonosítójú járművet.")
            return
        end
    end

    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található ilyen azonosítójú jármű!", sourcePlayer)
end)


addCommandHandler({"respawnveh", "rtc"}, function(sourcePlayer, sourceCommand, vehicleId)
    if not exports.sPermission:hasPermission(sourcePlayer, "rtc") then
        return
    end

    local vehicleId = tonumber(vehicleId)
    if not vehicleId then
        outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/".. sourceCommand .." [Jármű ID]", sourcePlayer)
        return
    end

    for _, vehicle in ipairs(getElementsByType("vehicle")) do
        if tonumber(getElementData(vehicle, "vehicle.dbID")) == vehicleId then
            if sourceCommand == "respawnveh" then
                exports.sVehicles:resetVehicle(vehicle)
                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A(z) [color=sightgreen]#" .. vehicleId .. " [color=hudwhite]jármű resetelve!", sourcePlayer)
            else
                respawnVehicle(vehicle)
                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A(z) [color=sightgreen]#" .. vehicleId .. " [color=hudwhite]jármű RTC-zve!", sourcePlayer)
            end

            local adminName = getElementData(sourcePlayer, "acc.adminNick")
            local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
            local action = sourceCommand == "respawnveh" and "resetelte" or "RTC-zte"
            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffff" .. action .. " a(z) [color=sightgreen]" .. vehicleId .. "[color=hudwhite] azonosítójú járművet.")
            return
        end
    end

    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található ilyen ID-vel jármű!" .. vehicleId, sourcePlayer)
end)


addCommandHandler("setvehcolor", function(sourcePlayer, sourceCommand, targetPlayer, hexColor)
    if exports.sPermission:hasPermission(sourcePlayer, "setvehcolor") then
        if not targetPlayer or not hexColor then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/setvehcolor [Játékos Név / ID] [HEX SZÍN]", sourcePlayer)
            return
        end

        targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
        local veh = getPedOccupiedVehicle(targetPlayer)
        local r, g, b = getVehicleColor(veh, true)
        color1 = {r, g, b}

        local color1Hex = rgbToHex(color1[1], color1[2], color1[3])
        local color2Hex = hexColor 
        local r, g, b = hex2rgb(hexColor)

        if r and g and b then
            if veh then
                local oldHex = string.upper(getElementData(veh, "lastColor") or "#000000")

                setVehicleColor(veh, r, g, b)
                setElementData(veh, "lastColor", hexColor)

                outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]A kiválasztott jármű színe módosítva! [color=sightgreen](".. color1Hex .."szín1 [color=hudwhite]→ #" .. color2Hex .. "szín2[color=sightgreen])", sourcePlayer)
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A játékos nem ül járműben.", sourcePlayer)
            end
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Érvénytelen HEX szín.", sourcePlayer)
        end
    end
end)

function hex2rgb(hex)
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

function rgbToHex(r, g, b)
    return string.format("#%.2X%.2X%.2X", r, g, b)
  end

addCommandHandler("oilveh", function(sourcePlayer, sourceCommand, targetPlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "oilveh") then
        if not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/oilveh [Játékos Név / ID]", sourcePlayer)
            return
        end
        
        targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
        if isElement(targetPlayer) then
            local veh = getPedOccupiedVehicle(targetPlayer)

            if veh then
                local oldOil = getElementData(veh, "vehicle.oil") or 0
                setElementData(veh, "vehicle.oil", 1000)
                local vehicleOccupants = getVehicleOccupants(veh)
                triggerClientEvent(vehicleOccupants, "gotVehicleOilLevel", veh, 1000)
                outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]A jármű olajszintje módosítva! (" .. oldOil .. " → 1000)", sourcePlayer)

                local adminName = getElementData(sourcePlayer, "acc.adminNick")
                local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffmódosította [color=sightgreen]" .. targetName .. " #ffffffjárművének olajszintjét: [color=sightgreen]" .. oldOil .. " → 1000")
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A játékos nem ült járműben.", sourcePlayer)
            end
        end
    end
end)


addCommandHandler("setvehhp", function(sourcePlayer, sourceCommand, targetPlayer, hp)
    if exports.sPermission:hasPermission(sourcePlayer, "setvehhp") then
        if not targetPlayer or not hp or tonumber(hp) < 32 or tonumber(hp) > 100 then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/setvehhp [Játékos Név / ID] [32-100]", sourcePlayer)
            return
        end

        hp = tonumber(hp * 10)
        targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

        if hp then
            local veh = getPedOccupiedVehicle(targetPlayer)
            if veh then
                local oldHP = getElementHealth(veh)
                setElementHealth(veh, hp)

                local oldPercent = oldHP / 10
                local newPercent = hp / 10

                local function getColor(percent)
                    if percent < 40 then
                        return "[color=sightred]"
                    elseif percent < 80 then
                        return "[color=sightyellow]"
                    else
                        return "[color=sightgreen]"
                    end
                end

                local oldColor = getColor(oldPercent)
                local newColor = getColor(newPercent)

                outputChatBox(
                    "[color=sightgreen][SightMTA]: [color=hudwhite]A kiválasztott jármű állapota módosítva! (" ..oldColor .. oldPercent .. "% [color=hudwhite]→ " ..newColor .. newPercent .. "%[color=hudwhite])", sourcePlayer)

                local adminName = getElementData(sourcePlayer, "acc.adminNick")
                local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
                showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffmódosította [color=sightgreen]" .. targetName .. " #ffffffjárművének állapotát: [color=sightgreen]" .. oldPercent .. "% → " .. newPercent .. "%")
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A játékos nem ül járműben.", sourcePlayer)
            end
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Érvénytelen érték.", sourcePlayer)
        end
    end
end)



addCommandHandler("setvehfuel", function(sourcePlayer, sourceCommand, targetPlayer, fuelPercent)
    if exports.sPermission:hasPermission(sourcePlayer, "fuelveh") then
        if not targetPlayer or not fuelPercent then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/setvehfuel [Játékos Név / ID] [Fuel 1-100%]", sourcePlayer)
            return
        end
        
        fuelPercent = tonumber(fuelPercent)
        targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

        if fuelPercent and fuelPercent <= 100 then
            local veh = getPedOccupiedVehicle(targetPlayer)
            if veh then
                local model = getElementModel(veh)
                local maxTankSize = exports.sVehicles:getTankSize(model)
                local fuelAmount = (maxTankSize * fuelPercent) / 100
                if fuelAmount then
                    setElementData(veh, "vehicle.fuel", fuelAmount)
                    outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]A jármű üzemanyag szintje módosítva! (" .. fuelAmount .. " liter)", sourcePlayer)

                    local adminName = getElementData(sourcePlayer, "acc.adminNick")
                    local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer)
                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffmódosította [color=sightgreen]" .. targetName .. " #ffffffjárművének üzemanyag szintjét: [color=sightgreen]" .. string.format("%.1f", fuelAmount) .. " liter.")
                else
                    outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Érvénytelen üzemanyag érték.", sourcePlayer)
                end
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A játékos nem ül járműben.", sourcePlayer)
            end
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Érvénytelen üzemanyag érték.", sourcePlayer)
        end
    end
end)


addCommandHandler("getvehfuel", function(sourcePlayer, sourceCommand, targetPlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "getfuel") then
        if not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/getvehfuel [Játékos Név / ID]", sourcePlayer)
            return
        end
        
        targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)

        local veh = getPedOccupiedVehicle(targetPlayer)
        if veh then
            local model = getElementModel(veh)
            local maxTankSize = exports.sVehicles:getTankSize(model)
            local fuelAmount = getElementData(veh, "vehicle.fuel")

            outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]A jármű üzemanyagszintje: ("..fuelAmount.." / "..maxTankSize..")", sourcePlayer)
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A játékos nem ül járműben.", sourcePlayer)
        end
    end
end)

addCommandHandler("unflip", function(client, commandName, targetPlayer)
    if exports.sPermission:hasPermission(client, "unflip") then

        if not targetPlayer then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Játékos Név / ID]", client)
        else
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                local adminName = getElementData(client, "acc.adminNick")
                local adminTitle = exports.sAdministration:getPlayerAdminTitle(client)
                local TargetVeh = getPedOccupiedVehicle(targetPlayer)

                if TargetVeh then
                    local _, rotY, rotZ = getVehicleRotation(TargetVeh)
                    setElementRotation(TargetVeh, 0, rotY, rotZ)
                    setElementFrozen(targetPlayer, true)

                    outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]" .. adminTitle .. " " .. adminName .. " [color=hudwhite]visszafordította a járműved.", targetPlayer)
                    outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite] Sikeresen visszafordítottad a kiválasztott játékos járművét. ([color=sightblue]" .. targetName:gsub("_", " ") .. "[color=hudwhite])", client)

                    showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffvisszafordította [color=sightgreen]" .. targetName .. " #ffffffjárművét.")
                else
                    outputChatBox("[color=sightgreen][SightMTA - Hiba]: [color=hudwhite]A kiválasztott játékos nem ül járműben. ([color=sightblue]" .. targetName:gsub("_", " ") .. "[color=hudwhite])", client)
                end
            end
        end
    end
end)


addCommandHandler("amuszaki", function(client, commandName, targetVehicle)
    if exports.sPermission:hasPermission(client, "amuszaki") then

        local targetVehicle = tonumber(targetVehicle)

        if not targetVehicle then
            outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. commandName .. " [Jármű ID]", client)
        else
            local vehicle = findVehicle(client, targetVehicle)
            if vehicle and isElement(vehicle) then
                local vehColors = {getVehicleColor(vehicle, true)}
                local color = table.concat(vehColors, ',')
                local currentTime = getRealTime().timestamp
                local expireTime = currentTime + 2678400
                local model = getElementData(vehicle, "vehicle.customModel") or getElementModel(vehicle)
                local plateText = getVehiclePlateText(vehicle)
                local vehicleRealName = exports.sVehiclenames:getCustomVehicleName(model) or getVehicleNameFromModel(model)
                exports.sItems:giveItem(client, 288, 1, false, toJSON({model = model, colors = color, owner = getElementData(client, "char.name"):gsub("_", " "),
                numberPlate = getVehiclePlateText(vehicle), isDiesel = getElementData(vehicle, "dieselFuel") and 1 or 0, driveType = getElementData(vehicle, "driveType"), expireDate = expireTime / 24 / 60 / 60,
                creationDate = getRealTime().timestamp, engine = getElementData(vehicle, "performance.engine"), turbo = getElementData(vehicle, "performance.turbo"), ecu = getElementData(vehicle, "performance.ecu"),
                transmission = getElementData(vehicle, "performance.transmission"), suspension = getElementData(vehicle, "performance.suspension"), brake = getElementData(vehicle, "performance.brakes"),
                tire = getElementData(vehicle, "performance.tires"), weightReduction = getElementData(vehicle, "performance.weightReduction"), rideHeight = getElementData(vehicle, "rideTuning"),
                paintjob = getElementData(vehicle, "paintjob"), backfire = getElementData(vehicle, "backfire"), wheelPaintjob = getElementData(vehicle, "wheelPaintjob") ~= 0 and 1,
                headlightPaintjob = getElementData(vehicle, "headlightPaintjob") ~= 0 and 1, lsdDoor = getElementData(vehicle, "lsdDoor"), nitro = getElementData(vehicle, "nitro"),
                spinner = getElementData(vehicle, "spinner") ~= 0, vehicleId = getElementData(vehicle, "vehicle.dbID")}), vehicleRealName, tostring(plateText))
                exports.sGui:showInfobox(client, "i", "A műszaki adatlapot megtalálod az inventorydban.")
            else
                exports.sGui:showInfobox(client, "e", "Nem létezik a jármű!")
            end
        end
    end
end)

function encodeDatabaseId(databaseId)
    local n3 = databaseId % 10
    databaseId = (databaseId - n3) / 10

    local n1 = databaseId % 10
    databaseId = (databaseId - n1) / 10

    local n2 = databaseId % 10
    databaseId = (databaseId - n2) / 10

    local c1 = databaseId % 14
    databaseId = (databaseId - c1) / 14

    local c2 = databaseId % 14
    databaseId = (databaseId - c2) / 14

    return "" .. string.format("%c%c-%c%c-%c%c",
        databaseId + string.byte("A"),
        c2 + string.byte("A"),
        c1 + string.byte("A"),
        n2 + string.byte("A"),
        n1 + string.byte("0"),
        n3 + string.byte("0")
    )
end

addCommandHandler("removeplate", function(client, commandName)
    if exports.sPermission:hasPermission(client, "removeplate") then
        local adminName = getElementData(client, "acc.adminNick")
        local adminTitle = exports.sAdministration:getPlayerAdminTitle(client)

        local TargetVeh = getPedOccupiedVehicle(client)

        if TargetVeh then
            local VehDbID = getElementData(TargetVeh, "vehicle.dbID") or 0
            local GeneratedPlate = encodeDatabaseId(VehDbID)

            dbExec(connection, "UPDATE vehicles SET plate = ? WHERE dbID = ?", GeneratedPlate, VehDbID)
            setVehiclePlateText(TargetVeh, GeneratedPlate)
            triggerClientEvent("applyVehiclePlate", TargetVeh, TargetVeh, true)

            outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen levetted a rendszámot a kiválasztott járműről. ([color=sightblue]" .. VehDbID .. "[color=hudwhite])", client)

            showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #fffffflevette a(z) [color=sightgreen]" .. VehDbID .. " [color=hudwhite] azonosítójú jármű rendszámát.")
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem ülsz járműben.", client)
        end
    end
end)


addCommandHandler("setvehicleplate", 
    function (Client, CommandName, PlateText)
        if not PlateText or PlateText == "" then
            return outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. CommandName .. " [Rendszám]", Client)
        end

        PlateText = tostring(PlateText)
        local CheckStringLength = (utf8.len(PlateText) <= 64 and utf8.len(PlateText) > 0)
        local ClientVeh = getPedOccupiedVehicle(Client)

        if not ClientVeh then 
            return outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem ülsz járműben.", Client)
        end

        if not CheckStringLength then 
            return outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. CommandName .. " [Rendszám]", Client)
        end

        if string.len(PlateText) < 6 then
            outputChatBox("[color=sightred][SightMTA - Hiba]: #ffffffA rendszámnak minimum 6 karakterből kell állnia.", Client)
            return
        end

        if string.len(PlateText) > 8 then
            outputChatBox("[color=sightred][SightMTA - Hiba]: #ffffffA rendszám max 8 karakterből állhat.", Client)
            return
        end

        if not PlateText:match("^[A-Z0-9]+$") then
            return outputChatBox("[color=sightred][SightMTA - Hiba]: #ffffffA rendszám csak betűket és számokat tartalmazhat.", Client)
        end

        local VehDbID = getElementData(ClientVeh, "vehicle.dbID") or 0
        local OldPlate = getVehiclePlateText(ClientVeh)

        dbExec(connection, "UPDATE vehicles SET plate = ? WHERE dbID = ?", PlateText, VehDbID)
        setVehiclePlateText(ClientVeh, PlateText)

        triggerClientEvent("applyVehiclePlate", ClientVeh, ClientVeh, true)

        outputChatBox("[color=sightgreen][SightMTA - Siker]: [color=hudwhite]Sikeresen megváltoztattad a  kiválasztott jármű rendszámát. [color=sightgreen](" .. VehDbID .. "[color=sightgreen]" .. OldPlate .. " [color=hudwhite]→ [color=sightgreen]" .. PlateText .. ")", Client)

        local adminName = getElementData(Client, "acc.adminNick")
        local adminTitle = exports.sAdministration:getPlayerAdminTitle(Client)
        showMessageForAdmins("[color=sightgreen][SightMTA - [color=sightblue]AdminNapló] " .. adminTitle .. " " .. adminName .. " #ffffffmódosította a(z) [color=sightgreen]" .. VehDbID .. "[color=hudwhite] azonosítóval rendelkező jármű rendszámát! [color=sightgreen](" .. OldPlate .. " #ffffff→ [color=sightgreen]" .. PlateText .. ")")
    end 
)

addCommandHandler("beszall", function(sourcePlayer)
    if exports.sPermission:hasPermission(sourcePlayer, "beszall") then
        local playerPosition = {getElementPosition(sourcePlayer)}
        local nearestVehicle = false
        local lastDistance = false

        local vehicleOccupants = {}

        for _, vehicleElement in pairs(getElementsByType("vehicle")) do
            local vehiclePosition = {getElementPosition(vehicleElement)}
            local vehDistance = getDistanceBetweenPoints3D(playerPosition[1], playerPosition[2], playerPosition[3], vehiclePosition[1], vehiclePosition[2], vehiclePosition[3]) 
            
            if not lastDistance then
                lastDistance = vehDistance
            end
            
            if vehDistance < lastDistance then
                vehicleOccupants = getVehicleOccupants(vehicleElement)
                local maxVehicleOccupants = getVehicleMaxPassengers(vehicleElement)

                if vehicleOccupants and maxVehicleOccupants ~= #vehicleOccupants then
                    lastDistance = vehDistance
                    selectedVehicle = vehicleElement
                end
            end
        end

        local selectedSeat = false

        for i = 0, getVehicleMaxPassengers(selectedVehicle) do
            local vehOccupants = getVehicleOccupants(selectedVehicle)
            if not vehOccupants[i] then
                selectedSeat = i
                break
            end
        end


        outputChatBox("[color=sightgreen][SightMTA - Vehicles]: [color=hudwhite]Sikeresen beszáltál a hozzád legközelebb álló autóba!", sourcePlayer)
        warpPedIntoVehicle(sourcePlayer, selectedVehicle, selectedSeat)
    end
end)

addCommandHandler("nitrolevel", function(sourcePlayer, commandName, vehicleIdentity, nitroType, nitroLevel)
    if exports.sPermission:hasPermission(sourcePlayer, "csinkonitro") then
        if not (vehicleIdentity or tonumber(vehicleIdentity)) or not (nitroType or tonumber(nitroType)) or not (tonumber(nitroType) >= 1 or tonumber(nitryType) <= 2) or not (nitroLevel or tonumber(nitroLevel)) or not (tonumber(nitroLevel) >= 1 and tonumber(nitroLevel) <= 4) then
            outputChatBox("[color=sightblue][SightMTA - Nitro]: [color=hudwhite]/"..commandName.." [Jármű ID] [Típus (1 - Sima, 2 - Prémium)] [Nitró Szint (1 - 4)]", sourcePlayer)
            return
        end

        local vehicleElement = findVehicle(sourcePlayer, vehicleIdentity)

        if vehicleElement then
            setElementData(vehicleElement, "nitro", true)
            setElementData(vehicleElement, "nitroLevel", {tonumber(nitroType), tonumber(nitroLevel)})
        
            outputChatBox("[color=sightgreen][SightMTA - Nitro]: [color=hudwhite]Sikeresen feltöltötted a kiválasztott autó nitró szintjét! ("..(nitroType == 1 and "Normál" or "Prémium")..", "..nitroLevel..")", sourcePlayer)
        end
    end
end)