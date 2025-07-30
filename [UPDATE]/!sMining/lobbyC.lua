screenX, screenY = guiGetScreenSize()

local function decodeAndProcess(inputString, keyByte, offsetByte)
	if inputString and keyByte and offsetByte then
		inputString = base64Decode(inputString)
		keyByte = utf8.byte(keyByte)
		offsetByte = math.floor(utf8.byte(offsetByte) / 2)
		local processedString = ""
		local inputLength = utf8.len(inputString)
		local currentPos = 1
		
		for i = 1, inputLength do
			if currentPos == offsetByte then
				keyByte = utf8.byte(utf8.sub(inputString, i, i))
				currentPos = 1
			else
				currentPos = currentPos + 1
				processedString = processedString .. utf8.char(bitXor(utf8.byte(utf8.sub(inputString, i, i)), keyByte))
			end
		end
		
		return processedString
	end
end

local function encodeWithOffset(inputString, shaderFunc, key1, key2, key3)
	local resultString = ""
	local inputLength = utf8.len(inputString)
	local tempString1 = nil
	local tempString2 = nil
	local tempString3 = nil
	
	for i = 1, inputLength do
		local currentChar = utf8.sub(inputString, i, i)
		
		if currentChar == "ö" or currentChar == "ü" or currentChar == "ó" or currentChar == "ő" or currentChar == "ú" or currentChar == "é" or currentChar == "á" or currentChar == "ű" or currentChar == "Ö" or currentChar == "Ü" or currentChar == "Ó" or currentChar == "Ő" or currentChar == "Ú" or currentChar == "Á" or currentChar == "Ű" or currentChar == "É" then
			if tempString3 then
				resultString = resultString .. decodeAndProcess(tempString3, tempString1, tempString2)
				tempString3 = nil
				tempString1 = nil
				tempString2 = nil
			else
				tempString3 = ""
			end
		elseif tempString3 then
			if not tempString1 then
				tempString1 = currentChar
			elseif not tempString2 then
				tempString2 = currentChar
			else
				tempString3 = tempString3 .. currentChar
			end
		else
			resultString = resultString .. currentChar
		end
	end
	
	local finalResult = dxCreateShader(resultString, shaderFunc, key1, key2, key3)
	resultString = nil
	collectgarbage("collect")
	return finalResult
end

