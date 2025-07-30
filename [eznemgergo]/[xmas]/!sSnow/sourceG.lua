-- filename:
-- version: lua51
-- line: [0, 0] id: 0
local r0_0 = {
  sVehicles = false,
}
local function r1()
  -- line: [1, 1] id: 1
  for r3 in pairs(r0_0) do
    local r4 = getResourceFromName(r3)
    if r4 and getResourceState(r4) == "running" then
      r0_0[r3] = exports[r3]
    else
      r0_0[r3] = false
    end
  end
end
r1()
if triggerServerEvent then
  addEventHandler("onClientResourceStart", getRootElement(), r1, true, "high+9999999999")
end
if triggerClientEvent then
  addEventHandler("onResourceStart", getRootElement(), r1, true, "high+9999999999")
end
function refreshVehicleWinter(r0)
  -- line: [1, 3] id: 2
  r0_0.sVehicles:checkWinterVeh(r0)
end
addEventHandler("onElementDimensionChange", getRootElement(), function(r0, r1)
  -- line: [6, 10] id: 3
  if getElementType(source) == "vehicle" then
    refreshVehicleWinter(source)
  end
end)
inSnow = false
function checkPlayerInSnow()
  -- line: [14, 16] id: 4
  inSnow = checkWinterCol(localPlayer)
end
local r2_0 = createColSphere(-2690, 2450, 18.486911773682, 550)
local r3_0 = createColPolygon(2273.3486328125, 432.1845703125, 2273.3486328125, 432.1845703125, 2104.4248046875, 510.5732421875, 1775.7509765625, 515.6962890625, 1558.2548828125, 536.0595703125, 1251.4384765625, 602.2041015625, 1152.5224609375, 626.626953125, 896.330078125, 590.8544921875, 507.1748046875, 508.091796875, -168.45703125, 366.2958984375, -629.8525390625, 360, -907.244140625, 591.77734375, -1500, 653.8271484375, -2400, -200, -2000, -1300, -1255.0390625, -1500, -77.7431640625, -1500, 2417.400390625, -1500)
addEventHandler("onVehicleColShapeHit", r3_0, refreshVehicleWinter)
addEventHandler("onVehicleColShapeLeave", r3_0, refreshVehicleWinter)
addEventHandler("onVehicleColShapeHit", r2_0, refreshVehicleWinter)
addEventHandler("onVehicleColShapeLeave", r2_0, refreshVehicleWinter)
addEventHandler("onClientLocalColShapeHit", r3_0, checkPlayerInSnow)
addEventHandler("onClientLocalColShapeLeave", r3_0, checkPlayerInSnow)
addEventHandler("onClientLocalColShapeHit", r2_0, checkPlayerInSnow)
addEventHandler("onClientLocalColShapeLeave", r2_0, checkPlayerInSnow)
function checkWinterCol(r0)
  -- line: [80, 82] id: 5
  local r1 = isElementWithinColShape(r0, r2_0)
  if not r1 then
    r1 = isElementWithinColShape(r0, r3_0) and getElementDimension(r0) == 0
  end
  return r1
end
if localPlayer then
  checkPlayerInSnow()
end
