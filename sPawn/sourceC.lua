local sightexports = {
	sModloader = false,
	sGui = false,
	sItems = false,
	sTrading = false
}
local function sightlangProcessExports()
	for k in pairs(sightexports) do
		local res = getResourceFromName(k)
		if res and getResourceState(res) == "running" then
			sightexports[k] = exports[k]
		else
			sightexports[k] = false
		end
	end
end
sightlangProcessExports()
if triggerServerEvent then
	addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
	addEventHandler("onResourceStart", getRootElement(), sightlangProcessExports, true, "high+9999999999")
end
local sightlangModloaderLoaded = function()
	sightexports.sTrading:setForexSubscription("all", "pawn")
	loadModelIds()
	refreshPrices()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local objs = {}
function loadModelIds()
	local sight_pawnshop_alpha = sightexports.sModloader:getModelId("v4_pawnshop_alpha")
	local sight_pawnshop_door = sightexports.sModloader:getModelId("v4_pawnshop_door")
	if sight_pawnshop_alpha and sight_pawnshop_door then
		for i = 1, #objs do
			if isElement(objs[i]) then
				destroyElement(objs[i])
			end
		end
		objs = {}
		local obj = createObject(sight_pawnshop_alpha, 249.8119, -57.0098, 1.7646, 0, 0, 0)
		setElementDoubleSided(obj, true)
		table.insert(objs, obj)
		local obj = createObject(sight_pawnshop_door, 253.4883, -61.7166, 0.5731, 0, 0, 0)
		setElementDoubleSided(obj, true)
		table.insert(objs, obj)
		local obj = createObject(sight_pawnshop_door, 255.5118, -61.7095, 0.5731, 0, 0, 180)
		setElementDoubleSided(obj, true)
		table.insert(objs, obj)
		removeWorldModel(1514, 5, 253.18, -54.5, 1.4609)
	end
end
local screenX, screenY = guiGetScreenSize()
local negotiationGui = false
local negotiationData = false
addEvent("refreshPawnData", true)
addEventHandler("refreshPawnData", getRootElement(), function(dat)
	negotiationData = dat
	createNegotiation()
end)
local pawnName = "Zacis úr"
local pawnPed = createPed(241, pawnSellPosX, pawnSellPosY, pawnSellPosZ, pawnSellPosR)
setElementData(pawnPed, "invulnerable", true)
setElementData(pawnPed, "visibleName", pawnName)
setElementData(pawnPed, "pedNameType", "Zálogház")
setElementFrozen(pawnPed, true)
local mineName = "Fémes Dénes"
local mineSellPosX, mineSellPosY, mineSellPosZ, mineSellPosR = -2428.2587890625, 2489.8239746094, 13.994000434875, 270
local minePed = createPed(242, mineSellPosX, mineSellPosY, mineSellPosZ, mineSellPosR)
setElementData(minePed, "invulnerable", true)
setElementData(minePed, "visibleName", mineName)
setElementData(minePed, "pedNameType", "Fém/Drágakő felvásárlás")
setElementFrozen(minePed, true)
local goldPeds = {}
for i = 1, #goldSellPoses do
	local ped = createPed(goldSellPoses[i][5], goldSellPoses[i][1], goldSellPoses[i][2], goldSellPoses[i][3], goldSellPoses[i][4])
	setElementData(ped, "invulnerable", true)
	setElementData(ped, "visibleName", goldSellPoses[i][6])
	setElementData(ped, "pedNameType", "Aranyrúd felvásárlás")
	setElementFrozen(ped, true)
	goldPeds[ped] = i
end

local moneyPeds = {}
for i = 1, #moneyStackSellPoses do
	local ped = createPed(moneyStackSellPoses[i][5], moneyStackSellPoses[i][1], moneyStackSellPoses[i][2], moneyStackSellPoses[i][3], moneyStackSellPoses[i][4])
	setElementData(ped, "invulnerable", true)
	setElementData(ped, "visibleName", moneyStackSellPoses[i][6])
	setElementData(ped, "pedNameType", "A Valutás")
	setElementData(ped, "moneyStackBuyer", true)
	setElementFrozen(ped, true)
	moneyPeds[ped] = i
end
local generatedPed = false
local moneyBlip = false
local moneyTimer = false
function getCasettePos(x, y)
	local r = math.rad(math.pi * 2 * math.random())
	local d = math.random(0, 400) / 10
	return x + math.cos(r) * d, y + math.sin(r) * d
