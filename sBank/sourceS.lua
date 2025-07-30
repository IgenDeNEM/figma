local connection = false

local dailyLimits = {}

local casettes = {}

function refreshCasettes()
    casettes = {}
    for playerIdentity, playerElement in pairs(getElementsByType("player")) do
        if exports.sItems:hasItem(playerElement, 361) then
            local playerDimension = getElementDimension(playerElement)
            local trackerState = false
            local casetteElement = playerElement
            if playerDimension == 0 then
                trackerState = true
                casetteElement = playerElement
            else
                trackerState = false
                casetteElement = "UNKNOWN"
            end

            local casettePosition = {getElementPosition(playerElement)}
            if playerDimension ~= 0 then
                if exports.sInteriors:isValidInterior(playerDimension) then
                    casettePosition = {exports.sInteriors:getInteriorOutsidePosition(getElementDimension(playerElement))}
                    casetteElement = "INTERIOR"
                end
            end

            casettes[playerElement] = {casettePosition[1], casettePosition[2], casettePosition[3], trackerState}
            triggerClientEvent(getRootElement(), "gotCasetteData", getRootElement(), playerElement, casettes[playerElement])
        else
            triggerClientEvent(getRootElement(), "gotCasetteData", getRootElement(), playerElement, nil)
        end
    end
end

addEvent("requestATMMoney", true)
addEventHandler("requestATMMoney", getRootElement(), function()
    if client == source then
        local charID = getElementData(client, "char.ID")

        if charID then
            triggerClientEvent(client, "refreshBankMoney", client, exports.sCore:getBankMoney(client) or -1)

            if not dailyLimits[charID] then
                dailyLimits[charID] = 1000000
            end
            
            triggerClientEvent(client, "refreshATMDailyLimit", client, dailyLimits[charID])
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #38 - sBank @sourceS:36")
    end
end)

addEvent("requestBankMoney", true)
addEventHandler("requestBankMoney", getRootElement(), function()
    if client == source then
        triggerClientEvent(client, "refreshBankMoney", client, exports.sCore:getBankMoney(client) or -1)
    else
        exports.sAnticheat:anticheatBan(client, "AC #39 - sBank @sourceS:45")        
    end
end)

addEvent("atmPayOut", true)
addEventHandler("atmPayOut", getRootElement(), function(atm, amount)
    if client == source then
        local charID = getElementData(client, "char.ID")

        if amount > 0 then
            if not atmDatas[atm].robbed then
                local isNPC = atmDatas[atm].skin
                if not dailyLimits[charID] then
                    dailyLimits[charID] = 1000000
                end
                if (dailyLimits[charID] >= amount) or isNPC then
                    local savedMoney = exports.sCore:getBankMoney(client)
                    savedMoney = math.floor(savedMoney)
                    if exports.sCore:takeBankMoney(client, amount) then
                        local tax = math.floor(amount * 0.0025)
                        exports.sCore:giveMoney(client, amount - tax)
                        if not isNPC then
                            dailyLimits[charID] = dailyLimits[charID] - amount
                        end

                        triggerClientEvent(client, "refreshATMDailyLimit", client, dailyLimits[charID])

                        exports.sGui:showInfobox(client, "s", "Sikeres pénzfelvétel!")
                        exports.sGui:showInfobox(client, "i", "Kezelési költség: " .. exports.sGui:thousandsStepper(tax) .. " $")
                        exports.sGui:showInfobox(client, "i", "Új egyenleg: " .. exports.sGui:thousandsStepper(exports.sCore:getBankMoney(client) or -1) .. " $")
                        
                        local embedDatas = {
                            username = "SightMTA - Bank [Pénz kivétel]",
                            title = "Egy játékos felvett pénzt az ATM-ből",
                            color = "sightred",
                        
                            embedData = {
                                embedFields = {
                                    {
                                        name = "Játékos neve - [Account ID]",
                                        value = "```"..getElementData(client, "visibleName"):gsub("_", " ").. " - ".. getElementData(client, "char.ID").."```",
                                        inline = true
                                    },
                                    {
                                        name = "Banki egyenlege (A levétel előtt)",
                                        value = "```"..exports.sGui:thousandsStepper((savedMoney or -1) .. " $").."```",
                                        inline = true
                                    },
                                    {
                                        name = "",
                                        value = "",
                                        inline = false
                                    },
                                    {
                                        name = "Levétel mennyisége",
                                        value = "```"..exports.sGui:thousandsStepper((amount or -1) .. " $").."```",
                                        inline = true
                                    },
                                    {
                                        name = "Levétel utáni mennyiség (Bank)",
                                        value = "```"..exports.sGui:thousandsStepper((savedMoney - amount or -1) .. " $").."```",
                                        inline = true
                                    },
                                },
                            },
                        }
                        exports.sAnticheat:sendEmbedMessage(embedDatas, "atm")
                        
                        triggerClientEvent(getRootElement(), "atmResponse", client, atm, true, false)
                    else
                        exports.sGui:showInfobox(client, "e", "Nincs elég egyenleged!")
                        triggerClientEvent(client, "atmResponse", client, atm, false, false)
                    end
                else
                    exports.sGui:showInfobox(client, "e", "Ez az összeg meghaladja a napi limited!")
                    triggerClientEvent(client, "atmResponse", client, atm, false, false)
                end
            else
                exports.sGui:showInfobox(client, "e", "Üzemképtelen ATM-ből nem vehetsz fel pénzt!")
                triggerClientEvent(client, "atmResponse", client, atm, false, false)
            end
        else
            exports.sAnticheat:anticheatBan(client, "AC #40 - sBank @sourceS:122")        
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #41 - sBank @sourceS:125")        
    end
end)

