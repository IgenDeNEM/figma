local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderAd, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderAd)
    end
  end
end
amgOne = 415
activeSpoilers = {
  [494] = -17,
  [506] = -20,
  [502] = -5,
  ["audirs7"] = -5,
}
activeBlinkerLeft = {
  [495] = "indicator_l",
  [470] = "indicator_l",
  [415] = "indicator_left",
  [404] = "indicator_l",
  [405] = "indicator_l",
  [604] = "indicator_l",
  [480] = "indicator_l",
  [566] = "indicator_l",
  [589] = "indicator_l",
  ["model_s"] = "indicator_l",
  ["model_y"] = "indicator_l",
  ["leaf"] = "indicator_l",
  [419] = "indicator_l",
  [467] = "indicator_l",
  [543] = "indicator_l",
  [400] = {"indicator_l1"},
  [492] = "indicator_l",
  [436] = "indicator_l",
  ["dodge"] = "indicator_l"
}
activeBlinkerRight = {
  [495] = "indicator_r",
  [470] = "indicator_r",
  [415] = "indicator_right",
  [404] = "indicator_r",
  [604] = "indicator_r",
  [480] = "indicator_r",
  [566] = "indicator_r",
  [405] = "indicator_r",
  [589] = "indicator_r",
  ["model_s"] = "indicator_r",
  ["model_y"] = "indicator_r",
  ["leaf"] = "indicator_r",
  [419] = "indicator_r",
  [467] = "indicator_r",
  [543] = "indicator_r",
  [400] = "indicator_r1",
  [492] = "indicator_r",
  [436] = "indicator_r",
  ["dodge"] = "indicator_r"
}
activeHeadlight = {
  [439] = {"movielight", 57.5}
}
function checkAd(veh)
  if getElementType(veh) == "vehicle" then
    local model = getElementModel(veh)
    local customModel = getElementData(veh, "vehicle.customModel")
    local modelToCheck = customModel or model 
    return activeSpoilers[modelToCheck] or modelToCheck == amgOne or activeBlinkerLeft[modelToCheck] or activeHeadlight[modelToCheck]
  end
end
local adVehList = {}
local adVehModel = {}
local adVehLastSpeed = {}
local adSpoilerP = {}
local adSpoilerForce = {}
local amgOneSpoiler = {}
local amgOneSpoilerSpd = {}
local adHeadlightP = {}
function adDataChange(data, old, new)
  if data == "forceSpoiler" then
    adSpoilerForce[source] = new
  end
end
function adStreamOut()
  for i = #adVehList, 1, -1 do
    if adVehList[i] == source then
      table.remove(adVehList, i)
      break
    end
  end
  adVehModel[source] = nil
  adVehLastSpeed[source] = nil
  adSpoilerP[source] = nil
  adSpoilerForce[source] = nil
  amgOneSpoiler[source] = nil
  amgOneSpoilerSpd[source] = nil
  adHeadlightP[source] = nil
  removeEventHandler("onClientElementDataChange", source, adDataChange)
  removeEventHandler("onClientElementStreamOut", source, adStreamOut)
  removeEventHandler("onClientElementDestroy", source, adStreamOut)
end
function adStreamIn(veh, model)
  sightlangCondHandl0(true)
  if not adVehModel[veh] then
    table.insert(adVehList, veh)
    adVehModel[veh] = model
    adVehLastSpeed[veh] = 0
    if model == amgOne then
      amgOneSpoiler[veh] = 0
      amgOneSpoilerSpd[veh] = 0
      adSpoilerForce[veh] = getElementData(veh, "forceSpoiler")
    elseif activeSpoilers[model] then
      adSpoilerP[veh] = 0
      adSpoilerForce[veh] = getElementData(veh, "forceSpoiler")
    end
    if activeHeadlight[model] then
      adHeadlightP[veh] = 0
    end
    addEventHandler("onClientElementDataChange", veh, adDataChange)
    addEventHandler("onClientElementStreamOut", veh, adStreamOut)
    addEventHandler("onClientElementDestroy", veh, adStreamOut)
  end
end
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
  local model = getElementModel(source)
  local customModel = getElementData(source, "vehicle.customModel") or false
  if checkAd(source) then
    adStreamIn(source, customModel and customModel or model)
  end
