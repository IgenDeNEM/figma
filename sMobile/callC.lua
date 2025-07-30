local sightxports = {
	sGui = false,
	sGroupcall = false,
	sChat = false,
	sVoice = false,
	sPawn = false,
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
local fromAds = false
local fromContacts = false
local fromSMS = false
local fromSingleSMS = false
local dialerNum = false
inCallScreens = {
	in_call = true,
	emergency = true,
	services = true
}
addEvent("openDialer", false)
addEventHandler("openDialer", getRootElement(), function()
	if callStatus then
		switchAppScreen(callStatus[4] or "in_call", true)
	else
		switchAppScreen("dialer")
	end
	dialerNum = false
end)
function openDialerWithNumber(num)
	dialerNum = num
	switchAppScreen("dialer", true)
end
addEvent("openDialerFromContact", false)
addEventHandler("openDialerFromContact", getRootElement(), function()
	if selectedContact and phoneContacts[selectedContact] then
		dialerNum = phoneContacts[selectedContact][4]
		fromContacts = true
		switchAppScreen("dialer")
	end
end)
addEvent("openDialerFromSMS", false)
addEventHandler("openDialerFromSMS", getRootElement(), function()
	if dottedMenuNum then
		dialerNum = dottedMenuNum
		fromSMS = true
		switchAppScreen("dialer")
	end
end)
addEvent("openDialerFromSingleSMS", false)
addEventHandler("openDialerFromSingleSMS", getRootElement(), function()
	if selectedSMSContact then
		dialerNum = selectedSMSContact
		fromSingleSMS = true
		switchAppScreen("dialer")
	end
end)
addEvent("callAd", false)
addEventHandler("callAd", getRootElement(), function()
	if singleData then
		dialerNum = tonumber(singleData.phoneNumber)
		fromAds = true
		switchAppScreen("dialer")
	end
end)
local dialerButtonsEls = {}
local dialerButtons = {
	{
		"7",
		"8",
		"9"
	},
	{
		"4",
		"5",
		"6"
	},
	{
		"1",
		"2",
		"3"
	},
	{
		"+",
		"0",
		"-"
	}
}
local dialerInput = false
addEvent("dialerButton", false)
addEventHandler("dialerButton", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	local val = sightxports.sGui:getInputValue(dialerInput) or ""
	val = val .. dialerButtonsEls[el]
	if utf8.len(val) < 30 then
		sightxports.sGui:setInputValue(dialerInput, val)
		sightxports.sGui:setActiveInput(dialerInput)
		sightxports.sGui:moveInputCursorBack(dialerInput)
		processDialerSearch(val)
	end
end)
dialerStatusLabel = false
callStatus = false
function answerCallLog(num)
	for i = #notifications, 1, -1 do
		if notifications[i] and notifications[i][1] == "call" and notifications[i][2] == num then
			table.remove(notifications, i)
			saveNotifications()
			refreshNotifications()
			break
		end
	end
	if fileExists("callog.sight") then
		local file = fileOpen("callog.sight")
		if file then
			local pos = fileGetSize(file) - 1
			local buffer = ""
			while 0 <= pos do
				fileSetPos(file, pos)
				local data = fileRead(file, 1)
				if data == "\n" or pos == 0 then
					if pos == 0 then
						buffer = data .. buffer
					end
					local dat = split(buffer, "#")
					buffer = ""
					if tonumber(dat[1]) == 3 and tonumber(dat[3]) == num then
						fileSetPos(file, pos + 1)
						fileWrite(file, tostring(2))
						break
					end
				else
					buffer = data .. buffer
				end
				pos = pos - 1
			end
			fileClose(file)
		end
	end
end
function saveToCallLog(theType, time, num)
	local file = false
	if not fileExists("callog.sight") then
		file = fileCreate("callog.sight")
	else
		file = fileOpen("callog.sight")
		fileSetPos(file, fileGetSize(file))
	end
	if file then
		fileWrite(file, theType .. "#" .. time .. "#" .. num .. "\n")
		fileClose(file)
	end
end
local dialTimers = {}
local dialSound = false
local responseTimes = {
	busy = 3400,
	cannotDial = 11300,
	notFound = 9500
}
function cancelDial(del)
	for i = 1, #dialTimers do
		if isTimer(dialTimers[i]) then
			killTimer(dialTimers[i])
		end
	end
	dialTimers = {}
	if isElement(dialSound) then
		destroyElement(dialSound)
	end
	dialSound = false
	if isElement(callSounds[localPlayer]) then
		destroyElement(callSounds[localPlayer])
	end
	callSounds[localPlayer] = nil
	endVibrate()
	callStatus = false
	if not del then
		if not inCallScreens[currentPhoneScreen] then
			createTop()
		end
		if inCallScreens[currentPhoneScreen] then
			switchAppScreen("dialer", true)
		end
	end
end
function deleteDialElements()
	if isElement(dialSound) then
		destroyElement(dialSound)
	end
	dialSound = false
	for i = 1, #dialTimers do
		if isTimer(dialTimers[i]) then
			killTimer(dialTimers[i])
		end
	end
	dialTimers = {}
end
function refreshStatusToEnded()
	if callStatus then
		local num = callStatus[1]
		if callStatus[3] == "incall" then
			local secs = math.floor((getTickCount() - callStatus[2]) / 1000)
			local mins = math.floor(secs / 60)
			local hours = math.floor(mins / 60)
			secs = secs - mins * 60
			mins = mins - hours * 60
			if 0 < hours then
				updateCallStatus(num, "Hívás vége. (" .. string.format("%02d:%02d:%02d", hours, mins, secs) .. ")")
			else
				updateCallStatus(num, "Hívás vége. (" .. string.format("%02d:%02d", mins, secs) .. ")")
			end
		else
			updateCallStatus(num, "ended")
		end
	end
end
function potyi1()
	deleteDialElements()
	dialSound = playSound("files/call/potyi/tedd1.mp3")
	dialTimers[1] = setTimer(potyi2, 10 * math.random(1000, 1200), 1)
end
function potyi2()
	deleteDialElements()
	dialSound = playSound("files/call/potyi/tedd2.mp3")
	dialTimers[1] = setTimer(potyi3, 4 * math.random(1000, 1200), 1)
end
function potyi3()
	deleteDialElements()
	dialSound = playSound("files/call/potyi/tedd3.mp3")
	dialTimers[1] = setTimer(potyi2, 4 * math.random(1000, 1200), 1)
end
local currentEmergencyGroup = false
local emergencyType = false
local emergencyReasonInput = false
local emergencyWaitingForResponse = false
function groupReportResponse(group)
	if callStatus and (not (not emergencyWaitingForResponse and group) or group == currentEmergencyGroup and emergencyType == "report") then
		emergencyWaitingForResponse = false
		switchAppScreen(callStatus[4] or "in_call", true)
	else
		emergencyWaitingForResponse = false
	end
end
function groupCallResponse(group)
	if callStatus and (not (not emergencyWaitingForResponse and group) or group == currentEmergencyGroup and emergencyType == "call") then
		emergencyWaitingForResponse = false
		switchAppScreen(callStatus[4] or "in_call", true)
	else
		emergencyWaitingForResponse = false
	end
end
addEvent("groupCallFailed", true)
addEventHandler("groupCallFailed", getRootElement(), groupCallResponse)
addEvent("selectEmergencyGroup", false)
addEventHandler("selectEmergencyGroup", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
	if callStatus then
		currentEmergencyGroup = id
		emergencyType = false
		switchAppScreen(callStatus[4] or "in_call", true)
	end
end)
addEvent("selectEmergencyType", false)
addEventHandler("selectEmergencyType", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
	if callStatus then
		emergencyType = id
		switchAppScreen(callStatus[4] or "in_call", true)
	end
end)
addEvent("sendEmergencyCall", false)
addEventHandler("sendEmergencyCall", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
	if callStatus and not emergencyWaitingForResponse then
		local val = sightxports.sGui:getInputValue(emergencyReasonInput)
		if val and utf8.len(val) > 0 then
			if emergencyType == "report" then
				if utf8.len(val) > 255 then
					return
				end
			elseif emergencyType == "call" then
				if utf8.len(val) > 48 then
					return
				end
			else
				return
			end
			emergencyWaitingForResponse = true
			switchAppScreen(callStatus[4] or "in_call", true)
			triggerServerEvent("sendEmergencyCall", localPlayer, currentEmergencyGroup, emergencyType, val)
		else
			sightxports.sGui:showInfobox("e", "Kötelező indokot megadnod!")
		end
	end
end)
addEvent("cancelEmergencyCall", false)
addEventHandler("cancelEmergencyCall", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
	if callStatus and not emergencyWaitingForResponse then
		emergencyWaitingForResponse = true
		switchAppScreen(callStatus[4] or "in_call", true)
		triggerServerEvent("cancelEmergencyCall", localPlayer, currentEmergencyGroup, emergencyType, val)
	end
end)
function createEmergencyApp(theType)
	createTop()
	appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightxports.sGui:setGuiBackground(rect, "solid", "#000000")
	local x, y, sx, sy = 8, topSize + 8, 32, 32

	local contact = contactsReversed[callStatus[1]] and phoneContacts[contactsReversed[callStatus[1]]] or hiddenContacts[callStatus[1]]
	local col = contact and contact[2] or 1

	local avRect = sightxports.sGui:createGuiElement("rectangle", x, y, sx, sy, appInside)
	sightxports.sGui:setGuiBackground(avRect, "solid", {
		contactColors[col][1],
		contactColors[col][2],
		contactColors[col][3]
	})
	if not contact then
		contactLetterLabel = sightxports.sGui:createGuiElement("label", x, y, sx, sy, appInside)
		sightxports.sGui:setLabelFont(contactLetterLabel, "25/Ubuntu-R.ttf")
		sightxports.sGui:setLabelAlignment(contactLetterLabel, "center", "center")
		sightxports.sGui:setLabelColor(contactLetterLabel, "#ffffff")
		sightxports.sGui:setLabelText(contactLetterLabel, "?")
	elseif contact[1] == "dds" then
		local img = sightxports.sGui:createGuiElement("image", x, y, sx, sy, appInside)
		sightxports.sGui:setImageDDS(img, "!mobile_sight/contacts/" .. contact[6] .. ".dds", "dxt1", false)
	elseif type(contact[1]) == "string" then
		local label = sightxports.sGui:createGuiElement("label", x, y, sx, sy, appInside)
		sightxports.sGui:setLabelFont(label, "25/Ubuntu-R.ttf")
		sightxports.sGui:setLabelAlignment(label, "center", "center")
		sightxports.sGui:setLabelColor(label, "#ffffff")
		sightxports.sGui:setLabelText(label, contact[1])
		contactLetterLabel = label
	elseif type(contact[1]) == "table" then
		local is = math.floor(sx * 0.6)
		local icon = sightxports.sGui:createGuiElement("image", x + sx / 2 - is / 2, y + sy / 2 - is / 2, is, is, appInside)
		sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(contact[1][1], is, contact[1][2]))
		sightxports.sGui:setImageColor(icon, "#ffffff")
	else
		local label = sightxports.sGui:createGuiElement("label", x, y, sx, sy, appInside)
		sightxports.sGui:setLabelFont(label, "25/Ubuntu-R.ttf")
		sightxports.sGui:setLabelAlignment(label, "center", "center")
		sightxports.sGui:setLabelColor(label, "#ffffff")
		sightxports.sGui:setLabelText(label, "?")
		contactLetterLabel = label
	end
	local img = sightxports.sGui:createGuiElement("image", x, y, sx, sy, appInside)
	sightxports.sGui:setImageFile(img, loadedTextures["files/img/avcut_lg.png"])
	sightxports.sGui:setImageColor(img, "#000000")
	local label = sightxports.sGui:createGuiElement("label", x + 32 + 6, y, 0, 16, appInside)
	sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	sightxports.sGui:setLabelAlignment(label, "left", "center")
	sightxports.sGui:setLabelColor(label, "#ffffff")
	sightxports.sGui:setLabelText(label, contact and contact[3] or formatPhoneNumber(callStatus[1]))
	y = y + 16
	local label = sightxports.sGui:createGuiElement("label", x + 32 + 6, y, 0, 16, appInside)
	sightxports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
	sightxports.sGui:setLabelAlignment(label, "left", "center")
	sightxports.sGui:setLabelColor(label, "#ffffff")
	sightxports.sGui:setLabelText(label, contact and formatPhoneNumber(contact[4]) or "")
	y = y + 16
	y = y + 8
	local ih = 64
	if emergencyWaitingForResponse then
		local loaderIcon = sightxports.sGui:createGuiElement("image", bsx / 2 - 24, y, 48, 48, appInside)
		sightxports.sGui:setImageFile(loaderIcon, sightxports.sGui:getFaIconFilename("circle-notch", 48))
		sightxports.sGui:setImageSpinner(loaderIcon, true)
	else
		local list = sightxports.sGroupcall:getEmergencyCallList(theType)
		if currentEmergencyGroup then
			local btn = sightxports.sGui:createGuiElement("button", 8, y, bsx - 16, 24, appInside)
			sightxports.sGui:setButtonIcon(btn, sightxports.sGui:getFaIconFilename("chevron-left", 24))
			sightxports.sGui:setGuiBackground(btn, "solid", "#ffffff")
			sightxports.sGui:setGuiHover(btn, "none", "#ffffff", false, true)
			sightxports.sGui:setButtonTextColor(btn, "#000000")
			sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
			sightxports.sGui:setClickEvent(btn, emergencyType and "selectEmergencyType" or "selectEmergencyGroup")
			sightxports.sGui:setButtonText(btn, " Vissza")
			y = y + 24 + 6
			local i = currentEmergencyGroup
			local icon = sightxports.sGui:getFaIconFilename(list[i][3], 24)
			local bw = sightxports.sGui:getTextWidthFont(" " .. list[i][1], "11/Ubuntu-R.ttf") + 16 + 4
			local img = sightxports.sGui:createGuiElement("image", bsx / 2 - bw / 2, y + 12 - 8, 16, 16, appInside)
			sightxports.sGui:setImageFile(img, icon)
			local label = sightxports.sGui:createGuiElement("label", bsx / 2 - bw / 2 + 16 + 4, y, 0, 24, appInside)
			sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightxports.sGui:setLabelAlignment(label, "left", "center")
			sightxports.sGui:setLabelColor(label, "#ffffff")
			sightxports.sGui:setLabelText(label, " " .. list[i][1])
			y = y + 24 + 6
			if emergencyType == "report" then
				local reason, time = sightxports.sGroupcall:getGroupReport(currentEmergencyGroup)
				if reason then
					local label = sightxports.sGui:createGuiElement("label", bsx / 2, y, 0, 24, appInside)
					sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "center", "center")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelText(label, theType == "emergency" and "Bejelentés" or "Üzenet")
					y = y + 24
					local time = getRealTime(time)
					local label = sightxports.sGui:createGuiElement("label", bsx / 2, y, 0, 24, appInside)
					sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
					sightxports.sGui:setLabelAlignment(label, "center", "center")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second))
					y = y + 24 + 6
					local label = sightxports.sGui:createGuiElement("label", 8, y, bsx - 16, bsy - topSize * 1.5 - ih - 4 - y - 6, appInside)
					sightxports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "left", "top")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelWordBreak(label, true)
					sightxports.sGui:setLabelText(label, reason)
				else
					local label = sightxports.sGui:createGuiElement("label", bsx / 2, y, 0, 24, appInside)
					sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "center", "center")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelText(label, theType == "emergency" and "Bejelentést teszek" or "Üzenetet küldök")
					y = y + 24 + 6
					emergencyReasonInput = sightxports.sGui:createGuiElement("input", 8, y, bsx - 16, 160, appInside)
					sightxports.sGui:setInputColor(emergencyReasonInput, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
					sightxports.sGui:setInputFont(emergencyReasonInput, "11/Ubuntu-R.ttf")
					sightxports.sGui:setInputPlaceholder(emergencyReasonInput, "Indok")
					sightxports.sGui:setInputMaxLength(emergencyReasonInput, 255)
					sightxports.sGui:setInputBorderSize(emergencyReasonInput, 0.5)
					sightxports.sGui:setInputMultiline(emergencyReasonInput, true)
					sightxports.sGui:setInputFontPaddingHeight(emergencyReasonInput, 32)
					y = y + 160 + 6
					local btn = sightxports.sGui:createGuiElement("button", 8, y, bsx - 16, 24, appInside)
					sightxports.sGui:setButtonIcon(btn, sightxports.sGui:getFaIconFilename("paper-plane", 24))
					sightxports.sGui:setGuiBackground(btn, "solid", "#ffffff")
					sightxports.sGui:setGuiHover(btn, "none", "#ffffff", false, true)
					sightxports.sGui:setButtonTextColor(btn, "#000000")
					sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
					sightxports.sGui:setClickArgument(btn, "call")
					sightxports.sGui:setClickEvent(btn, "sendEmergencyCall")
					sightxports.sGui:setButtonText(btn, " Elküldés")
				end
			elseif emergencyType == "call" then
				local label = sightxports.sGui:createGuiElement("label", bsx / 2, y, 0, 24, appInside)
				sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
				sightxports.sGui:setLabelAlignment(label, "center", "center")
				sightxports.sGui:setLabelColor(label, "#ffffff")
				sightxports.sGui:setLabelText(label, list[i][5])
				y = y + 24 + 6
				local reason, time, accepted = sightxports.sGroupcall:getGroupCall(currentEmergencyGroup)
				if reason then
					y = y - 6
					local time = getRealTime(time)
					local label = sightxports.sGui:createGuiElement("label", bsx / 2, y, 0, 24, appInside)
					sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
					sightxports.sGui:setLabelAlignment(label, "center", "center")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second))
					y = y + 24 + 6
					local label = sightxports.sGui:createGuiElement("label", bsx / 2, y, 0, 24, appInside)
					sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "center", "center")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelText(label, "Elfogadva:")
					y = y + 24
					local label = sightxports.sGui:createGuiElement("label", bsx / 2, y, 0, 24, appInside)
					sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
					sightxports.sGui:setLabelAlignment(label, "center", "center")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					if accepted then
						local time = getRealTime(accepted)
						sightxports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second))
					else
						sightxports.sGui:setLabelText(label, "nincs még elfogadva")
					end
					y = y + 24 + 6
					local by = bsy - topSize * 1.5 - ih - 4 - 24 - 6
					local label = sightxports.sGui:createGuiElement("label", 8, y, bsx - 16, by - y - 6, appInside)
					sightxports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "left", "top")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelWordBreak(label, true)
					sightxports.sGui:setLabelText(label, reason)
					local btn = sightxports.sGui:createGuiElement("button", 8, by, bsx - 16, 24, appInside)
					sightxports.sGui:setButtonIcon(btn, sightxports.sGui:getFaIconFilename("phone-slash", 24))
					sightxports.sGui:setGuiBackground(btn, "solid", "#ffffff")
					sightxports.sGui:setGuiHover(btn, "none", "#ffffff", false, true)
					sightxports.sGui:setButtonTextColor(btn, "#000000")
					sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
					sightxports.sGui:setClickEvent(btn, "cancelEmergencyCall")
					sightxports.sGui:setButtonText(btn, " Hívás lemondása")
				else
					emergencyReasonInput = sightxports.sGui:createGuiElement("input", 8, y, bsx - 16, 32, appInside)
					sightxports.sGui:setInputColor(emergencyReasonInput, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
					sightxports.sGui:setInputFont(emergencyReasonInput, "11/Ubuntu-R.ttf")
					sightxports.sGui:setInputPlaceholder(emergencyReasonInput, "Indok")
					sightxports.sGui:setInputMaxLength(emergencyReasonInput, 48)
					sightxports.sGui:setInputBorderSize(emergencyReasonInput, 0.5)
					y = y + 32 + 6
					local btn = sightxports.sGui:createGuiElement("button", 8, y, bsx - 16, 24, appInside)
					sightxports.sGui:setButtonIcon(btn, sightxports.sGui:getFaIconFilename("paper-plane", 24))
					sightxports.sGui:setGuiBackground(btn, "solid", "#ffffff")
					sightxports.sGui:setGuiHover(btn, "none", "#ffffff", false, true)
					sightxports.sGui:setButtonTextColor(btn, "#000000")
					sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
					sightxports.sGui:setClickArgument(btn, "call")
					sightxports.sGui:setClickEvent(btn, "sendEmergencyCall")
					sightxports.sGui:setButtonText(btn, " Elküldés")
				end
			else
				local btn = sightxports.sGui:createGuiElement("button", 8, y, bsx - 16, 24, appInside)
				sightxports.sGui:setButtonIcon(btn, sightxports.sGui:getFaIconFilename("comment-alt", 24))
				sightxports.sGui:setGuiBackground(btn, "solid", "#ffffff")
				sightxports.sGui:setGuiHover(btn, "none", "#ffffff", false, true)
				sightxports.sGui:setButtonTextColor(btn, "#000000")
				sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
				sightxports.sGui:setClickArgument(btn, "report")
				sightxports.sGui:setClickEvent(btn, "selectEmergencyType")
				sightxports.sGui:setButtonText(btn, theType == "emergency" and " Bejelentést teszek" or " Üzenetet küldök")
				y = y + 24 + 6
				local btn = sightxports.sGui:createGuiElement("button", 8, y, bsx - 16, 24, appInside)
				sightxports.sGui:setButtonIcon(btn, sightxports.sGui:getFaIconFilename("map-marker-alt", 24))
				sightxports.sGui:setGuiBackground(btn, "solid", "#ffffff")
				sightxports.sGui:setGuiHover(btn, "none", "#ffffff", false, true)
				sightxports.sGui:setButtonTextColor(btn, "#000000")
				sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
				sightxports.sGui:setClickArgument(btn, "call")
				sightxports.sGui:setClickEvent(btn, "selectEmergencyType")
				sightxports.sGui:setButtonText(btn, " " .. list[i][5])
			end
		else
			for i in pairs(list) do
				local btn = sightxports.sGui:createGuiElement("button", 8, y, bsx - 16, 24, appInside)
				sightxports.sGui:setButtonIcon(btn, sightxports.sGui:getFaIconFilename(list[i][3], 24))
				sightxports.sGui:setGuiBackground(btn, "solid", "#ffffff")
				sightxports.sGui:setGuiHover(btn, "none", "#ffffff", false, true)
				sightxports.sGui:setButtonTextColor(btn, "#000000")
				sightxports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
				sightxports.sGui:setClickArgument(btn, i)
				sightxports.sGui:setClickEvent(btn, "selectEmergencyGroup")
				sightxports.sGui:setButtonText(btn, " " .. list[i][1])
				y = y + 24 + 6
			end
		end
	end
	local icon = sightxports.sGui:createGuiElement("image", bsx / 2 - ih / 2, bsy - topSize * 1.5 - ih - 4, ih, ih, appInside)
	sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("circle", ih, "solid"))
	sightxports.sGui:setImageColor(icon, red)
	sightxports.sGui:setGuiHoverable(icon, true)
	sightxports.sGui:disableClickTrough(icon, true)
	sightxports.sGui:setClickEvent(icon, "hangUpPhone")
	local icon = sightxports.sGui:createGuiElement("image", ih / 2 - ih / 2 / 2, ih / 2 - ih / 2 / 2, ih / 2, ih / 2, icon)
	sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("phone", ih / 2))
	generateBottom(true)
	bringBackFront()
