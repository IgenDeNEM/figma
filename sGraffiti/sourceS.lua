graffities = {}

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

local f = fileOpen("server.json")
local data = fileRead(f, fileGetSize(f))
local data = processJson(fromJSON(data))
local tempTable = data or {}
if data then
    for k, v in pairs(data) do
        local f2 = fileOpen("files/server_graffiti/".. v.fileName .. ".png")
        local file = fileRead(f2, fileGetSize(f2))
        graffities[v.fileName] = {file, v}
        fileClose(f2)
    end
end

fileClose(f)

addEvent("protectGraffiti", true)
addEventHandler("protectGraffiti", root, 
    function(fileName)
        local enabled = false
        for k, v in pairs(tempTable) do
            if v.fileName == tonumber(fileName) then
                tempTable[k].protected = not tempTable[k].protected
                enabled = tempTable[k].protected
            end
        end
        for k, v in pairs(graffities) do
            if tostring(k) == fileName then
                graffities[k].protected = enabled
                triggerClientEvent("protectGraffiti", root, k, graffities[k].protected)
            end
        end

        local f = fileCreate("server.json")
        fileWrite(f, toJSON(tempTable))
        fileClose(f)
    end
)

addEvent("requestGraffitiList", true)
function requestGraffitiList()
    triggerClientEvent(client, "requestGraffitiList", client, graffities)
end
addEventHandler("requestGraffitiList", root, requestGraffitiList)

addEvent("createGraffiti", true)
function createGraffiti(selectedGraffiti, dataContainer)
    local time = getRealTime().timestamp
    dataContainer.fileName = time
    dataContainer.characterName = getElementData(client, "char.name"):gsub("_", " ")
    dataContainer.characterId = getElementData(client, "char.ID")
    dataContainer.protected = false
    graffities[time] = {selectedGraffiti, dataContainer}
    f = fileOpen("server.json")
    if f then

    else
        f = fileCreate("server.json")
    end
    table.insert(tempTable, graffities[time][2])
    fileWrite(f, toJSON(tempTable))
    fileClose(f)
    local f2 = fileCreate("files/server_graffiti/".. time .. ".png")
    fileWrite(f2, selectedGraffiti)
    fileClose(f2)
    triggerClientEvent(client, "requestGraffitiList", client, graffities)
    triggerClientEvent("createGraffiti", root, selectedGraffiti, dataContainer, dataContainer.fileName)
end
addEventHandler("createGraffiti", root, createGraffiti)

addEvent("requestGraffiti", true)
function requestGraffiti(list)
    triggerClientEvent(client, "requestGraffiti", client, graffities)
end
addEventHandler("requestGraffiti", root, requestGraffiti)

addEvent("deleteGraffiti", true)
function deleteGraffiti(name)
    graffities[name] = nil
    graffities[tonumber(name)] = nil
    for k, v in pairs(tempTable) do
        if v.fileName == tonumber(name) then
            tempTable[k] = nil
        end
    end
    local f = fileCreate("server.json")
    fileWrite(f, toJSON(tempTable))
    fileClose(f)
    triggerClientEvent("deleteGraffiti", client, tonumber(name))
end
addEventHandler("deleteGraffiti", root, deleteGraffiti)

addEvent("cleanGraffiti", true)
addEventHandler("cleanGraffiti", root, 
    function(fileName)
        graffities[fileName] = nil
        graffities[tonumber(fileName)] = nil
        for k, v in pairs(tempTable) do
            if v.fileName == tonumber(fileName) then
                tempTable[k] = nil
            end
        end
        local f = fileCreate("server.json")
        fileWrite(f, toJSON(tempTable))
        fileClose(f)
        triggerClientEvent("deleteGraffiti", client, tonumber(fileName))
    end
)

addEvent("graffitiCleanAnimation", true)
addEventHandler("graffitiCleanAnimation", getRootElement(),
	function ()
		setPedAnimation(client, "graffiti", "spraycan_fire", 15000, true, false, false, false)
	end
)