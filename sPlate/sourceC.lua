local sightexports = {
	sGui = false,
	sGroups = false,
	sMdc = false,
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
		sightlangStaticImage[0] = dxCreateTexture("files/plate_sight.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/charset.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[2] = function()
	if not isElement(sightlangStaticImage[2]) then
		sightlangStaticImageToc[2] = false
		sightlangStaticImage[2] = dxCreateTexture("files/light.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
local searchIcon = false
local loader = false
local faTicks = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		searchIcon = sightexports.sGui:getFaIconFilename("search", 48)
		loader = sightexports.sGui:getFaIconFilename("circle-notch", 48)
		faTicks = sightexports.sGui:getFaTicks()
		refreshColors()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
	faTicks = sightexports.sGui:getFaTicks()
end)
local charset = {
	A = {0, 0},
	B = {1, 0},
	C = {2, 0},
	D = {3, 0},
	E = {0, 1},
	F = {1, 1},
	G = {2, 1},
	H = {3, 1},
	I = {0, 2},
	J = {1, 2},
	K = {2, 2},
	L = {3, 2},
	M = {0, 3},
	N = {1, 3},
	O = {2, 3},
	P = {3, 3},
	Q = {0, 4},
	R = {1, 4},
	S = {2, 4},
	T = {3, 4},
	U = {0, 5},
	V = {1, 5},
	W = {2, 5},
	X = {3, 5},
	Y = {0, 6},
	Z = {1, 6},
	["0"] = {2, 6},
	["1"] = {3, 6},
	["2"] = {0, 7},
	["3"] = {1, 7},
	["4"] = {2, 7},
	["5"] = {3, 7},
	["6"] = {0, 8},
	["7"] = {1, 8},
	["8"] = {2, 8},
	["9"] = {3, 8}
}
function drawPlate(x, y, sx, text, a, l, veh)
	x = x - sx / 2
	y = y - sx / 2

	local type = exports.sSpeedo:isVehicleElectric(veh) and 2 or 1

	dxDrawImage(x, y, sx, sx / 2, "files/plate_".. type .."_sight.png", 0, 0, 0, tocolor(255, 255, 255, a))
	local r = sx / 256
	local w = (sx - 30 * r) / 8
	for i = 1, 8 do
		local letter = utf8.sub(text, i, i)
		if letter and charset[letter] then
			sightlangStaticImageUsed[1] = true
			if sightlangStaticImageToc[1] then
				processsightlangStaticImage[1]()
			end
			local tex = sightlangStaticImage[1]
			local x, y = x + sx / 2 - w * 8 / 2 + (i - 1) * w - 2, y + 36 * r
			dxDrawImageSection(x + 1, y + 1, w + 2, 76 * r, charset[letter][1] * 32, charset[letter][2] * 64, 32, 64, tex, 0, 0, 0, tocolor(129, 134, 133, a))
			dxDrawImageSection(x - 1, y - 1, w + 2, 76 * r, charset[letter][1] * 32, charset[letter][2] * 64, 32, 64, tex, 0, 0, 0, tocolor(216, 221, 220, 0.75 * a))
			dxDrawImageSection(x, y, w + 2, 76 * r, charset[letter][1] * 32, charset[letter][2] * 64, 32, 64, tex, 0, 0, 0, tocolor(25, 25, 25, a))
		end
	end
	if l then
		sightlangStaticImageUsed[2] = true
		if sightlangStaticImageToc[2] then
			processsightlangStaticImage[2]()
		end
		dxDrawImage(x, y, sx, sx / 2, sightlangStaticImage[2], 0, 0, 0, tocolor(255, 255, 255, a))
	end
end
local canSearch = false
function processPDSearch()
	canSearch = sightexports.sGroups:getPlayerPermission("mdc")
end
function hideSearchSymbol(searchState)
	canSearch = searchState
end
local blue = false
local snowIcon = false
function refreshColors()
	blue = sightexports.sGui:getColorCode("sightblue")
	snowIcon = sightexports.sGui:getFaIconFilename("snowflake", 48)
end
local maxD = 75
local screenX, screenY = guiGetScreenSize()
local currentTooltip = false
local currentHover = false
local gotVehicleDatas = {}
local winterTires = {}
local vehs = getElementsByType("vehicle", getRootElement(), true)
for i = 1, #vehs do
	winterTires[vehs[i]] = getElementData(vehs[i], "winterTires")
end
addEventHandler("onClientElementDestroy", getRootElement(), function()
	gotVehicleDatas[source] = nil
	winterTires[source] = nil
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
	gotVehicleDatas[source] = nil
	winterTires[source] = nil
end)
addEventHandler("onClientElementStreamIn", getRootElement(), function()
	if getElementType(source) == "vehicle" then
		winterTires[source] = getElementData(source, "winterTires")
	end
end)
addEventHandler("onClientElementDataChange", getRootElement(), function(data, old, new)
	if data == "winterTires" and isElementStreamedIn(source) then
		winterTires[source] = new
	end
end)
addEvent("gotVehiclePlateSearch", true)
addEventHandler("gotVehiclePlateSearch", getRootElement(), function(veh, valid, warrant, warrantPlate)
	if isElement(veh) then
		local col = false
		local mdcCol = false
		if warrant or warrantPlate then
			col = sightexports.sGui:getColorCodeToColor("sightred")
			mdcCol = "red"
		elseif tonumber(valid) then
			col = sightexports.sGui:getColorCodeToColor("sightorange")
			mdcCol = "yellow"
		elseif valid then
			col = sightexports.sGui:getColorCodeToColor("sightgreen")
		else
			col = sightexports.sGui:getColorCodeToColor("sightred")
			mdcCol = "red"
		end
		if tonumber(valid) then
			valid = sightexports.sGui:getColorCodeHex("sightorange") .. valid .. " érvénytelen bejegyzés"
		elseif valid then
			valid = sightexports.sGui:getColorCodeHex("sightgreen") .. "érvényes"
		else
			valid = sightexports.sGui:getColorCodeHex("sightred") .. "lejárt"
		end
		if warrant then
			warrant = sightexports.sGui:getColorCodeHex("sightred") .. "igen"
		else
			warrant = sightexports.sGui:getColorCodeHex("sightgreen") .. "nem"
		end
		if warrantPlate then
			warrantPlate = sightexports.sGui:getColorCodeHex("sightred") .. "igen"
		else
			warrantPlate = sightexports.sGui:getColorCodeHex("sightgreen") .. "nem"
		end
		gotVehicleDatas[veh] = {
			getTickCount(),
			valid,
			warrant,
			warrantPlate,
			col
		}
		local id = tonumber(getElementData(veh, "vehicle.dbID"))
		if id then
			local text = getVehiclePlateText(veh)
			text = split(text, "-")
			sightexports.sMdc:addLastPlate(id, table.concat(text, "-"), mdcCol)
		end
	end
end)
function renderPlates()
	local now = getTickCount()
	local curX, curY
	if canSearch then
		curX, curY = getCursorPosition()
		if curX then
			curX = curX * screenX
			curY = curY * screenY
		end
	end
	local tmp = false
	local tmpH = false
	local px, py, pz = getElementPosition(localPlayer)
	local cx, cy, cz = getCameraMatrix()
	local pv = getPedOccupiedVehicle(localPlayer)
	local vehs = getElementsByType("vehicle", getRootElement(), true)
	for i = 1, #vehs do
		if vehs[i] ~= pv then
			local text = getVehiclePlateText(vehs[i])
			if text then
				local x, y, z = getElementPosition(vehs[i])
				z = z + 1.25
				local d = getDistanceBetweenPoints3D(x, y, z, cx, cy, cz)
				if d < maxD and isLineOfSightClear(x, y, z, cx, cy, cz, true, true, false, true, false, true, false, vehs[i]) then
					local x, y = getScreenFromWorldPosition(x, y, z, 128)
					if x and y and getElementAlpha(vehs[i]) > 0 then
						local p = d / maxD
						local sx = 128 * math.min(1, 10 / d)
						drawPlate(x, y, sx, text, 255 * (1 - p), getVehicleOverrideLights(vehs[i]) == 2, vehs[i])
						local h = sx / 2
						if winterTires[vehs[i]] then
							local x = x - sx / 2 - sx * 0.1 - h * 0.65
							dxDrawImage(x, y - h / 2 - h * 0.65 / 2, h * 0.65, h * 0.65, ":sGui/" .. snowIcon .. faTicks[snowIcon], 0, 0, 0, tocolor(blue[1], blue[2], blue[3], 255 * (1 - p)))
						end
						if canSearch and p <= 0.25 then
							local x = x + sx / 2 + sx * 0.1
							if gotVehicleDatas[vehs[i]] and gotVehicleDatas[vehs[i]] == "loading" then
								dxDrawImage(x, y - h / 2 - h * 0.65 / 2, h * 0.65, h * 0.65, ":sGui/" .. loader .. faTicks[loader], now / 5 % 360)
							elseif gotVehicleDatas[vehs[i]] then
								if now - gotVehicleDatas[vehs[i]][1] >= 150000 then
									gotVehicleDatas[vehs[i]] = nil
									dxDrawImage(x, y - h / 2 - h * 0.65 / 2, h * 0.65, h * 0.65, ":sGui/" .. searchIcon .. faTicks[searchIcon])
								else
									dxDrawImage(x, y - h / 2 - h * 0.65 / 2, h * 0.65, h * 0.65, ":sGui/" .. searchIcon .. faTicks[searchIcon], 0, 0, 0, gotVehicleDatas[vehs[i]][5])
								end
							else
								dxDrawImage(x, y - h / 2 - h * 0.65 / 2, h * 0.65, h * 0.65, ":sGui/" .. searchIcon .. faTicks[searchIcon])
							end
							if curX and curX >= x and curY >= y - h / 2 - h * 0.65 / 2 and curX <= x + h * 0.65 and curY <= y - h / 2 + h * 0.65 / 2 then
								if gotVehicleDatas[vehs[i]] then
									if gotVehicleDatas[vehs[i]] ~= "loading" then
										tmp = "Forgalmi engedély: " .. gotVehicleDatas[vehs[i]][2] .. "\nKörözött tulajdonos: " .. gotVehicleDatas[vehs[i]][3] .. "\nKörözött rendszám: " .. gotVehicleDatas[vehs[i]][4]
										tmpH = vehs[i]
									end
								else
									text = table.concat(split(text, "-"), "-")
									tmp = "Rendszám lekérdezése (" .. text .. ")"
									tmpH = vehs[i]
								end
							end
						end
					end
				end
			end
		end
	end
	if tmp ~= currentTooltip then
		currentTooltip = tmp
		sightexports.sGui:showTooltip(currentTooltip)
	end
	if tmpH ~= currentHover then
		currentHover = tmpH
		sightexports.sGui:setCursorType(currentHover and "link" or "normal")
	end
end
function requestVehicle(veh)
	if canSearch and isElement(veh) then
		local id = tonumber(getElementData(veh, "vehicle.dbID"))
		if id then
			triggerLatentServerEvent("requestVehiclePlateSearch", localPlayer, veh)
		else
			gotVehicleDatas[veh] = {
				getTickCount(),
				sightexports.sGui:getColorCodeHex("sightgreen") .. "érvényes",
				sightexports.sGui:getColorCodeHex("sightgreen") .. "nem",
				sightexports.sGui:getColorCodeHex("sightgreen") .. "nem",
				sightexports.sGui:getColorCodeToColor("sightgreen")
			}
		end
	end
end
function clickPlates(button, state)
	if state == "up" and isElement(currentHover) then
		gotVehicleDatas[currentHover] = "loading"
		setTimer(requestVehicle, math.random(500, 1200), 1, currentHover)
	end
end
local plateState = false
bindKey("F10", "down", function()
	setPlatesVisible(not plateState)
	sightexports.sDashboard:saveValue("plateState", plateState and 1 or 0)
end)
function setPlatesVisible(state)
	if state ~= plateState then
		plateState = state
		if plateState then
			addEventHandler("onClientRender", getRootElement(), renderPlates)
			addEventHandler("onClientClick", getRootElement(), clickPlates)
			processPDSearch()
		else
			removeEventHandler("onClientRender", getRootElement(), renderPlates)
			removeEventHandler("onClientClick", getRootElement(), clickPlates)
			if currentTooltip then
				currentTooltip = false
				sightexports.sGui:showTooltip(false)
			end
			currentHover = false
			sightexports.sGui:setCursorType("normal")
		end
	end
end
function getPlatesVisible()
	return plateState
end
addEvent("gotPlayerGroupPermissions", true)
addEventHandler("gotPlayerGroupPermissions", getRootElement(), function()
	processPDSearch()
end)

local plateTextures = {}

local plateBackTextures = {}
local plateBackShaders = {}

local plateTargets = {}

function applyPlateTexture(veh)
	if isElement(plateBackTextures[veh]) then
		destroyElement(plateBackTextures[veh])
	end

	if isElement(plateTextures[veh]) then
		destroyElement(plateTextures[veh])
	end

	if isElement(plateBackShaders[veh]) then
		destroyElement(plateBackShaders[veh])
	end

	if isElement(plateTargets[veh]) then
		destroyElement(plateTargets[veh])
	end

	if getElementData(veh, "vehicle.dbID") or getElementData(veh, "electricPreview") then
		local plateType = (exports.sSpeedo:isVehicleElectric(veh) or getElementData(veh, "electricPreview")) and 2 or 1

		if not plateBackTextures[plateType] then
			plateBackTextures[plateType] = dxCreateTexture("files/plate_".. plateType .."_sight.png")
		end

		plateTextures[veh] = dxCreateShader("texturechanger.fx", 0, 100, false, "vehicle")

		plateBackShaders[veh] = dxCreateShader("texturechanger.fx", 0, 100, false, "vehicle")

		plateTargets[veh] = dxCreateRenderTarget(256, 128, false)

		dxSetRenderTarget(plateTargets[veh], true)
			dxDrawImage(-100, -100 - 25, 256 + 200, 128 + 200, plateBackTextures[plateType])
			local text = getVehiclePlateText(veh):gsub("-", " ") or getElementData(veh, "plateText"):gsub("-", " ") or "RENDSZAM"

			local x, y = 0, 0

			a = 255

			drawPlateString(text, 0 + 1, 0 + 1, 256, 128, false, tocolor(129, 134, 133, a))
			drawPlateString(text, 0 - 1, 0 - 1, 256, 128, false, tocolor(216, 221, 220, 0.75 * a))
			drawPlateString(text, 0, 0, 256, 128, false, tocolor(25, 25, 25, a))
		dxSetRenderTarget()
		dxSetShaderValue(plateTextures[veh], "gTexture", plateTargets[veh])
		dxSetShaderValue(plateBackShaders[veh], "gTexture", plateBackTextures[plateType])
		engineApplyShaderToWorldTexture(plateBackShaders[veh], "plateback*", veh)
		engineApplyShaderToWorldTexture(plateTextures[veh], "custom_car_plate", veh)
	end
end

addEventHandler("onClientRestore", root, function(cleared)
	for k, v in pairs(getElementsByType("vehicle", root, true)) do
		applyPlateTexture(v)
	end
end)

function applyVehiclePlate(vehicleElement, changed)
	if changed then
		if isElementStreamedIn(vehicleElement) then
			applyPlateTexture(vehicleElement)
		end
	else
		applyPlateTexture(vehicleElement)
	end
end
addEvent("applyVehiclePlate", true)
addEventHandler("applyVehiclePlate", root, applyVehiclePlate)

function started()
	for k, v in pairs(getElementsByType("vehicle", root, true)) do
		applyPlateTexture(v)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, started)

function streamIn(vehElement)

	local validElement = isElement(source)

	if (not validElement) then
		return false
	end

	local elementType = getElementType(source)
	local vehicleType = (elementType == "vehicle")

	if (not vehicleType) then
		return false
	end

	applyPlateTexture(source)
end
addEventHandler("onClientElementStreamIn", root, streamIn)

function streamOut()
	if getElementType(source) == "vehicle" then
		local veh = source
		if isElement(plateBackTextures[veh]) then
			destroyElement(plateBackTextures[veh])
		end

		if isElement(plateTextures[veh]) then
			destroyElement(plateTextures[veh])
		end

		if isElement(plateBackShaders[veh]) then
			destroyElement(plateBackShaders[veh])
		end

		if isElement(plateTargets[veh]) then
			destroyElement(plateTargets[veh])
		end
	end
end
addEventHandler("onClientElementStreamOut", root, streamOut)

function destroyed()
	if getElementType(source) == "vehicle" then
		local veh = source
		if isElement(plateBackTextures[veh]) then
			destroyElement(plateBackTextures[veh])
		end

		if isElement(plateTextures[veh]) then
			destroyElement(plateTextures[veh])
		end

		if isElement(plateBackShaders[veh]) then
			destroyElement(plateBackShaders[veh])
		end

		if isElement(plateTargets[veh]) then
			destroyElement(plateTargets[veh])
		end
	end
end
addEventHandler("onClientElementDestroy", root, destroyed)

local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
local charWidth  = 32
local charHeight = 64

local charTable = {}

for i = 1, #charset do
    local ch = charset:sub(i, i)
    local index = i - 1
    local row = math.floor(index / 4)
    local col = index % 4
    charTable[ch] = {
        x = col * charWidth,
        y = row * charHeight,
        w = charWidth,
        h = charHeight
    }
end

charTable[" "] = {
    x = 0,            
    y = 0,  
    w = charWidth,
    h = 10
}

function drawPlateString(text, areaX, areaY, areaW, areaH, maintainAspect, plateColor)
    maintainAspect = maintainAspect == nil and true or maintainAspect

    local textLength = #text
    if textLength == 0 then return end

    local origWidth = textLength * charWidth
    local origHeight = charHeight

    local scaleX = areaW / origWidth
    local scaleY = areaH / origHeight

    local actualScaleX, actualScaleY
    if maintainAspect then
        local scale = math.min(scaleX, scaleY)
        actualScaleX = scale
        actualScaleY = scale
    else
        actualScaleX = scaleX
        actualScaleY = scaleY
    end

    local totalTextWidth = origWidth * actualScaleX
    local totalTextHeight = origHeight * actualScaleY

    local startX = areaX + (areaW - totalTextWidth) / 2
    local startY = areaY + (areaH - totalTextHeight) / 2

    local offsetX = 0
    for i = 1, textLength do
        local ch = text:sub(i, i)
        local pos = charTable[ch] or charTable[" "]
        
        if pos then
            dxDrawImageSection(
                startX + offsetX,  
                startY,            
                charWidth * actualScaleX,
                charHeight * actualScaleY,
                pos.x,              
                pos.y,              
                pos.w,             
                pos.h,              
                "files/charset.dds",
                0, 0, 0,           
                plateColor
            )
            offsetX = offsetX + charWidth * actualScaleX
        else
            offsetX = offsetX + (4 * actualScaleX)
        end
    end
end
