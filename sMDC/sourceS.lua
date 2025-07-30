local connection = exports.sConnection:getConnection()

local warrants = {}
local vehWarrants = {}

addEventHandler("onResourceStart", resourceRoot,
function ()
    dbQuery(loadWarrants, connection, "SELECT * FROM mdc_warrants")
    dbQuery(loadVehWarrants, connection, "SELECT * FROM mdc_vehwarrants")
end
)

function loadWarrants(qh)
    local result = dbPoll(qh, 0)
    
    if result then
        for i, v in ipairs(result) do
            if v.isActive == 1 then
                table.insert(warrants, {
                    v.warrantId,
                    v.wantedName,
                    v.creationDate,
                    v.officerName,
                    v.reason,
                    v.wantedCharacterId
                })
            end
        end
    end
end

function loadVehWarrants(qh)
    local result = dbPoll(qh, 0)
    
    if result then
        for i, v in ipairs(result) do
            table.insert(vehWarrants, {
                v.warrantId,
                v.wantedPlate,
                v.creationDate,
                v.officerName,
                v.reason,
                v.wantedVehicleId
            })
        end
    end
end

function checkWarrantFromId(characterId)
    local tempTable = {}
    
    for k, v in ipairs(warrants) do
        if v[6] == characterId then
            table.insert(tempTable, v)
        end
    end
    
    return tempTable
end

function checkPlayerWarrant(playerElement)
    local playerId = getElementData(playerElement, "char.ID")
    
    local tempTable = {}
    
    for k, v in ipairs(warrants) do
        if v[6] == playerId then
            table.insert(tempTable, v)
        end
    end 
    
    return tempTable
end

function checkVehicleWarrant(vehicleElement)
    local vehiclePlate = getVehiclePlateText(vehicleElement)
    
    local tempTable = {}
    
    for k, v in ipairs(vehWarrants) do
        if v[2] == vehiclePlate then
            table.insert(tempTable, v)
        end
    end 
    
    return tempTable
end

function checkPlayerWarrantTraffipax(playerElement)
    local playerId = getElementData(playerElement, "char.ID")
    
    local tempTable = {}
    
    for k, v in ipairs(warrants) do
        if v[6] == playerId then
            table.insert(tempTable, v[5])
        end
    end 
    
    return tempTable
end

function checkVehicleWarrantTraffipax(vehicleElement)
    local vehiclePlate = getVehiclePlateText(vehicleElement)
    
    local tempTable = {}
    
    for k, v in ipairs(vehWarrants) do
        if v[2] == vehiclePlate then
            table.insert(tempTable, v[5])
        end
    end 
    
    return tempTable
end

addEvent("getWarrantsOfPlayers", true)
addEventHandler("getWarrantsOfPlayers", root,
function ()
    triggerClientEvent(client, "gotMDCWarrantQuery", client, false, warrants)
end
)

addEvent("addMDCWarrant", true)
addEventHandler("addMDCWarrant", root,
function (characterId, reason)
    dbQuery(requestNameAndIssueWarrant, {client, characterId, reason}, connection, [[
            SELECT
                name
            FROM
                characters
            WHERE
                characterId = ?
        ]], characterId)
end
)

function requestNameAndIssueWarrant(qh, client, characterId, reason)
    local result = dbPoll(qh, 0)
    
    if result then
        if #result > 0 then
            local officerName = string.gsub(getElementData(client, "visibleName"), "_", " ")
            local dutyGroup = getElementData(client, "inDuty")
            local creationDate = getRealTime().timestamp
            
            local name = result[1].name:gsub("_", " ")
            
            local recorderName = officerName:gsub(" ", "_")
            local punishedName = name:gsub(" ", "_")
            
            local columnNames = {}
            local valueMarks = {}
            local parameters = {}
            
            local warrantRecordDatas = {
                recordType = "warrant",
                punishedName = punishedName,
                recordBy = recorderName,
                description = reason,
                recordTime = getRealTime().timestamp,
                recordPunishment = ""
            }
            
            for k, v in pairs(warrantRecordDatas) do
                table.insert(columnNames, k)
                table.insert(valueMarks, "?")
                table.insert(parameters, v)
            end
            
            dbExec(connection, "INSERT INTO mdc_records (" .. table.concat(columnNames, ",") .. ") VALUES (" .. table.concat(valueMarks, ",") .. ")", unpack(parameters))
            
            dbQuery(issueNameWarrant, {client, name, creationDate, officerName, reason, characterId}, connection, "INSERT INTO mdc_warrants (wantedName, creationDate, officerName, reason, wantedCharacterId) VALUES (?, ?, ?, ?, ?)", name, creationDate, officerName, reason, characterId)
        end
    end
end

function issueNameWarrant(qh, client, name, creationDate, officerName, reason, characterId)
    local result, _, dbId = dbPoll(qh, 0)
    
    if result then
        if dbId then
            local nameWarrants = {}
            
            table.insert(warrants, {
                dbId,
                name:gsub("_", " "),
                creationDate,
                officerName,
                reason,
                characterId
            })
            
            for i, v in pairs(warrants) do
                if v[2] == name:gsub("_", " ") then
                    table.insert(nameWarrants, v)
                end
            end
            
            triggerClientEvent(client, "gotMDCWarrantQuery", client, characterId, nameWarrants)
        end
    end
