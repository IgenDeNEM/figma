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
local firstFreq = false
local secondFreq = false
addEvent("gotWalkieTalkieFrequencies", true)
addEventHandler("gotWalkieTalkieFrequencies", getRootElement(), function(f1, f2)
  firstFreq = f1
  secondFreq = f2
end)
function radioCommand(cmd, ...)
  if not (...) then
    outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. cmd .. " [Üzenet]", 255, 255, 255, true)
  else
    local message = table.concat({
      ...
    }, " ")
    if utfLen(message) > 0 then
      local transmitFreq = false
      if cmd == "r" then
        transmitFreq = firstFreq
      elseif cmd == "r2" then
        transmitFreq = secondFreq
      else
        transmitFreq = firstFreq or secondFreq
      end
      if transmitFreq then
        local playersTable = {}
        local sourcePlayerName = utf8.gsub(getElementData(localPlayer, "visibleName"), "_", " ")
        local sourceX, sourceY, sourceZ = getElementPosition(localPlayer)
        local veh = getPedOccupiedVehicle(localPlayer)
        if veh and not getElementData(veh, "vehicle.windowState") then
          for k, v in pairs(getVehicleOccupants(veh)) do
            if v ~= localPlayer then
              table.insert(playersTable, {v, "#FFFFFF"})
            end
          end
        else
          local players = getElementsByType("player", getRootElement(), true)
          for k = 1, #players do
            local v = players[k]
            if v ~= localPlayer then
              local targetX, targetY, targetZ = getElementPosition(v)
              local max = 12
              local vh = getPedOccupiedVehicle(v)
              if vh and not getElementData(vh, "vehicle.windowState") then
                max = 8
              end
              if max >= getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) then
                local color = 255
                color = 255 - 205 * (getDistanceBetweenPoints3D(sourceX, sourceY, sourceZ, targetX, targetY, targetZ) / max)
                table.insert(playersTable, {
                  v,
                  string.format("#%.2X%.2X%.2X", color, color, color)
                })
              end
            end
          end
        end
        triggerServerEvent("sendWalkieTalkieMessage", localPlayer, playersTable, transmitFreq, firstToUpper(message), cmd)
      elseif cmd == "r" then
        outputChatBox("[color=sightblue][SightMTA - Rádió]: #ffffffNincs frekvencia beállítva!", 255, 255, 255, true)
        outputChatBox("[color=sightblue][SightMTA - Rádió]: #ffffffHasználd a [color=sightblue]/tuneradio#ffffff parancsot.", 255, 255, 255, true)
      elseif cmd == "r2" then
        outputChatBox("[color=sightblue][SightMTA - Rádió]: #ffffffNincs frekvencia beállítva!", 255, 255, 255, true)
        outputChatBox("[color=sightblue][SightMTA - Rádió]: #ffffffHasználd a [color=sightblue]/tuneradio2#ffffff parancsot.", 255, 255, 255, true)
      else
        outputChatBox("[color=sightblue][SightMTA - Rádió]: #ffffffNincs frekvencia beállítva!", 255, 255, 255, true)
        outputChatBox("[color=sightblue][SightMTA - Rádió]: #ffffffHasználd a [color=sightblue]/tuneradio#ffffff vagy [color=sightblue]/tuneradio2#ffffff parancsot.", 255, 255, 255, true)
      end
    else
      outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. cmd .. " [Üzenet]", 255, 255, 255, true)
    end
  end
end
addCommandHandler("r", radioCommand)
addCommandHandler("teamsay", radioCommand)
addCommandHandler("r2", radioCommand)
local currentShare = {}
addEvent("syncFactionBlips", true)
addEventHandler("syncFactionBlips", getRootElement(), function(data)
  local show = false
  for i = 1, #departmentGroups do
    if isPlayerInGroup(departmentGroups[i]) then
      show = true
    end
  end
  if not show then
    return
  end
  for cid, value in pairs(data) do
    if isElement(currentShare[cid]) then
      destroyElement(currentShare[cid])
    end
    currentShare[cid] = nil
    currentShare[cid] = nil
    local r, g, b = unpack(sightexports.sGui:getColorCode(value[5]))
    currentShare[cid] = createBlip(value[2], value[3], value[4], 21, 2, r, g, b)
    setElementData(currentShare[cid], "tooltipText", value[1])
  end
end)
addEvent("createFactionBlip", true)
addEventHandler("createFactionBlip", getRootElement(), function(data)
  local show = false
  for i = 1, #departmentGroups do
    if isPlayerInGroup(departmentGroups[i]) then
      show = true
    end
  end
  if show then
    local cid = data[1]
    local r, g, b = unpack(sightexports.sGui:getColorCode(data[6]))
    currentShare[cid] = createBlip(data[3], data[4], data[5], 21, 2, r, g, b)
    setElementData(currentShare[cid], "tooltipText", data[2])
  end
end)
addEvent("deleteFactionBlip", true)
addEventHandler("deleteFactionBlip", getRootElement(), function(cid)
  if isElement(currentShare[cid]) then
    destroyElement(currentShare[cid])
  end
  currentShare[cid] = nil
  currentShare[cid] = nil
end)