end
function deleteEmergencyApp()
	emergencyReasonInput = false
end
appScreens.emergency = deleteEmergencyApp
appScreens.services = deleteEmergencyApp
function appScreens.emergency()
	createEmergencyApp("emergency")
end
function appScreens.services()
	createEmergencyApp("services")
end
addEvent("phoneCallResponse", true)
addEventHandler("phoneCallResponse", getRootElement(), function(num, response, sound, vib)
	if not tonumber(num) and callStatus then
		num = callStatus[1]
	end
	deleteDialElements()
	if response == "busy" or response == "cannotDial" or response == "notFound" then
		if callStatus[3] == "incoming" then
			refreshNotifications()
			cancelDial()
		else
			dialSound = playSound("files/call/" .. response .. ".wav")
			dialTimers[1] = setTimer(cancelDial, responseTimes[response], 1)
			refreshStatusToEnded()
		end
	elseif response == "summer" then
		updateCallStatus(num, "incall")
		dialSound = playSound("files/call/summer.wav")
	elseif response == "services" then
		currentEmergencyGroup = false
		updateCallStatus(num, "incall", "services")
		dialSound = playSound("files/call/service/" .. math.random(1, 8) .. ".mp3")
	elseif response == "emergency" then
		currentEmergencyGroup = false
		updateCallStatus(num, "incall", "emergency")
		dialSound = playSound("files/call/emergency/" .. math.random(1, 9) .. ".wav")
	elseif response == "jimmy" then
		updateCallStatus(num, "incall")
		dialSound = playSound("files/call/jimmy/" .. math.random(1, 6) .. ".mp3")
	elseif response == "pötyi" then
		updateCallStatus(num, "incall")
		dialSound = playSound("files/call/potyi/" .. math.random(1, 63) .. ".mp3")
		dialTimers[1] = setTimer(potyi1, 10 * math.random(1000, 1200), 1)
	elseif response == "moneyStackBuyer" then
		if sightxports.sPawn:generatePlayerMoneyStackPed() then
			updateCallStatus(num, "incall")
			dialSound = playSound("files/call/valutas/valutas" .. math.random(1, 3) .. ".wav")
			sightxports.sGui:showInfobox("i", "A Valutás megjelölésre került a térképen 30 percig.")
		end
	elseif response then
		updateCallStatus(num, response)
		if response == "incoming" then
			if sound then
				sightxports.sChat:localDo(localPlayer, "Csörög a telefonja")
			elseif vib then
				sightxports.sChat:localDoLow(localPlayer, "Csörög a telefonja")
			end
			if vib then
				startVibrate()
			end
			if currentSound.ringtone and sound then
				callSounds[localPlayer] = playSound("files/call/ringtone/" .. currentSound.ringtone .. ".wav", true)
				attachElements(callSounds[localPlayer], localPlayer)
				setElementDimension(callSounds[localPlayer], getElementDimension(localPlayer))
				setElementInterior(callSounds[localPlayer], getElementInterior(localPlayer))
			end
			local time = getRealTime().timestamp
			saveToCallLog(3, time, num)
			pushNotification("call", num, time, num, true)
			if mobileState then
				if currentPhoneScreen == "home" or currentPhoneScreen == "dialer" or currentPhoneScreen == "phone" or currentPhoneScreen == "photo_landscape" or currentPhoneScreen == "camera_landscape" or currentPhoneScreen == "photo_portrait" or currentPhoneScreen == "camera" then
					switchAppScreen("in_call", true)
				else
					createTop()
				end
			end
		end
	end
end)
addEvent("answerPhone", false)
addEventHandler("answerPhone", getRootElement(), function()
	if callStatus and callStatus[3] == "incoming" then
		triggerServerEvent("answerPhone", localPlayer)
		updateCallStatus(callStatus[1], "connecting")
		answerCallLog(callStatus[1])
	end
end)
addEvent("hangedUpPhone", true)
addEventHandler("hangedUpPhone", getRootElement(), function()
	if callStatus then
		if callStatus[3] == "incoming" then
			answerCallLog(callStatus[1])
			cancelDial()
		elseif callStatus[3] == "incall" then
			refreshStatusToEnded()
			deleteDialElements()
			dialSound = playSound("files/call/busy.wav")
			dialTimers[1] = setTimer(cancelDial, responseTimes.busy, 1)
		else
			cancelDial()
		end
		callStatus = false
	end
end)
addEvent("hangUpPhone", false)
addEventHandler("hangUpPhone", getRootElement(), function()
	if callStatus and (callStatus[3] == "connecting" or callStatus[3] == "dialing" or callStatus[3] == "incall" or callStatus[3] == "incoming") then
		triggerServerEvent("hangUpPhone", localPlayer)
		if callStatus[3] == "incoming" then
			answerCallLog(callStatus[1])
			cancelDial()
		elseif callStatus[3] == "incall" then
			refreshStatusToEnded()
			deleteDialElements()
			dialSound = playSound("files/call/busy.wav")
			dialTimers[1] = setTimer(cancelDial, responseTimes.busy, 1)
		else
			cancelDial()
		end
		callStatus = false
	end
end)
function dialNumber()
	if callStatus then
		triggerServerEvent("dialNumber", localPlayer, callStatus[1])
	end
