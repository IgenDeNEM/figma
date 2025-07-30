local sightexports = {
  sPattach = false,
  sGui = false,
  sItems = false,
  sModloader = false,
  sCore = false
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
local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processsightlangStaticImage = {}
sightlangStaticImageToc[0] = true
sightlangStaticImageToc[1] = true
sightlangStaticImageToc[2] = true
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
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/glass.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/blinds.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/gold.dds", "argb", true)
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
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sItems")
    if res0 and getResourceState(res0) == "running" then
      processItemPics()
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
local vaultTex = {}
local elev, ledTex, flameTex, collisionsmoke
local blowSounds = {}
function createTex()
  deleteTex()
  vaultTex[1] = dxCreateTexture("files/vault/1.dds", "dxt1")
  vaultTex[2] = dxCreateTexture("files/vault/2.dds", "dxt1")
  vaultTex[3] = dxCreateTexture("files/vault/3.dds", "dxt1")
  vaultTex[4] = dxCreateTexture("files/vault/4.dds", "dxt1")
  vaultTex[5] = dxCreateTexture("files/vault/5.dds", "dxt5")
  elev = dxCreateTexture("files/elev.dds")
  ledTex = dxCreateTexture("files/led.dds")
  collisionsmoke = dxCreateTexture("files/collisionsmoke.dds")
  flameTex = dxCreateTexture("files/flame.dds")
end
function deleteTex()
  for i = 1, #vaultTex do
    if isElement(vaultTex[i]) then
      destroyElement(vaultTex[i])
    end
    vaultTex[i] = nil
  end
  if isElement(elev) then
    destroyElement(elev)
  end
  elev = false
  if isElement(ledTex) then
    destroyElement(ledTex)
  end
  ledTex = false
  if isElement(collisionsmoke) then
    destroyElement(collisionsmoke)
  end
  collisionsmoke = false
  if isElement(flameTex) then
    destroyElement(flameTex)
  end
  flameTex = false
  for client in pairs(blowSounds) do
    setSoundVolume(blowSounds[client], 0)
  end
end
local streamedInSecuricars = {}
local securicarHover = false
local securicarCrateHover = false
local crateData = {}
local crateObjects = {}
local crateVehicle = {}
local vehicleCrates = {}
local goldBoxQ = {
  0.5102887485885,
  0.51160917434455,
  -0.6096257833934,
  -0.32591080069929
}
local selfCrate = false
inBankHover = false
local inBankVaultHover = false
local inBankVaultPointHover = false
local inBankBarHover = false
local goldBars = {}
local goldBarObjects = {}
local crateInElev = {}
local crateGold = {}
local goldBarCrates = {}
function gotGoldrobCrateData(id, data)
  if crateData[id] == localPlayer then
    selfCrate = false
    securicarHover = false
  end
  crateData[id] = data
  crateInElev[id] = nil
  local model = crateGold[id] and "v4_goldbox2" or "v4_goldbox1"
  if isElement(data) then
    if models then
      if not isElement(crateObjects[id]) then
        crateObjects[id] = createObject(models[model], 0, 0, 0)
      end
      if data == localPlayer then
        selfCrate = id
        securicarHover = false
      end
      sightexports.sPattach:detach(crateObjects[id])
      sightexports.sPattach:attach(crateObjects[id], data, 25, 0.1698296027643, -0.014056156163885, -0.0075286102126841, 0, 0, 0)
      sightexports.sPattach:setRotationQuaternion(crateObjects[id], goldBoxQ)
      setElementCollisionsEnabled(crateObjects[id], false)
    end
  elseif type(data) == "table" then
    if models then
      if not isElement(crateObjects[id]) then
        crateObjects[id] = createObject(models[model], data[1], data[2], data[3], 0, 0, data[4])
      else
        sightexports.sPattach:detach(crateObjects[id])
        setElementPosition(crateObjects[id], data[1], data[2], data[3])
        setElementRotation(crateObjects[id], 0, 0, data[4])
      end
      setElementCollisionsEnabled(crateObjects[id], false)
      crateInElev[id] = isInElev(data[1], data[2], data[3])
    end
  else
    if isElement(crateObjects[id]) then
      destroyElement(crateObjects[id])
    end
    crateObjects[id] = nil
  end
end
addEvent("gotGoldrobCrateData", true)
addEventHandler("gotGoldrobCrateData", getRootElement(), gotGoldrobCrateData)
addEvent("gotGoldrobCrateDataAll", true)
addEventHandler("gotGoldrobCrateDataAll", getRootElement(), function(data)
  for id in pairs(crateObjects) do
    if isElement(crateObjects[id]) then
      destroyElement(crateObjects[id])
    end
    crateObjects[id] = nil
  end
  crateData = {}
  for id, dat in pairs(data) do
    gotGoldrobCrateData(id, dat)
  end
end)
function gotGoldrobCrateVehicle(id, veh)
  local oldVeh = crateVehicle[id]
  if oldVeh and vehicleCrates[oldVeh] then
    for i = #vehicleCrates[oldVeh], 1, -1 do
      if vehicleCrates[oldVeh][i] == id then
        table.remove(vehicleCrates[oldVeh], i)
      end
    end
  end
  crateVehicle[id] = veh
  if isElement(veh) then
    if not vehicleCrates[veh] then
      vehicleCrates[veh] = {}
    end
    table.insert(vehicleCrates[veh], id)
  end
end
addEvent("gotGoldrobCrateVehicle", true)
addEventHandler("gotGoldrobCrateVehicle", getRootElement(), gotGoldrobCrateVehicle)
addEvent("gotGoldrobCrateVehicleAll", true)
addEventHandler("gotGoldrobCrateVehicleAll", getRootElement(), function(data)
  crateVehicle = {}
  for id, veh in pairs(data) do
    gotGoldrobCrateVehicle(id, veh)
  end
end)
function refreshGoldBar(id)
  local i = goldBars[id]
  if i and goldBarPositions[i] and not goldBarCrates[id] and models then
    if isElement(goldBarObjects[id]) then
      setElementPosition(goldBarObjects[id], goldBarPositions[i][1], goldBarPositions[i][2], goldBarPositions[i][3])
      setElementRotation(goldBarObjects[id], 0, 0, goldBarPositions[i][4])
    else
      goldBarObjects[id] = createObject(models.v4_goldbar, goldBarPositions[i][1], goldBarPositions[i][2], goldBarPositions[i][3], 0, 0, goldBarPositions[i][4])
    end
  else
    if isElement(goldBarObjects[id]) then
      destroyElement(goldBarObjects[id])
    end
    goldBarObjects[id] = nil
  end
end
function gotGoldrobGoldBarAll(bars)
  local toRefresh = {}
  for id in pairs(goldBars) do
    toRefresh[id] = true
  end
  goldBars = {}
  for id, pos in pairs(bars) do
    goldBars[id] = pos
    toRefresh[id] = true
  end
  for id in pairs(toRefresh) do
    refreshGoldBar(id)
  end
end
addEvent("gotGoldrobGoldBarAll", true)
addEventHandler("gotGoldrobGoldBarAll", getRootElement(), gotGoldrobGoldBarAll)
addEvent("gotGoldrobGoldBar", true)
addEventHandler("gotGoldrobGoldBar", getRootElement(), function(id, pos)
  goldBars[id] = pos
  refreshGoldBar(id)
end)
addEvent("gotGoldrobCrateGold", true)
addEventHandler("gotGoldrobCrateGold", getRootElement(), function(id, bar)
  if crateGold[id] then
    goldBarCrates[crateGold[id]] = nil
    refreshGoldBar(crateGold[id])
  end
  crateGold[id] = bar
  if bar then
    goldBarCrates[bar] = id
    refreshGoldBar(bar)
    local s = playSound3D("files/loot" .. math.random(1, 2) .. ".mp3", goldBarPositions[bar][1], goldBarPositions[bar][2], goldBarPositions[bar][3])
    setSoundMaxDistance(s, 15)
  end
  local model = crateGold[id] and "v4_goldbox2" or "v4_goldbox1"
  if models then
      if isElement(crateObjects[id]) then
          local attachedTo = crateData and crateData[id]
          destroyElement(crateObjects[id])
          crateObjects[id] = nil

          if isElement(attachedTo) then
              crateObjects[id] = createObject(models[model], 0,0,0)
              sightexports.sPattach:attach(crateObjects[id], attachedTo, 25,
                  0.1698296027643, -0.014056156163885, -0.0075286102126841, 0,0,0)
              sightexports.sPattach:setRotationQuaternion(crateObjects[id], goldBoxQ)
              setElementCollisionsEnabled(crateObjects[id], false)
          end
      end
  end
end)
addEvent("gotGoldrobCrateGoldAll", true)
addEventHandler("gotGoldrobCrateGoldAll", getRootElement(), function(dat)
  local toRefresh = {}
  for id, bar in pairs(crateGold) do
    if not dat[id] then
      toRefresh[bar] = true
      local model = "v4_goldbox1"
      if models and isElement(crateObjects[id]) then
          local attachedTo = crateData and crateData[id]
          destroyElement(crateObjects[id])
          crateObjects[id] = nil
          if isElement(attachedTo) then
              crateObjects[id] = createObject(models[model], 0,0,0)
              sightexports.sPattach:attach(crateObjects[id], attachedTo, 25,
                  0.1698296027643, -0.014056156163885, -0.0075286102126841, 0,0,0)
              sightexports.sPattach:setRotationQuaternion(crateObjects[id], goldBoxQ)
              setElementCollisionsEnabled(crateObjects[id], false)
          end
      end
    end
  end
  crateGold = {}
  goldBarCrates = {}
  for id, bar in pairs(dat) do
    crateGold[id] = bar
    goldBarCrates[bar] = id
    toRefresh[bar] = true
    local model = crateGold[id] and "v4_goldbox2" or "v4_goldbox1"
    if isElement(crateObjects[id]) and models then
      setElementModel(crateObjects[id], models[model])
    end
  end
  for bar in pairs(toRefresh) do
    refreshGoldBar(bar)
  end
end)
local vaultPry = {}
for i = 1, #vaultPoses do
  vaultPry[i] = {}
  for j = 1, #vaultOffsets do
    vaultPry[i][j] = {}
  end
end
function goldrobSyncVaultOpenAll(dat, loot)
  if dat then
    vaultOpened = dat
    vaultLoot = {}
    for i = 1, #vaultObjectPoses do
      vaultLoot[i] = {}
    end
    for i in pairs(loot) do
      for j, l in pairs(loot[i]) do
        vaultLoot[i][j] = l
      end
    end
  else
    vaultOpened = {}
    vaultLoot = {}
    for i = 1, #vaultObjectPoses do
      vaultOpened[i] = {}
      vaultLoot[i] = {}
    end
  end
end
addEvent("goldrobSyncVaultOpenAll", true)
addEventHandler("goldrobSyncVaultOpenAll", getRootElement(), goldrobSyncVaultOpenAll)
addEvent("goldrobFailedVaultOpen", true)
addEventHandler("goldrobFailedVaultOpen", getRootElement(), function(i, j)
  vaultPry[i][j] = {}
end)
addEvent("goldrobSyncVaultHit", true)
addEventHandler("goldrobSyncVaultHit", getRootElement(), function(i, j, k)
  local x, y, z = vaultPoses[i][j][1], vaultPoses[i][j][2], vaultPoses[i][j][3]
  local r = vaultPoses[i][j][4]
  x = x - math.sin(r) * 0.416588 * 2
  y = y + math.cos(r) * 0.416588 * 2
  local s = playSound3D("files/hit" .. math.random(1, 4) .. ".mp3", x, y, z)
  setSoundMaxDistance(s, 35)
  if k then
    vaultPry[i][j][k] = 2
  end
end)
addEvent("goldrobSyncVaultOpen", true)
addEventHandler("goldrobSyncVaultOpen", getRootElement(), function(i, j, loot)
  if inBankCol then
    local x, y, z = vaultPoses[i][j][1], vaultPoses[i][j][2], vaultPoses[i][j][3]
    local r = vaultPoses[i][j][4]
    x = x - math.sin(r) * 0.416588 * 2
    y = y + math.cos(r) * 0.416588 * 2
    local s = playSound3D("files/svault.mp3", x, y, z)
    setSoundMaxDistance(s, 35)
    local s = playSound3D("files/hit" .. math.random(1, 4) .. ".mp3", x, y, z)
    setSoundMaxDistance(s, 35)
  end
  local px, py, pz = getElementPosition(localPlayer)
  vaultOpened[i][j] = pz < 1 and getTickCount() or true
  vaultLoot[i][j] = loot
end)
addEvent("goldrobSyncVaultLooted", true)
addEventHandler("goldrobSyncVaultLooted", getRootElement(), function(i, j)
  if inBankCol then
    local x, y, z = vaultPoses[i][j][1], vaultPoses[i][j][2], vaultPoses[i][j][3]
    local r = vaultPoses[i][j][4]
    x = x - math.sin(r) * 0.416588 * 2
    y = y + math.cos(r) * 0.416588 * 2
    local s = playSound3D("files/loot" .. math.random(1, 2) .. ".mp3", x, y, z)
    setSoundMaxDistance(s, 15)
  end
  vaultLoot[i][j] = nil
end)
local barHeat = {}
local barCut = {}
local barHeating = {}
barNum = 0
for i = 1, 14 do
  barHeat[i] = 0
  barCut[i] = 0
end
local blowObjects = {}
local blowMetal = {}
local blowTimers = {}
function setBlowMetal(client, state)
  if isElement(blowMetal[client]) then
    setSoundVolume(blowMetal[client], state and 1.5 or 0)
  end
end
function startBlowLoop(client)
  if isElement(blowObjects[client]) then
    if isElement(blowSounds[client]) and isSoundLooped(blowSounds[client]) then
      destroyElement(blowSounds[client])
    end
    local x, y, z = getElementPosition(blowObjects[client])
    blowSounds[client] = playSound3D("files/blowloop.mp3", x, y, z, true)
    attachElements(blowSounds[client], blowObjects[client])
    setSoundVolume(blowSounds[client], 0)
  else
    if isElement(blowSounds[client]) then
      destroyElement(blowSounds[client])
    end
    blowSounds[client] = nil
  end
  blowTimers[client] = nil
end
function gotBlowtorchObject(client, obj)
  blowObjects[client] = obj
  if isTimer(blowTimers[client]) then
    killTimer(blowTimers[client])
  end
  if isElement(blowSounds[client]) then
    destroyElement(blowSounds[client])
  end
  blowSounds[client] = nil
  if isElement(blowMetal[client]) then
    destroyElement(blowMetal[client])
  end
  blowMetal[client] = nil
  if isElement(obj) then
    local x, y, z = getElementPosition(obj)
    blowSounds[client] = playSound3D("files/blowstart.mp3", x, y, z)
    setSoundVolume(blowSounds[client], 0)
    blowMetal[client] = playSound3D("files/blowmetal.mp3", x, y, z, true)
    setSoundVolume(blowMetal[client], 0)
    blowTimers[client] = setTimer(startBlowLoop, 210, 1, client)
    attachElements(blowSounds[client], blowObjects[client])
    attachElements(blowMetal[client], blowObjects[client])
  end
end
function clickInBank(key, state)
  if state == "down" then
    local now = getTickCount()
    if inBankBarHover then
      if now - lastClick > 500 then
        if not getElementData(localPlayer, "usingBlowTorch") then
          sightexports.sGui:showInfobox("e", "Nincs nálad lángvágó!")
          return
        end
        if not barHeating[inBankBarHover] then
          lastClick = getTickCount()
          barHeating[inBankBarHover] = localPlayer
          setBlowMetal(localPlayer, true)
          triggerServerEvent("syncGoldrobBarHeat", localPlayer, inBankBarHover)
        end
      end
    elseif inBankVaultHover then
      if now - lastClick > 200 then
        local hammer = sightexports.sItems:playerHasItem(34)
        local chisel = sightexports.sItems:playerHasItem(362)
        if hammer and chisel then
          local i, j, k = inBankHover, inBankVaultHover, inBankVaultPointHover
          if vaultOpened[i][j] then
            if vaultLoot[i][j] then
              triggerServerEvent("goldrobLootVault", localPlayer, i, j)
            end
          elseif not vaultPry[i][j][k] or vaultPry[i][j][k] < 1 then
            lastClick = now
            vaultPry[i][j][k] = (vaultPry[i][j][k] or 0) + 0.4
            local final = true
            for k = -1, 1 do
              if not vaultPry[i][j][k] or vaultPry[i][j][k] < 1 then
                final = nil
              end
            end
            triggerServerEvent("goldrobSyncVaultHit", localPlayer, i, j, 1 <= vaultPry[i][j][k] and k or nil, final)
          end
        elseif hammer then
          sightexports.sGui:showInfobox("e", "Nincs nálad véső!")
        elseif chisel then
          sightexports.sGui:showInfobox("e", "Nincs nálad kalapács!")
        else
          sightexports.sGui:showInfobox("e", "Nincs nálad kalapács és véső!")
        end
      end
    elseif now - lastClick > 500 then
      if inBankHover == "laserkey" then
        openKeypad("laser")
      elseif inBankHover == "doorkey" then
        openKeypad("door")
      elseif inBankHover == "doorhack" then
        lastClick = now
        triggerServerEvent("tryToHackGoldrobInside", localPlayer)
      elseif inBankHover == "doorreleasepd" then
        lastClick = now
        triggerServerEvent("goldrobReleaseDoorPD", localPlayer)
      elseif inBankHover == "doorrelease" then
        lastClick = now
        triggerServerEvent("goldrobReleaseInsideDoor", localPlayer)
      elseif inBankHover == "mute" then
        lastClick = now
        triggerServerEvent("goldrobMuteAlarm", localPlayer)
      elseif inBankHover == "npcfear" then
        lastClick = now
        triggerServerEvent("goldrobStartNPCMinigame", localPlayer)
      elseif inBankHover == "destroy" then
        lastClick = now
        triggerServerEvent("goldrobDestroyCrate", localPlayer)
      elseif inBankHover == "elev" then
        lastClick = now
        triggerServerEvent("goldrobBankElevator", localPlayer)
      elseif inBankHover == "roofdoor" then
        lastClick = now
        triggerServerEvent("goldrobToggleRoofDoor", localPlayer)
      elseif inBankHover == "backdoor" then
        lastClick = now
        triggerServerEvent("goldrobToggleBackDoor", localPlayer)
      elseif inBankHover == "bigdoor" then
        lastClick = now
        triggerServerEvent("goldrobStartWheelMinigame", localPlayer)
      elseif inBankHover then
        lastClick = now
        if selfCrate then
          triggerServerEvent("pickUpGoldBar", localPlayer, inBankHover)
        else
          triggerServerEvent("pickUpGoldCrate", localPlayer, inBankHover)
        end
      end
    end
  elseif state == "up" and inBankBarHover and barHeating[inBankBarHover] == localPlayer then
    triggerServerEvent("syncGoldrobBarHeat", localPlayer)
    barHeating[inBankBarHover] = nil
    setBlowMetal(localPlayer, false)
  end
end
local elevX, elevY, elevZ = 0, 0, 0
function keyInBank(key, state)
  if selfCrate and key == "f" then
    if state then
      local x, y, z = getElementPosition(localPlayer)
      local rx, ry, rz = getElementRotation(localPlayer)
      rz = math.rad(rz)
      x = x + math.cos(rz + math.pi / 2) * 0.5
      y = y + math.sin(rz + math.pi / 2) * 0.5
      z = getGroundPosition(x, y, z)
      for id, dat in pairs(crateData) do
        if type(dat) == "table" then
          local cx, cy, cz = dat[1], dat[2], dat[3]
          if crateInElev[id] then
            cz = elevZ - 1.45
          end
          if getDistanceBetweenPoints3D(x, y, z, cx, cy, cz) <= 0.4 then
            if isInElev(x, y, z) then
              return
            else
              z = z + 0.076966
            end
          end
        end
      end
      local camx, camy, camz = getCameraMatrix()
      if isLineOfSightClear(x, y, z + 0.125, camx, camy, camz, true, true, false, true, false, false, false) then
        triggerServerEvent("putDownGoldCrate", localPlayer, x, y, z, math.deg(rz))
      end
    end
    cancelEvent()
  end
end
vaultBarsCut = {}
function moveBar2()
  stopObject(vaultBars)
  setElementRotation(vaultBars, -90, 0, vaultBarsDestroyedPos[4] - 15.5368)
  moveObject(vaultBars, 250, vaultBarsDestroyedPos[1], vaultBarsDestroyedPos[2], vaultBarsDestroyedPos[3], 0, 0, 0, "OutQuad")
end
addEvent("syncGoldrobBarCut", true)
addEventHandler("syncGoldrobBarCut", getRootElement(), function(i)
  if not vaultBarsCut[i] then
    vaultBarsCut[i] = true
    if isElement(vaultBarPieces[i]) then
      destroyElement(vaultBarPieces[i])
      barNum = barNum - 1
    end
    vaultBarPieces[i] = nil
    processBarShader()
    if barNum <= 0 then
      setElementRotation(vaultBars, 0, 0, vaultBarsDestroyedPos[4])
      setElementCollisionsEnabled(vaultBars, false)
      local s = playSound3D("files/metaldoorfall.mp3", vaultBarsDestroyedPos[1], vaultBarsDestroyedPos[2], vaultBarsDestroyedPos[3])
      attachElements(s, vaultBars)
      setSoundMaxDistance(s, 40)
      moveObject(vaultBars, 500, vaultBarsDestroyedPos[1], vaultBarsDestroyedPos[2], vaultBarsDestroyedPos[3], -90, 0, -15.5368)
      setTimer(moveBar2, 500, 1)
    end
  end
end)
function refershBars()
  barNum = 0
  if not vaultBarsCut then
    vaultBarsCut = {}
  end
  for i = 1, 14 do
    if not vaultBarsCut[i] then
      if not isElement(vaultBarPieces[i]) then
        vaultBarPieces[i] = createObject(sightexports.sModloader:getModelId("v4_goldbank_vault_cuts" .. i), vaultBarsPos[1], vaultBarsPos[2], vaultBarsPos[3], 0, 0, vaultBarsPos[4])
        setElementCollisionsEnabled(vaultBarPieces[i], false)
      end
      barNum = barNum + 1
    else
      if isElement(vaultBarPieces[i]) then
        destroyElement(vaultBarPieces[i])
      end
      vaultBarPieces[i] = nil
    end
  end
  if barNum <= 0 then
    setElementCollisionsEnabled(vaultBars, false)
    setElementPosition(vaultBars, vaultBarsDestroyedPos[1], vaultBarsDestroyedPos[2], vaultBarsDestroyedPos[3])
    setElementRotation(vaultBars, -90, 0, vaultBarsDestroyedPos[4] - 15.5368)
  else
    setElementCollisionsEnabled(vaultBars, true)
    setElementPosition(vaultBars, vaultBarsPos[1], vaultBarsPos[2], vaultBarsPos[3])
    setElementRotation(vaultBars, 0, 0, vaultBarsPos[4])
  end
  processBarShader()
end
function syncGoldrobAllBarCut(d)
  vaultBarsCut = d
  refershBars()
end
addEvent("syncGoldrobAllBarCut", true)
addEventHandler("syncGoldrobAllBarCut", getRootElement(), syncGoldrobAllBarCut)
addEvent("syncGoldrobBarHeat", true)
addEventHandler("syncGoldrobBarHeat", getRootElement(), function(i, el)
  if el ~= localPlayer then
    if isElement(barHeating[i]) then
      setBlowMetal(barHeating[i], false)
    end
    barHeating[i] = el
    if isElement(el) then
      setBlowMetal(el, true)
    end
  end
end)
local inElev = false
local doorProgress = {
  1,
  1,
  1,
  1,
  1,
  1
}
elevDoorsMoving = false
local texShader = [[
	texture gTexture;

	technique tec0
	{
		pass P0
		{
			CullMode = None;
			
			AlphaBlendEnable = True;
			SrcBlend = SrcAlpha;
			DestBlend = InvSrcAlpha;

			Texture[0] = gTexture;
		}
	}

]]
local barShaderSource = [[
	#include "files/mta-helper.fx"

	struct PSInput
	{
		float4 Position : POSITION0;
		float4 Diffuse : COLOR0;
		float2 TexCoord : TEXCOORD0;
	};

	struct VSInput
	{
		float3 Position : POSITION0;
		float4 Diffuse : COLOR0;
		float2 TexCoord : TEXCOORD0;
	};

	texture MaskTexture;

	sampler2D MaskSampler = sampler_state
	{
		Texture = (MaskTexture);
	};

	sampler2D OrigSampler = sampler_state
	{
		Texture = (gTexture0);
	};

	float4 col1 = float4(1, 0.25, 0.25, 1);
	float4 col2 = float4(0.8, 0.5, 0, 1);
	float4 col3 = float4(1, 0.8, 0.8, 1);

	float p1 = 0;
	float p2 = 0.75/2;
	float p3 = 0.75;

	float4 PixelShaderFunction(PSInput PS) : COLOR0
	{
		float4 inp = tex2D(OrigSampler, PS.TexCoord);
		float4 col = inp;
		float4 m = tex2D(MaskSampler, PS.TexCoord);
		float mask = m.r;
		float a = m.g;

		if(mask >= p3)
		{
			float p = (mask-p3)/(1-p3);
			float4 c = lerp(col2, col3, p);

			col = col*c*lerp(0.5, 0.25, p) + c*lerp(0.5, 0.75, p);
		}
		else if(mask >= p2)
		{
			float p = (mask-p2)/(p3-p2);
			float4 c = lerp(col1, col2, p);

			col = col*c*lerp(0.8, 0.5, p) + c*lerp(0.2, 0.5, p);
		}
		else if(mask >= p1)
		{
			float p = (mask-p1)/(p2-p1);
			float4 c = lerp(col3, col1, p);

			col = col*c*lerp(1, 0.8, p) + c*lerp(0, 0.2, p);
		}

		//return float4(PS.TexCoord.x, 0, 0, 1);

		float d = PS.TexCoord.x;

		if(d > 0.5)
			d = (1-d)*2;
		else
			d *= 2;

		float4 output = lerp(inp*PS.Diffuse, col*lerp(PS.Diffuse, 1, min(1, mask*1.25)), d);

		output.a = max(0, 1-a*(d*2))*(1-(mask.r-0.9)/0.1);

		return output;
	}

	technique Technique1 
	{
		pass Pass1 
		{
			AlphaBlendEnable = true;
			AlphaFunc = GreaterEqual;
			PixelShader = compile ps_2_0 PixelShaderFunction(); 
		} 
	}
]]
local barShader = false
local barRt = false
function processBarShader()
  local create = barNum > 0 and inBankCol
  if create then
    if not isElement(barShader) then
      barShader = dxCreateShader(barShaderSource)
    end
    if not isElement(barRt) then
      barRt = dxCreateRenderTarget(8, 128)
    end
    dxSetShaderValue(barShader, "MaskTexture", barRt)
    for i = 1, 14 do
      if isElement(vaultBarPieces[i]) then
        engineApplyShaderToWorldTexture(barShader, "*", vaultBarPieces[i])
      end
    end
  else
    if isElement(barShader) then
      destroyElement(barShader)
    end
    barShader = nil
    if isElement(barRt) then
      destroyElement(barRt)
    end
    barRt = nil
  end
end
sparks = {}
bigDoorOpen = false
local canOpenBigDoor = true
local bigDoorStart = false
local particles = {}
function spawnParticle(x, y, z, dx, dy, dz, life, r, g, b, a, size, sizePlus)
  table.insert(particles, {
    x,
    y,
    z,
    dx,
    dy,
    dz,
    getTickCount(),
    life,
    r,
    g,
    b,
    a,
    size,
    sizePlus
  })
end
local lastWheelClick = 0
addEvent("syncGoldrobBigDoorOpen", true)
addEventHandler("syncGoldrobBigDoorOpen", getRootElement(), function(state, anim, can)
  bigDoorOpen = state
  canOpenBigDoor = can
  if anim and inBankCol then
    bigDoorStart = getTickCount()
    local s = playSound3D("files/bigdoor" .. (state and "open" or "close") .. ".mp3", vaultBigDoorPos[1], vaultBigDoorPos[2], vaultBigDoorPos[3])
    attachElements(s, vaultBigDoor)
    setSoundVolume(s, 1.5)
    setSoundMaxDistance(s, 40)
    local px, py, pz = getElementPosition(localPlayer)
    if pz < 1 then
      if state then
        if alarmState then
          sightexports.sGui:showInfobox("w", "A széf ajtaja " .. bigDoorCloseTime .. " perc múlva bezáródik.")
        else
          sightexports.sGui:showInfobox("w", "A széf ajtaja " .. bigDoorCloseTime .. " perc múlva bezáródik, és elindul a riasztás.")
        end
      else
        sightexports.sGui:showInfobox("w", "A széf ajtaja 10 másodperc múlva bezáródik.")
      end
    end
  else
    bigDoorStart = false
    refreshBigDoorPos()
  end
end)
local glassRT = dxCreateRenderTarget(256, 256, true)
local glassShader = dxCreateShader(texShader)
dxSetShaderValue(glassShader, "gTexture", glassRT)
engineApplyShaderToWorldTexture(glassShader, "v4_goldrob_glass")
engineApplyShaderToWorldTexture(glassShader, "v4_goldrob_glass2")
local blindProg = 0
function refreshGlasses(p)
  if type(p) == "boolean" then
    p = 0
  end
  if not p then
    if inBankCol then
      p = blindProg
    else
      p = alarmState and 1 or 0
      blindProg = p
    end
  end
  dxSetRenderTarget(glassRT, true)
  sightlangStaticImageUsed[0] = true
  if sightlangStaticImageToc[0] then
    processsightlangStaticImage[0]()
  end
  dxDrawImage(0, 0, 256, 256, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 215))
  sightlangStaticImageUsed[1] = true
  if sightlangStaticImageToc[1] then
    processsightlangStaticImage[1]()
  end
  dxDrawImage(0, -256 * (1 - p), 256, 256, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255, 255))
  dxSetRenderTarget()
