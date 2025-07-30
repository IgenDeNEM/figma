local sightexports = {
  sGroups = false,
  sChat = false,
  sGui = false,
  sBank = false,
  sRadar = false
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
sightlangStaticImageToc[1] = true
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
  if sightlangStaticImageUsed[1] then
    sightlangStaticImageUsed[1] = false
    sightlangStaticImageDel[1] = false
  elseif sightlangStaticImage[1] then
    if sightlangStaticImageDel[1] then
      if now >= sightlangStaticImageDel[1] then
        if isElement(sightlangStaticImage[1]) then
          destroyElement(sightlangStaticImage[1])
        end
        sightlangStaticImage[1] = nil
        sightlangStaticImageDel[1] = false
        sightlangStaticImageToc[1] = true
        return
      end
    else
      sightlangStaticImageDel[1] = now + 5000
    end
  else
    sightlangStaticImageToc[1] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/ambulanceticket.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/ticket.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangDynImgHand = false
local sightlangDynImgLatCr = falselocal
sightlangDynImage = {}
local sightlangDynImageForm = {}
local sightlangDynImageMip = {}
local sightlangDynImageUsed = {}
local sightlangDynImageDel = {}
local sightlangDynImgPre
function sightlangDynImgPre()
  local now = getTickCount()
  sightlangDynImgLatCr = true
  local rem = true
  for k in pairs(sightlangDynImage) do
    rem = false
    if sightlangDynImageDel[k] then
      if now >= sightlangDynImageDel[k] then
        if isElement(sightlangDynImage[k]) then
          destroyElement(sightlangDynImage[k])
        end
        sightlangDynImage[k] = nil
        sightlangDynImageForm[k] = nil
        sightlangDynImageMip[k] = nil
        sightlangDynImageDel[k] = nil
        break
      end
    elseif not sightlangDynImageUsed[k] then
      sightlangDynImageDel[k] = now + 5000
    end
  end
  for k in pairs(sightlangDynImageUsed) do
    if not sightlangDynImage[k] and sightlangDynImgLatCr then
      sightlangDynImgLatCr = false
      sightlangDynImage[k] = dxCreateTexture(k, sightlangDynImageForm[k], sightlangDynImageMip[k])
    end
    sightlangDynImageUsed[k] = nil
    sightlangDynImageDel[k] = nil
    rem = false
  end
  if rem then
    removeEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre)
    sightlangDynImgHand = false
  end
end
local function dynamicImage(img, form, mip)
  if not sightlangDynImgHand then
    sightlangDynImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre, true, "high+999999999")
  end
  if not sightlangDynImage[img] then
    sightlangDynImage[img] = dxCreateTexture(img, form, mip)
  end
  sightlangDynImageForm[img] = form
  sightlangDynImageUsed[img] = true
  return sightlangDynImage[img]
end
local screenX, screenY = guiGetScreenSize()
local sx, sy = 400, 496
local x, y = screenX / 2 - sx / 2, screenY / 2 - (sy + 30 + 8) / 2
local ticketState = false
local font = dxCreateFont("files/lunabar.ttf", 36, false, "antialiased")
local font2 = dxCreateFont("files/hand.ttf", 28, false, "antialiased")
local editing = false
local editingOffender = false
local editingOffenderName = false
local ticketButtons = false
local playerSelectorWindow = false
local playerButtons = false
local descriptionInput = false
local moneyInput = false
local ticketGroup = "PD"
local ticketData = false
function openTicketNew(group)
  if not ticketData and ticketGroups[group] and sightexports.sGroups:isPlayerInGroup(group) then
    setTicketState(false)
    ticketGroup = group
    showTicketPlayerSelector()
  end
