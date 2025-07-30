local sightexports = {
  sModloader = false,
  sGroups = false,
  sChat = false,
  sCirclegame = false,
  sGui = false,
  sMarkers = false
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
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sMarkers")
    if res0 and getResourceState(res0) == "running" then
      spawnMedicMarkers()
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
local sightlangModloaderLoaded = function()
  spawnMedicPed()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local medicNum = {}
local medicBags = {}
local medicCols = {}
local medicExam = {}
local inMedicCol = false
local inMedicGroup = false
function checkMedicGroup()
  return sightexports.sGroups:getPlayerPermission("medic")
end
function hitMedicCol(he, md)
  if md and he == localPlayer then
    if not inMedicCol then
      addEventHandler("onClientRender", getRootElement(), renderMedicRevive)
      addEventHandler("onClientClick", getRootElement(), clickMedicRevive)
    end
    inMedicCol = source
    inMedicGroup = checkMedicGroup()
    medicExam = {}
  end
end
function drawReviveIcon(cx, cy, client, bone, icon, color)
  local x, y, z = getPedBonePosition(client, bone)
  if x then
    local x, y = getScreenFromWorldPosition(x, y, z, 32)
    if x then
      dxDrawRectangle(x - 20, y - 20, 40, 40, tocolor(grey1[1], grey1[2], grey1[3]))
      if icon == loadIcon then
        dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. icon .. faTicks[icon], getTickCount() / 5 % 360, 0, 0, color and tocolor(color[1], color[2], color[3]))
      else
        dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. icon .. faTicks[icon], 0, 0, 0, color and tocolor(color[1], color[2], color[3]))
      end
      if cx and cx >= x - 20 and cx <= x + 20 and cy >= y - 20 and cy <= y + 20 then
        return true
      end
    end
  end
end
local hoveredPlayer = false
local hoveredBodypart = false
function clickMedicRevive(button, state)
  if state == "up" then
    if hoveredPlayer == "trash" then
      local id = medicCols[inMedicCol]
      triggerServerEvent("deleteMedicBag", localPlayer, id)
    elseif hoveredPlayer then
      if hoveredBodypart == "exam" then
        local time = 4000 + math.random(-1000, 1000)
        medicExam[hoveredPlayer] = getTickCount() + time
        sightexports.sChat:localActionC(localPlayer, "megvizsgálja a sérültet.")
        triggerServerEvent("examinePlayerAnimation", localPlayer, time)
      elseif hoveredBodypart == "adrenalin" then
        triggerServerEvent("useAdrenaline", localPlayer, hoveredPlayer)
      else
        triggerServerEvent("startPlayerFixingUp", localPlayer, hoveredPlayer, hoveredBodypart)
      end
    end
  end
