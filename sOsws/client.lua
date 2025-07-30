local sightexports = {sDynasky = false}
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
local moonIlluminance = 0.1
local specularSize = 9
local flowSpeed = 0.8
local reflectionSharpness = 0.06
local reflectionStrength = 0.9
local refractionStrength = 0.4
local causticStrength = 0.3
local causticSpeed = 0.2
local causticIterations = 20
local shoreFadeStrength = 0.101
setWaterColor(100, 225, 255, 255)
local width, height = guiGetScreenSize()
local ScreenInput, waterNormal, waterFoam, waterShader
local currentMinute, minuteStartTickCount, minuteEndTickCount = 0, 0, 0
local lowShader
if lowShader then
  engineApplyShaderToWorldTexture(lowShader, "waterclear256")
end
local effectBias
local stored = false
function getOswsState()
  return stored
end
function setOswsState(state)
  if stored ~= state then
    stored = state
    if state then
      ScreenInput = dxCreateScreenSource(width / 6, height / 6)
      waterNormal = dxCreateTexture("water/normal.dds", "dxt1")
      waterFoam = dxCreateTexture("water/foam.dds", "dxt1")
      currentMinute, minuteStartTickCount, minuteEndTickCount = 0, 0, 0
      lowShader = dxCreateShader("water_low.fx", 0, 0, false, "world")
      if lowShader then
        engineApplyShaderToWorldTexture(lowShader, "waterclear256")
      end
      effectBias = dxCreateShader("effectBias.fx", 999, 0, false, "world")
      if effectBias then
        engineApplyShaderToWorldTexture(effectBias, "coronaringa")
        engineApplyShaderToWorldTexture(effectBias, "boatwake1")
        engineApplyShaderToWorldTexture(effectBias, "waterwake")
        engineApplyShaderToWorldTexture(effectBias, "sphere")
      end
      setShaders()
    else
      destroyElement(ScreenInput)
      destroyElement(waterNormal)
      destroyElement(waterFoam)
      destroyElement(lowShader)
      destroyElement(effectBias)
      destroyShaders()
    end
  end
end
function setShaders()
  if ScreenInput and not waterShader then
    waterShader = dxCreateShader("water.fx", 999, 0, false, "world")
    if waterShader then
      setNearClipDistance(0.299)
      engineApplyShaderToWorldTexture(waterShader, "waterclear256")
      dxSetShaderValue(waterShader, "sPixelSize", {
        1 / width,
        1 / height
      })
      dxSetShaderValue(waterShader, "normalTexture", waterNormal)
      dxSetShaderValue(waterShader, "foamTexture", waterFoam)
      dxSetShaderValue(waterShader, "screenInput", ScreenInput)
      dxSetShaderValue(waterShader, "specularSize", specularSize)
      dxSetShaderValue(waterShader, "flowSpeed", flowSpeed)
      dxSetShaderValue(waterShader, "reflectionSharpness", reflectionSharpness)
      dxSetShaderValue(waterShader, "reflectionStrength", reflectionStrength)
      dxSetShaderValue(waterShader, "refractionStrength", refractionStrength)
      dxSetShaderValue(waterShader, "causticStrength", causticStrength)
      dxSetShaderValue(waterShader, "causticSpeed", causticSpeed)
      dxSetShaderValue(waterShader, "causticIterations", causticIterations)
      dxSetShaderValue(waterShader, "deepness", shoreFadeStrength)
      addEventHandler("onClientPreRender", root, updateShaders)
    end
  end
end
function destroyShaders()
  removeEventHandler("onClientPreRender", root, updateShaders)
  if isElement(waterShader) then
    destroyElement(waterShader)
    waterShader = nil
  end
  if isElement(lowShader) then
    engineApplyShaderToWorldTexture(lowShader, "waterclear256")
  end
