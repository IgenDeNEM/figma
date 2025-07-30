local sightexports = {
  sGui = false,
  sVehiclenames = false,
  sChat = false
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
local obdKruton = false
local krutonTimer = false
local krutonObdBg = false
function deleteKrutonObd()
  if obdKruton then
    sightexports.sGui:deleteGuiElement(obdKruton)
  end
  obdKruton = false
  if isTimer(krutonTimer) then
    killTimer(krutonTimer)
  end
  krutonTimer = false
  krutonObdBg = false
end
addEvent("deleteKrutonObd", false)
addEventHandler("deleteKrutonObd", getRootElement(), function()
  deleteKrutonObd()
  createKrutonScreen()
end)
local selectedKrutonVeh = false
addEvent("finalDeleteKrutonObdCodes", false)
addEventHandler("finalDeleteKrutonObdCodes", getRootElement(), function()
  if not isElement(selectedKrutonVeh) then
    createKrutonObd()
    return
  end
  if isTimer(krutonTimer) then
    killTimer(krutonTimer)
  end
  krutonTimer = false
  playSound("files/beep1.mp3")
  if krutonObdBg then
    sightexports.sGui:deleteGuiElement(krutonObdBg)
  end
  local panelWidth = 1000
  local panelHeight = 638
  local titleBarHeight = 24
  krutonObdBg = sightexports.sGui:createGuiElement("rectangle", 1, titleBarHeight, panelWidth - 2, panelHeight - titleBarHeight - 1, obdKruton)
  sightexports.sGui:setGuiBackground(krutonObdBg, "solid", "#000000")
  local y = 8
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  local plate = getVehiclePlateText(selectedKrutonVeh) or ""
  local tmp = {}
  plate = split(plate, "-")
  for i = 1, #plate do
    if 1 <= utf8.len(plate[i]) then
      table.insert(tmp, plate[i])
    end
  end
  local plate = table.concat(tmp, "-")
  local model = getElementData(selectedKrutonVeh, "vehicle.customModel") or getElementModel(selectedKrutonVeh)
  sightexports.sGui:setLabelText(label, "> [ " .. sightexports.sVehiclenames:getCustomVehicleName(model) .. " - Rendszám: " .. plate .. " ]")
  y = y + 24
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, ">")
  y = y + 24
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "> Hibakódok törlése...")
  krutonTimer = setTimer(krutonVehModules, math.random(100, 500), 1, "delete", 1)
