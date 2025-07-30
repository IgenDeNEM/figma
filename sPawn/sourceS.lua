local timerTable = {}
local tempTable = {}
local pawnTimer = 4000 --1200000
local missingItems = {}

addEvent("tryToStartPawnDeal", true)
addEventHandler("tryToStartPawnDeal", getRootElement(),
	function(pawnType)
		if client then
			local charId = getElementData(client, "char.ID")

			if pawnType == "pawn" then
				if timerTable[charId] and getTickCount() - timerTable[charId] < pawnTimer then
					triggerClientEvent(client, "showInfobox", client, "error", "Gyere vissza később!")
				else
					triggerClientEvent(client, "openPawnItemSelector", client, "pawn")
					setElementData(client, "inPawnMenu", true)
				end
			elseif pawnType == "mine" then
				triggerClientEvent(client, "openPawnItemSelector", client, "mine")
				setElementData(client, "inPawnMenu", true)
			end
		end
	end
)

addEvent("tryToSellGoldBar", true)
addEventHandler("tryToSellGoldBar", getRootElement(),
	function()
		if client and getElementData(client, "carryingGold") then
			local charId = getElementData(client, "char.ID")

			if timerTable[charId] and getTickCount() - timerTable[charId] < pawnTimer then
				triggerClientEvent(client, "showInfobox", client, "error", "Gyere vissza később!")
			else
                maxPrice = 250000
                minPrice = 62500
                local randomText = math.random(12, 15)
		        local middleNum = ((maxPrice / 2) + (maxPrice * 2)) / 2
                tempTable[client] = {
					pedName = "Aranyrúd felvásárlás",
                    text = randomText,
                    playerReply = false,
                    playerPrice = middleNum,
                    pawnPrice = false,
                    minPrice = maxPrice / 2,
                    maxPrice = maxPrice * 2,
                    canMove = true,
                    state = 0,
                    items = {"gold", 1}
                }
                triggerClientEvent(client, "refreshPawnData", client, tempTable[client])
			end
		end
	end
)

addEvent("tryToSellMoneyStack", true)
addEventHandler("tryToSellMoneyStack", getRootElement(),
	function (ped, dbID)
		if client then
			local charId = getElementData(client, "char.ID")

			if timerTable[charId] and getTickCount() - timerTable[charId] < pawnTimer then
				triggerClientEvent(client, "showInfobox", client, "error", "Gyere vissza később!")
			else

				local maxPrice = exports.sItems:getItemData1(client, dbID)

                local randomText = 25
		        local middleNum = ((maxPrice / 2) + (maxPrice)) / 2
				tempTable[client] = {
                    pedName = "A Valutás",
                    text = randomText,
                    playerReply = false,
                    playerPrice = middleNum,
                    pawnPrice = false,
                    minPrice = maxPrice / 2,
                    maxPrice = maxPrice,
                    canMove = true,
                    state = 0,
                    items = {"moneyStack", 1, dbID},
                }
                triggerClientEvent(client, "refreshPawnData", client, tempTable[client])
			end
		end
	end
)

addEvent("pawnAcceptOffer", true)
addEventHandler("pawnAcceptOffer", getRootElement(),
    function()
        if client then
            if tempTable[client] then
                tempTable[client].playerReply = 5
                tempTable[client].canMove = false
                tempTable[client].thinking = true
                tempTable[client].pawnLastPrice = 1
                tempTable[client].fixedPlayerPrice = tempTable[client].pawnPrice
                tempTable[client].playerPrice = tempTable[client].pawnPrice

                triggerClientEvent(client, "refreshPawnData", client, tempTable[client])
                setTimer(function(player)
                    if not tempTable[player] then return end

					local itemsTable = false
					if tempTable[player].items[1] == "gold" then
						itemsTable = "gold"
					elseif tempTable[player].items[1] == "moneyStack" then
						itemsTable = "moneyStack"
					else
						itemsTable = tempTable[player].items
					end

                    local allItemsPresent = true

					if itemsTable and type(itemsTable) == "table" then
						local itemDBID, itemId, itemCount = exports.sItems:checkPawnItems(player, itemsTable)
						if not itemDBID then
							exports.sGui:showInfobox(player, "e", "Hiányzó tárgy: "..(itemCount or "N/A").." darab " ..exports.sItems:getItemName(itemId))

							allItemsPresent = false
						end

						if not allItemsPresent then
							triggerClientEvent(player, "refreshPawnData", player, false)
							tempTable[player] = nil

							return
						end
					elseif itemsTable == "gold" then
						if not getElementData(player, "carryingGold") then
							triggerClientEvent(player, "refreshPawnData", player, false)
							tempTable[player] = nil
							return
						end
					elseif itemsTable == "moneyStack" then
						if not exports.sItems:getItemSlotID(player, tempTable[player].items[3]) then
							tempTable[player] = nil
							triggerClientEvent(player, "refreshPawnData", player, false)
							return
						end
					end

                    tempTable[player].playerReply = false
                    tempTable[player].text = 10
                    triggerClientEvent(player, "refreshPawnData", player, tempTable[player])

                    setTimer(function(player)
                        if not tempTable[player] then return end
						

                        triggerClientEvent(player, "refreshPawnData", player, false)

						local money = exports.sCore:getMoney(player)
						exports.sCore:setMoney(player, money + tempTable[player].fixedPlayerPrice, false)

						if itemsTable and type(itemsTable) == "table" then
                        	triggerEvent("takePawnItems", player, player, itemsTable)

							local itemCount = 0
							for k, v in pairs(itemsTable) do
								itemCount = itemCount + (v or 1)

								local itemName = exports.sItems:getItemName(k)
								exports.sChat:localAction(player, "eladott egy tárgyat: " .. v .. " darab " .. itemName .. ".")
							end

							triggerClientEvent(player, "showInfobox", player, "info", "Sikeresen eladtál " .. itemCount .. " darab tárgyat " .. thousandsStepper(tempTable[player].fixedPlayerPrice) .. " dollárért.")
						elseif itemsTable == "gold" then
							triggerEvent("goldrobTakeGold", player)
							triggerClientEvent(player, "showInfobox", player, "s", "Sikeresen eladtál egy aranyrudat " .. thousandsStepper(tempTable[player].fixedPlayerPrice) .. " dollárért.")
							exports.sChat:localAction(player, "eladott egy aranyrudat.")
						elseif itemsTable == "moneyStack" then
							if exports.sItems:getItemSlotID(player, tempTable[player].items[3]) then
								triggerClientEvent(player, "showInfobox", player, "s", "Sikeresen eladtál egy köteg pénzt " .. thousandsStepper(tempTable[player].fixedPlayerPrice) .. " dollárért.")
								exports.sChat:localAction(player, "eladott egy köteg pénzt.")
								exports.sItems:takeItem(player, "dbID", tempTable[player].items[3])
							end
						end

                        tempTable[player] = nil
                    end, 2000, 1, player)
                end, 2000, 1, client)
            end
        end
    end
)

