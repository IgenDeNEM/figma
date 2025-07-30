local sightexports = {
  sModloader = false,
  sWeather = false,
  sDashboard = false,
  sHud = false,
  sControls = false,
  sGui = false,
  sAccounts = false,
  sGroups = false,
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
local red = false
local timerFont = false
local timerFontScale = false
local timerFontH = false
local timerWidth = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    red = sightexports.sGui:getColorCode("sightred")
    timerFont = sightexports.sGui:getFont("30/BebasNeueRegular.otf")
    timerFontScale = sightexports.sGui:getFontScale("30/BebasNeueRegular.otf")
    timerFontH = sightexports.sGui:getFontHeight("30/BebasNeueRegular.otf")
    timerWidth = sightexports.sGui:getTextWidthFont("0", "30/BebasNeueRegular.otf")
    icon = sightexports.sGui:getFaIconFilename("arrow-alt-up", 24)
    faTicks = sightexports.sGui:getFaTicks()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local sightlangModloaderLoaded = function()
  loadModels()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState7 = false
local function sightlangCondHandl7(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState7 then
    sightlangCondHandlState7 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), carryingDeathPreRender, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), carryingDeathPreRender)
    end
  end
end
local sightlangCondHandlState6 = false
local function sightlangCondHandl6(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState6 then
    sightlangCondHandlState6 = cond
    if cond then
      addEventHandler("onClientPedsProcessed", getRootElement(), carryingDeathPedsProcessed, true, prio)
    else
      removeEventHandler("onClientPedsProcessed", getRootElement(), carryingDeathPedsProcessed)
    end
  end
end
local sightlangCondHandlState5 = false
local function sightlangCondHandl5(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState5 then
    sightlangCondHandlState5 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderRespawning, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderRespawning)
    end
  end
end
local sightlangCondHandlState4 = false
local function sightlangCondHandl4(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState4 then
    sightlangCondHandlState4 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderDeath, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderDeath)
    end
  end
end
local sightlangCondHandlState3 = false
local function sightlangCondHandl3(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState3 then
    sightlangCondHandlState3 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderDeathEx, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderDeathEx)
    end
  end
end
local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState2 then
    sightlangCondHandlState2 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderDeath, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderDeath)
    end
  end
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderDeathStart, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderDeathStart)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderDeathStart, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderDeathStart)
    end
  end
end
local sightlangStrmMode = true
if sightexports.sDashboard then
  local val = sightexports.sDashboard:getStreamerMode()
  sightlangStrmMode = val
end
local streamerSounds = {}
function sightlangSoundDestroy()
  streamerSounds[source] = nil
end
function setStreamerModeVolume(sound, vol)
  if not sound then
    return
  end
  if not streamerSounds[sound] then
    addEventHandler("onClientElementDestroy", sound, sightlangSoundDestroy)
  end
  streamerSounds[sound] = vol
  setSoundVolume(sound, sightlangStrmMode and 0 or vol)
end
addEventHandler("streamerModeChanged", getRootElement(), function(val)
  sightlangStrmMode = val
  for sound, vol in pairs(streamerSounds) do
    setSoundVolume(sound, val and 0 or vol)
  end
end)
local screenX, screenY = guiGetScreenSize()
local deathStart = false
local deathTrigger = false
local spawned = false
local spawnedInit = false
local spawnedInitCamGot = 0
local spawnedDone = false
local deathStartTheme = false
local bgSound = false
local timeUp = false
local dStartX, dStartY, dStartZ, dStartTX, dStartTY, dStartTZ
local dStartVert = false
local models = {}
function loadModels()
  models.v4_strangers_clock = sightexports.sModloader:getModelId("v4_strangers_clock")
  models.v4_strangers_portal = sightexports.sModloader:getModelId("v4_strangers_portal")
end
local particles = {}
local particle
local clockShader = false
local shader = false
local pedShader = false
local lightShader = false
local portalShader = false
local screenShader = false
local rootTexture = false
local rootLTexture = false
local rootL2Texture = false
local portalTexture = false
local noiseTexture = false
local rt, rt2, rt3, rt4, screen
function spawnParticle(x, y, z)
  table.insert(particles, {
    x,
    y,
    z,
    0.025 + 0.1 * math.random(),
    0.1 + 0.5 * math.random(),
    math.random(0, 1),
    math.random(0, 1),
    math.random(100, 200)
  })
end
local clockDelete = 0
local nextClock = 0
local clockSpawned = false
local clockX, clockY, clockZ = 0, 0, 0
local targetClockZ = 0
local portalX, portalY, portalZ = false, false, false
local lightningCos = false
local lightningSin = false
local lightningTime = false
local lightning = {}
local portalObj = false
local portalOutDone = false
local portalOutTrigger = false
local portalSound = false
local portalOutSound = false
local portalRot = false
local portalCos = false
local portalSin = false
function spawnLightning()
  local cx, cy, cz, tx, ty, tz = getCameraMatrix()
  local angle = math.atan2(ty - cy, tx - cx)
  lightningCos = math.cos(angle)
  lightningSin = math.sin(angle)
  lightningTime = getTickCount()
  playSound("files/thunder" .. math.random(1, 9) .. ".mp3")
  setTimer(function()
    local x, y, z = getElementPosition(localPlayer)
    createExplosion(x, y, z - 50, 12, false, 0.25, false)
  end, 250, (1000 + math.random() * 2000) / 1000 * 4)
end
function deleteClock(silent)
  if not silent then
    local sound = playSound3D("files/tick.mp3", clockX, clockY, clockZ)
    setSoundMaxDistance(sound, 1000)
    setSoundVolume(sound, 1.5)
    setElementDimension(sound, getElementDimension(localPlayer))
  end
  clockDelete = getTickCount()
  nextClock = getTickCount() + 120000 * (0.85 + 0.3 * math.random())
  spawnLightning()
