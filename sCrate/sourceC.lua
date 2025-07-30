local sightexports = {
	sGui = false,
	sModloader = false,
	sControls = false,
	sItems = false,
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
local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processSightlangStaticImage = {}
sightlangStaticImageToc[0] = true
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
	if sightlangStaticImageToc[0] then
		sightlangStatImgHand = false
		removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
	end
end
processSightlangStaticImage[0] = function()
	if not isElement(sightlangStaticImage[0]) then
		sightlangStaticImageToc[0] = false
		sightlangStaticImage[0] = dxCreateTexture("files/gecus.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
local font = false
local fontScale = false
local v4grey = false
local v4green = false
local v4blue = false
local v4red = false
local btnFont = false
local btnFontScale = false
local circle1 = false
local circle2 = false
local faTicks = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		font = sightexports.sGui:getFont("12/BebasNeueBold.otf")
		fontScale = sightexports.sGui:getFontScale("12/BebasNeueBold.otf")
		v4grey = sightexports.sGui:getColorCode("sightgrey1")
		v4green = sightexports.sGui:getColorCode("sightgreen")
		v4blue = sightexports.sGui:getColorCode("sightblue")
		v4red = sightexports.sGui:getColorCode("sightred")
		btnFont = sightexports.sGui:getFont("14/BebasNeueBold.otf")
		btnFontScale = sightexports.sGui:getFontScale("14/BebasNeueBold.otf")
		circle1 = sightexports.sGui:getFaIconFilename("circle", 96, "solid")
		circle2 = sightexports.sGui:getFaIconFilename("circle", 96, "light")
		faTicks = sightexports.sGui:getFaTicks()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
	faTicks = sightexports.sGui:getFaTicks()
end)
local screenX, screenY = guiGetScreenSize()
local shaderSource = [[
#include "files/mta-helper.fx"
 struct PSInput { float4 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; }; struct VSInput { float3 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord : TEXCOORD0; }; texture MaskTexture; sampler2D MaskSampler = sampler_state { Texture = (MaskTexture); }; texture CutTexture; sampler2D CutSampler = sampler_state { Texture = (CutTexture); }; sampler2D OrigSampler = sampler_state { Texture = (gTexture0); }; float4 PixelShaderFunction(PSInput PS) : COLOR0 { float4 col = tex2D(OrigSampler, PS.TexCoord); float4 cut = tex2D(CutSampler, PS.TexCoord); float4 mask = tex2D(MaskSampler, PS.TexCoord); col.rgb = lerp(col.rgb, cut.rgb, mask.r); return col*PS.Diffuse; } technique Technique1 { pass Pass1 { AlphaBlendEnable = true; AlphaFunc = GreaterEqual; PixelShader = compile ps_2_0 PixelShaderFunction(); } } ]]
local fadeCX, fadeCY, fadeCZ, fadeTX, fadeTY, fadeTZ
local fadeStart = getTickCount()
local currentPos = false
local objX, objY, objZ = 7467.671875, 264.1005859375, 4.4523830413818
local rot = 0
local cType = false
local atmMoney = false
local obj = false
local top = false
local money = false
local flex = false
local flexDisc = false
local shader = false
local items = {}
local rt = false
local cutTex = false
local rtLongSide = 312.8612127926175
local rtShortSide = 199.1387872073825
local rtLongSideATM = 338.6808106562581
local rtShortSideATM = 173.31918934374198
local flexD = 1
local flexX, flexY, flexZ = 0, 0, 0
local flexNX, flexNY, flexNZ = 0, 0, 0
local flexR = 0
local objR = 270
local objRT = 270
local cutProg = 0
local endP = 0
local endP2 = 0
local endP3 = -2000
local lootSoundPlayed = false
local syncList = false
local syncTime = 0
local toSync = false
local cutting = false
local atmMinigameButtons = {
	"W",
	"A",
	"S",
	"D",
	"R",
	"F",
	"G",
	"X",
	"C"
}
local atmMinigameButton = atmMinigameButtons[math.random(1, #atmMinigameButtons)]
local atmMinigameCircle = 1
local atmMinigameSpeed = 1
local atmMinigameCorner = math.random(1, 4)
local atmMinigameRound = 1
local atmMinigameSuccess = false
local atmMinigameX = 0
local atmMinigameY = 0
local targetAtmMinigameX = 0
local targetAtmMinigameY = 0
local openSynced = false
function crateOpenKey(key, state)
	if state then
		if cutProg < 1 then
			if key == "arrow_l" or key == "a" then
				objRT = (objRT + 90) % 360
				triggerServerEvent("rotateCrateOpening", localPlayer, syncList, objRT)
				cancelEvent()
			elseif key == "arrow_r" or key == "d" then
				objRT = (objRT - 90) % 360
				triggerServerEvent("rotateCrateOpening", localPlayer, syncList, objRT)
				cancelEvent()
			elseif key == "backspace" then
				triggerServerEvent("tryToExitCrateOpening", localPlayer)
				cancelEvent()
			end
		elseif cType == "atm" and 1 <= endP and atmMinigameRound < 10 then
			if key == utf8.lower(atmMinigameButton) then
				local rad = math.rad(objR)
				local cos = math.cos(rad)
				local sin = math.sin(rad)
				local xd = 0.0075 * (atmMinigameCorner % 2 == 1 and -1 or 1)
				local yd = 0.0075 * (2 < atmMinigameCorner and -1 or 1)
				targetAtmMinigameX = cos * xd + sin * yd
				targetAtmMinigameY = sin * xd - cos * yd
				atmMinigameButton = atmMinigameButtons[math.random(1, #atmMinigameButtons)]
				atmMinigameCircle = 1
				atmMinigameSpeed = atmMinigameSpeed * 1.25
				local old = atmMinigameCorner
				while atmMinigameCorner == old do
					atmMinigameCorner = math.random(1, 4)
				end
				atmMinigameRound = atmMinigameRound + 1
				playSound("files/move" .. math.random(1, 4) .. ".mp3")
				if 10 <= atmMinigameRound then
					atmMinigameSuccess = true
					if not openSynced then
						openSynced = true
						triggerServerEvent("syncCrateOpened", localPlayer, syncList, true)
					end
					atmMinigameRound = 10
				end
			else
				playSound("files/pop.mp3")
				sightexports.sGui:showInfobox("e", "Rossz gombot nyomtál!")
				addGecus(objX, objY, objZ)
				if not openSynced then
					openSynced = true
					triggerServerEvent("syncCrateOpened", localPlayer, syncList)
				end
				atmMinigameRound = 10
				setElementModel(obj, sightexports.sModloader:getModelId("container_atm2"))
				setElementModel(money, sightexports.sModloader:getModelId("container_atm_cash2"))
			end
			cancelEvent()
		end
	end
end
local loopSound = false
local cutSound = false
local progress = {}
local fadeProg = 0
function playLootSound()
	playSound("files/loot" .. math.random(1, 2) .. ".mp3")
end
local sparks = {}
local sparksEx = {}
local hitCursor = false
local gecusEffect = {}
function addGecus(x, y, z)
	for i = 1, 25 do
		local r = math.rad(math.pi * 2 * math.random())
		local d = 0.75 * math.random()
		local sin = math.sin(r) * d
		local cos = math.cos(r) * d
		table.insert(gecusEffect, {
			x,
			y,
			z,
			0,
			sin,
			cos,
			math.random() * 0.5,
			1,
			0.5 + 0.5 * math.random(),
			1.5 + 0.75 * math.random()
		})
	end
end
function preRenderCrateOpen(delta)
	if not streamedHandled and 1 <= #gecusEffect then
		local x, y, z = getWorldFromScreenPosition(screenX / 2, 0, 128)
		local x2, y2, z2 = getWorldFromScreenPosition(screenX / 2, screenY / 2, 128)
		x = x2 - x
		y = y2 - y
		z = z2 - z
		local len = math.sqrt(x * x + y * y + z * z) * 2
		x = x / len
		y = y / len
		z = z / len
		for i = #gecusEffect, 1, -1 do
			local data = gecusEffect[i]
			data[1] = data[1] + data[5] * delta / 1000
			data[2] = data[2] + data[6] * delta / 1000
			data[3] = data[3] + data[7] * delta / 1000
			data[4] = data[4] + data[10] * delta / 1000
			data[8] = data[8] - data[9] * delta / 1000
			if 0 > data[8] then
				table.remove(gecusEffect, i)
			else
				sightlangStaticImageUsed[0] = true
				if sightlangStaticImageToc[0] then
					processSightlangStaticImage[0]()
				end
				dxDrawMaterialLine3D(data[1] + x * data[4], data[2] + y * data[4], data[3] + z * data[4], data[1] - x * data[4], data[2] - y * data[4], data[3] - z * data[4], sightlangStaticImage[0], data[4], tocolor(148, 60, 184, 255 * data[8]))
			end
		end
	end
	for i = #sparks, 1, -1 do
		local nx, ny, nz = sparks[i][4], sparks[i][5], sparks[i][6]
		sparks[i][1] = sparks[i][1] + nx * 2.5 * delta / 1000
		sparks[i][2] = sparks[i][2] + ny * 2.5 * delta / 1000
		sparks[i][3] = sparks[i][3] + nz * 2.5 * delta / 1000
		local sx, sy, sz = sparks[i][1], sparks[i][2], sparks[i][3]
		sparks[i][7] = sparks[i][7] + 0.25 * delta / 1000
		local a = 255 - sparks[i][7] * sparks[i][9] * 255
		if a < 0 then
			table.remove(sparks, i)
		else
			local p = sparks[i][7] * 30
			local c = false
			if 2 <= p then
				c = tocolor(175, 50, 20, a)
			elseif 1 <= p then
				local r = 245 + -70 * (p - 1)
				local g = 219 + -169 * (p - 1)
				local b = 121 + -101 * (p - 1)
				c = tocolor(r, g, b, a)
			elseif 0 <= p then
				local r = 255 + -10 * p
				local g = 255 + -36 * p
				local b = 255 + -134 * p
				c = tocolor(r, g, b, a)
			else
				c = tocolor(255, 255, 255)
			end
			local len = math.sqrt(nx * nx + ny * ny + nz * nz) * 2
			nx = nx / len * sparks[i][8]
			ny = ny / len * sparks[i][8]
			nz = nz / len * sparks[i][8]
			dxDrawLine3D(sx, sy, sz, sx + nx, sy + ny, sz + nz, c, 0.125)
		end
	end
	if objR ~= objRT then
		local cr = objR - objRT
		cr = (cr + 180) % 360 - 180
		if 0 < cr then
			objR = objR - 270 * delta / 1000
			cr = objR - objRT
			cr = (cr + 180) % 360 - 180
			if cr < 0 then
				objR = objRT
			end
		end
		if cr < 0 then
			objR = objR + 270 * delta / 1000
			cr = objR - objRT
			cr = (cr + 180) % 360 - 180
			if 0 < cr then
				objR = objRT
			end
		end
		setElementRotation(obj, 0, 0, objR)
		setElementRotation(top, 0, 0, objR)
		if money then
			setElementRotation(money, 0, 0, objR)
		end
	end
	local hit = false
	if cutProg < 1 then
		local curX, curY = getCursorPosition()
		if curX then
			local x, y, z = getWorldFromScreenPosition(curX * screenX, curY * screenY, 3)
			local cx, cy, cz = getCameraMatrix()
			local h, hx, hy, hz, he, nx, ny, nz, mat = processLineOfSight(cx, cy, cz, x, y, z, false, false, false, true, false)
			if he == obj and nz == 0 then
				toSync = true
				hit = true
				flexX, flexY, flexZ = hx, hy, hz
				flexNX, flexNY, flexNZ = nx, ny, nz
			end
		end
	end
	if hit ~= hitCursor then
		hitCursor = hit
		sightexports.sGui:setCursorType(hitCursor and "none" or "normal")
	end
	local fDir = (flexY - objY) * math.cos(rot) - (flexX - objX) * math.sin(rot)
	local d = 0.025
	if 1 <= cutProg then
		d = 1
	elseif hit and getKeyState("mouse1") and objR == objRT and math.abs(flexZ - objZ - (cType == "atm" and 0.135778 or 0.416667)) <= 0.0225 then
		d = -0.02
	end
	if d > flexD then
		flexD = flexD + 0.5 * delta / 1000
		if d < flexD then
			flexD = d
		end
	end
	if d < flexD then
		flexD = flexD - 0.5 * delta / 1000
		if d > flexD then
			flexD = d
		end
	end
	if atmMinigameX < targetAtmMinigameX then
		atmMinigameX = atmMinigameX + 0.175 * delta / 1000
		if atmMinigameX > targetAtmMinigameX then
			atmMinigameX = targetAtmMinigameX
		end
	end
	if atmMinigameX > targetAtmMinigameX then
		atmMinigameX = atmMinigameX - 0.175 * delta / 1000
		if atmMinigameX < targetAtmMinigameX then
			atmMinigameX = targetAtmMinigameX
		end
	end
	if atmMinigameY < targetAtmMinigameY then
		atmMinigameY = atmMinigameY + 0.175 * delta / 1000
		if atmMinigameY > targetAtmMinigameY then
			atmMinigameY = targetAtmMinigameY
		end
	end
	if atmMinigameY > targetAtmMinigameY then
		atmMinigameY = atmMinigameY - 0.175 * delta / 1000
		if atmMinigameY < targetAtmMinigameY then
			atmMinigameY = targetAtmMinigameY
		end
	end
	local tmp = false
	if flexD < 0 then
		tmp = true
		if flexD <= -0.02 then
			local p = 0
			local cr = objR - math.deg(rot)
			cr = (cr + 180) % 360 - 180
			if cr < 0 then
				cr = 360 + cr
			end
			if cType == "atm" then
				if cr % 180 == 90 then
					p = (fDir / 0.504346 + 0.5) * rtLongSideATM
				else
					p = (fDir / 0.258098 + 0.5) * rtShortSideATM + rtLongSideATM
				end
			elseif cr % 180 == 90 then
				p = (fDir / 0.94266 + 0.5) * rtLongSide
			else
				p = (fDir / 0.600011 + 0.5) * rtShortSide + rtLongSide
			end
			if 180 <= cr then
				p = p + rtLongSide + rtShortSide
			end
			dxSetRenderTarget(rt)
			local x = math.floor(p) - 4
			if x < 0 then
				dxDrawRectangle(1024 + x, 0, 8, 1, tocolor(255, 255, 255))
			elseif 1016 < x then
				dxDrawRectangle(0, 0, x + 8 - 1024, 1, tocolor(255, 255, 255))
			end
			for i = x, x + 8 do
				progress[i % 1024] = true
			end
			dxDrawRectangle(x, 0, 8, 1, tocolor(255, 255, 255))
			dxSetRenderTarget()
		end
		setSoundVolume(cutSound, -flexD / 0.02 * 2)
		for i = 1, math.random(5, 10) do
			local dir = 0 < fDir
			local s = 1
			local alive = 6
			local x, y, z = flexX, flexY, flexZ
			if math.random() > 0.8 then
				dir = not dir
				s = 0.75
				alive = 16
				x = flexX + flexNX * 0.165
				y = flexY + flexNY * 0.165
			end
			if dir then
				local nx, ny = -flexNY, flexNX
				local r = -math.pi / 9 * math.random()
				nx, ny = nx * math.cos(r) - ny * math.sin(r), nx * math.sin(r) + ny * math.cos(r)
				table.insert(sparks, {
					x,
					y,
					z,
					nx * s,
					ny * s,
					(-0.125 + 0.25 * math.random()) * s,
					math.random() * 0.075 - 0.025,
					0.05 + math.random() * 0.25 * s * s,
					alive * (0.8 + math.random() * 0.3)
				})
			else
				local nx, ny = flexNY, -flexNX
				local r = math.pi / 9 * math.random()
				nx, ny = nx * math.cos(r) - ny * math.sin(r), nx * math.sin(r) + ny * math.cos(r)
				table.insert(sparks, {
					x,
					y,
					z,
					nx * s,
					ny * s,
					(-0.125 + 0.25 * math.random()) * s,
					math.random() * 0.075 - 0.025,
					0.05 + math.random() * 0.25 * s * s,
					alive * (0.8 + math.random() * 0.3)
				})
			end
		end
	else
		setSoundVolume(cutSound, 0)
	end
	local force = false
	if tmp ~= cutting then
		cutting = tmp
		toSync = true
		force = true
	end
	syncTime = syncTime + delta
	if toSync and (200 <= syncTime or force) then
		local d = 0.35 - (cutting and 0.1 or 0)
		triggerServerEvent("syncCrateFlexPos", localPlayer, syncList, flexX + flexNX * d, flexY + flexNY * d, syncTime / 1000, cutting, flexNX, flexNY)
		toSync = false
		syncTime = 0
	end
	if cutProg < 1 then
		cutProg = 0
		for i = 0, 1023 do
			if progress[i] then
				cutProg = cutProg + 1
			end
		end
		cutProg = cutProg / 1024
		if 1 <= cutProg then
			local cr = objRT - math.deg(rot)
			cr = (cr + 180) % 360 - 180
			if cr < 0 then
				cr = 360 + cr
			end
			if cr % 180 ~= 90 then
				objRT = objRT + 90
			end
		end
	end
	fDir = 0 < fDir
	local fr = math.deg(math.atan2(flexNY, flexNX)) + 90 + (fDir and 60 or -60)
	local cr = flexR - fr
	cr = (cr + 180) % 360 - 180
	if 0 < cr then
		flexR = flexR - 270 * delta / 1000
		cr = flexR - fr
		cr = (cr + 180) % 360 - 180
		if cr < 0 then
			flexR = fr
		end
	end
	if cr < 0 then
		flexR = flexR + 270 * delta / 1000
		cr = flexR - fr
		cr = (cr + 180) % 360 - 180
		if 0 < cr then
			flexR = fr
		end
	end
	local d = flexD + 0.0851145
	setElementPosition(flex, flexX + flexNX * d, flexY + flexNY * d, flexZ + flexNZ * d)
	setElementRotation(flex, 0, 0, flexR)
	setElementPosition(flexDisc, flexX + flexNX * d, flexY + flexNY * d, flexZ + flexNZ * d)
	setElementRotation(flexDisc, 0, 0, flexR + getTickCount() * 2)
	local flexRRad = math.rad(flexR)
	local cableX, cableY, cableZ = flexX + flexNX * d + math.sin(flexRRad) * 0.3223, flexY + flexNY * d - math.cos(flexRRad) * 0.3223, flexZ + flexNZ * d + 0.0394
	local lx, ly, lz = cableX, cableY, cableZ
	local tx = objX + 1 * math.cos(rot)
	local ty = objY + 1 * math.sin(rot)
	local tz = objZ
	for i = 1, 10 do
		local nx = cableX + (tx - cableX) * getEasingValue(i / 10, "InQuad")
		local ny = cableY + (ty - cableY) * getEasingValue(i / 10, "InQuad")
		local nz = cableZ + (tz - cableZ) * getEasingValue(i / 10, "OutQuad")
		dxDrawLine3D(lx, ly, lz, nx, ny, nz, tocolor(0, 0, 0), 0.5)
		lx, ly, lz = nx, ny, nz
	end
	local x, y, z = objX, objY, objZ + 0.15
	local r = 1.5
	setSoundVolume(loopSound, 1.25 * (1 - fadeProg) * (1 - math.max(0, flexD)))
	if 1 <= cutProg and objR == objRT then
		if cType ~= "atm" and not openSynced then
			openSynced = true
			triggerServerEvent("syncCrateOpened", localPlayer, syncList)
		end
		local n = #items
		if endP < 1 then
			endP = endP + 0.25 * delta / 1000
			if 1 < endP then
				endP = 1
			end
		elseif endP2 < 1 then
			local canEnd = true
			if cType == "atm" then
				if atmMinigameRound < 10 then
					atmMinigameCircle = atmMinigameCircle - atmMinigameSpeed / 10 * delta / 1000
					if atmMinigameCircle < 0 then
						atmMinigameCircle = 0
						if not openSynced then
							openSynced = true
							triggerServerEvent("syncCrateOpened", localPlayer, syncList)
						end
						atmMinigameRound = 10
						setElementModel(obj, sightexports.sModloader:getModelId("container_atm2"))
						setElementModel(top, sightexports.sModloader:getModelId("container_atm_top2"))
						setElementModel(money, sightexports.sModloader:getModelId("container_atm_cash2"))
						addGecus(objX, objY, objZ)
						sightexports.sGui:showInfobox("e", "Lejárt az időd!")
						playSound("files/pop.mp3")
					end
					canEnd = false
				else
					canEnd = true
				end
			end
			if canEnd then
				endP2 = endP2 + 0.25 * delta / 1000
				if 1 < endP2 then
					endP2 = 1
				end
			end
		elseif endP3 < 1 then
			if endP3 < 0 then
				endP3 = endP3 + delta
				if 0 < endP3 then
					endP3 = 0
				end
			else
				if not lootSoundPlayed then
					lootSoundPlayed = true
					if cType == "atm" then
						if atmMinigameSuccess then
							playSound("files/money.mp3")
						end
					else
						playLootSound()
						for i = 1, n - 1 do
							setTimer(playLootSound, 500 * i, 1)
						end
					end
				end
				local t = cType == "atm" and (atmMinigameSuccess and 5.25 or 0.1) or 0.5 * n
				endP3 = endP3 + 1 / t * delta / 1000
				if 1 < endP3 then
					endP3 = 1
				end
			end
		elseif fadeProg < 1 then
			fadeProg = fadeProg + 0.5 * delta / 1000
			if 1 < fadeProg then
				fadeProg = 1
				deleteCrateOpener()
				fadeStart = getTickCount()
				addEventHandler("onClientRender", getRootElement(), renderFadeOut, true, "low-9999999")
				return
			end
		end
		local p = getEasingValue(endP, "InOutQuad")
		local op = p
		if cType == "atm" then
			op = getEasingValue(endP2, "InOutQuad")
		end
		local p2 = getEasingValue(endP2, "InQuad")
		r = 1.5 * (1 - p * 0.85)
		local cz = 1
		if cType == "atm" then
			r = r * 0.85
			cz = cz * 0.35
		end
		setElementPosition(top, objX - p2 * 1 * math.cos(rot) + atmMinigameX, objY - p2 * 1 * math.sin(rot) + atmMinigameY, objZ + 0.25 * op)
		if money and atmMoney and 0 < endP2 then
			if atmMinigameSuccess then
				local p = math.max(0, math.min(1, endP3 * 1.5))
				if 1 <= p then
					setObjectScale(money, 0)
				else
					setObjectScale(money, atmMoney / 150000 * (1 - p), 1, 1)
				end
			else
				setObjectScale(money, atmMoney / 150000, 1, 1)
			end
		end
		setCameraMatrix(x + math.cos(rot) * r, y + math.sin(rot) * r, z + cz + 0.85 * p, x, y, z)
		local x, y, z = objX - (n / 4 - 0.5) * 0.15 * math.sin(rot), objY + (n / 4 - 0.5) * 0.15 * math.cos(rot), objZ + 0.3
		for i = 1, n / 2 do
			local c = 255 * p2
			p3 = getEasingValue(math.min(1, math.max(0, endP3 * (n + 1) - ((i - 1) * 2 + 1))), "InQuad")
			local a = 255 * (1 - p3)
			dxDrawMaterialLine3D(x + -0.19 * math.cos(rot), y + -0.19 * math.sin(rot), z + 1 * p3, x + -0.10999999999999999 * math.cos(rot), y + -0.10999999999999999 * math.sin(rot), z + 1 * p3, items[(i - 1) * 2 + 1], 0.08, tocolor(c, c, c, a), x - 0.15 * math.cos(rot), y - 0.15 * math.sin(rot), z + 10)
			p3 = getEasingValue(math.min(1, math.max(0, endP3 * (n + 1) - ((i - 1) * 2 + 2))), "InQuad")
			local a = 255 * (1 - p3)
			dxDrawMaterialLine3D(x + 0.10999999999999999 * math.cos(rot), y + 0.10999999999999999 * math.sin(rot), z + 1 * p3, x + 0.19 * math.cos(rot), y + 0.19 * math.sin(rot), z + 1 * p3, items[(i - 1) * 2 + 2], 0.08, tocolor(c, c, c, a), x + 0.15 * math.cos(rot), y + 0.15 * math.sin(rot), z + 10)
			x = x + 0.15 * math.sin(rot)
			y = y - 0.15 * math.cos(rot)
		end
	else
		if 0 < fadeProg then
			fadeProg = fadeProg - 1 * delta / 1000
			if fadeProg < 0 then
				fadeProg = 0
				if cType == "atm" then
					sightexports.sGui:showInfobox("i", "Vágd végig a kazetta tetejét, hogy kinyisd.")
					sightexports.sGui:showInfobox("i", "A kazettát a nyíl gombokkal forgathatod, a folyamatot megszakításához: Backspace")
				else
					sightexports.sGui:showInfobox("i", "Vágd végig a láda tetejét, hogy kinyisd.")
					sightexports.sGui:showInfobox("i", "A ládát a nyíl gombokkal forgathatod, a folyamatot megszakításához: Backspace")
					sightexports.sGui:showInfobox("w", "Figyelj arra, hogy elég helyed legyen az inventorydban!")
				end
			end
		end
		local cz = 1
		if cType == "atm" then
			r = r * 0.85
			cz = cz * 0.35
		end
		setCameraMatrix(x + math.cos(rot) * r, y + math.sin(rot) * r, z + cz, x, y, z)
	end
end
local crateOpener = false
function deleteCrateOpener()
	if hitCursor then
		sightexports.sGui:setCursorType("normal")
	end
	hitCursor = false
	crateOpener = false
	removeEventHandler("onClientRender", getRootElement(), renderCrateOpen)
	removeEventHandler("onClientKey", getRootElement(), crateOpenKey)
	removeEventHandler("onClientPreRender", getRootElement(), preRenderCrateOpen)
	removeEventHandler("onClientElementStreamIn", getRootElement(), refreshSyncList)
	removeEventHandler("onClientElementStreamOut", getRootElement(), refreshSyncList)
	if isElement(obj) then
		destroyElement(obj)
	end
	obj = false
	if isElement(top) then
		destroyElement(top)
	end
	top = false
	if isElement(money) then
		destroyElement(money)
	end
	money = false
	if isElement(flex) then
		destroyElement(flex)
	end
	flex = false
	if isElement(flexDisc) then
		destroyElement(flexDisc)
	end
	flexDisc = false
	if isElement(shader) then
		destroyElement(shader)
	end
	shader = false
	if isElement(rt) then
		destroyElement(rt)
	end
	rt = false
	if isElement(cutTex) then
		destroyElement(cutTex)
	end
	cutTex = false
	if isElement(loopSound) then
		destroyElement(loopSound)
	end
	loopSound = false
	if isElement(cutSound) then
		destroyElement(cutSound)
	end
	cutSound = false
	for i = 1, #items do
		if isElement(items[i]) then
			destroyElement(items[i])
		end
		items[i] = nil
	end
	for i = 0, 1023 do
		progress[i] = nil
	end
	sightexports.sControls:toggleAllControls(true)
	setCameraTarget(localPlayer)
	showCursor(false)
	setElementAlpha(localPlayer, 255)
	syncList = false
end
function refreshSyncList()
	syncList = getElementsByType("player", getRootElement(), true)
end
function createCrateOpener()
	crateOpener = true
	syncTime = 0
	toSync = false
	cutting = false
	syncList = getElementsByType("player", getRootElement(), true)
	addEventHandler("onClientRender", getRootElement(), renderCrateOpen)
	addEventHandler("onClientElementStreamIn", getRootElement(), refreshSyncList)
	addEventHandler("onClientElementStreamOut", getRootElement(), refreshSyncList)
	local pi, pd = false, false
	if tonumber(currentPos) then
		pi = openPoses[currentPos][5]
		pd = openPoses[currentPos][6]
	else
		local dat = split(currentPos, "_")
		if dat[1] == "rentgarage" then
			pd = tonumber(dat[2])
			pi = 2
			pd = math.abs(pd)
		else
			pd = tonumber(dat[2])
			pi = pd < 0 and 2 or 1
			pd = math.abs(pd)
		end
	end
	obj = createObject(sightexports.sModloader:getModelId("container_" .. cType), objX, objY, objZ)
	setElementDimension(obj, pd)
	setElementInterior(obj, pi)
	top = createObject(sightexports.sModloader:getModelId("container_" .. cType .. "_top"), objX, objY, objZ)
	setElementDimension(top, pd)
	setElementInterior(top, pi)
	if atmMoney then
		money = createObject(sightexports.sModloader:getModelId("container_atm_cash"), objX, objY, objZ)
		setElementDimension(money, pd)
		setElementInterior(money, pi)
		setElementCollisionsEnabled(money, false)
	else
		if isElement(money) then
			destroyElement(money)
		end
		money = false
	end
	flex = createObject(sightexports.sModloader:getModelId("flex"), objX, objY, objZ)
	setElementDimension(flex, pd)
	setElementInterior(flex, pi)
	flexDisc = createObject(sightexports.sModloader:getModelId("flex_disc"), objX, objY, objZ)
	setElementDimension(flexDisc, pd)
	setElementInterior(flexDisc, pi)
	setElementCollisionsEnabled(top, false)
	setElementCollisionsEnabled(flexDisc, false)
	setElementCollisionsEnabled(flex, false)
	shader = dxCreateShader(shaderSource)
	engineApplyShaderToWorldTexture(shader, cType .. "_container_weld", obj)
	rt = dxCreateRenderTarget(1024, 1)
	cutTex = dxCreateTexture("files/cut.dds")
	dxSetShaderValue(shader, "MaskTexture", rt)
	dxSetShaderValue(shader, "CutTexture", cutTex)
	cutProg = 0
	objR = (270 + math.deg(rot)) % 360
	if objR < 0 then
		objR = 360 + objR
	end
	objRT = objR
	setElementRotation(obj, 0, 0, objR)
	setElementRotation(top, 0, 0, objR)
	if money then
		setElementRotation(money, 0, 0, objR)
	end
	addEventHandler("onClientKey", getRootElement(), crateOpenKey)
	addEventHandler("onClientPreRender", getRootElement(), preRenderCrateOpen)
	for i = 0, 1023 do
		progress[i] = false
	end
	loopSound = playSound("files/loop.mp3", true)
	cutSound = playSound("files/cut.mp3", true)
	setSoundVolume(loopSound, 1.25)
	setSoundVolume(cutSound, 0)
	flexD = 1.25
	flexR = 0
	endP = 0
	endP2 = 0
	endP3 = -2000
	if cType == "atm" then
		atmMinigameButton = atmMinigameButtons[math.random(1, #atmMinigameButtons)]
		atmMinigameCircle = 1
		atmMinigameSpeed = 1
		atmMinigameCorner = math.random(1, 4)
		atmMinigameRound = 0
		atmMinigameSuccess = false
	end
	atmMinigameX = 0
	atmMinigameY = 0
	targetAtmMinigameX = 0
	targetAtmMinigameY = 0
	setCursorPosition(screenX / 2, screenY / 2)
	flexX, flexY, flexZ = objX, objY, objZ
	flexNX, flexNY, flexNZ = math.cos(rot), math.sin(rot), 0
	lootSoundPlayed = false
	showCursor(true)
	setElementAlpha(localPlayer, 0)
end
function renderCrateOpen()
	local y = math.floor(screenY * 0.8)
	local a = 1 - endP
	dxDrawText(math.floor(cutProg * 100) .. " %", 1, 1, screenX + 1, y - 4 + 1, tocolor(0, 0, 0, 150 * a), fontScale, font, "center", "bottom")
	dxDrawText(math.floor(cutProg * 100) .. " %", 0, 0, screenX, y - 4, tocolor(255, 255, 255, 255 * a), fontScale, font, "center", "bottom")
	dxDrawRectangle(screenX / 2 - 128, y, 256, 12, tocolor(v4grey[1], v4grey[2], v4grey[3], 255 * a))
	dxDrawRectangle(screenX / 2 - 128, y, 256 * cutProg, 12, tocolor(v4green[1], v4green[2], v4green[3], 255 * a))
	if cType == "atm" and 1 <= endP and atmMinigameRound < 10 then
		local x, y, z = objX, objY, objZ + 0.15
		local rad = math.rad(objR)
		local cos = math.cos(rad)
		local sin = math.sin(rad)
		local xd = 0.252173 * (atmMinigameCorner % 2 == 1 and -1 or 1)
		local yd = 0.129049 * (2 < atmMinigameCorner and -1 or 1)
		x = x + cos * xd + sin * yd
		y = y + sin * xd - cos * yd
		x, y = getScreenFromWorldPosition(x, y, z, 64)
		if x then
			local s = 38 + 90 * atmMinigameCircle
			local c = false
			local c2
			if atmMinigameCircle < 0.75 then
				c = {
					v4red[1] + (v4blue[1] - v4red[1]) * (atmMinigameCircle / 0.75),
					v4red[2] + (v4blue[2] - v4red[2]) * (atmMinigameCircle / 0.75),
					v4red[3] + (v4blue[3] - v4red[3]) * (atmMinigameCircle / 0.75)
				}
				if atmMinigameCircle < 0.55 then
					c2 = tocolor(v4red[1] + (255 - v4red[1]) * (atmMinigameCircle / 0.55), v4red[2] + (255 - v4red[2]) * (atmMinigameCircle / 0.55), v4red[3] + (255 - v4red[3]) * (atmMinigameCircle / 0.55))
				end
			else
				c = v4blue
			end
			dxDrawImage(x - s / 2, y - s / 2, s, s, ":sGui/" .. circle1 .. faTicks[circle1], 0, 0, 0, tocolor(c[1], c[2], c[3], 150))
			dxDrawImage(x - s / 2, y - s / 2, s, s, ":sGui/" .. circle2 .. faTicks[circle2], 0, 0, 0, tocolor(c[1], c[2], c[3]))
			dxDrawImage(x - 19, y - 19, 38, 38, ":sGui/" .. circle1 .. faTicks[circle1], 0, 0, 0, c2)
			dxDrawText(tostring(atmMinigameButton), x, y, x, y, tocolor(0, 0, 0, 255), btnFontScale, btnFont, "center", "center")
		end
	end
	if money and 1 <= endP2 and atmMinigameSuccess and 0 <= endP3 then
		local x, y = screenX / 2, screenY / 2
		local p = math.floor(atmMoney * math.max(0, math.min(1, endP3 * 1.5)))
		dxDrawText(sightexports.sGui:thousandsStepper(p) .. " $", x + 1, y + 1, x + 1, y + 1, tocolor(0, 0, 0, 255), btnFontScale * 2, btnFont, "center", "center")
		dxDrawText(sightexports.sGui:thousandsStepper(p) .. " $", x, y, x, y, tocolor(v4green[1], v4green[2], v4green[3], 255), btnFontScale * 2, btnFont, "center", "center")
	end
	dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * fadeProg))
end
function renderFadeOut()
	local p = (getTickCount() - fadeStart) / 1000
	p = getEasingValue(math.min(1, p), "OutQuad")
	dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * (1 - p)))
	if 1 <= p then
		removeEventHandler("onClientRender", getRootElement(), renderFadeOut)
		fadeStart = false
	end
end
function renderFadeIn()
	local p = (getTickCount() - fadeStart) / 2000
	p = getEasingValue(math.min(1, p), "InQuad")
	local bx, by, bz = getPedBonePosition(localPlayer, 6)
	local cx = fadeCX + (bx - fadeCX) * (p * 0.95)
	local cy = fadeCY + (by - fadeCY) * (p * 0.95)
	local cz = fadeCZ + (bz - fadeCZ) * (p * 0.95)
	setCameraMatrix(cx, cy, cz, fadeTX, fadeTY, fadeTZ)
	dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
	if 1 <= p then
		removeEventHandler("onClientRender", getRootElement(), renderFadeIn)
		createCrateOpener()
		fadeStart = false
		fadeProg = 1
	end
end
addEvent("endCrateOpening", true)
addEventHandler("endCrateOpening", getRootElement(), function()
	deleteCrateOpener()
end)
addEvent("startCrateOpening", true)
addEventHandler("startCrateOpening", getRootElement(), function(found, t, r, dat, money)
	if crateOpener then
		deleteCrateOpener()
	end
	openSynced = false
	cType = t
	atmMoney = money
	items = {}
	sightexports.sControls:toggleAllControls(false)
	local px, py, pz = getElementPosition(localPlayer)
	for i = 1, #dat do
		table.insert(items, dxCreateTexture(":sItems/" .. sightexports.sItems:getItemPic(dat[i][1])))
	end
	currentPos = found
	if tonumber(found) then
		objX, objY, objZ = openPoses[found][1], openPoses[found][2], openPoses[found][3]
	else
		objX, objY, objZ = 614.5529, -30.3982, 1000.870237
	end
	rot = r
	fadeCX, fadeCY, fadeCZ, fadeTX, fadeTY, fadeTZ = getCameraMatrix()
	fadeTX = fadeCX + (fadeTX - fadeCX) * 10
	fadeTY = fadeCY + (fadeTY - fadeCY) * 10
	fadeTZ = fadeCZ + (fadeTZ - fadeCZ) * 10
	fadeStart = getTickCount()
	addEventHandler("onClientRender", getRootElement(), renderFadeIn, true, "low-9999999")
end)
local crateObjects = {}
local flexDiscs = {}
local flexObjects = {}
local flexNX = {}
local flexNY = {}
local crateX = {}
local crateY = {}
local crateSX = {}
local crateSY = {}
local crateTX = {}
local crateTY = {}
local crateLoop = {}
local crateCut = {}
local crateCutting = {}
local crateTops = {}
local crateMoneys = {}
local crateAmounts = {}
local crateOpening = {}
local crateOpened = {}
local crateOpenedItems = {}
local crateR = {}
local crateRT = {}
local streamedInList = {}
local streamedHandled = false
addEvent("syncCrateFlexPos", true)
addEventHandler("syncCrateFlexPos", getRootElement(), function(x, y, t, c, nx, ny)
	if isElement(source) and flexObjects[source] then
		if not crateX[source] then
			crateX[source] = x
			crateY[source] = y
		else
			crateSX[source] = math.abs(crateX[source] - x) / t
			crateSY[source] = math.abs(crateY[source] - y) / t
		end
		crateTX[source] = x
		crateTY[source] = y
		setSoundVolume(crateCut[source], c and 1 or 0)
		crateCutting[source] = c
		flexNX[source] = nx
		flexNY[source] = ny
		setElementRotation(flexObjects[source], 0, 0, math.deg(math.atan2(ny, nx)) + 90)
	end
end)
function reverseMatrix(m, x, y, z)
	return (-m[2][1] * m[3][2] * z + m[2][1] * m[3][3] * y - m[2][2] * m[3][3] * x + m[2][2] * m[3][1] * z + m[3][2] * m[2][3] * x - m[2][3] * m[3][1] * y) / (-m[1][1] * m[2][2] * m[3][3] + m[1][1] * m[3][2] * m[2][3] - m[1][3] * m[2][1] * m[3][2] + m[1][3] * m[2][2] * m[3][1] + m[2][1] * m[3][3] * m[1][2] - m[1][2] * m[2][3] * m[3][1]), (m[1][1] * m[3][2] * z - m[1][1] * m[3][3] * y - m[1][3] * m[3][2] * x + m[1][3] * m[3][1] * y + m[3][3] * m[1][2] * x - m[1][2] * m[3][1] * z) / (-m[1][1] * m[2][2] * m[3][3] + m[1][1] * m[3][2] * m[2][3] - m[1][3] * m[2][1] * m[3][2] + m[1][3] * m[2][2] * m[3][1] + m[2][1] * m[3][3] * m[1][2] - m[1][2] * m[2][3] * m[3][1]), (-m[1][1] * m[2][2] * z + m[1][1] * m[2][3] * y - m[1][3] * m[2][1] * y + m[1][3] * m[2][2] * x + m[2][1] * m[1][2] * z - m[1][2] * m[2][3] * x) / (-m[1][1] * m[2][2] * m[3][3] + m[1][1] * m[3][2] * m[2][3] - m[1][3] * m[2][1] * m[3][2] + m[1][3] * m[2][2] * m[3][1] + m[2][1] * m[3][3] * m[1][2] - m[1][2] * m[2][3] * m[3][1])
end
function drawBoneVilag(m, x, y, z)
	return x * m[1][1] + y * m[2][1] + z * m[3][1] + m[4][1], x * m[1][2] + y * m[2][2] + z * m[3][2] + m[4][2], x * m[1][3] + y * m[2][3] + z * m[3][3] + m[4][3]
end
function onClientPedsProcessed_PreRender()
	local now = getTickCount()
	for i = 1, #streamedInList do
		local client = streamedInList[i]
		if isElementOnScreen(client) and crateX[client] and flexObjects[client] then
			local x, y, z = getElementBonePosition(client, 25)
			local flexNX, flexNY = flexNX[client], flexNY[client]
			local flexX, flexY, flexZ = x - flexNX * 0.2, y - flexNY * 0.2, z - 0.1
			setElementPosition(flexObjects[client], flexX, flexY, flexZ)
			setElementPosition(flexDiscs[client], flexX, flexY, flexZ)
			setElementRotation(flexDiscs[client], 0, 0, now * 2)
			if crateCutting[client] then
				for i = 1, math.random(2, 6) do
					local dir = true
					local s = 1
					local alive = 6
					local x, y, z = flexX, flexY, flexZ
					if math.random() > 0.8 then
						dir = not dir
						s = 0.75
						alive = 18
						x = flexX + flexNX * 0.165
						y = flexY + flexNY * 0.165
					end
					if dir then
						local nx, ny = -flexNY, flexNX
						local r = -math.pi / 9 * math.random()
						nx = nx * math.cos(r) - ny * math.sin(r)
						ny = nx * math.sin(r) + ny * math.cos(r)
						table.insert(sparksEx, {
							x,
							y,
							z,
							nx * s,
							ny * s,
							(-0.125 + 0.25 * math.random()) * s,
							math.random() * 0.075 - 0.025,
							0.05 + math.random() * 0.25 * s * s,
							alive * (0.8 + math.random() * 0.3)
						})
					else
						local nx, ny = flexNY, -flexNX
						local r = math.pi / 9 * math.random()
						nx = nx * math.cos(r) - ny * math.sin(r)
						ny = nx * math.sin(r) + ny * math.cos(r)
						table.insert(sparksEx, {
							x,
							y,
							z,
							nx * s,
							ny * s,
							(-0.125 + 0.25 * math.random()) * s,
							math.random() * 0.075 - 0.025,
							0.05 + math.random() * 0.25 * s * s,
							alive * (0.8 + math.random() * 0.3)
						})
					end
				end
			end
		end
	end
end
function onClientPedsProcessed()
	for i = 1, #streamedInList do
		local client = streamedInList[i]
		if isElementOnScreen(client) and crateX[client] and flexObjects[client] then
			local m = getElementBoneMatrix(client, 21)
			local x1, y1, z1 = getElementBonePosition(client, 22)
			local rx, ry, rz = getElementRotation(client)
			local hit = false
			local found = crateOpening[client][1]
			local tx, ty, tz = crateX[client], crateY[client], 0
			local x, y, z, i, d
			if tonumber(found) then
				tz = openPoses[found][3] + 0.1
			else
				tz = 1000.970237
			end
			tz = tz + (crateOpening[client][2] == "atm" and 0.135778 or 0.416667)
			m[4][1] = x1
			m[4][2] = y1
			m[4][3] = z1
			local x2, y2, z2 = getElementBonePosition(client, 23)
			local x3, y3, z3 = getElementBonePosition(client, 24)
			local x, y, z = reverseMatrix(m, tx - x1, ty - y1, tz - z1)
			local tx1, ty1, tz1 = drawBoneVilag(m, 0, 0, 0)
			local tx, ty, tz = drawBoneVilag(m, x, y, z)
			local tx2, ty2, tz2 = drawBoneVilag(m, 0, 0, z)
			local deg = math.deg(math.atan2(y, x))
			local deg2 = math.deg(math.atan2(-z, math.sqrt(x * x + y * y)))
			local l1 = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
			local l2 = getDistanceBetweenPoints3D(x2, y2, z2, x3, y3, z3)
			local l3 = math.sqrt(x * x + y * y + z * z)
			local joint2 = 180
			if l3 < l1 + l2 then
				joint2 = math.deg(math.acos((l1 * l1 + l2 * l2 - l3 * l3) / (2 * l1 * l2)))
			end
			local r2 = -deg
			local r3 = 0
			if 100 < r2 then
				r3 = (r2 - 100) / 2
				deg = -100
			elseif r2 < 75 then
				r3 = -(75 - r2) / 2
				deg = -75
			end
			setElementBoneRotation(client, 2, r3, 0, 0)
			setElementBoneRotation(client, 3, r3, 0, 0)
			setElementBoneRotation(client, 22, 0, deg + (180 - joint2) / 2, deg2)
			setElementBoneRotation(client, 23, 0, -(180 - joint2), 0)
			setElementBoneRotation(client, 24, 90, 0, 0)
			sightexports.sCore:updateElementRpHAnim(client)
		end
	end
end
function renderStreamedCrate()
	local cx, cy, cz = getCameraMatrix()
	local now = getTickCount()
	for i = 1, #streamedInList do
		local client = streamedInList[i]
		if client and crateOpened[client] then
			local delta = now - crateOpened[client]
			local p = delta / 5000
			local found = crateOpening[client][1]
			local x, y, z
			if tonumber(found) then
				x, y, z = openPoses[found][1], openPoses[found][2], openPoses[found][3]
			else
				x, y, z = 614.5529, -30.3982, 1000.870237
			end
			if p < 1 then
				p = getEasingValue(p, "InQuad")
				if crateAmounts[client] then
					local p = math.min(1, p * 1.5)
					setElementPosition(crateTops[client], x, y, z + 0.5 * p)
					setElementAlpha(crateTops[client], 255 * (1 - p))
				else
					setElementPosition(crateTops[client], x, y, z + 0.5 * p)
					setElementAlpha(crateTops[client], 255 * (1 - p))
				end
			elseif crateTops[client] then
				if isElement(crateTops[client]) then
					destroyElement(crateTops[client])
				end
				crateTops[client] = nil
			end
			local c = math.max(0, 255 * math.min(1, p - 0.75))
			p = math.min(1, p)
			z = z + 0.25 + 0.25 * p
			local d = getDistanceBetweenPoints3D(x, y, z, cx, cy, cz)
			if d < 7.5 then
				local a = 255 * p
				if 3.5 < d then
					a = a * (1 - (d - 3.5) / 4)
				end
				local x, y = getScreenFromWorldPosition(x, y, z, 108)
				if x then
					if crateAmounts[client] then
						p = math.min(1, p * 1.5)
						if 1 <= p then
							setObjectScale(crateMoneys[client], 0)
						else
							setObjectScale(crateMoneys[client], crateAmounts[client] / 150000 * (1 - p), 1, 1)
						end
						p = math.floor(crateAmounts[client] * p)
						dxDrawText(sightexports.sGui:thousandsStepper(p) .. " $", x + 1, y + 1, x + 1, y + 1, tocolor(0, 0, 0, a), btnFontScale, btnFont, "center", "center")
						dxDrawText(sightexports.sGui:thousandsStepper(p) .. " $", x, y, x, y, tocolor(v4green[1], v4green[2], v4green[3], a), btnFontScale, btnFont, "center", "center")
					else
						local n = #crateOpenedItems[client]
						x = x - n / 4 * 40
						for i = 1, n / 2 do
							dxDrawImage(x + 2, y - 36 - 2, 36, 36, crateOpenedItems[client][(i - 1) * 2 + 1], 0, 0, 0, tocolor(c, c, c, a))
							dxDrawImage(x + 2, y + 2, 36, 36, crateOpenedItems[client][(i - 1) * 2 + 2], 0, 0, 0, tocolor(c, c, c, a))
							x = x + 40
						end
					end
				end
			end
		end
	end
end
function preRenderStreamedCrate(delta)
	for i = #sparksEx, 1, -1 do
		local nx, ny, nz = sparksEx[i][4], sparksEx[i][5], sparksEx[i][6]
		sparksEx[i][1] = sparksEx[i][1] + nx * 2.5 * delta / 1000
		sparksEx[i][2] = sparksEx[i][2] + ny * 2.5 * delta / 1000
		sparksEx[i][3] = sparksEx[i][3] + nz * 2.5 * delta / 1000
		local sx, sy, sz = sparksEx[i][1], sparksEx[i][2], sparksEx[i][3]
		sparksEx[i][7] = sparksEx[i][7] + 0.25 * delta / 1000
		local a = 255 - sparksEx[i][7] * sparksEx[i][9] * 255
		if a < 0 then
			table.remove(sparksEx, i)
		else
			local p = sparksEx[i][7] * 30
			local c = false
			if 2 <= p then
				c = tocolor(175, 50, 20, a)
			elseif 1 <= p then
				local r = 245 + -70 * (p - 1)
				local g = 219 + -169 * (p - 1)
				local b = 121 + -101 * (p - 1)
				c = tocolor(r, g, b, a)
			elseif 0 <= p then
				local r = 255 + -10 * p
				local g = 255 + -36 * p
				local b = 255 + -134 * p
				c = tocolor(r, g, b, a)
			else
				c = tocolor(255, 255, 255)
			end
			local len = math.sqrt(nx * nx + ny * ny + nz * nz) * 2
			nx = nx / len * sparksEx[i][8]
			ny = ny / len * sparksEx[i][8]
			nz = nz / len * sparksEx[i][8]
			dxDrawLine3D(sx, sy, sz, sx + nx, sy + ny, sz + nz, c, 0.125)
		end
	end
	if 1 <= #gecusEffect then
		local x, y, z = getWorldFromScreenPosition(screenX / 2, 0, 128)
		local x2, y2, z2 = getWorldFromScreenPosition(screenX / 2, screenY / 2, 128)
		x = x2 - x
		y = y2 - y
		z = z2 - z
		local len = math.sqrt(x * x + y * y + z * z) * 2
		x = x / len
		y = y / len
		z = z / len
		for i = #gecusEffect, 1, -1 do
			local data = gecusEffect[i]
			data[1] = data[1] + data[5] * delta / 1000
			data[2] = data[2] + data[6] * delta / 1000
			data[3] = data[3] + data[7] * delta / 1000
			data[4] = data[4] + data[10] * delta / 1000
			data[8] = data[8] - data[9] * delta / 1000
			if 0 > data[8] then
				table.remove(gecusEffect, i)
			else
				sightlangStaticImageUsed[0] = true
				if sightlangStaticImageToc[0] then
					processSightlangStaticImage[0]()
				end
				dxDrawMaterialLine3D(data[1] + x * data[4], data[2] + y * data[4], data[3] + z * data[4], data[1] - x * data[4], data[2] - y * data[4], data[3] - z * data[4], sightlangStaticImage[0], data[4], tocolor(148, 60, 184, 255 * data[8]))
			end
		end
	end
	for i = 1, #streamedInList do
		local client = streamedInList[i]
		if client and flexObjects[client] then
			if crateX[client] then
				if crateX[client] > crateTX[client] then
					crateX[client] = crateX[client] - crateSX[client] * delta / 1000
					if crateX[client] < crateTX[client] then
						crateX[client] = crateTX[client]
					end
				end
				if crateX[client] < crateTX[client] then
					crateX[client] = crateX[client] + crateSX[client] * delta / 1000
					if crateX[client] > crateTX[client] then
						crateX[client] = crateTX[client]
					end
				end
				if crateY[client] > crateTY[client] then
					crateY[client] = crateY[client] - crateSY[client] * delta / 1000
					if crateY[client] < crateTY[client] then
						crateY[client] = crateTY[client]
					end
				end
				if crateY[client] < crateTY[client] then
					crateY[client] = crateY[client] + crateSY[client] * delta / 1000
					if crateY[client] > crateTY[client] then
						crateY[client] = crateTY[client]
					end
				end
			end
			if crateR[client] ~= crateRT[client] then
				local cr = crateR[client] - crateRT[client]
				cr = (cr + 180) % 360 - 180
				if 0 < cr then
					crateR[client] = crateR[client] - 270 * delta / 1000
					cr = crateR[client] - crateRT[client]
					cr = (cr + 180) % 360 - 180
					if cr < 0 then
						crateR[client] = crateRT[client]
					end
				end
				if cr < 0 then
					crateR[client] = crateR[client] + 270 * delta / 1000
					cr = crateR[client] - crateRT[client]
					cr = (cr + 180) % 360 - 180
					if 0 < cr then
						crateR[client] = crateRT[client]
					end
				end
				setElementRotation(crateObjects[client], 0, 0, crateR[client])
				setElementRotation(crateTops[client], 0, 0, crateR[client])
			end
		end
	end
end
function streamOutCrate(client)
	if isElement(crateObjects[client]) then
		destroyElement(crateObjects[client])
	end
	crateObjects[client] = nil
	if isElement(crateTops[client]) then
		destroyElement(crateTops[client])
	end
	crateTops[client] = nil
	if isElement(crateMoneys[client]) then
		destroyElement(crateMoneys[client])
	end
	crateMoneys[client] = nil
	crateAmounts[client] = nil
	if isElement(crateLoop[client]) then
		destroyElement(crateLoop[client])
	end
	crateLoop[client] = nil
	if isElement(crateCut[client]) then
		destroyElement(crateCut[client])
	end
	crateCut[client] = nil
	if isElement(flexObjects[client]) then
		destroyElement(flexObjects[client])
	end
	flexObjects[client] = nil
	if isElement(flexDiscs[client]) then
		destroyElement(flexDiscs[client])
	end
	flexDiscs[client] = nil
	for i = #streamedInList, 1, -1 do
		if streamedInList[i] == client then
			table.remove(streamedInList, i)
		end
	end
	crateX[client] = nil
	crateY[client] = nil
	crateTX[client] = nil
	crateTY[client] = nil
	crateSX[client] = nil
	crateSY[client] = nil
	flexNX[client] = nil
	flexNY[client] = nil
	crateCutting[client] = nil
	if #streamedInList <= 0 and streamedHandled then
		removeEventHandler("onClientPreRender", getRootElement(), preRenderStreamedCrate)
		removeEventHandler("onClientRender", getRootElement(), renderStreamedCrate)
		removeEventHandler("onClientPedsProcessed", getRootElement(), onClientPedsProcessed)
		removeEventHandler("onClientPreRender", getRootElement(), onClientPedsProcessed_PreRender)
		streamedHandled = false
	end
end
function streamInCrate(client)
	streamOutCrate(client)
	if crateOpening[client] then
		table.insert(streamedInList, client)
		local found, t, r = crateOpening[client][1], crateOpening[client][2], crateOpening[client][3]
		local r = (270 + math.deg(r)) % 360
		crateR[client] = r
		crateRT[client] = r
		local x, y, z, i, d
		if tonumber(found) then
			x, y, z = openPoses[found][1], openPoses[found][2], openPoses[found][3]
			i = openPoses[found][5]
			d = openPoses[found][6]
		else
			x, y, z = 614.5529, -30.3982, 1000.870237
			local dat = split(found, "_")
			d = tonumber(dat[2])
			i = d < 0 and 2 or 1
			d = math.abs(d)
		end
		flexObjects[client] = createObject(sightexports.sModloader:getModelId("flex"), x, y, z - 5, 0, 0, r)
		setElementInterior(flexObjects[client], i)
		setElementDimension(flexObjects[client], d)
		flexDiscs[client] = createObject(sightexports.sModloader:getModelId("flex_disc"), x, y, z - 5, 0, 0, r)
		setElementInterior(flexDiscs[client], i)
		setElementDimension(flexDiscs[client], d)
		setElementCollisionsEnabled(flexObjects[client], false)
		setElementCollisionsEnabled(flexDiscs[client], false)
		crateObjects[client] = createObject(sightexports.sModloader:getModelId("container_" .. t), x, y, z, 0, 0, r)
		setElementInterior(crateObjects[client], i)
		setElementDimension(crateObjects[client], d)
		crateTops[client] = createObject(sightexports.sModloader:getModelId("container_" .. t .. "_top"), x, y, z, 0, 0, r)
		setElementInterior(crateTops[client], i)
		setElementDimension(crateTops[client], d)
		crateLoop[client] = playSound3D("files/loop.mp3", x, y, z, true)
		crateCut[client] = playSound3D("files/cut.mp3", x, y, z, true)
		setSoundVolume(crateLoop[client], 1)
		setSoundVolume(crateCut[client], 0)
		setSoundMaxDistance(crateLoop[client], 50)
		setSoundMaxDistance(crateCut[client], 50)
		setElementInterior(crateLoop[client], i)
		setElementDimension(crateLoop[client], d)
		setElementInterior(crateCut[client], i)
		setElementDimension(crateCut[client], d)
		attachElements(crateLoop[client], flexObjects[client])
		attachElements(crateCut[client], flexObjects[client])
		if 1 <= #streamedInList and not streamedHandled then
			addEventHandler("onClientPreRender", getRootElement(), preRenderStreamedCrate)
			addEventHandler("onClientRender", getRootElement(), renderStreamedCrate)
			addEventHandler("onClientPedsProcessed", getRootElement(), onClientPedsProcessed, true, "high+99999")
			addEventHandler("onClientPreRender", getRootElement(), onClientPedsProcessed_PreRender, true, "high+99999")
			streamedHandled = true
		end
	end
end
addEvent("syncCrateOpened", true)
addEventHandler("syncCrateOpened", getRootElement(), function(items, atmSuccess, atmMoney)
	crateOpened[source] = getTickCount()
	crateOpenedItems[source] = {}
	if items then
		for i = 1, #items do
			crateOpenedItems[source][i] = ":sItems/" .. sightexports.sItems:getItemPic(items[i][1])
		end
	end
	if crateObjects[source] then
		if atmMoney and isElement(crateObjects[source]) then
			local x, y, z = getElementPosition(crateObjects[source])
			local rx, ry, rz = getElementRotation(crateObjects[source])
			local i = getElementInterior(crateObjects[source])
			local d = getElementDimension(crateObjects[source])
			crateMoneys[source] = createObject(sightexports.sModloader:getModelId(atmSuccess and "container_atm_cash" or "container_atm_cash2"), x, y, z, 0, 0, rz)
			setElementInterior(crateMoneys[source], i)
			setElementDimension(crateMoneys[source], d)
			if atmSuccess then
				crateAmounts[source] = atmMoney
			else
				local sound = playSound3D("files/pop.mp3", x, y, z)
				setElementInterior(sound, i)
				setElementDimension(sound, d)
			end
			setObjectScale(crateMoneys[source], (crateAmounts[source] or atmMoney) / 150000, 1, 1)
			if not atmSuccess then
				addGecus(x, y, z)
				setElementModel(crateObjects[source], sightexports.sModloader:getModelId("container_atm2"))
			end
		end
		if isElement(crateLoop[source]) then
			destroyElement(crateLoop[source])
		end
		crateLoop[source] = nil
		if isElement(crateCut[source]) then
			destroyElement(crateCut[source])
		end
		crateCut[source] = nil
		if isElement(flexObjects[source]) then
			destroyElement(flexObjects[source])
		end
		flexObjects[source] = nil
		if isElement(flexDiscs[source]) then
			destroyElement(flexDiscs[source])
		end
		flexDiscs[source] = nil
	end
	crateCutting[source] = nil
end)
addEventHandler("onClientPlayerStreamIn", getRootElement(), function()
	if crateOpening[source] then
		streamInCrate(source)
	end
end)
addEventHandler("onClientPlayerStreamOut", getRootElement(), function()
	if crateOpening[source] then
		streamOutCrate(source)
	end
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
	if crateOpening[source] then
		crateOpening[source] = nil
		crateR[source] = nil
		crateRT[source] = nil
		crateOpened[source] = nil
		crateOpenedItems[source] = nil
		streamOutCrate(source)
	end
end)
addEvent("rotateCrateOpening", true)
addEventHandler("rotateCrateOpening", getRootElement(), function(r)
	if crateOpening[source] then
		crateRT[source] = r
	end
end)
addEvent("clientCrateOpeningState", true)
addEventHandler("clientCrateOpeningState", getRootElement(), function(found, t, r)
	if isElement(source) and source ~= localPlayer then
		if found then
			crateOpening[source] = {
				found,
				t,
				r
			}
			if isElementStreamedIn(source) then
				streamInCrate(source)
			end
		else
			crateOpening[source] = nil
			crateR[source] = nil
			crateRT[source] = nil
			crateOpened[source] = nil
			crateOpenedItems[source] = nil
			streamOutCrate(source)
		end
	end
end)