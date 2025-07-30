local sightexports = {sInteriors = false}
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
local gateObjects = {}
local streamedGates = {}
addEvent("gotGateObjects", true)
addEventHandler("gotGateObjects", getRootElement(), function(objects)
  gateObjects = objects
  for obj in pairs(gateObjects) do
    setObjectBreakable(obj, false)
    if isElementStreamedIn(obj) then
      table.insert(streamedGates, obj)
    end
  end
  triggerEvent("extraLoaderDone", localPlayer, "loadingGates")
end)
if getElementData(localPlayer, "loggedIn") then
  triggerServerEvent("requestGateObjects", localPlayer)
end
addEvent("extraLoadStart:loadingGates", false)
addEventHandler("extraLoadStart:loadingGates", getRootElement(), function()
  triggerServerEvent("requestGateObjects", localPlayer)
end)
addEventHandler("onClientElementStreamIn", getRootElement(), function()
  if gateObjects[source] then
    table.insert(streamedGates, source)
  end
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
  if gateObjects[source] then
    for i = #streamedGates, 1, -1 do
      if streamedGates[i] == source then
        table.remove(streamedGates, i)
      end
    end
  end
end)
local currentGate = false

addEventHandler("onClientRender", getRootElement(), function()
  local px, py, pz = getElementPosition(localPlayer)
  local tmp = false
  local closestDist = math.huge

  for i = 1, #streamedGates do
    local gateId = gateObjects[streamedGates[i]]
    local gateData = availableGates[gateId]
    local distLimit = gateData.customDistance or 8
    local x, y, z = unpack(gateData.closed)
    local dist = getDistanceBetweenPoints3D(x, y, z, px, py, pz)

    if dist <= distLimit and dist < closestDist then
      closestDist = dist
      tmp = gateId
    end
  end

  if tmp ~= currentGate then
    currentGate = tmp
    exports.sInteriors:setGateState(currentGate)
  end
end)
