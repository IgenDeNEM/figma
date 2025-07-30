local sightexports = {sGui = false}
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
    sightlangStaticImage[0] = dxCreateTexture("files/load2.dds", "dxt1", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/load.dds", "dxt1", true)
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
local sightlangBlankTex = dxCreateTexture(1, 1)
local function latentDynamicImage(img, form, mip)
  if not sightlangDynImgHand then
    sightlangDynImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre, true, "high+999999999")
  end
  sightlangDynImageForm[img] = form
  sightlangDynImageMip[img] = mip
  sightlangDynImageUsed[img] = true
  return sightlangDynImage[img] or sightlangBlankTex
end
local impact = false
local impactScale = false
local impactHeight = false
local loaderIcon = false
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    impact = sightexports.sGui:getFont("10/Impact.ttf")
    impactScale = sightexports.sGui:getFontScale("10/Impact.ttf")
    impactHeight = sightexports.sGui:getFontHeight("10/Impact.ttf")
    loaderIcon = sightexports.sGui:getFaIconFilename("circle-notch", 64)
    faTicks = sightexports.sGui:getFaTicks()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderInvoice, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderInvoice)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), doCleanupInvoce, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), doCleanupInvoce)
    end
  end
end
local invoiceFont = false
local signFont = false
local invoiceDatas = {}
local invoiceRequested = {}
local invoiceBookData = {}
local invoiceBookRequested = {}
local currentInvoice = false
local invoiceBookGuiNull = false
local invoiceBookBuyerInput = false
local invoiceBookProductInput = false
local invoiceBookNetPriceInput = false
local invoiceBookVatPriceInput = false
local invoiceBookVatFormatted = false
local invoiceBookBuyerInputValue = false
local invoiceBookProductInputValue = false
local invoiceBookNetPriceInputValue = false
local invoiceBookNextButton = false
local invoiceBookPrevButton = false
local invoiceBookCreateButton = false
local invoiceCreating = false
local invoiceBookWindow = false
function renderInvoice()
  local x, y = screenX / 2 - 196, screenY / 2 - 284
  local tex = latentDynamicImage("files/bg.dds")
  local grunge = latentDynamicImage("files/grunge.dds")
  local isCopy = currentInvoice and currentInvoiceBook
  local over = latentDynamicImage("files/over" .. (isCopy and "2" or "") .. ".dds")
  if tex and grunge and over and (currentInvoice and invoiceDatas[currentInvoice] or not currentInvoice and currentInvoiceBook and invoiceBookData[currentInvoiceBook]) and not invoiceCreating then
    local isInvoiceFont = isElement(invoiceFont)
    local isSignFont = isElement(signFont)
    if isInvoiceFont and isSignFont then
      local penc = isCopy and tocolor(80, 80, 100) or tocolor(20, 100, 200)
      dxDrawImage(x, y, 392, 568, tex)
      if currentInvoiceBook and not currentInvoice then
        dxDrawText(invoiceBookData[currentInvoiceBook].companyName, x + 53, y + 68, x + 189, y + 137, tocolor(0, 0, 0), impactScale, impact, "center", "top", true, true)
        if invoiceBookData[currentInvoiceBook].postfix then
          dxDrawText(invoiceBookData[currentInvoiceBook].postfix, x + 53, 0, x + 189, y + 137 - impactHeight, tocolor(164, 27, 27), impactScale, impact, "center", "bottom", true)
        end
        dxDrawText(invoiceBookData[currentInvoiceBook].vatNumber, x + 53, 0, x + 189, y + 137, tocolor(0, 0, 0), impactScale, impact, "center", "bottom")
        if invoiceBookVatFormatted then
          dxDrawText(invoiceBookVatFormatted, x + 134, y + 393, x + 372, y + 393 + 33, penc, 0.6, invoiceFont, "right", "center", true)
        end
      else
        dxDrawText(invoiceDatas[currentInvoice].companyName, x + 53, y + 68, x + 189, y + 137, tocolor(0, 0, 0), impactScale, impact, "center", "top", true, true)
        if invoiceDatas[currentInvoice].postfix then
          dxDrawText(invoiceDatas[currentInvoice].postfix, x + 53, 0, x + 189, y + 137 - impactHeight, tocolor(164, 27, 27), impactScale, impact, "center", "bottom", true)
        end
        dxDrawText(invoiceDatas[currentInvoice].vatNumber, x + 53, 0, x + 189, y + 137, tocolor(0, 0, 0), impactScale, impact, "center", "bottom")
        dxDrawText(invoiceDatas[currentInvoice].buyer, x + 212, y + 60, x + 373, y + 146, penc, 0.55, invoiceFont, "center", "center", true, true)
        dxDrawText(invoiceDatas[currentInvoice].created, x + 134, y + 148, x + 372, y + 148 + 33, penc, 0.6, invoiceFont, "right", "center", true)
        dxDrawText(invoiceDatas[currentInvoice].product, x + 42, y + 203, x + 372, y + 348, penc, 0.6, invoiceFont, "left", "top", true, true)
        dxDrawText(invoiceDatas[currentInvoice].netPrice, x + 134, y + 358, x + 372, y + 358 + 33, penc, 0.6, invoiceFont, "right", "center", true)
        dxDrawText(invoiceDatas[currentInvoice].vat, x + 134, y + 393, x + 372, y + 393 + 33, penc, 0.6, invoiceFont, "right", "center", true)
        dxDrawText(invoiceDatas[currentInvoice].vatPrice, x + 134, y + 428, x + 372, y + 428 + 33, penc, 0.6, invoiceFont, "right", "center", true)
        dxDrawText(invoiceDatas[currentInvoice].sellerSign, x + 36, y + 478, x + 207, y + 532, penc, 0.7, signFont, "center", "center", true, true)
        dxDrawText(invoiceDatas[currentInvoice].buyerSign, x + 207, y + 478, x + 378, y + 532, penc, 0.7, signFont, "center", "center", true, true)
      end
      dxDrawImage(x, y, 392, 568, grunge)
      if currentInvoiceBook and not currentInvoice then
        dxDrawText(currentInvoiceBook .. "-" .. invoiceBookData[currentInvoiceBook].lastInvoice + 1, x + 200, 0, 0, y + 35, tocolor(60, 60, 60), impactScale * 1.25, impact, "left", "bottom")
      else
        dxDrawText(currentInvoice, x + 200, 0, 0, y + 35, tocolor(60, 60, 60), impactScale * 1.25, impact, "left", "bottom")
      end
      dxDrawImage(x, y, 392, 568, over)
    else
      while true do
        if not isInvoiceFont then
          invoiceFont = dxCreateFont("files/mathilde.otf", 35, false, "antialiased")
          break
        end
        if not isSignFont then
          signFont = dxCreateFont("files/lunabar.ttf", 25, false, "antialiased")
          break
        end
        break
      end
      if isCopy then
        sightlangStaticImageUsed[0] = true
        if sightlangStaticImageToc[0] then
          processsightlangStaticImage[0]()
        end
        dxDrawImage(x, y, 392, 568, sightlangStaticImage[0])
      else
        sightlangStaticImageUsed[1] = true
        if sightlangStaticImageToc[1] then
          processsightlangStaticImage[1]()
        end
        dxDrawImage(x, y, 392, 568, sightlangStaticImage[1])
      end
      dxDrawImage(x + 196 - 32, y + 284 - 32, 64, 64, ":sGui/" .. loaderIcon .. faTicks[loaderIcon], getTickCount() / 5 % 360)
    end
  else
    if isCopy then
      sightlangStaticImageUsed[0] = true
      if sightlangStaticImageToc[0] then
        processsightlangStaticImage[0]()
      end
      dxDrawImage(x, y, 392, 568, sightlangStaticImage[0])
    else
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
      end
      dxDrawImage(x, y, 392, 568, sightlangStaticImage[1])
    end
    dxDrawImage(x + 196 - 32, y + 284 - 32, 64, 64, ":sGui/" .. loaderIcon .. faTicks[loaderIcon], getTickCount() / 5 % 360)
  end
