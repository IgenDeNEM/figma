local sightexports = {sGui = false}
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
local gradientTick = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		gradientTick = sightexports.sGui:getGradientTick()
		guiRefreshedHud()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshGradientTick", getRootElement(), function()
	gradientTick = sightexports.sGui:getGradientTick()
end)
local barsWidgetPos = {0, 0}
local barsWidgetSize = {0, 0}
local oneH = 0
local barsWidgetState = false
local barColors = {}
local bloodColor = false
local health = 100
local armor = 0
local hunger = 65
local thirst = 75
stamina = 100
local damageTick = false
local damageLevel = 0
local dataFontRaw = "15/BebasNeueBold.otf"
local dataFont = false
local dataFontScale = false
local moneyWidgetFontRaw = "22/BebasNeueBold.otf"
local moneyWidgetFont = false
local moneyWidgetFontScale = false
local cameraIcon = false
local cameraIconSize = 0
local cameraWidgetFontRaw = "22/BebasNeueBold.otf"
local cameraWidgetFont = false
local cameraWidgetFontScale = false
local moneyHex = false
local sscHex = false
local ppHex = false
local moneyMinusHex = false
local blueColor = false
local greenColor = false
local hudWhite = false
local hpBloodGradient = false
addEvent("syncNeeds", true)
addEventHandler("syncNeeds", getRootElement(), function(h, t)
	hunger = h
	thirst = t
end)
function guiRefreshedHud()
	barColors = {
		bitReplace(sightexports.sGui:getColorCodeToColor("sightgrey1"), 174, 24, 8),
		sightexports.sGui:getColorCodeToColor("sightgreen"),
		sightexports.sGui:getColorCodeToColor("sightblue"),
		sightexports.sGui:getColorCodeToColor("sightyellow"),
		sightexports.sGui:getColorCodeToColor("sightblue-second"),
		sightexports.sGui:getColorCode("hudwhite")
	}
	bloodColor = sightexports.sGui:getColorCode("sightred")
	hpBloodGradient = sightexports.sGui:getGradient3Filename(350, 2, bloodColor, sightexports.sGui:getColorCode("sightgreen"))
	greenColor = sightexports.sGui:getColorCodeToColor("sightgreen")
	blueColor = sightexports.sGui:getColorCodeToColor("sightblue")
	moneyHex = sightexports.sGui:getColorCodeHex("sightgreen")
	sscHex = sightexports.sGui:getColorCodeHex("sightyellow")
	ppHex = sightexports.sGui:getColorCodeHex("sightblue")
	moneyMinusHex = sightexports.sGui:getColorCodeHex("sightred")
	hudWhite = sightexports.sGui:getColorCodeToColor("hudwhite")
	sightyellow = sightexports.sGui:getColorCodeToColor("sightyellow")
	sightred = sightexports.sGui:getColorCodeToColor("sightred")
	moneyWidgetFont = sightexports.sGui:getFont(moneyWidgetFontRaw)
	moneyWidgetFontScale = sightexports.sGui:getFontScale(moneyWidgetFontRaw)
	cameraWidgetFont = sightexports.sGui:getFont(cameraWidgetFontRaw)
	cameraWidgetFontScale = sightexports.sGui:getFontScale(cameraWidgetFontRaw)
	cameraIconSize = sightexports.sGui:getFontHeight(cameraWidgetFontRaw)
	cameraIcon = sightexports.sGui:getFaIconFilename("video", cameraIconSize)
	dataFont = sightexports.sGui:getFont(dataFontRaw)
	dataFontScale = sightexports.sGui:getFontScale(dataFontRaw)

	walkieIcon = sightexports.sGui:getFaIconFilename("walkie-talkie", 20)
	respawnIcon = sightexports.sGui:getFaIconFilename("hospital", 24)

end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	if getElementData(localPlayer, "loggedIn") then
		triggerServerEvent("requestMoney", localPlayer)
		triggerServerEvent("requestSSC", localPlayer)
		triggerServerEvent("requestPremiumData", localPlayer)
	end
end)
addEventHandler("onRealizedDamage", localPlayer, function()
	damageTick = getTickCount()
end)
addEventHandler("onClientPreRender", getRootElement(), function(delta)
	if damageTick then
		if getTickCount() - damageTick > 350 then
			damageLevel = math.max(0, damageLevel - delta / 1000 * 4)
			if damageLevel <= 0 then
				damageLevel = 0
				damageTick = false
			end
		else
			damageLevel = math.min(1, damageLevel + delta / 1000 * 4)
		end
	end
	local val = getElementHealth(localPlayer)
	if val > health then
		health = health + 100 * delta / 1000
		if val < health then
			health = val
		end
	elseif val < health then
		health = health - 100 * delta / 1000
		if val > health then
			health = val
		end
	end
	local val = getPedArmor(localPlayer)
	if val > armor then
		armor = armor + 100 * delta / 1000
		if val < armor then
			armor = val
		end
	elseif val < armor then
		armor = armor - 100 * delta / 1000
		if val > armor then
			armor = val
		end
	end
end)
local playerBlood = getElementData(localPlayer, "bloodDamage")
local charLevel = getElementData(localPlayer, "char.level") or 0
local charName = utf8.gsub(getElementData(localPlayer, "visibleName") or getPlayerName(localPlayer), "_", " ")
local playerID = getElementData(localPlayer, "playerID") or 0
local maxArmor = 1
addEvent("gotMaxArmorValue", true)
addEventHandler("gotMaxArmorValue", getRootElement(), function(val)
	maxArmor = val
end)
local barTooltip = false
function barsTooltip(x, y, sx, sy, name, tmp, cx, cy)
	if cx and not tmp and x <= cx and y <= cy and cx <= x + sx and cy <= y + sy then
		tmp = name
	end
	return tmp
