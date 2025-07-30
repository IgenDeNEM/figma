local sightexports = {sModloader = false}
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
  loadModelIds()
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
      addEventHandler("onClientRender", getRootElement(), waitAndTry, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), waitAndTry)
    end
  end
end
local objectModels = {}
local neonElements = {}
function destroyNeon(veh)
  if neonElements[veh] then
    for k in pairs(neonElements[veh]) do
      if isElement(neonElements[veh][k]) then
        destroyElement(neonElements[veh][k])
      end
    end
    neonElements[veh] = nil
  end
end
local waitingFor = {}
function waitAndTry()
  for i = #waitingFor, 1, -1 do
    local veh, p, s, f = waitingFor[i][1], waitingFor[i][2], waitingFor[i][3], waitingFor[i][4]
    if not isElement(veh) then
      table.remove(waitingFor, i)
    elseif veh and isElementStreamedIn(veh) then
      table.remove(waitingFor, i)
      initNeon(veh, p, s, f)
    end
  end
  if #waitingFor <= 0 then
    sightlangCondHandl0(false)
  end
end
function initNeon(veh, p, s, f)
  local side = s
  local front = f
  if not p then
    side = getElementData(veh, "neonSide")
    front = getElementData(veh, "neonFront")
  end
  if side or front then
    local int = getElementInterior(veh)
    local dim = getElementDimension(veh)
    if not neonElements[veh] then
      neonElements[veh] = {}
    end
    local x, y, z, x1, y1, z1 = getElementBoundingBox(veh)
    if not x then
      table.insert(waitingFor, {
        veh,
        p,
        s,
        f
      })
      sightlangCondHandl0(true)
      return false
    end
    if side then
      local x = (math.abs(x) + math.abs(x1)) / 2 - 0.4
      if isElement(neonElements[veh].side1) then
        setElementModel(neonElements[veh].side1, objectModels["neon_" .. side] or objectModels.neon_white)
        setElementDimension(neonElements[veh].side1, dim)
        setElementInterior(neonElements[veh].side1, int)
        attachElements(neonElements[veh].side1, veh, x, 0, z * 0.5)
      else
        local neon = createObject(objectModels["neon_" .. side] or objectModels.neon_white, 0, 0, 0)
        setElementDimension(neon, dim)
        setElementInterior(neon, int)
        attachElements(neon, veh, x, 0, z * 0.5)
        setObjectScale(neon, 0)
        setElementCollisionsEnabled(neon, false)
        neonElements[veh].side1 = neon
      end
      if isElement(neonElements[veh].side2) then
        setElementModel(neonElements[veh].side2, objectModels["neon_" .. side] or objectModels.neon_white)
        setElementDimension(neonElements[veh].side2, dim)
        setElementInterior(neonElements[veh].side2, int)
        attachElements(neonElements[veh].side2, veh, -x, 0, z * 0.5)
      else
        local neon = createObject(objectModels["neon_" .. side] or objectModels.neon_white, 0, 0, 0)
        setElementDimension(neon, dim)
        setElementInterior(neon, int)
        attachElements(neon, veh, -x, 0, z * 0.5)
        setObjectScale(neon, 0)
        setElementCollisionsEnabled(neon, false)
        neonElements[veh].side2 = neon
      end
    else
      if isElement(neonElements[veh].side1) then
        destroyElement(neonElements[veh].side1)
      end
      neonElements[veh].side1 = nil
      if isElement(neonElements[veh].side2) then
        destroyElement(neonElements[veh].side2)
      end
      neonElements[veh].side2 = nil
    end
    if front then
      local y = (math.abs(y) + math.abs(y1)) / 2 - 0.4
      if isElement(neonElements[veh].front1) then
        setElementModel(neonElements[veh].front1, objectModels["neon_" .. front .. "_lil"] or objectModels.neon_white_lil)
        setElementDimension(neonElements[veh].front1, dim)
        setElementInterior(neonElements[veh].front1, int)
        attachElements(neonElements[veh].front1, veh, 0, y, z * 0.5, 0, 0, 90)
      else
        local neon = createObject(objectModels["neon_" .. front .. "_lil"] or objectModels.neon_white_lil, 0, 0, 0)
        setElementDimension(neon, dim)
        setElementInterior(neon, int)
        attachElements(neon, veh, 0, y, z * 0.5, 0, 0, 90)
        setObjectScale(neon, 0)
        setElementCollisionsEnabled(neon, false)
        neonElements[veh].front1 = neon
      end
      if isElement(neonElements[veh].front2) then
        setElementModel(neonElements[veh].front2, objectModels["neon_" .. front .. "_lil"] or objectModels.neon_white_lil)
        setElementDimension(neonElements[veh].front2, dim)
        setElementInterior(neonElements[veh].front2, int)
        attachElements(neonElements[veh].front2, veh, 0, -y, z * 0.5, 0, 0, 90)
      else
        local neon = createObject(objectModels["neon_" .. front .. "_lil"] or objectModels.neon_white_lil, 0, 0, 0)
        setElementDimension(neon, dim)
        setElementInterior(neon, int)
        attachElements(neon, veh, 0, -y, z * 0.5, 0, 0, 90)
        setObjectScale(neon, 0)
        setElementCollisionsEnabled(neon, false)
        neonElements[veh].front2 = neon
      end
    else
      if isElement(neonElements[veh].front1) then
        destroyElement(neonElements[veh].front1)
      end
      neonElements[veh].front1 = nil
      if isElement(neonElements[veh].front2) then
        destroyElement(neonElements[veh].front2)
      end
      neonElements[veh].front2 = nil
    end
  else
    destroyNeon(veh)
  end