end
addEvent("dialNumber", false)
addEventHandler("dialNumber", getRootElement(), function()
	cancelDial()
	local val = sightxports.sGui:getInputValue(dialerInput) or ""
	val = utf8.gsub(val, " ", "")
	val = utf8.gsub(val, "-", "")
	val = utf8.gsub(val, "+", "")
	local num = tonumber(val)
	if num then
		updateCallStatus(num, "connecting")
		switchAppScreen("in_call", true)
		saveToCallLog(1, getRealTime().timestamp, num)
		local len = utf8.len(val)
		for i = 1, len do
			local n = utf8.sub(val, i, i)
			dialTimers[i] = setTimer(function()
				dialSound = playSound("files/call/num/" .. n .. ".wav")
			end, i * 200, 1, "files/call/num/" .. n .. ".wav")
		end
		dialTimers[len + 1] = setTimer(function()
			updateCallStatus(num, "dialing")
			dialSound = playSound("files/call/dial.wav", true)
			setTimer(dialNumber, math.random(1000, 4000), 1)
		end, (len + 1) * 200, 1)
	end
end)
function updateCallStatus(num, status, emergency)
	if num then
		if callStatus and callStatus[3] == "incoming" then
			if isElement(callSounds[localPlayer]) then
				destroyElement(callSounds[localPlayer])
			end
			callSounds[localPlayer] = nil
			endVibrate()
		end
		callStatus = {
			num,
			getTickCount(),
			status,
			emergency
		}
		if inCallScreens[currentPhoneScreen] then
			switchAppScreen(emergency or "in_call", true)
		end
		sightxports.sVoice:setCallState(status == "incall" and not emergency)
	else
		if isElement(callSounds[localPlayer]) then
			destroyElement(callSounds[localPlayer])
		end
		callSounds[localPlayer] = nil
		endVibrate()
		callStatus = false
		if not inCallScreens[currentPhoneScreen] then
			createTop()
		end
		sightxports.sVoice:setCallState(false)
	end
