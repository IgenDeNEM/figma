local connection = nil
connection = exports.sConnection:getConnection()

addEventHandler("onDatabaseConnected", root, function(newConnection)
    connection = newConnection
end)

storedSafes = {}

addEvent("requestSafes", true)
addEventHandler("requestSafes", root, function()
    triggerClientEvent(client, "recieveSafes", client, storedSafes)
end)

function onLastInsertId(qh)
    local result = dbPoll(qh, 0)
    if result and #result > 0 then
        local lastInsertId = result[1]["id"]
        dbQuery(onFetchRowDetails, connection, "SELECT LAST_INSERT_ID() AS id, posX as posX, posY as posY, posZ as posZ, rotZ as rotZ, interior as interior, dimension as dimension, ownerGroup as ownerGroup, safeType as safeType FROM safes WHERE dbID = ?", lastInsertId)

    end
end

function onInsertFinished(qh)
    local result = dbPoll(qh, 0)
    if result then
        dbQuery(onLastInsertId, connection, "SELECT LAST_INSERT_ID() AS id, posX as posX, posY as posX, posZ as posY, rotZ as rotZ, interior as interior, dimension as dimension, ownerGroup as ownerGroup, safeType as safeType FROM safes")
    end
end

function loadSafes()
    dbQuery(function(qh)
        local result = dbPoll(qh, 0)
        for k, v in pairs(result) do
            local lastInsertId = v.dbID
            local safe = v
            obj = createObject(964, safe.posX, safe.posY, safe.posZ, 0, 0, safe.rotZ)
            setElementDimension(obj, safe.dimension)
            setElementInterior(obj, safe.interior)
            setElementData(obj, "object.dbID", lastInsertId)
            safe.objectElement = obj
            safe.safeType = tonumber(safe.safeType)
            storedSafes[lastInsertId] = safe
            triggerClientEvent("createSafe", resourceRoot, lastInsertId, storedSafes[lastInsertId])
        end
    end, connection, "SELECT * FROM safes")
end
addEventHandler("onResourceStart", resourceRoot, loadSafes)

function onFetchRowDetails(qh)
    local result = dbPoll(qh, 0)
    if result and #result > 0 then
        local lastInsertId = result[1].id
        local safe = result[1]
        obj = createObject(964, safe.posX, safe.posY, safe.posZ, 0, 0, safe.rotZ)
        setElementDimension(obj, safe.dimension)
        setElementInterior(obj, safe.interior)
        setElementData(obj, "object.dbID", lastInsertId)
        safe.objectElement = obj
        safe.safeType = tonumber(safe.safeType)
        storedSafes[lastInsertId] = safe
        triggerClientEvent("createSafe", resourceRoot, lastInsertId, storedSafes[lastInsertId])
    end
end

function createSafe(thePlayer, cmd, groupId, type)
    if cmd == "0" then
        local  x, y, z, rotZ, interior, dimension, type = unpack(groupId)
        local id = getLastSafeId() + 1
        giveItem(thePlayer, 154, 1, false, id)
        dbQuery(onInsertFinished, connection, "INSERT INTO safes (posX, posY, posZ, rotZ, interior, dimension, ownerGroup, safeType) VALUES(?,?,?,?,?,?,?,?)",
        x, y, z, rotZ, interior, dimension, (0), tonumber(type))
    else
        if getElementData(thePlayer, "acc.adminLevel") >= 7 and (groupId) and tonumber(type) then
            local x, y, z = getElementPosition(thePlayer)
            local z = z - 0.65
            local _, _, rotZ = getElementRotation(thePlayer)
            local interior = getElementInterior(thePlayer)
            local dimension = getElementDimension(thePlayer)
            dbQuery(onInsertFinished, connection, "INSERT INTO safes (posX, posY, posZ, rotZ, interior, dimension, ownerGroup, safeType) VALUES(?,?,?,?,?,?,?,?)",
            x, y, z, rotZ, interior, dimension, (groupId), tonumber(type))
        elseif not (groupId) or not tonumber(type) then
            if getElementData(thePlayer, "acc.adminLevel") >= 7 then
                outputChatBox("[color=sightblue][SightMTA - Safe]:[color=hudwhite] /createsafe [groupId (pl: PD) vagy 0] [safeType < 1 = kicsi 2 = közepes 3 = nagy >]", thePlayer, 255, 255, 255)
            end
        end
    end
end
addCommandHandler("createsafe", createSafe)

