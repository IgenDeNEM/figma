local sightexports = {
  sItems = false,
  sMobile = false,
  sRadar = false,
  sGui = false,
  sChat = false,
  sModloader = false,
  sPattach = false,
  sCore = false
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
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sItems")
    if res0 and getResourceState(res0) == "running" then
      checkTablet()
      sightlangWaiterState0 = true
    end
  end
end
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end
local blipColor = false
local blipOffColor = false
local nameOnIcon = false
local nameOffIcon = false
local playerIcon = false
local othersIcon = false
local carIcon = false
local selfCarIcon = false
local reportMapIcon = false
local callMapIcon = false
local callOffMapIcon = false
local callInMapIcon = false
local callInOffMapIcon = false
local nameFont = false
local nameFontScale = false
local nameFontH = false
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    blipColor = sightexports.sGui:getColorCode("sightblue")
    blipOffColor = sightexports.sGui:getColorCode("sightorange")
    nameOnIcon = sightexports.sGui:getFaIconFilename("id-card-alt", 32, "solid", false, false, false, tabletColors.blackToColor)
    nameOffIcon = sightexports.sGui:getFaIconFilename("id-card-alt", 32, "light", false, false, false, tabletColors.blackToColor)
    playerIcon = sightexports.sGui:getFaIconFilename("location-arrow", 24)
    othersIcon = sightexports.sGui:getFaIconFilename("user", 32, "solid", false, tabletColors.blackToColor, tabletColors.blueToColor)
    carIcon = sightexports.sGui:getFaIconFilename("car", 32, "solid", false, tabletColors.blackToColor, tabletColors.blueToColor)
    selfCarIcon = sightexports.sGui:getFaIconFilename("car", 32, "solid", false, tabletColors.blackToColor, tabletColors.greenToColor)
    reportMapIcon = sightexports.sGui:getFaIconFilename("envelope", 32, "solid", false, tabletColors.blackToColor, tabletColors.blueToColor)
    callMapIcon = sightexports.sGui:getFaIconFilename("phone", 32, "solid", false, tabletColors.blackToColor, tabletColors.blueToColor)
    callOffMapIcon = sightexports.sGui:getFaIconFilename("phone", 32, "regular", false, tabletColors.blackToColor, tabletColors.orangeToColor)
    callInMapIcon = sightexports.sGui:getFaIconFilename("phone-plus", 32, "solid", false, tabletColors.blackToColor, tabletColors.greenToColor)
    callInOffMapIcon = sightexports.sGui:getFaIconFilename("phone-plus", 32, "regular", false, tabletColors.blackToColor, tabletColors.orangeToColor)
    nameFont = sightexports.sGui:getFont("9/Ubuntu-B.ttf")
    nameFontScale = sightexports.sGui:getFontScale("9/Ubuntu-B.ttf")
    nameFontH = sightexports.sGui:getFontHeight("9/Ubuntu-B.ttf")
    faTicks = sightexports.sGui:getFaTicks()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
local sightlangModloaderLoaded = function()
  loadModels()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState5 = false
local function sightlangCondHandl5(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState5 then
    sightlangCondHandlState5 = cond
    if cond then
      addEventHandler("onClientPedsProcessed", getRootElement(), tabletBones, true, prio)
    else
      removeEventHandler("onClientPedsProcessed", getRootElement(), tabletBones)
    end
  end
end
local sightlangCondHandlState4 = false
local function sightlangCondHandl4(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState4 then
    sightlangCondHandlState4 = cond
    if cond then
      addEventHandler("onClientClick", getRootElement(), tabletClick, true, prio)
    else
      removeEventHandler("onClientClick", getRootElement(), tabletClick)
    end
  end
end
local sightlangCondHandlState3 = false
local function sightlangCondHandl3(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState3 then
    sightlangCondHandlState3 = cond
    if cond then
      addEventHandler("onClientKey", getRootElement(), tabletScrollHandler, true, prio)
    else
      removeEventHandler("onClientKey", getRootElement(), tabletScrollHandler)
    end
  end
end
local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState2 then
    sightlangCondHandlState2 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderTabletRadar, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderTabletRadar)
    end
  end
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientCursorMove", getRootElement(), groupcallTabletMove, true, prio)
    else
      removeEventHandler("onClientCursorMove", getRootElement(), groupcallTabletMove)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientCursorMove", getRootElement(), radarDragMove, true, prio)
    else
      removeEventHandler("onClientCursorMove", getRootElement(), radarDragMove)
    end
  end
end
local playerCalls = {}
local playerCallsTime = {}
local playerCallAccepted = {}
local playerReports = {}
local playerReportsTime = {}
local groupCallBlips = {}
local groupReportBlips = {}
for i = 1, #emergencyCallList do
  groupCallBlips[i] = {}
  groupReportBlips[i] = {}
end
local hasTabletForGroup = {}
function checkTablet()
  local items = sightexports.sItems:getLocalPlayerItems(localPlayer)
  for i = 1, #emergencyCallList do
    hasTabletForGroup[i] = false
  end
  for k, v in pairs(items) do
    if v.itemId == 127 then
      for i = 1, #emergencyCallList do
        for j = 1, #emergencyCallList[i][2] do
          if v.data1 == emergencyCallList[i][2][j] then
            hasTabletForGroup[i] = true
            break
          end
        end
      end
    end
  end
end
addEvent("movedItemInInv", true)
addEventHandler("movedItemInInv", localPlayer, checkTablet)
addEvent("gotGroupCallNoti", true)
addEventHandler("gotGroupCallNoti", getRootElement(), function(group, message, id, reason)
  if hasTabletForGroup[group] then
    if message == 1 then
      message = "Új hívás érkezett: [color=sightblue]" .. id
      playSound("files/noti.wav")
    elseif message == 2 then
      message = "Új bejelentés érkezett: [color=sightblue]" .. id
      playSound("files/noti.wav")
    elseif message == 3 then
      message = "Törlődött a következő hívás: [color=sightblue]" .. id
      if reason == "spawn" then
        message = message .. "#ffffff (meghalt a játékos)"
      elseif reason == "quit" then
        message = message .. "#ffffff (kilépett a játékos)"
      elseif reason then
        message = message .. "#ffffff (" .. reason .. " törölte)"
      else
        message = message .. "#ffffff (lemondta a játékos)"
      end
    elseif message == 4 then
      message = reason .. " elfogadta a következő hívást: [color=sightblue]" .. id
    elseif message == 5 then
      message = "Törlődött a következő bejelentés: [color=sightblue]" .. id
      if reason then
        message = message .. "#ffffff (" .. reason .. " törölte)"
      end
    end
    outputChatBox("[color=sightblue][SightMTA - Tablet (" .. emergencyCallList[group][1] .. ")]: #ffffff" .. message, 0, 0, 255, true)
  end
end)
addEvent("gotGroupCallAccepted", true)
addEventHandler("gotGroupCallAccepted", getRootElement(), function(group, accepted)
  playerCallAccepted[group] = accepted
  sightexports.sMobile:groupCallResponse(group)
end)
addEvent("gotGroupCallReport", true)
addEventHandler("gotGroupCallReport", getRootElement(), function(group, reason, time)
  playerReports[group] = reason
  playerReportsTime[group] = time
  sightexports.sMobile:groupReportResponse(group)
end)
addEvent("gotGroupCall", true)
addEventHandler("gotGroupCall", getRootElement(), function(group, reason, time)
  playerCalls[group] = reason
  playerCallsTime[group] = time
  playerCallAccepted[group] = nil
  sightexports.sMobile:groupCallResponse(group)
end)
function getGroupCall(group)
  return playerCalls[group], playerCallsTime[group], playerCallAccepted[group]
end
function getGroupReport(group)
  return playerReports[group], playerReportsTime[group]
end
local menuButtons = {}
local currentTabletScroll = {}
local currentTabletMenu = 1
local tabletMapNameOn = true
local currentRadarX, currentRadarY = 0, 0
local currentRadarZoom = 48
local tabletLoading = false
local tabletRequested = false
local tabletMenuListElements = {}
local tabletDutyList = {}
local tabletCalls = {}
local tabletReports = {}
local acceptedCalls = {}
local incomingCalls = {}
function sortAcceptedCallList(a, b)
  if a.accpeted == b.accepted then
    return a.ts < b.ts
  else
    return a.accepted < b.accepted
  end
end
function sortCallList(a, b)
  return a.ts < b.ts
end
function processCall(id)
  tabletCalls[id].id = id
  tabletCalls[id].name = "((" .. tabletCalls[id].name .. "))"
  tabletCalls[id].numberText = sightexports.sMobile:formatPhoneNumber(tabletCalls[id].number)
  tabletCalls[id].ts = tabletCalls[id].ts
  local time = getRealTime(tabletCalls[id].ts)
  tabletCalls[id].timeString = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
  if tabletCalls[id].locationX then
    tabletCalls[id].locationName = sightexports.sRadar:getZoneName(tabletCalls[id].locationX, tabletCalls[id].locationY, tabletCalls[id].locationZ)
    if not tabletCalls[id].locationOnline then
      tabletCalls[id].locationName = tabletCalls[id].locationName .. " (Nincs jel)"
    end
  else
    tabletCalls[id].locationName = nil
  end
  if tabletCalls[id].accepted then
    local time = getRealTime(tabletCalls[id].accepted)
    tabletCalls[id].acceptedString = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
    table.insert(acceptedCalls, 1, tabletCalls[id])
  else
    table.insert(incomingCalls, 1, tabletCalls[id])
  end
end
function processCallList()
  incomingCalls = {}
  acceptedCalls = {}
  for id in pairs(tabletCalls) do
    processCall(id)
  end
  table.sort(incomingCalls, sortCallList)
  table.sort(acceptedCalls, sortAcceptedCallList)
end
local currentTabletGroup = false
addEvent("gotTabletReportDeleted", true)
addEventHandler("gotTabletReportDeleted", getRootElement(), function(group, id)
  if isElement(groupReportBlips[group][id]) then
    destroyElement(groupReportBlips[group][id])
  end
  groupReportBlips[group][id] = nil
  if group == currentTabletGroup then
    for i = #tabletReports, 1, -1 do
      if tabletReports[i].id == id then
        table.remove(tabletReports, i)
      end
    end
    if currentTabletMenu == 3 then
      processMenuList()
    end
  end
end)
addEvent("gotTabletCallDeleted", true)
addEventHandler("gotTabletCallDeleted", getRootElement(), function(group, id)
  if isElement(groupCallBlips[group][id]) then
    destroyElement(groupCallBlips[group][id])
  end
  groupCallBlips[group][id] = nil
  if group == currentTabletGroup and tabletCalls[id] then
    if tabletCalls[id].accepted then
      for i = #acceptedCalls, 1, -1 do
        if acceptedCalls[i].id == id then
          table.remove(acceptedCalls, i)
        end
      end
    else
      for i = #incomingCalls, 1, -1 do
        if incomingCalls[i].id == id then
          table.remove(incomingCalls, i)
        end
      end
    end
    tabletCalls[id] = nil
    if currentTabletMenu <= 2 then
      processMenuList()
    end
  end
end)
addEvent("gotTabletNewCall", true)
addEventHandler("gotTabletNewCall", getRootElement(), function(group, id, data)
  if group == currentTabletGroup then
    tabletCalls[id] = data
    processCall(id)
    if currentTabletMenu <= 2 then
      processMenuList()
    end
  end
end)
addEvent("gotTabletNewReport", true)
addEventHandler("gotTabletNewReport", getRootElement(), function(group, id, data)
  if group == currentTabletGroup then
    processReport(id, data)
    table.insert(tabletReports, 1, data)
    if currentTabletMenu == 3 then
      processMenuList()
    end
  end
end)
addEvent("gotTabletCallAccepted", true)
addEventHandler("gotTabletCallAccepted", getRootElement(), function(group, id, accepted, prefix)
  if group == currentTabletGroup and tabletCalls[id] then
    if accepted then
      local time = getRealTime(accepted)
      tabletCalls[id].acceptedString = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
    else
      tabletCalls[id].acceptedString = false
    end
    if accepted and not tabletCalls[id].accepted then
      table.insert(acceptedCalls, 1, tabletCalls[id])
      for i = #incomingCalls, 1, -1 do
        if incomingCalls[i].id == id then
          table.remove(incomingCalls, i)
          break
        end
      end
    elseif not accepted and tabletCalls[id].accepted then
      table.insert(incomingCalls, 1, tabletCalls[id])
      for i = #acceptedCalls, 1, -1 do
        if acceptedCalls[i].id == id then
          table.remove(acceptedCalls, i)
          break
        end
      end
    end
    tabletCalls[id].accepted = accepted
    tabletCalls[id].acceptedPrefix = prefix
    if currentTabletMenu <= 2 then
      processMenuList()
    end
  end
end)
function tabletSingleLocationUpdate(id, x, y, z)
  if tabletCalls[id] then
    if x then
      tabletCalls[id].locationX = x
      tabletCalls[id].locationY = y
      tabletCalls[id].locationZ = z
      tabletCalls[id].locationOnline = true
    else
      tabletCalls[id].locationOnline = false
    end
    if tabletCalls[id].locationX then
      tabletCalls[id].locationName = sightexports.sRadar:getZoneName(tabletCalls[id].locationX, tabletCalls[id].locationY, tabletCalls[id].locationZ)
      if not tabletCalls[id].locationOnline then
        tabletCalls[id].locationName = tabletCalls[id].locationName .. " (Nincs jel)"
      end
    else
      tabletCalls[id].locationName = nil
    end
  end
end
addEvent("deletedGroupCallSubscription", true)
addEventHandler("deletedGroupCallSubscription", getRootElement(), function(group, id)
  if isElement(groupCallBlips[group][id]) then
    destroyElement(groupCallBlips[group][id])
  end
  groupCallBlips[group][id] = nil
end)
addEvent("deletedGroupReportSubscription", true)
addEventHandler("deletedGroupReportSubscription", getRootElement(), function(group, id)
  if isElement(groupCallBlips[group][id]) then
    destroyElement(groupCallBlips[group][id])
  end
  groupCallBlips[group][id] = nil
end)
function updateGroupCallBlip(group, id, x, y, z)
  local name = "Hívás: " .. emergencyCallList[group][1] .. " " .. id
  if x then
    setBlipColor(groupCallBlips[group][id], blipColor[1], blipColor[2], blipColor[3], 255)
    setElementPosition(groupCallBlips[group][id], x, y, z + 1)
    setElementData(groupCallBlips[group][id], "tooltipText", name)
  else
    setBlipColor(groupCallBlips[group][id], blipOffColor[1], blipOffColor[2], blipOffColor[3], 255)
    name = name .. " (Nincs jel)"
    setElementData(groupCallBlips[group][id], "tooltipText", name)
  end
end
addEvent("gotTabletSingleLocationUpdate", true)
addEventHandler("gotTabletSingleLocationUpdate", getRootElement(), function(group, id, x, y, z)
  if groupCallBlips[group][id] then
    updateGroupCallBlip(group, id, x, y, z)
  end
  if group == currentTabletGroup then
    tabletSingleLocationUpdate(id, x, y, z)
    if currentTabletMenu <= 2 then
      processMenuList()
    end
  end
end)
addEvent("gotTabletLocationUpdate", true)
addEventHandler("gotTabletLocationUpdate", getRootElement(), function(group, data)
  for i = 1, #data do
    local id, x, y, z = data[i][1], data[i][2], data[i][3], data[i][4]
    if groupCallBlips[group][id] then
      updateGroupCallBlip(group, id, x, y, z)
    end
  end
  if group == currentTabletGroup then
    for i = 1, #data do
      tabletSingleLocationUpdate(data[i][1], data[i][2], data[i][3], data[i][4])
    end
    if currentTabletMenu <= 2 then
      processMenuList()
    end
  end
end)
function processReport(id, dat)
  dat.id = id
  dat.name = "((" .. dat.name .. "))"
  dat.numberText = sightexports.sMobile:formatPhoneNumber(dat.number)
  local time = getRealTime(dat.ts)
  dat.timeString = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
  if dat.locationX then
    dat.locationName = sightexports.sRadar:getZoneName(dat.locationX, dat.locationY, dat.locationZ)
  else
    dat.locationName = nil
  end
end
addEvent("newTabletDutyPlayer", true)
addEventHandler("newTabletDutyPlayer", getRootElement(), function(group, client, name)
  if group == currentTabletGroup then
    table.insert(tabletDutyList, {client, name})
  end
end)
addEvent("deleteTabletDutyPlayer", true)
addEventHandler("deleteTabletDutyPlayer", getRootElement(), function(group, client)
  if group == currentTabletGroup then
    for i = #tabletDutyList, 1, -1 do
      if tabletDutyList[i][1] == client then
        table.remove(tabletDutyList, i)
      end
    end
  end
end)
addEvent("gotTabletInitData", true)
addEventHandler("gotTabletInitData", getRootElement(), function(group, calls, reports, duty)
  tabletLoading = false
  if group == currentTabletGroup then
    tabletCalls = calls
    tabletReports = {}
    tabletDutyList = duty
    for id in pairs(reports) do
      processReport(id, reports[id])
      table.insert(tabletReports, reports[id])
    end
    table.sort(tabletReports, sortCallList)
    processCallList()
    gotTabletInitData()
  end
end)
local screenX, screenY = guiGetScreenSize()
local tabletX, tabletY
if fileExists("pos.sight") then
  local file = fileOpen("pos.sight")
  local data = fileRead(file, fileGetSize(file))
  fileClose(file)
  local pos = split(data, ",")
  local x = tonumber(pos[1])
  local y = tonumber(pos[2])
  if x and y then
    x = math.max(-440, math.min(screenX - 440, x))
    y = math.max(-275, math.min(screenY - 275, y))
  else
    x = screenX / 2 - 440
    y = screenY / 2 - 275
  end
  tabletX, tabletY = x, y
else
  tabletX = screenX / 2 - 440
  tabletY = screenY / 2 - 275
end
local iw = 828
local ih = 500
local rth = ih - 32
local tabletNull = false
local tabletInside = false
local tabletRtg = false
local tabletPrompt = false
local tabletScroll = false
local tabletMapRT = false
local tabletNameOnIcon = false
tabletColors = {
  white = {
    255,
    255,
    255
  },
  black = {
    0,
    0,
    0
  },
  bg = {
    47,
    47,
    47
  },
  fade = {
    15,
    15,
    15,
    200
  },
  btnbg = {
    18,
    18,
    18
  },
  selbtnbg = {
    33,
    33,
    33
  },
  secondarytext = {
    210,
    210,
    210
  },
  hr1 = {
    30,
    30,
    30
  },
  hr2 = {
    60,
    60,
    60
  },
  red = {
    190,
    83,
    83
  },
  orange = {
    209,
    141,
    82
  },
  blue = {
    79,
    106,
    229
  },
  green = {
    83,
    190,
    83
  }
}
tabletColors.blackToColor = tocolor(tabletColors.black[1], tabletColors.black[2], tabletColors.black[3])
tabletColors.whiteToColor = tocolor(tabletColors.white[1], tabletColors.white[2], tabletColors.white[3])
tabletColors.redToColor = tocolor(tabletColors.red[1], tabletColors.red[2], tabletColors.red[3])
tabletColors.orangeToColor = tocolor(tabletColors.orange[1], tabletColors.orange[2], tabletColors.orange[3])
tabletColors.blueToColor = tocolor(tabletColors.blue[1], tabletColors.blue[2], tabletColors.blue[3])
tabletColors.greenToColor = tocolor(tabletColors.green[1], tabletColors.green[2], tabletColors.green[3])
function tabletScrollHandler(key)
  if key == "mouse_wheel_up" or key == "mouse_wheel_down" then
    local x, y = sightexports.sGui:getGuiRealPosition(tabletRtg)
    local cx, cy = getCursorPosition()
    if not cx then
      return
    end
    cx = cx * screenX
    cy = cy * screenY
    if not (x <= cx and y <= cy and cx <= x + iw) or not (cy <= y + rth) then
      return
    end
    if currentTabletMenu <= 3 then
      local n, els = 0, 0
      if currentTabletMenu == 1 then
        n = #incomingCalls
        els = #tabletMenuListElements
      elseif currentTabletMenu == 2 then
        n = #acceptedCalls
        els = #tabletMenuListElements
      elseif currentTabletMenu == 3 then
        n = #tabletReports
        els = #tabletMenuListElements
      end
      if key == "mouse_wheel_up" then
        if 0 < currentTabletScroll[currentTabletMenu] then
          currentTabletScroll[currentTabletMenu] = currentTabletScroll[currentTabletMenu] - 1
          processMenuList()
        end
      elseif currentTabletScroll[currentTabletMenu] < n - els then
        currentTabletScroll[currentTabletMenu] = currentTabletScroll[currentTabletMenu] + 1
        processMenuList()
      end
    elseif currentTabletMenu == 4 then
      currentRadarZoom = currentRadarZoom + (key == "mouse_wheel_up" and 16 or -16)
      currentRadarZoom = math.max(32, math.min(512, currentRadarZoom))
      sightexports.sGui:setRadarCoords(tabletRadar, currentRadarX, currentRadarY, currentRadarZoom)
    end
  end
end
local radarMove = false
local tabletMove = false
function radarDragMove(rx, ry, cx, cy)
  if isCursorShowing() and currentTabletMenu == 4 then
    local zoom = 500 / currentRadarZoom
    currentRadarX = math.max(-3000, math.min(3000, radarMove[1] - (cx - radarMove[3]) * zoom))
    currentRadarY = math.max(-3000, math.min(3000, radarMove[2] + (cy - radarMove[4]) * zoom))
    radarMove[1] = currentRadarX
    radarMove[2] = currentRadarY
    radarMove[3] = cx
    radarMove[4] = cy
    sightexports.sGui:setRadarCoords(tabletRadar, currentRadarX, currentRadarY, currentRadarZoom)
  else
    radarMove = false
    sightlangCondHandl0(false)
  end
end
function groupcallTabletMove(rx, ry, cx, cy)
  if isCursorShowing() then
    tabletX = math.max(-440, math.min(screenX - 440, tabletMove[1] + (cx - tabletMove[3])))
    tabletY = math.max(-275, math.min(screenY - 275, tabletMove[2] + (cy - tabletMove[4])))
    tabletMove[1] = tabletX
    tabletMove[2] = tabletY
    tabletMove[3] = cx
    tabletMove[4] = cy
    sightexports.sGui:setGuiPosition(tabletNull, tabletX, tabletY)
  else
    local x, y = tonumber(tabletMove[1]), tonumber(tabletMove[2])
    if fileExists("pos.sight") then
      fileDelete("pos.sight")
    end
    if x and y then
      local file = fileCreate("pos.sight")
      fileWrite(file, x .. "," .. y)
      fileClose(file)
    end
    tabletMove = false
    sightlangCondHandl1(false)
  end
end
function tabletClick(btn, state, cx, cy)
  if radarMove then
    if state == "up" then
      radarMove = false
      sightlangCondHandl0(false)
    end
    return
  elseif tabletMove then
    if state == "up" then
      local x, y = tonumber(tabletMove[1]), tonumber(tabletMove[2])
      if fileExists("pos.sight") then
        fileDelete("pos.sight")
      end
      if x and y then
        local file = fileCreate("pos.sight")
        fileWrite(file, x .. "," .. y)
        fileClose(file)
      end
      tabletMove = false
      sightlangCondHandl1(false)
    end
    return
  end
  local ox, oy = sightexports.sGui:getGuiRealPosition(tabletNull)
  local x, y = sightexports.sGui:getGuiRealPosition(tabletRtg)
  if currentTabletMenu == 4 and cx >= x and cy >= y and cx <= x + iw and cy <= y + rth and state == "down" then
    radarMove = {
      currentRadarX,
      currentRadarY,
      cx,
      cy
    }
    sightlangCondHandl0(true)
    return
  end
  if cx >= x and cy >= y - 32 and cx <= x + iw and cy <= y + rth then
    return
  end
  if not (cx >= ox and cy >= oy and cx <= ox + 880) or not (cy <= oy + 550) then
    return
  end
  if state == "down" then
    tabletMove = {
      tabletX,
      tabletY,
      cx,
      cy
    }
    sightlangCondHandl1(true)
    return
  end
end
function refreshTabletOrder()
  if tabletInside then
    sightexports.sGui:guiToFront(tabletInside)
  end
  if tabletPrompt then
    sightexports.sGui:guiToFront(tabletPrompt)
  end
  if tabletImg then
    sightexports.sGui:guiToFront(tabletImg)
  end
end
function deleteTablet()
  tabletDutyList = {}
  tabletCalls = {}
  tabletReports = {}
  acceptedCalls = {}
  incomingCalls = {}
  if currentTabletGroup then
    sightexports.sChat:localActionC(localPlayer, "elrakta a szolgálati tabletjét.")
  end
  currentTabletGroup = false
  if tabletRequested then
    triggerServerEvent("deleteGroupCallTablet", localPlayer)
  end
  tabletRequested = false
  if tabletNull then
    sightexports.sGui:deleteGuiElement(tabletNull)
  end
  tabletNull = nil
  tabletInside = false
  tabletRtg = false
  tabletPrompt = false
  tabletScroll = false
  tabletRadar = false
  tabletNameOnIcon = false
  if isElement(tabletMapRT) then
    destroyElement(tabletMapRT)
  end
  tabletMapRT = nil
  tabletMenuListElements = {}
  menuButtons = {}
  if radarMove then
    radarMove = false
    sightlangCondHandl0(false)
  end
  sightlangCondHandl2(false)
  sightlangCondHandl3(false)
  sightlangCondHandl4(false)
end
addEvent("openGroupcallMobileDialer", false)
addEventHandler("openGroupcallMobileDialer", getRootElement(), function(button, state, absoluteX, absoluteY, el, number)
  if sightexports.sMobile:getMobileState() then
    sightexports.sMobile:openDialerWithNumber(number)
  else
    setClipboard(tostring(number))
    sightexports.sGui:showInfobox("i", "A megadott telefonszám a vágólapra lett másolva.")
  end
end)
local lastMark = 0
addEvent("markGroupReport", false)
addEventHandler("markGroupReport", getRootElement(), function(button, state, absoluteX, absoluteY, el, i)
  local dat = tabletReports[i]
  if dat then
    local id = dat.id
    if getTickCount() - lastMark < 1000 then
      sightexports.sGui:showInfobox("e", "Kérlek várj egy kicsit!")
      return
    end
    if isElement(groupReportBlips[currentTabletGroup][id]) then
      destroyElement(groupReportBlips[currentTabletGroup][id])
      groupReportBlips[currentTabletGroup][id] = nil
      triggerServerEvent("deleteGroupReportSubscription", localPlayer, currentTabletGroup, id)
      if currentTabletMenu == 3 then
        processMenuList()
      end
      playSound("files/pin.wav")
      return
    end
    if not dat.locationX then
      sightexports.sGui:showInfobox("e", "Nem jelölhető meg a bejelentés, mivel nem tartozik hozzá hely.")
      return
    end
    local name = "Bejelentés: " .. emergencyCallList[currentTabletGroup][1] .. " " .. id
    local r, g, b = unpack(blipColor)
    groupReportBlips[currentTabletGroup][id] = createBlip(dat.locationX, dat.locationY, dat.locationZ + 1, 23, 2, r, g, b)
    setElementData(groupReportBlips[currentTabletGroup][id], "tooltipText", name)
    triggerServerEvent("addGroupReportSubscription", localPlayer, currentTabletGroup, id)
    playSound("files/pin.wav")
    lastMark = getTickCount()
    if currentTabletMenu == 3 then
      processMenuList()
    end
  end
end)
addEvent("markGroupCall", false)
addEventHandler("markGroupCall", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
  if tabletCalls[id] then
    if getTickCount() - lastMark < 1000 then
      sightexports.sGui:showInfobox("e", "Kérlek várj egy kicsit!")
      return
    end
    if isElement(groupCallBlips[currentTabletGroup][id]) then
      destroyElement(groupCallBlips[currentTabletGroup][id])
      groupCallBlips[currentTabletGroup][id] = nil
      triggerServerEvent("deleteGroupCallSubscription", localPlayer, currentTabletGroup, id)
      if currentTabletMenu <= 2 then
        processMenuList()
      end
      playSound("files/pin.wav")
      return
    end
    if not tabletCalls[id].locationX then
      sightexports.sGui:showInfobox("e", "Nem jelölhető meg a hívás, mivel nem tartozik hozzá hely.")
      return
    end
    local name = "Hívás: " .. emergencyCallList[currentTabletGroup][1] .. " " .. id
    local r, g, b
    if not tabletCalls[id].locationOnline then
      name = name .. " (Nincs jel)"
      r, g, b = unpack(blipOffColor)
    else
      r, g, b = unpack(blipColor)
    end
    groupCallBlips[currentTabletGroup][id] = createBlip(tabletCalls[id].locationX, tabletCalls[id].locationY, tabletCalls[id].locationZ + 1, 22, 2, r, g, b)
    setElementData(groupCallBlips[currentTabletGroup][id], "tooltipText", name)
    triggerServerEvent("addGroupCallSubscription", localPlayer, currentTabletGroup, id)
    lastMark = getTickCount()
    playSound("files/pin.wav")
    if currentTabletMenu <= 2 then
      processMenuList()
    end
  end
end)
addEvent("acceptGroupCall", false)
addEventHandler("acceptGroupCall", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
  triggerServerEvent("acceptGroupCall", localPlayer, currentTabletGroup, id)
  playSound("files/accept.wav")
end)
addEvent("deleteGroupTabletPrompt", false)
addEventHandler("deleteGroupTabletPrompt", getRootElement(), function()
  if tabletPrompt then
    sightexports.sGui:deleteGuiElement(tabletPrompt)
  end
  tabletPrompt = nil
end)
addEvent("finalDeleteGroupCall", false)
addEventHandler("finalDeleteGroupCall", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
  playSound("files/accept.wav")
  if tabletPrompt then
    sightexports.sGui:deleteGuiElement(tabletPrompt)
  end
  tabletPrompt = nil
  triggerServerEvent("deleteGroupCall", localPlayer, currentTabletGroup, id)
end)
addEvent("deleteGroupCall", false)
addEventHandler("deleteGroupCall", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
  playSound("files/decline.wav")
  if tabletPrompt then
    sightexports.sGui:deleteGuiElement(tabletPrompt)
  end
  tabletPrompt = nil
  tabletPrompt = sightexports.sGui:createGuiElement("rectangle", 440 - iw / 2, 275 - ih / 2, iw, ih, tabletNull)
  sightexports.sGui:setGuiBackground(tabletPrompt, "solid", tabletColors.fade)
  sightexports.sGui:setGuiHoverable(tabletPrompt, true)
  sightexports.sGui:setGuiHover(tabletPrompt, "none", false, false, true)
  sightexports.sGui:disableClickTrough(tabletPrompt, true)
  sightexports.sGui:disableLinkCursor(tabletPrompt, true)
  local rect = sightexports.sGui:createGuiElement("rectangle", iw / 2 - 150, ih / 2 - 60, 300, 120, tabletPrompt)
  sightexports.sGui:setGuiBackground(rect, "solid", tabletColors.bg)
  local bw = 141
  local label = sightexports.sGui:createGuiElement("label", 6, 6, 288, 88, rect)
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelWordBreak(label, true)
  sightexports.sGui:setLabelText(label, "Biztosan törölni szeretnéd a következő hívást: " .. id .. "?")
  local btn = sightexports.sGui:createGuiElement("button", 6, 94, bw, 20, rect)
  sightexports.sGui:setGuiHover(btn, "none", false, false, true)
  sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightexports.sGui:setClickEvent(btn, "finalDeleteGroupCall")
  sightexports.sGui:setClickArgument(btn, id)
  sightexports.sGui:setGuiBackground(btn, "solid", tabletColors.green)
  sightexports.sGui:setButtonText(btn, "Igen")
  local btn = sightexports.sGui:createGuiElement("button", 6 + bw + 6, 94, bw, 20, rect)
  sightexports.sGui:setGuiHover(btn, "none", false, false, true)
  sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightexports.sGui:setClickEvent(btn, "deleteGroupTabletPrompt")
  sightexports.sGui:setGuiBackground(btn, "solid", tabletColors.red)
  sightexports.sGui:setButtonText(btn, "Nem")
  refreshTabletOrder()
end)
addEvent("finalDeleteGroupReport", false)
addEventHandler("finalDeleteGroupReport", getRootElement(), function(button, state, absoluteX, absoluteY, el, id)
  playSound("files/accept.wav")
  if tabletPrompt then
    sightexports.sGui:deleteGuiElement(tabletPrompt)
  end
  tabletPrompt = nil
  triggerServerEvent("deleteGroupReport", localPlayer, currentTabletGroup, id)
end)
addEvent("deleteGroupReport", false)
addEventHandler("deleteGroupReport", getRootElement(), function(button, state, absoluteX, absoluteY, el, i)
  local dat = tabletReports[i]
  if dat then
    local id = dat.id
    if tabletPrompt then
      sightexports.sGui:deleteGuiElement(tabletPrompt)
    end
    tabletPrompt = nil
    playSound("files/decline.wav")
    tabletPrompt = sightexports.sGui:createGuiElement("rectangle", 440 - iw / 2, 275 - ih / 2, iw, ih, tabletNull)
    sightexports.sGui:setGuiBackground(tabletPrompt, "solid", tabletColors.fade)
    sightexports.sGui:setGuiHoverable(tabletPrompt, true)
    sightexports.sGui:setGuiHover(tabletPrompt, "none", false, false, true)
    sightexports.sGui:disableClickTrough(tabletPrompt, true)
    sightexports.sGui:disableLinkCursor(tabletPrompt, true)
    local rect = sightexports.sGui:createGuiElement("rectangle", iw / 2 - 150, ih / 2 - 60, 300, 120, tabletPrompt)
    sightexports.sGui:setGuiBackground(rect, "solid", tabletColors.bg)
    local bw = 141
    local label = sightexports.sGui:createGuiElement("label", 6, 6, 288, 88, rect)
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelWordBreak(label, true)
    sightexports.sGui:setLabelText(label, "Biztosan törölni szeretnéd a következő bejelentést: " .. id .. "?")
    local btn = sightexports.sGui:createGuiElement("button", 6, 94, bw, 20, rect)
    sightexports.sGui:setGuiHover(btn, "none", false, false, true)
    sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    sightexports.sGui:setClickEvent(btn, "finalDeleteGroupReport")
    sightexports.sGui:setClickArgument(btn, id)
    sightexports.sGui:setGuiBackground(btn, "solid", tabletColors.green)
    sightexports.sGui:setButtonText(btn, "Igen")
    local btn = sightexports.sGui:createGuiElement("button", 6 + bw + 6, 94, bw, 20, rect)
    sightexports.sGui:setGuiHover(btn, "none", false, false, true)
    sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
    sightexports.sGui:setClickEvent(btn, "deleteGroupTabletPrompt")
    sightexports.sGui:setGuiBackground(btn, "solid", tabletColors.red)
    sightexports.sGui:setButtonText(btn, "Nem")
    refreshTabletOrder()
  end
end)
function processMenuList()
  if currentTabletMenu == 1 then
    local scroll = math.max(math.min(currentTabletScroll[1] or 0, #incomingCalls - #tabletMenuListElements), 0)
    if scroll ~= currentTabletScroll[1] then
      currentTabletScroll[1] = scroll
    end
    local sh = (rth - 16) / math.max(1, #incomingCalls - #tabletMenuListElements + 1)
    sightexports.sGui:setGuiSize(tabletScroll, false, sh)
    sightexports.sGui:setGuiPosition(tabletScroll, false, sh * scroll)
    for i = 1, #tabletMenuListElements do
      local dat = incomingCalls[i + scroll]
      for k, v in pairs(tabletMenuListElements[i]) do
        sightexports.sGui:setGuiRenderDisabled(v, not dat)
      end
      if dat then
        sightexports.sGui:setLabelText(tabletMenuListElements[i].id, dat.id)
        sightexports.sGui:setLabelText(tabletMenuListElements[i].reason, dat.reason)
        sightexports.sGui:setLabelText(tabletMenuListElements[i].time, dat.timeString)
        sightexports.sGui:setLabelText(tabletMenuListElements[i].name, dat.numberText)
        sightexports.sGui:setClickArgument(tabletMenuListElements[i].name, dat.number)
        sightexports.sGui:guiSetTooltip(tabletMenuListElements[i].name, dat.name)
        sightexports.sGui:setLabelText(tabletMenuListElements[i].location, dat.locationName or "N/A")
        sightexports.sGui:setClickArgument(tabletMenuListElements[i].accept, dat.id)
        sightexports.sGui:setClickArgument(tabletMenuListElements[i].decline, dat.id)
      end
    end
  elseif currentTabletMenu == 2 then
    local scroll = math.max(math.min(currentTabletScroll[2] or 0, #acceptedCalls - #tabletMenuListElements), 0)
    if scroll ~= currentTabletScroll[2] then
      currentTabletScroll[2] = scroll
    end
    local sh = (rth - 16) / math.max(1, #acceptedCalls - #tabletMenuListElements + 1)
    sightexports.sGui:setGuiSize(tabletScroll, false, sh)
    sightexports.sGui:setGuiPosition(tabletScroll, false, sh * scroll)
    for i = 1, #tabletMenuListElements do
      local dat = acceptedCalls[i + scroll]
      for k, v in pairs(tabletMenuListElements[i]) do
        sightexports.sGui:setGuiRenderDisabled(v, not dat)
      end
      if dat then
        sightexports.sGui:setLabelText(tabletMenuListElements[i].id, dat.id)
        sightexports.sGui:setLabelText(tabletMenuListElements[i].reason, dat.reason)
        sightexports.sGui:setLabelText(tabletMenuListElements[i].time, dat.timeString .. " (Elfogadva: " .. dat.acceptedString .. " / " .. (dat.acceptedPrefix or "N/A") .. ")")
        sightexports.sGui:setLabelText(tabletMenuListElements[i].name, dat.numberText)
        sightexports.sGui:setClickArgument(tabletMenuListElements[i].name, dat.number)
        sightexports.sGui:guiSetTooltip(tabletMenuListElements[i].name, dat.name)
        sightexports.sGui:setLabelText(tabletMenuListElements[i].location, dat.locationName or "N/A")
        sightexports.sGui:setImageFile(tabletMenuListElements[i].mark, sightexports.sGui:getFaIconFilename("map-marker-alt", 24, groupCallBlips[currentTabletGroup][dat.id] and "solid" or "regular"))
        sightexports.sGui:setClickArgument(tabletMenuListElements[i].mark, dat.id)
        sightexports.sGui:setClickArgument(tabletMenuListElements[i].decline, dat.id)
      end
    end
  elseif currentTabletMenu == 3 then
    local scroll = math.max(math.min(currentTabletScroll[3] or 0, #tabletReports - #tabletMenuListElements), 0)
    if scroll ~= currentTabletScroll[3] then
      currentTabletScroll[3] = scroll
    end
    local sh = (rth - 16) / math.max(1, #tabletReports - #tabletMenuListElements + 1)
    sightexports.sGui:setGuiSize(tabletScroll, false, sh)
    sightexports.sGui:setGuiPosition(tabletScroll, false, sh * scroll)
    for i = 1, #tabletMenuListElements do
      local dat = tabletReports[i + scroll]
      for k, v in pairs(tabletMenuListElements[i]) do
        sightexports.sGui:setGuiRenderDisabled(v, not dat)
      end
      if dat then
        sightexports.sGui:setLabelText(tabletMenuListElements[i].id, dat.id)
        sightexports.sGui:setLabelText(tabletMenuListElements[i].reason, dat.reason)
        sightexports.sGui:setLabelText(tabletMenuListElements[i].name, dat.numberText)
        sightexports.sGui:setClickArgument(tabletMenuListElements[i].name, dat.number)
        sightexports.sGui:guiSetTooltip(tabletMenuListElements[i].name, dat.name)
        sightexports.sGui:setLabelText(tabletMenuListElements[i].location, (dat.locationName or "N/A") .. " (" .. dat.timeString .. ")")
        sightexports.sGui:setImageFile(tabletMenuListElements[i].mark, sightexports.sGui:getFaIconFilename("map-marker-alt", 24, groupReportBlips[currentTabletGroup][dat.id] and "solid" or "regular"))
        sightexports.sGui:setClickArgument(tabletMenuListElements[i].mark, i + scroll)
        sightexports.sGui:setClickArgument(tabletMenuListElements[i].delete, i + scroll)
      end
    end
  end
end
function createIncomingCallMenu()
  local x, y = 8, 8
  local h = (rth - 16) / 10
  local rw = sightexports.sGui:getTextWidthFont("Indok: ", "10/Ubuntu-B.ttf")
  local rect = sightexports.sGui:createGuiElement("rectangle", iw - 8, y, 2, h * 10, tabletRtg)
  sightexports.sGui:setGuiBackground(rect, "solid", tabletColors.selbtnbg)
  tabletScroll = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, 0, rect)
  sightexports.sGui:setGuiBackground(tabletScroll, "solid", tabletColors.btnbg)
  for i = 1, 10 do
    tabletMenuListElements[i] = {}
    local label = sightexports.sGui:createGuiElement("label", x, y, 75, h, tabletRtg)
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-LI.ttf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelColor(label, tabletColors.secondarytext)
    tabletMenuListElements[i].id = label
    local label = sightexports.sGui:createGuiElement("label", x + 275, y, 0, h / 2, tabletRtg)
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Indok: ")
    table.insert(tabletMenuListElements[i], label)
    local label = sightexports.sGui:createGuiElement("label", x + 275 + rw, y, 0, h / 2, tabletRtg)
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, tabletColors.secondarytext)
    tabletMenuListElements[i].reason = label
    local label = sightexports.sGui:createGuiElement("label", x + 275, y + h / 2, 0, h / 2, tabletRtg)
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, tabletColors.secondarytext)
    tabletMenuListElements[i].time = label
    local icon = sightexports.sGui:createGuiElement("image", iw - 4 - 16 - 48 - 8, y + h / 2 - 12, 24, 24, tabletRtg)
    sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("phone", 24, "solid"))
    sightexports.sGui:setImageColor(icon, tabletColors.green)
    sightexports.sGui:setGuiHoverable(icon, true)
    sightexports.sGui:setClickEvent(icon, "acceptGroupCall")
    tabletMenuListElements[i].accept = icon
    local icon = sightexports.sGui:createGuiElement("image", iw - 4 - 16 - 24, y + h / 2 - 12, 24, 24, tabletRtg)
    sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("phone-slash", 24, "solid"))
    sightexports.sGui:setImageColor(icon, tabletColors.red)
    sightexports.sGui:setGuiHoverable(icon, true)
    sightexports.sGui:setClickEvent(icon, "deleteGroupCall")
    tabletMenuListElements[i].decline = icon
    local label = sightexports.sGui:createGuiElement("label", x + 75, y, 192, h / 2, tabletRtg)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setClickEvent(label, "openGroupcallMobileDialer")
    sightexports.sGui:setGuiHoverable(label, true)
    sightexports.sGui:setLabelClip(label, true)
    tabletMenuListElements[i].name = label
    y = y + h / 2
    local label = sightexports.sGui:createGuiElement("label", x + 75, y, 192, h / 2, tabletRtg)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, tabletColors.secondarytext)
    sightexports.sGui:setLabelClip(label, true)
    tabletMenuListElements[i].location = label
    y = y + h / 2
    if i < 10 then
      local border = sightexports.sGui:createGuiElement("hr", x, y - 1, iw - 4 - 16, 2, tabletRtg)
      sightexports.sGui:setGuiHrColor(border, tabletColors.hr1, tabletColors.hr2)
      table.insert(tabletMenuListElements[i], border)
    end
  end
end
function createAcceptedCallMenu()
  local x, y = 8, 8
  local h = (rth - 16) / 10
  local rw = sightexports.sGui:getTextWidthFont("Indok: ", "10/Ubuntu-B.ttf")
  local rect = sightexports.sGui:createGuiElement("rectangle", iw - 8, y, 2, h * 10, tabletRtg)
  sightexports.sGui:setGuiBackground(rect, "solid", tabletColors.selbtnbg)
  tabletScroll = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, 0, rect)
  sightexports.sGui:setGuiBackground(tabletScroll, "solid", tabletColors.btnbg)
  for i = 1, 10 do
    tabletMenuListElements[i] = {}
    local label = sightexports.sGui:createGuiElement("label", x, y, 75, h, tabletRtg)
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-LI.ttf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelColor(label, tabletColors.secondarytext)
    tabletMenuListElements[i].id = label
    local label = sightexports.sGui:createGuiElement("label", x + 275, y, 0, h / 2, tabletRtg)
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-B.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Indok: ")
    table.insert(tabletMenuListElements[i], label)
    local label = sightexports.sGui:createGuiElement("label", x + 275 + rw, y, 0, h / 2, tabletRtg)
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, tabletColors.secondarytext)
    tabletMenuListElements[i].reason = label
    local label = sightexports.sGui:createGuiElement("label", x + 275, y + h / 2, 0, h / 2, tabletRtg)
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, tabletColors.secondarytext)
    tabletMenuListElements[i].time = label
    local icon = sightexports.sGui:createGuiElement("image", iw - 4 - 16 - 48 - 8, y + h / 2 - 12, 24, 24, tabletRtg)
    sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("map-marker-alt", 24, "regular"))
    sightexports.sGui:setImageColor(icon, tabletColors.blue)
    sightexports.sGui:setGuiHoverable(icon, true)
    sightexports.sGui:setClickEvent(icon, "markGroupCall")
    tabletMenuListElements[i].mark = icon
    local icon = sightexports.sGui:createGuiElement("image", iw - 4 - 16 - 24, y + h / 2 - 12, 24, 24, tabletRtg)
    sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("phone-slash", 24, "solid"))
    sightexports.sGui:setImageColor(icon, tabletColors.red)
    sightexports.sGui:setGuiHoverable(icon, true)
    sightexports.sGui:setClickEvent(icon, "deleteGroupCall")
    tabletMenuListElements[i].decline = icon
    local label = sightexports.sGui:createGuiElement("label", x + 75, y, 192, h / 2, tabletRtg)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setClickEvent(label, "openGroupcallMobileDialer")
    sightexports.sGui:setGuiHoverable(label, true)
    sightexports.sGui:setLabelClip(label, true)
    tabletMenuListElements[i].name = label
    y = y + h / 2
    local label = sightexports.sGui:createGuiElement("label", x + 75, y, 192, h / 2, tabletRtg)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelColor(label, tabletColors.secondarytext)
    sightexports.sGui:setLabelClip(label, true)
    tabletMenuListElements[i].location = label
    y = y + h / 2
    if i < 10 then
      local border = sightexports.sGui:createGuiElement("hr", x, y - 1, iw - 4 - 16, 2, tabletRtg)
      sightexports.sGui:setGuiHrColor(border, tabletColors.hr1, tabletColors.hr2)
      table.insert(tabletMenuListElements[i], border)
    end
  end
end
function createReportsMenu()
  local x, y = 8, 8
  local h = (rth - 16) / 5
  local rect = sightexports.sGui:createGuiElement("rectangle", iw - 8, y, 2, h * 5, tabletRtg)
  sightexports.sGui:setGuiBackground(rect, "solid", tabletColors.selbtnbg)
  tabletScroll = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, 0, rect)
  sightexports.sGui:setGuiBackground(tabletScroll, "solid", tabletColors.btnbg)
  for i = 1, 5 do
    tabletMenuListElements[i] = {}
    local label = sightexports.sGui:createGuiElement("label", x, y, 75, 32, tabletRtg)
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-LI.ttf")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelColor(label, tabletColors.secondarytext)
    tabletMenuListElements[i].id = label
    local label = sightexports.sGui:createGuiElement("label", x + 75, y, 200, 32, tabletRtg)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setClickEvent(label, "openGroupcallMobileDialer")
    sightexports.sGui:setGuiHoverable(label, true)
    sightexports.sGui:setLabelClip(label, true)
    tabletMenuListElements[i].name = label
    local label = sightexports.sGui:createGuiElement("label", iw - 4 - 16 - 48 - 8, y, 0, 32, tabletRtg)
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-LI.ttf")
    sightexports.sGui:setLabelAlignment(label, "right", "center")
    sightexports.sGui:setLabelColor(label, tabletColors.secondarytext)
    tabletMenuListElements[i].location = label
    local icon = sightexports.sGui:createGuiElement("image", iw - 4 - 16 - 48, y + 16 - 12, 24, 24, tabletRtg)
    sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("map-marker-alt", 24, "regular"))
    sightexports.sGui:setImageColor(icon, tabletColors.blue)
    sightexports.sGui:setGuiHoverable(icon, true)
    sightexports.sGui:setClickEvent(icon, "markGroupReport")
    tabletMenuListElements[i].mark = icon
    local icon = sightexports.sGui:createGuiElement("image", iw - 4 - 16 - 24, y + 16 - 12, 24, 24, tabletRtg)
    sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("times", 24, "solid"))
    sightexports.sGui:setImageColor(icon, tabletColors.red)
    sightexports.sGui:setGuiHoverable(icon, true)
    sightexports.sGui:setClickEvent(icon, "deleteGroupReport")
    tabletMenuListElements[i].delete = icon
    local label = sightexports.sGui:createGuiElement("label", x, y + 32, iw - 16 - 4, h - 32, tabletRtg)
    sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
    sightexports.sGui:setLabelAlignment(label, "left", "top")
    sightexports.sGui:setLabelWordBreak(label, true)
    sightexports.sGui:setLabelColor(label, tabletColors.secondarytext)
    tabletMenuListElements[i].reason = label
    y = y + h
    if i < 5 then
      local border = sightexports.sGui:createGuiElement("hr", x, y - 1, iw - 4 - 16, 2, tabletRtg)
      sightexports.sGui:setGuiHrColor(border, tabletColors.hr1, tabletColors.hr2)
      tabletMenuListElements[i].hr = border
    end
  end
