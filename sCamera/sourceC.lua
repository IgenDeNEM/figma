local sightexports = {
	sGui = false,
	sHud = false,
	sCore = false
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
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
	if not sightlangWaiterState0 then
		local res0 = getResourceFromName("sHud")
		if res0 and getResourceState(res0) == "running" then
			hudLoaded()
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
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientPedsProcessed", getRootElement(), selfieBones, true, prio)
		else
			removeEventHandler("onClientPedsProcessed", getRootElement(), selfieBones)
		end
	end
end
local root = getRootElement()
local sm = setCameraMatrix
local disabled = false
function setCamMatrixDisabled(state)
	disabled = state
end
function setCameraMatrix(x, y, z, x2, y2, z2, r, fov)
	if not disabled then
		sm(x, y, z, x2, y2, z2, r, fov)
	end
end
local PI = math.pi
local isEnabled = true
local wasInVehicle = isPedInVehicle(localPlayer)
local mouseSensitivity = 0.1
local rotX, rotY = 0, 0
local mouseFrameDelay = 0
local idleTime = 2500
local fadeBack = false
local fadeBackFrames = 50
local executeCounter = 0
local recentlyMoved = false
local Xdiff, Ydiff
local radar = true
local fpHeightInCar = 0.005
local fpHeight = 0.1
function lerp(a, b, t)
	return a + (b - a) * t
end
function inverseLerp(min, max, x)
	return (x - min) / (max - min)
end
function getFpHeight()
	return inverseLerp(-0.1, 0.30000000000000004, fpHeight) * 100
end
function setFpHeight(val)
	fpHeight = lerp(-0.1, 0.30000000000000004, val / 100)
end
function getFpHeightInCar()
	return inverseLerp(-0.035, 0.045, fpHeightInCar) * 100
end
function setFpHeightInCar(val)
	fpHeightInCar = lerp(-0.035, 0.045, val / 100)
end
function getFpMouseSens()
	return inverseLerp(0, 0.2, mouseSensitivity) * 100
end
function setFpMouseSens(val)
	mouseSensitivity = lerp(0, 0.2, val / 100)
end
local currentCamera = "normal"
function getCurrentCamera()
	return currentCamera
end
function toggleCockpitView()
	if getElementData(localPlayer, "loggedIn") then
		if currentCamera == "fp" then
			toggleCamera("normal")
		else
			toggleCamera("fp")
		end
	end
end
addCommandHandler("fp", toggleCockpitView)
addCommandHandler("cockpit", toggleCockpitView)
local pedTmp = false
local vehTmp = false
addEventHandler("onClientKey", getRootElement(), function(key, state)
	if currentCamera == "fp" and not sightexports.sGui:getActiveInput() and not isChatBoxInputActive() and not isConsoleActive() and key ~= "home" then
		local cameraKeys = getBoundKeys("change_camera")
		for k in pairs(cameraKeys) do
			if k == key then
				if state then
					toggleCamera("normal")
				end
				cancelEvent()
				return
			end
		end
	end
end)
function preRenderCameraSetting()
	local veh, ped = getCameraViewMode()
	if not isPedInVehicle(localPlayer) then
		if ped ~= pedTmp then
			if ped == 3 and pedTmp == 1 then
				toggleCamera("fp")
			elseif ped == 1 then
				sightexports.sHud:setCameraMode("Közeli")
			elseif ped == 2 then
				sightexports.sHud:setCameraMode("Közepes")
			elseif ped == 3 then
				sightexports.sHud:setCameraMode("Távoli")
			end
			pedTmp = ped
		end
		if veh ~= vehTmp then
			vehTmp = veh
		end
	else
		if veh ~= vehTmp then
			if veh == 5 and vehTmp == 0 then
				toggleCamera("fp")
			elseif veh == 0 then
				sightexports.sHud:setCameraMode("Lökhárító")
			elseif veh == 1 then
				sightexports.sHud:setCameraMode("Külső közeli")
			elseif veh == 2 then
				sightexports.sHud:setCameraMode("Külső közepes")
			elseif veh == 3 then
				sightexports.sHud:setCameraMode("Külső távoli")
			elseif veh == 4 then
				sightexports.sHud:setCameraMode("Alsó")
			elseif veh == 5 then
				sightexports.sHud:setCameraMode("Cinematic")
			end
			vehTmp = veh
		end
		if ped ~= pedTmp then
			pedTmp = ped
		end
	end
end
function hudLoaded()
	addEventHandler("onClientPreRender", getRootElement(), preRenderCameraSetting)
end
function updateCameraSelfieBone()
	local px, py, pz = getElementPosition(localPlayer)
	boneX, boneY, boneZ = getPedBonePosition(localPlayer, 25)
	boneX = boneX - px
	boneY = boneY - py
	boneZ = boneZ - pz
end
function updateCameraSelfie()
	if isEnabled then
		local nowTick = getTickCount()
		if wasInVehicle and recentlyMoved and not fadeBack and startTick and nowTick - startTick > idleTime then
			recentlyMoved = false
			if 0 < rotX then
				Xdiff = rotX / fadeBackFrames
			elseif rotX < 0 then
				Xdiff = rotX / -fadeBackFrames
			end
			if 0 < rotY then
				Ydiff = rotY / fadeBackFrames
			elseif rotY < 0 then
				Ydiff = rotY / -fadeBackFrames
			end
		end
		if fadeBack then
			executeCounter = executeCounter + 1
			if 0 < rotX then
				rotX = rotX - Xdiff
			elseif rotX < 0 then
				rotX = rotX + Xdiff
			end
			if 0 < rotY then
				rotY = rotY - Ydiff
			elseif rotY < 0 then
				rotY = rotY + Ydiff
			end
			if executeCounter >= fadeBackFrames then
				fadeBack = false
				executeCounter = 0
			end
		end
		if not boneX then
			updateCameraSelfieBone()
		end
		local px, py, pz = getElementPosition(localPlayer)
		local camPosX, camPosY, camPosZ = px + boneX, py + boneY, pz + boneZ
		local roll = 0
		local rx, ry, rz
		inVehicle = getPedOccupiedVehicle(localPlayer)
		if inVehicle then
			rx, ry, rz = getElementRotation(getPedOccupiedVehicle(localPlayer))
			roll = -ry
			if 90 < rx and rx < 270 then
				roll = ry - 180
			end
			if not wasInVehicle then
				rotX = rotX + math.rad(rz)
				if rotY > -PI / 15 then
					rotY = -PI / 15
				end
			end
			cameraAngleX = rotX - math.rad(rz)
			cameraAngleY = rotY + math.rad(rx)
			if getPedControlState("vehicle_look_behind") or getPedControlState("vehicle_look_right") and getPedControlState("vehicle_look_left") then
				cameraAngleX = cameraAngleX + math.rad(180)
			elseif getPedControlState("vehicle_look_left") then
				cameraAngleX = cameraAngleX - math.rad(90)
			elseif getPedControlState("vehicle_look_right") then
				cameraAngleX = cameraAngleX + math.rad(90)
			end
			camPosZ = camPosZ + fpHeightInCar
		else
			camPosZ = camPosZ + fpHeight
			rx, ry, rz = getElementRotation(localPlayer)
			if wasInVehicle then
				rotX = rotX - math.rad(rz)
			end
			cameraAngleX = rotX
			cameraAngleY = rotY
		end
		wasInVehicle = inVehicle
		local freeModeAngleZ = math.sin(cameraAngleY)
		local freeModeAngleY = math.cos(cameraAngleY) * math.cos(cameraAngleX)
		local freeModeAngleX = math.cos(cameraAngleY) * math.sin(cameraAngleX)
		local camTargetX = camPosX + freeModeAngleX * 100
		local camTargetY = camPosY + freeModeAngleY * 100
		local camTargetZ = camPosZ + freeModeAngleZ * 100
		local camAngleX = camPosX - camTargetX
		local camAngleY = camPosY - camTargetY
		local camAngleZ = 0
		local angleLength = math.sqrt(camAngleX * camAngleX + camAngleY * camAngleY + camAngleZ * camAngleZ)
		local camNormalizedAngleX = camAngleX / angleLength
		local camNormalizedAngleY = camAngleY / angleLength
		local camNormalizedAngleZ = 0
		local normalAngleX = 0
		local normalAngleY = 0
		local normalAngleZ = 1
		local normalX = camNormalizedAngleY * normalAngleZ - camNormalizedAngleZ * normalAngleY
		local normalY = camNormalizedAngleZ * normalAngleX - camNormalizedAngleX * normalAngleZ
		local normalZ = camNormalizedAngleX * normalAngleY - camNormalizedAngleY * normalAngleX
		camTargetX = camPosX + freeModeAngleX * 100
		camTargetY = camPosY + freeModeAngleY * 100
		camTargetZ = camPosZ + freeModeAngleZ * 100
		setNearClipDistance(0.1)
		local r = math.atan2(camTargetY - camPosY, camTargetX - camPosX)
		local cr = r - math.rad(rz) + math.pi / 2
		cr = getEasingValue(1 - math.abs((cr + math.pi) % (math.pi * 2) - math.pi) / math.pi, "InQuad")
		setCameraMatrix(camPosX, camPosY, camPosZ, camTargetX, camTargetY, camTargetZ, roll, 70 + 40 * cr)
		setPedAnimationSpeed(localPlayer, "weapon_crouch", 0)
		setPedAnimationSpeed(localPlayer, "idle_stance", 0)
	end
end
function updateCameraBone()
	local px, py, pz = getElementPosition(localPlayer)
	boneX, boneY, boneZ = getPedBonePosition(localPlayer, 6)
	if inVehicle then
		boneX, boneY = getPedBonePosition(localPlayer, 4)
	end
	boneX = boneX - px
	boneY = boneY - py
	boneZ = boneZ - pz
end
function updateCamera()
	if isEnabled then
		local nowTick = getTickCount()
		if wasInVehicle and recentlyMoved and not fadeBack and startTick and nowTick - startTick > idleTime then
			recentlyMoved = false
			if 0 < rotX then
				Xdiff = rotX / fadeBackFrames
			elseif rotX < 0 then
				Xdiff = rotX / -fadeBackFrames
			end
			if 0 < rotY then
				Ydiff = rotY / fadeBackFrames
			elseif rotY < 0 then
				Ydiff = rotY / -fadeBackFrames
			end
		end
		if fadeBack then
			executeCounter = executeCounter + 1
			if 0 < rotX then
				rotX = rotX - Xdiff
			elseif rotX < 0 then
				rotX = rotX + Xdiff
			end
			if 0 < rotY then
				rotY = rotY - Ydiff
			elseif rotY < 0 then
				rotY = rotY + Ydiff
			end
			if executeCounter >= fadeBackFrames then
				fadeBack = false
				executeCounter = 0
			end
		end
		if not boneX then
			updateCameraBone()
		end
		local px, py, pz = getElementPosition(localPlayer)
		local camPosX, camPosY, camPosZ = px + boneX, py + boneY, pz + boneZ
		local roll = 0
		inVehicle = isPedInVehicle(localPlayer)
		if inVehicle then
			local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(localPlayer))
			roll = -ry
			if 90 < rx and rx < 270 then
				roll = ry - 180
			end
			if not wasInVehicle then
				rotX = rotX + math.rad(rz)
				if rotY > -PI / 15 then
					rotY = -PI / 15
				end
			end
			cameraAngleX = rotX - math.rad(rz)
			cameraAngleY = rotY + math.rad(rx)
			if getPedControlState("vehicle_look_behind") or getPedControlState("vehicle_look_right") and getPedControlState("vehicle_look_left") then
				cameraAngleX = cameraAngleX + math.rad(180)
			elseif getPedControlState("vehicle_look_left") then
				cameraAngleX = cameraAngleX - math.rad(90)
			elseif getPedControlState("vehicle_look_right") then
				cameraAngleX = cameraAngleX + math.rad(90)
			end
			camPosZ = camPosZ + fpHeightInCar
		else
			camPosZ = camPosZ + fpHeight
			local rx, ry, rz = getElementRotation(localPlayer)
			if wasInVehicle then
				rotX = rotX - math.rad(rz)
			end
			cameraAngleX = rotX
			cameraAngleY = rotY
		end
		wasInVehicle = inVehicle
		local freeModeAngleZ = math.sin(cameraAngleY)
		local freeModeAngleY = math.cos(cameraAngleY) * math.cos(cameraAngleX)
		local freeModeAngleX = math.cos(cameraAngleY) * math.sin(cameraAngleX)
		local camTargetX = camPosX + freeModeAngleX * 100
		local camTargetY = camPosY + freeModeAngleY * 100
		local camTargetZ = camPosZ + freeModeAngleZ * 100
		local camAngleX = camPosX - camTargetX
		local camAngleY = camPosY - camTargetY
		local camAngleZ = 0
		local angleLength = math.sqrt(camAngleX * camAngleX + camAngleY * camAngleY + camAngleZ * camAngleZ)
		local camNormalizedAngleX = camAngleX / angleLength
		local camNormalizedAngleY = camAngleY / angleLength
		local camNormalizedAngleZ = 0
		local normalAngleX = 0
		local normalAngleY = 0
		local normalAngleZ = 1
		local normalX = camNormalizedAngleY * normalAngleZ - camNormalizedAngleZ * normalAngleY
		local normalY = camNormalizedAngleZ * normalAngleX - camNormalizedAngleX * normalAngleZ
		local normalZ = camNormalizedAngleX * normalAngleY - camNormalizedAngleY * normalAngleX
		camTargetX = camPosX + freeModeAngleX * 100
		camTargetY = camPosY + freeModeAngleY * 100
		camTargetZ = camPosZ + freeModeAngleZ * 100
		setCameraMatrix(camPosX, camPosY, camPosZ, camTargetX, camTargetY, camTargetZ, roll, getFov)
		setPedAnimationSpeed(localPlayer, "weapon_crouch", 0)
		setPedAnimationSpeed(localPlayer, "idle_stance", 0)
	end