end
function openTicket(id)
  id = tonumber(id)
  if id then
    if ticketData and ticketData.id == id then
      setTicketState(false)
      sightexports.sChat:localActionC(localPlayer, "elrak egy csekket.")
    else
      sightexports.sChat:localActionC(localPlayer, "elővesz egy csekket.")
      triggerServerEvent("requestTicket", localPlayer, id)
    end
  else
    sightexports.sChat:localActionC(localPlayer, "elrak egy csekket.")
    setTicketState(false)
  end
end
addEvent("gotTicket", true)
addEventHandler("gotTicket", getRootElement(), function(data)
  if data then
    setTicketState(true)
    ticketButtons = sightexports.sGui:createGuiElement("null", x, y + sy + 8, sx, 30)
    local btn = sightexports.sGui:createGuiElement("button", 0, 0, sx / 2 - 4, 30, ticketButtons)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Bezárás")
    sightexports.sGui:setClickEvent(btn, "closeTicket")
    local btn = sightexports.sGui:createGuiElement("button", sx / 2 + 4, 0, sx / 2 - 4, 30, ticketButtons)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Befizetés")
    sightexports.sGui:setClickEvent(btn, "payTicket")
    ticketData = data
    ticketGroup = data.ticketGroup
    if data.offenderId == getElementData(localPlayer, "char.ID") then
      local time = getRealTime(data.ticketDate + 259200)
      local date = string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
      sightexports.sGui:showInfobox("i", "Fizetési határidő: " .. date)
      sightexports.sGui:showInfobox("w", "Amennyiben a megadott határidőn belül nem fizeted be, az összeg +50% büntetéssel kerül levonásra!")
    end
    local time = getRealTime(data.ticketDate)
    ticketData.ticketDate = string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
    local money = tostring(data.money)
    ticketData.money = {}
    local n = utf8.len(money)
    for i = n + 1, 6 do
      table.insert(ticketData.money, "-")
    end
    for i = 1, n do
      table.insert(ticketData.money, utf8.sub(money, i, i))
    end
  end
end)
function createEditInputs()
  local h = dxGetFontHeight(0.4, font2)
  if descriptionInput then
    sightexports.sGui:deleteGuiElement(descriptionInput)
  end
  descriptionInput = nil
  if moneyInput then
    sightexports.sGui:deleteGuiElement(moneyInput)
  end
  moneyInput = nil
  descriptionInput = sightexports.sGui:createGuiElement("input", x + 25, y + 348 - h, sx - 50, h * 5)
  sightexports.sGui:setInputColor(descriptionInput, "#454545", "#ffffff", false, "#353535", "#000000")
  sightexports.sGui:setInputFont(descriptionInput, "10/Ubuntu-R.ttf")
  sightexports.sGui:setInputPlaceholder(descriptionInput, "Leírás")
  sightexports.sGui:setInputMaxLength(descriptionInput, 120)
  sightexports.sGui:setInputMultiline(descriptionInput, true)
  sightexports.sGui:setInputFontPaddingHeight(descriptionInput, 32)
  moneyInput = sightexports.sGui:createGuiElement("input", x + 118, y + 170, 165, 26)
  sightexports.sGui:setInputColor(moneyInput, "#454545", "#ffffff", false, "#353535", "#000000")
  sightexports.sGui:setInputFont(moneyInput, "10/Ubuntu-R.ttf")
  sightexports.sGui:setInputPlaceholder(moneyInput, "Összeg (1 - " .. maxMoney .. " $)")
  sightexports.sGui:setInputMaxLength(moneyInput, utf8.len(tostring(maxMoney)))
  sightexports.sGui:setInputNumberOnly(moneyInput, true)
