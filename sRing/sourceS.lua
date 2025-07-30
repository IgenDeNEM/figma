local ringDatas = {
    currentRing = nil
}

local function updateLayout()
    ringDatas.currentRing = math.random(1, 4)
    triggerClientEvent("gotSeeringLayout", root, ringDatas.currentRing)
end

addEventHandler("onResourceStart", resourceRoot, function()
    removeWorldModel(10837, 2000, -1704.9752197266, -579.02069091797, 17.043182373047)

    updateLayout()

    local currentTime = getRealTime()
    local nextUpdate = 24 * 60 * 60 * 1000
    local msTillMidnight = nextUpdate - ((currentTime.hour * 60 + currentTime.minute) * 60 + currentTime.second) * 1000
    setTimer(function()
        updateLayout()
        setTimer(updateLayout, nextUpdate, 0)
    end, msTillMidnight, 1)
end)

addEvent("getSeeringLayout", true)
addEventHandler("getSeeringLayout", getRootElement(), function()
    if not ringDatas.currentRing then
        ringDatas.currentRing = math.random(1, 4)
    end
    triggerClientEvent(client, "gotSeeringLayout", client, ringDatas.currentRing)
end)

addCommandHandler("ringlayout", function(sourcePlayer, sourceCommand, ringStyle)
    if exports.sPermission:hasPermission(sourcePlayer, "ringlayout") then
        local ringStyle = tonumber(ringStyle)
        if ringStyle and tonumber(ringStyle) and ringStyle <= 4 then
            ringDatas.currentRing = tonumber(ringStyle)
            triggerClientEvent("gotSeeringLayout", root, tonumber(ringStyle))
            outputChatBox("[color=sightgreen][SightMTA - Ring]:[color=hudwhite] Sikeresen megváltoztattad a pályakiosztást.", sourcePlayer)
        else
            outputChatBox("[color=sightblue][SightMTA - Ring]:[color=hudwhite] /ringlayout [1-4]", sourcePlayer)
        end
    end
end)