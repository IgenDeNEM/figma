local weatherTimer = nil
local currentWeather = 2

function sendWeather(player, weatherData)
    local rt = getRealTime()
    local h, m, s = rt.hour, rt.minute, rt.second
    if player then
        triggerClientEvent(player, "gotTimeChange", player, h, m, s, currentWeather)
    else
        if weatherData then
            triggerClientEvent(getRootElement(), "gotTimeChange", getRootElement(), weatherData.hour, weatherData.minute, weatherData.s, currentWeather)
        else
            triggerClientEvent(getRootElement(), "gotTimeChange", getRootElement(), h, m, s, currentWeather)
        end
    end
end
addEvent("requestWeather", true)
addEventHandler("requestWeather", getRootElement(), sendWeather)

addEventHandler("onResourceStart", resourceRoot, function()
    weatherTimer = setTimer(sendWeather, 10000, 0)
end)

addCommandHandler("settime", function(sourcePlayer, sourceCommand, timeData)
    if sourcePlayer and getElementData(sourcePlayer, "acc.adminLevel") >= 7 then
        if timeData and timeData ~= "*" and tonumber(timeData) then
            local weatherData = {
                hour = timeData,
                minute = 0,
                s = 0
            }
            sendWeather(false, weatherData)
            if isTimer(weatherTimer) then
                killTimer(weatherTimer)
            end
        elseif timeData == "*" then
            sendWeather()
            weatherTimer = setTimer(sendWeather, 10000, 0)
        else
            outputChatBox("[color=sightblue][SightMTA - Weather]: [color=hudwhite]/settime [* = Aktuális idő / Idó (Órában)]", sourcePlayer)
        end
    end
end)

addCommandHandler("setweather", function(sourcePlayer, sourceCommand, weatherId)
    if sourcePlayer and getElementData(sourcePlayer, "acc.adminLevel") >= 8 then
        local weatherId = tonumber(weatherId)
        if weatherId and weatherId > 0 and weatherId < 255 then
            setWeather(weatherId)
            local rt = getRealTime()
            local h, m, s = rt.hour, rt.minute, rt.second
            triggerClientEvent("gotTimeChange", sourcePlayer, h, m, s, weatherId)
            currentWeather = weatherId
        else
            outputChatBox("[color=sightblue][SightMTA - Weather]: [color=hudwhite]/setweather [Weather ID (0 - 255) alap: 2]", sourcePlayer)
            outputChatBox("[color=sightblue][SightMTA - Weather]:#ffffff https://wiki.multitheftauto.com/wiki/Weather", sourcePlayer)
        end
    end
end)