end
function renderBars()
	local cx, cy = getCursorPosition()
	local tmp = false
	if cx and not widgetEditMode then
		cx = cx * screenX
		cy = cy * screenY
	end
	dxDrawRectangle(barsWidgetPos[1], barsWidgetPos[2], barsWidgetSize[1], oneH, barColors[1])
	local hpColor = barColors[2]
	local armorColor = barColors[3]
	if 0 < damageLevel then
		local r, g, b = interpolateBetween(bitExtract(barColors[2], 16, 8), bitExtract(barColors[2], 8, 8), bitExtract(barColors[2], 0, 8), bloodColor[1], bloodColor[2], bloodColor[3], damageLevel, "InOutQuad")
		hpColor = tocolor(r, g, b)
		local r, g, b = interpolateBetween(bitExtract(barColors[3], 16, 8), bitExtract(barColors[3], 8, 8), bitExtract(barColors[3], 0, 8), bloodColor[1], bloodColor[2], bloodColor[3], damageLevel, "InOutQuad")
		armorColor = tocolor(r, g, b)
	end
	if health < 20 then
		dxDrawRectangle(barsWidgetPos[1], barsWidgetPos[2], barsWidgetSize[1] / 2 * health / 100, oneH, tocolor(bloodColor[1], bloodColor[2], bloodColor[3]))
	else
		dxDrawRectangle(barsWidgetPos[1], barsWidgetPos[2], barsWidgetSize[1] / 2 * health / 100, oneH, hpColor)
		if playerBlood then
			local pulse = getTickCount() % 2000 / 1000
			if 1 < pulse then
				pulse = 2 - pulse
			end
			pulse = getEasingValue(pulse, "InOutQuad")
			dxDrawImage(barsWidgetPos[1], barsWidgetPos[2], math.floor(barsWidgetSize[1] / 2 * health / 100), oneH, ":sGui/" .. hpBloodGradient .. "." .. gradientTick[hpBloodGradient], 0, 0, 0, tocolor(255, 255, 255, 255 * (0.75 + 0.25 * pulse)))
		end
	end
	dxDrawRectangle(barsWidgetPos[1] + barsWidgetSize[1] / 2, barsWidgetPos[2], barsWidgetSize[1] / 2 * armor / maxArmor, oneH, armorColor)
	tmp = barsTooltip(barsWidgetPos[1], barsWidgetPos[2], barsWidgetSize[1] / 2, oneH, "Életerő", tmp, cx, cy)
	tmp = barsTooltip(barsWidgetPos[1] + barsWidgetSize[1] / 2, barsWidgetPos[2], barsWidgetSize[1] / 2, oneH, "Armor", tmp, cx, cy)
	dxDrawRectangle(barsWidgetPos[1], barsWidgetPos[2] + oneH + 8, barsWidgetSize[1], oneH, barColors[1])
	dxDrawRectangle(barsWidgetPos[1], barsWidgetPos[2] + oneH + 8, barsWidgetSize[1] / 2 * hunger / 100, oneH, barColors[4])
	dxDrawRectangle(barsWidgetPos[1] + barsWidgetSize[1] / 2, barsWidgetPos[2] + oneH + 8, barsWidgetSize[1] / 2 * thirst / 100, oneH, barColors[5])
	tmp = barsTooltip(barsWidgetPos[1], barsWidgetPos[2] + oneH + 8, barsWidgetSize[1] / 2, oneH, "Éhség", tmp, cx, cy)
	tmp = barsTooltip(barsWidgetPos[1] + barsWidgetSize[1] / 2, barsWidgetPos[2] + oneH + 8, barsWidgetSize[1] / 2, oneH, "Szomjúság", tmp, cx, cy)
	dxDrawRectangle(barsWidgetPos[1], barsWidgetPos[2] + (oneH + 8) * 2, barsWidgetSize[1], oneH, barColors[1])
	local r, g, b = barColors[6][1], barColors[6][2], barColors[6][3]
	if stamina < 50 then
		r = r * (0.6 + stamina / 50 * 0.4)
		g = g * (0.6 + stamina / 50 * 0.4)
		b = b * (0.6 + stamina / 50 * 0.4)
	end
	local oxy = getPedOxygenLevel(localPlayer) / 1000
	if oxy < 1 then
		dxDrawRectangle(barsWidgetPos[1], barsWidgetPos[2] + (oneH + 8) * 2, barsWidgetSize[1] * math.max(0, oxy), oneH, barColors[5])
		tmp = barsTooltip(barsWidgetPos[1], barsWidgetPos[2] + (oneH + 8) * 2, barsWidgetSize[1], oneH, "Oxigén", tmp, cx, cy)
	else
		dxDrawRectangle(barsWidgetPos[1], barsWidgetPos[2] + (oneH + 8) * 2, barsWidgetSize[1] * math.max(0, stamina / 100), oneH, tocolor(r, g, b))
		tmp = barsTooltip(barsWidgetPos[1], barsWidgetPos[2] + (oneH + 8) * 2, barsWidgetSize[1], oneH, "Stamina", tmp, cx, cy)
	end
	if barTooltip ~= tmp then
		barTooltip = tmp
		sightexports.sGui:showTooltip(barTooltip)
	end
