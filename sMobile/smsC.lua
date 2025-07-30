local sightxports = {
	sGui = false,
	sChat = false,
	sGps = false,
	sRadar = false
}
local function sightlangProcessExports()
	for k in pairs(sightxports) do
		local res = getResourceFromName(k)
		if res and getResourceState(res) == "running" then
			sightxports[k] = exports[k]
		else
			sightxports[k] = false
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
local smsContactResults = {}
local smsH = 0
local smsTopSize = 0
local fromAds = false
local fromContacts = false
local lastSMS = 0
selectedSMSContact = false
function processSMSSearch(value)
	for i = 1, #smsContactResults do
		for j = 2, #smsContactResults[i] do
			sightxports.sGui:deleteGuiElement(smsContactResults[i][j])
		end
	end
	local data = {}
	local numberValue = tonumber(value)
	if not numberValue and value then
		local str = utf8.gsub(utf8.gsub(utf8.gsub(value, "+", ""), "-", ""), " ", "")
		numberValue = tonumber(str)
	end
	if numberValue then
		if hiddenContacts[numberValue] then
			table.insert(data, hiddenContacts[numberValue])
		elseif contactsReversed[numberValue] and phoneContacts[contactsReversed[numberValue]] then
			table.insert(data, phoneContacts[contactsReversed[numberValue]])
		else
			table.insert(data, {
				"?",
				1,
				formatPhoneNumber(numberValue),
				numberValue
			})
			for i = 1, #phoneContacts do
				if phoneContacts[i] and (utf8.find(utf8.lower(phoneContacts[i][3]), utf8.lower(value)) or utf8.find(tostring(phoneContacts[i][4]), tostring(numberValue))) then
					table.insert(data, phoneContacts[i])
				end
			end
		end
	elseif value and utf8.len(value) > 0 then
		for i = 1, #phoneContacts do
			if phoneContacts[i] and utf8.find(utf8.lower(phoneContacts[i][3]), utf8.lower(value)) then
				table.insert(data, phoneContacts[i])
			end
		end
	else
		for i = 1, 8 do
			if phoneContacts[i] then
				table.insert(data, phoneContacts[i])
			end
		end
	end
	smsContactResults = {}
	local h = smsH
	local y = topSize + 4 + smsTopSize
	for i = 1, 8 do
		if data[i] then
			smsContactResults[i] = {
				data[i][4]
			}
			local rect = sightxports.sGui:createGuiElement("rectangle", 0, y, bsx, h, appInside)
			sightxports.sGui:setGuiBackground(rect, "solid", "#ffffff")
			sightxports.sGui:setGuiHover(rect, "none", "#ffffff", false, true)
			sightxports.sGui:setGuiHoverable(rect, true)
			sightxports.sGui:setClickEvent(rect, "selectSMSContact")
			table.insert(smsContactResults[i], rect)
			if data[i][2] then
				local col = data[i][2]
				if data[i][1] ~= "dds" then
					local rect = sightxports.sGui:createGuiElement("rectangle", 7, y + 3, h - 6, h - 6, appInside)
					sightxports.sGui:setGuiBackground(rect, "solid", {
						contactColors[col][1],
						contactColors[col][2],
						contactColors[col][3]
					})
					table.insert(smsContactResults[i], rect)
				end
				if data[i][1] == "dds" then
					local img = sightxports.sGui:createGuiElement("image", 7, y + 3, h - 6, h - 6, appInside)
					sightxports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/contacts/" .. data[i][6] .. ".dds", "dxt1", false)
					table.insert(smsContactResults[i], img)
				elseif type(data[i][1]) == "string" then
					local label = sightxports.sGui:createGuiElement("label", 6, y + 2, h - 4, h - 4, appInside)
					sightxports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "center", "center")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelText(label, data[i][1])
					table.insert(smsContactResults[i], label)
				elseif type(data[i][1]) == "table" then
					local icon = sightxports.sGui:createGuiElement("image", 6 + (h - 4) / 2 - 12, y + 2 + (h - 4) / 2 - 12, 24, 24, appInside)
					sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(data[i][1][1], 24, data[i][1][2]))
					sightxports.sGui:setImageColor(icon, "#ffffff")
					table.insert(smsContactResults[i], icon)
				else
					local label = sightxports.sGui:createGuiElement("label", 6, y + 2, h - 4, h - 4, appInside)
					sightxports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "center", "center")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelText(label, "?")
					table.insert(smsContactResults[i], label)
				end
			end
			local img = sightxports.sGui:createGuiElement("image", 6, y + 2, h - 4, h - 4, appInside)
			sightxports.sGui:setImageFile(img, loadedTextures["files/img/avcut_sm.png"])
			sightxports.sGui:setImageColor(img, "#ffffff")
			table.insert(smsContactResults[i], img)
			local label = sightxports.sGui:createGuiElement("label", 6 + h + 2, y + 4, bsx, (h - 8) / 2, appInside)
			sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightxports.sGui:setLabelAlignment(label, "left", "center")
			sightxports.sGui:setLabelColor(label, "#000000")
			sightxports.sGui:setLabelText(label, data[i][3])
			table.insert(smsContactResults[i], label)
			local label = sightxports.sGui:createGuiElement("label", 6 + h + 2, y + 4 + (h - 8) / 2, bsx, (h - 8) / 2, appInside)
			sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
			sightxports.sGui:setLabelAlignment(label, "left", "center")
			sightxports.sGui:setLabelColor(label, "#000000")
			sightxports.sGui:setLabelText(label, formatPhoneNumber(data[i][4]))
			table.insert(smsContactResults[i], label)
			if i < 8 then
				local border = sightxports.sGui:createGuiElement("hr", 0, y + h - 1, bsx, 1, appInside)
				sightxports.sGui:setGuiHrColor(border, grey2, grey2)
				table.insert(smsContactResults[i], border)
			end
			y = y + h
		end
	end
	bringBackFront()
end
addEvent("searchSmsContacts", false)
addEventHandler("searchSmsContacts", getRootElement(), function(value)
	processSMSSearch(value)
end)
local smsInput = false
local smsInputRect = false
local smsTopRect = false
local inputActive = false
local inputRectSize = 0
local messages = {}
local smsScroll = false
lockSMSScroll = false
local sumHeight = 0
local contact = false
local smsScrollBarBcg = false
local smsScrollBar = false
local smsScrollBarY = false
addEventHandler("onActiveInputChange", getRootElement(), function(el, was)
	if (smsInput == el or smsInput == was) and currentPhoneScreen == "sms_single" then
		inputActive = smsInput == el
		inputRectSize = inputActive and 96 or 32
		sightxports.sGui:setGuiPosition(smsInput, 8, bsy - topSize * 1.5 - inputRectSize - 4)
		sightxports.sGui:setGuiSize(smsInput, bsx - 16, inputRectSize)
		sightxports.sGui:setGuiPosition(smsInputRect, 0, bsy - topSize * 1.5 - inputRectSize - 4)
		sightxports.sGui:setGuiSize(smsInputRect, bsx, inputRectSize + 4)
		processSMSMessages()
	end
end)
local smsOlder = 0
local smsOlderButton = false
local smsNewerButton = false
local smsPoses = {}
local lastSMSPos = false
unreadSMSFromNumber = {}
addEvent("gotSMSCache", true)
addEventHandler("gotSMSCache", getRootElement(), function(cache, now, sound, vib)
	local messagesFrom = {}
	for i = 1, #cache do
		local num = tonumber(cache[i][1])
		if num then
			if not messagesFrom[num] then
				messagesFrom[num] = {}
			end
			if cache[i][3] == 2 and cache[i][5] and cache[i][5][1] and cache[i][5][2] and cache[i][4] then
				local splitted = split(cache[i][4], "#")
				if splitted and splitted[1] then
					local file = fileCreate("sms_pics/" .. splitted[1] .. "_t.dds")
					if file then
						fileWrite(file, cache[i][5][1])
						fileClose(file)
					end
					local certFile = fileCreate("sms_pics/" .. splitted[1] .. "_t.sight")
					if certFile then
						fileWrite(certFile, cache[i][5][2])
						fileClose(certFile)
					end
				end
			end
			table.insert(messagesFrom[num], {
				cache[i][2],
				cache[i][3],
				cache[i][4]
			})
		end
	end
	local lastSMSTime = 0
	local lastSMSData = false
	local lastSMSFrom = false
	for k, v in pairs(messagesFrom) do
		if 1 <= #v then
			local lastSMS = 1
			for i = 1, #v do
				if v[i][1] >= v[lastSMS][1] then
					lastSMS = i
				end
				writeToSMSFile(k, -1, v[i][1], 1, false, v[i][2], v[i][3])
				if currentPhoneScreen ~= "sms_single" or selectedSMSContact ~= k then
					local text = ""
					if v[i][2] == 2 then
						text = "Fogadott kép"
					elseif v[i][2] == 3 then
						text = "Fogadott koordináta"
					elseif utf8.len(v[i][3]) >= 17 then
						text = utf8.sub(v[i][3], 1, 14) .. "..."
					else
						text = v[i][3]
					end
					unreadSMSFromNumber[k] = true
					pushNotification("sms", k, v[i][1], text, false, now, sound, vib)
				elseif now then
					if sound then
						playSound("files/wood.wav")
					end
					if vib then
						playSound("files/noti/vib.wav")
						smallVibration = getTickCount()
					end
				end
				if now then
					if sound then
						sightxports.sChat:localDo(localPlayer, "SMS-t kapott")
					elseif vib then
						sightxports.sChat:localDoLow(localPlayer, "SMS-t kapott")
					end
				end
				if lastSMSTime <= v[lastSMS][1] then
					lastSMSTime = v[lastSMS][1]
					lastSMSData = v[lastSMS]
					lastSMSFrom = k
				end
			end
			processSMSListNewMessage(v[lastSMS][1], k, false, v[lastSMS][2], v[lastSMS][3])
		end
	end
	if currentPhoneScreen == "sms_list" then
		processSMSList()
	elseif currentPhoneScreen == "sms_single" and messagesFrom[selectedSMSContact] and smsOlder == 0 then
		for i = 1, #messagesFrom[selectedSMSContact] do
			createSMSMessage(false, messagesFrom[selectedSMSContact][i][1], messagesFrom[selectedSMSContact][i][2], messagesFrom[selectedSMSContact][i][3], 1, -1)
		end
		processSMSMessages()
	end
	if now and lastSMSData and (currentPhoneScreen ~= "sms_single" or selectedSMSContact ~= lastSMSFrom) then
		local text = ""
		if lastSMSData[2] == 2 then
			text = "Fogadott kép"
		elseif lastSMSData[2] == 3 then
			text = "Fogadott koordináta"
		elseif utf8.len(lastSMSData[3]) >= 17 then
			text = utf8.sub(lastSMSData[3], 1, 14) .. "..."
		else
			text = lastSMSData[3]
		end
		createTopNoti({
			false,
			lastSMSFrom,
			"sms",
			text,
			getTickCount(),
			{},
			5000
		})
	end
end)
local smsList = {}
local smsListElements = {}
function processSMSListRaw(data)
	local numWas = {}
	smsList = {}
	for k = 1, #data do
		local dat = split(data[k], "#")
		local text = {}
		for i = 4, #dat do
			if dat[i] then
				table.insert(text, dat[i])
			end
		end
		local num = tonumber(dat[1]) or 0
		if not numWas[num] then
			numWas[num] = true
			text = table.concat(text, "#")
			table.insert(smsList, {
				num,
				tonumber(dat[2]) == 1,
				tonumber(dat[3]) or 0,
				text
			})
		end
	end