end

function getWarrantsOfPlayer(sourcePlayer, characterId)
    local tempTable = {}
    
    for k, v in ipairs(warrants) do
        if v[6] == characterId then
            table.insert(tempTable, v)
        end
    end
    
    if #tempTable > 0 then
        triggerClientEvent(sourcePlayer, "gotMDCWarrantQuery", sourcePlayer, characterId, tempTable)
    else
        triggerClientEvent(sourcePlayer, "gotMDCWarrantQuery", sourcePlayer, characterId, tempTable)
    end
end

addEvent("getWarrantsOfPlayer", true)
addEventHandler("getWarrantsOfPlayer", root, 
function(characterId)
    local tempTable = {}
    
    for k, v in ipairs(warrants) do
        if v[6] == characterId then
            table.insert(tempTable, v)
        end
    end
    
    if #tempTable > 0 then
        triggerClientEvent(client, "gotMDCWarrantQuery", client, characterId, tempTable)
    else
        triggerClientEvent(client, "gotMDCWarrantQuery", client, characterId, tempTable)
    end
end
)

addEvent("queryMdcPlayerByName", true)
addEventHandler("queryMdcPlayerByName", root, function(playerName, sourceElement)
    if source ~= client and not source then
        exports.sAnticheat:anticheatBan(client, "AC #76 - sMDC @sourceS:243")
        return
    end
    
    if sourceElement and not client then
        client = sourceElement
    end
    
    
    local query = [[
        SELECT 
            c.characterId, 
            c.lastNameChange,
            l.licenseType, 
            l.id AS licenseId, 
            l.created, 
            l.expire, 
            l.revoked, 
            l.photo AS licensePhoto,
            g.groupPrefix, 
            g.rank, 
            g.isLeader,
            (SELECT COUNT(*) FROM mdc_warrants 
                WHERE wantedCharacterId = c.characterId AND isActive = 1) AS activeWarrants,
            (SELECT COUNT(*) FROM mdc_records 
                WHERE punishedName = c.name) AS playerRecords
        FROM characters c
        LEFT JOIN licenses l ON l.charId = c.characterId
        LEFT JOIN groupmembers g ON g.characterId = c.characterId
        WHERE c.name = ?
    ]]
    dbQuery(function(queryHandle, playerName, playerElement)
        local result = dbPoll(queryHandle, 0)
        if result and #result > 0 then
            local charData = {
                characterId = result[1].characterId,
                name = playerName,
                licenses = {},
                imageId = { false, false, false },
                pic = false,
                workplace = false,
                record = result[1].playerRecords or 0,
                warrants = result[1].activeWarrants or 0
            }
            if result[1].lastNameChange and result[1].lastNameChange ~= 0 then
                charData.namechange = result[1].lastNameChange
            end
            
            local licenseTable = {}
            local groups = {}
            
            for _, row in ipairs(result) do
                if row.licenseType and row.licenseType ~= "mine" then
                    if not licenseTable[row.licenseType] then
                        local isExpired = row.created > row.expire and true or false
                        licenseTable[row.licenseType] = {
                            row.licenseId,
                            row.created,
                            row.expire,
                            isExpired,
                            row.revoked == 1,
                            photo = row.licensePhoto
                        }
                    end
                end
                if row.groupPrefix then
                    if not groups[row.groupPrefix] then
                        groups[row.groupPrefix] = {
                            rank = row.rank,
                            isLeader = row.isLeader
                        }
                    end
                end
            end
            
            charData.licenses = {
                dl = licenseTable["dl"],
                id = licenseTable["id"],
                fs = licenseTable["fs"],
                wp = licenseTable["wp"],
            }
            charData.imageId = {
                licenseTable["id"] and licenseTable["id"][1] or false,
                licenseTable["dl"] and licenseTable["dl"][1] or false,
                licenseTable["wp"] and licenseTable["wp"][1] or false,
            }
            charData.pic = (licenseTable["dl"] and licenseTable["dl"].photo)
            or (licenseTable["id"] and licenseTable["id"].photo)
            or (licenseTable["wp"] and licenseTable["wp"].photo)
            or false
            
            if next(groups) then
                local workplaces = {}
                for groupPrefix, info in pairs(groups) do
                    local groupName = exports.sGroups:getGroupName(groupPrefix)
                    local rankName = exports.sGroups:getGroupRankName(groupPrefix, info.rank)
                    if exports.sGroups:isLegalGroup(groupPrefix) then
                        table.insert(workplaces, groupName .. " - " .. rankName)
                    end
                end
                charData.workplace = workplaces
            end
            
            triggerLatentClientEvent(playerElement, "gotMDCPlayerQuery", playerElement, charData,
            licenseTable["id"] and licenseTable["id"].photo or false,
            licenseTable["dl"] and licenseTable["dl"].photo or false,
            licenseTable["wp"] and licenseTable["wp"].photo or false)
        else
            triggerLatentClientEvent(playerElement, "gotMDCPlayerQuery", playerElement, false, false, false, false, false)
        end
    end, {playerName, client}, connection, query, playerName:gsub(" ", "_"))
end)

