local sightexports = {
  sSpeedo = false,
  sModloader = false,
  sGui = false,
  sJob_raktar = false,
  sItems = false,
  sPermission = false,
  sGroups = false,
  sMechanic = false,
  sInteriors = false,
  sPaintshop = false,
  sVehiclenames = false,
  sWebdebug = false,
  sCore = false,
  sHud = false,
  sControls = false,
  sWeather = false,
  sPattach = false
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
sightlangStaticImageToc[10] = true
sightlangStaticImageToc[11] = true
sightlangStaticImageToc[12] = true
sightlangStaticImageToc[13] = true
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
  if sightlangStaticImageUsed[10] then
    sightlangStaticImageUsed[10] = false
    sightlangStaticImageDel[10] = false
  elseif sightlangStaticImage[10] then
    if sightlangStaticImageDel[10] then
      if now >= sightlangStaticImageDel[10] then
        if isElement(sightlangStaticImage[10]) then
          destroyElement(sightlangStaticImage[10])
        end
        sightlangStaticImage[10] = nil
        sightlangStaticImageDel[10] = false
        sightlangStaticImageToc[10] = true
        return
      end
    else
      sightlangStaticImageDel[10] = now + 5000
    end
  else
    sightlangStaticImageToc[10] = true
  end
  if sightlangStaticImageUsed[11] then
    sightlangStaticImageUsed[11] = false
    sightlangStaticImageDel[11] = false
  elseif sightlangStaticImage[11] then
    if sightlangStaticImageDel[11] then
      if now >= sightlangStaticImageDel[11] then
        if isElement(sightlangStaticImage[11]) then
          destroyElement(sightlangStaticImage[11])
        end
        sightlangStaticImage[11] = nil
        sightlangStaticImageDel[11] = false
        sightlangStaticImageToc[11] = true
        return
      end
    else
      sightlangStaticImageDel[11] = now + 5000
    end
  else
    sightlangStaticImageToc[11] = true
  end
  if sightlangStaticImageUsed[12] then
    sightlangStaticImageUsed[12] = false
    sightlangStaticImageDel[12] = false
  elseif sightlangStaticImage[12] then
    if sightlangStaticImageDel[12] then
      if now >= sightlangStaticImageDel[12] then
        if isElement(sightlangStaticImage[12]) then
          destroyElement(sightlangStaticImage[12])
        end
        sightlangStaticImage[12] = nil
        sightlangStaticImageDel[12] = false
        sightlangStaticImageToc[12] = true
        return
      end
    else
      sightlangStaticImageDel[12] = now + 5000
    end
  else
    sightlangStaticImageToc[12] = true
  end
  if sightlangStaticImageUsed[13] then
    sightlangStaticImageUsed[13] = false
    sightlangStaticImageDel[13] = false
  elseif sightlangStaticImage[13] then
    if sightlangStaticImageDel[13] then
      if now >= sightlangStaticImageDel[13] then
        if isElement(sightlangStaticImage[13]) then
          destroyElement(sightlangStaticImage[13])
        end
        sightlangStaticImage[13] = nil
        sightlangStaticImageDel[13] = false
        sightlangStaticImageToc[13] = true
        return
      end
    else
      sightlangStaticImageDel[13] = now + 5000
    end
  else
    sightlangStaticImageToc[13] = true
  end
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] and sightlangStaticImageToc[9] and sightlangStaticImageToc[10] and sightlangStaticImageToc[11] and sightlangStaticImageToc[12] and sightlangStaticImageToc[13] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/sp2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/sp1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture(":sSpeedo/files/analog/pulse.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/turbo/light.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/turbo/light2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[5] = function()
  if not isElement(sightlangStaticImage[5]) then
    sightlangStaticImageToc[5] = false
    sightlangStaticImage[5] = dxCreateTexture("files/turbo/base.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[6] = function()
  if not isElement(sightlangStaticImage[6]) then
    sightlangStaticImageToc[6] = false
    sightlangStaticImage[6] = dxCreateTexture("files/turbo/redline.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[7] = function()
  if not isElement(sightlangStaticImage[7]) then
    sightlangStaticImageToc[7] = false
    sightlangStaticImage[7] = dxCreateTexture("files/turbo/section.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[8] = function()
  if not isElement(sightlangStaticImage[8]) then
    sightlangStaticImageToc[8] = false
    sightlangStaticImage[8] = dxCreateTexture("files/turbo/section2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[9] = function()
  if not isElement(sightlangStaticImage[9]) then
    sightlangStaticImageToc[9] = false
    sightlangStaticImage[9] = dxCreateTexture("files/turbo/indicator.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[10] = function()
  if not isElement(sightlangStaticImage[10]) then
    sightlangStaticImageToc[10] = false
    sightlangStaticImage[10] = dxCreateTexture("files/turbo/line.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[11] = function()
  if not isElement(sightlangStaticImage[11]) then
    sightlangStaticImageToc[11] = false
    sightlangStaticImage[11] = dxCreateTexture("files/collisionsmoke.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[12] = function()
  if not isElement(sightlangStaticImage[12]) then
    sightlangStaticImageToc[12] = false
    sightlangStaticImage[12] = dxCreateTexture("files/clip2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[13] = function()
  if not isElement(sightlangStaticImage[13]) then
    sightlangStaticImageToc[13] = false
    sightlangStaticImage[13] = dxCreateTexture("files/clip.dds", "argb", true)
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
    local res0 = getResourceFromName("sSpeedo")
    if res0 and getResourceState(res0) == "running" then
      speedoRes()
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
local loadingFont = false
local loadingFontScale = false
local green = false
local greenToColor = false
local grey1 = false
local grey2 = false
local nearbyFont = false
local nearbyFontScale = false
local nearbyFontH = false
local clipBg = false
local clipColor = false
local clipColor2 = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    loadingFont = sightexports.sGui:getFont("12/Ubuntu-R.ttf")
    loadingFontScale = sightexports.sGui:getFontScale("12/Ubuntu-R.ttf")
    green = sightexports.sGui:getColorCode("sightgreen")
    greenToColor = sightexports.sGui:getColorCodeToColor("sightgreen")
    grey1 = sightexports.sGui:getColorCode("sightgrey1")
    grey2 = sightexports.sGui:getColorCode("sightgrey2")
    nearbyFont = sightexports.sGui:getFont("14/BebasNeueRegular.otf")
    nearbyFontScale = sightexports.sGui:getFontScale("14/BebasNeueRegular.otf")
    nearbyFontH = sightexports.sGui:getFontHeight("14/BebasNeueRegular.otf")
    clipBg = sightexports.sGui:getColorCodeToColor("sightgrey1")
    clipColor = sightexports.sGui:getColorCodeToColor("sightgreen")
    clipColor2 = sightexports.sGui:getColorCodeToColor("sightred")
    guiRefreshColors()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local sightlangModloaderLoaded = function()
  loadModelIds()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState2 then
    sightlangCondHandlState2 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderVehicleLoader, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderVehicleLoader)
    end
  end
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderSelfAccelerate, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderSelfAccelerate)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), checkWaterDamage, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), checkWaterDamage)
    end
  end
end
local playerAccelerate = {}
local speedoVehicle = false
local selfSynced = false
local needToSync = false
local lastSync = 0
addEvent("syncPlayerAccelerate", true)
addEventHandler("syncPlayerAccelerate", getRootElement(), function(state)
  if isElement(source) then
    playerAccelerate[source] = state
  end
end)
function preRenderSelfAccelerate()
  local keep = false
  if isElement(speedoVehicle) and getVehicleController(speedoVehicle) == localPlayer then
    keep = true
    local tmp = getVehicleEngineState(speedoVehicle) and getPedControlState(localPlayer, "accelerate")
    local speed = 45 + 90 * (1 - getElementHealth(speedoVehicle) / 1000)
    local sp = getVehicleSpeed(speedoVehicle)
    if speed < sp then
      tmp = false
    end
    if tmp ~= playerAccelerate[localPlayer] then
      needToSync = true
      playerAccelerate[localPlayer] = tmp
    end
  end
  if needToSync then
    local now = getTickCount()
    if 750 < now - lastSync then
      lastSync = now
      needToSync = false
      if selfSynced ~= playerAccelerate[localPlayer] then
        selfSynced = playerAccelerate[localPlayer]
        local players = getElementsByType("player", getRootElement(), true)
        if 0 < #players then
          triggerLatentServerEvent("syncPlayerAccelerate", localPlayer, players, playerAccelerate[localPlayer])
        end
      end
    end
    return
  end
end
local speedoVehicleLight = false
local pressTimer = false
local triedToStartEngine = false
local currentVehicleLight = false
local objectModels = {}
local waterDamageSync = false
function checkWaterDamage()
  local keep = false
  if isElement(speedoVehicle) and getVehicleController(speedoVehicle) == localPlayer then
    keep = true
    local tmp = isElementInWater(speedoVehicle)
    if tmp ~= waterDamageSync then
      waterDamageSync = tmp
      if tmp then
        triggerServerEvent("checkWaterDamage", localPlayer)
      end
    end
  end
  if not keep then
    sightlangCondHandl0(false)
  end
end
function updateSpeedoVehicleLight(state)
  speedoVehicleLight = state
end
function updateSpeedoVehicle(veh)
  speedoVehicle = veh
  if veh and getVehicleController(veh) == localPlayer then
    waterDamageSync = false
    sightlangCondHandl1(true)
    sightlangCondHandl0(true)
  end
end
function speedoRes()
  speedoVehicle = sightexports.sSpeedo:getSpeedoVeh()
  if speedoVehicle and getVehicleController(speedoVehicle) == localPlayer then
    waterDamageSync = false
    sightlangCondHandl1(true)
    sightlangCondHandl0(true)
  end
end
function loadModelIds()
  objectModels = {
    supercharger = sightexports.sModloader:getModelId("supercharger"),
    supercharger_butterfly_valves = sightexports.sModloader:getModelId("supercharger_butterfly_valves"),
    supercharger_pully = sightexports.sModloader:getModelId("supercharger_pully"),
    supercharger_pully2 = sightexports.sModloader:getModelId("supercharger_pully2")
  }
end
bindKey("n", "down", "nitro")
addEventHandler("onClientVehicleStartEnter", getRootElement(), function(player)
  if player == localPlayer and getVehicleType(source) ~= "Automobile" and getVehicleType(source) ~= "Helicopter" and isVehicleLocked(source) then
    sightexports.sGui:showInfobox("e", "Ez a jármű zárva van!")
    cancelEvent()
  end
end)
function getVehicleKey(veh, mechanic)
  local jobVeh = false --local jobVeh = sightexports.sJob_raktar:getSelfJobVehicle()
  if jobVeh and jobVeh == veh then
    return true
  end
  local dbID = getElementData(veh, "vehicle.dbID")
  if not dbID then
    return true
  end
  if sightexports.sItems:playerHasItemWithData(1, dbID) then
    return true
  end
  if getElementData(localPlayer, "adminDuty") then
    return true
  end
  if sightexports.sPermission:hasPermission(localPlayer, "superUnlock") then
    return true
  end
  if exports.sVehiclerent:getRentedOwner(veh) then
    return true
  end
  if sightexports.sGroups:getPlayerVehicle(dbID) then
    return true
  end
  if mechanic and sightexports.sMechanic:isInsideWorkshop() and sightexports.sGroups:getPlayerPermissionInGroup(sightexports.sMechanic:getCurrentWorkshopGroup(), "engineKey") then
    return true
  end
end
local lastLock = 0
addEvent("vehicleLockSoundEffect", true)
addEventHandler("vehicleLockSoundEffect", getRootElement(), function(inside, locked)
  if isElement(source) then
    if inside and speedoVehicle == source then
      if locked then
        playSound("files/lock_in.mp3")
      else
        playSound("files/unlock_in.mp3")
      end
    else
      local x, y, z = getElementPosition(source)
      local int = getElementInterior(source)
      local dim = getElementDimension(source)
      local sound = playSound3D("files/lock_out.mp3", x, y, z)
      attachElements(sound, source)
      setElementDimension(sound, dim)
      setElementInterior(sound, int)
      if locked then
        local sound = playSound3D("files/lock_in.mp3", x, y, z)
        attachElements(sound, source)
        setElementDimension(sound, dim)
        setElementInterior(sound, int)
      else
        local sound = playSound3D("files/unlock_in.mp3", x, y, z)
        attachElements(sound, source)
        setElementDimension(sound, dim)
        setElementInterior(sound, int)
      end
    end
  end
end)
addEventHandler("onClientKey", getRootElement(), function(key, por)
  if not isCursorShowing() and not isConsoleActive() and not sightexports.sGui:getActiveInput() and not isChatBoxInputActive() then
    local veh = speedoVehicle
    if veh and getPedOccupiedVehicleSeat(localPlayer) == 0 then
      local vt = getVehicleType(veh)
      if key == "o" then
        if (vt == "Automobile" or vt == "Bike") and not getElementData(veh, "signalState") then
          triggerServerEvent("flashVehicleLights", localPlayer, por)
        end
        return
      elseif key == "l" then
        if por and (vt == "Automobile" or vt == "Bike") and not getElementData(veh, "signalState") then
          triggerServerEvent("toggleVehicleLights", localPlayer)
        end
        return
      elseif key == "j" then
        if vt == "Automobile" or vt == "Bike" or vt == "Quad" or vt == "Helicopter" or vt == "Plane" or vt == "Boat" then
          if getVehicleKey(veh, true) then
            triggerServerEvent("tryVehicleEngine", localPlayer, por, getKeyState("lshift"))
          elseif por then
            sightexports.sGui:showInfobox("e", "Nincs kulcsod a járműhöz!")
          end
        end
        return
      end
    end
    if key == "k" and por and getTickCount() - lastLock > 500 then
      local occupant = true
      if not veh then
        occupant = false
        local dist = 6
        local vehs = getElementsByType("vehicle", getRootElement(), true)
        local px, py, pz = getElementPosition(localPlayer)
        for i = 1, #vehs do
          local x, y, z = getElementPosition(vehs[i])
          local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
          if dist > d then
            dist = d
            veh = vehs[i]
          end
        end
      end
      if veh then --if veh and not sightexports.sInteriors:getCurrentStandingInterior() and not sightexports.sPaintshop:getStandingInMarker() then
        if getVehicleKey(veh) then
          if occupant then
            triggerServerEvent("lockUnlockVehicle", localPlayer, veh, occupant)
          else
            triggerServerEvent("lockUnlockVehicle", localPlayer, veh, occupant, getElementsByType("player", getRootElement(), true))
          end
          lastLock = getTickCount()
        else
          sightexports.sGui:showInfobox("e", "Nincs kulcsod a járműhöz!")
        end
      end
    end
  end
end)
local vehicleSounds = {}
addEvent("carStartingSound", true)
addEventHandler("carStartingSound", getRootElement(), function(sound, speed)
  if isElement(source) then
    if sound == "startfail" then
      if isElement(vehicleSounds[source]) then
        destroyElement(vehicleSounds[source])
      end
      vehicleSounds[source] = nil
    elseif sound == "started" then
      if isElement(vehicleSounds[source]) then
        destroyElement(vehicleSounds[source])
      end
      if speedoVehicle == source then
        vehicleSounds[source] = playSound("files/started.mp3")
        setSoundVolume(vehicleSounds[source], 0.75)
      else
        vehicleSounds[source] = playSound3D("files/started.mp3", 0, 0, 0)
        setElementDimension(vehicleSounds[source], getElementDimension(source))
        setElementInterior(vehicleSounds[source], getElementInterior(source))
        attachElements(vehicleSounds[source], source)
      end
    elseif sound == "starting" then
      if isElement(vehicleSounds[source]) then
        destroyElement(vehicleSounds[source])
      end
      if speedoVehicle == source then
        vehicleSounds[source] = playSound("files/starting.mp3", true)
        setSoundVolume(vehicleSounds[source], 0.75)
      else
        vehicleSounds[source] = playSound3D("files/starting.mp3", 0, 0, 0, true)
        setElementDimension(vehicleSounds[source], getElementDimension(source))
        setElementInterior(vehicleSounds[source], getElementInterior(source))
        attachElements(vehicleSounds[source], source)
      end
    elseif sound == "key" then
      playSound("files/key.mp3")
    elseif sound == "eloff" then
      playSound("files/eloff.mp3")
    elseif sound == "elon" then
      playSound("files/elon.mp3")
    end
  end
end)
function getPositionFromMatrixOffset(m, offX, offY, offZ)
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z
end
function getPositionFromElementOffset(element, offX, offY, offZ)
  local m = getElementMatrix(element)
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z
end
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
function makeMatrix(rx, ry, rz)
  rx, ry, rz = math.rad(rx), math.rad(ry), math.rad(rz)
  local m = {}
  m[1] = {}
  m[1][1] = math.cos(rz) * math.cos(ry) - math.sin(rz) * math.sin(rx) * math.sin(ry)
  m[1][2] = math.cos(ry) * math.sin(rz) + math.cos(rz) * math.sin(rx) * math.sin(ry)
  m[1][3] = -math.cos(rx) * math.sin(ry)
  m[1][4] = 1
  m[2] = {}
  m[2][1] = -math.cos(rx) * math.sin(rz)
  m[2][2] = math.cos(rz) * math.cos(rx)
  m[2][3] = math.sin(rx)
  m[2][4] = 1
  m[3] = {}
  m[3][1] = math.cos(rz) * math.sin(ry) + math.cos(ry) * math.sin(rz) * math.sin(rx)
  m[3][2] = math.sin(rz) * math.sin(ry) - math.cos(rz) * math.cos(ry) * math.sin(rx)
  m[3][3] = math.cos(rx) * math.cos(ry)
  m[3][4] = 1
  return m
end
function spawnFume(vx, vy, vz, fx, fy, fz, rx, ry, rz, size, c, a, velx, vely, velz)
  local m = makeMatrix(rx, ry, rz)
  local fox = fx * m[1][1] + fy * m[2][1] + fz * m[3][1] + vx
  local foy = fx * m[1][2] + fy * m[2][2] + fz * m[3][2] + vy
  local foz = fx * m[1][3] + fy * m[2][3] + fz * m[3][3] + vz
  local offX, offY, offZ = math.random(-35, 35) / 100, -0.8 - math.random(50) / 100, math.random(40) / 100
  local ox = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1]
  local oy = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2]
  local oz = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3]
  spawnParticle(fox, foy, foz, ox + velx, oy + vely, oz + velz, math.random(2500, 3500) * size, c, c, c, math.random(200, 230) * size * a, math.random(30, 35) / 100, math.random(70, 90) / 100 * size)
end
local collisionsmoke
local crashTexture = {
  "files/crash1.dds",
  "files/crash2.dds",
  "files/crash3.dds",
  "files/crash4.dds",
  "files/shard1.dds",
  "files/shard2.dds",
  "files/shard3.dds",
  "files/shard4.dds",
  "files/shard5.dds",
  "files/cardebris1.dds",
  "files/cardebris2.dds",
  "files/cardebris3.dds",
  "files/cardebris4.dds",
  "files/cardebris5.dds"
}
local vehiclesLoading = 0
local vehiclesMax = 0
local screenX, screenY = guiGetScreenSize()
local nearbyVehiclesCache = {}
local nearbyVehiclesState = false
function renderNearbyVehicles()
  dxDrawText("Nearby vehicles on", 1, screenY - 256 + 1, screenX + 1, screenY + 1, tocolor(0, 0, 0), nearbyFontScale * 1.5, nearbyFont, "center", "center")
  dxDrawText("Nearby vehicles on", 0, screenY - 256, screenX, screenY, greenToColor, nearbyFontScale * 1.5, nearbyFont, "center", "center")
  local vehicles = getElementsByType("vehicle")
  for i = 1, #vehicles do
    local veh = vehicles[i]
    if isElementOnScreen(veh) then
      local x, y, z = getElementPosition(veh)
      local x, y = getScreenFromWorldPosition(x, y, z, 128)
      if x then
        if not nearbyVehiclesCache[veh] then
          nearbyVehiclesCache[veh] = {}
        end
        if not nearbyVehiclesCache[veh].model then
          nearbyVehiclesCache[veh].model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
        end
        if not nearbyVehiclesCache[veh].name then
          nearbyVehiclesCache[veh].name = sightexports.sVehiclenames:getCustomVehicleName(nearbyVehiclesCache[veh].model)
        end
        if not nearbyVehiclesCache[veh].gta then
          nearbyVehiclesCache[veh].gta = getVehicleName(veh)
        end
        if not nearbyVehiclesCache[veh].plate then
          nearbyVehiclesCache[veh].plate = getVehiclePlateText(veh) or ""
        end
        if not nearbyVehiclesCache[veh].dbID then
          nearbyVehiclesCache[veh].dbID = getElementData(veh, "vehicle.dbID") or "N/A"
        end


        nearbyVehiclesCache[veh].health = (getElementHealth(veh) / 10) or 0

        dxDrawText(nearbyVehiclesCache[veh].name .. " (" .. nearbyVehiclesCache[veh].model .. "/" .. nearbyVehiclesCache[veh].gta .. ")", x + 1, y + 1, x + 1, y + 1, tocolor(0, 0, 0), nearbyFontScale, nearbyFont, "center", "center")
        dxDrawText(nearbyVehiclesCache[veh].name .. " (" .. nearbyVehiclesCache[veh].model .. "/" .. nearbyVehiclesCache[veh].gta .. ")", x, y, x, y, greenToColor, nearbyFontScale, nearbyFont, "center", "center")
        y = y + nearbyFontH
        dxDrawText("ID: " .. nearbyVehiclesCache[veh].dbID, x + 1, y + 1, x + 1, y + 1, tocolor(0, 0, 0), nearbyFontScale, nearbyFont, "center", "center")
        dxDrawText("ID: " .. nearbyVehiclesCache[veh].dbID, x, y, x, y, tocolor(255, 255, 255), nearbyFontScale, nearbyFont, "center", "center")
        y = y + nearbyFontH
        dxDrawText("Rendszám: " .. nearbyVehiclesCache[veh].plate, x + 1, y + 1, x + 1, y + 1, tocolor(0, 0, 0), nearbyFontScale, nearbyFont, "center", "center")
        dxDrawText("Rendszám: " .. nearbyVehiclesCache[veh].plate, x, y, x, y, tocolor(255, 255, 255), nearbyFontScale, nearbyFont, "center", "center")
        y = y + nearbyFontH
        dxDrawText("Állapot: " .. nearbyVehiclesCache[veh].health .. "%", x + 1, y + 1, x + 1, y + 1, tocolor(0, 0, 0), nearbyFontScale, nearbyFont, "center", "center")
        dxDrawText("Állapot: " .. nearbyVehiclesCache[veh].health .. "%", x, y, x, y, tocolor(255, 255, 255), nearbyFontScale, nearbyFont, "center", "center")
      end
    end
  end
end
addCommandHandler("nearbyvehicles", function()
  if sightexports.sPermission:hasPermission(localPlayer, "nearbyvehicles") then
    nearbyVehiclesState = not nearbyVehiclesState
    if nearbyVehiclesState then
      outputChatBox("[color=sightgreen][SightMTA - Járművek]: #ffffffNearby vehicles: [color=sightblue]be", 255, 255, 255, true)
      addEventHandler("onClientRender", getRootElement(), renderNearbyVehicles)
    else
      nearbyVehiclesCache = {}
      outputChatBox("[color=sightgreen][SightMTA - Járművek]: #ffffffNearby vehicles: [color=sightblue]ki", 255, 255, 255, true)
      removeEventHandler("onClientRender", getRootElement(), renderNearbyVehicles)
    end
  end
end)
addCommandHandler("nearbyvehicles2", function()
  local x, y, z = getElementPosition(localPlayer)
  local vehs = getElementsByType("vehicle", getRootElement(), true)
  outputChatBox("[color=sightgreen][SightMTA - Járművek]: #ffffffKözeledben lévő járművek:", 255, 255, 255, true)
  local found = false
  for i = 1, #vehs do
    local veh = vehs[i]
    local vx, vy, vz = getElementPosition(veh)
    if getDistanceBetweenPoints3D(x, y, z, vx, vy, vz) < 15 then
      local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
      outputChatBox(" > [color=sightblue-second][" .. (getElementData(veh, "vehicle.dbID") or "N/A") .. "]#ffffff:  " .. sightexports.sVehiclenames:getCustomVehicleName(model) .. " (" .. model .. "), Rendszám: [color=sightblue-second]" .. (getVehiclePlateText(veh) or ""), 255, 255, 255, true)
      found = true
    end
  end
  if not found then
    outputChatBox(" [color=sightlightgrey]> Nincsen a közeledben egy jármű sem", 255, 255, 255, true)
  end
end)
function renderVehicleLoader()
  local now = getTickCount()
  local sp = 40
  local w = sp + 8 + math.ceil(dxGetTextWidth("Járműveid betöltése (999/999)", loadingFontScale, loadingFont)) + 16
  local y = screenY - 124 - sp - 8
  dxDrawRectangle(screenX / 2 - w / 2, y, sp + 8, sp + 8, tocolor(grey1[1], grey1[2], grey1[3]))
  dxDrawRectangle(screenX / 2 - w / 2 + sp + 8, y, w - (sp + 8), sp + 8, tocolor(grey2[1], grey2[2], grey2[3]))
  if 0 < vehiclesMax then
    dxDrawRectangle(screenX / 2 - w / 2, y + sp + 8, w, 4, tocolor(grey1[1], grey1[2], grey1[3]))
    dxDrawRectangle(screenX / 2 - w / 2, y + sp + 8, w * (1 - vehiclesLoading / vehiclesMax), 4, tocolor(green[1], green[2], green[3]))
    dxDrawText("Járműveid betöltése (" .. vehiclesMax - vehiclesLoading .. "/" .. vehiclesMax .. ")", screenX / 2 - w / 2 + sp + 8, y, screenX / 2 + w / 2, y + sp + 8, tocolor(255, 255, 255, 255), loadingFontScale, loadingFont, "center", "center")
  else
    dxDrawText("Járműveid betöltése (" .. vehiclesLoading .. ")", screenX / 2 - w / 2 + sp + 8, y, screenX / 2 + w / 2, y + sp + 8, tocolor(255, 255, 255, 255), loadingFontScale, loadingFont, "center", "center")
  end
  sightlangStaticImageUsed[0] = true
  if sightlangStaticImageToc[0] then
    processsightlangStaticImage[0]()
  end
  dxDrawImage(screenX / 2 - w / 2 + 4, y + 4, sp, sp, sightlangStaticImage[0], 0, 0, 0, tocolor(green[1] * 0.1, green[2] * 0.1, green[3] * 0.1, 200))
  sightlangStaticImageUsed[1] = true
  if sightlangStaticImageToc[1] then
    processsightlangStaticImage[1]()
  end
  dxDrawImage(screenX / 2 - w / 2 + 4, y + 4, sp, sp, sightlangStaticImage[1], -now / 4.75 % 360, 0, 0, tocolor(green[1], green[2], green[3], 255))
end
local canShowLoader = getElementData(localPlayer, "loggedIn")
function canShowVehicleLoader()
  canShowLoader = true
  sightlangCondHandl2(canShowLoader and 0 < vehiclesLoading)
end
addEvent("refreshVehiclesQueue", true)
addEventHandler("refreshVehiclesQueue", getRootElement(), function(queue, forceNew)
  if queue then
    vehiclesLoading = queue
    vehiclesMax = forceNew and forceNew or math.max(vehiclesMax, vehiclesLoading)
    sightlangCondHandl2(canShowLoader and 0 < vehiclesLoading)
  end
end)
local fumeDisable = {}
local lastFume = {}
local fuelType = {}
local vehicleSoundOnReplaces = {}
local vehicleSoundOffReplaces = {}
function testVehicleType(model)
  if not getVehicleType(model) then
    return
  end
  return utf8.len(getVehicleType(model)) > 0
end
function registerFuelReplace(model, fuel, value)
  if not testVehicleType(model) then
    return
  end
  if value and model ~= value and testVehicleType(value) then
    if not vehicleSoundOnReplaces[model] then
      vehicleSoundOnReplaces[model] = {}
    end
    --vehicleSoundOnReplaces[model][fuel] = getVehicleModelAudioSetting(value)["engine-on-soundbank-id"]
    if not vehicleSoundOffReplaces[model] then
      vehicleSoundOffReplaces[model] = {}
    end
    --vehicleSoundOffReplaces[model][fuel] = getVehicleModelAudioSetting(value)["engine-off-soundbank-id"]
  else
    if vehicleSoundOnReplaces[model] then
      vehicleSoundOnReplaces[model][fuel] = nil
    end
    if vehicleSoundOffReplaces[model] then
      vehicleSoundOffReplaces[model][fuel] = nil
    end
  end
end
addEvent("forceSetVehicleSound", true)
addEventHandler("forceSetVehicleSound", getRootElement(), function(value)
  if isElement(source) and getElementType(source) == "vehicle" then
    --resetVehicleEngineSounds(source)
    --if value and testVehicleType(value) then
    --  local val = getVehicleModelAudioSetting(value)["engine-on-soundbank-id"]
    --  setVehicleAudioSetting(source, "engine-on-soundbank-id", val)
    --  local val = getVehicleModelAudioSetting(value)["engine-off-soundbank-id"]
    --  setVehicleAudioSetting(source, "engine-off-soundbank-id", val)
    --end
    --applyVehicleAudioSettings(source)
  end
end)
function refreshFuelTypeSound(veh)
  if isElement(veh) then
    --resetVehicleEngineSounds(veh)
    local fuel = fuelType[veh]
    local model = getElementModel(veh)
    if vehicleSoundOnReplaces[model] then
      local sound = vehicleSoundOnReplaces[model][fuel]
      if sound then
        --setVehicleAudioSetting(veh, "engine-on-soundbank-id", sound)
      end
    end
    if vehicleSoundOffReplaces[model] then
      local sound = vehicleSoundOffReplaces[model][fuel]
      if sound then
        --setVehicleAudioSetting(veh, "engine-off-soundbank-id", sound)
      end
    end
    --applyVehicleAudioSettings(veh)
  end
end
function getVehicleSpeed(currentElement)
  if isElement(currentElement) then
    local x, y, z = getElementVelocity(currentElement)
    return math.sqrt(x ^ 2 + y ^ 2 + z ^ 2) * 187.5
  end
end
local lastGear = {}
local lastShift = {}
local unfreezeVehicles = {}
local crashParticles = {}
function spawnCrashParticle(keep, x, y, z, v, t, r, g, b, a, size)
  local r1 = math.rad(math.random(0, 3600) / 10)
  local r2 = math.rad(math.random(0, 3600) / 10)
  local vert = math.random(200, 1200) / 250 * v
  local hor = math.random(400, 600) / 75
  if not keep then
    vert = vert * 1.1
    hor = hor * 1.5
    z = z - 0.15
  end
  table.insert(crashParticles, {
    x,
    y,
    z,
    math.cos(r1),
    math.sin(r1),
    math.cos(r2) * vert,
    math.sin(r2) * vert,
    hor,
    size,
    false,
    t,
    r,
    g,
    b,
    a,
    keep
  })
end
local groundCache = {}
local oldTurboSound = {}
local turboSound = {}
local gearSpeeds = {}
local tmpg = {}
local vol = {}
local turboSpeed = {}
local discharge = {}
local lastSpeed = {}
local turboBlowoff = {}
local turboBlowoffVolume = {}
local turboSoundVolume = {}
function createTurboSound(veh, dat)
  local customTurbo = dat or getElementData(veh, "customTurbo")
  if customTurbo then
    if isElement(turboSound[veh]) then
      destroyElement(turboSound[veh])
    end
    gearSpeeds[veh] = {
      0,
      0,
      0,
      0,
      0
    }
    tmpg[veh] = 0
    lastSpeed[veh] = 0
    vol[veh] = 0
    discharge[veh] = 1
    turboSpeed[veh] = 0
    turboBlowoff[veh] = customTurbo[4]
    turboBlowoffVolume[veh] = customTurbo[3]
    turboSoundVolume[veh] = customTurbo[1]
    turboSound[veh] = playSound3D("files/turbo" .. customTurbo[2] .. ".wav", 0, 0, 0, true)
    setElementDimension(turboSound[veh], getElementDimension(veh))
    setElementInterior(turboSound[veh], getElementInterior(veh))
    setSoundVolume(turboSound[veh], 0)
    local x, y, z = getVehicleDummyPosition(veh, "engine")
    attachElements(turboSound[veh], veh, x, y, z)
  else
    deleteTurboSound(veh)
  end
end
local previewCharger = {}
local superChargers = {}
local superChargerSound = {}
function processSuperChargerSound(veh, force)
  if getElementData(veh, "superCharger") or force then
    local model = getElementModel(veh)
    if superChargerOffsets[model] then
      superChargerSound[veh] = playSound3D("files/whine.wav", 0, 0, 0, true)
      setElementDimension(superChargerSound[veh], getElementDimension(veh))
      setElementInterior(superChargerSound[veh], getElementInterior(veh))
      setSoundVolume(superChargerSound[veh], 0)
    else
      deleteSuperCharger(veh)
    end
  else
    deleteSuperCharger(veh)
  end
end
function resetPreviewSuperchargers()
  for veh in pairs(previewCharger) do
    if not isElement(veh) or not getElementData(veh, "superCharger") then
      deleteSuperCharger(veh)
    end
    previewCharger[veh] = nil
  end
end
function createPreviewSupercharger(veh)
  deleteSuperCharger(veh)
  local model = getElementModel(veh)
  if superChargerOffsets[model] then
    previewCharger[veh] = true
    if not superChargers[veh] then
      superChargers[veh] = {}
    end
    local int = getElementInterior(veh)
    local dim = getElementDimension(veh)
    if not isElement(superChargers[veh][1]) then
      superChargers[veh][1] = createObject(objectModels.supercharger, 0, 0, 0)
    end
    setElementCollisionsEnabled(superChargers[veh][1], false)
    setElementInterior(superChargers[veh][1], int)
    setElementDimension(superChargers[veh][1], dim)
    if not isElement(superChargers[veh][2]) then
      superChargers[veh][2] = createObject(objectModels.supercharger_butterfly_valves, 0, 0, 0)
    end
    setElementCollisionsEnabled(superChargers[veh][2], false)
    setElementInterior(superChargers[veh][2], int)
    setElementDimension(superChargers[veh][2], dim)
    if not isElement(superChargers[veh][3]) then
      superChargers[veh][3] = createObject(objectModels.supercharger_pully, 0, 0, 0)
    end
    setElementCollisionsEnabled(superChargers[veh][3], false)
    setElementInterior(superChargers[veh][3], int)
    setElementDimension(superChargers[veh][3], dim)
    if not isElement(superChargers[veh][4]) then
      superChargers[veh][4] = createObject(objectModels.supercharger_pully2, 0, 0, 0)
    end
    setElementCollisionsEnabled(superChargers[veh][4], false)
    setElementInterior(superChargers[veh][4], int)
    setElementDimension(superChargers[veh][4], dim)
    superChargers[veh][5] = superChargerOffsets[model]
    superChargers[veh][6] = 0
    superChargers[veh][7] = 0
    superChargers[veh][8] = 0
    gearSpeeds[veh] = {
      0,
      0,
      0,
      0,
      0
    }
    tmpg[veh] = 0
    lastSpeed[veh] = 0
    vol[veh] = 0
    return superChargers[veh][1], superChargers[veh][2], superChargers[veh][3], superChargers[veh][4]
  end
end
function processSuperCharger(veh, force)
  if previewCharger[veh] or force then
    deleteSuperCharger(veh)
  end
  if getElementData(veh, "superCharger") then
    processSuperChargerSound(veh)
    local model = getElementModel(veh)
    if superChargerOffsets[model] then
      if not superChargers[veh] then
        superChargers[veh] = {}
      end
      local int = getElementInterior(veh)
      local dim = getElementDimension(veh)
      if not isElement(superChargers[veh][1]) then
        superChargers[veh][1] = createObject(objectModels.supercharger, 0, 0, 0)
      end
      setElementCollisionsEnabled(superChargers[veh][1], false)
      setElementInterior(superChargers[veh][1], int)
      setElementDimension(superChargers[veh][1], dim)
      if not isElement(superChargers[veh][2]) then
        superChargers[veh][2] = createObject(objectModels.supercharger_butterfly_valves, 0, 0, 0)
      end
      setElementCollisionsEnabled(superChargers[veh][2], false)
      setElementInterior(superChargers[veh][2], int)
      setElementDimension(superChargers[veh][2], dim)
      if not isElement(superChargers[veh][3]) then
        superChargers[veh][3] = createObject(objectModels.supercharger_pully, 0, 0, 0)
      end
      setElementCollisionsEnabled(superChargers[veh][3], false)
      setElementInterior(superChargers[veh][3], int)
      setElementDimension(superChargers[veh][3], dim)
      if not isElement(superChargers[veh][4]) then
        superChargers[veh][4] = createObject(objectModels.supercharger_pully2, 0, 0, 0)
      end
      setElementCollisionsEnabled(superChargers[veh][4], false)
      setElementInterior(superChargers[veh][4], int)
      setElementDimension(superChargers[veh][4], dim)
      superChargers[veh][5] = superChargerOffsets[model]
      superChargers[veh][6] = 0
      superChargers[veh][7] = 0
      superChargers[veh][8] = 0
      gearSpeeds[veh] = {
        0,
        0,
        0,
        0,
        0
      }
      tmpg[veh] = 0
      lastSpeed[veh] = 0
      vol[veh] = 0
    end
  end
end
function deleteSuperCharger(veh)
  if superChargers[veh] then
    if isElement(superChargers[veh][1]) then
      destroyElement(superChargers[veh][1])
    end
    if isElement(superChargers[veh][2]) then
      destroyElement(superChargers[veh][2])
    end
    if isElement(superChargers[veh][3]) then
      destroyElement(superChargers[veh][3])
    end
    if isElement(superChargers[veh][4]) then
      destroyElement(superChargers[veh][4])
    end
  end
  if isElement(superChargerSound[veh]) then
    destroyElement(superChargerSound[veh])
  end
  superChargerSound[veh] = nil
  superChargers[veh] = nil
  previewCharger[veh] = nil
  resetCommonVars(veh)
end
function deleteTurboSound(veh)
  if isElement(turboSound[veh]) then
    destroyElement(turboSound[veh])
  end
  turboSound[veh] = nil
  turboSpeed[veh] = nil
  discharge[veh] = nil
  turboBlowoff[veh] = nil
  turboBlowoffVolume[veh] = nil
  turboSoundVolume[veh] = nil
  resetCommonVars(veh)
end
function resetCommonVars(veh)
  if not turboSound[veh] and not superChargers[veh] then
    gearSpeeds[veh] = nil
    tmpg[veh] = nil
    lastSpeed[veh] = nil
    vol[veh] = nil
  end
end
local vehs = getElementsByType("vehicle", getRootElement(), true)
for i = 1, #vehs do
  createTurboSound(vehs[i])
  processSuperCharger(vehs[i], true)
  oldTurboSound[vehs[i]] = getElementData(vehs[i], "oldTurboSound")
end
local lowStamina = {}
local players = getElementsByType("player")
for i = 1, #players do
  if getElementData(players[i], "lowStamina") then
    lowStamina[players[i]] = true
  end
end
local lastKnock = {}
local vehicleTypes = {}
local vt = getVehicleType
function getVehicleType(veh)
  if not vehicleTypes[veh] then
    vehicleTypes[veh] = vt(veh)
  end
  return vehicleTypes[veh]
end
function vehicleStreamOut()
  if getElementType(source) == "vehicle" and not previewCharger[source] then
    deleteTurboSound(source)
    deleteSuperCharger(source, true)
    vehicleTypes[source] = nil
    fumeDisable[source] = nil
    lastFume[source] = nil
    fuelType[source] = nil
    lastGear[source] = nil
    lastShift[source] = nil
    unfreezeVehicles[source] = nil
    lastKnock[source] = nil
  end
end
addEventHandler("onClientElementStreamOut", getRootElement(), vehicleStreamOut)
function vehicleDestroy()
  if getElementType(source) == "vehicle" then
    deleteTurboSound(source)
    deleteSuperCharger(source, true)
    vehicleTypes[source] = nil
    fumeDisable[source] = nil
    lastFume[source] = nil
    fuelType[source] = nil
    lastGear[source] = nil
    lastShift[source] = nil
    unfreezeVehicles[source] = nil
    lastKnock[source] = nil
    if isElement(vehicleSounds[source]) then
      destroyElement(vehicleSounds[source])
    end
    vehicleSounds[source] = nil
    oldTurboSound[source] = nil
  end
end
addEventHandler("onClientElementDestroy", getRootElement(), vehicleDestroy)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
  if getElementType(source) == "player" then
    processPlayerJumper(source, false)
  end
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
  processPlayerJumper(source, false)
  lowStamina[source] = nil
  playerAccelerate[source] = nil
end)
function setFumeDisable(veh, state)
  fumeDisable[veh] = state