addEvent("atmPayIn", true)
addEventHandler("atmPayIn", getRootElement(), function(atm, amount)
    if client == source then
        if amount > 0 then
            if not atmDatas[atm].robbed then
                local savedMoney = exports.sCore:getBankMoney(client)
                local pMoney = exports.sCore:getMoney(client)
                if pMoney >= amount then
                    exports.sCore:takeMoney(client, amount)
                    local tax = math.floor(amount * 0.0025)
                    exports.sCore:giveBankMoney(client, amount - tax)

                    exports.sGui:showInfobox(client, "s", "Sikeres pénzbefizetés!")
                    exports.sGui:showInfobox(client, "i", "Kezelési költség: " .. exports.sGui:thousandsStepper(tax) .. " $")
                    exports.sGui:showInfobox(client, "i", "Új egyenleg: " .. exports.sGui:thousandsStepper(exports.sCore:getBankMoney(client) or -1) .. " $")
                    triggerClientEvent(getRootElement(), "atmResponse", client, atm, true, false)
               
                    local embedDatas = {
                        username = "SightMTA - Bank [Pénz kivétel]",
                        title = "Egy játékos letett pénzt az ATM-be",
                        color = "sightgreen",
                    
                        embedData = {
                            embedFields = {
                                {
                                    name = "Játékos neve - [Account ID]",
                                    value = "```"..getElementData(client, "visibleName"):gsub("_", " ").. " - ".. getElementData(client, "char.ID").."```",
                                    inline = true
                                },
                                {
                                    name = "Banki egyenlege (A befiz. előtt)",
                                    value = "```"..exports.sGui:thousandsStepper((savedMoney or -1) .. " $").."```",
                                    inline = true
                                },
                                {
                                    name = "",
                                    value = "",
                                    inline = false
                                },
                                {
                                    name = "Befizetés mennyisége",
                                    value = "```"..exports.sGui:thousandsStepper((amount or -1) .. " $").."```",
                                    inline = true
                                },
                                {
                                    name = "Befizetés utáni mennyiség (Bank)",
                                    value = "```"..exports.sGui:thousandsStepper((savedMoney - amount or -1) .. " $").."```",
                                    inline = true
                                },
                            },
                        },
                    }
                    exports.sAnticheat:sendEmbedMessage(embedDatas, "atm")
                else
                    exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
                    triggerClientEvent(client, "atmResponse", client, atm, false, false)
                end
            else
                exports.sGui:showInfobox(client, "e", "Üzemképtelen ATM-be nem fizethetsz be pénzt!")
                triggerClientEvent(client, "atmResponse", client, atm, false, false)
            end
        else
            exports.sAnticheat:anticheatBan(client, "AC #42 - sBank @sourceS:189")        
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #43 - sBank @sourceS:192")        
    end
end)