end
addEvent("hudWidgetState:bars", true)
addEventHandler("hudWidgetState:bars", getRootElement(), function(state)
	if barsWidgetState ~= state then
		barsWidgetState = state
		if barsWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderBars)
		else
			removeEventHandler("onClientRender", getRootElement(), renderBars)
			if barTooltip then
				sightexports.sGui:showTooltip()
			end
		end
	end
end)
addEvent("hudWidgetPosition:bars", true)
addEventHandler("hudWidgetPosition:bars", getRootElement(), function(pos, final)
	barsWidgetPos = pos
end)
addEvent("hudWidgetSize:bars", true)
addEventHandler("hudWidgetSize:bars", getRootElement(), function(size, final)
	barsWidgetSize = size
	oneH = math.floor((size[2] - 16) / 3)
end)
local clockWidgetPos = {0, 0}
local clockWidgetSize = {0, 0}
function renderClock()
	local rt = getRealTime()
	if utf8.len(rt.hour) < 2 then
		rt.hour = 0 .. rt.hour
	end
	if 2 > utf8.len(rt.minute) then
		rt.minute = 0 .. rt.minute
	end
	dxDrawText(rt.hour .. ":" .. rt.minute, clockWidgetPos[1], clockWidgetPos[2], clockWidgetPos[1] + clockWidgetSize[1], clockWidgetPos[2] + clockWidgetSize[2], hudWhite, dataFontScale, dataFont, "center", "center")
end

function dxDrawTextEx(t, x, y, x2, y2, c, s, f, a, a2)
	dxDrawText(t, x + 1, y + 1, x2 + 1, y2 + 1, tocolor(0, 0, 0, 225), s, f, a, a2)
	dxDrawText(t, x, y, x2, y2, c, s, f, a, a2)
end

local badgeWidgetPos = {0, 0}
local badgeWidgetSize = {0, 0}

local walkieTalkieWidgetPos = {0, 0}
local walkieTalkieWidgetSize = {0, 0}

function renderBadge()
	local badgeData = getElementData(localPlayer, "badgeData")
	local badgeExData = getElementData(localPlayer, "badgeExData")
	if badgeData then
		dxDrawImage(badgeWidgetPos[1] - 25, badgeWidgetPos[2] + 15, 20, 20, ":sNames/files/badge.dds", 0, 0, 0, sightyellow)
		dxDrawTextEx(badgeData, badgeWidgetPos[1], badgeWidgetPos[2], badgeWidgetPos[1] + badgeWidgetSize[1], badgeWidgetPos[2] + badgeWidgetSize[2], sightyellow, dataFontScale, dataFont, "left", "center")
	elseif badgeExData then
		dxDrawImage(badgeWidgetPos[1] - 25, badgeWidgetPos[2] + 15, 20, 20, ":sNames/files/id.dds", 0, 0, 0, blueColor)
		dxDrawTextEx(badgeExData, badgeWidgetPos[1], badgeWidgetPos[2], badgeWidgetPos[1] + badgeWidgetSize[1], badgeWidgetPos[2] + badgeWidgetSize[2], blueColor, dataFontScale, dataFont, "left", "center")
	else
		dxDrawTextEx("Nincs jelvény felvéve", badgeWidgetPos[1], badgeWidgetPos[2], badgeWidgetPos[1] + badgeWidgetSize[1], badgeWidgetPos[2] + badgeWidgetSize[2], hudWhite, dataFontScale, dataFont, "left", "center")
	end
end

local respawnWidgetPos = {0, 0}
local respawnWidgetSize = {0, 0}

function renderRespawn()
	local lastRespawn = getElementData(localPlayer, "lastRespawn")
	if lastRespawn and tonumber(lastRespawn) and tonumber(lastRespawn) < 16 then
		dxDrawImage(respawnWidgetPos[1] + 2, respawnWidgetPos[2] + 4, 24, 24, ":sGui/" .. respawnIcon .. faTicks[respawnIcon], 0, 0, 0, sightred)
		if lastRespawn == 0 then
			dxDrawText("Most éledtél újra", respawnWidgetPos[1], respawnWidgetPos[2] - 4, respawnWidgetPos[1] + respawnWidgetSize[1], respawnWidgetPos[2] + respawnWidgetSize[2], hudwhite, dataFontScale, dataFont, "center", "center")
		else
			dxDrawText(lastRespawn .. " perce éledtél újra", respawnWidgetPos[1], respawnWidgetPos[2] - 4, respawnWidgetPos[1] + respawnWidgetSize[1], respawnWidgetPos[2] + respawnWidgetSize[2], hudwhite, dataFontScale, dataFont, "center", "center")
		end
	end
