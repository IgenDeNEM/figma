local seexports = {
  sGui = false,
  sGroups = false,
  sTraffipax = false,
  sNames = false,
  sDashboard = false,
  sMarkers = false,
  sVehiclenames = false,
  sRadar = false
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
local sightlangWaiterState0 = false
local sightlangWaiterState1 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sMarkers")
    if res0 and getResourceState(res0) == "running" then
      createMDCMarkers()
      sightlangWaiterState0 = true
    end
  end
  if not sightlangWaiterState1 then
    local res0 = getResourceFromName("sGroups")
    if res0 and getResourceState(res0) == "running" then
      refreshInPolice()
      sightlangWaiterState1 = true
    end
  end
end
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientCursorMove", getRootElement(), mdcCursorMove, true, prio)
    else
      removeEventHandler("onClientCursorMove", getRootElement(), mdcCursorMove)
    end
  end
end
local mdcOpening = false
screenX, screenY = guiGetScreenSize()
mdcVeh = false
mdcWindow = false
local mdcInside = false
local dateLabel = false
local currentDate = false
mdcFront = false
mdcScan = false
mdcImages = {}
function orderMDCGui()
  seexports.sGui:guiToFront(mdcFront)
  seexports.sGui:guiToFront(mdcScan)
end
colorScheme = {
  base = {
    59,
    119,
    188
  },
  taskbar = {
    40,
    100,
    150,
    200
  },
  window = {
    240,
    240,
    220
  },
  window2 = {
    180,
    180,
    160
  },
  window3 = {
    200,
    200,
    180
  },
  red = {
    222,
    72,
    43
  },
  blue = {
    59,
    119,
    188
  },
  green = {
    129,
    192,
    70
  },
  yellow = {
    252,
    207,
    3
  },
  red2 = {
    242,
    92,
    63
  },
  blue2 = {
    79,
    139,
    208
  },
  green2 = {
    149,
    212,
    90
  },
  yellow2 = {
    255,
    227,
    23
  },
  btn1 = {
    255,
    255,
    250
  },
  btn2 = {
    205,
    205,
    225
  }
}
baseX, baseY = 1000, 670
insideX, insideY = baseX, baseY
pad = 8
loader = false
local loaderBackground = false
local loaderForeground = false
function createLoader(x, y, sx, sy)
  loader = {
    x + 1,
    y + 1 + 1,
    sx - 2,
    sy - 2
  }
  loaderBackground = seexports.sGui:createGuiElement("rectangle", x, y, sx, sy, mdcAppInside)
  seexports.sGui:setGuiBackground(loaderBackground, "solid", colorScheme.btn1)
  seexports.sGui:setGuiBackgroundBorder(loaderBackground, 1, "#000000")
  loaderForeground = {}
  for i = 1, 4 do
    loaderForeground[i] = seexports.sGui:createGuiElement("rectangle", x + 1, y + 1 + 1, 10, sy - 2 - 2, mdcAppInside)
    seexports.sGui:setGuiBackground(loaderForeground[i], "gradient", {
      colorScheme.green,
      colorScheme.green2
    })
  end
  orderMDCGui()
end
function mdcKey(key, por)
  if key == "mouse_wheel_up" or key == "mouse_wheel_down" or key == "enter" and por then
    if activeMdcApp == "player" then
      mdcPlayerKey(key)
    elseif activeMdcApp == "record" then
      mdcRecordKey(key)
    elseif activeMdcApp == "platewarrant" then
      mdcPlateWarrantKey(key)
    elseif activeMdcApp == "warrant" then
      mdcWarrantKey(key)
    elseif activeMdcApp == "vehicle" then
      mdcVehicleKey(key)
    elseif activeMdcApp == "interior" then
      mdcInteriorKey(key)
    end
  end
end
function mdcRender()
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh ~= mdcVeh then
    closeMDC(true)
    return
  end
  local time = getRealTime()
  local date = string.format([[
%02d:%02d
%04d. %02d. %02d.]], time.hour, time.minute, time.year + 1900, time.month + 1, time.monthday)
  if date ~= currentDate then
    currentDate = date
    seexports.sGui:setLabelText(dateLabel, currentDate)
  end
  if loader then
    local x, y, sx, sy = unpack(loader)
    local ox = x
    local p = getTickCount() % (sx * 4) / (sx * 4)
    x = x + (sx + 56 + 4) * p - 56
    for i = 1, 4 do
      if ox > x then
        seexports.sGui:setGuiPosition(loaderForeground[i], ox, y)
        seexports.sGui:setGuiSize(loaderForeground[i], math.max(0, 10 + (x - ox)), false)
      else
        seexports.sGui:setGuiPosition(loaderForeground[i], x, y)
        seexports.sGui:setGuiSize(loaderForeground[i], math.min(10, math.max(0, sx - x + 12 - 2 - 1)), false)
      end
      x = x + 14
    end
  end
end
activeMdcApp = false
local mdcApp = false
mdcPrompt = false
mdcPromptInput = false
mdcAppInside = false
function closeMDCApp()
  playerCharacterID = false
  if mdcPrompt then
    seexports.sGui:deleteGuiElement(mdcPrompt)
  end
  mdcPrompt = false
  mdcPromptInput = false
  for i = 1, #mdcImages do
    if isElement(mdcImages[i]) then
      destroyElement(mdcImages[i])
    end
  end
  mdcImages = {}
  if mdcApp then
    seexports.sGui:deleteGuiElement(mdcApp)
  end
  mdcApp = false
  mdcAppInside = false
  activeMdcApp = false
  loaderBackground = false
  loaderForeground = false
  loader = false
end
addEvent("closeMDCApplication", false)
addEventHandler("closeMDCApplication", getRootElement(), function()
  closeMDCApp()
  createDesktop()
end)
local lastPlates = {}
function addLastPlate(id, plate, mdcCol)
  for i = #lastPlates, 1, -1 do
    if lastPlates[i][1] == id then
      table.remove(lastPlates, i)
    end
  end
  table.insert(lastPlates, {
    id,
    plate,
    mdcCol
  })
  if 5 < #lastPlates then
    table.remove(lastPlates, 1)
  end
  if not activeMdcApp and mdcWindow then
    createDesktop()
  end
end
addEvent("mdcSquadOff", false)
addEventHandler("mdcSquadOff", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  seexports.sGui:setGuiHoverable(el, false)
  seexports.sGui:setClickEvent(el, false)
  triggerServerEvent("toggleMDCSquad", localPlayer, false)
end)
addEvent("mdcSquadOn", false)
addEventHandler("mdcSquadOn", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  seexports.sGui:setGuiHoverable(el, false)
  seexports.sGui:setClickEvent(el, false)
  triggerServerEvent("toggleMDCSquad", localPlayer, true)
end)
addEvent("mdcSquadBackup", false)
addEventHandler("mdcSquadBackup", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  seexports.sGui:setGuiHoverable(el, false)
  seexports.sGui:setClickEvent(el, false)
  triggerServerEvent("mdcSquadBackup", localPlayer)
end)
local mdcSquadName = ""
local squadColorButtons = {}
addEvent("finalChangeMDCSquad", false)
addEventHandler("finalChangeMDCSquad", getRootElement(), function()
  local val = seexports.sGui:getInputValue(mdcPromptInput)
  if val and utf8.len(val) > 0 and utf8.len(val) <= 10 then
    local col = 1
    for rect, i in pairs(squadColorButtons) do
      if not seexports.sGui:getGuiHoverable(rect) then
        col = i
        break
      end
    end
    triggerServerEvent("changeMDCSquad", localPlayer, val, col)
    mdcSquadName = val
    if mdcPrompt then
      seexports.sGui:deleteGuiElement(mdcPrompt)
    end
    mdcPrompt = false
    mdcPromptInput = false
    squadColorButtons = {}
    createDesktop()
  end
end)
addEvent("changeSquadColor", false)
addEventHandler("changeSquadColor", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for rect in pairs(squadColorButtons) do
    if rect == el then
      seexports.sGui:setGuiBackgroundBorder(rect, 3, "#000000")
      seexports.sGui:setGuiHoverable(rect, false)
      seexports.sGui:setClickEvent(rect, false)
    else
      seexports.sGui:setGuiBackgroundBorder(rect, 1, "#000000")
      seexports.sGui:setGuiHoverable(rect, true)
      seexports.sGui:setClickEvent(rect, "changeSquadColor")
    end
  end
end)
addEvent("changeMDCSquad", false)
addEventHandler("changeMDCSquad", getRootElement(), function()
  if not mdcPrompt then
    local inside, w, ih = createMDCInputPrompt("Egységcsere", 400, 175, "Egység neve", "finalChangeMDCSquad")
    local h = (w - pad) / #definedSquadColors
    local y = (ih - pad - 24 - pad) / 2 - (30 + pad + h - pad) / 2
    seexports.sGui:setGuiPosition(mdcPromptInput, false, y)
    seexports.sGui:setInputMaxLength(mdcPromptInput, 10)
    y = y + 30 + pad
    squadColorButtons = {}
    for i = 1, #definedSquadColors do
      local rect = seexports.sGui:createGuiElement("rectangle", pad + (i - 1) * h, y, h - pad, h - pad, inside)
      seexports.sGui:setGuiBackground(rect, "solid", "sight" .. definedSquadColors[i])
      seexports.sGui:setGuiHover(rect, "none", false, false, true)
      squadColorButtons[rect] = i
      if i == 1 then
        seexports.sGui:setGuiBackgroundBorder(rect, 3, "#000000")
        seexports.sGui:setGuiHoverable(rect, false)
        seexports.sGui:setClickEvent(rect, false)
      else
        seexports.sGui:setGuiBackgroundBorder(rect, 1, "#000000")
        seexports.sGui:setGuiHoverable(rect, true)
        seexports.sGui:setClickEvent(rect, "changeSquadColor")
      end
    end
  end
end)
addEvent("queryMDCLastPlate", false)
addEventHandler("queryMDCLastPlate", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  for i = 1, #lastPlates do
    if lastPlates[i] and lastPlates[i][4] == el then
      createMDCApp("Jármű lekérdezés", "vehicle")
      createMDCVehicleApp("loading")
      triggerLatentServerEvent("getMDCVehicleById", localPlayer, lastPlates[i][1])
      return
    end
  end
end)
function createDesktop()
  if mdcApp then
    seexports.sGui:deleteGuiElement(mdcApp)
  end
  mdcApp = seexports.sGui:createGuiElement("null", 0, 0, baseX, baseY - 32, mdcInside)
  local x = pad
  local y = pad
  local rect = seexports.sGui:createGuiElement("rectangle", x, y, 64, 80, mdcApp)
  seexports.sGui:setGuiBackground(rect, "solid", {
    0,
    0,
    0,
    0
  })
  seexports.sGui:setGuiHover(rect, "none")
  seexports.sGui:setGuiHoverable(rect, "none")
  seexports.sGui:setClickEvent(rect, "openMDCPlayerApp")
  local pic = seexports.sGui:createGuiElement("image", 8, 0, 48, 48, rect)
  seexports.sGui:setImageDDS(pic, ":sMdc/files/player.dds")
  local label = seexports.sGui:createGuiElement("label", 0, 48, 64, 32, rect)
  seexports.sGui:setLabelFont(label, "8/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, "Személy lekérdezés")
  seexports.sGui:setLabelAlignment(label, "center", "top")
  seexports.sGui:setLabelColor(label, "#ffffff")
  seexports.sGui:setLabelShadow(label, "#000000", 1, 1)
  seexports.sGui:setLabelWordBreak(label, true)
  y = y + 80 + pad
  local rect = seexports.sGui:createGuiElement("rectangle", x, y, 64, 80, mdcApp)
  seexports.sGui:setGuiBackground(rect, "solid", {
    0,
    0,
    0,
    0
  })
  seexports.sGui:setGuiHover(rect, "none")
  seexports.sGui:setGuiHoverable(rect, "none")
  seexports.sGui:setClickEvent(rect, "openMDCWarrantApp")
  local pic = seexports.sGui:createGuiElement("image", 8, 0, 48, 48, rect)
  seexports.sGui:setImageDDS(pic, ":sMdc/files/wanted.dds")
  local label = seexports.sGui:createGuiElement("label", 0, 48, 64, 32, rect)
  seexports.sGui:setLabelFont(label, "8/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, "Körözések")
  seexports.sGui:setLabelAlignment(label, "center", "top")
  seexports.sGui:setLabelColor(label, "#ffffff")
  seexports.sGui:setLabelShadow(label, "#000000", 1, 1)
  seexports.sGui:setLabelWordBreak(label, true)
  y = y + 80 + pad
  local rect = seexports.sGui:createGuiElement("rectangle", x, y, 64, 80, mdcApp)
  seexports.sGui:setGuiBackground(rect, "solid", {
    0,
    0,
    0,
    0
  })
  seexports.sGui:setGuiHover(rect, "none")
  seexports.sGui:setGuiHoverable(rect, "none")
  seexports.sGui:setClickEvent(rect, "openMDCPlateWarrantApp")
  local pic = seexports.sGui:createGuiElement("image", 8, 0, 48, 48, rect)
  seexports.sGui:setImageDDS(pic, ":sMdc/files/vwanted.dds")
  local label = seexports.sGui:createGuiElement("label", 0, 48, 64, 32, rect)
  seexports.sGui:setLabelFont(label, "8/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, "Rendszám körözések")
  seexports.sGui:setLabelAlignment(label, "center", "top")
  seexports.sGui:setLabelColor(label, "#ffffff")
  seexports.sGui:setLabelShadow(label, "#000000", 1, 1)
  seexports.sGui:setLabelWordBreak(label, true)
  y = y + 80 + pad
  local rect = seexports.sGui:createGuiElement("rectangle", x, y, 64, 80, mdcApp)
  seexports.sGui:setGuiBackground(rect, "solid", {
    0,
    0,
    0,
    0
  })
  seexports.sGui:setGuiHover(rect, "none")
  seexports.sGui:setGuiHoverable(rect, "none")
  seexports.sGui:setClickEvent(rect, "openMDCVehicleApp")
  local pic = seexports.sGui:createGuiElement("image", 8, 0, 48, 48, rect)
  seexports.sGui:setImageDDS(pic, ":sMdc/files/vehicle.dds")
  local label = seexports.sGui:createGuiElement("label", 0, 48, 64, 32, rect)
  seexports.sGui:setLabelFont(label, "8/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, "Jármű lekérdezés")
  seexports.sGui:setLabelAlignment(label, "center", "top")
  seexports.sGui:setLabelColor(label, "#ffffff")
  seexports.sGui:setLabelShadow(label, "#000000", 1, 1)
  seexports.sGui:setLabelWordBreak(label, true)
  y = y + 80 + pad
  local rect = seexports.sGui:createGuiElement("rectangle", x, y, 64, 80, mdcApp)
  seexports.sGui:setGuiBackground(rect, "solid", {
    0,
    0,
    0,
    0
  })
  seexports.sGui:setGuiHover(rect, "none")
  seexports.sGui:setGuiHoverable(rect, "none")
  seexports.sGui:setClickEvent(rect, "openMDCInteriorApp")
  local pic = seexports.sGui:createGuiElement("image", 8, 0, 48, 48, rect)
  seexports.sGui:setImageDDS(pic, ":sMdc/files/inti.dds")
  local label = seexports.sGui:createGuiElement("label", 0, 48, 64, 32, rect)
  seexports.sGui:setLabelFont(label, "8/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, "Ingatlan lekérdezés")
  seexports.sGui:setLabelAlignment(label, "center", "top")
  seexports.sGui:setLabelColor(label, "#ffffff")
  seexports.sGui:setLabelShadow(label, "#000000", 1, 1)
  seexports.sGui:setLabelWordBreak(label, true)

  if mdcVeh and getPedOccupiedVehicleSeat(localPlayer) ~= 0 and seexports.sGroups:getPlayerPermission("traffi") and seexports.sTraffipax:getTraffipaxModel(getElementModel(mdcVeh)) then
    y = y + 80 + pad
    local rect = seexports.sGui:createGuiElement("rectangle", x, y, 64, 80, mdcApp)
    seexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    seexports.sGui:setGuiHover(rect, "none")
    seexports.sGui:setGuiHoverable(rect, "none")
    seexports.sGui:setClickEvent(rect, "openMDCTraffipax")
    local pic = seexports.sGui:createGuiElement("image", 8, 0, 48, 48, rect)
    seexports.sGui:setImageDDS(pic, ":sMdc/files/traffi.dds")
    local label = seexports.sGui:createGuiElement("label", 0, 48, 64, 32, rect)
    seexports.sGui:setLabelFont(label, "8/Ubuntu-R.ttf")
    seexports.sGui:setLabelText(label, "Traffipax")
    seexports.sGui:setLabelAlignment(label, "center", "top")
    seexports.sGui:setLabelColor(label, "#ffffff")
    seexports.sGui:setLabelShadow(label, "#000000", 1, 1)
    seexports.sGui:setLabelWordBreak(label, true)
  end
  local widget = false
  local sx, sy = 200, 24 + pad + (30 + pad)
  local x, y = baseX - sx - pad, pad
  widget = seexports.sGui:createGuiElement("rectangle", x, y, sx, sy, mdcApp)
  seexports.sGui:setGuiBackground(widget, "solid", colorScheme.base)
  seexports.sGui:setGuiHover(widget, "none", false, false, true)
  seexports.sGui:setGuiHoverable(widget, true)
  seexports.sGui:disableClickTrough(widget, true)
  seexports.sGui:disableLinkCursor(widget, true)
  local label = seexports.sGui:createGuiElement("label", 6, 0, sx - 12, 24, widget)
  seexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, getElementData(localPlayer, "visibleName"):gsub("_", " "))
  seexports.sGui:setLabelAlignment(label, "left", "center")
  local inside = seexports.sGui:createGuiElement("rectangle", 2, 24, sx - 4, sy - 24 - 2, widget)
  seexports.sGui:setGuiBackground(inside, "solid", colorScheme.window)
  local btn = seexports.sGui:createGuiElement("button", pad, sy - 24 - 2 - (30 + pad), sx - pad * 2 - 4, 30, inside)
  seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("sign-out-alt", 30))
  seexports.sGui:setButtonText(btn, " Kijelentkezés")
  seexports.sGui:setClickEvent(btn, "closeMdcWindow")
  setButtonScheme(btn)
  if 0 < #lastPlates then
    local sx, sy = 200, 24 + pad + (30 + pad) * #lastPlates
    local x, y = baseX - sx - pad, pad + 24 + pad + (30 + pad) + pad
    widget = seexports.sGui:createGuiElement("rectangle", x, y, sx, sy, mdcApp)
    seexports.sGui:setGuiBackground(widget, "solid", colorScheme.base)
    seexports.sGui:setGuiHover(widget, "none", false, false, true)
    seexports.sGui:setGuiHoverable(widget, true)
    seexports.sGui:disableClickTrough(widget, true)
    seexports.sGui:disableLinkCursor(widget, true)
    local label = seexports.sGui:createGuiElement("label", 6, 0, 0, 24, widget)
    seexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    seexports.sGui:setLabelText(label, "Lekérdezett rendszámok")
    seexports.sGui:setLabelAlignment(label, "left", "center")
    local inside = seexports.sGui:createGuiElement("rectangle", 2, 24, sx - 4, sy - 24 - 2, widget)
    seexports.sGui:setGuiBackground(inside, "solid", colorScheme.window)
    for i = 1, #lastPlates do
      local btn = seexports.sGui:createGuiElement("button", pad, sy - 24 - 2 - (30 + pad) * i, sx - pad * 2 - 4 - (lastPlates[i][3] and 30 + pad or 0), 30, inside)
      seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
      seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("search", 30))
      seexports.sGui:setButtonText(btn, " " .. lastPlates[i][2])
      seexports.sGui:setClickEvent(btn, "queryMDCLastPlate")
      setButtonScheme(btn)
      if lastPlates[i][3] then
        local icon = seexports.sGui:createGuiElement("image", sx - pad - 2 - 30, sy - 24 - 2 - (30 + pad) * i, 30, 30, inside)
        seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("exclamation-triangle", 30, "solid"))
        seexports.sGui:setImageColor(icon, colorScheme[lastPlates[i][3]])
      end
      lastPlates[i][4] = btn
    end
  end
  if seexports.sGroups:getPlayerPermission("squad") and mdcVeh then
    local sx, sy = 200, 24 + pad + (30 + pad) * 4
    local x, y = baseX - sx - pad, baseY - sy - 32 - pad
    widget = seexports.sGui:createGuiElement("rectangle", x, y, sx, sy, mdcApp)
    seexports.sGui:setGuiBackground(widget, "solid", colorScheme.base)
    seexports.sGui:setGuiHover(widget, "none", false, false, true)
    seexports.sGui:setGuiHoverable(widget, true)
    seexports.sGui:disableClickTrough(widget, true)
    seexports.sGui:disableLinkCursor(widget, true)
    local label = seexports.sGui:createGuiElement("label", 6, 0, 0, 24, widget)
    seexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    seexports.sGui:setLabelText(label, "Egység: " .. mdcSquadName)
    seexports.sGui:setLabelAlignment(label, "left", "center")
    local inside = seexports.sGui:createGuiElement("rectangle", 2, 24, sx - 4, sy - 24 - 2, widget)
    seexports.sGui:setGuiBackground(inside, "solid", colorScheme.window)
    local btn = seexports.sGui:createGuiElement("button", pad, pad, sx - 4 - pad * 2, 30, inside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonText(btn, "Egységcsere")
    seexports.sGui:setClickEvent(btn, "changeMDCSquad")
    setButtonScheme(btn)
    local btn = seexports.sGui:createGuiElement("button", pad, pad + (30 + pad), sx - 4 - pad * 2, 30, inside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonText(btn, "Szolgálaton kívül")
    if not squads[mdcVeh] then
      seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("check", 30))
      setDisabledButtonScheme(btn)
      seexports.sGui:setButtonTextColor(btn, "#000000")
      seexports.sGui:setGuiBackgroundBorder(btn, 1, "#000000")
    else
      seexports.sGui:setClickEvent(btn, "mdcSquadOff")
      setButtonScheme(btn)
    end
    local btn = seexports.sGui:createGuiElement("button", pad, pad + (30 + pad) * 2, sx - 4 - pad * 2, 30, inside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonText(btn, "Szolgálatban")
    if squads[mdcVeh] and not squads[mdcVeh][4] then
      seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("check", 30))
      setDisabledButtonScheme(btn)
      seexports.sGui:setButtonTextColor(btn, "#000000")
      seexports.sGui:setGuiBackgroundBorder(btn, 1, "#000000")
    else
      seexports.sGui:setClickEvent(btn, "mdcSquadOn")
      setButtonScheme(btn)
    end
    local btn = seexports.sGui:createGuiElement("button", pad, pad + (30 + pad) * 3, sx - 4 - pad * 2, 30, inside)
    seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    seexports.sGui:setButtonText(btn, "Erősítés")
    if squads[mdcVeh] and squads[mdcVeh][4] then
      seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("check", 30))
      setDisabledButtonScheme(btn)
      seexports.sGui:setButtonTextColor(btn, "#000000")
      seexports.sGui:setGuiBackgroundBorder(btn, 1, "#000000")
    else
      seexports.sGui:setClickEvent(btn, "mdcSquadBackup")
      setButtonScheme(btn)
    end
  end
  orderMDCGui()
end
function setInputScheme(input)
  seexports.sGui:setInputColor(input, "#454545", "#ffffff", false, "#353535", "#000000")
end
function setDisabledButtonScheme(btn)
  seexports.sGui:setGuiHoverable(btn, false)
  seexports.sGui:setGuiBackground(btn, "solid", colorScheme.btn2)
  seexports.sGui:setButtonTextColor(btn, "#454545")
  seexports.sGui:setGuiBackgroundBorder(btn, 1, "#454545")
end
function setButtonScheme(btn)
  seexports.sGui:setGuiHoverable(btn, true)
  seexports.sGui:setGuiBackground(btn, "gradient", {
    colorScheme.btn1,
    colorScheme.btn2
  })
  seexports.sGui:setGuiHover(btn, "gradient", {
    colorScheme.btn2,
    colorScheme.btn1
  }, false, true)
  seexports.sGui:setButtonTextColor(btn, "#000000")
  seexports.sGui:setGuiBackgroundBorder(btn, 1, "#000000")
end
addEvent("closeMDCPrompt", false)
addEventHandler("closeMDCPrompt", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if mdcPrompt then
    seexports.sGui:deleteGuiElement(mdcPrompt)
  end
  mdcPrompt = false
  mdcPromptInput = false
end)
function createMDCErrorPrompt(title, sx, sy, text)
  playSound("files/error.mp3")
  mdcPromptInput = false
  if mdcPrompt then
    seexports.sGui:deleteGuiElement(mdcPrompt)
  end
  mdcPrompt = seexports.sGui:createGuiElement("rectangle", baseX / 2 - sx / 2, baseY / 2 - sy / 2, sx, sy, mdcFront)
  seexports.sGui:setGuiBackground(mdcPrompt, "solid", colorScheme.base)
  seexports.sGui:setGuiHover(mdcPrompt, "none", false, false, true)
  seexports.sGui:setGuiHoverable(mdcPrompt, true)
  seexports.sGui:disableClickTrough(mdcPrompt, true)
  seexports.sGui:disableLinkCursor(mdcPrompt, true)
  local label = seexports.sGui:createGuiElement("label", 6, 0, 0, 24, mdcPrompt)
  seexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, title)
  seexports.sGui:setLabelAlignment(label, "left", "center")
  local icon = seexports.sGui:createGuiElement("image", sx - 24, 0, 24, 24, mdcPrompt)
  seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("times", 24, "solid"))
  seexports.sGui:setImageColor(icon, "#ffffff")
  seexports.sGui:setGuiHoverable(icon, true)
  seexports.sGui:setGuiHover(icon, "solid", colorScheme.red)
  seexports.sGui:setClickEvent(icon, "closeMDCPrompt")
  local inside = seexports.sGui:createGuiElement("rectangle", 2, 24, sx - 4, sy - 24 - 2, mdcPrompt)
  seexports.sGui:setGuiBackground(inside, "solid", colorScheme.window)
  local icon = seexports.sGui:createGuiElement("image", pad, (sy - 24 - 2 - pad - 24 - pad) / 2 - 24, 48, 48, inside)
  seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("exclamation-circle", 48, "solid"))
  seexports.sGui:setImageColor(icon, colorScheme.red)
  local label = seexports.sGui:createGuiElement("label", pad + 48 + pad, 0, sx - 4 - pad - 48 - pad, sy - 24 - 2 - pad - 24 - pad, inside)
  seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, text)
  seexports.sGui:setLabelColor(label, "#000000")
  seexports.sGui:setLabelAlignment(label, "left", "center")
  seexports.sGui:setLabelWordBreak(label, true)
  local btn = seexports.sGui:createGuiElement("button", sx / 2 - 40, sy - 24 - 2 - pad, 80, 24, mdcPrompt)
  seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  seexports.sGui:setButtonText(btn, "OK")
  seexports.sGui:setClickEvent(btn, "closeMDCPrompt")
  setButtonScheme(btn)
  orderMDCGui()
  return inside, sx - 4, sy - 24 - 2