end
local dutyVehicleCache = {}
local dutyVehicleSizeCache = {}
addEvent("toggleGroupcallMapNames", false)
addEventHandler("toggleGroupcallMapNames", getRootElement(), function()
  playSound("files/pin.wav")
  tabletMapNameOn = not tabletMapNameOn
  sightexports.sGui:setImageFile(tabletNameOnIcon, tabletMapNameOn and nameOnIcon or nameOffIcon)
end)
function checkIntDim(client)
  if getElementInterior(client) == 0 and getElementDimension(client) == 0 then
    return true
  end
end
function preRenderTabletRadar()
  dxSetRenderTarget(tabletMapRT, true)
  dxSetBlendMode("modulate_add")
  local zoom = 500 * currentRadarZoom
  local tmp = {}
  local tmpVeh = {}
  local s = 28
  local vehToGet = false
  for i = 1, #tabletDutyList do
    local client = tabletDutyList[i][1]
    if isElement(client) and client ~= localPlayer and checkIntDim(client) then
      local veh = getPedOccupiedVehicle(client)
      if veh then
        tmp[client] = true
        tmpVeh[veh] = true
      else
        local x, y = getElementPosition(client)
        x = (x - currentRadarX) / 6000 * 12 * currentRadarZoom + iw / 2
        y = (currentRadarY - y) / 6000 * 12 * currentRadarZoom + rth / 2
        if x + s / 2 >= 0 and y + s / 2 >= 0 and x - s / 2 <= iw and y - s / 2 <= rth then
          dxDrawImage(x - s / 2, y - s / 2, s, s, ":sGui/" .. othersIcon .. faTicks[othersIcon])
          tmp[client] = true
          if tabletMapNameOn then
            if not tabletDutyList[i][3] then
              tabletDutyList[i][3] = dxGetTextWidth(tabletDutyList[i][2], nameFontScale, nameFont)
            end
            local w = tabletDutyList[i][3]
            dxDrawRectangle(x - w / 2, y + s / 2, w, nameFontH, tabletColors.blackToColor)
            dxDrawText(tabletDutyList[i][2], x, y + s / 2, x, 0, tabletColors.whiteToColor, nameFontScale, nameFont, "center", "top")
          end
        end
      end
    end
  end
  if checkIntDim(localPlayer) then
    local veh = getPedOccupiedVehicle(localPlayer)
    if veh then
      tmpVeh[veh] = true
    else
      local x, y = getElementPosition(localPlayer)
      x = (x - currentRadarX) / 6000 * 12 * currentRadarZoom + iw / 2
      y = (currentRadarY - y) / 6000 * 12 * currentRadarZoom + rth / 2
      if x + s / 2 >= 0 and y + s / 2 >= 0 and x - s / 2 <= iw and y - s / 2 <= rth then
        local s = s * 0.85
        local rx, ry, rz = getElementRotation(localPlayer)
        dxDrawImage(x - s / 2 + 1, y - s / 2 + 1, s, s, ":sGui/" .. playerIcon .. faTicks[playerIcon], -rz - 45, 0, 0, tabletColors.blackToColor)
        dxDrawImage(x - s / 2, y - s / 2, s, s, ":sGui/" .. playerIcon .. faTicks[playerIcon], -rz - 45, 0, 0, tabletColors.greenToColor)
      end
    end
  end
  local selfVeh = getPedOccupiedVehicle(localPlayer)
  for veh in pairs(tmpVeh) do
    local x, y = getElementPosition(veh)
    x = (x - currentRadarX) / 6000 * 12 * currentRadarZoom + iw / 2
    y = (currentRadarY - y) / 6000 * 12 * currentRadarZoom + rth / 2
    if x + s / 2 >= 0 and y + s / 2 >= 0 and x - s / 2 <= iw and y - s / 2 <= rth then
      local icon = veh == selfVeh and selfCarIcon or carIcon
      dxDrawImage(x - s / 2, y - s / 2, s, s, ":sGui/" .. icon .. faTicks[icon])
      if tabletMapNameOn then
        if dutyVehicleCache[veh] then
          local w = dutyVehicleSizeCache[veh]
          dxDrawRectangle(x - w / 2, y + s / 2, w, nameFontH, tabletColors.blackToColor)
          dxDrawText(dutyVehicleCache[veh], x, y + s / 2, x, 0, tabletColors.whiteToColor, nameFontScale, nameFont, "center", "top")
        else
          vehToGet = veh
        end
      end
    end
  end
  local w = 42
  for id, dat in pairs(tabletCalls) do
    if dat.locationX then
      local x, y = dat.locationX, dat.locationY
      x = (x - currentRadarX) / 6000 * 12 * currentRadarZoom + iw / 2
      y = (currentRadarY - y) / 6000 * 12 * currentRadarZoom + rth / 2
      if x + s / 2 >= 0 and y + s / 2 >= 0 and x - s / 2 <= iw and y - s / 2 <= rth then
        local icon = false
        if dat.accepted then
          icon = dat.locationOnline and callMapIcon or callOffMapIcon
        else
          icon = dat.locationOnline and callInMapIcon or callInOffMapIcon
        end
        dxDrawImage(x - s / 2, y - s / 2, s, s, ":sGui/" .. icon .. faTicks[icon])
        dxDrawRectangle(x - w / 2, y + s / 2, w, nameFontH, tabletColors.blackToColor)
        dxDrawText(dat.id, x, y + s / 2, x, 0, tabletColors.whiteToColor, nameFontScale, nameFont, "center", "top")
      end
    end
  end
  for id, dat in pairs(tabletReports) do
    if dat.locationX then
      local x, y = dat.locationX, dat.locationY
      x = (x - currentRadarX) / 6000 * 12 * currentRadarZoom + iw / 2
      y = (currentRadarY - y) / 6000 * 12 * currentRadarZoom + rth / 2
      if x + s / 2 >= 0 and y + s / 2 >= 0 and x - s / 2 <= iw and y - s / 2 <= rth then
        dxDrawImage(x - s / 2, y - s / 2, s, s, ":sGui/" .. reportMapIcon .. faTicks[reportMapIcon])
        dxDrawRectangle(x - w / 2, y + s / 2, w, nameFontH, tabletColors.blackToColor)
        dxDrawText(dat.id, x, y + s / 2, x, 0, tabletColors.whiteToColor, nameFontScale, nameFont, "center", "top")
      end
    end
  end
  dxSetBlendMode("blend")
  dxSetRenderTarget()
  if vehToGet then
    local plate = getVehiclePlateText(vehToGet) or ""
    local tmp = {}
    plate = split(plate, "-")
    for i = 1, #plate do
      if 1 <= utf8.len(plate[i]) then
        table.insert(tmp, plate[i])
      end
    end
    local plate = table.concat(tmp, "-")
    dutyVehicleCache[vehToGet] = plate
    dutyVehicleSizeCache[vehToGet] = dxGetTextWidth(dutyVehicleCache[vehToGet], nameFontScale, nameFont) + 6
  end
  for veh in pairs(dutyVehicleCache) do
    if not isElement(veh) or not tmpVeh[veh] then
      dutyVehicleCache[veh] = nil
      dutyVehicleSizeCache[veh] = nil
    end
  end
