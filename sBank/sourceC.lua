local sightexports = {
  sGroups = false,
  sGui = false,
  sModloader = false,
  sPattach = false,
  sPermission = false
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
    local res0 = getResourceFromName("sGroups")
    if res0 and getResourceState(res0) == "running" then
      refreshInPolice()
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
local faTicks = false
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
screenX, screenY = guiGetScreenSize()
local atmGui = false
local atmInput = false
local atmInputLabel = false
local atmBalance = false
local atmLoader = false
local atmBtn1 = false
local atmBtn2 = false
local atmBtn3 = false
local btnBg1 = false
local btnBg2 = false
local btnBg3 = false
local atmPhoneTopUp = false
local limitLabel = false
local atmAmount = 0
local bankBalance = 0
local transp = {
  0,
  0,
  0,
  0
}
local doneTimer = false
local loadingState = false
local loadingBalance = false
local currentATM = false
models = {}
local boxIcon = false
local inPolice = false
function refreshInPolice()
  local tmp = sightexports.sGroups:isPlayerInLawEnforcement()
  if inPolice ~= tmp then
    inPolice = tmp
    if inPolice then
      for id = 1, #atmDatas do
        if atmDatas[id].robStarted then
          resetATM(id)
        end
      end
    else
      for id = 1, #atmDatas do
        if atmDatas[id].robStarted then
          resetATM(id)
        end
      end
    end
    refreshCasetteBlips()
  end
end
local casetteBlips = {}
local casetteData = {}
function getCasettePos(x, y)
  local r = math.rad(math.pi * 2 * math.random())
  local d = math.random(0, 675) / 10
  return x + math.cos(r) * d, y + math.sin(r) * d
end
addEvent("gotCasetteData", true)
addEventHandler("gotCasetteData", getRootElement(), function(client, data)
  casetteData[client] = data
  if not data and isElement(casetteBlips[client]) then
    destroyElement(casetteBlips[client])
    casetteBlips[client] = nil
  elseif data and inPolice then
    local x, y, z, live = unpack(data)
    x, y = getCasettePos(x, y)
    local col = live and v4orange or v4red
    if not isElement(casetteBlips[client]) then
      casetteBlips[client] = createBlip(x, y, z, 11, 2, col[1], col[2], col[3])
      setElementData(casetteBlips[client], "tooltipText", "Pénzkazetta jeladó (" .. (live and "ONLINE" or "OFFLINE") .. ")")
    else
      setElementPosition(casetteBlips[client], x, y, z)
      setBlipColor(casetteBlips[client], col[1], col[2], col[3], 255)
      setElementData(casetteBlips[client], "tooltipText", "Pénzkazetta jeladó (" .. (live and "ONLINE" or "OFFLINE") .. ")")
    end
  end
end)
function refreshCasetteBlips()
  if inPolice then
    if casetteData then
      for client, data in pairs(casetteData) do
        local x, y, z, live = unpack(data)
        x, y = getCasettePos(x, y)
        local col = live and v4orange or v4red
        if not isElement(casetteBlips[client]) then
          casetteBlips[client] = createBlip(x, y, z, 11, 2, col[1], col[2], col[3])
          setElementData(casetteBlips[client], "tooltipText", "Pénzkazetta jeladó (" .. (live and "ONLINE" or "OFFLINE") .. ")")
        else
          setElementPosition(casetteBlips[client], x, y, z)
          setBlipColor(casetteBlips[client], col[1], col[2], col[3], 255)
          setElementData(casetteBlips[client], "tooltipText", "Pénzkazetta jeladó (" .. (live and "ONLINE" or "OFFLINE") .. ")")
        end
      end
    end
  else
    for client in pairs(casetteBlips) do
      if isElement(casetteBlips[client]) then
        destroyElement(casetteBlips[client])
      end
      casetteBlips[client] = nil
    end
  end
end
function guiRefreshColors()
  font = sightexports.sGui:getFont("12/BebasNeueBold.otf")
  fontScale = sightexports.sGui:getFontScale("12/BebasNeueBold.otf")
  v4grey = sightexports.sGui:getColorCode("sightgrey1")
  v4green = sightexports.sGui:getColorCode("sightgreen")
  v4red = sightexports.sGui:getColorCode("sightred")
  v4orange = sightexports.sGui:getColorCode("sightorange")
  boxIcon = sightexports.sGui:getFaIconFilename("sign-out", 32)
  if inPolice then
    for id = 1, #atmDatas do
      if atmDatas[id].robStarted then
        resetATM(id)
      end
    end
    refreshCasetteBlips()
  end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  engineLoadIFP("files/flex.ifp", "flex")
  triggerLatentServerEvent("requestATMRobData", localPlayer)
  triggerLatentServerEvent("requestATMCasetteData", localPlayer)
end)
local flexQ = {
  0.68589759975875,
  -0.72769807107425,
  1.2057324166135E-20,
  8.6850062541364E-18
}
local flexObjects = {}
local flexDiscs = {}
local loopSounds = {}
local cutSounds = {}
local atmSparking = {}
local sparkingHandled = false
local sparks = {}
function preRenderSparks(delta)
  for i = #sparks, 1, -1 do
    local nx, ny, nz = sparks[i][4], sparks[i][5], sparks[i][6]
    sparks[i][1] = sparks[i][1] + nx * 2.5 * delta / 1000
    sparks[i][2] = sparks[i][2] + ny * 2.5 * delta / 1000
    sparks[i][3] = sparks[i][3] + nz * 2.5 * delta / 1000
    local sx, sy, sz = sparks[i][1], sparks[i][2], sparks[i][3]
    sparks[i][7] = sparks[i][7] + 0.25 * delta / 1000
    local a = 255 - sparks[i][7] * sparks[i][9] * 255
    if a < 0 then
      table.remove(sparks, i)
    else
      local p = sparks[i][7] * 30
      local c = false
      if 2 <= p then
        c = tocolor(175, 50, 20, a)
      elseif 1 <= p then
        local r = 245 + -70 * (p - 1)
        local g = 219 + -169 * (p - 1)
        local b = 121 + -101 * (p - 1)
        c = tocolor(r, g, b, a)
      elseif 0 <= p then
        local r = 255 + -10 * p
        local g = 255 + -36 * p
        local b = 255 + -134 * p
        c = tocolor(r, g, b, a)
      else
        c = tocolor(255, 255, 255)
      end
      local len = math.sqrt(nx * nx + ny * ny + nz * nz) * 2
      nx = nx / len * sparks[i][8]
      ny = ny / len * sparks[i][8]
      nz = nz / len * sparks[i][8]
      dxDrawLine3D(sx, sy, sz, sx + nx, sy + ny, sz + nz, c, 0.125)
    end
  end
  for id, client in pairs(atmSparking) do
    if client ~= localPlayer and not atmDatas[id].robbed then
      if not isElement(client) then
        atmSparking[id] = nil
      else
        local x, y, z = atmDatas[id].pos[1], atmDatas[id].pos[2], atmDatas[id].pos[3] - 0.355
        local r = atmDatas[id].pos[4]
        local rad = math.rad(r)
        local cos = math.cos(rad)
        local sin = math.sin(rad)
        x = x + sin * 0.315
        y = y - cos * 0.315
        z = z - 0.2656
        local nx, ny, nz = cos, sin, -0.125 + 0.25 * math.random()
        local s = 1
        local alive = 6
        local rp = -1
        if math.random() > 0.8 then
          s = 0.75
          alive = 16
          nx, ny = -nx, -ny
          rp = 1
        end
        local r = rp * math.pi / 9 * math.random()
        nx, ny = nx * math.cos(r) - ny * math.sin(r), nx * math.sin(r) + ny * math.cos(r)
        table.insert(sparks, {
          x,
          y,
          z,
          nx * s,
          ny * s,
          nz * s,
          math.random() * 0.075 - 0.025,
          0.05 + math.random() * 0.25 * s * s,
          alive * (0.8 + math.random() * 0.3)
        })
      end
    end
  end
  if #sparks <= 0 then
    removeEventHandler("onClientPreRender", getRootElement(), preRenderSparks)
    sparkingHandled = false
  end