end)
addEvent("deleteKrutonObdCodes", false)
addEventHandler("deleteKrutonObdCodes", getRootElement(), function()
  if not isElement(selectedKrutonVeh) then
    createKrutonObd()
    return
  end
  if isTimer(krutonTimer) then
    killTimer(krutonTimer)
  end
  krutonTimer = false
  playSound("files/beep1.mp3")
  if krutonObdBg then
    sightexports.sGui:deleteGuiElement(krutonObdBg)
  end
  local panelWidth = 1000
  local panelHeight = 638
  local titleBarHeight = 24
  krutonObdBg = sightexports.sGui:createGuiElement("rectangle", 1, titleBarHeight, panelWidth - 2, panelHeight - titleBarHeight - 1, obdKruton)
  sightexports.sGui:setGuiBackground(krutonObdBg, "solid", "#000000")
  local y = 8
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  local plate = getVehiclePlateText(selectedKrutonVeh) or ""
  local tmp = {}
  plate = split(plate, "-")
  for i = 1, #plate do
    if 1 <= utf8.len(plate[i]) then
      table.insert(tmp, plate[i])
    end
  end
  local plate = table.concat(tmp, "-")
  local model = getElementData(selectedKrutonVeh, "vehicle.customModel") or getElementModel(selectedKrutonVeh)
  sightexports.sGui:setLabelText(label, "> [ " .. sightexports.sVehiclenames:getCustomVehicleName(model) .. " - Rendszám: " .. plate .. " ]")
  y = y + 24
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, ">")
  y = y + 24
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "> Biztosan törlöd a hibakódokat?")
  y = y + 24
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, ">")
  y = y + 24
  local rect = sightexports.sGui:createGuiElement("rectangle", 8, y, panelWidth - 2 - 16, 24, krutonObdBg)
  sightexports.sGui:setGuiBackground(rect, "solid", "#000000")
  sightexports.sGui:setGuiHover(rect, "none", false, false, true)
  sightexports.sGui:setGuiHoverable(rect, true)
  sightexports.sGui:setClickEvent(rect, "finalDeleteKrutonObdCodes")
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "> [ Igen ]")
  y = y + 24
  local rect = sightexports.sGui:createGuiElement("rectangle", 8, y, panelWidth - 2 - 16, 24, krutonObdBg)
  sightexports.sGui:setGuiBackground(rect, "solid", "#000000")
  sightexports.sGui:setGuiHover(rect, "none", false, false, true)
  sightexports.sGui:setGuiHoverable(rect, true)
  sightexports.sGui:setClickEvent(rect, "backToKrutonObdLoaded")
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "> [ Nem ]")
end)
local krutonCodes = {}
function krutonVehLoaded()
  if not isElement(selectedKrutonVeh) then
    createKrutonObd()
    return
  end
  if isTimer(krutonTimer) then
    killTimer(krutonTimer)
  end
  krutonTimer = false
  playSound("files/beep1.mp3")
  if krutonObdBg then
    sightexports.sGui:deleteGuiElement(krutonObdBg)
  end
  local panelWidth = 1000
  local panelHeight = 638
  local titleBarHeight = 24
  krutonObdBg = sightexports.sGui:createGuiElement("rectangle", 1, titleBarHeight, panelWidth - 2, panelHeight - titleBarHeight - 1, obdKruton)
  sightexports.sGui:setGuiBackground(krutonObdBg, "solid", "#000000")
  local y = 8
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  local plate = getVehiclePlateText(selectedKrutonVeh) or ""
  local tmp = {}
  plate = split(plate, "-")
  for i = 1, #plate do
    if 1 <= utf8.len(plate[i]) then
      table.insert(tmp, plate[i])
    end
  end
  local plate = table.concat(tmp, "-")
  local model = getElementData(selectedKrutonVeh, "vehicle.customModel") or getElementModel(selectedKrutonVeh)
  sightexports.sGui:setLabelText(label, "> [ " .. sightexports.sVehiclenames:getCustomVehicleName(model) .. " - Rendszám: " .. plate .. " ]")
  y = y + 24
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, ">")
  y = y + 24
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "> Hibakódok:")
  y = y + 24
  for i = 1, #krutonCodes do
    local code = krutonCodes[i] or 0
    local id = tostring(code)
    for j = utf8.len(id), 5 do
      id = "0" .. id
    end
    local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
    sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
    sightexports.sGui:setLabelColor(label, "#a1a1a1")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "> " .. ((faultCodes[code] and faultCodes[code].prefix or "P") .. id) .. " - " .. (faultCodes[code] and faultCodes[code].name or "N/A"))
    y = y + 24
  end
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, ">")
  y = y + 24
  local rect = sightexports.sGui:createGuiElement("rectangle", 8, y, panelWidth - 2 - 16, 24, krutonObdBg)
  sightexports.sGui:setGuiBackground(rect, "solid", "#000000")
  sightexports.sGui:setGuiHover(rect, "none", false, false, true)
  sightexports.sGui:setGuiHoverable(rect, true)
  sightexports.sGui:setClickEvent(rect, "deleteKrutonObdCodes")
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "> [ Hibakódok törlése ]")
  y = y + 24
  local rect = sightexports.sGui:createGuiElement("rectangle", 8, y, panelWidth - 2 - 16, 24, krutonObdBg)
  sightexports.sGui:setGuiBackground(rect, "solid", "#000000")
  sightexports.sGui:setGuiHover(rect, "none", false, false, true)
  sightexports.sGui:setGuiHoverable(rect, true)
  sightexports.sGui:setClickEvent(rect, "createKrutonObd")
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "> [ Vissza ]")
  y = y + 24