addEvent("queryMdcPlayerByCharacterID", true)
addEventHandler("queryMdcPlayerByCharacterID", root, function(characterId)
    if source ~= client and not source then
        exports.sAnticheat:anticheatBan(client, "AC #77 - sMDC @sourceS:359")
        return
    end
    
    
    local query = [[
        SELECT 
            c.characterId, 
            c.lastNameChange,
            c.name,
            l.licenseType, 
            l.id AS licenseId, 
            l.created, 
            l.expire, 
            l.revoked, 
            l.photo AS licensePhoto,
            g.groupPrefix, 
            g.rank, 
            g.isLeader,
            (SELECT COUNT(*) FROM mdc_warrants 
                WHERE wantedCharacterId = c.characterId AND isActive = 1) AS activeWarrants,
            (SELECT COUNT(*) FROM mdc_records 
                WHERE punishedName = c.name) AS playerRecords
        FROM characters c
        LEFT JOIN licenses l ON l.charId = c.characterId
        LEFT JOIN groupmembers g ON g.characterId = c.characterId
        WHERE c.characterId = ?
    ]]
    
    dbQuery(function(queryHandle, characterId, playerElement)
        local result = dbPoll(queryHandle, 0)
        if result and #result > 0 then
            local charData = {
                characterId = result[1].characterId,
                licenses = {},
                imageId = { false, false, false },
                pic = false,
                workplace = false,
                record = result[1].playerRecords or 0,
                warrants = result[1].activeWarrants or 0
            }
            
            if result[1].lastNameChange and result[1].lastNameChange ~= 0 then
                charData.namechange = result[1].lastNameChange
            end
            
            if result[1].name then
                charData.name = result[1].name:gsub("_", " ")
            else
                charData.name = "HIBA!"
            end
            
            local licenseTable = {}
            local groups = {}
            
            for _, row in ipairs(result) do
                if row.licenseType then
                    if not licenseTable[row.licenseType] then
                        licenseTable[row.licenseType] = {
                            row.licenseId,
                            row.created,
                            row.expire,
                            row.revoked == 1,
                            photo = row.licensePhoto
                        }
                    end
                end
                if row.groupPrefix then
                    if not groups[row.groupPrefix] then
                        groups[row.groupPrefix] = {
                            rank = row.rank,
                            isLeader = row.isLeader
                        }
                    end
                end
            end
            
            charData.licenses = {
                dl = licenseTable["dl"],
                id = licenseTable["id"],
                fs = licenseTable["fs"],
                wp = licenseTable["wp"],
            }
            charData.imageId = {
                licenseTable["id"] and licenseTable["id"][1] or false,
                licenseTable["dl"] and licenseTable["dl"][1] or false,
                licenseTable["wp"] and licenseTable["wp"][1] or false,
            }
            charData.pic = (licenseTable["dl"] and licenseTable["dl"].photo)
            or (licenseTable["id"] and licenseTable["id"].photo)
            or (licenseTable["wp"] and licenseTable["wp"].photo)
            or false
            
            if next(groups) then
                local workplaces = {}
                for groupPrefix, info in pairs(groups) do
                    local groupName = exports.sGroups:getGroupName(groupPrefix)
                    local rankName = exports.sGroups:getGroupRankName(groupPrefix, info.rank)
                    if exports.sGroups:isLegalGroup(groupPrefix) then
                        table.insert(workplaces, groupName .. " - " .. rankName)
                    end
                end
                charData.workplace = workplaces
            end
            
            triggerLatentClientEvent(playerElement, "gotMDCPlayerQuery", playerElement, charData,
            licenseTable["id"] and licenseTable["id"].photo or false,
            licenseTable["dl"] and licenseTable["dl"].photo or false,
            licenseTable["wp"] and licenseTable["wp"].photo or false)
        else
            triggerLatentClientEvent(playerElement, "gotMDCPlayerQuery", playerElement, false, false)
        end
    end, {characterId, client}, connection, query, characterId)
end)

