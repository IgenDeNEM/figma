local sightexports = {sItems = false, sGui = false}
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
sightlangStaticImageToc[4] = true
sightlangStaticImageToc[5] = true
sightlangStaticImageToc[6] = true
sightlangStaticImageToc[7] = true
sightlangStaticImageToc[8] = true
sightlangStaticImageToc[9] = true
sightlangStaticImageToc[10] = true
sightlangStaticImageToc[11] = true
sightlangStaticImageToc[12] = true
sightlangStaticImageToc[13] = true
sightlangStaticImageToc[14] = true
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
	if sightlangStaticImageUsed[9] then
		sightlangStaticImageUsed[9] = false
		sightlangStaticImageDel[9] = false
	elseif sightlangStaticImage[9] then
		if sightlangStaticImageDel[9] then
			if now >= sightlangStaticImageDel[9] then
				if isElement(sightlangStaticImage[9]) then
					destroyElement(sightlangStaticImage[9])
				end
				sightlangStaticImage[9] = nil
				sightlangStaticImageDel[9] = false
				sightlangStaticImageToc[9] = true
				return
			end
		else
			sightlangStaticImageDel[9] = now + 5000
		end
	else
		sightlangStaticImageToc[9] = true
	end
	if sightlangStaticImageUsed[10] then
		sightlangStaticImageUsed[10] = false
		sightlangStaticImageDel[10] = false
	elseif sightlangStaticImage[10] then
		if sightlangStaticImageDel[10] then
			if now >= sightlangStaticImageDel[10] then
				if isElement(sightlangStaticImage[10]) then
					destroyElement(sightlangStaticImage[10])
				end
				sightlangStaticImage[10] = nil
				sightlangStaticImageDel[10] = false
				sightlangStaticImageToc[10] = true
				return
			end
		else
			sightlangStaticImageDel[10] = now + 5000
		end
	else
		sightlangStaticImageToc[10] = true
	end
	if sightlangStaticImageUsed[11] then
		sightlangStaticImageUsed[11] = false
		sightlangStaticImageDel[11] = false
	elseif sightlangStaticImage[11] then
		if sightlangStaticImageDel[11] then
			if now >= sightlangStaticImageDel[11] then
				if isElement(sightlangStaticImage[11]) then
					destroyElement(sightlangStaticImage[11])
				end
				sightlangStaticImage[11] = nil
				sightlangStaticImageDel[11] = false
				sightlangStaticImageToc[11] = true
				return
			end
		else
			sightlangStaticImageDel[11] = now + 5000
		end
	else
		sightlangStaticImageToc[11] = true
	end
	if sightlangStaticImageUsed[12] then
		sightlangStaticImageUsed[12] = false
		sightlangStaticImageDel[12] = false
	elseif sightlangStaticImage[12] then
		if sightlangStaticImageDel[12] then
			if now >= sightlangStaticImageDel[12] then
				if isElement(sightlangStaticImage[12]) then
					destroyElement(sightlangStaticImage[12])
				end
				sightlangStaticImage[12] = nil
				sightlangStaticImageDel[12] = false
				sightlangStaticImageToc[12] = true
				return
			end
		else
			sightlangStaticImageDel[12] = now + 5000
		end
	else
		sightlangStaticImageToc[12] = true
	end
	if sightlangStaticImageUsed[13] then
		sightlangStaticImageUsed[13] = false
		sightlangStaticImageDel[13] = false
	elseif sightlangStaticImage[13] then
		if sightlangStaticImageDel[13] then
			if now >= sightlangStaticImageDel[13] then
				if isElement(sightlangStaticImage[13]) then
					destroyElement(sightlangStaticImage[13])
				end
				sightlangStaticImage[13] = nil
				sightlangStaticImageDel[13] = false
				sightlangStaticImageToc[13] = true
				return
			end
		else
			sightlangStaticImageDel[13] = now + 5000
		end
	else
		sightlangStaticImageToc[13] = true
	end
	if sightlangStaticImageUsed[14] then
		sightlangStaticImageUsed[14] = false
		sightlangStaticImageDel[14] = false
	elseif sightlangStaticImage[14] then
		if sightlangStaticImageDel[14] then
			if now >= sightlangStaticImageDel[14] then
				if isElement(sightlangStaticImage[14]) then
					destroyElement(sightlangStaticImage[14])
				end
				sightlangStaticImage[14] = nil
				sightlangStaticImageDel[14] = false
				sightlangStaticImageToc[14] = true
				return
			end
		else
			sightlangStaticImageDel[14] = now + 5000
		end
	else
		sightlangStaticImageToc[14] = true
	end
	if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] and sightlangStaticImageToc[9] and sightlangStaticImageToc[10] and sightlangStaticImageToc[11] and sightlangStaticImageToc[12] and sightlangStaticImageToc[13] and sightlangStaticImageToc[14] then
		sightlangStatImgHand = false
		removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
	end
