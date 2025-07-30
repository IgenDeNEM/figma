local sightexports = {sGui = false, sVehiclenames = false}
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
openedComputerApp = false
openedWebsite = false
computerWindow = false
local computerScan = false
local computerApp = false
local computerAppInside = false
local emailReplyButtons = {}
local emailAppFolderElemenets = {}
local emailAppRows = {}
local openedEmail = false
local emailCategoryCount = {}
local overallEmailCount = 0
local seletedEmailCategory = false
local emailList = {}
local emailListRaw = {}
local permissionButtons = {}
local fireButtons = {}
local foundPlayer = false
local orderElements = {}
local orderNum = {}
local overallOrderNum = 0
local overallOrderSum = 0
local orderOverallLabel = false
local scrollHandled = false
local emailScroll = 0
local nameW = 0
local dateW = 0
local emailScrollBar = false
local emailScrollBarY = 0
local emailScrollBarH = 0
dateLabel = false
currentDate = false
function frontComputerScan()
  sightexports.sGui:guiToFront(computerScan)
end
function setButtonScheme(btn)
  sightexports.sGui:setGuiHoverable(btn, true)
  sightexports.sGui:setGuiBackground(btn, "gradient", {
    computerColorScheme.btn1,
    computerColorScheme.btn2
  })
  sightexports.sGui:setGuiHover(btn, "gradient", {
    computerColorScheme.btn2,
    computerColorScheme.btn1
  }, false, true)
  sightexports.sGui:setButtonTextColor(btn, "#000000")
  sightexports.sGui:setGuiBackgroundBorder(btn, 1, "#000000")
end
local computerPrompt = false
local computerPromptInput = false
function closePaintshopComputerPrompt()
  if computerPrompt then
    sightexports.sGui:deleteGuiElement(computerPrompt)
  end
  computerPrompt = false
  computerPromptInput = false
end
addEvent("closePaintshopComputerPrompt", false)
addEventHandler("closePaintshopComputerPrompt", getRootElement(), function()
  playSound("files/click.mp3")
  closePaintshopComputerPrompt()
end)
function createPointPrompt(title, sx, sy)
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  playSound("files/prompt.mp3")
  if computerPrompt then
    sightexports.sGui:deleteGuiElement(computerPrompt)
  end
  computerPromptInput = false
  local x, y = 514 - sx / 2, titleBarHeight + 2 + 272 - sy / 2
  local pad = 8
  computerPrompt = sightexports.sGui:createGuiElement("rectangle", x, y, sx, sy, computerWindow)
  sightexports.sGui:setGuiBackground(computerPrompt, "solid", computerColorScheme.base)
  sightexports.sGui:setGuiHover(computerPrompt, "none", false, false, true)
  sightexports.sGui:setGuiHoverable(computerPrompt, true)
  sightexports.sGui:disableClickTrough(computerPrompt, true)
  sightexports.sGui:disableLinkCursor(computerPrompt, true)
  local label = sightexports.sGui:createGuiElement("label", 6, 0, 0, 24, computerPrompt)
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, title)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  local icon = sightexports.sGui:createGuiElement("image", sx - 24, 0, 24, 24, computerPrompt)
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("times", 24, "solid"))
  sightexports.sGui:setImageColor(icon, "#ffffff")
  sightexports.sGui:setGuiHoverable(icon, true)
  sightexports.sGui:setGuiHover(icon, "solid", computerColorScheme.red)
  sightexports.sGui:setClickEvent(icon, "closePaintshopComputerPrompt")
  local inside = sightexports.sGui:createGuiElement("rectangle", 2, 24, sx - 4, sy - 24 - 2, computerPrompt)
  sightexports.sGui:setGuiBackground(inside, "solid", computerColorScheme.window)
  local label = sightexports.sGui:createGuiElement("label", 10, 5, sx - 20, sy - 24 - 2 - pad - 24 - pad, inside)
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, "Válaszd ki a számodra megfelelő mennyiséget!")
  sightexports.sGui:setLabelColor(label, "#000000")
  sightexports.sGui:setLabelAlignment(label, "center", "top")
  sightexports.sGui:setLabelWordBreak(label, true)
  for i = 1, #possiblePoints do
    local btn = sightexports.sGui:createGuiElement("button", 10, titleBarHeight + 16 + ((i - 1) * 30), sx - 20, 24, computerPrompt)
    sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    sightexports.sGui:setButtonText(btn, possiblePoints[i].amount.. " - "..sightexports.sGui:thousandsStepper(possiblePoints[i].price).." PP")
    sightexports.sGui:setClickEvent(btn, "buyPoint")
    sightexports.sGui:setClickArgument(btn, i)
    setButtonScheme(btn)
  end
  frontComputerScan()
  return inside, sx - 4, sy - 24 - 2
end
function createErrorPrompt(title, sx, sy, text)
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  playSound("files/error.mp3")
  if computerPrompt then
    sightexports.sGui:deleteGuiElement(computerPrompt)
  end
  computerPromptInput = false
  local x = 514 - sx / 2
  local y = titleBarHeight + 2 + 272 - sy / 2
  local pad = 8
  computerPrompt = sightexports.sGui:createGuiElement("rectangle", x, y, sx, sy, computerWindow)
  sightexports.sGui:setGuiBackground(computerPrompt, "solid", computerColorScheme.base)
  sightexports.sGui:setGuiHover(computerPrompt, "none", false, false, true)
  sightexports.sGui:setGuiHoverable(computerPrompt, true)
  sightexports.sGui:disableClickTrough(computerPrompt, true)
  sightexports.sGui:disableLinkCursor(computerPrompt, true)
  local label = sightexports.sGui:createGuiElement("label", 6, 0, 0, 24, computerPrompt)
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, title)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  local icon = sightexports.sGui:createGuiElement("image", sx - 24, 0, 24, 24, computerPrompt)
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("times", 24, "solid"))
  sightexports.sGui:setImageColor(icon, "#ffffff")
  sightexports.sGui:setGuiHoverable(icon, true)
  sightexports.sGui:setGuiHover(icon, "solid", computerColorScheme.red)
  sightexports.sGui:setClickEvent(icon, "closePaintshopComputerPrompt")
  local inside = sightexports.sGui:createGuiElement("rectangle", 2, 24, sx - 4, sy - 24 - 2, computerPrompt)
  sightexports.sGui:setGuiBackground(inside, "solid", computerColorScheme.window)
  local icon = sightexports.sGui:createGuiElement("image", pad, (sy - 24 - 2 - pad - 24 - pad) / 2 - 24, 48, 48, inside)
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("exclamation-circle", 48, "solid"))
  sightexports.sGui:setImageColor(icon, computerColorScheme.red)
  local label = sightexports.sGui:createGuiElement("label", pad + 48 + pad, 0, sx - 4 - pad - 48 - pad, sy - 24 - 2 - pad - 24 - pad, inside)
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, text)
  sightexports.sGui:setLabelColor(label, "#000000")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelWordBreak(label, true)
  local btn = sightexports.sGui:createGuiElement("button", sx / 2 - 40, sy - 24 - 2 - pad, 80, 24, computerPrompt)
  sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightexports.sGui:setButtonText(btn, "OK")
  sightexports.sGui:setClickEvent(btn, "closePaintshopComputerPrompt")
  setButtonScheme(btn)
  frontComputerScan()
  return inside, sx - 4, sy - 24 - 2
end
function createInputPrompt(title, sx, sy, text, event)
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  playSound("files/prompt.mp3")
  if computerPrompt then
    sightexports.sGui:deleteGuiElement(computerPrompt)
  end
  computerPromptInput = false
  local x = 514 - sx / 2
  local y = titleBarHeight + 2 + 272 - sy / 2
  local pad = 8
  computerPrompt = sightexports.sGui:createGuiElement("rectangle", x, y, sx, sy, computerWindow)
  sightexports.sGui:setGuiBackground(computerPrompt, "solid", computerColorScheme.base)
  sightexports.sGui:setGuiHover(computerPrompt, "none", false, false, true)
  sightexports.sGui:setGuiHoverable(computerPrompt, true)
  sightexports.sGui:disableClickTrough(computerPrompt, true)
  sightexports.sGui:disableLinkCursor(computerPrompt, true)
  local label = sightexports.sGui:createGuiElement("label", 6, 0, 0, 24, computerPrompt)
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, title)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  local icon = sightexports.sGui:createGuiElement("image", sx - 24, 0, 24, 24, computerPrompt)
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("times", 24, "solid"))
  sightexports.sGui:setImageColor(icon, "#ffffff")
  sightexports.sGui:setGuiHoverable(icon, true)
  sightexports.sGui:setGuiHover(icon, "solid", computerColorScheme.red)
  sightexports.sGui:setClickEvent(icon, "closePaintshopComputerPrompt")
  local inside = sightexports.sGui:createGuiElement("rectangle", 2, 24, sx - 4, sy - 24 - 2, computerPrompt)
  sightexports.sGui:setGuiBackground(inside, "solid", computerColorScheme.window)
  local icon = sightexports.sGui:createGuiElement("image", pad, (sy - 52 - pad * 3 - 24) / 2 - 24, 48, 48, inside)
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("question-circle", 48, "solid"))
  sightexports.sGui:setImageColor(icon, computerColorScheme.blue)
  local label = sightexports.sGui:createGuiElement("label", pad + 48 + pad, 0, sx - 4 - pad - 48 - pad, sy - 52 - pad * 3 - 24, inside)
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, text)
  sightexports.sGui:setLabelColor(label, "#000000")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelWordBreak(label, true)
  computerPromptInput = sightexports.sGui:createGuiElement("input", pad + 8 + 2, sy - 24 - 2 - pad - 24 - pad, sx - 16 - 4 - pad * 2, 24, computerPrompt)
  sightexports.sGui:setInputFont(computerPromptInput, "10/Ubuntu-L.ttf")
  sightexports.sGui:setInputColor(computerPromptInput, "#454545", "#ffffff", false, "#353535", "#000000")
  local btn = sightexports.sGui:createGuiElement("button", sx / 2 - 40, sy - 24 - 2 - pad, 80, 24, computerPrompt)
  sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightexports.sGui:setButtonText(btn, "OK")
  sightexports.sGui:setClickEvent(btn, event or "closePaintshopComputerPrompt")
  setButtonScheme(btn)
  frontComputerScan()
  return inside, sx - 4, sy - 24 - 2
end
function createYesNoPrompt(title, sx, sy, text, event)
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  playSound("files/prompt.mp3")
  if computerPrompt then
    sightexports.sGui:deleteGuiElement(computerPrompt)
  end
  computerPromptInput = false
  local x = 514 - sx / 2
  local y = titleBarHeight + 2 + 272 - sy / 2
  local pad = 8
  computerPrompt = sightexports.sGui:createGuiElement("rectangle", x, y, sx, sy, computerWindow)
  sightexports.sGui:setGuiBackground(computerPrompt, "solid", computerColorScheme.base)
  sightexports.sGui:setGuiHover(computerPrompt, "none", false, false, true)
  sightexports.sGui:setGuiHoverable(computerPrompt, true)
  sightexports.sGui:disableClickTrough(computerPrompt, true)
  sightexports.sGui:disableLinkCursor(computerPrompt, true)
  local label = sightexports.sGui:createGuiElement("label", 6, 0, 0, 24, computerPrompt)
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, title)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  local icon = sightexports.sGui:createGuiElement("image", sx - 24, 0, 24, 24, computerPrompt)
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("times", 24, "solid"))
  sightexports.sGui:setImageColor(icon, "#ffffff")
  sightexports.sGui:setGuiHoverable(icon, true)
  sightexports.sGui:setGuiHover(icon, "solid", computerColorScheme.red)
  sightexports.sGui:setClickEvent(icon, "closePaintshopComputerPrompt")
  local inside = sightexports.sGui:createGuiElement("rectangle", 2, 24, sx - 4, sy - 24 - 2, computerPrompt)
  sightexports.sGui:setGuiBackground(inside, "solid", computerColorScheme.window)
  local icon = sightexports.sGui:createGuiElement("image", pad, (sy - 24 - 2 - pad - 24 - pad) / 2 - 24, 48, 48, inside)
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("question-circle", 48, "solid"))
  sightexports.sGui:setImageColor(icon, computerColorScheme.blue)
  local label = sightexports.sGui:createGuiElement("label", pad + 48 + pad, 0, sx - 4 - pad - 48 - pad, sy - 24 - 2 - pad - 24 - pad, inside)
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, text)
  sightexports.sGui:setLabelColor(label, "#000000")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelWordBreak(label, true)
  local btn = sightexports.sGui:createGuiElement("button", sx / 2 - 80 - pad / 2, sy - 24 - 2 - pad, 80, 24, computerPrompt)
  sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightexports.sGui:setButtonText(btn, "Igen")
  sightexports.sGui:setClickEvent(btn, event)
  setButtonScheme(btn)
  local btn = sightexports.sGui:createGuiElement("button", sx / 2 + pad / 2, sy - 24 - 2 - pad, 80, 24, computerPrompt)
  sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightexports.sGui:setButtonText(btn, "Nem")
  sightexports.sGui:setClickEvent(btn, "closePaintshopComputerPrompt")
  setButtonScheme(btn)
  frontComputerScan()
  return inside, sx - 4, sy - 24 - 2