end
function createMDCInfoPrompt(title, sx, sy, text)
  playSound("files/noti.mp3")
  mdcPromptInput = false
  if mdcPrompt then
    seexports.sGui:deleteGuiElement(mdcPrompt)
  end
  mdcPrompt = seexports.sGui:createGuiElement("rectangle", baseX / 2 - sx / 2, baseY / 2 - sy / 2, sx, sy, mdcFront)
  seexports.sGui:setGuiBackground(mdcPrompt, "solid", colorScheme.base)
  seexports.sGui:setGuiHover(mdcPrompt, "none", false, false, true)
  seexports.sGui:setGuiHoverable(mdcPrompt, true)
  seexports.sGui:disableClickTrough(mdcPrompt, true)
  seexports.sGui:disableLinkCursor(mdcPrompt, true)
  local label = seexports.sGui:createGuiElement("label", 6, 0, 0, 24, mdcPrompt)
  seexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, title)
  seexports.sGui:setLabelAlignment(label, "left", "center")
  local icon = seexports.sGui:createGuiElement("image", sx - 24, 0, 24, 24, mdcPrompt)
  seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("times", 24, "solid"))
  seexports.sGui:setImageColor(icon, "#ffffff")
  seexports.sGui:setGuiHoverable(icon, true)
  seexports.sGui:setGuiHover(icon, "solid", colorScheme.red)
  seexports.sGui:setClickEvent(icon, "closeMDCPrompt")
  local inside = seexports.sGui:createGuiElement("rectangle", 2, 24, sx - 4, sy - 24 - 2, mdcPrompt)
  seexports.sGui:setGuiBackground(inside, "solid", colorScheme.window)
  local icon = seexports.sGui:createGuiElement("image", pad, (sy - 24 - 2 - pad - 24 - pad) / 2 - 24, 48, 48, inside)
  seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("info-circle", 48, "solid"))
  seexports.sGui:setImageColor(icon, colorScheme.blue)
  local label = seexports.sGui:createGuiElement("label", pad + 48 + pad, 0, sx - 4 - pad - 48 - pad, sy - 24 - 2 - pad - 24 - pad, inside)
  seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, text)
  seexports.sGui:setLabelColor(label, "#000000")
  seexports.sGui:setLabelAlignment(label, "left", "center")
  seexports.sGui:setLabelWordBreak(label, true)
  local btn = seexports.sGui:createGuiElement("button", sx / 2 - 40, sy - 24 - 2 - pad, 80, 24, mdcPrompt)
  seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  seexports.sGui:setButtonText(btn, "OK")
  seexports.sGui:setClickEvent(btn, "closeMDCPrompt")
  setButtonScheme(btn)
  orderMDCGui()
  return inside, sx - 4, sy - 24 - 2
