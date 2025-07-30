local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), processFountain, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), processFountain)
    end
  end
end
local x, y, z = 1479.580078125, -1641.59960937, 18
local water = {}
for k = 1, 18 do
  water[k] = createObject(3515, x + math.cos(math.rad(k * 20)) * 10, y + math.sin(math.rad(k * 20)) * 10, z - 35)
  setElementAlpha(water[k], 0)
  setElementCollisionsEnabled(water[k], false)
end
local water2 = {}
for k = 1, 9 do
  water2[k] = createObject(3515, x + math.cos(math.rad(k * 40)) * 5, y + math.sin(math.rad(k * 40)) * 5, z - 35)
  setElementAlpha(water2[k], 0)
  setElementCollisionsEnabled(water2[k], false)
end
local sl1 = createSearchLight(1488.78174, -1647.34985, 13.5, x, y, z, 0, 20, false)
local sl2 = createSearchLight(1470.41724, -1647.41187, 13.5, x, y, z, 0, 20, false)
local currentWater = 1
local currentWater2 = 9
local sphere = createColSphere(x, y, z, 200)
local sphereCounter = 0
function processFountain()
  if not isElementWithinColShape(localPlayer, sphere) then
    sightlangCondHandl0(false)
  end
  if getTickCount() - sphereCounter > 500 then
    sphereCounter = getTickCount()
    nextFuntain()
  end
  local progress = getTickCount() % 10000 / 5000
  if 1 < progress then
    progress = 2 - progress
  end
  local progress = getEasingValue(progress, "InOutQuad")
  setSearchLightEndPosition(sl1, x, y, z - 1.5 + 3 * progress)
  setSearchLightEndPosition(sl2, x, y, z - 1.5 + 3 * (1 - progress))
end
addEventHandler("onClientColShapeHit", sphere, function(element, dim)
  if dim and element == localPlayer then
    sightlangCondHandl0(true)
  end
end)
function nextFuntain()
  if currentWater < 1 then
    currentWater = currentWater + 1
    if currentWater == 1 then
      for k = 1, 18 do
        setElementPosition(water[k], x + math.cos(math.rad(k * 20)) * 10, y + math.sin(math.rad(k * 20)) * 10, z - 35)
      end
      for k = 1, 9 do
        setElementPosition(water2[k], x + math.cos(math.rad(k * 40)) * 5, y + math.sin(math.rad(k * 40)) * 5, z - 35)
      end
    end
  else
    local k = currentWater
    setElementPosition(water[k], x + math.cos(math.rad(k * 20)) * 10, y + math.sin(math.rad(k * 20)) * 10, z - 35)
    currentWater = currentWater + 1
    local k = currentWater2
    setElementPosition(water2[k], x + math.cos(math.rad(k * 40)) * 5, y + math.sin(math.rad(k * 40)) * 5, z - 35)
    currentWater2 = currentWater2 - 1
    if currentWater2 <= 0 then
      currentWater2 = 9
    end
    k = currentWater2
    setElementPosition(water2[k], x + math.cos(math.rad(k * 40)) * 5, y + math.sin(math.rad(k * 40)) * 5, z - 5)
    if 18 < currentWater then
      currentWater = -3
      for k = 1, 18 do
        setElementPosition(water[k], x + math.cos(math.rad(k * 20)) * 10, y + math.sin(math.rad(k * 20)) * 10, z - 5)
      end
      for k = 1, 9 do
        setElementPosition(water2[k], x + math.cos(math.rad(k * 40)) * 5, y + math.sin(math.rad(k * 40)) * 5, z - 5)
      end
    else
      k = currentWater
      setElementPosition(water[k], x + math.cos(math.rad(k * 20)) * 10, y + math.sin(math.rad(k * 20)) * 10, z - 5)
    end
  end
end