end
refreshGlasses()
local topDoorP = 0
local neededTopDoorP = 0
local frontDoorP = 0
neededFrontDoorP = 0
frontDoorCol = createColPolygon(frontDoorColPos[1], frontDoorColPos[2], frontDoorColPos[3], frontDoorColPos[4], frontDoorColPos[5], frontDoorColPos[6], frontDoorColPos[7], frontDoorColPos[8], frontDoorColPos[9], frontDoorColPos[10], frontDoorColPos[11], frontDoorColPos[12])
frontDoorCol2 = createColPolygon(frontDoorCol2Pos[1], frontDoorCol2Pos[2], frontDoorCol2Pos[3], frontDoorCol2Pos[4], frontDoorCol2Pos[5], frontDoorCol2Pos[6], frontDoorCol2Pos[7], frontDoorCol2Pos[8], frontDoorCol2Pos[9], frontDoorCol2Pos[10], frontDoorCol2Pos[11], frontDoorCol2Pos[12])
setColPolygonHeight(frontDoorCol, frontDoorColHeight[1], frontDoorColHeight[2])
setColPolygonHeight(frontDoorCol2, frontDoorColHeight[1], frontDoorColHeight[2])
function enterFrontDoor(theElement, matchingDimension)
  if matchingDimension and (getElementType(theElement) == "player") then
    local c = 0
    if not alarmState then
      c = #getElementsWithinColShape(frontDoorCol2, "player")
      if bankOpen then
        c = c + #getElementsWithinColShape(frontDoorCol, "player")
      end
    end
    local tmp = 1 <= c and 1 or 0
    if tmp ~= neededFrontDoorP and not teimoState then
      neededFrontDoorP = tmp
      playFrontDoorSound()
    end
  end
