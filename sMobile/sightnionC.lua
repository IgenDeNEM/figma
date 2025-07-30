local sightexports = {
	sGui = false,
	sPermission = false,
	sDealer = false,
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
local r8_0 = false
local function r9_0(r0_5, r1_5)
	-- line: [1, 1] id: 5
	if r0_5 then
		r0_5 = true or false
	else
		--goto label_5	-- block#2 is visited secondly
	end
	if r0_5 ~= r8_0 then
		r8_0 = r0_5
		if r0_5 then
			addEventHandler("onClientKey", getRootElement(), marketKey, true, r1_5)
		else
			removeEventHandler("onClientKey", getRootElement(), marketKey)
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
local sightNionConversationFromChat = false
local nionPmList = false
local pmIcon = false
local incomingNoti = false
addEvent("opensightNion", false)
addEventHandler("opensightNion", getRootElement(), function()
	switchAppScreen("sightNion_menu")
end)
addEvent("opensightNionChat", false)
addEventHandler("opensightNionChat", getRootElement(), function()
	switchAppScreen("sightNion_chat")
end)
addEvent("opensightNionPMList", false)
addEventHandler("opensightNionPMList", getRootElement(), function()
	switchAppScreen("sightNion_pm_list")
end)
addEvent("opensightNionConversation", false)
addEventHandler("opensightNionConversation", getRootElement(), function(r0_12, r1_12, r2_12, r3_12, r4_12, id)
	if nionPmList then
		sightNionCurrentPM = id
		switchAppScreen("sightNion_pm")
	end
end)
addEvent("openSightNionConversationFromChat", false)
addEventHandler("openSightNionConversationFromChat", getRootElement(), function(r0_13, r1_13, r2_13, r3_13, x, id)
	if sightNionConnected and id ~= sightNionConnected then
		sightNionConversationFromChat = true
		sightNionCurrentPM = id
		switchAppScreen("sightNion_pm")
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
					sightexports.sGui:setClickEvent(rect, "openSightNionConversationFromChat")
					sightexports.sGui:setClickArgument(rect, currentSightNionMessages[i][2])
					sightexports.sGui:setGuiHover(rect, "none", false, false, true)
					sightexports.sGui:guiSetTooltip(rect, "Kattints a privát üzenetváltáshoz.\nÜzenet ID: " .. id)
				elseif not selfMsg then
					sightexports.sGui:setGuiHoverable(rect, true)
					sightexports.sGui:setClickEvent(rect, "openSightNionConversationFromChat")
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
	if currentPhoneScreen == "sightNion_chat" then
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
local openedDealerApp = false
local r48_0 = false
local r49_0 = false
local r50_0 = false
local r51_0 = false
local r52_0 = false
local r53_0 = false
local r54_0 = false
local r55_0 = 0
local r56_0 = 0
local openedDeal = false
local r58_0 = false
local r59_0 = false
local openedDeliveryApp = false
local chatBackground = false
function appCloses.sightNion_delivery()
	openedDeliveryApp = false
	chatBackground = false
end
function generateDeliveryInside()
	local deliveryData = sightexports.sDealer:getDelivery()
	if not deliveryData then
		switchAppScreen("sightNion_market", true)
		return 
	end
	if chatBackground then
		sightexports.sGui:deleteGuiElement(chatBackground)
	end
	chatBackground = sightexports.sGui:createGuiElement("null", 0, topSize + 32 + 4, bsx, sightNionSh, appInside)
	local r1_26 = 0
	local r2_26, r3_26 = sightexports.sDealer:formatAdMessage(deliveryData)
	local r4_26 = generateMarketMessageBubble(chatBackground, 0, r2_26, false)
	if r3_26 then
		r4_26 = generateMarketMessageBubble(chatBackground, r4_26, r3_26, false)
	end
	if deliveryData.respone and not deliveryData.responseLock then
		r4_26 = generateMarketMessageBubble(chatBackground, r4_26, sightexports.sDealer:formatResponseMessage(deliveryData), true)
		if not deliveryData.replyLock then
			if deliveryData.coordinateLock then
				r4_26 = generateMarketWritingBubble(chatBackground, r4_26, false)
			else
				r4_26 = generateMarketMessageBubble(chatBackground, r4_26, "Titkosított koordináta", false, true)
				if deliveryData.buyerResponse and not deliveryData.buyerResponseLock then
					r4_26 = generateMarketMessageBubble(chatBackground, r4_26, sightexports.sDealer:formatBuyerResponseMessage(deliveryData), false)
				else
					r4_26 = generateMarketWritingBubble(chatBackground, r4_26, false)
				end
			end
		end
	else
		r4_26 = generateMarketWritingBubble(chatBackground, r4_26, true)
	end
	bringBackFront()
end
function appScreens.sightNion_delivery()
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside), "solid", "#353535")
	rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightexports.sGui:setGuiBackground(rect, "solid", {
		0,
		0,
		0
	})
	local label = sightexports.sGui:createGuiElement("label", 8, topSize, bsx, 32, rect)
	sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	sightexports.sGui:setLabelColor(label, "#ffffff")
	sightexports.sGui:setLabelText(label, "SightNion Market")
	--openedDealerApp = true
	openedDeliveryApp = true
	generateBottom(true, "opensightNion")
	generateDeliveryInside()
end
function updatesightNionMarketDelivery()
	if openedDeliveryApp then
		generateDeliveryInside()
	end
	if openedDealerApp then
		updateDealerApp()
	end
end
function opensightNionMarket()
	if sightexports.sDealer:doHasDelivery() then
		switchAppScreen("sightNion_delivery", true)
	else
		switchAppScreen("sightNion_market", true)
	end
end
addEvent("opensightNionMarket", false)
addEventHandler("opensightNionMarket", getRootElement(), opensightNionMarket)
addEvent("sightNionMarketBack", false)
addEventHandler("sightNionMarketBack", getRootElement(), function()
	if openedDeal then
		openedDeal = false
		updateDealerApp()
	else
		switchAppScreen("sightNion_menu")
	end
end)
function generateMarketWritingBubble(r0_31, r1_31, r2_31)
	local r4_31 = sightexports.sGui:getFontHeight("10/Ubuntu-L.ttf")
	local r5_31 = nil	-- notice: implicit variable refs by block#[3, 6]
	if r2_31 then
		r5_31 = 20 + bsx - 32 - r4_31 - 8
	else
		r5_31 = 8
	end
	local r6_31 = sightexports.sGui:createGuiElement("rectangle", r5_31, r1_31, r4_31 + 8, r4_31 + 8, r0_31)
	local r7_31 = sightexports.sGui
	local r9_31 = r6_31
	local r10_31 = "solid"
	local r11_31 = nil	-- notice: implicit variable refs by block#[6]
	if r2_31 then
		r11_31 = "#181818"
	else
		r11_31 = "#242424"
	end
	r7_31:setGuiBackground(r9_31, r10_31, r11_31)
	r1_31 = r1_31 + 4
	sightexports.sGui:setImageFile(sightexports.sGui:createGuiElement("image", r5_31 + 4, r1_31, r4_31, r4_31, r0_31), sightexports.sGui:getFaIconFilename("ellipsis-h", r4_31))
	return r1_31 + 8
