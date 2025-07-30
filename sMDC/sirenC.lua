local seexports = {
	sGui = false,
	sGroups = false,
	sPermission = false,
	sHud = false,
	sModloader = false
}
local function sightlangProcessExports()
	for k in pairs(seexports) do
		local res = getResourceFromName(k)
		if res and getResourceState(res) == "running" then
			seexports[k] = exports[k]
		else
			seexports[k] = false
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
local faTicks = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		faTicks = exports.sGui:getFaTicks()
		refreshSirenColors()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
	faTicks = exports.sGui:getFaTicks()
end)
local sightlangModloaderLoaded = function()
	loadModelIds()
	triggerServerEvent("requestCoronaSirens", localPlayer)
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or exports.sModloader and exports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), processSirenSoundEffects, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), processSirenSoundEffects)
		end
	end
end
local x, y = 100, 550
local sx, sy = 350, 50
local icons = {}
local red, blue
function refreshSirenColors()
	red = exports.sGui:getColorCode("sightred")
	blue = exports.sGui:getColorCode("sightblue")
	icons = {
		siren = exports.sGui:getFaIconFilename("siren", 64),
		["siren-on"] = exports.sGui:getFaIconFilename("siren-on", 64),
		slash = exports.sGui:getFaIconFilename("slash", 64),
		slash2 = exports.sGui:getFaIconFilename("slash", 64, "regular"),
		waveform = exports.sGui:getFaIconFilename("waveform", 64),
		waveform2 = exports.sGui:getFaIconFilename("waveform", 64, "light"),
		bullhorn = exports.sGui:getFaIconFilename("bullhorn", 64),
		bullhorn2 = exports.sGui:getFaIconFilename("bullhorn", 64, "regular"),
		["walkie-talkie"] = exports.sGui:getFaIconFilename("walkie-talkie", 64),
		["walkie-talkie2"] = exports.sGui:getFaIconFilename("walkie-talkie", 64, "regular")
	}
end
local sosMode = true
local currentSiren = {}
local sirenHorn = {}
local sirenSounds = {}
function easeOutExpo(x)
	if x == 1 then
		return 1
	else
		return 1 - math.pow(2, -10 * x)
	end
end
function processSirenSoundEffects()
	local cx, cy, cz = getCameraMatrix()
	local found = false
	for veh, sound in pairs(sirenSounds) do
		found = true
		if isElement(sound) and isElementStreamedIn(sound) then
			local x, y, z = getElementPosition(veh)
			local p = easeOutExpo(math.min(1, getDistanceBetweenPoints3D(cx, cy, cz, x, y, z) / 310))
			setSoundEffectParameter(sound, "reverb", "reverbMix", -96 + 96 * p)
			setSoundEffectParameter(sound, "parameq", "center", 8000 + 3000 * p)
			setSoundEffectParameter(sound, "parameq", "gain", -15 * p)
		end
	end
	for veh, sound in pairs(sirenHorn) do
		found = true
		if isElement(sound) and isElementStreamedIn(sound) then
			local x, y, z = getElementPosition(veh)
			local p = easeOutExpo(math.min(1, getDistanceBetweenPoints3D(cx, cy, cz, x, y, z) / 210))
			setSoundEffectParameter(sound, "reverb", "reverbMix", -96 + 96 * p)
			setSoundEffectParameter(sound, "parameq", "center", 8000 + 3000 * p)
			setSoundEffectParameter(sound, "parameq", "gain", -15 * p)
		end
	end
	if not found then
		sightlangCondHandl0(false)
	end
