local sightexports = {sGui = false, sPawn = false}
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
local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processsightlangStaticImage = {}
sightlangStaticImageToc[0] = true
sightlangStaticImageToc[1] = true
sightlangStaticImageToc[2] = true
local sightlangStatImgPre
function sightlangStatImgPre()
  local now = getTickCount()
  if sightlangStaticImageUsed[0] then
    sightlangStaticImageUsed[0] = false
    sightlangStaticImageDel[0] = false
  elseif sightlangStaticImage[0] then
    if sightlangStaticImageDel[0] then
      if now >= sightlangStaticImageDel[0] then
        if isElement(sightlangStaticImage[0]) then
          destroyElement(sightlangStaticImage[0])
        end
        sightlangStaticImage[0] = nil
        sightlangStaticImageDel[0] = false
        sightlangStaticImageToc[0] = true
        return
      end
    else
      sightlangStaticImageDel[0] = now + 5000
    end
  else
    sightlangStaticImageToc[0] = true
  end
  if sightlangStaticImageUsed[1] then
    sightlangStaticImageUsed[1] = false
    sightlangStaticImageDel[1] = false
  elseif sightlangStaticImage[1] then
    if sightlangStaticImageDel[1] then
      if now >= sightlangStaticImageDel[1] then
        if isElement(sightlangStaticImage[1]) then
          destroyElement(sightlangStaticImage[1])
        end
        sightlangStaticImage[1] = nil
        sightlangStaticImageDel[1] = false
        sightlangStaticImageToc[1] = true
        return
      end
    else
      sightlangStaticImageDel[1] = now + 5000
    end
  else
    sightlangStaticImageToc[1] = true
  end
  if sightlangStaticImageUsed[2] then
    sightlangStaticImageUsed[2] = false
    sightlangStaticImageDel[2] = false
  elseif sightlangStaticImage[2] then
    if sightlangStaticImageDel[2] then
      if now >= sightlangStaticImageDel[2] then
        if isElement(sightlangStaticImage[2]) then
          destroyElement(sightlangStaticImage[2])
        end
        sightlangStaticImage[2] = nil
        sightlangStaticImageDel[2] = false
        sightlangStaticImageToc[2] = true
        return
      end
    else
      sightlangStaticImageDel[2] = now + 5000
    end
  else
    sightlangStaticImageToc[2] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/pda.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/pdahack.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/7seg.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local x, y = screenX / 2, screenY / 2
local generatedCode = false
local securicarTimer = false
local securicarStolen = false
local setDigits = {}
local currentDigit = 1
local randomDigit = 0
local nextRandomDigit = 0
local securicarLocked = true
local securicarGPS = true
local trackerBlips = {}
local trackerData = {}
local lastTrackerData = {}
local pdaHover = false
local movingPdaX, movingPdaY
local veh = false
addEventHandler("onClientElementDestroy", getRootElement(), function()
  lastTrackerData[source] = nil
  trackerData[source] = nil
  if isElement(trackerBlips[source]) then
    destroyElement(trackerBlips[source])
  end
  trackerBlips[source] = nil
end)
addEvent("gotSecuricarTrackerData", true)
addEventHandler("gotSecuricarTrackerData", getRootElement(), function(veh, data, delta)
  trackerData[veh] = data
  if data and data[4] then
    lastTrackerData[veh] = getTickCount() - (delta or 0)
  end
  if not data and isElement(trackerBlips[veh]) then
    destroyElement(trackerBlips[veh])
    trackerBlips[veh] = nil
  elseif data and inPolice then
    local x, y, z, live = unpack(data)
    x, y = getTrackerPos(x, y)
    local col = live and sightorange or sightred
    if not isElement(trackerBlips[veh]) then
      trackerBlips[veh] = createBlip(x, y, z, 12, 2, col[1], col[2], col[3])
      setElementData(trackerBlips[veh], "tooltipText", "Pénzszállító jeladó (" .. (live and "ONLINE" or "OFFLINE") .. ")")
    else
      setElementPosition(trackerBlips[veh], x, y, z)
      setBlipColor(trackerBlips[veh], col[1], col[2], col[3], 255)
      setElementData(trackerBlips[veh], "tooltipText", "Pénzszállító jeladó (" .. (live and "ONLINE" or "OFFLINE") .. ")")
    end
  end
end)
function getTrackerPos(x, y)
  local r = math.rad(math.pi * 2 * math.random())
  local d = math.random(0, 675) / 10
  return x + math.cos(r) * d, y + math.sin(r) * d