end
voiceIcon = false
function appCloses.in_call()
	dialerStatusLabel = false
	voiceIcon = false
end
function appScreens.in_call()
	createTop()
	appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightxports.sGui:setGuiBackground(rect, "solid", "#000000")
	local h = 32
	local x, y, sx, sy = bsx / 2 - 84 + 4, topSize + 32 + 4, 160, 160
	local ry = math.floor((topSize + 32 + 168) * 0.8)

	local contact = contactsReversed[callStatus[1]] and phoneContacts[contactsReversed[callStatus[1]]] or hiddenContacts[callStatus[1]]
	local col = contact and contact[2] or 1

	local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, ry, appInside)
	sightxports.sGui:setGuiBackground(rect, "solid", {
		contactColors[col][1],
		contactColors[col][2],
		contactColors[col][3]
	})
	local avRect = sightxports.sGui:createGuiElement("rectangle", x, y, sx, sy, appInside)
	sightxports.sGui:setGuiBackground(avRect, "solid", {
		contactColors[col][1],
		contactColors[col][2],
		contactColors[col][3]
	})
	if not contact then
		contactLetterLabel = sightxports.sGui:createGuiElement("label", x, y, sx, sy, appInside)
		sightxports.sGui:setLabelFont(contactLetterLabel, "50/Ubuntu-R.ttf")
		sightxports.sGui:setLabelAlignment(contactLetterLabel, "center", "center")
		sightxports.sGui:setLabelColor(contactLetterLabel, "#ffffff")
		sightxports.sGui:setLabelText(contactLetterLabel, "?")
	elseif contact[1] == "dds" then
		local img = sightxports.sGui:createGuiElement("image", x, y, sx, sy, appInside)
		sightxports.sGui:setImageDDS(img, "!mobile_sight/contacts/" .. contact[6] .. ".dds", "dxt1", false)
	elseif type(contact[1]) == "string" then
		local label = sightxports.sGui:createGuiElement("label", x, y, sx, sy, appInside)
		sightxports.sGui:setLabelFont(label, "50/Ubuntu-R.ttf")
		sightxports.sGui:setLabelAlignment(label, "center", "center")
		sightxports.sGui:setLabelColor(label, "#ffffff")
		sightxports.sGui:setLabelText(label, contact[1])
		contactLetterLabel = label
	elseif type(contact[1]) == "table" then
		local is = math.floor(sx * 0.6)
		local icon = sightxports.sGui:createGuiElement("image", x + sx / 2 - is / 2, y + sy / 2 - is / 2, is, is, appInside)
		sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(contact[1][1], is, contact[1][2]))
		sightxports.sGui:setImageColor(icon, "#ffffff")
	else
		local label = sightxports.sGui:createGuiElement("label", x, y, sx, sy, appInside)
		sightxports.sGui:setLabelFont(label, "50/Ubuntu-R.ttf")
		sightxports.sGui:setLabelAlignment(label, "center", "center")
		sightxports.sGui:setLabelColor(label, "#ffffff")
		sightxports.sGui:setLabelText(label, "?")
		contactLetterLabel = label
	end
	local img = sightxports.sGui:createGuiElement("image", bsx / 2 - 84, topSize + 32, 168, ry - (topSize + 32), appInside)
	sightxports.sGui:setImageFile(img, loadedTextures["files/img/avcut_lg.png"])
	sightxports.sGui:setImageColor(img, {
		contactColors[col][1],
		contactColors[col][2],
		contactColors[col][3]
	})
	sightxports.sGui:setImageUV(img, 0, 0, 168, ry - (topSize + 32))
	local img = sightxports.sGui:createGuiElement("image", bsx / 2 - 84, ry, 168, topSize + 32 + 168 - ry, appInside)
	sightxports.sGui:setImageFile(img, loadedTextures["files/img/avcut_lg.png"])
	sightxports.sGui:setImageColor(img, {
		0,
		0,
		0
	})
	sightxports.sGui:setImageUV(img, 0, ry - (topSize + 32), 168, topSize + 32 + 168 - ry)
	local img = sightxports.sGui:createGuiElement("image", bsx / 2 - 84 - 6, topSize + 32 - 6, 180, 180, appInside)
	sightxports.sGui:setImageFile(img, loadedTextures["files/img/avshad.png"])
	sightxports.sGui:setImageColor(img, {
		255,
		255,
		255,
		100
	})
	y = y + sy + 8
	local label = sightxports.sGui:createGuiElement("label", 0, y, bsx, 24, appInside)
	sightxports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
	sightxports.sGui:setLabelAlignment(label, "center", "center")
	sightxports.sGui:setLabelColor(label, "#ffffff")
	sightxports.sGui:setLabelText(label, contact and contact[3] or formatPhoneNumber(callStatus[1]))
	y = y + 24
	local label = sightxports.sGui:createGuiElement("label", 0, y, bsx, 24, appInside)
	sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
	sightxports.sGui:setLabelAlignment(label, "center", "center")
	sightxports.sGui:setLabelColor(label, "#ffffff")
	sightxports.sGui:setLabelText(label, contact and formatPhoneNumber(contact[4]) or "")
	y = y + 24 + 8
	dialerStatusLabel = sightxports.sGui:createGuiElement("label", 0, y, bsx, 24, appInside)
	sightxports.sGui:setLabelFont(dialerStatusLabel, "11/Ubuntu-L.ttf")
	sightxports.sGui:setLabelAlignment(dialerStatusLabel, "center", "center")
	sightxports.sGui:setLabelColor(dialerStatusLabel, "#ffffff")
	if callStatus[3] == "connecting" then
		sightxports.sGui:setLabelText(dialerStatusLabel, "Kapcsolódás...")
	elseif callStatus[3] == "dialing" then
		sightxports.sGui:setLabelText(dialerStatusLabel, "Tárcsázás...")
	elseif callStatus[3] == "incoming" then
		sightxports.sGui:setLabelText(dialerStatusLabel, "Bejövő hívás")
	elseif callStatus[3] == "ended" then
		sightxports.sGui:setLabelText(dialerStatusLabel, "Hívás vége.")
	elseif callStatus[3] == "incall" then
		local secs = math.floor((getTickCount() - callStatus[2]) / 1000)
		local mins = math.floor(secs / 60)
		local hours = math.floor(mins / 60)
		secs = secs - mins * 60
		mins = mins - hours * 60
		if 0 < hours then
			sightxports.sGui:setLabelText(dialerStatusLabel, string.format("%02d:%02d:%02d", hours, mins, secs))
		else
			sightxports.sGui:setLabelText(dialerStatusLabel, string.format("%02d:%02d", mins, secs))
		end
	else
		sightxports.sGui:setLabelText(dialerStatusLabel, callStatus[3])
	end
	local ih = 64
	if callStatus[3] == "incall" then
		y = y + 48
		sightxports.sGui:setGuiPosition(dialerStatusLabel, false, y)
		local mh = 40
		local icon = sightxports.sGui:createGuiElement("image", bsx / 2 - mh / 2, y - mh - 8, mh, mh, appInside)
		sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("microphone", mh, "solid"))
		sightxports.sGui:setImageColor(icon, grey3)
		voiceIcon = sightxports.sGui:createGuiElement("image", bsx / 2 - mh / 2, y - mh - 8, mh, mh, appInside)
		sightxports.sGui:setImageFile(voiceIcon, sightxports.sGui:getFaIconFilename("microphone", mh, "solid"))
		sightxports.sGui:setImageColor(voiceIcon, green)
	end
	if callStatus[3] == "incoming" then
		local icon = sightxports.sGui:createGuiElement("image", bsx / 2 - ih * 1.5, bsy - topSize * 1.5 - ih - 4, ih, ih, appInside)
		sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("circle", ih, "solid"))
		sightxports.sGui:setImageColor(icon, red)
		sightxports.sGui:setGuiHoverable(icon, true)
		sightxports.sGui:disableClickTrough(icon, true)
		sightxports.sGui:setClickEvent(icon, "hangUpPhone")
		local icon = sightxports.sGui:createGuiElement("image", ih / 2 - ih / 2 / 2, ih / 2 - ih / 2 / 2, ih / 2, ih / 2, icon)
		sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("phone", ih / 2))
		local icon = sightxports.sGui:createGuiElement("image", bsx / 2 + ih * 0.5, bsy - topSize * 1.5 - ih - 4, ih, ih, appInside)
		sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("circle", ih, "solid"))
		sightxports.sGui:setImageColor(icon, green)
		sightxports.sGui:setGuiHoverable(icon, true)
		sightxports.sGui:disableClickTrough(icon, true)
		sightxports.sGui:setClickEvent(icon, "answerPhone")
		local icon = sightxports.sGui:createGuiElement("image", ih / 2 - ih / 2 / 2, ih / 2 - ih / 2 / 2, ih / 2, ih / 2, icon)
		sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("phone", ih / 2))
	else
		local icon = sightxports.sGui:createGuiElement("image", bsx / 2 - ih / 2, bsy - topSize * 1.5 - ih - 4, ih, ih, appInside)
		sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("circle", ih, "solid"))
		sightxports.sGui:setImageColor(icon, red)
		sightxports.sGui:setGuiHoverable(icon, true)
		sightxports.sGui:disableClickTrough(icon, true)
		sightxports.sGui:setClickEvent(icon, "hangUpPhone")
		local icon = sightxports.sGui:createGuiElement("image", ih / 2 - ih / 2 / 2, ih / 2 - ih / 2 / 2, ih / 2, ih / 2, icon)
		sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("phone", ih / 2))
	end
	generateBottom(true)
	bringBackFront()