end
addEventHandler("endCircleMinigame", getRootElement(), function(mgState, success)
  if mgState == "revive" then
    local id = false
    if inMedicCol then
      id = medicCols[inMedicCol]
    end
    triggerServerEvent("endPlayerFixingUp", localPlayer, success, id)
  end
end)
addEvent("startReviveMinigame", true)
addEventHandler("startReviveMinigame", getRootElement(), function(helping, inGroup)
  if helping == "bone" then
    sightexports.sCirclegame:startMinigame("revive", "sightred", "bone-break", "#000000", 32, 48, 108, 45, 5000)
  elseif helping == "blood" then
    sightexports.sCirclegame:startMinigame("revive", "sightred", "raindrops", "sightred", 32, 48, 108, 45, 5000)
  elseif helping == "revive" then
    if inGroup then
      sightexports.sCirclegame:startMinigame("revive", "sightred", "heart-rate", "sightorange", 32, 48, 112, 55, 12500)
    else
      sightexports.sCirclegame:startMinigame("revive", "sightred", "heart-rate", "sightorange", 32, 48, 112, 65, 100)
    end
  end
end)
function renderMedicRevive()
  local now = getTickCount()
  local cx, cy = getCursorPosition()
  if cx then
    cx = cx * screenX
    cy = cy * screenY
  end
  local tmpPlayer = false
  local tmpBodypart = false
  if isElement(inMedicCol) then
    local id = medicCols[inMedicCol]
    local x, y, z = getElementPosition(inMedicCol)
    local x, y = getScreenFromWorldPosition(x, y, z + 0.25, 80)
    if x then
      dxDrawRectangle(x - 80, y - 6, 160, 12, tocolor(grey1[1], grey1[2], grey1[3]))
      dxDrawRectangle(x - 80, y - 6, 160 * medicNum[id] / 10, 12, tocolor(green[1], green[2], green[3]))
      dxDrawRectangle(x - 14, y + 12 + 4, 28, 28, tocolor(grey1[1], grey1[2], grey1[3]))
      if cx and cx >= x - 14 and cx <= x + 14 and cy >= y + 12 + 4 and cy <= y + 12 + 4 + 28 then
        dxDrawImage(x - 12, y + 12 + 4 + 2, 24, 24, ":sGui/" .. trashIcon .. faTicks[trashIcon], 0, 0, 0, tocolor(red[1], red[2], red[3]))
        tmpPlayer = "trash"
      else
        dxDrawImage(x - 12, y + 12 + 4 + 2, 24, 24, ":sGui/" .. trashIcon .. faTicks[trashIcon])
      end
    end
    local players = getElementsWithinColShape(inMedicCol, "player")
    for i = 1, #players do
      local client = players[i]
      if client ~= localPlayer and not isPedInVehicle(client) then
        if medicExam[client] and 0 < now - medicExam[client] then
          if inMedicGroup then
            if playerBloodDamages[client] and 0 < playerBloodDamages[client][1] then
              if drawReviveIcon(cx, cy, client, 33, bloodIcon, red) then
                tmpPlayer = client
                tmpBodypart = 1
              end
            elseif playerDamageStates[client] and playerDamageStates[client][1] and drawReviveIcon(cx, cy, client, 33, boneIcon) then
              tmpPlayer = client
              tmpBodypart = 1
            end
            if playerBloodDamages[client] and 0 < playerBloodDamages[client][2] then
              if drawReviveIcon(cx, cy, client, 23, bloodIcon, red) then
                tmpPlayer = client
                tmpBodypart = 2
              end
            elseif playerDamageStates[client] and playerDamageStates[client][2] and drawReviveIcon(cx, cy, client, 23, boneIcon) then
              tmpPlayer = client
              tmpBodypart = 2
            end
            if playerBloodDamages[client] and 0 < playerBloodDamages[client][3] then
              if drawReviveIcon(cx, cy, client, 42, bloodIcon, red) then
                tmpPlayer = client
                tmpBodypart = 3
              end
            elseif playerDamageStates[client] and playerDamageStates[client][3] and drawReviveIcon(cx, cy, client, 42, boneIcon) then
              tmpPlayer = client
              tmpBodypart = 3
            end
            if playerBloodDamages[client] and 0 < playerBloodDamages[client][4] then
              if drawReviveIcon(cx, cy, client, 52, bloodIcon, red) then
                tmpPlayer = client
                tmpBodypart = 4
              end
            elseif playerDamageStates[client] and playerDamageStates[client][4] and drawReviveIcon(cx, cy, client, 52, boneIcon) then
              tmpPlayer = client
              tmpBodypart = 4
            end
          end
          if playerBloodDamages[client] and 0 < playerBloodDamages[client][5] and inMedicGroup then
            if drawReviveIcon(cx, cy, client, 3, bloodIcon, red) then
              tmpPlayer = client
              tmpBodypart = 5
            end
          elseif getElementHealth(client) <= 20 and drawReviveIcon(cx, cy, client, 3, reviveIcon, orange) then
            tmpPlayer = client
            tmpBodypart = 5
          end
          if getElementHealth(client) <= 20 and inMedicGroup and drawReviveIcon(cx, cy, client, 8, syringeIcon, orange) then
            tmpPlayer = client
            tmpBodypart = "adrenalin"
          end
        elseif medicExam[client] then
          drawReviveIcon(cx, cy, client, 3, loadIcon, {
            255,
            255,
            255
          })
        elseif drawReviveIcon(cx, cy, client, 3, searchIcon, {
          255,
          255,
          255
        }) then
          tmpPlayer = client
          tmpBodypart = "exam"
        end
      end
    end
  end
  if hoveredPlayer ~= tmpPlayer or hoveredBodypart ~= tmpBodypart then
    hoveredPlayer = tmpPlayer
    hoveredBodypart = tmpBodypart
    if hoveredPlayer == "trash" then
      sightexports.sGui:showTooltip("EÜ doboz törlése")
      sightexports.sGui:setCursorType("link")
    elseif hoveredPlayer then
      if hoveredBodypart == "exam" then
        sightexports.sGui:showTooltip("Sérült vizsgálata")
      elseif hoveredBodypart == 1 then
        if playerBloodDamages[hoveredPlayer] and 0 < playerBloodDamages[hoveredPlayer][1] then
          sightexports.sGui:showTooltip("Vérzés elállítása")
        elseif playerDamageStates[hoveredPlayer] and playerDamageStates[hoveredPlayer][1] then
          sightexports.sGui:showTooltip("Csonttörés kezelése")
        end
      elseif hoveredBodypart == 2 then
        if playerBloodDamages[hoveredPlayer] and 0 < playerBloodDamages[hoveredPlayer][2] then
          sightexports.sGui:showTooltip("Vérzés elállítása")
        elseif playerDamageStates[hoveredPlayer] and playerDamageStates[hoveredPlayer][2] then
          sightexports.sGui:showTooltip("Csonttörés kezelése")
        end
      elseif hoveredBodypart == 3 then
        if playerBloodDamages[hoveredPlayer] and 0 < playerBloodDamages[hoveredPlayer][3] then
          sightexports.sGui:showTooltip("Vérzés elállítása")
        elseif playerDamageStates[hoveredPlayer] and playerDamageStates[hoveredPlayer][3] then
          sightexports.sGui:showTooltip("Csonttörés kezelése")
        end
      elseif hoveredBodypart == 4 then
        if playerBloodDamages[hoveredPlayer] and 0 < playerBloodDamages[hoveredPlayer][4] then
          sightexports.sGui:showTooltip("Vérzés elállítása")
        elseif playerDamageStates[hoveredPlayer] and playerDamageStates[hoveredPlayer][4] then
          sightexports.sGui:showTooltip("Csonttörés kezelése")
        end
      elseif hoveredBodypart == 5 then
        if playerBloodDamages[hoveredPlayer] and 0 < playerBloodDamages[hoveredPlayer][5] and inMedicGroup then
          sightexports.sGui:showTooltip("Vérzés elállítása")
        elseif getElementHealth(hoveredPlayer) <= 20 then
          sightexports.sGui:showTooltip("Felsegítés")
        end
      elseif hoveredBodypart == "adrenalin" and getElementHealth(hoveredPlayer) <= 20 and inMedicGroup then
        sightexports.sGui:showTooltip("Adrenalin beadása")
      end
      sightexports.sGui:setCursorType("link")
    else
      sightexports.sGui:showTooltip(false)
      sightexports.sGui:setCursorType("normal")
    end
  end
  if not (isElement(inMedicCol) and isElementWithinColShape(localPlayer, inMedicCol)) or getElementDimension(localPlayer) ~= getElementDimension(inMedicCol) then
    removeEventHandler("onClientRender", getRootElement(), renderMedicRevive)
    removeEventHandler("onClientClick", getRootElement(), clickMedicRevive)
    inMedicCol = false
    if hoveredPlayer then
      sightexports.sGui:showTooltip(false)
      sightexports.sGui:setCursorType("normal")
    end
    hoveredPlayer = false
    hoveredBodypart = false
    medicExam = {}
  end