addEvent("queryMdcPlayerByLicense", true)
addEventHandler("queryMdcPlayerByLicense", root, function(licenseId)
    if source ~= client and not source then
        exports.sAnticheat:anticheatBan(client, "AC #78 - sMDC @sourceS:477")
        return
    end
    
    
    local query = [[
        SELECT 
            c.characterId, 
            c.name,
            c.lastNameChange,
            l.licenseType, 
            l.id AS licenseId, 
            l.created, 
            l.expire, 
            l.revoked, 
            l.photo AS licensePhoto,
            g.groupPrefix, 
            g.rank, 
            g.isLeader,
            (SELECT COUNT(*) FROM mdc_warrants 
                WHERE wantedCharacterId = c.characterId AND isActive = 1) AS activeWarrants,
            (SELECT COUNT(*) FROM mdc_records 
                WHERE punishedName = c.name) AS playerRecords
        FROM characters c
        LEFT JOIN licenses l ON l.charId = c.characterId
        LEFT JOIN groupmembers g ON g.characterId = c.characterId
        WHERE c.characterId = (SELECT charId FROM licenses WHERE id = ?)
    ]]
    
    dbQuery(function(queryHandle, licenseId, playerElement)
        local result = dbPoll(queryHandle, 0)
        if result and #result > 0 then
            local charData = {
                characterId = result[1].characterId,
                name = result[1].name,
                licenses = {},
                imageId = { false, false, false },
                pic = false,
                workplace = false,
                record = result[1].playerRecords or 0,
                warrants = result[1].activeWarrants or 0
            }
            if result[1].lastNameChange and result[1].lastNameChange ~= 0 then
                charData.namechange = result[1].lastNameChange
            end
            
            local licenseTable = {}
            local groups = {}
            
            for _, row in ipairs(result) do
                if row.licenseType then
                    if not licenseTable[row.licenseType] then
                        licenseTable[row.licenseType] = {
                            row.licenseId,
                            row.created,
                            row.expire,
                            row.revoked == 1,
                            photo = row.licensePhoto
                        }
                    end
                end
                if row.groupPrefix then
                    if not groups[row.groupPrefix] then
                        groups[row.groupPrefix] = {
                            rank = row.rank,
                            isLeader = row.isLeader
                        }
                    end
                end
            end
            
            charData.licenses = {
                dl = licenseTable["dl"],
                id = licenseTable["id"],
                fs = licenseTable["fs"],
                wp = licenseTable["wp"],
            }
            charData.imageId = {
                licenseTable["id"] and licenseTable["id"][1] or false,
                licenseTable["dl"] and licenseTable["dl"][1] or false,
                licenseTable["wp"] and licenseTable["wp"][1] or false,
            }
            charData.pic = (licenseTable["dl"] and licenseTable["dl"].photo)
            or (licenseTable["id"] and licenseTable["id"].photo)
            or (licenseTable["wp"] and licenseTable["wp"].photo)
            or false
            
            if next(groups) then
                local workplaces = {}
                for groupPrefix, info in pairs(groups) do
                    local groupName = exports.sGroups:getGroupName(groupPrefix)
                    local rankName = exports.sGroups:getGroupRankName(groupPrefix, info.rank)
                    if exports.sGroups:isLegalGroup(groupPrefix) then
                        table.insert(workplaces, groupName .. " - " .. rankName)
                    end
                end
                charData.workplace = workplaces
            end
            
            triggerLatentClientEvent(playerElement, "gotMDCPlayerQuery", playerElement, charData,
            licenseTable["id"] and licenseTable["id"].photo or false,
            licenseTable["dl"] and licenseTable["dl"].photo or false,
            licenseTable["wp"] and licenseTable["wp"].photo or false)
        else
            triggerLatentClientEvent(playerElement, "gotMDCPlayerQuery", playerElement, false, false)
        end
    end, {licenseId, client}, connection, query, licenseId)
end)

addEvent("getMDCPlayerVehicles", true)
addEventHandler("getMDCPlayerVehicles", root,
function (characterId)
    dbQuery(queryPlayerVehicles, {client}, connection, [[
            SELECT
                vehicles.*,
                characters.name, characters.characterId
            FROM
                vehicles
            INNER JOIN
                characters ON vehicles.characterId = characters.characterId
            WHERE
                vehicles.characterId = ?
        ]], characterId)
end
)

addEvent("getWarrantsOfPlates", true)
addEventHandler("getWarrantsOfPlates", root,
function (plate)
    triggerClientEvent(client, "gotMDCPlateWarrantQuery", client, false, vehWarrants)
end
)

addEvent("getWarrantsOfPlate", true)
addEventHandler("getWarrantsOfPlate", root,
function (plate)
    dbQuery(queryVehicleIdByPlate, {client, plate}, connection, "SELECT dbID FROM vehicles WHERE plate = ? LIMIT 1", plate)
end
)

addEvent("getMDCPlayerVehiclesByName", true)
addEventHandler("getMDCPlayerVehiclesByName", root,
function (playerName)
    playerName = string.gsub(playerName, " ", "_")
    dbQuery(queryPlayerVehicles, {client, playerName}, connection, [[
            SELECT
                vehicles.*,
                characters.name, characters.characterId
            FROM
                vehicles
            INNER JOIN
                characters ON vehicles.characterId = characters.characterId
            WHERE
                characters.name = ?
        ]], playerName)
end
)

addEvent("getMDCVehicleById", true)
addEventHandler("getMDCVehicleById", root,
function (vehicleId)
    dbQuery(queryVehicleByData, {client}, connection, [[
            SELECT
                vehicles.*,
                characters.name, characters.characterId
            FROM
                vehicles
            INNER JOIN
                characters ON vehicles.characterId = characters.characterId
            WHERE
                vehicles.dbID = ?
        ]], vehicleId)
end
)

