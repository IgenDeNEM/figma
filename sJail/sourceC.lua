local sightexports = {
	sGui = false,
	sGroups = false,
	sModloader = false
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
local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processsightlangStaticImage = {}
sightlangStaticImageToc[0] = true
local sightlangStatImgPre
function sightlangStatImgPre()
	local now = getTickCount()
	if sightlangStaticImageUsed[0] then
		sightlangStaticImageUsed[0] = false
		sightlangStaticImageDel[0] = false
	elseif sightlangStaticImage[0] then
		if sightlangStaticImageDel[0] then
			if now >= sightlangStaticImageDel[0] then
				if isElement(sightlangStaticImage[0]) then
					destroyElement(sightlangStaticImage[0])
				end
				sightlangStaticImage[0] = nil
				sightlangStaticImageDel[0] = false
				sightlangStaticImageToc[0] = true
				return
			end
		else
			sightlangStaticImageDel[0] = now + 5000
		end
	else
		sightlangStaticImageToc[0] = true
	end
	if sightlangStaticImageToc[0] then
		sightlangStatImgHand = false
		removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
	end
end
processsightlangStaticImage[0] = function()
	if not isElement(sightlangStaticImage[0]) then
		sightlangStaticImageToc[0] = false
		sightlangStaticImage[0] = dxCreateTexture("files/icon.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
local sightlangModloaderLoaded = function()
	loadModels()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), checkInsideCol, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), checkInsideCol)
		end
	end
end
local screenX, screenY = guiGetScreenSize()
local ajDisable = false
local jailCols = {}
for i = 1, #jailCells do
	jailCells[i].outsideCol = createColSphere(jailCells[i].outside[1], jailCells[i].outside[2], jailCells[i].outside[3], 3)
	setElementInterior(jailCells[i].outsideCol, jailCells[i].interior)
	setElementDimension(jailCells[i].outsideCol, jailCells[i].dimension)
	jailCols[jailCells[i].outsideCol] = i
end
local inJailRenderHandled = false
local inJailCols = {}
local inJailHover = false
local btnBcg, btnCol = false, false
function renderInJailCol()
	local cx, cy = getCursorPosition()
	if cx then
		cx = cx * screenX
		cy = cy * screenY
	end
	local tmp = false
	for i = 1, #inJailCols do
		local x, y = getScreenFromWorldPosition(jailCells[inJailCols[i]].outside[1], jailCells[inJailCols[i]].outside[2], jailCells[inJailCols[i]].outside[3], 64)
		if x then
			dxDrawRectangle(x - 26, y - 26, 52, 52, btnBcg)
			if cx and cx <= x + 26 and cx >= x - 26 and cy >= y - 26 and cy <= y + 26 then
				sightlangStaticImageUsed[0] = true
				if sightlangStaticImageToc[0] then
					processsightlangStaticImage[0]()
				end
				dxDrawImage(x - 20, y - 20, 40, 40, sightlangStaticImage[0], 0, 0, 0, btnCol)
				tmp = inJailCols[i]
			else
				sightlangStaticImageUsed[0] = true
				if sightlangStaticImageToc[0] then
					processsightlangStaticImage[0]()
				end
				dxDrawImage(x - 20, y - 20, 40, 40, sightlangStaticImage[0])
			end
		end
	end
	if tmp ~= inJailHover then
		inJailHover = tmp
		sightexports.sGui:setCursorType(inJailHover and "link" or "normal")
	end
end
local currentJailingCol = false
local currentJailingPlayer = false
local jailingWindow = false
local playerButtons = false
local timeInput = false
local moneyInput = false
local reasonInput = false
local bailCheckbox = false
function deleteJailing()
	if jailingWindow then
		sightexports.sGui:deleteGuiElement(jailingWindow)
	end
	currentJailingCol = false
	currentJailingPlayer = false
	jailingWindow = false
	playerButtons = false
	timeInput = false
	moneyInput = false
	reasonInput = false
	bailCheckbox = false
