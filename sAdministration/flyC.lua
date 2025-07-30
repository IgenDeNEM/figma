local sightexports = {sPermission = false}
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
local flyingState = false
local keys = {}
keys.up = "up"
keys.down = "up"
keys.f = "up"
keys.b = "up"
keys.l = "up"
keys.r = "up"
keys.a = "up"
keys.s = "up"
function triggerFly()
  if sightexports.sPermission:hasPermission(localPlayer, "fly") then
    triggerEvent("onClientFlyToggle", getRootElement(), not flyingState)
  end
end
addCommandHandler("fly", triggerFly)
function getFly()
  return flyingState
end
addEvent("onClientFlyToggle", true)
addEventHandler("onClientFlyToggle", getRootElement(), function(state)
  flyingState = state
  if flyingState then
    setElementData(localPlayer, "flyState", true)
    addEventHandler("onClientRender", getRootElement(), flyingRender)
    bindKey("lshift", "both", keyH)
    bindKey("rshift", "both", keyH)
    bindKey("lctrl", "both", keyH)
    bindKey("rctrl", "both", keyH)
    bindKey("forwards", "both", keyH)
    bindKey("backwards", "both", keyH)
    bindKey("left", "both", keyH)
    bindKey("right", "both", keyH)
    bindKey("lalt", "both", keyH)
    bindKey("space", "both", keyH)
    bindKey("ralt", "both", keyH)
    bindKey("w", "both", keyH)
    bindKey("a", "both", keyH)
    bindKey("s", "both", keyH)
    bindKey("d", "both", keyH)

    if not getPedOccupiedVehicle(getLocalPlayer()) then
      setElementCollisionsEnabled(getLocalPlayer(), false)
    else
      setElementCollisionsEnabled(getPedOccupiedVehicle(getLocalPlayer()), false)
      setElementFrozen(getPedOccupiedVehicle(getLocalPlayer()), false)
      local carRot = {getElementRotation(getPedOccupiedVehicle(getLocalPlayer()))}
      setElementRotation(getPedOccupiedVehicle(getLocalPlayer()), 0, 0, carRot[3])
    end
  else
    setElementData(localPlayer, "flyState", false)
    removeEventHandler("onClientRender", getRootElement(), flyingRender)
    unbindKey("lshift", "both", keyH)
    unbindKey("rshift", "both", keyH)
    unbindKey("lctrl", "both", keyH)
    unbindKey("rctrl", "both", keyH)
    unbindKey("forwards", "both", keyH)
    unbindKey("backwards", "both", keyH)
    unbindKey("left", "both", keyH)
    unbindKey("right", "both", keyH)
    unbindKey("space", "both", keyH)
    unbindKey("w", "both", keyH)
    unbindKey("a", "both", keyH)
    unbindKey("s", "both", keyH)
    unbindKey("d", "both", keyH)
    keys.up = "up"
    keys.down = "up"
    keys.f = "up"
    keys.b = "up"
    keys.l = "up"
    keys.r = "up"
    keys.a = "up"
    keys.s = "up"

    if not getPedOccupiedVehicle(getLocalPlayer()) then
      setElementCollisionsEnabled(getLocalPlayer(), true)
    else
      setElementCollisionsEnabled(getPedOccupiedVehicle(getLocalPlayer()), true)
      setElementFrozen(getPedOccupiedVehicle(getLocalPlayer()), false)
    end
  end
end)

