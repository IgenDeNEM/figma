local sightexports = {sRing = false}
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
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
  if not sightlangWaiterState0 then
    local res0 = getResourceFromName("sRing")
    if res0 and getResourceState(res0) == "running" then
      initSeeRingZone()
      sightlangWaiterState0 = true
    end
  end
end
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end
ringZone = false
local ringInited = false
function getSeeRingZone()
  if ringInited then
    ringZone = sightexports.sRing:getSyncZone()
  end
end
function initSeeRingZone()
  ringInited = true
  getSeeRingZone()
end
addEventHandler("refreshSeeringZone", getRootElement(), getSeeRingZone)
local oldzone = getZoneName
local zoneRename = {
  ["Easter Bay Airport"] = "SightRing versenypálya"
}
function getZoneName(x, y, z, city)
  local zone = "Ismeretlen"
  if -1748 <= x and x <= -811 and -722 <= y and y <= 600 and ringZone and isInsideColShape(ringZone, x, y, 0) then
    return "SightRing versenypálya"
  end
  if -1309 <= x and x <= -1239 and 2240 <= y and y <= 2346 then
    return "Dance Pavilion"
  end
  if -1348 <= x and x <= -1281 and 2477 <= y and y <= 2562 then
    return "Körnitársaság"
  end
  if not (-510 < x) or not (620 < y) then
    zone = oldzone(x, y, z, city)
  end
  if zoneRename[zone] then
    zone = zoneRename[zone]
  end
  if zone == "Unknown" then
    zone = "Ismeretlen"
  end
  return zone
end
