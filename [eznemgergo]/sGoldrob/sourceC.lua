local sightexports = {
	sGroups = false,
	sGui = false,
	sModloader = false,
	sCirclegame = false
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
screenX, screenY = guiGetScreenSize()
circleIcon = false
circleBorderIcon = false
elevUpIcon = false
elevDownIcon = false
muteIcon = false
screwdriverIcon = false
fearIcon = false
fearArrowIcon = false
keyInputIcon = false
wheelIcon = false
toolboxIcon = false
lockIcon = false
unLockIcon = false
signalIcon = false
noSignalIcon = false
doorIcon = false
badgeIcon = false
fearFaceIcon = false
angerIcon = false
fearFace2Icon = false
anger2Icon = false
trashIcon = false
lcdFont = false
lcdFontScale = false
timerFont = false
timerFontScale = false
sightgreen = false
sightgrey1 = false
sightred = false
sightblue = false
sightorange = false
sightyellow = false
local garageAlarm = false
local garageAlarmBlip = false
local garageAlarmBlipTimer = false
local alarmBlip = false
local alarmBlipTimer = false
local roofDoorBlip = false
local backDoorBlip = false
function refreshInPolice()
	local tmp = sightexports.sGroups:isPlayerInLawEnforcement()
	if inPolice ~= tmp then
		inPolice = tmp
		refreshTrackerBlips()
		if inPolice then
			if garageAlarm then
				if not isElement(garageAlarmBlip) then
					garageAlarmBlip = createBlip(securicarGarageKeypadPos[1], securicarGarageKeypadPos[2], securicarGarageKeypadPos[3], 13, 2, sightblue[1], sightblue[2], sightblue[3])
					setElementData(garageAlarmBlip, "tooltipText", "Pénzszállító garázs riasztó")
				end
				if not isTimer(garageAlarmBlipTimer) then
					garageAlarmBlipTimer = setTimer(garageAlarmBlipColor, 500, 1, true)
				end
			end
			if alarmState then
				if not isElement(alarmBlip) then
					alarmBlip = createBlip(alarmPos[1], alarmPos[2], alarmPos[3], 14, 2, sightblue[1], sightblue[2], sightblue[3])
					setElementData(alarmBlip, "tooltipText", "Sight City Bank riasztó")
				end
				if not isTimer(alarmBlipTimer) then
					alarmBlipTimer = setTimer(alarmBlipColor, 500, 1, true)
				end
			end
			if roofDoorOpen and not isElement(roofDoorBlip) then
				roofDoorBlip = createBlip(roofDoorLPos[1], roofDoorLPos[2], roofDoorLPos[3], 15, 2, sightorange[1], sightorange[2], sightorange[3])
				setElementData(roofDoorBlip, "tooltipText", "Sight City Bank tető: ajtó nyitva")
			end
			if backDoorOpen and not isElement(backDoorBlip) then
				backDoorBlip = createBlip(backDoorIconPos[1], backDoorIconPos[2], backDoorIconPos[3], 15, 2, sightorange[1], sightorange[2], sightorange[3])
				setElementData(backDoorBlip, "tooltipText", "Sight City Bank hátsó ajtó nyitva")
			end
		else
			if isElement(roofDoorBlip) then
				destroyElement(roofDoorBlip)
			end
			roofDoorBlip = false
			if isElement(backDoorBlip) then
				destroyElement(backDoorBlip)
			end
			backDoorBlip = false
			if isElement(garageAlarmBlip) then
				destroyElement(garageAlarmBlip)
			end
			garageAlarmBlip = false
			if isTimer(garageAlarmBlipTimer) then
				killTimer(garageAlarmBlipTimer)
			end
			garageAlarmBlipTimer = false
			if isElement(alarmBlip) then
				destroyElement(alarmBlip)
			end
			alarmBlip = false
			if isTimer(alarmBlipTimer) then
				killTimer(alarmBlipTimer)
			end
			alarmBlipTimer = false
		end
	end
end
addEvent("gotPlayerGroupMembership", true)
addEventHandler("gotPlayerGroupMembership", getRootElement(), refreshInPolice)
function guiRefreshColors()
	circleIcon = sightexports.sGui:getFaIconFilename("circle", 32)
	circleBorderIcon = sightexports.sGui:getFaIconFilename("circle", 64, "light")
	elevUpIcon = sightexports.sGui:getFaIconFilename("sort-circle-up", 32)
	elevDownIcon = sightexports.sGui:getFaIconFilename("sort-circle-down", 32)
	sightgreen = sightexports.sGui:getColorCode("sightgreen")
	sightgrey1 = sightexports.sGui:getColorCode("sightgrey1")
	sightgrey2 = sightexports.sGui:getColorCode("sightgrey2")
	sightred = sightexports.sGui:getColorCode("sightred")
	sightredSecond = sightexports.sGui:getColorCode("sightred-second")
	sightblue = sightexports.sGui:getColorCode("sightblue")
	sightorange = sightexports.sGui:getColorCode("sightorange")
	sightyellow = sightexports.sGui:getColorCode("sightyellow")
	if isElement(roofDoorBlip) then
		setBlipColor(roofDoorBlip, sightorange[1], sightorange[2], sightorange[3], 255)
	end
	if isElement(backDoorBlip) then
		setBlipColor(backDoorBlip, sightorange[1], sightorange[2], sightorange[3], 255)
	end
	keyInputIcon = sightexports.sGui:getFaIconFilename("key", 32)
	wheelIcon = sightexports.sGui:getFaIconFilename("dharmachakra", 32, "light")
	screwdriverIcon = sightexports.sGui:getFaIconFilename("screwdriver", 32)
	fearIcon = sightexports.sGui:getFaIconFilename("exclamation", 64)
	fearArrowIcon = sightexports.sGui:getFaIconFilename("angle-right", 64)
	muteIcon = sightexports.sGui:getFaIconFilename("volume-mute", 32)
	toolboxIcon = sightexports.sGui:getFaIconFilename("toolbox", 32)
	lockIcon = sightexports.sGui:getFaIconFilename("lock", 32)
	unLockIcon = sightexports.sGui:getFaIconFilename("lock-open", 32)
	signalIcon = sightexports.sGui:getFaIconFilename("signal", 32)
	noSignalIcon = sightexports.sGui:getFaIconFilename("signal-slash", 32)
	doorIcon = sightexports.sGui:getFaIconFilename("door-open", 32)
	badgeIcon = sightexports.sGui:getFaIconFilename("id-badge", 32, "regular")
	fearFaceIcon = sightexports.sGui:getFaIconFilename("frown-open", 32, "regular")
	fearFace2Icon = sightexports.sGui:getFaIconFilename("frown-open", 32, "solid")
	angerIcon = sightexports.sGui:getFaIconFilename("angry", 32, "regular")
	anger2Icon = sightexports.sGui:getFaIconFilename("angry", 32, "solid")
	trashIcon = sightexports.sGui:getFaIconFilename("trash-alt", 32)
	timerFont = sightexports.sGui:getFont("45/BebasNeueRegular.otf")
	timerFontScale = sightexports.sGui:getFontScale("45/BebasNeueRegular.otf")
	lcdFont = sightexports.sGui:getFont("11/W95FA.otf")
	lcdFontScale = sightexports.sGui:getFontScale("11/W95FA.otf")
end
local securicarKeypadCol = createColSphere(-1771.17, 978.8232, 24, 6)
local securicarKeypadHandled = false
local securicarKeypadHover = false
local securicarGarageOpen = false
local securicarKeypadBroken = false
local insideKeypad = false
insideKeypadBroken = false
function isPlayerFreeToDo()
	return not wheelMinigame and not npcMinigame and not keypadHacking and not keypadCode and not isPedInVehicle(localPlayer)
end
goldrobMute = false
goldrobLock = false
goldrobDestroy = false
local goldrobRepairGarage = false
function processPermission()
	goldrobMute = sightexports.sGroups:getPlayerPermission("goldrobMute")
	goldrobLock = sightexports.sGroups:getPlayerPermission("goldrobLock")
	goldrobDestroy = sightexports.sGroups:getPlayerPermission("goldrobDestroy")
	goldrobRepairGarage = sightexports.sGroups:getPlayerPermission("goldrobRepairGarage")
end
function renderSecuricarKeypad()
	if not isElementWithinColShape(localPlayer, securicarKeypadCol) then
		removeEventHandler("onClientRender", getRootElement(), renderSecuricarKeypad)
		removeEventHandler("onClientClick", getRootElement(), clickSecuricarKeypad)
		securicarKeypadHandled = false
		if securicarKeypadHover then
			sightexports.sGui:setCursorType("normal")
			sightexports.sGui:showTooltip()
		end
		return
	end
	local tmp = false
	if isPlayerFreeToDo() then
		local x, y, z = getElementPosition(localPlayer)
		local d = getDistanceBetweenPoints3D(x, y, z, securicarGarageKeypadPos[1], securicarGarageKeypadPos[2], securicarGarageKeypadPos[3])
		local a = 255 * math.min(1, 1 - (d - 1.5) / 2)
		if 0 < a then
			local cx, cy = getCursorPosition()
			if cx then
				cx = cx * screenX
				cy = cy * screenY
			end
			local x, y = getScreenFromWorldPosition(securicarGarageKeypadPos[1], securicarGarageKeypadPos[2], securicarGarageKeypadPos[3], 64)
			if x then
				if not securicarGarageOpen and (securicarKeypadBroken or garageAlarm) and goldrobRepairGarage then
					x = x - 16 - 4
				end
				if (securicarGarageOpen or securicarKeypadBroken or garageAlarm) and goldrobRepairGarage then
					dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
					if 255 <= a and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
						tmp = "repair"
						dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. toolboxIcon .. faTicks[toolboxIcon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
					else
						dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. toolboxIcon .. faTicks[toolboxIcon], 0, 0, 0, tocolor(255, 255, 255, a))
					end
					x = x + 32 + 8
				end
				if not securicarGarageOpen then
					dxDrawRectangle(x - 16, y - 16, 32, 32, tocolor(sightgrey1[1], sightgrey1[2], sightgrey1[3], a))
					if 255 <= a and cx and cx >= x - 16 and cx <= x + 16 and cy >= y - 16 and cy <= y + 16 then
						tmp = "hack"
						dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. screwdriverIcon .. faTicks[screwdriverIcon], 0, 0, 0, tocolor(sightgreen[1], sightgreen[2], sightgreen[3], a))
					else
						dxDrawImage(x - 12, y - 12, 24, 24, ":sGui/" .. screwdriverIcon .. faTicks[screwdriverIcon], 0, 0, 0, tocolor(255, 255, 255, a))
					end
				end
			end
		end
	end
	if tmp ~= securicarKeypadHover then
		securicarKeypadHover = tmp
		sightexports.sGui:setCursorType(tmp and "link" or "normal")
		if tmp == "hack" then
			sightexports.sGui:showTooltip("Zár feltörése")
		elseif tmp == "repair" then
			sightexports.sGui:showTooltip("Zár javítása")
		else
			sightexports.sGui:showTooltip()
		end
	end
