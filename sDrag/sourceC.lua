local sightexports = {
  sGui = false,
  sVehiclenames = false,
  sModloader = false
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
sightlangStaticImageToc[3] = true
sightlangStaticImageToc[4] = true
sightlangStaticImageToc[5] = true
sightlangStaticImageToc[6] = true
sightlangStaticImageToc[7] = true
sightlangStaticImageToc[8] = true
sightlangStaticImageToc[9] = true
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
  if sightlangStaticImageUsed[3] then
    sightlangStaticImageUsed[3] = false
    sightlangStaticImageDel[3] = false
  elseif sightlangStaticImage[3] then
    if sightlangStaticImageDel[3] then
      if now >= sightlangStaticImageDel[3] then
        if isElement(sightlangStaticImage[3]) then
          destroyElement(sightlangStaticImage[3])
        end
        sightlangStaticImage[3] = nil
        sightlangStaticImageDel[3] = false
        sightlangStaticImageToc[3] = true
        return
      end
    else
      sightlangStaticImageDel[3] = now + 5000
    end
  else
    sightlangStaticImageToc[3] = true
  end
  if sightlangStaticImageUsed[4] then
    sightlangStaticImageUsed[4] = false
    sightlangStaticImageDel[4] = false
  elseif sightlangStaticImage[4] then
    if sightlangStaticImageDel[4] then
      if now >= sightlangStaticImageDel[4] then
        if isElement(sightlangStaticImage[4]) then
          destroyElement(sightlangStaticImage[4])
        end
        sightlangStaticImage[4] = nil
        sightlangStaticImageDel[4] = false
        sightlangStaticImageToc[4] = true
        return
      end
    else
      sightlangStaticImageDel[4] = now + 5000
    end
  else
    sightlangStaticImageToc[4] = true
  end
  if sightlangStaticImageUsed[5] then
    sightlangStaticImageUsed[5] = false
    sightlangStaticImageDel[5] = false
  elseif sightlangStaticImage[5] then
    if sightlangStaticImageDel[5] then
      if now >= sightlangStaticImageDel[5] then
        if isElement(sightlangStaticImage[5]) then
          destroyElement(sightlangStaticImage[5])
        end
        sightlangStaticImage[5] = nil
        sightlangStaticImageDel[5] = false
        sightlangStaticImageToc[5] = true
        return
      end
    else
      sightlangStaticImageDel[5] = now + 5000
    end
  else
    sightlangStaticImageToc[5] = true
  end
  if sightlangStaticImageUsed[6] then
    sightlangStaticImageUsed[6] = false
    sightlangStaticImageDel[6] = false
  elseif sightlangStaticImage[6] then
    if sightlangStaticImageDel[6] then
      if now >= sightlangStaticImageDel[6] then
        if isElement(sightlangStaticImage[6]) then
          destroyElement(sightlangStaticImage[6])
        end
        sightlangStaticImage[6] = nil
        sightlangStaticImageDel[6] = false
        sightlangStaticImageToc[6] = true
        return
      end
    else
      sightlangStaticImageDel[6] = now + 5000
    end
  else
    sightlangStaticImageToc[6] = true
  end
  if sightlangStaticImageUsed[7] then
    sightlangStaticImageUsed[7] = false
    sightlangStaticImageDel[7] = false
  elseif sightlangStaticImage[7] then
    if sightlangStaticImageDel[7] then
      if now >= sightlangStaticImageDel[7] then
        if isElement(sightlangStaticImage[7]) then
          destroyElement(sightlangStaticImage[7])
        end
        sightlangStaticImage[7] = nil
        sightlangStaticImageDel[7] = false
        sightlangStaticImageToc[7] = true
        return
      end
    else
      sightlangStaticImageDel[7] = now + 5000
    end
  else
    sightlangStaticImageToc[7] = true
  end
  if sightlangStaticImageUsed[8] then
    sightlangStaticImageUsed[8] = false
    sightlangStaticImageDel[8] = false
  elseif sightlangStaticImage[8] then
    if sightlangStaticImageDel[8] then
      if now >= sightlangStaticImageDel[8] then
        if isElement(sightlangStaticImage[8]) then
          destroyElement(sightlangStaticImage[8])
        end
        sightlangStaticImage[8] = nil
        sightlangStaticImageDel[8] = false
        sightlangStaticImageToc[8] = true
        return
      end
    else
      sightlangStaticImageDel[8] = now + 5000
    end
  else
    sightlangStaticImageToc[8] = true
  end
  if sightlangStaticImageUsed[9] then
    sightlangStaticImageUsed[9] = false
    sightlangStaticImageDel[9] = false
  elseif sightlangStaticImage[9] then
    if sightlangStaticImageDel[9] then
      if now >= sightlangStaticImageDel[9] then
        if isElement(sightlangStaticImage[9]) then
          destroyElement(sightlangStaticImage[9])
        end
        sightlangStaticImage[9] = nil
        sightlangStaticImageDel[9] = false
        sightlangStaticImageToc[9] = true
        return
      end
    else
      sightlangStaticImageDel[9] = now + 5000
    end
  else
    sightlangStaticImageToc[9] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] and sightlangStaticImageToc[9] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/light.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/bg1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/bg2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/5.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/4.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[5] = function()
  if not isElement(sightlangStaticImage[5]) then
    sightlangStaticImageToc[5] = false
    sightlangStaticImage[5] = dxCreateTexture("files/0.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[6] = function()
  if not isElement(sightlangStaticImage[6]) then
    sightlangStaticImageToc[6] = false
    sightlangStaticImage[6] = dxCreateTexture("files/stage2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[7] = function()
  if not isElement(sightlangStaticImage[7]) then
    sightlangStaticImageToc[7] = false
    sightlangStaticImage[7] = dxCreateTexture("files/stage1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[8] = function()
  if not isElement(sightlangStaticImage[8]) then
    sightlangStaticImageToc[8] = false
    sightlangStaticImage[8] = dxCreateTexture("files/stage3.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[9] = function()
  if not isElement(sightlangStaticImage[9]) then
    sightlangStaticImageToc[9] = false
    sightlangStaticImage[9] = dxCreateTexture("files/stage0.dds", "argb", true)
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
    local res0 = getResourceFromName("sVehiclenames")
    if res0 and getResourceState(res0) == "running" then
      vehnamesReady()
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
  loadModels()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local screenX, screenY = guiGetScreenSize()
local bigScreens = {}
local leftScreens = {}
local rightScreens = {}
local textureChanger = " texture gTexture; technique hello { pass P0 { Texture[0] = gTexture; } } "
local dragSlip = false
function closeDragSlip()
  if dragSlip then
    sightexports.sGui:deleteGuiElement(dragSlip)
  end
  dragSlip = false
end
function openDragSlip(data)
  closeDragSlip()
  if data then
    local w = 300
    dragSlip = sightexports.sGui:createGuiElement("image", screenX / 2 - w / 2, 0, w, 0)
    sightexports.sGui:setImageDDS(dragSlip, ":sDrag/files/paper.dds")
    local y = 10
    local label = sightexports.sGui:createGuiElement("label", 0, y, w, 20, dragSlip)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelColor(label, "#282828")
    sightexports.sGui:setLabelText(label, "DRAG VERSENY EREDMÉNY")
    y = y + 20
    local label = sightexports.sGui:createGuiElement("label", 0, y, w, 20, dragSlip)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelColor(label, "#282828")
    sightexports.sGui:setLabelText(label, "SightRing")
    y = y + 20
    local time = getRealTime(tonumber(data[11]) or 0)
    local label = sightexports.sGui:createGuiElement("label", 0, y, w, 20, dragSlip)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelColor(label, "#282828")
    sightexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute))
    y = y + 20
    local label = sightexports.sGui:createGuiElement("label", 0, y, w, 20, dragSlip)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelColor(label, "#282828")
    sightexports.sGui:setLabelText(label, "---------------------------------")
    y = y + 20 + 10
    local leftCar = false
    local rightCar = false
    if (data[1]) and 0 ~= data[1] then
      leftCar = true
      local label = sightexports.sGui:createGuiElement("label", 10, y, w - 20, 20, dragSlip)
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, "Bal pálya:")
      y = y + 20 + 5
      local label = sightexports.sGui:createGuiElement("label", 10, y, w - 20, 20, dragSlip)
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, sightexports.sVehiclenames:getCustomVehicleName(data[1]))
      y = y + 20
      local label = sightexports.sGui:createGuiElement("label", 10, y, w - 20, 20, dragSlip)
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, tostring(data[3]))
      y = y + 20
      local label = sightexports.sGui:createGuiElement("label", 10, y, w - 20, 20, dragSlip)
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, tostring(data[5]))
      y = y + 20 + 10
    else
      local label = sightexports.sGui:createGuiElement("label", 10, y, w - 20, 20, dragSlip)
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, "Bal pálya:")
      y = y + 20
      local label = sightexports.sGui:createGuiElement("label", 10, y, w - 20, 20, dragSlip)
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, "---")
      y = y + 20 + 10
    end
    if tonumber(data[2]) and data[2] > 0 then
      rightCar = true
      local label = sightexports.sGui:createGuiElement("label", 10, y, w - 20, 20, dragSlip)
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, "Jobb pálya:")
      y = y + 20 + 5
      local label = sightexports.sGui:createGuiElement("label", 10, y, w - 20, 20, dragSlip)
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, sightexports.sVehiclenames:getCustomVehicleName(data[2]))
      y = y + 20
      local label = sightexports.sGui:createGuiElement("label", 10, y, w - 20, 20, dragSlip)
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, tostring(data[4]))
      y = y + 20
      local label = sightexports.sGui:createGuiElement("label", 10, y, w - 20, 20, dragSlip)
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, tostring(data[6]))
      y = y + 20
    else
      local label = sightexports.sGui:createGuiElement("label", 10, y, w - 20, 20, dragSlip)
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, "Jobb pálya:")
      y = y + 20
      local label = sightexports.sGui:createGuiElement("label", 10, y, w - 20, 20, dragSlip)
      sightexports.sGui:setLabelClip(label, true)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, "---")
      y = y + 20
    end
    local label = sightexports.sGui:createGuiElement("label", 0, y, w, 20, dragSlip)
    sightexports.sGui:setLabelAlignment(label, "center", "center")
    sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
    sightexports.sGui:setLabelColor(label, "#282828")
    sightexports.sGui:setLabelText(label, "---------------------------------")
    y = y + 20 + 10
    local leftFail = tonumber(data[7]) == 1
    local rightFail = tonumber(data[8]) == 1
    local leftResults = data[9]
    local rightResults = data[10]
    for i = 1, #resultNames do
      local text = false
      if leftFail or not leftCar then
        text = "---"
      elseif tonumber(leftResults[i]) then
        text = string.format("%06.3f", leftResults[i])
      else
        text = "---"
      end
      local label = sightexports.sGui:createGuiElement("label", w / 2 - 48, y, 0, 20, dragSlip)
      sightexports.sGui:setLabelAlignment(label, "right", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, text)
      local label = sightexports.sGui:createGuiElement("label", 0, y, w, 20, dragSlip)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, resultNames[i][1] .. " (" .. resultNames[i][3] .. ")")
      local text = false
      if rightFail or not rightCar then
        text = "---"
      elseif tonumber(rightResults[i]) then
        text = string.format("%06.3f", rightResults[i])
      else
        text = "---"
      end
      local label = sightexports.sGui:createGuiElement("label", w / 2 + 48, y, 0, 20, dragSlip)
      sightexports.sGui:setLabelAlignment(label, "left", "center")
      sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
      sightexports.sGui:setLabelColor(label, "#282828")
      sightexports.sGui:setLabelText(label, text)
      y = y + 20 + 5
    end
    if leftCar and rightCar then
      local leftWinner = leftCar and not leftFail and (rightFail or leftResults[8] < rightResults[8])
      local rightWinner = rightCar and not rightFail and (leftFail or rightResults[8] < leftResults[8])
      if leftWinner or leftFail then
        local label = sightexports.sGui:createGuiElement("label", w / 2 - 48, y, 0, 20, dragSlip)
        sightexports.sGui:setLabelAlignment(label, "right", "center")
        sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
        sightexports.sGui:setLabelColor(label, "#282828")
        sightexports.sGui:setLabelText(label, "/\\")
        local label = sightexports.sGui:createGuiElement("label", w / 2 - 48, y + 20, 0, 20, dragSlip)
        sightexports.sGui:setLabelAlignment(label, "right", "center")
        sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
        sightexports.sGui:setLabelColor(label, "#282828")
        sightexports.sGui:setLabelText(label, leftFail and "Jumpstart" or "Győztes")
      end
      if rightWinner or rightFail then
        local label = sightexports.sGui:createGuiElement("label", w / 2 + 48, y, 0, 20, dragSlip)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
        sightexports.sGui:setLabelColor(label, "#282828")
        sightexports.sGui:setLabelText(label, "/\\")
        local label = sightexports.sGui:createGuiElement("label", w / 2 + 48, y + 20, 0, 20, dragSlip)
        sightexports.sGui:setLabelAlignment(label, "left", "center")
        sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
        sightexports.sGui:setLabelColor(label, "#282828")
        sightexports.sGui:setLabelText(label, rightFail and "Jumpstart" or "Győztes")
      end
      y = y + 20 + 20
    end
    y = y + 10
    sightexports.sGui:setGuiSize(dragSlip, false, y)
    sightexports.sGui:setGuiPosition(dragSlip, false, screenY / 2 - y / 2)
  end