end
function createClock(px, py, pz)
  if portalX and getDistanceBetweenPoints3D(px, py, pz, portalX, portalY, portalZ) <= 55 then
    return
  end
  if isElement(clockSound) then
    destroyElement(clockSound)
  end
  clockSound = nil
  if isElement(clock) then
    destroyElement(clock)
  end
  clock = nil
  local vx, vy = (portalX or math.random(-3000, 3000)) - px, (portalY or math.random(-3000, 3000)) - py
  local dist = math.sqrt(vx * vx + vy * vy)
  vx = vx / dist
  vy = vy / dist
  clockX, clockY, clockZ = px + vx * 90, py + vy * 90, pz
  targetClockZ = clockZ
  local sound = playSound3D("files/tick.mp3", clockX, clockY, clockZ)
  setSoundMaxDistance(sound, 1000)
  setSoundVolume(sound, 1.5)
  setElementDimension(sound, getElementDimension(localPlayer))
  clockDelete = false
  clockSpawned = getTickCount()
  clock = createObject(models.v4_strangers_clock, clockX, clockY, clockZ)
  setElementCollisionsEnabled(clock, false)
  setElementDimension(clock, getElementDimension(localPlayer))
  clockSound = playSound3D("files/clock.mp3", 0, 0, 0, true)
  setSoundMaxDistance(clockSound, 500)
  setElementDimension(clockSound, getElementDimension(localPlayer))
  dxSetShaderValue(shader, "clockSpawn", true)
  dxSetShaderValue(pedShader, "clockSpawn", true)
  dxSetShaderValue(clockShader, "clockSpawn", true)
end
function deleteShaders()
  for i = 1, 3 do
    if isElement(lightning[i]) then
      destroyElement(lightning[i])
    end
    lightning[i] = nil
  end
  if isElement(clockSound) then
    destroyElement(clockSound)
  end
  clockSound = nil
  if isElement(clock) then
    destroyElement(clock)
  end
  clock = nil
  clockSpawned = false
  if isElement(clockShader) then
    destroyElement(clockShader)
  end
  clockShader = nil
  if isElement(shader) then
    destroyElement(shader)
  end
  shader = nil
  if isElement(pedShader) then
    destroyElement(pedShader)
  end
  pedShader = nil
  if isElement(lightShader) then
    destroyElement(lightShader)
  end
  lightShader = nil
  if isElement(portalShader) then
    destroyElement(portalShader)
  end
  portalShader = nil
  if isElement(screenShader) then
    destroyElement(screenShader)
  end
  screenShader = nil
  if isElement(rootTexture) then
    destroyElement(rootTexture)
  end
  rootTexture = nil
  if isElement(rootLTexture) then
    destroyElement(rootLTexture)
  end
  rootLTexture = nil
  if isElement(rootL2Texture) then
    destroyElement(rootL2Texture)
  end
  rootL2Texture = nil
  if isElement(portalTexture) then
    destroyElement(portalTexture)
  end
  portalTexture = nil
  if isElement(noiseTexture) then
    destroyElement(noiseTexture)
  end
  noiseTexture = nil
  if isElement(rt) then
    destroyElement(rt)
  end
  rt = nil
  if isElement(rt2) then
    destroyElement(rt2)
  end
  rt2 = nil
  if isElement(rt3) then
    destroyElement(rt3)
  end
  rt3 = nil
  if isElement(rt4) then
    destroyElement(rt4)
  end
  rt4 = nil
  if isElement(screen) then
    destroyElement(screen)
  end
  screen = nil
  if isElement(particle) then
    destroyElement(particle)
  end
  particle = nil
  if isElement(portalObj) then
    destroyElement(portalObj)
  end
  portalObj = nil
  if isElement(portalSound) then
    destroyElement(portalSound)
  end
  portalSound = nil
  particles = {}