end
function freecamMouse(cX, cY, aX, aY)
	if isCursorShowing() or isMTAWindowActive() then
		mouseFrameDelay = 5
		return
	elseif 0 < mouseFrameDelay then
		mouseFrameDelay = mouseFrameDelay - 1
		return
	end
	startTick = getTickCount()
	recentlyMoved = true
	if fadeBack then
		fadeBack = false
		executeCounter = 0
	end
	local width, height = guiGetScreenSize()
	aX = aX - width / 2
	aY = aY - height / 2
	rotX = rotX + aX * mouseSensitivity * 0.01745
	rotY = rotY - aY * mouseSensitivity * 0.01745
	local pRotX, pRotY, pRotZ = getElementRotation(localPlayer)
	pRotZ = math.rad(pRotZ)
	if rotX > PI then
		rotX = rotX - 2 * PI
	elseif rotX < -PI then
		rotX = rotX + 2 * PI
	end
	if rotY > PI then
		rotY = rotY - 2 * PI
	elseif rotY < -PI then
		rotY = rotY + 2 * PI
	end
	if isPedInVehicle(localPlayer) then
		if rotY < -PI / 4 then
			rotY = -PI / 4
		elseif 0.075 < rotY then
			rotY = 0.075
		end
	elseif rotY < -PI / 4 then
		rotY = -PI / 4
	elseif rotY > PI / 2.1 then
		rotY = PI / 2.1
	end