end
function generatePlayerMoneyStackPed()
	if isElement(generatedPed) then
		return false
	end
	local pedPos = math.random(1, #moneyStackSellPoses)
	for ped, pos in pairs(moneyPeds) do
		if pos == pedPos then
			generatedPed = ped
			break
		end
	end
	local blipX, blipY, blipZ = unpack(moneyStackSellPoses[pedPos])
	local x, y = getCasettePos(blipX, blipY)
	local sightgreen = exports.sGui:getColorCode("sightgreen")
	moneyBlip = createBlip(x, y, blipZ - 1, 29, 2, sightgreen[1], sightgreen[2], sightgreen[3])
	if isElement(moneyBlip) then
		setElementData(moneyBlip, "tooltipText", "A valutás")
	end
	moneyTimer = setTimer(destroyPlayerMoneyStackInstance, 1800000, 1)
	return true
end
function destroyPlayerMoneyStackInstance()
	if not isElement(generatedPed) then
		return 
	end
	generatedPed = false
	if isElement(moneyBlip) then
		destroyElement(moneyBlip)
	end
	moneyBlip = false
	if isTimer(moneyTimer) then
		killTimer(moneyTimer)
	end
	moneyTimer = false
end
function tryToSellMoneyStack(currentPed, itemDBID)
    if generatedPed and currentPed == generatedPed then
      local ped = moneyPeds[currentPed]
      local playerX, playerY, playerZ = getElementPosition(localPlayer)
      if getDistanceBetweenPoints3D(moneyStackSellPoses[ped][1], moneyStackSellPoses[ped][2], moneyStackSellPoses[ped][3], playerX, playerY, playerZ) <= 3 then
        triggerServerEvent("tryToSellMoneyStack", localPlayer, ped, itemDBID)
      end
    end
end
local playerIcon = false
local pawnIcon = false
local playerLabel = false
local pawnLabel = false
local playerRect = false
local pawnRect = false
local pawnX = false
local barX, barStart, barY, barSX, barSize, barSY
local barHover = false
local barMoving = false
function refreshPlayerPrice()
	local x = barStart + barSize * (negotiationData.playerPrice - negotiationData.minPrice) / (negotiationData.maxPrice - negotiationData.minPrice)
	sightexports.sGui:setGuiPosition(playerRect, x - 1, false)
	sightexports.sGui:setLabelText(playerLabel, sightexports.sGui:thousandsStepper(negotiationData.playerPrice) .. " $")
	if pawnLabel then
		local lwpl = sightexports.sGui:getLabelTextWidth(playerLabel) / 2 + 2
		local lwpa = sightexports.sGui:getLabelTextWidth(pawnLabel) / 2 + 2
		local d = pawnX + lwpa - (x - lwpl)
		if 0 < d then
			sightexports.sGui:setGuiPosition(playerLabel, x + d / 2, false)
			sightexports.sGui:setGuiPosition(pawnLabel, pawnX - d / 2, false)
		else
			sightexports.sGui:setGuiPosition(playerLabel, x, false)
			sightexports.sGui:setGuiPosition(pawnLabel, pawnX, false)
		end
		local d = pawnX + 12 - (x - 12)
		if 0 < d then
			sightexports.sGui:setGuiPosition(playerIcon, x + d / 2 - 12, false)
			sightexports.sGui:setGuiPosition(pawnIcon, pawnX - d / 2 - 12, false)
		else
			sightexports.sGui:setGuiPosition(playerIcon, x - 12, false)
			sightexports.sGui:setGuiPosition(pawnIcon, pawnX - 12, false)
		end
	else
		sightexports.sGui:setGuiPosition(playerLabel, x, false)
		sightexports.sGui:setGuiPosition(playerIcon, x - 12, false)
	end
end
function onClientClick(btn, state, cx, cy)
	if negotiationData.canMove then
		if state == "down" then
			barMoving = barHover
			if barHover then
				negotiationData.playerPrice = math.floor(negotiationData.minPrice + (cx - barStart) / barSize * (negotiationData.maxPrice - negotiationData.minPrice))
				negotiationData.playerPrice = math.min(negotiationData.playerPrice, negotiationData.fixedPlayerPrice or negotiationData.maxPrice)
				negotiationData.playerPrice = math.max(negotiationData.playerPrice, negotiationData.pawnPrice or negotiationData.minPrice)
				refreshPlayerPrice()
			end
		else
			barMoving = false
			if not barHover then
				sightexports.sGui:setCursorType("normal")
			end
		end
	end
end
function onClientCursorMove(x, y, cx, cy)
	if negotiationData.canMove then
		local tmp = cx >= barX and cy >= barY - 24 - 4 and cx <= barX + barSX and cy <= barY + barSY
		if barHover ~= tmp then
			barHover = tmp
			sightexports.sGui:setCursorType((barHover or barMoving) and "link" or "normal")
		end
		if barMoving then
			negotiationData.playerPrice = math.floor(negotiationData.minPrice + (cx - barStart) / barSize * (negotiationData.maxPrice - negotiationData.minPrice))
			negotiationData.playerPrice = math.min(negotiationData.playerPrice, negotiationData.fixedPlayerPrice or negotiationData.maxPrice)
			negotiationData.playerPrice = math.max(negotiationData.playerPrice, negotiationData.pawnPrice or negotiationData.minPrice)
			refreshPlayerPrice()
		end
	end
end
addEvent("pawnOfferNewPrice", false)
addEventHandler("pawnOfferNewPrice", getRootElement(), function()
	if not negotiationData.thinking then
		negotiationData.canMove = false
		negotiationData.thinking = true
		negotiationData.fixedPlayerPrice = negotiationData.playerPrice
		negotiationData.playerReply = math.random(1, 4) + (negotiationData.goldped and 5 or 0)
		createNegotiation(true)
		triggerServerEvent("pawnOfferNewPrice", localPlayer, negotiationData.playerPrice)
	end
end)
addEvent("pawnEndTheDeal", false)
addEventHandler("pawnEndTheDeal", getRootElement(), function()
	if not negotiationData.thinking then
		negotiationData.canMove = false
		negotiationData.thinking = true
		triggerServerEvent("pawnEndTheDeal", localPlayer)
		createNegotiation(true)
	end
end)
addEvent("pawnAcceptOffer", false)
addEventHandler("pawnAcceptOffer", getRootElement(), function()
	if not negotiationData.thinking and negotiationData.pawnPrice then
		negotiationData.canMove = false
		negotiationData.thinking = true
		negotiationData.playerPrice = negotiationData.pawnPrice
		negotiationData.fixedPlayerPrice = negotiationData.playerPrice
		negotiationData.playerReply = 5 + (negotiationData.goldped and 5 or 0)
		createNegotiation(true)
		triggerServerEvent("pawnAcceptOffer", localPlayer)
	end
end)
function deleteNegotiation()
	if negotiationGui then
		sightexports.sGui:deleteGuiElement(negotiationGui)
		removeEventHandler("onClientCursorMove", getRootElement(), onClientCursorMove)
		removeEventHandler("onClientClick", getRootElement(), onClientClick)
		showCursor(false)
	end
	negotiationGui = false
	if barHover then
		sightexports.sGui:setCursorType("normal")
	end
	playerIcon = false
	pawnIcon = false
	playerLabel = false
	pawnLabel = false
	playerRect = false
	pawnRect = false
	pawnX = false
	barX = false
	barStart = false
	barY = false
	barSX = false
	barSize = false
	barSY = false
	barHover = false
	barMoving = false
end
function createNegotiation(disBtn)
	deleteNegotiation()
	if negotiationData then
		showCursor(true)
		addEventHandler("onClientCursorMove", getRootElement(), onClientCursorMove)
		addEventHandler("onClientClick", getRootElement(), onClientClick)
		negotiationGui = sightexports.sGui:createGuiElement("null", 0, 0, screenX, screenY)
		local sender = (negotiationData.pedName or currentTable == "pawn" and pawnName or mineName) .. ": "
		local text = negotiationTexts[negotiationData.text]
		if negotiationData.playerReply then
			sender = getElementData(localPlayer, "visibleName"):gsub("_", " ") .. ": "
			text = playerReplys[negotiationData.playerReply]
			text = utf8.gsub(text, "%$", sightexports.sGui:thousandsStepper(negotiationData.playerPrice))
		elseif negotiationData.pawnPrice then
			text = utf8.gsub(text, "%$", sightexports.sGui:thousandsStepper(negotiationData.pawnPrice))
		end
		local w1 = sightexports.sGui:getTextWidthFont(sender, "12/Ubuntu-R.ttf")
		local w2 = sightexports.sGui:getTextWidthFont(text, "12/Ubuntu-L.ttf")
		local x = screenX / 2 - (w1 + w2) / 2
		local y = math.floor(screenY * 0.9)
		y = y - 150
		local label = sightexports.sGui:createGuiElement("label", x, y, 0, 0, negotiationGui)
		sightexports.sGui:setLabelAlignment(label, "left", "top")
		sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, sender)
		sightexports.sGui:setLabelShadow(label, "#000000", 1, 1)
		local label = sightexports.sGui:createGuiElement("label", x + w1, y, 0, 0, negotiationGui)
		sightexports.sGui:setLabelAlignment(label, "left", "top")
		sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
		sightexports.sGui:setLabelText(label, text)
		sightexports.sGui:setLabelShadow(label, "#000000", 1, 1)
		y = y + 70
		local rect = sightexports.sGui:createGuiElement("rectangle", screenX / 2 - 225, y, 450, 16, negotiationGui)
		sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
		barX, barY, barSX, barSY = screenX / 2 - 225, y, 450, 16
		barStart = barX
		barSize = barSX
		local label = sightexports.sGui:createGuiElement("label", barStart - 8, y, 0, barSY, negotiationGui)
		sightexports.sGui:setLabelAlignment(label, "right", "center")
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
		sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(negotiationData.minPrice) .. " $")
		sightexports.sGui:setLabelColor(label, "sightgreen")
		sightexports.sGui:setLabelShadow(label, "#000000", 1, 1)
		local label = sightexports.sGui:createGuiElement("label", barStart + barSize + 8, y, 0, barSY, negotiationGui)
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
		sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(negotiationData.maxPrice) .. " $")
		sightexports.sGui:setLabelColor(label, "sightgreen")
		sightexports.sGui:setLabelShadow(label, "#000000", 1, 1)
		local redAlpha = sightexports.sGui:getColorCode("sightred")
		redAlpha[4] = 150
		if negotiationData.pawnPrice then
			local w = barSize * (negotiationData.pawnPrice - negotiationData.minPrice) / (negotiationData.maxPrice - negotiationData.minPrice)
			local rect = sightexports.sGui:createGuiElement("rectangle", barStart, y, w, barSY, negotiationGui)
			sightexports.sGui:setGuiBackground(rect, "solid", redAlpha)
			barX = barX + w
			barSX = barSX - w
		end
		if negotiationData.fixedPlayerPrice then
			local w = barSize * (negotiationData.fixedPlayerPrice - negotiationData.minPrice) / (negotiationData.maxPrice - negotiationData.minPrice)
			local rect = sightexports.sGui:createGuiElement("rectangle", barStart + w, y, barSize - w, barSY, negotiationGui)
			sightexports.sGui:setGuiBackground(rect, "solid", redAlpha)
			barSX = barSX - (barSize - w)
		end
		if negotiationData.pawnPrice then
			local x = barStart + barSize * (negotiationData.pawnPrice - negotiationData.minPrice) / (negotiationData.maxPrice - negotiationData.minPrice)
			pawnIcon = sightexports.sGui:createGuiElement("image", x - 12, y - 24 - 4, 24, 24, negotiationGui)
			sightexports.sGui:setImageFile(pawnIcon, sightexports.sGui:getFaIconFilename("store-alt", 24))
			sightexports.sGui:setImageColor(pawnIcon, "sightblue")
			pawnRect = sightexports.sGui:createGuiElement("rectangle", x - 1, y, 2, barSY, negotiationGui)
			sightexports.sGui:setGuiBackground(pawnRect, "solid", "sightblue")
			pawnLabel = sightexports.sGui:createGuiElement("label", x, y + barSY + 4, 0, 0, negotiationGui)
			sightexports.sGui:setLabelAlignment(pawnLabel, "center", "top")
			sightexports.sGui:setLabelFont(pawnLabel, "10/Ubuntu-L.ttf")
			sightexports.sGui:setLabelText(pawnLabel, sightexports.sGui:thousandsStepper(negotiationData.pawnPrice) .. " $")
			sightexports.sGui:setLabelColor(pawnLabel, "sightblue")
			sightexports.sGui:setLabelShadow(pawnLabel, "#000000", 1, 1)
			pawnX = x
		end
		local x = barStart + barSize * (negotiationData.playerPrice - negotiationData.minPrice) / (negotiationData.maxPrice - negotiationData.minPrice)
		playerIcon = sightexports.sGui:createGuiElement("image", x - 12, y - 24 - 4, 24, 24, negotiationGui)
		sightexports.sGui:setImageFile(playerIcon, sightexports.sGui:getFaIconFilename("user", 24))
		sightexports.sGui:setImageColor(playerIcon, "sightgreen")
		playerRect = sightexports.sGui:createGuiElement("rectangle", x - 1, y, 2, barSY, negotiationGui)
		sightexports.sGui:setGuiBackground(playerRect, "solid", "sightgreen")
		playerLabel = sightexports.sGui:createGuiElement("label", x, y + barSY + 4, 0, 0, negotiationGui)
		sightexports.sGui:setLabelAlignment(playerLabel, "center", "top")
		sightexports.sGui:setLabelFont(playerLabel, "10/Ubuntu-L.ttf")
		sightexports.sGui:setLabelText(playerLabel, sightexports.sGui:thousandsStepper(negotiationData.playerPrice) .. " $")
		sightexports.sGui:setLabelColor(playerLabel, "sightgreen")
		sightexports.sGui:setLabelShadow(playerLabel, "#000000", 1, 1)
		refreshPlayerPrice()
		if not disBtn and not negotiationData.thinking then
			y = y + barSY + 48
			local x = screenX / 2 - 180 * (negotiationData.pawnPrice and negotiationData.pawnPrice ~= negotiationData.playerPrice and negotiationData.pawnPrice < negotiationData.pawnLastPrice and 3 or 2) / 2
			if negotiationData.pawnPrice then
				local btn = sightexports.sGui:createGuiElement("button", x + 4, y, 172, 24, negotiationGui)
				sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
				sightexports.sGui:setGuiHover(btn, "gradient", {
					"sightblue",
					"sightblue-second"
				}, false, true)
				sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
				sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("check", 24))
				sightexports.sGui:setButtonText(btn, "Áll az alku! (" .. sightexports.sGui:thousandsStepper(negotiationData.pawnPrice) .. " $)")
				sightexports.sGui:setClickEvent(btn, "pawnAcceptOffer")
				x = x + 180
			end
			if negotiationData.pawnPrice ~= negotiationData.playerPrice and (not negotiationData.pawnPrice or negotiationData.pawnPrice < negotiationData.pawnLastPrice) then
				local btn = sightexports.sGui:createGuiElement("button", x + 4, y, 172, 24, negotiationGui)
				sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
				sightexports.sGui:setGuiHover(btn, "gradient", {
					"sightgreen",
					"sightgreen-second"
				}, false, true)
				sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
				sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("hand-holding-usd", 24))
				sightexports.sGui:setButtonText(btn, "Ajánlattétel")
				sightexports.sGui:setClickEvent(btn, "pawnOfferNewPrice")
				x = x + 180
			end
			local btn = sightexports.sGui:createGuiElement("button", x + 4, y, 172, 24, negotiationGui)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightred",
				"sightred-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
			sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("times", 24))
			sightexports.sGui:setButtonText(btn, "Alku megszakítása")
			sightexports.sGui:guiSetTooltip(btn, "FIGYELEM! Sikertelen üzlet esetén csak 20 perc múlva próbálkozhatsz újra!")
			sightexports.sGui:setClickEvent(btn, "pawnEndTheDeal")
		end
	end
