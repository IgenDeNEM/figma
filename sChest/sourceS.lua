openTimers = {}

addEvent("tryToStartTreasureOpening", true)
function tryToStartTreasureOpening(itemId, dbID)
    if isTimer(openTimers[client]) then
        return
    end
    exports.sItems:takeItem(client, "dbID", dbID)
    realItem = chooseRandomItem(itemId)
    triggerClientEvent(client, "createChestMinigame", client, itemId, 50, realItem)
    openTimers[client] = setTimer(function(player, realItem, itemId)
        exports.sItems:giveItem(player, realItem, 1, 1)
        
        if exports.sWeapons:getWeaponId(realItem) then
            local ser = exports.sItems:formatSerial(realItem, exports.sItems:getLastWeaponSerial())
            exports.sItems:giveItem(player, 583, 1, false, toJSON({
                item = realItem,
                serial = ser,
                buyer = string.gsub(getElementData(player, "char.name"), "_", " "),
                acc = getElementData(player, "char.accID"),
                price = exports.sItems:getItemName(itemId),
                ts = getRealTime().timestamp
            }, true))

            exports.sGui:showInfobox(player, "i", "A bizonylatod megtalálod az iratok között.")

            local itemName = exports.sItems:getItemName(realItem)
            outputChatBox("[color=sightblue][SightMTA - Ajándék]:[color=hudwhite] Kaptál[color=sightblue] 1 [color=hudwhite] darab [color=sightblue]" .. itemName .. "[color=hudwhite] itemet. [color=sightlightgrey][".. ser .."] [".. string.gsub(getElementData(player, "char.name"), "_", " ") .."]", player)
        end
    end, 30000, 1, client, realItem, itemId)
end
addEventHandler("tryToStartTreasureOpening", root, tryToStartTreasureOpening)
