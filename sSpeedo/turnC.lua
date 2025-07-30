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
signalState = {}
signalStage = {}
signalTick = {}
signalModel = {}
signalLength = {}
signalOriginalStates = {}
signalRot = false
addEventHandler("onVehicleDestroy", getRootElement(), function()
  signalState[source] = nil
  signalStage[source] = nil
  signalTick[source] = nil
  signalModel[source] = nil
  signalLength[source] = nil
  signalOriginalStates[source] = nil
end)
local signalTurnOffTimer = false
blinkTime = 350
pressTime = 0
local signals = {
  mouse1 = "left",
  mouse2 = "right",
  F6 = "both",
  p = "emergency"
}
currentEmergencyColor = false
local signalLights = {
  left = {
    [0] = true,
    [3] = true
  },
  right = {
    [1] = true,
    [2] = true
  },
  both = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true
  }
}
turnSignalSound = false
function initSignalState(veh, state)
  if signalState[veh] ~= state then
    signalState[veh] = state
    signalStage[veh] = true
    if isElement(turnSignalSound) then
      destroyElement(turnSignalSound)
    end
    turnSignalSound = nil
    if state ~= "emergency" and state ~= "emergency2" and state then
      signalModel[veh] = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
      local s = getBlinkerSound(signalModel[veh])
      if veh == currentVehicle then
        turnSignalSound = playSound("files/blinkers/" .. s .. ".wav", true)
      end
      signalLength[veh] = getBlinkTime(s)
    else
      signalLength[veh] = nil
    end
    signalTick[veh] = state and getTickCount() or nil
    if state then
      if not signalOriginalStates[veh] then
        signalOriginalStates[veh] = {}
        signalOriginalStates[veh][4] = getVehicleOverrideLights(veh)
        signalOriginalStates[veh][5], signalOriginalStates[veh][6], signalOriginalStates[veh][7] = getVehicleHeadLightColor(veh)
        for i = 0, 3 do
          signalOriginalStates[veh][i] = getVehicleLightState(veh, i)
        end
      end
      local light = signalOriginalStates[veh][4] == 2
      if state == "emergency2" then
        setVehicleLightState(veh, 0, signalStage[veh] and 1 or 0)
        setVehicleLightState(veh, 3, signalStage[veh] and 1 or 0)
        setVehicleLightState(veh, 1, signalStage[veh] and 0 or 1)
        setVehicleLightState(veh, 2, signalStage[veh] and 0 or 1)
        setVehicleHeadLightColor(veh, 255, 150, 0)
      elseif state == "emergency" then
        setVehicleLightState(veh, 0, signalStage[veh] and 1 or 0)
        setVehicleLightState(veh, 3, signalStage[veh] and 1 or 0)
        setVehicleLightState(veh, 1, signalStage[veh] and 0 or 1)
        setVehicleLightState(veh, 2, signalStage[veh] and 0 or 1)
        setVehicleHeadLightColor(veh, signalStage[veh] and 255 or 0, 0, signalStage[veh] and 0 or 255)
        if veh == currentVehicle then
          currentEmergencyColor = signalStage[veh] and guiDatas.redColor or guiDatas.blueColor
        end
      else
        setVehicleHeadLightColor(veh, signalOriginalStates[veh][5], signalOriginalStates[veh][6], signalOriginalStates[veh][7])
        if veh == currentVehicle then
          currentEmergencyColor = false
        end
        if activeBlinkerLeft[signalModel[veh]] then
          for i = 0, 3 do
            setVehicleLightState(veh, i, light and signalOriginalStates[veh][i] or 1)
          end
        else
          for i = 0, 3 do
            setVehicleLightState(veh, i, signalLights[signalState[veh]][i] and (signalStage[veh] and (light and 1 or 0) or light and 0 or 1) or light and signalOriginalStates[veh][i] or 1)
          end
        end
      end
      setVehicleOverrideLights(veh, 2)
    elseif signalOriginalStates[veh] then
      for k = 0, 3 do
        setVehicleLightState(veh, k, signalOriginalStates[veh][k])
      end
      setVehicleOverrideLights(veh, signalOriginalStates[veh][4])
      setVehicleHeadLightColor(veh, signalOriginalStates[veh][5], signalOriginalStates[veh][6], signalOriginalStates[veh][7])
      signalOriginalStates[veh] = false
    end
  end
end
function turnOffSignal(currentVehicle)
  if isElement(currentVehicle) then
    initSignalState(currentVehicle, false)
    setElementData(currentVehicle, "signalState", false)
  end
end
function isHeli(veh)
  return getVehicleType(veh) == "Helicopter" or getVehicleType(veh) == "Plane"
end
function isBike(veh)
  return getVehicleType(veh) == "Bike" or getVehicleType(veh) == "Quad" or getVehicleType(veh) == "BMX"
end
local emegergency2Vehicles = {
  [525] = true,
  [443] = true,
  [552] = true,
  [574] = true
}

sirenKey = "p"

signals[sirenKey] = "emergency"

function getSirenKey()
  return sirenKey or "p"
end
function setSirenKey(val)
  sirenKey = val
  signals[sirenKey] = "emergency"
  if sirenKey == val then
    return true
  else
    return false
  end
end