end
lastClick = 0
function clickSecuricarKeypad(btn, state)
	local now = getTickCount()
	if state == "down" and now - lastClick > 500 then
		if securicarKeypadHover == "hack" then
			triggerServerEvent("tryToHackGoldrobGarage", localPlayer)
			lastClick = now
		elseif securicarKeypadHover == "repair" then
			triggerServerEvent("repairGoldrobGarage", localPlayer)
			lastClick = now
		end
	end
end
addEventHandler("onClientColShapeHit", securicarKeypadCol, function(he, md)
	if he == localPlayer and md and not securicarKeypadHandled then
		addEventHandler("onClientRender", getRootElement(), renderSecuricarKeypad)
		addEventHandler("onClientClick", getRootElement(), clickSecuricarKeypad)
		securicarKeypadHandled = true
	end
end)
securicarGarageKeypad = false
laserKeypad = false
models = false
vaultObjects = {}
elevatorObject = false
elevatorDoors = {}
vaultBigDoor = false
vaultWheel = false
vaultPins = {}
vaultBars = false
vaultBarPieces = {}
bankOpen = true
addEvent("gotGoldrobBankOpen", true)
addEventHandler("gotGoldrobBankOpen", getRootElement(), function(open)
	bankOpen = open
end)
alarmState = false
alarmMuted = false
local alarmSound = false
function alarmBlipColor(state)
	local c = state and sightred or sightblue
	if isElement(alarmBlip) then
		setBlipColor(alarmBlip, c[1], c[2], c[3], 255)
		if isTimer(alarmBlipTimer) then
			killTimer(alarmBlipTimer)
		end
		alarmBlipTimer = setTimer(alarmBlipColor, 500, 1, not state)
	end
end
backDoorOpen = false
roofDoorOpen = false
addEvent("gotGoldrobBackDoorOpen", true)
addEventHandler("gotGoldrobBackDoorOpen", getRootElement(), function(open)
	backDoorOpen = open
	processBackDoor()
	if inBankHover == "backdoor" then
		inBankHover = false
	end
	if inBankCol then
		playSound3D(":v4_interiors/files/lockunlock.mp3", backDoorIconPos[1], backDoorIconPos[2], backDoorIconPos[3])
	end
end)
addEvent("gotGoldrobRoofDoorOpen", true)
addEventHandler("gotGoldrobRoofDoorOpen", getRootElement(), function(open)
	roofDoorOpen = open
	processRoofDoors()
	if inBankHover == "roofdoor" then
		inBankHover = false
	end
	if inBankCol then
		playSound3D(":v4_interiors/files/lockunlock.mp3", roofDoorIconPos[1], roofDoorIconPos[2], roofDoorIconPos[3])
	end
end)
addEvent("gotGoldrobAlarmState", true)
addEventHandler("gotGoldrobAlarmState", getRootElement(), function(state, muted)
	if alarmState ~= state and inPolice then
		if state then
			outputChatBox("[color=sightred][SightMTA - Security]: #ffffffFigyelem minden egységnek! A [color=sightred]Sight City Bank#ffffff riasztást jelzett.", 255, 255, 255, true)
			playSound(":sGroups/files/backup.mp3")
			if not isElement(alarmBlip) then
				alarmBlip = createBlip(alarmPos[1], alarmPos[2], alarmPos[3], 14, 2, sightblue[1], sightblue[2], sightblue[3])
				setElementData(alarmBlip, "tooltipText", "Sight City Bank riasztó")
			end
			if not isTimer(alarmBlipTimer) then
				alarmBlipTimer = setTimer(alarmBlipColor, 500, 1, true)
			end
		else
			if isElement(alarmBlip) then
				destroyElement(alarmBlip)
			end
			alarmBlip = false
			if isTimer(alarmBlipTimer) then
				killTimer(alarmBlipTimer)
			end
			alarmBlipTimer = false
		end
	end
	alarmState = state
	alarmMuted = muted
	refreshGlasses()
	if state and not muted then
		if not isElement(alarmSound) then
			alarmSound = playSound3D("files/alarm.mp3", alarmPos[1], alarmPos[2], alarmPos[3], true)
			setSoundMaxDistance(alarmSound, 400)
		end
	else
		if isElement(alarmSound) then
			destroyElement(alarmSound)
		end
		alarmSound = false
	end
end)
frontDoorL = false
frontDoorR = false
topDoorL = false
topDoorR = false
local backDoor = false
function processBackDoor()
	if not models then return end

	if not isElement(backDoor) then
		backDoor = createObject(
			models.v4_goldbank_door3,
			backDoorPos[1], backDoorPos[2], backDoorPos[3],
			backDoorPos[4], backDoorPos[5], backDoorPos[6]
		)
	end

	if backDoorOpen then
		if isElement(backDoor) then
			destroyElement(backDoor)
		end
		backDoor = createObject(
			models.v4_goldbank_door3_dynamic,
			backDoorPos[1], backDoorPos[2], backDoorPos[3],
			backDoorPos[4], backDoorPos[5], backDoorPos[6]
		)

		if inPolice then
			if not isElement(backDoorBlip) then
				backDoorBlip = createBlip(
					backDoorIconPos[1], backDoorIconPos[2], backDoorIconPos[3],
					15, 2, sightorange[1], sightorange[2], sightorange[3]
				)
				setElementData(backDoorBlip, "tooltipText", "Sight City Bank hátsó ajtó nyitva")
			end
		else
			if isElement(backDoorBlip) then destroyElement(backDoorBlip) end
			backDoorBlip = false
		end
	else
		-- Alap (zárt) modellre váltás
		if isElement(backDoor) then
			destroyElement(backDoor)
		end
		backDoor = createObject(
			models.v4_goldbank_door3,
			backDoorPos[1], backDoorPos[2], backDoorPos[3],
			backDoorPos[4], backDoorPos[5], backDoorPos[6]
		)

		if isElement(backDoorBlip) then destroyElement(backDoorBlip) end
		backDoorBlip = false
	end
