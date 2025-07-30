local sightexports = {sGui = false, sDashboard = false}
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
sightlangStaticImageToc[3] = true
sightlangStaticImageToc[4] = true
sightlangStaticImageToc[5] = true
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
  if sightlangStaticImageUsed[3] then
    sightlangStaticImageUsed[3] = false
    sightlangStaticImageDel[3] = false
  elseif sightlangStaticImage[3] then
    if sightlangStaticImageDel[3] then
      if now >= sightlangStaticImageDel[3] then
        if isElement(sightlangStaticImage[3]) then
          destroyElement(sightlangStaticImage[3])
        end
        sightlangStaticImage[3] = nil
        sightlangStaticImageDel[3] = false
        sightlangStaticImageToc[3] = true
        return
      end
    else
      sightlangStaticImageDel[3] = now + 5000
    end
  else
    sightlangStaticImageToc[3] = true
  end
  if sightlangStaticImageUsed[4] then
    sightlangStaticImageUsed[4] = false
    sightlangStaticImageDel[4] = false
  elseif sightlangStaticImage[4] then
    if sightlangStaticImageDel[4] then
      if now >= sightlangStaticImageDel[4] then
        if isElement(sightlangStaticImage[4]) then
          destroyElement(sightlangStaticImage[4])
        end
        sightlangStaticImage[4] = nil
        sightlangStaticImageDel[4] = false
        sightlangStaticImageToc[4] = true
        return
      end
    else
      sightlangStaticImageDel[4] = now + 5000
    end
  else
    sightlangStaticImageToc[4] = true
  end
  if sightlangStaticImageUsed[5] then
    sightlangStaticImageUsed[5] = false
    sightlangStaticImageDel[5] = false
  elseif sightlangStaticImage[5] then
    if sightlangStaticImageDel[5] then
      if now >= sightlangStaticImageDel[5] then
        if isElement(sightlangStaticImage[5]) then
          destroyElement(sightlangStaticImage[5])
        end
        sightlangStaticImage[5] = nil
        sightlangStaticImageDel[5] = false
        sightlangStaticImageToc[5] = true
        return
      end
    else
      sightlangStaticImageDel[5] = now + 5000
    end
  else
    sightlangStaticImageToc[5] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/bg.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/ledvumeter.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/frekimutato.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/kisablak.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/knob.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[5] = function()
  if not isElement(sightlangStaticImage[5]) then
    sightlangStaticImageToc[5] = false
    sightlangStaticImage[5] = dxCreateTexture("files/led.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangDynImgHand = false
local sightlangDynImgLatCr = falselocal
sightlangDynImage = {}
local sightlangDynImageForm = {}
local sightlangDynImageMip = {}
local sightlangDynImageUsed = {}
local sightlangDynImageDel = {}
local sightlangDynImgPre
function sightlangDynImgPre()
  local now = getTickCount()
  sightlangDynImgLatCr = true
  local rem = true
  for k in pairs(sightlangDynImage) do
    rem = false
    if sightlangDynImageDel[k] then
      if now >= sightlangDynImageDel[k] then
        if isElement(sightlangDynImage[k]) then
          destroyElement(sightlangDynImage[k])
        end
        sightlangDynImage[k] = nil
        sightlangDynImageForm[k] = nil
        sightlangDynImageMip[k] = nil
        sightlangDynImageDel[k] = nil
        break
      end
    elseif not sightlangDynImageUsed[k] then
      sightlangDynImageDel[k] = now + 5000
    end
  end
  for k in pairs(sightlangDynImageUsed) do
    if not sightlangDynImage[k] and sightlangDynImgLatCr then
      sightlangDynImgLatCr = false
      sightlangDynImage[k] = dxCreateTexture(k, sightlangDynImageForm[k], sightlangDynImageMip[k])
    end
    sightlangDynImageUsed[k] = nil
    sightlangDynImageDel[k] = nil
    rem = false
  end
  if rem then
    removeEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre)
    sightlangDynImgHand = false
  end
end
local function dynamicImage(img, form, mip)
  if not sightlangDynImgHand then
    sightlangDynImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre, true, "high+999999999")
  end
  if not sightlangDynImage[img] then
    sightlangDynImage[img] = dxCreateTexture(img, form, mip)
  end
  sightlangDynImageForm[img] = form
  sightlangDynImageUsed[img] = true
  return sightlangDynImage[img]
