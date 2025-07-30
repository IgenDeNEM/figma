local sightexports = {
	sModloader = false,
	sGui = false,
	sGroups = false,
	sPermission = false,
	sPattach = false,
	sSpeedo = false,
	sItems = false
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
	if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] then
		sightlangStatImgHand = false
		removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
	end
end
processsightlangStaticImage[0] = function()
	if not isElement(sightlangStaticImage[0]) then
		sightlangStaticImageToc[0] = false
		sightlangStaticImage[0] = dxCreateTexture("files/light.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/cuff.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[2] = function()
	if not isElement(sightlangStaticImage[2]) then
		sightlangStaticImageToc[2] = false
		sightlangStaticImage[2] = dxCreateTexture("files/visz.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
local sightlangWaiterState0 = false
local sightlangWaiterState1 = false
local function sightlangProcessResWaiters()
	if not sightlangWaiterState0 then
		local res0 = getResourceFromName("sGroups")
		if res0 and getResourceState(res0) == "running" then
			checkSpike()
			sightlangWaiterState0 = true
		end
	end
	if not sightlangWaiterState1 then
		local res0 = getResourceFromName("sItems")
		if res0 and getResourceState(res0) == "running" then
			checkCuffItems()
			sightlangWaiterState1 = true
		end
	end
end
if triggerServerEvent then
	addEventHandler("onClientResourceStart", getRootElement(), sightlangProcessResWaiters)
end
if triggerClientEvent then
	addEventHandler("onResourceStart", getRootElement(), sightlangProcessResWaiters)
end
local faTicks = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		faTicks = sightexports.sGui:getFaTicks()
		refreshColors()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
	faTicks = sightexports.sGui:getFaTicks()
end)
local sightlangModloaderLoaded = function()
	modloaderListener()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local screenX, screenY = guiGetScreenSize()
local playerHover = false
local viszHover = false
local biggestRBSId = 0
local rbsObjects = {}
local rbsPlacedBy = {}
local rbsObjectList = {}
local specialRBSData = {}
local specialRBSList = {}
local specialRBSLights = {}
local lightTexture
local rbsToggle = {}
local modloaderReady = false
local waitList = {}
function modloaderListener()
	modloaderReady = true
	for i = 1, #waitList do
		createRBS(waitList[i][1], waitList[i][2])
		if rbsToggle[waitList[i][1]] then
			toggleRBS(waitList[i][1], rbsToggle[waitList[i][1]])
		end
	end
end
local function lightDestroyFunction(id)
	rbsLightStreamOut(id)
	specialRBSLights[id] = nil
end
local emptyFunction = function()
end
local function bigYellowLightFunction(id)
	local ox, oy, oz = getElementPosition(rbsObjects[id])
	local rx, ry, rz = getElementRotation(rbsObjects[id])
	local rad = math.rad(rz)
	local c2 = math.cos(rad)
	local s2 = math.sin(rad)
	rad = rad + math.pi / 2
	specialRBSLights[id] = {}
	for i = 1, 2 do
		local cos = math.cos(rad)
		local sin = math.sin(rad)
		for j = 0, 1 do
			local x = ox + cos * 0.0395 + c2 * (-0.5 + 1 * j)
			local y = oy + sin * 0.0395 + s2 * (-0.5 + 1 * j)
			local z = oz + 0.944748
			table.insert(specialRBSLights[id], {
				x,
				y,
				z,
				cos,
				sin,
				0.4,
				tocolor(255, 170, 0, 200),
				j + 1
			})
		end
		rad = rad + math.pi
	end
	if isElementStreamedIn(rbsObjects[id]) then
		rbsLightStreamIn(id)
	end
end
local arrowMatrix = {
	{
		0.52281,
		0.14817,
		1.922044
	},
	{
		0.698638,
		0.14817,
		1.722044
	},
	{
		0.8393,
		0.14817,
		1.522044
	},
	{
		0.698638,
		0.14817,
		1.322044
	},
	{
		0.52281,
		0.14817,
		1.122044
	},
	{
		0.559532,
		0.14817,
		1.522044
	},
	{
		0.279766,
		0.14817,
		1.522044
	},
	{
		0,
		0.14817,
		1.522044
	},
	{
		-0.279766,
		0.14817,
		1.522044
	},
	{
		-0.559532,
		0.14817,
		1.522044
	},
	{
		-0.8393,
		0.14817,
		1.522044
	}
}
local specialRBS = {
	rbs16 = {
		create = function(id)
			local x, y, z = getElementPosition(rbsObjects[id])
			local rx, ry, rz = getElementRotation(rbsObjects[id])
			local rad = math.rad(rz) - math.pi / 2
			x = x + math.cos(rad) * 0.249378
			y = y + math.sin(rad) * 0.249378
			z = z + 0.158848
			specialRBSData[id] = createObject(sightexports.sModloader:getModelId("rbs16_2"), x, y, z, rx, ry, rz)
			setElementInterior(specialRBSData[id], getElementInterior(rbsObjects[id]))
			setElementDimension(specialRBSData[id], getElementDimension(rbsObjects[id]))
		end,
		turnOn = function(id)
			if isElement(specialRBSData[id]) then
				local x, y, z = getElementPosition(specialRBSData[id])
				local rx = getElementRotation(specialRBSData[id])
				moveObject(specialRBSData[id], 1000, x, y, z, 45 - rx, 0, 0)
				if isElementStreamedIn(specialRBSData[id]) then
					playSound3D("files/ramp.wav", x, y, z)
				end
			end
		end,
		turnOff = function(id)
			if isElement(specialRBSData[id]) then
				local x, y, z = getElementPosition(specialRBSData[id])
				local rx = getElementRotation(specialRBSData[id])
				moveObject(specialRBSData[id], 1000, x, y, z, -rx, 0, 0)
				if isElementStreamedIn(specialRBSData[id]) then
					playSound3D("files/ramp.wav", x, y, z)
				end
			end
		end,
		destroy = function(id)
			if isElement(specialRBSData[id]) then
				destroyElement(specialRBSData[id])
			end
			specialRBSData[id] = nil
		end
	},
	rbs37 = {
		create = function(id)
			local x, y, z = getElementPosition(rbsObjects[id])
			local rx, ry, rz = getElementRotation(rbsObjects[id])
			z = z - 0.771607
			specialRBSData[id] = createObject(sightexports.sModloader:getModelId("rbs37_2"), x, y, z, rx, ry, rz)
			setElementInterior(specialRBSData[id], getElementInterior(rbsObjects[id]))
			setElementDimension(specialRBSData[id], getElementDimension(rbsObjects[id]))
		end,
		turnOn = function(id)
			if isElement(specialRBSData[id]) then
				local x, y, z = getElementPosition(rbsObjects[id])
				moveObject(specialRBSData[id], 1000, x, y, z, 0, 0, 0)
				if isElementStreamedIn(specialRBSData[id]) then
					playSound3D("files/ramp.wav", x, y, z)
				end
			end
		end,
		turnOff = function(id)
			if isElement(specialRBSData[id]) then
				local x, y, z = getElementPosition(rbsObjects[id])
				moveObject(specialRBSData[id], 1000, x, y, z - 0.771607, 0, 0, 0)
				if isElementStreamedIn(specialRBSData[id]) then
					playSound3D("files/ramp.wav", x, y, z)
				end
			end
		end,
		destroy = function(id)
			if isElement(specialRBSData[id]) then
				destroyElement(specialRBSData[id])
			end
			specialRBSData[id] = nil
		end
	},
	rbs36 = {
		create = function(id)
			local x, y, z = getElementPosition(rbsObjects[id])
			local rx, ry, rz = getElementRotation(rbsObjects[id])
			local rad = math.rad(rz) + math.pi / 2
			local cos = math.cos(rad)
			local sin = math.sin(rad)
			x = x + cos * 0.215
			y = y + sin * 0.215
			z = z + 2.56035
			specialRBSLights[id] = {
				{
					x,
					y,
					z,
					cos,
					sin,
					0.75,
					tocolor(255, 0, 0, 200)
				}
			}
			if isElementStreamedIn(rbsObjects[id]) then
				rbsLightStreamIn(id)
			end
		end,
		turnOn = function(id)
			local x, y, z = getElementPosition(rbsObjects[id])
			local rx, ry, rz = getElementRotation(rbsObjects[id])
			local rad = math.rad(rz) + math.pi / 2
			local cos = math.cos(rad)
			local sin = math.sin(rad)
			x = x + cos * 0.215
			y = y + sin * 0.215
			z = z + 2.05827
			specialRBSLights[id] = {
				{
					x,
					y,
					z,
					cos,
					sin,
					0.75,
					tocolor(0, 255, 0, 200)
				}
			}
		end,
		turnOff = function(id)
			local x, y, z = getElementPosition(rbsObjects[id])
			local rx, ry, rz = getElementRotation(rbsObjects[id])
			local rad = math.rad(rz) + math.pi / 2
			local cos = math.cos(rad)
			local sin = math.sin(rad)
			x = x + cos * 0.215
			y = y + sin * 0.215
			z = z + 2.56035
			specialRBSLights[id] = {
				{
					x,
					y,
					z,
					cos,
					sin,
					0.75,
					tocolor(255, 0, 0, 200)
				}
			}
		end,
		destroy = lightDestroyFunction
	},
	rbs38 = {
		create = function(id)
			local ox, oy, oz = getElementPosition(rbsObjects[id])
			local rx, ry, rz = getElementRotation(rbsObjects[id])
			local rad = math.rad(rz)
			local c1 = math.cos(rad)
			local s1 = math.sin(rad)
			rad = rad + math.pi / 2
			local c2 = math.cos(rad)
			local s2 = math.sin(rad)
			specialRBSLights[id] = {}
			for i = 1, #arrowMatrix do
				local x = ox + c1 * arrowMatrix[i][1] + c2 * (arrowMatrix[i][2] + 0.015)
				local y = oy + s1 * arrowMatrix[i][1] + s2 * (arrowMatrix[i][2] + 0.015)
				local z = oz + arrowMatrix[i][3]
				table.insert(specialRBSLights[id], {
					x,
					y,
					z,
					c2,
					s2,
					0.95,
					tocolor(255, 170, 0, 200),
					1
				})
			end
			if isElementStreamedIn(rbsObjects[id]) then
				rbsLightStreamIn(id)
			end
		end,
		turnOn = function(id)
			local ox, oy, oz = getElementPosition(rbsObjects[id])
			local rx, ry, rz = getElementRotation(rbsObjects[id])
			local rad = math.rad(rz)
			local c1 = math.cos(rad)
			local s1 = math.sin(rad)
			rad = rad + math.pi / 2
			local c2 = math.cos(rad)
			local s2 = math.sin(rad)
			specialRBSLights[id] = {}
			for i = 1, #arrowMatrix do
				local x = ox - c1 * arrowMatrix[i][1] + c2 * (arrowMatrix[i][2] + 0.015)
				local y = oy - s1 * arrowMatrix[i][1] + s2 * (arrowMatrix[i][2] + 0.015)
				local z = oz + arrowMatrix[i][3]
				table.insert(specialRBSLights[id], {
					x,
					y,
					z,
					c2,
					s2,
					0.75,
					tocolor(255, 170, 0, 200),
					1
				})
			end
		end,
		turnOff = function(id)
			local ox, oy, oz = getElementPosition(rbsObjects[id])
			local rx, ry, rz = getElementRotation(rbsObjects[id])
			local rad = math.rad(rz)
			local c1 = math.cos(rad)
			local s1 = math.sin(rad)
			rad = rad + math.pi / 2
			local c2 = math.cos(rad)
			local s2 = math.sin(rad)
			specialRBSLights[id] = {}
			for i = 1, #arrowMatrix do
				local x = ox + c1 * arrowMatrix[i][1] + c2 * (arrowMatrix[i][2] + 0.015)
				local y = oy + s1 * arrowMatrix[i][1] + s2 * (arrowMatrix[i][2] + 0.015)
				local z = oz + arrowMatrix[i][3]
				table.insert(specialRBSLights[id], {
					x,
					y,
					z,
					c2,
					s2,
					0.75,
					tocolor(255, 170, 0, 200),
					1
				})
			end
		end,
		destroy = lightDestroyFunction
	},
	rbs5 = {
		create = emptyFunction,
		turnOn = function(id)
			local ox, oy, oz = getElementPosition(rbsObjects[id])
			local rx, ry, rz = getElementRotation(rbsObjects[id])
			local rad = math.rad(rz)
			local c2 = math.cos(rad)
			local s2 = math.sin(rad)
			rad = rad + math.pi / 2
			specialRBSLights[id] = {}
			for i = 1, 2 do
				local cos = math.cos(rad)
				local sin = math.sin(rad)
				local x = ox + cos * 0.035 + c2 * 0.238665
				local y = oy + sin * 0.035 + s2 * 0.238665
				local z = oz + 0.758285
				table.insert(specialRBSLights[id], {
					x,
					y,
					z,
					cos,
					sin,
					0.35,
					tocolor(255, 170, 0, 200),
					1
				})
				rad = rad + math.pi
			end
			if isElementStreamedIn(rbsObjects[id]) then
				rbsLightStreamIn(id)
			end
		end,
		turnOff = lightDestroyFunction,
		destroy = lightDestroyFunction
	},
	rbs40 = {
		create = emptyFunction,
		turnOn = function(id)
			local ox, oy, oz = getElementPosition(rbsObjects[id])
			local rx, ry, rz = getElementRotation(rbsObjects[id])
			local rad = math.rad(rz) + math.pi / 2
			specialRBSLights[id] = {}
			local cos = math.cos(rad)
			local sin = math.sin(rad)
			local x = ox + cos * 0.116
			local y = oy + sin * 0.116
			local z = oz + 1.75337
			table.insert(specialRBSLights[id], {
				x,
				y,
				z,
				cos,
				sin,
				0.75,
				tocolor(255, 170, 0, 200),
				1
			})
			if isElementStreamedIn(rbsObjects[id]) then
				rbsLightStreamIn(id)
			end
		end,
		turnOff = lightDestroyFunction,
		destroy = lightDestroyFunction
	},
	rbs7 = {
		create = emptyFunction,
		turnOn = bigYellowLightFunction,
		turnOff = lightDestroyFunction,
		destroy = lightDestroyFunction
	},
	rbs8 = {
		create = emptyFunction,
		turnOn = bigYellowLightFunction,
		turnOff = lightDestroyFunction,
		destroy = lightDestroyFunction
	}
}
addEventHandler("onClientElementDestroy", getRootElement(), function()
	if specialRBSList[source] then
		local obj = specialRBSList[source]
		specialRBS[obj].destroy(rbsObjectList[source])
	end
	rbsObjectList[source] = nil
end)
function toggleRBS(id, tog)
	local obj = specialRBSList[rbsObjects[id]]
	if obj and specialRBS[obj] then
		if tog then
			specialRBS[obj].turnOn(id)
		else
			specialRBS[obj].turnOff(id)
		end
	end
end
function createRBS(id, data)
	if not modloaderReady then
		table.insert(waitList, {id, data})
		return
	end
	if isElement(rbsObjects[id]) then
		destroyElement(rbsObjects[id])
	end
	rbsObjects[id] = nil
	rbsPlacedBy[id] = nil
	if data and validRBSModels[data[1]] then
		obj = data[1]
		x = tonumber(data[2])
		y = tonumber(data[3])
		z = tonumber(data[4])
		rz = tonumber(data[5])
		int = tonumber(data[6])
		dim = tonumber(data[7])
		biggestRBSId = math.max(biggestRBSId, id)
		rbsObjects[id] = createObject(sightexports.sModloader:getModelId(obj), x, y, z, 0, 0, rz)
		setElementInterior(rbsObjects[id], int)
		setElementDimension(rbsObjects[id], dim)
		rbsPlacedBy[id] = data[8] .. " (Karakter ID: " .. data[9] .. ")"
		rbsObjectList[rbsObjects[id]] = id
		if specialRBS[obj] then
			specialRBS[obj].create(id)
			specialRBSList[rbsObjects[id]] = obj
		end
	end
end
addEvent("gotRBSList", true)
addEventHandler("gotRBSList", getRootElement(), function(list, toggle)
	for id, data in pairs(list) do
		createRBS(id, data)
		rbsToggle = toggle
		if toggle[id] then
			toggleRBS(id, toggle[id])
		end
	end
end)
addEvent("syncRBSData", true)
addEventHandler("syncRBSData", getRootElement(), function(id, data, tog)
	if data then
		local sound = playSound3D("files/drop" .. math.random(1, 2) .. ".wav", data[2], data[3], data[4])
		setSoundMaxDistance(sound, 45)
	end
	createRBS(id, data)
	if tog then
		rbsToggle[id] = true
		toggleRBS(id, tog)
	else
		rbsToggle[id] = nil
	end
end)
addEvent("toggleRBS", true)
addEventHandler("toggleRBS", getRootElement(), function(id, tog)
	toggleRBS(id, tog)
	rbsToggle[id] = tog
end)
local selfCuffed = getElementData(localPlayer, "cuffed")
local carryingOther = {}
local carryedBy = {}
local lastFall = 0
local btnBcg, btnCol, btnCol2, btnCol3 = false, false, false, false
local putInIcon = false
local trashIcon = false
local infoIcon = false
local powerIcon = false
function refreshColors()
	btnBcg = sightexports.sGui:getColorCodeToColor("sightgrey1")
	btnCol = sightexports.sGui:getColorCodeToColor("sightgreen")
	btnCol2 = sightexports.sGui:getColorCodeToColor("sightred")
	btnCol3 = sightexports.sGui:getColorCodeToColor("sightblue")
	putInIcon = sightexports.sGui:getFaIconFilename("sign-in", 40)
	trashIcon = sightexports.sGui:getFaIconFilename("trash-alt", 32)
	infoIcon = sightexports.sGui:getFaIconFilename("info", 32)
	powerIcon = sightexports.sGui:getFaIconFilename("power-off", 32)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	local players = getElementsByType("player", getRootElement(), true)
	for i = 1, #players do
		processCuffObject(players[i], getElementData(players[i], "cuffed"))
		processTazerObject(players[i], getElementData(players[i], "tazerState"))
		local carry = getElementData(players[i], "carryingOther")
		if carry then
			setCarrying(players[i], carry)
		end
	end
	engineLoadIFP("files/walk.ifp", "cuff_walk")
	engineLoadIFP("files/spike.ifp", "spike")
	triggerServerEvent("requestRBSList", localPlayer)
end)
local nearbyRBHover = false
local nearbyRBHoverType = false
local nearbyRBState = false
function renderNearbyRb()
	local cx, cy = getCursorPosition()
	if cx then
		cx = cx * screenX
		cy = cy * screenY
	end
	local tmp = false
	local tmpType = false
	local px, py, pz = getElementPosition(localPlayer)
	for id, obj in pairs(rbsObjects) do
		if isElementStreamedIn(obj) then
			local x, y, z = getElementPosition(obj)
			if getDistanceBetweenPoints3D(px, py, pz, x, y, z) < 6 then
				local x, y = getScreenFromWorldPosition(x, y, z, 144)
				if x then
					x = x - 20 - 4
					if specialRBSList[obj] then
						x = x - 20 - 4
						dxDrawRectangle(x - 20, y - 20, 40, 40, btnBcg)
						if cx and cx <= x + 20 and cx >= x - 20 and cy >= y - 20 and cy <= y + 20 then
							dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. powerIcon .. (faTicks[powerIcon] or ""), 0, 0, 0, btnCol)
							tmp = id
							tmpType = "power"
						else
							dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. powerIcon .. (faTicks[powerIcon] or ""))
						end
						x = x + 40 + 8
					end
					dxDrawRectangle(x - 20, y - 20, 40, 40, btnBcg)
					if cx and cx <= x + 20 and cx >= x - 20 and cy >= y - 20 and cy <= y + 20 then
						dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. infoIcon .. (faTicks[infoIcon] or ""), 0, 0, 0, btnCol3)
						tmp = id
						tmpType = "info"
					else
						dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. infoIcon .. (faTicks[infoIcon] or ""))
					end
					x = x + 40 + 8
					dxDrawRectangle(x - 20, y - 20, 40, 40, btnBcg)
					if cx and cx <= x + 20 and cx >= x - 20 and cy >= y - 20 and cy <= y + 20 then
						dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. trashIcon .. (faTicks[trashIcon] or ""), 0, 0, 0, btnCol2)
						tmp = id
						tmpType = "delete"
					else
						dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. trashIcon .. (faTicks[trashIcon] or ""))
					end
				end
			end
		end
	end
	if nearbyRBHover ~= tmp or nearbyRBHoverType ~= tmpType then
		nearbyRBHover = tmp
		nearbyRBHoverType = tmpType
		if nearbyRBHoverType == "info" and rbsPlacedBy[tmp] then
			sightexports.sGui:showTooltip("Lerakta: " .. rbsPlacedBy[tmp])
		else
			sightexports.sGui:showTooltip(false)
		end
		sightexports.sGui:setCursorType(nearbyRBHover and "link" or "normal")
	end
