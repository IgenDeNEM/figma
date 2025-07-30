local sightexports = {sGui = false}
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
  if sightlangStaticImageToc[0] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/nocol.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local blue = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    blue = sightexports.sGui:getColorCode("sightblue")
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderNoCol, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderNoCol)
    end
  end
end
noColState = {}
local noColNum = 0
function processNoCol(veh, state)
  local old = noColState[veh] and true or false
  if old ~= state then
    if state then
      noColState[veh] = true
      noColNum = noColNum + 1
    else
      noColState[veh] = nil
      noColNum = noColNum - 1
    end
    sightlangCondHandl0(0 < noColNum)
    if not state then
      local vehs = getElementsByType("vehicle", getRootElement(), true)
      for j = 1, #vehs do
        setElementCollidableWith(veh, vehs[j], true)
      end
      local players = getElementsByType("player", getRootElement(), true)
      for j = 1, #players do
        setElementCollidableWith(veh, players[j], true)
      end
    end
    setElementAlpha(veh, state and 125 or 255)
  end
end
addEventHandler("onClientVehicleDestroy", getRootElement(), function()
  if noColState[source] then
    noColState[source] = nil
    noColNum = noColNum - 1
    sightlangCondHandl0(0 < noColNum)
  end
end)
function resetNoColStream()
  for veh in pairs(noColState) do
    setElementCollidableWith(source, veh, true)
  end
end
addEventHandler("onClientVehicleStreamOut", getRootElement(), resetNoColStream)
addEventHandler("onClientPlayerStreamOut", getRootElement(), resetNoColStream)
addEventHandler("onClientVehicleDataChange", getRootElement(), function(data, old, new)
  if data == "vehicleNoCol" then
    if new and not noColState[source] then
      processNoCol(source, true)
    elseif not new and noColState[source] then
      processNoCol(source, false)
    end
  end
end)
local maxD = 75
function renderNoCol()
  local cx, cy, cz = getCameraMatrix()
  local vehs = getElementsByType("vehicle", getRootElement(), true)
  local players = getElementsByType("player", getRootElement(), true)
  for i = 1, #vehs do
    if noColState[vehs[i]] then
      for j = 1, #vehs do
        setElementCollidableWith(vehs[i], vehs[j], false)
      end
      for j = 1, #players do
        setElementCollidableWith(vehs[i], players[j], false)
      end
      local x, y, z = getElementPosition(vehs[i])
      z = z + 1.25
      local d = getDistanceBetweenPoints3D(x, y, z, cx, cy, cz)
      if d < maxD and isLineOfSightClear(x, y, z, cx, cy, cz, true, true, false, true, false, true, false, vehs[i]) then
        local x, y = getScreenFromWorldPosition(x, y, z, 64)
        if x and y then
          local p = d / maxD
          local sx = 64 * math.min(1, 10 / d)
          sightlangStaticImageUsed[0] = true
          if sightlangStaticImageToc[0] then
            processsightlangStaticImage[0]()
          end
          dxDrawImage(x - sx / 2, y - sx / 2, sx, sx, sightlangStaticImage[0], 0, 0, 0, tocolor(blue[1], blue[2], blue[3], 255 * (1 - p)))
        end
      end
    end
  end
end
local vehicles = getElementsByType("vehicle")
for i = 1, #vehicles do
  setElementAlpha(vehicles[i], 255)
  if getElementData(vehicles[i], "vehicleNoCol") then
    processNoCol(vehicles[i], true)
  end
end
