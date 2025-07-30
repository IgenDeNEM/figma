local sightexports = {
	sModloader = false,
	sMetaldetector = false,
	sGui = false,
	sCore = false,
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
local sightlangDynImgLatCr = falselocal
sightlangDynImage = {}
local sightlangDynImageForm = {}
local sightlangDynImageMip = {}
local sightlangDynImageUsed = {}
local sightlangDynImageDel = {}
local sightlangDynImgPre = nil
function sightlangDynImgPre()
	local now = getTickCount()
	sightlangDynImgLatCr = true
	local rem = true
	for k in pairs(sightlangDynImage) do
		rem = false
		if sightlangDynImageDel[k] and sightlangDynImageDel[k] <= now then
			if isElement(sightlangDynImage[k]) then
				destroyElement(sightlangDynImage[k])
			end
			sightlangDynImage[k] = nil
			sightlangDynImageForm[k] = nil
			sightlangDynImageMip[k] = nil
			sightlangDynImageDel[k] = nil
			break
		elseif not sightlangDynImageUsed[k] then
			sightlangDynImageDel[k] = now + 5000
		end
	end
	for k in pairs(sightlangDynImageUsed) do
		if not sightlangDynImage[k] and sightlangDynImgLatCr then
			sightlangDynImgLatCr = false
			sightlangDynImage[k] = dxCreateTexture(k, sightlangDynImageForm[k], sightlangDynImageMip[k])
		end
		sightlangDynImageUsed[k] = nil
		sightlangDynImageDel[k] = nil
		rem = false
	end
	if rem then
		removeEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre)
		sightlangStatImgHand = false
	end
end

function dynamicImage(img, form, mip)
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre, true, "high+999999999")
	end
	if not sightlangDynImage[img] then
		sightlangDynImage[img] = dxCreateTexture(img, form, mip)
	end
	sightlangDynImageForm[img] = form
	sightlangDynImageUsed[img] = true
	return sightlangDynImage[img]
end

local sightgreen = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		sightgreen = sightexports.sGui:getColorCode("sightgreen-second")
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)

local function sightlangModloaderLoaded()
	modloaderLoaded()
end

addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end

local sightlangCondHandlState1 = false

local function checkPreRenderParticles(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState1 then
		sightlangCondHandlState1 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), preRenderParticles, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderParticles)
		end
	end
end

local sightlangCondHandlState2 = false

local function checkPreRenderMyBag(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState2 then
		sightlangCondHandlState2 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), preRenderMyBag, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderMyBag)
		end
	end
end

local sightlangCondHandlState3 = false