end
function createMDCInputPrompt(title, sx, sy, placeholder, event)
  playSound("files/prompt.mp3")
  if mdcPrompt then
    seexports.sGui:deleteGuiElement(mdcPrompt)
  end
  mdcPrompt = seexports.sGui:createGuiElement("rectangle", baseX / 2 - sx / 2, baseY / 2 - sy / 2, sx, sy, mdcFront)
  seexports.sGui:setGuiBackground(mdcPrompt, "solid", colorScheme.base)
  seexports.sGui:setGuiHover(mdcPrompt, "none", false, false, true)
  seexports.sGui:setGuiHoverable(mdcPrompt, true)
  seexports.sGui:disableClickTrough(mdcPrompt, true)
  seexports.sGui:disableLinkCursor(mdcPrompt, true)
  local label = seexports.sGui:createGuiElement("label", 6, 0, 0, 24, mdcPrompt)
  seexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, title)
  seexports.sGui:setLabelAlignment(label, "left", "center")
  local icon = seexports.sGui:createGuiElement("image", sx - 24, 0, 24, 24, mdcPrompt)
  seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("times", 24, "solid"))
  seexports.sGui:setImageColor(icon, "#ffffff")
  seexports.sGui:setGuiHoverable(icon, true)
  seexports.sGui:setGuiHover(icon, "solid", colorScheme.red)
  seexports.sGui:setClickEvent(icon, "closeMDCPrompt")
  local inside = seexports.sGui:createGuiElement("rectangle", 2, 24, sx - 4, sy - 24 - 2, mdcPrompt)
  seexports.sGui:setGuiBackground(inside, "solid", colorScheme.window)
  mdcPromptInput = seexports.sGui:createGuiElement("input", pad, (sy - 24 - 2 - pad - 24 - pad) / 2 - 15, sx - pad * 2 - 4, 30, inside)
  seexports.sGui:setInputPlaceholder(mdcPromptInput, placeholder)
  seexports.sGui:setInputMaxLength(mdcPromptInput, 120)
  setInputScheme(mdcPromptInput)
  local btn = seexports.sGui:createGuiElement("button", sx / 2 - 40, sy - 24 - 2 - pad, 80, 24, mdcPrompt)
  seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  seexports.sGui:setButtonText(btn, "OK")
  seexports.sGui:setClickEvent(btn, event)
  setButtonScheme(btn)
  orderMDCGui()
  return inside, sx - 4, sy - 24 - 2