end
function getEmailText(data)
  if data.paint then
    data.paint = data.paint:gsub("#", "")
  end
  if data.emailType == "rating" then
    local text = ""
    text = text .. "Értékelő: " .. getEmailName(data.from) .. [[


]]
    text = text .. "Értékelés: " .. math.floor(data.jobRating * 10) / 10 .. "/5" .. [[


]]
    text = text .. "Szöveges értékelés: " .. jobRatingTexts[data.jobRatingTextId][1] .. [[


]]
    return text
  elseif data.emailType == "job" then
    local text = ""
    local dat = paintshopWorks[data.workId]

    if dat and dat.color then
      dat.color = dat.color:gsub("#", "")
    end

    if dat then
      text = text .. "Gépjármű típusa: " .. sightexports.sVehiclenames:getCustomVehicleName(dat.model) .. "\n"
      text = text .. "Gépjármű forgalmi rendszáma: " .. convertPlate(dat.plate) .. [[


]]
      text = text .. "Sérült elemek: " .. table.concat(dat.partNames, ", ") .. [[


]]
      text = text .. "Gépjármű színkódja: " .. validColorNames[dat.color] .. "\n"
      text = text .. "Metál fény: " .. (dat.metal and "Igen" or "Nem") .. [[


]]
      text = text .. "Munkadíj: " .. sightexports.sGui:thousandsStepper(dat.price) .. " $"
    end
    return text
  elseif data.emailType == "offer" then
    if data.offerStartTimeoutTime then
      return getOfferStartTimeoutReply(data.textId, data.offerStartTimeoutRnd, workshopRented.name, data.fromText)
    elseif data.offerReplyTime then
      return getOfferReply(data.textId, data.offerReplyRnd, data.offerReply, sightexports.sVehiclenames:getCustomVehicleName(data.model), validColorNames[data.paint] .. (data.paintMetal and " METÁL" or ""), table.concat(data.partNames, ", "), data.price, data.playerReplyPrice, workshopRented.name, data.fromText)
    elseif data.playerReply then
      return getOfferPlayerReply(data.textId, workshopRented.name, data.from, offerPrices[data.playerReplyPrice][2] * data.price, data.playerReply[1], data.playerReply[2])
    else
      return getOfferEmail(data.textId, workshopRented.name, data.referrer, sightexports.sVehiclenames:getCustomVehicleName(data.model), validColorNames[data.paint] .. (data.paintMetal and " METÁL" or ""), table.concat(data.partNames, ", "), data.fromText)
    end
  end
  return ""
end
local monthNames = {
  "Jan",
  "Feb",
  "Már",
  "Ápr",
  "Máj",
  "Jún",
  "Júl",
  "Aug",
  "Szep",
  "Okt",
  "Nov",
  "Dec"
}
function processEmailData(i)
  local data = emailListRaw[i]
  if emailListRaw[i].emailType == "rating" then
    emailListRaw[i].fromText = "SightBack Értékelések"
  else
    emailListRaw[i].fromText = getEmailName(emailListRaw[i].from)
  end
  local text = getEmailText(data)
  emailListRaw[i].short = utf8.sub(utf8.gsub(text, "\n", " "), 1, 32) .. "..."
  emailListRaw[i].categoryText = getEmailCat(data)
  emailListRaw[i].lastEmailTime = getEmailTime(data)
  local time = data.lastEmailTime
  time = getRealTime(time)
  emailListRaw[i].dateShortText = monthNames[time.month + 1] .. ". " .. time.monthday .. ". " .. string.format("%02d:%02d", time.hour, time.minute)
end
function scrollHandler(key, state)
  if not openedEmail then
    if key == "mouse_wheel_up" then
      if 0 < emailScroll then
        emailScroll = emailScroll - 1
        processEmailAppRows()
      end
    elseif key == "mouse_wheel_down" and emailScroll < #emailList - #emailAppRows then
      emailScroll = emailScroll + 1
      processEmailAppRows()
    end
  end
end
function emailListSort(a, b)
  return emailListRaw[a].lastEmailTime > emailListRaw[b].lastEmailTime