end

function processRoofDoors()
	if not models then return end

	if not isElement(roofDoorL) then
		roofDoorL = createObject(
			models.v4_goldbank_roof_door,
			roofDoorLPos[1], roofDoorLPos[2], roofDoorLPos[3],
			roofDoorLPos[4], roofDoorLPos[5], roofDoorLPos[6]
		)
	end
	if not isElement(roofDoorR) then
		roofDoorR = createObject(
			models.v4_goldbank_roof_door2,
			roofDoorRPos[1], roofDoorRPos[2], roofDoorRPos[3],
			roofDoorRPos[4], roofDoorRPos[5], roofDoorRPos[6]
		)
	end

	if roofDoorOpen then
		if isElement(roofDoorL) then destroyElement(roofDoorL) end
		roofDoorL = createObject(
			models.v4_goldbank_roof_door_dynamic,
			roofDoorLPos[1], roofDoorLPos[2], roofDoorLPos[3],
			roofDoorLPos[4], roofDoorLPos[5], roofDoorLPos[6]
		)
		if isElement(roofDoorR) then destroyElement(roofDoorR) end
		roofDoorR = createObject(
			models.v4_goldbank_roof_door2_dynamic,
			roofDoorRPos[1], roofDoorRPos[2], roofDoorRPos[3],
			roofDoorRPos[4], roofDoorRPos[5], roofDoorRPos[6]
		)

		if inPolice then
			if not isElement(roofDoorBlip) then
				roofDoorBlip = createBlip(
					roofDoorIconPos[1], roofDoorIconPos[2], roofDoorIconPos[3],
					15, 2, sightorange[1], sightorange[2], sightorange[3]
				)
				setElementData(roofDoorBlip, "tooltipText", "Sight City Bank tető: ajtó nyitva")
			end
		else
			if isElement(roofDoorBlip) then destroyElement(roofDoorBlip) end
			roofDoorBlip = false
		end
	else
		if isElement(roofDoorL) then destroyElement(roofDoorL) end
		roofDoorL = createObject(
			models.v4_goldbank_roof_door,
			roofDoorLPos[1], roofDoorLPos[2], roofDoorLPos[3],
			roofDoorLPos[4], roofDoorLPos[5], roofDoorLPos[6]
		)
		if isElement(roofDoorR) then destroyElement(roofDoorR) end
		roofDoorR = createObject(
			models.v4_goldbank_roof_door2,
			roofDoorRPos[1], roofDoorRPos[2], roofDoorRPos[3],
			roofDoorRPos[4], roofDoorRPos[5], roofDoorRPos[6]
		)

		if isElement(roofDoorBlip) then destroyElement(roofDoorBlip) end
		roofDoorBlip = false
	end
end

function processInsideDoors()
	if inBankCol then
		playSound3D("files/doorclick.mp3", insideKeypadPos[1], insideKeypadPos[2], insideKeypadPos[3])
	end
	if keypadCode == "door" then
		closeKeypad()
	end

	if not models then return end

	if not isElement(insideDoorL) then
		insideDoorL = createObject(
			models.v4_goldbank_door5,
			insideDoorLPos[1], insideDoorLPos[2], insideDoorLPos[3],
			insideDoorLPos[4], insideDoorLPos[5], insideDoorLPos[6]
		)
	end
	if not isElement(insideDoorR) then
		insideDoorR = createObject(
			models.v4_goldbank_door5,
			insideDoorRPos[1], insideDoorRPos[2], insideDoorRPos[3],
			insideDoorRPos[4], insideDoorRPos[5], insideDoorRPos[6]
		)
	end

	if insideDoorsOpen then
		if isElement(insideDoorL) then destroyElement(insideDoorL) end
		insideDoorL = createObject(
			models.v4_goldbank_door5_dynamic,
			insideDoorLPos[1], insideDoorLPos[2], insideDoorLPos[3],
			insideDoorLPos[4], insideDoorLPos[5], insideDoorLPos[6]
		)
		if isElement(insideDoorR) then destroyElement(insideDoorR) end
		insideDoorR = createObject(
			models.v4_goldbank_door5_dynamic,
			insideDoorRPos[1], insideDoorRPos[2], insideDoorRPos[3],
			insideDoorRPos[4], insideDoorRPos[5], insideDoorRPos[6]
		)

		if not isElement(insideDoorSound) then
			insideDoorSound = playSound3D("files/keybuzz.mp3",
				insideKeypadPos[1], insideKeypadPos[2], insideKeypadPos[3], true)
			setSoundMaxDistance(insideDoorSound, 12)
			setSoundVolume(insideDoorSound, 0.25)
		end
	else
		if isElement(insideDoorL) then destroyElement(insideDoorL) end
		insideDoorL = createObject(
			models.v4_goldbank_door5,
			insideDoorLPos[1], insideDoorLPos[2], insideDoorLPos[3],
			insideDoorLPos[4], insideDoorLPos[5], insideDoorLPos[6]
		)
		if isElement(insideDoorR) then destroyElement(insideDoorR) end
		insideDoorR = createObject(
			models.v4_goldbank_door5,
			insideDoorRPos[1], insideDoorRPos[2], insideDoorRPos[3],
			insideDoorRPos[4], insideDoorRPos[5], insideDoorRPos[6]
		)

		if isElement(insideDoorSound) then destroyElement(insideDoorSound) end
		insideDoorSound = false
	end
