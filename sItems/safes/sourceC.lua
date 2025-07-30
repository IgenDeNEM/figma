local sightexports = {sModloader = false, sPermission = false}
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
  modloaderListener()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), renderSafeDoors, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), renderSafeDoors)
    end
  end
end
storedSafes = {}
local modelIds = {}
function isSafeModel(id)
  return id == modelIds.sight_safe1 or id == modelIds.sight_safe2 or id == modelIds.sight_safe3
end
function findSafeType(id)
  for name, model in pairs(modelIds) do
    if model == id then
      return name
    end
  end
end
local safeDoors = {}
function detachSafeDoors(el)
  if safeDoors[el] then
    for i = 1, #safeDoors[el] do
      if isElement(safeDoors[el][i]) then
        destroyElement(safeDoors[el][i])
      end
      safeDoors[el][i] = nil
    end
  end
  safeDoors[el] = nil
end
function attachSafeDoors(el)
  if isElementStreamedIn(el) then
    local model = getElementModel(el)
    if isSafeModel(model) then
      if safeDoors[el] then
        detachSafeDoors(el)
      end
      safeDoors[el] = {}
      local safeType = findSafeType(model)
      if safeType == "sight_safe1" then
        safeDoors[el][1] = createObject(modelIds.sight_safe1_door, 0, 0, 0)
        setElementDimension(safeDoors[el][1], getElementDimension(el))
        setElementInterior(safeDoors[el][1], getElementInterior(el))
        local x, y, z = getElementPosition(el)
        local rx, ry, rz = getElementRotation(el)
        local rad = math.rad(rz)
        local cos = math.cos(rad)
        local sin = math.sin(rad)
        x = x + cos * 0.4339 + sin * 0.3987
        y = y + sin * 0.4339 - cos * 0.3987
        setElementPosition(safeDoors[el][1], x, y, z + 0.0044)
        setElementRotation(safeDoors[el][1], rx, ry, rz)
      elseif safeType == "sight_safe2" then
        safeDoors[el][1] = createObject(modelIds.sight_safe2_door, 0, 0, 0)
        setElementDimension(safeDoors[el][1], getElementDimension(el))
        setElementInterior(safeDoors[el][1], getElementInterior(el))
        local x, y, z = getElementPosition(el)
        local rx, ry, rz = getElementRotation(el)
        local rad = math.rad(rz)
        local cos = math.cos(rad)
        local sin = math.sin(rad)
        x = x + cos * 0.4258 + sin * 0.4792
        y = y + sin * 0.4258 - cos * 0.4792
        setElementPosition(safeDoors[el][1], x, y, z + 0.3371)
        setElementRotation(safeDoors[el][1], rx, ry, rz)
      elseif safeType == "sight_safe3" then
        safeDoors[el][2] = createObject(modelIds.sight_safe3_Ldoor, 0, 0, 0)
        setElementDimension(safeDoors[el][2], getElementDimension(el))
        setElementInterior(safeDoors[el][2], getElementInterior(el))
        safeDoors[el][1] = createObject(modelIds.sight_safe3_Rdoor, 0, 0, 0)
        setElementDimension(safeDoors[el][1], getElementDimension(el))
        setElementInterior(safeDoors[el][1], getElementInterior(el))
        local x, y, z = getElementPosition(el)
        local rx, ry, rz = getElementRotation(el)
        local rad = math.rad(rz)
        local cos = math.cos(rad)
        local sin = math.sin(rad)
        local x1 = x - cos * 0.65 + sin * 0.375
        local y1 = y - sin * 0.65 - cos * 0.375
        local x2 = x + cos * 0.65 + sin * 0.375
        local y2 = y + sin * 0.65 - cos * 0.375
        setElementPosition(safeDoors[el][2], x1, y1, z + 0.5371)
        setElementPosition(safeDoors[el][1], x2, y2, z + 0.5371)
        setElementRotation(safeDoors[el][2], rx, ry, rz)
        setElementRotation(safeDoors[el][1], rx, ry, rz)
      end
    end
  end
