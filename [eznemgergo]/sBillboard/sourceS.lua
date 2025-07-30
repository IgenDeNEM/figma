local billboardTimers = {}

function syncBillboard(sourceElement)
    for i = 1, 15 do
        local selectedBillboard = math.random(1, #billboards)
        local selectedTexture = math.random(1, billbNum)

        triggerClientEvent(sourceElement, "syncBillboard", sourceElement, selectedBillboard, selectedTexture)
    end
end

addEvent("requestBillboards", true)
addEventHandler("requestBillboards", getRootElement(), 
    function()
        billboardTimers[client] = setTimer(syncBillboard, 600000, 0, client)
    end
)

addEventHandler("onPlayerQuit", getRootElement(),
    function()
        if isTimer(billboardTimers[source]) then
            killTimer(billboardTimers[source])
        end
    end
)