end
function generateMarketMessageBubble(r0_32, r1_32, r2_32, r3_32, r4_32)
	-- line: [874, 933] id: 32
	local r5_32	-- notice: implicit variable refs by block#[3, 8, 21]
	if r4_32 then
		r5_32 = "10/Ubuntu-B.ttf"
	else
		r5_32 = "10/Ubuntu-L.ttf"
	end
	local r6_32 = sightexports.sGui:getFontHeight(r5_32)
	local r7_32 = bsx - 32 - 8
	local r8_32 = 4
	if r4_32 then
		r7_32 = r7_32 - r6_32
		r8_32 = r8_32 + r6_32
	end
	local r9_32 = {}
	local r10_32 = split(r2_32, " ")
	local r11_32 = (r10_32[1] or "") .. " "
	local r19_32 = nil	-- notice: implicit variable refs by block#[18]
	for r15_32 = 2, #r10_32, 1 do
		if r7_32 <= sightexports.sGui:getTextWidthFont(r11_32 .. r10_32[r15_32], r5_32) then
			table.insert(r9_32, r11_32)
			r11_32 = r10_32[r15_32] .. " "
		else
			r19_32 = " "
			r11_32 = r11_32 .. r10_32[r15_32] .. r19_32
		end
	end
	table.insert(r9_32, r11_32)
	local r12_32 = #r9_32 * r6_32 + 8
	local r13_32 = nil	-- notice: implicit variable refs by block#[15, 19, 21]
	if r3_32 then
		r13_32 = 20
	else
		r13_32 = 8
	end
	local r14_32 = sightexports.sGui:createGuiElement("rectangle", r13_32, r1_32, bsx - 32, math.max(0, r12_32), r0_32)
	local r15_32 = sightexports.sGui
	local r17_32 = r14_32
	local r18_32 = "solid"
	if r3_32 then
		r19_32 = "#181818"
	else
		r19_32 = "#242424"
	end
	r15_32:setGuiBackground(r17_32, r18_32, r19_32)
	r1_32 = r1_32 + 4
	if r4_32 then
		r15_32 = sightexports.sGui:createGuiElement("image", r13_32 + 4, r1_32 + 1, r6_32 - 2, r6_32 - 2, r0_32)
		sightexports.sGui:setImageFile(r15_32, sightexports.sGui:getFaIconFilename("user-secret", r6_32))
		sightexports.sGui:setImageColor(r15_32, blue)
	end
	for r18_32 = 1, #r9_32, 1 do
		r19_32 = sightexports.sGui:createGuiElement("label", r13_32 + r8_32, r1_32, bsx - 32 - 8, r6_32, r0_32)
		sightexports.sGui:setLabelText(r19_32, r9_32[r18_32])
		sightexports.sGui:setLabelClip(r19_32, true)
		sightexports.sGui:setLabelFont(r19_32, r5_32)
		sightexports.sGui:setLabelAlignment(r19_32, "left", "center")
		if r4_32 then
			sightexports.sGui:setLabelColor(r19_32, blue)
		end
		r1_32 = r1_32 + r6_32
	end
	return r1_32 + 8