end
function deleteFromSMSList(numIn)
	local list = {}
	if fileExists("smslist.sight") then
		local numWas = {}
		local file = fileOpen("smslist.sight", true)
		if file then
			local data = fileRead(file, fileGetSize(file))
			data = split(data, "\n")
			if 0 < #data then
				for k = 1, #data do
					local dat = split(data[k], "#")
					local num = tonumber(dat[1]) or 0
					if num ~= numIn then
						table.insert(list, data[k])
					end
				end
			end
			fileClose(file)
		end
		fileDelete("smslist.sight")
	end
	local file = fileCreate("smslist.sight")
	if file then
		for i = 1, #list do
			fileWrite(file, list[i] .. "\n")
		end
		processSMSListRaw(list)
		fileClose(file)
	end
end
function processSMSListNewMessage(time, numIn, self, msgType, text)
	if msgType == 2 then
		text = (self and "Küldött" or "Fogadott") .. " kép"
	elseif msgType == 3 then
		text = (self and "Küldött" or "Fogadott") .. " koordináta"
	elseif utf8.len(text) >= 17 then
		text = utf8.sub(text, 1, 14) .. "..."
	end
	local list = {
		numIn .. "#" .. (self and 1 or 0) .. "#" .. time .. "#" .. text
	}
	if fileExists("smslist.sight") then
		local numWas = {}
		local file = fileOpen("smslist.sight", true)
		if file then
			local data = fileRead(file, fileGetSize(file))
			data = split(data, "\n")
			if 0 < #data then
				for k = 1, #data do
					local dat = split(data[k], "#")
					local num = tonumber(dat[1]) or 0
					if num ~= numIn then
						table.insert(list, data[k])
					end
				end
			end
			fileClose(file)
		end
		fileDelete("smslist.sight")
	end
	local file = fileCreate("smslist.sight")
	if file then
		for i = 1, #list do
			fileWrite(file, list[i] .. "\n")
		end
		processSMSListRaw(list)
		fileClose(file)
	end
end
function writeToSMSFile(num, id, time, state, self, msgType, message)
	local file = false
	if fileExists("sms/" .. num .. ".sight") then
		file = fileOpen("sms/" .. num .. ".sight")
		fileSetPos(file, fileGetSize(file))
	else
		file = fileCreate("sms/" .. num .. ".sight")
	end
	if file then
		local data = id .. "#" .. time .. "#" .. state .. "#" .. (self and 1 or 0) .. "#" .. (tonumber(msgType) or 1) .. "#" .. message .. "\n"
		fileWrite(file, data)
		fileClose(file)
	end
end
function tryToSendSMS(num, msgType, data, proc)
	if tonumber(num) and getTickCount() - lastSMS > 1000 then
		lastSMS = getTickCount()
		local message = ""
		if msgType == 2 then
			message = data[2]
			data = data[1]
		else
			message = data
		end
		local time = getRealTime().timestamp
		local id = createSMSMessage(true, time, msgType, message, 0, false)
		if proc then
			processSMSMessages()
		end
		writeToSMSFile(num, id, time, 0, true, msgType, message)
		processSMSListNewMessage(time, num, true, msgType, message)
		local speed = 5000
		if msgType == 2 then
			speed = 500000
		end
		triggerLatentServerEvent("tryToSendSMS", speed, localPlayer, num, id, msgType, data)
		if soundState then
			playSound("files/sent.wav")
		end
	end
end
function smsKey(key, por)
	if key == "mouse_wheel_down" then
		local tmp = smsScroll
		tmp = smsScroll - 24
		if tmp < 0 then
			tmp = 0
		end
		if tmp ~= smsScroll then
			smsScroll = tmp
			processSMSMessages()
		end
	elseif key == "mouse_wheel_up" then
		local tmp = smsScroll
		tmp = smsScroll + 24
		local max = sumHeight - (bsy - topSize * 2.5 - inputRectSize - 32)
		if 0 < max then
			if tmp > max then
				tmp = max
			end
			if tmp ~= smsScroll then
				smsScroll = tmp
				processSMSMessages()
			end
		end
	elseif (key == "enter" or key == "num_enter") and por then
		local message = sightxports.sGui:getInputValue(smsInput)
		if message and utf8.len(message) >= 1 and utf8.len(message) <= 250 and getTickCount() - lastSMS > 1000 then
			if 0 < smsOlder then
				smsOlder = 0
				lastSMSPos = false
				loadSMS()
			end
			if 0 < smsScroll then
				smsScroll = 0
			end
			tryToSendSMS(selectedSMSContact, 1, message, false)
			sightxports.sGui:resetInput(smsInput)
			sightxports.sGui:setActiveInput(false)
		end
	end
end
addEvent("smsSendRespone", true)
addEventHandler("smsSendRespone", getRootElement(), function(num, id, state)
	refershSMSState(id, num, state)
end)
addEvent("loadNewerSMS", false)
addEventHandler("loadNewerSMS", getRootElement(), function()
	if 0 < smsOlder then
		smsPoses[smsOlder] = nil
		smsOlder = smsOlder - 1
		if 0 < smsOlder then
			lastSMSPos = smsPoses[smsOlder]
		else
			lastSMSPos = false
			smsPoses = {}
		end
		loadSMS()
		smsScroll = math.max(0, sumHeight - (bsy - topSize * 2.5 - inputRectSize - 32))
		processSMSMessages()
	end
end)
addEvent("loadOlderSMS", false)
addEventHandler("loadOlderSMS", getRootElement(), function()
	smsOlder = smsOlder + 1
	smsScroll = 0
	loadSMS()
end)
local messagesToLoad = 50
function loadSMS()
	if messages then
		for i = 1, #messages do
			if messages[i][2] then
				sightxports.sGui:deleteGuiElement(messages[i][2])
			end
			if messages[i][1] then
				for j = 1, #messages[i][1] do
					sightxports.sGui:deleteGuiElement(messages[i][1][j][1])
				end
			end
		end
	end
	messages = {}
	local pos = 0
	if unreadSMSFromNumber[selectedSMSContact] then
		unreadSMSFromNumber[selectedSMSContact] = nil
		for i = #notifications, 1, -1 do
			if notifications[i] and notifications[i][1] == "sms" and notifications[i][2] == selectedSMSContact then
				table.remove(notifications, i)
			end
		end
		refreshNotifications()
		saveNotifications()
	end
	if selectedSMSContact and fileExists("sms/" .. selectedSMSContact .. ".sight") then
		local file = fileOpen("sms/" .. selectedSMSContact .. ".sight", true)
		if file then
			if not lastSMSPos then
				pos = fileGetSize(file) - 1
			else
				pos = lastSMSPos
			end
			smsPoses[smsOlder] = pos
			local lines = {}
			local c = 0
			local buffer = ""
			while 0 <= pos do
				fileSetPos(file, pos)
				local data = fileRead(file, 1)
				if data == "\n" or pos == 0 then
					if pos == 0 then
						buffer = data .. buffer
					end
					if 0 < utf8.len(buffer) then
						local dat = split(buffer, "#")
						local theType = tonumber(dat[5]) or 1
						if theType == 3 then
							c = c + 4
						elseif theType == 2 then
							c = c + 2
						else
							c = c + 1
						end
						table.insert(lines, dat)
					end
					if c >= messagesToLoad then
						break
					end
					buffer = ""
				else
					buffer = data .. buffer
				end
				pos = pos - 1
			end
			lastSMSPos = pos
			for i = #lines, 1, -1 do
				if lines[i] then
					local dat = lines[i]
					local text = {}
					for i = 6, #dat do
						if dat[i] then
							table.insert(text, dat[i])
						end
					end
					local id = createSMSMessage(tonumber(dat[4]) == 1, tonumber(dat[2]) or 0, tonumber(dat[5]) or 1, table.concat(text, "#"), tonumber(dat[3]) or 2, tonumber(dat[1]))
				end
			end
			lines = {}
			fileClose(file)
		end
	end
	lockSMSScroll = false
	if 0 < smsOlder then
		if not smsNewerButton then
			smsNewerButton = sightxports.sGui:createGuiElement("button", 8, 0, bsx - 16 - 7, 24, appInside)
			sightxports.sGui:setGuiBackground(smsNewerButton, "solid", green)
			sightxports.sGui:setGuiHover(smsNewerButton, "none", green, false, true)
			sightxports.sGui:setButtonTextColor(smsNewerButton, "#ffffff")
			sightxports.sGui:setButtonText(smsNewerButton, "Újabb üzenetek")
			sightxports.sGui:setButtonFont(smsNewerButton, "11/Ubuntu-R.ttf")
			sightxports.sGui:setClickEvent(smsNewerButton, "loadNewerSMS")
		end
	elseif smsNewerButton then
		sightxports.sGui:deleteGuiElement(smsNewerButton)
		smsNewerButton = false
	end
	if 0 < pos then
		if not smsOlderButton then
			smsOlderButton = sightxports.sGui:createGuiElement("button", 8, 0, bsx - 16 - 7, 24, appInside)
			sightxports.sGui:setGuiBackground(smsOlderButton, "solid", green)
			sightxports.sGui:setGuiHover(smsOlderButton, "none", green, false, true)
			sightxports.sGui:setButtonTextColor(smsOlderButton, "#ffffff")
			sightxports.sGui:setButtonText(smsOlderButton, "Régebbi üzenetek")
			sightxports.sGui:setButtonFont(smsOlderButton, "11/Ubuntu-R.ttf")
			sightxports.sGui:setClickEvent(smsOlderButton, "loadOlderSMS")
		end
	elseif smsOlderButton then
		sightxports.sGui:deleteGuiElement(smsOlderButton)
		smsOlderButton = false
	end
	processSMSMessages()