end
function createMDCYesNoPrompt(title, sx, sy, text, event)
  playSound("files/prompt.mp3")
  if mdcPrompt then
    seexports.sGui:deleteGuiElement(mdcPrompt)
  end
  mdcPrompt = seexports.sGui:createGuiElement("rectangle", baseX / 2 - sx / 2, baseY / 2 - sy / 2, sx, sy, mdcFront)
  seexports.sGui:setGuiBackground(mdcPrompt, "solid", colorScheme.base)
  seexports.sGui:setGuiHover(mdcPrompt, "none", false, false, true)
  seexports.sGui:setGuiHoverable(mdcPrompt, true)
  seexports.sGui:disableClickTrough(mdcPrompt, true)
  seexports.sGui:disableLinkCursor(mdcPrompt, true)
  local label = seexports.sGui:createGuiElement("label", 6, 0, 0, 24, mdcPrompt)
  seexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, title)
  seexports.sGui:setLabelAlignment(label, "left", "center")
  local icon = seexports.sGui:createGuiElement("image", sx - 24, 0, 24, 24, mdcPrompt)
  seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("times", 24, "solid"))
  seexports.sGui:setImageColor(icon, "#ffffff")
  seexports.sGui:setGuiHoverable(icon, true)
  seexports.sGui:setGuiHover(icon, "solid", colorScheme.red)
  seexports.sGui:setClickEvent(icon, "closeMDCPrompt")
  local inside = seexports.sGui:createGuiElement("rectangle", 2, 24, sx - 4, sy - 24 - 2, mdcPrompt)
  seexports.sGui:setGuiBackground(inside, "solid", colorScheme.window)
  local icon = seexports.sGui:createGuiElement("image", pad, (sy - 24 - 2 - pad - 24 - pad) / 2 - 24, 48, 48, inside)
  seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("question-circle", 48, "solid"))
  seexports.sGui:setImageColor(icon, colorScheme.blue)
  local label = seexports.sGui:createGuiElement("label", pad + 48 + pad, 0, sx - 4 - pad - 48 - pad, sy - 24 - 2 - pad - 24 - pad, inside)
  seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, text)
  seexports.sGui:setLabelColor(label, "#000000")
  seexports.sGui:setLabelAlignment(label, "left", "center")
  seexports.sGui:setLabelWordBreak(label, true)
  local btn = seexports.sGui:createGuiElement("button", sx / 2 - 80 - pad / 2, sy - 24 - 2 - pad, 80, 24, mdcPrompt)
  seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  seexports.sGui:setButtonText(btn, "Igen")
  seexports.sGui:setClickEvent(btn, event)
  setButtonScheme(btn)
  local btn = seexports.sGui:createGuiElement("button", sx / 2 + pad / 2, sy - 24 - 2 - pad, 80, 24, mdcPrompt)
  seexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  seexports.sGui:setButtonText(btn, "Nem")
  seexports.sGui:setClickEvent(btn, "closeMDCPrompt")
  setButtonScheme(btn)
  orderMDCGui()
  return inside, sx - 4, sy - 24 - 2
