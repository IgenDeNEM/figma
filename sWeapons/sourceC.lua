local sightexports = {
	sItems = false,
	sShield = false,
	sTestloader = false,
	sGui = false,
	sModloader = false,
	sPattach = false,
	sControls = false
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

airsoftItems = {}

function isAirsoftItem(id)
	local is = false
	for k, v in pairs(airsoftItems) do
		if v == id then
			is = true
			break
		end
	end
	return is
end

function gotAirsoftItems()
	airsoftItems = sightexports.sItems:getAirsoftItems()
end

function itemsStarted()
	if not loaded then
		local res = getResourceFromName("sItems")
		if res and getResourceState(res) == "running" then
			gotAirsoftItems()
			loaded = true
		end
	end
end

if triggerServerEvent then
	addEventHandler("onClientResourceStart", getRootElement(), itemsStarted)
end
if triggerClientEvent then
	addEventHandler("onResourceStart", getRootElement(), itemsStarted)
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
sightlangStaticImageToc[4] = true
sightlangStaticImageToc[5] = true
sightlangStaticImageToc[6] = true
sightlangStaticImageToc[7] = true
sightlangStaticImageToc[8] = true
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
	if sightlangStaticImageUsed[4] then
		sightlangStaticImageUsed[4] = false
		sightlangStaticImageDel[4] = false
	elseif sightlangStaticImage[4] then
		if sightlangStaticImageDel[4] then
			if now >= sightlangStaticImageDel[4] then
				if isElement(sightlangStaticImage[4]) then
					destroyElement(sightlangStaticImage[4])
				end
				sightlangStaticImage[4] = nil
				sightlangStaticImageDel[4] = false
				sightlangStaticImageToc[4] = true
				return
			end
		else
			sightlangStaticImageDel[4] = now + 5000
		end
	else
		sightlangStaticImageToc[4] = true
	end
	if sightlangStaticImageUsed[5] then
		sightlangStaticImageUsed[5] = false
		sightlangStaticImageDel[5] = false
	elseif sightlangStaticImage[5] then
		if sightlangStaticImageDel[5] then
			if now >= sightlangStaticImageDel[5] then
				if isElement(sightlangStaticImage[5]) then
					destroyElement(sightlangStaticImage[5])
				end
				sightlangStaticImage[5] = nil
				sightlangStaticImageDel[5] = false
				sightlangStaticImageToc[5] = true
				return
			end
		else
			sightlangStaticImageDel[5] = now + 5000
		end
	else
		sightlangStaticImageToc[5] = true
	end
	if sightlangStaticImageUsed[6] then
		sightlangStaticImageUsed[6] = false
		sightlangStaticImageDel[6] = false
	elseif sightlangStaticImage[6] then
		if sightlangStaticImageDel[6] then
			if now >= sightlangStaticImageDel[6] then
				if isElement(sightlangStaticImage[6]) then
					destroyElement(sightlangStaticImage[6])
				end
				sightlangStaticImage[6] = nil
				sightlangStaticImageDel[6] = false
				sightlangStaticImageToc[6] = true
				return
			end
		else
			sightlangStaticImageDel[6] = now + 5000
		end
	else
		sightlangStaticImageToc[6] = true
	end
	if sightlangStaticImageUsed[7] then
		sightlangStaticImageUsed[7] = false
		sightlangStaticImageDel[7] = false
	elseif sightlangStaticImage[7] then
		if sightlangStaticImageDel[7] then
			if now >= sightlangStaticImageDel[7] then
				if isElement(sightlangStaticImage[7]) then
					destroyElement(sightlangStaticImage[7])
				end
				sightlangStaticImage[7] = nil
				sightlangStaticImageDel[7] = false
				sightlangStaticImageToc[7] = true
				return
			end
		else
			sightlangStaticImageDel[7] = now + 5000
		end
	else
		sightlangStaticImageToc[7] = true
	end
	if sightlangStaticImageUsed[8] then
		sightlangStaticImageUsed[8] = false
		sightlangStaticImageDel[8] = false
	elseif sightlangStaticImage[8] then
		if sightlangStaticImageDel[8] then
			if now >= sightlangStaticImageDel[8] then
				if isElement(sightlangStaticImage[8]) then
					destroyElement(sightlangStaticImage[8])
				end
				sightlangStaticImage[8] = nil
				sightlangStaticImageDel[8] = false
				sightlangStaticImageToc[8] = true
				return
			end
		else
			sightlangStaticImageDel[8] = now + 5000
		end
	else
		sightlangStaticImageToc[8] = true
	end
	if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] then
		sightlangStatImgHand = false
		removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
	end