end
function clickNearbyRb(button, state)
	if state == "up" and nearbyRBHover then
		if nearbyRBHoverType == "delete" then
			triggerServerEvent("deleteRBS", getRootElement(), nearbyRBHover)
		elseif nearbyRBHoverType == "power" then
			triggerServerEvent("toggleRBS", getRootElement(), nearbyRBHover)
		end
	end
end
addCommandHandler("nearbyrbs", function()
	if sightexports.sGroups:getPlayerPermission("rbs") or sightexports.sPermission:hasPermission(localPlayer, "nearbyrb") or nearbyRBState then
		nearbyRBState = not nearbyRBState
		nearbyRBHover = false
		nearbyRBHoverType = false
		if nearbyRBState then
			addEventHandler("onClientRender", getRootElement(), renderNearbyRb)
			addEventHandler("onClientClick", getRootElement(), clickNearbyRb)
			outputChatBox("[color=sightgreen][SightMTA - RBS]: #FFFFFFKözeli RBS mód [color=sightgreen]bekapcsolva#ffffff.", 255, 255, 255, true)
		else
			removeEventHandler("onClientRender", getRootElement(), renderNearbyRb)
			removeEventHandler("onClientClick", getRootElement(), clickNearbyRb)
			outputChatBox("[color=sightgreen][SightMTA - RBS]: #FFFFFFKözeli RBS mód [color=sightred]kikapcsolva#ffffff.", 255, 255, 255, true)
		end
		if nearbyRBHoverType then
			sightexports.sGui:setCursorType("normal")
			sightexports.sGui:showTooltip(false)
		end
	end
end)
function playCuffSound(player)
	if isElement(player) then
		local x, y, z = getElementPosition(player)
		local int = getElementInterior(player)
		local dim = getElementDimension(player)
		local sound = playSound3D("files/cuff.mp3", x, y, z)
		setElementInterior(sound, int)
		setElementDimension(sound, dim)
		attachElements(sound, player)
	end
