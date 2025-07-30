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
local npcElements = {}
local npcPositions = {}
local targetNpcFearLeveles = {}
local npcFearLeveles = {}
local npcAim = {}
function createBankNPC(i, x, y, z, r)
  npcPositions[i] = {
    x,
    y,
    z
  }
  targetNpcFearLeveles[i] = 1
  npcFearLeveles[i] = 1
end
mainClerk = createBankNPC(1, mainClerkPos[1], mainClerkPos[2], mainClerkPos[3], mainClerkPos[4])
for i = 1, #otherNpcPoses do
  createBankNPC(1 + i, otherNpcPoses[i][1], otherNpcPoses[i][2], otherNpcPoses[i][3], otherNpcPoses[i][4])
end
npcDuck = false
npcFear = false
addEvent("gotGoldrobNPCElements", true)
addEventHandler("gotGoldrobNPCElements", getRootElement(), function(npc)
  npcElements = npc
end)
addEvent("gotGoldrobNPCDuck", true)
addEventHandler("gotGoldrobNPCDuck", getRootElement(), function(state)
  npcDuck = state
end)
addEvent("gotGoldrobNPCFear", true)
addEventHandler("gotGoldrobNPCFear", getRootElement(), function(state)
  npcFear = state
end)
local inFearCol = false
function screenIntersection(dx, dy, s)
  local w = screenX / 2 - s
  local h = screenY / 2 - s
  local phi = h / w
  local theta = math.abs(dy / dx)
  local qx = 0 < dx and 1 or -1
  local qy = 0 < dy and 1 or -1
  local x, y = 0, 0
  if phi < theta then
    x = h / theta * qx
    y = h * qy
  else
    x = w * qx
    y = w * theta * qy
  end
  return x, y