end
function createShaders()
  deleteShaders()
  lightningTime = false
  nextLightning = false
  nextClock = getTickCount() + 17000
  nextLightning = getTickCount() + 15000
  for i = 1, 3 do
    lightning[i] = dxCreateTexture("files/" .. i .. ".png")
  end
  particle = dxCreateTexture("files/real_tile.png")
  local x, y, z = getElementPosition(localPlayer)
  for i = 1, 100 do
    local r = math.random() * math.pi * 2
    local d = math.random() * 59.49999999999999
    spawnParticle(x + math.cos(r) * d, y + math.sin(r) * d, z - 1)
  end
  clockShader = dxCreateShader(clockShaderSource, 0, 85, false, "world,object")
  shader = dxCreateShader(shaderSource, 0, 85, false, "world,object")
  pedShader = dxCreateShader(pedShaderSource, 0, 85, false, "ped")
  lightShader = dxCreateShader(lightShaderSource, 0, 85, false, "world,object,other")
  portalShader = dxCreateShader(portalShaderSource, 0, 85, false, "object")
  screenShader = dxCreateShader(screenShaderSource)
  rt = dxCreateRenderTarget(screenX, screenY)
  rt2 = dxCreateRenderTarget(screenX, screenY)
  rt3 = dxCreateRenderTarget(screenX, screenY)
  rt4 = dxCreateRenderTarget(screenX, screenY)
  screen = dxCreateScreenSource(screenX, screenY)
  rootTexture = dxCreateTexture("files/root.png")
  rootLTexture = dxCreateTexture("files/rootl.png")
  rootL2Texture = dxCreateTexture("files/rootl2.png")
  portalTexture = dxCreateTexture("files/portal.png")
  noiseTexture = dxCreateTexture("files/noise.png")
  dxSetShaderValue(shader, "texa", rootTexture)
  dxSetShaderValue(shader, "texb", rootLTexture)
  dxSetShaderValue(pedShader, "cloud", rootL2Texture)
  dxSetShaderValue(shader, "cloud", rootL2Texture)
  dxSetShaderValue(clockShader, "cloud", rootL2Texture)
  dxSetShaderValue(screenShader, "worldRT", rt4)
  dxSetShaderValue(shader, "portalRT", rt2)
  dxSetShaderValue(shader, "secondRT", rt3)
  dxSetShaderValue(shader, "secondRT", rt3)
  dxSetShaderValue(screenShader, "portalRT", rt2)
  dxSetShaderValue(lightShader, "portalRT", rt2)
  dxSetShaderValue(portalShader, "secondRT", rt)
  dxSetShaderValue(screenShader, "sBaseTexture", screen)
  dxSetShaderValue(portalShader, "portalMask", portalTexture)
  dxSetShaderValue(portalShader, "noiseText", noiseTexture)
  engineApplyShaderToWorldTexture(shader, "*")
  engineRemoveShaderFromWorldTexture(shader, "*shad*")
  engineRemoveShaderFromWorldTexture(shader, "*light*")
  engineRemoveShaderFromWorldTexture(shader, "*sphere*")
  engineRemoveShaderFromWorldTexture(shader, "*particle*")
  engineRemoveShaderFromWorldTexture(shader, "*corona*")
  engineRemoveShaderFromWorldTexture(shader, "*smoke*")
  engineRemoveShaderFromWorldTexture(shader, "sight_strangers_clock")
  engineRemoveShaderFromWorldTexture(shader, "sight_strangers_clock_glass")
  engineApplyShaderToWorldTexture(clockShader, "sight_strangers_clock")
  engineApplyShaderToWorldTexture(clockShader, "sight_strangers_clock_glass")
  engineRemoveShaderFromWorldTexture(shader, "sight_strangers_portal2")
  engineApplyShaderToWorldTexture(portalShader, "sight_strangers_portal2")
  engineApplyShaderToWorldTexture(lightShader, "*corona*")
  engineApplyShaderToWorldTexture(lightShader, "*sphere*")
  engineApplyShaderToWorldTexture(lightShader, "*shad*")
  engineApplyShaderToWorldTexture(lightShader, "*light*")
  engineRemoveShaderFromWorldTexture(lightShader, "shad_ped")
  engineApplyShaderToWorldTexture(pedShader, "*")
  dxSetShaderValue(clockShader, "portal", {
    portalX or 0,
    portalY or 0,
    portalZ or 10000
  })
  dxSetShaderValue(pedShader, "portal", {
    portalX or 0,
    portalY or 0,
    portalZ or 10000
  })
  dxSetShaderValue(shader, "portal", {
    portalX or 0,
    portalY or 0,
    portalZ or 10000
  })
  if portalX then
    portalRot = math.random() * math.pi * 2
    portalCos = math.cos(portalRot)
    portalSin = math.sin(portalRot)
    portalObj = createObject(models.v4_strangers_portal, portalX, portalY, portalZ, 0, 0, 0)
    setElementDimension(portalObj, getElementDimension(localPlayer))
    portalSound = playSound3D("files/portal.mp3", portalX, portalY, portalZ, true)
    setSoundVolume(portalSound, 2)
    setSoundMaxDistance(portalSound, 85)
    setElementDimension(portalSound, getElementDimension(localPlayer))
    portalOutSound = false
  end
end
local timerText = {
  1,
  0,
  ":",
  0,
  0
}
local countdown = false
local hudOn = false
local respawning = false
local respawningPortal = false
function playerRespawned()
  spawned = false
  lightningTime = false
  deathStart = false
  countdown = false
  deleteShaders()
  setCameraTarget(localPlayer)
  if isElement(deathStartTheme) then
    destroyElement(deathStartTheme)
  end
  deathStartTheme = nil
  if isElement(bgSound) then
    destroyElement(bgSound)
  end
  bgSound = nil
  sightlangCondHandl0(false)
  sightlangCondHandl1(false)
  sightlangCondHandl2(false)
  sightlangCondHandl3(false)
  sightlangCondHandl4(false)
  sightexports.sWeather:resetWeather()
  sightexports.sDashboard:resetFogAndFarClip()
  sightexports.sHud:setHudState(true, 500)
  showChat(true)
end
addEvent("playerRespawnedFromDeath", true)
addEventHandler("playerRespawnedFromDeath", getRootElement(), function(portal)
  sightexports.sControls:toggleAllControls(false)
  respawning = getTickCount()
  respawningPortal = portal
  sightlangCondHandl5(respawning, "low-9999999999")
  playerRespawned()
  if not portal then
    if isElement(portalOutSound) then
      destroyElement(portalOutSound)
    end
    portalOutSound = nil
  end
end)
addEvent("spawnedInDeath", true)
addEventHandler("spawnedInDeath", getRootElement(), function(x, y, z)
  portalX, portalY, portalZ = x, y, z
  sightexports.sHud:setHudState(false)
  showChat(false)
  setElementFrozen(localPlayer, true)
  lightningTime = false
  deathStart = false
  spawned = true
  timeUp = false
  respawning = false
  spawnedInit = false
  spawnedInitCamGot = 0
  spawnedDone = false
  portalOutDone = false
  portalOutTrigger = false
  if getElementData(localPlayer, "c_isDead") then
    setElementData(localPlayer, "c_isDead", false)
  end
  bgSound = playSound("files/bg.mp3", true)
  dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0))
  sightlangCondHandl3(spawned or countdown, "low-9999999999")
  sightlangCondHandl5(respawning, "low-9999999999")
  sightlangCondHandl2(spawned or countdown, "high+99999999")
  sightlangCondHandl4(spawned or countdown)
  sightlangCondHandl0(deathStart, "low-9999999999")
  sightlangCondHandl1(deathStart)
