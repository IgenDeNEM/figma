local sightexports = {sHud = false, sWebdebug = false}
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
local controlStates = {
  fire = {},
  next_weapon = {},
  previous_weapon = {},
  forwards = {},
  backwards = {},
  left = {},
  right = {},
  zoom_in = {},
  zoom_out = {},
  jump = {},
  sprint = {},
  jog = {},
  look_behind = {},
  crouch = {},
  action = {},
  walk = {},
  aim_weapon = {},
  conversation_yes = {},
  conversation_no = {},
  group_control_forwards = {},
  group_control_back = {},
  enter_exit = {},
  vehicle_fire = {},
  vehicle_secondary_fire = {},
  vehicle_left = {},
  vehicle_right = {},
  steer_forward = {},
  steer_back = {},
  accelerate = {},
  brake_reverse = {},
  radio_next = {},
  radio_previous = {},
  radio_user_track_skip = {},
  horn = {},
  sub_mission = {},
  handbrake = {},
  vehicle_look_left = {},
  vehicle_look_right = {},
  vehicle_look_behind = {},
  vehicle_mouse_look = {},
  special_control_left = {},
  special_control_right = {},
  special_control_down = {},
  special_control_up = {},
  enter_passenger = {},
  radar = {}
}
local disabled = {}
local _toggleControl = toggleControl
local sprint = true
local jog = true
function refreshSprintControls()
  local ts = #controlStates.sprint <= 0
  local tj = 0 >= #controlStates.jog
  if ts ~= sprint or tj ~= jog then
    sprint = ts
    jog = tj
    sightexports.sHud:sprintControls(sprint, jog)
  end
end
function toggleControl(theControl, state, sourceResourceName)
  local resourceName = sourceResourceName or getResourceName(sourceResource)
  if type(theControl) == "table" then
    for key, name in pairs(theControl) do
      if name == "enter_exit" then
        toggleControl("enter_passenger", state, resourceName)
      elseif name == "jog" then
        toggleControl("sprint", state, resourceName)
      end
      if state then
        if controlStates[name] then
          for k, v in ipairs(controlStates[name]) do
            if v == resourceName then
              table.remove(controlStates[name], k)
            end
          end
        end
      elseif controlStates[name] then
        for k, v in ipairs(controlStates[name]) do
          if v == resourceName then
            return
          end
        end
        table.insert(controlStates[name], resourceName)
        setPedControlState(localPlayer, name, false)
      end
    end
  else
    local name = theControl
    if name == "enter_exit" then
      toggleControl("enter_passenger", state, resourceName)
    elseif name == "jog" then
      toggleControl("sprint", state, resourceName)
    end
    if state then
      if controlStates[name] then
        for k, v in ipairs(controlStates[name]) do
          if v == resourceName then
            table.remove(controlStates[name], k)
          end
        end
      end
    elseif controlStates[name] then
      for k, v in ipairs(controlStates[name]) do
        if v == resourceName then
          return
        end
      end
      table.insert(controlStates[name], resourceName)
      setPedControlState(localPlayer, name, false)
    end
  end
  refreshSprintControls()
end
addEvent("toggleControl", true)
addEventHandler("toggleControl", root, function(...)
  toggleControl(...)
end)
function toggleAllControls(state, sourceResourceName)
  local resourceName = sourceResourceName or getResourceName(sourceResource)
  if not state then
    for i in pairs(controlStates) do
      local found = false
      for k, v in ipairs(controlStates[i]) do
        if v == resourceName then
          found = true
        end
      end
      if not found then
        table.insert(controlStates[i], resourceName)
        setPedControlState(localPlayer, i, false)
      end
    end
  else
    for i in pairs(controlStates) do
      for k, v in ipairs(controlStates[i]) do
        if v == resourceName then
          table.remove(controlStates[i], k)
        end
      end
    end
  end
  refreshSprintControls()
end
addEvent("toggleAllControls", true)
addEventHandler("toggleAllControls", root, function(state, sourceResourceName)
  toggleAllControls(state, sourceResourceName)
end)
--[[addCommandHandler("debugcontrols", function()
  for k, v in pairs(controlStates) do
    if 0 < #v then
      outputChatBox(k .. ": ")
      for i = 1, #v do
        outputChatBox("  " .. v[i])
      end
    end
  end
end)--]]
addEventHandler("onClientPreRender", root, function()
  for k, v in pairs(controlStates) do
    if k ~= "jog" then
      if 0 < #v then
        if k == "crouch" and isPedDucked(localPlayer) then
          _toggleControl(k, true)
          setPedControlState(localPlayer, k, true)
        else
          _toggleControl(k, false)
        end
      else
        _toggleControl(k, true)
      end
    end
  end
  if not getPedControlState(localPlayer, "aim_weapon") then
    local wp = getPedWeapon(localPlayer)
    if wp and 22 <= wp and wp <= 38 then
      _toggleControl("fire", false)
    end
  end
end)
addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(veh)
  if getVehicleType(veh) == "Plane" or getVehicleType(veh) == "Helicopter" then
    toggleControl({
      "vehicle_look_left",
      "vehicle_look_right"
    }, true, "default")
  end
end)
addEventHandler("onClientPlayerVehicleExit", localPlayer, function(veh)
  toggleControl({
    "vehicle_look_left",
    "vehicle_look_right"
  }, false, "default")
end)
toggleControl({
  "next_weapon",
  "previous_weapon",
  "action",
  "radar"
}, false, "default")
