bearcatPassangers = {}


addEvent("standOnBearcat", true)
addEventHandler("standOnBearcat", root, function(truck, slot)
    if client == source then
        if isPedInVehicle(client) then
            return
        end
        if not getElementData(client, "cuffed") then
            if getElementHealth(client) > 20 then
                if truck and isElement(truck) then
                    if not bearcatPassangers[truck] then
                        bearcatPassangers[truck] = {}
                    end
                    if not bearcatPassangers[truck][slot] then
                        bearcatPassangers[truck][slot] = client
                    end

                    exports.sControls:toggleControl(client, {
                        "aim_weapon",
                        "sprint",
                        "fire",
                        "enter_exit",
                        "jump",
                        "crouch"
                    }, false)


                    triggerClientEvent("gotNewBearcatPassanger", client, truck, slot, true)

                    attachElements(client, truck, offsets[slot][1], offsets[slot][2], offsets[slot][3], offsets[slot][4], offsets[slot][5], offsets[slot][6])
                end
            else
                exports.sGui:showInfobox(client, "e", "Animban nem kapaszkodhatsz fel!")
            end
        else
            exports.sGui:showInfobox(client, "e", "Bilincsbe nem kapaszkodhatsz fel!")
        end
    else
        -- ac ban
    end
end)

addEvent("requestBearcatPassangers", true)
addEventHandler("requestBearcatPassangers", root, function()
    triggerClientEvent(client, "gotAllBearcatPassangers", client, bearcatPassangers)
end)


addEventHandler("onPlayerWasted", root, function()
    for k, v in pairs(bearcatPassangers) do
        for key, value in pairs(bearcatPassangers[k]) do
            if value == source then
                bearcatPassangers[k][key] = false
                triggerClientEvent("gotNewBearcatPassanger", source, k, key, false)
            end
        end
    end
end)

addEventHandler("onPlayerQuit", root, function()
    for k, v in pairs(bearcatPassangers) do
        for key, value in pairs(bearcatPassangers[k]) do
            if value == source then
                bearcatPassangers[k][key] = false
                triggerClientEvent("gotNewBearcatPassanger", source, k, key, false)
            end
        end
    end
end)


addEvent("getOffBearcat", true)
addEventHandler("getOffBearcat", root, function(truck, slot)
    detachElements(client, truck)

    exports.sControls:toggleControl(client, {
        "aim_weapon",
        "sprint",
        "fire",
        "enter_exit",
        "jump",
        "crouch"
    }, true)

    bearcatPassangers[truck][slot] = false

    triggerClientEvent("gotNewBearcatPassanger", client, truck, slot, false)
end)

addEventHandler("onElementDestroy", root, function()
	if getElementType(source) == "vehicle" and getElementModel(source) == 528 then
        for k, v in pairs(bearcatPassangers) do
            if v == source then
                table.remove(bearcatPassangers, k)
            end
        end
	end
end)