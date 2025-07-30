local sightexports = {
  sRadar = false,
  sHud = false,
  sGui = false,
  sGroups = false
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
local ocr = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    ocr = sightexports.sGui:getFont("15/W95FA.otf")
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local addData = {
  0,
  0,
  0
}
local currentVehicleElement
local vision = 1
local visions = {
  "normal",
  "thermalvision",
  "nightvision"
}
local visionText = {
  "NORMAL",
  "INFRA",
  "NIGHT"
}
local screenX, screenY = guiGetScreenSize()
local addedVehicles = {}
function round(num, numDecimalPlaces)
  local mult = 10 ^ (numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end
function heliPreRender(delta)
  local xC, yC = getCursorPosition()
  local diffX, diffY = xC - 0.5, yC - 0.5
  setCursorPosition(screenX / 2, screenY / 2)
  delta = delta / 10
  local distR, distR2 = addData[1], addData[2]
  if getKeyState("lshift") then
    delta = delta * 2
  elseif getKeyState("lalt") then
    delta = delta / 2
  end
  if not isConsoleActive() then
    if getKeyState("a") then
      if distR <= 180 then
        addData[1] = addData[1] + 0.75 * delta
      end
    elseif getKeyState("d") and -180 <= distR then
      addData[1] = addData[1] - 0.75 * delta
    end
    if getKeyState("w") then
      if distR2 <= 180 then
        addData[2] = addData[2] + 1 * delta
      end
    elseif getKeyState("s") and -180 <= distR2 then
      addData[2] = addData[2] - 1 * delta
    end
    if getKeyState("q") then
      if zoom < 4 then
        addData[3] = addData[3] + 0.01 * delta
      end
    elseif getKeyState("e") and zoom > 0 then
      addData[3] = addData[3] - 0.01 * delta
    end
  end
  addData[1] = addData[1] - delta * 32 * diffX
  addData[2] = addData[2] - delta * 40 * diffY
end
function heliRender(delta)
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh then
    local x, y, z = getElementPosition(veh)
    z = z - 1.3
    local vrx, vry, vrz = getElementRotation(veh)
    local r, r2 = vrz + addData[1], vrx + addData[2]
    local zoom = 0 + addData[3]
    local xC, yC = getCursorPosition()
    local diffX, diffY = xC - 0.5, yC - 0.5
    setCursorPosition(screenX / 2, screenY / 2)
    addData[1] = math.min(180, math.max(-180, addData[1]))
    addData[2] = math.min(180, math.max(-180, addData[2]))
    local centerX = 0
    local centerY = 0
    local pointX = 1
    local pointY = 0
    local angle = math.rad(r)
    local drawX = centerX + (pointX - centerX) * math.cos(angle) - (pointY - centerY) * math.sin(angle)
    local drawY = centerY + (pointX - centerX) * math.sin(angle) + (pointY - centerY) * math.cos(angle)
    local centerX = 0
    local centerY = 0
    local pointX = 0
    local pointY = 1
    local angle = math.rad(r2)
    local drawX2 = centerX + (pointX - centerX) * math.cos(angle) - (pointY - centerY) * math.sin(angle)
    local drawY2 = centerY + (pointX - centerX) * math.sin(angle) + (pointY - centerY) * math.cos(angle)
    setCameraMatrix(x, y, z, x + drawX + drawX * drawX2, y + drawY + drawY * drawX2, z + drawY2, 0, 70 - 5 * zoom)
    local realTime = getRealTime()
    local month = realTime.month + 1
    if 2 > utf8.len(month) then
      month = "0" .. month
    end
    local day = realTime.monthday
    if 2 > utf8.len(day) then
      day = "0" .. day
    end
    local hour = realTime.hour
    if 2 > utf8.len(hour) then
      hour = "0" .. hour
    end
    local minute = realTime.minute
    if 2 > utf8.len(minute) then
      minute = "0" .. minute
    end
    local second = realTime.second
    if 2 > utf8.len(second) then
      second = "0" .. second
    end
    local date = realTime.year + 1900 .. "." .. month .. "." .. day .. "\n" .. hour .. ":" .. minute .. ":" .. second
    date = date .. [[

VISION: ]] .. visionText[vision]
    dxDrawText(date, 15, 15, 0, 0, tocolor(255, 255, 255, 255), 1, ocr, "left", "top", false, false, false, true)
    local groundZ = getGroundPosition(x, y, z)
    if groundZ then
      local zone = sightexports.sRadar:getZoneName(x, y, z)
      local height = z - groundZ
      height = round(height, 2)
      local fHeight = dxGetFontHeight(1, ocr) + 15
      vrx = round(vrx, 2)
      local text = "ZONE: " .. zone .. "\n" .. "HEADING: " .. vrx .. "°\nHEIGHT: " .. height .. "m"
      local width = dxGetTextWidth(text, 1, ocr)
      dxDrawText(text, screenX - width - 15, screenY - fHeight * 2 - 15, 0, 0, tocolor(255, 255, 255, 255), 1, ocr, "left", "top", false, false, false, true)
    end
    local r, g, b = 255, 255, 255
    local tx, ty, tz = getWorldFromScreenPosition(screenX / 2, screenY / 2, 100)
    if tx then
      local hit, hitX, hitY, hitZ, element = processLineOfSight(x, y, z, tx, ty, tz, false, true, false, false, false, true, false, true)
      if hit and element ~= veh then
        local plate = getVehiclePlateText(element)
        currentVehicleElement = element
        if plate then
          local tmp = {}
          local plate = split(plate, "-")
          for i = 1, #plate do
            if 1 <= utf8.len(plate[i]) then
              table.insert(tmp, plate[i])
            end
          end
          plate = "Rendszám: " .. table.concat(tmp, "-")
          local width = dxGetTextWidth(plate, 1, ocr) + 15
          if addedVehicles[element] then
            r, g, b = 215, 89, 89
          end
          dxDrawText(plate, 0, screenY / 2 + 32 + 8, screenX, screenY, tocolor(r, g, b), 1, ocr, "center", "top", false, false, false, true)
          dxDrawImage(screenX / 2 - 32, screenY / 2 - 32, 64, 64, "pointer.png", 0, 0, 0, tocolor(r, g, b))
        else
          dxDrawImage(screenX / 2 - 32, screenY / 2 - 32, 64, 64, "pointer.png", 0, 0, 0, tocolor(r, g, b))
        end
      else
        dxDrawImage(screenX / 2 - 32, screenY / 2 - 32, 64, 64, "pointer.png", 0, 0, 0, tocolor(r, g, b))
        currentVehicleElement = false
      end
    end
  end
end
local heliMode = false
bindKey("v", "down", function()
  if heliMode then
    if #visions >= vision + 1 then
      vision = vision + 1
    else
      vision = 1
    end
    setCameraGoggleEffect(visions[vision])
  end
end)
bindKey("e", "down", function()
  if heliMode and currentVehicleElement and not addedVehicles[currentVehicleElement] then
    triggerServerEvent("addCarBlip", currentVehicleElement)
  end
end)
addCommandHandler("helicam", function()
  local veh = getPedOccupiedVehicle(localPlayer)
  local seat = getPedOccupiedVehicleSeat(localPlayer)
  if veh and getElementModel(veh) == 497 then
    if seat == 1 then
      heliMode = not heliMode
      if heliMode then
        vision = 2
        setCameraGoggleEffect("thermalvision", false)
        addEventHandler("onClientRender", getRootElement(), heliRender)
        addEventHandler("onClientPreRender", getRootElement(), heliPreRender)
        sightexports.sHud:setHudEnabled(false, 0)
        showChat(false)
        sightexports.sGui:setCursorType("none")
        showCursor(true)
      else
        removeEventHandler("onClientRender", getRootElement(), heliRender)
        removeEventHandler("onClientPreRender", getRootElement(), heliPreRender)
        vision = 1
        setCameraGoggleEffect("normal", false)
        setCameraTarget(localPlayer)
        showChat(true)
        sightexports.sHud:setHudEnabled(true, 0)
        sightexports.sGui:setCursorType("normal")
        showCursor(false)
      end
    else
      sightexports.sGui:showInfobox("e", "Csak a jobb-első ülésről használható!")
    end
  else
    sightexports.sGui:showInfobox("e", "Nem ülsz helikopterben!")
  end
end)
function disableHelicam()
  if heliMode then
    heliMode = false
    removeEventHandler("onClientRender", getRootElement(), heliRender)
    removeEventHandler("onClientPreRender", getRootElement(), heliPreRender)
    setCameraGoggleEffect("normal", false)
    setCameraTarget(localPlayer)
    sightexports.sHud:setHudEnabled(true, 0)
    showChat(true)
    vision = 1
    sightexports.sGui:setCursorType("normal")
    showCursor(false)
  end
end
addEventHandler("onClientPlayerWasted", localPlayer, disableHelicam)
addEventHandler("onClientPlayerVehicleExit", localPlayer, disableHelicam)
bindKey("backspace", "down", disableHelicam)
function getCarBlip()
  if sightexports.sGroups:getPlayerPermission("mdc") then
    local x, y, z = getElementPosition(source)
    local blip = createBlip(x, y, z, 0, 2, 215, 89, 89)
    attachElements(blip, source)
    local plate = getVehiclePlateText(source)
    local tmp = {}
    plate = split(plate, "-")
    for i = 1, #plate do
      if 1 <= utf8.len(plate[i]) then
        table.insert(tmp, plate[i])
      end
    end
    plate = table.concat(tmp, "-")
    setElementData(blip, "tooltipText", "Megjelölt jármű: " .. plate)
    addedVehicles[source] = true
    setTimer(destroyElement, 20000, 1, blip)
    setTimer(function(source)
      addedVehicles[source] = nil
    end, 20000, 1, source)
  end
end
addEvent("getCarBlip", true)
addEventHandler("getCarBlip", getRootElement(), getCarBlip)