end
function goldrobGotInsideDoor(state)
	insideDoorsOpen = state
	processInsideDoors()
end
addEvent("goldrobGotInsideDoor", true)
addEventHandler("goldrobGotInsideDoor", getRootElement(), goldrobGotInsideDoor)
function modelsLoaded()
	models = {
		v4_goldbank_door3 = sightexports.sModloader:getModelId("v4_goldbank_door3"),
		v4_goldbank_door3_dynamic = sightexports.sModloader:getModelId("v4_goldbank_door3_dynamic"),
		v4_goldbank_door5 = sightexports.sModloader:getModelId("v4_goldbank_door5"),
		v4_goldbank_door5_dynamic = sightexports.sModloader:getModelId("v4_goldbank_door5_dynamic"),
		v4_goldbank_roof_door_dynamic = sightexports.sModloader:getModelId("v4_goldbank_roof_door_dynamic"),
		v4_goldbank_roof_door2_dynamic = sightexports.sModloader:getModelId("v4_goldbank_roof_door2_dynamic"),
		v4_goldbank_roof_door = sightexports.sModloader:getModelId("v4_goldbank_roof_door"),
		v4_goldbank_roof_door2 = sightexports.sModloader:getModelId("v4_goldbank_roof_door2"),
		v4_goldbox1 = sightexports.sModloader:getModelId("v4_goldbox1"),
		v4_goldbox2 = sightexports.sModloader:getModelId("v4_goldbox2"),
		v4_goldbar = sightexports.sModloader:getModelId("v4_goldbar"),
		v4_goldbank_vault_safes = sightexports.sModloader:getModelId("v4_goldbank_vault_safes"),
		v4_goldbank_elevator = sightexports.sModloader:getModelId("v4_goldbank_elevator"),
		v4_goldbank_elevator_door = sightexports.sModloader:getModelId("v4_goldbank_elevator_door")
	}
	if isElement(insideDoorL) then
		destroyElement(insideDoorL)
	end
	insideDoorL = createObject(models.v4_goldbank_door5, insideDoorLPos[1], insideDoorLPos[2], insideDoorLPos[3], insideDoorLPos[4], insideDoorLPos[5], insideDoorLPos[6])
	if isElement(insideDoorR) then
		destroyElement(insideDoorR)
	end
	insideDoorR = createObject(models.v4_goldbank_door5, insideDoorRPos[1], insideDoorRPos[2], insideDoorRPos[3], insideDoorRPos[4], insideDoorRPos[5], insideDoorRPos[6])
	processInsideDoors()
	if isElement(backDoor) then
		destroyElement(backDoor)
	end
	backDoor = createObject(models.v4_goldbank_door3, backDoorPos[1], backDoorPos[2], backDoorPos[3], backDoorPos[4], backDoorPos[5], backDoorPos[6])
	processBackDoor()
	if isElement(roofDoorL) then
		destroyElement(roofDoorL)
	end
	roofDoorL = createObject(models.v4_goldbank_roof_door, roofDoorLPos[1], roofDoorLPos[2], roofDoorLPos[3], roofDoorLPos[4], roofDoorLPos[5], roofDoorLPos[6])
	if isElement(roofDoorR) then
		destroyElement(roofDoorR)
	end
	roofDoorR = createObject(models.v4_goldbank_roof_door2, roofDoorRPos[1], roofDoorRPos[2], roofDoorRPos[3], roofDoorRPos[4], roofDoorRPos[5], roofDoorRPos[6])
	processRoofDoors()
	if isElement(topDoorL) then
		destroyElement(topDoorL)
	end
	topDoorL = createObject(sightexports.sModloader:getModelId("v4_goldbank_door2"), topDoorLPos[1], topDoorLPos[2], topDoorLPos[3], 0, 0, topDoorLPos[4])
	if isElement(topDoorR) then
		destroyElement(topDoorR)
	end
	topDoorR = createObject(sightexports.sModloader:getModelId("v4_goldbank_door2"), topDoorRPos[1], topDoorRPos[2], topDoorRPos[3], 0, 0, topDoorRPos[4])
	refreshTopDoors()
	if isElement(frontDoorL) then
		destroyElement(frontDoorL)
	end
	frontDoorL = createObject(sightexports.sModloader:getModelId("v4_goldbank_door4"), frontDoorLPos[1], frontDoorLPos[2], frontDoorLPos[3])
	if isElement(frontDoorR) then
		destroyElement(frontDoorR)
	end
	frontDoorR = createObject(sightexports.sModloader:getModelId("v4_goldbank_door4"), frontDoorRPos[1], frontDoorRPos[2], frontDoorRPos[3])
	refreshFrontDoors()
	if isElement(vaultBigDoor) then
		destroyElement(vaultBigDoor)
	end
	vaultBigDoor = createObject(sightexports.sModloader:getModelId("v4_goldbank_vault_door"), vaultBigDoorPos[1], vaultBigDoorPos[2], vaultBigDoorPos[3])
	if isElement(vaultWheel) then
		destroyElement(vaultWheel)
	end
	vaultWheel = createObject(sightexports.sModloader:getModelId("v4_goldbank_vault_door_wheel"), vaultBigDoorPos[1], vaultBigDoorPos[2], vaultBigDoorPos[3])
	setElementCollisionsEnabled(vaultWheel, false)
	for i = 1, 8 do
		if isElement(vaultPins[i]) then
			destroyElement(vaultPins[i])
		end
		vaultPins[i] = createObject(sightexports.sModloader:getModelId("v4_goldbank_vault_door_lock"), vaultBigDoorPos[1], vaultBigDoorPos[2], vaultBigDoorPos[3])
		setElementCollisionsEnabled(vaultPins[i], false)
	end
	refreshBigDoorPos()
	if isElement(vaultBars) then
		destroyElement(vaultBars)
	end
	vaultBars = createObject(sightexports.sModloader:getModelId("v4_goldbank_vault_bars"), vaultBarsPos[1], vaultBarsPos[2], vaultBarsPos[3])
	refershBars()
	if isElement(insideKeypad) then
		destroyElement(insideKeypad)
	end
	insideKeypad = createObject(sightexports.sModloader:getModelId("v4_goldbank_codelock" .. (insideKeypadBroken and "broken" or "")), insideKeypadPos[1], insideKeypadPos[2], insideKeypadPos[3], insideKeypadPos[4], insideKeypadPos[5], insideKeypadPos[6])
	if isElement(securicarGarageKeypad) then
		destroyElement(securicarGarageKeypad)
	end
	securicarGarageKeypad = createObject(sightexports.sModloader:getModelId("v4_goldbank_codelock" .. (securicarKeypadBroken and "broken" or "")), securicarGarageKeypadPos[1], securicarGarageKeypadPos[2], securicarGarageKeypadPos[3], securicarGarageKeypadPos[4], securicarGarageKeypadPos[5], securicarGarageKeypadPos[6])
	if isElement(laserKeypad) then
		destroyElement(laserKeypad)
	end
	laserKeypad = createObject(sightexports.sModloader:getModelId("v4_goldbank_codelock"), laserKeypadPos[1], laserKeypadPos[2], laserKeypadPos[3], laserKeypadPos[4], laserKeypadPos[5], laserKeypadPos[6])
	for i = 1, #vaultObjectPoses do
		if isElement(vaultObjects[i]) then
			destroyElement(vaultObjects[i])
		end
		vaultObjects[i] = createObject(models.v4_goldbank_vault_safes, vaultObjectPoses[i][1], vaultObjectPoses[i][2], vaultObjectPoses[i][3], 0, 0, vaultObjectPoses[i][4])
	end
	if isElement(elevatorObject) then
		destroyElement(elevatorObject)
	end
	elevatorObject = createObject(models.v4_goldbank_elevator, elevatorObjectPos[1], elevatorObjectPos[2], elevatorUpperZ, 0, 0, elevatorObjectPos[3])
	setElementDoubleSided(elevatorObject, true)
	for i = 1, #elevatorDoors do
		if isElement(elevatorDoors[i]) then
			destroyElement(elevatorDoors[i])
		end
		elevatorDoors[i] = nil
	end
	elevatorDoors[1] = createObject(models.v4_goldbank_elevator_door, elevatorDoorsPos[1], elevatorDoorsPos[2], elevatorUpperZ - 0.25, 0, 0, elevatorDoorsPos[3])
	elevatorDoors[2] = createObject(models.v4_goldbank_elevator_door, elevatorDoorsPos[1], elevatorDoorsPos[2], elevatorUpperZ - 0.25, 0, 0, elevatorDoorsPos[3])
	elevatorDoors[3] = createObject(models.v4_goldbank_elevator_door, elevatorDoorsPos[1], elevatorDoorsPos[2], elevatorLowerZ - 0.25, 0, 0, elevatorDoorsPos[3])
	elevatorDoors[4] = createObject(models.v4_goldbank_elevator_door, elevatorDoorsPos[1], elevatorDoorsPos[2], elevatorLowerZ - 0.25, 0, 0, elevatorDoorsPos[3])
	elevatorDoors[5] = createObject(models.v4_goldbank_elevator_door, elevatorDoorsPos[1], elevatorDoorsPos[2], elevatorUpperZ - 0.25, 0, 0, elevatorDoorsPos[3] + 180)
	elevatorDoors[6] = createObject(models.v4_goldbank_elevator_door, elevatorDoorsPos[1], elevatorDoorsPos[2], elevatorUpperZ - 0.25, 0, 0, elevatorDoorsPos[3] + 180)
	for i = 1, #elevatorDoors do
		setElementDoubleSided(elevatorDoors[i], true)
	end
	setObjectScale(elevatorDoors[1], 1.25, 1, 1)
	setObjectScale(elevatorDoors[2], 0.75, 1, 1)
	setObjectScale(elevatorDoors[3], 1.25, 1, 1)
	setObjectScale(elevatorDoors[4], 0.75, 1, 1)
	setObjectScale(elevatorDoors[5], 1.25, 1, 1)
	setObjectScale(elevatorDoors[6], 0.75, 1, 1)
	triggerServerEvent("requestGoldrobDatasAfterModel", localPlayer)
	refreshGlasses()