end
addEvent("closeTicket", false)
addEventHandler("closeTicket", getRootElement(), function()
  setTicketState(false)
end)
addEvent("payTicket", false)
addEventHandler("payTicket", getRootElement(), function()
  if sightexports.sBank:isInBank(localPlayer) or devMode then
    triggerServerEvent("tryToPayTicket", localPlayer, ticketData.id)
    setTicketState(false)
  else
    sightexports.sGui:showInfobox("e", "Csekket csak a bankban tudsz befizetni!")
  end
end)
addEvent("closeTicketPlayerSelector", false)
addEventHandler("closeTicketPlayerSelector", getRootElement(), function()
  if playerSelectorWindow then
    sightexports.sGui:deleteGuiElement(playerSelectorWindow)
  end
  playerSelectorWindow = nil
  playerButtons = false
end)
addEvent("createTicket", false)
addEventHandler("createTicket", getRootElement(), function()
  if isElement(editingOffender) then
    local px, py, pz = getElementPosition(localPlayer)
    local px2, py2, pz2 = getElementPosition(editingOffender)
    local dist = getDistanceBetweenPoints3D(px2, py2, pz2, px, py, pz)
    if 5 <= dist then
      sightexports.sGui:showInfobox("e", "Túl messze vagy a megadott játékostól!")
      return
    end
    local money = tonumber(sightexports.sGui:getInputValue(moneyInput)) or 0
    if money < 1 or money > maxMoney then
      sightexports.sGui:showInfobox("e", "Az összegnek 1 és " .. sightexports.sGui:thousandsStepper(maxMoney) .. " $ között kell lennie!")
      return
    end
    local reason = sightexports.sGui:getInputValue(descriptionInput)
    if not reason or 1 > utf8.len(reason) then
      sightexports.sGui:showInfobox("e", "A leírás nem lehet üres!")
      return
    end
    triggerServerEvent("createTicket", localPlayer, ticketGroup, editingOffender, money, reason)
  end
  setTicketState(false)
end)
addEvent("selectTicketPlayer", false)
addEventHandler("selectTicketPlayer", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if isElement(playerButtons[el]) then
    local px, py, pz = getElementPosition(localPlayer)
    local px2, py2, pz2 = getElementPosition(playerButtons[el])
    local dist = getDistanceBetweenPoints3D(px2, py2, pz2, px, py, pz)
    if dist < 5 then
      setTicketState(true)
      editing = true
      editingOffender = playerButtons[el]
      editingOffenderName = getElementData(editingOffender, "visibleName"):gsub("_", " ")
      createEditInputs()
      ticketButtons = sightexports.sGui:createGuiElement("null", x, y + sy + 8, sx, 30)
      local btn = sightexports.sGui:createGuiElement("button", 0, 0, sx / 2 - 4, 30, ticketButtons)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightred",
        "sightred-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Mégsem")
      sightexports.sGui:setClickEvent(btn, "closeTicket")
      local btn = sightexports.sGui:createGuiElement("button", sx / 2 + 4, 0, sx / 2 - 4, 30, ticketButtons)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, "Kiállítás")
      sightexports.sGui:setClickEvent(btn, "createTicket")
    else
      sightexports.sGui:showInfobox("e", "Túl messze vagy tőle!")
    end
  end
  if playerSelectorWindow then
    sightexports.sGui:deleteGuiElement(playerSelectorWindow)
  end
  playerSelectorWindow = nil
  playerButtons = false