end

function renderWalkieTalkie()
	local radioData1 = "off"
	local radioData2 = "off"
	local radio = getElementData(localPlayer, "char.Radio") or {}
	if radio[1] then
		radioData1 = radio[1] or "off"
	end
	if radio[2] then
		radioData2 = radio[2] or "off"
	end
	for i = 1, 2 do
		dxDrawImage(walkieTalkieWidgetPos[1] - 26, walkieTalkieWidgetPos[2] + 63 + (i * 30), 22, 22, ":sGui/" .. walkieIcon .. faTicks[walkieIcon], 0, 0, 0, hudWhite)
		if i == 1 then
			dxDrawTextEx("R1: " .. radioData1, walkieTalkieWidgetPos[1], walkieTalkieWidgetPos[2] + i * 30, walkieTalkieWidgetPos[1] + walkieTalkieWidgetSize[1], walkieTalkieWidgetPos[2]  + i * 30 + walkieTalkieWidgetSize[2], hudWhite, dataFontScale, dataFont, "left", "center")
		elseif i == 2 then
			dxDrawTextEx("R2: " .. radioData2, walkieTalkieWidgetPos[1], walkieTalkieWidgetPos[2] + i * 30, walkieTalkieWidgetPos[1] + walkieTalkieWidgetSize[1], walkieTalkieWidgetPos[2]  + i * 30 + walkieTalkieWidgetSize[2], hudWhite, dataFontScale, dataFont, "left", "center")
		end
	end
end

addEvent("hudWidgetState:clock", true)
addEventHandler("hudWidgetState:clock", getRootElement(), function(state)
	if clockWidgetState ~= state then
		clockWidgetState = state
		if clockWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderClock)
		else
			removeEventHandler("onClientRender", getRootElement(), renderClock)
		end
	end
end)

addEvent("hudWidgetState:badge", true)
addEventHandler("hudWidgetState:badge", getRootElement(), function(state)
	if badgeWidgetState ~= state then
		badgeWidgetState = state
		if badgeWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderBadge)
		else
			removeEventHandler("onClientRender", getRootElement(), renderBadge)
		end
	end
end)

addEvent("hudWidgetState:respawn", true)
addEventHandler("hudWidgetState:respawn", getRootElement(), function(state)
	if badgeWidgetState ~= state then
		badgeWidgetState = state
		if badgeWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderRespawn)
		else
			removeEventHandler("onClientRender", getRootElement(), renderRespawn)
		end
	end
end)

addEvent("hudWidgetState:walkieTalkie", true)
addEventHandler("hudWidgetState:walkieTalkie", getRootElement(), function(state)
	if walkieTalkieWidgetState ~= state then
		walkieTalkieWidgetState = state
		if walkieTalkieWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderWalkieTalkie)
		else
			removeEventHandler("onClientRender", getRootElement(), renderWalkieTalkie)
		end
	end
end)

addEvent("hudWidgetPosition:clock", true)
addEventHandler("hudWidgetPosition:clock", getRootElement(), function(pos, final)
	clockWidgetPos = pos
end)

local bigClockWidgetPos = {0, 0}
local bigClockWidgetSize = {0, 0}

addEvent("hudWidgetPosition:badge", true)
addEventHandler("hudWidgetPosition:badge", getRootElement(), function(pos, final)
	badgeWidgetPos = pos
end)

addEvent("hudWidgetPosition:badge", true)
addEventHandler("hudWidgetPosition:badge", getRootElement(), function(pos, final)
	badgeWidgetPos = pos
end)

addEvent("hudWidgetPosition:walkieTalkie", true)
addEventHandler("hudWidgetPosition:walkieTalkie", getRootElement(), function(pos, final)
	walkieTalkieWidgetPos = pos
end)

addEvent("hudWidgetPosition:respawn", true)
addEventHandler("hudWidgetPosition:respawn", getRootElement(), function(pos, final)
	respawnWidgetPos = pos
end)

addEvent("hudWidgetSize:clock", true)
addEventHandler("hudWidgetSize:clock", getRootElement(), function(size, final)
	clockWidgetSize = size
end)

addEvent("hudWidgetSize:badge", true)
addEventHandler("hudWidgetSize:badge", getRootElement(), function(size, final)
	badgeWidgetSize = size
end)

addEvent("hudWidgetSize:walkieTalkie", true)
addEventHandler("hudWidgetSize:walkieTalkie", getRootElement(), function(size, final)
	walkieTalkieWidgetSize = size
end)

addEvent("hudWidgetSize:respawn", true)
addEventHandler("hudWidgetSize:respawn", getRootElement(), function(size, final)
	respawnWidgetSize = size
end)

function renderBigClock()
	local rt = getRealTime()
	if utf8.len(rt.hour) < 2 then
		rt.hour = 0 .. rt.hour
	end
	if 2 > utf8.len(rt.minute) then
		rt.minute = 0 .. rt.minute
	end
	dxDrawText(rt.hour .. ":" .. rt.minute, bigClockWidgetPos[1], bigClockWidgetPos[2], bigClockWidgetPos[1] + bigClockWidgetSize[1], bigClockWidgetPos[2] + bigClockWidgetSize[2], hudWhite, moneyWidgetFontScale * 0.9, moneyWidgetFont, "center", "center")