end
addEvent("deleteJailing", false)
addEventHandler("deleteJailing", getRootElement(), deleteJailing)
local bailWindow = false
local bailTimer = false
addEvent("bailResponse", false)
addEventHandler("bailResponse", getRootElement(), function(button, state, absoluteX, absoluteY, el, yes)
	if bailWindow then
		sightexports.sGui:deleteGuiElement(bailWindow)
	end
	bailWindow = nil
	bailWindow = false
	if isTimer(bailTimer) then
		killTimer(bailTimer)
	end
	bailTimer = nil
	if yes then
		triggerServerEvent("freeWithBail", localPlayer)
	end
end)
addEvent("hideBailWindow", true)
addEventHandler("hideBailWindow", getRootElement(), function()
	if bailWindow then
		sightexports.sGui:deleteGuiElement(bailWindow)
	end
	bailWindow = nil
	if isTimer(bailTimer) then
		killTimer(bailTimer)
	end
	bailTimer = nil
	bailWindow = false
end)
local bailMoney = 0
local bailRemaining = 5
local bailLabel = false
addEvent("showBailWindow", true)
addEventHandler("showBailWindow", getRootElement(), function(money)
	if bailWindow then
		sightexports.sGui:deleteGuiElement(bailWindow)
	end
	bailWindow = nil
	if isTimer(bailTimer) then
		killTimer(bailTimer)
	end
	bailTimer = nil
	bailWindow = false
	bailRemaining = 5
	bailMoney = money
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local pw = 375
	local ph = titleBarHeight + 210
	bailWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
	sightexports.sGui:setWindowColors(bailWindow, "sightgrey2", "sightgrey1", "sightgrey3", "#ffffff")
	sightexports.sGui:setWindowTitle(bailWindow, "16/BebasNeueRegular.otf", "Óvadék")
	bailLabel = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - 8 - 32 - 8 - titleBarHeight, bailWindow)
	sightexports.sGui:setLabelAlignment(bailLabel, "center", "center")
	sightexports.sGui:setLabelText(bailLabel, "Lehetőséged van óvadék letételére.\n\nEnnek ára: [color=sightblue]" .. sightexports.sGui:thousandsStepper(money) .. " $#FFFFFF.\n\nAz ajánlat még [color=sightblue]5 percig#FFFFFF érvényes.\n\nElfogadod az ajánlatot?")
	sightexports.sGui:setLabelFont(bailLabel, "11/Ubuntu-R.ttf")
	local w = (pw - 24) / 2
	local btn = sightexports.sGui:createGuiElement("button", 8, ph - 8 - 32, w, 32, bailWindow)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(btn, "Igen")
	sightexports.sGui:setClickEvent(btn, "bailResponse")
	sightexports.sGui:setClickArgument(btn, true)
	local btn = sightexports.sGui:createGuiElement("button", pw - w - 8, ph - 8 - 32, w, 32, bailWindow)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightred",
		"sightred-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(btn, "Nem")
	sightexports.sGui:setClickEvent(btn, "bailResponse")
	bailTimer = setTimer(function()
		bailRemaining = bailRemaining - 1
		sightexports.sGui:setLabelText(bailLabel, "Lehetőséged van óvadék letételére.\n\nEnnek ára: [color=sightblue]" .. sightexports.sGui:thousandsStepper(bailMoney) .. " $#FFFFFF.\n\nAz ajánlat még [color=sightblue]" .. bailRemaining .. " percig#FFFFFF érvényes.\n\nElfogadod az ajánlatot?")
		if bailRemaining == 0 then
			if bailWindow then
				sightexports.sGui:deleteGuiElement(bailWindow)
			end
			bailWindow = nil
			bailWindow = false
			if isTimer(bailTimer) then
				killTimer(bailTimer)
			end
			bailTimer = nil
		end
	end, 60000, 0)
