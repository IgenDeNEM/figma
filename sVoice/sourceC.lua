local sightexports = {
  sGroups = false,
  sGui = false,
  sNames = false,
  sHud = false
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
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    faTicks = sightexports.sGui:getFaTicks()
    refreshColors()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
local screenX, screenY = guiGetScreenSize()
local voiceVolume = 30
local customBind = "Q"
bindKey(customBind, "down", "voiceptt", "1")
bindKey(customBind, "up", "voiceptt", "0")
function getCustomBind()
  return customBind
end
function setCustomBind(new)
  if customBind then
    unbindKey(customBind, "down", "voiceptt", "1")
    unbindKey(customBind, "up", "voiceptt", "0")
  end
  customBind = new
  if customBind then
    bindKey(customBind, "down", "voiceptt", "1")
    bindKey(customBind, "up", "voiceptt", "0")
  end
end
function getVoiceVolume()
  return voiceVolume
end
local selfCall = false
function setVoiceVolume(v)
  voiceVolume = v
  setSoundVolume(localPlayer, voiceVolume)
end
local playerStreamList = getElementsByType("player", getRootElement())
local voiceState = {}
local radioChannels = {}
local selfRadio = false
local selfRadioName = false
local selfRadioNameShort = false
local names = {}
local adminDutyState = false
function setCallState(st)
  selfCall = st
  if selfRadio or selfCall or adminDutyState then
    triggerServerEvent("refreshVoiceStream", localPlayer, playerStreamList)
  end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  setSoundVolume(localPlayer, voiceVolume)
  local players = getElementsByType("player")
  for i = 1, #players do
    local name = getElementData(players[i], "visibleName")
    if name then
      names[players[i]] = utf8.gsub(name, "_", " ")
    end
    local channel = getElementData(players[i], "voiceRadioChannel")
    if channel then
      if not radioChannels[channel] then
        radioChannels[channel] = {}
      end
      table.insert(radioChannels[channel], players[i])
    end
  end
  adminDutyState = getElementData(localPlayer, "adminDuty")
  selfRadio = getElementData(localPlayer, "voiceRadioChannel")
  playerStreamList = getElementsByType("player", getRootElement())
  if selfRadio or selfCall or adminDutyState then
    triggerServerEvent("refreshVoiceStream", localPlayer, playerStreamList)
  end
  if selfRadio then
    selfRadioName = sightexports.sGroups:getGroupName(selfRadio)
    selfRadioNameShort = selfRadio
  end
end)
local voiceOff = {}
addEventHandler("onClientPlayerQuit", getRootElement(), function()
  for old in pairs(radioChannels) do
    for k = 1, #radioChannels[old] do
      if radioChannels[old][k] == source then
        table.remove(radioChannels[old], k)
        break
      end
    end
  end
  names[source] = nil
  voiceState[source] = nil
  voiceOff[source] = nil
end)
addEventHandler("onClientElementDataChange", getRootElement(), function(data, old, new)
  if data == "adminDuty" and source == localPlayer then
    adminDutyState = new
    if new then
      triggerServerEvent("refreshVoiceStream", localPlayer, playerStreamList)
    end
  elseif data == "visibleName" then
    local name = getElementData(source, "visibleName")
    if name then
      names[source] = utf8.gsub(name, "_", " ")
    end
  elseif data == "voiceRadioChannel" and new ~= old then
    if old then
      if not radioChannels[old] then
        radioChannels[old] = {}
      end
      for k = 1, #radioChannels[old] do
        if radioChannels[old][k] == source then
          table.remove(radioChannels[old], k)
          break
        end
      end
    end
    if new then
      if not radioChannels[new] then
        radioChannels[new] = {}
      end
      table.insert(radioChannels[new], source)
    end
    if source == localPlayer then
      selfRadio = new
      if selfRadio then
        triggerServerEvent("refreshVoiceStream", localPlayer, playerStreamList)
        selfRadioName = sightexports.sGroups:getGroupName(selfRadio)
        selfRadioNameShort = selfRadio
      end
    end
  end
end)
local radioList = {}
local found = {}
local lvl = 0
local adminVoiceActive
local voiceWindow = false
addEvent("adminVoiceRequest", true)
addEventHandler("adminVoiceRequest", getRootElement(), function(adminName)
  local windowWidth = 350
  local windowHeight = 100
  local titleBarHeight = sightexports.sGui:getTitleBarHeight()
  voiceWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - windowWidth / 2, screenY / 2 - windowHeight / 2, windowWidth, windowHeight)
  sightexports.sGui:setWindowTitle(voiceWindow, "16/BebasNeueRegular.otf", "SightMTA - Voice")
  local label = sightexports.sGui:createGuiElement("label", 5, 15, windowWidth - 10, windowHeight - 30 - 5, voiceWindow)
  sightexports.sGui:setLabelAlignment(label, "center", "center")
  sightexports.sGui:setLabelText(label, sightexports.sGui:getColorCodeHex("sightblue") .. adminName .. " #ffffff beszédjogot szeretne adni neked.")
  local btn = sightexports.sGui:createGuiElement("button", 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, voiceWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  })
  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
  sightexports.sGui:setButtonText(btn, "Elfogadás")
  sightexports.sGui:setClickEvent(btn, "acceptAdminVoice", true)
  local btn = sightexports.sGui:createGuiElement("button", 5 + (windowWidth - 15) / 2 + 5, windowHeight - 30 - 5, (windowWidth - 15) / 2, 30, voiceWindow)
  sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
  sightexports.sGui:setGuiHover(btn, "gradient", {
    "sightred",
    "sightred-second"
  })
  sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
  sightexports.sGui:setButtonTextColor(btn, "#ffffff")
  sightexports.sGui:setButtonText(btn, "Elutasítás")
  sightexports.sGui:setClickEvent(btn, "declineAdminVoice", false)