end
function processTabletMenu()
  tabletScroll = false
  tabletRadar = false
  tabletNameOnIcon = false
  if isElement(tabletMapRT) then
    destroyElement(tabletMapRT)
  end
  tabletMapRT = nil
  if tabletRtg then
    sightexports.sGui:deleteGuiElement(tabletRtg)
  end
  tabletRtg = nil
  if radarMove then
    radarMove = false
    sightlangCondHandl0(false)
  end
  dutyVehicleCache = {}
  dutyVehicleSizeCache = {}
  sightlangCondHandl2(false)
  tabletRtg = sightexports.sGui:createGuiElement("none", 0, 32, iw, rth, tabletInside)
  for btn, menu in pairs(menuButtons) do
    sightexports.sGui:setGuiBackground(btn, "solid", menu == currentTabletMenu and tabletColors.selbtnbg or tabletColors.btnbg)
    sightexports.sGui:setButtonTextColor(btn, menu == currentTabletMenu and tabletColors.white or tabletColors.secondarytext)
    sightexports.sGui:setGuiHoverable(btn, menu ~= currentTabletMenu)
  end
  tabletMenuListElements = {}
  if currentTabletMenu == 1 then
    createIncomingCallMenu()
  elseif currentTabletMenu == 2 then
    createAcceptedCallMenu()
  elseif currentTabletMenu == 3 then
    createReportsMenu()
  elseif currentTabletMenu == 4 then
    tabletRadar = sightexports.sGui:createGuiElement("radar", 0, 0, iw, rth, tabletRtg)
    sightexports.sGui:setRadarCoords(tabletRadar, currentRadarX, currentRadarY, currentRadarZoom)
    tabletMapRT = dxCreateRenderTarget(iw, rth, true)
    local img = sightexports.sGui:createGuiElement("image", 0, 0, iw, rth, tabletRtg)
    sightexports.sGui:setImageFile(img, tabletMapRT)
    tabletNameOnIcon = sightexports.sGui:createGuiElement("image", iw - 48, rth - 48, 32, 32, tabletRtg)
    sightexports.sGui:setImageFile(tabletNameOnIcon, tabletMapNameOn and nameOnIcon or nameOffIcon)
    sightexports.sGui:setClickEvent(tabletNameOnIcon, "toggleGroupcallMapNames")
    sightexports.sGui:setGuiHoverable(tabletNameOnIcon, true)
    sightlangCondHandl2(true)
  end
  if currentTabletMenu <= 3 then
    processMenuList()
  end
  refreshTabletOrder()