end
function refreshTrackerBlips()
  if inPolice then
    for veh, data in pairs(trackerData) do
      local x, y, z, live = unpack(data)
      x, y = getTrackerPos(x, y)
      local col = live and sightorange or sightred
      if not isElement(trackerBlips[veh]) then
        trackerBlips[veh] = createBlip(x, y, z, 12, 2, col[1], col[2], col[3])
        setElementData(trackerBlips[veh], "tooltipText", "Pénzszállító jeladó (" .. (live and "ONLINE" or "OFFLINE") .. ")")
      else
        setElementPosition(trackerBlips[veh], x, y, z)
        setBlipColor(trackerBlips[veh], col[1], col[2], col[3], 255)
        setElementData(trackerBlips[veh], "tooltipText", "Pénzszállító jeladó (" .. (live and "ONLINE" or "OFFLINE") .. ")")
      end
    end
  else
    for veh in pairs(trackerBlips) do
      if isElement(trackerBlips[veh]) then
        destroyElement(trackerBlips[veh])
      end
      trackerBlips[veh] = nil
    end
  end
end
addEvent("securiCarSetCurrentDigit", true)
addEventHandler("securiCarSetCurrentDigit", getRootElement(), function(v, digit)
  if v == veh then
    currentDigit = digit
  end
end)
addEvent("securiCarSetDigit", true)
addEventHandler("securiCarSetDigit", getRootElement(), function(v, digit, val)
  if v == veh and setDigits then
    setDigits[digit] = val
  end
end)
function clickPDA(btn, state)
  if state == "down" and generatedCode then
    if pdaHover == 1 then
      currentDigit = currentDigit - 1
      if currentDigit < 1 then
        currentDigit = 4
      end
      triggerServerEvent("securiCarSetCurrentDigit", localPlayer, currentDigit)
    elseif pdaHover == 2 then
      currentDigit = currentDigit + 1
      if 4 < currentDigit then
        currentDigit = 1
      end
      triggerServerEvent("securiCarSetCurrentDigit", localPlayer, currentDigit)
    elseif pdaHover == 3 then
      if setDigits[currentDigit] then
        setDigits[currentDigit] = false
      else
        setDigits[currentDigit] = randomDigit
      end
      triggerServerEvent("securiCarSetDigit", localPlayer, currentDigit, setDigits[currentDigit])
    end
  end
