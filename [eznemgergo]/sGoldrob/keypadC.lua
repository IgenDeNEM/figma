local sightexports = {sGui = false}
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
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/circle.dds", "dxt1", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture(":v4_goldrob/files/keypad.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local red = false
local green = false
local orange = false
local blue = false
local grey1 = false
local timerFont = false
local timerFontScale = false
local lcdFont = false
local lcdFontScale = false
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    red = sightexports.sGui:getColorCode("sightred")
    green = sightexports.sGui:getColorCode("sightgreen")
    orange = sightexports.sGui:getColorCode("sightorange")
    blue = sightexports.sGui:getColorCode("sightblue")
    grey1 = sightexports.sGui:getColorCode("sightgrey1")
    timerFont = sightexports.sGui:getFont("45/BebasNeueRegular.otf")
    timerFontScale = sightexports.sGui:getFontScale("45/BebasNeueRegular.otf")
    lcdFont = sightexports.sGui:getFont("11/W95FA.otf")
    lcdFontScale = sightexports.sGui:getFontScale("11/W95FA.otf")
    faTicks = sightexports.sGui:getFaTicks()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
local screenX, screenY = guiGetScreenSize()
local mgState = false
local mgBgColor = false
local iconColor = false
local mgIcon = false
local mgX, mgY = 0, 0
local targetMgX, targetMgY = 0, 0
local mgSize = 1
local targetMgSize = 1
local nextRandomPos = 0
local moveSpeed = 0
local targetMoveSpeed = 50
local untilStart = 6000
local mouseX, mouseY = 0, 0
local x, y = screenX / 2, screenY - 128 - 200 - 32
local mgProgress = 0.25
local mgProgressSpeed = 0.1
local mgSpeed = 0
local mgDistances = {
  32,
  48,
  72,
  108,
  350
}
local pulseSound = false
local greenSound = false
local pulseVolume = 0
local targetPulseVolume = 0
local pulseSpeed = 1
local targetPulseSpeed = 1
local tmpSecs = false
function startMinigame(name, bgc, icon, iconc, ts, gs, os, ms, time, keypad)
  if mgState then
    triggerEvent("endCircleMinigame", localPlayer, mgState, false)
  end
  if isElement(pulseSound) then
    destroyElement(pulseSound)
  end
  if isElement(greenSound) then
    destroyElement(greenSound)
  end
  pulseSound = playSound("files/pulse.mp3", true)
  setSoundVolume(pulseSound, 0)
  greenSound = playSound("files/green.wav", true)
  setSoundVolume(greenSound, 0)
  tmpSecs = false
  pulseVolume = 0
  targetPulseVolume = 0
  pulseSpeed = 1
  targetPulseSpeed = 1
  untilStart = 4000
  mgSize = 1
  targetMgSize = 1
  mgDistances = {
    ts,
    gs,
    math.floor(gs * 1.5),
    os,
    350,
    keypad
  }
  mgProgressSpeed = 1000 / time * 0.75
  mgProgress = 0.25
  moveSpeed = 0
  targetMoveSpeed = ms
  iconColor = sightexports.sGui:getColorCode(iconc)
  mgIcon = sightexports.sGui:getFaIconFilename(icon, 32)
  faTicks = sightexports.sGui:getFaTicks()
  mgBgColor = sightexports.sGui:getColorCode(bgc)
  if not mgState then
    addEventHandler("onClientRender", getRootElement(), renderMinigame)
    addEventHandler("onClientPreRender", getRootElement(), preRenderMinigame)
  end
  mgState = name
  sightexports.sGui:showInfobox("i", "Tartsd a fehér kört a zöld körön belül az egereddel.")
  showCursor(true)
end
function endMinigame(success)
  if isElement(pulseSound) then
    destroyElement(pulseSound)
  end
  pulseSound = nil
  if isElement(greenSound) then
    destroyElement(greenSound)
  end
  greenSound = nil
  triggerEvent("endCircleMinigame", localPlayer, mgState, success)
  if mgState then
    removeEventHandler("onClientRender", getRootElement(), renderMinigame)
    removeEventHandler("onClientPreRender", getRootElement(), preRenderMinigame)
  end
  mgState = false
  showCursor(false)
