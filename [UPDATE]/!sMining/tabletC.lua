local r1_0 = math.min(1, screenHeight / 1000)
local r2_0 = {}
local r3_0 = {}
local r4_0 = false
local r5_0 = false
local r6_0 = 0
local r7_0 = 0
local r8_0 = nil
local r9_0 = nil
local r10_0 = nil
local r11_0 = 800
local r12_0 = 600
local r13_0 = 800
local r14_0 = 652
local r15_0 = nil
local r16_0 = nil
local r17_0 = false
local r18_0 = nil
local r19_0 = {}
local r20_0 = screenWidth / 2
local r21_0 = screenHeight / 2
local r22_0 = 1
local r23_0 = 8
local r24_0 = false
local r25_0 = 1
local r26_0 = false
local r27_0 = {}
local r28_0 = {}
local r29_0 = ""
local r30_0 = 0
local r31_0 = false
local r32_0 = nil
local r33_0 = nil
local r34_0 = false
local r35_0 = false
local r36_0 = false
local r37_0 = {}
local r38_0 = false
local r39_0 = false
currentMineOrdering = {}
function setTabletMode(r0_2)
	-- line: [57, 75] id: 2
	tabletItem = r0_2
	if type(tabletItem) == "number" then
		if currentMine then
			if triggerServerEvent("syncMineTablet", localPlayer, true) then
				createTablet()
				return true
			end
		else
			exports.sGui:showInfobox("e", "Csak bányában veheted elő!")
		end
	elseif triggerServerEvent("syncMineTablet", localPlayer) then
		deleteTablet()
		return true
	end
	return false
end
addEvent("syncMineTablet", true)
addEventHandler("syncMineTablet", root, function(r0_3)
	-- line: [79, 97] id: 3
	if r0_3 and isElement(source) and not r2_0[source] then
		r2_0[source] = true
		addEventHandler("onClientPlayerStreamIn", source, streamTablet)
		addEventHandler("onClientPlayerStreamOut", source, streamTablet)
		addEventHandler("onClientPlayerQuit", source, streamTablet)
	elseif r2_0[source] then
		r2_0[source] = nil
		removeEventHandler("onClientPlayerStreamIn", source, streamTablet)
		removeEventHandler("onClientPlayerStreamOut", source, streamTablet)
		removeEventHandler("onClientPlayerQuit", source, streamTablet)
	end
	processTablet(source)
end)
addEvent("renameMineResponse", true)
addEventHandler("renameMineResponse", localPlayer, function(r0_4, r1_4)
	-- line: [102, 115] id: 4
	if r0_4 then
		currentMineName = r0_4
	end
	mineNameSyncing = false
	mineNameEdited = false
	if r1_4 then
		exports.sGui:showInfobox("e", r1_4)
	end
	shouldRefreshUrmaMotoDevice = true
end)
addEvent("mineOrderResponse", true)
addEventHandler("mineOrderResponse", localPlayer, function(r0_5, r1_5)
	-- line: [120, 128] id: 5
	mineOrderSyncing = false
	if r1_5 then
		local r2_5 = exports.sGui
		local r4_5 = nil	-- notice: implicit variable refs by block#[4]
		if r0_5 then
			r4_5 = "s"
		else
			r4_5 = "e"
		end
		r2_5:showInfobox(r4_5, r1_5)
	end
	shouldRefreshUrmaMotoDevice = true
end)
function streamTablet()
	-- line: [131, 137] id: 6
	if eventName == "onClientPlayerQuit" then
		r2_0[source] = nil
	end
	processTablet(source)
end
function processTablet(r0_7, r1_7)
	-- line: [139, 171] id: 7
	local r2_7 = nil	-- notice: implicit variable refs by block#[5, 9]
	if r1_7 == nil then
		r2_7 = r2_0[r0_7]
	else
		r2_7 = r1_7
	end
	if not isElementStreamedIn(r0_7) then
		r2_7 = false
	elseif r2_7 and (not isPlayerFreeFromAction(r0_7) or isRailCarSyncer(r0_7)) then
		r2_7 = false
	end
	if r2_7 then
		if not r3_0[r0_7] then
			r3_0[r0_7] = createObject(modelIds.v4_mine_tablet, 0, 0, 0)
			if isElement(r3_0[r0_7]) then
				setElementInterior(r3_0[r0_7], 0)
				setElementDimension(r3_0[r0_7], currentMine)
			end
		end
		if isElement(r3_0[r0_7]) then
			exports.sPattach:attach(r3_0[r0_7], r0_7, 25, -0.015927458568625, 0.029212576383282, 0.10783896003808, 0, 0, 0)
			exports.sPattach:setRotationQuaternion(r3_0[r0_7], {
				0.059827387447574,
				-0.038785605657951,
				0.72739675435797,
				0.68250298333007
			})
		end
	else
		if isElement(r3_0[r0_7]) then
			destroyElement(r3_0[r0_7])
		end
		r3_0[r0_7] = nil
	end
end
function pedsProcessedTablet(r0_8)
	-- line: [173, 186] id: 8
	for r4_8 in pairs(r2_0) do
		if isElement(r4_8) and isElementOnScreen(r4_8) then
			setElementBoneRotation(r4_8, 22, 51.73919511878, -74.347910673722, -58.695642222529)
			setElementBoneRotation(r4_8, 23, -50.869565217392, -78.260849662452, -9.1302705847697)
			setElementBoneRotation(r4_8, 24, -142.17389314071, -35.217426134192, -24.782568890116)
			setElementBoneRotation(r4_8, 25, -1.3044174857762, 10.43479256008, 16.956457055133)
			setElementBoneRotation(r4_8, 26, -5.2173266203507, 15.652084350586, 0)
			r0_8[r4_8] = true
		end
	end
end
function createTablet()
	-- line: [188, 196] id: 9
	if currentMine then
		if not r4_0 and not r5_0 then
			initUrmaMotoDevice(true)
		end
		r4_0 = true
	end
end
function deleteTablet()
	-- line: [198, 205] id: 10
	r4_0 = false
	endTabletMoving()
	if not r4_0 and not r5_0 then
		initUrmaMotoDevice(false)
	end
end
function createComputer()
	-- line: [207, 230] id: 11
	if not r4_0 and not r5_0 then
		initUrmaMotoDevice(true)
	end
	if r7_0 < 1 then
		playSound("files/sounds/computeron.wav")
	end
	if not r5_0 then
		addEventHandler("onClientPreRender", root, handleComputerLoading)
		exports.sChat:localActionC(localPlayer, "bekapcsolta a számítógépet.")
	end
	r5_0 = true
	if not r6_0 then
		r6_0 = playSound("files/sounds/computerloop.wav", true)
		if isElement(r6_0) then
			setSoundVolume(r6_0, 0)
		end
	end
end
function deleteComputer()
	-- line: [232, 242] id: 12
	if r5_0 then
		exports.sChat:localActionC(localPlayer, "kikapcsolta a számítógépet.")
	end
	r5_0 = false
	if not r4_0 and not r5_0 then
		initUrmaMotoDevice(false)
	end
end
function handleComputerLoading(r0_13)
	-- line: [244, 275] id: 13
	if r5_0 then
		if getDistanceBetweenPoints2D(minePosX - 32.6914, minePosY - 3.7004, selfPosX, selfPosY) > 2.5 then
			deleteComputer()
		end
		r7_0 = math.min(1, r7_0 + r0_13 / 2000)
		if isElement(r6_0) then
			setSoundSpeed(r6_0, 0.5 + 0.5 * r7_0)
			setSoundVolume(r6_0, math.min(1, r7_0 * 5) * 0.5)
		end
	else
		r7_0 = r7_0 - r0_13 / 1000
		if isElement(r6_0) then
			setSoundSpeed(r6_0, 0.5 + 0.5 * r7_0)
			setSoundVolume(r6_0, math.min(1, r7_0 * 5) * 0.5)
		end
		if r7_0 < 0 then
			r7_0 = 0
			if isElement(r6_0) then
				destroyElement(r6_0)
			end
			removeEventHandler("onClientPreRender", root, handleComputerLoading)
			r6_0 = nil
		end
	end
end
function initUrmaMotoDevice(r0_14)
	-- line: [277, 368] id: 14
	exports.sGui:showTooltip()
	exports.sGui:setCursorType("normal")
	if r0_14 then
		r28_0 = {
			urmamotoLogo = dxCreateTexture("files/textures/urmamoto/logo.dds", "argb", true),
			tabletBackground = dxCreateTexture("files/textures/urmamoto/tabb.dds", "argb", true),
			tabletForeground = dxCreateTexture("files/textures/urmamoto/tabf.dds", "argb", true),
			computerBackground = dxCreateTexture("files/textures/urmamoto/comb.dds", "argb", true),
			computerForeground = dxCreateTexture("files/textures/urmamoto/comf.dds", "argb", true),
			siloIcon = dxCreateTexture("files/textures/urmamoto/silo.dds", "argb", true),
			smelterIcon = dxCreateTexture("files/textures/urmamoto/smelter.dds", "argb", true),
		}
		for r4_14 = 1, 12, 1 do
			r28_0["mapPiece" .. r4_14] = dxCreateTexture("files/textures/urmamoto/m" .. r4_14 .. ".dds", "argb", true)
		end
		r8_0 = dxCreateFont("files/fonts/dos.ttf", 16)
		r9_0 = dxCreateFont("files/fonts/dos.ttf", 16, true)
		r10_0 = dxGetFontHeight(1, r8_0)
		r15_0 = dxCreateShader("files/shaders/urmamoto.fx")
		r16_0 = dxCreateRenderTarget(r11_0, r12_0)
		if isElement(r16_0) then
			dxSetShaderValue(r15_0, "screenTexture", r16_0)
		end
		if not r18_0 or r18_0 == "home" then
			setCurrentDeviceMenu("home")
		end
		addEventHandler("onClientClick", root, handleUrmaMotoDeviceClick)
		addEventHandler("onClientRender", root, handleUrmaMotoDeviceRender, true, "normal-1")
		addEventHandler("onClientRestore", root, handleUrmaMotoDeviceRestore)
		addEventHandler("onClientCharacter", root, handleUrmaMotoDeviceInput)
		addEventHandler("onClientKey", root, handleUrmaMotoDeviceKeyPress, true, "high+9999999")
		shouldRefreshUrmaMotoDevice = true
	else
		exports.sTrading:setForexSubscription(false)
		if r31_0 then
			removeEventHandler("onForexUpdate", localPlayer, refreshForex)
			r31_0 = false
		end
		removeEventHandler("onClientKey", root, handleUrmaMotoDeviceKeyPress)
		removeEventHandler("onClientCharacter", root, handleUrmaMotoDeviceInput)
		removeEventHandler("onClientRestore", root, handleUrmaMotoDeviceRestore)
		removeEventHandler("onClientRender", root, handleUrmaMotoDeviceRender)
		removeEventHandler("onClientClick", root, handleUrmaMotoDeviceClick)
		if isElement(r8_0) then
			destroyElement(r8_0)
		end
		if isElement(r9_0) then
			destroyElement(r9_0)
		end
		r8_0 = nil
		r9_0 = nil
		r10_0 = nil
		if isElement(r15_0) then
			destroyElement(r15_0)
		end
		if isElement(r16_0) then
			destroyElement(r16_0)
		end
		r15_0 = nil
		r16_0 = nil
		for r4_14, r5_14 in pairs(r28_0) do
			if isElement(r5_14) then
				destroyElement(r5_14)
			end
			r28_0[r4_14] = nil
		end
		r28_0 = {}
	end