end
processsightlangStaticImage[0] = function()
	if not isElement(sightlangStaticImage[0]) then
		sightlangStaticImageToc[0] = false
		sightlangStaticImage[0] = dxCreateTexture("files/lecer.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("weapons/wrench2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[2] = function()
	if not isElement(sightlangStaticImage[2]) then
		sightlangStaticImageToc[2] = false
		sightlangStaticImage[2] = dxCreateTexture("weapons/wrench.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[3] = function()
	if not isElement(sightlangStaticImage[3]) then
		sightlangStaticImageToc[3] = false
		sightlangStaticImage[3] = dxCreateTexture("weapons/hex.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[4] = function()
	if not isElement(sightlangStaticImage[4]) then
		sightlangStaticImageToc[4] = false
		sightlangStaticImage[4] = dxCreateTexture("files/scope_dragunov.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[5] = function()
	if not isElement(sightlangStaticImage[5]) then
		sightlangStaticImageToc[5] = false
		sightlangStaticImage[5] = dxCreateTexture("files/scope_m110.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[6] = function()
	if not isElement(sightlangStaticImage[6]) then
		sightlangStaticImageToc[6] = false
		sightlangStaticImage[6] = dxCreateTexture("files/scope_m110_tan.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[7] = function()
	if not isElement(sightlangStaticImage[7]) then
		sightlangStaticImageToc[7] = false
		sightlangStaticImage[7] = dxCreateTexture("files/scope_m700.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[8] = function()
	if not isElement(sightlangStaticImage[8]) then
		sightlangStaticImageToc[8] = false
		sightlangStaticImage[8] = dxCreateTexture("files/lecer2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
local sightlangDynImgHand = false
local sightlangDynImgLatCr = falselocal
sightlangDynImage = {}
local sightlangDynImageForm = {}
local sightlangDynImageMip = {}
local sightlangDynImageUsed = {}
local sightlangDynImageDel = {}
local sightlangDynImgPre
function sightlangDynImgPre()
	local now = getTickCount()
	sightlangDynImgLatCr = true
	local rem = true
	for k in pairs(sightlangDynImage) do
		rem = false
		if sightlangDynImageDel[k] then
			if now >= sightlangDynImageDel[k] then
				if isElement(sightlangDynImage[k]) then
					destroyElement(sightlangDynImage[k])
				end
				sightlangDynImage[k] = nil
				sightlangDynImageForm[k] = nil
				sightlangDynImageMip[k] = nil
				sightlangDynImageDel[k] = nil
				break
			end
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
		sightlangDynImgHand = false
	end
end
local function dynamicImage(img, form, mip)
	if not sightlangDynImgHand then
		sightlangDynImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangDynImgPre, true, "high+999999999")
	end
	if not sightlangDynImage[img] then
		sightlangDynImage[img] = dxCreateTexture(img, form, mip)
	end
	sightlangDynImageForm[img] = form
	sightlangDynImageUsed[img] = true
	return sightlangDynImage[img]
end
local sightlangGuiRefreshColors = function()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		guiRefreshColors()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local sightlangModloaderLoaded = function()
	modelsLoaded()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState1 then
		sightlangCondHandlState1 = cond
		if cond then
			addEventHandler("onClientKey", getRootElement(), clickPhysgun, true, prio)
		else
			removeEventHandler("onClientKey", getRootElement(), clickPhysgun)
		end
	end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), preRenderPhysgun, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderPhysgun)
		end
	end
end
screenX, screenY = guiGetScreenSize()
local textureList = {}
local textureCache = {}
local textureShader = {}
local textureUsed = {}
local textureUsedOnBack = {}
local textureName = {}
local wpData = {}
local wpType = {}
local wpObjects = {}
local wpSkin = {}
local weaponItemPics = {}
local currentWeapon, currentWeaponType, currentWeaponPic, currentWeaponAmmo, currentWeaponHeating, currentWeaponCooling
local overheating = false
local currentHeat = 0
addEvent("weaponCooldownSound", true)
addEventHandler("weaponCooldownSound", getRootElement(), function()
	if isElement(source) and isElementStreamedIn(source) then
		if source == localPlayer then
			overheating = false
		end
		local x, y, z = getElementPosition(source)
		local s = playSound3D("files/cooled.mp3", x, y, z)
		setElementDimension(s, getElementDimension(source))
		setElementInterior(s, getElementInterior(source))
		attachElements(s, source)
	end
end)
addEvent("weaponOverheatSound", true)
addEventHandler("weaponOverheatSound", getRootElement(), function()
	if isElement(source) and isElementStreamedIn(source) then
		if source == localPlayer then
			currentHeat = 1
			overheating = true
		end
		local x, y, z = getElementPosition(source)
		local s = playSound3D("files/overheat.mp3", x, y, z)
		setElementDimension(s, getElementDimension(source))
		setElementInterior(s, getElementInterior(source))
		attachElements(s, source)
	end
end)
addEvent("gotCurrentWeapon", true)
addEventHandler("gotCurrentWeapon", getRootElement(), function(cw, item, heat, overheat)
	if weaponItemIds[item] then
		currentWeapon = cw
		currentWeaponType = weaponItemIds[item]
		currentWeaponPic = weaponItemPics[item]
		setPhysgunMode(currentWeaponType == "physgun")
		if not getElementData(localPlayer, "airsoftgun") then
			currentWeaponHeating = customWeapons[currentWeaponType].heating
			currentWeaponCooling = customWeapons[currentWeaponType].cooling
			currentHeat = heat
			overheating = overheat
		end
		currentAirsoft = item
		if customWeapons[currentWeaponType].scope then
			if customWeapons[currentWeaponType].itemId == item then
				createScope(customWeapons[currentWeaponType].scope)
			elseif customWeapons[currentWeaponType].skinScope then
				for id, skin in pairs(customWeapons[currentWeaponType].skins) do
					if id == item then
						if customWeapons[currentWeaponType].skinScope[skin] then
							createScope(customWeapons[currentWeaponType].skinScope[skin])
						else
							createScope(customWeapons[currentWeaponType].scope)
						end
						return
					end
				end
				deleteScope()
			else
				createScope(customWeapons[currentWeaponType].scope)
			end
		else
			deleteScope()
		end
	else
		setPhysgunMode(false)
		currentWeapon = false
		currentWeaponType = false
		currentWeaponPic = false
		currentWeaponHeating = false
		currentWeaponCooling = false
		deleteScope()
	end
end)
addEvent("gotCurrentWeaponAmmo", true)
addEventHandler("gotCurrentWeaponAmmo", getRootElement(), function(ammo)
	currentWeaponAmmo = ammo
end)
local now, cx, cy, cz
local lastMuzzle = {}
local lastMuzzleType = {}
local reverbSound = {}
local reverb2Sound = {}
local lastShot = {}
local lastShotTime = {}
local lastShotWeapon = {}
local lastShotX = {}
local lastShotY = {}
local lastShotZ = {}
local lastDrop = {}
local lastDropX = {}
local lastDropY = {}
local lastDropZ = {}
setWorldSoundEnabled(5, true)
setWorldSoundEnabled(5, 52, false)
setWorldSoundEnabled(5, 53, false)
setWorldSoundEnabled(5, 6, false)
setWorldSoundEnabled(5, 7, false)
setWorldSoundEnabled(5, 8, false)
setWorldSoundEnabled(5, 76, false)
setWorldSoundEnabled(5, 77, false)
setWorldSoundEnabled(5, 74, false)
setWorldSoundEnabled(5, 24, false)
setWorldSoundEnabled(5, 73, false)
setWorldSoundEnabled(5, 21, false)
setWorldSoundEnabled(5, 22, false)
setWorldSoundEnabled(5, 23, false)
setWorldSoundEnabled(5, 29, false)
setWorldSoundEnabled(5, 30, false)
setWorldSoundEnabled(5, 17, false)
setWorldSoundEnabled(5, 18, false)
setWorldSoundEnabled(5, 2, false)
setWorldSoundEnabled(5, 0, false)
setWorldSoundEnabled(5, 1, false)
setWorldSoundEnabled(5, 33, false)
setWorldSoundEnabled(5, 3, false)
setWorldSoundEnabled(5, 4, false)
setWorldSoundEnabled(5, 5, false)
setWorldSoundEnabled(5, 26, false)
setWorldSoundEnabled(5, 27, false)
local bulletImpacts = {}
local bulletRoute = {}
function reverseMatrix(m, x, y, z)
	return (-m[2][1] * m[3][2] * z + m[2][1] * m[3][3] * y - m[2][2] * m[3][3] * x + m[2][2] * m[3][1] * z + m[3][2] * m[2][3] * x - m[2][3] * m[3][1] * y) / (-m[1][1] * m[2][2] * m[3][3] + m[1][1] * m[3][2] * m[2][3] - m[1][3] * m[2][1] * m[3][2] + m[1][3] * m[2][2] * m[3][1] + m[2][1] * m[3][3] * m[1][2] - m[1][2] * m[2][3] * m[3][1]), (m[1][1] * m[3][2] * z - m[1][1] * m[3][3] * y - m[1][3] * m[3][2] * x + m[1][3] * m[3][1] * y + m[3][3] * m[1][2] * x - m[1][2] * m[3][1] * z) / (-m[1][1] * m[2][2] * m[3][3] + m[1][1] * m[3][2] * m[2][3] - m[1][3] * m[2][1] * m[3][2] + m[1][3] * m[2][2] * m[3][1] + m[2][1] * m[3][3] * m[1][2] - m[1][2] * m[2][3] * m[3][1]), (-m[1][1] * m[2][2] * z + m[1][1] * m[2][3] * y - m[1][3] * m[2][1] * y + m[1][3] * m[2][2] * x + m[2][1] * m[1][2] * z - m[1][2] * m[2][3] * x) / (-m[1][1] * m[2][2] * m[3][3] + m[1][1] * m[3][2] * m[2][3] - m[1][3] * m[2][1] * m[3][2] + m[1][3] * m[2][2] * m[3][1] + m[2][1] * m[3][3] * m[1][2] - m[1][2] * m[2][3] * m[3][1])
end

function resetBulletImpacts()
	bulletImpacts = {}
end

local bulletMatrixTMP = {}
local metalRange = {5, 8}
local woodRange = {9, 13}
local glassRange = {14, 18}
local texRange = {
	[50] = metalRange,
	[51] = metalRange,
	[52] = metalRange,
	[53] = metalRange,
	[54] = metalRange,
	[55] = metalRange,
	[56] = metalRange,
	[57] = metalRange,
	[58] = metalRange,
	[59] = metalRange,
	[63] = metalRange,
	[64] = metalRange,
	[65] = metalRange,
	[162] = metalRange,
	[164] = metalRange,
	[167] = metalRange,
	[168] = metalRange,
	[171] = metalRange,
	[42] = woodRange,
	[43] = woodRange,
	[44] = woodRange,
	[70] = woodRange,
	[72] = woodRange,
	[73] = woodRange,
	[172] = woodRange,
	[173] = woodRange,
	[174] = woodRange,
	[45] = glassRange,
	[46] = glassRange,
	[47] = glassRange,
	[175] = glassRange
}
local lastDamage = {}
local frameCounter = 0
addEvent("onRealizedDamage", true)
addEventHandler("onClientPlayerDamage", localPlayer, function(attacker, weapon, bodyPart, loss)
	if usedGTAWeapons[weapon] then
		cancelEvent()
		lastDamage = {
			attacker,
			weapon,
			bodyPart,
			frameCounter
		}
	else
		triggerEvent("onRealizedDamage", localPlayer, attacker, weapon, bodyPart, loss)
	end
end, true, "high+999999999")
addEventHandler("onRealizedDamage", localPlayer, function()
end)
local canAmmoSync = {}
local canAmmoToSync = false
setTimer(function()
	if canAmmoToSync then
		triggerServerEvent("syncCanAmmo", localPlayer, canAmmoSync)
		canAmmoSync = {}
		canAmmoToSync = false
	end
end, 2000, 0)
addEventHandler("onClientResourceStop", getRootElement(), function()
	if canAmmoToSync then
		triggerServerEvent("syncCanAmmo", localPlayer, canAmmoSync)
		canAmmoSync = {}
		canAmmoToSync = false
	end
end)
local shieldModel = false
function playRicochetSound(x, y, z, int, dim)
	local sound = playSound3D("files/ricochet/bullet" .. math.random(1, 6) .. ".wav", x, y, z)
	setElementInterior(sound, int)
	setElementDimension(sound, dim)
	setSoundMaxDistance(sound, 150)
end
local accumShieldDmg = 0
local shieldDmgPerBullet = 0.5
addEventHandler("onClientPlayerWeaponFire", getRootElement(), function(weapon, ammo, ammoInClip, x, y, z, el)
	if source == localPlayer and customWeapons[currentWeaponType] and customWeapons[currentWeaponType].projectileAmmo then
		triggerServerEvent("takeProjectileAmmo", localPlayer, weapon)
		return
	end
	if source == localPlayer and customWeapons[currentWeaponType] and customWeapons[currentWeaponType].selfCanAmmo then
		canAmmoToSync = true
		if not canAmmoSync[currentWeaponType] then
			canAmmoSync[currentWeaponType] = {}
		end
		canAmmoSync[currentWeaponType][currentWeapon] = (canAmmoSync[currentWeaponType][currentWeapon] or 0) + 1
		sightexports.sItems:takeBullet(currentWeapon)
		return
	end
	if source == localPlayer and currentWeaponAmmo and customWeapons[currentWeaponType] and customWeapons[currentWeaponType].canAmmo then
		canAmmoToSync = true
		if not canAmmoSync[currentWeaponType] then
			canAmmoSync[currentWeaponType] = {}
		end
		canAmmoSync[currentWeaponType][currentWeaponAmmo] = (canAmmoSync[currentWeaponType][currentWeaponAmmo] or 0) + 1
		sightexports.sItems:takeBullet(currentWeaponAmmo)
		return
	end
	if usedGTAWeapons[weapon] then
		local sx, sy, sz = getPedWeaponMuzzlePosition(source)
		local vx, vy, vz = sx - x, sy - y, sz - z
		local len = math.sqrt(vx * vx + vy * vy + vz * vz)
		vx, vy, vz = vx / len, vy / len, vz / len
		local hit, hx, hy, hz, he, nx, ny, nz, mat = processLineOfSight(sx, sy, sz, sx - vx * len * 1.1, sy - vy * len * 1.1, sz - vz * len * 1.1, true, true, false, true, false, false, false, true, wpObjects[source], false)
		if hit and he ~= localPlayer then
			local veh = getPedOccupiedVehicle(localPlayer)
			if he == veh then
				he = localPlayer
			end
		end
		local wep = wpType[source]
		if customWeapons[wep] and customWeapons[wep].weaponId ~= weapon then
			return
		end
		if customWeapons[wep] and customWeapons[wep].taser then
			if source == localPlayer and el and getElementType(el) == "player" and (he == el or not hit) then
				triggerServerEvent("gotTazedPlayer", localPlayer, el)
			end
			return
		end
		if source == localPlayer then
			local wep = currentWeaponType
			if customWeapons[wep] and currentWeaponAmmo and weapon == customWeapons[wep].weaponId then
				sightexports.sItems:takeBullet(currentWeaponAmmo)
			end
			if currentWeaponHeating then
				currentHeat = currentHeat + currentWeaponHeating
			end
		elseif lastDamage and lastDamage[1] == source and lastDamage[2] == weapon and lastDamage[4] == frameCounter and wep and customWeapons[wep].weaponId == weapon then
			local canHit = false
			if he == localPlayer or not hit then
				canHit = true
			else
				canHit = len < getDistanceBetweenPoints3D(hx, hy, hz, sx, sy, sz)
			end
			if canHit and customWeapons[wep].range then
				local ir = math.max(0, len - 10) / customWeapons[wep].range
				if ir < 1 then
					local loss = math.pow(1 - ir, customWeapons[wep].rangePow)
					triggerServerEvent("selfWeaponDamage", localPlayer, lastDamage[1], wep, lastDamage[3], loss)
					triggerEvent("onRealizedDamage", localPlayer, lastDamage[1], weapon, lastDamage[3], loss * customWeapons[wep].damage)
				end
			end
			lastDamage = false
		end
		if he and (getElementType(he) == "player" or getElementType(he) == "ped") then
			he = nil
			hit = false
		end
		if wep then
			if hit and len < (customWeapons[wep].range or 0) then
				local sx, sy, sz
				if isElement(he) and getElementType(he) == "vehicle" then
					if not bulletMatrixTMP[he] then
						bulletMatrixTMP[he] = getElementMatrix(he)
					end
					local m = bulletMatrixTMP[he]
					hx = hx - m[4][1]
					hy = hy - m[4][2]
					hz = hz - m[4][3]
					hx, hy, hz = reverseMatrix(m, hx, hy, hz)
					nx, ny, nz = reverseMatrix(m, nx, ny, nz)
				elseif isElement(he) and getElementModel(he) == shieldModel then
					if not bulletMatrixTMP[he] then
						bulletMatrixTMP[he] = getElementMatrix(he)
					end
					local m = bulletMatrixTMP[he]
					hx = hx - m[4][1]
					hy = hy - m[4][2]
					hz = hz - m[4][3]
					hx, hy, hz = reverseMatrix(m, hx, hy, hz)
					nx, ny, nz = reverseMatrix(m, nx, ny, nz)
					local x, y, z = getElementPosition(he)
					playRicochetSound(x, y, z, getElementInterior(he), getElementDimension(he))
					local myShield = sightexports.sShield:getMyShield()
					if myShield and myShield == he then
						accumShieldDmg = accumShieldDmg + shieldDmgPerBullet
						if 4 <= accumShieldDmg then
							triggerServerEvent("damageMyShield", localPlayer)
							accumShieldDmg = 0
						end
					end
				else
					he = nil
				end
				local shoti = 25 <= weapon and weapon <= 27
				if not he or shoti then
					sx, sy, sz = cross(nx, ny, nz, 0, 0, 1)
					local len = math.sqrt(sx * sx + sy * sy + sz * sz)
					sx = sx / len
					sy = sy / len
					sz = sz / len
					if sx ~= sx then
						sx, sy, sz = 1, 0, 0
					end
				end
				local tex = math.random(1, 4)
				if texRange[mat] then
					tex = math.random(texRange[mat][1], texRange[mat][2])
				end
				table.insert(bulletImpacts, {
					hx + nx * 0.0075,
					hy + ny * 0.0075,
					hz + nz * 0.0075,
					nx,
					ny,
					nz,
					sx,
					sy,
					sz,
					he,
					tex,
					getTickCount()
				})
				if shoti then
					local ex, ey, ez = cross(sx, sy, sz, nx, ny, nz)
					local s = math.max(3.5, len) / 5 * 0.15
					for i = 1, math.random(3, 6) do
						table.insert(bulletImpacts, {
							hx + nx * 0.0075 + sx * (-s + s * 2 * math.random()) + ex * (-s + s * 2 * math.random()),
							hy + ny * 0.0075 + sy * (-s + s * 2 * math.random()) + ey * (-s + s * 2 * math.random()),
							hz + nz * 0.0075 + sz * (-s + s * 2 * math.random()) + ez * (-s + s * 2 * math.random()),
							nx,
							ny,
							nz,
							sx,
							sy,
							sz,
							he,
							tex,
							getTickCount()
						})
					end
				end
				for i = 100, #bulletImpacts do
					table.remove(bulletImpacts, 1)
				end
			end
			table.insert(bulletRoute, {
				x,
				y,
				z,
				vx,
				vy,
				vz,
				math.min(len, customWeapons[wep].range or 0)
			})
			if customWeapons[wep].sound then
				if getElementData(source, "airsoftgun") then
					shootSound(source, airsoftSounds[wep], sx, sy, sz, true)
				else
					shootSound(source, customWeapons[wep].sound, sx, sy, sz)
				end
			end
			if customWeapons[wep].muzzle then
				lastMuzzle[source] = getTickCount()
				lastMuzzleType[source] = customWeapons[wep].muzzle
			end
		end
	end
end)

local muzzleOffset = {
	{279, 261},
	{256, 256},
	{260, 249},
	{256, 256},
	{254, 255},
	{258, 239},
	{269, 259},
	{251, 233},
	{101, 241},
	{103, 246},
	{105, 251},
	{100, 275},
	{93, 240},
	{78, 268},
	{51, 222},
	{94, 268},
	{63, 320},
	{103, 270},
	{74, 262},
	{95, 267}
}
local frames = {
	3,
	3,
	3,
	3,
	3,
	2,
	8,
	3,
	3,
	3,
	3,
	3,
	8,
	8,
	8,
	8,
	8,
	12,
	8,
	8
}
local muzzleTex = {}
for i = 1, #frames do
	muzzleTex[i] = dxCreateTexture("files/muzzle/" .. i .. ".dds")
	dxSetTextureEdge(muzzleTex[i], "clamp")
end
function getPositionFromMatrixOffset(m, offX, offY, offZ)
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z
end
function getVectorFromMatrixOffset(m, offX, offY, offZ)
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3]
	return x, y, z
end
function cross(x, y, z, x2, y2, z2)
	return y * z2 - y2 * z, z * x2 - z2 * x, x * y2 - x2 * y
end
function applyMatrixOffset(m, offX, offY, offZ)
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3]
	return x, y, z
end
function getPositionFromMatrixOffset(m, offX, offY, offZ)
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z
end
local imp = dxCreateTexture("files/imp.dds")
local texIds = {
	{
		0,
		0,
		1
	},
	{
		0,
		1,
		1
	},
	{
		1,
		0,
		1
	},
	{
		1,
		1,
		1
	},
	{
		2,
		0,
		1
	},
	{
		3,
		0,
		1
	},
	{
		2,
		1,
		1
	},
	{
		3,
		1,
		1
	},
	{
		4,
		0,
		1
	},
	{
		5,
		0,
		1
	},
	{
		4,
		1,
		1
	},
	{
		5,
		1,
		1
	},
	{
		4,
		2,
		1
	},
	{
		0,
		2,
		2
	},
	{
		0,
		4,
		2
	},
	{
		2,
		2,
		2
	},
	{
		2,
		4,
		2
	},
	{
		4,
		4,
		2
	}
}
local laserData = {}
local taserCharge = 1
addEvent("gotTaserDischarge", true)
addEventHandler("gotTaserDischarge", getRootElement(), function()
	taserCharge = 0
end)
local textureDeleteTimer = {}
addEventHandler("onClientPreRender", getRootElement(), function(delta)
	now = getTickCount()
	for tid, t in pairs(textureDeleteTimer) do
		if t < now then
			deleteFromCache(tid)
		end
	end
	if taserCharge < 1 then
		taserCharge = taserCharge + 0.1 * delta / 1000
		if 1 < taserCharge then
			taserCharge = 1
		end
	end
	frameCounter = frameCounter + 1
	if 10000000 < frameCounter then
		frameCounter = 0
	end
	bulletMatrixTMP = {}
	for i = #bulletImpacts, 1, -1 do
		local x, y, z = bulletImpacts[i][1], bulletImpacts[i][2], bulletImpacts[i][3]
		local vx, vy, vz = bulletImpacts[i][4], bulletImpacts[i][5], bulletImpacts[i][6]
		local sx, sy, sz = bulletImpacts[i][7], bulletImpacts[i][8], bulletImpacts[i][9]
		local he = bulletImpacts[i][10]
		local t = 5
		if isElement(he) then
			t = 1
			if not bulletMatrixTMP[he] then
				bulletMatrixTMP[he] = getElementMatrix(he)
			end
			x, y, z = getPositionFromMatrixOffset(bulletMatrixTMP[he], x, y, z)
			vx, vy, vz = applyMatrixOffset(bulletMatrixTMP[he], vx, vy, vz)
			sx, sy, sz = cross(vx, vy, vz, 0, 0, 1)
			local len = math.sqrt(sx * sx + sy * sy + sz * sz)
			sx = sx / len
			sy = sy / len
			sz = sz / len
			if sx ~= sx then
				sx, sy, sz = 1, 0, 0
			end
		end
		local a = 255
		local delta = now - bulletImpacts[i][12] - t * 60 * 1000
		if 0 < delta then
			a = 255 - delta / 2000 * 255
		end
		if a < 0 then
			table.remove(bulletImpacts, i)
		elseif sx then
			local tex = texIds[bulletImpacts[i][11]]
			local ts = tex[3]
			local s = 0.05 * ts
			dxDrawMaterialSectionLine3D(x + sx * s, y + sy * s, z + sz * s, x - sx * s, y - sy * s, z - sz * s, 64 * tex[1], 64 * tex[2], 64 * ts, 64 * ts, imp, s * 2, tocolor(255, 255, 255, a), x + vx, y + vy, z + vz)
		end
	end
	for i = #bulletRoute, 1, -1 do
		local x, y, z = bulletRoute[i][1], bulletRoute[i][2], bulletRoute[i][3]
		local vx, vy, vz = bulletRoute[i][4], bulletRoute[i][5], bulletRoute[i][6]
		local len = bulletRoute[i][7] - 400 * delta / 1000
		if len < 0 then
			table.remove(bulletRoute, i)
		else
			bulletRoute[i][7] = len
			dxDrawLine3D(x, y, z, x + vx * len, y + vy * len, z + vz * len, tocolor(225, 225, 225, 25), 0.25)
		end
	end
	if currentWeaponCooling and 0 < currentHeat then
		currentHeat = currentHeat - currentWeaponCooling * delta / 1000
		if currentHeat < 0 then
			currentHeat = 0
			overheating = false
		end
	end
	cx, cy, cz = getCameraMatrix()
	for client, t in pairs(lastDrop) do
		if 550 <= now - t then
			local s = playSound3D("sounds/drop2.wav", lastDropX[client], lastDropY[client], lastDropZ[client] - 1)
			setSoundMaxDistance(s, 50)
			setElementDimension(s, getElementDimension(client))
			setElementInterior(s, getElementInterior(client))
			lastDrop[client] = nil
			lastDropX[client] = nil
			lastDropY[client] = nil
			lastDropZ[client] = nil
		end
	end
	for client, t in pairs(lastShot) do
		if now - t >= lastShotTime[client] then
			if isElement(reverbSound[client]) then
				destroyElement(reverbSound[client])
			end
			if isElement(reverb2Sound[client]) then
				destroyElement(reverb2Sound[client])
			end
			local d = getDistanceBetweenPoints3D(lastShotX[client], lastShotY[client], lastShotZ[client], cx, cy, cz)
			local dv = 1
			local dv2 = 0
			if 30 < d then
				if 80 < d then
					dv2 = 1
					dv = 0
				else
					dv2 = (d - 30) / 50
					dv = 1 - dv2
				end
				local rev2 = lastShotWeapon[client]
				if rev2 == "tec9" then
					rev2 = "uzi"
				elseif rev2 == "mp7" then
					rev2 = "mp5"
				elseif rev2 == "m4light" then
					rev2 = "m4"
				end
				reverb2Sound[client] = playSound3D("sounds/" .. rev2 .. "rev2.wav", lastShotX[client], lastShotY[client], lastShotZ[client])
				setSoundMaxDistance(reverb2Sound[client], 600)
				setSoundVolume(reverb2Sound[client], 1.5 * dv2 * 1.125)
				setElementDimension(reverb2Sound[client], getElementDimension(client))
				setElementInterior(reverb2Sound[client], getElementInterior(client))
			end
			if 0 < dv then
				local rev = lastShotWeapon[client]
				if rev == "tec9" then
					rev = "uzi"
				elseif rev == "mp7" then
					rev = "mp5"
				elseif rev == "m4light" then
					rev = "m4"
				end
				reverbSound[client] = playSound3D("sounds/" .. rev .. "rev.wav", lastShotX[client], lastShotY[client], lastShotZ[client])
				setSoundMaxDistance(reverbSound[client], 300)
				setSoundVolume(reverbSound[client], dv * 1.125)
				setElementDimension(reverbSound[client], getElementDimension(client))
				setElementInterior(reverbSound[client], getElementInterior(client))
			end
			lastShot[client] = nil
			lastShotTime[client] = nil
			lastShotWeapon[client] = nil
			lastShotX[client] = nil
			lastShotY[client] = nil
			lastShotZ[client] = nil
		end
	end
	local players = getElementsByType("player", getRootElement(), true)
	local playerMatrix = {}
	for i = 1, #players do
		local client = players[i]
		if wpObjects[client] then
			local wep = wpType[client]
			if customWeapons[wep].laser and (not isPedInVehicle(client) or isPedDoingGangDriveby(client)) then
				local laser = laserData[client] or 1
				if 0 < laser then
					if not playerMatrix[client] then
						playerMatrix[client] = getElementMatrix(wpObjects[client])
					end
					local aim = getPedTask(client, "secondary", 0) == "TASK_SIMPLE_USE_GUN"
					local isFPMode = exports.sCamera:getCurrentCamera() == "fp"
					
					if isElementOnScreen(client) then
						local x, y, z = getPositionFromMatrixOffset(playerMatrix[client], customWeapons[wep].laser[1], customWeapons[wep].laser[2], customWeapons[wep].laser[3])
						local vx, vy, vz
						
						if isFPMode then
							local rotX, rotY, rotZ = getElementRotation(client)
							local forwardLength = 300
							
							vx = x + math.sin(math.rad(rotZ)) * forwardLength
							vy = y + math.cos(math.rad(rotZ)) * forwardLength
							vz = z
						else
							vx, vy, vz = getVectorFromMatrixOffset(playerMatrix[client], customWeapons[wep].laser[4], customWeapons[wep].laser[5], customWeapons[wep].laser[6])
						end
						
						local colFound = false
						if not isFPMode and getPedTask(client, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
							vx, vy, vz = getPedTargetEnd(client)
							if client == localPlayer then
								local sx, sy = getScreenFromWorldPosition(vx, vy, vz)
								if sx then
									local x1, y1, z1 = getWorldFromScreenPosition(sx, sy, 0)
									local x2, y2, z2 = getWorldFromScreenPosition(sx, sy, 300)
									local collision, cx, cy, cz, element = processLineOfSight(x1, y1, z1, x2, y2, z2, true, true, true, true, true, false, false, false)
									if collision then
										vx, vy, vz = cx, cy, cz
										colFound = true
									end
								end
							end
							if not colFound then
								vx = vx - x
								vy = vy - y
								vz = vz - z
								local len = math.sqrt(vx * vx + vy * vy + vz * vz)
								vx = x + vx / len * 300
								vy = y + vy / len * 300
								vz = z + vz / len * 300
							end
						else
							vx, vy, vz = x + vx * 300, y + vy * 300, z + vz * 300
						end
						
						if vx == vx then
							if not colFound then
								local collision, cx, cy, cz, element = processLineOfSight(x, y, z, vx, vy, vz, true, true, true, true, true, false, false, false)
								if collision then
									vx, vy, vz = cx, cy, cz
								end
							end
							sightlangStaticImageUsed[0] = true
							if sightlangStaticImageToc[0] then
								processsightlangStaticImage[0]()
							end
							dxDrawMaterialSectionLine3D(x, y, z, vx, vy, vz, 22 * (laser - 1), 0, 22, 300, sightlangStaticImage[0], 0.05, tocolor(255, 255, 255, 155 + 55 * math.random()))
						end
					else
						local x, y, z = getPedWeaponMuzzlePosition(client)
						local vx, vy, vz = getPedTargetEnd(client)
						vx = vx - x
						vy = vy - y
						vz = vz - z
						local len = math.sqrt(vx * vx + vy * vy + vz * vz)
						if 0 < len then
							vx = x + vx / len * 300
							vy = y + vy / len * 300
							vz = z + vz / len * 300
							local collision, cx, cy, cz, element = processLineOfSight(x, y, z, vx, vy, vz, true, true, true, true, true, false, false, false)
							if collision then
								vx, vy, vz = cx, cy, cz
							end
							sightlangStaticImageUsed[0] = true
							if sightlangStaticImageToc[0] then
								processsightlangStaticImage[0]()
							end
							dxDrawMaterialSectionLine3D(x, y, z, vx, vy, vz, 22 * (laser - 1), 0, 22, 300, sightlangStaticImage[0], 0.05, tocolor(255, 255, 255, 155 + 55 * math.random()))
						end
					end
				end
			end
			if lastMuzzle[client] then
				local f = math.floor((now - lastMuzzle[client]) / 25)
				local muzzle = lastMuzzleType[client]
				local t1 = muzzle[1]
				local t2 = muzzle[2]
				if f > math.max(frames[t1], frames[t2]) then
					lastMuzzle[client] = nil
					lastMuzzleType[client] = nil
				else
					if not playerMatrix[client] then
						playerMatrix[client] = getElementMatrix(wpObjects[client])
					end
					local m = playerMatrix[client]
					local x, y, z = getPositionFromMatrixOffset(m, muzzle[5], muzzle[6], muzzle[7])
					local vx, vy, vz = getVectorFromMatrixOffset(m, muzzle[8], muzzle[9], muzzle[10])
					local tx, ty, tz = m[3][1], m[3][2], m[3][3]
					local sx, sy, sz = cross(vx, vy, vz, tx, ty, tz)
					if f < frames[t1] then
						local s = muzzle[3]
						local xOff = (muzzleOffset[t1][1] - 256) / 512 * s * 2
						local zOff = (muzzleOffset[t1][2] - 256) / 512 * s * 2
						local x, y, z = x + tx * zOff + sx * xOff, y + ty * zOff + sy * xOff, z + tz * zOff + sz * xOff
						dxDrawMaterialSectionLine3D(x + tx * s, y + ty * s, z + tz * s, x - tx * s, y - ty * s, z - tz * s, 512 * f, 0, 512, 512, false, muzzleTex[t1], s * 2, tocolor(255, 255, 255), x + vx, y + vy, z + vz)
					end
					if f < frames[t2] then
						local s = muzzle[4]
						local xOff = muzzleOffset[t2][1] / 512 * s
						local zOff = muzzleOffset[t2][2]
						local x, y, z = x - vx * xOff, y - vy * xOff, z - vz * xOff
						dxDrawMaterialSectionLine3D(x, y, z, x + vx * s, y + vy * s, z + vz * s, 512 * f, zOff - 256, 512, 512, true, muzzleTex[t2], s)
					end
				end
			end
		end
	end
	local x, y, z = -2203.001953125, -2441.3291015625, 30.6171875
end)
function shootSound(client, t, x, y, z, airsoft)
	local d = getDistanceBetweenPoints3D(x, y, z, cx, cy, cz)
	if d < 300 then
		if isElement(reverbSound[client]) then
			destroyElement(reverbSound[client])
		end
		reverbSound[client] = nil
		if isElement(reverb2Sound[client]) then
			destroyElement(reverb2Sound[client])
		end
		reverb2Sound[client] = nil
		local cv = 1
		local dv = 0
		local dv2 = 0
		if 150 < d then
			dv2 = 1
			cv = 0
		elseif 70 < d then
			dv2 = (d - 70) / 80
			dv = 1 - dv2
			cv = 0
		elseif 10 < d then
			dv = (d - 10) / 60
			cv = 1 - dv
		end
		if 0 < cv then
			local s = playSound3D("sounds/" .. t .. ".wav", x, y, z)
			setSoundMaxDistance(s, 350)
			setSoundVolume(s, cv * 1.125)
			setElementDimension(s, getElementDimension(client))
			setElementInterior(s, getElementInterior(client))
		end
		if t == "shoti" and d < 40 then
			local s = playSound3D("sounds/" .. t .. "load.wav", x, y, z - 1)
			setSoundMaxDistance(s, 40)
			setElementDimension(s, getElementDimension(client))
			setElementInterior(s, getElementInterior(client))
		end
		if d < 50 and not airsoft then
			local s = playSound3D("sounds/drop.wav", x, y, z - 1)
			setSoundMaxDistance(s, 50)
			setElementDimension(s, getElementDimension(client))
			setElementInterior(s, getElementInterior(client))
			lastDrop[client] = now
			lastDropX[client] = x
			lastDropY[client] = y
			lastDropZ[client] = z
		end
		local dist = t
		if t == "rev2" then
			dist = "rev"
		elseif t == "tec9" then
			dist = "uzi"
		elseif t == "mp7" then
			dist = "mp5"
		elseif t == "m4light" then
			dist = "m4"
		elseif t == "silenced" then
			dist = nil
		end
		if dist and 0 < dv and not airsoft then
			local s = playSound3D("sounds/" .. dist .. "dist.wav", x, y, z)
			setSoundMaxDistance(s, 400)
			setSoundVolume(s, 1.25 * dv * 1.125)
			setElementDimension(s, getElementDimension(client))
			setElementInterior(s, getElementInterior(client))
		end
		local dist2 = t
		if t == "rev2" then
			dist2 = "rev"
		elseif t == "mp5" or t == "mp7" or t == "uzi" or t == "tec9" then
			dist2 = "smg"
		elseif t == "sniper" then
			dist2 = "rifle"
		elseif t == "m4light" or t == "m16a2" then
			dist2 = "m4"
		elseif t == "silenced" then
			dist2 = nil
		end
		if dist2 and 0 < dv2 and not airsoft then
			local s = playSound3D("sounds/" .. dist2 .. "dist2.wav", x, y, z)
			setSoundMaxDistance(s, 600)
			setSoundVolume(s, 1.5 * dv2 * 1.125)
			setElementDimension(s, getElementDimension(client))
			setElementInterior(s, getElementInterior(client))
		end
		lastShotTime[client] = nil
		if t == "ak" then
			lastShotTime[client] = 279
		elseif t == "m4" or t == "m4light" then
			lastShotTime[client] = 168
		elseif t == "colt" then
			lastShotTime[client] = 140
		elseif t == "i_shoti" then
			lastShotTime[client] = 190
		elseif t == "mp5" then
			lastShotTime[client] = 180
		elseif t == "mp7" then
			lastShotTime[client] = 200
		elseif t == "uzi" or t == "tec9" then
			lastShotTime[client] = 135
		elseif t == "rifle" then
			lastShotTime[client] = 250
		elseif t == "sniper" then
			lastShotTime[client] = 270
		elseif t == "ak74" then
			lastShotTime[client] = 140
		elseif t == "m16a2" then
			lastShotTime[client] = 120
		elseif t == "bm9" then
			lastShotTime[client] = 145
		elseif t == "fnp40" then
			lastShotTime[client] = 150
		elseif t == "nagant" then
			lastShotTime[client] = 285
		elseif t == "fnfal" then
			lastShotTime[client] = 120
		elseif t == "draco" then
			lastShotTime[client] = 200
		elseif t == "p90" then
			lastShotTime[client] = 200
		elseif t == "m700" then
			lastShotTime[client] = 250
		end
		if lastShotTime[client] then
			lastShot[client] = now
			lastShotWeapon[client] = t
			lastShotX[client] = x
			lastShotY[client] = y
			lastShotZ[client] = z
		end
	end
end
local weaponPicDimensions = {}
local weaponPicOriginalDimensions = {
	["wep_ak-74"] = {290, 76},
	["wep_ak-74_skin_1"] = {290, 76},
	["wep_ak-74_skin_2"] = {290, 76},
	["wep_ak-74_skin_3"] = {290, 76},
	["wep_ak-74_skin_4"] = {290, 76},
	["wep_ak-74_skin_airsoft"] = {290, 76},
	ak47 = {258, 78},
	ak47_skin_camo = {258, 78},
	ak47_skin_camo2 = {258, 78},
	ak47_skin_camo3 = {258, 78},
	ak47_skin_gold = {258, 78},
	ak47_skin_gold2 = {258, 78},
	ak47_skin_kitty = {258, 78},
	ak47_skin_silver = {258, 78},
	ak47_skin_ak47halloween = {258, 78},
	ak47_skin_airsoft = {258, 78},
	ak47_skin_easter = {258, 78},
	["wep_ar-15"] = {278, 78},
	["wep_ar-15_aimpoint"] = {278, 98},
	["wep_ar-15_aimpoint_skin_1"] = {278, 98},
	["wep_ar-15_aimpoint_skin_2"] = {278, 98},
	["wep_ar-15_holo"] = {278, 90},
	["wep_ar-15_holo_skin_1"] = {278, 90},
	["wep_ar-15_holo_skin_2"] = {278, 90},
	["wep_ar-15_skin_1"] = {278, 78},
	["wep_ar-15_skin_2"] = {278, 78},
	["wep_ar-15_skin_airsoft"] = {278, 78},
	colt45 = {160, 104},
	wep_colt_1911 = {162, 102},
	wep_colt_1911_skin_1 = {162, 102},
	wep_colt_1911_skin_2 = {162, 102},
	wep_colt_1911_skin_3 = {162, 102},
	desert_eagle = {232, 134},
	desert_eagle_skin_camo = {232, 134},
	desert_eagle_skin_gold = {232, 134},
	desert_eagle_skin_hellokitty = {232, 134},
	["desert_eagle_skin_airsoft"] = {232, 134},
	["wep_glock-17"] = {154, 104},
	["wep_glock-19"] = {172, 128},
	["wep_glock-19_skin_1"] = {172, 128},
	["wep_glock-19_skin_2"] = {172, 128},
	["wep_glock-19_skin_3"] = {172, 128},
	["wep_glock-19_skin_4"] = {172, 128},
	["wep_glock-19_skin_5"] = {172, 128},
	["wep_glock-19_skin_6"] = {172, 128},
	["wep_glock-19_skin_7"] = {172, 128},
	["wep_glock-19_skin_airsoft"] = {172, 128},
	["wep_glock-19_skin_8"] = {172, 128},
	["wep_glock-19_skin_9"] = {172, 128},
	["wep_glock-19_skin_10"] = {172, 128},
	wep_hk_usp45 = {164, 116},
	wep_hk_usp45_skin_1 = {164, 116},
	wep_hk_usp45_skin_2 = {164, 116},
	wep_hk_usp45_skin_3 = {164, 116},
	wep_hk_usp45_skin_4 = {164, 116},
	wep_m110 = {268, 74},
	wep_m110_skin_1 = {268, 74},
	wep_m110_skin_airsoft = {268, 74},
	m4 = {248, 78},
	wep_m4a1 = {272, 88},
	wep_m4a1_skin_1 = {272, 88},
	wep_m4a1_skin_2 = {272, 88},
	wep_m4a1_skin_3 = {272, 88},
	wep_m4a1_skin_4 = {272, 88},
	wep_m4a1_sopmod = {272, 90},
	wep_m4a1_sopmod_skin_1 = {272, 90},
	wep_m4a1_sopmod_skin_2 = {272, 90},
	wep_m4a1_sopmod_skin_3 = {272, 90},
	wep_m4a1_sopmod_skin_4 = {272, 90},
	wep_m4a1_skin_airsoft = {272, 90},
	wep_m4a1_skin_5 = {272, 90},
	wep_m4a1_skin_6 = {272, 90},
	wep_m700 = {290, 52},
	wep_m700_skin_airsoft = {290, 52},
	wep_micro_draco = {220, 138},
	wep_micro_draco_skin_airsoft = {220, 138},
	wep_micro_draco_skin_gingerbread = {220, 138},
	wep_micro_draco_skin_easter = {220, 138},
	wep_mosin_nagant = {280, 46},
	wep_mosin_nagant_skin_1 = {280, 46},
	wep_mosin_nagant_skin_2 = {280, 46},
	mp5lng = {254, 136},
	mp5lng_skin_mp51 = {254, 136},
	mp5lng_skin_mp52 = {254, 136},
	mp5lng_skin_mp53 = {254, 136},
	mp5lng_skin_mp54 = {254, 136},
	mp5lng_skin_mp55 = {254, 136},
	mp5lng_skin_airsoft = {254, 136},
	mp5lng_skin_mp52xmas = {254, 136},
	mp5lng_skin_mp56 = {254, 136},
	wep_mp7a1 = {244, 116},
	wep_mp7a1_aimpoint = {244, 134},
	wep_mp7a1_aimpoint_skin_1 = {244, 134},
	wep_mp7a1_aimpoint_skin_2 = {244, 134},
	wep_mp7a1_skin_1 = {244, 116},
	wep_mp7a1_skin_2 = {244, 116},
	wep_mp7a1_skin_airsoft = {244, 116},
	wep_p90 = {278, 120},
	wep_p90_skin_1 = {278, 120},
	wep_p90_skin_2 = {278, 120},
	wep_p90_skin_3 = {278, 120},
	wep_p90_skin_4 = {278, 120},
	wep_p90_skin_5 = {278, 120},
	wep_p90_skin_6 = {278, 120},
	wep_p90_skin_7 = {278, 120},
	wep_p90_skin_8 = {278, 120},
	wep_p90_skin_9 = {278, 120},
	wep_p90_skin_airsoft = {278, 120},
	wep_p90_skin_10 = {278, 120},
	rifle = {262, 48},
	shotgun = {284, 58},
	shotgun_skin_1 = {284, 58},
	shotgun_skin_2 = {284, 58},
	shotgun_skin_3 = {284, 58},
	shotgun_skin_4 = {284, 58},
	silenced = {218, 90},
	sniper = {288, 84},
	sniper_skin_camo = {288, 84},
	sniper_skin_camo2 = {288, 84},
	sniper_skin_airsoft = {288, 84},
	sniper2 = {288, 84},
	sniper2_skin_summer1 = {288, 84},
	sniper2_skin_summer2 = {288, 84},
	["spaz-12"] = {240, 70},
	wep_sw_model66 = {198, 116},
	wep_sw_model66_skin_1 = {198, 116},
	wep_sw_model66_skin_2 = {198, 116},
	wep_sw_model66_skin_3 = {198, 116},
	wep_sw_model66_skin_4 = {198, 116},
	tec9 = {182, 142},
	tec9_skin_tec1 = {182, 142},
	tec9_skin_tec2 = {182, 142},
	tec9_skin_tec3 = {182, 142},
	tec9_skin_tec4 = {182, 142},
	tec9_skin_airsoft = {182, 142},
	uzi = {174, 136},
	uzi_skin_uzi1 = {174, 136},
	uzi_skin_uzi2 = {174, 136},
	uzi_skin_uzi3 = {174, 136},
	uzi_skin_uzi4 = {174, 136},
	uzi_skin_airsoft = {174, 136},
	sawnoff = {236, 80},
	sawnoff_skin_1 = {236, 80},
	sawnoff_skin_2 = {236, 80},
	sawnoff_skin_3 = {236, 80},
	sawnoff_skin_4 = {236, 80},
	sawnoff_skin_5 = {236, 80},
	sawnoff_skin_6 = {236, 80},
	wep_benelli_m4 = {278, 58},
	wep_benelli_m4_skin_1 = {278, 58},
	wep_benelli_m4_skin_2 = {278, 58},
	wep_benelli_m4_skin_airsoft = {278, 58},
	bat = {272, 64},
	cane = {288, 64},
	katana = {282, 64},
	katana_skin_1 = {282, 64},
	katana_skin_2 = {282, 64},
	wep_vipera = {280, 64},
	golfclub = {266, 64},
	bard = {234, 72},
	bard_skin_1 = {234, 72},
	bard_skin_2 = {234, 72},
	boxer = {100, 134},
	camera = {146, 66},
	chnsaw = {272, 94},
	fire_ex = {102, 142},
	flower = {238, 108},
	grenade = {48, 136},
	gun_para = {90, 124},
	knife = {268, 100},
	knife_skin_knife1 = {268, 100},
	knife_skin_knife2 = {268, 100},
	knife_skin_knife3 = {268, 100},
	knife_skin_knife4 = {268, 100},
	knife_skin_knife5 = {268, 100},
	knife_skin_knife6 = {268, 100},
	knife_skin_knife7 = {268, 100},
	knife_skin_knife8 = {268, 100},
	knife_skin_knife9 = {268, 100},
	molotov = {134, 118},
	nitestick = {270, 68},
	shovel = {288, 54},
	spraycan = {42, 132},
	teargas = {74, 140},
	wep_axe = {268, 90},
	wep_suspension = {234, 66},
	wep_hammer = {240, 100},
	wep_pipe_wrench = {292, 100},
	wep_taser_x26 = {212, 96},
	["wep_glock-19_laser"] = {172, 128},
	["wep_glock-19_laser_skin_1"] = {172, 128},
	["wep_glock-19_laser_skin_2"] = {172, 128},
	["wep_glock-19_laser_skin_3"] = {172, 128},
	["wep_glock-19_laser_skin_4"] = {172, 128},
	["wep_glock-19_laser_skin_5"] = {172, 128},
	["wep_glock-19_laser_skin_6"] = {172, 128}
}
local weaponPicScales = {}
for wp, dat in pairs(weaponPicOriginalDimensions) do
	weaponPicScales[wp] = 64 / dat[2]
	weaponPicDimensions[wp] = dat[1] * weaponPicScales[wp]
end
for wp, dat in pairs(customWeapons) do
	if weaponPicDimensions[wp] then
		weaponItemPics[dat.itemId] = wp
	end
	if dat.skins then
		for item, skin in pairs(dat.skins) do
			if weaponPicDimensions[wp .. "_skin_" .. skin] then
				local foundAirsoft = false
				for keys, values in pairs(customWeapons[wp].skins) do
					if customWeapons[wp].skins and skin == "airsoft" then
						if values == "airsoft" then
							weaponItemPics[item] = wp .. "_skin_" .. skin
						end
					end
				end
				if not foundAirsoft then
					weaponItemPics[item] = wp .. "_skin_" .. skin
				end
			end
		end
	end
end
local wrenchState = false
local wrenchRot = 0
local lastRotAnim = 0
local wrenchRotAnimation = false
function setWrenchRotation(rot)
	wrenchRotAnimation = rot
	lastRotAnim = getTickCount()
end
function setWrenchState(s)
	wrenchState = s
	if not s then
		wrenchRotAnimation = false
	end
end
local weaponWidgetState, weaponWidgetPos, weaponWidgetSize, dataFont, dataFontScale, hudWhite, hudWhite2, redColor, blueColor
function guiRefreshColors()
	redColor = sightexports.sGui:getColorCode("sightred")
	blueColor = sightexports.sGui:getColorCode("sightblue")
	hudWhite = sightexports.sGui:getColorCodeToColor("hudwhite")
	local r, g, b = unpack(sightexports.sGui:getColorCode("hudwhite"))
	hudWhite2 = string.format("#%.2X%.2X%.2X", r * 0.8, g * 0.8, b * 0.8)
	dataFont = sightexports.sGui:getFont("15/BebasNeueBold.otf")
	dataFontScale = sightexports.sGui:getFontScale("15/BebasNeueBold.otf")
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	bindKey("r", "down", "reloadmyweapon")
end)
function drawWeaponPic(x, y, w)
	local border = 16 * weaponPicScales[currentWeaponPic]
	local taser = customWeapons[currentWeaponType].taser and taserCharge or 1
	local heat = currentWeaponHeating and math.min(1, currentHeat) or 0
	if overheating then
		local pulse = getTickCount() % 1200 / 600
		if 1 < pulse then
			pulse = getEasingValue(2 - pulse, "OutQuad")
		else
			pulse = getEasingValue(pulse, "OutQuad")
		end
		dxDrawImage(x - border, y - border, w + border * 2, 64 + border * 2, dynamicImage("hud/glow/" .. currentWeaponPic .. ".dds"), 0, 0, 0, tocolor(redColor[1], redColor[2], redColor[3], 225 * pulse))
	elseif taser < 1 then
		local pulse = getTickCount() % 1200 / 600
		if 1 < pulse then
			pulse = getEasingValue(2 - pulse, "OutQuad")
		else
			pulse = getEasingValue(pulse, "OutQuad")
		end
		dxDrawImage(x - border, y - border, w + border * 2, 64 + border * 2, dynamicImage("hud/glow/" .. currentWeaponPic .. ".dds"), 0, 0, 0, tocolor(blueColor[1], blueColor[2], blueColor[3], 225 * pulse))
	elseif 0 < heat then
		dxDrawImage(x - border, y - border, w + border * 2, 64 + border * 2, dynamicImage("hud/glow/" .. currentWeaponPic .. ".dds"), 0, 0, 0, tocolor(redColor[1], redColor[2], redColor[3], 225 * heat))
	end
	dxDrawImage(x, y, w, 64, dynamicImage("hud/" .. currentWeaponPic .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 225))
	if taser < 1 then
		local od = weaponPicOriginalDimensions[currentWeaponPic]
		dxDrawImageSection(x, y, w * taser, 64, 0, 0, od[1] * taser, od[2], dynamicImage("hud/white/" .. currentWeaponPic .. ".dds"), 0, 0, 0, tocolor(blueColor[1], blueColor[2], blueColor[3], 125))
	elseif 0 < heat then
		local od = weaponPicOriginalDimensions[currentWeaponPic]
		dxDrawImageSection(x, y, w * heat, 64, 0, 0, od[1] * heat, od[2], dynamicImage("hud/white/" .. currentWeaponPic .. ".dds"), 0, 0, 0, tocolor(redColor[1], redColor[2], redColor[3], 125))
	end
	if customWeapons[currentWeaponType].selfCanAmmo then
		dxDrawText(getPedTotalAmmo(localPlayer), 0, y + 64 + 8, x + w, 0, hudWhite, dataFontScale, dataFont, "right", "top", false, false, false, true)
	elseif currentWeaponAmmo then
		local wp = getPedWeapon(localPlayer)
		if wp == 25 or wp == 33 or wp == 34 then
			dxDrawText(getPedTotalAmmo(localPlayer), 0, y + 64 + 8, x + w, 0, hudWhite, dataFontScale, dataFont, "right", "top", false, false, false, true)
		else
			dxDrawText(getPedAmmoInClip(localPlayer) .. " / " .. hudWhite2 .. getPedTotalAmmo(localPlayer), 0, y + 64 + 8, x + w, 0, hudWhite, dataFontScale, dataFont, "right", "top", false, false, false, true)
		end
	end
end
function renderWeapon()
	local id = getPedWeapon(localPlayer)
	if currentWeaponPic then
		local w = weaponPicDimensions[currentWeaponPic]
		local x, y = weaponWidgetPos[1] + weaponWidgetSize[1] - w, weaponWidgetPos[2]
		drawWeaponPic(x, y, w)
	elseif wrenchState then
		local id = "wrench"
		local w = 77.10843373493977
		local h = 64
		local x, y = weaponWidgetPos[1] + weaponWidgetSize[1] - w, weaponWidgetPos[2]
		local hs = 1.8421052631578947 * wrenchState
		sightlangStaticImageUsed[1] = true
		if sightlangStaticImageToc[1] then
			processsightlangStaticImage[1]()
		end
		dxDrawImage(x + (wrenchRotAnimation and 1 or 0), y, w, h, sightlangStaticImage[1])
		sightlangStaticImageUsed[2] = true
		if sightlangStaticImageToc[2] then
			processsightlangStaticImage[2]()
		end
		dxDrawImage(x, y, w, h, sightlangStaticImage[2])
		if wrenchRotAnimation then
			local delta = now - lastRotAnim
			lastRotAnim = now
			wrenchRot = (wrenchRot + delta / 1000 * 360 * 3.5 * wrenchRotAnimation) % 360
		end
		sightlangStaticImageUsed[3] = true
		if sightlangStaticImageToc[3] then
			processsightlangStaticImage[3]()
		end
		dxDrawImage(x + w - hs, y + h + 8, hs, hs, sightlangStaticImage[3], wrenchRot)
		dxDrawText("M" .. wrenchState, x + w - hs - 8, y + h + 8, x + w - hs - 8, y + h + 8 + hs, hudWhite, dataFontScale * 0.8, dataFont, "right", "center", false, false, false, true)
	end
end
addEvent("hudWidgetState:weapon", false)
addEventHandler("hudWidgetState:weapon", getRootElement(), function(state)
	if weaponWidgetState ~= state then
		weaponWidgetState = state
		if weaponWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderWeapon)
		else
			removeEventHandler("onClientRender", getRootElement(), renderWeapon)
		end
	end
end)
addEvent("hudWidgetPosition:weapon", false)
addEventHandler("hudWidgetPosition:weapon", getRootElement(), function(pos, final)
	weaponWidgetPos = pos
end)
addEvent("hudWidgetSize:weapon", false)
addEventHandler("hudWidgetSize:weapon", getRootElement(), function(size, final)
	weaponWidgetSize = size
end)
triggerEvent("requestWidgetDatas", localPlayer, "weapon")
local skillPrompt = false
local skillBookId = false
function deleteSkillPrompt()
	if skillPrompt then
		sightexports.sGui:deleteGuiElement(skillPrompt)
	end
	skillBookId = false
	skillPrompt = false
end
addEvent("weaponCancelSkill", false)
addEventHandler("weaponCancelSkill", getRootElement(), deleteSkillPrompt)
addEvent("weaponOkaySkill", false)
addEventHandler("weaponOkaySkill", getRootElement(), function()
	triggerServerEvent("useWeaponSkillBook", localPlayer, skillBookId)
	deleteSkillPrompt()
end)
addEvent("gotWeaponSkillPrompt", true)
addEventHandler("gotWeaponSkillPrompt", getRootElement(), function(dbID, item, dat)
	deleteSkillPrompt()
	skillBookId = dbID
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local fh = sightexports.sGui:getFontHeight("11/Ubuntu-R.ttf") + 12
	local w = sightexports.sGui:getTextWidthFont("Fegyver", "11/Ubuntu-R.ttf") + 12
	local w2 = sightexports.sGui:getTextWidthFont("Jelenlegi", "11/Ubuntu-L.ttf") + 12
	for i = 1, #dat do
		dat[i][1] = sightexports.sItems:getItemName(dat[i][1])
		w = math.max(w, sightexports.sGui:getTextWidthFont(dat[i][1], "11/Ubuntu-R.ttf") + 12)
	end
	local pw = 325
	local ph = titleBarHeight + 30 + 12 + fh * (2 + #dat + 1) + 6
	skillPrompt = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
	sightexports.sGui:setWindowTitle(skillPrompt, "16/BebasNeueRegular.otf", "Mesterkönyv")
	local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, fh * 2, skillPrompt)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "Biztosan szeretnéd elhasználni?\n[color=sightgreen]" .. sightexports.sItems:getItemName(item))
	sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	local y = titleBarHeight + fh * 2
	local x = pw / 2 - (w + w2) / 2
	local rect = sightexports.sGui:createGuiElement("rectangle", x, y, w + w2, fh, skillPrompt)
	sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
	local label = sightexports.sGui:createGuiElement("label", x, y, w, fh, skillPrompt)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "Fegyver")
	sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	local ah = fh * (#dat + 1)
	local border = sightexports.sGui:createGuiElement("hr", x - 1, y, 2, ah, skillPrompt)
	local border = sightexports.sGui:createGuiElement("hr", x + w - 1, y, 2, ah, skillPrompt)
	local border = sightexports.sGui:createGuiElement("hr", x + w + w2 - 1, y, 2, ah, skillPrompt)
	local border = sightexports.sGui:createGuiElement("hr", x, y - 1, w + w2, 2, skillPrompt)
	local border = sightexports.sGui:createGuiElement("hr", x, y + ah - 1, w + w2, 2, skillPrompt)
	local label = sightexports.sGui:createGuiElement("label", x + w, y, w2, fh, skillPrompt)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "Jelenlegi")
	sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	for i = 1, #dat do
		local y = titleBarHeight + fh * (2 + i)
		local border = sightexports.sGui:createGuiElement("hr", x, y - 1, w + w2, 2, skillPrompt)
		local label = sightexports.sGui:createGuiElement("label", x, y, w, fh, skillPrompt)
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelText(label, dat[i][1])
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		local label = sightexports.sGui:createGuiElement("label", x + w, y, w2, fh, skillPrompt)
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelText(label, dat[i][2] .. "%")
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
	end
	local bw = (pw - 18) / 2
	local btn = sightexports.sGui:createGuiElement("button", 6, ph - 30 - 6, bw, 30, skillPrompt)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(btn, "Igen")
	sightexports.sGui:setClickEvent(btn, "weaponOkaySkill")
	local btn = sightexports.sGui:createGuiElement("button", pw - bw - 6, ph - 30 - 6, bw, 30, skillPrompt)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightred",
		"sightred-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(btn, "Nem")
	sightexports.sGui:setClickEvent(btn, "weaponCancelSkill")
end)
local changerShader = " texture gTexture; technique hello { pass P0 { Texture[0] = gTexture; } } "
function deleteFromCache(tid)
	textureDeleteTimer[tid] = nil
	if isElement(textureCache[tid]) then
		destroyElement(textureCache[tid])
	end
	textureCache[tid] = nil
	if isElement(textureShader[tid]) then
		destroyElement(textureShader[tid])
	end
	textureShader[tid] = nil