end
addEvent("syncAtmCutSound", true)
addEventHandler("syncAtmCutSound", getRootElement(), function(id, state)
  if cutSounds[source] then
    setSoundVolume(cutSounds[source], state and 1 or 0)
  end
  atmSparking[id] = state and source or nil
  if state and not sparkingHandled then
    addEventHandler("onClientPreRender", getRootElement(), preRenderSparks)
    sparkingHandled = true
  end
end)
addEvent("atmRobState", true)
addEventHandler("atmRobState", getRootElement(), function(state)
  if isElement(source) and source ~= localPlayer then
    if isElement(flexObjects[source]) then
      destroyElement(flexObjects[source])
    end
    flexObjects[source] = nil
    if isElement(flexDiscs[source]) then
      destroyElement(flexDiscs[source])
    end
    flexDiscs[source] = nil
    if isElement(loopSounds[source]) then
      destroyElement(loopSounds[source])
    end
    loopSounds[source] = nil
    if isElement(cutSounds[source]) then
      destroyElement(cutSounds[source])
    end
    cutSounds[source] = nil
    if state then
      setPedAnimation(source, "flex", "camcrch_idleloop", -1, true, false, false, false)
      local x, y, z = getElementPosition(source)
      local i = getElementInterior(source)
      local d = getElementDimension(source)
      flexObjects[source] = createObject(sightexports.sModloader:getModelId("flex"), x, y, z - 5, 0, 0, r)
      setElementInterior(flexObjects[source], i)
      setElementDimension(flexObjects[source], d)
      flexDiscs[source] = createObject(sightexports.sModloader:getModelId("flex_disc"), x, y, z - 5, 0, 0, r)
      setElementInterior(flexDiscs[source], i)
      setElementDimension(flexDiscs[source], d)
      setElementCollisionsEnabled(flexObjects[source], false)
      setElementCollisionsEnabled(flexDiscs[source], false)
      sightexports.sPattach:attach(flexObjects[source], source, 24, -0.25239710864494, 0.082310572397713, 0.048512647503903, 0, 0, 0)
      sightexports.sPattach:attach(flexDiscs[source], source, 24, -0.25239710864494, 0.082310572397713, 0.048512647503903, 0, 0, 0)
      sightexports.sPattach:setRotationQuaternion(flexObjects[source], flexQ)
      sightexports.sPattach:setRotationQuaternion(flexDiscs[source], flexQ)
      loopSounds[source] = playSound3D("files/loop.mp3", x, y, z, true)
      cutSounds[source] = playSound3D("files/cut.mp3", x, y, z, true)
      setSoundVolume(loopSounds[source], 1)
      setSoundVolume(cutSounds[source], 0)
      setElementInterior(loopSounds[source], i)
      setElementDimension(loopSounds[source], d)
      setElementInterior(cutSounds[source], i)
      setElementDimension(cutSounds[source], d)
      attachElements(loopSounds[source], flexObjects[source])
      attachElements(cutSounds[source], flexObjects[source])
    else
      setPedAnimation(source)
    end
  end
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
  if isElement(flexObjects[source]) then
    destroyElement(flexObjects[source])
  end
  flexObjects[source] = nil
  if isElement(flexDiscs[source]) then
    destroyElement(flexDiscs[source])
  end
  flexDiscs[source] = nil
  if isElement(loopSounds[source]) then
    destroyElement(loopSounds[source])
  end
  loopSounds[source] = nil
  if isElement(cutSounds[source]) then
    destroyElement(cutSounds[source])
  end
  cutSounds[source] = nil
  if isElement(casetteBlips[source]) then
    destroyElement(casetteBlips[source])
  end
  casetteBlips[source] = nil
  casetteData[source] = nil
end)
local atmElements = {}
addEvent("gotATMRobData", true)
addEventHandler("gotATMRobData", getRootElement(), function(dat)
  for id, d in pairs(dat) do
    atmDatas[id].robStarted = d[1]
    atmDatas[id].robbed = d[2]
    resetATM(id)
  end
end)
addEvent("gotPlayerGroupMembership", true)
addEventHandler("gotPlayerGroupMembership", getRootElement(), refreshInPolice)
addEvent("refreshATMRobStarted", true)
addEventHandler("refreshATMRobStarted", getRootElement(), function(id, state, group)
  if atmDatas[id] then
    atmDatas[id].robStarted = state
    if state then
      if inPolice then
        local x, y, z = atmDatas[id].pos[1], atmDatas[id].pos[2], atmDatas[id].pos[3]
        if group then
          outputChatBox("[color=sightred][SightMTA - ATM]: #ffffffFigyelem! Egy [color=sightred]ATM üzemképtelen#ffffff. (" .. getZoneName(x, y, z) .. ") ((".. group .."))", 255, 255, 255, true)
        else
          outputChatBox("[color=sightred][SightMTA - ATM]: #ffffffFigyelem! Egy [color=sightred]ATM üzemképtelen#ffffff. (" .. getZoneName(x, y, z) .. ")", 255, 255, 255, true)
        end
        playSound(":sGroups/files/backup.mp3")
      end
    else
      atmDatas[id].robbed = nil
    end
    resetATM(id)
  end
end)
addEvent("refreshATMRobbed", true)
addEventHandler("refreshATMRobbed", getRootElement(), function(id, state, box)
  if atmDatas[id] then
    atmDatas[id].robbed = state
    if box and isElementStreamedIn(atmDatas[id].obj) then
      local x, y, z = atmDatas[id].pos[1], atmDatas[id].pos[2], atmDatas[id].pos[3] - 0.355
      local r = atmDatas[id].pos[4]
      local rad = math.rad(r)
      local cos = math.cos(rad)
      local sin = math.sin(rad)
      local x = x + cos * moneyBoxes[box][1] + sin * (moneyBoxes[box][2] + 0.25)
      local y = y + sin * moneyBoxes[box][1] - cos * (moneyBoxes[box][2] + 0.25)
      local z = z + moneyBoxes[box][3] + 0.086
      local sound = playSound3D("files/rob.mp3", x, y, z)
      setElementInterior(sound, atmDatas[id].pos[5])
      setElementDimension(sound, atmDatas[id].pos[6])
    end
    resetATM(id)
    checkRobbedCount()
  end
end)
local robHandled = false
local robHover = false
local robHoverBox = false
local robbedAtmList = {}
function renderRobbedATM()
  if not robbingAtm then
    local tmp = false
    local tmpBox = false
    local px, py, pz = getElementPosition(localPlayer)
    local int = getElementInterior(localPlayer)
    local dim = getElementDimension(localPlayer)
    local cx, cy = getCursorPosition()
    if cx then
      cx = cx * screenX
      cy = cy * screenY
    end
    for j = 1, #robbedAtmList do
      local id = robbedAtmList[j]
      if checkDistanceEx(px, py, pz, int, dim, id) then
        local x, y, z = atmDatas[id].pos[1], atmDatas[id].pos[2], atmDatas[id].pos[3] - 0.355
        local r = atmDatas[id].pos[4]
        local rad = math.rad(r)
        local cos = math.cos(rad)
        local sin = math.sin(rad)
        for i = 1, #moneyBoxes do
          if not atmDatas[id].robbed[i] then
            local x = x + cos * moneyBoxes[i][1] + sin * (moneyBoxes[i][2] + 0.25)
            local y = y + sin * moneyBoxes[i][1] - cos * (moneyBoxes[i][2] + 0.25)
            local z = z + moneyBoxes[i][3] + 0.086
            local x, y = getScreenFromWorldPosition(x, y, z, 32)
            if x then
              dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(v4grey[1], v4grey[2], v4grey[3]))
              if cx and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
                dxDrawImage(x - 14, y - 14, 28, 28, ":sGui/" .. boxIcon .. faTicks[boxIcon], 0, 0, 0, tocolor(v4green[1], v4green[2], v4green[3]))
                tmp = id
                tmpBox = i
              else
                dxDrawImage(x - 14, y - 14, 28, 28, ":sGui/" .. boxIcon .. faTicks[boxIcon], 0, 0, 0, tocolor(255, 255, 255))
              end
            end
          end
        end
      end
    end
    if robHover ~= tmp or robHoverBox ~= tmpBox then
      robHover = tmp
      robHoverBox = tmpBox
      sightexports.sGui:setCursorType(robHover and "link" or "normal")
      sightexports.sGui:showTooltip(robHover and "Pénzkazetta kivétele")
    end
  end