end
addEvent("showMDCPrompt", true)
addEventHandler("showMDCPrompt", getRootElement(), function(err, text)
  if err then
    createMDCErrorPrompt("Hiba", 225, 125, text)
  else
    createMDCInfoPrompt("Információ", 225, 125, text)
  end
end)
function createMDCApp(title, icon)
  if mdcPrompt then
    seexports.sGui:deleteGuiElement(mdcPrompt)
  end
  mdcPrompt = false
  mdcPromptInput = false
  if mdcApp then
    seexports.sGui:deleteGuiElement(mdcApp)
  end
  mdcApp = seexports.sGui:createGuiElement("rectangle", 0, 0, baseX, baseY - 32, mdcInside)
  seexports.sGui:setGuiBackground(mdcApp, "solid", colorScheme.base)
  local label = seexports.sGui:createGuiElement("label", 6, 0, 0, 24, mdcApp)
  seexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  seexports.sGui:setLabelText(label, title)
  seexports.sGui:setLabelAlignment(label, "left", "center")
  local rect = seexports.sGui:createGuiElement("rectangle", 38, baseY - 32, 36, 32, mdcApp)
  seexports.sGui:setGuiBackground(rect, "solid", colorScheme.base)
  local pic = seexports.sGui:createGuiElement("image", 4, 2, 28, 28, rect)
  seexports.sGui:setImageDDS(pic, ":sMdc/files/" .. icon .. ".dds")
  local icon = seexports.sGui:createGuiElement("image", baseX - 24, 0, 24, 24, mdcApp)
  seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("times", 24, "solid"))
  seexports.sGui:setImageColor(icon, "#ffffff")
  seexports.sGui:setGuiHoverable(icon, true)
  seexports.sGui:setGuiHover(icon, "solid", colorScheme.red)
  seexports.sGui:setClickEvent(icon, "closeMDCApplication")
  insideX, insideY = baseX - 4, baseY - 24 - 32 - 2
  mdcAppInside = seexports.sGui:createGuiElement("rectangle", 2, 24, insideX, insideY, mdcApp)
  seexports.sGui:setGuiBackground(mdcAppInside, "solid", colorScheme.window)