function createInteriorSafe(sourcePlayer, safeInfo)
    local x, y, z = safeInfo[1], safeInfo[2], safeInfo[3]
    local rotZ = safeInfo[4] or 0
    local interior = safeInfo.interiorIdentity
    local dimension = safeInfo.dimensionIdentity
    dbQuery(onInsertFinished, connection, "INSERT INTO safes (posX, posY, posZ, rotZ, interior, dimension, ownerGroup, safeType) VALUES(?,?,?,?,?,?,?,?)",
    x, y, z, (rotZ or 0), interior, dimension, (safeInfo.groupId), tonumber(safeInfo.type))
end

function deleteSafe(thePlayer, cmd, groupId)
    if getElementData(thePlayer, "acc.adminLevel") >= 7 and tonumber(groupId) then
        if not storedSafes[tonumber(groupId)] then
            outputChatBox("[color=sightred][SightMTA - Safe]:[color=hudwhite] Ez a széf nem létezik!", thePlayer, 255, 255, 255)
            return
        end
        destroyElement(storedSafes[tonumber(groupId)].objectElement)
        storedSafes[tonumber(groupId)] = nil
        triggerClientEvent("deleteSafe", thePlayer, tonumber(groupId))
        dbExec(connection, "DELETE FROM safes WHERE dbID = ?", tonumber(groupId))
        outputChatBox("[color=sightred][SightMTA - Safe]:[color=hudwhite] Sikeresen kitörölted!", thePlayer, 255, 255, 255)
    elseif not (groupId) or not tonumber(type) then
        if getElementData(thePlayer, "acc.adminLevel") >= 7 then
            outputChatBox("[color=sightblue][SightMTA - Safe]:[color=hudwhite] /deletesafe [ID]", thePlayer, 255, 255, 255)
        end
    end
end
addCommandHandler("deletesafe", deleteSafe)

function changelock2safe(thePlayer, cmd, groupId)
    if getElementData(thePlayer, "acc.adminLevel") >= 7 and tonumber(groupId) then
        exports.sItems:giveItem(thePlayer, 154, 1, false, tonumber(groupId))
        outputChatBox("[color=sightgreen][SightMTA - Safe]:[color=hudwhite] Sikeresen másoltál kulcsot!", thePlayer, 255, 255, 255)
    elseif not (groupId) or not tonumber(type) then
        if getElementData(thePlayer, "acc.adminLevel") >= 7 then
            outputChatBox("[color=sightblue][SightMTA - Safe]:[color=hudwhite]đ /changelock2safe [ID]", thePlayer, 255, 255, 255)
        end
    end
end
addCommandHandler("changelock2safe", changelock2safe)

addEvent("moveSafeFurniture", true)
addEventHandler("moveSafeFurniture", root, function(safe, x, y, z, rotX, rotY, rotZ)
    setElementPosition(storedSafes[tonumber(safe)].objectElement, x, y, z)
    setElementRotation(storedSafes[tonumber(safe)].objectElement, rotX, rotY, rotZ)
    triggerClientEvent("updateSafe", client, tonumber(safe), storedSafes[tonumber(safe)])
    dbExec(connection, "UPDATE safes SET posx = ?, posY = ?, posZ = ?, rotZ = ? WHERE dbID = ?", x, y, z, rotZ, tonumber(safe))
end)

function movesafe(thePlayer, cmd, groupId)
    if getElementData(thePlayer, "acc.adminLevel") >= 7 and tonumber(groupId) then
        if not storedSafes[tonumber(groupId)] then
            outputChatBox("[color=sightred][SightMTA - Safe]:[color=hudwhite] Ez a széf nem létezik!", thePlayer, 255, 255, 255)
            return
        end
        local x, y, z = getElementPosition(thePlayer)
        local _, _, rotZ = getElementRotation(thePlayer)
        local z = z - 0.65
        local int, dim = getElementInterior(thePlayer), getElementDimension(thePlayer)
        setElementPosition(storedSafes[tonumber(groupId)].objectElement, x, y, z)
        setElementRotation(storedSafes[tonumber(groupId)].objectElement, 0, 0, rotZ)

        setElementDimension(storedSafes[tonumber(groupId)].objectElement, dim)
        setElementInterior(storedSafes[tonumber(groupId)].objectElement, int)
        triggerClientEvent("updateSafe", thePlayer, tonumber(groupId), storedSafes[tonumber(groupId)])
        outputChatBox("[color=sightgreen][SightMTA - Safe]:[color=hudwhite] Sikeresen idehoztad a kiválasztott széfet!", thePlayer, 255, 255, 255)
        dbExec(connection, "UPDATE safes SET posx = ?, posY = ?, posZ = ?, rotZ = ?, interior = ?, dimension = ? WHERE dbID = ?", x, y, z, rotZ, int, dim, tonumber(groupId))
    elseif not (groupId) or not tonumber(type) then
        if getElementData(thePlayer, "acc.adminLevel") >= 7 then
            outputChatBox("[color=sightblue][SightMTA - Safe]:[color=hudwhite] /movesafe [ID]", thePlayer, 255, 255, 255)
        end
    end