local function checkBagInHandEx(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState3 then
		sightlangCondHandlState3 = cond
		if cond then
			addEventHandler("onClientPedsProcessed", getRootElement(), bagInHandEx, true, prio)
		else
			removeEventHandler("onClientPedsProcessed", getRootElement(), bagInHandEx)
		end
	end
end
local sightlangCondHandlState4 = false
local function checkBagInHand(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState4 then
		sightlangCondHandlState4 = cond
		if cond then
			addEventHandler("onClientPedsProcessed", getRootElement(), bagInHand, true, prio)
		else
			removeEventHandler("onClientPedsProcessed", getRootElement(), bagInHand)
		end
	end
end
local staticBags = {}
local suitCaseModel = false
local suitCaseModel2 = false
local suitCaseHandleModel = false
local suitCaseObjects = {}
local suitCaseHandleObjects = {}

addEventHandler("onClientPlayerDataChange", getRootElement(), function(key, old, new)
	if key == "carryingSummerEvent" then
		if isElement(suitCaseObjects[source]) then
			destroyElement(suitCaseObjects[source])
		end
		suitCaseObjects[source] = nil
		if isElement(suitCaseHandleObjects[source]) then
			destroyElement(suitCaseHandleObjects[source])
		end
		suitCaseHandleObjects[source] = nil
		if new and isElementStreamedIn(source) and suitCaseModel2 then
			suitCaseObjects[source] = createObject(suitCaseModel2, 0, 0, 0)
			setElementCollisionsEnabled(suitCaseObjects[source], false)
			suitCaseHandleObjects[source] = createObject(suitCaseHandleModel, 0, 0, 0)
			setElementCollisionsEnabled(suitCaseHandleObjects[source], false)
			checkBagInHand(true, "low-99")
			checkBagInHandEx(true, "low-99999999999")
		end
	end
end)

addEventHandler("onClientPlayerStreamIn", getRootElement(), function()
	if isElement(suitCaseObjects[source]) then
		destroyElement(suitCaseObjects[source])
	end
	suitCaseObjects[source] = nil
	if isElement(suitCaseHandleObjects[source]) then
		destroyElement(suitCaseHandleObjects[source])
	end
	suitCaseHandleObjects[source] = nil
	if getElementData(source, "carryingSummerEvent") then
		suitCaseObjects[source] = createObject(suitCaseModel2, 0, 0, 0)
		setElementCollisionsEnabled(suitCaseObjects[source], false)
		suitCaseHandleObjects[source] = createObject(suitCaseHandleModel, 0, 0, 0)
		setElementCollisionsEnabled(suitCaseHandleObjects[source], false)
		checkBagInHand(true, "low-99")
		checkBagInHandEx(true, "low-99999999999")
	end
end)

addEventHandler("onClientPlayerStreamOut", getRootElement(), function()
	if isElement(suitCaseObjects[source]) then
		destroyElement(suitCaseObjects[source])
	end
	suitCaseObjects[source] = nil
	if isElement(suitCaseHandleObjects[source]) then
		destroyElement(suitCaseHandleObjects[source])
	end
	suitCaseHandleObjects[source] = nil
end)

addEventHandler("onClientPlayerQuit", getRootElement(), function()
	if isElement(suitCaseObjects[source]) then
		destroyElement(suitCaseObjects[source])
	end
	suitCaseObjects[source] = nil
	if isElement(suitCaseHandleObjects[source]) then
		destroyElement(suitCaseHandleObjects[source])
	end
	suitCaseHandleObjects[source] = nil
end)

function modloaderLoaded()
	suitCaseModel = sightexports.sModloader:getModelId("v4_vacation_suitcase")
	suitCaseModel2 = sightexports.sModloader:getModelId("v4_vacation_suitcase")
	suitCaseHandleModel = sightexports.sModloader:getModelId("v4_vacation_suitcase_handle")
	triggerServerEvent("requestSummerEventBags", localPlayer)
	local players = getElementsByType("player", getRootElement(), true)
	for i = 1, #players, 1 do
		if isElement(suitCaseObjects[players[i]]) then
			destroyElement(suitCaseObjects[players[i]])
		end
		suitCaseObjects[players[i]] = nil
		if isElement(suitCaseHandleObjects[players[i]]) then
			destroyElement(suitCaseHandleObjects[players[i]])
		end
		suitCaseHandleObjects[players[i]] = nil
		if getElementData(players[i], "carryingSummerEvent") then
			suitCaseObjects[players[i]] = createObject(suitCaseModel2, 0, 0, 0)
			setElementCollisionsEnabled(suitCaseObjects[players[i]], false)
			suitCaseHandleObjects[players[i]] = createObject(suitCaseHandleModel, 0, 0, 0)
			setElementCollisionsEnabled(suitCaseHandleObjects[players[i]], false)
			checkBagInHand(true, "low-99")
			checkBagInHandEx(true, "low-99999999999")
		end
	end
end

local myCharID = getElementData(localPlayer, "char.ID")
local tropicalSound = false
local currentBlip = false
local hX = nil
local hY = nil
local hZ = nil
local bagRotation = 0

addEventHandler("onClientElementDataChange", localPlayer, function(key, old, new)
	if key == "char.ID" and source == localPlayer then
		myCharID = new
	end
end)

addEvent("gotSummerEventBags", true)
addEventHandler("gotSummerEventBags", getRootElement(), function(bags)
	if suitCaseModel then
		for k, v in pairs(bags) do
			local hX, hY, hZ = sightexports.sMetaldetector:findNearestHoleCoord(v[1], v[2])
			local rx = v[3]
			local rz = v[4]
			if isElement(staticBags[k]) then
				destroyElement(staticBags[k])
			end
			staticBags[k] = nil
			if hX then
				staticBags[k] = createObject(suitCaseModel, hX, hY, hZ, math.deg(rx), 0, math.deg(rz))
				setElementCollisionsEnabled(staticBags[k], false)
				if k == myCharID and not isElement(currentBlip) then
					gZ = hZ
					gY = hY
					gX = hX
					if isElement(tropicalSound) then
						destroyElement(tropicalSound)
					end
					tropicalSound = nil
					if isElement(currentBlip) then
						destroyElement(currentBlip)
					end
					currentBlip = nil
					tropicalSound = playSound3D("files/tropical.mp3", hX, hY, hZ, true)
					setSoundMaxDistance(tropicalSound, 150)
					local rx = math.random() * 210
					local ry = math.pi * 2 * math.random()
					currentBlip = createBlip(hX + math.cos(ry) * rx, hY + math.sin(ry) * rx, hZ, 31, 2, sightgreen[1], sightgreen[2], sightgreen[3])
					setElementData(currentBlip, "tooltipText", "Elveszett poggyász")
					sightexports.sGui:showInfobox("i", "Az elveszett poggyász területe megjelölve a térképen.")
					checkPreRenderMyBag(true)
				end
			end
		end
	end
end)

addEvent("gotSummerEventBag", true)
addEventHandler("gotSummerEventBag", getRootElement(), function(charID, x, y, rx, rz)
	if suitCaseModel then
		if isElement(staticBags[charID]) then
			destroyElement(staticBags[charID])
		end
		staticBags[charID] = nil
		if x then
			local hX, hY, hZ = sightexports.sMetaldetector:findNearestHoleCoord(x, y)
			if hX then
				staticBags[charID] = createObject(suitCaseModel, hX, hY, hZ, math.deg(rx), 0, math.deg(rz))
				setElementCollisionsEnabled(staticBags[charID], false)
				if charID == myCharID and not isElement(currentBlip) then
					if isElement(tropicalSound) then
						destroyElement(tropicalSound)
					end
					tropicalSound = nil
					if isElement(currentBlip) then
						destroyElement(currentBlip)
					end
					currentBlip = nil

					gZ = hZ
					gY = hY
					gX = hX

					tropicalSound = playSound3D("files/tropical.mp3", hX, hY, hZ, true)
					setSoundMaxDistance(tropicalSound, 150)
					local rx = math.random() * 210
					local ry = math.pi * 2 * math.random()
					currentBlip = createBlip(hX + math.cos(ry) * rx, hY + math.sin(ry) * rx, hZ, 31, 2, sightgreen[1], sightgreen[2], sightgreen[3])
					setElementData(currentBlip, "tooltipText", "Elveszett poggyász")
					sightexports.sGui:showInfobox("i", "Az elveszett poggyász területe megjelölve a térképen.")
					checkPreRenderMyBag(true)
				end
			end
		end
	end
end)

local screenX, screenY = guiGetScreenSize()
local particles = {}

function spawnParticle(x, y, z)
	local rx = math.random() * math.pi * 2
	local ry = (math.random() * 2 + 1) * 0.125
	table.insert(particles, {
		x,
		y,
		z,
		(2.5 + 10 * math.random()) * 0.05,
		math.random(0, 2),
		(1 + math.random()) * 0.75,
		0,
		math.cos(math.pi * 2 * math.random()) * (math.random() * 0.5 + 1),
		-math.sin((math.pi * 2 * math.random())) * (math.random() * 0.5 + 1),
		0,
		(1 + math.random()) * 4,
		math.random() * 0.25 + 0.75,
		z + 15 + 10 * math.random(),
		math.cos(rx) * ry,
		math.sin(rx) * ry
	})
	checkPreRenderParticles(true)
end

function preRenderParticles(deltaTime)
	if #particles > 0 then
		local cx, cy, cz, lx, ly, lz = getCameraMatrix()
		local x = lx - cx
		local y = ly - cy
		local len = math.sqrt(x * x + y * y)
		x = x / len
		y = y / len
		local wx, wy, depth = getWorldFromScreenPosition(screenX / 2, 0, 128)
		local wx2, wy2, depth2 = getWorldFromScreenPosition(screenX / 2, screenY / 2, 128)
		wx = wx2 - wx
		wy = wy2 - wy
		depth = depth2 - depth
		local len2 = math.sqrt((wx * wx + wy * wy + depth * depth)) * 2
		wx = -wx / len2
		wy = -wy / len2
		depth = -depth / len2
		for i = #particles, 1, -1 do
			local x, y, z, dx, dy, dz, life, dfx, dfy, rad, r, a, next, s, t = unpack(particles[i])
			particles[i][1] = particles[i][1] + s * deltaTime / 1000
			particles[i][2] = particles[i][2] + t * deltaTime / 1000
			particles[i][3] = particles[i][3] + dz * deltaTime / 1000
			if life < 1 then
				particles[i][7] = math.min(1, particles[i][7] + dz * 0.5 * deltaTime / 1000)
			end
			particles[i][10] = particles[i][10] + 1 * deltaTime / 1000
			rad = math.cos(rad) / r
			x = x + dfx * rad
			y = y + dfy * rad
			local r37_19 = 1
			if next < particles[i][3] then
				r37_19 = 1 - (particles[i][3] - next) / 10
			end
			if r37_19 <= 0 then
				table.remove(particles, i)
			else
				dxDrawMaterialSectionLine3D(x + wx * dx, y + wy * dx, z + depth * dx, x - wx * dx, y - wy * dx, z - depth * dx, 64 * dy, 0, 64, 64, dynamicImage("files/particle.dds"), dx, tocolor(255, 255, 255, 255 * life * a * r37_19))
			end
		end
	else
		checkPreRenderParticles(false)
	end
end
function preRenderMyBag(deltaTime)
	if isElement(staticBags[myCharID]) then
		bagRotation = bagRotation - deltaTime
		if bagRotation < 0 then
			bagRotation = 20 + 30 * math.random()
			spawnParticle(gX, gY, gZ + 0.5)
		end
	else
		checkPreRenderMyBag(false)
		if isElement(tropicalSound) then
			destroyElement(tropicalSound)
		end
		tropicalSound = nil
		if isElement(currentBlip) then
			destroyElement(currentBlip)
		end
		currentBlip = nil
	end
end

function bagInHand()
	local refresh = true
	for player in pairs(suitCaseObjects) do
		refresh = false
		if isElementOnScreen(player) and getPedTask(player, "secondary", 0) ~= "TASK_SIMPLE_USE_GUN" and not isPedInVehicle(player) then
			setElementBoneRotation(player, 22, -3.2608757848325, 29.347817379495, -65.869567705237)
			setElementBoneRotation(player, 23, 16.956516763438, 9.1304347826087, 14.347819867341)
			sightexports.sCore:updateElementRpHAnim(player)
		end
	end
	if refresh then
		checkBagInHand(false)
		checkBagInHandEx(false)
	end
end
function bagInHandEx()
	for player, case in pairs(suitCaseObjects) do
		local handleObj = suitCaseHandleObjects[player]
		if isElementOnScreen(player) then
			local int = getElementInterior(player)
			local dim = getElementDimension(player)
			setElementInterior(case, int)
			setElementDimension(case, dim)
			setElementInterior(handleObj, int)
			setElementDimension(handleObj, dim)
			if getPedTask(player, "secondary", 0) == "TASK_SIMPLE_USE_GUN" or isPedInVehicle(player) then
				local x, y, z = getElementPosition(player)
				setElementPosition(case, x, y, z)
				setElementPosition(handleObj, x, y, z)
				setObjectScale(case, 0)
				setObjectScale(handleObj, 0)
			else
				local x, y, z = getPedBonePosition(player, 26)
				local rx, ry, rz = getElementRotation(player)
				local q = 0.5
				local rad = math.rad(rz)
				local cs = math.cos(rad) * q
				local sn = math.sin(rad) * q
				x = x + sn * 0.1
				y = y - cs * 0.1
				local lx = x + sn
				local ly = y - cs
				local hit, hx, hy, hz = processLineOfSight(lx, ly, z, lx, ly, z - 1.5)
				if not hit then
					hz = z - 1.5
					hy = ly
					hx = lx
				end
				setElementRotation(case, math.deg(math.atan((z - hz) / q)) - 90, 0, rz)
				setElementPosition(case, hx, hy, hz)
				local r = math.sqrt(math.pow(z - hz, 2) + q * q) - 1.19276 + 0.025
				local fx = x - lx
				local fy = y - ly
				local fz = z - hz
				local s = math.sqrt(fx * fx + fy * fy + fz * fz)
				fx = fx / s * r
				fy = fy / s * r
				fz = fz / s * r
				setElementRotation(handleObj, math.deg(math.atan((z - hz) / q)) - 90, 0, rz)
				setElementPosition(handleObj, hx + fx, hy + fy, hz + fz)
				setObjectScale(case, 1)
				setObjectScale(handleObj, 1)
			end
		else
			local x, y, z = getElementPosition(player)
			setElementPosition(case, x, y, z)
			setElementPosition(handleObj, x, y, z)
		end
	end
end