end
local bigFontRaw = "19/BebasNeueBold.otf"
local midFontRaw = "10/BebasNeueBold.otf"
local bigFont = false
local bigFontScale = 1
local bigFontH = 1
local midFont = false
local midFontScale = false
local midFontH = false
local speedoColor = false
local speedoColorEx = false
function guiRefreshColors()
  bigFont = sightexports.sGui:getFont(bigFontRaw)
  bigFontScale = sightexports.sGui:getFontScale(bigFontRaw)
  bigFontH = sightexports.sGui:getFontHeight(bigFontRaw)
  midFont = sightexports.sGui:getFont(midFontRaw)
  midFontScale = sightexports.sGui:getFontScale(midFontRaw)
  midFontH = sightexports.sGui:getFontHeight(midFontRaw)
  speedoColor = sightexports.sGui:getColorCodeToColor("hudwhite")
  speedoColorEx = bitReplace(speedoColor, bitExtract(speedoColor, 0, 8) * 0.55, 0, 8)
  speedoColorEx = bitReplace(speedoColorEx, bitExtract(speedoColor, 8, 8) * 0.55, 8, 8)
  speedoColorEx = bitReplace(speedoColorEx, bitExtract(speedoColor, 16, 8) * 0.55, 16, 8)
  redColor = sightexports.sGui:getColorCodeToColor("sightred")
