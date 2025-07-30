local connection = exports.sConnection:getConnection()
local interiorSelling = {}

addEvent("tryToSellInterior", true)
addEventHandler("tryToSellInterior", root, 
    function(interiorIdentity, targetElement, interiorPrice)
        interiorSelling[client] = {
            "seller",
            false,
            getElementData(client, "char.name"):gsub("_", " "),
            getElementData(targetElement, "char.name"):gsub("_", " "),
            interiorList[interiorIdentity].name,
            interiorIdentity,
            getInteriorTypeName(interiorList[interiorIdentity].type, true),
            interiorPrice,
            getRealTime().timestamp,
            math.ceil(interiorPrice * 0.025),
            false,
            targetElement
        }

        interiorSelling[targetElement] = {
            "buyer",
            false,
            getElementData(client, "char.name"):gsub("_", " "),
            getElementData(targetElement, "char.name"):gsub("_", " "),
            interiorList[interiorIdentity].name,
            interiorIdentity,
            getInteriorTypeName(interiorList[interiorIdentity].type, true),
            interiorPrice,
            getRealTime().timestamp,
            math.ceil(interiorPrice * 0.025),
            false,
            client
        }

        setTimer(function(targetElement, table, seller)
            exports.sGui:showInfobox(targetElement, "i", "Ingatlan eladási ajánlatot kaptál! Nyomj [E] gombot az adásvételi megtekintéséhez")
            exports.sGui:showInfobox(targetElement, "w", "Figyelem 5 perced van reagálni az ajánlatra")

            triggerClientEvent(seller, "inteirorSellAcceptResponse", seller, true)
            triggerClientEvent(seller, "closeIntiSlotBuy", seller)
            triggerClientEvent(seller, "gotInteriorSellPaper", seller, false)

            local function openIntiBuy()
                triggerClientEvent(targetElement, "gotInteriorSellPaper", targetElement, table)
            end

            bindKey(targetElement, "e", "down", openIntiBuy)

            setTimer(function(seller, buyer)
                if interiorSelling[seller] then
                    interiorSelling[seller] = nil
                end
                if interiorSelling[selbuyerler] then
                    interiorSelling[buyer] = nil
                end

                unbindKey(targetElement, "e", "down", openIntiBuy)
            end, 300000, 1, client, targetElement)
        
        end, 3580, 1, targetElement, interiorSelling[targetElement], client)
    end
)

function findPlayerInteriors(player)
    local totalInteriors = 0
    local charID = getElementData(player, "char.ID")
    for k, v in pairs(interiorList) do
        if v.owner == charID then
            totalInteriors = totalInteriors + 1
        end
    end
    return totalInteriors
end

addEvent("intiSellResponse", true)
addEventHandler("intiSellResponse", root, 
    function(isAccepted)
        if interiorSelling[client] then
            local sellingData = interiorSelling[client]

            if isAccepted then
                local clientMoney = exports.sCore:getMoney(client)
                local sellerMoney = exports.sCore:getMoney(sellingData[12])
                local selectedInterior = sellingData[6]
                if getElementData(client, "char.interiorsSlot") > findPlayerInteriors(client) then
                    if clientMoney >= sellingData[8] then
                        exports.sCore:setMoney(sellingData[12], sellerMoney + (sellingData[8] - sellingData[10]))
                        exports.sCore:setMoney(client, clientMoney - sellingData[8])

                        exports.sGui:showInfobox(sellingData[12], "s", "Sikeresen eladtad az interiorod! Ár: " .. exports.sGui:thousandsStepper(sellingData[8]) .. "$, adó: " .. exports.sGui:thousandsStepper(sellingData[10]))
                        exports.sGui:showInfobox(sellingData[12], "i", "Ne felejtsd el a kulcsokat átadni a vevőnek!")

                        triggerClientEvent(client, "inteirorSellAcceptResponse", client, true)

                        interiorList[selectedInterior].owner = getElementData(client, "char.ID")
                        triggerLatentClientEvent("gotInteriorList", client, interiorList)

                        unbindKey(client, "e", "down", openIntiBuy)

                        dbExec(connection, "UPDATE interiors SET owner = ? WHERE interiorId = ?", getElementData(client, "char.ID"), selectedInterior)

                        outputChatBox("[color=sightgreen][SightMTA - Interior]: [color=hudwhite]Sikeresen eladtál egy interiort!", sellingData[12], 255, 255, 255, true)
                        outputChatBox("[color=sightgreen][SightMTA - Interior]: [color=hudwhite]Ingatlan neve: [color=sightgreen]" .. sellingData[5], sellingData[12], 255, 255, 255, true)
                        outputChatBox("[color=sightgreen][SightMTA - Interior]: [color=hudwhite]Ár: [color=sightgreen]" .. exports.sGui:thousandsStepper(sellingData[8]) .. "$", sellingData[12], 255, 255, 255, true)
                        outputChatBox("[color=sightgreen][SightMTA - Interior]: [color=hudwhite]Adó: [color=sightred]" .. exports.sGui:thousandsStepper(sellingData[10]) .. "$", sellingData[12], 255, 255, 255, true)
                    else
                        exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
                        triggerClientEvent(client, "inteirorSellAcceptResponse", client, false)
                    end
                else
                    exports.sGui:showInfobox(client, "e", "Nincs elég slotod!")
                    triggerClientEvent(client, "inteirorSellAcceptResponse", client, false)
                end
            else
                triggerClientEvent(clientTable[12], "gotInteriorSellPaper", clientTable[12], false)
                exports.sGui:showInfobox(clientTable[12], "e", "Elutasították az adásvételt!")
                interiorSelling[sellingData[12]] = false
                interiorSelling[client] = false
            end
        end
    end
)
