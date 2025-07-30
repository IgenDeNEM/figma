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
  modloaderLoaded()
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
      addEventHandler("onClientPreRender", getRootElement(), lamartTrashPreRender, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), lamartTrashPreRender)
    end
  end
end
storedTrashes = {}
local insectTrashes = {
  [1329] = true,
  [1330] = true
}
local trashEffects = {}
local objects = getElementsByType("object", getRootElement(), true)
for i = 1, #objects do
  local model = getElementModel(objects[i])
  if insectTrashes[model] then
    local x, y, z = getElementPosition(objects[i])
    trashEffects[objects[i]] = createEffect("insects", x, y, z + 1)
    setEffectDensity(trashEffects[objects[i]], 2)
    setElementInterior(trashEffects[objects[i]], getElementInterior(objects[i]))
    setElementDimension(trashEffects[objects[i]], getElementDimension(objects[i]))
    if getElementDimension(objects[i]) ~= -1 then
      setElementInterior(trashEffects[objects[i]], getElementInterior(objects[i]))
      setElementDimension(trashEffects[objects[i]], getElementDimension(objects[i]))
    else
      setElementInterior(trashEffects[objects[i]], getElementInterior(localPlayer))
      setElementDimension(trashEffects[objects[i]], getElementDimension(localPlayer))
    end
  end
end
addEventHandler("onClientObjectStreamIn", getRootElement(), function()
  if insectTrashes[getElementModel(source)] then
    local x, y, z = getElementPosition(source)
    trashEffects[source] = createEffect("insects", x, y, z + 1)
    setEffectDensity(trashEffects[source], 2)
    if getElementDimension(source) ~= -1 then
      setElementInterior(trashEffects[source], getElementInterior(source))
      setElementDimension(trashEffects[source], getElementDimension(source))
    else
      setElementInterior(trashEffects[source], getElementInterior(localPlayer))
      setElementDimension(trashEffects[source], getElementDimension(localPlayer))
    end
  end
end)
local streamedInLamart = {}
local lamartData = {}
local lamartSound = {}
function destroyedInsectObject()
  streamedInLamart[source] = nil
  if isElement(trashEffects[source]) then
    destroyElement(trashEffects[source])
  end
  trashEffects[source] = nil
  if isElement(lamartSound[source]) then
    destroyElement(lamartSound[source])
  end
  lamartSound[source] = nil
end
addEventHandler("onClientObjectStreamOut", getRootElement(), destroyedInsectObject)
addEventHandler("onClientObjectDestroy", getRootElement(), destroyedInsectObject)
function destroyLamart()
  if lamartData[source] then
    if isElement(lamartData[source][1]) then
      destroyElement(lamartData[source][1])
    end
    lamartData[source][1] = nil
    if isElement(lamartData[source][2]) then
      destroyElement(lamartData[source][2])
    end
    lamartData[source][2] = nil
  end
  lamartData[source] = nil
end
local lidModel = false
local loadTrashes = getElementData(localPlayer, "loggedIn")
addEvent("extraLoadStart:loadingTrashes", false)
addEventHandler("extraLoadStart:loadingTrashes", getRootElement(), function()
  if lidModel then
    triggerServerEvent("requestTrashes", localPlayer)
  else
    loadTrashes = true
  end
end)
function modloaderLoaded()
  lidModel = sightexports.sModloader:getModelId("v4_trashcan7_lid")
  if loadTrashes then
    triggerServerEvent("requestTrashes", localPlayer)
    loadTrashes = false
  end
end
function lamartTrashPreRender(delta)
  local canEnd = true
  for obj, dat in pairs(lamartData) do
    local els = getElementsWithinColShape(dat[2], "player")
    local state = 1 <= #els
    if state ~= dat[5] then
      local x, y, z = getElementPosition(obj)
      local int = getElementInterior(obj)
      local dim = getElementDimension(obj)
      if isElement(lamartSound[obj]) then
        destroyElement(lamartSound[obj])
      end
      lamartSound[obj] = nil
      lamartSound[obj] = playSound3D("files/lamart.mp3", x, y, z)
      setElementInterior(lamartSound[obj], int)
      setElementDimension(lamartSound[obj], dim)
      if state then
        setSoundPosition(lamartSound[obj], dat[3] * 0.75)
      else
        setSoundPosition(lamartSound[obj], (1 - dat[3]) * 0.75)
      end
      dat[5] = state
      if isElement(trashEffects[obj]) then
        destroyElement(trashEffects[obj])
      end
      trashEffects[obj] = nil
      if state then
        trashEffects[obj] = createEffect("insects", x, y, z + 1)
        setEffectDensity(trashEffects[obj], 2)
        setElementInterior(trashEffects[obj], int)
        setElementDimension(trashEffects[obj], dim)
      end
    end
    if state then
      dat[3] = dat[3] + 1 * delta / 750
      if 1 < dat[3] then
        dat[3] = 1
      end
    else
      dat[3] = dat[3] - 1 * delta / 750
      if dat[3] < 0 then
        dat[3] = 0
      end
    end
    local p = dat[3]
    if 0 < p and p < 1 then
      p = getEasingValue(p, "InOutQuad")
    end
    setElementRotation(dat[1], -p * 80, 0, dat[4] + 180)
    canEnd = false
  end
  if canEnd then
    sightlangCondHandl0(false)
  end