end
function loadModels()
  local single = sightexports.sModloader:getModelId("SeeRing_drag_scoreboard2")
  local double = sightexports.sModloader:getModelId("SeeRing_drag_scoreboard")
  for i = 1, #bigScreens do
    if isElement(bigScreens[i]) then
      destroyElement(bigScreens[i])
    end
  end
  bigScreens = {}
  for i = 1, #leftScreens do
    if isElement(leftScreens[i]) then
      destroyElement(leftScreens[i])
    end
  end
  leftScreens = {}
  for i = 1, #rightScreens do
    if isElement(rightScreens[i]) then
      destroyElement(rightScreens[i])
    end
  end
  rightScreens = {}
  local obj = createObject(single, -1560.8135, -18.6308, 13.6771, 0, 0, 135)
  local lod = createObject(single, -1560.8135, -18.6308, 13.6771, 0, 0, 135, true)
  setLowLODElement(obj, lod)
  table.insert(bigScreens, obj)
  table.insert(bigScreens, lod)
  local obj = createObject(single, -1474.1981, 67.9846, 13.6771, 0, 0, 135)
  local lod = createObject(single, -1474.1981, 67.9846, 13.6771, 0, 0, 135, true)
  setLowLODElement(obj, lod)
  table.insert(bigScreens, obj)
  table.insert(bigScreens, lod)
  local obj = createObject(single, -1398.547, 143.6357, 13.6771, 0, 0, 135)
  local lod = createObject(single, -1398.547, 143.6357, 13.6771, 0, 0, 135, true)
  setLowLODElement(obj, lod)
  table.insert(bigScreens, obj)
  table.insert(bigScreens, lod)
  local obj = createObject(single, -1322.77, 219.4127, 13.6771, 0, 0, 135)
  local lod = createObject(single, -1322.77, 219.4127, 13.6771, 0, 0, 135, true)
  setLowLODElement(obj, lod)
  table.insert(bigScreens, obj)
  table.insert(bigScreens, lod)
  local obj = createObject(double, -1223.6794, 319.2551, 13.6715, 0, 0, 65)
  local lod = createObject(double, -1223.6794, 319.2551, 13.6715, 0, 0, 65, true)
  setLowLODElement(obj, lod)
  table.insert(leftScreens, obj)
  table.insert(leftScreens, lod)
  local obj = createObject(double, -1115.3031, 427.6315, 13.6715, 0, 0, 65)
  local lod = createObject(double, -1115.3031, 427.6315, 13.6715, 0, 0, 65, true)
  setLowLODElement(obj, lod)
  table.insert(leftScreens, obj)
  table.insert(leftScreens, lod)
  local obj = createObject(double, -1202.4144, 297.9329, 13.9152, 0, 0, 25)
  local lod = createObject(double, -1202.4144, 297.9329, 13.9152, 0, 0, 25, true)
  setLowLODElement(obj, lod)
  table.insert(rightScreens, obj)
  table.insert(rightScreens, lod)
  local obj = createObject(double, -1093.2307, 407.1167, 13.9152, 0, 0, 25)
  local lod = createObject(double, -1093.2307, 407.1167, 13.9152, 0, 0, 25, true)
  setLowLODElement(obj, lod)
  table.insert(rightScreens, obj)
  table.insert(rightScreens, lod)
  applyShaders()