addEvent("getMDCVehicleByPlate", true)
addEventHandler("getMDCVehicleByPlate", root,
function (plate)
    dbQuery(queryVehicleByData, {client}, connection, [[
            SELECT
                vehicles.*,
                characters.name, characters.characterId
            FROM
                vehicles
            INNER JOIN
                characters ON vehicles.characterId = characters.characterId
            WHERE
                vehicles.customPlate = ? 
            OR 
                vehicles.plate = ?
        ]], plate, plate)
end
)

addEvent("getMDCPlayerInteriorsByName", true)
addEventHandler("getMDCPlayerInteriorsByName", root,
function (playerName)
    playerName = string.gsub(playerName, " ", "_")
    dbQuery(queryPlayerInteriors, {client, playerName}, connection, [[
            SELECT
                interiors.*,
                characters.name as characterName, characters.characterId
            FROM
                interiors
            INNER JOIN
                characters ON interiors.owner = characters.characterId
            WHERE
                characters.name = ?
        ]], playerName)
end
)

addEvent("addMDCPlateWarrant", true)
addEventHandler("addMDCPlateWarrant", root,
function (vehicleId, reason)
    dbQuery(requestPlateAndIssueWarrant, {client, vehicleId, reason}, connection, [[
            SELECT
                plate
            FROM
                vehicles
            WHERE
                dbID = ?
        ]], vehicleId)
end
)

addEvent("addMDCRecordComment", true)
addEventHandler("addMDCRecordComment", root, 
function(characterId, comment)
    
    dbQuery(function(selectQueryHandle, requesterElement, characterId, comment)
        local selectResult = dbPoll(selectQueryHandle, 0)
        
        local characterName = selectResult[1].name
        
        local columnNames = {}
        local valueMarks = {}
        local parameters = {}
        
        local recorderName = getElementData(requesterElement, "char.name")
        
        local mdcComment = {
            recordType = "comment",
            punishedName = characterName,
            recordBy = recorderName,
            description = comment,
            recordTime = getRealTime().timestamp,
            recordPunishment = ""
        }
        
        for k, v in pairs(mdcComment) do
            table.insert(columnNames, k)
            table.insert(valueMarks, "?")
            table.insert(parameters, v)
        end
        
        dbExec(connection, "INSERT INTO mdc_records (" .. table.concat(columnNames, ",") .. ") VALUES (" .. table.concat(valueMarks, ",") .. ")", unpack(parameters))
        
        dbQuery(
        function(qh, requesterElement, characterId)
            local recordList = {}
            local result = dbPoll(qh, 0)
            if result and #result > 0 then
                for i, row in ipairs(result) do
                    recordList[i] = {
                        recordType = row.recordType,
                        name = (row.punishedName):gsub("_", " "),
                        recordPunishment = row.recordPunishment,
                        recordBy = (row.recordBy):gsub("_", " "),
                        recordTime = row.recordTime,
                        description = row.description
                    }
                end
            end
            
            triggerClientEvent(requesterElement, "gotMDCRecordQuery", requesterElement, characterId, recordList)
        end,
        {requesterElement, characterId},
        connection,
        [[
                SELECT mdc_records.*
                FROM mdc_records
                JOIN characters ON mdc_records.punishedName = characters.name
                WHERE characters.characterId = ?;
                ]],
        characterId
    )
end,
{client, characterId, comment},
connection,
"SELECT name FROM characters WHERE characterId = ?",
characterId
)

end
)

addEvent("getRecordsOfPlayer", true)
addEventHandler("getRecordsOfPlayer", root, 
function (characterId)
    if characterId then
        dbQuery(
        function(qh, requesterElement, characterId)
            local recordList = {}
            
            local result = dbPoll(qh, 0)
            if result and #result > 0 then
                for i, row in ipairs(result) do
                    recordList[i] = {
                        recordType = row.recordType,
                        name = (row.punishedName):gsub("_", " "),
                        recordPunishment = row.recordPunishment,
                        recordBy = (row.recordBy):gsub("_", " "),
                        recordTime = row.recordTime,
                        description = row.description
                    }
                end
            end
            
            triggerClientEvent(requesterElement, "gotMDCRecordQuery", requesterElement, characterId, recordList)
        end,
        {client, characterId}, connection,
        [[
                SELECT mdc_records.*
                FROM mdc_records
                JOIN characters ON mdc_records.punishedName = characters.name
                WHERE characters.characterId = ?
                ]],
        characterId
    )
end
end
)

