local sightexports = {
  sGroups = false,
  sGui = false,
  sMarkers = false,
  sItems = false,
  sPermission = false,
  lv_hud = false,
  sControls = false,
  sGarages = false
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
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), fadeInteriorRender, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), fadeInteriorRender)
    end
  end
end
screenX, screenY = guiGetScreenSize()
local currentInteriorMarkerType = false
local currentInteriorId = false
local interiorEnterGui = false
local markersToLoad = false
local interiorMarked = false
local interiorMarkBlip = false
function refreshPlayerInteriors()
  local num = 0
  local rentable = 0
  local list = {}
  local charId = getElementData(localPlayer, "char.ID")
  if charId then
    for id, data in pairs(interiorList) do
      if data.ownerType == "player" and data.owner == charId then
        data.interiorId = id
        table.insert(list, data)
        if data.type == "rentable" then
          rentable = rentable + 1
        else
          num = num + 1
        end
      end
    end
  end
  triggerEvent("refreshPlayerInteriors", localPlayer, num, list, rentable)
end
addEvent("requestPlayerInteriors", true)
addEventHandler("requestPlayerInteriors", getRootElement(), refreshPlayerInteriors)
local oldMarkId = false
function markInteriorOnMap(id)
  if interiorList[id] and (interiorList[id].ownerType == "player" and interiorList[id].owner == getElementData(localPlayer, "char.ID") or sightexports.sGroups:getPlayerPermission("mdc")) then
    if isElement(interiorMarkBlip) then
      destroyElement(interiorMarkBlip)
    end
    if oldMarkId == id then
      oldMarkId = false
      return
    end
    oldMarkId = id
    local x, y, z = getInteriorOutsidePosition(id)
    local col = sightexports.sGui:getColorCode(getMarkerColor(id))
    interiorMarkBlip = createBlip(x, y, z, 3, 2, col[1], col[2], col[3])
    interiorMarked = id
    sightexports.sGui:showInfobox("s", "Az interior megjelölésre került a térképen! (Ház ikon)")
  end
end
function loadMarkerFor(i)
  if interiorList[i] then
    local col = getMarkerColor(i)
    local icon = getMarkerIcon(i)
    local text, textCols = getMarkerText(i, col)
    local size = 0.75
    if interiorList[i].type == "garage" or interiorList[i].type == "garage2" then
      size = 1.5
    end
    if not interiorList[i].outsideMarkerId then
      local x, y, z, int, dim = getInteriorOutsidePosition(i)
      if x then
        interiorList[i].outsideMarkerId = sightexports.sMarkers:createCustomMarker(x, y, z, int, dim, col, icon, text, textCols)
        sightexports.sMarkers:setCustomMarkerInterior(interiorList[i].outsideMarkerId, "outside", i, size)
        local locker = interiorList[i].policeLock and interiorList[i].policeLockBy and interiorList[i].policeLockGroup and interiorList[i].policeLockBy .. " (" .. interiorList[i].policeLockGroup .. ")" or ""
        sightexports.sMarkers:setCustomMarkerPolice(interiorList[i].outsideMarkerId, interiorList[i].policeLock, locker)
      end
    end
    if not interiorList[i].insideMarkerId then
      local x, y, z, int, dim = getInteriorInsidePosition(i)
      if x then
        interiorList[i].insideMarkerId = sightexports.sMarkers:createCustomMarker(x, y, z, int, dim, col, icon, text, textCols)
        sightexports.sMarkers:setCustomMarkerInterior(interiorList[i].insideMarkerId, "inside", i, size)
        local locker = interiorList[i].policeLock and interiorList[i].policeLockBy and interiorList[i].policeLockGroup and interiorList[i].policeLockBy .. " (" .. interiorList[i].policeLockGroup .. ")" or ""
        sightexports.sMarkers:setCustomMarkerPolice(interiorList[i].insideMarkerId, interiorList[i].policeLock, locker)
      end
    end
  end
end

function getInteriorCustomID(i)
  if interiorList[i] and interiorList[i].outsideMarkerId then
    return interiorList[i].outsideMarkerId
  end
end

