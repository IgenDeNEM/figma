jobVehs = {}
shelves = {}
cartContents = {}
cartContentIds = {}
carts = {}
handItems = {}
vehDoors = {}
cargos = {}
needFulfill = {}
orderRemoved = {}
fulFilled = {}
for i = 1, #shelfPoses * 4 do
    shelves[i] = i
end

addEvent("requestUrmatransJobVehicle", true)
function requestUrmatransJobVehicle(id)
    local clientCharID = getElementData(client, "char.ID")

    if isElement(jobVehs[clientCharID]) then
        destroyElement(jobVehs[clientCharID])
        jobVehs[clientCharID] = nil
        triggerLatentClientEvent(client, "deleteUrmatransOrder", client)
        return
    end

    local pX, pY, pZ = getElementPosition(client)

    jobVehs[clientCharID] = createVehicle(582, pX, pY, pZ)
    setVehicleColor(jobVehs[clientCharID], 255, 255, 255)
    setElementData(jobVehs[clientCharID], "vehicle.fuel", 90)
    setElementData(jobVehs[clientCharID], "vehicle.fueled", 0)
    setElementData(jobVehs[clientCharID], "vehicle.battery", 100)
    setElementData(jobVehs[clientCharID], "vehicle.Battery", 100)
    setElementData(jobVehs[clientCharID], "vehicleNoCol", true)
    setVehiclePlateText(jobVehs[clientCharID], "MT-"..clientCharID)
    setElementData(jobVehs[clientCharID], "vehicle.plate", "MT-"..clientCharID)
    setElementData(jobVehs[clientCharID], "vehicle.currentTexture", math.random(1, 18))
    setElementData(jobVehs[getElementData(client,"char.ID")], "veh:job", getElementData(client,"char.ID"))
    setTimer(giveBackCol, 1000 * 35, 1, jobVehs[clientCharID])
    warpPedIntoVehicle(client, jobVehs[clientCharID])
    triggerClientEvent("gotNewUrmatransVehicle", jobVehs[clientCharID], getElementData(client, "char.ID"))
end
addEventHandler("requestUrmatransJobVehicle", root, requestUrmatransJobVehicle)

function findJobVehicle(vehicleId)
    local foundVehicle = false
    for jobVehicleId, vehicleElement in pairs(jobVehs) do
        if jobVehicleId and jobVehicleId == vehicleId then
            foundVehicle = vehicleElement
            break
        end
    end
    return foundVehicle
end

addCommandHandler("getjobvehicle", function(sourcePlayer, commandName, vehicleIdentity)
    if exports.sPermission:hasPermission(sourcePlayer, "getjobvehicle") then
        if not vehicleIdentity or not tonumber(vehicleIdentity) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Jármű azonosító]", sourcePlayer)
            return
        end

        local vehicleElement = findJobVehicle(tonumber(vehicleIdentity))

        if vehicleElement and isElement(vehicleElement) then
            local x, y, z = getElementPosition(sourcePlayer)
            local int = getElementInterior(sourcePlayer)
            local dim = getElementDimension(sourcePlayer)
            local rx, ry, rz = getElementRotation(sourcePlayer)

            x = x + math.cos(math.rad(rz)) * 2
            y = y + math.sin(math.rad(rz)) * 2

            setElementPosition(vehicleElement, x, y, z)
            setElementRotation(vehicleElement, 0, 0, rz)
            setElementInterior(vehicleElement, int)
            setElementDimension(vehicleElement, dim)

            exports.sNocol:enableVehicleNoCol(vehicleElement, 10000)
    
            outputChatBox("[color=sightgreen][SightMTA - Munka]: [color=hudwhite]Sikeresen magadhoz teleportáltad a kiválasztott járművet", sourcePlayer)
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található munkajármű!", sourcePlayer)
        end
    end
end)

