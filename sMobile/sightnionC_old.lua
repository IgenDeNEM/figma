local sightexports = {sGui = false, sPermission = false}
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
local sightlangCondHandlState5 = false
local function sightlangCondHandl5(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState5 then
		sightlangCondHandlState5 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), waitAndLoadPmList, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), waitAndLoadPmList)
		end
	end
end
local sightlangCondHandlState6 = false
local function sightlangCondHandl6(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState6 then
		sightlangCondHandlState6 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), waitAndLoadMarketList, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), waitAndLoadMarketList)
		end
	end
end
local sightlangCondHandlState4 = false
local function sightlangCondHandl4(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState4 then
		sightlangCondHandlState4 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), waitAndValidatePm, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), waitAndValidatePm)
		end
	end
end
local sightlangCondHandlState3 = false
local function sightlangCondHandl3(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState3 then
		sightlangCondHandlState3 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), waitAndRefreshPmListScroll, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), waitAndRefreshPmListScroll)
		end
	end
end
local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState2 then
		sightlangCondHandlState2 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), waitThenLoad, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), waitThenLoad)
		end
	end
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState1 then
		sightlangCondHandlState1 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), processFrozenInput, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), processFrozenInput)
		end
	end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), waitAndProcessSightNionChatMessages, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), waitAndProcessSightNionChatMessages)
		end
	end
end
local bottomY = false
local topY = false
local inputRectSize = false
local sightNionTopRect = false
local sightNionInputRect = false
local nionStatusLabel = false
local sightNionInput = false
local nionScrollBar = false
local sightNionSh = false
local sightNionCurrentPM = false
local sightNionPmValid = false
local sightNionConnected = false
local firstSightNionMessage = 0
local lastSightNionMessage = 0
local sightNionOnlineNum = false
local sightnionConversationFromChat = false
local nionPmList = false
local pmIcon = false
local incomingNoti = false
addEvent("openSightNion", false)
addEventHandler("openSightNion", getRootElement(), function()
	switchAppScreen("sightnion")
end)
addEvent("openSightNionChat", false)
addEventHandler("openSightNionChat", getRootElement(), function()
	switchAppScreen("sightnion_chat")
end)
addEvent("openSightNionMarketplace", false)
addEventHandler("openSightNionMarketplace", getRootElement(), function()
	switchAppScreen("sightnion_marketplace")
end)
addEvent("openSightNionPMList", false)
addEventHandler("openSightNionPMList", getRootElement(), function()
	switchAppScreen("sightnion_pm_list")
end)
addEvent("openSightnionConversation", false)
addEventHandler("openSightnionConversation", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
	if nionPmList then
		sightNionCurrentPM = id
		switchAppScreen("sightnion_pm")
	end
end)
addEvent("openSightnionConversationFromChat", false)
addEventHandler("openSightnionConversationFromChat", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
	if sightNionConnected and id ~= sightNionConnected then
		sightnionConversationFromChat = true
		sightNionCurrentPM = id
		switchAppScreen("sightnion_pm")
	end
end)
local sightNionMaxScroll = 0
local sightNionScroll = 0
local loadingSightNionMessages = false
local cachedSightNionMessages = {}
local currentSightNionMessages = {}
function loadSightNionChatMessages(id, num, skipProc)
	local requestFromServer = {}
	local fromCache = false
	for i = id, id - num, -1 do
		if i < firstSightNionMessage or i < 1 then
			break
		end
		if cachedSightNionMessages[i] then
			local k = #currentSightNionMessages + 1
			for j = 1, #currentSightNionMessages do
				if i == currentSightNionMessages[j][4] then
					k = false
					break
				elseif i > currentSightNionMessages[j][4] then
					k = j
					break
				end
			end
			if k then
				table.insert(currentSightNionMessages, k, cachedSightNionMessages[i])
				fromCache = true
			end
		else
			table.insert(requestFromServer, i)
		end
	end
	if 0 < #requestFromServer then
		loadingSightNionMessages = true
		triggerLatentServerEvent("requestSightNionMessages", localPlayer, requestFromServer)
		if not skipProc or fromCache then
			sightlangCondHandl0(true)
		end
	elseif fromCache then
		sightlangCondHandl0(true)
	end
end
addEvent("gotSightNionMessages", true)
addEventHandler("gotSightNionMessages", getRootElement(), function(data)
	if loadingSightNionMessages then
		sightlangCondHandl0(true)
	end
	loadingSightNionMessages = false
	if data then
		for i in pairs(data) do
			lastSightNionMessage = math.max(i, lastSightNionMessage)
			if not cachedSightNionMessages[i] then
				cachedSightNionMessages[i] = data[i]
				cachedSightNionMessages[i][4] = i
				local k = #currentSightNionMessages + 1
				for j = 1, #currentSightNionMessages do
					if i == currentSightNionMessages[j][4] then
						k = false
						break
					elseif i > currentSightNionMessages[j][4] then
						k = j
						break
					end
				end
				if k then
					table.insert(currentSightNionMessages, k, cachedSightNionMessages[i])
					sightlangCondHandl0(true)
				end
			end
		end
	end
end)
local currentMessageElements = {}
local nionLoader = false
local nionEndLabel = false
function deleteSightNionMessage(id)
	if firstSightNionMessage == id then
		firstSightNionMessage = false
	end
	if lastSightNionMessage == id then
		lastSightNionMessage = false
	end
	if sightNionConnected then
		for i = #currentSightNionMessages, 1, -1 do
			if currentSightNionMessages[i][4] == id then
				table.remove(currentSightNionMessages, i)
			end
		end
		if currentMessageElements[id] then
			local h = sightexports.sGui:getFontHeight("9/Ubuntu-R.ttf")
			local h2 = sightexports.sGui:getFontHeight("10/Ubuntu-L.ttf")
			local n = #currentMessageElements[id] - 2
			local sy = n * h2 + 8
			sightNionMaxScroll = sightNionMaxScroll - (sy + h + 8)
			for j = 1, #currentMessageElements[id] do
				if currentMessageElements[id][j] then
					sightexports.sGui:deleteGuiElement(currentMessageElements[id][j])
				end
			end
		end
		currentMessageElements[id] = nil
	end
	cachedSightNionMessages[id] = nil
end
addEvent("deleteSightNionMessage", true)
addEventHandler("deleteSightNionMessage", getRootElement(), function(id)
	if tonumber(id) then
		deleteSightNionMessage(id)
	elseif type(id) == "table" then
		for i = 1, #id do
			deleteSightNionMessage(id[i])
		end
	end
	if sightNionConnected then
		if not firstSightNionMessage then
			firstSightNionMessage = false
			for id in pairs(cachedSightNionMessages) do
				if not firstSightNionMessage or id < firstSightNionMessage then
					firstSightNionMessage = id
				end
			end
			if not firstSightNionMessage then
				firstSightNionMessage = 1
			end
		end
		if not lastSightNionMessage then
			lastSightNionMessage = 0
			for id in pairs(cachedSightNionMessages) do
				lastSightNionMessage = math.max(lastSightNionMessage, id)
			end
		end
		sightlangCondHandl0(true)
	end
end)
function waitAndProcessSightNionChatMessages()
	sightlangCondHandl0(false)
	if sightNionConnected or sightNionPmValid then
		processSightNionChatMessages()
	end
