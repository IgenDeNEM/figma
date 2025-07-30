local bEffectEnabled
function setRoadShineState(bOn)
  if bOn then
    enableRoadshine3()
  else
    disableRoadshine3()
  end
end
function getRoadShineState()
  return bEffectEnabled
end
local maxEffectDistance = 250
local lightDirection = {
  0,
  0,
  1
}
local applyList = {
  {1, "*"},
  {2, "*road*"},
  {2, "*tar*"},
  {2, "*asphalt*"},
  {2, "*freeway*"},
  {2, "*hiway*"},
  {2, "*cross*"},
  {2, "*junction*"},
  {2, "snpedtest*"},
  {
    2,
    "sjmlas2lod5n"
  },
  {2, "*wall*"},
  {2, "*floor*"},
  {2, "*bridge*"},
  {2, "*conc*"},
  {2, "*drain*"},
  {2, "*carpark*"},
  {1.8, "*walk*"},
  {1.8, "*pave*"},
  {
    1,
    "hiwayoutside*"
  },
  {1, "hiwaymid*"},
  {
    1,
    "hiwayinside*"
  },
  {
    1,
    "vgsroad02_lod*"
  },
  {
    1,
    "vgsroad02b_lod*"
  },
  {
    1,
    "vegaspavement2_256*"
  }
}
local removeList = {
  "",
  "vehicle*",
  "?emap*",
  "?hite*",
  "*92*",
  "*wheel*",
  "*interior*",
  "*handle*",
  "*body*",
  "*decal*",
  "*8bit*",
  "*logos*",
  "*badge*",
  "*plate*",
  "*sign*",
  "shad*",
  "coronastar",
  "tx*",
  "lod*",
  "cj_w_grad",
  "*cloud*",
  "*smoke*",
  "sphere_cj",
  "particle*",
  "water*",
  "sw_sand",
  "coral",
  "sm_des_bush*",
  "*tree*",
  "*ivy*",
  "*pine*",
  "veg_*",
  "*largefur*",
  "hazelbr*",
  "weeelm",
  "*branch*",
  "cypress*",
  "plant*",
  "sm_josh_leaf",
  "trunk3",
  "*bark*",
  "gen_log",
  "trunk5"
}
function enableRoadshine3()
  if bEffectEnabled then
    return
  end
  if getVersion().sortable < "1.1.1" then
    outputChatBox("Resource is not compatible with this client.")
    return
  end
  for _, apply in ipairs(applyList) do
    local strength = apply[1]
    local nameMatch = apply[2]
    local info = ShaderInfoList.getShaderInfoForStrength(strength)
    if not info then
      return
    end
    engineApplyShaderToWorldTexture(info.shader, nameMatch)
  end
  for _, removeMatch in ipairs(removeList) do
    for _, info in ipairs(ShaderInfoList.items) do
      engineRemoveShaderFromWorldTexture(info.shader, removeMatch)
    end
  end
  shineTimer = setTimer(updateShineDirection, 100, 0)
  doneVehTexRemove = {}
  vehTimer = setTimer(checkCurrentVehicle, 100, 0)
  removeVehTextures()
  bEffectEnabled = true
  updateVisibility(0)
  updateShineDirection()
end
function disableRoadshine3()
  if not bEffectEnabled then
    return
  end
  for _, info in ipairs(ShaderInfoList.items) do
    destroyElement(info.shader)
  end
  ShaderInfoList.items = {}
  killTimer(shineTimer)
  killTimer(vehTimer)
  bEffectEnabled = false