end
function processSiren(veh)
	if isElement(sirenSounds[veh]) then
		destroyElement(sirenSounds[veh])
	end
	sirenSounds[veh] = nil
	if isElement(veh) and currentSiren[veh] then
		local model = getElementModel(veh)
		if currentSiren[veh] == 3 then
			local x, y, z = getElementPosition(veh)
			sirenSounds[veh] = playSound3D("files/siren/toll.mp3", x, y, z, true)
			attachElements(sirenSounds[veh], veh)
			setSoundMaxDistance(sirenSounds[veh], 300)
		elseif currentSiren[veh] == 4 then
			local x, y, z = getElementPosition(veh)
			sirenSounds[veh] = playSound3D("files/siren/frost.mp3", x, y, z, true)
			attachElements(sirenSounds[veh], veh)
			setSoundMaxDistance(sirenSounds[veh], 300)
		elseif currentSiren[veh] == 5 then
			local x, y, z = getElementPosition(veh)
			sirenSounds[veh] = playSound3D("files/siren/tankolninemlehet.mp3", x, y, z, true)
			attachElements(sirenSounds[veh], veh)
			setSoundMaxDistance(sirenSounds[veh], 300)
		elseif currentSiren[veh] == 6 then
			local x, y, z = getElementPosition(veh)
			sirenSounds[veh] = playSound3D("files/siren/tengericsiga.mp3", x, y, z, true)
			attachElements(sirenSounds[veh], veh)
			setSoundMaxDistance(sirenSounds[veh], 300)
		elseif sirenVehicles[model] and sirenVehicles[model].sounds[currentSiren[veh]] then
			local x, y, z = getElementPosition(veh)
			sirenSounds[veh] = playSound3D("files/siren/" .. sirenVehicles[model].sounds[currentSiren[veh]], x, y, z, true)
			attachElements(sirenSounds[veh], veh)
			setSoundMaxDistance(sirenSounds[veh], 300)
		else
			local x, y, z = getElementPosition(veh)
			sirenSounds[veh] = playSound3D("files/siren/" .. currentSiren[veh] .. ".mp3", x, y, z, true)
			attachElements(sirenSounds[veh], veh)
			setSoundMaxDistance(sirenSounds[veh], 300)
		end
		if sirenSounds[veh] then
			setSoundEffectEnabled(sirenSounds[veh], "reverb", true)
			setSoundEffectEnabled(sirenSounds[veh], "parameq", true)
			sightlangCondHandl0(true)
		end
	end
end
local vehicles = getElementsByType("vehicle")
for i = 1, #vehicles do
	local data = getElementData(vehicles[i], "sirenSound")
	if data then
		currentSiren[vehicles[i]] = data
		processSiren(vehicles[i])
	end
end
addEventHandler("onClientElementDestroy", getRootElement(), function()
	if sirenSounds[source] then
		processSiren(source)
	end
	currentSiren[source] = nil
end)
addEventHandler("onClientVehicleDataChange", getRootElement(), function(data, old, new)
	if data == "sirenSound" then
		currentSiren[source] = new
		processSiren(source)
	end
end)
function endSirenHorn(veh)
	if isElement(sirenHorn[veh]) then
		destroyElement(sirenHorn[veh])
	end
	sirenHorn[veh] = nil
end
addEvent("vehicleSirenHorn", true)
addEventHandler("vehicleSirenHorn", getRootElement(), function()
	if isElement(source) and not sirenHorn[source] then
		local model = getElementModel(source)
		if sirenVehicles[model] then
			local x, y, z = getElementPosition(source)
			sirenHorn[source] = playSound3D("files/siren/" .. sirenVehicles[model].horn, x, y, z, false)
			attachElements(sirenHorn[source], source)
			setSoundMaxDistance(sirenHorn[source], 200)
			setTimer(endSirenHorn, 560, 1, source)
		else
			local x, y, z = getElementPosition(source)
			sirenHorn[source] = playSound3D("files/siren/horn.mp3", x, y, z, false)
			attachElements(sirenHorn[source], source)
			setSoundMaxDistance(sirenHorn[source], 200)
			setTimer(endSirenHorn, 560, 1, source)
		end
		if sirenHorn[source] then
			setSoundEffectEnabled(sirenHorn[source], "reverb", true)
			setSoundEffectEnabled(sirenHorn[source], "parameq", true)
			sightlangCondHandl0(true)
		end
	end
end)
local currentHover = false
local sirenWidgetState = false
local sirenWidgetIs = 0
local sirenVehicle = false
function sirenVehicleEnter(veh, seat)
	sirenVehicle = false
	if seat <= 1 then
		local model = getElementModel(veh)
		if getElementData(veh, "vehicle.customModel") then
			model = getElementData(veh, "vehicle.customModel")
		end
		if checkSirenVehicle(veh, model) or getElementData(veh, "civilSiren") then
			sirenVehicle = veh
			sosMode = exports.sGroups:getPlayerPermission("squad")
		end
	end
