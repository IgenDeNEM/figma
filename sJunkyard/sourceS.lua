addEvent("onClientTryToEnterJunkyard", true)
addEventHandler("onClientTryToEnterJunkyard", getRootElement(), function()
    if client and client == source then
        triggerClientEvent(client, "setJunkyardPanel", client, true)
    else
        exports.sAnticheat:anticheatBan(client, "AC #10 - sJunkyard @sourceS:6")
    end
end)

addEvent("tryToDestroyVehicle", true)
addEventHandler("tryToDestroyVehicle", getRootElement(), function()
    if client and client == source then
        local vehicleElement = getPedOccupiedVehicle(client)
        if vehicleElement and isElement(vehicleElement) and getElementType(vehicleElement) == "vehicle" then
            local vehicleOwner = getElementData(vehicleElement, "vehicle.owner")
            local clientIdentity = getElementData(client, "char.ID")
            if vehicleOwner == clientIdentity then
                exports.sVehicles:destroyVehicle(vehicleElement, client)

                local vehiclePrice = exports.sCarshop:getCarshopPrice(vehicleElement) or 0
                
                local getbackPrice = vehiclePrice / 5 

                if getbackPrice < 2000 then
                    getbackPrice = 5000
                end

                exports.sCore:giveMoney(client, getbackPrice)
            else
                outputChatBox("[color=sightgreen][SightMTA - Junkyard] [color=hudwhite]Amennyiben a jármű nem a tiéd nincs jogosultságod bebontani azt!", client)
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #11 - sJunkyard @sourceS:34")
    end
end)