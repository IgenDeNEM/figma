--update bővítéshez: v2 anim + lecsúszás + tűzcsap amiről tudod tankolni a kocsit
local seexports = {
	sGroups = false,
	sModloader = false,
	sPattach = false,
	sGui = false,
}
local function seelangProcessExports()
	for k in pairs(seexports) do
		local res = getResourceFromName(k)
		if res and getResourceState(res) == "running" then
			seexports[k] = exports[k]
		else
			seexports[k] = false
		end
	end
end
seelangProcessExports()
if triggerServerEvent then
	addEventHandler("onClientResourceStart", getRootElement(), seelangProcessExports, true, "high+9999999999")
end
if triggerClientEvent then
	addEventHandler("onResourceStart", getRootElement(), seelangProcessExports, true, "high+9999999999")
end
local seelangStatImgHand = false
local seelangStaticImage = {}
local seelangStaticImageToc = {}
local seelangStaticImageUsed = {}
local seelangStaticImageDel = {}
local processSeelangStaticImage = {}
seelangStaticImageToc[0] = true
seelangStaticImageToc[1] = true
seelangStaticImageToc[2] = true
seelangStaticImageToc[3] = true
local seelangStatImgPre = nil

function seelangStatImgPre()
	local now = getTickCount()
	if seelangStaticImageUsed[0] then
		seelangStaticImageUsed[0] = false
		seelangStaticImageDel[0] = false
	elseif seelangStaticImage[0] then
		if seelangStaticImageDel[0] then
			if seelangStaticImageDel[0] <= now then
				if isElement(seelangStaticImage[0]) then
					destroyElement(seelangStaticImage[0])
				end
				seelangStaticImage[0] = nil
				seelangStaticImageDel[0] = false
				seelangStaticImageToc[0] = true
				return
			end
		else
			seelangStaticImageDel[0] = now + 5000
		end
	else
		seelangStaticImageToc[0] = true
	end
	if seelangStaticImageUsed[1] then
		seelangStaticImageUsed[1] = false
		seelangStaticImageDel[1] = false
	elseif seelangStaticImage[1] then
		if seelangStaticImageDel[1] then
			if seelangStaticImageDel[1] <= now then
				if isElement(seelangStaticImage[1]) then
					destroyElement(seelangStaticImage[1])
				end
				seelangStaticImage[1] = nil
				seelangStaticImageDel[1] = false
				seelangStaticImageToc[1] = true
				return
			end
		else
			seelangStaticImageDel[1] = now + 5000
		end
	else
		seelangStaticImageToc[1] = true
	end
	if seelangStaticImageUsed[2] then
		seelangStaticImageUsed[2] = false
		seelangStaticImageDel[2] = false
	elseif seelangStaticImage[2] then
		if seelangStaticImageDel[2] then
			if seelangStaticImageDel[2] <= now then
				if isElement(seelangStaticImage[2]) then
					destroyElement(seelangStaticImage[2])
				end
				seelangStaticImage[2] = nil
				seelangStaticImageDel[2] = false
				seelangStaticImageToc[2] = true
				return
			end
		else
			seelangStaticImageDel[2] = now + 5000
		end
	else
		seelangStaticImageToc[2] = true
	end
	if seelangStaticImageUsed[3] then
		seelangStaticImageUsed[3] = false
		seelangStaticImageDel[3] = false
	elseif seelangStaticImage[3] then
		if seelangStaticImageDel[3] then
			if seelangStaticImageDel[3] <= now then
				if isElement(seelangStaticImage[3]) then
					destroyElement(seelangStaticImage[3])
				end
				seelangStaticImage[3] = nil
				seelangStaticImageDel[3] = false
				seelangStaticImageToc[3] = true
				return
			end
		else
			seelangStaticImageDel[3] = now + 5000
		end
	else
		seelangStaticImageToc[3] = true
	end
	if seelangStaticImageToc[0] and seelangStaticImageToc[1] and seelangStaticImageToc[2] and seelangStaticImageToc[3] then
		seelangStatImgHand = false
		removeEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre)
	end
end
processSeelangStaticImage[0] = function()
	if not isElement(seelangStaticImage[0]) then
		seelangStaticImageToc[0] = false
		seelangStaticImage[0] = dxCreateTexture("files/grad.dds", "argb", true)
	end
	if not seelangStatImgHand then
		seelangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
	end
end
processSeelangStaticImage[1] = function()
	if not isElement(seelangStaticImage[1]) then
		seelangStaticImageToc[1] = false
		seelangStaticImage[1] = dxCreateTexture("files/fball.dds", "argb", true)
	end
	if not seelangStatImgHand then
		seelangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
	end
end
processSeelangStaticImage[2] = function()
	if not isElement(seelangStaticImage[2]) then
		seelangStaticImageToc[2] = false
		seelangStaticImage[2] = dxCreateTexture("files/collisionsmoke.dds", "argb", true)
	end
	if not seelangStatImgHand then
		seelangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
	end
end
processSeelangStaticImage[3] = function()
	if not isElement(seelangStaticImage[3]) then
		seelangStaticImageToc[3] = false
		seelangStaticImage[3] = dxCreateTexture("files/water.dds", "argb", true)
	end
	if not seelangStatImgHand then
		seelangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), seelangStatImgPre, true, "high+999999999")
	end
end
local seelangWaiterState0 = false
local function seelangProcessResWaiters()
	if not seelangWaiterState0 then
		local res0 = getResourceFromName("sGroups")
		if res0 and getResourceState(res0) == "running" then
			refreshInMembership()
			seelangWaiterState0 = true
		end
	end
end
if triggerServerEvent then
	addEventHandler("onClientResourceStart", getRootElement(), seelangProcessResWaiters)
end
if triggerClientEvent then
	addEventHandler("onResourceStart", getRootElement(), seelangProcessResWaiters)
end
local grey1 = false
local grey3 = false
local green = false
local red = false
local orange = false
local blue = false
local greenTocolor = false
local redTocolor = false
local blueTocolor = false
local grey1Tocolor = false
local grey3Tocolor = false
local toolsIcon = false
local hintFont = false
local hintFontScale = false
local displayFont = false
local displayFontScale = false
local faTicks = false

local function seelangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		grey1 = seexports.sGui:getColorCode("sightgrey1")
		grey1 = seexports.sGui:getColorCode("sightgrey1")
		grey3 = seexports.sGui:getColorCode("sightgrey3")
		green = seexports.sGui:getColorCode("sightgreen")
		red = seexports.sGui:getColorCode("sightred")
		orange = seexports.sGui:getColorCode("sightorange")
		blue = seexports.sGui:getColorCode("sightblue")
		greenTocolor = seexports.sGui:getColorCodeToColor("sightgreen")
		redTocolor = seexports.sGui:getColorCodeToColor("sightred")
		blueTocolor = seexports.sGui:getColorCodeToColor("sightblue")
		grey1Tocolor = seexports.sGui:getColorCodeToColor("sightgrey1")
		grey3Tocolor = seexports.sGui:getColorCodeToColor("sightgrey3")
		toolsIcon = seexports.sGui:getFaIconFilename("tools", 24)
		hintFont = seexports.sGui:getFont("25/BebasNeueBold.otf")
		hintFontScale = seexports.sGui:getFontScale("25/BebasNeueBold.otf")
		displayFont = seexports.sGui:getFont("11/Ubuntu-B.ttf")
		displayFontScale = seexports.sGui:getFontScale("11/Ubuntu-B.ttf")
		faTicks = seexports.sGui:getFaTicks()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), seelangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), seelangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
	faTicks = seexports.sGui:getFaTicks()
end)
local function seelangModloaderLoaded()
	modloaderListener()
end
addEventHandler("modloaderLoaded", getRootElement(), seelangModloaderLoaded)
local firemanGroup = nil
local firemanPermission = nil
if getElementData(localPlayer, "loggedIn") or seexports.sModloader and seexports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), seelangModloaderLoaded)
end
local seelangCondHandlState7 = false
local function checkPreRenderFireHealth(cond, prio)
	cond = cond and true or false
	if cond ~= seelangCondHandlState7 then
		seelangCondHandlState7 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), preRenderFireHealth, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderFireHealth)
		end
	end
end
local seelangCondHandlState6 = false
local function checkRenderFireHealth(cond, prio)
	cond = cond and true or false
	if cond ~= seelangCondHandlState6 then
		seelangCondHandlState6 = cond
		if cond then
			addEventHandler("onClientRender", getRootElement(), renderFireHealth, true, prio)
		else
			removeEventHandler("onClientRender", getRootElement(), renderFireHealth)
		end
	end
end
local seelangCondHandlState5 = false
local function checkPreRenderWaterEmitters(cond, prio)
	cond = cond and true or false
	if cond ~= seelangCondHandlState5 then
		seelangCondHandlState5 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), preRenderWaterEmitters, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderWaterEmitters)
		end
	end
end
local seelangCondHandlState4 = false
local function checkRenderWaterParticles(cond, prio)
	cond = cond and true or false
	if cond ~= seelangCondHandlState4 then
		seelangCondHandlState4 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), renderWaterParticles, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), renderWaterParticles)
		end
	end
end
local seelangCondHandlState3 = false
local function checkPreRenderFires(cond, prio)
	cond = cond and true or false
	if cond ~= seelangCondHandlState3 then
		seelangCondHandlState3 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), preRenderFires, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderFires)
		end
	end
end
local seelangCondHandlState2 = false
local function checkClickFireTrucks(cond, prio)
	cond = cond and true or false
	if cond ~= seelangCondHandlState2 then
		seelangCondHandlState2 = cond
		if cond then
			addEventHandler("onClientClick", getRootElement(), clickFireTrucks, true, prio)
		else
			removeEventHandler("onClientClick", getRootElement(), clickFireTrucks)
		end
	end