end)
addEvent("finalJailPlayer", false)
addEventHandler("finalJailPlayer", getRootElement(), function()
	local time = tonumber(sightexports.sGui:getInputValue(timeInput))
	local money = tonumber(sightexports.sGui:getInputValue(moneyInput))
	local reason = sightexports.sGui:getInputValue(reasonInput)
	if time and money and reason and 0 < time and 0 < money and 0 < utf8.len(reason) then
		if money > maxMoney then
			sightexports.sGui:showInfobox("e", "Maximum összeg: " .. maxMoney .. " $")
			return
		end
		if time > maxTime then
			sightexports.sGui:showInfobox("e", "Maximum idő: " .. maxTime .. " perc")
			return
		end
		local bail = sightexports.sGui:isCheckboxChecked(bailCheckbox)
		triggerServerEvent("tryToJailPlayer", localPlayer, currentJailingPlayer, currentJailingCol, time, money, reason, bail)
		deleteJailing()
	end
end)
addEvent("selectJailPlayer", false)
addEventHandler("selectJailPlayer", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	currentJailingPlayer = playerButtons[el]
	if currentJailingCol and isElement(currentJailingPlayer) and isElementWithinColShape(currentJailingPlayer, jailCells[currentJailingCol].outsideCol) then
		if jailingWindow then
			sightexports.sGui:deleteGuiElement(jailingWindow)
		end
		local titleBarHeight = sightexports.sGui:getTitleBarHeight()
		local panelWidth = 325
		local panelHeight = titleBarHeight + 5 + 245
		jailingWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
		sightexports.sGui:setWindowTitle(jailingWindow, "16/BebasNeueRegular.otf", "Börtön: " .. getElementData(currentJailingPlayer, "visibleName"):gsub("_", " "))
		sightexports.sGui:setWindowCloseButton(jailingWindow, "deleteJailing")
		timeInput = sightexports.sGui:createGuiElement("input", 5, titleBarHeight + 5, panelWidth - 10, 30, jailingWindow)
		sightexports.sGui:setInputIcon(timeInput, "clock")
		sightexports.sGui:setInputFont(timeInput, "10/Ubuntu-R.ttf")
		sightexports.sGui:setInputPlaceholder(timeInput, "Büntetés (1 - " .. maxTime .. " perc)")
		sightexports.sGui:setInputMaxLength(timeInput, utf8.len(tostring(maxTime)))
		sightexports.sGui:setInputNumberOnly(timeInput, true)
		moneyInput = sightexports.sGui:createGuiElement("input", 5, titleBarHeight + 5 + 30 + 5, panelWidth - 10, 30, jailingWindow)
		sightexports.sGui:setInputIcon(moneyInput, "dollar-sign")
		sightexports.sGui:setInputFont(moneyInput, "10/Ubuntu-R.ttf")
		sightexports.sGui:setInputPlaceholder(moneyInput, "Összeg (1 - " .. maxMoney .. " $)")
		sightexports.sGui:setInputMaxLength(moneyInput, utf8.len(tostring(maxMoney)))
		sightexports.sGui:setInputNumberOnly(moneyInput, true)
		reasonInput = sightexports.sGui:createGuiElement("input", 5, titleBarHeight + 5 + 70, panelWidth - 10, 100, jailingWindow)
		sightexports.sGui:setInputFont(reasonInput, "10/Ubuntu-R.ttf")
		sightexports.sGui:setInputPlaceholder(reasonInput, "Indok")
		sightexports.sGui:setInputMaxLength(reasonInput, 120)
		sightexports.sGui:setInputMultiline(reasonInput, true)
		sightexports.sGui:setInputFontPaddingHeight(reasonInput, 32)
		bailCheckbox = sightexports.sGui:createGuiElement("checkbox", 1, titleBarHeight + 5 + 175, 28, 28, jailingWindow)
		sightexports.sGui:setGuiColorScheme(bailCheckbox, "darker")
		local bbox = sightexports.sGui:createGuiElement("rectangle", 6, titleBarHeight + 5 + 175, panelWidth - 6 - 32, 28, jailingWindow)
		sightexports.sGui:setGuiBackground(bbox, "solid", {
			0,
			0,
			0,
			0
		})
		sightexports.sGui:setGuiHover(bbox, "none")
		sightexports.sGui:setGuiHoverable(bbox, true)
		sightexports.sGui:setGuiBoundingBox(bailCheckbox, bbox)
		local label = sightexports.sGui:createGuiElement("label", 33, titleBarHeight + 5 + 175, 0, 32, jailingWindow)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelText(label, "Óvadék lehetősége")
		local btn = sightexports.sGui:createGuiElement("button", 5, titleBarHeight + 5 + 210, panelWidth - 10, 30, jailingWindow)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, "/tömlöc berak")
		sightexports.sGui:setClickEvent(btn, "finalJailPlayer")
	else
		deleteJailing()
	end