addEvent("revokeLicenseOfPlayer", true)
addEventHandler("revokeLicenseOfPlayer", root, 
function(characterId, revokingLicenseId, reason)
    if characterId and revokingLicenseId and reason then
        dbQuery(
        function(qh, recorderElement, punishedIdentity)
            local result = dbPoll(qh, 0)
            if result and #result > 0 then
                local name = result[1].name
                
                local columnNames = {}
                local valueMarks = {}
                local parameters = {}
                
                dbExec(connection, "UPDATE licenses SET revoked = ? WHERE licenseType = ?", 1, revokingLicenseId)
                
                local recorderName = getElementData(recorderElement, "char.name")
                
                local licenseRevokeDatas = {
                    recordType = "licenseRevoke",
                    punishedName = name:gsub(" ", "_"),
                    recordBy = recorderName,
                    description = reason,
                    recordTime = getRealTime().timestamp,
                    recordPunishment = ""
                }
                
                for k, v in pairs(licenseRevokeDatas) do
                    table.insert(columnNames, k)
                    table.insert(valueMarks, "?")
                    table.insert(parameters, v)
                end
                
                dbExec(connection, "INSERT INTO mdc_records (" .. table.concat(columnNames, ",") .. ") VALUES (" .. table.concat(valueMarks, ",") .. ")", unpack(parameters))
                triggerEvent("queryMdcPlayerByName", recorderElement, name, recorderElement)
            end
        end,
        {client}, connection, [[
                                SELECT characters.name, licenses.*
                                FROM characters
                                JOIN licenses ON licenses.charId = characters.characterId
                                WHERE characters.characterId = ?
                            ]], characterId
    )
end
end
)

function queryPlayerByName(qh, client, name)
    local result = dbPoll(qh, 0)
    
    if result then
        if #result > 0 then
            local characterId = result[1].characterId
            
            dbQuery(queryPlayerByData, {client}, connection, [[
                SELECT
                    COALESCE(licenses.name, characters.name) as name,
                    characters.*,
                    licenses.licenseType, licenses.id, licenses.created, licenses.expire, licenses.revoked, licenses.photo,
                    mdc_warrants.*,
                    groupmembers.groupPrefix
                FROM
                    characters
                LEFT JOIN
                    licenses ON characters.name = licenses.name
                LEFT JOIN
                    mdc_warrants ON characters.characterId = mdc_warrants.wantedCharacterId
                LEFT JOIN
                    groupmembers ON characters.characterId = groupmembers.characterId
                WHERE
                    characters.characterId = ?
            ]], characterId)
            
        else
            triggerClientEvent(client, "gotMDCPlayerQuery", client, false)
        end
    end
end

function queryPlayerByData(qh, client)
    local result = dbPoll(qh, 0)
    
    if result then
        if #result > 0 then
            local playerData = {}
            local licensePhotos = {}
            local characterId = false
            local workplace = {}
            
            playerData.imageId = {}
            playerData.licenses = {}
            
            for i, v in pairs(result) do
                if v.characterId then
                    characterId = v.characterId
                end
                
                for i, licenseType in pairs({"id", "dl", "wp", "fs"}) do
                    if v.licenseType == licenseType then
                        playerData.licenses[licenseType] = {
                            v.id,
                            v.created,
                            v.expire,
                            false,
                            (v.revoked == 1 and true or false)
                        }
                        
                        if i < 4 then
                            licensePhotos[i] = v.photo
                            playerData.imageId[i] = v.id
                        end
                    end
                end
                
                playerData.characterId = characterId
                playerData.name = string.gsub(v.name, "_", " ")
                playerData.warrants = 0
                playerData.record = 0
            end
            
            for k, v in pairs(result[1]) do
                if k == "groupPrefix" then
                    local groupName = exports.sGroups:getGroupName(v)
                    
                    table.insert(workplace, groupName)
                end
            end
            
            playerData.workplace = workplace
            triggerClientEvent(client, "gotMDCPlayerQuery", client, characterId and playerData or false, licensePhotos[1], licensePhotos[2], licensePhotos[3])
        else
            triggerClientEvent(client, "gotMDCPlayerQuery", client, false)
        end
    end
end

function queryPlayerVehicles(qh, client)
    local result = dbPoll(qh, 0)
    
    if result then
        if #result > 0 then
            local vehicles = {}
            local name = false
            local characterId = false
            
            for i, v in pairs(result) do
                local plateText = v.customPlate or v.plate
                table.insert(vehicles, {
                    vehicleId = v.dbID,
                    plate = v.customPlate or v.plate,
                    model = v.modelId,
                    customModel = v.customModel
                })
                
                name = v.name
                characterId = v.characterId
            end
            
            triggerClientEvent(client, "gotMDCVehicles", client, vehicles, characterId, name)
        else
            triggerClientEvent(client, "gotMDCVehicles", client, false)
        end
    end
end

function queryVehicleByData(qh, client)
    local result = dbPoll(qh, 0)
    
    if result then
        if #result > 0 then
            local vehicles = {}
            local name = false
            local characterId = false
            
            for i, v in pairs(result) do
                table.insert(vehicles, {
                    vehicleId = v.dbID,
                    plate = v.customPlate or v.plate,
                    model = v.modelId,
                    customModel = v.customModel
                })
                
                name = v.name
                characterId = v.characterId
            end
            
            triggerClientEvent(client, "gotMDCVehicles", client, vehicles, characterId, name)
        else
            triggerClientEvent(client, "gotMDCVehicles", client, false)
        end
    end
end

function queryVehicleIdByPlate(qh, client, plate)
    local result = dbPoll(qh, 0)
    if result then
        if #result > 0 then
            local plateWarrants = {}
            local vehicleId = result[1].dbID
            
            for i, v in ipairs(vehWarrants) do
                if v[2] == plate then
                    table.insert(plateWarrants, v)
                end
            end
            
            triggerClientEvent(client, "gotMDCPlateWarrantQuery", client, vehicleId, plateWarrants)
        else
            triggerClientEvent(client, "gotMDCPlateWarrantQuery", client, vehicleId, {})
        end
    end
