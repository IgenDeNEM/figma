local sightexports = {sGui = false, sFishing = false}
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
local sightlangGuiRefreshColors = function()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		refreshListener()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState1 then
		sightlangCondHandlState1 = cond
		if cond then
			addEventHandler("onClientKey", getRootElement(), animpanelKeyHandler, true, prio)
		else
			removeEventHandler("onClientKey", getRootElement(), animpanelKeyHandler)
		end
	end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), checkIfAnimStillPlaying, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), checkIfAnimStillPlaying)
		end
	end
end
local screenX, screenY = guiGetScreenSize()
local scrollOffset = 0
local selectorElements = {}
local selectorCategoryButtons = {}
local currentCategory = "user"
local buttonActions = {}
local currentAnimList = {}
local favoriteList = {}
local linkList = {}
circleList = {}
local categoryIcons = {}
local categoryIconList = {}
local specialIcons = {}
function refreshListener()
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local w, h = 600, titleBarHeight + 360 + 12
	local iconHeight = (h - titleBarHeight) / (#categoryList + 2)
	for i = 1, #categoryList do
		categoryIcons[i] = sightexports.sGui:getFaIconFilename(categoryList[i][2], 24) or sightexports.sGui:getFaIconFilename("user", 24)
	end
	for i = 1, #categoryList do
		categoryIconList[i] = sightexports.sGui:getFaIconFilename(categoryList[i][2], iconHeight) or sightexports.sGui:getFaIconFilename("user", iconHeight)
	end
	specialIcons.play = sightexports.sGui:getFaIconFilename("play", 24)
	specialIcons.stop = sightexports.sGui:getFaIconFilename("stop", 24)
	specialIcons.bolt = sightexports.sGui:getFaIconFilename("bolt", 24)
	specialIcons.user = sightexports.sGui:getFaIconFilename("user", 24)
	specialIcons.link = sightexports.sGui:getFaIconFilename("link", 24)
	specialIcons.star = sightexports.sGui:getFaIconFilename("star", 24, "solid")
	specialIcons.play_regular = sightexports.sGui:getFaIconFilename("play", 24, "regular")
	specialIcons.bolt_regular = sightexports.sGui:getFaIconFilename("bolt", 24, "regular")
	specialIcons.star_regular = sightexports.sGui:getFaIconFilename("star", 24, "regular")
	specialIcons.link_regular = sightexports.sGui:getFaIconFilename("link", 24, "regular")
end
function loadConfig(name, maxValues)
	local ret = {}
	if fileExists(name .. ".sight") then
		local file = fileOpen(name .. ".sight")
		if file then
			local data = split(fileRead(file, fileGetSize(file)), "\n")
			for i = 1, #data do
				if maxValues and maxValues < i then
					break
				end
				if tonumber(data[i]) then
					table.insert(ret, tonumber(data[i]))
				end
			end
		end
		fileClose(file)
	else
		return ret
	end
	return ret
end
function saveConfig(data, name)
	local file = false
	if fileExists(name .. ".sight") then
		fileDelete(name .. ".sight")
	end
	file = fileCreate(name .. ".sight")
	if file then
		local saveData = ""
		for i = 1, #data do
			if tonumber(data[i]) then
				if i ~= #data then
					saveData = saveData .. data[i] .. "\n"
				else
					saveData = saveData .. data[i]
				end
			end
		end
		fileWrite(file, saveData)
		fileFlush(file)
		fileClose(file)
	end
	return {}
end
favoriteList = loadConfig("!animpanel/fav")
currentAnimList = favoriteList
circleList = loadConfig("!animpanel/circle", 8)
local animPlaying = false
local waitingForAnim = false
currentAnimId = false
function checkIfAnimStillPlaying(delta)
	local animBlock, animName = getPedAnimation(localPlayer)
	if animBlock and animName then
		animBlock, animName = utf8.lower(animBlock), utf8.lower(animName)
	end
	if waitingForAnim then
		waitingForAnim = waitingForAnim - delta
		if waitingForAnim < 0 then
			waitingForAnim = false
		else
			if animBlock == animList[currentAnimId][3] and animName == animList[currentAnimId][4] then
				waitingForAnim = false
			end
			return
		end
	end
	if animBlock ~= animList[currentAnimId][3] or animName ~= animList[currentAnimId][4] then
		currentAnimId = false
		sightlangCondHandl0(false)
		sightlangCondHandl1(false)
		triggerServerEvent("playAnimpanelAnimation", localPlayer)
		if animpanelWindow then
			refreshAnimList()
		end
	end
end
function animpanelKeyHandler(key, state)
	if key == "space" and state and not sightexports.sGui:getActiveInput() and not isChatBoxInputActive() and not isConsoleActive() then
		currentAnimId = false
		sightlangCondHandl0(false)
		sightlangCondHandl1(false)
		triggerServerEvent("playAnimpanelAnimation", localPlayer)
		if animpanelWindow then
			refreshAnimList()
		end
	end
end
function isFavorite(animID)
	for i = 1, #favoriteList do
		if favoriteList[i] == animID then
			return true
		end
	end
	return false
end
function isCircle(id)
	for i = 1, #circleList do
		if circleList[i] == id then
			return true
		end
	end
	return false
end
function refreshAnimList()
	for btn, val in pairs(selectorCategoryButtons) do
		if currentCategory == val then
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
			sightexports.sGui:setGuiHoverable(btn, false)
		else
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
			sightexports.sGui:setGuiHoverable(btn, true)
		end
	end
	for i = 1, #selectorElements do
		if not currentAnimList[i] then
			for j = 1, #selectorElements[i] do
				if selectorElements[i][j] then
					sightexports.sGui:setGuiRenderDisabled(selectorElements[i][j], true)
				end
			end
		else
			for j = 1, #selectorElements[i] do
				if selectorElements[i][j] then
					sightexports.sGui:setGuiRenderDisabled(selectorElements[i][j], false)
				end
			end
			if selectorElements[i][7] and not isLinkAnimation(currentAnimList[i]) then
				sightexports.sGui:setGuiRenderDisabled(selectorElements[i][7], true)
			end
			sightexports.sGui:setClickArgument(selectorElements[i][7], currentAnimList[i + scrollOffset])

			sightexports.sGui:setImageFile(selectorElements[i][1], categoryIcons[currentCategory] or specialIcons.user)
			sightexports.sGui:setLabelText(selectorElements[i][2], animList[currentAnimList[i + scrollOffset]][2])
			if isFavorite(currentAnimList[i + scrollOffset]) then
				sightexports.sGui:setImageFile(selectorElements[i][4], specialIcons.star)
				sightexports.sGui:setImageColor(selectorElements[i][4], "sightyellow")
			else
				sightexports.sGui:setImageFile(selectorElements[i][4], specialIcons.star_regular)
				sightexports.sGui:setImageColor(selectorElements[i][4], "#FFFFFF")
			end
			if isCircle(currentAnimList[i + scrollOffset]) then
				sightexports.sGui:setImageFile(selectorElements[i][6], specialIcons.bolt)
				sightexports.sGui:setImageColor(selectorElements[i][6], "sightblue")
			else
				sightexports.sGui:setImageFile(selectorElements[i][6], specialIcons.bolt_regular)
				sightexports.sGui:setImageColor(selectorElements[i][6], "#FFFFFF")
			end
			sightexports.sGui:setClickArgument(selectorElements[i][6], currentAnimList[i + scrollOffset])
			if currentAnimId == currentAnimList[i + scrollOffset] then
				sightexports.sGui:setImageFile(selectorElements[i][5], specialIcons.stop)
				sightexports.sGui:setImageColor(selectorElements[i][5], "sightgreen")
				sightexports.sGui:setClickArgument(selectorElements[i][5], currentAnimList[i + scrollOffset])
			else
				sightexports.sGui:setImageFile(selectorElements[i][5], specialIcons.play)
				sightexports.sGui:setImageColor(selectorElements[i][5], "#FFFFFF")
				sightexports.sGui:setClickArgument(selectorElements[i][5], currentAnimList[i + scrollOffset])
			end
		end
	end
	local sh = 360 / math.max(1, #currentAnimList - 12 + 1)
	sightexports.sGui:setGuiSize(selectorScrollBar, false, sh)
	sightexports.sGui:setGuiPosition(selectorScrollBar, false, sh * scrollOffset)
end
addEvent("setFavorite", true)
addEventHandler("setFavorite", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	local num = 0
	for i = 1, #selectorElements do
		if selectorElements[i][4] == el then
			num = i
			break
		end
	end
	if isFavorite(currentAnimList[num + scrollOffset]) then
		for i = 1, #favoriteList do
			if favoriteList[i] == currentAnimList[num + scrollOffset] then
				table.remove(favoriteList, i)
			end
		end
	else
		table.insert(favoriteList, currentAnimList[num + scrollOffset])
	end
	saveConfig(favoriteList, "!animpanel/fav")
	refreshAnimList()
end)
addEvent("setCircle", true)
addEventHandler("setCircle", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
	if isCircle(id) then
		for i = 1, #circleList do
			if circleList[i] == id then
				table.remove(circleList, i)
			end
		end
	elseif #circleList < 8 then
		table.insert(circleList, id)
	else
		sightexports.sGui:showInfobox("e", "Egyszerre maximum 8 darab animációt rakhatsz a gyors elérésbe!")
	end
	saveConfig(circleList, "!animpanel/circle")
	refreshAnimList()
end)

function deleteSelector()
	if selectorWindow then
		sightexports.sGui:deleteGuiElement(selectorWindow)
		selectorWindow = false
	end
end
addEvent("deleteSelector", false)
addEventHandler("deleteSelector", getRootElement(), deleteSelector)


addEvent("selectPlayerPairAnimation", false)
addEventHandler("selectPlayerPairAnimation", getRootElement(), function(button, state, absoluteX, absoluteY, el, animId)
	currentAnimationPlayer = playerButtons[el]
	if selectorWindow then
		sightexports.sGui:deleteGuiElement(selectorWindow)
		selectorWindow = false
		triggerServerEvent("selectPlayerPairAnimation", localPlayer, currentAnimationPlayer, animId)
	end
end)

addEvent("showPlayerSelector", true)
addEventHandler("showPlayerSelector", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)

	local x, y, z = getElementPosition(localPlayer)
	local playerList = getElementsWithinRange(x, y, z, 5, "player")
	for i = #playerList, 1, -1 do
		if playerList[i] == localPlayer then
			table.remove(playerList, i)
		end
	end
	if #playerList < 1 then
		sightexports.sGui:showInfobox("e", "Nincs senki a közeledben!")
		deleteSelector()
	else
		if selectorWindow then
			sightexports.sGui:deleteGuiElement(selectorWindow)
		end
		local titleBarHeight = sightexports.sGui:getTitleBarHeight()
		local panelWidth = 300
		local panelHeight = titleBarHeight + 5 + 30 + 5 + 35 * #playerList
		selectorWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
		sightexports.sGui:setWindowTitle(selectorWindow, "16/BebasNeueRegular.otf", "Páros animáció - Játékosok")
		local y = titleBarHeight + 5
		playerButtons = {}
		for i = 1, #playerList do
			local btn = sightexports.sGui:createGuiElement("button", 5, y, panelWidth - 10, 30, selectorWindow)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonTextColor(btn, "#ffffff")
			sightexports.sGui:setButtonText(btn, getElementData(playerList[i], "visibleName"):gsub("_", " "))
			sightexports.sGui:setClickEvent(btn, "selectPlayerPairAnimation", false)
			sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("user", 28))
			sightexports.sGui:setClickArgument(btn, id)
			playerButtons[btn] = playerList[i]
			y = y + 35
		end
		local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 35, panelWidth - 10, 30, selectorWindow)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightred",
			"sightred-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, "Mégsem")
		sightexports.sGui:setClickEvent(btn, "deleteSelector")
	end