end
addEvent("doAcceptsightNionMarketAd", false)
addEventHandler("doAcceptsightNionMarketAd", getRootElement(), function(r0_33, r1_33, r2_33, r3_33, r4_33, r5_33)
	-- line: [937, 945] id: 33
	if r59_0 then
		sightexports.sGui:deleteGuiElement(r59_0)
		r59_0 = false
	end
	sightexports.sDealer:startDelivery(r5_33)
end)
addEvent("acceptsightNionMarketAd", false)
addEventHandler("acceptsightNionMarketAd", getRootElement(), function(r0_34, r1_34, r2_34, r3_34, r4_34, r5_34)
	-- line: [949, 983] id: 34
	if r59_0 then
		sightexports.sGui:setGuiHoverable(r59_0, false)
		sightexports.sGui:setGuiBackground(r59_0, "solid", {
			0,
			0,
			0,
			0
		})
		sightexports.sGui:setButtonFont(r59_0, "11/Ubuntu-B.ttf")
		local r6_34 = sightexports.sGui:createGuiElement("label", 4, 28, bsx - 24, 0, r59_0)
		sightexports.sGui:setLabelAlignment(r6_34, "center", "top")
		sightexports.sGui:setLabelColor(r6_34, "#ffffff")
		sightexports.sGui:setLabelFont(r6_34, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(r6_34, "Biztosan szeretnéd elvállalni?\nAmennyiben nem teljesíted\nidőben a megbízást, 24 órára\nelérhetetlen lesz a sightNion\nMarket számodra.")
		local r7_34 = sightexports.sGui:getLabelFontHeight(r6_34) * 5 + 4
		local r8_34 = sightexports.sGui:createGuiElement("button", 0, 28 + r7_34, (bsx - 16 - 4) / 2, 24, r59_0)
		sightexports.sGui:setGuiBackground(r8_34, "solid", green)
		sightexports.sGui:setGuiHover(r8_34, "none", green, false, true)
		sightexports.sGui:setButtonTextColor(r8_34, "#ffffff")
		sightexports.sGui:setButtonFont(r8_34, "11/Ubuntu-R.ttf")
		sightexports.sGui:setClickEvent(r8_34, "doAcceptsightNionMarketAd")
		sightexports.sGui:setClickArgument(r8_34, r5_34)
		sightexports.sGui:setButtonText(r8_34, "Igen")
		local r9_34 = sightexports.sGui:createGuiElement("button", (bsx - 16 - 4) / 2 + 4, 28 + r7_34, (bsx - 16 - 4) / 2, 24, r59_0)
		sightexports.sGui:setGuiBackground(r9_34, "solid", red)
		sightexports.sGui:setGuiHover(r9_34, "none", red, false, true)
		sightexports.sGui:setButtonTextColor(r9_34, "#ffffff")
		sightexports.sGui:setButtonFont(r9_34, "11/Ubuntu-R.ttf")
		sightexports.sGui:setClickEvent(r9_34, "opensightNionMarketAd")
		sightexports.sGui:setClickArgument(r9_34, r5_34)
		sightexports.sGui:setButtonText(r9_34, "Nem")
		bringBackFront()
	end
end)
addEvent("opensightNionMarketAd", false)
addEventHandler("opensightNionMarketAd", getRootElement(), function(r0_35, r1_35, r2_35, r3_35, r4_35, r5_35)
	-- line: [987, 1013] id: 35
	openedDeal = r5_35
	if r58_0 then
		sightexports.sGui:deleteGuiElement(r58_0)
	end
	r58_0 = sightexports.sGui:createGuiElement("rectangle", 0, topSize + 32 + 4, bsx, sightNionSh, appInside)
	sightexports.sGui:setGuiBackground(r58_0, "solid", "#353535")
	local r6_35, r7_35 = sightexports.sDealer:getAdMessage(r5_35)
	local r8_35 = generateMarketMessageBubble(r58_0, 0, r6_35, false)
	if r7_35 then
		r8_35 = generateMarketMessageBubble(r58_0, r8_35, r7_35, false)
	end
	r59_0 = sightexports.sGui:createGuiElement("button", 8, r8_35, bsx - 16, 24, r58_0)
	sightexports.sGui:setGuiBackground(r59_0, "solid", green)
	sightexports.sGui:setGuiHover(r59_0, "none", green, false, true)
	sightexports.sGui:setButtonTextColor(r59_0, "#ffffff")
	sightexports.sGui:setButtonFont(r59_0, "11/Ubuntu-R.ttf")
	sightexports.sGui:setClickEvent(r59_0, "acceptsightNionMarketAd")
	sightexports.sGui:setClickArgument(r59_0, r5_35)
	updateDealerApp()
	bringBackFront()
end)
function updateDealerScroll()
	-- line: [1015, 1097] id: 36
	if openedDealerApp then
		if openedDeal then
			local r0_36 = sightexports.sDealer:getAdvertisement(openedDeal)
			if r0_36 then
				if r59_0 then
					sightexports.sGui:setButtonText(r59_0, "Megbízás elvállalása (" .. string.format("%02d:%02d", math.floor(r0_36.remaining / 60), r0_36.remaining % 60) .. ")")
				end
			else
				openedDeal = false
				updateDealerApp()
				return 
			end
		end
		if r48_0 then
			sightexports.sGui:setGuiRenderDisabled(r54_0, false)
			sightexports.sGui:setGuiRenderDisabled(nionScrollBar, false)
			r55_0 = sightexports.sDealer:getAdvertisementNum()
			local r0_36 = math.max(0, r55_0 - 10)
			if r0_36 < r56_0 then
				r56_0 = r0_36
			end
			for r4_36 = 1, #r53_0, 1 do
				local r5_36 = true
				local r7_36 = sightexports.sDealer:getAdvertisementId(r4_36 + r56_0)
				if r7_36 then
					local r8_36 = sightexports.sDealer:getAdvertisement(r7_36)
					if r8_36 then
						r5_36 = false
						local r9_36 = r53_0[r4_36][1]
						local r11_36 = r53_0[r4_36][3]
						local r12_36 = r53_0[r4_36][4]
						local r13_36 = r53_0[r4_36][5]
						local r14_36 = r53_0[r4_36][6]
						local r15_36 = math.floor(r8_36.remaining / 60)
						local r16_36 = r8_36.remaining % 60
						sightexports.sGui:setImageFile(r53_0[r4_36][2], ":sItems/" .. r8_36.itemPic)
						sightexports.sGui:setLabelText(r11_36, r8_36.amount)
						sightexports.sGui:setLabelText(r12_36, r8_36.itemName)
						sightexports.sGui:setLabelText(r13_36, sightexports.sGui:thousandsStepper(r8_36.price) .. " $")
						sightexports.sGui:setLabelText(r14_36, string.format("%02d:%02d", r15_36, r16_36))
						local r17_36 = sightexports.sGui
						local r19_36 = r14_36
						local r20_36 = nil	-- notice: implicit variable refs by block#[15]
						if r15_36 < 1 then
							r20_36 = red
						else
							r20_36 = "#ffffff"
						end
						r17_36:setLabelColor(r19_36, r20_36)
						sightexports.sGui:setClickArgument(r9_36, r7_36)
					end
				end
				for r11_36 = 1, #r53_0[r4_36], 1 do
					sightexports.sGui:setGuiRenderDisabled(r53_0[r4_36][r11_36], r5_36)
				end
			end
			local r1_36 = sightNionSh / math.max(1, (r0_36 + 1))
			sightexports.sGui:setGuiSize(nionScrollBar, false, r1_36)
			sightexports.sGui:setGuiPosition(nionScrollBar, false, r1_36 * r56_0)
		else
			sightexports.sGui:setGuiRenderDisabled(r54_0, true)
			sightexports.sGui:setGuiRenderDisabled(nionScrollBar, true)
			for r3_36 = 1, #r53_0, 1 do
				for r7_36 = 1, #r53_0[r3_36], 1 do
					sightexports.sGui:setGuiRenderDisabled(r53_0[r3_36][r7_36], true)
				end
			end
		end
	end
end
function marketKey(r0_37)
	-- line: [1099, 1111] id: 37
	if r0_37 == "mouse_wheel_down" and r56_0 < r55_0 - 10 then
		r56_0 = r56_0 + 1
		updateDealerScroll()
	elseif r0_37 == "mouse_wheel_up" and 0 < r56_0 then
		r56_0 = r56_0 - 1
		updateDealerScroll()
	end
end
function updateDealerApp()
	-- line: [1113, 1152] id: 38
	if openedDealerApp then
		if sightexports.sDealer:doHasDelivery() then
			switchAppScreen("sightNion_delivery", true)
			return 
		end
		r48_0 = false
		local r0_38, restrictionReason = sightexports.sDealer:getAppState()
		if r58_0 and not openedDeal then
			sightexports.sGui:deleteGuiElement(r58_0)
			r58_0 = false
			r59_0 = false
		end
		if r58_0 then
			sightexports.sGui:setGuiRenderDisabled(r51_0, true)
			sightexports.sGui:setGuiRenderDisabled(r52_0, true)
		elseif r0_38 then
			sightexports.sGui:setGuiRenderDisabled(r51_0, true)
			sightexports.sGui:setGuiRenderDisabled(r52_0, false)
		elseif restrictionReason then
			sightexports.sGui:setGuiRenderDisabled(r51_0, false)
			sightexports.sGui:setGuiRenderDisabled(r52_0, true)
			sightexports.sGui:setLabelText(r51_0, restrictionReason)
		else
			sightexports.sGui:setGuiRenderDisabled(r51_0, true)
			sightexports.sGui:setGuiRenderDisabled(r52_0, true)
			r48_0 = true
		end
		r9_0(r48_0)
		updateDealerScroll()
	end
end
function appCloses.sightNion_market()
	-- line: [1154, 1179] id: 39
	openedDealerApp = false
	r50_0 = false
	r51_0 = false
	r52_0 = false
	r54_0 = false
	r48_0 = false
	r53_0 = false
	sightNionTopRect = false
	nionScrollBar = false
	openedDeal = false
	r58_0 = false
	r59_0 = false
	r55_0 = 0
	r56_0 = 0
	r9_0(false)
	if isTimer(r49_0) then
		killTimer(r49_0)
	end
	r49_0 = nil
	sightexports.sDealer:unsubscribeToAdvertisementList()
end
function doMarketSubscribe()
	-- line: [1181, 1183] id: 40
	sightexports.sDealer:subscribeToAdvertisementList()
end
function appScreens.sightNion_market()
	-- line: [1185, 1284] id: 41
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside), "solid", "#353535")
	sightNionTopRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightexports.sGui:setGuiBackground(sightNionTopRect, "solid", {
		0,
		0,
		0
	})
	local r1_41 = sightexports.sGui:createGuiElement("label", 8, topSize, bsx, 32, sightNionTopRect)
	sightexports.sGui:setLabelFont(r1_41, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r1_41, "left", "center")
	sightexports.sGui:setLabelColor(r1_41, "#ffffff")
	sightexports.sGui:setLabelText(r1_41, "SightNion Market")
	local r3_41 = topSize + 32 + 4
	sightNionSh = bsy - topSize * 2.5 - 32 - 8
	r54_0 = sightexports.sGui:createGuiElement("rectangle", bsx - 9, r3_41, 3, sightNionSh, appInside)
	sightexports.sGui:setGuiBackground(r54_0, "solid", "#444444")
	nionScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 3, sightNionSh, r54_0)
	sightexports.sGui:setGuiBackground(nionScrollBar, "solid", "#181818")
	r51_0 = sightexports.sGui:createGuiElement("label", 12, r3_41, bsx - 24, sightNionSh, appInside)
	sightexports.sGui:setLabelAlignment(r51_0, "center", "center")
	sightexports.sGui:setLabelColor(r51_0, "#ffffff")
	sightexports.sGui:setLabelFont(r51_0, "11/Ubuntu-B.ttf")
	sightexports.sGui:setLabelWordBreak(r51_0, true)
	r52_0 = sightexports.sGui:createGuiElement("image", bsx / 2 - 16, r3_41 + sightNionSh / 2 - 16, 32, 32, appInside)
	sightexports.sGui:setImageFile(r52_0, sightexports.sGui:getFaIconFilename("circle-notch", 32))
	sightexports.sGui:setImageSpinner(r52_0, true)
	local r4_41 = sightNionSh / 10
	r53_0 = {}
	for r8_41 = 1, 10, 1 do
		r53_0[r8_41] = {}
		local r9_41 = sightexports.sGui:createGuiElement("rectangle", 8, r3_41, bsx - 16 - 4, r4_41, appInside)
		sightexports.sGui:setGuiHoverable(r9_41, true)
		sightexports.sGui:setClickEvent(r9_41, "opensightNionMarketAd")
		table.insert(r53_0[r8_41], r9_41)
		local r10_41 = sightexports.sGui:createGuiElement("image", 0, 2, r4_41 - 2, r4_41 - 2, r9_41)
		sightexports.sGui:setImageFile(r10_41, ":sItems/files/items/64.png")
		table.insert(r53_0[r8_41], r10_41)
		local r11_41 = sightexports.sGui:createGuiElement("label", 0, 0, r4_41 - 2, r4_41 - 2, r10_41)
		sightexports.sGui:setLabelFont(r11_41, "8/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r11_41, "right", "bottom")
		sightexports.sGui:setLabelText(r11_41, "50")
		table.insert(r53_0[r8_41], r11_41)
		local r12_41 = sightexports.sGui:createGuiElement("label", r4_41 + 4, 0, bsx - 16 - 4 - r4_41 - 4 - 40 - 4, r4_41 / 2, r9_41)
		sightexports.sGui:setLabelFont(r12_41, "11/Ubuntu-B.ttf")
		sightexports.sGui:setLabelAlignment(r12_41, "left", "center")
		sightexports.sGui:setLabelColor(r12_41, "#ffffff")
		sightexports.sGui:setLabelText(r12_41, "Füves Cigi")
		sightexports.sGui:setLabelClip(r12_41, true)
		table.insert(r53_0[r8_41], r12_41)
		local r13_41 = sightexports.sGui:createGuiElement("label", r4_41 + 4, r4_41 / 2, 0, r4_41 / 2, r9_41)
		sightexports.sGui:setLabelFont(r13_41, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r13_41, "left", "center")
		sightexports.sGui:setLabelColor(r13_41, green)
		sightexports.sGui:setLabelText(r13_41, "100 000 $")
		table.insert(r53_0[r8_41], r13_41)
		local r14_41 = sightexports.sGui:createGuiElement("label", bsx - 16 - 4 - 40, 0, 40, r4_41, r9_41)
		sightexports.sGui:setLabelFont(r14_41, "13/BebasNeueBold.otf")
		sightexports.sGui:setLabelAlignment(r14_41, "center", "center")
		sightexports.sGui:setLabelText(r14_41, "20:10")
		table.insert(r53_0[r8_41], r14_41)
		if r8_41 > 1 then
			local r15_41 = sightexports.sGui:createGuiElement("hr", 0, -1, bsx - 16 - 4, 1, r9_41)
			sightexports.sGui:setGuiHrColor(r15_41, "#555555", "#555555")
			table.insert(r53_0[r8_41], r15_41)
		end
		r3_41 = r3_41 + r4_41
	end
	r56_0 = 0
	openedDealerApp = true
	updateDealerApp()
	if isTimer(r49_0) then
		killTimer(r49_0)
	end
	r49_0 = nil
	r49_0 = setTimer(doMarketSubscribe, 500 + 1500 * math.random(), 1)
	generateBottom(true, "sightNionMarketBack")
	bringBackFront()
end
function appCloses.sightNion_menu()
	-- line: [1286, 1288] id: 42
	sightNionTopRect = false
end
function appScreens.sightNion_menu()
	-- line: [1290, 1349] id: 43
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside), "solid", "#353535")
	sightNionTopRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightexports.sGui:setGuiBackground(sightNionTopRect, "solid", {
		0,
		0,
		0
	})
	local r1_43 = sightexports.sGui:createGuiElement("label", 8, topSize, bsx, 32, sightNionTopRect)
	sightexports.sGui:setLabelFont(r1_43, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r1_43, "left", "center")
	sightexports.sGui:setLabelColor(r1_43, "#ffffff")
	sightexports.sGui:setLabelText(r1_43, "SightNion Homepage")
	local r2_43 = 32 + topSize + 4
	local r3_43 = sightexports.sGui:createGuiElement("rectangle", 8, r2_43, bsx - 16, 32, appInside)
	sightexports.sGui:setGuiBackground(r3_43, "solid", {
		0,
		0,
		0
	})
	sightexports.sGui:setGuiHover(r3_43, "none", false, false, true)
	sightexports.sGui:setGuiHoverable(r3_43, true)
	sightexports.sGui:setClickEvent(r3_43, "opensightNionChat")
	local r4_43 = sightexports.sGui:getTextWidthFont(" SightNion Chat", "10/Ubuntu-R.ttf") + 24
	sightexports.sGui:setImageFile(sightexports.sGui:createGuiElement("image", (bsx - 16) / 2 - r4_43 / 2, 4, 24, 24, r3_43), sightexports.sGui:getFaIconFilename("comments-alt", 24))
	local r6_43 = sightexports.sGui:createGuiElement("label", (bsx - 16) / 2 - r4_43 / 2 + 24, 0, bsx, 32, r3_43)
	sightexports.sGui:setLabelFont(r6_43, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r6_43, "left", "center")
	sightexports.sGui:setLabelColor(r6_43, "#ffffff")
	sightexports.sGui:setLabelText(r6_43, " SightNion Chat")
	r2_43 = r2_43 + 32 + 4
	local r7_43 = sightexports.sGui:createGuiElement("rectangle", 8, r2_43, bsx - 16, 32, appInside)
	sightexports.sGui:setGuiBackground(r7_43, "solid", {
		0,
		0,
		0
	})
	sightexports.sGui:setGuiHover(r7_43, "none", false, false, true)
	sightexports.sGui:setGuiHoverable(r7_43, true)
	sightexports.sGui:setClickEvent(r7_43, "opensightNionMarket")
	local r8_43 = sightexports.sGui:getTextWidthFont(" SightNion Market", "10/Ubuntu-R.ttf") + 24
	sightexports.sGui:setImageFile(sightexports.sGui:createGuiElement("image", (bsx - 16) / 2 - r8_43 / 2, 4, 24, 24, r7_43), sightexports.sGui:getFaIconFilename("store", 24))
	local r10_43 = sightexports.sGui:createGuiElement("label", (bsx - 16) / 2 - r8_43 / 2 + 24, 0, bsx, 32, r7_43)
	sightexports.sGui:setLabelFont(r10_43, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r10_43, "left", "center")
	sightexports.sGui:setLabelColor(r10_43, "#ffffff")
	sightexports.sGui:setLabelText(r10_43, " SightNion Market")
	r2_43 = r2_43 + 32 + 4
	generateBottom(true)
	bringBackFront()