end
local font = false
local fontScale = false
local fontHeight = false
local leftRTToRefresh = false
local rightRTToRefresh = false
local bigRTToRefresh = false
function guiRefreshColors()
  local resource = getResourceFromName("sGui")
  if resource and getResourceState(resource) == "running" then
    font = sightexports.sGui:getFont("20/BebasNeueBold.otf")
    fontScale = sightexports.sGui:getFontScale("20/BebasNeueBold.otf")
    fontHeight = sightexports.sGui:getFontHeight("20/BebasNeueBold.otf")
    leftRTToRefresh = true
    rightRTToRefresh = true
    bigRTToRefresh = true
  end
end
addEvent("onGuiRefreshColors", true)
addEventHandler("onGuiRefreshColors", getRootElement(), guiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), guiRefreshColors)
function pDistance(x, y, x1, y1, C, D)
  local A = x - x1
  local B = y - y1
  local dot = A * C + B * D
  local len_sq = C * C + D * D
  local param = -1
  if len_sq ~= 0 then
    param = dot / len_sq
  end
  return param
end
local lightColors = {
  prestage_l = tocolor(255, 199, 15),
  prestage_r = tocolor(255, 199, 15),
  stage_l = tocolor(255, 199, 15),
  stage_r = tocolor(255, 199, 15),
  ["1_l"] = tocolor(255, 199, 15),
  ["1_r"] = tocolor(255, 199, 15),
  ["2_l"] = tocolor(255, 199, 15),
  ["2_r"] = tocolor(255, 199, 15),
  ["3_l"] = tocolor(255, 199, 15),
  ["3_r"] = tocolor(255, 199, 15),
  start_l = tocolor(0, 168, 90),
  start_r = tocolor(0, 168, 90),
  fail_l = tocolor(189, 0, 3),
  fail_r = tocolor(189, 0, 3)
}
local lightPositions = {
  prestage_l = {
    {
      -1502.7681,
      17.6594,
      17.4149
    },
    {
      -1502.6266,
      17.5179,
      17.4149
    }
  },
  prestage_r = {
    {
      -1502.194,
      17.0852,
      17.4149
    },
    {
      -1502.0525,
      16.9438,
      17.4149
    }
  },
  stage_l = {
    {
      -1502.7681,
      17.6594,
      16.8747
    },
    {
      -1502.6266,
      17.5179,
      16.8747
    }
  },
  stage_r = {
    {
      -1502.194,
      17.0852,
      16.8747
    },
    {
      -1502.0525,
      16.9438,
      16.8747
    }
  },
  ["1_l"] = {
    {
      -1502.6412,
      17.5326,
      16.4398
    }
  },
  ["1_r"] = {
    {
      -1502.1826,
      17.074,
      16.4398
    }
  },
  ["2_l"] = {
    {
      -1502.6412,
      17.5326,
      16.0826
    }
  },
  ["2_r"] = {
    {
      -1502.1826,
      17.074,
      16.0826
    }
  },
  ["3_l"] = {
    {
      -1502.6412,
      17.5326,
      15.7254
    }
  },
  ["3_r"] = {
    {
      -1502.1826,
      17.074,
      15.7254
    }
  },
  start_l = {
    {
      -1502.6412,
      17.5326,
      15.3682
    }
  },
  start_r = {
    {
      -1502.1826,
      17.074,
      15.3682
    }
  },
  fail_l = {
    {
      -1502.6412,
      17.5326,
      15.0115
    }
  },
  fail_r = {
    {
      -1502.1826,
      17.074,
      15.0115
    }
  }
}
function drawLight(id)
  for i = 1, #lightPositions[id] do
    local x, y, z = lightPositions[id][i][1], lightPositions[id][i][2], lightPositions[id][i][3]
    local fx, fy, fz = x + dragVectorX, y + dragVectorY, z + dragVectorZ
    checkId = id ~= "prestage_l" and id ~= "prestage_r" and id ~= "stage_l" and id ~= "stage_r"
    local d = (checkId and 0.09 or 0.05) + 0.005
    local s = checkId and 0.4 or 0.25
    x, y, z = x + dragVectorX * d, y + dragVectorY * d, z + dragVectorZ * d
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processsightlangStaticImage[0]()
    end
    dxDrawMaterialLine3D(x, y, z + s, x, y, z - s, sightlangStaticImage[0], s * 2, lightColors[id], false, fx, fy, fz)
    x, y, z = x - dragVectorX * d * 2, y - dragVectorY * d * 2, z - dragVectorZ * d * 2
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processsightlangStaticImage[0]()
    end
    dxDrawMaterialLine3D(x, y, z + s, x, y, z - s, sightlangStaticImage[0], s * 2, lightColors[id], false, fx, fy, fz)
  end