end
addEvent("backToKrutonObdLoaded", false)
addEventHandler("backToKrutonObdLoaded", getRootElement(), krutonVehLoaded)
function krutonVehModules(text, i)
  if not isElement(selectedKrutonVeh) then
    createKrutonObd()
    return
  end
  if i == 9 then
    if text == "delete" then
      triggerServerEvent("deleteVehicleErrorCodes", localPlayer, selectedKrutonVeh)
      createKrutonObd()
    else
      krutonCodes = {}
      triggerServerEvent("readVehicleErrorCodes", localPlayer, selectedKrutonVeh)
    end
  else
    playSound("files/beep1.mp3")
    local mod = ""
    if i == 1 then
      mod = "EM"
    elseif i == 2 then
      mod = "LM"
    elseif i == 3 then
      mod = "PM"
    elseif i == 4 then
      mod = "CM"
    elseif i == 5 then
      mod = "BM"
    elseif i == 6 then
      mod = "DU"
    elseif i == 7 then
      mod = "SU"
    elseif i == 8 then
      mod = "TM"
    end
    local label = sightexports.sGui:createGuiElement("label", 8, 8 + 24 * (2 + i), 0, 24, krutonObdBg)
    sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
    sightexports.sGui:setLabelColor(label, "#a1a1a1")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    if text == "delete" then
      sightexports.sGui:setLabelText(label, "> Hibakódok törlése, modul: " .. mod)
    else
      sightexports.sGui:setLabelText(label, "> Hibakódok olvasása, modul: " .. mod)
    end
    if i <= 8 then
      krutonTimer = setTimer(krutonVehModules, math.random(100, 500), 1, text, i + 1)
    end
  end
end
local krutonObdButtons = {}
addEvent("selectKrutonOBDVehicle", false)
addEventHandler("selectKrutonOBDVehicle", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  selectedKrutonVeh = krutonObdButtons[el]
  local vx, vy, vz = getElementPosition(selectedKrutonVeh)
  if getDistanceBetweenPoints3D(vx, vy, vz, krutonX, krutonY, krutonZ) > 10 then
    selectedKrutonVeh = false
  end
  if isElement(selectedKrutonVeh) then
    if isTimer(krutonTimer) then
      killTimer(krutonTimer)
    end
    krutonTimer = false
    playSound("files/beep1.mp3")
    if krutonObdBg then
      sightexports.sGui:deleteGuiElement(krutonObdBg)
    end
    local panelWidth = 1000
    local panelHeight = 638
    local titleBarHeight = 24
    krutonObdBg = sightexports.sGui:createGuiElement("rectangle", 1, titleBarHeight, panelWidth - 2, panelHeight - titleBarHeight - 1, obdKruton)
    sightexports.sGui:setGuiBackground(krutonObdBg, "solid", "#000000")
    local y = 8
    local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
    sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
    sightexports.sGui:setLabelColor(label, "#a1a1a1")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    local plate = getVehiclePlateText(selectedKrutonVeh) or ""
    local tmp = {}
    plate = split(plate, "-")
    for i = 1, #plate do
      if 1 <= utf8.len(plate[i]) then
        table.insert(tmp, plate[i])
      end
    end
    local plate = table.concat(tmp, "-")
    local model = getElementData(selectedKrutonVeh, "vehicle.customModel") or getElementModel(selectedKrutonVeh)
    sightexports.sGui:setLabelText(label, "> [ " .. sightexports.sVehiclenames:getCustomVehicleName(model) .. " - Rendszám: " .. plate .. " ]")
    y = y + 24
    local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
    sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
    sightexports.sGui:setLabelColor(label, "#a1a1a1")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, ">")
    y = y + 24
    local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
    sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
    sightexports.sGui:setLabelColor(label, "#a1a1a1")
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "> Csatlakozás a járműhöz...")
    krutonTimer = setTimer(krutonVehModules, math.random(100, 500), 1, "read", 1)
  end
