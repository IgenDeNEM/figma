local sightexports = {
  sRadio = false,
  sWeather = false,
  sModloader = false,
  sDashboard = false
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
local sightlangModloaderLoaded = function()
  requestClubDatas()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState2 then
    sightlangCondHandlState2 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderClub, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderClub)
    end
  end
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderRadio, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderRadio)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderLookAt, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderLookAt)
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
local lookAtPeds = {}
local loggedIn = false
local excludeList = {}
function isPedExcluded(ped)
  if excludeList[ped] then
    return true
  end
  local deathPed = getElementData(ped, "deathPed")
  if deathPed then
    excludeList[ped] = true
    return true
  end
  return false
end
function preRenderLookAt()
  local now = getTickCount()
  local tmp = true
  for ped, time in pairs(lookAtPeds) do
    tmp = false
    if 1000 < now - time then
      lookAtPeds[ped] = now
      setPedLookAt(ped, 0, 0, 0, -1, 1000, localPlayer)
    end
  end
  if tmp then
    sightlangCondHandl0(false)
  end
end
if getElementData(localPlayer, "loggedIn") then
  local peds = getElementsByType("ped", getRootElement(), true)
  for i = 1, #peds do
    if not isPedExcluded(peds[i]) then
      lookAtPeds[peds[i]] = 0
      sightlangCondHandl0(true)
    end
  end
  loggedIn = true
end
addEventHandler("onClientPedStreamIn", getRootElement(), function()
  if loggedIn and not isPedExcluded(source) then
    lookAtPeds[source] = 0
    sightlangCondHandl0(true)
  end
end)
addEventHandler("onClientPedStreamOut", getRootElement(), function()
  lookAtPeds[source] = nil
end)
addEventHandler("onClientPedDestroy", getRootElement(), function()
  excludeList[source] = nil
  lookAtPeds[source] = nil
end)
addEventHandler("onClientElementDataChange", localPlayer, function(dataName, oldValue, newValue)
  if dataName == "loggedIn" and newValue then
    local peds = getElementsByType("ped", getRootElement(), true)
    for i = 1, #peds do
      if not isPedExcluded(peds[i]) then
        lookAtPeds[peds[i]] = 0
        sightlangCondHandl0(true)
      end
    end
    loggedIn = true
  end
end)
function disablePedHeadmove(ped)
  excludeList[ped] = true
  if lookAtPeds[ped] then
    lookAtPeds[ped] = nil
    setPedLookAt(ped, 0, 0, 0, 0)
  end
end
local clubReady = false
local npcX, npcY, npcZ = -1273.8633, 2285.9514, 133.51055908203
local pavilionPeds = {}
local pavilionRadio = false
local pavilionRadioStation = false
local pavilionRadioCol = createColSphere(npcX, npcY, npcZ + 1, 100)
local pavilionRadioInnerCol = createColTube(npcX, npcY, npcZ - 2, 7.75, 5.25)
local pavilionIsInside = false
function refreshPavilionRadio()
  if isElement(pavilionRadio) then
    destroyElement(pavilionRadio)
  end
  pavilionRadio = nil
  if pavilionRadioStation then
    pavilionRadio = playSound3D(pavilionRadioStation, npcX, npcY, npcZ + 1)
    setSoundMaxDistance(pavilionRadio, 80)
    pavilionIsInside = false
    setStreamerModeVolume(pavilionRadio, 1.5)
    setSoundEffectEnabled(pavilionRadio, "i3dl2reverb", true)
    setSoundEffectEnabled(pavilionRadio, "compressor", true)
    sightlangCondHandl1(true)
  else
    sightlangCondHandl1(false)
  end