end
function removeNeonHandler()
  destroyNeon(source)
end
addEventHandler("onClientElementDestroy", getRootElement(), removeNeonHandler)
addEventHandler("onClientElementStreamOut", getRootElement(), removeNeonHandler)
addEventHandler("onClientElementDimensionChange", getRootElement(), function(old, new)
  if neonElements[source] then
    for k in pairs(neonElements[source]) do
      if isElement(neonElements[source][k]) then
        setElementDimension(neonElements[source][k], new)
      end
    end
  end
end)
addEventHandler("onClientElementInteriorChange", getRootElement(), function(old, new)
  if neonElements[source] then
    for k in pairs(neonElements[source]) do
      if isElement(neonElements[source][k]) then
        setElementInterior(neonElements[source][k], new)
      end
    end
  end
end)
addEventHandler("onClientElementDataChange", getRootElement(), function(data)
  if (data == "neonSide" or data == "neonFront") and isElementStreamedIn(source) then
    initNeon(source)
  end
end)
function loadModelIds()
  objectModels = {
    neon_white = sightexports.sModloader:getModelId("neon_white"),
    neon_blue = sightexports.sModloader:getModelId("neon_blue"),
    neon_red = sightexports.sModloader:getModelId("neon_red"),
    neon_orange = sightexports.sModloader:getModelId("neon_orange"),
    neon_green = sightexports.sModloader:getModelId("neon_green"),
    neon_yellow = sightexports.sModloader:getModelId("neon_yellow"),
    neon_pink = sightexports.sModloader:getModelId("neon_pink"),
    neon_purple = sightexports.sModloader:getModelId("neon_purple"),
    neon_lightblue = sightexports.sModloader:getModelId("neon_lightblue"),
    neon_white_lil = sightexports.sModloader:getModelId("neon_white_lil"),
    neon_blue_lil = sightexports.sModloader:getModelId("neon_blue_lil"),
    neon_red_lil = sightexports.sModloader:getModelId("neon_red_lil"),
    neon_orange_lil = sightexports.sModloader:getModelId("neon_orange_lil"),
    neon_green_lil = sightexports.sModloader:getModelId("neon_green_lil"),
    neon_yellow_lil = sightexports.sModloader:getModelId("neon_yellow_lil"),
    neon_pink_lil = sightexports.sModloader:getModelId("neon_pink_lil"),
    neon_purple_lil = sightexports.sModloader:getModelId("neon_purple_lil"),
    neon_lightblue_lil = sightexports.sModloader:getModelId("neon_lightblue_lil")
  }
  local vehs = getElementsByType("vehicle", getRootElement(), true)
  for i = 1, #vehs do
    initNeon(vehs[i])
  end
end
addEventHandler("onClientElementStreamIn", getRootElement(), function()
  if getElementType(source) == "vehicle" and (getElementData(source, "neonSide") or getElementData(source, "neonFront")) then
    initNeon(source)
  end
end)