end
addEvent("cuffedSoundEffect", true)
addEventHandler("cuffedSoundEffect", getRootElement(), function(state)
	if isElement(source) and isElementStreamedIn(source) then
		if state then
			setTimer(playCuffSound, 300, 1, source)
			setTimer(playCuffSound, 800, 1, source)
		else
			setTimer(playCuffSound, 200, 1, source)
			setTimer(playCuffSound, 700, 1, source)
		end
	end
end)
local cuffObjects = {}
local tazerObjects = {}
function processTazerObject(client, state)
	if state then
		if not isElement(tazerObjects[client]) then
			tazerObjects[client] = createObject(sightexports.sModloader:getModelId("taser"), 0, 0, 0)
			setObjectScale(tazerObjects[client], 1.05)
			sightexports.sPattach:attach(tazerObjects[client], client, 24, 0, 0, 0.0075, 0, 0, -2)
		end
	else
		if isElement(tazerObjects[client]) then
			destroyElement(tazerObjects[client])
		end
		tazerObjects[client] = nil
	end
end
function processCuffObject(client, cuffed)
	if cuffed then
		if not cuffObjects[client] then
			cuffObjects[client] = {}
		end
		if not isElement(cuffObjects[client][1]) then
			cuffObjects[client][1] = createObject(sightexports.sModloader:getModelId("handcuff"), 0, 0, 0)
			sightexports.sPattach:attach(cuffObjects[client][1], client, 24, 0, 0.075, 0, 90, 0, -90)
		end
		if not isElement(cuffObjects[client][2]) then
			cuffObjects[client][2] = createObject(sightexports.sModloader:getModelId("handcuff"), 0, 0, 0)
			sightexports.sPattach:attach(cuffObjects[client][2], client, 34, 0, 0.075, 0, 90, 0, -90)
		end
	else
		if cuffObjects[client] then
			if isElement(cuffObjects[client][1]) then
				destroyElement(cuffObjects[client][1])
			end
			if isElement(cuffObjects[client][2]) then
				destroyElement(cuffObjects[client][2])
			end
		end
		cuffObjects[client] = nil
	end