end)
function showTicketPlayerSelector()
  setTicketState(false)
  if playerSelectorWindow then
    sightexports.sGui:deleteGuiElement(playerSelectorWindow)
  end
  playerSelectorWindow = nil
  local px, py, pz = getElementPosition(localPlayer)
  local playerList = {}
  local players = getElementsByType("player", getRootElement(), true)
  for i = 1, #players do
    if players[i] ~= localPlayer and getElementData(players[i], "loggedIn") then
      local px2, py2, pz2 = getElementPosition(players[i])
      local dist = getDistanceBetweenPoints3D(px2, py2, pz2, px, py, pz)
      if dist < 5 then
        table.insert(playerList, players[i])
      end
    end
  end
  if #playerList < 1 then
    sightexports.sGui:showInfobox("e", "Nincs senki a közeledben!")
  else
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local panelWidth = 250
    local panelHeight = titleBarHeight + 5 + 30 + 5 + 35 * #playerList
    playerSelectorWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
    sightexports.sGui:setWindowTitle(playerSelectorWindow, "16/BebasNeueRegular.otf", "Válassz játékost!")
    local y = titleBarHeight + 5
    playerButtons = {}
    for i = 1, #playerList do
      local btn = sightexports.sGui:createGuiElement("button", 5, y, panelWidth - 10, 30, playerSelectorWindow)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      sightexports.sGui:setButtonTextColor(btn, "#ffffff")
      sightexports.sGui:setButtonText(btn, getElementData(playerList[i], "visibleName"):gsub("_", " "))
      sightexports.sGui:setClickEvent(btn, "selectTicketPlayer", false)
      playerButtons[btn] = playerList[i]
      y = y + 35
    end
    local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 35, panelWidth - 10, 30, playerSelectorWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Mégsem")
    sightexports.sGui:setClickEvent(btn, "closeTicketPlayerSelector")
  end
end
function setTicketState(state)
  if ticketButtons then
    sightexports.sGui:deleteGuiElement(ticketButtons)
  end
  ticketButtons = nil
  if descriptionInput then
    sightexports.sGui:deleteGuiElement(descriptionInput)
  end
  descriptionInput = nil
  if moneyInput then
    sightexports.sGui:deleteGuiElement(moneyInput)
  end
  moneyInput = nil
  editing = false
  editingOffender = false
  editingOffenderName = false
  if state ~= ticketState then
    ticketState = state
    if state then
      addEventHandler("onClientRender", getRootElement(), renderTicket)
    else
      removeEventHandler("onClientRender", getRootElement(), renderTicket)
      ticketData = false
    end
  end
