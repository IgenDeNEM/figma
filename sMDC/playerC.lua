local seexports = {sGui = false}
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
function warrantSort(a, b)
  return tonumber(a[3]) > tonumber(b[3])
end
local playerNameInput, licenseIdInput
playerCharacterID = false
local playerRecords = 0
function mdcPlayerKey(key)
  if key == "enter" then
    local input = seexports.sGui:getActiveInput()
    if input == playerNameInput then
      triggerEvent("queryMdcPlayerByName", localPlayer)
    elseif input == licenseIdInput then
      triggerEvent("queryMdcPlayerByLicense", localPlayer)
    end
  end
end
addEvent("queryMdcPlayerByLicense", false)
addEventHandler("queryMdcPlayerByLicense", getRootElement(), function()
  local value = seexports.sGui:getInputValue(licenseIdInput)
  if value and utf8.len(value) > 0 then
    if utf8.len(value) == 8 then
      createMDCPlayerApp("loading")
      if mdcPrompt then
        seexports.sGui:deleteGuiElement(mdcPrompt)
      end
      mdcPrompt = false
      mdcPromptInput = false
      triggerLatentServerEvent("queryMdcPlayerByLicense", localPlayer, value)
    else
      createMDCPlayerApp()
      playSound("files/error.mp3")
      createMDCErrorPrompt("Hiba", 225, 125, "Hibás okmányazonosító!", true)
    end
  end
end)
addEvent("queryMdcPlayerByName", false)
addEventHandler("queryMdcPlayerByName", getRootElement(), function()
  local value = seexports.sGui:getInputValue(playerNameInput)
  if value and utf8.len(value) > 0 then
    createMDCPlayerApp("loading")
    if mdcPrompt then
      seexports.sGui:deleteGuiElement(mdcPrompt)
    end
    mdcPrompt = false
    mdcPromptInput = false
    triggerLatentServerEvent("queryMdcPlayerByName", localPlayer, value)
  end
end)
addEvent("queryMdcPlayerFromRecord", false)
addEventHandler("queryMdcPlayerFromRecord", getRootElement(), function()
  if playerCharacterID then
    createMDCApp("Személy lekérdezés", "player")
    triggerLatentServerEvent("queryMdcPlayerByCharacterID", localPlayer, playerCharacterID)
    createMDCPlayerApp("loading")
    if mdcPrompt then
      seexports.sGui:deleteGuiElement(mdcPrompt)
    end
    mdcPrompt = false
    mdcPromptInput = false
  end
end)
addEvent("getWarrantsOfPlayer", false)
addEventHandler("getWarrantsOfPlayer", getRootElement(), function()
  if playerCharacterID then
    createMDCApp("Körözések", "wanted")
    createMDCWarrantApp()
    triggerLatentServerEvent("getWarrantsOfPlayer", localPlayer, playerCharacterID)
  end
end)
addEvent("getRecordsOfPlayer", false)
addEventHandler("getRecordsOfPlayer", getRootElement(), function()
  if playerCharacterID then
    createMDCApp("Priusz", "records")
    createMDCRecordApp()
    triggerLatentServerEvent("getRecordsOfPlayer", localPlayer, playerCharacterID)
  end
end)
addEvent("requestVehiclesOfPlayers", false)
addEventHandler("requestVehiclesOfPlayers", getRootElement(), function()
  if playerCharacterID then
    createMDCApp("Jármű lekérdezés", "vehicle")
    createMDCVehicleApp("loading")
    triggerLatentServerEvent("getMDCPlayerVehicles", localPlayer, playerCharacterID)
  end
end)
addEvent("requestInteriorsOfPlayers", false)
addEventHandler("requestInteriorsOfPlayers", getRootElement(), function()
  if playerCharacterID then
    createMDCApp("Ingatlan lekérdezés", "inti")
    createMDCInteriorApp("loading")
    triggerLatentServerEvent("getMDCPlayerInteriors", localPlayer, playerCharacterID)
  end
end)
addEvent("gotMDCPlayerQuery", true)
addEventHandler("gotMDCPlayerQuery", getRootElement(), function(data, image1, image2, image3)
  if activeMdcApp == "player" then
    if data then
      for i = 1, #mdcImages do
        if isElement(mdcImages[i]) then
          destroyElement(mdcImages[i])
        end
      end
      mdcImages = {}
      if image1 then
        mdcImages[1] = dxCreateTexture(image1)
      end
      if image2 then
        mdcImages[2] = dxCreateTexture(image2)
      end
      if image3 then
        mdcImages[3] = dxCreateTexture(image3)
      end
      createMDCPlayerApp(data)
    else
      createMDCPlayerApp()
      createMDCErrorPrompt("Hiba", 225, 125, "Nincs találat!", true)
    end
  end
  image1 = nil
  image2 = nil
  image3 = nil
  collectgarbage("collect")
end)
local recordTypes = {
  jail = "Börtön", --MISSING
  ticket = "Pénzbírság",
  licenseRevoke = "Bevont okmány",
  warrant = "Körözés",
  comment = "Megjegyzés"
}
local recordList = {}
local recordScroll = 0
local recordElements = {}
local recordScrollBar = false
local recordScrollHeight = 0
function mdcRecordKey(key)
  if key == "mouse_wheel_up" then
    if 0 < recordScroll then
      recordScroll = recordScroll - 1
      processRecords()
    end
  elseif key == "mouse_wheel_down" then
    local n = math.max(0, #recordList - #recordElements)
    if n > recordScroll then
      recordScroll = recordScroll + 1
      processRecords()
    end
  end
end
addEvent("gotMDCRecordQuery", true)
addEventHandler("gotMDCRecordQuery", getRootElement(), function(id, data)
  if activeMdcApp == "record" then
    playerCharacterID = id
    recordList = data
    recordScroll = 0
    createMDCRecordApp(true)
    if #data < 1 then
      createMDCInfoPrompt("Információ", 225, 125, "Nincs találat!", true)
    end
  end
end)
function processRecords()
  local n = math.max(0, #recordList - #recordElements)
  if n < recordScroll then
    recordScroll = n
  end
  local sh = recordScrollHeight / (n + 1)
  seexports.sGui:setGuiPosition(recordScrollBar, false, 2 + sh * recordScroll)
  seexports.sGui:setGuiSize(recordScrollBar, false, sh)
  for i = 1, #recordElements do
    if recordList[i + recordScroll] then
      local label = recordElements[i][1]
      seexports.sGui:setLabelText(label, recordList[i + recordScroll].name)
      seexports.sGui:setGuiRenderDisabled(label, false)
      local label = recordElements[i][2]
      if 0 < utf8.len(recordList[i + recordScroll].recordPunishment) then
        seexports.sGui:setLabelText(label, recordTypes[recordList[i + recordScroll].recordType] .. " - " .. recordList[i + recordScroll].recordPunishment)
      else
        seexports.sGui:setLabelText(label, recordTypes[recordList[i + recordScroll].recordType])
      end
      seexports.sGui:setGuiRenderDisabled(label, false)
      local label = recordElements[i][3]
      local time = getRealTime(recordList[i + recordScroll].recordTime)
      seexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute))
      seexports.sGui:setGuiRenderDisabled(label, false)
      local label = recordElements[i][4]
      seexports.sGui:setLabelText(label, recordList[i + recordScroll].recordBy)
      seexports.sGui:setGuiRenderDisabled(label, false)
      local label = recordElements[i][5]
      seexports.sGui:setLabelText(label, recordList[i + recordScroll].description)
      seexports.sGui:setGuiRenderDisabled(label, false)
    else
      for j = 1, #recordElements[i] do
        seexports.sGui:setGuiRenderDisabled(recordElements[i][j], true)
      end
    end
  end
