addEvent("enableRestreamForPlayer", true)
addEventHandler("enableRestreamForPlayer", root, 
    function (streamingState)
        triggerClientEvent(client, "setRestreamingEnabled", client, streamingState)
    end
)