addEvent("syncWholeInterior", true)
addEventHandler("syncWholeInterior", getRootElement(), function(id, data)
  if interiorList[id] then
    if interiorList[id].outsideMarkerId then
      sightexports.sMarkers:deleteCustomMarker(interiorList[id].outsideMarkerId)
    end
    if interiorList[id].insideMarkerId then
      sightexports.sMarkers:deleteCustomMarker(interiorList[id].insideMarkerId)
    end
  end
  interiorList[id] = data
  if interiorMarked == id then
    if isElement(interiorMarkBlip) then
      destroyElement(interiorMarkBlip)
    end
    interiorMarkBlip = false
    interiorMarked = false
  end
  loadMarkerFor(id)
  if interiorList[id] and interiorList[id].ownerType == "player" and interiorList[id].owner == getElementData(localPlayer, "char.ID") then
    refreshPlayerInteriors()
  end
end)
addEvent("syncInteriorData", true)
addEventHandler("syncInteriorData", getRootElement(), function(id, dat)
  if not interiorList[id] then
    return
  end
  local wasOwner = false
  local wasOwnerType = false
  for data in pairs(dat) do
    if data == "owner" or data == "ownerType" then
      wasOwner = interiorList[id].owner
      wasOwnerType = interiorList[id].ownerType
      break
    end
  end
  local refreshMarkerColorIcon = false
  local refreshMarkerText = false
  local refreshMarkerPolice = false
  local refreshMarkerOutside = false
  local refreshMarkerInside = false
  for data, value in pairs(dat) do
    interiorList[id][data] = value
    if data == "type" or data == "owner" or data == "price" then
      refreshMarkerColorIcon = true
    end
    if data == "name" or data == "type" or data == "owner" or data == "price" then
      refreshMarkerText = true
    end
    if data == "policeLock" or data == "policeLockBy" or data == "policeLockGroup" then
      refreshMarkerPolice = true
    end
    if data == "outside" then
      refreshMarkerOutside = true
    end
    if data == "inside" then
      refreshMarkerInside = true
    end
  end
  if refreshMarkerColorIcon then
    local col = getMarkerColor(id)
    if interiorList[id].outsideMarkerId then
      sightexports.sMarkers:setCustomMarkerColor(interiorList[id].outsideMarkerId, col)
    end
    if interiorList[id].insideMarkerId then
      sightexports.sMarkers:setCustomMarkerColor(interiorList[id].insideMarkerId, col)
    end
    local icon = getMarkerIcon(id)
    if interiorList[id].outsideMarkerId then
      sightexports.sMarkers:setCustomMarkerType(interiorList[id].outsideMarkerId, icon)
    end
    if interiorList[id].insideMarkerId then
      sightexports.sMarkers:setCustomMarkerType(interiorList[id].insideMarkerId, icon)
    end
  end
  if refreshMarkerText then
    local text, textCols = getMarkerText(id)
    if interiorList[id].outsideMarkerId then
      sightexports.sMarkers:setCustomMarkerText(interiorList[id].outsideMarkerId, text, textCols)
    end
    if interiorList[id].insideMarkerId then
      sightexports.sMarkers:setCustomMarkerText(interiorList[id].insideMarkerId, text, textCols)
    end
  end
  if refreshMarkerPolice then
    if interiorList[id].outsideMarkerId then
      local locker = interiorList[id].policeLock and interiorList[id].policeLockGroup and interiorList[id].policeLockBy and (interiorList[id].policeLockBy .. " (" .. interiorList[id].policeLockGroup) .. ")"
      sightexports.sMarkers:setCustomMarkerPolice(interiorList[id].outsideMarkerId, interiorList[id].policeLock, locker)
    end
    if interiorList[id].insideMarkerId then
      local locker = interiorList[id].policeLock and interiorList[id].policeLockGroup and interiorList[id].policeLockBy and (interiorList[id].policeLockBy .. " (" .. interiorList[id].policeLockGroup) .. ")"
      sightexports.sMarkers:setCustomMarkerPolice(interiorList[id].insideMarkerId, interiorList[id].policeLock, locker)
    end
  end
  if refreshMarkerOutside then
    local x, y, z, int, dim = getInteriorOutsidePosition(id)
    if interiorList[id].outsideMarkerId then
      sightexports.sMarkers:setCustomMarkerPosition(interiorList[id].outsideMarkerId, x, y, z, int, dim)
    end
    if interiorMarked == id and isElement(interiorMarkBlip) then
      setElementPosition(interiorMarkBlip, x, y, z)
    end
  end
  if refreshMarkerInside and interiorList[id].insideMarkerId then
    local x, y, z, int, dim = getInteriorInsidePosition(id)
    sightexports.sMarkers:setCustomMarkerPosition(interiorList[id].insideMarkerId, x, y, z, int, dim)
  end
  if currentInteriorId == id then
    refreshInteriorBottomGUI()
  end
  local charId = getElementData(localPlayer, "char.ID")
  if charId and (interiorList[id] and interiorList[id].ownerType == "player" and interiorList[id].owner == charId or wasOwnerType == "player" and wasOwner == charId) then
    refreshPlayerInteriors()
  end
end)
addEvent("gotInteriorList", true)
addEventHandler("gotInteriorList", getRootElement(), function(list)
  for i, v in pairs(interiorList) do
    if v.outsideMarkerId then
      sightexports.sMarkers:deleteCustomMarker(v.outsideMarkerId)
    end
    if v.insideMarkerId then
      sightexports.sMarkers:deleteCustomMarker(v.insideMarkerId)
    end
  end
  for k, v in pairs(list) do
    if v.policeLock == "N" then
      v.policeLock = false
    end
  end
  interiorList = list
  if not markersToLoad then
    addEventHandler("onClientPreRender", getRootElement(), loadMarkers)
  end
  markersToLoad = {}
  for i in pairs(interiorList) do
    if not interiorList[i].outsideMarkerId or not interiorList[i].insideMarkerId then
      if interiorList[i].intiType ~= "mine" and interiorList[i].intiType ~= "otherRentable" and interiorList[i].intiType ~= "workshop" then
        table.insert(markersToLoad, i)
      end
    end
  end
  refreshPlayerInteriors()
  setTimer(triggerEvent, 500, 1, "extraLoaderDone", localPlayer, "loadingInteriors")
end)
function loadMarkers()
  local res = getResourceFromName("sMarkers")
  if res and getResourceState(res) == "running" then
    local c = 0
    for i = 1, 50 do
      if markersToLoad[#markersToLoad] then
        loadMarkerFor(markersToLoad[#markersToLoad])
        table.remove(markersToLoad, #markersToLoad)
      end
    end
  end
  if #markersToLoad <= 0 then
    removeEventHandler("onClientPreRender", getRootElement(), loadMarkers)
    markersToLoad = false
  end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  if getElementData(localPlayer, "loggedIn") then
    triggerServerEvent("requestInteriors", localPlayer)
  end
end)
addEvent("extraLoadStart:loadingInteriors", false)
addEventHandler("extraLoadStart:loadingInteriors", getRootElement(), function()
  triggerServerEvent("requestInteriors", localPlayer)
end)
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  for i, v in pairs(interiorList) do
    if v.outsideMarkerId then
      sightexports.sMarkers:deleteCustomMarker(v.outsideMarkerId)
    end
    if v.insideMarkerId then
      sightexports.sMarkers:deleteCustomMarker(v.insideMarkerId)
    end
  end
end)
addEvent("playInteriorRam", true)
addEventHandler("playInteriorRam", getRootElement(), function(id)
  if interiorList[id] then
    local px, py, pz = getElementPosition(localPlayer)
    local int = getElementInterior(localPlayer)
    local dim = getElementDimension(localPlayer)
    local x, y, z, i, d = getInteriorOutsidePosition(id)
    if i == int and d == dim and getDistanceBetweenPoints3D(px, py, pz, x, y, z) < knockOutsideDistance * 3 then
      local sound = playSound3D("files/ram.mp3", x, y, z)
      setElementInterior(sound, i)
      setElementDimension(sound, d)
      setSoundMaxDistance(sound, knockOutsideDistance)
    end
    local x, y, z, i, d = getInteriorInsidePosition(id)
    if i == int and d == dim and getDistanceBetweenPoints3D(px, py, pz, x, y, z) < knockInsideDistance * 3 then
      local sound = playSound3D("files/ram.mp3", x, y, z)
      setElementInterior(sound, i)
      setElementDimension(sound, d)
      setSoundMaxDistance(sound, knockInsideDistance)
    end
  end
end)
addEvent("playInteriorKnock", true)
addEventHandler("playInteriorKnock", getRootElement(), function(id)
  if interiorList[id] then
    local px, py, pz = getElementPosition(localPlayer)
    local int = getElementInterior(localPlayer)
    local dim = getElementDimension(localPlayer)
    local x, y, z, i, d = getInteriorOutsidePosition(id)
    if i == int and d == dim and getDistanceBetweenPoints3D(px, py, pz, x, y, z) < knockOutsideDistance * 3 then
      local sound = playSound3D("files/knock.mp3", x, y, z)
      setElementInterior(sound, i)
      setElementDimension(sound, d)
      setSoundMaxDistance(sound, knockOutsideDistance)
    end
    local x, y, z, i, d = getInteriorInsidePosition(id)
    if i == int and d == dim and getDistanceBetweenPoints3D(px, py, pz, x, y, z) < knockInsideDistance * 3 then
      local sound = playSound3D("files/knock.mp3", x, y, z)
      setElementInterior(sound, i)
      setElementDimension(sound, d)
      setSoundMaxDistance(sound, knockInsideDistance)
    end
  end
end)
addEvent("playInteriorRing", true)
addEventHandler("playInteriorRing", getRootElement(), function(id)
  if interiorList[id] then
    local px, py, pz = getElementPosition(localPlayer)
    local int = getElementInterior(localPlayer)
    local dim = getElementDimension(localPlayer)
    local x, y, z, i, d = getInteriorOutsidePosition(id)
    if i == int and d == dim and getDistanceBetweenPoints3D(px, py, pz, x, y, z) < ringOutsideDistance * 3 then
      local sound = playSound3D("files/bell.mp3", x, y, z)
      setElementInterior(sound, i)
      setElementDimension(sound, d)
      setSoundMaxDistance(sound, ringOutsideDistance)
    end
    local x, y, z, i, d = getInteriorInsidePosition(id)
    if i == int and d == dim and getDistanceBetweenPoints3D(px, py, pz, x, y, z) < ringInsideDistance * 3 then
      local sound = playSound3D("files/bell.mp3", x, y, z)
      setElementInterior(sound, i)
      setElementDimension(sound, d)
      setSoundMaxDistance(sound, ringInsideDistance)
    end
  end
end)
addEvent("playInteriorLocked", true)
addEventHandler("playInteriorLocked", getRootElement(), function(id)
  if interiorList[id] then
    local px, py, pz = getElementPosition(localPlayer)
    local int = getElementInterior(localPlayer)
    local dim = getElementDimension(localPlayer)
    local x, y, z, i, d = getInteriorOutsidePosition(id)
    if i == int and d == dim and getDistanceBetweenPoints3D(px, py, pz, x, y, z) < lockSoundDistance * 3 then
      local sound = playSound3D("files/locked.mp3", x, y, z)
      setElementInterior(sound, i)
      setElementDimension(sound, d)
      setSoundMaxDistance(sound, lockSoundDistance)
    end
    local x, y, z, i, d = getInteriorInsidePosition(id)
    if i == int and d == dim and getDistanceBetweenPoints3D(px, py, pz, x, y, z) < lockSoundDistance * 3 then
      local sound = playSound3D("files/locked.mp3", x, y, z)
      setElementInterior(sound, i)
      setElementDimension(sound, d)
      setSoundMaxDistance(sound, lockSoundDistance)
    end
  end
end)
addEvent("playInteriorLockUnlock", true)
addEventHandler("playInteriorLockUnlock", getRootElement(), function(id)
  if interiorList[id] then
    local px, py, pz = getElementPosition(localPlayer)
    local int = getElementInterior(localPlayer)
    local dim = getElementDimension(localPlayer)
    local x, y, z, i, d = getInteriorOutsidePosition(id)
    if i == int and d == dim and getDistanceBetweenPoints3D(px, py, pz, x, y, z) < lockSoundDistance * 3 then
      local sound = playSound3D("files/lockunlock.mp3", x, y, z)
      setElementInterior(sound, i)
      setElementDimension(sound, d)
      setSoundMaxDistance(sound, lockSoundDistance)
    end
    local x, y, z, i, d = getInteriorInsidePosition(id)
    if i == int and d == dim and getDistanceBetweenPoints3D(px, py, pz, x, y, z) < lockSoundDistance * 3 then
      local sound = playSound3D("files/lockunlock.mp3", x, y, z)
      setElementInterior(sound, i)
      setElementDimension(sound, d)
      setSoundMaxDistance(sound, lockSoundDistance)
    end
  end
end)
addEvent("knockOnInterior", false)
addEventHandler("knockOnInterior", getRootElement(), function()
  if currentInteriorId and interiorList[currentInteriorId] and getTickCount() > (interiorList[currentInteriorId].nextKnock or 0) then
    interiorList[currentInteriorId].nextKnock = getTickCount() + 2000
    triggerServerEvent("knockOnInterior", localPlayer, currentInteriorId)
  end
end)
addEvent("ringBellOnInterior", false)
addEventHandler("ringBellOnInterior", getRootElement(), function()
  if currentInteriorId and interiorList[currentInteriorId] and getTickCount() > (interiorList[currentInteriorId].nextKnock or 0) then
    interiorList[currentInteriorId].nextKnock = getTickCount() + 750
    triggerServerEvent("ringBellOnInterior", localPlayer, currentInteriorId)
  end
end)
addEvent("lockUnlockInterior", false)
addEventHandler("lockUnlockInterior", getRootElement(), function()
  if currentInteriorId and interiorList[currentInteriorId] and getTickCount() > (interiorList[currentInteriorId].nextLock or 0) then
    interiorList[currentInteriorId].nextLock = getTickCount() + 1000
    triggerServerEvent("lockUnlockInterior", localPlayer, currentInteriorMarkerType, currentInteriorId)
  end
end)
local interiorBuyWindow = false
addEvent("deleteInteriorBuyPanel", false)
addEventHandler("deleteInteriorBuyPanel", getRootElement(), function()
  if interiorBuyWindow then
    sightexports.sGui:deleteGuiElement(interiorBuyWindow)
  end
  interiorBuyWindow = false
end)
addEvent("tryToBuyInterior", false)
addEventHandler("tryToBuyInterior", getRootElement(), function()
  if interiorBuyWindow then
    sightexports.sGui:deleteGuiElement(interiorBuyWindow)
  end
  interiorBuyWindow = false
  if currentInteriorMarkerType and interiorList[currentInteriorId] then
    if not interiorList[currentInteriorId].owner and interiorList[currentInteriorId].price and ownableInteriorTypes[interiorList[currentInteriorId].type] then
      triggerServerEvent("tryToBuyInterior", localPlayer, currentInteriorMarkerType, currentInteriorId)
    elseif interiorList[currentInteriorId].type == "rentable" then
      local charId = getElementData(localPlayer, "char.ID")
      if interiorList[currentInteriorId].ownerType == "player" and interiorList[currentInteriorId].owner == charId then
        triggerServerEvent("tryToBuyInterior", localPlayer, currentInteriorMarkerType, currentInteriorId)
      end
    end
  end
end)
addEvent("tryToUnrentInterior", false)
addEventHandler("tryToUnrentInterior", getRootElement(), function()
  if interiorBuyWindow then
    sightexports.sGui:deleteGuiElement(interiorBuyWindow)
  end
  interiorBuyWindow = false
  if currentInteriorMarkerType and interiorList[currentInteriorId] and interiorList[currentInteriorId].type == "rentable" then
    local charId = getElementData(localPlayer, "char.ID")
    if interiorList[currentInteriorId].ownerType == "player" and interiorList[currentInteriorId].owner == charId then
      triggerServerEvent("tryToUnrentInterior", localPlayer, currentInteriorMarkerType, currentInteriorId)
    end
  end
end)
function openInteriorBuyPanel()
  if interiorBuyWindow then
    sightexports.sGui:deleteGuiElement(interiorBuyWindow)
  end
  interiorBuyWindow = false
  local theType = currentInteriorMarkerType
  local id = currentInteriorId
  if theType and interiorList[id] and not interiorList[id].owner and interiorList[id].price and ownableInteriorTypes[interiorList[id].type] then
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local name = "[" .. id .. "] " .. interiorList[id].name
    local priceText = false
    local priceText2 = false
    local priceText3 = false
    local priceW = 0
    local ph = titleBarHeight + 8 + 128 + 24
    if interiorList[id].type == "rentable" then
      priceText = "Bérleti díj: " .. sightexports.sGui:thousandsStepper(interiorList[id].price) .. " $ / hét"
      priceText2 = "Kaució: " .. sightexports.sGui:thousandsStepper(interiorList[id].price * 4) .. " $"
      priceText3 = "Fizetendő: " .. sightexports.sGui:thousandsStepper(interiorList[id].price * 5) .. " $"
      priceW = math.max(sightexports.sGui:getTextWidthFont(priceText, "15/BebasNeueRegular.otf"), sightexports.sGui:getTextWidthFont(priceText2, "15/BebasNeueRegular.otf"))
      priceW = math.max(priceW, sightexports.sGui:getTextWidthFont(priceText3, "15/BebasNeueBold.otf"))
      ph = ph + 64
    else
      priceText = "Vételár: " .. sightexports.sGui:thousandsStepper(interiorList[id].price) .. " $"
      priceW = sightexports.sGui:getTextWidthFont(priceText, "15/BebasNeueRegular.otf")
    end
    local tw = math.max(sightexports.sGui:getTextWidthFont(name, "16/BebasNeueBold.otf"), priceW) + 16
    local pw = math.max(300, tw)
    local ih = 0
    local y = titleBarHeight
    if tonumber(interiorList[id].inside) then
      ih = math.ceil((pw - 16) * 0.5625)
      ph = ph + ih + 8
    end
    interiorBuyWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
    sightexports.sGui:setWindowTitle(interiorBuyWindow, "16/BebasNeueRegular.otf", "Interior " .. (interiorList[id].type == "rentable" and "bérlése" or "megvásárlása"))
    sightexports.sGui:setWindowCloseButton(interiorBuyWindow, "deleteInteriorBuyPanel")
    if interiorList[id].editable and interiorList[id].editable ~= "N" then
      local icon = sightexports.sGui:createGuiElement("image", 8, y + 8, pw - 16, ih, interiorBuyWindow)
      sightexports.sGui:setImageDDS(icon, ":sInteriors/files/pics/e.dds")
      y = y + ih + 8
    elseif tonumber(interiorList[id].inside) then
      local icon = sightexports.sGui:createGuiElement("image", 8, y + 8, pw - 16, ih, interiorBuyWindow)
      sightexports.sGui:setImageDDS(icon, ":sInteriors/files/pics/" .. interiorList[id].inside .. ".dds")
      y = y + ih + 8
    end
    y = y + 8
    local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, interiorBuyWindow)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "[" .. id .. "] " .. interiorList[id].name)
    sightexports.sGui:setLabelFont(label, "16/BebasNeueBold.otf")
    sightexports.sGui:setLabelColor(label, "#ffffff")
    y = y + 32
    if interiorList[id].type == "rentable" then
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, interiorBuyWindow)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, priceText)
      sightexports.sGui:setLabelFont(label, "15/BebasNeueRegular.otf")
      sightexports.sGui:setLabelColor(label, "sightgreen")
      y = y + 32
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, interiorBuyWindow)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, priceText2)
      sightexports.sGui:setLabelFont(label, "15/BebasNeueRegular.otf")
      sightexports.sGui:setLabelColor(label, "sightgreen")
      y = y + 32
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, interiorBuyWindow)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, priceText3)
      sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
      sightexports.sGui:setLabelColor(label, "sightgreen")
      y = y + 32
    else
      local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, interiorBuyWindow)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, priceText)
      sightexports.sGui:setLabelFont(label, "15/BebasNeueRegular.otf")
      sightexports.sGui:setLabelColor(label, "sightgreen")
      y = y + 32
    end
    y = y + 8
    local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 32, interiorBuyWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setClickEvent(btn, "tryToBuyInterior")
    if interiorList[id].type == "rentable" then
      sightexports.sGui:setButtonText(btn, "Bérlés")
    else
      sightexports.sGui:setButtonText(btn, "Vásárlás")
    end
    y = y + 32 + 8
    local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 32, interiorBuyWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setButtonText(btn, "Mégsem")
    sightexports.sGui:setClickEvent(btn, "deleteInteriorBuyPanel")
  end