end

addEvent("deleteMDCWarrant", true)
addEventHandler("deleteMDCWarrant", root,
function (selectedWarrantCharacterId, deletingWarrant)
    if not deletingWarrant then
        return
    end
    
    dbExec(
    connection,
    "UPDATE mdc_warrants SET isActive = 0 WHERE warrantId = ?",
    deletingWarrant, selectedWarrantCharacterId
)

for k, v in pairs(warrants) do
    if v[6] == selectedWarrantCharacterId and v[1] == deletingWarrant then
        table.remove(warrants, k)
    end
end

getWarrantsOfPlayer(client, selectedWarrantCharacterId)
end
)


function deleteWarrant(qh, client, selectedWarrantCharacterId, deletingWarrant)
    dbFree(qh)
    
    for i, v in pairs(warrants) do
        if v[1] == deletingWarrant then
            table.remove(warrants, i)
        end
    end
    
    getWarrantsOfPlayer(client, selectedWarrantCharacterId)
end

addEvent("deleteMDCPlateWarrant", true)
addEventHandler("deleteMDCPlateWarrant", root,
function (selectedWarrantVehicleId, deletingWarrant)
    dbQuery(deletePlateWarrant, {client, selectedWarrantVehicleId, deletingWarrant}, connection, "DELETE FROM mdc_vehwarrants WHERE warrantId = ?", deletingWarrant)
end
)

function deletePlateWarrant(qh, client, selectedWarrantVehicleId, deletingWarrant)
    dbFree(qh)
    
    for i, v in pairs(vehWarrants) do
        if v[1] == deletingWarrant then
            table.remove(vehWarrants, i)
        end
    end
    
    dbQuery(queryVehicleIdByPlate, {client, plate}, connection, "SELECT dbID FROM vehicles WHERE dbID = ? LIMIT 1", selectedWarrantVehicleId)
end

addEvent("getMDCInteriorById", true)
addEventHandler("getMDCInteriorById", root,
function (interiorId)
    dbQuery(queryPlayerInteriors, {client, interiorId, tonumber(interiorId)}, connection, [[
            SELECT
                interiors.*,
                characters.name as characterName, characters.characterId
            FROM
                interiors
            INNER JOIN
                characters ON interiors.owner = characters.characterId
            WHERE
                interiors.interiorId = ?
        ]], interiorId)
end
)

outTunings = {
    ["owner"] = true,
    ["numberPlate"] = true,
    ["vehicleId"] = true,
    ["model"] = true,
    ["isDiesel"] = true,
    ["expireDate"] = true,
    ["creationDate"] = true,
    ["paintjob"] = true
}


function findVehicleByID(charID)
    local player = false
    for k, v in pairs(getElementsByType("vehicle")) do
        if charID == getElementData(v, "vehicle.dbID") then
            player = v
            break
        end
    end
    return player
end

addEvent("requestVehicleMDCTrafficLicense", true)
addEventHandler("requestVehicleMDCTrafficLicense", root, 
function(vehicleId)
    dbQuery(function(queryHandle, vehicleId, client)
        local queryResult = dbPoll(queryHandle, 0)
        if queryResult then
            local licenseData = fromJSON(queryResult[1].licenseData)
            if licenseData then
                licenseData = licenseData[1]
            end
            
            local vehicleElement = findVehicleByID(vehicleId)
            local validCount = 0
            if vehicleElement and isElement(vehicleElement) then
                if licenseData then
                    for k, v in pairs(licenseData) do
                        local valid = exports.sTrafficlicense:isTuningValid(k, vehicleElement, v)
                        if not outTunings[k] and valid == 1 then
                            validCount = validCount + 1
                        end
                    end
                end
            end
            if licenseData then
                local licenseDatas = {
                    validLicense = (getRealTime().timestamp / 86400) < (licenseData.expireDate or 0),
                    expireDate = (licenseData.expireDate or 0),
                    creationDate = licenseData.creationDate,
                    licenseWarns = validCount,
                }
                triggerClientEvent(client, "gotMDCTrafficLicense", client, vehicleId, not licenseDatas.validLicense, licenseDatas.expireDate, licenseDatas.creationDate, licenseDatas.licenseWarns)
            else
                triggerClientEvent(client, "gotMDCTrafficLicense", client, vehicleId, false, false, false, false)
            end
        else
            triggerClientEvent(client, "gotMDCTrafficLicense", client, vehicleId, false, false, false, false)
        end
    end, {vehicleId, client}, connection, "SELECT licenseData FROM vehicles WHERE dbID = ?", vehicleId)
end 
)

addEvent("getMDCPlayerInteriors", true)
addEventHandler("getMDCPlayerInteriors", root, 
function(ownerId)
    dbQuery(queryPlayerInteriors, {client, ownerId, true}, connection, [[
            SELECT
                interiors.*,
                characters.name as characterName, characters.characterId
            FROM
                interiors
            INNER JOIN
                characters ON interiors.owner = characters.characterId
            WHERE
                interiors.owner = ?
        ]], ownerId)
end
)

