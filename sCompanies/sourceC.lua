local sightexports = {sGui = false, sGroups = false}
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
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientKey", getRootElement(), companyListScrollHandler, true, prio)
    else
      removeEventHandler("onClientKey", getRootElement(), companyListScrollHandler)
    end
  end
end
screenX, screenY = guiGetScreenSize()
local officePedPoses = {
  {
    295,
    "Gayse Tailor",
    1524.0234375,
    -1796.845703125,
    17.54686164856,
    270
  },
  {
    151,
    "Falcho Chapo",
    1524.0234375,
    -1801.1484375,
    17.54686164856,
    270
  },
  {
    240,
    "Mikey Strongman Jr.",
    1524.0234375,
    -1805.353515625,
    17.54686164856,
    270
  },
  {
    186,
    "Chie Poess",
    1538.1875,
    -1805.2939453125,
    17.54686164856,
    90
  },
  {
    192,
    "Anita Missecret",
    1538.1875,
    -1801.0732421875,
    17.54686164856,
    90
  },
  {
    219,
    "Roxana Coppersmith",
    1538.1875,
    -1796.79296875,
    17.54686164856,
    90
  },
  {
    57,
    "Michael Strongman",
    -1608.4365234375,
    693.5751953125,
    8997.708984375,
    90,
    1,
    1
  }
}
local officePeds = {}
for i = 1, #officePedPoses do
  local ped = createPed(officePedPoses[i][1], officePedPoses[i][3], officePedPoses[i][4], officePedPoses[i][5], officePedPoses[i][6])
  setElementData(ped, "visibleName", officePedPoses[i][2])
  if officePedPoses[i][7] then
    setElementInterior(ped, officePedPoses[i][7])
  end
  if officePedPoses[i][8] then
    setElementDimension(ped, officePedPoses[i][8])
  end
  setElementData(ped, "pedNameType", "NAV Ügyintéző")
  setElementFrozen(ped, true)
  setElementData(ped, "invulnerable", true)
  officePeds[ped] = true
end
local newCompanyWindow = false
local newCompanyInputs = false
local companyList = false
local rawCompanyList = false
function deleteNewCompanyWindow()
  if newCompanyWindow then
    sightexports.sGui:deleteGuiElement(newCompanyWindow)
  end
  newCompanyWindow = nil
  newCompanyInputs = {}
end
addEvent("closeNewCompanyWindow", false)
addEventHandler("closeNewCompanyWindow", getRootElement(), deleteNewCompanyWindow)
addEvent("createNewCompany", false)
addEventHandler("createNewCompany", getRootElement(), function()
  local name = sightexports.sGui:getInputValue(newCompanyInputs.name)
  local owner = tonumber(sightexports.sGui:getInputValue(newCompanyInputs.owner))
  local activity = sightexports.sGui:getInputValue(newCompanyInputs.activity)
  local postfix = sightexports.sGui:getInputValue(newCompanyInputs.postfix)
  if not (name and owner) or owner < 1 or not activity then
    sightexports.sGui:showInfobox("e", "Minden mező kitöltése kötelező!")
    return
  end
  deleteNewCompanyWindow()
  triggerServerEvent("createNewCompany", localPlayer, name, owner, activity, postfix)
  createCompanyListLoader()
end)
addEvent("editExistingCompany", false)
addEventHandler("editExistingCompany", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
  local name = sightexports.sGui:getInputValue(newCompanyInputs.name)
  local owner = tonumber(sightexports.sGui:getInputValue(newCompanyInputs.owner))
  local activity = sightexports.sGui:getInputValue(newCompanyInputs.activity)
  local postfix = sightexports.sGui:getInputValue(newCompanyInputs.postfix)
  if not (name and owner) or owner < 1 or not activity then
    sightexports.sGui:showInfobox("e", "Minden mező kitöltése kötelező!")
    return
  end
  deleteNewCompanyWindow()
  rawCompanyList = false
  triggerServerEvent("editExistingCompany", localPlayer, id, name, owner, activity, postfix)
  createCompanyListLoader()
end)
addEvent("createNewCompanyWindow", false)
addEventHandler("createNewCompanyWindow", getRootElement(), function(button, state, absoluteX, absoluteY, el, arg)
  if arg then
    createNewCompanyWindow(unpack(arg))
  else
    createNewCompanyWindow(arg)
  end
end)
function createNewCompanyWindow(id, name, owner, activity, postfix)
  deleteNewCompanyWindow()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local pw, ph = 350, titleBarHeight + 210 + 48 + 32
  newCompanyWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowTitle(newCompanyWindow, "16/BebasNeueRegular.otf", "Cég " .. (id and "szerkesztése" or "létrehozása"))
  sightexports.sGui:setWindowCloseButton(newCompanyWindow, "closeNewCompanyWindow")
  local y = titleBarHeight + 8
  newCompanyInputs.name = sightexports.sGui:createGuiElement("input", 8, y, pw - 16, 30, newCompanyWindow)
  sightexports.sGui:setInputPlaceholder(newCompanyInputs.name, "Cég neve")
  sightexports.sGui:setInputIcon(newCompanyInputs.name, "store-alt")
  sightexports.sGui:setInputMaxLength(newCompanyInputs.name, 32)
  if name then
    sightexports.sGui:setInputValue(newCompanyInputs.name, name)
  end
  y = y + 30 + 8
  newCompanyInputs.owner = sightexports.sGui:createGuiElement("input", 8, y, pw - 16, 30, newCompanyWindow)
  sightexports.sGui:setInputPlaceholder(newCompanyInputs.owner, "Cégtulajdonos Karakter ID")
  sightexports.sGui:setInputIcon(newCompanyInputs.owner, "user")
  sightexports.sGui:setInputMaxLength(newCompanyInputs.owner, 8)
  sightexports.sGui:setInputNumberOnly(newCompanyInputs.owner, true)
  if owner then
    sightexports.sGui:setInputValue(newCompanyInputs.owner, owner)
  end
  y = y + 30 + 8
  newCompanyInputs.postfix = sightexports.sGui:createGuiElement("input", 8, y, pw - 16, 30, newCompanyWindow)
  sightexports.sGui:setInputPlaceholder(newCompanyInputs.postfix, "NAV jelölés (nem kötelező)")
  sightexports.sGui:setInputIcon(newCompanyInputs.postfix, "tag")
  sightexports.sGui:setInputMaxLength(newCompanyInputs.postfix, 6)
  if postfix then
    sightexports.sGui:setInputValue(newCompanyInputs.postfix, postfix)
  end
  y = y + 30 + 8
  newCompanyInputs.activity = sightexports.sGui:createGuiElement("input", 8, y, pw - 16, 120, newCompanyWindow)
  sightexports.sGui:setInputPlaceholder(newCompanyInputs.activity, "Tevékenységi kör")
  sightexports.sGui:setInputMaxLength(newCompanyInputs.activity, 255)
  sightexports.sGui:setInputMultiline(newCompanyInputs.activity, true)
  sightexports.sGui:setInputFontPaddingHeight(newCompanyInputs.activity, 30)
  if activity then
    sightexports.sGui:setInputValue(newCompanyInputs.activity, activity)
  end
  y = y + 120 + 8
  local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 32, newCompanyWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  if id then
    sightexports.sGui:setButtonText(btn, "Szerkesztés")
    sightexports.sGui:setClickEvent(btn, "editExistingCompany")
    sightexports.sGui:setClickArgument(btn, id)
  else
    sightexports.sGui:setButtonText(btn, "Létrehozás")
    sightexports.sGui:setClickEvent(btn, "createNewCompany")
  end
