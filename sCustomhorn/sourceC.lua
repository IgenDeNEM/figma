local sightexports = {sControls = false}
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
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), renderHorn, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), renderHorn)
    end
  end
end
local hornState = false
local currVehicle = false
local monitoredKeys = {}
local disabled = false
addEventHandler("onClientVehicleEnter", getRootElement(), function(thePlayer, seat)
  if thePlayer == localPlayer and seat == 0 then
    local horn = getElementData(source, "customHorn") or 0
    if getElementModel(source) == 472 or getElementModel(source) == 595 or getElementModel(source) == 484 or getElementModel(source) == 430 or getElementModel(source) == 453 or getElementModel(source) == 454 then
      horn = 8
    end
    if 1 <= horn then
      sightexports.sControls:toggleControl({"horn"}, false)
      disabled = true
      sightlangCondHandl0(true)
      currVehicle = source
      hornState = false
      monitoredKeys = {}
      for k in pairs(getBoundKeys("horn")) do
        table.insert(monitoredKeys, k)
      end
    end
  end
end)
local lastTurnOn = 0
function renderHorn()
  local veh = getPedOccupiedVehicle(localPlayer)
  if currVehicle ~= veh and disabled then
    if isElement(currVehicle) then
      setElementData(currVehicle, "hornState", nil)
    end
    currVehicle = false
    disabled = false
    sightexports.sControls:toggleControl({"horn"}, true)
    sightlangCondHandl0(false)
    return
  end
  local currHorn = false
  if not isCursorShowing() and not isChatBoxInputActive() and not isConsoleActive() then
    for k = 1, #monitoredKeys do
      if getKeyState(monitoredKeys[k]) then
        currHorn = true
        break
      end
    end
  end
  if hornState ~= currHorn then
    hornState = currHorn
    if hornState and getTickCount() - lastTurnOn <= 100 then
      return
    end
    lastTurnOn = getTickCount()
    setElementData(currVehicle, "hornState", hornState)
  end
end
local sounds = {}
addEventHandler("onClientVehicleDestroy", getRootElement(), function()
  if isElement(sounds[source]) then
    destroyElement(sounds[source])
  end
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
  local veh = getPedOccupiedVehicle(source)
  if veh and sounds[veh] then
    destroyElement(sounds[veh])
    setElementData(veh, "hornState", nil)
  end
end)
function playHornForVeh(veh, id)
  if isElement(sounds[veh]) then
    destroyElement(sounds[veh])
  end
  if id then
    sounds[veh] = playSound3D("horns/" .. id .. ".wav", 0, 0, 0, false)
    setSoundVolume(sounds[veh], 1.5)
    setSoundEffectEnabled(sounds[veh], "i3dl2reverb", true)
    setSoundMinDistance(sounds[veh], 10)
    setSoundMaxDistance(sounds[veh], 60)
    setElementDimension(sounds[veh], getElementDimension(veh))
    setElementInterior(sounds[veh], getElementInterior(veh))
    attachElements(sounds[veh], veh)
  else
    sounds[veh] = nil
  end
end
addEventHandler("onClientVehicleDataChange", getRootElement(), function(data)
  if data == "customHorn" and source == currVehicle then
    if disabled then
      disabled = false
      sightexports.sControls:toggleControl({"horn"}, true)
      sightlangCondHandl0(false)
      setElementData(source, "hornState", nil)
    end
    local horn = getElementData(source, "customHorn") or 0
    if 1 <= horn then
      sightexports.sControls:toggleControl({"horn"}, false)
      disabled = true
      sightlangCondHandl0(true)
      vehicle = source
      hornState = false
      monitoredKeys = {}
      for k in pairs(getBoundKeys("horn")) do
        table.insert(monitoredKeys, k)
      end
    end
  end
  if data == "hornState" then
    if isElement(sounds[source]) then
      destroyElement(sounds[source])
    end
    sounds[source] = nil
    local state = getElementData(source, data)
    if state and isElementStreamedIn(source) then
      local horn = false
      if getElementModel(source) == 472 or getElementModel(source) == 595 or getElementModel(source) == 484 or getElementModel(source) == 430 or getElementModel(source) == 453 or getElementModel(source) == 454 then
        horn = 8
      else
        horn = getElementData(source, "customHorn")
      end
      if horn then
        sounds[source] = playSound3D("horns/" .. horn .. ".wav", 0, 0, 0, true)
        setSoundVolume(sounds[source], 1.5)
        setSoundEffectEnabled(sounds[source], "i3dl2reverb", true)
        setSoundMinDistance(sounds[source], 10)
        setSoundMaxDistance(sounds[source], 60)
        setElementDimension(sounds[source], getElementDimension(source))
        setElementInterior(sounds[source], getElementInterior(source))
        attachElements(sounds[source], source)
        if getElementModel(source) == 472 or getElementModel(source) == 595 or getElementModel(source) == 484 or getElementModel(source) == 430 or getElementModel(source) == 453 or getElementModel(source) == 454 then
          setSoundMaxDistance(sounds[source], 150)
        end
      end
    end
  end
end)