end
local seelangCondHandlState1 = false
local function checkRenderFireTrucks(cond, prio)
	cond = cond and true or false
	if cond ~= seelangCondHandlState1 then
		seelangCondHandlState1 = cond
		if cond then
			addEventHandler("onClientRender", getRootElement(), renderFireTrucks, true, prio)
		else
			removeEventHandler("onClientRender", getRootElement(), renderFireTrucks)
		end
	end
end
local seelangCondHandlState0 = false
local function checkPreRenderFireTrucks(cond, prio)
	cond = cond and true or false
	if cond ~= seelangCondHandlState0 then
		seelangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), preRenderFireTrucks, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderFireTrucks)
		end
	end
end

local playerNozzleObjects = {}
local firetruckDatas = {}
local hoseSegmentLength = 0.3
local hoseSegmentThickness = 0.075
screenX, screenY = guiGetScreenSize()
function processPermission()
	local tmp = seexports.sGroups:getPlayerPermission("fireman")
	if tmp ~= firemanPermission then
		firemanPermission = tmp
	end
end
addEvent("gotPlayerGroupPermissions", true)
addEventHandler("gotPlayerGroupPermissions", getRootElement(), function()
	processPermission()
end)
function refreshInMembership()
	local tmp = seexports.sGroups:isPlayerInGroup(groupPrefix)
	if firemanGroup ~= tmp then
		firemanPermission = false
		firemanGroup = tmp
		refreshBlip()
		processPermission()
	end
end
addEvent("gotPlayerGroupMembership", true)
addEventHandler("gotPlayerGroupMembership", getRootElement(), refreshInMembership)
function createLine(x, y, z, r)
	local lines = {}
	local numLines = math.floor(1000 / 15) -- 15 (20 hoseLength) / hoseSegmentLength better
	local rad = math.rad(r - 90)
	local cos = math.cos(rad)
	local sin = math.sin(rad)
	local nx = -sin
	local ny = cos
	local mod = math.floor(numLines / 4)
	y = y + sin * hoseSegmentLength * 3
	x = x + cos * hoseSegmentLength * 3
	for i = 1, numLines, 1 do
		if i % mod == 0 then
			sin = -sin
			cos = -cos
			y = y + ny * hoseSegmentThickness * 1.5
			x = x + nx * hoseSegmentThickness * 1.5
		end
		y = y + sin * hoseSegmentLength
		x = x + cos * hoseSegmentLength
		table.insert(lines, {x, y, z})
	end
	return lines
end
local groundCache = {}
function setGroundPosCache(zx, zy, zz, gz)
	if not groundCache[zx] then
		groundCache[zx] = {}
	end
	if not groundCache[zx][zy] then
		groundCache[zx][zy] = {}
	end
	groundCache[zx][zy][zz] = gz
end
function cachedGroundPosition(x, y, z)
	local zx = math.floor(x / 0.25)
	local zy = math.floor(y / 0.25)
	local zz = math.floor(z / 0.25)
	if groundCache[zx] and groundCache[zx][zy] and groundCache[zx][zy][zz] then
		return groundCache[zx][zy][zz]
	end
	local gz = getGroundPosition(x, y, z)
	if gz and gz ~= 0 then
		setGroundPosCache(zx, zy, zz, gz)
		return gz
	end
end
local matrixCache = {}
local pumpPosCache = {}
function getVehiclePumpPosition(veh, side)
	if pumpPosCache[veh] and pumpPosCache[veh][side] then
		return unpack(pumpPosCache[veh][side])
	end
	local m = matrixCache[veh] or getElementMatrix(veh)
	matrixCache[veh] = m
	if m then
		local x = m[4][1] + sidePoses[side][1] * m[1][1] + sidePoses[side][2] * m[2][1] + sidePoses[side][3] * m[3][1]
		local y = m[4][2] + sidePoses[side][1] * m[1][2] + sidePoses[side][2] * m[2][2] + sidePoses[side][3] * m[3][2]
		local z = m[4][3] + sidePoses[side][1] * m[1][3] + sidePoses[side][2] * m[2][3] + sidePoses[side][3] * m[3][3]
		if not pumpPosCache[veh] then
			pumpPosCache[veh] = {}
		end
		pumpPosCache[veh][side] = {x, y, z}
		return x, y, z
	end
	return 0, 0, 0
end
local modelIds = {}
function modloaderListener()
	local v4_fire_watertank = seexports.sModloader:getModelId("v4_fire_watertank")
	modelIds.v4_fire_waterhose = seexports.sModloader:getModelId("v4_fire_waterhose")
	modelIds.v4_fire_nozzle = seexports.sModloader:getModelId("v4_fire_nozzle")
	modelIds.v4_fire_hose_balljoint = seexports.sModloader:getModelId("v4_fire_hose_balljoint")
	for i = 1, #refillPositions, 1 do
		if isElement(refillPositions[i].object) then
			destroyElement(refillPositions[i].object)
		end
		refillPositions[i].object = nil
		refillPositions[i].object = createObject(v4_fire_watertank, refillPositions[i].objectPosition[1], refillPositions[i].objectPosition[2], refillPositions[i].objectPosition[3], 0, 0, refillPositions[i].objectPosition[4])
		local rad = math.rad(refillPositions[i].objectPosition[4])
		local cos = math.cos(rad)
		local sin = math.sin(rad)
		refillPositions[i].offset = {
			refillPositions[i].objectPosition[1] + cos * 2.6299,
			refillPositions[i].objectPosition[2] + sin * 2.6299,
			refillPositions[i].objectPosition[3] + 0.5,
			refillPositions[i].objectPosition[1] + cos * 2.9296 - sin * 0.0478,
			refillPositions[i].objectPosition[2] + sin * 2.9296 + cos * 0.0478,
			refillPositions[i].objectPosition[3] + 0.611,
			refillPositions[i].objectPosition[4]
		}
	end
