local sightexports = {
  sControls = false,
  sGui = false,
  sHud = false,
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
    sightlangStaticImage[0] = dxCreateTexture("files/vign.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[1] = function()
  if not isElement(sightlangStaticImage[1]) then
    sightlangStaticImageToc[1] = false
    sightlangStaticImage[1] = dxCreateTexture("files/vign2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[2] = function()
  if not isElement(sightlangStaticImage[2]) then
    sightlangStaticImageToc[2] = false
    sightlangStaticImage[2] = dxCreateTexture("files/arrow.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[3] = function()
  if not isElement(sightlangStaticImage[3]) then
    sightlangStaticImageToc[3] = false
    sightlangStaticImage[3] = dxCreateTexture("files/body.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[4] = function()
  if not isElement(sightlangStaticImage[4]) then
    sightlangStaticImageToc[4] = false
    sightlangStaticImage[4] = dxCreateTexture("files/handband2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[5] = function()
  if not isElement(sightlangStaticImage[5]) then
    sightlangStaticImageToc[5] = false
    sightlangStaticImage[5] = dxCreateTexture("files/handband.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[6] = function()
  if not isElement(sightlangStaticImage[6]) then
    sightlangStaticImageToc[6] = false
    sightlangStaticImage[6] = dxCreateTexture("files/legband2.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[7] = function()
  if not isElement(sightlangStaticImage[7]) then
    sightlangStaticImageToc[7] = false
    sightlangStaticImage[7] = dxCreateTexture("files/legband.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[8] = function()
  if not isElement(sightlangStaticImage[8]) then
    sightlangStaticImageToc[8] = false
    sightlangStaticImage[8] = dxCreateTexture("files/blood1.dds", "argb", true)
  end
  if not sightlangStatImgHand then
    sightlangStatImgHand = true
    addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
  end
end
processsightlangStaticImage[9] = function()
  if not isElement(sightlangStaticImage[9]) then
    sightlangStaticImageToc[9] = false
    sightlangStaticImage[9] = dxCreateTexture("files/blood2.dds", "argb", true)
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
local function sightlangGuiRefreshColors()
  local res = getResourceFromName("sGui")
  if res and getResourceState(res) == "running" then
    red = sightexports.sGui:getColorCode("sightred")
    green = sightexports.sGui:getColorCode("sightgreen")
    purple = sightexports.sGui:getColorCode("sightpurple")
    orange = sightexports.sGui:getColorCode("sightorange")
    blue = sightexports.sGui:getColorCode("sightblue")
    grey1 = sightexports.sGui:getColorCode("sightgrey1")
    timerFont2 = sightexports.sGui:getFont("20/Ubuntu-R.ttf")
    timerFont2Scale = sightexports.sGui:getFontScale("20/Ubuntu-R.ttf")
    timerFont = sightexports.sGui:getFont("25/BebasNeueRegular.otf")
    timerFontScale = sightexports.sGui:getFontScale("25/BebasNeueRegular.otf")
    timerFontH = sightexports.sGui:getFontHeight("25/BebasNeueRegular.otf")
    timerWidth = sightexports.sGui:getTextWidthFont("0", "25/BebasNeueRegular.otf")
    boneIcon = sightexports.sGui:getFaIconFilename("bone-break", 32)
    bloodIcon = sightexports.sGui:getFaIconFilename("raindrops", 32)
    syringeIcon = sightexports.sGui:getFaIconFilename("syringe", 32, "regular")
    searchIcon = sightexports.sGui:getFaIconFilename("search", 32)
    loadIcon = sightexports.sGui:getFaIconFilename("circle-notch", 32)
    reviveIcon = sightexports.sGui:getFaIconFilename("heart-rate", 32)
    trashIcon = sightexports.sGui:getFaIconFilename("trash-alt", 32)
    faTicks = sightexports.sGui:getFaTicks()
  end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
  faTicks = sightexports.sGui:getFaTicks()
end)
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderBloodSplatter, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderBloodSplatter)
    end
  end
end
local damageState = {
  leftArm = false,
  rightArm = false,
  leftLeg = false,
  rightLeg = false
}
local boneIds = {
  leftArm = 33,
  rightArm = 23,
  leftLeg = 42,
  rightLeg = 52
}
local oneHandAim = {}
oneHandAim[0] = true
oneHandAim[1] = true
oneHandAim[2] = true
oneHandAim[3] = true
oneHandAim[4] = true
oneHandAim[5] = true
oneHandAim[6] = true
oneHandAim[7] = true
oneHandAim[8] = true
oneHandAim[9] = true
oneHandAim[22] = true
oneHandAim[23] = false
oneHandAim[24] = false
oneHandAim[25] = false
oneHandAim[26] = true
oneHandAim[27] = false
oneHandAim[28] = true
oneHandAim[29] = false
oneHandAim[32] = true
oneHandAim[30] = false
oneHandAim[31] = false
oneHandAim[33] = false
oneHandAim[34] = false
oneHandAim[35] = false
oneHandAim[36] = false
oneHandAim[37] = false
oneHandAim[38] = false
oneHandAim[16] = true
oneHandAim[17] = true
oneHandAim[18] = true
oneHandAim[39] = true
oneHandAim[41] = true
oneHandAim[42] = true
oneHandAim[43] = true
oneHandAim[10] = true
oneHandAim[11] = true
oneHandAim[12] = true
oneHandAim[14] = true
oneHandAim[15] = true
oneHandAim[44] = false
oneHandAim[45] = false
oneHandAim[46] = false
oneHandAim[40] = true
local hardAim = false
local proneStates = {}
local syncedAnimTime = 0
local animStage = false
local animStart = false
function refreshDamages()
  if animStart then
    if getTickCount() - animStart >= 300000 then
      animStage = 2
    else
      animStage = 1
    end
  else
    animStage = false
  end
  if animStage == 2 or animStart and getPedOccupiedVehicle(localPlayer) then
    sightexports.sControls:toggleAllControls(false)
  else
    sightexports.sControls:toggleAllControls(true)
    if animStart then
      sightexports.sControls:toggleControl("jog", false)
      sightexports.sControls:toggleControl("jump", false)
    else
      sightexports.sControls:toggleControl("jog", not damageState.leftLeg and not damageState.rightLeg)
      sightexports.sControls:toggleControl("jump", not damageState.leftLeg and not damageState.rightLeg)
    end
    hardAim = false
    local aimState = true
    local fireState = true
    if damageState.leftArm and damageState.rightArm then
      aimState = false
      fireState = false
    elseif damageState.rightArm then
      hardAim = true
    else
      local wp = getPedWeapon(localPlayer)
      if damageState.leftArm and not oneHandAim[wp] then
        hardAim = true
      end
    end
    sightexports.sControls:toggleControl("accelerate", not damageState.rightLeg)
    sightexports.sControls:toggleControl("brake_reverse", not damageState.rightLeg)
    sightexports.sControls:toggleControl("vehicle_left", not damageState.leftArm or not damageState.rightArm)
    sightexports.sControls:toggleControl("vehicle_right", not damageState.leftArm or not damageState.rightArm)
    if damageState.leftLeg and damageState.rightLeg or animStage == 1 then
      aimState = false
      fireState = false
      setProneState(localPlayer, true)
      sightexports.sControls:toggleControl("enter_exit", false)
    else
      setProneState(localPlayer, false)
      sightexports.sControls:toggleControl("enter_exit", true)
    end
    sightexports.sControls:toggleControl("aim_weapon", aimState)
    sightexports.sControls:toggleControl("fire", fireState)
  end
end
function setProneState(player, state)
  proneStates[player] = state
  if state then
    engineReplaceAnimation(player, "ped", "weapon_crouch", "pr_idle", "ParkSit_W_loop")
    engineReplaceAnimation(player, "ped", "guncrouchfwd", "pr_loop", "ParkSit_M_loop")
    engineReplaceAnimation(player, "ped", "guncrouchbwd", "prone", "proneBwd")
    engineReplaceAnimation(player, "ped", "crouch_roll_l", "prone", "leftroll")
    engineReplaceAnimation(player, "ped", "crouch_roll_r", "prone", "rightroll")
  else
    engineRestoreAnimation(player, "ped", "weapon_crouch")
    engineRestoreAnimation(player, "ped", "guncrouchfwd")
    engineRestoreAnimation(player, "ped", "guncrouchbwd")
    engineRestoreAnimation(player, "ped", "crouch_roll_l")
    engineRestoreAnimation(player, "ped", "crouch_roll_r")
  end
end
local maxAnimTime = 10
addEventHandler("onClientPlayerDataChange", localPlayer, function(dataName, oldValue, newValue)
  if dataName == "adrenaline" then
    if newValue then
      maxAnimTime = 15
    else
      maxAnimTime = 10
    end
  end
end)
playerBloodDamages = {}
playerDamageStates = {}
local streamedInPlayers = {}
local cuffState = {}
local carryingOther = {}
addEventHandler("onClientPlayerStreamIn", getRootElement(), function()
  for i = #streamedInPlayers, 1, -1 do
    if streamedInPlayers[i] == source then
      table.remove(streamedInPlayers, i)
    end
  end
  table.insert(streamedInPlayers, source)
  local bloodDamage = getElementData(source, "bloodDamage")
  playerBloodDamages[source] = bloodDamage
  local damage = getElementData(source, "bodyDamage") or {}
  playerDamageStates[source] = damage
  cuffState[source] = getElementData(source, "cuffed")
  carryingOther[source] = getElementData(source, "carryingOther")
  if damage[3] and damage[4] then
    setProneState(source, true)
  end
end)
addEvent("boneBreakSound", true)
addEventHandler("boneBreakSound", getRootElement(), function()
  if isElement(source) then
    local x, y, z = getElementPosition(source)
    local sound = playSound3D("files/bone1.mp3", x, y, z)
    setElementInterior(sound, getElementInterior(source))
    setElementDimension(sound, getElementDimension(source))
    attachElements(sound, source)
  end
end)
addEventHandler("onClientPlayerStreamOut", getRootElement(), function()
  for i = #streamedInPlayers, 1, -1 do
    if streamedInPlayers[i] == source then
      table.remove(streamedInPlayers, i)
    end
  end
  playerDamageStates[source] = nil
  setProneState(source, false)
  proneStates[source] = nil
  cuffState[source] = nil
  carryingOther[source] = nil
end)
local flyState = {}
local voiceState = {}
local voiceChannel = {}
addEventHandler("onClientPlayerVoiceStart", getRootElement(), function()
  if isElementStreamedIn(source) and voiceChannel[source] then
    voiceState[source] = true
  end
end)
addEventHandler("onClientPlayerVoiceStop", getRootElement(), function()
  if voiceState[source] then
    voiceState[source] = getTickCount()
  end
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
  for i = #streamedInPlayers, 1, -1 do
    if streamedInPlayers[i] == source then
      table.remove(streamedInPlayers, i)
    end
  end
  playerDamageStates[source] = nil
  setProneState(source, false)
  proneStates[source] = nil
  flyState[source] = nil
  cuffState[source] = nil
  carryingOther[source] = nil
  voiceState[source] = nil
  voiceChannel[source] = nil
end)
local facePaint = getElementData(localPlayer, "facePaint")
addEventHandler("onClientPlayerDataChange", getRootElement(), function(data, old, new)
  if data == "cuffed" then
    cuffState[source] = new
  elseif data == "voiceRadioChannel" then
    voiceChannel[source] = new
  elseif data == "carryingOther" then
    carryingOther[source] = new
  elseif data == "flyState" then
    flyState[source] = new
  elseif data == "bloodDamage" then
    if getElementType(source) == "player" and isElementStreamedIn(source) then
      playerBloodDamages[source] = new
    end
  elseif data == "facePaint" then
    if source == localPlayer then
      facePaint = new
    end
  elseif data == "bodyDamage" then
    if source == localPlayer then
      if new then
        damageState = {
          leftArm = new[1] or false,
          rightArm = new[2] or false,
          leftLeg = new[3] or false,
          rightLeg = new[4] or false
        }
      else
        damageState = {}
      end
      refreshDamages()
    end
    if getElementType(source) == "player" and isElementStreamedIn(source) then
      playerDamageStates[source] = new or {}
      if source ~= localPlayer then
        setProneState(source, playerDamageStates[source][3] and playerDamageStates[source][4])
      end
    end
  end
end)
local shaderSource = " texture texture0; float factor = 0; float Saturation = 1; float dark = 0; float Contrast = 0; sampler Sampler0 = sampler_state { Texture = (texture0); AddressU = MIRROR; AddressV = MIRROR; }; struct PSInput { float2 TexCoord : TEXCOORD0; }; float4 PixelShader_Background(PSInput PS) : COLOR0 { float4 sum = tex2D(Sampler0, PS.TexCoord); const float3 lumCoeff = float3(0.2125, 0.7154, 0.0721); if(factor > 0) { float xc = (PS.TexCoord.x-0.5)/0.5; float yc = (PS.TexCoord.x-0.5)/0.5; for (float i = 1; i < 3; i++) { sum += tex2D(Sampler0, float2(PS.TexCoord.x, PS.TexCoord.y + (i * factor)*yc)); sum += tex2D(Sampler0, float2(PS.TexCoord.x, PS.TexCoord.y - (i * factor)*yc)); sum += tex2D(Sampler0, float2(PS.TexCoord.x - (i * factor)*xc, PS.TexCoord.y)); sum += tex2D(Sampler0, float2(PS.TexCoord.x + (i * factor)*xc, PS.TexCoord.y)); } sum /= 9; } float r = sum.r; float g = sum.g; float b = sum.b; float4 o = sum; float3 intensity; intensity = float(dot(sum.rgb, lumCoeff)); sum.rgb = lerp(intensity, sum.rgb, Saturation ); sum.rgb = (sum.rgb - 0.5) *(Contrast + 1.0) + 0.5; sum.rgb -= dark; if(r > 0.15 && g < 0.05 && b < 0.05) sum = o; return sum; } technique complercated { pass P0 { PixelShader = compile ps_2_0 PixelShader_Background(); } } technique simple { pass P0 { Texture[0] = texture0; } } "
screenX, screenY = guiGetScreenSize()
local screenShader = false
local screenSrc = false
function startRenderingDamages()
  addEventHandler("onClientPreRender", getRootElement(), renderDamages)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  screenSrc = dxCreateScreenSource(screenX, screenY)
  screenShader = dxCreateShader(shaderSource)
  dxSetShaderValue(screenShader, "UVSize", screenX, screenY)
  dxSetShaderValue(screenShader, "factor", 0)
  dxSetShaderValue(screenShader, "texture0", screenSrc)
  engineLoadIFP("files/prone.ifp", "prone")
  engineLoadIFP("files/pr_idle.ifp", "pr_idle")
  engineLoadIFP("files/pr_loop.ifp", "pr_loop")
  if getElementData(localPlayer, "loggedIn") then
    startRenderingDamages()
    local damage = getElementData(localPlayer, "bodyDamage") or {}
    damageState = {
      leftArm = damage[1] or false,
      rightArm = damage[2] or false,
      leftLeg = damage[3] or false,
      rightLeg = damage[4] or false
    }
    refreshDamages()
  end
  local players = getElementsByType("player")
  for i = 1, #players do
    voiceChannel[players[i]] = getElementData(players[i], "voiceRadioChannel")
  end
  local players = getElementsByType("player", getRootElement(), true)
  for i = 1, #players do
    table.insert(streamedInPlayers, players[i])
    local damage = getElementData(players[i], "bodyDamage") or {}
    playerDamageStates[players[i]] = damage
    local bloodDamage = getElementData(players[i], "bloodDamage")
    playerBloodDamages[players[i]] = bloodDamage
    cuffState[players[i]] = getElementData(players[i], "cuffed")
    carryingOther[players[i]] = getElementData(players[i], "carryingOther")
    if damage[3] and damage[4] then
      setProneState(players[i], true)
    end
  end
end)
local checkCrouch = 0
local nextForce = 0
local force = 0
local tmpWp = 0
local bloods = {
  "files/blood/1.dds",
  "files/blood/2.dds",
  "files/blood/3.dds",
  "files/blood/4.dds",
  "files/blood/5.dds",
  "files/blood/6.dds"
}
function drawBlood(i, x, y, z, s)
  dxDrawMaterialLine3D(x, y, z + s, x, y, z - s, dynamicImage(bloods[i]), s * 2, tocolor(119, 0, 0))
end
local bloodParticles = {}
local attackData
function calculateAttackerImageAngle()
  local px, py = getElementPosition(localPlayer)
  local angle1 = findRotation(px, py, attackData[2], attackData[3])
  local x, y, z, tx, ty, tz = getCameraMatrix()
  local angle2 = findRotation(x, y, tx, ty)
  if angle1 and angle2 then
    local imgAngle = angle1 - angle2
    return -imgAngle
  end
end
function findRotation(x1, y1, x2, y2)
  local t = -math.deg(math.atan2(x2 - x1, y2 - y1))
  if t < 0 then
    t = t + 360
  end
  return t
end
-- ezt visszatenni ha valami nem jó
--[[local oh = getElementHealth
function getElementHealth(el)
  local hp = oh(el)
  if tonumber(hp) then
    return math.floor(hp + 0.5)
  end
  return hp
end--]]
local damageEffectTick = false
local hpTmp = getElementHealth(localPlayer)
local hp = getElementHealth(localPlayer)
local tmpVeh = false
local localLastBlood = 0
local timerText = {
  0,
  0,
  ":",
  0,
  0
}
local lastAnimTrigger = 0
local bloodSplatters = {}
local bloodTime = false
local bandageState = false
function setBandageState(state)
  bandageState = state
end
addEvent("setBandageState", true)
addEventHandler("setBandageState", getRootElement(), setBandageState)
function renderDamages(delta)
  local wp = getPedWeapon(localPlayer)
  hp = getElementHealth(localPlayer)
  localLastBlood = localLastBlood - delta
  if playerBloodDamages[localPlayer] and 20 < hp then
    local sum = 0
    sum = sum + playerBloodDamages[localPlayer][1] or 0
    sum = sum + playerBloodDamages[localPlayer][2] or 0
    sum = sum + playerBloodDamages[localPlayer][3] or 0
    sum = sum + playerBloodDamages[localPlayer][4] or 0
    sum = sum + playerBloodDamages[localPlayer][5] or 0
    if bandageState then
      sum = math.floor(sum / 2)
    end
    local minus = 1 * sum / 100
    bloodTime = (hp - 20) / minus * 10 / 60 + localLastBlood / 60000
    if localLastBlood < 0 then
      localLastBlood = 10000
      hp = hp - minus
      if hp - minus <= 20 then
        sightexports.sGui:showInfobox("w", "Túl sok vért vesztettél!")
      end
      setElementHealth(localPlayer, hp)
    end
  else
    bloodTime = false
  end
  if tmpWp ~= wp then
    tmpWp = wp
    refreshDamages()
  end
  local veh = getPedOccupiedVehicle(localPlayer)
  if tmpVeh ~= veh then
    tmpVeh = veh
    refreshDamages()
  end
  checkCrouch = checkCrouch - delta
  if damageState.leftLeg and damageState.rightLeg or animStage == 1 then
    if isPedDucked(localPlayer) then
      toggleControl("crouch", false)
    else
      setPedAnimation(localPlayer)
      setAnalogControlState("forwards", 0, true)
      setAnalogControlState("backwards", 0, true)
      setAnalogControlState("left", 0, true)
      setAnalogControlState("right", 0, true)
    end
    if checkCrouch <= 0 then
      checkCrouch = 300
      if not isPedDucked(localPlayer) then
        toggleControl("crouch", true)
        setPedControlState(localPlayer, "crouch", false)
        setPedControlState(localPlayer, "crouch", true)
        setTimer(setPedControlState, 50, 1, localPlayer, "crouch", false)
        setTimer(toggleControl, 50, 1, "crouch", false)
      else
        toggleControl("crouch", false)
      end
    end
  end
  if getPedControlState(localPlayer, "aim_weapon") and hardAim and 0 < wp then
    nextForce = nextForce - delta
    if nextForce <= 0 then
      nextForce = math.random(100, 400)
      force = force + math.random(-10000, 10000) / 10000 * 10
    end
    setPedCameraRotation(localPlayer, -(getPedCameraRotation(localPlayer) + force))
    if 0 < force then
      force = force - 45 * delta / 1000
      if force < 0 then
        force = 0
      end
    elseif force < 0 then
      force = force + 45 * delta / 1000
      if 0 < force then
        force = 0
      end
    end
  end
  for i = #bloodParticles, 1, -1 do
    bloodParticles[i][1] = bloodParticles[i][1] + bloodParticles[i][5] * delta / 1000
    bloodParticles[i][2] = bloodParticles[i][2] + bloodParticles[i][6] * delta / 1000
    bloodParticles[i][3] = bloodParticles[i][3] - 2 * delta / 1000
    if bloodParticles[i][3] < bloodParticles[i][4] then
      table.remove(bloodParticles, i)
    else
      drawBlood(bloodParticles[i][8], bloodParticles[i][1], bloodParticles[i][2], bloodParticles[i][3], 0.025 * bloodParticles[i][7])
    end
  end
end
function dxDrawLine2(x, y, x2, y2, r, g, b, a)
  dxDrawLine(x + 1, y + 1, x2 + 1, y2 + 1, tocolor(0, 0, 0, a * 0.75))
  dxDrawLine(x, y, x2, y2, tocolor(r, g, b, a))
end
function dxDrawLineEx(p, x, y, x2, y2, r, g, b, a)
  if x <= p and p <= x2 then
    local pr = (p - x) / (x2 - x)
    dxDrawLine2(x, y, x + (x2 - x) * pr, y + (y2 - y) * pr, r, g, b, a)
    dxDrawLine2(x, y, x + (x2 - x) * (1 - pr), y + (y2 - y) * (1 - pr), r, g, b, a * 0.25)
    return y + (y2 - y) * pr
  elseif x2 <= p then
    dxDrawLine2(x, y, x2, y2, r, g, b, a)
  elseif p <= x then
    dxDrawLine2(x, y, x2, y2, r, g, b, a * 0.25)
  end
end
addEventHandler("onClientPlayerSpawn", localPlayer, function()
  bloodSplatters = {}
end)
function renderBloodSplatter()
  local now = getTickCount()
  for i = #bloodSplatters, 1, -1 do
    local diff = now - bloodSplatters[i][5]
    local p = (diff - bloodSplatters[i][6]) / 200
    if 0 < p then
      if 2500 < diff then
        p = 1 - (diff - 2500) / 500
      end
      if p < 0 then
        table.remove(bloodSplatters, i)
        sightlangCondHandl0(0 < #bloodSplatters)
      else
        dxDrawImage(bloodSplatters[i][2], bloodSplatters[i][3], 128, 128, dynamicImage("files/screenblood/" .. bloodSplatters[i][1] .. ".dds"), bloodSplatters[i][4], 0, 0, tocolor(225, 0, 0, 225 * math.min(1, p)))
      end
    end
  end
end
function spawnBlood()
  for j = 1, math.random(2, 6) do
    local x, y = math.random(0, screenX), math.random(0, screenY)
    for i = 1, math.random(15, 20) do
      local rx = math.random(-256, 256) - 64
      local ry = math.random(-256, 256) - 64
      table.insert(bloodSplatters, {
        math.random(12),
        x + rx,
        y + ry,
        math.random(360),
        getTickCount(),
        math.random(600)
      })
    end
  end
  sightlangCondHandl0(true)
end
addEventHandler("onClientRender", getRootElement(), function()
  local now = getTickCount()
  if hp <= 20 then
    if not animStart then
      animStart = now
      maxAnimTime = 10
      timerText = {
        1,
        0,
        ":",
        0,
        0
      }
      syncedAnimTime = 1
      setElementData(localPlayer, "inAnimTime", syncedAnimTime)
      refreshDamages()
      local veh = getPedOccupiedVehicle(localPlayer)
      if veh then
        setElementData(veh, "vehicle.gear", "N")
      end
      triggerServerEvent("onPlayerStartAnim", localPlayer)
    end
  elseif animStart then
    animStart = false
    setElementData(localPlayer, "inAnimTime", false)
    refreshDamages()
  end
  if animStart then
    local delta = now - animStart
    if maxAnimTime * 60 * 1000 - delta <= 300000 and animStage ~= 2 then
      refreshDamages()
    end
    if 0 < hp then
      if delta > maxAnimTime * 60 * 1000 then
        setElementHealth(localPlayer, 0)
      end
      local anim1, anim2 = getPedAnimation(localPlayer)
      if isPedInVehicle(localPlayer) then
        if (anim1 ~= "ped" or anim2 ~= "car_dead_lhs") and 1000 < now - lastAnimTrigger then
          triggerServerEvent("setVehicleAnimAnimation", localPlayer)
          lastAnimTrigger = now
        end
      elseif animStage == 2 and (anim1 ~= "crack" or anim2 ~= "crckdeth1" and anim2 ~= "crckdeth2" and anim2 ~= "crckdeth3") and 1000 < now - lastAnimTrigger then
        triggerServerEvent("setStage2AnimAnimation", localPlayer)
        lastAnimTrigger = now
      end
    end
    if 60000 < delta - syncedAnimTime then
      syncedAnimTime = delta
      setElementData(localPlayer, "inAnimTime", syncedAnimTime)
    end
  end
  for i = 1, #streamedInPlayers do
    local damage = playerDamageStates[streamedInPlayers[i]] or {}
    if 20 >= getElementHealth(streamedInPlayers[i]) or damage[3] and damage[4] then
      if not proneStates[streamedInPlayers[i]] then
        setProneState(streamedInPlayers[i], true)
      end
    elseif proneStates[streamedInPlayers[i]] then
      setProneState(streamedInPlayers[i], false)
    end
  end
  if hpTmp ~= hp then
    if hp < hpTmp and 5 < hpTmp - hp then
      if damageEffectTick then
        local p = (now - damageEffectTick) / 2000
        if 0.3 < p then
          spawnBlood()
          damageEffectTick = now - 600
        end
      else
        spawnBlood()
        damageEffectTick = now
      end
    end
    hpTmp = hp
  end
  local redV = 0
  local blackV = 0
  if hp <= 40 or damageEffectTick then
    dxUpdateScreenSource(screenSrc, true)
  end
  local Saturation = 1
  local dark = 0
  local Contrast = 0
  local factor = 0
  if hp <= 40 then
    local p = 1 - (hp - 5) / 35
    if animStart then
      local delta = now - animStart
      if 300000 <= delta then
        delta = delta - 300000
        local p2 = delta / 300000
        if p < p2 then
          p = p2
        end
      end
    end
    if p < 0 then
      p = 0
    end
    Saturation = math.max(0, 1 - 1 * p * 1.5)
    dark = 0.015 * p
    Contrast = 0.25 * p
    factor = 0.004 * p
    blackV = 100 * p
    redV = 125 * p
  end
  if damageEffectTick then
    local p = (now - damageEffectTick) / 2000
    if p <= 0.35 then
      p = p / 0.35
    else
      p = 1 - (p - 0.35) / 0.65
    end
    if p < 0 then
      damageEffectTick = false
      p = 0
    end
    Saturation = math.min(Saturation, math.max(0, 1 - 1 * p * 1.25))
    dark = math.max(dark, 0.015 * p)
    Contrast = math.max(Contrast, 0.25 * p)
    factor = math.max(factor, 0.005 * p)
    blackV = math.max(blackV, 100 * p)
    redV = math.max(redV, 180 * p)
  end
  local p2 = now % 4000 / 4000
  p2 = p2 * 3
  if 2 < p2 then
    p2 = 3 - p2
  elseif 1 < p2 then
    p2 = 1
  end
  if hp <= 40 or damageEffectTick then
    dxSetShaderValue(screenShader, "Saturation", Saturation)
    dxSetShaderValue(screenShader, "dark", dark)
    dxSetShaderValue(screenShader, "Contrast", Contrast)
    dxSetShaderValue(screenShader, "factor", factor * 0.25 + factor * 0.75 * (1 - p2))
    dxDrawImage(0, 0, screenX, screenY, screenShader)
  end
  if 0 < blackV then
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processsightlangStaticImage[0]()
    end
    dxDrawImage(0, 0, screenX, screenY, sightlangStaticImage[0], 0, 0, 0, tocolor(0, 0, 0, blackV))
  end
  if 0 < redV then
    sightlangStaticImageUsed[0] = true
    if sightlangStaticImageToc[0] then
      processsightlangStaticImage[0]()
    end
    dxDrawImage(0, 0, screenX, screenY, sightlangStaticImage[0], 0, 0, 0, tocolor(red[1] * 0.75, red[2] * 0.25, red[3] * 0.25, redV * 0.25 + redV * 0.75 * (1 - p2)))
  end
  local damage = playerDamageStates[localPlayer]
  if damage and (damage[1] or damage[2] or damage[3] or damage[4]) then
    local pulse = now % 2000 / 1000
    if 1 < pulse then
      pulse = 2 - pulse
    end
    pulse = getEasingValue(pulse, "InOutQuad")
    if damage[4] then
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
      end
      dxDrawImage(0, 0, screenX, screenY, sightlangStaticImage[1], 0, 0, 0, tocolor(red[1] * 0.75, red[2] * 0.35, red[3] * 0.35, 255 * (0.35 + 0.25 * pulse)))
    end
    if damage[2] then
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
      end
      dxDrawImage(0, screenY, screenX, -screenY, sightlangStaticImage[1], 0, 0, 0, tocolor(red[1] * 0.75, red[2] * 0.35, red[3] * 0.35, 255 * (0.35 + 0.25 * pulse)))
    end
    if damage[3] then
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
      end
      dxDrawImage(screenX, 0, -screenX, screenY, sightlangStaticImage[1], 0, 0, 0, tocolor(red[1] * 0.75, red[2] * 0.35, red[3] * 0.35, 255 * (0.35 + 0.25 * pulse)))
    end
    if damage[1] then
      sightlangStaticImageUsed[1] = true
      if sightlangStaticImageToc[1] then
        processsightlangStaticImage[1]()
      end
      dxDrawImage(screenX, screenY, -screenX, -screenY, sightlangStaticImage[1], 0, 0, 0, tocolor(red[1] * 0.75, red[2] * 0.35, red[3] * 0.35, 255 * (0.35 + 0.25 * pulse)))
    end
  end
  if attackData then
    local p2 = (now - attackData[1]) / 1200
    if p2 <= 0.2 then
      p2 = p2 / 0.2
    else
      p2 = 1 - (p2 - 0.2) / 0.8
    end
    if p2 < 0 then
      attackData = false
    else
      local a = calculateAttackerImageAngle()
      sightlangStaticImageUsed[2] = true
      if sightlangStaticImageToc[2] then
        processsightlangStaticImage[2]()
      end
      dxDrawImage(screenX / 2 - 128, screenY / 2 - 256, 256, 256, sightlangStaticImage[2], a, 0, 128, tocolor(255, 255, 255, 255 * p2))
      local p = (now - attackData[1]) / 300
      local r = math.rad(a) + math.pi / 2
      if p <= 0.2 then
        p = p / 0.2
      else
        p = 1 - (p - 0.2) / 0.8
      end
      if p < 0 then
        sightexports.sHud:moveWholeHud(0, 0)
      else
        local s = 32 + 96 * attackData[4]
        local x, y = s * math.cos(r) * p, s * math.sin(r) * p
        sightexports.sHud:moveWholeHud(x, y)
      end
    end
  end
  if animStart and 0 < hp then
    local delta = maxAnimTime * 60 * 1000 - (now - animStart)
    if delta < 0 then
      delta = 0
    end
    local secs = delta / 1000
    local ew = timerWidth / 4
    local sx = screenX / 2
    local ey = 24
    local ly = y
    local y = screenY * 0.825 - ey
    if secs <= 240 then
      ey = ey * (secs / 240)
    end
    local p = sx - ew * 10 + (now - animStart + 300) % 2000 / 2000 * ew * 20
    local ny = dxDrawLineEx(p, sx - ew * 5 - ew * 5, y, sx - ew * 5 - ew * 2, y, red[1], red[2], red[3], 200)
    ly = ny or ly
    local ny = dxDrawLineEx(p, sx - ew * 5 - ew * 2, y, sx - ew * 5 - ew, y - ey, red[1], red[2], red[3], 200)
    ly = ny or ly
    local ny = dxDrawLineEx(p, sx - ew * 5 - ew, y - ey, sx - ew * 5 + ew * 0.7, y + ey * 0.5, red[1], red[2], red[3], 200)
    ly = ny or ly
    local ny = dxDrawLineEx(p, sx - ew * 5 + ew * 0.7, y + ey * 0.5, sx - ew * 5 + ew * 1.4, y, red[1], red[2], red[3], 200)
    ly = ny or ly
    local ny = dxDrawLineEx(p, sx - ew * 5 + ew * 1.4, y, sx - ew * 5 + ew * 5, y, red[1], red[2], red[3], 200)
    ly = ny or ly
    local ny = dxDrawLineEx(p, sx + ew * 5 - ew * 5, y, sx + ew * 5 - ew * 2, y, red[1], red[2], red[3], 200)
    ly = ny or ly
    local ny = dxDrawLineEx(p, sx + ew * 5 - ew * 2, y, sx + ew * 5 - ew, y - ey, red[1], red[2], red[3], 200)
    ly = ny or ly
    local ny = dxDrawLineEx(p, sx + ew * 5 - ew, y - ey, sx + ew * 5 + ew * 0.7, y + ey * 0.5, red[1], red[2], red[3], 200)
    ly = ny or ly
    local ny = dxDrawLineEx(p, sx + ew * 5 + ew * 0.7, y + ey * 0.5, sx + ew * 5 + ew * 1.4, y, red[1], red[2], red[3], 200)
    ly = ny or ly
    local ny = dxDrawLineEx(p, sx + ew * 5 + ew * 1.4, y, sx + ew * 5 + ew * 5, y, red[1], red[2], red[3], 200)
    ly = ny or ly
    dxDrawRectangle(p - 2 + 1, ly - 2 + 1, 4, 4, tocolor(0, 0, 0, 150))
    dxDrawRectangle(p - 2, ly - 2, 4, 4, tocolor(red[1], red[2], red[3], 200))
    y = screenY * 0.825
    secs = math.floor(secs)
    local mins = math.floor(secs / 60)
    secs = secs - mins * 60
    local m1 = mins % 10
    local m2 = math.floor(mins / 10)
    local s1 = secs % 10
    local s2 = math.floor(secs / 10)
    if type(timerText[1]) == "table" then
      if timerText[1][2] ~= m2 then
        timerText[1] = {
          timerText[1][2],
          m2,
          now
        }
      end
    elseif timerText[1] ~= m2 then
      timerText[1] = {
        timerText[1],
        m2,
        now
      }
    end
    if type(timerText[2]) == "table" then
      if timerText[2][2] ~= m1 then
        timerText[2] = {
          timerText[2][2],
          m1,
          now
        }
      end
    elseif timerText[2] ~= m1 then
      timerText[2] = {
        timerText[2],
        m1,
        now
      }
    end
    if type(timerText[4]) == "table" then
      if timerText[4][2] ~= s2 then
        timerText[4] = {
          timerText[4][2],
          s2,
          now
        }
      end
    elseif timerText[4] ~= s2 then
      timerText[4] = {
        timerText[4],
        s2,
        now
      }
    end
    if type(timerText[5]) == "table" then
      if timerText[5][2] ~= s1 then
        timerText[5] = {
          timerText[5][2],
          s1,
          now
        }
      end
    elseif timerText[5] ~= s1 then
      timerText[5] = {
        timerText[5],
        s1,
        now
      }
    end
    local x = screenX / 2 - timerWidth * 5 / 2
    local col = tocolor(255, 255, 255)
    local r, g, b = interpolateBetween(255, 255, 255, red[1], red[2], red[3], math.min(1, delta % 1000 / 1000), "Linear")
    col = tocolor(r, g, b)
    for i = 1, 5 do
      if type(timerText[i]) == "table" then
        local p = (now - timerText[i][3]) / 300
        if 1 < p then
          p = 1
        end
        dxDrawText(timerText[i][2], x, y, x + timerWidth, y + timerFontH * p, col, timerFontScale, timerFont, "center", "bottom", true)
        dxDrawText(timerText[i][1], x, y + timerFontH * p, x + timerWidth, y + timerFontH, col, timerFontScale, timerFont, "center", "top", true)
        if 1 <= p then
          timerText[i] = timerText[i][2]
        end
      else
        dxDrawText(timerText[i], x, y, x + timerWidth, y + timerFontH, col, timerFontScale, timerFont, "center", "top", true)
      end
      x = x + timerWidth
    end
  end
end, true, "low-999999999")
local lastBlood = {}
addEventHandler("onClientPedsProcessed", getRootElement(), function()
  local now = getTickCount()
  local p = now % 800 / 800
  if 0.5 < p then
    p = 1 - p
  end
  p = getEasingValue(p * 2, "InQuad")
  for i = #streamedInPlayers, 1, -1 do
    local player = streamedInPlayers[i]
    if isElement(player) then
      if flyState[player] then
        --[[
        setElementBoneRotation(player, 32, 0, 0, -45 + 90 * p)
        setElementBoneRotation(player, 33, 0, 0, -20 + 40 * p)
        setElementBoneRotation(player, 34, -90, 0, -45 + 90 * p)
        setElementBoneRotation(player, 35, 0, 0, 0)
        setElementBoneRotation(player, 36, 0, 0, 0)
        setElementBoneRotation(player, 22, 0, 0, 45 - 90 * p)
        setElementBoneRotation(player, 23, 0, 0, 20 - 40 * p)
        setElementBoneRotation(player, 24, 90, 0, 45 - 90 * p)
        setElementBoneRotation(player, 25, 0, 0, 0)
        setElementBoneRotation(player, 26, 0, 0, 0)
        sightexports.sCore:updateElementRpHAnim(player)
        ]]
      else
        local damage = playerBloodDamages[player]

        local d1 = damage and damage[1] or 0
        local d2 = damage and damage[2] or 0
        local d3 = damage and damage[3] or 0
        local d4 = damage and damage[4] or 0
        local d5 = damage and damage[5] or 0

        if (d1 > 0 or d2 > 0 or d3 > 0 or d4 > 0 or d5 > 0) and (now - (lastBlood[player] or 0) > 0) then
          if 4 > math.random(10) then
            lastBlood[player] = now + math.random(300, 600)
          else
            lastBlood[player] = now + math.random(50, 150)
          end
          local c = 0
          if damage[1] > 0 and math.random(100) < 70 then
            local x, y, z = getPedBonePosition(player, 33)
            for j = 1, math.random(5) do
              table.insert(bloodParticles, {
                x,
                y,
                z,
                z - 1.5,
                math.random(-50, 50) / 100,
                math.random(-50, 50) / 100,
                math.random(50, 100) / 100,
                math.random(1, 6)
              })
            end
            c = c + 1
          end
          if damage[2] > 0 and math.random(100) < 70 then
            local x, y, z = getPedBonePosition(player, 23)
            for j = 1, math.random(5) do
              table.insert(bloodParticles, {
                x,
                y,
                z,
                z - 1.5,
                math.random(-50, 50) / 100,
                math.random(-50, 50) / 100,
                math.random(50, 100) / 100,
                math.random(1, 6)
              })
            end
            c = c + 1
          end
          if 0 < damage[3] and math.random(100) < 70 then
            local x, y, z = getPedBonePosition(player, 42)
            for j = 1, math.random(5) do
              table.insert(bloodParticles, {
                x,
                y,
                z,
                z - 1.5,
                math.random(-50, 50) / 100,
                math.random(-50, 50) / 100,
                math.random(50, 100) / 100,
                math.random(1, 6)
              })
            end
            c = c + 1
          end
          if 0 < damage[4] and math.random(100) < 70 then
            local x, y, z = getPedBonePosition(player, 52)
            for j = 1, math.random(5) do
              table.insert(bloodParticles, {
                x,
                y,
                z,
                z - 1.5,
                math.random(-50, 50) / 100,
                math.random(-50, 50) / 100,
                math.random(50, 100) / 100,
                math.random(1, 6)
              })
            end
            c = c + 1
          end
          if 0 < damage[5] and math.random(100) < 70 then
            local x, y, z = getPedBonePosition(player, 3)
            for j = 1, math.random(5) do
              table.insert(bloodParticles, {
                x,
                y,
                z,
                z - 1.5,
                math.random(-50, 50) / 100,
                math.random(-50, 50) / 100,
                math.random(50, 100) / 100,
                math.random(1, 6)
              })
            end
            c = c + 1
          end
          for j = 1, c do
            local x, y, z = getElementPosition(player)
            fxAddBlood(x, y, z - 2.5, 0, 0, 1, 1, 1)
          end
        end
        local damage = playerDamageStates[player]
        local update = false
        local p = (now + i * 150) % 2000 / 2000
        if p <= 0.5 then
          p = p * 2
        else
          p = 1 - (p - 0.5) * 2
        end
        if (damage[3] or damage[4]) and (not damage[3] or not damage[4]) then
          if damage[3] then
            local x, y, z = getElementBoneRotation(player, 42)
            setElementBoneRotation(player, 42, 0, -60 + 10 * p, 0)
            update = true
          elseif damage[4] then
            local x, y, z = getElementBoneRotation(player, 52)
            setElementBoneRotation(player, 52, 0, -60 + 10 * p, 0)
            update = true
          end
        end
        if not getPedControlState(player, "aim_weapon") and (not damage[3] or not damage[4]) and not isPedDucked(player) then
          if damage[1] or damage[2] then
            local r = 0
            if damage[1] then
              r = r - 5 + 3 * p
            end
            if damage[2] then
              r = r + 5 - 3 * p
            end
            setElementBoneRotation(player, 3, 0, 20, r)
            update = true
          end
          if damage[1] then
            setElementBoneRotation(player, 32, 0, 0, 70)
            setElementBoneRotation(player, 33, 45 - 20 * p, -90 + 10 * p, 0)
            update = true
          end
          if damage[2] then
            setElementBoneRotation(player, 22, 0, 0, -70)
            setElementBoneRotation(player, 23, 45 - 20 * p, -90 + 10 * p, 0)
            update = true
          end
        end
        if carryingOther[player] then
          setElementBoneRotation(player, 22, 0, -20, -65)
          setElementBoneRotation(player, 23, 0, -80, 0)
          setElementBoneRotation(player, 24, 90, 0, 0)
          update = true
        end
        if cuffState[player] then
          setElementBoneRotation(player, 21, 40, -160, 74)
          setElementBoneRotation(player, 31, 0, 165, -74)
          setElementBoneRotation(player, 22, 40, 25, -60)
          setElementBoneRotation(player, 32, -40, 25, 60)
          setElementBoneRotation(player, 23, 0, 50, 10)
          setElementBoneRotation(player, 33, 0, 50, 0)
          setElementBoneRotation(player, 24, 0, -30, 0)
          setElementBoneRotation(player, 34, 0, -30, 0)
          setElementBoneRotation(player, 25, 0, 20, 0)
          setElementBoneRotation(player, 26, 0, 20, 0)
          setElementBoneRotation(player, 35, 0, 20, 0)
          setElementBoneRotation(player, 36, 0, 20, 0)
          update = true
        elseif voiceState[player] then
          if tonumber(voiceState[player]) and 500 < now - voiceState[player] then
            voiceState[player] = nil
          end
          setElementBoneRotation(player, 32, -80.869565217391, -99.130489515222, 23.478474824325)
          setElementBoneRotation(player, 33, 2.6086210167926, 33.912705131199, 117.39116502845)
          setElementBoneRotation(player, 34, 0, 0, 0)
          update = true
        end
        if update then
          sightexports.sCore:updateElementRpHAnim(player)
        end
      end
    else
      table.remove(streamedInPlayers, i)
    end
  end
end)
addEventHandler("onRealizedDamage", localPlayer, function(attacker, weapon, bodyPart, loss)
  if isElement(attacker) and (getElementType(attacker) == "player" or getElementType(attacker) == "ped" or getElementType(attacker) == "vehicle") and attacker ~= localPlayer then
    local x, y = getElementPosition(attacker)
    attackData = {
      getTickCount(),
      x,
      y,
      loss / 100
    }
  end
end)
addEventHandler("onClientPedDamage", getRootElement(), function(attacker, weapon, bodyPart, loss)
  if getElementData(source, "invulnerable") then
    cancelEvent()
  end
end)
addEventHandler("onClientPlayerStealthKill", getRootElement(), function(target)
  if getElementData(target, "invulnerable") then
    cancelEvent()
  end
end)
local damageTick = 0
addEventHandler("onClientVehicleDamage", getRootElement(), function(attacker, weapon, loss, x, y, z, tyre)
  if not weapon then
    local now = getTickCount()
    local veh = getPedOccupiedVehicle(localPlayer)
    if now >= damageTick + 1000 and source == getPedOccupiedVehicle(localPlayer) and (veh and getVehicleController(veh) == localPlayer) then
      damageTick = now
      triggerServerEvent("vehicleDamage", localPlayer, loss)
    end
  end
end, true, "high+99999")
local conditionWidgetState = false
local conditionWidgetPos = false
local conditionWidgetSize = false
local conditionWidgetIS = 0
function renderCondition()
  local s = conditionWidgetIS
  local fs = s / 100
  local x = conditionWidgetPos[1] + conditionWidgetSize[1]
  local y = conditionWidgetPos[2] + conditionWidgetSize[2] / 2 - conditionWidgetIS / 2
  local damage = playerDamageStates[localPlayer]
  if damage and (damage[1] or damage[2] or damage[3] or damage[4]) then
    sightlangStaticImageUsed[3] = true
    if sightlangStaticImageToc[3] then
      processsightlangStaticImage[3]()
    end
    dxDrawImage(x - s * 0.5 / 2 - s / 2, y, s, s, sightlangStaticImage[3], 0, 0, 0, tocolor(grey1[1], grey1[2], grey1[3], 200))
    if damage[2] then
      sightlangStaticImageUsed[4] = true
      if sightlangStaticImageToc[4] then
        processsightlangStaticImage[4]()
      end
      dxDrawImage(x - s * 0.5 / 2 - s / 2, y, s, s, sightlangStaticImage[4], 0, 0, 0, tocolor(red[1], red[2], red[3]))
      sightlangStaticImageUsed[5] = true
      if sightlangStaticImageToc[5] then
        processsightlangStaticImage[5]()
      end
      dxDrawImage(x - s * 0.5 / 2 - s / 2, y, s, s, sightlangStaticImage[5])
    end
    if damage[4] then
      sightlangStaticImageUsed[6] = true
      if sightlangStaticImageToc[6] then
        processsightlangStaticImage[6]()
      end
      dxDrawImage(x - s * 0.5 / 2 - s / 2, y, s, s, sightlangStaticImage[6], 0, 0, 0, tocolor(red[1], red[2], red[3]))
      sightlangStaticImageUsed[7] = true
      if sightlangStaticImageToc[7] then
        processsightlangStaticImage[7]()
      end
      dxDrawImage(x - s * 0.5 / 2 - s / 2, y, s, s, sightlangStaticImage[7])
    end
    if damage[1] then
      sightlangStaticImageUsed[4] = true
      if sightlangStaticImageToc[4] then
        processsightlangStaticImage[4]()
      end
      dxDrawImage(x - s * 0.5 / 2 - s / 2 + s, y, -s, s, sightlangStaticImage[4], 0, 0, 0, tocolor(red[1], red[2], red[3]))
      sightlangStaticImageUsed[5] = true
      if sightlangStaticImageToc[5] then
        processsightlangStaticImage[5]()
      end
      dxDrawImage(x - s * 0.5 / 2 - s / 2 + s, y, -s, s, sightlangStaticImage[5])
    end
    if damage[3] then
      sightlangStaticImageUsed[6] = true
      if sightlangStaticImageToc[6] then
        processsightlangStaticImage[6]()
      end
      dxDrawImage(x - s * 0.5 / 2 - s / 2 + s, y, -s, s, sightlangStaticImage[6], 0, 0, 0, tocolor(red[1], red[2], red[3]))
      sightlangStaticImageUsed[7] = true
      if sightlangStaticImageToc[7] then
        processsightlangStaticImage[7]()
      end
      dxDrawImage(x - s * 0.5 / 2 - s / 2 + s, y, -s, s, sightlangStaticImage[7])
    end
    x = x - s * 0.6
  end
  if bloodTime then
    sightlangStaticImageUsed[8] = true
    if sightlangStaticImageToc[8] then
      processsightlangStaticImage[8]()
    end
    dxDrawImage(x - s * 0.9 / 2 - s / 2, y, s, s, sightlangStaticImage[8], 0, 0, 0, tocolor(red[1], red[2], red[3], 200))
    sightlangStaticImageUsed[9] = true
    if sightlangStaticImageToc[9] then
      processsightlangStaticImage[9]()
    end
    dxDrawImage(x - s * 0.9 / 2 - s / 2, y, s, s, sightlangStaticImage[9], 0, 0, 0, tocolor(255, 255, 255, 200))
    local minute = math.floor(bloodTime)
    if 60 < minute then
      dxDrawText(math.floor(minute / 60) .. " óra", x - s * 0.9 / 2, y + s * 0.9, x - s * 0.9 / 2, y + s * 0.9, tocolor(red[1], red[2], red[3]), timerFont2Scale * fs, timerFont2, "center", "center", false)
    else
      dxDrawText(string.format("%02d:%02d", minute, (bloodTime - minute) * 60), x - s * 0.9 / 2, y + s * 0.9, x - s * 0.9 / 2, y + s * 0.9, tocolor(red[1], red[2], red[3]), timerFont2Scale * fs, timerFont2, "center", "center", false)
    end
    x = x - s
  end
  if facePaint then
    dxDrawImage(x - s * 0.9 / 2 - s / 2, y, s, s, "files/paint.dds", 0, 0, 0, tocolor(purple[1], purple[2], purple[3]))
    dxDrawText(facePaint .. " perc", x - s * 0.9 / 2, y + s * 0.9, x - s * 0.9 / 2, y + s * 0.9, tocolor(purple[1], purple[2], purple[3]), timerFont2Scale * fs, timerFont2, "center", "center", false)
  end
end
addEvent("hudWidgetState:condition", true)
addEventHandler("hudWidgetState:condition", getRootElement(), function(state)
  if conditionWidgetState ~= state then
    conditionWidgetState = state
    if conditionWidgetState then
      addEventHandler("onClientRender", getRootElement(), renderCondition)
    else
      removeEventHandler("onClientRender", getRootElement(), renderCondition)
    end
  end
end)
addEvent("hudWidgetPosition:condition", true)
addEventHandler("hudWidgetPosition:condition", getRootElement(), function(pos, final)
  conditionWidgetPos = pos
end)
addEvent("hudWidgetSize:condition", true)
addEventHandler("hudWidgetSize:condition", getRootElement(), function(size, final)
  conditionWidgetSize = size
  conditionWidgetIS = math.floor(math.min(size[1] / 2.3, size[2]))
end)
triggerEvent("requestWidgetDatas", localPlayer, "condition")
function isCrawling()
  return damageState.leftLeg and damageState.rightLeg or animStage == 1
end
function isDamagedForFishing()
  return damageState.leftArm or damageState.rightArm or damageState.leftLeg and damageState.rightLeg or animStage == 1
end