end
function processWPSkinBack(client, itemId, new)
	local wep = weaponItemIds[itemId]
	if customWeapons[wep] then
		local tid = customWeapons[wep].textures and customWeapons[wep].textures[itemId]
		if tid then
			if new then
				textureDeleteTimer[tid] = nil
				if not isElement(textureCache[tid]) then
					textureCache[tid] = dxCreateTexture(textureList[tid])
				end
				if not isElement(textureShader[tid]) then
					textureShader[tid] = dxCreateShader(changerShader, 0, 0, false, "object")
					dxSetShaderValue(textureShader[tid], "gTexture", textureCache[tid])
				end
				for i = #textureUsedOnBack[tid], 1, -1 do
					if textureUsedOnBack[tid][i] == client then
						return textureShader[tid], textureName[tid], textureCache[tid]
					end
				end
				table.insert(textureUsedOnBack[tid], client)
			else
				for i = #textureUsedOnBack[tid], 1, -1 do
					if textureUsedOnBack[tid][i] == client then
						table.remove(textureUsedOnBack[tid], i)
					end
				end
				if #textureUsed[tid] <= 0 and #textureUsedOnBack[tid] <= 0 then
					textureDeleteTimer[tid] = getTickCount() + 5000
				end
			end
		end
		return textureShader[tid], textureName[tid], textureCache[tid]
	end
	return false
