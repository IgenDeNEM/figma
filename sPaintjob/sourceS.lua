local connection = exports.sConnection:getConnection()

function findVehicle(id)
    local veh = false
    for k, v in pairs(getElementsByType("vehicle")) do
        if getElementData(v, "vehicle.dbID") == id then
            veh = v
        end
    end
    return veh
end

addCommandHandler("apaintjob", function (sourcePlayer, commandName, veh, pj)
    if exports.sPermission:hasPermission(sourcePlayer, "apaintjob") then
        local vehID = tonumber(veh)
        local pj = tonumber(pj)
        if veh and pj then
            local veh = findVehicle(vehID)
            if veh and pj == 0 then
                setElementData(veh, "vehicle.currentTexture", false)
                setElementData(veh, "paintjob", false)
                dbExec(connection, "UPDATE vehicles SET paintjob = ? WHERE dbID = ?", tonumber(0), tonumber(vehID))
                outputChatBox("[color=sightgreen][SightMTA - PaintJob][color=hudwhite] Sikeresen levetted a PaintJob-ot!", sourcePlayer, 255, 150, 0)
                return
            end
            if veh and isTextureValid(getElementModel(veh), "pj", pj) then
                setElementData(veh, "vehicle.currentTexture", pj)
                setElementData(veh, "paintjob", pj)
                outputChatBox("[color=sightgreen][SightMTA - PaintJob][color=hudwhite] Sikeresen megváltoztattad a PaintJob-ot!", sourcePlayer, 255, 150, 0)
                dbExec(connection, "UPDATE vehicles SET paintjob = ? WHERE dbID = ?", tonumber(pj), tonumber(vehID))
            else
                outputChatBox("[color=sightred][SightMTA - PaintJob][color=hudwhite] Nem sikerült rárakni a kiválaszott PaintJob-ot!", sourcePlayer, 255, 150, 0)
            end
        else
            outputChatBox("[color=sightblue][SightMTA - PaintJob]:[color=hudwhite]/" .. commandName .. " [Jármű ID] [Paintjob ID]", sourcePlayer)
        end
    end
end)

addCommandHandler("aheadlight", function(sourcePlayer, commandName, vehicleIdentity, targetHeadlight)
    if exports.sPermission:hasPermission(sourcePlayer, "aheadlight") then
        if (not vehicleIdentity or not tonumber(vehicleIdentity)) or (not targetHeadlight or not tonumber(targetHeadlight)) then
            outputChatBox("[color=sightblue][SightMTA - Headlight]: [color=hudwhite]/"..commandName.." [Jármű ID] [Headlight ID]", sourcePlayer)
            return
        end
        local vehicleIdentity = tonumber(vehicleIdentity)
        local targetHeadlight = tonumber(targetHeadlight)
        local vehicleElement = findVehicle(vehicleIdentity)
        local updateDatabase = false

        --vehicle.currentHeadlightTexture - headlight
        if vehicleElement then
            if targetHeadlight and isTextureValid(getElementModel(vehicleElement), "headlight", targetHeadlight) then
                setElementData(vehicleElement, "vehicle.currentHeadlightTexture", targetHeadlight)
                updateDatabase = true

                outputChatBox("[color=sightgreen][SightMTA - Headlight]: [color=hudwhite]Sikeresen felszerelted az autóra a kiválasztott lámpatextúrát!", sourcePlayer)
            elseif targetHeadlight == 0 then
                setElementData(vehicleElement, "vehicle.currentHeadlightTexture", targetHeadlight)
                updateDatabase = true

                outputChatBox("[color=sightgreen][SightMTA - Headlight]: [color=hudwhite]Sikeresen leszerelted az autóról a lámpatextúrát!", sourcePlayer)
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem létezik ilyen lámpatextúra erre a járműre!", sourcePlayer)
            end
        end

        if updateDatabase then
            dbExec(connection, "UPDATE vehicles SET currentHeadlightTexture = ? WHERE dbID = ?", targetHeadlight, vehicleIdentity)
        end
    end
end)

addCommandHandler("awheeltext", function(sourcePlayer, commandName, vehicleIdentity, targetWheelTexture)
    if exports.sPermission:hasPermission(sourcePlayer, "awheeltext") then
        if (not vehicleIdentity or not tonumber(vehicleIdentity)) or (not targetWheelTexture or not tonumber(targetWheelTexture)) then
            outputChatBox("[color=sightblue][SightMTA - Headlight]: [color=hudwhite]/"..commandName.." [Jármű ID] [KerékPJ ID]", sourcePlayer)
            return
        end

        local vehicleIdentity = tonumber(vehicleIdentity)
        local targetWheelTexture = tonumber(targetWheelTexture)
        local vehicleElement = findVehicle(vehicleIdentity)
        local updateDatabase = false

        --vehicle.currentWheelTexture - wheel
        if vehicleElement then
            if targetWheelTexture and isTextureValid(getElementModel(vehicleElement), "wheel", targetWheelTexture) then
                setElementData(vehicleElement, "vehicle.currentWheelTexture", targetWheelTexture)
                updateDatabase = true

                outputChatBox("[color=sightgreen][SightMTA - Wheel]: [color=hudwhite]Sikeresen felszerelted az autóra a kiválasztott keréktextúrát!", sourcePlayer)
            elseif targetWheelTexture == 0 then
                setElementData(vehicleElement, "vehicle.currentWheelTexture", targetWheelTexture)
                updateDatabase = true

                outputChatBox("[color=sightgreen][SightMTA - Wheel]: [color=hudwhite]Sikeresen leszerelted az autóról a keréktextúrát!", sourcePlayer)
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem létezik ilyen keréktextúra erre a járműre!", sourcePlayer)
            end
        end

        if updateDatabase then
            dbExec(connection, "UPDATE vehicles SET currentWheelTexture = ? WHERE dbID = ?", targetWheelTexture, vehicleIdentity)
        end
    end
end)