end
local movingSafeDoors = {}
function renderSafeDoors()
  local tick = getTickCount()
  for door, moving in pairs(movingSafeDoors) do
    if isElement(door) then
      local startTick = moving.startTick
      local progress = (tick - startTick) / moving.time
      progress = math.min(progress, 1)
      progress = getEasingValue(progress, "OutQuad")
      local rd = moving.targetRot - moving.defaultRot
      rd = (rd + 180) % 360 - 180
      local rot = moving.defaultRot + rd * progress
      setElementRotation(door, 0, 0, rot)
      if 1 <= progress then
        movingSafeDoors[door] = nil
      end
    else
      movingSafeDoors[door] = nil
    end
  end
end
function openSafe(dbId, relativeRot, inTime)
  local doors = safeDoors[storedSafes[dbId].objectElement]
  local x, y, z = getElementRotation(storedSafes[dbId].objectElement)
  local outTime = 0
  if doors then
    for i = 1, #doors do
      local door = doors[i]
      local currX, currY, currZ = getElementRotation(door)
      local targetRot = (i == 2 and -1 or 1) * relativeRot + z
      local rd = targetRot - currZ
      rd = (rd + 180) % 360 - 180
      local time = math.abs(rd / 90) * inTime
      movingSafeDoors[door] = {
        startTick = getTickCount(),
        time = time,
        defaultRot = currZ,
        targetRot = targetRot
      }
      outTime = math.max(outTime, time)
    end
    sightlangCondHandl0(true)
  end
  return outTime
end
local sounds = {}
local timers = {}
function clearSound(dbId)
  if isElement(sounds[dbId]) then
    destroyElement(sounds[dbId])
  end
  sounds[dbId] = nil
  if isTimer(timers[dbId]) then
    killTimer(timers[dbId])
  end
  timers[dbId] = nil
end
addEvent("syncSafeDoor", true)
addEventHandler("syncSafeDoor", getRootElement(), function(dbId, open)
  if storedSafes[dbId] and isElement(storedSafes[dbId].objectElement) then
    local x, y, z = getElementPosition(storedSafes[dbId].objectElement)
    clearSound(dbId)
    if open then
      local time = openSafe(dbId, 90, 1380)
      local sound = playSound3D("files/sounds/safeopen.wav", x, y, z, false)
      setElementDimension(sound, getElementDimension(storedSafes[dbId].objectElement))
      setElementInterior(sound, getElementInterior(storedSafes[dbId].objectElement))
      setSoundMaxDistance(sound, 15)
      setSoundPosition(sound, math.max(0, 1.38 - time / 1000))
      sounds[dbId] = sound
      timers[dbId] = setTimer(clearSound, 2000, 1, dbId)
    else
      local time = openSafe(dbId, 0, 800)
      local sound = playSound3D("files/sounds/safeclose.wav", x, y, z, false)
      setElementDimension(sound, getElementDimension(storedSafes[dbId].objectElement))
      setElementInterior(sound, getElementInterior(storedSafes[dbId].objectElement))
      setSoundMaxDistance(sound, 15)
      setSoundPosition(sound, math.max(0, 0.8 - time / 1000))
      sounds[dbId] = sound
      timers[dbId] = setTimer(clearSound, 2000, 1, dbId)
    end
  end
end)
function recalcSafeModels()
  for dbId in pairs(storedSafes) do
    recalcSafeModelSingle(storedSafes[dbId].objectElement)
  end
end
function recalcSafeModelSingle(el)
  if isElement(el) then
    local dbId = getElementData(el, "object.dbID")
    if dbId then
      local data = storedSafes[dbId]
      if data and modelIds["sight_safe" .. data.safeType] then
        setElementModel(el, modelIds["sight_safe" .. data.safeType])
        attachSafeDoors(el)
      end
    end
  end