end)
function krutonObdMenuLoaded()
  playSound("files/beep1.mp3")
  local y = 32
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "> OBD Diag 1.0 Ready")
  y = y + 24
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, ">")
  y = y + 24
  local rect = sightexports.sGui:createGuiElement("rectangle", 8, y, panelWidth - 2 - 16, 24, krutonObdBg)
  sightexports.sGui:setGuiBackground(rect, "solid", "#000000")
  sightexports.sGui:setGuiHover(rect, "none", false, false, true)
  sightexports.sGui:setGuiHoverable(rect, true)
  sightexports.sGui:setClickEvent(rect, "createKrutonObd")
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "> [ Menü újratöltése ]")
  y = y + 24
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, ">")
  y = y + 24
  local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "> Válassz járművet:")
  y = y + 24
  krutonObdButtons = {}
  selectedKrutonVeh = false
  local vehs = getElementsByType("vehicle", getRootElement(), true)
  local c = 0
  for i = 1, #vehs do
    local vx, vy, vz = getElementPosition(vehs[i])
    if getDistanceBetweenPoints3D(vx, vy, vz, krutonX, krutonY, krutonZ) < 10 then
      local rect = sightexports.sGui:createGuiElement("rectangle", 8, y, panelWidth - 2 - 16, 24, krutonObdBg)
      sightexports.sGui:setGuiBackground(rect, "solid", "#000000")
      sightexports.sGui:setGuiHover(rect, "none", false, false, true)
      sightexports.sGui:setGuiHoverable(rect, true)
      sightexports.sGui:setClickEvent(rect, "selectKrutonOBDVehicle")
      krutonObdButtons[rect] = vehs[i]
      local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, krutonObdBg)
      sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
      sightexports.sGui:setLabelColor(label, "#a1a1a1")
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      local plate = getVehiclePlateText(vehs[i]) or ""
      local tmp = {}
      plate = split(plate, "-")
      for i = 1, #plate do
        if 1 <= utf8.len(plate[i]) then
          table.insert(tmp, plate[i])
        end
      end
      local plate = table.concat(tmp, "-")
      local model = getElementData(vehs[i], "vehicle.customModel") or getElementModel(vehs[i])
      sightexports.sGui:setLabelText(label, "> [ " .. sightexports.sVehiclenames:getCustomVehicleName(model) .. " - Rendszám: " .. plate .. " ]")
      y = y + 24
      c = c + 1
      if 10 <= c then
        break
      end
    end
  end
end
function createKrutonObd()
  deleteKrutonObd()
  selectedKrutonVeh = false
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  local padding = 4
  local panelWidth = 1000
  local panelHeight = 638
  obdKruton = sightexports.sGui:createGuiElement("rectangle", padding, titleBarHeight + padding, panelWidth, panelHeight, krutonWindow)
  sightexports.sGui:setGuiBackground(obdKruton, "solid", {
    40,
    120,
    170
  })
  local titleBarHeight = 24
  krutonObdBg = sightexports.sGui:createGuiElement("rectangle", 1, titleBarHeight, panelWidth - 2, panelHeight - titleBarHeight - 1, obdKruton)
  sightexports.sGui:setGuiBackground(krutonObdBg, "solid", "#000000")
  local rect = sightexports.sGui:createGuiElement("rectangle", 38, panelHeight, 36, 32, obdKruton)
  sightexports.sGui:setGuiBackground(rect, "solid", {
    40,
    120,
    170
  })
  local logo = sightexports.sGui:createGuiElement("image", 2, 0, 32, 32, rect)
  sightexports.sGui:setImageDDS(logo, ":sMechanic/files/diag.dds")
  if krutonInside then
    sightexports.sGui:deleteGuiElement(krutonInside)
  end
  krutonInside = false
  playSound("files/beep1.mp3")
  local label = sightexports.sGui:createGuiElement("label", 6, 0, 0, titleBarHeight, obdKruton)
  sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
  sightexports.sGui:setLabelText(label, "OBD Diag 1.0")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  local icon = sightexports.sGui:createGuiElement("image", panelWidth - titleBarHeight, 0, titleBarHeight, titleBarHeight, obdKruton)
  sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("times", titleBarHeight, "solid"))
  sightexports.sGui:setImageColor(icon, "#ffffff")
  sightexports.sGui:setGuiHoverable(icon, true)
  sightexports.sGui:setGuiHover(icon, "solid", "sightred")
  sightexports.sGui:setClickEvent(icon, "deleteKrutonObd")
  local label = sightexports.sGui:createGuiElement("label", 8, 8, 0, 24, krutonObdBg)
  sightexports.sGui:setLabelFont(label, "12/Pixellari.ttf")
  sightexports.sGui:setLabelColor(label, "#a1a1a1")
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "> Loading OBD Diag 1.0")
  krutonTimer = setTimer(krutonObdMenuLoaded, math.random(800, 1500), 1)