end
function createEmailList()
  emailList = {}
  nameW = 0
  dateW = 0
  for i in pairs(emailListRaw) do
    emailListRaw[i].emailId = i
    if not seletedEmailCategory or seletedEmailCategory == emailListRaw[i].categoryText then
      table.insert(emailList, i)
      nameW = math.max(nameW, sightexports.sGui:getTextWidthFont(emailListRaw[i].fromText, "10/Ubuntu-R.ttf"))
      dateW = math.max(dateW, sightexports.sGui:getTextWidthFont(emailListRaw[i].dateShortText, "10/Ubuntu-R.ttf"))
    end
  end
  if emailScroll > math.max(0, #emailList - #emailAppRows) then
    emailScroll = math.max(0, #emailList - #emailAppRows)
  end
  table.sort(emailList, emailListSort)
end
function countEmailCategories()
  emailCategoryCount = {}
  overallEmailCount = 0
  for i in pairs(emailListRaw) do
    emailCategoryCount[emailListRaw[i].categoryText] = (emailCategoryCount[emailListRaw[i].categoryText] or 0) + 1
    overallEmailCount = overallEmailCount + 1
  end
end
addEvent("selectPaintshopEmailCategory", false)
addEventHandler("selectPaintshopEmailCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  seletedEmailCategory = emailAppFolderElemenets[el]
  createEmailList()
  createEmailWindow()
  playSound("files/click.mp3")
end)
lastEmailNoti = 0
addEvent("refreshPaintshopEmail", true)
addEventHandler("refreshPaintshopEmail", getRootElement(), function(ws, emailId, data, noti)
  if ws == currentWorkshop then
    local cat = false
    local cat2 = emailListRaw[emailId] and emailListRaw[emailId].categoryText
    if data then
      if not emailListRaw[emailId] then
        emailListRaw[emailId] = {}
      end
      for k, v in pairs(data) do
        emailListRaw[emailId][k] = v or nil
      end
      processEmailData(emailId)
      cat = emailListRaw[emailId].categoryText
    else
      emailListRaw[emailId] = nil
    end
    countEmailCategories()
    if noti then
      local sound = playSound3D("files/newmail.mp3", wsX + 3.0706, wsY - 3.6492, wsZ + 0.9472)
      setElementInterior(sound, targetInt)
      setElementDimension(sound, currentWorkshop)
      lastEmailNoti = getTickCount()
    end
    if openedComputerApp == "email" and computerWindow then
      if openedEmail == emailId then
        if not emailListRaw[emailId] then
          createEmailList()
          openedEmail = false
        end
      elseif not seletedEmailCategory or cat == seletedEmailCategory then
        createEmailList()
      end
      createEmailWindow()
    end
  end
end)
function gotPaintshopEmailList(data)
  emailListRaw = data
  for i in pairs(emailListRaw) do
    processEmailData(i)
  end
  countEmailCategories()
  if openedComputerApp == "email" and computerWindow then
    createEmailList()
    createEmailWindow()
  end
end
addEvent("openPaintshopEmailApp", false)
addEventHandler("openPaintshopEmailApp", getRootElement(), function()
  openedEmail = false
  createEmailList()
  createEmailWindow()
  playSound("files/click.mp3")
end)
addEvent("openPaintshopInternetApp", false)
addEventHandler("openPaintshopInternetApp", getRootElement(), function()
  orderNum = {}
  overallOrderSum = 0
  overallOrderNum = 0
  createInternetWindow()
  playSound("files/click.mp3")
end)
addEvent("openPaintshopEmailMessage", false)
addEventHandler("openPaintshopEmailMessage", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #emailAppRows do
    local id = i + emailScroll
    if emailAppRows[i][1] == el then
      openedEmail = emailList[id]
      createEmailWindow()
      playSound("files/click.mp3")
      return
    end
  end
end)
addEvent("sendOfferToPaintshopJob", false)
addEventHandler("sendOfferToPaintshopJob", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if openedEmail then
    if not getPlayerPermission("sendOffer") then
      sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
      return
    end
    triggerServerEvent("tryToMakePaintShopOffer", localPlayer, openedEmail, emailReplyButtons[el])
    for el in pairs(emailReplyButtons) do
      sightexports.sGui:deleteGuiElement(el)
    end
    playSound("files/click.mp3")
    emailReplyButtons = {}
  end
end)
addEvent("tryToStartPaintshopJobFinal", false)
addEventHandler("tryToStartPaintshopJobFinal", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if openedEmail then
    closePaintshopComputerPrompt()
    triggerServerEvent("tryToStartPaintshopJob", localPlayer, openedEmail)
    playSound("files/click.mp3")
  end
end)
addEvent("tryToStartPaintshopJob", false)
addEventHandler("tryToStartPaintshopJob", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if openedEmail then
    if not getPlayerPermission("startJob") then
      sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
      return
    end
    createYesNoPrompt("Munka megkezdése", 400, 125, "Biztosan szeretnéd megkezdeni a munkát?", "tryToStartPaintshopJobFinal")
  end
end)
addEvent("tryToEndPaintshopJobFinal", false)
addEventHandler("tryToEndPaintshopJobFinal", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if openedEmail then
    local data = emailListRaw[openedEmail]
    if data and data.workId then
      closePaintshopComputerPrompt()
      triggerServerEvent("tryToEndPaintshopJob", localPlayer, data.workId)
    end
  end
end)
addEvent("tryToEndPaintshopJob", false)
addEventHandler("tryToEndPaintshopJob", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if openedEmail then
    if not getPlayerPermission("cancelJob") then
      sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
      return
    end
    createYesNoPrompt("Munka visszamondása", 400, 155, "A munka visszamondásával romlik az értékelésed. Biztosan szeretnéd visszamondani a munkát?", "tryToEndPaintshopJobFinal")
  end
end)
addEvent("startPaintshopDeliveryIn", false)
addEventHandler("startPaintshopDeliveryIn", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if openedEmail then
    if not getPlayerPermission("transportIn") then
      sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
      return
    end
    local data = emailListRaw[openedEmail]
    if data and data.workId then
      triggerServerEvent("startPaintshopDeliveryIn", localPlayer, data.workId)
      playSound("files/click.mp3")
    end
  end
end)
addEvent("startPaintshopDeliveryOut", false)
addEventHandler("startPaintshopDeliveryOut", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if openedEmail then
    if not getPlayerPermission("transportOut") then
      sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
      return
    end
    local data = emailListRaw[openedEmail]
    if data and data.workId then
      triggerServerEvent("startPaintshopDeliveryOut", localPlayer, data.workId)
      playSound("files/click.mp3")
    end
  end
end)
function processEmailAppRows()
  local h = emailScrollBarH / math.max(1, #emailList - #emailAppRows + 1)
  sightexports.sGui:setGuiSize(emailScrollBar, false, h)
  sightexports.sGui:setGuiPosition(emailScrollBar, false, emailScrollBarY + h * emailScroll)
  local appW = 1020
  local w = appW - 190 - 32 - 16 - 6
  for i = 1, #emailAppRows do
    local id = i + emailScroll
    local data = emailList[id] and emailListRaw[emailList[id]]
    if data then
      for j = 2, #emailAppRows[i] do
        sightexports.sGui:setGuiRenderDisabled(emailAppRows[i][j], false)
      end
      sightexports.sGui:setGuiHoverable(emailAppRows[i][1], true)
      if data.unread then
        sightexports.sGui:setGuiBackground(emailAppRows[i][1], "solid", {
          255,
          255,
          255,
          225
        })
        sightexports.sGui:setLabelFont(emailAppRows[i][2], "10/Ubuntu-R.ttf")
        sightexports.sGui:setLabelFont(emailAppRows[i][4], "10/Ubuntu-R.ttf")
        sightexports.sGui:setLabelFont(emailAppRows[i][5], "10/Ubuntu-R.ttf")
        sightexports.sGui:setLabelFont(emailAppRows[i][6], "10/Ubuntu-R.ttf")
        sightexports.sGui:setLabelFont(emailAppRows[i][7], "10/Ubuntu-R.ttf")
        sightexports.sGui:setLabelColor(emailAppRows[i][2], "#000")
        sightexports.sGui:setLabelColor(emailAppRows[i][5], "#000")
        sightexports.sGui:setLabelColor(emailAppRows[i][6], "#989898")
        sightexports.sGui:setLabelColor(emailAppRows[i][7], "#000")
      else
        sightexports.sGui:setGuiBackground(emailAppRows[i][1], "solid", {
          255,
          255,
          255,
          150
        })
        sightexports.sGui:setLabelFont(emailAppRows[i][2], "10/Ubuntu-L.ttf")
        sightexports.sGui:setLabelFont(emailAppRows[i][4], "10/Ubuntu-L.ttf")
        sightexports.sGui:setLabelFont(emailAppRows[i][5], "10/Ubuntu-L.ttf")
        sightexports.sGui:setLabelFont(emailAppRows[i][6], "10/Ubuntu-L.ttf")
        sightexports.sGui:setLabelFont(emailAppRows[i][7], "10/Ubuntu-L.ttf")
        sightexports.sGui:setLabelColor(emailAppRows[i][2], "#464646")
        sightexports.sGui:setLabelColor(emailAppRows[i][5], "#464646")
        sightexports.sGui:setLabelColor(emailAppRows[i][6], "#afafaf")
        sightexports.sGui:setLabelColor(emailAppRows[i][7], "#464646")
      end
      sightexports.sGui:setLabelText(emailAppRows[i][2], data.fromText)
      setCatAndLabel(emailAppRows[i][3], emailAppRows[i][4], data)
      sightexports.sGui:setGuiPosition(emailAppRows[i][4], 24 + nameW + 4, 0)
      local categoryW = sightexports.sGui:getLabelTextWidth(emailAppRows[i][4])
      sightexports.sGui:setGuiPosition(emailAppRows[i][3], 24 + nameW + 4 - 4, 2)
      sightexports.sGui:setGuiSize(emailAppRows[i][3], categoryW + 8, false)
      sightexports.sGui:setGuiPosition(emailAppRows[i][5], 24 + nameW + 4 + categoryW + 9, 0)
      local title = getEmailTitle(data, true)
      sightexports.sGui:setLabelText(emailAppRows[i][5], title)
      local titleW = sightexports.sGui:getLabelTextWidth(emailAppRows[i][5])
      local x = 24 + nameW + 4 + categoryW + 9 + titleW + 4
      sightexports.sGui:setGuiPosition(emailAppRows[i][6], x, 0)
      sightexports.sGui:setGuiSize(emailAppRows[i][6], w - x - dateW - 12, false)
      sightexports.sGui:setLabelText(emailAppRows[i][6], data.short)
      sightexports.sGui:setLabelText(emailAppRows[i][7], data.dateShortText)
    else
      for j = 2, #emailAppRows[i] do
        sightexports.sGui:setGuiRenderDisabled(emailAppRows[i][j], true)
      end
      sightexports.sGui:setGuiHoverable(emailAppRows[i][1], false)
      sightexports.sGui:setGuiBackground(emailAppRows[i][1], "solid", {
        255,
        255,
        255,
        150
      })
    end
  end
end
function getEmailCat(data)
  if data.emailType == "rating" then
    return "Értékelések"
  elseif data.emailType == "job" then
    return "Elvállalt munkák"
  elseif data.emailType == "offer" then
    if data.offerReplyTime then
      if not data.offerReply or data.offerReply == "timeout" then
        return "Archívum"
      elseif data.offerReply then
        return "Elfogadott ajánlatok"
      end
    end
    return "Ajánlatok"
  else
    return "Egyéb"
  end
end
function setCatAndLabel(bg, label, data)
  local cat = data.categoryText
  if cat == "Értékelések" then
    sightexports.sGui:setGuiBackground(bg, "solid", "#e8e6c4")
    sightexports.sGui:setGuiBackgroundBorder(bg, 1, "#7d7931")
    sightexports.sGui:setLabelColor(label, "#7d7931")
  elseif cat == "Elvállalt munkák" then
    sightexports.sGui:setGuiBackground(bg, "solid", "#c4c7e8")
    sightexports.sGui:setGuiBackgroundBorder(bg, 1, "#31377d")
    sightexports.sGui:setLabelColor(label, "#31377d")
  elseif cat == "Archívum" then
    sightexports.sGui:setGuiBackground(bg, "solid", "#e8c4c4")
    sightexports.sGui:setGuiBackgroundBorder(bg, 1, "#7d3131")
    sightexports.sGui:setLabelColor(label, "#7d3131")
  elseif cat == "Elfogadott ajánlatok" then
    sightexports.sGui:setGuiBackground(bg, "solid", "#c4e8d4")
    sightexports.sGui:setGuiBackgroundBorder(bg, 1, "#317d54")
    sightexports.sGui:setLabelColor(label, "#317d54")
  elseif cat == "Ajánlatok" then
    sightexports.sGui:setGuiBackground(bg, "solid", "#c4e5e8")
    sightexports.sGui:setGuiBackgroundBorder(bg, 1, "#31777d")
    sightexports.sGui:setLabelColor(label, "#31777d")
  else
    sightexports.sGui:setGuiBackground(bg, "solid", "#e6c4e8")
    sightexports.sGui:setGuiBackgroundBorder(bg, 1, "#79317d")
    sightexports.sGui:setLabelColor(label, "#79317d")
  end
  sightexports.sGui:setLabelText(label, cat)
end
function getEmailTitle(data, re)
  local title = ""
  if data.emailType == "rating" then
    return "Új értékelést kaptál"
  elseif data.emailType == "offer" or data.emailType == "job" then
    title = offerTitles[data.titleId]
    if re then
      if data.playerReplyTime then
        title = "Re: " .. title
      end
      if data.offerReplyTime then
        title = "Re: " .. title
      end
      if data.offerStartTimeoutTime then
        title = "Re: " .. title
      end
      if data.jobStartTime then
        title = "Re: " .. title
      end
    end
  end
  return title
end
function createEmailWindow()
  closePaintshopComputerPrompt()
  if not scrollHandled then
    scrollHandled = true
    addEventHandler("onClientKey", getRootElement(), scrollHandler)
  end
  openedComputerApp = "email"
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  if computerApp then
    sightexports.sGui:deleteGuiElement(computerApp)
  end
  computerApp = sightexports.sGui:createGuiElement("rectangle", 2, titleBarHeight + 2, 1024, 544, computerWindow)
  sightexports.sGui:setGuiBackground(computerApp, "solid", computerColorScheme.blue)
  local rect = sightexports.sGui:createGuiElement("rectangle", 40, 544, 32, 32, computerApp)
  sightexports.sGui:setGuiBackground(rect, "solid", computerColorScheme.blue)
  local icon = sightexports.sGui:createGuiElement("image", 0, 0, 32, 32, rect)
  sightexports.sGui:setImageFile(icon, ":sPaintshop/files/emailicon.dds")
  local label = sightexports.sGui:createGuiElement("label", 4, 0, 0, 24, computerApp)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "Sightmail kliens")
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  local icon = sightexports.sGui:createGuiElement("image", 1000, 0, 24, 24, computerApp)
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("times", 24))
  sightexports.sGui:setGuiHover(icon, "solid", "sightred")
  sightexports.sGui:setGuiHoverable(icon, true)
  sightexports.sGui:setClickEvent(icon, "openPaintshopComputerDesktop")
  local appW = 1020
  local appH = 518
  computerAppInside = sightexports.sGui:createGuiElement("rectangle", 2, 24, appW, appH, computerApp)
  sightexports.sGui:setGuiBackground(computerAppInside, "solid", "#ffffff")
  local image = sightexports.sGui:createGuiElement("image", 16, 16, 162, 51, computerAppInside)
  sightexports.sGui:setImageFile(image, ":sPaintshop/files/maillogo.dds")
  local y = 83
  local ih = appH - y - 16
  emailAppFolderLabels = {}
  emailAppRows = {}
  emailReplyButtons = {}
  if openedEmail then
    sightexports.sGui:setGuiHoverable(image, true)
    sightexports.sGui:setClickEvent(image, "openPaintshopEmailApp")
    local data = emailListRaw[openedEmail]
    if data then
      if data.unread then
        emailListRaw[openedEmail].unread = false
        triggerServerEvent("readPaintshopEmail", localPlayer, openedEmail)
      end
      local title = getEmailTitle(data)
      local time = data.emailTime
      local sender = data.fromText
      if data.playerReplyTime then
        local rect = sightexports.sGui:createGuiElement("rectangle", 16, y, appW - 32, 30, computerAppInside)
        sightexports.sGui:setGuiBackground(rect, "solid", "#c3d9ff")
        local timeFormat = getRealTime(time)
        local label = sightexports.sGui:createGuiElement("label", 0, 0, appW - 32 - 6, 30, rect)
        sightexports.sGui:setLabelAlignment(label, "right", "center")
        sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        sightexports.sGui:setLabelColor(label, "#0000d7")
        sightexports.sGui:setLabelText(label, "Feladó: " .. sender .. ", " .. string.format("%04d. %02d. %02d.", timeFormat.year + 1900, timeFormat.month + 1, timeFormat.monthday) .. " " .. string.format("%02d:%02d:%02d", timeFormat.hour, timeFormat.minute, timeFormat.second))
        local cat = sightexports.sGui:createGuiElement("rectangle", 6, 4, 0, 22, rect)
        local label = sightexports.sGui:createGuiElement("label", 10, 0, 0, 30, rect)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        setCatAndLabel(cat, label, data)
        local w = sightexports.sGui:getLabelTextWidth(label) + 8
        sightexports.sGui:setGuiSize(cat, w, false)
        local label = sightexports.sGui:createGuiElement("label", 6 + w + 4, 0, 0, 30, rect)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelText(label, title)
        sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
        sightexports.sGui:setLabelColor(label, "#0000d7")
        title = "Re: " .. title
        time = data.playerReplyTime
        sender = workshopRented.name
        y = y + 30 + 6
        ih = ih - 30 - 6
      end
      if data.offerReplyTime then
        local rect = sightexports.sGui:createGuiElement("rectangle", 16, y, appW - 32, 30, computerAppInside)
        sightexports.sGui:setGuiBackground(rect, "solid", "#c3d9ff")
        local timeFormat = getRealTime(time)
        local label = sightexports.sGui:createGuiElement("label", 0, 0, appW - 32 - 6, 30, rect)
        sightexports.sGui:setLabelAlignment(label, "right", "center")
        sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        sightexports.sGui:setLabelColor(label, "#0000d7")
        sightexports.sGui:setLabelText(label, "Feladó: " .. sender .. ", " .. string.format("%04d. %02d. %02d.", timeFormat.year + 1900, timeFormat.month + 1, timeFormat.monthday) .. " " .. string.format("%02d:%02d:%02d", timeFormat.hour, timeFormat.minute, timeFormat.second))
        local cat = sightexports.sGui:createGuiElement("rectangle", 6, 4, 0, 22, rect)
        local label = sightexports.sGui:createGuiElement("label", 10, 0, 0, 30, rect)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        setCatAndLabel(cat, label, data)
        local w = sightexports.sGui:getLabelTextWidth(label) + 8
        sightexports.sGui:setGuiSize(cat, w, false)
        local label = sightexports.sGui:createGuiElement("label", 6 + w + 4, 0, 0, 30, rect)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelText(label, title)
        sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
        sightexports.sGui:setLabelColor(label, "#0000d7")
        title = "Re: " .. title
        time = data.offerReplyTime
        sender = data.fromText
        y = y + 30 + 6
        ih = ih - 30 - 6
      end
      if data.offerStartTimeoutTime then
        local rect = sightexports.sGui:createGuiElement("rectangle", 16, y, appW - 32, 30, computerAppInside)
        sightexports.sGui:setGuiBackground(rect, "solid", "#c3d9ff")
        local timeFormat = getRealTime(time)
        local label = sightexports.sGui:createGuiElement("label", 0, 0, appW - 32 - 6, 30, rect)
        sightexports.sGui:setLabelAlignment(label, "right", "center")
        sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        sightexports.sGui:setLabelColor(label, "#0000d7")
        sightexports.sGui:setLabelText(label, "Feladó: " .. sender .. ", " .. string.format("%04d. %02d. %02d.", timeFormat.year + 1900, timeFormat.month + 1, timeFormat.monthday) .. " " .. string.format("%02d:%02d:%02d", timeFormat.hour, timeFormat.minute, timeFormat.second))
        local cat = sightexports.sGui:createGuiElement("rectangle", 6, 4, 0, 22, rect)
        local label = sightexports.sGui:createGuiElement("label", 10, 0, 0, 30, rect)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        setCatAndLabel(cat, label, data)
        local w = sightexports.sGui:getLabelTextWidth(label) + 8
        sightexports.sGui:setGuiSize(cat, w, false)
        local label = sightexports.sGui:createGuiElement("label", 6 + w + 4, 0, 0, 30, rect)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelText(label, title)
        sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
        sightexports.sGui:setLabelColor(label, "#0000d7")
        title = "Re: " .. title
        time = data.offerStartTimeoutTime
        sender = data.fromText
        y = y + 30 + 6
        ih = ih - 30 - 6
      end
      if data.jobStartTime then
        local rect = sightexports.sGui:createGuiElement("rectangle", 16, y, appW - 32, 30, computerAppInside)
        sightexports.sGui:setGuiBackground(rect, "solid", "#c3d9ff")
        local timeFormat = getRealTime(time)
        local label = sightexports.sGui:createGuiElement("label", 0, 0, appW - 32 - 6, 30, rect)
        sightexports.sGui:setLabelAlignment(label, "right", "center")
        sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        sightexports.sGui:setLabelColor(label, "#0000d7")
        sightexports.sGui:setLabelText(label, "Feladó: " .. sender .. ", " .. string.format("%04d. %02d. %02d.", timeFormat.year + 1900, timeFormat.month + 1, timeFormat.monthday) .. " " .. string.format("%02d:%02d:%02d", timeFormat.hour, timeFormat.minute, timeFormat.second))
        local cat = sightexports.sGui:createGuiElement("rectangle", 6, 4, 0, 22, rect)
        local label = sightexports.sGui:createGuiElement("label", 10, 0, 0, 30, rect)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        setCatAndLabel(cat, label, data)
        local w = sightexports.sGui:getLabelTextWidth(label) + 8
        sightexports.sGui:setGuiSize(cat, w, false)
        local label = sightexports.sGui:createGuiElement("label", 6 + w + 4, 0, 0, 30, rect)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelText(label, title)
        sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
        sightexports.sGui:setLabelColor(label, "#0000d7")
        title = "Re: " .. title
        time = data.jobStartTime
        sender = workshopRented.name
        y = y + 30 + 6
        ih = ih - 30 - 6
      end
      local rect = sightexports.sGui:createGuiElement("rectangle", 16, y, appW - 32, ih, computerAppInside)
      sightexports.sGui:setGuiBackground(rect, "solid", "#c3d9ff")
      local timeFormat = getRealTime(time)
      local label = sightexports.sGui:createGuiElement("label", 0, 0, appW - 32 - 6, 42, rect)
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      sightexports.sGui:setLabelColor(label, "#0000d7")
      sightexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d.", timeFormat.year + 1900, timeFormat.month + 1, timeFormat.monthday) .. "\n" .. string.format("%02d:%02d:%02d", timeFormat.hour, timeFormat.minute, timeFormat.second))
      local cat = sightexports.sGui:createGuiElement("rectangle", 6, 4, 0, 22, rect)
      local label = sightexports.sGui:createGuiElement("label", 10, 0, 0, 30, rect)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      setCatAndLabel(cat, label, data)
      local w = sightexports.sGui:getLabelTextWidth(label) + 8
      sightexports.sGui:setGuiSize(cat, w, false)
      local label = sightexports.sGui:createGuiElement("label", 6 + w + 4, 0, 0, 30, rect)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelText(label, title)
      sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
      sightexports.sGui:setLabelColor(label, "#0000d7")
      local label = sightexports.sGui:createGuiElement("label", 6, 30, 0, 12, rect)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelText(label, "Feladó: " .. sender)
      sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      sightexports.sGui:setLabelColor(label, "#0000d7")
      local rect = sightexports.sGui:createGuiElement("rectangle", 6, 48, appW - 32 - 12, ih - 30 - 12 - 12, rect)
      sightexports.sGui:setGuiBackground(rect, "solid", "#ffffff")
      local label = sightexports.sGui:createGuiElement("label", 6, 6, appW - 32 - 24, ih - 30 - 12 - 24, rect)
      sightexports.sGui:setLabelAlignment(label, "left", "top")
      sightexports.sGui:setLabelText(label, getEmailText(data))
      sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      sightexports.sGui:setLabelColor(label, "#000000")
      sightexports.sGui:setLabelWordBreak(label, true)
      if data.emailType == "job" then
        local dat = paintshopWorks[data.workId]
        if dat then
          local w = (appW - 32 - 12 - 24) / 3
          local y = ih - 30 - 12 - 12 - 24 - 6
          if dat.state == "transportOut" then
            local x = (appW - 32) / 2 - w - 3
            local btn = sightexports.sGui:createGuiElement("button", x, y, w, 24, rect)
            sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
            sightexports.sGui:setButtonText(btn, "Munka visszamondása")
            sightexports.sGui:setClickEvent(btn, "tryToEndPaintshopJob")
            setButtonScheme(btn)
            local btn = sightexports.sGui:createGuiElement("button", x + w + 6, y, w, 24, rect)
            sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
            sightexports.sGui:setButtonText(btn, "Autó leszállítása az ügyfélnek")
            sightexports.sGui:setClickEvent(btn, "startPaintshopDeliveryOut")
            setButtonScheme(btn)
          elseif dat.state == "transportIn" then
            local x = (appW - 32) / 2 - w - 3
            local btn = sightexports.sGui:createGuiElement("button", x, y, w, 24, rect)
            sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
            sightexports.sGui:setButtonText(btn, "Munka visszamondása")
            sightexports.sGui:setClickEvent(btn, "tryToEndPaintshopJob")
            setButtonScheme(btn)
            local btn = sightexports.sGui:createGuiElement("button", x + w + 6, y, w, 24, rect)
            sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
            sightexports.sGui:setButtonText(btn, "Autó beszállítása a műhelybe")
            sightexports.sGui:setClickEvent(btn, "startPaintshopDeliveryIn")
            setButtonScheme(btn)
          else
            local btn = sightexports.sGui:createGuiElement("button", 6 + w + 6, y, w, 24, rect)
            sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
            sightexports.sGui:setButtonText(btn, "Munka visszamondása")
            sightexports.sGui:setClickEvent(btn, "tryToEndPaintshopJob")
            setButtonScheme(btn)
          end
        end
      elseif data.emailType == "offer" then
        if data.offerReply and data.offerReply ~= "timeout" then
          local w = (appW - 32 - 12 - 24) / 3
          local y = ih - 30 - 12 - 12 - 24 - 6
          local btn = sightexports.sGui:createGuiElement("button", 6 + w + 6, y, w, 24, rect)
          sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
          sightexports.sGui:setButtonText(btn, "Munka megkezdése")
          sightexports.sGui:setClickEvent(btn, "tryToStartPaintshopJob")
          setButtonScheme(btn)
        elseif not data.playerReplyTime and not data.offerReplyTime then
          local n = #offerPrices
          local w = (appW - 32 - 12 - 6 * (n + 2)) / (n + 1)
          local y = ih - 30 - 12 - 12 - 24 - 6
          for i = 1, n do
            local btn = sightexports.sGui:createGuiElement("button", 6 + (w + 6) * (i - 1), y, w, 24, rect)
            sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
            sightexports.sGui:setButtonText(btn, "Ajánlat: " .. sightexports.sGui:thousandsStepper(math.floor(data.price * offerPrices[i][2])) .. " $")
            sightexports.sGui:setClickEvent(btn, "sendOfferToPaintshopJob")
            setButtonScheme(btn)
            emailReplyButtons[btn] = i
          end
          local btn = sightexports.sGui:createGuiElement("button", 6 + (w + 6) * n, y, w, 24, rect)
          sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
          sightexports.sGui:setButtonText(btn, "Nem érdekel")
          sightexports.sGui:setClickEvent(btn, "sendOfferToPaintshopJob")
          setButtonScheme(btn)
          emailReplyButtons[btn] = false
        end
      end
    end
  else
    emailAppFolderLabels = {}
    local rect = sightexports.sGui:createGuiElement("rectangle", 16, y, 190, 24, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "solid", not seletedEmailCategory and "#c3d9ff" or "#ffffff")
    sightexports.sGui:setGuiHover(rect, "none", false, false, true)
    sightexports.sGui:setGuiHoverable(rect, true)
    sightexports.sGui:setClickEvent(rect, "selectPaintshopEmailCategory")
    local label = sightexports.sGui:createGuiElement("label", 4, 0, 0, 24, rect)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Összes bejövő (" .. overallEmailCount .. ")")
    sightexports.sGui:setLabelFont(label, not seletedEmailCategory and "11/Ubuntu-R.ttf" or "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelColor(label, "#0000d7")
    local rect = sightexports.sGui:createGuiElement("rectangle", 16, y + 24, 190, 24, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "solid", seletedEmailCategory == "Ajánlatok" and "#c3d9ff" or "#ffffff")
    sightexports.sGui:setGuiHover(rect, "none", false, false, true)
    sightexports.sGui:setGuiHoverable(rect, true)
    sightexports.sGui:setClickEvent(rect, "selectPaintshopEmailCategory")
    local label = sightexports.sGui:createGuiElement("label", 4, 0, 0, 24, rect)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Ajánlatok (" .. (emailCategoryCount["Ajánlatok"] or 0) .. ")")
    sightexports.sGui:setLabelFont(label, seletedEmailCategory == "Ajánlatok" and "11/Ubuntu-R.ttf" or "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelColor(label, "#0000d7")
    emailAppFolderElemenets[rect] = "Ajánlatok"
    local rect = sightexports.sGui:createGuiElement("rectangle", 16, y + 48, 190, 24, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "solid", seletedEmailCategory == "Elfogadott ajánlatok" and "#c3d9ff" or "#ffffff")
    sightexports.sGui:setGuiHover(rect, "none", false, false, true)
    sightexports.sGui:setGuiHoverable(rect, true)
    sightexports.sGui:setClickEvent(rect, "selectPaintshopEmailCategory")
    local label = sightexports.sGui:createGuiElement("label", 4, 0, 0, 24, rect)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Elfogadott ajánlatok (" .. (emailCategoryCount["Elfogadott ajánlatok"] or 0) .. ")")
    sightexports.sGui:setLabelFont(label, seletedEmailCategory == "Elfogadott ajánlatok" and "11/Ubuntu-R.ttf" or "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelColor(label, "#0000d7")
    emailAppFolderElemenets[rect] = "Elfogadott ajánlatok"
    local rect = sightexports.sGui:createGuiElement("rectangle", 16, y + 72, 190, 24, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "solid", seletedEmailCategory == "Elvállalt munkák" and "#c3d9ff" or "#ffffff")
    sightexports.sGui:setGuiHover(rect, "none", false, false, true)
    sightexports.sGui:setGuiHoverable(rect, true)
    sightexports.sGui:setClickEvent(rect, "selectPaintshopEmailCategory")
    local label = sightexports.sGui:createGuiElement("label", 4, 0, 0, 24, rect)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Elvállalt munkák (" .. (emailCategoryCount["Elvállalt munkák"] or 0) .. ")")
    sightexports.sGui:setLabelFont(label, seletedEmailCategory == "Elvállalt munkák" and "11/Ubuntu-R.ttf" or "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelColor(label, "#0000d7")
    emailAppFolderElemenets[rect] = "Elvállalt munkák"
    local rect = sightexports.sGui:createGuiElement("rectangle", 16, y + 96, 190, 24, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "solid", seletedEmailCategory == "Értékelések" and "#c3d9ff" or "#ffffff")
    sightexports.sGui:setGuiHover(rect, "none", false, false, true)
    sightexports.sGui:setGuiHoverable(rect, true)
    sightexports.sGui:setClickEvent(rect, "selectPaintshopEmailCategory")
    local label = sightexports.sGui:createGuiElement("label", 4, 0, 0, 24, rect)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Értékelések (" .. (emailCategoryCount["Értékelések"] or 0) .. ")")
    sightexports.sGui:setLabelFont(label, seletedEmailCategory == "Értékelések" and "11/Ubuntu-R.ttf" or "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelColor(label, "#0000d7")
    emailAppFolderElemenets[rect] = "Értékelések"
    local rect = sightexports.sGui:createGuiElement("rectangle", 16, y + 120, 190, 24, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "solid", seletedEmailCategory == "Archívum" and "#c3d9ff" or "#ffffff")
    sightexports.sGui:setGuiHover(rect, "none", false, false, true)
    sightexports.sGui:setGuiHoverable(rect, true)
    sightexports.sGui:setClickEvent(rect, "selectPaintshopEmailCategory")
    local label = sightexports.sGui:createGuiElement("label", 4, 0, 0, 24, rect)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Archívum (" .. (emailCategoryCount["Archívum"] or 0) .. ")")
    sightexports.sGui:setLabelFont(label, seletedEmailCategory == "Archívum" and "11/Ubuntu-R.ttf" or "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelColor(label, "#0000d7")
    emailAppFolderElemenets[rect] = "Archívum"
    local rect = sightexports.sGui:createGuiElement("rectangle", 16, y + 144, 190, 24, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "solid", seletedEmailCategory == "Egyéb" and "#c3d9ff" or "#ffffff")
    sightexports.sGui:setGuiHover(rect, "none", false, false, true)
    sightexports.sGui:setGuiHoverable(rect, true)
    sightexports.sGui:setClickEvent(rect, "selectPaintshopEmailCategory")
    local label = sightexports.sGui:createGuiElement("label", 4, 0, 0, 24, rect)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Egyéb (" .. (emailCategoryCount["Egyéb"] or 0) .. ")")
    sightexports.sGui:setLabelFont(label, seletedEmailCategory == "Egyéb" and "11/Ubuntu-R.ttf" or "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelColor(label, "#0000d7")
    emailAppFolderElemenets[rect] = "Egyéb"
    if seletedEmailCategory == "Archívum" then
      local label = sightexports.sGui:createGuiElement("label", 206, y - 24, appW - 190 - 32, 24, computerAppInside)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "A több mint 36 órája 'Archívum' mappában lévő üzenetek automatikusan törlődnek.")
      sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      sightexports.sGui:setLabelColor(label, "#323232")
    end
    local rect = sightexports.sGui:createGuiElement("rectangle", 206, y, appW - 190 - 32, ih, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "solid", "#c3d9ff")
    local n = 13
    local h = (ih - 16) / n
    local w = appW - 190 - 32 - 16 - 6
    local scrollBar = sightexports.sGui:createGuiElement("rectangle", 214 + w + 4, y + 8, 2, ih - 16, computerAppInside)
    sightexports.sGui:setGuiBackground(scrollBar, "solid", {
      255,
      255,
      255,
      150
    })
    emailScrollBar = sightexports.sGui:createGuiElement("rectangle", 214 + w + 4, y + 8, 2, ih - 16, computerAppInside)
    sightexports.sGui:setGuiBackground(emailScrollBar, "solid", "#7e9ccf")
    emailScrollBarY = y + 8
    emailScrollBarH = ih - 16
    for i = 1, n do
      emailAppRows[i] = {}
      local rect = sightexports.sGui:createGuiElement("rectangle", 214, 8 + y + (i - 1) * h, w, h - 1, computerAppInside)
      sightexports.sGui:setGuiHover(rect, "solid", "#ffffff", false, true)
      sightexports.sGui:setClickEvent(rect, "openPaintshopEmailMessage")
      emailAppRows[i][1] = rect
      local label = sightexports.sGui:createGuiElement("label", 4, 0, 0, h - 1, rect)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelColor(label, "#000000")
      emailAppRows[i][2] = label
      local cat = sightexports.sGui:createGuiElement("rectangle", 4, 2, 0, h - 1 - 4, rect)
      emailAppRows[i][3] = cat
      local label = sightexports.sGui:createGuiElement("label", 4, 0, 0, h - 1, rect)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      emailAppRows[i][4] = label
      local label = sightexports.sGui:createGuiElement("label", 4, 0, 0, h - 1, rect)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelColor(label, "#000000")
      emailAppRows[i][5] = label
      local label = sightexports.sGui:createGuiElement("label", 4, 0, 0, h - 1, rect)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelColor(label, "#989898")
      sightexports.sGui:setLabelClip(label, true)
      emailAppRows[i][6] = label
      local label = sightexports.sGui:createGuiElement("label", 0, 0, w - 4, h - 1, rect)
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      sightexports.sGui:setLabelColor(label, "#000000")
      emailAppRows[i][7] = label
    end
    processEmailAppRows()
  end
  frontComputerScan()
end
addEvent("paintshopOrderFinalize", false)
addEventHandler("paintshopOrderFinalize", getRootElement(), function()
  closePaintshopComputerPrompt()
  triggerLatentServerEvent("tryToOrderPaintshop", localPlayer, orderNum)
  overallOrderSum = 0
  overallOrderNum = 0
  orderNum = {}
  playSound("files/click.mp3")
end)
addEvent("buyPoint", false)
addEventHandler("buyPoint", getRootElement(), function(button, state, absx, absy, el, pointIndex)
  if not getPlayerPermission("buyUpgrade") then
    createErrorPrompt("Pont vásárlás", 400, 150, "Csak a jogosultsággal rendelkező vásárolhat pontot!")
    return
  end
    playSound("files/click.mp3")
    triggerServerEvent("tryToBuyPaintshopPoint", localPlayer, pointIndex)
end)
addEvent("paintshopBuyPoint", false)
addEventHandler("paintshopBuyPoint", getRootElement(), function()
  createPointPrompt("Pont vásárlása", 400, 150 + (2 * 26) + 4)
end)
addEvent("paintshopOrderFinish", false)
addEventHandler("paintshopOrderFinish", getRootElement(), function()
  if not getPlayerPermission("createOrder") then
    sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    return
  end
  if 0 < overallOrderNum then
    if 30 < overallOrderNum then
      createErrorPrompt("Rendelés", 400, 125, "Az utánfutóra maximum 30 karton fér fel!")
    else
      for i = 1, 17 do
        local max = 4 - paintStockData[i][1] - (paintStockData[i][2] and 1 or 0)
        if max < (orderNum[i] or 0) then
          if i == 1 then
            createErrorPrompt("Rendelés", 400, 150, "A(z) 'PRIMER' termékből már csak " .. max .. " karton fér el a raktáradban!")
          elseif i == 2 then
            createErrorPrompt("Rendelés", 400, 150, "A(z) 'BASE' termékből már csak " .. max .. " karton fér el a raktáradban!")
          elseif i == 3 then
            createErrorPrompt("Rendelés", 400, 150, "A(z) 'METALIC BASE' termékből már csak " .. max .. " karton fér el a raktáradban!")
          else
            createErrorPrompt("Rendelés", 400, 150, "A(z) '" .. colorNames[i - 3] .. "' termékből már csak " .. max .. " karton fér el a raktáradban!")
          end
          return
        end
      end
      overallOrderSum = 0
      for i = 1, 17 do
        if (orderNum[i] or 0) <= 0 then
          orderNum[i] = nil
        else
          overallOrderSum = overallOrderSum + orderNum[i] * paintPrices[i]
        end
      end
      createYesNoPrompt("Rendelés", 400, 125, "Biztosan szeretnéd leadni a rendelést? Összérték: " .. sightexports.sGui:thousandsStepper(overallOrderSum) .. " $", "paintshopOrderFinalize")
    end
  end
end)
addEvent("paintshopOrderChangeNum", false)
addEventHandler("paintshopOrderChangeNum", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if not getPlayerPermission("createOrder") then
    sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    return
  end
  for i = 1, #orderElements do
    if el == orderElements[i][2] then
      if 0 < (orderNum[i] or 0) then
        orderNum[i] = (orderNum[i] or 0) - 1
        overallOrderNum = overallOrderNum - 1
        overallOrderSum = overallOrderSum - paintPrices[i]
        sightexports.sGui:setLabelText(orderElements[i][1], orderNum[i])
        sightexports.sGui:setLabelText(orderOverallLabel, "Rendelés összértéke: " .. sightexports.sGui:thousandsStepper(overallOrderSum) .. " $\nUtánfutó: " .. overallOrderNum .. "/30")
        playSound("files/click.mp3")
        return
      end
    elseif el == orderElements[i][3] then
      local max = 4 - paintStockData[i][1] - (paintStockData[i][2] and 1 or 0)
      if max > (orderNum[i] or 0) then
        orderNum[i] = (orderNum[i] or 0) + 1
        overallOrderNum = overallOrderNum + 1
        overallOrderSum = overallOrderSum + paintPrices[i]
        sightexports.sGui:setLabelText(orderElements[i][1], orderNum[i])
        sightexports.sGui:setLabelText(orderOverallLabel, "Rendelés összértéke: " .. sightexports.sGui:thousandsStepper(overallOrderSum) .. " $\nUtánfutó: " .. overallOrderNum .. "/30")
        playSound("files/click.mp3")
        return
      end
    end
  end
end)
addEvent("openPaintshopHomeWebpage", false)
addEventHandler("openPaintshopHomeWebpage", getRootElement(), function()
  openedWebsite = false
  createInternetWindow()
  playSound("files/click.mp3")
end)
addEvent("openPaintshopOrderWebpage", false)
addEventHandler("openPaintshopOrderWebpage", getRootElement(), function()
  openedWebsite = "paint"
  createInternetWindow()
  playSound("files/click.mp3")
end)
addEvent("openPaintshopUpgradeWebpage", false)
addEventHandler("openPaintshopUpgradeWebpage", getRootElement(), function()
  openedWebsite = "upgrade"
  createInternetWindow()
  playSound("files/click.mp3")
end)
addEvent("openPaintshopCompanyWebpage", false)
addEventHandler("openPaintshopCompanyWebpage", getRootElement(), function()
  openedWebsite = "company"
  createInternetWindow()
  playSound("files/click.mp3")
end)
addEvent("finalEditPaintshopCompanyName", false)
addEventHandler("finalEditPaintshopCompanyName", getRootElement(), function()
  local val = sightexports.sGui:getInputValue(computerPromptInput)
  if val and utf8.len(val) > 0 and utf8.len(val) <= 32 then
    workshopRented.name = val
    triggerServerEvent("renamePaintshopWorkshop", localPlayer, val)
    openedWebsite = "company"
    createInternetWindow()
    playSound("files/click.mp3")
  end
end)
addEvent("editPaintshopCompanyName", false)
addEventHandler("editPaintshopCompanyName", getRootElement(), function()
  if not getPlayerPermission("owner") then
    sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    return
  end
  createInputPrompt("Cégjegyzék", 400, 150, "Add meg a cégnevet!", "finalEditPaintshopCompanyName")
  sightexports.sGui:setInputMaxLength(computerPromptInput, 32)
  sightexports.sGui:setInputValue(computerPromptInput, workshopRented.name)
end)
addEvent("finalFirePaintshopPlayer", false)
addEventHandler("finalFirePaintshopPlayer", getRootElement(), function()
  closePaintshopComputerPrompt()
  if foundPlayer and workshopPermissions[foundPlayer] then
    triggerServerEvent("firePaintshopPlayer", localPlayer, foundPlayer)
  end
  playSound("files/click.mp3")
  foundPlayer = false
end)
addEvent("tryToFirePaintshopPlayer", false)
addEventHandler("tryToFirePaintshopPlayer", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if fireButtons[el] and workshopPermissions[fireButtons[el]] then
    if not getPlayerPermission("owner") then
      sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
      return
    end
    foundPlayer = fireButtons[el]
    createYesNoPrompt("Cégjegyzék", 400, 135, "Biztosan kirúgod:\n" .. workshopPermissions[foundPlayer].name, "finalFirePaintshopPlayer")
  end
end)
addEvent("finalPaintshopAddPlayer", false)
addEventHandler("finalPaintshopAddPlayer", getRootElement(), function()
  closePaintshopComputerPrompt()
  if foundPlayer then
    local cid = getElementData(foundPlayer, "char.ID")
    if workshopPermissions[cid] then
      createErrorPrompt("Cégjegyzék", 400, 125, "Ő már alkalmazottad!")
      return
    end
    triggerServerEvent("paintshopTryToAddPlayer", localPlayer, foundPlayer)
  end
  playSound("files/click.mp3")
  foundPlayer = false
end)

local currentBuyingLevel = 0
addEvent("paintshopUpgrade", false) --Fejlesztés upgrade event.
addEventHandler("paintshopUpgrade", getRootElement(), function(_, _, _, _, _, clickArgument)
  currentBuyingLevel = clickArgument[3]
  createYesNoPrompt("Fejlesztés", 400, 135, "Biztosan megvásárlod ezt a fejlesztést?\n" .. clickArgument[2] .. " - " .. sightexports.sGui:thousandsStepper(clickArgument[1]) .. " Pont", "finalPaintshopBuyUpgrade")
end)
addEvent("finalPaintshopBuyUpgrade", false)
addEventHandler("finalPaintshopBuyUpgrade", getRootElement(), function()
  if not getPlayerPermission("buyUpgrade") then
    createErrorPrompt("Fejlesztés vásárlás", 400, 150, "Csak a jogosultsággal rendelkező vásárolhat pontot!")
    return
  end
  triggerServerEvent("tryToBuyPaintshopUpgrade", localPlayer, currentBuyingLevel)
  playSound("files/click.mp3")
  currentBuyingLevel = 0
end)
addEvent("workshopPointBuyResponse", true)
addEventHandler("workshopPointBuyResponse", getRootElement(), function(ws, state)
  if ws and currentWorkshop == ws then
    if state then
      closePaintshopComputerPrompt()
      exports.sGui:showInfobox("s", "Sikeresen megvásároltad a pontokat a fényezőműhelyhez!")
    else
    closePaintshopComputerPrompt()
    exports.sGui:showInfobox("e", "Nem sikerült megvásárolnod a pontokat a fényezőműhelyhez!")
    end
  end
end)

addEvent("gotPaintshopUpgradeBuy", true)
addEventHandler("gotPaintshopUpgradeBuy", getRootElement(), function(state)
  if state then
    closePaintshopComputerPrompt()
    exports.sGui:showInfobox("s", "Sikeresen megvásároltál egy fejlesztést a fényezőműhelyhez!")
  else
    closePaintshopComputerPrompt()
    exports.sGui:showInfobox("e", "Nem sikerült megvásárolni a fejlesztést a fényezőműhelyhez!")
  end
end)
addEvent("finalPaintshopTryToAddPlayer", false)
addEventHandler("finalPaintshopTryToAddPlayer", getRootElement(), function()
  foundPlayer = false
  local val = sightexports.sGui:getInputValue(computerPromptInput)
  if val and utf8.len(val) > 0 then
    local players = getElementsByType("player")
    if tonumber(val) then
      val = tonumber(val)
      for i = 1, #players do
        if getElementData(players[i], "playerID") == val then
          if getElementData(players[i], "loggedIn") then
            foundPlayer = players[i]
          end
          break
        end
      end
    else
      val = utf8.lower(val):gsub("_", " ")
      for i = 1, #players do
        local name = getElementData(players[i], "visibleName")
        if name then
          name = utf8.lower(name):gsub("_", " ")
          if utf8.find(name, val) and getElementData(players[i], "loggedIn") then
            if foundPlayer then
              createErrorPrompt("Cégjegyzék", 400, 125, "Nincs találat!")
              return
            end
            foundPlayer = players[i]
          end
        end
      end
    end
    if foundPlayer == localPlayer then
      createErrorPrompt("Cégjegyzék", 400, 125, "Magadat nem veheted fel alkalmazottnak!")
    elseif foundPlayer then
      local cid = getElementData(foundPlayer, "char.ID")
      if workshopPermissions[cid] then
        createErrorPrompt("Cégjegyzék", 400, 125, "Ő már alkalmazottad!")
        return
      end
      createYesNoPrompt("Cégjegyzék", 400, 135, "Biztosan felveszed alkalmazottnak:\n" .. getElementData(foundPlayer, "visibleName"):gsub("_", " "), "finalPaintshopAddPlayer")
    else
      createErrorPrompt("Cégjegyzék", 400, 125, "Nincs találat!")
    end
  end
end)
addEvent("paintshopTryToAddPlayer", false)
addEventHandler("paintshopTryToAddPlayer", getRootElement(), function()
  if not getPlayerPermission("owner") then
    sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    return
  end
  foundPlayer = false
  createInputPrompt("Alkalmazott felvétele", 400, 150, "Add meg az alkalmazott nevét!", "finalPaintshopTryToAddPlayer")
  sightexports.sGui:setInputPlaceholder(computerPromptInput, "Név / ID")
  sightexports.sGui:setInputMaxLength(computerPromptInput, 48)
end)
addEvent("togglePaintshopPermissionValue", false)
addEventHandler("togglePaintshopPermissionValue", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if not getPlayerPermission("owner") then
    sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    return
  end
  if permissionButtons[el] then
    local cid = permissionButtons[el][1]
    local k = permissionButtons[el][2]
    local val = false
    if unsyncedPermissionData[cid] and type(unsyncedPermissionData[cid][k]) == "boolean" then
      val = unsyncedPermissionData[cid][k]
    else
      val = workshopPermissions[cid][k]
    end
    val = not val
    if not unsyncedPermissionData[cid] then
      unsyncedPermissionData[cid] = {}
    end
    unsyncedPermissionData[cid][k] = val
    permissionDataToSync = 1000
    if val then
      sightexports.sGui:setButtonIcon(el, sightexports.sGui:getFaIconFilename("check", 24, "solid"))
      sightexports.sGui:setButtonText(el, false)
    else
      sightexports.sGui:setButtonIcon(el, false)
      sightexports.sGui:setButtonText(el, "")
    end
    playSound("files/click.mp3")
  end
end)

function createInternetWindow()
  closePaintshopComputerPrompt()
  openedComputerApp = "internet"
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  if computerApp then
    sightexports.sGui:deleteGuiElement(computerApp)
  end
  computerApp = sightexports.sGui:createGuiElement("rectangle", 2, titleBarHeight + 2, 1024, 544, computerWindow)
  sightexports.sGui:setGuiBackground(computerApp, "solid", computerColorScheme.blue)
  local rect = sightexports.sGui:createGuiElement("rectangle", 40, 544, 32, 32, computerApp)
  sightexports.sGui:setGuiBackground(rect, "solid", computerColorScheme.blue)
  local icon = sightexports.sGui:createGuiElement("image", 0, 0, 32, 32, rect)
  sightexports.sGui:setImageFile(icon, ":sPaintshop/files/internet.dds")
  local label = sightexports.sGui:createGuiElement("label", 4, 0, 0, 24, computerApp)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "Internet")
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  local icon = sightexports.sGui:createGuiElement("image", 1000, 0, 24, 24, computerApp)
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("times", 24))
  sightexports.sGui:setGuiHover(icon, "solid", "sightred")
  sightexports.sGui:setGuiHoverable(icon, true)
  sightexports.sGui:setClickEvent(icon, "openPaintshopComputerDesktop")
  local appW = 1020
  local appH = 518
  computerAppInside = sightexports.sGui:createGuiElement("rectangle", 2, 24, appW, appH, computerApp)
  sightexports.sGui:setGuiBackground(computerAppInside, "solid", "#ffffff")
  local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, appW, 30, computerAppInside)
  sightexports.sGui:setGuiBackground(rect, "solid", computerColorScheme.window)
  local btn = sightexports.sGui:createGuiElement("button", 3, 3, 24, 24, rect)
  sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("home", 24))
  sightexports.sGui:setClickEvent(btn, "openPaintshopHomeWebpage")
  setButtonScheme(btn)
  local rect = sightexports.sGui:createGuiElement("rectangle", 30, 3, appW - 24 - 9, 24, computerAppInside)
  sightexports.sGui:setGuiBackground(rect, "solid", computerColorScheme.btn1)
  sightexports.sGui:setGuiBackgroundBorder(rect, 1, "#000000")
  local btm = sightexports.sGui:createGuiElement("rectangle", 0, 30, appW, 1, computerAppInside)
  sightexports.sGui:setGuiBackground(btm, "solid", computerColorScheme.window2)
  local label = sightexports.sGui:createGuiElement("label", 3, 0, 0, 24, rect)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelColor(label, "#000000")
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  if openedWebsite == "company" then
    sightexports.sGui:setLabelText(label, "https://compreg.gov.sight/")
    local rect = sightexports.sGui:createGuiElement("rectangle", 0, 31, appW, 64, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "gradient", {"#29ccc4", "#0aa49c"})
    local image = sightexports.sGui:createGuiElement("image", 6, 5.5, 115, 53, rect)
    sightexports.sGui:setImageFile(image, ":sPaintshop/files/logo2.dds")
    orderOverallLabel = sightexports.sGui:createGuiElement("label", 0, 0, appW - 32 - 12, 64, rect)
    sightexports.sGui:setLabelAlignment(orderOverallLabel, "right", "center")
    sightexports.sGui:setLabelText(orderOverallLabel, "Bejelentkezve mint:\n" .. workshopRented.name)
    sightexports.sGui:setLabelFont(orderOverallLabel, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelColor(orderOverallLabel, "#000000")
    local btn = sightexports.sGui:createGuiElement("button", appW - 32 - 6, 16, 32, 32, rect)
    sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("pen", 32))
    sightexports.sGui:setClickEvent(btn, "editPaintshopCompanyName")
    setButtonScheme(btn)
    local y = 95
    local label = sightexports.sGui:createGuiElement("label", 8, y, w, 32, computerAppInside)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, "#000000")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelText(label, "Cégvezető: ")
    local label = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(label), y, w, 32, computerAppInside)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, "#000000")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelText(label, workshopRented.ownerName)
    y = y + 32
    local label = sightexports.sGui:createGuiElement("label", 8, y, w, 32, computerAppInside)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, "#000000")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelText(label, "Alkalmazottak ")
    local label = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(label), y, w, 32, computerAppInside)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, "#000000")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    local charList = false
    local w = 0
    if workshopPermissions then
      charList = {}
      for i, d in pairs(workshopPermissions) do
        table.insert(charList, i)
        w = math.max(w, sightexports.sGui:getTextWidthFont(d.name, "10/Ubuntu-R.ttf"))
      end
    end
    sightexports.sGui:setLabelText(label, "(" .. (charList and #charList or 0) .. "/" .. maxPermissionPlayers .. ")")
    y = y + 32 + 8
    local h = (appH - y - 8) / maxPermissionPlayers
    w = w + 8 + h
    local j = 1
    local iw = (appW - 16 - w) / #permissionList
    permissionButtons = {}
    fireButtons = {}
    for i = 1, maxPermissionPlayers do
      local rect = sightexports.sGui:createGuiElement("rectangle", 8, y + (i - 1) * h, appW - 16, h, computerAppInside)
      sightexports.sGui:setGuiBackground(rect, "solid", i % 2 == 0 and "#e4f5f4" or "#f0f7f7")
      if charList and i <= #charList then
        local cid = charList[j]
        if cid then
          local btn = sightexports.sGui:createGuiElement("button", 12, y + (j - 1) * h + 4, h - 8, h - 8, computerAppInside)
          sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
          sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("user-times", h - 8))
          sightexports.sGui:setClickEvent(btn, "tryToFirePaintshopPlayer")
          sightexports.sGui:guiSetTooltip(btn, "Kirúgás", "right")
          setButtonScheme(btn)
          fireButtons[btn] = cid
          local label = sightexports.sGui:createGuiElement("label", 8 + h, y + (j - 1) * h, w, h, computerAppInside)
          sightexports.sGui:setLabelAlignment(label, "left", "center")
          sightexports.sGui:setLabelColor(label, "#000000")
          sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
          sightexports.sGui:setLabelText(label, workshopPermissions[cid].name:gsub("_", " "))
          for k = 1, #permissionList do
            local btn = sightexports.sGui:createGuiElement("button", w + k * iw - (h - 8), y + (j - 1) * h + 4, h - 8, h - 8, computerAppInside)
            sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
            sightexports.sGui:setClickEvent(btn, "togglePaintshopPermissionValue")
            local val = false
            if unsyncedPermissionData[cid] and type(unsyncedPermissionData[cid][k]) == "boolean" then
              val = unsyncedPermissionData[cid][k]
            else
              val = workshopPermissions[cid][k]
            end
            if val then
              sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("check", 24, "solid"))
              sightexports.sGui:setButtonText(btn, false)
            else
              sightexports.sGui:setButtonIcon(btn, false)
              sightexports.sGui:setButtonText(btn, "")
            end
            sightexports.sGui:guiSetTooltip(btn, permissionList[k][2], k > #permissionList / 4 and "left" or "right")
            setButtonScheme(btn)
            permissionButtons[btn] = {cid, k}
          end
        end
        j = j + 1
      end
    end
    if j <= maxPermissionPlayers then
      local btn = sightexports.sGui:createGuiElement("button", 12, y + (j - 1) * h + 4, h - 8 + sightexports.sGui:getTextWidthFont("Alkalmazott felvétele", "10/Ubuntu-R.ttf") + 8, h - 8, computerAppInside)
      sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
      sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("plus", h - 8))
      sightexports.sGui:setButtonText(btn, " Alkalmazott felvétele")
      sightexports.sGui:setClickEvent(btn, "paintshopTryToAddPlayer")
      setButtonScheme(btn)
    end
  elseif openedWebsite == "upgrade" then
    updatedItems = {}
    sightexports.sGui:setLabelText(label, "https://upgrade-workshop.sight/upgrade.php")
    local rect = sightexports.sGui:createGuiElement("rectangle", 0, 31, appW, 64, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "gradient", {"#e1781d", "#c64900"})
    local image = sightexports.sGui:createGuiElement("image", 6, 5.5, 115, 53, rect)
    sightexports.sGui:setImageFile(image, dxCreateTexture(":sPaintshop/files/logo3.png"))

    playerWorkshopPoints = sightexports.sGui:createGuiElement("label", 0, 0, appW - 32 - 12, 64, rect)
    sightexports.sGui:setLabelAlignment(playerWorkshopPoints, "right", "center")
    sightexports.sGui:setLabelText(playerWorkshopPoints, "Vásárolj pontot!\nElérhető pontok: "..sightexports.sGui:thousandsStepper(tonumber(workshopPoints or 0)).."")
    sightexports.sGui:setLabelFont(playerWorkshopPoints, "11/Ubuntu-R.ttf")
    local btn = sightexports.sGui:createGuiElement("button", appW - 32 - 6, 16, 32, 32, rect)
    sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("chevron-right", 32))
    sightexports.sGui:setClickEvent(btn, "paintshopBuyPoint")
    sightexports.sGui:guiSetTooltip(btn, "Pontok vásárlása", "right")
    setButtonScheme(btn)

    local y = 100
    local upgradeHeight = 64.5
    for i = 1, #possibleUpgrades do
        local rect = sightexports.sGui:createGuiElement("rectangle", 10, y, appW - 20, upgradeHeight, computerAppInside)
        sightexports.sGui:setGuiBackground(rect, "solid", computerColorScheme.btn1)
        sightexports.sGui:setGuiBackgroundBorder(rect, 1, computerColorScheme.window2)

        local label = sightexports.sGui:createGuiElement("label", 10, -10, appW - 20, upgradeHeight, rect)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelColor(label, "#000000")
        sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
        sightexports.sGui:setLabelText(label, possibleUpgrades[i].label)
        
        local label = sightexports.sGui:createGuiElement("label", 10, 10, appW - 20, upgradeHeight, rect)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelColor(label, "#797979")
        sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
        sightexports.sGui:setLabelText(label, possibleUpgrades[i].description)

        local currentLevel = workshopUpgrades[i] 

        local btn = sightexports.sGui:createGuiElement("button", appW - sightexports.sGui:getTextWidthFont("Fejlesztés", "10/Ubuntu-R.ttf") - 24 - 30, 21, sightexports.sGui:getTextWidthFont("Fejlesztés", "10/Ubuntu-R.ttf") + 24, 24, rect)
        sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
        sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("plus", 16))
        sightexports.sGui:setButtonText(btn, "Fejlesztés")
        if currentLevel >= 5 then
          sightexports.sGui:setGuiHoverable(btn, false)
          sightexports.sGui:guiSetTooltip(btn, "Elérted a maximális szintet!", "right")
        else
          sightexports.sGui:guiSetTooltip(btn, sightexports.sGui:thousandsStepper(possibleUpgrades[i].levelPrice[currentLevel + 1]).." Pont", "right")
          sightexports.sGui:setClickEvent(btn, "paintshopUpgrade")
      		sightexports.sGui:setClickArgument(btn, {possibleUpgrades[i].levelPrice[currentLevel + 1], possibleUpgrades[i].label, i})
        end
        setButtonScheme(btn)

        for l = 1, 5 do
          local levelX = (appW - sightexports.sGui:getTextWidthFont("Fejlesztés", "10/Ubuntu-R.ttf") - 24 - 110) - (80 * (5 - l))
          local level = sightexports.sGui:createGuiElement("button", levelX, 21, 75, 24, rect)

          if currentLevel >= l then
            sightexports.sGui:setGuiBackground(level, "gradient", {"#e1781d", "#c64900"})
          else
            sightexports.sGui:setGuiBackground(level, "solid", computerColorScheme.btn1)
          end

          sightexports.sGui:setGuiBackgroundBorder(level, 1, computerColorScheme.window2)
          sightexports.sGui:setGuiHover(level, "none", false, false, true)
          sightexports.sGui:setGuiHoverable(level, true)
          sightexports.sGui:guiSetTooltip(level, possibleUpgrades[i].levelAmount[l] .. "%", "right")
        end
        y = y + upgradeHeight + 5
    end
  elseif openedWebsite == "paint" then
    sightexports.sGui:setLabelText(label, "https://miguitalia.sight/order/")
    local rect = sightexports.sGui:createGuiElement("rectangle", 0, 31, appW, 64, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "gradient", {"#b6382d", "#7c070a"})
    local image = sightexports.sGui:createGuiElement("image", 6, 5.5, 115, 53, rect)
    sightexports.sGui:setImageFile(image, ":sPaintshop/files/logo.dds")
    if workshopOrder then
      local label = sightexports.sGui:createGuiElement("label", 0, 95, appW, 48, computerAppInside)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelColor(label, "#000000")
      sightexports.sGui:setLabelFont(label, "13/Ubuntu-R.ttf")
      sightexports.sGui:setLabelText(label, "Köszönjük rendelésed!")
      local y = 149
      local h = (appH - y - 6) / 19
      local w = (appW - 24) / 6
      local sum = 0
      local btm = sightexports.sGui:createGuiElement("rectangle", 12, y + h - 1, appW - 24, 1, computerAppInside)
      sightexports.sGui:setGuiBackground(btm, "solid", computerColorScheme.window2)
      local label = sightexports.sGui:createGuiElement("label", 12, y, w * 2, h, computerAppInside)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelColor(label, "#000000")
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelText(label, "Megnevezés")
      local label = sightexports.sGui:createGuiElement("label", 12 + w * 2, y, w, h, computerAppInside)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelColor(label, "#000000")
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelText(label, "Egységár")
      local label = sightexports.sGui:createGuiElement("label", 12 + w * 3, y, w, h, computerAppInside)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelColor(label, "#000000")
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelText(label, "Mennyiség")
      local label = sightexports.sGui:createGuiElement("label", 12 + w * 4, y, w, h, computerAppInside)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelColor(label, "#000000")
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelText(label, "Mennyiségi egység")
      local label = sightexports.sGui:createGuiElement("label", 12 + w * 5, y, w, h, computerAppInside)
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      sightexports.sGui:setLabelColor(label, "#000000")
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelText(label, "Érték")
      y = y + h
      for i = 1, 17 do
        if workshopOrder[i] and 0 < workshopOrder[i] then
          local btm = sightexports.sGui:createGuiElement("rectangle", 12, y + h - 1, appW - 24, 1, computerAppInside)
          sightexports.sGui:setGuiBackground(btm, "solid", computerColorScheme.window2)
          local label = sightexports.sGui:createGuiElement("label", 12, y, w * 2, h, computerAppInside)
          sightexports.sGui:setLabelAlignment(label, "left", "center")
          sightexports.sGui:setLabelColor(label, "#000000")
          sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
          if i == 1 then
            sightexports.sGui:setLabelText(label, "PRIMER festék karton")
          elseif i == 2 then
            sightexports.sGui:setLabelText(label, "BASE festék karton")
          elseif i == 3 then
            sightexports.sGui:setLabelText(label, "METALIC BASE festék karton")
          else
            sightexports.sGui:setLabelText(label, colorNames[i - 3] .. " pigment karton")
          end
          local label = sightexports.sGui:createGuiElement("label", 12 + w * 2, y, w, h, computerAppInside)
          sightexports.sGui:setLabelAlignment(label, "left", "center")
          sightexports.sGui:setLabelColor(label, "#000000")
          sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
          sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(paintPrices[i]) .. " $")
          local label = sightexports.sGui:createGuiElement("label", 12 + w * 3, y, w, h, computerAppInside)
          sightexports.sGui:setLabelAlignment(label, "left", "center")
          sightexports.sGui:setLabelColor(label, "#000000")
          sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
          sightexports.sGui:setLabelText(label, workshopOrder[i])
          local label = sightexports.sGui:createGuiElement("label", 12 + w * 4, y, w, h, computerAppInside)
          sightexports.sGui:setLabelAlignment(label, "left", "center")
          sightexports.sGui:setLabelColor(label, "#000000")
          sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
          if i <= 1 then
            sightexports.sGui:setLabelText(label, "Karton (1 kaz.)")
          else
            sightexports.sGui:setLabelText(label, "Karton (4 kaz.)")
          end
          local label = sightexports.sGui:createGuiElement("label", 12 + w * 5, y, w, h, computerAppInside)
          sightexports.sGui:setLabelAlignment(label, "right", "center")
          sightexports.sGui:setLabelColor(label, "#000000")
          sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
          local price = paintPrices[i] * workshopOrder[i]
          sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(price) .. " $")
          sum = sum + price
          y = y + h
        end
      end
      local label = sightexports.sGui:createGuiElement("label", 12 + w * 5, y, w, h, computerAppInside)
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      sightexports.sGui:setLabelColor(label, "#000000")
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      sightexports.sGui:setLabelText(label, "Összesen: " .. sightexports.sGui:thousandsStepper(sum) .. " $")
    else
      orderOverallLabel = sightexports.sGui:createGuiElement("label", 0, 0, appW - 32 - 12, 64, rect)
      sightexports.sGui:setLabelAlignment(orderOverallLabel, "right", "center")
      sightexports.sGui:setLabelText(orderOverallLabel, "Rendelés összértéke: " .. sightexports.sGui:thousandsStepper(overallOrderSum) .. " $\nUtánfutó: " .. overallOrderNum .. "/30")
      sightexports.sGui:setLabelFont(orderOverallLabel, "11/Ubuntu-R.ttf")
      local btn = sightexports.sGui:createGuiElement("button", appW - 32 - 6, 16, 32, 32, rect)
      sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("chevron-right", 32))
      sightexports.sGui:setClickEvent(btn, "paintshopOrderFinish")
      sightexports.sGui:guiSetTooltip(btn, "Rendelés leadása", "right")
      setButtonScheme(btn)
      local y = 95
      appH = appH - y
      local h = appH / 3
      local w = appW / 7
      local b = w * 0.19999999999999996 / 2
      w = w - b / 7
      local w2 = appW / 3
      for i = 1, 3 do
        orderElements[i] = {}
        local x = w2 * (i - 1 + 0.5) - w / 2
        local y = y + h / 2 - (w * 0.4 + 24 + 24) / 2
        local rect = sightexports.sGui:createGuiElement("rectangle", x + w / 2 - w * 1.2 / 2 - 6, y - 6, w * 1.2 + 12, w * 0.4 + 24 + 24 + 12, computerAppInside)
        sightexports.sGui:setGuiBackground(rect, "solid", computerColorScheme.btn1)
        sightexports.sGui:setGuiBackgroundBorder(rect, 1, computerColorScheme.window2)
        local image = sightexports.sGui:createGuiElement("image", x + w / 2 - w * 0.4 / 2, y, w * 0.4, w * 0.4, computerAppInside)
        sightexports.sGui:setImageFile(image, ":sPaintshop/files/box.dds")
        local image = sightexports.sGui:createGuiElement("image", x + w / 2 - w * 0.3 / 2, y + w * 0.4 / 2 - w * 0.3 / 4, w * 0.3, w * 0.3 / 2, computerAppInside)
        y = y + w * 0.4
        local label = sightexports.sGui:createGuiElement("label", x, y, w, 24, computerAppInside)
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelColor(label, "#000000")
        sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        if i == 1 then
          sightexports.sGui:setImageFile(image, colorPrimerTexture)
          sightexports.sGui:setLabelText(label, "PRIMER (" .. paintPrices[i] .. "$)")
        elseif i == 2 then
          sightexports.sGui:setImageFile(image, colorBaseTextures[1])
          sightexports.sGui:setLabelText(label, "BASE (" .. paintPrices[i] .. "$)")
        elseif i == 3 then
          sightexports.sGui:setImageFile(image, colorBaseTextures[2])
          sightexports.sGui:setLabelText(label, "METALIC BASE (" .. paintPrices[i] .. "$)")
        end
        local label = sightexports.sGui:createGuiElement("label", x, y + 24, w, 24, computerAppInside)
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelText(label, orderNum[i] or 0)
        sightexports.sGui:setLabelColor(label, "#000000")
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        orderElements[i][1] = label
        local btn = sightexports.sGui:createGuiElement("button", x + w / 2 - 30 - 12, y + 24, 24, 24, computerAppInside)
        sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
        sightexports.sGui:setButtonText(btn, "-")
        sightexports.sGui:setClickEvent(btn, "paintshopOrderChangeNum")
        setButtonScheme(btn)
        orderElements[i][2] = btn
        local btn = sightexports.sGui:createGuiElement("button", x + w / 2 + 30 - 12, y + 24, 24, 24, computerAppInside)
        sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
        sightexports.sGui:setButtonText(btn, "+")
        sightexports.sGui:setClickEvent(btn, "paintshopOrderChangeNum")
        setButtonScheme(btn)
        orderElements[i][3] = btn
      end
      y = y + h
      for i = 1, 7 do
        orderElements[3 + i] = {}
        local x = w * (i - 1) + b / 2
        local y = y + h / 2 - (w * 0.4 + 24 + 24) / 2
        local rect = sightexports.sGui:createGuiElement("rectangle", x + w / 2 - w * 0.8 / 2 - 6, y - 6, w * 0.8 + 12, w * 0.4 + 24 + 24 + 12, computerAppInside)
        sightexports.sGui:setGuiBackground(rect, "solid", computerColorScheme.btn1)
        sightexports.sGui:setGuiBackgroundBorder(rect, 1, computerColorScheme.window2)
        local image = sightexports.sGui:createGuiElement("image", x + w / 2 - w * 0.4 / 2, y, w * 0.4, w * 0.4, computerAppInside)
        sightexports.sGui:setImageFile(image, ":sPaintshop/files/box.dds")
        local image = sightexports.sGui:createGuiElement("image", x + w / 2 - w * 0.25 / 2, y + w * 0.4 / 2 - w * 0.25 / 2, w * 0.25, w * 0.25, computerAppInside)
        sightexports.sGui:setImageFile(image, colorPaletteTextures[i])
        y = y + w * 0.4
        local label = sightexports.sGui:createGuiElement("label", x, y, w, 24, computerAppInside)
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelText(label, colorNames[i] .. " (" .. paintPrices[3 + i] .. "$)")
        sightexports.sGui:setLabelColor(label, "#000000")
        sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        local label = sightexports.sGui:createGuiElement("label", x, y + 24, w, 24, computerAppInside)
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelText(label, orderNum[3 + i] or 0)
        sightexports.sGui:setLabelColor(label, "#000000")
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        orderElements[3 + i][1] = label
        local btn = sightexports.sGui:createGuiElement("button", x + w / 2 - 30 - 12, y + 24, 24, 24, computerAppInside)
        sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
        sightexports.sGui:setButtonText(btn, "-")
        sightexports.sGui:setClickEvent(btn, "paintshopOrderChangeNum")
        setButtonScheme(btn)
        orderElements[3 + i][2] = btn
        local btn = sightexports.sGui:createGuiElement("button", x + w / 2 + 30 - 12, y + 24, 24, 24, computerAppInside)
        sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
        sightexports.sGui:setButtonText(btn, "+")
        sightexports.sGui:setClickEvent(btn, "paintshopOrderChangeNum")
        setButtonScheme(btn)
        orderElements[3 + i][3] = btn
      end
      y = y + h
      for i = 1, 7 do
        orderElements[10 + i] = {}
        local x = w * (i - 1) + b / 2
        local y = y + h / 2 - (w * 0.4 + 24 + 24) / 2
        local rect = sightexports.sGui:createGuiElement("rectangle", x + w / 2 - w * 0.8 / 2 - 6, y - 6, w * 0.8 + 12, w * 0.4 + 24 + 24 + 12, computerAppInside)
        sightexports.sGui:setGuiBackground(rect, "solid", computerColorScheme.btn1)
        sightexports.sGui:setGuiBackgroundBorder(rect, 1, computerColorScheme.window2)
        local image = sightexports.sGui:createGuiElement("image", x + w / 2 - w * 0.4 / 2, y, w * 0.4, w * 0.4, computerAppInside)
        sightexports.sGui:setImageFile(image, ":sPaintshop/files/box.dds")
        local image = sightexports.sGui:createGuiElement("image", x + w / 2 - w * 0.25 / 2, y + w * 0.4 / 2 - w * 0.25 / 2, w * 0.25, w * 0.25, computerAppInside)
        sightexports.sGui:setImageFile(image, colorPaletteTextures[7 + i])
        y = y + w * 0.4
        local label = sightexports.sGui:createGuiElement("label", x, y, w, 24, computerAppInside)
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelText(label, colorNames[7 + i] .. " (" .. paintPrices[10 + i] .. "$)")
        sightexports.sGui:setLabelColor(label, "#000000")
        sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
        local label = sightexports.sGui:createGuiElement("label", x, y + 24, w, 24, computerAppInside)
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelText(label, orderNum[10 + i] or 0)
        sightexports.sGui:setLabelColor(label, "#000000")
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        orderElements[10 + i][1] = label
        local btn = sightexports.sGui:createGuiElement("button", x + w / 2 - 30 - 12, y + 24, 24, 24, computerAppInside)
        sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
        sightexports.sGui:setButtonText(btn, "-")
        sightexports.sGui:setClickEvent(btn, "paintshopOrderChangeNum")
        setButtonScheme(btn)
        orderElements[10 + i][2] = btn
        local btn = sightexports.sGui:createGuiElement("button", x + w / 2 + 30 - 12, y + 24, 24, 24, computerAppInside)
        sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
        sightexports.sGui:setButtonText(btn, "+")
        sightexports.sGui:setClickEvent(btn, "paintshopOrderChangeNum")
        setButtonScheme(btn)
        orderElements[10 + i][3] = btn
      end
    end
  else
    sightexports.sGui:setLabelText(label, "https://homehub.sight/")
    local h = (appH - 30 - 96) / 4
    local y = 48
    local image = sightexports.sGui:createGuiElement("image", appW / 2 - 186, y + h / 2 - 26, 372, 52, computerAppInside)
    sightexports.sGui:setImageFile(image, ":sPaintshop/files/homehublogo.dds")
    y = y + h
    local w = 193
    w = math.max(72 + sightexports.sGui:getTextWidthFont("Üdvözlünk " .. workshopRented.name .. "!", "11/Ubuntu-R.ttf"), w)
    w = math.max(72 + sightexports.sGui:getTextWidthFont("SightBack értékelések: " .. workshopRatingNum, "11/Ubuntu-L.ttf"), w)
    local image = sightexports.sGui:createGuiElement("image", appW / 2 - w / 2, y + h / 2 - 32, 64, 64, computerAppInside)
    sightexports.sGui:setImageFile(image, ":sPaintshop/files/avatar.dds")
    local label = sightexports.sGui:createGuiElement("label", appW / 2 - w / 2 + 64 + 8, y + h / 2 - 32, 0, 20, computerAppInside)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Üdvözlünk " .. workshopRented.name .. "!")
    sightexports.sGui:setLabelColor(label, "#000000")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    local label = sightexports.sGui:createGuiElement("label", appW / 2 - w / 2 + 64 + 8, y + h / 2 - 32 + 20, 0, 20, computerAppInside)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Értékelések száma: " .. sightexports.sGui:thousandsStepper(workshopRatingNum))
    sightexports.sGui:setLabelColor(label, "#000000")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    local image = sightexports.sGui:createGuiElement("image", appW / 2 - w / 2 + 64 + 8, y + h / 2 + 32 - 16, 89, 16, computerAppInside)
    sightexports.sGui:setImageFile(image, ":sPaintshop/files/stars.dds")
    sightexports.sGui:setImageUV(image, 0, 0, 89, 16)
    local rating = 0
    if 0 < workshopRatingNum then
      rating = workshopRatingSum / workshopRatingNum
    end
    local image = sightexports.sGui:createGuiElement("image", appW / 2 - w / 2 + 64 + 8, y + h / 2 + 32 - 16, 89 * (rating / 5), 16, computerAppInside)
    sightexports.sGui:setImageFile(image, ":sPaintshop/files/stars.dds")
    sightexports.sGui:setImageUV(image, 0, 16, 89 * (rating / 5), 16)
    local label = sightexports.sGui:createGuiElement("label", appW / 2 - w / 2 + 64 + 8 + 89 + 8, y + h / 2 + 32 - 16, 24, 16, computerAppInside)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, math.floor(rating * 10) / 10)
    sightexports.sGui:setLabelColor(label, "#000000")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    y = y + h
    local time = getRealTime(workshopRented.rentUntil)
    local text = "Műhely bérlet lejár: " .. string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
    local w1 = sightexports.sGui:getTextWidthFont("Emlékeztető", "11/Ubuntu-R.ttf") + 8
    local w2 = sightexports.sGui:getTextWidthFont(text, "11/Ubuntu-L.ttf") + 8
    local rect = sightexports.sGui:createGuiElement("rectangle", appW / 2 - (w1 + w2) / 2, y + h / 2 - 12, w1 + w2, 24, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "solid", "#0aa49c")
    local r2 = sightexports.sGui:createGuiElement("rectangle", 0, 0, w1, 24, rect)
    sightexports.sGui:setGuiBackground(r2, "solid", "#066a65")
    local label = sightexports.sGui:createGuiElement("label", 0, 0, w1, 24, rect)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "Emlékeztető")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    local label = sightexports.sGui:createGuiElement("label", 0 + w1, 0, w2, 24, rect)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, text)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    y = y + h
    local w = (appW - 310) / 2

    --MiguItalia Shop
    local rect = sightexports.sGui:createGuiElement("rectangle", 155 + w / 2 - 65.5, y + h / 2 - 47.5, 131, 95, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "solid", computerColorScheme.btn1)
    sightexports.sGui:setGuiHover(rect, "none", false, false, true)
    sightexports.sGui:setGuiBackgroundBorder(rect, 1, computerColorScheme.window2)
    sightexports.sGui:setClickEvent(rect, "openPaintshopOrderWebpage")
    sightexports.sGui:setGuiHoverable(rect, true)
    local image = sightexports.sGui:createGuiElement("image", 8, 8, 115, 53, rect)
    sightexports.sGui:setImageFile(image, ":sPaintshop/files/logo.dds")
    local label = sightexports.sGui:createGuiElement("label", 0, 61, 131, 34, rect)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "MiguItalia Shop")
    sightexports.sGui:setLabelColor(label, "#000000")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")

    --Fejlesztések (logo3)
    local rect = sightexports.sGui:createGuiElement("rectangle", 155 + w - 65.5, y + h / 2 - 47.5, 131, 95, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "solid", computerColorScheme.btn1)
    sightexports.sGui:setGuiHover(rect, "none", false, false, true)
    sightexports.sGui:setGuiBackgroundBorder(rect, 1, computerColorScheme.window2)
    sightexports.sGui:setClickEvent(rect, "openPaintshopUpgradeWebpage")
    sightexports.sGui:setGuiHoverable(rect, true)
    local image = sightexports.sGui:createGuiElement("image", 8, 8, 115, 53, rect)
    sightexports.sGui:setImageFile(image, dxCreateTexture(":sPaintshop/files/logo3.png"))
    local label = sightexports.sGui:createGuiElement("label", 0, 61, 131, 34, rect)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "Fejlesztések")
    sightexports.sGui:setLabelColor(label, "#000000")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")

    --Cégjegyzék
    local rect = sightexports.sGui:createGuiElement("rectangle", 155 + w + w / 2 - 65.5, y + h / 2 - 47.5, 131, 95, computerAppInside)
    sightexports.sGui:setGuiBackground(rect, "solid", computerColorScheme.btn1)
    sightexports.sGui:setGuiHover(rect, "none", false, false, true)
    sightexports.sGui:setGuiBackgroundBorder(rect, 1, computerColorScheme.window2)
    sightexports.sGui:setClickEvent(rect, "openPaintshopCompanyWebpage")
    sightexports.sGui:setGuiHoverable(rect, true)
    local image = sightexports.sGui:createGuiElement("image", 8, 8, 115, 53, rect)
    sightexports.sGui:setImageFile(image, ":sPaintshop/files/logo2.dds")
    local label = sightexports.sGui:createGuiElement("label", 0, 61, 131, 34, rect)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "Cégjegyzék")
    sightexports.sGui:setLabelColor(label, "#000000")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  end
  frontComputerScan()