end
function renderPDA()
  if getPedOccupiedVehicle(localPlayer) ~= veh then
    removeEventHandler("onClientClick", getRootElement(), clickPDA)
    removeEventHandler("onClientRender", getRootElement(), renderPDA)
    veh = false
    generatedCode = false
    deleteDealBlips()
    return
  end
  local now = getTickCount()
  local tmp = false
  local cx, cy = getCursorPosition()
  if cx then
    cx = cx * screenX
    cy = cy * screenY
    if movingPdaX then
      if getKeyState("mouse1") then
        x = math.min(screenX - 150, math.max(150, cx - movingPdaX))
        y = math.min(screenY - 236, math.max(236, cy - movingPdaY))
      else
        movingPdaX = false
        movingPdaY = false
      end
    elseif cx >= x - 32 and cy >= y + 172 - 16 and cx <= x + 32 and cy <= y + 172 + 16 then
      tmp = 3
    elseif cx >= x - 82 - 19 and cy >= y + 172 - 10 and cx <= x - 82 + 19 and cy <= y + 172 + 10 then
      tmp = 1
    elseif cx >= x + 82 - 19 and cy >= y + 172 - 10 and cx <= x + 82 + 19 and cy <= y + 172 + 10 then
      tmp = 2
    elseif getKeyState("mouse1") then
      movingPdaX = cx - x
      movingPdaY = cy - y
    end
  else
    movingPdaX = false
    movingPdaY = false
  end
  if pdaHover ~= tmp then
    pdaHover = tmp
    sightexports.sGui:setCursorType(tmp and "link" or "normal")
  end
  sightlangStaticImageUsed[0] = true
  if sightlangStaticImageToc[0] then
    processsightlangStaticImage[0]()
  end
  dxDrawImage(x - 150, y - 236, 300, 472, sightlangStaticImage[0])
  local d = getElementDimension(veh)
  local text = 0 < d and "NO SIGNAL" or "GPS: OK, GPRS: OK"
  local icon = 0 < d and noSignalIcon or signalIcon
  local tw = dxGetTextWidth(text, lcdFontScale * 1, lcdFont) + 24 + 6
  dxDrawImage(x - tw / 2, y - 113.5 - 12, 24, 24, ":sGui/" .. icon .. faTicks[icon], 0, 0, 0, tocolor(49, 76, 50))
  dxDrawText(text, x - tw / 2 + 24 + 6, y - 126, 0, y - 101, tocolor(49, 76, 50), lcdFontScale * 1, lcdFont, "left", "center")
  if lastTrackerData[veh] then
    local secs = math.max(0, math.floor((now - lastTrackerData[veh]) / 1000))
    if secs < 3 then
      dxDrawText("Utolsó jel: az imént", x, y - 101, x, y - 76, tocolor(49, 76, 50), lcdFontScale * 1, lcdFont, "center", "center")
    else
      local hour = math.floor(secs / 3600)
      local min = math.floor(secs / 60) - hour * 60
      secs = secs - min * 60 - hour * 3600
      dxDrawText("Utolsó jel: " .. string.format("%02d:%02d:%02d", hour, min, secs), x, y - 101, x, y - 76, tocolor(49, 76, 50), lcdFontScale * 1, lcdFont, "center", "center")
    end
  else
    dxDrawText("Utolsó jel: nem volt", x, y - 101, x, y - 76, tocolor(49, 76, 50), lcdFontScale * 1, lcdFont, "center", "center")
  end
  if securicarStolen then
    local secs = math.max(0, math.floor((now - securicarStolen) / 1000))
    local hour = math.floor(secs / 3600)
    local min = math.floor(secs / 60) - hour * 60
    secs = secs - min * 60 - hour * 3600
    dxDrawText(string.format("%02d:%02d:%02d", hour, min, secs), 0, 0, x + 94, y - 150, tocolor(49, 76, 50), lcdFontScale * 0.75, lcdFont, "right", "bottom")
  else
    dxDrawText("--:--:--", 0, 0, x + 94, y - 150, tocolor(49, 76, 50), lcdFontScale * 0.75, lcdFont, "right", "bottom")
  end
  dxDrawText("Nyomkövetés " .. (securicarGPS and "aktív" or "inaktív"), x, y - 68, x, y - 48, tocolor(49, 76, 50), lcdFontScale * 1, lcdFont, "center", "center")
  if securicarTimer then
    local secs = math.max(0, math.floor((securicarTimer - now) / 1000))
    local min = math.floor(secs / 60)
    secs = secs - min * 60
    dxDrawText(string.format("%02d:%02d", min, secs), x, y - 48, x, y + 12, tocolor(49, 76, 50), lcdFontScale * 2.5, lcdFont, "center", "center")
  else
    dxDrawText("--:--", x, y - 48, x, y + 12, tocolor(49, 76, 50), lcdFontScale * 2.5, lcdFont, "center", "center")
  end
  if generatedCode then
    if 0 < now - nextRandomDigit then
      nextRandomDigit = now + 300 + 100 * math.random()
      randomDigit = math.random(0, 9)
    end
    for i = 1, 4 do
      local cx = x - 60 + (i - 1) * 32
      if i == currentDigit then
        if setDigits[i] then
          drawBorder(cx, y + 77 - 16, 24, 32, 4, tocolor(49, 76, 50))
          dxDrawText(setDigits[i], cx, y + 77, cx + 24, y + 77, tocolor(49, 76, 50), lcdFontScale * 1.5, lcdFont, "center", "center")
        else
          dxDrawRectangle(cx, y + 77 - 16, 24, 32, tocolor(49, 76, 50))
          dxDrawText(randomDigit, cx, y + 77, cx + 24, y + 77, tocolor(91, 122, 86), lcdFontScale * 1.5, lcdFont, "center", "center")
        end
      elseif setDigits[i] then
        drawBorder(cx, y + 77 - 16, 24, 32, 2, tocolor(49, 76, 50))
        dxDrawText(setDigits[i], cx, y + 77, cx + 24, y + 77, tocolor(49, 76, 50), lcdFontScale * 1.5, lcdFont, "center", "center")
      else
        drawBorder(cx, y + 77 - 16, 24, 32, 2, tocolor(49, 76, 50))
        dxDrawText("?", cx, y + 77, cx + 24, y + 77, tocolor(49, 76, 50), lcdFontScale * 1.5, lcdFont, "center", "center")
      end
    end
    local hx, hy = x - 71 - 128, y + 135 - 64
    sightlangStaticImageUsed[1] = true
    if sightlangStaticImageToc[1] then
      processsightlangStaticImage[1]()
    end
    dxDrawImage(hx, hy, 256, 128, sightlangStaticImage[1])
    local i = math.floor(getTickCount() / 25)
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImageSection(hx + 78, hy + 53, 24, 24, generatedCode[1] * 24, (i + 1) % 9 * 24, 24, 24, sightlangStaticImage[2], 0, 0, 0, tocolor(200, 10, 10))
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImageSection(hx + 107, hy + 53, 24, 24, generatedCode[2] * 24, (i + 2) % 9 * 24, 24, 24, sightlangStaticImage[2], 0, 0, 0, tocolor(200, 10, 10))
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImageSection(hx + 136, hy + 53, 24, 24, generatedCode[3] * 24, (i + 3) % 9 * 24, 24, 24, sightlangStaticImage[2], 0, 0, 0, tocolor(200, 10, 10))
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImageSection(hx + 165, hy + 53, 24, 24, generatedCode[4] * 24, (i + 4) % 9 * 24, 24, 24, sightlangStaticImage[2], 0, 0, 0, tocolor(200, 10, 10))
  else
    local icon = not (not securicarGPS and securicarTimer) and lockIcon or unLockIcon
    dxDrawImage(x - 16, y + 77 - 16, 32, 32, ":sGui/" .. icon .. faTicks[icon], 0, 0, 0, tocolor(49, 76, 50))
  end