end)
addEvent("acceptAdminVoice", true)
addEventHandler("acceptAdminVoice", getRootElement(), function()
  adminVoiceActive = getTickCount() + 300000
  triggerServerEvent("adminVoiceResponse", localPlayer, true)
  triggerServerEvent("refreshVoiceStream", localPlayer, playerStreamList)
  if voiceWindow then
    sightexports.sGui:deleteGuiElement(voiceWindow)
  end
  voiceWindow = false
end)
addEvent("declineAdminVoice", true)
addEventHandler("declineAdminVoice", getRootElement(), function()
  triggerServerEvent("adminVoiceResponse", localPlayer, false)
  adminVoiceActive = false
  if voiceWindow then
    sightexports.sGui:deleteGuiElement(voiceWindow)
  end
  voiceWindow = false
end)
addEvent("endAdminVoice", true)
addEventHandler("endAdminVoice", getRootElement(), function()
  adminVoiceActive = false
  if voiceWindow then
    sightexports.sGui:deleteGuiElement(voiceWindow)
  end
  voiceWindow = false
end)
local callPartner = false
addEvent("setVoiceCallPartner", true)
addEventHandler("setVoiceCallPartner", getRootElement(), function(new)
  callPartner = new
end)
addEventHandler("onClientPreRender", getRootElement(), function()
  local cx, cy, cz, cx2, cy2, cz2 = getCameraMatrix()
  radioList = {}
  lvl = 0
  found = {}
  if adminVoiceActive or adminDutyState then
    local l, r = getSoundLevelData(localPlayer)
    if l and r then
      lvl = (l + r) / 65536
    elseif l then
      lvl = l / 32768
    elseif r then
      lvl = r / 32768
    else
      lvl = 0
    end
  end
  if callPartner then
    if isElement(callPartner) then
      found[callPartner] = true
      setSoundVolume(callPartner, voiceVolume)
      setSoundPan(callPartner, 0)
    end
  elseif selfRadio then
    for k = 1, #radioChannels[selfRadio] do
      local v = radioChannels[selfRadio][k]
      if voiceOff[v] and getTickCount() - voiceOff[v] > 250 then
        playSound("files/radioff.mp3")
        voiceState[v] = false
        voiceOff[v] = false
        sightexports.sNames:setVoiceState(v, nil)
      end
      found[v] = "group"
      setSoundVolume(v, voiceVolume)
      setSoundPan(v, 0)
      local l, r = getSoundLevelData(v)
      local ltmp = 0
      if l and r then
        ltmp = (l + r) / 65536
      elseif l then
        ltmp = l / 32768
      elseif r then
        ltmp = r / 32768
      end
      if 0 < ltmp then
        local data = getSoundFFTData(v, 256, 7)
        if voiceState[v] then
          if not data and not voiceOff[v] then
            voiceOff[v] = getTickCount()
          end
          local dat = {v}
          for i = 0, 5 do
            local a = 0
            if data and data[i] and 0 < data[i] then
              a = math.sqrt(data[i]) * 3
            end
            if v == localPlayer then
              lvl = ltmp
            end
            table.insert(dat, a)
          end
          table.insert(radioList, dat)
        end
      elseif voiceState[v] then
        table.insert(radioList, {v})
      end
    end
  end
  for i = 1, #playerStreamList do
    local v = playerStreamList[i]
    if isElement(v) and not found[v] then
      if voiceState[v] then
        if voiceOff[v] then
          if getTickCount() - voiceOff[v] > 250 then
            voiceState[v] = false
            voiceOff[v] = false
            sightexports.sNames:setVoiceState(v, nil)
          end
        else
          local x, y, z = getElementPosition(v)
          local dx = x - cx
          local dy = y - cy
          local dz = z - cz
          local fDistance = math.sqrt(dx * dx + dy * dy + dz * dz)
          local fMinDistance = 2.5
          local fMaxDistance = 25
          local fDistDiff = fMaxDistance - fMinDistance
          local fVolume
          if fDistance <= fMinDistance then
            fVolume = voiceVolume
          elseif fDistance >= fMaxDistance then
            fVolume = 0
          else
            fVolume = math.exp(-(fDistance - fMinDistance) * (5 / fDistDiff)) * voiceVolume
          end
          setSoundVolume(v, fVolume)
          if 0 < fVolume then
            local fPanSharpness = 1
            if fMinDistance ~= fMinDistance * 2 then
              fPanSharpness = math.max(0, math.min(1, (fDistance - fMinDistance) / (fMinDistance * 2 - fMinDistance)))
            end
            local fPanLimit = 0.65 * fPanSharpness + 0.35
            local vecLook = Vector3(cx2 - cx, cy2 - cy, cz2 - cz):getNormalized()
            local vecSound = Vector3(x - cx, y - cy, z - cz):getNormalized()
            local cross = vecLook:cross(vecSound)
            local fPan = math.max(-fPanLimit, math.min(-cross.z, fPanLimit))
            setSoundPan(v, fPan)
          end
        end
      end
      found[v] = true
    end
  end
end)
addEventHandler("onClientPlayerVoiceStart", getRootElement(), function()
  if source == localPlayer and not selfRadio and not selfCall and not adminVoiceActive and not adminDutyState then
    cancelEvent()
    return
  end
  voiceOff[source] = false
  if not voiceState[source] then
    if found[source] == "group" then
      playSound("files/radion.mp3")
    end
    voiceState[source] = true
    sightexports.sNames:setVoiceState(source, true)
    setSoundEffectEnabled(source, "compressor", true)
    if not isElementStreamedIn(source) then
      setSoundVolume(source, 0)
      setSoundPan(source, 0)
      return
    end
    if source == callPartner or found[source] then
      return
    end
    setSoundVolume(source, 0)
  end
end)
addEventHandler("onClientPlayerVoiceStop", getRootElement(), function()
  voiceOff[source] = getTickCount()
end)
addEventHandler("onClientPlayerStreamIn", getRootElement(), function()
  playerStreamList = getElementsByType("player", getRootElement())
  if selfRadio or selfCall or adminVoiceActive or adminDutyState then
    triggerServerEvent("refreshVoiceStream", localPlayer, playerStreamList)
  end
end)
addEventHandler("onClientPlayerStreamOut", getRootElement(), function()
  playerStreamList = getElementsByType("player", getRootElement())
  if selfRadio or selfCall or adminVoiceActive or adminDutyState then
    triggerServerEvent("refreshVoiceStream", localPlayer, playerStreamList)
  end
end)
local hudwhite = false
local hudwhite2 = false
local greyOriginal = false
local grey = false
local green = false
local bebas = false
local bebasScale = false
local h = 64
local mic1, mic2, tower
function refreshColors()
  hudwhite = sightexports.sGui:getColorCodeToColor("hudwhite")
  hudwhite2 = bitReplace(hudwhite, 125, 24, 8)
  greyOriginal = sightexports.sGui:getColorCodeToColor("sightgrey1")
  grey = bitReplace(greyOriginal, 174, 24, 8)
  green = sightexports.sGui:getColorCodeToColor("sightgreen")
  bebas = sightexports.sGui:getFont("14/BebasNeueBold.otf")
  bebasScale = sightexports.sGui:getFontScale("14/BebasNeueBold.otf")
  mic1 = sightexports.sGui:getFaIconFilename("microphone", math.ceil(h), "solid", false, false, sightexports.sGui:getColorCodeToColor("sightgrey2"), sightexports.sGui:getColorCodeToColor("sightgrey1"))
  mic2 = sightexports.sGui:getFaIconFilename("microphone", math.ceil(h), "solid", false, false, sightexports.sGui:getColorCodeToColor("sightgreen"), sightexports.sGui:getColorCodeToColor("sightgrey1"))
  tower = sightexports.sGui:getFaIconFilename("broadcast-tower", math.ceil(h), "solid")