end
function checkRobbedCount()
  robbedAtmList = {}
  for id = 1, #atmDatas do
    if atmDatas[id].robbed and isElementStreamedIn(atmDatas[id].obj) then
      for j = 1, #moneyBoxes do
        if not atmDatas[id].robbed[j] then
          table.insert(robbedAtmList, id)
          break
        end
      end
    end
  end
  local tmp = 0 < #robbedAtmList
  if robHandled ~= tmp then
    robHandled = tmp
    if robHover then
      sightexports.sGui:setCursorType("normal")
      sightexports.sGui:showTooltip()
    end
    robHover = false
    robHoverBox = false
    if robHandled then
      addEventHandler("onClientRender", getRootElement(), renderRobbedATM)
    else
      removeEventHandler("onClientRender", getRootElement(), renderRobbedATM)
    end
  end
end
function resetATM(id)
  local x, y, z = atmDatas[id].pos[1], atmDatas[id].pos[2], atmDatas[id].pos[3] - 0.355
  if isElement(atmDatas[id].blip) then
    destroyElement(atmDatas[id].blip)
  end
  atmDatas[id].blip = nil
  if inPolice and (atmDatas[id].robbed or atmDatas[id].robStarted) then
    atmDatas[id].blip = createBlip(x, y, z, 10, 2, v4red[1], v4red[2], v4red[3])
    setElementData(atmDatas[id].blip, "tooltipText", "Üzemképtelen ATM")
  end
  if robbingAtm ~= id then
    local r = atmDatas[id].pos[4]
    if atmDatas[id].robbed or not atmDatas[id].robStarted then
      if isElement(atmDatas[id].door) then
        destroyElement(atmDatas[id].door)
      end
      atmDatas[id].door = false
    elseif not isElement(atmDatas[id].door) then
      atmDatas[id].door = createObject(models.v4_atm2_door, x, y, z, 0, 0, r)
      setElementInterior(atmDatas[id].door, atmDatas[id].pos[5])
      setElementDimension(atmDatas[id].door, atmDatas[id].pos[6])
      setElementCollisionsEnabled(atmDatas[id].door, false)
    end
    if atmDatas[id].robbed then
      local rad = math.rad(r)
      local cos = math.cos(rad)
      local sin = math.sin(rad)
      for i = 1, #moneyBoxes do
        if atmDatas[id].robbed[i] then
          if isElement(atmDatas[id].boxes[i]) then
            destroyElement(atmDatas[id].boxes[i])
          end
          atmDatas[id].boxes[i] = nil
        elseif not isElement(atmDatas[id].boxes[i]) then
          local x = x + cos * moneyBoxes[i][1] + sin * moneyBoxes[i][2]
          local y = y + sin * moneyBoxes[i][1] - cos * moneyBoxes[i][2]
          local z = z + moneyBoxes[i][3]
          atmDatas[id].boxes[i] = createObject(models.v4_atm_cassette, x, y, z, 0, 0, r - 90)
          setElementInterior(atmDatas[id].boxes[i], atmDatas[id].pos[5])
          setElementDimension(atmDatas[id].boxes[i], atmDatas[id].pos[6])
          setElementCollisionsEnabled(atmDatas[id].boxes[i], false)
        end
      end
    else
      for i = 1, #moneyBoxes do
        if atmDatas[id].boxes then
          if isElement(atmDatas[id].boxes[i]) then
            destroyElement(atmDatas[id].boxes[i])
          end
          atmDatas[id].boxes[i] = nil
        end
      end
    end

    if isElement(atmDatas[id].obj) then
      local model = models[atmDatas[id].robStarted and "v4_atm2" or "v4_atm"]

      atmDatas[id].obj = createObject(model, atmDatas[id].pos[1], atmDatas[id].pos[2], atmDatas[id].pos[3], atmDatas[id].pos[4])
      setElementInterior(atmDatas[i].obj, atmDatas[i].pos[5])
      setElementDimension(atmDatas[i].obj, atmDatas[i].pos[6])
      --setElementModel(atmDatas[id].obj, models[atmDatas[id].robStarted and "v4_atm2" or "v4_atm"])
    end
  end