end)

addEvent("playAnimation", true)
addEventHandler("playAnimation", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
	if getPedSimplestTask(localPlayer) ~= "TASK_SIMPLE_IN_AIR" and getPedSimplestTask(localPlayer) ~= "TASK_SIMPLE_LAND" and sightexports.sFishing:canUseAnimPanel() then
		triggerServerEvent("playAnimpanelAnimation", localPlayer, id)
	end
end)
addEvent("gotCurrentAnim", true)
addEventHandler("gotCurrentAnim", getRootElement(), function(id)
	currentAnimId = id
	waitingForAnim = 10000
	sightlangCondHandl0(id)
	sightlangCondHandl1(id)
	if animpanelWindow then
		refreshAnimList()
	end
end)
function scrollHandler(key)
	if key == "mouse_wheel_up" then
		if 0 < scrollOffset then
			scrollOffset = scrollOffset - 1
			refreshAnimList()
		end
	elseif key == "mouse_wheel_down" and scrollOffset < #currentAnimList - 12 then
		scrollOffset = scrollOffset + 1
		refreshAnimList()
	end
end
addEvent("selectAnimpanelCategory", true)
addEventHandler("selectAnimpanelCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if selectorCategoryButtons[el] then
		scrollOffset = 0
		currentCategory = selectorCategoryButtons[el]
		if currentCategory == "user" then
			currentAnimList = favoriteList
		elseif currentCategory == "circle" then
			currentAnimList = circleList
		elseif currentCategory == "link" then
			currentAnimList = {}
			for k, v in pairs(linkAnimations) do
				table.insert(currentAnimList, v)
			end
		else
			currentAnimList = getCategoryAnimations(currentCategory)
		end
		refreshAnimList()
	end
end)
function closeAnimpanel()
	removeEventHandler("onClientKey", getRootElement(), scrollHandler)
	local x, y = sightexports.sGui:getGuiPosition(animpanelWindow)
	if fileExists("!animpanel/pos.sight") then
		fileDelete("!animpanel/pos.sight")
	end
	local file = fileCreate("!animpanel/pos.sight")
	fileWrite(file, x .. ";" .. y)
	fileClose(file)
	if animpanelWindow then
		sightexports.sGui:deleteGuiElement(animpanelWindow)
	end
	animpanelWindow = nil