end
local groupRadioWidgetState = false
local groupRadioWidgetPos = false
local groupRadioWidgetSize = false
local cursorType = "normal"
local groupSelectHover = false
local lastSelect = 0
addEventHandler("onClientClick", getRootElement(), function(button, state)
  if button == "left" and state == "up" and groupSelectHover and not sightexports.sHud:getWidgetEditMode() and getTickCount() - lastSelect > 500 then
    lastSelect = getTickCount()
    triggerServerEvent("selectNewRadioGroup", localPlayer)
  end
end)
function renderRadioPanel()
  local x, y = groupRadioWidgetPos[1], groupRadioWidgetPos[2]
  local sx, sy = groupRadioWidgetSize[1], groupRadioWidgetSize[2]
  local cursorTmp = "normal"
  if selfRadio then
    dxDrawImage(x, y, math.ceil(h), math.ceil(h), ":sGui/" .. tower .. (faTicks[tower] or ""), 0, 0, 0, hudwhite)
    local name = selfRadioName
    w = dxGetTextWidth(name, bebasScale, bebas)
    if w >= sx - h * 2 - 8 then
      name = selfRadioNameShort
      w = dxGetTextWidth(name, bebasScale, bebas)
    end
    dxDrawText(name, x + h + 4, y, 0, y + h, hudwhite, bebasScale, bebas, "left", "center", false, false, false, true)
  else
    dxDrawImage(x, y, math.ceil(h), math.ceil(h), ":sGui/" .. tower .. (faTicks[tower] or ""), 0, 0, 0, hudwhite2)
    dxDrawText("KIKAPCSOLVA", x + h + 4, y, 0, y + h, hudwhite2, bebasScale, bebas, "left", "center", false, false, false, true)
    w = dxGetTextWidth("KIKAPCSOLVA", bebasScale, bebas)
  end
  local cx, cy = getCursorPosition()
  groupSelectHover = false
  if cx then
    cx = cx * screenX
    cy = cy * screenY
    if x <= cx and cx <= x + h + w + 8 and y <= cy and cy <= y + h then
      cursorTmp = "link"
      groupSelectHover = true
    end
  end
  local f = false
  for i = 2, 8 do
    dxDrawRectangle(x, y + (i - 1) * h, sx, 1, grey)
    if radioList[i - 1] then
      dxDrawText(names[radioList[i - 1][1]], x + 4, y + (i - 1) * h, 0, y + i * h, hudwhite, bebasScale * 0.9, bebas, "left", "center", false, false, false, true)
      for j = 1, 6 do
        if radioList[i - 1][1] == localPlayer then
          f = true
        end
        if radioList[i - 1][j + 1] then
          local a = math.min(1, math.max(0, radioList[i - 1][j + 1]))
          dxDrawRectangle(x + sx - 4 - 3 * j - 2 * (j - 1), y + (i - 1) * h + 4 + (h - 8) * (1 - a), 3, (h - 8) * a, green)
        end
      end
    end
  end
  if f then
    dxDrawImage(x + sx - math.ceil(h), y, math.ceil(h), math.ceil(h), ":sGui/" .. mic1 .. (faTicks[mic1] or ""))
    if 0 < lvl then
      local a = math.min(1, 0.25 + lvl * 10)
      dxDrawImage(x + sx - math.ceil(h), y, math.ceil(h), math.ceil(h), ":sGui/" .. mic2 .. (faTicks[mic2] or ""), 0, 0, 0, tocolor(255, 255, 255, 255 * a))
    end
  else
    dxDrawImage(x + sx - math.ceil(h), y, math.ceil(h), math.ceil(h), ":sGui/" .. mic1 .. (faTicks[mic1] or ""), 0, 0, 0, tocolor(255, 255, 255, 125))
  end
  if cursorType ~= cursorTmp then
    cursorType = cursorTmp
    sightexports.sGui:setCursorType(cursorType)
  end