end
function processSMSMessages()
	local h = sightxports.sGui:getFontHeight("9/Ubuntu-R.ttf")
	local h2 = sightxports.sGui:getFontHeight("10/Ubuntu-L.ttf")
	local y = bsy - (topSize * 1.5 + (inputActive and 96 or 32)) - 10
	y = y + smsScroll
	sumHeight = 0
	if smsNewerButton then
		sumHeight = sumHeight + 24 + 8 + 12
		local sy = 24
		local ry = y - 24 - 4
		local hide = ry + sy < 32 + topSize or ry > bsy - inputRectSize - topSize * 1.5
		if not hide then
			sightxports.sGui:setGuiPosition(smsNewerButton, false, ry)
		end
		sightxports.sGui:setGuiRenderDisabled(smsNewerButton, hide)
		y = y - 24 - 8 - 12
	end
	for i = #messages, 1, -1 do
		local rectY = messages[i][3] * h2 + 8
		local sy = rectY + (messages[i][8] and h + 6 or 0)
		local ry = math.floor(y - sy + (messages[i][8] and h + 6 or 0))
		local cutY = 0
		local hide = ry + sy < 32 + topSize or ry > bsy - inputRectSize - topSize * 1.5
		if ry < 0 then
			sightxports.sGui:setGuiSize(messages[i][2], false, rectY + ry)
			ry = 0
		elseif ry + rectY > bsy - inputRectSize - topSize * 1.5 then
			sightxports.sGui:setGuiSize(messages[i][2], false, bsy - inputRectSize - topSize * 1.5 - ry)
		else
			sightxports.sGui:setGuiSize(messages[i][2], false, rectY)
		end
		if not hide then
			sightxports.sGui:setGuiPosition(messages[i][2], false, ry)
		end
		sightxports.sGui:setGuiRenderDisabled(messages[i][2], hide)
		local by = bsy - inputRectSize - topSize * 1.5
		local ty = 32 + topSize
		for j = 1, #messages[i][1] do
			local ry = math.floor(y - sy + messages[i][1][j][2])
			local h = messages[i][1][j][3]
			local hidden = ty > ry + h or by < ry
			sightxports.sGui:setGuiRenderDisabled(messages[i][1][j][1], hidden)
			if not hidden then
				sightxports.sGui:setGuiPosition(messages[i][1][j][1], false, ry)
				local is = messages[i][1][j][4]
				local uv = messages[i][1][j][5]
				if is then
					if by <= ry + h then
						local size = is / h
						local yp = by - ry
						if uv then
							sightxports.sGui:setImageUV(messages[i][1][j][1], uv[1], uv[2], uv[3], yp * size)
						else
							sightxports.sGui:setImageUV(messages[i][1][j][1], 0, 0, is, yp * size)
						end
						sightxports.sGui:setGuiSize(messages[i][1][j][1], false, yp)
					elseif ry < 0 then
						local size = is / h
						if uv then
							sightxports.sGui:setImageUV(messages[i][1][j][1], uv[1], uv[2] - ry * size, uv[3], uv[4] + ry * size)
						else
							sightxports.sGui:setImageUV(messages[i][1][j][1], 0, -ry * size, is, is + ry * size)
						end
						sightxports.sGui:setGuiPosition(messages[i][1][j][1], false, 0)
						sightxports.sGui:setGuiSize(messages[i][1][j][1], false, h + ry)
					else
						if uv then
							sightxports.sGui:setImageUV(messages[i][1][j][1], uv[1], uv[2], uv[3], uv[4])
						else
							sightxports.sGui:setImageUV(messages[i][1][j][1])
						end
						sightxports.sGui:setGuiSize(messages[i][1][j][1], false, h)
					end
				elseif ry + h >= bsy - topSize * 1.5 then
					local yp = by - ry
					sightxports.sGui:setGuiSize(messages[i][1][j][1], false, yp)
				elseif ry < 0 then
					sightxports.sGui:setGuiPosition(messages[i][1][j][1], false, 0)
					sightxports.sGui:setGuiSize(messages[i][1][j][1], false, h + ry)
				else
					sightxports.sGui:setGuiSize(messages[i][1][j][1], false, h)
				end
			end
		end
		y = y - sy - (messages[i][8] and 12 or 8)
		sumHeight = sumHeight + sy + (messages[i][8] and 12 or 8)
	end
	if smsOlderButton then
		sumHeight = sumHeight + 24 + 8 + 4
		local sy = 24
		local ry = y - 24 - 4
		local hide = ry + sy < 32 + topSize or ry > bsy - inputRectSize - topSize * 1.5
		if not hide then
			sightxports.sGui:setGuiPosition(smsOlderButton, false, ry)
		end
		sightxports.sGui:setGuiRenderDisabled(smsOlderButton, hide)
		y = y - 24 - 8
	end
	sumHeight = sumHeight + 8
	if not lockSMSScroll and 0 < sumHeight - (bsy - topSize * 2.5 - inputRectSize - 32) and smsScroll > sumHeight - (bsy - topSize * 2.5 - inputRectSize - 32) then
		smsScroll = sumHeight - (bsy - topSize * 2.5 - inputRectSize - 32)
		processSMSMessages()
	end
	local y = topSize + 32 + 4
	local sh = bsy - topSize * 2.5 - 32 - 8 - inputRectSize - 2
	local h = bsy - topSize * 2.5 - inputRectSize - 32
	local max = sumHeight - h
	div = h / sumHeight
	local progress = 1 - smsScroll / max
	if 0 > div then
		div = 0
	end
	if 1 < div then
		div = 1
	end
	sightxports.sGui:setGuiSize(smsScrollBarBcg, 3, sh)
	sightxports.sGui:setGuiSize(smsScrollBar, 3, sh * div)
	sightxports.sGui:setGuiPosition(smsScrollBar, false, topSize + 32 + 4 + (sh - sh * div) * progress)
	sightxports.sGui:guiToFront(smsTopRect)
	sightxports.sGui:guiToFront(smsInputRect)
	sightxports.sGui:guiToFront(smsInput)
	bringBackFront()
end
local photoDatas = {}
local gpsButtons = {}
local gpsMode = false
addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(v)
	local vt = getVehicleType(v)
	gpsMode = vt == "Automobile" or vt == "Quad" or vt == "Bike"