end
function preRenderRadio()
  local tmp = isElementWithinColShape(localPlayer, pavilionRadioInnerCol)
  if tmp ~= pavilionIsInside then
    pavilionIsInside = tmp
    setSoundEffectEnabled(pavilionRadio, "i3dl2reverb", not tmp)
    setSoundEffectEnabled(pavilionRadio, "compressor", not tmp)
  end
  if pavilionIsInside then
    local renget = false
    local soundFFT = getSoundFFTData(pavilionRadio, 4096, 10)
    if soundFFT then
      for i = 0, 3 do
        if math.sqrt(soundFFT[i]) > 0.5 then
          renget = true
        end
      end
    end
    if renget then
      local x, y, z = getElementPosition(localPlayer)
      createExplosion(x, y, z - 50, 12, false, 0.1, false)
    end
  end
end
addEventHandler("onClientLocalColShapeHit", pavilionRadioCol, function()
  refreshPavilionRadio()
end)
addEventHandler("onClientLocalColShapeLeave", pavilionRadioCol, function()
  if isElement(pavilionRadio) then
    destroyElement(pavilionRadio)
  end
  pavilionRadio = nil
  sightlangCondHandl1(false)
end)
addEvent("gotPavilionRadio", true)
addEventHandler("gotPavilionRadio", getRootElement(), function(radio)
  if not clubReady then
    return
  end
  pavilionRadioStation = sightexports.sRadio:getStationUrl(radio)
  if isElementWithinColShape(localPlayer, pavilionRadioCol) then
    refreshPavilionRadio()
  end
end)
addEvent("gotPavilionDancers", true)
addEventHandler("gotPavilionDancers", getRootElement(), function(dat, radio)
  if not clubReady then
    return
  end
  for i = 1, #pavilionPeds do
    if isElement(pavilionPeds[i]) then
      destroyElement(pavilionPeds[i])
    end
    pavilionPeds[i] = nil
  end
  for i = 1, #dat do
    local x, y, z
    if dat[i][2] == -1 then
      x, y, z = -1274.935546875, 2277.5087890625, 134.10029602051
    else
      local d = pavilionPoses[dat[i][2]][1]
      local r = pavilionPoses[dat[i][2]][2]
      x = npcX + math.cos(r) * d
      y = npcY + math.sin(r) * d
      z = npcZ
    end
    local ped = createPed(dat[i][1], x, y, z, dat[i][4])
    setElementFrozen(ped, true)
    setElementData(ped, "invulnerable", true)
    local a = dat[i][3]

    setPedAnimation(ped, danceAnims[a][1], danceAnims[a][2], -1, true, false, false)
    setPedAnimationProgress(ped, danceAnims[a][2], math.random())
    table.insert(pavilionPeds, ped)
  end
  pavilionRadioStation = sightexports.sRadio:getStationUrl(radio)
  if isElementWithinColShape(localPlayer, pavilionRadioCol) then
    refreshPavilionRadio()
  end
end)
local clubInterior = 17
local clubDimension = 123
local clubNpcX, clubNpcY, clubNpcZ = 482.2060546875, -18.361328125, 1000.6796875
local outX, outY, outZ = 1872.4, -1683.9, 19.4
local clubRadioCol = createColSphere(outX, outY, outZ, 150)
local clubRadioInnerCol = createColCuboid(468.322265625, -38.5751953125, 999, 52.3173828125, 53.3740234375, 10)
setElementInterior(clubRadioInnerCol, clubInterior)
setElementDimension(clubRadioInnerCol, clubDimension)
local clubIsInside = false
local clubRadio = false
local clubRadioStation = false
local clubPeds = {}
function withinClubShape()
  return isElementWithinColShape(localPlayer, clubRadioCol) or isElementWithinColShape(localPlayer, clubRadioInnerCol)
end
function refershClubRadio()
  if isElement(clubRadio) then
    destroyElement(clubRadio)
  end
  clubRadio = nil
  if clubRadioStation then
    clubRadio = playSound3D(clubRadioStation, outX, outY, outZ)
    setSoundMinDistance(clubRadio, 37)
    setSoundMaxDistance(clubRadio, 135)
    if clubIsInside then
      sightexports.sWeather:resetWeather()
      setInteriorSoundsEnabled(true)
    end
    clubIsInside = false
    setStreamerModeVolume(clubRadio, 1.5)
    setSoundEffectEnabled(clubRadio, "i3dl2reverb", true)
    setSoundEffectEnabled(clubRadio, "compressor", true)
  end