end
addEventHandler("onClientColShapeHit", frontDoorCol, enterFrontDoor)
addEventHandler("onClientColShapeHit", frontDoorCol2, enterFrontDoor)
function enterTeimoFrontDoor(theElement, matchingDimension)
  if matchingDimension and (getElementType(theElement) == "ped") then
    local c = 0
    if not alarmState then
      c = #getElementsWithinColShape(frontDoorCol2, "ped")
      c = c + #getElementsWithinColShape(frontDoorCol, "ped")
    end
    local tmp = 1 <= c and 1 or 0
    if tmp ~= neededFrontDoorP and teimoState then
      neededFrontDoorP = tmp
      playFrontDoorSound()
    end
  end
end
addEventHandler("onClientColShapeHit", frontDoorCol, enterTeimoFrontDoor)
addEventHandler("onClientColShapeHit", frontDoorCol2, enterTeimoFrontDoor)
addEventHandler("onClientColShapeLeave", frontDoorCol2, enterTeimoFrontDoor)
local topDoorCol = createColCuboid((topDoorLPos[1] + topDoorRPos[1]) / 2 - 2.5, (topDoorLPos[2] + topDoorRPos[2]) / 2 - 2.5, topDoorLPos[3] - 1, 5, 5, 3.5)
function enterTopDoor(theElement, matchingDimension)
  if matchingDimension and getElementType(theElement) == "player" then
    local c = 0
    if not alarmState and bankOpen then
      c = #getElementsWithinColShape(topDoorCol, "player")
    end
    local tmp = 1 <= c and 1 or 0
    if tmp ~= neededTopDoorP then
      neededTopDoorP = tmp
      playTopDoorSound()
    end
  end