end
addEvent("openInteriorBuyPanel", false)
addEventHandler("openInteriorBuyPanel", getRootElement(), openInteriorBuyPanel)
function openInteriorRentPanel()
  if interiorBuyWindow then
    sightexports.sGui:deleteGuiElement(interiorBuyWindow)
  end
  interiorBuyWindow = false
  local theType = currentInteriorMarkerType
  local id = currentInteriorId
  local charId = getElementData(localPlayer, "char.ID")
  if theType and interiorList[id] and interiorList[id].owner == charId and interiorList[id].type == "rentable" then
    local titleBarHeight = sightexports.sGui:getTitleBarHeight()
    local name = "[" .. id .. "] " .. interiorList[id].name
    local priceText = false
    local priceText2 = false
    local priceText3 = false
    local priceW = 0
    local ph = titleBarHeight + 8 + 160 + 24
    local time = getRealTime(interiorList[id].rentTime)
    priceText = "Lejárat: " .. string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
    priceText2 = "Bérleti díj: " .. sightexports.sGui:thousandsStepper(interiorList[id].price) .. " $ / hét"
    priceW = math.max(sightexports.sGui:getTextWidthFont(priceText, "15/BebasNeueRegular.otf"), sightexports.sGui:getTextWidthFont(priceText2, "15/BebasNeueBold.otf"))
    local tw = math.max(sightexports.sGui:getTextWidthFont(name, "16/BebasNeueBold.otf"), priceW) + 16
    local pw = math.max(300, tw)
    local ih = 0
    local y = titleBarHeight
    interiorBuyWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
    sightexports.sGui:setWindowTitle(interiorBuyWindow, "16/BebasNeueRegular.otf", "Albérlet kezelése")
    sightexports.sGui:setWindowCloseButton(interiorBuyWindow, "deleteInteriorBuyPanel")
    y = y + 8
    local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, interiorBuyWindow)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "[" .. id .. "] " .. interiorList[id].name)
    sightexports.sGui:setLabelFont(label, "16/BebasNeueBold.otf")
    sightexports.sGui:setLabelColor(label, "#ffffff")
    y = y + 32
    local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, interiorBuyWindow)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, priceText)
    sightexports.sGui:setLabelFont(label, "15/BebasNeueRegular.otf")
    y = y + 32
    local label = sightexports.sGui:createGuiElement("label", 0, y, pw, 32, interiorBuyWindow)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, priceText2)
    sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
    sightexports.sGui:setLabelColor(label, "sightgreen")
    y = y + 32
    y = y + 8
    local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 32, interiorBuyWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setClickEvent(btn, "tryToBuyInterior")
    sightexports.sGui:setButtonText(btn, "Bérlet meghosszabbítása")
    y = y + 32 + 8
    local btn = sightexports.sGui:createGuiElement("button", 8, y, pw - 16, 32, interiorBuyWindow)
    sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
    sightexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    sightexports.sGui:setClickEvent(btn, "tryToUnrentInterior")
    sightexports.sGui:setButtonText(btn, "Bérlet lemondása")
  end