function flyingRender()
  local veh = getPedOccupiedVehicle(getLocalPlayer())

  if veh then
    local speed_multiplier = 1.0
    if getKeyState("mouse1") then
        speed_multiplier = 5.0
    elseif getKeyState("lshift") or getKeyState("rshift") then
        speed_multiplier = 3.0
    elseif getKeyState("lalt") or getKeyState("ralt") then
        speed_multiplier = 0.4
    end

    local base_speed = 0.5
    local move_speed = base_speed * speed_multiplier
    
    local cx, cy, cz, lx, ly, lz = getCameraMatrix()

    local dirX, dirY, dirZ = lx - cx, ly - cy, lz - cz
    local len = math.sqrt(dirX * dirX + dirY * dirY + dirZ * dirZ)
    if len > 0 then
      dirX, dirY, dirZ = dirX / len, dirY / len, dirZ / len
    end

    local rightX, rightY = dirY, -dirX
    len = math.sqrt(rightX * rightX + rightY * rightY)
    if len > 0 then
        rightX, rightY = rightX/len, rightY/len
    end

    local velX, velY, velZ = 0, 0, 0

    if getKeyState("w") then
      velX = velX + dirX * move_speed
      velY = velY + dirY * move_speed
      velZ = velZ + dirZ * move_speed
    end
    if getKeyState("s") then
      velX = velX - dirX * move_speed
      velY = velY - dirY * move_speed
      velZ = velZ - dirZ * move_speed
    end
    if getKeyState("d") then
      velX = velX + rightX * move_speed
      velY = velY + rightY * move_speed
    end
    if getKeyState("a") then
      velX = velX - rightX * move_speed
      velY = velY - rightY * move_speed
    end

    if getKeyState("space") then
      velZ = velZ + 0.4 * speed_multiplier
    end
    if getKeyState("lctrl") or getKeyState("rctrl") then
      velZ = velZ - 0.4 * speed_multiplier
    end
    
    setElementVelocity(veh, velX, velY, velZ)

    -- Roll, Pitch, Yaw
    local rotX_roll = 0
    local rotY_pitch = 0
    local rotZ_yaw = -math.deg(math.atan2(dirX, dirY))
    
    setElementRotation(veh, rotX_roll, rotY_pitch, rotZ_yaw)
  else
    local speed = 10

    if getKeyState("mouse1") then
      speed = 150
    end
  
    local x, y, z = getElementPosition(getLocalPlayer())

    if keys.a == "down" then
      speed = 3
    elseif keys.s == "down" then
      speed = 50
    end
    if keys.f == "down" then
      local a = rotFromCam(0)
      setElementRotation(getLocalPlayer(), 0, 0, a)
      local ox, oy = dirMove(a)
      x = x + ox * 0.1 * speed
      y = y + oy * 0.1 * speed
    elseif keys.b == "down" then
      local a = rotFromCam(180)
      setElementRotation(getLocalPlayer(), 0, 0, a)
      local ox, oy = dirMove(a)
      x = x + ox * 0.1 * speed
      y = y + oy * 0.1 * speed
    end
    if keys.l == "down" then
      local a = rotFromCam(-90)
      setElementRotation(getLocalPlayer(), 0, 0, a)
      local ox, oy = dirMove(a)
      x = x + ox * 0.1 * speed
      y = y + oy * 0.1 * speed
    elseif keys.r == "down" then
      local a = rotFromCam(90)
      setElementRotation(getLocalPlayer(), 0, 0, a)
      local ox, oy = dirMove(a)
      x = x + ox * 0.1 * speed
      y = y + oy * 0.1 * speed
    end
    if keys.up == "down" then
      z = z + 0.1 * speed
    elseif keys.down == "down" then
      z = z - 0.1 * speed
    end
    setElementPosition(getLocalPlayer(), x, y, z)
  end
end
function keyH(key, state)
  local veh = getPedOccupiedVehicle(getLocalPlayer())

  if veh then
    if key == "lshift" or key == "rshift" then
      keys.s = state
    end
    if key == "lctrl" or key == "rctrl" then
      keys.down = state
    end
    if key == "w" then
      keys.f = state
    end
    if key == "s" then
      keys.b = state
    end
    if key == "a" then
      keys.l = state
    end
    if key == "d" then
      keys.r = state
    end
    if key == "lalt" or key == "ralt" then
      keys.a = state
    end
    if key == "space" then
      keys.up = state
    end
  else
    if key == "lshift" or key == "rshift" then
      keys.s = state
    end
    if key == "lctrl" or key == "rctrl" then
      keys.down = state
    end
    if key == "forwards" then
      keys.f = state
    end
    if key == "w" then
      keys.f = state
    end
    if key == "backwards" then
      keys.b = state
    end
    if key == "s" then
      keys.b = state
    end
    if key == "left" then
      keys.l = state
    end
    if key == "right" then
      keys.r = state
    end
    if key == "lalt" or key == "ralt" then
      keys.a = state
    end
    if key == "space" then
      keys.up = state
    end
  end
end
function rotFromCam(rzOffset)
  local cx, cy, _, fx, fy = getCameraMatrix(getLocalPlayer())
  local deltaY, deltaX = fy - cy, fx - cx
  local rotZ = math.deg(math.atan(deltaY / deltaX))
  if 0 <= deltaY and deltaX <= 0 then
    rotZ = rotZ + 180
  elseif deltaY <= 0 and deltaX <= 0 then
    rotZ = rotZ + 180
  end
  return -rotZ + 90 + rzOffset
end
function dirMove(a)
  local x = math.sin(math.rad(a))
  local y = math.cos(math.rad(a))
  return x, y