end
function setCurrentDeviceMenu(r0_15)
	-- line: [370, 396] id: 15
	r18_0 = r0_15
	if r18_0 == "permissions" then
		r34_0 = false
		r35_0 = false
		r36_0 = false
	elseif r18_0 == "home" then
		exports.sTrading:setForexSubscription("all")
		if not r31_0 then
			addEventHandler("onForexUpdate", localPlayer, refreshForex)
			r31_0 = true
		end
		refreshForex()
	else
		exports.sTrading:setForexSubscription(false)
		if r31_0 then
			removeEventHandler("onForexUpdate", localPlayer, refreshForex)
			r31_0 = false
		end
	end
	shouldRefreshUrmaMotoDevice = true
end
function handleUrmaMotoDeviceInput(r0_16)
	-- line: [398, 449] id: 16
	if currentNameLine then
		local r1_16 = utf8.upper(r0_16)
		if charset[r1_16] or r1_16 == " " then
			local r2_16 = currentMineName[currentNameLine] or ""
			local r3_16 = utf8.len(r2_16)
			if r3_16 < 16 then
				local r4_16 = r10_0 / 64
				local r5_16 = math.floor(r10_0 * 3.5 / 0.44326 * 0.927294)
				local r6_16 = 0
				local r7_16 = 28
				for r11_16 = 1, r3_16, 1 do
					local r13_16 = charset[utf8.sub(r2_16, r11_16, r11_16)]
					if r13_16 then
						r6_16 = r6_16 + r13_16[2] * r4_16
					else
						r6_16 = r6_16 + r7_16 * r4_16
					end
				end
				local r8_16 = charset[r1_16]
				if r8_16 then
					r6_16 = r6_16 + r8_16[2] * r4_16
				else
					r6_16 = r6_16 + r7_16 * r4_16
				end
				if r6_16 < r5_16 then
					r2_16 = r2_16 .. r0_16
					shouldRefreshUrmaMotoDevice = true
				end
			end
			currentMineName[currentNameLine] = r2_16
		end
	elseif r35_0 and r0_16 ~= "\u{7f}" then
		r0_16 = utf8.upper(r0_16)
		if r0_16:match("%w") ~= nil or r0_16 == " " or r0_16 == "_" then
			r36_0 = r36_0 .. r0_16
			shouldRefreshUrmaMotoDevice = true
		end
	end
end
function handleUrmaMotoDeviceKeyPress(r0_17, r1_17)
	-- line: [451, 507] id: 17
	if currentNameLine then
		cancelEvent()
		if r1_17 then
			if r0_17 == "backspace" then
				local r2_17 = currentMineName[currentNameLine]
				if utf8.len(r2_17) <= 0 and 1 < currentNameLine then
					currentMineName[currentNameLine] = nil
					currentNameLine = currentNameLine - 1
					mineNameEdited = true
				else
					currentMineName[currentNameLine] = utf8.sub(r2_17, 1, -2)
					mineNameEdited = true
				end
				shouldRefreshUrmaMotoDevice = true
			elseif r0_17 == "arrow_u" and currentNameLine > 1 then
				shouldRefreshUrmaMotoDevice = true
				if utf8.len(currentMineName[currentNameLine]) <= 0 then
					currentMineName[currentNameLine] = nil
					mineNameEdited = true
				end
				currentNameLine = currentNameLine - 1
			elseif r0_17 == "enter" or r0_17 == "arrow_d" then
				if currentNameLine < 2 then
					currentNameLine = currentNameLine + 1
					if not currentMineName[currentNameLine] then
						currentMineName[currentNameLine] = ""
						mineNameEdited = true
					end
					shouldRefreshUrmaMotoDevice = true
				else
					endMineNameEdit()
				end
			end
		end
	elseif r35_0 then
		cancelEvent()
		if r1_17 then
			if r0_17 == "backspace" then
				r36_0 = utf8.sub(r36_0, 1, -2)
				shouldRefreshUrmaMotoDevice = true
			elseif r0_17 == "enter" then
				tabletRegisterCheck()
			end
		end
	end
end
function endMineNameEdit()
	-- line: [509, 532] id: 18
	if currentNameLine then
		showCursor(false)
		for r3_18 = #currentMineName, 1, -1 do
			if not currentMineName[r3_18] or utf8.len(currentMineName[r3_18]) <= 1 then
				table.remove(currentMineName, r3_18)
			else
				break
			end
		end
		currentNameLine = false
		if mineNameEdited and currentMineOwnerId == selfCharacterId then
			triggerLatentServerEvent("renameMine", localPlayer, currentMineName)
			mineNameSyncing = true
		end
		shouldRefreshUrmaMotoDevice = true
	end
end
function endTabletMoving()
	-- line: [534, 540] id: 19
	if r24_0 then
		r24_0 = false
		exports.sGui:setCursorType("normal")
	end
end
function tabletRegisterCheck()
	-- line: [542, 593] id: 20
	local r0_20 = utf8.lower(r36_0):gsub("_", " ")
	if utf8.len(r0_20) <= 0 then
		return 
	end
	local r1_20 = false
	local r2_20 = getElementsByType("player")
	if tonumber(r0_20) then
		local r3_20 = tonumber(r0_20)
		for r7_20 = 1, #r2_20, 1 do
			if getElementData(r2_20[r7_20], "playerID") == r3_20 then
				r1_20 = r2_20[r7_20]
			end
		end
	else
		for r6_20 = 1, #r2_20, 1 do
			if getElementData(r2_20[r6_20], "loggedIn") then
				local r8_20 = getElementData(r2_20[r6_20], "visibleName")
				if r8_20 and utf8.find(utf8.lower(r8_20):gsub("_", " "), r0_20) then
					if not r1_20 then
						r1_20 = r2_20[r6_20]
					else
						return exports.sGui:showInfobox("e", "Több játékos található ilyen névvel!")
					end
				end
			end
		end
	end
	if not isElement(r1_20) then
		return exports.sGui:showInfobox("e", "Nem található a játékos!")
	end
	if r1_20 == localPlayer then
		return exports.sGui:showInfobox("e", "Saját magadat nem alkalmazhatod!")
	end
	r34_0 = false
	r35_0 = r1_20
	shouldRefreshUrmaMotoDevice = true