end
addEvent("openInteriorRentPanel", false)
addEventHandler("openInteriorRentPanel", getRootElement(), openInteriorRentPanel)
local currentGate = false
local lastGateOpen = 0
function setGateState(gate)
  currentGate = gate
  lastGateOpen = 0
  refreshInteriorBottomGUI()
end
function getGateKey(gate)
  if sightexports.sItems:playerHasItemWithData(3, gate) then
    return true
  end
  if getElementData(localPlayer, "adminDuty") then
    return true
  end
  if sightexports.sPermission:hasPermission(localPlayer, "superUnlock") then
    return true
  end
  if sightexports.sGroups:getPlayerGate(gate) then
    return true
  end
end
function getInteriorKey(id)
  if getElementData(localPlayer, "adminDuty") then
    return true
  end
  if sightexports.sPermission:hasPermission(localPlayer, "superUnlock") then
    return true
  end
  local key = false
  if interiorList[id].ownerType == "player" then
    if interiorList[id].type == "rentable" then
      local charId = getElementData(localPlayer, "char.ID")
      key = interiorList[id].owner == charId
    else
      key = sightexports.sItems:playerHasItemWithData(2, id)
    end
  elseif interiorList[id].ownerType == "group" then
    key = sightexports.sGroups:getPlayerInterior(id)
  end
  return key
