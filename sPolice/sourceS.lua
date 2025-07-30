local rbsList = {}
local toggle = {}
local rbsCount = 0

addEvent("requestRBSList", true)
addEventHandler("requestRBSList", root,
function ()
    triggerClientEvent(client, "gotRBSList", client, rbsList, toggle)
end
)

addEvent("addNewRBS", true)
addEventHandler("addNewRBS", root,
function (model, x, y, z, rz, int, dim)
    local placerName = string.gsub(getElementData(client, "visibleName"), "_", " ")
    local characterId = getElementData(client, "char.ID")
    
    rbsCount = rbsCount + 1
    
    rbsList[rbsCount] = {
        model,
        x,
        y,
        z,
        rz,
        int,
        dim,
        placerName,
        characterId
    }
    
    table.insert(toggle, false)
    
    triggerClientEvent("syncRBSData", client, rbsCount, rbsList[rbsCount], toggle[rbsCount])
end
)

addEvent("deleteRBS", true)
addEventHandler("deleteRBS", root,
function (rbsId)
    rbsList[rbsId] = nil
    toggle[rbsId] = nil
    
    triggerClientEvent("syncRBSData", client, rbsId, false, false)
end
)

addEvent("toggleRBS", true)
addEventHandler("toggleRBS", root,
function (rbsId)
    toggle[rbsId] = not toggle[rbsId]
    
    triggerClientEvent("toggleRBS", client, rbsId, toggle[rbsId])
end
)

addCommandHandler("rbs",
function (sourcePlayer, commandName)
    local hasPermission = exports.sGroups:getPlayerPermission(sourcePlayer, "rbs")
    
    if not hasPermission then
        return
    end
    
    local playerX, playerY, playerZ = getElementPosition(sourcePlayer)
    
    for k, v in pairs(getElementsByType("vehicle")) do
        local vehicleX, vehicleY, vehicleZ = getElementPosition(v)
        local distance = getDistanceBetweenPoints3D(playerX, playerY, playerZ, vehicleX, vehicleY, vehicleZ)
        
        if distance <= 10 then
            local model = getElementModel(v)
            
            triggerClientEvent(sourcePlayer, "openRBSGui", sourcePlayer, model, v)
            
            break
        end
    end
end
)

local createdSpikes = {}

addCommandHandler("spike", function(sourcePlayer) --(cid, x, y, z, rz)
    if exports.sGroups:getPlayerPermission(sourcePlayer, "spike") then
        for playerIdentity, spikeValue in pairs(createdSpikes) do
            if playerIdentity == getElementData(sourcePlayer, "char.ID") and spikeValue[1] then
                outputChatBox("[color=sightred][SightMTA - Police]: [color=hudwhite]Mielőtt leraknál egy újat töröld ki az előzőt!", sourcePlayer)
                return
            end 
        end

        local isPedInVehicle = getPedOccupiedVehicle(sourcePlayer)
        if isPedInVehicle then
            exports.sGui:showInfobox(sourcePlayer, "e", "Ezt nem használhatod járműben!")
            return
        end

        local playerPosition = {getElementPosition(sourcePlayer)}
        local playerRotation = {getElementRotation(sourcePlayer)}
        local playerIdentity = getElementData(sourcePlayer, "char.ID")
        
        createdSpikes[playerIdentity] = {true, playerPosition}

        triggerClientEvent("syncSpike", sourcePlayer, playerIdentity, playerPosition[1], playerPosition[2], playerPosition[3] - 0.95, playerRotation[3])
    end
end)

addCommandHandler("nearbyspikes", function(sourcePlayer)
    if exports.sGroups:getPlayerPermission(sourcePlayer, "spike") or getElementData(sourcePlayer, "acc.adminLevel") >= 1 then
        outputChatBox("[color=sightgreen][SightMTA - Police]: [color=hudwhite]A közeledben lévő spikeok: ", sourcePlayer)
        for k, v in pairs(createdSpikes) do
            local sourcePos = {getElementPosition(sourcePlayer)}
            if v[1] then
                local spikeDis = getDistanceBetweenPoints3D(sourcePos[1], sourcePos[2], sourcePos[3], v[2][1], v[2][2], v[2][3])
                if spikeDis < 20 then
                    outputChatBox("[color=sightred]  * [color=hudwhite]["..k.."] ".. v[2][1] ..", ".. v[2][2] ..", ".. v[2][3] .." [color=sightred][".. math.floor(spikeDis) .."M]", sourcePlayer)
                end
            end
        end
    end
end)