end
local mdcX, mdcY
if fileExists("!mdc_pos.sight") then
  local file = fileOpen("!mdc_pos.sight")
  local data = fileRead(file, fileGetSize(file))
  fileClose(file)
  local pos = split(data, ",")
  mdcX = tonumber(pos[1])
  mdcY = tonumber(pos[2])
  if mdcX and mdcY then
    mdcX = math.max(0, math.min(screenX - 1164, mdcX))
    mdcY = math.max(0, math.min(screenY - 810, mdcY))
  else
    mdcX, mdcY = screenX / 2 - 582, screenY / 2 - 405
  end
else
  mdcX, mdcY = screenX / 2 - 582, screenY / 2 - 405
end
local movingMDC = false
function mdcCursorMove(rx, ry, cx, cy)
  if isCursorShowing() and mdcWindow then
    mdcX = math.max(0, math.min(screenX - 1164, movingMDC[1] + cx - movingMDC[3]))
    mdcY = math.max(0, math.min(screenY - 810, movingMDC[2] + cy - movingMDC[4]))
    movingMDC[5] = mdcX
    movingMDC[6] = mdcY
    seexports.sGui:setGuiPosition(mdcWindow, mdcX, mdcY)
  else
    local x, y = tonumber(movingMDC[5]), tonumber(movingMDC[6])
    movingMDC = false
    if fileExists("!mdc_pos.sight") then
      fileDelete("!mdc_pos.sight")
    end
    if x and y then
      local file = fileCreate("!mdc_pos.sight")
      fileWrite(file, x .. "," .. y)
      fileClose(file)
    end
    sightlangCondHandl0(false)
  end
end
function mdcClick(button, state, cx, cy)
  if button ~= "left" then
    return
  end
  if state == "down" then
    if cx >= mdcX and cx <= mdcX + 1164 and cy >= mdcY and cy <= mdcY + 810 and (not (cx >= mdcX + 81 and cy >= mdcY + 69 and cx <= mdcX + 81 + baseX) or not (cy <= mdcY + 69 + baseY)) then
      movingMDC = {
        mdcX,
        mdcY,
        cx,
        cy
      }
      sightlangCondHandl0(true)
    end
  elseif state == "up" then
    if movingMDC then
      local x, y = tonumber(movingMDC[5]), tonumber(movingMDC[6])
      if fileExists("!mdc_pos.sight") then
        fileDelete("!mdc_pos.sight")
      end
      if x and y then
        local file = fileCreate("!mdc_pos.sight")
        fileWrite(file, x .. "," .. y)
        fileClose(file)
      end
    end
    movingMDC = false
    sightlangCondHandl0(false)
  end