end
local selfFireTruck = false
local selfFireNozzle = false
function firetruckDataChange(fireTruck, dataName, newValue)
	if dataName:sub(1, 10) == "fireNozzle" then
		if not firetruckDatas[fireTruck].fireNozzle then
			firetruckDatas[fireTruck].fireNozzle = {}
		end
		local nozzleId = tonumber(split(dataName, ":")[2])
		if sidePoses[nozzleId] then
			if firetruckDatas[fireTruck].fireNozzle[nozzleId] and firetruckDatas[fireTruck].fireNozzle[nozzleId].user == localPlayer then
				selfFireTruck = nil
				selfFireNozzle = nil
			end
			if newValue then
				if not firetruckDatas[fireTruck].fireNozzle[nozzleId] then
					firetruckDatas[fireTruck].fireNozzle[nozzleId] = {}
				end
				local nozzlePosX = 0
				local nozzlePosY = 0
				local nozzlePosZ = 0
				local nozzleRotZ = 0
				if isElement(newValue) then
					nozzlePosX, nozzlePosY, nozzlePosZ = getElementPosition(newValue)
					if firetruckDatas[fireTruck].fireNozzle[nozzleId].refill then
						local watertankId = tonumber(firetruckDatas[fireTruck].fireNozzle[nozzleId].refill)
						playSound3D("files/detach.mp3", refillPositions[watertankId].offset[4], refillPositions[watertankId].offset[5], refillPositions[watertankId].offset[6])
					elseif not firetruckDatas[fireTruck].fireNozzle[nozzleId].pos then
						local pumpPosX, pumpPosY, pumpPosZ = getVehiclePumpPosition(fireTruck, nozzleId)
						playSound3D("files/attach.mp3", pumpPosX, pumpPosY, pumpPosZ)
					else
						playSound3D("files/pick.mp3", nozzlePosX, nozzlePosY, nozzlePosZ)
					end
					firetruckDatas[fireTruck].fireNozzle[nozzleId].user = newValue
					firetruckDatas[fireTruck].fireNozzle[nozzleId].refill = nil
					if newValue == localPlayer then
						selfFireTruck = fireTruck
						selfFireNozzle = nozzleId
					end
				elseif tonumber(newValue) then
					local watertankId = tonumber(newValue)
					firetruckDatas[fireTruck].fireNozzle[nozzleId].user = nil
					nozzlePosZ = refillPositions[watertankId].offset[6]
					nozzlePosY = refillPositions[watertankId].offset[5]
					nozzlePosX = refillPositions[watertankId].offset[4]
					nozzleRotZ = refillPositions[watertankId].offset[7]
					firetruckDatas[fireTruck].fireNozzle[nozzleId].refill = watertankId
					firetruckDatas[fireTruck].fireNozzle[nozzleId].pos = {nozzlePosX, nozzlePosY, nozzlePosZ}
					playSound3D("files/attach.mp3", nozzlePosX, nozzlePosY, nozzlePosZ)
				else
					nozzlePosX, nozzlePosY, nozzlePosZ = unpack(newValue)
					if firetruckDatas[fireTruck].fireNozzle[nozzleId].user then
						playerNozzleObjects[firetruckDatas[fireTruck].fireNozzle[nozzleId].user] = nil
					end
					firetruckDatas[fireTruck].fireNozzle[nozzleId].user = nil
					firetruckDatas[fireTruck].fireNozzle[nozzleId].pos = newValue
					firetruckDatas[fireTruck].fireNozzle[nozzleId].refill = nil
					playSound3D("files/drop.mp3", nozzlePosX, nozzlePosY, nozzlePosZ)
				end
				firetruckDatas[fireTruck].fireNozzle[nozzleId].zReset = nil
				if isElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].object) then
					seexports.sPattach:detach(firetruckDatas[fireTruck].fireNozzle[nozzleId].object)
					setElementPosition(firetruckDatas[fireTruck].fireNozzle[nozzleId].object, nozzlePosX, nozzlePosY, nozzlePosZ)
					setElementRotation(firetruckDatas[fireTruck].fireNozzle[nozzleId].object, -1, 29, 183 + nozzleRotZ)
				else
					firetruckDatas[fireTruck].fireNozzle[nozzleId].object = createObject(modelIds[(nozzleId > 1 and "v4_fire_nozzle" or "v4_fire_waterhose")], nozzlePosX, nozzlePosY, nozzlePosZ, -1, 29, 183 + nozzleRotZ)
					setElementCollisionsEnabled(firetruckDatas[fireTruck].fireNozzle[nozzleId].object, false)
				end
				if not isElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].joint1) then
					firetruckDatas[fireTruck].fireNozzle[nozzleId].joint1 = createObject(modelIds.v4_fire_hose_balljoint, nozzlePosX, nozzlePosY, nozzlePosZ)
					setElementCollisionsEnabled(firetruckDatas[fireTruck].fireNozzle[nozzleId].joint1, false)
					if nozzleId == 1 then
						setObjectScale(firetruckDatas[fireTruck].fireNozzle[nozzleId].joint1, 1.5)
					end
				end
				if not isElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].joint2) then
					firetruckDatas[fireTruck].fireNozzle[nozzleId].joint2 = createObject(modelIds.v4_fire_hose_balljoint, nozzlePosX, nozzlePosY, nozzlePosZ)
					setElementCollisionsEnabled(firetruckDatas[fireTruck].fireNozzle[nozzleId].joint2, false)
					if nozzleId == 1 then
						setObjectScale(firetruckDatas[fireTruck].fireNozzle[nozzleId].joint2, 1.5)
					end
				end
				if isElement(newValue) then
					if nozzleId > 1 then
						if not isElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].sound) then
							firetruckDatas[fireTruck].fireNozzle[nozzleId].sound = playSound3D("files/hose.mp3", nozzlePosX, nozzlePosY, nozzlePosZ, true)
							attachElements(firetruckDatas[fireTruck].fireNozzle[nozzleId].sound, firetruckDatas[fireTruck].fireNozzle[nozzleId].object)
							setSoundVolume(firetruckDatas[fireTruck].fireNozzle[nozzleId].sound, 0)
							setSoundMaxDistance(firetruckDatas[fireTruck].fireNozzle[nozzleId].sound, 50)
						end
					else
						if isElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].sound) then
							destroyElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].sound)
						end
						firetruckDatas[fireTruck].fireNozzle[nozzleId].sound = nil
					end
					seexports.sPattach:attach(firetruckDatas[fireTruck].fireNozzle[nozzleId].object, newValue, "weapon")
				else
					if isElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].sound) then
						destroyElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].sound)
					end
					firetruckDatas[fireTruck].fireNozzle[nozzleId].sound = nil
				end
				if firetruckDatas[fireTruck].fireNozzle[nozzleId].lines then
					for i = 1, #firetruckDatas[fireTruck].fireNozzle[nozzleId].lines, 1 do
						firetruckDatas[fireTruck].fireNozzle[nozzleId].lines[i][3] = nil
					end
				else
					local posX, posY, posZ = getVehiclePumpPosition(fireTruck, nozzleId)
					local rotX, rotY, rotZ = getElementRotation(fireTruck)
					firetruckDatas[fireTruck].fireNozzle[nozzleId].lines = createLine(posX, posY, posZ, rotZ)
				end
			elseif firetruckDatas[fireTruck].fireNozzle[nozzleId] then
				if firetruckDatas[fireTruck].fireNozzle[nozzleId].user then
					local nozzlePosX, nozzlePosY, nozzlePosZ = getVehiclePumpPosition(fireTruck, nozzleId)
					playSound3D("files/detach.mp3", nozzlePosX, nozzlePosY, nozzlePosZ)
				end
				if isElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].object) then
					destroyElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].object)
				end
				firetruckDatas[fireTruck].fireNozzle[nozzleId].object = nil
				if isElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].sound) then
					destroyElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].sound)
				end
				firetruckDatas[fireTruck].fireNozzle[nozzleId].sound = nil
				if isElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].joint1) then
					destroyElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].joint1)
				end
				firetruckDatas[fireTruck].fireNozzle[nozzleId].joint1 = nil
				if isElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].joint2) then
					destroyElement(firetruckDatas[fireTruck].fireNozzle[nozzleId].joint2)
				end
				firetruckDatas[fireTruck].fireNozzle[nozzleId].joint2 = nil
				firetruckDatas[fireTruck].fireNozzle[nozzleId] = nil
			end
		end
	else
		if dataName ~= "fireWater" then
		end
		firetruckDatas[fireTruck][dataName] = newValue
	end
end
function firetruckDataChangeHandler(dataName, oldValue, newValue)
	firetruckDataChange(source, dataName, newValue)
end
local hoverAction = false
local hoverFireTruck = false
local hoverFireNozzle = false
function clickFireTrucks(button, state)
	if state == "up" then
		if hoverAction == "useNozzle" or hoverAction == "pickNozzle" or hoverAction == "removeRefill" then
			triggerServerEvent("firetruckUseNozzle", localPlayer, hoverFireTruck, hoverFireNozzle)
		elseif hoverAction == "refillNozzle" then
			triggerServerEvent("firetruckRefillNozzle", localPlayer, hoverFireNozzle)
		elseif hoverAction == "unuseNozzle" then
			triggerServerEvent("firetruckUnuseNozzle", localPlayer)
		end
	end