end
ShaderInfoList = {}
ShaderInfoList.items = {}
function ShaderInfoList.getShaderInfoForStrength(strength)
  if #ShaderInfoList.items > 0 then
    local info = ShaderInfoList.items[#ShaderInfoList.items]
    if info.strength == strength then
      return info
    end
  end
  local shader = dxCreateShader("roadshine3.fx", 0, maxEffectDistance)
  if not shader then
    outputChatBox("Could not create shader. Please use debugscript 3")
    return nil
  end
  dxSetShaderValue(shader, "sStrength", strength)
  dxSetShaderValue(shader, "sFadeEnd", maxEffectDistance)
  dxSetShaderValue(shader, "sFadeStart", maxEffectDistance / 2)
  table.insert(ShaderInfoList.items, {shader = shader, strength = strength})
  return ShaderInfoList.items[#ShaderInfoList.items]
end
local dectectorPos = 1
local dectectorScore = 0
local detectorList = {
  {
    x = -1,
    y = -1,
    status = 0
  },
  {
    x = 0,
    y = -1,
    status = 0
  },
  {
    x = 1,
    y = -1,
    status = 0
  },
  {
    x = -1,
    y = 0,
    status = 0
  },
  {
    x = 0,
    y = 0,
    status = 0
  },
  {
    x = 1,
    y = 0,
    status = 0
  },
  {
    x = -1,
    y = 1,
    status = 0
  },
  {
    x = 0,
    y = 1,
    status = 0
  },
  {
    x = 1,
    y = 1,
    status = 0
  }
}
function detectNext()
  dectectorPos = (dectectorPos + 1) % #detectorList
  dectector = detectorList[dectectorPos + 1]
  repeat
    local lightDirX, lightDirY, lightDirZ = unpack(lightDirection)
    local x, y, z = getElementPosition(localPlayer)
    x = x + dectector.x
    y = y + dectector.y
    local endX = x - lightDirX * 200
    local endY = y - lightDirY * 200
    local endZ = z - lightDirZ * 200
    if dectector.status == 1 then
      dectectorScore = dectectorScore - 1
    end
    dectector.status = isLineOfSightClear(x, y, z, endX, endY, endZ, true, false, false) and 1 or 0
    if dectector.status == 1 then
      dectectorScore = dectectorScore + 1
    end
    if dectectorScore < 0 or 9 < dectectorScore then
      do break end
      local color = tocolor(255, 255, 0)
      if dectector.status == 1 then
        color = tocolor(255, 0, 255)
      end
      dxDrawLine3D(x, y, z, endX, endY, endZ, color)
    end
  until true
end
local fadeTarget = 0
local fadeCurrent = 0
function updateVisibility(deltaTicks)
  if not bEffectEnabled then
    return
  end
  detectNext()
  if 0 < dectectorScore then
    fadeTarget = 1
  else
    fadeTarget = 0
  end
  local dif = fadeTarget - fadeCurrent
  local maxChange = deltaTicks / 1000
  dif = math.clamp(-maxChange, dif, maxChange)
  fadeCurrent = fadeCurrent + dif
  for _, info in ipairs(ShaderInfoList.items) do
    dxSetShaderValue(info.shader, "sVisibility", fadeCurrent)
  end
end
addEventHandler("onClientPreRender", root, updateVisibility)
shineDirectionList = {
  {
    0,
    0,
    -0.019183,
    0.994869,
    -0.099336,
    4,
    0,
    1
  },
  {
    0,
    30,
    -0.019183,
    0.994869,
    -0.099336,
    4,
    0.25,
    1
  },
  {
    3,
    0,
    -0.019183,
    0.994869,
    -0.099336,
    4,
    0.5,
    1
  },
  {
    6,
    30,
    -0.019183,
    0.994869,
    -0.099336,
    4,
    0.5,
    1
  },
  {
    6,
    39,
    -0.019183,
    0.994869,
    -0.099336,
    4,
    0,
    0
  },
  {
    6,
    40,
    -0.9144,
    0.37753,
    -0.146093,
    16,
    0,
    0
  },
  {
    6,
    50,
    -0.9144,
    0.37753,
    -0.146093,
    16,
    1,
    0
  },
  {
    7,
    0,
    -0.891344,
    0.377265,
    -0.251386,
    16,
    1,
    0
  },
  {
    10,
    0,
    -0.678627,
    0.405156,
    -0.612628,
    16,
    0.5,
    0
  },
  {
    13,
    0,
    -0.303948,
    0.49079,
    -0.816542,
    16,
    0.5,
    0
  },
  {
    16,
    0,
    0.169642,
    0.707262,
    -0.686296,
    16,
    0.5,
    0
  },
  {
    18,
    0,
    0.380167,
    0.893543,
    -0.238859,
    16,
    0.5,
    0
  },
  {
    18,
    30,
    0.398043,
    0.911378,
    -0.238859,
    4,
    1,
    0
  },
  {
    18,
    53,
    0.360288,
    0.932817,
    -0.238859,
    1,
    1.5,
    0
  },
  {
    19,
    0,
    0.360288,
    0.932817,
    -0.238859,
    1,
    0,
    0
  },
  {
    19,
    1,
    0.360288,
    0.932817,
    -0.612628,
    4,
    0,
    0
  },
  {
    19,
    30,
    0.360288,
    0.932817,
    -0.612628,
    4,
    0.5,
    0
  },
  {
    21,
    0,
    0.360288,
    0.932817,
    -0.612628,
    4,
    0.5,
    0
  },
  {
    22,
    9,
    0.360288,
    0.932817,
    -0.612628,
    4,
    0,
    0
  },
  {
    22,
    10,
    -0.744331,
    0.663288,
    -0.077591,
    32,
    0,
    1
  },
  {
    22,
    30,
    -0.744331,
    0.663288,
    -0.077591,
    32,
    0.5,
    1
  },
  {
    23,
    50,
    -0.744331,
    0.663288,
    -0.077591,
    32,
    0.5,
    1
  },
  {
    23,
    59,
    -0.744331,
    0.663288,
    -0.077591,
    32,
    0,
    1
  }
}
function updateShineDirection()
  local h, m, s = getTimeHMS()
  local fhoursNow = h + m / 60 + s / 3600
  for idx, v in ipairs(shineDirectionList) do
    local fhoursTo = v[1] + v[2] / 60
    if fhoursNow <= fhoursTo then
      local vFrom = shineDirectionList[math.max(idx - 1, 1)]
      local fhoursFrom = vFrom[1] + vFrom[2] / 60
      local f = math.unlerp(fhoursFrom, fhoursNow, fhoursTo)
      local x = math.lerp(vFrom[3], f, v[3])
      local y = math.lerp(vFrom[4], f, v[4])
      local z = math.lerp(vFrom[5], f, v[5])
      local sharpness = math.lerp(vFrom[6], f, v[6])
      local brightness = math.lerp(vFrom[7], f, v[7])
      local nightness = math.lerp(vFrom[8], f, v[8])
      sharpness, brightness = applyWeatherInfluence(sharpness, brightness, nightness)
      local thresh = -0.128859
      if z < thresh then
        z = (z - thresh) / 2 + thresh
      end
      lightDirection = {
        x,
        y,
        z
      }
      for _, info in ipairs(ShaderInfoList.items) do
        dxSetShaderValue(info.shader, "sLightDir", x, y, z)
        dxSetShaderValue(info.shader, "sSpecularPower", sharpness)
        dxSetShaderValue(info.shader, "sSpecularBrightness", brightness)
      end
      break
    end
  end
end
weatherInfluenceList = {
  {
    0,
    1,
    0,
    1,
    1
  },
  {
    1,
    0.8,
    0,
    1,
    1
  },
  {
    2,
    0.8,
    0,
    1,
    1
  },
  {
    3,
    0.8,
    0,
    0.8,
    1
  },
  {
    4,
    1,
    0,
    0.2,
    0
  },
  {
    5,
    3,
    0,
    0.5,
    1
  },
  {
    6,
    3,
    1,
    0.5,
    1
  },
  {
    7,
    1,
    0,
    0.01,
    0
  },
  {
    8,
    1,
    0,
    0,
    0
  },
  {
    9,
    1,
    0,
    0,
    0
  },
  {
    10,
    1,
    0,
    1,
    1
  },
  {
    11,
    3,
    0,
    1,
    1
  },
  {
    12,
    3,
    1,
    0.5,
    0
  },
  {
    13,
    1,
    0,
    0.8,
    1
  },
  {
    14,
    1,
    0,
    0.7,
    1
  },
  {
    15,
    1,
    0,
    0.1,
    0
  },
  {
    16,
    1,
    0,
    0,
    0
  },
  {
    17,
    3,
    1,
    0.8,
    1
  },
  {
    18,
    3,
    1,
    0.8,
    1
  },
  {
    19,
    1,
    0,
    0,
    0
  }
}
local bHasCloudsBug = getVersion().sortable < "1.1.2"
function applyWeatherInfluence(sharpness, brightness, nightness)
  local id = getWeather()
  id = math.min(id, #weatherInfluenceList - 1)
  local item = weatherInfluenceList[id + 1]
  local sunSize = item[2]
  local sunTranslucency = item[3]
  local sunBright = item[4]
  local nightBright = item[5]
  if bHasCloudsBug and not getCloudsEnabled() then
    nightBright = 0
  end
  local useSize = math.lerp(sunSize, nightness, 1)
  local useTranslucency = math.lerp(sunTranslucency, nightness, 0)
  local useBright = math.lerp(sunBright, nightness, nightBright)
  brightness = brightness * useBright
  sharpness = sharpness / useSize
  return sharpness, brightness
end
local nextCheckTime = 0
local bHasFastRemove = getVersion().sortable > "1.1.1-9.03285"
addEventHandler("onClientPlayerVehicleEnter", root, function()
  removeVehTexturesSoon()
end)
function checkCurrentVehicle()
  local veh = getPedOccupiedVehicle(localPlayer)
  local id = veh and getElementModel(veh)
  if lastveh ~= veh or lastid ~= id then
    lastveh = veh
    lastid = id
    removeVehTexturesSoon()
  end
  if nextCheckTime < getTickCount() then
    nextCheckTime = getTickCount() + 5000
    removeVehTextures()
  end
end
function removeVehTexturesSoon()
  nextCheckTime = getTickCount() + 200
end
function removeVehTextures()
  if not bHasFastRemove then
    return
  end
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh then
    local id = getElementModel(veh)
    local vis = engineGetVisibleTextureNames("*", id)
    if vis then
      for _, removeMatch in pairs(vis) do
        if not doneVehTexRemove[removeMatch] then
          doneVehTexRemove[removeMatch] = true
          for _, info in ipairs(ShaderInfoList.items) do
            engineRemoveShaderFromWorldTexture(info.shader, removeMatch)
          end
        end
      end
    end
  end
end
local timeHMS = {
  0,
  0,
  0
}
local minuteStartTickCount, minuteEndTickCount
function getTimeHMS()
  return unpack(timeHMS)
end
addEventHandler("onClientRender", root, function()
  if not bEffectEnabled then
    return
  end
  local h, m = getTime()
  local s = 0
  if m ~= timeHMS[2] then
    minuteStartTickCount = getTickCount()
    local gameSpeed = math.clamp(0.01, getGameSpeed(), 10)
    minuteEndTickCount = minuteStartTickCount + 1000 / gameSpeed
  end
  if minuteStartTickCount then
    local minFraction = math.unlerpclamped(minuteStartTickCount, getTickCount(), minuteEndTickCount)
    s = math.min(59, math.floor(minFraction * 60))
  end
  timeHMS = {
    h,
    m,
    s
  }
end)
function math.lerp(from, alpha, to)
  return from + (to - from) * alpha
end
function math.unlerp(from, pos, to)
  if to == from then
    return 1
  end
  return (pos - from) / (to - from)
end
function math.clamp(low, value, high)
  return math.max(low, math.min(value, high))
end
function math.unlerpclamped(from, pos, to)
  return math.clamp(0, math.unlerp(from, pos, to), 1)
end
_dxCreateShader = dxCreateShader
function dxCreateShader(filepath, priority, maxDistance, bDebug)
  priority = priority or 0
  maxDistance = maxDistance or 0
  bDebug = bDebug or false
  local build = getVersion().sortable:sub(9)
  local fullscreen = not dxGetStatus().SettingWindowed
  if build < "03236" and fullscreen then
    maxDistance = 0
  end
  return _dxCreateShader(filepath, priority, maxDistance, bDebug)
end