local sightexports = {
	sMarkers = false,
	sLicense = false,
	sGui = false,
	sWeather = false,
	sDashboard = false,
	sWorkaround = false,
	sPermission = false,
	sModloader = false,
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
local processSightlangStaticImage = {}
sightlangStaticImageToc[0] = true
sightlangStaticImageToc[1] = true
sightlangStaticImageToc[2] = true
local sightlangStatImgPre = nil
function sightlangStatImgPre()
	local now = getTickCount()
	if sightlangStaticImageUsed[0] then
		sightlangStaticImageUsed[0] = false
		sightlangStaticImageDel[0] = false
	elseif sightlangStaticImage[0] then
		if sightlangStaticImageDel[0] then
			if sightlangStaticImageDel[0] <= now then
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
			if sightlangStaticImageDel[1] <= now then
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
			if sightlangStaticImageDel[2] <= now then
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
processSightlangStaticImage[0] = function()
	if not isElement(sightlangStaticImage[0]) then
		sightlangStaticImageToc[0] = false
		sightlangStaticImage[0] = dxCreateTexture("files/table.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/mug.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[2] = function()
	if not isElement(sightlangStaticImage[2]) then
		sightlangStaticImageToc[2] = false
		sightlangStaticImage[2] = dxCreateTexture("files/headlight.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
local function modloaderLoaded()
	r26_0()
	createLobby()
end
addEventHandler("modloaderLoaded", getRootElement(), modloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), modloaderLoaded)
end
local sightlangCondHandlState1 = false
local function checkClickLobby(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState1 then
		sightlangCondHandlState1 = cond
		if cond then
			addEventHandler("onClientClick", getRootElement(), clickLobby, true, prio)
		else
			removeEventHandler("onClientClick", getRootElement(), clickLobby)
		end
	end
end
local sightlangCondHandlState2 = false
local function checkRestoreLobby(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState2 then
		sightlangCondHandlState2 = cond
		if cond then
			addEventHandler("onClientRestore", getRootElement(), restoreLobby, true, prio)
		else
			removeEventHandler("onClientRestore", getRootElement(), restoreLobby)
		end
	end
end
local sightlangCondHandlState3 = false
local function checkRenderLobby(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState3 then
		sightlangCondHandlState3 = cond
		if cond then
			addEventHandler("onClientRender", getRootElement(), renderLobby, true, prio)
		else
			removeEventHandler("onClientRender", getRootElement(), renderLobby)
		end
	end
end
local sightlangCondHandlState4 = false
local function checkPreRenderLobby(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState4 then
		sightlangCondHandlState4 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), preRenderLobby, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderLobby)
		end
	end
end
local mineCache = {}

addEvent("gotMineCache", true)
addEventHandler("gotMineCache", getRootElement(), function(datas)
	mineCache = datas
end)

addEvent("addMineCache", true)
addEventHandler("addMineCache", getRootElement(), function(data)
	table.insert(mineCache, data)
end)

addEvent("deleteMineCache", true)
addEventHandler("deleteMineCache", getRootElement(), function(mineId)
	for i = #mineCache, 1, -1 do
		if mineCache[i].id == mineId then
			table.remove(mineCache, i)
			break
		end
	end
end)

addEvent("updateMineCache", true)
addEventHandler("updateMineCache", getRootElement(), function(mineId, key, data)
	for i = 1, #mineCache, 1 do
		if mineCache[i].id == mineId then
			mineCache[i][key] = data
			break
		end
	end
end)

function getMineCache()
	return mineCache
end

--[[
if getElementData(localPlayer, "loggedIn") then
	triggerServerEvent("getMineCache", localPlayer)
end

addEventHandler("onClientElementDataChange", localPlayer, function(key, old, new)
	if key == "loggedIn" and new then
		triggerServerEvent("getMineCache", localPlayer)
	end
end)
]]

charset = {
	["!"] = {
		2140,
		17
	},
	["#"] = {
		2000,
		33
	},
	["\""] = {
		2230,
		26
	},
	["%"] = {
		2194,
		28
	},
	["$"] = {
		1843,
		30
	},
	["Ó"] = {
		529,
		37
	},
	["&"] = {
		2102,
		31
	},
	[")"] = {
		1977,
		16
	},
	["("] = {
		1954,
		18
	},
	["+"] = {
		1881,
		32
	},
	["-"] = {
		1921,
		26
	},
	[","] = {
		2281,
		17
	},
	["."] = {
		2304,
		17
	},
	["Á"] = {
		4,
		32
	},
	["0"] = {
		1479,
		35
	},
	["3"] = {
		1586,
		32
	},
	["2"] = {
		1548,
		30
	},
	["5"] = {
		1660,
		26
	},
	["4"] = {
		1626,
		26
	},
	["7"] = {
		1733,
		27
	},
	["6"] = {
		1694,
		31
	},
	["9"] = {
		1806,
		29
	},
	["Í"] = {
		121,
		13
	},
	["\'"] = {
		2262,
		14
	},
	["?"] = {
		2163,
		24
	},
	["@"] = {
		2044,
		48
	},
	["É"] = {
		632,
		30
	},
	["8"] = {
		1768,
		30
	},
	A = {
		1356,
		32
	},
	["Ú"] = {
		485,
		34
	},
	["C"] = {
		908,
		41
	},
	["B"] = {
		960,
		34
	},
	E = {
		760,
		30
	},
	D = {
		1430,
		39
	},
	G = {
		577,
		45
	},
	F = {
		446,
		30
	},
	I = {
		887,
		13
	},
	H = {
		714,
		37
	},
	K = {
		357,
		33
	},
	["Ő"] = {
		266,
		37
	},
	["Ö"] = {
		400,
		37
	},
	L = {
		1319,
		29
	},
	O = {
		1004,
		37
	},
	N = {
		1101,
		36
	},
	Q = {
		799,
		37
	},
	P = {
		671,
		33
	},
	S = {
		1277,
		33
	},
	["Ű"] = {
		222,
		34
	},
	U = {
		846,
		34
	},
	T = {
		185,
		28
	},
	W = {
		1051,
		40
	},
	V = {
		90,
		25
	},
	Y = {
		1396,
		25
	},
	X = {
		1147,
		35
	},
	["1"] = {
		1522,
		19
	},
	Z = {
		141,
		35
	},
	M = {
		1227,
		40
	},
	["Ü"] = {
		313,
		34
	},
	J = {
		1191,
		27
	},
	R = {
		45,
		36
	},
}

local unrentWindow = false
local lobbyObject = false
local lobbyAlphaObject = false
local exitMarkers = {}
local mineLobbyDatas = {}
local lobbyTableObjects = {}
local mineLobbyEnterWindow = false
local mineRentWindow = false
local mineRentManageWindow = false
local currentStandingLobbyMarker = false
local inLobbyExitMarker = false
local currentStandingMine = false
local inMineExitMarker = false
function createLobby()
	if isElement(lobbyObject) then
		destroyElement(lobbyObject)
	end
	lobbyObject = nil
	if isElement(lobbyAlphaObject) then
		destroyElement(lobbyAlphaObject)
	end
	lobbyAlphaObject = nil
	lobbyObject = createBuilding(modelIds.v4_mine_lobby, 0, 0, 7000, 0, 0, 0)
	setElementInterior(lobbyObject, 0)
	setElementDimension(lobbyObject, 1)
	lobbyAlphaObject = createBuilding(modelIds.v4_mine_lobby_alpha, 0, 0, 7000, 0, 0, 0)
	engineSetModelFlag(modelIds.v4_mine_lobby_alpha, "no_zbuffer_write", true)
	setElementInterior(lobbyAlphaObject, 0)
	setElementDimension(lobbyAlphaObject, 1)
end

function setMineExitMarker(mineIdentifier)
	local markerId = #mineCoords
	sightexports.sMarkers:setCustomMarkerDimension(exitMarkers[markerId + 2], mineIdentifier)
	sightexports.sMarkers:setCustomMarkerText(exitMarkers[markerId + 2], {
		formatCorridorNameMineId(mineIdentifier),
		formatMineName(mineIdentifier) .. " (" .. mineIdentifier .. ")"
	})
end

local replaceShader = " texture gTexture; technique hello { pass P0 { Texture[0] = gTexture; } } "
local mineTableChars = {}
local mugRTs = {}
local shaderElements = {}
local mugs = {}
local idCards = {}
local isProcessingPic = false

function restoreLobby()
	for i in pairs(mugRTs) do
		if isElement(mugRTs[i]) then
			destroyElement(mugRTs[i])
		end
		mugRTs[i] = nil
	end
end

function drawMug(id, image, u)
	for mineId, rt in pairs(mugRTs) do
		for i = 1, 5, 1 do
			if id == mineLobbyDatas[mineId].workersInside[i] and id ~= mugs[mineId][i] then
				dxSetRenderTarget(rt)
				if u then
					dxDrawImageSection((i - 1) * 48, 0, 48, 48, u, 0, 48, 48, image)
				else
					dxDrawImage((i - 1) * 48, 0, 48, 48, image)
				end
				mugs[mineId][i] = id
			end
		end
	end
	dxSetRenderTarget()
end

function processMug(id)
	for k, v in pairs(mugs) do
		if mugRTs[k] then
			for i in pairs(v) do
				if id == v[i] then
					drawMug(id, mugRTs[k], (i - 1) * 48)
					return 
				end
			end
		end
	end
	triggerServerEvent("requestPicForMine", localPlayer, id)
	isProcessingPic = true
end

addEvent("gotPicForMine", true)
addEventHandler("gotPicForMine", getRootElement(), function(id, texture)
	isProcessingPic = false
	local textureElement = dxCreateTexture(texture)
	drawMug(id, textureElement)
	if isElement(textureElement) then
		destroyElement(textureElement)
	end
	textureElement = nil
	texture = false
	collectgarbage("collect")
end)

local licenseShowState = false
function renderLobby()
	local px, py = getElementPosition(localPlayer)
	local cursorX, cursorY = getCursorPosition()
	if cursorX then
		cursorY = cursorY * screenY
		cursorX = cursorX * screenX
	end
	local licenseHover = false
	local canOpenLicense = true
	local currentHoveringLicense = false
	for mineId, datas in pairs(idCards) do
		if isElementOnScreen(lobbyTableObjects[mineId]) then
			for i = 1, 5, 1 do
				local id = mineLobbyDatas[mineId].workersInside[i]
				if id then
					local x, y, z = unpack(datas[i])
					local wX, wY = getScreenFromWorldPosition(x, y, z, 16)
					if wX then
						local dist = getDistanceBetweenPoints2D(x, y, px, py)
						if dist < 3.5 then
							if not licenseHover then
								licenseHover = true
								if sightexports.sLicense:isLicenseShowing() then
									canOpenLicense = false
									break
								end
							else
								local alpha = (1 - math.max(0, (dist - 3) / 0.5)) * 255
								dxDrawRectangle(wX - 16, wY - 16, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], alpha))
								if cursorX and 255 <= alpha and wX - 16 <= cursorX and wY - 16 <= cursorY and cursorX <= wX + 16 and cursorY <= wY + 16 then
									currentHoveringLicense = id
									dxDrawImage(wX - 12, wY - 12, 24, 24, ":sGui/" .. idIcon .. faTicks[idIcon], 0, 0, 0, greenToColor)
								else
									dxDrawImage(wX - 12, wY - 12, 24, 24, ":sGui/" .. idIcon .. faTicks[idIcon], 0, 0, 0, tocolor(255, 255, 255, alpha))
								end
							end
						end
					end
				end
			end
		end
		if not canOpenLicense then
			break
		end
	end
	if currentHoveringLicense ~= licenseShowState then
		licenseShowState = currentHoveringLicense
		local cursorType = nil
		if currentHoveringLicense then
			cursorType = "link"
		else
			cursorType = "normal"
		end
		sightexports.sGui:setCursorType(cursorType)
		text = currentHoveringLicense and "Igazolvány megtekintése (" .. currentHoveringLicense .. ")"
		sightexports.sGui:showTooltip(text)
	end
end

function clickLobby(button, state)
	if state == "down" and licenseShowState and not sightexports.sLicense:isLicenseShowing() then
		sightexports.sLicense:showLicense("mine", licenseShowState, true)
	end
end

function getTableTex()
	sightlangStaticImageUsed[0] = true
	if sightlangStaticImageToc[0] then
		processSightlangStaticImage[0]()
	end
	return sightlangStaticImage[0]
end

function preRenderLobby()
	setTime(12, 0)
	setWeather(1)
	setSkyGradient(0, 0, 0, 0, 0, 0)
	local tableTex = getTableTex()
	
	local refresh = false
	for mineId, datas in pairs(mineTableChars) do
		if isElementOnScreen(lobbyTableObjects[mineId]) then
			for i = 1, #datas, 1 do
				local x, y, z, w, h, u, v = unpack(datas[i])
				dxDrawMaterialSectionLine3D(x, y, z + 0.0625, x, y, z - 0.0625, u, 0, v, 64, tableTex, v * 0.001953125, tocolor(0, 0, 0), x + w, y + h, z)
			end
			if not isProcessingPic and not refresh and 0 < #mineLobbyDatas[mineId].workersInside then
				if not isElement(mugRTs[mineId]) or not isElement(shaderElements[mineId]) then
					refresh = true
					if not isElement(mugRTs[mineId]) then
						mugRTs[mineId] = dxCreateRenderTarget(240, 48)
					end
					if not isElement(shaderElements[mineId]) then
						shaderElements[mineId] = encodeWithOffset(replaceShader)
					end
					if isElement(mugRTs[mineId]) and isElement(shaderElements[mineId]) then
						dxSetRenderTarget(mugRTs[mineId])
						for i = 0, 4, 1 do
							sightlangStaticImageUsed[1] = true
							if sightlangStaticImageToc[1] then
								processSightlangStaticImage[1]()
							end
							dxDrawImage(48 * i, 0, 48, 48, sightlangStaticImage[1])
						end
						dxSetRenderTarget()
						dxSetShaderValue(shaderElements[mineId], "gTexture", mugRTs[mineId])
						engineApplyShaderToWorldTexture(shaderElements[mineId], "v4_mining_license_mugshot", lobbyTableObjects[mineId])
					end
					mugs[mineId] = {}
				end
				local needProcess = true
				for j = 1, 5, 1 do
					local y = mineLobbyDatas[mineId].workersInside[j]
					if y and mugs[mineId][j] ~= y then
						processMug(y)
						needProcess = false
						break
					end
				end
				if needProcess then
					for j = 1, 5, 1 do
						if mugs[mineId][j] and not mineLobbyDatas[mineId].workersInside[j] then
							dxSetRenderTarget(mugRTs[mineId])
							sightlangStaticImageUsed[1] = true
							if sightlangStaticImageToc[1] then
								processSightlangStaticImage[1]()
							end
							dxDrawImage(48 * (j - 1), 0, 48, 48, sightlangStaticImage[1])
							dxSetRenderTarget()
							mugs[mineId][j] = nil
							break
						end
					end
				end
			end
		end
	end
end

function refreshLobbyTable(mineId)
	if mineLobbyDatas[mineId] then
		local lobby, corridor, door = getLobbyFromMineId(mineId)
		local rz = mineCoords[door][10]
		local sin = mineCoords[door][11]
		local cos = mineCoords[door][12]
		local z = mineCoords[door][9]
		local y = 0 + mineCoords[door][8]
		local x = 0 + mineCoords[door][7]
		local insideNum = math.min(5, #mineLobbyDatas[mineId].workersInside)
		if insideNum <= 0 then
			if isElement(mugRTs[mineId]) then
				destroyElement(mugRTs[mineId])
			end
			mugRTs[mineId] = nil
			if isElement(shaderElements[mineId]) then
				destroyElement(shaderElements[mineId])
			end
			shaderElements[mineId] = nil
		end
		iprint(x, y, z)
		if isElement(lobbyTableObjects[mineId]) then
			setElementModel(lobbyTableObjects[mineId], modelIds["v4_mine_table" .. insideNum])
		else
			lobbyTableObjects[mineId] = createObject(modelIds["v4_mine_table" .. insideNum], x, y, z, 0, 0, rz)
			setElementInterior(lobbyTableObjects[mineId], 0)
			setElementDimension(lobbyTableObjects[mineId], loadedMineLobby)
			if isElement(mugRTs[mineId]) then
				destroyElement(mugRTs[mineId])
			end
			mugRTs[mineId] = nil
			if isElement(shaderElements[mineId]) then
				destroyElement(shaderElements[mineId])
			end
			shaderElements[mineId] = nil
		end
		if not idCards[mineId] then
			idCards[mineId] = {}
			for i = 1, 5, 1 do
				idCards[mineId][i] = {
					x - cos * idCardOffsets[i],
					y + sin * idCardOffsets[i],
					z - 0.2
				}
			end
		end
		mineTableChars[mineId] = {}
		local count = 1
		local nameChars = mineLobbyDatas[mineId].mineName
		for charId = 1, 2, 1 do
			if nameChars[charId] then
				local charX = x + sin * 0.05
				local charY = y + cos * 0.05
				local charNum = #nameChars
				if charNum > 1 then
					charNum = 0.125 * (charId - 1.5)
				else
					charNum = 0
				end
				charNum = z - charNum
				local offset = 0
				for j = 1, utf8.len(nameChars[charId]), 1 do
					local currentChar = charset[utf8.sub(nameChars[charId], j, j)]

					if currentChar then
						local ts = currentChar[2] * 0.001953125 / 2
						charX = charX - cos * ts
						charY = charY + sin * ts
						table.insert(mineTableChars[mineId], {
							charX,
							charY,
							charNum,
							sin,
							cos,
							currentChar[1],
							currentChar[2]
						})
						charX = charX - cos * ts
						charY = charY + sin * ts
						offset = offset + ts * 2
					else
						local ts = 0.0546875
						charX = charX - cos * ts
						charY = charY + sin * ts
						offset = offset + ts
					end
				end
				offset = offset / 2
				for j = count, #mineTableChars[mineId], 1 do
					if mineTableChars[mineId][j] then
						mineTableChars[mineId][j][1] = mineTableChars[mineId][j][1] + cos * offset
						mineTableChars[mineId][j][2] = mineTableChars[mineId][j][2] - sin * offset
					end
				end
				count = #mineTableChars[mineId] + 1
			end
		end
	else
		if isElement(mugRTs[mineId]) then
			destroyElement(mugRTs[mineId])
		end
		mugRTs[mineId] = nil
		if isElement(shaderElements[mineId]) then
			destroyElement(shaderElements[mineId])
		end
		shaderElements[mineId] = nil
		if isElement(lobbyTableObjects[mineId]) then
			destroyElement(lobbyTableObjects[mineId])
		end
		lobbyTableObjects[mineId] = nil
		mineTableChars[mineId] = nil
		mugs[mineId] = nil
		idCards[mineId] = nil
	end
end

function refreshLobbyMarker(id)
	local lobby, corridor, door = getLobbyFromMineId(id)
	sightexports.sMarkers:setCustomMarkerInterior(exitMarkers[door], "mineLobbyInside", id, 1.5)
	if mineLobbyDatas[id] then
		sightexports.sMarkers:setCustomMarkerColor(exitMarkers[door], "sightyellow")
		sightexports.sMarkers:setCustomMarkerText(exitMarkers[door], {
			formatCorridorNameMineId(id),
			formatMineName(id) .. " (" .. id .. ")"
		})
	else
		sightexports.sMarkers:setCustomMarkerColor(exitMarkers[door], "sightgreen")
		sightexports.sMarkers:setCustomMarkerText(exitMarkers[door], {
			formatCorridorNameMineId(id),
			formatMineName(id) .. " (" .. id .. ")",
			"Kiadó!"
		}, {
			"#ffffff",
			"#ffffff",
			"sightgreen"
		})
	end
end

local lobbyLoopSound = false
function unloadLobby()

	  for k in pairs(mineColShapes) do
		if isElement(k) then
			destroyElement(k)
		end
		mineColShapes[k] = nil
	end

	if isElement(lobbyLoopSound) then
		destroyElement(lobbyLoopSound)
	end
	lobbyLoopSound = nil
	checkPreRenderLobby(false)
	checkRenderLobby(false)
	checkRestoreLobby(false)
	checkClickLobby(false)
	sightexports.sWeather:resetWeather()
	sightexports.sDashboard:resetFogAndFarClip()
	loadedMineLobby = false
	mineLobbyDatas = false
	refreshMarkersAndBlips()
	mineTableChars = {}
	mugs = {}
	idCards = {}
	for i in pairs(lobbyTableObjects) do
		if isElement(lobbyTableObjects[i]) then
			destroyElement(lobbyTableObjects[i])
		end
		lobbyTableObjects[i] = nil
	end
	for i in pairs(shaderElements) do
		if isElement(shaderElements[i]) then
			destroyElement(shaderElements[i])
		end
		shaderElements[i] = nil
	end
	for i in pairs(mugRTs) do
		if isElement(mugRTs[i]) then
			destroyElement(mugRTs[i])
		end
		mugRTs[i] = nil
	end
	sightexports.sWorkaround:setDisableDetach(600)
end

mineColShapes = {}

function initLobby(lobbyId, lobbyDatas)
	unloadLobby()
	sightexports.sWorkaround:setDisableDetach(true)
	checkPreRenderLobby(true)
	checkRenderLobby(true)
	checkRestoreLobby(true)
	checkClickLobby(true)
	loadedMineLobby = lobbyId
	mineLobbyDatas = lobbyDatas
	refreshMarkersAndBlips()
	setElementDimension(lobbyObject, lobbyId)
	setElementDimension(lobbyAlphaObject, lobbyId)
	local pos = #mineCoords
	local lobby, id = getLobbyFromCorridor(loadedMineLobby)
	local baseId = getLobbyMineBaseId(lobby, id)
	for i = 1, pos, 1 do
		sightexports.sMarkers:setCustomMarkerDimension(exitMarkers[i], lobbyId)
		refreshLobbyMarker(baseId + i)
		refreshLobbyTable(baseId + i)
	end
	sightexports.sMarkers:setCustomMarkerDimension(exitMarkers[pos + 1], lobbyId)
	sightexports.sMarkers:setCustomMarkerText(exitMarkers[pos + 1], {
		formatCorridorName(lobbyId)
	})
	lobbyLoopSound = playSound("files/minesound/lobbyloop.mp3", true)
	initMineIntiBox()

	for r3_34 = 1, #lobbyCoords, 1 do
		local r4_34 = lobbyCoords[r3_34]
		local r5_34 = r4_34[7]
		local r6_34 = r4_34[8]
		local r7_34 = r4_34[9]
		local r8_34 = math.rad(r4_34[10])
		local r9_34 = math.cos(r8_34)
		local r10_34 = math.sin(r8_34)
		r7_0[r3_34] = {
			r5_34 - r9_34 * 0.62,
			r6_34 - r10_34 * 0.62,
			r7_34 + 1.0685,
			r9_34,
			r10_34
		}
	end

	for k = 1, #mineCoords, 1 do
		local x, y, z = unpack(mineCoords[k], 1, 3)
		local col = createColSphere(x, y, z, 2.5)
		if isElement(col) then
			setElementInterior(col, 0)
			setElementDimension(col, lobbyId)
			addEventHandler("onClientColShapeHit", col, handleMineColShapeEnter)
			addEventHandler("onClientColShapeLeave", col, handleMineColShapeLeave)
		end
		mineColShapes[col] = baseId + k
  	end
end

addEvent("gotMineDoorLocked", true)
addEventHandler("gotMineDoorLocked", getRootElement(), function(mineId, lockData)
	if currentMine == mineId then
		currentMineLocked = lockData
	elseif loadedMineLobby then
		local lobby, corridor, door = getLobbyFromMineId(mineId)
		if loadedMineLobby == getCorridorIdFromLobbyCorridor(lobby, corridor) then
			mineLobbyDatas[mineId].locked = lockData
		end
	end
	initMineIntiBox()
end)

addEvent("gotMineLobbyDoorSound", true)
addEventHandler("gotMineLobbyDoorSound", getRootElement(), function(lobbyId)
	if source == localPlayer or source == getPedOccupiedVehicle(localPlayer) then
		playSound("files/minesound/lobbydoor.wav")
		return 
	end
	if loadedMineLobby == lobbyId then
		local sound = playSound3D("files/minesound/lobbydoor.wav", 0 + lobbyExitX, 0 + lobbyExitY, lobbyExitZ)
		setElementInterior(sound, 0)
		setElementDimension(sound, lobbyId)
		setSoundMaxDistance(sound, 50)
	else
		local lobby = getLobbyFromCorridor(lobbyId)
		local x, y, z = getElementPosition(localPlayer)
		if getDistanceBetweenPoints3D(lobbyCoords[lobby][1], lobbyCoords[lobby][2], lobbyCoords[lobby][3], x, y, z) <= 100 then
			setSoundMaxDistance(playSound3D("files/minesound/lobbydoor.wav", lobbyCoords[lobby][1], lobbyCoords[lobby][2], lobbyCoords[lobby][3]), 50)
		end
	end
end)

addEvent("gotMineDoorSound", true)
addEventHandler("gotMineDoorSound", getRootElement(), function(mineId, soundType)
	if source == localPlayer then
		if soundType == 5 then
			playSound(":sInteriors/files/lockunlock.mp3")
		elseif soundType == 6 then
			playSound(":sInteriors/files/locked.mp3")
		elseif 1 <= soundType and soundType <= 4 then
			playSound(":sInteriors/files/door/" .. soundType .. ".mp3")
		end
		return 
	end
	local x = nil
	local y = nil
	local z = nil
	if currentMine == mineId then
		z = 9001
		y = 0.045
		x = -34.5877
	elseif loadedMineLobby then
		local lobby, corridor, door = getLobbyFromMineId(mineId)
		if loadedMineLobby == getCorridorIdFromLobbyCorridor(lobby, corridor) then
			x, y, z, cos, sin = unpack(mineCoords[door])
			x = 0 + x - cos * 2
			y = 0 + y - sin * 2
			z = z + 1
		end
	end
	if x then
		if soundType == 5 then
			soundType = playSound3D(":sInteriors/files/lockunlock.mp3", x, y, z)
		elseif soundType == 6 then
			soundType = playSound3D(":sInteriors/files/locked.mp3", x, y, z)
		elseif 1 <= soundType and soundType <= 4 then
			soundType = playSound3D(":sInteriors/files/door/" .. soundType .. ".mp3", x, y, z)
		end
	end
	if currentMine == mineId then
		setElementInterior(soundType, 0)
		setElementDimension(soundType, currentMine)
	elseif loadedMineLobby then
		local lobby, corridor, door = getLobbyFromMineId(mineId)
		local lobbyId = getCorridorIdFromLobbyCorridor(lobby, corridor)
		if loadedMineLobby == lobbyId then
			setElementInterior(soundType, 0)
			setElementDimension(soundType, lobbyId)
		end
	end
end)

addEvent("gotNewMineData", true)
addEventHandler("gotNewMineData", getRootElement(), function(mineId, datas)
	if mineLobbyDatas then
		local lobby, corridor, door = getLobbyFromMineId(mineId)
		if loadedMineLobby == getCorridorIdFromLobbyCorridor(lobby, corridor) then
			mineLobbyDatas[mineId] = datas
			refreshLobbyMarker(mineId)
			refreshLobbyTable(mineId)
			if mineId == currentStandingMine then
				doStandingMineBox(mineId)
			end
		end
	end
end)

addEvent("gotMineRentData", true)
addEventHandler("gotMineRentData", getRootElement(), function(mineId, key, data)
	if mineLobbyDatas and mineLobbyDatas[mineId] then
		mineLobbyDatas[mineId][key] = data
		if key == "inside" or key == "mineName" then
			refreshLobbyTable(mineId)
		end
		if mineId == currentStandingMine then
			if mineRentManageWindow then
				refresh = true
			else
				refresh = false
			end
			doStandingMineBox(mineId)
			if refresh then
				openMineRentPanel()
			end
		end
	end
end)

addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	for i = 1, #exitMarkers, 1 do
		if exitMarkers[i] then
			sightexports.sMarkers:deleteCustomMarker(exitMarkers[i])
		end
		exitMarkers[i] = nil
	end
	for i = 1, #mineCoords, 1 do
		local x, y, z, rx, ry = unpack(mineCoords[i])
		table.insert(exitMarkers, sightexports.sMarkers:createCustomMarker(0 + x - rx * 2, 0 + y - ry * 2, z + 1, 0, 1, "sightgreen", "mine"))
	end
	local marker = sightexports.sMarkers:createCustomMarker(0 + lobbyExitX, 0 + lobbyExitY, lobbyExitZ, 0, 1, "sightorange", "mine")
	table.insert(exitMarkers, marker)
	sightexports.sMarkers:setCustomMarkerInterior(marker, "mineLobbyExit", false, 3)
	mineExitMarker = sightexports.sMarkers:createCustomMarker(-34.5877, 0.045, 9001, 0, 1, "sightyellow", "mine")
	table.insert(exitMarkers, mineExitMarker)
	sightexports.sMarkers:setCustomMarkerInterior(mineExitMarker, "mineExit", false, 1.5)
	for i = 1, #lobbyCoords, 1 do
		local marker = sightexports.sMarkers:createCustomMarker(lobbyCoords[i][1], lobbyCoords[i][2], lobbyCoords[i][3], 0, 0, "sightorange", "mine")
		sightexports.sMarkers:setCustomMarkerText(marker, {
			"Tierra Robada bánya",
			lobbyCoords[i][5] .. " bánya"
		}, {
			"sightorange"
		})
		sightexports.sMarkers:setCustomMarkerInterior(marker, "mineLobbyEnter", i, 3)
		table.insert(exitMarkers, marker)
	end
end)

addEventHandler("onClientResourceStop", getResourceRootElement(), function()
	for i = 1, #exitMarkers, 1 do
		if exitMarkers[i] then
			sightexports.sMarkers:deleteCustomMarker(exitMarkers[i])
		end
		exitMarkers[i] = nil
	end
end)

addEvent("mineEnterResponse", true)
addEventHandler("mineEnterResponse", getRootElement(), function(mineId)
	loadingMineEnter = mineId
	loadingMineEnterSynced = mineId
	if mineId then
		startLoader(true)
	end
end)

addEvent("mineLobbyEnterResponse", true)
addEventHandler("mineLobbyEnterResponse", getRootElement(), function(mineId)
	loadingMineLobby = mineId
	loadedMineLobby = mineId
	
	if mineId then
		setElementDimension(lobbyObject, mineId)
		setElementDimension(lobbyAlphaObject, mineId)
		startLoader(true)
	end
end)

addEvent("mineLobbyLoaded", true)
addEventHandler("mineLobbyLoaded", getRootElement(), function(lobby, datas)
	loadingMineLobby = false
	loadedMineLobby = false
	loadingMineExit = false
	loadingMineExitSynced = false
	initLobby(lobby, datas)
end)
addEvent("mineLobbyExitResponse", true)
addEventHandler("mineLobbyExitResponse", getRootElement(), function(mineId)
	if mineId then
		loadingMineLobbyExit = true
		loadingMineLobbyExitSynced = true
		startLoader(true)
	else
		loadingMineLobbyExit = false
		loadingMineLobbyExitSynced = false
	end
end)
addEvent("mineExitResponse", true)
addEventHandler("mineExitResponse", getRootElement(), function(mineId)
	if mineId then
		loadingMineExit = true
		loadingMineExitSynced = true
		startLoader(true)
		handleMineHandlers(false)
	else
		loadingMineExit = false
		loadingMineExitSynced = false
		handleMineHandlers(true)
	end
end)

addEvent("mineLobbyExited", true)
addEventHandler("mineLobbyExited", getRootElement(), function()
	loadingMineLobbyExit = false
	loadingMineLobbyExitSynced = false
	loadedMineLobby = false
	mineLobbyDatas = false
	unloadLobby()
end)

function createIntiBox(iconIn, text, text2, color, forRent, lock, manage)
	local was = false
	if mineRentWindow then
		was = true
		sightexports.sGui:deleteGuiElement(mineRentWindow)
	end
	mineRentWindow = false
	if mineLobbyEnterWindow then
		sightexports.sGui:deleteGuiElement(mineLobbyEnterWindow)
	end
	mineLobbyEnterWindow = nil
	if mineRentManageWindow then
		sightexports.sGui:deleteGuiElement(mineRentManageWindow)
	end
	mineRentManageWindow = nil
	if unrentWindow then
		sightexports.sGui:deleteGuiElement(unrentWindow)
	end
	unrentWindow = nil
	showCursor(false)
	if iconIn then
		mineRentWindow = sightexports.sGui:createGuiElement("rectangle", screenX / 2 - 150, screenY + 64, 300, 75)
		sightexports.sGui:setGuiBackground(mineRentWindow, "solid", "sightgrey2")
		sightexports.sGui:setGuiBackground(sightexports.sGui:createGuiElement("rectangle", 0, 0, 75, 75, mineRentWindow), "solid", "sightgrey1")
		local icon = sightexports.sGui:createGuiElement("image", 6, 10, 63, 59, mineRentWindow)
		sightexports.sGui:setImageDDS(icon, sightexports.sMarkers:getCustomMarkerTexture(iconIn))
		sightexports.sGui:setImageColor(icon, color)
		sightexports.sGui:setImageUV(icon, 0, 0, 320, 320 - 4 * 5.079365079365079)
		local label = sightexports.sGui:createGuiElement("label", 87, 4, 0, 37.5, mineRentWindow)
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelText(label, text)
		sightexports.sGui:setLabelFont(label, "16/BebasNeueBold.otf")
		sightexports.sGui:setLabelColor(label, color)
		local label = sightexports.sGui:createGuiElement("label", 87, 33.5, 0, 37.5, mineRentWindow)
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelText(label, text2)
		sightexports.sGui:setLabelFont(label, "16/BebasNeueRegular.otf")
		local w = 87 + math.max(200, math.max(sightexports.sGui:getLabelTextWidth(label), sightexports.sGui:getLabelTextWidth(label))) + 12
		local yMinus = false
		local bw = nil
		if forRent then
			local label = sightexports.sGui:createGuiElement("label", w / 2, -72, 0, 32, mineRentWindow)
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			sightexports.sGui:setLabelText(label, "Kiadó!")
			sightexports.sGui:setLabelColor(label, "sightgreen")
			sightexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
			local text = " Bérlés (" .. sightexports.sGui:thousandsStepper(rentPrice) .. " $ / hét vagy " .. sightexports.sGui:thousandsStepper(ppRentPrice) .. " PP / hét)"
			bw = math.ceil((28 + sightexports.sGui:getTextWidthFont(text, "12/BebasNeueRegular.otf") + 4) / 2) * 2
			local btn = sightexports.sGui:createGuiElement("button", w / 2 - bw / 2, -36, bw, 28, mineRentWindow)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
			sightexports.sGui:setButtonText(btn, text)
			sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("tags", 28))
			sightexports.sGui:setClickEvent(btn, "openMineRentPanel")
			yMinus = 72
		elseif manage or lock then
			local manW = 0
			if manage then
				manW = math.ceil((28 + sightexports.sGui:getTextWidthFont(" Albérlet kezelése", "12/BebasNeueRegular.otf") + 4) / 2) * 2 + 8
			end
			local x = w / 2
          	x = w / 2 - ((lock and 36 or 0) + manW) / 2
			y = -36
			if manage then
				manW = manW - 8
				local btn = sightexports.sGui:createGuiElement("button", x, -36, manW, 28, mineRentWindow)
				sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
				sightexports.sGui:setGuiHover(btn, "gradient", {
					"sightgreen",
					"sightgreen-second"
				}, false, true)
				sightexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
				sightexports.sGui:setButtonText(btn, " Albérlet kezelése")
				sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("tags", 28))
				sightexports.sGui:setClickEvent(btn, "openMineRentPanel")
				x = x + manW + 8
			end
			if lock then
				local rect = sightexports.sGui:createGuiElement("rectangle", x, y, 28, 28, mineRentWindow)
				sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
				local icon = sightexports.sGui:createGuiElement("image", 2, 2, 24, 24, rect)
				sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("key", 24))
				sightexports.sGui:setGuiBoundingBox(icon, rect)
				sightexports.sGui:setGuiHoverable(icon, true)
				sightexports.sGui:setGuiHover(icon, "solid", "sightyellow")
				sightexports.sGui:setClickEvent(icon, "lockUnlockMine")
				lockedState = false
				if currentMine then
					lockedState = currentMineLocked
				elseif mineLobbyDatas and mineLobbyDatas[currentStandingMine] then
					lockedState = mineLobbyDatas[currentStandingMine].locked
				end
				if lockedState then
					sightexports.sGui:guiSetTooltip(icon, "Bánya kinyitása")
				else
					sightexports.sGui:guiSetTooltip(icon, "Bánya bezárása")
				end
			end
			yMinus = 36
		end
		if not yMinus then
			yMinus = 32
		end
		local label = sightexports.sGui:createGuiElement("label", w / 2, 75, 0, 32, mineRentWindow)
		sightexports.sGui:setLabelAlignment(label, "center", "center")

		sightexports.sGui:setLabelText(label, "Nyomj [E] gombot a " .. (forRent and "bérléshez" or "belépéshez") .. ".")
		sightexports.sGui:setLabelFont(label, "14/BebasNeueBold.otf")
		sightexports.sGui:setGuiSize(mineRentWindow, w, 75)
		if was then
			sightexports.sGui:setGuiPosition(mineRentWindow, screenX / 2 - w / 2, screenY - 128 - 64 - yMinus)
		else
			sightexports.sGui:setGuiPosition(mineRentWindow, screenX / 2 - w / 2, screenY + yMinus)
			sightexports.sGui:setGuiPositionAnimated(mineRentWindow, screenX / 2 - w / 2, screenY - 128 - 64 - yMinus, 1000, false, "OutBounce")
		end
	end