end
local selfPosX = 0
local selfPosY = 0
local selfPosZ = 0
local fKeyPressed = false
local hoseIsStretching = false
local usingPumpSynced = false
local usingPumpDelta = 0
function renderFireTrucks()
	local cx, cy = getCursorPosition()
	if cx then
		cy = cy * screenY
		cx = cx * screenX
	end
	local tmpAction = false
	local tmpFireTruck = false
	local tmpFireNozzle = false
	if hoseIsStretching then
		dxDrawText("Feszül a tömlő!", 1, screenY * 0.8 + 1, screenX + 1, screenY * 0.8 + 1, tocolor(0, 0, 0, 200), hintFontScale, hintFont, "center", "center")
		dxDrawText("Feszül a tömlő!", 0, screenY * 0.8, screenX, screenY * 0.8, redTocolor, hintFontScale, hintFont, "center", "center")
		hoseIsStretching = false
	end
	if selfFireTruck and selfFireNozzle then
		if selfFireNozzle == 1 then
			for i = 1, #refillPositions, 1 do
				local x = refillPositions[i].offset[1]
				local y = refillPositions[i].offset[2]
				local z = refillPositions[i].offset[3]
				local d = getDistanceBetweenPoints3D(x, y, z, selfPosX, selfPosY, selfPosZ)
				if d < 2 then
					local sx, sy = getScreenFromWorldPosition(x, y, z, 16)
					if sx then
						local a = (1 - math.max(0, (d - 1.75) / 0.25)) * 255
						dxDrawRectangle(sx - 16, sy - 16, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], a))
						if cx and 255 <= a and sx - 16 <= cx and sy - 16 <= cy and cx <= sx + 16 and cy <= sy + 16 then
							tmpAction = "refillNozzle"
							tmpFireNozzle = i
							dxDrawImage(sx - 12, sy - 12, 24, 24, ":sGui/" .. toolsIcon .. faTicks[toolsIcon], 0, 0, 0, greenTocolor)
						else
							dxDrawImage(sx - 12, sy - 12, 24, 24, ":sGui/" .. toolsIcon .. faTicks[toolsIcon], 0, 0, 0, tocolor(255, 255, 255, a))
						end
					end
				end
			end
		end
		local x, y, z = getVehiclePumpPosition(selfFireTruck, selfFireNozzle)
		local sx, sy = getScreenFromWorldPosition(x, y, z, 16)
		if sx then
			local d = getDistanceBetweenPoints3D(x, y, z, selfPosX, selfPosY, selfPosZ)
			if d < 2 then
				local a = (1 - math.max(0, (d - 1.75) / 0.25)) * 255
				dxDrawRectangle(sx - 16, sy - 16, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], a))
				if cx and 255 <= a and sx - 16 <= cx and sy - 16 <= cy and cx <= sx + 16 and cy <= sy + 16 then
					tmpAction = "unuseNozzle"
					tmpFireTruck = veh
					tmpFireNozzle = i
					dxDrawImage(sx - 12, sy - 12, 24, 24, ":sGui/" .. toolsIcon .. faTicks[toolsIcon], 0, 0, 0, greenTocolor)
				else
					dxDrawImage(sx - 12, sy - 12, 24, 24, ":sGui/" .. toolsIcon .. faTicks[toolsIcon], 0, 0, 0, tocolor(255, 255, 255, a))
				end
			end
		end
		local displayText = "Víztartály: " .. math.floor(firetruckDatas[selfFireTruck].displayedFireWater * 1500) .. "L"
		dxDrawText(displayText, 1, 0, screenX + 1, screenY * 0.9 - 16 - 16 - 4 + 1, tocolor(0, 0, 0, 200), displayFontScale, displayFont, "center", "bottom")
		dxDrawText(displayText, 0, 0, screenX, screenY * 0.9 - 16 - 16 - 4, tocolor(255, 255, 255), displayFontScale, displayFont, "center", "bottom")
		dxDrawRectangle(screenX / 2 - 200, screenY * 0.9 - 16 - 16, 400, 16, grey1Tocolor)
		dxDrawRectangle(screenX / 2 - 200 + 2, screenY * 0.9 - 16 - 16 + 2, 396, 12, grey3Tocolor)
		dxDrawRectangle(screenX / 2 - 200 + 2, screenY * 0.9 - 16 - 16 + 2, 396 * firetruckDatas[selfFireTruck].displayedFireWater, 12, blueTocolor)
		if getKeyState("mouse1") and not isCursorShowing() and 1 < selfFireNozzle and 0 < firetruckDatas[selfFireTruck].fireWater and not usingPumpSynced then
			triggerServerEvent("syncUsingPump", localPlayer, true)
			usingPumpSynced = true
			usingPumpDelta = 500
		elseif usingPumpSynced and usingPumpDelta <= 0 then
			if firetruckDatas[selfFireTruck].fireWater <= 0 then
				seexports.sGui:showInfobox("e", "Elfogyott a víz a tartályból!")
				triggerServerEvent("syncUsingPump", localPlayer)
				usingPumpSynced = false
			end
			if not getKeyState("mouse1") then
				triggerServerEvent("syncUsingPump", localPlayer)
				usingPumpSynced = false
			end
		end
		if getKeyState("f") and not isCursorShowing() and not isChatBoxInputActive() and not isConsoleActive() then
			fKeyPressed = true
		elseif fKeyPressed then
			fKeyPressed = false
			selfFireTruck = nil
			selfFireNozzle = nil
			triggerServerEvent("firetruckUnuseNozzle", localPlayer, true)
		end
	else
		if usingPumpSynced then
			triggerServerEvent("syncUsingPump", localPlayer)
			usingPumpSynced = false
		end
		fKeyPressed = false
		if firemanPermission then
			for fireTruck, truckData in pairs(firetruckDatas) do
				local truckPosX, truckPosY, truckPosZ = getElementPosition(fireTruck)
				for nozzleId = 1, #sidePoses, 1 do
					if truckData.fireNozzle[nozzleId] and not truckData.fireNozzle[nozzleId].user and truckData.fireNozzle[nozzleId].pos then
						local nozzlePosX, nozzlePosY, nozzlePosZ = unpack(truckData.fireNozzle[nozzleId].pos)
						local sx, sy = getScreenFromWorldPosition(nozzlePosX, nozzlePosY, nozzlePosZ, 16)
						if sx then
							local d = getDistanceBetweenPoints3D(nozzlePosX, nozzlePosY, nozzlePosZ, selfPosX, selfPosY, selfPosZ)
							if d < 2 then
								local a = (1 - math.max(0, (d - 1.75) / (2 - 1.75))) * 255
								dxDrawRectangle(sx - 16, sy - 16, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], a))
								if cx and 255 <= a and sx - 16 <= cx and sy - 16 <= cy and cx <= sx + 16 and cy <= sy + 16 then
									tmpAction = "pickNozzle"
									tmpFireTruck = fireTruck
									tmpFireNozzle = nozzleId
									dxDrawImage(sx - 12, sy - 12, 24, 24, ":sGui/" .. toolsIcon .. faTicks[toolsIcon], 0, 0, 0, greenTocolor)
								else
									dxDrawImage(sx - 12, sy - 12, 24, 24, ":sGui/" .. toolsIcon .. faTicks[toolsIcon], 0, 0, 0, tocolor(255, 255, 255, a))
								end
							end
						end
					elseif truckData.fireNozzle[nozzleId] and truckData.fireNozzle[nozzleId].refill then
						local watertankId = truckData.fireNozzle[nozzleId].refill
						local watertankPosX = refillPositions[watertankId].offset[1]
						local watertankPosY = refillPositions[watertankId].offset[2]
						local watertankPosZ = refillPositions[watertankId].offset[3]
						local sx, sy = getScreenFromWorldPosition(watertankPosX, watertankPosY, watertankPosZ, 128)
						if sx then
							local d = getDistanceBetweenPoints3D(watertankPosX, watertankPosY, watertankPosZ, selfPosX, selfPosY, selfPosZ)
							if d < 2 then
								local a = 1 - math.max(0, (d - 1.75) / 0.25)
								dxDrawRectangle(sx - 16, sy - 16, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], 255 * a))
								if cx and 1 <= a and sx - 16 <= cx and sy - 16 <= cy and cx <= sx + 16 and cy <= sy + 16 then
									tmpAction = "removeRefill"
									tmpFireTruck = fireTruck
									tmpFireNozzle = nozzleId
									dxDrawImage(sx - 12, sy - 12, 24, 24, ":sGui/" .. toolsIcon .. faTicks[toolsIcon], 0, 0, 0, greenTocolor)
								else
									dxDrawImage(sx - 12, sy - 12, 24, 24, ":sGui/" .. toolsIcon .. faTicks[toolsIcon], 0, 0, 0, tocolor(255, 255, 255, 255 * a))
								end
								sy = sy - 24
								local displayText = "Víztartály: " .. math.floor(truckData.displayedFireWater * 1500) .. "L"
								dxDrawText(displayText, sx + 1, 0, sx + 1, sy - 5 - 2 + 1, tocolor(0, 0, 0, 200 * a), displayFontScale * 0.9, displayFont, "center", "bottom")
								dxDrawText(displayText, sx, 0, sx, sy - 5 - 2, tocolor(255, 255, 255, 255 * a), displayFontScale * 0.9, displayFont, "center", "bottom")
								dxDrawRectangle(sx - 64, sy - 5, 128, 10, tocolor(grey1[1], grey1[2], grey1[3], 255 * a))
								dxDrawRectangle(sx - 64 + 1, sy - 5 + 1, 126, 8, tocolor(grey3[1], grey3[2], grey3[3], 255 * a))
								dxDrawRectangle(sx - 64 + 1, sy - 5 + 1, 126 * truckData.displayedFireWater, 8, tocolor(blue[1], blue[2], blue[3], 255 * a))
							end
						end
					end
				end
				if getDistanceBetweenPoints3D(truckPosX, truckPosY, truckPosZ, selfPosX, selfPosY, selfPosZ) < 20 then
					local pumpPosX, pumpPosY, pumpPosZ = getVehiclePumpPosition(fireTruck, 1)
					pumpPosZ = pumpPosZ + 0.25
					local sx, sy = getScreenFromWorldPosition(pumpPosX, pumpPosY, pumpPosZ, 128)
					if sx then
						local d = getDistanceBetweenPoints3D(pumpPosX, pumpPosY, pumpPosZ, selfPosX, selfPosY, selfPosZ)
						if d < 4 then
							local a = 1 - math.max(0, (d - 3) / (4 - 3))
							local displayText = "Víztartály: " .. math.floor(truckData.displayedFireWater * 1500) .. "L"
							dxDrawText(displayText, sx + 1, 0, sx + 1, sy - 5 - 2 + 1, tocolor(0, 0, 0, 200 * a), displayFontScale * 0.9, displayFont, "center", "bottom")
							dxDrawText(displayText, sx, 0, sx, sy - 5 - 2, tocolor(255, 255, 255, 255 * a), displayFontScale * 0.9, displayFont, "center", "bottom")
							dxDrawRectangle(sx - 64, sy - 5, 128, 10, tocolor(grey1[1], grey1[2], grey1[3], 255 * a))
							dxDrawRectangle(sx - 64 + 1, sy - 5 + 1, 126, 8, tocolor(grey3[1], grey3[2], grey3[3], 255 * a))
							dxDrawRectangle(sx - 64 + 1, sy - 5 + 1, 126 * truckData.displayedFireWater, 8, tocolor(blue[1], blue[2], blue[3], 255 * a))
						end
					end
					for nozzleId = 1, #sidePoses, 1 do
						if not truckData.fireNozzle[nozzleId] then
							local pumpPosX, pumpPosY, pumpPosZ = getVehiclePumpPosition(fireTruck, nozzleId)
							local sx, sy = getScreenFromWorldPosition(pumpPosX, pumpPosY, pumpPosZ, 16)
							if sx then
								local d = getDistanceBetweenPoints3D(pumpPosX, pumpPosY, pumpPosZ, selfPosX, selfPosY, selfPosZ)
								if d < 2 then
									local a = (1 - math.max(0, (d - 1.75) / 0.25)) * 255
									dxDrawRectangle(sx - 16, sy - 16, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], a))
									if cx and 255 <= a and sx - 16 <= cx and sy - 16 <= cy and cx <= sx + 16 and cy <= sy + 16 then
										tmpAction = "useNozzle"
										tmpFireTruck = fireTruck
										tmpFireNozzle = nozzleId
										dxDrawImage(sx - 12, sy - 12, 24, 24, ":sGui/" .. toolsIcon .. faTicks[toolsIcon], 0, 0, 0, greenTocolor)
									else
										dxDrawImage(sx - 12, sy - 12, 24, 24, ":sGui/" .. toolsIcon .. faTicks[toolsIcon], 0, 0, 0, tocolor(255, 255, 255, a))
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if tmpAction ~= hoverAction or tmpFireTruck ~= hoverFireTruck or tmpFireNozzle ~= hoverFireNozzle then
		hoverAction = tmpAction
		hoverFireTruck = tmpFireTruck
		hoverFireNozzle = tmpFireNozzle
		if tmpAction then
			if tmpAction == "unuseNozzle" then
				seexports.sGui:showTooltip("Tömlő leszerelése")
			elseif tmpAction == "useNozzle" then
				seexports.sGui:showTooltip("Tömlő felszerelése")
			elseif tmpAction == "pickNozzle" then
				seexports.sGui:showTooltip("Tömlő felvétele")
			elseif tmpAction == "removeRefill" then
				seexports.sGui:showTooltip("Tömlő leszerelése a tartályról")
			elseif tmpAction == "refillNozzle" then
				seexports.sGui:showTooltip("Tömlő felszerelése a tartályra")
			else
				seexports.sGui:showTooltip()
			end
			seexports.sGui:setCursorType("link")
		else
			seexports.sGui:showTooltip()
			seexports.sGui:setCursorType("normal")
		end
	end