end)
function showPlayerSelector()
	local playerList = getElementsWithinColShape(jailCells[currentJailingCol].outsideCol, "player")
	
	for i = #playerList, 1, -1 do
		if playerList[i] == localPlayer or getElementData(playerList[i], "inJail") then
			table.remove(playerList, i)
		end
	end

	if #playerList < 1 then
		sightexports.sGui:showInfobox("e", "Nincs senki a közeledben!")
		deleteJailing()
	else
		if jailingWindow then
			sightexports.sGui:deleteGuiElement(jailingWindow)
		end
		local titleBarHeight = sightexports.sGui:getTitleBarHeight()
		local panelWidth = 250
		local panelHeight = titleBarHeight + 5 + 30 + 5 + 35 * #playerList
		jailingWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
		sightexports.sGui:setWindowTitle(jailingWindow, "16/BebasNeueRegular.otf", "Válassz játékost!")
		local y = titleBarHeight + 5
		playerButtons = {}
		for i = 1, #playerList do
			local btn = sightexports.sGui:createGuiElement("button", 5, y, panelWidth - 10, 30, jailingWindow)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonTextColor(btn, "#ffffff")
			sightexports.sGui:setButtonText(btn, getElementData(playerList[i], "visibleName"):gsub("_", " "))
			sightexports.sGui:setClickEvent(btn, "selectJailPlayer", false)
			playerButtons[btn] = playerList[i]
			y = y + 35
		end
		local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 35, panelWidth - 10, 30, jailingWindow)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightred",
			"sightred-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, "Mégsem")
		sightexports.sGui:setClickEvent(btn, "deleteJailing")
	end
end
function clickInJailCol(button, state)
	if state == "up" and inJailHover and not jailingWindow then
		currentJailingCol = inJailHover
		currentJailingPlayer = false
		showPlayerSelector()
	end
end
addEventHandler("onClientElementColShapeHit", localPlayer, function(theShape, md)
	if md and jailCols[theShape] then
		table.insert(inJailCols, jailCols[theShape])
		if not inJailRenderHandled and sightexports.sGroups:getPlayerPermission("jail") then
			addEventHandler("onClientRender", getRootElement(), renderInJailCol)
			addEventHandler("onClientClick", getRootElement(), clickInJailCol)
			btnBcg = sightexports.sGui:getColorCodeToColor("sightgrey1")
			btnCol = sightexports.sGui:getColorCodeToColor("sightgreen")
		end
		inJailRenderHandled = true
	end
end)
addEventHandler("onClientElementColShapeLeave", localPlayer, function(theShape, md)
	if jailCols[theShape] then
		if jailCols[theShape] == currentJailingCol then
			deleteJailing()
		end
		for i = #inJailCols, 1, -1 do
			if inJailCols[i] == jailCols[theShape] then
				table.remove(inJailCols, i)
			end
		end
		if #inJailCols < 1 then
			if inJailRenderHandled then
				removeEventHandler("onClientRender", getRootElement(), renderInJailCol)
				removeEventHandler("onClientClick", getRootElement(), clickInJailCol)
				sightexports.sGui:setCursorType("normal")
			end
			inJailRenderHandled = false
		end
	end
end)
addEvent("broadcastAdminJailMessage", true)
addEventHandler("broadcastAdminJailMessage", getRootElement(), function(from, to, minute, reason)
	if not ajDisable then
		outputChatBox("[color=sightred][AdminJail]: " .. from .. "#ffffff bebörtönözte [color=sightblue]" .. to .. "#ffffff játékost [color=sightblue]" .. minute .. "#ffffff percre.", 255, 255, 255, true)
		outputChatBox("[color=sightred][AdminJail]: [color=sightblue]Indok: #ffffff" .. reason, 255, 255, 255, true)
	end
end)
addEvent("broadcastOfflineAdminJailMessage", true)
addEventHandler("broadcastOfflineAdminJailMessage", getRootElement(), function(from, to, minute, reason)
	if not ajDisable then
		outputChatBox("[color=sightred][OfflineJail]: " .. from .. "#ffffff bebörtönözte [color=sightblue]" .. to .. "#ffffff játékost [color=sightblue]" .. minute .. "#ffffff percre.", 255, 255, 255, true)
		outputChatBox("[color=sightred][OfflineJail]: [color=sightblue]Indok: #ffffff" .. reason, 255, 255, 255, true)
	end
end)
local obj = false
function loadModels()
	obj = createObject(sightexports.sModloader:getModelId("adminjail"), 0, 0, 100)
	setElementInterior(obj, 1)
	if getElementData(localPlayer, "playerID") then
		setElementDimension(obj, getElementData(localPlayer, "playerID"))
	else
		setElementDimension(obj, 999)
	end
