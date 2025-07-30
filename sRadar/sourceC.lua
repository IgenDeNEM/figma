local sightexports = {
	sPermission = false,
	sRing = false,
	sBag = false,
	sGps = false,
	sGui = false,
	sSpeedo = false,
	sDashboard = false
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
		sightlangStaticImage[0] = dxCreateTexture("files/arrow_shadow.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/arrow.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[2] = function()
	if not isElement(sightlangStaticImage[2]) then
		sightlangStaticImageToc[2] = false
		sightlangStaticImage[2] = dxCreateTexture("files/arrow2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[3] = function()
	if not isElement(sightlangStaticImage[3]) then
		sightlangStaticImageToc[3] = false
		sightlangStaticImage[3] = dxCreateTexture("files/cross.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
	if not sightlangWaiterState0 then
		local res0 = getResourceFromName("sRing")
		if res0 and getResourceState(res0) == "running" then
			seeringStarted()
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
local faTicks = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		faTicks = sightexports.sGui:getFaTicks()
		guiRefreshColors()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
	faTicks = sightexports.sGui:getFaTicks()
end)
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), processSecondaryTextures, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), processSecondaryTextures)
		end
	end
end
local screenX, screenY = guiGetScreenSize()
local inSeeRing = false
local currentSeeringLayout = 1
local renderSizes = {
	512,
	256,
	128,
	64,
	32
}
local ringTextures = {}
for i = 1, #renderSizes do
	ringTextures[renderSizes[i]] = {}
end
local showPlayers = false
local targetPlayer = localPlayer
addEventHandler("onClientElementDataChange", localPlayer, function(dataName, oldValue, newValue)
	if dataName == "spectateTarget" then
		if newValue then
			targetPlayer = newValue
		else
			targetPlayer = localPlayer
		end
	end
end)
addCommandHandler("showplayers", function()
	if sightexports.sPermission:hasPermission(localPlayer, "showplayers") then
		showPlayers = not showPlayers
		outputChatBox("[color=sightgreen][SightMTA - Radar]: #ffffffShowplayers " .. (showPlayers and "[color=sightgreen]be" or "[color=sightred]ki") .. "kapcsolva.", 255, 255, 255, true)
	end
end)
addEvent("gotSeeringLayout", true)
addEventHandler("gotSeeringLayout", getRootElement(), function(layout)
	if currentSeeringLayout ~= layout then
		currentSeeringLayout = layout
		for i = 1, #renderSizes do
			for s, el in pairs(ringTextures[renderSizes[i]]) do
				if isElement(el) then
					destroyElement(el)
				end
				el = nil
				ringTextures[renderSizes[i]][s] = nil
			end
		end
	end
end)
function checkSeeRing()
	inSeeRing = sightexports.sRing:isPlayerInSeeRing()
end
addEvent("refreshPlayerInSeering", false)
addEventHandler("refreshPlayerInSeering", getRootElement(), checkSeeRing)
function seeringStarted()
	triggerServerEvent("getSeeringLayout", localPlayer)
	checkSeeRing()
end
local ringIDS = {
	[64] = true,
	[65] = true,
	[75] = true,
	[76] = true,
	[87] = true,
	[88] = true
}
local invalidatedIds = {
	[5] = true,
	[6] = true,
	[7] = true,
	[8] = true,
	[9] = true,
	[10] = true,
	[11] = true,
	[12] = true,
	[18] = true,
	[19] = true,
	[20] = true,
	[23] = true,
	[24] = true,
	[30] = true,
	[31] = true,
	[36] = true,
	[42] = true,
	[43] = true,
	[48] = true,
	[54] = true,
	[55] = true,
	[58] = true,
	[59] = true,
	[60] = true,
	[140] = true,
	[21] = true,
	[22] = true,
	[44] = true,
	[45] = true,
	[46] = true,
	[47] = true,
	[32] = true,
	[33] = true,
	[34] = true,
	[35] = true
}
local radarBlocks = {}
local renderSizes = {
	512,
	256,
	128,
	64,
	32
}
for i = 1, #renderSizes do
	radarBlocks[renderSizes[i]] = {}
end
for i = 1, 144 do
	if not invalidatedIds[i] then
		radarBlocks[32][i] = dxCreateTexture("files/tex/sight/32/" .. i .. ".dds", "dxt5", false)
	end
end
local radarTS = 256
local texTS = 256
local radarPieceRT = dxCreateRenderTarget(math.floor(screenX / 256 * 512), math.floor(screenY / 256 * 512), true)
function coordToTex(x, y)
	x = (x + 3000) / 6000 * 12
	y = (-y + 3000) / 6000 * 12
	local cx, cy = math.ceil(x), math.ceil(y)
	return cx, cy, 1 - (cx - x), 1 - (cy - y)
end
function toValidId(idX, idY)
	if 1 <= idX and idX <= 12 and 1 <= idY and idY <= 12 then
		local id = idX + (idY - 1) * 12
		if not invalidatedIds[id] then
			return id
		end
	end
end
function toRealWorldUnit(x)
	return x / radarTS * 6000 / 12
end
function getTSSize(s)
	if 256 < s then
		return 512
	elseif 128 < s then
		return 256
	elseif 64 < s then
		return 128
	elseif 32 < s then
		return 64
	else
		return 32
	end
end
local radarPieceZoom = 1
local radarPX, radarPY = 0, 0
local radarSX, radarSY = 300, 256
local storedX, storedY, storedNX, storedNY, storedRadarTS
local forceRadarRerender = false
local idX, idY, xf, yf = 0, 0, 0, 0
local xbs, ybs = 0, 0
addEventHandler("onClientRestore", getRootElement(), function()
	forceRadarRerender = true
end)
function forceRadarToRender()
	forceRadarRerender = true
end
local isInNavi = false
local radarOn = true
local ringTexturesCreated = false
local seeringColor = false
local speedZoom = 1
local usedTex = {}
local usedTexIds = {}
for i = 1, #renderSizes do
	usedTex[renderSizes[i]] = {}
