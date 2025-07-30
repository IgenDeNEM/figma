local sightexports = {
  sGui = false,
  sDamage = false,
  sWeather = false,
  sWater = false,
  sDashboard = false,
  sVehicles = false,
  sHud = false,
  sCore = false,
  sGroups = false,
  sClothesshop = false,
  sWebdebug = false
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
    local res0 = getResourceFromName("sGui")
    if res0 and getResourceState(res0) == "running" then
      initGmText()
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
screenX, screenY = guiGetScreenSize()
local loginMusicFadeOut = false
local loginMusic = false
function createLoginMusic()
  if isElement(loginMusic) then
    destroyElement(loginMusic)
  end
  loginMusic = nil
  loginMusic = playSound("files/login" .. math.random(1, 7) .. ".mp3", true)
  setStreamerModeVolume(loginMusic, 1)
end
function fadeOutLoginMusic()
  if not loginMusicFadeOut then
    addEventHandler("onClientPreRender", getRootElement(), fadeOutMusicPre)
  end
  loginMusicFadeOut = getTickCount()
end
function fadeOutMusicPre()
  local p = (getTickCount() - loginMusicFadeOut) / 4000
  if 1 <= p then
    loginMusicFadeOut = false
    if isElement(loginMusic) then
      destroyElement(loginMusic)
    end
    loginMusic = nil
    removeEventHandler("onClientPreRender", getRootElement(), fadeOutMusicPre)
  else
    setStreamerModeVolume(loginMusic, 1 - p)
  end
end
local mainColor = "sightgreen"
local mainSecColor = "sightgreen-second"
local loginPanelGui = false
local serialLabel = false
local characterSelectGui = false
local loginButton = false
local loginUsernameInput = false
local loginPasswordInput = false
local loginRememberCheckbox = false
local loginLogoTimer = false
function loginLogoSequence(logo, alreadyOut)
  if loginPanelGui then
    if not alreadyOut then
      sightexports.sGui:playLogoAnimation(logo, "in", 200)
    end
    setTimer(function()
      if loginPanelGui then
        sightexports.sGui:playLogoAnimation(logo, "out", 200)
        loginLogoTimer = setTimer(loginLogoSequence, 1200, 1, logo)
      end
    end, 5000, 1)
  end
end
local charSelected = false
local charSetObj = false
local charSetPeds = {}
local characterDatas = {}
local currentCharacter = 1
local characterDatasGui = false
idles = {
  "shift",
  "stretch",
  "strleg",
  "time"
}
function nextIdleAnimation()
  if charSetPeds and not charSelected then
    for id in pairs(charSetPeds) do
      setPedAnimation(charSetPeds[id], "playidles", idles[math.random(#idles)], -1, false, false)
    end
    setTimer(nextIdleAnimation, math.random(1500, 5000), 1)
  end
end
local loadingEnded = false
local isCharacterSelected = getElementData(localPlayer, "loggedIn")
function getIsCharacterSelected()
  return isCharacterSelected
end
addEvent("characterSelected", true)
addEventHandler("characterSelected", getRootElement(), function(x, y, z, r, int, dim, creationStage, inDeath)
  setTimer(function()
    loadingEnded = false
    sightexports.sGui:showLoadingScreen(7000)
    isCharacterSelected = true
    setTimer(fadeOutLoginMusic, 7000, 1)
    setTimer(function()
      sightexports.sDamage:startRenderingDamages()
      sightexports.sWeather:resetWeather()
      sightexports.sWater:setWaterDimension(0)
      sightexports.sDashboard:loadLateSettings()
      sightexports.sDashboard:resetFogAndFarClip()
      sightexports.sVehicles:canShowVehicleLoader()
    end, 1250, 1)
    if creationStage <= 6 then
      if creationStage == 4 or creationStage == 5 then
        creationStage = 3
      end
      setTimer(setupCharCreationStage, 5000, 1, creationStage)
    end
    setTimer(selectCharacter, 250, 1, x, y, z, r, int, dim, creationStage <= 6, inDeath)
  end, 5250, 1)
  triggerServerEvent("requestPlayerVehicleList", localPlayer)
end)
local charIntroPrompt = false
addEvent("charIntroPromptClick", false)
addEventHandler("charIntroPromptClick", getRootElement(), function(button, state, absoluteX, absoluteY, el, skip)
  showCursor(false)
  if charIntroPrompt then
    sightexports.sGui:deleteGuiElement(charIntroPrompt)
  end
  charIntroPrompt = nil
  charSelected = true
  for id in pairs(charSetPeds) do
    setPedAnimation(charSetPeds[id], "otb", "wtchrace_win", -1, false, false, false)
  end
  removeEventHandler("onClientKey", getRootElement(), charSetKeyEvent)
  selectedPlayerSkin = characterDatas[currentCharacter].skin
  characterName = characterDatas[currentCharacter].name
  triggerServerEvent("selectCharacter", localPlayer, characterDatas[currentCharacter].characterId, skip)
  characterDatas = {}
end)
function charSetKeyEvent(key, por)
  if por and not charIntroPrompt then
    if key == "enter" or key == "num_enter" then
      if characterDatas[currentCharacter].creationStage < 7 and characterDatas[currentCharacter].canSkipCreation == 1 then
        local pw = 340
        local ph = 120
        showCursor(true)
        charIntroPrompt = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
        sightexports.sGui:setWindowTitle(charIntroPrompt, "16/BebasNeueRegular.otf", "SightMTA Intro")
        local titleBarHeight = sightexports.sGui:getTitleBarHeight()
        local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - titleBarHeight - 30 - 6 - 6, charIntroPrompt)
        sightexports.sGui:setLabelAlignment(label, "center", "center")
        sightexports.sGui:setLabelText(label, "Szeretnéd végigjátszani a sziget jelenetet?")
        sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
        local bw = (pw - 18) / 2
        local btn = sightexports.sGui:createGuiElement("button", 6, ph - 30 - 6, bw, 30, charIntroPrompt)
        sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
        sightexports.sGui:setGuiHover(btn, "gradient", {
          "sightgreen",
          "sightgreen-second"
        }, false, true)
        sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
        sightexports.sGui:setButtonText(btn, "Igen")
        sightexports.sGui:setClickEvent(btn, "charIntroPromptClick")
        sightexports.sGui:setClickArgument(btn, false)
        local btn = sightexports.sGui:createGuiElement("button", pw - bw - 6, ph - 30 - 6, bw, 30, charIntroPrompt)
        sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
        sightexports.sGui:setGuiHover(btn, "gradient", {
          "sightred",
          "sightred-second"
        }, false, true)
        sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
        sightexports.sGui:setButtonText(btn, "Nem")
        sightexports.sGui:setClickEvent(btn, "charIntroPromptClick")
        sightexports.sGui:setClickArgument(btn, true)
      else
        charSelected = true
        for id in pairs(charSetPeds) do
          setPedAnimation(charSetPeds[id], "otb", "wtchrace_win", -1, false, false, false)
        end
        removeEventHandler("onClientKey", getRootElement(), charSetKeyEvent)
        selectedPlayerSkin = characterDatas[currentCharacter].skin
        characterName = characterDatas[currentCharacter].name
        triggerServerEvent("selectCharacter", localPlayer, characterDatas[currentCharacter].characterId)
        characterDatas = {}
      end
    elseif 1 < #characterDatas then
      if key == "arrow_r" then
        currentCharacter = currentCharacter + 1
        if currentCharacter > #characterDatas then
          currentCharacter = 1
        end
      elseif key == "arrow_l" then
        currentCharacter = currentCharacter - 1
        if currentCharacter < 1 then
          currentCharacter = #characterDatas
        end
      end
      createCharacterDatas()
    end
  end
end
function getPositionOffset(x, y, z, rx, ry, rz, offX, offY, offZ)
  rx, ry, rz = math.rad(rx), math.rad(ry), math.rad(rz)
  local m = {}
  m[1] = {}
  m[1][1] = math.cos(rz) * math.cos(ry) - math.sin(rz) * math.sin(rx) * math.sin(ry)
  m[1][2] = math.cos(ry) * math.sin(rz) + math.cos(rz) * math.sin(rx) * math.sin(ry)
  m[1][3] = -math.cos(rx) * math.sin(ry)
  m[1][4] = 1
  m[2] = {}
  m[2][1] = -math.cos(rx) * math.sin(rz)
  m[2][2] = math.cos(rz) * math.cos(rx)
  m[2][3] = math.sin(rx)
  m[2][4] = 1
  m[3] = {}
  m[3][1] = math.cos(rz) * math.sin(ry) + math.cos(ry) * math.sin(rz) * math.sin(rx)
  m[3][2] = math.sin(rz) * math.sin(ry) - math.cos(rz) * math.cos(ry) * math.sin(rx)
  m[3][3] = math.cos(rx) * math.cos(ry)
  m[3][4] = 1
  m[4] = {}
  m[4][1], m[4][2], m[4][3] = x, y, z
  m[4][4] = 1
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z
end
local cameraInterpolation = {}
function renderCameraInterpolation()
  local now = getTickCount()
  local progress = math.max(0, (now - cameraInterpolation[3]) / 4000)
  if 0 < progress and not loadingEnded then
    loadingEnded = true
    showChat(true)
    sightexports.sHud:setHudEnabled(true, 4000)
  end
  local x, y, z = interpolateBetween(cameraInterpolation[1][1], cameraInterpolation[1][2], cameraInterpolation[1][3], cameraInterpolation[2][1], cameraInterpolation[2][2], cameraInterpolation[2][3], progress, "OutQuad")
  local x2, y2, z2 = interpolateBetween(cameraInterpolation[1][4], cameraInterpolation[1][5], cameraInterpolation[1][6], cameraInterpolation[2][4], cameraInterpolation[2][5], cameraInterpolation[2][6], progress, "OutQuad")
  setCameraMatrix(x, y, z, x2, y2, z2)
  local a1, a2 = getPedAnimation(localPlayer)
  if a1 ~= "otb" and a2 ~= "wtchrace_win" then
    setElementFrozen(localPlayer, true)
    setPedAnimation(localPlayer, "otb", "wtchrace_win", -1, false, false, false)
  end
  local px, py, pz, rz = unpack(cameraInterpolation[4])
  setElementRotation(localPlayer, 0, 0, rz, "default", true)
  if 1 <= progress then
    local mul = 1280 / screenX
    local screenSource = dxCreateScreenSource(screenX * mul, screenY * mul)
    local rt = dxCreateRenderTarget(256, 256)
    if isElement(screenSource) and isElement(rt) and getElementHealth(localPlayer) > 20 then
      dxUpdateScreenSource(screenSource)
      local x, y, z = getPedBonePosition(localPlayer, 8)
      local x, y = getScreenFromWorldPosition(x, y, z)
      if x then
        dxSetRenderTarget(rt)
        dxDrawImageSection(0, 0, 256, 256, x * mul - 128, y * mul - 128, 256, 256, screenSource)
        dxSetRenderTarget()
        local pixels = dxGetTexturePixels(rt)
        if pixels then
          pixels = dxConvertPixels(pixels, "jpeg", 80)
          triggerLatentServerEvent("gotLoginPicture", localPlayer, pixels)
        end
        pixels = nil
        collectgarbage("collect")
      end
    end
    if isElement(screenSource) then
      destroyElement(screenSource)
    end
    screenSource = nil
    if isElement(rt) then
      destroyElement(rt)
    end
    rt = nil
    removeEventHandler("onClientRender", getRootElement(), renderCameraInterpolation)
    setCameraTarget(localPlayer)
    setPedAnimation(localPlayer)
    setElementFrozen(localPlayer, false)
    setElementPosition(localPlayer, px, py, pz)
  end
end
function selectCharacter(px, py, pz, rz, int, dim, creation, inDeath)
  setTimer(deleteCharacterSelect, 500, 1)
  removeEventHandler("onClientPreRender", getRootElement(), preRenderCharSet)
  setTimer(function()
    if getElementData(localPlayer, "acc.adminLevel") >= 1 then
      exports.sDiscord:initTwoFactor()
    end
    engineRestreamWorld(true)
  end, 7000, 1)
  if not creation and not inDeath then
    setElementInterior(localPlayer, int)
    setElementDimension(localPlayer, dim)
    setElementPosition(localPlayer, px, py, pz)
    setElementRotation(localPlayer, 0, 0, rz)
    setElementFrozen(localPlayer, true)
    setPedAnimation(localPlayer, "otb", "wtchrace_win", -1, false, false, false)
    local x, y, z = getPositionOffset(px, py, pz, 0, 0, rz, 1, 2, 1.15)
    local x2, y2, z2 = getPositionOffset(px, py, pz, 0, 0, rz, 0, 0, 0.25)
    cameraInterpolation[2] = {
      x,
      y,
      z,
      x2,
      y2,
      z2
    }
    local x, y, z = getPositionOffset(px, py, pz, 0, 0, rz, 10, 10, 3.5)
    local x2, y2, z2 = getPositionOffset(px, py, pz, 0, 0, rz, 0, 0, 0.25)
    cameraInterpolation[1] = {
      x,
      y,
      z,
      x2,
      y2,
      z2
    }
    cameraInterpolation[3] = getTickCount() + 5000
    cameraInterpolation[4] = {
      px,
      py,
      pz,
      rz
    }
    addEventHandler("onClientRender", getRootElement(), renderCameraInterpolation)
  end
end
function deleteCharacterSelect()
  if characterSelectGui then
    sightexports.sGui:deleteGuiElement(characterSelectGui)
    characterSelectGui = false
  end
  if characterDatasGui then
    sightexports.sGui:deleteGuiElement(characterDatasGui)
    characterDatasGui = false
  end
  for id in pairs(charSetPeds) do
    if isElement(charSetPeds[id]) then
      destroyElement(charSetPeds[id])
    end
    charSetPeds[id] = nil
  end
  if isElement(charSetObj) then
    destroyElement(charSetObj)
  end
  charSelected = false
  charSetObj = false
  charSetPed = false
end
function preRenderCharSet()
  if charSetPeds then
    setFarClipDistance(500)
    setFogDistance(500)
    setElementInterior(charSetObj, getElementInterior(localPlayer))
    for id in pairs(charSetPeds) do
      setElementInterior(charSetPeds[id], getElementInterior(localPlayer))
      setElementDimension(charSetPeds[id], getElementDimension(localPlayer))
    end
    dxDrawLine3D(0, -2, 0, 0, -4, 20, tocolor(13.65, 15.524999999999999, 20.615000000000002), 1500)
  end
end
function createCharacterDatas()
  if characterDatasGui then
    sightexports.sGui:deleteGuiElement(characterDatasGui)
  end
  characterDatasGui = sightexports.sGui:createGuiElement("null", 0, 0, screenX, screenY)
  local data = characterDatas[currentCharacter]
  for id in pairs(charSetPeds) do
    if data.characterId == id then
      setElementAlpha(charSetPeds[id], 255)
    else
      setElementAlpha(charSetPeds[id], 0)
    end
  end
  local label = sightexports.sGui:createGuiElement("label", screenX / 2 + 32, screenY / 2 - screenY / 3 / 2, 256, 48, characterDatasGui)
  sightexports.sGui:setLabelText(label, utf8.gsub(data.name, "_", " "))
  sightexports.sGui:setLabelFont(label, "30/BebasNeueRegular.otf")
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  local label = sightexports.sGui:createGuiElement("label", screenX / 2 + 32, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getLabelFontHeight(label), 256, 48, characterDatasGui)
  sightexports.sGui:setLabelText(label, "AccountID: " .. sightexports.sGui:getColorCodeHex(mainColor) .. data.accountId)
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  local label = sightexports.sGui:createGuiElement("label", screenX / 2 + 32, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getLabelFontHeight(label), 256, 48, characterDatasGui)
  sightexports.sGui:setLabelText(label, "KarakterID: " .. sightexports.sGui:getColorCodeHex(mainColor) .. data.characterId)
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  local label = sightexports.sGui:createGuiElement("label", screenX / 2 + 32, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getLabelFontHeight(label), 256, 48, characterDatasGui)
  sightexports.sGui:setLabelText(label, "Játszott percek: " .. sightexports.sGui:getColorCodeHex(mainColor) .. sightexports.sGui:thousandsStepper(data.playedMinutes))
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  local label = sightexports.sGui:createGuiElement("label", screenX / 2 + 32, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getLabelFontHeight(label), 256, 48, characterDatasGui)
  sightexports.sGui:setLabelText(label, "Szint: " .. sightexports.sGui:getColorCodeHex(mainColor) .. "Lvl " .. sightexports.sCore:getLevel(data.playedMinutes))
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  local label = sightexports.sGui:createGuiElement("label", screenX / 2 + 32, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getLabelFontHeight(label), 256, 48, characterDatasGui)
  if 0 > data.money then
    sightexports.sGui:setLabelText(label, "Készpénz: " .. sightexports.sGui:getColorCodeHex("sightred") .. sightexports.sGui:thousandsStepper(data.money) .. " $")
  else
    sightexports.sGui:setLabelText(label, "Készpénz: " .. sightexports.sGui:getColorCodeHex(mainColor) .. sightexports.sGui:thousandsStepper(data.money) .. " $")
  end
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  local label = sightexports.sGui:createGuiElement("label", screenX / 2 + 32, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getLabelFontHeight(label), 256, 48, characterDatasGui)
  if 0 > data.bankMoney then
    sightexports.sGui:setLabelText(label, "Bankszámla egyenleg: " .. sightexports.sGui:getColorCodeHex("sightred") .. sightexports.sGui:thousandsStepper(data.bankMoney) .. " $")
  else
    sightexports.sGui:setLabelText(label, "Bankszámla egyenleg: " .. sightexports.sGui:getColorCodeHex(mainColor) .. sightexports.sGui:thousandsStepper(data.bankMoney) .. " $")
  end
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
  sightexports.sGui:setLabelAlignment(label, "left", "top")
  if 1 < #characterDatas then
    local label = sightexports.sGui:createGuiElement("label", 0, screenY - 128 - sightexports.sGui:getFontHeight("12/Ubuntu-L.ttf") - sightexports.sGui:getFontHeight("15/Ubuntu-L.ttf"), screenX, 128, characterDatasGui)
    sightexports.sGui:setLabelText(label, currentCharacter .. "/" .. #characterDatas)
    sightexports.sGui:setLabelFont(label, "15/Ubuntu-L.ttf")
  end
end
function createCharacterSelect()
  setFarClipDistance(550)
  setFogDistance(500)
  local x, y, z
  for id in pairs(charSetPeds) do
    x, y, z = getElementPosition(charSetPeds[id])
  end
  local x1 = getWorldFromScreenPosition(screenX / 2 - screenX / 5 / 2, screenY / 2, 4)
  local x2 = getWorldFromScreenPosition(screenX / 2, screenY / 2, 4)
  setCameraMatrix(x + (x2 - x1), y + 4, z + 0.5, x + (x2 - x1), y, z)
  addEventHandler("onClientPreRender", getRootElement(), preRenderCharSet)
  sightexports.sWeather:setForceTime(12, 0, 0, 1)
  characterSelectGui = sightexports.sGui:createGuiElement("image", 0, 0, screenX, screenY)
  sightexports.sGui:setImageDDS(characterSelectGui, "files/vignette.dds")
  for id in pairs(charSetPeds) do
    x, y, z = getPedBonePosition(charSetPeds[id], 8)
  end
  local x, y = getScreenFromWorldPosition(x, y, z + 0.15)
  local logo
  if x and y then
    local logo = sightexports.sGui:createGuiElement("logo", screenX / 2 - screenX / 5 / 2, y + 64, 128, 128, characterSelectGui)
  end
  local div = sightexports.sGui:createGuiElement("rectangle", screenX / 2 - 1, screenY / 2 - screenY / 3 / 2, 2, screenY / 3, characterSelectGui)
  sightexports.sGui:setGuiBackground(div, "solid", "sightmidgrey")
  createCharacterDatas()
  local h = sightexports.sGui:getFontHeight("label:normal")
  local label = sightexports.sGui:createGuiElement("label", 0, screenY - 48 - h * 1.5 + h, screenX, h, characterSelectGui)
  if 1 < #characterDatas then
    sightexports.sGui:setLabelText(label, "A karakterek között a NYILAKKAL navigálhatsz, kiválasztásához nyomj ENTERT.")
  else
    sightexports.sGui:setLabelText(label, "A karakter kiválasztásához nyomj ENTERT.")
  end
end
addEvent("forgotPassword", false)
addEventHandler("forgotPassword", getRootElement(), function()
  setClipboard("discord.gg/sightmta")
  exports.sGui:showInfobox("i", "Sikeresen kimásoltad a discord meghívót, ahol segítséget tudsz kérni!")
end)
addEvent("openRulesPage", false)
addEventHandler("openRulesPage", getRootElement(), function()
  setClipboard("discord.gg/sightmta")
  exports.sGui:showInfobox("i", "Sikeresen kimásoltad a discord meghívót, ahol segítséget tudsz kérni!")
end)
function createLoginPanel(afterRegistration)
  sightexports.sWeather:setForceTime(12, 0, 0, 1)
  showChat(false)
  sightexports.sHud:setHudEnabled(false, 100)
  showCursor(true)
  loginPanelGui = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
  sightexports.sGui:setGuiBackground(loginPanelGui, "solid", "sightgrey1")
  local vign = sightexports.sGui:createGuiElement("image", 0, 0, screenX, screenY, loginPanelGui)
  sightexports.sGui:setImageDDS(vign, "files/vignette.dds")
  local logo = sightexports.sGui:createGuiElement("logo", screenX / 2, math.floor(screenY * 0.25), 220, 220, loginPanelGui)
  sightexports.sGui:setLogoAnimated(logo, true)
  if isTimer(loginLogoTimer) then
    killTimer(loginLogoTimer)
  end
  sightexports.sGui:playLogoAnimation(logo, "in", 1)
  loginLogoTimer = setTimer(loginLogoSequence, 1000, 1, logo, true)
  local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") / 2, screenX, 48, loginPanelGui)
  sightexports.sGui:setLabelText(label, "S I G H T M T A")
  sightexports.sGui:setLabelFont(label, "27/Ubuntu-L.ttf")
  local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y"), screenX, 24, loginPanelGui)
  sightexports.sGui:setLabelText(label, "w w w . s i g h  t m t a . c o m")
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  sightexports.sGui:setLabelColor(label, mainColor)
  loginUsernameInput = sightexports.sGui:createGuiElement("input", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 10 + 16, 300, false, loginPanelGui)
  sightexports.sGui:setInputPlaceholder(loginUsernameInput, "Felhasználónév")
  sightexports.sGui:setInputIcon(loginUsernameInput, "user")
  sightexports.sGui:setInputMaxLength(loginUsernameInput, 24)
  loginPasswordInput = sightexports.sGui:createGuiElement("input", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 20, 300, false, loginPanelGui)
  sightexports.sGui:setInputPlaceholder(loginPasswordInput, "Jelszó")
  sightexports.sGui:setInputIcon(loginPasswordInput, "unlock-alt")
  sightexports.sGui:setInputPassword(loginPasswordInput, true)
  loginRememberCheckbox = sightexports.sGui:createGuiElement("checkbox", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 10, 300, "normal", loginPanelGui)
  sightexports.sGui:setCheckboxText(loginRememberCheckbox, "Jegyezzen meg")
  sightexports.sGui:setCheckboxColor(loginRememberCheckbox, "sightmidgrey", "sightgrey2", mainColor, "sightmidgrey")
  loginButton = sightexports.sGui:createGuiElement("button", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 10, 300, "large", loginPanelGui)
  sightexports.sGui:setButtonText(loginButton, "Bejelentkezés")
  sightexports.sGui:setGuiFontScheme(loginButton, "large")
  sightexports.sGui:setGuiBackground(loginButton, "solid", mainColor)
  sightexports.sGui:setGuiHover(loginButton, "gradient", {mainColor, mainSecColor}, false, true)
  sightexports.sGui:setClickEvent(loginButton, "loginButtonClick", true)
  if not afterRegistration then
    loadLoginFiles()
  else
    saveLoginFiles()
    sightexports.sGui:setInputValue(loginUsernameInput, afterRegistration)
  end
  if not afterRegistration then
    local y = sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 10
    local width = sightexports.sGui:getTextWidthFont("Elfelejtett adatok | Regisztráció", "label:normal")
    local w2 = sightexports.sGui:getTextWidthFont("Elfelejtett adatok", "label:normal")
    local w3 = sightexports.sGui:getTextWidthFont(" | ", "label:normal")
    local w4 = sightexports.sGui:getTextWidthFont("Regisztráció", "label:normal")
    local label = sightexports.sGui:createGuiElement("label", screenX / 2 - width / 2, y, w2, 32, loginPanelGui)
    sightexports.sGui:setLabelText(label, "Elfelejtett adatok")
    sightexports.sGui:setLabelColor(label, mainColor)
    sightexports.sGui:setLabelAlignment(label, "left")
    sightexports.sGui:setGuiHoverable(label, true)
    sightexports.sGui:guiSetTooltip(label, "Kattints ide, ha elfelejtetted a jelszavadat!")
    sightexports.sGui:setClickEvent(label, "forgotPassword")
    local label = sightexports.sGui:createGuiElement("label", sightexports.sGui:getGuiPosition("last", "x") + w2, y, 0, 32, loginPanelGui)
    sightexports.sGui:setLabelText(label, " | ")
    sightexports.sGui:setLabelColor(label, mainColor)
    sightexports.sGui:setLabelAlignment(label, "left")
    local label = sightexports.sGui:createGuiElement("label", sightexports.sGui:getGuiPosition("last", "x") + w3, y, w4, 32, loginPanelGui)
    sightexports.sGui:setLabelText(label, "Regisztráció")
    sightexports.sGui:setLabelColor(label, mainColor)
    sightexports.sGui:setLabelAlignment(label, "left")
    sightexports.sGui:setGuiHoverable(label, true)
    sightexports.sGui:setClickEvent(label, "tryRegistration")
  end
  local h = sightexports.sGui:getFontHeight("label:normal")
  local width = sightexports.sGui:getTextWidthFont("Serialod: 00000000000000000000000000000000", "label:normal")
  serialLabel = sightexports.sGui:createGuiElement("label", screenX / 2 - width / 2 - 8, screenY - 48 - h * 1.5 - h, width + 16, h, loginPanelGui)
  sightexports.sGui:setLabelText(serialLabel, "betöltés...")
  sightexports.sGui:setLabelColor(serialLabel, "sightmidgrey")
  sightexports.sGui:setGuiHoverable(serialLabel, true)
  sightexports.sGui:guiSetTooltip(serialLabel, "A serialod vágólapra másolásához kattints ide.", false, "up")
  sightexports.sGui:setClickEvent(serialLabel, "copySerialToClipboard")
  local width = sightexports.sGui:getTextWidthFont("SG Serialod: 00000000000000000000000000000000", "label:normal")
  local y = screenY - 48 - h * 1.5 + h
  local width = sightexports.sGui:getTextWidthFont("Mielőtt bejelentkeznél, kötelességed elolvasni a szabályzatunkat, majd azt betartani a játék során.", "label:normal")
  local w2 = sightexports.sGui:getTextWidthFont("Mielőtt bejelentkeznél, kötelességed elolvasni a ", "label:normal")
  local w3 = sightexports.sGui:getTextWidthFont("szabályzatunkat", "label:normal")
  local w4 = sightexports.sGui:getTextWidthFont(", majd azt betartani a játék során.", "label:normal")
  local label = sightexports.sGui:createGuiElement("label", screenX / 2 - width / 2, y, w2, h, loginPanelGui)
  sightexports.sGui:setLabelText(label, "Mielőtt bejelentkeznél, kötelességed elolvasni a ")
  sightexports.sGui:setLabelAlignment(label, "left")
  local label = sightexports.sGui:createGuiElement("label", sightexports.sGui:getGuiPosition("last", "x") + w2, y, w3, h, loginPanelGui)
  sightexports.sGui:setLabelText(label, "szabályzatunkat")
  sightexports.sGui:setLabelColor(label, mainColor)
  sightexports.sGui:setLabelAlignment(label, "left")
  sightexports.sGui:setGuiHoverable(label, true)
  sightexports.sGui:guiSetTooltip(label, "A szabályzat megtekintéséhez kattints ide.", false, "up")
  sightexports.sGui:setClickEvent(label, "openRulesPage")
  local label = sightexports.sGui:createGuiElement("label", sightexports.sGui:getGuiPosition("last", "x") + w3, y, w4, h, loginPanelGui)
  sightexports.sGui:setLabelText(label, ", majd azt betartani a játék során.")
  sightexports.sGui:setLabelAlignment(label, "left")
  local label = sightexports.sGui:createGuiElement("label", 0, screenY - 48 - h * 1.5 + h * 2, screenX, h, loginPanelGui)
  sightexports.sGui:setLabelText(label, "A szabályzat nem ismerete nem mentesít a büntetések alól.")
end
function createBanPanel(banData)
  loginPanelGui = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
  sightexports.sGui:setGuiBackground(loginPanelGui, "solid", "sightgrey1")
  local vign = sightexports.sGui:createGuiElement("image", 0, 0, screenX, screenY, loginPanelGui)
  sightexports.sGui:setImageDDS(vign, "files/vignette.dds")
  if isTimer(loginLogoTimer) then
    killTimer(loginLogoTimer)
  end
  if screenY >= 850 then
    local logo = sightexports.sGui:createGuiElement("logo", screenX / 2, math.floor(screenY * 0.1), 175, 175, loginPanelGui)
    sightexports.sGui:setLogoAnimated(logo, true)
    setTimer(loginLogoSequence, 500, 1, logo)
    local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") / 2, screenX, 48, loginPanelGui)
    sightexports.sGui:setLabelText(label, "S I G H T M T A")
    sightexports.sGui:setLabelFont(label, "27/Ubuntu-L.ttf")
    local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y"), screenX, 24, loginPanelGui)
    sightexports.sGui:setLabelText(label, "w w w . s i g h t - g a m e . c o m")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelColor(label, mainColor)
    local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 32, screenX, 96, loginPanelGui)
    sightexports.sGui:setLabelText(label, "SAJNÁLJUK#ffffff, TE " .. sightexports.sGui:getColorCodeHex("sightred") .. " KI LETTÉL TILTVA #ffffffA SZERVERRŐL!")
    sightexports.sGui:setLabelFont(label, "35/BebasNeueLight.otf")
    local line = sightexports.sGui:createGuiElement("rectangle", screenX / 2 - sightexports.sGui:getLabelTextWidth(label) / 2, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y"), sightexports.sGui:getLabelTextWidth(label), 2)
    sightexports.sGui:setGuiBackground(line, "solid", "sightmidgrey")
  else
    local logo = sightexports.sGui:createGuiElement("logo", screenX / 2, 92, 120, 120, loginPanelGui)
    sightexports.sGui:setLogoAnimated(logo, true)
    setTimer(loginLogoSequence, 500, 1, logo)
    local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") / 2, screenX, 96, loginPanelGui)
    sightexports.sGui:setLabelText(label, "SAJNÁLJUK#ffffff, TE " .. sightexports.sGui:getColorCodeHex("sightred") .. " KI LETTÉL TILTVA #ffffffA SZERVERRŐL!")
    sightexports.sGui:setLabelFont(label, "35/BebasNeueLight.otf")
    local line = sightexports.sGui:createGuiElement("rectangle", screenX / 2 - sightexports.sGui:getLabelTextWidth(label) / 2, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y"), sightexports.sGui:getLabelTextWidth(label), 2)
    sightexports.sGui:setGuiBackground(line, "solid", "sightmidgrey")
  end
  local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 22, screenX, 16, loginPanelGui)
  sightexports.sGui:setLabelText(label, "Account ID:")
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
  sightexports.sGui:setLabelColor(label, "sightmidgrey")
  local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 8, screenX, 48, loginPanelGui)
  sightexports.sGui:setLabelText(label, banData.playerAccountId)
  sightexports.sGui:setLabelFont(label, "26/BebasNeueLight.otf")
  sightexports.sGui:setLabelColor(label, "#ffffff")
  local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 22, screenX, 16, loginPanelGui)
  sightexports.sGui:setLabelText(label, "Adminisztrátor:")
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
  sightexports.sGui:setLabelColor(label, "sightmidgrey")
  local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 8, screenX, 48, loginPanelGui)
  sightexports.sGui:setLabelText(label, banData.adminName)
  sightexports.sGui:setLabelFont(label, "26/BebasNeueLight.otf")
  sightexports.sGui:setLabelColor(label, "#ffffff")
  local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 22, screenX, 16, loginPanelGui)
  sightexports.sGui:setLabelText(label, "Indoklás:")
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
  sightexports.sGui:setLabelColor(label, "sightmidgrey")
  local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 8, screenX, 48, loginPanelGui)
  sightexports.sGui:setLabelText(label, banData.banReason)
  sightexports.sGui:setLabelFont(label, "26/BebasNeueLight.otf")
  sightexports.sGui:setLabelColor(label, "#ffffff")
  local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 22, screenX, 16, loginPanelGui)
  sightexports.sGui:setLabelText(label, "Kitiltás ideje:")
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
  sightexports.sGui:setLabelColor(label, "sightmidgrey")
  local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 8, screenX, 48, loginPanelGui)
  sightexports.sGui:setLabelText(label, sightexports.sGui:formatDate("Y.m.d. h:i:s", "'", banData.banTimestamp))
  sightexports.sGui:setLabelFont(label, "26/BebasNeueLight.otf")
  sightexports.sGui:setLabelColor(label, "#ffffff")
  local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 22, screenX, 16, loginPanelGui)
  sightexports.sGui:setLabelText(label, "Tiltás lejár:")
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
  sightexports.sGui:setLabelColor(label, "sightmidgrey")
  local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 8, screenX, 48, loginPanelGui)
  if 0 >= banData.expireTimestamp then
    sightexports.sGui:setLabelText(label, "SOHA")
  else
    sightexports.sGui:setLabelText(label, sightexports.sGui:formatDate("Y.m.d. h:i:s", "'", banData.expireTimestamp))
  end
  sightexports.sGui:setLabelFont(label, "26/BebasNeueLight.otf")
  sightexports.sGui:setLabelColor(label, "#ffffff")
  local label = sightexports.sGui:createGuiElement("label", 0, screenY - 106, screenX, 106, loginPanelGui)
  sightexports.sGui:setLabelText(label, "Serialod: " .. banData.serial .. "\n#ffffffUnban kérelmet a discordunkon tudsz írni, az adott adminisztrátornak címezve.\n" .. sightexports.sGui:getColorCodeHex(mainColor) .. "discord.gg/sightmta")
  sightexports.sGui:setLabelColor(label, "#ffffff")