end
addEventHandler("onClientElementDataChange", localPlayer, function(data)
	if data == "playerID" and isElement(obj) then
		setElementDimension(obj, getElementData(localPlayer, "playerID"))
	end
end)
addEvent("loadJailInDimension", true)
addEventHandler("loadJailInDimension", getRootElement(), function(dim)
	if isElement(obj) then
		setElementDimension(obj, dim)
	end
end)
local jailLabel = false
local jailQuestion = false
local jailInput = false
addEvent("sendJailAnswerInput", false)
addEventHandler("sendJailAnswerInput", getRootElement(), function()
	local value = sightexports.sGui:getInputValue(jailInput)
	if utf8.len(value) > 0 then
		triggerServerEvent("sendJailAnswer", localPlayer, value)
		if jailQuestion then
			sightexports.sGui:deleteGuiElement(jailQuestion)
		end
		jailQuestion = false
		jailInput = false
		showCursor(false)
	end
end)
function shuffleTable(t)
	local rand = math.random
	local iterations = #t
	local j
	for i = iterations, 2, -1 do
		j = rand(i)
		t[i], t[j] = t[j], t[i]
	end
	return t
end
addEvent("pickAdminJailAnswer", false)
addEventHandler("pickAdminJailAnswer", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	triggerServerEvent("sendJailAnswer", localPlayer, sightexports.sGui:getButtonText(el))
	for btn, correct in pairs(jailInput) do
		local col = correct and "sightgreen" or "sightred"
		sightexports.sGui:setGuiBackground(btn, "solid", col)
		sightexports.sGui:setGuiHoverable(btn, false)
		sightexports.sGui:setClickEvent(btn, false)
		if el ~= btn then
			sightexports.sGui:setGuiBackgroundAlpha(btn, 0.25)
			sightexports.sGui:setButtonTextColor(btn, "sightlightgrey")
		end
	end
	jailInput = {}
end)
addEvent("gotJailQuestion", true)
addEventHandler("gotJailQuestion", getRootElement(), function(jailType, question)
	if jailQuestion then
		sightexports.sGui:deleteGuiElement(jailQuestion)
	end
	jailQuestion = false
	jailInput = false
	showCursor(false)
	if jailType == 2 then
		local titleBarHeight = sightexports.sGui:getTitleBarHeight()
		local pw = 350
		local answers = {}
		if adminJailQuestions[question] then
			local questionFont = "15/BebasNeueBold.otf"
			local answerFont = "14/BebasNeueRegular.otf"
			for i = 2, 4 do
				table.insert(answers, adminJailQuestions[question][i])
			end
			shuffleTable(answers)
			for i = 1, #answers do
				local aw = sightexports.sGui:getTextWidthFont(answers[i], answerFont) + 48
				pw = math.max(pw, aw)
			end
			local correct = adminJailQuestions[question][adminJailQuestions[question][5] + 1]
			local dat = split(adminJailQuestions[question][1], " ")
			local h = sightexports.sGui:getFontHeight(questionFont)
			local q = ""
			local question = {}
			for i = 1, #dat do
				if sightexports.sGui:getTextWidthFont(q .. " " .. dat[i], questionFont) > pw - 16 then
					table.insert(question, q)
					q = dat[i]
				else
					q = q .. " " .. dat[i]
				end
			end
			table.insert(question, q)
			local ph = titleBarHeight + 8 + h * #question + 16 + 38 * #answers
			jailQuestion = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
			sightexports.sGui:setWindowTitle(jailQuestion, "16/BebasNeueRegular.otf", "AdminJail")
			for i = 1, #question do
				local label = sightexports.sGui:createGuiElement("label", 8, titleBarHeight + 8 + (i - 1) * h, pw - 16, 30, jailQuestion)
				sightexports.sGui:setLabelFont(label, questionFont)
				sightexports.sGui:setLabelColor(label, "#ffffff")
				sightexports.sGui:setLabelAlignment(label, "center", "center")
				sightexports.sGui:setLabelText(label, question[i])
			end
			jailInput = {}
			for i = 1, #answers do
				local btn = sightexports.sGui:createGuiElement("button", 8, ph - 38 * i, pw - 16, 30, jailQuestion)
				sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
				sightexports.sGui:setGuiHover(btn, "gradient", {
					"sightblue",
					"sightblue-second"
				}, false, true)
				sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
				sightexports.sGui:setButtonTextColor(btn, "#ffffff")
				sightexports.sGui:setButtonText(btn, answers[i])
				sightexports.sGui:setClickEvent(btn, "pickAdminJailAnswer")
				jailInput[btn] = correct == answers[i]
			end
		end
	elseif jailType == 3 then
		showCursor(true)
		local titleBarHeight = sightexports.sGui:getTitleBarHeight()
		local pw = 300
		local ph = titleBarHeight + 8 + 152
		jailQuestion = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
		sightexports.sGui:setWindowTitle(jailQuestion, "16/BebasNeueRegular.otf", "AdminJail")
		local label = sightexports.sGui:createGuiElement("label", 8, ph - 152, pw - 16, 30, jailQuestion)
		sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelText(label, "Másold be az alábbi szöveget!")
		local rect = sightexports.sGui:createGuiElement("rectangle", 8, ph - 114, pw - 16, 30, jailQuestion)
		sightexports.sGui:setGuiBackground(rect, "solid", "#000000")
		local label = sightexports.sGui:createGuiElement("label", 8, ph - 114, pw - 16, 30, jailQuestion)
		sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelText(label, question)
		jailInput = sightexports.sGui:createGuiElement("input", 8, ph - 76, pw - 16, 30, jailQuestion)
		sightexports.sGui:setInputPlaceholder(jailInput, "Válasz")
		sightexports.sGui:setInputFont(jailInput, "10/Ubuntu-R.ttf")
		local btn = sightexports.sGui:createGuiElement("button", 8, ph - 30 - 8, pw - 16, 30, jailQuestion)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, "Válasz beküldése")
		sightexports.sGui:setClickEvent(btn, "sendJailAnswerInput", true)
		sightexports.sGui:setActiveInput(jailInput)
	end