end
local dialerY = 0
local dialerH = 0
local dialerSearchResults = {}
addEvent("searchDialerContact", false)
addEventHandler("searchDialerContact", getRootElement(), function(value)
	processDialerSearch(value)
end)
addEvent("selectDialerContact", false)
addEventHandler("selectDialerContact", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	for i = 1, 3 do
		if dialerSearchResults[i] and dialerSearchResults[i][2] == el then
			local num = dialerSearchResults[i][1][1]
			if dialerSearchResults[i][1][2] == "new" then
				openNewContactForDialer(num)
				break
			end
			sightxports.sGui:setInputValue(dialerInput, formatPhoneNumber(num))
			sightxports.sGui:setActiveInput(dialerInput)
			processDialerSearch(formatPhoneNumber(num))
			break
		end
	end
end)
local lastForDialer = {}
function processDialerSearch(value)
	local y = dialerY
	local h = dialerH
	for i = 1, #dialerSearchResults do
		for j = 2, #dialerSearchResults[i] do
			sightxports.sGui:deleteGuiElement(dialerSearchResults[i][j])
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
			for i = 1, #phoneContacts do
				if phoneContacts[i] and (utf8.find(utf8.lower(phoneContacts[i][3]), utf8.lower(value)) or utf8.find(tostring(phoneContacts[i][4]), tostring(numberValue))) then
					table.insert(data, phoneContacts[i])
				end
			end
			table.insert(data, {
				"+",
				2,
				"Új névjegy létrehozása",
				numberValue,
				"new"
			})
		end
	elseif value and utf8.len(value) > 0 then
		for i = 1, #phoneContacts do
			if phoneContacts[i] and utf8.find(utf8.lower(phoneContacts[i][3]), utf8.lower(value)) then
				table.insert(data, phoneContacts[i])
			end
		end
	else
		for i = 1, #lastForDialer do
			local num = tonumber(lastForDialer[i])
			if num then
				if hiddenContacts[num] then
					table.insert(data, hiddenContacts[num])
				elseif contactsReversed[num] then
					table.insert(data, phoneContacts[contactsReversed[num]])
				else
					table.insert(data, {
						"?",
						1,
						formatPhoneNumber(num),
						num
					})
				end
			end
		end
		for i = 1, 3 do
			if phoneContacts[i] then
				table.insert(data, phoneContacts[i])
			end
		end
	end
	dialerSearchResults = {}
	for i = 1, 3 do
		if data[i] then
			dialerSearchResults[i] = {
				{
					data[i][4],
					data[i][5]
				}
			}
			local rect = sightxports.sGui:createGuiElement("rectangle", 0, y, bsx, h, appInside)
			sightxports.sGui:setGuiBackground(rect, "solid", "#ffffff")
			sightxports.sGui:setGuiHover(rect, "none", "#ffffff", false, true)
			sightxports.sGui:setGuiHoverable(rect, true)
			sightxports.sGui:setClickEvent(rect, "selectDialerContact")
			table.insert(dialerSearchResults[i], rect)
			if data[i][2] then
				local col = data[i][2]
				if data[i][1] ~= "dds" then
					local rect = sightxports.sGui:createGuiElement("rectangle", 7, y + 3, h - 6, h - 6, appInside)
					sightxports.sGui:setGuiBackground(rect, "solid", {
						contactColors[col][1],
						contactColors[col][2],
						contactColors[col][3]
					})
					table.insert(dialerSearchResults[i], rect)
				end
				if data[i][1] == "dds" then
					local img = sightxports.sGui:createGuiElement("image", 7, y + 3, h - 6, h - 6, appInside)
					sightxports.sGui:setImageDDS(img, "!mobile_sight/contacts/" .. data[i][6] .. ".dds", "dxt1", false)
					table.insert(dialerSearchResults[i], img)
				elseif type(data[i][1]) == "string" then
					local label = sightxports.sGui:createGuiElement("label", 6, y + 2, h - 4, h - 4, appInside)
					sightxports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "center", "center")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelText(label, data[i][1])
					table.insert(dialerSearchResults[i], label)
				elseif type(data[i][1]) == "table" then
					local icon = sightxports.sGui:createGuiElement("image", 6 + (h - 4) / 2 - 12, y + 2 + (h - 4) / 2 - 12, 24, 24, appInside)
					sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(data[i][1][1], 24, data[i][1][2]))
					sightxports.sGui:setImageColor(icon, "#ffffff")
					table.insert(dialerSearchResults[i], icon)
				else
					local label = sightxports.sGui:createGuiElement("label", 6, y + 2, h - 4, h - 4, appInside)
					sightxports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "center", "center")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelText(label, "?")
					table.insert(dialerSearchResults[i], label)
				end
			end
			local img = sightxports.sGui:createGuiElement("image", 6, y + 2, h - 4, h - 4, appInside)
			sightxports.sGui:setImageFile(img, loadedTextures["files/img/avcut_sm.png"])
			sightxports.sGui:setImageColor(img, "#ffffff")
			table.insert(dialerSearchResults[i], img)
			local label = sightxports.sGui:createGuiElement("label", 6 + h + 2, y + 4, bsx, (h - 8) / 2, appInside)
			sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightxports.sGui:setLabelAlignment(label, "left", "center")
			sightxports.sGui:setLabelColor(label, "#000000")
			sightxports.sGui:setLabelText(label, data[i][3])
			table.insert(dialerSearchResults[i], label)
			local label = sightxports.sGui:createGuiElement("label", 6 + h + 2, y + 4 + (h - 8) / 2, bsx, (h - 8) / 2, appInside)
			sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
			sightxports.sGui:setLabelAlignment(label, "left", "center")
			sightxports.sGui:setLabelColor(label, "#000000")
			sightxports.sGui:setLabelText(label, formatPhoneNumber(data[i][4]))
			table.insert(dialerSearchResults[i], label)
			if i < 3 then
				local border = sightxports.sGui:createGuiElement("hr", 0, y + h - 1, bsx, 1, appInside)
				sightxports.sGui:setGuiHrColor(border, grey2, grey2)
				table.insert(dialerSearchResults[i], border)
			end
			y = y + h
		end
	end
	bringBackFront()
