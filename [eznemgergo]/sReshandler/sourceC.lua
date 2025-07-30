local resourceDatas = {}

addEventHandler("onClientResourceStart", resourceRoot, function()
    loadResourceDetails()
end)

addEventHandler("onClientPlayerQuit", root, function()
    for resourceName, resourceStatus in pairs(resourceDatas) do
        saveResourceStatus(resourceName, resourceStatus)
    end
end)

function loadResourceDetails()
    local dataPath = "sight-res.sight"
    local dataFile = false

    if fileExists(dataPath) then
        dataFile = fileOpen(dataPath)
    end

    if dataFile then
        local fileData = fileRead(dataFile, fileGetSize(dataFile))
        fileClose(dataFile)

        local resourceDatas = fromJSON(fileData)
    end
end

function saveResourceStatus(resourceName, newStatus)
    local dataPath = "sight-res.sight"
    local dataFile = false

    if fileExists(dataPath) then
        dataFile = fileOpen(dataPath)
    else
        dataFile = fileCreate(dataPath)
    end

    if dataFile then
        local fileData = fileRead(dataFile, fileGetSize(dataFile))

        if fileData then
            resourceDatas = fromJSON(fileData, false, "tabs") or {}
        end

        if (resourceDatas[resourceName] or false) ~= newStatus then
            resourceDatas[resourceName] = newStatus
        end

        fileClose(dataFile)
        fileDelete(dataPath)
        dataFile = fileCreate(dataPath)

        fileWrite(dataFile, toJSON(resourceDatas))

        fileClose(dataFile)
    end
end

function getResourceStatus(resourceName)
    return resourceDatas[resourceName] and resourceDatas[resourceName] or false
end