end
function processMedicBag(id, x, y, z, int, dim, num)
  if isElement(medicBags[id]) then
    destroyElement(medicBags[id])
    for col, i in pairs(medicCols) do
      if i == id then
        removeEventHandler("onClientColShapeHit", col, hitMedicCol)
        if isElement(col) then
          destroyElement(col)
        end
        medicCols[col] = i
      end
    end
  end
  medicBags[id] = nil
  medicNum[id] = nil
  if x then
    medicBags[id] = createObject(sightexports.sModloader:getModelId("omsz_bag") or 0, x, y, z)
    setElementInterior(medicBags[id], int)
    setElementDimension(medicBags[id], dim)
    setElementCollisionsEnabled(medicBags[id], false)
    local col = createColSphere(0, 0, 0, 3.5)
    medicCols[col] = id
    setElementInterior(col, int)
    setElementDimension(col, dim)
    setTimer(setElementPosition, 500, 1, col, x, y, z)
    addEventHandler("onClientColShapeHit", col, hitMedicCol)
    medicNum[id] = num
  end
end
addEvent("gotMedicBag", true)
addEventHandler("gotMedicBag", getRootElement(), function(id, x, y, z, int, dim, num)
  processMedicBag(id, x, y, z, int, dim, num)
end)
addEvent("updateMedicBag", true)
addEventHandler("updateMedicBag", getRootElement(), function(id, num)
  if medicNum[id] then
    medicNum[id] = num
  end
end)
addEvent("gotMedicBags", true)
addEventHandler("gotMedicBags", getRootElement(), function(list)
  for id, data in pairs(list) do
    processMedicBag(id, data[1], data[2], data[3], data[4], data[5], data[6])
  end
end)
triggerServerEvent("requestMedicBags", localPlayer)
local lastUse = 0
function useMedicPed()
  if getTickCount() - lastUse > 60000 then
    lastUse = getTickCount()
    triggerServerEvent("useMedicPed", localPlayer)
  else
    sightexports.sGui:showInfobox("e", "Várj egy kicsit, mielőtt újra használnád!")
  end