end
addEventHandler("onClientPlayerVehicleEnter", localPlayer, sirenVehicleEnter)
function sirenVehicleExit(veh, seat)
	if sirenVehicle then
		sirenVehicle = false
	end
end
addEventHandler("onClientPlayerVehicleExit", localPlayer, sirenVehicleExit)
function renderSirenWidget()
	local tmp = false
	if sirenVehicle then
		local veh = getPedOccupiedVehicle(localPlayer)
		local seat = getPedOccupiedVehicleSeat(localPlayer)
		if veh == sirenVehicle and seat <= 1 then
			local now = getTickCount()
			local n = sosMode and 6 or 5
			local is = math.min(64, math.floor(math.min(sy, sx / n)))
			local w = (sx - is) / (n - 1)
			local y = y + sy / 2 - is / 2
			local cx, cy = getCursorPosition()
			if cx then
				cx = cx * screenX
				cy = cy * screenY
				if y <= cy and cy <= y + is then
					if cx >= x + 0 * w and cx <= x + 0 * w + is then
						tmp = "siren"
					elseif cx >= x + 1 * w and cx <= x + 1 * w + is then
						tmp = "sound0"
					elseif cx >= x + 2 * w and cx <= x + 2 * w + is then
						tmp = "sound1"
					elseif cx >= x + 3 * w and cx <= x + 3 * w + is then
						tmp = "sound2"
					elseif cx >= x + 4 * w and cx <= x + 4 * w + is then
						tmp = "horn"
					elseif sosMode and cx >= x + 5 * w and cx <= x + 5 * w + is then
						tmp = "sos"
					end
				end
			end
			if getVehicleSirensOn(veh) or getElementData(veh, "vehicle.sirenstate") then
				local pulse = now % 700 / 350
				local col = blue
				if 1 < pulse then
					col = red
					pulse = pulse - 1
				end
				dxDrawImage(x + 0 * w + 4 + 1, y + 4 + 1, is - 8, is - 8, ":sGui/" .. icons["siren-on"] .. faTicks[icons["siren-on"]], 0, 0, 0, tocolor(0, 0, 0, 60))
				dxDrawImage(x + 0 * w + 4, y + 4, is - 8, is - 8, ":sGui/" .. icons["siren-on"] .. faTicks[icons["siren-on"]], 0, 0, 0, tocolor(col[1], col[2], col[3], 150 + 105 * (1 - pulse)))
			else
				dxDrawImage(x + 0 * w + 4 + 1, y + 4 + 1, is - 8, is - 8, ":sGui/" .. icons.siren .. faTicks[icons.siren], 0, 0, 0, tocolor(0, 0, 0, 60))
				dxDrawImage(x + 0 * w + 4, y + 4, is - 8, is - 8, ":sGui/" .. icons.siren .. faTicks[icons.siren], 0, 0, 0, tocolor(255, 255, 255, tmp == "siren" and 255 or 150))
			end
			if not currentSiren[veh] then
				dxDrawImage(x + 1 * w + 4 + 1, y + 4 + 1, is - 8, is - 8, ":sGui/" .. icons.waveform .. faTicks[icons.waveform], 0, 0, 0, tocolor(0, 0, 0, 60))
				dxDrawImage(x + 1 * w + 4 + 1, y + 4 + 1, is - 8, is - 8, ":sGui/" .. icons.slash .. faTicks[icons.slash], 0, 0, 0, tocolor(0, 0, 0, 60))
				dxDrawImage(x + 1 * w + 4, y + 4, is - 8, is - 8, ":sGui/" .. icons.waveform .. faTicks[icons.waveform], 0, 0, 0, tocolor(blue[1], blue[2], blue[3], tmp == "sound0" and 255 or 220))
				dxDrawImage(x + 1 * w + 4, y + 4, is - 8, is - 8, ":sGui/" .. icons.slash .. faTicks[icons.slash], 0, 0, 0, tocolor(blue[1], blue[2], blue[3], tmp == "sound0" and 255 or 220))
			else
				dxDrawImage(x + 1 * w + 4 + 1, y + 4 + 1, is - 8, is - 8, ":sGui/" .. icons.waveform2 .. faTicks[icons.waveform2], 0, 0, 0, tocolor(0, 0, 0, 60))
				dxDrawImage(x + 1 * w + 4 + 1, y + 4 + 1, is - 8, is - 8, ":sGui/" .. icons.slash2 .. faTicks[icons.slash2], 0, 0, 0, tocolor(0, 0, 0, 60))
				dxDrawImage(x + 1 * w + 4, y + 4, is - 8, is - 8, ":sGui/" .. icons.waveform2 .. faTicks[icons.waveform2], 0, 0, 0, tocolor(255, 255, 255, tmp == "sound0" and 255 or 150))
				dxDrawImage(x + 1 * w + 4, y + 4, is - 8, is - 8, ":sGui/" .. icons.slash2 .. faTicks[icons.slash2], 0, 0, 0, tocolor(255, 255, 255, tmp == "sound0" and 255 or 150))
			end
			if currentSiren[veh] == 1 then
				local pulse = now % 2000 / 1000
				if 1 < pulse then
					pulse = 2 - pulse
				end
				pulse = getEasingValue(pulse, "InOutQuad")
				local r = red[1] + (blue[1] - red[1]) * pulse
				local g = red[2] + (blue[2] - red[2]) * pulse
				local b = red[3] + (blue[3] - red[3]) * pulse
				dxDrawImage(x + 2 * w + 4 + 1, y + 4 + 1, is - 8, is - 8, ":sGui/" .. icons.waveform .. faTicks[icons.waveform], 0, 0, 0, tocolor(0, 0, 0, 60))
				dxDrawImage(x + 2 * w + 4, y + 4, is - 8, is - 8, ":sGui/" .. icons.waveform .. faTicks[icons.waveform], 0, 0, 0, tocolor(r, g, b, tmp == "sound1" and 255 or 220))
			else
				dxDrawImage(x + 2 * w + 4 + 1, y + 4 + 1, is - 8, is - 8, ":sGui/" .. icons.waveform2 .. faTicks[icons.waveform2], 0, 0, 0, tocolor(0, 0, 0, 60))
				dxDrawImage(x + 2 * w + 4, y + 4, is - 8, is - 8, ":sGui/" .. icons.waveform2 .. faTicks[icons.waveform2], 0, 0, 0, tocolor(255, 255, 255, tmp == "sound1" and 255 or 150))
			end
			if currentSiren[veh] == 2 then
				local pulse = now % 1000 / 500
				if 1 < pulse then
					pulse = 2 - pulse
				end
				pulse = getEasingValue(pulse, "InOutQuad")
				local r = red[1] + (blue[1] - red[1]) * pulse
				local g = red[2] + (blue[2] - red[2]) * pulse
				local b = red[3] + (blue[3] - red[3]) * pulse
				dxDrawImage(x + 3 * w + 4 + 1, y + 4 + 1, is - 8, is - 8, ":sGui/" .. icons.waveform .. faTicks[icons.waveform], 0, 0, 0, tocolor(0, 0, 0, 60))
				dxDrawImage(x + 3 * w + 4, y + 4, is - 8, is - 8, ":sGui/" .. icons.waveform .. faTicks[icons.waveform], 0, 0, 0, tocolor(r, g, b, tmp == "sound2" and 255 or 220))
			else
				dxDrawImage(x + 3 * w + 4 + 1, y + 4 + 1, is - 8, is - 8, ":sGui/" .. icons.waveform2 .. faTicks[icons.waveform2], 0, 0, 0, tocolor(0, 0, 0, 60))
				dxDrawImage(x + 3 * w + 4, y + 4, is - 8, is - 8, ":sGui/" .. icons.waveform2 .. faTicks[icons.waveform2], 0, 0, 0, tocolor(255, 255, 255, tmp == "sound2" and 255 or 150))
			end
			if sirenHorn[veh] then
				dxDrawImage(x + 4 * w + 4 + 1, y + 4 + 1, is - 8, is - 8, ":sGui/" .. icons.bullhorn2 .. faTicks[icons.bullhorn2], 0, 0, 0, tocolor(0, 0, 0, 60))
				dxDrawImage(x + 4 * w + 4, y + 4, is - 8, is - 8, ":sGui/" .. icons.bullhorn2 .. faTicks[icons.bullhorn2], 0, 0, 0, tocolor(blue[1], blue[2], blue[3], tmp == "horn" and 255 or 220))
			else
				dxDrawImage(x + 4 * w + 4 + 1, y + 4 + 1, is - 8, is - 8, ":sGui/" .. icons.bullhorn2 .. faTicks[icons.bullhorn2], 0, 0, 0, tocolor(0, 0, 0, 60))
				dxDrawImage(x + 4 * w + 4, y + 4, is - 8, is - 8, ":sGui/" .. icons.bullhorn2 .. faTicks[icons.bullhorn2], 0, 0, 0, tocolor(255, 255, 255, tmp == "horn" and 255 or 150))
			end
			if sosMode then
				if squads[veh] and squads[veh][4] then
					dxDrawImage(x + 5 * w + 4 + 1, y + 4 + 1, is - 8, is - 8, ":sGui/" .. icons["walkie-talkie"] .. faTicks[icons["walkie-talkie"]], 0, 0, 0, tocolor(0, 0, 0, 60))
					dxDrawImage(x + 5 * w + 4, y + 4, is - 8, is - 8, ":sGui/" .. icons["walkie-talkie"] .. faTicks[icons["walkie-talkie"]], 0, 0, 0, tocolor(red[1], red[2], red[3], tmp == "sos" and 255 or 220))
				else
					dxDrawImage(x + 5 * w + 4 + 1, y + 4 + 1, is - 8, is - 8, ":sGui/" .. icons["walkie-talkie2"] .. faTicks[icons["walkie-talkie2"]], 0, 0, 0, tocolor(0, 0, 0, 60))
					dxDrawImage(x + 5 * w + 4, y + 4, is - 8, is - 8, ":sGui/" .. icons["walkie-talkie2"] .. faTicks[icons["walkie-talkie2"]], 0, 0, 0, tocolor(255, 255, 255, tmp == "sos" and 255 or 150))
				end
			end
			if tmp ~= currentHover then
				currentHover = tmp
				exports.sGui:setCursorType(currentHover and "link" or "normal")
				if currentHover == "siren" then
					exports.sGui:showTooltip("Sziréna " .. ((getVehicleSirensOn(veh) or getElementData(veh, "vehicle.sirenstate")) and "kikapcsolása" or "bekapcsolása"))
				elseif currentHover == "sound0" then
					exports.sGui:showTooltip("Hang: ki")
				elseif currentHover == "sound1" then
					exports.sGui:showTooltip("Hang: normál")
				elseif currentHover == "sound2" then
					exports.sGui:showTooltip("Hang: gyors")
				elseif currentHover == "horn" then
					exports.sGui:showTooltip("Kürt")
				elseif currentHover == "sos" then
					exports.sGui:showTooltip("Erősítés " .. (squads[veh] and squads[veh][4] and "lemondása" or "hívása"))
				else
					exports.sGui:showTooltip(false)
				end
			end
		else
			sirenVehicle = false
			currentHover = false
			exports.sGui:setCursorType("normal")
			exports.sGui:showTooltip(false)
		end
	end