end
addEvent("selectGroupCallTabletMenu", false)
addEventHandler("selectGroupCallTabletMenu", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if menuButtons[el] then
    currentTabletMenu = menuButtons[el]
    playSound("files/navbar.wav")
    processTabletMenu()
  end
end)
function gotTabletInitData()
  if tabletInside then
    sightexports.sGui:deleteGuiElement(tabletInside)
  end
  tabletInside = nil
  tabletInside = sightexports.sGui:createGuiElement("rectangle", 440 - iw / 2, 275 - ih / 2, iw, ih, tabletNull)
  sightexports.sGui:setGuiBackground(tabletInside, "solid", tabletColors.bg)
  local bw = iw / 4
  local btn = sightexports.sGui:createGuiElement("button", 0, 0, bw, 32, tabletInside)
  sightexports.sGui:setGuiHover(btn, "none", false, false, true)
  sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightexports.sGui:setClickEvent(btn, "selectGroupCallTabletMenu")
  sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("phone-plus", 32))
  sightexports.sGui:setButtonText(btn, " Bejövő hívások")
  menuButtons[btn] = 1
  local btn = sightexports.sGui:createGuiElement("button", bw * 1, 0, bw, 32, tabletInside)
  sightexports.sGui:setGuiHover(btn, "none", false, false, true)
  sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightexports.sGui:setClickEvent(btn, "selectGroupCallTabletMenu")
  sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("phone", 32))
  sightexports.sGui:setButtonText(btn, " Elfogadott hívások")
  menuButtons[btn] = 2
  local btn = sightexports.sGui:createGuiElement("button", bw * 2, 0, bw, 32, tabletInside)
  sightexports.sGui:setGuiHover(btn, "none", false, false, true)
  sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightexports.sGui:setClickEvent(btn, "selectGroupCallTabletMenu")
  sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("envelope", 32))
  sightexports.sGui:setButtonText(btn, " Bejelentések")
  menuButtons[btn] = 3
  local btn = sightexports.sGui:createGuiElement("button", bw * 3, 0, bw, 32, tabletInside)
  sightexports.sGui:setGuiHover(btn, "none", false, false, true)
  sightexports.sGui:setButtonFont(btn, "11/Ubuntu-R.ttf")
  sightexports.sGui:setClickEvent(btn, "selectGroupCallTabletMenu")
  sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("map-signs", 32))
  sightexports.sGui:setButtonText(btn, " Térkép")
  menuButtons[btn] = 4
  tabletLoading = false
  sightlangCondHandl3(true)
  sightlangCondHandl4(true)
  processTabletMenu()
