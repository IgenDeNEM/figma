local sightexports = {sGui = false, sGroups = false}
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
local localPlayer = getLocalPlayer()
local driver = false
local shooting = false
local helpText, helpAnimation
lastSlot = 0
settings = {}
function getVehicleSpeed(currentElement)
  if isElement(currentElement) then
    local x, y, z = getElementVelocity(currentElement)
    return math.sqrt(x ^ 2 + y ^ 2 + z ^ 2) * 187.5
  end
end
local function setupDriveby(player, seat)
  if seat == 0 then
    driver = true
  else
    driver = false
  end
  setPedWeaponSlot(localPlayer, 0)
  if settings.autoEquip then
    toggleDriveby()
  end
end
addEventHandler("onClientPlayerVehicleEnter", localPlayer, setupDriveby)
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), function()
  --bindKey("X", "down", "Toggle Driveby", "")
  toggleControl("vehicle_next_weapon", false)
  toggleControl("vehicle_previous_weapon", false)
  triggerServerEvent("driveby_clientScriptLoaded", localPlayer)
  helpText = dxText:create("", 0.5, 0.85)
  helpText:scale(1)
  helpText:type("stroke", 1)
end)
local pullingKey = "x"
local lastDriveby = 0
addEventHandler("onClientKey", root, function(button, buttonState)
  if button and buttonState then
    if button == pullingKey then
      toggleDriveby()
    end
  end
end)
function getPullingKey()
  return pullingKey or "x"
end
function setPullingKey(val)
  pullingKey = val
  if pullingKey == val then
    return true
  else
    return false
  end
end
addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()), function()
  toggleControl("vehicle_next_weapon", true)
  toggleControl("vehicle_previous_weapon", true)
end)
addEvent("doSendDriveBySettings", true)
addEventHandler("doSendDriveBySettings", localPlayer, function(newSettings)
  settings = newSettings
  local newTable = {}
  for key, vehicleID in ipairs(settings.blockedVehicles) do
    newTable[vehicleID] = true
  end
  settings.blockedVehicles = newTable
end)
function checkSpeedTimer()
  if isPedDoingGangDriveby(localPlayer) and isPedInVehicle(localPlayer) then
    local spd = getVehicleSpeed(getPedOccupiedVehicle(localPlayer))
    if spd < 5 or 70 < spd then
      if not isChatBoxInputActive() then
        sightexports.sGui:showInfobox("e", "Csak 5km/h és 70km/h sebesség között használhatod a pullozást!")
        toggleDriveby()
      end
      return
    end
    local switchTo, switchToWeapon
    local lastSlotAmmo = getPedTotalAmmo(localPlayer, lastSlot)
    if not lastSlotAmmo or lastSlotAmmo == 0 or getSlotFromWeapon(getPedWeapon(localPlayer, lastSlot)) == 0 then
      for key, weaponID in ipairs(weaponsTable) do
        local slot = getSlotFromWeapon(weaponID)
        local weapon = getPedWeapon(localPlayer, slot)
        if weapon == 1 then
          weapon = 0
        end
        if weapon == weaponID and getPedTotalAmmo(localPlayer, slot) ~= 0 and (not switchTo or slot == 4) then
          switchTo = slot
          switchToWeapon = weaponID
        end
      end
    else
      switchTo = lastSlot
      switchToWeapon = getPedWeapon(localPlayer, lastSlot)
    end
    if not switchTo then
      toggleDriveby()
    end
  end
end
setTimer(checkSpeedTimer, 1000, 0)
function toggleDriveby()
  if not isPedInVehicle(localPlayer) then
    return
  end
  local vehicleID = getElementModel(getPedOccupiedVehicle(localPlayer))
  if settings.blockedVehicles[vehicleID] then
    return
  end
  local equipedWeapon = getPedWeaponSlot(localPlayer)
  if not isPedDoingGangDriveby(localPlayer) then
    local spd = getVehicleSpeed(getPedOccupiedVehicle(localPlayer))
    if spd < 5 or 70 < spd then
      if not isChatBoxInputActive() then
        sightexports.sGui:showInfobox("e", "Csak 5km/h és 70km/h sebesség között használhatod a pullozást!")
      end
      return
    end
    if driver then
      if sightexports.sGroups:isPlayerInGroup(localPlayer, 40) then
        weaponsTable = settings.driver
      else
        weaponsTable = {}
        return
      end
    else
      weaponsTable = settings.passenger
    end
    local switchTo, switchToWeapon
    local lastSlotAmmo = getPedTotalAmmo(localPlayer, lastSlot)
    if not lastSlotAmmo or lastSlotAmmo == 0 or getSlotFromWeapon(getPedWeapon(localPlayer, lastSlot)) == 0 then
      for key, weaponID in ipairs(weaponsTable) do
        local slot = getSlotFromWeapon(weaponID)
        local weapon = getPedWeapon(localPlayer, slot)
        if weapon == 1 then
          weapon = 0
        end
        if weapon == weaponID and getPedTotalAmmo(localPlayer, slot) ~= 0 and (not switchTo or slot == 4) then
          switchTo = slot
          switchToWeapon = weaponID
        end
      end
    else
      switchTo = lastSlot
      switchToWeapon = getPedWeapon(localPlayer, lastSlot)
    end
    if not switchTo then
      return
    end
    setPedDoingGangDriveby(localPlayer, true)
    setPedWeaponSlot(localPlayer, switchTo)
    limitDrivebySpeed(switchToWeapon)
    toggleControl("vehicle_look_left", false)
    toggleControl("vehicle_look_right", false)
    toggleControl("vehicle_secondary_fire", false)
    toggleTurningKeys(vehicleID, false)
    addEventHandler("onClientPlayerVehicleExit", localPlayer, removeKeyToggles)
    if prevw and nextw then
      if animation then
        Animation:remove()
      end
      fadeInHelp()
      setTimer(fadeOutHelp, 10000, 1)
    end
  else
    setPedDoingGangDriveby(localPlayer, false)
    setPedWeaponSlot(localPlayer, 0)
    limitDrivebySpeed(switchToWeapon)
    toggleControl("vehicle_look_left", true)
    toggleControl("vehicle_look_right", true)
    toggleControl("vehicle_secondary_fire", true)
    toggleTurningKeys(vehicleID, true)
    fadeOutHelp()
    removeEventHandler("onClientPlayerVehicleExit", localPlayer, removeKeyToggles)
  end
