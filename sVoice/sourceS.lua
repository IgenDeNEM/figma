local activeRequests = {}

local activeCallers = {}

addEvent("refreshVoiceStream", true)
addEventHandler("refreshVoiceStream", getRootElement(), function(streamList)
    if activeCallers[client] then
        table.insert(streamList, activeCallers[client])
    end
    setPlayerVoiceBroadcastTo(client, streamList)
end)

addEvent("setVoiceCallPartner", true)
addEventHandler("setVoiceCallPartner", getRootElement(), function(player, caller)
    if isElement(source) and not player then
        setPlayerVoiceBroadcastTo(source, {})

        if activeCallers[source] then
            setPlayerVoiceBroadcastTo(activeCallers[source], {})
            activeCallers[activeCallers[source]] = nil
        end
        activeCallers[source] = nil
    else 
        setPlayerVoiceBroadcastTo(player, caller)
        activeCallers[player] = caller
        activeCallers[caller] = player
    end
end)

function giveVoice(client, commandName, targetPlayer)
    if exports.sPermission:hasPermission(client, "felelj") then
        if targetPlayer then
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                if activeRequests[targetPlayer] then
                    outputChatBox("[color=sightred][SightMTA - Voice]: [color=hudwhite]A kiválasztott játékos már kapott egy kérelmet!", client, 255, 255, 255, true)
                else
                    activeRequests[targetPlayer] = client
                    triggerClientEvent(targetPlayer, "adminVoiceRequest", client, getElementData(client, "acc.adminNick") or "Admin")
                end
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Voice]: [color=hudwhite]/" .. commandName .. " [Játékos Név / ID]", client, 255, 255, 255, true)
        end
    end
end
addCommandHandler("givevoice", giveVoice)

addEvent("adminVoiceResponse", true)
addEventHandler("adminVoiceResponse", getRootElement(), function(state)
    if activeRequests[client] then
        local admin = activeRequests[client]

        if isElement(admin) then
            outputChatBox("[color=sightgreen][SightMTA - Voice]: [color=sightblue]" .. (getElementData(client, "visibleName") or getPlayerName(client)) .. " [color=hudwhite]a felelési kérelmet " .. ((state and "[color=sightgreen]elfogadta") or "[color=sightred]elutasította") .. "[color=hudwhite]!", admin, 255, 255, 255, true)
        end

        activeRequests[client] = nil
    end
end)

function takeVoice(client, commandName, targetPlayer)
    if exports.sPermission:hasPermission(client, "csitt") then
        if targetPlayer then
            local targetPlayer, targetName = exports.sCore:findPlayer(client, targetPlayer)

            if targetPlayer then
                activeRequests[targetPlayer] = nil
                triggerClientEvent(targetPlayer, "endAdminVoice", client)
            end
        else
            outputChatBox("[color=sightblue][SightMTA - Voice]: [color=hudwhite]/" .. commandName .. " [Játékos Név / ID]", client, 255, 255, 255, true)
        end
    end
end
addCommandHandler("takevoice", takeVoice)