addEvent("atmTopUpPhone", true)
addEventHandler("atmTopUpPhone", getRootElement(), function(atm, phone, amount)
    if client == source then
        if amount > 0 then
            if not atmDatas[atm].robbed then
                dbQuery(function(qh, client, phone, amount)
                    local results = dbPoll(qh, 0)

                    if #results > 0 then
                        local result = results[1]
                        
                        if exports.sCore:takeBankMoney(client, amount) then
                            local foundPlayer = false
        
                            for k, v in pairs(getElementsByType("player")) do
                                local item = exports.sItems:playerHasItemWithData(v, 9, phone)
        
                                if item then
                                    foundPlayer = v
                                    foundItem = item
                                    break
                                end
                            end

                            local newBalance = (tonumber(foundItem.data3) or 0) + amount
        
                            if foundPlayer then
                                exports.sItems:updateItemData3(foundPlayer, foundItem.dbID, newBalance)
                            end

                            local timestamp = getRealTime().timestamp
                            local message = {
                                sender = 131,
                                recipient = recipientNumber,
                                timestamp = timestamp,
                                msgType = 1,
                                id = 1,
                                state = 1,
                                text = "Sikeres egyenlegfeltöltés (".. exports.sGui:thousandsStepper(amount) .. " $)! Az ön elérhető egyenlege a " .. exports.sMobile:formatPhoneNumber(phone) .. " telefonszámon: " .. exports.sGui:thousandsStepper(newBalance) .. " $ Sight - COM"
                            }
            
                            if not getElementData(foundPlayer, "smsInbox") then
                                setElementData(foundPlayer, "smsInbox", {})
                            end
                            local inbox = getElementData(foundPlayer, "smsInbox")
                            table.insert(inbox, message)
                            setElementData(foundPlayer, "smsInbox", inbox)
                            cacheEntry = { 131, timestamp, 1, message.text }
                    
                            triggerClientEvent(foundPlayer, "gotSMSCache", foundPlayer, { cacheEntry }, true, true, true)

                            dbExec(connection, "UPDATE items SET data3 = ? WHERE data1 = ? AND itemId = ?", tostring(newBalance), tostring(phone), 9)
        
                            exports.sGui:showInfobox(client, "s", "Sikeresen feltöltötted a megadott telefon egyenlegét!")
                            exports.sGui:showInfobox(client, "i", "Új egyenleg: " .. exports.sGui:thousandsStepper(exports.sCore:getBankMoney(client) or -1) .. " $")
                            triggerClientEvent(client, "atmResponse", client, atm, true, true)
                        else
                            exports.sGui:showInfobox(client, "e", "Nincs elég pénzed!")
                            triggerClientEvent(client, "atmResponse", client, atm, false, false)
                        end
                    else
                        exports.sGui:showInfobox(client, "e", "Hibás telefonszám!")
                        triggerClientEvent(client, "atmResponse", client, atm, false, false)
                    end
                end, {client, phone, amount}, connection, "SELECT * FROM items WHERE data1 = ? AND itemId = ?", tostring(phone), 9)
            else
                exports.sGui:showInfobox(client, "e", "Üzemképtelen ATM-be nem fizethetsz be pénzt!")
                triggerClientEvent(client, "atmResponse", client, atm, false, false)
            end
        else
            exports.sAnticheat:anticheatBan(client, "AC #44 - sBank @sourceS:266")        
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #45 - sBank @sourceS:269")        
    end
end)

addEvent("tryToRobATM", true)
addEventHandler("tryToRobATM", getRootElement(), function(atm)
    if client == source then
        if exports.sGroups:getPlayerPermission(client, "atmRob") then
            if not atmDatas[atm].protected then
                if not atmDatas[atm].robbing then
                    atmDatas[atm].robbing = client
                    setPedAnimation(client, "CAMERA", "camcrch_idleloop", -1, true, false, false)
                    triggerClientEvent(client, "startATMRob", client, atm)
                    triggerClientEvent(client, "gotATMRobData", client, {[atm] = {true, false}})
                    local group = false
                    local groups = exports.sGroups:getPlayerGroups(client)
                    for k, v in pairs(groups) do
                        group = exports.sGroups:getGroupName(v.groupPrefix)
                    end

                    triggerClientEvent(getRootElement(), "refreshATMRobStarted", getRootElement(), atm, true, group)

                    exports.sClothesshop:processPlayerWeaponItems(exports.sItems:getElementItems(client), client, true)
                end
            else
                exports.sGui:showInfobox(client, "e", "Ez az ATM védett!")
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #46 - sBank @sourceS:291")        
    end
end)

atmResetTimers = {}