end
addEvent("gotGoldrobNPCAim", true)
addEventHandler("gotGoldrobNPCAim", getRootElement(), function(i, aim)
  npcAim[i] = aim
end)
addEvent("gotGoldrobNPCFearLevel", true)
addEventHandler("gotGoldrobNPCFearLevel", getRootElement(), function(i, val)
  targetNpcFearLeveles[i] = val or 1
  if not inBankCol then
    npcFearLeveles[i] = targetNpcFearLeveles[i]
  end
end)
function drawNPCFear(i, pulse, ctx, cty, r2, nx, ny, nz)
  local x, y = getScreenFromWorldPosition(nx, ny, nz + 1.25, screenX * screenY)
  local r = 0
  local s = 16 + (npcFearLeveles[i] < 0.25 and pulse * 8 or 0)
  if x then
    if x >= s and x <= screenX - s and y >= s and y <= screenY - s then
      dxDrawRectangle(x - 48, y + 16 + 4, 96, 10, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3]))
      dxDrawRectangle(x - 48 + 1, y + 16 + 4 + 1, 94 * npcFearLeveles[i], 8, tocolor(sightred[1], sightred[2], sightred[3]))
      dxDrawImage(x - s + 1, y - s + 1, s * 2, s * 2, ":sGui/" .. fearIcon .. faTicks[fearIcon], 0, 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3]))
      dxDrawImage(x - s, y - s, s * 2, s * 2, ":sGui/" .. fearIcon .. faTicks[fearIcon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
      return
    end
    r = -math.atan2(x - screenX / 2, y - screenY / 2) + math.pi / 2
  else
    r = -math.atan2(ny - cty, nx - ctx)
    r = r + r2
  end
  local x, y = 10000 * math.cos(r), 10000 * math.sin(r)
  x, y = screenIntersection(x, y, 16)
  dxDrawImage(screenX / 2 + x - 24 + 1, screenY / 2 + y - 24 + 1, 48, 48, ":sGui/" .. fearArrowIcon .. faTicks[fearArrowIcon], math.deg(r), 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3]))
  dxDrawImage(screenX / 2 + x - 24, screenY / 2 + y - 24, 48, 48, ":sGui/" .. fearArrowIcon .. faTicks[fearArrowIcon], math.deg(r), 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
  local len = math.sqrt(x * x + y * y)
  x = x / len * (len - 32)
  y = y / len * (len - 32)
  dxDrawImage(screenX / 2 + x - s + 1, screenY / 2 + y - s + 1, s * 2, s * 2, ":sGui/" .. fearIcon .. faTicks[fearIcon], 0, 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3]))
  dxDrawImage(screenX / 2 + x - s, screenY / 2 + y - s, s * 2, s * 2, ":sGui/" .. fearIcon .. faTicks[fearIcon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
end
function renderNPCFear(now, camx, camy, camz, ctx, cty, ctz)
  if npcFear and not npcDuck and inFearCol then
    local pulse = now % 600 / 300
    if 1 < pulse then
      pulse = 2 - pulse
    end
    pulse = getEasingValue(pulse, "InOutQuad")
    local r2 = math.atan2(camy - cty, camx - ctx) + math.pi / 2
    for i = 1, #npcPositions do
      if isElement(npcElements[i]) then
        local nx, ny, nz = npcPositions[i][1], npcPositions[i][2], npcPositions[i][3]
        drawNPCFear(i, pulse, ctx, cty, r2, nx, ny, nz)
      end
    end
  end
end
function processNPCFear(now, delta)
  inFearCol = isElementWithinColShape(localPlayer, bankFearCol)
  for i = 1, #npcPositions do
    if npcFearLeveles[i] > targetNpcFearLeveles[i] then
      npcFearLeveles[i] = npcFearLeveles[i] - 1 * delta / 1000
      if npcFearLeveles[i] < targetNpcFearLeveles[i] then
        npcFearLeveles[i] = targetNpcFearLeveles[i]
      end
    elseif npcFearLeveles[i] < targetNpcFearLeveles[i] then
      npcFearLeveles[i] = npcFearLeveles[i] + 1 * delta / 1000
      if npcFearLeveles[i] > targetNpcFearLeveles[i] then
        npcFearLeveles[i] = targetNpcFearLeveles[i]
      end
    end
    if isElement(npcElements[i]) then
      local a, b = getPedAnimation(npcElements[i])
      if npcDuck then
        if a ~= "ped" or b ~= "duck_cower" then
          setPedAnimation(npcElements[i], "ped", "duck_cower", -1, false, false, false)
        end
      elseif npcFear then
        if npcAim[i] then
          targetNpcFearLeveles[i] = math.min(1, targetNpcFearLeveles[i] + fearRecharge * delta / 1000)
        else
          targetNpcFearLeveles[i] = math.max(0, targetNpcFearLeveles[i] - fearDischarge * delta / 1000)
        end
        if a ~= "ped" or b ~= "handsup" then
          setPedAnimation(npcElements[i], "ped", "handsup", -1, false, false, false)
        end
      elseif a or b then
        setPedAnimation(npcElements[i])
      end
    end
  end
end
local fearMinigameUpSpeed = 0
local fearMinigameNextUpSpeed = 0
local fearMinigameDownSpeed = 0
local fearMinigameNextDownSpeed = 0
local fearMinigameNextUpStart = getTickCount()
local fearMinigameNextUpTime = 0
local fearMinigameNextDownStart = getTickCount()
local fearMinigameNextDownTime = 0
local countdown = 6000
local fearMinigameCursor = 0.4
local fearMinigameProg = 0
function renderFearMinigame()
  local now = getTickCount()
  local x = screenX / 2
  local y = math.floor(screenY * 0.8)
  dxDrawRectangle(x - 150, y - 8, 300, 16, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3]))
  local c = tocolor(sightred[1], sightred[2], sightred[3])
  if 0.1 < fearMinigameCursor and fearMinigameCursor <= 0.5 then
    c = tocolor(sightred[1] + (sightgreen[1] - sightred[1]) * (fearMinigameCursor - 0.1) / 0.4, sightred[2] + (sightgreen[2] - sightred[2]) * (fearMinigameCursor - 0.1) / 0.4, sightred[3] + (sightgreen[3] - sightred[3]) * (fearMinigameCursor - 0.1) / 0.4)
  elseif 0.1 < fearMinigameCursor and fearMinigameCursor < 0.9 then
    c = tocolor(sightgreen[1] + (sightred[1] - sightgreen[1]) * (fearMinigameCursor - 0.5) / 0.4, sightgreen[2] + (sightred[2] - sightgreen[2]) * (fearMinigameCursor - 0.5) / 0.4, sightgreen[3] + (sightred[3] - sightgreen[3]) * (fearMinigameCursor - 0.5) / 0.4)
  end
  dxDrawRectangle(x - 150 + 294 * fearMinigameCursor, y - 8, 6, 16, c)
  if fearMinigameProg < 0 then
    local w = -32 * fearMinigameProg
    dxDrawImageSection(x - 150 - 16, y - 8 - 32, 32, 32 - w, 0, 0, 32, 32 - w, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3]))
    dxDrawImageSection(x - 150 - 16, y - 8 - 32 + 32 - w, 32, w, 0, 32 - w, 32, w, ":sGui/" .. anger2Icon .. faTicks[anger2Icon], 0, 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3]))
    dxDrawImageSection(x - 150 - 16, y - 8 - 32, 32, 32 - w, 0, 0, 32, 32 - w, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
    dxDrawImageSection(x - 150 - 16, y - 8 - 32 + 32 - w, 32, w, 0, 32 - w, 32, w, ":sGui/" .. anger2Icon .. faTicks[anger2Icon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
  else
    dxDrawImage(x - 150 - 16 + 1, y - 8 - 32 + 1, 32, 32, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3]))
    dxDrawImage(x - 150 - 16, y - 8 - 32, 32, 32, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
  end
  if 0 < fearMinigameProg then
    local w = 32 * fearMinigameProg
    dxDrawImageSection(x - 16, y - 8 - 32, 32, 32 - w, 0, 0, 32, 32 - w, ":sGui/" .. fearFaceIcon .. faTicks[fearFaceIcon], 0, 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3]))
    dxDrawImageSection(x - 16, y - 8 - 32 + 32 - w, 32, w, 0, 32 - w, 32, w, ":sGui/" .. fearFace2Icon .. faTicks[fearFace2Icon], 0, 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3]))
    dxDrawImageSection(x - 16, y - 8 - 32, 32, 32 - w, 0, 0, 32, 32 - w, ":sGui/" .. fearFaceIcon .. faTicks[fearFaceIcon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3]))
    dxDrawImageSection(x - 16, y - 8 - 32 + 32 - w, 32, w, 0, 32 - w, 32, w, ":sGui/" .. fearFace2Icon .. faTicks[fearFace2Icon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3]))
  else
    dxDrawImage(x - 16 + 1, y - 8 - 32 + 1, 32, 32, ":sGui/" .. fearFaceIcon .. faTicks[fearFaceIcon], 0, 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3]))
    dxDrawImage(x - 16, y - 8 - 32, 32, 32, ":sGui/" .. fearFaceIcon .. faTicks[fearFaceIcon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3]))
  end
  if fearMinigameProg < 0 then
    local w = -32 * fearMinigameProg
    dxDrawImageSection(x + 150 - 16, y - 8 - 32, 32, 32 - w, 0, 0, 32, 32 - w, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3]))
    dxDrawImageSection(x + 150 - 16, y - 8 - 32 + 32 - w, 32, w, 0, 32 - w, 32, w, ":sGui/" .. anger2Icon .. faTicks[anger2Icon], 0, 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3]))
    dxDrawImageSection(x + 150 - 16, y - 8 - 32, 32, 32 - w, 0, 0, 32, 32 - w, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
    dxDrawImageSection(x + 150 - 16, y - 8 - 32 + 32 - w, 32, w, 0, 32 - w, 32, w, ":sGui/" .. anger2Icon .. faTicks[anger2Icon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
  else
    dxDrawImage(x + 150 - 16 + 1, y - 8 - 32 + 1, 32, 32, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3]))
    dxDrawImage(x + 150 - 16, y - 8 - 32, 32, 32, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
  end
  if 0 < countdown then
    local secs = math.floor(countdown / 1000)
    local p = countdown / 1000 - secs
    local a = 1
    if secs < 1 then
      secs = "START"
      a = p
    end
    dxDrawText(secs, x + 1, y - 16 + 1, x + 1, y - 16 + 1, tocolor(0, 0, 0, 255 * math.min(1, a * 2)), timerFontScale * (1 + 1 * p), timerFont, "center", "center")
    dxDrawText(secs, x, y - 16, x, y - 16, tocolor(255, 255, 255, 255 * math.min(1, a * 2)), timerFontScale * (1 + 1 * p), timerFont, "center", "center")
  end
end
function preRenderFearMinigame(delta)
  local now = getTickCount()
  countdown = countdown - delta
  if countdown < 0 then
    if now - fearMinigameNextUpStart > fearMinigameNextUpTime then
      fearMinigameNextUpStart = now
      fearMinigameNextUpTime = math.random(50, 500)
      fearMinigameUpSpeed = fearMinigameNextUpSpeed
      fearMinigameNextUpSpeed = 0.2 + math.random() * 0.75
    end
    if now - fearMinigameNextDownStart > fearMinigameNextDownTime then
      fearMinigameNextDownStart = now
      fearMinigameNextDownTime = math.random(50, 500)
      fearMinigameDownSpeed = fearMinigameNextDownSpeed
      fearMinigameNextDownSpeed = 0.2 + math.random() * 0.75
    end
  end
  local spd = 0
  if getKeyState("space") then
    local p = math.min(1, (now - fearMinigameNextUpStart) / fearMinigameNextUpTime)
    spd = fearMinigameUpSpeed + (fearMinigameNextUpSpeed - fearMinigameUpSpeed) * p
  else
    local p = math.min(1, (now - fearMinigameNextDownStart) / fearMinigameNextDownTime)
    spd = -(fearMinigameDownSpeed + (fearMinigameNextDownSpeed - fearMinigameDownSpeed) * p)
  end
  fearMinigameCursor = math.min(1, math.max(0, fearMinigameCursor + spd * delta / 1000))
  local px, py, pz = getElementPosition(localPlayer)
  if 3 < getDistanceBetweenPoints3D(px, py, pz, mainClerkPos[1], mainClerkPos[2], mainClerkPos[3]) then
    removeEventHandler("onClientRender", getRootElement(), renderFearMinigame)
    removeEventHandler("onClientPreRender", getRootElement(), preRenderFearMinigame)
    triggerServerEvent("goldrobNPCMinigameResult", localPlayer)
    npcMinigame = false
    return
  end
  if fearMinigameCursor <= 0.4 then
    local spd = (0.4 - fearMinigameCursor) / 0.4 * 2.75
    fearMinigameProg = fearMinigameProg - spd * delta / 1000
    if fearMinigameProg < -1 then
      removeEventHandler("onClientRender", getRootElement(), renderFearMinigame)
      removeEventHandler("onClientPreRender", getRootElement(), preRenderFearMinigame)
      triggerServerEvent("goldrobNPCMinigameResult", localPlayer)
      npcMinigame = false
    end
  elseif 0.42 <= fearMinigameCursor and fearMinigameCursor <= 0.58 then
    local spd = (1 - math.abs(fearMinigameCursor - 0.5) / 0.08) * 0.425
    fearMinigameProg = fearMinigameProg + spd * delta / 1000
    if 1 < fearMinigameProg then
      removeEventHandler("onClientRender", getRootElement(), renderFearMinigame)
      removeEventHandler("onClientPreRender", getRootElement(), preRenderFearMinigame)
      triggerServerEvent("goldrobNPCMinigameResult", localPlayer, true)
      npcMinigame = false
    end
  elseif 0.6 <= fearMinigameCursor then
    local spd = (fearMinigameCursor - 0.6) / 0.4 * 2.75
    fearMinigameProg = fearMinigameProg - spd * delta / 1000
    if fearMinigameProg < -1 then
      removeEventHandler("onClientRender", getRootElement(), renderFearMinigame)
      removeEventHandler("onClientPreRender", getRootElement(), preRenderFearMinigame)
      triggerServerEvent("goldrobNPCMinigameResult", localPlayer)
      npcMinigame = false
    end
  end
end
npcMinigame = false
addEvent("gotGoldrobNPCFearMinigame", true)
addEventHandler("gotGoldrobNPCFearMinigame", getRootElement(), function(state)
  if state ~= npcMinigame then
    npcMinigame = state
    fearMinigameUpSpeed = 0
    fearMinigameNextUpSpeed = 0
    fearMinigameDownSpeed = 0
    fearMinigameNextDownSpeed = 0
    fearMinigameNextUpStart = getTickCount()
    fearMinigameNextUpTime = 0
    fearMinigameNextDownStart = getTickCount()
    fearMinigameNextDownTime = 0
    countdown = 6000
    fearMinigameCursor = 0.4
    fearMinigameProg = 0
    if state then
      addEventHandler("onClientRender", getRootElement(), renderFearMinigame)
      addEventHandler("onClientPreRender", getRootElement(), preRenderFearMinigame)
      sightexports.sGui:showInfobox("i", "Tartsd a SPACE gomb segítségével a zöld kurzort a szürke négyzet közepén.")
    else
      removeEventHandler("onClientRender", getRootElement(), renderFearMinigame)
      removeEventHandler("onClientPreRender", getRootElement(), preRenderFearMinigame)
    end
  end
end)
