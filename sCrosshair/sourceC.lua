local sightexports = {sGui = false}
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
local sightlangGuiRefreshColors = function()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    refreshColors()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local pos = {
  [0] = {-1, -1},
  [1] = {0, -1},
  [2] = {0, 0},
  [3] = {-1, 0}
}
local crosshairData = {1, "hudwhite"}
local crosshairColor = tocolor(255, 255, 255)
local crosshairImage = "files/" .. crosshairData[1] .. ".dds"
setPlayerHudComponentVisible("crosshair", false)
local screenX, screenY = guiGetScreenSize()
local weapon = false
local currentCrosshair = 2
local responsiveSize = 6.4
local baseSize = responsiveSize
local cSize = baseSize
function findSkillAccuracy(w)
  local level = -1
  local lvl = "poor"
  if w == 22 then
    level = getPedStat(localPlayer, 69)
    lvl = "poor"
    if 40 <= level then
      lvl = "std"
    end
    if 999 <= level then
      lvl = "pro"
    end
  end
  if w == 23 then
    level = getPedStat(localPlayer, 70)
    lvl = "poor"
    if 500 <= level then
      lvl = "std"
    end
    if 999 <= level then
      lvl = "pro"
    end
  end
  if w == 24 then
    level = getPedStat(localPlayer, 71)
    lvl = "poor"
    if 200 <= level then
      lvl = "std"
    end
    if 999 <= level then
      lvl = "pro"
    end
  end
  if w == 25 then
    level = getPedStat(localPlayer, 72)
    lvl = "poor"
    if 200 <= level then
      lvl = "std"
    end
    if 999 <= level then
      lvl = "pro"
    end
  end
  if w == 26 then
    level = getPedStat(localPlayer, 73)
    lvl = "poor"
    if 200 <= level then
      lvl = "std"
    end
    if 999 <= level then
      lvl = "pro"
    end
  end
  if w == 27 then
    level = getPedStat(localPlayer, 74)
    lvl = "poor"
    if 200 <= level then
      lvl = "std"
    end
    if 999 <= level then
      lvl = "pro"
    end
  end
  if w == 28 then
    level = getPedStat(localPlayer, 75)
    lvl = "poor"
    if 50 <= level then
      lvl = "std"
    end
    if 999 <= level then
      lvl = "pro"
    end
  end
  if w == 32 then
    level = getPedStat(localPlayer, 75)
    lvl = "poor"
    if 50 <= level then
      lvl = "std"
    end
    if 999 <= level then
      lvl = "pro"
    end
  end
  if w == 29 then
    level = getPedStat(localPlayer, 76)
    lvl = "poor"
    if 250 <= level then
      lvl = "std"
    end
    if 999 <= level then
      lvl = "pro"
    end
  end
  if w == 30 then
    level = getPedStat(localPlayer, 77)
    lvl = "poor"
    if 200 <= level then
      lvl = "std"
    end
    if 999 <= level then
      lvl = "pro"
    end
  end
  if w == 31 then
    level = getPedStat(localPlayer, 78)
    lvl = "poor"
    if 200 <= level then
      lvl = "std"
    end
    if 999 <= level then
      lvl = "pro"
    end
  end
  if w == 33 then
    level = getPedStat(localPlayer, 79)
    lvl = "poor"
    if 300 <= level then
      lvl = "std"
    end
    if 999 <= level then
      lvl = "pro"
    end
  end
  if w == 34 then
    level = getPedStat(localPlayer, 79)
    lvl = "poor"
    if 300 <= level then
      lvl = "std"
    end
    if 999 <= level then
      lvl = "pro"
    end
  end
  if level == -1 then
    baseSize = responsiveSize
  else
    local accuracy = getWeaponProperty(w, lvl, "accuracy")
    baseSize = responsiveSize * (0.75 / accuracy)
  end
  baseSize = math.floor(math.max(32, baseSize) / 2 + 0.5) * 2
  cSize = baseSize
end
function setCrosshair(d)
  crosshairData = d
  crosshairImage = "files/" .. crosshairData[1] .. ".dds"
  refreshColors()
  local w = getPedWeapon(localPlayer)
  weapon = false
  if 22 <= w and w <= 33 then
    weapon = w
    findSkillAccuracy(w)
    setPlayerHudComponentVisible("crosshair", false)
  else
    setPlayerHudComponentVisible("crosshair", true)
  end
end
function getCrosshair()
  return crosshairData
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, function()
  if weapon then
    cSize = baseSize * 2
  end
end)
addEventHandler("onClientPreRender", getRootElement(), function(delta)
  if cSize > baseSize then
    cSize = cSize - delta / 30
  elseif cSize < baseSize then
    cSize = baseSize
  end
end)
function refreshColors()
  crosshairColor = sightexports.sGui:getColorCodeToColor(crosshairData[2])
end
addEventHandler("onClientRender", getRootElement(), function()
  local w = getPedWeapon(localPlayer)
  if not (22 <= w) or not (w <= 33) then
    w = false
  end
  if weapon ~= w then
    weapon = w
    if weapon then
      findSkillAccuracy(w)
      setPlayerHudComponentVisible("crosshair", false)
    else
      setPlayerHudComponentVisible("crosshair", true)
    end
  end
  if crosshairData[1] > 0 and weapon and (isPedDoingGangDriveby(localPlayer) or getPedControlState("aim_weapon") and getPedTask(localPlayer, "secondary", 0) == "TASK_SIMPLE_USE_GUN") then
    local x, y, z = getPedTargetEnd(localPlayer)
    if x then
      local x, y = getScreenFromWorldPosition(x, y, z)
      if x then
        x = math.floor(x + 0.5)
        y = math.floor(y + 0.5)
        local cSize = math.floor(cSize + 0.5)
        for k = 0, 3 do
          dxDrawImage(x + pos[k][1] * cSize, y + pos[k][2] * cSize, cSize, cSize, dynamicImage(crosshairImage), 90 * k, 0, 0, crosshairColor)
        end
      end
    end
  end
end)