end
function refreshInteriorBottomGUI()
  local was = false
  if interiorEnterGui then
    was = true
    sightexports.sGui:deleteGuiElement(interiorEnterGui)
  end
  interiorEnterGui = false
  if interiorBuyWindow then
    sightexports.sGui:deleteGuiElement(interiorBuyWindow)
  end
  interiorBuyWindow = false
  local theType = currentInteriorMarkerType
  local id = currentInteriorId
  if theType and interiorList[id] then
    local col = getMarkerColor(id)
    interiorEnterGui = sightexports.sGui:createGuiElement("rectangle", screenX / 2 - 150, screenY + 64, 300, 75)
    sightexports.sGui:setGuiBackground(interiorEnterGui, "solid", "sightgrey2")
    local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, 75, 75, interiorEnterGui)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
    local icon = sightexports.sGui:createGuiElement("image", 6, 10, 63, 59, interiorEnterGui)
    sightexports.sGui:setImageDDS(icon, sightexports.sMarkers:getCustomMarkerTexture(getMarkerIcon(id)))
    local s = 5.079365079365079
    sightexports.sGui:setImageUV(icon, 0, 0, 320, 320 - 4 * s)
    sightexports.sGui:setImageColor(icon, col)
    local label = sightexports.sGui:createGuiElement("label", 87, 4, 0, 37.5, interiorEnterGui)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "[" .. id .. "] " .. interiorList[id].name)
    sightexports.sGui:setLabelFont(label, "16/BebasNeueBold.otf")
    sightexports.sGui:setLabelColor(label, col)
    local label2 = sightexports.sGui:createGuiElement("label", 87, 33.5, 0, 37.5, interiorEnterGui)
    sightexports.sGui:setLabelAlignment(label2, "left", "center")
    sightexports.sGui:setLabelText(label2, interiorList[id].zone)
    sightexports.sGui:setLabelFont(label2, "16/BebasNeueRegular.otf")
    local w = math.max(sightexports.sGui:getLabelTextWidth(label), sightexports.sGui:getLabelTextWidth(label2))
    w = 87 + math.max(200, w) + 12
    local yMinus = 0
    if interiorList[id].owner then
      local key = getInteriorKey(id)
      if theType == "outside" then
        local n = key and 1 or 0
        if ringInteriorTypes[interiorList[id].type] then
          n = n + 2
        elseif knockInteriorTypes[interiorList[id].type] then
          n = n + 1
        end
        local x = w / 2 - (36 * n - 8) / 2
        local y = -36
        if interiorList[id].type == "rentable" and key then
          y = y - 28 - 8
          local text = " Albérlet kezelése"
          local bw = math.ceil((28 + sightexports.sGui:getTextWidthFont(text, "12/BebasNeueRegular.otf") + 4) / 2) * 2
          local btn = sightexports.sGui:createGuiElement("button", w / 2 - bw / 2, -36, bw, 28, interiorEnterGui)
          sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
          sightexports.sGui:setGuiHover(btn, "gradient", {
            "sightgreen",
            "sightgreen-second"
          }, false, true)
          sightexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
          sightexports.sGui:setButtonText(btn, text)
          sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("tags", 28))
          sightexports.sGui:setClickEvent(btn, "openInteriorRentPanel")
          yMinus = yMinus + 28 + 8
        end
        if ringInteriorTypes[interiorList[id].type] then
          local rect = sightexports.sGui:createGuiElement("rectangle", x, y, 28, 28, interiorEnterGui)
          sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
          local icon = sightexports.sGui:createGuiElement("image", 2, 2, 24, 24, rect)
          sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("bell", 24))
          sightexports.sGui:setGuiBoundingBox(icon, rect)
          sightexports.sGui:setGuiHoverable(icon, true)
          sightexports.sGui:setGuiHover(icon, "solid", "sightyellow")
          sightexports.sGui:guiSetTooltip(icon, "Csengetés")
          sightexports.sGui:setClickEvent(icon, "ringBellOnInterior")
          x = x + 28 + 8
        end
        if knockInteriorTypes[interiorList[id].type] then
          local rect = sightexports.sGui:createGuiElement("rectangle", x, y, 28, 28, interiorEnterGui)
          sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
          local icon = sightexports.sGui:createGuiElement("image", 2, 2, 24, 24, rect)
          sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("hand-rock", 24))
          sightexports.sGui:setGuiBoundingBox(icon, rect)
          sightexports.sGui:setGuiHoverable(icon, true)
          sightexports.sGui:setGuiHover(icon, "solid", "sightyellow")
          sightexports.sGui:guiSetTooltip(icon, "Kopogtatás")
          sightexports.sGui:setClickEvent(icon, "knockOnInterior")
          x = x + 28 + 8
        end
        if key then
          local rect = sightexports.sGui:createGuiElement("rectangle", x, y, 28, 28, interiorEnterGui)
          sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
          local icon = sightexports.sGui:createGuiElement("image", 2, 2, 24, 24, rect)
          sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("key", 24))
          sightexports.sGui:setGuiBoundingBox(icon, rect)
          sightexports.sGui:setGuiHoverable(icon, true)
          sightexports.sGui:setGuiHover(icon, "solid", "sightyellow")
          sightexports.sGui:setClickEvent(icon, "lockUnlockInterior")
          if interiorList[id].locked then
            sightexports.sGui:guiSetTooltip(icon, "Interior kinyitása")
          else
            sightexports.sGui:guiSetTooltip(icon, "Interior bezárása")
          end
        end
      elseif key then
        local rect = sightexports.sGui:createGuiElement("rectangle", w / 2 - 14, -36, 28, 28, interiorEnterGui)
        sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
        local icon = sightexports.sGui:createGuiElement("image", 2, 2, 24, 24, rect)
        sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("key", 24))
        sightexports.sGui:setGuiBoundingBox(icon, rect)
        sightexports.sGui:setGuiHoverable(icon, true)
        sightexports.sGui:setGuiHover(icon, "solid", "sightyellow")
        sightexports.sGui:setClickEvent(icon, "lockUnlockInterior")
        if interiorList[id].locked then
          sightexports.sGui:guiSetTooltip(icon, "Interior kinyitása")
        else
          sightexports.sGui:guiSetTooltip(icon, "Interior bezárása")
        end
      end
      local label = sightexports.sGui:createGuiElement("label", w / 2, 75, 0, 32, interiorEnterGui)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "Nyomj [E] gombot az interior használatához.")
      sightexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
      yMinus = yMinus + 28 + 8
    elseif interiorList[id].price then
      local label = sightexports.sGui:createGuiElement("label", w / 2, -72, 0, 32, interiorEnterGui)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      if interiorList[id].type == "rentable" then
        sightexports.sGui:setLabelText(label, "Kiadó!")
      else
        sightexports.sGui:setLabelText(label, "Eladó!")
      end
      sightexports.sGui:setLabelColor(label, "sightgreen")
      sightexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
      local text = false
      local icon = false
      if interiorList[id].type == "rentable" then
        text = " Bérlés (" .. sightexports.sGui:thousandsStepper(interiorList[id].price) .. " $ / hét)"
        icon = sightexports.sGui:getFaIconFilename("tags", 28)
      else
        text = " Megvásárlás (" .. sightexports.sGui:thousandsStepper(interiorList[id].price) .. " $)"
        icon = sightexports.sGui:getFaIconFilename("shopping-cart", 28)
      end
      local bw = math.ceil((28 + sightexports.sGui:getTextWidthFont(text, "12/BebasNeueRegular.otf") + 4) / 2) * 2
      local btn = sightexports.sGui:createGuiElement("button", w / 2 - bw / 2, -36, bw, 28, interiorEnterGui)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
      sightexports.sGui:setButtonText(btn, text)
      sightexports.sGui:setButtonIcon(btn, icon)
      sightexports.sGui:setClickEvent(btn, "openInteriorBuyPanel")
      yMinus = yMinus + 64 + 8
    else
      local label = sightexports.sGui:createGuiElement("label", w / 2, 75, 0, 32, interiorEnterGui)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "Nyomj [E] gombot az interior használatához.")
      sightexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
      yMinus = yMinus + 32
    end
    sightexports.sGui:setGuiSize(interiorEnterGui, w, 75)
    if was then
      sightexports.sGui:setGuiPosition(interiorEnterGui, screenX / 2 - w / 2, screenY - 128 - 64 - yMinus)
    else
      sightexports.sGui:setGuiPosition(interiorEnterGui, screenX / 2 - w / 2, screenY + yMinus)
      sightexports.sGui:setGuiPositionAnimated(interiorEnterGui, screenX / 2 - w / 2, screenY - 128 - 64 - yMinus, 1000, false, "OutBounce")
    end
  elseif currentGate then
    interiorEnterGui = sightexports.sGui:createGuiElement("rectangle", screenX / 2 - 150, screenY + 64, 300, 75)
    sightexports.sGui:setGuiBackground(interiorEnterGui, "solid", "sightgrey2")
    local rect = sightexports.sGui:createGuiElement("rectangle", 0, 0, 75, 75, interiorEnterGui)
    sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
    local icon = sightexports.sGui:createGuiElement("image", 6, 6, 63, 63, interiorEnterGui)
    sightexports.sGui:setImageDDS(icon, ":sGates/files/icon.dds")
    sightexports.sGui:setImageColor(icon, "sightblue")
    local label = sightexports.sGui:createGuiElement("label", 87, 4, 0, 37.5, interiorEnterGui)
    sightexports.sGui:setLabelAlignment(label, "left", "center")
    sightexports.sGui:setLabelText(label, "Kapu")
    sightexports.sGui:setLabelFont(label, "16/BebasNeueBold.otf")
    sightexports.sGui:setLabelColor(label, "sightblue")
    local label2 = sightexports.sGui:createGuiElement("label", 87, 33.5, 0, 37.5, interiorEnterGui)
    sightexports.sGui:setLabelAlignment(label2, "left", "center")
    sightexports.sGui:setLabelText(label2, "ID: " .. currentGate)
    sightexports.sGui:setLabelFont(label2, "16/BebasNeueRegular.otf")
    local w = math.max(sightexports.sGui:getLabelTextWidth(label), sightexports.sGui:getLabelTextWidth(label2))
    w = 87 + math.max(200, w) + 12
    if not yMinus then
      yMinus = 32
    end
    if getGateKey(currentGate) then
      local label = sightexports.sGui:createGuiElement("label", w / 2, 75, 0, 32, interiorEnterGui)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "Nyomj [E] gombot a kapu használatához.")
      sightexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
    end
    sightexports.sGui:setGuiSize(interiorEnterGui, w, 75)
    if was then
      sightexports.sGui:setGuiPosition(interiorEnterGui, screenX / 2 - w / 2, screenY - 128 - 64 - yMinus)
    else
      sightexports.sGui:setGuiPosition(interiorEnterGui, screenX / 2 - w / 2, screenY + yMinus)
      sightexports.sGui:setGuiPositionAnimated(interiorEnterGui, screenX / 2 - w / 2, screenY - 128 - 64 - yMinus, 1000, false, "OutBounce")
    end
  end