end
function minabs(a, b)
  if math.abs(a) < math.abs(b) then
    return a
  else
    return b
  end
end
local selfInvalid = false
local selfFront = false
local selfStage = false
local selfPreStage = false
function getVehicleSpeed(currentElement)
  if isElement(currentElement) then
    local x, y, z = getElementVelocity(currentElement)
    local speed = math.sqrt(x ^ 2 + y ^ 2 + z ^ 2)
    return speed * 180 * 1.1
  end
  return 0
end
function getRaceDistance(veh)
  if not isElement(veh) then
    return false
  end
  local x, y, z = getVehicleComponentPosition(veh, "wheel_lf_dummy", "world")
  local x2, y2, z2 = getVehicleComponentPosition(veh, "wheel_rf_dummy", "world")
  if not x then
    x, y, z = getVehicleComponentPosition(veh, "wheel_front", "world")
  end
  if x then
    local dist = pDistance(x, y, dragStartX, dragStartY, dragVectorX, dragVectorY)
    if x2 then
      dist = minabs(dist, pDistance(x, y, dragStartX, dragStartY, dragVectorX, dragVectorY))
    end
    return dist
  end
end
function checkVehicleStaging(veh)
  if not isElement(veh) then
    return false, false, false
  end
  local x, y, z = getVehicleComponentPosition(veh, "wheel_lf_dummy", "world")
  local x2, y2, z2 = getVehicleComponentPosition(veh, "wheel_rf_dummy", "world")
  if not x then
    x, y, z = getVehicleComponentPosition(veh, "wheel_front", "world")
  end
  local pre, stage = false, false
  if x then
    local dist = pDistance(x, y, dragStartX, dragStartY, dragVectorX, dragVectorY)
    if x2 then
      dist = minabs(dist, pDistance(x, y, dragStartX, dragStartY, dragVectorX, dragVectorY))
    end
    if math.abs(dist) < 0.1 then
      pre = true
      stage = true
    elseif math.abs(dist) < 0.6 then
      if dist < 0.1 then
        pre = true
      end
      if -0.1 < dist then
        stage = true
      end
    else
      pre = false
      stage = false
    end
  end
  if stage or pre then
    return pre, stage, true
  end
  x, y, z = getVehicleComponentPosition(veh, "wheel_lb_dummy", "world")
  x2, y2, z2 = getVehicleComponentPosition(veh, "wheel_rb_dummy", "world")
  if not x then
    x, y, z = getVehicleComponentPosition(veh, "wheel_rear", "world")
  end
  pre, stage = false, false
  if x then
    local dist = pDistance(x, y, dragStartX, dragStartY, dragVectorX, dragVectorY)
    if x2 then
      dist = minabs(dist, pDistance(x, y, dragStartX, dragStartY, dragVectorX, dragVectorY))
    end
    if math.abs(dist) < 0.17 then
      pre = true
      stage = true
    elseif math.abs(dist) < 0.6 then
      if dist < 0.17 then
        pre = true
      end
      if -0.17 < dist then
        stage = true
      end
    else
      pre = false
      stage = false
    end
  end
  if stage or pre then
    return pre, stage, false
  end