end
function rotateAround(deg, x, y)
	local centerX = 0
	local centerY = 0
	local pointX = x
	local pointY = y
	local angle = math.rad(deg)
	local drawX = centerX + (pointX - centerX) * math.cos(angle) - (pointY - centerY) * math.sin(angle)
	local drawY = centerY + (pointX - centerX) * math.sin(angle) + (pointY - centerY) * math.cos(angle)
	return drawX, drawY
end
local chinatownRotation = 0
local chinatownSensitivity = 100
local chinatownZoomOnFoot = 1
local chinatownZoomInCar = 1
local chinatownInVeh = false
function chinatownRender()
	local el = localPlayer
	local mul = 0.45 * chinatownZoomOnFoot
	local mul2 = 0.325 * chinatownZoomOnFoot
	local rot = chinatownRotation
	if isPedInVehicle(localPlayer) then
		if not chinatownInVeh then
			chinatownInVeh = true
			chinatownRotation = 0
		end
		el = getPedOccupiedVehicle(localPlayer)
		local rx, ry, rz = getElementRotation(el)
		rot = chinatownRotation + rz
		local vx, vy, vz = getElementVelocity(el)
		local speed = math.sqrt(vx ^ 2 + vy ^ 2)
		mul = 0.75 * (speed * 0.8 + 1) * chinatownZoomInCar
		mul2 = 0.65 * (speed * 0.7 + 1) * chinatownZoomInCar
	elseif chinatownInVeh then
		chinatownInVeh = false
		chinatownRotation = rot + 180
		rot = chinatownRotation
	end
	local x, y, z = getElementPosition(el)
	if getPedControlState("vehicle_look_left") then
		rz = rz + 90
	elseif getPedControlState("vehicle_look_right") then
		rz = rz - 90
	end
	local x2, y2 = rotateAround(rot, 0, -24 * mul)
	local hit, hx, hy, hz = processLineOfSight(x, y, z, x + x2, y + y2, z + 18 * mul2, true, false, true, true, true, false, false, false, localPlayer)
	if hit then
		setCameraMatrix(hx, hy, hz, x, y, z)
	else
		setCameraMatrix(x + x2, y + y2, z + 18 * mul2, x, y, z)
	end