end
function handleUrmaMotoDeviceClick(r0_21, r1_21, r2_21, r3_21)
	-- line: [595, 786] id: 21
	if r33_0 == "moveTablet" or r24_0 then
		if r1_21 == "up" then
			endTabletMoving()
		else
			r24_0 = {
				r2_21,
				r3_21
			}
			exports.sGui:setCursorType("move")
		end
	elseif r1_21 == "up" then
		if r33_0 == "editMineName" and not mineNameSyncing then
			showCursor(true)
			currentNameLine = #currentMineName
			shouldRefreshUrmaMotoDevice = true
		elseif r33_0 == "turnOffComputer" then
			deleteComputer()
		elseif r33_0 == "zoomInTablet" and r22_0 < 1 then
			local r4_21 = r22_0
			r22_0 = math.min(1, r22_0 + 1 / r23_0)
			r20_0 = r2_21 + (r20_0 - r2_21) * r1_0 * r22_0 / r1_0 * r4_21
			r21_0 = r3_21 + (r21_0 - r3_21) * r1_0 * r22_0 / r1_0 * r4_21
			r20_0 = math.max(0, math.min(screenWidth, r20_0))
			r21_0 = math.max(0, math.min(screenHeight, r21_0))
		elseif r33_0 == "zoomOutTablet" and r22_0 > 0.5 then
			local r4_21 = r22_0
			r22_0 = math.max(0.5, r22_0 - 1 / r23_0)
			r20_0 = r2_21 + (r20_0 - r2_21) * r1_0 * r22_0 / r1_0 * r4_21
			r21_0 = r3_21 + (r21_0 - r3_21) * r1_0 * r22_0 / r1_0 * r4_21
			r20_0 = math.max(0, math.min(screenWidth, r20_0))
			r21_0 = math.max(0, math.min(screenHeight, r21_0))
		elseif r33_0 == "mapCenter" then
			r26_0 = false
			shouldRefreshUrmaMotoDevice = true
		elseif r33_0 == "requestFuelTank" then
			if checkMinePermission(permissionFlags.ORDER) then
				triggerServerEvent("requestMineFuelTank", localPlayer)
			else
				exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
			end
		elseif r33_0 == "promptNo" then
			shouldRefreshUrmaMotoDevice = true
			if r35_0 then
				r35_0 = false
				r36_0 = ""
			elseif r34_0 then
				r34_0 = false
			end
		elseif r33_0 == "promptYes" then
			shouldRefreshUrmaMotoDevice = true
			if r35_0 then
				if isElement(r35_0) then
					triggerServerEvent("addMinePermissions", localPlayer, r35_0)
					r35_0 = false
					r36_0 = ""
				else
					tabletRegisterCheck()
				end
			elseif r34_0 then
				triggerServerEvent("removeMinePermissions", localPlayer, r34_0)
				r34_0 = false
			end
		elseif r33_0 == "addWorker" and currentMineOwnerId == selfCharacterId and not r34_0 then
			r35_0 = true
			r36_0 = ""
			shouldRefreshUrmaMotoDevice = true
		elseif r33_0 == "createOrder" then
			if checkMinePermission(permissionFlags.ORDER) then
				revalidateTabletOrder()
				triggerLatentServerEvent("createMineOrder", localPlayer, currentMineOrdering)
				mineOrderSyncing = true
				shouldRefreshUrmaMotoDevice = true
			else
				exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
			end
		elseif r33_0 == "cancelOrder" then
			if checkMinePermission(permissionFlags.ORDER) then
				triggerLatentServerEvent("cancelMineOrder", localPlayer)
				mineOrderSyncing = true
				shouldRefreshUrmaMotoDevice = true
			else
				exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
			end
		elseif r33_0 then
			local r4_21 = split(r33_0, ".")
			if r4_21[1] == "menu" then
				setCurrentDeviceMenu(r4_21[2])
			elseif r4_21[1] == "mapZoom" then
				local r5_21 = tonumber(r4_21[2])
				if r5_21 then
					r25_0 = math.max(0.25, math.min(1.5, r25_0 + r5_21 * 0.25))
				end
				shouldRefreshUrmaMotoDevice = true
			elseif r4_21[1] == "mapMove" then
				local r5_21 = tonumber(r4_21[2])
				if r5_21 then
					shouldRefreshUrmaMotoDevice = true
					if not r26_0 then
						r26_0 = {
							selfMineX,
							selfMineY
						}
					end
					r26_0[r5_21] = r26_0[r5_21] + tonumber(r4_21[3])
				end
			elseif r4_21[1] == "fireWorker" and not r35_0 then
				r34_0 = tonumber(r4_21[2])
				shouldRefreshUrmaMotoDevice = true
			elseif r4_21[1] == "setPermission" and currentMineOwnerId == selfCharacterId then
				local r5_21 = tonumber(r4_21[2])
				local r8_21 = permissionFlags[permissionList[tonumber(r4_21[3])]]
				if currentMinePermissions[r5_21] then
					if not r37_0[r5_21] then
						r37_0[r5_21] = currentMinePermissions[r5_21]
					end
					if bitTest(r37_0[r5_21], r8_21) then
						r37_0[r5_21] = r37_0[r5_21] - r8_21
					else
						r37_0[r5_21] = r37_0[r5_21] + r8_21
					end
					r39_0 = getTickCount()
					if not r38_0 then
						addEventHandler("onClientPreRender", root, handleMinePermissionChange)
						r38_0 = true
					end
					shouldRefreshUrmaMotoDevice = true
				end
			elseif r4_21[1] == "orderPlus" then
				local r5_21 = r4_21[2]
				if not currentMineOrdering[r5_21] then
					currentMineOrdering[r5_21] = 1
				else
					currentMineOrdering[r5_21] = currentMineOrdering[r5_21] + 1
				end
				revalidateTabletOrder()
			elseif r4_21[1] == "orderMinus" then
				local r5_21 = r4_21[2]
				if not currentMineOrdering[r5_21] then
					currentMineOrdering[r5_21] = 0
				else
					currentMineOrdering[r5_21] = currentMineOrdering[r5_21] - 1
				end
				revalidateTabletOrder()
			end
		end
	end
	-- warn: not visited block [8]
	-- block#8:
	-- endMineNameEdit()
	-- goto label_504
end
function revalidateTabletOrder()
	-- line: [788, 791] id: 22
	refreshOrderConstraints(currentMineOrdering, currentMineInventory)
	shouldRefreshUrmaMotoDevice = true
end
function handleMinePermissionChange()
	-- line: [793, 813] id: 23
	if getTickCount() - r39_0 > 5000 then
		removeEventHandler("onClientPreRender", root, handleMinePermissionChange)
		if next(r37_0) then
			triggerServerEvent("updateMinePermissions", localPlayer, r37_0)
			if type(currentMinePermissions) == "table" then
				for r3_23, r4_23 in pairs(r37_0) do
					if currentMinePermissions[r3_23] then
						currentMinePermissions[r3_23] = r4_23
					end
				end
			end
			r37_0 = {}
		end
		r38_0 = false
	end
end
function hasUnsyncedPermissions()
	-- line: [815, 817] id: 24
	return next(r37_0) ~= nil
end
function handleUrmaMotoDeviceRestore()
	-- line: [819, 821] id: 25
	shouldRefreshUrmaMotoDevice = true
end
function handleUrmaMotoDeviceRender()
	-- line: [823, 909] id: 26
	local r0_26 = false
	local r1_26 = false
	r32_0 = false
	if r5_0 then
		hoverComputer()
	elseif r4_0 then
		hoverTablet()
	end
	if r33_0 ~= r32_0 then
		r33_0 = r32_0
		if r33_0 == "moveTablet" or r24_0 then
			exports.sGui:showTooltip(false)
			exports.sGui:setCursorType("move")
		elseif r33_0 then
			exports.sGui:setCursorType("link")
			if r33_0 == "turnOffComputer" then
				exports.sGui:showTooltip("Számítógép kikapcsolása")
			elseif r33_0 == "!" then
				exports.sGui:showTooltip("Tablet nagyítása")
			elseif r33_0 == "zoomOutTablet" then
				exports.sGui:showTooltip("Tablet kicsinyítése")
			elseif r33_0:find("fireWorker") then
				exports.sGui:showTooltip("Kirúgás")
			elseif r33_0:find("setPermission") then
				local r2_26 = permissionList[tonumber(gettok(r33_0, 3, "."))]
				if r2_26 then
					local r3_26 = permissionFlags[r2_26]
					if r3_26 then
						exports.sGui:showTooltip(permissionDescriptions[r3_26])
						if currentMineOwnerId ~= selfCharacterId then
							exports.sGui:setCursorType("normal")
						end
					end
				end
			else
				exports.sGui:showTooltip(false)
			end
		else
			exports.sGui:showTooltip(false)
			exports.sGui:setCursorType("normal")
		end
		r1_26 = true
	end
	if r18_0 == "home" or r18_0 == "map" or r18_0 == "shop" and mineOrderSyncing then
		r0_26 = 250 < getTickCount() % 500
	elseif r18_0 == "permissions" and r35_0 and not isElement(r35_0) then
		r0_26 = 250 < getTickCount() % 500
	elseif r18_0 == "ores" then
		if shouldRefreshBoxContent or shouldRefreshFoundryContent or mineFoundryData.furnaceRunning then
			shouldRefreshUrmaMotoDevice = true
		end
		if mineFoundryData.furnaceRunning or mineFoundryData.meltingOre then
			r0_26 = 250 < getTickCount() % 500
		else
			r0_26 = true
		end
	end
	if r17_0 ~= r0_26 or shouldRefreshUrmaMotoDevice or r1_26 then
		r19_0 = {}
		r17_0 = r0_26
		shouldRefreshUrmaMotoDevice = false
		drawRenderTarget(r0_26)
	end
	if r5_0 then
		drawComputer()
	elseif r4_0 then
		drawTablet()
	end
end

function refreshForex()
	-- line: [911, 936] id: 27
	shouldRefreshUrmaMotoDevice = true
	r29_0 = ""
	for r3_27, r4_27 in pairs(oreTypes) do
		if r4_27.forexIndex then
			local r5_27 = exports.sTrading:getPrice(r4_27.forexIndex)
			if r5_27 then
				if exports.sTrading:getTrend(r4_27.forexIndex) then
					r29_0 = r29_0 .. "#ff0000/\\#00ff00 " .. r4_27.forexIndex .. " - " .. formatNumber(math.floor(r5_27 + 0.5)) .. " $ | "
				else
					r29_0 = r29_0 .. "#0000ff\\/#00ff00 " .. r4_27.forexIndex .. " - " .. formatNumber(math.floor(r5_27 + 0.5)) .. " $ | "
				end
			else
				r29_0 = r29_0 .. "  #00ff00 " .. r4_27.forexIndex .. " - ... | "
			end
		end
	end
	r30_0 = dxGetTextWidth(r29_0, 0.75, r8_0, true)
end
function hoverComputer()
	-- line: [938, 973] id: 28
	local r0_28, r1_28 = getCursorPosition()
	if r0_28 then
		local r2_28 = r1_0
		local r3_28 = screenWidth / 2 - r13_0 / 2 * r2_28
		local r4_28 = screenHeight / 2 - r14_0 / 2 * r2_28
		r0_28 = r0_28 * screenWidth
		r1_28 = r1_28 * screenHeight
		local r5_28 = r3_28 - 140 * r2_28
		local r6_28 = r4_28 - 214 * r2_28
		if r5_28 + 867 * r2_28 <= r0_28 and r0_28 <= r5_28 + 916 * r2_28 and r6_28 + 855 * r2_28 <= r1_28 and r1_28 <= r6_28 + 903 * r2_28 then
			r32_0 = "turnOffComputer"
		elseif r7_0 * 3 >= 1 then
			r0_28 = (r0_28 - r3_28) / r2_28
			r1_28 = (r1_28 - r4_28) / r2_28
			if 0 < r0_28 and r0_28 < r11_0 and 0 < r1_28 and r1_28 < r12_0 then
				r32_0 = false
				for r10_28, r11_28 in pairs(r19_0) do
					if r11_28[1] <= r0_28 and r0_28 <= r11_28[1] + r11_28[3] and r11_28[2] <= r1_28 and r1_28 <= r11_28[2] + r11_28[4] then
						r32_0 = r10_28
						break
					end
				end
				tabletHovering = true
			end
		end
	end
