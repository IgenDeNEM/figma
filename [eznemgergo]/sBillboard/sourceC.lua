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
local billboardState = false
local sightlangDynImgHand = false
local sightlangDynImgLatCr = false
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
local sightlangModloaderLoaded = function()
  loadModels()
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
      addEventHandler("onClientRender", getRootElement(), renderBillboards, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderBillboards)
    end
  end
end
for j = 1, #billboards do
  if billboards[j][8] then
    billboards[j][3] = {
      "files/" .. billbTextures[billboards[j][8][1]] .. ".dds",
      "files/lod/" .. billbTextures[billboards[j][8][1]] .. ".dds"
    }
    billboards[j][4] = {
      "files/" .. billbTextures[billboards[j][8][1]] .. ".dds",
      "files/lod/" .. billbTextures[billboards[j][8][1]] .. ".dds"
    }
  end
  local rnd = math.random(1, billbNum)
  billboards[j][3] = {
    "files/" .. billbTextures[rnd] .. ".dds",
    "files/lod/" .. billbTextures[rnd] .. ".dds"
  }
  billboards[j][4] = {
    "files/" .. billbTextures[rnd] .. ".dds",
    "files/lod/" .. billbTextures[rnd] .. ".dds"
  }
end
addEvent("syncBillboard", true)
addEventHandler("syncBillboard", getRootElement(), function(j, d2)
  billboards[j][2] = getTickCount()
  billboards[j][4] = {
    "files/" .. billbTextures[d2] .. ".dds",
    "files/lod/" .. billbTextures[d2] .. ".dds"
  }
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  triggerServerEvent("requestBillboards", localPlayer)
end)
local streamedBillboards = {}
local streamedLods = {}
local billboardId = {}
function streamInBillboard()
  local id = billboardId[source]
  for i = #streamedBillboards, 1, -1 do
    if streamedBillboards[i] == id then
      return
    end
  end
  table.insert(streamedBillboards, id)
  sightlangCondHandl0(true)
