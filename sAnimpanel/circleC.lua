local sightexports = {
  sGui = false,
  sHud = false,
  sFishing = false
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
    sightlangStaticImage[0] = dxCreateTexture("files/glow.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/circle.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/outline.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
local circleFont = false
local circleFontScale = false
local circleBg = false
local circleIcon = false
local circleGreen = false
local circleRed = false
local faTicks = false
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    circleFont = sightexports.sGui:getFont("14/BebasNeueRegular.otf")
    circleFontScale = sightexports.sGui:getFontScale("14/BebasNeueRegular.otf")
    circleBg = sightexports.sGui:getColorCode("sightgrey1")
    circleIcon = sightexports.sGui:getColorCode("sightmidgrey")
    circleGreen = sightexports.sGui:getColorCode("sightgreen")
    circleRed = sightexports.sGui:getColorCode("sightred")
    faTicks = sightexports.sGui:getFaTicks()
    guiRefresh()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderAnimCircle, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderAnimCircle)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderAnimCircle, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderAnimCircle)
    end
  end
end
local circleBind = "mouse3"
local iconS = 64
local screenX, screenY = guiGetScreenSize()
local icons = {}
local closeIcon
function guiRefresh()
  for i = 1, #categoryList do
    local categIcon = categoryList[i][2]
    icons[i] = sightexports.sGui:getFaIconFilename(categIcon, iconS)
  end
  closeIcon = sightexports.sGui:getFaIconFilename("ban", iconS, "light")
end
local animCircle = false
local animCircleOpened = 0
local selectedAnim = false
local tmpSelected = false
local circleCenterP = 1
local builtCircleList = {}
function preRenderAnimCircle(delta)
  local cx, cy = getCursorPosition()
  if not cx then
    animCircle = false
  else
    cx, cy = cx * screenX, cy * screenY
  end
  local selected = false
  if selectedAnim then
    selected = selectedAnim
  elseif cx and 3 <= animCircleOpened then
    local d = getDistanceBetweenPoints2D(cx, cy, screenX / 2, screenY / 2)
    if 75 < d then
      local d = math.atan2(cy - screenY / 2, cx - screenX / 2)
      local deg = math.pi * 2 / #builtCircleList
      local min = deg * 2
      for i = 1, #builtCircleList do
        local comp = math.abs((deg * i - d + math.pi) % (math.pi * 2) - math.pi)
        if min > comp then
          selected = i
          min = comp
        end
      end
    end
  end
  if tmpSelected ~= selected then
    tmpSelected = selected
    playSound("files/hover.wav")
  end
  if animCircle then
    if animCircleOpened < 3 then
      animCircleOpened = animCircleOpened + delta / 1000 * 4.75
      if 3 < animCircleOpened then
        animCircleOpened = 3
        selectedAnim = false
      end
    end
  elseif 0 < animCircleOpened then
    animCircleOpened = animCircleOpened - delta / 1000 * 4
    if animCircleOpened < 0 then
      animCircleOpened = 0
      sightlangCondHandl0(false)
      sightlangCondHandl1(false)
    end
  end
  for i = 1, #builtCircleList do
    if i == selected then
      if builtCircleList[i][3] < 1 then
        builtCircleList[i][3] = builtCircleList[i][3] + delta / 1000 * 4
        if builtCircleList[i][3] > 1 then
          builtCircleList[i][3] = 1
        end
      end
    elseif builtCircleList[i][3] > 0 then
      builtCircleList[i][3] = builtCircleList[i][3] - delta / 1000 * 4
      if builtCircleList[i][3] < 0 then
        builtCircleList[i][3] = 0
      end
    end
  end
  if selected then
    if 0 < circleCenterP then
      circleCenterP = circleCenterP - delta / 1000 * 4
      if circleCenterP < 0 then
        circleCenterP = 0
      end
    end
  elseif circleCenterP < 1 then
    circleCenterP = circleCenterP + delta / 1000 * 4
    if 1 < circleCenterP then
      circleCenterP = 1
    end
  end
end
function renderCircle(a, s, ts, i, rad, deg, p)
  local x = screenX / 2 + math.cos(deg * i) * rad * 250
  local y = screenY / 2 + math.sin(deg * i) * rad * 250
  local centerP = builtCircleList[i][3]
  if 0 < centerP and centerP < 1 then
    centerP = getEasingValue(centerP, "InOutQuad")
  end
  local r = 255 + (circleGreen[1] - 255) * centerP
  local g = 255 + (circleGreen[2] - 255) * centerP
  local b = 255 + (circleGreen[3] - 255) * centerP
  local sp = 1.5 - centerP * 0.5
  sightlangStaticImageUsed[0] = true
  if sightlangStaticImageToc[0] then
    processsightlangStaticImage[0]()
  end
  dxDrawImage(x - s * 2 * a / 2, y - s * 2 * a / 2, s * 2 * a, s * 2 * a, sightlangStaticImage[0], 0, 0, 0, tocolor(r, g, b, 255 * centerP * a))
  sightlangStaticImageUsed[1] = true
  if sightlangStaticImageToc[1] then
    processsightlangStaticImage[1]()
  end
  dxDrawImage(x - s * a / 2, y - s * a / 2, s * a, s * a, sightlangStaticImage[1], 0, 0, 0, tocolor(circleBg[1], circleBg[2], circleBg[3], 255 * a))
  local icon = icons[builtCircleList[i][2]]
  dxDrawImage(x - iconS * a / 2, y - iconS * a / 2, iconS * a, iconS * a, ":sGui/" .. icon .. faTicks[icon], 0, 0, 0, tocolor(circleIcon[1], circleIcon[2], circleIcon[3], 200 * a))
  dxDrawText(builtCircleList[i][1], x - ts * a / 2, y - ts * a / 2, x + ts * a / 2, y + ts * a / 2, tocolor(r, g, b, 255 * a), circleFontScale * a, circleFont, "center", "center", false, true)
  sightlangStaticImageUsed[2] = true
  if sightlangStaticImageToc[2] then
    processsightlangStaticImage[2]()
  end
  dxDrawImage(x - s * sp * a / 2, y - s * sp * a / 2, s * sp * a, s * sp * a, sightlangStaticImage[2], 0, 0, 0, tocolor(circleGreen[1], circleGreen[2], circleGreen[3], 255 * centerP * a))