end
local selfL, selfR = false, false
local isReady = false
local syncReadyTime = false
local readySynced = false
local leftCar = false
local rightCar = false
local raceState = false
local raceTime = false
local raceStart = false
local greenLightTime = false
local deltaTime = 0
local currentResult = 1
local raceC = 1
local veh = false
local isDriver = false
addEvent("syncDragFail", true)
addEventHandler("syncDragFail", getRootElement(), function(left, right)
  if raceState then
    leftFail = left
    if left then
      leftRTToRefresh = true
      bigRTToRefresh = true
    end
    rightFail = right
    if right then
      rightRTToRefresh = true
      bigRTToRefresh = true
    end
  end
end)
local selfResults = {}
local leftResults = {}
local rightResults = {}
local dragReady = false
addEvent("syncDragRaceState", true)
addEventHandler("syncDragRaceState", getRootElement(), function(left, right, state, time)
  leftCar = left
  rightCar = right
  leftFail = false
  rightFail = false
  raceState = state
  raceTime = time
  if state and time then
    raceStart = getTickCount()
    local sound = playSound3D("files/cd1.mp3", -1502.515625, 17.1865234375, 18.515621185303)
    setSoundMaxDistance(sound, 400)
  else
    raceStart = false
  end
  greenLightTime = false
  raceC = 1
  deltaTime = 0
  currentResult = 1
  selfResults = {}
  leftResults = {}
  rightResults = {}
  readySynced = false
  isReady = false
  leftRTToRefresh = true
  rightRTToRefresh = true
  bigRTToRefresh = true
  dragReady = false
end)
local lcdFont = false
local rightRT = false
local leftRT = false
local bigRT = false
local rightShader = false
local leftShader = false
local bigShader = false
local screenTex = false
function createShaders()
  if not isElement(rightRT) then
    rightRT = dxCreateRenderTarget(256, 128)
  end
  if not isElement(leftRT) then
    leftRT = dxCreateRenderTarget(256, 128)
  end
  if not isElement(bigRT) then
    bigRT = dxCreateRenderTarget(384, 192)
  end
  if not isElement(rightShader) then
    rightShader = dxCreateShader(textureChanger)
    dxSetShaderValue(rightShader, "gTexture", rightRT)
  end
  if not isElement(leftShader) then
    leftShader = dxCreateShader(textureChanger)
    dxSetShaderValue(leftShader, "gTexture", leftRT)
  end
  if not isElement(bigShader) then
    bigShader = dxCreateShader(textureChanger)
    dxSetShaderValue(bigShader, "gTexture", bigRT)
  end
  if not isElement(screenTex) then
    screenTex = dxCreateTexture("files/screen.dds", "dxt1")
  end
  if not isElement(lcdFont) then
    lcdFont = dxCreateFont("files/lcdsign.ttf", 25, false, "antialiased")
  end
  applyShaders()
  leftRTToRefresh = true
  rightRTToRefresh = true
  bigRTToRefresh = true
end
function applyShaders()
  if leftShader then
    for i = 1, #leftScreens do
      engineApplyShaderToWorldTexture(leftShader, "seering_drag_screen", leftScreens[i])
    end
  end
  if rightShader then
    for i = 1, #rightScreens do
      engineApplyShaderToWorldTexture(rightShader, "seering_drag_screen", rightScreens[i])
    end
  end
  if bigShader then
    for i = 1, #bigScreens do
      engineApplyShaderToWorldTexture(bigShader, "seering_drag_screen2", bigScreens[i])
    end
  end
