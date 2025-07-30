local sightexports = {
  sCore = false,
  sControls = false,
  sModloader = false
}
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
local sightlangModloaderLoaded = function()
  modloaderListener()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
  addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState2 then
    sightlangCondHandlState2 = cond
    if cond then
      addEventHandler("onClientPreRender", getRootElement(), shieldCheckDuck, true, prio)
    else
      removeEventHandler("onClientPreRender", getRootElement(), shieldCheckDuck)
    end
  end
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState1 then
    sightlangCondHandlState1 = cond
    if cond then
      addEventHandler("onClientRender", getRootElement(), renderShields, true, prio)
    else
      removeEventHandler("onClientRender", getRootElement(), renderShields)
    end
  end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
  cond = cond and true or false
  if cond ~= sightlangCondHandlState0 then
    sightlangCondHandlState0 = cond
    if cond then
      addEventHandler("onClientPedsProcessed", getRootElement(), pedsProcessShields, true, prio)
    else
      removeEventHandler("onClientPedsProcessed", getRootElement(), pedsProcessShields)
    end
  end
end
local shields = {}
local modloaderReady = false
function getPositionFromElementOffset(element, offX, offY, offZ)
  local m = getElementMatrix(element)
  local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
  local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
  local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
  return x, y, z
end
function reverseMatrix(m, x, y, z)
  return (-m[2][1] * m[3][2] * z + m[2][1] * m[3][3] * y - m[2][2] * m[3][3] * x + m[2][2] * m[3][1] * z + m[3][2] * m[2][3] * x - m[2][3] * m[3][1] * y) / (-m[1][1] * m[2][2] * m[3][3] + m[1][1] * m[3][2] * m[2][3] - m[1][3] * m[2][1] * m[3][2] + m[1][3] * m[2][2] * m[3][1] + m[2][1] * m[3][3] * m[1][2] - m[1][2] * m[2][3] * m[3][1]), (m[1][1] * m[3][2] * z - m[1][1] * m[3][3] * y - m[1][3] * m[3][2] * x + m[1][3] * m[3][1] * y + m[3][3] * m[1][2] * x - m[1][2] * m[3][1] * z) / (-m[1][1] * m[2][2] * m[3][3] + m[1][1] * m[3][2] * m[2][3] - m[1][3] * m[2][1] * m[3][2] + m[1][3] * m[2][2] * m[3][1] + m[2][1] * m[3][3] * m[1][2] - m[1][2] * m[2][3] * m[3][1]), (-m[1][1] * m[2][2] * z + m[1][1] * m[2][3] * y - m[1][3] * m[2][1] * y + m[1][3] * m[2][2] * x + m[2][1] * m[1][2] * z - m[1][2] * m[2][3] * x) / (-m[1][1] * m[2][2] * m[3][3] + m[1][1] * m[3][2] * m[2][3] - m[1][3] * m[2][1] * m[3][2] + m[1][3] * m[2][2] * m[3][1] + m[2][1] * m[3][3] * m[1][2] - m[1][2] * m[2][3] * m[3][1])