end
function createMDCWindow()
  if mdcWindow then
    closeMDCApp()
    seexports.sGui:deleteGuiElement(mdcWindow)
  else
    addEventHandler("onClientRender", getRootElement(), mdcRender)
    addEventHandler("onClientClick", getRootElement(), mdcClick)
    addEventHandler("onClientKey", getRootElement(), mdcKey)
  end
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local padding = 4
  local panelWidth = 1164
  local panelHeight = 810
  mdcWindow = seexports.sGui:createGuiElement("image", mdcX, mdcY, panelWidth, panelHeight)
  seexports.sGui:setImageDDS(mdcWindow, ":sMdc/files/tablet.dds")
  seexports.sGui:setDisableClickSound(mdcWindow, false, true)
  mdcInside = seexports.sGui:createGuiElement("image", 81, 69, baseX, baseY, mdcWindow)
  seexports.sGui:setImageDDS(mdcInside, ":sMdc/files/wp.dds")
  local rect = seexports.sGui:createGuiElement("rectangle", 81, 69 + baseY - 32, baseX, 32, mdcWindow)
  seexports.sGui:setGuiBackground(rect, "solid", colorScheme.taskbar)
  dateLabel = seexports.sGui:createGuiElement("label", baseX - 100, 0, 100, 32, rect)
  seexports.sGui:setLabelFont(dateLabel, "9/Ubuntu-R.ttf")
  seexports.sGui:setLabelAlignment(dateLabel, "center", "center")
  currentDate = false
  mdcFront = seexports.sGui:createGuiElement("null", 81, 69, baseX, baseY, mdcWindow)
  mdcScan = seexports.sGui:createGuiElement("image", 81, 69, baseX, baseY, mdcWindow)
  seexports.sGui:setImageDDS(mdcScan, ":sMdc/files/scan.dds")
  seexports.sGui:setImageColor(mdcScan, {
    255,
    255,
    255,
    150
  })
end
function closeMDC(sound)
  if mdcWindow then
    closeMDCApp()
    mdcVeh = false
    seexports.sGui:deleteGuiElement(mdcWindow)
    mdcWindow = false
    removeEventHandler("onClientRender", getRootElement(), mdcRender)
    removeEventHandler("onClientClick", getRootElement(), mdcClick)
    removeEventHandler("onClientKey", getRootElement(), mdcKey)
    if sound then
      playSound("files/quit.mp3")
    end
  end
end
addCommandHandler("mdc", function()
  if mdcOpening then
    return
  end
  if not mdcWindow then
    if isPedInVehicle(localPlayer) and seexports.sGroups:getPlayerPermission("mdc") then
      mdcOpening = true
      triggerServerEvent("tryToOpenMDCInCar", localPlayer)
    end
  else
    closeMDC(true)
  end
end)
addEvent("closeMdcWindow", false)
addEventHandler("closeMdcWindow", getRootElement(), function()
  if mdcWindow then
    closeMDC(true)
  end
end)
function launchMDC(sound)
  if not mdcWindow then
    seexports.sTraffipax:stopHandheldTraffi()
    local veh = getPedOccupiedVehicle(localPlayer)
    if not veh then
      seexports.sGui:showInfobox("e", "Az MDC csak járműben működik!")
      return
    end
    if getPedOccupiedVehicleSeat(localPlayer) > 1 then
      seexports.sGui:showInfobox("e", "Az MDC csak az első ülésekről működik!")
      return
    end
    mdcVeh = veh
    createMDCWindow()
    createDesktop()
    if sound then
      playSound("files/logon.mp3")
    end
  end
end
addEvent("mdcLaunchFailed", true)
addEventHandler("mdcLaunchFailed", getRootElement(), function()
  mdcOpening = false
end)
addEvent("launchMDC", true)
addEventHandler("launchMDC", getRootElement(), function(veh, squadName)
  mdcOpening = false
  if veh and veh == getPedOccupiedVehicle(localPlayer) then
    mdcSquadName = squadName or ""
    if not mdcWindow then
      launchMDC(true)
    elseif not activeMdcApp and mdcWindow then
      createDesktop()
    end
  elseif not veh then
    mdcSquadName = ""
    if not mdcWindow then
      mdcVeh = false
      createMDCWindow()
      createDesktop()
      playSound("files/logon.mp3")
    elseif not activeMdcApp and mdcWindow then
      createDesktop()
    end
  end
end)
addEvent("openMDCPlayerApp", false)
addEventHandler("openMDCPlayerApp", getRootElement(), function()
  createMDCApp("Személy lekérdezés", "player")
  createMDCPlayerApp()
end)
addEvent("openMDCWarrantApp", false)
addEventHandler("openMDCWarrantApp", getRootElement(), function()
  createMDCApp("Körözések", "wanted")
  createMDCWarrantApp()
  triggerLatentServerEvent("getWarrantsOfPlayers", localPlayer)
end)
addEvent("openMDCPlateWarrantApp", false)
addEventHandler("openMDCPlateWarrantApp", getRootElement(), function()
  createMDCApp("Rendszám körözések", "vwanted")
  createMDCPlateWarrantApp()
  triggerLatentServerEvent("getWarrantsOfPlates", localPlayer)
end)
addEvent("openMDCVehicleApp", false)
addEventHandler("openMDCVehicleApp", getRootElement(), function()
  createMDCApp("Jármű lekérdezés", "vehicle")
  createMDCVehicleApp()
end)
addEvent("openMDCInteriorApp", false)
addEventHandler("openMDCInteriorApp", getRootElement(), function()
  createMDCApp("Ingatlan lekérdezés", "inti")
  createMDCInteriorApp()
end)
addEvent("openMDCTraffipaxFinal", false)
addEventHandler("openMDCTraffipaxFinal", getRootElement(), function()
  local val = tonumber(seexports.sGui:getInputValue(mdcPromptInput))
  if val and 30 <= val and val <= 130 then
    if mdcPrompt then
      seexports.sGui:deleteGuiElement(mdcPrompt)
    end
    mdcPrompt = false
    mdcPromptInput = false
    closeMDC()
    seexports.sTraffipax:startHandheldTraffi(val)
  end
end)
addEvent("openMDCTraffipax", false)
addEventHandler("openMDCTraffipax", getRootElement(), function()
  createMDCInputPrompt("Traffipax", 400, 125, "Sebességhatár (km/h, 30-130)", "openMDCTraffipaxFinal")
end)
addCommandHandler("togegysegszam", function()
  local state = seexports.sNames:getSquadsVisible()
  state = not state
  outputChatBox("[color=sightblue][SightMTA - Egységszám]: " .. (state and "[color=sightgreen]Bekapcsoltad" or "[color=sightred]Kikapcsoltad") .. "#FFFFFF az egységszámokat.", 255, 255, 255, true)
  seexports.sNames:setSquadsVisible(state)
  seexports.sDashboard:saveValue("squadState", state)
end)
local markerPoses = {
  {
    1558.9169921875,
    -1692.009765625,
    1994.8203125,
    1,
    1
  },
  {
    1543.880859375,
    -1692.1396484375,
    1994.8266601562,
    1,
    1
  },
  {
    230.796875,
    71.1015625,
    1005.0390625,
    6,
    5555
  },
  {
    -1553.412109375,
    412.7412109375,
    9007.05859375,
    1,
    1
  },
  {
    -1547.2177734375,
    412.9853515625,
    9007.05859375,
    1,
    1
  },
  {
    1624.9521484375, -1500.9921875, 7498.7670898438,
    1,
    1
  },
  {
    256.5234375,
    69.576171875,
    1003.640625,
    6,
    1
  },
  {
    1493.6044921875,
    -1475.775390625,
    8030.3671875,
    1,
    1
  },
  {
    1509.3330078125,
    -1463.6865234375,
    8032.9609375,
    1,
    1
  },
  {
    1558.9169921875,
    -1692.009765625,
    1994.8203125,
    1,
    2
  },
  {
    1543.880859375,
    -1692.1396484375,
    1994.8266601562,
    1,
    2
  }
}
addEvent("changeEnteredCustomMarker", false)
addEventHandler("changeEnteredCustomMarker", getRootElement(), function(theType, id)
  if theType == "mdc" then
    if lastExit == id then
      lastExit = false
      return
    end
    lastExit = false
    triggerServerEvent("tryToOpenMDCOnFoot", localPlayer)
  elseif mdcWindow then
    closeMDC(true)
  end
end)
local markers = {}
function createMDCMarkers()
  for i = 1, #markerPoses do
    markers[i] = seexports.sMarkers:createCustomMarker(markerPoses[i][1], markerPoses[i][2], markerPoses[i][3], markerPoses[i][4], markerPoses[i][5], "sightpurple", "mdc")
    seexports.sMarkers:setCustomMarkerInterior(markers[i], "mdc", i, 1)
  end