end
local widgetState = false
local widgetPos = {0, 0}
addEvent("hudWidgetState:turbo", true)
addEventHandler("hudWidgetState:turbo", getRootElement(), function(state)
  if widgetState ~= state then
    widgetState = state
    if widgetState then
      addEventHandler("onClientRender", getRootElement(), renderTurboWidget)
    else
      removeEventHandler("onClientRender", getRootElement(), renderTurboWidget)
    end
  end
end)
addEvent("hudWidgetPosition:turbo", true)
addEventHandler("hudWidgetPosition:turbo", getRootElement(), function(pos, final)
  widgetPos = {
    math.floor(pos[1]),
    math.floor(pos[2])
  }
end)
function renderTurboWidget()
  if speedoVehicle and turboSpeed[speedoVehicle] then
    local wx, wy = widgetPos[1], widgetPos[2]
    local r = math.max(-36.86666666666667, turboSpeed[speedoVehicle] * 65)
    if r < 0 then
      r = r * 2.5
    end
    local redProg = math.min(1, math.max(0, (r - 125) / 13.888888888888888 + 1))
    if 0 < redProg then
      sightlangStaticImageUsed[2] = true
      if sightlangStaticImageToc[2] then
        processsightlangStaticImage[2]()
      end
      dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[2], 0, 0, 0, bitReplace(redColor, 100 * redProg, 24, 8))
    end
    if speedoVehicleLight then
      sightlangStaticImageUsed[3] = true
      if sightlangStaticImageToc[3] then
        processsightlangStaticImage[3]()
      end
      dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[3], 0, 0, 0, tocolor(255, 255, 255, 100))
      sightlangStaticImageUsed[4] = true
      if sightlangStaticImageToc[4] then
        processsightlangStaticImage[4]()
      end
      dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[4], 0, 0, 0, tocolor(215, 89, 89, 100))
    end
    sightlangStaticImageUsed[5] = true
    if sightlangStaticImageToc[5] then
      processsightlangStaticImage[5]()
    end
    dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[5])
    sightlangStaticImageUsed[6] = true
    if sightlangStaticImageToc[6] then
      processsightlangStaticImage[6]()
    end
    dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[6], 0, 0, 0, tocolor(215, 89, 89, 255))
    local rad = math.rad(35)
    local rad2 = math.rad(250) / 6
    for i = 0, 6 do
      local x = 100 - math.cos(-rad + rad2 * i) * 42
      local y = 100 - math.sin(-rad + rad2 * i) * 42
      local n = -1 + i * 0.5
      local progress = 0
      if n == 0 then
        progress = 1
      elseif 0 < n then
        progress = math.min(1, math.max(0, (r - 41.666666666666664 * (i - 2)) / 13.888888888888888 + 1))
      else
        progress = 1 - math.min(1, math.max(0, (r - 41.666666666666664 * (i - 2)) / 13.888888888888888))
      end
      if 4 < i and 0 < progress then
        dxDrawText(n, wx + x, wy + y, wx + x, wy + y, bitReplace(speedoColor, 53 * (1 - progress), 24, 8), midFontScale, midFont, "center", "center")
        dxDrawText(n, wx + x, wy + y, wx + x, wy + y, bitReplace(redColor, 255 * progress, 24, 8), midFontScale, midFont, "center", "center")
      elseif n < 0 then
        if 0 < progress then
          dxDrawText(n, wx + x, wy + y, wx + x, wy + y, bitReplace(speedoColor, 53 * (1 - progress), 24, 8), midFontScale, midFont, "center", "center")
          dxDrawText(n, wx + x, wy + y, wx + x, wy + y, bitReplace(speedoColorEx, 53 + 202 * progress, 24, 8), midFontScale, midFont, "center", "center")
        else
          dxDrawText(n, wx + x, wy + y, wx + x, wy + y, bitReplace(speedoColor, 53, 24, 8), midFontScale, midFont, "center", "center")
        end
      else
        dxDrawText(n, wx + x, wy + y, wx + x, wy + y, bitReplace(speedoColor, 53 + 202 * progress, 24, 8), midFontScale, midFont, "center", "center")
      end
    end
    local w = 12
    local bar = r / 41.666666666666664 * 0.5
    local vac = bar < 0
    bar = math.abs(math.floor(bar * 100 + 0.5))
    local digit = math.floor(bar / 100)
    bar = bar - digit * 100
    local x = wx + 100 - w * 3.5 / 2
    local col = speedoColor
    local col2 = speedoColor
    if 0 < redProg then
      col = bitReplace(speedoColor, 255 * (1 - redProg), 24, 8)
      col2 = bitReplace(redColor, 255 * redProg, 24, 8)
    end
    dxDrawText(digit, x, wy + 44, x + w, wy + 140, col, bigFontScale, bigFont, "center", "center")
    if 0 < redProg then
      dxDrawText(digit, x, wy + 44, x + w, wy + 140, col2, bigFontScale, bigFont, "center", "center")
    end
    dxDrawText(".", x + w, wy + 44, x + w * 1.5, wy + 140, col, bigFontScale, bigFont, "center", "center")
    if 0 < redProg then
      dxDrawText(".", x + w, wy + 44, x + w * 1.5, wy + 140, col2, bigFontScale, bigFont, "center", "center")
    end
    local digit = math.floor(bar / 10)
    bar = bar - digit * 10
    dxDrawText(digit, x + w * 1.5, wy + 44, x + w * 2.5, wy + 140, col, bigFontScale, bigFont, "center", "center")
    if 0 < redProg then
      dxDrawText(digit, x + w * 1.5, wy + 44, x + w * 2.5, wy + 140, col2, bigFontScale, bigFont, "center", "center")
    end
    dxDrawText(bar, x + w * 2.5, wy + 44, x + w * 3.5, wy + 140, col, bigFontScale, bigFont, "center", "center")
    if 0 < redProg then
      dxDrawText(bar, x + w * 2.5, wy + 44, x + w * 3.5, wy + 140, col2, bigFontScale, bigFont, "center", "center")
    end
    dxDrawText(vac and "VAC" or "BOOST", wx, wy + 44 + bigFontH, wx + 200, wy + 140 + bigFontH, col, midFontScale, midFont, "center", "center")
    if 0 < redProg then
      dxDrawText(vac and "VAC" or "BOOST", wx, wy + 44 + bigFontH, wx + 200, wy + 140 + bigFontH, col2, midFontScale, midFont, "center", "center")
    end
    local dp = 48.33333333333333
    r = math.min(215 - dp, math.max(-35 - dp, r))
    local n = math.floor((r - 25) / 25 * 0.25 * 100 + 0.5)
    if 5 <= math.abs(r) then
      if 0 < r then
        sightlangStaticImageUsed[7] = true
        if sightlangStaticImageToc[7] then
          processsightlangStaticImage[7]()
        end
        dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[7], 35 + r + dp, 0, 0, 126 < r and redColor or speedoColor)
        for i = 1, math.floor(math.abs(r) / 9) do
          if 14 < i then
            sightlangStaticImageUsed[7] = true
            if sightlangStaticImageToc[7] then
              processsightlangStaticImage[7]()
            end
            dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[7], 35 + dp + 9 * i, 0, 0, redColor)
          else
            sightlangStaticImageUsed[7] = true
            if sightlangStaticImageToc[7] then
              processsightlangStaticImage[7]()
            end
            dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[7], 35 + dp + 9 * i, 0, 0, speedoColor)
          end
        end
      else
        sightlangStaticImageUsed[7] = true
        if sightlangStaticImageToc[7] then
          processsightlangStaticImage[7]()
        end
        dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[7], 35 + r + dp + 10, 0, 0, speedoColorEx)
        for i = 1, math.floor(math.abs(r) / 9) do
          sightlangStaticImageUsed[7] = true
          if sightlangStaticImageToc[7] then
            processsightlangStaticImage[7]()
          end
          dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[7], 35 + dp + 10 - 9 * i, 0, 0, speedoColorEx)
        end
      end
    end
    sightlangStaticImageUsed[7] = true
    if sightlangStaticImageToc[7] then
      processsightlangStaticImage[7]()
    end
    dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[7], 35 + dp + 4, 0, 0, speedoColorEx)
    sightlangStaticImageUsed[8] = true
    if sightlangStaticImageToc[8] then
      processsightlangStaticImage[8]()
    end
    dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[8], 35 + dp + 5 + 6, 0, 0, speedoColor)
    if 1 <= redProg then
      sightlangStaticImageUsed[9] = true
      if sightlangStaticImageToc[9] then
        processsightlangStaticImage[9]()
      end
      dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[9], r + dp, 0, 0, redColor)
    elseif r < 0 then
      sightlangStaticImageUsed[9] = true
      if sightlangStaticImageToc[9] then
        processsightlangStaticImage[9]()
      end
      dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[9], r + dp, 0, 0, speedoColorEx)
    else
      sightlangStaticImageUsed[9] = true
      if sightlangStaticImageToc[9] then
        processsightlangStaticImage[9]()
      end
      dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[9], r + dp)
    end
    sightlangStaticImageUsed[10] = true
    if sightlangStaticImageToc[10] then
      processsightlangStaticImage[10]()
    end
    dxDrawImage(wx, wy, 200, 200, sightlangStaticImage[10], 0, 0, 0, tocolor(0, 0, 0, 255))
  end