end
function appCloses.dialer()
	dialerSearchResults = {}
end
function appScreens.dialer()
	appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightxports.sGui:setGuiBackground(rect, "solid", {
		255,
		255,
		255
	})
	local sx = 3
	local sy = 4
	local w = (bsx - 8) / sx
	local h = math.floor((bsy - topSize * 1.5) * 0.4) / sy
	local y = bsy - topSize * 1.5 - h * (sy + 1.5) - 32 - 24
	dialerInput = sightxports.sGui:createGuiElement("input", 8, y, bsx - 16, 32, appInside)
	sightxports.sGui:setInputColor(dialerInput, grey3, "#ffffff", "#000000", "#ffffff", "#000000")
	sightxports.sGui:setInputFont(dialerInput, "11/Ubuntu-R.ttf")
	sightxports.sGui:setInputPlaceholder(dialerInput, "Telefonszám vagy név")
	sightxports.sGui:setInputMaxLength(dialerInput, 30)
	sightxports.sGui:setInputBorderSize(dialerInput, 0.5)
	sightxports.sGui:setInputChangeEvent(dialerInput, "searchDialerContact")
	if isCursorShowing() then
		sightxports.sGui:setActiveInput(dialerInput)
	end
	local border = sightxports.sGui:createGuiElement("hr", 8, y + 32 - 1, bsx - 16, 1, appInside)
	sightxports.sGui:setGuiHrColor(border, grey2, grey2)
	dialerButtonsEls = {}
	for y = 1, sy do
		for x = 1, sx do
			local btn = sightxports.sGui:createGuiElement("button", 4 + (x - 1) * w, bsy - topSize * 1.5 - h * (sy + 2.35) + y * h - 24, w, h, appInside)
			sightxports.sGui:setGuiBackground(btn, "solid", "#ffffff")
			sightxports.sGui:setGuiHover(btn, "none", "#ffffff", false, true)
			sightxports.sGui:setButtonTextColor(btn, "#000000")
			sightxports.sGui:setButtonFont(btn, "15/Ubuntu-L.ttf")
			sightxports.sGui:setClickEvent(btn, "dialerButton")
			sightxports.sGui:setButtonText(btn, dialerButtons[y][x])
			dialerButtonsEls[btn] = dialerButtons[y][x]
		end
	end
	local ih = math.floor(h * 1.25 / 2) * 2
	local icon = sightxports.sGui:createGuiElement("image", bsx / 2 - ih / 2, bsy - topSize * 1.5 - ih - 4 - 24, ih, ih, appInside)
	sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("circle", ih, "solid"))
	sightxports.sGui:setImageColor(icon, green)
	sightxports.sGui:setGuiHoverable(icon, true)
	sightxports.sGui:disableClickTrough(icon, true)
	sightxports.sGui:setClickEvent(icon, "dialNumber", true)
	local icon = sightxports.sGui:createGuiElement("image", ih / 2 - ih / 2 / 2, ih / 2 - ih / 2 / 2, ih / 2, ih / 2, icon)
	sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("phone", ih / 2))
	local btn = sightxports.sGui:createGuiElement("button", 4, bsy - topSize * 1.5 - 24, w, 24, appInside)
	sightxports.sGui:setGuiBackground(btn, "solid", blue)
	sightxports.sGui:setGuiHover(btn, "none", blue, false, true)
	sightxports.sGui:setButtonTextColor(btn, "#ffffff")
	sightxports.sGui:setButtonText(btn, "Névjegyek")
	sightxports.sGui:setButtonFont(btn, "9/Ubuntu-R.ttf")
	sightxports.sGui:setClickEvent(btn, "openContacts")
	local btn = sightxports.sGui:createGuiElement("button", 4 + w, bsy - topSize * 1.5 - 24, w, 24, appInside)
	sightxports.sGui:setGuiBackground(btn, "solid", blue)
	sightxports.sGui:setGuiHover(btn, "none", blue, false, true)
	sightxports.sGui:setButtonTextColor(btn, "#ffffff")
	sightxports.sGui:setButtonText(btn, "Legutóbbi")
	sightxports.sGui:setButtonFont(btn, "9/Ubuntu-R.ttf")
	sightxports.sGui:setClickEvent(btn, "openPhoneApp")
	local btn = sightxports.sGui:createGuiElement("button", 4 + w * 2, bsy - topSize * 1.5 - 24, w, 24, appInside)
	sightxports.sGui:setGuiBackground(btn, "solid", blue2)
	sightxports.sGui:setGuiHover(btn, "none", blue2, false, true)
	sightxports.sGui:setButtonTextColor(btn, "#ffffff")
	sightxports.sGui:setButtonText(btn, "Tárcsázó")
	sightxports.sGui:setButtonFont(btn, "9/Ubuntu-R.ttf")
	local s = bsy - topSize * 2.5 - (sy + 1.5) * h - 32 - 24 - 8
	local h = math.floor(s / 3)
	local y = topSize
	lastForDialer = {}
	if fileExists("callog.sight") then
		local file = fileOpen("callog.sight", true)
		if file then
			local pos = fileGetSize(file) - 1
			local buffer = ""
			while 0 <= pos do
				fileSetPos(file, pos)
				local data = fileRead(file, 1)
				if data == "\n" or pos == 0 then
					if pos == 0 then
						buffer = data .. buffer
					end
					local dat = split(buffer, "#")
					buffer = ""
					if tonumber(dat[3]) then
						local found = false
						for i = 1, #lastForDialer do
							if lastForDialer[i] == tonumber(dat[3]) then
								found = true
								break
							end
						end
						if not found then
							table.insert(lastForDialer, tonumber(dat[3]))
							if 3 <= #lastForDialer then
								break
							end
						end
					end
				else
					buffer = data .. buffer
				end
				pos = pos - 1
			end
			fileClose(file)
		end
	end
	y = y + 4
	dialerY = y
	dialerH = h
	dialerSearchResults = {}
	if dialerNum then
		sightxports.sGui:setInputValue(dialerInput, formatPhoneNumber(dialerNum))
		processDialerSearch(dialerNum)
	else
		processDialerSearch()
	end
	if fromAds then
		generateBottom(true, "backToSingleAd")
		fromAds = false
	elseif fromContacts then
		generateBottom(true, "openSingleContactEx")
		fromContacts = false
	elseif fromSingleSMS then
		generateBottom(true, "goBackToSMSSingle")
		fromSingleSMS = false
	elseif fromSMS then
		generateBottom(true, "openSMSList")
		fromSMS = false
	else
		generateBottom(true, "openPhoneApp")
	end
	bringBackFront()