end)
function preRenderDeathStart()
  if not deathTrigger then
    local now = getTickCount()
    local pIn = math.min(1, (now - deathStart) / 20000)
    local p = getEasingValue(pIn, "InQuad")
    local gz = getGroundPosition(dStartX, dStartY, dStartZ)
    local ncx, ncy, ncz = interpolateBetween(dStartX, dStartY, dStartZ, dStartX, dStartY, gz - 1.5, p, "Linear")
    local ntx, nty, ntz = interpolateBetween(dStartTX, dStartTY, dStartTZ, dStartTX, dStartTY, gz - 1.5, p, "Linear")
    local r = 180 * p
    local rad = math.rad(r)
    local cos = math.cos(rad)
    local sin = math.sin(rad)
    setCameraMatrix(ncx, ncy, ncz, ntx, nty, ntz, r)
    if not getElementData(localPlayer, "c_isDead") then
      setElementData(localPlayer, "c_isDead", true)
    end
    processDStartVert(sin, cos)
    if 1 <= pIn then
      deathTrigger = true
      local r = math.deg(math.atan2(dStartTY - dStartY, dStartTX - dStartX)) - 90
      setElementRotation(localPlayer, 0, 0, r, "default", true)
      setCameraTarget(localPlayer)
      triggerServerEvent("reSpawnInDeath", localPlayer, r)
    end
  end
end
function renderDeathStart()
  local now = getTickCount()
  local p = (now - deathStart) / 20000
  if dStartVert and 3 <= #dStartVert then
    dxDrawPrimitive("trianglestrip", false, unpack(dStartVert))
  end
  if 0.95 <= p then
    dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * math.min(1, (p - 0.95) / 0.05)))
  end
end
function cross(x, y, z, x2, y2, z2)
  return y * z2 - y2 * z, z * x2 - z2 * x, x * y2 - x2 * y
end
function processDStartVert(sin, cos)
  dStartVert = {}
  local black = tocolor(0, 0, 0)
  for i = -5, 5 do
    local d = math.sqrt(screenX * screenX + screenY * screenY) / 2 * i / 5
    local rx, ry = screenX / 2 + cos * d, screenY / 2 + sin * d
    local x, y, z = getWorldFromScreenPosition(rx, ry, 1)
    if x and y and z then
      local z = getGroundPosition(x, y, z + 2.5)
      local sx, sy = getScreenFromWorldPosition(x, y, z + 0.05, screenY * 2)
      local sx2, sy2 = getScreenFromWorldPosition(x, y, z - 1, screenY * 2)
      if sx and sx2 then
        sx2 = sx + (sx2 - sx) * 100
        sy2 = sy + (sy2 - sy) * 100
        table.insert(dStartVert, {
          sx2,
          sy2,
          black
        })
        table.insert(dStartVert, {
          sx,
          sy,
          black
        })
      end
    end
  end