end
function lamartTrashStreamIn()
  streamedInLamart[source] = true
  sightlangCondHandl0(true)
end
addEvent("recieveTrashes", true)
addEventHandler("recieveTrashes", getRootElement(), function(trashData)
  if trashData and type(trashData) == "table" then
    storedTrashes = trashData
    for id, dat in pairs(trashData) do
      if dat.lamart then
        addEventHandler("onClientElementDestroy", dat.objectElement, destroyLamart)
        addEventHandler("onClientElementStreamIn", dat.objectElement, lamartTrashStreamIn)
        if isElementStreamedIn(dat.objectElement) then
          streamedInLamart[dat.objectElement] = true
          sightlangCondHandl0(true)
        end
        local rad = math.rad(dat.rotZ)
        local cos = math.cos(rad)
        local sin = math.sin(rad)
        local x = dat.posX + 0.1527 * sin
        local y = dat.posY - 0.1527 * cos
        local z = dat.posZ + 1.0504
        local lid = createObject(lidModel, x, y, z, 0, 0, dat.rotZ + 180)
        setElementInterior(lid, dat.interior)
        setElementDimension(lid, dat.dimension)
        local col = createColSphere(x, y, z, 2)
        lamartData[dat.objectElement] = {
          lid,
          col,
          0,
          dat.rotZ,
          false
        }
        setElementInterior(col, dat.interior)
        setElementDimension(col, dat.dimension)
      end
    end
  end
  setTimer(triggerEvent, 250, 1, "extraLoaderDone", localPlayer, "loadingTrashes")
end)
addEvent("createTrash", true)
addEventHandler("createTrash", getRootElement(), function(databaseId, trashData)
  if databaseId then
    databaseId = tonumber(databaseId)
    if trashData and type(trashData) == "table" then
      storedTrashes[databaseId] = trashData
      if trashData.lamart then
        addEventHandler("onClientElementDestroy", trashData.objectElement, destroyLamart)
        addEventHandler("onClientElementStreamIn", trashData.objectElement, lamartTrashStreamIn)
        if isElementStreamedIn(trashData.objectElement) then
          streamedInLamart[trashData.objectElement] = true
          sightlangCondHandl0(true)
        end
        local rad = math.rad(trashData.rotZ)
        local cos = math.cos(rad)
        local sin = math.sin(rad)
        local x = trashData.posX + 0.1527 * sin
        local y = trashData.posY - 0.1527 * cos
        local z = trashData.posZ + 1.0504
        local lid = createObject(lidModel, x, y, z, 0, 0, trashData.rotZ + 180)
        setElementInterior(lid, trashData.interior)
        setElementDimension(lid, trashData.dimension)
        local col = createColSphere(x, y, z, 1.5)
        lamartData[trashData.objectElement] = {
          lid,
          col,
          0,
          trashData.rotZ,
          false
        }
        setElementInterior(col, dat.interior)
        setElementDimension(col, dat.dimension)
      end
    end
  end
end)
addEvent("destroyTrash", true)
addEventHandler("destroyTrash", getRootElement(), function(databaseId)
  if databaseId then
    databaseId = tonumber(databaseId)
    if storedTrashes[databaseId] then
      if lamartData[storedTrashes[databaseId].objectElement] then
        destroyElement(lamartData[storedTrashes[databaseId].objectElement][1])
        lamartData[storedTrashes[databaseId].objectElement] = nil
      end
      storedTrashes[databaseId] = nil
    end
  end
end)
addCommandHandler("nearbytrashes", function()
  if sightexports.sPermission:hasPermission(localPlayer, "nearbytrashes") then
    local sourcePosX, sourcePosY, sourcePosZ = getElementPosition(localPlayer)
    local sourceInterior = getElementInterior(localPlayer)
    local sourceDimension = getElementDimension(localPlayer)
    local findCount = 0
    outputChatBox("[color=sightgreen][SightMTA]:[color=hudwhite] Közeledben lévő szemetesek:", 255, 255, 255, true)
    for k, v in pairs(storedTrashes) do
      if sourceInterior == v.interior and sourceDimension == v.dimension then
        local currentDistance = getDistanceBetweenPoints3D(sourcePosX, sourcePosY, sourcePosZ, v.posX, v.posY, v.posZ)
        if currentDistance <= 15 then
          outputChatBox("[color=sightgreen][SightMTA]:[color=hudwhite] Azonosító: [color=sightgreen]" .. v.trashId .. "#FFFFFF <> Távolság: [color=sightgreen]" .. math.floor(currentDistance), 255, 255, 255, true)
          findCount = findCount + 1
        end
      end
    end
    if findCount == 0 then
      outputChatBox("[color=sightred][SightMTA]:[color=hudwhite] A közeledben nem található egyetlen szemetes sem.", 255, 255, 255, true)
    end
  end
end)