addCommandHandler("gotojobvehicle", function(sourcePlayer, commandName, vehicleIdentity)
    if exports.sPermission:hasPermission(sourcePlayer, "gotojobvehicle") then
        if not vehicleIdentity or not tonumber(vehicleIdentity) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Jármű azonosító]", sourcePlayer)
            return
        end

        local vehicleElement = findJobVehicle(tonumber(vehicleIdentity))

        if isElement(vehicleElement) then
            local x, y, z = getElementPosition(vehicleElement)
            local int = getElementInterior(vehicleElement)
            local dim = getElementDimension(vehicleElement)
            local rx, ry, rz = getElementRotation(vehicleElement)

            x = x + math.cos(math.rad(rz)) * 2
            y = y + math.sin(math.rad(rz)) * 2

            setElementPosition(sourcePlayer, x, y, z)
            setElementRotation(sourcePlayer, 0, 0, rz)
            setElementInterior(sourcePlayer, int)
            setElementDimension(sourcePlayer, dim)

            outputChatBox("[color=sightgreen][SightMTA - Munka]: [color=hudwhite]Sikeresen elteleportáltál a kiválasztott járművet", sourcePlayer)
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található munkajármű!", sourcePlayer)
        end
    end
end)

addCommandHandler("deljobvehicle", function(sourcePlayer, commandName, vehicleIdentity)
    if exports.sPermission:hasPermission(sourcePlayer, "deljobvehicle") then
        if not vehicleIdentity or not tonumber(vehicleIdentity) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Jármű azonosító]", sourcePlayer)
            return
        end

        local vehicleIdentity = tonumber(vehicleIdentity)
        local vehicleElement = findJobVehicle(vehicleIdentity)
        local vehicleOwner = false

        if isElement(vehicleElement) then
            for _, playerElement in pairs(getElementsByType("player")) do
                if getElementData(playerElement, "char.ID") == vehicleIdentity then
                    vehicleOwner = playerElement
                end
            end

            destroyElement(jobVehs[vehicleIdentity])
            jobVehs[vehicleIdentity] = nil

            outputChatBox("[color=sightgreen][SightMTA - Munka]: [color=hudwhite]Sikeresen kitörölted a kiválasztott járművet.", sourcePlayer)

            local adminTitle = exports.sAdministration:getPlayerAdminTitle(sourcePlayer) .. " " .. getElementData(sourcePlayer, "acc.adminNick")
            outputChatBox("[color=sightgreen][SightMTA - Munka]: [color=hudwhite]"..adminTitle.." [color=hudwhite]kitörölte a munkajárművedet!", vehicleOwner)

            if vehicleOwner then
                triggerLatentClientEvent(vehicleOwner, "deleteUrmatransOrder", vehicleOwner)
            end
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található munkajármű!", sourcePlayer)
        end
    end
end)

addCommandHandler("getjobvehof", function(sourcePlayer, commandName, vehicleIdentity)
    if exports.sPermission:hasPermission(sourcePlayer, "getjobvehof") then
        if not vehicleIdentity or not tonumber(vehicleIdentity) then
            outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/" .. commandName .. " [Jármű azonosító]", sourcePlayer)
            return
        end

        local vehicleIdentity = tonumber(vehicleIdentity)
        local vehicleElement = findJobVehicle(vehicleIdentity)
        local vehicleOwner = false

        if isElement(vehicleElement) then
            for _, playerElement in pairs(getElementsByType("player")) do
                if getElementData(playerElement, "char.ID") == vehicleIdentity then
                    vehicleOwner = playerElement
                end
            end

            outputChatBox("[color=sightgreen][SightMTA - Munka]: [color=hudwhite]A munkajármű tulajdonosa: [color=sightgreen]"..getElementData(vehicleOwner, "visibleName"):gsub("_", " ").."[color=hudwhite].", sourcePlayer)
        else
            outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nem található munkajármű!", sourcePlayer)
        end
    end
end)

addEvent("requestUrmatransData", true)
function requestUrmatransData()
    triggerClientEvent(client, "gotUrmatransData", client, shelves, carts, cartContents, handItems, jobVehs, vehDoors, cargos)
end
addEventHandler("requestUrmatransData", root, requestUrmatransData)

addEvent("createUrmatransJob", true)
function createUrmatransJob()
    local order = {}
    local orderCount = math.random(1, 5)
    fulFilled[client] = 0
    orderRemoved[client] = 0
    needFulfill[client] = orderCount
    for i = 1, orderCount do
        if not order[i] then
            order[i] = {}
        end
        local itemCount = math.random(1, 5)
        local item = math.random(1, 4)
        for k = 1, item do
            order[i][math.random(1, 28)] = math.random(1, 3)
        end
    end
    triggerClientEvent(client, "gotUrmatransOrder", client, order)
