local startRaceTimer = false
local endRaceTimer = false
local currentRace = false
local stripResults = {}
local printScoreDatas = {}
local results = {}
local ped = false
local lanes = {
    left = false, right = false
}

function startRace()
    triggerClientEvent(getRootElement(), "syncDragRaceState", resourceRoot, lanes.left, lanes.right, true, 1000)
    currentRace = {
        lanes = lanes,
        controllers = {
            left = isElement(lanes.left) and getVehicleController(lanes.left),
            right = isElement(lanes.right) and getVehicleController(lanes.right)
        },
        fails = {
            left = false,
            right = false
        }
    }

    lanes = {
        left = false, right = false
    }

    endRaceTimer = setTimer(endRace, 20000, 1)
end

function endRace()
    for k, v in pairs(currentRace.controllers) do
        if isElement(v) then
            printScoreDatas[v] = {
                isElement(currentRace.lanes.left) and (getElementData(currentRace.lanes.left, "vehicle.customModel") or getElementModel(currentRace.lanes.left)),
                isElement(currentRace.lanes.right) and (getElementData(currentRace.lanes.right, "vehicle.customModel") or getElementModel(currentRace.lanes.right)),
                isElement(currentRace.lanes.left) and getVehiclePlateText(currentRace.lanes.left),
                isElement(currentRace.lanes.right) and getVehiclePlateText(currentRace.lanes.right),
                isElement(currentRace.controllers.left) and string.gsub(getElementData(currentRace.controllers.left, "char.name"), "_", " "),
                isElement(currentRace.controllers.right) and string.gsub(getElementData(currentRace.controllers.right, "char.name"), "_", " "),
                (currentRace.fails.left and 1) or 0,
                (currentRace.fails.right and 1) or 0,
                stripResults[currentRace.controllers.left] or {},
                stripResults[currentRace.controllers.right] or {},
                getRealTime().timestamp
            }

            exports.sGui:showInfobox(v, "i", "Az eredményt kinyomtathatod a rajtnál lévő sátornál.")
        end
    end
    
    for k, v in pairs(currentRace.controllers) do
        stripResults[v] = nil
    end

    triggerClientEvent(getRootElement(), "syncDragRaceState", resourceRoot, lanes.left, lanes.right, false)

    currentRace = false
    endRaceTimer = false
end

function syncDragTop(syncElements)
    local res = {}

    for i = 1, 5 do
        if results[i] then
            table.insert(res, results[i])
        end
    end

    triggerClientEvent(syncElements, "refreshDragTop", resourceRoot, res)
end

addEvent("dragStripReadyChange", true)
addEventHandler("dragStripReadyChange", getRootElement(), function(veh, ready)
    if client == source then
        if isTimer(startRaceTimer) then
            killTimer(startRaceTimer)
        end
        startRaceTimer = false

        local lane = false

        if isElementWithinColShape(veh, leftDragLane) then
            lane = "left"
        elseif isElementWithinColShape(veh, rightDragLane) then
            lane = "right"
        end

        if lane then
            lanes[lane] = veh and ready and veh

            if lanes.left and lanes.right then
                startRace()
            elseif lanes.left or lanes.right then
                triggerClientEvent(getRootElement(), "dragRaceReady", veh, 10000)
                startRaceTimer = setTimer(startRace, 10000, 1)
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "sDrag >> dragStripReadyChange -> @sourceS.lua/108")
    end
end)

addEvent("syncDragStripResult", true)
addEventHandler("syncDragStripResult", getRootElement(), function(veh, index, val)
    if client == source then
        local pedveh = getPedOccupiedVehicle(client)

        if veh and pedveh == veh then
            local en = false

            if lanes.left == veh then
                en = "gotNewDragLeftResult"
            elseif lanes.right == veh then
                en = "gotNewDragRightResult"
            end

            if en then
                triggerClientEvent(getRootElement(), en, client, index, val)
            end

            if not stripResults[client] then
                stripResults[client] = {}
            end

            stripResults[client][index] = val

            if index == 8 then
                local num = 0

                for i = 1, #results do
                    local result = results[i]
                    local _, time, speed = unpack(result)

                    if val < time then
                        num = i
                        break
                    end
                end

                if #results < 5 and not num then
                    num = #results + 1
                end

                if #results == 0 or num <= 5 then
                    table.insert(results, num or 1, {getElementData(veh, "vehicle.customModel") or getElementModel(veh), val, stripResults[client][7], getElementData(client, "char.name")})

                    syncDragTop(getRootElement())
                end
            end
        else
            for k, v in pairs(currentRace.controllers) do
                if v == client then
                    currentRace.fails[k] = true
                    triggerClientEvent(getRootElement(), "syncDragFail", client, currentRace.fails.left, currentRace.fails.right)

                    break
                end
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "sDrag >> syncDragStripResult -> @sourceS.lua/170")
    end
end)

addEvent("getDragTop", true)
addEventHandler("getDragTop", getRootElement(), function()
    syncDragTop(client)
end)

addEventHandler("onElementClicked", getRootElement(), function(key, state, client)
    if source == ped then
        if state == "down" then
            if printScoreDatas[client] then
                local leftText = -1
                
                if printScoreDatas[client][3] then
                    leftText = exports.sVehiclenames:getCustomVehicleName(printScoreDatas[client][1]) .. " (" .. printScoreDatas[client][3] .. ")"
                end
                
                local rightText = -1
                
                if printScoreDatas[client][4] then
                    rightText = exports.sVehiclenames:getCustomVehicleName(printScoreDatas[client][2]) .. " (" .. printScoreDatas[client][4] .. ")"
                end

                exports.sItems:giveItem(client, 584, 1, false, toJSON(printScoreDatas[client], true), leftText, rightText)
                exports.sGui:showInfobox(client, "s", "A kinyomtatott eredményt megtalálod az inventorydban.")
                
                printScoreDatas[client] = nil
            end
        end
    end
end)

addEventHandler("onResourceStop", getRootElement(), function(res)
    if res == getThisResource() then
        if fileExists("dragtop.sight") then
            fileDelete("dragtop.sight")
        end

        local file = fileCreate("dragtop.sight")
        fileWrite(file, toJSON(results, true))
        fileClose(file)
    end
end)

addEventHandler("onResourceStart", getRootElement(), function(res)
    if res == getThisResource() then
        if fileExists("dragtop.sight") then
            local file = fileOpen("dragtop.sight")
            local content = fileRead(file, fileGetSize(file))
            results = fromJSON(content)
            content = nil
            collectgarbage("collect")
            fileClose(file)
        end

        ped = createPed(50, -1515.1522216797, -9.5267457962036, 14.913536071777, 137)
        setElementData(ped, "invulnerable", true)
        setElementFrozen(ped, true)
        setElementData(ped, "pedNameType", "Drag verseny eredmény")
        setElementData(ped, "visibleName", "John Speedster")
    end
end)