addEvent("buyPremiumItem", true)
addEventHandler("buyPremiumItem", getRootElement(), function(menuTab, selectedItem, amount)
    if client then
        local itemId, price, itemData1 = unpack(menus[menuTab].items[selectedItem])
        amount = tonumber(amount) or 1

        if tonumber(itemId) then
            if exports.sItems:getCurrentWeight(client) + exports.sItems:getItemWeight(itemId) * amount > exports.sItems:getWeightLimit("player", client) then
                exports.sGui:showInfobox(client, "e", "Nincs elég helyed!")
            else
                if exports.sCore:getPP(client) < price * amount then
                    exports.sGui:showInfobox(client, "e", "Nincs elég prémiumpontod!")
                    return
                end

                if exports.sCore:takePP(client, price * amount) then
                    local giveItem = exports.sItems:giveItem(client, itemId, amount, false, itemData1 or false)
                    exports.sGui:showInfobox(client, "s", "Sikeres vásárlás!")

                    if exports.sWeapons:getWeaponId(itemId) then
                        exports.sItems:giveItem(client, 583, 1, false, toJSON({
                            item = itemId,
                            serial = exports.sItems:formatSerial(itemId, exports.sItems:getLastWeaponSerial()),
                            buyer = string.gsub(getElementData(client, "char.name"), "_", " "),
                            acc = getElementData(client, "char.accID"),
                            price = price,
                            ts = getRealTime().timestamp
                        }, true))

                        exports.sGui:showInfobox(client, "i", "A vásárlásról szóló bizonylatot megtalálod az iratok között.")
                        exports.sAnticheat:sendWebhookMessage("**"..string.gsub(getElementData(client, "char.name"), "_", " ").. "** Vásárolt egy fegyvert a premiumshopból! **[ItemID: "..itemId.." | SERIAL: "..exports.sItems:formatSerial(itemId, exports.sItems:getLastWeaponSerial()).."]**", "premiumshop")
                    else
                        exports.sAnticheat:sendWebhookMessage("**"..string.gsub(getElementData(client, "char.name"), "_", " ").. "** Vásárolt egy tárgyat a prémiumshopból! **[Amount: "..amount.." | ItemID: "..itemId.."]**", "premiumshop")
                    end
                end
            end
        elseif itemId == "money" then
            if exports.sCore:getPP(client) < price * amount then
                exports.sGui:showInfobox(client, "e", "Nincs elég prémiumpontod!")
                return
            end


            if exports.sCore:takePP(client, price) then
                exports.sCore:giveMoney(client, amount)

                exports.sGui:showInfobox(client, "s", "Sikeres vásárlás!")
            end
        end
    end
end)