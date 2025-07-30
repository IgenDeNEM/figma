local seexports = {
  sModloader = false,
  sGui = false,
  sPaintshop = false,
  sInteriors = false,
  sMechanic = false
}
local function sightlangProcessExports()
  for k in pairs(seexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      seexports[k] = exports[k]
    else
      seexports[k] = false
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
local garageWindow = false
local garageObjects = {}
local loadedGarageData = false
local bpRt = false
local bpShader = false
local replaceShader = [[
    texture ReplacedTexture;

    technique TextureChange
    {
        pass P0
        {
            Texture[0] = ReplacedTexture;
        }
    }
]]
local eventsHandled = false
local doorShader = false
local toolboxShader = false
local wallShader = false
local ceilingShader = false
local floorShader = false
local doorTexture = false
local toolboxTexture = false
local wallTexture = false
local ceilingTexture = false
local floorTexture = false
local btnBcg = false
local btnCol = false
local btnCol2 = false
local lastClick = {}
local liftSounds = {}
local liftStates = {}
local chargingVehicle = false
local chargingObjects = {}
function prepareGarageFloor(dim)
  if dim then
    removeWorldModel(14776, 10, 621.785, -12.5417, 1000.922)
    if not isElement(garageObjects.floor) then
      garageObjects.floor = createObject(seexports.sModloader:getModelId("garage_floor"), baseX, baseY, baseZ)
    end
    if not isElement(garageObjects.trashCan) then
      garageObjects.trashCan = createObject(seexports.sModloader:getModelId("v4_trashcan2"), 613.27626953125, -30.449887084961, 1000.9199829102 - 0.35, 0, 0, 180)
    end
    processDimension(garageObjects.floor, dim)
    processDimension(garageObjects.trashCan, dim)
    if not isElement(bpRt) then
      bpRt = dxCreateRenderTarget(800, 500)
    end
    if not eventsHandled then
      addEventHandler("onClientRestore", getRootElement(), drawBlueprint)
      addEventHandler("onClientClick", getRootElement(), garageClick)
      addEventHandler("onClientRender", getRootElement(), garageRender)
      eventsHandled = true
    end
    btnBcg = seexports.sGui:getColorCodeToColor("sightgrey1")
    btnCol = seexports.sGui:getColorCodeToColor("sightgreen")
    btnCol2 = seexports.sGui:getColorCodeToColor("sightred")
    if not isElement(toolboxShader) then
      toolboxShader = dxCreateShader(replaceShader)
      engineApplyShaderToWorldTexture(toolboxShader, "v4_toolbox")
    end
    if not isElement(wallShader) then
      wallShader = dxCreateShader(replaceShader)
      engineApplyShaderToWorldTexture(wallShader, "garageint_wall")
    end
    if not isElement(ceilingShader) then
      ceilingShader = dxCreateShader(replaceShader)
      engineApplyShaderToWorldTexture(ceilingShader, "garageint_ceil")
    end
    if not isElement(floorShader) then
      floorShader = dxCreateShader(replaceShader)
      engineApplyShaderToWorldTexture(floorShader, "garageint_floor")
    end
    if not isElement(doorShader) then
      doorShader = dxCreateShader(replaceShader)
      engineApplyShaderToWorldTexture(doorShader, "v4_garagedoor")
    end
    if not isElement(bpShader) then
      bpShader = dxCreateShader(replaceShader)
      dxSetShaderValue(bpShader, "ReplacedTexture", bpRt)
      engineApplyShaderToWorldTexture(bpShader, "garage_plan")
    end
  else
    loadedGarageData = nil
    closeGaragePanel()
    restoreWorldModel(14776, 10, 621.785, -12.5417, 1000.922)
    if isElement(doorTexture) then
      destroyElement(doorTexture)
    end
    doorTexture = nil
    if isElement(doorShader) then
      destroyElement(doorShader)
    end
    doorShader = nil
    if isElement(toolboxTexture) then
      destroyElement(toolboxTexture)
    end
    toolboxTexture = nil
    if isElement(toolboxShader) then
      destroyElement(toolboxShader)
    end
    toolboxShader = nil
    if isElement(wallTexture) then
      destroyElement(wallTexture)
    end
    wallTexture = nil
    if isElement(wallShader) then
      destroyElement(wallShader)
    end
    wallShader = nil
    if isElement(ceilingTexture) then
      destroyElement(ceilingTexture)
    end
    ceilingTexture = nil
    if isElement(ceilingShader) then
      destroyElement(ceilingShader)
    end
    ceilingShader = nil
    if isElement(floorTexture) then
      destroyElement(floorTexture)
    end
    floorTexture = nil
    if isElement(floorShader) then
      destroyElement(floorShader)
    end
    floorShader = nil
    for k in pairs(garageObjects) do
      if isElement(garageObjects[k]) then
        destroyElement(garageObjects[k])
      end
      garageObjects[k] = nil
    end
    if isElement(bpRt) then
      destroyElement(bpRt)
    end
    bpRt = nil
    if eventsHandled then
      removeEventHandler("onClientRestore", getRootElement(), drawBlueprint)
      removeEventHandler("onClientClick", getRootElement(), garageClick)
      removeEventHandler("onClientRender", getRootElement(), garageRender)
    end
    eventsHandled = false
    if isElement(bpShader) then
      destroyElement(bpShader)
    end
    bpShader = nil
    for i = 1, #liftLayout do
      if isElement(liftSounds[i]) then
        destroyElement(liftSounds[i])
      end
    end
    lastClick = {}
    liftSounds = {}
    liftStates = {}
    for i = 1, #chargingObjects do
      if isElement(chargingObjects[i]) then
        destroyElement(chargingObjects[i])
      end
    end
    chargingObjects = {}
  end
end
addEvent("syncGarageCharging", true)
addEventHandler("syncGarageCharging", getRootElement(), function(id, veh, eff)
  if loadedGarageData and id == loadedGarageData.interiorId then
    chargingVehicle = veh
    for i = 1, #chargingObjects do
      if isElement(chargingObjects[i]) then
        destroyElement(chargingObjects[i])
      end
    end
    chargingObjects = {}
    if isElement(veh) then
      chargingObjects[1] = createObject(seexports.sModloader:getModelId("bika"), 0, 0, 0)
      processDimension(chargingObjects[1], id)
      setElementCollisionsEnabled(chargingObjects[1], false)
      chargingObjects[2] = createObject(seexports.sModloader:getModelId("bika_red"), 0, 0, 0)
      processDimension(chargingObjects[2], id)
      setElementCollisionsEnabled(chargingObjects[2], false)
      setElementDoubleSided(chargingObjects[2], true)
      chargingObjects[3] = createObject(seexports.sModloader:getModelId("bika_black"), 0, 0, 0)
      processDimension(chargingObjects[3], id)
      setElementCollisionsEnabled(chargingObjects[3], false)
      setElementDoubleSided(chargingObjects[3], true)
      chargingObjects[4] = createObject(seexports.sModloader:getModelId("bika_garage"),607.572, -27.8817, 1001.4 - 0.3)
      processDimension(chargingObjects[4], id)
      setElementCollisionsEnabled(chargingObjects[4], false)
      setElementDoubleSided(chargingObjects[4], true)
    end
    if isElement(eff) then
      local ex, ey, ez = getVehicleDummyPosition(eff, "engine")
      if not ex then
        ex, ey, ez = 0, 0, 0
      end
      local x, y, z = getPositionFromElementOffset(eff, ex, ey * 1.1, ez + 0.1)
      local sound = playSound3D(":sVehicles/files/batt" .. math.random(1, 5) .. ".mp3", x, y, z)
      processDimension(sound, id)
      local sound = playSound3D(":sVehicles/files/battin" .. math.random(1, 2) .. ".mp3", x, y, z)
      processDimension(sound, id)
      fxAddSparks(x, y, z, 0, 0, 1)
    end
  end
end)
local currentGarageLocked = false
addEvent("loadedGarageData", true)
addEventHandler("loadedGarageData", getRootElement(), function(id, data, owner, locked, sound)
  if data then
    triggerEvent("gotWallCharger", localPlayer, false)
    triggerServerEvent("requestSuperchargerSync", localPlayer)
    currentGarageLocked = locked
    loadedGarageData = data
    loadedGarageData.isOwner = owner
    prepareGarageFloor(id)
    local sizeX = data.sizeX or 1
    local sizeY = data.sizeY or 1
    if not wallSizesX[sizeX] then
      loadedGarageData.sizeX = 1
      sizeX = 1
    end
    if not wallSizesY[sizeY] then
      loadedGarageData.sizeY = 1
      sizeY = 1
    end
    local furnishing = data.furnishing or 1
    if furnishing < 1 or 2 < furnishing then
      furnishing = 1
    end
    if isElement(garageObjects.int) then
      setElementPosition(garageObjects.int, baseX, baseY, baseZ)
    else
      garageObjects.int = createObject(seexports.sModloader:getModelId("garage_int"), baseX, baseY, baseZ)
    end
    if isElement(garageObjects.furniture) then
      setElementModel(garageObjects.furniture, seexports.sModloader:getModelId("garage_furnitures_" .. furnishing))
      setElementPosition(garageObjects.furniture, baseX, baseY, baseZ)
    else
      garageObjects.furniture = createObject(seexports.sModloader:getModelId("garage_furnitures_" .. furnishing), baseX, baseY, baseZ)
      setElementDoubleSided(garageObjects.furniture, true)
    end
    if isElement(garageObjects.wall1) then
      setElementModel(garageObjects.wall1, seexports.sModloader:getModelId("garage_wall_1_" .. furnishing))
      setElementPosition(garageObjects.wall1, baseX, baseY + wallSizesX[sizeX], baseZ)
    else
      garageObjects.wall1 = createObject(seexports.sModloader:getModelId("garage_wall_1_" .. furnishing), baseX, baseY + wallSizesX[sizeX], baseZ)
      setElementDoubleSided(garageObjects.wall1, true)
    end
    if isElement(garageObjects.wall2) then
      setElementModel(garageObjects.wall2, seexports.sModloader:getModelId("garage_wall_2_" .. furnishing))
      setElementPosition(garageObjects.wall2, baseX + wallSizesY[sizeY], baseY, baseZ)
    else
      garageObjects.wall2 = createObject(seexports.sModloader:getModelId("garage_wall_2_" .. furnishing), baseX + wallSizesY[sizeY], baseY, baseZ)
      setElementDoubleSided(garageObjects.wall2, true)
    end
    if loadedGarageData.kruton == 1 then
      if not isElement(garageObjects.kruton) then
        garageObjects.kruton = createObject(seexports.sModloader:getModelId("kruton"), baseX - 14.6352, baseY - 14.9, baseZ, 0, 0, 90)
        setElementDoubleSided(garageObjects.kruton, true)
      end
      processDimension(garageObjects.kruton, id)
    else
      if isElement(garageObjects.kruton) then
        destroyElement(garageObjects.kruton)
      end
      garageObjects.kruton = nil
    end
    if loadedGarageData.plugsight == 1 then
      triggerEvent("gotWallCharger", localPlayer, id)
    end
    if loadedGarageData.workbench == 1 then
      if not isElement(garageObjects.workbench) then
        garageObjects.workbench = createObject(seexports.sModloader:getModelId("v4_workbench"), baseX - 7.2321, baseY - 19.3982, baseZ + 0.4747, 0, 0, 0)
      end
      processDimension(garageObjects.workbench, id)
    else
      if isElement(garageObjects.workbench) then
        destroyElement(garageObjects.workbench)
      end
      garageObjects.workbench = nil
    end
    if isElement(toolboxTexture) then
      destroyElement(toolboxTexture)
    end
    local door = data.door
    if door > textureNum.door or door < 1 then
      door = 1
    end
    doorTexture = dxCreateTexture("files/door/" .. door .. ".png")
    dxSetShaderValue(doorShader, "ReplacedTexture", doorTexture)
    local toolbox = data.toolbox
    if toolbox > textureNum.toolbox or toolbox < 1 then
      toolbox = 1
    end
    toolboxTexture = dxCreateTexture("files/toolbox/" .. toolbox .. ".png")
    dxSetShaderValue(toolboxShader, "ReplacedTexture", toolboxTexture)
    if isElement(wallTexture) then
      destroyElement(wallTexture)
    end
    local wall = data.wall
    if wall > textureNum.wall or wall < 1 then
      wall = 1
    end
    wallTexture = dxCreateTexture("files/wall/" .. wall .. ".png")
    dxSetShaderValue(wallShader, "ReplacedTexture", wallTexture)
    if isElement(ceilingTexture) then
      destroyElement(ceilingTexture)
    end
    local ceiling = data.ceiling
    if ceiling > textureNum.ceiling or ceiling < 1 then
      ceiling = 1
    end
    ceilingTexture = dxCreateTexture("files/ceiling/" .. ceiling .. ".png")
    dxSetShaderValue(ceilingShader, "ReplacedTexture", ceilingTexture)
    if isElement(floorTexture) then
      destroyElement(floorTexture)
    end
    local floor = data.floor
    if floor > textureNum.floor or floor < 1 then
      floor = 1
    end
    floorTexture = dxCreateTexture("files/floor/" .. floor .. ".png")
    dxSetShaderValue(floorShader, "ReplacedTexture", floorTexture)
    setElementAlpha(garageObjects.floor, floorAlpha[floor])
    processDimension(garageObjects.int, id)
    processDimension(garageObjects.furniture, id)
    processDimension(garageObjects.wall1, id)
    processDimension(garageObjects.wall2, id)
    drawBlueprint()
    if garageWindow then
      openGaragePanel()
    end
    if id < 0 then
      seexports.sPaintshop:loadedGarageData(id)
    end
    if sound then
      playSound(":sInterioredit/files/sound/construct2.mp3")
    end
  else
    prepareGarageFloor()
  end
end)
addEvent("toggleGarageLiftState", true)
addEventHandler("toggleGarageLiftState", getRootElement(), function(i, state)
  if state and (not liftSounds[i] or not isElement(liftSounds[i][1])) then
    local bx, by, bz = baseX + liftLayout[i][1], baseY + liftLayout[i][2], baseZ
    liftSounds[i] = {
      playSound3D("files/lift.mp3", bx, by, bz, true),
      bx,
      by,
      bz
    }
    processDimension(liftSounds[i][1], loadedGarageData.interiorId)
  end
  liftStates[i] = state
end)
function getPositionFromElementOffset(element, offX, offY, offZ)
  local m = getElementMatrix(element)
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z
end
local btnHover = false
local screenX, screenY = guiGetScreenSize()
function garageRender()
  local now = getTickCount()
  for i = 1, #liftLayout do
    if liftSounds[i] then
      if isElement(liftSounds[i][1]) then
        local delta = getSoundPosition(liftSounds[i][1]) * 1000
        if liftStates[i] then
          if 1110 < delta then
            setSoundPosition(liftSounds[i][1], 0.638 + (delta - 1100) % 1100 / 1000)
          end
          if 638 < delta and now - (lastClick[i] or 0) > 2500 then
            lastClick[i] = now
            local sound = playSound3D("files/lift2.mp3", liftSounds[i][2], liftSounds[i][3], liftSounds[i][4], false)
            setSoundVolume(sound, 0.75)
            processDimension(sound, loadedGarageData.interiorId)
          end
        else
          if delta < 1100 then
            setSoundPosition(liftSounds[i][1], 1.1 + (delta - 638) / 1000)
          end
          if 2092 < delta then
            destroyElement(liftSounds[i][1])
            liftSounds[i] = nil
          end
        end
      else
        liftSounds[i] = nil
      end
    end
  end
  if loadedGarageData then
    local tmp = false
    local px, py, pz = getElementPosition(localPlayer)
    local cx, cy = getCursorPosition()
    if cx then
      cx = cx * screenX
      cy = cy * screenY
    end
    if not garageWindow and loadedGarageData.isOwner then
      local x, y, z = baseX - 14.07, baseY - 12.2109, baseZ + 1.04948
      if 2 > getDistanceBetweenPoints3D(x, y, z, px, py, pz) then
        local x, y = getScreenFromWorldPosition(x, y, z, 48)
        if x then
          dxDrawRectangle(x - 26, y - 26, 52, 52, btnBcg)
          if cx and cx <= x + 26 and cx >= x - 26 and cy >= y - 26 and cy <= y + 26 then
            dxDrawImage(x - 24, y - 24, 48, 48, "files/bpicon.png", 0, 0, 0, btnCol)
            tmp = "bp"
          else
            dxDrawImage(x - 24, y - 24, 48, 48, "files/bpicon.png")
          end
        end
      end
    elseif garageWindow then
      local x, y, z = baseX - 14.07, baseY - 12.2109, baseZ + 1.04948
      if 2 < getDistanceBetweenPoints3D(x, y, z, px, py, pz) then
        closeGaragePanel()
      end
    end
    if loadedGarageData.kruton == 1 then
      local x, y, z = baseX - 14.6352, baseY - 14.9, baseZ + 1
      if 2 > getDistanceBetweenPoints3D(x, y, z, px, py, pz) then
        local x, y = getScreenFromWorldPosition(x, y, z, 48)
        if x then
          dxDrawRectangle(x - 26, y - 26, 52, 52, btnBcg)
          if cx and cx <= x + 26 and cx >= x - 26 and cy >= y - 26 and cy <= y + 26 then
            dxDrawImage(x - 24, y - 24, 48, 48, "files/kruton.png", 0, 0, 0, btnCol)
            tmp = "kruton"
          else
            dxDrawImage(x - 24, y - 24, 48, 48, "files/kruton.png")
          end
        end
      end
    end
    local x, y, z = baseX - 14.3858, baseY - 16.7694, baseZ + 1.36682
    if isElement(chargingVehicle) then
      local obj = chargingObjects[1]
      local red = chargingObjects[2]
      local black = chargingObjects[3]
      local obj2 = chargingObjects[4]
      local redX2, redY2, redZ2 = 607.6705, -27.926299999999998, 1001.4 - 0.3
      local blackX2, blackY2, blackZ2 = 607.65421, -27.835442999999998, 1001.4 - 0.3
      local ex, ey, ez = getVehicleDummyPosition(chargingVehicle, "engine")
      local rx, ry, rz = getElementRotation(chargingVehicle)
      if ey < 0 then
        rz = rz + 180
      end
      x, y, z = getPositionFromElementOffset(chargingVehicle, ex, ey * 1.1, ez + 0.1)
      setElementPosition(obj, x, y, z)
      setElementRotation(obj, 0, 0, rz)
      rz = math.rad(rz)
      local redX, redY, redZ = x - 0.050096 * math.cos(rz) - 0.704467 * math.sin(rz), y - 0.050096 * math.sin(rz) + 0.704467 * math.cos(rz), z - 0.297132
      local rgz = 1001.4 - 1.5
      local blackX, blackY, blackZ = x + 0.276453 * math.cos(rz) - 0.704467 * math.sin(rz), y + 0.276453 * math.sin(rz) + 0.704467 * math.cos(rz), z - 0.297132
      local bgz = 1001.4 - 1.5
      local rgz2 = 1001.4 - 1.5
      local bgz2 = 1001.4 - 1.5
      setElementPosition(red, redX, redY, redZ)
      setElementPosition(black, blackX, blackY, blackZ)
      local dr = getDistanceBetweenPoints3D(redX, redY, redZ, redX2, redY2, redZ2)
      local db = getDistanceBetweenPoints3D(blackX, blackY, blackZ, blackX2, blackY2, blackZ2)
      setObjectScale(red, 1, dr / 0.986118, math.min(redZ - rgz, redZ2 - rgz2))
      setObjectScale(black, 1, db / 0.986118, math.min(blackZ - bgz, blackZ2 - bgz2))
      local rr = math.deg(math.atan2(redY2 - redY, redX2 - redX)) - 90
      local rb = math.deg(math.atan2(blackY2 - blackY, blackX2 - blackX)) - 90
      local rr2 = math.deg(math.asin((redZ2 - redZ) / dr))
      local rb2 = math.deg(math.asin((blackZ2 - blackZ) / db))
      setElementRotation(red, rr2, 0, rr)
      setElementRotation(black, rb2, 0, rb)
    end
    if getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 1.65 then
      local x, y = getScreenFromWorldPosition(x, y, z, 48)
      if x then
        dxDrawRectangle(x - 26, y - 26, 52, 52, btnBcg)
        if cx and cx <= x + 26 and cx >= x - 26 and cy >= y - 26 and cy <= y + 26 then
          dxDrawImage(x - 21, y - 21, 42, 42, dynamicImage(":sVehicles/files/" .. (chargingVehicle and "clip2" or "clip") .. ".dds"), 0, 0, 0, chargingVehicle and btnCol2 or btnCol)
          tmp = "charger"
        else
          dxDrawImage(x - 21, y - 21, 42, 42, dynamicImage(":sVehicles/files/" .. (chargingVehicle and "clip2" or "clip") .. ".dds"))
        end
      end
    end
    if tmp ~= btnHover then
      btnHover = tmp
      seexports.sGui:setCursorType(btnHover and "link" or "normal")
    end
  end
end
local layoutPosX = {
  228,
  276,
  341,
  397,
  481,
  593
}
local layoutPosY = {
  324,
  393,
  450
}
local liftBpPoses = {
  {260, 109},
  {499, 109},
  {133, 370},
  {320, 370},
  {499, 370}
}
function drawBlueprint()
  if isElement(bpRt) and loadedGarageData then
    dxSetRenderTarget(bpRt)
    local font = seexports.sGui:getFont("14/BebasNeueBold.otf")
    local fontScale = seexports.sGui:getFontScale("14/BebasNeueBold.otf")
    local sx = tonumber(loadedGarageData.sizeX) or 1
    local sy = tonumber(loadedGarageData.sizeY) or 1
    dxDrawImage(624, 136, 42, 42, wallTexture)
    dxDrawImage(674, 136, 42, 42, floorTexture)
    dxDrawImage(724, 136, 42, 42, ceilingTexture)
    dxDrawImage(61, 216, 82, 50, doorTexture)
    local furnishing = loadedGarageData.furnishing or 1
    if furnishing < 1 or 2 < furnishing then
      furnishing = 1
    end
    dxDrawImage(631, 207, 128, 128, "files/furnishing" .. furnishing .. ".png")
    local toolbox = loadedGarageData.toolbox
    if toolbox > textureNum.toolbox or toolbox < 1 then
      toolbox = 1
    end
    dxDrawImage(631, 336, 128, 128, "files/toolbox/pv" .. toolbox .. ".png")
    dxDrawImage(0, 0, 800, 500, "files/bpbase.png")
    dxDrawImage(25, 125, 30, 24, "files/krutonslot.png", 90, 0, 0, tocolor(255, 255, 255, 150))
    if loadedGarageData.workbench == 1 then
      dxDrawImage(16, 113, 48, 48, "files/workbench.png")
    else
      dxDrawImage(8, 125, 64, 24, "files/lifts/0.png", 0, 0, 0, tocolor(255, 255, 255, 255))
    end
    dxDrawImage(84, 24, 30, 24, "files/krutonslot.png", 0, 0, 0, tocolor(255, 255, 255, 150))
    dxDrawImage(54, 24, 30, 24, "files/krutonslot.png", 0, 0, 0, tocolor(255, 255, 255, 150))
    if loadedGarageData.kruton == 1 then
      dxDrawImage(91, 28, 16, 16, "files/krutonbp.png")
    else
      dxDrawImage(67, 24, 64, 24, "files/lifts/0.png", 0, 0, 0, tocolor(255, 255, 255, 255))
    end
    if loadedGarageData.plugsight == 1 then
      dxDrawImage(59, 28, 16, 16, "files/krutonbp.png")
    else
      dxDrawImage(42, 24, 64, 24, "files/lifts/0.png", 0, 0, 0, tocolor(255, 255, 255, 255))
    end
    dxDrawText("Burkolatok:", 695, 0, 695, 128, tocolor(255, 255, 255), fontScale, font, "center", "bottom")
    dxDrawText("Berendezés:", 695, 0, 695, 222, tocolor(255, 255, 255), fontScale, font, "center", "bottom")
    dxDrawText("Szekrények:", 695, 0, 695, 352, tocolor(255, 255, 255), fontScale, font, "center", "bottom")
    dxDrawText("Szélesség: " .. sx .. "\nHosszúság: " .. sy, 695, 30, 695, 100, tocolor(255, 255, 255), fontScale, font, "center", "center")
    dxDrawImageSection(0, 0, layoutPosX[sx], layoutPosY[sy], 0, 0, layoutPosX[sx], layoutPosY[sy], "files/bp_furn" .. furnishing .. ".png")
    dxDrawImageSection(0, layoutPosY[sy] - layoutPosY[#layoutPosY], layoutPosX[sx], 500, 0, 0, layoutPosX[sx], 500, "files/bp_furn" .. furnishing .. "_w1.png")
    dxDrawImageSection(layoutPosX[sx] - layoutPosX[#layoutPosX], 0, 800, layoutPosY[sy], 0, 0, 800, layoutPosY[sy], "files/bp_furn" .. furnishing .. "_w2.png")
    dxDrawRectangle(32, 25, 1, layoutPosY[#layoutPosY] - 30 + 10, tocolor(255, 255, 255, 100))
    dxDrawRectangle(27, 29, layoutPosX[#layoutPosX] - 32 + 10, 1, tocolor(255, 255, 255, 100))
    for x = sx, #layoutPosX do
      dxDrawRectangle(layoutPosX[x], 25, 1, layoutPosY[#layoutPosY] - 30 + 10, tocolor(255, 255, 255, 100))
    end
    for y = sy, #layoutPosY do
      dxDrawRectangle(27, layoutPosY[y], layoutPosX[#layoutPosX] - 32 + 10, 1, tocolor(255, 255, 255, 100))
    end
    for i = 1, #liftBpPoses do
      if sx >= liftLayout[i][4] and sy >= liftLayout[i][5] then
        if loadedGarageData["lift" .. i] == 1 then
          dxDrawImage(liftBpPoses[i][1] - 64, liftBpPoses[i][2] - 24, 128, 48, "files/slot.png", 0, 0, 0, tocolor(255, 255, 255, 100))
          dxDrawImage(liftBpPoses[i][1] - 64, liftBpPoses[i][2] - 24, 128, 48, "files/lifts/1.png", liftLayout[i][3] - 90, 0, 0, tocolor(255, 255, 255, 255))
        elseif loadedGarageData["lift" .. i] == 2 then
          dxDrawImage(liftBpPoses[i][1] - 64, liftBpPoses[i][2] - 64, 128, 128, "files/slotbig.png", 0, 0, 0, tocolor(255, 255, 255, 100))
          dxDrawImage(liftBpPoses[i][1] - 64, liftBpPoses[i][2] - 64, 128, 128, "files/lifts/2.png", liftLayout[i][3] - 90, 0, 0, tocolor(255, 255, 255, 255))
        else
          dxDrawImage(liftBpPoses[i][1] - 64, liftBpPoses[i][2] - 24, 128, 48, "files/slot.png", 0, 0, 0, tocolor(255, 255, 255, 150))
          dxDrawImage(liftBpPoses[i][1] - 64, liftBpPoses[i][2] - 24, 128, 48, "files/lifts/0.png", 0, 0, 0, tocolor(255, 255, 255, 255))
        end
      else
        dxDrawImage(liftBpPoses[i][1] - 64, liftBpPoses[i][2] - 24, 128, 48, "files/slot.png", 0, 0, 0, tocolor(255, 255, 255, 60))
      end
    end
    dxDrawRectangle(32, 25, 1, layoutPosY[sy] - 30 + 10, tocolor(255, 255, 255))
    dxDrawRectangle(27, 29, layoutPosX[sx] - 32 + 10, 1, tocolor(255, 255, 255))
    dxDrawRectangle(layoutPosX[sx], 25, 1, layoutPosY[sy] - 30 + 10, tocolor(255, 255, 255))
    dxDrawRectangle(27, layoutPosY[sy], layoutPosX[sx] - 32 + 10, 1, tocolor(255, 255, 255))
    if sy < #layoutPosY then
      dxDrawImage(32 + (layoutPosX[sx] - 32) / 2 - 32, layoutPosY[sy], 64, 64, "files/caret.png")
    end
    if sx < #layoutPosX then
      dxDrawImage(layoutPosX[sx], 30 + (layoutPosY[sy] - 30) / 2 - 32, 64, 64, "files/caret.png", 270)
    end
    local font = seexports.sGui:getFont("15/BebasNeueBold.otf")
    local fontScale = seexports.sGui:getFontScale("15/BebasNeueBold.otf")
    if 0 > loadedGarageData.interiorId then
      dxDrawText("Garázs #" .. math.abs(loadedGarageData.interiorId) .. " - " .. seexports.sPaintshop:formatGarageName(loadedGarageData.interiorId), 0, 450, 800, 500, tocolor(255, 255, 255), fontScale, font, "center", "center")
    else
      dxDrawText("[" .. loadedGarageData.interiorId .. "] " .. (seexports.sInteriors:getInteriorName(loadedGarageData.interiorId) or "n/a"), 0, 450, 800, 500, tocolor(255, 255, 255), fontScale, font, "center", "center")
    end
    dxSetRenderTarget()
  end
end
local promptSelectionButtons = {}
function closeGaragePanel()
  if garageWindow then
    seexports.sGui:deleteGuiElement(garageWindow)
  end
  garageWindow = nil
  promptSelectionButtons = {}
end
addEvent("closeGaragePanel", false)
addEventHandler("closeGaragePanel", getRootElement(), closeGaragePanel)
local garageBuyingItem = false
local garageBuyingValue = false
addEvent("extendGarageX", false)
addEventHandler("extendGarageX", getRootElement(), function()
  local sx = (tonumber(loadedGarageData.sizeX) or 1) + 1
  if wallSizesX[sx] then
    garageBuyingItem = "sizeX"
    garageBuyingValue = sx
    createGarageBuyPrompt()
  end
end)
addEvent("extendGarageY", false)
addEventHandler("extendGarageY", getRootElement(), function()
  local sy = (tonumber(loadedGarageData.sizeY) or 1) + 1
  if wallSizesY[sy] then
    garageBuyingItem = "sizeY"
    garageBuyingValue = sy
    createGarageBuyPrompt()
  end
end)
addEvent("buyGarageWorkbench", false)
addEventHandler("buyGarageWorkbench", getRootElement(), function()
  if loadedGarageData.workbench ~= 1 then
    garageBuyingItem = "workbench"
    garageBuyingValue = 1
    createGarageBuyPrompt()
  end
end)
addEvent("buyGarageKruton", false)
addEventHandler("buyGarageKruton", getRootElement(), function()
  if loadedGarageData.kruton ~= 1 then
    garageBuyingItem = "kruton"
    garageBuyingValue = 1
    createGarageBuyPrompt()
  end
end)
addEvent("buyGaragePlugSight", false)
addEventHandler("buyGaragePlugSight", getRootElement(), function()
  if loadedGarageData.plugsight ~= 1 then
    garageBuyingItem = "plugsight"
    garageBuyingValue = 1
    createGarageBuyPrompt()
  end
end)
addEvent("garageBuyItemResponse", true)
addEventHandler("garageBuyItemResponse", getRootElement(), function()
  buyingProcess = false
end)
addEvent("tryToBuyGarageItem", false)
addEventHandler("tryToBuyGarageItem", getRootElement(), function()
  local sy = (tonumber(loadedGarageData.sizeY) or 1) + 1
  if garageBuyingItem and garageBuyingValue then
    openGaragePanel()
    buyingProcess = true
    triggerServerEvent("tryToBuyGarageItem", localPlayer, garageBuyingItem, garageBuyingValue)
  end
end)
addEvent("openGarageTextureBrowser", false)
addEventHandler("openGarageTextureBrowser", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if promptSelectionButtons[el] then
    garageBuyingItem = promptSelectionButtons[el]
    createGarageTexturePrompt()
  end
end)
addEvent("openGarageFurnishingSelector", false)
addEventHandler("openGarageFurnishingSelector", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  createGarageFurnishingPrompt()
end)
addEvent("openGarageLiftBrowser", false)
addEventHandler("openGarageLiftBrowser", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if tonumber(promptSelectionButtons[el]) then
    garageBuyingItem = "lift" .. tonumber(promptSelectionButtons[el])
    createGarageLiftPrompt()
  end
end)
addEvent("selectedGarageLiftType", false)
addEventHandler("selectedGarageLiftType", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  if tonumber(promptSelectionButtons[el]) then
    garageBuyingValue = tonumber(promptSelectionButtons[el])
    createGarageBuyPrompt()
  end
end)
addEvent("selectGarageFurnishingType", false)
addEventHandler("selectGarageFurnishingType", getRootElement(), function(button, state, absoluteX, absoluteY, el)
  garageBuyingItem = "furnishing"
  garageBuyingValue = tonumber(promptSelectionButtons[el])
  createGarageBuyPrompt()
end)
function createGarageFurnishingPrompt()
  garageBuyingItem = "furnishing"
  if buyingProcess then
    return
  end
  closeGaragePanel()
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local n = 2
  local w = 128
  local pw = w * 2 + 8
  local ph = titleBarHeight + w + 64
  garageWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
  seexports.sGui:setWindowTitle(garageWindow, "16/BebasNeueRegular.otf", "Garázs kezelése")
  seexports.sGui:setWindowCloseButton(garageWindow, "openGaragePanel")
  for i = 1, 2 do
    local img = seexports.sGui:createGuiElement("image", 8 + (i - 1) % n * w, titleBarHeight + 8, w - 8, w - 8, garageWindow)
    seexports.sGui:setImageFile(img, ":sGarages/files/furnishing" .. i .. ".png")
    local label = seexports.sGui:createGuiElement("label", 8 + (i - 1) % n * w, titleBarHeight + w, w, 64, garageWindow)
    seexports.sGui:setLabelAlignment(label, "center", "center")
    seexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
    if loadedGarageData.furnishing == i then
      seexports.sGui:setLabelText(label, (i == 1 and "Normál" or "Modern") .. "\n" .. "Jelenlegi")
    else
      seexports.sGui:setGuiHoverable(img, true)
      seexports.sGui:setClickEvent(img, "selectGarageFurnishingType")
      promptSelectionButtons[img] = i
      seexports.sGui:setLabelText(label, (i == 1 and "Normál" or "Modern") .. "\n" .. formatPrice(garageBuyingItem, i))
    end
  end
end
function createGarageTexturePrompt()
  if textureNum[garageBuyingItem] then
    if buyingProcess then
      return
    end
    closeGaragePanel()
    local titleBarHeight = seexports.sGui:getTitleBarHeight()
    local n = 7
    local w = 110
    local pw = w * math.min(n, textureNum[garageBuyingItem]) + 8
    local h = w
    if garageBuyingItem == "door" then
      h = 80
    end
    local ph = titleBarHeight + (h + 32) * math.ceil(textureNum[garageBuyingItem] / n)
    garageWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
    seexports.sGui:setWindowTitle(garageWindow, "16/BebasNeueRegular.otf", "Garázs kezelése")
    seexports.sGui:setWindowCloseButton(garageWindow, "openGaragePanel")
    for i = 1, textureNum[garageBuyingItem] do
      local img = seexports.sGui:createGuiElement("image", 8 + (i - 1) % n * w, titleBarHeight + (math.ceil(i / n) - 1) * (h + 32) + 8, w - 8, h - 8, garageWindow)
      if garageBuyingItem == "toolbox" then
        seexports.sGui:setImageFile(img, ":sGarages/files/" .. garageBuyingItem .. "/pv" .. i .. ".png")
      else
        seexports.sGui:setImageFile(img, ":sGarages/files/" .. garageBuyingItem .. "/" .. i .. ".png")
      end
      local label = seexports.sGui:createGuiElement("label", 8 + (i - 1) % n * w, titleBarHeight + (math.ceil(i / n) - 1) * (h + 32) + h, w, 32, garageWindow)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      seexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
      if loadedGarageData[garageBuyingItem] == i then
        seexports.sGui:setLabelText(label, "Jelenlegi")
      else
        seexports.sGui:setGuiHoverable(img, true)
        seexports.sGui:setClickEvent(img, "selectedGarageLiftType")
        promptSelectionButtons[img] = i
        seexports.sGui:setLabelText(label, formatPrice(garageBuyingItem, i))
      end
    end
  end
end
function createGarageLiftPrompt()
  if loadedGarageData[garageBuyingItem] then
    if buyingProcess then
      return
    end
    closeGaragePanel()
    local titleBarHeight = seexports.sGui:getTitleBarHeight()
    local w = 128
    local pw = w * 3 + 8
    local ph = titleBarHeight + w + 32
    garageWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
    seexports.sGui:setWindowTitle(garageWindow, "16/BebasNeueRegular.otf", "Garázs kezelése")
    seexports.sGui:setWindowCloseButton(garageWindow, "openGaragePanel")
    for i = 0, 2 do
      local img = seexports.sGui:createGuiElement("image", 8 + i * w, titleBarHeight + 8, w - 8, w - 8, garageWindow)
      seexports.sGui:setImageFile(img, ":sGarages/files/lifts/pv" .. i .. ".png")
      local label = seexports.sGui:createGuiElement("label", 8 + i * w, titleBarHeight + w, w, 32, garageWindow)
      seexports.sGui:setLabelAlignment(label, "center", "center")
      seexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
      if loadedGarageData[garageBuyingItem] == i then
        seexports.sGui:setLabelText(label, "Jelenlegi")
      else
        seexports.sGui:setGuiHoverable(img, true)
        seexports.sGui:setClickEvent(img, "selectedGarageLiftType")
        promptSelectionButtons[img] = i
        seexports.sGui:setLabelText(label, formatPrice(garageBuyingItem, i))
      end
    end
  end
end
function createGarageBuyPrompt()
  local name = getItemName(garageBuyingItem, garageBuyingValue)
  if name then
    if buyingProcess then
      return
    end
    closeGaragePanel()
    local titleBarHeight = seexports.sGui:getTitleBarHeight()
    local pw = 300
    local ph = titleBarHeight + 128 + 16
    garageWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
    seexports.sGui:setWindowTitle(garageWindow, "16/BebasNeueRegular.otf", "Garázs kezelése")
    local label = seexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, 32, garageWindow)
    seexports.sGui:setLabelAlignment(label, "center", "center")
    seexports.sGui:setLabelText(label, "Biztosan szeretnéd megvenni?")
    seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
    local label = seexports.sGui:createGuiElement("label", 0, titleBarHeight + 32, pw, 32, garageWindow)
    seexports.sGui:setLabelAlignment(label, "center", "center")
    seexports.sGui:setLabelText(label, name)
    seexports.sGui:setLabelColor(label, "sightgreen")
    seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    local label = seexports.sGui:createGuiElement("label", 0, titleBarHeight + 64, pw, 32, garageWindow)
    seexports.sGui:setLabelAlignment(label, "center", "center")
    seexports.sGui:setLabelText(label, "Ár: " .. formatPrice(garageBuyingItem, garageBuyingValue))
    seexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
    local btn = seexports.sGui:createGuiElement("button", 8, ph - 32 - 8, (pw - 16) / 2 - 4, 32, garageWindow)
    seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightgreen",
      "sightgreen-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setClickEvent(btn, "tryToBuyGarageItem")
    seexports.sGui:setButtonText(btn, "Igen")
    local btn = seexports.sGui:createGuiElement("button", pw / 2 + 4, ph - 32 - 8, (pw - 16) / 2 - 4, 32, garageWindow)
    seexports.sGui:setGuiBackground(btn, "solid", "sightred")
    seexports.sGui:setGuiHover(btn, "gradient", {
      "sightred",
      "sightred-second"
    }, false, true)
    seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
    seexports.sGui:setClickEvent(btn, "openGaragePanel")
    seexports.sGui:setButtonText(btn, "Nem")
  end
end
function openGaragePanel()
  closeGaragePanel()
  if loadedGarageData then
    drawBlueprint()
    local titleBarHeight = seexports.sGui:getTitleBarHeight()
    local pw = 816
    local ph = 516 + titleBarHeight
    garageWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
    seexports.sGui:setWindowTitle(garageWindow, "16/BebasNeueRegular.otf", "Garázs kezelése")
    seexports.sGui:setWindowCloseButton(garageWindow, "closeGaragePanel")
    local sx = tonumber(loadedGarageData.sizeX) or 1
    local sy = tonumber(loadedGarageData.sizeY) or 1
    local img = seexports.sGui:createGuiElement("image", 8, titleBarHeight + 8, 800, 500, garageWindow)
    seexports.sGui:setImageFile(img, bpRt)
    if sy < #layoutPosY then
      local rect = seexports.sGui:createGuiElement("rectangle", 32 + (layoutPosX[sx] - 32) / 2 - 32, layoutPosY[sy], 64, 64, img)
      seexports.sGui:setGuiBackground(rect, "solid", {
        0,
        0,
        0,
        0
      })
      seexports.sGui:setGuiHover(rect, "none")
      seexports.sGui:setGuiHoverable(rect, true)
      seexports.sGui:setClickEvent(rect, "extendGarageY")
      seexports.sGui:guiSetTooltip(rect, "Hosszúság növelése")
    end
    if sx < #layoutPosX then
      local rect = seexports.sGui:createGuiElement("rectangle", layoutPosX[sx], 30 + (layoutPosY[sy] - 30) / 2 - 32, 64, 64, img)
      seexports.sGui:setGuiBackground(rect, "solid", {
        0,
        0,
        0,
        0
      })
      seexports.sGui:setGuiHover(rect, "none")
      seexports.sGui:setGuiHoverable(rect, true)
      seexports.sGui:setClickEvent(rect, "extendGarageX")
      seexports.sGui:guiSetTooltip(rect, "Szélesség növelése")
    end
    if loadedGarageData.kruton ~= 1 then
      local rect = seexports.sGui:createGuiElement("rectangle", 84, 24, 30, 24, img)
      seexports.sGui:setGuiBackground(rect, "solid", {
        0,
        0,
        0,
        0
      })
      seexports.sGui:setGuiHover(rect, "none")
      seexports.sGui:setGuiHoverable(rect, true)
      seexports.sGui:setClickEvent(rect, "buyGarageKruton")
      seexports.sGui:guiSetTooltip(rect, "Kruton diagnosztikai eszköz megvásárlása")
    end
    if loadedGarageData.plugsight ~= 1 then
      local rect = seexports.sGui:createGuiElement("rectangle", 54, 24, 30, 24, img)
      seexports.sGui:setGuiBackground(rect, "solid", {
        0,
        0,
        0,
        0
      })
      seexports.sGui:setGuiHover(rect, "none")
      seexports.sGui:setGuiHoverable(rect, true)
      seexports.sGui:setClickEvent(rect, "buyGaragePlugSight")
      seexports.sGui:guiSetTooltip(rect, "PlugSight falitöltő megvásárlása")
    end
    if loadedGarageData.workbench ~= 1 then
      local rect = seexports.sGui:createGuiElement("rectangle", 28, 122, 24, 30, img)
      seexports.sGui:setGuiBackground(rect, "solid", {
        0,
        0,
        0,
        0
      })
      seexports.sGui:setGuiHover(rect, "none")
      seexports.sGui:setGuiHoverable(rect, true)
      seexports.sGui:setClickEvent(rect, "buyGarageWorkbench")
      seexports.sGui:guiSetTooltip(rect, "Barkácsasztal megvásárlása")
    end
    for i = 1, #liftBpPoses do
      if sx >= liftLayout[i][4] and sy >= liftLayout[i][5] then
        local rect = seexports.sGui:createGuiElement("rectangle", liftBpPoses[i][1] - 44, liftBpPoses[i][2] - 58, 88, 116, img)
        seexports.sGui:setGuiBackground(rect, "solid", {
          0,
          0,
          0,
          0
        })
        seexports.sGui:setGuiHover(rect, "none")
        seexports.sGui:setGuiHoverable(rect, true)
        seexports.sGui:setClickEvent(rect, "openGarageLiftBrowser")
        seexports.sGui:guiSetTooltip(rect, "Emelő " .. i)
        promptSelectionButtons[rect] = i
      else
        local rect = seexports.sGui:createGuiElement("rectangle", liftBpPoses[i][1] - 44, liftBpPoses[i][2] - 58, 88, 116, img)
        seexports.sGui:setGuiBackground(rect, "solid", {
          0,
          0,
          0,
          0
        })
        seexports.sGui:setGuiHover(rect, "none")
        seexports.sGui:setGuiHoverable(rect, true)
        seexports.sGui:guiSetTooltip(rect, "Emelő " .. i .. " (nem elérhető a méret miatt!)")
      end
    end
    local rect = seexports.sGui:createGuiElement("rectangle", 622, 133, 46, 58, img)
    seexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    seexports.sGui:setGuiHover(rect, "none")
    seexports.sGui:setGuiHoverable(rect, true)
    seexports.sGui:setClickEvent(rect, "openGarageTextureBrowser")
    seexports.sGui:guiSetTooltip(rect, "Fal")
    promptSelectionButtons[rect] = "wall"
    local rect = seexports.sGui:createGuiElement("rectangle", 672, 133, 46, 58, img)
    seexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    seexports.sGui:setGuiHover(rect, "none")
    seexports.sGui:setGuiHoverable(rect, true)
    seexports.sGui:setClickEvent(rect, "openGarageTextureBrowser")
    seexports.sGui:guiSetTooltip(rect, "Padló")
    promptSelectionButtons[rect] = "floor"
    local rect = seexports.sGui:createGuiElement("rectangle", 722, 133, 46, 58, img)
    seexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    seexports.sGui:setGuiHover(rect, "none")
    seexports.sGui:setGuiHoverable(rect, true)
    seexports.sGui:setClickEvent(rect, "openGarageTextureBrowser")
    seexports.sGui:guiSetTooltip(rect, "Plafon")
    promptSelectionButtons[rect] = "ceiling"
    local rect = seexports.sGui:createGuiElement("rectangle", 640, 229, 110, 84, img)
    seexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    seexports.sGui:setGuiHover(rect, "none")
    seexports.sGui:setGuiHoverable(rect, true)
    seexports.sGui:setClickEvent(rect, "openGarageFurnishingSelector")
    seexports.sGui:guiSetTooltip(rect, "Berendezés")
    local rect = seexports.sGui:createGuiElement("rectangle", 640, 358, 110, 84, img)
    seexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    seexports.sGui:setGuiHover(rect, "none")
    seexports.sGui:setGuiHoverable(rect, true)
    seexports.sGui:setClickEvent(rect, "openGarageTextureBrowser")
    seexports.sGui:guiSetTooltip(rect, "Szekrények")
    promptSelectionButtons[rect] = "toolbox"
    local rect = seexports.sGui:createGuiElement("rectangle", 61, 216, 82, 50, img)
    seexports.sGui:setGuiBackground(rect, "solid", {
      0,
      0,
      0,
      0
    })
    seexports.sGui:setGuiHover(rect, "none")
    seexports.sGui:setGuiHoverable(rect, true)
    seexports.sGui:setClickEvent(rect, "openGarageTextureBrowser")
    seexports.sGui:guiSetTooltip(rect, "Garázsajtó")
    promptSelectionButtons[rect] = "door"
  end
end
addEvent("openGaragePanel", false)
addEventHandler("openGaragePanel", getRootElement(), openGaragePanel)
local lastLift = 0
local liftId = false
local liftWindow = false
local lifting = false
local lastJumperTry = 0
function garageClick(key, state)
  if btnHover and state == "down" then
    if btnHover == "charger" then
      if chargingVehicle then
        triggerServerEvent("removeVehicleFromCharger", localPlayer, chargingVehicle)
        chargingVehicle = false
      elseif getElementData(localPlayer, "jumperInHand") then
        setElementData(localPlayer, "jumperInHand", false)
        triggerServerEvent("tryToGetJumperFromGarage", localPlayer, true)
      elseif getTickCount() - lastJumperTry > 1000 then
        lastJumperTry = getTickCount()
        triggerServerEvent("tryToGetJumperFromGarage", localPlayer)
      end
    elseif btnHover == "kruton" then
      seexports.sMechanic:openKrutonComputer(baseX - 14.6352, baseY - 14.9, baseZ + 1)
    elseif btnHover == "bp" then
      openGaragePanel()
    end
  elseif lifting and state == "up" and liftId then
    triggerServerEvent("stopGarageCarLift", getRootElement(), liftId)
    lifting = false
    return
  end
end
addEvent("hideGarageLiftGui", true)
addEventHandler("hideGarageLiftGui", getRootElement(), function()
  if lifting and liftId then
    triggerServerEvent("stopGarageCarLift", getRootElement(), liftId)
    lifting = false
  end
  liftId = false
  if liftWindow then
    seexports.sGui:deleteGuiElement(liftWindow)
  end
  liftWindow = false
end)
addEvent("showGarageLiftGui", true)
addEventHandler("showGarageLiftGui", getRootElement(), function(i)
  liftId = i
  local titleBarHeight = seexports.sGui:getTitleBarHeight()
  local panelWidth = 88
  local panelHeight = titleBarHeight + 32 + 8 + 8
  liftWindow = seexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
  seexports.sGui:setWindowTitle(liftWindow, "16/BebasNeueRegular.otf", "Emelő")
  local btn = seexports.sGui:createGuiElement("button", 8, titleBarHeight + 8, 32, 32, liftWindow)
  seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  })
  seexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
  seexports.sGui:setButtonTextColor(btn, "#000")
  seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("arrow-down", 32))
  seexports.sGui:setClickEvent(btn, "startGarageCarLiftDown")
  local btn = seexports.sGui:createGuiElement("button", 48, titleBarHeight + 8, 32, 32, liftWindow)
  seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
  seexports.sGui:setGuiHover(btn, "gradient", {
    "sightgreen",
    "sightgreen-second"
  })
  seexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
  seexports.sGui:setButtonTextColor(btn, "#000")
  seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("arrow-up", 32))
  seexports.sGui:setClickEvent(btn, "startGarageCarLiftUp")
end)
addEvent("startGarageCarLiftUp", true)
addEventHandler("startGarageCarLiftUp", getRootElement(), function()
  if liftId and getTickCount() - lastLift > 1000 then
    lastLift = getTickCount()
    triggerServerEvent("startGarageCarLiftUp", getRootElement(), liftId)
    lifting = true
  end
end)
addEvent("startGarageCarLiftDown", true)
addEventHandler("startGarageCarLiftDown", getRootElement(), function()
  if liftId and getTickCount() - lastLift > 1000 then
    lastLift = getTickCount()
    triggerServerEvent("startGarageCarLiftDown", getRootElement(), liftId)
    lifting = true
  end
end)
function getCurrentGarage()
  return loadedGarageData and loadedGarageData.interiorId
end
function isCurrentGarageLocked()
  return currentGarageLocked
end
function setCurrentGarageLocked(locked)
  currentGarageLocked = locked
end