end
function appCloses.sightNion_chat()
	-- line: [1351, 1374] id: 44
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
function appScreens.sightNion_chat()
	-- line: [1376, 1448] id: 45
	sightNionScroll = 0
	addEventHandler("onClientKey", getRootElement(), sightNionChatKey)
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside), "solid", "#353535")
	sightNionTopRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightexports.sGui:setGuiBackground(sightNionTopRect, "solid", {
		0,
		0,
		0
	})
	pmIcon = sightexports.sGui:createGuiElement("image", bsx - 32 - 4, topSize, 32, 32, sightNionTopRect)
	sightexports.sGui:setImageFile(pmIcon, sightexports.sGui:getFaIconFilename("envelope", 32, "regular"))
	sightexports.sGui:setImageColor(pmIcon, "#ffffff")
	sightexports.sGui:setGuiHoverable(pmIcon, true)
	sightexports.sGui:setClickEvent(pmIcon, "opensightNionPMList")
	local r1_45 = sightexports.sGui:createGuiElement("label", 8, topSize, bsx, 32, sightNionTopRect)
	sightexports.sGui:setLabelFont(r1_45, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r1_45, "left", "center")
	sightexports.sGui:setLabelColor(r1_45, "#ffffff")
	sightexports.sGui:setLabelText(r1_45, "SightNion Chat")
	local r2_45 = topSize * 1.5 + 32
	local r3_45 = sightexports.sGui:getFontHeight("9/Ubuntu-R.ttf") + 1
	inputRectSize = r3_45 + r2_45 + 4 - topSize * 1.5
	sightNionInputRect = sightexports.sGui:createGuiElement("rectangle", 0, bsy - r2_45 - r3_45 - 4, bsx, inputRectSize, appInside)
	sightexports.sGui:setGuiBackground(sightNionInputRect, "solid", "#353535")
	sightexports.sGui:setGuiHrColor(sightexports.sGui:createGuiElement("hr", 0, -1, bsx, 1, sightNionInputRect), "#555555", "#555555")
	nionStatusLabel = sightexports.sGui:createGuiElement("label", 0, 0, bsx - 8, r3_45 - 1, sightNionInputRect)
	sightexports.sGui:setLabelFont(nionStatusLabel, "9/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(nionStatusLabel, "right", "bottom")
	sightexports.sGui:setLabelColor(nionStatusLabel, "#a8a8a8")
	sightexports.sGui:setLabelText(nionStatusLabel, "Nincs csatlakozva")
	sightNionInput = sightexports.sGui:createGuiElement("input", 8, r3_45, bsx - 16, 32, sightNionInputRect)
	sightexports.sGui:setInputColor(sightNionInput, grey1, "#232323", "#ffffff", "#232323", "#ffffff")
	sightexports.sGui:setInputFont(sightNionInput, "11/Ubuntu-R.ttf")
	sightexports.sGui:setInputMaxLength(sightNionInput, 200)
	sightexports.sGui:setInputBorderSize(sightNionInput, 0.5)
	sightexports.sGui:setInputMultiline(sightNionInput, true)
	sightexports.sGui:setInputFontPaddingHeight(sightNionInput, 32)
	sightexports.sGui:setInputPlaceholder(sightNionInput, "Nincs csatlakozva")
	sightexports.sGui:setElementDisabled(sightNionInput, true)
	sightNionSh = bsy - topSize * 2.5 - 32 - 8 - inputRectSize - 2
	local r6_45 = sightexports.sGui:createGuiElement("rectangle", bsx - 9, topSize + 32 + 4, 3, sightNionSh, appInside)
	sightexports.sGui:setGuiBackground(r6_45, "solid", "#444444")
	nionScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 3, sightNionSh, r6_45)
	sightexports.sGui:setGuiBackground(nionScrollBar, "solid", "#181818")
	bottomY = bsy - (inputRectSize + topSize * 1.5)
	topY = 32 + topSize
	sightNionMaxScroll = 32 - bottomY - topY
	generateBottom(true, "opensightNion")
	bringBackFront()
	triggerServerEvent("connectToSightNion", localPlayer)