end
local sightgrey1 = false
local sightgrey2 = false
local sightgreen = false
local sightorange = false
local sightred = false
local sightbluesecond = false
local btnBg = false
local btnCol = false
local radioIcon = false
local pickUpIcon = false
local smallFont = false
local smallFontScale = false
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    sightgrey1 = sightexports.sGui:getColorCode("sightgrey1")
    sightgrey2 = sightexports.sGui:getColorCode("sightgrey2")
    sightgreen = sightexports.sGui:getColorCode("sightgreen")
    sightorange = sightexports.sGui:getColorCode("sightorange")
    sightred = sightexports.sGui:getColorCode("sightred")
    sightbluesecond = sightexports.sGui:getColorCode("sightblue-second")
    btnBg = sightexports.sGui:getColorCode("sightgrey1")
    btnCol = sightexports.sGui:getColorCodeToColor("sightgreen")
    radioIcon = sightexports.sGui:getFaIconFilename("radio", 24)
    pickUpIcon = sightexports.sGui:getFaIconFilename("inbox-out", 24)
    smallFont = sightexports.sGui:getFont("9/BebasNeueBold.otf")
    smallFontScale = sightexports.sGui:getFontScale("9/BebasNeueBold.otf")
    faTicks = sightexports.sGui:getFaTicks()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState2 then
    sightlangCondHandlState2 = cond
    if cond then
      addEventHandler("onClientClick", getRootElement(), clickHifis, true, prio)
    else
      removeEventHandler("onClientClick", getRootElement(), clickHifis)
    end
  end
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderHifis, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderHifis)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderHifis, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderHifis)
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
local lcdFont = false
local streamedInHifis = {}
local streamedInHifiCurrentStation = {}
local streamedInHifiCurrentClarity = {}
local streamedInHifiSound = {}
local streamedInHifiStatic = {}
local streamedInHifiGui = {}
local streamedInHifiGui = {}
local streamedInHifiFreq = {}
local streamedInHifiVol = {}
local streamedInHifiX = {}
local streamedInHifiY = {}
local streamedInHifiZ = {}
local streamedInHifiInterior = {}
local streamedInHifiDimension = {}
local streamedInHifiNote = {}
local streamedInHifiClear = {}
local streamedInHifiLS = {}
local streamedInHifiRS = {}
local streamedInHifiPickable = {}
local radioHover, radioHoverObj, needToSync, lastCX, lastCY, movingRadioVol, movingRadioFreq
function hifiDataChange(data, old, new)
  if source ~= movingRadioVol and source ~= movingRadioFreq then
    new = tonumber(new)
    if data == "radioFreq" then
      streamedInHifiFreq[source] = new and math.min(math.max(new, 0), #stationList - 1) or 0
      processStation(source)
    elseif data == "radioVolume" then
      streamedInHifiVol[source] = new and math.min(math.max(new, 0), 1) or 0
      processStation(source)
    end
  end
end
function streamOutHifi()
  streamedInHifis[source] = nil
  streamedInHifiGui[source] = nil
  streamedInHifiFreq[source] = nil
  streamedInHifiVol[source] = nil
  streamedInHifiX[source] = nil
  streamedInHifiY[source] = nil
  streamedInHifiZ[source] = nil
  streamedInHifiDimension[source] = nil
  streamedInHifiNote[source] = nil
  streamedInHifiClear[source] = nil
  streamedInHifiLS[source] = nil
  streamedInHifiRS[source] = nil
  streamedInHifiCurrentStation[source] = nil
  streamedInHifiCurrentClarity[source] = nil
  streamedInHifiPickable[source] = nil
  if isElement(streamedInHifiSound[source]) then
    destroyElement(streamedInHifiSound[source])
  end
  streamedInHifiSound[source] = nil
  if isElement(streamedInHifiStatic[source]) then
    destroyElement(streamedInHifiStatic[source])
  end
  streamedInHifiStatic[source] = nil
  removeEventHandler("onClientElementStreamOut", source, streamOutHifi)
  removeEventHandler("onClientElementDestroy", source, streamOutHifi)
  removeEventHandler("onClientElementDataChange", source, hifiDataChange)
end
function processRadioVolume(obj)
  if streamedInHifiFreq[obj] then
    streamedInHifiCurrentClarity[obj] = math.pow(math.sin((streamedInHifiFreq[obj] - 0.5) % 1 * math.pi), 0.5)
    if isElement(streamedInHifiSound[obj]) then
      local vol = streamedInHifiVol[obj] * streamedInHifiCurrentClarity[obj]
      setStreamerModeVolume(streamedInHifiSound[obj], vol)
      setSoundMaxDistance(streamedInHifiSound[obj], 15 + 20 * vol)
    end
    if isElement(streamedInHifiStatic[obj]) then
      local vol = streamedInHifiVol[obj] * (1 - streamedInHifiCurrentClarity[obj])
      setSoundVolume(streamedInHifiStatic[obj], vol)
      setSoundMaxDistance(streamedInHifiStatic[obj], 15 + 20 * vol)
    end
    streamedInHifiClear[obj] = 0.05 <= streamedInHifiVol[obj] and 0.5 <= streamedInHifiCurrentClarity[obj]
  end
end
function processStation(obj)
  if streamedInHifiFreq[obj] then
    local isOn = 0.05 <= streamedInHifiVol[obj]
    if isOn and not isElement(streamedInHifiStatic[obj]) then
      streamedInHifiStatic[obj] = playSound3D("files/static.wav", streamedInHifiX[obj], streamedInHifiY[obj], streamedInHifiZ[obj], true)
      attachElements(streamedInHifiStatic[obj], obj)
      setElementInterior(streamedInHifiStatic[obj], streamedInHifiInterior[obj])
      setElementDimension(streamedInHifiStatic[obj], streamedInHifiDimension[obj])
      local s = playSound3D("files/button.wav", streamedInHifiX[obj], streamedInHifiY[obj], streamedInHifiZ[obj])
      setElementInterior(s, streamedInHifiInterior[obj])
      setElementDimension(s, streamedInHifiDimension[obj])
      if 0 < streamedInHifiDimension[obj] then
        setSoundEffectEnabled(s, "reverb", true)
        setSoundEffectEnabled(streamedInHifiStatic[obj], "reverb", true)
      end
    elseif not isOn and isElement(streamedInHifiStatic[obj]) then
      if isElement(streamedInHifiStatic[obj]) then
        destroyElement(streamedInHifiStatic[obj])
      end
      streamedInHifiStatic[obj] = nil
      local s = playSound3D("files/button.wav", streamedInHifiX[obj], streamedInHifiY[obj], streamedInHifiZ[obj])
      setElementInterior(s, streamedInHifiInterior[obj])
      setElementDimension(s, streamedInHifiDimension[obj])
      if 0 < streamedInHifiDimension[obj] then
        setSoundEffectEnabled(s, "reverb", true)
      end
    end
    local station = isOn and math.floor(streamedInHifiFreq[obj] + 0.5) + 1
    if station ~= streamedInHifiCurrentStation[obj] then
      streamedInHifiCurrentStation[obj] = station
      if isElement(streamedInHifiSound[obj]) then
        destroyElement(streamedInHifiSound[obj])
      end
      streamedInHifiSound[obj] = nil
      if stationList[station] then
        streamedInHifiSound[obj] = playSound3D(stationList[station][1], streamedInHifiX[obj], streamedInHifiY[obj], streamedInHifiZ[obj])
        attachElements(streamedInHifiSound[obj], obj)
        setElementInterior(streamedInHifiSound[obj], streamedInHifiInterior[obj])
        setElementDimension(streamedInHifiSound[obj], streamedInHifiDimension[obj])
        if 0 < streamedInHifiDimension[obj] then
          setSoundEffectEnabled(streamedInHifiSound[obj], "reverb", true)
        else
        end
      end
    end
    processRadioVolume(obj)
  end
end
function radioStreamIn(obj)
  local model = getElementModel(obj)
  if hiFiZ[model] and not streamedInHifis[obj] then
    streamedInHifis[obj] = model
    streamedInHifiVol[obj] = 0
    local new = getElementData(obj, "radioFreq")
    streamedInHifiFreq[obj] = new and math.min(math.max(new, 0), #stationList - 1) or 0
    local new = getElementData(obj, "radioVolume")
    streamedInHifiVol[obj] = new and math.min(math.max(new, 0), 1) or 0
    streamedInHifiCurrentStation[obj] = nil
    streamedInHifiX[obj], streamedInHifiY[obj], streamedInHifiZ[obj] = getElementPosition(obj)
    streamedInHifiInterior[obj] = getElementInterior(obj)
    streamedInHifiDimension[obj] = getElementDimension(obj)
    streamedInHifiPickable[obj] = getElementData(obj, "radioId") and not getElementData(obj, "radioFurniture")
    processStation(obj)
    sightlangCondHandl0(true)
    sightlangCondHandl1(true)
    sightlangCondHandl2(true)
    addEventHandler("onClientElementStreamOut", obj, streamOutHifi)
    addEventHandler("onClientElementDestroy", obj, streamOutHifi)
    addEventHandler("onClientElementDataChange", obj, hifiDataChange)
  end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  local objects = getElementsByType("object", getRootElement(), true)
  for i = 1, #objects do
    local obj = objects[i]
    if getElementData(obj, "radioId") or getElementData(obj, "radioFurniture") then
      radioStreamIn(obj)
    end
  end
end)
addEventHandler("onClientObjectStreamIn", getRootElement(), function()
  if getElementData(source, "radioId") or getElementData(source, "radioFurniture") then
    radioStreamIn(source)
  end
end)
local notes = {
  "files/hifi/note1.dds",
  "files/hifi/note2.dds"
}
local soundNotes = {}
function preRenderHifis(delta)
  local found = false
  if needToSync then
    needToSync = needToSync - delta
  end
  for obj, model in pairs(streamedInHifis) do
    found = true
    local x, y, z = getElementPosition(obj)
    streamedInHifiX[obj], streamedInHifiY[obj], streamedInHifiZ[obj] = x, y, z
    streamedInHifiZ[obj] = streamedInHifiZ[obj] + (hiFiZ[model] or 0.25)
    local clear = streamedInHifiClear[obj]
    local ls, rs
    if clear and isElement(streamedInHifiSound[obj]) then
      local l, r = getSoundLevelData(streamedInHifiSound[obj])
      ls = l and l / 32768 * streamedInHifiVol[obj] * streamedInHifiCurrentClarity[obj] or 0
      rs = r and r / 32768 * streamedInHifiVol[obj] * streamedInHifiCurrentClarity[obj] or 0
    end
    setObjectScale(obj, 1 + ((ls or 0) + (rs or 0)) / 2 * 0.1)
    streamedInHifiLS[obj] = ls
    streamedInHifiRS[obj] = rs
    if ls then
      if not streamedInHifiNote[obj] then
        streamedInHifiNote[obj] = ls + rs
      end
      streamedInHifiNote[obj] = streamedInHifiNote[obj] + (ls + rs)
      if streamedInHifiNote[obj] > math.random(20, 35) then
        streamedInHifiNote[obj] = 0
        local zp = hiFiZ[model]
        if zp then
          z = z + zp
        else
          z = z + 0.25
        end
        if notes[1] and notes[2] then
          for i = 1, math.random(1, 3) do
            local randy = math.random(0, 180)
            table.insert(soundNotes, {
              notes[math.random(1, 2)],
              x + math.random(-2, 2) / 10,
              y + math.random(-2, 2) / 10,
              z,
              z,
              getTickCount(),
              randy * 2,
              {
                math.cos(math.rad(randy * 2)),
                -math.sin(math.rad(math.random(0, 360)))
              },
              math.random(7, 10),
              math.random(5, 15) / 10,
              1
            })
          end
        end
      end
    end
  end
  for k = #soundNotes, 1, -1 do
    if soundNotes[k] then
      found = true
      local note = soundNotes[k]
      local delta = getTickCount() - note[6]
      note[6] = getTickCount()
      local jitter_cycle = math.cos(note[7]) / note[9]
      local jitter_x = note[8][1] * jitter_cycle
      local jitter_y = note[8][2] * jitter_cycle
      note[7] = note[7] % 360 + 0.1
      note[4] = note[4] + delta * 0.001 * note[10]
      if note[4] - note[5] > 1.75 then
        soundNotes[k][11] = soundNotes[k][11] - 4 * delta / 1000
        if 0 >= soundNotes[k][11] then
          soundNotes[k][11] = 0
        end
      end
      dxDrawMaterialLine3D(note[2] + jitter_x, note[3] + jitter_y, note[4], note[2] + jitter_x, note[3] + jitter_y, note[4] - 0.1, dynamicImage(note[1], "dxt1"), 0.1, tocolor(0, 0, 0, 255 * note[11]))
      if 0 >= note[11] then
        table.remove(soundNotes, k)
      end
    end
  end
  if not found then
    sightlangCondHandl0(false)
    sightlangCondHandl1(false)
    sightlangCondHandl2(false)
    if radioHover then
      sightexports.sGui:setCursorType("normal")
      sightexports.sGui:showTooltip()
    end
    radioHover = false
    radioHoverObj = false
    if isElement(lcdFont) then
      destroyElement(lcdFont)
    end
    lcdFont = nil
    if movingRadioFreq then
      if needToSync then
        syncRadioFreqMove()
      end
      needToSync = false
      movingRadioFreq = false
    end
    if movingRadioVol then
      if needToSync then
        syncRadioVolMove()
      end
      needToSync = false
      movingRadioVol = false
    end
  end
end
function marqueText(now, text)
  text = text .. " "
  local len = utf8.len(text)
  if 24 < len then
    local p = math.floor(now / 250) % (len + 1)
    text = utf8.sub(text .. text, p, p + 24)
    return stripAccents(text)
  else
    return stripAccents(text)
  end
end
function renderHifis()
  local now = getTickCount()
  local cx, cy = getCursorPosition()
  if cx then
    cx = cx * screenX
    cy = cy * screenY
  end
  local tmpObj, tmp
  local px, py, pz = getElementPosition(localPlayer)
  local moving = movingRadioVol or movingRadioFreq
  for obj in pairs(streamedInHifis) do
    local x, y, z = streamedInHifiX[obj], streamedInHifiY[obj], streamedInHifiZ[obj]
    local gui = streamedInHifiGui[obj]
    local d = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
    if (cx or gui) and d < 4 then
      local x, y = getScreenFromWorldPosition(x, y, z, gui and 512 or 32)
      if x then
        local p = 1 - math.max(0, d - 3)
        if streamedInHifiPickable[obj] then
          x = x - 32 - 4 + 16
          dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(btnBg[1], btnBg[2], btnBg[3], 255 * p))
          if 1 <= p and not moving and cx and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
            dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. pickUpIcon .. faTicks[pickUpIcon], 0, 0, 0, btnCol)
            tmp = "pickup"
            tmpObj = obj
          else
            dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. pickUpIcon .. faTicks[pickUpIcon], 0, 0, 0, tocolor(255, 255, 255, 255 * p))
          end
          x = x + 32 + 8
        end
        dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(btnBg[1], btnBg[2], btnBg[3], 255 * p))
        if 1 <= p and not moving and cx and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
          dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. radioIcon .. faTicks[radioIcon], 0, 0, 0, btnCol)
          tmp = "togglegui"
          tmpObj = obj
        else
          dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. radioIcon .. faTicks[radioIcon], 0, 0, 0, tocolor(255, 255, 255, 255 * p))
        end
        if streamedInHifiPickable[obj] then
          x = x - 4 - 16
        end
        if gui then
          y = y - 32 - 150
          x = x - 225
          dxDrawRectangle(x, y, 450, 150, tocolor(sightgrey2[1], sightgrey2[2], sightgrey2[3], 255 * p))
          sightlangStaticImageUsed[0] = true
          if sightlangStaticImageToc[0] then
            processsightlangStaticImage[0]()
          end
          dxDrawImage(x, y, 450, 150, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 255 * p))
          y = y + 6
          dxDrawRectangle(x + 6, y, 438, 10, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], 255 * p))
          local w = 7.3
          local vul = 0
          local vur = 0
          local clear = streamedInHifiClear[obj]
          vul = streamedInHifiLS[obj] or 0
          vur = streamedInHifiRS[obj] or 0
          for i = 1, 30 do
            local v = i / 30
            local c = 0.6 <= v and (0.85 <= v and sightred or sightorange) or sightgreen
            dxDrawRectangle(x + 225 - w * i + 1, y + 1, w - 2, 8, tocolor(c[1] * 0.2, c[2] * 0.2, c[3] * 0.2, 255 * p))
            dxDrawRectangle(x + 225 + w * (i - 1) + 1, y + 1, w - 2, 8, tocolor(c[1] * 0.2, c[2] * 0.2, c[3] * 0.2, 255 * p))
            if vul >= v then
              dxDrawRectangle(x + 225 - w * i + 1, y + 1, w - 2, 8, tocolor(c[1], c[2], c[3], 255 * p))
            end
            if vur >= v then
              dxDrawRectangle(x + 225 + w * (i - 1) + 1, y + 1, w - 2, 8, tocolor(c[1], c[2], c[3], 255 * p))
            end
          end
          sightlangStaticImageUsed[1] = true
          if sightlangStaticImageToc[1] then
            processsightlangStaticImage[1]()
          end
          dxDrawImage(x + 6, y, 438, 10, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255, 255 * p))
          y = y + 10 + 6
          dxDrawRectangle(x + 6, y, 438, 55, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], 255 * p))
          local w = 426 / #stationList
          dxDrawRectangle(x + 12 + w / 2 - 1, y + 55 - 32, 426 - w + 2, 1, tocolor(255, 255, 255, 255 * p))
          for i = 1, #stationList do
            dxDrawRectangle(x + 12 + w * (i - 0.5) - 1, y + 55 - 32 - 6, 2, 6, tocolor(255, 255, 255, 255 * p))
            dxDrawText(i, x + 12 + w * (i - 1), y + 55 - 24, x + 12 + w * i, y + 55, tocolor(255, 255, 255, 255 * p), smallFontScale * 0.5, smallFont, "center", "top", true)
          end
          dxDrawRectangle(x + 12 + streamedInHifiFreq[obj] * w, y, w, 55, tocolor(255, 255, 255, 50 * p))
          dxDrawRectangle(x + 12 + streamedInHifiFreq[obj] * w + w / 2 - 1, y, 2, 55, tocolor(sightred[1], sightred[2], sightred[3], 255 * p))
          sightlangStaticImageUsed[2] = true
          if sightlangStaticImageToc[2] then
            processsightlangStaticImage[2]()
          end
          dxDrawImage(x + 6, y, 438, 55, sightlangStaticImage[2], 0, 0, 0, tocolor(255, 255, 255, 255 * p))
          y = y + 55
          dxDrawRectangle(x + 6, y + 6, 181, 40, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], 255 * p))
          if clear then
            if not isElement(lcdFont) then
              lcdFont = dxCreateFont("files/dsdigi.ttf", 14, false, "antialiased")
            end
            if stationList[streamedInHifiCurrentStation[obj]] then
              dxDrawText(stripAccents(stationList[streamedInHifiCurrentStation[obj]][2]), x + 12, y + 6, x + 225 - 6 - 32 - 6, y + 6 + 30, tocolor(sightbluesecond[1], sightbluesecond[2], sightbluesecond[3], 255 * p), 0.7, lcdFont, "left", "center", true)
            end
            local streamTitle
            if 0.95 <= streamedInHifiCurrentClarity[obj] then
              streamTitle = "N/A"
              if isElement(streamedInHifiSound[obj]) then
                local metaTags = getSoundMetaTags(streamedInHifiSound[obj])
                if metaTags and metaTags.stream_title then
                  streamTitle = metaTags.stream_title
                end
              end
            else
              local p = math.floor(now / 100) % 4
              if p == 0 then
                streamTitle = "\\"
              elseif p == 1 then
                streamTitle = "|"
              elseif p == 2 then
                streamTitle = "/"
              elseif p == 3 then
                streamTitle = "-"
              end
            end
            dxDrawText(marqueText(now, streamTitle), x + 12, y + 6 + 20, x + 225 - 6 - 32 - 6, y + 6 + 40, tocolor(sightbluesecond[1], sightbluesecond[2], sightbluesecond[3], 255 * p), 0.6, lcdFont, "left", "center", false)
          end
          sightlangStaticImageUsed[3] = true
          if sightlangStaticImageToc[3] then
            processsightlangStaticImage[3]()
          end
          dxDrawImage(x + 6, y + 6, 181, 40, sightlangStaticImage[3], 0, 0, 0, tocolor(255, 255, 255, 255 * p))
          y = y - 12
          local r = streamedInHifiFreq[obj] * 180
          sightlangStaticImageUsed[4] = true
          if sightlangStaticImageToc[4] then
            processsightlangStaticImage[4]()
          end
          dxDrawImage(x + 225 - 32, y + 2, 64, 64, sightlangStaticImage[4], r, 0, 0, tocolor(0, 0, 0, 100 * p))
          sightlangStaticImageUsed[4] = true
          if sightlangStaticImageToc[4] then
            processsightlangStaticImage[4]()
          end
          dxDrawImage(x + 225 - 32, y, 64, 64, sightlangStaticImage[4], r, 0, 0, tocolor(255, 255, 255, 255 * p))
          local r = -140 + 280 * streamedInHifiVol[obj]
          sightlangStaticImageUsed[4] = true
          if sightlangStaticImageToc[4] then
            processsightlangStaticImage[4]()
          end
          dxDrawImage(x + 450 - 12 - 40, y + 64 - 40 + 2, 40, 40, sightlangStaticImage[4], r, 0, 0, tocolor(0, 0, 0, 100 * p))
          sightlangStaticImageUsed[4] = true
          if sightlangStaticImageToc[4] then
            processsightlangStaticImage[4]()
          end
          dxDrawImage(x + 450 - 12 - 40, y + 64 - 40, 40, 40, sightlangStaticImage[4], r, 0, 0, tocolor(255, 255, 255, 255 * p))
          dxDrawText("Tuning", x, y + 64, x + 450, y + 64 + 20, tocolor(255, 255, 255, 255 * p), smallFontScale, smallFont, "center", "center")
          if 0.05 <= streamedInHifiVol[obj] then
            local a = 255
            local p1 = streamedInHifiCurrentClarity[obj]
            local p2 = math.pow(p1, 5)
            a = (255 * p2 + 255 * math.random() * (1 - p2)) * math.pow(p1, 0.5)
            sightlangStaticImageUsed[5] = true
            if sightlangStaticImageToc[5] then
              processsightlangStaticImage[5]()
            end
            dxDrawImage(x + 225 - 24, y + 64 + 10 - 3, 6, 6, sightlangStaticImage[5], 0, 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], 200 * p))
            sightlangStaticImageUsed[5] = true
            if sightlangStaticImageToc[5] then
              processsightlangStaticImage[5]()
            end
            dxDrawImage(x + 225 - 24, y + 64 + 10 - 3, 6, 6, sightlangStaticImage[5], 0, 0, 0, tocolor(sightbluesecond[1], sightbluesecond[2], sightbluesecond[3], a * p))
          else
            sightlangStaticImageUsed[5] = true
            if sightlangStaticImageToc[5] then
              processsightlangStaticImage[5]()
            end
            dxDrawImage(x + 225 - 24, y + 64 + 10 - 3, 6, 6, sightlangStaticImage[5], 0, 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], 200 * p))
          end
          dxDrawText("Vol", x + 450 - 12 - 20, y + 64, x + 450 - 12 - 20, y + 64 + 20, tocolor(255, 255, 255, 255 * p), smallFontScale, smallFont, "center", "center")
          if 0.05 <= streamedInHifiVol[obj] then
            sightlangStaticImageUsed[5] = true
            if sightlangStaticImageToc[5] then
              processsightlangStaticImage[5]()
            end
            dxDrawImage(x + 450 - 12 - 40, y + 64 + 10 - 3, 6, 6, sightlangStaticImage[5], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], 255 * p))
          else
            sightlangStaticImageUsed[5] = true
            if sightlangStaticImageToc[5] then
              processsightlangStaticImage[5]()
            end
            dxDrawImage(x + 450 - 12 - 40, y + 64 + 10 - 3, 6, 6, sightlangStaticImage[5], 0, 0, 0, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], 200 * p))
          end
          if 1 <= p and cx then
            if movingRadioFreq == obj then
              tmp = "freq"
              tmpObj = obj
              local x, y = x + 225, y + 32
              local a1 = math.atan2(cy - y, cx - x)
              local a2 = math.atan2(lastCY - y, lastCX - x)
              local a = (a1 - a2 + math.pi) % (math.pi * 2) - math.pi
              local tmp = streamedInHifiFreq[obj] + a / math.pi
              tmp = math.max(math.min(#stationList - 1, tmp), 0)
              if tmp ~= streamedInHifiFreq[obj] then
                if not needToSync then
                  needToSync = 200
                end
                streamedInHifiFreq[obj] = tmp
              end
              lastCX = cx
              lastCY = cy
            elseif movingRadioVol == obj then
              tmp = "vol"
              tmpObj = obj
              local x, y = x + 450 - 12 - 20, y + 64 - 20
              local a1 = math.atan2(cy - y, cx - x)
              local a2 = math.atan2(lastCY - y, lastCX - x)
              local a = (a1 - a2 + math.pi) % (math.pi * 2) - math.pi
              local tmp = streamedInHifiVol[obj] + a / math.rad(280)
              tmp = math.max(math.min(1, tmp), 0)
              if tmp ~= streamedInHifiVol[obj] then
                if not needToSync then
                  needToSync = 200
                end
                streamedInHifiVol[obj] = tmp
              end
              lastCX = cx
              lastCY = cy
            elseif not moving then
              if cx >= x + 225 - 32 and cx <= x + 225 + 32 and cy >= y and cy <= y + 64 then
                if 0.05 <= streamedInHifiVol[obj] then
                  tmp = "freq"
                  tmpObj = obj
                end
              elseif cx >= x + 450 - 12 - 40 and cx <= x + 450 - 12 and cy >= y + 64 - 40 and cy <= y + 64 then
                tmp = "vol"
                tmpObj = obj
              end
            end
          end
        end
      end
    end
  end
  if movingRadioFreq then
    if tmpObj ~= movingRadioFreq then
      if needToSync then
        syncRadioFreqMove()
      end
      needToSync = false
      movingRadioFreq = false
    elseif needToSync and needToSync < 0 then
      needToSync = false
      syncRadioFreqMove()
    end
  end
  if movingRadioVol then
    if tmpObj ~= movingRadioVol then
      if needToSync then
        syncRadioVolMove()
      end
      needToSync = false
      movingRadioVol = false
    elseif needToSync and needToSync < 0 then
      needToSync = false
      syncRadioVolMove()
    end
  end
  if tmp ~= radioHover or tmpObj ~= radioHoverObj then
    radioHover = tmp
    radioHoverObj = tmpObj
    if radioHover then
      sightexports.sGui:setCursorType("link")
      if tmp == "togglegui" then
        sightexports.sGui:showTooltip("Rádió " .. (streamedInHifiGui[tmpObj] and "bezárása" or "megnyitása"))
      elseif tmp == "pickup" then
        sightexports.sGui:showTooltip("Rádió felvétele a földről")
      elseif tmp == "vol" then
        sightexports.sGui:showTooltip("Hangerő")
      elseif tmp == "freq" then
        sightexports.sGui:showTooltip("Frekvencia")
      end
    else
      sightexports.sGui:setCursorType("normal")
      sightexports.sGui:showTooltip()
    end
  end
end
function syncRadioFreqMove()
  if isElement(movingRadioFreq) then
    processStation(movingRadioFreq)
    setElementData(movingRadioFreq, "radioFreq", streamedInHifiFreq[movingRadioFreq])
  end
end
function syncRadioVolMove()
  if isElement(movingRadioVol) then
    processStation(movingRadioVol)
    setElementData(movingRadioVol, "radioVolume", streamedInHifiVol[movingRadioVol])
  end
end
function clickHifis(btn, state, cx, cy)
  if state == "down" and radioHover then
    if movingRadioFreq then
      if needToSync then
        syncRadioFreqMove()
      end
      needToSync = false
      movingRadioFreq = false
    end
    if movingRadioVol then
      if needToSync then
        syncRadioVolMove()
      end
      needToSync = false
      movingRadioVol = false
    end
    if radioHover == "pickup" then
      local id = getElementData(radioHoverObj, "radioId")
      if id then
        triggerServerEvent("pickupHifiRadio", localPlayer, id)
      end
    elseif radioHover == "togglegui" then
      streamedInHifiGui[radioHoverObj] = not streamedInHifiGui[radioHoverObj]
      radioHover = false
    elseif radioHover == "vol" then
      movingRadioVol = radioHoverObj
      lastCX, lastCY = cx, cy
    elseif radioHover == "freq" then
      movingRadioFreq = radioHoverObj
      lastCX, lastCY = cx, cy
    end
  elseif movingRadioFreq then
    if needToSync then
      syncRadioFreqMove()
    end
    needToSync = false
    movingRadioFreq = false
  elseif movingRadioVol then
    if needToSync then
      syncRadioVolMove()
    end
    needToSync = false
    movingRadioVol = false
  end
end