addCommandHandler("delspike", function(sourcePlayer, commandName, spikeIdentity)
    if exports.sPermission:hasPermission(sourcePlayer, "delspike") then
        local spikeIdentity = tonumber(spikeIdentity)
        if not spikeIdentity then
            outputChatBox("[color=sightblue][SightMTA - Police]: [color=hudwhite]/" .. commandName .. " [ID]", sourcePlayer, 255, 255, 255, true)
            return
        end

        local spikeOwner = nil
        for playerId in pairs(createdSpikes) do
            for playerIndex, playerElement in pairs(getElementsByType("player")) do
                if getElementData(playerElement, "char.ID") == playerId then
                    spikeOwner = playerElement
                end                    
            end
        end

        outputChatBox("[color=sightgreen][SightMTA - Police]: [color=hudwhite]Sikeresen kitöröltél egy spike-ot!", sourcePlayer)
        if spikeOwner and isElement(spikeOwner) then
            outputChatBox("[color=sightgreen]  * [color=hudwhite]Spike tulajdonosa: "..getElementData(spikeOwner, "visibleName"):gsub("_", " "), sourcePlayer)
            outputChatBox("[color=sightred][SightMTA]: [color=hudwhite]Egy adminisztrátor kitörölte a lehelyezett spike-od! ["..spikeIdentity..", Admin: "..getElementData(sourcePlayer, "acc.adminNick").."]", spikeOwner)
        end

        createdSpikes[spikeIdentity] = {false, nil}
        triggerClientEvent("syncSpike", resourceRoot, spikeIdentity)
    end
end)

addEventHandler("onPlayerQuit", root, function()
    local sourceIdentity = getElementData(source, "char.ID") or nil
    if not sourceIdentity then
    end

    if createdSpikes[sourceIdentity] then
        createdSpikes[sourceIdentity] = {false, nil}
        triggerClientEvent("syncSpike", resourceRoot, spikeIdentity)
    end
end)

local poppedWheels = {}

addEvent("spikeDamageWheels", true)
addEventHandler("spikeDamageWheels", root, function(wheelIdentity)
    if source and source == client then
        local sourceVehicle = getPedOccupiedVehicle(client)

        if not poppedWheels[sourceVehicle] then
            poppedWheels[sourceVehicle] = {
                [1] = {false, alreadyPopped = false}, --//* frontLeft
                [2] = {false, alreadyPopped = false}, --//* rearLeft
                [3] = {false, alreadyPopped = false}, --//* frontRight
                [4] = {false, alreadyPopped = false}, --//* rearRight
            }
        end

        local vehicleWheelStates = {getVehicleWheelStates(sourceVehicle)}

        if vehicleWheelStates[wheelIdentity] == 0 then
            if not poppedWheels[sourceVehicle][wheelIdentity].alreadyPopped then
                poppedWheels[sourceVehicle][wheelIdentity][1] = true
                poppedWheels[sourceVehicle][wheelIdentity].alreadyPopped = true
            end
        end

        setVehicleWheelStates(
            sourceVehicle,
            poppedWheels[sourceVehicle][1][1] and 1 or 0, --//* frontLeft
            poppedWheels[sourceVehicle][2][1] and 1 or 0, --//* rearLeft
            poppedWheels[sourceVehicle][3][1] and 1 or 0, --//* frontRight
            poppedWheels[sourceVehicle][4][1] and 1 or 0  --//* rearRight
        )
        triggerClientEvent("wheelPunctureSound", sourceVehicle, wheelIdentity)
    else
        exports.sAnticheat:anticheatBan(client, "AC #79 - sPolice @sourceS:191")
    end
end)

addEvent("tryToDeleteSpike", true)
addEventHandler("tryToDeleteSpike", root, function(spikeIdentity)
    local function isValidSpike(spikeIdentity)
        for playerIdentity, spikeValue in pairs(createdSpikes) do
            if playerIdentity == spikeIdentity and spikeValue[1] then
                return true
            end
        end
        return false
    end

    local validSpike = isValidSpike(spikeIdentity)
    if not validSpike then
        exports.sAnticheat:anticheatBan(client, "AC #80 - sPolice @sourceS:208")
        return
    end

    if client ~= source then
        exports.sAnticheat:anticheatBan(client, "AC #81 - sPolice @sourceS:213")
        return
    end

    createdSpikes[getElementData(client, "char.ID")] = {false, nil}

    triggerClientEvent("syncSpike", client, spikeIdentity)
end)