end
addEvent("deletesightNionConversation", true)
addEventHandler("deletesightNionConversation", getRootElement(), function(r0_46)
	-- line: [1453, 1483] id: 46
	if fileExists("nionpm/" .. r0_46 .. ".sight") then
		fileDelete("nionpm/" .. r0_46 .. ".sight")
	end
	if sightNionCurrentPM == r0_46 and sightNionPmValid then
		currentSightNionMessages = {}
		for r4_46, r5_46 in pairs(currentMessageElements) do
			for r9_46 = 1, #r5_46, 1 do
				if r5_46[r9_46] then
					sightexports.sGui:deleteGuiElement(r5_46[r9_46])
				end
			end
		end
		currentMessageElements = {}
		sightlangCondHandl0(true)
	end
	if nionPmList then
		local r1_46 = false
		for r5_46 = #nionPmList, 1, -1 do
			if nionPmList[r5_46][1] == r0_46 then
				table.remove(nionPmList, r5_46)
			end
		end
		sightlangCondHandl3(true)
	end
end)
addEvent("gotSightNionPMMessage", true)
addEventHandler("gotSightNionPMMessage", getRootElement(), function(r0_47, r1_47, r2_47, r3_47)
	-- line: [1487, 1559] id: 47
	r2_47 = r2_47:gsub("\n", " ")
	if sightNionCurrentPM == r0_47 and sightNionPmValid then
		table.insert(currentSightNionMessages, 1, {
			r2_47,
			r1_47,
			r3_47,
			#currentSightNionMessages + 1
		})
		sightlangCondHandl0(true)
	elseif r1_47 == r0_47 then
		incomingNoti = true
		if sightNionConnected then
			sightexports.sGui:setImageFile(pmIcon, sightexports.sGui:getFaIconFilename("envelope", 32, incomingNoti and "solid" or "regular"))
		end
	end
	if nionPmList then
		local r4_47 = false
		for r8_47 = 1, #nionPmList, 1 do
			if nionPmList[r8_47][1] == r0_47 then
				r4_47 = r8_47
				break
			end
		end
		if not r4_47 then
			r4_47 = 1
			table.insert(nionPmList, 1, {
				r1_47
			})
		end
		local r5_47 = getRealTime(r3_47)
		nionPmList[r4_47][2] = string.format("%02d. %02d. %02d. %02d:%02d", r5_47.year - 100, r5_47.month + 1, r5_47.monthday, r5_47.hour, r5_47.minute)
		nionPmList[r4_47][3] = r2_47
		nionPmList[r4_47][4] = r1_47 == r0_47
		sightlangCondHandl3(true)
	end
	local r4_47 = nil
	if fileExists("nionpm/" .. r0_47 .. ".sight") then
		r4_47 = fileOpen("nionpm/" .. r0_47 .. ".sight")
		fileSetPos(r4_47, fileGetSize(r4_47))
	else
		r4_47 = fileCreate("nionpm/" .. r0_47 .. ".sight")
		if r4_47 then
			local r5_47 = false
			if fileExists("nionpm/list.sight") then
				r5_47 = fileOpen("nionpm/list.sight")
				fileSetPos(r5_47, fileGetSize(r5_47))
			else
				r5_47 = fileCreate("nionpm/list.sight")
			end
			if r5_47 then
				fileWrite(r5_47, r0_47 .. "\n")
				fileClose(r5_47)
			end
		end
	end
	if r4_47 then
		fileWrite(r4_47, r1_47 .. "#" .. r3_47 .. "#" .. r2_47 .. "\n")
		fileClose(r4_47)
	end
end)
function checkPmFiles()
	-- line: [1562, 1590] id: 48
	if fileExists("nionpm/list.sight") then
		local r0_48 = fileOpen("nionpm/list.sight")
		if r0_48 then
			local r1_48 = fileRead(r0_48, fileGetSize(r0_48))
			fileClose(r0_48)
			fileDelete("nionpm/list.sight")
			local r2_48 = fileCreate("nionpm/list.sight")
			r1_48 = split(r1_48, "\n")
			local r3_48 = {}
			for r7_48 = 1, #r1_48, 1 do
				local r8_48 = tonumber(r1_48[r7_48])
				if fileExists("nionpm/" .. r8_48 .. ".sight") and not r3_48[r8_48] then
					fileWrite(r2_48, r8_48 .. "\n")
					r3_48[r8_48] = true
				end
			end
			fileClose(r2_48)
		end
	end