end

function openMineRentPanel()
	if not currentStandingMine then
		return 
	end
	if mineRentManageWindow then
		sightexports.sGui:deleteGuiElement(mineRentManageWindow)
	end
	mineRentManageWindow = nil
	if unrentWindow then
		sightexports.sGui:deleteGuiElement(unrentWindow)
	end
	unrentWindow = nil
	showCursor(true)
	local w = 300
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	if mineLobbyDatas[currentStandingMine] then
		if mineLobbyDatas[currentStandingMine].canManage then
			local deltaRaw = mineLobbyDatas[currentStandingMine].rentUntil - getRealTime().timestamp
			local h = titleBarHeight + 32 + 8 + 76
			mineRentManageWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
			sightexports.sGui:setWindowTitle(mineRentManageWindow, "16/BebasNeueRegular.otf", "Bánya #" .. currentStandingMine)
			sightexports.sGui:setWindowCloseButton(mineRentManageWindow, "closeMineRentPanel")
			local y = titleBarHeight
			delta = deltaRaw / 3600
			if delta < 0.5 then
				delta = "kevesebb mint fél óra"
			elseif delta < 1 then
				delta = "kevesebb mint 1 óra"
			elseif delta < 24 then
				delta = math.floor(delta) .. " óra"
			else
				local days = math.floor(delta / 24)
				local hours = math.floor(delta) - days * 24
				if hours > 0 then
					delta = days .. " nap " .. hours .. " óra"
				else
					delta = days .. " nap"
				end
			end
			local label = sightexports.sGui:createGuiElement("label", 0, y, w, 32, mineRentManageWindow)
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			sightexports.sGui:setLabelText(label, "Bérlet lejár: " .. delta)
			sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
			sightexports.sGui:setLabelColor(label, "sightgreen")
			y = y + 32 + 8
			if deltaRaw < 86400 then
				local btn = sightexports.sGui:createGuiElement("button", 8, y, w - 16, 30, mineRentManageWindow)
				sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
				sightexports.sGui:setGuiHover(btn, "gradient", {
					"sightgreen",
					"sightgreen-second"
				}, false, true)
				sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
				if mineLobbyDatas[currentStandingMine].rentMode == "pp" then
					sightexports.sGui:setButtonText(btn, "Meghosszabbítás (1 hét - " .. sightexports.sGui:thousandsStepper(ppRentPrice) .. " PP)")
					sightexports.sGui:setClickEvent(btn, "rentMineWithPP")
				else
					sightexports.sGui:setButtonText(btn, "Meghosszabbítás (1 hét - " .. sightexports.sGui:thousandsStepper(rentPrice) .. " $)")
					sightexports.sGui:setClickEvent(btn, "rentMineWithCash")
				end
			else
				local label = sightexports.sGui:createGuiElement("label", 0, y, w, 30, mineRentManageWindow)
				sightexports.sGui:setLabelAlignment(label, "center", "center")
				sightexports.sGui:setLabelText(label, "Meghosszabbítani lejárat előtt 24 órával lehet.")
				sightexports.sGui:setLabelFont(label, "13/BebasNeueRegular.otf")
			end
			local btn = sightexports.sGui:createGuiElement("button", 8, y + 30 + 8, w - 16, 30, mineRentManageWindow)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightred",
				"sightred-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonText(btn, "Bérlet lemondása")
			sightexports.sGui:setClickEvent(btn, "unrentMine")
		end
	else
		local deltaRaw = titleBarHeight + 96 + 24 + 8 + 76
		mineRentManageWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - deltaRaw / 2, w, deltaRaw)
		sightexports.sGui:setWindowTitle(mineRentManageWindow, "16/BebasNeueRegular.otf", "Bánya #" .. currentStandingMine)
		sightexports.sGui:setWindowCloseButton(mineRentManageWindow, "closeMineRentPanel")
		local y = titleBarHeight
		local label = sightexports.sGui:createGuiElement("label", 0, y, w, 32, mineRentManageWindow)
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(rentPrice) .. " $ / hét")
		sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
		sightexports.sGui:setLabelColor(label, "sightgreen")
		y = y + 32
		local label = sightexports.sGui:createGuiElement("label", 0, y, w, 32, mineRentManageWindow)
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelText(label, " + " .. sightexports.sGui:thousandsStepper(rentPrice * 4) .. " $ egyszeri kaució")
		sightexports.sGui:setLabelFont(label, "13/BebasNeueBold.otf")
		sightexports.sGui:setLabelColor(label, "sightgreen")
		y = y + 32
		local btn = sightexports.sGui:createGuiElement("label", 0, y, w, 24, mineRentManageWindow)
		sightexports.sGui:setLabelAlignment(btn, "center", "center")
		sightexports.sGui:setLabelText(btn, "vagy")
		sightexports.sGui:setLabelFont(btn, "13/BebasNeueRegular.otf")
		y = y + 24
		local label = sightexports.sGui:createGuiElement("label", 0, y, w, 32, mineRentManageWindow)
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(ppRentPrice) .. " PP / hét")
		sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
		sightexports.sGui:setLabelColor(label, "sightblue")
		y = y + 32 + 8
		local pW = (w - 16) / 2 - 4
		local btn = sightexports.sGui:createGuiElement("button", 8, y, pW, 30, mineRentManageWindow)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(btn, "Bérlés ($)")
		sightexports.sGui:setClickEvent(btn, "rentMineWithCash")
		local btn = sightexports.sGui:createGuiElement("button", 8 + pW + 8, y, pW, 30, mineRentManageWindow)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightblue",
			"sightblue-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(btn, "Bérlés (PP)")
		sightexports.sGui:setClickEvent(btn, "rentMineWithPP")
		local btn = sightexports.sGui:createGuiElement("button", 8, y + 30 + 8, w - 16, 30, mineRentManageWindow)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightred",
			"sightred-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(btn, "Mégsem")
		sightexports.sGui:setClickEvent(btn, "closeMineRentPanel")
	end