end)
function preRenderAd(delta)
  for i = 1, #adVehList do
    local veh = adVehList[i]
    local model = adVehModel[veh]
    local speed = getVehicleSpeed(veh, "KM/H")
    local accel = (speed - adVehLastSpeed[veh]) / delta
    adVehLastSpeed[veh] = speed
    local onScreen = isElementOnScreen(veh)
    if model == amgOne then
      local target = 0
      if adSpoilerForce[veh] then
        target = 1
      elseif 50 < speed then
        target = math.min(1, (speed - 50) / 150)
      end
      if accel < -0.0625 and 40 < speed then
        target = 2
      end
      target = math.max(0, math.min(2, target))
      local spd = (1 < target or 1 < amgOneSpoiler[veh]) and 4 or 1
      if spd > amgOneSpoilerSpd[veh] then
        amgOneSpoilerSpd[veh] = amgOneSpoilerSpd[veh] + 15 * delta / 1000
        if spd < amgOneSpoilerSpd[veh] then
          amgOneSpoilerSpd[veh] = spd
        end
      end
      if spd < amgOneSpoilerSpd[veh] then
        amgOneSpoilerSpd[veh] = amgOneSpoilerSpd[veh] - 12 * delta / 1000
        if spd > amgOneSpoilerSpd[veh] then
          amgOneSpoilerSpd[veh] = spd
        end
      end
      if target > amgOneSpoiler[veh] then
        amgOneSpoiler[veh] = amgOneSpoiler[veh] + amgOneSpoilerSpd[veh] * delta / 1000
        if target < amgOneSpoiler[veh] then
          amgOneSpoiler[veh] = target
        end
      end
      if target < amgOneSpoiler[veh] then
        amgOneSpoiler[veh] = amgOneSpoiler[veh] - amgOneSpoilerSpd[veh] * delta / 1000
        if target > amgOneSpoiler[veh] then
          amgOneSpoiler[veh] = target
        end
      end
      if onScreen then
        local p = amgOneSpoiler[veh]
        setVehicleComponentRotation(veh, "left1", -25 * (p * 0.6), 0, 3 * (p * 0.6))
        setVehicleComponentRotation(veh, "left2", -25 * (p * 0.6), 0, 3 * (p * 0.6))
        setVehicleComponentRotation(veh, "left3", -25 * (p * 0.6), 0, 3 * (p * 0.6))
        setVehicleComponentRotation(veh, "left4", -25 * (p * 0.6), 0, 3 * (p * 0.6))
        setVehicleComponentRotation(veh, "right1", -25 * (p * 0.6), 0, -3 * (p * 0.6))
        setVehicleComponentRotation(veh, "right2", -25 * (p * 0.6), 0, -3 * (p * 0.6))
        setVehicleComponentRotation(veh, "right3", -25 * (p * 0.6), 0, -3 * (p * 0.6))
        setVehicleComponentRotation(veh, "right4", -25 * (p * 0.6), 0, -3 * (p * 0.6))
        setVehicleComponentRotation(veh, "f_an3a=ax-25", -25 * math.min(1, p * 0.8), 0, 0)
        setVehicleComponentRotation(veh, "f_an4b=ax-15", -18 * math.max(0, p - 1), 0, 0)
      end
    elseif activeSpoilers[model] then
      local t = 0
      if adSpoilerForce[veh] then
        t = 1
      elseif 170 < speed then
        t = math.min(1, (speed - 170) / 30)
      end
      if accel < -0.0625 and 30 < speed then
        t = math.max(1, t + 0.5 * math.min(1, (speed - 30) / 15))
      end
      if t > adSpoilerP[veh] then
        adSpoilerP[veh] = adSpoilerP[veh] + 2 * delta / 1000
        if t < adSpoilerP[veh] then
          adSpoilerP[veh] = t
        end
      elseif t < adSpoilerP[veh] then
        adSpoilerP[veh] = adSpoilerP[veh] - 1 * delta / 1000
        if t > adSpoilerP[veh] then
          adSpoilerP[veh] = t
        end
      end
      if onScreen then
        local p = adSpoilerP[veh]
        if 0 < p and p < 1 then
          p = getEasingValue(p, "InOutQuad")
        end
        setVehicleComponentRotation(veh, "movspoiler", activeSpoilers[model] * p, 0, 0)
      end
    end
    if activeHeadlight[model] then
      local t = getVehicleOverrideLights(veh) == 2 and 1 or 0
      if t > adHeadlightP[veh] then
        adHeadlightP[veh] = adHeadlightP[veh] + 1 * delta / 1000
        if t < adHeadlightP[veh] then
          adHeadlightP[veh] = t
        end
      elseif t < adHeadlightP[veh] then
        adHeadlightP[veh] = adHeadlightP[veh] - 1 * delta / 1000
        if t > adHeadlightP[veh] then
          adHeadlightP[veh] = t
        end
      end
      if onScreen then
        local p = adHeadlightP[veh]
        if 0 < p and p < 1 then
          p = getEasingValue(p, "InOutQuad")
        end
        setVehicleComponentRotation(veh, activeHeadlight[model][1], activeHeadlight[model][2] * p, 0, 0)
      end
    end
    if activeBlinkerLeft[model] and onScreen then
      if signalTick[veh] then
        local both = signalState[veh] == "both"
        local state = (both or signalState[veh] == "left") and signalStage[veh]
        if type(activeBlinkerLeft[model]) == "table" then
          for blinkerIndex, blinkerName in pairs(activeBlinkerLeft[model]) do
            setVehicleComponentVisible(veh, blinkerName, state)
          end
        else
          setVehicleComponentVisible(veh, activeBlinkerLeft[model], state)
        end
        local state = (both or signalState[veh] == "right") and signalStage[veh]
        if type(activeBlinkerRight[model]) == "table" then
          for blinkerIndex, blinkerName in pairs(activeBlinkerRight[model]) do
            setVehicleComponentVisible(veh, blinkerName, state)
          end
        else
          setVehicleComponentVisible(veh, activeBlinkerRight[model], state)
        end
      else
        if type(activeBlinkerLeft[model]) == "table" then
          for blinkerIndex, blinkerName in pairs(activeBlinkerLeft[model]) do
            setVehicleComponentVisible(veh, blinkerName, false)
          end
        else
          setVehicleComponentVisible(veh, activeBlinkerLeft[model], false)
        end
        if type(activeBlinkerRight[model]) == "table" then
          for blinkerIndex, blinkerName in pairs(activeBlinkerRight[model]) do
            setVehicleComponentVisible(veh, blinkerName, false)
          end
        else
          setVehicleComponentVisible(veh, activeBlinkerRight[model], false)
        end
      end
    end
  end
  if #adVehList <= 0 then
    sightlangCondHandl0(false)
  end
end
local vehicles = getElementsByType("vehicle", getRootElement(), true)
for i = 1, #vehicles do
  local customModel = getElementData(vehicles[i], "vehicle.customModel") or false
  local model = getElementModel(vehicles[i])
  if checkAd(vehicles[i]) then
    adStreamIn(vehicles[i], customModel and customModel or model)
  end
end