end
function chinatownCursorMove(x, y)
	if not isCursorShowing() and not isConsoleActive() then
		local diff = 0.5 - x
		chinatownRotation = chinatownRotation + diff * chinatownSensitivity
	end
end
local lockCamera = false
local boneX, boneY, boneZ = false, false, false
function toggleCamera(new, lock)
	if getElementData(localPlayer, "loggedIn") then
		resetNearClipDistance()
		if lock and not lockCamera then
			lockCamera = currentCamera
		elseif lockCamera then
			if not lock then
				return
			end
			new = new or lockCamera
			lockCamera = false
		end
		setPedAnimationSpeed(localPlayer, "weapon_crouch", 1)
		setPedAnimationSpeed(localPlayer, "idle_stance", 1)
		setCameraTarget(localPlayer)
		if currentCamera == "chinatown" then
			removeEventHandler("onClientPreRender", getRootElement(), chinatownRender)
			removeEventHandler("onClientCursorMove", getRootElement(), chinatownCursorMove)
		elseif currentCamera == "fp2" then
			removeEventHandler("onClientPedsProcessed", getRootElement(), updateCameraSelfieBone, true, "low-9999999999")
			removeEventHandler("onClientPreRender", getRootElement(), updateCameraSelfie)
			removeEventHandler("onClientCursorMove", getRootElement(), freecamMouse)
		elseif currentCamera == "fp" then
			removeEventHandler("onClientPedsProcessed", getRootElement(), updateCameraBone, true, "low-9999999999")
			removeEventHandler("onClientPreRender", getRootElement(), updateCamera)
			removeEventHandler("onClientCursorMove", getRootElement(), freecamMouse)
		end
		currentCamera = new
		if currentCamera == "chinatown" then
			addEventHandler("onClientPreRender", getRootElement(), chinatownRender)
			addEventHandler("onClientCursorMove", getRootElement(), chinatownCursorMove)
			sightexports.sHud:setCameraMode("Chinatown")
		elseif currentCamera == "fp2" then
			boneX, boneY, boneZ = false, false, false
			wasInVehicle = isPedInVehicle(localPlayer)
			addEventHandler("onClientPedsProcessed", getRootElement(), updateCameraSelfieBone, true, "low-9999999999")
			addEventHandler("onClientPreRender", getRootElement(), updateCameraSelfie)
			addEventHandler("onClientCursorMove", getRootElement(), freecamMouse)
			sightexports.sHud:setCameraMode("First Person")
		elseif currentCamera == "fp" then
			wasInVehicle = isPedInVehicle(localPlayer)
			boneX, boneY, boneZ = false, false, false
			getFov = getCameraFieldOfView("player")
			addEventHandler("onClientPedsProcessed", getRootElement(), updateCameraBone, true, "low-9999999999")
			addEventHandler("onClientPreRender", getRootElement(), updateCamera)
			addEventHandler("onClientCursorMove", getRootElement(), freecamMouse)
			sightexports.sHud:setCameraMode("First Person")
		else
			local veh, ped = getCameraViewMode()
			if not isPedInVehicle(localPlayer) then
				if ped == 1 then
					sightexports.sHud:setCameraMode("Közeli")
				elseif ped == 2 then
					sightexports.sHud:setCameraMode("Közepes")
				elseif ped == 3 then
					sightexports.sHud:setCameraMode("Távoli")
				end
			elseif veh == 0 then
				sightexports.sHud:setCameraMode("Lökhárító")
			elseif veh == 1 then
				sightexports.sHud:setCameraMode("Külső közeli")
			elseif veh == 2 then
				sightexports.sHud:setCameraMode("Külső közepes")
			elseif veh == 3 then
				sightexports.sHud:setCameraMode("Külső távoli")
			elseif veh == 4 then
				sightexports.sHud:setCameraMode("Alsó")
			elseif veh == 5 then
				sightexports.sHud:setCameraMode("Cinematic")
			end
		end
	end
