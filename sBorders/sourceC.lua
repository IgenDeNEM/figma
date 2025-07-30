local sightexports = {
  sGroups = false,
  sDashboard = false,
  sVehiclenames = false,
  sGui = false,
  sControls = false,
  sSpeedo = false,
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
    local res0 = getResourceFromName("sGroups")
    if res0 and getResourceState(res0) == "running" then
      refreshInPolice()
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
local screenX, screenY = guiGetScreenSize()
local borderManualOpened = {}
local borderManual = {}
local borderCols = {}
local inBorderCol = false
local borderWindow = false
local borderControl = false
local borderState = true
addEvent("changeBorderManual", true)
addEventHandler("changeBorderManual", getRootElement(), function(i, manual, opened, name)
  borderManual[i] = manual
  borderManualOpened[i] = opened
  if inBorderCol == i then
    createBorderControl()
  end
  if name and (inPolice or getElementData(localPlayer, "acc.adminLevel") >= 1) and borders[i] then
    if manual then
      if opened then
        outputChatBox("[color=sightblue][SightMTA - Határ]: #ffffff" .. borders[i].pronoun .. " [color=sightblue]" .. borders[i].name .. " határt#ffffff kinyitotta [color=sightblue]" .. name, 255, 255, 255, true)
      else
        outputChatBox("[color=sightblue][SightMTA - Határ]: #ffffff" .. borders[i].pronoun .. " [color=sightblue]" .. borders[i].name .. " határt#ffffff bezárta [color=sightblue]" .. name, 255, 255, 255, true)
      end
    else
      outputChatBox("[color=sightblue][SightMTA - Határ]: #ffffff" .. borders[i].pronoun .. " [color=sightblue]" .. borders[i].name .. " határt#ffffff automatikusra állította [color=sightblue]" .. name, 255, 255, 255, true)
    end
  end
end)
triggerServerEvent("requestBorderManual", localPlayer)
function refreshInPolice()
  local tmp = sightexports.sGroups:isPlayerInLawEnforcement()
  if inPolice ~= tmp then
    inPolice = tmp
  end
end
addEvent("gotPlayerGroupMembership", true)
addEventHandler("gotPlayerGroupMembership", getRootElement(), refreshInPolice)
function getBorderState()
  return borderState
end
function setBorderState(val)
  borderState = val
end
addCommandHandler("toghatar", function()
  borderState = not borderState
  sightexports.sDashboard:saveValue("toghatar", borderState)
  outputChatBox("[color=sightgreen][SightMTA]: #FFFFFFHatár üzenetek " .. (borderState and "[color=sightgreen]bekapcsolva" or "[color=sightred]kikapcsolva") .. "#ffffff.", 255, 255, 255, true)
end)
function deleteAlertBlip(blip)
  if isElement(blip) then
    destroyElement(blip)
  end
  blip = nil
end

function rgbToHex(r, g, b)
  return string.format("#%.2X%.2X%.2X", r, g, b)
end

addEvent("borderCrossingMessage", true)
addEventHandler("borderCrossingMessage", getRootElement(), function(model, plate, i, warrant, color1, color2)
  if inPolice and borders[i] and (borderState or warrant) and sightexports.sGroups:getTogGroupMsg() then
    if borderState then

      local color1Hex = rgbToHex(color1[1], color1[2], color1[3])
      local color2Hex = rgbToHex(color2[1], color2[2], color2[3])
			local customVehicleModel = getElementData((source), "vehicle.customModel")
			local vehicleRealName = exports.sVehiclenames:getCustomVehicleName(customVehicleModel) or exports.sVehiclenames:getCustomVehicleName(model)

      --outputChatBox("[color=sightblue][SightMTA - Határ]:#ffffff Átlépte egy jármű a határt!", 255, 255, 255, true)
      --outputChatBox("[color=sightblue][SightMTA - Határ]:#ffffff Rendszáma: " .. "[color=sightblue]" .. plate, 255, 255, 255, true)
      --outputChatBox("[color=sightblue][SightMTA - Határ]:#ffffff Típusa: [color=sightblue]" .. vehicleRealName .. " #FFFFFF Színek: " .. color1Hex .."[1] ".. color2Hex .."[2]", 255, 255, 255, true)
      --outputChatBox("[color=sightblue][SightMTA - Határ]:#ffffff Pozíció: [color=sightblue]" .. getZoneName(getElementPosition(source)), 255, 255, 255, true)
      outputChatBox("[color=sightblue][SightMTA - Határ]: #ffffff" .. borders[i].pronoun .. " [color=sightblue]" .. borders[i].name .. " határon#ffffff átlépett egy jármű: [color=sightblue]" .. vehicleRealName .. " (" .. plate .. ")", 255, 255, 255, true)
    end
    if warrant then
      local sound = false
      --outputChatBox("[color=sightblue][SightMTA - Határ]:#ffffff Átlépte egy jármű a határt!", 255, 255, 255, true)
      --outputChatBox("[color=sightblue][SightMTA - Határ]:#ffffff Rendszáma: " .. "[color=sightred]" .. plate, 255, 255, 255, true)
      --outputChatBox("[color=sightblue][SightMTA - Határ]:#ffffff Típusa: [color=sightblue]" .. sightexports.sVehiclenames:getCustomVehicleName(model) .. " #FFFFFF Színek: [1] [2]", 255, 255, 255, true)
      --outputChatBox("[color=sightblue][SightMTA - Határ]:#ffffff Pozíció: [color=sightblue]" .. getZoneName(getElementPosition(source)), 255, 255, 255, true)--]]
      outputChatBox("[color=sightblue][SightMTA - Határ]: #ffffff" .. borders[i].pronoun .. " [color=sightblue]" .. borders[i].name .. " határon#ffffff átlépett [color=sightred]" .. plate .. "#ffffff rendszámú jármű [color=sightred]körözött#ffffff.", 255, 255, 255, true)
      for i = 1, #warrant do
        outputChatBox("[color=sightblue][SightMTA - Határ]: #ffffffIndok: [color=sightred-second]" .. warrant[i], 255, 255, 255, true)
        if not sound and not utf8.find(warrant[i], "megfigyel") then
          sound = true
        end
      end
      if sound then
        playSound(":sGroups/files/backup.mp3")
      end
      local x, y, z = unpack(borders[i].pos)
      local r, g, b = unpack(sightexports.sGui:getColorCode("sightred"))
      local blip = createBlip(x, y, z, 25, 2, r, g, b)
      if isElement(source) then
        attachElements(blip, source)
      end
      setElementData(blip, "tooltipText", "Körözött jármű: " .. plate)
      setTimer(deleteAlertBlip, 10000, 1, blip)
    end
  end