end
addEvent("hudWidgetState:bigClock", true)
addEventHandler("hudWidgetState:bigClock", getRootElement(), function(state)
	if bigClockWidgetState ~= state then
		bigClockWidgetState = state
		if bigClockWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderBigClock)
		else
			removeEventHandler("onClientRender", getRootElement(), renderBigClock)
		end
	end
end)
addEvent("hudWidgetPosition:bigClock", true)
addEventHandler("hudWidgetPosition:bigClock", getRootElement(), function(pos, final)
	bigClockWidgetPos = pos
end)
addEvent("hudWidgetSize:bigClock", true)
addEventHandler("hudWidgetSize:bigClock", getRootElement(), function(size, final)
	bigClockWidgetSize = size
end)
addEventHandler("onClientElementDataChange", localPlayer, function(data, was, new)
	if data == "visibleName" then
		charName = utf8.gsub(new or getPlayerName(localPlayer), "_", " ")
	elseif data == "char.level" then
		charLevel = new
	elseif data == "bloodDamage" then
		playerBlood = new
	elseif data == "playerID" then
		playerID = new
	end
end)
local charDataWidgetPos = {0, 0}
local charDataWidgetSize = {0, 0}
function renderCharData()
	local rt = getRealTime()
	if utf8.len(rt.hour) < 2 then
		rt.hour = 0 .. rt.hour
	end
	if 2 > utf8.len(rt.minute) then
		rt.minute = 0 .. rt.minute
	end
	dxDrawText(rt.hour .. ":" .. rt.minute, charDataWidgetPos[1], charDataWidgetPos[2], charDataWidgetPos[1] + charDataWidgetSize[1], charDataWidgetPos[2] + charDataWidgetSize[2], hudWhite, dataFontScale, dataFont, "left", "center")
	dxDrawText(charName .. " (" .. playerID .. ") | LVL " .. charLevel, charDataWidgetPos[1], charDataWidgetPos[2], charDataWidgetPos[1] + charDataWidgetSize[1], charDataWidgetPos[2] + charDataWidgetSize[2], hudWhite, dataFontScale, dataFont, "right", "center")
end
addEvent("hudWidgetState:charData", true)
addEventHandler("hudWidgetState:charData", getRootElement(), function(state)
	if charDataWidgetState ~= state then
		charDataWidgetState = state
		if charDataWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderCharData)
		else
			removeEventHandler("onClientRender", getRootElement(), renderCharData)
		end
	end
end)
addEvent("hudWidgetPosition:charData", true)
addEventHandler("hudWidgetPosition:charData", getRootElement(), function(pos, final)
	charDataWidgetPos = pos
end)
addEvent("hudWidgetSize:charData", true)
addEventHandler("hudWidgetSize:charData", getRootElement(), function(size, final)
	charDataWidgetSize = size
end)
local charDataExWidgetPos = {0, 0}
local charDataExWidgetSize = {0, 0}
function renderCharDataEx()
	dxDrawText(charName .. " (" .. playerID .. ") | LVL " .. charLevel, charDataExWidgetPos[1], charDataExWidgetPos[2], charDataExWidgetPos[1] + charDataExWidgetSize[1], charDataExWidgetPos[2] + charDataExWidgetSize[2], hudWhite, dataFontScale, dataFont, "center", "center")
end
addEvent("hudWidgetState:charDataEx", true)
addEventHandler("hudWidgetState:charDataEx", getRootElement(), function(state)
	if charDataExWidgetState ~= state then
		charDataExWidgetState = state
		if charDataExWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderCharDataEx)
		else
			removeEventHandler("onClientRender", getRootElement(), renderCharDataEx)
		end
	end