addEvent("doCuffPlayer", true)
addEventHandler("doCuffPlayer", root, 
function(hoverPlayer)
    if isElement(hoverPlayer) then
        local x, y, z = getElementPosition(client)
        local tx, ty, tz = getElementPosition(hoverPlayer)
        if getDistanceBetweenPoints3D(tx, ty, tz, x, y, z) > 10 then
            exports.sAnticheat:anticheatBan(client, "AC #124 - sPolice @sourceS:229")
            return
        end
        if exports.sItems:hasItem(client, 118) or exports.sItems:hasItem(client, 119) then
            local playerCuff = getElementData(hoverPlayer, "cuffed") 

            if playerCuff then
                exports.sControls:toggleControl(hoverPlayer, {
                    "aim_weapon",
                    "sprint",
                    "fire",
                    "enter_exit",
                    "jump",
                    "crouch",
                    "jog"
                }, true)


                setElementData(hoverPlayer, "carryingOther2", false)
                setElementData(hoverPlayer, "cuffedBy", false)
                setElementData(client, "carryingOther2", false)


                setElementData(hoverPlayer, "carryingOther", false)
                setElementData(client, "carryingOther", false)

                detachElements(client, hoverPlayer)
                detachElements(hoverPlayer, client)

            else
                exports.sControls:toggleControl(hoverPlayer, {
                    "aim_weapon",
                    "sprint",
                    "fire",
                    "enter_exit",
                    "jump",
                    "crouch",
                    "jog"
                }, false)

            end
            setElementData(hoverPlayer, "cuffedBy", client)
            setElementData(hoverPlayer, "cuffed", not playerCuff)

            triggerClientEvent("cuffedSoundEffect", client, not playerCuff)

            if not playerCuff then
                local items = exports.sItems:getElementItems(client)

                for k, v in pairs(items) do
                    if v.itemId == 118 then
                        exports.sItems:takeItem(client, "dbID", v.dbID)
                        break
                    end
                end
            elseif playerCuff then
                if exports.sItems:hasItem(client, 119) then
                    exports.sItems:giveItem(client, 118, 1)
                end
            end
            
            exports.sChat:localAction(client, (playerCuff and "elengedte" or "megbilincselte").." " .. getElementData(hoverPlayer, "visibleName"):gsub("_", " ") .. "-t.")
        else
            -- haker
        end
    end
end
)

addEventHandler("onResourceStart", resourceRoot, function()
    for _, playerElement in ipairs(getElementsByType("player")) do
        setElementData(playerElement, "cuffed", false)
        setElementData(playerElement, "carryingOther", false)
        setElementData(playerElement, "carryingOther2", false)
    end
end)

addEventHandler("onPlayerWasted", root, function()
    
    local carriedBy = getElementData(source, "carryingOther2")

    local carried = getElementData(source, "carryingOther")

    setElementData(source, "cuffed", false)

    if carriedBy and isElement(carriedBy) then
        setElementData(carriedBy, "carryingOther", false)
        setElementData(source, "carryingOther", false)
        detachElements(source, carriedBy)
        detachElements(carriedBy, source)
    end
    if carried and isElement(carried) then
        setElementData(carried, "carryingOther2", false)
        setElementData(source, "carryingOther2", false)
        detachElements(source, carried)
        detachElements(carried, source)
    end
    setElementData(source, "carryingOther2", false)
    setElementData(source, "carryingOther", false)
    setElementData(source, "cuffed", false)
end)

addEvent("doViszPlayer", true)
addEventHandler("doViszPlayer", root, function(hoverPlayer)
    if isElement(hoverPlayer) then

        local x, y, z = getElementPosition(client)
        local tx, ty, tz = getElementPosition(hoverPlayer)
        if getDistanceBetweenPoints3D(tx, ty, tz, x, y, z) > 6 then
            exports.sAnticheat:anticheatBan(client, "AC #125 - sPolice @sourceS:338")
            return
        end

        if hoverPlayer == client then
            exports.sAnticheat:anticheatBan(client, "AC #126 - sPolice @sourceS:343")
            return
        end

        if getElementData(client, "cuffed") then
            outputChatBox("[color=sightred][SightMTA - Police] [color=hudwhite]Bilincsben nem kivitelezhető", client)
            return
        end
        if getElementData(client, "carryingOther") == hoverPlayer then
            setElementData(client, "carryingOther", false)
            detachElements(hoverPlayer, client)
            detachElements(client, hoverPlayer)
            exports.sControls:toggleControl(client, {
                "jump",
                "sprint",
                "crouch",
                "aim_weapon",
                "fire",
                "enter_exit",
                "jog",
              }, true)
        else
            setElementData(client, "carryingOther", hoverPlayer)
            setElementData(hoverPlayer, "carryingOther2", client)
            attachElements(hoverPlayer, client, 0.4, 0.4)
            exports.sControls:toggleControl(client, {
                "jump",
                "sprint",
                "crouch",
                "aim_weapon",
                "fire",
                "enter_exit",
                "jog",
              }, false)
        end
    end
end)

addEvent("jumpFallAnimation", true)
addEventHandler("jumpFallAnimation", getRootElement(), function()
    if client and client == source then
        setPedAnimation(client, "ped", "floor_hit_f", -1, false)
    end
end)
addEvent("putPlayerInVehicle", true)
addEventHandler("putPlayerInVehicle", getRootElement(), function(vehicleElement, hoveringDoor)
    if source and source == client then
        local playerElement = getElementData(client, "carryingOther", hoverPlayer)
        if playerElement and isElement(playerElement) then
            detachElements(playerElement, client)
            detachElements(client, playerElement)
            warpPedIntoVehicle(playerElement, vehicleElement, hoveringDoor)
            setElementData(client, "carryingOther", false)
            setElementData(playerElement, "carryingOther2", false)

            exports.sControls:toggleControl(playerElement, {
                "jump",
                "sprint",
                "crouch",
                "aim_weapon",
                "fire",
                "enter_exit",
                "jog",
              }, false)

            exports.sControls:toggleControl(client, {
                "jump",
                "sprint",
                "crouch",
                "aim_weapon",
                "fire",
                "enter_exit",
                "jog",
              }, true)
        end
    end
end)