end
addEventHandler("createUrmatransJob", root, createUrmatransJob)

addEvent("toggleUrmatransCart", true)
function toggleUrmatransCart()
    if not carts[client] then
        carts[client] = true
        triggerClientEvent("gotNewUrmatransCart", client, getElementData(client, "char.ID"))
    else 

        if not cartContents[client] then
            cartContents[client] = {}
        end

        if not cartContentIds[client] then
            cartContentIds[client] = {}
        end

        if #cartContents[client] == 0 then
            carts[client] = nil
            triggerClientEvent("deleteUrmatransCart", client, getElementData(client, "char.ID"))
        else
            triggerClientEvent(client, "showInfobox", client, "e", "Amíg nem üres a kézikocsi addig nem rakhatod vissza!")
        end
    end
end
addEventHandler("toggleUrmatransCart", root, toggleUrmatransCart)

local shelfTimer = {}

addEvent("pickUpUrmatransCargo", true)
function pickUpUrmatransCargo(id, cargo)
    if not needFulfill[client] then
        exports.sGui:showInfobox(client, "e", "Hogyha nincs aktív rendelésed, nem tudsz dobozokat felvenni!")
        return
    end

    if isTimer(shelfTimer[id]) then
        killTimer(shelfTimer[id])
    end

    shelfTimer[id] = setTimer(function(shelfIdentity, cargoIdentity)
        triggerClientEvent("refreshUrmatransShelves", resourceRoot, shelfIdentity, cargoIdentity, true)
    end, 120000, 1, id, cargoIdentity)

    setPedAnimation(client,"CARRY","crry_prtial",0,true,true,false,true) 
    handItems[client] = {id, cargo}
    triggerClientEvent("refreshUrmatransShelves", client, id, cargo, false)
    triggerClientEvent("refreshUrmatransHandContent", client, id)
end
addEventHandler("pickUpUrmatransCargo", root, pickUpUrmatransCargo)

addEvent("putUrmatransCargoToCart", true)
function putUrmatransCargoToCart()
    setPedAnimation(client,"CARRY","putdwn",750,false,true,false,false) 
    if not cartContents[client] then
        cartContents[client] = {}
    end
    if not cartContentIds[client] then
        cartContentIds[client] = {}
    end
    table.insert(cartContents[client], handItems[client][1])
    table.insert(cartContentIds[client], handItems[client][2])
    triggerClientEvent("urmatransAddedToCart", client, handItems[client][1])
    triggerClientEvent("refreshUrmatransHandContent", client)
    handItems[client] = nil
end
addEventHandler("putUrmatransCargoToCart", root, putUrmatransCargoToCart)

addEvent("removeUrmatransCargoFromCart", true)
function removeUrmatransCargoFromCart(cargo)
    setPedAnimation(client,"CARRY","crry_prtial",0,true,true,false,true) 
    triggerClientEvent("urmatransRemovedFromCart", client, cargo)
    triggerClientEvent("refreshUrmatransHandContent", client, cargo)
    for k, v in pairs(cartContents[client]) do
        if v == cargo then
            handItems[client] = {cargo, cartContentIds[client][k]}
            cartContents[client][k] = nil
            cartContentIds[client][k] = nil
            break
        end
    end
end
addEventHandler("removeUrmatransCargoFromCart", root, removeUrmatransCargoFromCart)

addEvent("urmatransSprinterRemoveCargo", true)
function urmatransSprinterRemoveCargo(id, delete)
    if delete then
        triggerClientEvent("refreshUrmatransHandContent", client, id)
        handItems[client] = {id, 1}
        cargos[source][id] = nil
        triggerClientEvent("urmatransRemovedFromVehicle", source, id)
        setPedAnimation(client,"CARRY","crry_prtial",0,true,true,false,true) 
        return
    end
    triggerClientEvent("urmatransRemovedFromVehicle", source, id)
    cargos[source][id] = nil
    triggerClientEvent(client, "showInfobox", client, "info",
    "Az árut az [F] gombbal tudod letenni a címen található kék zónában.", 4000)
end
addEventHandler("urmatransSprinterRemoveCargo", root, urmatransSprinterRemoveCargo)

