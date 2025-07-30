addEvent("addCarBlip", true)
addEventHandler("addCarBlip", root, 
    function ()
        triggerClientEvent("getCarBlip", source)
    end
)