end
addCommandHandler("movesafe", movesafe)

addEvent("updateSafeInt", true)
addEventHandler("updateSafeInt", root, function(sourcePlayer, safeIdentity)
    if safeIdentity and getElementInterior(sourcePlayer) >= 1 then
        triggerClientEvent("updateSafe", sourcePlayer, tonumber(safeIdentity), storedSafes[tonumber(safeIdentity)])
    end
end)

function gotosafe(thePlayer, cmd, groupId)
    if getElementData(thePlayer, "acc.adminLevel") >= 5 and tonumber(groupId) then
        if not storedSafes[tonumber(groupId)] then
            outputChatBox("[color=sightred][SightMTA - Safe]:[color=hudwhite] Ez a széf nem létezik!", thePlayer, 255, 255, 255)
            return
        end
        local x, y, z = getElementPosition(storedSafes[tonumber(groupId)].objectElement)
        local dim = getElementDimension(storedSafes[tonumber(groupId)].objectElement)
        local int = getElementInterior(storedSafes[tonumber(groupId)].objectElement)
        setElementPosition(thePlayer, x, y, z)
        setElementDimension(thePlayer, dim)
        setElementInterior(thePlayer, int)
    elseif not (groupId) or not tonumber(type) then
        if getElementData(thePlayer, "acc.adminLevel") >= 1 then
            outputChatBox("[color=sightblue][SightMTA - Safe]:[color=hudwhite] /gotosafe [ID]", thePlayer, 255, 255, 255)
        end
    end
end
addCommandHandler("gotosafe", gotosafe)

addCommandHandler("rotatesafe", function(sourcePlayer, commandName, safeId)
    if exports.sPermission:hasPermission(sourcePlayer, "rotatesafe") then
        local safeId = tonumber(safeId)
        if not safeId then
            outputChatBox("[color=sightgreen][SightMTA - Használat]: #ffffff/" .. commandName .. " [Széf ID]", sourcePlayer)
        else
            if storedSafes[safeId] then
                local safe = storedSafes[safeId]
                local rx, ry, rz = getElementRotation(sourcePlayer)
                rz = rz - 180
                dbExec(connection, "UPDATE safes SET rotZ = ? WHERE dbID = ?", rz, safeId)
                safe.rotZ = rz
                setElementRotation(safe.objectElement, 0, 0, rz)
                outputChatBox("[color=sightgreen][SightMTA - Admin]: [color=hudwhite]Sikeresen elforgattad a széfet.", sourcePlayer)
                triggerClientEvent("updateSafe", sourcePlayer, safeId, safe)
            else
                outputChatBox("[color=sightred][SightMTA - Admin]: [color=hudwhite]Nem található széf ezzel az ID-vel.", sourcePlayer)
            end
        end
    end
end)

addCommandHandler("setsafegroup", function(sourcePlayer, commandName, safeId, groupId)
    if exports.sPermission:hasPermission(sourcePlayer, "setsafegroup") then
        local safeId = tonumber(safeId)
        if not safeId or not groupId then
            outputChatBox("[color=sightgreen][SightMTA - Használat]: #ffffff/" .. commandName .. " [Széf ID] [Frakció prefix (pl PD, NAV)]", sourcePlayer)
        else
            if storedSafes[safeId] then
                local safe = storedSafes[safeId]
                safe.ownerGroup = groupId
                dbExec(connection, "UPDATE safes SET ownerGroup = ? WHERE dbID = ?", groupId, safeId)
                outputChatBox("[color=sightgreen][SightMTA - Admin]: [color=hudwhite]Sikeresen megváltoztattad a széf frakcióját.", sourcePlayer)
                triggerClientEvent("updateSafe", sourcePlayer, safeId, safe)
            else
                outputChatBox("[color=sightred][SightMTA - Admin]: [color=hudwhite]Nem található széf ezzel az ID-vel.", sourcePlayer)
            end
        end
    end
end)

function getLastSafeId()
    local id = 0
    for k, v in pairs(storedSafes) do
        if k > id then
            id = k
        end
    end
    return id
end