end
checkPmFiles()
local waitingForValidation = false
addEvent("gotSightNionPMValidation", true)
addEventHandler("gotSightNionPMValidation", getRootElement(), function(r0_49, r1_49, r2_49, r3_49)
	-- line: [1597, 1695] id: 49
	waitingForValidation = false
	if sightNionCurrentPM == r0_49 then
		if r1_49 then
			sightNionPmValid = true
			if r2_49 and fileExists("nionpm/" .. r0_49 .. ".sight") then
				local r4_49 = fileOpen("nionpm/" .. r0_49 .. ".sight")
				if r4_49 then
					local r5_49 = split(fileRead(r4_49, fileGetSize(r4_49)), "\n")
					for r9_49 = 1, #r5_49, 1 do
						local r10_49 = split(r5_49[r9_49], "#")
						local r11_49 = tonumber(r10_49[1])
						table.remove(r10_49, 1)
						if r11_49 then
							local r12_49 = tonumber(r10_49[1])
							table.remove(r10_49, 1)
							table.insert(currentSightNionMessages, 1, {
								table.concat(r10_49, "#"),
								r11_49,
								r12_49,
								#currentSightNionMessages + 1
							})
							sightlangCondHandl0(true)
						end
					end
					fileClose(r4_49)
				end
			elseif fileExists("nionpm/" .. r0_49 .. ".sight") then
				fileDelete("nionpm/" .. r0_49 .. ".sight")
			end
			if r3_49 then
				for r7_49 = 1, #r3_49, 1 do
					local r8_49, r9_49, r10_49 = unpack(r3_49[r7_49])
					table.insert(currentSightNionMessages, 1, {
						r9_49,
						r8_49,
						r10_49,
						#currentSightNionMessages + 1
					})
				end
				local r4_49 = nil
				if fileExists("nionpm/" .. r0_49 .. ".sight") then
					r4_49 = fileOpen("nionpm/" .. r0_49 .. ".sight")
					fileSetPos(r4_49, fileGetSize(r4_49))
				else
					r4_49 = fileCreate("nionpm/" .. r0_49 .. ".sight")
					if r4_49 then
						local r5_49 = false
						if fileExists("nionpm/list.sight") then
							r5_49 = fileOpen("nionpm/list.sight")
							fileSetPos(r5_49, fileGetSize(r5_49))
						else
							r5_49 = fileCreate("nionpm/list.sight")
						end
						if r5_49 then
							fileWrite(r5_49, r0_49 .. "\n")
							fileClose(r5_49)
						end
					end
				end
				if r4_49 then
					for r8_49 = 1, #r3_49, 1 do
						local r9_49, r10_49, r11_49 = unpack(r3_49[r8_49])
						fileWrite(r4_49, r9_49 .. "#" .. r11_49 .. "#" .. r10_49 .. "\n")
					end
					fileClose(r4_49)
				end
			end
			sightexports.sGui:setInputPlaceholder(sightNionInput, "Üzenet")
			sightexports.sGui:setElementDisabled(sightNionInput, false)
		else
			switchAppScreen("sightNion_chat")
		end
	end
end)
function appCloses.sightNion_pm()
	-- line: [1697, 1718] id: 50
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
	-- line: [1720, 1729] id: 51
	if not waitingForValidation then
		if sightNionCurrentPM and not sightNionPmValid then
			waitingForValidation = true
			triggerLatentServerEvent("validateSightNionPM", localPlayer, sightNionCurrentPM)
		end
		sightlangCondHandl4(false)
	end