end
function calculateRotation(vectorX, vectorY, vectorZ)
	local vectorLength = math.sqrt(vectorX ^ 2 + vectorY ^ 2 + vectorZ ^ 2)
	vectorX = vectorX / vectorLength
	vectorY = vectorY / vectorLength
	vectorZ = vectorZ / vectorLength
	return math.deg(math.atan2(vectorY, vectorX)) + 180, -math.deg(math.acos(vectorZ)) + 90
end
function getRotMatrix(rx, ry, rz)
	rz = math.rad(rz)
	ry = math.rad(ry)
	rx = math.rad(rx)
	local m = {}
	m[1] = {}
	m[1][1] = math.cos(rz) * math.cos(ry) - math.sin(rz) * math.sin(rx) * math.sin(ry)
	m[1][2] = math.cos(ry) * math.sin(rz) + math.cos(rz) * math.sin(rx) * math.sin(ry)
	m[1][3] = -math.cos(rx) * math.sin(ry)
	m[1][4] = 1
	m[2] = {}
	m[2][1] = -math.cos(rx) * math.sin(rz)
	m[2][2] = math.cos(rz) * math.cos(rx)
	m[2][3] = math.sin(rx)
	m[2][4] = 1
	m[3] = {}
	m[3][1] = math.cos(rz) * math.sin(ry) + math.cos(ry) * math.sin(rz) * math.sin(rx)
	m[3][2] = math.sin(rz) * math.sin(ry) - math.cos(rz) * math.cos(ry) * math.sin(rx)
	m[3][3] = math.cos(rx) * math.cos(ry)
	m[3][4] = 1
	return m
end
local warnSound = false
local warnSoundTimer = false
function endWarnSound()
	if isElement(warnSound) then
		destroyElement(warnSound)
	end
	warnSound = nil
	if isTimer(warnSoundTimer) then
		killTimer(warnSoundTimer)
	end
	warnSoundTimer = nil
end
addEvent("firemanWarnSoundEx", true)
addEventHandler("firemanWarnSoundEx", getRootElement(), function()
	local x, y, z = getElementPosition(localPlayer)
	if getDistanceBetweenPoints3D(x, y, z, -2038.751953125, 79.8720703125, 28.397680282593) < 250 then
		endWarnSound()
		warnSoundTimer = setTimer(endWarnSound, 20000, 1)
		warnSound = playSound3D("files/muszakimentes.mp3", -2038.751953125, 79.8720703125, 28.397680282593)
		setSoundVolume(warnSound, 1.5)
		setSoundMaxDistance(warnSound, 80)
	end
end)
addEvent("firemanWarnSound", true)
addEventHandler("firemanWarnSound", getRootElement(), function()
	if getDistanceBetweenPoints3D(selfPosX, selfPosY, selfPosZ, -2038.751953125, 79.8720703125, 28.397680282593) < 250 then
		endWarnSound()
		warnSoundTimer = setTimer(endWarnSound, 20000, 1)
		warnSound = playSound3D("files/riasztashang.mp3", -2038.751953125, 79.8720703125, 28.397680282593)
		setSoundVolume(warnSound, 1.5)
		setSoundMaxDistance(warnSound, 80)
	end
end)
local waterParticles = {}
local waterEmitters = {}
local waterEmitterIndex = 0
function preRenderFireTrucks(deltaTime)
	if usingPumpDelta > 0 then
		usingPumpDelta = usingPumpDelta - deltaTime
	end
	selfPosX, selfPosY, selfPosZ = getElementPosition(localPlayer)
	for fireTruck, truckData in pairs(firetruckDatas) do
		local roloOpenRatio = getVehicleDoorOpenRatio(fireTruck, 1) * 0.9
		setVehicleComponentPosition(fireTruck, "rolo", 0.015, 0.0244, -0.0026 + 1.4223 * roloOpenRatio)
		setVehicleComponentScale(fireTruck, "rolo", 1, 1, 1 - roloOpenRatio)
		local numUsers = 0
		for nozzleId, nozzleData in pairs(truckData.fireNozzle) do
			local nozzleLines = nozzleData.lines
			local nozzleObject = nozzleData.object
			local nozzleUser = nozzleData.user
			local nozzlePosX = nil
			local nozzlePosY = nil
			local nozzlePosZ = nil
			if nozzleData.refill then
				local m = getElementMatrix(nozzleObject)
				nozzlePosX = m[4][1] + m[1][1] * 0.0188 + m[2][1] * 0.0513 - m[3][1] * 0.116
				nozzlePosY = m[4][2] + m[1][2] * 0.0188 + m[2][2] * 0.0513 - m[3][2] * 0.116
				nozzlePosZ = m[4][3] + m[1][3] * 0.0188 + m[2][3] * 0.0513 - m[3][3] * 0.116
			elseif nozzleUser then
				numUsers = numUsers + 1
				nozzlePosX, nozzlePosY, nozzlePosZ = getElementPosition(nozzleObject)
				if not isElementOnScreen(nozzleUser) or 9000 < nozzlePosZ then
					nozzlePosX, nozzlePosY, nozzlePosZ = getElementPosition(nozzleUser)
					playerNozzleObjects[nozzleUser] = nil
				else
					local m = getElementMatrix(nozzleObject)
					if nozzleId == 1 then
						nozzlePosX = m[4][1] + m[1][1] * 0.0188 + m[2][1] * 0.0513 - m[3][1] * 0.116
						nozzlePosY = m[4][2] + m[1][2] * 0.0188 + m[2][2] * 0.0513 - m[3][2] * 0.116
						nozzlePosZ = m[4][3] + m[1][3] * 0.0188 + m[2][3] * 0.0513 - m[3][3] * 0.116
					else
						nozzlePosX = m[4][1] + m[1][1] * 0.0156 + m[2][1] * 0.0519 - m[3][1] * 0.1265
						nozzlePosY = m[4][2] + m[1][2] * 0.0156 + m[2][2] * 0.0519 - m[3][2] * 0.1265
						nozzlePosZ = m[4][3] + m[1][3] * 0.0156 + m[2][3] * 0.0519 - m[3][3] * 0.1265
					end
					playerNozzleObjects[nozzleUser] = nozzleObject
				end
				if nozzleData.sound then
					setSoundVolume(nozzleData.sound, waterEmitters[nozzleUser] and 1 or 0)
				end
			else
				nozzlePosX, nozzlePosY, nozzlePosZ = unpack(nozzleData.pos)
			end
			local lineFromX = nozzlePosX
			local lineFromY = nozzlePosY
			local lineFromZ = nozzlePosZ
			local pumpPosX, pumpPosY, pumpPosZ = getVehiclePumpPosition(fireTruck, nozzleId)
			local numNozzleLines = #nozzleLines
			nozzleLines[1][2] = lineFromY
			nozzleLines[1][1] = lineFromX
			seelangStaticImageUsed[0] = true
			if seelangStaticImageToc[0] then
				processSeelangStaticImage[0]()
			end
			local hoseTexture = seelangStaticImage[0]
			local hoseThickness = hoseSegmentThickness * (nozzleId == 1 and 1.5 or 1)
			local hoseAngle = 0
			for i = 2, numNozzleLines, 1 do
				if nozzleLines[i][3] then
					if getDistanceBetweenPoints2D(nozzleLines[i][1], nozzleLines[i][2], nozzleLines[i][4] or -10000, nozzleLines[i][5] or -10000) > 0.2 then
						local groundZ = cachedGroundPosition(nozzleLines[i][1], nozzleLines[i][2], nozzlePosZ + 1)
						if groundZ then
							nozzleLines[i][3] = groundZ
						end
					end
				end
				local lineToX = nozzleLines[i][1]
				local lineToY = nozzleLines[i][2]
				local lineToZ = (nozzleLines[i][3] or nozzlePosZ) + hoseThickness
				if i <= numNozzleLines * 0.2 then
					lineToZ = lineToZ + (nozzlePosZ - lineToZ) * getEasingValue(1 - i / (numNozzleLines * 0.2), "InQuad")
				end
				if pumpPosZ and numNozzleLines * 0.8 <= i then
					lineToZ = lineToZ + (pumpPosZ - lineToZ) * getEasingValue((i - numNozzleLines * 0.8) / (numNozzleLines - numNozzleLines * 0.8), "InQuad")
				end
				dxDrawMaterialLine3D(lineFromX, lineFromY, lineFromZ, lineToX, lineToY, lineToZ, hoseTexture, hoseThickness, tocolor(255, 255, 255))
				if i == 2 then
					setElementPosition(nozzleData.joint1, lineFromX, lineFromY, lineFromZ)
					local rotZ, rotY = calculateRotation(lineToX - lineFromX, lineToY - lineFromY, lineToZ - lineFromZ)
					setElementRotation(nozzleData.joint1, 0, rotY, rotZ)
					hoseAngle = rotZ
				elseif i == numNozzleLines then
					setElementPosition(nozzleData.joint2, lineToX, lineToY, lineToZ)
					local rotZ, rotY = calculateRotation(lineFromX - lineToX, lineFromY - lineToY, lineFromZ - lineToZ)
					setElementRotation(nozzleData.joint2, 0, rotY, rotZ)
				end
				lineFromZ = lineToZ
				lineFromY = lineToY
				lineFromX = lineToX
			end
			local totalPenetration = 0
			for i = 2, numNozzleLines, 1 do
				local prevX = nozzleLines[i - 1][1]
				local prevY = nozzleLines[i - 1][2]
				local currX = nozzleLines[i][1]
				local currY = nozzleLines[i][2]
				local lineDistance = getDistanceBetweenPoints2D(prevX, prevY, currX, currY)
				if lineDistance > hoseSegmentLength then
					local penetrationDistance = lineDistance - hoseSegmentLength
					nozzleLines[i][1] = currX + (prevX - currX) * penetrationDistance / lineDistance
					nozzleLines[i][2] = currY + (prevY - currY) * penetrationDistance / lineDistance
					totalPenetration = totalPenetration + penetrationDistance
				end
			end
			nozzleLines[numNozzleLines][1] = pumpPosX
			nozzleLines[numNozzleLines][2] = pumpPosY
			for i = numNozzleLines - 1, 1, -1 do
				local nextX = nozzleLines[i + 1][1]
				local nextY = nozzleLines[i + 1][2]
				local currX = nozzleLines[i][1]
				local currY = nozzleLines[i][2]
				local lineDistance = getDistanceBetweenPoints2D(nextX, nextY, currX, currY)
				if lineDistance > hoseSegmentLength then
					local penetrationDistance = lineDistance - hoseSegmentLength
					nozzleLines[i][1] = currX + (nextX - currX) * penetrationDistance / lineDistance
					nozzleLines[i][2] = currY + (nextY - currY) * penetrationDistance / lineDistance
					totalPenetration = totalPenetration + penetrationDistance
				end
			end
			if not nozzleUser and not nozzleData.refill and (totalPenetration > 0.025 or not nozzleData.zReset) then
				local groundZ = cachedGroundPosition(nozzleLines[1][1], nozzleLines[1][2], (nozzleLines[1][3] or nozzlePosZ) + 1)
				if groundZ then
					nozzlePosZ = groundZ + hoseThickness
					nozzleData.zReset = true
				end
				local x = nozzleLines[1][1]
				local y = nozzleLines[1][2]
				local z = nozzlePosZ
				nozzleData.pos = {x, y, z}
				local m = getRotMatrix(90, hoseAngle, 30)
				if nozzleId == 1 then
					nozzlePosX = x - m[1][1] * 0.0188 - m[2][1] * 0.0513 + m[3][1] * 0.116
					nozzlePosY = y - m[1][2] * 0.0188 - m[2][2] * 0.0513 + m[3][2] * 0.116
					nozzlePosZ = z - m[1][3] * 0.0188 - m[2][3] * 0.0513 + m[3][3] * 0.116
				else
					nozzlePosX = x - m[1][1] * 0.0156 - m[2][1] * 0.0519 + m[3][1] * 0.1265
					nozzlePosY = y - m[1][2] * 0.0156 - m[2][2] * 0.0519 + m[3][2] * 0.1265
					nozzlePosZ = z - m[1][3] * 0.0156 - m[2][3] * 0.0519 + m[3][3] * 0.1265
				end
				setElementPosition(nozzleObject, nozzlePosX, nozzlePosY, nozzlePosZ)
				setElementRotation(nozzleObject, 90, hoseAngle, 30)
			end
		end
		if truckData.fireWater < truckData.displayedFireWater then
			truckData.displayedFireWater = truckData.displayedFireWater - deltaTime / 60000 * 0.08 * math.max(1, numUsers)
			if truckData.displayedFireWater < truckData.fireWater then
				truckData.displayedFireWater = truckData.fireWater
			end
			truckData.pumpNeeded = 2000
		elseif truckData.displayedFireWater < truckData.fireWater then
			truckData.displayedFireWater = truckData.displayedFireWater + deltaTime / 60000 * 0.25
			if truckData.displayedFireWater > 1 then
				truckData.displayedFireWater = 1
			end
			truckData.pumpNeeded = 2000
		end
		if truckData.pumpNeeded then
			truckData.pumpNeeded = truckData.pumpNeeded - deltaTime
			if truckData.pumpNeeded <= 0 then
				truckData.pumpNeeded = false
			end
			setSoundVolume(truckData.pumpSound, 1.5)
			if not truckData.pumping then
				truckData.pumping = true
				setSoundPosition(truckData.pumpSound, 0)
			end
			local soundPosition = getSoundPosition(truckData.pumpSound)
			if soundPosition >= 8.313 then
				setSoundPosition(truckData.pumpSound, 4.951 + soundPosition - 8.313)
			end
		elseif truckData.pumping then
			local soundPosition = getSoundPosition(truckData.pumpSound)
			if soundPosition > 4.951 then
				truckData.pumpEnding = true
			elseif truckData.pumpEnding then
				truckData.pumping = false
				setSoundVolume(truckData.pumpSound, 0)
			end
			if soundPosition > 9.275 then
				truckData.pumping = false
				setSoundVolume(truckData.pumpSound, 0)
			end
		end
	end
	local currentVehicle = getPedOccupiedVehicle(localPlayer)
	if selfFireTruck and selfFireNozzle then
		if currentVehicle then
			selfFireTruck = nil
			selfFireNozzle = nil
			triggerServerEvent("firetruckUnuseNozzle", localPlayer, true)
		elseif firetruckDatas[selfFireTruck] and firetruckDatas[selfFireTruck].fireNozzle[selfFireNozzle] and firetruckDatas[selfFireTruck].fireNozzle[selfFireNozzle].lines then
			local nozzleDistance = getDistanceBetweenPoints2D(selfPosX, selfPosY, firetruckDatas[selfFireTruck].fireNozzle[selfFireNozzle].lines[1][1], firetruckDatas[selfFireTruck].fireNozzle[selfFireNozzle].lines[1][2])
			if nozzleDistance > 0.75 then
				hoseIsStretching = true
				if nozzleDistance > 2 then
					selfFireTruck = nil
					selfFireNozzle = nil
					triggerServerEvent("firetruckUnuseNozzle", localPlayer, true)
				end
			end
		end
	elseif firetruckDatas[currentVehicle] and firetruckDatas[currentVehicle].fireNozzle[1] and firetruckDatas[currentVehicle].fireNozzle[1].refill and firetruckDatas[currentVehicle].fireNozzle[1].lines and firetruckDatas[currentVehicle].fireNozzle[1].object then
		local nozzlePosX, nozzlePosY = getElementPosition(firetruckDatas[currentVehicle].fireNozzle[1].object)
		if getDistanceBetweenPoints2D(nozzlePosX, nozzlePosY, firetruckDatas[currentVehicle].fireNozzle[1].lines[1][1], firetruckDatas[currentVehicle].fireNozzle[1].lines[1][2]) > 2 then
			firetruckDatas[currentVehicle].fireNozzle[1].refill = nil
			triggerServerEvent("firetruckResetRefillNozzle", localPlayer, currentVehicle)
		end
	end
	matrixCache = {}
	pumpPosCache = {}
