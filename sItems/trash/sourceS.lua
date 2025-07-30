local connection = false
local storedTrashes = {}
local enabledTrashModels = {
    [1439] = -1,
    [1372] = -1,
    [1334] = true,
    [1330] = -0.5,
    [1331] = true,
    [1339] = -0.35,
    [1343] = -0.3,
    [1227] = -0.1,
    [1246] = true,
    [1329] = -0.5,
    [1328] = -0.5,
    [2770] = -0.5,
    [1358] = true,
    [1415] = -1,
    [3035] = -0.2,
    [1574] = -1,
    [1337] = -0.35, 
    [1359] = -0.3,
}

function previewTrashes()
    local createdTrashes = 0
    for k, v in pairs(enabledTrashModels) do
        createdTrashes = createdTrashes + 1
        trashObject = createObject(k, 619.99523925781, -17.670654296875 + (createdTrashes * 2), 1000.9199829102)
        setElementInterior(trashObject, 1)
        setElementDimension(trashObject, 29)
        setElementFrozen(trashObject, true)
        setObjectBreakable(trashObject, false)
    end
end

addCommandHandler("createtrash", function(sourcePlayer, commandName, modelId)
    if exports.sPermission:hasPermission(sourcePlayer, "manageTrashes") then
        local modelId = tonumber(modelId) or 1359

        if enabledTrashModels[modelId] then
            local posX, posY, posZ = getElementPosition(sourcePlayer)
            if tonumber(enabledTrashModels[modelId]) then
                posZ = posZ + enabledTrashModels[modelId]
            end
            local interior = getElementInterior(sourcePlayer)
            local dimension = getElementDimension(sourcePlayer)
            local _, _, rotZ = getElementRotation(sourcePlayer)

            dbExec(connection, "INSERT INTO trashes (posX, posY, posZ, interior, dimension, rotZ, modelId, lamart) VALUES (?,?,?,?,?,?,?,?)", posX, posY, posZ, interior, dimension, rotZ, modelId, (modelId == 1574 and 1) or 0)
            dbQuery(function(qh, sourcePlayer)
                local results = dbPoll(qh, 0)

                if #results > 0 then
                    loadTrash(results[1], sourcePlayer)
                    exports.sGui:showInfobox(sourcePlayer, "s", "Sikeresen létrehoztad a kukát! Azonosító: " .. results[1].databaseId)
                end
            end, {sourcePlayer}, connection, "SELECT * FROM trashes WHERE databaseId = LAST_INSERT_ID()")
        else
            exports.sGui:showInfobox(sourcePlayer, "e", "Hibás modell!")
        end
    end
end)

addCommandHandler("deletetrash", function(sourcePlayer, commandName, databaseId)
    if exports.sPermission:hasPermission(sourcePlayer, "manageTrashes") then
        local databaseId = tonumber(databaseId)
        
        if databaseId then
            if storedTrashes[databaseId] then
                destroyElement(storedTrashes[databaseId].objectElement)
                triggerLatentClientEvent(getRootElement(), "destroyTrash", sourcePlayer, databaseId)
                dbExec(connection, "DELETE FROM trashes WHERE databaseId = ?", databaseId)
                storedTrashes[databaseId] = nil
                exports.sGui:showInfobox(sourcePlayer, "s", "Sikeresen törlés!")
            else
                outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található kuka ezzel az azonosítóval!")
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Azonosító]", sourcePlayer)
        end
    end
end)

function loadTrash(dat, createdBy)
    local objectElement = createObject(dat.modelId, dat.posX, dat.posY, dat.posZ, 0, 0, dat.rotZ - 180)

    setElementFrozen(objectElement, true)
    setObjectBreakable(objectElement, false)

    setElementInterior(objectElement, dat.interior)
    setElementDimension(objectElement, dat.dimension)

    storedTrashes[dat.databaseId] = {
        trashId = dat.databaseId,
        objectElement = objectElement,
        posX = dat.posX,
        posY = dat.posY,
        posZ = dat.posZ,
        rotZ = dat.rotZ,
        interior = dat.interior,
        dimension = dat.dimension,
        lamart = dat.lamart == 1
    }

    if createdBy then
        triggerLatentClientEvent(getRootElement(), "createTrash", createdBy, dat.databaseId, storedTrashes[dat.databaseId])
    end
end

addEvent("requestTrashes", true)
addEventHandler("requestTrashes", getRootElement(), function()
    triggerLatentClientEvent(client, "recieveTrashes", client, storedTrashes)
end)

addEventHandler("onResourceStart", getRootElement(), function(res)
    if res == getThisResource() then
        connection = exports.sConnection:getConnection()

        dbQuery(function(qh)
            local results = dbPoll(qh, 0)

            for i = 1, #results do
                loadTrash(results[i])
            end
        end, connection, "SELECT * FROM trashes")
    else
        local resName = getResourceName(res)

        if resName == "sConnection" then
            connection = exports.sConnection:getConnection()
        end
    end
end)