end
function loadATMs()
  models = {
    v4_atm = sightexports.sModloader:getModelId("v4_atm"),
    v4_atm2 = sightexports.sModloader:getModelId("v4_atm2"),
    v4_atm2_door = sightexports.sModloader:getModelId("v4_atm2_door"),
    v4_atm_cassette = sightexports.sModloader:getModelId("v4_atm_cassette")
  }
  for i = 1, #atmDatas do
    atmDatas[i].boxes = {}
    if atmDatas[i].skin then
      atmDatas[i].obj = createPed(atmDatas[i].skin, atmDatas[i].pos[1], atmDatas[i].pos[2], atmDatas[i].pos[3], atmDatas[i].pos[4])
      setElementInterior(atmDatas[i].obj, atmDatas[i].pos[5])
      setElementDimension(atmDatas[i].obj, atmDatas[i].pos[6])
      setElementFrozen(atmDatas[i].obj, true)
      setElementData(atmDatas[i].obj, "visibleName", "Banki ügyintéző")
      setElementData(atmDatas[i].obj, "invulnerable", true)
    else
      atmDatas[i].obj = createObject(models.v4_atm, atmDatas[i].pos[1], atmDatas[i].pos[2], atmDatas[i].pos[3] - 0.355, 0, 0, atmDatas[i].pos[4])
      setElementInterior(atmDatas[i].obj, atmDatas[i].pos[5])
      setElementDimension(atmDatas[i].obj, atmDatas[i].pos[6])
      if not atmDatas[i].protected then
        addEventHandler("onClientElementStreamIn", atmDatas[i].obj, checkRobbedCount)
        addEventHandler("onClientElementStreamOut", atmDatas[i].obj, checkRobbedCount)
      end
    end
    atmElements[atmDatas[i].obj] = i
  end
end
addEvent("modloaderLoaded", false)
addEventHandler("modloaderLoaded", getRootElement(), loadATMs)
if getElementData(localPlayer, "loggedIn") then
  loadATMs()