end
function preRenderDeath(delta)
  local now = getTickCount()
  local px, py, pz = getElementPosition(localPlayer)
  if not spawnedInit then
    if sightexports.sAccounts:getIsCharacterSelected() then
      setCameraTarget(localPlayer)
      spawnedInit = true
      createShaders()
    end
  elseif spawnedInitCamGot < 5 then
    dStartX, dStartY, dStartZ, dStartTX, dStartTY, dStartTZ = getCameraMatrix()
    spawnedInitCamGot = spawnedInitCamGot + 1
  elseif spawnedInitCamGot < 10 then
    local gz = getGroundPosition(dStartX, dStartY, dStartZ)
    setCameraMatrix(dStartX, dStartY, gz - 1.5, dStartTX, dStartTY, gz - 1.5, 180)
    local cos = math.cos(math.pi)
    local sin = math.sin(math.pi)
    processDStartVert(sin, cos)
    if not sightexports.sGui:getLoadingScreen() then
      spawnedInitCamGot = spawnedInitCamGot + 1
    else
    end
  else
    if not tonumber(spawned) then
      spawned = now
    end
    if isElement(deathStartTheme) then
      local pIn = (now - spawned) / 25000
      if pIn < 1 then
        setStreamerModeVolume(deathStartTheme, 1 - pIn)
      else
        destroyElement(deathStartTheme)
        deathStartTheme = false
      end
    end
    if not spawnedDone then
      local pIn = math.min(1, (now - spawned) / 20000)
      local p = getEasingValue(1 - pIn, "InQuad")
      local gz = getGroundPosition(dStartX, dStartY, dStartZ)
      local ncx, ncy, ncz = interpolateBetween(dStartX, dStartY, dStartZ, dStartX, dStartY, gz - 1.5, p, "Linear")
      local ntx, nty, ntz = interpolateBetween(dStartTX, dStartTY, dStartTZ, dStartTX, dStartTY, gz - 1.5, p, "Linear")
      local r = 180 + 180 * (1 - p)
      local rad = math.rad(r)
      local cos = math.cos(rad)
      local sin = math.sin(rad)
      setCameraMatrix(ncx, ncy, ncz, ntx, nty, ntz, r)
      processDStartVert(sin, cos)
      if 1 <= pIn then
        countdown = now
        setSoundVolume(bgSound, 0.75)
        spawnedDone = true
        setCameraTarget(localPlayer)
        sightexports.sControls:toggleAllControls(true)
        setElementFrozen(localPlayer, false)
        dStartVert = false
      else
        setSoundVolume(bgSound, pIn * 0.75)
      end
    end
  end
  if spawnedInit then
    setTime(0, 0)
    setWeather(0)
    setSkyGradient(0, 0, 0, 10, 0, 0)
    setFarClipDistance(85)
    if lightningTime then
      local p = (now - lightningTime) / 125
      local lightness = 0.5 + math.random() * 0.5
      local lx, ly, lz = px + lightningCos * 65, py + lightningSin * 65, pz - 1.5
      if p < 1 then
        lightness = lightness * math.min(1, p * 2)
        dxDrawMaterialSectionLine3D(lx, ly, lz + 65, lx, ly, lz + 65 * (1 - p), 0, 0, 615, 481 * p, lightning[1], 65, tocolor(255, 200, 200, 255 * lightness))
        dxSetShaderValue(shader, "lightningPos", {
          lx,
          ly,
          lz + 75 * (1 - p)
        })
        dxSetShaderValue(pedShader, "lightningPos", {
          lx,
          ly,
          lz + 75 * (1 - p)
        })
        dxSetShaderValue(clockShader, "lightningPos", {
          lx,
          ly,
          lz + 75 * (1 - p)
        })
      else
        local p2 = math.min(1, math.max(0, p - 5))
        lightness = lightness * (1 - p2)
        dxDrawMaterialLine3D(lx, ly, lz + 75, lx, ly, lz, lightning[1], 75, tocolor(255, 200, 200, 255 * lightness))
        dxSetShaderValue(shader, "lightningPos", {
          lx,
          ly,
          lz
        })
        dxSetShaderValue(pedShader, "lightningPos", {
          lx,
          ly,
          lz
        })
        dxSetShaderValue(clockShader, "lightningPos", {
          lx,
          ly,
          lz
        })
      end
      dxSetShaderValue(shader, "lightning", lightness)
      dxSetShaderValue(pedShader, "lightning", lightness)
      dxSetShaderValue(clockShader, "lightning", lightness)
      setFogDistance(25 + 50 * lightness)
      if 6 < p then
        lightningTime = false
        nextLightning = now + 5000 + 40000 * math.random()
      end
    else
      setFogDistance(25)
      if nextLightning and now >= nextLightning and not timeUp and tonumber(spawned) then
        spawnLightning()
        nextLightning = false
      end
    end
    if portalX then
      local hit, x, y, z, he, nx, ny, nz = processLineOfSight(portalX, portalY, portalZ + 2, portalX, portalY, portalZ - 2, true, false, false, true, false, false, false, false, obj)
      if hit then
        local fx, fy, fz = cross(portalCos, portalSin, 0, nx, ny, nz)
        local lx, ly, lz = cross(portalSin, -portalCos, 0, nx, ny, nz)
        x = x + nx * 1.86915
        y = y + ny * 1.86915
        z = z + nz * 1.86915
        setElementMatrix(portalObj, {
          {
            lx,
            ly,
            lz,
            0
          },
          {
            fx,
            fy,
            fz,
            0
          },
          {
            nx,
            ny,
            nz,
            0
          },
          {
            x,
            y,
            z,
            0
          }
        })
        setElementPosition(portalSound, x, y, z)
        dxSetShaderValue(clockShader, "portal", {
          x,
          y,
          z
        })
        dxSetShaderValue(pedShader, "portal", {
          x,
          y,
          z
        })
        dxSetShaderValue(shader, "portal", {
          x,
          y,
          z
        })
      end
    end
    local time = now % 200000 / 200000
    dxSetShaderValue(shader, "shadTime", time)
    dxSetShaderValue(portalShader, "shadTime", time * 5)
    if clockSpawned then
      local dp = 0
      if clockDelete then
        dp = getEasingValue(math.min(1, (now - clockDelete) / 3500), "InQuad")
      end
      local hit, x, y, z, he, nx, ny, nz = processLineOfSight(clockX, clockY, pz + 5, clockX, clockY, pz - 10, true, false, false, true, false, false, false, false, clock)
      if hit then
        targetClockZ = z + 2.5
      else
        targetClockZ = pz
      end
      if clockZ < targetClockZ then
        clockZ = clockZ + 2.5 * delta / 1000
        if clockZ > targetClockZ then
          clockZ = targetClockZ
        end
      elseif clockZ > targetClockZ then
        clockZ = clockZ - 2.5 * delta / 1000
        if clockZ < targetClockZ then
          clockZ = targetClockZ
        end
      end
      local p = now % 20000 / 20000
      p = math.sin(p * math.pi)
      local p2 = now % 32500 / 32500
      p2 = math.sin(p2 * math.pi)
      setElementPosition(clock, clockX, clockY, clockZ + 1 * p + 75 * dp)
      if clockSound then
        setElementPosition(clockSound, clockX, clockY, clockZ + 1 * p + 75 * dp)
      end
      local r = math.deg(math.atan2(py - clockY, px - clockX))
      setElementRotation(clock, 25 + 10 * p2, 0, r)
      dxSetShaderValue(shader, "clock", {
        clockX,
        clockY,
        clockZ + 1 * p + 75 * dp
      })
      dxSetShaderValue(pedShader, "clock", {
        clockX,
        clockY,
        clockZ + 1 * p + 75 * dp
      })
      dxSetShaderValue(clockShader, "clock", {
        clockX,
        clockY,
        clockZ + 1 * p + 75 * dp
      })
      if clockDelete then
        if 1 <= dp then
          if isElement(clock) then
            destroyElement(clock)
          end
          clock = nil
          if isElement(clockSound) then
            destroyElement(clockSound)
          end
          clockSound = nil
          clockSpawned = false
          dxSetShaderValue(shader, "clockSpawn", false)
          dxSetShaderValue(pedShader, "clockSpawn", false)
          dxSetShaderValue(clockShader, "clockSpawn", false)
        end
      elseif getDistanceBetweenPoints2D(clockX, clockY, px, py) < 17.5 then
        deleteClock()
      elseif 60000 < now - clockSpawned then
        deleteClock()
      end
    elseif now >= nextClock and not timeUp and tonumber(spawned) then
      createClock(px, py, pz)
    end
    dxSetShaderValue(lightShader, "prog", math.random())
    dxSetRenderTarget(rt4, true)
    dxDrawImage(0, 0, screenX, screenY, rt3)
    dxSetRenderTarget(rt2, true)
    dxDrawImage(0, 0, screenX, screenY, rt, tocolor(255, 255, 255, 255))
    dxSetRenderTarget(rt3, true)
    dxSetRenderTarget(rt, true)
    dxSetRenderTarget()
    dxUpdateScreenSource(screen)
    for i = 1, math.max(2, delta / 8) do
      local r = math.random() * math.pi * 2
      local d = math.random() * 59.49999999999999
      spawnParticle(px + math.cos(r) * d, py + math.sin(r) * d, pz - 1.5 * math.random())
    end
    local cos = math.sin(now / 1000 % (math.pi * 2))
    local sin = math.cos(now / 1000 % (math.pi * 2))
    for i = #particles, 1, -1 do
      local x, y, z = particles[i][1], particles[i][2], particles[i][3]
      local s = particles[i][4]
      local spd = particles[i][5]
      local a = 1 - math.max(0, (math.abs(pz - z) - 3) / 1)
      if 0 < a and 50 > getDistanceBetweenPoints2D(x, y, px, py) then
        x = x + spd * sin
        y = y + spd * cos
        dxDrawMaterialSectionLine3D(x, y, z, x, y, z + s, particles[i][6] * 32, particles[i][7] * 32, 32, 32, particle, s, tocolor(40, 40, 40, particles[i][8] * a), s)
        particles[i][3] = particles[i][3] + delta / 1000 * spd
      else
        table.remove(particles, i)
      end
    end
  end