end)
addEvent("borderWarrantAlert", true)
addEventHandler("borderWarrantAlert", getRootElement(), function(name, i, warrant)
  if inPolice and borders[i] and sightexports.sGroups:getTogGroupMsg() then
    outputChatBox("[color=sightblue][SightMTA - Határ]: #ffffff" .. borders[i].pronoun .. " [color=sightblue]" .. borders[i].name .. " határon#ffffff [color=sightred]körözött személy#ffffff lépett át: [color=sightred]" .. name, 255, 255, 255, true)
    local sound = false
    for i = 1, #warrant do
      outputChatBox("[color=sightblue][SightMTA - Határ]: #ffffffIndok: [color=sightred-second]" .. warrant[i], 255, 255, 255, true)
      if not sound and not utf8.find(warrant[i], "megfigyel") then
        sound = true
      end
    end
    if sound then
      playSound(":sGroups/files/backup.mp3")
    end
    local x, y, z = unpack(borders[i].pos)
    local r, g, b = unpack(sightexports.sGui:getColorCode("sightred"))
    local blip = createBlip(x, y, z, 25, 2, r, g, b)
    if isElement(source) then
      attachElements(blip, source)
    end
    setElementData(blip, "tooltipText", "Körözött személy: " .. name)
    setTimer(deleteAlertBlip, 10000, 1, blip)
  end
end)
addEvent("setBorderManualOpened", false)
addEventHandler("setBorderManualOpened", getRootElement(), function()
  if inBorderCol then
    triggerServerEvent("changeBorderManual", localPlayer, inBorderCol, true, true)
  end
end)
addEvent("setBorderManualClosed", false)
addEventHandler("setBorderManualClosed", getRootElement(), function()
  if inBorderCol then
    triggerServerEvent("changeBorderManual", localPlayer, inBorderCol, true, false)
  end
end)
addEvent("setBorderAutomatic", false)
addEventHandler("setBorderAutomatic", getRootElement(), function()
  if inBorderCol then
    triggerServerEvent("changeBorderManual", localPlayer, inBorderCol, false)
  end
end)
function createBorderControl()
  if borderControl then
    sightexports.sGui:deleteGuiElement(borderControl)
  end
  borderControl = false
  if inBorderCol and sightexports.sGroups:getPlayerPermission("borderControl") then
    local w = 128
    borderControl = sightexports.sGui:createGuiElement("rectangle", screenX / 2 - w / 2, screenY * 0.85, w, 48)
    sightexports.sGui:setGuiBackground(borderControl, "solid", "sightgrey1")
    local btn = sightexports.sGui:createGuiElement("button", 8, 8, 32, 32, borderControl)
    if not borderManual[inBorderCol] then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey3", "sightgrey2"}, false, true)
    end
    sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("passport", 32))
    sightexports.sGui:guiSetTooltip(btn, "Automata")
    sightexports.sGui:setClickEvent(btn, "setBorderAutomatic")
    local btn = sightexports.sGui:createGuiElement("button", 48, 8, 32, 32, borderControl)
    if borderManual[inBorderCol] and not borderManualOpened[inBorderCol] then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey3", "sightgrey2"}, false, true)
    end
    sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("lock", 32))
    sightexports.sGui:guiSetTooltip(btn, "Zárva")
    sightexports.sGui:setClickEvent(btn, "setBorderManualClosed")
    local btn = sightexports.sGui:createGuiElement("button", 88, 8, 32, 32, borderControl)
    if borderManual[inBorderCol] and borderManualOpened[inBorderCol] then
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHoverable(btn, false)
    else
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
      sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey3", "sightgrey2"}, false, true)
    end
    sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
    sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("lock-open", 32))
    sightexports.sGui:guiSetTooltip(btn, "Nyitva")
    sightexports.sGui:setClickEvent(btn, "setBorderManualOpened")
  end