end
function deleteComputerWindow()
  if computerWindow then
    sightexports.sGui:deleteGuiElement(computerWindow)
  end
  if scrollHandled then
    scrollHandled = false
    removeEventHandler("onClientKey", getRootElement(), scrollHandler)
  end
  openedWebsite = false
  computerWindow = false
  computerPrompt = false
  seletedEmailCategory = false
  openedComputerApp = false
  computerScan = false
  computerApp = false
  computerAppInside = false
  emailReplyButtons = {}
  emailAppFolderElemenets = {}
  emailAppRows = {}
  openedEmail = false
  emailList = {}
  emailScrollBar = false
  emailScrollBarY = 0
  emailScrollBarH = 0
  permissionButtons = {}
  fireButtons = {}
  foundPlayer = false
  dateLabel = false
  currentDate = false
  orderElements = {}
  orderNum = {}
  overallOrderSum = 0
  overallOrderNum = 0
  orderOverallLabel = false
end
addEvent("closePaintshopComputerWindow", false)
addEventHandler("closePaintshopComputerWindow", getRootElement(), deleteComputerWindow)
addEvent("openPaintshopComputerDesktop", false)
addEventHandler("openPaintshopComputerDesktop", getRootElement(), function()
  closePaintshopComputerPrompt()
  openedComputerApp = false
  if computerApp then
    sightexports.sGui:deleteGuiElement(computerApp)
  end
  if scrollHandled then
    scrollHandled = false
    removeEventHandler("onClientKey", getRootElement(), scrollHandler)
  end
  computerApp = false
  computerAppInside = false
  emailReplyButtons = {}
  emailAppFolderElemenets = {}
  emailAppRows = {}
  openedEmail = false
  emailList = {}
  seletedEmailCategory = false
  emailScrollBar = false
  emailScrollBarY = 0
  emailScrollBarH = 0
  permissionButtons = {}
  fireButtons = {}
  foundPlayer = false
  orderElements = {}
  orderNum = {}
  overallOrderSum = 0
  overallOrderNum = 0
  orderOverallLabel = false
  createDekstop()
  playSound("files/click.mp3")
end)
function createDekstop()
  if computerApp then
    sightexports.sGui:deleteGuiElement(computerApp)
  end
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  computerApp = sightexports.sGui:createGuiElement("null", 2, titleBarHeight + 2, 1024, 544, computerWindow)
  local rect = sightexports.sGui:createGuiElement("rectangle", 24, 24, 48, 60, computerApp)
  sightexports.sGui:setGuiBackground(rect, "solid", {
    0,
    0,
    0,
    0
  })
  sightexports.sGui:setGuiHover(rect, "none", false, false, true)
  sightexports.sGui:setGuiHoverable(rect, true)
  sightexports.sGui:setClickEvent(rect, "openPaintshopEmailApp")
  local icon = sightexports.sGui:createGuiElement("image", 9, 9, 32, 32, rect)
  sightexports.sGui:setImageFile(icon, ":sPaintshop/files/emailicon.dds")
  sightexports.sGui:setImageColor(icon, "#000000")
  local icon = sightexports.sGui:createGuiElement("image", 8, 8, 32, 32, rect)
  sightexports.sGui:setImageFile(icon, ":sPaintshop/files/emailicon.dds")
  local label = sightexports.sGui:createGuiElement("label", 0, 48, 48, 12, rect)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, "Sightmail")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelShadow(label, "#000000", 1, 1)
  local rect = sightexports.sGui:createGuiElement("rectangle", 24, 96, 48, 60, computerApp)
  sightexports.sGui:setGuiBackground(rect, "solid", {
    0,
    0,
    0,
    0
  })
  sightexports.sGui:setGuiHover(rect, "none", false, false, true)
  sightexports.sGui:setGuiHoverable(rect, true)
  sightexports.sGui:setClickEvent(rect, "openPaintshopInternetApp")
  local icon = sightexports.sGui:createGuiElement("image", 9, 9, 32, 32, rect)
  sightexports.sGui:setImageFile(icon, ":sPaintshop/files/internet.dds")
  sightexports.sGui:setImageColor(icon, "#000000")
  local icon = sightexports.sGui:createGuiElement("image", 8, 8, 32, 32, rect)
  sightexports.sGui:setImageFile(icon, ":sPaintshop/files/internet.dds")
  local label = sightexports.sGui:createGuiElement("label", 0, 48, 48, 12, rect)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, "Internet")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelShadow(label, "#000000", 1, 1)
  frontComputerScan()