end
triggerEvent("requestWidgetDatas", localPlayer, "turbo")
local turboPreviewProgress = false
local turboPreviewSound = false
local turboPreviewSoundId = false
local turboPreviewBlowoffSound = false
local turboPreivewVol = 0
local turboPreviewSoundVol = 1
local turboPreviewBoffVol = 1
function previewTurboSound(veh, id, boff, sv, bv)
  turboPreviewVeh = veh
  if not turboPreviewProgress then
    if isElement(veh) then
      turboPreviewProgress = 0
      turboPreivewVol = 0
      turboPreviewSoundVol = sv
      turboPreviewBoffVol = bv
      if sv <= 0.05 then
        turboPreviewProgress = 2.5
        if turboPreviewSoundId == 1 then
          local pitch = math.min(math.max(0.2, turboPreviewProgress * 1.7), 4) + 0.2
          turboPreivewVol = getEasingValue(math.max(math.min(turboPreviewProgress * 3 - 0.5, 1), 0), "OutQuad") + math.max(0, 0.15 * (pitch - 0.8) / 3)
        else
          local pitch = math.min(math.max(0.3, turboPreviewProgress * 1.15), 4) + 0.25
          turboPreivewVol = getEasingValue(math.max(math.min(turboPreviewProgress * 2 - 0.5, 1), 0), "OutQuad") * 0.8 + math.max(0, 0.25 * (pitch - 1) / 3)
        end
      else
        turboPreviewSound = playSound3D("files/turbo" .. id .. ".wav", 0, 0, 0, true)
        setElementDimension(turboPreviewSound, getElementDimension(veh))
        setElementInterior(turboPreviewSound, getElementInterior(veh))
        setSoundVolume(turboPreviewSound, 0)
        local x, y, z = getVehicleDummyPosition(veh, "engine")
        attachElements(turboPreviewSound, veh, x, y, z)
        turboPreviewSoundId = id
      end
      turboPreviewBlowoffSound = boff
      addEventHandler("onClientPreRender", getRootElement(), turboPreviewPreRender)
    end
  else
    turboPreviewProgress = 2.5
  end