end
addEvent("closeAnimpanel", true)
addEventHandler("closeAnimpanel", getRootElement(), closeAnimpanel)
function createAnimSelector()
	if getElementData(localPlayer, "loggedIn") then
		if animpanelWindow then
			closeAnimpanel()
		else
			addEventHandler("onClientKey", getRootElement(), scrollHandler)
			local titleBarHeight = sightexports.sGui:getTitleBarHeight()
			local w, h = 600, titleBarHeight + 360 + 12
			local posX, posY = screenX / 2 - w / 2, screenY / 2 - h / 2
			if fileExists("!animpanel/pos.sight") then
				local file = fileOpen("!animpanel/pos.sight")
				local data = fileRead(file, fileGetSize(file))
				fileClose(file)
				local pos = split(data, ";")
				posX, posY = tonumber(pos[1]), tonumber(pos[2])
			end
			animpanelWindow = sightexports.sGui:createGuiElement("window", posX, posY, w, h)
			sightexports.sGui:setWindowTitle(animpanelWindow, "16/BebasNeueRegular.otf", "Animációk")
			sightexports.sGui:setWindowCloseButton(animpanelWindow, "closeAnimpanel")
			local ch = (h - titleBarHeight) / (#categoryList + 3)
			local y = titleBarHeight
			selectorCategoryButtons = {}
			selectorElements = {}
			previewButtons = {}
			local x = 0
			local btn = sightexports.sGui:createGuiElement("button", 0, y, 160, ch, animpanelWindow)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
			sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
			sightexports.sGui:setButtonText(btn, " Kedvencek")
			sightexports.sGui:setButtonIcon(btn, specialIcons.user)
			sightexports.sGui:setClickEvent(btn, "selectAnimpanelCategory")
			selectorCategoryButtons[btn] = "user"
			y = y + ch
			local btn = sightexports.sGui:createGuiElement("button", 0, y, 160, ch, animpanelWindow)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
			sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
			sightexports.sGui:setButtonText(btn, " Gyors elérés")
			sightexports.sGui:setButtonIcon(btn, specialIcons.bolt)
			sightexports.sGui:setClickEvent(btn, "selectAnimpanelCategory")
			selectorCategoryButtons[btn] = "circle"
			y = y + ch
			local btn = sightexports.sGui:createGuiElement("button", 0, y, 160, ch, animpanelWindow)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
			sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
			sightexports.sGui:setButtonText(btn, "Páros")
			sightexports.sGui:setButtonIcon(btn, specialIcons.link)
			sightexports.sGui:setClickEvent(btn, "selectAnimpanelCategory")
			selectorCategoryButtons[btn] = "link"
			y = y + ch
			for i = 1, #categoryList do
				local btn = sightexports.sGui:createGuiElement("button", 0, y, 160, ch, animpanelWindow)
				sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
				sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
				sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
				sightexports.sGui:setButtonText(btn, " " .. categoryList[i][1])
				sightexports.sGui:setButtonIcon(btn, categoryIconList[i])
				sightexports.sGui:setClickEvent(btn, "selectAnimpanelCategory")
				selectorCategoryButtons[btn] = i
				y = y + ch
			end
			x = x + 160
			y = titleBarHeight + 6
			for i = 1, 12 do
				selectorElements[i] = {}
				selectorElements[i][1] = sightexports.sGui:createGuiElement("image", x + 6, y + 15 - 12, 24, 24, animpanelWindow)
				selectorElements[i][2] = sightexports.sGui:createGuiElement("label", x + 6 + 24 + 3, y, 0, 30, animpanelWindow)
				sightexports.sGui:setLabelAlignment(selectorElements[i][2], "left", "center")
				sightexports.sGui:setLabelFont(selectorElements[i][2], "11/Ubuntu-R.ttf")
				local bw = 24
				selectorElements[i][3] = sightexports.sGui:createGuiElement("label", 0, y, w - (30 + bw) - 2 - 12, 30, animpanelWindow)
				sightexports.sGui:setLabelAlignment(selectorElements[i][3], "right", "center")
				sightexports.sGui:setLabelFont(selectorElements[i][3], "11/Ubuntu-R.ttf")
				local icon = sightexports.sGui:createGuiElement("image", w - bw - 2 - 6 - 2 - 24 - 2, y + 15 - 12, 24, 24, animpanelWindow)
				sightexports.sGui:setImageFile(icon, specialIcons.star_regular)
				sightexports.sGui:setGuiHoverable(icon, true)
				sightexports.sGui:setClickEvent(icon, "setFavorite")
				selectorElements[i][4] = icon
				local icon = sightexports.sGui:createGuiElement("image", w - bw - 2 - 6 - 2, y + 15 - 12, 24, 24, animpanelWindow)
				sightexports.sGui:setImageFile(icon, specialIcons.play_regular)
				sightexports.sGui:setGuiHoverable(icon, true)
				sightexports.sGui:setClickEvent(icon, "playAnimation")
				selectorElements[i][5] = icon
				local icon = sightexports.sGui:createGuiElement("image", w - bw - 2 - 6 - 4 - 48, y + 15 - 12, 24, 24, animpanelWindow)
				sightexports.sGui:setImageFile(icon, specialIcons.bolt_regular)
				sightexports.sGui:setGuiHoverable(icon, true)
				sightexports.sGui:setClickEvent(icon, "setCircle")
				selectorElements[i][6] = icon
				
				local icon = sightexports.sGui:createGuiElement("image", w - bw - 2 - 6 - 4 - 48 - 24, y + 15 - 12, 24, 24, animpanelWindow)
				sightexports.sGui:setImageFile(icon, specialIcons.link_regular)
				sightexports.sGui:setGuiHoverable(icon, true)
				sightexports.sGui:setClickEvent(icon, "showPlayerSelector")
				sightexports.sGui:guiSetTooltip(icon, "Páros animáció lejátszása")
				selectorElements[i][7] = icon
				y = y + 30
				if i < 12 then
					local border = sightexports.sGui:createGuiElement("hr", x + 6, y - 1, w - 12 - x - 2 - 6, 2, animpanelWindow)
				end
			end
			local rect = sightexports.sGui:createGuiElement("rectangle", w - 6 - 2, titleBarHeight + 6, 2, 360, animpanelWindow)
			sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
			selectorScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, 360, rect)
			sightexports.sGui:setGuiBackground(selectorScrollBar, "solid", "sightmidgrey")
			refreshAnimList()
		end
	end