end
function firetruckStreamIn(fireTruck)
	if not firetruckDatas[fireTruck] then
		firetruckDatas[fireTruck] = {}
		for i = 1, #sidePoses, 1 do
			firetruckDataChange(fireTruck, "fireNozzle:" .. i, getElementData(fireTruck, "fireNozzle:" .. i))
		end
		firetruckDataChange(fireTruck, "fireWater", getElementData(fireTruck, "fireWater") or 0)
		firetruckDatas[fireTruck].displayedFireWater = firetruckDatas[fireTruck].fireWater
		firetruckDataChange(fireTruck, "fireRefill", getElementData(fireTruck, "fireRefill"))
		firetruckDatas[fireTruck].pumpSound = playSound3D("files/pump.mp3", 0, 0, 0, true)
		setSoundVolume(firetruckDatas[fireTruck].pumpSound, 0)
		setSoundMaxDistance(firetruckDatas[fireTruck].pumpSound, 75)
		attachElements(firetruckDatas[fireTruck].pumpSound, fireTruck, sidePoses[1][1], sidePoses[1][2], sidePoses[1][3])
		addEventHandler("onClientElementDataChange", fireTruck, firetruckDataChangeHandler)
		checkPreRenderFireTrucks(true)
		checkRenderFireTrucks(true)
		checkClickFireTrucks(true)
	end
end
function firetruckStreamOut(fireTruck)
	if firetruckDatas[fireTruck] then
		if fireTruck == selfFireTruck then
			selfFireTruck = nil
			selfFireNozzle = nil
			triggerServerEvent("firetruckUnuseNozzle", localPlayer, true)
		end
		if firetruckDatas[fireTruck].fireNozzle then
			for k, v in pairs(firetruckDatas[fireTruck].fireNozzle) do
				if isElement(v.object) then
					destroyElement(v.object)
				end
				v.object = nil
				if isElement(v.joint1) then
					destroyElement(v.joint1)
				end
				v.joint1 = nil
				if isElement(v.joint2) then
					destroyElement(v.joint2)
				end
				v.joint2 = nil
				if isElement(v.sound) then
					destroyElement(v.sound)
				end
				v.sound = nil
			end
		end
		if isElement(firetruckDatas[fireTruck].pumpSound) then
			destroyElement(firetruckDatas[fireTruck].pumpSound)
		end
		firetruckDatas[fireTruck].pumpSound = nil
		firetruckDatas[fireTruck] = nil
		removeEventHandler("onClientElementDataChange", fireTruck, firetruckDataChangeHandler)
		for k in pairs(firetruckDatas) do
			return
		end
		checkPreRenderFireTrucks(false)
		checkRenderFireTrucks(false)
		checkClickFireTrucks(false)
		groundCache = {}
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	local streamedVehicles = getElementsByType("vehicle", getRootElement(), true)
	for i = 1, #streamedVehicles, 1 do
		local vehicleElement = streamedVehicles[i]
		if getElementModel(vehicleElement) == 407 then
			firetruckStreamIn(vehicleElement)
		end
	end
	triggerServerEvent("requestFires", localPlayer)
end)
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
	if getElementModel(source) == 407 then
		firetruckStreamIn(source)
	end
