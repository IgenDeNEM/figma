local sightexports = {sCarshop = false}
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
slideAnimationTime = 2564
rotateAnimationTime = 1200
carAnimationTime = 4150
impoundPositions = {
  {
    1755.6689453125,
    -2059.0634765625,
    1747.3261718725,
    -2067.4853515625,
    12.55
  },
  {
    -2108.6015625,
    -19.3564453125,
    -2116.94433594,
    -27.7783203125,
    34.33,
    true
  },
  { --PD
    1607.9615234375,
    -1623.119140625,
    1599.6187499975001,
    -1631.541015625,
    12.555735351562,
    true
  }
}
lawEnforcementPrefix = "PD"
minX, minY = 1747.326171875, -2067.4853515625
maxX, maxY = 1755.6689453125, -2059.0634765625
zoneZ = 12.55
unImpoundPrice = 7500
impoundReward = math.floor(unImpoundPrice * 0.5)
function getElementMatrix(element)
  local rx, ry, rz = getElementRotation(element, "ZXY")
  rx, ry, rz = math.rad(rx), math.rad(ry), math.rad(rz)
  local matrix = {}
  matrix[1] = {}
  matrix[1][1] = math.cos(rz) * math.cos(ry) - math.sin(rz) * math.sin(rx) * math.sin(ry)
  matrix[1][2] = math.cos(ry) * math.sin(rz) + math.cos(rz) * math.sin(rx) * math.sin(ry)
  matrix[1][3] = -math.cos(rx) * math.sin(ry)
  matrix[1][4] = 1
  matrix[2] = {}
  matrix[2][1] = -math.cos(rx) * math.sin(rz)
  matrix[2][2] = math.cos(rz) * math.cos(rx)
  matrix[2][3] = math.sin(rx)
  matrix[2][4] = 1
  matrix[3] = {}
  matrix[3][1] = math.cos(rz) * math.sin(ry) + math.cos(ry) * math.sin(rz) * math.sin(rx)
  matrix[3][2] = math.sin(rz) * math.sin(ry) - math.cos(rz) * math.cos(ry) * math.sin(rx)
  matrix[3][3] = math.cos(rx) * math.cos(ry)
  matrix[3][4] = 1
  matrix[4] = {}
  matrix[4][1], matrix[4][2], matrix[4][3] = getElementPosition(element)
  matrix[4][4] = 1
  return matrix
end
function getPositionFromElementOffset(element, offX, offY, offZ)
  local m = getElementMatrix(element)
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z
end
function calculateUnimpound(vehicleId)
  local price = sightexports.sCarshop:getCarshopPrice(vehicleId) or 0
  return math.max(5000, math.floor(price * 0.02))
end
allowedVehicleTypes = {
  Automobile = true,
  Quad = true,
  Bike = true
}