end
addCommandHandler("animpanel", createAnimSelector)
local customAnimList = {
	"SEcrckidle1",
	"Scrckdeth2",
	"S3SitnWait_loop_W",
	"S2SitnWait_loop_W",
	"Rtisztelges_gsign5LH",
	"Rtarkonhandsup_cower",
	"rSitnWait_loop_W",
	"Rhandsup",
	"Rfallfront_csplay",
	"Rcolt45_fire_2hands",
	"ParkSit_W_loop",
	"ParkSit_M_loop",
	"noifekv",
	"LOU",
	"leanIDLE",
	"Lcamcrch_cmon",
	"Lay_Bac_Loop",
	"HCS_Dead_Guy",
	"Hcrckidle4",
	"Gun_stand_4",
	"Gun_stand_3",
	"Gun_stand_2",
	"Gun_stand",
	"fSitnWait_loop_W",
	"FPParkSit_M_loop",
	"FPGun_stand",
	"FPCoplook_loop",
	"FPCoplook_in",
	"FPbather",
	"FP5bather",
	"FP4bather",
	"FP3bather",
	"FP2ParkSit_M_loop",
	"FP2bather",
	"fekves",
	"FARMSitnWait_loop_W",
	"FARMBARman_idle",
	"FARM2SitnWait_loop_W",
	"FARM2BARman_idle",
	"Ddnce_M_e",
	"Ddnce_M_b",
	"Ddnce_M_a",
	"Ddance_loop",
	"DDAN_Up_A",
	"DDAN_Right_A",
	"DDAN_Loop_A",
	"DDAN_Left_A",
	"DDAN_Down_A",
	"Dbd_clap1",
	"Dbd_clap",
	"cSitnWait_loop_W",
	"bather",
	"SSitnWait_loop_W",
	"SitnWait_loop_W",
	"SEcrckidle4",
	"SEcrckidle3",
	"SEcrckidle2",
	"clap2_tran_hng",
	"clap1_tran_gtup",
	"gum_eat",
	"bal_elso_2",
	"bal_elso_3",
	"bal_hatso_1",
	"bal_hatso_2",
	"jobb_2",
	"jobb_3",
	"tricking"
}
local ifpList = {}
for i = 1, #customAnimList do
	local ifp = engineLoadIFP("custom/" .. customAnimList[i] .. ".ifp", "SGS" .. customAnimList[i])
	table.insert(ifpList, ifp)