end
function pedsProcessShields()
  local c = 0
  for client, v in pairs(shields) do
    if isElement(client) and isElement(v) then
      local posX, posY, posZ = getPositionFromElementOffset(client, 0, 0.7, 0)
      local rotX, rotY, rotZ = getElementRotation(client)
      if not isPedDucked(client) then
        local baseBone, otx, oty, otz = 30, posX, posY, posZ
        if baseBone and otx and isElementOnScreen(client) then
          local m = getElementBoneMatrix(client, baseBone + 1)
          local x1, y1, z1 = getElementBonePosition(client, baseBone + 2)
          local rx, ry, rz = getElementRotation(client)
          tx, ty, tz = getPositionFromElementOffset(v, -0.3514, -0.1404, 0.2323)
          m[4][1] = x1
          m[4][2] = y1
          m[4][3] = z1
          local x2, y2, z2 = getElementBonePosition(client, baseBone + 3)
          local x3, y3, z3 = getElementBonePosition(client, baseBone + 4)
          local x, y, z = reverseMatrix(m, tx - x1, ty - y1, tz - z1)
          local deg = math.deg(math.atan2(y, x))
          local deg2 = math.deg(math.atan2(-z, math.sqrt(x * x + y * y)))
          local l1 = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
          local l2 = getDistanceBetweenPoints3D(x2, y2, z2, x3, y3, z3)
          local l3 = math.sqrt(x * x + y * y + z * z)
          local joint2 = 180
          if l3 < l1 + l2 then
            joint2 = math.deg(math.acos((l1 * l1 + l2 * l2 - l3 * l3) / (2 * l1 * l2)))
          end
          if tonumber(deg) and tonumber(deg2) and tonumber(joint2) and deg == deg and deg2 == deg2 and joint2 == joint2 then
            setElementBoneRotation(client, baseBone + 2, 0, deg + (180 - joint2) / 2, deg2)
            setElementBoneRotation(client, baseBone + 3, 0, -(180 - joint2), 0)
            setElementBoneRotation(client, baseBone + 4, 20 < baseBone and 270 or 90, 0, 0)
          end
          baseBone = 20
          local m = getElementBoneMatrix(client, baseBone + 1)
          local x1, y1, z1 = getElementBonePosition(client, baseBone + 2)
          tx, ty, tz = getPositionFromElementOffset(v, 0.3514, -0.1404, 0.2323)
          m[4][1] = x1
          m[4][2] = y1
          m[4][3] = z1
          local x2, y2, z2 = getElementBonePosition(client, baseBone + 3)
          local x3, y3, z3 = getElementBonePosition(client, baseBone + 4)
          local x, y, z = reverseMatrix(m, tx - x1, ty - y1, tz - z1)
          local deg = math.deg(math.atan2(y, x))
          local deg2 = math.deg(math.atan2(-z, math.sqrt(x * x + y * y)))
          local l1 = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
          local l2 = getDistanceBetweenPoints3D(x2, y2, z2, x3, y3, z3)
          local l3 = math.sqrt(x * x + y * y + z * z)
          local joint2 = 180
          if l3 < l1 + l2 then
            joint2 = math.deg(math.acos((l1 * l1 + l2 * l2 - l3 * l3) / (2 * l1 * l2)))
          end
          if tonumber(deg) and tonumber(deg2) and tonumber(joint2) and deg == deg and deg2 == deg2 and joint2 == joint2 then
            setElementBoneRotation(client, baseBone + 2, 0, deg + (180 - joint2) / 2, deg2)
            setElementBoneRotation(client, baseBone + 3, 0, -(180 - joint2), 0)
            setElementBoneRotation(client, baseBone + 4, 20 < baseBone and 270 or 90, 0, 0)
          end
          sightexports.sCore:updateElementRpHAnim(client)
        end
      end
      c = c + 1
    else
      shields[client] = nil
    end
  end
  local vehs = getElementsByType("vehicle", getRootElement(), true)
  for i = 1, #vehs do
    for player, shield in pairs(shields) do
      setElementCollidableWith(vehs[i], shield, false)
    end
  end
  for player, shield in pairs(shields) do
    if player ~= localPlayer then
      setElementCollidableWith(localPlayer, shield, false)
    end
  end
  sightlangCondHandl0(0 < c)
end
function renderShields()
  local c = 0
  for client, v in pairs(shields) do
    if isElement(client) and isElement(v) then
      local posX, posY, posZ = getPositionFromElementOffset(client, 0, 0.7, 0)
      local rotX, rotY, rotZ = getElementRotation(client)
      if isPedDucked(client) then
        posZ = posZ - 0.25
        setElementRotation(v, 15, 0, rotZ)
      else
        setElementRotation(v, 0, 0, rotZ)
      end
      setElementPosition(v, posX, posY, posZ)
      setElementDimension(v, getElementDimension(client))
      setElementInterior(v, getElementInterior(client))
      c = c + 1
    else
      shields[client] = nil
    end
  end
  sightlangCondHandl1(0 < c)
end
local walkDisabled = false
function shieldCheckDuck()
  if isPedDucked(localPlayer) then
    if not walkDisabled then
      sightexports.sControls:toggleControl({
        "forwards",
        "backwards",
        "left",
        "right"
      }, false)
      walkDisabled = true
    end
  elseif walkDisabled then
    sightexports.sControls:toggleControl({
      "forwards",
      "backwards",
      "left",
      "right"
    }, true)
    walkDisabled = false
  end
end
function getMyShield()
  return shields[localPlayer]
end
function processShield(player, val)
  if shields[player] then
    if isElement(shields[player]) then
      destroyElement(shields[player])
    end
    shields[player] = nil
    shields[player] = nil
    if player == localPlayer then
      sightexports.sControls:toggleControl({
        "forwards",
        "backwards",
        "left",
        "right"
      }, true)
      walkDisabled = false
      sightlangCondHandl2(false)
    end
  end
  if val and modloaderReady then
    local x, y, z = getElementPosition(player)
    local shield = createObject(sightexports.sModloader:getModelId("police_shield"), x, y, z)
    shields[player] = shield
    sightlangCondHandl1(true)
    sightlangCondHandl0(true)
    if player == localPlayer then
      sightlangCondHandl2(true)
    end
  else
    shields[player] = true
  end
end
function modloaderListener()
  modloaderReady = true
  for player in pairs(shields) do
    processShield(player, shields[player])
  end
end
addEventHandler("onClientElementDataChange", getRootElement(), function(dataName, oldValue, newValue)
  if dataName == "shield" then
    processShield(source, newValue)
  end
end)
addEventHandler("onElementStreamIn", getRootElement(), function()
  processShield(soure)
end)
addEventHandler("onElementStreamOut", getRootElement(), function()
  processShield(source, nil)
end)
addEvent("onShieldDestroy", true)
addEventHandler("onShieldDestroy", getRootElement(), function()
  local x, y, z = getElementPosition(source)
  fxAddDebris(x, y, z, 10, 10, 10, 255, 0.05, 10)
  local sound = playSound3D("files/destroyed.wav", x, y, z)
  setSoundMaxDistance(sound, 30)
  setElementInterior(sound, getElementInterior(source))
  setElementDimension(sound, getElementDimension(source))
end)