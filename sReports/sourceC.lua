local seexports = {sGui = false}
local function seelangProcessExports()
	for k in pairs(seexports) do
		local res = getResourceFromName(k)
		if res and getResourceState(res) == "running" then
			seexports[k] = exports[k]
		else
			seexports[k] = false
		end
	end
end
seelangProcessExports()
if triggerServerEvent then
	addEventHandler("onClientResourceStart", getRootElement(), seelangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
	addEventHandler("onResourceStart", getRootElement(), seelangProcessExports, true, "high+9999999999")
end
screenX, screenY = guiGetScreenSize()
local reportWindow = false
local ratingWindow = false
local messageInput = false
local inputSize = 0
local inputRect = false
local guiClosed = false
local scrollbar = false
local sbBack = false
local reportData = {}
local unreadPlayerMessages = {}
local reportMessages = {}
local waitingToConnectId = false
local writing = false
local otherWriting = false
local writingState = false
local reportClosed = false
addEvent("gotPlayerReport", true)
addEventHandler("gotPlayerReport", getRootElement(), function(data, messages)
	otherWriting = false
	reportClosed = false
	reportData = data
	reportMessages = messages
	unreadPlayerMessages = {}
	for i = 1, #reportMessages do
		local msg = reportMessages[i]
		if msg.seen <= 0 and 0 < msg.sender and msg.sender ~= reportData.sentBy then
			table.insert(unreadPlayerMessages, {
				msg.reportId,
				msg.id
			})
		end
	end
	createReportGui()
end)
local panelWidth = 0
local panelHeight = 0
local titleBarHeight = 0
local messages = {}
local sumH = 0
local currentScroll = 0
local copyMenu = false
local copyMenuId = false
local copyMenuTexts = {}
local keyHandled = false
local reportRating = false
local ratingStars = {}
local currentRating = 0
local hoveringStars = 0
local writingIcon = false
local unreadIcon = false
local unreadLabel = false
local bellIcon = false
local soundState = true
function deleteReportGui()
	writingIcon = false
	unreadIcon = false
	unreadLabel = false
	bellIcon = false
	writing = false
	if writingState then
		triggerServerEvent("changeWritingStatePlayer", localPlayer, writingState, false)
	end
	messages = false
	writingState = false
	if keyHandled then
		removeEventHandler("onClientKey", getRootElement(), reportPanelScrollKey)
	end
	keyHandled = false
	local x, y = false, false
	if reportWindow then
		x, y = seexports.sGui:getGuiPosition(reportWindow)
		seexports.sGui:deleteGuiElement(reportWindow)
	end
	reportWindow = false
	messageInput = false
	inputRect = false
	return x, y
end
addEvent("copyReportToClipboard", false)
addEventHandler("copyReportToClipboard", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if copyMenuTexts[el] then
		if setClipboard(copyMenuTexts[el]) then
			seexports.sGui:showInfobox("s", "Sikeresen a vágólapra másoltad a szöveget.")
			outputConsole("[Report] Vágólapra másolva: " .. copyMenuTexts[el])
		else
			outputChatBox("[color=sightred][SightMTA - Report]:#ffffff Sikertelen másolás: " .. copyMenuTexts[el])
		end
		if copyMenu then
			seexports.sGui:deleteGuiElement(copyMenu)
		end
		copyMenu = false
		copyMenuTexts = {}
		copyMenuId = false
	end
end)
addEvent("openURLFromReport", false)
addEventHandler("openURLFromReport", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if copyMenuTexts[el] then
		openURL(copyMenuTexts[el])
		if copyMenu then
			seexports.sGui:deleteGuiElement(copyMenu)
		end
		copyMenu = false
		copyMenuTexts = {}
		copyMenuId = false
	end
end)
addEvent("openCopyMenuReport", false)
addEventHandler("openCopyMenuReport", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if copyMenu then
		seexports.sGui:deleteGuiElement(copyMenu)
	end
	copyMenu = false
	copyMenuTexts = {}
	local msg = false
	for i = #messages, 1, -1 do
		if messages[i][1] == el then
			msg = i
			break
		end
	end
	local was = copyMenuId
	copyMenuId = false
	if msg and messages[msg][8] and was ~= msg then
		copyMenuId = msg
		local x, y = seexports.sGui:getGuiRealPosition(el)
		x = absoluteX - x + 8
		y = absoluteY - y
		copyMenu = seexports.sGui:createGuiElement("null", x, y, 200, 20 * (1 + #messages[msg][8]), el)
		local btn = seexports.sGui:createGuiElement("button", 0, 0, 200, 20, copyMenu)
		seexports.sGui:setGuiBackground(btn, "solid", "sightgrey")
		seexports.sGui:setGuiHover(btn, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		seexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
		seexports.sGui:setButtonTextColor(btn, "#ffffff")
		seexports.sGui:setButtonText(btn, "Szöveg másolása")
		copyMenuTexts[btn] = messages[msg][9]
		seexports.sGui:disableClickTrough(btn, true)
		seexports.sGui:setClickEvent(btn, "copyReportToClipboard")
		for i = 1, #messages[msg][8] do
			local btn = seexports.sGui:createGuiElement("button", 0, 20 * i, 200, 20, copyMenu)
			seexports.sGui:setGuiBackground(btn, "solid", "sightgrey")
			seexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			seexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
			seexports.sGui:setButtonTextColor(btn, "#ffffff")
			seexports.sGui:disableClickTrough(btn, true)
			seexports.sGui:setClickEvent(btn, "openURLFromReport")
			copyMenuTexts[btn] = messages[msg][8][i]
			if utf8.len(messages[msg][8][i]) > 33 then
				seexports.sGui:setButtonText(btn, utf8.sub(messages[msg][8][i], 1, 30) .. "...")
			else
				seexports.sGui:setButtonText(btn, messages[msg][8][i])
			end
		end
	end
end)
function reportPanelScrollKey(key)
	if key == "mouse_wheel_down" then
		local tmp = currentScroll
		tmp = currentScroll - 24
		if tmp < 0 then
			tmp = 0
		end
		if tmp ~= currentScroll then
			currentScroll = tmp
			processReportMessages()
		end
	elseif key == "mouse_wheel_up" then
		local tmp = currentScroll
		tmp = currentScroll + 24
		local max = sumH
		if 0 < max then
			if tmp > max then
				tmp = max
			end
			if tmp ~= currentScroll then
				currentScroll = tmp
				processReportMessages()
			end
		end
	end
end
function deleteMessage(i, byId)
	if not guiClosed then
		if byId then
			i = false
			for j = #messages, 1, -1 do
				if messages[j] and messages[j][7] == i then
					i = j
				end
			end
		end
		if i and messages[i] then
			if messages[i][1] then
				seexports.sGui:deleteGuiElement(messages[i][1])
			end
			for j = 1, #messages[i][3] do
				seexports.sGui:deleteGuiElement(messages[i][3][j][1])
			end
			if messages[i][5] then
				for j = 1, #messages[i][5] do
					seexports.sGui:deleteGuiElement(messages[i][5][j][1])
				end
			end
			if byId then
				table.remove(messages, i)
			end
		end
	end
end
function processReportMessages()
	if not guiClosed then
		local y = panelHeight - inputSize
		local by = y
		local ty = titleBarHeight
		if writing then
			y = y - 24
			seexports.sGui:setGuiPosition(writing, false, y)
			by = y
			y = y + 6
		end
		y = y + currentScroll
		sumH = 0
		for i = #messages, 1, -1 do
			y = y - messages[i][4] - 12
			sumH = sumH + messages[i][4] + 12
			if messages[i][1] then
				local sy = messages[i][2][2]
				local y = y + messages[i][2][1]
				if ty > y and by < y + sy then
					seexports.sGui:setGuiSize(messages[i][1], false, by - ty)
					seexports.sGui:setGuiPosition(messages[i][1], false, ty)
				elseif ty > y + sy then
					seexports.sGui:setGuiRenderDisabled(messages[i][1], true)
				elseif by < y then
					seexports.sGui:setGuiRenderDisabled(messages[i][1], true)
				elseif by < y + sy then
					seexports.sGui:setGuiRenderDisabled(messages[i][1], false)
					seexports.sGui:setGuiSize(messages[i][1], false, by - y)
					seexports.sGui:setGuiPosition(messages[i][1], false, y)
				elseif ty > y then
					seexports.sGui:setGuiRenderDisabled(messages[i][1], false)
					seexports.sGui:setGuiPosition(messages[i][1], false, ty)
					seexports.sGui:setGuiSize(messages[i][1], false, y + sy - ty)
				else
					seexports.sGui:setGuiRenderDisabled(messages[i][1], false)
					seexports.sGui:setGuiPosition(messages[i][1], false, y)
					seexports.sGui:setGuiSize(messages[i][1], false, sy)
				end
			end
			for j = 1, #messages[i][3] do
				local y = y + messages[i][3][j][2]
				local sy = messages[i][3][j][3]
				if ty > y + sy then
					seexports.sGui:setGuiRenderDisabled(messages[i][3][j][1], true)
				elseif by < y then
					seexports.sGui:setGuiRenderDisabled(messages[i][3][j][1], true)
				elseif by < y + sy then
					seexports.sGui:setGuiRenderDisabled(messages[i][3][j][1], false)
					seexports.sGui:setGuiSize(messages[i][3][j][1], false, by - y)
					seexports.sGui:setGuiPosition(messages[i][3][j][1], false, y)
					seexports.sGui:setLabelAlignment(messages[i][3][j][1], false, "top")
				elseif ty > y then
					seexports.sGui:setGuiRenderDisabled(messages[i][3][j][1], false)
					seexports.sGui:setGuiSize(messages[i][3][j][1], false, y + sy - ty)
					seexports.sGui:setGuiPosition(messages[i][3][j][1], false, ty)
					seexports.sGui:setLabelAlignment(messages[i][3][j][1], false, "bottom")
				else
					seexports.sGui:setGuiRenderDisabled(messages[i][3][j][1], false)
					seexports.sGui:setGuiPosition(messages[i][3][j][1], false, y)
					seexports.sGui:setGuiSize(messages[i][3][j][1], false, sy)
				end
			end
			if messages[i][5] then
				for j = 1, #messages[i][5] do
					local y = y + messages[i][5][j][2]
					local sy = messages[i][5][j][4]
					if ty > y + sy then
						seexports.sGui:setGuiRenderDisabled(messages[i][5][j][1], true)
					elseif by < y then
						seexports.sGui:setGuiRenderDisabled(messages[i][5][j][1], true)
					elseif by < y + sy then
						seexports.sGui:setGuiRenderDisabled(messages[i][5][j][1], false)
						seexports.sGui:setGuiSize(messages[i][5][j][1], false, by - y)
						seexports.sGui:setImageUV(messages[i][5][j][1], 0, 0, messages[i][5][j][3], by - y)
						seexports.sGui:setGuiPosition(messages[i][5][j][1], false, y)
					elseif ty > y then
						seexports.sGui:setGuiRenderDisabled(messages[i][5][j][1], false)
						seexports.sGui:setGuiSize(messages[i][5][j][1], false, y + sy - ty)
						seexports.sGui:setImageUV(messages[i][5][j][1], 0, sy - (y + sy - ty), messages[i][5][j][3], y + sy - ty)
						seexports.sGui:setGuiPosition(messages[i][5][j][1], false, ty)
					else
						seexports.sGui:setGuiRenderDisabled(messages[i][5][j][1], false)
						seexports.sGui:setGuiPosition(messages[i][5][j][1], false, y)
						seexports.sGui:setGuiSize(messages[i][5][j][1], false, sy)
						seexports.sGui:setImageUV(messages[i][5][j][1])
					end
				end
			end
		end
		local sy = panelHeight - titleBarHeight - inputSize - 16
		local div = (sy + 16) / sumH
		sumH = math.max(0, sumH - (panelHeight - inputSize) + titleBarHeight + 16)
		local progress = 1 - (0 < sumH and currentScroll / sumH or 0)
		if div < 0 then
			div = 0
		end
		if 1 < div then
			div = 1
		end
		local sh = sy * div
		seexports.sGui:setGuiSize(sbBack, false, sy)
		seexports.sGui:setGuiPosition(scrollbar, false, titleBarHeight + 8 + (sy - sh) * progress)
		seexports.sGui:setGuiSize(scrollbar, false, sh)
		if currentScroll > sumH then
			currentScroll = sumH
			processReportMessages()
		end
	end
end
function createSystemMessageEx(text, id)
	if not guiClosed then
		local labels = {}
		local h = seexports.sGui:getFontHeight("10/Ubuntu-R.ttf")
		local sy = 0
		if type(text) == "table" then
			local h2 = seexports.sGui:getFontHeight("10/Ubuntu-R.ttf")
			for i = 1, #text do
				local label = seexports.sGui:createGuiElement("label", 0, (i - 1) * h, panelWidth - 6, i <= 1 and h2 or h, reportWindow)
				seexports.sGui:setLabelFont(label, "10/Ubuntu-" .. (i <= 1 and "R" or "R") .. ".ttf")
				seexports.sGui:setLabelColor(label, 1 < i and "sightgreen" or "#a0a0a0")
				seexports.sGui:setLabelText(label, text[i])
				seexports.sGui:setLabelClip(label, true)
				seexports.sGui:setLabelAlignment(label, "center", "center")
				table.insert(labels, {
					label,
					(i - 1) * h,
					i <= 1 and h2 or h
				})
				sy = sy + (i <= 1 and h2 or h)
			end
		else
			local label = seexports.sGui:createGuiElement("label", 0, 0, panelWidth - 6, h, reportWindow)
			seexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
			seexports.sGui:setLabelText(label, text)
			seexports.sGui:setLabelClip(label, true)
			seexports.sGui:setLabelColor(label, "#a0a0a0")
			seexports.sGui:setLabelAlignment(label, "center", "center")
			table.insert(labels, {
				label,
				0,
				h
			})
			sy = sy + h
		end
		if not id then
			for i = #messages, 1, -1 do
				if 0 > messages[i][7] then
					id = messages[i][7] - 1
					break
				end
			end
		end
		id = id or -(#messages + 1)
		table.insert(messages, {
			false,
			false,
			labels,
			sy,
			false,
			false,
			id
		})
		return id
	end
end
function createSystemMessage(text, id)
	if not guiClosed then
		local labels = {}
		local h = seexports.sGui:getFontHeight("10/Ubuntu-R.ttf")
		local sy = 0
		if type(text) == "table" then
			local h2 = seexports.sGui:getFontHeight("10/Ubuntu-R.ttf")
			for i = 1, #text do
				local label = seexports.sGui:createGuiElement("label", 0, (i - 1) * h, panelWidth - 6, 1 < i and h2 or h, reportWindow)
				seexports.sGui:setLabelFont(label, "10/Ubuntu-" .. (1 < i and "R" or "R") .. ".ttf")
				seexports.sGui:setLabelColor(label, "#a0a0a0")
				seexports.sGui:setLabelText(label, text[i])
				seexports.sGui:setLabelClip(label, true)
				seexports.sGui:setLabelAlignment(label, "center", "center")
				table.insert(labels, {
					label,
					(i - 1) * h,
					1 < i and h2 or h
				})
				sy = sy + (1 < i and h2 or h)
			end
		else
			local label = seexports.sGui:createGuiElement("label", 0, 0, panelWidth - 6, h, reportWindow)
			seexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
			seexports.sGui:setLabelText(label, text)
			seexports.sGui:setLabelClip(label, true)
			seexports.sGui:setLabelColor(label, "#a0a0a0")
			seexports.sGui:setLabelAlignment(label, "center", "center")
			table.insert(labels, {
				label,
				0,
				h
			})
			sy = sy + h
		end
		if not id then
			for i = #messages, 1, -1 do
				if 0 > messages[i][7] then
					id = messages[i][7] - 1
					break
				end
			end
		end
		id = id or -(#messages + 1)
		table.insert(messages, {
			false,
			false,
			labels,
			sy,
			false,
			false,
			id
		})
		return id
	end
end
function checkURL(text)
	local https = utf8.find(text, "^[https//:]+%w+%.%w+[/%w%.%-%_%+%=%?%&%s*@#]+$")
	if https then
		return https
	end
	return utf8.find(text, "^[http//:]+%w+%.%w+[/%w%.%-%_%+%=%?%&%s*@#]+$")
end
function createMessage(date, text, self, id, checkdate, seen, replace)
	if not guiClosed then
		local checkEls = {}
		local labels = {}
		local imgs = {}
		local msgW = panelWidth - 80
		local h3 = seexports.sGui:getFontHeight("9/Ubuntu-R.ttf")
		local h2 = h3
		local h = seexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
		local textIn = text
		local data = split(text, " ")
		local urls = {}
		local lines = {}
		local sy = h
		local text = false
		local textEx = false
		local line = false
		local isUrl = checkURL(data[1])
		if isUrl then
			table.insert(urls, data[1])
			text = ""
			textEx = data[1]
			line = {
				{
					data[1],
					"#2048a2"
				}
			}
		else
			text = data[1]
			textEx = data[1]
			line = {}
		end
		for i = 2, #data do
			local word = data[i]
			local w = seexports.sGui:getTextWidthFont(textEx .. " " .. word, "11/Ubuntu-R.ttf", 1, true)
			local isUrl = checkURL(word)
			if isUrl then
				table.insert(urls, word)
			end
			if w >= msgW - 8 then
				table.insert(line, {text})
				table.insert(lines, line)
				sy = sy + h
				if isUrl then
					line = {
						{word, "#2048a2"}
					}
					text = ""
					textEx = word
				else
					line = {}
					text = word
					textEx = word
				end
			else
				if isUrl then
					table.insert(line, {text})
					table.insert(line, {
						" " .. word,
						"#2048a2"
					})
					text = ""
				else
					text = text .. " " .. word
				end
				textEx = textEx .. " " .. word
			end
		end
		table.insert(line, {text})
		table.insert(lines, line)
		sy = sy + 8
		local label = seexports.sGui:createGuiElement("label", self and panelWidth - 6 - msgW or 8, 0, msgW - 8, h2, reportWindow)
		seexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
		seexports.sGui:setLabelText(label, date)
		seexports.sGui:setLabelColor(label, "#a0a0a0")
		seexports.sGui:setLabelClip(label, true)
		seexports.sGui:setLabelAlignment(label, self and "right" or "left", "center")
		table.insert(labels, {
			label,
			0,
			h2
		})
		local rect = seexports.sGui:createGuiElement("rectangle", self and panelWidth - 6 - msgW - 8 or 8, h2 + 4, msgW, sy, reportWindow)
		seexports.sGui:setGuiBackground(rect, "solid", self and "sightgreen" or "sightblue")
		seexports.sGui:setGuiHover(rect, "gradient", {
			self and "sightgreen" or "sightblue",
			(self and "sightgreen" or "sightblue") .. "-second"
		}, false, true)
		seexports.sGui:setGuiHoverable(rect, true)
		seexports.sGui:setClickEvent(rect, "openCopyMenuReport")
		local lastLabel = false
		local w = 0
		for i = 1, #lines do
			for j = 1, #lines[i] do
				if lastLabel then
					w = w + seexports.sGui:getLabelTextWidth(lastLabel)
				end
				local label = seexports.sGui:createGuiElement("label", (self and panelWidth - 6 - msgW - 4 or 12) + w, h2 + 8 + (i - 1) * h, msgW - 8, h, reportWindow)
				seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
				seexports.sGui:setLabelText(label, lines[i][j][1])
				if lines[i][j][2] then
					seexports.sGui:setLabelColor(label, lines[i][j][2])
				end
				seexports.sGui:setLabelClip(label, true)
				seexports.sGui:setLabelAlignment(label, "left", "center")
				table.insert(labels, {
					label,
					h2 + 8 + (i - 1) * h,
					h
				})
				lastLabel = label
			end
			w = 0
			lastLabel = false
		end
		local ph = 0
		if checkdate then
			local time = getRealTime(checkdate)
			local label = seexports.sGui:createGuiElement("label", self and panelWidth - 6 - msgW or 8, h2 + 8 + #lines * h + 8, msgW - 8, h3, reportWindow)
			seexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
			seexports.sGui:setLabelColor(label, seen and "sightgreen" or "#a0a0a0")
			if getRealTime().yearday == time.yearday then
				seexports.sGui:setLabelText(label, string.format("%02d:%02d:%02d", time.hour, time.minute, time.second))
			else
				seexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second))
			end
			seexports.sGui:setLabelClip(label, true)
			seexports.sGui:setLabelAlignment(label, "right", "center")
			table.insert(labels, {
				label,
				h2 + 8 + #lines * h + 8,
				h3
			})
			table.insert(checkEls, label)
			local icon = seexports.sGui:createGuiElement("image", (self and panelWidth - 6 - msgW or 8) + msgW - 8 - seexports.sGui:getLabelTextWidth(label) - h3, h2 + 8 + #lines * h + 8, h3, h3, reportWindow)
			seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("check", h3))
			seexports.sGui:setImageColor(icon, seen and "sightgreen" or "#a0a0a0")
			table.insert(imgs, {
				icon,
				h2 + 8 + #lines * h + 8,
				h3,
				h3
			})
			table.insert(checkEls, icon)
			ph = h3
		end
		if not id then
			for i = #messages, 1, -1 do
				if 0 > messages[i][7] then
					id = messages[i][7] - 1
					break
				end
			end
		end
		id = id or -(#messages + 1)
		if replace then
			local found = #messages + 1
			for i = 1, #messages do
				if messages[i] and messages[i][7] == id then
					deleteMessage(i)
					found = i
					break
				end
			end
			id = tonumber(replace) or id
			messages[found] = {
				rect,
				{
					h2 + 4,
					sy
				},
				labels,
				sy + h2 + 4 + ph,
				imgs,
				checkEls,
				id,
				urls,
				textIn
			}
		else
			table.insert(messages, {
				rect,
				{
					h2 + 4,
					sy
				},
				labels,
				sy + h2 + 4 + ph,
				imgs,
				checkEls,
				id,
				urls,
				textIn
			})
		end
		return id
	end
end
afkState = getElementData(localPlayer, "afk")
addEventHandler("onClientElementDataChange", localPlayer, function(data, old, new)
	if data == "afk" then
		afkState = new
		if not afkState then
			processReportPlayerUnread()
			processReportAdminUnread()
		end
	end
end)
function processReportPlayerUnread()
	if reportData and not guiClosed and not afkState then
		local tmp = {}
		for i = #unreadPlayerMessages, 1, -1 do
			if reportData.id == unreadPlayerMessages[i][1] then
				table.insert(tmp, unreadPlayerMessages[i])
				table.remove(unreadPlayerMessages, i)
			end
		end
		triggerServerEvent("processUnreadMessages", localPlayer, tmp)
	end
	if reportData then
		if seexports.sGui:isGuiElementValid(unreadIcon) then
			seexports.sGui:setImageColor(unreadIcon, {
				255,
				255,
				255,
				0 < #unreadPlayerMessages and 255 or 0
			})
		end
		if seexports.sGui:isGuiElementValid(unreadLabel) then
			seexports.sGui:setLabelText(unreadLabel, 0 < #unreadPlayerMessages and #unreadPlayerMessages or "")
			processWritingIcon()
		end
	end
end
addEvent("reportPlayerMessageSeen", true)
addEventHandler("reportPlayerMessageSeen", getRootElement(), function(data)
	for i = 1, #data do
		local report, id, ts = data[i][1], data[i][2], data[i][3]
		if reportData and reportData.id == report then
			for i = #reportMessages, 1, -1 do
				if reportMessages[i].id == id then
					reportMessages[i].seen = ts
					local time = getRealTime(reportMessages[i].date)
					local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
					createMessage(date, reportMessages[i].message, true, id, ts, true, true)
					break
				end
			end
		end
	end
	processReportMessages()
end)
addEvent("newMessageForPlayer", true)
addEventHandler("newMessageForPlayer", getRootElement(), function(msg, lid)
	local report = msg.reportId
	if not reportMessages then
		reportMessages = {}
	end
	table.insert(reportMessages, msg)
	if reportData and reportData.id == report then
		local time = getRealTime(msg.date)
		local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
		if msg.sender == 0 then
			createSystemMessageEx({
				date,
				msg.message
			})
		elseif msg.sender == reportData.sentBy then
			createMessage(date, msg.message, true, lid or msg.id, math.max(msg.date, msg.seen), 0 < msg.seen, msg.id)
		else
			createMessage(date, msg.message, false, lid or msg.id, false, false, msg.id)
		end
		if 0 >= msg.seen and msg.sender > 0 and msg.sender ~= reportData.sentBy then
			table.insert(unreadPlayerMessages, {
				msg.reportId,
				msg.id
			})
		end
		if soundState and msg.sender ~= reportData.sentBy then
			if guiClosed then
				playSound("files/message.wav")
			else
				playSound("files/message2.wav")
			end
		end
		if waitingToConnectId then
			deleteMessage(waitingToConnectId, true)
			waitingToConnectId = createSystemMessage("Várakozás admin csatlakozására...")
		end
		processReportPlayerUnread()
		processReportMessages()
	end
end)
addEvent("adminChangeOnReport", true)
addEventHandler("adminChangeOnReport", getRootElement(), function(report, adminId, adminName)
	if report and reportData and reportData.id == report then
		reportData.adminId = adminId
		reportData.adminName = adminName
		if not guiClosed then
			if reportData.adminId <= 0 then
				waitingToConnectId = createSystemMessage("Várakozás admin csatlakozására...")
			else
				deleteMessage(waitingToConnectId, true)
				waitingToConnectId = false
			end
		end
		processReportMessages()
	end
end)
addEvent("playerWritingState", true)
addEventHandler("playerWritingState", getRootElement(), function(report, state)
	if report and reportData and reportData.id == report then
		otherWriting = state
		if not guiClosed then
			if writing then
				seexports.sGui:deleteGuiElement(writing)
			end
			writing = false
			if state then
				writing = seexports.sGui:createGuiElement("label", 0, 0, panelWidth, 24, reportWindow)
				seexports.sGui:setLabelFont(writing, "10/Ubuntu-R.ttf")
				seexports.sGui:setLabelText(writing, state .. " éppen ír...")
				seexports.sGui:setLabelClip(writing, true)
				seexports.sGui:setLabelColor(writing, "#a0a0a0")
				seexports.sGui:setLabelAlignment(writing, "center", "center")
			end
			processReportMessages()
		end
		processWritingIcon()
	end
end)
addEvent("sendReportMessage", false)
addEventHandler("sendReportMessage", getRootElement(), function()
	if reportData and not guiClosed then
		local message = seexports.sGui:getInputValue(messageInput)
		if message and utf8.len(message) > 0 then
			if 0 >= reportData.adminId then
				seexports.sGui:showInfobox("e", "Ezt az ügyet nem vállalta el senki!")
				return
			end
			local time = getRealTime()
			local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
			local id = createMessage(date, message, true, false)
			processReportMessages()
			triggerServerEvent("sendReportMessage", localPlayer, reportData.id, message, id)
			seexports.sGui:resetInput(messageInput)
			seexports.sGui:setActiveInput(false)
		end
	end
end)
addEvent("closeReport", true)
addEventHandler("closeReport", getRootElement(), function(report)
	if reportData and reportData.id == report then
		reportRating = report
		createReportRatingGui()
		reportClosed = true
		guiClosed = false
		createReportGui()
	end
end)
addEvent("closeReportFinal", true)
addEventHandler("closeReportFinal", getRootElement(), function()
	reportClosed = false
	otherWriting = false
	reportData = false
	reportMessages = false
	deleteReportGui()
end)
addEventHandler("onActiveInputChange", getRootElement(), function(el, was)
	if messageInput and (messageInput == el or messageInput == was) then
		if reportData then
			local state = messageInput == el
			local id = reportData.id
			writingState = state and id or false
			triggerServerEvent("changeWritingStatePlayer", localPlayer, id, state)
		end
		inputSize = 32 * (messageInput == el and 3 or 1) + 8
		seexports.sGui:setGuiPosition(messageInput, false, panelHeight - (inputSize - 8) - 4)
		seexports.sGui:setGuiSize(messageInput, false, inputSize - 8)
		seexports.sGui:setGuiPosition(inputRect, false, panelHeight - inputSize)
		seexports.sGui:setGuiSize(inputRect, false, inputSize)
		processReportMessages()
	end
end)
addEvent("ratingStarHover", true)
addEventHandler("ratingStarHover", getRootElement(), function(el, state)
	if state then
		local full = true
		local w = (panelWidth - 200) / 5
		for i = 1, 5 do
			seexports.sGui:setImageFile(ratingStars[i], seexports.sGui:getFaIconFilename("star", w, full and "solid" or "regular"))
			seexports.sGui:setImageColor(ratingStars[i], full and "sightyellow" or "#ffffff")
			if ratingStars[i] == el then
				full = false
			end
		end
	end
end)
addEvent("ratingStarClicked", true)
addEventHandler("ratingStarClicked", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	local full = true
	local w = (panelWidth - 200) / 5
	for i = 1, 5 do
		seexports.sGui:setImageFile(ratingStars[i], seexports.sGui:getFaIconFilename("star", w, full and "solid" or "regular"))
		seexports.sGui:setImageColor(ratingStars[i], full and "sightyellow" or "#ffffff")
		if ratingStars[i] == el then
			currentRating = i
			full = false
		end
	end
end)
addEvent("ratingStarHoverOff", true)
addEventHandler("ratingStarHoverOff", getRootElement(), function(el, state)
	if not state then
		local full = 0 < currentRating
		local w = (panelWidth - 200) / 5
		for i = 1, 5 do
			seexports.sGui:setImageFile(ratingStars[i], seexports.sGui:getFaIconFilename("star", w, full and "solid" or "regular"))
			seexports.sGui:setImageColor(ratingStars[i], full and "sightyellow" or "#ffffff")
			if i == currentRating then
				full = false
			end
		end
	end
end)
addEvent("sendReportRating", true)
addEventHandler("sendReportRating", getRootElement(), function()
	if 0 < currentRating then
		if reportRating then
			triggerServerEvent("sendReportRating", localPlayer, reportRating, currentRating, seexports.sGui:getInputValue(ratingInput))
		end
		if ratingWindow then
			seexports.sGui:deleteGuiElement(ratingWindow)
		end
		reportRating = false
		ratingWindow = nil
		reportRating = false
	end
end)
function createReportRatingGui()
	if ratingWindow then
		seexports.sGui:deleteGuiElement(ratingWindow)
	end
	ratingWindow = nil
	titleBarHeight = seexports.sGui:getTitleBarHeight()
	panelWidth = 425
	panelHeight = titleBarHeight + 250
	ratingWindow = seexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
	seexports.sGui:setWindowTitle(ratingWindow, "16/BebasNeueRegular.otf", "Report " .. reportRating .. " értékelése")
	local label = seexports.sGui:createGuiElement("label", 0, titleBarHeight, panelWidth, 32, ratingWindow)
	seexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
	seexports.sGui:setLabelText(label, "Kérjük értékeld az ügyintézést, ezzel segítve a munkánkat!")
	seexports.sGui:setLabelClip(label, true)
	seexports.sGui:setLabelColor(label, "#ffffff")
	seexports.sGui:setLabelAlignment(label, "center", "center")
	local w = (panelWidth - 200) / 5
	ratingStars = {}
	currentRating = 0
	local rect = seexports.sGui:createGuiElement("rectangle", 100, titleBarHeight + 32, w * 5, w, ratingWindow)
	seexports.sGui:setGuiBackground(rect, "solid", "sightgrey2")
	seexports.sGui:setGuiHover(rect, "none")
	seexports.sGui:setGuiHoverable(rect, true)
	seexports.sGui:setHoverEvent(rect, "ratingStarHoverOff")
	for i = 1, 5 do
		local icon = seexports.sGui:createGuiElement("image", 100 + w * (i - 1), titleBarHeight + 32, w, w, ratingWindow)
		seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("star", w, "regular"))
		seexports.sGui:setGuiHoverable(icon, true)
		seexports.sGui:setClickEvent(icon, "ratingStarClicked")
		seexports.sGui:setHoverEvent(icon, "ratingStarHover")
		ratingStars[i] = icon
	end
	local sy = panelHeight - titleBarHeight - 32 - w - 16 - 30 - 8
	ratingInput = seexports.sGui:createGuiElement("input", 8, panelHeight - sy - 8 - 30 - 8, panelWidth - 16, sy, ratingWindow)
	seexports.sGui:setInputFont(ratingInput, "10/Ubuntu-R.ttf")
	seexports.sGui:setInputPlaceholder(ratingInput, "Szöveges értékelés")
	seexports.sGui:setInputMaxLength(ratingInput, 255)
	seexports.sGui:setInputMultiline(ratingInput, true)
	seexports.sGui:setInputFontPaddingHeight(ratingInput, 32)
	local w = (panelWidth - 24) / 2
	local btn = seexports.sGui:createGuiElement("button", 8, panelHeight - 30 - 8, panelWidth - 16, 30, ratingWindow)
	seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	seexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	seexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
	seexports.sGui:setButtonTextColor(btn, "#ffffff")
	seexports.sGui:setButtonText(btn, "Értékelés elküldése")
	seexports.sGui:setClickEvent(btn, "sendReportRating")
end

addEvent("toggleGuiClose", false)
addEventHandler("toggleGuiClose", getRootElement(), function()
	guiClosed = not guiClosed
	createReportGui()
end)
addEvent("togglePlayerReportSound", false)
addEventHandler("togglePlayerReportSound", getRootElement(), function()
	soundState = not soundState
	local ih = titleBarHeight - 8
	seexports.sGui:setImageFile(bellIcon, seexports.sGui:getFaIconFilename(soundState and "bell" or "bell-slash", ih))
	seexports.sGui:setImageColor(bellIcon, soundState and "#ffffff" or "#a0a0a0")
end)
function processWritingIcon()
	if writingIcon then
		local ih = titleBarHeight - 8
		local x = panelWidth - titleBarHeight - ih * (0 < #unreadPlayerMessages and 3.5 or 2)
		seexports.sGui:setGuiRenderDisabled(writingIcon, not otherWriting)
		seexports.sGui:setGuiPosition(writingIcon, x, false)
	end
end
function createReportGui()
	copyMenu = false
	copyMenuTexts = {}
	copyMenuId = false
	local x, y = deleteReportGui()
	currentScroll = 0
	titleBarHeight = seexports.sGui:getTitleBarHeight()
	panelWidth = 325
	panelHeight = titleBarHeight + (guiClosed and 0 or 450)
	if not keyHandled then
		addEventHandler("onClientKey", getRootElement(), reportPanelScrollKey)
	end
	keyHandled = true
	reportWindow = seexports.sGui:createGuiElement("window", x or screenX / 2 - panelWidth / 2, y or screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
	seexports.sGui:setWindowTitle(reportWindow, "16/BebasNeueRegular.otf", "Report " .. reportData.id)
	local ih = titleBarHeight - 8
	bellIcon = seexports.sGui:createGuiElement("image", panelWidth - titleBarHeight - ih * 1, titleBarHeight / 2 - ih / 2, ih, ih, reportWindow)
	seexports.sGui:setImageFile(bellIcon, seexports.sGui:getFaIconFilename(soundState and "bell" or "bell-slash", ih))
	seexports.sGui:setImageColor(bellIcon, soundState and "#ffffff" or "#a0a0a0")
	seexports.sGui:setGuiHoverable(bellIcon, true)
	seexports.sGui:setGuiHover(bellIcon, "solid", "sightgreen")
	seexports.sGui:setClickEvent(bellIcon, "togglePlayerReportSound")
	writingIcon = seexports.sGui:createGuiElement("image", panelWidth - titleBarHeight - ih * 3.5, titleBarHeight / 2 - ih / 2, ih, ih, reportWindow)
	seexports.sGui:setImageFile(writingIcon, seexports.sGui:getFaIconFilename("pen", ih))
	processWritingIcon()
	unreadIcon = seexports.sGui:createGuiElement("image", panelWidth - titleBarHeight - ih * 2.5, titleBarHeight / 2 - ih / 2, ih, ih, reportWindow)
	seexports.sGui:setImageFile(unreadIcon, seexports.sGui:getFaIconFilename("envelope", ih))
	unreadLabel = seexports.sGui:createGuiElement("label", panelWidth - titleBarHeight - ih * 1.5, 0, ih * 0.5, titleBarHeight, reportWindow)
	seexports.sGui:setLabelFont(unreadLabel, "10/Ubuntu-R.ttf")
	seexports.sGui:setLabelAlignment(unreadLabel, "center", "center")
	seexports.sGui:setImageColor(unreadIcon, {
		255,
		255,
		255,
		0 < #unreadPlayerMessages and 255 or 0
	})
	seexports.sGui:setLabelText(unreadLabel, 0 < #unreadPlayerMessages and #unreadPlayerMessages or "")
	local icon = seexports.sGui:createGuiElement("image", panelWidth - titleBarHeight, titleBarHeight / 2 - ih / 2, ih, ih, reportWindow)
	seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename(guiClosed and "angle-down" or "angle-up", ih))
	seexports.sGui:setGuiHoverable(icon, true)
	seexports.sGui:setGuiHover(icon, "solid", "sightgreen")
	seexports.sGui:setClickEvent(icon, "toggleGuiClose")
	seexports.sGui:disableClickTrough(icon, true)
	if not guiClosed then
		inputSize = 40
		inputRect = seexports.sGui:createGuiElement("rectangle", 0, panelHeight - inputSize, panelWidth, inputSize, reportWindow)
		seexports.sGui:setGuiBackground(inputRect, "solid", "sightgrey1")
		if reportClosed then
			local btn = seexports.sGui:createGuiElement("button", 4, panelHeight - inputSize + 4, panelWidth - 8, inputSize - 8, reportWindow)
			seexports.sGui:setGuiBackground(btn, "solid", "sightblue")
			seexports.sGui:setGuiHover(btn, "gradient", {
				"sightblue",
				"sightblue-second"
			}, false, true)
			seexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
			seexports.sGui:setButtonTextColor(btn, "#ffffff")
			seexports.sGui:setButtonText(btn, "Report bezárása")
			seexports.sGui:setClickEvent(btn, "closeReportFinal")
			inputSize = 40
		else
			messageInput = seexports.sGui:createGuiElement("input", 4, panelHeight - (inputSize - 8) - 4, panelWidth - 8 - 32 - 4, inputSize - 8, reportWindow)
			seexports.sGui:setInputFont(messageInput, "10/Ubuntu-R.ttf")
			seexports.sGui:setInputPlaceholder(messageInput, "Üzenet")
			seexports.sGui:setInputMaxLength(messageInput, 255)
			seexports.sGui:setInputMultiline(messageInput, true)
			seexports.sGui:setInputFontPaddingHeight(messageInput, 32)
			local icon = seexports.sGui:createGuiElement("image", panelWidth - 32 - 4, panelHeight - 32 - 4, 32, 32, reportWindow)
			seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("paper-plane", 32))
			seexports.sGui:setGuiHoverable(icon, true)
			seexports.sGui:setGuiHover(icon, "solid", "sightgreen")
			seexports.sGui:setClickEvent(icon, "sendReportMessage", true)
		end
		messages = {}
		local time = getRealTime(reportData.created)
		local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
		createSystemMessage({
			"Bejelentés időpontja:",
			date
		})
		createSystemMessage({
			"Bejelentés kategóriája:",
			reportData.category
		})
		local text = {
			"Bejelentés címe:"
		}
		local title = split(reportData.title, " ")
		local buffer = {}
		local w = 0
		for i = 1, #title do
			local tw = seexports.sGui:getTextWidthFont(title[i] .. " ", "11/Ubuntu-R.ttf", 1, true)
			if w + tw >= panelWidth then
				table.insert(text, table.concat(buffer, " "))
				w = 0
				buffer = {}
			else
				w = w + tw
			end
			table.insert(buffer, title[i])
		end
		table.insert(text, table.concat(buffer, " "))
		createSystemMessage(text)
		createMessage(date, reportData.description, true, false)
		if reportMessages then
			local charId = getElementData(localPlayer, "char.ID")
			for i = 1, #reportMessages do
				local time = getRealTime(reportMessages[i].date)
				local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
				if reportMessages[i].sender == 0 then
					createSystemMessageEx({
						date,
						reportMessages[i].message
					})
				elseif reportMessages[i].sender == charId then
					createMessage(date, reportMessages[i].message, true, reportMessages[i].id, math.max(reportMessages[i].date, reportMessages[i].seen), 0 < reportMessages[i].seen)
				else
					createMessage(date, reportMessages[i].message, false, reportMessages[i].id)
				end
			end
		end
		waitingToConnectId = false
		if 0 >= reportData.adminId then
			waitingToConnectId = createSystemMessage("Várakozás admin csatlakozására...")
		end
		x = panelWidth - 8
		y = titleBarHeight + 8
		local sy = panelHeight - titleBarHeight - inputSize - 16
		sbBack = seexports.sGui:createGuiElement("rectangle", x, y, 2, sy, reportWindow)
		seexports.sGui:setGuiBackground(sbBack, "solid", "sightgrey")
		scrollbar = seexports.sGui:createGuiElement("rectangle", x, y, 2, sy, reportWindow)
		seexports.sGui:setGuiBackground(scrollbar, "solid", "sightmidgrey")
		processReportPlayerUnread()
		if writing then
			seexports.sGui:deleteGuiElement(writing)
		end
		writing = false
		if otherWriting then
			writing = seexports.sGui:createGuiElement("label", 0, 0, panelWidth, 24, reportWindow)
			seexports.sGui:setLabelFont(writing, "10/Ubuntu-R.ttf")
			seexports.sGui:setLabelText(writing, otherWriting .. " éppen ír...")
			seexports.sGui:setLabelClip(writing, true)
			seexports.sGui:setLabelColor(writing, "#a0a0a0")
			seexports.sGui:setLabelAlignment(writing, "center", "center")
		end
		processReportMessages()
	end
end