end
function sirenHandler(cmd)
	if sirenVehicle then
		if cmd == "sos" then
			triggerServerEvent("mdcSquadToggleBackup", localPlayer)
		elseif cmd == "horn" then
			if not sirenHorn[sirenVehicle] then
				triggerServerEvent("vehicleSirenHorn", localPlayer, getElementsByType("player", getRootElement(), true))
			end
		elseif cmd == "sound0" then
			if currentSiren[sirenVehicle] then
				setElementData(sirenVehicle, "sirenSound", nil)
			end
		elseif cmd == "sound1" then
			if currentSiren[sirenVehicle] ~= 1 then
				setElementData(sirenVehicle, "sirenSound", 1)
			end
		elseif cmd == "sound2" then
			if currentSiren[sirenVehicle] ~= 2 then
				setElementData(sirenVehicle, "sirenSound", 2)
			end
		elseif cmd == "siren" then
			triggerServerEvent("toggleVehicleSiren", localPlayer)
		end
	end
end
addCommandHandler("sirenpanel", function(cmd, id)
	id = tonumber(id)
	if not id or id < 1 or 6 < id then
		outputChatBox("[color=sightblue][SightMTA - Használat]: #ffffff/" .. cmd .. " [1-6]", 255, 255, 255, true)
		return
	end
	if id == 1 then
		sirenHandler("siren")
	elseif id == 2 then
		sirenHandler("sound0")
	elseif id == 3 then
		sirenHandler("sound1")
	elseif id == 4 then
		sirenHandler("sound2")
	elseif id == 5 then
		sirenHandler("horn")
	elseif id == 6 then
		sirenHandler("sos")
	end
end)
function clickSirenWidget(button, state)
	if state == "down" and not exports.sHud:getWidgetEditMode() then
		sirenHandler(currentHover)
	end