end
addEvent("hudWidgetState:groupRadio", true)
addEventHandler("hudWidgetState:groupRadio", getRootElement(), function(state)
  if groupRadioWidgetState ~= state then
    groupRadioWidgetState = state
    groupSelectHover = false
    if cursorType ~= "normal" then
      cursorType = "normal"
      sightexports.sGui:setCursorType(cursorType)
    end
    if groupRadioWidgetState then
      addEventHandler("onClientRender", getRootElement(), renderRadioPanel)
    else
      removeEventHandler("onClientRender", getRootElement(), renderRadioPanel)
    end
  end
end)
addEvent("hudWidgetPosition:groupRadio", true)
addEventHandler("hudWidgetPosition:groupRadio", getRootElement(), function(pos, final)
  groupRadioWidgetPos = pos
end)
addEvent("hudWidgetSize:groupRadio", true)
addEventHandler("hudWidgetSize:groupRadio", getRootElement(), function(size, final)
  groupRadioWidgetSize = size
  h = size[2] / 8
end)
triggerEvent("requestWidgetDatas", localPlayer, "groupRadio")
addEventHandler("onClientRender", getRootElement(), function()
  if adminVoiceActive or adminDutyState then
    local now = getTickCount()
    local delta = 0
    if adminVoiceActive then
      delta = adminVoiceActive - getTickCount()
    end
    if delta < 0 then
      delta = 0
      adminVoiceActive = false
    end
    local w = dxGetTextWidth("Voice aktív", bebasScale, bebas) + math.ceil(h)
    dxDrawImage(screenX / 2 - w / 2, screenY - 128, math.ceil(h), math.ceil(h), ":sGui/" .. mic1 .. (faTicks[mic1] or ""))
    if 0 < lvl then
      local a = math.min(1, 0.25 + lvl * 10)
      dxDrawImage(screenX / 2 - w / 2, screenY - 128, math.ceil(h), math.ceil(h), ":sGui/" .. mic2 .. (faTicks[mic2] or ""), 0, 0, 0, tocolor(255, 255, 255, 255 * a))
    end
    dxDrawText("Voice aktív", 0 + math.ceil(h) / 2, screenY - 128, screenX + math.ceil(h) / 2, screenY - 128 + h, hudwhite, bebasScale, bebas, "center", "center", false, false, false, true)
    if adminDutyState then
      dxDrawText("Admin Duty", 0, screenY - 128 + h, screenX, screenY - 128 + h * 2, hudwhite, bebasScale, bebas, "center", "center", false, false, false, true)
    else
      local secs = math.floor(delta / 1000)
      local mins = math.floor(secs / 60)
      secs = secs - mins * 60
      if 2 > utf8.len(secs) then
        secs = "0" .. secs
      end
      dxDrawText(mins .. ":" .. secs, 0, screenY - 128 + h, screenX, screenY - 128 + h * 2, hudwhite, bebasScale, bebas, "center", "center", false, false, false, true)
    end
  end
end)