end
function isDeath()
  return spawned or countdown
end
addEventHandler("onClientPlayerDamage", localPlayer, function(attacker, weapon, bodyPart, loss)
  if spawned or countdown then
    cancelEvent()
  end
end, true, "high+999999999999")
function renderRespawning()
  local now = getTickCount()
  if respawningPortal then
    if tonumber(portalOutDone) then
      local p = (now - portalOutDone) / 4000
      if 0 < p then
        if 1 < p then
          p = 1
          respawning = false
          sightexports.sControls:toggleAllControls(true)
          sightlangCondHandl5(false)
        end
        dxDrawRectangle(0, 0, screenX, screenY, tocolor(255, 255, 255, 255 * (1 - p)))
      else
        dxDrawRectangle(0, 0, screenX, screenY, tocolor(255, 255, 255, 255))
      end
    else
      portalOutDone = now + math.max(0, (1.189 - (isElement(portalOutSound) and getSoundPosition(portalOutSound) or 0)) * 1000 + 5311)
      dxDrawRectangle(0, 0, screenX, screenY, tocolor(255, 255, 255, 255))
    end
    if portalOutSound then
      if not isElement(portalOutSound) then
        portalOutSound = playSound("files/portalout.mp3")
      end
      setSoundVolume(portalOutSound, 1.5)
      portalOutSound = false
    end
  else
    local p = (now - respawning) / 1000
    if 1 < p then
      sightexports.sControls:toggleAllControls(true)
      respawning = false
      sightlangCondHandl5(false)
    else
      dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * (1 - p)))
    end
  end
end
function renderDeath()
  local now = getTickCount()
  local px, py, pz = getElementPosition(localPlayer)
  if tonumber(spawned) then
    local delta = 900000
    if countdown then
      delta = math.max(0, delta - (now - countdown))
    end
    local secs = delta / 1000
    secs = math.floor(secs)
    local mins = math.floor(secs / 60)
    secs = secs - mins * 60
    local m1 = mins % 10
    local m2 = math.floor(mins / 10)
    local s1 = secs % 10
    local s2 = math.floor(secs / 10)
    if type(timerText[1]) == "table" then
      if timerText[1][2] ~= m2 then
        timerText[1] = {
          timerText[1][2],
          m2,
          now
        }
      end
    elseif timerText[1] ~= m2 then
      timerText[1] = {
        timerText[1],
        m2,
        now
      }
    end
    if type(timerText[2]) == "table" then
      if timerText[2][2] ~= m1 then
        timerText[2] = {
          timerText[2][2],
          m1,
          now
        }
      end
    elseif timerText[2] ~= m1 then
      timerText[2] = {
        timerText[2],
        m1,
        now
      }
    end
    if type(timerText[4]) == "table" then
      if timerText[4][2] ~= s2 then
        timerText[4] = {
          timerText[4][2],
          s2,
          now
        }
      end
    elseif timerText[4] ~= s2 then
      timerText[4] = {
        timerText[4],
        s2,
        now
      }
    end
    if type(timerText[5]) == "table" then
      if timerText[5][2] ~= s1 then
        timerText[5] = {
          timerText[5][2],
          s1,
          now
        }
      end
    elseif timerText[5] ~= s1 then
      timerText[5] = {
        timerText[5],
        s1,
        now
      }
    end
    dxDrawImage(0, 0, screenX, screenY, screenShader)
    local p = 1 - (now - spawned) / 20000
    local a = 255 * math.min(1, math.max(0, -p * 20))
    local x = screenX / 2 - timerWidth * 5 / 2
    local y = screenY * 0.85
    local col = tocolor(255, 255, 255, a)
    for i = 1, 5 do
      if type(timerText[i]) == "table" then
        local p = (now - timerText[i][3]) / 300
        if 1 < p then
          p = 1
        end
        dxDrawText(timerText[i][2], x, y, x + timerWidth, y + timerFontH * p, col, timerFontScale, timerFont, "center", "bottom", true)
        dxDrawText(timerText[i][1], x, y + timerFontH * p, x + timerWidth, y + timerFontH, col, timerFontScale, timerFont, "center", "top", true)
        if 1 <= p then
          timerText[i] = timerText[i][2]
        end
      else
        dxDrawText(timerText[i], x, y, x + timerWidth, y + timerFontH, col, timerFontScale, timerFont, "center", "top", true)
      end
      x = x + timerWidth
    end
    if delta <= 10100 and not timeUp then
      timeUp = now
      local s = playSound("files/timeout.mp3")
      setSoundVolume(s, 1.5)
      if clockSpawned then
        deleteClock(true)
      end
    end
    if delta <= 5000 then
      setSoundVolume(bgSound, 0.75 * delta / 5000)
    end
    if portalOutTrigger then
      dxDrawRectangle(0, 0, screenX, screenY, tocolor(255, 255, 255, 255))
      if not isElement(portalOutSound) then
        portalOutSound = playSound("files/portalout.mp3")
      else
        local pos = getSoundPosition(portalOutSound)
        if 1.189 <= pos then
          setSoundPosition(portalOutSound, 0.221)
          pos = 0.221
        end
      end
      setSoundVolume(portalOutSound, 1.5)
      setSoundVolume(portalSound, 0)
    elseif delta <= 0 then
      dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255))
    elseif portalX then
      local portalDistance = math.max(0, getDistanceBetweenPoints3D(px, py, pz, portalX, portalY, portalZ) - 1.5)
      if portalDistance < 10 then
        local p = 1 - portalDistance / 10
        local pos = 0
        if not isElement(portalOutSound) then
          portalOutSound = playSound("files/portalout.mp3")
        else
          pos = getSoundPosition(portalOutSound)
          if 1.189 <= pos then
            if portalDistance <= 0 and not portalOutTrigger then
              portalOutTrigger = true
              triggerServerEvent("deathFoundPortal", localPlayer)
            end
            setSoundPosition(portalOutSound, 0.221)
            pos = 0.221
          end
        end
        setSoundVolume(portalOutSound, p * 1.5)
        setSoundVolume(portalSound, 2 * (1 - p))
        local a1 = (pos - 0.221) / 0.9680000000000001 * (pos % 0.121 / 0.121)
        local a = math.min(1, math.max(0, a1 * (1 - p) + p))
        dxDrawRectangle(0, 0, screenX, screenY, tocolor(255, 255, 255, 255 * a * p))
      else
        if isElement(portalOutSound) then
          setSoundVolume(portalOutSound, 0)
        end
        setSoundVolume(portalSound, 2)
      end
    end
  end