end
addEvent("changeEnteredCustomMarker", false)
addEventHandler("changeEnteredCustomMarker", getRootElement(), function(theType, id)
  if theType == "medic" then
    sightexports.sGui:showInfobox("i", "Nyomj [E] gombot a gyógyító NPC használatához! Az ellátás ára: 5 000$.")
    bindKey("e", "down", useMedicPed)
  else
    unbindKey("e", "down", useMedicPed)
  end
end)
local markers = {}
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
  for k = 1, #markers do
    if markers[k] then
      sightexports.sMarkers:deleteCustomMarker(markers[k])
    end
    markers[k] = nil
  end
end)
function spawnMedicPed()
  for i = 1, #pedPositions do
    local ped = createPed(1, pedPositions[i][1], pedPositions[i][2], pedPositions[i][3], pedPositions[i][4])
    setElementModel(ped, sightexports.sGroups:getGroupSkinId("OMSZ7"))
    setElementData(ped, "visibleName", "Gyógyítás")
    setElementFrozen(ped, true)
    setElementData(ped, "invulnerable", true)
  end
  for k, v in pairs(medicBags) do
    setElementModel(medicBags[k], sightexports.sModloader:getModelId("omsz_bag"))
  end
end
function spawnMedicMarkers()
  for i = 1, #markerPoses do
    markers[i] = sightexports.sMarkers:createCustomMarker(markerPoses[i][1], markerPoses[i][2], markerPoses[i][3], markerPoses[i][4], markerPoses[i][5], "#FFFFFF", "medic")
    sightexports.sMarkers:setCustomMarkerInterior(markers[i], "medic", i, 1)
  end
end