end
function hoverTablet()
	-- line: [975, 1033] id: 29
	local r0_29, r1_29 = getCursorPosition()
	if r0_29 then
		local r2_29 = r1_0 * r22_0
		local r3_29 = r20_0 - r11_0 / 2 * r2_29
		local r4_29 = r21_0 - r12_0 / 2 * r2_29
		r0_29 = r0_29 * screenWidth
		r1_29 = r1_29 * screenHeight
		if r24_0 then
			r20_0 = math.max(0, math.min(screenWidth, r20_0 + r0_29 - r24_0[1]))
			r21_0 = math.max(0, math.min(screenHeight, r21_0 + r1_29 - r24_0[2]))
			r24_0[1] = r0_29
			r24_0[2] = r1_29
		else
			local r5_29 = r3_29 - 200 * r2_29
			local r6_29 = r4_29 - 150 * r2_29
			if r5_29 + 56 * r2_29 <= r0_29 and r0_29 <= r5_29 + 1145 * r2_29 and r6_29 + 34 * r2_29 <= r1_29 and r1_29 <= r6_29 + 866 * r2_29 then
				r32_0 = "moveTablet"
			end
			if r5_29 + 1042 * r2_29 <= r0_29 and r0_29 <= r5_29 + 1088 * r2_29 then
				if r6_29 + 704 * r2_29 <= r1_29 and r1_29 <= r6_29 + 750 * r2_29 then
					r32_0 = "zoomInTablet"
				elseif r6_29 + 759 * r2_29 <= r1_29 and r1_29 <= r6_29 + 805 * r2_29 then
					r32_0 = "zoomOutTablet"
				end
			end
			r0_29 = (r0_29 - r3_29) / r2_29
			r1_29 = (r1_29 - r4_29) / r2_29
			if 0 < r0_29 and r0_29 < r11_0 and 0 < r1_29 and r1_29 < r12_0 then
				r32_0 = false
				for r10_29, r11_29 in pairs(r19_0) do
					if r11_29[1] <= r0_29 and r0_29 <= r11_29[1] + r11_29[3] and r11_29[2] <= r1_29 and r1_29 <= r11_29[2] + r11_29[4] then
						r32_0 = r10_29
						break
					end
				end
				tabletHovering = true
			end
		end
	else
		endTabletMoving()
	end