end
addEvent("endCircleMinigame", false)
addEvent("serverEndCircleMinigame", true)
addEventHandler("serverEndCircleMinigame", getRootElement(), endMinigame)
local randomKeypadText = ""
local lastRandomKeypadText = 0
function generateRandomKeypadText()
  randomKeypadText = ""
  for i = 1, 12 do
    randomKeypadText = randomKeypadText .. string.char(math.random(40, 90))
  end
end
generateRandomKeypadText()
function preRenderMinigame(delta)
  local cx, cy = getCursorPosition()
  if 0 < untilStart then
    untilStart = untilStart - delta
    mgSpeed = 1
    if cx then
      cx = cx * screenX
      cy = cy * screenY
      if mgDistances[6] then
        local tx, ty = cx - x, cy - (y + 45)
        local d = mgDistances[1] / 2
        mouseX = math.min(math.max(tx, -131 + d), 131 - d)
        mouseY = math.min(math.max(ty, -127.5 + d), 127.5 - d)
        local d = mgDistances[4] / 2
        mgX = math.min(math.max(tx, -131 + d), 131 - d)
        mgY = math.min(math.max(ty, -127.5 + d), 127.5 - d)
      else
        local r = math.atan2(cy - y, cx - x)
        local d = getDistanceBetweenPoints2D(cx, cy, x, y)
        d = math.min(d, (mgDistances[5] - mgDistances[1]) / 2)
        mouseX = math.cos(r) * d
        mouseY = math.sin(r) * d
        d = math.min(d, (mgDistances[5] - mgDistances[4]) / 2)
        mgX = math.cos(r) * d
        mgY = math.sin(r) * d
      end
    end
  else
    if cx then
      cx = cx * screenX
      cy = cy * screenY
      if mgDistances[6] then
        local tx, ty = cx - x, cy - (y + 45)
        local d = mgDistances[1] / 2
        mouseX = math.min(math.max(tx, -131 + d), 131 - d)
        mouseY = math.min(math.max(ty, -127.5 + d), 127.5 - d)
      else
        local r = math.atan2(cy - y, cx - x)
        local d = getDistanceBetweenPoints2D(cx, cy, x, y)
        d = math.min(d, (mgDistances[5] - mgDistances[1]) / 2)
        mouseX = math.cos(r) * d
        mouseY = math.sin(r) * d
      end
    end
    if moveSpeed < targetMoveSpeed then
      moveSpeed = moveSpeed + 30 * (delta / 1000)
      if moveSpeed > targetMoveSpeed then
        moveSpeed = targetMoveSpeed
      end
    end
    if moveSpeed > targetMoveSpeed then
      moveSpeed = moveSpeed - 30 * (delta / 1000)
      if moveSpeed < targetMoveSpeed then
        moveSpeed = targetMoveSpeed
      end
    end
    if pulseSpeed < targetPulseSpeed then
      pulseSpeed = pulseSpeed + 2 * (delta / 1000)
      if pulseSpeed > targetPulseSpeed then
        pulseSpeed = targetPulseSpeed
      end
    end
    if pulseSpeed > targetPulseSpeed then
      pulseSpeed = pulseSpeed - 1 * (delta / 1000)
      if pulseSpeed < targetPulseSpeed then
        pulseSpeed = targetPulseSpeed
      end
    end
    if pulseVolume < targetPulseVolume then
      pulseVolume = pulseVolume + 4 * (delta / 1000)
      if pulseVolume > targetPulseVolume then
        pulseVolume = targetPulseVolume
      end
    end
    if pulseVolume > targetPulseVolume then
      pulseVolume = pulseVolume - 2 * (delta / 1000)
      if pulseVolume < targetPulseVolume then
        pulseVolume = targetPulseVolume
      end
    end
    setSoundSpeed(pulseSound, pulseSpeed)
    setSoundVolume(pulseSound, pulseVolume)
    setSoundVolume(greenSound, 1 - pulseVolume)
    if mgX < targetMgX then
      mgX = mgX + moveSpeed * (delta / 1000)
      if mgX > targetMgX then
        nextRandomPos = 0
      end
    end
    if mgX > targetMgX then
      mgX = mgX - moveSpeed * (delta / 1000)
      if mgX < targetMgX then
        nextRandomPos = 0
      end
    end
    if mgY < targetMgY then
      mgY = mgY + moveSpeed * (delta / 1000)
      if mgY > targetMgY then
        nextRandomPos = 0
      end
    end
    if mgY > targetMgY then
      mgY = mgY - moveSpeed * (delta / 1000)
      if mgY < targetMgY then
        nextRandomPos = 0
      end
    end
    if mgSize < targetMgSize then
      mgSize = mgSize + moveSpeed / mgDistances[5] * (delta / 1000)
      if mgSize > targetMgSize then
        nextRandomPos = 0
      end
    end
    if mgSize > targetMgSize then
      mgSize = mgSize - moveSpeed / mgDistances[5] * (delta / 1000)
      if mgSize < targetMgSize then
        nextRandomPos = 0
      end
    end
    nextRandomPos = nextRandomPos - delta
    if nextRandomPos < 0 then
      nextRandomPos = math.random(1000, 4000)
      targetMgSize = math.random(800, 1200) / 1000
      if mgDistances[6] then
        local d = mgDistances[4] * targetMgSize / 2
        targetMgX = math.random(-131 + d, 131 - d)
        targetMgY = math.random(-127.5 + d, 127.5 - d)
      else
        local r = math.rad(math.random(0, 3600) / 10)
        local d = (mgDistances[5] - mgDistances[4]) / 2 * 0.9 * (math.random(0, 1000) / 1000)
        targetMgX = math.cos(r) * d
        targetMgY = math.sin(r) * d
      end
    end
    local d = getDistanceBetweenPoints2D(mouseX, mouseY, mgX, mgY) + mgDistances[1] / 2
    if d <= mgDistances[2] / 2 then
      mgSpeed = 1
      targetPulseVolume = 0
      targetPulseSpeed = 1
    elseif d <= mgDistances[3] / 2 then
      mgSpeed = 0.5
      targetPulseVolume = 0
      targetPulseSpeed = 1
    elseif d <= mgDistances[4] / 2 then
      mgSpeed = 0
      targetPulseVolume = 1
      targetPulseSpeed = 1
    else
      mgSpeed = -2
      targetPulseVolume = 1
      targetPulseSpeed = 1.5
    end
    mgProgress = mgProgress + mgProgressSpeed * mgSpeed * delta / 1000 * math.min(1, moveSpeed / targetMoveSpeed)
    if mgProgress < 0 then
      mgProgress = 0
      endMinigame(false)
    end
    if 1 < mgProgress then
      mgProgress = 1
      endMinigame(true)
    end
  end
  if mgDistances[6] and untilStart <= 0 then
    lastRandomKeypadText = lastRandomKeypadText - delta * math.max(0, mgSpeed)
    if lastRandomKeypadText < 0 then
      lastRandomKeypadText = 125
      generateRandomKeypadText()
    end
  end