end
addEventHandler("onClientColShapeHit", topDoorCol, enterTopDoor)
local currentCCTV = false
addEventHandler("changeCurrentCCTV", getRootElement(), function(name)
  currentCCTV = name
  if name == "SC Bank & Gold Depot" then
    loadInBank()
  end
end)
function preRenderInBank(delta)
  if not isElementWithinColShape(localPlayer, bankCol) and currentCCTV ~= "SC Bank & Gold Depot" then
    inBankCol = false
    if inBankHover then
      inBankHover = false
      sightexports.sGui:showTooltip()
      sightexports.sGui:setCursorType("normal")
    end
    for i = 1, 14 do
      barHeat[i] = 0
      barCut[i] = 0
      barHeating[i] = false
    end
    removeEventHandler("onClientPedsProcessed", getRootElement(), pedsProcessedInBank)
    removeEventHandler("onClientRender", getRootElement(), renderInBank)
    removeEventHandler("onClientPreRender", getRootElement(), preRenderInBank)
    removeEventHandler("onClientKey", getRootElement(), keyInBank)
    removeEventHandler("onClientClick", getRootElement(), clickInBank)
    removeEventHandler("onClientRestore", getRootElement(), refreshGlasses)
    processBarShader()
    deleteTex()
    return
  end
  local now = getTickCount()
  local px, py, pz = getElementPosition(localPlayer)
  if currentCCTV == "SC Bank & Gold Depot" then
    local cx, cy, cz = getCameraMatrix()
    pz = cz
  end
  processNPCFear(now, delta)
  local bds = bigDoorSpeed * 160
  if bds < wrSpeed then
    wrSpeed = wrSpeed - 360 * delta / 1000
    if bds > wrSpeed then
      wrSpeed = bds
    end
  end
  if bds > wrSpeed then
    wrSpeed = wrSpeed + 360 * delta / 1000
    if bds < wrSpeed then
      wrSpeed = bds
    end
  end
  if 0 < math.abs(wrSpeed) then
    local wrs = wrSpeed * delta / 1000
    bigWheelRot = (bigWheelRot + wrs) % 360
    setElementAttachedOffsets(vaultWheel, 1.597, 0.125, -0.34905, 0, bigWheelRot, 0)
  end
  if math.abs(bigWheelRot - lastWheelClick) > 15 then
    playSound3D("files/wheel.mp3", vaultBigDoorPos[1], vaultBigDoorPos[2], vaultBigDoorPos[3])
    lastWheelClick = bigWheelRot
  end
  if 0 < #particles then
    local x, y, z = getWorldFromScreenPosition(screenX / 2, 0, 128)
    local x2, y2, z2 = getWorldFromScreenPosition(screenX / 2, screenY / 2, 128)
    x = x2 - x
    y = y2 - y
    z = z2 - z
    local len = math.sqrt(x * x + y * y + z * z) * 2
    x = x / len
    y = y / len
    z = z / len
    for k = #particles, 1, -1 do
      local data = particles[k]
      if data then
        data[1] = data[1] + data[4] * delta / 1000
        data[2] = data[2] + data[5] * delta / 1000
        data[3] = data[3] + data[6] * delta / 1000
        local progress = (now - data[7]) / 50
        if 1 < progress then
          progress = 1
        end
        if now - data[7] > data[8] then
          progress = 1 - (now - (data[7] + data[8])) / 600
          if progress < 0 then
            progress = 0
            table.remove(particles, k)
          end
        end
        data[13] = data[13] + data[14] * delta / 1000
        dxDrawMaterialLine3D(data[1] + x * data[13], data[2] + y * data[13], data[3] + z * data[13], data[1] - x * data[13], data[2] - y * data[13], data[3] - z * data[13], collisionsmoke, data[13], tocolor(data[9], data[10], data[11], data[12] * progress))
      end
    end
  end
  if bigDoorStart then
    local p = now - bigDoorStart
    if 30000 < p then
      bigDoorStart = false
      refreshBigDoorPos()
    else
      local fp = 0
      local vx, vy, vz, rot, pinP
      if bigDoorOpen then
        fp = 1 - (p - 8400) / 5700
        pinP = math.max(0, math.min(1, p / 3500))
        p = p - 3500
        local outP = math.max(0, math.min(1, p / 7500))
        p = p - 5000
        vx, vy, vz = vaultBigDoorPos[1], vaultBigDoorPos[2] - 0.375 * getEasingValue(outP, "InOutQuad"), vaultBigDoorPos[3]
        local rotP = math.max(0, math.min(1, p / 21500))
        rot = vaultBigDoorPos[4] - 130 * getEasingValue(rotP, "InOutQuad")
      else
        p = p - 10000
        fp = 1 - (p - 10000) / 5000
        local rotP = math.max(0, math.min(1, p / 10000))
        rot = vaultBigDoorPos[4] - 130 * getEasingValue(1 - rotP, "InOutQuad")
        p = p - 8000
        local outP = math.max(0, math.min(1, p / 6500))
        vx, vy, vz = vaultBigDoorPos[1], vaultBigDoorPos[2] - 0.375 * getEasingValue(1 - outP, "InOutQuad"), vaultBigDoorPos[3]
        p = p - 6000
        pinP = 1 - math.max(0, math.min(1, p / 3500))
      end
      local r = math.pi - math.pi / 2 * 1.5 * getEasingValue(pinP, "InOutQuad")
      local x = 0.148923 * math.cos(r)
      local z = 0.148923 * math.sin(r)
      local d = math.deg(math.asin(z / 1.05406))
      local l = math.sqrt(1.1110424836 - z * z)
      setElementAttachedOffsets(vaultPins[1], 1.60936 + x, 0.025, 0.108106 + z, 0, -d, 0)
      setElementAttachedOffsets(vaultPins[2], 1.60936 - x, 0.025, 0.108106 - z, 0, 180 - d, 0)
      setElementAttachedOffsets(vaultPins[3], 0.5552999999999999 - l + x, 0, 0.108106, 0, 180, 0)
      setElementAttachedOffsets(vaultPins[4], 2.66342 + l - x, 0, 0.108106, 0, 0, 0)
      setElementAttachedOffsets(vaultPins[5], 1.60936 + x, 0.025, -0.782258 + z, 0, -d, 0)
      setElementAttachedOffsets(vaultPins[6], 1.60936 - x, 0.025, -0.782258 - z, 0, 180 - d, 0)
      setElementAttachedOffsets(vaultPins[7], 0.5552999999999999 - l + x, 0, -0.782258, 0, 180, 0)
      setElementAttachedOffsets(vaultPins[8], 2.66342 + l - x, 0, -0.782258, 0, 0, 0)
      setElementPosition(vaultBigDoor, vx, vy, vz)
      setElementRotation(vaultBigDoor, 0, 0, rot)
      if fp <= 1 and 0 < fp then
        local rad = math.rad(rot)
        local cos = math.cos(rad)
        local sin = math.sin(rad)
        vx = vx + 1.597 * cos - 0.35 * sin
        vy = vy + 1.597 * sin + 0.35 * cos
        vz = vz - 0.34905
        for i = 1, 8 do
          local r = math.pi * 2 / 8 * i + math.pi / 8 * (math.random() * 2 - 1)
          local dx, dy, dz = cos * math.sin(r), sin * math.sin(r), math.cos(r)
          local x, y, z = vx + 1.6 * dx, vy + 1.6 * dy, vz + 1.6 * dz
          local s = 0.125 + math.random() * 0.125
          spawnParticle(x, y, z, dx * s, dy * s, dz * s, 500 * math.random() + 2000 * fp, 255, 255, 255, 50 * fp, 0.05 + 0.05 * math.random() + 0.15 * fp, 0.2 + 0.2 * math.random() + 0.3 * fp)
        end
      end
    end
  end
  for client, obj in pairs(blowObjects) do
    if isElementOnScreen(obj) then
      local m = getElementMatrix(obj)
      local x = m[4][1] + m[2][1] * 0.036841 + m[3][1] * 0.294475
      local y = m[4][2] + m[2][2] * 0.036841 + m[3][2] * 0.294475
      local z = m[4][3] + m[2][3] * 0.036841 + m[3][3] * 0.294475
      local nx = m[2][1] * 0.41232 + m[3][1] * 0.911039
      local ny = m[2][2] * 0.41232 + m[3][2] * 0.911039
      local nz = m[2][3] * 0.41232 + m[3][3] * 0.911039
      local s = 0.25 + 0.025 * math.random()
      dxDrawMaterialLine3D(x + nx * s, y + ny * s, z + nz * s, x, y, z, flameTex, s * 0.4, tocolor(255, 225 + 20 * math.random(), 225 + 20 * math.random(), 125 + 100 * math.random()))
    end
    setSoundVolume(blowSounds[client], 1)
  end
  if 0 < barNum then
    for i = 1, 14 do
      if barHeating[i] then
        if not isElement(barHeating[i]) then
          barHeating[i] = nil
        else
          local x, y, z = barPoses[i][1], barPoses[i][2], barPoses[i][3]
          local nx, ny = 0, 1
          local r = -math.pi / 9 * math.random()
          nx, ny = -1 * math.sin(r), 1 * math.cos(r)
          alive = 6 * (1 + 2 * barCut[i])
          table.insert(sparks, {
            x,
            y,
            z,
            nx,
            ny,
            -0.125 + 0.25 * math.random(),
            math.random() * 0.075 - 0.025,
            0.05 + math.random() * 0.25,
            alive * (0.8 + math.random() * 0.3)
          })
          if 1 < barHeat[i] then
            barHeat[i] = 1
            if barHeating[i] == localPlayer then
              triggerServerEvent("syncGoldrobBarHeat", localPlayer, false, true)
              barHeating[i] = nil
              setBlowMetal(localPlayer, false)
            end
          else
            barHeat[i] = barHeat[i] + 0.1 * (1 + 2 * barCut[i]) * delta / 1000
          end
        end
      elseif 0 < barHeat[i] and barHeat[i] < 1 then
        barHeat[i] = barHeat[i] - 0.075 * delta / 1000
        if barHeat[i] < 0 then
          barHeat[i] = 0
        end
      end
      if 0.75 <= barHeat[i] then
        barCut[i] = math.max(barCut[i], 0.3 + (barHeat[i] - 0.75) / 0.25 * 0.7)
      elseif 0.375 <= barHeat[i] then
        barCut[i] = math.max(barCut[i], (barHeat[i] - 0.375) / 0.375 * 0.3)
      end
    end
    if pz < 1 then
      dxSetRenderTarget(barRt)
      for i = 1, 14 do
        local p = barHeat[i]
        local c = math.min(1, math.max(0, barCut[i]))
        dxDrawRectangle(0, 9.142857142857142 * (i - 1), 8, 9.142857142857142, tocolor(p * 255, c * 255, 0))
      end
      dxSetRenderTarget()
    end
  end
  if elevatorObject then
    elevX, elevY, elevZ = getElementPosition(elevatorObject)
    local w = 0.07875
    local h = 0.0525
    local elevRot = elevatorObjectPos[3]
    local elevRotRad = math.rad(elevRot)
    local elevRotCos = math.cos(elevRotRad)
    local elevRotSin = math.sin(elevRotRad)
    local z = pz < 1 and elevatorLowerZ or elevatorUpperZ
    inElev = isInElev(px, py, pz)
    if isElement(elevatorMusic) then
      setSoundVolume(elevatorMusic, inElev and 0.65 or 0)
    end
    if elevatorMoving then
      if inElev then
        dxDrawMaterialSectionLine3D(elevatorInsideDisplayPos[1] + elevRotCos * 0.005 + elevRotSin * -w, elevatorInsideDisplayPos[2] + elevRotSin * 0.005 - elevRotCos * -w, elevZ + 1.2 + h * (elevatorTop and -1 or 1), elevatorInsideDisplayPos[1] + elevRotCos * 0.005 + elevRotSin * -w, elevatorInsideDisplayPos[2] + elevRotSin * 0.005 - elevRotCos * -w, elevZ + 1.2 - h * (elevatorTop and -1 or 1), 48, -32 * now / 1000, 24, 32, elev, w, tocolor(200, 10, 10), elevatorDisplayPos[1] + elevRotCos * 1 + elevRotSin * -w, elevatorInsideDisplayPos[2] + elevRotSin * 1 - elevRotCos * -w, elevZ + 1.2)
      else
        dxDrawMaterialSectionLine3D(elevatorDisplayPos[1] + elevRotCos * -0.005 + elevRotSin * w, elevatorDisplayPos[2] + elevRotSin * -0.005 - elevRotCos * w, z + 1.2 + h * (elevatorTop and -1 or 1), elevatorDisplayPos[1] + elevRotCos * -0.005 + elevRotSin * w, elevatorDisplayPos[2] + elevRotSin * -0.005 - elevRotCos * w, z + 1.2 - h * (elevatorTop and -1 or 1), 48, -32 * now / 1000, 24, 32, elev, w, tocolor(200, 10, 10), elevatorDisplayPos[1] + elevRotCos * -1 + elevRotSin * w, elevatorDisplayPos[2] + elevRotSin * -1 - elevRotCos * w, z + 1.2)
      end
      local p = 1 - (elevZ - elevatorLowerZ) / (elevatorUpperZ - elevatorLowerZ)
      if inElev then
        dxDrawMaterialSectionLine3D(elevatorInsideDisplayPos[1] + elevRotCos * 0.005 + elevRotSin * w * p, elevatorInsideDisplayPos[2] + elevRotSin * 0.005 - elevRotCos * w * p, elevZ + 1.2 + h, elevatorInsideDisplayPos[1] + elevRotCos * 0.005 + elevRotSin * w * p, elevatorInsideDisplayPos[2] + elevRotSin * 0.005 - elevRotCos * w * p, elevZ + 1.2 - h, 24 * p, 0, 24 * (1 - p), 32, elev, w * (1 - p), tocolor(200, 10, 10), elevatorInsideDisplayPos[1] + elevRotCos * 1 + elevRotSin * w * p, elevatorInsideDisplayPos[2] + elevRotSin * 1 - elevRotCos * w * p, elevZ + 1.2)
        dxDrawMaterialSectionLine3D(elevatorInsideDisplayPos[1] + elevRotCos * 0.005 + elevRotSin * w * (0.5 + 0.5 * p), elevatorInsideDisplayPos[2] + elevRotSin * 0.005 - elevRotCos * w * (0.5 + 0.5 * p), elevZ + 1.2 + h, elevatorInsideDisplayPos[1] + elevRotCos * 0.005 + elevRotSin * w * (0.5 + 0.5 * p), elevatorInsideDisplayPos[2] + elevRotSin * 0.005 - elevRotCos * w * (0.5 + 0.5 * p), elevZ + 1.2 - h, 24, 0, 24 * p, 32, elev, w * p, tocolor(200, 10, 10), elevatorInsideDisplayPos[1] + elevRotCos * 1 + elevRotSin * w * (0.5 + 0.5 * p), elevatorInsideDisplayPos[2] + elevRotSin * 1 - elevRotCos * w * (0.5 + 0.5 * p), elevZ + 1.2)
      else
        dxDrawMaterialSectionLine3D(elevatorDisplayPos[1] + elevRotCos * -0.005 + elevRotSin * -w * p, elevatorDisplayPos[2] + elevRotSin * -0.005 - elevRotCos * -w * p, z + 1.2 + h, elevatorDisplayPos[1] + elevRotCos * -0.005 + elevRotSin * -w * p, elevatorDisplayPos[2] + elevRotSin * -0.005 - elevRotCos * -w * p, z + 1.2 - h, 24 * p, 0, 24 * (1 - p), 32, elev, w * (1 - p), tocolor(200, 10, 10), elevatorDisplayPos[1] + elevRotCos * -1 + elevRotSin * -w * p, elevatorDisplayPos[2] + elevRotSin * -1 - elevRotCos * -w * p, z + 1.2)
        dxDrawMaterialSectionLine3D(elevatorDisplayPos[1] + elevRotCos * -0.005 + elevRotSin * -w * (0.5 + 0.5 * p), elevatorDisplayPos[2] + elevRotSin * -0.005 - elevRotCos * -w * (0.5 + 0.5 * p), z + 1.2 + h, elevatorDisplayPos[1] + elevRotCos * -0.005 + elevRotSin * -w * (0.5 + 0.5 * p), elevatorDisplayPos[2] + elevRotSin * -0.005 - elevRotCos * -w * (0.5 + 0.5 * p), z + 1.2 - h, 24, 0, 24 * p, 32, elev, w * p, tocolor(200, 10, 10), elevatorDisplayPos[1] + elevRotCos * -1 + elevRotSin * -w * (0.5 + 0.5 * p), elevatorDisplayPos[2] + elevRotSin * -1 - elevRotCos * -w * (0.5 + 0.5 * p), z + 1.2)
      end
    elseif elevatorTop then
      if inElev then
        dxDrawMaterialSectionLine3D(elevatorInsideDisplayPos[1] + elevRotCos * 0.005, elevatorInsideDisplayPos[2] + elevRotSin * 0.005, elevZ + 1.2 + h, elevatorInsideDisplayPos[1] + elevRotCos * 0.005, elevatorInsideDisplayPos[2] + elevRotSin * 0.005, elevZ + 1.2 - h, 0, 0, 24, 32, elev, w, tocolor(200, 10, 10), elevatorInsideDisplayPos[1] + elevRotCos * 1, elevatorInsideDisplayPos[2] + elevRotSin * 1, z + 1.2)
      else
        dxDrawMaterialSectionLine3D(elevatorDisplayPos[1] + elevRotCos * -0.005, elevatorDisplayPos[2] + elevRotSin * -0.005, z + 1.2 + h, elevatorDisplayPos[1] + elevRotCos * -0.005, elevatorDisplayPos[2] + elevRotSin * -0.005, z + 1.2 - h, 0, 0, 24, 32, elev, w, tocolor(200, 10, 10), elevatorDisplayPos[1] + elevRotCos * -1, elevatorDisplayPos[2] + elevRotSin * -1, z + 1.2)
      end
    elseif inElev then
      dxDrawMaterialSectionLine3D(elevatorInsideDisplayPos[1] + elevRotCos * 0.005 + elevRotSin * w, elevatorInsideDisplayPos[2] + elevRotSin * 0.005 - elevRotCos * w, elevZ + 1.2 + h, elevatorInsideDisplayPos[1] + elevRotCos * 0.005 + elevRotSin * w, elevatorInsideDisplayPos[2] + elevRotSin * 0.005 - elevRotCos * w, elevZ + 1.2 - h, 24, 0, 24, 32, elev, w, tocolor(200, 10, 10), elevatorInsideDisplayPos[1] + elevRotCos * 1 + elevRotSin * w, elevatorInsideDisplayPos[2] + elevRotSin * 1 - elevRotCos * w, z + 1.2)
    else
      dxDrawMaterialSectionLine3D(elevatorDisplayPos[1] + elevRotCos * -0.005 + elevRotSin * -w, elevatorDisplayPos[2] + elevRotSin * -0.005 - elevRotCos * -w, z + 1.2 + h, elevatorDisplayPos[1] + elevRotCos * -0.005 + elevRotSin * -w, elevatorDisplayPos[2] + elevRotSin * -0.005 - elevRotCos * -w, z + 1.2 - h, 24, 0, 24, 32, elev, w, tocolor(200, 10, 10), elevatorDisplayPos[1] + elevRotCos * -1 + elevRotSin * -w, elevatorDisplayPos[2] + elevRotSin * -1 - elevRotCos * -w, z + 1.2)
    end
  end
  for i = 1, #vaultPoses do
    for j = 1, #vaultOffsets do
      for k = -1, 1 do
        if vaultPry[i][j][k] then
          if 1 <= vaultPry[i][j][k] then
            if vaultPry[i][j][k] < 2 then
              vaultPry[i][j][k] = vaultPry[i][j][k] + 1 * delta / 1000
              if 2 <= vaultPry[i][j][k] then
                vaultPry[i][j][k] = 2
              end
            end
          elseif 0 < vaultPry[i][j][k] then
            vaultPry[i][j][k] = vaultPry[i][j][k] - 0.5 * delta / 1000
            if vaultPry[i][j][k] < 0 then
              vaultPry[i][j][k] = nil
            end
          end
        end
      end
    end
  end
  elevDoorsMoving = false
  for i = 1, #elevatorDoors do
    local closed = true
    local y, z = 0, 0
    if i <= 2 then
      z = elevatorUpperZ
      closed = elevatorMoving or not elevatorTop
    elseif i <= 4 then
      z = elevatorLowerZ
      closed = elevatorMoving or elevatorTop
    else
      z = elevZ
      closed = elevatorMoving
    end
    if closed then
      if doorProgress[i] < 1 then
        doorProgress[i] = doorProgress[i] + 0.3125 * delta / 1000
        elevDoorsMoving = true
        if 1 < doorProgress[i] then
          doorProgress[i] = 1
        end
      end
    elseif 0 < doorProgress[i] then
      doorProgress[i] = doorProgress[i] - 0.3125 * delta / 1000
      elevDoorsMoving = true
      if doorProgress[i] < 0 then
        doorProgress[i] = 0
      end
    end
    local p = doorProgress[i]
    if 0 < p and p < 1 then
      p = getEasingValue(p, "InOutQuad")
    end
    y = 1.24998 * (0.1 + p * 0.9)
    if i % 2 == 0 then
      y = y + 1.24998 * (0.1 + p * 0.9)
    end
    local rad = math.rad(elevatorDoorsPos[3])
    local cos = math.cos(rad)
    local sin = math.sin(rad)
    setElementPosition(elevatorDoors[i], elevatorDoorsPos[1] + cos * 0 + sin * y, elevatorDoorsPos[2] + sin * 0 - cos * y, z - 0.25)
  end
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
      dxDrawLine3D(sx, sy, sz, sx + nx, sy + ny, sz + nz, c, 0.2)
    end
  end
  if alarmState and now % 800 > 400 then
    for i = 1, #alarmPoses do
      dxDrawMaterialLine3D(alarmPoses[i][1], alarmPoses[i][2], alarmPoses[i][3], alarmPoses[i][4], alarmPoses[i][5], alarmPoses[i][6], ledTex, 0.065, tocolor(255, 50, 0), alarmPoses[i][7], alarmPoses[i][8], alarmPoses[i][9])
    end
  end
  if alarmState and blindProg < 1 then
    blindProg = blindProg + 0.6060606060606061 * delta / 1000
    if 1 < blindProg then
      blindProg = 1
    end
    refreshGlasses(getEasingValue(blindProg, "OutBounce", 0.3, 0.15))
  elseif not alarmState and 0 < blindProg then
    blindProg = blindProg - 0.25 * delta / 1000
    if blindProg < 0 then
      blindProg = 0
    end
    refreshGlasses(getEasingValue(blindProg, "InOutQuad"))
  end
  if 1 <= neededFrontDoorP and not teimoState then
    local c = 0
    if not alarmState then
      c = #getElementsWithinColShape(frontDoorCol2, "player")
      if bankOpen then
        c = c + #getElementsWithinColShape(frontDoorCol, "player")
      end
    end
    if c < 1 then
      neededFrontDoorP = 0
      playFrontDoorSound()
    end
  end
  if frontDoorP < neededFrontDoorP then
    frontDoorP = frontDoorP + delta / 1200
    if frontDoorP > neededFrontDoorP then
      frontDoorP = neededFrontDoorP
    end
    refreshFrontDoors()
  elseif frontDoorP > neededFrontDoorP then
    frontDoorP = frontDoorP - delta / 1250
    if frontDoorP < neededFrontDoorP then
      frontDoorP = neededFrontDoorP
    end
    refreshFrontDoors()
  end
  if 1 <= neededTopDoorP then
    local c = 0
    if not alarmState and bankOpen then
      c = #getElementsWithinColShape(topDoorCol, "player")
    end
    if c < 1 then
      neededTopDoorP = 0
      playTopDoorSound()
    end
  end
  if topDoorP < neededTopDoorP then
    topDoorP = topDoorP + delta / 1200
    if topDoorP > neededTopDoorP then
      topDoorP = neededTopDoorP
    end
    refreshTopDoors()
  elseif topDoorP > neededTopDoorP then
    topDoorP = topDoorP - delta / 1250
    if topDoorP < neededTopDoorP then
      topDoorP = neededTopDoorP
    end
    refreshTopDoors()
  end
