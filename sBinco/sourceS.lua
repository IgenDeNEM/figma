addEvent("bincoExit", true)
addEventHandler("bincoExit", getRootElement(), function(currentBinco)
    setElementFrozen(client, false)

    if availableShops[currentBinco] then
        local x, y, z, int, dim = unpack(availableShops[currentBinco])
        setElementPosition(client, x, y, z)
        setElementInterior(client, int)
        setElementDimension(client, dim)
    end
end)

addEvent("bincoEnter", true)
addEventHandler("bincoEnter", getRootElement(), function(bincoEnter)
    setElementFrozen(client, true)
    setElementPosition(client, 0, 0, 10000)
end)

addEvent("bincoBuySkin", true)
addEventHandler("bincoBuySkin", getRootElement(), function(skinId)
    if skinId then
        if skinId == getElementModel(client) then
            exports.sGui:showInfobox(client, "e", "Ez a jelenlegi skined!")
        else
            local money = exports.sCore:getMoney(client)
            if money >= 250 then
                if type(skinId) == "table" then
                    setElementData(client, "permGroupSkin", skinId[1] .. skinId[2])
                else
                    setElementData(client, "permGroupSkin", "N")
                    setElementModel(client, skinId)
                    setElementData(client, "char.skin", skinId)

                end
                exports.sGui:showInfobox(client, "s", "Sikeres vásárlás!")
                exports.sCore:takeMoney(client, 250)
            else
                exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
            end
        end
    end
end)

addEvent("requestGroupsForBinco", true)
addEventHandler("requestGroupsForBinco", getRootElement(),
	function()
		triggerClientEvent(client, "gotGroupSkinsForBinco", client, false)
		local skins = exports.sGroups:getPlayerGroupSkins(client)
        if #skins == 0 then
            skins = false
        end
		triggerClientEvent(client, "gotGroupSkinsForBinco", client, skins)
	end
)