end
function turboPreviewPreRender(delta)
  turboPreviewProgress = turboPreviewProgress + 1 * delta / 1000
  if 2.5 < turboPreviewProgress or not isElement(turboPreviewVeh) then
    removeEventHandler("onClientPreRender", getRootElement(), turboPreviewPreRender)
    if isElement(turboPreviewSound) then
      destroyElement(turboPreviewSound)
    end
    if isElement(turboPreviewVeh) then
      local s = playSound3D("files/boff" .. turboPreviewBlowoffSound .. ".wav", 0, 0, 0)
      setElementDimension(s, getElementDimension(turboPreviewVeh))
      setElementInterior(s, getElementInterior(turboPreviewVeh))
      setSoundMaxDistance(s, 20 + 20 * turboPreivewVol)
      setSoundVolume(s, turboPreivewVol * 0.6 * 1.15 * turboPreviewBoffVol)
      local x, y, z = getVehicleDummyPosition(turboPreviewVeh, "engine")
      attachElements(s, turboPreviewVeh, x, y, z)
    end
    turboPreviewBlowoffSound = false
    turboPreivewVol = 0
    turboPreviewSoundVol = 1
    turboPreviewBoffVol = 1
    turboPreviewSoundId = false
    turboPreviewSound = false
    turboPreviewProgress = false
    turboPreviewVeh = false
  elseif turboPreviewSoundId == 1 then
    local pitch = math.min(math.max(0.2, turboPreviewProgress * 1.7), 4) + 0.2
    local vol = getEasingValue(math.max(math.min(turboPreviewProgress * 3 - 0.5, 1), 0), "OutQuad") + math.max(0, 0.15 * (pitch - 0.8) / 3)
    setSoundVolume(turboPreviewSound, vol * 0.125 * 1.15 * turboPreviewSoundVol)
    setSoundMaxDistance(turboPreviewSound, 20 + 20 * vol)
    turboPreivewVol = vol
    setSoundSpeed(turboPreviewSound, pitch * 0.75)
  else
    local pitch = math.min(math.max(0.3, turboPreviewProgress * 1.15), 4) + 0.25
    local vol = getEasingValue(math.max(math.min(turboPreviewProgress * 2 - 0.5, 1), 0), "OutQuad") * 0.8 + math.max(0, 0.25 * (pitch - 1) / 3)
    setSoundVolume(turboPreviewSound, vol * 0.135 * 1.15 * turboPreviewSoundVol)
    setSoundMaxDistance(turboPreviewSound, 20 + 20 * vol)
    turboPreivewVol = vol
    setSoundSpeed(turboPreviewSound, pitch * 0.35)
  end
end
addEventHandler("onClientElementDimensionChange", getRootElement(), function(old, new)
  if superChargerSound[source] then
    setElementDimension(superChargerSound[source], new)
  end
  if turboSound[source] then
    setElementDimension(turboSound[source], new)
  end
  if superChargers[source] then
    for k = 1, 4 do
      if isElement(superChargers[source][k]) then
        setElementDimension(superChargers[source][k], new)
      end
    end
  end
end)
addEventHandler("onClientElementInteriorChange", getRootElement(), function(old, new)
  if superChargerSound[source] then
    setElementInterior(superChargerSound[source], new)
  end
  if turboSound[source] then
    setElementInterior(turboSound[source], new)
  end
  if superChargers[source] then
    for k = 1, 4 do
      if isElement(superChargers[source][k]) then
        setElementInterior(superChargers[source][k], new)
      end
    end
  end
end)
addEventHandler("onClientPreRender", getRootElement(), function(delta)
  for k, v in pairs(unfreezeVehicles) do
    unfreezeVehicles[k] = unfreezeVehicles[k] - delta
    if unfreezeVehicles[k] <= 0 then
      if not getElementData(k, "vehicle.handbrake") and not getElementData(k, "packerRampState") and not getElementData(k, "carRoped") and not getElementData(k, "ropedToPacker") then
        setElementFrozen(k, false)
      end
      unfreezeVehicles[k] = nil
    end
  end
  local tick = getTickCount()
  local cx, cy, cz = getCameraMatrix()
  local vehs = getElementsByType("vehicle", getRootElement(), true)
  for i = 1, #vehs do
    local veh = vehs[i]
    local controller = getVehicleController(veh)
    local gear = getVehicleCurrentGear(veh)
    local speed = 0
    local engine = getVehicleEngineState(veh)
    local hp = getElementHealth(veh)
    if (turboSound[veh] or superChargers[veh]) and engine then
      speed = getVehicleSpeed(veh)
      local acceleration = math.max(-0.5, (speed - (lastSpeed[veh] or 0)) * (delta / 1000) * 100)
      lastSpeed[veh] = speed
      if gear ~= tmpg[veh] then
        if gear > (tmpg[veh] or 0) then
          if 1 < gear then
            speed = speed - 20
          end
          if not gearSpeeds[veh] then
            gearSpeeds[veh] = {}
          end
          gearSpeeds[veh][gear] = speed
          if turboSound[veh] then
            local sound = playSound3D("files/boff" .. turboBlowoff[veh] .. ".wav", 0, 0, 0)
            setElementDimension(sound, getElementDimension(veh))
            setElementInterior(sound, getElementInterior(veh))
            local x, y, z = getVehicleDummyPosition(veh, "engine")
            attachElements(sound, veh, x, y, z)
            setSoundVolume(sound, vol[veh] * 0.6 * 1.2 * turboBlowoffVolume[veh])
            setSoundMaxDistance(sound, 20 + 20 * vol[veh])
          end
          if discharge[veh] then
            discharge[veh] = 5.5
          end
        end
        tmpg[veh] = gear
      end
      speed = math.min(2, math.max(0, (speed - (gearSpeeds[veh][gear] or 0)) / 30) - 0.35) * 1.05 + acceleration * 0.8
      speed = math.min(speed, 3)
      if discharge[veh] and 0.85 < discharge[veh] then
        discharge[veh] = discharge[veh] - 1.8 * delta / 1000
      end
    end
    if turboSpeed[veh] then
      if speed < turboSpeed[veh] then
        turboSpeed[veh] = turboSpeed[veh] - discharge[veh] * delta / 1000
        if speed > turboSpeed[veh] then
          turboSpeed[veh] = speed
        end
      elseif speed > turboSpeed[veh] then
        turboSpeed[veh] = turboSpeed[veh] + 0.75 * delta / 1000
        if speed < turboSpeed[veh] then
          turboSpeed[veh] = speed
        end
      end
      if engine then
        if turboSound[veh] then
          local pitch = math.min(math.max(0.3, turboSpeed[veh] * 1.15), 4) + 0.25
          vol[veh] = getEasingValue(math.max(math.min(turboSpeed[veh] * 2 - 0.5, 1), 0), "OutQuad") * 0.8 + math.max(0, 0.25 * (pitch - 1) / 3)
          setSoundVolume(turboSound[veh], vol[veh] * 0.135 * 1.2 * turboSoundVolume[veh])
          setSoundSpeed(turboSound[veh], pitch * 0.35)
          setSoundMaxDistance(turboSound[veh], 20 + 20 * vol[veh])
        else
          createTurboSound(veh)
        end
      elseif turboSound[veh] then
        if isElement(turboSound[veh]) then
          destroyElement(turboSound[veh])
        end
        turboSound[veh] = nil
      end
    end
    if lastGear[veh] ~= gear then
      if hp < 725 and lastGear[veh] then
        local x, y, z = getVehicleDummyPosition(veh, "engine")
        local sound = playSound3D("files/kerreges.mp3", x, y, z)
        setElementDimension(sound, getElementDimension(veh))
        setElementInterior(sound, getElementInterior(veh))
        attachElements(sound, veh, x, y, z)
      end
      if lastGear[veh] and gear > lastGear[veh] and oldTurboSound[veh] then
        local x, y, z = getVehicleDummyPosition(veh, "engine")
        local sound = playSound3D("files/old_turbo.mp3", x, y, z)
        setElementDimension(sound, getElementDimension(veh))
        setElementInterior(sound, getElementInterior(veh))
        attachElements(sound, veh, x, y, z)
      end
      lastGear[veh] = gear
      lastShift[veh] = tick
    end
    local vehType = getVehicleType(veh)
    if veh and engine and not fumeDisable[veh] and (vehType == "Automobile" or vehType == "Bike" or vehType == "Quad" or vehType == "Quad") then
      speed = 45 + 90 * (1 - hp / 1000)
      local sp = getVehicleSpeed(veh)
      if speed >= sp or tick - (lastShift[veh] or 0) < 1500 then
        local vx, vy, vz = getElementPosition(veh)
        if 80 >= getDistanceBetweenPoints3D(cx, cy, cz, vx, vy, vz) then

          lastFume[veh] = (lastFume[veh] or 0) + delta
          if not fuelType[veh] then
            fuelType[veh] = getFuelType(veh)
            refreshFuelTypeSound(veh)
          end
          local num = 90 - 40 * (1 - hp / 1000)
          num = num * (0.5 + 0.5 * math.max(0, 1 - sp / speed))
          local size = 0.7 + 0.4 * (1 - hp / 1000)
          local color = fuelType[veh] == "petrol" and 170 or 30
          local a = fuelType[veh] == "petrol" and 0.4 or 0.8
          local customModel = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
          if electricVehicles[customModel] then
            fuelType[veh] = "electric"
          end
          if fuelType[veh] == "electric" then
            a = 0
          end
          if hp < 700 then
            color = color * (1 - 0.3 * hp / 700)
            a = a * (0.6 + 0.4 * (1 - hp / 700))
          else
            a = a * 0.6
          end
          if controller then
            local acc = playerAccelerate[controller] and 1 or 0
            if controller ~= localPlayer and speed <= sp then
              acc = 1
            end
            num = num - num * 0.1 * acc
            size = size + 0.45 * acc
            color = color - 10 * acc
          end
          if num < lastFume[veh] then
            lastFume[veh] = 0
            local fx, fy, fz = getVehicleModelExhaustFumesPosition(getElementModel(veh))
            local rx, ry, rz = getElementRotation(veh)
            local velx, vely, velz = getElementVelocity(veh)
            velx = velx * 0.75
            vely = vely * 0.75
            velz = velz * 0.75

            if bitAnd(getVehicleHandling(veh).modelFlags, 8192) == 8192 then
              spawnFume(vx, vy, vz, -fx, fy, fz, rx, ry, rz, size, color, a, velx, vely, velz)
            end
            spawnFume(vx, vy, vz, fx, fy, fz, rx, ry, rz, size, color, a, velx, vely, velz)
          end
        end
      end
    end
  end
  if 0 < #particles or 0 < #crashParticles then
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
        local progress = (tick - data[7]) / 50
        if 1 < progress then
          progress = 1
        end
        if tick - data[7] > data[8] then
          progress = 1 - (tick - (data[7] + data[8])) / 600
          if progress < 0 then
            progress = 0
            table.remove(particles, k)
          end
        end
        data[13] = data[13] + data[14] * delta / 1000
        sightlangStaticImageUsed[11] = true
        if sightlangStaticImageToc[11] then
          processsightlangStaticImage[11]()
        end
        dxDrawMaterialLine3D(data[1] + x * data[13], data[2] + y * data[13], data[3] + z * data[13], data[1] - x * data[13], data[2] - y * data[13], data[3] - z * data[13], sightlangStaticImage[11], data[13], tocolor(data[9], data[10], data[11], data[12] * progress))
      end
    end
    local keep = 0
    if #crashParticles < 0 then
      groundCache = {}
    end
    for i = #crashParticles, 1, -1 do
      local size = crashParticles[i][9]
      local rx, ry = crashParticles[i][4] * size / 2, crashParticles[i][5] * size / 2
      local a = crashParticles[i][15]
      if not crashParticles[i][10] then
        if crashParticles[i][8] > -10 then
          crashParticles[i][8] = crashParticles[i][8] - 20 * delta / 1000
        end
        if crashParticles[i][16] then
          keep = keep + 1
        end
        if 500 < keep then
          crashParticles[i][16] = false
        end
        local mx, my, mz = crashParticles[i][6], crashParticles[i][7], crashParticles[i][8]
        if 0 > crashParticles[i][8] then
          local gx, gy = math.floor(crashParticles[i][1] + 0.5), math.floor(crashParticles[i][2] + 0.5)
          if not groundCache[gx] then
            groundCache[gx] = {}
          end
          if not groundCache[gx][gy] then
            groundCache[gx][gy] = math.max(-1, getGroundPosition(gx, gy, crashParticles[i][3] + 1) + 0.025)
          end
          local gz = groundCache[gx][gy]
          if gz == 0 then
            groundCache[gx][gy] = false
          end
          if gz < crashParticles[i][3] then
            crashParticles[i][1] = crashParticles[i][1] + mx * delta / 1000
            crashParticles[i][2] = crashParticles[i][2] + my * delta / 1000
            crashParticles[i][3] = crashParticles[i][3] + mz * delta / 1000
          elseif crashParticles[i][16] then
            crashParticles[i][3] = gz
            crashParticles[i][10] = tick + math.random(-2000, 2000)
          else
            table.remove(crashParticles, i)
            a = 0
          end
        else
          crashParticles[i][1] = crashParticles[i][1] + mx * delta / 1000
          crashParticles[i][2] = crashParticles[i][2] + my * delta / 1000
          crashParticles[i][3] = crashParticles[i][3] + mz * delta / 1000
        end
      else
        local p = (tick - crashParticles[i][10]) / 60000
        if 1 < p then
          p = (p - 1) / 0.1
          if 1 < p then
            table.remove(crashParticles, i)
            a = 0
          else
            a = a * (1 - p)
          end
        end
      end
      if 0 < a then
        local x, y, z = crashParticles[i][1], crashParticles[i][2], crashParticles[i][3]
        if crashParticles[i][10] then
          dxDrawMaterialLine3D(x + rx, y + ry, z, x - rx, y - ry, z, dynamicImage(crashTexture[crashParticles[i][11]]), size, tocolor(crashParticles[i][12], crashParticles[i][13], crashParticles[i][14], a), x, y, z + 1)
        else
          dxDrawMaterialLine3D(x, y, z - size / 2, x, y, z + size / 2, dynamicImage(crashTexture[crashParticles[i][11]]), size, tocolor(crashParticles[i][12], crashParticles[i][13], crashParticles[i][14], a))
        end
      end
    end
  end
end)
function maxex(a, b)
  if math.abs(a) > math.abs(b) then
    return a
  else
    return b
  end