end
local hoveringCar = false
local hoveringDoor = false
local doors = {
	"door_rf_dummy",
	"door_lr_dummy",
	"door_rr_dummy"
}
function isHeli(veh)
	return getVehicleType(veh) == "Helicopter" or getVehicleType(veh) == "Plane"
end
function renderCarryIcons()
	local cx, cy = getCursorPosition()
	if cx then
		cx = cx * screenX
		cy = cy * screenY
	end
	local tmp = false
	local tmpD = false
	local vehicles = getElementsByType("vehicle", getRootElement(), true)
	local px, py, pz = getElementPosition(localPlayer)
	for i = 1, #vehicles do
		local x, y, z = getElementPosition(vehicles[i])
		if getDistanceBetweenPoints3D(px, py, pz, x, y, z) < 5 then
			for j = 1, #doors do
				if getVehicleDoorOpenRatio(vehicles[i], j + 2) > 0.25 or getVehicleDoorState(vehicles[i], j + 2) == 4 or isHeli(vehicles[i]) then
					local x, y, z = getVehicleComponentPosition(vehicles[i], doors[j], "world")
					if getDistanceBetweenPoints3D(px, py, pz, x, y, z) < 2 then
						local x, y = getScreenFromWorldPosition(x, y, z, 64)
						if x then
							dxDrawRectangle(x - 26, y - 26, 52, 52, btnBcg)
							if cx and cx <= x + 26 and cx >= x - 26 and cy >= y - 26 and cy <= y + 26 then
								dxDrawImage(x - 20, y - 20, 40, 40, ":sGui/" .. putInIcon .. (faTicks[putInIcon] or ""), 0, 0, 0, btnCol)
								tmp = vehicles[i]
								tmpD = j
							else
								dxDrawImage(x - 20, y - 20, 40, 40, ":sGui/" .. putInIcon .. (faTicks[putInIcon] or ""))
							end
						end
					end
				end
			end
		end
	end
	if tmp ~= hoveringCar or tmpD ~= hoveringDoor then
		hoveringCar = tmp
		hoveringDoor = tmpD
		sightexports.sGui:setCursorType(hoveringCar and "link" or "normal")
	end
end
function clickCarryIcons(button, state)
	if state == "up" and hoveringCar then
		triggerServerEvent("putPlayerInVehicle", localPlayer, hoveringCar, hoveringDoor)
	end
end
function setCarrying(client, state)
	if carryingOther[client] ~= state then
		if isElement(carryingOther[client]) then
			setPedAnimation(carryingOther[client])
			carryedBy[carryingOther[client]] = nil
		end
		carryingOther[client] = state
		if isElement(state) then
			carryedBy[state] = client
		end
		if client == localPlayer then
			if state then
				hoveringCar = false
				addEventHandler("onClientRender", getRootElement(), renderCarryIcons)
				addEventHandler("onClientClick", getRootElement(), clickCarryIcons)
			else
				removeEventHandler("onClientRender", getRootElement(), renderCarryIcons)
				removeEventHandler("onClientClick", getRootElement(), clickCarryIcons)
				sightexports.sGui:setCursorType("normal")
			end
			playerHover = false
			viszHover = false
			sightexports.sSpeedo:syncCarrying(state)
		end
	end
end
addEventHandler("onClientPlayerQuit", getRootElement(), function()
	processCuffObject(source, false)
	processTazerObject(source, false)
	setCarrying(source, nil)
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
	if getElementType(source) == "player" then
		processCuffObject(source, false)
		processTazerObject(source, false)
		setCarrying(source, nil)
	elseif rbsObjectList[source] then
		local id = rbsObjectList[source]
		if specialRBSLights[id] then
			rbsLightStreamOut(id)
		end
	end
end)
addEventHandler("onClientElementStreamIn", getRootElement(), function()
	if getElementType(source) == "player" then
		processCuffObject(source, getElementData(source, "cuffed"))
		processTazerObject(source, getElementData(source, "tazerState"))
		setCarrying(source, getElementData(source, "carryingOther"))
	elseif rbsObjectList[source] then
		local id = rbsObjectList[source]
		if specialRBSLights[id] then
			rbsLightStreamIn(id)
		end
	end
end)
addEventHandler("onClientElementDataChange", getRootElement(), function(data, old, new)
	if data == "carryingOther" then
		if isElementStreamedIn(source) then
			setCarrying(source, new)
		end
	elseif data == "tazerState" then
		if isElementStreamedIn(source) then
			processTazerObject(source, new)
		end
	elseif data == "cuffed" then
		if isElementStreamedIn(source) then
			processCuffObject(source, new)
		end
		if source == localPlayer then
			selfCuffed = new
		end
	end
end)
local spikes = {}
addEvent("syncSpike", true)
addEventHandler("syncSpike", getRootElement(), function(cid, x, y, z, rz)
	if x then
		for i = #spikes, 1, -1 do
			if spikes[i][9] == cid then
				if isElement(spikes[i][1]) then
					destroyElement(spikes[i][1])
				end
				table.remove(spikes, i)
			end
		end
		local spike = createObject(sightexports.sModloader:getModelId("spike"), x, y, z, 0, 0, rz)
		setElementCollisionsEnabled(spike, false)
		table.insert(spikes, {
			spike,
			getTickCount(),
			x,
			y,
			z,
			false,
			0,
			false,
			cid
		})
		playSound3D("files/spike.mp3", x, y, z)
		if isElement(source) and getElementType(source) == "player" then
			setPedAnimation(source, "spike", "stinger_throw", -1, false, false, false, false, 250, true)
		end
	else
		for i = 1, #spikes do
			if spikes[i][9] == cid then
				playSound3D("files/spike.mp3", spikes[i][3], spikes[i][4], spikes[i][5])
				spikes[i][2] = getTickCount()
				spikes[i][8] = true
			end
		end
		if isElement(source) and getElementType(source) == "player" then
			setPedAnimation(source, "spike", "stinger_pull", -1, false, false, false, false, 250, true)
		end
	end
end)
local lx1, ly1, lz1 = false, false, false
local lx2, ly2, lz2 = false, false, false
local lx3, ly3, lz3 = false, false, false
local lx4, ly4, lz4 = false, false, false
local wheelsDamaged = {
	0,
	0,
	0,
	0
}
function onSegment(px, py, qx, qy, rx, ry)
	return qx <= math.max(px, rx) and qx >= math.min(px, rx) and qy <= math.max(py, ry) and qy >= math.min(py, ry)
end
function orientation(px, py, qx, qy, rx, ry)
	local val = (qy - py) * (rx - qx) - (qx - px) * (ry - qy)
	if 0 < val then
		return 1
	elseif val < 0 then
		return 2
	else
		return 0
	end
end
function doIntersect(x1, y1, x2, y2, x3, y3, x4, y4)
	o1 = orientation(x1, y1, x2, y2, x3, y3)
	o2 = orientation(x1, y1, x2, y2, x4, y4)
	o3 = orientation(x3, y3, x4, y4, x1, y1)
	o4 = orientation(x3, y3, x4, y4, x2, y2)
	if o1 ~= o2 and o3 ~= o4 then
		return true
	end
	if o1 == 0 and onSegment(x1, y1, x3, y3, x2, y2) then
		return true
	end
	if o2 == 0 and onSegment(x1, y1, x4, y4, x2, y2) then
		return true
	end
	if o3 == 0 and onSegment(x3, y3, x1, y1, x4, y4) then
		return true
	end
	if o4 == 0 and onSegment(x3, y3, x2, y2, x4, y4) then
		return true
	end
	return false