end
function deleteLoginPanel()
  sightexports.sGui:deleteGuiElement(loginPanelGui)
  loginPanelGui = false
  loginButton = false
  loginUsernameInput = false
  loginPasswordInput = false
  loginRememberCheckbox = false
end
local serial = false
local serial2 = false
function saveLoginFiles(username, password)
  if fileExists("@sightloginremember.sight") then
    fileDelete("@sightloginremember.sight")
  end
  if username and password then
    local file = fileCreate("@sightloginremember.sight")
    if file then
      fileWrite(file, username .. "\n" .. password)
      fileClose(file)
    end
  end
end
function loadLoginFiles()
  if fileExists("@sightloginremember.sight") then
    local file = fileOpen("@sightloginremember.sight")
    if file then
      local data = fileRead(file, fileGetSize(file))
      data = split(data, "\n")
      sightexports.sGui:setInputValue(loginUsernameInput, data[1] or "")
      sightexports.sGui:setInputValue(loginPasswordInput, data[2] or "")
      sightexports.sGui:setCheckboxChecked(loginRememberCheckbox, true)
      fileClose(file)
    end
  end
end
addEvent("loginResponse", true)
addEventHandler("loginResponse", getRootElement(), function(success, characters)
  if success then
    showCursor(false)
    if 0 < #characters then
      setCameraMatrix(0, 0, 500, 1, 1, 500)
      setTimer(deleteLoginPanel, 500, 1)
      local time = math.random(2500, 5000)
      charSetObj = createObject(3095, 0, 0, 10)
      setElementAlpha(charSetObj, 0)
      setElementInterior(charSetObj, getElementInterior(localPlayer))
      setElementDimension(charSetObj, -1)
      for i = 1, #characters do
        local id = characters[i].characterId
        charSetPeds[id] = createPed(sightexports.sGroups:getGroupSkinId(characters[i].permGroupSkin) or characters[i].skin, 0, 0, 11)
        setElementInterior(charSetPeds[id], getElementInterior(localPlayer))
        setElementDimension(charSetPeds[id], getElementDimension(localPlayer))
      end
      sightexports.sClothesshop:doLoginClothesPreview(charSetPeds)
      for id in pairs(charSetPeds) do
        for id2 in pairs(charSetPeds) do
          if id ~= id2 then
            setElementCollidableWith(charSetPeds[id], charSetPeds[id2], false)
          end
        end
      end
      for id in pairs(charSetPeds) do
        local x, y, z = getElementPosition(charSetPeds[id])
        setCameraMatrix(x, y + 4, z + 0.5, x, y, z)
      end
      characterDatas = characters
      currentCharacter = 1
      setTimer(createCharacterSelect, time * 0.75 - 250, 1)
      setTimer(nextIdleAnimation, time + math.random(500, 1000), 1)
      setTimer(function()
        addEventHandler("onClientKey", getRootElement(), charSetKeyEvent)
      end, time + 250, 1)
      sightexports.sGui:showLoadingScreen(time)
    else
      setTimer(deleteLoginPanel, 500, 1)
      local time = math.random(4000, 7000)
      sightexports.sGui:showLoadingScreen(time)
      setTimer(createCharacterWardrobe, 1000, 1, time - 1000)
      setTimer(fadeOutLoginMusic, time - 1000, 1)
    end
  else
    sightexports.sGui:setClickEvent(loginButton, "loginButtonClick", true)
  end
end)
addEvent("loginButtonClick", true)
addEventHandler("loginButtonClick", getRootElement(), function()
  if not characterSelectGui then
    local username = sightexports.sGui:getInputValue(loginUsernameInput) or ""
    local password = sightexports.sGui:getInputValue(loginPasswordInput) or ""
    if utf8.len(username) > 0 and utf8.len(password) > 0 then
      sightexports.sGui:setClickEvent(loginButton, false)
      if sightexports.sGui:isCheckboxChecked(loginRememberCheckbox) then
        local username = sightexports.sGui:getInputValue(loginUsernameInput) or ""
        local password = sightexports.sGui:getInputValue(loginPasswordInput) or ""
        saveLoginFiles(username, password)
      else
        saveLoginFiles()
      end
      triggerServerEvent("tryLogin", localPlayer, username, password)
    else
      sightexports.sGui:showInfobox("e", "Add meg a felhasználóneved és jelszavad!")
    end
  end
end)
addEvent("copySerialToClipboard", true)
addEventHandler("copySerialToClipboard", getRootElement(), function()
  if serial then
    sightexports.sGui:showInfobox("i", "A serialod vágólapra másolása megtörtént.")
    setClipboard(serial)
  end
end)
addEvent("copySerial2ToClipboard", true)
addEventHandler("copySerial2ToClipboard", getRootElement(), function()
  if serial then
    sightexports.sGui:showInfobox("i", "A serialod vágólapra másolása megtörtént.")
    setClipboard(serial2)
  end
end)
local registerProgress = false
addEvent("tryRegistration", true)
addEventHandler("tryRegistration", getRootElement(), function()
  if not registerProgress then
    registerProgress = true
    triggerServerEvent("tryRegistration", localPlayer)
  end
end)
local rulesPanelGui = false
function createRulesPanel()
  if rulesPanelGui then
    sightexports.sGui:deleteGuiElement(rulesPanelGui)
  end
  rulesPanelGui = nil
  rulesPanelGui = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
  sightexports.sGui:setGuiBackground(rulesPanelGui, "solid", "sightgrey1")
  local vign = sightexports.sGui:createGuiElement("image", 0, 0, screenX, screenY, rulesPanelGui)
  sightexports.sGui:setImageDDS(vign, "files/vignette.dds")
  local y = screenY * 0.1
  local m = screenX * 0.1
  local label = sightexports.sGui:createGuiElement("label", 0, y, screenX, 64, rulesPanelGui)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, "Üdvözlünk a SightMTA-n!")
  sightexports.sGui:setLabelFont(label, "25/BebasNeueBold.otf")
  sightexports.sGui:setLabelColor(label, mainColor)
  local label = sightexports.sGui:createGuiElement("label", m, y + 64, screenX - m * 2, 220, rulesPanelGui)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, "Amennyiben új játékos vagy, kapsz egy kis bevezet\195\181t a játékból.\n\nAz alap koncepció, hogy szinte bármit megtehetsz. Ez lehet akár a második életed is. Egyszerű munkásból lehetsz a város egyik legnagyobb maffiózója, netán egy banda vezére, egy sikeres üzletember, avagy a rend éber őreinek legnagyobb alakja. Vigyázz, hamar nincstelen koldussá is válhatsz, ha nem figyelsz oda! A lehet\195\181ség csak rajtad áll, kérdés, hogy élni tudsz-e vele. Felhívjuk figyelmedet arra is, hogy megfelel\195\181 hozzáállás és komolyság nélkül ez nem fog sikerülni.\n\nJó szórakozást és kellemes időtöltést kíván a SightMTA csapata!")
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
  sightexports.sGui:setLabelWordBreak(label, true)
  local label = sightexports.sGui:createGuiElement("label", m, y + 64 + 220, screenX - m * 2, 220, rulesPanelGui)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, "Ahhoz, hogy továbblépj el kell fogadnod a szabályzatot, valamint az ahhoz tartozó feltételeket.\n\nA szabályok nem ismerete nem mentesít a büntetés alól!\n\nRegisztráció előtt ki kell töltened egy tesztet, ahol minimum 90%-os teljesítményt kell nyújtanod.")
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-B.ttf")
  sightexports.sGui:setLabelWordBreak(label, true)
  y = y + 64 + 440
  local button = sightexports.sGui:createGuiElement("button", screenX / 2 - 200, y, 400, 30, rulesPanelGui)
  sightexports.sGui:setButtonText(button, " Szabályzat megnyitása")
  sightexports.sGui:setButtonFont(button, "15/BebasNeueBold.otf")
  sightexports.sGui:setGuiBackground(button, "solid", "sightblue")
  sightexports.sGui:setGuiHover(button, "gradient", {
    "sightblue",
    "sightblue-second"
  }, false, true)
  sightexports.sGui:setClickEvent(button, "openRulesPage")
  sightexports.sGui:setButtonIcon(button, sightexports.sGui:getFaIconFilename("external-link", 30, "solid"))
  y = y + 30 + 8
  local button = sightexports.sGui:createGuiElement("button", screenX / 2 - 200, y, 400, 30, rulesPanelGui)
  sightexports.sGui:setButtonText(button, "Elolvastam és elfogadom a szabályzatot")
  sightexports.sGui:setButtonFont(button, "15/BebasNeueBold.otf")
  sightexports.sGui:setGuiBackground(button, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(button, "gradient", {
    "sightgreen",
    "sightgreen-second"
  }, false, true)
  sightexports.sGui:setClickEvent(button, "continueRegister")
end
addEvent("registrationResponse", true)
addEventHandler("registrationResponse", getRootElement(), function(canRegister)
  if canRegister then
    deleteLoginPanel()
    createRulesPanel()
    fadeOutLoginMusic()
  else
    registerProgress = false
  end
end)
addEvent("continueRegister", true)
addEventHandler("continueRegister", getRootElement(), function()
  if rulesPanelGui then
    sightexports.sGui:deleteGuiElement(rulesPanelGui)
  end
  rulesPanelGui = nil
  createQuizPanel()
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  createTheIsland()
  local txd = engineLoadTXD("files/at400.txd")
  engineImportTXD(txd, 577)
  local dff = engineLoadDFF("files/at400.dff")
  engineReplaceModel(dff, 577)
end)
local afkWindow = false
local afkLbl = false
function showAntiAfk(mins)
  if not afkWindow then
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    afkWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - 150, screenY / 2 - (titleBarHeight + 128) / 2, 300, titleBarHeight + 128)
    sightexports.sGui:setWindowTitle(afkWindow, "16/BebasNeueRegular.otf", "AFK")
    afkLbl = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, 300, 128, afkWindow)
  end
  sightexports.sGui:setLabelText(afkLbl, "Mivel már [color=sightred]" .. mins .. " perce#ffffff afkolsz, ezért a\njátszott perceid számolása szünetel!\n\nEzen idő alatt a [color=sightred]fizetésed#ffffff sem kapod\nmeg, és adminjail [color=sightred]időd#ffffff sem tellik.")