end
function getCurrentStandingInterior()
  return currentInteriorId and interiorList[currentInteriorId] and currentInteriorId, currentInteriorMarkerType
end
function useDoorRam(itemDbID)
  triggerServerEvent("doorRam", localPlayer, currentInteriorId, itemDbID)
end
addEvent("changeEnteredCustomMarker", false)
addEventHandler("changeEnteredCustomMarker", getRootElement(), function(theType, id)
  if theType and (theType == "inside" or theType == "outside") and interiorList[id] then
    currentInteriorMarkerType = theType
    currentInteriorId = id
    if theType == "outside" then
      if interiorMarked == id then
        if isElement(interiorMarkBlip) then
          destroyElement(interiorMarkBlip)
        end
        interiorMarkBlip = false
        interiorMarked = false
      end
      if interiorList[id].editable ~= "N" and (interiorList[id].ownerType == "player" and interiorList[id].owner == getElementData(localPlayer, "char.ID") or interiorList[id].ownerType == "group" and sightexports.sGroups:getPlayerPermissionInGroup(interiorList[id].owner, "editInteriors")) then
        outputChatBox("[color=sightgreen][SightMTA - Interior]: #ffffffEz az interior szerkeszthető!", 255, 255, 255, true)
        outputChatBox("[color=sightgreen][SightMTA - Interior]: #ffffffHasználd a [color=sightgreen][Z]#ffffff gombot vagy a '[color=sightgreen]/edit#ffffff' parancsot a szerkesztéshez!", 255, 255, 255, true)
      end
    end
  else
    currentInteriorMarkerType = false
    currentInteriorId = false
  end
  refreshInteriorBottomGUI()
end)
local lastInteriorEnter = 0
local interiorFade = false
local interiorFadeA = 0
local lastInteriorFadeTick = 0
local interiorEnterTriggered = false
addEvent("interiorEntered", true)
addEventHandler("interiorEntered", getRootElement(), function(id)
  if id and interiorList[id] then
    local soundFile = "files/door/" .. math.random(1, 4) .. ".mp3"
    local time = 2000
    local dist = doorSoundDistance
    if interiorList[id].type == "lift" then
      soundFile = "files/elevator.mp3"
      time = 4500
    elseif interiorList[id].type == "stairs" then
      soundFile = "files/stairs" .. math.random(1, 2) .. ".mp3"
      time = 3000
    elseif interiorList[id].type == "business" then
      soundFile = "files/business.mp3"
    elseif interiorList[id].type == "garage" or interiorList[id].type == "garage2" then
      soundFile = "files/garage.mp3"
      time = 3000
      dist = dist * 1.5
    end
    if source == localPlayer then
      interiorFade = getTickCount() + time
      sightlangCondHandl0(true)
      playSound(soundFile)
    else
      local px, py, pz = getElementPosition(localPlayer)
      local int = getElementInterior(localPlayer)
      local dim = getElementDimension(localPlayer)
      local x, y, z, i, d = getInteriorOutsidePosition(id)
      if i == int and d == dim and getDistanceBetweenPoints3D(px, py, pz, x, y, z) < dist * 3 then
        local sound = playSound3D(soundFile, x, y, z)
        setElementInterior(sound, i)
        setElementDimension(sound, d)
        setSoundMaxDistance(sound, dist)
      end
      local x, y, z, i, d = getInteriorInsidePosition(id)
      if i == int and d == dim and getDistanceBetweenPoints3D(px, py, pz, x, y, z) < dist * 3 then
        local sound = playSound3D(soundFile, x, y, z)
        setElementInterior(sound, i)
        setElementDimension(sound, d)
        setSoundMaxDistance(sound, dist)
      end
    end
  elseif source == localPlayer then
    interiorFade = false
  end
end)
addEvent("interiorEnterCancelled", true)
addEventHandler("interiorEnterCancelled", getRootElement(), function(id)
  interiorFade = false
end)
function fadeInteriorRender()
  local now = getTickCount()
  local delta = now - lastInteriorFadeTick
  lastInteriorFadeTick = now
  if interiorFade then
    if tonumber(interiorFade) then
      if now > interiorFade then
        interiorFade = false
      end
    elseif interiorFadeA < 1 then
      interiorFadeA = interiorFadeA + 2 * delta / 1000
      if 1 < interiorFadeA then
        interiorFadeA = 1
        if not interiorEnterTriggered then
          if currentInteriorId and interiorList[currentInteriorId] then
            triggerServerEvent("teleportPlayerBetweenInterior", localPlayer, currentInteriorMarkerType, currentInteriorId)
          else
            interiorFade = false
          end
          interiorEnterTriggered = true
        end
      end
    elseif not interiorEnterTriggered then
      if currentInteriorId and interiorList[currentInteriorId] then
        triggerServerEvent("teleportPlayerBetweenInterior", localPlayer, currentInteriorMarkerType, currentInteriorId)
      else
        interiorFade = false
      end
      interiorEnterTriggered = true
    end
  else
    interiorFadeA = interiorFadeA - 2 * delta / 1000
  end
  if interiorFadeA <= 0 then
    if not interiorFade then
      sightlangCondHandl0(false)
      sightexports.sControls:toggleAllControls(true)
      setElementFrozen(localPlayer, false)
    end
  else
    dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * interiorFadeA))
  end
