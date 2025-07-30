local connection = false

addEvent("doneCustomPaintjob", true)
addEventHandler("doneCustomPaintjob", getRootElement(), function(pixels, gratisPJ)
    local clientVehicle = getPedOccupiedVehicle(client)
    if clientVehicle == source then
        local vehicleId = getElementData(clientVehicle, "vehicle.dbID") or false

        if vehicleId then
            if not gratisPJ then
                local currentPremiumPoints = exports.sCore:getPP(client)

                if currentPremiumPoints - 2300 >= 0 then
                    exports.sCore:setPP(client, currentPremiumPoints - 2300)
                    triggerClientEvent(client, "boughtPaintjobResponse", client, true)
                else
                    triggerClientEvent(client, "boughtPaintjobResponse", client, false)
                    return
                end
            end

            local fileName = "server/" .. vehicleId .. ".png"
            local saveDatas = {}

            local vehicleColor = {getVehicleColor(clientVehicle, true)}
            vehicleColor[1] = 255
            vehicleColor[2] = 255
            vehicleColor[3] = 255

            setElementData(clientVehicle, "paintjob", -1)
            setElementData(clientVehicle, "customPaintjob", true)
            setVehicleColor(clientVehicle, unpack(vehicleColor))
            
            saveDatas["color"] = toJSON(vehicleColor)
            saveDatas["paintjob"] = -1

            setVehicleColor(clientVehicle, 255, 255, 255, vehicleColor[4], vehicleColor[5], vehicleColor[6])
    
            exports.sConnection:dbUpdate("vehicles", saveDatas, {dbID = vehicleId})

            if fileExists(fileName) then
                fileDelete(fileName)
            end

            triggerClientEvent(getVehicleOccupants(clientVehicle), "gotTuningValuesFromServer", client, clientVehicle, {{"paintjob", true}})
            triggerClientEvent(root, "paintjobRefreshedOnVehicle", clientVehicle)


            local file = fileCreate(fileName)
            fileWrite(file, pixels)
            fileClose(file)
        end 
    end
    
    pixels = nil
    collectgarbage("collect")
end)

addEvent("requestCustomPJData", true)
addEventHandler("requestCustomPJData", getRootElement(), function()
    if isElement(source) then
        local vehicleId = getElementData(source, "vehicle.dbID") or false

        if vehicleId then
            local vehiclePaintjob = getElementData(source, "paintjob") or false

            if vehiclePaintjob and vehiclePaintjob == -1 then
                local fileName = "server/" .. vehicleId .. ".png"

                local processStart = getTickCount()
                if fileExists(fileName) then
                    --[[
                    local file = fileOpen(fileName)
                    local fileSize = fileGetSize(file)
                    local fileContent = fileRead(file, fileSize)
                    fileClose(file)
                    not enough memory miatt updatelni kellet.
                    ~gergo
                    ]]

                    local file = fileOpen(fileName, true) 
                    local buffer = {}
                    
                    while not fileIsEOF(file) do 
                        buffer[#buffer + 1] = fileRead(file, 4124)
                    end
                    fileClose(file)

                    local fileContent = table.concat(buffer) 

                    triggerLatentClientEvent(client, "gotCustomPJData", 1000000, source, fileContent)
                    fileContent = nil
                    collectgarbage("collect")
                end
            end
        end
    end
end)

addCommandHandler("delpj", function(sourcePlayer, commandName, targetVehicle)
    if exports.sPermission:hasPermission(sourcePlayer, "delpj") then
        if not targetVehicle or not tonumber(targetVehicle) then
            outputChatBox("[color=sightblue][SightMTA - CustomPaintjob]: [color=hudwhite]/"..commandName.." [Jármű azonosító]", sourcePlayer)
            return
        end

        local vehicleIdentity = targetVehicle
        local targetVehicle = exports.sAdministration:findVehicle(sourcePlayer, tonumber(targetVehicle))

        if targetVehicle then
            local vehiclePaintjob = getElementData(targetVehicle, "paintjob") or false
            if vehiclePaintjob and vehiclePaintjob == -1 then
                local fileName = "server/" .. vehicleIdentity .. ".png"
                if fileExists(fileName) then
                    fileDelete(fileName)
                end
                
                if setElementData(targetVehicle, "customPaintjob", false) then
                
                    local vehicleOwner = getElementData(targetVehicle, "vehicle.owner") 
                    local ownerElement = false

                    for _, playerElement in pairs(getElementsByType("player")) do
                        if getElementData(playerElement, "char.ID") == vehicleOwner then
                            ownerElement = playerElement
                            break
                        end
                    end
                    
                    local saveDatas = {}

                    saveDatas["paintjob"] = 0
                    exports.sConnection:dbUpdate("vehicles", saveDatas, {dbID = vehicleIdentity})

                    triggerClientEvent(getVehicleOccupants(targetVehicle), "gotTuningValuesFromServer", sourcePlayer, targetVehicle, {{"paintjob", false}})
                    triggerClientEvent(root, "paintjobRefreshedOnVehicle", targetVehicle)

                    if ownerElement then
                        outputChatBox("[color=sightgreen][SightMTA - CustomPJ]: [color=hudwhite]Egy adminisztrátor kitörölte egy járművedről a custom paintjobot! (Jármű azonosító: "..vehicleIdentity..")", ownerElement)
                    end

                    outputChatBox("[color=sightgreen][SightMTA - CustomPJ]: [color=hudwhite]Sikeresen kitörölted a kiválasztott autó paintjob-ját!", sourcePlayer)
                end
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Ezen a járművön nem található custom paintjob!", sourcePlayer)
            end
        end
    end
end)

addEventHandler("onResourceStart", getRootElement(), function(res)
    if res == getThisResource() then
        connection = exports.sConnection:getConnection()
    else
        local resName = getResourceName(res)

        if resName == "sConnection" then
            connection = exports.sConnection:getConnection()
        end
    end
end)