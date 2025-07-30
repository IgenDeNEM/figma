local sightexports = {
	sModloader = false,
	sMdc = false,
	sGui = false,
	sChat = false,
	sRadar = false
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
local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processsightlangStaticImage = {}
sightlangStaticImageToc[0] = true
sightlangStaticImageToc[1] = true
sightlangStaticImageToc[2] = true
sightlangStaticImageToc[3] = true
local sightlangStatImgPre
function sightlangStatImgPre()
	local now = getTickCount()
	if sightlangStaticImageUsed[0] then
		sightlangStaticImageUsed[0] = false
		sightlangStaticImageDel[0] = false
	elseif sightlangStaticImage[0] then
		if sightlangStaticImageDel[0] then
			if now >= sightlangStaticImageDel[0] then
				if isElement(sightlangStaticImage[0]) then
					destroyElement(sightlangStaticImage[0])
				end
				sightlangStaticImage[0] = nil
				sightlangStaticImageDel[0] = false
				sightlangStaticImageToc[0] = true
				return
			end
		else
			sightlangStaticImageDel[0] = now + 5000
		end
	else
		sightlangStaticImageToc[0] = true
	end
	if sightlangStaticImageUsed[1] then
		sightlangStaticImageUsed[1] = false
		sightlangStaticImageDel[1] = false
	elseif sightlangStaticImage[1] then
		if sightlangStaticImageDel[1] then
			if now >= sightlangStaticImageDel[1] then
				if isElement(sightlangStaticImage[1]) then
					destroyElement(sightlangStaticImage[1])
				end
				sightlangStaticImage[1] = nil
				sightlangStaticImageDel[1] = false
				sightlangStaticImageToc[1] = true
				return
			end
		else
			sightlangStaticImageDel[1] = now + 5000
		end
	else
		sightlangStaticImageToc[1] = true
	end
	if sightlangStaticImageUsed[2] then
		sightlangStaticImageUsed[2] = false
		sightlangStaticImageDel[2] = false
	elseif sightlangStaticImage[2] then
		if sightlangStaticImageDel[2] then
			if now >= sightlangStaticImageDel[2] then
				if isElement(sightlangStaticImage[2]) then
					destroyElement(sightlangStaticImage[2])
				end
				sightlangStaticImage[2] = nil
				sightlangStaticImageDel[2] = false
				sightlangStaticImageToc[2] = true
				return
			end
		else
			sightlangStaticImageDel[2] = now + 5000
		end
	else
		sightlangStaticImageToc[2] = true
	end
	if sightlangStaticImageUsed[3] then
		sightlangStaticImageUsed[3] = false
		sightlangStaticImageDel[3] = false
	elseif sightlangStaticImage[3] then
		if sightlangStaticImageDel[3] then
			if now >= sightlangStaticImageDel[3] then
				if isElement(sightlangStaticImage[3]) then
					destroyElement(sightlangStaticImage[3])
				end
				sightlangStaticImage[3] = nil
				sightlangStaticImageDel[3] = false
				sightlangStaticImageToc[3] = true
				return
			end
		else
			sightlangStaticImageDel[3] = now + 5000
		end
	else
		sightlangStaticImageToc[3] = true
	end
	if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] then
		sightlangStatImgHand = false
		removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
	end