end
addEvent("openMineRentPanel", false)
addEventHandler("openMineRentPanel", getRootElement(), openMineRentPanel)

addEvent("rentMineWithPP", false)
addEventHandler("rentMineWithPP", getRootElement(), function()
	triggerServerEvent("rentMineWithPP", localPlayer, currentStandingMine)
end)

addEvent("rentMineWithCash", false)
addEventHandler("rentMineWithCash", getRootElement(), function()
	triggerServerEvent("rentMineWithCash", localPlayer, currentStandingMine)
end)

addEvent("unrentMineFinal", false)
addEventHandler("unrentMineFinal", getRootElement(), function(_, _, _, _, _, id)
	-- line: [1199, 1205] id: 50
	if unrentWindow then
		sightexports.sGui:deleteGuiElement(unrentWindow)
	end
	unrentWindow = nil
	if id then
		triggerServerEvent("unrentMine", localPlayer, currentStandingMine)
	end
end)

addEvent("unrentMine", false)
addEventHandler("unrentMine", getRootElement(), function()
	if unrentWindow then
		sightexports.sGui:deleteGuiElement(unrentWindow)
	end
	unrentWindow = nil
	local w = 300
	local h = 150
	unrentWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
	sightexports.sGui:setWindowTitle(unrentWindow, "16/BebasNeueRegular.otf", "Albérlet lemondása")
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, w, h - titleBarHeight - 30 - 6 - 6, unrentWindow)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "Biztosan lemondod az albérleted?\nA bányából minden elvész.")
	sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	local bw = (w - 18) / 2
	local btn = sightexports.sGui:createGuiElement("button", 6, h - 30 - 6, bw, 30, unrentWindow)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(btn, "Igen")
	sightexports.sGui:setClickEvent(btn, "unrentMineFinal")
	sightexports.sGui:setClickArgument(btn, true)
	local btn = sightexports.sGui:createGuiElement("button", w - bw - 6, h - 30 - 6, bw, 30, unrentWindow)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightred",
		"sightred-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(btn, "Nem")
	sightexports.sGui:setClickEvent(btn, "unrentMineFinal")