end
function createComputerWindow()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local pw, ph = 1028, 576 + titleBarHeight + 4
  computerWindow = sightexports.sGui:createGuiElement("window", x or screenX / 2 - pw / 2, y or screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setDisableClickSound(computerWindow, false, true)
  sightexports.sGui:setWindowTitle(computerWindow, "16/BebasNeueRegular.otf", "Számítógép")
  sightexports.sGui:setWindowCloseButton(computerWindow, "closePaintshopComputerWindow")
  local image = sightexports.sGui:createGuiElement("image", 2, titleBarHeight + 2, pw - 4, ph - titleBarHeight - 4, computerWindow)
  sightexports.sGui:setImageFile(image, ":sPaintshop/files/wp.dds")
  local rect = sightexports.sGui:createGuiElement("rectangle", 2, ph - 2 - 32, pw - 4, 32, computerWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", computerColorScheme.taskbar)
  local icon = sightexports.sGui:createGuiElement("image", 4, 4, 24, 24, rect)
  sightexports.sGui:setImageFile(icon, ":sPaintshop/files/start.dds")
  computerScan = sightexports.sGui:createGuiElement("image", 2, titleBarHeight + 2, pw - 4, ph - titleBarHeight - 4, computerWindow)
  sightexports.sGui:setImageFile(computerScan, ":sPaintshop/files/scan.dds")
  sightexports.sGui:setImageColor(computerScan, {
    255,
    255,
    255,
    150
  })
  dateLabel = sightexports.sGui:createGuiElement("label", pw - 2 - 100, 0, 100, 32, rect)
  sightexports.sGui:setLabelFont(dateLabel, "9/Ubuntu-R.ttf")
  sightexports.sGui:setLabelAlignment(dateLabel, "center", "center")
  currentDate = false
  createDekstop()
end

function createCarPaintjob(id, data, maskData, syncData)
	if isElement(carPaintjobs[id]) then
		destroyElement(carPaintjobs[id])
	end
	if isElement(carSecondaryMasks[id]) then
		destroyElement(carSecondaryMasks[id])
	end
	carPaintjobs[id] = dxCreateTexture(data, "dxt1")
	local levelAmount = {5, 15, 25, 50, 75}
	local level = (workshopUpgrades[6] or 0)
	local brushSize = levelAmount[level] or 0
	local sizeMultiplier = (1 + (brushSize / 100))
	if maskData then
		carSecondaryMasks[id] = dxCreateTexture(maskData)
		local rt = dxCreateRenderTarget(1024, 1024)
		dxSetRenderTarget(rt, true)
		dxDrawRectangle(0, 0, 1024, 1024, tocolor(255, 255, 255))
		for k, v in pairs(syncData) do
			if syncData[k] then
				local x, y = syncToCoord(k)
				local size = (paintshopWorks[id].state == "paint" or paintshopWorks[id].state == "primerDry") and 48 or 32
				local w, h = size * sizeMultiplier, size * sizeMultiplier
				local x, y = x - (w / 2), y - (h / 2)
				dxDrawImage(x, y, w, h, sandbrush, 0, 0, 0, tocolor(0, 0, 0, v))
			end
		end
		dxSetRenderTarget()
		local pixels = dxGetTexturePixels(rt)
		dxSetTexturePixels(carSecondaryMasks[id], pixels)
		destroyElement(rt)
	else
		carSecondaryMasks[id] = nil
	end
	if isElement(carShaders[id]) then
		dxSetShaderValue(carShaders[id], "baseTexture", carPaintjobs[id])
		dxSetShaderValue(carShaders[id], "secondaryMask", carSecondaryMasks[id])
	end
	data = nil
	maskData = nil
	pixels = nil
	collectgarbage("collect")
end