end)
addEventHandler("onClientPlayerVehicleExit", localPlayer, function()
	gpsMode = false
end)
addEvent("clickGpsButtonMobile", false)
addEventHandler("clickGpsButtonMobile", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if gpsButtons[el] then
		sightxports.sGps:navigateToCoords(gpsButtons[el][1], gpsButtons[el][2])
	end
end)
function createSMSMessage(self, date, msgType, text, state, id)
	data = split(text, " ")
	local h = sightxports.sGui:getFontHeight("9/Ubuntu-R.ttf")
	local h2 = sightxports.sGui:getFontHeight("10/Ubuntu-L.ttf")
	local lines = {}
	local sx = bsx - 16 - 20
	local avh = math.min(32, math.floor(h2 * 1.5 + 8))
	if not self then
		sx = bsx - avh - 4 - 8 - 8 - 6
	end
	if msgType == 1 then
		text = data[1]
		for i = 2, #data do
			local w = sightxports.sGui:getTextWidthFont(text .. " " .. data[i], "11/Ubuntu-L.ttf")
			if w > sx - 8 or data[i] == "\n" then
				table.insert(lines, text)
				if data[i] ~= "\n" then
					text = data[i]
				end
			else
				text = text .. " " .. data[i]
			end
		end
		table.insert(lines, text)
	elseif msgType == 2 then
		lines = {
			true,
			true,
			true
		}
	elseif msgType == 3 then
		lines = {
			true,
			true,
			true,
			true,
			true,
			true,
			true
		}
		if gpsMode then
			table.insert(lines, true)
		end
	end
	local x = self and bsx - sx - 8 - 6 or 8
	local labels = {}
	local current = getRealTime()
	local time = getRealTime(date)
	local date = ""
	if current.year == time.year and current.month == time.month and current.monthday == time.monthday then
		date = string.format("%02d:%02d", time.hour, time.minute)
	else
		date = string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
	end
	local dateShown = #messages <= 0 or date ~= messages[#messages][6]
	if not self then
		local y = 0
		if avh > #lines * h2 + 8 then
			y = (dateShown and h + 6 or 0) + (#lines * h2 + 8) / 2 - avh / 2
		else
			y = dateShown and h + 6 or 0
		end
		local h = avh
		if contact then
			local col = contact[2]
			if contact[1] ~= "dds" then
				local rect = sightxports.sGui:createGuiElement("rectangle", 9, y + 1, h - 2, h - 2, appInside)
				sightxports.sGui:setGuiBackground(rect, "solid", {
					contactColors[col][1],
					contactColors[col][2],
					contactColors[col][3]
				})
				table.insert(labels, {
					rect,
					y + 1,
					h - 2
				})
			end
			if contact[1] == "dds" then
				local img = sightxports.sGui:createGuiElement("image", 9, y + 1, h - 2, h - 2, appInside)
				sightxports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/contacts/" .. contact[6] .. ".dds", "dxt1", false)
				table.insert(labels, {
					img,
					y + 1,
					h - 2
				})
			elseif type(contact[1]) == "string" then
				local label = sightxports.sGui:createGuiElement("label", 8, y, h, h, appInside)
				sightxports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
				sightxports.sGui:setLabelAlignment(label, "center", "center")
				sightxports.sGui:setLabelColor(label, "#ffffff")
				sightxports.sGui:setLabelText(label, contact[1])
				table.insert(labels, {
					label,
					y,
					h
				})
			elseif type(contact[1]) == "table" then
				local icon = sightxports.sGui:createGuiElement("image", 8 + h / 2 - 10, y + h / 2 - 10, 20, 20, appInside)
				sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(contact[1][1], 20, contact[1][2]))
				sightxports.sGui:setImageColor(icon, "#ffffff")
				table.insert(labels, {
					icon,
					y + h / 2 - 10,
					20
				})
			else
				local label = sightxports.sGui:createGuiElement("label", 8, y, h, h, appInside)
				sightxports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
				sightxports.sGui:setLabelAlignment(label, "center", "center")
				sightxports.sGui:setLabelColor(label, "#ffffff")
				sightxports.sGui:setLabelText(label, "?")
				table.insert(labels, {
					label,
					y,
					h
				})
			end
		else
			local rect = sightxports.sGui:createGuiElement("rectangle", 9, y + 1, h - 2, h - 2, appInside)
			sightxports.sGui:setGuiBackground(rect, "solid", {
				contactColors[1][1],
				contactColors[1][2],
				contactColors[1][3]
			})
			table.insert(labels, {
				rect,
				y + 1,
				h - 2
			})
			local label = sightxports.sGui:createGuiElement("label", 8, y, h, h, appInside)
			sightxports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
			sightxports.sGui:setLabelAlignment(label, "center", "center")
			sightxports.sGui:setLabelColor(label, "#ffffff")
			sightxports.sGui:setLabelText(label, "?")
			table.insert(labels, {
				label,
				y,
				h
			})
		end
		local img = sightxports.sGui:createGuiElement("image", 8, y, h, h, appInside)
		sightxports.sGui:setImageFile(img, loadedTextures["files/img/avcut_sm.png"])
		sightxports.sGui:setImageColor(img, "#ffffff")
		table.insert(labels, {
			img,
			y,
			h
		})
		x = x + avh + 4
	end
	local y = 0
	local sy = math.floor(h + 6)
	local y = 4
	if dateShown then
		local dateLabel = sightxports.sGui:createGuiElement("label", 0, y, bsx, sy - 6, appInside)
		sightxports.sGui:setLabelFont(dateLabel, "9/Ubuntu-R.ttf")
		sightxports.sGui:setLabelAlignment(dateLabel, "center", "bottom")
		sightxports.sGui:setLabelColor(dateLabel, "#444444")
		sightxports.sGui:setLabelText(dateLabel, date)
		table.insert(labels, {
			dateLabel,
			y,
			sy - 6
		})
		y = sy + 4
	end
	local rect = sightxports.sGui:createGuiElement("rectangle", x, 0, sx, #lines * h2 + 8, appInside)
	if not self then
		local col = contact and contact[2] or 1
		sightxports.sGui:setGuiBackground(rect, "solid", {
			contactColors[col][1] * 0.95,
			contactColors[col][2] * 0.95,
			contactColors[col][3] * 0.95
		})
	elseif state == 1 then
		sightxports.sGui:setGuiBackground(rect, "solid", "#e5e7e9")
	elseif state == 0 then
		sightxports.sGui:setGuiBackground(rect, "solid", "#dcebfa")
	else
		sightxports.sGui:setGuiBackground(rect, "solid", "#ffc9c9")
	end
	local sy = h2
	if msgType == 3 then
		local location = split(text, "#")
		local img = sightxports.sGui:createGuiElement("image", x, y, sy, sy, appInside)
		sightxports.sGui:setImageFile(img, sightxports.sGui:getFaIconFilename("map-marker-alt", sy))
		sightxports.sGui:setImageColor(img, not self and "#ffffff" or "#000000")
		table.insert(labels, {
			img,
			y,
			sy
		})
		local label = sightxports.sGui:createGuiElement("label", x + 4 + sy, y, sx - sy - 4 - 4, sy, appInside)
		sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
		sightxports.sGui:setLabelAlignment(label, "left", "bottom")
		sightxports.sGui:setLabelColor(label, not self and "#ffffff" or "#000000")
		sightxports.sGui:setLabelText(label, (self and "Elküldött" or "Fogadott") .. " koordináta")
		table.insert(labels, {
			label,
			y,
			sy
		})
		y = y + h2
		local img = sightxports.sGui:createGuiElement("image", x, y, sy, sy, appInside)
		sightxports.sGui:setImageFile(img, sightxports.sGui:getFaIconFilename("save", sy, "regular"))
		sightxports.sGui:setImageColor(img, not self and "#ffffff" or "#000000")
		table.insert(labels, {
			img,
			y,
			sy
		})
		local label = sightxports.sGui:createGuiElement("label", x + 4 + sy, y, sx - sy - 4 - 4, sy, appInside)
		sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
		sightxports.sGui:setLabelAlignment(label, "left", "bottom")
		sightxports.sGui:setLabelColor(label, not self and "#ffffff" or "#000000")
		sightxports.sGui:setLabelText(label, location[3] or "N/A")
		table.insert(labels, {
			label,
			y,
			sy
		})
		y = y + h2
		if gpsMode then
			local img = sightxports.sGui:createGuiElement("image", x, y, sy, sy, appInside)
			sightxports.sGui:setImageFile(img, sightxports.sGui:getFaIconFilename("route", sy, "regular"))
			sightxports.sGui:setImageColor(img, not self and "#ffffff" or "#000000")
			table.insert(labels, {
				img,
				y,
				sy
			})
			local label = sightxports.sGui:createGuiElement("label", x + 4 + sy, y, sx - sy - 4 - 4, sy, appInside)
			sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
			sightxports.sGui:setLabelAlignment(label, "left", "bottom")
			sightxports.sGui:setLabelColor(label, not self and "#ffffff" or "#000000")
			sightxports.sGui:setLabelText(label, "Úticél beállítása")
			sightxports.sGui:setGuiHoverable(label, true)
			sightxports.sGui:setClickEvent(label, "clickGpsButtonMobile")
			table.insert(labels, {
				label,
				y,
				sy
			})
			gpsButtons[label] = {
				tonumber(location[1]) or 0,
				tonumber(location[2]) or 0
			}
			y = y + h2
		end
		local pw, ph = sx - 8, h2 * 5
		local px, py = x + 4, y
		local rx, ry = tonumber(location[1]) or 0, tonumber(location[2]) or 0
		local rect = sightxports.sGui:createGuiElement("rectangle", px, py, pw, ph, appInside)
		sightxports.sGui:setGuiBackground(rect, "solid", {
			20,
			20,
			20
		})
		table.insert(labels, {
			rect,
			py,
			ph
		})
		local map = sightxports.sGui:createGuiElement("radar", px, py, pw, ph, appInside)
		sightxports.sGui:setRadarCoords(map, rx, ry, 128)
		table.insert(labels, {
			map,
			py,
			ph
		})
		local icon = sightxports.sGui:createGuiElement("image", px + pw / 2 - 12, py, 24, 24, appInside)
		sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("map-marker-alt", 24))
		sightxports.sGui:setImageColor(icon, green)
		table.insert(labels, {
			icon,
			py + ph / 2 - 22,
			24,
			24
		})
	elseif msgType == 2 then
		if text then
			local imgData = split(text, "#")
			local ih = #lines * h2 + 8
			local imgSize = 64
			local img = sightxports.sGui:createGuiElement("image", x + 4, 4, ih - 8, ih - 8, appInside)
			if self and imgData[1] and fileExists("sms_pics/" .. imgData[1] .. ".dds") and fileExists("sms_pics/" .. imgData[1] .. ".sight") and imgData[4] and imgData[5] then
				sightxports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/sms_pics/" .. imgData[1] .. ".dds", "dxt1", false, true)
			elseif not self and imgData[1] and fileExists("sms_pics/" .. imgData[1] .. "_t.dds") and fileExists("sms_pics/" .. imgData[1] .. "_t.sight") and imgData[2] and imgData[3] then
				sightxports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/sms_pics/" .. imgData[1] .. "_t.dds", "dxt1", false, true)
			else
				sightxports.sGui:setImageFile(img, loadedTextures["files/img/cam.png"])
				imgSize = 256
			end
			table.insert(labels, {
				img,
				y,
				ih - 8,
				imgSize
			})
			local img = sightxports.sGui:createGuiElement("image", x + ih, y, sy, sy, appInside)
			sightxports.sGui:setImageFile(img, sightxports.sGui:getFaIconFilename("image", sy, "regular"))
			sightxports.sGui:setImageColor(img, not self and "#ffffff" or "#000000")
			table.insert(labels, {
				img,
				y,
				sy
			})
			local label = sightxports.sGui:createGuiElement("label", x + 4 + ih + sy, y, sx - 4 - ih - sy - 4, sy, appInside)
			sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
			sightxports.sGui:setLabelAlignment(label, "left", "bottom")
			sightxports.sGui:setLabelColor(label, not self and "#ffffff" or "#000000")
			sightxports.sGui:setLabelText(label, (self and "Elküldött" or "Fogadott") .. " kép")
			sightxports.sGui:setLabelClip(label, true)
			table.insert(labels, {
				label,
				y,
				sy
			})
			y = y + h2
			local img = sightxports.sGui:createGuiElement("image", x + ih, y, sy, sy, appInside)
			sightxports.sGui:setImageFile(img, sightxports.sGui:getFaIconFilename("save", sy, "regular"))
			sightxports.sGui:setImageColor(img, not self and "#ffffff" or "#000000")
			table.insert(labels, {
				img,
				y,
				sy
			})
			local label = sightxports.sGui:createGuiElement("label", x + 4 + ih + sy, y, sx - 4 - ih - sy - 4, sy, appInside)
			sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
			sightxports.sGui:setLabelAlignment(label, "left", "bottom")
			sightxports.sGui:setLabelColor(label, not self and "#ffffff" or "#000000")
			if self then
				sightxports.sGui:setLabelText(label, (tonumber(imgData[2]) or 0) .. " MB")
			else
				sightxports.sGui:setLabelText(label, (tonumber(imgData[9]) or 0) .. " MB")
			end
			sightxports.sGui:setLabelClip(label, true)
			table.insert(labels, {
				label,
				y,
				sy
			})
			y = y + h2
			local img = sightxports.sGui:createGuiElement("image", x + ih, y, sy, sy, appInside)
			sightxports.sGui:setImageFile(img, sightxports.sGui:getFaIconFilename("map-marker-alt", sy))
			sightxports.sGui:setImageColor(img, not self and "#ffffff" or "#000000")
			table.insert(labels, {
				img,
				y,
				sy
			})
			local label = sightxports.sGui:createGuiElement("label", x + 4 + ih + sy, y, sx - 4 - ih - sy - 4, sy, appInside)
			sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
			sightxports.sGui:setLabelAlignment(label, "left", "bottom")
			sightxports.sGui:setLabelColor(label, not self and "#ffffff" or "#000000")
			if self then
				sightxports.sGui:setLabelText(label, imgData[3])
			else
				sightxports.sGui:setLabelText(label, imgData[6])
			end
			sightxports.sGui:setLabelClip(label, true)
			table.insert(labels, {
				label,
				y,
				sy
			})
			if not self then
				smsDownloadButtons[rect] = imgData[1]
				photoDatas[imgData[1]] = imgData
				local col = contact and contact[2] or 1
				sightxports.sGui:setGuiHoverable(rect, true)
				sightxports.sGui:setGuiHover(rect, "none", {
					contactColors[col][1] * 0.95,
					contactColors[col][2] * 0.95,
					contactColors[col][3] * 0.95
				}, false, true)
				sightxports.sGui:setClickEvent(rect, "tryToOpenSMSPhoto")
			end
		end
		y = y + h2
	else
		for i = 1, #lines do
			local label = sightxports.sGui:createGuiElement("label", x + 4, y, sx - 8, sy, appInside)
			sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
			sightxports.sGui:setLabelAlignment(label, "left", "bottom")
			sightxports.sGui:setLabelColor(label, not self and "#ffffff" or "#000000")
			sightxports.sGui:setLabelText(label, lines[i])
			sightxports.sGui:setLabelClip(label, true)
			table.insert(labels, {
				label,
				y,
				sy
			})
			y = y + h2
		end
	end
	if not lockSMSScroll and 0 < smsScroll then
		smsScroll = smsScroll + #lines * h2 + 8 + 8 + h + 1
	end
	if not tonumber(id) then
		for i = #messages, 1, -1 do
			local j = tonumber(messages[i][4])
			if j and 0 <= j then
				id = j
				break
			end
		end
		if not tonumber(id) then
			id = #messages
		end
		id = id + 1
	end
	table.insert(messages, {
		labels,
		rect,
		#lines,
		id,
		state,
		date,
		self,
		dateShown
	})
	return id