end
addEvent("modloaderLoaded", false)
addEventHandler("modloaderLoaded", getRootElement(), modelsLoaded)
elevatorTop = true
elevatorMoving = false
elevatorSound = false
elevatorMusic = false
addEvent("gotGoldrobElevatorState", true)
addEventHandler("gotGoldrobElevatorState", getRootElement(), function(top, moving, to)
	elevatorTop = top
	elevDoorsMoving = true
	if isElement(elevatorSound) then
		destroyElement(elevatorSound)
	end
	elevatorSound = false
	if isElement(elevatorMusic) then
		destroyElement(elevatorMusic)
	end
	
	if to then
		setTimer(function()
			moveObject(elevatorObject, 11000, elevatorObjectPos[1], elevatorObjectPos[2], to, 0, 0, elevatorObjectPos[3])
		end, 5000, 1)
	end
	elevatorMusic = false
	if inBankCol then
		if elevatorMoving and not moving then
			playSound3D("files/bell.mp3", elevatorDoorsPos[1], elevatorDoorsPos[2], (top and elevatorUpperZ or elevatorLowerZ) + 1.75)
			playSound3D("files/elevdoor.mp3", elevatorDoorsPos[1], elevatorDoorsPos[2], top and elevatorUpperZ or elevatorLowerZ)
		elseif not elevatorMoving and moving then
			playSound3D("files/elevdoor.mp3", elevatorDoorsPos[1], elevatorDoorsPos[2], top and elevatorLowerZ or elevatorUpperZ)
		end
		if moving then
			elevatorMusic = playSound("files/elevmusic.mp3")
			setSoundVolume(elevatorMusic, 0)
			elevatorSound = playSound3D("files/elev.mp3", elevatorDoorsPos[1], elevatorDoorsPos[2], (top and elevatorUpperZ or elevatorLowerZ) + 1.75)
			if elevatorObject then
				attachElements(elevatorSound, elevatorObject)
			end
		end
	end
	elevatorMoving = moving
end)
addEvent("gotGoldrobElevator", true)
addEventHandler("gotGoldrobElevator", getRootElement(), function(obj, top, moving)
	if elevatorObject then
		attachElements(elevatorObject, obj, 0, 0, 0, 0, 0, 0)
		elevatorTop = top
		elevatorMoving = moving
	end
end)
addEvent("gotGoldrobGarageKeypadState", true)
addEventHandler("gotGoldrobGarageKeypadState", getRootElement(), function(state)
	securicarKeypadBroken = state
	if securicarGarageKeypad then
		setElementModel(securicarGarageKeypad, sightexports.sModloader:getModelId("v4_goldbank_codelock" .. (securicarKeypadBroken and "broken" or "")))
	end
end)
addEvent("gotGoldrobInsideKeypadState", true)
addEventHandler("gotGoldrobInsideKeypadState", root, function(state)
	insideKeypadBroken = state
	if sightexports and sightexports.sModloader then
		local modelName = "v4_goldbank_codelock" .. (insideKeypadBroken and "broken" or "")
		local modelId = sightexports.sModloader:getModelId(modelName)

		if isElement(insideKeypad) then
			destroyElement(insideKeypad)
			insideKeypad = nil
		end

		if modelId then
			insideKeypad = createObject(
				modelId,
				insideKeypadPos[1], insideKeypadPos[2], insideKeypadPos[3],
				insideKeypadPos[4] or 0, insideKeypadPos[5] or 0, insideKeypadPos[6] or 0
			)
		end
	end
end)
addEvent("gotGoldrobGarageOpen", true)
addEventHandler("gotGoldrobGarageOpen", getRootElement(), function(state)
	securicarGarageOpen = state
end)
function garageAlarmBlipColor(state)
	local c = state and sightred or sightblue
	if isElement(garageAlarmBlip) then
		setBlipColor(garageAlarmBlip, c[1], c[2], c[3], 255)
		if isTimer(garageAlarmBlipTimer) then
			killTimer(garageAlarmBlipTimer)
		end
		garageAlarmBlipTimer = setTimer(garageAlarmBlipColor, 500, 1, not state)
	end
