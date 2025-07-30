enableds = {}

addEventHandler("onElementClicked", getRootElement(), function(button, state, client, x, y, z)
    if enableds[client] and button == "left" and state == "down" and (getElementType(source) == "player" or getElementType(source) == "ped") then
        if getElementType(source) == "player" then
            local dealtDamage = math.random(10, 15)
            setElementHealth(source, getElementHealth(source) - math.random(10, 15))
            if getElementHealth(source) - dealtDamage < 0 then
                setElementData(source, "customDeath", "Agyonostorozták. ("..getElementData(client, "visibleName")..")")
            end
        end

        triggerClientEvent(getRootElement(), "ostorCsapas", client, x, y, z, source)
    end
end)

addCommandHandler("ostor", function(client)
    if exports.sPermission:hasPermission(client, "ostor") then
        enableds[client] = not enableds[client]
        local state = enableds[client]
        outputChatBox("[color=sightblue][SightMTA]: [color=hudwhite]Ostor " .. ((state and "[color=sightgreen]bekapcsolva") or "[color=sightred]kikapcsolva") .. "[color=hudwhite].", client)
    end
end)