end
function refreshLeftRT()
  if leftRT and font then
    dxSetRenderTarget(leftRT)
    dxSetBlendMode("modulate_add")
    dxDrawImage(0, 0, 256, 128, screenTex)
    if raceState and isElement(leftCar) then
      if leftFail then
        dxDrawText("JUMPSTART", 0, 0, 256, 64, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      elseif leftResults[8] then
        dxDrawText(string.format("%06.3f", leftResults[8]), 0, 0, 256, 64, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      elseif greenLightTime then
        dxDrawText(string.format("%06.3f", deltaTime), 0, 0, 256, 64, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      else
        dxDrawText("00.000", 0, 0, 256, 64, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      end
      if leftFail then
        dxDrawText("JUMPSTART", 0, 64, 256, 128, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      elseif leftResults[7] then
        dxDrawText(string.format("%07.3f", leftResults[7]) .. " KM/H", 0, 64, 256, 128, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      elseif greenLightTime and isElement(leftCar) then
        dxDrawText(string.format("%07.3f", getVehicleSpeed(leftCar)) .. " KM/H", 0, 64, 256, 128, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      else
        dxDrawText("000.000 KM/H", 0, 64, 256, 128, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      end
    end
    dxSetBlendMode("blend")
    dxSetRenderTarget()
  end
end
function refreshRightRT()
  if rightRT and font then
    dxSetRenderTarget(rightRT)
    dxSetBlendMode("modulate_add")
    dxDrawImage(0, 0, 256, 128, screenTex)
    if raceState and isElement(rightCar) then
      if rightFail then
        dxDrawText("JUMPSTART", 0, 0, 256, 64, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      elseif rightResults[8] then
        dxDrawText(string.format("%06.3f", rightResults[8]), 0, 0, 256, 64, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      elseif greenLightTime then
        dxDrawText(string.format("%06.3f", deltaTime), 0, 0, 256, 64, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      else
        dxDrawText("00.000", 0, 0, 256, 64, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      end
      if rightFail then
        dxDrawText("JUMPSTART", 0, 64, 256, 128, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      elseif rightResults[7] then
        dxDrawText(string.format("%07.3f", rightResults[7]) .. " KM/H", 0, 64, 256, 128, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      elseif greenLightTime and isElement(rightCar) then
        dxDrawText(string.format("%07.3f", getVehicleSpeed(rightCar)) .. " KM/H", 0, 64, 256, 128, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      else
        dxDrawText("000.000 KM/H", 0, 64, 256, 128, tocolor(235, 20, 20, 255), 0.5, lcdFont, "center", "center")
      end
    end
    dxSetBlendMode("blend")
    dxSetRenderTarget()
  end
end
local topResults = {}
addEvent("refreshDragTop", true)
addEventHandler("refreshDragTop", getRootElement(), function(res)
  topResults = res
  refreshBigRT()
end)
local modelName = {}
function getModelName(model)
  if modelName[model] then
    return modelName[model]
  end
  modelName[model] = sightexports.sVehiclenames:getCustomVehicleName(model)
  return modelName[model]
end
function refreshBigRT()
  if bigRT and font then
    dxSetRenderTarget(bigRT)
    dxSetBlendMode("modulate_add")
    dxDrawImage(0, 0, 384, 192, screenTex)
    if raceState then
      if greenLightTime then
        if (leftResults[8] or leftFail or not isElement(leftCar)) and (rightResults[8] or rightFail or not isElement(rightCar)) then
          local time = math.max(leftResults[8] or 0, rightResults[8] or 0)
          dxDrawText(string.format("%06.3f", time), 0, 0, 384, 32, tocolor(235, 20, 20, 255), 0.38, lcdFont, "center", "center")
        else
          dxDrawText(string.format("%06.3f", deltaTime), 0, 0, 384, 32, tocolor(235, 20, 20, 255), 0.38, lcdFont, "center", "center")
        end
      else
        dxDrawText("00.000", 0, 0, 384, 32, tocolor(235, 20, 20, 255), 0.38, lcdFont, "center", "center")
      end
      local h = 160 / #resultNames
      for i = 1, #resultNames do
        if leftFail or not isElement(leftCar) then
          dxDrawText("---", 0, 32 + (i - 1) * h, 128, 32 + i * h, tocolor(235, 20, 20, 255), 0.35, lcdFont, "right", "center")
        elseif leftResults[i] then
          dxDrawText(string.format("%06.3f", leftResults[i]), 0, 32 + (i - 1) * h, 128, 32 + i * h, tocolor(235, 20, 20, 255), 0.35, lcdFont, "right", "center")
        end
        dxDrawText(resultNames[i][1] .. " (" .. resultNames[i][3] .. ")", 0, 32 + (i - 1) * h, 384, 32 + i * h, tocolor(235, 20, 20, 255), 0.3, lcdFont, "center", "center")
        if rightFail or not isElement(rightCar) then
          dxDrawText("---", 256, 32 + (i - 1) * h, 0, 32 + i * h, tocolor(235, 20, 20, 255), 0.35, lcdFont, "left", "center")
        elseif rightResults[i] then
          dxDrawText(string.format("%06.3f", rightResults[i]), 256, 32 + (i - 1) * h, 0, 32 + i * h, tocolor(235, 20, 20, 255), 0.35, lcdFont, "left", "center")
        end
      end
    else
      local h = 19.2
      local j = 1
      for i = 1, 10, 2 do
        if topResults[j] then
          dxDrawText(topResults[j][4]:gsub("_", " "), 24, (i - 1) * h, 281, i * h, tocolor(235, 20, 20, 255), 0.25, lcdFont, "left", "center", true)
          dxDrawText(getModelName(topResults[j][1]), 24, i * h, 281, (i + 1) * h, tocolor(235, 20, 20, 255), 0.25, lcdFont, "left", "center", true)
          dxDrawText(string.format("%06.3f", topResults[j][2]) .. " S", 285, (i - 1) * h, 360, i * h, tocolor(235, 20, 20, 255), 0.25, lcdFont, "right", "center", true)
          dxDrawText(math.floor(topResults[j][3]) .. " km/h", 285, i * h, 360, (i + 1) * h, tocolor(235, 20, 20, 255), 0.25, lcdFont, "right", "center", true)
          dxDrawLine(24, (i + 1) * h, 360, (i + 1) * h, tocolor(235, 20, 20, 255), 1)
        end
        j = j + 1
      end
    end
    dxSetBlendMode("blend")
    dxSetRenderTarget()
  end
end
function vehnamesReady()
  triggerServerEvent("getDragTop", localPlayer)
  addEventHandler("onClientRestore", getRootElement(), refreshLeftRT)
  addEventHandler("onClientRestore", getRootElement(), refreshRightRT)
  addEventHandler("onClientRestore", getRootElement(), refreshBigRT)
  createShaders()
end
addEvent("gotNewDragLeftResult", true)
addEventHandler("gotNewDragLeftResult", getRootElement(), function(index, val)
  if raceState then
    leftResults[index] = val
    if index == 8 then
      leftRTToRefresh = true
      if (rightResults[8] or rightFail or not isElement(rightCar)) and (leftResults[8] or leftFail or not isElement(leftCar)) then
        bigRTToRefresh = true
      end
    end
  end
end)
addEvent("gotNewDragRightResult", true)
addEventHandler("gotNewDragRightResult", getRootElement(), function(index, val)
  if raceState then
    rightResults[index] = val
    if index == 8 then
      rightRTToRefresh = true
      if (rightResults[8] or rightFail or not isElement(rightCar)) and (leftResults[8] or leftFail or not isElement(leftCar)) then
        bigRTToRefresh = true
      end
    end
  end
end)
function syncSelfResult(index, val)
  if veh == leftCar then
    leftResults[index] = val
    if index == 8 then
      leftRTToRefresh = true
      bigRTToRefresh = true
    end
  end
  if veh == rightCar then
    rightResults[index] = val
    if index == 8 then
      rightRTToRefresh = true
      bigRTToRefresh = true
    end
  end
  selfResults[index] = val
  outputChatBox("[color=sightblue][SightMTA - Drag]:#ffffff " .. resultNames[index][2] .. ": " .. string.format("%.3f", val) .. " " .. resultNames[index][3], 255, 255, 255, true)
  triggerServerEvent("syncDragStripResult", localPlayer, veh, index, val)
end
addEventHandler("onClientPreRender", getRootElement(), function(delta)
  local now = getTickCount()
  if raceState then
    if raceStart then
      local tmp = math.floor((now - raceStart) / raceTime) + 1
      if tmp ~= raceC then
        raceC = tmp
        if 3 < raceC then
          local sound = playSound3D("files/cd2.mp3", -1502.515625, 17.1865234375, 18.515621185303)
          setSoundMaxDistance(sound, 400)
          raceC = false
          raceStart = false
          raceTime = false
          greenLightTime = now
        else
          local sound = playSound3D("files/cd1.mp3", -1502.515625, 17.1865234375, 18.515621185303)
          setSoundMaxDistance(sound, 400)
        end
      end
    end
    if greenLightTime then
      deltaTime = (now - greenLightTime) / 1000
    end
    if leftCar then
      if leftFail then
        drawLight("fail_l")
      elseif raceC then
        drawLight(raceC .. "_l")
      else
        drawLight("start_l")
      end
    end
    if rightCar then
      if rightFail then
        drawLight("fail_r")
      elseif raceC then
        drawLight(raceC .. "_r")
      else
        drawLight("start_r")
      end
    end
  end
  selfStage = false
  selfPreStage = false
  selfInvalid = false
  selfFront = false
  veh = getPedOccupiedVehicle(localPlayer)
  isDriver = veh and getVehicleController(veh) == localPlayer
  if readySynced and readySynced ~= veh then
    readySynced = false
  end
  local stageL, preStageL, frontL, invalidL
  selfL = false
  if raceState then
    local pre, stage, front = checkVehicleStaging(leftCar)
    if veh == leftCar then
      selfStage = stage
      selfPreStage = pre
    end
    stageL, preStageL, frontL = stage, pre, front
  else
    local leftVehs = getElementsWithinColShape(leftDragLane, "vehicle")
    for i = 1, #leftVehs do
      local pre, stage, front = checkVehicleStaging(leftVehs[i])
      if veh == leftVehs[i] then
        selfL = true
      end
      if pre or stage then
        if stageL or preStageL then
          invalidL = true
          break
        end
        stageL, preStageL, frontL = stage, pre, front
      end
    end
  end
  local stageR, preStageR, frontR, invalidR
  selfR = false
  if raceState then
    local pre, stage, front = checkVehicleStaging(rightCar)
    if veh == rightCar then
      selfStage = stage
      selfPreStage = pre
    end
    stageR, preStageR, frontR = stage, pre, front
  else
    local rightVehs = getElementsWithinColShape(rightDragLane, "vehicle")
    for i = 1, #rightVehs do
      local pre, stage, front = checkVehicleStaging(rightVehs[i])
      if veh == rightVehs[i] then
        selfR = true
      end
      if pre or stage then
        if stageR or preStageR then
          invalidR = true
          break
        end
        stageR, preStageR, frontR = stage, pre, front
      end
    end
  end
  if invalidL then
    stageL = now % 500 > 250
    preStageL = now % 500 > 250
  end
  if invalidR then
    stageR = now % 500 > 250
    preStageR = now % 500 > 250
  end
  if stageL then
    drawLight("stage_l")
  end
  if preStageL then
    drawLight("prestage_l")
  end
  if stageR then
    drawLight("stage_r")
  end
  if preStageR then
    drawLight("prestage_r")
  end
  local tmpReady = false
  if selfL then
    if invalidL then
      selfInvalid = true
    else
      tmpReady = stageL and preStageL and frontL
    end
    selfFront = frontL
    selfStage = stageL
    selfPreStage = preStageL
  elseif selfR then
    if invalidR then
      selfInvalid = true
    else
      tmpReady = stageR and preStageR and frontR
    end
    selfFront = frontR
    selfStage = stageR
    selfPreStage = preStageR
  end
  if raceState then
    local stage = false
    local preStage = false
    local selfCar = false
    if leftCar == veh and not leftFail then
      stage = stageL
      preStage = preStageL
      selfCar = true
    elseif rightCar == veh and not rightFail then
      stage = stageR
      preStage = preStageR
      selfCar = true
    end
    if selfCar and isDriver then
      if currentResult < #selfResults then
        currentResult = currentResult + 2 * delta / 1000
        if currentResult > #selfResults then
          currentResult = #selfResults
        end
      end
      if not stage or not preStage then
        if greenLightTime then
          if not selfResults[1] then
            syncSelfResult(1, deltaTime)
          end
        else
          if leftCar == veh then
            leftFail = true
            leftRTToRefresh = true
            bigRTToRefresh = true
          end
          if rightCar == veh then
            rightFail = true
            rightRTToRefresh = true
            bigRTToRefresh = true
          end
          triggerServerEvent("syncDragStripResult", localPlayer, false)
        end
      end
      local dist = getRaceDistance(veh)
      if dist and greenLightTime then
        if dist / 0.3048 >= 60 and not selfResults[2] then
          syncSelfResult(2, deltaTime)
        end
        if dist / 0.3048 >= 330 and not selfResults[3] then
          syncSelfResult(3, deltaTime)
        end
        if dist / 1609.344 >= 0.125 and not selfResults[5] then
          syncSelfResult(4, getVehicleSpeed(veh))
          syncSelfResult(5, deltaTime)
        end
        if 1000 <= dist / 0.3048 and not selfResults[6] then
          syncSelfResult(6, deltaTime)
        end
        if dist / 1609.344 >= 0.25 and not selfResults[8] then
          syncSelfResult(7, getVehicleSpeed(veh))
          syncSelfResult(8, deltaTime)
        end
      end
    end
  elseif tmpReady ~= isReady then
    isReady = tmpReady
    if veh and isDriver then
      if isReady then
        syncReadyTime = now
      else
        syncReadyTime = false
        if readySynced then
          triggerServerEvent("dragStripReadyChange", localPlayer, readySynced)
          readySynced = false
          dragReady = false
        end
      end
    end
  end
  if syncReadyTime and 1000 < now - syncReadyTime then
    syncReadyTime = false
    readySynced = veh
    dragReady = false
    if not raceState then
      triggerServerEvent("dragStripReadyChange", localPlayer, veh, true)
    end
  end
end)
function dxDrawTextEx(text, y, scale, a)
  dxDrawText(text, 1, 0, screenX + 1, y + 1, tocolor(0, 0, 0, a or 255), fontScale * scale, font, "center", "bottom")
  dxDrawText(text, 0, 0, screenX, y, tocolor(255, 255, 255, a or 255), fontScale * scale, font, "center", "bottom")
end
addEvent("dragRaceReady", true)
addEventHandler("dragRaceReady", getRootElement(), function(time)
  dragReady = time and getTickCount() + time or 0
end)
local sx, sy = 140, 370
local x, y = screenX - sx - 32, screenY / 2 - sy / 2
local dragX, dragY = false, false
addEventHandler("onClientRender", getRootElement(), function()
  local cx, cy = getCursorPosition()
  if cx then
    cx, cy = cx * screenX, cy * screenY
    if dragX then
      if getKeyState("mouse1") then
        x = math.max(0, math.min(screenX - sx, cx - dragX))
        y = math.max(0, math.min(screenY - sy, cy - dragY))
      else
        dragX = false
        dragY = false
      end
    elseif cx >= x and cy >= y and cx <= x + sx and cy <= y + sy and getKeyState("mouse1") then
      dragX, dragY = cx - x, cy - y
    end
  elseif dragX then
    dragX = false
    dragY = false
  end
  local selfRace = raceState and isElement(veh) and (leftCar == veh or rightCar == veh)
  if selfRace and isDriver then
    if leftCar == veh and leftFail or rightCar == veh and rightFail then
      dxDrawTextEx("JUMPSTART", screenY * 0.85, 1)
    elseif selfResults[8] then
      dxDrawTextEx(string.format("%06.3f", selfResults[8]), screenY * 0.85, 1)
    elseif greenLightTime then
      dxDrawTextEx(string.format("%06.3f", deltaTime), screenY * 0.85, 1)
    else
      dxDrawTextEx("00.000", screenY * 0.85, 1)
    end
    local current = math.floor(currentResult)
    if current < currentResult then
      local p = currentResult % 1
      if selfResults[current - 1] then
        dxDrawTextEx(resultNames[current - 1][2] .. ": " .. string.format("%.3f", selfResults[current - 1]) .. " " .. resultNames[current - 1][3], screenY * 0.85 + fontHeight * 1.85, 0.75, (1 - p) * 200)
      end
      dxDrawTextEx(resultNames[current][2] .. ": " .. string.format("%.3f", selfResults[current]) .. " " .. resultNames[current][3], screenY * 0.85 + fontHeight * (1 + 0.85 * p), 0.9 - 0.15 * p, 200)
      if selfResults[current + 1] then
        dxDrawTextEx(resultNames[current + 1][2] .. ": " .. string.format("%.3f", selfResults[current + 1]) .. " " .. resultNames[current + 1][3], screenY * 0.85 + fontHeight, 0.9, 200 * p)
      end
    elseif selfResults[current] then
      dxDrawTextEx(resultNames[current][2] .. ": " .. string.format("%.3f", selfResults[current]) .. " " .. resultNames[current][3], screenY * 0.85 + fontHeight, 0.9, 200)
      if selfResults[current - 1] then
        dxDrawTextEx(resultNames[current - 1][2] .. ": " .. string.format("%.3f", selfResults[current - 1]) .. " " .. resultNames[current - 1][3], screenY * 0.85 + fontHeight * 1.85, 0.75, 200)
      end
    end
  end
  if selfRace or selfL or selfR then
    local test = math.floor(getTickCount() / 250 % 6)
    if x < screenX / 2 - sx / 2 then
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[1])
    else
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
      end
      dxDrawImage(x + sx, y, -sx, sy, sightlangStaticImage[1])
    end
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImage(x, y, sx, sy, sightlangStaticImage[2])
    if raceState then
      if raceC then
        dxDrawImage(x, y, sx, sy, dynamicImage("files/" .. raceC .. ".dds"))
      elseif leftCar == veh and leftFail or rightCar == veh and rightFail then
        sightlangStaticImageUsed[3] = true
        if sightlangStaticImageToc[3] then
          processsightlangStaticImage[3]()
        end
        dxDrawImage(x, y, sx, sy, sightlangStaticImage[3])
      else
        sightlangStaticImageUsed[4] = true
        if sightlangStaticImageToc[4] then
          processsightlangStaticImage[4]()
        end
        dxDrawImage(x, y, sx, sy, sightlangStaticImage[4])
      end
    else
      sightlangStaticImageUsed[5] = true
      if sightlangStaticImageToc[5] then
        processsightlangStaticImage[5]()
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[5])
    end
    if selfPreStage and selfStage then
      sightlangStaticImageUsed[6] = true
      if sightlangStaticImageToc[6] then
        processsightlangStaticImage[6]()
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[6])
    elseif selfPreStage then
      sightlangStaticImageUsed[7] = true
      if sightlangStaticImageToc[7] then
        processsightlangStaticImage[7]()
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[7])
    elseif selfStage then
      sightlangStaticImageUsed[8] = true
      if sightlangStaticImageToc[8] then
        processsightlangStaticImage[8]()
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[8])
    else
      sightlangStaticImageUsed[9] = true
      if sightlangStaticImageToc[9] then
        processsightlangStaticImage[9]()
      end
      dxDrawImage(x, y, sx, sy, sightlangStaticImage[9])
    end
    if not raceState and isDriver then
      if readySynced then
        dxDrawTextEx("Várakozás a verseny indítására...", screenY * 0.85, 1)
        if dragReady then
          local delta = dragReady - getTickCount()
          if 0 < delta then
            local mins = math.floor(delta / 60000)
            local secs = math.floor(delta % 60000 / 1000)
            dxDrawTextEx(string.format("%02d:%02d", mins, secs), screenY * 0.85 + fontHeight, 1)
          end
        end
      elseif selfInvalid then
        dxDrawTextEx("Egyszerre csak egy autó állhat a célvonalnál!", screenY * 0.85, 1)
      elseif selfFront then
        dxDrawTextEx("Állj be a célvonalhoz az első kerekeddel!", screenY * 0.85, 1)
        if selfStage and selfPreStage then
          dxDrawTextEx("Állj meg!", screenY * 0.85 + fontHeight, 1)
        elseif selfPreStage then
          dxDrawTextEx("Kicsit elölrébb!", screenY * 0.85 + fontHeight, 1)
        elseif selfStage then
          dxDrawTextEx("Kicsit hátrébb!", screenY * 0.85 + fontHeight, 1)
        end
      else
        dxDrawTextEx("Állj be a célvonalhoz az első kerekeddel!", screenY * 0.85, 1)
      end
    end
  elseif dragX then
    dragX = false
    dragY = false
  end
  if raceState and greenLightTime then
    if not leftFail and not leftResults[8] and isElement(leftCar) then
      leftRTToRefresh = true
    end
    if not rightFail and not rightResults[8] and isElement(rightCar) then
      rightRTToRefresh = true
    end
    if not (not (#leftResults < #resultNames) or leftFail) and isElement(leftCar) or #rightResults < #resultNames and not rightFail and isElement(rightCar) then
      bigRTToRefresh = true
    end
  end
  if leftRTToRefresh then
    leftRTToRefresh = false
    refreshLeftRT()
  end
  if rightRTToRefresh then
    rightRTToRefresh = false
    refreshRightRT()
  end
  if bigRTToRefresh then
    bigRTToRefresh = false
    refreshBigRT()
  end
end)