end
local companyListWindow = false
local companyListScroll = 0
local companyListScrollH = false
local companyListScrollBar = false
local companyListSortIcons = {}
local companyListElements = {}
local companyBookElements = {}
local companyBookButton = false
local taxAccountLabel = false
local taxAccountButtons = {}
local currentSingleCompany = false
local companyTaxWindow = false
local companyTaxInput = false
function deleteCompanyListWindow()
  deleteNewCompanyWindow()
  sightlangCondHandl0(false)
  if companyTaxWindow then
    sightexports.sGui:deleteGuiElement(companyTaxWindow)
  end
  companyTaxWindow = nil
  if companyListWindow then
    sightexports.sGui:deleteGuiElement(companyListWindow)
  end
  companyListWindow = nil
  companyTaxInput = false
  currentSingleCompany = false
  companyListSortIcons = {}
  companyListElements = {}
  companyBookElements = {}
  companyBookButton = false
  taxAccountLabel = false
  taxAccountButtons = {}
  companyListScrollBar = false
  companyListScrollH = false
end
addEvent("forceDeleteCompanyListWindow", true)
addEventHandler("forceDeleteCompanyListWindow", getRootElement(), deleteCompanyListWindow)
function createCompanyListLoader()
  deleteCompanyListWindow()
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local pw, ph = 200, 150
  companyListWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowTitle(companyListWindow, "16/BebasNeueRegular.otf", "Cégek")
  local loaderIcon = sightexports.sGui:createGuiElement("image", pw / 2 - 24, titleBarHeight + (ph - titleBarHeight) / 2 - 24, 48, 48, companyListWindow)
  sightexports.sGui:setImageFile(loaderIcon, sightexports.sGui:getFaIconFilename("circle-notch", 48))
  sightexports.sGui:setImageSpinner(loaderIcon, true)
end
function companyListScrollHandler(key)
  if key == "mouse_wheel_up" then
    if 0 < companyListScroll then
      companyListScroll = companyListScroll - 1
      refreshCompanyList()
    end
  elseif key == "mouse_wheel_down" and companyListScroll < #companyList - 12 then
    companyListScroll = companyListScroll + 1
    refreshCompanyList()
  end