end
local frontDoorSound = false
function playFrontDoorSound()
  if isElement(frontDoorSound) then
    destroyElement(frontDoorSound)
  end
  frontDoorSound = nil
  if neededFrontDoorP == 1 then
    frontDoorSound = playSound3D("files/dooropen.wav", (frontDoorLPos[1] + frontDoorRPos[1]) / 2, (frontDoorLPos[2] + frontDoorRPos[2]) / 2, frontDoorLPos[3])
    setSoundPosition(frontDoorSound, frontDoorP * 1.2)
  else
    frontDoorSound = playSound3D("files/doorclose.wav", (frontDoorLPos[1] + frontDoorRPos[1]) / 2, (frontDoorLPos[2] + frontDoorRPos[2]) / 2, frontDoorLPos[3])
    setSoundPosition(frontDoorSound, (1 - frontDoorP) * 1.2)
  end
end
function refreshFrontDoors()
  local x, y, z = frontDoorPivot[1], frontDoorPivot[2], frontDoorPivot[3]
  local rplus = -5.7 * getEasingValue(frontDoorP, "InOutQuad")
  local r = math.rad(frontDoorLPos[4] + 3.35 - rplus)
  local cos = math.cos(r)
  local sin = math.sin(r)
  local dx, dy = x + cos * 10.67, y + sin * 10.67
  setElementPosition(frontDoorL, dx, dy, z)
  setElementRotation(frontDoorL, 0, 0, frontDoorLPos[4] + 3.35 - rplus)
  local r = math.rad(frontDoorRPos[4] - 3.35 + rplus)
  local cos = math.cos(r)
  local sin = math.sin(r)
  local dx, dy = x + cos * 10.67, y + sin * 10.67
  setElementPosition(frontDoorR, dx, dy, z)
  setElementRotation(frontDoorR, 0, 0, frontDoorRPos[4] - 3.35 + rplus)