end
local canCleanup = 0
function doCleanupInvoce(delta)
  canCleanup = canCleanup - delta
  if canCleanup <= 0 then
    sightlangCondHandl0(false)
    invoiceDatas = {}
    invoiceBookData = {}
    invoiceRequested = {}
    invoiceBookRequested = {}
    if isElement(invoiceFont) then
      destroyElement(invoiceFont)
    end
    invoiceFont = nil
    if isElement(signFont) then
      destroyElement(signFont)
    end
    signFont = nil
  end
end
addEvent("invoiceInputChangeEvent", false)
addEventHandler("invoiceInputChangeEvent", getRootElement(), function(value, el)
  if el == invoiceBookBuyerInput then
    invoiceBookBuyerInputValue = value
  elseif el == invoiceBookProductInput then
    invoiceBookProductInputValue = value
  elseif el == invoiceBookNetPriceInput then
    value = tonumber(value)
    if value and value ~= 0 then
      value = math.ceil(value)
      invoiceBookNetPriceInputValue = value
      local vat = math.floor(value * 0.2)
      invoiceBookVatFormatted = sightexports.sGui:thousandsStepper(vat) .. " $"
      local new = value + vat
      sightexports.sGui:setInputValue(invoiceBookVatPriceInput, new)
    else
      sightexports.sGui:setInputValue(invoiceBookVatPriceInput, "")
      invoiceBookNetPriceInputValue = false
      invoiceBookVatFormatted = false
    end
  elseif el == invoiceBookVatPriceInput then
    value = tonumber(value)
    if value and value ~= 0 then
      value = math.ceil(value)
      local new = math.ceil(value / 1.2)
      local vat = math.floor(new * 0.2)
      invoiceBookVatFormatted = sightexports.sGui:thousandsStepper(vat) .. " $"
      sightexports.sGui:setInputValue(invoiceBookNetPriceInput, new)
      invoiceBookNetPriceInputValue = new
    else
      sightexports.sGui:setInputValue(invoiceBookNetPriceInput, "")
      invoiceBookNetPriceInputValue = false
      invoiceBookVatFormatted = false
    end
  end
end)
addEvent("prevInvoiceInBook", false)
addEventHandler("prevInvoiceInBook", getRootElement(), function()
  local disablePrevious = false
  if currentInvoice then
    local dat = split(currentInvoice, "-")
    local id = tonumber(dat[3]) - 1
    table.remove(dat, 3)
    currentInvoice = table.concat(dat, "-") .. "-" .. id
    disablePrevious = id <= 1
  else
    currentInvoice = currentInvoiceBook .. "-" .. invoiceBookData[currentInvoiceBook].lastInvoice
    disablePrevious = 1 >= invoiceBookData[currentInvoiceBook].lastInvoice
  end
  invoiceBookProcessGui(disablePrevious)
  if not invoiceDatas[currentInvoice] and not invoiceRequested[currentInvoice] then
    invoiceRequested[currentInvoice] = true
    triggerLatentServerEvent("requestInvoice", localPlayer, currentInvoice)
  end
  playSound("files/paper" .. math.random(1, 2) .. ".mp3")
end)
addEvent("nextInvoiceInBook", false)
addEventHandler("nextInvoiceInBook", getRootElement(), function()
  local disablePrevious = false
  if currentInvoice then
    local dat = split(currentInvoice, "-")
    local id = tonumber(dat[3]) + 1
    table.remove(dat, 3)
    if id <= invoiceBookData[currentInvoiceBook].lastInvoice then
      currentInvoice = table.concat(dat, "-") .. "-" .. id
      disablePrevious = id <= 1
      if not invoiceDatas[currentInvoice] and not invoiceRequested[currentInvoice] then
        invoiceRequested[currentInvoice] = true
        triggerLatentServerEvent("requestInvoice", localPlayer, currentInvoice)
      end
    else
      currentInvoice = false
    end
  end
  invoiceBookProcessGui(disablePrevious)
  playSound("files/paper" .. math.random(1, 2) .. ".mp3")
end)
addEvent("createInvoiceResponse", true)
addEventHandler("createInvoiceResponse", getRootElement(), function(book, id)
  invoiceCreating = false
  if currentInvoiceBook == book and invoiceBookData[book] then
    if id then
      currentInvoice = book .. "-" .. id
      invoiceBookData[book].lastInvoice = id
      if not invoiceDatas[currentInvoice] and not invoiceRequested[currentInvoice] then
        invoiceRequested[currentInvoice] = true
        triggerLatentServerEvent("requestInvoice", localPlayer, currentInvoice)
      end
      invoiceBookBuyerInputValue = false
      invoiceBookProductInputValue = false
      invoiceBookNetPriceInputValue = false
      invoiceBookProcessGui(id <= 1)
    else
      invoiceBookProcessGui(invoiceBookData[book].lastInvoice < 1)
    end
  end
end)
addEvent("selectInvoicePlayer", false)
addEventHandler("selectInvoicePlayer", getRootElement(), function(button, state, absoluteX, absoluteY, el, client)
  if invoiceBookWindow then
    sightexports.sGui:deleteGuiElement(invoiceBookWindow)
  end
  invoiceBookWindow = nil
  local buyer = invoiceBookBuyerInputValue
  local product = invoiceBookProductInputValue
  local netPrice = tonumber(invoiceBookNetPriceInputValue)
  if not buyer or utf8.len(buyer) <= 0 then
    sightexports.sGui:showInfobox("e", "A vevő mező kitöltése kötelező!")
    return
  end
  if not product or utf8.len(product) <= 0 then
    sightexports.sGui:showInfobox("e", "A termék/szolgáltatás mező kitöltése kötelező!")
    return
  end
  if not netPrice then
    sightexports.sGui:showInfobox("e", "Az ár mező kitöltése kötelező!")
    return
  end
  if math.abs(netPrice) > 1000000000 then
    sightexports.sGui:showInfobox("e", "A maximum nettó ár: " .. sightexports.sGui:thousandsStepper(1000000000) .. "!")
    return
  end
  if isElement(client) then
    invoiceCreating = true
    invoiceBookProcessGui()
    triggerServerEvent("createInvoice", localPlayer, client, currentInvoiceBook, buyer, product, netPrice)
  end
end)
addEvent("createInvoicePlayerList", false)
addEventHandler("createInvoicePlayerList", getRootElement(), function()
  if invoiceBookWindow then
    sightexports.sGui:deleteGuiElement(invoiceBookWindow)
  end
  invoiceBookWindow = nil
  if currentInvoice then
    return
  end
  local buyer = invoiceBookBuyerInputValue
  local product = invoiceBookProductInputValue
  local netPrice = tonumber(invoiceBookNetPriceInputValue)
  if not buyer or utf8.len(buyer) <= 0 then
    sightexports.sGui:showInfobox("e", "A vevő mező kitöltése kötelező!")
    return
  end
  if not product or utf8.len(product) <= 0 then
    sightexports.sGui:showInfobox("e", "A termék/szolgáltatás mező kitöltése kötelező!")
    return
  end
  if not netPrice then
    sightexports.sGui:showInfobox("e", "Az ár mező kitöltése kötelező!")
    return
  end
  if math.abs(netPrice) > 1000000000 then
    sightexports.sGui:showInfobox("e", "A maximum nettó ár: " .. sightexports.sGui:thousandsStepper(1000000000) .. "!")
    return
  end
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local players = getElementsByType("player", getRootElement(), true)
  local px, py, pz = getElementPosition(localPlayer)
  for i = #players, 1, -1 do
    local x, y, z = getElementPosition(players[i])
    if players[i] == localPlayer or getDistanceBetweenPoints3D(px, py, pz, x, y, z) > 5 then
      table.remove(players, i)
    end
  end
  local panelWidth = 325
  local panelHeight = titleBarHeight + 35 * (#players + 2) + 5
  invoiceBookWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
  sightexports.sGui:setWindowTitle(invoiceBookWindow, "16/BebasNeueRegular.otf", "Számla kiállítása")
  local btn = sightexports.sGui:createGuiElement("button", 5, titleBarHeight + 5, panelWidth - 10, 30, invoiceBookWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  sightexports.sGui:setButtonText(btn, " Saját magam")
  sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("user", 30))
  sightexports.sGui:setClickEvent(btn, "selectInvoicePlayer")
  sightexports.sGui:setClickArgument(btn, localPlayer)
  for i = 1, #players do
    local btn = sightexports.sGui:createGuiElement("button", 5, titleBarHeight + 5 + 35 * i, panelWidth - 10, 30, invoiceBookWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonText(btn, " " .. getElementData(players[i], "visibleName"):gsub("_", " "))
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("user", 30))
    sightexports.sGui:setClickEvent(btn, "selectInvoicePlayer")
    sightexports.sGui:setClickArgument(btn, players[i])
  end
  local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 30 - 5, panelWidth - 10, 30, invoiceBookWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  sightexports.sGui:setButtonText(btn, "Mégsem")
  sightexports.sGui:setClickEvent(btn, "selectInvoicePlayer")
end)
function invoiceBookProcessGui(disablePrevious)
  if invoiceBookWindow then
    sightexports.sGui:deleteGuiElement(invoiceBookWindow)
  end
  invoiceBookWindow = nil
  if currentInvoiceBook and invoiceBookData[currentInvoiceBook] then
    local x, y = screenX / 2 - 196, screenY / 2 - 284
    if not invoiceBookGuiNull then
      invoiceBookGuiNull = sightexports.sGui:createGuiElement("null", x, y, 0, 0)
    end
    if not invoiceBookBuyerInput then
      invoiceBookBuyerInput = sightexports.sGui:createGuiElement("input", 211, 52, 163, 90, invoiceBookGuiNull)
      sightexports.sGui:setInputPlaceholder(invoiceBookBuyerInput, "Vevő")
      sightexports.sGui:setInputColor(invoiceBookBuyerInput, "sightgrey1", "#ffffff", "sightlightgrey", "sightlightgrey", "#000000")
      sightexports.sGui:setInputChangeEvent(invoiceBookBuyerInput, "invoiceInputChangeEvent")
      sightexports.sGui:setInputMaxLength(invoiceBookBuyerInput, 40)
      sightexports.sGui:setInputMultiline(invoiceBookBuyerInput, true)
      sightexports.sGui:setInputFontPaddingHeight(invoiceBookBuyerInput, 30)
    end
    if not invoiceBookProductInput then
      invoiceBookProductInput = sightexports.sGui:createGuiElement("input", 40, 200, 334, 152, invoiceBookGuiNull)
      sightexports.sGui:setInputPlaceholder(invoiceBookProductInput, "Termék/Szolgáltatás")
      sightexports.sGui:setInputColor(invoiceBookProductInput, "sightgrey1", "#ffffff", "sightlightgrey", "sightlightgrey", "#000000")
      sightexports.sGui:setInputChangeEvent(invoiceBookProductInput, "invoiceInputChangeEvent")
      sightexports.sGui:setInputMaxLength(invoiceBookProductInput, 130)
      sightexports.sGui:setInputMultiline(invoiceBookProductInput, true)
      sightexports.sGui:setInputFontPaddingHeight(invoiceBookProductInput, 30)
    end
    if not invoiceBookNetPriceInput then
      invoiceBookNetPriceInput = sightexports.sGui:createGuiElement("input", 144, 362, 230, 25, invoiceBookGuiNull)
      sightexports.sGui:setInputPlaceholder(invoiceBookNetPriceInput, "Nettó ár")
      sightexports.sGui:setInputColor(invoiceBookNetPriceInput, "sightgrey1", "#ffffff", "sightlightgrey", "sightlightgrey", "#000000")
      sightexports.sGui:setInputChangeEvent(invoiceBookNetPriceInput, "invoiceInputChangeEvent")
      sightexports.sGui:setInputIcon(invoiceBookNetPriceInput, "dollar-sign")
      sightexports.sGui:setInputMaxLength(invoiceBookNetPriceInput, 10)
      sightexports.sGui:setInputNumberNegative(invoiceBookNetPriceInput, true)
    end
    if not invoiceBookVatPriceInput then
      invoiceBookVatPriceInput = sightexports.sGui:createGuiElement("input", 144, 432, 230, 25, invoiceBookGuiNull)
      sightexports.sGui:setInputPlaceholder(invoiceBookVatPriceInput, "Bruttó ár")
      sightexports.sGui:setInputColor(invoiceBookVatPriceInput, "sightgrey1", "#ffffff", "sightlightgrey", "sightlightgrey", "#000000")
      sightexports.sGui:setInputChangeEvent(invoiceBookVatPriceInput, "invoiceInputChangeEvent")
      sightexports.sGui:setInputIcon(invoiceBookVatPriceInput, "dollar-sign")
      sightexports.sGui:setInputMaxLength(invoiceBookVatPriceInput, 10)
      sightexports.sGui:setInputNumberNegative(invoiceBookVatPriceInput, true)
    end
    if invoiceBookBuyerInputValue then
      sightexports.sGui:setInputValue(invoiceBookBuyerInput, invoiceBookBuyerInputValue)
    else
      sightexports.sGui:setInputValue(invoiceBookBuyerInput, "")
    end
    if invoiceBookProductInputValue then
      sightexports.sGui:setInputValue(invoiceBookProductInput, invoiceBookProductInputValue)
    else
      sightexports.sGui:setInputValue(invoiceBookProductInput, "")
    end
    if invoiceBookNetPriceInputValue then
      local value = math.ceil(invoiceBookNetPriceInputValue)
      local vat = math.floor(value * 0.2)
      invoiceBookVatFormatted = sightexports.sGui:thousandsStepper(vat) .. " $"
      local new = value + vat
      sightexports.sGui:setInputValue(invoiceBookNetPriceInput, value)
      sightexports.sGui:setInputValue(invoiceBookVatPriceInput, new)
    else
      invoiceBookVatFormatted = false
      sightexports.sGui:setInputValue(invoiceBookNetPriceInput, "")
      sightexports.sGui:setInputValue(invoiceBookVatPriceInput, "")
    end
    if not invoiceBookPrevButton then
      invoiceBookPrevButton = sightexports.sGui:createGuiElement("button", -40, 268, 32, 32, invoiceBookGuiNull)
      sightexports.sGui:setGuiBackground(invoiceBookPrevButton, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(invoiceBookPrevButton, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
      sightexports.sGui:setButtonFont(invoiceBookPrevButton, "10/Ubuntu-B.ttf")
      sightexports.sGui:setButtonIcon(invoiceBookPrevButton, sightexports.sGui:getFaIconFilename("chevron-left", 32))
      sightexports.sGui:setClickEvent(invoiceBookPrevButton, "prevInvoiceInBook")
    end
    if not invoiceBookNextButton then
      invoiceBookNextButton = sightexports.sGui:createGuiElement("button", 400, 268, 32, 32, invoiceBookGuiNull)
      sightexports.sGui:setGuiBackground(invoiceBookNextButton, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(invoiceBookNextButton, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
      sightexports.sGui:setButtonFont(invoiceBookNextButton, "10/Ubuntu-B.ttf")
      sightexports.sGui:setButtonIcon(invoiceBookNextButton, sightexports.sGui:getFaIconFilename("chevron-right", 32))
      sightexports.sGui:setClickEvent(invoiceBookNextButton, "nextInvoiceInBook")
    end
    if not invoiceBookCreateButton then
      invoiceBookCreateButton = sightexports.sGui:createGuiElement("button", 121, 576, 150, 30, invoiceBookGuiNull)
      sightexports.sGui:setGuiBackground(invoiceBookCreateButton, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(invoiceBookCreateButton, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      sightexports.sGui:setButtonFont(invoiceBookCreateButton, "13/BebasNeueBold.otf")
      sightexports.sGui:setButtonText(invoiceBookCreateButton, " Számla kiállítása")
      sightexports.sGui:setButtonIcon(invoiceBookCreateButton, sightexports.sGui:getFaIconFilename("pen", 30))
      sightexports.sGui:setClickEvent(invoiceBookCreateButton, "createInvoicePlayerList")
    end
    sightexports.sGui:setGuiRenderDisabled(invoiceBookBuyerInput, not invoiceCreating and currentInvoice and true)
    sightexports.sGui:setGuiRenderDisabled(invoiceBookProductInput, not invoiceCreating and currentInvoice and true)
    sightexports.sGui:setGuiRenderDisabled(invoiceBookNetPriceInput, not invoiceCreating and currentInvoice and true)
    sightexports.sGui:setGuiRenderDisabled(invoiceBookVatPriceInput, not invoiceCreating and currentInvoice and true)
    if currentInvoice == currentInvoiceBook .. "-100" then
      sightexports.sGui:setGuiRenderDisabled(invoiceBookNextButton, true)
    else
      sightexports.sGui:setGuiRenderDisabled(invoiceBookNextButton, invoiceCreating or not currentInvoice)
    end
    sightexports.sGui:setGuiRenderDisabled(invoiceBookPrevButton, invoiceCreating or disablePrevious)
    sightexports.sGui:setGuiRenderDisabled(invoiceBookCreateButton, not invoiceCreating and currentInvoice and true)
  else
    if invoiceBookGuiNull then
      sightexports.sGui:deleteGuiElement(invoiceBookGuiNull)
    end
    invoiceBookGuiNull = nil
    invoiceBookBuyerInput = false
    invoiceBookProductInput = false
    invoiceBookNetPriceInput = false
    invoiceBookVatPriceInput = false
    invoiceBookNextButton = false
    invoiceBookPrevButton = false
    invoiceBookCreateButton = false
  end
  sightexports.sGui:setActiveInput(false)
end
function deleteInvoice()
  canCleanup = 10000
  currentInvoice = false
  currentInvoiceBook = false
  invoiceBookProcessGui()
  sightlangCondHandl0(true)
  sightlangCondHandl1(false)
end
function createInvoice(id)
  currentInvoice = id
  currentInvoiceBook = false
  sightlangCondHandl0(false)
  sightlangCondHandl1(true)
  invoiceBookProcessGui()
  if not invoiceDatas[currentInvoice] and not invoiceRequested[currentInvoice] then
    invoiceRequested[currentInvoice] = true
    triggerLatentServerEvent("requestInvoice", localPlayer, currentInvoice)
  end
end
function createInvoiceBook(id)
  currentInvoice = false
  currentInvoiceBook = id
  sightlangCondHandl0(false)
  sightlangCondHandl1(true)
  if not invoiceBookData[currentInvoiceBook] and not invoiceBookRequested[currentInvoiceBook] then
    invoiceBookRequested[currentInvoiceBook] = true
    triggerLatentServerEvent("requestInvoiceBook", localPlayer, currentInvoiceBook)
    invoiceBookProcessGui()
  else
    if invoiceBookData[currentInvoiceBook].lastInvoice >= 100 then
      local tmp = currentInvoiceBook .. "-" .. invoiceBookData[currentInvoiceBook].lastInvoice
      if tmp ~= currentInvoice then
        currentInvoice = tmp
        if not invoiceDatas[currentInvoice] and not invoiceRequested[currentInvoice] then
          invoiceRequested[currentInvoice] = true
          triggerLatentServerEvent("requestInvoice", localPlayer, currentInvoice)
        end
      end
    end
    if currentInvoice then
      local dat = split(currentInvoice, "-")
      local id = tonumber(dat[3])
      invoiceBookProcessGui(id <= 1)
    else
      invoiceBookProcessGui(invoiceBookData[currentInvoiceBook].lastInvoice < 1)
    end
  end
end
addEvent("gotInvoiceData", true)
addEventHandler("gotInvoiceData", getRootElement(), function(id, data)
  local time = getRealTime(data.created * 24 * 60 * 60)
  data.created = string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday)
  data.vat = math.floor(data.netPrice * 0.2)
  data.vatPrice = data.netPrice + data.vat
  data.netPrice = sightexports.sGui:thousandsStepper(data.netPrice) .. " $"
  data.vat = sightexports.sGui:thousandsStepper(data.vat) .. " $"
  data.vatPrice = sightexports.sGui:thousandsStepper(data.vatPrice) .. " $"
  if data.postfix then
    data.postfix = "(" .. data.postfix .. ")"
  end
  invoiceDatas[id] = data
end)
addEvent("gotInvoiceBookData", true)
addEventHandler("gotInvoiceBookData", getRootElement(), function(id, data, companyName, postfix, vatNumber)
  invoiceBookData[id] = data
  invoiceBookData[id].companyName = companyName
  if postfix then
    invoiceBookData[id].postfix = "(" .. postfix .. ")"
  end
  invoiceBookData[id].vatNumber = vatNumber
  if currentInvoiceBook == id then
    if invoiceBookData[id].lastInvoice >= 100 then
      local tmp = id .. "-" .. invoiceBookData[id].lastInvoice
      if tmp ~= currentInvoice then
        currentInvoice = tmp
        if not invoiceDatas[currentInvoice] and not invoiceRequested[currentInvoice] then
          invoiceRequested[currentInvoice] = true
          triggerLatentServerEvent("requestInvoice", localPlayer, currentInvoice)
        end
      end
    end
    if currentInvoice then
      local dat = split(currentInvoice, "-")
      local id = tonumber(dat[3])
      invoiceBookProcessGui(id <= 1)
    else
      invoiceBookProcessGui(invoiceBookData[id].lastInvoice < 1)
    end
  end
end)