end
function processWPSkin(client, new)
	local tid = wpSkin[client]
	if tid then
		for i = #textureUsed[tid], 1, -1 do
			if textureUsed[tid][i] == client then
				table.remove(textureUsed[tid], i)
			end
		end
		if isElement(wpObjects[client]) and isElement(textureShader[tid]) then
			engineRemoveShaderFromWorldTexture(textureShader[tid], textureName[tid], wpObjects[client])
		end
		if #textureUsed[tid] <= 0 and #textureUsedOnBack[tid] <= 0 then
			textureDeleteTimer[tid] = getTickCount() + 5000
		end
	end
	if new then
		textureDeleteTimer[new] = nil
		if not isElement(textureCache[new]) then
			textureCache[new] = dxCreateTexture(textureList[new])
		end
		if not isElement(textureShader[new]) then
			textureShader[new] = dxCreateShader(changerShader, 0, 0, false, "object")
			dxSetShaderValue(textureShader[new], "gTexture", textureCache[new])
		end
		table.insert(textureUsed[new], client)
		engineApplyShaderToWorldTexture(textureShader[new], textureName[new], wpObjects[client])
	end
	wpSkin[client] = new
end
function clearTextureCache()
	for tid = 1, #textureList do
		deleteFromCache(tid)
	end