end
function removeKeyToggles(vehicle)
  toggleControl("vehicle_look_left", true)
  toggleControl("vehicle_look_right", true)
  toggleControl("vehicle_secondary_fire", true)
  toggleTurningKeys(getElementModel(vehicle), true)
  fadeOutHelp()
  removeEventHandler("onClientPlayerVehicleExit", localPlayer, removeKeyToggles)
end
local limiterTimer
function limitDrivebySpeed(weaponID)
  local speed = settings.shotdelay[tostring(weaponID)]
  if not speed then
    if not isControlEnabled("vehicle_fire") then
      toggleControl("vehicle_fire", true)
    end
    removeEventHandler("onClientPlayerVehicleExit", localPlayer, unbindFire)
    removeEventHandler("onClientPlayerWasted", localPlayer, unbindFire)
    unbindKey("vehicle_fire", "both", limitedKeyPress)
  elseif isControlEnabled("vehicle_fire") then
    toggleControl("vehicle_fire", false)
    addEventHandler("onClientPlayerVehicleExit", localPlayer, unbindFire)
    addEventHandler("onClientPlayerWasted", localPlayer, unbindFire)
    bindKey("vehicle_fire", "both", limitedKeyPress, speed)
  end
end
function unbindFire()
  unbindKey("vehicle_fire", "both", limitedKeyPress)
  if not isControlEnabled("vehicle_fire") then
    toggleControl("vehicle_fire", true)
  end
  removeEventHandler("onClientPlayerVehicleExit", localPlayer, unbindFire)
  removeEventHandler("onClientPlayerWasted", localPlayer, unbindFire)
end
local block
function limitedKeyPress(key, keyState, speed)
  if keyState == "down" then
    if block == true then
      return
    end
    shooting = true
    pressKey("vehicle_fire")
    block = true
    setTimer(function()
      block = false
    end, speed, 1)
    limiterTimer = setTimer(pressKey, speed, 0, "vehicle_fire")
  else
    shooting = false
    for k, timer in ipairs(getTimers()) do
      if timer == limiterTimer then
        killTimer(limiterTimer)
      end
    end
  end
end
function pressKey(controlName)
  setPedControlState(controlName, true)
  setTimer(setPedControlState, 150, 1, controlName, false)
end
local bikes = {
  [581] = true,
  [509] = true,
  [481] = true,
  [462] = true,
  [521] = true,
  [463] = true,
  [510] = true,
  [522] = true,
  [461] = true,
  [448] = true,
  [468] = true,
  [586] = true
}
function toggleTurningKeys(vehicleID, state)
  if bikes[vehicleID] then
    if not settings.steerBikes then
      toggleControl("vehicle_left", state)
      toggleControl("vehicle_right", state)
    end
  elseif not settings.steerCars then
    toggleControl("vehicle_left", state)
    toggleControl("vehicle_right", state)
  end
end
function fadeInHelp()
  if helpAnimation then
    helpAnimation:remove()
  end
  local _, _, _, a = helpText:color()
  if a == 255 then
    return
  end
  helpAnimation = Animation.createAndPlay(helpText, Animation.presets.dxTextFadeIn(300))
  setTimer(function()
    helpText:color(255, 255, 255, 255)
  end, 300, 1)
end
function fadeOutHelp()
  if helpAnimation then
    helpAnimation:remove()
  end
  local _, _, _, a = helpText:color()
  if a == 0 then
    return
  end
  helpAnimation = Animation.createAndPlay(helpText, Animation.presets.dxTextFadeOut(300))
  setTimer(function()
    helpText:color(255, 255, 255, 0)
  end, 300, 1)
end