end
local lastVehiclePush = {}

local amount = 110

addEventHandler("onClientVehicleCollision", getRootElement(), function(collider, damageImpulseMag, bodyPart, x, y, z, nx, ny, nz)
  if isElementStreamedIn(source) and not isElementFrozen(source) then
    if amount < damageImpulseMag then
      local sound = false
      if speedoVehicle == source then
        sound = playSound("files/crash" .. math.random(1, 9) .. ".mp3")
      else
        sound = playSound3D("files/crash" .. math.random(1, 9) .. ".mp3", x, y, z)
        setElementDimension(sound, getElementDimension(source))
        setElementInterior(sound, getElementInterior(source))
        setSoundMaxDistance(sound, math.min(120, 30 + 90 * ((damageImpulseMag - 110) / 1000)))
      end
      setSoundVolume(sound, 2.25)
      local t, r, g, b, a = 1, 0, 0, 0, 255
      local s = 1
      for i = 1, math.max(20, math.ceil(damageImpulseMag * 0.2)) * 3 do
        local rand = math.random(10000) / 100
        if 90 < rand then
          r, g, b = getVehicleColor(source, true)
          t = math.random(1, 4)
          a = 255
          s = 0.75
        elseif 65 < rand then
          r, g, b = 230, 240, 255
          a = 175
          t = math.random(5, 9)
        elseif 25 < rand then
          r = math.random(0, 40)
          g = r
          b = r
          s = 0.85
          t = math.random(1, 4)
          a = 255
        else
          s = 0.5
          r = math.random(0, 200)
          g = r
          b = r
          a = 255
          t = math.random(10, 14)
        end
        spawnCrashParticle(i % 3 == 0, x, y, z - 0.1, 0.3 + (damageImpulseMag - 90) / 275, t, r, g, b, a, s * 0.8 * math.min(0.45, math.random(400, 1400) / 1000 * damageImpulseMag / 100 * 0.35))
      end
      if 100 < #crashParticles then
        for i = 100, #crashParticles do
          table.remove(crashParticles, 1)
        end
      end
    end
    if 75 < damageImpulseMag and getVehicleController(source) == localPlayer then
      if 200 < damageImpulseMag then
      end
      if getVehicleType(source) == "Automobile" then
        local frontLeft = {
          getVehicleComponentPosition(source, "wheel_lf_dummy", "world")
        }
        local frontRight = {
          getVehicleComponentPosition(source, "wheel_rf_dummy", "world")
        }
        local rearLeft = {
          getVehicleComponentPosition(source, "wheel_lb_dummy", "world")
        }
        local rearRight = {
          getVehicleComponentPosition(source, "wheel_rb_dummy", "world")
        }
        frontLeft = getDistanceBetweenPoints2D(frontLeft[1], frontLeft[2], x, y)
        frontRight = getDistanceBetweenPoints2D(frontRight[1], frontRight[2], x, y)
        rearLeft = getDistanceBetweenPoints2D(rearLeft[1], rearLeft[2], x, y)
        rearRight = getDistanceBetweenPoints2D(rearRight[1], rearRight[2], x, y)
        local distSum = frontLeft + frontRight + rearLeft + rearRight
        frontLeft = 1 - frontLeft / distSum
        frontRight = 1 - frontRight / distSum
        rearLeft = 1 - rearLeft / distSum
        rearRight = 1 - rearRight / distSum
        local fl, rl, fr, rr = getVehicleWheelStates(source)
        if 1 <= fl then
          frontLeft = -1
        end
        if 1 <= rl then
          rearLeft = -1
        end
        if 1 <= fr then
          frontRight = -1
        end
        if 1 <= rr then
          rearRight = -1
        end
        local max = math.max(frontLeft, frontRight, rearLeft, rearRight)
        if max == frontLeft then
          triggerServerEvent("damageVehicleSuspension", localPlayer, source, 1, damageImpulseMag)
        elseif max == frontRight then
          triggerServerEvent("damageVehicleSuspension", localPlayer, source, 2, damageImpulseMag)
        elseif max == rearLeft then
          triggerServerEvent("damageVehicleSuspension", localPlayer, source, 3, damageImpulseMag)
        elseif max == rearRight then
          triggerServerEvent("damageVehicleSuspension", localPlayer, source, 4, damageImpulseMag)
        end
      elseif getVehicleType(source) == "Quad" then
        if 90 <= damageImpulseMag then
          local frontLeft = {
            getVehicleComponentPosition(source, "wheel_lf_dummy", "world")
          }
          local frontRight = {
            getVehicleComponentPosition(source, "wheel_rf_dummy", "world")
          }
          local rearLeft = {
            getVehicleComponentPosition(source, "wheel_lb_dummy", "world")
          }
          local rearRight = {
            getVehicleComponentPosition(source, "wheel_rb_dummy", "world")
          }
          local frontPos = {
            (frontLeft[1] + frontRight[1]) / 2,
            (frontLeft[2] + frontRight[2]) / 2
          }
          local rearPos = {
            (rearLeft[1] + rearRight[1]) / 2,
            (rearLeft[2] + rearRight[2]) / 2
          }
          local fl, rl, fr, rr = getVehicleWheelStates(source)
          local front = 999
          if fl == 0 or fr == 0 then
            front = getDistanceBetweenPoints2D(frontPos[1], frontPos[2], x, y)
          end
          local rear = 999
          if rl == 0 or rr == 0 then
            rear = getDistanceBetweenPoints2D(rearPos[1], rearPos[2], x, y)
          end
          if front < rear then
            triggerServerEvent("damageBikeWheels", localPlayer, source, 1)
          else
            triggerServerEvent("damageBikeWheels", localPlayer, source, 2)
          end
        end
      elseif getVehicleType(source) == "Bike" and 90 <= damageImpulseMag then
        local frontPos = {
          getVehicleComponentPosition(source, "wheel_front", "world")
        }
        local rearPos = {
          getVehicleComponentPosition(source, "wheel_rear", "world")
        }
        local fl, rl, fr, rr = getVehicleWheelStates(source)
        local front = 999
        if fl == 0 or fr == 0 then
          front = getDistanceBetweenPoints2D(frontPos[1], frontPos[2], x, y)
        end
        local rear = 999
        if rl == 0 or rr == 0 then
          rear = getDistanceBetweenPoints2D(rearPos[1], rearPos[2], x, y)
        end
        if front < rear then
          triggerServerEvent("damageBikeWheels", localPlayer, source, 1)
        else
          triggerServerEvent("damageBikeWheels", localPlayer, source, 2)
        end
      end
    end
    if collider and not lowStamina[collider] and isElement(collider) and getElementType(collider) == "player" and getVehicleType(source) == "Automobile" and isElementStreamable(collider) then
      local driver = getVehicleController(source)
      if 2 > getVehicleSpeed(source) then
        if driver and not getVehicleEngineState(source) and isVehicleWheelOnGround(source, "front_left") and isVehicleWheelOnGround(source, "rear_left") then
          local vx, vy, vz = getElementPosition(source)
          local rx, ry, rz = getElementRotation(source)
          local a = math.deg(math.atan2(vy - y, vx - x) + math.pi) - rz
          a = (a + 180) % 360 - 180
          if 10 >= math.abs(math.abs(a) - 90) then
            lastVehiclePush[collider] = getTickCount()
            local m = getElementMatrix(source)
            local f = 0.0125
            if 0 < a then
              f = -f
            end
            local vx, vy, vz = getElementVelocity(source)
            setElementVelocity(source, maxex(vx, m[2][1] * f), maxex(vy, m[2][2] * f), maxex(vz, m[2][3] * f))
          end
        elseif not driver then
          setElementFrozen(source, true)
          unfreezeVehicles[source] = 150
        end
      end
    end
  end
end)
local selfPush = false
addEventHandler("onClientPedsProcessed", getRootElement(), function()
  local tmp = false
  local now = getTickCount()
  for player, time in pairs(lastVehiclePush) do
    if 425 < now - time then
      lastVehiclePush[player] = nil
    else
      if player == localPlayer then
        tmp = true
      end
      setElementBoneRotation(player, 2, 0, 20, 0)
      setElementBoneRotation(player, 3, 0, 15, 0)
      setElementBoneRotation(player, 22, 13.043463333793, -49.565267148225, -20.869540338931)
      setElementBoneRotation(player, 23, -33.912973818572, -57.391204833984, 5.4732612909447E-5)
      setElementBoneRotation(player, 32, -13.043463333793, -49.565267148225, 20.869540338931)
      setElementBoneRotation(player, 33, -33.912973818572, -57.391204833984, 5.4732612909447E-5)
      sightexports.sCore:updateElementRpHAnim(player)
    end
  end
  if tmp ~= selfPush then
    selfPush = tmp
    sightexports.sHud:refreshVehiclePush(tmp)
    sightexports.sControls:toggleControl({
      "jog",
      "aim_weapon",
      "crouch",
      "fire"
    }, not tmp)
  end
end)
local localJumperHandled = false
local jumpstartPairs = {}
local jumpstartOnVehicles = {}
local clipHandled = false
local clipHover = false
local clippedTo = false
function deleteJumpstartPair(veh)
  for i = #jumpstartPairs, 1, -1 do
    if jumpstartPairs[i] and (jumpstartPairs[i][1] == veh or jumpstartPairs[i][2] == veh) then
      for j = 4, 7 do
        if isElement(jumpstartPairs[i][j]) then
          destroyElement(jumpstartPairs[i][j])
        end
      end
      if isElement(jumpstartPairs[i][1]) then
        local ex, ey, ez = getVehicleDummyPosition(jumpstartPairs[i][1], "engine")
        if not ex then
          ex, ey, ez = 0, 0, 0
        end
        local x, y, z = getPositionFromElementOffset(jumpstartPairs[i][1], ex, ey * 1.1, ez + 0.1)
        local sound = playSound3D("files/batt" .. math.random(1, 5) .. ".mp3", x, y, z)
        setElementDimension(sound, getElementDimension(jumpstartPairs[i][1]))
        setElementInterior(sound, getElementInterior(jumpstartPairs[i][1]))
        fxAddSparks(x, y, z, 0, 0, 1)
      end
      if isElement(jumpstartPairs[i][2]) then
        local ex, ey, ez = getVehicleDummyPosition(jumpstartPairs[i][2], "engine")
        if not ex then
          ex, ey, ez = 0, 0, 0
        end
        local x, y, z = getPositionFromElementOffset(jumpstartPairs[i][2], ex, ey * 1.1, ez + 0.1)
        local sound = playSound3D("files/batt" .. math.random(1, 5) .. ".mp3", x, y, z)
        setElementDimension(sound, getElementDimension(jumpstartPairs[i][2]))
        setElementInterior(sound, getElementInterior(jumpstartPairs[i][2]))
        fxAddSparks(x, y, z, 0, 0, 1)
      end
      jumpstartOnVehicles[jumpstartPairs[i][1]] = nil
      jumpstartOnVehicles[jumpstartPairs[i][2]] = nil
      if jumpstartPairs[i][3] == localPlayer and localJumperHandled then
        removeEventHandler("onClientRender", getRootElement(), renderLocalJumper)
        removeEventHandler("onClientClick", getRootElement(), clickLocalJumper)
        localJumperHandled = false
        sightexports.sGui:setCursorType("normal")
      end
      table.remove(jumpstartPairs, i)
    end
  end
end
addEvent("deleteJumpstartPair", true)
addEventHandler("deleteJumpstartPair", getRootElement(), deleteJumpstartPair)
function addJumpstartPair(data)
  deleteJumpstartPair(data[1])
  deleteJumpstartPair(data[2])
  if isElement(data[1]) and isElement(data[2]) then
    local ex, ey, ez = getVehicleDummyPosition(data[2], "engine")
    if not ex then
      ex, ey, ez = 0, 0, 0
    end
    local x, y, z = getPositionFromElementOffset(data[2], ex, ey * 1.1, ez + 0.1)
    local sound = playSound3D("files/batt" .. math.random(1, 5) .. ".mp3", x, y, z)
    setElementDimension(sound, getElementDimension(data[2]))
    setElementInterior(sound, getElementInterior(data[2]))
    local sound = playSound3D("files/battin" .. math.random(1, 2) .. ".mp3", x, y, z)
    setElementDimension(sound, getElementDimension(data[2]))
    setElementInterior(sound, getElementInterior(data[2]))
    fxAddSparks(x, y, z, 0, 0, 1)
    jumpstartOnVehicles[data[1]] = true
    jumpstartOnVehicles[data[2]] = true
    if data[3] == localPlayer and not localJumperHandled then
      addEventHandler("onClientRender", getRootElement(), renderLocalJumper)
      addEventHandler("onClientClick", getRootElement(), clickLocalJumper)
      localJumperHandled = true
      clipBg = sightexports.sGui:getColorCodeToColor("sightgrey1")
      clipColor = sightexports.sGui:getColorCodeToColor("sightgreen")
      clipColor2 = sightexports.sGui:getColorCodeToColor("sightred")
    end
    local int = getElementInterior(data[1])
    local dim = getElementDimension(data[1])
    data[4] = createObject(sightexports.sModloader:getModelId("bika"), 0, 0, 0)
    setElementInterior(data[4], int)
    setElementDimension(data[4], dim)
    setElementCollisionsEnabled(data[4], false)
    data[5] = createObject(sightexports.sModloader:getModelId("bika_red"), 0, 0, 0)
    setElementInterior(data[5], int)
    setElementDimension(data[5], dim)
    setElementCollisionsEnabled(data[5], false)
    setElementDoubleSided(data[5], true)
    data[6] = createObject(sightexports.sModloader:getModelId("bika_black"), 0, 0, 0)
    setElementInterior(data[6], int)
    setElementDimension(data[6], dim)
    setElementCollisionsEnabled(data[6], false)
    setElementDoubleSided(data[6], true)
    data[7] = createObject(sightexports.sModloader:getModelId("bika"), 0, 0, 0)
    setElementInterior(data[7], int)
    setElementDimension(data[7], dim)
    setElementCollisionsEnabled(data[7], false)
    setElementDoubleSided(data[7], true)
    setObjectScale(data[7], -1, 1, 1)
    table.insert(jumpstartPairs, data)
  end