end
function processSightNionChatMessages()
	if 0 < sightNionMaxScroll and sightNionScroll > sightNionMaxScroll then
		sightNionScroll = sightNionMaxScroll
	end
	local perm
	local refreshOrders = false
	local lastY = bottomY + sightNionScroll - 6
	local h = sightexports.sGui:getFontHeight("9/Ubuntu-R.ttf")
	local h2 = sightexports.sGui:getFontHeight("10/Ubuntu-L.ttf")
	local l = false
	for i = 1, #currentSightNionMessages do
		local id = currentSightNionMessages[i][4]
		if currentMessageElements[id] then
			local n = #currentMessageElements[id] - 2
			local sy = n * h2 + 8
			lastY = lastY - sy - h - 8
			local y = lastY + 8 + h
			if y < topY then
				sy = sy - (topY - y)
				y = topY
			elseif y + sy > bottomY then
				sy = bottomY - y
			end
			if lastY + 8 + h < topY or lastY + 8 > bottomY then
				sightexports.sGui:setGuiRenderDisabled(currentMessageElements[id][2], true)
			else
				sightexports.sGui:setGuiRenderDisabled(currentMessageElements[id][2], false)
				sightexports.sGui:setGuiPosition(currentMessageElements[id][2], false, lastY + 8)
			end
			if sy <= 0 then
				sightexports.sGui:setGuiRenderDisabled(currentMessageElements[id][1], true)
				for j = 3, n + 2 do
					sightexports.sGui:setGuiRenderDisabled(currentMessageElements[id][j], true)
				end
			else
				sightexports.sGui:setGuiRenderDisabled(currentMessageElements[id][1], false)
				sightexports.sGui:setGuiPosition(currentMessageElements[id][1], false, y)
				sightexports.sGui:setGuiSize(currentMessageElements[id][1], false, sy)
				y = lastY + h + 8 + 4
				for j = 3, n + 2 do
					sightexports.sGui:setGuiPosition(currentMessageElements[id][j], false, y)
					sightexports.sGui:setGuiRenderDisabled(currentMessageElements[id][j], y + h2 < topY or y > bottomY)
					y = y + h2
				end
			end
		else
			local selfMsg = false
			if sightNionConnected then
				selfMsg = currentSightNionMessages[i][2] == sightNionConnected
			else
				selfMsg = currentSightNionMessages[i][2] ~= sightNionCurrentPM
			end
			currentMessageElements[id] = {}
			refreshOrders = true
			local lines = {}
			local text = split(currentSightNionMessages[i][1], " ")
			local textTmp = (text[1] or "") .. " "
			for j = 2, #text do
				local tw = sightexports.sGui:getTextWidthFont(textTmp .. text[j], "10/Ubuntu-L.ttf")
				if tw >= bsx - 32 - 8 then
					table.insert(lines, textTmp)
					textTmp = text[j]
				else
					textTmp = textTmp .. text[j] .. " "
				end
			end
			table.insert(lines, textTmp)
			local sy = #lines * h2 + 8
			sightNionMaxScroll = sightNionMaxScroll + sy + h + 8
			lastY = lastY - sy - h - 8
			local y = lastY + 8 + h
			local x = selfMsg and 20 or 8
			if y < topY then
				sy = sy - (topY - y)
				y = topY
			elseif y + sy > bottomY then
				sy = bottomY - y
			end
			local rect = sightexports.sGui:createGuiElement("rectangle", x, y, bsx - 32, math.max(0, sy), appInside)
			sightexports.sGui:setGuiBackground(rect, "solid", selfMsg and "#181818" or "#242424")
			if sightNionConnected then
				if perm == nil then
					perm = sightexports.sPermission:hasPermission(localPlayer, "delnion")
				end
				if perm then
					sightexports.sGui:setGuiHoverable(rect, true)
					sightexports.sGui:setClickEvent(rect, "openSightnionConversationFromChat")
					sightexports.sGui:setClickArgument(rect, currentSightNionMessages[i][2])
					sightexports.sGui:setGuiHover(rect, "none", false, false, true)
					sightexports.sGui:guiSetTooltip(rect, "Kattints a privát üzenetváltáshoz.\nÜzenet ID: " .. id)
				elseif not selfMsg then
					sightexports.sGui:setGuiHoverable(rect, true)
					sightexports.sGui:setClickEvent(rect, "openSightnionConversationFromChat")
					sightexports.sGui:setClickArgument(rect, currentSightNionMessages[i][2])
					sightexports.sGui:setGuiHover(rect, "none", false, false, true)
					sightexports.sGui:guiSetTooltip(rect, "Kattints a privát üzenetváltáshoz.")
				end
			end
			local time = getRealTime(currentSightNionMessages[i][3])
			local date = string.format("%02d. %02d. %02d. %02d:%02d:%02d", time.year - 100, time.month + 1, time.monthday, time.hour, time.minute, time.second)
			local label = sightexports.sGui:createGuiElement("label", x, lastY + 8, bsx - 32, h, appInside)
			sightexports.sGui:setLabelText(label, "Ano" .. currentSightNionMessages[i][2] .. ", " .. date)
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
			sightexports.sGui:setLabelColor(label, "#a8a8a8")
			sightexports.sGui:setLabelAlignment(label, selfMsg and "right" or "left", "center")
			sightexports.sGui:setGuiRenderDisabled(label, lastY + 8 + h < topY or lastY + 8 > bottomY)
			currentMessageElements[id] = {rect, label}
			y = lastY + h + 8 + 4
			for j = 1, #lines do
				local label = sightexports.sGui:createGuiElement("label", x + 4, y, bsx - 32 - 8, h2, appInside)
				sightexports.sGui:setLabelText(label, lines[j])
				sightexports.sGui:setLabelClip(label, true)
				sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
				sightexports.sGui:setLabelAlignment(label, "left", "center")
				sightexports.sGui:setGuiRenderDisabled(label, y + h2 < topY or y > bottomY)
				table.insert(currentMessageElements[id], label)
				y = y + h2
			end
		end
		if lastY < topY then
			l = i + 1
			break
		end
	end
	if l then
		for i = l, #currentSightNionMessages do
			local id = currentSightNionMessages[i][4]
			if currentMessageElements[id] then
				for j = 1, #currentMessageElements[id] do
					sightexports.sGui:setGuiRenderDisabled(currentMessageElements[id][j], true)
				end
			end
		end
	end
	local atEnd = lastY >= topY
	if atEnd then
		lastY = lastY - 16
		if sightNionConnected and not loadingSightNionMessages and 0 < #currentSightNionMessages then
			local lastId = currentSightNionMessages[#currentSightNionMessages][4]
			if lastId > firstSightNionMessage then
				loadSightNionChatMessages(lastId - 1, 5, true)
			end
		end
		if loadingSightNionMessages then
			if nionEndLabel then
				sightexports.sGui:setGuiRenderDisabled(nionEndLabel, true)
			end
			if nionLoader then
				sightexports.sGui:setGuiPosition(nionLoader, false, lastY)
				sightexports.sGui:setGuiRenderDisabled(nionLoader, false, true)
			else
				refreshOrders = true
				nionLoader = sightexports.sGui:createGuiElement("null", 8, lastY, bsx - 20, 16, appInside)
				local tw = sightexports.sGui:getTextWidthFont("Üzenetek betöltése ", "9/Ubuntu-R.ttf")
				local loaderIcon = sightexports.sGui:createGuiElement("image", (bsx - 20) / 2 - (tw + 16) / 2 + tw, 0, 16, 16, nionLoader)
				sightexports.sGui:setImageFile(loaderIcon, sightexports.sGui:getFaIconFilename("circle-notch", 16))
				sightexports.sGui:setImageSpinner(loaderIcon, true)
				local label = sightexports.sGui:createGuiElement("label", (bsx - 20) / 2 - (tw + 16) / 2, 0, 0, 16, nionLoader)
				sightexports.sGui:setLabelText(label, "Üzenetek betöltése")
				sightexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
				sightexports.sGui:setLabelAlignment(label, "left", "center")
			end
		else
			if nionLoader then
				sightexports.sGui:deleteGuiElement(nionLoader)
			end
			nionLoader = nil
			if 0 < #currentSightNionMessages then
				if nionEndLabel then
					sightexports.sGui:setGuiPosition(nionEndLabel, false, lastY)
					sightexports.sGui:setGuiRenderDisabled(nionEndLabel, false)
				else
					refreshOrders = true
					nionEndLabel = sightexports.sGui:createGuiElement("label", 8, lastY, bsx - 20, 16, appInside)
					sightexports.sGui:setLabelText(nionEndLabel, "Az üzenetváltás végére értél.")
					sightexports.sGui:setLabelFont(nionEndLabel, "10/Ubuntu-LI.ttf")
					sightexports.sGui:setLabelAlignment(nionEndLabel, "center", "center")
					sightexports.sGui:setLabelColor(nionEndLabel, "#a8a8a8")
				end
			elseif nionEndLabel then
				sightexports.sGui:setGuiRenderDisabled(nionEndLabel, true)
			end
		end
	else
		if nionLoader then
			sightexports.sGui:setGuiRenderDisabled(nionLoader, true, true)
		end
		if nionEndLabel then
			sightexports.sGui:setGuiRenderDisabled(nionEndLabel, true)
		end
	end
	if sightNionPmValid then
		if currentSightNionMessages[#currentSightNionMessages] then
			local now = getRealTime().timestamp
			local ts = currentSightNionMessages[#currentSightNionMessages][3]
			local delta = math.max(0, 24 - math.floor((now - ts) / 3600))
			sightexports.sGui:setLabelText(nionStatusLabel, "Eltűnő üzenet (" .. delta .. "h)")
		else
			sightexports.sGui:setLabelText(nionStatusLabel, "Eltűnő üzenet")
		end
	end
	if refreshOrders then
		sightexports.sGui:guiToFront(sightNionTopRect)
		sightexports.sGui:guiToFront(sightNionInputRect)
		bringBackFront()
	end
	local h = bottomY - topY
	local div = math.min(1, h / math.max(1, sightNionMaxScroll + h))
	local progress = 1 - sightNionScroll / sightNionMaxScroll
	local sh = sightNionSh * div
	sightexports.sGui:setGuiSize(nionScrollBar, false, sh)
	sightexports.sGui:setGuiPosition(nionScrollBar, false, (sightNionSh - sh) * progress)
end
local mainInputFrozen = false
local pmInputFrozen = false
local mainInputFrozenVal = false
local pmInputFrozenVal = false
function processFrozenInput()
	if mainInputFrozen then
		local tmp = 15000 - (getTickCount() - mainInputFrozen)
		if sightNionConnected then
			if tmp < 0 then
				mainInputFrozen = false
				tmp = false
			else
				tmp = math.ceil(tmp / 1000)
			end
			if tmp ~= mainInputFrozenVal then
				mainInputFrozenVal = tmp
				sightexports.sGui:setInputPlaceholder(sightNionInput, mainInputFrozen and "Kérlek várj! (" .. tmp .. ")" or "Üzenet")
				sightexports.sGui:setElementDisabled(sightNionInput, mainInputFrozen and true or false)
				if mainInputFrozen and sightexports.sGui:getActiveInput() == sightNionInput then
					sightexports.sGui:setActiveInput(false)
				end
			end
		elseif tmp < 0 then
			mainInputFrozen = false
		end
	end
	if pmInputFrozen then
		local tmp = 3000 - (getTickCount() - pmInputFrozen)
		if sightNionCurrentPM then
			if tmp < 0 then
				pmInputFrozen = false
				tmp = false
			else
				tmp = math.ceil(tmp / 1000)
			end
			if tmp ~= pmInputFrozenVal then
				pmInputFrozenVal = tmp
				sightexports.sGui:setInputPlaceholder(sightNionInput, pmInputFrozen and "Kérlek várj! (" .. tmp .. ")" or "Üzenet")
				sightexports.sGui:setElementDisabled(sightNionInput, pmInputFrozen and true or false)
				if pmInputFrozen and sightexports.sGui:getActiveInput() == sightNionInput then
					sightexports.sGui:setActiveInput(false)
				end
			end
		elseif tmp < 0 then
			pmInputFrozen = false
		end
	end
	if not mainInputFrozen and not pmInputFrozen then
		sightlangCondHandl1(false)
	end
end
function sightNionChatKey(key, por)
	if nionPmList then
		if not pmListLoading then
			if key == "mouse_wheel_down" then
				if sightNionScroll < #nionPmList - 8 then
					sightNionScroll = sightNionScroll + 1
					refreshPmListScroll()
				end
			elseif key == "mouse_wheel_up" and 0 < sightNionScroll then
				sightNionScroll = sightNionScroll - 1
				refreshPmListScroll()
			end
		end
	elseif key == "mouse_wheel_down" then
		if 0 < sightNionScroll then
			sightNionScroll = sightNionScroll - 24
			if sightNionScroll < 0 then
				sightNionScroll = 0
			end
			processSightNionChatMessages()
		end
	elseif key == "mouse_wheel_up" then
		if sightNionScroll < sightNionMaxScroll then
			sightNionScroll = sightNionScroll + 24
			if sightNionScroll > sightNionMaxScroll then
				sightNionScroll = sightNionMaxScroll
			end
			processSightNionChatMessages()
		end
	elseif (key == "enter" or key == "num_enter") and por then
		local text = sightexports.sGui:getInputValue(sightNionInput)
		if text and 0 < utf8.len(text) and utf8.len(text) <= 200 then
			if sightNionConnected then
				if mainInputFrozen then
					return
				end
				mainInputFrozen = getTickCount()
				mainInputFrozenVal = false
				sightlangCondHandl1(true)
				triggerServerEvent("sendSightNionChatMessage", localPlayer, text)
			elseif sightNionPmValid then
				if pmInputFrozen then
					return
				end
				pmInputFrozen = getTickCount()
				pmInputFrozenVal = false
				sightlangCondHandl1(true)
				triggerServerEvent("sendSightNionPMMessage", localPlayer, sightNionCurrentPM, text)
			end
			sightexports.sGui:resetInput(sightNionInput)
			sightexports.sGui:setActiveInput(false)
		end
	end
end
function waitThenLoad()
	if not sightNionConnected then
		sightlangCondHandl2(false)
		return
	end
	if not loadingSightNionMessages then
		loadSightNionChatMessages(lastSightNionMessage, 10)
		sightlangCondHandl2(false)
	end
end
addEvent("gotSightNionConnected", true)
addEventHandler("gotSightNionConnected", getRootElement(), function(id, lastMessage, firstMessage)
	if currentPhoneScreen == "sightnion" then
		sightexports.sGui:setImageFile(pmIcon, sightexports.sGui:getFaIconFilename("envelope", 32, incomingNoti and "solid" or "regular"))
		sightNionConnected = id
		firstSightNionMessage = firstMessage
		lastSightNionMessage = lastMessage
		sightlangCondHandl2(true)
		if sightNionOnlineNum then
			sightexports.sGui:setLabelText(nionStatusLabel, "Ano" .. sightNionConnected .. " | Online: " .. sightNionOnlineNum)
		else
			sightexports.sGui:setLabelText(nionStatusLabel, "Ano" .. sightNionConnected)
		end
		if sightNionConnected then
			sightexports.sGui:setInputPlaceholder(sightNionInput, "Üzenet")
			sightexports.sGui:setElementDisabled(sightNionInput, false)
			mainInputFrozenVal = false
			pmInputFrozenVal = false
		end
	end
end)
addEvent("gotSightNionOnlineNum", true)
addEventHandler("gotSightNionOnlineNum", getRootElement(), function(num)
	sightNionOnlineNum = num
	if sightNionConnected then
		sightexports.sGui:setLabelText(nionStatusLabel, "Ano" .. sightNionConnected .. " | Online: " .. sightNionOnlineNum)
	end
end)
function appCloses.sightnion()
	inputRectSize = false
	bottomY = false
	topY = false
	sightNionTopRect = false
	sightNionInputRect = false
	nionStatusLabel = false
	pmIcon = false
	sightNionInput = false
	nionScrollBar = false
	sightNionConnected = false
	sightNionOnlineNum = false
	sightNionSh = false
	nionLoader = false
	nionEndLabel = false
	currentSightNionMessages = {}
	currentMessageElements = {}
	mainInputFrozenVal = false
	pmInputFrozenVal = false
	removeEventHandler("onClientKey", getRootElement(), sightNionChatKey)
	triggerServerEvent("disconnectFromSightNion", localPlayer)
end
function appScreens.sightnion()
	sightNionScroll = 0
	addEventHandler("onClientKey", getRootElement(), sightNionChatKey)
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", "#353535")
	sightNionTopRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightexports.sGui:setGuiBackground(sightNionTopRect, "solid", {
		0,
		0,
		0
	})
	
	local label = sightexports.sGui:createGuiElement("label", 8, topSize, bsx, 32, sightNionTopRect)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelColor(label, "#ffffff")
	sightexports.sGui:setLabelText(label, "SightNion Homepage")
	local h2 = topSize * 1.5 + 32
	local h = sightexports.sGui:getFontHeight("9/Ubuntu-R.ttf") + 1
	
	local chatButton = sightexports.sGui:createGuiElement("rectangle", 7.5, topSize + 35, bsx - 15, 35, appInside)
	sightexports.sGui:setGuiBackground(chatButton, "solid", {0, 0, 0})
	sightexports.sGui:setGuiHoverable(chatButton, true, 0)
	sightexports.sGui:setGuiHover(chatButton, "none", false, false, true)
	sightexports.sGui:setClickEvent(chatButton, "openSightNionChat")
	
	local chatText = sightexports.sGui:createGuiElement("label", 0, 0, bsx - 15, 35, chatButton)
	sightexports.sGui:setLabelFont(chatText, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(chatText, "center", "center")
	sightexports.sGui:setLabelColor(chatText, "#ffffff")
	sightexports.sGui:setLabelText(chatText, "SightNion Chat")
	
	local w = sightexports.sGui:getTextWidthFont("SightNion Chat", "10/Ubuntu-L.ttf")
	local chatIcon = sightexports.sGui:createGuiElement("image", (bsx - 15) / 2 - (28) - (w / 2), 35 / 2 - 25 / 2, 25, 25, chatButton)
	sightexports.sGui:setImageFile(chatIcon, sightexports.sGui:getFaIconFilename("comments-alt", 25, "solid"))
	sightexports.sGui:setImageColor(chatIcon, "#ffffff")
	sightexports.sGui:setGuiHoverable(chatIcon, true)
	
	local marketPlace = sightexports.sGui:createGuiElement("rectangle", 7.5, topSize + 35 + 39, bsx - 15, 35, appInside)
	sightexports.sGui:setGuiBackground(marketPlace, "solid", {0, 0, 0})
	sightexports.sGui:setGuiHoverable(marketPlace, true, 0)
	sightexports.sGui:setGuiHover(marketPlace, "none", false, false, true)
	sightexports.sGui:setClickEvent(marketPlace, "openSightNionMarketplace")
	
	local marketText = sightexports.sGui:createGuiElement("label", 0, 0, bsx - 15, 35, marketPlace)
	sightexports.sGui:setLabelFont(marketText, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(marketText, "center", "center")
	sightexports.sGui:setLabelColor(marketText, "#ffffff")
	sightexports.sGui:setLabelText(marketText, "SightNion Market")
	
	local w = sightexports.sGui:getTextWidthFont("SightNion Market", "10/Ubuntu-L.ttf")
	local marketIcon = sightexports.sGui:createGuiElement("image", (bsx - 15) / 2 - (28) - (w / 2), 35 / 2 - 25 / 2, 25, 25, marketPlace)
	sightexports.sGui:setImageFile(marketIcon, sightexports.sGui:getFaIconFilename("store", 25, "solid"))
	sightexports.sGui:setImageColor(marketIcon, "#ffffff")
	
	generateBottom(true)
	bringBackFront()
end

function appCloses.sightnion_chat()
	inputRectSize = false
	bottomY = false
	topY = false
	sightNionTopRect = false
	sightNionInputRect = false
	nionStatusLabel = false
	pmIcon = false
	sightNionInput = false
	nionScrollBar = false
	sightNionConnected = false
	sightNionOnlineNum = false
	sightNionSh = false
	nionLoader = false
	nionEndLabel = false
	currentSightNionMessages = {}
	currentMessageElements = {}
	mainInputFrozenVal = false
	pmInputFrozenVal = false
	removeEventHandler("onClientKey", getRootElement(), sightNionChatKey)
	triggerServerEvent("disconnectFromSightNion", localPlayer)
end
function appScreens.sightnion_chat()
	sightNionScroll = 0
	addEventHandler("onClientKey", getRootElement(), sightNionChatKey)
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", "#353535")
	sightNionTopRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightexports.sGui:setGuiBackground(sightNionTopRect, "solid", {
		0,
		0,
		0
	})
	
	local label = sightexports.sGui:createGuiElement("label", 8, topSize, bsx, 32, sightNionTopRect)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelColor(label, "#ffffff")
	sightexports.sGui:setLabelText(label, "SightNion Chat")
	local h2 = topSize * 1.5 + 32
	local h = sightexports.sGui:getFontHeight("9/Ubuntu-R.ttf") + 1
	
	pmIcon = sightexports.sGui:createGuiElement("image", bsx - 32 - 4, topSize, 32, 32, sightNionTopRect)
	sightexports.sGui:setImageFile(pmIcon, sightexports.sGui:getFaIconFilename("envelope", 32, "regular"))
	sightexports.sGui:setImageColor(pmIcon, "#ffffff")
	sightexports.sGui:setGuiHoverable(pmIcon, true)
	sightexports.sGui:setClickEvent(pmIcon, "openSightNionPMList")
	
	inputRectSize = h + h2 + 4 - topSize * 1.5
	sightNionInputRect = sightexports.sGui:createGuiElement("rectangle", 0, bsy - h2 - h - 4, bsx, inputRectSize, appInside)
	sightexports.sGui:setGuiBackground(sightNionInputRect, "solid", "#353535")
	local border = sightexports.sGui:createGuiElement("hr", 0, -1, bsx, 1, sightNionInputRect)
	sightexports.sGui:setGuiHrColor(border, "#555555", "#555555")
	nionStatusLabel = sightexports.sGui:createGuiElement("label", 0, 0, bsx - 8, h - 1, sightNionInputRect)
	sightexports.sGui:setLabelFont(nionStatusLabel, "9/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(nionStatusLabel, "right", "bottom")
	sightexports.sGui:setLabelColor(nionStatusLabel, "#a8a8a8")
	sightexports.sGui:setLabelText(nionStatusLabel, "Nincs csatlakozva")
	sightNionInput = sightexports.sGui:createGuiElement("input", 8, h, bsx - 16, 32, sightNionInputRect)
	sightexports.sGui:setInputColor(sightNionInput, grey1, "#232323", "#ffffff", "#232323", "#ffffff")
	sightexports.sGui:setInputFont(sightNionInput, "11/Ubuntu-R.ttf")
	sightexports.sGui:setInputMaxLength(sightNionInput, 200)
	sightexports.sGui:setInputBorderSize(sightNionInput, 0.5)
	sightexports.sGui:setInputMultiline(sightNionInput, true)
	sightexports.sGui:setInputFontPaddingHeight(sightNionInput, 32)
	sightexports.sGui:setInputPlaceholder(sightNionInput, "Nincs csatlakozva")
	sightexports.sGui:setElementDisabled(sightNionInput, true)
	local y = topSize + 32 + 4
	sightNionSh = bsy - topSize * 2.5 - 32 - 8 - inputRectSize - 2
	local nionScrollBarBcg = sightexports.sGui:createGuiElement("rectangle", bsx - 9, y, 3, sightNionSh, appInside)
	sightexports.sGui:setGuiBackground(nionScrollBarBcg, "solid", "#444444")
	nionScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 3, sightNionSh, nionScrollBarBcg)
	sightexports.sGui:setGuiBackground(nionScrollBar, "solid", "#181818")
	bottomY = bsy - (inputRectSize + topSize * 1.5)
	topY = 32 + topSize
	sightNionMaxScroll = 32 - (bottomY - topY)
	
	generateBottom(true, "openSightNion")
	bringBackFront()
	triggerServerEvent("connectToSightNion", localPlayer)
end
addEvent("deleteSightNionConversation", true)
addEventHandler("deleteSightNionConversation", getRootElement(), function(id)
	if fileExists("nionpm/" .. id .. ".sight") then
		fileDelete("nionpm/" .. id .. ".sight")
	end
	if sightNionCurrentPM == id and sightNionPmValid then
		currentSightNionMessages = {}
		for id, dat in pairs(currentMessageElements) do
			for i = 1, #dat do
				if dat[i] then
					sightexports.sGui:deleteGuiElement(dat[i])
				end
			end
		end
		currentMessageElements = {}
		sightlangCondHandl0(true)
	end
	if nionPmList then
		local pid = false
		for i = #nionPmList, 1, -1 do
			if nionPmList[i][1] == id then
				table.remove(nionPmList, i)
			end
		end
		sightlangCondHandl3(true)
	end
end)
addEvent("gotSightNionPMMessage", true)
addEventHandler("gotSightNionPMMessage", getRootElement(), function(id, sender, text, ts)
	text = text:gsub("\n", " ")
	if sightNionCurrentPM == id and sightNionPmValid then
		local mid = #currentSightNionMessages + 1
		table.insert(currentSightNionMessages, 1, {
			text,
			sender,
			ts,
			mid
		})
		sightlangCondHandl0(true)
	elseif sender == id then
		incomingNoti = true
		if sightNionConnected then
			sightexports.sGui:setImageFile(pmIcon, sightexports.sGui:getFaIconFilename("envelope", 32, incomingNoti and "solid" or "regular"))
		end
	end
	if nionPmList then
		local pid = false
		for i = 1, #nionPmList do
			if nionPmList[i][1] == id then
				pid = i
				break
			end
		end
		if not pid then
			pid = 1
			table.insert(nionPmList, 1, {sender})
		end
		local time = getRealTime(ts)
		nionPmList[pid][2] = string.format("%02d. %02d. %02d. %02d:%02d", time.year - 100, time.month + 1, time.monthday, time.hour, time.minute)
		nionPmList[pid][3] = text
		nionPmList[pid][4] = sender == id
		sightlangCondHandl3(true)
	end
	local file
	if fileExists("nionpm/" .. id .. ".sight") then
		file = fileOpen("nionpm/" .. id .. ".sight")
		fileSetPos(file, fileGetSize(file))
	else
		file = fileCreate("nionpm/" .. id .. ".sight")
		if file then
			local lf = false
			if fileExists("nionpm/list.sight") then
				lf = fileOpen("nionpm/list.sight")
				fileSetPos(lf, fileGetSize(lf))
			else
				lf = fileCreate("nionpm/list.sight")
			end
			if lf then
				fileWrite(lf, id .. "\n")
				fileClose(lf)
			end
		end
	end
	if file then
		fileWrite(file, sender .. "#" .. ts .. "#" .. text .. "\n")
		fileClose(file)
	end
end)
function checkPmFiles()
	if fileExists("nionpm/list.sight") then
		local file = fileOpen("nionpm/list.sight")
		if file then
			local data = fileRead(file, fileGetSize(file))
			fileClose(file)
			fileDelete("nionpm/list.sight")
			local newFile = fileCreate("nionpm/list.sight")
			data = split(data, "\n")
			local tmp = {}
			for i = 1, #data do
				local id = tonumber(data[i])
				if fileExists("nionpm/" .. id .. ".sight") and not tmp[id] then
					fileWrite(newFile, id .. "\n")
					tmp[id] = true
				end
			end
			fileClose(newFile)
		end
	end
end
checkPmFiles()
local waitingForValidation = false
addEvent("gotSightNionPMValidation", true)
addEventHandler("gotSightNionPMValidation", getRootElement(), function(id, valid, keep, cache)
	waitingForValidation = false
	if sightNionCurrentPM == id then
		if valid then
			sightNionPmValid = true
			if keep then
				if fileExists("nionpm/" .. id .. ".sight") then
					local file = fileOpen("nionpm/" .. id .. ".sight")
					if file then
						local dat = fileRead(file, fileGetSize(file))
						dat = split(dat, "\n")
						for i = 1, #dat do
							local msg = split(dat[i], "#")
							local sender = tonumber(msg[1])
							table.remove(msg, 1)
							if sender then
								local ts = tonumber(msg[1])
								table.remove(msg, 1)
								local text = table.concat(msg, "#")
								local mid = #currentSightNionMessages + 1
								table.insert(currentSightNionMessages, 1, {
									text,
									sender,
									ts,
									mid
								})
								sightlangCondHandl0(true)
							end
						end
						fileClose(file)
					end
				end
			elseif fileExists("nionpm/" .. id .. ".sight") then
				fileDelete("nionpm/" .. id .. ".sight")
			end
			if cache then
				for i = 1, #cache do
					local sender, text, ts = unpack(cache[i])
					local mid = #currentSightNionMessages + 1
					table.insert(currentSightNionMessages, 1, {
						text,
						sender,
						ts,
						mid
					})
				end
				local file
				if fileExists("nionpm/" .. id .. ".sight") then
					file = fileOpen("nionpm/" .. id .. ".sight")
					fileSetPos(file, fileGetSize(file))
				else
					file = fileCreate("nionpm/" .. id .. ".sight")
					if file then
						local lf = false
						if fileExists("nionpm/list.sight") then
							lf = fileOpen("nionpm/list.sight")
							fileSetPos(lf, fileGetSize(lf))
						else
							lf = fileCreate("nionpm/list.sight")
						end
						if lf then
							fileWrite(lf, id .. "\n")
							fileClose(lf)
						end
					end
				end
				if file then
					for i = 1, #cache do
						local sender, text, ts = unpack(cache[i])
						fileWrite(file, sender .. "#" .. ts .. "#" .. text .. "\n")
					end
					fileClose(file)
				end
			end
			sightexports.sGui:setInputPlaceholder(sightNionInput, "Üzenet")
			sightexports.sGui:setElementDisabled(sightNionInput, false)
		else
			switchAppScreen("sightnion")
		end
	end
end)
function appCloses.sightnion_pm()
	inputRectSize = false
	bottomY = false
	topY = false
	sightNionTopRect = false
	sightNionInputRect = false
	nionStatusLabel = false
	sightNionInput = false
	nionScrollBar = false
	sightNionSh = false
	nionLoader = false
	nionEndLabel = false
	currentSightNionMessages = {}
	currentMessageElements = {}
	mainInputFrozenVal = false
	pmInputFrozenVal = false
	sightNionCurrentPM = false
	sightNionPmValid = false
	removeEventHandler("onClientKey", getRootElement(), sightNionChatKey)
end
function waitAndValidatePm()
	if not waitingForValidation then
		if sightNionCurrentPM and not sightNionPmValid then
			waitingForValidation = true
			triggerLatentServerEvent("validateSightNionPM", localPlayer, sightNionCurrentPM)
		end
		sightlangCondHandl4(false)
	end
end
function appScreens.sightnion_pm()
	sightNionScroll = 0
	addEventHandler("onClientKey", getRootElement(), sightNionChatKey)
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", "#353535")
	sightNionTopRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightexports.sGui:setGuiBackground(sightNionTopRect, "solid", {
		0,
		0,
		0
	})
	local label = sightexports.sGui:createGuiElement("label", 8, topSize, bsx, 32, sightNionTopRect)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelColor(label, "#ffffff")
	sightexports.sGui:setLabelText(label, "Ano" .. sightNionCurrentPM)
	local h2 = topSize * 1.5 + 32
	local h = sightexports.sGui:getFontHeight("9/Ubuntu-R.ttf") + 1
	inputRectSize = h + h2 + 4 - topSize * 1.5
	sightNionInputRect = sightexports.sGui:createGuiElement("rectangle", 0, bsy - h2 - h - 4, bsx, inputRectSize, appInside)
	sightexports.sGui:setGuiBackground(sightNionInputRect, "solid", "#353535")
	local border = sightexports.sGui:createGuiElement("hr", 0, -1, bsx, 1, sightNionInputRect)
	sightexports.sGui:setGuiHrColor(border, "#555555", "#555555")
	nionStatusLabel = sightexports.sGui:createGuiElement("label", 0, 0, bsx - 8, h - 1, sightNionInputRect)
	sightexports.sGui:setLabelFont(nionStatusLabel, "9/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(nionStatusLabel, "right", "bottom")
	sightexports.sGui:setLabelColor(nionStatusLabel, "#a8a8a8")
	sightexports.sGui:setLabelText(nionStatusLabel, "Eltűnő üzenet")
	sightNionInput = sightexports.sGui:createGuiElement("input", 8, h, bsx - 16, 32, sightNionInputRect)
	sightexports.sGui:setInputColor(sightNionInput, grey1, "#232323", "#ffffff", "#232323", "#ffffff")
	sightexports.sGui:setInputFont(sightNionInput, "11/Ubuntu-R.ttf")
	sightexports.sGui:setInputMaxLength(sightNionInput, 200)
	sightexports.sGui:setInputBorderSize(sightNionInput, 0.5)
	sightexports.sGui:setInputMultiline(sightNionInput, true)
	sightexports.sGui:setInputFontPaddingHeight(sightNionInput, 32)
	sightexports.sGui:setInputPlaceholder(sightNionInput, "Betöltés folyamatban...")
	sightexports.sGui:setElementDisabled(sightNionInput, true)
	local y = topSize + 32 + 4
	sightNionSh = bsy - topSize * 2.5 - 32 - 8 - inputRectSize - 2
	local nionScrollBarBcg = sightexports.sGui:createGuiElement("rectangle", bsx - 9, y, 3, sightNionSh, appInside)
	sightexports.sGui:setGuiBackground(nionScrollBarBcg, "solid", "#444444")
	nionScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 3, sightNionSh, nionScrollBarBcg)
	sightexports.sGui:setGuiBackground(nionScrollBar, "solid", "#181818")
	bottomY = bsy - (inputRectSize + topSize * 1.5)
	topY = 32 + topSize
	sightNionMaxScroll = 32 - (bottomY - topY)
	if sightnionConversationFromChat then
		sightnionConversationFromChat = false
		generateBottom(true, "openSightNionChat")
	else
		generateBottom(true, "openSightNionPMList")
	end
	bringBackFront()
	sightNionPmValid = false
	sightlangCondHandl4(true)
end
local pmListLoading = false
function sortPmList(a, b)
	return a[2] > b[2]
end
local pmIH = false
local nionPmElements = {}
function refreshPmListScroll()
	local oneFileLoaded = false
	if sightNionScroll > math.max(0, #nionPmList - 8) then
		sightNionScroll = math.max(0, #nionPmList - 8)
	end
	for i = 1, 8 do
		local k = i + sightNionScroll
		if nionPmList[k] then
			sightexports.sGui:setGuiRenderDisabled(nionPmElements[i][1], false)
			sightexports.sGui:setGuiRenderDisabled(nionPmElements[i][2], false)
			sightexports.sGui:setGuiRenderDisabled(nionPmElements[i][3], false)
			if nionPmElements[i][6] then
				sightexports.sGui:setGuiRenderDisabled(nionPmElements[i][6], false)
			end
			sightexports.sGui:setClickArgument(nionPmElements[i][1], nionPmList[k][1])
			sightexports.sGui:setLabelText(nionPmElements[i][2], "Ano" .. nionPmList[k][1])
			sightexports.sGui:setLabelText(nionPmElements[i][3], nionPmList[k][2])
			if type(nionPmList[k][3]) == "nil" then
				if oneFileLoaded then
					sightlangCondHandl3(true)
				else
					nionPmList[k][3] = false
					if fileExists("nionpm/" .. nionPmList[k][1] .. ".sight") then
						oneFileLoaded = true
						local file = fileOpen("nionpm/" .. nionPmList[k][1] .. ".sight")
						local dat = ""
						local pos = fileGetSize(file) - 2
						while 0 <= pos do
							fileSetPos(file, pos)
							local char = fileRead(file, 1)
							pos = pos - 1
							dat = char .. dat
							if char == "\n" then
								break
							end
						end
						fileClose(file)
						local msg = split(dat, "#")
						local sender = tonumber(msg[1])
						table.remove(msg, 1)
						if sender then
							local ts = tonumber(msg[1])
							table.remove(msg, 1)
							local text = table.concat(msg, "#")
							if utf8.len(text) > 24 then
								text = utf8.sub(text, 1, 21) .. "..."
							end
							nionPmList[k][3] = text
							nionPmList[k][4] = sender == nionPmList[k][1]
						end
					end
				end
			end
			if nionPmList[k][3] then
				sightexports.sGui:setGuiRenderDisabled(nionPmElements[i][4], false)
				sightexports.sGui:setGuiRenderDisabled(nionPmElements[i][5], false)
				sightexports.sGui:setLabelText(nionPmElements[i][5], nionPmList[k][3])
				sightexports.sGui:setGuiSize(nionPmElements[i][4], pmIH / 2 * (nionPmList[k][4] and -1 or 1), false)
				sightexports.sGui:setGuiPosition(nionPmElements[i][4], pmIH / 2 * (nionPmList[k][4] and 1 or 0), false)
			else
				sightexports.sGui:setGuiRenderDisabled(nionPmElements[i][4], true)
				sightexports.sGui:setGuiRenderDisabled(nionPmElements[i][5], true)
			end
		else
			for j = 1, #nionPmElements[i] do
				sightexports.sGui:setGuiRenderDisabled(nionPmElements[i][j], true)
			end
		end
	end
	local sh = sightNionSh / math.max(1, #nionPmList - 8 + 1)
	sightexports.sGui:setGuiSize(nionScrollBar, false, sh)
	sightexports.sGui:setGuiPosition(nionScrollBar, false, sh * sightNionScroll)
end
function waitAndRefreshPmListScroll()
	sightlangCondHandl3(false)
	if nionPmList then
		refreshPmListScroll()
	end
end
addEvent("gotSightNionPmList", true)
addEventHandler("gotSightNionPmList", getRootElement(), function(data)
	pmListLoading = false
	if nionPmList then
		if data then
			nionPmList = data
			table.sort(nionPmList, sortPmList)
			local found = {}
			for i = 1, #nionPmList do
				found[nionPmList[i][1]] = true
				local time = getRealTime(nionPmList[i][2])
				nionPmList[i][2] = string.format("%02d. %02d. %02d. %02d:%02d", time.year - 100, time.month + 1, time.monthday, time.hour, time.minute)
			end
			if fileExists("nionpm/list.sight") then
				local file = fileOpen("nionpm/list.sight")
				if file then
					local data = fileRead(file, fileGetSize(file))
					fileClose(file)
					data = split(data, "\n")
					local tmp = {}
					for i = 1, #data do
						local id = tonumber(data[i])
						if not found[id] and fileExists("nionpm/" .. id .. ".sight") then
							fileDelete("nionpm/" .. id .. ".sight")
						end
					end
				end
			end
			sightlangCondHandl3(true)
		else
			data = {}
		end
	end
end)
function waitAndLoadPmList()
	if not pmListLoading then
		if nionPmList then
			pmListLoading = true
			triggerLatentServerEvent("requestSightNionPmList", localPlayer)
		end
		sightlangCondHandl5(false)
	end
end
function appCloses.sightnion_pm_list()
	sightNionScroll = false
	sightNionSh = false
	nionScrollBar = false
	nionPmList = false
	pmIH = false
	removeEventHandler("onClientKey", getRootElement(), sightNionChatKey)
end
function appScreens.sightnion_pm_list()
	incomingNoti = false
	sightNionScroll = 0
	addEventHandler("onClientKey", getRootElement(), sightNionChatKey)
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", "#353535")
	local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", {
		0,
		0,
		0
	})
	local label = sightexports.sGui:createGuiElement("label", 8, topSize, bsx, 32, rect)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelColor(label, "#ffffff")
	sightexports.sGui:setLabelText(label, "Privát beszélgetések")
	local h = bsy - topSize * 2.5 - 32
	local y = topSize + 32 + 4
	sightNionSh = h - 8
	local n = 8
	h = (h - 8) / n
	pmIH = h
	for i = 1, n do
		local y = y + h * (i - 1)
		nionPmElements[i] = {}
		local rect = sightexports.sGui:createGuiElement("rectangle", 8, y, bsx - 8 - 12, h, appInside)
		sightexports.sGui:setGuiHover(rect, "none", false, false, true)
		sightexports.sGui:setGuiHoverable(rect, true)
		sightexports.sGui:setClickEvent(rect, "openSightnionConversation")
		nionPmElements[i][1] = rect
		local label = sightexports.sGui:createGuiElement("label", 0, 0, bsx - 8 - 12, h / 2, rect)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelClip(label, true)
		nionPmElements[i][2] = label
		local label = sightexports.sGui:createGuiElement("label", 0, 0, bsx - 8 - 12, h / 2, rect)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-LI.ttf")
		sightexports.sGui:setLabelAlignment(label, "right", "center")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelClip(label, true)
		nionPmElements[i][3] = label
		local icon = sightexports.sGui:createGuiElement("image", 0, h / 2, h / 2, h / 2, rect)
		sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("reply", h / 2))
		nionPmElements[i][4] = icon
		local label = sightexports.sGui:createGuiElement("label", h / 2, h / 2, bsx - 8 - 12 - h / 2, h / 2, rect)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelClip(label, true)
		nionPmElements[i][5] = label
		if i < n then
			local border = sightexports.sGui:createGuiElement("hr", 0, h - 1, bsx - 8 - 12, 1, rect)
			sightexports.sGui:setGuiHrColor(border, "#222222", "#222222")
			nionPmElements[i][6] = border
		end
		if i == 1 then
			sightexports.sGui:setGuiRenderDisabled(rect, true, true)
			sightexports.sGui:setGuiRenderDisabled(nionPmElements[i][2], false)
			sightexports.sGui:setLabelText(nionPmElements[i][2], "Betöltés...")
		else
			sightexports.sGui:setGuiRenderDisabled(rect, true, true)
		end
	end
	local nionScrollBarBcg = sightexports.sGui:createGuiElement("rectangle", bsx - 9, y, 3, sightNionSh, appInside)
	sightexports.sGui:setGuiBackground(nionScrollBarBcg, "solid", "#444444")
	nionScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 3, sightNionSh, nionScrollBarBcg)
	sightexports.sGui:setGuiBackground(nionScrollBar, "solid", "#181818")
	generateBottom(true, "openSightNionChat")
	bringBackFront()
	nionPmList = {}
	sightlangCondHandl5(true)
end

local marketList = false
local marketListLoading = false
local marketNionScroll = 0
local marketNionSh = false
local marketScrollBar = false
local marketElements = {}

function waitAndLoadMarketList()
	if not marketListLoading then
		if marketList then
			marketListLoading = true
			setTimer(function()
				generateMarketRandomList()
				marketListLoading = false
			end, 500, 1)
			--triggerLatentServerEvent("requestSightNionPmList", localPlayer)
		end
		sightlangCondHandl6(false)
	end
end
function appCloses.sightnion_marketplace()
	removeEventHandler("onClientKey", getRootElement(), sightNionMarketKey)
	if isTimer(marketUpdateTimer) then killTimer(marketUpdateTimer) end
	marketList = false
	marketScrollBar = false
	marketNionScroll = 0
	marketNionSh = false
end

--531 - 12gauge, 532 .357 magn 533 4.6 534 .45 535 5.45 536 5.56 537 5.7 538 .50 539 7.62
local itemIds = {
	85, --Ak-47
	76, --colt1
	471, --colt3
	531, 
	532,
	533,
	534,
	535,
	536,
	537,
	538,
	539
}

local tickStart = getTickCount()

function generateMarketRandomList()
	for i = 1, 15 do
		local selectedItem = math.random(1, #itemIds)
		local name = exports.sItems:getItemName(itemIds[selectedItem])--itemNames[i]
		local price = math.random(5500, 250000)
		local expireTick = getTickCount() + (math.random(10000, 150000))
		table.insert(marketList, {
			name = name,
			price = string.format("%s$", tostring(price)),
			expireTick = expireTick,
			amount = math.random(1, 10),
			image = ":sItems/files/items/"..tostring((itemIds[selectedItem] - 1))..".png",
			id = i
		})
	end
end

function getFormattedTimeLeft(ms)
	local seconds = math.max(0, math.floor(ms / 1000))
	local minutes = math.floor(seconds / 60)
	local secs = seconds % 60
	return string.format("%02d:%02d", minutes, secs)
end

function refreshMarketListScroll()
	if marketListLoading then
		return
	end
	
	if marketList and type(marketList) == "table" then
		table.sort(marketList, function(a, b)
			local aLeft = a.expireTick - getTickCount()
			local bLeft = b.expireTick - getTickCount()
			if math.floor(aLeft / 1000) == math.floor(bLeft / 1000) then
				return a.id < b.id
			end
			return aLeft < bLeft
		end)
	end
	
	for i = 1, 10 do
		local k = i + marketNionScroll
		if marketList[k] then
			local data = marketList[k]
			local timeLeft = data.expireTick - getTickCount()
			local timeStr = getFormattedTimeLeft(timeLeft)
			sightexports.sGui:setImageFile(marketElements[i].image, data.image)
			sightexports.sGui:setLabelText(marketElements[i].amount, data.amount)
			sightexports.sGui:setLabelText(marketElements[i].name, data.name)
			sightexports.sGui:setLabelText(marketElements[i].price, sightexports.sGui:thousandsStepper(data.price))
			sightexports.sGui:setLabelText(marketElements[i].time, timeStr)
			if timeLeft < 60000 then
				sightexports.sGui:setLabelColor(marketElements[i].time, "sightred")
			else
				sightexports.sGui:setLabelColor(marketElements[i].time, "sighthudwhite")
			end
			sightexports.sGui:setGuiRenderDisabled(marketElements[i].container, false)
			sightexports.sGui:setClickArgument(marketElements[i].container, data.id)
			if marketElements[i].hr then
				sightexports.sGui:setGuiRenderDisabled(marketElements[i].hr, false)
				sightexports.sGui:guiToFront(marketElements[i].hr, true)
			end
		else
			sightexports.sGui:setGuiRenderDisabled(marketElements[i].container, true)
			if marketElements[i].hr then
				sightexports.sGui:setGuiRenderDisabled(marketElements[i].hr, true)
				sightexports.sGui:guiToFront(marketElements[i].hr, true)
			end
		end
	end
	local sh = marketNionSh / math.max(1, #marketList - 10 + 1)
	sightexports.sGui:setGuiSize(marketScrollBar, false, sh)
	sightexports.sGui:setGuiPosition(marketScrollBar, false, sh * marketNionScroll)
	sightexports.sGui:guiToFront(marketScrollBar, true)
end

local markerLoader = false

function appScreens.sightnion_marketplace()
	addEventHandler("onClientKey", getRootElement(), sightNionMarketKey)
	marketList = {}
	remainingTime = 0

	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local bg = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightexports.sGui:setGuiBackground(bg, "solid", "#353535")
	
	local topBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightexports.sGui:setGuiBackground(topBar, "solid", { 0, 0, 0 })
	
	local title = sightexports.sGui:createGuiElement("label", 8, topSize, bsx, 32, topBar)
	sightexports.sGui:setLabelFont(title, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(title, "left", "center")
	sightexports.sGui:setLabelColor(title, "sighthudwhite")
	sightexports.sGui:setLabelText(title, "SightNion Market")
	
	marketLoader = sightexports.sGui:createGuiElement("image", bsx / 2 - 12, bsy / 2 - 12, 24, 24, appInside)
	sightexports.sGui:setImageFile(marketLoader, sightexports.sGui:getFaIconFilename("circle-notch", 24))
	sightexports.sGui:setImageSpinner(marketLoader, true)
	
	if marketList then
		local h = bsy - topSize * 2.5 - 30
		local y = topSize + 32 + 4
		marketNionSh = h - 8
		local n = 10
		local itemSize = (h - 8) / n
		
		for i = 1, n do
			local offsetY = y + itemSize * (i - 1)
			marketElements[i] = {}
			
			local container = sightexports.sGui:createGuiElement("rectangle", 6, offsetY, bsx - 12, itemSize, appInside)
			sightexports.sGui:setGuiBackground(container, "solid", "#353535")
			sightexports.sGui:setGuiHoverable(container, true, 0)
			sightexports.sGui:setGuiHover(container, "none", false, false, true)
			sightexports.sGui:setClickArgument(container, i)
			sightexports.sGui:setClickEvent(container, "openMarketItem")
			marketElements[i].container = container
			
			local image = sightexports.sGui:createGuiElement("image", 2, 0, itemSize, itemSize, container)
			marketElements[i].image = image
			
			local amount = sightexports.sGui:createGuiElement("label", -1, 1, itemSize, itemSize, image)
			sightexports.sGui:setLabelColor(amount, "sighthudwhite")
			sightexports.sGui:setLabelAlignment(amount, "right", "bottom")
			sightexports.sGui:setLabelFont(amount, "8/Ubuntu-R.ttf")
			marketElements[i].amount = amount
			
			local name = sightexports.sGui:createGuiElement("label", itemSize + 8, 1, bsx - itemSize - 10, itemSize, container)
			sightexports.sGui:setLabelFont(name, "10/Ubuntu-B.ttf")
			sightexports.sGui:setLabelColor(name, "sighthudwhite")
			sightexports.sGui:setLabelAlignment(name, "left", "top")
			marketElements[i].name = name
			
			local price = sightexports.sGui:createGuiElement("label", itemSize + 8, itemSize - 20, bsx - itemSize - 10, itemSize, container)
			sightexports.sGui:setLabelFont(price, "10/Ubuntu-R.ttf")
			sightexports.sGui:setLabelColor(price, "sightgreen")
			sightexports.sGui:setLabelAlignment(price, "left", "top")
			marketElements[i].price = price
			
			local time = sightexports.sGui:createGuiElement("label", bsx - sightexports.sGui:getTextWidthFont("00:00", "13/BebasNeueBold.otf") - 17, 0, 75, itemSize, container)
			sightexports.sGui:setLabelFont(time, "13/BebasNeueBold.otf")
			sightexports.sGui:setLabelColor(time, "sighthudwhite")
			sightexports.sGui:setLabelAlignment(time, "left", "center")
			marketElements[i].time = time
			
			if i ~= 10 then
				local borderY = math.floor(offsetY + itemSize)
				local border = sightexports.sGui:createGuiElement("rectangle", 7, borderY, bsx - 12, 1, appInside)
				sightexports.sGui:setGuiBackground(border, "solid", "#555555")
				marketElements[i].hr = border
			end
		end
		
		local marketScrollBarBcg = sightexports.sGui:createGuiElement("rectangle", bsx - 7, y, 3, marketNionSh, appInside)
		sightexports.sGui:setGuiBackground(marketScrollBarBcg, "solid", "#444444")
		marketScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 3, 20, marketScrollBarBcg)
		sightexports.sGui:setGuiBackground(marketScrollBar, "solid", "#181818")
	end
	
	generateBottom(true, "openSightNion")
	bringBackFront()
	refreshMarketListScroll()
	
	nionPmList = {}
	sightlangCondHandl6(true)
	
	if isTimer(marketUpdateTimer) then killTimer(marketUpdateTimer) end
	marketUpdateTimer = setTimer(refreshMarketListScroll, 1000, 0)
end

local function findMarketDataWithId(marketIdentity)
	for marketIndex, marketData in pairs(marketList) do
		if marketData.id == marketIdentity then
			return marketData
		end
	end
	return false
end

addEvent("openMarketItem", false)
addEventHandler("openMarketItem", getRootElement(), function(_, _, _, _, _, marketIdentity)
	local marketData = findMarketDataWithId(marketIdentity)
	if marketData then
		appScreens.sightnion_marketitem(marketData)
	end
end)

local labelUpdateTimer = {}
local remainingTime = 0

function appCloses.sightnion_marketitem()
end

function appScreens.sightnion_marketitem(itemData)
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local bg = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightexports.sGui:setGuiBackground(bg, "solid", "#353535")
	
	local topBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightexports.sGui:setGuiBackground(topBar, "solid", { 0, 0, 0 })
	
	local title = sightexports.sGui:createGuiElement("label", 8, topSize, bsx, 32, topBar)
	sightexports.sGui:setLabelFont(title, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(title, "left", "center")
	sightexports.sGui:setLabelColor(title, "sighthudwhite")
	sightexports.sGui:setLabelText(title, "SightNion Market")

	local chatMessages = {
		{
			sender = "customer",
			message = "Üzenj, ha nálad van 1 db M4. Fizetek, 451 950 $ kézbe",
		},
		{
			sender = "customer",
			message = "Csak egyben és hibátlanul éri meg - neked is, nekem is.",
		}
	}

	local yOffset = 0
	for messageIndex, messageData in pairs(chatMessages) do
		data = split(messageData.message, " ")
	
		local lines = {}
		local text = data[1]
		for i = 2, #data do
			local w = sightexports.sGui:getTextWidthFont(text .. " " .. data[i], "10/Ubuntu-R.ttf")
			if w > bsx - 30 or data[i] == "\n" then
				table.insert(lines, text)
				if data[i] ~= "\n" then
					text = data[i]
				end
			else
				text = text .. " " .. data[i]
			end
		end
		table.insert(lines, text)

		local height = #lines * 19

		local container = sightexports.sGui:createGuiElement("rectangle", 9, 32 + topSize + 5 + yOffset, bsx - 30, height, appInside)
		sightexports.sGui:setGuiBackground(container, "solid", "#222222")

		local label = sightexports.sGui:createGuiElement("label", 5, 2, bsx - 40, 40, container)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(label, "left", "top")
		sightexports.sGui:setLabelColor(label, "hudwhite")
		sightexports.sGui:setLabelText(label, messageData.message)
		sightexports.sGui:setLabelWordBreak(label, true)

		yOffset = yOffset + height + 3
	end

	local button = sightexports.sGui:createGuiElement("rectangle", 9, 32 + topSize + 5 + yOffset, bsx - 18, 25, appInside)
	sightexports.sGui:setGuiBackground(button, "solid", "sightgreen")

	startJobLabel = sightexports.sGui:createGuiElement("label", 0, 0, bsx - 18, 25, button)
	sightexports.sGui:setLabelFont(startJobLabel, "11/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(startJobLabel, "center", "center")
	sightexports.sGui:setLabelColor(startJobLabel, "hudwhite")
	sightexports.sGui:setLabelText(startJobLabel, "Megbízás elvállalása (00:00)")

	remainingTime = itemData.expireTick
	refreshLabelTime()
	labelUpdateTimer = setTimer(refreshLabelTime, 1000, 0)

	generateBottom(true, "openSightNionMarketplace")
	bringBackFront()
end

function refreshLabelTime()
	if remainingTime and remainingTime ~= 0 then
		sightexports.sGui:setLabelText(startJobLabel, "Megbízás elvállalása ("..getFormattedTimeLeft(remainingTime - getTickCount())..")")
	end
end

function sightNionMarketKey(key)
	if not marketListLoading and marketList then
		if key == "mouse_wheel_down" then
			if marketNionScroll < #marketList - 10 then
				marketNionScroll = marketNionScroll + 1
				refreshMarketListScroll()
			end
		elseif key == "mouse_wheel_up" then
			if marketNionScroll > 0 then
				marketNionScroll = marketNionScroll - 1
				refreshMarketListScroll()
			end
		end
	end
end