local sightexports = {sGui = false, sItems = false}
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
local screenX, screenY = guiGetScreenSize()
local dashboardGridSize = {6, 4}
local dashboardPadding = {
  screenX <= 1366 and math.floor(screenX * 0.075) or math.floor(screenX * 0.15),
  math.floor(screenY * 0.15),
  screenX <= 1366 and (screenX <= 1024 and 2 or 3) or 4
}
local oneSize = {
  math.floor((screenX - dashboardPadding[1] * 2) / dashboardGridSize[1] / 10 + 0.5) * 10,
  math.floor((screenY - dashboardPadding[2] * 2) / dashboardGridSize[2] / 10 + 0.5) * 10
}
local dashSize = {
  oneSize[1] * dashboardGridSize[1],
  oneSize[2] * dashboardGridSize[2]
}
local shopSize = {
  math.max(3, math.floor(dashSize[1] / 220)),
  math.max(2, math.floor(dashSize[2] / 190))
}
local currentMenu = 1
local currentPage = 1
local pagerButtons = {}
local inside = false
buyingItem = false
local ppBuyWindow = false
local buyingWindow = false
local buyingRect = false
local buyingLabel = false
local shopButtons = false
function ppInsideDestroy()
  pagerButtons = false
  buyingLabel = false
  buyingItem = false
  shopButtons = false
  inside = false
  if ppBuyRect then
    sightexports.sGui:deleteGuiElement(ppBuyRect)
  end
  ppBuyRect = false
  if ppBuyWindow then
    sightexports.sGui:deleteGuiElement(ppBuyWindow)
  end
  ppBuyWindow = false
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  buyingRect = false
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    if closeButton then
      sightexports.sGui:lockHover(closeButton, false)
    end
    if helpIcon then
      sightexports.sGui:lockHover(helpIcon, false)
    end
  end
  buyingWindow = false