end
function renderDeathEx()
  local now = getTickCount()
  if tonumber(spawned) then
    local p = 1 - (now - spawned) / 20000
    if dStartVert and 3 <= #dStartVert then
      dxDrawPrimitive("trianglestrip", false, unpack(dStartVert))
    end
    if 0.95 <= p then
      dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * math.min(1, (p - 0.95) / 0.05)))
    end
  elseif sightexports.sAccounts:getIsCharacterSelected() then
    dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0))
  end
end
addEventHandler("onClientRender", getRootElement(), function()
  local hp = getElementHealth(localPlayer)
  if hp <= 0 then
    if not deathStart then
      deathStart = getTickCount()
      deathTrigger = false
      spawned = false
      sightexports.sControls:toggleAllControls(false)
      sightexports.sHud:setHudState(false, 5000)
      showChat(false)
      if isElement(bgSound) then
        destroyElement(bgSound)
      end
      bgSound = nil
      dStartVert = {}
      dStartX, dStartY, dStartZ, dStartTX, dStartTY, dStartTZ = getCameraMatrix()
      if isElement(deathStartTheme) then
        destroyElement(deathStartTheme)
      end
      deathStartTheme = nil
      deathStartTheme = playSound("files/start.mp3")
      setStreamerModeVolume(deathStartTheme, 1)
      sightlangCondHandl0(deathStart, "low-9999999999")
      sightlangCondHandl1(deathStart)
      sightlangCondHandl2(spawned or countdown, "high+99999999")
      sightlangCondHandl3(spawned or countdown, "low-9999999999")
      sightlangCondHandl4(spawned or countdown)
    end
  elseif deathStart then
    if isElement(deathStartTheme) then
      destroyElement(deathStartTheme)
    end
    deathStartTheme = nil
    sightexports.sControls:toggleAllControls(true)
    deathStart = false
    setCameraTarget(localPlayer)
    sightexports.sHud:setHudState(true, 500)
    showChat(true)
    dStartVert = false
    dStartX, dStartY, dStartZ = false, false, false
    dStartTX, dStartTY, dStartTZ = false, false, false
    sightlangCondHandl0(deathStart, "low-9999999999")
    sightlangCondHandl1(deathStart)
  end
end)
function getPositionFromElementOffset(m, offX, offY, offZ)
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z
end
local carryingDeathPeds = {}
addEventHandler("onClientPedStreamIn", getRootElement(), function()
  local deathPed = getElementData(source, "deathPed")
  if deathPed then
    setPedAnimation(source, "crack", "crckdeth" .. math.random(1, 3), -1, false, true, false)
    local skin = deathPed[4]
    setElementCollisionsEnabled(source, false)
    if skin then
      local model = sightexports.sGroups:getGroupSkinId(skin)
      if model then
        setElementModel(source, model)
      end
    end
  end
end)
local deathPeds = {}
local carryingPedsHandled = false
addEventHandler("onClientElementDataChange", getRootElement(), function(data, old, new)
  if data == "deathPed" then
    setElementCollisionsEnabled(source, false)
    table.insert(deathPeds, source)
    if exports.sGroups and new and new[4] then
      local model = sightexports.sGroups:getGroupSkinId(new[4])
      if model then
        setElementModel(source, model)
      end
    end
  elseif data == "deathPedCarriedBy" then
    for i = #carryingDeathPeds, 1, -1 do
      if carryingDeathPeds[i][1] == source then
        table.remove(carryingDeathPeds, i)
      end
    end
    if new then
      table.insert(carryingDeathPeds, {
        source,
        new,
        getTickCount()
      })
    else
      if isElement(old) then
        local rx, ry, rz = getElementRotation(old)
        local x, y, z = getElementPosition(old)
        setElementPosition(source, x + math.cos(math.rad(rz) + math.pi / 2), y + math.sin(math.rad(rz) + math.pi / 2), z)
      end
      setElementCollisionsEnabled(source, true)
      setPedAnimation(source, "crack", "crckdeth" .. math.random(1, 3), -1, false, true, false)
    end
    local tmp = 0 < #carryingDeathPeds
    sightlangCondHandl6(tmp)
    sightlangCondHandl7(tmp)
    if new == localPlayer then
      sightexports.sGui:showTooltip()
      sightexports.sControls:toggleControl("jog", false)
      sightexports.sControls:toggleControl("aim_weapon", false)
      sightexports.sControls:toggleControl("fire", false)
      sightexports.sControls:toggleControl("jump", false)
      sightexports.sControls:toggleControl("enter_exit", false)
    end
    if old == localPlayer then
      sightexports.sControls:toggleControl("jog", true)
      sightexports.sControls:toggleControl("aim_weapon", true)
      sightexports.sControls:toggleControl("fire", true)
      sightexports.sControls:toggleControl("jump", true)
      sightexports.sControls:toggleControl("enter_exit", true)
    end
  end
end)
function carryingDeathPreRender()
  local now = getTickCount()
  for i = #carryingDeathPeds, 1, -1 do
    local ped = carryingDeathPeds[i][1]
    local player = carryingDeathPeds[i][2]
    local tick = now - carryingDeathPeds[i][3]
    if isElement(ped) and isElement(player) then
      if 2500 < tick then
        setElementCollisionsEnabled(ped, false)
        if isElementStreamedIn(player) then
          local m = getElementBoneMatrix(player, 33)
          local x, y, z = getPositionFromElementOffset(m, 0.1, -0.2, -0.2)
          local rx, ry, rz = getElementRotation(player)
          setElementPosition(ped, x, y, z)
          setElementRotation(ped, 0, 0, rz, "default", true)
          setPedAnimation(ped, "ped", "drown", -1, false, false, false, true, 0)
          setPedAnimationProgress(ped, "drown", 1)
          setElementDimension(ped, getElementDimension(player))
          setElementInterior(ped, getElementInterior(player))
        end
      end
    else
      if player == localPlayer then
        sightexports.sControls:toggleControl("sprint", true)
        sightexports.sControls:toggleControl("aim_weapon", true)
        sightexports.sControls:toggleControl("fire", true)
        sightexports.sControls:toggleControl("jump", true)
        sightexports.sControls:toggleControl("enter_exit", true)
      end
      table.remove(carryingDeathPeds, i)
    end
  end