end
function hideAntiAfk()
  if afkWindow then
    sightexports.sGui:deleteGuiElement(afkWindow)
  end
  afkWindow = nil
  afkLbl = nil
end
function shuffleTable(t)
  local rand = math.random
  local iterations = #t
  local j
  for i = iterations, 2, -1 do
    j = rand(i)
    t[i], t[j] = t[j], t[i]
  end
  return t
end
local quizQuestions = {
  {
    "Mit jelent az 'OOC' kifejezés?",
    "Out of Control",
    "Out of Charism",
    "Out of Character",
    3
  },
  {
    "Mit jelent az 'IC' kifejezés?",
    "In Character",
    "In Cartel",
    "In Cover",
    1
  },
  {
    "Hogyan használod az OOC, azaz karakteren kívüli chatet?",
    "'c' betű vagy /c",
    "'m' betű vagy /m",
    "'b' betű vagy /b",
    3
  },
  {
    "Hogyan használod a szerveren található /me RolePlay parancsot?",
    "Csak a '/do' parancsot használom",
    "Cselekvés kifejezéséhez használom",
    "Történés kifejezéséhez használom",
    2
  },
  {
    "Hogyan használod a szerveren található /do RolePlay parancsot?",
    "Csak a '/me' parancsot használom",
    "Cselekvés kifejezéséhez használom",
    "Történés kifejezéséhez használom",
    3
  },
  {
    "Melyik szabálysértést követed el azzal, ha egy idegennek kiolvasod a nevét és azon szólítod meg?",
    "'DM' (deathmatch)",
    "'MG' (metagaming)",
    "'PG' (powergaming)",
    2
  },
  {
    "Szituáció: Odamegy hozzád egy játékos és IC megkérdezi, hogy kell az inventoryt behozni. Milyen szabálysértést követett el?",
    "'DM' (deathmatch)",
    "Helytelen /me használat",
    "IC-OOC keverés",
    3
  },
  {
    "Ha a szerveren 'bug'-ot találsz, kötelességed minden esetbe jelenteni?",
    "Igen",
    "Nem",
    "Csak akkor ha nincs belőle előnyöm",
    1
  },
  {
    "Hogyan jelented, ha egy játékos nem  tartja be a szabályokat?",
    "IC szólok neki",
    "OOC szólok neki",
    "Jelentem adminnak/panaszkönyvet teszek",
    3
  },
  {
    "Szabad ölni a szerveren?",
    "Igen, bármikor",
    "Csak este 10 után",
    "Igen, ha van rá nyomós indokom",
    3
  },
  {
    "Ha találkozol egy  'bug'-ot kihasználó játékossal kötelességed jelenteni?",
    "Igen, minden esetben kell",
    "Nem, nem kötelező",
    "Igen, kivéve ha a barátom",
    1
  },
  {
    "Mi a weboldalunk címe?",
    "sight-game.net",
    "sight-game.com",
    "sightmta.hu",
    3
  },
  {
    "Ha téged megölnek a játékban és te visszamész bosszút állni, akkor melyik szabályt szeged meg?",
    "'DM' (deathmatch)",
    "'PG' (powergaming)",
    "'RK' (revengekill)",
    3
  }
}
local quizProgress = {
  "sightlightgrey"
}
local quizPanelGui = false
local quizCheck1 = false
local quizCheck2 = false
local quizCheck3 = false
local quizProgressBar = false
local quizQuestion = false
local quizNextQuiestion = false
local quizSize = math.max(800, screenX * 0.5)
local quizPadding = (screenX - quizSize) / 2
function createQuizProgress(first)
  if quizProgressBar then
    sightexports.sGui:deleteGuiElement(quizProgressBar)
  end
  quizProgressBar = sightexports.sGui:createGuiElement("null", 0, 0, screenX, screenY)
  local rect = sightexports.sGui:createGuiElement("rectangle", 32, screenY - 32 - 4, screenX - 64, 4, quizProgressBar)
  sightexports.sGui:setGuiBackground(rect, "solid", "sightmidgrey")
  local w = (screenX - 64) / #quizQuestions
  for k = 1, #quizQuestions do
    local color = quizProgress[k]
    if color then
      local glowEnd = false
      if k == 1 then
        local glow = sightexports.sGui:createGuiElement("image", 19, screenY - 32 - 2 - 16, 13, 32, quizProgressBar)
        sightexports.sGui:setImageColor(glow, color)
        sightexports.sGui:setImageDDS(glow, "files/glowside.dds")
      end
      local gGlow = false
      local gRect = false
      if color == "sightlightgrey" then
        glowEnd = sightexports.sGui:createGuiElement("image", 32 + k * w, screenY - 32 - 2 - 16, 13, 32, quizProgressBar)
        sightexports.sGui:setImageColor(glowEnd, color)
        sightexports.sGui:setImageDDS(glowEnd, "files/glowside.dds")
        sightexports.sGui:setImageRotation(glowEnd, 180)
      elseif k == #quizQuestions then
        gGlow = sightexports.sGui:createGuiElement("image", 32 + (k - 1) * w, screenY - 32 - 2 - 16, w, 32, quizProgressBar)
        sightexports.sGui:setImageColor(gGlow, "sightlightgrey")
        sightexports.sGui:setImageDDS(gGlow, "files/glow.dds")
        gRect = sightexports.sGui:createGuiElement("rectangle", 32 + (k - 1) * w, screenY - 32 - 4, w, 4, quizProgressBar)
        sightexports.sGui:setGuiBackground(gRect, "solid", "sightlightgrey")
      end
      local glow = sightexports.sGui:createGuiElement("image", 32 + (k - 1) * w, screenY - 32 - 2 - 16, w, 32, quizProgressBar)
      sightexports.sGui:setImageColor(glow, color)
      sightexports.sGui:setImageDDS(glow, "files/glow.dds")
      local rect = sightexports.sGui:createGuiElement("rectangle", 32 + (k - 1) * w, screenY - 32 - 4, w, 4, quizProgressBar)
      sightexports.sGui:setGuiBackground(rect, "solid", color)
      if not first then
        if color == "sightlightgrey" then
          sightexports.sGui:setGuiPosition(glowEnd, 32 + k * w - w, screenY - 32 - 2 - 16)
          sightexports.sGui:setGuiPositionAnimated(glowEnd, 32 + k * w, screenY - 32 - 2 - 16, 500)
          sightexports.sGui:setGuiPosition(glow, 32 + (k - 1) * w - w, screenY - 32 - 2 - 16)
          sightexports.sGui:setGuiPositionAnimated(glow, 32 + (k - 1) * w, screenY - 32 - 2 - 16, 500)
          sightexports.sGui:setGuiPosition(rect, 32 + (k - 1) * w - w, screenY - 32 - 4)
          sightexports.sGui:setGuiPositionAnimated(rect, 32 + (k - 1) * w, screenY - 32 - 4, 500)
        elseif quizProgress[k + 1] == "sightlightgrey" or k == #quizQuestions then
          sightexports.sGui:setGuiSize(glow, 0, false, 500)
          sightexports.sGui:setGuiSize(rect, 0, false, 500)
          sightexports.sGui:setGuiSizeAnimated(glow, w, false, 500)
          sightexports.sGui:setGuiSizeAnimated(rect, w, false, 500)
        end
        if color ~= "sightlightgrey" and k == #quizQuestions then
          sightexports.sGui:setGuiPositionAnimated(gGlow, 32 + k * w, screenY - 32 - 2 - 16, 500)
          sightexports.sGui:setGuiPositionAnimated(gRect, 32 + k * w, screenY - 32 - 4, 500)
          sightexports.sGui:setGuiSizeAnimated(gGlow, 0, false, 500)
          sightexports.sGui:setGuiSizeAnimated(gRect, 0, false, 500)
        end
      end
    end
  end