end
addEventHandler("onClientClick", getRootElement(), function(button, state, x, y, wx, wy, wz, clickedElement)
  if state == "down" and not robbingAtm then
    if robHover then
      triggerServerEvent("takeOutBoxFromATM", localPlayer, robHover, robHoverBox)
    elseif not atmGui and atmElements[clickedElement] and checkDistance(localPlayer, atmElements[clickedElement]) then
      local id = atmElements[clickedElement]
      if getElementData(localPlayer, "usingGrinder") and not atmDatas[id].skin then
        if atmDatas[id].protected then
          sightexports.sGui:showInfobox("e", "Ez egy védett ATM, nem rabolhatod ki.")
        elseif not atmDatas[id].robbed then
          triggerServerEvent("tryToRobATM", localPlayer, id)
        end
      elseif not atmDatas[id].robStarted and not atmDatas[id].robbed then
        createATM(id)
        atmPhoneTopUp = false
      else
        sightexports.sGui:showInfobox("e", "Ez az ATM nem működik.")
      end
    end
  end
end, true, "high+999999999999")
function deleteATM()
  currentATM = false
  showCursor(false)
  if atmGui then
    sightexports.sGui:deleteGuiElement(atmGui)
    removeEventHandler("onClientPreRender", getRootElement(), checkATMDistance)
  end
  atmGui = false
  atmInput = false
  phoneInput = false
  atmBalance = false
  atmLoader = false
  atmBtn1 = false
  atmBtn2 = false
  atmBtn3 = false
  btnBg1 = false
  btnBg2 = false
  btnBg3 = false
  limitLabel = false
end
addEvent("changeATMInput", false)
addEventHandler("changeATMInput", getRootElement(), function(amount)
  atmAmount = math.floor(math.max(0, tonumber(amount) or 0))
  if atmInputLabel then
    sightexports.sGui:setLabelText(atmInputLabel, "azaz " .. sightexports.sGui:thousandsStepper(atmAmount) .. " $")
  end
end)
addEvent("atmBtnHover", false)
addEventHandler("atmBtnHover", getRootElement(), function(el, state)
  local el2 = false
  if el == atmBtn1 then
    el2 = btnBg1
  elseif el == atmBtn2 then
    el2 = btnBg2
  elseif el == atmBtn3 then
    el2 = btnBg3
  end
  if el2 == btnBg3 then
    sightexports.sGui:setImageColor(el2, state and "#36d7b7" or "#2bcaaa")
  else
    sightexports.sGui:setImageColor(el2, state and "#369cd7" or "#2793cd")
  end
end)
addEvent("atmPayOut", false)
addEventHandler("atmPayOut", getRootElement(), function()
  if atmAmount < 1500 then
    sightexports.sGui:showInfobox("e", "A minimum kifizethető összeg: 1 500 $")
  else
    triggerLatentServerEvent("atmPayOut", localPlayer, currentATM, atmAmount)
    loadingState = true
    refreshInputShown()
  end
end)
addEvent("atmPayIn", false)
addEventHandler("atmPayIn", getRootElement(), function()
  if atmAmount < 1500 then
    sightexports.sGui:showInfobox("e", "A minimum befizethető összeg: 1 500 $")
  else
    triggerLatentServerEvent("atmPayIn", localPlayer, currentATM, atmAmount)
    loadingState = true
    refreshInputShown()
  end
end)
function doneAtmLoading(success)
  if success then
    sightexports.sGui:setInputValue(atmInput, "")
    if phoneInput then
      sightexports.sGui:setInputValue(phoneInput, "")
    end
    atmAmount = 0
    if atmInputLabel then
      sightexports.sGui:setLabelText(atmInputLabel, "azaz 0 $")
    end
  end
  loadingState = false
  refreshInputShown()
end
addEvent("atmResponse", true)
addEventHandler("atmResponse", getRootElement(), function(i, success, fastLoad)
  if source == localPlayer and atmGui then
    if isTimer(doneTimer) then
      killTimer(doneTimer)
    end
    doneTimer = nil
    if success and not fastLoad then
      doneTimer = setTimer(doneAtmLoading, 10000, 1, success)
    else
      doneTimer = setTimer(doneAtmLoading, 2000, 1, success)
    end
  end
  if success and not fastLoad and atmDatas[i] then
    local sound = playSound3D("files/" .. (atmDatas[i].skin and "bankcount" or "atmmoneyinout") .. ".mp3", atmDatas[i].pos[1], atmDatas[i].pos[2], atmDatas[i].pos[3])
    setElementInterior(sound, atmDatas[i].pos[5])
    setElementDimension(sound, atmDatas[i].pos[6])
  end
end)
addEvent("closeATMPanel", false)
addEventHandler("closeATMPanel", getRootElement(), function()
  deleteATM()
end)
addEvent("refreshBankMoney", true)
addEventHandler("refreshBankMoney", getRootElement(), function(bal)
  bankBalance = bal
  loadingBalance = false
  if atmGui then
    sightexports.sGui:setLabelText(atmBalance, sightexports.sGui:thousandsStepper(bankBalance) .. " $")
    refreshInputShown()
  end
end)
addEvent("refreshATMDailyLimit", true)
addEventHandler("refreshATMDailyLimit", getRootElement(), function(limit)
  if limitLabel then
    sightexports.sGui:setLabelText(limitLabel, "ATM pénzfelvételi napi limit:\n" .. sightexports.sGui:thousandsStepper(limit) .. " $")
  end
end)
addEvent("atmTogglePhoneTopUp", true)
addEventHandler("atmTogglePhoneTopUp", getRootElement(), function()
  if currentATM then
    atmPhoneTopUp = not atmPhoneTopUp
    createATM(currentATM)
  end
end)
addEvent("finalAtmTopUpPhone", true)
addEventHandler("finalAtmTopUpPhone", getRootElement(), function()
  if currentATM then
    if atmAmount < 10 then
      sightexports.sGui:showInfobox("e", "A minimum feltölthető összeg 10 $!")
      return
    end
    local phone = sightexports.sGui:getInputValue(phoneInput)
    if phone then
      local str = utf8.gsub(utf8.gsub(utf8.gsub(phone, "+", ""), "-", ""), " ", "")
      phone = tonumber(str)
      if phone and 0 < phone then
        triggerServerEvent("atmTopUpPhone", localPlayer, currentATM, phone, atmAmount)
        loadingState = true
        refreshInputShown()
        return
      end
    end
    sightexports.sGui:showInfobox("e", "Nem megfelelő telefonszám!")
  end
end)
function checkATMDistance()
  if not checkDistance(localPlayer, currentATM) then
    deleteATM()
  end
