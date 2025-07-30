addEvent("requestServersideProtection", true)
addEventHandler("requestServersideProtection", getRootElement(), function(k, fileType, fileName)
    local realFileName = fileName .. ".see3"
    local data = false
    local offset = false

    if fileExists(realFileName) then
        local file = fileOpen(realFileName)
        local size = fileGetSize(file)
        local buffer = fileRead(file, size)
        fileClose(file)

        if buffer then
            buffer = fromJSON(buffer)
            data = buffer[1]
            offset = buffer[2]
        end

        buffer = nil
        collectgarbage("collect")
    end

    triggerClientEvent(client, "gotServersideProtection", client, k, fileType, fileName, data, offset)
end)

addCommandHandler("reloadmodel", function(thePlayer, cmd, modelIdentifier)
    if not isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(thePlayer)), aclGetGroup("Admin")) then
        outputChatBox("Nincs jogosultságod a parancs használatához!", thePlayer, 255, 0, 0)
        return
    end

    if not modelIdentifier then
        outputChatBox("[color=sightblue]SightMTA - Használat:[color=hudwhite] /reloadmodel [modell kulcs vagy ID]", thePlayer, 255, 0, 0)
        return
    end

    local modelKey = nil
    local modelInfo = nil

    if modelList[modelIdentifier] then
        modelKey = modelIdentifier
        modelInfo = modelList[modelIdentifier]
    else
        local modelIdNumber = tonumber(modelIdentifier)
        if modelIdNumber then
            for k, v in pairs(modelList) do
                if tonumber(v.model) == modelIdNumber then
                    modelKey = k
                    modelInfo = v
                    break
                end
            end
        end
    end

    if not modelInfo then
        outputChatBox("Nincs ilyen modell a modelList-ben: " .. modelIdentifier, thePlayer, 255, 100, 0)
        return
    end

    local dffData, colData = false, false
    
    if modelInfo.dff and fileExists(modelInfo.dff) then
        local file = fileOpen(modelInfo.dff)
        dffData = fileRead(file, fileGetSize(file))
        fileClose(file)
    end

    if modelInfo.col and fileExists(modelInfo.col) then
        local file = fileOpen(modelInfo.col)
        colData = fileRead(file, fileGetSize(file))
        fileClose(file)
    end
    
    triggerClientEvent("sModloader:onReloadModelData", getRootElement(), modelKey, modelInfo, dffData, colData)
    outputChatBox("A(z) " .. modelKey .. " modell újratöltése elküldve a klienseknek.", thePlayer, 0, 255, 0)
end)