end
addEvent("wheelPunctureSound", true)
addEventHandler("wheelPunctureSound", getRootElement(), function(wheel)
	if isElement(source) then
		local x, y, z = getElementPosition(source)
		local sound = playSound3D("files/punct.wav", x, y, z)
		if getVehicleType(source) == "Bike" then
			if wheel == 1 then
				x, y, z = getVehicleComponentPosition(source, "wheel_front", "root")
			end
			if wheel == 2 then
				x, y, z = getVehicleComponentPosition(source, "wheel_rear", "root")
			end
		else
			if wheel == 1 then
				x, y, z = getVehicleComponentPosition(source, "wheel_lf_dummy", "root")
			end
			if wheel == 2 then
				x, y, z = getVehicleComponentPosition(source, "wheel_lb_dummy", "root")
			end
			if wheel == 3 then
				x, y, z = getVehicleComponentPosition(source, "wheel_rf_dummy", "root")
			end
			if wheel == 4 then
				x, y, z = getVehicleComponentPosition(source, "wheel_rb_dummy", "root")
			end
		end
		attachElements(sound, source, x, y, z)
		setSoundMaxDistance(sound, 60)
	end
end)
local spikeToCheck = {}
local canDeleteSpike = false
function checkSpike()
	canDeleteSpike = sightexports.sGroups:getPlayerPermission("spike")
end
addEvent("gotPlayerGroupPermissions", true)
addEventHandler("gotPlayerGroupPermissions", getRootElement(), checkSpike)
function applyInverseRotation(x, y, z, rx, ry, rz)
	local DEG2RAD = math.pi * 2 / 360
	rx = rx * DEG2RAD
	ry = ry * DEG2RAD
	rz = rz * DEG2RAD
	local tempY = y
	y = math.cos(rx) * tempY + math.sin(rx) * z
	z = -math.sin(rx) * tempY + math.cos(rx) * z
	local tempX = x
	x = math.cos(ry) * tempX - math.sin(ry) * z
	z = math.sin(ry) * tempX + math.cos(ry) * z
	tempX = x
	x = math.cos(rz) * tempX + math.sin(rz) * y
	y = -math.sin(rz) * tempX + math.cos(rz) * y
	return x, y, z
end
function attachRotationAdjusted(frPosX, frPosY, frPosZ, toPosX, toPosY, toPosZ, toRotX, toRotY, toRotZ)
	local offsetPosX = frPosX - toPosX
	local offsetPosY = frPosY - toPosY
	local offsetPosZ = frPosZ - toPosZ
	return applyInverseRotation(offsetPosX, offsetPosY, offsetPosZ, toRotX, toRotY, toRotZ)
end
local boneIDs = {
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	21,
	22,
	23,
	24,
	25,
	26,
	31,
	32,
	33,
	34,
	35,
	36,
	41,
	42,
	43,
	44,
	51,
	52,
	53,
	54,
	201,
	301,
	302
}
addEventHandler("onClientPlayerWeaponFire", localPlayer, function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement, startX, startY, startZ)
	if getElementData(localPlayer, "tazerState") and isElement(hitElement) and getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
		triggerServerEvent("tazerPlayer", localPlayer, hitElement)
	end
end)
local hoveringSpike = false
local spikeIconHandled = false
function renderSpikeIcons()
	local cx, cy = getCursorPosition()
	if cx then
		cx = cx * screenX
		cy = cy * screenY
	end
	local tmp = false
	local tmpD = false
	local vehicles = getElementsByType("vehicle", getRootElement(), true)
	local px, py, pz = getElementPosition(localPlayer)
	for j = 1, #spikeToCheck do
		local i = spikeToCheck[j]
		if i and spikes[i] then
			local x, y, z = spikes[i][3], spikes[i][4], spikes[i][5]
			if 3 > getDistanceBetweenPoints3D(px, py, pz, x, y, z) and 1 <= spikes[i][7] then
				local x, y = getScreenFromWorldPosition(x, y, z, 64)
				if x then
					dxDrawRectangle(x - 20, y - 20, 40, 40, btnBcg)
					if cx and cx <= x + 20 and cx >= x - 20 and cy >= y - 20 and cy <= y + 20 then
						dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. trashIcon .. (faTicks[trashIcon] or ""), 0, 0, 0, btnCol2)
						tmp = spikes[i][9]
					else
						dxDrawImage(x - 16, y - 16, 32, 32, ":sGui/" .. trashIcon .. (faTicks[trashIcon] or ""))
					end
				end
			end
		end
	end
	if tmp ~= hoveringSpike then
		hoveringSpike = tmp
		sightexports.sGui:setCursorType(hoveringSpike and "link" or "normal")
	end
end
function clickSpikeIcons(button, state)
	if state == "up" and hoveringSpike then
		triggerServerEvent("tryToDeleteSpike", localPlayer, hoveringSpike)
	end
end
local tazerEffects = {}
local selfTazer = false
local selfTazerTime = false
function renderTazerEffect()
	local now = getTickCount()
	local a = (now - selfTazer) / 50
	if 10 < a then
		local p = (now - selfTazer) / (selfTazerTime - 500)
		a = 1 - p
		if a < 0 then
			a = 0
			removeEventHandler("onClientRender", getRootElement(), renderTazerEffect)
			selfTazer = false
			selfTazerTime = false
		end
	elseif 1 < a then
		a = 1
	end
	dxDrawRectangle(0, 0, screenX, screenY, tocolor(255, 255, 255, 255 * a))
end
addEvent("gotTazerEffect", true)
addEventHandler("gotTazerEffect", getRootElement(), function(target, time)
	if isElement(source) and isElement(target) and isElementStreamedIn(target) then
		table.insert(tazerEffects, {
			source,
			target,
			getTickCount()
		})
		local x, y, z = getElementPosition(source)
		local int = getElementInterior(source)
		local dim = getElementDimension(source)
		local sound = playSound3D("files/shock.mp3", x, y, z)
		setElementInterior(sound, int)
		setElementDimension(sound, dim)
		attachElements(sound, source)
		if target == localPlayer then
			if not selfTazer then
				addEventHandler("onClientRender", getRootElement(), renderTazerEffect)
			end
			selfTazer = getTickCount()
			selfTazerTime = time
		end
	end
end)
local placingRBS = false
local placingRBSModel = false
local placingRBSRZ = 0
local rbx = 0
local rby = 0
local rbz = 0
local streamedInRbsLights = {}
function rbsLightStreamIn(id)
	rbsLightStreamOut(id)
	table.insert(streamedInRbsLights, id)
end
function rbsLightStreamOut(id)
	for i = #streamedInRbsLights, 1, -1 do
		if streamedInRbsLights[i] == id then
			table.remove(streamedInRbsLights, i)
		end
	end