end
function createATM(id)
  if not loadingBalance then
    local event = false
    if atmDatas[id].skin then
      event = "requestBankMoney"
    else
      event = "requestATMMoney"
    end
    loadingBalance = true
    setTimer(triggerServerEvent, 1000 + 1000 * math.random(), 1, event, localPlayer)
  end
  deleteATM()
  showCursor(true)
  addEventHandler("onClientPreRender", getRootElement(), checkATMDistance)
  atmGui = sightexports.sGui:createGuiElement("image", screenX / 2 - 300, screenY / 2 - 300, 600, 600)
  sightexports.sGui:setImageDDS(atmGui, atmPhoneTopUp and ":sBank/files/atm2.dds" or ":sBank/files/atm.dds")
  atmAmount = 0
  local label = sightexports.sGui:createGuiElement("label", 10, 48, 0, 35, atmGui)
  sightexports.sGui:setLabelAlignment(label, "left", "center")
  sightexports.sGui:setLabelText(label, "Egyenleg:")
  sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
  atmBalance = sightexports.sGui:createGuiElement("label", 590, 48, 0, 35, atmGui)
  sightexports.sGui:setLabelAlignment(atmBalance, "right", "center")
  sightexports.sGui:setLabelText(atmBalance, "betöltés folyamatban")
  sightexports.sGui:setLabelFont(atmBalance, "12/Ubuntu-R.ttf")
  if atmPhoneTopUp then
    local label = sightexports.sGui:createGuiElement("label", 300, 275, 0, 0, atmGui)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelText(label, "SightCom egyenlegfeltöltés")
    sightexports.sGui:setLabelFont(label, "12/Ubuntu-R.ttf")
  elseif not atmDatas[id].skin then
    limitLabel = sightexports.sGui:createGuiElement("label", 300, 249, 0, 76, atmGui)
    sightexports.sGui:setLabelAlignment(limitLabel, "center", "center")
    sightexports.sGui:setLabelText(limitLabel, "")
    sightexports.sGui:setLabelFont(limitLabel, "12/Ubuntu-R.ttf")
  end
  if atmPhoneTopUp then
    phoneInput = sightexports.sGui:createGuiElement("input", 156, 300, 288, 46, atmGui)
    sightexports.sGui:setInputColor(phoneInput, "sightmidgrey", transp, transp, transp, "#000000")
    sightexports.sGui:setInputFont(phoneInput, "12/Ubuntu-R.ttf")
    sightexports.sGui:setInputPlaceholder(phoneInput, "Telefonszám")
    sightexports.sGui:setInputMaxLength(phoneInput, 20)
    sightexports.sGui:setInputDisableBorder(phoneInput, true)
    atmInput = sightexports.sGui:createGuiElement("input", 156, 358, 288, 46, atmGui)
    sightexports.sGui:setInputColor(atmInput, "sightmidgrey", transp, transp, transp, "#000000")
    sightexports.sGui:setInputFont(atmInput, "12/Ubuntu-R.ttf")
    sightexports.sGui:setInputPlaceholder(atmInput, "Összeg")
    sightexports.sGui:setInputMaxLength(atmInput, 10)
    sightexports.sGui:setInputNumberOnly(atmInput, true)
    sightexports.sGui:setInputDisableBorder(atmInput, true)
    sightexports.sGui:setInputChangeEvent(atmInput, "changeATMInput")
  else
    atmInput = sightexports.sGui:createGuiElement("input", 156, 325, 288, 46, atmGui)
    sightexports.sGui:setInputColor(atmInput, "sightmidgrey", transp, transp, transp, "#000000")
    sightexports.sGui:setInputFont(atmInput, "12/Ubuntu-R.ttf")
    sightexports.sGui:setInputPlaceholder(atmInput, "Összeg")
    sightexports.sGui:setInputMaxLength(atmInput, 10)
    sightexports.sGui:setInputNumberOnly(atmInput, true)
    sightexports.sGui:setInputDisableBorder(atmInput, true)
    sightexports.sGui:setInputChangeEvent(atmInput, "changeATMInput")
    atmInputLabel = sightexports.sGui:createGuiElement("label", 300, 379, 0, 0, atmGui)
    sightexports.sGui:setLabelAlignment(atmInputLabel, "center", "top")
    sightexports.sGui:setLabelText(atmInputLabel, "azaz 0 $")
    sightexports.sGui:setLabelFont(atmInputLabel, "12/Ubuntu-R.ttf")
  end
  local btn = sightexports.sGui:createGuiElement("image", 558, 10, 32, 32, atmGui)
  sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("times", 32))
  sightexports.sGui:setGuiHoverable(btn, true)
  sightexports.sGui:setGuiHover(btn, "solid", "sightred")
  sightexports.sGui:setClickEvent(btn, "closeATMPanel")
  if atmPhoneTopUp then
    btnBg1 = sightexports.sGui:createGuiElement("image", 172, 464, 256, 128, atmGui)
    sightexports.sGui:setImageDDS(btnBg1, ":sBank/files/btn.dds")
    sightexports.sGui:setImageColor(btnBg1, "#369cd7")
    atmBtn1 = sightexports.sGui:createGuiElement("button", 11, 34, 234, 60, btnBg1)
    sightexports.sGui:setGuiBackground(atmBtn1, "solid", transp)
    sightexports.sGui:setGuiHover(atmBtn1, "none", false, false, true)
    sightexports.sGui:setButtonFont(atmBtn1, "16/BebasNeueBold.otf")
    sightexports.sGui:setButtonText(atmBtn1, " Visszalépés")
    sightexports.sGui:setButtonIcon(atmBtn1, sightexports.sGui:getFaIconFilename("step-backward", 60))
    sightexports.sGui:setClickEvent(atmBtn1, "atmTogglePhoneTopUp")
    sightexports.sGui:setHoverEvent(atmBtn1, "atmBtnHover")
    btnBg3 = sightexports.sGui:createGuiElement("image", 172, 390, 256, 128, atmGui)
    sightexports.sGui:setImageDDS(btnBg3, ":sBank/files/btn.dds")
    sightexports.sGui:setImageColor(btnBg3, "#36d7b7")
    atmBtn3 = sightexports.sGui:createGuiElement("button", 11, 34, 234, 60, btnBg3)
    sightexports.sGui:setGuiBackground(atmBtn3, "solid", {
      0,
      0,
      0,
      0
    })
    sightexports.sGui:setGuiHover(atmBtn3, "none", false, false, true)
    sightexports.sGui:setButtonFont(atmBtn3, "16/BebasNeueBold.otf")
    sightexports.sGui:setButtonText(atmBtn3, " Egyenlegfeltöltés")
    sightexports.sGui:setButtonIcon(atmBtn3, sightexports.sGui:getFaIconFilename("phone", 60))
    sightexports.sGui:setClickEvent(atmBtn3, "finalAtmTopUpPhone")
    sightexports.sGui:setHoverEvent(atmBtn3, "atmBtnHover")
  else
    btnBg1 = sightexports.sGui:createGuiElement("image", 44, 390, 256, 128, atmGui)
    sightexports.sGui:setImageDDS(btnBg1, ":sBank/files/btn.dds")
    sightexports.sGui:setImageColor(btnBg1, "#369cd7")
    atmBtn1 = sightexports.sGui:createGuiElement("button", 11, 34, 234, 60, btnBg1)
    sightexports.sGui:setGuiBackground(atmBtn1, "solid", transp)
    sightexports.sGui:setGuiHover(atmBtn1, "none", false, false, true)
    sightexports.sGui:setButtonFont(atmBtn1, "16/BebasNeueBold.otf")
    sightexports.sGui:setButtonText(atmBtn1, " Pénzfelvétel")
    sightexports.sGui:setButtonIcon(atmBtn1, sightexports.sGui:getFaIconFilename("inbox-out", 60))
    sightexports.sGui:setClickEvent(atmBtn1, "atmPayOut")
    sightexports.sGui:setHoverEvent(atmBtn1, "atmBtnHover")
    btnBg2 = sightexports.sGui:createGuiElement("image", 300, 390, 256, 128, atmGui)
    sightexports.sGui:setImageDDS(btnBg2, ":sBank/files/btn.dds")
    sightexports.sGui:setImageColor(btnBg2, "#369cd7")
    atmBtn2 = sightexports.sGui:createGuiElement("button", 11, 34, 234, 60, btnBg2)
    sightexports.sGui:setGuiBackground(atmBtn2, "solid", {
      0,
      0,
      0,
      0
    })
    sightexports.sGui:setGuiHover(atmBtn2, "none", false, false, true)
    sightexports.sGui:setButtonFont(atmBtn2, "16/BebasNeueBold.otf")
    sightexports.sGui:setButtonText(atmBtn2, " Pénzbefizetés")
    sightexports.sGui:setButtonIcon(atmBtn2, sightexports.sGui:getFaIconFilename("inbox-in", 60))
    sightexports.sGui:setClickEvent(atmBtn2, "atmPayIn")
    sightexports.sGui:setHoverEvent(atmBtn2, "atmBtnHover")
    btnBg3 = sightexports.sGui:createGuiElement("image", 172, 464, 256, 128, atmGui)
    sightexports.sGui:setImageDDS(btnBg3, ":sBank/files/btn.dds")
    sightexports.sGui:setImageColor(btnBg3, "#36d7b7")
    atmBtn3 = sightexports.sGui:createGuiElement("button", 11, 34, 234, 60, btnBg3)
    sightexports.sGui:setGuiBackground(atmBtn3, "solid", {
      0,
      0,
      0,
      0
    })
    sightexports.sGui:setGuiHover(atmBtn3, "none", false, false, true)
    sightexports.sGui:setButtonFont(atmBtn3, "16/BebasNeueBold.otf")
    sightexports.sGui:setButtonText(atmBtn3, " SightCom egyenlegfeltöltés")
    sightexports.sGui:setButtonIcon(atmBtn3, sightexports.sGui:getFaIconFilename("phone", 60))
    sightexports.sGui:setClickEvent(atmBtn3, "atmTogglePhoneTopUp")
    sightexports.sGui:setHoverEvent(atmBtn3, "atmBtnHover")
  end
  atmLoader = sightexports.sGui:createGuiElement("image", 276, 467, 48, 48, atmGui)
  sightexports.sGui:setImageFile(atmLoader, sightexports.sGui:getFaIconFilename("circle-notch", 48))
  sightexports.sGui:setImageSpinner(atmLoader, true)
  sightexports.sGui:setGuiRenderDisabled(atmLoader, true)
  local image = sightexports.sGui:createGuiElement("image", 0, 0, 600, 600, atmGui)
  sightexports.sGui:setImageDDS(image, ":sBank/files/over.dds")
  if loadingState or loadingBalance then
    refreshInputShown()
  end
  currentATM = id