end)
addEvent("hudWidgetPosition:charDataEx", true)
addEventHandler("hudWidgetPosition:charDataEx", getRootElement(), function(pos, final)
	charDataExWidgetPos = pos
end)
addEvent("hudWidgetSize:charDataEx", true)
addEventHandler("hudWidgetSize:charDataEx", getRootElement(), function(size, final)
	charDataExWidgetSize = size
end)
local storedMoney = 0
local money = 0
local moneyZeros = 0
local moneyWidgetPos = {0, 0}
local moneyWidgetSize = {0, 0}
local transactions = {}
local ssc = 0
local wasSSC = false
local sscTrans = false
local sscZeros = 0
local sscWidgetPos = {0, 0}
local sscWidgetSize = {0, 0}
local ppZeros = 0
local ppWidgetPos = {0, 0}
local ppWidgetSize = {0, 0}
local ppBalance = 0
local ppTrans = false
local wasPP = false
addEvent("gotPremiumData", true)
addEventHandler("gotPremiumData", getRootElement(), function(balance)
	if balance and balance ~= ppBalance then
		if not wasPP then
			wasPP = amount
		else
			wasPP = ssc
			ppTrans = getTickCount()
			playSound("files/pptrans.wav")
		end
		ppBalance = balance
	end
end)
addEvent("refreshSSC", true)
addEventHandler("refreshSSC", getRootElement(), function(amount)
	if amount then
		if not wasSSC then
			wasSSC = amount
		elseif ssc ~= amount then
			wasSSC = ssc
			sscTrans = getTickCount()
		end
		ssc = amount
	end
end)
addEvent("refreshMoney", true)
addEventHandler("refreshMoney", getRootElement(), function(m, instant)
	if widgets.money.deleted then
		instant = true
	end
	local old = storedMoney
	storedMoney = tonumber(m) or 0
	if instant then
		money = storedMoney
	else
		local d = storedMoney - (tonumber(old) or 0)
		if 0 < math.abs(d) then
			if not transactions[1] then
				if 0 < d then
					playSound("files/money.mp3")
				else
					playSound("files/money2.mp3")
				end
			end
			if moneyWidgetState then
				local time = utf8.len(tostring(d)) * 3000
				time = time - 18000
				if time < 1000 then
					time = 1000
				end
				table.insert(transactions, {
					getTickCount(),
					d,
					money,
					storedMoney,
					time
				})
			else
				money = storedMoney
			end
		end
	end
end)
local zeroWidth = 0
local dollarWidth = 0
local sscWidth = 0
local ppWidth = 0
local lastMoney = 0
local lastMoneyTick = 0
function renderMoney()
	local text = ""
	if transactions[1] then
		prog = math.min((getTickCount() - transactions[1][1]) / transactions[1][5], 1)
		money = math.floor(transactions[1][3] + (transactions[1][4] - transactions[1][3]) * prog)
		if lastMoney ~= money then
			lastMoney = money
			if getTickCount() - lastMoneyTick > 30 then
				lastMoneyTick = getTickCount()
				playSound("files/moneycount.mp3")
			end
		end
	end
	local negative = money < 0
	local val = tostring(math.min(money, math.pow(10, moneyZeros) - 1))
	local x = moneyWidgetPos[1]
	if negative then
		x = x + zeroWidth * (moneyZeros - utf8.len(val))
	else
		for k = 1, moneyZeros - utf8.len(val) do
			dxDrawText("0", x, moneyWidgetPos[2], x + zeroWidth, moneyWidgetPos[2] + moneyWidgetSize[2], hudWhite, moneyWidgetFontScale, moneyWidgetFont, "center", "center", false, false, false, true)
			x = x + zeroWidth
		end
	end
	local col = moneyHex
	if negative then
		col = moneyMinusHex
	end
	for k = 1, utf8.len(val) do
		dxDrawText(col .. utf8.sub(val, k, k), x, moneyWidgetPos[2], x + zeroWidth, moneyWidgetPos[2] + moneyWidgetSize[2], hudWhite, moneyWidgetFontScale, moneyWidgetFont, "center", "center", false, false, false, true)
		x = x + zeroWidth
	end
	dxDrawText(col .. " $", x, moneyWidgetPos[2], x + zeroWidth, moneyWidgetPos[2] + moneyWidgetSize[2], hudWhite, moneyWidgetFontScale, moneyWidgetFont, "center", "center", false, false, false, true)
	if transactions[1] then
		if getTickCount() - transactions[1][1] >= transactions[1][5] then
			money = transactions[1][4]
			table.remove(transactions, 1)
			if transactions[1] then
				if 0 < transactions[1][2] then
					playSound("files/money.mp3")
				else
					playSound("files/money2.mp3")
				end
				transactions[1][1] = getTickCount()
				transactions[1][3] = money
			end
		else
			local prog = math.min((getTickCount() - transactions[1][1]) / transactions[1][5], 1)
			local y = -16 - prog * 16
			local a = 255 - prog * 255
			dxDrawText((0 < transactions[1][2] and moneyHex or moneyMinusHex) .. (0 < transactions[1][2] and "+" or "") .. transactions[1][2] .. " $", 0, moneyWidgetPos[2] + y, moneyWidgetPos[1] + moneyWidgetSize[1] - dollarWidth * 0.1, moneyWidgetPos[2] + moneyWidgetSize[2] + y, bitReplace(hudWhite, math.min(255, a * 1.5), 24, 8), moneyWidgetFontScale * 0.9, moneyWidgetFont, "right", "center", false, false, true, true)
		end
	end
end
addEvent("hudWidgetState:money", true)
addEventHandler("hudWidgetState:money", getRootElement(), function(state)
	if moneyWidgetState ~= state then
		moneyWidgetState = state
		if moneyWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderMoney)
		else
			money = storedMoney
			transactions = {}
			removeEventHandler("onClientRender", getRootElement(), renderMoney)
		end
	end
