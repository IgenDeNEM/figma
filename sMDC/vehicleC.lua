local seexports = {sGui = false, sVehiclenames = false}
local function sightlangProcessExports()
  for k in pairs(seexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      seexports[k] = exports[k]
    else
      seexports[k] = false
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
local vehicleScroll = 0
local vehicleScrollHeight = false
local vehicleScrollBar = false
local vehicleOwnerName = false
local vehicleElements = {}
local vehicleList = {}
local playerNameInput = false
local vehicleIDInput = false
local vehiclePlateInput = false
function mdcVehicleKey(key)
  if key == "mouse_wheel_up" then
    if 0 < vehicleScroll then
      vehicleScroll = vehicleScroll - 1
      processVehicles()
    end
  elseif key == "mouse_wheel_down" then
    local n = math.max(0, #vehicleList - #vehicleElements)
    if n > vehicleScroll then
      vehicleScroll = vehicleScroll + 1
      processVehicles()
    end
  elseif key == "enter" then
    local input = seexports.sGui:getActiveInput()
    if input == playerNameInput then
      triggerEvent("getMDCPlayerVehiclesByName", localPlayer)
    elseif input == vehicleIDInput then
      triggerEvent("getMDCVehicleById", localPlayer)
    elseif input == vehiclePlateInput then
      triggerEvent("getMDCVehicleByPlate", localPlayer)
    end
  end
end
function processVehicles()
  local n = math.max(0, #vehicleList - #vehicleElements)
  if n < vehicleScroll then
    vehicleScroll = n
  end
  local sh = vehicleScrollHeight / (n + 1)
  seexports.sGui:setGuiPosition(vehicleScrollBar, false, 2 + sh * vehicleScroll)
  seexports.sGui:setGuiSize(vehicleScrollBar, false, sh)
  for i = 1, #vehicleElements do
    if vehicleList[i + vehicleScroll] then
      local label = vehicleElements[i][1]
      seexports.sGui:setLabelText(label, (tostring(vehicleList[i + vehicleScroll].plate) or "Processing..."))
      seexports.sGui:setGuiRenderDisabled(label, false)
      local label = vehicleElements[i][2]
      seexports.sGui:setLabelText(label, vehicleList[i + vehicleScroll].vehicleId)
      seexports.sGui:setGuiRenderDisabled(label, false)
      local label = vehicleElements[i][3]
      local model = seexports.sVehiclenames:getCustomVehicleName(vehicleList[i + vehicleScroll].customModel) or seexports.sVehiclenames:getCustomVehicleName(vehicleList[i + vehicleScroll].model)
      seexports.sGui:setLabelText(label, model or "N/A")
      seexports.sGui:setGuiRenderDisabled(label, false)
      local label = vehicleElements[i][4]
      seexports.sGui:setLabelText(label, vehicleOwnerName)
      seexports.sGui:setGuiRenderDisabled(label, false)
      seexports.sGui:setGuiRenderDisabled(vehicleElements[i][5], false)
    else
      for j = 1, #vehicleElements[i] do
        seexports.sGui:setGuiRenderDisabled(vehicleElements[i][j], true)
      end
    end
  end
end
addEvent("requestVehicleMDCTrafficLicense", true)
addEventHandler("requestVehicleMDCTrafficLicense", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #vehicleElements do
    if vehicleElements[i] and vehicleElements[i][5] == el then
      if vehicleList[i + vehicleScroll] then
        createMDCInfoPrompt("Betöltés", 250, 125, "Betöltés folyamatban...", true)
        triggerLatentServerEvent("requestVehicleMDCTrafficLicense", localPlayer, vehicleList[i + vehicleScroll].vehicleId)
      end
      return
    end
  end
end)
addEvent("requestVehicleMDCWarrants", true)
addEventHandler("requestVehicleMDCWarrants", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #vehicleElements do
    if vehicleElements[i] and vehicleElements[i][6] == el then
      if vehicleList[i + vehicleScroll] then
        createMDCApp("Rendszám körözések", "vwanted")
        createMDCPlateWarrantApp()
        triggerLatentServerEvent("getWarrantsOfPlate", localPlayer, vehicleList[i + vehicleScroll].plate)
      end
      return
    end
  end
end)
addEvent("gotMDCMultipleVehicles", true)
addEventHandler("gotMDCMultipleVehicles", getRootElement(), function(ids)
  if activeMdcApp == "vehicle" then
    playerCharacterID = false
    vehicleOwnerName = false
    createMDCVehicleApp()
    createMDCErrorPrompt("Hiba", 225, 125, "Több találat: " .. table.concat(ids, ", "), true)
  end
end)
addEvent("gotMDCVehicles", true)
addEventHandler("gotMDCVehicles", getRootElement(), function(data, id, name)
  if activeMdcApp == "vehicle" then
    if data then
      playerCharacterID = id
      vehicleOwnerName = name:gsub("_", " ")
      vehicleList = data
      vehicleScroll = 0
      createMDCVehicleApp(true)
    else
      playerCharacterID = false
      vehicleOwnerName = false
      createMDCVehicleApp()
      createMDCErrorPrompt("Hiba", 225, 125, "Nincs találat!", true)
    end
  end
end)
addEvent("gotMDCTrafficLicense", true)
addEventHandler("gotMDCTrafficLicense", getRootElement(), function(id, expired, expireDate, creationDate, invalidated)
  if activeMdcApp == "vehicle" then
    if creationDate then
      local text = ""
      local time = getRealTime(creationDate)
      creationDate = string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
      local time = getRealTime(expireDate * 24 * 60 * 60)
      expireDate = string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday)
      text = text .. "Kiállítva: " .. creationDate .. "\n"
      text = text .. "Lejár: " .. expireDate .. "\n"
      text = text .. "Érvényes: " .. (expired and "nem" or "igen") .. "\n"
      text = text .. "Érvénytelenített bejegyzések: " .. invalidated .. "db"
      createMDCInfoPrompt("Forgalmi engedély - " .. id, 400, 150, text, true)
    else
      createMDCErrorPrompt("Forgalmi engedély - " .. id, 250, 125, "Nem található forgalmi engedély!", true)
    end
  end
end)
addEvent("getMDCPlayerVehiclesByName", true)
addEventHandler("getMDCPlayerVehiclesByName", getRootElement(), function()
  local value = seexports.sGui:getInputValue(playerNameInput)
  if value and utf8.len(value) > 0 then
    createMDCVehicleApp("loading")
    triggerLatentServerEvent("getMDCPlayerVehiclesByName", localPlayer, value)
  end
end)
addEvent("getMDCVehicleById", true)
addEventHandler("getMDCVehicleById", getRootElement(), function()
  local value = tonumber(seexports.sGui:getInputValue(vehicleIDInput))
  if value then
    createMDCVehicleApp("loading")
    triggerLatentServerEvent("getMDCVehicleById", localPlayer, value)
  end
end)
addEvent("getMDCVehicleByPlate", true)
addEventHandler("getMDCVehicleByPlate", getRootElement(), function()
  local value = seexports.sGui:getInputValue(vehiclePlateInput)
  if value and utf8.len(value) > 0 then
    createMDCVehicleApp("loading")
    triggerLatentServerEvent("getMDCVehicleByPlate", localPlayer, value)
  end
end)
addEvent("mdcVehiclesNewQuery", true)
addEventHandler("mdcVehiclesNewQuery", getRootElement(), function()
  playerCharacterID = false
  vehicleOwnerName = false
  vehicleList = {}
  createMDCVehicleApp()
end)
function createMDCVehicleApp(data)
  seexports.sGui:deleteAllChildren(mdcAppInside)
  activeMdcApp = "vehicle"
  loader = false
  local y = pad
  vehicleIDInput = false
  playerNameInput = false
  if not data then
    local label = seexports.sGui:createGuiElement("label", pad, y, 0, 30, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    seexports.sGui:setLabelText(label, "Lekérdezés tulajdonos alapján:")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "center")
    local label = seexports.sGui:createGuiElement("label", pad + 275 + pad + 30 + pad * 2, y, 0, 30, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    seexports.sGui:setLabelText(label, "Lekérdezés alvázszám (ID) alapján:")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "center")
    local label = seexports.sGui:createGuiElement("label", pad + (275 + pad + 30 + pad * 2) * 2, y, 0, 30, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    seexports.sGui:setLabelText(label, "Lekérdezés rendszám alapján:")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "center")
    y = y + 30
    playerNameInput = seexports.sGui:createGuiElement("input", pad, y, 275, 30, mdcAppInside)
    seexports.sGui:setInputPlaceholder(playerNameInput, "Név")
    seexports.sGui:setInputMaxLength(playerNameInput, 32)
    setInputScheme(playerNameInput)
    local btn = seexports.sGui:createGuiElement("button", pad + 275 + pad, y, 30, 30, mdcAppInside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("search", 30))
    seexports.sGui:setClickEvent(btn, "getMDCPlayerVehiclesByName")
    setButtonScheme(btn)
    vehicleIDInput = seexports.sGui:createGuiElement("input", pad + 275 + pad + 30 + pad * 2, y, 275, 30, mdcAppInside)
    seexports.sGui:setInputPlaceholder(vehicleIDInput, "Azonosító")
    seexports.sGui:setInputMaxLength(vehicleIDInput, 9)
    seexports.sGui:setInputNumberOnly(vehicleIDInput, true)
    setInputScheme(vehicleIDInput)
    local btn = seexports.sGui:createGuiElement("button", pad + 275 + pad + 30 + pad * 2 + 275 + pad, y, 30, 30, mdcAppInside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("search", 30))
    seexports.sGui:setClickEvent(btn, "getMDCVehicleById")
    setButtonScheme(btn)
    vehiclePlateInput = seexports.sGui:createGuiElement("input", pad + (275 + pad + 30 + pad * 2) * 2, y, 275, 30, mdcAppInside)
    seexports.sGui:setInputPlaceholder(vehiclePlateInput, "Rendszám")
    seexports.sGui:setInputMaxLength(vehiclePlateInput, 8)
    setInputScheme(vehiclePlateInput)
    local btn = seexports.sGui:createGuiElement("button", pad + (275 + pad + 30 + pad * 2) * 2 + 275 + pad, y, 30, 30, mdcAppInside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("search", 30))
    seexports.sGui:setClickEvent(btn, "getMDCVehicleByPlate")
    setButtonScheme(btn)
    y = y + 30 + pad + pad + pad
    local border = seexports.sGui:createGuiElement("hr", pad, pad + 30 + 30 + pad + pad - 1, insideX - pad * 2, 2, mdcAppInside)
    seexports.sGui:setGuiHrColor(border, colorScheme.window2, colorScheme.window3)
  end
  if data == "loading" then
    createLoader(pad, insideY / 2 - 12, insideX - pad * 2, 24)
  elseif data then
    if playerCharacterID then
      local btn = seexports.sGui:createGuiElement("button", pad, pad, 225, 30, mdcAppInside)
      seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("search", 30))
      seexports.sGui:setButtonText(btn, " Tulajdonos lekérdezése")
      seexports.sGui:setClickEvent(btn, "queryMdcPlayerFromRecord")
      setButtonScheme(btn)
      local btn = seexports.sGui:createGuiElement("button", pad + 225 + pad, pad, 150, 30, mdcAppInside)
      seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      seexports.sGui:setButtonText(btn, "Új lekérdezés")
      seexports.sGui:setClickEvent(btn, "mdcVehiclesNewQuery")
      setButtonScheme(btn)
      y = y + 30 + pad + pad
      local border = seexports.sGui:createGuiElement("hr", pad, pad + 30 + pad - 1, insideX - pad * 2, 2, mdcAppInside)
      seexports.sGui:setGuiHrColor(border, colorScheme.window2, colorScheme.window3)
    else
      local btn = seexports.sGui:createGuiElement("button", pad, pad, 150, 30, mdcAppInside)
      seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      seexports.sGui:setButtonText(btn, "Új lekérdezés")
      seexports.sGui:setClickEvent(btn, "mdcVehiclesNewQuery")
      setButtonScheme(btn)
      y = y + 30 + pad + pad
      local border = seexports.sGui:createGuiElement("hr", pad, pad + 30 + pad - 1, insideX - pad * 2, 2, mdcAppInside)
      seexports.sGui:setGuiHrColor(border, colorScheme.window2, colorScheme.window3)
    end
    local h = insideY - y - pad
    local w = insideX - pad * 2
    local n = 18
    local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w, h, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", "#ffffff")
    seexports.sGui:setGuiBackgroundBorder(rect, 2, colorScheme.window2)
    h = h / (n + 1)
    w = w - 18
    w = w / 3.6
    local rect = seexports.sGui:createGuiElement("rectangle", pad + w / 2, y, 1, h, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
    for i = 1, 3 do
      local rect = seexports.sGui:createGuiElement("rectangle", pad + w * i, y, 1, h, mdcAppInside)
      seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
    end
    local label = seexports.sGui:createGuiElement("label", pad, y, w / 2, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Rendszám")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w / 2, y, w / 2, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Alvázszám")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w * 1, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Típus")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w * 2, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Tulajdonos")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w * 3, y, w * 0.6, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Lekérdezés")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    y = y + h
    vehicleScrollHeight = h * n - 4
    local rect = seexports.sGui:createGuiElement("rectangle", pad + w * 3.6, y, 18, vehicleScrollHeight + 4, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", colorScheme.btn1)
    seexports.sGui:setGuiBackgroundBorder(rect, 2, colorScheme.window2)
    vehicleScrollBar = seexports.sGui:createGuiElement("rectangle", 2, 2, 14, vehicleScrollHeight, rect)
    seexports.sGui:setGuiBackground(vehicleScrollBar, "solid", colorScheme.btn2)
    vehicleElements = {}
    for i = 1, n do
      vehicleElements[i] = {}
      local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w * 3.6, 1, mdcAppInside)
      seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
      local rect = seexports.sGui:createGuiElement("rectangle", pad + w / 2, y, 1, h, mdcAppInside)
      seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
      for i = 1, 3 do
        local rect = seexports.sGui:createGuiElement("rectangle", pad + w * i, y, 1, h, mdcAppInside)
        seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
      end
      local label = seexports.sGui:createGuiElement("label", pad, y, w / 2, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      vehicleElements[i][1] = label
      local label = seexports.sGui:createGuiElement("label", pad + w / 2, y, w / 2, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      vehicleElements[i][2] = label
      local label = seexports.sGui:createGuiElement("label", pad + w, y, w, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      vehicleElements[i][3] = label
      local label = seexports.sGui:createGuiElement("label", pad + w * 2, y, w, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      vehicleElements[i][4] = label
      local bw = (w * 0.6 - 2) / 2
      local btn = seexports.sGui:createGuiElement("button", pad + w * 3 + 1, y + 1, bw, h - 2, mdcAppInside)
      seexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
      seexports.sGui:setButtonText(btn, "Forgalmi")
      seexports.sGui:setClickEvent(btn, "requestVehicleMDCTrafficLicense")
      setButtonScheme(btn)
      vehicleElements[i][5] = btn
      local btn = seexports.sGui:createGuiElement("button", pad + w * 3 + 1 + bw, y + 1, bw, h - 2, mdcAppInside)
      seexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
      seexports.sGui:setButtonText(btn, "Körözés")
      seexports.sGui:setClickEvent(btn, "requestVehicleMDCWarrants")
      setButtonScheme(btn)
      vehicleElements[i][6] = btn
      y = y + h
    end
    processVehicles()
  end
  orderMDCGui()
end
local deletingWarrant = false
local warrantList = {}
local warrantScroll = 0
local warrantElements = {}
local warrantScrollBar = false
local warrantScrollHeight = 0
function processPlateWarrants()
  local n = math.max(0, #warrantList - #warrantElements)
  if n < warrantScroll then
    warrantScroll = n
  end
  local sh = warrantScrollHeight / (n + 1)
  seexports.sGui:setGuiPosition(warrantScrollBar, false, 2 + sh * warrantScroll)
  seexports.sGui:setGuiSize(warrantScrollBar, false, sh)
  for i = 1, #warrantElements do
    if warrantList[i + warrantScroll] then
      local label = warrantElements[i][1]
      seexports.sGui:setLabelText(label, warrantList[i + warrantScroll][2])
      seexports.sGui:setGuiRenderDisabled(label, false)
      local label = warrantElements[i][2]
      local time = getRealTime(warrantList[i + warrantScroll][3])
      seexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute))
      seexports.sGui:setGuiRenderDisabled(label, false)
      local label = warrantElements[i][3]
      seexports.sGui:setLabelText(label, warrantList[i + warrantScroll][4])
      seexports.sGui:setGuiRenderDisabled(label, false)
      seexports.sGui:setGuiRenderDisabled(warrantElements[i][4], false)
      local label = warrantElements[i][5]
      seexports.sGui:setLabelText(label, warrantList[i + warrantScroll][5])
      seexports.sGui:setGuiRenderDisabled(label, false)
    else
      for j = 1, #warrantElements[i] do
        seexports.sGui:setGuiRenderDisabled(warrantElements[i][j], true)
      end
    end
  end
end
function mdcPlateWarrantKey(key)
  if key == "mouse_wheel_up" then
    if 0 < warrantScroll then
      warrantScroll = warrantScroll - 1
      processPlateWarrants()
    end
  elseif key == "mouse_wheel_down" then
    local n = math.max(0, #warrantList - #warrantElements)
    if n > warrantScroll then
      warrantScroll = warrantScroll + 1
      processPlateWarrants()
    end
  end
end
local selectedWarrantVehicleId = false
addEvent("gotMDCPlateWarrantQuery", true)
addEventHandler("gotMDCPlateWarrantQuery", getRootElement(), function(id, data)
  if activeMdcApp == "platewarrant" then
    table.sort(data, warrantSort)
    selectedWarrantVehicleId = id
    warrantList = data
    warrantScroll = 0
    createMDCPlateWarrantApp(true)
    if #data < 1 then
      createMDCInfoPrompt("Információ", 225, 125, "Nincs találat!", true)
    end
  end
end)
addEvent("openWarrantVehicle", false)
addEventHandler("openWarrantVehicle", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  deletingWarrant = false
  for i = 1, #warrantElements do
    if warrantList[i + warrantScroll] and warrantElements[i][4] == el then
      triggerLatentServerEvent("getMDCVehicleByPlate", localPlayer, warrantList[i + warrantScroll][2])
      createMDCApp("Jármű lekérdezés", "vehicle")
      createMDCVehicleApp("loading")
      return
    end
  end
end)
addEvent("queryMdcVehicleFromRecord", false)
addEventHandler("queryMdcVehicleFromRecord", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if selectedWarrantVehicleId then
    createMDCVehicleApp("loading")
    triggerLatentServerEvent("getMDCVehicleByPlate", localPlayer, selectedWarrantVehicleId)
  end
end)
addEvent("finalAddMDCPlateWarrant", false)
addEventHandler("finalAddMDCPlateWarrant", getRootElement(), function()
  local val = seexports.sGui:getInputValue(mdcPromptInput)
  if val and utf8.len(val) > 0 then
    if mdcPrompt then
      seexports.sGui:deleteGuiElement(mdcPrompt)
    end
    mdcPrompt = false
    mdcPromptInput = false
    if selectedWarrantVehicleId then
      triggerLatentServerEvent("addMDCPlateWarrant", localPlayer, selectedWarrantVehicleId, val)
      createMDCPlateWarrantApp()
    end
  end
end)
addEvent("addMDCPlateWarrant", false)
addEventHandler("addMDCPlateWarrant", getRootElement(), function()
  createMDCInputPrompt("Körözés kiadása", 400, 125, "Indok", "finalAddMDCPlateWarrant")
end)
addEvent("finalDeletePlateWarrant", false)
addEventHandler("finalDeletePlateWarrant", getRootElement(), function()
  if mdcPrompt then
    seexports.sGui:deleteGuiElement(mdcPrompt)
  end
  mdcPrompt = false
  mdcPromptInput = false
  if selectedWarrantVehicleId then
    triggerLatentServerEvent("deleteMDCPlateWarrant", localPlayer, selectedWarrantVehicleId, deletingWarrant)
    createMDCPlateWarrantApp()
  end
end)
addEvent("deletePlateWarrant", false)
addEventHandler("deletePlateWarrant", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  deletingWarrant = false
  for i = 1, #warrantElements do
    if warrantList[i + warrantScroll] and warrantElements[i][4] == el then
      deletingWarrant = warrantList[i + warrantScroll][1]
      createMDCYesNoPrompt("Körözés törlése", 400, 125, "Biztosan szeretnéd törölni a körözést?", "finalDeletePlateWarrant")
      return
    end
  end
end)
function createMDCPlateWarrantApp(data)
  seexports.sGui:deleteAllChildren(mdcAppInside)
  activeMdcApp = "platewarrant"
  loader = false
  if data then
    local y = pad
    if selectedWarrantVehicleId then
      local btn = seexports.sGui:createGuiElement("button", pad, pad, 200, 30, mdcAppInside)
      seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("car", 30))
      seexports.sGui:setButtonText(btn, " Jármű lekérdezése")
      seexports.sGui:setClickEvent(btn, "queryMdcVehicleFromRecord")
      setButtonScheme(btn)
      local btn = seexports.sGui:createGuiElement("button", pad + 200 + pad, pad, 225, 30, mdcAppInside)
      seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("exclamation-triangle", 30))
      seexports.sGui:setButtonText(btn, " Körözés kiadása")
      seexports.sGui:setClickEvent(btn, "addMDCPlateWarrant")
      setButtonScheme(btn)
      y = y + 30 + pad + pad
      local border = seexports.sGui:createGuiElement("hr", pad, pad + 30 + pad - 1, insideX - pad * 2, 2, mdcAppInside)
      seexports.sGui:setGuiHrColor(border, colorScheme.window2, colorScheme.window3)
    end
    local h = insideY - y - pad
    local w = insideX - pad * 2
    local n = 18
    local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w, h, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", "#ffffff")
    seexports.sGui:setGuiBackgroundBorder(rect, 2, colorScheme.window2)
    h = h / (n + 2)
    w = w - 18
    w = w / 3.5
    for i = 1, 3 do
      local rect = seexports.sGui:createGuiElement("rectangle", pad + w * i, y, 2, h, mdcAppInside)
      seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
    end
    local label = seexports.sGui:createGuiElement("label", pad, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Rendszám")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w * 1, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Időpont")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w * 2, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Intézkedő")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w * 3, y, w * 0.5, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, selectedWarrantVehicleId and "Törlés" or "Lekérdezés")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    y = y + h
    local label = seexports.sGui:createGuiElement("label", pad, y, w * 3.5, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Indok")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w * 3.5 + 18, 2, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
    y = y + h
    warrantScrollHeight = h * n - 4
    local rect = seexports.sGui:createGuiElement("rectangle", pad + w * 3.5, y, 18, warrantScrollHeight + 4, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", colorScheme.btn1)
    seexports.sGui:setGuiBackgroundBorder(rect, 2, colorScheme.window2)
    warrantScrollBar = seexports.sGui:createGuiElement("rectangle", 2, 2, 14, warrantScrollHeight, rect)
    seexports.sGui:setGuiBackground(warrantScrollBar, "solid", colorScheme.btn2)
    warrantElements = {}
    for i = 1, n / 2 do
      warrantElements[i] = {}
      local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w * 3.5, 2, mdcAppInside)
      seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
      for i = 1, 2 do
        local rect = seexports.sGui:createGuiElement("rectangle", pad + w * i, y, 1, h, mdcAppInside)
        seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
      end
      local label = seexports.sGui:createGuiElement("label", pad, y, w, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      warrantElements[i][1] = label
      local label = seexports.sGui:createGuiElement("label", pad + w, y, w, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      warrantElements[i][2] = label
      local label = seexports.sGui:createGuiElement("label", pad + w * 2, y, w, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      warrantElements[i][3] = label
      local btn = seexports.sGui:createGuiElement("button", pad + w * 3, y, w * 0.5, h, mdcAppInside)
      seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      seexports.sGui:setButtonText(btn, selectedWarrantVehicleId and "Törlés" or " Jármű")
      if not selectedWarrantVehicleId then
        seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("car", 30))
      end
      seexports.sGui:setClickEvent(btn, selectedWarrantVehicleId and "deletePlateWarrant" or "openWarrantVehicle")
      setButtonScheme(btn)
      warrantElements[i][4] = btn
      y = y + h
      local label = seexports.sGui:createGuiElement("label", pad, y, w * 3.5, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      warrantElements[i][5] = label
      local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w * 3.5, 1, mdcAppInside)
      seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
      y = y + h
    end
    processPlateWarrants()
  else
    createLoader(pad, insideY / 2 - 12, insideX - pad * 2, 24)
  end
  orderMDCGui()
end