end
function carryingDeathPedsProcessed()
  local now = getTickCount()
  for i = #carryingDeathPeds, 1, -1 do
    local ped = carryingDeathPeds[i][1]
    local player = carryingDeathPeds[i][2]
    local tick = now - carryingDeathPeds[i][3]
    if isElement(ped) and isElement(player) and 2500 < tick and isElementStreamedIn(player) then
      setElementBoneRotation(ped, 3, 0, 60, 0)
      setElementBoneRotation(ped, 2, 0, 65, 0)
      setElementBoneRotation(ped, 4, 0, 40, 0)
      setElementBoneRotation(ped, 51, 180, 182, 0)
      setElementBoneRotation(ped, 41, 180, 182, 0)
      setElementBoneRotation(ped, 53, 0, -50, 0)
      setElementBoneRotation(ped, 43, 0, -50, 0)
      setElementBoneRotation(ped, 52, 0, 0, 0)
      setElementBoneRotation(ped, 42, 0, 0, 0)
      setElementBoneRotation(ped, 22, 0, -120, 70)
      setElementBoneRotation(ped, 32, 0, -120, -70)
      sightexports.sCore:updateElementRpHAnim(ped)
      setElementBoneRotation(player, 32, 0, 0, 0)
      setElementBoneRotation(player, 33, 180, 0, -110)
      sightexports.sCore:updateElementRpHAnim(player)
    end
  end
end
local activeButton = false
addEventHandler("onClientClick", getRootElement(), function(button, state, x, y, wx, wy, wz, element)
  if activeButton and activeButton[1] == "pickupbody" and (button == "right" or button == "left") and state == "down" then
    local stamina = sightexports.sHud:getStamina()
    if 0 < stamina then
      triggerServerEvent("startBodyCarry", localPlayer, activeButton[2])
    end
  end
end)

local colorDatas = {
    backgroundColor = sightexports.sGui:getColorCodeToColor("sightgrey1"),
    activeColor = sightexports.sGui:getColorCodeToColor("sightgreen"),
}
addEventHandler("onClientRender", root, function()
  local tmp = false
  local cx, cy = getCursorPosition()
  if cx then
    cx = cx * screenX
    cy = cy * screenY
  end
  for _, pedElement in pairs(deathPeds) do
    if pedElement and isElement(pedElement) and getElementType(pedElement) == "ped" then
      if getElementDimension(localPlayer) == getElementDimension(pedElement) and getElementInterior(localPlayer) == getElementDimension(pedElement) then
        if getElementData(pedElement, "deathPed") and not getElementData(pedElement, "deathPedCarriedBy") then
          local pedPosition = {getElementPosition(pedElement)}
          if 2 > getDistanceBetweenPoints3D(pedPosition[1], pedPosition[2], pedPosition[3], getElementPosition(localPlayer)) then
            local x, y = getScreenFromWorldPosition(pedPosition[1], pedPosition[2], pedPosition[3] - 0.8, 32)
              if x then
                dxDrawRectangle(x - 26, y - 26, 32, 32, colorDatas.backgroundColor)
              if cx and cx <= x + 6 and cx >= x - 26 and cy >= y - 26 and cy <= y + 6 then
                  dxDrawImage(x - 26, y - 26, 32, 32, ":sGui/".. icon .. faTicks[icon], 0, 0, 0, colorDatas.activeColor)
                  sightexports.sGui:showTooltip("Hulla mozgatása")
                  tmp = {"pickupbody", pedElement}
                  sightexports.sGui:setCursorType("link")
              else
                  sightexports.sGui:showTooltip()
                  sightexports.sGui:setCursorType("normal")
                  dxDrawImage(x - 26, y - 26, 32, 32, ":sGui/".. icon .. faTicks[icon])
              end
            end
          end
        end
      end
    end
  end
  activeButton = tmp
end)