end
processsightlangStaticImage[0] = function()
	if not isElement(sightlangStaticImage[0]) then
		sightlangStaticImageToc[0] = false
		sightlangStaticImage[0] = dxCreateTexture("files/shadow_body.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/shadow_head.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[2] = function()
	if not isElement(sightlangStaticImage[2]) then
		sightlangStaticImageToc[2] = false
		sightlangStaticImage[2] = dxCreateTexture("files/head2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[3] = function()
	if not isElement(sightlangStaticImage[3]) then
		sightlangStaticImageToc[3] = false
		sightlangStaticImage[3] = dxCreateTexture("files/body.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[4] = function()
	if not isElement(sightlangStaticImage[4]) then
		sightlangStaticImageToc[4] = false
		sightlangStaticImage[4] = dxCreateTexture("files/eyebg.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[5] = function()
	if not isElement(sightlangStaticImage[5]) then
		sightlangStaticImageToc[5] = false
		sightlangStaticImage[5] = dxCreateTexture("files/eye.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[6] = function()
	if not isElement(sightlangStaticImage[6]) then
		sightlangStaticImageToc[6] = false
		sightlangStaticImage[6] = dxCreateTexture("files/eyeshut.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[7] = function()
	if not isElement(sightlangStaticImage[7]) then
		sightlangStaticImageToc[7] = false
		sightlangStaticImage[7] = dxCreateTexture("files/head.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[8] = function()
	if not isElement(sightlangStaticImage[8]) then
		sightlangStaticImageToc[8] = false
		sightlangStaticImage[8] = dxCreateTexture("files/glass.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[9] = function()
	if not isElement(sightlangStaticImage[9]) then
		sightlangStaticImageToc[9] = false
		sightlangStaticImage[9] = dxCreateTexture("files/mouth2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[10] = function()
	if not isElement(sightlangStaticImage[10]) then
		sightlangStaticImageToc[10] = false
		sightlangStaticImage[10] = dxCreateTexture("files/mouth.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[11] = function()
	if not isElement(sightlangStaticImage[11]) then
		sightlangStaticImageToc[11] = false
		sightlangStaticImage[11] = dxCreateTexture("files/bg.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[12] = function()
	if not isElement(sightlangStaticImage[12]) then
		sightlangStaticImageToc[12] = false
		sightlangStaticImage[12] = dxCreateTexture("files/itemHover.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[13] = function()
	if not isElement(sightlangStaticImage[13]) then
		sightlangStaticImageToc[13] = false
		sightlangStaticImage[13] = dxCreateTexture("files/ibg.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[14] = function()
	if not isElement(sightlangStaticImage[14]) then
		sightlangStaticImageToc[14] = false
		sightlangStaticImage[14] = dxCreateTexture("files/win.dds", "argb", true)
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
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
	if not sightlangWaiterState0 then
		local res0 = getResourceFromName("sItems")
		if res0 and getResourceState(res0) == "running" then
			loadedItems()
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
local font = false
local fontScale = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		font = sightexports.sGui:getFont("17/BebasNeueRegular.otf")
		fontScale = sightexports.sGui:getFontScale("17/BebasNeueRegular.otf")
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
function teaDecodeBinary(data, key)
	return decodeString(teaDecode(data, key))
end
function teaEncodeBinary(data, key)
	return teaEncode(encodeString(data), key)
end
local santaNames = {}
function loadedItems()
	for item in pairs(santaData) do
		santaNames[item] = sightexports.sItems:getItemName(item)
	end
	santaNames[418] = sightexports.sItems:getItemName(418)
end
local screenX, screenY = guiGetScreenSize()
local minigameStarted = false
local snow = {}
local words = {}
local lastWord = 0
local lastHoho = getTickCount()
local hoCount = 0
local lastSnow = 0
local itemList = {}
local itemEye = false
local targetAlpha = 0
local spinSpeed = 0
local targetSpinSpeed = false
local spinAcceleration = false
local spinDeceleration = false
local spinStop = false
local spinMin = 75
local spinMin2 = 12.5
local winItem = false
local winItemId = false
local hohoTime = 2500
local santaSleeping = 0
local fadeInSpeed = 3
local overallAlpha = 0
local overallTime = 0
local rotateEnded = false
local musicStart = false
local music = false
local music2 = false
local lastDistance = 0
local lastDistanceWay = false
function spawnWord(w, x, y)
	table.insert(words, {
		w,
		x,
		y,
		1
	})
	lastWord = getTickCount()
end
function createSnowflake(y, s)
	local a = math.random(105, 175)
	table.insert(snow, {
		math.random(4),
		screenX / 2 + math.random(-400, 400),
		y,
		s,
		math.random(360),
		a,
		math.random(100, 250) / 10,
		math.random(10) == 1,
		math.random(2) == 1
	})
end
function tryToStartSantaOpening(dbID)
	if not minigameStarted then
		triggerServerEvent("tryToStartSantaOpening", localPlayer, dbID)
	end
end
addEvent("startSantaOpening", true)
addEventHandler("startSantaOpening", getRootElement(), function(itemId, rnd1, rnd2, rnd3, rnd4, rnd5)
	if not minigameStarted then
		addEventHandler("onClientPreRender", getRootElement(), preRenderSantaOpen)
		addEventHandler("onClientRender", getRootElement(), renderSantaOpen)
		minigameStarted = true
	end
	snow = {}
	words = {}
	lastWord = 0
	lastHoho = getTickCount()
	hoCount = 0
	hohoTime = 2500
	lastSnow = 0
	itemList = {}
	itemEye = false
	targetAlpha = 0
	spinSpeed = 0
	targetSpinSpeed = rnd1
	spinAcceleration = rnd2
	spinDeceleration = rnd3
	spinStop = targetSpinSpeed / spinAcceleration * 1000 + rnd4
	spinMin = rnd5
	spinMin2 = 12.5
	winItem = itemId
	winItemId = false
	santaSleeping = hohoTime * 3
	fadeInSpeed = 3
	overallAlpha = 0
	local d = 384
	overallTime = 1 / fadeInSpeed * 1000 + santaSleeping + spinStop + (targetSpinSpeed - spinMin) / spinDeceleration * 1000 + (d / spinMin * 7 + d / spinMin2) / 8 * 1000
	rotateEnded = false
	musicStart = false
	if isElement(music) then
		destroyElement(music)
	end
	music = false
	if isElement(music2) then
		destroyElement(music2)
	end
	music2 = false
	lastDistance = 0
	lastDistanceWay = false
	for i = 1, 50 do
		createSnowflake(math.random(0, 472), math.random(25, 75))
	end
	local x = 0
	for i = 1, 13 do
		table.insert(itemList, {
			x,
			chooseFakeItem()
		})
		x = x + 64
	end
	itemList[1][3] = true
	playSound("files/snore.mp3")
end)
function preRenderSantaOpen(delta)
	local now = getTickCount()
	local y = 472
	for i = #words, 1, -1 do
		words[i][4] = words[i][4] - 0.5 * delta / 1000
		if words[i][4] <= 0 then
			table.remove(words, i)
		end
	end
	for i = #snow, 1, -1 do
		snow[i][3] = snow[i][3] + snow[i][7] * delta / 1000
		if y < snow[i][3] then
			snow[i][6] = snow[i][6] - 100 * delta / 1000
			if 0 >= snow[i][6] then
				table.remove(snow, i)
			end
		end
	end
	lastSnow = lastSnow - delta
	if lastSnow < 0 then
		lastSnow = math.random(2000, 4000) / 10
		local s = math.random(25, 75)
		createSnowflake(-s, s)
	end
	if overallAlpha < 1 and not rotateEnded then
		overallAlpha = overallAlpha + fadeInSpeed * delta / 1000
		if 1 < overallAlpha then
			overallAlpha = 1
		end
	else
		if santaSleeping <= 500 then
			targetAlpha = math.min(1, 1 - santaSleeping / 500)
		end
		if santaSleeping <= 1750 and not musicStart then
			musicStart = 750
			music = playSound("files/music.mp3")
			music2 = playSound("files/music2.mp3")
			setSoundVolume(music2, 0)
		end
		if musicStart and 0 < musicStart then
			musicStart = musicStart - delta
			if musicStart < 0 then
				musicStart = 0
			end
			setSoundVolume(music, 1 - musicStart / 750)
		end
		if 0 < santaSleeping then
			santaSleeping = santaSleeping - delta
		else
			local md = 384
			local minX = md
			local foundEye = false
			if winItemId then
				local d = itemList[winItemId][1] - md
				if 0 <= d then
					spinSpeed = 0
					for i = 1, #itemList do
						itemList[i][1] = itemList[i][1] - d
					end
					if not rotateEnded then
						rotateEnded = now
					end
				else
					local p = math.min(1, -d / md * 2.25)
					spinSpeed = math.max(spinMin2, spinMin * p)
				end
			elseif spinStop < 0 then
				if spinSpeed > spinMin then
					spinSpeed = spinSpeed - spinDeceleration * delta / 1000
					if spinSpeed < spinMin then
						spinSpeed = spinMin
					end
				end
			else
				if spinSpeed < targetSpinSpeed then
					spinSpeed = spinSpeed + spinAcceleration * delta / 1000
					if spinSpeed > targetSpinSpeed then
						spinSpeed = targetSpinSpeed
					end
				end
				spinStop = spinStop - delta
			end
			for i = #itemList, 1, -1 do
				itemList[i][1] = itemList[i][1] + spinSpeed * delta / 1000
				minX = math.min(itemList[i][1], minX)
				if itemList[i][1] > md * 2 then
					if not winItemId then
						table.remove(itemList, i)
					end
				elseif itemList[i][3] then
					foundEye = true
					itemEye = screenX / 2 - md + itemList[i][1]
				end
			end
			minX = minX - 64
			if 0 < minX then
				if spinSpeed <= spinMin and not winItemId then
					table.insert(itemList, {minX, winItem})
					winItemId = #itemList
				else
					table.insert(itemList, {
						minX,
						chooseFakeItem()
					})
				end
				if not foundEye then
					itemList[#itemList][3] = true
				end
			end
		end
	end
	if rotateEnded then
		local d = now - rotateEnded
		if 10000 < d then
			overallAlpha = overallAlpha - fadeInSpeed * delta / 1000
			if overallAlpha < 0 then
				overallAlpha = 0
				snow = {}
				words = {}
				removeEventHandler("onClientPreRender", getRootElement(), preRenderSantaOpen)
				removeEventHandler("onClientRender", getRootElement(), renderSantaOpen)
				minigameStarted = false
				if isElement(music) then
					destroyElement(music)
				end
				music = false
				if isElement(music2) then
					destroyElement(music2)
				end
				music2 = false
			else
				setSoundVolume(music, 0)
				setSoundVolume(music2, overallAlpha)
			end
		else
			local p = math.min(1, d / 500)
			setSoundVolume(music, 1 - p)
			setSoundVolume(music2, p)
		end
	end
end
function renderSantaOpen()
	local now = getTickCount()
	local p = now % 3600 / 1800
	if 1 < p then
		p = 2 - p
	end
	local cx, cy = getCursorPosition()
	if cx then
		cx = cx * screenX
		cy = cy * screenY
	end
	for i = 1, #snow do
		if not snow[i][8] then
			local p = snow[i][3]
			local sin = math.sin(p / 50)
			local cos = math.cos(p / 25)
			local s = snow[i][4] * (0.9 + 0.1 * math.abs(sin))
			local x = snow[i][2] - s / 2
			if snow[i][9] then
				x = x + sin * s * 0.5
			else
				x = x - sin * s * 0.5
			end
			local y = p - s / 2 - cos * s / 5
			local a = 255 * math.max(0, 1 - math.abs(snow[i][2] - x) / 400) * overallAlpha
			a = math.min(a, snow[i][6])
			dxDrawImage(x, y, s, s, dynamicImage("files/" .. snow[i][1] .. ".dds"), snow[i][5] - sin * 50, 0, 0, tocolor(255, 255, 255, a * overallAlpha))
		end
	end
	local x, y = screenX / 2, 100
	local ix, iy = x - 250, y
	local p2 = getEasingValue(p, "InOutQuad")
	local hx, hy = -4 * p2, p2 * 12
	local hr = p2 * 7.5
	local hc = math.cos(math.rad(hr))
	local hs = math.sin(math.rad(hr))
	local hoDelta = now - lastHoho
	if hoDelta > hohoTime then
		if 3 <= hoCount then
			hoCount = 0
			lastHoho = now
			hohoTime = 10000
		else
			local ex = ix + hx + 290 - 22 * hc + 12 * hs
			local ey = iy + hy + 156 - 22 * hs - 12 * hc
			if 0 < santaSleeping then
				spawnWord("zzz", ex, ey)
				if 2500 < santaSleeping then
					playSound("files/snore.mp3")
				end
				lastHoho = now
			else
				spawnWord("hoho", ex, ey)
				lastHoho = lastHoho + 300
				if hoCount == 0 then
					playSound("files/hohoho.mp3")
				end
				hoCount = hoCount + 1
			end
		end
	end
	sightlangStaticImageUsed[0] = true
	if sightlangStaticImageToc[0] then
		processsightlangStaticImage[0]()
	end
	dxDrawImage(ix + 10 * p2, iy, 500 - 20 * p2, 372, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 200 * overallAlpha))
	sightlangStaticImageUsed[1] = true
	if sightlangStaticImageToc[1] then
		processsightlangStaticImage[1]()
	end
	dxDrawImage(ix + hx, iy + hy, 500, 372, sightlangStaticImage[1], hr, 40, -30, tocolor(255, 255, 255, 200 * overallAlpha))
	sightlangStaticImageUsed[2] = true
	if sightlangStaticImageToc[2] then
		processsightlangStaticImage[2]()
	end
	dxDrawImage(ix + hx, iy + hy, 500, 372, sightlangStaticImage[2], hr, 40, -30, tocolor(255, 255, 255, 255 * overallAlpha))
	sightlangStaticImageUsed[3] = true
	if sightlangStaticImageToc[3] then
		processsightlangStaticImage[3]()
	end
	dxDrawImage(ix + 10 * p2, iy, 500 - 20 * p2, 372, sightlangStaticImage[3], 0, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha))
	if santaSleeping <= 0 then
		sightlangStaticImageUsed[4] = true
		if sightlangStaticImageToc[4] then
			processsightlangStaticImage[4]()
		end
		dxDrawImage(ix + hx, iy + hy, 500, 372, sightlangStaticImage[4], hr, 40, -30, tocolor(255, 255, 255, 255 * overallAlpha))
		local ecos, esin = 0, 0
		if itemEye and 0 < spinSpeed then
			local ex = ix + hx + 290 - 36 * hc + 42 * hs
			local ey = iy + hy + 156 - 36 * hs - 42 * hc
			local r = math.atan2(ey - (iy + 290 - 125 + 199), ex - itemEye) + math.pi
			ecos = math.cos(r) * 3
			esin = math.sin(r) * 3
		elseif cx then
			local ex = ix + hx + 290 - 36 * hc + 42 * hs
			local ey = iy + hy + 156 - 36 * hs - 42 * hc
			local r = math.atan2(ey - cy, ex - cx) + math.pi
			ecos = math.cos(r) * 3
			esin = math.sin(r) * 3
		end
		local ex, ey = ix + hx, iy + hy
		ex = ex + 290 - 51 * hc + 35 * hs
		ey = ey + 156 - 51 * hs - 35 * hc
		ex = ex + ecos
		ey = ey + esin
		ex = ex - 4
		ey = ey - 4
		sightlangStaticImageUsed[5] = true
		if sightlangStaticImageToc[5] then
			processsightlangStaticImage[5]()
		end
		dxDrawImage(ex, ey, 8, 8, sightlangStaticImage[5], hr, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha))
		local ex, ey = ix + hx, iy + hy
		ex = ex + 290 - 22 * hc + 47 * hs
		ey = ey + 156 - 22 * hs - 47 * hc
		ex = ex + ecos * 0.75
		ey = ey + esin * 0.75
		ex = ex - 3
		ey = ey - 3
		sightlangStaticImageUsed[5] = true
		if sightlangStaticImageToc[5] then
			processsightlangStaticImage[5]()
		end
		dxDrawImage(ex, ey, 6, 6, sightlangStaticImage[5], hr, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha))
	end
	if 0.975 < p or 0 < santaSleeping then
		sightlangStaticImageUsed[6] = true
		if sightlangStaticImageToc[6] then
			processsightlangStaticImage[6]()
		end
		dxDrawImage(ix + hx, iy + hy, 500, 372, sightlangStaticImage[6], hr, 40, -30, tocolor(255, 255, 255, 255 * overallAlpha))
	end
	sightlangStaticImageUsed[6] = true
	if sightlangStaticImageToc[6] then
		processsightlangStaticImage[6]()
	end
	sightlangStaticImageUsed[7] = true
	if sightlangStaticImageToc[7] then
		processsightlangStaticImage[7]()
	end
	dxDrawImage(ix + hx, iy + hy, 500, 372, sightlangStaticImage[7], hr, 40, -30, tocolor(255, 255, 255, 255 * overallAlpha))
	sightlangStaticImageUsed[8] = true
	if sightlangStaticImageToc[8] then
		processsightlangStaticImage[8]()
	end
	dxDrawImage(ix + hx, iy + hy, 500, 372, sightlangStaticImage[8], hr, 40, -30, tocolor(255, 255, 255, 255 * overallAlpha))
	if 0 < santaSleeping then
		sightlangStaticImageUsed[9] = true
		if sightlangStaticImageToc[9] then
			processsightlangStaticImage[9]()
		end
		dxDrawImage(ix + hx, iy + hy, 500, 372, sightlangStaticImage[9], hr, 40, -30, tocolor(255, 255, 255, 255 * overallAlpha))
		if 1000 < now - lastWord then
			sightlangStaticImageUsed[10] = true
			if sightlangStaticImageToc[10] then
				processsightlangStaticImage[10]()
			end
			dxDrawImage(ix + hx, iy + hy, 500, 372, sightlangStaticImage[10], hr, 40, -30, tocolor(255, 255, 255, 255 * overallAlpha))
		end
	elseif 200 < now - lastWord then
		sightlangStaticImageUsed[10] = true
		if sightlangStaticImageToc[10] then
			processsightlangStaticImage[10]()
		end
		dxDrawImage(ix + hx, iy + hy, 500, 372, sightlangStaticImage[10], hr, 40, -30, tocolor(255, 255, 255, 255 * overallAlpha))
	end
	sightlangStaticImageUsed[11] = true
	if sightlangStaticImageToc[11] then
		processsightlangStaticImage[11]()
	end
	--ez
	dxDrawImage(x - 350, iy + 290 - 125, 700, 250, sightlangStaticImage[11], 0, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha))
	local md = 384
	x = x - md
	local nearestItemId = false
	local nearestD = md
	local rotateEndedP = 0
	if rotateEnded then
		rotateEndedP = math.min(1, (getTickCount() - rotateEnded) / 750)
	end
	for i = 1, #itemList do
		local x = x + itemList[i][1]
		local d = math.abs(x - screenX / 2) / md
		local a = math.min(255, 355 * (1 - d)) * (1 - rotateEndedP * 0.65) * overallAlpha
		if 0 < a then
			if nearestD > d then
				nearestD = d
				nearestItemId = itemList[i][2]
			end
			local s = 36 - 12 * d
			if itemList[i][2] == 418 and rotateEndedP < 1 then
				local gs = s * 1.8333333333333333
				sightlangStaticImageUsed[12] = true
				if sightlangStaticImageToc[12] then
					processsightlangStaticImage[12]()
				end
				dxDrawImage(x - gs / 2, iy + 290 - 125 + 199 - gs / 2, gs, gs, sightlangStaticImage[12], 0, 0, 0, tocolor(148, 60, 184, a * 0.75 * (1 - rotateEndedP)))
			elseif goldItems[itemList[i][2]] and rotateEndedP < 1 then
				local gs = s * 1.8333333333333333
				sightlangStaticImageUsed[12] = true
				if sightlangStaticImageToc[12] then
					processsightlangStaticImage[12]()
				end
				dxDrawImage(x - gs / 2, iy + 290 - 125 + 199 - gs / 2, gs, gs, sightlangStaticImage[12], 0, 0, 0, tocolor(245, 206, 70, a * 0.75 * (1 - rotateEndedP)))
			end
			dxDrawImage(x - s / 2, iy + 290 - 125 + 199 - s / 2, s, s, ":sItems/files/items/" .. itemList[i][2] - 1 .. ".png", 0, 0, 0, tocolor(255, 255, 255, a))
		end
	end
	sightlangStaticImageUsed[13] = true
	if sightlangStaticImageToc[13] then
		processsightlangStaticImage[13]()
	end
	dxDrawImage(screenX / 2 - 24, iy + 290 - 125 + 199 - 24, 48, 48, sightlangStaticImage[13], 0, 0, 0, tocolor(255, 255, 255, 255 * targetAlpha * (1 - rotateEndedP)))
	if rotateEnded then
		local s = 100 + 300 * rotateEndedP
		if winItem == 418 then
			sightlangStaticImageUsed[14] = true
			if sightlangStaticImageToc[14] then
				processsightlangStaticImage[14]()
			end
			dxDrawImage(screenX / 2 - s / 2, iy + 290 - 125 + 199 - s / 2, s, s, sightlangStaticImage[14], getTickCount() / 40 % 360, 0, 0, tocolor(148, 60, 184, 255 * rotateEndedP * overallAlpha))
		elseif goldItems[winItem] then
			sightlangStaticImageUsed[14] = true
			if sightlangStaticImageToc[14] then
				processsightlangStaticImage[14]()
			end
			dxDrawImage(screenX / 2 - s / 2, iy + 290 - 125 + 199 - s / 2, s, s, sightlangStaticImage[14], getTickCount() / 40 % 360, 0, 0, tocolor(245, 206, 70, 255 * rotateEndedP * overallAlpha))
		else
			sightlangStaticImageUsed[14] = true
			if sightlangStaticImageToc[14] then
				processsightlangStaticImage[14]()
			end
			dxDrawImage(screenX / 2 - s / 2, iy + 290 - 125 + 199 - s / 2, s, s, sightlangStaticImage[14], getTickCount() / 40 % 360, 0, 0, tocolor(255, 255, 255, 255 * rotateEndedP * overallAlpha))
		end
		local s = 36 + 8 * rotateEndedP
		if winItem == 418 then
			local gs = s * 1.8333333333333333
			sightlangStaticImageUsed[12] = true
			if sightlangStaticImageToc[12] then
				processsightlangStaticImage[12]()
			end
			dxDrawImage(screenX / 2 - gs / 2, iy + 290 - 125 + 199 - gs / 2, gs, gs, sightlangStaticImage[12], 0, 0, 0, tocolor(148, 60, 184, 255 * overallAlpha))
		elseif goldItems[winItem] then
			local gs = s * 1.8333333333333333
			sightlangStaticImageUsed[12] = true
			if sightlangStaticImageToc[12] then
				processsightlangStaticImage[12]()
			end
			dxDrawImage(screenX / 2 - gs / 2, iy + 290 - 125 + 199 - gs / 2, gs, gs, sightlangStaticImage[12], 0, 0, 0, tocolor(245, 206, 70, 255 * overallAlpha))
		end
		dxDrawImage(screenX / 2 - s / 2, iy + 290 - 125 + 199 - s / 2, s, s, ":sItems/files/items/" .. winItem - 1 .. ".png", 0, 0, 0, tocolor(255, 255, 255, 255 * overallAlpha))
	end
	local delta = nearestD - lastDistance
	lastDistance = nearestD
	local tmp = delta <= 0
	if lastDistanceWay ~= tmp then
		lastDistanceWay = tmp
		if tmp and 0 < spinSpeed then
			playSound("files/spin.mp3")
		end
	end
	if nearestItemId then
		local c = 64 / md
		local a = (0.5 - nearestD / c) / 0.5
		dxDrawText(santaNames[nearestItemId], 1, iy + 290 - 125 + 230 + 1, screenX + 1, 0, tocolor(0, 0, 0, 150 * a * targetAlpha * overallAlpha), fontScale * (0.8 + rotateEndedP * 0.2), font, "center", "top")
		if nearestItemId == 418 then
			dxDrawText(santaNames[nearestItemId], 0, iy + 290 - 125 + 230, screenX, 0, tocolor(148, 60, 184, 255 * a * targetAlpha * overallAlpha), fontScale * (0.8 + rotateEndedP * 0.2), font, "center", "top")
		elseif goldItems[nearestItemId] then
			dxDrawText(santaNames[nearestItemId], 0, iy + 290 - 125 + 230, screenX, 0, tocolor(245, 206, 70, 255 * a * targetAlpha * overallAlpha), fontScale * (0.8 + rotateEndedP * 0.2), font, "center", "top")
		else
			dxDrawText(santaNames[nearestItemId], 0, iy + 290 - 125 + 230, screenX, 0, tocolor(255, 255, 255, 255 * a * targetAlpha * overallAlpha), fontScale * (0.8 + rotateEndedP * 0.2), font, "center", "top")
		end
	end
	for i = 1, #snow do
		if snow[i][8] then
			local s = snow[i][4]
			local a = 255 * math.max(0, 1 - math.abs(snow[i][2] - x) / 400)
			a = math.min(a, snow[i][6])
			local p = snow[i][3]
			local x = snow[i][2] - s / 2 + math.sin(p / 50) * s * 0.75
			local y = p - s / 2 - math.cos(p / 25) * s / 4
			dxDrawImage(x, y, s, s, dynamicImage("files/" .. snow[i][1] .. ".dds"), snow[i][5], 0, 0, tocolor(255, 255, 255, a * overallAlpha))
		end
	end
	for i = 1, #words do
		local a = 255
		local p = words[i][4]
		if 0.85 < p then
			a = a - a * (p - 0.85) / 0.15000000000000002
		end
		if p < 0.25 then
			a = a * (p / 0.25)
		end
		local xm = 1 - math.pow(p, 3)
		local s = 64 * (p * 0.25 + 0.25 + 0.5 * xm)
		local x = words[i][2] - s / 2 + xm * 128
		local y = words[i][3] * p - s / 2
		dxDrawImage(x, y, s, s, dynamicImage("files/" .. words[i][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, a * overallAlpha))
	end
end