end
addEvent("finalAddMdcRecordComment", false)
addEventHandler("finalAddMdcRecordComment", getRootElement(), function()
  local val = seexports.sGui:getInputValue(mdcPromptInput)
  if val and utf8.len(val) > 0 then
    if mdcPrompt then
      seexports.sGui:deleteGuiElement(mdcPrompt)
    end
    mdcPrompt = false
    mdcPromptInput = false
    if playerCharacterID then
      triggerLatentServerEvent("addMDCRecordComment", localPlayer, playerCharacterID, val)
      createMDCRecordApp()
    end
  end
end)
addEvent("addMdcRecordComment", false)
addEventHandler("addMdcRecordComment", getRootElement(), function()
  createMDCInputPrompt("Megjegyzés hozzáadása", 400, 125, "Megjegyzés", "finalAddMdcRecordComment")
end)
function createMDCRecordApp(data)
  seexports.sGui:deleteAllChildren(mdcAppInside)
  activeMdcApp = "record"
  loader = false
  if data then
    local btn = seexports.sGui:createGuiElement("button", pad, pad, 200, 30, mdcAppInside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("search", 30))
    seexports.sGui:setButtonText(btn, " Személy lekérdezése")
    seexports.sGui:setClickEvent(btn, "queryMdcPlayerFromRecord")
    setButtonScheme(btn)
    local btn = seexports.sGui:createGuiElement("button", pad + 200 + pad, pad, 225, 30, mdcAppInside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("comment", 30))
    seexports.sGui:setButtonText(btn, " Megjegyzés létrehozása")
    seexports.sGui:setClickEvent(btn, "addMdcRecordComment")
    setButtonScheme(btn)
    local border = seexports.sGui:createGuiElement("hr", pad, pad + 30 + pad - 1, insideX - pad * 2, 2, mdcAppInside)
    seexports.sGui:setGuiHrColor(border, colorScheme.window2, colorScheme.window3)
    local y = pad + 30 + pad + pad
    local h = insideY - y - pad
    local w = insideX - pad * 2
    local n = 18
    local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w, h, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", "#ffffff")
    seexports.sGui:setGuiBackgroundBorder(rect, 2, colorScheme.window2)
    h = h / (n + 2)
    w = w - 18
    w = w / 4
    for i = 1, 3 do
      local rect = seexports.sGui:createGuiElement("rectangle", pad + w * i, y, 2, h, mdcAppInside)
      seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
    end
    local label = seexports.sGui:createGuiElement("label", pad, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Név")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w * 1, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Büntetés")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w * 2, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Időpont")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w * 3, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Intézkedő")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    y = y + h
    local label = seexports.sGui:createGuiElement("label", pad, y, w * 4, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Leírás")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w * 4 + 18, 2, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
    y = y + h
    recordScrollHeight = h * n - 4
    local rect = seexports.sGui:createGuiElement("rectangle", pad + w * 4, y, 18, recordScrollHeight + 4, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", colorScheme.btn1)
    seexports.sGui:setGuiBackgroundBorder(rect, 2, colorScheme.window2)
    recordScrollBar = seexports.sGui:createGuiElement("rectangle", 2, 2, 14, recordScrollHeight, rect)
    seexports.sGui:setGuiBackground(recordScrollBar, "solid", colorScheme.btn2)
    recordElements = {}
    for i = 1, n / 2 do
      recordElements[i] = {}
      local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w * 4, 2, mdcAppInside)
      seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
      for i = 1, 3 do
        local rect = seexports.sGui:createGuiElement("rectangle", pad + w * i, y, 1, h, mdcAppInside)
        seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
      end
      local label = seexports.sGui:createGuiElement("label", pad, y, w, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      recordElements[i][1] = label
      local label = seexports.sGui:createGuiElement("label", pad + w, y, w, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      recordElements[i][2] = label
      local label = seexports.sGui:createGuiElement("label", pad + w * 2, y, w, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      recordElements[i][3] = label
      local label = seexports.sGui:createGuiElement("label", pad + w * 3, y, w, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      recordElements[i][4] = label
      y = y + h
      local label = seexports.sGui:createGuiElement("label", pad, y, w * 4, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      recordElements[i][5] = label
      local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w * 4, 1, mdcAppInside)
      seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
      y = y + h
    end
    processRecords()
  else
    createLoader(pad, insideY / 2 - 12, insideX - pad * 2, 24)
  end
  orderMDCGui()
end
local warrantList = {}
local warrantScroll = 0
local warrantElements = {}
local warrantScrollBar = false
local warrantScrollHeight = 0
function mdcWarrantKey(key)
  if key == "mouse_wheel_up" then
    if 0 < warrantScroll then
      warrantScroll = warrantScroll - 1
      processWarrants()
    end
  elseif key == "mouse_wheel_down" then
    local n = math.max(0, #warrantList - #warrantElements)
    if n > warrantScroll then
      warrantScroll = warrantScroll + 1
      processWarrants()
    end
  end
end
addEvent("gotMDCWarrantQuery", true)
addEventHandler("gotMDCWarrantQuery", getRootElement(), function(id, data)
  if activeMdcApp == "warrant" then
    table.sort(data, warrantSort)
    playerCharacterID = id
    warrantList = data
    warrantScroll = 0
    createMDCWarrantApp(true)
    if #data < 1 then
      createMDCInfoPrompt("Információ", 225, 125, "Nincs találat!", true)
    end
  end
end)
local deletingWarrant = false
addEvent("finalDeleteWarrant", false)
addEventHandler("finalDeleteWarrant", getRootElement(), function()
  if mdcPrompt then
    seexports.sGui:deleteGuiElement(mdcPrompt)
  end
  mdcPrompt = false
  mdcPromptInput = false
  if playerCharacterID then
    triggerLatentServerEvent("deleteMDCWarrant", localPlayer, playerCharacterID, deletingWarrant)
    createMDCWarrantApp()
  end
end)
addEvent("deleteWarrant", false)
addEventHandler("deleteWarrant", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  deletingWarrant = false
  for i = 1, #warrantElements do
    if warrantList[i + warrantScroll] and warrantElements[i][4] == el then
      deletingWarrant = warrantList[i + warrantScroll][1]
      createMDCYesNoPrompt("Körözés törlése", 400, 125, "Biztosan szeretnéd törölni a körözést?", "finalDeleteWarrant")
      return
    end
  end
end)
addEvent("openWarrantPlayer", false)
addEventHandler("openWarrantPlayer", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  deletingWarrant = false
  for i = 1, #warrantElements do
    if warrantList[i + warrantScroll] and warrantElements[i][4] == el then
      createMDCApp("Személy lekérdezés", "player")
      triggerLatentServerEvent("queryMdcPlayerByCharacterID", localPlayer, warrantList[i + warrantScroll][6])
      createMDCPlayerApp("loading")
      return
    end
  end
end)
addEvent("finalAddMDCWarrant", false)
addEventHandler("finalAddMDCWarrant", getRootElement(), function()
  local val = seexports.sGui:getInputValue(mdcPromptInput)
  if val and utf8.len(val) > 0 then
    if mdcPrompt then
      seexports.sGui:deleteGuiElement(mdcPrompt)
    end
    mdcPrompt = false
    mdcPromptInput = false
    if playerCharacterID then
      triggerLatentServerEvent("addMDCWarrant", localPlayer, playerCharacterID, val)
      createMDCWarrantApp()
    end
  end
end)
addEvent("addMDCWarrant", false)
addEventHandler("addMDCWarrant", getRootElement(), function()
  createMDCInputPrompt("Körözés kiadása", 400, 125, "Indok", "finalAddMDCWarrant")
end)
function processWarrants()
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
function createMDCWarrantApp(data)
  seexports.sGui:deleteAllChildren(mdcAppInside)
  activeMdcApp = "warrant"
  loader = false
  if data then
    local y = pad
    if playerCharacterID then
      local btn = seexports.sGui:createGuiElement("button", pad, pad, 200, 30, mdcAppInside)
      seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("search", 30))
      seexports.sGui:setButtonText(btn, " Személy lekérdezése")
      seexports.sGui:setClickEvent(btn, "queryMdcPlayerFromRecord")
      setButtonScheme(btn)
      local btn = seexports.sGui:createGuiElement("button", pad + 200 + pad, pad, 225, 30, mdcAppInside)
      seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("exclamation-triangle", 30))
      seexports.sGui:setButtonText(btn, " Körözés kiadása")
      seexports.sGui:setClickEvent(btn, "addMDCWarrant")
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
    seexports.sGui:setLabelText(label, "Név")
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
    seexports.sGui:setLabelText(label, playerCharacterID and "Törlés" or "Lekérdezés")
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
      seexports.sGui:setButtonText(btn, playerCharacterID and "Törlés" or " Körözött")
      if not playerCharacterID then
        seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("user", 30))
      end
      seexports.sGui:setClickEvent(btn, playerCharacterID and "deleteWarrant" or "openWarrantPlayer")
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
    processWarrants()
  else
    createLoader(pad, insideY / 2 - 12, insideX - pad * 2, 24)
  end
  orderMDCGui()
end
local revokingLicense = false
addEvent("finalRevokeLicense", false)
addEventHandler("finalRevokeLicense", getRootElement(), function()
  local val = seexports.sGui:getInputValue(mdcPromptInput)
  if val and utf8.len(val) > 0 then
    if mdcPrompt then
      seexports.sGui:deleteGuiElement(mdcPrompt)
    end
    mdcPrompt = false
    mdcPromptInput = false
    if playerCharacterID then
      triggerLatentServerEvent("revokeLicenseOfPlayer", localPlayer, playerCharacterID, revokingLicense, val)
      createMDCPlayerApp("loading")
    end
  end
end)
addEvent("mdcRevokeDriversLicense", false)
addEventHandler("mdcRevokeDriversLicense", getRootElement(), function()
  revokingLicense = "dl"
  createMDCInputPrompt("Vezetői engedély bevonása", 400, 125, "Indok", "finalRevokeLicense")
end)
addEvent("mdcRevokeWeaponLicense", false)
addEventHandler("mdcRevokeWeaponLicense", getRootElement(), function()
  revokingLicense = "wp"
  createMDCInputPrompt("Fegyverviselési engedély bevonása", 400, 125, "Indok", "finalRevokeLicense")
end)
function createMDCPlayerApp(data)
  playerCharacterID = false
  seexports.sGui:deleteAllChildren(mdcAppInside)
  activeMdcApp = "player"
  local y = pad
  local label = seexports.sGui:createGuiElement("label", pad, y, 0, 30, mdcAppInside)
  seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, "Lekérdezés név alapján:")
  seexports.sGui:setLabelColor(label, "#000000")
  seexports.sGui:setLabelAlignment(label, "left", "center")
  local label = seexports.sGui:createGuiElement("label", pad + 250 + pad * 2, y, 0, 30, mdcAppInside)
  seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, "Lekérdezés okmányazonosító alapján:")
  seexports.sGui:setLabelColor(label, "#000000")
  seexports.sGui:setLabelAlignment(label, "left", "center")
  y = y + 30
  playerNameInput = seexports.sGui:createGuiElement("input", pad, y, 250, 30, mdcAppInside)
  seexports.sGui:setInputPlaceholder(playerNameInput, "Név")
  seexports.sGui:setInputMaxLength(playerNameInput, 32)
  setInputScheme(playerNameInput)
  if data == "loading" then
    seexports.sGui:setGuiHoverable(playerNameInput, false)
  end
  licenseIdInput = seexports.sGui:createGuiElement("input", pad + 250 + pad * 2, y, 250, 30, mdcAppInside)
  seexports.sGui:setInputPlaceholder(licenseIdInput, "Azonosító")
  seexports.sGui:setInputMaxLength(licenseIdInput, 8)
  setInputScheme(licenseIdInput)
  if data == "loading" then
    seexports.sGui:setGuiHoverable(licenseIdInput, false)
  end
  y = y + 30 + pad
  local btn = seexports.sGui:createGuiElement("button", pad, y, 175, 30, mdcAppInside)
  seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("search", 30))
  seexports.sGui:setButtonText(btn, " Lekérdezés indítása")
  seexports.sGui:setClickEvent(btn, "queryMdcPlayerByName")
  setButtonScheme(btn)
  if data == "loading" then
    seexports.sGui:setGuiHoverable(btn, false)
  end
  local btn = seexports.sGui:createGuiElement("button", pad + 250 + pad * 2, y, 175, 30, mdcAppInside)
  seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("search", 30))
  seexports.sGui:setButtonText(btn, " Lekérdezés indítása")
  seexports.sGui:setClickEvent(btn, "queryMdcPlayerByLicense")
  setButtonScheme(btn)
  if data == "loading" then
    seexports.sGui:setGuiHoverable(btn, false)
  end
  y = y + 30 + pad
  local border = seexports.sGui:createGuiElement("hr", pad + 250 + pad - 1, pad, 2, y - pad, mdcAppInside)
  seexports.sGui:setGuiHrColor(border, colorScheme.window2, colorScheme.window3)
  y = y + pad
  local border = seexports.sGui:createGuiElement("hr", pad, y - 1, insideX - pad * 2, 2, mdcAppInside)
  seexports.sGui:setGuiHrColor(border, colorScheme.window2, colorScheme.window3)
  loader = false
  if data == "loading" then
    local h = insideY - y
    createLoader(pad, y + h / 2 - 12, insideX - pad * 2, 24)
  elseif data then
    playerCharacterID = data.characterId
    y = y + pad
    local h = (insideY - y) / 3
    if data.imageId[1] and isElement(mdcImages[1]) then
      local image = seexports.sGui:createGuiElement("image", insideX - h, y, h - pad, h - pad, mdcAppInside)
      seexports.sGui:setImageFile(image, mdcImages[1])
      local label = seexports.sGui:createGuiElement("label", 0, h - pad - 16, h - pad, 16, image)
      seexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
      seexports.sGui:setLabelText(label, data.imageId[1])
      seexports.sGui:setLabelColor(label, "#ffffff")
      seexports.sGui:setLabelShadow(label, "#000000", 1, 1)
      seexports.sGui:setLabelAlignment(label, "center", "center")
    end
    if data.imageId[2] and isElement(mdcImages[2]) then
      local image = seexports.sGui:createGuiElement("image", insideX - h, y + h, h - pad, h - pad, mdcAppInside)
      seexports.sGui:setImageFile(image, mdcImages[2])
      local label = seexports.sGui:createGuiElement("label", 0, h - pad - 16, h - pad, 16, image)
      seexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
      seexports.sGui:setLabelText(label, data.imageId[2])
      seexports.sGui:setLabelColor(label, "#ffffff")
      seexports.sGui:setLabelShadow(label, "#000000", 1, 1)
      seexports.sGui:setLabelAlignment(label, "center", "center")
    end
    if data.imageId[3] and isElement(mdcImages[3]) then
      local image = seexports.sGui:createGuiElement("image", insideX - h, y + h * 2, h - pad, h - pad, mdcAppInside)
      seexports.sGui:setImageFile(image, mdcImages[3])
      local label = seexports.sGui:createGuiElement("label", 0, h - pad - 16, h - pad, 16, image)
      seexports.sGui:setLabelFont(label, "9/Ubuntu-R.ttf")
      seexports.sGui:setLabelText(label, data.imageId[3])
      seexports.sGui:setLabelColor(label, "#ffffff")
      seexports.sGui:setLabelShadow(label, "#000000", 1, 1)
      seexports.sGui:setLabelAlignment(label, "center", "center")
    end
    local label = seexports.sGui:createGuiElement("label", pad, y, 0, 0, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Név: ")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "top")
    local label = seexports.sGui:createGuiElement("label", pad + seexports.sGui:getLabelTextWidth(label), y, 0, 0, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    seexports.sGui:setLabelText(label, data.name)
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "top")
    y = y + seexports.sGui:getLabelFontHeight(label) + pad
    local label = seexports.sGui:createGuiElement("label", pad, y, 0, 0, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Névváltás: ")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "top")
    local label = seexports.sGui:createGuiElement("label", pad + seexports.sGui:getLabelTextWidth(label), y, 0, 0, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "top")
    if data.namechange then
      local time = getRealTime(data.namechange)
      local date = string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
      seexports.sGui:setLabelText(label, date)
    else
      seexports.sGui:setLabelText(label, "nem volt")
    end
    y = y + seexports.sGui:getLabelFontHeight(label) + pad
    local label = seexports.sGui:createGuiElement("label", pad, y, 0, 0, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Munkahely: ")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "top")
    local tw = seexports.sGui:getLabelTextWidth(label)
    local label = seexports.sGui:createGuiElement("label", pad + tw, y, insideX - pad * 2 - h - tw - pad, seexports.sGui:getLabelFontHeight(label), mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    seexports.sGui:setLabelClip(label, true)
    if data.workplace and 0 < #data.workplace then
      seexports.sGui:setLabelText(label, table.concat(data.workplace, ", "))
      seexports.sGui:guiSetTooltip(label, table.concat(data.workplace, "\n"))
      seexports.sGui:setGuiHoverable(label, true)
    else
      seexports.sGui:setLabelText(label, "nincs")
    end
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "top")
    y = y + seexports.sGui:getLabelFontHeight(label) + pad
    local border = seexports.sGui:createGuiElement("hr", pad, y - 1, insideX - pad * 2 - h, 2, mdcAppInside)
    seexports.sGui:setGuiHrColor(border, colorScheme.window2, colorScheme.window3)
    y = y + pad
    local btn = seexports.sGui:createGuiElement("button", pad, y, 200, 30, mdcAppInside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("car", 30))
    seexports.sGui:setButtonText(btn, " Járművek lekérdezése")
    seexports.sGui:setClickEvent(btn, "requestVehiclesOfPlayers")
    setButtonScheme(btn)
    local btn = seexports.sGui:createGuiElement("button", pad + 200 + pad, y, 200, 30, mdcAppInside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("home", 30))
    seexports.sGui:setButtonText(btn, " Ingatlanok lekérdezése")
    seexports.sGui:setClickEvent(btn, "requestInteriorsOfPlayers")
    setButtonScheme(btn)
    y = y + 30 + pad
    local border = seexports.sGui:createGuiElement("hr", pad, y - 1, insideX - pad * 2 - h, 2, mdcAppInside)
    seexports.sGui:setGuiHrColor(border, colorScheme.window2, colorScheme.window3)
    y = y + pad
    local label = seexports.sGui:createGuiElement("label", pad, y, 0, 0, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Körözések: ")
    seexports.sGui:setLabelColor(label, 0 < data.warrants and colorScheme.red or "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "top")
    local label = seexports.sGui:createGuiElement("label", pad + seexports.sGui:getLabelTextWidth(label), y, 0, 0, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    seexports.sGui:setLabelText(label, data.warrants)
    seexports.sGui:setLabelColor(label, 0 < data.warrants and colorScheme.red or "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "top")
    y = y + seexports.sGui:getLabelFontHeight(label) + pad
    local label = seexports.sGui:createGuiElement("label", pad, y, 0, 0, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Priusz: ")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "top")
    local label = seexports.sGui:createGuiElement("label", pad + seexports.sGui:getLabelTextWidth(label), y, 0, 0, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    seexports.sGui:setLabelText(label, data.record)
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "top")
    y = y + seexports.sGui:getLabelFontHeight(label) + pad
    local btn = seexports.sGui:createGuiElement("button", pad, y, 200, 30, mdcAppInside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("exclamation-triangle", 30))
    seexports.sGui:setButtonText(btn, " Körözések lekérdezése")
    seexports.sGui:setClickEvent(btn, "getWarrantsOfPlayer")
    setButtonScheme(btn)
    local btn = seexports.sGui:createGuiElement("button", pad + 200 + pad, y, 200, 30, mdcAppInside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("archive", 30))
    seexports.sGui:setButtonText(btn, " Priusz lekérdezése")
    seexports.sGui:setClickEvent(btn, "getRecordsOfPlayer")
    setButtonScheme(btn)
    playerRecords = data.record
    y = y + 30 + pad
    local border = seexports.sGui:createGuiElement("hr", pad, y - 1, insideX - pad * 2 - h, 2, mdcAppInside)
    seexports.sGui:setGuiHrColor(border, colorScheme.window2, colorScheme.window3)
    y = y + pad
    local btn = seexports.sGui:createGuiElement("button", pad, insideY - 30 - pad, 300, 30, mdcAppInside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("user-times", 30))
    seexports.sGui:setButtonText(btn, " Vezetői engedély bevonása")
    seexports.sGui:setButtonIconColor(btn, colorScheme.red)
    if not data.licenses.dl or data.licenses.dl[5] then
      setDisabledButtonScheme(btn)
    else
      seexports.sGui:setClickEvent(btn, "mdcRevokeDriversLicense")
      setButtonScheme(btn)
    end
    local btn = seexports.sGui:createGuiElement("button", pad, insideY - (30 + pad) * 2, 300, 30, mdcAppInside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("user-times", 30))
    seexports.sGui:setButtonText(btn, " Fegyverviselési engedély bevonása")
    seexports.sGui:setButtonIconColor(btn, colorScheme.red)
    if not data.licenses.wp or data.licenses.wp[4] or data.licenses.wp[5] then
      setDisabledButtonScheme(btn)
    else
      seexports.sGui:setClickEvent(btn, "mdcRevokeWeaponLicense")
      setButtonScheme(btn)
    end
    local w = insideX - pad * 2 - h
    local h = insideY - (30 + pad) * 2 - y - pad
    local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w, h, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", "#ffffff")
    seexports.sGui:setGuiBackgroundBorder(rect, 2, colorScheme.window2)
    w = w / 4
    for i = 1, 3 do
      local rect = seexports.sGui:createGuiElement("rectangle", pad + w * i, y, 1, h, mdcAppInside)
      seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
    end
    h = h / 5
    local label = seexports.sGui:createGuiElement("label", pad, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Okmány")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Azonosító")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w * 2, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Kiállítás")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w * 3, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Érvényesség")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    y = y + h
    local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w * 4, 1, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
    local label = seexports.sGui:createGuiElement("label", pad, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelText(label, "Személyi igazolvány")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label1 = seexports.sGui:createGuiElement("label", pad + w, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label1, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelColor(label1, "#000000")
    seexports.sGui:setLabelAlignment(label1, "center", "center")
    local label2 = seexports.sGui:createGuiElement("label", pad + w * 2, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label2, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelColor(label2, "#000000")
    seexports.sGui:setLabelAlignment(label2, "center", "center")
    local label3 = seexports.sGui:createGuiElement("label", pad + w * 3, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label3, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelColor(label3, "#000000")
    seexports.sGui:setLabelAlignment(label3, "center", "center")
    if data.licenses.id then
      seexports.sGui:setLabelText(label1, data.licenses.id[1])
      local time = getRealTime(data.licenses.id[2] * 24 * 60 * 60)
      seexports.sGui:setLabelText(label2, string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday))
      local time = getRealTime(data.licenses.id[3] * 24 * 60 * 60)
      if data.licenses.id[4] then
        seexports.sGui:setLabelColor(label, colorScheme.red)
        seexports.sGui:setLabelColor(label1, colorScheme.red)
        seexports.sGui:setLabelColor(label2, colorScheme.red)
        seexports.sGui:setLabelColor(label3, colorScheme.red)
      end
      seexports.sGui:setLabelText(label3, string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday))
    else
      seexports.sGui:setLabelText(label1, "nincs")
      seexports.sGui:setLabelText(label2, "nincs")
      seexports.sGui:setLabelText(label3, "nincs")
    end
    y = y + h
    local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w * 4, 1, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
    local label = seexports.sGui:createGuiElement("label", pad, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelText(label, "Vezetői engedély")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label1 = seexports.sGui:createGuiElement("label", pad + w, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label1, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelColor(label1, "#000000")
    seexports.sGui:setLabelAlignment(label1, "center", "center")
    local label2 = seexports.sGui:createGuiElement("label", pad + w * 2, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label2, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelColor(label2, "#000000")
    seexports.sGui:setLabelAlignment(label2, "center", "center")
    local label3 = seexports.sGui:createGuiElement("label", pad + w * 3, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label3, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelColor(label3, "#000000")
    seexports.sGui:setLabelAlignment(label3, "center", "center")
    if data.licenses.dl then
      seexports.sGui:setLabelText(label1, data.licenses.dl[1])
      local time = getRealTime(data.licenses.dl[2] * 24 * 60 * 60)
      seexports.sGui:setLabelText(label2, string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday))
      local time = getRealTime(data.licenses.dl[3] * 24 * 60 * 60)
      if data.licenses.dl[4] or data.licenses.dl[5] then
        seexports.sGui:setLabelColor(label, colorScheme.red)
        seexports.sGui:setLabelColor(label1, colorScheme.red)
        seexports.sGui:setLabelColor(label2, colorScheme.red)
        seexports.sGui:setLabelColor(label3, colorScheme.red)
      end
      if data.licenses.dl[5] then
        seexports.sGui:setLabelText(label3, "bevont")
      else
        seexports.sGui:setLabelText(label3, string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday))
      end
    else
      seexports.sGui:setLabelText(label1, "nincs")
      seexports.sGui:setLabelText(label2, "nincs")
      seexports.sGui:setLabelText(label3, "nincs")
    end
    y = y + h
    local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w * 4, 1, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
    local label = seexports.sGui:createGuiElement("label", pad, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelText(label, "Fegyverviselési engedély")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label1 = seexports.sGui:createGuiElement("label", pad + w, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label1, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelColor(label1, "#000000")
    seexports.sGui:setLabelAlignment(label1, "center", "center")
    local label2 = seexports.sGui:createGuiElement("label", pad + w * 2, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label2, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelColor(label2, "#000000")
    seexports.sGui:setLabelAlignment(label2, "center", "center")
    local label3 = seexports.sGui:createGuiElement("label", pad + w * 3, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label3, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelColor(label3, "#000000")
    seexports.sGui:setLabelAlignment(label3, "center", "center")
    if data.licenses.wp then
      seexports.sGui:setLabelText(label1, data.licenses.wp[1])
      local time = getRealTime(data.licenses.wp[2] * 24 * 60 * 60)
      seexports.sGui:setLabelText(label2, string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday))
      local time = getRealTime(data.licenses.wp[3] * 24 * 60 * 60)
      if data.licenses.wp[4] or data.licenses.wp[5] then
        seexports.sGui:setLabelColor(label, colorScheme.red)
        seexports.sGui:setLabelColor(label1, colorScheme.red)
        seexports.sGui:setLabelColor(label2, colorScheme.red)
        seexports.sGui:setLabelColor(label3, colorScheme.red)
      end
      if data.licenses.wp[5] then
        seexports.sGui:setLabelText(label3, "bevont")
      else
        seexports.sGui:setLabelText(label3, string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday))
      end
    else
      seexports.sGui:setLabelText(label1, "nincs")
      seexports.sGui:setLabelText(label2, "nincs")
      seexports.sGui:setLabelText(label3, "nincs")
    end
    y = y + h
    local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w * 4, 1, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
    local label = seexports.sGui:createGuiElement("label", pad, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelText(label, "Horgászengedély")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label1 = seexports.sGui:createGuiElement("label", pad + w, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label1, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelColor(label1, "#000000")
    seexports.sGui:setLabelAlignment(label1, "center", "center")
    local label2 = seexports.sGui:createGuiElement("label", pad + w * 2, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label2, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelColor(label2, "#000000")
    seexports.sGui:setLabelAlignment(label2, "center", "center")
    local label3 = seexports.sGui:createGuiElement("label", pad + w * 3, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label3, "10/Ubuntu-L.ttf")
    seexports.sGui:setLabelColor(label3, "#000000")
    seexports.sGui:setLabelAlignment(label3, "center", "center")
    if data.licenses.fs then
      seexports.sGui:setLabelText(label1, data.licenses.fs[1])
      local time = getRealTime(data.licenses.fs[2] * 24 * 60 * 60)
      seexports.sGui:setLabelText(label2, string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday))
      local time = getRealTime(data.licenses.fs[3] * 24 * 60 * 60)
      if data.licenses.fs[4] then
        seexports.sGui:setLabelColor(label, colorScheme.red)
        seexports.sGui:setLabelColor(label1, colorScheme.red)
        seexports.sGui:setLabelColor(label2, colorScheme.red)
        seexports.sGui:setLabelColor(label3, colorScheme.red)
      end
      seexports.sGui:setLabelText(label3, string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday))
    else
      seexports.sGui:setLabelText(label1, "nincs")
      seexports.sGui:setLabelText(label2, "nincs")
      seexports.sGui:setLabelText(label3, "nincs")
    end
    y = y + h
    local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w * 4, 1, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
  end
  orderMDCGui()
end
