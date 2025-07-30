local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processsightlangStaticImage = {}
sightlangStaticImageToc[0] = true
sightlangStaticImageToc[1] = true
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
  if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] then
    sightlangStatImgHand = false
    removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
  end
end
processsightlangStaticImage[0] = function()
  if not isElement(sightlangStaticImage[0]) then
    sightlangStaticImageToc[0] = false
    sightlangStaticImage[0] = dxCreateTexture("files/logo.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/spin.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local sightlangCondHandlState4 = false
local function sightlangCondHandl4(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState4 then
    sightlangCondHandlState4 = cond
    if cond then
      addEventHandler("onClientLazyRender", getRootElement(), renderFileLoader, true, prio)
    else
      removeEventHandler("onClientLazyRender", getRootElement(), renderFileLoader)
    end
  end
end
local sightlangCondHandlState3 = false
local function sightlangCondHandl3(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState3 then
    sightlangCondHandlState3 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderFileLoader, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderFileLoader)
    end
  end
end
local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState2 then
    sightlangCondHandlState2 = cond
    if cond then
      addEventHandler("onClientTransferBoxVisibilityChange", getRootElement(), onClientTransferBoxVisibilityChange, true, prio)
    else
      removeEventHandler("onClientTransferBoxVisibilityChange", getRootElement(), onClientTransferBoxVisibilityChange)
    end
  end
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientTransferBoxProgressChange", getRootElement(), onClientTransferBoxProgressChange, true, prio)
    else
      removeEventHandler("onClientTransferBoxProgressChange", getRootElement(), onClientTransferBoxProgressChange)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientChatMessage", getRootElement(), cancelChatMessage, true, prio)
    else
      removeEventHandler("onClientChatMessage", getRootElement(), cancelChatMessage)
    end
  end
end
local screenX, screenY = guiGetScreenSize()
local transferVisible = false
local loadingFiles = 1
local loadedFiles = 1
local font = dxCreateFont("files/BebasNeueBold.otf", 30, false, "antialiased")
local fontScale = 0.5
function cancelChatMessage()
  cancelEvent()
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  setTransferBoxVisible(false)
  if getElementData(localPlayer, "loggedIn") then
    endPreloader()
  else
    showChat(false)
    sightlangCondHandl0(true)
    sightlangCondHandl1(true)
    sightlangCondHandl2(true)
    sightlangCondHandl3(true, "low-99999999999")
    sightlangCondHandl4(true, "low-99999999999")
  end
end)
function endPreloader()
  sightlangCondHandl0(false)
  sightlangCondHandl3(false)
  sightlangCondHandl4(false)
  sightlangCondHandl1(false)
  sightlangCondHandl2(false)
  if isElement(font) then
    destroyElement(font)
  end
  font = nil
end
function onClientTransferBoxProgressChange(d, t)
  loadedFiles = d
  loadingFiles = t
  transferVisible = true
end
function onClientTransferBoxVisibilityChange(isVisible)
  transferVisible = isVisible
end
function renderFileLoader()
  dxDrawRectangle(0, 0, screenX, screenY, tocolor(26, 27, 31))
  local y = screenY / 2 - 272
  sightlangStaticImageUsed[0] = true
  if sightlangStaticImageToc[0] then
    processsightlangStaticImage[0]()
  end
  dxDrawImage(screenX / 2 - 256, y, 512, 512, sightlangStaticImage[0], 0, 0, 0, tocolor(51, 53, 61, 200))
  sightlangStaticImageUsed[1] = true
  if sightlangStaticImageToc[1] then
    processsightlangStaticImage[1]()
  end
  dxDrawImage(screenX / 2 - 16, y + 512, 32, 32, sightlangStaticImage[1], getTickCount() / 5 % 360, 0, 0, tocolor(60, 184, 130))
  local w = screenX - 48
  if transferVisible then
    loadedFiles = math.max(1, loadedFiles)
    local p = loadedFiles / math.max(loadedFiles, loadingFiles)
    dxDrawRectangle(screenX / 2 - w / 2, screenY - 96 - 8, w, 8, tocolor(51, 53, 61))
    dxDrawRectangle(screenX / 2 - w / 2, screenY - 96 - 8, w * p, 8, tocolor(60, 184, 130))
    dxDrawText("Fájlok letöltése (" .. formatBytes(loadedFiles) .. "/" .. formatBytes(math.max(loadedFiles, loadingFiles)) .. ")", screenX / 2 - w / 2, 0, 0, screenY - 96 - 8 - 14, tocolor(255, 255, 255), fontScale, font, "left", "bottom")
  else
    dxDrawText("Előkészítés folyamatban...", screenX / 2 - w / 2, 0, 0, screenY - 96 - 8 - 14, tocolor(255, 255, 255), fontScale, font, "left", "bottom")
    dxDrawRectangle(screenX / 2 - w / 2, screenY - 96 - 8, w, 8, tocolor(51, 53, 61))
  end
end
local byteSuffix = {
  "B",
  "KB",
  "MB",
  "GB",
  "TB"
}
function formatBytes(size)
  if size ~= size then
    return "0 B"
  end
  local base = math.log(size) / math.log(1024)
  local fbase = math.floor(base)
  return math.floor(math.pow(1024, base - fbase) * 100 + 0.5) / 100 .. (byteSuffix[1 + fbase] or "")
end