end)

addEvent("closeMineRentPanel", false)
addEventHandler("closeMineRentPanel", getRootElement(), function()
	if mineRentManageWindow then
		sightexports.sGui:deleteGuiElement(mineRentManageWindow)
	end
	mineRentManageWindow = nil
	showCursor(false)
end)

function doStandingMineBox(id)
	local lobby, corridor = getLobbyFromMineId(id)
	if loadedMineLobby == getCorridorIdFromLobbyCorridor(lobby, corridor) then
		if mineLobbyDatas[id] then
			createIntiBox("mine", formatCorridorNameMineId(id), formatMineName(id) .. " (" .. id .. ")", "sightyellow", false, mineLobbyDatas[id].canLock, mineLobbyDatas[id].canManage)
		else
			createIntiBox("mine", formatCorridorNameMineId(id), formatMineName(id) .. " (" .. id .. ")", "sightgreen", true)
		end
	else
		createIntiBox()
	end
end

function initMineIntiBox()
	if loadedMineLobby then
		if currentStandingMine then
			doStandingMineBox(currentStandingMine)
		elseif inLobbyExitMarker then
			local lobby = getLobbyFromCorridor(loadedMineLobby)
			createIntiBox("mine", "Tierra Robada bánya", lobbyCoords[lobby][5] .. " bánya", "sightorange")
		else
			createIntiBox()
		end
	elseif currentMine then
		if inMineExitMarker then
			createIntiBox("mine", formatCorridorNameMineId(currentMine), formatMineName(currentMine) .. " (" .. currentMine .. ")", "sightyellow", false, checkMinePermission("lock"), false)
		else
			createIntiBox()
		end
	elseif currentStandingLobbyMarker then
		createIntiBox("mine", "Tierra Robada bánya", lobbyCoords[currentStandingLobbyMarker][5] .. " bánya", "sightorange")
	else
		createIntiBox()
	end
