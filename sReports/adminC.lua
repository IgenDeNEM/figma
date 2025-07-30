local sightexports = {
	sGui = false,
	sAdministration = false,
	sPermission = false
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
  local sightlangGuiRefreshColors = function()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
	  refreshColors()
	end
  end
  addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
  local sightlangCondHandlState0 = false
  local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
	  sightlangCondHandlState0 = cond
	  if cond then
		addEventHandler("onClientKey", getRootElement(), adminReportPanelScrollKey, true, prio)
	  else
		removeEventHandler("onClientKey", getRootElement(), adminReportPanelScrollKey)
	  end
	end
  end
  local adminWindow = false
  local fpsGreen = false
  local reportFont = false
  local reportFontH = false
  local reportFontS = false
  local reportFontB = false
  local reportFontBH = false
  local reportFontBS = false
  local panelWidth = 0
  local panelHeight = 0
  local titleBarHeight = 0
  local reportScroll = 0
  local writingState = false
  local writing = false
  local currentMenu = "open"
  local reportCategoryButtons = {}
  local disabledCategories = {}
  local soundState = true
  local bellIcon = false
  local adminMenus = {
	{
	  {
		"file-alt",
		"regular",
		"Nyitott ügyek [0]"
	  },
	  false,
	  "open"
	}
  }
  local reportData = {}
  local reportList = {}
  local myReports = {}
  local myReportWriting = {}
  local myReportMessages = {}
  local myReportMessagesLoaded = {}
  local myReportInput = {}
  local messages = {}
  local sumH = 0
  local currentScroll = 0
  local copyMenu = false
  local copyMenuId = false
  local copyMenuTexts = {}
  local sbBack = false
  local scrollbar = false
  local sh = 0
  local adminInputSize = false
  local adminInputRect = false
  local adminMessageInput = false
  local promptWindow = false
  local adminMenu = false
  local adminSection = false
  local reportTemplateWindow = false
  local reportTemplatesElements = {}
  local reportTemplates = {}
  local reportTemplateScroll = 0
  local reportTemplateScrollElement = false
  local reportTemplateDeletePromptWindow = false
  local reportTemplateEditor = false
  local templateTitleInput, templateMessageInput
  addEvent("forceDeleteReportPanel", true)
  addEventHandler("forceDeleteReportPanel", getRootElement(), function()
	deleteAdminGui()
	reportData = {}
	reportList = {}
	myReports = {}
	myReportMessages = {}
	myReportMessagesLoaded = {}
	myReportInput = {}
	if reportTemplateEditor then
	  sightexports.sGui:deleteGuiElement(reportTemplateEditor)
	end
	reportTemplateEditor = nil
	if reportTemplateWindow then
	  sightexports.sGui:deleteGuiElement(reportTemplateWindow)
	end
	reportTemplateWindow = nil
	if reportTemplateDeletePromptWindow then
	  sightexports.sGui:deleteGuiElement(reportTemplateDeletePromptWindow)
	end
	reportTemplateDeletePromptWindow = nil
  end)
  function deleteAdminGui()
	bellIcon = false
	scrollbar = false
	sbBack = false
	adminMenu = false
	adminSection = false
	if writingState then
	  triggerServerEvent("changeWritingStateAdmin", localPlayer, writingState, false)
	end
	writingState = false
	writing = false
	local x, y = false, false
	if adminWindow then
	  x, y = sightexports.sGui:getGuiPosition(adminWindow)
	  sightexports.sGui:deleteGuiElement(adminWindow)
	end
	adminMessageInput = false
	adminWindow = false
	if promptWindow then
	  sightexports.sGui:deleteGuiElement(promptWindow)
	end
	promptWindow = false
	sightlangCondHandl0(false)
	messages = {}
	return x, y
  end
  addEvent("copyAdminToClipboard", false)
  addEventHandler("copyAdminToClipboard", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if copyMenuTexts[el] then
	  if setClipboard(copyMenuTexts[el]) then
		sightexports.sGui:showInfobox("s", "Sikeresen a vágólapra másoltad a szöveget.")
		outputConsole("[Report] Vágólapra másolva: " .. copyMenuTexts[el])
	  else
		outputChatBox("[color=sightred][SightMTA - Report]:#ffffff Sikertelen másolás: " .. copyMenuTexts[el])
	  end
	  if copyMenu then
		sightexports.sGui:deleteGuiElement(copyMenu)
	  end
	  copyMenu = false
	  copyMenuTexts = {}
	  copyMenuId = false
	end
  end)
  addEvent("openURLFromReportAdmin", false)
  addEventHandler("openURLFromReportAdmin", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if copyMenuTexts[el] then
	  openURL(copyMenuTexts[el])
	  if copyMenu then
		sightexports.sGui:deleteGuiElement(copyMenu)
	  end
	  copyMenu = false
	  copyMenuTexts = {}
	  copyMenuId = false
	end
  end)
  addEvent("openUCP", true)
  addEventHandler("openUCP", getRootElement(), function(button, state, absoluteX, absoluteY, el, arg)
	if (getElementData(localPlayer, "acc.adminLevel") or 0) >= 1 then
	  openURL("https://ucp.see-game.com/sight/profile/" .. arg .. "/")
	end
  end)
  addEvent("openCopyMenuAdmin", false)
  addEventHandler("openCopyMenuAdmin", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if copyMenu then
	  sightexports.sGui:deleteGuiElement(copyMenu)
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
	  local x, y = sightexports.sGui:getGuiRealPosition(el)
	  x = absoluteX - x + 8
	  y = absoluteY - y
	  copyMenu = sightexports.sGui:createGuiElement("null", x, y, 200, 20 * (1 + #messages[msg][8]), el)
	  local btn = sightexports.sGui:createGuiElement("button", 0, 0, 200, 20, copyMenu)
	  sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
	  sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	  }, false, true)
	  sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
	  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	  sightexports.sGui:setButtonText(btn, "Szöveg másolása")
	  copyMenuTexts[btn] = messages[msg][9]
	  sightexports.sGui:disableClickTrough(btn, true)
	  sightexports.sGui:setClickEvent(btn, "copyAdminToClipboard")
	  for i = 1, #messages[msg][8] do
		local btn = sightexports.sGui:createGuiElement("button", 0, 20 * i, 200, 20, copyMenu)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
		sightexports.sGui:setGuiHover(btn, "gradient", {
		  "sightgreen",
		  "sightgreen-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:disableClickTrough(btn, true)
		sightexports.sGui:setClickEvent(btn, "openURLFromReportAdmin")
		copyMenuTexts[btn] = messages[msg][8][i]
		if utf8.len(messages[msg][8][i]) > 33 then
		  sightexports.sGui:setButtonText(btn, utf8.sub(messages[msg][8][i], 1, 30) .. "...")
		else
		  sightexports.sGui:setButtonText(btn, messages[msg][8][i])
		end
	  end
	end
  end)
  addEvent("adminWritingState", true)
  addEventHandler("adminWritingState", getRootElement(), function(report, state)
	myReportWriting[report] = state
	if adminWindow and myReportMessagesLoaded[report] and type(currentMenu) == "table" and currentMenu[1] == "my" and myReports[currentMenu[2]].id == report then
	  if writing then
		sightexports.sGui:deleteGuiElement(writing)
	  end
	  writing = nil
	  if state then
		writing = sightexports.sGui:createGuiElement("label", 0, 0, panelWidth / 3 * 2, 24, adminWindow)
		sightexports.sGui:setLabelFont(writing, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(writing, state .. " éppen ír...")
		sightexports.sGui:setLabelClip(writing, true)
		sightexports.sGui:setLabelColor(writing, "#a0a0a0")
		sightexports.sGui:setLabelAlignment(writing, "center", "center")
	  end
	  processReportAdminMessages()
	end
  end)
  addEvent("toggleAdminReportSound", false)
  addEventHandler("toggleAdminReportSound", getRootElement(), function()
	soundState = not soundState
	local ih = titleBarHeight - 8
	sightexports.sGui:setImageFile(bellIcon, sightexports.sGui:getFaIconFilename(soundState and "bell" or "bell-slash", ih))
	sightexports.sGui:setImageColor(bellIcon, soundState and "#ffffff" or "#a0a0a0")
  end)
  addEvent("selectAdminReportMenu", false)
  addEventHandler("selectAdminReportMenu", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	local refresh = false
	local newMenu = "open"
	for j = #adminMenus, 1, -1 do
	  if adminMenus[j][4] then
		table.remove(adminMenus, j)
		refresh = true
	  end
	end
	for i = 1, #adminMenus do
	  if adminMenus[i][2] == el then
		newMenu = adminMenus[i][3]
	  end
	end
	if refresh then
	  createAdminMenu()
	end
	setNewAdminMenu(newMenu)
  end)
  addEvent("selectAdminReportCategory", false)
  addEventHandler("selectAdminReportCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	local cat = sightexports.sGui:getButtonText(el)
	disabledCategories[cat] = not disabledCategories[cat]
	if disabledCategories[cat] then
	  sightexports.sGui:setGuiBackground(el, "solid", "sightgrey3")
	  sightexports.sGui:setGuiHover(el, "gradient", {"sightgrey3", "sightgrey2"}, true, true)
	else
	  sightexports.sGui:setGuiBackground(el, "solid", "sightgreen")
	  sightexports.sGui:setGuiHover(el, "gradient", {
		"sightgreen",
		"sightgreen-second"
	  }, true, true)
	end
	local c = 0
	for i = 1, #reportData do
	  if not disabledCategories[reportData[i].category] then
		c = c + 1
	  end
	end
	adminMenus[1][1][3] = "Nyitott ügyek [" .. c .. "]"
	refreshReportList()
	refreshAdminMenuLabels()
  end)
  function adminReportPanelScrollKey(key)
	if reportTemplateWindow then
	  if key == "mouse_wheel_up" then
		if 0 < reportTemplateScroll then
		  reportTemplateScroll = reportTemplateScroll - 1
		  reportTemplateScrollHandler()
		end
	  elseif key == "mouse_wheel_down" and reportTemplateScroll < #reportTemplates - 10 then
		reportTemplateScroll = reportTemplateScroll + 1
		reportTemplateScrollHandler()
	  end
	elseif type(currentMenu) == "table" and currentMenu[1] == "my" and myReports[currentMenu[2]] then
	  if key == "mouse_wheel_down" then
		local tmp = currentScroll
		tmp = currentScroll - 24
		if tmp < 0 then
		  tmp = 0
		end
		if tmp ~= currentScroll then
		  currentScroll = tmp
		  processReportAdminMessages()
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
			processReportAdminMessages()
		  end
		end
	  end
	elseif currentMenu == "open" then
	  if key == "mouse_wheel_down" then
		if reportScroll < #reportList - 11 then
		  reportScroll = reportScroll + 1
		  refreshReports()
		end
	  elseif key == "mouse_wheel_up" and 0 < reportScroll then
		reportScroll = reportScroll - 1
		refreshReports()
	  end
	end
  end
  function reportListSort(a, b)
	return reportData[b[6]].id > reportData[a[6]].id
  end
  function refreshReportList()
	reportList = {}
	for i = 1, #reportData do
	  if not disabledCategories[reportData[i].category] then
		table.insert(reportList, {
		  reportData[i].id,
		  sightexports.sGui:getColorCodeHex(categoryColors[reportData[i].category] or "sightgreen") .. reportData[i].category,
		  reportData[i].title,
		  reportData[i].sentName:gsub("_", " "),
		  reportData[i].lastEdit,
		  i
		})
	  end
	end
	table.sort(reportList, reportListSort)
	if reportScroll + 11 > #reportList then
	  reportScroll = math.max(0, #reportList - 11)
	end
	if adminWindow and currentMenu == "open" then
	  refreshReports()
	end
  end
  function sortAdminMenus(a, b)
	local sva = -1
	if type(a[3]) == "table" and (a[3][1] == "open" or a[3][1] == "my") then
	  sva = a[3][2]
	end
	local svb = -1
	if type(b[3]) == "table" and (b[3][1] == "open" or b[3][1] == "my") then
	  svb = b[3][2]
	end
	return sva < svb
  end
  addEvent("gotAdminOpenReports", true)
  addEventHandler("gotAdminOpenReports", getRootElement(), function(data, my, to, new, del, myNew)
	local reCreateMenu = false
	local refreshLabel = false
	if data or new or del then
	  local wasId = false
	  if type(currentMenu) == "table" and currentMenu[1] == "open" and reportData[currentMenu[2]] and reportData[currentMenu[2]].id then
		wasId = reportData[currentMenu[2]].id
	  end
	  local was = #reportData
	  for i = #adminMenus, 2, -1 do
		if type(adminMenus[i][3]) == "table" and adminMenus[i][3][1] == "open" then
		  adminMenus[i][3][2] = reportData[adminMenus[i][3][2]] and reportData[adminMenus[i][3][2]].id
		end
	  end
	  if del then
		for i = #reportData, 1, -1 do
		  if reportData[i].id == del then
			table.remove(reportData, i)
		  end
		end
	  elseif new then
		table.insert(reportData, new)
	  else
		reportData = data
	  end
	  if #reportData ~= was then
		refreshLabel = true
		local c = 0
		for i = 1, #reportData do
		  if not disabledCategories[reportData[i].category] then
			c = c + 1
		  end
		end
		adminMenus[1][1][3] = "Nyitott ügyek [" .. c .. "]"
	  end
	  local tmp = {}
	  for i = 1, #reportData do
		tmp[reportData[i].id] = i
	  end
	  if was < #reportData and soundState and new and not disabledCategories[new.category] then
		playSound("files/newreport.wav")
	  end
	  for i = #adminMenus, 2, -1 do
		if type(adminMenus[i][3]) == "table" and adminMenus[i][3][1] == "open" then
		  if adminMenus[i][3][2] then
			local id = tmp[adminMenus[i][3][2]]
			if id then
			  adminMenus[i][3][2] = id
			else
			  table.remove(adminMenus, i)
			  reCreateMenu = true
			end
		  else
			table.remove(adminMenus, i)
			reCreateMenu = true
		  end
		end
	  end
	  if wasId then
		if tmp[wasId] then
		  currentMenu[2] = tmp[wasId]
		else
		  setNewAdminMenu("open")
		end
	  end
	  refreshReportList()
	end
	local to = false
	if my or new or del or myNew then
	  local wasId = false
	  if type(currentMenu) == "table" and currentMenu[1] == "my" and myReports[currentMenu[2]] and myReports[currentMenu[2]].id then
		wasId = myReports[currentMenu[2]].id
	  end
	  for i = #adminMenus, 2, -1 do
		if type(adminMenus[i][3]) == "table" and adminMenus[i][3][1] == "my" then
		  adminMenus[i][3][2] = myReports[adminMenus[i][3][2]] and myReports[adminMenus[i][3][2]].id
		end
	  end
	  if myNew then
		to = myNew.id
		table.insert(myReports, myNew)
	  elseif del or new then
		for i = #myReports, 1, -1 do
		  if myReports[i].id == del or new and myReports[i].id == new.id then
			table.remove(myReports, i)
		  end
		end
	  else
		myReports = my
	  end
	  local tmp = {}
	  for i = 1, #myReports do
		tmp[myReports[i].id] = i
	  end
	  for id in pairs(myReportMessages) do
		if not tmp[id] then
		  myReportMessages[id] = nil
		end
	  end
	  for id in pairs(myReportMessagesLoaded) do
		if not tmp[id] then
		  myReportMessagesLoaded[id] = nil
		end
	  end
	  for id in pairs(myReportInput) do
		if not tmp[id] then
		  myReportInput[id] = nil
		end
	  end
	  for id in pairs(myReportWriting) do
		if not tmp[id] then
		  myReportWriting[id] = nil
		end
	  end
	  if wasId and not to then
		if tmp[wasId] then
		  currentMenu[2] = tmp[wasId]
		else
		  setNewAdminMenu("open")
		end
	  end
	  for i = #adminMenus, 2, -1 do
		if type(adminMenus[i][3]) == "table" and adminMenus[i][3][1] == "my" then
		  if adminMenus[i][3][2] then
			local id = tmp[adminMenus[i][3][2]]
			tmp[adminMenus[i][3][2]] = nil
			if id then
			  adminMenus[i][3][2] = id
			else
			  table.remove(adminMenus, i)
			  reCreateMenu = true
			end
		  else
			table.remove(adminMenus, i)
			reCreateMenu = true
		  end
		end
	  end
	  for id, i in pairs(tmp) do
		table.insert(adminMenus, {
		  {
			"file-alt",
			"solid",
			"Report " .. id
		  },
		  false,
		  {"my", i}
		})
		reCreateMenu = true
	  end
	end
	if adminWindow then
	  if reCreateMenu then
		table.sort(adminMenus, sortAdminMenus)
		createAdminMenu()
	  elseif refreshLabel then
		refreshAdminMenuLabels()
	  end
	end
	if to then
	  for i = 1, #myReports do
		if myReports[i].id == to then
		  setNewAdminMenu({"my", i})
		end
	  end
	end
  end)
  local tabs = {
	"ID:",
	"Kategória:",
	"Rövid cím:",
	"Beküldte:",
	"Nyitva:"
  }
  local reportButtons = {}
  local reportElements = {}
  addEvent("openAdminReport", true)
  addEventHandler("openAdminReport", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if reportButtons[el] then
	  local dat = reportData[reportButtons[el]]
	  if dat then
		table.insert(adminMenus, {
		  {
			"file-alt",
			"regular",
			"Report " .. dat.id
		  },
		  false,
		  {
			"open",
			reportButtons[el]
		  },
		  true
		})
		createAdminMenu()
		setNewAdminMenu({
		  "open",
		  reportButtons[el]
		})
	  end
	end
  end)
  function reportMessageSort(a, b)
	return a.id < b.id
  end
  addEvent("gotMessagesForAdminReport", true)
  addEventHandler("gotMessagesForAdminReport", getRootElement(), function(report, result)
	local tmp = {}
	if not myReportMessages[report] then
	  myReportMessages[report] = {}
	else
	  for i = 1, #myReportMessages[report] do
		tmp[myReportMessages[report][i].id] = i
	  end
	end
	for i = 1, #result do
	  if not tmp[result[i].id] then
		table.insert(myReportMessages[report], result[i])
	  else
		myReportMessages[report][tmp[result[i].id]] = result[i]
	  end
	end
	table.sort(myReportMessages[report], reportMessageSort)
	myReportMessagesLoaded[report] = true
	if adminWindow and type(currentMenu) == "table" and currentMenu[1] == "my" and myReports[currentMenu[2]].id == report then
	  createAdminSection()
	end
  end)
  local unreadAdminMessages = {}
  addEvent("newMessageForAdmin", true)
  addEventHandler("newMessageForAdmin", getRootElement(), function(msg, lid)
	local report = msg.reportId
	local currPage = adminWindow and type(currentMenu) == "table" and currentMenu[1] == "my" and myReports[currentMenu[2]].id == report
	local insert = true
	if not myReportMessages[report] then
	  myReportMessages[report] = {}
	else
	  for i = 1, #myReportMessages[report] do
		if myReportMessages[report][i].id == msg.id then
		  myReportMessages[report][i] = msg
		  insert = false
		end
	  end
	end
	if insert then
	  table.insert(myReportMessages[report], msg)
	end
	local reSort = false
	local lastId = false
	for i = #myReportMessages[report], 1, -1 do
	  local id = myReportMessages[report][i].id
	  if id then
		if lastId and lastId < id then
		  reSort = true
		end
		lastId = id
	  end
	end
	if reSort then
	  table.sort(myReportMessages[report], reportMessageSort)
	  createAdminSection()
	  return
	end
	local id = false
	for i = 1, #myReports do
	  if myReports[i].id == report then
		id = i
	  end
	end
	if currPage then
	  if myReportMessagesLoaded[report] then
		if lid then
		  deleteAdminMessage(lid)
		end
		local time = getRealTime(msg.date)
		local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
		if msg.sender == 0 then
		  createAdminSystemMessageEx({
			date,
			msg.message
		  }, msg.id)
		elseif msg.sender == myReports[currentMenu[2]].sentBy then
		  createAdminMessage(date, msg.message, false, msg.id, false, false, true)
		else
		  createAdminMessage(date, msg.message, true, msg.id, math.max(msg.date, msg.seen), 0 < msg.seen, true)
		end
	  end
	  processReportAdminMessages()
	  if soundState and msg.sender == myReports[currentMenu[2]].sentBy then
		playSound("files/message2.wav")
	  end
	elseif soundState and id and msg.sender == myReports[id].sentBy then
	  playSound("files/message.wav")
	end
	if id and 0 >= msg.seen and msg.sender == myReports[id].sentBy then
	  table.insert(unreadAdminMessages, {
		msg.reportId,
		msg.id
	  })
	end
	processReportAdminUnread()
  end)
  addEvent("acceptAdminReport", false)
  addEventHandler("acceptAdminReport", getRootElement(), function()
	if type(currentMenu) == "table" and currentMenu[1] == "open" and reportData[currentMenu[2]] then
	  triggerServerEvent("acceptAdminReport", localPlayer, reportData[currentMenu[2]].id)
	end
  end)
  addEvent("closeAdminReport", false)
  addEventHandler("closeAdminReport", getRootElement(), function()
	if type(currentMenu) == "table" and currentMenu[1] == "my" and myReports[currentMenu[2]] then
	  triggerServerEvent("closeAdminReport", localPlayer, myReports[currentMenu[2]].id)
	  setNewAdminMenu("open")
	  if promptWindow then
		sightexports.sGui:deleteGuiElement(promptWindow)
	  end
	  promptWindow = false
	end
  end)
  addEvent("cancelAdminReport", false)
  addEventHandler("cancelAdminReport", getRootElement(), function()
	if type(currentMenu) == "table" and currentMenu[1] == "my" and myReports[currentMenu[2]] then
	  triggerServerEvent("cancelAdminReport", localPlayer, myReports[currentMenu[2]].id)
	  setNewAdminMenu("open")
	end
  end)
  addEvent("sendAdminReportMessage", false)
  addEventHandler("sendAdminReportMessage", getRootElement(), function()
	if adminMessageInput and type(currentMenu) == "table" and currentMenu[1] == "my" and myReports[currentMenu[2]] then
	  local message = sightexports.sGui:getInputValue(adminMessageInput)
	  if message and utf8.len(message) > 0 then
		local time = getRealTime()
		local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
		local id = createAdminMessage(date, message, true, false)
		processReportAdminMessages()
		triggerServerEvent("sendReportMessage", localPlayer, myReports[currentMenu[2]].id, message, id)
		sightexports.sGui:resetInput(adminMessageInput)
		myReportInput[myReports[currentMenu[2]].id] = false
	  end
	end
  end)
  addEvent("reportAdminMessageSeen", true)
  addEventHandler("reportAdminMessageSeen", getRootElement(), function(data)
	local proc = false
	for i = 1, #data do
	  local report, id, ts = data[i][1], data[i][2], data[i][3]
	  if myReportMessages[report] then
		for i = #myReportMessages[report], 1, -1 do
		  if myReportMessages[report][i].id == id then
			myReportMessages[report][i].seen = ts
			if myReportMessagesLoaded[report] and type(currentMenu) == "table" and currentMenu[1] == "my" and myReports[currentMenu[2]].id == report then
			  local time = getRealTime(myReportMessages[report][i].date)
			  local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
			  createAdminMessage(date, myReportMessages[report][i].message, true, id, ts, true, true)
			  processReportAdminMessages()
			end
			break
		  end
		end
	  end
	end
  end)
  function getReportMinutes(t)
	local delta = math.floor((getRealTime().timestamp - t) / 60)
	if delta < 0 then
	  delta = 0
	end
	if 60 <= delta then
	  return sightexports.sGui:getColorCodeHex("sightred") .. math.floor(delta / 60) .. " órája"
	elseif 15 <= delta then
	  return sightexports.sGui:getColorCodeHex("sightorange") .. delta .. " perce"
	elseif 5 <= delta then
	  return sightexports.sGui:getColorCodeHex("sightyellow") .. delta .. " perce"
	else
	  return delta .. " perce"
	end
  end
  function refreshReports()
	local n = 11
	for i = 1, n do
	  if reportList[i + reportScroll] then
		reportButtons[reportElements[i][1]] = reportList[i + reportScroll][6]
		for j = 1, #tabs do
		  sightexports.sGui:setLabelText(reportElements[i][1 + j], j < #tabs and reportList[i + reportScroll][j] or getReportMinutes(reportList[i + reportScroll][j]))
		end
		for j = 1, #reportElements[i] do
		  sightexports.sGui:setGuiRenderDisabled(reportElements[i][j], false)
		end
	  else
		for j = 1, #reportElements[i] do
		  sightexports.sGui:setGuiRenderDisabled(reportElements[i][j], true)
		end
	  end
	end
	local y = titleBarHeight + 4 + 32 + 8 + 24 + 8
	local h = math.floor((panelHeight - y - 8 - 24) / n) - 10
	local topH = 32
	local sy = panelHeight - titleBarHeight - topH - 4 - 16 - 24 - h - 4
	local sh = sy / math.max(1, #reportList - n + 1)
	sightexports.sGui:setGuiPosition(scrollbar, false, titleBarHeight + 32 + 8 + 24 + h + sh * reportScroll)
	sightexports.sGui:setGuiSize(scrollbar, false, sh)
  end
  function deleteAdminMessage(id, noRemove)
	local i = false
	for j in pairs(messages) do
	  if messages[j] and messages[j][7] == id then
		i = j
		break
	  end
	end
	if i then
	  if messages[i][1] then
		sightexports.sGui:deleteGuiElement(messages[i][1])
	  end
	  for j = 1, #messages[i][3] do
		sightexports.sGui:deleteGuiElement(messages[i][3][j][1])
	  end
	  if messages[i][5] then
		for j = 1, #messages[i][5] do
		  sightexports.sGui:deleteGuiElement(messages[i][5][j][1])
		end
	  end
	  if noRemove then
		return i
	  else
		table.remove(messages, i)
	  end
	end
  end
  local unreadCount = {}
  function processReportAdminUnread()
	if adminWindow and type(currentMenu) == "table" and currentMenu[1] == "my" and not afkState then
	  local tmp = {}
	  for i = #unreadAdminMessages, 1, -1 do
		if unreadAdminMessages[i] and myReports[currentMenu[2]].id == unreadAdminMessages[i][1] then
		  table.insert(tmp, unreadAdminMessages[i])
		  table.remove(unreadAdminMessages, i)
		end
	  end
	  triggerServerEvent("processUnreadMessages", localPlayer, tmp)
	end
	unreadCount = {}
	for i = 1, #myReports do
	  if myReports[i] then
		unreadCount[myReports[i].id] = 0
	  end
	end
	for i = #unreadAdminMessages, 1, -1 do
	  if unreadAdminMessages[i] then
		unreadCount[unreadAdminMessages[i][1]] = (unreadCount[unreadAdminMessages[i][1]] or 0) + 1
	  end
	end
	for k, v in pairs(unreadCount) do
	  for i = 1, #adminMenus do
		if adminMenus[i] and type(adminMenus[i][3]) == "table" and adminMenus[i][3][1] == "my" and myReports[adminMenus[i][3][2]].id == k then
		  adminMenus[i][1][3] = "Report " .. k .. (0 < v and " [" .. v .. "]" or "")
		end
	  end
	end
	refreshAdminMenuLabels()
  end
  function processReportAdminMessages()
	local y = panelHeight - adminInputSize
	local by = y
	local ty = titleBarHeight + 32 + 4
	if writing then
	  y = y - 24
	  sightexports.sGui:setGuiPosition(writing, false, y)
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
		  sightexports.sGui:setGuiSize(messages[i][1], false, by - ty)
		  sightexports.sGui:setGuiPosition(messages[i][1], false, ty)
		elseif ty > y + sy then
		  sightexports.sGui:setGuiRenderDisabled(messages[i][1], true)
		elseif by < y then
		  sightexports.sGui:setGuiRenderDisabled(messages[i][1], true)
		elseif by < y + sy then
		  sightexports.sGui:setGuiRenderDisabled(messages[i][1], false)
		  sightexports.sGui:setGuiSize(messages[i][1], false, by - y)
		  sightexports.sGui:setGuiPosition(messages[i][1], false, y)
		elseif ty > y then
		  sightexports.sGui:setGuiRenderDisabled(messages[i][1], false)
		  sightexports.sGui:setGuiPosition(messages[i][1], false, ty)
		  sightexports.sGui:setGuiSize(messages[i][1], false, y + sy - ty)
		else
		  sightexports.sGui:setGuiRenderDisabled(messages[i][1], false)
		  sightexports.sGui:setGuiPosition(messages[i][1], false, y)
		  sightexports.sGui:setGuiSize(messages[i][1], false, sy)
		end
	  end
	  for j = 1, #messages[i][3] do
		local y = y + messages[i][3][j][2]
		local sy = messages[i][3][j][3]
		if ty > y + sy then
		  sightexports.sGui:setGuiRenderDisabled(messages[i][3][j][1], true)
		elseif by < y then
		  sightexports.sGui:setGuiRenderDisabled(messages[i][3][j][1], true)
		elseif by < y + sy then
		  sightexports.sGui:setGuiRenderDisabled(messages[i][3][j][1], false)
		  sightexports.sGui:setGuiSize(messages[i][3][j][1], false, by - y)
		  sightexports.sGui:setGuiPosition(messages[i][3][j][1], false, y)
		  sightexports.sGui:setLabelAlignment(messages[i][3][j][1], false, "top")
		elseif ty > y then
		  sightexports.sGui:setGuiRenderDisabled(messages[i][3][j][1], false)
		  sightexports.sGui:setGuiSize(messages[i][3][j][1], false, y + sy - ty)
		  sightexports.sGui:setGuiPosition(messages[i][3][j][1], false, ty)
		  sightexports.sGui:setLabelAlignment(messages[i][3][j][1], false, "bottom")
		else
		  sightexports.sGui:setGuiRenderDisabled(messages[i][3][j][1], false)
		  sightexports.sGui:setGuiPosition(messages[i][3][j][1], false, y)
		  sightexports.sGui:setGuiSize(messages[i][3][j][1], false, sy)
		end
	  end
	  if messages[i][5] then
		for j = 1, #messages[i][5] do
		  local y = y + messages[i][5][j][2]
		  local sy = messages[i][5][j][4]
		  if ty > y + sy then
			sightexports.sGui:setGuiRenderDisabled(messages[i][5][j][1], true)
		  elseif by < y then
			sightexports.sGui:setGuiRenderDisabled(messages[i][5][j][1], true)
		  elseif by < y + sy then
			sightexports.sGui:setGuiRenderDisabled(messages[i][5][j][1], false)
			sightexports.sGui:setGuiSize(messages[i][5][j][1], false, by - y)
			sightexports.sGui:setImageUV(messages[i][5][j][1], 0, 0, messages[i][5][j][3], by - y)
			sightexports.sGui:setGuiPosition(messages[i][5][j][1], false, y)
		  elseif ty > y then
			sightexports.sGui:setGuiRenderDisabled(messages[i][5][j][1], false)
			sightexports.sGui:setGuiSize(messages[i][5][j][1], false, y + sy - ty)
			sightexports.sGui:setImageUV(messages[i][5][j][1], 0, sy - (y + sy - ty), messages[i][5][j][3], y + sy - ty)
			sightexports.sGui:setGuiPosition(messages[i][5][j][1], false, ty)
		  else
			sightexports.sGui:setGuiRenderDisabled(messages[i][5][j][1], false)
			sightexports.sGui:setGuiPosition(messages[i][5][j][1], false, y)
			sightexports.sGui:setGuiSize(messages[i][5][j][1], false, sy)
			sightexports.sGui:setImageUV(messages[i][5][j][1])
		  end
		end
	  end
	end
	local sy = panelHeight - titleBarHeight - 32 - 4 - 16 - adminInputSize
	local div = (sy + 16) / sumH
	sumH = math.max(0, sumH - (panelHeight - adminInputSize) + ty + 16)
	local progress = 1 - (0 < sumH and currentScroll / sumH or 0)
	if div < 0 then
	  div = 0
	end
	if 1 < div then
	  div = 1
	end
	local sh = sy * div
	sightexports.sGui:setGuiSize(sbBack, false, sy)
	sightexports.sGui:setGuiPosition(scrollbar, false, titleBarHeight + 32 + 4 + 8 + (sy - sh) * progress)
	sightexports.sGui:setGuiSize(scrollbar, false, sh)
	if currentScroll > sumH then
	  currentScroll = sumH
	  processReportAdminMessages()
	end
  end
  function createAdminSystemMessageEx(text, id)
	if not adminWindow then
	  return
	end
	local labels = {}
	local h = sightexports.sGui:getFontHeight("10/Ubuntu-R.ttf")
	local sy = 0
	if type(text) == "table" then
	  local h2 = sightexports.sGui:getFontHeight("10/Ubuntu-R.ttf")
	  for i = 1, #text do
		local label = sightexports.sGui:createGuiElement("label", 0, (i - 1) * h, panelWidth / 3 * 2 - 6, i <= 1 and h2 or h, adminSection)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-" .. (i <= 1 and "R" or "R") .. ".ttf")
		sightexports.sGui:setLabelColor(label, 1 < i and "sightgreen" or "#a0a0a0")
		sightexports.sGui:setLabelText(label, text[i])
		sightexports.sGui:setLabelClip(label, true)
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		table.insert(labels, {
		  label,
		  (i - 1) * h,
		  i <= 1 and h2 or h
		})
		sy = sy + (i <= 1 and h2 or h)
	  end
	else
	  local label = sightexports.sGui:createGuiElement("label", 0, 0, panelWidth / 3 * 2 - 6, h, adminSection)
	  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
	  sightexports.sGui:setLabelText(label, text)
	  sightexports.sGui:setLabelClip(label, true)
	  sightexports.sGui:setLabelColor(label, "#a0a0a0")
	  sightexports.sGui:setLabelAlignment(label, "center", "center")
	  table.insert(labels, {
		label,
		0,
		h
	  })
	  sy = sy + h
	end
	if id then
	  local i = deleteAdminMessage(id, true)
	  if i then
		messages[i] = {
		  false,
		  false,
		  labels,
		  sy,
		  false,
		  false,
		  id
		}
	  else
		table.insert(messages, {
		  false,
		  false,
		  labels,
		  sy,
		  false,
		  false,
		  id
		})
	  end
	end
  end
  function createAdminMessage(date, text, self, id, checkdate, seen, replace)
	if not adminWindow then
	  return
	end
	local checkEls = {}
	local labels = {}
	local imgs = {}
	local msgW = panelWidth / 3 * 2 - 80
	local h3 = sightexports.sGui:getFontHeight("9/Ubuntu-R.ttf")
	local h2 = h3
	local h = sightexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
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
	  local w = sightexports.sGui:getTextWidthFont(textEx .. " " .. word, "11/Ubuntu-R.ttf", 1, true)
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
	local label = sightexports.sGui:createGuiElement("label", self and panelWidth / 3 * 2 - 6 - msgW or 8, 0, msgW - 8, h2, adminSection)
	sightexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
	sightexports.sGui:setLabelText(label, date)
	sightexports.sGui:setLabelColor(label, "#a0a0a0")
	sightexports.sGui:setLabelClip(label, true)
	sightexports.sGui:setLabelAlignment(label, self and "right" or "left", "center")
	table.insert(labels, {
	  label,
	  0,
	  h2
	})
	local rect = sightexports.sGui:createGuiElement("rectangle", self and panelWidth / 3 * 2 - 6 - msgW - 8 or 8, h2 + 4, msgW, sy, adminSection)
	sightexports.sGui:setGuiBackground(rect, "solid", self and "sightblue" or "sightgreen")
	sightexports.sGui:setGuiHover(rect, "gradient", {
	  self and "sightblue" or "sightgreen",
	  (self and "sightblue" or "sightgreen") .. "-second"
	}, false, true)
	sightexports.sGui:setGuiHoverable(rect, true)
	sightexports.sGui:setClickEvent(rect, "openCopyMenuAdmin")
	local lastLabel = false
	local w = 0
	for i = 1, #lines do
	  for j = 1, #lines[i] do
		if lastLabel then
		  w = w + sightexports.sGui:getLabelTextWidth(lastLabel)
		end
		local label = sightexports.sGui:createGuiElement("label", (self and panelWidth / 3 * 2 - 6 - msgW - 4 or 12) + w, h2 + 8 + (i - 1) * h, msgW - 8, h, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, lines[i][j][1])
		if lines[i][j][2] then
		  sightexports.sGui:setLabelColor(label, lines[i][j][2])
		end
		sightexports.sGui:setLabelClip(label, true)
		sightexports.sGui:setLabelAlignment(label, "left", "center")
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
	  local label = sightexports.sGui:createGuiElement("label", self and panelWidth / 3 * 2 - 6 - msgW or 8, h2 + 8 + #lines * h + 8, msgW - 8, h3, adminSection)
	  sightexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
	  sightexports.sGui:setLabelColor(label, seen and "sightgreen" or "#a0a0a0")
	  if getRealTime().yearday == time.yearday then
		sightexports.sGui:setLabelText(label, string.format("%02d:%02d:%02d", time.hour, time.minute, time.second))
	  else
		sightexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second))
	  end
	  sightexports.sGui:setLabelClip(label, true)
	  sightexports.sGui:setLabelAlignment(label, "right", "center")
	  table.insert(labels, {
		label,
		h2 + 8 + #lines * h + 8,
		h3
	  })
	  table.insert(checkEls, label)
	  local icon = sightexports.sGui:createGuiElement("image", (self and panelWidth / 3 * 2 - 6 - msgW or 8) + msgW - 8 - sightexports.sGui:getLabelTextWidth(label) - h3, h2 + 8 + #lines * h + 8, h3, h3, adminSection)
	  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("check", h3))
	  sightexports.sGui:setImageColor(icon, seen and "sightgreen" or "#a0a0a0")
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
	  local i = deleteAdminMessage(tonumber(replace) or id, true)
	  if i then
		messages[i] = {
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
  function checkAdminInput(el)
	if type(currentMenu) == "table" and currentMenu[1] == "my" and myReports[currentMenu[2]] then
	  local state = adminMessageInput == el
	  local id = myReports[currentMenu[2]].id
	  writingState = state and id or false
	  triggerServerEvent("changeWritingStateAdmin", localPlayer, id, state)
	end
	adminInputSize = 32 * (adminMessageInput == el and 2 or 1) + 8
	sightexports.sGui:setGuiPosition(adminMessageInput, false, panelHeight - (adminInputSize - 8) - 4)
	sightexports.sGui:setGuiSize(adminMessageInput, false, adminInputSize - 8)
	sightexports.sGui:setGuiPosition(adminInputRect, false, panelHeight - adminInputSize)
	sightexports.sGui:setGuiSize(adminInputRect, false, adminInputSize)
  end
  addEventHandler("onActiveInputChange", getRootElement(), function(el, was)
	if adminMessageInput and (adminMessageInput == el or adminMessageInput == was) then
	  checkAdminInput(el)
	  processReportAdminMessages()
	end
  end)
  addEvent("useAdminActionButton", false)
  addEventHandler("useAdminActionButton", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	local report = false
	if type(currentMenu) == "table" and currentMenu[1] == "my" and myReports[currentMenu[2]] then
	  report = myReports[currentMenu[2]].id
	elseif type(currentMenu) == "table" and currentMenu[1] == "open" and reportData[currentMenu[2]] then
	  report = reportData[currentMenu[2]].id
	end
	if report then
	  local text = sightexports.sGui:getButtonText(el)
	  for i = 1, #actionButtons do
		if actionButtons[i][1] == text then
		  triggerServerEvent("useAdminActionButton", localPlayer, report, i)
		  break
		end
	  end
	end
  end)
  function deleteClosePrompt()
	if promptWindow then
	  sightexports.sGui:deleteGuiElement(promptWindow)
	end
	promptWindow = false
  end
  addEvent("deleteClosePrompt", false)
  addEventHandler("deleteClosePrompt", getRootElement(), deleteClosePrompt)
  function createClosePrompt()
	if type(currentMenu) == "table" and currentMenu[1] == "my" and myReports[currentMenu[2]] and not promptWindow then
	  local windowHeight = 130
	  local windowWidth = 400
	  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	  promptWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
	  sightexports.sGui:setWindowTitle(promptWindow, "16/BebasNeueRegular.otf", "SightMTA - Reportok")
	  local label = sightexports.sGui:createGuiElement("label", 5, 15, windowWidth - 10, windowHeight - 30 - 5, promptWindow)
	  sightexports.sGui:setLabelAlignment(label, "center", "center")
	  sightexports.sGui:setLabelText(label, "Biztosan szeretnéd lezárni a '" .. myReports[currentMenu[2]].id .. "' számú reportot?")
	  local btn = sightexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, promptWindow)
	  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	  sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	  }, false, true)
	  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	  sightexports.sGui:setButtonText(btn, "Igen")
	  sightexports.sGui:disableClickTrough(btn, true)
	  sightexports.sGui:setClickEvent(btn, "closeAdminReport", true)
	  local btn = sightexports.sGui:createGuiElement("button", 5 + (windowWidth - 15) / 2 + 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, promptWindow)
	  sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
	  sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightred",
		"sightred-second"
	  }, false, true)
	  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	  sightexports.sGui:setButtonText(btn, "Nem")
	  sightexports.sGui:disableClickTrough(btn, true)
	  sightexports.sGui:setClickEvent(btn, "deleteClosePrompt", false)
	end
  end
  addEvent("createClosePrompt", false)
  addEventHandler("createClosePrompt", getRootElement(), createClosePrompt)
  addEvent("closeAdminReportGui", false)
  addEventHandler("closeAdminReportGui", getRootElement(), function()
	deleteAdminGui()
	if reportTemplateEditor then
	  sightexports.sGui:deleteGuiElement(reportTemplateEditor)
	end
	reportTemplateEditor = nil
	if reportTemplateWindow then
	  sightexports.sGui:deleteGuiElement(reportTemplateWindow)
	end
	reportTemplateWindow = nil
	if reportTemplateDeletePromptWindow then
	  sightexports.sGui:deleteGuiElement(reportTemplateDeletePromptWindow)
	end
	reportTemplateDeletePromptWindow = nil
  end)
  function setNewAdminMenu(new, force)
	local set = false
	if new ~= currentMenu then
	  set = true
	  if type(currentMenu) == "table" and type(new) == "table" then
		set = false
		for i = 1, math.max(#currentMenu, #new) do
		  if currentMenu[i] ~= new[i] then
			set = true
			break
		  end
		end
	  end
	end
	if set or force then
	  if type(new) == "table" then
		if new[1] == "my" and (not myReports[new[2]] or not myReports[new[2]].id) then
		  new = "open"
		end
		if new[1] == "open" and (not reportData[new[2]] or not reportData[new[2]].id) then
		  new = "open"
		end
	  end
	  currentMenu = new
	  if adminWindow then
		setAdminMenuSelected()
		createAdminSection()
	  end
	end
  end
  function refreshAdminMenuLabels()
	if adminWindow then
	  for i = 1, #adminMenus do
		if adminMenus[i][2] then
		  sightexports.sGui:setButtonText(adminMenus[i][2], adminMenus[i][1][3])
		end
	  end
	end
  end
  function setAdminMenuSelected()
	if adminWindow then
	  for i = 1, #adminMenus do
		local isCurrent = false
		if type(currentMenu) == "table" then
		  if type(adminMenus[i][3]) == "table" then
			isCurrent = true
			for j = 1, math.max(#currentMenu, #adminMenus[i][3]) do
			  if currentMenu[j] ~= adminMenus[i][3][j] then
				isCurrent = false
				break
			  end
			end
		  end
		else
		  isCurrent = adminMenus[i][3] == currentMenu
		end
		if isCurrent then
		  sightexports.sGui:setGuiHoverable(adminMenus[i][2], false)
		  sightexports.sGui:setGuiBackground(adminMenus[i][2], "solid", "sightgrey2")
		else
		  sightexports.sGui:setGuiHoverable(adminMenus[i][2], true)
		  sightexports.sGui:setGuiBackground(adminMenus[i][2], "solid", "sightgrey1")
		  sightexports.sGui:setGuiHover(adminMenus[i][2], "gradient", {"sightgrey1", "sightgrey2"}, true, true)
		end
	  end
	end
  end
  function createAdminMenu()
	if adminWindow then
	  local topH = 32
	  if adminMenu then
		sightexports.sGui:deleteGuiElement(adminMenu)
	  end
	  adminMenu = sightexports.sGui:createGuiElement("rectangle", 0, titleBarHeight - 2, panelWidth, topH + 4 + 2, adminWindow)
	  sightexports.sGui:setGuiBackground(adminMenu, "solid", "sightgrey1")
	  local x, y = 8, titleBarHeight + 4
	  for i = 1, #adminMenus do
		local btnW = math.ceil(sightexports.sGui:getTextWidthFont(adminMenus[i][1][3], "13/BebasNeueRegular.otf", 1, true) + 20 + topH)
		local btn = sightexports.sGui:createGuiElement("button", x, y - (titleBarHeight - 2), btnW, topH, adminMenu)
		sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename(adminMenus[i][1][1], topH, adminMenus[i][1][2]))
		sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
		sightexports.sGui:setButtonTextColor(btn, adminMenus[i][3] == currentMenu and "#ffffff" or "#a0a0a0")
		sightexports.sGui:setButtonText(btn, adminMenus[i][1][3])
		sightexports.sGui:setClickEvent(btn, "selectAdminReportMenu")
		adminMenus[i][2] = btn
		x = x + btnW
	  end
	end
	setAdminMenuSelected()
  end
  function saveReportTemplates()
	local path = "!reportTemplates_sight.see"
	if fileExists(path) then
	  fileDelete(path)
	end
	local file = fileCreate(path)
	for i = 1, #reportTemplates do
	  fileWrite(file, reportTemplates[i][1] .. "\n")
	  fileWrite(file, reportTemplates[i][2] .. "\n")
	end
	fileClose(file)
  end
  function loadReportTemplates()
	reportTemplates = {}
	local path = "!reportTemplates_sight.see"
	if fileExists(path) then
	  local file = fileOpen(path)
	  local content = fileRead(file, fileGetSize(file))
	  fileClose(file)
	  local lines = split(content, "\n")
	  for i = 1, #lines, 2 do
		if lines[i + 1] then
		  table.insert(reportTemplates, {
			lines[i],
			lines[i + 1]
		  })
		end
	  end
	end
  end
  addEvent("reportTemplateSort", false)
  addEventHandler("reportTemplateSort", getRootElement(), function(button, state, absoluteX, absoluteY, el, dat)
	local i = dat[1]
	local dir = dat[2]
	local j = i + reportTemplateScroll
	if reportTemplates[j] then
	  if dir == "dn" then
		if reportTemplates[j + 1] then
		  reportTemplates[j], reportTemplates[j + 1] = reportTemplates[j + 1], reportTemplates[j]
		end
	  elseif reportTemplates[j - 1] then
		reportTemplates[j], reportTemplates[j - 1] = reportTemplates[j - 1], reportTemplates[j]
	  end
	  saveReportTemplates()
	  reportTemplateScrollHandler()
	end
  end)
  addEvent("reportTemplateDelete", false)
  addEventHandler("reportTemplateDelete", getRootElement(), function(button, state, absoluteX, absoluteY, el, i)
	if i then
	  local j = i + reportTemplateScroll
	  if reportTemplates[j] then
		table.remove(reportTemplates, j)
		saveReportTemplates()
		openReportTemplates()
	  end
	else
	  if reportTemplateDeletePromptWindow then
		sightexports.sGui:deleteGuiElement(reportTemplateDeletePromptWindow)
	  end
	  reportTemplateDeletePromptWindow = nil
	end
  end)
  local replaceVariables = {
	{
	  "player",
	  "Játékos neve"
	},
	{"adminnick", "Admin nick"},
	{"adminrank", "Admin rang"},
	{"reportid", "Report ID"},
	{"ucp", "UCP"},
	{"forum", "Fórum"},
	{"fb", "FB Oldal"},
	{
	  "email",
	  "Support email"
	},
	{
	  "fa",
	  "FA/SA Topic"
	},
	{
	  "dc",
	  "Discord invite"
	},
	{
	  "ingatlan",
	  "Ingatlan igénylés"
	},
	{"ts", "TS3 IP"},
	{
	  "rules",
	  "Szabályzat"
	},
	{
	  "pk",
	  "Panaszkönyv"
	},
	{
	  "pp",
	  "Prémium Shop"
	},
	{
	  "help",
	  "Tutorial Videók"
	}
  }
  local templateDatas = {
	player = "Játékos név",
	adminnick = "Admin nick",
	adminrank = "Admin rang",
	reportid = "Report ID",
	ucp = "https://ucp.sightmta.com/sight/ ",
	dc = "https://discord.gg/sightmta",
	rules = "https://rules.sightmta.com/sight/",
	pp = "https://premium.sightmta.com/server/sight/",
	help = "https://help.sightmta.com/",
	fb = "https://www.facebook.com/sightmta/",
	fa = "https://forum.sightmta.com/categories/foadmin-szuperadmin-segitsegkeres-sight.33/",
	ingatlan = "https://forum.sightmta.com/categories/ingatlan-igenylesek.361/",
	forum = "https://forum.sightmta.com/#SightMTA-sight.5/",
	ts = "ts.sightmta.com",
	pk = "https://forum.sightmta.com/categories/panaszkoenyv-sight.21/",
	email = "support@sightmta.com"
  }
  function processPerPlayerTemplates()
	if type(currentMenu) == "table" and currentMenu[1] == "my" and myReports[currentMenu[2]] then
	  templateDatas.reportid = myReports[currentMenu[2]].id
	  templateDatas.player = getElementData(myReports[currentMenu[2]].player, "visibleName"):gsub("_", " ")
	else
	  templateDatas.reportid = "Report ID"
	  templateDatas.player = "Játékos Név"
	end
	templateDatas.adminnick = getElementData(localPlayer, "acc.adminNick")
	templateDatas.adminrank = sightexports.sAdministration:getPlayerAdminTitle(localPlayer, true)
  end
  addEvent("reportTemplateSave", false)
  addEventHandler("reportTemplateSave", getRootElement(), function(button, state, absoluteX, absoluteY, el, template)
	if reportTemplates[template] then
	  local title = sightexports.sGui:getInputValue(templateTitleInput)
	  local message = sightexports.sGui:getInputValue(templateMessageInput)
	  reportTemplates[template][1] = title
	  reportTemplates[template][2] = message
	  saveReportTemplates()
	  openReportTemplates()
	end
  end)
  function createReportTemplateEditor(template)
	if reportTemplateEditor then
	  sightexports.sGui:deleteGuiElement(reportTemplateEditor)
	end
	reportTemplateEditor = nil
	if reportTemplateWindow then
	  sightexports.sGui:deleteGuiElement(reportTemplateWindow)
	end
	reportTemplateWindow = nil
	if reportTemplateDeletePromptWindow then
	  sightexports.sGui:deleteGuiElement(reportTemplateDeletePromptWindow)
	end
	reportTemplateDeletePromptWindow = nil
	local windowWidth = 450
	local windowHeight = 400
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	reportTemplateEditor = sightexports.sGui:createGuiElement("window", (screenX - windowWidth) / 2, (screenY - windowHeight) / 2, windowWidth, windowHeight)
	sightexports.sGui:setWindowTitle(reportTemplateEditor, "16/BebasNeueRegular.otf", "Válasz szerkesztése")
	sightexports.sGui:setWindowCloseButton(reportTemplateEditor, "openReportTemplates")
	local y = titleBarHeight + 8
	local input = sightexports.sGui:createGuiElement("input", 8, y, windowWidth - 16, 30, reportTemplateEditor)
	sightexports.sGui:setInputMaxLength(input, 32)
	sightexports.sGui:setInputValue(input, reportTemplates[template][1])
	sightexports.sGui:setInputPlaceholder(input, "Cím")
	sightexports.sGui:setInputFont(input, "10/Ubuntu-R.ttf")
	templateTitleInput = input
	y = y + 30 + 8
	local inputSize = windowHeight - 8 - y - 8 - 30 - math.ceil(#replaceVariables / 2) * 16
	local input = sightexports.sGui:createGuiElement("input", 8, y, windowWidth - 16, inputSize - 8, reportTemplateEditor)
	sightexports.sGui:setInputFont(input, "10/Ubuntu-R.ttf")
	sightexports.sGui:setInputPlaceholder(input, "Válasz szövege")
	sightexports.sGui:setInputMaxLength(input, 255)
	sightexports.sGui:setInputMultiline(input, true)
	sightexports.sGui:setInputFontPaddingHeight(input, 32)
	sightexports.sGui:setInputValue(input, reportTemplates[template][2])
	local w = (windowWidth - 16) / 2
	for i = 1, #replaceVariables do
	  local label = sightexports.sGui:createGuiElement("label", 8 + i % 2 * w, y + inputSize + 16 * (math.ceil(i / 2) - 1), w, 16, reportTemplateEditor)
	  sightexports.sGui:setLabelText(label, "[" .. replaceVariables[i][1] .. "]: " .. replaceVariables[i][2])
	  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
	end
	local btn = sightexports.sGui:createGuiElement("button", 8, windowHeight - 30 - 8, windowWidth - 16, 30, reportTemplateEditor)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(btn, "gradient", {
	  "sightgreen",
	  "sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "11/BebasNeueRegular.otf")
	sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("save", 24))
	sightexports.sGui:setButtonText(btn, " Mentés")
	sightexports.sGui:setClickEvent(btn, "reportTemplateSave")
	sightexports.sGui:setClickArgument(btn, template)
	templateMessageInput = input
  end
  addEvent("reportTemplateEdit", false)
  addEventHandler("reportTemplateEdit", getRootElement(), function(button, state, absoluteX, absoluteY, el, i)
	local j = i + reportTemplateScroll
	if reportTemplates[j] then
	  createReportTemplateEditor(j)
	end
  end)
  function reportTemplateScrollHandler()
	local max = math.max(0, #reportTemplates - 10)
	if max < reportTemplateScroll then
	  reportTemplateScroll = max
	end
	local n = math.min(10, #reportTemplates)
	for i = 1, n do
	  local j = i + reportTemplateScroll
	  sightexports.sGui:setButtonText(reportTemplatesElements[i][3], reportTemplates[j][1])
	  sightexports.sGui:guiSetTooltip(reportTemplatesElements[i][3], reportTemplates[j][3])
	  sightexports.sGui:setGuiRenderDisabled(reportTemplatesElements[i][1], j == 1)
	  sightexports.sGui:setGuiRenderDisabled(reportTemplatesElements[i][2], j == #reportTemplates)
	end
	local sh = (40 * n - 8) / math.max(1, #reportTemplates - 10 + 1)
	sightexports.sGui:setGuiPosition(reportTemplateScrollElement, false, sh * reportTemplateScroll)
	sightexports.sGui:setGuiSize(reportTemplateScrollElement, false, sh)
  end
  addEvent("createReportTemplate", false)
  addEventHandler("createReportTemplate", getRootElement(), function()
	table.insert(reportTemplates, {
	  "Új válasz",
	  "Új válasz"
	})
	saveReportTemplates()
	openReportTemplates()
  end)
  addEvent("closeReportTemplates", false)
  addEventHandler("closeReportTemplates", getRootElement(), function()
	if reportTemplateEditor then
	  sightexports.sGui:deleteGuiElement(reportTemplateEditor)
	end
	reportTemplateEditor = nil
	if reportTemplateWindow then
	  sightexports.sGui:deleteGuiElement(reportTemplateWindow)
	end
	reportTemplateWindow = nil
	if reportTemplateDeletePromptWindow then
	  sightexports.sGui:deleteGuiElement(reportTemplateDeletePromptWindow)
	end
	reportTemplateDeletePromptWindow = nil
  end)
  addEvent("reportTemplateDeletePrompt", false)
  addEventHandler("reportTemplateDeletePrompt", getRootElement(), function(button, state, absoluteX, absoluteY, el, i)
	if reportTemplateDeletePromptWindow then
	  sightexports.sGui:deleteGuiElement(reportTemplateDeletePromptWindow)
	end
	reportTemplateDeletePromptWindow = nil
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local pw = 375
	local ph = titleBarHeight + 120
	reportTemplateDeletePromptWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
	sightexports.sGui:setWindowColors(reportTemplateDeletePromptWindow, "sightgrey2", "sightgrey1", "sightgrey3", "#ffffff")
	sightexports.sGui:setWindowTitle(reportTemplateDeletePromptWindow, "16/BebasNeueRegular.otf", "Sablon törlése")
	local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - 8 - 32 - 8 - titleBarHeight, reportTemplateDeletePromptWindow)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "Biztosan szeretnéd törölni a sablont?\n\n[color=sightred]Ez a művelet nem visszavonható.")
	sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	local w = (pw - 24) / 2
	local btn = sightexports.sGui:createGuiElement("button", 8, ph - 8 - 32, w, 32, reportTemplateDeletePromptWindow)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(btn, "gradient", {
	  "sightgreen",
	  "sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(btn, "Igen")
	sightexports.sGui:setClickEvent(btn, "reportTemplateDelete")
	sightexports.sGui:setClickArgument(btn, i)
	local btn = sightexports.sGui:createGuiElement("button", pw - w - 8, ph - 8 - 32, w, 32, reportTemplateDeletePromptWindow)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
	sightexports.sGui:setGuiHover(btn, "gradient", {
	  "sightred",
	  "sightred-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(btn, "Nem")
	sightexports.sGui:setClickEvent(btn, "reportTemplateDelete")
  end)
  addEvent("sendReportTemplate", false)
  addEventHandler("sendReportTemplate", getRootElement(), function(button, state, absoluteX, absoluteY, el, i)
	local j = i + reportTemplateScroll
	if reportTemplates[j] and adminMessageInput then
	  sightexports.sGui:setInputValue(adminMessageInput, reportTemplates[j][4])
	  myReportInput[myReports[currentMenu[2]].id] = reportTemplates[j][4]
	  if reportTemplateEditor then
		sightexports.sGui:deleteGuiElement(reportTemplateEditor)
	  end
	  reportTemplateEditor = nil
	  if reportTemplateWindow then
		sightexports.sGui:deleteGuiElement(reportTemplateWindow)
	  end
	  reportTemplateWindow = nil
	  if reportTemplateDeletePromptWindow then
		sightexports.sGui:deleteGuiElement(reportTemplateDeletePromptWindow)
	  end
	  reportTemplateDeletePromptWindow = nil
	  sightexports.sGui:setActiveInput(adminMessageInput)
	  sightexports.sGui:moveInputCursorBack(adminMessageInput)
	end
  end)
  function openReportTemplates()
	if reportTemplateEditor then
	  sightexports.sGui:deleteGuiElement(reportTemplateEditor)
	end
	reportTemplateEditor = nil
	if reportTemplateWindow then
	  sightexports.sGui:deleteGuiElement(reportTemplateWindow)
	end
	reportTemplateWindow = nil
	if reportTemplateDeletePromptWindow then
	  sightexports.sGui:deleteGuiElement(reportTemplateDeletePromptWindow)
	end
	reportTemplateDeletePromptWindow = nil
	loadReportTemplates()
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local windowWidth = 350
	local n = math.min(10, #reportTemplates)
	local windowHeight = titleBarHeight + 8 + 40 * (n + 1)
	reportTemplateWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
	sightexports.sGui:setWindowTitle(reportTemplateWindow, "16/BebasNeueRegular.otf", "Sablon válaszok")
	sightexports.sGui:setWindowCloseButton(reportTemplateWindow, "closeReportTemplates")
	for i = 1, n do
	  reportTemplatesElements[i] = {}
	  local y = titleBarHeight + 8 + (i - 1) * 40
	  local btn = sightexports.sGui:createGuiElement("button", 8, y, 16, 16, reportTemplateWindow)
	  sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
	  sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey3", "sightgrey4"}, false, true)
	  sightexports.sGui:setButtonFont(btn, "11/BebasNeueRegular.otf")
	  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	  sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("angle-up", 16))
	  sightexports.sGui:setClickEvent(btn, "reportTemplateSort")
	  sightexports.sGui:setClickArgument(btn, {i, "up"})
	  reportTemplatesElements[i][1] = btn
	  local btn = sightexports.sGui:createGuiElement("button", 8, y + 16, 16, 16, reportTemplateWindow)
	  sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
	  sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey3", "sightgrey4"}, false, true)
	  sightexports.sGui:setButtonFont(btn, "11/BebasNeueRegular.otf")
	  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	  sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("angle-down", 16))
	  sightexports.sGui:setClickEvent(btn, "reportTemplateSort")
	  sightexports.sGui:setClickArgument(btn, {i, "dn"})
	  reportTemplatesElements[i][2] = btn
	  local btn = sightexports.sGui:createGuiElement("button", 32, y, windowWidth - 128, 32, reportTemplateWindow)
	  sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
	  sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightblue",
		"sightblue-second"
	  }, false, true)
	  sightexports.sGui:setButtonFont(btn, "11/BebasNeueRegular.otf")
	  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	  sightexports.sGui:setClickEvent(btn, "sendReportTemplate")
	  sightexports.sGui:setClickArgument(btn, i)
	  reportTemplatesElements[i][3] = btn
	  local btn = sightexports.sGui:createGuiElement("button", windowWidth - 8 - 80, y, 32, 32, reportTemplateWindow)
	  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	  sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	  }, false, true)
	  sightexports.sGui:setButtonFont(btn, "11/BebasNeueRegular.otf")
	  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	  sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("pencil", 32))
	  sightexports.sGui:setClickArgument(btn, i)
	  sightexports.sGui:setClickEvent(btn, "reportTemplateEdit")
	  local btn = sightexports.sGui:createGuiElement("button", windowWidth - 8 - 40, y, 32, 32, reportTemplateWindow)
	  sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
	  sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightred",
		"sightred-second"
	  }, false, true)
	  sightexports.sGui:setButtonFont(btn, "11/BebasNeueRegular.otf")
	  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	  sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("trash-alt", 32))
	  sightexports.sGui:setClickArgument(btn, i)
	  sightexports.sGui:setClickEvent(btn, "reportTemplateDeletePrompt")
	end
	local rect = sightexports.sGui:createGuiElement("rectangle", windowWidth - 8 - 2, titleBarHeight + 8, 2, 40 * n - 8, reportTemplateWindow)
	sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
	reportTemplateScrollElement = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, 40 * n - 8, rect)
	sightexports.sGui:setGuiBackground(reportTemplateScrollElement, "solid", "sightmidgrey")
	local btn = sightexports.sGui:createGuiElement("button", 8, windowHeight - 32 - 8, windowWidth - 16, 32, reportTemplateWindow)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(btn, "gradient", {
	  "sightgreen",
	  "sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
	sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	sightexports.sGui:setButtonText(btn, " Létrehozás")
	sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("plus", 32))
	sightexports.sGui:setClickEvent(btn, "createReportTemplate")
	processReportTemplates()
	reportTemplateScrollHandler()
  end
  addEvent("openReportTemplates", false)
  addEventHandler("openReportTemplates", getRootElement(), openReportTemplates)
  function processReportTemplates()
	processPerPlayerTemplates()
	for i = 1, #reportTemplates do
	  local tmp = reportTemplates[i][2]
	  for j = 1, #replaceVariables do
		tmp = utf8.gsub(tmp, "%[" .. replaceVariables[j][1] .. "%]", templateDatas[replaceVariables[j][1]])
	  end
	  reportTemplates[i][4] = tmp
	  local text = split(tmp, " ")
	  local lines = {}
	  local tmp = ""
	  for i = 1, #text do
		tmp = tmp .. text[i]
		if utf8.len(tmp) > 48 then
		  table.insert(lines, tmp)
		  tmp = ""
		else
		  tmp = tmp .. " "
		end
	  end
	  if utf8.len(tmp) > 0 then
		table.insert(lines, tmp)
	  end
	  reportTemplates[i][3] = table.concat(lines, "\n")
	end
  end
  addEvent("adminMessageInputChange", false)
  addEventHandler("adminMessageInputChange", getRootElement(), function(val)
	local tmp = val
	for j = 1, #replaceVariables do
	  tmp = utf8.gsub(tmp, "%[" .. replaceVariables[j][1] .. "%]", templateDatas[replaceVariables[j][1]])
	end
	if tmp ~= val then
	  sightexports.sGui:setInputValue(adminMessageInput, tmp)
	  sightexports.sGui:moveInputCursorBack(adminMessageInput)
	end
	myReportInput[myReports[currentMenu[2]].id] = tmp
  end)
  function createAdminSection()
	if adminWindow then
	  if writing then
		sightexports.sGui:deleteGuiElement(writing)
	  end
	  writing = nil
	  scrollbar = false
	  sbBack = false
	  adminInputSize = 0
	  adminInputRect = false
	  local resetActive = false
	  if adminMessageInput and sightexports.sGui:getActiveInput() == adminMessageInput then
		resetActive = true
	  end
	  adminMessageInput = false
	  messages = {}
	  sightlangCondHandl0(true)
	  if adminSection then
		sightexports.sGui:deleteGuiElement(adminSection)
	  end
	  adminSection = nil
	  local x, y = 8, titleBarHeight + 4
	  local topH = 32
	  adminSection = sightexports.sGui:createGuiElement("null", 0, 0, panelWidth, panelHeight, adminWindow)
	  if type(currentMenu) == "table" and currentMenu[1] == "my" and myReports[currentMenu[2]] then
		local w = panelWidth / 3
		y = y + topH
		adminInputSize = 40
		adminInputRect = sightexports.sGui:createGuiElement("rectangle", 0, panelHeight - adminInputSize, w * 2, adminInputSize, adminSection)
		sightexports.sGui:setGuiBackground(adminInputRect, "solid", "sightgrey1")
		if myReportMessagesLoaded[myReports[currentMenu[2]].id] then
		  adminMessageInput = sightexports.sGui:createGuiElement("input", 4, panelHeight - (adminInputSize - 8) - 4, w * 2 - 8 - 32 - 4 - 32, adminInputSize - 8, adminSection)
		  sightexports.sGui:setInputFont(adminMessageInput, "10/Ubuntu-R.ttf")
		  sightexports.sGui:setInputPlaceholder(adminMessageInput, "Üzenet")
		  sightexports.sGui:setInputMaxLength(adminMessageInput, 255)
		  sightexports.sGui:setInputMultiline(adminMessageInput, true)
		  sightexports.sGui:setInputFontPaddingHeight(adminMessageInput, 32)
		  if myReportInput[myReports[currentMenu[2]].id] then
			sightexports.sGui:setInputValue(adminMessageInput, myReportInput[myReports[currentMenu[2]].id])
		  end
		  sightexports.sGui:setInputChangeEvent(adminMessageInput, "adminMessageInputChange")
		end
		local icon = sightexports.sGui:createGuiElement("image", w * 2 - 32 - 4 - 32, panelHeight - 32 - 4, 32, 32, adminSection)
		sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("comments", 32))
		sightexports.sGui:setGuiHoverable(icon, true)
		sightexports.sGui:setGuiHover(icon, "solid", "sightblue", false, true)
		sightexports.sGui:setClickEvent(icon, "openReportTemplates")
		local tmp = {}
		for i = 1, #replaceVariables, 2 do
		  if replaceVariables[i + 1] then
			table.insert(tmp, "[" .. replaceVariables[i][1] .. "]: " .. replaceVariables[i][2] .. ", " .. "[" .. replaceVariables[i + 1][1] .. "]: " .. replaceVariables[i + 1][2])
		  else
			table.insert(tmp, "[" .. replaceVariables[i][1] .. "]: " .. replaceVariables[i][2])
		  end
		end
		sightexports.sGui:guiSetTooltip(icon, table.concat(tmp, "\n"))
		local icon2 = sightexports.sGui:createGuiElement("image", w * 2 - 32 - 4, panelHeight - 32 - 4, 32, 32, adminSection)
		sightexports.sGui:setImageFile(icon2, sightexports.sGui:getFaIconFilename("paper-plane", 32))
		sightexports.sGui:setGuiHoverable(icon2, true)
		sightexports.sGui:setGuiHover(icon2, "solid", "sightgreen", false, true)
		sightexports.sGui:setClickEvent(icon2, "sendAdminReportMessage", true)
		if myReportMessagesLoaded[myReports[currentMenu[2]].id] then
		  local time = getRealTime(myReports[currentMenu[2]].created)
		  local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
		  createAdminMessage(date, myReports[currentMenu[2]].description, false, false)
		  local msg = myReportMessages[myReports[currentMenu[2]].id]
		  if msg then
			for i = 1, #msg do
			  local time = getRealTime(msg[i].date)
			  local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
			  if msg[i].sender == 0 then
				createAdminSystemMessageEx({
				  date,
				  msg[i].message
				}, msg[i].id)
			  elseif msg[i].sender == myReports[currentMenu[2]].sentBy then
				createAdminMessage(date, msg[i].message, false, msg[i].id)
			  else
				createAdminMessage(date, msg[i].message, true, msg[i].id, math.max(msg[i].date, msg[i].seen), 0 < msg[i].seen)
			  end
			  if 0 >= msg[i].seen and msg[i].sender == myReports[currentMenu[2]].sentBy then
				table.insert(unreadAdminMessages, {
				  msg[i].reportId,
				  msg[i].id
				})
			  end
			end
		  end
		end
		local rect = sightexports.sGui:createGuiElement("rectangle", w * 2, y, w, panelHeight - y, adminSection)
		sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey4")
		local border = sightexports.sGui:createGuiElement("hr", w * 2 - 1, y, 2, panelHeight - y, adminSection)
		x = w * 2 - 8
		y = titleBarHeight + topH + 4 + 8
		local sy = panelHeight - titleBarHeight - topH - 4 - 16 - adminInputSize
		sbBack = sightexports.sGui:createGuiElement("rectangle", x, y, 2, sy, adminSection)
		sightexports.sGui:setGuiBackground(sbBack, "solid", "sightgrey3")
		scrollbar = sightexports.sGui:createGuiElement("rectangle", x, y, 2, sy, adminSection)
		sightexports.sGui:setGuiBackground(scrollbar, "solid", "sightmidgrey")
		if myReportMessagesLoaded[myReports[currentMenu[2]].id] then
		  if myReportWriting[myReports[currentMenu[2]].id] then
			writing = sightexports.sGui:createGuiElement("label", 0, 0, panelWidth / 3 * 2, 24, adminWindow)
			sightexports.sGui:setLabelFont(writing, "10/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(writing, myReportWriting[myReports[currentMenu[2]].id] .. " éppen ír...")
			sightexports.sGui:setLabelClip(writing, true)
			sightexports.sGui:setLabelColor(writing, "#a0a0a0")
			sightexports.sGui:setLabelAlignment(writing, "center", "center")
		  end
		  processReportAdminUnread()
		  if resetActive then
			sightexports.sGui:setActiveInput(adminMessageInput)
			adminMessageInput(adminMessageInput)
		  end
		  processReportAdminMessages()
		else
		  local rect = sightexports.sGui:createGuiElement("rectangle", 0, titleBarHeight + 4 + topH, w * 2, panelHeight - (titleBarHeight + 4 + topH), adminSection)
		  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
		  local loaderIcon = sightexports.sGui:createGuiElement("image", w - 24, (panelHeight - (titleBarHeight + 4 + topH)) / 2 - 24, 48, 48, rect)
		  sightexports.sGui:setImageFile(loaderIcon, sightexports.sGui:getFaIconFilename("circle-notch", 48))
		  sightexports.sGui:setImageSpinner(loaderIcon, true)
		end
		x = w * 2 + 8
		y = titleBarHeight + topH + 4
		local player = myReports[currentMenu[2]].player
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 32, adminSection)
		sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
		sightexports.sGui:setLabelText(label, (getElementData(player, "visibleName") or "N/A"):gsub("_", " ") .. " (" .. getElementData(player, "playerID") .. ")")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		y = y + 32
		x = w * 2 + 8
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "13/BebasNeueBold.otf")
		sightexports.sGui:setLabelText(label, "Szint: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		x = x + sightexports.sGui:getLabelTextWidth(label)
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
		sightexports.sGui:setLabelText(label, getElementData(player, "char.level"))
		sightexports.sGui:setLabelColor(label, "sightgreen")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		x = x + sightexports.sGui:getLabelTextWidth(label)
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "13/BebasNeueBold.otf")
		sightexports.sGui:setLabelText(label, "   Skin: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		x = x + sightexports.sGui:getLabelTextWidth(label)
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
		sightexports.sGui:setLabelText(label, getElementModel(player))
		sightexports.sGui:setLabelColor(label, "sightblue")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		x = x + sightexports.sGui:getLabelTextWidth(label)
		x = w * 2 + 8
		y = y + 24
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "13/BebasNeueBold.otf")
		sightexports.sGui:setLabelText(label, "Account ID: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		x = x + sightexports.sGui:getLabelTextWidth(label)
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
		sightexports.sGui:setLabelText(label, getElementData(player, "char.accID"))
		sightexports.sGui:setLabelColor(label, "sightgreen")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		x = x + sightexports.sGui:getLabelTextWidth(label)
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "13/BebasNeueBold.otf")
		sightexports.sGui:setLabelText(label, "   Karakter ID: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		x = x + sightexports.sGui:getLabelTextWidth(label)
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
		sightexports.sGui:setLabelText(label, getElementData(player, "char.ID"))
		sightexports.sGui:setLabelColor(label, "sightgreen")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		x = x + sightexports.sGui:getLabelTextWidth(label)
		x = w * 2
		y = y + 24 + 8
		local btnW = (w - 8) / 4
		x = x + 4
		for i = 1, #actionButtons do
		  if i == 5 then
			y = y + 20 + 8
			x = w * 2 + 4
		  end
		  local btn = sightexports.sGui:createGuiElement("button", x + 4, y, btnW - 8, 20, adminSection)
		  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
		  sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightgreen",
			"sightgreen-second"
		  }, false, true)
		  sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
		  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		  sightexports.sGui:setButtonText(btn, actionButtons[i][1])
		  sightexports.sGui:setClickEvent(btn, "useAdminActionButton")
		  x = x + btnW
		end
		y = y + 4
		local btn = sightexports.sGui:createGuiElement("button", 2 * w + 8, y + 20 + 4, w - 16, 20, adminSection)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
		sightexports.sGui:setGuiHover(btn, "gradient", {
		  "sightblue",
		  "sightblue-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, " UCP Megnyitása")
		sightexports.sGui:setClickEvent(btn, "openUCP")
		sightexports.sGui:setClickArgument(btn, getElementData(player, "acc.ID") or 0)
		sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("globe", 24, "solid"))
		y = y + 20 + 4
		x = 2 * w + 8
		y = y + 20 + 8
		local bh = panelHeight - y - 8 - 64
		local bb = y + bh
		local rect = sightexports.sGui:createGuiElement("rectangle", x, y, w - 16, bh, adminSection)
		sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
		x = x + 4
		y = y + 4
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Kategória: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "top")
		y = y + sightexports.sGui:getLabelFontHeight(label)
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, myReports[currentMenu[2]].category)
		sightexports.sGui:setLabelColor(label, "#cccccc")
		sightexports.sGui:setLabelAlignment(label, "left", "top")
		y = y + 24
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Bejelentés címe: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "top")
		y = y + sightexports.sGui:getLabelFontHeight(label)
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, myReports[currentMenu[2]].title)
		sightexports.sGui:setLabelColor(label, "#cccccc")
		sightexports.sGui:setLabelAlignment(label, "left", "top")
		y = y + 24
		local time = getRealTime(myReports[currentMenu[2]].created)
		local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Bejelentés időpontja: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "top")
		y = y + sightexports.sGui:getLabelFontHeight(label)
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, date)
		sightexports.sGui:setLabelColor(label, "#cccccc")
		sightexports.sGui:setLabelAlignment(label, "left", "top")
		y = y + 24
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 24, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Bejelentés leírása: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "top")
		y = y + sightexports.sGui:getLabelFontHeight(label)
		local dat = split(myReports[currentMenu[2]].description, " ")
		local text = dat[1]
		local showLast = true
		for i = 2, #dat do
		  local tw = sightexports.sGui:getTextWidthFont(text .. " " .. dat[i], "11/Ubuntu-R.ttf")
		  if tw > w - 24 then
			local label = sightexports.sGui:createGuiElement("label", x, y, w - 24, 24, adminSection)
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(label, text)
			sightexports.sGui:setLabelColor(label, "#cccccc")
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "left", "top")
			y = y + sightexports.sGui:getLabelFontHeight(label)
			if y >= bb - 8 then
			  showLast = false
			  sightexports.sGui:setLabelText(label, utf8.sub(text, 1, math.max(1, utf8.len(text) - 3)) .. "...")
			  break
			end
			text = dat[i]
		  else
			text = text .. " " .. dat[i]
		  end
		end
		if showLast then
		  local label = sightexports.sGui:createGuiElement("label", x, y, w - 24, 24, adminSection)
		  sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		  sightexports.sGui:setLabelText(label, text)
		  sightexports.sGui:setLabelColor(label, "#cccccc")
		  sightexports.sGui:setLabelClip(label, true)
		  sightexports.sGui:setLabelAlignment(label, "left", "top")
		  y = y + sightexports.sGui:getLabelFontHeight(label)
		end
		y = y + 24
		x = x - 4
		y = panelHeight - 24 - 8
		local btn = sightexports.sGui:createGuiElement("button", x, y, w - 16, 24, adminSection)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
		sightexports.sGui:setGuiHover(btn, "gradient", {
		  "sightred",
		  "sightred-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, "Ügy lezárása")
		sightexports.sGui:setClickEvent(btn, "createClosePrompt")
		sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("lock", 24, "solid"))
		y = y - 24 - 8
		local btn = sightexports.sGui:createGuiElement("button", x, y, w - 16, 24, adminSection)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
		sightexports.sGui:setGuiHover(btn, "gradient", {
		  "sightblue",
		  "sightblue-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, "Ügy leadása")
		sightexports.sGui:setClickEvent(btn, "cancelAdminReport")
		sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("undo", 24, "solid"))
	  elseif type(currentMenu) == "table" and currentMenu[1] == "open" and reportData[currentMenu[2]] then
		x = 20
		y = y + topH + 20
		local rect2 = sightexports.sGui:createGuiElement("rectangle", x - 6, y - 6, panelWidth - 40 + 12, 32, adminSection)
		sightexports.sGui:setGuiBackground(rect2, "solid", "sightgrey3")
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 26, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Kategória: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		local w = sightexports.sGui:getLabelTextWidth(label)
		local label = sightexports.sGui:createGuiElement("label", x + w, y, panelWidth - w - x, 26, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, reportData[currentMenu[2]].category)
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelClip(label, true)
		y = y + 26
		local time = getRealTime(reportData[currentMenu[2]].created)
		local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 26, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Bejelentés időpontja: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		local w = sightexports.sGui:getLabelTextWidth(label)
		local label = sightexports.sGui:createGuiElement("label", x + w, y, panelWidth - w - x, 26, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, date)
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelClip(label, true)
		y = y + 26
		local time = getRealTime(reportData[currentMenu[2]].lastEdit)
		local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 26, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Utolsó interakció időpontja: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		local w = sightexports.sGui:getLabelTextWidth(label)
		local label = sightexports.sGui:createGuiElement("label", x + w, y, panelWidth - w - x, 26, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, date)
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelClip(label, true)
		y = y + 26
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 26, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Bejelentő neve: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		local w = sightexports.sGui:getLabelTextWidth(label)
		local label = sightexports.sGui:createGuiElement("label", x + w, y, panelWidth - w - x, 26, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, reportData[currentMenu[2]].sentName:gsub("_", " "))
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelClip(label, true)
		y = y + 26
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 26, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Bejelentő karakter ID-je: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		local w = sightexports.sGui:getLabelTextWidth(label)
		local label = sightexports.sGui:createGuiElement("label", x + w, y, panelWidth - w - x, 26, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, reportData[currentMenu[2]].sentBy)
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelClip(label, true)
		y = y + 26
		local player = reportData[currentMenu[2]].player
		if isElement(player) then
		  local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 26, adminSection)
		  sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		  sightexports.sGui:setLabelText(label, "Bejelentő online ID-je: ")
		  sightexports.sGui:setLabelColor(label, "#ffffff")
		  sightexports.sGui:setLabelAlignment(label, "left", "center")
		  local w = sightexports.sGui:getLabelTextWidth(label)
		  local label = sightexports.sGui:createGuiElement("label", x + w, y, panelWidth - w - x, 26, adminSection)
		  sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		  sightexports.sGui:setLabelText(label, getElementData(player, "playerID"))
		  sightexports.sGui:setLabelColor(label, "#ffffff")
		  sightexports.sGui:setLabelAlignment(label, "left", "center")
		  sightexports.sGui:setLabelClip(label, true)
		  y = y + 26
		  local name = getElementData(player, "visibleName")
		  if name ~= reportData[currentMenu[2]].sentName then
			local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 26, adminSection)
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(label, "Bejelentő jelenlegi neve: ")
			sightexports.sGui:setLabelColor(label, "#ffffff")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			local w = sightexports.sGui:getLabelTextWidth(label)
			local label = sightexports.sGui:createGuiElement("label", x + w, y, panelWidth - w - x, 26, adminSection)
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(label, name:gsub("_", " "))
			sightexports.sGui:setLabelColor(label, "#ffffff")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelClip(label, true)
			y = y + 26
		  end
		  y = y + 6
		  local btn = sightexports.sGui:createGuiElement("button", x, y, 100, 20, adminSection)
		  sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
		  sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightblue",
			"sightblue-second"
		  }, false, true)
		  sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
		  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		  sightexports.sGui:setButtonText(btn, "spec")
		  sightexports.sGui:setClickEvent(btn, "useAdminActionButton")
		  x = x + 100 + 8
		  local btn = sightexports.sGui:createGuiElement("button", x, y, 100, 20, adminSection)
		  sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
		  sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightblue",
			"sightblue-second"
		  }, false, true)
		  sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
		  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		  sightexports.sGui:setButtonText(btn, "goto")
		  sightexports.sGui:setClickEvent(btn, "useAdminActionButton")
		  x = x + 100 + 8
		  local btn = sightexports.sGui:createGuiElement("button", x, y, 100, 20, adminSection)
		  sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
		  sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightblue",
			"sightblue-second"
		  }, false, true)
		  sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
		  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		  sightexports.sGui:setButtonText(btn, "gethere")
		  sightexports.sGui:setClickEvent(btn, "useAdminActionButton")
		  y = y + 20 + 6
		  x = 20
		end
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 26, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Bejelentés címe: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		local w = sightexports.sGui:getLabelTextWidth(label)
		local label = sightexports.sGui:createGuiElement("label", x + w, y, panelWidth - w - x, 26, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, reportData[currentMenu[2]].title)
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelClip(label, true)
		y = y + 26
		local label = sightexports.sGui:createGuiElement("label", x, y, panelWidth, 26, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Bejelentés leírása: ")
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		local w = sightexports.sGui:getLabelTextWidth(label)
		local dat = split(reportData[currentMenu[2]].description, " ")
		local text = dat[1]
		for i = 2, #dat do
		  local tw = w + sightexports.sGui:getTextWidthFont(text .. " " .. dat[i], "11/Ubuntu-R.ttf", 1, true)
		  if tw >= panelWidth - 40 then
			local label = sightexports.sGui:createGuiElement("label", x + w, y, panelWidth - w - x, 26, adminSection)
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(label, text)
			sightexports.sGui:setLabelColor(label, "#ffffff")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelClip(label, true)
			text = dat[i]
			w = 0
			y = y + sightexports.sGui:getLabelFontHeight(label)
		  else
			text = text .. " " .. dat[i]
		  end
		end
		local label = sightexports.sGui:createGuiElement("label", x + w, y, panelWidth - w - x, 26, adminSection)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, text)
		sightexports.sGui:setLabelColor(label, "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelClip(label, true)
		y = y + 26
		y = y + 6
		local btn = sightexports.sGui:createGuiElement("button", x, y, 200, 28, adminSection)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(btn, "gradient", {
		  "sightgreen",
		  "sightgreen-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, "Ügy elvállalása")
		sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("gavel", 28, "solid"))
		sightexports.sGui:setClickEvent(btn, "acceptAdminReport")
		y = y + 28 + 6
		sightexports.sGui:setGuiSize(rect2, false, y - topH - 20 - titleBarHeight + 8)
	  elseif currentMenu == "open" then
		x = 8
		y = y + topH + 8
		local categories = getReportCategories()
		selectedReportCategory = false
		reportCategoryButtons = {}
		for i = 1, #categories do
		  local btnW = math.ceil(sightexports.sGui:getTextWidthFont(categories[i], "11/BebasNeueRegular.otf", 1, true) + 16)
		  local btn = sightexports.sGui:createGuiElement("button", x, y, btnW, 24, adminSection)
		  if disabledCategories[categories[i]] then
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
			sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey3", "sightgrey2"}, true, true)
		  else
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(btn, "gradient", {
			  "sightgreen",
			  "sightgreen-second"
			}, true, true)
		  end
		  sightexports.sGui:setButtonFont(btn, "11/BebasNeueRegular.otf")
		  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		  sightexports.sGui:setButtonText(btn, categories[i])
		  sightexports.sGui:setClickEvent(btn, "selectAdminReportCategory")
		  reportCategoryButtons[btn] = categories[i]
		  x = x + btnW + 4
		end
		y = y + 24 + 8
		local ty = y
		local w = panelWidth - 16 - 10
		local tabW = {
		  0.09,
		  0.2,
		  0.4,
		  0.21,
		  0.1
		}
		local n = 11
		local h = math.floor((panelHeight - y - 8 - 24) / n) - 10
		x = 8
		for j = 1, #tabs do
		  local label = sightexports.sGui:createGuiElement("label", x, y, w * tabW[j] - 12, 19, adminSection)
		  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
		  sightexports.sGui:setLabelText(label, tabs[j])
		  sightexports.sGui:setLabelColor(label, "#ffffff")
		  sightexports.sGui:setLabelAlignment(label, "left", "center")
		  x = math.floor(x + w * tabW[j])
		end
		y = y + 24
		reportButtons = {}
		for i = 1, n do
		  x = 8
		  reportElements[i] = {}
		  local rect = sightexports.sGui:createGuiElement("rectangle", x, y, w, h, adminSection)
		  sightexports.sGui:setGuiHoverable(rect, true)
		  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
		  sightexports.sGui:setGuiHover(rect, "gradient", {"sightgrey4", "sightgrey3"}, false, true)
		  sightexports.sGui:setClickEvent(rect, "openAdminReport")
		  reportElements[i][1] = rect
		  for j = 1, #tabs do
			local label = sightexports.sGui:createGuiElement("label", x + 6, y, w * tabW[j] - 12, h, adminSection)
			sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
			sightexports.sGui:setLabelClip(label, j ~= 2 and j ~= #tabs)
			sightexports.sGui:setLabelColor(label, "#ffffff")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			reportElements[i][1 + j] = label
			x = math.floor(x + w * tabW[j])
			if j < #tabs then
			  local border = sightexports.sGui:createGuiElement("hr", x - 1, y + 6, 2, h - 12, adminSection)
			  reportElements[i][1 + #tabs + j] = border
			end
		  end
		  y = y + h + 10
		end
		x = panelWidth - 10
		y = titleBarHeight + topH + 8 + 24 + h
		local sy = panelHeight - titleBarHeight - topH - 4 - 16 - 24 - h - 4
		local rect = sightexports.sGui:createGuiElement("rectangle", x, y, 2, sy, adminSection)
		sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
		sh = sy / math.max(1, #reportList - n + 1)
		scrollbar = sightexports.sGui:createGuiElement("rectangle", x, y + sh * reportScroll, 2, sh, adminSection)
		sightexports.sGui:setGuiBackground(scrollbar, "solid", "sightmidgrey")
		refreshReports()
		x = 8
	  end
	end
  end
  function createAdminGui()
	copyMenu = false
	copyMenuId = false
	copyMenuTexts = {}
	titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local x, y = deleteAdminGui()
	panelWidth = 900
	panelHeight = 650
	adminWindow = sightexports.sGui:createGuiElement("window", x or screenX / 2 - panelWidth / 2, y or screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
	sightexports.sGui:setWindowTitle(adminWindow, "16/BebasNeueRegular.otf", "SightMTA - Reportok")
	sightexports.sGui:setWindowCloseButton(adminWindow, "closeAdminReportGui")
	local ih = titleBarHeight - 8
	if type(currentMenu) ~= "table" or currentMenu[1] ~= "my" or not myReports[currentMenu[2]] then
	  local icon = sightexports.sGui:createGuiElement("image", panelWidth - titleBarHeight - ih * 2, titleBarHeight / 2 - ih / 2, ih, ih, adminWindow)
	  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("comments", 32))
	  sightexports.sGui:setGuiHoverable(icon, true)
	  sightexports.sGui:setGuiHover(icon, "solid", "sightblue", false, true)
	  sightexports.sGui:setClickEvent(icon, "openReportTemplates")
	end
	bellIcon = sightexports.sGui:createGuiElement("image", panelWidth - titleBarHeight - ih, titleBarHeight / 2 - ih / 2, ih, ih, adminWindow)
	sightexports.sGui:setImageFile(bellIcon, sightexports.sGui:getFaIconFilename(soundState and "bell" or "bell-slash", ih))
	sightexports.sGui:setImageColor(bellIcon, soundState and "#ffffff" or "#a0a0a0")
	sightexports.sGui:setGuiHoverable(bellIcon, true)
	sightexports.sGui:setGuiHover(bellIcon, "solid", "sightgreen", false, true)
	sightexports.sGui:setClickEvent(bellIcon, "toggleAdminReportSound")
	createAdminMenu()
	setNewAdminMenu(currentMenu, true)
	if reportTemplateEditor then
	  sightexports.sGui:guiToFront(reportTemplateEditor)
	end
	if reportTemplateWindow then
	  sightexports.sGui:guiToFront(reportTemplateWindow)
	  processReportTemplates()
	  reportTemplateScrollHandler()
	else
	  processPerPlayerTemplates()
	end
	if reportTemplateDeletePromptWindow then
	  sightexports.sGui:guiToFront(reportTemplateDeletePromptWindow)
	end
  end
  addCommandHandler("reports", function()
	if sightexports.sPermission:hasPermission(localPlayer, "reports") then
	  if adminWindow then
		deleteAdminGui()
		if reportTemplateEditor then
		  sightexports.sGui:deleteGuiElement(reportTemplateEditor)
		end
		reportTemplateEditor = nil
		if reportTemplateWindow then
		  sightexports.sGui:deleteGuiElement(reportTemplateWindow)
		end
		reportTemplateWindow = nil
		if reportTemplateDeletePromptWindow then
		  sightexports.sGui:deleteGuiElement(reportTemplateDeletePromptWindow)
		end
		reportTemplateDeletePromptWindow = nil
	  else
		createAdminGui()
	  end
	end
  end)
  local reportWidgetState = false
  local reportWidgetPos = false
  local reportWidgetSize = false
  function dxDrawTextEx(t, x, y, x2, y2, c, s, f, a, a2)
	dxDrawText(t, x + 1, y + 1, x2 + 1, y2 + 1, tocolor(0, 0, 0, 225), s, f, a, a2)
	dxDrawText(t, x, y, x2, y2, c, s, f, a, a2)
  end
  function renderReportWidget()
	local x = math.floor(reportWidgetPos[1])
	local y = math.floor(reportWidgetPos[2])
	local h = math.ceil(reportFontBH)
	dxDrawTextEx("Reportok", x, y, x, y + h, fpsGreen, reportFontBS, reportFontB, "left", "center")
	y = y + h
	if reportData then
	  local h = math.ceil(reportFontBH * 0.9)
	  dxDrawTextEx("Nyitott ügyek: ", x, y, x, y + h, tocolor(255, 255, 255), reportFontBS * 0.9, reportFontB, "left", "center")
	  dxDrawTextEx(#reportData, x + dxGetTextWidth("Nyitott ügyek: ", reportFontBS * 0.9, reportFontB), y, x, y + h, tocolor(255, 255, 255), reportFontS * 0.9, reportFont, "left", "center")
	  y = y + h
	  dxDrawTextEx("Elvállat ügyek: ", x, y, x, y + h, tocolor(255, 255, 255), reportFontBS * 0.9, reportFontB, "left", "center")
	  y = y + h
	  for i = 1, #myReports do
		if myReports[i] then
		  if unreadCount[myReports[i].id] and unreadCount[myReports[i].id] > 0 then
			dxDrawTextEx("Report " .. myReports[i].id .. " - " .. unreadCount[myReports[i].id] .. " új üzenet", x, y, x, y + h, tocolor(255, 255, 255), reportFontS * 0.9, reportFont, "left", "center")
		  else
			dxDrawTextEx("Report " .. myReports[i].id, x, y, x, y + h, tocolor(255, 255, 255), reportFontS * 0.9, reportFont, "left", "center")
		  end
		  y = y + h
		end
	  end
	end
  end
  function refreshColors()
	reportFont = sightexports.sGui:getFont("12/Ubuntu-R.ttf")
	reportFontH = sightexports.sGui:getFontHeight("12/Ubuntu-R.ttf")
	reportFontS = sightexports.sGui:getFontScale("12/Ubuntu-R.ttf")
	reportFontB = sightexports.sGui:getFont("12/Ubuntu-R.ttf")
	reportFontBH = sightexports.sGui:getFontHeight("12/Ubuntu-R.ttf")
	reportFontBS = sightexports.sGui:getFontScale("12/Ubuntu-R.ttf")
	fpsGreen = sightexports.sGui:getColorCodeToColor("sightgreen")
  end
  addEvent("hudWidgetState:reports", true)
  addEventHandler("hudWidgetState:reports", getRootElement(), function(state)
	if reportWidgetState ~= state then
	  reportWidgetState = state
	  if reportWidgetState then
		addEventHandler("onClientRender", getRootElement(), renderReportWidget)
	  else
		removeEventHandler("onClientRender", getRootElement(), renderReportWidget)
	  end
	end
  end)
  addEvent("hudWidgetPosition:reports", true)
  addEventHandler("hudWidgetPosition:reports", getRootElement(), function(pos, final)
	reportWidgetPos = pos
  end)
  addEvent("hudWidgetSize:reports", true)
  addEventHandler("hudWidgetSize:reports", getRootElement(), function(size, final)
	reportWidgetSize = size
  end)
  addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	triggerEvent("requestWidgetDatas", localPlayer, "reports")
  end)
  