addEvent("atmRobStart", true)
addEventHandler("atmRobStart", getRootElement(), function(atm)
    if client == source then
        if atmDatas[atm].robbing == client then
            atmDatas[atm].robStarted = true
            local groups = exports.sGroups:getPlayerGroups(client)
            local group = false
            for k, v in pairs(groups) do
                group = exports.sGroups:getGroupName(v.groupPrefix)
            end
            triggerClientEvent(getRootElement(), "refreshATMRobStarted", getRootElement(), atm, true, group)
            triggerClientEvent(getRootElement(), "atmRobState", client, true)
            setPedAnimation(client, "CAMERA", "camcrch_idleloop", -1, true, false, false)

            if isTimer(atmResetTimers[atm]) then
                killTimer(atmResetTimers[atm])
            end

            atmResetTimers[atm] = setTimer(function(atm)
                atmDatas[atm].robbed = false
                atmDatas[atm].robStarted = false
                triggerClientEvent(getRootElement(), "refreshATMRobStarted", getRootElement(), atm, false, false)
                triggerClientEvent(getRootElement(), "refreshATMRobbed", getRootElement(), atm, false, false)
            end, ((1000 * 60) * 60) * 2, 1, atm)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #47 - sBank @sourceS:304")        
    end
end)

addEvent("syncAtmCutSound", true)
addEventHandler("syncAtmCutSound", getRootElement(), function(state)
    if client == source then
        for atm, dat in pairs(atmDatas) do
            if dat.robbing == client then
                triggerClientEvent(getRootElement(), "syncAtmCutSound", client, atm, state)

                break
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #48 - sBank @sourceS:319")        
    end
end)

addEvent("endATMRobbing", true)
addEventHandler("endATMRobbing", getRootElement(), function()
    if client == source then
        for atm, dat in pairs(atmDatas) do
            if dat.robbing == client then
                atmDatas[atm].robbing = false
                triggerClientEvent(getRootElement(), "atmRobState", client, false)
                triggerClientEvent(getRootElement(), "syncAtmCutSound", client, false)
                exports.sClothesshop:storePlayerClothes(client)
                setPedAnimation(client)
                break
            end
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #49 - sBank @sourceS:335")        
    end
end)

addEvent("atmDoorCut", true)
addEventHandler("atmDoorCut", getRootElement(), function(atm)
    if client == source then
        if atmDatas[atm].robbing == client then
            atmDatas[atm].robbing = false
            atmDatas[atm].robbed = {false, false, false, false, false}
            setPedAnimation(client)

            triggerClientEvent("refreshATMRobbed", client, atm, atmDatas[atm].robbed)
            triggerClientEvent("atmRobState", client, false)
            triggerClientEvent(getRootElement(), "syncAtmCutSound", client, false)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #50 - sBank @sourceS:350")        
    end
end)

addEvent("takeOutBoxFromATM", true)
addEventHandler("takeOutBoxFromATM", getRootElement(), function(atm, casette)
    if client == source then
        if atmDatas[atm].robbed and not atmDatas[atm].robbed[casette] then
            atmDatas[atm].robbed[casette] = true
            triggerClientEvent(getRootElement(), "refreshATMRobbed", getRootElement(), atm, atmDatas[atm].robbed, casette)
            exports.sItems:giveItem(client, 361, 1)
        end
    else
        exports.sAnticheat:anticheatBan(client, "AC #51 - sBank @sourceS:363")        
    end
end)

addEvent("requestATMRobData", true)
addEventHandler("requestATMRobData", getRootElement(), function()
    local tempTable = {}
    for atmIdentity, atmData in pairs(atmDatas) do
        tempTable[atmIdentity] = {atmData.robStarted or false, atmData.robbed}
        if tempTable[atmIdentity][1] then
        end
    end

    triggerClientEvent(client, "gotATMRobData", client, tempTable)
end)

addEvent("requestATMCasetteData", true)
addEventHandler("requestATMCasetteData", getRootElement(), function()
    for player, dat in pairs(casettes) do
        triggerClientEvent(client, "gotCasetteData", getRootElement(), player, dat)
    end
end)

addEventHandler("onResourceStart", getRootElement(), function(res)
    if res == getThisResource() then
        connection = exports.sConnection:getConnection()
        setTimer(refreshCasettes, 1000, 0)
    else
        local resName = getResourceName(res)

        if resName == "sConnection" then
            connection = exports.sConnection:getConnection()
        end
    end
end)