end
playedMinutes = 0
addEvent("refreshPlayedMinutes", true)
addEventHandler("refreshPlayedMinutes", getRootElement(), function(data)
  playedMinutes = data
end)
function borderColHit(he)
  if he == localPlayer then
    closeBorderWindow()
    inBorderCol = borderCols[source]
    if inBorderCol then
      local veh = getPedOccupiedVehicle(localPlayer)
      if veh and getVehicleController(veh) == localPlayer then
        if borderManual[inBorderCol] then
          if not borderManualOpened[inBorderCol] then
            sightexports.sGui:showInfobox("e", "Ez a határ zárva van!")
          end
        else
          sightexports.sControls:toggleControl("enter_exit", false)
          setElementData(veh, "vehicle.gear", "N")
          local titleBarHeight = sightexports.sGui:getTitleBarHeight()
          local pw = 300
          local ph = titleBarHeight + 120 + (sandingSkip and 32 or 0)
          borderWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
          sightexports.sGui:setWindowTitle(borderWindow, "16/BebasNeueRegular.otf", "Határ")
          local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - 8 - 32 - 8 - titleBarHeight, borderWindow)
          sightexports.sGui:setLabelAlignment(label, "center", "center")
          if getElementData(localPlayer, "char.level") <= 3 then
            sightexports.sGui:setLabelText(label, "Átlépsz a határon?\n\nFizetendő: [color=sightgreen]Ingyenes (Lvl 3-ig)")
          else
            sightexports.sGui:setLabelText(label, "Átlépsz a határon?\n\nFizetendő: [color=sightgreen]" .. sightexports.sGui:thousandsStepper(borders[inBorderCol].price) .. " $")
          end
          sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
          local w = (pw - 24) / 2
          local btn = sightexports.sGui:createGuiElement("button", 8, ph - 8 - 32, w, 32, borderWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
          sightexports.sGui:setGuiHover(btn, "gradient", {
            "sightgreen",
            "sightgreen-second"
          }, false, true)
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonText(btn, "Igen")
          sightexports.sGui:setClickEvent(btn, "payBorderCrossing", true)
          local btn = sightexports.sGui:createGuiElement("button", pw - w - 8, ph - 8 - 32, w, 32, borderWindow)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
          sightexports.sGui:setGuiHover(btn, "gradient", {
            "sightred",
            "sightred-second"
          }, false, true)
          sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
          sightexports.sGui:setButtonText(btn, "Nem")
          sightexports.sGui:setClickEvent(btn, "closeBorderWindow")
        end
      end
      createBorderControl()
    end
  end
end
addEvent("payBorderCrossing", false)
addEventHandler("payBorderCrossing", getRootElement(), function()
  triggerServerEvent("payBorderCrossing", localPlayer, inBorderCol)
end)
function closeBorderWindow()
  inBorderCol = false
  if borderWindow then
    sightexports.sGui:deleteGuiElement(borderWindow)
  end
  borderWindow = false
end
addEvent("closeBorderWindow", true)
addEventHandler("closeBorderWindow", getRootElement(), closeBorderWindow)
function borderColLeave(he)
  if he == localPlayer then
    closeBorderWindow()
    sightexports.sControls:toggleControl("enter_exit", true)
    if borderControl then
      sightexports.sGui:deleteGuiElement(borderControl)
    end
    borderControl = false
  end
end
for i = 1, #borders do
  local rad = math.rad(borders[i].pos[4])
  local cx, cy = borders[i].pos[1], borders[i].pos[2]
  local x, y = cx + math.cos(rad) * maxSizes[borders[i].size], cy + math.sin(rad) * maxSizes[borders[i].size]
  local x2, y2 = cx + math.cos(rad) * minSizes[borders[i].size], cy + math.sin(rad) * minSizes[borders[i].size]
  local x3, y3 = math.sin(rad) * 5.5, math.cos(rad) * 5.5
  borders[i].col = createColPolygon(cx, cy, x, y, x2, y2, x2 + x3, y2 - y3, x + x3, y - y3)
  borderCols[borders[i].col] = i
  setColPolygonHeight(borders[i].col, borders[i].pos[3] - 1, borders[i].pos[3] + 5)
  addEventHandler("onClientColShapeHit", borders[i].col, borderColHit)
  addEventHandler("onClientColShapeLeave", borders[i].col, borderColLeave)
end
addEventHandler("onClientObjectBreak", root,
    function()
        if getElementModel(source) == 1214 then
            cancelEvent()
        end
    end
)