end
function renderMinigame()
  sightlangStaticImageUsed[0] = true
  if sightlangStaticImageToc[0] then
    processsightlangStaticImage[0]()
  end
  local circleTex = sightlangStaticImage[0]
  local now = getTickCount()
  local p = 0
  if mgSpeed == 0 then
    p = now % 1500 / 1500
  elseif mgSpeed < 0 then
    p = now % 1000 / 1000
  end
  if mgDistances[6] then
    sightlangStaticImageUsed[1] = true
    if sightlangStaticImageToc[1] then
      processsightlangStaticImage[1]()
    end
    dxDrawImage(x - 150, y - 256, 300, 512, sightlangStaticImage[1])
    dxDrawRectangle(x - 131, y + 45 - 127.5, 262, 255, tocolor(mgBgColor[1], mgBgColor[2], mgBgColor[3], 100))
    dxDrawText(randomKeypadText, x, y - 256 + 113, x, y - 256 + 155, tocolor(33, 52, 20), lcdFontScale * 1.5, lcdFont, "center", "center")
  else
    local s = mgDistances[5]
    if mgSpeed < 0 then
      dxDrawImage(x - s * (1 + 0.5 * p) / 2, y - s * (1 + 0.5 * p) / 2, s * (1 + 0.5 * p), s * (1 + 0.5 * p), circleTex, 0, 0, 0, tocolor(mgBgColor[1], mgBgColor[2], mgBgColor[3], 150 - p * 150))
    end
    dxDrawImage(x - s / 2, y - s / 2, s, s, circleTex, 0, 0, 0, tocolor(mgBgColor[1], mgBgColor[2], mgBgColor[3], 150))
  end
  local tx = x + mgX
  local ty = y + mgY + (mgDistances[6] and 45 or 0)
  local s = mgDistances[4] * mgSize
  if mgSpeed == 0 then
    dxDrawImage(tx - s * (1 + 0.5 * p) / 2, ty - s * (1 + 0.5 * p) / 2, s * (1 + 0.5 * p), s * (1 + 0.5 * p), circleTex, 0, 0, 0, tocolor(orange[1], orange[2], orange[3], 150 - p * 150))
  end
  dxDrawImage(tx - s / 2, ty - s / 2, s, s, circleTex, 0, 0, 0, tocolor(orange[1], orange[2], orange[3], 100))
  local s = mgDistances[3] * mgSize
  dxDrawImage(tx - s / 2, ty - s / 2, s, s, circleTex, 0, 0, 0, tocolor(green[1], green[2], green[3], 150))
  local s = mgDistances[2] * mgSize
  dxDrawImage(tx - s / 2, ty - s / 2, s, s, circleTex, 0, 0, 0, tocolor(green[1], green[2], green[3], 150))
  local tx = x + mouseX
  local ty = y + mouseY + (mgDistances[6] and 45 or 0)
  dxDrawImage(tx - mgDistances[1] / 2, ty - mgDistances[1] / 2, mgDistances[1], mgDistances[1], circleTex, 0, 0, 0, tocolor(255, 255, 255, 200))
  dxDrawImage(tx - mgDistances[1] / 2 + 2, ty - mgDistances[1] / 2 + 2, mgDistances[1] - 4, mgDistances[1] - 4, ":sGui/" .. mgIcon .. (faTicks[mgIcon] or ""), 0, 0, 0, tocolor(iconColor[1], iconColor[2], iconColor[3], 255))
  local s = mgDistances[5]
  dxDrawRectangle(x - s / 2, y + s / 2 + 20, s, 12, tocolor(grey1[1], grey1[2], grey1[3], 150))
  dxDrawRectangle(x - s / 2, y + s / 2 + 20, s * mgProgress, 12, tocolor(green[1], green[2], green[3]))
  if mgSpeed < 0 then
    dxDrawRectangle(x - s / 2, y + s / 2 + 20, s * mgProgress, 12, tocolor(red[1], red[2], red[3], 255 * p))
  elseif mgSpeed == 0 then
    dxDrawRectangle(x - s / 2, y + s / 2 + 20, s * mgProgress, 12, tocolor(orange[1], orange[2], orange[3], 255 * p))
  end
  if 0 < untilStart then
    local secs = math.floor(untilStart / 1000)
    local p = untilStart / 1000 - secs
    local a = 1
    if secs < 1 then
      secs = "START"
      a = p
    end
    if tmpSecs ~= secs then
      tmpSecs = secs
      if secs == "START" then
        playSound("files/cd2.wav")
      else
        playSound("files/cd.wav")
      end
    end
    local ty = y
    if mgDistances[6] then
      dxDrawRectangle(x - 131, y + 45 - 127.5, 262, 255, tocolor(0, 0, 0, 150))
      ty = y + 45
    else
      dxDrawImage(x - s / 2, y - s / 2, s, s, circleTex, 0, 0, 0, tocolor(0, 0, 0, 150 * a))
    end
    dxDrawText(secs, x, ty, x, ty, tocolor(255, 255, 255, 255 * math.min(1, a * 2)), timerFontScale * (1 + 1 * p), timerFont, "center", "center")
  end
end