end
function createTablet(group)
  deleteTablet()
  sightexports.sChat:localActionC(localPlayer, "elővette a szolgálati tabletjét.")
  tabletNull = sightexports.sGui:createGuiElement("rectangle", tabletX, tabletY, 880, 550)
  sightexports.sGui:setGuiHoverable(tabletNull, true)
  sightexports.sGui:disableClickTrough(tabletNull, true)
  sightexports.sGui:disableLinkCursor(tabletNull, true)
  sightexports.sGui:setDisableClickSound(tabletNull, false, true)
  tabletImg = sightexports.sGui:createGuiElement("image", 0, 0, 880, 550, tabletNull)
  sightexports.sGui:setImageDDS(tabletImg, ":sGroupcall/files/tablet.dds")
  tabletInside = sightexports.sGui:createGuiElement("rectangle", 440 - iw / 2, 275 - ih / 2, iw, ih, tabletNull)
  sightexports.sGui:setGuiBackground(tabletInside, "solid", tabletColors.btnbg)
  local loadingIcon = sightexports.sGui:createGuiElement("image", iw / 2 - 32, ih / 2 - 44, 64, 64, tabletInside)
  local label = sightexports.sGui:createGuiElement("label", iw / 2, ih / 2 + 44 - 24, 0, 24, tabletInside)
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  currentTabletGroup = byGroupPrefix[group]
  if not currentTabletGroup then
    sightexports.sGui:setImageFile(loadingIcon, sightexports.sGui:getFaIconFilename("times", 64))
    sightexports.sGui:setLabelText(label, "Hibás szervezet!")
  else
    sightexports.sGui:setImageFile(loadingIcon, sightexports.sGui:getFaIconFilename("circle-notch", 64))
    sightexports.sGui:setImageSpinner(loadingIcon, true)
    sightexports.sGui:setLabelText(label, emergencyCallList[currentTabletGroup][1])
    if not tabletLoading then
      tabletRequested = true
      tabletLoading = true
      triggerServerEvent("requestTabletInitData", localPlayer, currentTabletGroup, group)
    end
  end
  refreshTabletOrder()