end
addEvent("hudWidgetState:siren", true)
addEventHandler("hudWidgetState:siren", getRootElement(), function(state)
	if sirenWidgetState ~= state then
		sirenWidgetState = state
		if sirenWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderSirenWidget)
			addEventHandler("onClientClick", getRootElement(), clickSirenWidget)
		else
			removeEventHandler("onClientRender", getRootElement(), renderSirenWidget)
			removeEventHandler("onClientClick", getRootElement(), clickSirenWidget)
			currentHover = false
			exports.sGui:setCursorType("normal")
			exports.sGui:showTooltip(false)
		end
	end
end)
addEvent("hudWidgetPosition:siren", true)
addEventHandler("hudWidgetPosition:siren", getRootElement(), function(pos, final)
	x, y = pos[1], pos[2]
end)
addEvent("hudWidgetSize:siren", true)
addEventHandler("hudWidgetSize:siren", getRootElement(), function(size, final)
	sx, sy = size[1], size[2]
end)
triggerEvent("requestWidgetDatas", localPlayer, "siren")
local vehicleObjects = {}
local objectIds = {}
function loadModelIds()
	objectIds.sSiren = exports.sModloader:getModelId("v4_siren")
end
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
	local civilState = getElementData(source, "civilSiren") or false
	if civilState and objectIds.sSiren and not vehicleObjects[source] then
		local x, y, z = getElementPosition(source)
		local model = getElementModel(source)
		vehicleObjects[source] = createObject(objectIds.sSiren, x, y, z)
		setElementInterior(vehicleObjects[source], getElementInterior(source))
		setElementDimension(vehicleObjects[source], getElementDimension(source))
		setElementCollisionsEnabled(vehicleObjects[source], false)
		attachElements(vehicleObjects[source], source, sirenPositions[model][1], sirenPositions[model][2], sirenPositions[model][3], sirenPositions[model][4], sirenPositions[model][5], 0)
	end