end
local dealBlips = {}
function deleteDealBlips()
  for i = 1, #dealBlips do
    if isElement(dealBlips[i]) then
      destroyElement(dealBlips[i])
    end
    dealBlips[i] = nil
  end
end
function createDealBlips()
  deleteDealBlips()
  local dealPoses = sightexports.sPawn:getGoldSellPoses()
  for i = 1, #dealPoses do
    dealBlips[i] = createBlip(dealPoses[i][1], dealPoses[i][2], dealPoses[i][3], 16, 2, sightyellow[1], sightyellow[2], sightyellow[3])
    setElementData(dealBlips[i], "tooltipText", "Illegális aranyfelvásárlás")
  end
end
addEvent("openSecuricarPDA", true)
addEventHandler("openSecuricarPDA", getRootElement(), function(v, code, gps, stolen, timer, digs, dig)
  if isElement(v) then
    if not veh then
      addEventHandler("onClientClick", getRootElement(), clickPDA)
      addEventHandler("onClientRender", getRootElement(), renderPDA)
      createDealBlips()
    end
    if code and not generatedCode then
      sightexports.sGui:showInfobox("i", "Használd a PDA alsó gombjait a nyomkövető feltöréséhez.")
      sightexports.sGui:showInfobox("i", "A PDA képernyőjén lévő számsornak meg kell egyeznie az alsó piros számsorral.")
    end
    veh = v
    generatedCode = code
    securicarGPS = gps
    securicarTimer = timer and getTickCount() + timer or false
    securicarStolen = stolen and getTickCount() - stolen or false
    setDigits = digs
    currentDigit = dig
  end
end)