end
local quizY = 0
function createQuiestion(panel, id)
  local y = quizY
  local label = sightexports.sGui:createGuiElement("label", quizPadding, y, screenX, 128, panel)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "REGISZTRÁCIÓ")
  sightexports.sGui:setLabelFont(label, "35/BebasNeueRegular.otf")
  local label = sightexports.sGui:createGuiElement("label", quizPadding + sightexports.sGui:getLabelTextWidth(label), y, screenX, 128, panel)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, " " .. id .. "/" .. #quizQuestions)
  sightexports.sGui:setLabelFont(label, "35/BebasNeueLight.otf")
  y = y + sightexports.sGui:getLabelFontHeight(label)
  local label = sightexports.sGui:createGuiElement("label", quizPadding, y, quizSize, 160, panel)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, quizQuestions[id][1])
  sightexports.sGui:setLabelFont(label, "25/BebasNeueLight.otf")
  y = sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") - 32
  local w = quizSize / 3
  local qc1 = sightexports.sGui:createGuiElement("checkbox", quizPadding, y, w, false, panel)
  sightexports.sGui:setCheckboxText(qc1, quizQuestions[id][2])
  sightexports.sGui:setGuiColorScheme(qc1, quizQuestions[id][5] == 1 and "dark" or "dark-red")
  sightexports.sGui:setCheckboxFont(qc1, "12/Ubuntu-L.ttf")
  if quizQuestions[id][5] ~= 1 then
    sightexports.sGui:setCheckboxIcon(qc1, "times", 0, 0)
  end
  if id ~= #quizProgress then
    sightexports.sGui:setGuiHoverable(qc1)
  else
    sightexports.sGui:setClickEvent(qc1, "quizClick")
    quizCheck1 = qc1
  end
  local qc2 = sightexports.sGui:createGuiElement("checkbox", quizPadding, y, w, false, panel)
  sightexports.sGui:setCheckboxText(qc2, quizQuestions[id][3])
  sightexports.sGui:setGuiColorScheme(qc2, quizQuestions[id][5] == 2 and "dark" or "dark-red")
  sightexports.sGui:setCheckboxFont(qc2, "12/Ubuntu-L.ttf")
  if quizQuestions[id][5] ~= 2 then
    sightexports.sGui:setCheckboxIcon(qc2, "times", 0, 0)
  end
  if id ~= #quizProgress then
    sightexports.sGui:setGuiHoverable(qc2)
  else
    sightexports.sGui:setClickEvent(qc2, "quizClick")
    quizCheck2 = qc2
  end
  local w2 = sightexports.sGui:getCheckboxWidth(qc2)
  sightexports.sGui:setGuiPosition(qc2, quizPadding + w * 1.5 - w2 / 2, y)
  local qc3 = sightexports.sGui:createGuiElement("checkbox", quizPadding, y, w, false, panel)
  sightexports.sGui:setCheckboxText(qc3, quizQuestions[id][4])
  sightexports.sGui:setGuiColorScheme(qc3, quizQuestions[id][5] == 3 and "dark" or "dark-red")
  sightexports.sGui:setCheckboxFont(qc3, "12/Ubuntu-L.ttf")
  if quizQuestions[id][5] ~= 3 then
    sightexports.sGui:setCheckboxIcon(qc3, "times", 0, 0)
  end
  if id ~= #quizProgress then
    sightexports.sGui:setGuiHoverable(qc3)
  else
    sightexports.sGui:setClickEvent(qc3, "quizClick")
    quizCheck3 = qc3
  end
  local w2 = sightexports.sGui:getCheckboxWidth(qc3)
  sightexports.sGui:setGuiPosition(qc3, quizPadding + w * 3 - w2, y)
