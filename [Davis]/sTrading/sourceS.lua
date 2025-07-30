forexDatas = {}
forexPriceDatas = {
    AMB = { base = 146000, min = 73000, max = 219000, volatility = 73000 },
    AME = { base = 39818, min = 19909, max = 59727, volatility = 19909 },
    ALU = { base = 29982, min = 14991, max = 44973, volatility = 14991 },
    CHR = { base = 75500, min = 37750, max = 113250, volatility = 37750 },
    COL = { base = 6257, min = 3128.5, max = 9385.5, volatility = 3128.5 },
    COP = { base = 41433, min = 20716.5, max = 62149.5, volatility = 20716.5 },
    DIA = { base = 438000, min = 219000, max = 657000, volatility = 219000 },
    EMD = { base = 219000, min = 109500, max = 328500, volatility = 109500 },
    GOL = { base = 262055, min = 131027.5, max = 393082.5, volatility = 131027.5 },
    IRN = { base = 21966, min = 10983, max = 32949, volatility = 10983 },
    NIK = { base = 85928, min = 42964, max = 128892, volatility = 42964 },
    PLT = { base = 182192, min = 91096, max = 273288, volatility = 91096 },
    RUB = { base = 365000, min = 182500, max = 547500, volatility = 182500 },
    SRC = { base = 500000, min = 250000, max = 750000, volatility = 250000 },
}

function updateForexPrices()
    for index, data in pairs(forexPriceDatas) do
        if not forexDatas[index] then
            forexDatas[index] = {
                price = exports.sMining:getOrePrice(index) or forexPriceDatas[index].base,
                history = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
                last12Hourly = {1000, 1000},
                hour12List = {{1000, 1000}, {1000, 1000}},
                priceHistory = {10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
                min = data.min,
                max = data.max,
                base = exports.sMining:getOrePrice(index) or forexPriceDatas[index].base,
                volatility = data.volatility
            }
        end

        local current = forexDatas[index]

        local rate = (math.random(600, 1000) / 1000)

        local newPrice = math.floor(priceFromRate(rate, data.base)) or 1
        local oldPrice = current.price or 1

        current.trending = newPrice > oldPrice

        
        if #current.history == 12 then
            table.remove(current.history, 1)
        end

        table.insert(current.history, rate)

        if #current.priceHistory == 36 then
            table.remove(current.priceHistory, 1)
        end

        table.insert(current.priceHistory, newPrice)

        local twelvePrice = {}
        
        for i = 24, 36 do
            table.insert(twelvePrice, current.priceHistory[i])
        end

        local avg, med = avgMed(twelvePrice)

        current.last12Hourly = {avg, med}

        local last24Price = {}
        local last36Price = {}

        for i = 12, 24 do
            table.insert(last24Price, current.priceHistory[i])
        end

        for i = 1, 12 do
            table.insert(last36Price, current.priceHistory[i])
        end

        local avg1, med1 = avgMed(last24Price)

        local avg2, med2 = avgMed(last24Price)

        current.hour12List = {{avg1, med1}, {avg2, med2}}

        current.price = newPrice

        triggerClientEvent("gotForexPriceUpdate", getRootElement(), index, newPrice, current.trending, true, current.last12Hourly)
        triggerClientEvent("gotForexExtended", getRootElement(), {[index] = {newPrice, current.history, current.last12Hourly, current.hour12List}})
    end
end

setTimer(updateForexPrices, 1, 36)
setTimer(updateForexPrices, (1000 * 60) * 60, 0)

addEvent("onForexSubscriptionChange", true)
addEventHandler("onForexSubscriptionChange", root, function()
    for index, data in pairs(forexDatas) do
        triggerClientEvent(client, "gotForexPriceUpdate", client, index, data.price, data.trending, true, data.last12Hourly)
        triggerClientEvent(client, "gotForexExtended", client, {[index] = {data.price, data.history, data.last12Hourly, data.hour12List}})
    end
end)

function getItemPrice(index)
    return (forexDatas[index].price or 1000)
end