end
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  for k = 1, #markers do
    if markers[k] then
      seexports.sMarkers:deleteCustomMarker(markers[k])
    end
    markers[k] = nil
  end
end)
function refreshInPolice()
  local tmp = seexports.sGroups:isPlayerInLawEnforcement()
  if inPolice ~= tmp then
    inPolice = tmp
  end
end
addEvent("gotPlayerGroupMembership", true)
addEventHandler("gotPlayerGroupMembership", getRootElement(), refreshInPolice)
function deleteAlertBlip(blip)
  if isElement(blip) then
    destroyElement(blip)
  end
  blip = nil
end
addEvent("mdcVehicleWarrantAlert", true)
addEventHandler("mdcVehicleWarrantAlert", getRootElement(), function(colors, model, plate, warrant, warrantPlate)
  if inPolice and seexports.sGroups:getTogGroupMsg() and isElement(source) then
    local sound = false
    local x, y, z = getElementPosition(source)
    local veh = (source)
    local customModel = getElementData(veh, "vehicle.customModel")
    local realName = seexports.sVehiclenames:getCustomVehicleName(customModel) or seexports.sVehiclenames:getCustomVehicleName(model)
    if warrant then
      outputChatBox("[color=sightblue][SightMTA - MDC]: #ffffffA rendszer egy járművet ([color=sightblue]" .. seexports.sVehiclenames:getCustomVehicleName(model) .. " (" .. plate .. ")#ffffff) érzékelt, melynek tulajdonosa körözött.", 255, 255, 255, true)
      outputChatBox("[color=sightblue][SightMTA - MDC]: #ffffffZóna: [color=sightblue]" .. seexports.sRadar:getZoneName(x, y, z), 255, 255, 255, true)
      outputChatBox("[color=sightblue][SightMTA - MDC]: #ffffffSzíne: ".. colors, 255, 255, 255, true)
      --outputChatBox("[color=sightblue][SightMTA - MDC]: #ffffffEgy körözött [color=sightred-second]tulajdonosú#ffffff jármű haladt át a [color=sightblue]" .. seexports.sRadar:getZoneName(x, y, z) .. "#ffffff előtt lehelyezett traffipaxnál", 255, 255, 255, true)
      --outputChatBox("[color=sightblue][SightMTA - MDC]: #ffffffTípus: [color=sightblue]" .. realName .. "#ffffff", 255, 255, 255, true)
      for i = 1, #warrant do
        outputChatBox("[color=sightblue][SightMTA - MDC]: #ffffffKörözési indok: [color=sightred-second]" .. warrant[i], 255, 255, 255, true)
        if not sound and not utf8.find(warrant[i], "megfigyel") then
          sound = true
        end
      end
    end
    if warrantPlate then
      outputChatBox("[color=sightblue][SightMTA - MDC]: #ffffffA rendszer egy járművet ([color=sightblue]" .. seexports.sVehiclenames:getCustomVehicleName(model) .. " (" .. plate .. ")#ffffff) érzékelt, melynek rendszáma körözött.", 255, 255, 255, true)
      outputChatBox("[color=sightblue][SightMTA - MDC]: #ffffffZóna: [color=sightblue]" .. seexports.sRadar:getZoneName(x, y, z), 255, 255, 255, true)
      outputChatBox("[color=sightblue][SightMTA - MDC]: #ffffffSzíne: ".. colors, 255, 255, 255, true)
      --outputChatBox("[color=sightblue][SightMTA - MDC]: #ffffffEgy körözött [color=sightred-second]jármű#ffffff haladt át a [color=sightblue]" .. seexports.sRadar:getZoneName(x, y, z) .. "#ffffff előtt lehelyezett traffipaxnál", 255, 255, 255, true)
      --outputChatBox("[color=sightblue][SightMTA - MDC]: #ffffffTípus: [color=sightblue]" .. realName .. "#ffffff", 255, 255, 255, true)
      --outputChatBox("[color=sightblue][SightMTA - MDC]: #ffffffRendszám: [color=sightblue]" .. plate, 255, 255, 255, true)
      for i = 1, #warrantPlate do
        outputChatBox("[color=sightblue][SightMTA - MDC]: #ffffffIndok: [color=sightred-second]" .. warrantPlate[i], 255, 255, 255, true)
        if not sound and not utf8.find(warrantPlate[i], "megfigyel") then
          sound = true
        end
      end
    end
    if sound then
      playSound(":sGroups/files/backup.mp3")
    end
    local r, g, b = unpack(seexports.sGui:getColorCode("sightred"))
    local blip = createBlip(x, y, z, 25, 2, r, g, b)
    attachElements(blip, source)
    setElementData(blip, "tooltipText", warrantPlate and "Körözött jármű: " .. plate or "Körözött tulajdonosú jármű (" .. plate .. ")")
    setTimer(deleteAlertBlip, 10000, 1, blip)
  end
end)