end
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
	for i = 1, #ifpList do
		destroyElement(ifpList[i])
	end
end)
local farmAnims = {
	{
		"FARMSitnWait_loop_W",
		"SitnWait_loop_W"
	},
	{
		"FARMBARman_idle",
		"BARman_idle"
	},
	{
		"FARM2SitnWait_loop_W",
		"SitnWait_loop_W"
	},
	{
		"FARM2BARman_idle",
		"BARman_idle"
	}
}
function processCustomAnim(client)
	local customAnim = getElementData(client, "customAnim") or false
	if customAnim and tonumber(customAnim) then
		local updatePosition = false
		if animList[customAnim][3] == "sgstricking" then
			updatePosition = true
		end
		setPedAnimation(client, animList[customAnim][3], animList[customAnim][4], -1, animList[customAnim][5], updatePosition, false, animList[customAnim][7])
	elseif customAnim and utf8.len(customAnim) > 0 then
		if utf8.find(customAnim, "farm") then
			local dat = split(customAnim, "_")
			local anim = tonumber(dat[2])
			local farmAnim = farmAnims[anim]
			setPedAnimation(client, "SGS" .. farmAnim[1], farmAnim[2], tonumber(dat[3]), true, false, false, false)
		end
	else
		setPedAnimation(client)
	end