end

addEvent("changeEnteredCustomMarker", false)
addEventHandler("changeEnteredCustomMarker", getRootElement(), function(theType, id)
	currentStandingLobbyMarker = false
	inLobbyExitMarker = false
	currentStandingMine = false
	inMineExitMarker = false
	if theType == "mineLobbyInside" then
		currentStandingMine = id
	elseif theType == "mineLobbyExit" then
		inLobbyExitMarker = true
	elseif theType == "mineExit" and currentMine then
		inMineExitMarker = true
	elseif theType == "mineLobbyEnter" then
		currentStandingLobbyMarker = id
	end
	initMineIntiBox()
end)

function tryToBreakIn(itemDbId)
	if currentStandingMine and mineLobbyDatas[currentStandingMine] then
		if not mineLobbyDatas[currentStandingMine].locked then
			sightexports.sGui:showInfobox("e", "A bánya nyitva van!")
		else
			triggerServerEvent("tryToBreakInMine", localPlayer, currentStandingMine, itemDbId)
		end
	end
	return false
end

addEvent("closeMineLobbyEnterWindow", false)
addEventHandler("closeMineLobbyEnterWindow", getRootElement(), function()
	if mineLobbyEnterWindow then
		sightexports.sGui:deleteGuiElement(mineLobbyEnterWindow)
	end
	mineLobbyEnterWindow = nil
	showCursor(false)
end)