end
addEvent("createKrutonObd", false)
addEventHandler("createKrutonObd", getRootElement(), createKrutonObd)
screenX, screenY = guiGetScreenSize()
local obdX, obdY = screenX / 2 - 200, screenY / 2 - 200
local movingObd = false
obdState = false
local currentObdMenu = 1
local obdMenus = {}
local obd = false
local obdCodes = {}
function vehicleExit()
  obdState = "connect"
  playSound("files/beep1.mp3")
  createObd()
end
function vehicleEnter()
  sightexports.sChat:localActionC(localPlayer, "csatlakoztatta az OBD scannert az autóhoz.")
  obdState = "main"
  currentObdMenu = 1
  playSound("files/beep1.mp3")
  createObd()
end
addEvent("obdMenuDown", false)
addEventHandler("obdMenuDown", getRootElement(), function()
  if obdState == "codes" then
    if currentObdMenu < #obdCodes then
      playSound("files/beep1.mp3")
      currentObdMenu = currentObdMenu + 1
      refreshCurrentCode()
    end
  elseif obdState == "main" then
    if currentObdMenu < 2 then
      playSound("files/beep1.mp3")
      currentObdMenu = currentObdMenu + 1
      selectObdMenu()
    end
  elseif obdState == "deletecodes" and currentObdMenu < 2 then
    playSound("files/beep1.mp3")
    currentObdMenu = currentObdMenu + 1
    selectObdMenu()
  end
end)
addEvent("obdMenuUp", false)
addEventHandler("obdMenuUp", getRootElement(), function()
  if obdState == "codes" then
    if 1 < currentObdMenu then
      playSound("files/beep1.mp3")
      currentObdMenu = currentObdMenu - 1
      refreshCurrentCode()
    end
  elseif obdState == "main" then
    if 1 < currentObdMenu then
      playSound("files/beep1.mp3")
      currentObdMenu = currentObdMenu - 1
      selectObdMenu()
    end
  elseif obdState == "deletecodes" and 1 < currentObdMenu then
    playSound("files/beep1.mp3")
    currentObdMenu = currentObdMenu - 1
    selectObdMenu()
  end
end)
function readErrorCodes()
  obdCodes = {}
  currentObdMenu = 1
  triggerServerEvent("readVehicleErrorCodes", localPlayer)
end
addEvent("gotVehicleErrorCodes", true)
addEventHandler("gotVehicleErrorCodes", getRootElement(), function(codes)
  if krutonObdBg and selectedKrutonVeh then
    krutonCodes = shuffleTable(codes)
    krutonVehLoaded()
  end
  if obdState == "loadcodes" then
    playSound("files/beep1.mp3")
    obdState = "codes"
    obdCodes = shuffleTable(codes)
    currentObdMenu = 1
    createObd()
  end
end)
function deleteErrorCodes()
  triggerServerEvent("deleteVehicleErrorCodes", localPlayer)
  obdHome()
end
function obdHome()
  playSound("files/beep1.mp3")
  currentObdMenu = 1
  obdState = "main"
  createObd()