addEventHandler("onClientKey", getRootElement(), function(key, por)
  if currentVehicle and currentSeat == 0 and (key == "mouse1" or key == "mouse2" or key == "F6" or key == sirenKey) and not isCursorShowing() and not isConsoleActive() and not speedoHoverState and not unitHoverState and not sightexports.sGui:getActiveInput() and not isChatBoxInputActive() then
    if isTimer(signalTurnOffTimer) then
      killTimer(signalTurnOffTimer)
    end
    if isHeli(currentVehicle) or isBike(currentVehicle) or isBoat(currentVehicle) then
      return
    end
    signalTurnOffTimer = false
    if por then
      if (signalState[currentVehicle] == "emergency2" and "emergency" or signalState[currentVehicle]) ~= signals[key] then
        pressTime = getTickCount()
        if signals[key] ~= "emergency" then
          initSignalState(currentVehicle, signals[key])
          setElementData(currentVehicle, "signalState", signalState[currentVehicle])
        else
          local model = getElementData(currentVehicle, "vehicle.customModel") or getElementModel(currentVehicle)
          if emegergency2Vehicles[model] then
            initSignalState(currentVehicle, "emergency2")
            setElementData(currentVehicle, "signalState", signalState[currentVehicle])
          else
            triggerServerEvent("turnEmergencyLights", localPlayer)
          end
        end
        local rx, ry, rz = getElementRotation(currentVehicle)
        signalRot = rz
      else
        pressTime = 0
      end
    else
      if pressTime and getTickCount() - pressTime >= (signalLength[currentVehicle] or blinkTime) then
        if signalStage[currentVehicle] or signalState[currentVehicle] == "emergency" or signalState[currentVehicle] == "emergency2" then
          signalTurnOffTimer = setTimer(turnOffSignal, (getTickCount() - signalTick[currentVehicle]) % (signalLength[currentVehicle] or blinkTime), 1, currentVehicle)
        else
          turnOffSignal(currentVehicle)
        end
      end
      pressTime = false
    end
    cancelEvent()
  end
end, true, "high+999")
addEventHandler("onClientRender", getRootElement(), function()
  if currentSeat == 0 and (signalState[currentVehicle] == "left" or signalState[currentVehicle] == "right") and signalRot and not signalStage[currentVehicle] and not pressTime then
    local rx, ry, rz = getElementRotation(currentVehicle)
    local a = signalRot - rz
    a = (a + 180) % 360 - 180
    if signalState[currentVehicle] == "left" and a <= -70 or signalState[currentVehicle] == "right" and 70 <= a then
      initSignalState(currentVehicle, false)
      setElementData(currentVehicle, "signalState", false)
    end
  end
  local vehs = getElementsByType("vehicle", getRootElement(), true)
  local now = getTickCount()
  for k = 1, #vehs do
    local veh = vehs[k]
    if signalTick[veh] then
      local bt = signalLength[veh] or blinkTime
      local delta = (now - signalTick[veh]) % (bt * 2)
      signalStage[veh] = bt > delta
      if signalState[veh] == "emergency2" then
        setVehicleLightState(veh, 0, signalStage[veh] and 1 or 0)
        setVehicleLightState(veh, 3, signalStage[veh] and 1 or 0)
        setVehicleLightState(veh, 1, signalStage[veh] and 0 or 1)
        setVehicleLightState(veh, 2, signalStage[veh] and 0 or 1)
        setVehicleHeadLightColor(veh, 255, 150, 0)
        if veh == currentVehicle then
          currentEmergencyColor = signalStage[veh] and guiDatas.redColor or guiDatas.blueColor
        end
      elseif signalState[veh] == "emergency" then
        setVehicleLightState(veh, 0, signalStage[veh] and 1 or 0)
        setVehicleLightState(veh, 3, signalStage[veh] and 1 or 0)
        setVehicleLightState(veh, 1, signalStage[veh] and 0 or 1)
        setVehicleLightState(veh, 2, signalStage[veh] and 0 or 1)
        setVehicleHeadLightColor(veh, signalStage[veh] and 255 or 0, 0, signalStage[veh] and 0 or 255)
        if veh == currentVehicle then
          currentEmergencyColor = signalStage[veh] and guiDatas.redColor or guiDatas.blueColor
        end
      elseif signalState[veh] then
        local model = signalModel[veh]
        if veh == currentVehicle and not turnSignalSound then
          local s = getBlinkerSound(model)
          turnSignalSound = playSound("files/blinkers/" .. s .. ".wav", true)
          setSoundPosition(turnSignalSound, delta / 1000)
        end
        local light = signalOriginalStates[veh][4] == 2
        if activeBlinkerLeft[model] then
          for i = 0, 3 do
            setVehicleLightState(veh, i, light and signalOriginalStates[veh][i] or 1)
          end
        else
          for i = 0, 3 do
            setVehicleLightState(veh, i, signalLights[signalState[veh]][i] and (signalStage[veh] and (light and 1 or 0) or light and 0 or 1) or light and signalOriginalStates[veh][i] or 1)
          end
        end
      end
    end
  end
end)
addEventHandler("onClientElementDataChange", getRootElement(), function(data, old, new)
  if data == "signalState" then
    initSignalState(source, new)
  end
end)