end
function preRenderClub()
  local tmp = isElementWithinColShape(localPlayer, clubRadioInnerCol)
  if tmp ~= clubIsInside then
    clubIsInside = tmp
    if clubRadio then
      if clubIsInside then
        setElementPosition(clubRadio, 487.4208984375, -4.6630859375, 1002.078125)
        setElementInterior(clubRadio, clubInterior)
        setElementDimension(clubRadio, clubDimension)
        removeWorldModel(2596, 0.25, 499.9922, -8.9688, 1003.1719, 17)
        removeWorldModel(2779, 0.25, 501.4688, -10.3672, 999.6797, 17)
        removeWorldModel(2778, 0.25, 502.4063, -7.5313, 999.6797, 17)
        removeWorldModel(2681, 0.25, 503.6484, -7.5156, 999.6797, 17)
        removeWorldModel(2125, 0.25, 482.2656, -20.5078, 1000, 17)
        removeWorldModel(2125, 0.25, 484.8359, -20.5, 1000, 17)
        removeWorldModel(2125, 0.25, 486.0859, -20.5625, 1000, 17)
        removeWorldModel(1517, 0.25, 487.2266, -20.5391, 1000.3438, 17)
        removeWorldModel(2125, 0.25, 488.2266, -20.5, 1000, 17)
        removeWorldModel(2125, 0.25, 482.6094, -19.5156, 1000, 17)
        removeWorldModel(1520, 0.25, 483.3359, -20.1094, 1000.2031, 17)
        removeWorldModel(1520, 0.25, 483.6797, -20.1016, 1000.2031, 17)
        removeWorldModel(2125, 0.25, 484.2266, -19.5547, 1000, 17)
        removeWorldModel(1823, 0.25, 484.1094, -19.9141, 999.6563, 17)
        removeWorldModel(2125, 0.25, 486.0938, -19.5938, 1000, 17)
        removeWorldModel(1520, 0.25, 487.3359, -20.1484, 1000.2031, 17)
        removeWorldModel(2125, 0.25, 488.3281, -19.6094, 1000, 17)
        removeWorldModel(1823, 0.25, 487.625, -19.9141, 999.6563, 17)
        removeWorldModel(2596, 0.25, 482.4453, -20.5938, 1002.2969, 17)
        removeWorldModel(2596, 0.25, 485.7422, -20.5938, 1002.2969, 17)
        removeWorldModel(2173, 1.25, 476.5, -14.39999961853, 1002.700012207, 17)
      else
        sightexports.sWeather:resetWeather()
        setInteriorSoundsEnabled(true)
        setElementPosition(clubRadio, outX, outY, outZ)
        setElementInterior(clubRadio, 0)
        setElementDimension(clubRadio, 0)
      end
      setSoundEffectEnabled(clubRadio, "i3dl2reverb", not tmp)
      setSoundEffectEnabled(clubRadio, "compressor", not tmp)
      setSoundEffectEnabled(clubRadio, "parameq", not tmp)
    end
  end
  if clubIsInside then
    setInteriorSoundsEnabled(false)
    setTime(0, 0)
    setWeather(2)
    if clubRadio then
      local renget = false
      local soundFFT = getSoundFFTData(clubRadio, 4096, 10)
      if soundFFT then
        for i = 0, 3 do
          if math.sqrt(soundFFT[i]) > 0.5 then
            renget = true
          end
        end
      end
      if renget then
        local x, y, z = getElementPosition(localPlayer)
        createExplosion(x, y, z - 50, 12, false, 0.1, false)
      end
    end
  end
end
function enterClubRadio()
  refershClubRadio()
  sightlangCondHandl2(true)