addCommandHandler("pay", function(sourcePlayer, commandName, targetPlayer, payedAmount)
    if not payedAmount or not tonumber(payedAmount) or not targetPlayer then
        outputChatBox("[color=sightblue][SightMTA - Használat]: [color=hudwhite]/pay [Név / ID] [Összeg]", sourcePlayer)
        return
    end

    local targetPlayer, targetName = exports.sCore:findPlayer(sourcePlayer, targetPlayer)
    local givenPrice = tonumber(payedAmount)
    local targetPosition = {getElementPosition(targetPlayer)}
    local sourcePosition = {getElementPosition(sourcePlayer)}
    local playerDistance = getDistanceBetweenPoints3D(targetPosition[1], targetPosition[2], targetPosition[3], sourcePosition[1], sourcePosition[2], sourcePosition[3])
    
    if targetPlayer == sourcePlayer then
        outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Magadnak nem tudsz átadni pénzt!", sourcePlayer)
        return
    end

    if givenPrice % 1 ~= 0 then
        outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Csak egész számokat lehet átadni!", sourcePlayer)
        return
    end

    if playerDistance > 3 then
        outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]A kiválasztott játékos túl messze van!", sourcePlayer)
        return
    end

    if givenPrice < 0 then
        outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Az összeg nem lehet negatív!", sourcePlayer)
        return
    end

    local targetMoney = exports.sCore:getMoney(targetPlayer)
    local sourceMoney = exports.sCore:getMoney(sourcePlayer)

    if exports.sCore:getMoney(sourcePlayer) >= givenPrice and givenPrice > 0 then
        local interestRate = 0.95
        local tax = math.floor(givenPrice - givenPrice * 0.95)
        exports.sCore:takeMoney(sourcePlayer, givenPrice)
        outputChatBox("[color=sightgreen][SightMTA]: [color=hudwhite]Adtál [color=sightblue]"..getElementData(targetPlayer, "visibleName"):gsub("_", " ").." [color=hudwhite]játékosnak [color=sightgreen]".. givenPrice - tax .." [color=hudwhite]dollárt. (Adó: [color=sightred]".. math.floor(givenPrice - givenPrice * 0.95) .." $[color=hudwhite])", sourcePlayer)
        outputChatBox("[color=sightgreen][SightMTA]: [color=sightblue]"..getElementData(sourcePlayer, "visibleName"):gsub("_", " ").." [color=hudwhite]adott neked [color=sightgreen]".. givenPrice - tax.." [color=hudwhite]dollárt. (Adó: [color=sightred]".. math.floor(givenPrice - givenPrice * 0.95) .." $[color=hudwhite])", targetPlayer)

        local embedDatas = {
            username = "SightMTA - Bank [Pénz átadás]",
            title = "Egy játékos pénzt fizetett egy másik játékosnak!",
            color = "sightred",
        
            embedData = {
                embedFields = {
                    {
                        name = "Játékos neve - [Account ID]",
                        value = "```"..getElementData(sourcePlayer, "visibleName"):gsub("_", " ").. " - ".. getElementData(sourcePlayer, "char.ID").."```",
                        inline = true
                    },
                    {
                        name = "Egyenlege",
                        value = "```"..exports.sGui:thousandsStepper((sourceMoney or -1) .. " $").."```",
                        inline = true
                    },
                    {
                        name = "",
                        value = "",
                        inline = false
                    },
                    {
                        name = "Játékos neve - [Account ID]",
                        value = "```"..getElementData(targetPlayer, "visibleName"):gsub("_", " ").. " - ".. getElementData(targetPlayer, "char.ID") .."```",
                        inline = true
                    },
                    {
                        name = "Egyenlege",
                        value = "```"..exports.sGui:thousandsStepper((targetMoney or -1) .. " $").."```",
                        inline = true
                    },
                    {
                        name = "",
                        value = "",
                        inline = false
                    },
                    {
                        name = "Átadott pénz mennyisége - Adó",
                        value = "```"..exports.sGui:thousandsStepper((givenPrice or -1) .. " $").." - ".. exports.sGui:thousandsStepper(math.floor(givenPrice - givenPrice * 0.95)) .."```",
                        inline = true
                    },
                },
            },
        }
        exports.sAnticheat:sendEmbedMessage(embedDatas, "atm")
        exports.sCore:giveMoney(targetPlayer, math.floor(givenPrice - tax))

        givenPrice = givenPrice * math.floor(interestRate)
    else    
        outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Nincs nálad ennyi pénz!", sourcePlayer)
    end
end)

function getATMPosition(atmId)
    if atmDatas[atmId] then
        return atmDatas[atmId].pos
    end
    return false
end