end
bindKey("k", "up", function()
  if currentInteriorId and interiorList[currentInteriorId] and getTickCount() > (interiorList[currentInteriorId].nextLock or 0) then
    if getInteriorKey(currentInteriorId) then
      interiorList[currentInteriorId].nextLock = getTickCount() + 1000
      triggerServerEvent("lockUnlockInterior", localPlayer, currentInteriorMarkerType, currentInteriorId)
    else
      sightexports.sGui:showInfobox("e", "Nincs kulcsod ehhez az interiorhoz!")
    end
  end
end)
local lastInteriorTry = 0
function policeLockInterior(cmd, ...)
  if currentInteriorId and interiorList[currentInteriorId] and not interiorFade and (sightexports.sGroups:getPlayerPermission("interiorLock") or sightexports.sPermission:hasPermission(localPlayer, "forceUnlockInterior")) then
    if interiorList[currentInteriorId].policeLock then
      triggerServerEvent("unlockPoliceInterior", localPlayer, currentInteriorMarkerType, currentInteriorId)
    else
      local reason = table.concat({
        ...
      }, " ")
      if reason and utf8.len(reason) > 0 then
        if utf8.len(reason) <= 24 then
          triggerServerEvent("lockPoliceInterior", localPlayer, currentInteriorMarkerType, currentInteriorId, reason)
        else
          sightexports.sGui:showInfobox("e", "Az indok maximum 24 karakter lehet!")
        end
      else
        outputChatBox("[color=sightblue][SightMTA - Használat]:[color=hudwhite] /" .. cmd .. " [Indok]", 255, 255, 255, true)
      end
    end
  end
