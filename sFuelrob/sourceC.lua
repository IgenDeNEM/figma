local sightexports = {
  sModloader = false,
  sFuel = false,
  sPeds = false,
  sGui = false,
  sGroups = false,
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
local sX, sY = guiGetScreenSize()
local npcMinigame = false
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
local fearIcon = false
local fearArrowIcon = false
local fearFaceIcon = false
local fearFace2Icon = false
local angerIcon = false
local anger2Icon = false
local inboxOutIcon = false
local faTicks = false
local sightgrey1 = false
local sightorange = false
local sightred = false
local sightblue = false
local timerFont = false
local timerFontScale = false
local cashFont = false
local cashFontScale = false
local model_ids = {}
function loadModelIds()
  model_ids = {
    sCashregister = engineRequestModel("object"),
    sCashregister_drawer = engineRequestModel("object"),
    sCashregister_cash = engineRequestModel("object"),
}

for k, v in pairs(model_ids) do
    local txd = engineLoadTXD("files/cashreg.txd")
    local dff = engineLoadDFF("files/".. k ..".dff")
    if fileExists("files/".. k ..".col") then
        col = engineLoadCOL("files/".. k ..".col")
    end
    engineImportTXD(txd, v)
    engineReplaceModel(dff, v)
    if col then
        engineReplaceCOL(col, v)
    end
end

end
addEvent("modloaderLoaded", false)
addEventHandler("modloaderLoaded", getRootElement(), loadModelIds)
local inPolice = false
local casetteBlips = {}
local casetteData = {}
function getCasettePos(x, y)
  local r = math.rad(math.pi * 2 * math.random())
  local d = math.random(0, 400) / 10
  return x + math.cos(r) * d, y + math.sin(r) * d
end
addEvent("gotFuelrobCasetteData", true)
addEventHandler("gotFuelrobCasetteData", getRootElement(), function(element, data)
  casetteData[element] = data
  if not data and isElement(casetteBlips[element]) then
    destroyElement(casetteBlips[element])
    casetteBlips[element] = nil
  elseif data and inPolice then
    local x, y, z, live = unpack(data)
    x, y = getCasettePos(x, y)
    local col = live and sggreen or sightred
    if not isElement(casetteBlips[element]) then
      casetteBlips[element] = createBlip(x, y, z, 36, 2, col[1], col[2], col[3])
      setElementData(casetteBlips[element], "tooltipText", "Pénzköteg jeladó (" .. (live and "ONLINE" or "OFFLINE") .. ")")
    else
      setElementPosition(casetteBlips[element], x, y, z)
      setBlipColor(casetteBlips[element], col[1], col[2], col[3], 255)
      setElementData(casetteBlips[element], "tooltipText", "Pénzköteg jeladó (" .. (live and "ONLINE" or "OFFLINE") .. ")")
    end
  end
end)
function refreshCasetteBlips()
  if inPolice then
    for element, data in pairs(casetteData) do
      if data then
        local x, y, z, live = unpack(data)
        x, y = getCasettePos(x, y)
        local col = live and sightorange or sightred
        if not isElement(casetteBlips[element]) then
          casetteBlips[element] = createBlip(x, y, z, 29, 2, col[1], col[2], col[3])
          setElementData(casetteBlips[element], "tooltipText", "Pénzköteg jeladó (" .. (live and "ONLINE" or "OFFLINE") .. ")")
        else
          setElementPosition(casetteBlips[element], getCasettePos(unpack(data)))
          setBlipColor(casetteBlips[element], col[1], col[2], col[3], 255)
          setElementData(casetteBlips[element], "tooltipText", "Pénzköteg jeladó (" .. (live and "ONLINE" or "OFFLINE") .. ")")
        end
      end
    end
  else
    for element in pairs(casetteBlips) do
      if isElement(casetteBlips[element]) then
        destroyElement(casetteBlips[element])
      end
      casetteBlips[element] = nil
    end
  end
end
function guiRefreshColors()
  fearIcon = sightexports.sGui:getFaIconFilename("exclamation", 64)
  fearArrowIcon = sightexports.sGui:getFaIconFilename("angle-right", 64)
  fearFaceIcon = sightexports.sGui:getFaIconFilename("frown-open", 32, "regular")
  fearFace2Icon = sightexports.sGui:getFaIconFilename("frown-open", 32, "solid")
  angerIcon = sightexports.sGui:getFaIconFilename("angry", 32, "regular")
  anger2Icon = sightexports.sGui:getFaIconFilename("angry", 32, "solid")
  inboxOutIcon = sightexports.sGui:getFaIconFilename("inbox-out", 32)
  sggreen = sightexports.sGui:getColorCode("sightgreen")
  vgrey1 = sightexports.sGui:getColorCode("sightgrey1")
  sightorange = sightexports.sGui:getColorCode("sightorange")
  sightred = sightexports.sGui:getColorCode("sightred")
  sightblue = sightexports.sGui:getColorCode("sightblue")
  timerFont = sightexports.sGui:getFont("45/BebasNeueRegular.otf")
  timerFontScale = sightexports.sGui:getFontScale("45/BebasNeueRegular.otf")
  cashFont = sightexports.sGui:getFont("16/BebasNeueRegular.otf")
  cashFontScale = sightexports.sGui:getFontScale("16/BebasNeueRegular.otf")
  if inPolice then
    refreshCasetteBlips()
  end
end
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    faTicks = sightexports.sGui:getFaTicks()
    guiRefreshColors()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
local tmp = false
local boxId = false
local npcElements = {}
local npcDuck = {}
local npcFear = {}
local npcAim = {}
local npcFearLevels = {}
local targetNpcFearLevels = {}
local alarmStates = {}
local drawerOpens = {}
local boxData = {}
local alarmSounds = {}
local alarmBlips = {}
local alarmBlipTimers = {}
local lastClick = 0
local drawerOpenX = -7.25841
local drawerOpenY = 1.161253
local drawerOpenZ = 1.062498
local drawerCloseX = -6.92841
local drawerCloseY = 1.161253
local drawerCloseZ = 1.062498
local cashObjects = {}
local cashText = false
function processFuelElements()
  npcElements = {}
  availableFuelStations = exports.sFuel:getFuelStations()
  for i = 1, #availableFuelStations do
    alarmStates[i] = false
    local colSyncZone = availableFuelStations[i].syncZone
    if isElement(colSyncZone) then
      local robX, robY, robZ = getElementPosition(robCols[i])
      for _, ped in ipairs(getElementsByType("ped")) do
        local pX, pY, pZ = getElementPosition(ped)
        if getDistanceBetweenPoints3D(robX, robY, robZ, pX, pY, pZ) <= 20 then
          if not npcElements[i] then
            npcElements[i] = {}
          end
          if not npcFearLevels[i] then
            npcFearLevels[i] = {}
          end
          if not targetNpcFearLevels[i] then
            targetNpcFearLevels[i] = {}
          end
          table.insert(npcElements[i], ped)
          table.insert(npcFearLevels[i], 1)
          table.insert(targetNpcFearLevels[i], 1)
        end
      end
    end
    local storeElement = availableFuelStations[i].storeElement
    if isElement(storeElement) then
      local mat = getElementMatrix(storeElement)
      local x = -7.13841
      local y = 1.161253
      local z = 1.052498
      availableFuelStations[i].cashMachine = createObject(model_ids.sCashregister, x * mat[1][1] + y * mat[2][1] + z * mat[3][1] + mat[4][1], x * mat[1][2] + y * mat[2][2] + z * mat[3][2] + mat[4][2], x * mat[1][3] + y * mat[2][3] + z * mat[3][3] + mat[4][3])
      setElementRotation(availableFuelStations[i].cashMachine, 0, 0, availableFuelStations[i].storePos[4] + 90)
      availableFuelStations[i].drawerObject = createObject(model_ids.sCashregister_drawer, drawerCloseX * mat[1][1] + drawerCloseY * mat[2][1] + drawerCloseZ * mat[3][1] + mat[4][1], drawerCloseX * mat[1][2] + drawerCloseY * mat[2][2] + drawerCloseZ * mat[3][2] + mat[4][2], drawerCloseX * mat[1][3] + drawerCloseY * mat[2][3] + drawerCloseZ * mat[3][3] + mat[4][3])
      setElementRotation(availableFuelStations[i].drawerObject, 0, 0, availableFuelStations[i].storePos[4] + 90)
    end
    cashObjects[i] = {}
  end
  triggerServerEvent("requestFuelRobData", resourceRoot)
end
function onFuelStationEnter(element, matchingDimension)
  if element == localPlayer and matchingDimension then
    currentFuelStation = fuelStationIds[source]
    setElementData(localPlayer, "currentStation", currentFuelStation)
    addEventHandler("onClientRender", getRootElement(), renderInFuelStation)
    addEventHandler("onClientPreRender", getRootElement(), preRenderInFuelStation)
    addEventHandler("onClientClick", getRootElement(), clickInFuelStation)
    addEventHandler("onClientPlayerTarget", getLocalPlayer(), targetInFuelStation)
  end
end
function onFuelStationLeave(element)
  if element == localPlayer then
    currentFuelStation = false
    setElementData(localPlayer, "currentStation", currentFuelStation)
    removeEventHandler("onClientRender", getRootElement(), renderInFuelStation)
    removeEventHandler("onClientPreRender", getRootElement(), preRenderInFuelStation)
    removeEventHandler("onClientClick", getRootElement(), clickInFuelStation)
    removeEventHandler("onClientPlayerTarget", getLocalPlayer(), targetInFuelStation)
  end
end
function alarmBlipColor(fuelStation, state)
  local c = state and sightred or sightblue
  if isElement(alarmBlips[fuelStation]) then
    setBlipColor(alarmBlips[fuelStation], c[1], c[2], c[3], 255)
    if isTimer(alarmBlipTimers[fuelStation]) then
      killTimer(alarmBlipTimers[fuelStation])
    end
    alarmBlipTimers[fuelStation] = setTimer(alarmBlipColor, 500, 1, fuelStation, not state)
  end
end
function doAlarmStuff(id, state)
  if alarmStates[id] ~= state and inPolice then
    if state then
      outputChatBox("[color=sightred][SightMTA - Security]: #ffffffFigyelem minden egységnek! Egy benzinkút riasztója megszólalt. [color=sightblue](" .. availableFuelStations[id].stationName .. ")", 255, 255, 255, true)
      playSound(":sGroups/files/backup.mp3")
      if not isElement(alarmBlips[id]) then
        alarmBlips[id] = createBlip(availableFuelStations[id].storePos[1], availableFuelStations[id].storePos[2], availableFuelStations[id].storePos[3], 35, 2, sightblue[1], sightblue[2], sightblue[3])
        setElementData(alarmBlips[id], "tooltipText", "Benzinkút riasztó (" .. availableFuelStations[id].stationName .. ")")
      end
      if not isTimer(alarmBlipTimers[id]) then
        alarmBlipTimers[id] = setTimer(alarmBlipColor, 500, 1, id, true)
      end
    else
      if isElement(alarmBlips[id]) then
        destroyElement(alarmBlips[id])
      end
      alarmBlips[id] = false
      if isTimer(alarmBlipTimers[id]) then
        killTimer(alarmBlipTimers[id])
      end
      alarmBlipTimers[id] = false
    end
  end
  alarmStates[id] = state
  if state then
    if not isElement(alarmSounds[id]) then
      alarmSounds[id] = playSound3D("files/alarm.wav", availableFuelStations[id].storePos[1], availableFuelStations[id].storePos[2], availableFuelStations[id].storePos[3], true)
      setSoundMaxDistance(alarmSounds[id], 240)
      setSoundVolume(alarmSounds[id], 1.5)
    end
  else
    if isElement(alarmSounds[id]) then
      destroyElement(alarmSounds[id])
    end
    alarmSounds[id] = false
  end
end
addEvent("gotFuelrobNPCDuckAll", true)
addEventHandler("gotFuelrobNPCDuckAll", resourceRoot, function(data)
  npcDuck = data
end)
addEvent("gotFuelrobNPCDuck", true)
addEventHandler("gotFuelrobNPCDuck", root, function(fuelStation, state)
  npcDuck[fuelStation] = state
end)
addEvent("gotFuelrobNPCFearAll", true)
addEventHandler("gotFuelrobNPCFearAll", resourceRoot, function(data)
  npcFear = data
end)
addEvent("gotFuelrobNPCFear", true)
addEventHandler("gotFuelrobNPCFear", root, function(fuelStation, state)
  npcFear[fuelStation] = state
end)
addEvent("gotFuelrobNPCFearLevelAll", true)
addEventHandler("gotFuelrobNPCFearLevelAll", resourceRoot, function(data)
  for i = 1, #availableFuelStations do
    local fear = data[i]
    if fear then
      for ped, val in pairs(fear) do
        targetNpcFearLevels[i][ped] = val or 1
        if not currentFuelStation or currentFuelStation ~= i then
          npcFearLevels[i][ped] = val
        end
      end
    end
  end
end)
addEvent("gotFuelrobNPCFearLevel", true)
addEventHandler("gotFuelrobNPCFearLevel", resourceRoot, function(fuelStation, ped, val)
  targetNpcFearLevels[fuelStation][ped] = val or 1
  if not currentFuelStation or currentFuelStation ~= fuelStation then
    npcFearLevels[fuelStation][ped] = val
  end
end)
addEvent("gotFuelrobNPCAimAll", true)
addEventHandler("gotFuelrobNPCAimAll", getRootElement(), function(aim)
  npcAim = aim
end)
addEvent("gotFuelrobNPCAim", true)
addEventHandler("gotFuelrobNPCAim", getRootElement(), function(fuelStation, npcId, aim)
  npcAim[fuelStation][npcId] = aim
end)
addEvent("gotFuelrobAlarmStateAll", true)
addEventHandler("gotFuelrobAlarmStateAll", getRootElement(), function(states)
  for i = 1, #availableFuelStations do
    doAlarmStuff(i, states[i])
  end
end)
addEvent("gotFuelrobAlarmState", true)
addEventHandler("gotFuelrobAlarmState", getRootElement(), function(id, state)
  doAlarmStuff(id, state)
end)
function createCashObjects(fuelStation)
  for i = 1, 6 do
    local dX, dY, dZ = getElementPosition(availableFuelStations[fuelStation].drawerObject)
    local rot = availableFuelStations[fuelStation].storePos[4] + 90
    local r = math.rad(rot)
    local c = math.cos(r)
    local s = math.sin(r)
    local x = dX + c * cashObjectOffsets[i][1] + s * (cashObjectOffsets[i][2] + 0.2)
    local y = dY + s * cashObjectOffsets[i][1] - c * (cashObjectOffsets[i][2] + 0.2)
    local z = dZ - 0.048638 + cashObjectOffsets[i][3] + 0.111
    if x and y and z then
      local obj = createObject(model_ids.sCashregister_cash, x, y, z)
      if isElement(obj) then
        cashObjects[fuelStation][i] = obj
        setObjectScale(obj, 0.9)
        setElementRotation(obj, 0, 0, rot)
      end
    end
  end
end
function destroyCashObjects(fuelStation)
  for i = 1, 6 do
    if isElement(cashObjects[fuelStation][i]) then
      destroyElement(cashObjects[fuelStation][i])
    end
  end
  cashObjects[fuelStation] = {}
end
function checkResourceStates()
  local sFuel = getResourceFromName("sFuel")
  local sPeds = getResourceFromName("sPeds")
  if sFuel and getResourceState(sFuel) == "running" and sPeds and getResourceState(sPeds) == "running" and sightexports.sFuel:areMainElementsCreated() and sightexports.sPeds:arePedsInit() then
    processFuelElements()
    return 
  end
  setTimer(checkResourceStates, 3000, 1)
end
addEvent("gotFuelrobDrawerOpenAll", true)
addEventHandler("gotFuelrobDrawerOpenAll", getRootElement(), function(data)
  drawerOpens = data
  for i = 1, #availableFuelStations do
    local storeElement = availableFuelStations[i].storeElement
    if isElement(storeElement) then
      local mat = getElementMatrix(storeElement)
      if drawerOpens[i] then
        setElementPosition(availableFuelStations[i].drawerObject, drawerOpenX * mat[1][1] + drawerOpenY * mat[2][1] + drawerOpenZ * mat[3][1] + mat[4][1], drawerOpenX * mat[1][2] + drawerOpenY * mat[2][2] + drawerOpenZ * mat[3][2] + mat[4][2], drawerOpenX * mat[1][3] + drawerOpenY * mat[2][3] + drawerOpenZ * mat[3][3] + mat[4][3])
        createCashObjects(i)
      else
        setElementPosition(availableFuelStations[i].drawerObject, drawerCloseX * mat[1][1] + drawerCloseY * mat[2][1] + drawerCloseZ * mat[3][1] + mat[4][1], drawerCloseX * mat[1][2] + drawerCloseY * mat[2][2] + drawerCloseZ * mat[3][2] + mat[4][2], drawerCloseX * mat[1][3] + drawerCloseY * mat[2][3] + drawerCloseZ * mat[3][3] + mat[4][3])
        destroyCashObjects(i)
      end
    end
  end
end)
addEvent("gotFuelrobDrawerOpen", true)
addEventHandler("gotFuelrobDrawerOpen", root, function(fuelStation, now)
  drawerOpens[fuelStation] = now and getTickCount() or false
  local storeElement = availableFuelStations[fuelStation].storeElement
  if isElement(storeElement) then
    local mat = getElementMatrix(storeElement)
    local dX, dY, dZ = getElementPosition(availableFuelStations[fuelStation].drawerObject)
    if drawerOpens[fuelStation] then
      local x = drawerOpenX * mat[1][1] + drawerOpenY * mat[2][1] + drawerOpenZ * mat[3][1] + mat[4][1]
      local y = drawerOpenX * mat[1][2] + drawerOpenY * mat[2][2] + drawerOpenZ * mat[3][2] + mat[4][2]
      local z = drawerOpenX * mat[1][3] + drawerOpenY * mat[2][3] + drawerOpenZ * mat[3][3] + mat[4][3]
      if currentFuelStation and currentFuelStation == fuelStation then
        moveObject(availableFuelStations[fuelStation].drawerObject, 2000, x, y, z)
        playSound3D("files/cashregopen.wav", dX, dY, dZ)
      else
        setElementPosition(availableFuelStations[fuelStation].drawerObject, x, y, z)
      end
      setTimer(function()
        createCashObjects(fuelStation)
      end, 2000, 1)
    else
      local x = drawerCloseX * mat[1][1] + drawerCloseY * mat[2][1] + drawerCloseZ * mat[3][1] + mat[4][1]
      local y = drawerCloseX * mat[1][2] + drawerCloseY * mat[2][2] + drawerCloseZ * mat[3][2] + mat[4][2]
      local z = drawerCloseX * mat[1][3] + drawerCloseY * mat[2][3] + drawerCloseZ * mat[3][3] + mat[4][3]
      if currentFuelStation and currentFuelStation == fuelStation then
        moveObject(availableFuelStations[fuelStation].drawerObject, 2000, x, y, z)
        playSound3D("files/cashregclose.wav", dX, dY, dZ)
      else
        setElementPosition(availableFuelStations[fuelStation].drawerObject, x, y, z)
      end
      destroyCashObjects(fuelStation)
    end
  end
end)
addEvent("gotFuelrobSyncedBoxDataAll", true)
addEventHandler("gotFuelrobSyncedBoxDataAll", getRootElement(), function(data)
  boxData = data
end)
addEvent("gotFuelrobSyncedBoxData", true)
addEventHandler("gotFuelrobSyncedBoxData", root, function(fuelStation, data)
  boxData[fuelStation] = data
end)
addEvent("fuelrobGetOutBox", true)
addEventHandler("fuelrobGetOutBox", getRootElement(), function(fuelStation, cash, amt)
  boxData[fuelStation][cash] = true
  if currentFuelStation and currentFuelStation == fuelStation then
    local x, y, z = getElementPosition(source)
    if x and y and z then
      playSound3D("files/money.mp3", x, y, z)
    end
    if isElement(cashObjects[fuelStation][cash]) then
      local cashX, cashY, cashZ = getElementPosition(cashObjects[fuelStation][cash])
      moveObject(cashObjects[fuelStation][cash], 3800, cashX, cashY, cashZ + 0.1)
      setTimer(function()
        if isElement(cashObjects[fuelStation][cash]) then
          destroyElement(cashObjects[fuelStation][cash])
        end
        cashObjects[fuelStation][cash] = nil
      end, 3800, 1)
      cashText = {
        boxId = cash,
        amount = amt,
      }
    end
  end
end)
addEvent("gotFuelRobMinigame", true)
addEventHandler("gotFuelRobMinigame", root, function(state)
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
function preRenderInFuelStation(delta)
  if not currentFuelStation then
    return 
  end
  processNPCFear(getTickCount(), delta)
end
function renderInFuelStation()
  if not currentFuelStation then
    return 
  end
  local r0_37 = false
  local r1_37 = false
  local r2_37, r3_37, r4_37 = getElementPosition(localPlayer)
  local r5_37, r6_37, r7_37, r8_37, r9_37, r10_37 = getCameraMatrix()
  renderNPCFear(getTickCount(), r5_37, r6_37, r7_37, r8_37, r9_37, r10_37)
  local r12_37, r13_37 = getCursorPosition()
  if r12_37 then
    r12_37 = r12_37 * sX
    r13_37 = r13_37 * sY
  end
  local r14_37, r15_37, r16_37 = getElementPosition(localPlayer)
  local r17_37 = npcElements[currentFuelStation][1]
  if isElement(r17_37) then
    local r18_37 = {
      getElementPosition(r17_37)
    }
    r18_37[3] = r18_37[3] + 0.5
    local r20_37 = 255 * math.min(1, (1 - (getDistanceBetweenPoints3D(r14_37, r15_37, r16_37, r18_37[1], r18_37[2], r18_37[3]) - 2.5) / 2))
    if npcFear[currentFuelStation] and not npcDuck[currentFuelStation] and 0 < r20_37 then
      local r21_37, r22_37 = getScreenFromWorldPosition(r18_37[1], r18_37[2], r18_37[3])
      if r21_37 then
        dxDrawRectangle(r21_37 - 16, r22_37 - 16, 32, 32, tocolor(vgrey1[1], vgrey1[2], vgrey1[3], r20_37))
        if 255 <= r20_37 and r12_37 and r21_37 - 16 <= r12_37 and r12_37 <= r21_37 + 16 and r22_37 - 16 <= r13_37 and r13_37 <= r22_37 + 16 then
          r0_37 = "npcfear"
          dxDrawImage(r21_37 - 12, r22_37 - 12, 24, 24, ":sGui/" .. fearFaceIcon .. faTicks[fearFaceIcon], 0, 0, 0, tocolor(sggreen[1], sggreen[2], sggreen[3], r20_37))
        else
          dxDrawImage(r21_37 - 12, r22_37 - 12, 24, 24, ":sGui/" .. fearFaceIcon .. faTicks[fearFaceIcon], 0, 0, 0, tocolor(255, 255, 255, r20_37))
        end
      end
    end
    if drawerOpens[currentFuelStation] and 0 < r20_37 then
      local r21_37, r22_37, r23_37 = getElementPosition(availableFuelStations[currentFuelStation].drawerObject)
      r23_37 = r23_37 - 0.048638
      local r25_37 = math.rad(availableFuelStations[currentFuelStation].storePos[4] + 90)
      local r26_37 = math.cos(r25_37)
      local r27_37 = math.sin(r25_37)
      for i = 1, 6 do
        if not boxData[currentFuelStation][i] then
          local r35_37, r36_37 = getScreenFromWorldPosition(r21_37 + r26_37 * cashOffsets[i][1] + r27_37 * (cashOffsets[i][2] + 0.25), r22_37 + r27_37 * cashOffsets[i][1] - r26_37 * (cashOffsets[i][2] + 0.25), r23_37 + cashOffsets[i][3] + 0.086, 256)
          if r35_37 then
            dxDrawRectangle(r35_37 - 16, r36_37 - 16, 32, 32, tocolor(vgrey1[1], vgrey1[2], vgrey1[3], r20_37))
            if 255 <= r20_37 and r12_37 and r35_37 - 16 <= r12_37 and r12_37 <= r35_37 + 16 and r36_37 - 16 <= r13_37 and r13_37 <= r36_37 + 16 then
              r0_37 = "box"
              r1_37 = i
              dxDrawImage(r35_37 - 12, r36_37 - 12, 24, 24, ":sGui/" .. inboxOutIcon .. faTicks[inboxOutIcon], 0, 0, 0, tocolor(sggreen[1], sggreen[2], sggreen[3], r20_37))
            else
              dxDrawImage(r35_37 - 12, r36_37 - 12, 24, 24, ":sGui/" .. inboxOutIcon .. faTicks[inboxOutIcon], 0, 0, 0, tocolor(255, 255, 255, r20_37))
            end
          end
        end
      end
    end
    if cashText then
      if not isElement(cashObjects[currentFuelStation][cashText.boxId]) then
        cashText = false
      elseif r20_37 > 0 then
        local r21_37, r22_37, r23_37 = getElementPosition(cashObjects[currentFuelStation][cashText.boxId])
        local r24_37, r25_37 = getScreenFromWorldPosition(r21_37, r22_37, r23_37, 256)
        if r24_37 then
          dxDrawText(sightexports.sGui:thousandsStepper(cashText.amount) .. " $", r24_37 - 10, r25_37 - 10, r24_37 - 10, r25_37 - 10, tocolor(sggreen[1], sggreen[2], sggreen[3], r20_37), cashFontScale, cashFont, "center", "center")
        end
      end
    end
  end
  if r0_37 ~= tmp or boxId ~= r1_37 then
    tmp = r0_37
    boxId = r1_37
    if tmp then
      if tmp == "npcfear" then
        sightexports.sGui:showTooltip("Fenyegetés\n(Kasszanyitás)")
      end
      if tmp == "box" then
        sightexports.sGui:showTooltip("Pénzköteg kivétele")
      end
    else
      sightexports.sGui:showTooltip()
    end
    local r18_37 = sightexports.sGui
    local r20_37 = tmp and "link" or "normal"
    r18_37:setCursorType(r20_37)
  end
end
function clickInFuelStation(button, state)
  if state == "down" then
    local now = getTickCount()
    if 500 < now - lastClick and tmp then
      if tmp == "npcfear" then
        lastClick = now
        triggerServerEvent("tryStartFuelFearMinigame", resourceRoot)
      end
      if tmp == "box" and drawerOpens[currentFuelStation] and drawerOpens[currentFuelStation] + 2000 < getTickCount() then
        lastClick = now
        triggerServerEvent("tryToGetOutFuelBox", resourceRoot, boxId)
      end
    end
  end
end
function isPedBeingTargetted(fuelStation, ped)
  for i = 1, #npcElements[fuelStation] do
    if ped == npcElements[fuelStation][i] then
      return i
    end
  end
  return false
end
function targetInFuelStation(target)
  if not currentFuelStation then
    return 
  end
  local beingTargeted = isPedBeingTargetted(currentFuelStation, target)
  if beingTargeted then
    triggerServerEvent("onFuelPedAim", resourceRoot, beingTargeted)
  else
    triggerServerEvent("onFuelPedAim", resourceRoot, false)
  end
end
function screenIntersection(r0_42, r1_42, r2_42)
  local r3_42 = sX / 2 - r2_42
  local r4_42 = sY / 2 - r2_42
  local r5_42 = r4_42 / r3_42
  local r6_42 = math.abs(r1_42 / r0_42)
  local r7_42 = r0_42 > 0 and 1 or -1
  local r8_42 = r1_42 > 0 and 1 or -1
  local r9_42 = 0
  local r10_42 = 0
  if r5_42 < r6_42 then
    r9_42 = r4_42 / r6_42 * r7_42
    r10_42 = r4_42 * r8_42
  else
    r9_42 = r3_42 * r7_42
    r10_42 = r3_42 * r6_42 * r8_42
  end
  return r9_42, r10_42
end
function renderNPCFear(now, camx, camy, camz, ctx, cty, ctz)
  if currentFuelStation and npcFear[currentFuelStation] and not npcDuck[currentFuelStation] then
    local pulse = now % 600 / 300
    if pulse > 1 then
      pulse = 2 - pulse
    end
    pulse = getEasingValue(pulse, "InOutQuad")
    local r2 = math.atan2(camy - cty, camx - ctx) + math.pi / 2
    for i = 1, #npcElements[currentFuelStation] do
      if isElement(npcElements[currentFuelStation][i]) then
        local nx, ny, nz = getElementPosition(npcElements[currentFuelStation][i])
        drawNPCFear(currentFuelStation, i, pulse, ctx, cty, r2, nx, ny, nz)
      end
    end
  end
end
function processNPCFear(now, delta)
  if not currentFuelStation then
    return 
  end
  for i = 1, #npcElements[currentFuelStation] do
    if targetNpcFearLevels[currentFuelStation][i] < npcFearLevels[currentFuelStation][i] then
      npcFearLevels[currentFuelStation][i] = npcFearLevels[currentFuelStation][i] - 1 * delta / 1000
      if npcFearLevels[currentFuelStation][i] < targetNpcFearLevels[currentFuelStation][i] then
        npcFearLevels[currentFuelStation][i] = targetNpcFearLevels[currentFuelStation][i]
      end
    elseif npcFearLevels[currentFuelStation][i] < targetNpcFearLevels[currentFuelStation][i] then
      npcFearLevels[currentFuelStation][i] = npcFearLevels[currentFuelStation][i] + 1 * delta / 1000
      if targetNpcFearLevels[currentFuelStation][i] < npcFearLevels[currentFuelStation][i] then
        npcFearLevels[currentFuelStation][i] = targetNpcFearLevels[currentFuelStation][i]
      end
    end
    if isElement(npcElements[currentFuelStation][i]) then
      local a, b = getPedAnimation(npcElements[currentFuelStation][i])
      if npcDuck[currentFuelStation] then
        if a ~= "ped" or b ~= "duck_cower" then
          setPedAnimation(npcElements[currentFuelStation][i], "ped", "duck_cower", -1, false, false, false)
        end
      elseif npcFear[currentFuelStation] then
        if npcAim[currentFuelStation] and npcAim[currentFuelStation][i] then
          targetNpcFearLevels[currentFuelStation][i] = math.min(1, targetNpcFearLevels[currentFuelStation][i] + fearRecharge * delta / 1000)
        else
          targetNpcFearLevels[currentFuelStation][i] = math.max(0, targetNpcFearLevels[currentFuelStation][i] - fearDischarge * delta / 1000)
        end
        if a ~= "ped" or b ~= "handsup" then
          setPedAnimation(npcElements[currentFuelStation][i], "ped", "handsup", -1, false, false, false)
        end
      elseif a or b then
        setPedAnimation(npcElements[currentFuelStation][i])
      end
    end
  end
end
function drawNPCFear(r0_45, r1_45, r2_45, r3_45, r4_45, r5_45, r6_45, r7_45, r8_45)
  local r9_45, r10_45 = getScreenFromWorldPosition(r6_45, r7_45, r8_45 + 1.25, sX * sY)
  local r11_45 = 0
  local r12_45 = npcFearLevels[currentFuelStation][r1_45] < 0.25 and r2_45 * 8 or 0
  r12_45 = 16 + r12_45
  if r9_45 then
    if r12_45 <= r9_45 and r9_45 <= sX - r12_45 and r12_45 <= r10_45 and r10_45 <= sY - r12_45 then
      dxDrawRectangle(r9_45 - 48, r10_45 + 16 + 4, 96, 10, tocolor(vgrey1[1], vgrey1[2], vgrey1[3]))
      dxDrawRectangle(r9_45 - 48 + 1, r10_45 + 16 + 4 + 1, 94 * npcFearLevels[currentFuelStation][r1_45], 8, tocolor(sightred[1], sightred[2], sightred[3]))
      dxDrawImage(r9_45 - r12_45 + 1, r10_45 - r12_45 + 1, r12_45 * 2, r12_45 * 2, ":sGui/" .. fearIcon .. faTicks[fearIcon], 0, 0, 0, tocolor(vgrey1[1], vgrey1[2], vgrey1[3]))
      dxDrawImage(r9_45 - r12_45, r10_45 - r12_45, r12_45 * 2, r12_45 * 2, ":sGui/" .. fearIcon .. faTicks[fearIcon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
      return 
    end
    r11_45 = -math.atan2((r9_45 - sX / 2), (r10_45 - sY / 2)) + math.pi / 2
  else
    r11_45 = -math.atan2((r7_45 - r4_45), (r6_45 - r3_45)) + r5_45
  end
  local r13_45 = 10000 * math.cos(r11_45)
  local r14_45 = 10000 * math.sin(r11_45)
  r13_45, r14_45 = screenIntersection(r13_45, r14_45, 16)
  dxDrawImage(sX / 2 + r13_45 - 24 + 1, sY / 2 + r14_45 - 24 + 1, 48, 48, ":sGui/" .. fearArrowIcon .. faTicks[fearArrowIcon], math.deg(r11_45), 0, 0, tocolor(vgrey1[1], vgrey1[2], vgrey1[3]))
  dxDrawImage(sX / 2 + r13_45 - 24, sY / 2 + r14_45 - 24, 48, 48, ":sGui/" .. fearArrowIcon .. faTicks[fearArrowIcon], math.deg(r11_45), 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
  local r15_45 = math.sqrt(r13_45 * r13_45 + r14_45 * r14_45)
  r13_45 = r13_45 / r15_45 * (r15_45 - 32)
  r14_45 = r14_45 / r15_45 * (r15_45 - 32)
  dxDrawImage(sX / 2 + r13_45 - r12_45 + 1, sY / 2 + r14_45 - r12_45 + 1, r12_45 * 2, r12_45 * 2, ":sGui/" .. fearIcon .. faTicks[fearIcon], 0, 0, 0, tocolor(vgrey1[1], vgrey1[2], vgrey1[3]))
  dxDrawImage(sX / 2 + r13_45 - r12_45, sY / 2 + r14_45 - r12_45, r12_45 * 2, r12_45 * 2, ":sGui/" .. fearIcon .. faTicks[fearIcon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
end
function refreshInPolice()
  local tmp = sightexports.sGroups:isPlayerInLawEnforcement()
  if inPolice ~= tmp then
    inPolice = tmp
    if inPolice then
      for i = 1, #availableFuelStations do
        if alarmStates[i] then
          if not isElement(alarmBlips[i]) then
            alarmBlips[i] = createBlip(availableFuelStations[i].storePos[1], availableFuelStations[i].storePos[2], availableFuelStations[i].storePos[3], 32, 2, sightblue[1], sightblue[2], sightblue[3])
            setElementData(alarmBlips[i], "tooltipText", "Benzinkút riasztó (" .. availableFuelStations[i].stationName .. ")")
          end
          if not isTimer(alarmBlipTimers[i]) then
            alarmBlipTimers[i] = setTimer(alarmBlipColor, 500, 1, i, true)
          end
        end
      end
    else
      for i = 1, #availableFuelStations do
        local alarmBlips = alarmBlips[i]
        if alarmBlips then
          if isElement(alarmBlips) then
            destroyElement(alarmBlips)
          end
          alarmBlips[i] = false
        end
        local alarmBlipTimer = alarmBlipTimers[i]
        if alarmBlipTimer then
          if isTimer(alarmBlipTimer) then
            killTimer(alarmBlipTimer)
          end
          alarmBlipTimers[i] = false
        end
      end
    end
    refreshCasetteBlips()
  end
end
function renderFearMinigame()
  local now = getTickCount()
  local oX = sX / 2
  local oY = math.floor(sY * 0.8)
  dxDrawRectangle(oX - 150, oY - 8, 300, 16, tocolor(vgrey1[1], vgrey1[2], vgrey1[3]))
  local col = tocolor(sightred[1], sightred[2], sightred[3])
  if 0.1 < fearMinigameCursor and fearMinigameCursor <= 0.5 then
    col = tocolor(sightred[1] + (sggreen[1] - sightred[1]) * (fearMinigameCursor - 0.1) / 0.4, sightred[2] + (sggreen[2] - sightred[2]) * (fearMinigameCursor - 0.1) / 0.4, sightred[3] + (sggreen[3] - sightred[3]) * (fearMinigameCursor - 0.1) / 0.4)
  elseif 0.1 < fearMinigameCursor and fearMinigameCursor < 0.9 then
    col = tocolor(sggreen[1] + (sightred[1] - sggreen[1]) * (fearMinigameCursor - 0.5) / 0.4, sggreen[2] + (sightred[2] - sggreen[2]) * (fearMinigameCursor - 0.5) / 0.4, sggreen[3] + (sightred[3] - sggreen[3]) * (fearMinigameCursor - 0.5) / 0.4)
  end
  dxDrawRectangle(oX - 150 + 294 * fearMinigameCursor, oY - 8, 6, 16, col)
  if fearMinigameProg < 0 then
    local p = -32 * fearMinigameProg
    dxDrawImageSection(oX - 150 - 16, oY - 8 - 32, 32, 32 - p, 0, 0, 32, 32 - p, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(vgrey1[1], vgrey1[2], vgrey1[3]))
    dxDrawImageSection(oX - 150 - 16, oY - 8 - 32 + 32 - p, 32, p, 0, 32 - p, 32, p, ":sGui/" .. anger2Icon .. faTicks[anger2Icon], 0, 0, 0, tocolor(vgrey1[1], vgrey1[2], vgrey1[3]))
    dxDrawImageSection(oX - 150 - 16, oY - 8 - 32, 32, 32 - p, 0, 0, 32, 32 - p, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
    dxDrawImageSection(oX - 150 - 16, oY - 8 - 32 + 32 - p, 32, p, 0, 32 - p, 32, p, ":sGui/" .. anger2Icon .. faTicks[anger2Icon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
  else
    dxDrawImage(oX - 150 - 16 + 1, oY - 8 - 32 + 1, 32, 32, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(vgrey1[1], vgrey1[2], vgrey1[3]))
    dxDrawImage(oX - 150 - 16, oY - 8 - 32, 32, 32, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
  end
  if fearMinigameProg > 0 then
    local p = 32 * fearMinigameProg
    dxDrawImageSection(oX - 16, oY - 8 - 32, 32, 32 - p, 0, 0, 32, 32 - p, ":sGui/" .. fearFaceIcon .. faTicks[fearFaceIcon], 0, 0, 0, tocolor(vgrey1[1], vgrey1[2], vgrey1[3]))
    dxDrawImageSection(oX - 16, oY - 8 - 32 + 32 - p, 32, p, 0, 32 - p, 32, p, ":sGui/" .. fearFace2Icon .. faTicks[fearFace2Icon], 0, 0, 0, tocolor(vgrey1[1], vgrey1[2], vgrey1[3]))
    dxDrawImageSection(oX - 16, oY - 8 - 32, 32, 32 - p, 0, 0, 32, 32 - p, ":sGui/" .. fearFaceIcon .. faTicks[fearFaceIcon], 0, 0, 0, tocolor(sggreen[1], sggreen[2], sggreen[3]))
    dxDrawImageSection(oX - 16, oY - 8 - 32 + 32 - p, 32, p, 0, 32 - p, 32, p, ":sGui/" .. fearFace2Icon .. faTicks[fearFace2Icon], 0, 0, 0, tocolor(sggreen[1], sggreen[2], sggreen[3]))
  else
    dxDrawImage(oX - 16 + 1, oY - 8 - 32 + 1, 32, 32, ":sGui/" .. fearFaceIcon .. faTicks[fearFaceIcon], 0, 0, 0, tocolor(vgrey1[1], vgrey1[2], vgrey1[3]))
    dxDrawImage(oX - 16, oY - 8 - 32, 32, 32, ":sGui/" .. fearFaceIcon .. faTicks[fearFaceIcon], 0, 0, 0, tocolor(sggreen[1], sggreen[2], sggreen[3]))
  end
  if fearMinigameProg < 0 then
    local p = -32 * fearMinigameProg
    dxDrawImageSection(oX + 150 - 16, oY - 8 - 32, 32, 32 - p, 0, 0, 32, 32 - p, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(vgrey1[1], vgrey1[2], vgrey1[3]))
    dxDrawImageSection(oX + 150 - 16, oY - 8 - 32 + 32 - p, 32, p, 0, 32 - p, 32, p, ":sGui/" .. anger2Icon .. faTicks[anger2Icon], 0, 0, 0, tocolor(vgrey1[1], vgrey1[2], vgrey1[3]))
    dxDrawImageSection(oX + 150 - 16, oY - 8 - 32, 32, 32 - p, 0, 0, 32, 32 - p, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
    dxDrawImageSection(oX + 150 - 16, oY - 8 - 32 + 32 - p, 32, p, 0, 32 - p, 32, p, ":sGui/" .. anger2Icon .. faTicks[anger2Icon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
  else
    dxDrawImage(oX + 150 - 16 + 1, oY - 8 - 32 + 1, 32, 32, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(vgrey1[1], vgrey1[2], vgrey1[3]))
    dxDrawImage(oX + 150 - 16, oY - 8 - 32, 32, 32, ":sGui/" .. angerIcon .. faTicks[angerIcon], 0, 0, 0, tocolor(sightred[1], sightred[2], sightred[3]))
  end
  if countdown > 0 then
    local p = math.floor(countdown / 1000)
    local r5_47 = countdown / 1000 - p
    local r6_47 = 1
    if p < 1 then
      p = "START"
      r6_47 = r5_47
    end
    dxDrawText(p, oX + 1, oY - 16 + 1, oX + 1, oY - 16 + 1, tocolor(0, 0, 0, 255 * math.min(1, r6_47 * 2)), timerFontScale * (1 + 1 * r5_47), timerFont, "center", "center")
    dxDrawText(p, oX, oY - 16, oX, oY - 16, tocolor(255, 255, 255, 255 * math.min(1, r6_47 * 2)), timerFontScale * (1 + 1 * r5_47), timerFont, "center", "center")
  end
end
function preRenderFearMinigame(delta)
  local now = getTickCount()
  countdown = countdown - delta
  if countdown < 0 then
    if fearMinigameNextUpTime < now - fearMinigameNextUpStart then
      fearMinigameNextUpStart = now
      fearMinigameNextUpTime = math.random(50, 500)
      fearMinigameUpSpeed = fearMinigameNextUpSpeed
      fearMinigameNextUpSpeed = 0.2 + math.random() * 0.75
    end
    if fearMinigameNextDownTime < now - fearMinigameNextDownStart then
      fearMinigameNextDownStart = now
      fearMinigameNextDownTime = math.random(50, 500)
      fearMinigameDownSpeed = fearMinigameNextDownSpeed
      fearMinigameNextDownSpeed = 0.2 + math.random() * 0.75
    end
  end
  local spd = 0
  if getKeyState("space") then
    spd = fearMinigameUpSpeed + (fearMinigameNextUpSpeed - fearMinigameUpSpeed) * math.min(1, (now - fearMinigameNextUpStart) / fearMinigameNextUpTime)
  else
    spd = -(fearMinigameDownSpeed + (fearMinigameNextDownSpeed - fearMinigameDownSpeed) * math.min(1, (now - fearMinigameNextDownStart) / fearMinigameNextDownTime))
  end
  fearMinigameCursor = math.min(1, math.max(0, fearMinigameCursor + spd * delta / 1000))
  local r3_48, r4_48, r5_48 = getElementPosition(localPlayer)
  if getDistanceBetweenPoints3D(r3_48, r4_48, r5_48, getElementPosition(npcElements[currentFuelStation][1])) > 3 then
    removeEventHandler("onClientRender", getRootElement(), renderFearMinigame)
    removeEventHandler("onClientPreRender", getRootElement(), preRenderFearMinigame)
    triggerServerEvent("fuelRobMinigameResult", resourceRoot)
    npcMinigame = false
    return 
  end
  if fearMinigameCursor <= 0.4 then
    fearMinigameProg = fearMinigameProg - (0.4 - fearMinigameCursor) / 0.4 * 2.75 * delta / 1000
    if fearMinigameProg < -1 then
      removeEventHandler("onClientRender", getRootElement(), renderFearMinigame)
      removeEventHandler("onClientPreRender", getRootElement(), preRenderFearMinigame)
      triggerServerEvent("fuelRobMinigameResult", resourceRoot)
      npcMinigame = false
    end
  elseif 0.42 <= fearMinigameCursor and fearMinigameCursor <= 0.58 then
    fearMinigameProg = fearMinigameProg + (1 - math.abs((fearMinigameCursor - 0.5)) / 0.08) * 0.425 * delta / 1000
    if fearMinigameProg > 1 then
      removeEventHandler("onClientRender", getRootElement(), renderFearMinigame)
      removeEventHandler("onClientPreRender", getRootElement(), preRenderFearMinigame)
      triggerServerEvent("fuelRobMinigameResult", resourceRoot, true)
      npcMinigame = false
    end
  elseif fearMinigameCursor >= 0.6 then
    fearMinigameProg = fearMinigameProg - (fearMinigameCursor - 0.6) / 0.4 * 2.75 * delta / 1000
    if fearMinigameProg < -1 then
      removeEventHandler("onClientRender", getRootElement(), renderFearMinigame)
      removeEventHandler("onClientPreRender", getRootElement(), preRenderFearMinigame)
      triggerServerEvent("fuelRobMinigameResult", resourceRoot)
      npcMinigame = false
    end
  end
end
addEvent("gotPlayerGroupMembership", true)
addEventHandler("gotPlayerGroupMembership", getRootElement(), refreshInPolice)
addEventHandler("onClientResourceStart", resourceRoot, function()
  refreshInPolice()
  if getElementData(localPlayer, "loggedIn") then
    loadModelIds()
  end
  setTimer(checkResourceStates, 3000, 1)
end)

addEventHandler("onClientElementDataChange", root, function(key, oValue, nValue)
  if source == localPlayer and key == "loggedIn" and nValue then
    setTimer(checkResourceStates, 3000, 1)
  end
end)

fearDischarge = 0.075
fearRecharge = 0.25
minimumPD = 8
robCols = {}
availableFuelStations = {}
cashOffsets = {
  {
    -0.23646,
    -0.45,
    -0.05614
  },
  {
    -0.14646,
    -0.45,
    -0.05614
  },
  {
    -0.05646,
    -0.45,
    -0.05614
  },
  {
    0.02946,
    -0.45,
    -0.05614
  },
  {
    0.11946,
    -0.45,
    -0.05614
  },
  {
    0.20946,
    -0.45,
    -0.05614
  }
}
cashObjectOffsets = {
  {
    -0.22246,
    -0.45,
    -0.05614
  },
  {
    -0.13646,
    -0.45,
    -0.05614
  },
  {
    -0.04646,
    -0.45,
    -0.05614
  },
  {
    0.03546,
    -0.45,
    -0.05614
  },
  {
    0.11946,
    -0.45,
    -0.05614
  },
  {
    0.20946,
    -0.45,
    -0.05614
  }
}
stackTypes = {
  {
    540,
    12000,
    715
  },
  {
    12001,
    60000,
    716
  },
  {
    60001,
    150000,
    717
  }
}
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sFuel")
    if res0 and getResourceState(res0) == "running" then
      createRobCols()
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
fuelStationIds = {}
function createRobCols()
  for i = 1, #robCols do
    if isElement(robCols[i]) then
      destroyElement(robCols[i])
    end
  end
  availableFuelStations = sightexports.sFuel:getFuelStations()
  for i = 1, #availableFuelStations do
    local fuelStation = availableFuelStations[i]
    if fuelStation then
      local col = createColSphere(fuelStation.storePos[1], fuelStation.storePos[2], fuelStation.storePos[3], 12)
      if isElement(col) then
        robCols[i] = col
        robCols[col] = i
        fuelStationIds[col] = i

        setTimer(function()
          addEventHandler("onClientColShapeHit", col, onFuelStationEnter)
          addEventHandler("onClientColShapeLeave", col, onFuelStationLeave)
        end, 50, 1)
      end
    end
  end
end
function isInFuelStation()
    return currentFuelStation
end