end
addEvent("openPhoneAppFromHome", false)
addEventHandler("openPhoneAppFromHome", getRootElement(), function()
	if callStatus then
		switchAppScreen(callStatus[4] or "in_call", true)
	else
		switchAppScreen("phone")
	end
end)
addEvent("openPhoneApp", false)
addEventHandler("openPhoneApp", getRootElement(), function()
	if callStatus then
		switchAppScreen(callStatus[4] or "in_call", true)
	else
		switchAppScreen("phone")
	end
end)
local callLog = {}
local callLogScroll = 0
local callLogElements = {}
local callLogAvatars = {}
local callLogScrollBar = false
function callLogScrollKey(key)
	if key == "mouse_wheel_up" then
		if 0 < callLogScroll then
			callLogScroll = callLogScroll - 1
			processCallLog()
		end
	elseif key == "mouse_wheel_down" and callLogScroll < #callLog - 8 then
		callLogScroll = callLogScroll + 1
		processCallLog()
	end
end
addEvent("selectCallLog", false)
addEventHandler("selectCallLog", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	for i = 1, #callLogElements do
		if callLogElements[i][2] == el then
			dialerNum = callLogElements[i][1]
			switchAppScreen("dialer")
			break
		end
	end
end)
function processCallLog()
	local y = topSize
	local h = math.floor((bsy - y - topSize * 1.5 - 32 - 24) / 8)
	local ts = bsy - y - topSize * 1.5 - 24 - h * 8
	local sh = h * 8 - 8
	sightxports.sGui:setGuiPosition(callLogScrollBar, false, topSize + ts + 4 + sh / math.max(1, #callLog - 8 + 1) * callLogScroll)
	y = y + ts
	for i = 1, #callLog do
		for j = 1, #callLogAvatars[i] do
			sightxports.sGui:setGuiRenderDisabled(callLogAvatars[i][j][1], i - callLogScroll < 1 or 8 < i - callLogScroll)
		end
	end
	for j = 1, 8 do
		local i = j + callLogScroll
		if callLog[i] then
			for k = 1, #callLogAvatars[i] do
				sightxports.sGui:setGuiPosition(callLogAvatars[i][k][1], false, y + callLogAvatars[i][k][2])
			end
			sightxports.sGui:guiToFront(callLogElements[j][3])
			local num = callLog[i][3]
			local contact = contactsReversed[num] and (phoneContacts[contactsReversed[num]] or hiddenContacts[num])

			callLogElements[j][1] = callLog[i][3]
			local icon = callLogElements[j][4]
			local label = callLogElements[j][5]
			if callLog[i][1] == 2 then
				sightxports.sGui:setImageColor(icon, green)
				sightxports.sGui:setLabelText(label, "Bejövő hívás")
			elseif callLog[i][1] == 1 then
				sightxports.sGui:setImageColor(icon, blue)
				sightxports.sGui:setLabelText(label, "Kimenő hívás")
			else
				sightxports.sGui:setImageColor(icon, red)
				sightxports.sGui:setLabelText(label, "Nem fogadott")
			end
			local label = callLogElements[j][6]
			sightxports.sGui:setLabelText(label, contact and contact[3] or formatPhoneNumber(num))
			local time = getRealTime(callLog[i][2])
			local label = callLogElements[j][7]
			sightxports.sGui:setLabelText(label, string.format("%02d.%02d.", time.month + 1, time.monthday))
			local label = callLogElements[j][8]
			sightxports.sGui:setLabelText(label, string.format("%02d:%02d", time.hour, time.minute))
			y = y + h
		end
	end
	bringBackFront()
end
function appCloses.phone()
	callLogElements = {}
	callLogAvatars = {}
	removeEventHandler("onClientKey", getRootElement(), callLogScrollKey)
end
function appScreens.phone()
	addEventHandler("onClientKey", getRootElement(), callLogScrollKey)
	appInside = sightxports.sGui:createGuiElement("null", 0, 0, bsx, bsy, mobileBackground)
	local rect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, bsy, appInside)
	sightxports.sGui:setGuiBackground(rect, "solid", {
		255,
		255,
		255
	})
	local y = topSize
	local h = math.floor((bsy - y - topSize * 1.5 - 32 - 24) / 8)
	local ts = bsy - y - topSize * 1.5 - 24 - h * 8
	local topRect = sightxports.sGui:createGuiElement("rectangle", 0, 0, bsx, ts + topSize, appInside)
	sightxports.sGui:setGuiBackground(topRect, "solid", blue)
	local label = sightxports.sGui:createGuiElement("label", 8, topSize, bsx - 16, ts, appInside)
	sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	sightxports.sGui:setLabelAlignment(label, "center", "center")
	sightxports.sGui:setLabelColor(label, "#ffffff")
	sightxports.sGui:setLabelText(label, "Legutóbbi")
	local found = false
	for i = #notifications, 1, -1 do
		if notifications[i] and notifications[i][1] == "call" then
			table.remove(notifications, i)
			found = true
		end
	end
	if found then
		saveNotifications()
		refreshNotifications()
	end
	callLogScroll = 0
	callLog = {}
	if fileExists("callog.sight") then
		local file = fileOpen("callog.sight", true)
		if file then
			local pos = fileGetSize(file) - 1
			local buffer = ""
			while 0 <= pos do
				fileSetPos(file, pos)
				local data = fileRead(file, 1)
				if data == "\n" or pos == 0 then
					if pos == 0 then
						buffer = data .. buffer
					end
					local dat = split(buffer, "#")
					buffer = ""
					if tonumber(dat[1]) and tonumber(dat[2]) and tonumber(dat[3]) then
						table.insert(callLog, {
							tonumber(dat[1]),
							tonumber(dat[2]),
							tonumber(dat[3])
						})
						if 75 <= #callLog then
							break
						end
					end
				else
					buffer = data .. buffer
				end
				pos = pos - 1
			end
			fileClose(file)
		end
	end
	y = y + ts
	callLogAvatars = {}
	for i = 1, #callLog do
		if i <= 8 and callLog[i] then
			local num = callLog[i][3]
			local contact = contactsReversed[num] and (phoneContacts[contactsReversed[num]] or hiddenContacts[num])
			callLogElements[i] = {
				callLog[i][3]
			}
			local rect = sightxports.sGui:createGuiElement("rectangle", 0, y, bsx - 12, h, appInside)
			sightxports.sGui:setGuiBackground(rect, "solid", "#ffffff")
			sightxports.sGui:setGuiHover(rect, "none", "#ffffff", false, true)
			sightxports.sGui:setGuiHoverable(rect, true)
			sightxports.sGui:setClickEvent(rect, "selectCallLog")
			table.insert(callLogElements[i], rect)
			local img = sightxports.sGui:createGuiElement("image", 6, y + 2, h - 4, h - 4, appInside)
			sightxports.sGui:setImageFile(img, loadedTextures["files/img/avcut_sm.png"])
			sightxports.sGui:setImageColor(img, "#ffffff")
			table.insert(callLogElements[i], img)
			local fh = sightxports.sGui:getFontHeight("11/Ubuntu-R.ttf")
			local icon = sightxports.sGui:createGuiElement("image", 6 + h + 2, y + 4 + (h - 8) / 2 / 2 - fh / 2, fh, fh, appInside)
			sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename("phone", fh))
			table.insert(callLogElements[i], icon)
			local label = sightxports.sGui:createGuiElement("label", 6 + h + 2 + fh, y + 4, bsx, (h - 8) / 2, appInside)
			sightxports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightxports.sGui:setLabelAlignment(label, "left", "center")
			sightxports.sGui:setLabelColor(label, "#000000")
			if callLog[i][1] == 2 then
				sightxports.sGui:setImageColor(icon, green)
				sightxports.sGui:setLabelText(label, "Bejövő hívás")
			elseif callLog[i][1] == 1 then
				sightxports.sGui:setImageColor(icon, blue)
				sightxports.sGui:setLabelText(label, "Kimenő hívás")
			else
				sightxports.sGui:setImageColor(icon, red)
				sightxports.sGui:setLabelText(label, "Nem fogadott")
			end
			table.insert(callLogElements[i], label)
			local label = sightxports.sGui:createGuiElement("label", 6 + h + 2, y + 4 + (h - 8) / 2, bsx, (h - 8) / 2, appInside)
			sightxports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
			sightxports.sGui:setLabelAlignment(label, "left", "center")
			sightxports.sGui:setLabelColor(label, "#000000")
			sightxports.sGui:setLabelText(label, contact and contact[3] or formatPhoneNumber(num))
			table.insert(callLogElements[i], label)
			local time = getRealTime(callLog[i][2])
			local label = sightxports.sGui:createGuiElement("label", 6 + h + 2, y + 4, bsx - 12 - 6 - h - 2, (h - 8) / 2, appInside)
			sightxports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
			sightxports.sGui:setLabelAlignment(label, "right", "center")
			sightxports.sGui:setLabelColor(label, "#555555")
			sightxports.sGui:setLabelText(label, string.format("%02d.%02d.", time.month + 1, time.monthday))
			table.insert(callLogElements[i], label)
			local label = sightxports.sGui:createGuiElement("label", 6 + h + 2, y + 4 + (h - 8) / 2, bsx - 12 - 6 - h - 2, (h - 8) / 2, appInside)
			sightxports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
			sightxports.sGui:setLabelAlignment(label, "right", "center")
			sightxports.sGui:setLabelColor(label, "#555555")
			sightxports.sGui:setLabelText(label, string.format("%02d:%02d", time.hour, time.minute))
			table.insert(callLogElements[i], label)
			if i < 8 then
				local border = sightxports.sGui:createGuiElement("hr", 0, y + h - 1, bsx - 12, 1, appInside)
				sightxports.sGui:setGuiHrColor(border, grey2, grey2)
				table.insert(callLogElements[i], border)
			end
			y = y + h
		end
		if callLog[i] then
			local y = y - h
			local num = callLog[i][3]
			local contact = contactsReversed[num] and (phoneContacts[contactsReversed[num]] or hiddenContacts[num])
			callLogAvatars[i] = {}
			if contact and contact[2] then
				local col = contact[2]
				if contact[1] ~= "dds" then
					local rect = sightxports.sGui:createGuiElement("rectangle", 7, y + 3, h - 6, h - 6, appInside)
					sightxports.sGui:setGuiBackground(rect, "solid", {
						contactColors[col][1],
						contactColors[col][2],
						contactColors[col][3]
					})
					sightxports.sGui:setGuiRenderDisabled(rect, 8 < i)
					table.insert(callLogAvatars[i], {rect, 3})
				end
				if contact[1] == "dds" then
					local img = sightxports.sGui:createGuiElement("image", 6, y + 2, h - 4, h - 4, appInside)
					sightxports.sGui:setImageDDS(img, "!mobile_sight/contacts/" .. contact[6] .. ".dds", "dxt1", false)
					sightxports.sGui:setGuiRenderDisabled(img, 8 < i)
					table.insert(callLogAvatars[i], {img, 2})
				elseif type(contact[1]) == "string" then
					local label = sightxports.sGui:createGuiElement("label", 6, y + 2, h - 4, h - 4, appInside)
					sightxports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "center", "center")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelText(label, contact[1])
					sightxports.sGui:setGuiRenderDisabled(label, 8 < i)
					table.insert(callLogAvatars[i], {label, 2})
				elseif type(contact[1]) == "table" then
					local icon = sightxports.sGui:createGuiElement("image", 6 + (h - 4) / 2 - 12, y + 2 + (h - 4) / 2 - 12, 24, 24, appInside)
					sightxports.sGui:setImageFile(icon, sightxports.sGui:getFaIconFilename(contact[1][1], 24, contact[1][2]))
					sightxports.sGui:setImageColor(icon, "#ffffff")
					sightxports.sGui:setGuiRenderDisabled(icon, 8 < i)
					table.insert(callLogAvatars[i], {
						icon,
						2 + (h - 4) / 2 - 12
					})
				else
					local label = sightxports.sGui:createGuiElement("label", 6, y + 2, h - 4, h - 4, appInside)
					sightxports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
					sightxports.sGui:setLabelAlignment(label, "center", "center")
					sightxports.sGui:setLabelColor(label, "#ffffff")
					sightxports.sGui:setLabelText(label, "?")
					sightxports.sGui:setGuiRenderDisabled(label, 8 < i)
					table.insert(callLogAvatars[i], {label, 2})
				end
			else
				local rect = sightxports.sGui:createGuiElement("rectangle", 7, y + 3, h - 6, h - 6, appInside)
				sightxports.sGui:setGuiBackground(rect, "solid", {
					contactColors[1][1],
					contactColors[1][2],
					contactColors[1][3]
				})
				sightxports.sGui:setGuiRenderDisabled(rect, 8 < i)
				table.insert(callLogAvatars[i], {rect, 3})
				local label = sightxports.sGui:createGuiElement("label", 6, y + 2, h - 4, h - 4, appInside)
				sightxports.sGui:setLabelFont(label, "14/Ubuntu-R.ttf")
				sightxports.sGui:setLabelAlignment(label, "center", "center")
				sightxports.sGui:setLabelColor(label, "#ffffff")
				sightxports.sGui:setLabelText(label, "?")
				sightxports.sGui:setGuiRenderDisabled(label, 8 < i)
				table.insert(callLogAvatars[i], {label, 2})
			end
			if i <= 8 then
				sightxports.sGui:guiToFront(callLogElements[i][3])
			end
		end
	end
	local sh = h * 8 - 8
	local rect = sightxports.sGui:createGuiElement("rectangle", bsx - 9, topSize + ts + 4, 3, sh, appInside)
	sightxports.sGui:setGuiBackground(rect, "solid", grey1)
	callLogScrollBar = sightxports.sGui:createGuiElement("rectangle", bsx - 9, topSize + ts + 4, 3, sh / math.max(1, #callLog - 8 + 1), appInside)
	sightxports.sGui:setGuiBackground(callLogScrollBar, "solid", grey3)
	local w = (bsx - 8) / 3
	local btn = sightxports.sGui:createGuiElement("button", 4, bsy - topSize * 1.5 - 24, w, 24, appInside)
	sightxports.sGui:setGuiBackground(btn, "solid", blue)
	sightxports.sGui:setGuiHover(btn, "none", blue, false, true)
	sightxports.sGui:setButtonTextColor(btn, "#ffffff")
	sightxports.sGui:setButtonText(btn, "Névjegyek")
	sightxports.sGui:setButtonFont(btn, "9/Ubuntu-R.ttf")
	sightxports.sGui:setClickEvent(btn, "openContacts")
	local btn = sightxports.sGui:createGuiElement("button", 4 + w, bsy - topSize * 1.5 - 24, w, 24, appInside)
	sightxports.sGui:setGuiBackground(btn, "solid", blue2)
	sightxports.sGui:setGuiHover(btn, "none", blue2, false, true)
	sightxports.sGui:setButtonTextColor(btn, "#ffffff")
	sightxports.sGui:setButtonText(btn, "Legutóbbi")
	sightxports.sGui:setButtonFont(btn, "9/Ubuntu-R.ttf")
	local btn = sightxports.sGui:createGuiElement("button", 4 + w * 2, bsy - topSize * 1.5 - 24, w, 24, appInside)
	sightxports.sGui:setGuiBackground(btn, "solid", blue)
	sightxports.sGui:setGuiHover(btn, "none", blue, false, true)
	sightxports.sGui:setButtonTextColor(btn, "#ffffff")
	sightxports.sGui:setButtonText(btn, "Tárcsázó")
	sightxports.sGui:setButtonFont(btn, "9/Ubuntu-R.ttf")
	sightxports.sGui:setClickEvent(btn, "openDialer")
	generateBottom(true)
	bringBackFront()
end