end)
addEvent("hudWidgetPosition:money", true)
addEventHandler("hudWidgetPosition:money", getRootElement(), function(pos, final)
	moneyWidgetPos = pos
end)
addEvent("hudWidgetSize:money", true)
addEventHandler("hudWidgetSize:money", getRootElement(), function(size, final)
	moneyWidgetSize = size
	zeroWidth = sightexports.sGui:getTextWidthFont("0", moneyWidgetFontRaw)
	dollarWidth = sightexports.sGui:getTextWidthFont(" $", moneyWidgetFontRaw)
	moneyZeros = math.floor((size[1] - dollarWidth) / zeroWidth + 0.5)
end)
function renderSsc()
	local text = ""
	local negative = ssc < 0
	local val = tostring(math.min(ssc, math.pow(10, sscZeros) - 1))
	local x = sscWidgetPos[1]
	if negative then
		x = x + zeroWidth * (sscZeros - utf8.len(val))
	else
		for k = 1, sscZeros - utf8.len(val) do
			dxDrawText("0", x, sscWidgetPos[2], x + zeroWidth, sscWidgetPos[2] + sscWidgetSize[2], hudWhite, moneyWidgetFontScale, moneyWidgetFont, "center", "center", false, false, false, true)
			x = x + zeroWidth
		end
	end
	local col = sscHex
	if negative then
		col = moneyMinusHex
	end
	for k = 1, utf8.len(val) do
		dxDrawText(col .. utf8.sub(val, k, k), x, sscWidgetPos[2], x + zeroWidth, sscWidgetPos[2] + sscWidgetSize[2], hudWhite, moneyWidgetFontScale, moneyWidgetFont, "center", "center", false, false, false, true)
		x = x + zeroWidth
	end
	dxDrawText(col .. " SSC", x, sscWidgetPos[2], x + sscWidth, sscWidgetPos[2] + sscWidgetSize[2], hudWhite, moneyWidgetFontScale, moneyWidgetFont, "center", "center", false, false, false, true)
	if sscTrans then
		local delta = getTickCount() - sscTrans
		local d = ssc - wasSSC
		local prog = math.min(1, delta / 500)
		local y = -16 * (0.65 + prog)
		if 3000 < delta then
			prog = math.max(0, 1 - (delta - 3000) / 500)
		end
		local a = 255 * prog
		dxDrawText((0 < d and moneyHex or moneyMinusHex) .. (0 < d and "+" or "") .. d .. " SSC", 0, sscWidgetPos[2] + y, sscWidgetPos[1] + sscWidgetSize[1] - sscWidth * 0.1, sscWidgetPos[2] + sscWidgetSize[2] + y, bitReplace(hudWhite, a, 24, 8), moneyWidgetFontScale * 0.9, moneyWidgetFont, "right", "center", false, false, true, true)
		if 3500 < delta then
			sscTrans = false
			wasSSC = ssc
		end
	end
end
addEvent("hudWidgetState:ssc", true)
addEventHandler("hudWidgetState:ssc", getRootElement(), function(state)
	if sscWidgetState ~= state then
		sscWidgetState = state
		if sscWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderSsc)
		else
			removeEventHandler("onClientRender", getRootElement(), renderSsc)
		end
	end
end)
addEvent("hudWidgetPosition:ssc", true)
addEventHandler("hudWidgetPosition:ssc", getRootElement(), function(pos, final)
	sscWidgetPos = pos
end)
addEvent("hudWidgetSize:ssc", true)
addEventHandler("hudWidgetSize:ssc", getRootElement(), function(size, final)
	sscWidgetSize = size
	zeroWidth = sightexports.sGui:getTextWidthFont("0", moneyWidgetFontRaw)
	sscWidth = sightexports.sGui:getTextWidthFont(" SSC", moneyWidgetFontRaw)
	sscZeros = math.floor((size[1] - sscWidth) / zeroWidth + 0.5)
end)
function renderPP()
	local text = ""
	local negative = ppBalance < 0
	local val = tostring(math.min(ppBalance, math.pow(10, ppZeros) - 1))
	local x = ppWidgetPos[1]
	if negative then
		x = x + zeroWidth * (ppZeros - utf8.len(val))
	else
		for k = 1, ppZeros - utf8.len(val) do
			dxDrawText("0", x, ppWidgetPos[2], x + zeroWidth, ppWidgetPos[2] + ppWidgetSize[2], hudWhite, moneyWidgetFontScale, moneyWidgetFont, "center", "center", false, false, false, true)
			x = x + zeroWidth
		end
	end
	local col = ppHex
	if negative then
		col = moneyMinusHex
	end
	for k = 1, utf8.len(val) do
		dxDrawText(col .. utf8.sub(val, k, k), x, ppWidgetPos[2], x + zeroWidth, ppWidgetPos[2] + ppWidgetSize[2], hudWhite, moneyWidgetFontScale, moneyWidgetFont, "center", "center", false, false, false, true)
		x = x + zeroWidth
	end
	dxDrawText(col .. " PP", x, ppWidgetPos[2], x + ppWidth, ppWidgetPos[2] + ppWidgetSize[2], hudWhite, moneyWidgetFontScale, moneyWidgetFont, "center", "center", false, false, false, true)
	if ppTrans then
		local delta = getTickCount() - ppTrans
		local d = ppBalance - wasPP
		local prog = math.min(1, delta / 500)
		local y = -16 * (0.65 + prog)
		if 3000 < delta then
			prog = math.max(0, 1 - (delta - 3000) / 500)
		end
		local a = 255 * prog
		dxDrawText((0 < d and moneyHex or moneyMinusHex) .. (0 < d and "+" or "") .. d .. " PP", 0, ppWidgetPos[2] + y, ppWidgetPos[1] + ppWidgetSize[1] - ppWidth * 0.1, ppWidgetPos[2] + ppWidgetSize[2] + y, bitReplace(hudWhite, a, 24, 8), moneyWidgetFontScale * 0.9, moneyWidgetFont, "right", "center", false, false, true, true)
		if 3500 < delta then
			ppTrans = false
			wasPP = ppBalance
		end
	end