end
function drawRenderTarget(r0_30)
	-- line: [1035, 1743] id: 30
	dxSetRenderTarget(r16_0, true)
	local r16_30 = nil	-- notice: implicit variable refs by block#[282]
	local r19_30 = nil	-- notice: implicit variable refs by block#[298]
	local r21_30 = nil	-- notice: implicit variable refs by block#[301, 304]
	if r18_0 == "home" then
		local r1_30 = -r30_0 * (math.floor(getTickCount() / 250) * 250 % 30000 / 30000)
		--iprint(r30_0, r1_30)
		dxDrawText(r29_0, r1_30, 24, 0, 48, 4294901760, 0.75, r8_0, "left", "center", false, false, false, true)
		dxDrawText(r29_0, r1_30 + r30_0, 24, 0, 48, 4294901760, 0.75, r8_0, "left", "center", false, false, false, true)
		dxDrawImage(80, 52, 640, 160, r28_0.urmamotoLogo, 0, 0, 0, 4294901760)
		local r2_30 = dxGetTextWidth("-", 0.75, r8_0)
		for r6_30 = 0, math.floor(r11_0 / r2_30), 1 do
			dxDrawText("-", r6_30 * r2_30, 234 - r10_0, 0, 0, 4294901760, 0.75, r8_0, "left", "top")
		end
		for r6_30 = -1, math.floor((r12_0 - 280) / r10_0) - 1, 1 do
			dxDrawText("|", r11_0 / 2, 256 + r10_0 * r6_30, r11_0 / 2, 0, 4294901760, 0.75, r8_0, "center", "top")
		end
		local r3_30 = 256 + r10_0 * 4
		dxDrawText(("Üzemanyag: %s/%s L"):format(math.floor(currentMineInventory.displayedFuelTankLevel * 10) / 10, fuelTankCapacity), 0, 256 - r10_0, 752, 0, 4294901760, 0.75, r8_0, "right", "top")
		dxDrawText(("Sínszál: %s/%s db"):format(math.floor(currentMineInventory.railIrons), 2 * railIronStack), 0, 256 + r10_0, 752, 0, 4294901760, 0.75, r8_0, "right", "top")
		dxDrawText(("Talpfa: %s/%s db"):format(math.floor(currentMineInventory.railWoods), 2 * railWoodStack), 0, 256 + r10_0 * 2, 752, 0, 4294901760, 0.75, r8_0, "right", "top")
		dxDrawText(("Lámpa: %s/%s db"):format(math.floor(currentMineInventory.mineLamps), 2 * mineLampStack), 0, 256, 752, 0, 4294901760, 0.75, r8_0, "right", "top")
		if currentMineInventory.dieselLoco then
			dxDrawText(("Mozdony: %s/%s L"):format(math.floor(locoDisplayedFuel / 100 * locoTankCapacity * 10) / 10, locoTankCapacity), 0, r3_30, 752, 0, 4294901760, 0.75, r8_0, "right", "top")
		else
			dxDrawText(("Kocsi 1: %s%%"):format(math.floor((cartMaxSlots[1] or 0) / #oreCartOffsets * 100 + 0.5)), 0, r3_30, 752, 0, 4294901760, 0.75, r8_0, "right", "top")
		end
		local r4_30 = currentMineInventory.dieselLoco
		if r4_30 then
			r4_30 = 1
		else
			r4_30 = 2
		end
		local r5_30 = currentMineInventory.subCartNum
		local r6_30 = currentMineInventory.dieselLoco
		if r6_30 then
			r6_30 = 0
		else
			r6_30 = 1
		end
		for r7_30 = r4_30, r5_30 + r6_30, 1 do
			dxDrawText(("Kocsi %s: %s%%"):format(r7_30, math.floor((cartMaxSlots[r7_30] or 0) / #oreCartOffsets * 100 + 0.5)), 0, r3_30 + r10_0, 752, 0, 4294901760, 0.75, r8_0, "right", "top")
			r3_30 = r3_30 + r10_0
		end
		r3_30 = 256 - r10_0
		r4_30 = r10_0 * 3.5
		r5_30 = math.floor(r4_30 / 0.44326 * 0.927294) + 12
		if currentNameLine or r33_0 == "editMineName" then
			drawBorder(48, r3_30, r5_30, r4_30, 3, 4294901760)
		else
			drawBorder(48, r3_30, r5_30, r4_30, 2, 4294901760)
		end
		if mineNameSyncing then
			r6_30 = math.floor(getTickCount() / 250) % 4
			if r6_30 == 0 then
				dxDrawText("|", 48, r3_30, 48 + r5_30, r3_30 + r4_30, 4294901760, 1, r8_0, "center", "center")
			elseif r6_30 == 1 then
				dxDrawText("/", 48, r3_30, 48 + r5_30, r3_30 + r4_30, 4294901760, 1, r8_0, "center", "center")
			elseif r6_30 == 2 then
				dxDrawText("-", 48, r3_30, 48 + r5_30, r3_30 + r4_30, 4294901760, 1, r8_0, "center", "center")
			else
				dxDrawText("\\", 48, r3_30, 48 + r5_30, r3_30 + r4_30, 4294901760, 1, r8_0, "center", "center")
			end
		else
			r6_30 = r3_30 + r4_30 / 2 - r10_0 * #currentMineName / 2
			for r10_30 = 1, #currentMineName, 1 do
				local r11_30 = utf8.upper(currentMineName[r10_30])
				local r12_30 = utf8.len(r11_30)
				if r11_30 then
					local r13_30 = r10_0 / 64
					local r14_30 = 0
					local r15_30 = 28
					for r19_30 = 1, r12_30, 1 do
						r21_30 = charset[utf8.sub(r11_30, r19_30, r19_30)]
						if r21_30 then
							r14_30 = r14_30 + r21_30[2] * r13_30
						else
							r14_30 = r14_30 + r15_30 * r13_30
						end
					end
					r16_30 = 48 + r5_30 / 2 - r14_30 / 2
					for r20_30 = 1, r12_30, 1 do
						r21_30 = utf8.sub(r11_30, r20_30, r20_30)
						local r22_30 = charset[r21_30]
						if r22_30 then
							dxDrawImageSection(r16_30, r6_30, r22_30[2] * r13_30, r10_0, r22_30[1], 0, r22_30[2], 64, getTableTex(), 0, 0, 0, 4294901760)
							r16_30 = r16_30 + r22_30[2] * r13_30
						else
							r16_30 = r16_30 + r15_30 * r13_30
						end
					end
					if currentNameLine == r10_30 and r0_30 then
						dxDrawText("|", r16_30, r6_30, 0, r6_30, 4294901760, 1, r8_0, "left", "top")
					end
				end
				r6_30 = r6_30 + r10_0
			end
			if currentMineOwnerId == selfCharacterId then
				r19_0.editMineName = {
					48,
					r3_30,
					r5_30,
					r4_30
				}
			end
		end
		r3_30 = r3_30 + r4_30 + 20
		r6_30 = {
			{
				"ores",
				"Nyersanyagok"
			},
			{
				"map",
				"Feltérképezés"
			},
			{
				"permissions",
				"Jogosultságok"
			},
			{
				"shop",
				"Rendelés"
			}
		}
		local r7_30 = 48
		local r8_30 = r10_0 * 0.85 + 12
		dxDrawText("Kérlek válassz:", r7_30, r3_30, 0, 0, 4294901760, 0.75, r8_0, "left", "top")
		r3_30 = r3_30 + r10_0 + 6
		for r12_30 = 1, #r6_30, 1 do
			drawButton("menu." .. r6_30[r12_30][1], r7_30, r3_30, 24, r8_30, r6_30[r12_30][2])
			r3_30 = r3_30 + r8_30 + 12
		end
	elseif r18_0 == "ores" then
		local r1_30 = 0
		local r2_30 = 0
		for r6_30, r7_30 in pairs(oreTypes) do
			if not r7_30.fixedBasePrice and not r7_30.instantItem then
				if r7_30.meltingPoint then
					r2_30 = r2_30 + 1
				else
					r1_30 = r1_30 + 1
				end
			end
		end
		local r3_30 = 80
		local r4_30 = 120
		local r5_30 = 32
		local r6_30 = 400 - (r3_30 + r5_30) * r1_30 / 2
		local r7_30 = 48
		local r8_30 = 400 - (r3_30 + r5_30) * r2_30 / 2
		local r9_30 = r7_30 + 16 + r4_30 + r5_30
		for r13_30, r14_30 in pairs(oreTypes) do
			if not r14_30.instantItem then
				local r15_30 = r14_30.meltingPoint
				if r15_30 then
					r15_30 = r8_30
				else
					r15_30 = r6_30
				end
				r16_30 = r14_30.meltingPoint
				if r16_30 then
					r16_30 = r9_30
				else
					r16_30 = r7_30
				end
				r15_30 = r15_30 + (r3_30 + r5_30) / 2
				if r14_30.meltingPoint then
					local r17_30 = 4278255360
					if mineFoundryData.meltingOre == r13_30 or mineFoundryData.furnaceRunning == r13_30 then
						if mineFoundryData.meltProgress >= 1 then
							if r0_30 then
								r17_30 = 4278190335
							else
								r17_30 = 4278255360
							end
						else
							r17_30 = 4278190335
						end
					end
					local r18_30 = r14_30.displayedFoundryContent
					if r18_30 >= 100 then
						r19_30 = math.floor(r18_30)
						r18_30 = r19_30
					else
						r19_30 = math.floor(r18_30 * 10)
						r18_30 = r19_30 / 10
					end
					r18_30 = math.max(0, r18_30)
					dxDrawImage(r8_30 + 16, r9_30, r3_30, r4_30, r28_0.siloIcon, 0, 0, 0, 4294901760)
					dxDrawText("Kohó", r15_30, r9_30 + r4_30 + 16, r15_30, r9_30 + r4_30 + 32, r17_30, 0.75, r8_0, "center", "center")
					dxDrawImage(r8_30 + 16, r9_30 + r4_30 + 32, r3_30, r4_30, r28_0.smelterIcon, 0, 0, 0, r17_30)
					dxDrawText(r18_30 .. "\nrúd", r8_30 + 49.75, r9_30 + r4_30 + 32 + 55, r8_30 + 49.75, r9_30 + r4_30 + 32 + 55, r17_30, 0.75, r8_0, "center", "center")
					r19_30 = mineFoundryData.meltingOre
					if r19_30 ~= r13_30 then
						r19_30 = mineFoundryData.furnaceRunning
						if r19_30 == r13_30 then
							r19_30 = calculateFurnaceTemperature(r14_30.furnaceTemperature, r14_30.meltingPoint, getTickCount())
							if r19_30 > 50 then
								local r20_30 = math.floor(r19_30)
								r21_30 = " C"
								r19_30 = r20_30 .. r21_30
							elseif r0_30 then
								r19_30 = "----"
							else
								r19_30 = ""
							end
							dxDrawText(r19_30, r8_30 + 49.75, r9_30 + r4_30 + 32 + r4_30 + 8, r8_30 + 49.75, 0, r17_30, 0.75, r8_0, "center", "top")
						end
					end
					r19_30 = r8_30 + r3_30
					r8_30 = r19_30 + r5_30
				else
					dxDrawImage(r6_30 + 16, r7_30, r3_30, r4_30, r28_0.siloIcon, 0, 0, 0, 4294901760)
					r6_30 = r6_30 + r3_30 + r5_30
				end
				local r17_30 = r14_30.bufferContent
				r19_30 = r14_30.boxContent
				if r14_30.displayedBoxContent < r19_30 then
					r19_30 = r14_30.displayedBoxContent
					r17_30 = r17_30 + r14_30.boxContent - r19_30
				end
				if r17_30 >= 100 then
					r17_30 = math.floor(r17_30)
				else
					r17_30 = math.floor(r17_30 * 10) / 10
				end
				dxDrawText(r14_30.displayName, r15_30, r16_30 - 16, r15_30, r16_30, 4294901760, 0.75, r8_0, "center", "center")
				dxDrawText(math.max(0, r17_30) .. "\nadag", r15_30, r16_30 + 41.875, r15_30, r16_30 + 41.875, 4294901760, 0.75, r8_0, "center", "center")
				r19_30 = math.floor(r14_30.displayedBoxContent * 100)
				dxDrawText(r19_30 .. "%", r15_30, 0, r15_30, r16_30 + 111.25, 4294901760, 0.75, r8_0, "center", "bottom")
			end
		end
	else
		local r26_30 = nil	-- notice: implicit variable refs by block#[191, 323, 326]
		if r18_0 == "map" then
			local r1_30 = 32 * r25_0
			local r2_30 = math.ceil(r11_0 / r1_30 / 2)
			local r3_30 = math.ceil(r12_0 / r1_30 / 2)
			local r4_30 = r11_0 / 2
			local r5_30 = r12_0 / 2
			local r6_30 = r26_0
			if r6_30 then
				r6_30 = r26_0[1] or selfMineX
			else
				r6_30 = selfMineX
			end
			local r7_30 = r26_0
			if r7_30 then
				r7_30 = r26_0[2] or selfMineY
			else
				r7_30 = selfMineY
			end
			local r8_30 = {}
			if not r0_30 then
				for r12_30 in pairs(threeJunctionBombs) do
					for r16_30 in pairs(threeJunctionBombs[r12_30]) do
						setTabletBomb(r8_30, r12_30, r16_30)
					end
				end
				for r12_30, r13_30 in pairs(openShaftBombs) do
					setTabletBomb(r8_30, convertMineCoordinates(r13_30[5], r13_30[6]))
				end
				for r12_30 in pairs(shaftBombs) do
					local r13_30 = pairs
					for r16_30 in r13_30(shaftBombs[r12_30]) do
						for r20_30, r21_30 in pairs(shaftBombs[r12_30][r16_30]) do
							setTabletBomb(r8_30, convertMineCoordinates(r21_30[5], r21_30[6]))
						end
					end
				end
			end
			local r9_30 = 4294901760
			local r10_30 = 4278255360
			local r11_30 = 4278190335
			for r15_30 = -r3_30, r3_30, 1 do
				r16_30 = r15_30 + r6_30
				local r17_30 = r5_30 - r15_30 * r1_30 - r1_30 / 2
				if r8_30[r16_30] then
					for r21_30 = -r2_30, r2_30, 1 do
						local r23_30 = r4_30 - r21_30 * r1_30 - r1_30 / 2
						if r8_30[r16_30][r21_30 + r7_30] then
							dxDrawRectangle(r23_30, r17_30, r1_30, r1_30, r11_30)
						end
					end
				end
				if tunnelObjectRots[r16_30] or junctionObjects[r16_30] or r27_0[r16_30] then
					for r21_30 = -r2_30, r2_30, 1 do
						local r22_30 = r21_30 + r7_30
						local r23_30 = r4_30 - r21_30 * r1_30 - r1_30 / 2
						if r27_0[r16_30] and r27_0[r16_30][r22_30] then
							dxDrawImage(r23_30, r17_30, r1_30, r1_30, r28_0["mapPiece" .. r27_0[r16_30][r22_30][1]], r27_0[r16_30][r22_30][2], 0, 0, r9_30)
						elseif tunnelObjectRots[r16_30] and tunnelObjectRots[r16_30][r22_30] then
							if openShaftsAt[r16_30] and openShaftsAt[r16_30][r22_30] then
								dxDrawImage(r23_30, r17_30, r1_30, r1_30, r28_0.mapPiece4, -tunnelObjectRots[r16_30][r22_30], 0, 0, r9_30)
							else
								dxDrawImage(r23_30, r17_30, r1_30, r1_30, r28_0.mapPiece1, tunnelObjectRots[r16_30][r22_30], 0, 0, r9_30)
							end
						elseif threeJunctionsAt[r16_30] and threeJunctionsAt[r16_30][r22_30] then
							dxDrawImage(r23_30, r17_30, r1_30, r1_30, r28_0.mapPiece2, -threeJunctionRots[r16_30][r22_30] + 180, 0, 0, r9_30)
						elseif junctionObjects[r16_30] and junctionObjects[r16_30][r22_30] then
							dxDrawImage(r23_30, r17_30, r1_30, r1_30, r28_0.mapPiece3, 0, 0, 0, r9_30)
						end
					end
				end
				if railsAt[r16_30] or railSwitchesAt[r16_30] then
					for r21_30 = -r2_30, r2_30, 1 do
						local r22_30 = r21_30 + r7_30
						local r23_30 = r4_30 - r21_30 * r1_30 - r1_30 / 2
						if railsAt[r16_30] and railsAt[r16_30][r22_30] then
							local r25_30 = railTracks[railsAt[r16_30][r22_30]]
							if r16_30 == -4 then
								dxDrawImage(r23_30, r17_30, r1_30, r1_30, r28_0.mapPiece6, 0, 0, 0, r10_30)
							else
								r26_30 = railEndsAt[r16_30]
								if r26_30 then
									r26_30 = railEndsAt[r16_30][r22_30]
									if r26_30 then
										dxDrawImage(r23_30, r17_30, r1_30, r1_30, r28_0.mapPiece6, -r25_30.angleDeg + 180, 0, 0, r10_30)
									end
								else
									dxDrawImage(r23_30, r17_30, r1_30, r1_30, r28_0.mapPiece5, r25_30.angleDeg, 0, 0, r10_30)
								end
							end
						else
							local r24_30 = railSwitchesAt[r16_30] and railSwitchesAt[r16_30][r22_30]
							if r24_30 then
								local r25_30 = railSwitches[r24_30]
								if r25_30 then
									dxDrawImage(r23_30, r17_30, r1_30, r1_30, r28_0["mapPiece" .. #r25_30.trackIds + 5], -r25_30.angleDeg + 180, 0, 0, r10_30)
								end
							end
						end
					end
				end
			end
			local r12_30 = r1_30 * 0.25
			if r0_30 then
				local r13_30, r14_30 = getRelativeFirstRailCarPosition()
				dxDrawRectangle(r4_30 - (selfMineY - r7_30) * r1_30 - r12_30 / 2, r5_30 - (selfMineX - r6_30) * r1_30 - r12_30 / 2, r12_30, r12_30, 4278190335)
				dxDrawRectangle(r4_30 - (r14_30 - r7_30) * r1_30 - r12_30 / 2, r5_30 - (r13_30 - r6_30) * r1_30 - r12_30 / 2, r12_30, r12_30, 4278255360)
				dxDrawRectangle(30, 30, r12_30, r12_30, 4278190335)
				dxDrawRectangle(30, 60, r12_30, r12_30, 4278255360)
			end
			dxDrawText("Tartózkodási helyed", 46, 30, 0, 38, 4278190335, 0.75, r8_0, "left", "center")
			dxDrawText("Bányavonat helyzete", 46, 60, 0, 68, 4278255360, 0.75, r8_0, "left", "center")
			local r13_30 = r10_0 * 0.75 + 8
			local r14_30 = 752
			local r15_30 = 552
			drawButton("mapZoom.-1", r14_30 - r13_30 * 4 - 24, r15_30 - r13_30, r13_30, r13_30, "-", 0.75, true)
			drawButton("mapZoom.1", r14_30 - r13_30 * 4 - 24, r15_30 - r13_30 * 2 - 6, r13_30, r13_30, "+", 0.75, true)
			drawButton("mapMove.1.-1", r14_30 - r13_30 * 2 - 6, r15_30 - r13_30, r13_30, r13_30, "\\/", 0.75, true)
			drawButton("mapMove.2.-1", r14_30 - r13_30, r15_30 - r13_30 * 2 - 6, r13_30, r13_30, ">", 0.75, true)
			r16_30 = r26_0
			if r16_30 then
				drawButton("mapCenter", r14_30 - r13_30 * 2 - 6, r15_30 - r13_30 * 2 - 6, r13_30, r13_30, "O", 0.75, true)
			end
			drawButton("mapMove.1.1", r14_30 - r13_30 * 2 - 6, r15_30 - r13_30 * 3 - 12, r13_30, r13_30, "/\\", 0.75, true)
			drawButton("mapMove.2.1", r14_30 - r13_30 * 3 - 12, r15_30 - r13_30 * 2 - 6, r13_30, r13_30, "<", 0.75, true)
		elseif r18_0 == "permissions" then
			local r1_30 = 48
			local r2_30 = 48
			local r3_30 = r10_0 * 0.85 + 6
			dxDrawText("Munkások:", r1_30, r2_30, 0, r2_30 + r3_30, 4294901760, 0.85, r8_0, "left", "center")
			r2_30 = r2_30 + r3_30
			local r4_30 = dxGetTextWidth("-", 0.75, r8_0)
			local r5_30 = r4_30 / 1.5
			for r9_30 = 0, math.floor(r11_0 / r4_30), 1 do
				dxDrawText("-", r9_30 * r4_30, r2_30, 0, r2_30 + r10_0, 4294901760, 0.75, r8_0, "left", "center")
			end
			r2_30 = r2_30 + r10_0
			local r6_30 = 250
			local r7_30 = r3_30 - 4
			for r11_30 = 1, #currentMineWorkersList, 1 do
				local r12_30 = currentMineWorkersList[r11_30]
				local r13_30 = currentMineWorkers[r12_30]:gsub("_", " ")
				if currentMineOwnerId == selfCharacterId then
					drawRedButton("fireWorker." .. r12_30, r1_30, r2_30 + (r3_30 - r7_30) / 2, r7_30, r7_30, "x", false, true)
					dxDrawText(r13_30, r1_30 + r7_30 + 4, r2_30, r1_30 + r7_30 + 4 + r6_30, r2_30 + r3_30, 4294901760, 0.85, r8_0, "left", "center", true)
				else
					dxDrawText(r13_30, r1_30, r2_30, r1_30 + r6_30, r2_30 + r3_30, 4294901760, 0.85, r8_0, "left", "center", true)
				end
				for r17_30 = 1, #permissionList, 1 do
					local r18_30 = permissionList[r17_30]
					if r18_30 then
						r19_30 = bitTest
						r19_30 = r19_30(r37_0[r12_30] or currentMinePermissions[r12_30], permissionFlags[r18_30])
						local r20_30 = drawButton
						r21_30 = "setPermission." .. r12_30 .. "." .. r17_30
						local r22_30 = r11_0 - 48 - (r7_30 + 4) * (#permissionList - r17_30 + 1)
						local r23_30 = r2_30 + (r3_30 - r7_30) / 2
						local r24_30 = r7_30
						local r25_30 = r7_30
						if r19_30 then
							r26_30 = "x"
						else
							r26_30 = " "
						end
						r20_30(r21_30, r22_30, r23_30, r24_30, r25_30, r26_30, 0.85, true)
					end
				end
				if r11_30 < #currentMineWorkersList then
					r2_30 = r2_30 + r3_30 + 3
					for r17_30 = 0, math.floor((r11_0 - 96) / r5_30), 1 do
						dxDrawText("-", r1_30 + r17_30 * r5_30, r2_30, 0, r2_30 + r3_30 / 5, 4294901760, 0.5, r8_0, "left", "center")
					end
					r2_30 = r2_30 + r3_30 / 5 + 3
				else
					r2_30 = r2_30 + r3_30 + 12
				end
			end
			if currentMineOwnerId == selfCharacterId then
				local r8_30 = 400
				local r9_30 = 200
				local r10_30 = (r11_0 - r8_30) / 2
				local r11_30 = (r12_0 - r9_30) / 2
				local r12_30 = 12
				local r13_30 = r10_0 * 0.85 + r12_30
				local r14_30 = (r8_30 - r12_30 * 3) / 2
				r16_30 = maxWorkers
				if #currentMineWorkersList < r16_30 then
					drawButton("addWorker", r1_30, r2_30, 24, r3_30 + 6, "Munkás regisztrálása")
				end
				if r35_0 then
					dxDrawRectangle(r10_30, r11_30, r8_30, r9_30, 4278190080)
					drawBorder(r10_30, r11_30, r8_30, r9_30, 2, 4294901760)
					if isElement(r35_0) then
						dxDrawText("Biztosan szeretnéd felvenni " .. getElementData(r35_0, "visibleName"):gsub("_", " ") .. " munkást?", r10_30 + r12_30, r11_30, r10_30 + r8_30 - r12_30, r11_30 + r9_30 - r13_30 - r12_30 * 2, 4294901760, 0.85, r8_0, "center", "center", false, true)
						drawButton("promptYes", r10_30 + r12_30, r11_30 + r9_30 - r13_30 - r12_30, r14_30, r13_30, "Igen", 0.85, true)
						drawButton("promptNo", r10_30 + r12_30 * 2 + r14_30, r11_30 + r9_30 - r13_30 - r12_30, r14_30, r13_30, "Nem", 0.85, true)
					else
						local r15_30 = r11_30 + r13_30 * 2
						r16_30 = dxGetTextWidth(r36_0, 0.85, r8_0)
						dxDrawText("Játékos név/id:", r10_30 + r12_30, r11_30, 0, r15_30, 4294901760, 0.85, r8_0, "left", "center")
						drawBorder(r10_30 + r12_30, r15_30, r8_30 - r12_30 * 2, r13_30, 2, 4294901760)
						local r17_30 = dxDrawText
						local r18_30 = r36_0
						r19_30 = r10_30 + r12_30 * 1.5
						local r20_30 = r15_30
						r21_30 = r10_30 + r8_30 - r12_30 * 1.5
						local r22_30 = r15_30 + r13_30
						local r23_30 = 4294901760
						local r24_30 = 0.85
						local r25_30 = r8_0
						r26_30 = r8_30 - r12_30 * 1.5
						if r16_30 < r26_30 then
							r26_30 = "left"
						else
							r26_30 = "right"
						end
						r17_30(r18_30, r19_30, r20_30, r21_30, r22_30, r23_30, r24_30, r25_30, r26_30, "center", true)
						if r0_30 then
							dxDrawText("|", r10_30 + r12_30 * 1.5 + math.min(r16_30, r8_30 - r12_30 * 3.5), r15_30, 0, r15_30 + r13_30, 4294901760, 1, r8_0, "left", "center")
						end
						drawButton("promptYes", r10_30 + r12_30, r11_30 + r9_30 - r13_30 - r12_30, r14_30, r13_30, "Regisztráció", 0.85, true)
						drawButton("promptNo", r10_30 + r12_30 * 2 + r14_30, r11_30 + r9_30 - r13_30 - r12_30, r14_30, r13_30, "Mégsem", 0.85, true)
					end
				elseif r34_0 then
					r16_30 = r34_0
					local r15_30 = currentMineWorkers[r16_30]
					if r15_30 then
						dxDrawRectangle(r10_30, r11_30, r8_30, r9_30, 4278190080)
						drawBorder(r10_30, r11_30, r8_30, r9_30, 2, 4294901760)
						dxDrawText("Biztosan szeretnéd kirúgni " .. r15_30 .. " munkást?", r10_30 + r12_30, r11_30, r10_30 + r8_30 - r12_30, r11_30 + r9_30 - r13_30 - r12_30 * 2, 4294901760, 0.85, r8_0, "center", "center", false, true)
						drawButton("promptYes", r10_30 + r12_30, r11_30 + r9_30 - r13_30 - r12_30, r14_30, r13_30, "Igen", 0.85, true)
						drawButton("promptNo", r10_30 + r12_30 * 2 + r14_30, r11_30 + r9_30 - r13_30 - r12_30, r14_30, r13_30, "Nem", 0.85, true)
					else
						r34_0 = false
						r16_30 = true
						shouldRefreshUrmaMotoDevice = r16_30
					end
				end
			end
		elseif r18_0 == "shop" then
			local lineY = 48
			local lineHeight = r10_0 * 0.85 + 12
			if currentMineInventory.tankOutside then
				dxDrawText("Az üzemanyagtartály szállítás alatt", 48, lineY, 0, lineY + lineHeight, tocolor(255, 0, 0), 0.9, r8_0, "left", "center")
			else
				local r3_49 = "Üzemanyagtartály: " .. math.floor(currentMineInventory.displayedFuelTankLevel * 10) / 10 .. "/1000 L"
				local r4_49 = dxGetTextWidth(r3_49, 0.9, r8_0) + 12
				dxDrawText(r3_49, 48, lineY, 0, lineY + lineHeight, tocolor(255, 0, 0), 0.9, r8_0, "left", "center")
				if tankPreRequest == currentMine then
					drawRedButton("requestFuelTank", 48 + r4_49, lineY, 24, lineHeight, "Feltöltés megszakítása")
				else
          			drawButton("requestFuelTank", 48 + r4_49, 48, 24, lineHeight, "Tartály feltöltése")
				end
				lineY = lineY + lineHeight + 6
			end
			local hyphenWidth = dxGetTextWidth("-", 0.75, r8_0)
			for i = 0, math.floor(800 / hyphenWidth), 1 do
				dxDrawText("-", i * hyphenWidth, lineY, 0, lineY + r10_0, tocolor(255, 0, 0), 0.75, r8_0, "left", "center")
			end
			lineY = lineY + r10_0 + 24
			local w1 = dxGetTextWidth("Megnevezés", 0.9, r8_0) + 32
			local w2 = dxGetTextWidth("Raktár", 0.9, r8_0) + 32
			local w3 = dxGetTextWidth("Rendelés", 0.9, r8_0) + 40
			local w4 = dxGetTextWidth("Egységár", 0.9, r8_0) + 48
			local lineX = 400 - (w1 + w2 + w3 + w4 * 2) / 2
			dxDrawText("Megnevezés", lineX, lineY, lineX + w1, lineY + r10_0, tocolor(255, 0, 0), 0.9, r9_0, "center", "center")
			dxDrawText("Raktár", lineX + w1, lineY, lineX + w1 + w2, lineY + r10_0, tocolor(255, 0, 0), 0.9, r9_0, "center", "center")
			dxDrawText("Rendelés", lineX + w1 + w2, lineY, lineX + w1 + w2 + w3, lineY + r10_0, tocolor(255, 0, 0), 0.9, r9_0, "center", "center")
			dxDrawText("Egységár", lineX + w1 + w2 + w3, lineY, lineX + w1 + w2 + w3 + w4, lineY + r10_0, tocolor(255, 0, 0), 0.9, r9_0, "center", "center")
			dxDrawText("Fizetendö", lineX + w1 + w2 + w3 + w4, lineY, lineX + w1 + w2 + w3 + w4 * 2, lineY + r10_0, tocolor(255, 0, 0), 0.9, r9_0, "center", "center")
			lineY = lineY + r10_0
			local hyphenWidth = dxGetTextWidth("-", 0.75, r8_0)
			for i = 0, math.floor((w1 + w2 + w3 + w4 * 2) / hyphenWidth), 1 do
				dxDrawText("-", lineX + i * hyphenWidth, lineY, 0, lineY + r10_0, tocolor(255, 0, 0), 0.75, r8_0, "left", "center")
			end
			if mineOrderSyncing then
				lineY = lineY + r10_0
				local r10_49 = math.floor(getTickCount() / 250) % 4
				if r10_49 == 0 then
					dxDrawText("|", 0, lineY, 800, 0, tocolor(255, 0, 0), 1, r8_0, "center", "top")
				elseif r10_49 == 1 then
					dxDrawText("/", 0, lineY, 800, 0, tocolor(255, 0, 0), 1, r8_0, "center", "top")
				elseif r10_49 == 2 then
					dxDrawText("-", 0, lineY, 800, 0, tocolor(255, 0, 0), 1, r8_0, "center", "top")
				else
					dxDrawText("\\", 0, lineY, 800, 0, tocolor(255, 0, 0), 1, r8_0, "center", "top")
				end
			else
				local maxSubCart = currentMineInventory.dieselLoco and 6 or 1
				local canOrder = false 
				if currentMineOrdering.subCartNum then
					canOrder = {
						subCartNum = currentMineInventory.subCartNum + (currentMineOrdering.subCartNum or 0) < maxSubCart and (currentMineOrdering.subCartNum or 0) < #trailerOffsets.subCartNum
					}
				elseif not currentMineOrdering.dieselLoco and not currentMineOrder then
					canOrder = {
						railIron = math.ceil(currentMineInventory.railIrons / 50) + (currentMineOrdering.railIrons or 0) < 2 and (currentMineOrdering.railIrons or 0) < #trailerOffsets.railIrons - (currentMineOrdering.railWoods or 0),
						railWood = math.ceil(currentMineInventory.railWoods / 125) + (currentMineOrdering.railWoods or 0) < 2 and (currentMineOrdering.railWoods or 0) < #trailerOffsets.railWoods - (currentMineOrdering.railIrons or 0),
						mineLamps = math.ceil(currentMineInventory.mineLamps / 20) + (currentMineOrdering.mineLamps or 0) < 2 and (currentMineOrdering.mineLamps or 0) < #trailerOffsets.mineLamps,
						dieselLoco = (currentMineInventory.dieselLoco and 1 or 0) + (currentMineOrdering.dieselLoco or 0) < 1 and (currentMineOrdering.dieselLoco or 0) < #trailerOffsets.dieselLoco,
						subCartNum = currentMineInventory.subCartNum + (currentMineOrdering.subCartNum or 0) < maxSubCart and (currentMineOrdering.subCartNum or 0) < #trailerOffsets.subCartNum,
					}
					if currentMineOrdering.railIrons or currentMineOrdering.railWoods then
						canOrder.mineLamps = false
						canOrder.dieselLoco = false
						canOrder.subCartNum = false
					elseif currentMineOrdering.mineLamps then
						canOrder.railIron = false
						canOrder.railWood = false
						canOrder.dieselLoco = false
						canOrder.subCartNum = false
					end
				end
				local r12_49 = r10_0 * 0.75 + 8
				lineY = lineY + r10_0 + 8
				if not currentMineOrder or currentMineOrder.railIron then
					local r13_49 = currentMineOrder and currentMineOrder.railIron or currentMineOrdering.railIrons or 0
					dxDrawText("Sínszál", lineX, lineY, lineX + w1, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(math.ceil(currentMineInventory.railIrons / 50) .. "/2 doboz", lineX + w1, lineY, lineX + w1 + w2, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(r13_49, lineX + w1 + w2, lineY, lineX + w1 + w2 + w3, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(exports.sGui:thousandsStepper(railIronPrice) .. " $", lineX + w1 + w2 + w3, lineY, lineX + w1 + w2 + w3 + w4, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(exports.sGui:thousandsStepper(railIronPrice * r13_49) .. " $", lineX + w1 + w2 + w3 + w4, lineY, lineX + w1 + w2 + w3 + w4 * 2, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					if 0 < (currentMineOrdering.railIrons or 0) and not currentMineOrder then
						drawButton("orderMinus." .. "railIrons", lineX + w1 + w2 + w3 / 2 - r12_49 * 1.75, lineY + r10_0 / 2 - r12_49 / 2, r12_49, r12_49, "-", 0.75, true)
					end
					if canOrder and canOrder.railIron then
						drawButton("orderPlus." .. "railIrons", lineX + w1 + w2 + w3 / 2 + r12_49 * 0.75, lineY + r10_0 / 2 - r12_49 / 2, r12_49, r12_49, "+", 0.75, true)
					end
					lineY = lineY + r10_0 + 8
				end
				if not currentMineOrder or currentMineOrder.railWood then
					local r13_49 = currentMineOrder and currentMineOrder.railWood or currentMineOrdering.railWoods or 0
					dxDrawText("Talpfa", lineX, lineY, lineX + w1, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(math.ceil(currentMineInventory.railWoods / 125) .. "/2 doboz", lineX + w1, lineY, lineX + w1 + w2, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(r13_49, lineX + w1 + w2, lineY, lineX + w1 + w2 + w3, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(exports.sGui:thousandsStepper(railWoodPrice) .. " $", lineX + w1 + w2 + w3, lineY, lineX + w1 + w2 + w3 + w4, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(exports.sGui:thousandsStepper(railWoodPrice * r13_49) .. " $", lineX + w1 + w2 + w3 + w4, lineY, lineX + w1 + w2 + w3 + w4 * 2, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					if 0 < (currentMineOrdering.railWoods or 0) and not currentMineOrder then
						drawButton("orderMinus." .. "railWoods", lineX + w1 + w2 + w3 / 2 - r12_49 * 1.75, lineY + r10_0 / 2 - r12_49 / 2, r12_49, r12_49, "-", 0.75, true)
					end
					if canOrder and canOrder.railWood then
						drawButton("orderPlus." .. "railWoods", lineX + w1 + w2 + w3 / 2 + r12_49 * 0.75, lineY + r10_0 / 2 - r12_49 / 2, r12_49, r12_49, "+", 0.75, true)
					end
					lineY = lineY + r10_0 + 8
				end
				if not currentMineOrder or currentMineOrder.mineLamps then
					local r13_49 = currentMineOrder and currentMineOrder.mineLamps or currentMineOrdering.mineLamps or 0
					dxDrawText("Lámpa", lineX, lineY, lineX + w1, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(math.ceil(currentMineInventory.mineLamps / 20) .. "/2 doboz", lineX + w1, lineY, lineX + w1 + w2, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(r13_49, lineX + w1 + w2, lineY, lineX + w1 + w2 + w3, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(exports.sGui:thousandsStepper(mineLampPrice) .. " $", lineX + w1 + w2 + w3, lineY, lineX + w1 + w2 + w3 + w4, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(exports.sGui:thousandsStepper(mineLampPrice * r13_49) .. " $", lineX + w1 + w2 + w3 + w4, lineY, lineX + w1 + w2 + w3 + w4 * 2, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					if 0 < (currentMineOrdering.mineLamps or 0) and not currentMineOrder then
						drawButton("orderMinus." .. "mineLamps", lineX + w1 + w2 + w3 / 2 - r12_49 * 1.75, lineY + r10_0 / 2 - r12_49 / 2, r12_49, r12_49, "-", 0.75, true)
					end
					if canOrder and canOrder.mineLamps then
						drawButton("orderPlus." .. "mineLamps", lineX + w1 + w2 + w3 / 2 + r12_49 * 0.75, lineY + r10_0 / 2 - r12_49 / 2, r12_49, r12_49, "+", 0.75, true)
					end
					lineY = lineY + r10_0 + 8
				end
				if not currentMineOrder or currentMineOrder.dieselLoco then
					local r13_49 = currentMineOrder and currentMineOrder.dieselLoco or currentMineOrdering.dieselLoco or 0
					dxDrawText("MiguMoto\nmozdony", lineX, lineY, lineX + w1, lineY + r10_0 * 2, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText((currentMineInventory.dieselLoco and 1 or 0) .. "/1", lineX + w1, lineY, lineX + w1 + w2, lineY + r10_0 * 2, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(r13_49, lineX + w1 + w2, lineY, lineX + w1 + w2 + w3, lineY + r10_0 * 2, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(exports.sGui:thousandsStepper(dieselLocoPrice) .. " PP", lineX + w1 + w2 + w3, lineY, lineX + w1 + w2 + w3 + w4, lineY + r10_0 * 2, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(exports.sGui:thousandsStepper(dieselLocoPrice * r13_49) .. " PP", lineX + w1 + w2 + w3 + w4, lineY, lineX + w1 + w2 + w3 + w4 * 2, lineY + r10_0 * 2, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					if 0 < (currentMineOrdering.dieselLoco or 0) and not currentMineOrder then
						drawButton("orderMinus." .. "dieselLoco", lineX + w1 + w2 + w3 / 2 - r12_49 * 1.75, lineY + r10_0 - r12_49 / 2, r12_49, r12_49, "-", 0.75, true)
					end
					if canOrder and canOrder.dieselLoco then
						drawButton("orderPlus." .. "dieselLoco", lineX + w1 + w2 + w3 / 2 + r12_49 * 0.75, lineY + r10_0 - r12_49 / 2, r12_49, r12_49, "+", 0.75, true)
					end
					lineY = lineY + r10_0 * 2 + 8
				end
				if not currentMineOrder or currentMineOrder.subCartNum then
					local r13_49 = currentMineOrder and currentMineOrder.subCartNum or currentMineOrdering.subCartNum or 0
					dxDrawText("Kocsi", lineX, lineY, lineX + w1, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(currentMineInventory.subCartNum + (currentMineInventory.dieselLoco and 0 or 1) .. "/" .. maxSubCart + (currentMineInventory.dieselLoco and 0 or 1), lineX + w1, lineY, lineX + w1 + w2, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(r13_49, lineX + w1 + w2, lineY, lineX + w1 + w2 + w3, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(exports.sGui:thousandsStepper(subRailCarPrice) .. " $", lineX + w1 + w2 + w3, lineY, lineX + w1 + w2 + w3 + w4, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					dxDrawText(exports.sGui:thousandsStepper(subRailCarPrice * r13_49) .. " $", lineX + w1 + w2 + w3 + w4, lineY, lineX + w1 + w2 + w3 + w4 * 2, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					if 0 < (currentMineOrdering.subCartNum or 0) and not currentMineOrder then
						drawButton("orderMinus." .. "subCartNum", lineX + w1 + w2 + w3 / 2 - r12_49 * 1.75, lineY + r10_0 / 2 - r12_49 / 2, r12_49, r12_49, "-", 0.75, true)
					end
					if canOrder and canOrder.subCartNum then
						drawButton("orderPlus." .. "subCartNum", lineX + w1 + w2 + w3 / 2 + r12_49 * 0.75, lineY + r10_0 / 2 - r12_49 / 2, r12_49, r12_49, "+", 0.75, true)
					end
					lineY = lineY + r10_0 + 8
				end
				lineY = lineY + 16
				local r13_49 = ""
				if currentMineOrder then
					local r14_49 = nil
					local r15_49 = nil
					r14_49, r15_49, r13_49 = getOrderPrice(currentMineOrder)
					dxDrawText("Végösszeg: " .. r13_49 .. (currentMineOrderPaid and " (fizetve)" or ""), 0, lineY, 800, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					lineY = lineY + r10_0
					dxDrawText("A rendelés átvehetö a Sight Mining Co. telephelyén.", 0, lineY, 800, lineY + r10_0, tocolor(255, 0, 0), 0.9, r8_0, "center", "center")
					lineY = lineY + r10_0 + 12
					if not currentMineOrderPaid then
						r17_49 = dxGetTextWidth("Rendelés lemondása", 0.85, r8_0) + 24
						drawRedButton("cancelOrder", (800 - dxGetTextWidth("Rendelés lemondása", 0.85, r8_0) + 24) / 2, lineY, 24, r10_0 * 0.85 + 12, "Rendelés lemondása")
					end
				else
					local r12_30, r13_30 = getOrderPrice(currentMineOrdering)
					if r12_30 > 0 then
						r14_30 = "Rendelés leadása (%s)"
						if r13_30 then
							r14_30 = r14_30:format(formatNumber(r12_30) .. " PP")
						else
							r14_30 = r14_30:format(formatNumber(r12_30) .. " $")
						end
						drawButton("createOrder", (800 - dxGetTextWidth(r14_30, 0.85, r8_0) + 24) / 2, lineY, 24, r10_0 * 0.85 + 12, r14_30)
					end
				end
			end
		end
	end
	local r1_30 = r10_0 * 0.85 + 12
	if r18_0 ~= "home" then
		drawButton("menu.home", 48, 568 - r1_30, 24, r1_30, "< Vissza")
	end
	dxSetRenderTarget()
end
function drawTablet()
	-- line: [1745, 1763] id: 31
	local r0_31 = r1_0 * r22_0
	local r1_31 = r11_0 * r0_31
	local r2_31 = r12_0 * r0_31
	local r3_31 = r20_0 - r1_31 / 2
	local r4_31 = r21_0 - r2_31 / 2
	local r5_31 = r3_31 - 200 * r0_31
	local r6_31 = r4_31 - 150 * r0_31
	local r7_31 = 1200 * r0_31
	local r8_31 = 900 * r0_31
	dxDrawImage(r5_31, r6_31, r7_31, r8_31, r28_0.tabletBackground)
	dxDrawImage(r3_31, r4_31, r1_31, r2_31, r15_0)
	dxDrawImage(r5_31, r6_31, r7_31, r8_31, r28_0.tabletForeground)
end
function drawComputer()
	-- line: [1765, 1794] id: 32
	local r0_32 = r1_0
	local r1_32 = screenWidth / 2 - r13_0 / 2 * r0_32
	local r2_32 = screenHeight / 2 - r14_0 / 2 * r0_32
	local r3_32 = r1_32 - 140 * r0_32
	local r4_32 = r2_32 - 214 * r0_32
	local r5_32 = 1080 * r0_32
	local r6_32 = 1080 * r0_32
	dxDrawImage(r3_32, r4_32, r5_32, r6_32, r28_0.computerBackground)
	local r7_32 = r11_0 * r0_32
	local r8_32 = r12_0 * r0_32
	if r7_0 < 1 then
		local r9_32 = math.min(1, r7_0 * 1.5)
		local r10_32 = r7_32 * (1 - math.min(1, r7_0 * 6))
		local r11_32 = r8_32 * (1 - math.min(1, r7_0 * 3))
		dxDrawImage(r1_32 + r10_32 / 2, r2_32 + r11_32 / 2, r7_32 - r10_32, r8_32 - r11_32, r15_0, 0, 0, 0, tocolor(255 * r9_32, 255 * r9_32, 255 * r9_32, r7_0))
	else
		dxDrawImage(r1_32, r2_32, r7_32, r8_32, r15_0)
	end
	dxDrawImage(r3_32, r4_32, r5_32, r6_32, r28_0.computerForeground)
end
function drawBorder(r0_33, r1_33, r2_33, r3_33, r4_33, r5_33)
	-- line: [1796, 1801] id: 33
	dxDrawRectangle(r0_33, r1_33, r2_33, r4_33, r5_33)
	dxDrawRectangle(r0_33, r1_33 + r3_33 - r4_33, r2_33, r4_33, r5_33)
	dxDrawRectangle(r0_33, r1_33, r4_33, r3_33, r5_33)
	dxDrawRectangle(r0_33 + r2_33 - r4_33, r1_33, r4_33, r3_33, r5_33)
end
function drawButton(r0_34, r1_34, r2_34, r3_34, r4_34, r5_34, r6_34, r7_34)
	-- line: [1803, 1821] id: 34
	if not r6_34 then
		r6_34 = 0.85
	end
	if not r7_34 then
		r3_34 = dxGetTextWidth(r5_34, r6_34, r8_0) + r3_34
	end
	if r0_34 and r33_0 == r0_34 then
		dxDrawRectangle(r1_34, r2_34, r3_34, r4_34, 4294901760)
		dxDrawText(r5_34, r1_34, r2_34, r1_34 + r3_34, r2_34 + r4_34, 4278190080, r6_34, r9_0, "center", "center")
	else
		drawBorder(r1_34, r2_34, r3_34, r4_34, 2, 4294901760)
		dxDrawText(r5_34, r1_34, r2_34, r1_34 + r3_34, r2_34 + r4_34, 4294901760, r6_34, r8_0, "center", "center")
	end
	if r0_34 then
		r19_0[r0_34] = {
			r1_34,
			r2_34,
			r3_34,
			r4_34
		}
	end
end
function drawRedButton(r0_35, r1_35, r2_35, r3_35, r4_35, r5_35, r6_35, r7_35)
	-- line: [1823, 1841] id: 35
	if not r6_35 then
		r6_35 = 0.85
	end
	if not r7_35 then
		r3_35 = dxGetTextWidth(r5_35, r6_35, r8_0) + r3_35
	end
	if r0_35 and r33_0 == r0_35 then
		dxDrawRectangle(r1_35, r2_35, r3_35, r4_35, 4278190335)
		dxDrawText(r5_35, r1_35, r2_35, r1_35 + r3_35, r2_35 + r4_35, 4278190080, r6_35, r9_0, "center", "center")
	else
		drawBorder(r1_35, r2_35, r3_35, r4_35, 2, 4278190335)
		dxDrawText(r5_35, r1_35, r2_35, r1_35 + r3_35, r2_35 + r4_35, 4278190335, r6_35, r8_0, "center", "center")
	end
	if r0_35 then
		r19_0[r0_35] = {
			r1_35,
			r2_35,
			r3_35,
			r4_35
		}
	end
end
function saveTabletPos()
	-- line: [1843, 1845] id: 36
end
function saveTabletZoom()
	-- line: [1847, 1849] id: 37
end
function setTabletBomb(r0_38, r1_38, r2_38, r3_38)
	-- line: [1851, 1866] id: 38
	if r3_38 then
		if not r0_38[r1_38] then
			r0_38[r1_38] = {}
		end
		r0_38[r1_38][r2_38] = true
	else
		for r7_38 = r1_38 - 2, r1_38 + 2, 1 do
			for r11_38 = r2_38 - 2, r2_38 + 2, 1 do
				if getDistanceBetweenPoints2D(r1_38, r2_38, r7_38, r11_38) <= 2 then
					setTabletBomb(r0_38, r7_38, r11_38, true)
				end
			end
		end
	end
end
function setTabletPresetMap(r0_39, r1_39, r2_39, r3_39)
	-- line: [1868, 1873] id: 39
	if not r27_0[r0_39] then
		r27_0[r0_39] = {}
	end
	r27_0[r0_39][r1_39] = {
		r2_39,
		r3_39
	}
end
setTabletPresetMap(-2, 0, 12, 90)
setTabletPresetMap(-2, -2, 11, 90)
setTabletPresetMap(-2, -1, 10, 90)
setTabletPresetMap(-2, 1, 10, 90)
setTabletPresetMap(-2, 2, 11, 0)
setTabletPresetMap(-6, 0, 12, 270)
setTabletPresetMap(-6, 2, 11, 270)
setTabletPresetMap(-6, 1, 10, 270)
setTabletPresetMap(-6, -1, 10, 270)
setTabletPresetMap(-6, -2, 11, 180)
setTabletPresetMap(-7, 0, 4, 180)
for r43_0 = 3, 5, 1 do
	setTabletPresetMap(-r43_0, -2, 10, 180)
	setTabletPresetMap(-r43_0, 2, 10, 0)
end