end
local itemPlusButtons = {}
local itemMinusButtons = {}
local itemLabels = {}
local itemAmounts = {}
local itemSelectedAmount = {}
local window = false
local bigLabel = false
addEventHandler("onClientClick", getRootElement(), function(button, state, x, y, wx, wy, wz, clickedElement)
	if state == "down" and not window and not negotiationData then
		if clickedElement == pawnPed or clickedElement == minePed then
			local px, py, pz = getElementPosition(localPlayer)
			local targetPosition = clickedElement == pawnPed and {pawnSellPosX, pawnSellPosY, pawnSellPosZ} or {mineSellPosX, mineSellPosY, mineSellPosZ}
			if getDistanceBetweenPoints3D(targetPosition[1], targetPosition[2], targetPosition[3], px, py, pz) <= 3 then
				triggerServerEvent("tryToStartPawnDeal", localPlayer, clickedElement == pawnPed and "pawn" or "mine") 
			end
		elseif goldPeds[clickedElement] then
			local i = goldPeds[clickedElement]
			local px, py, pz = getElementPosition(localPlayer)
			if 3 >= getDistanceBetweenPoints3D(goldSellPoses[i][1], goldSellPoses[i][2], goldSellPoses[i][3], px, py, pz) then
				triggerServerEvent("tryToSellGoldBar", localPlayer, i)
			end
		end
	end
end, true, "high+999999999999")
addEvent("changePawnItemAmount", false)
addEventHandler("changePawnItemAmount", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if itemPlusButtons[el] then
		local item = itemPlusButtons[el]
		if itemSelectedAmount[item] < itemAmounts[item] then
			itemSelectedAmount[item] = itemSelectedAmount[item] + 1
			refreshPawnItemAmounts(item)
			refreshBigLabel()
		end
	elseif itemMinusButtons[el] then
		local item = itemMinusButtons[el]
		if 0 < itemSelectedAmount[item] then
			itemSelectedAmount[item] = itemSelectedAmount[item] - 1
			refreshPawnItemAmounts(item)
			refreshBigLabel()
		end
	end
end)
function refreshPawnItemAmounts(k)
	sightexports.sGui:setLabelText(itemLabels[k], itemSelectedAmount[k])
	for el, item in pairs(itemMinusButtons) do
		if item == k then
			sightexports.sGui:setGuiRenderDisabled(el, itemSelectedAmount[k] <= 0)
			break
		end
	end
	for el, item in pairs(itemPlusButtons) do
		if item == k then
			sightexports.sGui:setGuiRenderDisabled(el, itemSelectedAmount[k] >= itemAmounts[k])
			break
		end
	end
