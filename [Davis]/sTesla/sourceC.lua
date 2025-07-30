local evSounds = {}
local evRevSounds = {}
local streamedEVs = {}

local soundTable = {
    [7] = true, [8] = true, [9] = true, [10] = true,
    [11] = true, [12] = true, [13] = true, [14] = true,
    [15] = true, [16] = true, [40] = true
}

function processEVSounds()
    for v in pairs(streamedEVs) do
        if isElement(v) and isElementStreamedIn(v) then
            local model = getElementData(v, "vehicle.customModel") or getElementModel(v)
            if electricVehicles[model] then
                if not isElement(evSounds[v]) then
                    local x, y, z = getElementPosition(v)
                    evSounds[v] = playSound3D("files/ev.mp3", x, y, z, true)
                    setElementDimension(evSounds[v], getElementDimension(v))
                    setElementInterior(evSounds[v], getElementInterior(v))
                    setSoundMaxDistance(evSounds[v], 30)
                    attachElements(evSounds[v], v)
                end

                local speed = exports.sSpeedo:getVehicleSpeed(v, "KMH") or 0
                local gear = getElementData(v, "vehicle.gear")

                if gear == "R" then
                    if not isElement(evRevSounds[v]) then
                        local x, y, z = getElementPosition(v)
                        evRevSounds[v] = playSound3D("files/evrev.mp3", x, y, z, true)
                        setElementDimension(evRevSounds[v], getElementDimension(v))
                        setElementInterior(evRevSounds[v], getElementInterior(v))
                        setSoundMaxDistance(evRevSounds[v], 30)
                        setSoundVolume(evRevSounds[v], 0.7)
                        attachElements(evRevSounds[v], v)
                    end
                    setSoundSpeed(evRevSounds[v], 1 * (speed / 100) + 0.8)
                    setSoundVolume(evSounds[v], 0)
                else
                    if isElement(evRevSounds[v]) then
                        destroyElement(evRevSounds[v])
                        evRevSounds[v] = nil
                    end
                    if isElement(evSounds[v]) then
                        setSoundVolume(evSounds[v], 0.2 * (speed / 100))
                        setSoundSpeed(evSounds[v], 0.7 * (speed / 150))
                    end
                end
            end
        else
            streamedEVs[v] = nil
            if isElement(evSounds[v]) then destroyElement(evSounds[v]) evSounds[v] = nil end
            if isElement(evRevSounds[v]) then destroyElement(evRevSounds[v]) evRevSounds[v] = nil end
        end
    end
end
addEventHandler("onClientRender", root, processEVSounds)

addEventHandler("onClientElementStreamIn", root, function()
    if getElementType(source) == "vehicle" then
        local model = getElementData(source, "vehicle.customModel") or getElementModel(source)
        if electricVehicles[model] then
            streamedEVs[source] = true
        end
    end
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
    for _, source in pairs(getElementsByType("vehicle", root, true)) do
        if getElementType(source) == "vehicle" then
            local model = getElementData(source, "vehicle.customModel") or getElementModel(source)
            if electricVehicles[model] then
                streamedEVs[source] = true
            end
        end
    end
end)

addEventHandler("onClientElementStreamOut", root, function()
    if streamedEVs[source] then
        streamedEVs[source] = nil
    end
    if isElement(evSounds[source]) then
        destroyElement(evSounds[source])
        evSounds[source] = nil
    end
    if isElement(evRevSounds[source]) then
        destroyElement(evRevSounds[source])
        evRevSounds[source] = nil
    end
end)

addEventHandler("onClientElementDestroy", root, function()
    streamedEVs[source] = nil
    if isElement(evSounds[source]) then
        destroyElement(evSounds[source])
        evSounds[source] = nil
    end
    if isElement(evRevSounds[source]) then
        destroyElement(evRevSounds[source])
        evRevSounds[source] = nil
    end
end)

local function updateDimInt()
    if isElement(evSounds[source]) then
        setElementDimension(evSounds[source], getElementDimension(source))
        setElementInterior(evSounds[source], getElementInterior(source))
    end
    if isElement(evRevSounds[source]) then
        setElementDimension(evRevSounds[source], getElementDimension(source))
        setElementInterior(evRevSounds[source], getElementInterior(source))
    end
end
addEventHandler("onClientElementDimensionChange", root, updateDimInt)
addEventHandler("onClientElementInteriorChange", root, updateDimInt)

addEventHandler("onClientWorldSound", root, function(group)
    if getElementType(source) == "vehicle" then
        local model = getElementData(source, "vehicle.customModel") or getElementModel(source)
        if electricVehicles[model] and soundTable[group] then
            cancelEvent()
        end
    end
end)