end
function createQuizEnd()
  local panel = sightexports.sGui:createGuiElement("null", screenX, 0, screenX, screenY)
  local y = quizY
  local good = 0
  for k = 1, #quizProgress do
    if quizProgress[k] == "sightgreen" then
      good = good + 1
    end
  end
  local percent = math.floor(good / #quizQuestions * 100 + 0.5)
  local label = sightexports.sGui:createGuiElement("label", quizPadding, y, quizSize, 128, panel)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelFont(label, "35/BebasNeueRegular.otf")
  if 90 <= percent then
    sightexports.sGui:setLabelText(label, "GRATULÁLUNK!")
    sightexports.sGui:setLabelColor(label, "sightgreen")
  else
    sightexports.sGui:setLabelText(label, "SAJNÁLJUK!")
    sightexports.sGui:setLabelColor(label, "sightred")
  end
  y = y + sightexports.sGui:getLabelFontHeight(label)
  local label = sightexports.sGui:createGuiElement("label", quizPadding, y, quizSize, 256, panel)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelFont(label, "25/BebasNeueLight.otf")
  if 90 <= percent then
    sightexports.sGui:setLabelText(label, "Sikeresen kitöltötted a tesztet!\nFolytathatod a regisztrációs folyamatot.\n \nEredményed: " .. percent .. "%")
    local nextButton = sightexports.sGui:createGuiElement("button", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 20, 300, "large", panel)
    sightexports.sGui:setButtonText(nextButton, "Regisztráció")
    sightexports.sGui:setGuiFontScheme(nextButton, "normal")
    sightexports.sGui:setGuiBackground(nextButton, "solid", mainColor)
    sightexports.sGui:setGuiHover(nextButton, "gradient", {mainColor, mainSecColor}, false, true)
    sightexports.sGui:setClickEvent(nextButton, "quizNextStep")
  else
    sightexports.sGui:setLabelText(label, "Elrontottad a tesztet! Próbáld újra!\nMinimum 90%-ot kell teljesítened!\n \nEredményed: " .. percent .. "%")
    local nextButton = sightexports.sGui:createGuiElement("button", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 20, 300, "large", panel)
    sightexports.sGui:setButtonText(nextButton, "Újrakezdés")
    sightexports.sGui:setGuiFontScheme(nextButton, "normal")
    sightexports.sGui:setGuiColorScheme(nextButton, "red")
    sightexports.sGui:setClickEvent(nextButton, "quizNextStep")
  end
  return panel
end
function createQuizQuestions()
  if quizQuestion then
    sightexports.sGui:deleteGuiElement(quizQuestion)
  end
  if quizNextQuiestion then
    sightexports.sGui:deleteGuiElement(quizNextQuiestion)
  end
  quizNextQuiestion = false
  quizQuestion = sightexports.sGui:createGuiElement("null", 0, 0, screenX, screenY)
  createQuiestion(quizQuestion, #quizProgress)
  if #quizProgress < #quizQuestions then
    quizNextQuiestion = sightexports.sGui:createGuiElement("null", screenX, 0, screenX, screenY)
    createQuiestion(quizNextQuiestion, #quizProgress + 1)
  end
end
function deleteQuizPanel()
  if quizPanelGui then
    sightexports.sGui:deleteGuiElement(quizPanelGui)
  end
  if quizQuestion then
    sightexports.sGui:deleteGuiElement(quizQuestion)
  end
  if quizNextQuiestion then
    sightexports.sGui:deleteGuiElement(quizNextQuiestion)
  end
  if quizProgressBar then
    sightexports.sGui:deleteGuiElement(quizProgressBar)
  end
  quizPanelGui = false
  quizCheck1 = false
  quizCheck2 = false
  quizCheck3 = false
  quizProgressBar = false
  quizQuestion = false
  quizNextQuiestion = false
end
function createQuizPanel()
  quizProgress = {
    "sightlightgrey"
  }
  deleteQuizPanel()
  quizQuestions = shuffleTable(quizQuestions)
  for k = 1, #quizQuestions do
    local goodAnswer = quizQuestions[k][1 + quizQuestions[k][5]]
    local answers = {}
    for i = 2, 4 do
      table.insert(answers, quizQuestions[k][i])
    end
    answers = shuffleTable(answers)
    for i = 1, 3 do
      if answers[i] == goodAnswer then
        quizQuestions[k][5] = i
      end
      quizQuestions[k][1 + i] = answers[i]
    end
  end
  quizPanelGui = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
  sightexports.sGui:setGuiBackground(quizPanelGui, "solid", "sightgrey1")
  local vign = sightexports.sGui:createGuiElement("image", 0, 0, screenX, screenY, quizPanelGui)
  sightexports.sGui:setImageDDS(vign, "files/vignette.dds")
  if screenY >= 850 then
    local logo = sightexports.sGui:createGuiElement("logo", screenX / 2, math.floor(screenY * 0.1), 200, 200, quizPanelGui)
    local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") / 2, screenX, 48, quizPanelGui)
    sightexports.sGui:setLabelText(label, "S I G H T M T A")
    sightexports.sGui:setLabelFont(label, "27/Ubuntu-L.ttf")
    local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y"), screenX, 24, quizPanelGui)
    sightexports.sGui:setLabelText(label, "w w w . s i g h t m t a . h u")
    sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    sightexports.sGui:setLabelColor(label, mainColor)
  else
    local logo = sightexports.sGui:createGuiElement("logo", screenX / 2, 92, 120, 120, quizPanelGui)
  end
  quizY = sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 64
  createQuizQuestions()
  createQuizProgress(true)
end
addEvent("initNextQuiz", true)
addEventHandler("initNextQuiz", getRootElement(), createQuizQuestions)
addEvent("quizNextStep", true)
addEventHandler("quizNextStep", getRootElement(), function()
  local good = 0
  for k = 1, #quizProgress do
    if quizProgress[k] == "sightgreen" then
      good = good + 1
    end
  end
  local percent = math.floor(good / #quizQuestions * 100 + 0.5)
  if 90 <= percent then
    deleteQuizPanel()
    createRegisterPanel()
  else
    createQuizPanel()
  end
end)
addEvent("quizClick", true)
addEventHandler("quizClick", getRootElement(), function()
  sightexports.sGui:setGuiHoverable(quizCheck1, false)
  sightexports.sGui:setGuiHoverable(quizCheck2, false)
  sightexports.sGui:setGuiHoverable(quizCheck3, false)
  local success = sightexports.sGui:isCheckboxChecked(quizCheck1) and quizQuestions[#quizProgress][5] == 1 or sightexports.sGui:isCheckboxChecked(quizCheck2) and quizQuestions[#quizProgress][5] == 2 or sightexports.sGui:isCheckboxChecked(quizCheck3) and quizQuestions[#quizProgress][5] == 3
  quizProgress[#quizProgress] = success and "sightgreen" or "sightred"
  if success then
    sightexports.sGui:showInfobox("s", "Helyes válasz!")
  else
    sightexports.sGui:showInfobox("e", "Helytelen válasz!")
  end
  sightexports.sGui:setGuiColorScheme(quizCheck1, quizQuestions[#quizProgress][5] == 1 and "dark-text-green" or "dark-text-red")
  sightexports.sGui:setGuiColorScheme(quizCheck2, quizQuestions[#quizProgress][5] == 2 and "dark-text-green" or "dark-text-red")
  sightexports.sGui:setGuiColorScheme(quizCheck3, quizQuestions[#quizProgress][5] == 3 and "dark-text-green" or "dark-text-red")
  local last = false
  if #quizProgress < #quizQuestions then
    table.insert(quizProgress, "sightlightgrey")
  elseif #quizProgress == #quizQuestions then
    quizNextQuiestion = createQuizEnd()
    last = true
  end
  setTimer(function()
    sightexports.sGui:setGuiPositionAnimated(quizQuestion, -screenX, 0, 2000, false, "InOutQuad")
    sightexports.sGui:setGuiPositionAnimated(quizNextQuiestion, 0, 0, 2000, not last and "initNextQuiz" or false, "InOutQuad")
  end, 1250, 1)
  createQuizProgress()
end)
local registerPanelGui = false
local registerLogoTimer = false
local registerUsername = false
local registerPassword = false
local registerPassword2 = false
local registerEmail = false
local registerEmail2 = false
local registerButton = false
function registerLogoSequence(logo)
  if registerPanelGui then
    sightexports.sGui:playLogoAnimation(logo, "in", 200)
    setTimer(function()
      if registerPanelGui then
        sightexports.sGui:playLogoAnimation(logo, "out", 200)
        registerLogoTimer = setTimer(registerLogoSequence, 1200, 1, logo)
      end
    end, 5000, 1)
  end
end
function deleteRegisterPanel()
  if registerPanelGui then
    sightexports.sGui:deleteGuiElement(registerPanelGui)
  end
  registerPanelGui = false
  registerLogoTimer = false
  registerUsername = false
  registerPassword = false
  registerPassword2 = false
  registerEmail = false
  registerEmail2 = false
  registerButton = false
end
function createRegisterPanel()
  deleteRegisterPanel()
  registerPanelGui = sightexports.sGui:createGuiElement("rectangle", 0, 0, screenX, screenY)
  sightexports.sGui:setGuiBackground(registerPanelGui, "solid", "sightgrey1")
  local vign = sightexports.sGui:createGuiElement("image", 0, 0, screenX, screenY, registerPanelGui)
  sightexports.sGui:setImageDDS(vign, "files/vignette.dds")
  local logo = sightexports.sGui:createGuiElement("logo", screenX / 2, math.floor(screenY * 0.15), 220, 220, registerPanelGui)
  sightexports.sGui:setLogoAnimated(logo, true)
  if isTimer(registerLogoTimer) then
    killTimer(registerLogoTimer)
  end
  registerLogoTimer = setTimer(registerLogoSequence, 500, 1, logo)
  local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") / 2, screenX, 48, registerPanelGui)
  sightexports.sGui:setLabelText(label, "S I G H T M T A")
  sightexports.sGui:setLabelFont(label, "27/Ubuntu-L.ttf")
  local label = sightexports.sGui:createGuiElement("label", 0, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y"), screenX, 24, registerPanelGui)
  sightexports.sGui:setLabelText(label, "w w w . s i g h t - g a m e . c o m")
  sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
  sightexports.sGui:setLabelColor(label, mainColor)
  registerUsername = sightexports.sGui:createGuiElement("input", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 10 + 16, 300, false, registerPanelGui)
  sightexports.sGui:setInputPlaceholder(registerUsername, "Felhasználónév")
  sightexports.sGui:setInputIcon(registerUsername, "user")
  sightexports.sGui:guiSetTooltip(registerUsername, "Ezzel lépsz majd be. Nem a karaktered neve! Minimum 4, maximum 24 karakter.\nTartalmazhat: betűk (ékezet nélkül), számok, pont, vessző, aláhúzás.")
  sightexports.sGui:setInputMaxLength(registerUsername, 24)
  registerPassword = sightexports.sGui:createGuiElement("input", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 20, 300, false, registerPanelGui)
  sightexports.sGui:setInputPlaceholder(registerPassword, "Jelszó")
  sightexports.sGui:setInputIcon(registerPassword, "unlock-alt")
  sightexports.sGui:setInputPassword(registerPassword, true)
  sightexports.sGui:guiSetTooltip(registerPassword, "Minimum 6 karakter. Tartalmaznia kell számot, valamint kis- és nagybetűt is.")
  registerPassword2 = sightexports.sGui:createGuiElement("input", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 20, 300, false, registerPanelGui)
  sightexports.sGui:setInputPlaceholder(registerPassword2, "Jelszó újra")
  sightexports.sGui:setInputIcon(registerPassword2, "unlock-alt")
  sightexports.sGui:setInputPassword(registerPassword2, true)
  sightexports.sGui:guiSetTooltip(registerPassword2, "Minimum 6 karakter. Tartalmaznia kell számot, valamint kis- és nagybetűt is.")
  registerEmail = sightexports.sGui:createGuiElement("input", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 20, 300, false, registerPanelGui)
  sightexports.sGui:setInputPlaceholder(registerEmail, "Valós, létező e-mail cím")
  sightexports.sGui:setInputIcon(registerEmail, "envelope-open-text")
  registerEmail2 = sightexports.sGui:createGuiElement("input", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 20, 300, false, registerPanelGui)
  sightexports.sGui:setInputPlaceholder(registerEmail2, "Valós, létező e-mail cím újra")
  sightexports.sGui:setInputIcon(registerEmail2, "envelope-open-text")
  registerInviteCode = sightexports.sGui:createGuiElement("input", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 20, 300, false, registerPanelGui)
  sightexports.sGui:setInputPlaceholder(registerInviteCode, "Meghívókód (ha van)")
  sightexports.sGui:setInputIcon(registerInviteCode, "envelope-open-text")
  registerButton = sightexports.sGui:createGuiElement("button", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 20, 300, "large", registerPanelGui)
  sightexports.sGui:setButtonText(registerButton, "Regisztráció")
  sightexports.sGui:setGuiFontScheme(registerButton, "normal")
  sightexports.sGui:setGuiBackground(registerButton, "solid", mainColor)
  sightexports.sGui:setGuiHover(registerButton, "gradient", {mainColor, mainSecColor}, false, true)
  sightexports.sGui:setClickEvent(registerButton, "registerButtonClick", true)
  local label = sightexports.sGui:createGuiElement("label", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y") + 20, 300, 32, registerPanelGui)
  sightexports.sGui:setLabelText(label, "Figyelem!")
  sightexports.sGui:setLabelFont(label, "14/Ubuntu-L.ttf")
  local label = sightexports.sGui:createGuiElement("label", screenX / 2 - 150, sightexports.sGui:getGuiPosition("last", "y") + sightexports.sGui:getGuiSize("last", "y"), 300, 48, registerPanelGui)
  sightexports.sGui:setLabelText(label, "Fontos, hogy valós, létező e-mail címet adj meg,\nmivel ha elfelejted adataid, csak ez alapján tudunk segíteni.")
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-L.ttf")
end
local registrationProcess = false
addEvent("registrationEndResponse", true)
addEventHandler("registrationEndResponse", getRootElement(), function(state, serial1, serial2, username)
  if state then
    deleteRegisterPanel()
    createLoginPanel(username)
    sightexports.sGui:setLabelText(serialLabel, "Serialod: " .. serial1)
    sightexports.sGui:showInfobox("s", "Sikeres regisztráció! Mostmár bejelentkezhetsz!")
  else
    registrationProcess = false
  end
end)
addEvent("registerButtonClick", true)
addEventHandler("registerButtonClick", getRootElement(), function()
  if not registrationProcess then
    local username = sightexports.sGui:getInputValue(registerUsername) or ""
    local password = sightexports.sGui:getInputValue(registerPassword) or ""
    local email = sightexports.sGui:getInputValue(registerEmail) or ""
    if utf8.len(username) < 1 or utf8.len(password) < 1 or utf8.len(email) < 1 or utf8.len(sightexports.sGui:getInputValue(registerPassword2)) < 1 or utf8.len(sightexports.sGui:getInputValue(registerEmail2)) < 1 then
      sightexports.sGui:showInfobox("e", "Minden mezőt ki kell töltened!")
    elseif utf8.len(username) < 4 then
      sightexports.sGui:showInfobox("e", "A megadott felhasználónév túl rövid! (Minimum 4 karakter!)")
    elseif utf8.len(username) > 24 then
      sightexports.sGui:showInfobox("e", "A megadott felhasználónév túl hosszú! (Maximum 24 karakter!)")
    elseif utf8.len(password) < 6 then
      sightexports.sGui:showInfobox("e", "A megadott jelszó túl rövid! (Minimum 6 karakter!)")
    elseif not (utf8.match(password, "[a-z]") and utf8.match(password, "[A-Z]")) or not utf8.match(password, "[0-9]") then
      sightexports.sGui:showInfobox("e", "A megadott jelszónak tartalmaznia kell számot, valamint kis- és nagybetűt is!")
    elseif utf8.match(username, "[^a-zA-Z0-9_%.%-%,]") then
      sightexports.sGui:showInfobox("e", "A megadott felhasználónév nem megfelelő formátumú!")
    elseif not utf8.match(email, "[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?") then
      sightexports.sGui:showInfobox("e", "A megadott e-mail cím nem megfelelő formátumú!")
    elseif password ~= sightexports.sGui:getInputValue(registerPassword2) then
      sightexports.sGui:showInfobox("e", "A megadott jelszavak nem egyeznek meg!")
    elseif email ~= sightexports.sGui:getInputValue(registerEmail2) then
      sightexports.sGui:showInfobox("e", "A megadott e-mail címek nem egyeznek meg!")
    else
      registrationProcess = true
      triggerServerEvent("tryEndRegistration", localPlayer, username, password, email, sightexports.sGui:getInputValue(registerInviteCode))
    end
  end
end)
local gotBanState = false
addEvent("receiveBanState", true)
addEventHandler("receiveBanState", getRootElement(), function(data, serial, serial2)
  if not gotBanState then
    gotBanState = true
    if loginPanelGui then
      deleteLoginPanel()
    end
    if data.state then
      createBanPanel(data)
    else
      local logged = getElementData(localPlayer, "loggedIn")
      if logged then
      else
        createLoginMusic()
        createLoginPanel()
        sightexports.sGui:setLabelText(serialLabel, "Serialod: " .. serial)
        setElementPosition(localPlayer, 0, 0, 1500)
        setElementFrozen(localPlayer, true)
      end
    end
  end
end)
local gamemodeText = false
function initGmText()
  if isElement(gamemodeText) then
    destroyElement(gamemodeText)
  end
  gamemodeText = nil
  if getElementData(localPlayer, "loggedIn") then
    gamemodeText = guiCreateLabel(0, screenY - 25, screenX - 70, 24, "SightMTA # Account ID: " .. getElementData(localPlayer, "char.accID") .. " # " .. sightexports.sGui:formatDate("Y.m.d.", "'", getRealTime().timestamp) .. " # ", false)
  else
    gamemodeText = guiCreateLabel(0, screenY - 25, screenX - 1, 24, "SightMTA # " .. sightexports.sGui:formatDate("Y.m.d.", "'", getRealTime().timestamp), false)
  end
  guiLabelSetVerticalAlign(gamemodeText, "bottom")
  guiLabelSetHorizontalAlign(gamemodeText, "right")
  guiSetAlpha(gamemodeText, 0.5)
end
local ts = getRealTime()
local yearday = ts.yearday
setTimer(function()
  local ts = getRealTime()
  if yearday ~= ts.yearday then
    yearday = ts.yearday
    initGmText()
  end
end, 60000, 0)
addEventHandler("onClientElementDataChange", localPlayer, function(dataName, oldValue, newValue)
  if dataName == "afkMinutes" then
    if 20 < newValue and getElementData(source, "loggedIn") then
      showAntiAfk(newValue)
    else
      hideAntiAfk()
    end
  elseif dataName == "loggedIn" then
    initGmText()
  end
end)
local afkState = false
local currentAfkState = getElementData(localPlayer, "afk")
local lastTick = getTickCount()
addEventHandler("onClientRender", getRootElement(), function()
  local currentTick = getTickCount()
  if 60000 <= currentTick - lastTick then
    afkState = true
  end
  if currentAfkState ~= afkState then
    currentAfkState = afkState
    setElementData(localPlayer, "afk", afkState)
  end
end)
addEventHandler("onClientRestore", getRootElement(), function()
  lastTick = getTickCount()
  afkState = false
end)
addEventHandler("onClientMinimize", getRootElement(), function()
  afkState = true
end)
addEventHandler("onClientCursorMove", getRootElement(), function()
  lastTick = getTickCount()
  afkState = false
end)
addEventHandler("onClientKey", getRootElement(), function()
  lastTick = getTickCount()
  afkState = false
end)
addEvent("gotPaydayData", true)
addEventHandler("gotPaydayData", getRootElement(), function(data)
  sightexports.sGui:showInfobox("i", "Megérkezett a fizetésed!")
  outputChatBox("[color=sightgreen][SightMTA - Fizetés]:", 255, 255, 255, true)
  for i = 1, #data do
    outputChatBox(data[i], 255, 255, 255, true)
  end
end)
local serverLogo = createObject(exports.sModloader:getModelId("v4_statue"), 1479.55,-1641.61, 14.6484, 0, 0, 180)
setTimer(function(serverLogo)
  rot = {getElementRotation(serverLogo)}
  setElementRotation(serverLogo, rot[1], rot[2], rot[3] + 0.25)
end, 10, 0, serverLogo)