end
function renderAnimCircle()
  local s = 150
  local ts = s * 0.8
  local a = 1
  if animCircleOpened < 1 then
    a = 1 * getEasingValue(animCircleOpened, "InQuad")
  end
  local rad = 0
  local deg = math.pi * 2 / #builtCircleList
  if 1 < animCircleOpened then
    if animCircleOpened < 3 then
      rad = getEasingValue((animCircleOpened - 1) / 2, "OutQuad")
    else
      rad = 1
    end
    for i = 1, #builtCircleList do
      if i ~= selectedAnim then
        renderCircle(1, s, ts, i, rad, deg)
      end
    end
  end
  if not selectedAnim or 1 < animCircleOpened then
    local x = screenX / 2
    local y = screenY / 2
    local centerP = circleCenterP
    if 0 < circleCenterP and circleCenterP < 1 then
      centerP = getEasingValue(centerP, "InOutQuad")
    end
    local r = 255 + (circleRed[1] - 255) * centerP
    local g = 255 + (circleRed[2] - 255) * centerP
    local b = 255 + (circleRed[3] - 255) * centerP
    local sp = 1.5 - centerP * 0.5
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processsightlangStaticImage[0]()
    end
    dxDrawImage(x - s * 2 * a / 2, y - s * 2 * a / 2, s * 2 * a, s * 2 * a, sightlangStaticImage[0], 0, 0, 0, tocolor(r, g, b, 255 * centerP * a))
    sightlangStaticImageUsed[1] = true
    if sightlangStaticImageToc[1] then
      processsightlangStaticImage[1]()
    end
    dxDrawImage(x - s * a / 2, y - s * a / 2, s * a, s * a, sightlangStaticImage[1], 0, 0, 0, tocolor(circleBg[1], circleBg[2], circleBg[3], 255 * a))
    dxDrawImage(x - iconS * a / 2, y - iconS * a / 2, iconS * a, iconS * a, ":sGui/" .. closeIcon .. faTicks[closeIcon], 0, 0, 0, tocolor(r, g, b, 255 * a))
    sightlangStaticImageUsed[2] = true
    if sightlangStaticImageToc[2] then
      processsightlangStaticImage[2]()
    end
    dxDrawImage(x - s * sp * a / 2, y - s * sp * a / 2, s * sp * a, s * sp * a, sightlangStaticImage[2], 0, 0, 0, tocolor(circleRed[1], circleRed[2], circleRed[3], 255 * centerP * a))
  end
  if selectedAnim then
    renderCircle(a, s, ts, selectedAnim, rad, deg)
  end
end
addEventHandler("onClientKey", getRootElement(), function(key, state)
  if key == circleBind and getElementData(localPlayer, "loggedIn") then
    if state and not isPedInVehicle(localPlayer) and not getElementData(localPlayer, "dashboardState") and not sightexports.sHud:getHudDisabled() and sightexports.sFishing:canUseAnimPanel() then
      animCircle = true
      sightlangCondHandl0(true)
      sightlangCondHandl1(true)
      showCursor(true)
      playSound("files/whosh1.wav")
      if animCircleOpened <= 0 then
        tmpSelected = false
        selectedAnim = false
        setCursorPosition(screenX / 2, screenY / 2)
        circleCenterP = selectedAnim and 0 or 1
        builtCircleList = {}
        for i = 1, #circleList do
          local anim = {
            animList[circleList[i]][2],
            animList[circleList[i]][1],
            currentAnimId == circleList[i] and 1 or 0,
            circleList[i]
          }
          table.insert(builtCircleList, anim)
        end
      end
      cancelEvent()
    elseif animCircle then
      animCircle = false
      showCursor(false)
      playSound("files/whosh2.wav")
      if 1 <= animCircleOpened then
        selectedAnim = false
        for i = 1, #builtCircleList do
          if builtCircleList[i][3] > 0.5 and (not selectedAnim or builtCircleList[i][3] > builtCircleList[selectedAnim][3]) then
            selectedAnim = i
          end
        end
        if selectedAnim then
          if currentAnimId ~= builtCircleList[selectedAnim][4] then
            triggerServerEvent("playAnimpanelAnimation", localPlayer, builtCircleList[selectedAnim][4])
          end
        else
          triggerServerEvent("playAnimpanelAnimation", localPlayer, false)
        end
      end
      cancelEvent()
    end
  end
end)
function getAnimCircleBind()
  return circleBind
end
function setAnimCircleBind(btn)
  circleBind = btn
end