end
addEvent("addJumpstartPair", true)
addEventHandler("addJumpstartPair", getRootElement(), addJumpstartPair)
addEvent("gotJumpstartPairs", true)
addEventHandler("gotJumpstartPairs", getRootElement(), function(data)
  for i = 1, #data do
    addJumpstartPair(data[i])
  end
end)
triggerServerEvent("requestJumpstartPairList", localPlayer)
local playerJumperObjects = {}
local playerJumperVehicle = {}
function processPlayerJumper(client, data)
  if data == nil then
    data = getElementData(client, "jumperInHand")
  end
  local was = playerJumperVehicle[client]
  playerJumperVehicle[client] = nil
  if data and (isElementStreamedIn(client) or client == localPlayer) then
    if not playerJumperObjects[client] then
      playerJumperObjects[client] = {}
    end
    local veh = false
    local inHand = false
    if data == "charger" then
      inHand = true
      playerJumperVehicle[client] = "charger"
      if client == localPlayer then
        if not clipHandled then
          clipBg = sightexports.sGui:getColorCodeToColor("sightgrey1")
          clipColor = sightexports.sGui:getColorCodeToColor("sightgreen")
          clipColor2 = sightexports.sGui:getColorCodeToColor("sightred")
          addEventHandler("onClientRender", getRootElement(), renderClipping)
          addEventHandler("onClientClick", getRootElement(), clippingClick)
        end
        clippedTo = false
        clipHandled = "charger"
      end
    elseif isElement(data) then
      inHand = true
      veh = data
      playerJumperVehicle[client] = veh
      local ex, ey, ez = getVehicleDummyPosition(veh, "engine")
      if not ex then
        ex, ey, ez = 0, 0, 0
      end
      local x, y, z = getPositionFromElementOffset(veh, ex, ey * 1.1, ez + 0.1)
      local sound = playSound3D("files/batt" .. math.random(1, 5) .. ".mp3", x, y, z)
      setElementDimension(sound, getElementDimension(veh))
      setElementInterior(sound, getElementInterior(veh))
      local sound = playSound3D("files/battin" .. math.random(1, 2) .. ".mp3", x, y, z)
      setElementDimension(sound, getElementDimension(veh))
      setElementInterior(sound, getElementInterior(veh))
      fxAddSparks(x, y, z, 0, 0, 1)
    end
    local int = getElementInterior(client)
    local dim = getElementDimension(client)
    if not isElement(playerJumperObjects[client][1]) then
      playerJumperObjects[client][1] = createObject(sightexports.sModloader:getModelId(inHand and "bika2" or "bika_rolled"), 0, 0, 0)
      setElementCollisionsEnabled(playerJumperObjects[client][1], false)
      sightexports.sPattach:attach(playerJumperObjects[client][1], client, "right-hand", -0.225, 0, 0, 0, -90, 0)
    else
      setElementModel(playerJumperObjects[client][1], sightexports.sModloader:getModelId(inHand and "bika2" or "bika_rolled"))
    end
    if inHand then
      if not isElement(playerJumperObjects[client][2]) then
        playerJumperObjects[client][2] = createObject(sightexports.sModloader:getModelId("bika_red"), 0, 0, 0)
        setElementInterior(playerJumperObjects[client][2], int)
        setElementDimension(playerJumperObjects[client][2], dim)
        setElementCollisionsEnabled(playerJumperObjects[client][2], false)
        setElementDoubleSided(playerJumperObjects[client][2], true)
      end
      if not isElement(playerJumperObjects[client][3]) then
        playerJumperObjects[client][3] = createObject(sightexports.sModloader:getModelId("bika_black"), 0, 0, 0)
        setElementInterior(playerJumperObjects[client][3], int)
        setElementDimension(playerJumperObjects[client][3], dim)
        setElementCollisionsEnabled(playerJumperObjects[client][3], false)
        setElementDoubleSided(playerJumperObjects[client][3], true)
      end
      if isElement(playerJumperObjects[client][4]) then
        setElementModel(playerJumperObjects[client][4], sightexports.sModloader:getModelId(veh and "bika" or "bika_garage"))
      else
        playerJumperObjects[client][4] = createObject(sightexports.sModloader:getModelId(veh and "bika" or "bika_garage"), 0, 0, 0)
        setElementInterior(playerJumperObjects[client][4], int)
        setElementDimension(playerJumperObjects[client][4], dim)
        setElementCollisionsEnabled(playerJumperObjects[client][4], false)
      end
    else
      for i = 2, #playerJumperObjects[client] do
        if isElement(playerJumperObjects[client][i]) then
          destroyElement(playerJumperObjects[client][i])
        end
        playerJumperObjects[client][i] = nil
      end
    end
  else
    if client == localPlayer and clipHandled then
      clipHandled = false
      removeEventHandler("onClientRender", getRootElement(), renderClipping)
      removeEventHandler("onClientClick", getRootElement(), clippingClick)
      sightexports.sGui:setCursorType("normal")
    end
    if playerJumperObjects[client] then
      for i = 1, #playerJumperObjects[client] do
        if isElement(playerJumperObjects[client][i]) then
          destroyElement(playerJumperObjects[client][i])
        end
      end
    end
    playerJumperObjects[client] = nil
    if isElement(was) then
      local ex, ey, ez = getVehicleDummyPosition(was, "engine")
      if not ex then
        ex, ey, ez = 0, 0, 0
      end
      local x, y, z = getPositionFromElementOffset(was, ex, ey * 1.1, ez + 0.1)
      local sound = playSound3D("files/batt" .. math.random(1, 5) .. ".mp3", x, y, z)
      setElementDimension(sound, getElementDimension(was))
      setElementInterior(sound, getElementInterior(was))
      fxAddSparks(x, y, z, 0, 0, 1)
    end
  end
end
local noBonnetCars = {
  [411] = true,
  [415] = true,
  [451] = true,
  [474] = true,
  [480] = true,
  [494] = true,
  [506] = true,
  [533] = true
}
function checkNoBonnetCar(veh)
  if not getVehicleComponentPosition(veh, "bonnet_dummy") then
    return true
  elseif getVehicleDoorState(veh, 0) == 4 then
    return true
  elseif noBonnetCars[getElementModel(veh)] then
    return true
  end
end
function isBike(veh)
  return getVehicleType(veh) == "Bike" or getVehicleType(veh) == "BMX"
end
function renderClipping()
  local tmp = false
  if not isPedInVehicle(localPlayer) then
    local cx, cy = getCursorPosition()
    if cx then
      cx = cx * screenX
      cy = cy * screenY
    end
    local vehs = getElementsByType("vehicle", getRootElement(), true)
    local px, py, pz = getElementPosition(localPlayer)
    for i = 1, #vehs do
      if (getVehicleDoorOpenRatio(vehs[i], 0) > 0.5 or checkNoBonnetCar(vehs[i])) and not jumpstartOnVehicles[vehs[i]] and not isBike(vehs[i]) then
        local ex, ey, ez = getVehicleDummyPosition(vehs[i], "engine")
        if not ex then
          ex, ey, ez = 0, 0, 0
        end
        local x, y, z = getPositionFromElementOffset(vehs[i], ex, ey * 1.1, ez + 0.1)
        if getDistanceBetweenPoints3D(x, y, z, px, py, pz) <= 2 then
          local x, y = getScreenFromWorldPosition(x, y, z, 48)
          if x then
            dxDrawRectangle(x - 24, y - 24, 48, 48, clipBg)
            if cx and cx >= x - 24 and cy >= y - 24 and cx <= x + 24 and cy <= y + 24 then
              if clippedTo == vehs[i] then
                sightlangStaticImageUsed[12] = true
                if sightlangStaticImageToc[12] then
                  processsightlangStaticImage[12]()
                end
                dxDrawImage(x - 24 + 5, y - 24 + 5, 38, 38, sightlangStaticImage[12], 0, 0, 0, clipColor2)
              else
                sightlangStaticImageUsed[13] = true
                if sightlangStaticImageToc[13] then
                  processsightlangStaticImage[13]()
                end
                dxDrawImage(x - 24 + 5, y - 24 + 5, 38, 38, sightlangStaticImage[13], 0, 0, 0, clipColor)
              end
              tmp = vehs[i]
            elseif clippedTo == vehs[i] then
              sightlangStaticImageUsed[12] = true
              if sightlangStaticImageToc[12] then
                processsightlangStaticImage[12]()
              end
              dxDrawImage(x - 24 + 5, y - 24 + 5, 38, 38, sightlangStaticImage[12])
            else
              sightlangStaticImageUsed[13] = true
              if sightlangStaticImageToc[13] then
                processsightlangStaticImage[13]()
              end
              dxDrawImage(x - 24 + 5, y - 24 + 5, 38, 38, sightlangStaticImage[13])
            end
          end
        end
      end
    end
  end
  if tmp ~= clipHover then
    clipHover = tmp
    sightexports.sGui:setCursorType(clipHover and "link" or "normal")
  end
end
function clippingClick(button, state)
  if state == "down" and clipHover then
    if clipHandled == "charger" then
      triggerServerEvent("tryToPutOnCharger", localPlayer, clipHover)
    elseif clippedTo then
      if clipHover == clippedTo then
        clippedTo = false
        setElementData(localPlayer, "jumperInHand", true)
      else
        local ex, ey, ez = getVehicleDummyPosition(clippedTo, "engine")
        if not ex then
          ex, ey, ez = 0, 0, 0
        end
        local x, y, z = getPositionFromElementOffset(clippedTo, ex, ey * 1.1, ez + 0.1)
        local ex, ey, ez = getVehicleDummyPosition(clipHover, "engine")
        if not ex then
          ex, ey, ez = 0, 0, 0
        end
        local x2, y2, z2 = getPositionFromElementOffset(clipHover, ex, ey * 1.1, ez + 0.1)
        local d = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
        if 3 < d then
          sightexports.sGui:showInfobox("e", "Túl messze van a másik autó.")
        else
          triggerServerEvent("addJumpstarter", localPlayer, clippedTo, clipHover)
          clippedTo = false
          removeEventHandler("onClientRender", getRootElement(), renderClipping)
          removeEventHandler("onClientClick", getRootElement(), clippingClick)
          clipHandled = false
          setElementData(localPlayer, "jumperInHand", false)
        end
      end
    else
      clippedTo = clipHover
      setElementData(localPlayer, "jumperInHand", clippedTo)
    end
  end
end
function stopClipping()
  if clipHandled then
    clipHandled = false
    removeEventHandler("onClientRender", getRootElement(), renderClipping)
    removeEventHandler("onClientClick", getRootElement(), clippingClick)
    setElementData(localPlayer, "jumperInHand", false)
    sightexports.sGui:setCursorType("normal")
  end
end
function startClipping()
  if not clipHandled then
    if localJumperHandled then
      sightexports.sGui:showInfobox("e", "Már van csatlakoztatva egy bikakábeled.")
    else
      clipBg = sightexports.sGui:getColorCodeToColor("sightgrey1")
      clipColor = sightexports.sGui:getColorCodeToColor("sightgreen")
      clipColor2 = sightexports.sGui:getColorCodeToColor("sightred")
      clipHandled = true
      clippedTo = false
      addEventHandler("onClientRender", getRootElement(), renderClipping)
      addEventHandler("onClientClick", getRootElement(), clippingClick)
      setElementData(localPlayer, "jumperInHand", true)
    end
  end
end
local localX, localY, localZ = 0, 0, 0
local localHover = false
function renderLocalJumper()
  local tmp = false
  if not isPedInVehicle(localPlayer) then
    local px, py, pz = getElementPosition(localPlayer)
    local d = getDistanceBetweenPoints3D(px, py, pz, localX, localY, localZ)
    if d <= 2.5 then
      local cx, cy = getCursorPosition()
      if cx then
        cx = cx * screenX
        cy = cy * screenY
      end
      local x, y = getScreenFromWorldPosition(localX, localY, localZ, 48)
      if x then
        dxDrawRectangle(x - 24, y - 24, 48, 48, clipBg)
        if cx and cx >= x - 24 and cy >= y - 24 and cx <= x + 24 and cy <= y + 24 then
          sightlangStaticImageUsed[12] = true
          if sightlangStaticImageToc[12] then
            processsightlangStaticImage[12]()
          end
          dxDrawImage(x - 24 + 5, y - 24 + 5, 38, 38, sightlangStaticImage[12], 0, 0, 0, clipColor2)
          tmp = true
        else
          sightlangStaticImageUsed[12] = true
          if sightlangStaticImageToc[12] then
            processsightlangStaticImage[12]()
          end
          dxDrawImage(x - 24 + 5, y - 24 + 5, 38, 38, sightlangStaticImage[12])
        end
      end
    end
  end
  if tmp ~= localHover then
    localHover = tmp
    sightexports.sGui:setCursorType(localHover and "link" or "normal")
  end