end
function leaveClubRadio()
  if isElement(clubRadio) then
    destroyElement(clubRadio)
  end
  clubRadio = nil
  sightlangCondHandl2(false)
  if clubIsInside then
    sightexports.sWeather:resetWeather()
    setInteriorSoundsEnabled(true)
  end
end
addEventHandler("onClientLocalColShapeHit", clubRadioCol, enterClubRadio)
addEventHandler("onClientLocalColShapeLeave", clubRadioCol, leaveClubRadio)
addEventHandler("onClientLocalColShapeHit", clubRadioInnerCol, enterClubRadio)
addEventHandler("onClientLocalColShapeLeave", clubRadioInnerCol, leaveClubRadio)
addEventHandler("onClientElementDimensionChange", localPlayer, function()
  if withinClubShape() then
    enterClubRadio()
  else
    leaveClubRadio()
  end
end)
addEvent("gotClubRadio", true)
addEventHandler("gotClubRadio", getRootElement(), function(radio)
  if not clubReady then
    return
  end
  clubRadioStation = sightexports.sRadio:getStationUrl(radio)
  if withinClubShape() then
    refershClubRadio()
  end
end)
addEvent("gotClubDancers", true)
addEventHandler("gotClubDancers", getRootElement(), function(dat, radio)
  if not clubReady then
    return
  end
  for i = 1, #clubPeds do
    if isElement(clubPeds[i]) then
      destroyElement(clubPeds[i])
    end
    clubPeds[i] = nil
  end
  for i = 1, #dat do
    local x, y, z
    if dat[i][2] == -1 then
      x, y, z = 487.5, -1.999140625, 1002.3828125
    else
      x = clubNpcX + clubPoses[dat[i][2]][1]
      y = clubNpcY + clubPoses[dat[i][2]][2]
      z = clubNpcZ
    end
    local ped = createPed(dat[i][1], x, y, z, dat[i][4])
    setElementFrozen(ped, true)
    setElementData(ped, "invulnerable", true)
    setElementInterior(ped, clubInterior)
    setElementDimension(ped, clubDimension)
    local a = dat[i][3]
    setPedAnimation(ped, danceAnims[a][1], danceAnims[a][2], -1, true, false, false)
    setPedAnimationProgress(ped, danceAnims[a][2], math.random())
    table.insert(clubPeds, ped)
  end
  clubRadioStation = sightexports.sRadio:getStationUrl(radio)
  if withinClubShape() then
    refershClubRadio()
  end
end)
local fishX, fishY, fishZ = 2020.5380859375, -133.4130859375, 1.703125
local fishRadioCol = createColSphere(fishX, fishY, fishZ, 250)
local fishRadio = false
local fishRadioStation = false
function refershFishRadio()
  if isElement(fishRadio) then
    destroyElement(fishRadio)
  end
  fishRadio = nil
  if fishRadioStation then
    fishRadio = playSound3D(fishRadioStation, fishX, fishY, fishZ)
    setSoundMinDistance(fishRadio, 60)
    setSoundMaxDistance(fishRadio, 225)
    setStreamerModeVolume(fishRadio, 1.5)
    setSoundEffectEnabled(fishRadio, "i3dl2reverb", true)
    setSoundEffectEnabled(fishRadio, "compressor", true)
  end
end
addEventHandler("onClientLocalColShapeHit", fishRadioCol, function()
  refershFishRadio()
end)
addEventHandler("onClientLocalColShapeLeave", fishRadioCol, function()
  if isElement(fishRadio) then
    destroyElement(fishRadio)
  end
  fishRadio = nil
end)
addEvent("gotFishRadio", true)
addEventHandler("gotFishRadio", getRootElement(), function(radio)
  if not clubReady then
    return
  end
  fishRadioStation = sightexports.sRadio:getStationUrl(radio)
  if isElementWithinColShape(localPlayer, fishRadioCol) then
    refershFishRadio()
  end
end)
function requestClubDatas()
  clubReady = true
  triggerServerEvent("requestClubDatas", localPlayer)
end