end
function appCloses.sms_single()
	smsDownloadButtons = {}
	messages = {}
	smsOlderButton = false
	smsNewerButton = false
	lastSMSPos = false
	smsPoses = {}
	removeEventHandler("onClientKey", getRootElement(), smsKey)
end
function refershSMSState(id, num, state)
	if tonumber(state) and utf8.len(tostring(state)) == 1 then
		local found = false
		if currentPhoneScreen == "sms_single" and selectedSMSContact == num then
			for i = 1, #messages do
				if messages[i] and messages[i][4] == id then
					if not messages[i][7] then
						return
					end
					found = true
					messages[i][5] = state
					if state == 1 then
						sightxports.sGui:setGuiBackground(messages[i][2], "solid", "#e5e7e9")
						break
					end
					if state == 0 then
						sightxports.sGui:setGuiBackground(messages[i][2], "solid", "#dcebfa")
						break
					end
					sightxports.sGui:setGuiBackground(messages[i][2], "solid", "#ffc9c9")
					break
				end
			end
		end
		if fileExists("sms/" .. num .. ".sight") then
			file = fileOpen("sms/" .. num .. ".sight")
			if file then
				local line = ""
				local lastParam = ""
				local pos = fileGetSize(file) - 1
				while 0 <= pos do
					fileSetPos(file, pos)
					local data = fileRead(file, 1)
					if data ~= "\n" then
						line = data .. line
						if data == "#" then
							lastParam = ""
						else
							lastParam = data .. lastParam
						end
					end
					if data == "\n" or pos == 0 then
						if tonumber(lastParam) == id then
							local count = 0
							local data = false
							while data ~= "\n" do
								fileSetPos(file, pos)
								local data = fileRead(file, 1)
								if data == "#" then
									count = count + 1
									if count == 2 then
										pos = pos + 1
										fileSetPos(file, pos)
										fileWrite(file, tostring(state))
										break
									end
								end
								pos = pos + 1
							end
							break
						end
						line = ""
						lastParam = ""
					end
					pos = pos - 1
				end
				fileClose(file)
			end
		end
	end