end
processsightlangStaticImage[0] = function()
	if not isElement(sightlangStaticImage[0]) then
		sightlangStaticImageToc[0] = false
		sightlangStaticImage[0] = dxCreateTexture("files/traffipaxlight.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/radar2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[2] = function()
	if not isElement(sightlangStaticImage[2]) then
		sightlangStaticImageToc[2] = false
		sightlangStaticImage[2] = dxCreateTexture("files/radar1.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[3] = function()
	if not isElement(sightlangStaticImage[3]) then
		sightlangStaticImageToc[3] = false
		sightlangStaticImage[3] = dxCreateTexture("files/arrow.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
local sightlangGuiRefreshColors = function()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		refreshColors()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local sightlangModloaderLoaded = function()
	onStart()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientRender", getRootElement(), renderSpeedCamHit, true, prio)
		else
			removeEventHandler("onClientRender", getRootElement(), renderSpeedCamHit)
		end
	end
end
local screenX, screenY = guiGetScreenSize()
local traffiRadarObjects = {}
local fixCameraObjects = {}
local fixCameraCols = {}
local fixCameraLimit = {}
local flashes = {}
addEvent("traffipaxFlash", true)
addEventHandler("traffipaxFlash", getRootElement(), function(id)
	if tonumber(id) and fixCameraObjects[id] then
		table.insert(flashes, {
			id,
			getTickCount()
		})
		local x, y, z = getElementPosition(fixCameraObjects[id])
		playSound3D("files/traffi.mp3", x, y, z)
	end
end)
addEventHandler("onClientPreRender", getRootElement(), function()
	local now = getTickCount()
	for i = #flashes, 1, -1 do
		if now - flashes[i][2] > 100 then
			table.remove(flashes, i)
		elseif tonumber(flashes[i][1]) then
			local x, y, z = getElementPosition(fixCameraObjects[flashes[i][1]])
			local rx, ry, rz = getElementRotation(fixCameraObjects[flashes[i][1]])
			local vx = math.cos(math.rad(rz - 90))
			local vy = math.sin(math.rad(rz - 90))
			x = x + vx * 0.3
			y = y + vy * 0.3
			z = z + 1.55
			sightlangStaticImageUsed[0] = true
			if sightlangStaticImageToc[0] then
				processsightlangStaticImage[0]()
			end
			dxDrawMaterialLine3D(x, y, z - 0.5, x, y, z + 0.5, sightlangStaticImage[0], 1, tocolor(255, 255, 255), x + vx * 10, y + vy * 10, z)
		end
	end
end)
function onStart()
	for i = 1, #fixCameraPoses do
		local rz = math.deg(math.atan2(fixCameraPoses[i][5] - fixCameraPoses[i][2], fixCameraPoses[i][4] - fixCameraPoses[i][1])) + 90
		local obj = createObject(sightexports.sModloader:getModelId("traffi"), fixCameraPoses[i][1], fixCameraPoses[i][2], fixCameraPoses[i][3] - 1, 0, 0, rz)
		local col = createColSphere(fixCameraPoses[i][4], fixCameraPoses[i][5], fixCameraPoses[i][6], fixCameraPoses[i][7])
		table.insert(fixCameraObjects, obj)
		table.insert(fixCameraCols, col)
		table.insert(fixCameraLimit, fixCameraPoses[i][8])
		traffiRadarObjects[obj] = 1
		addEventHandler("onClientColShapeHit", col, speedCamHit)
		addEventHandler("onClientElementStreamIn", obj, traffipaxObjectStreamIn)
		addEventHandler("onClientElementStreamOut", obj, traffipaxObjectStreamOut)
	end
	local players = getElementsByType("player")
	for i = 1, #players do
		processTraffiObject(players[i], getElementData(players[i], "traffipaxState"))
	end
end
local speedHitStarted = false
local speedHitEnded = false
local shaderSource = " texture sBaseTexture; float Contrast = -0.2; float Saturation = 0.75; const float3 lumCoeff = float3(0.2125, 0.7154, 0.0721); sampler Samp = sampler_state { Texture = (sBaseTexture); AddressU = MIRROR; AddressV = MIRROR; }; float4 PixelShaderFunction(float2 uv : TEXCOORD) : COLOR { float4 outputColor = tex2D(Samp, uv); outputColor.rgb = (outputColor.rgb - 0.5) *(Contrast + 1.0) + 0.5; float3 intensity = float(dot(outputColor.rgb, lumCoeff)); outputColor.rgb = lerp(intensity, outputColor.rgb, Saturation ); outputColor.r *= 0.85; outputColor.b *= 0.9; return outputColor; } technique movie { pass P0 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } technique fallback { pass P0 { } } "
local camSet = false
function getVehicleSpeed(currentElement, forceUnit)
	if isElement(currentElement) then
		local testUnit = forceUnit or unit
		local x, y, z = getElementVelocity(currentElement)
		local speed = math.sqrt(x ^ 2 + y ^ 2 + z ^ 2)
		if testUnit == "MPH" then
			speed = speed * 116.5 * 1.1
		else
			speed = speed * 180 * 1.1
		end
		return speed
	end
	return 0
end
function renderSpeedCamHit()
	local now = getTickCount()
	local p = 0
	if speedHitStarted then
		p = (now - speedHitStarted) / 40
		if 1 < p then
			p = 1
			if not speedHitEnded then
				speedHitEnded = now
			end
		elseif speedHitEnded then
			speedHitEnded = false
		end
	end
	if speedHitEnded then
		p = 1 - (now - speedHitEnded) / 300
		if p < 0 then
			p = 0
			sightlangCondHandl0(false)
		end
	end
	dxDrawRectangle(0, 0, screenX, screenY, tocolor(255, 255, 255, 255 * p))
end
local lastHit = 0
function speedCamHit(element)
	local now = getTickCount()
	if element == localPlayer and 10000 < now - lastHit then
		local veh = getPedOccupiedVehicle(localPlayer)
		local driver = getPedOccupiedVehicleSeat(localPlayer) == 0
		if veh and isCheckedVehicle(veh) then
			local belts = 0
			if not isBike(veh) then
				for seat, element in pairs(getVehicleOccupants(veh)) do
					if getElementType(element) == "player" and not getElementData(element, "seatBelt") then
						belts = belts + 1
					end
				end
				if 0 < belts and driver then
					triggerServerEvent("speedCameraBelt", localPlayer, belts)
					lastHit = now
				end
			end
			for i = 1, #fixCameraCols do
				if source == fixCameraCols[i] then
					speedHitSpeed = math.floor(getVehicleSpeed(veh) + 0.5)
					if speedHitSpeed > fixCameraLimit[i] * speedMargin then
						playSound("files/traffi.mp3")
						if driver then
							triggerServerEvent("speedCameraHit", localPlayer, veh, speedHitSpeed - fixCameraLimit[i], i, "o7HFy57BNfAiSkSF", "", speedHitSpeed, fixCameraLimit[i])
							lastHit = now
						end
						speedHitStarted = getTickCount()
						speedHitEnded = false
						sightlangCondHandl0(true)
						return
					end
				end
			end
		end
	end
end
function getMatrixForward(m)
	return m[2][1], m[2][2], m[2][3]
end
function getElementMatrixEx(element, prx, pry, prz)
	local rx, ry, rz = getElementRotation(element, "ZXY")
	rx, ry, rz = math.rad(rx + prx), math.rad(ry + pry), math.rad(rz + prz)
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
function getPositionFromMatrixOffset(m, offX, offY, offZ)
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z
end
local trx = 0
local trz = 0
function cursorMoveTraffi(cx, cy)
	setCursorPosition(0.5 * screenX, 0.5 * screenY)
	trx = trx - (cy - 0.5) * math.rad(75)
	trz = trz - (cx - 0.5) * math.rad(75)
	if trz > math.pi * 0.45 then
		trz = math.pi * 0.45
	end
	if trz < -math.pi * 0.45 then
		trz = -math.pi * 0.45
	end
	if trx > math.pi / 3 then
		trx = math.pi / 3
	end
	if trx < -math.pi * 0.1 then
		trx = -math.pi * 0.1
	end
end
local gotVehicleDatas = {}
addEventHandler("onClientElementDestroy", getRootElement(), function()
	gotVehicleDatas[source] = nil
end)
addEvent("gotVehiclePlateSearchForTraffi", true)
addEventHandler("gotVehiclePlateSearchForTraffi", getRootElement(), function(veh, valid, warrant)
	if isElement(veh) then
		local mdcCol = false
		if tonumber(valid) then
			valid = "#bf6c39" .. valid .. " érvénytelen bejegyzés"
			mdcCol = "yellow"
		elseif valid then
			valid = "#39bf39érvényes"
		else
			valid = "#bf3939lejárt"
			mdcCol = "red"
		end
		if warrant then
			warrant = "#bf3939igen"
			mdcCol = "red"
		else
			warrant = "#39bf39nem"
		end
		gotVehicleDatas[veh] = {
			getTickCount(),
			valid,
			warrant
		}
		local id = tonumber(getElementData(veh, "vehicle.dbID"))
		if id then
			local text = getVehiclePlateText(veh)
			text = split(text, "-")
			sightexports.sMdc:addLastPlate(id, table.concat(text, "-"), mdcCol)
		end
	end
end)
function requestVehicle(veh)
	if isElement(veh) then
		local id = tonumber(getElementData(veh, "vehicle.dbID"))
		if id then
			gotVehicleDatas[veh] = "loading"
			triggerLatentServerEvent("requestVehiclePlateSearch", localPlayer, veh, true)
		else
			gotVehicleDatas[veh] = {
				getTickCount(),
				"#39bf39érvényes",
				"#39bf39nem"
			}
		end
	end
end
local targetVeh = false
local targetVehDriver = false
local targetDist = false
local targetSpeed = false
local traffiScreenSource = false
local traffiShader = false
local traffiFont = false
local traffiMax = 90
local traffiSet = 0
local traffiPhotoStart = false
local traffiPhotoEnd = false
local traffiPhotoCanSend = false
local traffiPhotoSent = false
local traffiPhotoCooldown = false
local traffiPhotoCooldownDuration = false
local traffiState = false
local traffipaxCars = {
	[490] = {
		1,
		1,
		-0.25,
		0.4
	},
	[598] = {
		0.75,
		0.5,
		-0.37,
		-0.135
	},
	[599] = {
		0.65,
		0.6,
		-0.49,
		-0.03
	},
	[597] = {
		1,
		0.8,
		-0.07,
		0.07
	},
	[596] = {
		0.75,
		0.4,
		-0.3,
		-0.2
	}
}
function getTraffipaxModel(model)
	return traffipaxCars[model]
end
local traffipaxObjects = {}
function processTraffiObject(client, data)
	if isElement(traffipaxObjects[client]) then
		destroyElement(traffipaxObjects[client])
	end
	traffipaxObjects[client] = nil
	if data then
		local veh = getPedOccupiedVehicle(client)
		if veh then
			local model = getElementModel(veh)
			local data = traffipaxCars[model]
			if data then
				traffipaxObjects[client] = createObject(sightexports.sModloader:getModelId("traffi_car"), 0, 0, 0)
				setElementCollisionsEnabled(traffipaxObjects[client], false)
				attachElements(traffipaxObjects[client], veh, 0, data[3], data[4])
				traffiRadarObjects[traffipaxObjects[client]] = 2
				addEventHandler("onClientElementStreamIn", traffipaxObjects[client], traffipaxObjectStreamIn)
				addEventHandler("onClientElementStreamOut", traffipaxObjects[client], traffipaxObjectStreamOut)
			end
		end
	end
end
local traffiRadarVeh = false
local traffiRadarLevel = false
addEventHandler("onClientElementDataChange", getRootElement(), function(data, old, new)
	if data == "traffipaxState" then
		processTraffiObject(source, new)
	elseif data == "traffipaxRadar" and source == traffiRadarVeh then
		traffiRadarLevel = new
		refreshColors()
	end
end)
addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(veh)
	traffiRadarLevel = getElementData(veh, "traffipaxRadar")
	traffiRadarVeh = veh
	refreshColors()
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function(data, old, new)
	processTraffiObject(source, false)
end)
function preRenderCarTraffi()
	if not traffiPhotoStart then
		targetVeh = false
		targetDist = 0
		targetSpeed = false
	end
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh and veh == traffiState then
		local model = getElementModel(veh)
		local data = traffipaxCars[model]
		if data then
			local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(veh)
			local m = getElementMatrix(veh)
			local py = data[1]
			local pz = data[2]
			local x, y, z = getPositionFromMatrixOffset(m, 0, py, pz)
			local maxD = 75
			local x2, y2, z2 = getPositionFromMatrixOffset(m, maxD * math.cos(trz + math.pi / 2), py + maxD * math.sin(trz + math.pi / 2), pz + maxD * math.sin(trx))
			local rx, ry, rz = getElementRotation(veh)
			if traffiPhotoStart and 1 < (getTickCount() - traffiPhotoStart) / 40 and isElement(targetVeh) then
				local vx, vy, vz = getElementPosition(targetVeh)
				local d1 = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
				local d2 = getDistanceBetweenPoints3D(x, y, z, vx, vy, vz)
				d2 = math.max(0, d2 - 10)
				x = x + (x2 - x) * (d2 / d1)
				y = y + (y2 - y) * (d2 / d1)
				z = z + (z2 - z) * (d2 / d1)
				setCameraMatrix(x, y, z, x2, y2, z2, -ry)
				traffiPhotoCanSend = true
			else
				setCameraMatrix(x, y, z, x2, y2, z2, -ry)
			end
			local hit, hx, hy, hz, hitElement = processLineOfSight(x, y, z, x2, y2, z2, false, true, false, false, false, false, false, false, veh)
			if hitElement and not traffiPhotoStart then
				targetVeh = hitElement
				targetDist = math.floor(getDistanceBetweenPoints3D(x, y, z, hx, hy, hz) + 0.5)
				targetSpeed = math.floor(getVehicleSpeed(targetVeh) + 0.5)
				if gotVehicleDatas[targetVeh] and gotVehicleDatas[targetVeh] ~= "loading" and getTickCount() - gotVehicleDatas[targetVeh][1] > 150000 then
					gotVehicleDatas[targetVeh] = nil
				end
				if not gotVehicleDatas[targetVeh] then
					requestVehicle(targetVeh)
				end
			end
		else
			stopHandheldTraffi()
		end
	else
		stopHandheldTraffi()
	end
end
function keyCarTraffi(key, por)
	if por and not traffiPhotoStart and not traffiPhotoEnd and not traffiPhotoCanSend and not traffiPhotoCooldown then
		if key == "backspace" then
			stopHandheldTraffi()
		elseif key == "mouse_wheel_up" then
			traffiMax = math.min(130, traffiMax + 5)
			traffiSet = getTickCount()
		elseif key == "mouse_wheel_down" then
			traffiMax = math.max(30, traffiMax - 5)
			traffiSet = getTickCount()
		elseif key == "mouse1" and targetVeh and targetSpeed > traffiMax * speedMargin then
			sightexports.sChat:localActionC(localPlayer, "bemért egy gyorshajtót.")
			playSound("files/trafficar.mp3")
			targetVehDriver = getVehicleController(targetVeh)
			if targetVehDriver then
				traffiPhotoStart = getTickCount()
				traffiPhotoSent = false
				local text = getVehiclePlateText(targetVeh)
				text = split(text, "-")
				triggerServerEvent("speedCameraHit", targetVehDriver, targetVeh, targetSpeed - traffiMax, false, "o7HFy57BNfAiSkSF", table.concat(text, "-"), targetSpeed, traffiMax)
			end
		end
	end
	cancelEvent()
end
function sendSpeedcamSms(client, rt, x, y, z, rsx, sy, speed)
	if isElement(client) then
		local thumbRt = dxCreateRenderTarget(64, 64)
		if isElement(thumbRt) then
			dxSetRenderTarget(thumbRt)
			local tx = 64 / sy * rsx
			dxDrawImage(32 - tx / 2, 0, tx, 64, rt)
			dxSetRenderTarget()
			local convertedThumb = dxGetTexturePixels(thumbRt, "dds", "dxt1", false)
			if convertedThumb then
				local timestamp = getRealTime().timestamp
				local time = getRealTime()
				local filename = string.format("%04d-%02d-%02d_%02d-%02d-%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
				filename = "traf_" .. filename .. "_" .. math.floor(speed)
				local checksumThumb = sha256(convertedThumb)
				checksumThumb = teaEncode(checksumThumb, "smst" .. timestamp .. utf8.sub(filename, 1, 10))
				local convertedPixels = dxGetTexturePixels(rt, "dds", "dxt3", false)
				local rawPixels = dxGetTexturePixels(rt)
				if convertedPixels then
					local checksumRaw = sha256(convertedPixels)
					checksum = teaEncode(checksumRaw, "mk" .. timestamp .. utf8.sub(filename, 1, 10))
					triggerLatentServerEvent("traffipaxSMSPicture", 500000, client, speed, getPrice(client, speed), filename, timestamp, checksum, checksumRaw, checksumThumb, convertedPixels, convertedThumb, rsx, sy, tostring(sightexports.sRadar:getZoneName(x, y, z)), x, y)
					rawPixels = dxConvertPixels(rawPixels, "jpeg", 95)
					if rawPixels then
						local jpg = filename
						local post = ""
						local i = 1
						while fileExists("#traffipax_sight/" .. jpg .. post .. ".jpg") do
							i = i + 1
							post = "_" .. i
						end
						jpg = "#traffipax_sight/" .. jpg .. post .. ".jpg"
						if not fileExists(jpg) then
							local file = fileCreate(jpg)
							if file then
								fileWrite(file, rawPixels)
								fileClose(file)
							end
						end
					end
					rawPixels = nil
					checksum = nil
				end
				convertedPixels = nil
			end
			checksumThumb = nil
			convertedThumb = nil
		end
		if isElement(thumbRt) then
			destroyElement(thumbRt)
		end
		thumbRt = false
	end
	collectgarbage("collect")
end
function renderCarTraffi()
	local now = getTickCount()
	local p = 0
	local veh = getPedOccupiedVehicle(localPlayer)
	if traffiPhotoStart then
		p = (now - traffiPhotoStart) / 40
		if 1 < p then
			p = 1
			if not isElement(targetVeh) or not isElement(targetVehDriver) then
				traffiPhotoCanSend = false
				traffiPhotoStart = false
				traffiPhotoEnd = now
			end
		end
	end
	if veh then
		dxUpdateScreenSource(traffiScreenSource)
		local rt = false
		if traffiPhotoCanSend and not traffiPhotoSent then
			rt = dxCreateRenderTarget(screenX, screenY)
			dxSetRenderTarget(rt)
		end
		dxDrawImage(0, 0, screenX, screenY, traffiShader)
		local scale = 0.65
		dxDrawText("> <", 0, 0, screenX, screenY, tocolor(255, 255, 255, 255), 0.5 * scale, traffiFont, "center", "center")
		if traffiPhotoCanSend then
			scale = 1
		end
		if traffiPhotoCooldown or traffiPhotoEnd then
			local text = ""
			local p = 0
			local dot = 0
			if traffiPhotoCooldown then
				p = (now - traffiPhotoCooldown) / traffiPhotoCooldownDuration
				dot = now % 800 / 200
			end
			if 0.75 < p then
				text = "Bírság küldése sikeres!"
			elseif 0.5 < p then
				text = "Adatok feltöltése"
			elseif 0.25 < p then
				text = "Fénykép feltöltése"
			else
				text = "Csatlakozás a rendőrségi szerverhez"
			end
			if p <= 0.75 then
				for i = 1, dot do
					text = text .. "."
				end
			end
			local w = math.ceil(dxGetTextWidth(text, 0.25 * scale, traffiFont) * 1.25)
			local h = math.ceil(dxGetFontHeight(0.5 * scale, traffiFont) * 1.25)
			local h2 = math.ceil(dxGetFontHeight(0.25 * scale, traffiFont) * 1.25)
			dxDrawRectangle(screenX / 2 - w / 2, screenY - h * 2.5 + h / 2 - h2 / 2, w, h2, tocolor(0, 0, 0))
			dxDrawText(text, 0, screenY - h * 2.5 + h / 2 - h2 / 2, screenX, screenY - h * 2.5 + h / 2 + h2 / 2, tocolor(255, 255, 255, 255), 0.25 * scale, traffiFont, "center", "center")
			if 1 <= p then
				traffiPhotoCooldown = false
				traffiPhotoCooldownDuration = false
			end
		else
			local speedText = "---"
			if isElement(targetVeh) then
				speedText = targetSpeed .. " km/h"
			end
			local w = math.ceil(dxGetTextWidth(speedText, 0.5 * scale, traffiFont) * 1.25)
			local h = math.ceil(dxGetFontHeight(0.5 * scale, traffiFont) * 1.25)
			local y = 0
			if p < 1 then
				y = screenY - h * 2.5
			else
				y = screenY - h * 1.2
			end
			dxDrawRectangle(screenX / 2 - w / 2, y, w, h, tocolor(0, 0, 0))
			if p < 1 and isElement(targetVeh) then
				if targetSpeed > traffiMax * speedMargin then
					dxDrawText(speedText, 0, y, screenX, y + h, tocolor(191, 57, 57, 255), 0.5 * scale, traffiFont, "center", "center")
				else
					dxDrawText(speedText, 0, y, screenX, y + h, tocolor(255, 255, 255, 255), 0.5 * scale, traffiFont, "center", "center")
				end
				local plate = getVehiclePlateText(targetVeh)
				local numberPlate = split(plate, "-")
				numberPlate = table.concat(numberPlate, "-") .. ", d=" .. targetDist .. "m"
				local sw = math.ceil(dxGetTextWidth(numberPlate, 0.2 * scale, traffiFont) * 1.25)
				local sh = math.ceil(dxGetFontHeight(0.2 * scale, traffiFont) * 1.25)
				dxDrawRectangle(screenX / 2 - sw / 2, screenY - h * 2.5 - sh * 1.5, sw, sh, tocolor(0, 0, 0))
				dxDrawText(numberPlate, 0, screenY - h * 2.5 - sh * 1.5, screenX, screenY - h * 2.5 - sh * 0.5, tocolor(255, 255, 255, 255), 0.2 * scale, traffiFont, "center", "center")
				local sh = math.ceil(dxGetFontHeight(0.175 * scale, traffiFont) * 1.25)
				local lowerText = "N/A"
				if gotVehicleDatas[targetVeh] == "loading" then
					lowerText = "Lekérdezés folyamatban..."
				elseif gotVehicleDatas[targetVeh] then
					lowerText = "Forgalmi: " .. gotVehicleDatas[targetVeh][2] .. "#ffffff, Körözött tulajdonos: " .. gotVehicleDatas[targetVeh][3]
				end
				local sw = math.ceil(dxGetTextWidth(lowerText, 0.175 * scale, traffiFont, true) * 1.1)
				dxDrawRectangle(screenX / 2 - sw / 2, screenY - h * 1.5 + sh * 0.5, sw, sh, tocolor(0, 0, 0))
				dxDrawText(lowerText, 0, screenY - h * 1.5 + sh * 0.5, screenX, screenY - h * 1.5 + sh * 1.5, tocolor(255, 255, 255, 255), 0.175 * scale, traffiFont, "center", "center", false, false, false, true)
			else
				if isElement(targetVeh) and 1 <= p then
					local plate = getVehiclePlateText(targetVeh)
					local numberPlate = split(plate, "-")
					numberPlate = table.concat(numberPlate, "-")
					local w2 = math.ceil(dxGetTextWidth(numberPlate, 0.3, traffiFont) * 1.15)
					local h2 = math.ceil(dxGetFontHeight(0.3, traffiFont) * 1.15)
					dxDrawRectangle(screenX / 2 - w2 / 2, y - h2 * 1.1, w2, h2, tocolor(0, 0, 0))
					dxDrawText(numberPlate, 0, y - h2 * 1.1, screenX, y - h2 * 0.1, tocolor(255, 255, 255, 255), 0.3 * scale, traffiFont, "center", "center")
				end
				dxDrawText(speedText, 0, y, screenX, y + h, tocolor(255, 255, 255, 255), 0.5 * scale, traffiFont, "center", "center")
			end
		end
		local time = getRealTime()
		local x, y, z = getElementPosition(localPlayer)
		if p < 1 then
			local h = math.ceil(dxGetFontHeight(0.25 * scale, traffiFont) * 1.5)
			dxDrawRectangle(0, 0, screenX, h, tocolor(0, 0, 0))
			dxDrawText(sightexports.sRadar:getZoneName(x, y, z) .. ", " .. string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second) .. ", vMax=" .. traffiMax .. " km/h, vRef=" .. math.floor(getVehicleSpeed(veh)) .. "km/h", 0, 0, screenX, h, tocolor(255, 255, 255, 255), 0.25 * scale, traffiFont, "center", "center")
			if now - traffiSet < 3000 then
				local h2 = math.ceil(dxGetFontHeight(0.5 * scale, traffiFont) * 1.5)
				dxDrawRectangle(0, h * 1.25, screenX, h2, tocolor(0, 0, 0))
				dxDrawText("vMax=" .. traffiMax .. " km/h", 0, h * 1.25, screenX, h * 1.25 + h2, tocolor(255, 255, 255, 255), 0.5 * scale, traffiFont, "center", "center")
			end
		else
			local h = math.ceil(dxGetFontHeight(0.35 * scale, traffiFont) * 1.25)
			dxDrawRectangle(0, 0, screenX, h * 2, tocolor(0, 0, 0))
			dxDrawText("Megengedett legnagyobb sebesség: " .. traffiMax .. " km/h\n" .. sightexports.sRadar:getZoneName(x, y, z) .. ", " .. string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second), 0, 0, screenX, h * 2, tocolor(255, 255, 255, 255), 0.35 * scale, traffiFont, "center", "center")
		end
		if traffiPhotoCanSend then
			if not traffiPhotoSent then
				local sx = math.min(1000, screenX)
				local rsx = math.floor(sx * 0.9)
				local sy = math.floor(sx / screenX * screenY + 0.5)
				rsx = math.floor(rsx / 4) * 4
				sy = math.floor(sy / 4) * 4
				local rt2 = dxCreateRenderTarget(rsx, sy)
				dxSetRenderTarget(rt2)
				dxDrawImage(rsx / 2 - sx / 2, 0, sx, sy, rt)
				if isElement(rt) then
					destroyElement(rt)
				end
				rt = nil
				dxSetRenderTarget()
				local x, y, z = getElementPosition(localPlayer)
				sendSpeedcamSms(targetVehDriver, rt2, x, y, z, rsx, sy, targetSpeed - traffiMax)
				if isElement(rt2) then
					destroyElement(rt2)
				end
				rt2 = nil
				traffiPhotoSent = true
			end
			traffiPhotoCanSend = false
			traffiPhotoStart = false
			traffiPhotoEnd = now
		end
	elseif 1 <= p then
		traffiPhotoStart = false
		traffiPhotoEnd = now
	end
	if traffiPhotoEnd then
		p = 1 - (now - traffiPhotoEnd) / 300
		if p < 0 then
			p = 0
			traffiPhotoEnd = false
			traffiPhotoCooldown = now
			traffiPhotoCooldownDuration = math.random(2000, 3000)
		end
	end
	if 0 < p then
		dxDrawRectangle(0, 0, screenX, screenY, tocolor(255, 255, 255, 255 * p))
	end
end
function startHandheldTraffi(max)
	if not traffiState then
		local veh = getPedOccupiedVehicle(localPlayer)
		if veh and traffipaxCars[getElementModel(veh)] then
			sightexports.sGui:showInfobox("i", "Kilépéshez használd a [Backspace] gombot.")
			sightexports.sChat:localActionC(localPlayer, "beüzemel egy traffipaxot.")
			setElementData(localPlayer, "traffipaxState", veh)
			traffiState = veh
			targetVeh = false
			targetVehDriver = false
			targetDist = false
			targetSpeed = false
			playSound("files/hardin.mp3")
			if isElement(traffiScreenSource) then
				destroyElement(traffiScreenSource)
			end
			if isElement(traffiShader) then
				destroyElement(traffiShader)
			end
			if isElement(traffiFont) then
				destroyElement(traffiFont)
			end
			traffiScreenSource = dxCreateScreenSource(screenX, screenY)
			traffiShader = dxCreateShader(shaderSource)
			dxSetShaderValue(traffiShader, "sBaseTexture", traffiScreenSource)
			traffiFont = dxCreateFont("files/W95FA.otf", 125 * screenY / 1080, false, "antialiased")
			traffiPhotoStart = false
			traffiPhotoEnd = false
			traffiPhotoCanSend = false
			traffiPhotoSent = false
			traffiPhotoCooldown = false
			traffiPhotoCooldownDuration = false
			addEventHandler("onClientPreRender", getRootElement(), preRenderCarTraffi)
			addEventHandler("onClientRender", getRootElement(), renderCarTraffi)
			addEventHandler("onClientKey", getRootElement(), keyCarTraffi, true, "high+9999999999")
			addEventHandler("onClientCursorMove", getRootElement(), cursorMoveTraffi)
			sightexports.sGui:setCursorType("none")
		end
	end
	traffiMax = max
	traffiSet = getTickCount()
end
function stopHandheldTraffi()
	if traffiState then
		traffiState = false
		targetVeh = false
		targetVehDriver = false
		targetDist = false
		targetSpeed = false
		setElementData(localPlayer, "traffipaxState", false)
		if isElement(traffiScreenSource) then
			destroyElement(traffiScreenSource)
		end
		traffiScreenSource = nil
		if isElement(traffiShader) then
			destroyElement(traffiShader)
		end
		traffiShader = nil
		if isElement(traffiFont) then
			destroyElement(traffiFont)
		end
		traffiFont = nil
		traffiPhotoStart = false
		traffiPhotoEnd = false
		traffiPhotoCanSend = false
		traffiPhotoSent = false
		traffiPhotoCooldown = false
		traffiPhotoCooldownDuration = false
		removeEventHandler("onClientPreRender", getRootElement(), preRenderCarTraffi)
		removeEventHandler("onClientRender", getRootElement(), renderCarTraffi)
		removeEventHandler("onClientKey", getRootElement(), keyCarTraffi, true, "high+9999999999")
		removeEventHandler("onClientCursorMove", getRootElement(), cursorMoveTraffi)
		sightexports.sGui:setCursorType("normal")
		traffiMax = false
		setCameraTarget(localPlayer)
		if isPedInVehicle(localPlayer) then
			playSound("files/hardout.mp3")
			sightexports.sMdc:launchMDC()
		end
	end
end
local red = false
local arrow = false
function refreshColors()
	red = sightexports.sGui:getColorCodeToColor("sightred")
	arrow = sightexports.sGui:getColorCodeToColor(traffiRadarLevel == 2 and "sightblue" or "sightgreen")
end
local currentWave = -1
local waveStart = 0
local lastMove = 0
local waveSpeed = false
local streamedTraffis = {}
function traffipaxObjectStreamIn()
	if traffiRadarObjects[source] then
		for i = #streamedTraffis, 1, -1 do
			if streamedTraffis[i][1] == source then
				table.remove(streamedTraffis, i)
			end
		end
		if traffiRadarObjects[source] == 1 then
			local x, y, z = getElementPosition(source)
			table.insert(streamedTraffis, {
				source,
				traffiRadarObjects[source],
				x,
				y,
				z
			})
		else
			table.insert(streamedTraffis, {
				source,
				traffiRadarObjects[source]
			})
		end
	end
end
function traffipaxObjectStreamOut()
	if traffiRadarObjects[source] then
		for i = #streamedTraffis, 1, -1 do
			if streamedTraffis[i][1] == source then
				table.remove(streamedTraffis, i)
			end
		end
	end
end
local traffiRadarWidgetState = false
local traffiRadarWidgetPos = {0, 0}
local traffiRadarWidgetSize = {0, 0}
local traffiRadarWidgetIs = 0
function renderRadarWidget()
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh and veh == traffiRadarVeh and traffiRadarLevel and 0 < traffiRadarLevel then
		local px, py, pz = getElementPosition(veh)
		local d = 150
		for i = #streamedTraffis, 1, -1 do
			if isElement(streamedTraffis[i][1]) then
				if traffiRadarLevel >= streamedTraffis[i][2] then
					local x, y, z
					if streamedTraffis[i][3] then
						x, y, z = streamedTraffis[i][3], streamedTraffis[i][4], streamedTraffis[i][5]
					else
						x, y, z = getElementPosition(streamedTraffis[i][1])
					end
					d = math.min(d, getDistanceBetweenPoints3D(x, y, z, px, py, pz))
				end
			else
				table.remove(streamedTraffis, i)
			end
		end
		if d < 150 then
			d = math.max(25, d)
			waveSpeed = 150 + 1050 * ((d - 25) / 125)
		else
			waveSpeed = false
			currentWave = false
			lastMove = false
		end
		local now = getTickCount()
		local sx, sy = unpack(traffiRadarWidgetSize)
		local is = traffiRadarWidgetIs
		local x, y = unpack(traffiRadarWidgetPos)
		local bg = tocolor(255, 255, 255, 50)
		if lastMove and waveSpeed and now - lastMove > math.min(150, waveSpeed / 4) then
			currentWave = currentWave + 1
			lastMove = now
			if 4 < currentWave then
				lastMove = false
				currentWave = -1
			end
		end
		if waveStart and waveSpeed and now - waveStart > waveSpeed then
			waveStart = now
			lastMove = now
			currentWave = 0
			playSound("files/radar.mp3")
		end
		sightlangStaticImageUsed[1] = true
		if sightlangStaticImageToc[1] then
			processsightlangStaticImage[1]()
		end
		dxDrawImage(x + sx / 2 - is / 2, y + sy / 2 - is / 2, is, is, sightlangStaticImage[1], 0, 0, 0, currentWave == 0 and arrow or waveSpeed and tocolor(255, 255, 255, 75) or bg)
		sightlangStaticImageUsed[2] = true
		if sightlangStaticImageToc[2] then
			processsightlangStaticImage[2]()
		end
		dxDrawImage(x + sx / 2 - is / 2, y + sy / 2 - is / 2, is, is, sightlangStaticImage[2], 0, 0, 0, waveSpeed and red or bg)
		sightlangStaticImageUsed[3] = true
		if sightlangStaticImageToc[3] then
			processsightlangStaticImage[3]()
		end
		dxDrawImage(x + sx / 2 - is * 2, y + sy / 2 - is / 2, is, is, sightlangStaticImage[3], 180, 0, 0, currentWave == 1 and arrow or bg)
		sightlangStaticImageUsed[3] = true
		if sightlangStaticImageToc[3] then
			processsightlangStaticImage[3]()
		end
		dxDrawImage(x + sx / 2 - is * 3, y + sy / 2 - is / 2, is, is, sightlangStaticImage[3], 180, 0, 0, currentWave == 2 and arrow or bg)
		sightlangStaticImageUsed[3] = true
		if sightlangStaticImageToc[3] then
			processsightlangStaticImage[3]()
		end
		dxDrawImage(x + sx / 2 - is * 4, y + sy / 2 - is / 2, is, is, sightlangStaticImage[3], 180, 0, 0, currentWave == 3 and arrow or bg)
		sightlangStaticImageUsed[3] = true
		if sightlangStaticImageToc[3] then
			processsightlangStaticImage[3]()
		end
		dxDrawImage(x + sx / 2 + is * 1, y + sy / 2 - is / 2, is, is, sightlangStaticImage[3], 0, 0, 0, currentWave == 1 and arrow or bg)
		sightlangStaticImageUsed[3] = true
		if sightlangStaticImageToc[3] then
			processsightlangStaticImage[3]()
		end
		dxDrawImage(x + sx / 2 + is * 2, y + sy / 2 - is / 2, is, is, sightlangStaticImage[3], 0, 0, 0, currentWave == 2 and arrow or bg)
		sightlangStaticImageUsed[3] = true
		if sightlangStaticImageToc[3] then
			processsightlangStaticImage[3]()
		end
		dxDrawImage(x + sx / 2 + is * 3, y + sy / 2 - is / 2, is, is, sightlangStaticImage[3], 0, 0, 0, currentWave == 3 and arrow or bg)
	end
end
addEvent("hudWidgetState:traffiRadar", true)
addEventHandler("hudWidgetState:traffiRadar", getRootElement(), function(state)
	if traffiRadarWidgetState ~= state then
		traffiRadarWidgetState = state
		if traffiRadarWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderRadarWidget)
		else
			removeEventHandler("onClientRender", getRootElement(), renderRadarWidget)
		end
	end
end)
addEvent("hudWidgetPosition:traffiRadar", true)
addEventHandler("hudWidgetPosition:traffiRadar", getRootElement(), function(pos, final)
	traffiRadarWidgetPos = pos
end)
addEvent("hudWidgetSize:traffiRadar", true)
addEventHandler("hudWidgetSize:traffiRadar", getRootElement(), function(size, final)
	traffiRadarWidgetSize = size
	traffiRadarWidgetIs = math.min(math.floor(size[1] / 8), size[2])
end)
triggerEvent("requestWidgetDatas", localPlayer, "traffiRadar")