addEvent("tryToEnterMineLobby", false)
addEventHandler("tryToEnterMineLobby", getRootElement(), function(_, _, _, _, _, lobby)
	loadingMineLobby = lobby
	loadedMineLobby = false
	startLoader()
	if mineLobbyEnterWindow then
		sightexports.sGui:deleteGuiElement(mineLobbyEnterWindow)
	end
	mineLobbyEnterWindow = nil
	showCursor(false)
	setElementDimension(lobbyObject, lobby)
	setElementDimension(lobbyAlphaObject, lobby)
end)

function lockUnlockMine()
	if not isLoading() and not mineLobbyEnterWindow then
		if isPedInVehicle(localPlayer) then
			return 
		end
		if inMineExitMarker then
			triggerServerEvent("lockUnlockMine", localPlayer)
		elseif currentStandingMine then
			if not mineLobbyDatas[currentStandingMine] then
				openMineRentPanel()
				return 
			end
			if mineLobbyDatas[currentStandingMine].canLock or getElementData(localPlayer, "adminDuty") or sightexports.sPermission:hasPermission(localPlayer, "superUnlock") then
				triggerServerEvent("lockUnlockMine", localPlayer, currentStandingMine)
			end
		end
	end
end


addEvent("lockUnlockMine", false)
addEventHandler("lockUnlockMine", getRootElement(), lockUnlockMine)
bindKey("K", "up", lockUnlockMine)
bindKey("E", "up", function()
	if not isLoading() and not mineLobbyEnterWindow and not mineRentManageWindow then
		if currentStandingMine then
			if not mineLobbyDatas[currentStandingMine] then
				openMineRentPanel()
				return 
			end
			if isPedInVehicle(localPlayer) then
				return 
			end
			if mineLobbyDatas[currentStandingMine].locked then
				triggerServerEvent("tryToEnterMine", localPlayer, currentStandingMine)
				return 
			end
			loadingMineEnter = currentStandingMine
			loadingMineEnterSynced = false
			print(currentStandingMine)
			setElementDimension(mineHq, currentStandingMine)
			startLoader()
		elseif inMineExitMarker then
			if isPedInVehicle(localPlayer) then
				return 
			end
			loadingMineExit = true
			loadingMineExitSynced = false
			startLoader()
		elseif inLobbyExitMarker then
			if isPedInVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer) ~= 0 then
				return 
			end
			local veh = getPedOccupiedVehicle(localPlayer)
			if veh then
				setElementData(veh, "vehicle.gear", "N")
			end
			loadingMineLobbyExit = true
			loadingMineLobbyExitSynced = false
			startLoader()
		elseif currentStandingLobbyMarker then
			local lobbyId = currentStandingLobbyMarker
			if isPedInVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer) ~= 0 then
				return 
			end
			if mineLobbyEnterWindow then
				sightexports.sGui:deleteGuiElement(mineLobbyEnterWindow)
			end
			mineLobbyEnterWindow = nil
			local veh = getPedOccupiedVehicle(localPlayer)
			if veh then
				setElementData(veh, "vehicle.gear", "N")
			end
			local titleBarHeight = sightexports.sGui:getTitleBarHeight()
			local w = 300
			local h = titleBarHeight + 48 * lobbyCoords[lobbyId][6] + 16
			mineLobbyEnterWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
			sightexports.sGui:setWindowTitle(mineLobbyEnterWindow, "16/BebasNeueRegular.otf", lobbyCoords[lobbyId][5] .. " bánya")
			sightexports.sGui:setWindowCloseButton(mineLobbyEnterWindow, "closeMineLobbyEnterWindow")
			showCursor(true)
			local y = titleBarHeight + 8
			local x = 0
			local baseId = getLobbyCorridorBaseId(lobbyId)
			for i = 1, lobbyCoords[lobbyId][6], 1 do
				local x = x + 8
				local marked = isCorridorMarked(lobbyId, i)
				if marked then
					local img = sightexports.sGui:createGuiElement("image", x, y + 24 - 10, 20, 20, mineLobbyEnterWindow)
					sightexports.sGui:setImageFile(img, sightexports.sGui:getFaIconFilename("circle", 24))
					sightexports.sGui:setImageColor(img, marked)
					x = x + 20 + 8
				end
				local label = sightexports.sGui:createGuiElement("label", x, y, 0, 24, mineLobbyEnterWindow)
				sightexports.sGui:setLabelAlignment(label, "left", "center")
				sightexports.sGui:setLabelText(label, i .. ". járat")
				sightexports.sGui:setLabelColor(label, "sightgreen")
				sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
				local label = sightexports.sGui:createGuiElement("label", x, y + 24, 0, 24, mineLobbyEnterWindow)
				sightexports.sGui:setLabelAlignment(label, "left", "center")
				sightexports.sGui:setLabelText(label, lobbyCoords[lobbyId][5] .. " bánya")
				sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
				local btn = sightexports.sGui:createGuiElement("button", w - 32 - 8, y + 24 - 16, 32, 32, mineLobbyEnterWindow)
				sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
				sightexports.sGui:setGuiHover(btn, "gradient", {
					"sightgreen",
					"sightgreen-second"
				}, false, true)
				sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
				sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("sign-in-alt", 32))
				sightexports.sGui:setClickEvent(btn, "tryToEnterMineLobby")
				sightexports.sGui:setClickArgument(btn, baseId + i)
				sightexports.sGui:guiSetTooltip(btn, "Belépés")
				y = y + 48
				if i < lobbyCoords[lobbyId][6] then
					local border = sightexports.sGui:createGuiElement("hr", x, y - 1, w - 16, 2, mineLobbyEnterWindow)
				end
			end
		end
	end