end
function refreshInputShown()
  local hidden = false
  if loadingState or loadingBalance then
    sightexports.sGui:setActiveInput()
    hidden = true
  end
  sightexports.sGui:setGuiHoverable(atmInput, not hidden)
  if phoneInput then
    sightexports.sGui:setGuiHoverable(phoneInput, not hidden)
  end
  sightexports.sGui:setGuiRenderDisabled(atmLoader, not hidden)
  sightexports.sGui:setGuiRenderDisabled(btnBg1, hidden)
  sightexports.sGui:setGuiRenderDisabled(atmBtn1, hidden)
  if btnBg2 then
    sightexports.sGui:setGuiRenderDisabled(btnBg2, hidden)
  end
  if atmBtn2 then
    sightexports.sGui:setGuiRenderDisabled(atmBtn2, hidden)
  end
  sightexports.sGui:setGuiRenderDisabled(btnBg3, hidden)
  sightexports.sGui:setGuiRenderDisabled(atmBtn3, hidden)
end
local testObj = false
function preRenderAtm()
  local x, y, z = getElementPosition(localPlayer)
  local rx, ry, rz = getElementRotation(localPlayer)
  local int = getElementInterior(localPlayer)
  local dim = getElementDimension(localPlayer)
  rz = math.floor(rz / 5) * 5
  setElementPosition(testObj, x, y, z - 0.355)
  setElementRotation(testObj, 0, 0, rz)
  setElementInterior(testObj, int)
  setElementDimension(testObj, dim)
  if getKeyState("lctrl") then
    if isElement(testObj) then
      destroyElement(testObj)
    end
    testObj = false
    removeEventHandler("onClientPreRender", getRootElement(), preRenderAtm)
    sightexports.sGui:showInfobox("i", "Megszakítva.")
  elseif getKeyState("lalt") then
    sightexports.sGui:showInfobox("i", "Lerakva.")
    if isElement(testObj) then
      destroyElement(testObj)
    end
    testObj = false
    removeEventHandler("onClientPreRender", getRootElement(), preRenderAtm)
    local file = false
    if fileExists("!atm.sight") then
      file = fileOpen("!atm.sight")
      fileSetPos(file, fileGetSize(file))
    else
      file = fileCreate("!atm.sight")
    end
    fileWrite(file, "{[\"pos\"] = {" .. table.concat({
      x,
      y,
      z,
      rz,
      int,
      dim
    }, ", ") .. "},},\n")
    local obj = createObject(models.v4_atm, x, y, z - 0.355, 0, 0, rz)
    setElementInterior(obj, int)
    setElementDimension(obj, dim)
    setElementCollisionsEnabled(obj, false)
    createBlip(x, y, z)
    fileClose(file)
  elseif getKeyState("ralt") then
    sightexports.sGui:showInfobox("i", "Lerakva protectelve.")
    if isElement(testObj) then
      destroyElement(testObj)
    end
    testObj = false
    removeEventHandler("onClientPreRender", getRootElement(), preRenderAtm)
    local file = false
    if fileExists("!atm.sight") then
      file = fileOpen("!atm.sight")
      fileSetPos(file, fileGetSize(file))
    else
      file = fileCreate("!atm.sight")
    end
    fileWrite(file, "{[\"pos\"] = {" .. table.concat({
      x,
      y,
      z,
      rz,
      int,
      dim
    }, ", ") .. "}, [\"protected\"] = true}, --protect\n")
    local obj = createObject(models.v4_atm, x, y, z - 0.355, 0, 0, rz)
    setElementInterior(obj, int)
    setElementDimension(obj, dim)
    setElementCollisionsEnabled(obj, false)
    createBlip(x, y, z)
    fileClose(file)
  end