end
function appScreens.sms_single()
	smsDownloadButtons = {}
	addEventHandler("onClientKey", getRootElement(), smsKey)
	gpsButtons = {}
	appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightxports.sGui:setGuiBackground(rect, "solid", {
		255,
		255,
		255
	})
	contact = hiddenContacts[selectedSMSContact]
	if contactsReversed[selectedSMSContact] and phoneContacts[contactsReversed[selectedSMSContact]] then
		contact = phoneContacts[contactsReversed[selectedSMSContact]]
	end
	local col = contact and contact[2] or 1
	smsTopRect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightxports.sGui:setGuiBackground(smsTopRect, "solid", {
		contactColors[col][1],
		contactColors[col][2],
		contactColors[col][3]
	})
	local border = sightxports.sGui:createGuiElement("hr", 0, 32 + topSize - 1, bsx - 16, 1, smsTopRect)
	sightxports.sGui:setGuiHrColor(border, {
		contactColors[col][1],
		contactColors[col][2],
		contactColors[col][3]
	}, {
		contactColors[col][1],
		contactColors[col][2],
		contactColors[col][3]
	})
	local label = sightxports.sGui:createGuiElement("label", 8, topSize, bsx - 16, 32, smsTopRect)
	sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	sightxports.sGui:setLabelAlignment(label, "center", "center")
	sightxports.sGui:setLabelColor(label, "#ffffff")
	sightxports.sGui:setLabelText(label, contact and contact[3] or formatPhoneNumber(selectedSMSContact))
	if locationState then
		local icon = sightxports.sGui:createGuiElement("image", 8, topSize + 16 - 12, 24, 24, smsTopRect)
		sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("map-marker-alt", 24))
		sightxports.sGui:setGuiHoverable(icon, true)
		sightxports.sGui:setClickEvent(icon, "sendSMSLocation")
	end
	local icon = sightxports.sGui:createGuiElement("image", bsx - 8 - 24, topSize + 16 - 12, 24, 24, smsTopRect)
	sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("phone", 24))
	sightxports.sGui:setGuiHoverable(icon, true)
	sightxports.sGui:setClickEvent(icon, "openDialerFromSingleSMS")
	inputActive = false
	inputRectSize = 32
	if not lockSMSScroll then
		smsScroll = 0
	end
	smsInputRect = sightxports.sGui:createGuiElement("rect", 0, bsy - topSize * 1.5 - 32 - 4, bsx, 36, appInside)
	sightxports.sGui:setGuiBackground(smsInputRect, "solid", {
		255,
		255,
		255
	})
	smsInput = sightxports.sGui:createGuiElement("input", 8, bsy - topSize * 1.5 - 32 - 4, bsx - 16, 32, appInside)
	sightxports.sGui:setInputColor(smsInput, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
	sightxports.sGui:setInputFont(smsInput, "11/Ubuntu-R.ttf")
	sightxports.sGui:setInputPlaceholder(smsInput, "Üzenet")
	sightxports.sGui:setInputMaxLength(smsInput, 250)
	sightxports.sGui:setInputBorderSize(smsInput, 0.5)
	sightxports.sGui:setInputMultiline(smsInput, true)
	sightxports.sGui:setInputFontPaddingHeight(smsInput, 32)
	if isCursorShowing() then
		sightxports.sGui:setActiveInput(smsInput)
	end
	local y = topSize + 32 + 4
	local sh = bsy - topSize * 2.5 - 32 - 8 - inputRectSize - 2
	local border = sightxports.sGui:createGuiElement("hr", 0, 0, bsx - 16, 1, smsInput)
	sightxports.sGui:setGuiHrColor(border, grey2, grey2)
	smsScrollBarBcg = sightxports.sGui:createGuiElement("rectangle", bsx - 9, y, 3, sh, appInside)
	sightxports.sGui:setGuiBackground(smsScrollBarBcg, "solid", grey1)
	smsScrollBar = sightxports.sGui:createGuiElement("rectangle", bsx - 9, y, 3, sh, appInside)
	sightxports.sGui:setGuiBackground(smsScrollBar, "solid", grey3)
	smsScrollBarY = y
	if fromAds then
		generateBottom(true, "backToSingleAd")
		fromAds = false
	elseif fromContacts then
		generateBottom(true, "openSingleContactEx")
		fromContacts = false
	else
		generateBottom(true, "openSMSList")
	end
	smsOlder = 0
	lastSMSPos = false
	loadSMS()
	bringBackFront()
end
local smsNewType = false
function appScreens.sms_contact()
	appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightxports.sGui:setGuiBackground(rect, "solid", {
		255,
		255,
		255
	})
	local y = topSize + 4
	local h = math.floor((bsy - y - topSize * 1.5 - 32) / 8)
	local ts = bsy - y - topSize * 1.5 - h * 8
	smsH = h
	smsTopSize = ts
	local input = sightxports.sGui:createGuiElement("input", 8, y, bsx - 16, ts, appInside)
	sightxports.sGui:setInputColor(input, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
	sightxports.sGui:setInputFont(input, "11/Ubuntu-R.ttf")
	sightxports.sGui:setInputPlaceholder(input, "Címzett")
	sightxports.sGui:setInputMaxLength(input, 20)
	sightxports.sGui:setInputBorderSize(input, 0.5)
	sightxports.sGui:setInputChangeEvent(input, "searchSmsContacts")
	local border = sightxports.sGui:createGuiElement("hr", 8, y + ts - 1, bsx - 16, 1, appInside)
	sightxports.sGui:setGuiHrColor(border, grey2, grey2)
	y = y + ts
	smsContactResults = {}
	processSMSSearch()
	if smsNewType and smsNewType[1] == "photo" then
		generateBottom(true, "forceBackToPhoto")
	else
		generateBottom(true, "openSMSList")
	end
	bringBackFront()
end
function smsListSort(a, b)
	return a[3] > b[3]
end
local dottedMenu = false
local dottedMenuPrompt = false
dottedMenuNum = false
addEvent("finalDeleteDottedSMS", false)
addEventHandler("finalDeleteDottedSMS", getRootElement(), function()
	if dottedMenuNum then
		deleteFromSMSList(dottedMenuNum)
		if fileExists("sms/" .. dottedMenuNum .. ".sight") then
			fileDelete("sms/" .. dottedMenuNum .. ".sight")
		end
		dottedMenuNum = false
	end
	switchAppScreen("sms_list", true)
end)
addEvent("closeDottedMenuPrompt", false)
addEventHandler("closeDottedMenuPrompt", getRootElement(), function()
	if dottedMenuPrompt then
		sightxports.sGui:deleteGuiElement(dottedMenuPrompt)
	end
	dottedMenuPrompt = false
end)
addEvent("deleteDottedMenuPrompt", false)
addEventHandler("deleteDottedMenuPrompt", getRootElement(), function()
	if dottedMenuPrompt then
		sightxports.sGui:deleteGuiElement(dottedMenuPrompt)
	end
	local h = 24
	local dh = h * 3 + 8
	local w = 150
	dottedMenuPrompt = sightxports.sGui:createGuiElement("rectangle", 1, 1, w, dh, dottedMenu)
	sightxports.sGui:setGuiBackground(dottedMenuPrompt, "solid", {
		255,
		255,
		255
	})
	sightxports.sGui:setGuiHover(dottedMenuPrompt, "none", {
		255,
		255,
		255
	}, false, true)
	sightxports.sGui:setGuiHoverable(dottedMenuPrompt, true)
	sightxports.sGui:disableClickTrough(dottedMenuPrompt, true)
	local label = sightxports.sGui:createGuiElement("label", 0, 0, w, dh - h - 4, dottedMenuPrompt)
	sightxports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
	sightxports.sGui:setLabelAlignment(label, "center", "center")
	sightxports.sGui:setLabelColor(label, "#000000")
	sightxports.sGui:setLabelText(label, "Biztosan törlöd?")
	local btn = sightxports.sGui:createGuiElement("button", 4, dh - h - 4, (w - 12) / 2, h, dottedMenuPrompt)
	sightxports.sGui:setGuiBackground(btn, "solid", green)
	sightxports.sGui:setGuiHover(btn, "none", green, false, true)
	sightxports.sGui:setButtonTextColor(btn, "#ffffff")
	sightxports.sGui:setButtonText(btn, "Igen")
	sightxports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
	sightxports.sGui:setClickEvent(btn, "finalDeleteDottedSMS")
	local btn = sightxports.sGui:createGuiElement("button", w / 2 + 2, dh - h - 4, (w - 12) / 2, h, dottedMenuPrompt)
	sightxports.sGui:setGuiBackground(btn, "solid", red)
	sightxports.sGui:setGuiHover(btn, "none", red, false, true)
	sightxports.sGui:setButtonTextColor(btn, "#ffffff")
	sightxports.sGui:setButtonText(btn, "Nem")
	sightxports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
	sightxports.sGui:setClickEvent(btn, "closeDottedMenuPrompt")
end)
addEvent("openDottedMenu", false)
addEventHandler("openDottedMenu", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	local minY = topSize + 4 + smsTopSize
	local maxY = bsy - topSize * 1.5 - 4
	for i = 1, 10 do
		if smsListElements[i][#smsListElements[i]] == el then
			local num = smsListElements[i][1]
			if dottedMenu then
				sightxports.sGui:deleteGuiElement(dottedMenu)
			end
			dottedMenu = false
			dottedMenuPrompt = false
			if num ~= dottedMenuNum then
				dottedMenuNum = num
				do
					local h = 24
					local dh = h * 3 + 8
					local y = minY + smsH * (i - 0.5) - dh / 2
					local ry = y
					y = math.max(minY, y)
					if maxY < y + dh then
						y = maxY - dh
					end
					y = math.floor(y)
					sightxports.sGui:guiToFront(el)
					local w = 150
					dottedMenu = sightxports.sGui:createGuiElement("rectangle", bsx - 8 - 28 - w - 1, y - 1, w + 2, dh + 2, appInside)
					sightxports.sGui:setGuiBackground(dottedMenu, "solid", grey1)
					sightxports.sGui:setGuiHover(dottedMenu, "none", grey1, false, true)
					sightxports.sGui:setGuiHoverable(dottedMenu, true)
					sightxports.sGui:disableClickTrough(dottedMenu, true)
					local rect = sightxports.sGui:createGuiElement("rectangle", w, ry - y + dh / 2 - 16, 20, 34, dottedMenu)
					sightxports.sGui:setGuiBackground(rect, "solid", grey1)
					local rect = sightxports.sGui:createGuiElement("rectangle", 1, 1, w, dh, dottedMenu)
					sightxports.sGui:setGuiBackground(rect, "solid", {
						255,
						255,
						255
					})
					local rect = sightxports.sGui:createGuiElement("rectangle", w + 1, ry - y + dh / 2 - 16 + 1, 18, 32, dottedMenu)
					sightxports.sGui:setGuiBackground(rect, "solid", {
						255,
						255,
						255
					})
					y = 5
					local rect = sightxports.sGui:createGuiElement("rectangle", 5, y, w - 8, h, dottedMenu)
					sightxports.sGui:setGuiBackground(rect, "solid", {
						255,
						255,
						255
					})
					sightxports.sGui:setGuiHover(rect, "none", {
						255,
						255,
						255
					}, false, true)
					sightxports.sGui:setGuiHoverable(rect, true)
					sightxports.sGui:setClickEvent(rect, "openDialerFromSMS")
					local icon = sightxports.sGui:createGuiElement("image", 5, y, h, h, dottedMenu)
					sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("phone", h))
					sightxports.sGui:setImageColor(icon, blue)
					local label = sightxports.sGui:createGuiElement("label", 5 + h, y, w, h, dottedMenu)
					sightxports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "left", "center")
					sightxports.sGui:setLabelColor(label, "#000000")
					sightxports.sGui:setLabelText(label, "Hívás")
					local border = sightxports.sGui:createGuiElement("hr", 5, y + h - 1, w - 8, 1, dottedMenu)
					sightxports.sGui:setGuiHrColor(border, grey2, grey2)
					y = y + h
					local rect = sightxports.sGui:createGuiElement("rectangle", 5, y, w - 8, h, dottedMenu)
					sightxports.sGui:setGuiBackground(rect, "solid", {
						255,
						255,
						255
					})
					sightxports.sGui:setGuiHover(rect, "none", {
						255,
						255,
						255
					}, false, true)
					sightxports.sGui:setGuiHoverable(rect, true)
					sightxports.sGui:setClickEvent(rect, "openNewContactForSMS")
					local icon = sightxports.sGui:createGuiElement("image", 5, y, h, h, dottedMenu)
					sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("address-book", h))
					sightxports.sGui:setImageColor(icon, blue)
					local label = sightxports.sGui:createGuiElement("label", 5 + h, y, w, h, dottedMenu)
					sightxports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "left", "center")
					sightxports.sGui:setLabelColor(label, "#000000")
					sightxports.sGui:setLabelText(label, "Névjegy")
					local border = sightxports.sGui:createGuiElement("hr", 5, y + h - 1, w - 8, 1, dottedMenu)
					sightxports.sGui:setGuiHrColor(border, grey2, grey2)
					y = y + h
					local rect = sightxports.sGui:createGuiElement("rectangle", 5, y, w - 8, h, dottedMenu)
					sightxports.sGui:setGuiBackground(rect, "solid", {
						255,
						255,
						255
					})
					sightxports.sGui:setGuiHover(rect, "none", {
						255,
						255,
						255
					}, false, true)
					sightxports.sGui:setGuiHoverable(rect, true)
					sightxports.sGui:setClickEvent(rect, "deleteDottedMenuPrompt")
					local icon = sightxports.sGui:createGuiElement("image", 5, y, h, h, dottedMenu)
					sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("trash-alt", h))
					sightxports.sGui:setImageColor(icon, red)
					local label = sightxports.sGui:createGuiElement("label", 5 + h, y, w, h, dottedMenu)
					sightxports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "left", "center")
					sightxports.sGui:setLabelColor(label, "#000000")
					sightxports.sGui:setLabelText(label, "Törlés")
					sightxports.sGui:guiToFront(smsListElements[i][#smsListElements[i] - 1])
				end
				break
			end
			dottedMenuNum = false
			break
		end
	end
end)
local smsListSH = false
local smsListScrollBar = false
local smsListScroll = 0
function smsListKey(key, por)
	if key == "mouse_wheel_up" then
		if 0 < smsListScroll then
			smsListScroll = smsListScroll - 1
			processSMSList()
		end
	elseif key == "mouse_wheel_down" then
		local n = math.max(0, #smsList - 10)
		if n > smsListScroll then
			smsListScroll = smsListScroll + 1
			processSMSList()
		end
	end
end
function processSMSList()
	local h = smsH
	local y = topSize + 4 + smsTopSize
	if dottedMenu then
		sightxports.sGui:deleteGuiElement(dottedMenu)
	end
	dottedMenu = false
	dottedMenuPrompt = false
	dottedMenuNum = false
	for i = 1, #smsListElements do
		for j = 2, #smsListElements[i] do
			sightxports.sGui:deleteGuiElement(smsListElements[i][j])
		end
	end
	smsListElements = {}
	sightxports.sGui:setGuiPosition(smsListScrollBar, false, topSize + smsTopSize + 4 + smsListScroll * smsListSH)
	local th = sightxports.sGui:getFontHeight("11/Ubuntu-L.ttf")
	for j = 1, 10 do
		local i = j + smsListScroll
		if smsList[i] then
			smsListElements[j] = {
				smsList[i][1]
			}
			local rect = sightxports.sGui:createGuiElement("rectangle", 0, y, bsx - 8 - 28, h, appInside)
			sightxports.sGui:setGuiBackground(rect, "solid", "#ffffff")
			sightxports.sGui:setGuiHover(rect, "none", "#ffffff", false, true)
			sightxports.sGui:setGuiHoverable(rect, true)
			sightxports.sGui:setClickEvent(rect, "selectSMSContact")
			table.insert(smsListElements[j], rect)

			if contactsReversed[smsList[i][1]] and (phoneContacts[contactsReversed[smsList[i][1]]] or hiddenContacts[smsList[i][1]]) then
				local col = phoneContacts[contactsReversed[smsList[i][1]]][2]
				if phoneContacts[contactsReversed[smsList[i][1]]][1] ~= "dds" then
					local rect = sightxports.sGui:createGuiElement("rectangle", 7, y + 3, h - 6, h - 6, appInside)
					sightxports.sGui:setGuiBackground(rect, "solid", {
						contactColors[col][1],
						contactColors[col][2],
						contactColors[col][3]
					})
					table.insert(smsListElements[j], rect)
				end
				if phoneContacts[contactsReversed[smsList[i][1]]][1] == "dds" then
					local img = sightxports.sGui:createGuiElement("image", 6, y + 2, h - 4, h - 4, appInside)
					sightxports.sGui:setImageDDS(img, ":sMobile/!mobile_sight/contacts/" .. phoneContacts[contactsReversed[smsList[i][1]]][6] .. ".dds", "dxt1", false)
					table.insert(smsListElements[j], img)
				elseif type(phoneContacts[contactsReversed[smsList[i][1]]][1]) == "string" then
					local label = sightxports.sGui:createGuiElement("label", 6, y + 2, h - 4, h - 4, appInside)
					sightxports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "center", "center")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelText(label, phoneContacts[contactsReversed[smsList[i][1]]][1])
					table.insert(smsListElements[j], label)
				elseif type(phoneContacts[contactsReversed[smsList[i][1]]][1]) == "table" then
					local icon = sightxports.sGui:createGuiElement("image", 6 + (h - 4) / 2 - 12, y + 2 + (h - 4) / 2 - 12, 24, 24, appInside)
					sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(phoneContacts[contactsReversed[smsList[i][1]]][1][1], 24, phoneContacts[contactsReversed[smsList[i][1]]][1][2]))
					sightxports.sGui:setImageColor(icon, "#ffffff")
					table.insert(smsListElements[j], icon)
				else
					local label = sightxports.sGui:createGuiElement("label", 6, y + 2, h - 4, h - 4, appInside)
					sightxports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "center", "center")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelText(label, "?")
					table.insert(smsListElements[j], label)
				end
			else
				local rect = sightxports.sGui:createGuiElement("rectangle", 7, y + 3, h - 6, h - 6, appInside)
				sightxports.sGui:setGuiBackground(rect, "solid", {
					contactColors[1][1],
					contactColors[1][2],
					contactColors[1][3]
				})
				table.insert(smsListElements[j], rect)
				local label = sightxports.sGui:createGuiElement("label", 6, y + 2, h - 4, h - 4, appInside)
				sightxports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
				sightxports.sGui:setLabelAlignment(label, "center", "center")
				sightxports.sGui:setLabelColor(label, "#ffffff")
				sightxports.sGui:setLabelText(label, "?")
				table.insert(smsListElements[j], label)
			end
			local img = sightxports.sGui:createGuiElement("image", 6, y + 2, h - 4, h - 4, appInside)
			sightxports.sGui:setImageFile(img, loadedTextures["files/img/avcut_sm.png"])
			sightxports.sGui:setImageColor(img, "#ffffff")
			table.insert(smsListElements[j], img)
			local label = sightxports.sGui:createGuiElement("label", 6 + h + 2, y + 4, bsx - 6 - h - 2 - 40, (h - 8) / 2, appInside)
			if unreadSMSFromNumber[smsList[i][1]] then
				sightxports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
			else
				sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			end
			sightxports.sGui:setLabelAlignment(label, "left", "center")
			sightxports.sGui:setLabelColor(label, "#000000")
			sightxports.sGui:setLabelClip(label, true)
			local contact = contactsReversed[smsList[i][1]] and phoneContacts[contactsReversed[smsList[i][1]]] or hiddenContacts[smsList[i][1]]
			if contact then
				sightxports.sGui:setLabelText(label, contact[3])
			else
				sightxports.sGui:setLabelText(label, formatPhoneNumber(smsList[i][1]))
			end
			table.insert(smsListElements[j], label)
			if not smsList[i][2] then
				local icon = sightxports.sGui:createGuiElement("image", 6 + h + 2 - th * 0.1 + th, y + 4 + (h - 8) / 2, -th, th, appInside)
				sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("reply", th))
				if unreadSMSFromNumber[smsList[i][1]] then
					sightxports.sGui:setImageColor(icon, "#000000")
				else
					sightxports.sGui:setImageColor(icon, "#222222")
				end
				table.insert(smsListElements[j], icon)
			else
				local icon = sightxports.sGui:createGuiElement("image", 6 + h + 2 - th * 0.1, y + 4 + (h - 8) / 2, th, th, appInside)
				sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("reply", th))
				if unreadSMSFromNumber[smsList[i][1]] then
					sightxports.sGui:setImageColor(icon, "#000000")
				else
					sightxports.sGui:setImageColor(icon, "#222222")
				end
				table.insert(smsListElements[j], icon)
			end
			local label = sightxports.sGui:createGuiElement("label", 6 + h + 2 + th * 1, y + 4 + (h - 8) / 2, bsx - 6 - h - 2 - th - 40, (h - 8) / 2, appInside)
			if unreadSMSFromNumber[smsList[i][1]] then
				sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			else
				sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
			end
			sightxports.sGui:setLabelAlignment(label, "left", "center")
			sightxports.sGui:setLabelColor(label, "#000000")
			sightxports.sGui:setLabelText(label, smsList[i][4])
			sightxports.sGui:setLabelClip(label, true)
			table.insert(smsListElements[j], label)
			if j < 10 then
				local border = sightxports.sGui:createGuiElement("hr", 0, y + h - 1, bsx - 16, 1, appInside)
				sightxports.sGui:setGuiHrColor(border, grey2, grey2)
				table.insert(smsListElements[j], border)
			end
			local rect = sightxports.sGui:createGuiElement("rectangle", bsx - 8 - 28, y, 20, h - 1, appInside)
			sightxports.sGui:setGuiBackground(rect, "solid", "#ffffff")
			sightxports.sGui:setGuiHover(rect, "none", "#ffffff", false, true)
			sightxports.sGui:setGuiHoverable(rect, true)
			sightxports.sGui:setClickEvent(rect, "openDottedMenu")
			local icon = sightxports.sGui:createGuiElement("image", bsx - 8 - 30, y + h / 2 - 12, 24, 24, appInside)
			sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("ellipsis-v", 24))
			sightxports.sGui:setImageColor(icon, "#222222")
			sightxports.sGui:setGuiHoverable(icon, true)
			table.insert(smsListElements[j], icon)
			table.insert(smsListElements[j], rect)
			y = y + h
		end
	end
	bringBackFront()
