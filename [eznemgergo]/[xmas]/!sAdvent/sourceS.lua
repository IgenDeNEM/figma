addEvent("gotAdventKalendarItem", true)
addEventHandler("gotAdventKalendarItem", root, 
    function(kalendarIndex)
        if kalendarIndex then
            triggerClientEvent(client, "gotAdventKalendarGiven", client, kalendarIndex)
        end
    end
)