end
local isModelsReady = false
function modelsLoaded()
	isModelsReady = true
	shieldModel = sightexports.sModloader:getModelId("police_shield")
	clearTextureCache()
	textureList = {}
	for id, dat in pairs(customWeapons) do
		if customWeapons[id].modelName then
			customWeapons[id].model = sightexports.sModloader:getModelId(dat.modelName)
		end
		if customWeapons[id].skins then
			customWeapons[id].textures = {}
			for item, skin in pairs(customWeapons[id].skins) do
				local found = false
				for tid, tex in pairs(textureList) do
					if tex == "skins/" .. (customWeapons[id].skinFolder or id) .. "/" .. skin .. ".dds" then
						customWeapons[id].textures[item] = tid
						found = true
					end
				end
				if not found then
					local tex = "skins/" .. (customWeapons[id].skinFolder or id) .. "/" .. skin .. ".dds"
					local tid = #textureList + 1
					textureList[tid] = tex
					textureName[tid] = customWeapons[id].textureName
					textureUsed[tid] = {}
					textureUsedOnBack[tid] = {}
					customWeapons[id].textures[item] = tid
				end
			end
		end
	end
	processWPModelInit()
end
function processWPModel(client, item)
	if isModelsReady then
		local wep = wpType[client]
		local newSkin
		if wep then
			if isElement(wpObjects[client]) then
				setElementModel(wpObjects[client], customWeapons[wep].model)
				sightexports.sPattach:detach(wpObjects[client])
			else
				wpObjects[client] = createObject(customWeapons[wep].model, 0, 0, 0)
			end
			sightexports.sPattach:attach(wpObjects[client], client, "weapon")
			if customWeapons[wep].itemId ~= item and customWeapons[wep].textures then
				local tid = customWeapons[wep].textures[item]
				newSkin = tid
			end
		else
			if isElement(wpObjects[client]) then
				destroyElement(wpObjects[client])
			end
			wpObjects[client] = nil
		end
		if wpSkin[client] ~= newSkin then
			processWPSkin(client, newSkin)
		end
	end