end
function appCloses.sms_list()
	dottedMenu = false
	dottedMenuPrompt = false
	removeEventHandler("onClientKey", getRootElement(), smsListKey)
end
function appScreens.sms_list()
	addEventHandler("onClientKey", getRootElement(), smsListKey)
	appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightxports.sGui:setGuiBackground(rect, "solid", {
		255,
		255,
		255
	})
	local h = math.floor((bsy - topSize * 2.5 - 32 - 6) / 10)
	local ts = bsy - topSize * 2.5 - h * 10 - 6
	smsH = h
	smsTopSize = ts
	smsTopRect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, ts + topSize, appInside)
	sightxports.sGui:setGuiBackground(smsTopRect, "solid", blue)
	local icon = sightxports.sGui:createGuiElement("image", bsx - 24 - 8, topSize + ts / 2 - 12, 24, 24, appInside)
	sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("plus", 24, "solid"))
	sightxports.sGui:setGuiHoverable(icon, true)
	sightxports.sGui:setClickEvent(icon, "openSMSContacts")
	local label = sightxports.sGui:createGuiElement("label", 8, topSize, bsx - 16, ts, appInside)
	sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	sightxports.sGui:setLabelAlignment(label, "center", "center")
	sightxports.sGui:setLabelColor(label, "#ffffff")
	sightxports.sGui:setLabelText(label, "SMS")
	smsList = {}
	if fileExists("smslist.sight") then
		local file = fileOpen("smslist.sight", true)
		if file then
			local data = fileRead(file, fileGetSize(file))
			data = split(data, "\n")
			processSMSListRaw(data)
			fileClose(file)
		end
	end
	smsListElements = {}
	local n = math.max(0, #smsList - 10)
	if n < smsListScroll then
		smsListScroll = n
	end
	local rect = sightxports.sGui:createGuiElement("rectangle", bsx - 9, topSize + ts + 4, 3, bsy - topSize * 2.5 - ts - 8, appInside)
	sightxports.sGui:setGuiBackground(rect, "solid", grey1)
	smsListSH = (bsy - topSize * 2.5 - ts - 8) / (n + 1)
	smsListScrollBar = sightxports.sGui:createGuiElement("rectangle", bsx - 9, topSize + ts + 4 + smsListScroll * smsListSH, 3, smsListSH, appInside)
	sightxports.sGui:setGuiBackground(smsListScrollBar, "solid", grey3)
	processSMSList()
	generateBottom(true)
	bringBackFront()
end
addEvent("openSMSContacts", false)
addEventHandler("openSMSContacts", getRootElement(), function()
	switchAppScreen("sms_contact")
end)
addEvent("openSMSList", false)
addEventHandler("openSMSList", getRootElement(), function()
	smsNewType = false
	switchAppScreen("sms_list")
end)
function openSMSListForPhoto(photo)
	smsNewType = {"photo", photo}
	switchAppScreen("sms_contact")
end
addEvent("smsPhotoDownloaded", true)
addEventHandler("smsPhotoDownloaded", getRootElement(), function(filename, data)
	local success = false
	if filename and photoDatas[filename] then
		for i = 1, #photoListForCategory.downloads do
			local j = photoListForCategory.downloads[i]
			if j and photoListData[j] and photoListData[j][1] == filename then
				data = nil
				switchAppScreen("photo_download_fail")
				collectgarbage("collect")
				return
			end
		end
		local checksum = sha256(data)
		if 1 == 1 then
			local sx, sy = tonumber(photoDatas[filename][4]), tonumber(photoDatas[filename][5])
			local timestamp = tonumber(photoDatas[filename][3])
			local zonename = photoDatas[filename][6]
			local x = tonumber(photoDatas[filename][7])
			local y = tonumber(photoDatas[filename][8])
			local size = tonumber(photoDatas[filename][9])
			if sx and sy and timestamp and zonename and x and y and size then
				local convertedFile = fileCreate("photos/" .. filename .. ".dds")
				if convertedFile then
					fileWrite(convertedFile, data)
					fileClose(convertedFile)
					local thumbRt = dxCreateRenderTarget(thumbSize, thumbSize)
					dxSetRenderTarget(thumbRt)
					local text = dxCreateTexture(data, "dxt3", false)
					if isElement(text) then
						if photoDatas[filename][10] == "screenshot" then
							local tsy = thumbSize / bsx * bsy
							dxDrawImage(0, thumbSize / 2 - tsy / 2, thumbSize, tsy, text)
						else
							local ts = math.floor(math.min(sx, sy) * 0.75)
							dxDrawImageSection(0, 0, thumbSize, thumbSize, sx / 2 - ts / 2, sy / 2 - ts / 2, ts, ts, text)
						end
					end
					local savert = dxCreateRenderTarget(sx, sy)
					dxSetRenderTarget(savert)
					if isElement(text) then
						dxDrawImage(0, 0, sx, sy, text)
					end
					dxSetRenderTarget()
					if isElement(savert) then
						local rawPixels = dxGetTexturePixels(savert)
						rawPixels = dxConvertPixels(rawPixels, "jpeg", 95)
						if rawPixels then
							local jpg = filename
							local post = ""
							local i = 1
							while origFE("#mobile_download_sight/" .. jpg .. post .. ".jpg") do
								i = i + 1
								post = "_" .. i
							end
							jpg = "#mobile_download_sight/" .. jpg .. post .. ".jpg"
							if not origFE(jpg) then
								local file = origFC(jpg)
								if file then
									fileWrite(file, rawPixels)
									fileClose(file)
								end
							end
						end
						rawPixels = nil
						collectgarbage("collect")
					end
					if isElement(savert) then
						destroyElement(savert)
					end
					savert = nil
					if isElement(text) then
						destroyElement(text)
					end
					text = nil
					if isElement(thumbRt) then
						local tsx, tsy = dxGetMaterialSize(thumbRt)
						if tsx % 2 == 1 or tsy % 2 == 1 then
							return
						end
						local pixels = dxGetTexturePixels(thumbRt, "dds", "dxt1", false)
						if pixels then
							local thumbFile = fileCreate("photos/thumbs/" .. filename .. ".dds")
							if thumbFile then
								fileWrite(thumbFile, pixels)
								fileClose(thumbFile)
								local checksumFile = fileCreate("photos/" .. filename .. ".sight")
								if checksumFile then
									fileWrite(checksumFile, teaEncode(checksum, "mk" .. timestamp .. utf8.sub(filename, 1, 10)))
									fileClose(checksumFile)
									local photoList = false
									if fileExists("photolist.sight") then
										photoList = fileOpen("photolist.sight")
									else
										photoList = fileCreate("photolist.sight")
									end
									if photoList then
										fileSetPos(photoList, fileGetSize(photoList))
										fileWrite(photoList, filename .. "#" .. timestamp .. "#" .. sx .. "#" .. sy .. "#" .. zonename .. "#" .. x .. "#" .. y .. "#" .. size .. "#" .. checksum .. "#downloads\n")
										fileClose(photoList)
										table.insert(photoListData, {
											filename,
											timestamp,
											sx,
											sy,
											zonename,
											x,
											y,
											size,
											checksum,
											"downloads"
										})
										table.insert(photoListForCategory.all, #photoListData)
										table.insert(photoListForCategory.downloads, #photoListData)
										currentPhoto = #photoListData
										selectedGalleryCategory = "downloads"
										photoDeleting = false
										photoInfo = false
										if mobileState then
											photoFromSMS = true
											if photoLandscape then
												switchAppScreen("photo_landscape")
											else
												switchAppScreen("photo")
											end
										end
										success = true
									end
									photoList = nil
								end
								checksumFile = nil
							end
							convertedFile = nil
							checksum = nil
						end
					end
					pixels = nil
					destroyElement(thumbRt)
				end
				thumbRt = nil
			end
		end
	end
	if not success then
		switchAppScreen("photo_download_fail")
	end
	data = nil
	collectgarbage("collect")
end)
addEvent("tryToOpenSMSPhoto", false)
addEventHandler("tryToOpenSMSPhoto", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if smsDownloadButtons[el] and photoDatas[smsDownloadButtons[el]] then
		local image = smsDownloadButtons[el]
		for i = 1, #photoListForCategory.downloads do
			local j = photoListForCategory.downloads[i]
			if j and photoListData[j] and photoListData[j][1] == image then
				currentPhoto = j
				selectedGalleryCategory = "downloads"
				photoDeleting = false
				photoInfo = false
				photoFromSMS = true
				if photoLandscape then
					switchAppScreen("photo_landscape")
				else
					switchAppScreen("photo")
				end
				return
			end
		end
		switchAppScreen("photo_downloading")
		triggerServerEvent("requestSMSPhoto", localPlayer, image)
	end
end)
function appScreens.photo_downloading()
	appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightxports.sGui:setGuiBackground(rect, "solid", {
		255,
		255,
		255
	})
	local ts = 32
	local contact = hiddenContacts[selectedSMSContact]
	if contactsReversed[selectedSMSContact] and phoneContacts[contactsReversed[selectedSMSContact]] then
		contact = phoneContacts[contactsReversed[selectedSMSContact]]
	end

	if contact then
		col = contact[2] or 1
	else
		col = 1
	end

	local col = contact and contact[2] or 1
	local tr = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightxports.sGui:setGuiBackground(tr, "solid", {
		contactColors[col][1],
		contactColors[col][2],
		contactColors[col][3]
	})
	local label = sightxports.sGui:createGuiElement("label", 8, topSize, bsx - 16, ts, appInside)
	sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	sightxports.sGui:setLabelAlignment(label, "center", "center")
	sightxports.sGui:setLabelColor(label, "#ffffff")
	sightxports.sGui:setLabelText(label, "SMS")
	local label = sightxports.sGui:createGuiElement("label", 0, ts, bsx, 128, appInside)
	sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	sightxports.sGui:setLabelAlignment(label, "center", "center")
	sightxports.sGui:setLabelColor(label, "#000000")
	sightxports.sGui:setLabelText(label, "Fénykép letöltése\nfolyamatban...")
	bringBackFront()
end
function appScreens.photo_download_fail()
	appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightxports.sGui:setGuiBackground(rect, "solid", {
		255,
		255,
		255
	})
	local ts = 32
	local contact = hiddenContacts[selectedSMSContact]
	if contactsReversed[selectedSMSContact] and phoneContacts[contactsReversed[selectedSMSContact]] then
		contact = phoneContacts[contactsReversed[selectedSMSContact]]
	end

	if contact then
		col = contact[2]
	else
		col = 1
	end

	local col = contact and contact[2] or 1
	local tr = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, 32 + topSize, appInside)
	sightxports.sGui:setGuiBackground(tr, "solid", {
		contactColors[col][1],
		contactColors[col][2],
		contactColors[col][3]
	})
	local label = sightxports.sGui:createGuiElement("label", 8, topSize, bsx - 16, ts, appInside)
	sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	sightxports.sGui:setLabelAlignment(label, "center", "center")
	sightxports.sGui:setLabelColor(label, "#ffffff")
	sightxports.sGui:setLabelText(label, "SMS")
	local label = sightxports.sGui:createGuiElement("label", 0, ts, bsx, 128, appInside)
	sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	sightxports.sGui:setLabelAlignment(label, "center", "center")
	sightxports.sGui:setLabelColor(label, "#000000")
	sightxports.sGui:setLabelText(label, "Hiba a fénykép\nletöltése közben!")
	generateBottom(true, "goBackToSMSSingle")
	bringBackFront()
end
addEvent("goBackToSMSSingle", false)
addEventHandler("goBackToSMSSingle", getRootElement(), function()
	lockSMSScroll = true
	switchAppScreen("sms_single")
end)
addEvent("sendSMSLocation", false)
addEventHandler("sendSMSLocation", getRootElement(), function()
	if not inSightRing and (getElementInterior(localPlayer) > 0 or 0 < getElementDimension(localPlayer)) then
		sightxports.sGui:showInfobox("e", "Nem tudsz GPS koordinátát küldeni interiorban!")
		return
	end
	if selectedSMSContact then
		local x, y, z = getElementPosition(localPlayer)
		local name = sightxports.sRadar:getZoneName(x, y, z)
		x = math.floor(x + 0.5)
		y = math.floor(y + 0.5)
		tryToSendSMS(selectedSMSContact, 3, x .. "#" .. y .. "#" .. name, true)
	end
end)
addEvent("smsAd", false)
addEventHandler("smsAd", getRootElement(), function()
	if singleData then
		selectedSMSContact = tonumber(singleData.phoneNumber)
		fromAds = true
		switchAppScreen("sms_single")
	end
end)
function openSMSForContact(num)
	if num then
		selectedSMSContact = num
		fromContacts = true
		switchAppScreen("sms_single")
	end
end
addEvent("openSMSFromTop", false)
addEventHandler("openSMSFromTop", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if topExpandedElements then
		local j = 0
		for i = #notifications, #notifications - 5 + 1, -1 do
			j = j + 1
			if topExpandedElements[8][j] and el == topExpandedElements[8][j][1] then
				selectedSMSContact = notifications[i][2]
			end
		end
		if selectedSMSContact then
			smsScroll = 0
			switchAppScreen("sms_single", true)
		end
	end
end)
addEvent("openSMSForTopNoti", false)
addEventHandler("openSMSForTopNoti", getRootElement(), function()
	selectedSMSContact = topNoti[2]
	topNoti[5] = getTickCount() - notiAnimTime
	topNoti[7] = 600
	smsScroll = 0
	switchAppScreen("sms_single", true)
end)
addEvent("selectSMSContact", false)
addEventHandler("selectSMSContact", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if currentPhoneScreen == "sms_contact" then
		for i = 1, 8 do
			if smsContactResults[i] and smsContactResults[i][2] == el then
				selectedSMSContact = tonumber(smsContactResults[i][1])
			end
		end
	elseif currentPhoneScreen == "sms_list" then
		for i = 1, 8 do
			if smsListElements[i] and smsListElements[i][2] == el then
				selectedSMSContact = tonumber(smsListElements[i][1])
			end
		end
	end
	if selectedSMSContact then
		switchAppScreen("sms_single")
		if smsNewType then
			if smsNewType[1] == "photo" and photoListData[smsNewType[2]] then
				local photo = smsNewType[2]
				local file = fileOpen("photos/" .. photoListData[photo][1] .. ".sight", true)
				if file then
					local checksum = fileRead(file, fileGetSize(file))
					fileClose(file)
					if checksum then
						local checksumRaw = checksum
						checksum = teaDecode(checksum, "mk" .. photoListData[photo][2] .. utf8.sub(photoListData[photo][1], 1, 10))
						local image = fileOpen("photos/" .. photoListData[photo][1] .. ".dds", true)
						if image then
							local imageData = fileRead(image, fileGetSize(image))
							fileClose(image)
							if imageData then
								local calculatedSum = sha256(imageData)
								if calculatedSum == checksum then
									local thumbRt = dxCreateRenderTarget(64, 64)
									if thumbRt then
										dxSetRenderTarget(thumbRt)
										local sx, sy = photoListData[photo][3], photoListData[photo][4]
										if sx < sy then
											sy = sy * (64 / sx)
											sx = 64
										else
											sx = sx * (64 / sy)
											sy = 64
										end
										local text = dxCreateTexture(imageData, "dxt3", false)
										if isElement(text) then
											dxDrawImage(32 - sx / 2, 32 - sy / 2, sx, sy, text)
											destroyElement(text)
										end
										dxSetRenderTarget()
										local thumbPixels = dxGetTexturePixels(thumbRt, "dds", "dxt1", false)
										if thumbPixels then
											local checksumThumb = sha256(thumbPixels)
											checksumThumb = teaEncode(checksumThumb, "smst" .. photoListData[photo][2] .. utf8.sub(photoListData[photo][1], 1, 10))
											local rt = getRealTime()
											local thumbName = "sent_" .. rt.timestamp .. "_" .. selectedSMSContact
											local count = 0
											while fileExists("sms_pics/" .. thumbName .. ".dds") do
												count = count + 1
												thumbName = "sent_" .. rt.timestamp .. "_" .. selectedSMSContact .. "_" .. count
											end
											local file = fileCreate("sms_pics/" .. thumbName .. ".dds")
											if file then
												fileWrite(file, thumbPixels)
												fileClose(file)
												local certFile = fileCreate("sms_pics/" .. thumbName .. ".sight")
												if certFile then
													fileWrite(certFile, checksumThumb)
													fileClose(certFile)
													local data = {
														checksumRaw,
														imageData,
														photoListData[photo],
														thumbPixels,
														checksumThumb,
														thumbName
													}
													local data2 = table.concat({
														thumbName,
														photoListData[photo][8],
														photoListData[photo][5],
														photoListData[photo][2],
														utf8.sub(photoListData[photo][1], 1, 10)
													}, "#")
													tryToSendSMS(selectedSMSContact, 2, {data, data2}, true)
												end
											end
											data = nil
											checksumThumb = nil
										end
										thumbPixels = nil
									end
								end
								calculatedSum = nil
							end
							imageData = nil
						end
						checksumRaw = nil
					end
					checksum = nil
				end
				collectgarbage("collect")
			end
			smsNewType = false
		end
	end
end)
