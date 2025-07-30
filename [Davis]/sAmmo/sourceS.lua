machineContents = {}

pressContents = {}

playerOpenings = {}

machinePressed = {}

addEvent("requestAmmoMachineContent", true)
addEventHandler("requestAmmoMachineContent", root, function()
    for k, v in pairs(pressContents) do
        if v then
            triggerClientEvent(client, "clientPressMachineContent", getRootElement(), k, v)
        end
    end
    for k, v in pairs(machineContents) do
        if v then
            triggerClientEvent(client, "clientSmallMachineContent", getRootElement(), k, v, machinePressed[k], true)
        end
    end
end)

addEvent("fillAmmoShell", true)
addEventHandler("fillAmmoShell", root, function(machineId, item)
    machineContents[machineId] = item

    takeSmallMachineItem(client, item)

    machinePressed[machineId] = nil

    triggerClientEvent("clientSmallMachineContent", client, machineId, item)

    local itemName = exports.sItems:getItemName(item)

    exports.sChat:localAction(client, "elkezdett betölteni egy töltényhüvelyt. (" .. itemName .. " hüvely)")
end)

addEvent("pressSmallMachine", true)
addEventHandler("pressSmallMachine", root, function(machineId)
    local item = machineContents[machineId]
    machinePressed[machineId] = true
    triggerClientEvent("clientSmallMachineContent", client, machineId, item, true, false)
end)

addEvent("clientAmmoHammerHit", true)
addEventHandler("clientAmmoHammerHit", root, function()
    triggerClientEvent("clientAmmoHammerHit", client, math.random(1, 5))
end)

addEvent("gotPlayerOpeningAmmo", true)
addEventHandler("gotPlayerOpeningAmmo", root, function(id, r)
    playerOpenings[source] = {id, r}

    exports.sChat:localAction(source, "elkezdett kinyitni egy háborús lőszert.")
end)

addEvent("ammoOpeningResult", true)
addEventHandler("ammoOpeningResult", root, function(success)

    if success then
        local rand = math.random(30, 300)

        exports.sItems:giveItem(client, 742, rand)

        exports.sGui:showInfobox(client, "s", "Sikeresen kinyitottad a lőszert! " .. rand .. "g lőpor volt benne.")
    else
        local id, r = playerOpenings[client][1], math.random(1, 5)
        triggerClientEvent("clientAmmoExplosion", client, id, r)
    end

    setPedAnimation(client)
    playerOpenings[client] = nil

    triggerClientEvent("clientAmmoOpeningState", client)
end)

addEvent("takeSmallMachineShell", true)
addEventHandler("takeSmallMachineShell", root, function(machineId)
    local item = machineContents[machineId]
    if exports.sItems:hasSpaceForItem(client, item, 1) then
        triggerClientEvent("clientSmallMachineContent", client, machineId, false)
        machineContents[machineId] = nil
        machinePressed[machineId] = nil
        local itemName = exports.sItems:getItemName(item)
            
        exports.sItems:giveItem(client, item, 1)

        exports.sGui:showInfobox(client, "s", "Sikeresen kivetted a kész töltényt! (" .. itemName .. ")")

        exports.sChat:localAction(client, "kivette a kész töltényt a gépből. (" .. itemName .. ")")
    else
        exports.sGui:showInfobox(client,"e", "Nincs elég helyed az item kivételéhez!")
    end
end)

addEvent("requestHydraulicPress", true)
addEventHandler("requestHydraulicPress", root, function(machineId, itemId)
    pressContents[machineId] = itemId
    triggerClientEvent("clientPressMachineContent", source, machineId, itemId)
    setPedAnimation(source, "CASINO", "SLOT_PLYR", -1, false, false, false, false, 250, true)
    local item = ammoCraft[itemId][3]
    exports.sChat:localAction(source, "elkezdett töltényhüvelyeket készíteni. (" .. exports.sItems:getItemName(item) .. ")")
end)

addEvent("takePressMachineShell", true)
addEventHandler("takePressMachineShell", root, function(machineId)

    local item = pressContents[machineId]
    local itemId, itemAmount = ammoCraft[item][3], ammoCraft[item][2]

    exports.sItems:giveItem(client, itemId, itemAmount)
    pressContents[machineId] = false
    triggerClientEvent("clientPressMachineContent", source, machineId, false)

    exports.sGui:showInfobox(client, "s", "Sikeresen kivetted a kész hüvelyt a gépből! (".. itemAmount.. "db ".. exports.sItems:getItemName(itemId) .. ")")

    exports.sChat:localAction(client, "kivette a kész töltényhüvelyeket a gépből. (".. itemAmount.. "db ".. exports.sItems:getItemName(itemId) .. ")")
end)

function takeSmallMachineItem(client, item)
    local usageItem = ammoCraft[item][3]
    local items = exports.sItems:getElementItems(client)

    for k, v in pairs(items) do
        if v.itemId == usageItem then
            exports.sItems:takeItem(client, "dbID", v.dbID, 1)
            break
        end
    end

    local powder = ammoCraft[item][1]

    local itemsTook = 0

    for k, v in pairs(items) do
        if v.itemId == 742 and itemsTook < powder then
            if v.amount >= powder then
                exports.sItems:takeItem(client, "dbID", v.dbID, powder)
                itemsTook = powder
            elseif v.amount < powder then
                exports.sItems:takeItem(client, "dbID", v.dbID, v.amount)
                itemsTook = itemsTook + v.amount
            end
        end
    end
end

function isPressOccupied(press)
    return pressContents[press]
end

function getNearestPressMachine(player, playerX, playerY, playerZ)
    local nearestPoint = nil
    local nearestDistance = 5
    
    for k, pose in ipairs(pressMachines) do
        if pose[6] == getElementDimension(player) then
            local distance = getDistanceBetweenPoints3D(playerX, playerY, playerZ, pose[1], pose[2], pose[3])
            if distance < nearestDistance then
                nearestPoint = k
                nearestDistance = distance
            end
        end
    end
    
    return nearestPoint
end