addEvent("urmatransPutCargoInVehicle", true)
function urmatransPutCargoInVehicle()
    if not cargos[source] then
        cargos[source] = {} 
    end
    setPedAnimation(client,"CARRY","putdwn",750,false,true,false,false) 
    table.insert(cargos[source], handItems[client][1])
    triggerClientEvent("urmatransAddedToVehicle", source, handItems[client][1])
    triggerClientEvent("refreshUrmatransHandContent", client)
    handItems[client] = nil
end
addEventHandler("urmatransPutCargoInVehicle", root, urmatransPutCargoInVehicle)

addEvent("putBackUrmatransCargo", true)
function putBackUrmatransCargo(id, cargo)
    triggerClientEvent("refreshUrmatransShelves", client, handItems[client][1], handItems[client][2], true)
    triggerClientEvent("refreshUrmatransHandContent", client)
    setPedAnimation(client,"CARRY","putdwn",750,false,true,false,false) 
    handItems[client] = nil
end
addEventHandler("putBackUrmatransCargo", root, putBackUrmatransCargo)

addEvent("putDownUrmatransCart", true)
function putDownUrmatransCart(x, y, z, r)
    carts[client] = {x, y, z, r}
    triggerClientEvent("urmatransCartAttachState", client, x, y, z, r)
end
addEventHandler("putDownUrmatransCart", root, putDownUrmatransCart)

addEvent("pickUpUrmatransCart", true)
function pickUpUrmatransCart(x, y, z, r)
    if carts[client] and type(carts[client]) == "table" then
        triggerClientEvent("urmatransCartAttachState", client)
        carts[client] = true
        return
    end
    triggerClientEvent("gotNewUrmatransCart", client, getElementData(client, "char.ID"))
end
addEventHandler("pickUpUrmatransCart", root, pickUpUrmatransCart)


addEvent("fulfillUrmatransOrder", true)
function fulfillUrmatransOrder(i, id)
    local x, y, z = getElementPosition(client)
    local _, _, r = getElementRotation(client)
    triggerClientEvent(client, "urmatransOrderFulfilled", client, i, id, x, y, z, r)
    triggerClientEvent("refreshUrmatransHandContent", client)
    if not orderRemoved[client] then
        orderRemoved[client] = 0
    end
    orderRemoved[client] = orderRemoved[client] + 1
    setPedAnimation(client,"CARRY","putdwn",750,false,true,false,false) 
end
addEventHandler("fulfillUrmatransOrder", root, fulfillUrmatransOrder)

addEvent("orderFulFilled", true)
function orderFulFilled()
    if orderRemoved[client] >= 1 then
        local targetMoneyValue = exports.sCore:getMoney(client)
        local targetPPValue = exports.sCore:getPP(client) 
        local targetNewPPValue = targetPPValue + math.floor(orderRemoved[client] * 10)
        local targetNewMoneyValue = targetMoneyValue + math.floor(orderRemoved[client] * 2000)

        exports.sDashboard:givePlayerAchievement(client, "work")

        exports.sCore:setMoney(client, targetNewMoneyValue)
        exports.sCore:setPP(client, targetNewPPValue)

        triggerClientEvent(client, "showInfobox", client, "success", "Megkaptad a fizetésed: ".. math.floor(orderRemoved[client] * 2000) .." $ és " .. math.floor(orderRemoved[client] * 10) .. " PP", 6000)
        orderRemoved[client] = 0
        if not fulFilled[client] then
            fulFilled[client] = 0
        end
        fulFilled[client] = fulFilled[client] + 1
        if fulFilled[client] == needFulfill[client] then
            triggerLatentClientEvent(client, "deleteUrmatransOrder", client)
        end
    end
end
addEventHandler("orderFulFilled", root, orderFulFilled)

addEvent("toggleUrmatransSprinterDoor", true)
function toggleUrmatransSprinterDoor()
    local veh = source
    if not vehDoors[veh] then
        vehDoors[veh] = false
    end
    vehDoors[veh] = not vehDoors[veh]
    triggerClientEvent("toggleUrmatransSprinterDoor", veh, vehDoors[veh])
end
addEventHandler("toggleUrmatransSprinterDoor", root, toggleUrmatransSprinterDoor)

function giveBackCol(veh)
    if isElement(veh) then
        setElementData(veh, "vehicleNoCol", false)
    end
end