end
local topDoorSound = false
function playTopDoorSound()
  if isElement(topDoorSound) then
    destroyElement(topDoorSound)
  end
  topDoorSound = nil
  if neededTopDoorP == 1 then
    topDoorSound = playSound3D("files/dooropen.wav", (topDoorLPos[1] + topDoorRPos[1]) / 2, (topDoorLPos[2] + topDoorRPos[2]) / 2, topDoorLPos[3])
    setSoundPosition(topDoorSound, topDoorP * 1.2)
  else
    topDoorSound = playSound3D("files/doorclose.wav", (topDoorLPos[1] + topDoorRPos[1]) / 2, (topDoorLPos[2] + topDoorRPos[2]) / 2, topDoorLPos[3])
    setSoundPosition(topDoorSound, (1 - topDoorP) * 1.2)
  end
end
function refreshTopDoors()
  local p = getEasingValue(topDoorP, "InOutQuad")
  local rad = math.rad(topDoorLPos[4])
  local cos = math.cos(rad)
  local sin = math.sin(rad)
  setElementPosition(topDoorL, topDoorLPos[1] + (cos * 0 + sin * 1) * p, topDoorLPos[2] + (sin * 0 - cos * 1) * p, topDoorLPos[3])
  setElementPosition(topDoorR, topDoorRPos[1] + (cos * 0 + sin * -1) * p, topDoorRPos[2] + (sin * 0 - cos * -1) * p, topDoorRPos[3])
end
local itemPics = {
  money = "files/money.dds"
}
function processItemPics()
  for key, probability in pairs(vaultLootList) do
    if tonumber(key) then
      itemPics[key] = ":sItems/" .. sightexports.sItems:getItemPic(key)
    end
  end
end
laserOtherSide = false
function goldrobSyncLaserOtherSide(d, s)
  if keypadCode == "laser" then
    closeKeypad()
  end
  laserOtherSide = d
  if s and inBankCol then
    playSound3D("files/keysucc.mp3", laserKeypadPos[1], laserKeypadPos[2], laserKeypadPos[3])
  end