end
function appScreens.sightNion_pm()
	-- line: [1731, 1805] id: 52
	sightNionScroll = 0
	addEventHandler("onClientKey", getRootElement(), sightNionChatKey)
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside), "solid", "#353535")
	sightNionTopRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightexports.sGui:setGuiBackground(sightNionTopRect, "solid", {
		0,
		0,
		0
	})
	local r1_52 = sightexports.sGui:createGuiElement("label", 8, topSize, bsx, 32, sightNionTopRect)
	sightexports.sGui:setLabelFont(r1_52, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r1_52, "left", "center")
	sightexports.sGui:setLabelColor(r1_52, "#ffffff")
	sightexports.sGui:setLabelText(r1_52, "Ano" .. sightNionCurrentPM)
	local r2_52 = topSize * 1.5 + 32
	local r3_52 = sightexports.sGui:getFontHeight("9/Ubuntu-R.ttf") + 1
	inputRectSize = r3_52 + r2_52 + 4 - topSize * 1.5
	sightNionInputRect = sightexports.sGui:createGuiElement("rectangle", 0, bsy - r2_52 - r3_52 - 4, bsx, inputRectSize, appInside)
	sightexports.sGui:setGuiBackground(sightNionInputRect, "solid", "#353535")
	sightexports.sGui:setGuiHrColor(sightexports.sGui:createGuiElement("hr", 0, -1, bsx, 1, sightNionInputRect), "#555555", "#555555")
	nionStatusLabel = sightexports.sGui:createGuiElement("label", 0, 0, bsx - 8, r3_52 - 1, sightNionInputRect)
	sightexports.sGui:setLabelFont(nionStatusLabel, "9/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(nionStatusLabel, "right", "bottom")
	sightexports.sGui:setLabelColor(nionStatusLabel, "#a8a8a8")
	sightexports.sGui:setLabelText(nionStatusLabel, "Eltűnő üzenet")
	sightNionInput = sightexports.sGui:createGuiElement("input", 8, r3_52, bsx - 16, 32, sightNionInputRect)
	sightexports.sGui:setInputColor(sightNionInput, grey1, "#232323", "#ffffff", "#232323", "#ffffff")
	sightexports.sGui:setInputFont(sightNionInput, "11/Ubuntu-R.ttf")
	sightexports.sGui:setInputMaxLength(sightNionInput, 200)
	sightexports.sGui:setInputBorderSize(sightNionInput, 0.5)
	sightexports.sGui:setInputMultiline(sightNionInput, true)
	sightexports.sGui:setInputFontPaddingHeight(sightNionInput, 32)
	sightexports.sGui:setInputPlaceholder(sightNionInput, "Betöltés folyamatban...")
	sightexports.sGui:setElementDisabled(sightNionInput, true)
	sightNionSh = bsy - topSize * 2.5 - 32 - 8 - inputRectSize - 2
	local r6_52 = sightexports.sGui:createGuiElement("rectangle", bsx - 9, topSize + 32 + 4, 3, sightNionSh, appInside)
	sightexports.sGui:setGuiBackground(r6_52, "solid", "#444444")
	nionScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 3, sightNionSh, r6_52)
	sightexports.sGui:setGuiBackground(nionScrollBar, "solid", "#181818")
	bottomY = bsy - (inputRectSize + topSize * 1.5)
	topY = 32 + topSize
	sightNionMaxScroll = 32 - bottomY - topY
	if r31_0 then
		r31_0 = false
		generateBottom(true, "opensightNionChat")
	else
		generateBottom(true, "opensightNionPMList")
	end
	bringBackFront()
	sightNionPmValid = false
	sightlangCondHandl4(true)
end
local r63_0 = false
function sortPmList(r0_53, r1_53)
	-- line: [1809, 1811] id: 53
	return r1_53[2] < r0_53[2]