function requestPlateAndIssueWarrant(qh, client, vehicleId, reason)
    local result = dbPoll(qh, 0)
    
    if result then
        if #result > 0 then
            local officerName = string.gsub(getElementData(client, "visibleName"), "_", " ")
            local dutyGroup = getElementData(client, "inDuty")
            local creationDate = getRealTime().timestamp
            
            local plate = result[1].plate
            
            dbQuery(issuePlateWarrant, {client, plate, creationDate, officerName, reason, vehicleId}, connection, "INSERT INTO mdc_vehwarrants (wantedPlate, creationDate, officerName, reason, wantedVehicleId) VALUES (?, ?, ?, ?, ?)", plate, creationDate, officerName, reason, vehicleId)
        end
    end
end

function issuePlateWarrant(qh, client, plate, creationDate, officerName, reason, vehicleId)
    local result, _, dbId = dbPoll(qh, 0)
    
    if result then
        if dbId then
            local plateWarrants = {}
            
            table.insert(vehWarrants, {
                dbId,
                plate,
                creationDate,
                officerName,
                reason,
                vehicleId
            })
            
            for i, v in pairs(vehWarrants) do
                if v[2] == plate then
                    table.insert(plateWarrants, v)
                end
            end
            
            triggerClientEvent(client, "gotMDCPlateWarrantQuery", client, vehicleId, plateWarrants)
        end
    end
end

addEvent("deleteMDCPlateWarrant", true)
addEventHandler("deleteMDCPlateWarrant", root,
function (selectedWarrantVehicleId, deletingWarrant)
    dbQuery(deletePlateWarrant, {client, selectedWarrantVehicleId, deletingWarrant}, connection, "DELETE FROM mdc_vehwarrants WHERE warrantId = ?", deletingWarrant)
end
)

function deletePlateWarrant(qh, client, selectedWarrantVehicleId, deletingWarrant)
    dbFree(qh)
    
    for i, v in pairs(vehWarrants) do
        if v[1] == deletingWarrant then
            table.remove(vehWarrants, i)
        end
    end
    
    dbQuery(queryVehicleIdByPlate, {client, plate}, connection, "SELECT dbID FROM vehicles WHERE dbID = ? LIMIT 1", selectedWarrantVehicleId)
end

function queryPlayerInteriors(qh, client, byId, all)
    local result = dbPoll(qh, 0)
    if result then
        if #result > 0 then
            local interiors = {}
            local characterId = false
            local name = false
            for k, v in pairs(result) do
                table.insert(interiors, {
                    v.interiorId,
                    exports.sInteriors:getInteriorTypeName(v.type, true),
                    v.name,
                })
                
                characterId = v.characterId
                name = string.gsub(v.characterName, "_", " ")
            end
            local byId = tonumber(byId)
            if not byId or all then
                local garages = exports.sPaintshop:requestPlayerRentedGarages(characterId)

                for k, v in pairs(garages) do
                    table.insert(interiors, {
                        v.id,
                        "Bérelhető garázs",
                        v.name,
                        "garage"
                    })
                end
            end
            extended = true
            if byId then
                extended = false
            end
            triggerClientEvent(client, "gotMDCInteriors", client, interiors, characterId, name, extended)
        else
            if byId then
                dbQuery(function(qh, client)
                    local result = dbPoll(qh, 0)
    
                    local interiors = {}

                    if result then
                        if #result > 0 then
                            local interiors = {}
                            for k, v in pairs(result) do
                                table.insert(interiors, {
                                    v.interiorId,
                                    "Bérelhető garázs",
                                    exports.sPaintshop:formatGarageName(v.interiorId),
                                    "garage"
                                })
                                name = v.charname
                                characterId = v.charID
                            end
                            triggerClientEvent(client, "gotMDCInteriors", client, interiors, characterId, name, false)
                        else
                            triggerClientEvent(client, "gotMDCInteriors", client, false)
                        end
                    end
                end, {client}, connection, "SELECT characters.name AS charname, characters.characterId AS charID, garages.* FROM garages INNER JOIN characters ON garages.rentedBy = characters.characterId WHERE interiorId = ?", byId)
            else
                triggerClientEvent(client, "gotMDCInteriors", client, false)
            end
        end
    end
end

addCommandHandler("asiren1", function(player)
    if exports.sPermission:hasPermission(player, "asiren") then
        local veh = getPedOccupiedVehicle(player)
        if not veh then
            return
        end
        if getElementData(veh, "sirenSound") == 3 then
            setElementData(veh, "sirenSound", nil)
        else
            setElementData(veh, "sirenSound", 3)
        end
    end
end)

addCommandHandler("asiren2", function(player)
    if exports.sPermission:hasPermission(player, "asiren") then
        local veh = getPedOccupiedVehicle(player)
        if not veh then
            return
        end
        if getElementData(veh, "sirenSound") == 4 then
            setElementData(veh, "sirenSound", nil)
        else
            setElementData(veh, "sirenSound", 4)
        end
    end
end)