end)
addEventHandler("onClientVehicleStreamOut", getRootElement(), function()
	firetruckStreamOut(source)
end)
addEventHandler("onClientVehicleDestroy", getRootElement(), function()
	firetruckStreamOut(source)
end)
local createdFires = {}
local lastFireHealthSync = 0
local healthLossToSync = false
local fireBlip = false
function refreshBlip()
	if not firemanGroup then
		if isElement(fireBlip) then
			destroyElement(fireBlip)
		end
		fireBlip = nil
	else
		local firePosX = 0
		local firePosY = 0
		local firePosZ = 0
		local fireCount = 0
		for k, v in pairs(createdFires) do
			firePosX = firePosX + v[1]
			firePosY = firePosY + v[2]
			firePosZ = math.max(firePosZ, v[3])
			fireCount = fireCount + 1
		end
		firePosX = firePosX / fireCount
		firePosY = firePosY / fireCount
		if fireCount <= 0 then
			if isElement(fireBlip) then
				destroyElement(fireBlip)
			end
			fireBlip = nil
		elseif isElement(fireBlip) then
			setElementPosition(fireBlip, firePosX, firePosY, firePosZ + 1)
		else
			fireBlip = createBlip(firePosX, firePosY, firePosZ + 1, 9, 2, orange[1], orange[2], orange[3])
			setElementData(fireBlip, "tooltipText", "Tűzeset")
		end
	end
end
function createFire(fireId, firePosX, firePosY, firePosZ, fireHealth)
	if createdFires[fireId] then
		if isElement(createdFires[fireId][10]) then
			destroyElement(createdFires[fireId][10])
		end
		createdFires[fireId][10] = nil
	end
	createdFires[fireId] = {firePosX, firePosY, firePosZ, false, fireHealth, false, 0, 0, 0}
	createdFires[fireId][10] = playSound3D("files/fire" .. math.random(1, 4) .. ".mp3", firePosX, firePosY, firePosZ, true)
	setSoundMaxDistance(createdFires[fireId][10], 80)
	setSoundVolume(createdFires[fireId][10], 0)
	refreshBlip()
	checkPreRenderFires(true)
	setupFireShaders(true)
end
addEvent("createFire", true)
addEventHandler("createFire", getRootElement(), createFire)
addEvent("gotFires", true)
addEventHandler("gotFires", getRootElement(), function(loadedFires)
	for fireId, fireData in pairs(loadedFires) do
		createFire(fireId, fireData[1], fireData[2], fireData[3], fireData[4])
	end
end)
addEvent("resetFireHealth", true)
addEventHandler("resetFireHealth", getRootElement(), function(fireId, fireHealth)
	createdFires[fireId][5] = fireHealth
end)
addEvent("doResetFires", true)
addEventHandler("doResetFires", getRootElement(), function()
	for fireId in pairs(createdFires) do
		if createdFires[fireId] then
			if isElement(createdFires[fireId][10]) then
				destroyElement(createdFires[fireId][10])
			end
			createdFires[fireId][10] = nil
		end
	end
	createdFires = {}
	refreshBlip()
end)
addEvent("doDeleteFire", true)
addEventHandler("doDeleteFire", getRootElement(), function(fireId)
	if createdFires[fireId] then
		if isElement(createdFires[fireId][10]) then
			destroyElement(createdFires[fireId][10])
		end
		createdFires[fireId][10] = nil
	end
	createdFires[fireId] = nil
	refreshBlip()
end)
addEvent("doSyncFireHealth", true)
addEventHandler("doSyncFireHealth", getRootElement(), function(syncData)
	for fireId, fireHealth in pairs(syncData) do
		if createdFires[fireId] then
			createdFires[fireId][5] = fireHealth
		end
	end
end)
local fumeParticles = {}
function spawnFumeParticle(x, y, z, dx, dy, dz, life, r, g, b, a, size, sizePlus)
	table.insert(fumeParticles, {
		x,
		y,
		z,
		dx,
		dy,
		dz,
		getTickCount(),
		life,
		r,
		g,
		b,
		a,
		size,
		sizePlus
	})
end
function spawnFume(x, y, z)
	local c = math.random() * 30
	local r = math.pi * 2 * math.random()
	local d = math.random() * 0.5
	spawnFumeParticle(x, y, z + 1, math.cos(r) * d, math.sin(r) * d, 0.8 + math.random() * 1.5, 5000 + math.random() * 5000, c, c, c, math.random(50, 150), math.random(30, 35) / 100, math.random(70, 90) / 100 * (2 + math.random() * 3) / 4)