end)

local spotLights = {}
local entranceLights = {}
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	for i = 1, #lobbyCoords, 1 do
		local x = lobbyCoords[i][7]
		local y = lobbyCoords[i][8]
		local z = lobbyCoords[i][9]
		local rad = math.rad(lobbyCoords[i][10])
		local cos = math.cos(rad)
		local sin = math.sin(rad)
		spotLights[i] = {
			x - cos * 0.62,
			y - sin * 0.62,
			z + 1.0685,
			cos,
			sin
		}
		entranceLights[i] = {}
		local lx = x - cos * 0.4812
		local ly = y - sin * 0.4812
		local lu = z + 1.6449
		local ts = 0
		for j = 1, utf8.len(lobbyCoords[i][5]), 1 do
			local currentChar = charset[utf8.upper(utf8.sub(lobbyCoords[i][5], j, j))]
			if currentChar then
				local d = currentChar[2] * 0.015625 / 2
				lx = lx + sin * d
				ly = ly - cos * d
				table.insert(entranceLights[i], {
					lx,
					ly,
					lu,
					-cos,
					-sin,
					currentChar[1],
					currentChar[2]
				})
				lx = lx + sin * d
				ly = ly - cos * d
				ts = ts + d * 2
			else
				local d = 0.4375
				lx = lx + sin * d
				ly = ly - cos * d
				ts = ts + d
			end
		end
		ts = ts / 2
		for j = 1, #entranceLights[i], 1 do
			if entranceLights[i][j] then
				entranceLights[i][j][1] = entranceLights[i][j][1] - sin * ts
				entranceLights[i][j][2] = entranceLights[i][j][2] + cos * ts
			end
		end
	end
	processSpotlights()
end)
local lightElements = {}
local oldNightTime = false
function processSpotlights()
	local time = getTime()
	local nightTime = nil
	if time < 21 then
		nightTime = time <= 8
	else
		nightTime = true
	end
	if oldNightTime ~= nightTime then
		oldNightTime = nightTime
		for i = 1, #lightElements, 1 do
			if isElement(lightElements[i]) then
				destroyElement(lightElements[i])
			end
			lightElements[i] = nil
		end
		lightElements = {}
		if nightTime then
			for i = 1, #lobbyCoords, 1 do
				local x, y, z, rx, ry = unpack(spotLights[i])
				table.insert(lightElements, createSearchLight(x - rx * 0.05, y - ry * 0.05, z, x - rx * 2.5, y - ry * 2.5, z - 4.25, 0.1, 75))
				local spotSound = playSound3D("files/minesound/spot.mp3", x, y, z, false)
				setSoundMaxDistance(spotSound, 40)
				setSoundVolume(spotSound, 2)
			end
		end
	end
end
setTimer(processSpotlights, 60000, 0)

function preRenderMineEntrance()
	if oldNightTime then
		for i = 1, #streamedInEntrances, 1 do
			local entrance = streamedInEntrances[i]
			if isElement(streamedInEntrances[entrance]) and isElementOnScreen(streamedInEntrances[entrance]) then
				local x, y, z, w, h = unpack(spotLights[entrance])
				sightlangStaticImageUsed[2] = true
				if sightlangStaticImageToc[2] then
					processSightlangStaticImage[2]()
				end
				dxDrawMaterialLine3D(x, y, z + 1, x, y, z - 1, sightlangStaticImage[2], 2, tocolor(225, 225, 255, 255), x + w, y + h, z)
			end
		end
	end
	local tex = getTableTex()
	for i = 1, #streamedInEntrances, 1 do
		local entrance = streamedInEntrances[i]
		if isElement(lobbyObjectsEx[entrance]) and isElementOnScreen(lobbyObjectsEx[entrance]) then
			for j = 1, #entranceLights[entrance], 1 do
				local x, y, z, w, h, u, v = unpack(entranceLights[entrance][j])
				dxDrawMaterialSectionLine3D(x, y, z + 0.5, x, y, z - 0.5, u, 0, v, 64, tex, v * 0.015625, tocolor(15, 15, 15, 220), x + w, y + h, z)
			end
		end
	end
end


function mineEntranceStreamedIn()
  -- line: [163, 170] id: 6
  table.insert(streamedInEntrances, lobbyObjectsEx[source])
  if not r1_0 then
    addEventHandler("onClientPreRender", root, preRenderMineEntrance)
    r1_0 = true
  end
end

streamedInEntrances = {}
lobbyObjectsEx = {}

function mineEntranceStreamedOut()
  -- line: [172, 188] id: 7
  local r0_7 = lobbyObjectsEx[source]
  for r4_7 = #streamedInEntrances, 1, -1 do
    if streamedInEntrances[r4_7] == r0_7 then
      table.remove(streamedInEntrances, r4_7)
      break
    end
  end
  if #streamedInEntrances <= 0 and r1_0 then
    removeEventHandler("onClientPreRender", root, preRenderMineEntrance)
    r1_0 = false
  end
end

function r26_0()
  -- line: [99, 121] id: 2
  for r3_2 = 1, #lobbyCoords, 1 do
    local r4_2 = lobbyCoords[r3_2]
    if r4_2 then
      if not streamedInEntrances[r3_2] then
        local r5_2 = createObject(modelIds[r4_2[11]], r4_2[7], r4_2[8], r4_2[9], 0, 0, r4_2[10])
        if isElement(r5_2) then
          addEventHandler("onClientElementStreamIn", r5_2, mineEntranceStreamedIn)
          addEventHandler("onClientElementStreamOut", r5_2, mineEntranceStreamedOut)
        end
        lobbyObjectsEx[r3_2] = r5_2
        streamedInEntrances[r3_2] = r3_2
      elseif isElement(streamedInEntrances[r3_2]) then
        setElementModel(streamedInEntrances[r3_2], modelIds[r4_2[11]])
      end
    end
  end
end

r7_0 = {}