end
function streamOutBillboard()
  local id = billboardId[source]
  for i = #streamedBillboards, 1, -1 do
    if streamedBillboards[i] == id then
      table.remove(streamedBillboards, i)
      break
    end
  end
  sightlangCondHandl0(0 < #streamedLods + #streamedBillboards)
end
function streamInBillboardLod()
  local id = billboardId[source]
  for i = #streamedLods, 1, -1 do
    if streamedLods[i] == id then
      return
    end
  end
  table.insert(streamedLods, id)
  sightlangCondHandl0(true)
end
function streamOutBillboardLod()
  local id = billboardId[source]
  for i = #streamedLods, 1, -1 do
    if streamedLods[i] == id then
      table.remove(streamedLods, i)
      break
    end
  end
  sightlangCondHandl0(0 < #streamedLods + #streamedBillboards)
end
function getPositionFromElementOffset(m, s, offX, offY, offZ)
  offX = offX * s
  offY = offY * s
  offZ = offZ * s
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z
end
local billboardMatrix = {}
function destroyBillboards()
  for k, v in pairs(billboards) do
    if v and v[1][8] then
      removeEventHandler("onClientElementStreamIn", v[1][8], streamInBillboard)
      removeEventHandler("onClientElementStreamOut", v[1][8], streamOutBillboard)
      removeEventHandler("onClientElementStreamIn", v[1][9], streamInBillboardLod)
      removeEventHandler("onClientElementStreamOut", v[1][9], streamOutBillboardLod)
      if isElement(v[1][8]) then
        destroyElement(v[1][8])
      end
      if isElement(v[1][9]) then
        destroyElement(v[1][9])
      end
      v[1][8] = nil
      v[1][9] = nil
    end
  end
  sightlangCondHandl0(false)
  billboardMatrix = {}
end
function setBillboardState(state)
  if state then
    billboardState = true
    loadModels()
  else
    billboardState = false
    destroyBillboards()
  end
end
function getBillboardState()
  return billboardState
end
function loadModels()
  if not billboardState then return end
  local model = sightexports.sModloader:getModelId("v4_billboard")
  for i = 1, #billboards do
    local s = billboards[i][1][7]
    local x, y, z, rx, ry, rz = billboards[i][1][1], billboards[i][1][2], billboards[i][1][3], billboards[i][1][4], billboards[i][1][5], billboards[i][1][6]
    if billboards[i][1] then
      if isElement(billboards[i][1][9]) then
        destroyElement(billboards[i][1][9])
      end
      billboards[i][1][9] = nil
      if isElement(billboards[i][1][9]) then
        destroyElement(billboards[i][1][9])
      end
      billboards[i][1][9] = nil
    end
    billboards[i][1][8] = createObject(model, x, y, z, rx, ry, rz, true)
    setElementCollisionsEnabled(billboards[i][1][8], false)
    setObjectScale(billboards[i][1][8], s)
    billboards[i][1][9] = createObject(model, x, y, z, rx, ry, rz)
    setElementCollisionsEnabled(billboards[i][1][9], false)
    setObjectScale(billboards[i][1][9], s)
    setLowLODElement(billboards[i][1][9], billboards[i][1][9])
    engineSetModelLODDistance(model, 100)
    billboardId[billboards[i][1][8]] = i
    billboardId[billboards[i][1][9]] = i
    addEventHandler("onClientElementStreamIn", billboards[i][1][8], streamInBillboard)
    addEventHandler("onClientElementStreamOut", billboards[i][1][8], streamOutBillboard)
    addEventHandler("onClientElementStreamIn", billboards[i][1][9], streamInBillboardLod)
    addEventHandler("onClientElementStreamOut", billboards[i][1][9], streamOutBillboardLod)
    local m = getElementMatrix(billboards[i][1][8])
    local x, y, z = getPositionFromElementOffset(m, s, 0, 0.15625, 2.5)
    local x2, y2, z2 = getPositionFromElementOffset(m, s, 0, 0.15625, -2.5)
    local x3, y3, z3 = getPositionFromElementOffset(m, s, 0, 0.3125, -2.65625)
    billboardMatrix[i] = {
      x,
      y,
      z,
      x2,
      y2,
      z2,
      x3,
      y3,
      z3,
      12.5 * s,
      s,
      m
    }
  end
end
function renderBillboards()
  if not billboardState then return end
  local now = getTickCount()
  local drawn = {}
  for i = 1, #streamedBillboards do
    local j = streamedBillboards[i]
    drawn[j] = true
    if isElementOnScreen(billboards[j][1][8]) then
      if billboards[j][2] then
        local p = (now - billboards[j][2]) / 200
        if 20 <= p then
          billboards[j][2] = false
          billboards[j][3] = billboards[j][4]
          dxDrawMaterialLine3D(billboardMatrix[j][1], billboardMatrix[j][2], billboardMatrix[j][3], billboardMatrix[j][4], billboardMatrix[j][5], billboardMatrix[j][6], latentDynamicImage(billboards[j][3][1], "dxt1"), billboardMatrix[j][10], tocolor(255, 255, 255), billboardMatrix[j][7], billboardMatrix[j][8], billboardMatrix[j][9])
        else
          local m = billboardMatrix[j][12]
          local s = billboardMatrix[j][11]
          for i = 0, 15 do
            local p = math.max(math.min(p - i * 1.25, 1), 0)
            local zi = 2.34375 - i * 0.3125
            local yp2 = math.sin(p * math.pi / 2 + math.pi / 2) * 0.3125 / 2
            local zp2 = math.cos(p * math.pi / 2 + math.pi / 2) * 0.3125 / 2
            local yp = math.sin(p * math.pi / 2) * 0.3125 / 2
            local zp = math.cos(p * math.pi / 2) * 0.3125 / 2
            local x, y, z = getPositionFromElementOffset(m, s, 0, yp - yp2, zp - zp2 + zi)
            local x2, y2, z2 = getPositionFromElementOffset(m, s, 0, yp + yp2, zp + zp2 + zi)
            local x3, y3, z3 = getPositionFromElementOffset(m, s, 0, yp * 10, zp * 10 + zi)
            dxDrawMaterialSectionLine3D(x, y, z, x2, y2, z2, 0, i * 16, 640, 16, latentDynamicImage(billboards[j][4][1], "dxt1"), billboardMatrix[j][10], tocolor(255, 255, 255), x3, y3, z3)
            local yp = yp2
            local zp = zp2
            local yp2 = math.sin(p * math.pi / 2 + math.pi / 2 + math.pi / 2) * 0.3125 / 2
            local zp2 = math.cos(p * math.pi / 2 + math.pi / 2 + math.pi / 2) * 0.3125 / 2
            local x, y, z = getPositionFromElementOffset(m, s, 0, yp - yp2, zp - zp2 + zi)
            local x2, y2, z2 = getPositionFromElementOffset(m, s, 0, yp + yp2, zp + zp2 + zi)
            local x3, y3, z3 = getPositionFromElementOffset(m, s, 0, yp * 10, zp * 10 + zi)
            dxDrawMaterialSectionLine3D(x, y, z, x2, y2, z2, 0, i * 16, 640, 16, latentDynamicImage(billboards[j][3][1], "dxt1"), billboardMatrix[j][10], tocolor(255, 255, 255), x3, y3, z3)
          end
        end
      else
        dxDrawMaterialLine3D(billboardMatrix[j][1], billboardMatrix[j][2], billboardMatrix[j][3], billboardMatrix[j][4], billboardMatrix[j][5], billboardMatrix[j][6], latentDynamicImage(billboards[j][3][1], "dxt1"), billboardMatrix[j][10], tocolor(255, 255, 255), billboardMatrix[j][7], billboardMatrix[j][8], billboardMatrix[j][9])
      end
    end
  end
  for i = 1, #streamedLods do
    local j = streamedLods[i]
    if not drawn[j] and isElement(billboards[j][1][2]) and isElementOnScreen(billboards[j][1][2]) then
      if billboards[j][2] then
        local p = (now - billboards[j][2]) / 3200
        if 1 < p then
          billboards[j][3] = billboards[j][4]
          billboards[j][2] = false
          dxDrawMaterialLine3D(billboardMatrix[j][1], billboardMatrix[j][2], billboardMatrix[j][3], billboardMatrix[j][4], billboardMatrix[j][5], billboardMatrix[j][6], latentDynamicImage(billboards[j][3][2], "dxt1"), billboardMatrix[j][10], tocolor(255, 255, 255), billboardMatrix[j][7], billboardMatrix[j][8], billboardMatrix[j][9])
        else
          dxDrawMaterialLine3D(billboardMatrix[j][1], billboardMatrix[j][2], billboardMatrix[j][3], billboardMatrix[j][4], billboardMatrix[j][5], billboardMatrix[j][6], latentDynamicImage(billboards[j][3][2], "dxt1"), billboardMatrix[j][10], tocolor(255, 255, 255, 255 * (1 - p)), billboardMatrix[j][7], billboardMatrix[j][8], billboardMatrix[j][9])
          dxDrawMaterialLine3D(billboardMatrix[j][1], billboardMatrix[j][2], billboardMatrix[j][3], billboardMatrix[j][4], billboardMatrix[j][5], billboardMatrix[j][6], latentDynamicImage(billboards[j][4][2], "dxt1"), billboardMatrix[j][10], tocolor(255, 255, 255, 255 * p), billboardMatrix[j][7], billboardMatrix[j][8], billboardMatrix[j][9])
        end
      else
        dxDrawMaterialLine3D(billboardMatrix[j][1], billboardMatrix[j][2], billboardMatrix[j][3], billboardMatrix[j][4], billboardMatrix[j][5], billboardMatrix[j][6], latentDynamicImage(billboards[j][3][2], "dxt1"), billboardMatrix[j][10], tocolor(255, 255, 255), billboardMatrix[j][7], billboardMatrix[j][8], billboardMatrix[j][9])
      end
    end
  end
end