end
addEvent("goldorbInPoliceMessage", true)
addEventHandler("goldorbInPoliceMessage", getRootElement(), function(text, sound)
	if inPolice then
		outputChatBox("[color=sightred][SightMTA - Security]: #ffffff" .. text, 255, 255, 255, true)
		if sound then
			playSound(":sGroups/files/backup.mp3")
		end
	end
end)
addEvent("gotGoldrobGarageAlarm", true)
addEventHandler("gotGoldrobGarageAlarm", getRootElement(), function(state)
	if state then
		if not isElement(garageAlarm) then
			garageAlarm = playSound3D("files/garalarm.mp3", securicarGarageKeypadPos[1], securicarGarageKeypadPos[2], securicarGarageKeypadPos[3], true)
			setSoundMaxDistance(garageAlarm, 400)
		end
		if inPolice then
			playSound(":sGroups/files/backup.mp3")
			outputChatBox("[color=sightred][SightMTA - Security]: #ffffffFigyelem! Illetéktelen behatolás történt a [color=sightred]pénzszállító garázsba#ffffff!", 255, 255, 255, true)
			if not isElement(garageAlarmBlip) then
				garageAlarmBlip = createBlip(securicarGarageKeypadPos[1], securicarGarageKeypadPos[2], securicarGarageKeypadPos[3], 13, 2, sightblue[1], sightblue[2], sightblue[3])
				setElementData(garageAlarmBlip, "tooltipText", "Pénzszállító garázs riasztó")
			end
			if not isTimer(garageAlarmBlipTimer) then
				garageAlarmBlipTimer = setTimer(garageAlarmBlipColor, 500, 1, true)
			end
		end
	else
		if isElement(garageAlarm) then
			destroyElement(garageAlarm)
		end
		garageAlarm = false
		if isElement(garageAlarmBlip) then
			destroyElement(garageAlarmBlip)
		end
		garageAlarmBlip = false
		if isTimer(garageAlarmBlipTimer) then
			killTimer(garageAlarmBlipTimer)
		end
		garageAlarmBlipTimer = false
	end
end)
addEvent("gotPlayerGroupPermissions", true)
addEventHandler("gotPlayerGroupPermissions", getRootElement(), processPermission)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	triggerServerEvent("requestGoldrobDatas", localPlayer)
	if getElementData(localPlayer, "loggedIn") then
		modelsLoaded()
		processPermission()
		refreshInPolice()
	end
end)
function drawBorder(x, y, sx, sy, b, c)
	dxDrawRectangle(x, y, b, sy, c)
	dxDrawRectangle(x + sx - b, y, b, sy, c)
	dxDrawRectangle(x + b, y, sx - b * 2, b, c)
	dxDrawRectangle(x + b, y + sy - b, sx - b * 2, b, c)
end
local teimoObjects = {}
local teimoPeds = {}
local teimoBike = {}
teimoState = false
addEvent("gotTeimoBike", true)
addEventHandler("gotTeimoBike", getRootElement(), function(i, state)
	if state then
		if not isElement(teimoBike[i]) and isElement(teimoPeds[i]) then
			local ox, oy, oz = getElementPosition(teimoPeds[i])
			teimoBike[i] = createVehicle(509, ox, oy, oz, 0, 0, 270)
			warpPedIntoVehicle(teimoPeds[i], teimoBike[i])
			setPedCanBeKnockedOffBike(teimoPeds[i], false)
		end
	else
		if isElement(teimoBike[i]) then
			destroyElement(teimoBike[i])
		end
		teimoBike[i] = nil
	end
end)
addEvent("gotTeimoData", true)
addEventHandler("gotTeimoData", getRootElement(), function(dat, skins, surnames, names)
	teimoObjects = dat
	local tmp = dat and true or false
	if tmp ~= teimoState then
		teimoState = tmp
		if tmp then
			addEventHandler("onClientPreRender", getRootElement(), preRenderTeimo)
			if not isElement(teimoPeds[1]) then
				teimoPeds[1] = createPed(managerSkins[skins[1]], 574.7060546875, -1636.498046875, 16.649925231934)
				setElementData(teimoPeds[1], "invulnerable", true)
				setElementFrozen(teimoPeds[1], true)
				setElementData(teimoPeds[1], "visibleName", maleNames[names[1]] .. " " .. surNames[surnames[1]])
			end
			for i = 1, #otherNpcPoses do
				if not isElement(teimoPeds[i + 1]) then
					teimoPeds[i + 1] = createPed(clerkSkins[skins[i + 1]], otherNpcPoses[i][1], otherNpcPoses[i][2], otherNpcPoses[i][3])
					setElementData(teimoPeds[i + 1], "invulnerable", true)
					setElementFrozen(teimoPeds[i + 1], true)
					setElementData(teimoPeds[i + 1], "visibleName", femaleNames[names[i + 1]] .. " " .. surNames[surnames[i + 1]])
				end
			end
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderTeimo)
			for i = 1, #otherNpcPoses + 1 do
				if isElement(teimoPeds[i]) then
					destroyElement(teimoPeds[i])
				end
				teimoPeds[i] = nil
				if isElement(teimoBike[i]) then
					destroyElement(teimoBike[i])
				end
				teimoBike[i] = nil
			end
		end
	end
end)
teimoOpen = 0
function preRenderTeimo()
	for i = 1, #teimoPeds do
		if isElement(teimoObjects[i]) then
			local x, y, z = getElementPosition(teimoObjects[i])
			local gz = getGroundPosition(x, y, z + 1)
			if teimoBike[i] then
				local rx, ry, rz = getElementRotation(teimoBike[i])
				setElementPosition(teimoBike[i], x, y, gz + 0.5)
				setElementRotation(teimoBike[i], rx, ry, 180)
				setPedControlState(teimoPeds[i], "accelerate", true)
				setPedControlState(teimoPeds[i], "forwards", false)
			else
				local ox, oy, oz = getElementPosition(teimoPeds[i])
				local d = getDistanceBetweenPoints2D(x, y, ox, oy)
				if 5 < d or math.abs(oz - z) > 3 then
					setElementPosition(teimoPeds[i], x, y, z)
				end
				if 3 > getDistanceBetweenPoints2D(618.1666125, -1628.788845, ox, oy) then
					teimoOpen = 1
				else
					teimoOpen = 0
				end
				setElementFrozen(teimoPeds[i], false)
				setPedCameraRotation(teimoPeds[i], math.deg(math.atan2(x - ox, y - oy)))
				setPedControlState(teimoPeds[i], "accelerate", false)
				setPedControlState(teimoPeds[i], "walk", true)
				setPedControlState(teimoPeds[i], "forwards", 0.5 < d)
			end
		end
	end
end
addEvent("goldrobDeleteGoldBarsSync", true)
addEventHandler("goldrobDeleteGoldBarsSync", getRootElement(), function(goldBars)
	gotGoldrobLaserTries()
	gotGoldrobInsideDoorTries()
	syncGoldrobAllBarCut()
	gotGoldrobGoldBarAll(goldBars)
	goldrobSyncVaultOpenAll()
	goldrobSyncLaserOtherSide()
end)

local sightexports = {
	sControls = false,
	sGui = false,
	sCirclegame = false
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
	if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] then
		sightlangStatImgHand = false
		removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
	end
