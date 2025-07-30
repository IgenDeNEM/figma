local seexports = {
  sGui = false,
  sFarm = false,
  sInteriors = false,
  sPaintshop = false
}
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
local interiorScroll = 0
local interiorScrollHeight = false
local interiorScrollBar = false
local interiorOwnerName = false
local interiorElements = {}
local interiorList = {}
local playerNameInput = false
local interiorIDInput = false
function mdcInteriorKey(key)
  if key == "mouse_wheel_up" then
    if 0 < interiorScroll then
      interiorScroll = interiorScroll - 1
      processInteriors()
    end
  elseif key == "mouse_wheel_down" then
    local n = math.max(0, #interiorList - #interiorElements)
    if n > interiorScroll then
      interiorScroll = interiorScroll + 1
      processInteriors()
    end
  elseif key == "enter" then
    local input = seexports.sGui:getActiveInput()
    if input == playerNameInput then
      triggerEvent("getMDCPlayerInteriorsByName", localPlayer)
    elseif input == interiorIDInput then
      triggerEvent("getMDCInteriorById", localPlayer)
    end
  end
end
function processInteriors()
  local n = math.max(0, #interiorList - #interiorElements)
  if n < interiorScroll then
    interiorScroll = n
  end
  local sh = interiorScrollHeight / (n + 1)
  seexports.sGui:setGuiPosition(interiorScrollBar, false, 2 + sh * interiorScroll)
  seexports.sGui:setGuiSize(interiorScrollBar, false, sh)
  for i = 1, #interiorElements do
    if interiorList[i + interiorScroll] then
      local label = interiorElements[i][1]
      seexports.sGui:setLabelText(label, interiorList[i + interiorScroll][1])
      seexports.sGui:setGuiRenderDisabled(label, false)
      local label = interiorElements[i][2]
      seexports.sGui:setLabelText(label, interiorList[i + interiorScroll][2])
      seexports.sGui:setGuiRenderDisabled(label, false)
      local label = interiorElements[i][3]
      seexports.sGui:setLabelText(label, interiorList[i + interiorScroll][3])
      seexports.sGui:setGuiRenderDisabled(label, false)
      local label = interiorElements[i][4]
      seexports.sGui:setLabelText(label, interiorOwnerName)
      seexports.sGui:setGuiRenderDisabled(label, false)
      seexports.sGui:setGuiRenderDisabled(interiorElements[i][5], false)
    else
      for j = 1, #interiorElements[i] do
        seexports.sGui:setGuiRenderDisabled(interiorElements[i][j], true)
      end
    end
  end
end
addEvent("gotMDCInteriors", true)
addEventHandler("gotMDCInteriors", getRootElement(), function(data, id, name, extend)
  if activeMdcApp == "interior" then
    if data then
      playerCharacterID = id
      interiorOwnerName = name:gsub("_", " ")
      interiorList = data
      if extend then
        local farms = seexports.sFarm:getPlayerFarmsForDashboard(id)
        for i = 1, #farms do
          table.insert(interiorList, {
            farms[i].id,
            "Farm",
            farms[i].name,
            "farm"
          })
        end
      end
      interiorScroll = 0
      createMDCInteriorApp(true)
    else
      playerCharacterID = false
      interiorOwnerName = false
      createMDCInteriorApp()
      createMDCErrorPrompt("Hiba", 225, 125, "Nincs találat!", true)
    end
  end
end)
addEvent("getMDCPlayerInteriorsByName", true)
addEventHandler("getMDCPlayerInteriorsByName", getRootElement(), function()
  local value = seexports.sGui:getInputValue(playerNameInput)
  if value and utf8.len(value) > 0 then
    createMDCInteriorApp("loading")
    triggerLatentServerEvent("getMDCPlayerInteriorsByName", localPlayer, value)
  end
end)
addEvent("getMDCInteriorById", true)
addEventHandler("getMDCInteriorById", getRootElement(), function()
  local value = tonumber(seexports.sGui:getInputValue(interiorIDInput))
  if value then
    createMDCInteriorApp("loading")
    triggerLatentServerEvent("getMDCInteriorById", localPlayer, value)
  end
end)
addEvent("mdcInteriorsNewQuery", true)
addEventHandler("mdcInteriorsNewQuery", getRootElement(), function()
  playerCharacterID = false
  interiorOwnerName = false
  interiorList = {}
  createMDCInteriorApp()
end)
addEvent("markMDCInterior", true)
addEventHandler("markMDCInterior", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #interiorElements do
    if interiorElements[i] and interiorElements[i][5] == el then
      if interiorList[i + interiorScroll] then
        if not interiorList[i + interiorScroll][4] then
          seexports.sInteriors:markInteriorOnMap(interiorList[i + interiorScroll][1])
        elseif interiorList[i + interiorScroll][4] == "farm" then
          seexports.sFarm:markFarm(interiorList[i + interiorScroll][1])
        elseif interiorList[i + interiorScroll][4] == "garage" then
          seexports.sPaintshop:markGarageDoor(interiorList[i + interiorScroll][1])
        elseif interiorList[i + interiorScroll][4] == "paintshop" then
          seexports.sPaintshop:markGarageDoor(interiorList[i + interiorScroll][1])
        end
      end
      return
    end
  end
end)
function createMDCInteriorApp(data)
  seexports.sGui:deleteAllChildren(mdcAppInside)
  activeMdcApp = "interior"
  loader = false
  local y = pad
  interiorIDInput = false
  playerNameInput = false
  if not data then
    local label = seexports.sGui:createGuiElement("label", pad, y, 0, 30, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    seexports.sGui:setLabelText(label, "Lekérdezés tulajdonos alapján:")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "center")
    local label = seexports.sGui:createGuiElement("label", pad + 250 + pad + 125 + pad * 2, y, 0, 30, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    seexports.sGui:setLabelText(label, "Lekérdezés hrsz. (ID) alapján:")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "left", "center")
    y = y + 30
    playerNameInput = seexports.sGui:createGuiElement("input", pad, y, 250, 30, mdcAppInside)
    seexports.sGui:setInputPlaceholder(playerNameInput, "Név")
    seexports.sGui:setInputMaxLength(playerNameInput, 32)
    setInputScheme(playerNameInput)
    local btn = seexports.sGui:createGuiElement("button", pad + 250 + pad, y, 125, 30, mdcAppInside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("search", 30))
    seexports.sGui:setButtonText(btn, " Lekérdezés")
    seexports.sGui:setClickEvent(btn, "getMDCPlayerInteriorsByName")
    setButtonScheme(btn)
    interiorIDInput = seexports.sGui:createGuiElement("input", pad + 250 + pad + 125 + pad * 2, y, 250, 30, mdcAppInside)
    seexports.sGui:setInputPlaceholder(interiorIDInput, "Azonosító")
    seexports.sGui:setInputMaxLength(interiorIDInput, 8)
    seexports.sGui:setInputNumberOnly(interiorIDInput, true)
    setInputScheme(interiorIDInput)
    local btn = seexports.sGui:createGuiElement("button", pad + 250 + pad + 125 + pad * 2 + 250 + pad, y, 125, 30, mdcAppInside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("search", 30))
    seexports.sGui:setButtonText(btn, " Lekérdezés")
    seexports.sGui:setClickEvent(btn, "getMDCInteriorById")
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
      seexports.sGui:setClickEvent(btn, "mdcInteriorsNewQuery")
      setButtonScheme(btn)
      y = y + 30 + pad + pad
      local border = seexports.sGui:createGuiElement("hr", pad, pad + 30 + pad - 1, insideX - pad * 2, 2, mdcAppInside)
      seexports.sGui:setGuiHrColor(border, colorScheme.window2, colorScheme.window3)
    else
      local btn = seexports.sGui:createGuiElement("button", pad, pad, 150, 30, mdcAppInside)
      seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      seexports.sGui:setButtonText(btn, "Új lekérdezés")
      seexports.sGui:setClickEvent(btn, "mdcInteriorsNewQuery")
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
    w = w / 3.5
    local rect = seexports.sGui:createGuiElement("rectangle", pad + w / 2, y, 1, h, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
    for i = 1, 3 do
      local rect = seexports.sGui:createGuiElement("rectangle", pad + w * i, y, 1, h, mdcAppInside)
      seexports.sGui:setGuiBackground(rect, "solid", colorScheme.window2)
    end
    local label = seexports.sGui:createGuiElement("label", pad, y, w / 2, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "HRSZ")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w / 2, y, w / 2, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Típus")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w * 1, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Név")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w * 2, y, w, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "Tulajdonos")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    local label = seexports.sGui:createGuiElement("label", pad + w * 3, y, w * 0.5, h, mdcAppInside)
    seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    seexports.sGui:setLabelText(label, "GPS")
    seexports.sGui:setLabelColor(label, "#000000")
    seexports.sGui:setLabelAlignment(label, "center", "center")
    y = y + h
    interiorScrollHeight = h * n - 4
    local rect = seexports.sGui:createGuiElement("rectangle", pad + w * 3.5, y, 18, interiorScrollHeight + 4, mdcAppInside)
    seexports.sGui:setGuiBackground(rect, "solid", colorScheme.btn1)
    seexports.sGui:setGuiBackgroundBorder(rect, 2, colorScheme.window2)
    interiorScrollBar = seexports.sGui:createGuiElement("rectangle", 2, 2, 14, interiorScrollHeight, rect)
    seexports.sGui:setGuiBackground(interiorScrollBar, "solid", colorScheme.btn2)
    interiorElements = {}
    for i = 1, n do
      interiorElements[i] = {}
      local rect = seexports.sGui:createGuiElement("rectangle", pad, y, w * 3.5, 1, mdcAppInside)
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
      interiorElements[i][1] = label
      local label = seexports.sGui:createGuiElement("label", pad + w / 2, y, w / 2, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      interiorElements[i][2] = label
      local label = seexports.sGui:createGuiElement("label", pad + w, y, w, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      interiorElements[i][3] = label
      local label = seexports.sGui:createGuiElement("label", pad + w * 2, y, w, h, mdcAppInside)
      seexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
      seexports.sGui:setLabelColor(label, "#000000")
      seexports.sGui:setLabelWordBreak(label, true)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      interiorElements[i][4] = label
      local btn = seexports.sGui:createGuiElement("button", pad + w * 3 + 1, y + 1, w * 0.5 - 2, h - 2, mdcAppInside)
      seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      seexports.sGui:setButtonText(btn, "Megjelölés")
      seexports.sGui:setClickEvent(btn, "markMDCInterior")
      setButtonScheme(btn)
      interiorElements[i][5] = btn
      y = y + h
    end
    processInteriors()
  end
  orderMDCGui()
end