end
function refreshCompanyList()
  for i = 1, #companyListElements do
    local dat = companyList[i + companyListScroll]
    local label = companyListElements[i][1]
    if dat then
      sightexports.sGui:setLabelText(label, dat[1])
      sightexports.sGui:setGuiRenderDisabled(label, false)
    else
      sightexports.sGui:setGuiRenderDisabled(label, true)
    end
    local label = companyListElements[i][2]
    if dat then
      if dat[5] then
        sightexports.sGui:setLabelText(label, dat[2] .. " [color=sightred](" .. dat[5] .. ")")
      else
        sightexports.sGui:setLabelText(label, dat[2])
      end
      sightexports.sGui:setGuiRenderDisabled(label, false)
    else
      sightexports.sGui:setGuiRenderDisabled(label, true)
    end
    local label = companyListElements[i][3]
    if dat then
      sightexports.sGui:setLabelText(label, dat[3])
      sightexports.sGui:setGuiRenderDisabled(label, false)
    else
      sightexports.sGui:setGuiRenderDisabled(label, true)
    end
    local label = companyListElements[i][4]
    if dat then
      sightexports.sGui:setLabelText(label, dat[7])
      if dat[4] == 0 then
        sightexports.sGui:setLabelColor(label, "sightlightgrey")
      else
        sightexports.sGui:setLabelColor(label, dat[4] > 0 and "sightgreen" or "sightred")
      end
      sightexports.sGui:setGuiRenderDisabled(label, false)
    else
      sightexports.sGui:setGuiRenderDisabled(label, true)
    end
    local btn = companyListElements[i][5]
    if dat then
      sightexports.sGui:setClickArgument(btn, dat[1])
      sightexports.sGui:setGuiRenderDisabled(btn, false)
    else
      sightexports.sGui:setGuiRenderDisabled(btn, true)
    end
  end
  local sh = companyListScrollH / math.max(1, #companyList - 12 + 1)
  sightexports.sGui:setGuiPosition(companyListScrollBar, false, sh * companyListScroll)
  sightexports.sGui:setGuiSize(companyListScrollBar, false, sh)
end
local currentSorting = 1
local currentSortingDirection = true
local sortFunctions = {}
sortFunctions[1] = {}
sortFunctions[1][true] = function(a, b)
  return a[1] < b[1]
end
sortFunctions[1][false] = function(a, b)
  return a[1] > b[1]
end
sortFunctions[2] = {}
sortFunctions[2][true] = function(a, b)
  return a[6] < b[6]
end
sortFunctions[2][false] = function(a, b)
  return a[6] > b[6]
end
sortFunctions[3] = {}
sortFunctions[3][true] = function(a, b)
  return a[3] < b[3]
end
sortFunctions[3][false] = function(a, b)
  return a[3] > b[3]
end
sortFunctions[4] = {}
sortFunctions[4][true] = function(a, b)
  return a[4] < b[4]
end
sortFunctions[4][false] = function(a, b)
  return a[4] > b[4]
end
function sortCompanyList(tmp)
  local skip = false
  if not tmp then
    if companyList and companyList ~= rawCompanyList then
      tmp = companyList
    else
      tmp = {}
      for i = 1, #rawCompanyList do
        table.insert(tmp, rawCompanyList[i])
      end
      skip = currentSorting == 1 and currentSortingDirection
    end
  end
  if not skip then
    table.sort(tmp, sortFunctions[currentSorting][currentSortingDirection])
  end
  for i = 1, 4 do
    if i == currentSorting then
      sightexports.sGui:setImageRotation(companyListSortIcons[i], currentSortingDirection and 0 or 180)
      sightexports.sGui:setGuiRenderDisabled(companyListSortIcons[i], false)
    else
      sightexports.sGui:setGuiRenderDisabled(companyListSortIcons[i], true)
    end
  end
  if tmp then
    companyList = tmp
  end
end
addEvent("toggleCompanyListSort", true)
addEventHandler("toggleCompanyListSort", getRootElement(), function(button, state, absoluteX, absoluteY, el, cat)
  companyListScroll = 0
  if currentSorting == cat then
    currentSortingDirection = not currentSortingDirection
  else
    currentSorting = cat
    currentSortingDirection = true
  end
  sortCompanyList()
  refreshCompanyList()
end)
local checkIndexes = {
  1,
  2,
  3,
  5,
  6
}
addEvent("searchCompanyList", true)
addEventHandler("searchCompanyList", getRootElement(), function(value)
  companyListScroll = 0
  local tmp
  if value and 0 < utf8.len(value) then
    tmp = {}
    value = stripAccents(value)
    for i = 1, #rawCompanyList do
      for k = 1, #checkIndexes do
        local j = checkIndexes[k]
        if rawCompanyList[i][j] and utf8.find(utf8.lower(rawCompanyList[i][j]), value, nil, true) then
          table.insert(tmp, rawCompanyList[i])
          break
        end
      end
    end
  else
    companyList = false
  end
  sortCompanyList(tmp)
  refreshCompanyList()
end)
addEvent("refreshCompanyActiveBooks", true)
addEventHandler("refreshCompanyActiveBooks", getRootElement(), function(id, books)
  if currentSingleCompany == id then
    refreshCompanyBooks(books)
  end
end)
addEvent("refreshCompanyTaxAmount", true)
addEventHandler("refreshCompanyTaxAmount", getRootElement(), function(id, amount)
  if currentSingleCompany == id then
    refreshTaxAccountLabel(amount)
    rawCompanyList = false
  end
end)
addEvent("deleteCompanyBook", true)
addEventHandler("deleteCompanyBook", getRootElement(), function(button, state, absoluteX, absoluteY, el, book)
  if currentSingleCompany then
    triggerServerEvent("deleteCompanyBook", localPlayer, currentSingleCompany, book)
    for i = 1, 10 do
      if companyBookElements[i][3] then
        sightexports.sGui:setClickArgument(companyBookElements[i][3], true)
      end
    end
  end
end)
addEvent("requestNewInvoiceBook", true)
addEventHandler("requestNewInvoiceBook", getRootElement(), function()
  if currentSingleCompany then
    triggerServerEvent("requestNewInvoiceBook", localPlayer, currentSingleCompany)
  end
end)
addEvent("requestCompanyCard", true)
addEventHandler("requestCompanyCard", getRootElement(), function()
  if currentSingleCompany then
    triggerServerEvent("requestCompanyCard", localPlayer, currentSingleCompany)
  end
end)
function refreshCompanyBooks(books)
  local lastActive = 1
  for i = 1, 10 do
    if books[i] then
      sightexports.sGui:setLabelText(companyBookElements[i][1], books[i][1])
      local time = getRealTime(books[i][2])
      sightexports.sGui:setLabelText(companyBookElements[i][2], string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second))
      if companyBookElements[i][3] then
        sightexports.sGui:setClickArgument(companyBookElements[i][3], books[i][1])
      end
      for j = 1, #companyBookElements[i] do
        sightexports.sGui:setGuiRenderDisabled(companyBookElements[i][j], false)
      end
      lastActive = i + 1
    else
      for j = 1, #companyBookElements[i] do
        sightexports.sGui:setGuiRenderDisabled(companyBookElements[i][j], true)
      end
    end
  end
  if companyBookButton then
    if companyBookElements[lastActive] then
      sightexports.sGui:setGuiRenderDisabled(companyBookButton, false)
      local x, y = sightexports.sGui:getGuiPosition(companyBookElements[lastActive][1])
      sightexports.sGui:setGuiPosition(companyBookButton, false, y)
    else
      sightexports.sGui:setGuiRenderDisabled(companyBookButton, true)
    end
  end