end
function obdClickEvent(button, state, cx, cy)
  if state == "down" then
    if cx >= obdX + 85 and cx <= obdX + 315 and cy >= obdY + 9 and cy <= obdY + 381 and (not (cx >= obdX + 140 and cx <= obdX + 260 and cy >= obdY + 210) or not (cy <= obdY + 315)) then
      movingObd = {
        obdX,
        obdY,
        cx,
        cy
      }
    end
  elseif state == "up" then
    movingObd = false
  end
end
addEvent("obdMenuOk", false)
addEventHandler("obdMenuOk", getRootElement(), function()
  if obdState == "deletecodes" then
    if currentObdMenu == 2 then
      playSound("files/beep1.mp3")
      currentObdMenu = 1
      obdState = "deleting"
      local time = math.random(3000, 5000)
      for i = 1, 8 do
        setTimer(loadModule, math.random(500, 2500), 1, i)
      end
      setTimer(deleteErrorCodes, time, 1)
      createObd()
    else
      obdHome()
    end
  elseif obdState == "codes" then
    if #obdCodes <= 0 then
      obdHome()
    end
  elseif obdState == "main" then
    if currentObdMenu == 1 then
      playSound("files/beep1.mp3")
      currentObdMenu = 1
      obdState = "loadcodes"
      local time = math.random(3000, 5000)
      for i = 1, 8 do
        setTimer(loadModule, math.random(500, 2500), 1, i)
      end
      setTimer(readErrorCodes, time, 1)
      createObd()
    elseif currentObdMenu == 2 then
      playSound("files/beep1.mp3")
      currentObdMenu = 1
      obdState = "deletecodes"
      createObd()
    end
  end
end)
addEvent("obdMenuBack", false)
addEventHandler("obdMenuBack", getRootElement(), function()
  if obdState == "codes" or obdState == "deletecodes" then
    obdHome()
  end
end)
function obdCursorMove(rx, ry, cx, cy)
  if movingObd then
    obdX = movingObd[1] + cx - movingObd[3]
    obdY = movingObd[2] + cy - movingObd[4]
    sightexports.sGui:setGuiPosition(obd, obdX, obdY)
  end
end
function openObdState(state)
  if state and not obdState then
    sightexports.sChat:localActionC(localPlayer, "elővett egy OBD scannert.")
    obdState = "connect"
    currentObdMenu = 1
    createObd()
    addEventHandler("onClientPlayerVehicleExit", localPlayer, vehicleExit)
    addEventHandler("onClientPlayerVehicleEnter", localPlayer, vehicleEnter)
    addEventHandler("onClientCursorMove", getRootElement(), obdCursorMove)
    addEventHandler("onClientClick", getRootElement(), obdClickEvent)
  elseif not state and obdState then
    deleteObd()
    obdState = false
    removeEventHandler("onClientPlayerVehicleExit", localPlayer, vehicleExit)
    removeEventHandler("onClientPlayerVehicleEnter", localPlayer, vehicleEnter)
    removeEventHandler("onClientCursorMove", getRootElement(), obdCursorMove)
    removeEventHandler("onClientClick", getRootElement(), obdClickEvent)
    sightexports.sChat:localActionC(localPlayer, "elrakott egy OBD scannert.")
  end
end
function loadModule(id)
  if obdState == "loadcodes" or obdState == "deleting" then
    playSound("files/beep1.mp3")
    sightexports.sGui:setGuiBackground(obdMenus[id][1], "solid", "#063756")
    sightexports.sGui:setLabelColor(obdMenus[id][2], "#bde1f9")
  end
end
function selectObdMenu()
  if obdState == "main" or obdState == "deletecodes" then
    for i = 1, 2 do
      if currentObdMenu == i then
        sightexports.sGui:setGuiBackground(obdMenus[i][1], "solid", "#063756")
        sightexports.sGui:setLabelColor(obdMenus[i][2], "#bde1f9")
      else
        sightexports.sGui:setGuiBackground(obdMenus[i][1], "solid", {
          0,
          0,
          0,
          0
        })
        sightexports.sGui:setLabelColor(obdMenus[i][2], "#063756")
      end
    end
  end