end
addEvent("goldrobSyncLaserOtherSide", true)
addEventHandler("goldrobSyncLaserOtherSide", getRootElement(), goldrobSyncLaserOtherSide)
function renderInBank()
  local tmp = false
  local tmpVault = false
  local tmpPoint = false
  local tmpBar = false
  local px, py, pz = getElementPosition(localPlayer)
  local camx, camy, camz, ctx, cty, ctz = getCameraMatrix()
  if currentCCTV == "SC Bank & Gold Depot" then
    pz = camz
  end
  local now = getTickCount()
  renderNPCFear(now, camx, camy, camz, ctx, cty, ctz)
  local cx, cy = getCursorPosition()
  if cx then
    cx = cx * screenX
    cy = cy * screenY
  end
  local freeToDo = isPlayerFreeToDo()
  if not elevatorMoving and not elevDoorsMoving then
    local x, y, z = 0, 0, 0
    if inElev then
      x, y = elevatorButtonInsidePos[1], elevatorButtonInsidePos[2]
      z = elevZ
    else
      x, y = elevatorButtonPos[1], elevatorButtonPos[2]
      z = (elevatorTop and elevatorLowerZ or elevatorUpperZ) - 0.2501
    end
    local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
    local a = 255 * math.min(1, 1 - (d - 1.5) / 2.5)
    if 0 < a then
      local x, y = getScreenFromWorldPosition(x, y, z, 32)
      if x then
        dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
        local icon = elevatorTop and elevDownIcon or elevUpIcon
        if 255 <= a and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
          tmp = "elev"
          dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. icon .. faTicks[icon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
        else
          dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. icon .. faTicks[icon], 0, 0, 0, tocolor(255, 255, 255, a))
        end
      end
    end
  end
  if pz < 1 then
    if bigDoorOpen then
      for i = 1, #vaultPoses do
        if isElementOnScreen(vaultObjects[i]) then
          for j = 1, #vaultOffsets do
            local ox, oy, z = vaultPoses[i][j][1], vaultPoses[i][j][2], vaultPoses[i][j][3]
            local r = vaultPoses[i][j][4]
            local op = vaultOpened[i][j] and 1 or 0
            local t = vaultOpened[i][j] and 5 or 1
            if tonumber(vaultOpened[i][j]) then
              op = (now - vaultOpened[i][j]) / 2000
              if op < 1 then
                p = getEasingValue(op, "OutElastic", 0.4)
              else
                p = 1
                op = 1
                vaultOpened[i][j] = true
              end
            else
              p = op
              if not vaultOpened[i][j] then
                for k = -1, 1 do
                  if vaultPry[i][j][k] and 1 <= vaultPry[i][j][k] then
                    t = t + 1
                  end
                end
              end
            end
            local cos = math.cos(r + math.pi * 0.5 * p)
            local sin = math.sin(r + math.pi * 0.5 * p)
            local x = ox - sin * 0.416588
            local y = oy + cos * 0.416588
            dxDrawMaterialLine3D(x, y, z + 0.231966, x, y, z - 0.231966, vaultTex[t], 0.833176, tocolor(150, 150, 150), x - cos, y - sin, z)
            if freeToDo and not selfCrate and 0 >= barNum then
              if vaultOpened[i][j] then
                if vaultLoot[i][j] then
                  local cos = math.cos(r)
                  local sin = math.sin(r)
                  local x = ox - sin * 0.416588
                  local y = oy + cos * 0.416588
                  local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
                  local a = 255 * math.min(1, (1 - (d - 3) / 5) * op)
                  if 0 < a then
                    local x, y = getScreenFromWorldPosition(x, y, z, 36)
                    if x then
                      if 1 <= op and d <= 1.5 and cx and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
                        dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(sightblue[1], sightblue[2], sightblue[3], a))
                        tmp = i
                        tmpVault = j
                      else
                        dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(sightgrey2[1], sightgrey2[2], sightgrey2[3], a))
                      end
                      dxDrawImage(x - 18, y - 18, 36, 36, dynamicImage(itemPics[vaultLoot[i][j]]), 0, 0, 0, tocolor(255, 255, 255, a * op))
                    end
                  end
                end
              elseif cx then
                local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
                local a = 255 * math.min(1, 1 - (d - 1.5) / 1)
                if 0 < a then
                  x = x - sin * 0.416588
                  y = y + cos * 0.416588
                  for k = -1, 1 do
                    local a2 = a
                    local p = vaultPry[i][j][k] or 0
                    if 1 < p then
                      a2 = a * (1 - (p - 1))
                    end
                    local green = tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a2)
                    local x, y = getScreenFromWorldPosition(x, y, z + 0.1 * k, 32)
                    if x then
                      if p < 1 then
                        dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. circleIcon .. faTicks[circleIcon], 0, 0, 0, tocolor(0, 0, 0, 0.75 * a2))
                        dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. circleBorderIcon .. faTicks[circleBorderIcon], 0, 0, 0, green)
                        if 255 <= a and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
                          tmp = i
                          tmpVault = j
                          tmpPoint = k
                        end
                      end
                      if 0 < p then
                        p = math.min(1, p)
                        dxDrawImageSection(x - 16, y - 16, 32 * p, 32, 0, 0, 32 * p, 32, ":sGui/" .. circleIcon .. faTicks[circleIcon], 0, 0, 0, green)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
      if freeToDo then
        local d = getDistanceBetweenPoints3D(px, py, pz, barX, barY, barZ)
        local a = 255 * math.min(1, 1 - (d - 1) / 1)
        if 0 < a and blowObjects[localPlayer] then
          for i = 1, #barPoses do
            if isElement(vaultBarPieces[i]) then
              local x, y = getScreenFromWorldPosition(barPoses[i][1], barPoses[i][2], barPoses[i][3], 48)
              if x then
                if 255 <= a and cx and cx >= x - 24 and cy >= y - 24 and cx <= x + 24 and cy <= y + 24 then
                  dxDrawImage(x - 24, y - 24, 48, 48, ":sGui/" .. circleBorderIcon .. faTicks[circleBorderIcon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
                  tmpBar = i
                else
                  dxDrawImage(x - 24, y - 24, 48, 48, ":sGui/" .. circleBorderIcon .. faTicks[circleBorderIcon], 0, 0, 0, tocolor(255, 255, 255, a))
                end
              end
            end
          end
        end
      end
      if laserOtherSide then
        if freeToDo and "v4" == "v4" and py <= laserKeypadPos[2] + 0.5 or "v4" == "lv" and px >= laserKeypadPos[1] - 0.5 then
          local d = getDistanceBetweenPoints3D(px, py, pz, laserKeypadPos[1], laserKeypadPos[2], laserKeypadPos[3])
          local a = 255 * math.min(1, 1 - (d - 1.5) / 2)
          if 0 < a then
            local x, y = getScreenFromWorldPosition(laserKeypadPos[1], laserKeypadPos[2], laserKeypadPos[3])
            if x then
              dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
              if 255 <= a and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
                tmp = "laserkey"
                dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. keyInputIcon .. faTicks[keyInputIcon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
              else
                dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. keyInputIcon .. faTicks[keyInputIcon], 0, 0, 0, tocolor(255, 255, 255, a))
              end
            end
          end
        end
        for i = 1, #laserPoses do
          if laserOtherSide[i] then
            dxDrawLine3D(laserX1, laserPoses[i][1], laserPoses[i][2], laserX2, laserPoses[laserOtherSide[i]][1], laserPoses[laserOtherSide[i]][2], tocolor(200, 10, 10, 50 + 150 * math.random()), 1)
          end
        end
      end
    elseif freeToDo and canOpenBigDoor and not bigDoorStart and ("v4" == "v4" and py <= vaultBigDoorWheelPos[2] or "v4" == "lv" and px <= vaultBigDoorWheelPos[1]) then
      local x, y, z = vaultBigDoorWheelPos[1], vaultBigDoorWheelPos[2], vaultBigDoorWheelPos[3]
      local d = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
      local a = 255 * math.min(1, 1 - (d - 1.5) / 2)
      if 0 < a then
        local x, y = getScreenFromWorldPosition(x, y, z)
        if x then
          dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
          if 255 <= a and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
            tmp = "bigdoor"
            dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. wheelIcon .. faTicks[wheelIcon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
          else
            dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. wheelIcon .. faTicks[wheelIcon], 0, 0, 0, tocolor(255, 255, 255, a))
          end
        end
      end
    end
  elseif freeToDo then
    if npcFear and not npcDuck then
      local d = getDistanceBetweenPoints3D(px, py, pz, mainClerkPos[1], mainClerkPos[2], mainClerkPos[3])
      local a = 255 * math.min(1, 1 - (d - 2.5) / 2)
      if 0 < a then
        local x, y = getScreenFromWorldPosition(mainClerkPos[1], mainClerkPos[2], mainClerkPos[3])
        if x then
          dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
          if 255 <= a and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
            tmp = "npcfear"
            dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. fearFaceIcon .. faTicks[fearFaceIcon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
          else
            dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. fearFaceIcon .. faTicks[fearFaceIcon], 0, 0, 0, tocolor(255, 255, 255, a))
          end
        end
      end
    end
    if alarmState and not alarmMuted and goldrobMute and ("v4" == "v4" and px >= alarmPos[1] or "v4" == "lv" and py <= alarmPos[2]) then
      local x, y, z = alarmPos[1], alarmPos[2], alarmPos[3]
      local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
      local a = 255 * math.min(1, 1 - (d - 1.5) / 2.5)
      if 0 < a then
        local x, y = getScreenFromWorldPosition(x, y, z, 32)
        if x then
          dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
          if 255 <= a and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
            tmp = "mute"
            dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. muteIcon .. faTicks[muteIcon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
          else
            dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. muteIcon .. faTicks[muteIcon], 0, 0, 0, tocolor(255, 255, 255, a))
          end
        end
      end
    end
    if not insideDoorsOpen then
      if "v4" == "v4" and px <= insideDoorReleasePos[1] or "v4" == "lv" and py >= insideDoorReleasePos[2] then
        local x, y, z = insideDoorReleasePos[1], insideDoorReleasePos[2], insideDoorReleasePos[3]
        local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
        local a = 255 * math.min(1, 1 - (d - 1.5) / 2.5)
        if 0 < a then
          local x, y = getScreenFromWorldPosition(x, y, z, 32)
          if x then
            dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
            if 255 <= a and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
              tmp = "doorrelease"
              dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. doorIcon .. faTicks[doorIcon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
            else
              dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. doorIcon .. faTicks[doorIcon], 0, 0, 0, tocolor(255, 255, 255, a))
            end
          end
        end
      else
        local x, y, z = insideKeypadPos[1], insideKeypadPos[2], insideKeypadPos[3]
        local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
        local a = 255 * math.min(1, 1 - (d - 1.5) / 2.5)
        if 0 < a then
          local x, y = getScreenFromWorldPosition(x, y, z, 64)
          if x then
            if not insideKeypadBroken then
              y = y - 19
            end
            if goldrobLock then
              y = y - 19
            end
            dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
            if 255 <= a and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
              tmp = "doorhack"
              dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. screwdriverIcon .. faTicks[screwdriverIcon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
            else
              dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. screwdriverIcon .. faTicks[screwdriverIcon], 0, 0, 0, tocolor(255, 255, 255, a))
            end
            if not insideKeypadBroken then
              y = y + 32 + 6
              dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
              if 255 <= a and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
                tmp = "doorkey"
                dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. keyInputIcon .. faTicks[keyInputIcon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
              else
                dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. keyInputIcon .. faTicks[keyInputIcon], 0, 0, 0, tocolor(255, 255, 255, a))
              end
            end
            if goldrobLock then
              y = y + 32 + 6
              dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
              if 255 <= a and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
                tmp = "doorreleasepd"
                dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. badgeIcon .. faTicks[badgeIcon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
              else
                dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. badgeIcon .. faTicks[badgeIcon], 0, 0, 0, tocolor(255, 255, 255, a))
              end
            end
          end
        end
      end
    end
    if goldrobLock then
      local x, y, z = roofDoorIconPos[1], roofDoorIconPos[2], roofDoorIconPos[3]
      local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
      local a = 255 * math.min(1, 1 - (d - 1.5) / 2.5)
      if 0 < a then
        local x, y = getScreenFromWorldPosition(x, y, z, 32)
        if x then
          dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
          local icon = roofDoorOpen and unLockIcon or lockIcon
          if 255 <= a and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
            tmp = "roofdoor"
            dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. icon .. faTicks[icon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
          else
            dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. icon .. faTicks[icon], 0, 0, 0, tocolor(255, 255, 255, a))
          end
        end
      end
      if py <= backDoorIconPos[2] then
        local x, y, z = backDoorIconPos[1], backDoorIconPos[2], backDoorIconPos[3]
        local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
        local a = 255 * math.min(1, 1 - (d - 1.5) / 2.5)
        if 0 < a then
          local x, y = getScreenFromWorldPosition(x, y, z, 32)
          if x then
            dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
            local icon = backDoorOpen and unLockIcon or lockIcon
            if 255 <= a and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
              tmp = "backdoor"
              dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. icon .. faTicks[icon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
            else
              dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. icon .. faTicks[icon], 0, 0, 0, tocolor(255, 255, 255, a))
            end
          end
        end
      end
    end
    if goldrobDestroy and selfCrate then
      local x, y, z = 572.0234375, -1639.763671875, 16.642763137817
      local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
      local a = 255 * math.min(1, 1 - (d - 1.5) / 2.5)
      if 0 < a then
        local x, y = getScreenFromWorldPosition(x, y, z, 32)
        if x then
          dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
          if 255 <= a and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
            tmp = "destroy"
            dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. trashIcon .. faTicks[trashIcon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
          else
            dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. trashIcon .. faTicks[trashIcon], 0, 0, 0, tocolor(255, 255, 255, a))
          end
        end
      end
    end
  end
  if selfCrate and 0 >= barNum and bigDoorOpen then
    for id, dat in pairs(crateData) do
      if type(dat) == "table" then
        local x, y, z = dat[1], dat[2], dat[3] + 0.125
        if crateInElev[id] then
          z = elevZ - 1.45 + 0.125
          setElementPosition(crateObjects[id], x, y, z)
        end
      end
    end
    if pz < 1 and freeToDo then
      for id = 1, #goldBars do
        if goldBars[id] and not goldBarCrates[id] then
          local x, y, z = goldBarPositions[goldBars[id]][1], goldBarPositions[goldBars[id]][2], goldBarPositions[goldBars[id]][3]
          local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
          local a = 255 * math.min(1, 1 - (d - 1.5) / 2.5)
          if 0 < a then
            local x, y = getScreenFromWorldPosition(x, y, z, 32)
            if x then
              dxDrawRectangle(x - 16 - 2, y - 16 - 2, 36, 36, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
              if 255 <= a and cx and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
                dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightblue[1], sightblue[2], sightblue[3], a))
                tmp = id
              else
                dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey2[1], sightgrey2[2], sightgrey2[3], a))
              end
              sightlangStaticImageUsed[2] = true
              if sightlangStaticImageToc[2] then
                processsightlangStaticImage[2]()
              end
              dxDrawImage(x - 16, y - 16, 32, 32, sightlangStaticImage[2], 0, 0, 0, tocolor(255, 255, 255, a))
            end
          end
        end
      end
    end
  elseif freeToDo then
    for id, dat in pairs(crateData) do
      if type(dat) == "table" then
        local x, y, z = dat[1], dat[2], dat[3] + 0.125
        local elev = true
        if crateInElev[id] then
          z = elevZ - 1.45 + 0.125
          setElementPosition(crateObjects[id], x, y, z)
          elev = inElev
        end
        local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
        local a = 255 * math.min(1, 1 - (d - 1.5) / 2.5)
        if 0 < a and elev and isLineOfSightClear(x, y, z, camx, camy, camz, true, true, false, true, false, false, false, crateObjects[id]) then
          local x, y = getScreenFromWorldPosition(x, y, z, 32)
          if x then
            dxDrawRectangle(x - 16 - 2, y - 16 - 2, 36, 36, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
            if 255 <= a and cx and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
              dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightblue[1], sightblue[2], sightblue[3], a))
              tmp = id
            else
              dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey2[1], sightgrey2[2], sightgrey2[3], a))
            end
            dxDrawImage(x - 16, y - 16, 32, 32, dynamicImage("files/crate" .. (crateGold[id] and "gold" or "") .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, a))
          end
        end
      end
    end
  end
  if inBankHover ~= tmp or inBankVaultHover ~= tmpVault or inBankVaultPointHover ~= tmpPoint or inBankBarHover ~= tmpBar then
    if barHeating[inBankBarHover] == localPlayer then
      triggerServerEvent("syncGoldrobBarHeat", localPlayer)
      barHeating[inBankBarHover] = nil
      setBlowMetal(localPlayer, false)
    end
    inBankHover = tmp
    inBankVaultHover = tmpVault
    inBankVaultPointHover = tmpPoint
    inBankBarHover = tmpBar
    sightexports.sGui:setCursorType((inBankHover or inBankBarHover) and "link" or "normal")
    if inBankBarHover then
      sightexports.sGui:showTooltip("Lángvágó használata")
    elseif tmpVault then
      if vaultOpened[tmp][tmpVault] then
        sightexports.sGui:showTooltip("Széf kiürítése")
      else
        sightexports.sGui:showTooltip("Széf vésése")
      end
    elseif inBankHover == "bigdoor" then
      sightexports.sGui:showTooltip("Széf kinyitása")
    elseif inBankHover == "laserkey" then
      sightexports.sGui:showTooltip("Lézer kikapcsolása")
    elseif inBankHover == "backdoor" then
      sightexports.sGui:showTooltip("Ajtó " .. (backDoorOpen and "zárása" or "nyitása"))
    elseif inBankHover == "roofdoor" then
      sightexports.sGui:showTooltip("Ajtó " .. (roofDoorOpen and "zárása" or "nyitása"))
    elseif inBankHover == "doorhack" then
      sightexports.sGui:showTooltip("Ajtó feltörése")
    elseif inBankHover == "doorkey" then
      sightexports.sGui:showTooltip("Ajtó kinyitása kóddal")
    elseif inBankHover == "doorrelease" then
      sightexports.sGui:showTooltip("Ajtó kinyitása")
    elseif inBankHover == "destroy" then
      sightexports.sGui:showTooltip("Láda megsemmisítése")
    elseif inBankHover == "doorreleasepd" then
      sightexports.sGui:showTooltip("Ajtó kinyitása (rendvédelem)")
    elseif inBankHover == "mute" then
      sightexports.sGui:showTooltip("Riasztás némítása")
    elseif inBankHover == "npcfear" then
      sightexports.sGui:showTooltip("Ügyintéző megfenyegetése\n(Biztonsági rendszer kód)")
    elseif inBankHover == "elev" then
      sightexports.sGui:showTooltip("Lift")
    else
      sightexports.sGui:showTooltip(not inBankHover or selfCrate and "Arany felvétele" or "Láda felvétele")
    end
  end