end
addEvent("hudWidgetState:pp", true)
addEventHandler("hudWidgetState:pp", getRootElement(), function(state)
	if ppWidgetState ~= state then
		ppWidgetState = state
		if ppWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderPP)
		else
			removeEventHandler("onClientRender", getRootElement(), renderPP)
		end
	end
end)
addEvent("hudWidgetPosition:pp", true)
addEventHandler("hudWidgetPosition:pp", getRootElement(), function(pos, final)
	ppWidgetPos = pos
end)
addEvent("hudWidgetSize:pp", true)
addEventHandler("hudWidgetSize:pp", getRootElement(), function(size, final)
	ppWidgetSize = size
	zeroWidth = sightexports.sGui:getTextWidthFont("0", moneyWidgetFontRaw)
	ppWidth = sightexports.sGui:getTextWidthFont(" PP", moneyWidgetFontRaw)
	ppZeros = math.floor((size[1] - ppWidth) / zeroWidth + 0.5)
end)
local cameramodeWidgetState = false
local cameramodeWidgetPos = false
local cameramodeWidgetSize = false
local currentCameraMode = "Normál"
local cameraFade = false
function setCameraMode(mode)
	cameraFade = getTickCount()
	currentCameraMode = mode
end
function getCameraMode()
	return currentCameraMode
end
function renderCameramode()
	if cameraFade then
		local p = (getTickCount() - cameraFade) / 250
		if 4.5 < p then
			p = 1 - (p - 4.5)
		else
			p = 1
		end
		if p < 0 then
			cameraFade = false
		else
			local w = dxGetTextWidth(currentCameraMode, cameraWidgetFontScale * 0.9, cameraWidgetFont) + cameraIconSize
			local x = cameramodeWidgetPos[1] + cameramodeWidgetSize[1] / 2 - w / 2
			dxDrawImage(x, cameramodeWidgetPos[2] + cameramodeWidgetSize[2] / 2 - cameraIconSize / 2, cameraIconSize, cameraIconSize, ":sGui/" .. cameraIcon .. faTicks[cameraIcon], 0, 0, 0, bitReplace(hudWhite, 255 * p, 24, 8))
			dxDrawText(currentCameraMode, x + cameraIconSize, cameramodeWidgetPos[2], 0, cameramodeWidgetPos[2] + cameramodeWidgetSize[2], bitReplace(hudWhite, 255 * p, 24, 8), cameraWidgetFontScale * 0.9, cameraWidgetFont, "left", "center")
		end
	end
end
addEvent("hudWidgetState:cameramode", true)
addEventHandler("hudWidgetState:cameramode", getRootElement(), function(state)
	if cameramodeWidgetState ~= state then
		cameramodeWidgetState = state
		if cameramodeWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderCameramode)
		else
			removeEventHandler("onClientRender", getRootElement(), renderCameramode)
		end
	end
end)
addEvent("hudWidgetPosition:cameramode", true)
addEventHandler("hudWidgetPosition:cameramode", getRootElement(), function(pos, final)
	cameramodeWidgetPos = pos
end)
addEvent("hudWidgetSize:cameramode", true)
addEventHandler("hudWidgetSize:cameramode", getRootElement(), function(size, final)
	cameramodeWidgetSize = size
end)
local rulerWidgetState = false
local rulerWidgetPos = false
local rulerWidgetSize = false
function renderRuler()
	dxDrawRectangle(rulerWidgetPos[1] + rulerWidgetSize[1] / 2 - 1, rulerWidgetPos[2], 2, rulerWidgetSize[2], tocolor(255, 255, 255))
	dxDrawRectangle(rulerWidgetPos[1], rulerWidgetPos[2] + rulerWidgetSize[2] / 2 - 1, rulerWidgetSize[1], 2, tocolor(255, 255, 255))
	dxDrawText(rulerWidgetSize[1], 0, 0, rulerWidgetPos[1] + rulerWidgetSize[1], rulerWidgetPos[2] + rulerWidgetSize[2] / 2 - 1, hudWhite, dataFontScale, dataFont, "right", "bottom")
	dxDrawText(rulerWidgetSize[2], rulerWidgetPos[1] + rulerWidgetSize[1] / 2 + 1, 0, 0, rulerWidgetPos[2] + rulerWidgetSize[2], hudWhite, dataFontScale, dataFont, "left", "bottom")
end
addEvent("hudWidgetState:ruler", true)
addEventHandler("hudWidgetState:ruler", getRootElement(), function(state)
	if rulerWidgetState ~= state then
		rulerWidgetState = state
		if rulerWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderRuler)
		else
			removeEventHandler("onClientRender", getRootElement(), renderRuler)
		end
	end
end)
addEvent("hudWidgetPosition:ruler", true)
addEventHandler("hudWidgetPosition:ruler", getRootElement(), function(pos, final)
	rulerWidgetPos = pos
end)
addEvent("hudWidgetSize:ruler", true)
addEventHandler("hudWidgetSize:ruler", getRootElement(), function(size, final)
	rulerWidgetSize = size
end)