addEvent("pawnEndTheDeal", true)
addEventHandler("pawnEndTheDeal", getRootElement(), 
	function()
		if client then
			local charId = getElementData(client, "char.ID")

			if charId then
				timerTable[charId] = getTickCount()
				setElementData(client, "inPawnMenu", false)
				triggerClientEvent(client, "refreshPawnData", client, false)
				tempTable[client] = nil
			end
		end
	end
)

addEvent("startItemSelling", true)
addEventHandler("startItemSelling", getRootElement(),
	function(itemSelectedAmount, sellType)
		if sellType == "pawn" then
			local maxPrice = 0
			tempTable[client] = {}

			for key, value in pairs(itemSelectedAmount) do
				maxPrice = pawnItems[key] * value + maxPrice
			end

			local middleNum = ((maxPrice / 2) + (maxPrice * 2)) / 2

			local randomText = math.random(1, 4)

			tempTable[client] = {
				pedName = false,
				text = randomText,
				playerReply = false,
				playerPrice = middleNum,
				pawnPrice = false,
				minPrice = maxPrice / 2,
				maxPrice = maxPrice * 2,
				canMove = true,
				state = 0,
				items = itemSelectedAmount
			}
			triggerClientEvent(client, "refreshPawnData", client, tempTable[client])
		elseif sellType == "mine" then
			local maxPrice = 0
			tempTable[client] = {}

			for key, value in pairs(itemSelectedAmount) do
				maxPrice = exports.sTrading:getItemPrice(mineItemNames[key]) * value + maxPrice
			end

			local middleNum = ((maxPrice / 2) + (maxPrice * 2)) / 2

			local randomText = math.random(1, 4)

			tempTable[client] = {
				pedName = false,
				text = randomText,
				playerReply = false,
				playerPrice = middleNum,
				pawnPrice = false,
				minPrice = maxPrice / 2,
				maxPrice = maxPrice * 2,
				canMove = true,
				state = 0,
				items = itemSelectedAmount
			}
			triggerClientEvent(client, "refreshPawnData", client, tempTable[client])
		end
	end
)

addEvent("pawnOfferNewPrice", true)
addEventHandler("pawnOfferNewPrice", getRootElement(),
	function(price)
		if tempTable[client] then
			local playerReply = tempTable[client].playerReply
			local playerPrice = tempTable[client].playerPrice
			local pawnPrice = tempTable[client].pawnPrice
			local text = tempTable[client].text
			if tempTable[player] and tempTable[player].pawnLastPrice and tempTable[player].pawnLastPrice ~= price then
				tempTable[client].state = tempTable[client].state + 1
			end
			if tempTable[client].state < 4 then
				tempTable[client].playerPrice = price
				tempTable[client].fixedPlayerPrice = price
				tempTable[client].playerReply = math.random(1, 4)
				tempTable[client].canMove = false
				tempTable[client].thinking = true

				setTimer(function(player)
					tempTable[player].playerReply = false
					tempTable[player].thinking = false
					if tempTable[player].pawnLastPrice == price then
						tempTable[player].text = 12
						tempTable[player].canMove = true
						tempTable[player].pawnLastPrice = price
						tempTable[player].state = 1
						triggerClientEvent(player, "refreshPawnData", player, tempTable[player])
						return
					end
					
					if tempTable[player].state < 3 then
						tempTable[player].text = math.random(4, 6)
						tempTable[player].canMove = true
						tempTable[player].pawnPrice = math.random(pawnPrice or tempTable[player].minPrice, price)
						tempTable[player].pawnLastPrice = price
					else
						if price == playerPrice then
							tempTable[player].state = 1
							tempTable[player].canMove = true
							tempTable[player].text = math.random(11, 12)
						else
							tempTable[player].text = math.random(7, 9)
							tempTable[player].canMove = false
							tempTable[player].pawnPrice = math.random(pawnPrice or tempTable[player].pawnPrice, price)
							tempTable[player].pawnLastPrice = price
						end
					end

					triggerClientEvent(player, "refreshPawnData", player, tempTable[player])
				end, 2000, 1, client)
			else

			end

			triggerClientEvent(client, "refreshPawnData", client, tempTable[client])
		end
	end
)

function thousandsStepper(amount)
  	local formatted = amount
  	
  	while true do
    	formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1 %2")
    	if k == 0 then
      		break
    	end
  	end
  	
  	return formatted
end