end
function deleteObd()
  if obd then
    sightexports.sGui:deleteGuiElement(obd)
  end
  obd = false
end
function refreshCurrentCode()
  if 0 < #obdCodes then
    local code = obdCodes[currentObdMenu] or 0
    local id = tostring(code)
    for j = utf8.len(id), 5 do
      id = "0" .. id
    end
    sightexports.sGui:setLabelText(obdMenus[1], (faultCodes[code] and faultCodes[code].prefix or "P") .. id)
    sightexports.sGui:setLabelText(obdMenus[2], faultCodes[code] and faultCodes[code].name or "N/A")
    sightexports.sGui:setLabelText(obdMenus[3], currentObdMenu .. "/" .. #obdCodes)
  end
end
function createObd()
  if not isPedInVehicle(localPlayer) then
    if obdState ~= "connect" then
      obdState = "connect"
      playSound("files/beep1.mp3")
    end
  elseif obdState == "connect" then
    sightexports.sChat:localActionC(localPlayer, "csatlakoztatta az OBD scannert az autóhoz.")
    obdHome()
  end
  obdMenus = {}
  deleteObd()
  obd = sightexports.sGui:createGuiElement("image", obdX, obdY, 400, 400)
  sightexports.sGui:setImageDDS(obd, ":sMechanic/files/obd.dds")
  if obdState == "codes" then
    if 0 < #obdCodes then
      local rect = sightexports.sGui:createGuiElement("rectangle", 150, 58, 100, 24, obd)
      sightexports.sGui:setGuiBackground(rect, "solid", "#063756")
      local label = sightexports.sGui:createGuiElement("label", 112, 58, 176, 24, obd)
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#bde1f9")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      obdMenus[1] = label
      local label = sightexports.sGui:createGuiElement("label", 117, 82, 166, 48, obd)
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#063756")
      sightexports.sGui:setLabelWordBreak(label, true)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      obdMenus[2] = label
      local label = sightexports.sGui:createGuiElement("label", 112, 124, 176, 24, obd)
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#063756")
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      obdMenus[3] = label
      refreshCurrentCode()
    else
      local label = sightexports.sGui:createGuiElement("label", 117, 50, 166, 98, obd)
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelText(label, "NEM TALÁLHATÓ HIBAKÓD")
      sightexports.sGui:setLabelColor(label, "#063756")
      sightexports.sGui:setLabelWordBreak(label, true)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
    end
  elseif obdState == "loadcodes" or obdState == "deleting" then
    local rect = sightexports.sGui:createGuiElement("rectangle", 118, 55.5, 32, 24, obd)
    sightexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    local label = sightexports.sGui:createGuiElement("label", 112, 50, 44, 35, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, "EM")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    obdMenus[1] = {rect, label}
    local rect = sightexports.sGui:createGuiElement("rectangle", 162, 55.5, 32, 24, obd)
    sightexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    local label = sightexports.sGui:createGuiElement("label", 156, 50, 44, 35, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, "LM")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    obdMenus[2] = {rect, label}
    local rect = sightexports.sGui:createGuiElement("rectangle", 206, 55.5, 32, 24, obd)
    sightexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    local label = sightexports.sGui:createGuiElement("label", 200, 50, 44, 35, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, "PM")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    obdMenus[3] = {rect, label}
    local rect = sightexports.sGui:createGuiElement("rectangle", 250, 55.5, 32, 24, obd)
    sightexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    local label = sightexports.sGui:createGuiElement("label", 244, 50, 44, 35, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, "CM")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    obdMenus[4] = {rect, label}
    local rect = sightexports.sGui:createGuiElement("rectangle", 118, 90.5, 32, 24, obd)
    sightexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    local label = sightexports.sGui:createGuiElement("label", 112, 85, 44, 35, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, "BM")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    obdMenus[5] = {rect, label}
    local rect = sightexports.sGui:createGuiElement("rectangle", 162, 90.5, 32, 24, obd)
    sightexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    local label = sightexports.sGui:createGuiElement("label", 156, 85, 44, 35, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, "DU")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    obdMenus[6] = {rect, label}
    local rect = sightexports.sGui:createGuiElement("rectangle", 206, 90.5, 32, 24, obd)
    sightexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    local label = sightexports.sGui:createGuiElement("label", 200, 85, 44, 35, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, "SU")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    obdMenus[7] = {rect, label}
    local rect = sightexports.sGui:createGuiElement("rectangle", 250, 90.5, 32, 24, obd)
    sightexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    local label = sightexports.sGui:createGuiElement("label", 244, 85, 44, 35, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, "TM")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    obdMenus[8] = {rect, label}
    local label = sightexports.sGui:createGuiElement("label", 112, 124, 176, 24, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, obdState == "deleting" and "Törlés..." or "Betöltés...")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
  elseif obdState == "deletecodes" then
    local label = sightexports.sGui:createGuiElement("label", 122, 50, 156, 48, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, "Biztosan törlöd a hibakódokat?")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelWordBreak(label, true)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    local rect = sightexports.sGui:createGuiElement("rectangle", 122, 98, 156, 24, obd)
    sightexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    local label = sightexports.sGui:createGuiElement("label", 112, 98, 176, 24, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, "NEM")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    obdMenus[1] = {rect, label}
    local rect = sightexports.sGui:createGuiElement("rectangle", 122, 122, 156, 24, obd)
    sightexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    local label = sightexports.sGui:createGuiElement("label", 112, 122, 176, 24, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, "IGEN")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    obdMenus[2] = {rect, label}
    selectObdMenu()
  elseif obdState == "main" then
    local rect = sightexports.sGui:createGuiElement("rectangle", 122, 75, 156, 24, obd)
    sightexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    local label = sightexports.sGui:createGuiElement("label", 112, 75, 176, 24, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, "Hibakód olvasás")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    obdMenus[1] = {rect, label}
    local rect = sightexports.sGui:createGuiElement("rectangle", 122, 99, 156, 24, obd)
    sightexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    local label = sightexports.sGui:createGuiElement("label", 112, 99, 176, 24, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, "Hibakód törlés")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    obdMenus[2] = {rect, label}
    selectObdMenu()
  elseif obdState == "connect" then
    local label = sightexports.sGui:createGuiElement("label", 112, 50, 176, 98, obd)
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelText(label, "Csatlakoztass egy\njárművet!")
    sightexports.sGui:setLabelColor(label, "#063756")
    sightexports.sGui:setLabelAlignment(label, "center", "center")
  end
  local btn = sightexports.sGui:createGuiElement("button", 187, 218, 27, 28, obd)
  sightexports.sGui:setGuiBackground(btn, "solid", {
    0,
    0,
    0,
    0
  })
  sightexports.sGui:setGuiHover(btn, "none", false, false, true)
  sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
  sightexports.sGui:setClickEvent(btn, "obdMenuUp")
  local btn = sightexports.sGui:createGuiElement("button", 187, 282, 27, 28, obd)
  sightexports.sGui:setGuiBackground(btn, "solid", {
    0,
    0,
    0,
    0
  })
  sightexports.sGui:setGuiHover(btn, "none", false, false, true)
  sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
  sightexports.sGui:setClickEvent(btn, "obdMenuDown")
  local btn = sightexports.sGui:createGuiElement("button", 171, 250, 27, 28, obd)
  sightexports.sGui:setGuiBackground(btn, "solid", {
    0,
    0,
    0,
    0
  })
  sightexports.sGui:setGuiHover(btn, "none", false, false, true)
  sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
  sightexports.sGui:setClickEvent(btn, "obdMenuBack")
  local btn = sightexports.sGui:createGuiElement("button", 202, 250, 27, 28, obd)
  sightexports.sGui:setGuiBackground(btn, "solid", {
    0,
    0,
    0,
    0
  })
  sightexports.sGui:setGuiHover(btn, "none", false, false, true)
  sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
  sightexports.sGui:setClickEvent(btn, "obdMenuOk")
end