end
function renderTicket()
  if ticketGroup == medicGroupPrefix then
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processsightlangStaticImage[0]()
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[0])
  else
    sightlangStaticImageUsed[1] = true
    if sightlangStaticImageToc[1] then
      processsightlangStaticImage[1]()
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[1])
    if ticketGroups[ticketGroup] then
      dxDrawImage(x, y, sx, sy, dynamicImage("files/logo/" .. ticketGroup .. ".dds"))
    end
  end
  local penc = tocolor(57, 70, 126, 255)
  if editing then
    local px, py, pz = getElementPosition(localPlayer)
    local time = getRealTime()
    local date = string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
    if ticketGroup == medicGroupPrefix then
      dxDrawLine(x + 127 + 8, y + 228, x + 375, y + 228, tocolor(0, 0, 0), 1)
      dxDrawLine(x + 125 + 8, y + 258, x + 375, y + 258, tocolor(0, 0, 0), 1)
      dxDrawLine(x + 121 + 8, y + 288, x + 375, y + 288, tocolor(0, 0, 0), 1)
      dxDrawText(editingOffenderName, x + 127 + 8, 0, x + 375, y + 228 + 2, penc, 0.4, font2, "center", "bottom", true)
      dxDrawText(sightexports.sRadar:getZoneName(px, py, pz) or "N/A", x + 125 + 8, 0, x + 375, y + 258 + 2, penc, 0.4, font2, "center", "bottom", true)
      dxDrawText(date, x + 121 + 8, 0, x + 375, y + 288 + 2, penc, 0.4, font2, "center", "bottom", true)
    else
      dxDrawLine(x + 146 + 8, y + 228, x + 375, y + 228, tocolor(0, 0, 0), 1)
      dxDrawLine(x + 130 + 8, y + 258, x + 375, y + 258, tocolor(0, 0, 0), 1)
      dxDrawLine(x + 126 + 8, y + 288, x + 375, y + 288, tocolor(0, 0, 0), 1)
      dxDrawText(editingOffenderName, x + 146 + 8, 0, x + 375, y + 228 + 2, penc, 0.4, font2, "center", "bottom", true)
      dxDrawText(sightexports.sRadar:getZoneName(px, py, pz) or "N/A", x + 130 + 8, 0, x + 375, y + 258 + 2, penc, 0.4, font2, "center", "bottom", true)
      dxDrawText(date, x + 126 + 8, 0, x + 375, y + 288 + 2, penc, 0.4, font2, "center", "bottom", true)
    end
    if not isElement(editingOffender) then
      sightexports.sGui:showInfobox("e", "A megadott játékos kilépett!")
      setTicketState(false)
    end
  elseif ticketData then
    dxDrawText(ticketData.money[1], x + 120, y + 170, x + 120 + 25, y + 170 + 24, penc, 0.5, font2, "center", "center", true)
    dxDrawText(ticketData.money[2], x + 147, y + 170, x + 147 + 25, y + 170 + 24, penc, 0.5, font2, "center", "center", true)
    dxDrawText(ticketData.money[3], x + 174, y + 170, x + 174 + 25, y + 170 + 24, penc, 0.5, font2, "center", "center", true)
    dxDrawText(ticketData.money[4], x + 202, y + 170, x + 202 + 25, y + 170 + 24, penc, 0.5, font2, "center", "center", true)
    dxDrawText(ticketData.money[5], x + 229, y + 170, x + 229 + 25, y + 170 + 24, penc, 0.5, font2, "center", "center", true)
    dxDrawText(ticketData.money[6], x + 256, y + 170, x + 256 + 25, y + 170 + 24, penc, 0.5, font2, "center", "center", true)
    if ticketGroup == medicGroupPrefix then
      dxDrawLine(x + 127 + 8, y + 228, x + 375, y + 228, tocolor(0, 0, 0), 1)
      dxDrawLine(x + 125 + 8, y + 258, x + 375, y + 258, tocolor(0, 0, 0), 1)
      dxDrawLine(x + 121 + 8, y + 288, x + 375, y + 288, tocolor(0, 0, 0), 1)
      dxDrawText(ticketData.offenderName, x + 127 + 8, 0, x + 375, y + 228 + 2, penc, 0.4, font2, "center", "bottom", true)
      dxDrawText(ticketData.ticketPlace, x + 125 + 8, 0, x + 375, y + 258 + 2, penc, 0.4, font2, "center", "bottom", true)
      dxDrawText(ticketData.ticketDate, x + 121 + 8, 0, x + 375, y + 288 + 2, penc, 0.4, font2, "center", "bottom", true)
    else
      dxDrawLine(x + 146 + 8, y + 228, x + 375, y + 228, tocolor(0, 0, 0), 1)
      dxDrawLine(x + 130 + 8, y + 258, x + 375, y + 258, tocolor(0, 0, 0), 1)
      dxDrawLine(x + 126 + 8, y + 288, x + 375, y + 288, tocolor(0, 0, 0), 1)
      dxDrawText(ticketData.offenderName, x + 146 + 8, 0, x + 375, y + 228 + 2, penc, 0.4, font2, "center", "bottom", true)
      dxDrawText(ticketData.ticketPlace, x + 130 + 8, 0, x + 375, y + 258 + 2, penc, 0.4, font2, "center", "bottom", true)
      dxDrawText(ticketData.ticketDate, x + 126 + 8, 0, x + 375, y + 288 + 2, penc, 0.4, font2, "center", "bottom", true)
    end
    local h = dxGetFontHeight(0.4, font2)
    dxDrawText(ticketData.reason, x + 25, y + 348 - h, x + 375, y + 348 + 6 * h, penc, 0.4, font2, "left", "top", true, true)
    for i = 1, 4 do
      dxDrawLine(x + 25, y + 348 + (i - 1) * h, x + 375, y + 348 + (i - 1) * h, tocolor(0, 0, 0), 1)
    end
    dxDrawText(ticketData.ticketBy, x, 0, x + sx, y + 470, penc, 0.5, font, "center", "bottom", true)
  end
end