end
local trackBlips = {}
addEventHandler("onClientPreRender", getRootElement(), function()
	local now = getTickCount()
	for i = #trackBlips, 1, -1 do
		if now - trackBlips[i][2] > 35000 then
			if isElement(trackBlips[i][1]) then
				destroyElement(trackBlips[i][1])
			end
			table.remove(trackBlips, i)
		end
	end
	local x, y, z = getElementPosition(localPlayer)
	local phase = math.ceil(now % 1000 / 500)
	for i = #streamedInRbsLights, 1, -1 do
		local id = streamedInRbsLights[i]
		if specialRBSLights[id] then
			for j = 1, #specialRBSLights[id] do
				local dat = specialRBSLights[id][j]
				if not dat[8] or dat[8] == phase then
					local x, y, z = dat[1], dat[2], dat[3]
					sightlangStaticImageUsed[0] = true
					if sightlangStaticImageToc[0] then
						processsightlangStaticImage[0]()
					end
					dxDrawMaterialLine3D(x, y, z - dat[6] / 2, x, y, z + dat[6] / 2, sightlangStaticImage[0], dat[6], dat[7], x + dat[4], y + dat[5], z)
				end
			end
		end
	end
	if placingRBS then
		local int = getElementInterior(localPlayer)
		local dim = getElementDimension(localPlayer)
		setElementInterior(placingRBS, int)
		setElementDimension(placingRBS, dim)
		local cx, cy, wx, wy, wz = getCursorPosition()
		local cx, cy, cz, tx, ty, tz = getCameraMatrix()
		if wx then
			local hit, hx, hy, hz = processLineOfSight(cx, cy, cz, wx, wy, wz, true, true, true, true, true, false, false, false, localPlayer)
			if hit then
				if getKeyState("mouse2") then
					local rad = math.atan2(hy - rby, hx - rbx)
					placingRBSRZ = math.deg(rad + math.pi / 2)
				elseif getDistanceBetweenPoints3D(x, y, z, hx, hy, hz) < 10 then
					rbx, rby, rbz = hx, hy, hz
				end
			end
		else
			local rad = math.atan2(cy - ty, cx - tx) + math.pi
			placingRBSRZ = math.deg(rad + math.pi / 2)
			rbx = x + math.cos(rad) * 4
			rby = y + math.sin(rad) * 4
		end
		rbz = getGroundPosition(rbx, rby, rbz + 1)
		setElementPosition(placingRBS, rbx, rby, rbz)
		setElementRotation(placingRBS, 0, 0, placingRBSRZ)
		if getKeyState("e") then
			triggerServerEvent("addNewRBS", localPlayer, placingRBSModel, rbx, rby, rbz, placingRBSRZ, int, dim)
			if isElement(placingRBS) then
				destroyElement(placingRBS)
			end
			placingRBS = nil
			placingRBSModel = false
		end
	end
	for i = #tazerEffects, 1, -1 do
		if tazerEffects[i] then
			local client = tazerEffects[i][1]
			local target = tazerEffects[i][2]
			local started = tazerEffects[i][3]
			if isElement(client) and isElement(target) and now < started + 7000 then
				local p = (now - started) / 400
				local boneX, boneY, boneZ = 0, 0, 0
				if tazerObjects[client] and isElementOnScreen(client) then
					local m = getElementMatrix(tazerObjects[client])
					boneX = m[4][1] + m[1][1] * 0.35 + m[3][1] * 0.1
					boneY = m[4][2] + m[1][2] * 0.35 + m[3][2] * 0.1
					boneZ = m[4][3] + m[1][3] * 0.35 + m[3][3] * 0.1
				else
					boneX, boneY, boneZ = getPedBonePosition(client, 26)
				end
				local positionX, positionY, positionZ = getPedBonePosition(target, 3)
				if p < 1 then
					p = getEasingValue(p, "OutQuad")
					positionX = boneX + (positionX - boneX) * p
					positionY = boneY + (positionY - boneY) * p
					positionZ = boneZ + (positionZ - boneZ) * p
				elseif now - started < 5000 and math.random(100) < 50 then
					fxAddSparks(positionX, positionY, positionZ, 0, 0, 1)
				end
				local rx, ry, rz = getElementRotation(client)
				rz = math.rad(rz)
				dxDrawLine3D(boneX + math.cos(rz) * 0.0075, boneY + math.sin(rz) * 0.0075, boneZ, positionX + math.cos(rz) * 0.0075, positionY + math.sin(rz) * 0.0075, positionZ, tocolor(100, 100, 100, 100), 0.5, false)
				dxDrawLine3D(boneX - math.cos(rz) * 0.0075, boneY - math.sin(rz) * 0.0075, boneZ, positionX - math.cos(rz) * 0.0075, positionY - math.sin(rz) * 0.0075, positionZ, tocolor(100, 100, 100, 100), 0.5, false)
			else
				table.remove(tazerEffects, i)
			end
		else
			table.remove(tazerEffects, i)
		end
	end
	spikeToCheck = {}
	local toRemove = {}
	for i = #spikes, 1, -1 do
		if isElementStreamedIn(spikes[i][1]) or spikes[i][8] then
			if not spikes[i][6] then
				spikes[i][6] = getElementMatrix(spikes[i][1])
			end
			local p = (now - spikes[i][2]) / 1000
			if spikes[i][8] then
				p = 1 - p
				if 0 < p then
					p = getEasingValue(p, "InQuad")
				end
			elseif 1 < p then
				p = 1
			else
				p = getEasingValue(p, "OutQuad")
			end
			if spikes[i][8] and p < 0 then
				table.insert(toRemove, i)
			else
				spikes[i][7] = p
				setObjectScale(spikes[i][1], 1, p, 1)
				if getDistanceBetweenPoints3D(spikes[i][3], spikes[i][4], spikes[i][5], x, y, z) < 30 then
					table.insert(spikeToCheck, i)
				end
			end
		end
	end
	if 0 < #spikeToCheck and not spikeIconHandled and canDeleteSpike then
		spikeIconHandled = true
		hoveringSpike = false
		addEventHandler("onClientRender", getRootElement(), renderSpikeIcons)
		addEventHandler("onClientClick", getRootElement(), clickSpikeIcons)
	elseif #spikeToCheck <= 0 and spikeIconHandled then
		spikeIconHandled = false
		removeEventHandler("onClientRender", getRootElement(), renderSpikeIcons)
		removeEventHandler("onClientClick", getRootElement(), clickSpikeIcons)
		sightexports.sGui:setCursorType("normal")
	end
	if 0 < #spikeToCheck then
		local veh = getPedOccupiedVehicle(localPlayer)
		if veh and getVehicleController(veh) == localPlayer then
			local vType = getVehicleType(veh)
			local x1, y1, z1 = 0, 0, 0
			local x2, y2, z2 = 0, 0, 0
			local x3, y3, z3 = 0, 0, 0
			local x4, y4, z4 = 0, 0, 0
			if vType == "Automobile" or vType == "Quad" or vType == "Bike" then
				if vType == "Bike" then
					x1, y1, z1 = getVehicleComponentPosition(veh, "wheel_front", "world")
					x2, y2, z2 = getVehicleComponentPosition(veh, "wheel_rear", "world")
				else
					x1, y1, z1 = getVehicleComponentPosition(veh, "wheel_lf_dummy", "world")
					x2, y2, z2 = getVehicleComponentPosition(veh, "wheel_lb_dummy", "world")
					x3, y3, z3 = getVehicleComponentPosition(veh, "wheel_rf_dummy", "world")
					x4, y4, z4 = getVehicleComponentPosition(veh, "wheel_rb_dummy", "world")
				end
				local w1, w2, w3, w4 = getVehicleWheelStates(veh)
				for i = 1, #spikeToCheck do
					local m = spikes[i][6]
					local sx = m[4][1]
					local sy = m[4][2]
					local sz = m[4][3]
					local sx2 = sx + m[2][1] * 9.68905 * spikes[i][7]
					local sy2 = sy + m[2][2] * 9.68905 * spikes[i][7]
					local sz2 = sz + m[2][3] * 9.68905 * spikes[i][7]
					if lx1 and now - wheelsDamaged[1] > 5000 and w1 == 0 and 1 > math.abs(z1 - sz) and doIntersect(lx1, ly1, x1, y1, sx, sy, sx2, sy2) then
						wheelsDamaged[1] = getTickCount()
						triggerServerEvent("spikeDamageWheels", localPlayer, 1, getElementsByType("player", getRootElement(), true))
					end
					if lx2 and now - wheelsDamaged[2] > 5000 and w2 == 0 and 1 > math.abs(z2 - sz) and doIntersect(lx2, ly2, x2, y2, sx, sy, sx2, sy2) then
						wheelsDamaged[2] = getTickCount()
						triggerServerEvent("spikeDamageWheels", localPlayer, 2, getElementsByType("player", getRootElement(), true))
					end
					if lx3 and now - wheelsDamaged[3] > 5000 and w3 == 0 and 1 > math.abs(z3 - sz) and doIntersect(lx3, ly3, x3, y3, sx, sy, sx2, sy2) then
						wheelsDamaged[3] = getTickCount()
						triggerServerEvent("spikeDamageWheels", localPlayer, 3, getElementsByType("player", getRootElement(), true))
					end
					if lx4 and now - wheelsDamaged[4] > 5000 and w4 == 0 and 1 > math.abs(z4 - sz) and doIntersect(lx4, ly4, x4, y4, sx, sy, sx2, sy2) then
						wheelsDamaged[4] = getTickCount()
						triggerServerEvent("spikeDamageWheels", localPlayer, 4, getElementsByType("player", getRootElement(), true))
					end
				end
				lx1, ly1, lz1 = x1, y1, z1
				lx2, ly2, lz2 = x2, y2, z2
				lx3, ly3, lz3 = x3, y3, z3
				lx4, ly4, lz4 = x4, y4, z4
			end
		elseif lx1 then
			lx1, ly1, lz1 = false, false, false
			lx2, ly2, lz2 = false, false, false
			lx3, ly3, lz3 = false, false, false
			lx4, ly4, lz4 = false, false, false
			wheelsDamaged = {
				0,
				0,
				0,
				0
			}
		end
	elseif lx1 then
		lx1, ly1, lz1 = false, false, false
		lx2, ly2, lz2 = false, false, false
		lx3, ly3, lz3 = false, false, false
		lx4, ly4, lz4 = false, false, false
		wheelsDamaged = {
			0,
			0,
			0,
			0
		}
	end
	for i = 1, #toRemove do
		if isElement(spikes[toRemove[i]][1]) then
			destroyElement(spikes[toRemove[i]][1])
		end
		table.remove(spikes, toRemove[i])
	end
	if selfCuffed and not isPedInVehicle(localPlayer) then
		local task = getPedTask(localPlayer, "primary", 3) == "TASK_COMPLEX_JUMP"
		if task and getTickCount() - lastFall > 1000 then
			lastFall = getTickCount()
			triggerServerEvent("jumpFallAnimation", localPlayer)
		end
	end
	for player, objs in pairs(cuffObjects) do
		if objs then
			local x, y, z = getElementPosition(objs[1])
			local x2, y2, z2 = getElementPosition(objs[2])
			dxDrawLine3D(x, y, z, x2, y2, z2, tocolor(60, 60, 60))
		end
	end
	for client, target in pairs(carryingOther) do
		if isElement(client) and isElement(target) then
			local rx, ry, rz = getElementRotation(client)
			setElementRotation(target, 0, 0, rz, "default", true)
			local a1, a2 = getPedAnimation(target)
			local vx, vy, vz = getElementVelocity(client)
			if isElement(target) then
				if 0 < math.sqrt(vx * vx + vy * vy) then
					if a1 ~= "cuff_walk" or a2 ~= "walk_civi" then
						setPedAnimation(target, "cuff_walk", "walk_civi", -1, true, false, false, false, 250)
					end
				elseif a1 ~= "playidles" or a2 ~= "strleg" then
					setPedAnimation(target, "playidles", "strleg", -1, true, false, false, false, 250)
				end
			end
		else
			if target and isElement(target) then
				setPedAnimation(target)
			end
			carryingOther[client] = nil
		end
	end
end)
local rbsWindow = false
local rbsVehicleModel = 0
local currentRBSPage = 0
local pages = 0
local numOfRbsPerPage = 0
local rbsElements = {}
local rbsPagers = {}
addEvent("selectRBSObject", true)
addEventHandler("selectRBSObject", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if rbsElements[el] then
		local c = rbsElements[el][1] + currentRBSPage * numOfRbsPerPage
		if isElement(placingRBS) then
			destroyElement(placingRBS)
		end
		placingRBS = nil
		if rbsList[rbsVehicleModel] and rbsList[rbsVehicleModel][c] then
			placingRBSModel = rbsList[rbsVehicleModel][c]
			placingRBS = createObject(sightexports.sModloader:getModelId(rbsList[rbsVehicleModel][c]), 0, 0, 0)
			setElementCollisionsEnabled(placingRBS, false)
			sightexports.sGui:showInfobox("i", "Az RBS letételéhez nyomj [E] gombot.")
			rbx, rby, rbz = getElementPosition(localPlayer)
		end
		deleteRBSGui()
	end
end)
addEvent("rbsSelectPage", true)
addEventHandler("rbsSelectPage", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if tonumber(rbsPagers[el]) then
		currentRBSPage = tonumber(rbsPagers[el])
	elseif rbsPagers[el] == "plus" then
		if currentRBSPage >= pages - 1 then
			return
		end
		currentRBSPage = currentRBSPage + 1
	elseif rbsPagers[el] == "minus" then
		if currentRBSPage < 1 then
			return
		end
		currentRBSPage = currentRBSPage - 1
	end
	refreshRBSPage()
end)
function refreshRBSPage()
	if rbsList[rbsVehicleModel] then
		for lbg, v in pairs(rbsElements) do
			local c = v[1] + currentRBSPage * numOfRbsPerPage
			if rbsList[rbsVehicleModel][c] then
				sightexports.sGui:setGuiRenderDisabled(v[2], false)
				sightexports.sGui:setGuiHoverable(lbg, true)
				sightexports.sGui:setImageDDS(v[2], ":sPolice/files/rbs/" .. rbsList[rbsVehicleModel][c] .. ".dds")
				sightexports.sGui:setGuiRenderDisabled(v[3], not specialRBS[rbsList[rbsVehicleModel][c]])
			else
				sightexports.sGui:setGuiRenderDisabled(v[3], true)
				sightexports.sGui:setGuiRenderDisabled(v[2], true)
				sightexports.sGui:setGuiHoverable(lbg, false)
			end
		end
	end
	for button, page in pairs(rbsPagers) do
		if tonumber(page) then
			local curr = page == currentRBSPage
			sightexports.sGui:setImageFile(button, sightexports.sGui:getFaIconFilename("circle", 16, curr and "solid" or "regular"))
			sightexports.sGui:setGuiHoverable(button, not curr)
		end
	end