end
local tabletObjects = {}
local streamedPlayerTablets = {}
local tabletQ = {
  0.059827387447574,
  -0.038785605657951,
  0.72739675435797,
  0.68250298333007
}
local tabletModel = false
function loadModels()
  tabletModel = sightexports.sModloader:getModelId("v4_tablet")
end
addEventHandler("onClientPlayerDataChange", getRootElement(), function(data, old, new)
  if (source == localPlayer or isElementStreamedIn(source)) and data == "tablet" then
    streamedPlayerTablets[source] = new or nil
    if new then
      sightlangCondHandl5(true)
      if not isElement(tabletObjects[source]) then
        tabletObjects[source] = createObject(tabletModel, 0, 0, 0)
        setElementCollisionsEnabled(tabletObjects[source], false)
        sightexports.sPattach:attach(tabletObjects[source], source, 25, -0.015927458568625, 0.029212576383282, 0.10783896003808, 0, 0, 0)
        sightexports.sPattach:setRotationQuaternion(tabletObjects[source], tabletQ)
      end
    else
      if isElement(tabletObjects[source]) then
        destroyElement(tabletObjects[source])
      end
      tabletObjects[source] = nil
    end
  end
end)
addEventHandler("onClientPlayerStreamIn", getRootElement(), function()
  if source ~= localPlayer then
    streamedPlayerTablets[source] = getElementData(source, "tablet") or nil
    if streamedPlayerTablets[source] then
      sightlangCondHandl5(true)
      if not isElement(tabletObjects[source]) then
        tabletObjects[source] = createObject(tabletModel, 0, 0, 0)
        setElementCollisionsEnabled(tabletObjects[source], false)
        sightexports.sPattach:attach(tabletObjects[source], source, 25, -0.015927458568625, 0.029212576383282, 0.10783896003808, 0, 0, 0)
        sightexports.sPattach:setRotationQuaternion(tabletObjects[source], tabletQ)
      end
    else
      if isElement(tabletObjects[source]) then
        destroyElement(tabletObjects[source])
      end
      tabletObjects[source] = nil
    end
  end
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
  if source ~= localPlayer then
    streamedPlayerTablets[source] = nil
    if isElement(tabletObjects[source]) then
      destroyElement(tabletObjects[source])
    end
    tabletObjects[source] = nil
  end
end)
addEventHandler("onClientPlayerStreamOut", getRootElement(), function()
  if source ~= localPlayer then
    streamedPlayerTablets[source] = nil
    if isElement(tabletObjects[source]) then
      destroyElement(tabletObjects[source])
    end
    tabletObjects[source] = nil
  end
end)
function tabletBones()
  for client, val in pairs(streamedPlayerTablets) do
    if isElementOnScreen(client) then
      setElementBoneRotation(client, 22, 51.73919511878, -74.347910673722, -58.695642222529)
      setElementBoneRotation(client, 23, -50.869565217392, -78.260849662452, -9.1302705847697)
      setElementBoneRotation(client, 24, -142.17389314071, -35.217426134192, -24.782568890116)
      setElementBoneRotation(client, 25, -1.3044174857762, 10.43479256008, 16.956457055133)
      setElementBoneRotation(client, 26, -5.2173266203507, 15.652084350586, 0)
      sightexports.sCore:updateElementRpHAnim(client)
      if isElement(tabletObjects[client]) then
        setElementInterior(tabletObjects[client], getElementInterior(client))
        setElementDimension(tabletObjects[client], getElementDimension(client))
      end
    end
  end
  for client, val in pairs(streamedPlayerTablets) do
    return
  end
  sightlangCondHandl5(false)
end