end
addEventHandler("onClientPreRender", getRootElement(), function()
	if inSeeRing then
		for id in pairs(ringIDS) do
			if not isElement(ringTextures[32][id]) then
				ringTextures[32][id] = dxCreateTexture("files/tex/ring/" .. currentSeeringLayout .. "/32/" .. id .. ".dds", "dxt5", false)
				forceRadarRerender = true
				ringTexturesCreated = true
				break
			end
		end
	elseif ringTexturesCreated then
		ringTexturesCreated = false
		for i = 1, #renderSizes do
			for s, el in pairs(ringTextures[renderSizes[i]]) do
				if isElement(el) then
					destroyElement(el)
				end
				el = nil
				ringTextures[renderSizes[i]][s] = nil
			end
		end
	end
	local realSize = 3072 * radarPieceZoom / 12
	radarTS = getTSSize(realSize)
	if bigRadarElement then
		texTS = radarTest
	else
		texTS = math.max(radarTS, getTSSize(realSize / speedZoom))
	end
	local zoom = realSize / radarTS
	xbs = radarSX / zoom
	ybs = radarSY / zoom
	idX, idY, xf, yf = coordToTex(radarPX - toRealWorldUnit(xbs / 2), radarPY + toRealWorldUnit(ybs / 2))
	local nx = math.ceil(xbs / radarTS)
	local ny = math.ceil(ybs / radarTS)
	local created = false
	local validIds = {}
	local int = getElementInterior(localPlayer)
	local dim = getElementDimension(localPlayer)
	local tmp = int <= 0 and dim <= 0
	if sightexports.sBag:getBagState() then
		tmp = false
	end
	if tmp ~= radarOn then
		radarOn = tmp
		forceRadarRerender = true
	end
	local now = getTickCount()
	for id in pairs(usedTexIds) do
		usedTexIds[id] = nil
	end
	for x = 0, nx do
		validIds[x] = {}
		for y = 0, ny do
			validIds[x][y] = radarOn and toValidId(idX + x, idY + y)
			local id = validIds[x][y]
			if id then
				if not created and not isElement(radarBlocks[texTS][id]) then
					radarBlocks[texTS][id] = dxCreateTexture("files/tex/sight/" .. texTS .. "/" .. id .. ".dds", "dxt5", false)
					created = true
					forceRadarRerender = true
				end
				if not created and inSeeRing and ringIDS[id] and not isElement(ringTextures[texTS][id]) then
					ringTextures[texTS][id] = dxCreateTexture("files/tex/ring/" .. currentSeeringLayout .. "/" .. texTS .. "/" .. id .. ".dds", "dxt5", false)
					created = true
					forceRadarRerender = true
				end
				usedTex[texTS][id] = now
				usedTexIds[id] = true
			end
		end
	end
	local deleted = false
	for i = 1, #renderSizes - 1 do
		local ts = renderSizes[i]
		for vid in pairs(radarBlocks[ts]) do
			if 2000 < now - usedTex[ts][vid] then
				if isElement(radarBlocks[ts][vid]) then
					destroyElement(radarBlocks[ts][vid])
				end
				radarBlocks[ts][vid] = nil
				if isElement(ringTextures[ts][vid]) then
					destroyElement(ringTextures[ts][vid])
				end
				ringTextures[ts][vid] = nil
				deleted = true
				usedTex[ts][vid] = nil
				break
			end
		end
		if deleted then
			break
		end
	end
	if storedX ~= idX or storedY ~= idY or storedNX ~= nx or storedNY ~= ny or storedRadarTS ~= radarTS or forceRadarRerender then
		storedX, storedY, storedNX, storedNY = idX, idY, nx, ny
		storedRadarTS = radarTS
		forceRadarRerender = false
		dxSetRenderTarget(radarPieceRT, true)
		dxSetBlendMode("modulate_add")
		for x = 0, nx do
			for y = 0, ny do
				local vid = validIds[x][y]
				if vid then
					if radarBlocks[texTS][vid] then
						dxDrawImage(x * radarTS, y * radarTS, radarTS, radarTS, radarBlocks[texTS][vid])
					else
						for i = 1, #renderSizes do
							local ts = renderSizes[i]
							if radarBlocks[ts][vid] then
								dxDrawImage(x * radarTS, y * radarTS, radarTS, radarTS, radarBlocks[ts][vid])
								break
							end
						end
					end
					if inSeeRing then
						if ringTextures[texTS][vid] then
							dxDrawImage(x * radarTS, y * radarTS, radarTS, radarTS, ringTextures[texTS][vid], 0, 0, 0, seeringColor)
						else
							for i = 1, #renderSizes do
								local ts = renderSizes[i]
								if ringTextures[ts][vid] then
									dxDrawImage(x * radarTS, y * radarTS, radarTS, radarTS, ringTextures[ts][vid], 0, 0, 0, seeringColor)
									break
								end
							end
						end
					end
				end
			end
		end
		isInNavi = sightexports.sGps:drawMapRoute(idX, idY, nx, ny, radarTS)
		dxSetBlendMode("blend")
		dxSetRenderTarget()
	end
end, true, "low-999999")
--[[
addCommandHandler("createdradartex", function()
	for i = 1, #renderSizes do
		outputChatBox("s " .. renderSizes[i] .. ":")
		for id in pairs(radarBlocks[renderSizes[i) do
			outputChatBox("  " .. id)
		end
		for id in pairs(ringTextures[renderSizes[i) do
			outputChatBox("  ring " .. id)
		end
	end
end)
]]
local radarArrowColor = false
local radarArrowColorEx = false
local radarBloodColor = false
local radarX, radarY = 0, 0
local blips = {}
local blipGroups = {}
local targetBlipSize = 32
local targetBlipIcon = false
local targetBlipIcon2 = false
local targetBlipAlpha = 255
local blipSize = 32
local blipShadow = 0
local blipColor = 0
local blipAlpha = 255
local sweetSixteen = false
local sweetSixteenScale = false
local bigRadarLegendColor = false
local bigRadarLegendScrollColor = {}
local mapBackground = false
local blipIcons = {}
local blipTooltips = {}
local disableBlipSticky = {}
local disableBlip3D = {}
addEventHandler("onClientElementDataChange", getRootElement(), function(data, old, new)
	if data == "tooltipText" then
		blipTooltips[source] = new
	elseif data == "disableBlipSticky" then
		disableBlipSticky[source] = new
	elseif data == "disableBlip3D" then
		disableBlip3D[source] = new
	end
end)
addEventHandler("onClientElementDestroy", getRootElement(), function()
	blipTooltips[source] = nil
	disableBlipSticky[source] = nil
	disableBlip3D[source] = nil
end)
local markBlips = {}
local refreshZoomRot = false
local radarZoom = 1
local radarZoomSave = false
function saveRadarZoom()
	local file = fileCreate("!radar_zoom.sight")
	fileWrite(file, tostring(radarZoom))
	fileClose(file)
end
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
	if radarZoomSave then
		saveRadarZoom()
	end
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	if fileExists("!sRadar_marks.sight") then
		local file = fileOpen("!sRadar_marks.sight")
		local dat = fileRead(file, fileGetSize(file))
		dat = split(dat, "\n")
		for i = 1, #dat do
			local pos = split(dat[i], ",")
			local x = tonumber(pos[1])
			local y = tonumber(pos[2])
			local z = tonumber(pos[3])
			if x and y and -4500 <= x and -4500 <= y and x <= 4500 and y <= 4500 then
				table.insert(markBlips, {
					x,
					y,
					z
				})
			end
		end
		fileClose(file)
	end
	if fileExists("!radar_zoom.sight") then
		local file = fileOpen("!radar_zoom.sight")
		local dat = tonumber(fileRead(file, fileGetSize(file))) or 0
		radarZoom = math.max(math.min(dat, 1.3), 0.45)
		fileClose(file)
	end
	refreshZoomRot = true
	local blips = getElementsByType("blip")
	for i = 1, #blips do
		blipTooltips[blips[i]] = getElementData(blips[i], "tooltipText")
		disableBlipSticky[blips[i]] = getElementData(blips[i], "disableBlipSticky")
		disableBlip3D[blips[i]] = getElementData(blips[i], "disableBlip3D")
	end
end)
local initGui = false
local bigCircle1 = false
local bigCircle2 = false
local markBlipColor = false
local arrowIcon = false
local blipFont = false
local blipFontScale = false
local bigRadarFont = false
local bigRadarFontScale = false
local bigRadarFontH = false
function guiRefreshColors()
	radarArrowColor = sightexports.sGui:getColorCode("sightgreen")
	radarArrowColorEx = sightexports.sGui:getColorCode("sightblue")
	radarBloodColor = sightexports.sGui:getColorCode("sightred")
	markBlipColor = sightexports.sGui:getColorCode("sightpurple")
	mapBackground = sightexports.sGui:getColorCode("hudwhite")
	seeringColor = sightexports.sGui:getColorCodeToColor("sightyellow")
	targetBlipSize = 18
	bigRadarLegendScrollColor = {
		sightexports.sGui:getColorCodeToColor("sightgreen"),
		sightexports.sGui:getColorCodeToColor("sightgrey2")
	}
	bigRadarLegendColor = sightexports.sGui:getColorCodeToColor("#000000")
	blipShadow = sightexports.sGui:getColorCodeToColor("sightgrey2")
	blipColor = tocolor(255, 255, 255)
	arrowIcon = sightexports.sGui:getFaIconFilename("angle-right", 64)
	targetBlipIcon = sightexports.sGui:getFaIconFilename("circle", targetBlipSize * 5, "solid", false, blipShadow, blipColor)
	bigCircle1 = sightexports.sGui:getFaIconFilename("circle", 128, "solid", false, blipShadow, blipColor)
	bigCircle2 = sightexports.sGui:getFaIconFilename("circle", 128, "regular", false, blipShadow, blipColor)
	blipIcons = {
		{
			sightexports.sGui:getFaIconFilename("car", 28, "solid", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("bolt", 28, "solid", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("home", 28, "solid", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("exclamation-circle", 28, "solid", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("siren", 28, "solid", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("siren", 30, "solid", false, blipShadow, blipColor),
			30
		},
		{
			sightexports.sGui:getFaIconFilename("siren-on", 30, "solid", false, blipShadow, blipColor),
			30
		},
		{
			sightexports.sGui:getFaIconFilename("mobile-alt", 30, "solid", false, blipShadow, blipColor),
			30,
			true
		},
		{
			sightexports.sGui:getFaIconFilename("fire-alt", 28, "regular", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("sensor-alert", 28, "solid", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("hdd", 30, "solid", false, blipShadow, blipColor),
			30,
			true
		},
		{
			sightexports.sGui:getFaIconFilename("truck", 30, "solid", false, blipShadow, blipColor),
			30,
			true
		},
		{
			sightexports.sGui:getFaIconFilename("warehouse", 28, "solid", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("university", 28, "solid", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("door-open", 24, "solid", false, blipShadow, blipColor),
			24
		},
		{
			sightexports.sGui:getFaIconFilename("handshake-alt", 28, "solid", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("map-marker-alt", 33.6, "solid", false, blipShadow, blipColor),
			56
		},
		{
			sightexports.sGui:getFaIconFilename("fill-drip", 28, "solid", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("farm", 28, "solid", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("truck-loading", 28, "solid", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("location", 28, "solid", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("phone", 30, "solid", false, blipShadow, blipColor),
			30,
			true
		},
		{
			sightexports.sGui:getFaIconFilename("envelope", 30, "solid", false, blipShadow, blipColor),
			30,
			true
		},
		{
			sightexports.sGui:getFaIconFilename("industry-alt", 28, "solid", false, blipShadow, blipColor),
			28
		},
		{
			sightexports.sGui:getFaIconFilename("bell-exclamation", 30, "solid", false, blipShadow, blipColor),
			30
		},
		{
			sightexports.sGui:getFaIconFilename("user", 24, "solid", false, blipShadow, blipColor),
			24
		},
		{
			sightexports.sGui:getFaIconFilename("ghost", 30, "solid", false, blipShadow, blipColor),
			30
		},
		{
			sightexports.sGui:getFaIconFilename("helicopter", 30, "solid", false, blipShadow, blipColor),
			30
		},
		{
			sightexports.sGui:getFaIconFilename("bullseye", 30, "solid", false, blipShadow, blipColor),
			30
		},
		{
			sightexports.sGui:getFaIconFilename("dot-circle", 30, "solid", false, blipShadow, blipColor),
			30
		},
		{
			sightexports.sGui:getFaIconFilename("briefcase", 30, "solid", false, blipShadow, blipColor),
			30,
			650
		},
		{
			sightexports.sGui:getFaIconFilename("briefcase", 30, "solid", false, blipShadow, blipColor),
			30,
		},
		{
			sightexports.sGui:getFaIconFilename("user-secret", 30, "solid", false, blipShadow, blipColor),
			30
		},
		{
			sightexports.sGui:getFaIconFilename("mountains", 30, "solid", false, blipShadow, blipColor),
			30
		},
		{
			sightexports.sGui:getFaIconFilename("gas-pump", 30, "solid", false, blipShadow, blipColor),
			30,
		},
		{
			sightexports.sGui:getFaIconFilename("money-bill", 30, "solid", false, blipShadow, blipColor),
			30,
		},
	}
	blipFont = sightexports.sGui:getFont("11/Ubuntu-R.ttf")
	blipFontScale = sightexports.sGui:getFontScale("11/Ubuntu-R.ttf")
	bigRadarFont = sightexports.sGui:getFont("11/Ubuntu-L.ttf")
	bigRadarFontScale = sightexports.sGui:getFontScale("11/Ubuntu-L.ttf")
	bigRadarFontH = sightexports.sGui:getFontHeight("11/Ubuntu-L.ttf")
	sweetSixteen = sightexports.sGui:getFont("30/SweetSixteen.ttf")
	sweetSixteenScale = sightexports.sGui:getFontScale("30/SweetSixteen.ttf")
	initGui = true
	refreshBlipList()
end
local blipColorState = "Színes"
function getBlipColorState()
	return blipColorState
end
function setBlipColorState(val)
	blipColorState = val
	refreshBlipList()
end
local blipList = {
	{
		-2111.6689453125,
		-2484.306640625,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	},
	{
		-1846.3447265625,
		-1700.650390625,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	},
	{
		-70.5322265625,
		-1158.0576171875,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		-1266.3955078125,
		-26.4052734375,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		-1686.4921875,
		393.3818359375,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		-1424.5048828125,
		879.873046875,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		-1473.2060546875,
		1875.8515625,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		-1322.880859375,
		2689.623046875,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		85.34375,
		-185.455078125,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		1416.55859375,
		459.1904296875,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		2257.8701171875,
		-85.7314453125,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		984.529296875,
		-919.197265625,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		1129.0546875,
		-1431.1630859375,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		1503.220703125,
		-1717.0732421875,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		1908.7373046875,
		-1782.03515625,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		2118.068359375,
		-1778.7177734375,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		2400.146484375,
		-2499.9365234375,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		-2540.6796875,
		2357.767578125,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	  {
		-2411.83203125,
		-585.583984375,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	  },
	{
		2398.916015625,
		-2499.4189453125,
		"bolt",
		"sightgreen",
		"PlugSight Supercharger"
	},
	{
		2437.109375,
		-2465.6962890625,
		"car-mechanic",
		"sightblue",
		"Boxter Mechanic Shop"
	},
	{
		-1493.7607421875,
		842.2373046875,
		"car-mechanic",
		"sightblue",
		"Fix & Drive Mechanic Shop"
	},
	{
		-1882.6533203125,
		-1698.197265625,
		"car-mechanic",
		"sightblue",
		"Angel Pine Junkyard szerelőtelep"
	},
	{
		1024.859375,
		-1033.4140625,
		"motorcycle",
		"sightorange",
		"Motorkerékpár szerviz"
	},
	{
		-2710.98046875,
		217.33203125,
		"motorcycle",
		"sightorange",
		"Motorkerékpár szerviz"
	},
	{
		727.423828125,
		-1509.84765625,
		"tools",
		"sightorange",
		"Hajó szerviz"
	},
	{
		-333.5673828125,
		-473.56640625,
		"tools",
		"sightorange",
		"Hajó szerviz"
	},
	{
		1765.7626953125,
		-2286.431640625,
		"tools",
		"sightorange",
		"Helikopter szerviz"
	},
	{
		-2227.5849609375,
		2326.6494140625,
		"tools",
		"sightorange",
		"Helikopter szerviz"
	},
	{
		-1857.416015625,
		-1721.5703125,
		"car-crash",
		"sightred-second",
		"Roncstelep"
	},
	{
		-1685.9365234375,
		-1678.1201171875,
		"car-crash",
		"sightred-second",
		"Hajó bontó"
	},
	{
		254.4248046875,
		-63.3857421875,
		"handshake",
		"sightyellow",
		"Zálogház"
	},
	{
		-2625,
		209,
		"crosshairs",
		"sightred-second",
		"Fegyverbolt"
	},
	{
		1367,
		-1279,
		"crosshairs",
		"sightred-second",
		"Fegyverbolt"
	},
	{
		-1509.1201171875,
		2610.2060546875,
		"crosshairs",
		"sightred-second",
		"Fegyverbolt"
	},
	{
		1185.3974609375,
		-1323.5732421875,
		"clinic-medical",
		"sightred",
		"Los Santos Kórház"
	},
	{
		-2665.048828125,
		630.9169921875,
		"clinic-medical",
		"sightred",
		"San Fierro Kórház"
	},
	{
		1246.53125,
		337.3828125,
		"clinic-medical",
		"sightred",
		"Montgomery Kórház"
	},
	{
		-1514.8251953125,
		2521.2568359375,
		"clinic-medical",
		"sightred",
		"Tierra Robada Kórház"
	},
	{
		1288.1796875,
		-1652.4794921875,
		"ambulance",
		"sightred-second",
		"OMSZ Központ"
	},
	{
		-2042.6357421875,
		70.80078125,
		"fire-extinguisher",
		"solid",
		"sightred",
		"Katasztrófavédelem"
	},
	{
		1810.2338867188,
		-1889.5958251953,
		"taxi",
		"sightyellow",
		"Sight City Közlekedési Központ",
	},
	{
		53.6064453125,
		-1531.5595703125,
		"passport",
		"sightlightgrey",
		"Határ"
	},
	{
		-13.7783203125,
		-1351.6103515625,
		"passport",
		"sightlightgrey",
		"Határ"
	},
	{
		-81.6376953125,
		-905.5771484375,
		"passport",
		"sightlightgrey",
		"Határ"
	},
	{
		-967.22265625,
		-340.271484375,
		"passport",
		"sightlightgrey",
		"Határ"
	},
	{
		-1399.4833984375,
		822.482421875,
		"passport",
		"sightlightgrey",
		"Határ"
	},
	{
		-2681.912109375,
		1274.3564453125,
		"passport",
		"sightlightgrey",
		"Határ"
	},
	{
		29.7294921875,
		-2647.33984375,
		"farm",
		"sightyellow",
		"Farm"
	},
	{
		-1609.5654296875,
		-2712.13671875,
		"farm",
		"sightyellow",
		"Farm"
	},
	{
		-1078.7197265625,
		-981.4208984375,
		"farm",
		"sightyellow",
		"Farm"
	},
	{
		-1686.2353515625,
		-73.4541015625,
		"farm",
		"sightyellow",
		"Farm"
	},
	{
		-1837.9638671875,
		63.5986328125,
		"farm",
		"sightyellow",
		"Farm"
	},
	{
		-2900.201171875,
		461.0703125,
		"farm",
		"sightyellow",
		"Farm"
	},
	{
		-2256.4208984375,
		2310.0732421875,
		"farm",
		"sightyellow",
		"Farm"
	},
	{
		-2462.927734375,
		2225.1484375,
		"farm",
		"sightyellow",
		"Farm"
	},
	{
		-89.3466796875,
		-3.4443359375,
		"farm",
		"sightyellow",
		"Farm"
	},
	{
		-2615.052734375,
		2273.08984375,
		"store",
		"sightorange",
		"Piac"
	},
	{
		1108.5390625,
		-1796.431640625,
		"cars",
		"sightblue",
		"Autósiskola"
	},
	{
		-873.10546875,
		211.16015625,
		"flag-checkered",
		"sightorange",
		"SightRing bejárat"
	},
	{
		-1738.48046875,
		-579.21875,
		"flag-checkered",
		"sightorange",
		"SightRing bejárat"
	},
	{
		1481.296875,
		-1769.09960937,
		"landmark",
		"sightgreen",
		"Városháza"
	},
	{
		1540.296875,
		-1674.181640625,
		"siren-on",
		"regular",
		"sightblue",
		"Rendőrség"
	},
	{
		635.181640625,
		-571.9306640625,
		"siren-on",
		"regular",
		"sightblue",
		"Rendőrség"
	},
	{
		1940.255859375,
		-1771.6328125,
		"gas-pump",
		"sightred",
		"Benzinkút"
	},
	{
		1004.0224609375,
		-935.9990234375,
		"gas-pump",
		"sightred",
		"Benzinkút"
	},
	{
		-2106.7119140625,
		-2469.8203125,
		"gas-pump",
		"sightred",
		"Benzinkút"
	},
	{
		-1672.8525390625,
		408.44140625,
		"gas-pump",
		"sightred",
		"Benzinkút"
	},
	{
		-86.9462890625,
		-1176.732421875,
		"gas-pump",
		"sightred",
		"Benzinkút"
	},
	{
		103.759765625,
		-176.59375,
		"gas-pump",
		"sightred",
		"Benzinkút"
	},
	{
		1353.1787109375,
		466.255859375,
		"gas-pump",
		"sightred",
		"Benzinkút"
	},
	{
		-1482.498046875,
		1862.966796875,
		"gas-pump",
		"sightred",
		"Benzinkút"
	},
	{
		-1311.5771484375,
		2677.6162109375,
		"gas-pump",
		"sightred",
		"Benzinkút"
	},
	{
		-1243.642578125,
		-33.99609375,
		"gas-pump",
		"sightred",
		"Benzinkút"
	},
	{
		-1298.2587890625,
		24.5634765625,
		"garage-open",
		"sightblue",
		"Tuning műhely"
	},
	{
		-1267.46875,
		2708.3212890625,
		"garage-open",
		"sightblue",
		"Tuning műhely"
	},
	{
		1040.3349609375,
		-907.357421875,
		"garage-open",
		"sightblue",
		"Tuning műhely"
	},
	{
		-1787.2197265625,
		-1600.8896484375,
		"garage-open",
		"sightblue",
		"Tuning műhely"
	},
	{
		-1818.8623046875,
		-1671.1640625,
		"tachometer-alt-fastest",
		"sightred-second",
		"SightDyno"
	},
	{
		-1281.3193359375,
		-18.7314453125,
		"tachometer-alt-fastest",
		"sightred-second",
		"SightDyno"
	},
	{
		2491.4370117188, 
		-2429.5324707031,
		"tachometer-alt-fastest",
		"sightred-second",
		"SightDyno"
	},
	{
		-66.48046875,
		-1114.8125,
		"tachometer-alt-fastest",
		"sightred-second",
		"SightDyno"
	},
	{
		-1546.4892578125,
		-65.95703125,
		"flag-checkered",
		"sightred",
		"Drag pálya"
	},
	{
		1183.99609375,
		-1433.357421875,
		"money-check-edit-alt",
		"sightgreen",
		"Bank"
	},
	{
		619.8349609375,
		-1628.755859375,
		"money-check-edit-alt",
		"sightgreen",
		"Bank"
	},
	{
		-828.259765625,
		1503.22265625,
		"money-check-edit-alt",
		"sightgreen",
		"Bank"
	},
	{
		-1572.236328125,
		662.1669921875,
		"file-invoice-dollar",
		"solid",
		"sightgreen",
		"NAV (Adóhatóság)"
	},
	{
		-2042.6357421875,
		70.80078125,
		"fire-extinguisher",
		"solid",
		"sightred",
		"Katasztrófavédelem"
	},
	{
		1057.1787109375,
		-1555.123046875,
		"dice",
		"sightred",
		"Kaszinó"
	},
	{
		1948.1171875,
		-2118.3017578125,
		"dice",
		"sightred",
		"Kaszinó"
	},
	{
		-1806.0537109375,
		906.6689453125,
		"dice",
		"sightred",
		"Kaszinó"
	},
	{
		-856.6025390625,
		1537.0263671875,
		"dice",
		"sightred",
		"Kaszinó"
	},
	{
		1022.74609375,
		-1130.189453125,
		"dice",
		"sightred",
		"Kaszinó"
	},
	{
		-488.95703125,
		-561.9365234375,
		"truck-loading",
		"sightgreen",
		"Áruszállító depó"
	},
	{
		-1411.66796875,
		-1473.169921875,
		"wheat",
		"sightyellow",
		"Mezőgazdasági nagyker"
	},
	{
		-1910.25390625,
		293.0439453125,
		"paint-roller",
		"sightpurple",
		"MiguItalia"
	},
	{
		2404.4892578125,
		-2138.8701171875,
		"trailer",
		"sightpurple",
		"Utánfutó bérlés"
	},
	{
		2769.2353515625,
		-1606.6826171875,
		"industry-alt",
		"sightred",
		"Los Santos Gyár"
	},
	{
		-2718.9580078125,
		74.1650390625,
		"industry-alt",
		"sightred",
		"San Fierro Gyár"
	},
	{
		2021.078125,
		-2247.9951171875,
		"industry-alt",
		"sightpurple",
		"Ipari park"
	},
	{
		-147.06640625,
		-296.2099609375,
		"industry-alt",
		"sightpurple",
		"Ipari park"
	},
	{
		816.11120605469,
		-1386.9178466797,
		"dot-circle",
		"sightred", 
		"Billiárd terem"
	},
	{
		1128.4401855469,
		-1560.2990722656,
		"bullseye",
		"sightred",
		"AirSoft pálya (mélygarázsban)"
	},
	{
		1069.78125,
		-1471.8408203125,
		"tshirt",
		"sightblue",
		"Ruhabolt"
	},
	{
		461.1748046875,
		-1501.0048828125,
		"tshirt",
		"sightblue",
		"Ruhabolt"
	},
	{
		2244.3740234375,
		-1664.7060546875,
		"tshirt",
		"sightblue",
		"Ruhabolt"
	},
	{
		-1695.4697265625,
		950.8896484375,
		"tshirt",
		"sightblue",
		"Ruhabolt"
	},
	{
		2307.197265625,
		15.1337890625,
		"tshirt",
		"sightblue",
		"Ruhabolt"
	},
	{
		2112.19140625,
		-1807.5820312,
		"burger-soda",
		"sightblue-second",
		"Sight Burger"
	},
	{
		1129.0146484375,
		-1489.1591796875,
		"bags-shopping",
		"sightorange",
		"Pláza"
	},
	{
		1888.3251953125,
		-2200.642578125,
		"helicopter",
		"sightgreen",
		"Helikopter kereskedés"
	},
	{
		2127.265625,
		-1139.2314453125,
		"car",
		"sightgreen",
		"Autókereskedés"
	},
	{
		715.2861328125,
		-1625.859375,
		"ship",
		"sightgreen",
		"Hajókereskedés"
	},
	{
		-2146.826171875,
		-974.3232421875,
		"parking",
		"sightred",
		"Lefoglalt járművek kiváltása"
	},
	{
		-1273.732421875,
		2286.079101562,
		"music",
		"sightblue",
		"Dancing Pavilion"
	},
	{
		-2457.9338378906, 
		2488.1811523438,
		"mountains",
		"sightblue",
		"Sight Mining Co."
	},
	{
		-1209.32470703,
		2052.11743164,
		"mountains",
		"sightyellow",
		"Diamond Depths bánya"
	},
	{
		-1199.85473632,
		2249.184814453,
		"mountains",
		"sightyellow",
		"Emerald Grotto bánya"
	},
	{
		-1274.343505,
		2231.2636718,
		"mountains",
		"sightyellow",
		"Granite Ridge bánya"
	},
	{
		-1323.037475,
		2286.3176269,
		"mountains",
		"sightyellow",
		"Sapphire Shaft bánya"
	},
	{
		-1382.242919,
		2309.0949707,
		"mountains",
		"sightyellow",
		"Golden Summit bánya"
	},
	{
		-1391.9270019,
		2483.66674804,
		"mountains",
		"sightyellow",
		"Silver Vein bánya"
	},
	{
		1872.4,
		-1683.9,
		"compact-disc",
		"sightblue",
		"Alhambra Club"
	},
	{
		-1420.6318359375,
		2594.9013671875,
		"tachometer-alt-fastest",
		"sightred-second",
		"SightDyno"
	},
	{
		-2056.3994,
		-2462.2,
		"fish",
		"sightblue",
		"Horgászbolt"
	},
	{
		-1501.8,
		1955.7,
		"fish",
		"sightblue",
		"Horgászbolt"
	},
	{
		1256.091796875,
		206.1376953125,
		"shopping-basket",
		"sightblue",
		"Tündi Boltja"
	},
	{
		-2482.0268554688,
		2406.6333007812,
		"church",
		"sightyellow",
		"Templom"
	},
	{
		-7.8427734375,
		-247.1123046875,
		"knife-kitchen",
		"sightorange",
		"Vágóhíd"
	}
}
function getBlipList()
	return blipList
end
function refreshBlipList()
	if not initGui then
		return
	end
	blips = {}
	blipGroups = {}
	blipGroupsWidth = 0
	local tmp = {}
	local black = tocolor(0, 0, 0)
	local grey = sightexports.sGui:getColorCodeToColor("sightgrey2")
	local hudwhite = sightexports.sGui:getColorCodeToColor("hudwhite")
	for k = 1, #blipList do
		local data = blipList[k]
		if #data == 5 or #data == 6 then
			local dat = {
				tonumber(data[1]),
				tonumber(data[2])
			}
			local name = data[3] .. data[#data - 1] .. data[#data]
			local blipColor = false
			local shadow = blipShadow
			local border = false
			if blipColorState == "Fehér" then
				blipColor = hudwhite
			elseif blipColorState == "Fekete" then
				blipColor = black
				shadow = false
				border = hudwhite
			elseif blipColorState == "Szürke" then
				blipColor = grey
				shadow = false
				border = hudwhite
			else
				blipColor = sightexports.sGui:getColorCodeToColor(data[#data - 1])
			end
			dat[3] = sightexports.sGui:getFaIconFilename(data[3], blipSize, #data == 6 and data[4] or false, true, shadow, blipColor, border)
			dat[4] = blipSize
			dat[7] = data[#data]
			dat[8] = name
			dat[11] = toValidId(dat[1], dat[2])
			if not tmp[name] then
				tmp[name] = {}
				table.insert(blipGroups, {
					dat[3],
					dat[7],
					false,
					false,
					name
				})
				local w = sightexports.sGui:getTextWidthFont(dat[7], "12/Ubuntu-L.ttf")
				if w > blipGroupsWidth then
					blipGroupsWidth = w
				end
			end
			table.insert(blips, dat)
		end
	end
end
function rotate(px, py, pz, pitch, roll, yaw)
	pitch = math.rad(pitch)
	roll = math.rad(roll)
	yaw = math.rad(yaw)
	local cosa = math.cos(yaw)
	local sina = math.sin(yaw)
	local cosb = math.cos(pitch)
	local sinb = math.sin(pitch)
	local cosc = math.cos(roll)
	local sinc = math.sin(roll)
	local Axx = cosa * cosb
	local Axy = cosa * sinb * sinc - sina * cosc
	local Axz = cosa * sinb * cosc + sina * sinc
	local Ayx = sina * cosb
	local Ayy = sina * sinb * sinc + cosa * cosc
	local Ayz = sina * sinb * cosc - cosa * sinc
	local Azx = -sinb
	local Azy = cosb * sinc
	local Azz = cosb * cosc
	return Axx * px + Axy * py + Axz * pz, Ayx * px + Ayy * py + Ayz * pz, Azx * px + Azy * py + Azz * pz
end
local focal = 1024
function projection(x, y, z, size)
	local tana = size / focal
	local denom = size / tana
	local oX = x / z * denom
	local oY = y / z * denom
	return oX, oY
end
local radarSizeX = math.min(512, math.floor(screenX * 0.19))
local radarSizeY = math.min(256, math.floor(screenY * 0.21))
local radarZoomRot = 0
local radarRot = -65
function calculateInnerSize()
	local x, y, z = rotate(-radarSizeX / 2, 0, 0, 0, -65, 0)
	z = z + focal
	minX, minY = projection(x, y, z, radarSizeX)
	minX = math.abs(minX * 2) * 0.75
	local finalX = radarSizeX / minX * radarSizeX
	local x, y, z = rotate(0, -radarSizeY / 2, 0, 0, -65, 0)
	z = z + focal
	minX, minY = projection(x, y, z, radarSizeY)
	minY = math.abs(minY * 2) * 0.75
	local finalY = radarSizeY / minY * radarSizeY
	return math.max(finalX, finalY)
end
local radarInnerSize = calculateInnerSize()
local baseRt = dxCreateRenderTarget(radarInnerSize, radarInnerSize, true)
local radarRt = dxCreateRenderTarget(radarSizeX, radarSizeY, true)
local playerRt = dxCreateRenderTarget(64, 64, true)
local radarShader = dxCreateShader([[
texture texture0;
float percX;
float percY;

sampler implicitInputTexture = sampler_state 
{ 
	Texture = <texture0>; 
}; 
  
float4 MaskTextureMain( float2 uv : TEXCOORD0 ) : COLOR0 
{ 
	 
	float4 sampledTexture = tex2D( implicitInputTexture, uv ); 

	sampledTexture.a = sampledTexture.a*min(1, min(min(uv.x*percX, uv.y*percY), min((1-uv.x)*percX, (1-uv.y)*percY))); 

	return sampledTexture; 
} 
  
technique Technique0
{ 
	pass Pass0
	{ 
		PixelShader = compile ps_2_0 MaskTextureMain(); 
	} 
} 
]])
local blankShader = [[
texture texture0;

sampler implicitInputTexture = sampler_state 
{ 
	Texture = <texture0>; 
}; 
  
float4 Blank( float2 uv : TEXCOORD0 ) : COLOR0 
{ 
	 
	float4 sampledTexture = tex2D( implicitInputTexture, uv ); 
	return sampledTexture; 
} 
  
technique Technique1 
{ 
	pass Pass1 
	{ 
		PixelShader = compile ps_2_0 Blank(); 
	} 
} 
]]
local playerShader = dxCreateShader(blankShader)
dxSetShaderValue(playerShader, "texture0", playerRt)
local baseShader = dxCreateShader(blankShader)
dxSetShaderValue(baseShader, "texture0", baseRt)
dxSetShaderValue(radarShader, "texture0", radarRt)
local radarBlur = 16
dxSetShaderValue(radarShader, "percX", 100 / (radarBlur / radarSizeX * 100))
dxSetShaderValue(radarShader, "percY", 100 / (radarBlur / radarSizeY * 100))
dxSetShaderTransform(baseShader, 0, radarRot * (1 - radarZoomRot), 0)
dxSetShaderTransform(playerShader, 0, radarRot * (1 - radarZoomRot), 0)
local rtSize = math.ceil(math.sqrt(math.pow(radarInnerSize, 2) + math.pow(radarInnerSize, 2)) * 1.05)
function setRadarSize(sizeX, sizeY)
	radarSizeX = math.min(512, math.floor(sizeX))
	radarSizeY = math.min(256, math.floor(sizeY))
	radarInnerSize = calculateInnerSize()
	dxSetShaderValue(radarShader, "percX", 100 / (radarBlur / radarSizeX * 100))
	dxSetShaderValue(radarShader, "percY", 100 / (radarBlur / radarSizeY * 100))
	if isElement(baseRt) then
		destroyElement(baseRt)
	end
	if isElement(radarRt) then
		destroyElement(radarRt)
	end
	baseRt = dxCreateRenderTarget(radarInnerSize, radarInnerSize, true)
	radarRt = dxCreateRenderTarget(radarSizeX, radarSizeY, true)
	dxSetShaderValue(baseShader, "texture0", baseRt)
	dxSetShaderValue(radarShader, "texture0", radarRt)
end
function getVehicleSpeed(currentElement)
	if isElement(currentElement) then
		local x, y, z = getElementVelocity(currentElement)
		return math.sqrt(x ^ 2 + y ^ 2 + z ^ 2) * 187.5
	end
end
local rotInterpolation = false
local mapAngle = 0
local radarDamageTick = false
local radarDamageLevel = 0
addEventHandler("onClientPlayerDamage", localPlayer, function()
	radarDamageTick = getTickCount()
end)
local lx, ly, lz = getWorldFromScreenPosition(screenX / 2, screenY / 2, 1)
local hudDelta = 0
local widgetState = false
local widgetPos = pos
local tmpRadarSizeX, tmpRadarSizeY = 0, 0
function keyRadar(key)
	if key == "mouse_wheel_up" or key == "mouse_wheel_down" then
		local cx, cy = getCursorPosition()
		if cx then
			cx = cx * screenX
			cy = cy * screenY
			if cx >= widgetPos[1] and cy >= widgetPos[2] and cx <= widgetPos[1] + tmpRadarSizeX and cy <= widgetPos[2] + tmpRadarSizeY then
				if key == "mouse_wheel_down" then
					radarZoom = radarZoom - 0.075
					if radarZoom < 0.45 then
						radarZoom = 0.45
					end
					refreshZoomRot = true
				elseif key == "mouse_wheel_up" then
					radarZoom = radarZoom + 0.075
					if 1.3 < radarZoom then
						radarZoom = 1.3
					end
					refreshZoomRot = true
				end
			end
		end
	end
end
local bigRadarPos = {400, 400}
local bigRadarSize = {256, 256}
local bigRadarState = false
local bigRadarElement = false
local bigZoom = 0.55
local veh = false
function preRenderRadar(delta)
	local px, py, pz = getElementPosition(targetPlayer)
	veh = false
	if rotInterpolation then
		local progress = (getTickCount() - rotInterpolation[3]) / 500
		radarRot = interpolateBetween(rotInterpolation[1], 0, 0, rotInterpolation[2], 0, 0, progress, "InOutQuad")
		if 1 < progress then
			rotInterpolation = false
		end
		dxSetShaderTransform(baseShader, 0, radarRot * (1 - radarZoomRot), 0)
		dxSetShaderTransform(playerShader, 0, radarRot * (1 - radarZoomRot), 0)
	else
		veh = getPedOccupiedVehicle(targetPlayer)
		if veh then
			if -55 < radarRot then
				rotInterpolation = {
					radarRot,
					-55,
					getTickCount()
				}
			else
				local speed = getVehicleSpeed(veh)
				local tmp = -55 + math.min(1, speed / 250) * (math.abs(-55) - math.abs(-65))
				local zoomTmp = 1 - math.min(1, speed / 250) * 0.2
				if zoomTmp > speedZoom then
					speedZoom = speedZoom + delta / 1000 * 1.5
					if zoomTmp < speedZoom then
						speedZoom = zoomTmp
					end
				elseif zoomTmp < speedZoom then
					speedZoom = speedZoom - delta / 1000 * 1.5
					if zoomTmp > speedZoom then
						speedZoom = zoomTmp
					end
				end
				if tmp ~= radarRot then
					radarRot = tmp
					dxSetShaderTransform(baseShader, 0, radarRot * (1 - radarZoomRot), 0)
					dxSetShaderTransform(playerShader, 0, radarRot * (1 - radarZoomRot), 0)
				end
			end
		elseif radarRot < 0 then
			rotInterpolation = {
				radarRot,
				0,
				getTickCount()
			}
		end
	end
	if not veh and speedZoom < 1 then
		speedZoom = speedZoom + delta / 1000
		if 1 < speedZoom then
			speedZoom = 1
		end
	end
	if not bigRadarElement then
		radarPieceZoom = radarZoom * speedZoom
		radarPX, radarPY = px, py
		radarSX, radarSY = rtSize, rtSize
	end
	hudDelta = delta
	local cameraX, cameraY, cameraZ, cameraLookAtX, cameraLookAtY, cameraLookAtZ = getCameraMatrix()
	local tmp = math.deg(math.atan2(cameraLookAtY - cameraY, cameraLookAtX - cameraX)) + 180
	local a = mapAngle - tmp
	a = (a + 180) % 360 - 180
	if a < 0 then
		mapAngle = mapAngle + delta / 1000 * 1080
		local a = mapAngle - tmp
		a = (a + 180) % 360 - 180
		if 0 < a then
			mapAngle = tmp
		end
	elseif 0 < a then
		mapAngle = mapAngle - delta / 1000 * 1080
		local a = mapAngle - tmp
		a = (a + 180) % 360 - 180
		if a < 0 then
			mapAngle = tmp
		end
	end
	if radarOn then
		if getKeyState("num_sub") and not sightexports.sSpeedo:isCruiseSet("num_sub") then
			radarZoom = radarZoom - delta / 1000 * 0.5
			if radarZoom < 0.45 then
				radarZoom = 0.45
			end
			refreshZoomRot = true
			radarZoomSave = 2000
		elseif getKeyState("num_add") and not sightexports.sSpeedo:isCruiseSet("num_add") then
			radarZoom = radarZoom + delta / 1000 * 0.5
			if 1.3 < radarZoom then
				radarZoom = 1.3
			end
			refreshZoomRot = true
			radarZoomSave = 2000
		end
	end
	if refreshZoomRot then
		refreshZoomRot = false
		radarZoomRot = 0.2 * (1 - (radarZoom - 0.45) / 0.8500000000000001)
		dxSetShaderTransform(baseShader, 0, radarRot * (1 - radarZoomRot), 0)
		dxSetShaderTransform(playerShader, 0, radarRot * (1 - radarZoomRot), 0)
	end
	if radarZoomSave then
		radarZoomSave = radarZoomSave - delta
		if radarZoomSave <= 0 then
			radarZoomSave = false
			saveRadarZoom()
		end
	end
	if radarDamageTick then
		if getTickCount() - radarDamageTick > 350 then
			radarDamageLevel = math.max(0, radarDamageLevel - delta / 1000 * 4)
			if radarDamageLevel <= 0 then
				radarDamageLevel = 0
				radarDamageTick = false
			end
		else
			radarDamageLevel = math.min(1, radarDamageLevel + delta / 1000 * 4)
		end
	end
end
function rectangleOverlap(l1, t1, r1, b1, l2, t2, r2, b2)
	return not (r2 < l1) and not (r1 < l2) and not (b2 < t1) and not (b1 < t2)
end
local px, py, pz = 0, 0, 0
local rx, ry, rz = 0, 0, 0
local blipDatas = {}
function screenIntersection(dx, dy, s)
	local w = screenX / 2 - s
	local h = screenY / 2 - s
	local phi = h / w
	local theta = math.abs(dy / dx)
	local qx = 0 < dx and 1 or -1
	local qy = 0 < dy and 1 or -1
	local x, y = 0, 0
	if phi < theta then
		x = h / theta * qx
		y = h * qy
	else
		x = w * qx
		y = w * theta * qy
	end
	return x, y
end
local blips3dAlpha = 255
function draw3DBlip(nx, ny, nz, ctx, cty, r2, icon, c, shad, text)
	if not initGui then
		return
	end
	local x, y = getScreenFromWorldPosition(nx, ny, nz + 1.25, screenX * screenY)
	local r = 0
	local s = 14
	if x then
		if x >= s and x <= screenX - s and y >= s and y <= screenY - s then
			dxDrawImage(x - s, y - s, s * 2, s * 2, ":sGui/" .. icon .. (faTicks[icon] or ""), 0, 0, 0, c)
			dxDrawText(text, x + 1, y + s + 4 + 1, x + 1, 0, shad, blipFontScale * 0.9, blipFont, "center", "top")
			dxDrawText(text, x, y + s + 4, x, 0, tocolor(255, 255, 255, blips3dAlpha), blipFontScale * 0.9, blipFont, "center", "top")
			return
		end
		r = -math.atan2(x - screenX / 2, y - screenY / 2) + math.pi / 2
	else
		r = -math.atan2(ny - cty, nx - ctx)
		r = r + r2
	end
	local x, y = 10000 * math.cos(r), 10000 * math.sin(r)
	x, y = screenIntersection(x, y, 16)
	dxDrawImage(screenX / 2 + x - 20 + 1, screenY / 2 + y - 20 + 1, 40, 40, ":sGui/" .. arrowIcon .. faTicks[arrowIcon], math.deg(r), 0, 0, shad)
	dxDrawImage(screenX / 2 + x - 20, screenY / 2 + y - 20, 40, 40, ":sGui/" .. arrowIcon .. faTicks[arrowIcon], math.deg(r), 0, 0, c)
	local len = math.sqrt(x * x + y * y)
	x = x / len * (len - 28)
	y = y / len * (len - 28)
	dxDrawImage(screenX / 2 + x - s, screenY / 2 + y - s, s * 2, s * 2, ":sGui/" .. icon .. faTicks[icon], 0, 0, 0, c)
end
local blipElements = {}
local calculationsHandled = false
function render3DBlips()
	if not radarOn then
		return
	end
	if not initGui then
		return
	end
	if not calculationsHandled then
		px, py, pz = getElementPosition(targetPlayer)
		blipElements = getElementsByType("blip")
	end
	local camx, camy, camz, ctx, cty, ctz = getCameraMatrix()
	local r2 = math.atan2(camy - cty, camx - ctx) + math.pi / 2
	local shad = bitReplace(blipShadow, blips3dAlpha, 24, 8)
	for i = 1, #blipElements do
		local element = blipElements[i]
		if isElement(element) and not disableBlip3D[element] and not disableBlipSticky[element] then
			local icon = getBlipIcon(element)
			local x, y, z = getElementPosition(element)
			local r, g, b = getBlipColor(element)
			local dist = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
			if 1000 <= dist then
				dist = math.floor(dist / 1000 * 10) / 10 .. " km"
			else
				dist = math.ceil(dist) .. " m"
			end
			draw3DBlip(x, y, z, ctx, cty, r2, blipIcons[icon] and blipIcons[icon][1] or targetBlipIcon, tocolor(r, g, b, blips3dAlpha), shad, blipTooltips[element] and blipTooltips[element] .. "\n" .. dist or dist)
		end
	end
	for id, dat in pairs(markBlips) do
		local r, g, b = markBlipColor[1], markBlipColor[2], markBlipColor[3]
		local dist
		local z = pz
		if dat[3] then
			z = dat[3]
			dist = getDistanceBetweenPoints3D(px, py, pz, dat[1], dat[2], z)
		else
			local hit, hitX, hitY, hitZ = processLineOfSight(dat[1], dat[2], 3000, dat[1], dat[2], -3000, true, false, false, true, true)
			if hit then
				dat[3] = hitZ + 1
				z = dat[3]
				reSaveBlips()
				dist = getDistanceBetweenPoints3D(px, py, pz, dat[1], dat[2], z)
			else
				dist = getDistanceBetweenPoints2D(px, py, dat[1], dat[2])
			end
		end
		if 1000 <= dist then
			dist = math.floor(dist / 1000 * 10) / 10 .. " km"
		else
			dist = math.ceil(dist) .. " m"
		end
		draw3DBlip(dat[1], dat[2], z, ctx, cty, r2, blipIcons[17][1], tocolor(r, g, b, blips3dAlpha), shad, "Megjelölt pont\n" .. dist)
	end
end
local blips3dState = true
addEventHandler("onClientRender", getRootElement(), render3DBlips)
function set3DBlipState(state)
	if state ~= blips3dState then
		blips3dState = state
		if state then
			addEventHandler("onClientRender", getRootElement(), render3DBlips)
		else
			removeEventHandler("onClientRender", getRootElement(), render3DBlips)
		end
	end
end
function get3DBlipState()
	return blips3dState
end
function set3DBlipAlpha(alpha)
	blips3dAlpha = alpha
end
function get3DBlipAlpha()
	return blips3dAlpha
end
addCommandHandler("tog3dblip", function()
	local state = get3DBlipState()
	local newState = not state
	set3DBlipState(newState)
	sightexports.sDashboard:saveValue("radar3DBlipState", newState)
	outputChatBox("[color=sightblue][SightMTA - 3D Blip]: " .. (newState and "[color=sightgreen]Bekapcsoltad" or "[color=sightred]Kikapcsoltad") .. "#FFFFFF a 3D blipeket.", 255, 255, 255, true)
end)
function preRenderCalculations()
	px, py, pz = getElementPosition(targetPlayer)
	rx, ry, rz = getElementRotation(targetPlayer)
	if radarOn then
		blipElements = getElementsByType("blip")
		local j = 0
		for id, dat in pairs(markBlips) do
			j = j + 1
			local r, g, b = markBlipColor[1], markBlipColor[2], markBlipColor[3]
			if 0 < radarDamageLevel then
				r, g, b = interpolateBetween(r, g, b, radarBloodColor[1], radarBloodColor[2], radarBloodColor[3], radarDamageLevel, "InOutQuad")
			end
			blipDatas[j] = {
				dat[1],
				dat[2],
				blipIcons[17][1],
				blipIcons[17][2],
				tocolor(r, g, b),
				true,
				"Megjelölt pont",
				"target",
				17,
				id
			}
		end
		if showPlayers then
			local r, g, b = radarArrowColor[1], radarArrowColor[2], radarArrowColor[3]
			local r2, g2, b2 = radarArrowColorEx[1], radarArrowColorEx[2], radarArrowColorEx[3]
			local players = getElementsByType("player")
			for k, v in ipairs(players) do
				j = j + 1
				local x, y, z = getElementPosition(v)
				blipDatas[j] = {
					x,
					y,
					blipIcons[26][1],
					blipIcons[26][2],
					0 < getElementDimension(v) and tocolor(r2, g2, b2) or tocolor(r, g, b),
					false,
					tostring(getElementData(v, "visibleName")),
					"target",
					26,
					id
				}
			end
		end
		for k = 1, #blips + #blipElements do
			j = j + 1
			local data = false
			if k > #blips then
				local i = k - #blips
				local element = blipElements[i]
				local x, y = getElementPosition(element)
				local r, g, b = getBlipColor(element)
				if 0 < radarDamageLevel then
					r, g, b = interpolateBetween(r, g, b, radarBloodColor[1], radarBloodColor[2], radarBloodColor[3], radarDamageLevel, "InOutQuad")
				end
				local icon = getBlipIcon(element)
				blipDatas[j] = {
					x,
					y,
					blipIcons[icon] and blipIcons[icon][1] or targetBlipIcon,
					blipIcons[icon] and blipIcons[icon][2] or targetBlipSize,
					tocolor(r, g, b, targetBlipAlpha),
					true,
					icon == 17 and "Megjelölt pont" or blipTooltips[element],
					"target",
					icon
				}
			else
				blipDatas[j] = blips[k]
				local r, g, b = 255, 255, 255
				if 0 < radarDamageLevel then
					r, g, b = interpolateBetween(255, 255, 255, radarBloodColor[1], radarBloodColor[2], radarBloodColor[3], radarDamageLevel, "InOutQuad")
				end
				blipDatas[j][5] = tocolor(r, g, b)
			end
		end
		for k = j + 1, #blipDatas do
			blipDatas[k] = nil
		end
	end
end
function processCalculationHandling()
	local tmp = bigRadarState or widgetState
	if tmp ~= calculationsHandled then
		calculationsHandled = tmp
		if tmp then
			addEventHandler("onClientPreRender", getRootElement(), preRenderCalculations)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderCalculations)
		end
	end
end
function renderRadar()
	if not radarOn then
		return
	end
	lx, ly, lz = cx, cy, cz
	local rzc = radarZoom * speedZoom
	local pulse = getTickCount() % 1250 / 1250
	dxSetRenderTarget(baseRt, true)
	dxSetBlendMode("modulate_add")
	local playerRot = math.abs(360 - rz) + mapAngle - 90 - 180
	local mapAngleRad = math.rad(mapAngle + 90)
	local mapAngleCos = math.cos(mapAngleRad)
	local mapAngleSin = math.sin(mapAngleRad)
	local mapColor = tocolor(mapBackground[1], mapBackground[2], mapBackground[3])
	if 0 < radarDamageLevel then
		local r, g, b = interpolateBetween(mapBackground[1], mapBackground[2], mapBackground[3], radarBloodColor[1], radarBloodColor[2], radarBloodColor[3], radarDamageLevel, "InOutQuad")
		mapColor = tocolor(r, g, b)
	end
	if not bigRadarElement then
		dxDrawImageSection(radarInnerSize / 2 - rtSize / 2, radarInnerSize / 2 - rtSize / 2, rtSize, rtSize, radarTS * xf, radarTS * yf, xbs, ybs, radarPieceRT, mapAngle + 90, 0, 0, mapColor)
	end
	if isInNavi then
		sightexports.sGps:drawSmallRadarRoute(radarInnerSize / 2, rtSize, px, py, rzc, mapAngleSin, mapAngleCos)
	end
	local fx, fy = radarInnerSize / 2 - radarSizeX / 2, radarInnerSize / 2 - radarSizeY / 2
	local tx, ty = radarInnerSize / 2 + radarSizeX / 2, radarInnerSize / 2 + radarSizeY / 2
	local color = tocolor(r, g, b, targetBlipAlpha)
	for k = 1, #blipDatas do
		local id = blipDatas[k][11]
		if not id or usedTexIds[id] then
			local icon = blipDatas[k][9]
			if icon and icon ~= 26 then
				local x, y = blipDatas[k][1], blipDatas[k][2]
				local color = blipDatas[k][5]
				local pointX = x - px
				local pointY = py - y
				pointX = pointX / 6000 * 3072 * rzc
				pointY = pointY / 6000 * 3072 * rzc
				local x = pointX * mapAngleCos - pointY * mapAngleSin + radarInnerSize / 2
				local y = pointX * mapAngleSin + pointY * mapAngleCos + radarInnerSize / 2
				if blipIcons[icon] and blipIcons[icon][3] then
					local s = 325
					if blipIcons[icon][3] == true then
						s = 325
					elseif tonumber(blipIcons[icon][3]) then
						s = tonumber(blipIcons[icon][3])
					end
					if icon == 11 or icon == 12 then
						s = 250
					elseif icon == 22 or icon == 23 then
						s = 100
					end
					s = s / 6000 * 3072 * rzc
					local sc = s * 1.5
					if rectangleOverlap(x - sc / 2, y - sc / 2, x + sc / 2, y + sc / 2, fx, fy, tx, ty) then
						local p = pulse
						local s2 = s * (1 + 0.5 * p)
						local a = 0.5 * (1 - math.min(1, math.max(0, (p - 0.6) / 0.4)))
						dxDrawImage(x - s2 / 2, y - s2 / 2, s2, s2, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5 * a, 24, 8))
						local s2 = s * (1 + 0.5 * getEasingValue(p, "InQuad"))
						dxDrawImage(x - s2 / 2, y - s2 / 2, s2, s2, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5 * a, 24, 8))
						dxDrawImage(x - s / 2, y - s / 2, s, s, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5, 24, 8))
					end
				else
					local sc = targetBlipSize * 5
					if rectangleOverlap(x - sc / 2, y - sc / 2, x + sc / 2, y + sc / 2, fx, fy, tx, ty) then
						local p = pulse
						local s2 = targetBlipSize * (0.75 + 4.25 * p)
						local s3 = targetBlipSize * (0.75 + 4.25 * getEasingValue(p, "InQuad"))
						local a = 0.5 * (1 - math.min(1, math.max(0, (p - 0.6) / 0.4)))
						dxDrawImage(x - s2 / 2, y - s2 / 2, s2, s2, ":sGui/" .. targetBlipIcon .. (faTicks[targetBlipIcon] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * a, 24, 8))
						dxDrawImage(x - s3 / 2, y - s3 / 2, s3, s3, ":sGui/" .. targetBlipIcon .. (faTicks[targetBlipIcon] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * a, 24, 8))
					end
				end
			end
		end
	end
	local col = isInNavi and radarArrowColorEx or radarArrowColor
	local arrowColorR, arrowColorG, arrowColorB = col[1], col[2], col[3]
	if 0 < radarDamageLevel then
		arrowColorR, arrowColorG, arrowColorB = interpolateBetween(col[1], col[2], col[3], radarBloodColor[1], radarBloodColor[2], radarBloodColor[3], radarDamageLevel, "InOutQuad")
	end
	dxSetRenderTarget(playerRt, true)
	local a = math.min(1, math.abs(radarRot * (1 - radarZoomRot)) / 60)
	local s = 40 + 24 * a
	sightlangStaticImageUsed[0] = true
	if sightlangStaticImageToc[0] then
		processsightlangStaticImage[0]()
	end
	dxDrawImage(32 - s / 2, 32 - s / 2, s, s, sightlangStaticImage[0], playerRot, 0, 0, tocolor(0, 0, 0, 255 * (0.65 + 0.15 * a)))
	sightlangStaticImageUsed[1] = true
	if sightlangStaticImageToc[1] then
		processsightlangStaticImage[1]()
	end
	dxDrawImage(32 - s / 2, 32 - s / 2, s, s, sightlangStaticImage[1], playerRot, 0, 0, tocolor(arrowColorR, arrowColorG, arrowColorB, (1 - a) * 255))
	if 0 < a then
		sightlangStaticImageUsed[2] = true
		if sightlangStaticImageToc[2] then
			processsightlangStaticImage[2]()
		end
		dxDrawImage(32 - s / 2, 32 - s / 2, s, s, sightlangStaticImage[2], playerRot, 0, 0, tocolor(arrowColorR, arrowColorG, arrowColorB, math.min(1, a * 2) * 255))
	end
	dxSetRenderTarget(radarRt, true)
	dxDrawImage(radarSizeX / 2 - radarInnerSize / 2, radarSizeY / 2 - radarInnerSize / 2, radarInnerSize, radarInnerSize, baseShader)
	local cx, cy = radarSizeX / 2, radarSizeY / 2
	local stickyBlips = {}
	local blipZoom = (rzc - 1) * 0.5 + 1
	for k = 1, #blipDatas do
		local data = blipDatas[k]
		if data then
			local id = data[11]
			if not id or usedTexIds[id] then
				local pointX = data[1] - px
				local pointY = py - data[2]
				local size = rtSize / rzc
				if data[6] or math.abs(pointX) < size / 2 and math.abs(pointY) < size / 2 then
					pointX = pointX / 6000 * 3072 * rzc
					pointY = pointY / 6000 * 3072 * rzc
					local x = pointX * mapAngleCos - pointY * mapAngleSin
					local y = pointX * mapAngleSin + pointY * mapAngleCos
					local z = 0
					if radarRot * (1 - radarZoomRot) < 0 then
						x, y, z = rotate(x, y, z, 0, radarRot * (1 - radarZoomRot), 0)
						local ot = math.atan2(y, x)
						z = z + focal
						x, y = projection(x, y, z, radarInnerSize)
						if math.abs(math.atan2(y, x) - ot) >= math.pi then
							x, y = -x, -y
						end
					end
					local color = data[5]
					local s = data[4] * blipZoom / 2
					if data[6] and (y - s < -radarSizeY / 2 + radarBlur or y + s > radarSizeY / 2 - radarBlur or x - s < -radarSizeX / 2 + radarBlur or x + s > radarSizeX / 2 - radarBlur) then
						table.insert(stickyBlips, {
							x,
							y,
							data
						})
					elseif data[9] == 17 then
						local s2 = s * 2 * 0.6
						dxDrawImage(cx + x - s2 / 2, cy + y - s, s2, s2, ":sGui/" .. data[3] .. (faTicks[data[3]] or ""), 0, 0, 0, color)
					else
						dxDrawImage(cx + x - s, cy + y - s, s * 2, s * 2, ":sGui/" .. data[3] .. (faTicks[data[3]] or ""), 0, 0, 0, color)
					end
				end
			end
		end
	end
	dxDrawImage(cx - 32 * blipZoom, cy - 32 * blipZoom, 64 * blipZoom, 64 * blipZoom, playerShader)
	dxSetBlendMode("blend")
	dxSetRenderTarget()
	dxDrawImage(radarX - radarSizeX / 2, radarY - radarSizeY / 2, radarSizeX, radarSizeY, radarShader)
	dxSetBlendMode("modulate_add")
	for k = 1, #stickyBlips do
		local x, y = stickyBlips[k][1], stickyBlips[k][2]
		local data = stickyBlips[k][3]
		local color = data[5]
		local s = data[4] * blipZoom / 2
		if data[9] == 17 then
			local s2 = s * 2 * 0.6
			if x < -radarSizeX / 2 then
				x = -radarSizeX / 2
			elseif x > radarSizeX / 2 then
				x = radarSizeX / 2
			end
			y = y - s + s2 / 2
			if y < -radarSizeY / 2 then
				y = -radarSizeY / 2
			elseif y > radarSizeY / 2 then
				y = radarSizeY / 2
			end
			dxDrawImage(radarX + x - s2 / 2, radarY + y - s2 / 2, s2, s2, ":sGui/" .. data[3] .. (faTicks[data[3]] or ""), 0, 0, 0, color)
		else
			if x < -radarSizeX / 2 then
				x = -radarSizeX / 2
			elseif x > radarSizeX / 2 then
				x = radarSizeX / 2
			end
			if y < -radarSizeY / 2 then
				y = -radarSizeY / 2
			elseif y > radarSizeY / 2 then
				y = radarSizeY / 2
			end
			dxDrawImage(radarX + x - s, radarY + y - s, s * 2, s * 2, ":sGui/" .. data[3] .. (faTicks[data[3]] or ""), 0, 0, 0, color)
		end
	end
	dxSetBlendMode("blend")
end
addEvent("hudWidgetState:radar", true)
addEventHandler("hudWidgetState:radar", getRootElement(), function(state)
	if widgetState ~= state then
		widgetState = state
		processCalculationHandling()
		if widgetState then
			addEventHandler("onClientRender", getRootElement(), renderRadar)
			addEventHandler("onClientPreRender", getRootElement(), preRenderRadar)
			addEventHandler("onClientKey", getRootElement(), keyRadar)
		else
			removeEventHandler("onClientRender", getRootElement(), renderRadar)
			removeEventHandler("onClientPreRender", getRootElement(), preRenderRadar)
			removeEventHandler("onClientKey", getRootElement(), keyRadar)
		end
	end
end)
addEvent("hudWidgetPosition:radar", true)
addEventHandler("hudWidgetPosition:radar", getRootElement(), function(pos, final)
	widgetPos = pos
	radarX, radarY = widgetPos[1] + math.floor(radarSizeX / 2 + 0.5) - math.floor((radarSizeX - tmpRadarSizeX) / 2 + 0.5), widgetPos[2] + math.floor(radarSizeY / 2 + 0.5) - math.floor((radarSizeY - tmpRadarSizeY) / 2 + 0.5)
end)
addEvent("hudWidgetSize:radar", true)
addEventHandler("hudWidgetSize:radar", getRootElement(), function(size, final)
	tmpRadarSizeX, tmpRadarSizeY = size[1], size[2]
	if final then
		setRadarSize(size[1], size[2])
	end
	radarX, radarY = widgetPos[1] + math.floor(radarSizeX / 2 + 0.5) - math.floor((radarSizeX - tmpRadarSizeX) / 2 + 0.5), widgetPos[2] + math.floor(radarSizeY / 2 + 0.5) - math.floor((radarSizeY - tmpRadarSizeY) / 2 + 0.5)
end)
triggerEvent("requestWidgetDatas", localPlayer, "radar")
local zoneNamePos = {0, 0}
local zoneNameSize = {256, 256}
local zoneNameState = false
local zoneAlpha = 0
local zoneName = false
local zoneAnimation = false
function preRenderZoneName(delta)
	local x, y, z = getCameraMatrix(localPlayer)
	local zone = getZoneName(x, y, z, false)
	if zone ~= zoneName and zone ~= "Ismeretlen" then
		zoneName = zone
		zoneAnimation = getTickCount()
	end
	if zoneAnimation then
		if getTickCount() - zoneAnimation > 3500 then
			zoneAnimation = false
		end
		if zoneAlpha < 1 then
			zoneAlpha = zoneAlpha + delta / 1000 * 2
			if 1 < zoneAlpha then
				zoneAlpha = 1
			end
		end
	elseif 0 < zoneAlpha then
		zoneAlpha = zoneAlpha - delta / 1000 * 2
		if zoneAlpha < 0 then
			zoneAlpha = 0
		end
	end
end
function renderZoneName()
	if zoneName and 0 < zoneAlpha then
		dxDrawText(zoneName, zoneNamePos[1], zoneNamePos[2], zoneNamePos[1] + zoneNameSize[1], zoneNamePos[2] + zoneNameSize[2], tocolor(255, 255, 255, 174 * zoneAlpha), sweetSixteenScale, sweetSixteen, "center", "center")
	end
end

constantZoneNamePos = {}
constantZoneNameSize = {}

function renderConstantZoneName()
	local x, y, z = getCameraMatrix(localPlayer)
	local zone = getZoneName(x, y, z, false)
	if zone then
		dxDrawText(zone, constantZoneNamePos[1], constantZoneNamePos[2], constantZoneNamePos[1] + constantZoneNameSize[1], constantZoneNamePos[2] + constantZoneNameSize[2], tocolor(255, 255, 255, 174 * 1), sweetSixteenScale, sweetSixteen, "center", "center")
	end
end

addEvent("hudWidgetState:zoneName", true)
addEventHandler("hudWidgetState:zoneName", getRootElement(), function(state)
	if zoneNameState ~= state then
		zoneNameState = state
		zoneName = false
		zoneAlpha = 0
		if zoneNameState then
			addEventHandler("onClientRender", getRootElement(), renderZoneName)
			addEventHandler("onClientPreRender", getRootElement(), preRenderZoneName)
		else
			removeEventHandler("onClientRender", getRootElement(), renderZoneName)
			removeEventHandler("onClientPreRender", getRootElement(), preRenderZoneName)
		end
	end
end)
addEvent("hudWidgetPosition:zoneName", true)
addEventHandler("hudWidgetPosition:zoneName", getRootElement(), function(pos, final)
	zoneNamePos = pos
end)
addEvent("hudWidgetSize:zoneName", true)
addEventHandler("hudWidgetSize:zoneName", getRootElement(), function(size, final)
	zoneNameSize = size
end)
triggerEvent("requestWidgetDatas", localPlayer, "zoneName")

addEvent("hudWidgetState:constantZoneName", true)
addEventHandler("hudWidgetState:constantZoneName", getRootElement(), function(state)
	if constantZoneNameState ~= state then
		constantZoneNameState = state
		if constantZoneNameState then
			addEventHandler("onClientRender", getRootElement(), renderConstantZoneName)
		else
			removeEventHandler("onClientRender", getRootElement(), renderConstantZoneName)
		end
	end
end)
addEvent("hudWidgetPosition:constantZoneName", true)
addEventHandler("hudWidgetPosition:constantZoneName", getRootElement(), function(pos, final)
	constantZoneNamePos = pos
end)
addEvent("hudWidgetSize:constantZoneName", true)
addEventHandler("hudWidgetSize:constantZoneName", getRootElement(), function(size, final)
	constantZoneNameSize = size
end)
triggerEvent("requestWidgetDatas", localPlayer, "constantZoneName")

local bigShaderRaw = " texture texture0; float percX; float percY; float sx; float sy; float mainAlpha; sampler implicitInputTexture = sampler_state { Texture = <texture0>; }; float4 MaskTextureMain( float2 uv : TEXCOORD0 ) : COLOR0 { float4 sampledTexture = tex2D( implicitInputTexture, uv ); float x = uv.x/sx; float y = uv.y/sy; sampledTexture.a = sampledTexture.a*min(1, min(min(x*percX, y*percY), min((1-x)*percX, (1-y)*percY))) * mainAlpha; return sampledTexture; } technique Technique0 { pass Pass0 { PixelShader = compile ps_2_0 MaskTextureMain(); } } "
local bigRt = false
local bigShader = false
local bigOpened = false
local bigOpenedTick = 0
local bigOpenedTime = 0
local markBlipHover = false
local legendHover = false
local legendOffset = 0
local blipGroupStates = {}
local bigRadarPosition = false
local bigRadarDrag = false
local maxHoverZoom = 0.15
local hoverZoom = 0
local miniHoverState = false
local mainAlpha = 200
local bigSX, bigSY = 0, 0
local teleportToTimer = false
function clickBigRadar(btn, state, x, y)
	if bigOpened and getTickCount() - bigOpenedTick > bigOpenedTime and not legendHover and state == "up" and radarOn and x >= bigRadarPos[1] and y >= bigRadarPos[2] and x <= bigRadarPos[1] + bigSX and y <= bigRadarPos[2] + bigSY then
		if btn == "right" then
			local el = markBlips[markBlipHover]
			if markBlips[markBlipHover] then
				markBlips[markBlipHover] = nil
				reSaveBlips()
			else
				local id = 0
				while true do
					id = id + 1
					if not markBlips[id] then
						break
					end
				end
				local opx, opy, pz = getElementPosition(targetPlayer)
				if bigRadarPosition then
					opx, opy = bigRadarPosition[1], bigRadarPosition[2]
				end
				local cx = bigRadarPos[1] + bigSX / 2
				local cy = bigRadarPos[2] + bigSY / 2
				local x = (x - cx) * 6000 / 3072 / (bigZoom + hoverZoom) + opx
				local y = (cy - y) * 6000 / 3072 / (bigZoom + hoverZoom) + opy
				markBlips[id] = {x, y}
				local file = false
				if fileExists("!sRadar_marks.sight") then
					file = fileOpen("!sRadar_marks.sight")
					fileSetPos(file, fileGetSize(file))
				else
					file = fileCreate("!sRadar_marks.sight")
				end
				fileWrite(file, x .. "," .. y .. "\n")
				fileClose(file)
			end
		elseif btn == "middle" and sightexports.sPermission:hasPermission(localPlayer, "scrollTeleport") and not isPedInVehicle(localPlayer) and 0 >= getElementInterior(localPlayer) then
			local opx, opy, pz = getElementPosition(localPlayer)
			if bigRadarPosition then
				opx, opy = bigRadarPosition[1], bigRadarPosition[2]
			end
			local cx = bigRadarPos[1] + bigSX / 2
			local cy = bigRadarPos[2] + bigSY / 2
			local x = (x - cx) * 6000 / 3072 / (bigZoom + hoverZoom) + opx
			local y = (cy - y) * 6000 / 3072 / (bigZoom + hoverZoom) + opy
			teleportTo(x, y, 0, 0)
		end
	end
end
function reSaveBlips()
	if fileExists("!sRadar_marks.sight") then
		fileDelete("!sRadar_marks.sight")
	end
	local file = fileCreate("!sRadar_marks.sight")
	for id, dat in pairs(markBlips) do
		if dat[3] then
			fileWrite(file, dat[1] .. "," .. dat[2] .. "," .. dat[3] .. "\n")
		else
			fileWrite(file, dat[1] .. "," .. dat[2] .. "\n")
		end
	end
	fileClose(file)
end
local endNaviHover = false
function teleportTo(x, y, z, i)
	local hit, hitX, hitY, hitZ = processLineOfSight(x, y, 3000, x, y, -3000, true, false, false, true, true)
	if isTimer(teleportToTimer) then
		killTimer(teleportToTimer)
	end
	teleportToTimer = false
	if hit or 200 <= i then
		setElementPosition(localPlayer, x, y, hitZ + 1)
	else
		setElementPosition(localPlayer, x, y, z)
		teleportToTimer = setTimer(teleportTo, 50, 1, x, y, z + 0.25, i + 1)
	end
end
function doubleClickBig(btn, x, y)
	if btn == "left" and bigOpened and getTickCount() - bigOpenedTick > bigOpenedTime and not legendHover and veh and radarOn and x >= bigRadarPos[1] and y >= bigRadarPos[2] and x <= bigRadarPos[1] + bigSX and y <= bigRadarPos[2] + bigSY then
		local vt = getVehicleType(veh)
		if vt == "Automobile" or vt == "Quad" or vt == "Bike" then
			if endNaviHover then
				sightexports.sGps:navigateToCoords()
			else
				local opx, opy, pz = getElementPosition(localPlayer)
				if bigRadarPosition then
					opx, opy = bigRadarPosition[1], bigRadarPosition[2]
				end
				local cx = bigRadarPos[1] + bigSX / 2
				local cy = bigRadarPos[2] + bigSY / 2
				local x = (x - cx) * 6000 / 3072 / (bigZoom + hoverZoom) + opx
				local y = (cy - y) * 6000 / 3072 / (bigZoom + hoverZoom) + opy
				sightexports.sGps:navigateToCoords(x, y)
			end
		end
	end
end
function keyBig(key, por)
	if key == "mouse1" and por and legendHover and radarOn then
		blipGroups[legendHover][4] = not blipGroups[legendHover][4]
		blipGroupStates[blipGroups[legendHover][5]] = blipGroups[legendHover][4]
		sightexports.sGui:showTooltip("Kattints az ikonok " .. (blipGroups[legendHover][4] and "megjelenítéshez" or "eltüntetéshez"))
	elseif key == "mouse_wheel_up" or key == "mouse_wheel_down" and not getKeyState("mouse1") and radarOn then
		local cx, cy = getCursorPosition()
		if cx and bigRadarPos and bigRadarSize then
			cx = cx * screenX
			cy = cy * screenY
			if cx >= bigRadarPos[1] and cy >= bigRadarPos[2] and cx <= bigRadarPos[1] + bigRadarSize[1] and cy <= bigRadarPos[2] + bigRadarSize[2] then
				if legendHover then
					if key == "mouse_wheel_down" then
						if legendOffset < #blipGroups - 10 then
							legendOffset = legendOffset + 1
						end
					elseif key == "mouse_wheel_up" and 0 < legendOffset then
						legendOffset = legendOffset - 1
					end
				elseif key == "mouse_wheel_down" then
					bigZoom = bigZoom - 0.065
					if bigZoom < 0.3 then
						bigZoom = 0.3
					end
				elseif key == "mouse_wheel_up" then
					bigZoom = bigZoom + 0.065
					if 1.5 < bigZoom then
						bigZoom = 1.5
					end
				end
			end
		end
	end
end
function preRenderBigRadar(delta)
	if miniHoverState then
		if hoverZoom < maxHoverZoom then
			hoverZoom = hoverZoom + maxHoverZoom * delta / 1000
			if hoverZoom > maxHoverZoom then
				hoverZoom = maxHoverZoom
			end
		end
	elseif 0 < hoverZoom then
		hoverZoom = hoverZoom - maxHoverZoom * delta / 1000
		if hoverZoom < 0 then
			hoverZoom = 0
		end
	end
	local tmp = 155
	if getTickCount() - bigOpenedTick <= bigOpenedTime then
		if not bigOpened then
			tmp = 255 - 100 * (getTickCount() - bigOpenedTick) / bigOpenedTime
		else
			tmp = 155 + 100 * (getTickCount() - bigOpenedTick) / bigOpenedTime
		end
	elseif bigOpened then
		tmp = 255
	end
	if not bigOpened or getTickCount() - bigOpenedTick <= bigOpenedTime then
		tmp = math.min(255, tmp + 100 * (hoverZoom / maxHoverZoom))
	end
	if tmp ~= mainAlpha then
		mainAlpha = tmp
		dxSetShaderValue(bigShader, "mainAlpha", mainAlpha / 255)
	end
	local opx, opy, pz = getElementPosition(targetPlayer)
	if bigRadarPosition then
		opx, opy = bigRadarPosition[1], bigRadarPosition[2]
	end
	bigSX, bigSY = sightexports.sGui:getGuiSize(bigRadarElement)
	radarPieceZoom = bigZoom + hoverZoom
	radarPX, radarPY = opx, opy
	radarSX, radarSY = bigSX, bigSY
end
function renderBigRadar()
	if not radarOn then
		bigRadarDrag = false
		legendHover = false
		endNaviHover = false
		markBlipHover = false
		return
	end
	local opx, opy = px, py
	local playerX, playerY = opx, opy
	if bigRadarPosition then
		opx, opy = bigRadarPosition[1], bigRadarPosition[2]
	end
	local cursorX, cursorY = getCursorPosition()
	local x, y = sightexports.sGui:getGuiPosition(bigRadarElement)
	bigRadarPos = {x, y}
	if cursorX then
		cursorX = cursorX * screenX - x
		cursorY = cursorY * screenY - y
	end
	local sx, sy = bigSX, bigSY
	miniHoverState = false
	if not bigOpened and cursorX and 0 < cursorX and 0 < cursorY and cursorX < sx and cursorY < sy then
		miniHoverState = true
	end
	if bigOpened and getTickCount() - bigOpenedTick > bigOpenedTime and not legendHover then
		local cx, cy = cursorX, cursorY
		if cx then
			if getKeyState("mouse1") then
				if not bigRadarDrag then
					bigRadarDrag = {
						cx,
						cy,
						opx,
						opy
					}
				end
				if not bigRadarPosition and (math.abs(bigRadarDrag[1] - cx) > 3 or math.abs(cy - bigRadarDrag[2]) > 3) then
					bigRadarPosition = {}
				end
				if bigRadarPosition then
					bigRadarPosition[1] = (bigRadarDrag[1] - cx) * 6000 / 3072 / (bigZoom + hoverZoom) + bigRadarDrag[3]
					bigRadarPosition[2] = (cy - bigRadarDrag[2]) * 6000 / 3072 / (bigZoom + hoverZoom) + bigRadarDrag[4]
					if bigRadarPosition[1] < -4500 then
						bigRadarPosition[1] = -4500
					end
					if bigRadarPosition[1] > 4500 then
						bigRadarPosition[1] = 4500
					end
					if bigRadarPosition[2] < -4500 then
						bigRadarPosition[2] = -4500
					end
					if bigRadarPosition[2] > 4500 then
						bigRadarPosition[2] = 4500
					end
				end
			else
				bigRadarDrag = false
			end
		end
	end
	if bigRadarPosition and not bigRadarDrag and getKeyState("space") then
		bigRadarPosition = false
	end
	if sx ~= bigRadarSize[1] or sy ~= bigRadarSize[2] then
		bigRadarSize = {sx, sy}
		dxSetShaderValue(bigShader, "percX", 100 / (radarBlur / bigRadarSize[1] * 100))
		dxSetShaderValue(bigShader, "percY", 100 / (radarBlur / bigRadarSize[2] * 100))
		dxSetShaderValue(bigShader, "sx", bigRadarSize[1] / screenX)
		dxSetShaderValue(bigShader, "sy", bigRadarSize[2] / screenY)
	end
	local cx = sx / 2
	local cy = sy / 2
	local rtx = sx / (bigZoom + hoverZoom)
	local rty = sy / (bigZoom + hoverZoom)
	local rx, ry, rz = getElementRotation(localPlayer)
	dxSetRenderTarget(bigRt, true)
	dxSetBlendMode("modulate_add")
	dxDrawImageSection(0, 0, sx, sy, radarTS * xf, radarTS * yf, xbs, ybs, radarPieceRT, 0, 0, 0, tocolor(mapBackground[1], mapBackground[2], mapBackground[3]))
	local naviHover = false
	if isInNavi then
		if not bigRadarDrag then
			naviHover = sightexports.sGps:drawBigRadar(cx, cy, sx, sy, opx, opy, bigZoom + hoverZoom, cursorX, cursorY)
		else
			sightexports.sGps:drawBigRadar(cx, cy, sx, sy, opx, opy, bigZoom + hoverZoom)
		end
	end
	local bigBlipZoom = (bigZoom + hoverZoom) * 0.35 + 0.85
	local pulse = getTickCount() % 1250 / 1250
	local tooltips = {}
	local tmpMark = false
	for k = 1, #blipDatas do
		local data = blipDatas[k]
		if data then
			local id = data[11]
			if not id or usedTexIds[id] then
				local pointX = data[1] - opx
				local pointY = opy - data[2]
				if not blipGroupStates[data[8]] and math.abs(pointX) < rtx * 1.5 and math.abs(pointY) < rty * 1.5 then
					pointX = pointX / 6000 * 3072 * (bigZoom + hoverZoom)
					pointY = pointY / 6000 * 3072 * (bigZoom + hoverZoom)
					local x = pointX
					local y = pointY
					local color = data[5]
					if legendHover and blipGroups[legendHover][5] ~= data[8] then
						color = bitReplace(color, bitExtract(color, 24, 8) * 0.5, 24, 8)
					end
					if data[9] == 11 or data[9] == 12 then
						local p = pulse
						local s = 128 * (bigZoom + hoverZoom)
						local s2 = s * (1 + 0.5 * p)
						local a = 0.5 * (1 - math.min(1, math.max(0, (p - 0.6) / 0.4)))
						dxDrawImage(cx + x - s2 / 2, cy + y - s2 / 2, s2, s2, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5 * a, 24, 8))
						local s2 = s * (1 + 0.5 * getEasingValue(p, "InQuad"))
						dxDrawImage(cx + x - s2 / 2, cy + y - s2 / 2, s2, s2, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5 * a, 24, 8))
						dxDrawImage(cx + x - s / 2, cy + y - s / 2, s, s, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5, 24, 8))
						dxDrawImage(cx + x - data[4] * bigBlipZoom / 2, cy + y - data[4] * bigBlipZoom / 2, data[4] * bigBlipZoom, data[4] * bigBlipZoom, ":sGui/" .. data[3] .. (faTicks[data[3]] or ""), 0, 0, 0, color)
					elseif data[9] == 22 or data[9] == 23 then
						local p = pulse
						local s = 51.2 * (bigZoom + hoverZoom)
						local s2 = s * (1 + 0.5 * p)
						local a = 0.5 * (1 - math.min(1, math.max(0, (p - 0.6) / 0.4)))
						dxDrawImage(cx + x - s2 / 2, cy + y - s2 / 2, s2, s2, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5 * a, 24, 8))
						local s2 = s * (1 + 0.5 * getEasingValue(p, "InQuad"))
						dxDrawImage(cx + x - s2 / 2, cy + y - s2 / 2, s2, s2, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5 * a, 24, 8))
						dxDrawImage(cx + x - s / 2, cy + y - s / 2, s, s, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5, 24, 8))
						dxDrawImage(cx + x - data[4] * bigBlipZoom / 2, cy + y - data[4] * bigBlipZoom / 2, data[4] * bigBlipZoom, data[4] * bigBlipZoom, ":sGui/" .. data[3] .. (faTicks[data[3]] or ""), 0, 0, 0, color)
					elseif data[9] == 26 then
						dxDrawImage(cx + x - data[4] * bigBlipZoom / 2, cy + y - data[4] * bigBlipZoom / 2, data[4] * bigBlipZoom, data[4] * bigBlipZoom, ":sGui/" .. data[3] .. (faTicks[data[3]] or ""), 0, 0, 0, color)
					elseif data[9] == 8 then
						local p = pulse
						local s = 166.4 * (bigZoom + hoverZoom)
						local s2 = s * (1 + 0.5 * p)
						local a = 0.5 * (1 - math.min(1, math.max(0, (p - 0.6) / 0.4)))
						dxDrawImage(cx + x - s2 / 2, cy + y - s2 / 2, s2, s2, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5 * a, 24, 8))
						local s2 = s * (1 + 0.5 * getEasingValue(p, "InQuad"))
						dxDrawImage(cx + x - s2 / 2, cy + y - s2 / 2, s2, s2, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5 * a, 24, 8))
						dxDrawImage(cx + x - s / 2, cy + y - s / 2, s, s, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5, 24, 8))
						dxDrawImage(cx + x - data[4] * bigBlipZoom / 2, cy + y - data[4] * bigBlipZoom / 2, data[4] * bigBlipZoom, data[4] * bigBlipZoom, ":sGui/" .. data[3] .. (faTicks[data[3]] or ""), 0, 0, 0, color)
					elseif data[9] == 31 then
						local p = pulse
						local s = 325 * (bigZoom + hoverZoom)
						local s2 = s * (1 + 0.5 * p)
						local a = 0.5 * (1 - math.min(1, math.max(0, (p - 0.6) / 0.4)))
						dxDrawImage(cx + x - s2 / 2, cy + y - s2 / 2, s2, s2, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5 * a, 24, 8))
						local s2 = s * (1 + 0.5 * getEasingValue(p, "InQuad"))
						dxDrawImage(cx + x - s2 / 2, cy + y - s2 / 2, s2, s2, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5 * a, 24, 8))
						dxDrawImage(cx + x - s / 2, cy + y - s / 2, s, s, ":sGui/" .. bigCircle1 .. (faTicks[bigCircle1] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * 0.5, 24, 8))
						dxDrawImage(cx + x - data[4] * bigBlipZoom / 2, cy + y - data[4] * bigBlipZoom / 2, data[4] * bigBlipZoom, data[4] * bigBlipZoom, ":sGui/" .. data[3] .. (faTicks[data[3]] or ""), 0, 0, 0, color)
					elseif data[9] == 17 then
						local p = pulse
						local s2 = targetBlipSize * (0.75 + 4.25 * p)
						local a = 0.5 * (1 - math.min(1, math.max(0, (p - 0.6) / 0.4)))
						dxDrawImage(cx + x - s2 * bigBlipZoom / 2, cy + y - s2 * bigBlipZoom / 2, s2 * bigBlipZoom, s2 * bigBlipZoom, ":sGui/" .. targetBlipIcon .. (faTicks[targetBlipIcon] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * a, 24, 8))
						local s2 = targetBlipSize * (0.75 + 4.25 * getEasingValue(p, "InQuad"))
						dxDrawImage(cx + x - s2 * bigBlipZoom / 2, cy + y - s2 * bigBlipZoom / 2, s2 * bigBlipZoom, s2 * bigBlipZoom, ":sGui/" .. targetBlipIcon .. (faTicks[targetBlipIcon] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * a, 24, 8))
						local s2 = data[4] * bigBlipZoom * 0.6
						dxDrawImage(cx + x - s2 / 2, cy + y - data[4] * bigBlipZoom / 2, s2, s2, ":sGui/" .. data[3] .. (faTicks[data[3]] or ""), 0, 0, 0, color)
					elseif data[9] then
						local p = pulse
						local s2 = targetBlipSize * (0.75 + 4.25 * p)
						local a = 0.5 * (1 - math.min(1, math.max(0, (p - 0.6) / 0.4)))
						dxDrawImage(cx + x - s2 * bigBlipZoom / 2, cy + y - s2 * bigBlipZoom / 2, s2 * bigBlipZoom, s2 * bigBlipZoom, ":sGui/" .. targetBlipIcon .. (faTicks[targetBlipIcon] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * a, 24, 8))
						local s2 = targetBlipSize * (0.75 + 4.25 * getEasingValue(p, "InQuad"))
						dxDrawImage(cx + x - s2 * bigBlipZoom / 2, cy + y - s2 * bigBlipZoom / 2, s2 * bigBlipZoom, s2 * bigBlipZoom, ":sGui/" .. targetBlipIcon .. (faTicks[targetBlipIcon] or ""), 0, 0, 0, bitReplace(color, bitExtract(color, 24, 8) * a, 24, 8))
						dxDrawImage(cx + x - data[4] * bigBlipZoom / 2, cy + y - data[4] * bigBlipZoom / 2, data[4] * bigBlipZoom, data[4] * bigBlipZoom, ":sGui/" .. data[3] .. (faTicks[data[3]] or ""), 0, 0, 0, color)
					else
						dxDrawImage(cx + x - data[4] * bigBlipZoom / 2, cy + y - data[4] * bigBlipZoom / 2, data[4] * bigBlipZoom, data[4] * bigBlipZoom, ":sGui/" .. data[3] .. (faTicks[data[3]] or ""), 0, 0, 0, color)
					end
					if data[7] and not tmpMark and (legendHover and blipGroups[legendHover][5] == data[8] or cursorX and cursorX >= cx + x - (data[9] == 17 and 0.6 or 1) * data[4] * bigBlipZoom / 2 and cursorY >= cy + y - data[4] * bigBlipZoom / 2 and cursorX <= cx + x + (data[9] == 17 and 0.6 or 1) * data[4] * bigBlipZoom / 2 and cursorY <= cy + y + data[4] * bigBlipZoom / (data[9] == 17 and 4 or 2)) then
						local w = dxGetTextWidth(data[7], bigRadarFontScale, bigRadarFont) + 8
						local h = bigRadarFontH + 8
						local x = cx + x
						local y = cy + y + h * 0.5
						if data[9] == 17 then
							y = y + 4
						else
							y = y + data[4] * bigBlipZoom / 2
						end
						table.insert(tooltips, {
							x,
							y,
							w,
							h,
							data[7],
							data[10]
						})
						if not legendHover then
							tmpMark = data[10]
						end
					end
				end
			end
		end
	end
	for i = 1, #tooltips do
		if not tmpMark or tmpMark == tooltips[i][6] then
			local x, y, w, h, text = tooltips[i][1], tooltips[i][2], tooltips[i][3], tooltips[i][4], tooltips[i][5]
			dxDrawRectangle(x - w / 2, y - h / 2, w, h, bigRadarLegendColor)
			dxDrawText(text, x, y, x, y, tocolor(255, 255, 255, bigAlpha), bigRadarFontScale, bigRadarFont, "center", "center")
		end
	end
	local pointX = (playerX - opx) / 6000 * 3072 * (bigZoom + hoverZoom)
	local pointY = (opy - playerY) / 6000 * 3072 * (bigZoom + hoverZoom)
	sightlangStaticImageUsed[0] = true
	if sightlangStaticImageToc[0] then
		processsightlangStaticImage[0]()
	end
	dxDrawImage(cx + pointX - 20.5, cy + pointY - 21.5, 41, 43, sightlangStaticImage[0], 360 - rz, 0, 0, tocolor(0, 0, 0, 153))
	local col = isInNavi and radarArrowColorEx or radarArrowColor
	sightlangStaticImageUsed[1] = true
	if sightlangStaticImageToc[1] then
		processsightlangStaticImage[1]()
	end
	dxDrawImage(cx + pointX - 20.5, cy + pointY - 21.5, 41, 43, sightlangStaticImage[1], 360 - rz, 0, 0, tocolor(col[1], col[2], col[3]))
	local bigAlpha = 0
	local grey = bigRadarLegendColor
	if getTickCount() - bigOpenedTick <= bigOpenedTime then
		if bigOpened then
			bigAlpha = 255 * (getTickCount() - bigOpenedTick) / bigOpenedTime
		else
			bigAlpha = 255 - 255 * (getTickCount() - bigOpenedTick) / bigOpenedTime
		end
		grey = bitReplace(bigRadarLegendColor, bitExtract(bigRadarLegendColor, 24, 8) * bigAlpha / 255, 24, 8)
	elseif bigOpened then
		bigAlpha = 255
	end
	if 0 < bigAlpha then
		local zone = getZoneName(opx, opy, pz)
		for x = -1, 1, 2 do
			for y = -1, 1, 2 do
				dxDrawText(zone, 0, 0, sx - 32 + x, sy - 16 + y, tocolor(0, 0, 0, bigAlpha * 0.75), sweetSixteenScale, sweetSixteen, "right", "bottom")
			end
		end
		dxDrawText(zone, 0, 0, sx - 32 + 3, sy - 16 + 3, tocolor(0, 0, 0, bigAlpha * 0.75), sweetSixteenScale, sweetSixteen, "right", "bottom")
		dxDrawText(zone, 0, 0, sx - 32, sy - 16, tocolor(255, 255, 255, bigAlpha), sweetSixteenScale, sweetSixteen, "right", "bottom")
	end
	local h = bigRadarFontH + 8
	if 0 < bigAlpha then
		local y = sy - 32
		if bigRadarPosition then
			local w = dxGetTextWidth("A nézet visszaállításához nyomd meg a 'SPACE' gombot", bigRadarFontScale, bigRadarFont) + 8
			dxDrawRectangle(sx / 2 - w / 2, y - h / 2, w, h, grey)
			dxDrawText("A nézet visszaállításához nyomd meg a 'SPACE' gombot", 0, y, sx, y, tocolor(255, 255, 255, bigAlpha), bigRadarFontScale, bigRadarFont, "center", "center")
			y = y - h - 8
		end
		if not isInNavi and veh then
			local vt = getVehicleType(veh)
			if vt == "Automobile" or vt == "Quad" or vt == "Bike" then
				local w = dxGetTextWidth("Duplakattintás az úticél kiválasztásához", bigRadarFontScale, bigRadarFont) + 8
				dxDrawRectangle(sx / 2 - w / 2, y - h / 2, w, h, grey)
				dxDrawText("Duplakattintás az úticél kiválasztásához", 0, y, sx, y, tocolor(255, 255, 255, bigAlpha), bigRadarFontScale, bigRadarFont, "center", "center")
			end
		end
	end
	local tmp = false
	if 0 < bigAlpha then
		local w = blipGroupsWidth + 8 + h + 4 + 2
		local x = sx - w - radarBlur
		local y = radarBlur
		local cx, cy = cursorX, cursorY
		for k = 1, 10 do
			if cx and x <= cx and cx <= x + w and y <= cy and cy <= y + h and getTickCount() - bigOpenedTick > bigOpenedTime then
				dxDrawRectangle(x, y, w, h, bitReplace(bigRadarLegendScrollColor[2], bigAlpha, 24, 8))
				tmp = k + legendOffset
			else
				dxDrawRectangle(x, y, w, h, grey)
			end
			local a = blipGroups[k + legendOffset][4] and 0.15 or 1
			dxDrawImage(x, y, h, h, ":sGui/" .. blipGroups[k + legendOffset][1] .. (faTicks[blipGroups[k + legendOffset][1]] or ""), 0, 0, 0, tocolor(255, 255, 255, bigAlpha * a))
			dxDrawText(blipGroups[k + legendOffset][2], x + h + 4, y, 0, y + h, tocolor(255, 255, 255, bigAlpha * a), bigRadarFontScale, bigRadarFont, "left", "center")
			y = y + h
		end
		y = radarBlur
		dxDrawRectangle(x + w - 2, y, 2, h * 10, bitReplace(bigRadarLegendScrollColor[2], bigAlpha, 24, 8))
		local oh = h * 10 / (#blipGroups - 10 + 1)
		dxDrawRectangle(x + w - 2, y + oh * legendOffset, 2, oh, bitReplace(bigRadarLegendScrollColor[1], bigAlpha, 24, 8))
	end
	local tmpNavi = false
	if not tmp and not tmpMark then
		tmpNavi = naviHover
	end
	if tmp ~= legendHover or tmpNavi ~= endNaviHover or tmpMark ~= markBlipHover then
		legendHover = tmp
		endNaviHover = tmpNavi
		markBlipHover = tmpMark
		sightexports.sGui:setCursorType((legendHover or endNaviHover or markBlipHover) and "link" or "normal")
		if endNaviHover then
			sightexports.sGui:showTooltip("Duplakattintás az úticél törléséhez")
		elseif legendHover then
			sightexports.sGui:showTooltip("Kattints az ikonok " .. (blipGroups[legendHover][4] and "megjelenítéshez" or "eltüntetéshez"))
		else
			sightexports.sGui:showTooltip(false)
		end
	end
	if bigRadarPosition then
		sightlangStaticImageUsed[3] = true
		if sightlangStaticImageToc[3] then
			processsightlangStaticImage[3]()
		end
		dxDrawImage(cx - 128, cy - 128, 256, 256, sightlangStaticImage[3])
	end
	dxSetBlendMode("blend")
	dxSetRenderTarget()
end
function setBigRadarOpened(opened, time)
	bigOpened = opened
	bigOpenedTick = getTickCount()
	bigOpenedTime = time
end
function setBigRadarElement(element)
	if bigRadarElement ~= element then
		bigRadarElement = element
		if bigRadarElement then
			if not bigRadarState then
				bigRadarState = true
				processCalculationHandling()
				bigRadarPos = {400, 400}
				bigRadarSize = {256, 256}
				bigRt = dxCreateRenderTarget(screenX, screenY, true)
				bigShader = dxCreateShader(bigShaderRaw)
				dxSetShaderValue(bigShader, "texture0", bigRt)
				dxSetShaderValue(bigShader, "percX", 100 / (radarBlur / bigRadarSize[1] * 100))
				dxSetShaderValue(bigShader, "percY", 100 / (radarBlur / bigRadarSize[2] * 100))
				dxSetShaderValue(bigShader, "sx", bigRadarSize[1] / screenX)
				dxSetShaderValue(bigShader, "sy", bigRadarSize[2] / screenY)
				dxSetShaderValue(bigShader, "mainAlpha", mainAlpha / 255)
				addEventHandler("onClientRender", getRootElement(), renderBigRadar, true, "low-999999")
				addEventHandler("onClientPreRender", getRootElement(), preRenderBigRadar)
				addEventHandler("onClientKey", getRootElement(), keyBig)
				addEventHandler("onClientDoubleClick", getRootElement(), doubleClickBig)
				addEventHandler("onClientClick", getRootElement(), clickBigRadar)
			end
		elseif bigRadarState then
			bigRadarState = false
			processCalculationHandling()
			if isElement(bigRt) then
				destroyElement(bigRt)
			end
			bigRt = false
			if isElement(bigShader) then
				destroyElement(bigShader)
			end
			bigShader = false
			removeEventHandler("onClientRender", getRootElement(), renderBigRadar, true, "low-999999")
			removeEventHandler("onClientPreRender", getRootElement(), preRenderBigRadar)
			removeEventHandler("onClientKey", getRootElement(), keyBig)
			removeEventHandler("onClientDoubleClick", getRootElement(), doubleClickBig)
			removeEventHandler("onClientClick", getRootElement(), clickBigRadar)
			sightexports.sGui:showTooltip(false)
		end
	end
	return bigShader
end
local secondaryRadarTextures = {}
for i = 1, #renderSizes - 1 do
	secondaryRadarTextures[renderSizes[i]] = {}
end
local usedSecondaryTextures = {}
local secondaryRendering = false
function processSecondaryTextures()
	for id, ts in pairs(usedSecondaryTextures) do
		if not isElement(secondaryRadarTextures[ts][id]) then
			secondaryRadarTextures[ts][id] = dxCreateTexture("files/tex/sight/" .. ts .. "/" .. id .. ".dds", "dxt5", false)
			usedSecondaryTextures = {}
			return
		end
	end
	for i = 1, #renderSizes - 1 do
		for id in pairs(secondaryRadarTextures[renderSizes[i]]) do
			if usedSecondaryTextures[id] ~= renderSizes[i] then
				if isElement(secondaryRadarTextures[renderSizes[i]][id]) then
					destroyElement(secondaryRadarTextures[renderSizes[i]][id])
				end
				secondaryRadarTextures[renderSizes[i]][id] = nil
				usedSecondaryTextures = {}
				return
			end
		end
	end
	usedSecondaryTextures = {}
	if not secondaryRendering then
		sightlangCondHandl0(false)
	end
	secondaryRendering = false
end
function getSecondaryTs(ts, id)
	local tex = radarBlocks[32][id]
	local rts = 32
	if ts <= 32 then
		return tex, rts
	end
	if radarBlocks[ts][id] then
		tex = radarBlocks[ts][id]
		rts = ts
	else
		usedSecondaryTextures[id] = ts
		if secondaryRadarTextures[ts][id] then
			tex = secondaryRadarTextures[ts][id]
			rts = ts
		end
	end
	return tex, rts
end
function drawSecondaryRadar(ix, iy, sx, sy, rx, ry, rz, fadeAlpha)
	secondaryRendering = true
	sightlangCondHandl0(true)
	local gx = ix + sx / 2
	local gy = iy + sy / 2
	local cx = ix + sx
	local cy = iy + sy
	local ts = getTSSize(rz)
	local idX, idY, xf, yf = coordToTex(rx, ry)
	local nx = math.ceil(sx / rz / 2)
	local ny = math.ceil(sy / rz / 2)
	for x = -nx, nx do
		for y = -ny, ny do
			local id = toValidId(idX + x, idY + y)
			if id then
				local dx, dy = math.floor(gx + (x - xf) * rz), math.floor(gy + (y - yf) * rz)
				if ix <= dx and iy <= dy and cx >= dx + rz and cy >= dy + rz then
					local tex = getSecondaryTs(ts, id)
					dxDrawImage(dx, dy, rz, rz, tex)
				elseif ix <= dx + rz and iy <= dy + rz and cx >= dx and cy >= dy then
					local tex, rts = getSecondaryTs(ts, id)
					local marginX = -math.min(0, dx - ix)
					local marginY = -math.min(0, dy - iy)
					local cropX = rz - math.max(0, dx + rz - cx) - marginX
					local cropY = rz - math.max(0, dy + rz - cy) - marginY
					dxDrawImageSection(math.max(ix, dx), math.max(iy, dy), cropX, cropY, marginX / rz * rts, marginY / rz * rts, cropX / rz * rts, cropY / rz * rts, tex)
				end
			end
		end
	end
end
