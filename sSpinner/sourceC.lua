local steelexports = {sModloader = false}
local function steelangProcessExports()
  for k in pairs(steelexports) do
    local res = getResourceFromName(k)
    if res and getResourceState(res) == "running" then
      steelexports[k] = exports[k]
    else
      steelexports[k] = false
    end
  end
end
steelangProcessExports()
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), steelangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), steelangProcessExports, true, "high+9999999999")
end
local steelangModloaderLoaded = function()
  loadModelIds()
end
addEventHandler("modloaderLoaded", getRootElement(), steelangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or steelexports.sModloader and steelexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), steelangModloaderLoaded)
end
local wheels = {
  "wheel_lf_dummy",
  "wheel_lb_dummy",
  "wheel_rf_dummy",
  "wheel_rb_dummy"
}
local wheelFlags = {
  256,
  512,
  1024,
  2048,
  4096,
  8192,
  16384,
  32768
}
local offsetTable = {
  0.65,
  0.8,
  1.05,
  1.2
}
function isFlagSet(val, flag)
  return bitAnd(val, flag) == flag
end
local previewSpinner = {}
local spinners = {}
local createdShaders = {}
function loadModelIds()
  spinnerModels = {
    {
      steelexports.sModloader:getModelId("spinner1_chrome"),
      false
    },
    {
      steelexports.sModloader:getModelId("spinner1_color"),
      true
    },
    {
      steelexports.sModloader:getModelId("spinner2_chrome"),
      false
    },
    {
      steelexports.sModloader:getModelId("spinner2_color"),
      true
    },
    {
      steelexports.sModloader:getModelId("spinner3_chrome"),
      false
    },
    {
      steelexports.sModloader:getModelId("spinner3_color"),
      true
    },
    {
      steelexports.sModloader:getModelId("spinner4_chrome"),
      false
    },
    {
      steelexports.sModloader:getModelId("spinner4_color"),
      true
    }
  }
end
function getSpinnerSize(vehicle)
  local spinnerSize = getVehicleModelWheelSize(getElementModel(vehicle))
  return spinnerSize.front_axle, spinnerSize.rear_axle
end
addEventHandler("onClientElementDestroy", getRootElement(), function()
  if spinners[source] then
    for k = 1, #spinners[source] do
      if isElement(spinners[source][k]) then
        destroyElement(spinners[source][k])
      end
    end
    spinners[source] = nil
  end
  if isElement(createdShaders[source]) then
    destroyElement(createdShaders[source])
  end
  createdShaders[source] = nil
  previewSpinner[source] = nil
end)
addEventHandler("onClientVehicleStreamOut", getRootElement(), function()
  if getElementType(source) == "vehicle" and not previewSpinner[source] then
    if spinners[source] then
      for k = 1, #spinners[source] do
        if isElement(spinners[source][k]) then
          destroyElement(spinners[source][k])
        end
      end
      spinners[source] = nil
    end
    if isElement(createdShaders[source]) then
      destroyElement(createdShaders[source])
    end
    createdShaders[source] = nil
  end
end)
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
  if getElementType(source) == "vehicle" then
    refreshSpinners(source)
  end
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  local vehicles = getElementsByType("vehicle", getRootElement(), true)
  for k, v in ipairs(vehicles) do
    refreshSpinners(v)
  end
end)
addEventHandler("onClientVehicleDataChange", getRootElement(), function(dat)
  if dat == "tuningSpinners" then
    refreshSpinners(source)
  end
end)
function refreshSpinnerColor(veh, r, g, b)
  if isElement(createdShaders[veh]) then
    dxSetShaderValue(createdShaders[veh], "red", r / 255)
    dxSetShaderValue(createdShaders[veh], "green", g / 255)
    dxSetShaderValue(createdShaders[veh], "blue", b / 255)
  end