end
addCommandHandler("createatm", function()
  if sightexports.sPermission:hasPermission(localPlayer, "createatm") and not isElement(testObj) then
    outputChatBox("[color=sightgreen][SightMTA]: #FFFFFFATM létrehozás: Bal CTRL = Mégse | Bal ALT = Lerakás | Jobb ALT = Lerakás (protectelve)", 255, 255, 255, true)
    testObj = createObject(models.v4_atm, 0, 0, 0, 0, 0, 0)
    setElementCollisionsEnabled(testObj, false)
    addEventHandler("onClientPreRender", getRootElement(), preRenderAtm)
  end
end)
addCommandHandler("nearbyatms", function()
  if sightexports.sPermission:hasPermission(localPlayer, "nearbyatms") then
    outputChatBox("[color=sightgreen][SightMTA]: #FFFFFFATM-ek a közeledben:", 255, 255, 255, true)
    for i = 1, #atmDatas do
      local data = atmDatas[i]
      local x, y, z = unpack(data.pos)
      local px, py, pz = getElementPosition(localPlayer)
      local dist = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
      if dist < 30 then
        local protect = data.protected and " [color=sightgreen](protectelve)" or ""
        outputChatBox("- #FFFFFFID: [color=sightblue]" .. i .. "#FFFFFF | Távolság: [color=sightblue]" .. math.floor(dist) .. "m#FFFFFF " .. protect, 255, 255, 255, true)
      end
    end
  end
end)