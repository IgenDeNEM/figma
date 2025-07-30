local changer = " texture gTexture; technique hello { pass P0 { Texture[0] = gTexture; } } "
local customPjData = {}
local requestingPjData = {}
addEvent("gotCustomPJData", true)
addEventHandler("gotCustomPJData", getRootElement(), function(data)
  requestingPjData[source] = nil
  if isElement(source) and data and customPjData[source] then
    if isElement(customPjData[source][2]) then
      destroyElement(customPjData[source][2])
    end
    customPjData[source][2] = dxCreateTexture(data, "dxt1", false)
    dxSetShaderValue(customPjData[source][1], "gTexture", customPjData[source][2])
    handleVehStreamIn(source)
  end
  data = nil
  collectgarbage("collect")
end)
addEvent("paintjobRefreshedOnVehicle", true)
addEventHandler("paintjobRefreshedOnVehicle", getRootElement(), function()
  requestingPjData[source] = nil
  if isElement(source) and customPjData[source] then
    triggerLatentServerEvent("requestCustomPJData", source)
  end
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  local vehicles = getElementsByType("vehicle", getRootElement(), true)
  for i = 1, #vehicles do
    handleVehStreamIn(vehicles[i])
  end
end)
addEventHandler("onClientVehicleDataChange", getRootElement(), function(data, old, new)
  if data == "customPaintjob" then
    if new and isElementStreamedIn(source) then
      handleVehStreamIn(source)
    else
      handleVehStreamDestroy(source)
    end
  end
end)
function handleVehStreamOut(veh)
  if customPjData[veh] then
    customPjData[veh][3] = getTickCount()
  end
end
setTimer(function()
  local now = getTickCount()
  for veh in pairs(customPjData) do
    if customPjData[veh][3] and now - customPjData[veh][3] > 20000 then
      handleVehStreamDestroy(veh)
    end
  end
end, 15000, 0)
function handleVehStreamDestroy(veh)
  if customPjData[veh] then
    if isElement(customPjData[veh][1]) then
      destroyElement(customPjData[veh][1])
    end
    if isElement(customPjData[veh][2]) then
      destroyElement(customPjData[veh][2])
    end
    customPjData[veh] = nil
  end
  requestingPjData[veh] = nil
end
function handleVehStreamIn(veh, force)
  if getElementData(veh, "customPaintjob") and (veh ~= getEditingVeh() or force) then
    if not customPjData[veh] then
      customPjData[veh] = {}
    end
    customPjData[veh][3] = nil
    if not isElement(customPjData[veh][1]) then
      local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
      if not textureNames[model] then
        return
      end
      customPjData[veh][1] = dxCreateShader(changer)
      engineApplyShaderToWorldTexture(customPjData[veh][1], textureNames[model], veh)
      engineApplyShaderToWorldTexture(customPjData[veh][1], "#" .. utf8.sub(textureNames[model], 2), veh)
    end
    if isElement(customPjData[veh][1]) then
      if not isElement(customPjData[veh][2]) then
        if not requestingPjData[veh] then
          requestingPjData[veh] = true
          triggerLatentServerEvent("requestCustomPJData", veh)
        end
      else
        dxSetShaderValue(customPjData[veh][1], "gTexture", customPjData[veh][2])
      end
    end
  end
end
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
  handleVehStreamIn(source)
end)
addEventHandler("onClientVehicleStreamOut", getRootElement(), function()
  handleVehStreamOut(source)
end)
addEventHandler("onClientVehicleDestroy", getRootElement(), function()
  handleVehStreamDestroy(source)
end)