end
addEventHandler("onClientElementDimensionChange", getRootElement(), function(old, new)
  if spinners[source] then
    for k = 1, #spinners[source] do
      if isElement(spinners[source][k]) then
        setElementDimension(spinners[source][k], new)
      end
    end
  end
end)
addEventHandler("onClientElementInteriorChange", getRootElement(), function(old, new)
  if spinners[source] then
    for k = 1, #spinners[source] do
      if isElement(spinners[source][k]) then
        setElementInterior(spinners[source][k], new)
      end
    end
  end
end)
function refreshSpinners(veh, value, skipShader)
  if value == nil then
    value = getElementData(veh, "tuningSpinners")
  end
  if spinners[veh] then
    for k = 1, #spinners[veh] do
      if isElement(spinners[veh][k]) then
        destroyElement(spinners[veh][k])
      end
    end
    spinners[veh] = nil
  end
  if isElement(createdShaders[veh]) then
    destroyElement(createdShaders[veh])
  end
  createdShaders[veh] = nil
  previewSpinner[veh] = skipShader
  if value and isElementStreamedIn(veh) then
    local spinnerID = false
    if type(value) == "table" then
      spinnerID = value[1]
      if not skipShader then
        createdShaders[veh] = dxCreateShader("tint.fx")
        dxSetShaderValue(createdShaders[veh], "red", value[2] / 255)
        dxSetShaderValue(createdShaders[veh], "green", value[3] / 255)
        dxSetShaderValue(createdShaders[veh], "blue", value[4] / 255)
      end
    else
      spinnerID = value
      createdShaders[veh] = nil
    end
    if spinnerModels[spinnerID] then
      spinners[veh] = {
        createObject(spinnerModels[spinnerID][1], 0, 0, 0),
        createObject(spinnerModels[spinnerID][1], 0, 0, 0),
        createObject(spinnerModels[spinnerID][1], 0, 0, 0),
        createObject(spinnerModels[spinnerID][1], 0, 0, 0)
      }
    end
    local handlingFlags = getVehicleHandling(veh).handlingFlags
    if spinners[veh] then
      for flag = 1, #wheelFlags do
        if isFlagSet(handlingFlags, wheelFlags[flag]) then
          if flag < 5 then
            spinners[veh][6] = flag
          else
            spinners[veh][7] = flag
          end
        end
      end
      local int = getElementInterior(veh)
      local dim = getElementDimension(veh)
      for i = 1, 4 do
        if spinners[veh] and spinners[veh][i] then
          if createdShaders[veh] then
            engineApplyShaderToWorldTexture(createdShaders[veh], "spinner_color", spinners[veh][i])
          end
          setElementInterior(spinners[veh][i], int)
          setElementDimension(spinners[veh][i], dim)
          setElementCollisionsEnabled(spinners[veh][i], false)
        end
      end
      refreshSpinnerScales(veh)
      if spinners[veh] then
        spinners[veh][5] = 0
      end
      return spinners[veh]
    end
  end
end
function refreshSpinnerScales(veh)
  local frontSize, rearSize = getSpinnerSize(veh)
  if not spinners[veh] then
    return
  end
  for i = 1, 4 do
    if i % 2 == 1 then
      if spinners[veh][6] == 1 then
        offset = offsetTable[1]
      elseif spinners[veh][6] == 2 then
        offset = offsetTable[2]
      elseif spinners[veh][6] == 3 then
        offset = offsetTable[3]
      elseif spinners[veh][6] == 4 then
        offset = offsetTable[4]
      else
        offset = 1
      end
      offset = offset * 1.05
      setObjectScale(spinners[veh][i], rearSize * offset, frontSize, rearSize)
    else
      if spinners[veh][7] == 5 then
        offset = offsetTable[1]
      elseif spinners[veh][7] == 6 then
        offset = offsetTable[2]
      elseif spinners[veh][7] == 7 then
        offset = offsetTable[3]
      elseif spinners[veh][7] == 8 then
        offset = offsetTable[4]
      else
        offset = 1
      end
      offset = offset * 1.05
      setObjectScale(spinners[veh][i], frontSize * offset, rearSize, frontSize)
    end
  end
end
function getElementSpeed(theElement, unit)
  local mult = 180
  return (Vector3(getElementVelocity(theElement)) * mult).length
end
function getPositionFromMatrixOffset(m, offX, offY, offZ)
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z
end
local wheelStates = {}
addEventHandler("onClientPreRender", getRootElement(), function(delta)
  local now = getTickCount()
  for k, v in pairs(spinners) do
    local speed = getElementSpeed(k)
    local mul = 100
    if getVehicleEngineState(k) then
      mul = mul * (1 + speed / 10)
      spinners[k][5] = spinners[k][5] + delta / 1000 * mul
    end
    m = getElementMatrix(k)
    local handlingFlags = getVehicleHandling(k).handlingFlags
    local tmp1, tmp2 = false, nil
    for flag = 1, #wheelFlags do
      if isFlagSet(handlingFlags, wheelFlags[flag]) then
        if flag < 5 then
          tmp1 = flag
        else
          tmp2 = flag
        end
      end
    end
    if tmp1 ~= spinners[k][6] or tmp2 ~= spinners[k][7] then
      spinners[k][6] = tmp1
      spinners[k][7] = tmp2
      refreshSpinnerScales(k)
    end
    for i = 1, 4 do
      if getVehicleComponentVisible(k, wheels[i]) then
        setElementAlpha(v[i], 255)
        local x, y, z = getVehicleComponentPosition(k, wheels[i])
        local spinX, spinY, spinZ = getPositionFromMatrixOffset(m, x, y, z)
        setElementPosition(v[i], spinX, spinY, spinZ)
        local rx, ry, rz = getVehicleComponentRotation(k, wheels[i], "world")
        if i < 3 then
          setElementRotation(v[i], -spinners[k][5], ry, rz, "ZYX")
        else
          setElementRotation(v[i], spinners[k][5], ry, rz, "ZYX")
        end
      else
        setElementAlpha(v[i], 0)
      end
    end
  end
end)