end
local marks = {}
function loadMarks()
  if fileExists("!admin/mark.sight") then
    local file = fileOpen("!admin/mark.sight")
    local size = fileGetSize(file)
    local data = fileRead(file, size)
    fileClose(file)
    local markData = split(data, "\n")
    for i, marked in ipairs(markData) do
      local row = split(marked, ";")
      if 1 < #row then
        local name = row[1]
        local x = row[2]
        local y = row[3]
        local z = row[4]
        local interior = row[5]
        local dimension = row[6]
        marks[name] = {
          x,
          y,
          z,
          interior,
          dimension
        }
      end
    end
  end
end
function addMark(name, data)
  marks[name] = data
  local file
  if fileExists("!admin/mark.sight") then
    file = fileOpen("!admin/mark.sight")
  else
    file = fileCreate("!admin/mark.sight")
  end
  if file then
    fileSetPos(file, fileGetSize(file))
    fileWrite(file, name .. ";" .. table.concat(data, ";") .. "\n")
  end
  fileClose(file)
end
local _addCommandHandler = addCommandHandler
function addCommandHandler(cmd, ...)
	if type(cmd) == "string" then
		_addCommandHandler(cmd, ...)
	else
		for k, v in ipairs(cmd) do
			_addCommandHandler(v, ...)
		end
	end
end
function deleteMark(name)
  if marks[name] then
    marks[name] = nil
    if fileExists("!admin/mark.sight") then
      fileDelete("!admin/mark.sight")
    end
    local file = fileCreate("!admin/mark.sight")
    for i in pairs(marks) do
      fileWrite(file, i .. ";" .. table.concat(marks[i], ";") .. "\n")
    end
    fileClose(file)
  end
end
addEventHandler("onClientResourceStart", resourceRoot, loadMarks)
addCommandHandler({"delmark", "delhome"}, function(commandName, ...)
  if sightexports.sPermission:hasPermission(localPlayer, "gotomark") then
    local name = table.concat({
      ...
    }, " ")
    name = utf8.lower(name)
    if name and utf8.len(name) > 0 then
      if marks[name] then
        deleteMark(name)
        outputChatBox("[color=sightgreen][SightMTA - Mark]: #FFFFFFTeleport [color=sightblue]" .. name .. "#FFFFFF sikeresen törölve.", 0, 255, 0, true)
      else
        outputChatBox("[color=sightred][SightMTA - Mark]: #FFFFFFTeleport [color=sightblue]" .. name .. "#FFFFFF nem létezik.", 0, 255, 0, true)
      end
    else
      outputChatBox("[color=sightblue][SightMTA - Mark]: #FFFFFF/" .. commandName .. " [Név]", 255, 255, 255, true)
    end
  end
end)
addCommandHandler({"marks", "homes"}, function(commandName, ...)
  if sightexports.sPermission:hasPermission(localPlayer, "gotomark") then
    outputChatBox("[color=sightgreen][SightMTA - Mark]: #ffffff Név - (X, Y, Z, INT, DIM) ", 255, 255, 255, true)
    for name, data in pairs(marks) do
      outputChatBox("#FFFFFF- [color=sightblue]" .. name .. "#ffffff - (" .. table.concat(data, ", ") .. ")", 255, 255, 255, true)
    end
  end
end)
addCommandHandler({"mark", "sethome"}, function(commandName, ...)
  if sightexports.sPermission:hasPermission(localPlayer, "gotomark") then
    local name = table.concat({
      ...
    }, " ")
    name = utf8.lower(name)
    if name and utf8.len(name) > 0 then
      local x, y, z = getElementPosition(localPlayer)
      local interior = getElementInterior(localPlayer)
      local dimension = getElementDimension(localPlayer)
      addMark(name, {
        x,
        y,
        z,
        interior,
        dimension
      })
      outputChatBox("[color=sightgreen][SightMTA - Mark]: #FFFFFFTeleport [color=sightblue]" .. name .. "#FFFFFF sikeresen mentve.", 0, 255, 0, true)
    else
      outputChatBox("[color=sightblue][SightMTA - Mark]: #FFFFFF/" .. commandName .. " [Név]", 255, 255, 255, true)
    end
  end
end)
addCommandHandler({"gotomark", "home"}, function(commandName, ...)
  if sightexports.sPermission:hasPermission(localPlayer, "gotomark") then
    local name = table.concat({
      ...
    }, " ")
    if marks[name] then
      if getPedOccupiedVehicle(localPlayer) then
        triggerServerEvent("markVehicle", localPlayer, marks[name][1], marks[name][2], marks[name][3], marks[name][4], marks[name][5])
      else
        triggerServerEvent("markIntDim", localPlayer, marks[name][4], marks[name][5])
        setElementPosition(localPlayer, marks[name][1], marks[name][2], marks[name][3])
      end
    else
      outputChatBox("[color=sightred][SightMTA]: #FFFFFFNincs megjelölve ilyen teleport.", 255, 255, 255, true)
    end
  end
end)