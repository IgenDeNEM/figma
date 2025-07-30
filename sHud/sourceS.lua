addEvent("requestMoney", true)
addEventHandler("requestMoney", getRootElement(), function()
    triggerClientEvent(client, "refreshMoney", client, exports.sCore:getMoney(client), true)
end)

addEvent("requestSSC", true)
addEventHandler("requestSSC", getRootElement(), function()
    triggerClientEvent(client, "refreshSSC", client, 0)
end)

addEvent("requestPremiumData", true)
addEventHandler("requestPremiumData", getRootElement(), function()
    triggerClientEvent(client, "gotPremiumData", client, exports.sCore:getPP(client))
end)

addEvent("syncTiredAnim", true)
addEventHandler("syncTiredAnim", getRootElement(), function(state)
    if state then
        setPedAnimation(client, "ped", "idle_tired", -1, true, false, true)
    else
        setPedAnimation(client)
    end
end)