end
function refreshTaxAccountLabel(amount)
  sightexports.sGui:setLabelText(taxAccountLabel, sightexports.sGui:thousandsStepper(amount) .. " $")
  if amount == 0 then
    sightexports.sGui:setLabelColor(taxAccountLabel, "sightlightgrey")
  else
    sightexports.sGui:setLabelColor(taxAccountLabel, 0 < amount and "sightgreen" or "sightred")
  end
  local x = sightexports.sGui:getGuiPosition(taxAccountLabel)
  x = x + sightexports.sGui:getLabelTextWidth(taxAccountLabel) + 8
  for i = 1, #taxAccountButtons do
    sightexports.sGui:setGuiPosition(taxAccountButtons[i], x)
    sightexports.sGui:setGuiRenderDisabled(taxAccountButtons[i], false)
    x = x + 24 + 4
  end
end
addEvent("closeCompanyTaxAccount", false)
addEventHandler("closeCompanyTaxAccount", getRootElement(), function()
  if companyTaxWindow then
    sightexports.sGui:deleteGuiElement(companyTaxWindow)
  end
  companyTaxWindow = nil
  companyTaxInput = false
end)
addEvent("finalCompanyTaxAccountTransaction", false)
addEventHandler("finalCompanyTaxAccountTransaction", getRootElement(), function(button, state, absoluteX, absoluteY, el, transType)
  if companyTaxInput then
    local val = tonumber(sightexports.sGui:getInputValue(companyTaxInput))
    if val and 0 < val then
      if currentSingleCompany then
        triggerServerEvent("companyTaxAccountTransaction", localPlayer, currentSingleCompany, transType, val)
        for i = 1, #taxAccountButtons do
          sightexports.sGui:setGuiRenderDisabled(taxAccountButtons[i], true)
        end
      end
    else
      sightexports.sGui:showInfobox("e", "Az összeg mező kitöltése kötelező!")
    end
  end
  if companyTaxWindow then
    sightexports.sGui:deleteGuiElement(companyTaxWindow)
  end
  companyTaxWindow = nil
  companyTaxInput = false
end)
addEvent("companyTaxAccountTransaction", false)
addEventHandler("companyTaxAccountTransaction", getRootElement(), function(button, state, absoluteX, absoluteY, el, transType)
  if companyTaxWindow then
    sightexports.sGui:deleteGuiElement(companyTaxWindow)
  end
  companyTaxWindow = nil
  companyTaxInput = false
  if currentSingleCompany then
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local pw, ph = 300, titleBarHeight + 8 + 30 + 8 + 30 + 8
    companyTaxWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
    if transType == 1 then
      sightexports.sGui:setWindowTitle(companyTaxWindow, "16/BebasNeueRegular.otf", "Befizetés az adószámlára")
    elseif transType == 2 then
      sightexports.sGui:setWindowTitle(companyTaxWindow, "16/BebasNeueRegular.otf", "Adószámla jóváírás")
    elseif transType == 3 then
      sightexports.sGui:setWindowTitle(companyTaxWindow, "16/BebasNeueRegular.otf", "Adószámla levonás")
    end
    sightexports.sGui:setWindowCloseButton(companyTaxWindow, "closeCompanyTaxAccount")
    companyTaxInput = sightexports.sGui:createGuiElement("input", 8, titleBarHeight + 8, pw - 16, 30, companyTaxWindow)
    sightexports.sGui:setInputPlaceholder(companyTaxInput, "Összeg")
    sightexports.sGui:setInputIcon(companyTaxInput, "dollar-sign")
    sightexports.sGui:setInputMaxLength(companyTaxInput, 9)
    sightexports.sGui:setInputNumberOnly(companyTaxInput, true)
    local btn = sightexports.sGui:createGuiElement("button", 8, titleBarHeight + 8 + 30 + 8, pw - 16, 30, companyTaxWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    if transType == 1 then
      sightexports.sGui:setButtonText(btn, "Befizetés")
    elseif transType == 2 then
      sightexports.sGui:setButtonText(btn, "Jóváírás")
    elseif transType == 3 then
      sightexports.sGui:setButtonText(btn, "Levonás")
    end
    sightexports.sGui:setClickEvent(btn, "finalCompanyTaxAccountTransaction")
    sightexports.sGui:setClickArgument(btn, transType)
  end
end)
function createSingleCompanyWindow(dat, ownerName)
  deleteCompanyListWindow()
  currentSingleCompany = dat.companyId
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local fh = sightexports.sGui:getFontHeight("10/Ubuntu-B.ttf")
  local h = fh + 8
  local owner = getElementData(localPlayer, "char.ID") == dat.companyOwner
  local bh = fh + 12
  local pw, ph = 500, titleBarHeight + 4 + h * 10 + 24 + 8 + bh * 10 + 8
  if owner then
    ph = ph + 30 + 8
  end
  companyListWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowElementMaxDistance(companyListWindow, lastPanelPed, 3, "forceDeleteCompanyListWindow")
  sightexports.sGui:setWindowTitle(companyListWindow, "16/BebasNeueRegular.otf", dat.companyName)
  sightexports.sGui:setWindowCloseButton(companyListWindow, "backToCompanyList")
  if sightexports.sGroups:getPlayerPermission("editCompany") then
    local icon = sightexports.sGui:createGuiElement("image", pw - titleBarHeight * 2 + 8, 4, titleBarHeight - 8, titleBarHeight - 8, companyListWindow)
    sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("pencil", h, "solid"))
    sightexports.sGui:setGuiHoverable(icon, true)
    sightexports.sGui:guiSetTooltip(icon, "Szerkesztés")
    sightexports.sGui:setClickEvent(icon, "createNewCompanyWindow")
    sightexports.sGui:setClickArgument(icon, {
      dat.companyId,
      dat.companyName,
      dat.companyOwner,
      dat.activity,
      dat.postfix
    })
  end
  local y = titleBarHeight + 4
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(label, "Nyilvántartási szám: ")
  local x = 8 + sightexports.sGui:getLabelTextWidth(label)
  local label = sightexports.sGui:createGuiElement("label", x, y, pw - x - 8, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelClip(label, true)
  sightexports.sGui:setLabelText(label, dat.companyId)
  y = y + h
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(label, "Adószám: ")
  local x = 8 + sightexports.sGui:getLabelTextWidth(label)
  local label = sightexports.sGui:createGuiElement("label", x, y, pw - x - 8, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelClip(label, true)
  sightexports.sGui:setLabelText(label, dat.vatNumber)
  y = y + h
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(label, "Cégnév: ")
  local x = 8 + sightexports.sGui:getLabelTextWidth(label)
  local label = sightexports.sGui:createGuiElement("label", x, y, pw - x - 8, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelClip(label, true)
  sightexports.sGui:setLabelText(label, dat.companyName)
  y = y + h
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(label, "Cég NAV jelölés: ")
  local x = 8 + sightexports.sGui:getLabelTextWidth(label)
  local label = sightexports.sGui:createGuiElement("label", x, y, pw - x - 8, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelClip(label, true)
  if dat.postfix then
    sightexports.sGui:setLabelColor(label, "sightred")
    sightexports.sGui:setLabelText(label, dat.postfix)
  else
    sightexports.sGui:setLabelColor(label, "sightlightgrey")
    sightexports.sGui:setLabelText(label, "nincs")
  end
  y = y + h
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(label, "Cégtulajdonos: ")
  local x = 8 + sightexports.sGui:getLabelTextWidth(label)
  local label = sightexports.sGui:createGuiElement("label", x, y, pw - x - 8, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelClip(label, true)
  sightexports.sGui:setLabelText(label, (ownerName or "N/A") .. " (" .. dat.companyOwner .. ")")
  y = y + h
  local topLabel = sightexports.sGui:createGuiElement("label", 8, y, pw - 16, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(topLabel, "left", "center")
  sightexports.sGui:setLabelFont(topLabel, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(topLabel, "Tevékenység: ")
  sightexports.sGui:setGuiHoverable(topLabel, true)
  local activity = split(dat.activity, " ")
  local lines = {}
  local text = activity[1]
  for i = 2, #activity do
    if utf8.len(text .. " " .. activity[i]) > 64 then
      table.insert(lines, text)
      text = activity[i]
    else
      text = text .. " " .. activity[i]
    end
  end
  if 0 < utf8.len(text) then
    table.insert(lines, text)
  end
  sightexports.sGui:guiSetTooltip(topLabel, table.concat(lines, "\n"))
  local x = 8 + sightexports.sGui:getLabelTextWidth(topLabel)
  local label = sightexports.sGui:createGuiElement("label", x, y, pw - x - 8, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelClip(label, true)
  sightexports.sGui:setLabelText(label, dat.activity)
  sightexports.sGui:setGuiHoverable(label, true)
  sightexports.sGui:setGuiBoundingBox(label, topLabel)
  sightexports.sGui:guiSetTooltip(label, table.concat(lines, "\n"))
  y = y + h
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(label, "Bejegyezve: ")
  local x = 8 + sightexports.sGui:getLabelTextWidth(label)
  local label = sightexports.sGui:createGuiElement("label", x, y, pw - x - 8, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelClip(label, true)
  local time = getRealTime(dat.created)
  sightexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second) .. " (" .. dat.createdBy .. ")")
  y = y + h
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(label, "Módosítva: ")
  local x = 8 + sightexports.sGui:getLabelTextWidth(label)
  local label = sightexports.sGui:createGuiElement("label", x, y, pw - x - 8, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelClip(label, true)
  if dat.edited and dat.editedBy then
    local time = getRealTime(dat.edited)
    sightexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second) .. " (" .. dat.editedBy .. ")")
  else
    sightexports.sGui:setLabelColor(label, "sightlightgrey")
    sightexports.sGui:setLabelText(label, "nem volt")
  end
  y = y + h
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 32, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(label, "Adószámla egyenleg: ")
  local x = 8 + sightexports.sGui:getLabelTextWidth(label)
  taxAccountLabel = sightexports.sGui:createGuiElement("label", x, y, pw - x - 8, 32, companyListWindow)
  sightexports.sGui:setLabelAlignment(taxAccountLabel, "left", "center")
  sightexports.sGui:setLabelFont(taxAccountLabel, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelClip(taxAccountLabel, true)
  if owner then
    local btn = sightexports.sGui:createGuiElement("button", 0, y + 4, 24, 24, companyListWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("dollar-sign", 24))
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
    sightexports.sGui:setClickEvent(btn, "companyTaxAccountTransaction")
    sightexports.sGui:setClickArgument(btn, 1)
    sightexports.sGui:guiSetTooltip(btn, "Befizetés az adószámlára")
    table.insert(taxAccountButtons, btn)
  end
  if sightexports.sGroups:getPlayerPermission("manageCompanyTax") then
    local btn = sightexports.sGui:createGuiElement("button", 0, y + 4, 24, 24, companyListWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("plus", 24))
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
    sightexports.sGui:setClickEvent(btn, "companyTaxAccountTransaction")
    sightexports.sGui:setClickArgument(btn, 2)
    sightexports.sGui:guiSetTooltip(btn, "Adószámla jóváírás")
    table.insert(taxAccountButtons, btn)
    local btn = sightexports.sGui:createGuiElement("button", 0, y + 4, 24, 24, companyListWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("minus", 24))
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
    sightexports.sGui:setClickEvent(btn, "companyTaxAccountTransaction")
    sightexports.sGui:setClickArgument(btn, 3)
    sightexports.sGui:guiSetTooltip(btn, "Adószámla levonás")
    table.insert(taxAccountButtons, btn)
  end
  refreshTaxAccountLabel(dat.taxAccount)
  y = y + 24 + 8
  if owner then
    y = y + 4
    local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 30, companyListWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightblue",
      "sightblue-second"
    }, false, true)
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("id-card-alt", 30))
    sightexports.sGui:setButtonText(btn, " Vállalkozói igazolvány kiadása")
    sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
    sightexports.sGui:setClickEvent(btn, "requestCompanyCard")
    y = y + 30 + 4
  end
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(label, "Számlatömb prefix: ")
  local x = 8 + sightexports.sGui:getLabelTextWidth(label)
  local label = sightexports.sGui:createGuiElement("label", x, y, pw - x - 8, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelClip(label, true)
  sightexports.sGui:setLabelText(label, dat.prefix)
  y = y + h
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(label, "Számlatömbök: ")
  y = y + h
  local rect = sightexports.sGui:createGuiElement("hr", 7, y, 2, bh * 10, companyListWindow)
  local rect = sightexports.sGui:createGuiElement("hr", pw - 8 - 1, y, 2, bh * 10, companyListWindow)
  local manageBooks = sightexports.sGroups:getPlayerPermission("manageInvoiceBooks")
  for i = 1, 10 do
    local rect = sightexports.sGui:createGuiElement("hr", 8, y - 1, pw - 16, 2, companyListWindow)
    companyBookElements[i] = {}
    local label = sightexports.sGui:createGuiElement("label", 14, y, 0, bh, companyListWindow)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    companyBookElements[i][1] = label
    local label = sightexports.sGui:createGuiElement("label", 0, y, pw - 8 - 6 - (manageBooks and bh or 0), bh, companyListWindow)
    sightexports.sGui:setLabelAlignment(label, "right", "center")
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    companyBookElements[i][2] = label
    if manageBooks then
      local btn = sightexports.sGui:createGuiElement("button", pw - 8 - bh + 1, y + 1, bh - 2, bh - 2, companyListWindow)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
      sightexports.sGui:setButtonFont(btn, "10/Ubuntu-B.ttf")
      sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("trash", h))
      sightexports.sGui:setClickEvent(btn, "deleteCompanyBook")
      sightexports.sGui:guiSetTooltip(btn, "Számlatömb törlése a könyvelésből")
      companyBookElements[i][3] = btn
    end
    lastActive = y + bh
    sightexports.sGui:setGuiRenderDisabled(label, true)
    y = y + bh
  end
  if owner then
    companyBookButton = sightexports.sGui:createGuiElement("button", 9, 0, pw - 16 - 2, bh - 2, companyListWindow)
    sightexports.sGui:setGuiBackground(companyBookButton, "solid", "sightgrey2")
    sightexports.sGui:setGuiHover(companyBookButton, "gradient", {"sightgrey2", "sightgrey3"}, false, true)
    sightexports.sGui:setButtonIcon(companyBookButton, sightexports.sGui:getFaIconFilename("file-invoice-dollar", bh))
    sightexports.sGui:setButtonText(companyBookButton, " Új számlatömb igénylése")
    sightexports.sGui:setButtonFont(companyBookButton, "13/BebasNeueBold.otf")
    sightexports.sGui:setClickEvent(companyBookButton, "requestNewInvoiceBook")
    sightexports.sGui:setGuiRenderDisabled(companyBookButton, true)
  end
  refreshCompanyBooks(dat.activeBooks)
  local rect = sightexports.sGui:createGuiElement("hr", 8, y - 1, pw - 16, 2, companyListWindow)
end
addEvent("loadedSingleCompany", true)
addEventHandler("loadedSingleCompany", getRootElement(), createSingleCompanyWindow)
addEvent("openSingleComapany", false)
addEventHandler("openSingleComapany", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
  triggerServerEvent("requestSingleCompany", localPlayer, id)
  createCompanyListLoader()
end)
addEvent("backToCompanyList", false)
addEventHandler("backToCompanyList", getRootElement(), function()
  if rawCompanyList then
    createCompanyList()
  else
    triggerServerEvent("requestCompanyList", localPlayer)
    createCompanyListLoader()
  end
end)
function createCompanyList()
  deleteCompanyListWindow()
  sightlangCondHandl0(true)
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local pw, ph = 850, 500
  companyListWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  sightexports.sGui:setWindowElementMaxDistance(companyListWindow, lastPanelPed, 3, "forceDeleteCompanyListWindow")
  sightexports.sGui:setWindowTitle(companyListWindow, "16/BebasNeueRegular.otf", "Cégek")
  sightexports.sGui:setWindowCloseButton(companyListWindow, "forceDeleteCompanyListWindow")
  local y = titleBarHeight + 8
  local canCreate = sightexports.sGroups:getPlayerPermission("createCompany")
  local input = sightexports.sGui:createGuiElement("input", 8, y, pw - 16 - (canCreate and 38 or 0), 30, companyListWindow)
  sightexports.sGui:setInputPlaceholder(input, "Keresés")
  sightexports.sGui:setInputIcon(input, "search")
  sightexports.sGui:setInputMaxLength(input, 80)
  sightexports.sGui:setInputChangeEvent(input, "searchCompanyList")
  if canCreate then
    local btn = sightexports.sGui:createGuiElement("button", pw - 30 - 8, y, 30, 30, companyListWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
    sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("plus", 30))
    sightexports.sGui:guiSetTooltip(btn, "Új cég létrehozása")
    sightexports.sGui:setButtonFont(btn, "10/Ubuntu-B.ttf")
    sightexports.sGui:setClickEvent(btn, "createNewCompanyWindow")
  end
  y = y + 30 + 8
  local h = (ph - 8 - y) / 13
  local w1 = math.floor(pw * 0.125)
  local w3 = math.floor(pw * 0.2)
  local w4 = math.floor(pw * 0.175)
  local w2 = pw - 16 - h - 4 - 6 - (w1 + w3 + w4)
  local w = 8 + w1 + w2 + w3 + w4
  local rect = sightexports.sGui:createGuiElement("rectangle", 8, y, w1, h, companyListWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey4")
  sightexports.sGui:setGuiHover(rect, "solid", "sightgrey3", false, true)
  sightexports.sGui:setGuiHoverable(rect, true)
  sightexports.sGui:setClickEvent(rect, "toggleCompanyListSort")
  sightexports.sGui:setClickArgument(rect, 1)
  local rect = sightexports.sGui:createGuiElement("rectangle", 8 + w1, y, w2, h, companyListWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey4")
  sightexports.sGui:setGuiHover(rect, "solid", "sightgrey3", false, true)
  sightexports.sGui:setGuiHoverable(rect, true)
  sightexports.sGui:setClickEvent(rect, "toggleCompanyListSort")
  sightexports.sGui:setClickArgument(rect, 2)
  local rect = sightexports.sGui:createGuiElement("rectangle", 8 + w1 + w2, y, w3, h, companyListWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey4")
  sightexports.sGui:setGuiHover(rect, "solid", "sightgrey3", false, true)
  sightexports.sGui:setGuiHoverable(rect, true)
  sightexports.sGui:setClickEvent(rect, "toggleCompanyListSort")
  sightexports.sGui:setClickArgument(rect, 3)
  local rect = sightexports.sGui:createGuiElement("rectangle", 8 + w1 + w2 + w3, y, w4, h, companyListWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey4")
  sightexports.sGui:setGuiHover(rect, "solid", "sightgrey3", false, true)
  sightexports.sGui:setGuiHoverable(rect, true)
  sightexports.sGui:setClickEvent(rect, "toggleCompanyListSort")
  sightexports.sGui:setClickArgument(rect, 4)
  local rect = sightexports.sGui:createGuiElement("rectangle", w, y, pw - 16 - w, h, companyListWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey4")
  local label = sightexports.sGui:createGuiElement("label", 8, y, w1, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(label, "Ny. sz.")
  local tw = sightexports.sGui:getLabelTextWidth(label)
  local icon = sightexports.sGui:createGuiElement("image", 8 + w1 / 2 + tw / 2, y + h / 2 - 12, 24, 24, companyListWindow)
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("caret-up", 24, "solid"))
  companyListSortIcons[1] = icon
  local label = sightexports.sGui:createGuiElement("label", 8 + w1, y, w2, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(label, "Cégnév")
  local tw = sightexports.sGui:getLabelTextWidth(label)
  local icon = sightexports.sGui:createGuiElement("image", 8 + w1 + w2 / 2 + tw / 2, y + h / 2 - 12, 24, 24, companyListWindow)
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("caret-up", 24, "solid"))
  companyListSortIcons[2] = icon
  local label = sightexports.sGui:createGuiElement("label", 8 + w1 + w2, y, w3, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(label, "Adószám")
  local tw = sightexports.sGui:getLabelTextWidth(label)
  local icon = sightexports.sGui:createGuiElement("image", 8 + w1 + w2 + w3 / 2 + tw / 2, y + h / 2 - 12, 24, 24, companyListWindow)
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("caret-up", 24, "solid"))
  companyListSortIcons[3] = icon
  local label = sightexports.sGui:createGuiElement("label", 8 + w1 + w2 + w3, y, w4, h, companyListWindow)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
  sightexports.sGui:setLabelText(label, "Adószámla")
  local tw = sightexports.sGui:getLabelTextWidth(label)
  local icon = sightexports.sGui:createGuiElement("image", 8 + w1 + w2 + w3 + w4 / 2 + tw / 2, y + h / 2 - 12, 24, 24, companyListWindow)
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("caret-up", 24, "solid"))
  companyListSortIcons[4] = icon
  local border = sightexports.sGui:createGuiElement("hr", 7, y, 2, h * 13, companyListWindow)
  local border = sightexports.sGui:createGuiElement("hr", 8 + w1 - 1, y, 2, h * 13, companyListWindow)
  local border = sightexports.sGui:createGuiElement("hr", 8 + w1 + w2 - 1, y, 2, h * 13, companyListWindow)
  local border = sightexports.sGui:createGuiElement("hr", 8 + w1 + w2 + w3 - 1, y, 2, h * 13, companyListWindow)
  local border = sightexports.sGui:createGuiElement("hr", w - 1, y, 2, h * 13, companyListWindow)
  local border = sightexports.sGui:createGuiElement("hr", pw - 6 - 8 - 1, y, 2, h * 13, companyListWindow)
  local border = sightexports.sGui:createGuiElement("hr", 8, y - 1, pw - 16 - 6, 2, companyListWindow)
  local border = sightexports.sGui:createGuiElement("hr", 8, y + h - 1, pw - 16 - 6, 2, companyListWindow)
  companyListScrollH = h * 12
  local rect = sightexports.sGui:createGuiElement("rectangle", pw - 8 - 2, y + h, 2, companyListScrollH, companyListWindow)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
  companyListScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, companyListScrollH, rect)
  sightexports.sGui:setGuiBackground(companyListScrollBar, "solid", "sightmidgrey")
  for i = 1, 12 do
    y = y + h
    local border = sightexports.sGui:createGuiElement("hr", 8, y + h - 1, pw - 16 - 6, 2, companyListWindow)
    companyListElements[i] = {}
    local label = sightexports.sGui:createGuiElement("label", 8, y, w1, h, companyListWindow)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    companyListElements[i][1] = label
    local label = sightexports.sGui:createGuiElement("label", 8 + w1, y, w2, h, companyListWindow)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    companyListElements[i][2] = label
    local label = sightexports.sGui:createGuiElement("label", 8 + w1 + w2, y, w3, h, companyListWindow)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    companyListElements[i][3] = label
    local label = sightexports.sGui:createGuiElement("label", 8 + w1 + w2 + w3, y, w4, h, companyListWindow)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    companyListElements[i][4] = label
    local btn = sightexports.sGui:createGuiElement("button", w + (pw - 8 - 6 - w) / 2 - (h - 8) / 2, y + 4, h - 8, h - 8, companyListWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
    sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
    sightexports.sGui:setButtonFont(btn, "10/Ubuntu-B.ttf")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("folder-open", h))
    sightexports.sGui:setClickEvent(btn, "openSingleComapany")
    companyListElements[i][5] = btn
  end
  sortCompanyList(rawCompanyList)
  refreshCompanyList()
end
addEvent("loadedCompanies", true)
addEventHandler("loadedCompanies", getRootElement(), function(list)
  rawCompanyList = list or {}
  for i = 1, #rawCompanyList do
    if rawCompanyList[i][5] then
      rawCompanyList[i][6] = stripAccents(rawCompanyList[i][2]) .. " (" .. stripAccents(rawCompanyList[i][5]) .. ")"
    else
      rawCompanyList[i][6] = stripAccents(rawCompanyList[i][2])
    end
    rawCompanyList[i][7] = sightexports.sGui:thousandsStepper(rawCompanyList[i][4]) .. " $"
  end
  companyList = rawCompanyList
  createCompanyList()
end)
addEventHandler("onClientClick", getRootElement(), function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
  if state == "down" and officePeds[clickedElement] and not companyListWindow then
    local px, py, pz = getElementPosition(localPlayer)
    local x, y, z = getElementPosition(clickedElement)
    if getDistanceBetweenPoints3D(x, y, z, px, py, pz) <= 3 then
      lastPanelPed = clickedElement
      triggerServerEvent("requestCompanyList", localPlayer)
      createCompanyListLoader()
    end
  end
end, true, "high+999999999")
addEvent("playInvoicePaperSound", true)
addEventHandler("playInvoicePaperSound", getRootElement(), function()
  if isElement(source) and isElementStreamedIn(source) then
    local x, y, z = getElementPosition(source)
    local sound = playSound3D("files/paper.wav", x, y, z)
    setElementDimension(sound, getElementDimension(source))
    setElementInterior(sound, getElementInterior(source))
  end
end)