end)
addEventHandler("onClientVehicleStreamOut", getRootElement(), function()
	if vehicleObjects[source] then
		if isElement(vehicleObjects[source]) then
			destroyElement(vehicleObjects[source])
		end
		vehicleObjects[source] = nil
		vehicleObjects[source] = nil
	end
end)
addEventHandler("onClientElementDestroy", getRootElement(), function()
	if vehicleObjects[source] then
		if isElement(vehicleObjects[source]) then
			destroyElement(vehicleObjects[source])
		end
		vehicleObjects[source] = nil
		vehicleObjects[source] = nil
	end
end)
addEventHandler("onClientElementDimensionChange", getRootElement(), function(old, new)
	if vehicleObjects[source] then
		setElementDimension(vehicleObjects[source], new)
	end
end)
addEventHandler("onClientElementInteriorChange", getRootElement(), function(old, new)
	if vehicleObjects[source] then
		setElementInterior(vehicleObjects[source], new)
	end
end)
addEventHandler("onClientVehicleDataChange", getRootElement(), function(dataName, oldValue, newValue)
	if dataName == "civilSiren" then
		if oldValue then
			if vehicleObjects[source] then
				if isElement(vehicleObjects[source]) then
					destroyElement(vehicleObjects[source])
				end
				vehicleObjects[source] = nil
				vehicleObjects[source] = nil
			end
			local veh = getPedOccupiedVehicle(localPlayer)
			if veh and veh == source then
				local seat = getPedOccupiedVehicleSeat(localPlayer)
				if seat <= 1 then
					sirenVehicle = false
					sosMode = false
				end
			end
		elseif newValue and objectIds.sSiren then
			if vehicleObjects[source] then
				if isElement(vehicleObjects[source]) then
					destroyElement(vehicleObjects[source])
				end
				vehicleObjects[source] = nil
				vehicleObjects[source] = nil
			end
			local x, y, z = getElementPosition(source)
			local model = getElementModel(source)
			vehicleObjects[source] = createObject(objectIds.sSiren, x, y, z)
			setElementInterior(vehicleObjects[source], getElementInterior(source))
			setElementDimension(vehicleObjects[source], getElementDimension(source))
			setElementCollisionsEnabled(vehicleObjects[source], false)
			attachElements(vehicleObjects[source], source, sirenPositions[model][1], sirenPositions[model][2], sirenPositions[model][3], sirenPositions[model][4], sirenPositions[model][5], 0)
			local veh = getPedOccupiedVehicle(localPlayer)
			if veh and veh == source then
				local seat = getPedOccupiedVehicleSeat(localPlayer)
				if seat <= 1 then
					sirenVehicle = veh
					sosMode = exports.sGroups:getPlayerPermission("squad")
				end
			end
		end
	end
end)

