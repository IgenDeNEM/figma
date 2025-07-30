local budSpencers = {}
local carCarrys = {}

function setBudSpencer(client)
    if exports.sPermission:hasPermission(client, "setbudspencer") then
        budSpencers[client] = not budSpencers[client]
        outputChatBox("[color=sightgreen][SightMTA]: #FFFFFFBudspencer " .. (budSpencers[client] and "[color=sightgreen]bekapcsolva" or "[color=sightred]kikapcsolva") .. "#ffffff.", client, 255, 255, 255, true)
    end
end
addCommandHandler("setbudspencer", setBudSpencer)
addCommandHandler("budspencer", setBudSpencer)

function carCarry(client)
    if exports.sPermission:hasPermission(client, "setbudspencer") then
        local contactElement = getPedContactElement(client)
        if carCarrys[client] then
            setElementCollisionsEnabled(carCarrys[client], true)
            triggerClientEvent(getRootElement(), "gotCarCarryData", client, false)
            carCarrys[client] = false
        else
            if contactElement and getElementType(contactElement) == "vehicle" then
                carCarrys[client] = contactElement
                setElementCollisionsEnabled(contactElement, false)
                triggerClientEvent(getRootElement(), "gotCarCarryData", client, contactElement)
            end
        end
    end
end
addCommandHandler("carcarry", carCarry)
addCommandHandler("cipel", carCarry)

addEventHandler("onPlayerDamage", getRootElement(), function(attacker, damage, bodypart, loss)
    if budSpencers[attacker] then
        triggerClientEvent(getRootElement(), "playBudSpencerSound", source, math.random(1, 10))
    end
end)