end
processsightlangStaticImage[0] = function()
	if not isElement(sightlangStaticImage[0]) then
		sightlangStaticImageToc[0] = false
		sightlangStaticImage[0] = dxCreateTexture("files/keypad.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/keys.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
local x, y = screenX / 2, screenY - 128 - 200 - 32
local pryProgress = false
local endFade = 0
keypadHacking = false
keypadCode = false
local eventsHandled = false
local circleGame = false
local pryHover = false
function clickKeypadHack(btn, state)
	if state == "down" and pryHover then
		pryProgress[pryHover] = pryProgress[pryHover] + 0.25
		if 1 <= pryProgress[pryHover] then
			pryProgress[pryHover] = 1
			local s = playSound("files/pry" .. math.random(1, 5) .. ".mp3")
			setSoundVolume(s, 1.25)
		end
	end
end
function preRenderKeypadHack(delta)
	local done = 0
	for i = 1, 8 do
		if 1 <= pryProgress[i] then
			done = done + 1
			if pryProgress[i] < 2 then
				pryProgress[i] = pryProgress[i] + 1 * delta / 1000
				if 2 <= pryProgress[i] then
					pryProgress[i] = 2
				end
			end
		elseif 0 < pryProgress[i] then
			pryProgress[i] = pryProgress[i] - 0.5 * delta / 1000
			if pryProgress[i] < 0 then
				pryProgress[i] = 0
			end
		end
	end
	if 8 <= done then
		endFade = endFade + 0.75 * delta / 1000
		if 1 <= endFade then
			endFade = 1
			if eventsHandled then
				showCursor(false)
				sightexports.sControls:toggleAllControls(true)
				removeEventHandler("onClientRender", getRootElement(), renderKeypadHack)
				removeEventHandler("onClientPreRender", getRootElement(), preRenderKeypadHack)
				removeEventHandler("onClientClick", getRootElement(), clickKeypadHack)
				if pryHover then
					pryHover = false
					sightexports.sGui:setCursorType(pryHover and "link" or "normal")
				end
				eventsHandled = false
			end
			if keypadHacking == "goldrob_door" then
				triggerServerEvent("endGoldrobInsidePry", localPlayer, true)
			elseif keypadHacking == "goldrob_garage" then
				triggerServerEvent("endGoldrobGaragePry", localPlayer, true)
			end
			sightexports.sCirclegame:startMinigame(keypadHacking, "sightred", "network-wired", "sightblue", 20, 30, 64, 35, 15000, true)
		end
	elseif getKeyState("backspace") then
		if eventsHandled then
			showCursor(false)
			sightexports.sControls:toggleAllControls(true)
			removeEventHandler("onClientRender", getRootElement(), renderKeypadHack)
			removeEventHandler("onClientPreRender", getRootElement(), preRenderKeypadHack)
			removeEventHandler("onClientClick", getRootElement(), clickKeypadHack)
			if pryHover then
				pryHover = false
				sightexports.sGui:setCursorType(pryHover and "link" or "normal")
			end
			eventsHandled = false
		end
		if keypadHacking == "goldrob_door" then
			triggerServerEvent("endGoldrobInsidePry", localPlayer, false)
		elseif keypadHacking == "goldrob_garage" then
			triggerServerEvent("endGoldrobGaragePry", localPlayer, false)
		end
		keypadHacking = false
	end
end
addEventHandler("endCircleMinigame", getRootElement(), function(mgState, success)
	if mgState == keypadHacking then
		if keypadHacking == "goldrob_door" then
			triggerServerEvent("goldrobInsideHacked", localPlayer, success)
		elseif keypadHacking == "goldrob_garage" then
			triggerServerEvent("goldrobGarageHacked", localPlayer, success)
		end
	end
	keypadHacking = false
end)
local keypadHover = false
local keypadInput = {}
local laserTries = 1
local doorTries = 1
function gotGoldrobLaserTries(tr)
	if inBankCol and (tr or 1) > laserTries then
		playSound3D("files/keyfail.mp3", laserKeypadPos[1], laserKeypadPos[2], laserKeypadPos[3])
	end
	laserTries = tr or 1
end
addEvent("gotGoldrobLaserTries", true)
addEventHandler("gotGoldrobLaserTries", getRootElement(), gotGoldrobLaserTries)
function gotGoldrobInsideDoorTries(tr)
	if inBankCol and (tr or 1) > doorTries then
		playSound3D("files/keyfail.mp3", insideKeypadPos[1], insideKeypadPos[2], insideKeypadPos[3])
	end
	doorTries = tr or 1
end
addEvent("gotGoldrobInsideDoorTries", true)
addEventHandler("gotGoldrobInsideDoorTries", getRootElement(), gotGoldrobInsideDoorTries)
function clickKeypadInput(btn, state)
	local now = getTickCount()
	if state == "down" and now - lastClick > 500 then
		local x, y, z = px, py, pz
		if keypadCode == "door" then
			x, y, z = insideKeypadPos[1], insideKeypadPos[2], insideKeypadPos[3]
		elseif keypadCode == "laser" then
			x, y, z = laserKeypadPos[1], laserKeypadPos[2], laserKeypadPos[3]
		end
		if tonumber(keypadHover) then
			playSound3D("files/key" .. math.random(1, 4) .. ".mp3", x, y, z)
			if #keypadInput < 4 then
				table.insert(keypadInput, keypadHover)
			end
		elseif keypadHover == "clear" then
			playSound3D("files/key" .. math.random(1, 4) .. ".mp3", x, y, z)
			if 0 < #keypadInput then
				table.remove(keypadInput, #keypadInput)
			end
		elseif keypadHover == "enter" then
			if 4 <= #keypadInput then
				local code = 0
				for i = 1, 4 do
					code = code + (keypadInput[i] or 0) * math.pow(10, 4 - i)
				end
				if keypadCode == "laser" then
					triggerServerEvent("goldrobTryLaserCode", localPlayer, code)
				elseif keypadCode == "door" then
					triggerServerEvent("goldrobTryDoorCode", localPlayer, code)
				end
				lastClick = now
				keypadInput = {}
			else
				playSound3D("files/key" .. math.random(1, 4) .. ".mp3", x, y, z)
			end
		elseif keypadHover == "cancel" then
			closeKeypad()
		end
	end
end
function renderKeypadInput()
	sightlangStaticImageUsed[0] = true
	if sightlangStaticImageToc[0] then
		processsightlangStaticImage[0]()
	end
	dxDrawImage(x - 150, y - 256, 300, 512, sightlangStaticImage[0])
	sightlangStaticImageUsed[1] = true
	if sightlangStaticImageToc[1] then
		processsightlangStaticImage[1]()
	end
	dxDrawImage(x - 150, y - 256, 300, 512, sightlangStaticImage[1])
	local fault = false
	if alarmState and keypadCode == "laser" then
		if getTickCount() % 1000 > 500 then
			dxDrawText("RIASZTÁS", x, y - 256 + 113, x, y - 256 + 155, tocolor(33, 52, 20), lcdFontScale * 1.5, lcdFont, "center", "center")
		end
		fault = true
	elseif 3 < doorTries and keypadCode == "door" then
		if getTickCount() % 1000 > 500 then
			dxDrawText("HIBÁS KÓD", x, y - 256 + 113, x, y - 256 + 155, tocolor(33, 52, 20), lcdFontScale * 1.5, lcdFont, "center", "center")
		end
		fault = true
	else
		local w = 24
		for i = 1, 4 do
			dxDrawText(keypadInput[i] or "_", x + w * (-3 + i), y - 256 + 115, x + w * (-2 + i), y - 256 + 145, tocolor(33, 52, 20), lcdFontScale * 1.4, lcdFont, "center", "center")
		end
		if keypadCode == "laser" then
			dxDrawText("Próba " .. laserTries .. "/3", x, y - 256 + 145, x, y - 256 + 150, tocolor(33, 52, 20), lcdFontScale * 0.75, lcdFont, "center", "center")
		elseif keypadCode == "door" then
			dxDrawText("Próba " .. doorTries .. "/3", x, y - 256 + 145, x, y - 256 + 150, tocolor(33, 52, 20), lcdFontScale * 0.75, lcdFont, "center", "center")
		end
	end
	local tmp = false
	local cx, cy = getCursorPosition()
	if cx then
		cx = cx * screenX
		cy = cy * screenY
	end
	if fault then
		if cx and cx >= x - 150 + 32 + 183 and cy >= y - 256 + 194 and cx <= x - 150 + 32 + 183 + 54 and cy <= y - 256 + 194 + 48 then
			tmp = "cancel"
		end
	else
		for i = 0, 3 do
			for j = 0, 3 do
				if cx and cx >= x - 150 + 32 + 61 * i and cy >= y - 256 + 194 + 57 * j and cx <= x - 150 + 32 + 61 * i + 54 and cy <= y - 256 + 194 + 57 * j + 48 then
					if i <= 2 and j <= 2 then
						tmp = j * 3 + i + 1
					elseif i == 3 and j == 0 then
						tmp = "cancel"
					elseif i == 3 and j == 1 then
						tmp = "clear"
					elseif i == 3 and j == 2 then
						tmp = "enter"
					elseif i == 1 and j == 3 then
						tmp = 0
					end
				end
			end
		end
	end
	if keypadHover ~= tmp then
		keypadHover = tmp
		sightexports.sGui:setCursorType(keypadHover and "link" or "normal")
	end
	local px, py, pz = getElementPosition(localPlayer)
	local x, y, z = px, py, pz
	if keypadCode == "door" then
		x, y, z = insideKeypadPos[1], insideKeypadPos[2], insideKeypadPos[3]
		if px <= insideKeypadPos[1] then
			z = 10000
		end
	elseif keypadCode == "laser" then
		x, y, z = laserKeypadPos[1], laserKeypadPos[2], laserKeypadPos[3]
	end
	if 1.5 < getDistanceBetweenPoints3D(x, y, z, px, py, pz) then
		closeKeypad()
	end
end
function closeKeypad()
	if keypadCode then
		removeEventHandler("onClientRender", getRootElement(), renderKeypadInput)
		removeEventHandler("onClientClick", getRootElement(), clickKeypadInput)
	end
	if keypadHover then
		keypadHover = false
		sightexports.sGui:setCursorType("normal")
	end
	keypadCode = false
end
function openKeypad(code)
	if keypadHacking then
		return
	end
	if not keypadCode then
		addEventHandler("onClientRender", getRootElement(), renderKeypadInput)
		addEventHandler("onClientClick", getRootElement(), clickKeypadInput)
	end
	sightexports.sGui:showInfobox("i", "Kilépéshez kattints a 'CANCEL' gombra.")
	keypadInput = {}
	keypadCode = code
end
function renderKeypadHack()
	sightlangStaticImageUsed[0] = true
	if sightlangStaticImageToc[0] then
		processsightlangStaticImage[0]()
	end
	dxDrawImage(x - 150, y - 256, 300, 512, sightlangStaticImage[0])
	if keypadHacking == "goldrob_door" then
		if 3 < doorTries then
			if getTickCount() % 1000 > 500 then
				dxDrawText("HIBÁS KÓD", x, y - 256 + 113, x, y - 256 + 155, tocolor(33, 52, 20), lcdFontScale * 1.5, lcdFont, "center", "center")
			end
		else
			local w = 24
			for i = 1, 4 do
				dxDrawText("_", x + w * (-3 + i), y - 256 + 115, x + w * (-2 + i), y - 256 + 145, tocolor(33, 52, 20), lcdFontScale * 1.4, lcdFont, "center", "center")
			end
			dxDrawText("Próba " .. doorTries .. "/3", x, y - 256 + 145, x, y - 256 + 150, tocolor(33, 52, 20), lcdFontScale * 0.75, lcdFont, "center", "center")
		end
	elseif keypadHacking == "goldrob_garage" then
		local w = 24
		for i = 1, 4 do
			dxDrawText("_", x + w * (-3 + i), y - 256 + 113, x + w * (-2 + i), y - 256 + 155, tocolor(33, 52, 20), lcdFontScale * 1.4, lcdFont, "center", "center")
		end
	end
	local a = 255
	if 0.25 < endFade then
		a = 255 * (1 - (endFade - 0.25) / 0.75)
	end
	sightlangStaticImageUsed[1] = true
	if sightlangStaticImageToc[1] then
		processsightlangStaticImage[1]()
	end
	dxDrawImage(x - 150, y - 256 + 512 * endFade, 300, 512, sightlangStaticImage[1], 70 * endFade, 0, 0, tocolor(255, 255, 255, a))
	local tmp = false
	local cx, cy = getCursorPosition()
	if cx then
		cx = cx * screenX
		cy = cy * screenY
	end
	for i = 0, 1 do
		for j = 0, 3 do
			local id = j + 1 + i * 4
			local a = 1
			local p = pryProgress[id]
			if 1 < p then
				a = 1 - (p - 1)
			end
			local green = tocolor(sightgreen[1], sightgreen[2], sightgreen[3], 255 * a)
			if p < 1 then
				dxDrawImage(x - 131 + 262 * i - 16, y + 45 - 127.5 + 85 * j - 16, 32, 32, ":sGui/" .. circleIcon .. faTicks[circleIcon], 0, 0, 0, tocolor(0, 0, 0, 200 * a))
				dxDrawImage(x - 131 + 262 * i - 16, y + 45 - 127.5 + 85 * j - 16, 32, 32, ":sGui/" .. circleBorderIcon .. faTicks[circleBorderIcon], 0, 0, 0, green)
				if cx and cx >= x - 131 + 262 * i - 16 and cy >= y + 45 - 127.5 + 85 * j - 16 and cx <= x - 131 + 262 * i + 16 and cy <= y + 45 - 127.5 + 85 * j + 16 then
					tmp = id
				end
			end
			if 0 < p then
				p = math.min(p, 1)
				dxDrawImageSection(x - 131 + 262 * i - 16, y + 45 - 127.5 + 85 * j - 16, 32 * p, 32, 0, 0, 32 * p, 32, ":sGui/" .. circleIcon .. faTicks[circleIcon], 0, 0, 0, green)
			end
		end
	end
	if pryHover ~= tmp then
		pryHover = tmp
		sightexports.sGui:setCursorType(pryHover and "link" or "normal")
	end
end
function startKeypadHacking(hackType)
	if not eventsHandled then
		showCursor(true)
		sightexports.sControls:toggleAllControls(false)
		addEventHandler("onClientRender", getRootElement(), renderKeypadHack)
		addEventHandler("onClientPreRender", getRootElement(), preRenderKeypadHack)
		addEventHandler("onClientClick", getRootElement(), clickKeypadHack)
		eventsHandled = true
	end
	keypadHacking = hackType
	pryProgress = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	endFade = 0
	sightexports.sGui:showInfobox("i", "Feszítsd le a billentyűzetet a zöld körökre kattintva.")
	sightexports.sGui:showInfobox("i", "Megszakításhoz használd a Backspace gombot.")
end
addEvent("goldrobInsideHackStarted", true)
addEventHandler("goldrobInsideHackStarted", getRootElement(), function(pried)
	closeKeypad()
	if pried then
		keypadHacking = "goldrob_door"
		sightexports.sCirclegame:startMinigame("goldrob_door", "sightred", "network-wired", "sightblue", 20, 30, 64, 35, 15000, true)
	else
		startKeypadHacking("goldrob_door")
	end
end)
addEvent("goldrobGarageHackStarted", true)
addEventHandler("goldrobGarageHackStarted", getRootElement(), function(pried)
	closeKeypad()
	if pried then
		keypadHacking = "goldrob_garage"
		sightexports.sCirclegame:startMinigame("goldrob_garage", "sightred", "network-wired", "sightblue", 20, 30, 64, 35, 15000, true)
	else
		startKeypadHacking("goldrob_garage")
	end
end)