end
addCommandHandler("policelock", policeLockInterior)
addCommandHandler("navlock", policeLockInterior)
addCommandHandler("nnilock", policeLockInterior)
addCommandHandler("okflock", policeLockInterior)

--[[
addCommandHandler("intidebug", function()
  outputChatBox("interiorFade: " .. tostring(interiorFade))
  outputChatBox("interiorFadeA: " .. tostring(interiorFadeA))
  outputChatBox("interiorEnterTriggered: " .. tostring(interiorEnterTriggered))
  outputChatBox("currentInteriorId: " .. tostring(currentInteriorId))
  outputChatBox("getTickCount: " .. tostring(getTickCount() - lastInteriorTry < 1000))
  outputChatBox("tick: " .. getTickCount())
end)
]]

bindKey("e", "up", function()
  if currentInteriorId and interiorList[currentInteriorId] and not interiorFade then
    if getElementData(localPlayer, "editingInterior") then
      sightexports.sGui:showInfobox("e", "Nem hagyhatod el az interiort szerkesztő módban.")
      return
    end
    if getTickCount() - lastInteriorTry < 1000 then
      return
    end
    if not interiorList[currentInteriorId].owner and interiorList[currentInteriorId].price and ownableInteriorTypes[interiorList[currentInteriorId].type] then
      openInteriorBuyPanel()
    else
      if currentInteriorMarkerType == "outside" then
        if not getInteriorInsidePosition(currentInteriorId) then
          return
        end
      elseif currentInteriorMarkerType == "inside" and not getInteriorOutsidePosition(currentInteriorId) then
        return
      end
      local currentTask = getPedSimplestTask(localPlayer)
      if interiorList[currentInteriorId].type ~= "garage" and interiorList[currentInteriorId].type ~= "garage2" then
        if isPedInVehicle(localPlayer) then
          return
        end
        if utf8.find(currentTask, "CAR") then
          return
        end
      end
      if currentTask == "TASK_SIMPLE_GO_TO_POINT" then
        return
      end
      if currentInteriorMarkerType == "outside" and interiorList[currentInteriorId].type == "garage" then
        sightexports.sGarages:prepareGarageFloor(currentInteriorId)
      end
      lastInteriorTry = getTickCount()
      local veh = getPedOccupiedVehicle(localPlayer)
      if veh and getVehicleController(veh) == localPlayer then
        setElementData(veh, "vehicle.gear", "N")
      end
      if interiorList[currentInteriorId].locked or interiorList[currentInteriorId].policeLock then
        triggerServerEvent("teleportPlayerBetweenInterior", localPlayer, currentInteriorMarkerType, currentInteriorId)
      else
        interiorFade = true
        lastInteriorFadeTick = getTickCount()
        if interiorFadeA <= 0 then
          interiorFadeA = 0
        end
        setElementFrozen(localPlayer, true)
        sightexports.sControls:toggleAllControls(false)
        interiorEnterTriggered = false
        sightlangCondHandl0(true, "low-99999999999999999999")
      end
    end
  elseif currentGate and getGateKey(currentGate) and getTickCount() - lastGateOpen > 500 then
    lastGateOpen = getTickCount()
    triggerServerEvent("toggleGate", localPlayer, currentGate)
  end
end)
local editTick = 0
addCommandHandler("edit", function()
  if currentInteriorId and interiorList[currentInteriorId] and not interiorFade and currentInteriorMarkerType == "outside" then
    if interiorList[currentInteriorId].editable ~= "N" then
      if editTick + 5000 <= getTickCount() then
        triggerServerEvent("editInterior", localPlayer, currentInteriorId)
        editTick = getTickCount()
      else
        outputChatBox("[color=sightred][SightMTA - Ingatlan]: #ffffffCsak 5 másodpercenként használhatod ezt a parancsot.", 255, 255, 255, true)
      end
    else
      outputChatBox("[color=sightred][SightMTA - Ingatlan]: #ffffffEz nem szerkeszthető interior.", 255, 255, 255, true)
    end
  end
end)
bindKey("Z", "down", "edit")

addEvent("markEventInterior", true)
function markEventInterior(destInterior, markType)
    if markType == "summerevent" then
      markerId = exports.sInteriors:getInteriorCustomID(destInterior)
      exports.sMarkers:setCustomMarkerMarked(markerId, "briefcase")
    elseif markType == "nionmarket" then
      markerId = exports.sInteriors:getInteriorCustomID(destInterior)
      exports.sMarkers:setCustomMarkerMarked(markerId, "deal")
    end
end
addEventHandler("markEventInterior", root, markEventInterior)

addEvent("deMarkEventInterior", true)
function deMarkEventInterior(destInterior)
    markerId = exports.sInteriors:getInteriorCustomID(destInterior)
    exports.sMarkers:setCustomMarkerMarked(markerId, false)
end
addEventHandler("deMarkEventInterior", root, deMarkEventInterior)