end
addEventHandler("onClientPlayerStreamIn", getRootElement(), function()
	processCustomAnim(source)
end)
addEventHandler("onClientPlayerDataChange", getRootElement(), function(dataName)
	if dataName == "customAnim" then
		processCustomAnim(source)
	end
end)
function commandDispatcher(cmd, arg)
	arg = tonumber(arg) or 0
	if commandLookup[cmd] then
		local animId
		if arg == 0 and commandLookup[cmd][1] then
			animId = commandLookup[cmd][1]
		else
			animId = commandLookup[cmd][arg]
		end
		if animId and getPedSimplestTask(localPlayer) ~= "TASK_SIMPLE_IN_AIR" and getPedSimplestTask(localPlayer) ~= "TASK_SIMPLE_LAND" and sightexports.sFishing:canUseAnimPanel() then
			triggerServerEvent("playAnimpanelAnimation", localPlayer, animId)
		end
	end
end
for k, v in pairs(commandLookup) do
	addCommandHandler(k, commandDispatcher, false)
end
addCommandHandler("anims", function()
	local outText = {}
	for k, v in pairs(commandLookup) do
		local arg = 1 < #v and " [1-" .. #v .. "]" or ""
		table.insert(outText, "#FFFFFF/" .. k .. arg)
	end
	local realOutTexts = {}
	for i = 1, #outText do
		if not realOutTexts[i % 7] then
			realOutTexts[i % 7] = {}
		end
		table.insert(realOutTexts[i % 7], outText[i])
	end
	for k, v in pairs(realOutTexts) do
			local text = table.concat(v, ", ")
			outputChatBox("[color=sightgreen][SightMTA - Animációk]: " .. text, 255, 255, 255, true)
	end
end)
local animPanelBind = "f2"
function getAnimPanelBind()
	return animPanelBind
end
function setAnimPanelBind(button)
	animPanelBind = button
end
addEventHandler("onClientKey", getRootElement(), function(button, por)
	if animPanelBind and utf8.lower(button) == utf8.lower(animPanelBind) and por then
		createAnimSelector()
	end
end)