end
local distanceThreshold = 1.5
local currentAlpha = 255
local targetAlpha = 255
local alphaChangeSpeed = 100
local lastUpdateTime = getTickCount()
local fixedAlpha = false
local alphaValue = 0
function setAlpha(alphaState, alphaVal)
	fixedAlpha = alphaState
	alphaValue = alphaVal
end
addEventHandler("onClientRender", root, function()
	if getElementData(localPlayer, "fixedAlpha") then
		return
	end
	if fixedAlpha then
		setElementAlpha(localPlayer, alphaValue or 255)
		return
	end
	if currentCamera ~= "normal" then
		setElementAlpha(localPlayer, 255)
	end
	if currentCamera == "normal" then
		local playerPosition = {getElementPosition(localPlayer)}
		local cameraPosition = {getCameraMatrix()}
		
		local cameraDistance = getDistanceBetweenPoints3D(
		playerPosition[1], playerPosition[2], playerPosition[3],
		cameraPosition[1], cameraPosition[2], cameraPosition[3]
	)
	
	if cameraDistance < distanceThreshold then
		targetAlpha = 200
	else
		targetAlpha = 255
	end
	
	local now = getTickCount()
	local deltaTime = (now - lastUpdateTime) / 1000 
	lastUpdateTime = now
	
	if currentAlpha < targetAlpha then
		currentAlpha = currentAlpha + alphaChangeSpeed * deltaTime
		if currentAlpha > targetAlpha then
			currentAlpha = targetAlpha
		end
	elseif currentAlpha > targetAlpha then
		currentAlpha = currentAlpha - alphaChangeSpeed * deltaTime
		if currentAlpha < targetAlpha then
			currentAlpha = targetAlpha
		end
	end
	
	setElementAlpha(localPlayer, math.floor(currentAlpha))
end
end)