end
local rbsVehicleElement = false
function deleteRBSGui()
	if rbsWindow then
		sightexports.sGui:deleteGuiElement(rbsWindow)
	end
	rbsWindow = nil
	rbsElements = {}
	rbsPagers = {}
end
addEvent("closeRBSGui", true)
addEventHandler("closeRBSGui", getRootElement(), function()
	rbsVehicleElement = nil
	deleteRBSGui()
end)
function createRBSGui()
	deleteRBSGui()
	if rbsList[rbsVehicleModel] and sightexports.sGroups:getPlayerPermission("rbs") then
		local ds = 200
		local spacing = 2
		local titlebarHeight = 40
		local sx = math.floor(screenX / ds * 0.6)
		local sy = math.floor(screenY / ds * 0.75)
		rbsWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - (sx * ds + spacing * 2) / 2, screenY / 2 - (sy * ds + spacing * 2 + 32) / 2, sx * ds + spacing * 2, titlebarHeight + sy * ds + spacing * 2 + 32)
		sightexports.sGui:setGuiBackground(rbsWindow, "solid", "sightgrey1")
		sightexports.sGui:setWindowTitle(rbsWindow, "16/BebasNeueRegular.otf", "Road Block System")
		sightexports.sGui:setWindowCloseButton(rbsWindow, "closeRBSGui")
		sightexports.sGui:setWindowElementMaxDistance(rbsWindow, rbsVehicleElement, 10, "closeRBSGui")
		local c = 0
		for x = 0, sx - 1 do
			for y = 0, sy - 1 do
				c = c + 1
				local lbg = sightexports.sGui:createGuiElement("rectangle", spacing + x * ds + spacing, titlebarHeight + y * ds, ds - spacing * 2, ds - spacing * 2, rbsWindow)
				sightexports.sGui:setGuiBackground(lbg, "solid", "sightgrey1")
				sightexports.sGui:setGuiHover(lbg, "gradient", {"sightgrey1", "sightgrey3"}, false, true)
				sightexports.sGui:setGuiHoverable(lbg, true)
				local image = sightexports.sGui:createGuiElement("image", 12, 12, ds - spacing * 2 - 24, ds - spacing * 2 - 24, lbg)
				local icon = sightexports.sGui:createGuiElement("image", ds - 32 - 12, 12, 32, 32, lbg)
				sightexports.sGui:setImageFile(icon, powerIcon)
				sightexports.sGui:setImageColor(icon, "sightlightgrey")
				rbsElements[lbg] = {
					c,
					image,
					icon
				}
				sightexports.sGui:setClickEvent(lbg, "selectRBSObject")
			end
		end
		numOfRbsPerPage = c
		pages = math.ceil(#rbsList[rbsVehicleModel] / c)
		local w = 16 * pages
		local x = (sx * ds + spacing * 2) / 2 - w / 2
		local y = sy * ds + 16 - 12 + titlebarHeight
		local button = sightexports.sGui:createGuiElement("image", x - 24, y, 24, 24, rbsWindow)
		sightexports.sGui:setImageFile(button, sightexports.sGui:getFaIconFilename("caret-left", 24))
		sightexports.sGui:setGuiHover(button, "solid", "#ffffff")
		sightexports.sGui:setImageColor(button, "sightlightgrey")
		sightexports.sGui:setGuiHoverable(button, true)
		sightexports.sGui:setClickEvent(button, "rbsSelectPage")
		rbsPagers[button] = "minus"
		local button = sightexports.sGui:createGuiElement("image", x + w, y, 24, 24, rbsWindow)
		sightexports.sGui:setImageFile(button, sightexports.sGui:getFaIconFilename("caret-right", 24))
		sightexports.sGui:setGuiHover(button, "solid", "#ffffff")
		sightexports.sGui:setImageColor(button, "sightlightgrey")
		sightexports.sGui:setGuiHoverable(button, true)
		sightexports.sGui:setClickEvent(button, "rbsSelectPage")
		rbsPagers[button] = "plus"
		for i = 1, pages do
			local button = sightexports.sGui:createGuiElement("image", x + (i - 1) * 16, y + 12 - 8, 16, 16, rbsWindow)
			sightexports.sGui:setGuiHover(button, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(button, "rbsSelectPage")
			rbsPagers[button] = i - 1
		end
		refreshRBSPage()
	end
end
addEvent("openRBSGui", true)
addEventHandler("openRBSGui", getRootElement(), function(model, el)
	rbsVehicleModel = model
	rbsVehicleElement = el
	createRBSGui()
end)
addEvent("gotTrackingResult", true)
addEventHandler("gotTrackingResult", getRootElement(), function(x, y, z)
	local r, g, b = unpack(sightexports.sGui:getColorCode("sightblue"))
	table.insert(trackBlips, {
		createBlip(x, y, z, 8, 2, r, g, b),
		getTickCount()
	})
end)
local hasCuff = false
local hasCuffKey = false
function checkCuffItems()
	hasCuff = sightexports.sItems:playerHasItem(118)
	hasCuffKey = sightexports.sItems:playerHasItem(119)
	playerHover = false
	viszHover = false
end
addEvent("movedItemInInv", true)
addEventHandler("movedItemInInv", localPlayer, checkCuffItems)
local lastCuff = getTickCount()
addEventHandler("onClientClick", getRootElement(), function(btn, state)
	if state == "up" and playerHover then
		if getTickCount() - lastCuff < 1000 then
			sightexports.sGui:showInfobox("e", "Várj egy kicsit!")
			return
		end
		if viszHover then
			triggerServerEvent("doViszPlayer", localPlayer, playerHover)
		else
			triggerServerEvent("doCuffPlayer", localPlayer, playerHover)
		end
		lastCuff = getTickCount()
	end
end)
addEventHandler("onClientRender", getRootElement(), function()
	if isPedInVehicle(localPlayer) then
		if playerHover then
			sightexports.sGui:setCursorType("normal")
			sightexports.sGui:showTooltip()
			playerHover = false
			viszHover = false
		end
		return
	end
	local cx, cy = getCursorPosition()
	if cx then
		cx = cx * screenX
		cy = cy * screenY
	else
		if playerHover then
			sightexports.sGui:setCursorType("normal")
			sightexports.sGui:showTooltip()
			playerHover = false
			viszHover = false
		end
		return
	end
	local tmpPlayer = false
	local tmpVisz = false
	local x, y, z = getElementPosition(localPlayer)
	local players = getElementsByType("player", getRootElement(), true)
	for i = 1, #players do
		local client = players[i]
		if client ~= localPlayer then
			local px, py, pz = getElementPosition(client)
			if not getPedOccupiedVehicle(client) and getDistanceBetweenPoints3D(x, y, z, px, py, pz) <= 2 then
				local x, y = getScreenFromWorldPosition(px, py, pz, 128)
				if x then
					if cuffObjects[client] then
						if carryingOther[localPlayer] and carryingOther[localPlayer] ~= client then
							if hasCuffKey then
								dxDrawRectangle(x - 16, y - 16, 32, 32, btnBcg)
								if cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
									tmpPlayer = client
									tmpVisz = false
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImage(x - 12, y - 12, 24, 24, sightlangStaticImage[1], 0, 0, 0, btnCol)
								else
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImage(x - 12, y - 12, 24, 24, sightlangStaticImage[1])
								end
							end
						elseif not carryedBy[client] or carryedBy[client] == localPlayer then
							if hasCuffKey then
								dxDrawRectangle(x - 32 - 4, y - 16, 32, 32, btnBcg)
								if cx >= x - 32 - 4 and cx <= x - 4 and cy >= y - 16 and cy <= y + 16 then
									tmpPlayer = client
									tmpVisz = false
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImage(x - 4 - 16 - 12, y - 12, 24, 24, sightlangStaticImage[1], 0, 0, 0, btnCol)
								else
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImage(x - 4 - 16 - 12, y - 12, 24, 24, sightlangStaticImage[1])
								end
								dxDrawRectangle(x + 4, y - 16, 32, 32, btnBcg)
								if cx >= x + 4 and cx <= x + 4 + 32 and cy >= y - 16 and cy <= y + 16 then
									tmpPlayer = client
									tmpVisz = true
									sightlangStaticImageUsed[2] = true
									if sightlangStaticImageToc[2] then
										processsightlangStaticImage[2]()
									end
									dxDrawImage(x + 4 + 16 - 12, y - 12, 24, 24, sightlangStaticImage[2], 0, 0, 0, btnCol)
								else
									sightlangStaticImageUsed[2] = true
									if sightlangStaticImageToc[2] then
										processsightlangStaticImage[2]()
									end
									dxDrawImage(x + 4 + 16 - 12, y - 12, 24, 24, sightlangStaticImage[2])
								end
							else
								dxDrawRectangle(x - 16, y - 16, 32, 32, btnBcg)
								if cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
									tmpPlayer = client
									tmpVisz = true
									sightlangStaticImageUsed[2] = true
									if sightlangStaticImageToc[2] then
										processsightlangStaticImage[2]()
									end
									dxDrawImage(x - 12, y - 12, 24, 24, sightlangStaticImage[2], 0, 0, 0, btnCol)
								else
									sightlangStaticImageUsed[2] = true
									if sightlangStaticImageToc[2] then
										processsightlangStaticImage[2]()
									end
									dxDrawImage(x - 12, y - 12, 24, 24, sightlangStaticImage[2])
								end
							end
						end
					elseif hasCuff then
						dxDrawRectangle(x - 16, y - 16, 32, 32, btnBcg)
						if cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
							tmpPlayer = client
							tmpVisz = false
							sightlangStaticImageUsed[1] = true
							if sightlangStaticImageToc[1] then
								processsightlangStaticImage[1]()
							end
							dxDrawImage(x - 12, y - 12, 24, 24, sightlangStaticImage[1], 0, 0, 0, btnCol)
						else
							sightlangStaticImageUsed[1] = true
							if sightlangStaticImageToc[1] then
								processsightlangStaticImage[1]()
							end
							dxDrawImage(x - 12, y - 12, 24, 24, sightlangStaticImage[1])
						end
					end
				end
			end
		end
	end
	if tmpPlayer ~= playerHover or tmpVisz ~= viszHover then
		playerHover = tmpPlayer
		viszHover = tmpVisz
		if playerHover then
			sightexports.sGui:setCursorType("link")
			if cuffObjects[playerHover] then
				sightexports.sGui:showTooltip(viszHover and (carryedBy[playerHover] and "Elengedés" or "Megragadás") or "Bilincs levétele")
			else
				sightexports.sGui:showTooltip("Megbilincselés")
				viszHover = false
			end
		else
			sightexports.sGui:setCursorType("normal")
			sightexports.sGui:showTooltip()
		end
	end
end)
addEventHandler("onClientVehicleEnter", getRootElement(), function(ped, seat)
	if ped == localPlayer and carryingOther[localPlayer] then
		triggerServerEvent("forceEndVisz", localPlayer, carryingOther[localPlayer])
	end
end)
