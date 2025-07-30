local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), preRenderDoors, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), preRenderDoors)
    end
  end
end
local lsdDoor = {}
local moonBeams = {}
local doorCoordinates = {}
addEventHandler("onClientVehicleDataChange", getRootElement(), function(key, old, new)
  if key == "lsdDoor" and isElementStreamedIn(source) then
    lsdDoor[source] = new and true or nil
    if new then
      sightlangCondHandl0(true)
    end
  end
end)
function streamOutDoor()
  lsdDoor[source] = nil
  moonBeams[source] = nil
end
addEventHandler("onClientVehicleDestroy", getRootElement(), streamOutDoor)
addEventHandler("onClientVehicleStreamOut", getRootElement(), streamOutDoor)
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
  if getElementData(source, "lsdDoor") then
    lsdDoor[source] = true
    sightlangCondHandl0(true)
  end
  if getElementModel(source) == 418 then
    moonBeams[source] = true
    sightlangCondHandl0(true)
  end
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
  local vehicles = getElementsByType("vehicle", getRootElement(), true)
  for k = 1, #vehicles do
    if getElementData(vehicles[k], "lsdDoor") then
      lsdDoor[vehicles[k]] = true
      sightlangCondHandl0(true)
    end
    if getElementModel(vehicles[k]) == 418 then
      moonBeams[vehicles[k]] = true
      sightlangCondHandl0(true)
    end
  end
end)
local componentNames = {
  [2] = "door_lf_dummy",
  [3] = "door_rf_dummy"
}
lsdPreview = false
function preRenderDoors()
  for veh in pairs(lsdDoor) do
    if isElementOnScreen(veh) and lsdPreview ~= veh then
      for i = 2, 3 do
        local ratio = getVehicleDoorOpenRatio(veh, i)
        local dir = i == 3 and -1 or 1
        setVehicleComponentRotation(veh, componentNames[i], -45 * ratio, 5 * dir * ratio, -40 * dir * ratio)
      end
    end
  end
  for v in pairs(moonBeams) do
    if isElementOnScreen(v) then
      if getElementModel(v) ~= 418 then
        moonBeams[v] = nil
      else
        for i = 4, 5 do
          local p = getVehicleDoorOpenRatio(v, i)
          p = getEasingValue(p, "InOutQuad")
          local compent = false
          local x, y, z = -1.024099946022, 0.093099996447563, 0.14896002411842
          local m = 1
          if i == 5 then
            m = -1
            compent = "door_rr_dummy"
          else
            compent = "door_lr_dummy"
          end
          setVehicleComponentRotation(v, compent, 0, 0, 0)
          setVehicleComponentPosition(v, compent, (x - 0.1 * p) * m, y - 1.1 * p, z)
        end
      end
    end
  end
  if lsdPreview and isElement(lsdPreview) then
    for i = 2, 3 do
      local dir = i == 3 and -1 or 1
      setVehicleComponentRotation(lsdPreview, componentNames[i], -45, 5 * dir, -40 * dir)
    end
    return
  end
  for veh in pairs(lsdDoor) do
    return
  end
  for veh in pairs(moonBeams) do
    return
  end
  sightlangCondHandl0(false)
end