end)
local col = false
local lastSend = 0
function checkInsideCol()
	if not isElementWithinColShape(localPlayer, col) and getTickCount() - lastSend > 1000 then
		triggerServerEvent("leftJailCol", localPlayer)
		lastSend = getTickCount()
	end
end
addEvent("refreshJailTime", true)
addEventHandler("refreshJailTime", getRootElement(), function(time, jailCol)
	if time then
		if not jailLabel then
			jailLabel = sightexports.sGui:createGuiElement("label", 0, 0, screenX, screenY - 128)
			sightexports.sGui:setLabelFont(jailLabel, "20/BebasNeueBold.otf")
			sightexports.sGui:setLabelColor(jailLabel, "sightred")
			sightexports.sGui:setLabelShadow(jailLabel, "#000000", 1, 1)
			sightexports.sGui:setLabelAlignment(jailLabel, "center", "bottom")
		end
		sightexports.sGui:setLabelText(jailLabel, "Hátralevő büntetés: " .. time .. " perc")
		if jailCol then
			col = jailCol
			sightlangCondHandl0(true)
		end
	else
		if jailLabel then
			sightexports.sGui:deleteGuiElement(jailLabel)
		end
		jailLabel = false
		if jailQuestion then
			sightexports.sGui:deleteGuiElement(jailQuestion)
		end
		jailQuestion = false
		jailInput = false
		showCursor(false)
		sightlangCondHandl0(false)
	end
end)