end
function preRenderFires(deltaTime)
	local px, py, pz = getElementPosition(localPlayer)
	local x, y, z = getWorldFromScreenPosition(screenX / 2, 0, 128)
	local x2, y2, z2 = getWorldFromScreenPosition(screenX / 2, screenY / 2, 128)
	x = x2 - x
	y = y2 - y
	z = z2 - z
	local len = math.sqrt(x * x + y * y + z * z)
	x = x / len
	y = y / len
	z = z / len
	local zp = math.pow(math.asin(z) / math.pi / 2 + 1, 2)
	local zpi = 1 - zp
	local activeFires = {}
	for fireId, fireData in pairs(createdFires) do
		local firePosX = fireData[1]
		local firePosY = fireData[2]
		local firePosZ = fireData[3]
		local fireDistance = getDistanceBetweenPoints3D(px, py, pz, firePosX, firePosY, firePosZ)
		if fireDistance < 1000 then
			if fireData[5] < fireData[9] then
				fireData[9] = fireData[9] - 0.02 * deltaTime / 25
				if fireData[9] < fireData[5] then
					fireData[9] = fireData[5]
				end
				setSoundVolume(createdFires[fireId][10], fireData[9])
			elseif fireData[9] < fireData[5] then
				fireData[9] = fireData[9] + deltaTime / 1000
				if fireData[5] < fireData[9] then
					fireData[9] = fireData[5]
				end
				setSoundVolume(createdFires[fireId][10], fireData[9])
			end
			local fireSize = 2 + 10 * math.pow(fireData[9], 0.5)
			if fireDistance < fireSize * 0.15 then
				setPedOnFire(localPlayer, true)
			end
			local groundZ = 0
			if fireDistance < 250 then
				groundZ = cachedGroundPosition(firePosX, firePosY, firePosZ + 2)
				if groundZ then
					firePosZ = groundZ + 0.25 + zp
					fireData[4] = firePosZ
					setElementPosition(createdFires[fireId][10], firePosX, firePosY, firePosZ)
				end
			end
			dxDrawMaterialLine3D(firePosX + x * fireSize * 0.2, firePosY + y * fireSize * 0.2, firePosZ + z * fireSize * 0.2, firePosX - x * fireSize * 0.8, firePosY - y * fireSize * 0.8, firePosZ - z * fireSize * 0.8, shader, fireSize / 2, tocolor(255, 255, 255, a))
			table.insert(activeFires, fireId)
		end
	end
	if #activeFires > 0 then
		spawnParticle()
		seelangStaticImageUsed[1] = true
		if seelangStaticImageToc[1] then
			processSeelangStaticImage[1]()
		end
		local fireBallTexture = seelangStaticImage[1]
		local deltaTimeSec = deltaTime / 1000
		dxSetRenderTarget(rt, true)
		dxSetBlendMode("modulate_add")
		for i = 1, #particles, 1 do
			local v = particles[i]
			v.s = v.s - v.shr * deltaTimeSec - v.syp * deltaTimeSec * 0.5 * zpi
			v.f = math.min(1, v.f + deltaTimeSec * 5)
			local size = v.s * maxSpriteSize
			if size > 0 then
				v.r = v.r + v.rp * deltaTimeSec
				v.fo = v.fo - deltaTimeSec
				if v.fo > 0 then
					local a = v.a * v.f * math.min(1, v.fo)
					if v.tx < v.x then
						v.x = v.x + v.sxp * deltaTimeSec * 0.5
						if v.x < v.tx then
							v.x = v.tx
						end
					elseif v.x < v.tx then
						v.x = v.x - v.sxp * deltaTimeSec * 0.5
						if v.tx < v.x then
							v.x = v.tx
						end
					end
					v.y = v.y + v.syp * deltaTimeSec * 0.5 * zpi
					dxDrawImage(safeZone + (256 - safeZone * 2) * (0.5 + v.x / 2) - size / 2, safeZone + (512 - safeZone * 2) * v.y - size / 2, size, size, fireBallTexture, v.r, 0, 0, tocolor(255, 255, 255, a))
				end
			end
		end
		for i = #particles, 1, -1 do
			local v = particles[i]
			if 1 < v.y or v.s < 0 or v.fo < 0 then
				table.remove(particles, i)
			end
		end
		dxSetBlendMode("blend")
		dxSetRenderTarget()
		local fireId = activeFires[math.random(1, #activeFires)]
		if fireId then
			spawnFume(createdFires[fireId][1], createdFires[fireId][2], createdFires[fireId][4] or createdFires[fireId][3])
		end
	end
	local now = getTickCount()
	seelangStaticImageUsed[2] = true
	if seelangStaticImageToc[2] then
		processSeelangStaticImage[2]()
	end
	local smokeTexture = seelangStaticImage[2]
	for i = #fumeParticles, 1, -1 do
		local v = fumeParticles[i]
		if v then
			v[1] = v[1] + v[4] * deltaTime / 1000
			v[2] = v[2] + v[5] * deltaTime / 1000
			v[3] = v[3] + v[6] * deltaTime / 1000
			local a = (now - v[7]) / 2000
			if a > 1 then
				a = 1
			end
			if v[8] < now - v[7] then
				a = 1 - (now - v[7] + v[8]) / 2000
				if a < 0 then
					a = 0
					table.remove(fumeParticles, i)
				end
			end
			v[13] = v[13] + v[14] * deltaTime / 1000
			dxDrawMaterialLine3D(v[1] + x * v[13], v[2] + y * v[13], v[3] + z * v[13], v[1] - x * v[13], v[2] - y * v[13], v[3] - z * v[13], smokeTexture, v[13], tocolor(v[9], v[10], v[11], v[12] * a))
		end
	end
	for k in pairs(createdFires) do
		return
	end
	if #fumeParticles <= 0 then
		checkPreRenderFires(false)
		setupFireShaders(false)
		groundCache = {}
	end
end
function spawnWaterParticle(client, index)
	local m = getElementMatrix(playerNozzleObjects[client] or client)
	local offsetY = 10
	local offsetX = 0
	local offsetZ = 4
	local startOffsetX = 0
	local startOffsetY = 0
	local startOffsetZ = 0
	if playerNozzleObjects[client] then
		offsetX = offsetY
		offsetY = -1.25
		offsetZ = 10
		startOffsetX = m[1][1] * 0.25
		startOffsetY = m[1][2] * 0.25
		startOffsetZ = m[1][3] * 0.25
		fxAddTyreBurst(
			m[4][1] + m[1][1] * 0.5192 + m[2][1] * 0.0055 + m[3][1] * 0.2678,
			m[4][2] + m[1][2] * 0.5192 + m[2][2] * 0.0055 + m[3][2] * 0.2678,
			m[4][3] + m[1][3] * 0.5192 + m[2][3] * 0.0055 + m[3][3] * 0.2678,
			0, 0, 0
		)
	end
	local force = 9.81
	local ux = -m[3][1] * force
	local uy = -m[3][2] * force
	local uz = -m[3][3] * force
	table.insert(waterParticles, {
		m[4][1] + startOffsetX,
		m[4][2] + startOffsetY,
		m[4][3] + startOffsetZ,
		m[3][1] * offsetZ + m[2][1] * offsetY + m[1][1] * offsetX,
		m[3][2] * offsetZ + m[2][2] * offsetY + m[1][2] * offsetX,
		m[3][3] * offsetZ + m[2][3] * offsetY + m[1][3] * offsetX,
		getTickCount(),
		0,
		0,
		-force,
		client,
		index,
		client == localPlayer
	})
	checkRenderWaterParticles(true)
end
function preRenderWaterEmitters(deltaTime)
	for k in pairs(waterEmitters) do
		waterEmitters[k][1] = waterEmitters[k][1] + deltaTime
		if waterEmitters[k][1] > 25 then
			waterEmitters[k][1] = 0
			spawnWaterParticle(k, waterEmitters[k][2])
		end
	end
	for k in pairs(waterEmitters) do
		return
	end
	checkPreRenderWaterEmitters(false)
end
addEvent("syncUsingPump", true)
addEventHandler("syncUsingPump", getRootElement(), function(state)
	if state and isElement(source) and isElementStreamedIn(source) then
		waterEmitters[source] = {0, waterEmitterIndex}
		waterEmitterIndex = waterEmitterIndex + 1
		checkPreRenderWaterEmitters(true)
	else
		waterEmitters[source] = nil
	end
end)
function renderWaterParticles(deltaTime)
	local now = getTickCount()
	local emitterPoses = {}
	seelangStaticImageUsed[3] = true
	if seelangStaticImageToc[3] then
		processSeelangStaticImage[3]()
	end
	local waterTexture = seelangStaticImage[3]
	for i = #waterParticles, 1, -1 do
		local dat = waterParticles[i]
		local emitter = dat[12]
		local myEmitter = dat[13]
		local waterPosX = dat[1] + dat[4] * deltaTime / 1000
		local waterPosY = dat[2] + dat[5] * deltaTime / 1000
		local waterPosZ = dat[3] + dat[6] * deltaTime / 1000
		dat[4] = dat[4] + dat[8] * deltaTime / 1000
		dat[5] = dat[5] + dat[9] * deltaTime / 1000
		dat[6] = dat[6] + dat[10] * deltaTime / 1000
		local scale = 0.05
		local endPosX = dat[1] + dat[4] * scale
		local endPosY = dat[2] + dat[5] * scale
		local endPosZ = dat[3] + dat[6] * scale
		if emitterPoses[emitter] then
			waterPosZ = emitterPoses[emitter][3]
			waterPosY = emitterPoses[emitter][2]
			waterPosX = emitterPoses[emitter][1]
		end
		emitterPoses[emitter] = {endPosX, endPosY, endPosZ}
		local groundZ = cachedGroundPosition(endPosX, endPosY, endPosZ + 1)
		local elapsedTime = now - dat[7]
		local alphaScale = math.min(1, elapsedTime / 20)
		local widthScale = 1 + 2 * math.min(1, elapsedTime / 1000)
		if elapsedTime > 15000 then
			table.remove(waterParticles, i)
		elseif groundZ and waterPosZ < groundZ or waterPosZ < -10 then
			table.remove(waterParticles, i)
			if groundZ then
				fxAddTyreBurst(endPosX, endPosY, groundZ, 0, 0, 0)
				if myEmitter then
					local closestFireDistance = 2.125
					local closestFire = false
					for fireId, fireData in pairs(createdFires) do
						local fireDistance = getDistanceBetweenPoints2D(fireData[1], fireData[2], endPosX, endPosY)
						if fireDistance < closestFireDistance then
							closestFireDistance = fireDistance
							closestFire = fireId
						end
					end
					if closestFire then
						if createdFires[closestFire][5] > 0 then
							local healthLoss = 0.01 * (math.random() * 0.2 + 0.9)
							createdFires[closestFire][5] = math.max(0, createdFires[closestFire][5] - healthLoss)
							if not healthLossToSync then
								healthLossToSync = {}
							end
							healthLossToSync[closestFire] = (healthLossToSync[closestFire] or 0) + healthLoss
						end
						createdFires[closestFire][6] = now
						checkRenderFireHealth(true)
						checkPreRenderFireHealth(true)
					end
				end
			end
		end
		dat[3] = waterPosZ
		dat[2] = waterPosY
		dat[1] = waterPosX
		dxDrawMaterialLine3D(waterPosX, waterPosY, waterPosZ, endPosX, endPosY, endPosZ, waterTexture, 0.16 * widthScale, tocolor(200, 250, 255, 160 * alphaScale))
	end
	if #waterParticles <= 0 then
		checkRenderWaterParticles(false)
	end
end
local fireDeltaTime = 0
function preRenderFireHealth(deltaTime)
	fireDeltaTime = deltaTime
end
local healthBarFade = 0
function renderFireHealth()
	local now = getTickCount()
	local showHealthBar = false
	local accumulatedHealth = 0
	local removeRenderHandler = healthBarFade <= 0
	if healthLossToSync then
		removeRenderHandler = false
		if now - lastFireHealthSync > 500 then
			triggerServerEvent("doSyncFireHealth", localPlayer, healthLossToSync)
			healthLossToSync = false
			lastFireHealthSync = now
		end
	end
	for fireId, fireData in pairs(createdFires) do
		accumulatedHealth = accumulatedHealth + fireData[9]
		if fireData[6] then
			local firePosX = fireData[1]
			local firePosY = fireData[2]
			local firePosZ = fireData[4] or fireData[3]
			local elapsedTime = now - fireData[6]
			if elapsedTime < 25 + fireDeltaTime and fireData[7] < 1 then
				fireData[7] = fireData[7] + fireDeltaTime / 100
				if fireData[7] > 1 then
					fireData[7] = 1
				end
			elseif fireData[7] > 0 then
				fireData[7] = fireData[7] - fireDeltaTime / 250
				if fireData[7] < 0 then
					fireData[7] = 0
				end
			end
			local moveProg = 1 + getEasingValue(fireData[7], "InOutQuad") * 0.25
			if elapsedTime > 2000 then
				fireData[8] = fireData[8] - fireDeltaTime / 500
			else
				showHealthBar = true
				if fireData[8] < 1 then
					fireData[8] = fireData[8] + fireDeltaTime / 250
					if fireData[8] > 1 then
						fireData[8] = 1
					end
				end
			end
			if fireData[8] < 0 then
				fireData[6] = false
				fireData[8] = 0
			else
				local a = fireData[8] * 200 + 55 * fireData[7]
				local sx, sy = getScreenFromWorldPosition(firePosX, firePosY, firePosZ + 1, 128)
				if sx then
					dxDrawRectangle(sx - 64 * moveProg, sy - 6 * moveProg, 128 * moveProg, 12 * moveProg, tocolor(grey1[1], grey1[2], grey1[3], a))
					dxDrawRectangle(sx - 64 * moveProg + 2, sy - 6 * moveProg + 2, 128 * moveProg - 4, 12 * moveProg - 4, tocolor(grey3[1], grey3[2], grey3[3], a))
					dxDrawRectangle(sx - 64 * moveProg + 2, sy - 6 * moveProg + 2, (128 * moveProg - 4) * fireData[9], 12 * moveProg - 4, tocolor(orange[1], orange[2], orange[3], a))
				end
				removeRenderHandler = false
			end
		end
	end
	if showHealthBar then
		healthBarFade = math.min(1, healthBarFade + fireDeltaTime / 500)
	elseif healthBarFade > 0 then
		healthBarFade = healthBarFade - fireDeltaTime / 500
		if healthBarFade < 0 then
			healthBarFade = 0
		end
	end
	dxDrawRectangle(screenX / 2 - 200, screenY * 0.9 - 8, 400, 16, tocolor(grey1[1], grey1[2], grey1[3], 255 * healthBarFade))
	dxDrawRectangle(screenX / 2 - 200 + 2, screenY * 0.9 - 8 + 2, 396, 12, tocolor(grey3[1], grey3[2], grey3[3], 255 * healthBarFade))
	dxDrawRectangle(screenX / 2 - 200 + 2, screenY * 0.9 - 8 + 2, 396 * accumulatedHealth / 50, 12, tocolor(orange[1], orange[2], orange[3], 255 * healthBarFade))
	if removeRenderHandler then
		checkRenderFireHealth(false)
	end
end
