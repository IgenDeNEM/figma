local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
    cond = cond and true or false
    if cond ~= sightlangCondHandlState0 then
        sightlangCondHandlState0 = cond
        if cond then
            addEventHandler("onClientPreRender", getRootElement(), processSubs, true, prio)
        else
            removeEventHandler("onClientPreRender", getRootElement(), processSubs)
        end
    end
end

local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
    cond = cond and true or false
    if cond ~= sightlangCondHandlState1 then
        sightlangCondHandlState1 = cond
        if cond then
            addEventHandler("onClientPreRender", getRootElement(), triggerForexUpdate, true, prio)
        else
            removeEventHandler("onClientPreRender", getRootElement(), triggerForexUpdate)
        end
    end
end

addEvent("onForexUpdate", false)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
    for k, v in pairs(indexes) do
        v.subs = {}
        v.currentSub = 0
        v.lastUpdate = 0
        v.price = false
        v.trend = false
    end
end)

function gotForexPriceUpdate(index, newPrice, trending, history, last12)
    local currentIndex = indexes[index]
    if currentIndex.currentSub >= 0 then
        currentIndex.price = newPrice
        currentIndex.trend = trending
        if last12 then
            currentIndex.last12Hourly = last12
        end
        if history and currentIndex.history then
            table.insert(currentIndex.history, newPrice)
            while 20 < #currentIndex.history do
                table.remove(currentIndex.history, 1)
            end
        end
        sightlangCondHandl1(true)
    end
end

addEvent("gotForexPriceUpdate", true)
addEventHandler("gotForexPriceUpdate", getRootElement(), gotForexPriceUpdate)
addEvent("gotForexMultiPriceUpdate", true)
addEventHandler("gotForexMultiPriceUpdate", getRootElement(), function(prices)
    for k, v in pairs(prices) do
        gotForexPriceUpdate(k, v[1], v[2])
    end
end)

addEvent("gotForexExtended", true)
addEventHandler("gotForexExtended", getRootElement(), function(datas)
    for index, v in pairs(datas) do
        if indexes[index].currentSub >= 2 then
            indexes[index].history = {}
            for i = 1, #v[2], 1 do
                table.insert(indexes[index].history, priceFromRate(v[2][i], v[1]))
            end
            indexes[index].last12Hourly = v[3]
            indexes[index].hour12List = v[4]
            sightlangCondHandl1(true)
        end
    end
end)

function triggerForexUpdate()
    triggerEvent("onForexUpdate", localPlayer)
    sightlangCondHandl1(false)
end

function processSubs()
    local subscription = false
    local refresh = true
    local now = getTickCount()
    for k, v in pairs(indexes) do
        local lastSub = 0
        for i in pairs(v.subs) do
            if lastSub < v.subs[i] then
                lastSub = v.subs[i]
                if lastSub >= 2 then
                    break
                end
            end
        end
        if lastSub ~= v.currentSub then
            if v.currentSub < lastSub or 5000 < now - v.lastUpdate then
                v.currentSub = lastSub
                v.lastUpdate = now
                if lastSub < 2 then
                    v.history = false
                    v.last12Hourly = false
                    v.hour12List = false
                    if lastSub < 1 then
                        v.price = false
                    end
                end
                sightlangCondHandl1(false)
                if not subscription then
                    subscription = {}
                end
                subscription[k] = v.currentSub
            end
            refresh = false
        end
    end
    if subscription then
        triggerServerEvent("onForexSubscriptionChange", localPlayer, subscription)
    end
    if refresh then
        sightlangCondHandl0(false)
    end
end

function setForexSubscription(type, sourceRes)
    local subRes = sourceRes or getResourceName(sourceResource)
    local now = getTickCount()
    for k, v in pairs(indexes) do
        if type == "all" or k == type then
            local t = nil
            if k == type then
                t = 2
            else
                t = 1
            end
            v.subs[subRes] = t
            v.lastUpdate = getTickCount()
        elseif v.subs[subRes] then
            v.subs[subRes] = nil
            v.lastUpdate = getTickCount()
        end
    end
    sightlangCondHandl0(true)
end