end
function reverseMatrix(m, x, y, z)
  return (-m[2][1] * m[3][2] * z + m[2][1] * m[3][3] * y - m[2][2] * m[3][3] * x + m[2][2] * m[3][1] * z + m[3][2] * m[2][3] * x - m[2][3] * m[3][1] * y) / (-m[1][1] * m[2][2] * m[3][3] + m[1][1] * m[3][2] * m[2][3] - m[1][3] * m[2][1] * m[3][2] + m[1][3] * m[2][2] * m[3][1] + m[2][1] * m[3][3] * m[1][2] - m[1][2] * m[2][3] * m[3][1]), (m[1][1] * m[3][2] * z - m[1][1] * m[3][3] * y - m[1][3] * m[3][2] * x + m[1][3] * m[3][1] * y + m[3][3] * m[1][2] * x - m[1][2] * m[3][1] * z) / (-m[1][1] * m[2][2] * m[3][3] + m[1][1] * m[3][2] * m[2][3] - m[1][3] * m[2][1] * m[3][2] + m[1][3] * m[2][2] * m[3][1] + m[2][1] * m[3][3] * m[1][2] - m[1][2] * m[2][3] * m[3][1]), (-m[1][1] * m[2][2] * z + m[1][1] * m[2][3] * y - m[1][3] * m[2][1] * y + m[1][3] * m[2][2] * x + m[2][1] * m[1][2] * z - m[1][2] * m[2][3] * x) / (-m[1][1] * m[2][2] * m[3][3] + m[1][1] * m[3][2] * m[2][3] - m[1][3] * m[2][1] * m[3][2] + m[1][3] * m[2][2] * m[3][1] + m[2][1] * m[3][3] * m[1][2] - m[1][2] * m[2][3] * m[3][1])
end
function drawBoneVilag(m, x, y, z)
  return x * m[1][1] + y * m[2][1] + z * m[3][1] + m[4][1], x * m[1][2] + y * m[2][2] + z * m[3][2] + m[4][2], x * m[1][3] + y * m[2][3] + z * m[3][3] + m[4][3]
end
function pedsProcessedInBank()
  local now = getTickCount()
  for i, client in pairs(barHeating) do
    if isElement(client) and isElementOnScreen(client) and i then
      local m = getElementBoneMatrix(client, 21)
      local x1, y1, z1 = getElementBonePosition(client, 22)
      local rx, ry, rz = getElementRotation(client)
      local hit = false
      local tx, ty, tz = (barPoses[i][1] or 0) + 0.1, (barPoses[i][2] or 0) - 0.05, (barPoses[i][3] or 0) - 0.125
      local x, y, z, i, d
      m[4][1] = x1
      m[4][2] = y1
      m[4][3] = z1
      local x2, y2, z2 = getElementBonePosition(client, 23)
      local x3, y3, z3 = getElementBonePosition(client, 24)
      local x, y, z = reverseMatrix(m, tx - x1, ty - y1, tz - z1)
      local tx1, ty1, tz1 = drawBoneVilag(m, 0, 0, 0)
      local tx, ty, tz = drawBoneVilag(m, x, y, z)
      local tx2, ty2, tz2 = drawBoneVilag(m, 0, 0, z)
      local deg = math.deg(math.atan2(y, x))
      local deg2 = math.deg(math.atan2(-z, math.sqrt(x * x + y * y)))
      local l1 = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
      local l2 = getDistanceBetweenPoints3D(x2, y2, z2, x3, y3, z3)
      local l3 = math.sqrt(x * x + y * y + z * z)
      local joint2 = 180
      if l3 < l1 + l2 then
        joint2 = math.deg(math.acos((l1 * l1 + l2 * l2 - l3 * l3) / (2 * l1 * l2)))
      end
      local r2 = -deg
      local r3 = 0
      if 100 < r2 then
        r3 = (r2 - 100) / 2
        deg = -100
      elseif r2 < 75 then
        r3 = -(75 - r2) / 2
        deg = -75
      end
      setElementBoneRotation(client, 2, r3, 0, 0)
      setElementBoneRotation(client, 3, r3, 0, 0)
      setElementBoneRotation(client, 22, 0, deg + (180 - joint2) / 2, deg2)
      setElementBoneRotation(client, 23, 0, -(180 - joint2), 0)
      setElementBoneRotation(client, 24, 180, 0, -45)
      sightexports.sCore:updateElementRpHAnim(client)
    end
  end
end
function loadInBank()
  if not inBankCol then
    inBankCol = true
    addEventHandler("onClientPedsProcessed", getRootElement(), pedsProcessedInBank)
    addEventHandler("onClientRender", getRootElement(), renderInBank)
    addEventHandler("onClientPreRender", getRootElement(), preRenderInBank)
    addEventHandler("onClientKey", getRootElement(), keyInBank)
    addEventHandler("onClientClick", getRootElement(), clickInBank)
    addEventHandler("onClientRestore", getRootElement(), refreshGlasses)
    bigDoorSpeed = 0
    for i = 1, 14 do
      barHeat[i] = 0
      barCut[i] = 0
      barHeating[i] = false
    end
  end
  processBarShader()
  createTex()
  refreshGlasses()
end
addEventHandler("onClientResourceStart", resourceRoot, function()
  if inBankCol then
    loadInBank()
  end
end)
addEventHandler("onClientColShapeHit", bankCol, function(he, md)
  if he == localPlayer and md then
    loadInBank()
  end
end)
inBankCol = isElementWithinColShape(localPlayer, bankCol)
if inBankCol then
  loadInBank()
end
function clickSecuricars(btn, state)
  if state == "down" and securicarHover and getTickCount() - lastClick > 500 then
    local id = false
    if vehicleCrates[securicarHover] then
      for j = 1, #vehicleCrates[securicarHover] do
        if tonumber(crateData[vehicleCrates[securicarHover][j]]) == securicarCrateHover then
          id = vehicleCrates[securicarHover][j]
        end
      end
    end
    if selfCrate then
      if id then
        return
      end
    elseif not id then
      return
    end
    lastClick = getTickCount()
    triggerServerEvent("securiCarCrateClick", localPlayer, securicarHover, id, securicarCrateHover, selfCrate)
  end
end
function renderSecuricars()
  local tmp = false
  local tmpCrate = false
  local tooltip = false
  if isPlayerFreeToDo() then
    local w = securiCarCrates * 36 + 4
    local camx, camy, camz = getCameraMatrix()
    local px, py, pz = getElementPosition(localPlayer)
    local cx, cy = getCursorPosition()
    if cx then
      cx = cx * screenX
      cy = cy * screenY
    end
    for i = 1, #streamedInSecuricars do
      local veh = streamedInSecuricars[i]
      if isElement(veh) then
        local vx, vy, vz = getElementVelocity(veh)
        if math.sqrt(vx * vx + vy * vy + vz * vz) < 0.1 then
          local m = getElementMatrix(veh)
          local x, y, z = m[4][1] - m[2][1] * 3, m[4][2] - m[2][2] * 3, m[4][3] - m[2][3] * 3
          local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
          local a = 255 * math.min(1, 1 - (d - 1.5) / 2.5)
          if 0 < a and isLineOfSightClear(x, y, z, camx, camy, camz, true, true, false, true, false, false, false, veh) then
            x, y = getScreenFromWorldPosition(x, y, z, w / 2)
            if x then
              local ox = x - w / 2
              x = ox
              dxDrawRectangle(x, y - 20, w, 40, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
              x = x + 4
              for j = 1, securiCarCrates do
                if 255 <= a and not tmp and cx and cx >= x and cx <= x + 32 and cy >= y - 16 and cy <= y + 16 then
                  dxDrawRectangle(x, y - 16, 32, 32, tocolor(sightblue[1], sightblue[2], sightblue[3], a))
                  tmp = veh
                  tmpCrate = j
                  if selfCrate then
                    tooltip = "Láda behelyezése"
                  end
                else
                  dxDrawRectangle(x, y - 16, 32, 32, tocolor(sightgrey2[1], sightgrey2[2], sightgrey2[3], a))
                end
                x = x + 32 + 4
              end
              if vehicleCrates[veh] then
                for j = 1, #vehicleCrates[veh] do
                  local id = vehicleCrates[veh][j]
                  if tonumber(crateData[id]) then
                    if tmp == veh and tonumber(crateData[id]) == tmpCrate then
                      if not selfCrate then
                        tooltip = "Láda kivétele"
                      else
                        tooltip = false
                      end
                    end
                    dxDrawImage(ox + 4 + (crateData[id] - 1) * 36, y - 16, 32, 32, dynamicImage("files/crate" .. (crateGold[id] and "gold" or "") .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, a))
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  if securicarHover ~= tmp or securicarCrateHover ~= tmpCrate then
    securicarHover = tmp
    securicarCrateHover = tmpCrate
    sightexports.sGui:setCursorType(tmp and "link" or "normal")
    sightexports.sGui:showTooltip(tooltip)
  end
end
local vehs = getElementsByType("vehicle", getRootElement(), true)
for i = 1, #vehs do
  if getElementModel(vehs[i]) == 428 then
    if #streamedInSecuricars <= 0 then
      addEventHandler("onClientRender", getRootElement(), renderSecuricars)
      addEventHandler("onClientClick", getRootElement(), clickSecuricars)
    end
    table.insert(streamedInSecuricars, vehs[i])
  end
end
addEventHandler("onClientElementStreamIn", getRootElement(), function()
  if getElementModel(source) == 428 then
    if #streamedInSecuricars <= 0 then
      addEventHandler("onClientRender", getRootElement(), renderSecuricars)
      addEventHandler("onClientClick", getRootElement(), clickSecuricars)
    end
    table.insert(streamedInSecuricars, source)
  end
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
  if getElementModel(source) == 428 then
    local was = #streamedInSecuricars
    for i = was, 1, -1 do
      if streamedInSecuricars[i] == source then
        table.remove(streamedInSecuricars, i)
      end
    end
    if 1 <= was and #streamedInSecuricars <= 0 then
      removeEventHandler("onClientRender", getRootElement(), renderSecuricars)
      removeEventHandler("onClientClick", getRootElement(), clickSecuricars)
      if securicarHover then
        sightexports.sGui:setCursorType("normal")
        sightexports.sGui:showTooltip()
      end
      securicarHover = false
    end
  end
end)
addEventHandler("onClientElementDestroy", getRootElement(), function()
  vehicleCrates[source] = nil
  if getElementModel(source) == 428 then
    local was = #streamedInSecuricars
    for i = was, 1, -1 do
      if streamedInSecuricars[i] == source then
        table.remove(streamedInSecuricars, i)
      end
    end
    if 1 <= was and #streamedInSecuricars <= 0 then
      removeEventHandler("onClientRender", getRootElement(), renderSecuricars)
      removeEventHandler("onClientClick", getRootElement(), clickSecuricars)
      if securicarHover then
        sightexports.sGui:setCursorType("normal")
        sightexports.sGui:showTooltip()
      end
      securicarHover = false
    end
  end
end)