end
function clickLocalJumper(button, state)
  if state == "down" and localHover then
    triggerServerEvent("removeJumpstarter", localPlayer)
  end
end
addEventHandler("onClientPreRender", getRootElement(), function()
  for client, veh in pairs(playerJumperVehicle) do
    local redX, redY, redZ, blackX, blackY, blackZ, rgz, bgz, x, y, z
    if veh == "charger" and playerJumperObjects[client][2] then
      local baseX, baseY, baseZ = 607.572, -27.8817, 1001.10863
      setElementPosition(playerJumperObjects[client][4], baseX, baseY, baseZ)
      redX, redY, redZ = baseX + 0.0985, baseY - 0.0446, baseZ - 0.241907
      blackX, blackY, blackZ = baseX + 0.08221, baseY + 0.046257, baseZ - 0.244298
      x = (redX + blackX) / 2
      y = (redY + blackY) / 2
      z = (redZ + blackZ) / 2
      rgz = 1000.05
      bgz = 1000.05
    elseif isElement(veh) and playerJumperObjects[client][2] then
      local ex, ey, ez = getVehicleDummyPosition(veh, "engine")
      if not ex then
        ex, ey, ez = 0, 0, 0
      end
      local rx, ry, rz = getElementRotation(veh)
      if ey < 0 then
        rz = rz + 180
      end
      x, y, z = getPositionFromElementOffset(veh, ex, ey * 1.1, ez + 0.1)
      setElementPosition(playerJumperObjects[client][4], x, y, z)
      setElementRotation(playerJumperObjects[client][4], 0, 0, rz)
      rz = math.rad(rz)
      redX, redY, redZ = x - 0.050096 * math.cos(rz) - 0.704467 * math.sin(rz), y - 0.050096 * math.sin(rz) + 0.704467 * math.cos(rz), z - 0.297132
      rgz = 0
      if 1000 <= redZ then
        rgz = 1000.05
      else
        rgz = getGroundPosition(redX, redY, redZ) + 0.05
      end
      blackX, blackY, blackZ = x + 0.276453 * math.cos(rz) - 0.704467 * math.sin(rz), y + 0.276453 * math.sin(rz) + 0.704467 * math.cos(rz), z - 0.297132
      bgz = 0
      if 1000 <= blackZ then
        bgz = 1000.05
      else
        bgz = getGroundPosition(blackX, blackY, blackZ) + 0.05
      end
    end
    if redX and blackX then
      local m = getElementMatrix(playerJumperObjects[client][1])
      local redX2, redY2, redZ2 = getPositionFromMatrixOffset(m, 0.047486, 0.407279, 0.032275)
      local rgz2 = 0
      if 1000 <= redZ2 then
        rgz2 = 1000.05
      else
        rgz2 = getGroundPosition(redX2, redY2, redZ2) + 0.05
      end
      local blackX2, blackY2, blackZ2 = getPositionFromMatrixOffset(m, 0.086667, 0.407279, 0.033131)
      local bgz2 = 0
      if 1000 <= blackZ2 then
        bgz2 = 1000.05
      else
        bgz2 = getGroundPosition(blackX2, blackY2, blackZ2) + 0.05
      end
      setElementPosition(playerJumperObjects[client][2], redX, redY, redZ)
      setElementPosition(playerJumperObjects[client][3], blackX, blackY, blackZ)
      local dr = getDistanceBetweenPoints3D(redX, redY, redZ, redX2, redY2, redZ2)
      local db = getDistanceBetweenPoints3D(blackX, blackY, blackZ, blackX2, blackY2, blackZ2)
      setObjectScale(playerJumperObjects[client][2], 1, dr / 0.986118, math.min(redZ - rgz, redZ2 - rgz2))
      setObjectScale(playerJumperObjects[client][3], 1, db / 0.986118, math.min(blackZ - bgz, blackZ2 - bgz2))
      local rr = math.deg(math.atan2(redY2 - redY, redX2 - redX)) - 90
      local rb = math.deg(math.atan2(blackY2 - blackY, blackX2 - blackX)) - 90
      local rr2 = math.deg(math.asin((redZ2 - redZ) / dr))
      local rb2 = math.deg(math.asin((blackZ2 - blackZ) / db))
      setElementRotation(playerJumperObjects[client][2], rr2, 0, rr)
      setElementRotation(playerJumperObjects[client][3], rb2, 0, rb)
      if client == localPlayer then
        local x2, y2, z2 = getElementPosition(localPlayer)
        local d = getDistanceBetweenPoints2D(x, y, x2, y2)
        if 4 < d then
          setElementData(localPlayer, "jumperInHand", false)
          processPlayerJumper(localPlayer, false)
          triggerServerEvent("onPlayerJumperDrop", localPlayer)
          clipHandled = false
          removeEventHandler("onClientRender", getRootElement(), renderClipping)
          removeEventHandler("onClientClick", getRootElement(), clippingClick)
          setElementData(localPlayer, "jumperInHand", false)
          sightexports.sGui:setCursorType("normal")
        end
      end
    end
  end
  for i = 1, #jumpstartPairs do
    local veh1 = jumpstartPairs[i][1]
    local veh2 = jumpstartPairs[i][2]
    local obj = jumpstartPairs[i][4]
    local red = jumpstartPairs[i][5]
    local black = jumpstartPairs[i][6]
    local obj2 = jumpstartPairs[i][7]
    local isLocal = jumpstartPairs[i][3] == localPlayer
    if isLocal or isElement(veh1) and isElement(veh2) and isElementStreamedIn(veh1) and isElementStreamedIn(veh2) then
      setElementAlpha(obj, 255)
      setElementAlpha(red, 255)
      setElementAlpha(black, 255)
      setElementAlpha(obj2, 255)
      local ex, ey, ez = getVehicleDummyPosition(veh1, "engine")
      local rx, ry, rz = getElementRotation(veh1)
      if ey < 0 then
        rz = rz + 180
      end
      local x, y, z = getPositionFromElementOffset(veh1, ex, ey * 1.1, ez + 0.1)
      local ex, ey, ez = getVehicleDummyPosition(veh2, "engine")
      local rx2, ry2, rz2 = getElementRotation(veh2)
      if ey < 0 then
        rz2 = rz2 + 180
      end
      local x2, y2, z2 = getPositionFromElementOffset(veh2, ex, ey * 1.1, ez + 0.1)
      setElementPosition(obj, x, y, z)
      setElementPosition(obj2, x2, y2, z2)
      setElementRotation(obj, 0, 0, rz)
      setElementRotation(obj2, 0, 0, rz2)
      rz = math.rad(rz)
      rz2 = math.rad(rz2)
      local redX, redY, redZ = x - 0.050096 * math.cos(rz) - 0.704467 * math.sin(rz), y - 0.050096 * math.sin(rz) + 0.704467 * math.cos(rz), z - 0.297132
      local rgz = 0
      if 1000 <= redZ then
        rgz = 1000.05
      else
        rgz = getGroundPosition(redX, redY, redZ) + 0.05
      end
      local blackX, blackY, blackZ = x + 0.276453 * math.cos(rz) - 0.704467 * math.sin(rz), y + 0.276453 * math.sin(rz) + 0.704467 * math.cos(rz), z - 0.297132
      local bgz = 0
      if 1000 <= blackZ then
        bgz = 1000.05
      else
        bgz = getGroundPosition(blackX, blackY, blackZ) + 0.05
      end
      local redX2, redY2, redZ2 = x2 + 0.050096 * math.cos(rz2) - 0.704467 * math.sin(rz2), y2 + 0.050096 * math.sin(rz2) + 0.704467 * math.cos(rz2), z2 - 0.297132
      local rgz2 = 0
      if 1000 <= redZ2 then
        rgz2 = 1000.05
      else
        rgz2 = getGroundPosition(redX2, redY2, redZ2) + 0.05
      end
      local blackX2, blackY2, blackZ2 = x2 - 0.276453 * math.cos(rz2) - 0.704467 * math.sin(rz2), y2 - 0.276453 * math.sin(rz2) + 0.704467 * math.cos(rz2), z2 - 0.297132
      local bgz2 = 0
      if 1000 <= blackZ2 then
        bgz2 = 1000.05
      else
        bgz2 = getGroundPosition(blackX2, blackY2, blackZ2) + 0.05
      end
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
      if isLocal then
        localX = (x + x2) / 2
        localY = (y + y2) / 2
        localZ = (z + z2) / 2
        local d = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
        if not (not (3 < d) and isElementStreamedIn(veh1)) or not isElementStreamedIn(veh2) then
          deleteJumpstartPair(veh1)
          triggerServerEvent("removeJumpstarter", localPlayer, veh1)
        end
      end
    else
      setElementAlpha(obj, 0)
      setElementAlpha(red, 0)
      setElementAlpha(black, 0)
      setElementAlpha(obj2, 0)
    end
  end
end)
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
  createTurboSound(source)
  processSuperCharger(source)
  oldTurboSound[source] = getElementData(source, "oldTurboSound")
  fuelType[source] = getFuelType(source)
  refreshFuelTypeSound(source)
end)
addEventHandler("onClientPlayerStreamIn", getRootElement(), function()
  processPlayerJumper(source)
  playerAccelerate[source] = nil
end)
addEventHandler("onClientVehicleDataChange", getRootElement(), function(data, old, new)
  if data == "customTurbo" and isElementStreamedIn(source) then
    createTurboSound(source, new)
  elseif data == "oldTurboSound" and isElementStreamedIn(source) then
    oldTurboSound[source] = new
  elseif data == "superCharger" and isElementStreamedIn(source) then
    processSuperCharger(source)
  elseif data == "dieselFuel" then
    fuelType[source] = nil
    vehicleFuelTypeCache[source] = nil
  end
end)
addEventHandler("onClientElementDataChange", getRootElement(), function(data, old, new)
  if data == "jumperInHand" then
    processPlayerJumper(source, new)
  elseif data == "lowStamina" then
    if new then
      lowStamina[source] = true
    else
      lowStamina[source] = nil
    end
  end
end)
local protectPrompt = false
local protectPromptVeh = false
function deleteProtectPrompt()
  if protectPrompt then
    sightexports.sGui:deleteGuiElement(protectPrompt)
  end
  protectPrompt = nil
end
addEvent("protectPromptResponse", false)
addEventHandler("protectPromptResponse", getRootElement(), function(button, state, absoluteX, absoluteY, el, yes)
  deleteProtectPrompt()
  if yes then
    triggerServerEvent("tryToBuyProtect", localPlayer, protectPromptVeh)
  end
end)
addEvent("showProtectPrompt", true)
addEventHandler("showProtectPrompt", getRootElement(), function(veh, isProtected)
  if veh then
    local dbID = getElementData(veh, "vehicle.dbID")
    if dbID then
      protectPromptVeh = veh
      local titleBarHeight = sightexports.sGui:getTitleBarHeight()
      local pw = 375
      local ph = titleBarHeight + 240
      deleteProtectPrompt()
      local plate = getVehiclePlateText(veh)
      local numberPlate = split(plate, "-")
      numberPlate = table.concat(numberPlate, "-")
      local currentProtect = ""
      local ts = getRealTime().timestamp
      if isProtected and isProtected >= ts then
        local timeFormat = getRealTime(isProtected)
        currentProtect = "[color=sightgreen]" .. string.format("%04d. %02d. %02d. %02d:%02d", timeFormat.year + 1900, timeFormat.month + 1, timeFormat.monthday, timeFormat.hour, timeFormat.minute)
        isProtected = true
      else
        currentProtect = "[color=sightred]nincs"
        isProtected = false
      end
      protectPrompt = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
      sightexports.sGui:setWindowColors(protectPrompt, "sightgrey2", "sightgrey1", "sightgrey3", "#ffffff")
      sightexports.sGui:setWindowTitle(protectPrompt, "16/BebasNeueRegular.otf", "Protect " .. (isProtected and "megújítás" or "vásárlás"))
      local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - 8 - 32 - 8 - titleBarHeight, protectPrompt)
      sightexports.sGui:setLabelAlignment(label, "center", "center")
      sightexports.sGui:setLabelText(label, "Biztosan szeretnéd " .. (isProtected and "megújítani" or "megvásárolni") .. " a protectet?\n\nÁr: [color=sightblue]300 PP#ffffff\nÉrvényes: [color=sightblue]a vásárlástól számított 1 hétig#ffffff\n\nJármű: [color=sightblue]" .. sightexports.sVehiclenames:getCustomVehicleName(getElementData(veh, "vehicle.customModel") or getElementModel(veh)) .. "#ffffff\nRendszám: [color=sightblue]" .. numberPlate .. "#ffffff\nJármű ID: [color=sightblue]" .. dbID .. [[

#ffffffJelenlegi protect: ]] .. currentProtect)
      sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
      local w = (pw - 24) / 2
      local btn = sightexports.sGui:createGuiElement("button", 8, ph - 8 - 32, w, 32, protectPrompt)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightgreen",
        "sightgreen-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      sightexports.sGui:setButtonText(btn, "Igen")
      sightexports.sGui:setClickEvent(btn, "protectPromptResponse")
      sightexports.sGui:setClickArgument(btn, true)
      local btn = sightexports.sGui:createGuiElement("button", pw - w - 8, ph - 8 - 32, w, 32, protectPrompt)
      sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
      sightexports.sGui:setGuiHover(btn, "gradient", {
        "sightred",
        "sightred-second"
      }, false, true)
      sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
      sightexports.sGui:setButtonText(btn, "Nem")
      sightexports.sGui:setClickEvent(btn, "protectPromptResponse")
    end
  end
end)
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
  if getVehicleType(source) == "Helicopter" then
    setHeliBladeCollisionsEnabled(source, false)
  end
end)