end
local rtg = false
local sx, sy = 0, 0
local buttonsWidth = 0
addEvent("ppShopPageSelector", true)
addEventHandler("ppShopPageSelector", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if pagerButtons[el] then
    if tonumber(pagerButtons[el]) then
      currentPage = pagerButtons[el]
    elseif pagerButtons[el] == "next" then
      currentPage = currentPage + 1
    elseif pagerButtons[el] == "prev" then
      currentPage = currentPage - 1
    end
    drawPPMenu()
  end
end)
function drawPPMenu()
  shopButtons = {}
  buyingLabel = false
  buyingItem = false
  if ppBuyRect then
    sightexports.sGui:deleteGuiElement(ppBuyRect)
  end
  ppBuyRect = false
  if ppBuyWindow then
    sightexports.sGui:deleteGuiElement(ppBuyWindow)
  end
  ppBuyWindow = false
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  buyingRect = false
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    sightexports.sGui:lockHover(rtg, false)
    sightexports.sGui:lockHover(closeButton, false)
    sightexports.sGui:lockHover(helpIcon, false)
  end
  buyingWindow = false
  if inside then
    sightexports.sGui:deleteGuiElement(inside)
  end
  inside = sightexports.sGui:createGuiElement("null", 0, 0, sx, sy, rtg)
  local label = sightexports.sGui:createGuiElement("label", dashboardPadding[3] * 4, 0, buttonsWidth - dashboardPadding[3] * 4 * 2, sy, inside)
  sightexports.sGui:setLabelFont(label, "15/BebasNeueRegular.otf")
  sightexports.sGui:setLabelAlignment(label, "left", "bottom")
  sightexports.sGui:setLabelText(label, "Egyenleg:\n" .. sightexports.sGui:getColorCodeHex("sightblue") .. sightexports.sGui:thousandsStepper(ppBalance) .. " PP")
  local btn = sightexports.sGui:createGuiElement("button", buttonsWidth / 2 + dashboardPadding[3] * 4, sy - 30, buttonsWidth / 2 - dashboardPadding[3] * 4 * 2, 30, inside)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightblue",
    "sightblue-second"
  })
  sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
  sightexports.sGui:setButtonText(btn, "PP vásárlás")
  sightexports.sGui:setClickEvent(btn, "openSMSPanel", false)
  local x = buttonsWidth + dashboardPadding[3] * 2
  local y = dashboardPadding[3] * 2
  local oneX = (sx - x + dashboardPadding[3] * 2) / shopSize[1]
  local oneY = sy / shopSize[2]
  local num = shopSize[1] * shopSize[2]
  local pages = math.ceil(#menus[currentMenu].items / num)
  pagerButtons = {}
  oneX = (sx - x - 64 + dashboardPadding[3] * 2) / shopSize[1]
  x = x + 32
  oneY = (sy - 24) / shopSize[2]
  if 1 < currentPage then
    local rect = sightexports.sGui:createGuiElement("rectangle", buttonsWidth, dashboardPadding[3] * 4, 32 + dashboardPadding[3] * 2, sy - 24 - dashboardPadding[3] * 4, inside)
    local el = sightexports.sGui:createGuiElement("image", buttonsWidth + dashboardPadding[3] * 1, dashboardPadding[3] * 4 + (sy - 24 - dashboardPadding[3] * 4) / 2 - 16, 32, 32, inside)
    sightexports.sGui:setGuiHover(el, "solid", "sightblue")
    sightexports.sGui:setGuiHoverable(el, true)
    sightexports.sGui:setClickEvent(el, "ppShopPageSelector")
    sightexports.sGui:setImageFile(el, sightexports.sGui:getFaIconFilename("chevron-left", 32))
    sightexports.sGui:setGuiBoundingBox(el, rect)
    pagerButtons[el] = "prev"
  end
  if pages > currentPage then
    local rect = sightexports.sGui:createGuiElement("rectangle", sx + dashboardPadding[3] * 4 - 32 - dashboardPadding[3] * 2, dashboardPadding[3] * 4, 32 + dashboardPadding[3] * 2, sy - 24 - dashboardPadding[3] * 4, inside)
    local el = sightexports.sGui:createGuiElement("image", sx + dashboardPadding[3] * 4 - 32 - dashboardPadding[3] * 1, dashboardPadding[3] * 4 + (sy - 24 - dashboardPadding[3] * 4) / 2 - 16, 32, 32, inside)
    sightexports.sGui:setGuiHover(el, "solid", "sightblue")
    sightexports.sGui:setGuiHoverable(el, true)
    sightexports.sGui:setClickEvent(el, "ppShopPageSelector")
    sightexports.sGui:setImageFile(el, sightexports.sGui:getFaIconFilename("chevron-right", 32))
    sightexports.sGui:setGuiBoundingBox(el, rect)
    pagerButtons[el] = "next"
  end
  for i = 1, pages do
    local el = sightexports.sGui:createGuiElement("image", buttonsWidth + (sx - buttonsWidth + dashboardPadding[3] * 4) / 2 - pages * 16 / 2 + (i - 1) * 16, sy - 24 + dashboardPadding[3] * 4, 16, 16, inside)
    sightexports.sGui:setGuiHover(el, "solid", "sightblue")
    sightexports.sGui:setGuiHoverable(el, i ~= currentPage)
    sightexports.sGui:setClickEvent(el, "ppShopPageSelector")
    sightexports.sGui:setImageFile(el, sightexports.sGui:getFaIconFilename("circle", 16, i == currentPage and "solid" or "regular"))
    pagerButtons[el] = i
  end
  local h = sightexports.sGui:getFontHeight("14/BebasNeueRegular.otf")
  local w = oneX - dashboardPadding[3] * 4
  local col = sightexports.sGui:getColorCode("sightgrey2")
  for i = 1, shopSize[1] do
    y = dashboardPadding[3] * 2
    for j = 1, shopSize[2] do
      local id = i + (j - 1) * shopSize[1] + (currentPage - 1) * num
      local data = menus[currentMenu].items[id]
      if data then
        local rect = sightexports.sGui:createGuiElement("rectangle", x + dashboardPadding[3] * 2 + 1, y + dashboardPadding[3] * 2 + 1, w, oneY - dashboardPadding[3] * 4, inside)
        sightexports.sGui:setGuiBackground(rect, "solid", "#000000")
        local rect = sightexports.sGui:createGuiElement("rectangle", x + dashboardPadding[3] * 2, y + dashboardPadding[3] * 2, w, oneY - dashboardPadding[3] * 4, inside)
        sightexports.sGui:setGuiBackground(rect, "gradient", {"sightgrey3", "sightgrey1"})
        --local black = sightexports.sGui:createGuiElement("image", (x + w) - (w / 2) + dashboardPadding[3] * 2 + 10, y - 1, w / 2, w / 2, inside) -- Black Weekend
        --sightexports.sGui:setImageDDS(black, ":sDashboard/files/black.dds") -- Black Weekend
        local item = sightexports.sGui:createGuiElement("image", math.floor(x + oneX / 2 - 18) - 15, math.floor(y + dashboardPadding[3] * 4 + 9) - 15, 66, 66, inside)
        sightexports.sGui:setImageDDS(item, ":sHud/files/itemHover.dds")
        sightexports.sGui:setImageColor(item, "sightblue")
        local item = sightexports.sGui:createGuiElement("image", math.floor(x + oneX / 2 - 18), math.floor(y + dashboardPadding[3] * 4 + 9), 36, 36, inside)
        if data[1] == "money" then
          sightexports.sGui:setImageDDS(item, ":sDashboard/files/money.dds")
        else
          sightexports.sGui:setImageFile(item, ":sItems/" .. sightexports.sItems:getItemPic(data[1]))
        end
        if weaponPreviewNames[data[1]] then
          sightexports.sGui:guiSetTooltipImageDDS(item, ":sDashboard/files/weps/" .. weaponPreviewNames[data[1]] .. ".dds", 512, 288)
          sightexports.sGui:setGuiHoverable(item, true)
        end
        local itemData = false
        if data[3] then
          local index = data[1] .. "-" .. data[3]
          itemData = itemDatas[index]
        else
          itemData = itemDatas[data[1]]
        end
        local label = sightexports.sGui:createGuiElement("label", x, y + dashboardPadding[3] * 4 + 45, oneX, oneY - dashboardPadding[3] * 6 - 48 - (dashboardPadding[3] * 4 + 45), inside)
        sightexports.sGui:setLabelFont(label, "14/BebasNeueRegular.otf")
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelText(label, utf8.upper(itemData[1]))
        local width = sightexports.sGui:getLabelTextWidth(label)
        local specialTooltip = sightexports.sItems:getItemSpecialTooltip(data[1])
        if width >= w - 16 then
          local text = utf8.sub(utf8.upper(itemData[1]), 1, -6)
          if utf8.sub(text, 1) == " " then
            text = utf8.sub(utf8.upper(itemData[1]), 1, -2)
          end
          text = text .. "..."
          local i = utf8.len(text)
          while width >= w - 16 do
            sightexports.sGui:setLabelText(label, text)
            width = sightexports.sGui:getLabelTextWidth(label)
            text = utf8.sub(text, 1, -6) .. "..."
          end
          if weaponAmmoNames[data[1]] then
            sightexports.sGui:guiSetTooltip(label, itemData[1] .. "\nLőszer: " .. sightexports.sGui:getColorCodeHex("sightblue") .. weaponAmmoNames[data[1]])
          elseif weaponsForAmmo[data[1]] then
            sightexports.sGui:guiSetTooltip(label, itemData[1] .. "\n" .. sightexports.sGui:getColorCodeHex("sightblue") .. "Fegyverek:\n" .. table.concat(weaponsForAmmo[data[1]], "\n"))
          elseif specialTooltip then
            specialTooltip = utf8.gsub(specialTooltip, "\n", "\n" .. sightexports.sGui:getColorCodeHex("sightblue"))
            sightexports.sGui:guiSetTooltip(label, itemData[1] .. "\n" .. sightexports.sGui:getColorCodeHex("sightblue") .. specialTooltip)
          else
            sightexports.sGui:guiSetTooltip(label, itemData[1])
          end
          sightexports.sGui:setGuiHoverable(label, true)
        elseif weaponAmmoNames[data[1]] then
          sightexports.sGui:guiSetTooltip(label, "Lőszer: " .. sightexports.sGui:getColorCodeHex("sightblue") .. weaponAmmoNames[data[1]])
          sightexports.sGui:setGuiHoverable(label, true)
        elseif weaponsForAmmo[data[1]] then
          sightexports.sGui:guiSetTooltip(label, sightexports.sGui:getColorCodeHex("sightblue") .. "Fegyverek:\n" .. table.concat(weaponsForAmmo[data[1]], "\n"))
          sightexports.sGui:setGuiHoverable(label, true)
        elseif specialTooltip then
          specialTooltip = utf8.gsub(specialTooltip, "\n", "\n" .. sightexports.sGui:getColorCodeHex("sightblue"))
          sightexports.sGui:guiSetTooltip(label, sightexports.sGui:getColorCodeHex("sightblue") .. specialTooltip)
          sightexports.sGui:setGuiHoverable(label, true)
        end
        if data[2] > ppBalance then
          local btn = sightexports.sGui:createGuiElement("button", x + dashboardPadding[3] * 4, y + oneY - dashboardPadding[3] * 4 - 24, oneX - dashboardPadding[3] * 8, 24, inside)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
          sightexports.sGui:setElementDisabled(btn, true)
          sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
          sightexports.sGui:setButtonTextColor(btn, "#ffffff")
          sightexports.sGui:setButtonText(btn, "Nincs elég PP-d!")
        else
          local btn = sightexports.sGui:createGuiElement("button", x + dashboardPadding[3] * 4, y + oneY - dashboardPadding[3] * 4 - 24, oneX - dashboardPadding[3] * 8, 24, inside)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
          sightexports.sGui:setGuiHover(btn, "gradient", {
            "sightblue",
            "sightblue-second"
          })
          sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
          sightexports.sGui:setButtonTextColor(btn, "#ffffff")
          sightexports.sGui:setButtonText(btn, "VÁSÁRLÁS")
          shopButtons[btn] = {
            currentMenu,
            id,
            data
          }
          sightexports.sGui:setClickEvent(btn, "buyPPItem", false)
        end
        -- data[2] = data[2] * 0.8 -- Black Weekend
        local text = " " .. sightexports.sGui:thousandsStepper(data[2]) .. " PP "
        local tw = sightexports.sGui:getTextWidthFont(text, "13/BebasNeueBold.otf")
        local rect = sightexports.sGui:createGuiElement("rectangle", x + oneX / 2 - tw / 2, y + oneY - dashboardPadding[3] * 6 - 48, tw, 24, inside)
        sightexports.sGui:setGuiBackground(rect, "solid", "sightgreen") -- Black Weekend (ha igen, cseréld sightred)
        local label = sightexports.sGui:createGuiElement("label", 0, 0, tw, 24, rect)
        sightexports.sGui:setLabelFont(label, "13/BebasNeueBold.otf")
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelText(label, text)
        sightexports.sGui:setLabelColor(label, "sightgrey1") -- Black Weekend (ha igen, kommenteld ki)
        if data[2] > ppBalance then
          local rect = sightexports.sGui:createGuiElement("rectangle", x + dashboardPadding[3] * 2, y + dashboardPadding[3] * 2, w + 1, oneY, inside)
          sightexports.sGui:setGuiBackground(rect, "solid", {
            col[1],
            col[2],
            col[3],
            125
          })
          end
        end
      y = y + oneY
    end
    x = x + oneX
  end
end

addEvent("gotPremiumData", true)
addEventHandler("gotPremiumData", getRootElement(), function(balance)
  ppBalance = balance
  if dashboardState then
    sightexports.sGui:setLabelText(ppLabelElement, sightexports.sGui:thousandsStepper(ppBalance) .. " PP")
    sightexports.sGui:setGuiSize(ppLabelElement2, sightexports.sGui:getGuiSize(ppLabelElement, "x") - sightexports.sGui:getLabelTextWidth(ppLabelElement), false)
    if dashboardExpanded then
      refreshVehiclesBottomLabel()
      local i, j = dashboardExpanded[1], dashboardExpanded[2]
      if dashboardLayout[i][j].ppShop then
        drawPPMenu()
      end
    end
  end
end)
function ppInsideDraw(x, y, isx, isy, i, j, irtg)
  rtg = irtg
  sx, sy = isx, isy
  buttonsWidth = 0
  local fontSize = bebasSize - 10
  local buttonsHeight = sightexports.sGui:getFontHeight(fontSize .. "/BebasNeueRegular.otf") + dashboardPadding[3] * 4
  for k = 1, #menus do
    local w = sightexports.sGui:getTextWidthFont(menus[k].name, fontSize .. "/BebasNeueRegular.otf")
    if w > buttonsWidth then
      buttonsWidth = w
    end
  end
  buttonsWidth = buttonsWidth + dashboardPadding[3] * 8
  local rect = sightexports.sGui:createGuiElement("rectangle", x + buttonsWidth, y, sx - buttonsWidth, sy, rtg)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey2")
  for k = 1, #menus do
    menus[k].button = sightexports.sGui:createGuiElement("button", x, y, buttonsWidth, buttonsHeight, rtg)
    if currentMenu == k then
      sightexports.sGui:setGuiBackground(menus[k].button, "solid", "sightblue")
      sightexports.sGui:setGuiHover(menus[k].button, "gradient", {
        "sightblue-second",
        "sightblue"
      }, true)
    else
      sightexports.sGui:setGuiBackground(menus[k].button, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(menus[k].button, "gradient", {"sightgrey2", "sightgrey1"}, true)
    end
    sightexports.sGui:setButtonFont(menus[k].button, fontSize .. "/BebasNeueRegular.otf")
    sightexports.sGui:setButtonTextColor(menus[k].button, "#ffffff")
    sightexports.sGui:setButtonText(menus[k].button, menus[k].name) 
    sightexports.sGui:setButtonTextAlign(menus[k].button, "left", "center")
    sightexports.sGui:setButtonTextPadding(menus[k].button, dashboardPadding[3] * 4, dashboardPadding[3] * 2)
    sightexports.sGui:setClickEvent(menus[k].button, "dashboardPPMenuClick", false)
    y = y + buttonsHeight
  end
  sx = sx - dashboardPadding[3] * 4
  sy = sy - dashboardPadding[3] * 4
  drawPPMenu()
end
addEvent("closePPBuy", true)
addEventHandler("closePPBuy", getRootElement(), function()
  buyingLabel = false
  buyingItem = false
  if buyingRect then
    sightexports.sGui:deleteGuiElement(buyingRect)
  end
  buyingRect = false
  if buyingWindow then
    sightexports.sGui:deleteGuiElement(buyingWindow)
    sightexports.sGui:lockHover(rtg, false)
    sightexports.sGui:lockHover(closeButton, false)
    sightexports.sGui:lockHover(helpIcon, false)
  end
  buyingWindow = false
end)
local currentAmount = 1
local currentPrice = 1
addEvent("changePPShopAmount", true)
addEventHandler("changePPShopAmount", getRootElement(), function(value)
  value = tonumber(value)
  if value then
    if 1 <= value then
      currentAmount = round2(value)
    else
      currentAmount = 1
    end
  else
    currentAmount = 1
  end
  sightexports.sGui:setLabelText(buyingLabel, "Fizetendő: " .. sightexports.sGui:getColorCodeHex("sightblue") .. "" .. sightexports.sGui:thousandsStepper(currentPrice * currentAmount) .. " PP")
end)
addEvent("finalBuyPPItem", true)
addEventHandler("finalBuyPPItem", getRootElement(), function()
  if currentPrice * currentAmount > ppBalance then
    sightexports.sGui:showInfobox("e", "Nincs elég PrémiumPontod!")
  elseif buyingItem then
    triggerServerEvent("buyPremiumItem", localPlayer, buyingItem[1], buyingItem[2], currentAmount)
    buyingLabel = false
    buyingItem = false
    if buyingRect then
      sightexports.sGui:deleteGuiElement(buyingRect)
    end
    buyingRect = false
    if buyingWindow then
      sightexports.sGui:deleteGuiElement(buyingWindow)
      sightexports.sGui:lockHover(rtg, false)
      sightexports.sGui:lockHover(closeButton, false)
      sightexports.sGui:lockHover(helpIcon, false)
    end
    buyingWindow = false
  end
end)
addEvent("closeSMSPanel", true)
addEventHandler("closeSMSPanel", getRootElement(), function()
  sightexports.sGui:lockHover(rtg, false)
  sightexports.sGui:lockHover(closeButton, false)
  sightexports.sGui:lockHover(helpIcon, false)
  if ppBuyRect then
    sightexports.sGui:deleteGuiElement(ppBuyRect)
  end
  ppBuyRect = false
  if ppBuyWindow then
    sightexports.sGui:deleteGuiElement(ppBuyWindow)
  end
  ppBuyWindow = false
end)
addEvent("openSMSPanel", true)
addEventHandler("openSMSPanel", getRootElement(), function()
  sightexports.sGui:lockHover(rtg, true)
  sightexports.sGui:lockHover(closeButton, true)
  sightexports.sGui:lockHover(helpIcon, true)
  ppBuyRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
  sightexports.sGui:setGuiBackground(ppBuyRect, "solid", {
    0,
    0,
    0,
    150
  })
  sightexports.sGui:setGuiHover(ppBuyRect, "none")
  sightexports.sGui:setGuiHoverable(ppBuyRect, true)
  sightexports.sGui:disableClickTrough(ppBuyRect, true)
  sightexports.sGui:disableLinkCursor(ppBuyRect, true)
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local panelWidth = 780
  local panelHeight = titleBarHeight + 300 + 10 + 30 + 20
  ppBuyWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
  sightexports.sGui:setWindowTitle(ppBuyWindow, "16/BebasNeueRegular.otf", "PrémiumPont vásárlás - https://discord.gg/sightmta")
  sightexports.sGui:setWindowCloseButton(ppBuyWindow, "closeSMSPanel")
  local item = sightexports.sGui:createGuiElement("image", 421, titleBarHeight + 10, 349, 300, ppBuyWindow)
  sightexports.sGui:setImageDDS(item, ":sDashboard/files/ill.dds")
  local label = sightexports.sGui:createGuiElement("label", 10, titleBarHeight, 401, 320, ppBuyWindow)
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelWordBreak(label, true)
  sightexports.sGui:setLabelText(label, "Account ID: " .. getElementData(localPlayer, "char.accID") .. "\n\n\t\t\t- Több fizetési mód is elérhető:\n\t\t\tEzek között szerepel a banki átutalás, a paypal-al történő fizetés, illetve az emelt díjas hívás.\n\t\t\t\n\t\t\t- Az összeg elküldése után, minél hamarabb megfogod kapni a Prémium mennyiséget!\n\t\t\t\n\t\t\t- Banki utalás és a paypal-os támogatás esetén nagyobb, kedvezőbb csomagok is elérhetőek!\n\n\t\t\t- Banki átutalás/Paypal fizetés esetén bónusz PrémiumPont jár.")
  local btn = sightexports.sGui:createGuiElement("button", 10, titleBarHeight + 300 + 20, panelWidth - 20, 30, ppBuyWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
  sightexports.sGui:setButtonText(btn, " Tekintsd meg a discord támogatási szobánkat!")
  sightexports.sGui:setClickEvent(btn, "openPremiumShop")
  sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("discord", 30, "brands"))
end)
addEvent("openPremiumShop", true)
addEventHandler("openPremiumShop", getRootElement(), function()
  setClipboard("discord.gg/sightmta")
  exports.sGui:showInfobox("s", "Sikeresen vágólapra másoltad a discord meghívót")
end)
addEvent("buyPPItem", true)
addEventHandler("buyPPItem", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if shopButtons and shopButtons[el] then
    currentAmount = 1
    buyingItem = shopButtons[el]
    local data = buyingItem[3]
    currentPrice = data[2]
    local itemData = false
    if data[3] then
      local index = data[1] .. "-" .. data[3]
      itemData = itemDatas[index]
    else
      itemData = itemDatas[data[1]]
    end
    local canBuyMultiple = itemData[3]
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local h = sightexports.sGui:getFontHeight("14/BebasNeueRegular.otf")
    local panelWidth = 300
    local panelHeight = titleBarHeight + 5 + 66 + 5 + h + h * 2 + 30 + 5 + 5 + 5
    if canBuyMultiple then
      panelHeight = panelHeight + 32 + 5
    end
    sightexports.sGui:lockHover(rtg, true)
    sightexports.sGui:lockHover(closeButton, true)
    sightexports.sGui:lockHover(helpIcon, true)
    buyingRect = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
    sightexports.sGui:setGuiBackground(buyingRect, "solid", {
      0,
      0,
      0,
      150
    })
    sightexports.sGui:setGuiHover(buyingRect, "none")
    sightexports.sGui:setGuiHoverable(buyingRect, true)
    sightexports.sGui:disableClickTrough(buyingRect, true)
    sightexports.sGui:disableLinkCursor(buyingRect, true)
    buyingWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
    sightexports.sGui:setWindowTitle(buyingWindow, "16/BebasNeueRegular.otf", "Prémium shop vásárlás")
    local y = titleBarHeight + 5
    local item = sightexports.sGui:createGuiElement("image", panelWidth / 2 - 33, y, 66, 66, buyingWindow)
    sightexports.sGui:setImageDDS(item, ":sHud/files/itemHover.dds")
    sightexports.sGui:setImageColor(item, "sightblue")
    local item = sightexports.sGui:createGuiElement("image", panelWidth / 2 - 18, y + 15, 36, 36, buyingWindow)
    if data[1] == "money" then
      sightexports.sGui:setImageDDS(item, ":sDashboard/files/money.dds")
    else
      sightexports.sGui:setImageFile(item, ":sItems/" .. sightexports.sItems:getItemPic(data[1]))
    end
    if weaponPreviewNames[data[1]] then
      sightexports.sGui:guiSetTooltipImageDDS(item, ":sDashboard/files/weps/" .. weaponPreviewNames[data[1]] .. ".dds", 512, 288)
      sightexports.sGui:setGuiHoverable(item, true)
    end
    y = y + 66 + 5
    local label = sightexports.sGui:createGuiElement("label", 5, y, panelWidth - 5, h, buyingWindow)
    sightexports.sGui:setLabelFont(label, "14/BebasNeueRegular.otf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, utf8.upper(itemData[1]))
    y = y + h + 5
    if canBuyMultiple then
      local input = sightexports.sGui:createGuiElement("input", 32, y, panelWidth - 64, 32, buyingWindow)
      sightexports.sGui:setInputFont(input, "11/Ubuntu-R.ttf")
      sightexports.sGui:setInputIcon(input, "boxes")
      sightexports.sGui:setInputPlaceholder(input, "Mennyiség")
      sightexports.sGui:setInputMaxLength(input, 5)
      sightexports.sGui:setInputNumberOnly(input, true)
      sightexports.sGui:setInputChangeEvent(input, "changePPShopAmount")
      y = y + 32 + 5
    end
    buyingLabel = sightexports.sGui:createGuiElement("label", 5, y, panelWidth - 5, h * 2, buyingWindow)
    sightexports.sGui:setLabelFont(buyingLabel, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(buyingLabel, "center", "center")
    sightexports.sGui:setLabelText(buyingLabel, "Fizetendő: " .. sightexports.sGui:getColorCodeHex("sightblue") .. "" .. sightexports.sGui:thousandsStepper(currentPrice * currentAmount) .. " PP")
    sightexports.sGui:setLabelColor(buyingLabel, "sightlightgrey")
    local btnW = (panelWidth - 15) / 2
    local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 35, btnW, 30, buyingWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Vásárlás")
    sightexports.sGui:setClickEvent(btn, "finalBuyPPItem", false)
    local btn = sightexports.sGui:createGuiElement("button", 10 + btnW, panelHeight - 35, btnW, 30, buyingWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonTextColor(btn, "#ffffff")
    sightexports.sGui:setButtonText(btn, "Mégsem")
    sightexports.sGui:setClickEvent(btn, "closePPBuy", false)
  end
end)
addEvent("dashboardPPMenuClick", true)
addEventHandler("dashboardPPMenuClick", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for k = 1, #menus do
    if el == menus[k].button then
      currentMenu = k
      currentPage = 1
      sightexports.sGui:setGuiBackground(menus[k].button, "solid", "sightblue")
      sightexports.sGui:setGuiHover(menus[k].button, "gradient", {
        "sightblue-second",
        "sightblue"
      }, true)
    else
      sightexports.sGui:setGuiBackground(menus[k].button, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(menus[k].button, "gradient", {"sightgrey2", "sightgrey1"}, true)
    end
  end
  drawPPMenu()
end)