local coronaSirens = {}

local coronaMarkers = {}

addEvent("gotCoronaSirens", true)
addEventHandler("gotCoronaSirens", root, function(sirens)
    coronaSirens = sirens
end)

addEvent("disableCoronaSirens", true)
addEventHandler("disableCoronaSirens", root, function(veh)
	for k, v in pairs(coronaSirens) do
		if v[1] == veh then
			coronaSirens[k] = nil
		end
	end
	for k, v in pairs(coronaMarkers) do
		if k == veh then
			for key, value in pairs(coronaMarkers[k]) do
				if value.marker and isElement(value.marker) then
					destroyElement(value.marker)
				end
				coronaMarkers[k] = nil
			end
		end
	end
end)

local flashInterval = 200
local fadeSpeed = 0.0025

function renderCoronaSirens()
    local now = getTickCount()
    local px, py, pz = getCameraMatrix()

    for k, v in pairs(coronaSirens) do
        local veh = v[1]
        if not isElement(veh) then
            if coronaMarkers[veh] and coronaMarkers[veh][k] and isElement(coronaMarkers[veh][k].marker) then
                destroyElement(coronaMarkers[veh][k].marker)
            end
            table.remove(coronaSirens, k)
        end

        if isElement(veh) and isElementStreamedIn(veh) then
            local vx, vy, vz = getElementPosition(veh)
            if getDistanceBetweenPoints3D(px, py, pz, vx, vy, vz) < 70 then

                coronaMarkers[veh] = coronaMarkers[veh] or {}
                coronaMarkers[veh][k] = coronaMarkers[veh][k] or {}

                local data = coronaMarkers[veh][k]

                if not data.lastTick then
                    data.lastTick = now
                    data.leftSideActive = true
                    data.size = 0.12
                end

                if now - data.lastTick >= flashInterval then
                    data.lastTick = now
                    data.leftSideActive = not data.leftSideActive
                    data.size = 0.12
                end

                local timeSinceLastFlash = now - data.lastTick
                local progress = timeSinceLastFlash / flashInterval
                data.size = 0.12 - (progress * 0.15)

                local isLeft = v[2] < 0
                local thisSideActive = (isLeft and data.leftSideActive) or (not isLeft and not data.leftSideActive)

                if thisSideActive then
                    if not isElement(data.marker) then
                        data.marker = createMarker(v[2], v[3], v[4], "corona", data.size, v[5], v[6], v[7])
                        attachElements(data.marker, veh, v[2], v[3], v[4])
                        setCoronaReflectionEnabled(data.marker, true)
                    end

                    setElementInterior(data.marker, getElementInterior(veh))
                    setElementDimension(data.marker, getElementDimension(veh))
                    setMarkerSize(data.marker, data.size)
                    setMarkerColor(data.marker, v[5], v[6], v[7])

                else
                    -- Ha inaktív oldal, és létezik marker => töröljük
                    if isElement(data.marker) then
                        destroyElement(data.marker)
                        data.marker = nil
                    end
                end
            end
        end
    end
end

setTimer(renderCoronaSirens, flashInterval / 4, 0)
