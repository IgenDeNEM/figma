local sightexports = {
  sCore = false,
  sVehiclenames = false,
  sGui = false
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
local sightlangBlankTex = dxCreateTexture(1, 1)
local function latentDynamicImage(img, form, mip)
  if not sightlangDynImgHand then
    sightlangDynImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre, true, "high+999999999")
  end
  sightlangDynImageForm[img] = form
  sightlangDynImageMip[img] = mip
  sightlangDynImageUsed[img] = true
  return sightlangDynImage[img] or sightlangBlankTex
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), carCarryRender, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), carCarryRender)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPedsProcessed", getRootElement(), carCarryBones, true, prio)
    else
      removeEventHandler("onClientPedsProcessed", getRootElement(), carCarryBones)
    end
  end
end
local carCarrys = {}
addEvent("playBudSpencerSound", true)
addEventHandler("playBudSpencerSound", getRootElement(), function(s)
  if isElement(source) and isElementStreamedIn(source) then
    local x, y, z = getElementPosition(source)
    local s = playSound3D("files/hit" .. s .. ".mp3", x, y, z)
    setElementInterior(s, getElementInterior(source))
    setElementDimension(s, getElementDimension(source))
    attachElements(s, source)
  end
end)
addEvent("gotCarCarryData", true)
addEventHandler("gotCarCarryData", getRootElement(), function(veh)
  if isElement(source) then
    if isElement(veh) then
      carCarrys[source] = veh
      sightlangCondHandl0(true)
      sightlangCondHandl1(true)
    else
      carCarrys[source] = nil
    end
  end
end)
function carCarryBones()
  for client in pairs(carCarrys) do
    setElementBoneRotation(client, 22, 90, 0, 90)
    setElementBoneRotation(client, 23, 0, 0, 0)
    setElementBoneRotation(client, 24, 0, 0, 0)
    setElementBoneRotation(client, 25, 0, 0, 0)
    setElementBoneRotation(client, 26, 0, 0, 0)
    setElementBoneRotation(client, 32, 90, 0, -90)
    setElementBoneRotation(client, 33, 0, 0, 0)
    setElementBoneRotation(client, 34, 0, 0, 0)
    setElementBoneRotation(client, 35, 0, 0, 0)
    setElementBoneRotation(client, 36, 0, 0, 0)
    sightexports.sCore:updateElementRpHAnim(client)
  end
end
function carCarryRender()
  for client, veh in pairs(carCarrys) do
    if isElement(veh) and isElement(client) then
      local x, y, z = getPedBonePosition(client, 22)
      local x2, y2, z2 = getPedBonePosition(client, 32)
      if x and x2 then
        x = (x + x2) / 2
        y = (y + y2) / 2
        z = (z + z2) / 2
        local rx, ry, rz = getElementRotation(client)
        local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(veh)
        z = z - (minZ or 0) + 0.25
        setElementPosition(veh, x, y, z)
        setElementRotation(veh, 0, 0, rz)
      else
        carCarrys[client] = nil
      end
    else
      carCarrys[client] = nil
    end
  end
  for client, veh in pairs(carCarrys) do
    return
  end
  sightlangCondHandl0(false)
  sightlangCondHandl1(false)
end
addEventHandler("onClientVehicleEnter", getRootElement(), function()
  setVehicleDoorOpenRatio(source, 2, 0, 0)
  setVehicleDoorOpenRatio(source, 3, 0, 0)
  setVehicleDoorOpenRatio(source, 4, 0, 0)
  setVehicleDoorOpenRatio(source, 5, 0, 0)
end)
addEventHandler("onClientElementStreamIn", getRootElement(), function()
  if getElementType(source) == "vehicle" then
    setVehicleDoorOpenRatio(source, 2, 0, 0)
    setVehicleDoorOpenRatio(source, 3, 0, 0)
    setVehicleDoorOpenRatio(source, 4, 0, 0)
    setVehicleDoorOpenRatio(source, 5, 0, 0)
    for i = 0, 6 do
      setVehiclePanelState(source, i, getVehiclePanelState(source, i))
    end
  end
end)