end
addEventHandler("onClientElementDestroy", getRootElement(), function()
  if safeDoors[source] then
    detachSafeDoors(source)
  end
end)
addEventHandler("onClientElementStreamIn", getRootElement(), function()
  recalcSafeModelSingle(source)
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
  detachSafeDoors(source)
end)
function modloaderListener()
  modelIds.sight_safe1 = sightexports.sModloader:getModelId("v4_safe1")
  modelIds.sight_safe1_door = sightexports.sModloader:getModelId("v4_safe1_door")
  modelIds.sight_safe2 = sightexports.sModloader:getModelId("v4_safe2")
  modelIds.sight_safe2_door = sightexports.sModloader:getModelId("v4_safe2_door")
  modelIds.sight_safe3 = sightexports.sModloader:getModelId("v4_safe3")
  modelIds.sight_safe3_Ldoor = sightexports.sModloader:getModelId("v4_safe3_Ldoor")
  modelIds.sight_safe3_Rdoor = sightexports.sModloader:getModelId("v4_safe3_Rdoor")
  recalcSafeModels()
end
addEvent("extraLoadStart:loadingSafes", false)
addEventHandler("extraLoadStart:loadingSafes", getRootElement(), function()
  triggerServerEvent("requestSafes", localPlayer)
end)
if getElementData(localPlayer, "loggedIn") then
  triggerServerEvent("requestSafes", localPlayer)
end
addEvent("recieveSafes", true)
addEventHandler("recieveSafes", getRootElement(), function(safes)
  storedSafes = safes
  recalcSafeModels()
  setTimer(triggerEvent, 250, 1, "extraLoaderDone", localPlayer, "loadingSafes")
end)
addEvent("createSafe", true)
addEventHandler("createSafe", getRootElement(), function(dbId, data)
  storedSafes[dbId] = data
  recalcSafeModelSingle(storedSafes[dbId].objectElement)
end)
addEvent("deleteSafe", true)
addEventHandler("deleteSafe", getRootElement(), function(dbId)
  if storedSafes[dbId] then
    storedSafes[dbId] = nil
  end
end)
addEvent("updateSafe", true)
addEventHandler("updateSafe", getRootElement(), function(dbId, data)
  if storedSafes[dbId] then
    storedSafes[dbId] = data
    recalcSafeModelSingle(storedSafes[dbId].objectElement)
  end
end)
addCommandHandler("nearbysafes", function()
  if sightexports.sPermission:hasPermission(localPlayer, "nearbysafes") then
    local sourcePosX, sourcePosY, sourcePosZ = getElementPosition(localPlayer)
    local sourceInterior = getElementInterior(localPlayer)
    local sourceDimension = getElementDimension(localPlayer)
    local findCount = 0
    outputChatBox("[color=sightgreen][SightMTA - Safe]: #FFFFFFA közeledben lévő széfek:", 255, 255, 255, true)
    for k, v in pairs(storedSafes) do
      if sourceInterior == getElementInterior(v.objectElement) and sourceDimension == getElementDimension(v.objectElement) then
        local x, y, z = getElementPosition(v.objectElement)
        local currentDistance = getDistanceBetweenPoints3D(sourcePosX, sourcePosY, sourcePosZ, x, y, z)
        if currentDistance <= 15 then
          outputChatBox("[color=sightgreen][SightMTA - Safe]: #FFFFFFAzonosító: [color=sightgreen]" .. k .. "#FFFFFF <> Csoport Azonosító: [color=sightgreen]" .. v.ownerGroup .. "#FFFFFF <> Távolság: [color=sightgreen]" .. math.floor(currentDistance) .. "#FFFFFF <> Típus: [color=sightgreen]" .. v.safeType, 255, 255, 255, true)
          findCount = findCount + 1
        end
      end
    end
    if findCount == 0 then
      outputChatBox("[color=sightred][SightMTA - Safe]: #FFFFFFA közeledben nem található egyetlen széf sem.", 255, 255, 255, true)
    end
  end
end)