end
local pmIH = false
local nionPmElements = {}
function refreshPmListScroll()
	-- line: [1816, 1925] id: 54
	local r0_54 = false
	if math.max(0, #nionPmList - 8) < sightNionScroll then
		sightNionScroll = math.max(0, #nionPmList - 8)
	end
	for r4_54 = 1, 8, 1 do
		local r5_54 = r4_54 + sightNionScroll
		if nionPmList[r5_54] then
			sightexports.sGui:setGuiRenderDisabled(nionPmElements[r4_54][1], false)
			sightexports.sGui:setGuiRenderDisabled(nionPmElements[r4_54][2], false)
			sightexports.sGui:setGuiRenderDisabled(nionPmElements[r4_54][3], false)
			if nionPmElements[r4_54][6] then
				sightexports.sGui:setGuiRenderDisabled(nionPmElements[r4_54][6], false)
			end
			sightexports.sGui:setClickArgument(nionPmElements[r4_54][1], nionPmList[r5_54][1])
			sightexports.sGui:setLabelText(nionPmElements[r4_54][2], "Ano" .. nionPmList[r5_54][1])
			sightexports.sGui:setLabelText(nionPmElements[r4_54][3], nionPmList[r5_54][2])
			if type(nionPmList[r5_54][3]) == "nil" then
				if r0_54 then
					sightlangCondHandl3(true)
				else
					nionPmList[r5_54][3] = false
					if fileExists("nionpm/" .. nionPmList[r5_54][1] .. ".sight") then
						r0_54 = true
						local r6_54 = fileOpen("nionpm/" .. nionPmList[r5_54][1] .. ".sight")
						local r7_54 = ""
						local r8_54 = fileGetSize(r6_54) - 2
						while 0 <= r8_54 do
							fileSetPos(r6_54, r8_54)
							local r9_54 = fileRead(r6_54, 1)
							r8_54 = r8_54 - 1
							local r10_54 = r9_54
							r7_54 = r10_54 .. r7_54
							if r9_54 == "\n" then
								--goto label_154	-- block#13 is visited secondly
							end
						end
						fileClose(r6_54)
						local r9_54 = split(r7_54, "#")
						local r10_54 = tonumber(r9_54[1])
						table.remove(r9_54, 1)
						if r10_54 then
							local r11_54 = tonumber(r9_54[1])
							table.remove(r9_54, 1)
							local r12_54 = table.concat(r9_54, "#")
							if utf8.len(r12_54) > 24 then
								r12_54 = utf8.sub(r12_54, 1, 21) .. "..."
							end
							nionPmList[r5_54][3] = r12_54
							nionPmList[r5_54][4] = r10_54 == nionPmList[r5_54][1]
						end
					end
				end
			end
			if nionPmList[r5_54][3] then
				sightexports.sGui:setGuiRenderDisabled(nionPmElements[r4_54][4], false)
				sightexports.sGui:setGuiRenderDisabled(nionPmElements[r4_54][5], false)
				sightexports.sGui:setLabelText(nionPmElements[r4_54][5], nionPmList[r5_54][3])
				sightexports.sGui:setGuiSize(nionPmElements[r4_54][4], pmIH / 2 * (nionPmList[r5_54][4] and -1 or 1), false)
				sightexports.sGui:setGuiPosition(nionPmElements[r4_54][4], pmIH / 2 * (nionPmList[r5_54][4] and 1 or 0), false)
			else
				sightexports.sGui:setGuiRenderDisabled(nionPmElements[r4_54][4], true)
				sightexports.sGui:setGuiRenderDisabled(nionPmElements[r4_54][5], true)
			end
		else
			for r9_54 = 1, #nionPmElements[r4_54], 1 do
				sightexports.sGui:setGuiRenderDisabled(nionPmElements[r4_54][r9_54], true)
			end
		end
	end
	local r1_54 = sightNionSh / math.max(1, (#nionPmList - 8 + 1))
	sightexports.sGui:setGuiSize(nionScrollBar, false, r1_54)
	sightexports.sGui:setGuiPosition(nionScrollBar, false, r1_54 * sightNionScroll)
end
function waitAndRefreshPmListScroll()
	-- line: [1927, 1933] id: 55
	sightlangCondHandl3(false)
	if nionPmList then
		refreshPmListScroll()
	end
end
addEvent("gotsightNionPmList", true)
addEventHandler("gotsightNionPmList", getRootElement(), function(r0_56)
	-- line: [1938, 1984] id: 56
	r63_0 = false
	if nionPmList then
		if r0_56 then
			nionPmList = r0_56
			table.sort(nionPmList, sortPmList)
			local r1_56 = {}
			for r5_56 = 1, #nionPmList, 1 do
				r1_56[nionPmList[r5_56][1]] = true
				local r6_56 = getRealTime(nionPmList[r5_56][2])
				nionPmList[r5_56][2] = string.format("%02d. %02d. %02d. %02d:%02d", r6_56.year - 100, r6_56.month + 1, r6_56.monthday, r6_56.hour, r6_56.minute)
			end
			if fileExists("nionpm/list.sight") then
				local r2_56 = fileOpen("nionpm/list.sight")
				if r2_56 then
					local r3_56 = fileRead(r2_56, fileGetSize(r2_56))
					fileClose(r2_56)
					r3_56 = split(r3_56, "\n")
					local r4_56 = {}
					for r8_56 = 1, #r3_56, 1 do
						local r9_56 = tonumber(r3_56[r8_56])
						if not r1_56[r9_56] and fileExists("nionpm/" .. r9_56 .. ".sight") then
							fileDelete("nionpm/" .. r9_56 .. ".sight")
						end
					end
				end
			end
			sightlangCondHandl3(true)
		else
			r0_56 = {}
		end
	end
end)
function waitAndLoadPmList()
	-- line: [1986, 1995] id: 57
	if not r63_0 then
		if nionPmList then
			r63_0 = true
			triggerLatentServerEvent("requestSightNionPmList", localPlayer)
		end
		sightlangCondHandl5(false)
	end
end
function appCloses.sightNion_pm_list()
	-- line: [1997, 2005] id: 58
	sightNionScroll = false
	sightNionSh = false
	nionScrollBar = false
	nionPmList = false
	pmIH = false
	removeEventHandler("onClientKey", getRootElement(), sightNionChatKey)
end
function appScreens.sightNion_pm_list()
	-- line: [2007, 2102] id: 59
	incomingNoti = false
	sightNionScroll = 0
	addEventHandler("onClientKey", getRootElement(), sightNionChatKey)
	appInside = sightexports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside), "solid", "#353535")
	local r1_59 = sightexports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightexports.sGui:setGuiBackground(r1_59, "solid", {
		0,
		0,
		0
	})
	local r2_59 = sightexports.sGui:createGuiElement("label", 8, topSize, bsx, 32, r1_59)
	sightexports.sGui:setLabelFont(r2_59, "12/Ubuntu-R.ttf")
	sightexports.sGui:setLabelAlignment(r2_59, "left", "center")
	sightexports.sGui:setLabelColor(r2_59, "#ffffff")
	sightexports.sGui:setLabelText(r2_59, "Privát beszélgetések")
	local r3_59 = bsy - topSize * 2.5 - 32
	local r4_59 = topSize + 32 + 4
	sightNionSh = r3_59 - 8
	local r5_59 = 8
	r3_59 = (r3_59 - 8) / r5_59
	pmIH = r3_59
	for r9_59 = 1, r5_59, 1 do
		nionPmElements[r9_59] = {}
		local r11_59 = sightexports.sGui:createGuiElement("rectangle", 8, r4_59 + r3_59 * (r9_59 - 1), bsx - 8 - 12, r3_59, appInside)
		sightexports.sGui:setGuiHover(r11_59, "none", false, false, true)
		sightexports.sGui:setGuiHoverable(r11_59, true)
		sightexports.sGui:setClickEvent(r11_59, "opensightNionConversation")
		nionPmElements[r9_59][1] = r11_59
		local r12_59 = sightexports.sGui:createGuiElement("label", 0, 0, bsx - 8 - 12, r3_59 / 2, r11_59)
		sightexports.sGui:setLabelFont(r12_59, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(r12_59, "left", "center")
		sightexports.sGui:setLabelColor(r12_59, "#ffffff")
		sightexports.sGui:setLabelClip(r12_59, true)
		nionPmElements[r9_59][2] = r12_59
		local r13_59 = sightexports.sGui:createGuiElement("label", 0, 0, bsx - 8 - 12, r3_59 / 2, r11_59)
		sightexports.sGui:setLabelFont(r13_59, "10/Ubuntu-LI.ttf")
		sightexports.sGui:setLabelAlignment(r13_59, "right", "center")
		sightexports.sGui:setLabelColor(r13_59, "#ffffff")
		sightexports.sGui:setLabelClip(r13_59, true)
		nionPmElements[r9_59][3] = r13_59
		local r14_59 = sightexports.sGui:createGuiElement("image", 0, r3_59 / 2, r3_59 / 2, r3_59 / 2, r11_59)
		sightexports.sGui:setImageFile(r14_59, sightexports.sGui:getFaIconFilename("reply", r3_59 / 2))
		nionPmElements[r9_59][4] = r14_59
		local r15_59 = sightexports.sGui:createGuiElement("label", r3_59 / 2, r3_59 / 2, bsx - 8 - 12 - r3_59 / 2, r3_59 / 2, r11_59)
		sightexports.sGui:setLabelFont(r15_59, "10/Ubuntu-L.ttf")
		sightexports.sGui:setLabelAlignment(r15_59, "left", "center")
		sightexports.sGui:setLabelColor(r15_59, "#ffffff")
		sightexports.sGui:setLabelClip(r15_59, true)
		nionPmElements[r9_59][5] = r15_59
		if r9_59 < r5_59 then
			local r16_59 = sightexports.sGui:createGuiElement("hr", 0, r3_59 - 1, bsx - 8 - 12, 1, r11_59)
			sightexports.sGui:setGuiHrColor(r16_59, "#222222", "#222222")
			nionPmElements[r9_59][6] = r16_59
		end
		if r9_59 == 1 then
			sightexports.sGui:setGuiRenderDisabled(r11_59, true, true)
			sightexports.sGui:setGuiRenderDisabled(nionPmElements[r9_59][2], false)
			sightexports.sGui:setLabelText(nionPmElements[r9_59][2], "Betöltés...")
		else
			sightexports.sGui:setGuiRenderDisabled(r11_59, true, true)
		end
	end
	local r6_59 = sightexports.sGui:createGuiElement("rectangle", bsx - 9, r4_59, 3, sightNionSh, appInside)
	sightexports.sGui:setGuiBackground(r6_59, "solid", "#444444")
	nionScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 3, sightNionSh, r6_59)
	sightexports.sGui:setGuiBackground(nionScrollBar, "solid", "#181818")
	generateBottom(true, "opensightNionChat")
	bringBackFront()
	nionPmList = {}
	sightlangCondHandl5(true)
end