end
function updateShaders()
  if waterShader and ScreenInput then
    local ho, mi = getTime()
    local se = 0
    if mi ~= currentMinute then
      minuteStartTickCount = getTickCount()
      local gameSpeed = math.clamp(0.01, getGameSpeed(), 10)
      minuteEndTickCount = minuteStartTickCount + getMinuteDuration() / gameSpeed
    end
    if minuteStartTickCount then
      local minFraction = math.unlerpclamped(minuteStartTickCount, getTickCount(), minuteEndTickCount)
      se = math_min(59, math.floor(minFraction * 60)) / 60
    end
    currentMinute = mi
    local shiningPower = getShiningPower(ho, mi, se)
    local sunX, sunY, sunZ = 0, 0, 0
    local moonX, moonY, moonZ = 0, 0, 0
    local skyResource = getResourceFromName("sDynasky")
    if skyResource and getResourceState(skyResource) == "running" and sightexports.sDynasky:isDynamicSkyEnabled() then
      local px, py, pz = getElementPosition(localPlayer)
      local x, y, z = sightexports.sDynasky:getDynamicSunVector()
      local dist = getFarClipDistance() * 0.8
      sunX, sunY, sunZ = px - x * dist, py - y * dist, pz - z * dist
      x, y, z = sightexports.sDynasky:getDynamicMoonVector()
      moonX, moonY, moonZ = px - x * dist, py - y * dist, pz - z * dist
    else
      shiningPower = 0
    end
    local cr, cg, cb = getSunColor()
    local nightModifier = 1
    if 21 <= ho or ho < 5 then
      cr, cg, cb = 255, 255, 255
      sunX, sunY, sunZ = moonX, moonY, moonZ
      nightModifier = 0.4
    end
    local wr, wg, wb, waterAlpha = getWaterColor()
    dxUpdateScreenSource(ScreenInput)
    dxSetShaderValue(waterShader, "dayTime", getDiffuse(ho, mi, se))
    dxSetShaderValue(waterShader, "waterShiningPower", shiningPower * nightModifier)
    dxSetShaderValue(waterShader, "waterColor", {
      wr / 255,
      wg / 255,
      wb / 255,
      waterAlpha / 255
    })
    dxSetShaderValue(waterShader, "sunColor", {
      cr / 600,
      cg / 600,
      cb / 600
    })
    dxSetShaderValue(waterShader, "sunPos", {
      sunX,
      sunY,
      sunZ
    })
  end
end
function getDiffuse(ho, mi, se)
  local diffuse = 1
  if 21 < ho or ho < 6 then
    diffuse = 0
  end
  if ho == 6 then
    diffuse = 1 - (60 - mi - se) / 60
  elseif ho == 20 then
    diffuse = 1 - (mi + se) / 60
  elseif ho == 21 then
    diffuse = math_min(1, 1 + (mi + se - 20) / 20) * moonIlluminance
  elseif 21 < ho or ho < 3 then
    diffuse = moonIlluminance
  elseif ho == 3 then
    diffuse = math_min(1, 1 - (mi + se - 40) / 20) * moonIlluminance
  end
  return diffuse
end
function getShiningPower(ho, mi, se)
  local shiningPower = 1
  if ho == 6 then
    if mi < 20 then
      shiningPower = 1 - (20 - mi - se) / 20
    elseif 20 <= mi then
      shiningPower = 1
    end
  elseif ho == 19 then
    shiningPower = math_min(1, 1 - (mi + se - 40) / 20)
  elseif ho == 20 or ho == 5 or ho == 4 then
    shiningPower = 0
  elseif ho == 3 then
    shiningPower = math_min(1, 1 - (mi + se - 40) / 20)
  elseif ho == 21 then
    shiningPower = math_min(1, 1 + (mi + se - 20) / 20)
  end
  return shiningPower
end
function math.clamp(low, value, high)
  return math_max(low, math_min(value, high))
end
function math.unlerp(from, pos, to)
  if to == from then
    return 1
  end
  return (pos - from) / (to - from)
end
function math.unlerpclamped(from, pos, to)
  return math.clamp(0, math.unlerp(from, pos, to), 1)
end
function math_max(a, b)
  return b < a and a or b
end
function math_min(a, b)
  return a < b and a or b
end