end
function refreshBigLabel()
	local sum = 0
	local c = 0
	local selectedTable = currentTable == "pawn" and pawnItems or mineItems

	for el, item in pairs(itemPlusButtons) do
		sum = sum + selectedTable[item] * itemSelectedAmount[item]
		c = c + itemSelectedAmount[item]
	end
	if 0 < c then
		sightexports.sGui:setLabelText(bigLabel, c .. " db, " .. sightexports.sGui:thousandsStepper(sum / 2) .. " $ - " .. sightexports.sGui:thousandsStepper(sum * 2) .. " $")
	else
		sightexports.sGui:setLabelText(bigLabel, c .. " db")
	end
end
function deleteItemSelector()
	if window then
		sightexports.sGui:deleteGuiElement(window)
	end
	window = false
	itemPlusButtons = {}
	itemMinusButtons = {}
	itemLabels = {}
	itemAmounts = {}
	itemSelectedAmount = {}
	bigLabel = false
	showCursor(false)
end
addEvent("closePawnItemWindow", false)
addEventHandler("closePawnItemWindow", getRootElement(), deleteItemSelector)
addEvent("sellSelectedItems", false)
addEventHandler("sellSelectedItems", getRootElement(), function()
	local c = 0
	for el, item in pairs(itemPlusButtons) do
		c = c + itemSelectedAmount[item]
		if itemSelectedAmount[item] <= 0 then
			itemSelectedAmount[item] = nil
		end
	end
	if c <= 0 then
		sightexports.sGui:showInfobox("e", "Előbb válassz ki valamilyen tárgyat!")
		return
	end
	for el, item in pairs(itemPlusButtons) do
		if itemSelectedAmount[item] and itemSelectedAmount[item] <= 0 then
			itemSelectedAmount[item] = nil
		end
	end
	triggerServerEvent("startItemSelling", localPlayer, itemSelectedAmount, currentTable)
	deleteItemSelector()
end)
currentTable = false
addEvent("openPawnItemSelector", true)
addEventHandler("openPawnItemSelector", getRootElement(), function(selectorType)
	sightexports.sTrading:setForexSubscription("all", "pawn")
	refreshPrices()
	currentTable = selectorType

	createItemSelector(selectorType)
end)
function createItemSelector(selectorType)
	if not selectorType then return end
	refreshPrices()
	deleteItemSelector()
	if not negotiationData then
		showCursor(true)
		local selectedTable = selectorType == "pawn" and pawnItems or mineItems
		local items = sightexports.sItems:getLocalPlayerItems()
		itemAmounts = {}
		for k, v in pairs(items) do
			if selectedTable[v.itemId] then
				if not itemAmounts[v.itemId] then
					itemAmounts[v.itemId] = 1
				else
					itemAmounts[v.itemId] = itemAmounts[v.itemId] + 1
				end
			end
		end
		local c = 0
		for k, v in pairs(selectedTable) do
			c = c + 1
		end
		local titleBarHeight = sightexports.sGui:getTitleBarHeight()
		local h = titleBarHeight + c / 2 * 48 + 48
		window = sightexports.sGui:createGuiElement("window", screenX / 2 - 310, screenY / 2 - h / 2, 620, h)
		sightexports.sGui:setWindowTitle(window, "16/BebasNeueRegular.otf", selectorType == "pawn" and "Zálogház" or "Fém/Drágakő felvásárlás")
		sightexports.sGui:setWindowCloseButton(window, "closePawnItemWindow")
		local y = titleBarHeight
		local transp = {
			200,
			200,
			200,
			150
		}
		local transp2 = sightexports.sGui:getColorCode("sightgreen")
		transp2 = {
			transp2[1],
			transp2[2],
			transp2[3],
			150
		}
		local border = sightexports.sGui:createGuiElement("hr", 309, titleBarHeight + 6, 2, c / 2 * 48 - 6, window)
		c = 0
		for k, v in pairs(selectedTable) do
			c = c + 1
			local img = sightexports.sGui:createGuiElement("image", 6 + (c % 2 == 0 and 310 or 0), y + 6, 36, 36, window)
			sightexports.sGui:setImageFile(img, ":sItems/" .. sightexports.sItems:getItemPic(k))
			local label = sightexports.sGui:createGuiElement("label", 42, 0, 0, 18, img)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(label, sightexports.sItems:getItemName(k))
			local money = sightexports.sGui:createGuiElement("label", 42, 18, 0, 18, img)
			sightexports.sGui:setLabelAlignment(money, "left", "center")
			sightexports.sGui:setLabelFont(money, "10/Ubuntu-L.ttf")
			sightexports.sGui:setLabelText(money, sightexports.sGui:thousandsStepper(math.floor(selectedTable[k] / 2)) .. " $ - " .. sightexports.sGui:thousandsStepper(math.floor(selectedTable[k] * 2)) .. " $ / db")
			if not itemAmounts[k] then
				sightexports.sGui:setImageColor(img, transp)
				sightexports.sGui:setLabelColor(label, transp)
				sightexports.sGui:setLabelColor(money, transp2)
			else
				sightexports.sGui:setLabelColor(money, "sightgreen")
				itemLabels[k] = sightexports.sGui:createGuiElement("label", 242, 0, 32, 36, img)
				sightexports.sGui:setLabelAlignment(itemLabels[k], "center", "center")
				sightexports.sGui:setLabelFont(itemLabels[k], "11/Ubuntu-R.ttf")
				sightexports.sGui:setLabelText(itemLabels[k], "0")
				local btn = sightexports.sGui:createGuiElement("button", 218, 6, 24, 24, img)
				sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
				sightexports.sGui:setGuiHover(btn, "gradient", {
					"sightgreen",
					"sightgreen-second"
				}, false, true)
				sightexports.sGui:setClickEvent(btn, "changePawnItemAmount")
				sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
				sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("minus", 24))
				itemMinusButtons[btn] = k
				local btn = sightexports.sGui:createGuiElement("button", 274, 6, 24, 24, img)
				sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
				sightexports.sGui:setGuiHover(btn, "gradient", {
					"sightgreen",
					"sightgreen-second"
				}, false, true)
				sightexports.sGui:setClickEvent(btn, "changePawnItemAmount")
				sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
				sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("plus", 24))
				itemPlusButtons[btn] = k
				itemSelectedAmount[k] = 0
				refreshPawnItemAmounts(k)
			end
			if c % 2 == 0 then
				y = y + 48
				local border = sightexports.sGui:createGuiElement("hr", 6, y - 1, 608, 2, window)
			end
		end
		bigLabel = sightexports.sGui:createGuiElement("label", 12, h - 48, 0, 48, window)
		sightexports.sGui:setLabelAlignment(bigLabel, "left", "center")
		sightexports.sGui:setLabelFont(bigLabel, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(bigLabel, "10 db, 200 000 $ - 300 000 $")
		refreshBigLabel()
		local btn = sightexports.sGui:createGuiElement("button", 488, h - 24 - 12, 120, 24, window)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		sightexports.sGui:setClickEvent(btn, "sellSelectedItems")
		sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(btn, "Tárgyak eladása")
	end
end
