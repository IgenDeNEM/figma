local playersTrailer = {}
local destroyTimer = {}

addEvent("canRentTrailer", true)
addEventHandler("canRentTrailer", getRootElement(),
    function()  
        triggerClientEvent(client, "canRentTrailer", client, true, playersTrailer[client])        
    end
)

addEvent("requestTrailerRental", true)
addEventHandler("requestTrailerRental", getRootElement(),
    function(carTrailer)
        if playersTrailer[client] then
            if isElement(playersTrailer[client]) then
                destroyElement(playersTrailer[client])
            end
            
            playersTrailer[client] = nil
        else
            local model = 611

            if carTrailer then
                model = 608
            end

            playersTrailer[client] = createVehicle(model, 2393.0881347656, -2095.5947265625, 13.553783416748) 
            setVehicleVariant(playersTrailer[client], 0, 255)

            local plateText = "TR - " .. math.random(100, 999)

            setVehiclePlateText(playersTrailer[client], plateText)

            startDestroyTimer(playersTrailer[client], client, true)

            local pj = math.random(1, 3)

            setElementData(playersTrailer[client], "vehicle.currentTexture", pj)
            setElementData(playersTrailer[client], "paintjob", pj)
            setElementData(playersTrailer[client], "vehicle.fuel", 0)

            exports.sGui:showInfobox(client, "s", "Sikeres bérlés! Kapott utánfutód rendszáma: ".. plateText ..". Bérleted lejár 15 perc múlva.")
        end
    end
)

addEventHandler("onTrailerDetach", getRootElement(), 
    function(truck)
        local client = getVehicleController(truck)
        startDestroyTimer(source, client)
    end
)

addEventHandler("onPlayerVehicleExit", getRootElement(), 
    function(vehicle)
        local trailer = getVehicleTowedByVehicle(vehicle)
        local client = source

        if trailer then
            startDestroyTimer(trailer, client)
        end
    end
)

addEventHandler("onVehicleEnter", getRootElement(), 
    function(player)
        local trailer = getVehicleTowedByVehicle(source)
        local client = player

        if trailer then
            stopDestroyTimer(trailer, client)
        end
    end
)

fiveMinuteTimers = {}
minuteTimers = {}

function startDestroyTimer(trailer, client, withoutNotify)
    if isTimer(destroyTimer[trailer]) then
        return
    end
    if not withoutNotify then
        if isElement(client) then
            exports.sGui:showInfobox(client, "i", "Az utánfutó bérleted lejár 15 perc múlva!")
        end
    end
    destroyTimer[trailer] = setTimer(function(trailer, client)
        if isElement(trailer) then
            destroyElement(trailer)
            playersTrailer[client] = nil
            if isElement(client) then
                exports.sGui:showInfobox(client, "e", "Az utánfutó bérleted lejárt!")
            end
        end
    end, 1000 * 60 * 15, 1, trailer, client)

    fiveMinuteTimers[trailer] = setTimer(function(trailer, client)
        if isElement(trailer) then
            if isElement(client) then
                exports.sGui:showInfobox(client, "w", "Az utánfutó bérleted lejár 5 perc múlva!")
            end
        end
    end, 1000 * 60 * 10, 1, trailer, client)

    minuteTimers[trailer] = setTimer(function(trailer, client)
        if isElement(trailer) then
            if isElement(client) then
                exports.sGui:showInfobox(client, "w", "Az utánfutó bérleted lejár 1 perc múlva!")
            end
        end
    end, 1000 * 60 * 14, 1, trailer, client)
end

function stopDestroyTimer(trailer, client)
    if destroyTimer[trailer] then
        if isTimer(destroyTimer[trailer]) then
            killTimer(destroyTimer[trailer])
        end
    end
    if minuteTimers[trailer] then
        if isTimer(minuteTimers[trailer]) then
            killTimer(minuteTimers[trailer])
        end
    end
    if fiveMinuteTimers[trailer] then
        if isTimer(fiveMinuteTimers[trailer]) then
            killTimer(fiveMinuteTimers[trailer])
        end
    end
end