end
function processWPModelInit()
	local players = getElementsByType("player")
	for i = 1, #players do
		laserData[players[i]] = getElementData(players[i], "weaponLaserState")
		local new = getElementData(players[i], "customWP")
		wpData[players[i]] = new
		wpType[players[i]] = new and weaponItemIds[new] or false
		processWPModel(players[i], isElementStreamedIn(players[i]) and new)
	end
end
addEventHandler("onClientElementDataChange", getRootElement(), function(data, old, new)
	if data == "weaponLaserState" then
		laserData[source] = new
	elseif data == "customWP" then
		wpData[source] = new
		wpType[source] = new and weaponItemIds[new] or false
		processWPModel(source, isElementStreamedIn(source) and new)
	end
end)
addEventHandler("onClientElementStreamIn", getRootElement(), function()
	if wpData[source] then
		processWPModel(source, wpData[source])
	end
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
	if wpObjects[source] then
		processWPModel(source)
	end
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
	wpData[source] = nil
	wpType[source] = nil
	if wpObjects[source] then
		processWPModel(source)
	end
end)
local scopeShaderSource = " texture sBaseTexture; sampler Samp = sampler_state { Texture = (sBaseTexture); AddressU = MIRROR; AddressV = MIRROR; }; float blur = 0.0025; float aspect = 1; float yp = 0; float td = 0; float rc = 1; float bc = 1; float gc = 1; float4 PixelShaderFunction(float2 uv : TEXCOORD) : COLOR { float4 outputColor; float x = (uv.x-0.5)/aspect; float y = uv.y-(0.5+yp); float d = sqrt(x*x+y*y)/td; if(d > 1) { outputColor = tex2D(Samp, uv); for (float i = 1; i < 3; i++) { outputColor += tex2D(Samp, float2(uv.x, uv.y + (i * blur))); outputColor += tex2D(Samp, float2(uv.x, uv.y - (i * blur))); outputColor += tex2D(Samp, float2(uv.x - (i * blur), uv.y)); outputColor += tex2D(Samp, float2(uv.x + (i * blur), uv.y)); } outputColor /= 9; } else { uv.x -= 0.5; uv.y -= (0.5+yp); uv.xy *= d*0.2+0.8; uv.x += 0.5; uv.y += (0.5+yp); outputColor = tex2D(Samp, uv); outputColor.r *= rc; outputColor.g *= gc; outputColor.b *= bc; outputColor.rgb *= (1-d)*0.7+0.3; } return outputColor; } technique movie { pass P1 { PixelShader = compile ps_2_a PixelShaderFunction(); } } technique fallback { pass P0 { } } "
	local scopeScreenSource = false
	local scopeShader = false
	local currentScope = false
	local hearthSound = false
	local breathLoopSound = false
	local breathInOutSound = false
	local outOfBreath = 0
	local breathValue = 1
	local breathMul = 1
	local breathIn = false
	local breathOut = 0
	function deleteScope()
		if currentScope then
			removeEventHandler("onClientRender", getRootElement(), renderScope)
			removeEventHandler("onClientPreRender", getRootElement(), preRenderScope)
		end
		currentScope = false
		if isElement(scopeScreenSource) then
			destroyElement(scopeScreenSource)
		end
		scopeScreenSource = false
		if isElement(scopeShader) then
			destroyElement(scopeShader)
		end
		scopeShader = false
		if isElement(hearthSound) then
			destroyElement(hearthSound)
		end
		hearthSound = false
		if isElement(breathLoopSound) then
			destroyElement(breathLoopSound)
		end
		breathLoopSound = false
		if isElement(breathInOutSound) then
			destroyElement(breathInOutSound)
		end
		breathInOutSound = false
	end
	function createScope(curr)
		deleteScope()
		currentScope = curr
		scopeScreenSource = dxCreateScreenSource(screenX, screenY)
		scopeShader = dxCreateShader(scopeShaderSource)
		if curr == "dragunov" then
			dxSetShaderValue(scopeShader, "td", 0.315)
			dxSetShaderValue(scopeShader, "rc", 0.7)
			dxSetShaderValue(scopeShader, "gc", 1.1)
			dxSetShaderValue(scopeShader, "bc", 0.7)
		elseif curr == "m110" then
			dxSetShaderValue(scopeShader, "td", 0.3)
			dxSetShaderValue(scopeShader, "rc", 0.6)
			dxSetShaderValue(scopeShader, "gc", 0.85)
			dxSetShaderValue(scopeShader, "bc", 1.1)
		elseif curr == "m110_tan" then
			dxSetShaderValue(scopeShader, "td", 0.3)
			dxSetShaderValue(scopeShader, "rc", 0.85)
			dxSetShaderValue(scopeShader, "gc", 1.1)
			dxSetShaderValue(scopeShader, "bc", 0.6)
		elseif curr == "m700" then
			dxSetShaderValue(scopeShader, "td", 0.32999999999999996)
			dxSetShaderValue(scopeShader, "rc", 1)
			dxSetShaderValue(scopeShader, "gc", 0.95)
			dxSetShaderValue(scopeShader, "bc", 0.8)
		end
		dxSetShaderValue(scopeShader, "sBaseTexture", scopeScreenSource)
		dxSetShaderValue(scopeShader, "aspect", screenY / screenX)
		hearthSound = playSound("files/beat.mp3", true)
		breathLoopSound = playSound("files/breath3.mp3", true)
		breathInOutSound = false
		setSoundVolume(hearthSound, 0)
		setSoundVolume(breathLoopSound, 0)
		addEventHandler("onClientRender", getRootElement(), renderScope)
		addEventHandler("onClientPreRender", getRootElement(), preRenderScope)
		sightexports.sGui:showInfobox("info", "A lélegzet visszatartásához tartsd nyomva az E gombot.")
	end
	function preRenderScope(delta)
		if isPedDoingGangDriveby(localPlayer) or getPedControlState("aim_weapon") then
			local now = getTickCount()
			local skill = math.min(1, getPedStat(localPlayer, 79) / 999)
			local breathGlobalMul = 1 - 0.75 * skill
			local breathHoldTime = 0.175 * (1 - 0.5 * skill)
			local x1 = math.cos((now - delta) % 3000 / 3000 * math.pi * 2)
			local x2 = math.cos(now % 3000 / 3000 * math.pi * 2)
			local eKey = getKeyState("e")
			if eKey and not breathIn then
				if breathValue <= 1 and outOfBreath < 1 and 340 < now - breathOut then
					breathIn = true
					if isElement(breathInOutSound) then
						destroyElement(breathInOutSound)
					end
					breathInOutSound = playSound("files/breath1.mp3")
				end
			elseif not eKey and breathIn then
				breathIn = false
				breathOut = now
				if isElement(breathInOutSound) then
					destroyElement(breathInOutSound)
				end
				breathInOutSound = playSound("files/breath2.mp3")
			end
			if 1 < outOfBreath then
				breathIn = false
				breathValue = breathValue + 2.5 * delta / 1000
				if 3 < breathValue then
					breathValue = 3
					outOfBreath = 0
				end
			elseif 1 < breathValue then
				breathValue = breathValue - 0.25 * delta / 1000
				if breathValue < 1 then
					breathValue = 1
				end
			elseif breathIn then
				breathValue = breathValue - 1 * delta / 1000
				if breathValue < 1 then
					outOfBreath = outOfBreath + (1 - breathValue) * breathHoldTime * delta / 1000
				end
			elseif breathValue < 0 then
				breathValue = 0
			elseif breathValue < 1 then
				breathValue = breathValue + 3 * delta / 1000
				if 1 < breathValue then
					breathValue = 1
				end
			elseif 1 <= breathValue and 0 < outOfBreath then
				outOfBreath = outOfBreath - 0.25 * delta / 1000
				if outOfBreath < 0 then
					outOfBreath = 0
				end
			end
			setSoundSpeed(hearthSound, math.max(math.max((math.min(2, breathValue) - 1) * 0.35 + 1, 1), outOfBreath * 1.35))
			if 1 < breathValue then
				breathMul = math.min(2, breathValue)
				setSoundVolume(breathLoopSound, breathMul - 1)
				setSoundVolume(hearthSound, breathMul - 1)
			else
				setSoundVolume(breathLoopSound, 0)
				if breathValue < 1 then
					breathMul = getEasingValue(math.max(0, breathValue), "InOutQuad")
				else
					breathMul = 1
				end
				setSoundVolume(hearthSound, math.max(1 - breathMul, 1 < outOfBreath and 1 or 0))
			end
			breathMul = breathMul * breathGlobalMul
			setPedCameraRotation(localPlayer, -getPedCameraRotation(localPlayer) + (x2 - x1) * 0.75 * breathMul)
		else
			if breathIn then
				breathIn = false
				breathOut = now
				if isElement(breathInOutSound) then
					destroyElement(breathInOutSound)
				end
				breathInOutSound = playSound("files/breath2.mp3")
			end
			if 1 < outOfBreath then
				breathIn = false
				breathValue = breathValue + 2.5 * delta / 1000
				if 3 < breathValue then
					breathValue = 3
					outOfBreath = 0
				end
			elseif 1 < breathValue then
				breathValue = breathValue - 0.25 * delta / 1000
				if breathValue < 1 then
					breathValue = 1
				end
			elseif breathIn then
				breathValue = breathValue - 1 * delta / 1000
				if breathValue < 1 then
					outOfBreath = outOfBreath + (1 - breathValue) * breathHoldTime * delta / 1000
				end
			elseif breathValue < 0 then
				breathValue = 0
			elseif breathValue < 1 then
				breathValue = breathValue + 3 * delta / 1000
				if 1 < breathValue then
					breathValue = 1
				end
			elseif 1 <= breathValue and 0 < outOfBreath then
				outOfBreath = outOfBreath - 0.25 * delta / 1000
				if outOfBreath < 0 then
					outOfBreath = 0
				end
			end
			setSoundVolume(hearthSound, 0)
			setSoundVolume(breathLoopSound, 0)
		end
	end
	function renderScope()
		if isPedDoingGangDriveby(localPlayer) or getPedControlState("aim_weapon") then
			local yp = math.sin(getTickCount() % 3000 / 3000 * math.pi * 2) * 0.0125 * breathMul
			dxSetShaderValue(scopeShader, "yp", yp)
			dxUpdateScreenSource(scopeScreenSource)
			dxDrawImage(0, 0, screenX, screenY, scopeShader)
			if currentScope == "dragunov" then
				sightlangStaticImageUsed[4] = true
				if sightlangStaticImageToc[4] then
					processsightlangStaticImage[4]()
				end
				dxDrawImage(screenX / 2 - screenY * 1.1335978835978835 / 2 / 0.95, screenY / 2 - screenY / 0.95 / 2 + screenY * yp, screenY * 1.1335978835978835 / 0.95, screenY / 0.95, sightlangStaticImage[4])
			elseif currentScope == "m110" then
				sightlangStaticImageUsed[5] = true
				if sightlangStaticImageToc[5] then
					processsightlangStaticImage[5]()
				end
				dxDrawImage(screenX / 2 - screenY * 0.9907407407407407 / 2 / 0.95, screenY / 2 - screenY / 0.95 / 2 + screenY * yp, screenY * 0.9907407407407407 / 0.95, screenY / 0.95, sightlangStaticImage[5])
			elseif currentScope == "m110_tan" then
				sightlangStaticImageUsed[6] = true
				if sightlangStaticImageToc[6] then
					processsightlangStaticImage[6]()
				end
				dxDrawImage(screenX / 2 - screenY * 0.9907407407407407 / 2 / 0.95, screenY / 2 - screenY / 0.95 / 2 + screenY * yp, screenY * 0.9907407407407407 / 0.95, screenY / 0.95, sightlangStaticImage[6])
			elseif currentScope == "m700" then
				sightlangStaticImageUsed[7] = true
				if sightlangStaticImageToc[7] then
					processsightlangStaticImage[7]()
				end
				dxDrawImage(screenX / 2 - screenY * 0.7876984126984127 / 2 / 0.95, screenY / 2 - screenY / 0.95 / 2 + screenY * yp, screenY * 0.7876984126984127 / 0.95, screenY / 0.95, sightlangStaticImage[7])
			end
			if currentWeaponPic then
				local w = weaponPicDimensions[currentWeaponPic]
				local fh = dxGetFontHeight(dataFontScale, dataFont)
				drawWeaponPic(screenX - w - 16, screenY - 64 - 8 - fh - 16, w)
			end
		end
	end
	local receipt = false
	function deleteWeaponReceipt()
		if receipt then
			sightexports.sGui:deleteGuiElement(receipt)
		end
		receipt = false
	end
	function createWeaponReceipt(data)
		deleteWeaponReceipt()
		if data then
			local w = 300
			local wpPrev = weaponItemPics[data.item]
			local weaponName = tostring(sightexports.sItems:getItemName(data.item))
			local prevH = 0
			local prevW = 0
			if weaponPicOriginalDimensions[wpPrev] then
				prevW = math.min(256, weaponPicOriginalDimensions[wpPrev][1])
				prevH = prevW / weaponPicOriginalDimensions[wpPrev][1] * weaponPicOriginalDimensions[wpPrev][2]
			end
			local h = 290 + prevH + 10
			receipt = sightexports.sGui:createGuiElement("image", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
			sightexports.sGui:setImageDDS(receipt, ":sWeapons/files/paper.dds")
			local y = 10
			local label = sightexports.sGui:createGuiElement("label", 0, y, w, 20, receipt)
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
			sightexports.sGui:setLabelColor(label, "#282828")
			sightexports.sGui:setLabelText(label, "FEGYVERVÁSÁRLÁSI BIZONYLAT")
			y = y + 20
			local label = sightexports.sGui:createGuiElement("label", 0, y, w, 20, receipt)
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
			sightexports.sGui:setLabelColor(label, "#282828")
			sightexports.sGui:setLabelText(label, "---------------------------------")
			y = y + 20 + 10
			local label = sightexports.sGui:createGuiElement("label", 10, y, w - 20, 20, receipt)
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
			sightexports.sGui:setLabelColor(label, "#282828")
			sightexports.sGui:setLabelText(label, "Fegyver: " .. weaponName)
			y = y + 20 + 5
			local label = sightexports.sGui:createGuiElement("label", 10, y, 0, 20, receipt)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
			sightexports.sGui:setLabelColor(label, "#282828")
			sightexports.sGui:setLabelText(label, "Sorozatszám: " .. tostring(data.serial))
			y = y + 20 + 5
			local label = sightexports.sGui:createGuiElement("label", 10, y, w - 20, 20, receipt)
			sightexports.sGui:setLabelClip(label, true)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
			sightexports.sGui:setLabelColor(label, "#282828")
			sightexports.sGui:setLabelText(label, "Vevő: " .. tostring(data.buyer))
			y = y + 20 + 5
			local label = sightexports.sGui:createGuiElement("label", 10, y, 0, 20, receipt)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
			sightexports.sGui:setLabelColor(label, "#282828")
			sightexports.sGui:setLabelText(label, "Vevő azonosító: " .. tostring(data.acc) .. " (AccID)")
			y = y + 20 + 5
			local label = sightexports.sGui:createGuiElement("label", 10, y, 0, 20, receipt)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
			sightexports.sGui:setLabelColor(label, "#282828")
			if tonumber(data.price) then
				sightexports.sGui:setLabelText(label, "Vételár: " .. sightexports.sGui:thousandsStepper(tonumber(data.price)) .. " PP")
			else
				sightexports.sGui:setLabelText(label, "Indok: " .. data.price)
			end
			y = y + 20 + 10
			local label = sightexports.sGui:createGuiElement("label", 0, y, w, 20, receipt)
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
			sightexports.sGui:setLabelColor(label, "#282828")
			sightexports.sGui:setLabelText(label, "---------------------------------")
			y = y + 20 + 10
			local time = getRealTime(tonumber(data.ts) or 0)
			local label = sightexports.sGui:createGuiElement("label", 0, y, w, 20, receipt)
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
			sightexports.sGui:setLabelColor(label, "#282828")
			sightexports.sGui:setLabelText(label, string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday))
			y = y + 20
			local label = sightexports.sGui:createGuiElement("label", 0, y, w, 20, receipt)
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
			sightexports.sGui:setLabelColor(label, "#282828")
			sightexports.sGui:setLabelText(label, string.format("%02d:%02d:%02d", time.hour, time.minute, time.second))
			y = y + 20
			local label = sightexports.sGui:createGuiElement("label", 0, y, w, 20, receipt)
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			sightexports.sGui:setLabelFont(label, "11/W95FA.otf")
			sightexports.sGui:setLabelColor(label, "#282828")
			sightexports.sGui:setLabelText(label, "---------------------------------")
			y = y + 20 + 10
			if weaponPicOriginalDimensions[wpPrev] then
				local img = sightexports.sGui:createGuiElement("image", w / 2 - prevW / 2, y, prevW, prevH, receipt)
				sightexports.sGui:setImageDDS(img, ":sWeapons/hud/" .. wpPrev .. ".dds")
			end
		end
	end
	local physgunTargets = {}
	local physgunSound = {}
	local physgunSoundEx = {}
	triggerServerEvent("requestPhysgunTargets", localPlayer)
	addEvent("gotPhysgunTargets", true)
	addEventHandler("gotPhysgunTargets", getRootElement(), function(dat)
		for k, v in pairs(dat) do
			processPhysgunTarget(k, v)
		end
	end)
	local lastSelfVectorX, lastSelfVectorY, lastSelfVectorZ = 0, 0, 0
	local lastSelfTargetX, lastSelfTargetY, lastSelfTargetZ = 0, 0, 0
	function processPhysgunTarget(source, dat)
		if isElement(physgunSound[source]) then
			destroyElement(physgunSound[source])
		end
		physgunSound[source] = nil
		if isElement(physgunSoundEx[source]) then
			destroyElement(physgunSoundEx[source])
		end
		physgunSoundEx[source] = nil
		physgunTargets[source] = dat
		if dat then
			physgunSound[source] = playSound3D("files/beam.wav", 0, 0, 0, true)
			attachElements(physgunSound[source], source)
			setSoundMaxDistance(physgunSound[source], 300)
			physgunSoundEx[source] = playSound3D("files/beam.wav", 0, 0, 0, true)
			setSoundMaxDistance(physgunSoundEx[source], 300)
			local sound = playSound3D("files/gravshot.wav", 0, 0, 0)
			attachElements(sound, source)
			setSoundMaxDistance(sound, 300)
			sightlangCondHandl0(true)
		else
			local sound = playSound3D("files/gravshot2.wav", 0, 0, 0)
			attachElements(sound, source)
			setSoundMaxDistance(sound, 300)
		end
	end
	addEvent("setPhysgunTarget", true)
	addEventHandler("setPhysgunTarget", getRootElement(), function(dat, was, x, y, z)
		if source ~= localPlayer then
			processPhysgunTarget(source, dat)
			if isElement(was) then
				setElementVelocity(was, x, y, z)
			end
		end
	end)
	addEvent("physgunPosSync", true)
	addEventHandler("physgunPosSync", getRootElement(), function(target, x, y, z)
		if source ~= localPlayer and physgunTargets[source] and physgunTargets[source][1] == target then
			physgunTargets[source][3] = x
			physgunTargets[source][4] = y
			physgunTargets[source][5] = z
		end
	end)
	addEvent("physgunDistSync", true)
	addEventHandler("physgunDistSync", getRootElement(), function(target, d)
		if source ~= localPlayer and physgunTargets[source] and physgunTargets[source][1] == target then
			physgunTargets[source][2] = d
		end
	end)
	function getPhysgunVector(client)
		local x, y, z = getElementPosition(client)
		if wpObjects[client] and isElementOnScreen(client) then
			local matrix = getElementMatrix(wpObjects[client])
			if matrix then
				x, y, z = getPositionFromMatrixOffset(matrix, 0.5882, -0.026, 0.1725)
			end
		end
		local vx, vy, vz = getPedTargetEnd(client)
		vx = vx - x
		vy = vy - y
		vz = vz - z
		local hit, hx, hy, hz = processLineOfSight(x, y, z, x + vx * 10, y + vy * 10, z + vz * 10, true, true, true, true, true, true, false, true, wpObjects[client])
		if hit then
			vx = hx - x
			vy = hy - y
			vz = hz - z
		end
		local d = math.sqrt(vx * vx + vy * vy + vz * vz)
		vx = vx / d
		vy = vy / d
		vz = vz / d
		return vx, vy, vz, x, y, z, d
	end
	local lastSelfSync = 100
	local lastVector = 0
	function preRenderPhysgun(delta)
		lastSelfSync = lastSelfSync - delta
		if physgunTargets[localPlayer] and not getKeyState("mouse2") then
			processPhysgunTarget(localPlayer)
			triggerServerEvent("setPhysgunTarget", localPlayer, nil, nil, lastSelfVectorX, lastSelfVectorY, lastSelfVectorZ)
		end
		for client, dat in pairs(physgunTargets) do
			local target = dat[1]
			if not isElement(client) then
				physgunTargets[client] = nil
				if isElement(physgunSound[client]) then
					destroyElement(physgunSound[client])
				end
				physgunSound[client] = nil
				if isElement(physgunSoundEx[client]) then
					destroyElement(physgunSoundEx[client])
				end
				physgunSoundEx[client] = nil
			elseif isElement(target) and (isElementStreamedIn(client) or isElementStreamedIn(target)) then
				local ex, ey, ez = getElementPosition(target)
				local vx, vy, vz, x, y, z, d = getPhysgunVector(client)
				if client == localPlayer then
					local tx, ty, tz = x + vx * dat[2], y + vy * dat[2], z + vz * dat[2]
					lastVector = lastVector + delta
					if 100 < lastVector then
						if lastSelfTargetX then
							lastSelfVectorX = (tx - lastSelfTargetX) / (lastVector / 1000)
							lastSelfVectorY = (ty - lastSelfTargetY) / (lastVector / 1000)
							lastSelfVectorZ = (tz - lastSelfTargetZ) / (lastVector / 1000)
						end
						lastSelfTargetX, lastSelfTargetY, lastSelfTargetZ = tx, ty, tz
					end
					if lastSelfSync < 0 then
						lastSelfSync = 200
						triggerServerEvent("physgunPosSync", localPlayer, tx, ty, tz)
					end
					dat[3], dat[4], dat[5] = tx, ty, tz
				end
				if dat[3] then
					local mvx, mvy, mvz = 0, 0, 0
					local tx, ty, tz = dat[3], dat[4], dat[5]
					if ex < tx then
						mvx = delta / 1000 * math.max(10, math.abs(ex - tx) * 10)
						if tx < ex + mvx then
							mvx = tx - ex
						end
					end
					if ex > tx then
						mvx = -delta / 1000 * math.max(10, math.abs(ex - tx) * 10)
						if tx > ex + mvx then
							mvx = tx - ex
						end
					end
					if ey < ty then
						mvy = delta / 1000 * math.max(10, math.abs(ey - ty) * 10)
						if ty < ey + mvy then
							mvy = ty - ey
						end
					end
					if ey > ty then
						mvy = -delta / 1000 * math.max(10, math.abs(ey - ty) * 10)
						if ty > ey + mvy then
							mvy = ty - ey
						end
					end
					if ez < tz then
						mvz = delta / 1000 * math.max(10, math.abs(ez - tz) * 10)
						if tz < ez + mvz then
							mvz = tz - ez
						end
					end
					if ez > tz then
						mvz = -delta / 1000 * math.max(10, math.abs(ez - tz) * 10)
						if tz > ez + mvz then
							mvz = tz - ez
						end
					end
					setElementPosition(target, ex + mvx, ey + mvy, ez + mvz)
					setElementPosition(physgunSoundEx[client], ex + mvx, ey + mvy, ez + mvz)
				end
				local d = getDistanceBetweenPoints3D(x, y, z, ex, ey, ez)
				ex = ex - x
				ey = ey - y
				ez = ez - z
				local lx, ly, lz = x, y, z
				vx = vx * d
				vy = vy * d
				vz = vz * d
				local c = tocolor(255, 255, 255, 175 + 85 * math.random())
				for i = 0, 1, 0.05 do
					local tx1, ty1, tz1 = x + vx * i, y + vy * i, z + vz * i
					local tx2, ty2, tz2 = x + ex * i, y + ey * i, z + ez * i
					local tx = tx1 * (1 - i) + tx2 * i
					local ty = ty1 * (1 - i) + ty2 * i
					local tz = tz1 * (1 - i) + tz2 * i
					sightlangStaticImageUsed[8] = true
					if sightlangStaticImageToc[8] then
						processsightlangStaticImage[8]()
					end
					dxDrawMaterialLine3D(lx, ly, lz, tx, ty, tz, true, sightlangStaticImage[8], 0.2, c)
					lx, ly, lz = tx, ty, tz
				end
				sightlangStaticImageUsed[8] = true
				if sightlangStaticImageToc[8] then
					processsightlangStaticImage[8]()
				end
				dxDrawMaterialLine3D(lx, ly, lz, x + ex, y + ey, z + ez, true, sightlangStaticImage[8], 0.2, c)
			end
		end
		for k in pairs(physgunTargets) do
			return
		end
		sightlangCondHandl0(false)
	end
	function clickPhysgun(btn, state)
		if btn == "mouse1" then
			if state then
				if physgunTargets[localPlayer] then
					processPhysgunTarget(localPlayer)
					triggerServerEvent("setPhysgunTarget", localPlayer, nil, nil, lastSelfVectorX, lastSelfVectorY, lastSelfVectorZ)
				else
					local el = getPedTarget(localPlayer)
					local vx, vy, vz, x, y, z, d = getPhysgunVector(localPlayer)
					if not el then
						local cx, cy, cz = getCameraMatrix()
						vx = x + vx * 10000
						vy = y + vy * 10000
						vz = z + vz * 10000
						local hit, hx, hy, hz, he = processLineOfSight(cx, cy, cz, vx, vy, vz, true, true, true, true, true, true, false, true, wpObjects[client] or client)
						if hit and isElement(he) then
							el = he
							d = getDistanceBetweenPoints3D(x, y, z, hx, hy, hz)
						end
					end
					if isElement(el) and (getElementType(el) == "player" or getElementType(el) == "vehicle") then
						lastSelfVectorX, lastSelfVectorY, lastSelfVectorZ = 0, 0, 0
						lastSelfTargetX, lastSelfTargetY, lastSelfTargetZ = false, false, false
						lastVector = 0
						processPhysgunTarget(localPlayer, {el, d})
						triggerServerEvent("setPhysgunTarget", localPlayer, el, d)
					end
				end
			end
		elseif btn == "mouse_wheel_up" then
			if physgunTargets[localPlayer] then
				physgunTargets[localPlayer][2] = math.min(300, physgunTargets[localPlayer][2] + 1)
				triggerServerEvent("physgunDistSync", localPlayer, physgunTargets[localPlayer][2])
			end
		elseif btn == "mouse_wheel_down" and physgunTargets[localPlayer] then
			physgunTargets[localPlayer][2] = math.max(1, physgunTargets[localPlayer][2] - 1)
			triggerServerEvent("physgunDistSync", localPlayer, physgunTargets[localPlayer][2])
		end
	end
	function setPhysgunMode(state)
		if getElementData(localPlayer, "acc.adminLevel") < 7 then
			return
		end
		sightexports.sControls:toggleControl("fire", not state, "physgun")
		sightlangCondHandl1(state)
	end
	