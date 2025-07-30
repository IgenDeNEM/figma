local sightexports = {
	sWorkaround = false,
	sGui = false,
	sPattach = false,
	sMarkers = false,
	sas_vehiclemods = false,
	sWeather = false,
	sGroups = false,
	sChat = false,
	sCarshader = false,
	sCore = false,
	sVehiclenames = false
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
local sightlangGuiRefreshColors = function()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		refreshColors()
	end
end

addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local spraySanderQ = {
	0.70671125101686,
	-0.0054610971042183,
	0.078414476395553,
	0.70312200505759
}
local sprayGunCupQ = {
	0.94963309340626,
	0.17066805576273,
	-0.027293328159634,
	0.26138951181677
}
local sprayColorQ = {
	0.77596576566438,
	0.05805398519481,
	0.064098394408889,
	-0.62481858259345
}
local sprayBaseQ = {
	0.56787281841883,
	0.50841416086926,
	0.48228270955973,
	-0.43178570053719
}
local sprayGunQ = {
	0.76821355116556,
	-0.12022193861048,
	0.097221674067972,
	0.62124276363895
}
screenX, screenY = guiGetScreenSize()
computerColorScheme = {
	base = {
		59,
		119,
		188
	},
	taskbar = {
		40,
		100,
		150,
		200
	},
	window = {
		240,
		240,
		220
	},
	window2 = {
		180,
		180,
		160
	},
	window3 = {
		200,
		200,
		180
	},
	red = {
		222,
		72,
		43
	},
	blue = {
		59,
		119,
		188
	},
	green = {
		129,
		192,
		70
	},
	yellow = {
		252,
		207,
		3
	},
	red2 = {
		242,
		92,
		63
	},
	blue2 = {
		79,
		139,
		208
	},
	green2 = {
		149,
		212,
		90
	},
	yellow2 = {
		255,
		227,
		23
	},
	btn1 = {
		255,
		255,
		250
	},
	btn2 = {
		205,
		205,
		225
	}
}
local timedPaint = {}
local loaderIcon = false
local playerAlphaSet = false
local compressorState = false
local compressorStart = false
local compressorEnd = false
local compressorSound = false
local lastCompressor = 0
workshopObj = false
workshopMarker = false
workshopRented = false
workshopUpgrades = {}
workshopPoint = 0
workshopRatingNum = 0
workshopRatingSum = 0
workshopPermissions = false
isOwner = false
myCid = false
function isPlayerInWorkshop()
	if currentWorkshop then
		return true
	end
	return false
end
function getPlayerPermission(permission)
	if currentWorkshop then
		if isOwner then
			return true
		end
		if workshopPermissions and workshopPermissions[myCid] then
			local id = permissionIds[permission]
			return id and workshopPermissions[myCid][id]
		end
	end
	return false
end
addEvent("syncWorkshopPermissions", true)
addEventHandler("syncWorkshopPermissions", getRootElement(), function(ws, cid, dat)
	if ws == currentWorkshop and workshopPermissions then
		local was = workshopPermissions[cid]
		workshopPermissions[cid] = dat
		if (not dat or not was and dat) and openedComputerApp == "internet" and computerWindow and openedWebsite == "company" then
			createInternetWindow()
		end
	end
end)
addEvent("syncWorkshopUpgrades", true)
addEventHandler("syncWorkshopUpgrades", getRootElement(), function(ws, uid, dat)
	if ws == currentWorkshop and workshopUpgrades then
		local wasdas = workshopUpgrades[uid]
		workshopUpgrades[uid] = dat
		if (wasdas ~= dat) and openedComputerApp == "internet" and computerWindow and openedWebsite == "upgrade" then
			createInternetWindow()
		end
	end
end)
addEvent("syncWorkshopPointBuy", true)
addEventHandler("syncWorkshopPointBuy", getRootElement(), function(ws, point)
	if ws == currentWorkshop and workshopPoints then
		local wasdas = workshopPoints
		workshopPoints = point
		if (wasdas ~= dat) and openedComputerApp == "internet" and computerWindow and openedWebsite == "upgrade" then
			createInternetWindow()
		end
	end
end)
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
	sightexports.sWorkaround:setDisableDetach(true)
end)
local mixerFont = false
local mixerFontScale = false
loaderFont = false
loaderFontScale = false
green = false
red = false
grey1 = false
grey2 = false
function refreshColors()
	green = sightexports.sGui:getColorCode("sightgreen")
	red = sightexports.sGui:getColorCode("sightred")
	grey1 = sightexports.sGui:getColorCode("sightgrey1")
	grey2 = sightexports.sGui:getColorCode("sightgrey2")
	mixerFont = sightexports.sGui:getFont("12/Ubuntu-R.ttf")
	mixerFontScale = sightexports.sGui:getFontScale("12/Ubuntu-R.ttf")
	loaderFont = sightexports.sGui:getFont("20/BebasNeueBold.otf")
	loaderFontScale = sightexports.sGui:getFontScale("20/BebasNeueBold.otf")
end
local doors = {}
local ifps = {}
local segTexture = false
local gradTexture = false
local ledTexture = false
local dropTexture = false
local noiseTexture = false
local metalTexture = false
local alphaObj = false
local boothObj = false
local boothDoorObj = false
local paletteObj = false
local officeDoorObj = false
local officeDoorP = 0
local officeDoorState = 0
local mixerWindow = false
local mixerInput = false
local loadedMixerRecipe = false
local mixerX, mixerY, mixerZ = wsX - 0.6627, wsY - 7.415, wsZ + 1.0554
local mixerObject = false
local mixerRenderTarget = false
local mixerShader = false
local mixerColorOffets = {
	{
		-0.0085,
		-1.4177,
		0.5
	},
	{
		-0.0085,
		-1.2044,
		0.5
	},
	{
		-0.0085,
		-0.991,
		0.5
	},
	{
		-0.0085,
		-0.7777,
		0.5
	},
	{
		-0.0085,
		-0.5644,
		0.5
	},
	{
		-0.0085,
		-0.351,
		0.5
	},
	{
		-0.0085,
		-0.1377,
		0.5
	},
	{
		-0.0085,
		0.0757,
		0.5
	},
	{
		-0.0085,
		0.289,
		0.5
	},
	{
		-0.0085,
		0.5024,
		0.5
	},
	{
		-0.0085,
		0.7157,
		0.5
	},
	{
		-0.0085,
		0.929,
		0.5
	},
	{
		-0.0085,
		1.1424,
		0.5
	},
	{
		-0.0085,
		1.3557,
		0.5
	}
}
local mixerBaseOffsets = {
	{
		0.018,
		-2.0654,
		0.548
	},
	{
		0.018,
		-1.7126,
		0.548
	}
}
local mixerColorCasettes = {}
local mixerBaseCasettes = {}
local mixerPrimerCasette = false
colorPaletteTextures = {}
colorPaletteShaders = {}
colorBaseTextures = {}
colorBaseShaders = {}
colorPrimerTexture = false
colorPrimerShader = false
local mixerMaintenance = false
function processMixerMachineCasette(i)
	if i == 1 then
		if not mixerMaintenance or mixerMaintenance[i] then
			if not isElement(mixerPrimerCasette) then
				mixerPrimerCasette = createObject(models.spray_base_canister, mixerX + 0.018, mixerY - 2.4809, mixerZ + 0.548, 0, 0, 270)
				setElementCollisionsEnabled(mixerPrimerCasette, false)
				setElementInterior(mixerPrimerCasette, targetInt)
				setElementDimension(mixerPrimerCasette, currentWorkshop)
				if colorPrimerShader then
					engineApplyShaderToWorldTexture(colorPrimerShader, "base_canister_tag", mixerPrimerCasette)
				end
			end
			if mixerMaintenance and isElement(mixerMaintenance[i]) then
				sightexports.sPattach:attach(mixerPrimerCasette, mixerMaintenance[i], 24, -0.016094882674033, -0.027072481281135, 0.23904491647236, 0, 0, 0)
				sightexports.sPattach:setRotationQuaternion(mixerPrimerCasette, sprayBaseQ)
				sightexports.sPattach:disableScreenCheck(mixerPrimerCasette, true)
			else
				sightexports.sPattach:detach(mixerPrimerCasette)
				setElementPosition(mixerPrimerCasette, mixerX + 0.018, mixerY - 2.4809, mixerZ + 0.548)
				setElementRotation(mixerPrimerCasette, 0, 0, 270)
				setElementCollisionsEnabled(mixerPrimerCasette, false)
			end
		else
			if isElement(mixerPrimerCasette) then
				destroyElement(mixerPrimerCasette)
			end
			mixerPrimerCasette = nil
		end
	elseif i <= 3 then
		local j = i - 1
		if not mixerMaintenance or mixerMaintenance[i] then
			if not isElement(mixerBaseCasettes[j]) then
				mixerBaseCasettes[j] = createObject(models.spray_base_canister, mixerX + mixerBaseOffsets[j][1], mixerY + mixerBaseOffsets[j][2], mixerZ + mixerBaseOffsets[j][3], 0, 0, 270)
				setElementCollisionsEnabled(mixerBaseCasettes[j], false)
				setElementInterior(mixerBaseCasettes[j], targetInt)
				setElementDimension(mixerBaseCasettes[j], currentWorkshop)
				if colorBaseShaders[j] then
					engineApplyShaderToWorldTexture(colorBaseShaders[j], "base_canister_tag", mixerBaseCasettes[j])
				end
			end
			if mixerMaintenance and isElement(mixerMaintenance[i]) then
				sightexports.sPattach:attach(mixerBaseCasettes[j], mixerMaintenance[i], 24, -0.016094882674033, -0.027072481281135, 0.23904491647236, 0, 0, 0)
				sightexports.sPattach:setRotationQuaternion(mixerBaseCasettes[j], sprayBaseQ)
				sightexports.sPattach:disableScreenCheck(mixerBaseCasettes[j], true)
			else
				sightexports.sPattach:detach(mixerBaseCasettes[j])
				setElementPosition(mixerBaseCasettes[j], mixerX + mixerBaseOffsets[j][1], mixerY + mixerBaseOffsets[j][2], mixerZ + mixerBaseOffsets[j][3])
				setElementRotation(mixerBaseCasettes[j], 0, 0, 270)
				setElementCollisionsEnabled(mixerBaseCasettes[j], false)
			end
		else
			if isElement(mixerBaseCasettes[j]) then
				destroyElement(mixerBaseCasettes[j])
			end
			mixerBaseCasettes[j] = nil
		end
	else
		local j = i - 3
		if not mixerMaintenance or mixerMaintenance[i] then
			if not isElement(mixerColorCasettes[j]) then
				mixerColorCasettes[j] = createObject(models.spray_color_canister, mixerX + mixerColorOffets[j][1], mixerY + mixerColorOffets[j][2], mixerZ + mixerColorOffets[j][3], 0, 0, 270)
				setElementCollisionsEnabled(mixerColorCasettes[j], false)
				setElementInterior(mixerColorCasettes[j], targetInt)
				setElementDimension(mixerColorCasettes[j], currentWorkshop)
				if colorPaletteShaders[j] then
					engineApplyShaderToWorldTexture(colorPaletteShaders[j], "color_canister_tag", mixerColorCasettes[j])
				end
			end
			if mixerMaintenance and isElement(mixerMaintenance[i]) then
				sightexports.sPattach:attach(mixerColorCasettes[j], mixerMaintenance[i], 24, 0.01537618291949, -0.0062368490559353, 0.21705975436459, 0, 0, 0)
				sightexports.sPattach:setRotationQuaternion(mixerColorCasettes[j], sprayColorQ)
				sightexports.sPattach:disableScreenCheck(mixerColorCasettes[j], true)
			else
				sightexports.sPattach:detach(mixerColorCasettes[j])
				setElementPosition(mixerColorCasettes[j], mixerX + mixerColorOffets[j][1], mixerY + mixerColorOffets[j][2], mixerZ + mixerColorOffets[j][3])
				setElementRotation(mixerColorCasettes[j], 0, 0, 270)
				setElementCollisionsEnabled(mixerColorCasettes[j], false)
			end
		else
			if isElement(mixerColorCasettes[j]) then
				destroyElement(mixerColorCasettes[j])
			end
			mixerColorCasettes[j] = nil
		end
	end
end
playerHoldingCasette = false
addEvent("refreshPaintShopMixerMaintenanceAll", true)
addEventHandler("refreshPaintShopMixerMaintenanceAll", getRootElement(), function(ws, data)
	if ws == currentWorkshop then
		playerHoldingCasette = false
		mixerMaintenance = data
		local sound = playSound3D("files/prompt.mp3", mixerX + 0.01264, mixerY + 1.83547, mixerZ + 0.162247)
		setElementInterior(sound, targetInt)
		setElementDimension(sound, currentWorkshop)
		if data then
			loadedMixerRecipe = false
			for i = 1, #data do
				if data[i] == localPlayer then
					playerHoldingCasette = i
				end
				processMixerMachineCasette(i)
			end
		end
		if mixerWindow then
			createMixerWindow()
		else
			processMixerRenderTarget()
		end
	end
end)
addEvent("refreshPaintShopMixerMaintenance", true)
addEventHandler("refreshPaintShopMixerMaintenance", getRootElement(), function(ws, i, data)
	if ws == currentWorkshop then
		i = tonumber(i)
		if i then
			if mixerMaintenance[i] == localPlayer then
				playerHoldingCasette = false
			end
			if data and mixerMaintenance[i] then
				local x, y, z
				if i == 1 then
					x, y, z = mixerX + 0.018, mixerY - 2.4809, mixerZ + 0.548
				elseif i <= 3 then
					local j = i - 1
					x, y, z = mixerX + mixerBaseOffsets[j][1], mixerY + mixerBaseOffsets[j][2], mixerZ + mixerBaseOffsets[j][3]
				else
					local j = i - 3
					x, y, z = mixerX + mixerColorOffets[j][1], mixerY + mixerColorOffets[j][2], mixerZ + mixerColorOffets[j][3]
				end
				local sound = playSound3D("files/casette.mp3", x, y, z)
				setElementInterior(sound, targetInt)
				setElementDimension(sound, currentWorkshop)
				if isElement(data) then
					local sound = playSound3D("files/hardout.mp3", mixerX + 0.01264, mixerY + 1.83547, mixerZ + 0.162247)
					setElementInterior(sound, targetInt)
					setElementDimension(sound, currentWorkshop)
				else
					local sound = playSound3D("files/hardin.mp3", mixerX + 0.01264, mixerY + 1.83547, mixerZ + 0.162247)
					setElementInterior(sound, targetInt)
					setElementDimension(sound, currentWorkshop)
				end
			end
			mixerMaintenance[i] = data
			if data == localPlayer then
				playerHoldingCasette = i
			end
			processMixerMachineCasette(i)
		end
		if mixerWindow then
			createMixerWindow()
		else
			processMixerRenderTarget()
		end
	end
end)
local paintBoxOffsets = {
	{
		7.7198,
		-4.1815,
		0.611649,
		3.41,
		-1.06,
		2.83,
		2.99
	},
	{
		7.7198,
		-4.8588,
		0.611649,
		4.12,
		-3.03,
		-1.65,
		2.68
	},
	{
		7.7198,
		-5.5361,
		0.611649,
		-2.22,
		0.54,
		-0.23,
		1.29
	},
	{
		7.7198,
		-6.2134,
		0.611649,
		-1.35,
		0.13,
		4.53,
		4.17
	},
	{
		7.7198,
		-6.8907,
		0.611649,
		1.36,
		2.18,
		-3.59,
		1.07
	},
	{
		7.7198,
		-7.568,
		0.611649,
		-4.84,
		-2.57,
		-3.63,
		3.04
	},
	{
		7.7198,
		-8.2453,
		0.611649,
		-3.44,
		-0.99,
		-3.71,
		-3.92
	},
	{
		7.7198,
		-8.9226,
		0.611649,
		4.99,
		-2.82,
		0.13,
		3.39
	},
	{
		7.7198,
		-9.5999,
		0.611649,
		1.13,
		-2.04,
		1.38,
		0.24
	},
	{
		6.8442,
		-10.5375,
		0.611649,
		269.94,
		274.73,
		267.92,
		272.72
	},
	{
		6.1669,
		-10.5375,
		0.611649,
		270.27,
		272.7,
		269,
		273.92
	},
	{
		5.4896,
		-10.5375,
		0.611649,
		267.83,
		268.52,
		273.08,
		274.19
	},
	{
		4.8123,
		-10.5375,
		0.611649,
		265.69,
		274.5,
		270.26,
		265.86
	},
	{
		4.135,
		-10.5375,
		0.611649,
		266.92,
		271.63,
		273.91,
		268.49
	},
	{
		3.4577,
		-10.5375,
		0.611649,
		265.64,
		265.2,
		269.58,
		265.63
	},
	{
		2.7804,
		-10.5375,
		0.611649,
		267.38,
		274.71,
		274.03,
		273.51
	},
	{
		2.1031,
		-10.5375,
		0.611649,
		267.66,
		270.4,
		268.75,
		272.61
	}
}
local boxLevelZ = {
	1.65572,
	2.15072,
	2.75028
}
workshopOrder = false
addEvent("refreshPaintshopOrder", true)
addEventHandler("refreshPaintshopOrder", getRootElement(), function(ws, data)
	if ws == currentWorkshop then
		workshopOrder = data
		if openedComputerApp == "internet" and computerWindow and openedWebsite == "paint" then
			createInternetWindow()
		end
	end
end)
paintStockData = {}
local paintBoxes = {}
function processPaintStockBoxes(i)
	local boxes = paintStockData[i][1]
	local bottomBox = paintStockData[i][2]
	if bottomBox then
		local model = false
		if i <= 3 then
			if tonumber(bottomBox) and 0 < bottomBox then
				model = models["spray_basebox_" .. bottomBox]
			else
				model = models.spray_basebox
			end
		elseif tonumber(bottomBox) and 0 < bottomBox then
			model = models["spray_paintbox_" .. bottomBox]
		else
			model = models.spray_paintbox
		end
		if model then
			if not isElement(paintBoxes[i][1]) then
				paintBoxes[i][1] = createObject(model, wsX + paintBoxOffsets[i][1], wsY + paintBoxOffsets[i][2], wsZ + paintBoxOffsets[i][3], 0, 0, paintBoxOffsets[i][4])
				setElementCollisionsEnabled(paintBoxes[i][1], false)
				setElementInterior(paintBoxes[i][1], targetInt)
				setElementDimension(paintBoxes[i][1], currentWorkshop)
				if i == 1 and colorPrimerShader then
					engineApplyShaderToWorldTexture(colorPrimerShader, "base_canister_tag", paintBoxes[i][1])
				elseif i <= 3 and colorBaseShaders[i - 1] then
					engineApplyShaderToWorldTexture(colorBaseShaders[i - 1], "base_canister_tag", paintBoxes[i][1])
				elseif colorPaletteShaders[i - 3] then
					engineApplyShaderToWorldTexture(colorPaletteShaders[i - 3], "color_canister_tag", paintBoxes[i][1])
				end
			else
				setElementModel(paintBoxes[i][1], model)
			end
		end
	else
		if isElement(paintBoxes[i][1]) then
			destroyElement(paintBoxes[i][1])
		end
		paintBoxes[i][1] = nil
	end
	for j = 2, 4 do
		if j <= boxes + 1 then
			if not isElement(paintBoxes[i][j]) then
				local model = models[i <= 3 and "spray_basebox" or "spray_paintbox"]
				paintBoxes[i][j] = createObject(model, wsX + paintBoxOffsets[i][1], wsY + paintBoxOffsets[i][2], wsZ + boxLevelZ[j - 1], 0, 0, paintBoxOffsets[i][4 + j - 1])
				setElementCollisionsEnabled(paintBoxes[i][j], false)
				setElementInterior(paintBoxes[i][j], targetInt)
				setElementDimension(paintBoxes[i][j], currentWorkshop)
				if i == 1 and colorPrimerShader then
					engineApplyShaderToWorldTexture(colorPrimerShader, "base_canister_tag", paintBoxes[i][j])
				elseif i <= 3 and colorBaseShaders[i - 1] then
					engineApplyShaderToWorldTexture(colorBaseShaders[i - 1], "base_canister_tag", paintBoxes[i][j])
				elseif colorPaletteShaders[i - 3] then
					engineApplyShaderToWorldTexture(colorPaletteShaders[i - 3], "color_canister_tag", paintBoxes[i][j])
				end
			end
		else
			if isElement(paintBoxes[i][j]) then
				destroyElement(paintBoxes[i][j])
			end
			paintBoxes[i][j] = nil
		end
	end
end
addEvent("refreshPaintshopStockData", true)
addEventHandler("refreshPaintshopStockData", getRootElement(), function(ws, i, data)
	if ws == currentWorkshop then
		if paintStockData[i][2] == true and tonumber(data[2]) then
			local sound = playSound3D("files/cut" .. math.random(1, 4) .. ".mp3", wsX + paintBoxOffsets[i][1], wsY + paintBoxOffsets[i][2], wsZ + paintBoxOffsets[i][3] + 0.25)
			setElementInterior(sound, targetInt)
			setElementDimension(sound, currentWorkshop)
		elseif (tonumber(paintStockData[i][2]) or 0) > (tonumber(data[2]) or 0) then
			local sound = playSound3D("files/boxout.mp3", wsX + paintBoxOffsets[i][1], wsY + paintBoxOffsets[i][2], wsZ + paintBoxOffsets[i][3] + 0.25)
			setElementInterior(sound, targetInt)
			setElementDimension(sound, currentWorkshop)
		end
		paintStockData[i] = data
		processPaintStockBoxes(i)
	end
end)
function processColorPaletteLabel()
	local font = sightexports.sGui:getFont("28/BebasNeueRegular.otf")
	local fontScale = sightexports.sGui:getFontScale("28/BebasNeueRegular.otf")
	for i = 1, #colorPalette do
		if isElement(colorPaletteTextures[i]) then
			destroyElement(colorPaletteTextures[i])
		end
		colorPaletteTextures[i] = nil
		if isElement(colorPaletteShaders[i]) then
			destroyElement(colorPaletteShaders[i])
		end
		colorPaletteShaders[i] = nil
		local rt = dxCreateRenderTarget(128, 128)
		if isElement(rt) then
			dxSetRenderTarget(rt)
			dxDrawImage(0, 0, 128, 128, "files/label1.dds")
			if i == 1 then
				dxDrawRectangle(0, 17, 128, 63, tocolor(85, 85, 85))
			end
			local r, g, b = colorPalette[i][1], colorPalette[i][2], colorPalette[i][3]
			dxDrawImage(0, 0, 128, 128, "files/label2.dds", 0, 0, 0, tocolor(r, g, b))
			if i <= 2 then
				dxDrawText(colorNames[i], 0, 21, 128, 76, i == 1 and tocolor(85, 85, 85) or tocolor(235, 235, 235), fontScale * 0.85, font, "center", "center")
			elseif i == 3 or i == 5 or i == 7 then
				dxDrawText(colorNames[i], 0, 21, 128, 76, tocolor(255, 255, 255), fontScale * 0.9, font, "center", "center")
			elseif i <= 8 then
				dxDrawText(colorNames[i], 0, 21, 128, 76, tocolor(35, 35, 35), fontScale * 0.9, font, "center", "center")
			else
				dxDrawText(colorNames[i], 0, 21, 128, 76, tocolor(255, 255, 255), fontScale * 0.9, font, "center", "center")
			end
			dxSetRenderTarget()
			colorPaletteTextures[i] = dxCreateTexture(dxGetTexturePixels(rt), "dxt1")
			destroyElement(rt)
			colorPaletteShaders[i] = dxCreateShader(textureChanger)
			dxSetShaderValue(colorPaletteShaders[i], "gTexture", colorPaletteTextures[i])
			if mixerColorCasettes[i] then
				engineApplyShaderToWorldTexture(colorPaletteShaders[i], "color_canister_tag", mixerColorCasettes[i])
			end
			if paintBoxes[i + 3] then
				for j = 1, #paintBoxes[i + 3] do
					engineApplyShaderToWorldTexture(colorPaletteShaders[i], "color_canister_tag", paintBoxes[i + 3][j])
				end
			end
		end
	end
	for i = 1, 2 do
		if isElement(colorBaseTextures[i]) then
			destroyElement(colorBaseTextures[i])
		end
		if isElement(colorBaseShaders[i]) then
			destroyElement(colorBaseShaders[i])
		end
		colorBaseShaders[i] = nil
		if i == 2 then
			colorBaseTextures[i] = dxCreateTexture("files/labelmetbase.dds", "dxt1")
		else
			colorBaseTextures[i] = dxCreateTexture("files/labelbase.dds", "dxt1")
		end
		colorBaseShaders[i] = dxCreateShader(textureChanger)
		dxSetShaderValue(colorBaseShaders[i], "gTexture", colorBaseTextures[i])
		if mixerBaseCasettes[i] then
			engineApplyShaderToWorldTexture(colorBaseShaders[i], "base_canister_tag", mixerBaseCasettes[i])
		end
		if paintBoxes[i + 1] then
			for j = 1, #paintBoxes[i + 1] do
				engineApplyShaderToWorldTexture(colorBaseShaders[i], "base_canister_tag", paintBoxes[i + 1][j])
			end
		end
	end
	if isElement(colorPrimerTexture) then
		destroyElement(colorPrimerTexture)
	end
	if isElement(colorPrimerShader) then
		destroyElement(colorPrimerShader)
	end
	colorPrimerShader = nil
	colorPrimerTexture = dxCreateTexture("files/labelprimer.dds", "dxt1")
	colorPrimerShader = dxCreateShader(textureChanger)
	dxSetShaderValue(colorPrimerShader, "gTexture", colorPrimerTexture)
	if mixerPrimerCasette then
		engineApplyShaderToWorldTexture(colorPrimerShader, "base_canister_tag", mixerPrimerCasette)
	end
	if paintBoxes[1] then
		for j = 1, #paintBoxes[1] do
			engineApplyShaderToWorldTexture(colorPrimerShader, "base_canister_tag", paintBoxes[1][j])
		end
	end
	processTransferBoxes()
end
addEventHandler("onClientRestore", getRootElement(), processColorPaletteLabel)
local mixerSliderPosition = mixerBaseOffsets[1][2]
local mixerSliderTarget = mixerBaseOffsets[1][2]
local mixerSlider = false
local emailTexture = false
local renderTargetX = false
local renderTargetY = false
local renderTargetDepth = false
sandbrush = false
paintbrush = false
local boothRefl = false
local boothDryingRefl = false
local primerR = 198
local primerG = 211
local primerB = 255
local carWindow = false
local carPrompt = false
local carModelLoadDelay = 0
bigLoader = false
local bigLoaderFadeOut = false
local loadingShop = false
local loadingWorks = 0
local reflectionTextures = {}
local workCars = {}
local workCarFrozen = {}
local workCarFreezeTimers = {}
local wheelMasks = {}
local wheelSizes = {}
local wheels = {
	"wheel_lf_dummy",
	"wheel_rf_dummy",
	"wheel_rb_dummy",
	"wheel_lb_dummy"
}
paintshopWorks = {}
local cx, cy
local paintshopHover = false
local paintshopHoverId = false
carMasks = {}
carMaskBgs = {}
carSecondaryMasks = {}
carPaintjobs = {}
carShaders = {}
local carHelperShaders = {}
local carHideShader = {}
local currentWorkingCar = false
local syncedData = {}
local unsyncedData = {}
unsyncedPaintDelta = {}
local unsyncedPaintGunId = {}
unsyncedPermissionData = {}
permissionDataToSync = false
function syncPermissionData()
	triggerLatentServerEvent("refreshWorkshopPermissions", localPlayer, unsyncedPermissionData)
	if workshopPermissions then
		for cid, values in pairs(unsyncedPermissionData) do
			if workshopPermissions[cid] then
				for i, v in pairs(values) do
					workshopPermissions[cid][i] = v
				end
			end
		end
	end
	unsyncedPermissionData = {}
	permissionDataToSync = false
end
dataToSync = {}
local lastSync = {}
local boothBeepTmp = false
local boothDrying = false
local boothClosed = false
local boothDoor = 0.8
local boothVolume = 0
local drySecondarySound = false
local drySound = false
local dryStart = false
local dryStop = false
local boothCoordinates = {
	wsX - 8.37799,
	wsY - 5.50019,
	wsX - 1.30572,
	wsY + 6.91943
}
local paintGunDatas = {}
local sanderMachineDatas = {}
local servoSoundEffect = false
local sliderServoSpeed = 0
local primerMachineStarted = false
local mixerStarted = false
local mixerSoundEffect = false
local mixerTank = false
local machineSounds = {}
local machineStartTick = {}
local machineEndTick = {}
local sandingBaseSounds = {}
local sandingBaseStart = {}
local sandingBaseEnd = {}
local particleTextures = {}
local particles = {}
local lastParticleEffect = 0
local lastParticleSync = 0
local unsyncedParticleNum = 0
local paintingAnim = {}
local paintingAnimTime = 0
local paintingAnimPoses = {}
local paintingAnimDegrees = {}
local timedPaintParticles = {}
local sprayGuns = {}
local sprayShaders = {}
local playerGuns = {}
tankInHand = false
local gunPoses = {}
local airPipes = {}
local sanderCables = {}
local sanderPlugs = {}
local sanderCableLength = 10
local socketUsed = {}
local lineSegment = 0.15
local gz = wsZ + 0.05
local sprayBar = {}
local sprayPumping = {}
local sprayNeedles = {}
local sprayGunBases = {}
local sanderMachines = {}
playerSanders = {}
local lastPlayerSanderSocket = false
local clockObjects = {}
function preparePaintshopObject(id)
	setElementDimension(workshopObj, id)
	sightexports.sMarkers:setCustomMarkerDimension(workshopMarker, id)
end
local eventsHandled = false
local canWorkWarning = false
currentWorkshop = false
local myWorkSkin = false
function destroyTableElements(tbl)
	for i, v in pairs(tbl) do
		if isElement(v) then
			destroyElement(v)
		end
	end
end
function destroyPaintObjects()
	destroyTableElements(clockObjects)
	clockObjects = {}
	destroyTableElements(doors)
	doors = {}
	destroyTableElements(sprayGunBases)
	sprayGunBases = {}
	destroyTableElements(sanderPlugs)
	sanderPlugs = {}
	destroyTableElements(mixerColorCasettes)
	mixerColorCasettes = {}
	destroyTableElements(mixerBaseCasettes)
	mixerBaseCasettes = {}
	destroyTableElements(sprayNeedles)
	sprayNeedles = {}
	destroyTableElements(sprayGuns)
	sprayGuns = {}
	destroyTableElements(sanderMachines)
	sanderMachines = {}
	if isElement(mixerSlider) then
		destroyElement(mixerSlider)
	end
	mixerSlider = false
	if isElement(mixerPrimerCasette) then
		destroyElement(mixerPrimerCasette)
	end
	mixerPrimerCasette = false
	if isElement(alphaObj) then
		destroyElement(alphaObj)
	end
	alphaObj = false
	if isElement(boothObj) then
		destroyElement(boothObj)
	end
	boothObj = false
	if isElement(boothDoorObj) then
		destroyElement(boothDoorObj)
	end
	boothDoorObj = false
	if isElement(mixerObject) then
		destroyElement(mixerObject)
	end
	mixerObject = false
	if isElement(officeDoorObj) then
		destroyElement(officeDoorObj)
	end
	officeDoorObj = false
	if isElement(paletteObj) then
		destroyElement(paletteObj)
	end
	paletteObj = false
	for i in pairs(paintBoxes) do
		for j in pairs(paintBoxes[i]) do
			if isElement(paintBoxes[i][j]) then
				destroyElement(paintBoxes[i][j])
			end
		end
	end
	paintBoxes = {}
end
function destroyPaintTextures()
	if isElement(emailTexture) then
		destroyElement(emailTexture)
	end
	emailTexture = false
	if isElement(renderTargetX) then
		destroyElement(renderTargetX)
	end
	renderTargetX = false
	if isElement(renderTargetY) then
		destroyElement(renderTargetY)
	end
	renderTargetY = false
	if isElement(renderTargetDepth) then
		destroyElement(renderTargetDepth)
	end
	renderTargetDepth = false
	if isElement(sandbrush) then
		destroyElement(sandbrush)
	end
	sandbrush = false
	if isElement(paintbrush) then
		destroyElement(paintbrush)
	end
	paintbrush = false
	if isElement(boothRefl) then
		destroyElement(boothRefl)
	end
	boothRefl = false
	if isElement(boothDryingRefl) then
		destroyElement(boothDryingRefl)
	end
	boothDryingRefl = false
	if isElement(mixerRenderTarget) then
		destroyElement(mixerRenderTarget)
	end
	mixerRenderTarget = false
	if isElement(noiseTexture) then
		destroyElement(noiseTexture)
	end
	noiseTexture = false
	if isElement(metalTexture) then
		destroyElement(metalTexture)
	end
	metalTexture = false
	destroyTableElements(particleTextures)
	particleTextures = {}
	for i in pairs(paintGunDatas) do
		if paintGunDatas[i] and isElement(paintGunDatas[i].paintRT) then
			destroyElement(paintGunDatas[i].paintRT)
		end
	end
	paintGunDatas = {}
	if isElement(segTexture) then
		destroyElement(segTexture)
	end
	segTexture = false
	if isElement(gradTexture) then
		destroyElement(gradTexture)
	end
	gradTexture = false
	if isElement(ledTexture) then
		destroyElement(ledTexture)
	end
	ledTexture = false
	if isElement(dropTexture) then
		destroyElement(dropTexture)
	end
	dropTexture = false
end
function destroyWorkCars()
	for i, v in pairs(workCarFreezeTimers) do
		if isTimer(workCarFreezeTimers) then
			killTimer(workCarFreezeTimers)
		end
	end
	workCarFrozen = {}
	destroyTableElements(workCars)
	workCars = {}
	destroyTableElements(carMaskBgs)
	carMaskBgs = {}
	destroyTableElements(carShaders)
	carShaders = {}
	destroyTableElements(carHelperShaders)
	carHelperShaders = {}
	destroyTableElements(reflectionTextures)
	reflectionTextures = {}
	destroyTableElements(carHideShader)
	carHideShader = {}
	for i in pairs(wheelMasks) do
		for j = 1, 4 do
			if wheelMasks[i] and wheelMasks[i][j] and isElement(wheelMasks[i][j]) then
				destroyElement(wheelMasks[i][j])
			end
		end
	end
	wheelMasks = {}
end
function destroyPaintElements()
	destroyPaintObjects()
	collectgarbage("collect")
	destroyPaintTextures()
	collectgarbage("collect")
	destroyWorkCars()
	collectgarbage("collect")
	sliderServoSpeed = 0
	if isElement(servoSoundEffect) then
		destroyElement(servoSoundEffect)
	end
	servoSoundEffect = false
	destroyTableElements(sprayShaders)
	sprayShaders = {}
	if isElement(mixerShader) then
		destroyElement(mixerShader)
	end
	mixerShader = false
	if isElement(mixerSoundEffect) then
		destroyElement(mixerSoundEffect)
	end
	mixerSoundEffect = nil
	if isElement(drySecondarySound) then
		destroyElement(drySecondarySound)
	end
	drySecondarySound = false
	if isElement(drySound) then
		destroyElement(drySound)
	end
	drySound = false
	destroyTableElements(sandingBaseSounds)
	sandingBaseSounds = {}
	destroyTableElements(machineSounds)
	machineSounds = {}
	destroyTableElements(ifps)
	ifps = {}
end
function resetHandheldVariables()
	socketUsed = {}
	lastParticleEffect = 0
	lastParticleSync = 0
	unsyncedParticleNum = 0
	paintingAnimTime = 0
	timedPaintParticles = {}
	playerGuns = {}
	sanderCables = {}
	gunPoses = {}
	airPipes = {}
	playerSanders = {}
	lastPlayerSanderSocket = false
end
function resetVariables()
	destroyPaintElements()
	collectgarbage("collect")
	paintshopWorks = {}
	myWorkSkin = false
	currentWorkingCar = false
	bigLoaderFadeOut = false
	resetHandheldVariables()
	canWorkWarning = false
	paintshopHover = false
	paintshopHoverId = false
	isOwner = false
	workshopRatingNum = 0
	workshopRatingSum = 0
	workshopPermissions = false
	unsyncedPermissionData = {}
	permissionDataToSync = false
	syncedData = {}
	unsyncedData = {}
	unsyncedPaintDelta = {}
	unsyncedPaintGunId = {}
	dataToSync = {}
	lastSync = {}
	boothDrying = false
	boothClosed = false
	dryStart = false
	dryStop = false
	sanderMachineDatas = {}
	primerMachineStarted = false
	mixerStarted = false
	mixerMaintenance = false
	playerHoldingCasette = false
	workshopOrder = false
	paintStockData = {}
	paintBoxes = {}
	machineStartTick = {}
	machineEndTick = {}
	sandingBaseStart = {}
	sandingBaseEnd = {}
	syncedData = {}
	unsyncedData = {}
	unsyncedPaintDelta = {}
	unsyncedPaintGunId = {}
	paintingAnim = {}
	paintingAnimDegrees = {}
	paintingAnimPoses = {}
	particles = {}
	if eventsHandled then
		removeEventHandler("onClientRender", getRootElement(), renderPaintshop)
		removeEventHandler("onClientClick", getRootElement(), clickPaintshop)
		removeEventHandler("onClientPreRender", getRootElement(), preRenderPaintshop)
		removeEventHandler("onClientRestore", getRootElement(), restorePaintShop)
		removeEventHandler("onClientPedsProcessed", getRootElement(), pedsProcessPaintshop)
		removeEventHandler("onClientPedsProcessed", getRootElement(), pedsProcessPaintshopEx)
	end
	eventsHandled = false
	playerAlphaSet = false
	compressorState = false
	compressorStart = false
	compressorEnd = false
	if isElement(compressorSound) then
		destroyElement(compressorSound)
	end
	compressorSound = false
	lastCompressor = 0
	deleteCarWindow()
	deleteComputerWindow()
	deleteMixerWindow()
	bigLoaderFadeOut = false
	loadingShop = false
	loadingWorks = 0
	currentWorkshop = false
	collectgarbage("collect")
end
addEvent("exitedPaintWorkshop", true)
addEventHandler("exitedPaintWorkshop", getRootElement(), function(lobby)
	resetVariables()
	sightexports.sWeather:resetWeather()
	if lobby then
		startPaintshopLobbyLoading(lobby, true)
	end
end)
function isLoading()
	if currentWorkshop then
		return loadingShop or 0 < loadingWorks
	end
end
function initTextures()
	segTexture = dxCreateTexture("files/7seg.dds")
	gradTexture = dxCreateTexture("files/grad.dds")
	ledTexture = dxCreateTexture("files/led.dds")
	dropTexture = dxCreateTexture("files/drop.dds")
	noiseTexture = dxCreateTexture("files/noise.dds")
	metalTexture = dxCreateTexture("files/metal.dds", "dxt1")
	renderTargetX = dxCreateRenderTarget(screenX, screenY, true)
	renderTargetY = dxCreateRenderTarget(screenX, screenY, true)
	renderTargetDepth = dxCreateRenderTarget(screenX, screenY, true)
	sandbrush = dxCreateTexture("assets/brushes/sandbrush.dds")
	paintbrush = dxCreateTexture("assets/brushes/paintbrush.dds")
	boothRefl = dxCreateTexture("files/refl_booth.dds", "dxt1")
	boothDryingRefl = dxCreateTexture("files/refl_booth_drying.dds", "dxt1")
	emailTexture = dxCreateTexture("files/spray_monitor_email.dds", "dxt1")
	particleTextures = {
		dxCreateTexture("files/particle/collisionsmoke.dds"),
		dxCreateTexture("files/particle/permetbrush.dds")
	}
	mixerRenderTarget = dxCreateRenderTarget(1024, 576)
	mixerShader = dxCreateShader(textureChanger)
	dxSetShaderValue(mixerShader, "gTexture", mixerRenderTarget)
	engineApplyShaderToWorldTexture(mixerShader, "mixer_monitor", mixerObject)
end
function initSprayGuns(id)
	for i = 1, #sprayGunPoses do
		paintGunDatas[i] = {}
		sprayBar[i] = 8
		sprayNeedles[i] = createObject(models.spray_manometer, wsX + barNeedles[i][1], wsY + barNeedles[i][2], wsZ + barNeedles[i][3], 0, 0, sprayGunPoses[i][4])
		setElementCollisionsEnabled(sprayNeedles[i], false)
		sprayGuns[i] = createObject(models.spray_gun, wsX + sprayGunPoses[i][1], wsY + sprayGunPoses[i][2], wsZ + sprayGunPoses[i][3], sprayGunPoses[i][4], sprayGunPoses[i][5], sprayGunPoses[i][6])
		setElementInterior(sprayNeedles[i], targetInt)
		setElementDimension(sprayNeedles[i], id)
		setElementInterior(sprayGuns[i], targetInt)
		setElementDimension(sprayGuns[i], id)
		setElementCollisionsEnabled(sprayGuns[i], false)
		setElementAlpha(sprayGuns[i], 254)
		sprayShaders[i] = dxCreateShader(paintGunShader)
		dxSetShaderValue(sprayShaders[i], "paintLevel", 0)
		paintGunDatas[i].paintRT = dxCreateRenderTarget(128, 128, true)
		processSprayGunRenderTarget(i)
		dxSetShaderValue(sprayShaders[i], "gTexture", paintGunDatas[i].paintRT)
		engineApplyShaderToWorldTexture(sprayShaders[i], "spray_gun_color", sprayGuns[i])
		resetAirHose(i)
	end
end
function initPaintshopObjects(id)
	for i = 1, 4 do
		doors[i] = createObject(models.spray_door, 0, 0, 0)
		setElementInterior(doors[i], targetInt)
		setElementDimension(doors[i], id)
	end
	alphaObj = createObject(models.spray_interior_alpha, wsX - 1.2447, wsY + 1.9516, wsZ + 2.1357)
	boothObj = createObject(models.spray_booth, wsX - 4.8419, wsY + 0.6871, wsZ + 2.2797)
	setElementInterior(alphaObj, targetInt)
	setElementDimension(alphaObj, id)
	setElementInterior(boothObj, targetInt)
	setElementDimension(boothObj, id)
	boothDoorObj = createObject(models.spray_door2, wsX - 1.2447, wsY - 3.5337, wsZ + 0.056, 0, 0, 90)
	setElementInterior(boothDoorObj, targetInt)
	setElementDimension(boothDoorObj, id)
	mixerObject = createObject(models.spray_mixer, mixerX, mixerY, mixerZ, 0, 0, 270)
	setElementInterior(mixerObject, targetInt)
	setElementDimension(mixerObject, id)
	mixerSliderPosition = mixerBaseOffsets[1][2]
	mixerSliderTarget = mixerBaseOffsets[1][2]
	mixerSlider = createObject(models.spray_mixer_slider, mixerX - 0.0085, mixerY + mixerSliderPosition, mixerZ - 0.087629, 0, 0, 270)
	setElementCollisionsEnabled(mixerSlider, false)
	setElementInterior(mixerSlider, targetInt)
	setElementDimension(mixerSlider, id)
	officeDoorObj = createObject(models.spray_office_door, wsX + 6.9973, wsY - 3.0941, wsZ + 1.1438)
	setElementInterior(officeDoorObj, targetInt)
	setElementDimension(officeDoorObj, id)
	paletteObj = createObject(models.spray_palette, wsX + 2.6776, wsY - 3.2738, wsZ + 1.8713, 0, 0, 90)
	setElementInterior(paletteObj, targetInt)
	setElementDimension(paletteObj, id)
	officeDoorP = 0
	officeDoorState = false
	for i = 1, #sanderPosition do
		sanderMachineDatas[i] = {}
		sanderMachines[i] = createObject(models.spray_sander_shelf, wsX + sanderPosition[i][1], wsY + sanderPosition[i][2], wsZ + sanderPosition[i][3], sanderPosition[i][4], sanderPosition[i][5], sanderPosition[i][6])
		setElementAlpha(sanderMachines[i], 254)
		setElementCollisionsEnabled(sanderMachines[i], false)
		setElementInterior(sanderMachines[i], targetInt)
		setElementDimension(sanderMachines[i], id)
	end
	for i = 1, 3 do
		clockObjects[i] = createObject(models.spray_clock, wsX + 6.2812, wsY - 2.9317, wsZ + 2.7857)
		setElementInterior(clockObjects[i], targetInt)
		setElementDimension(clockObjects[i], id)
	end
	setObjectScale(clockObjects[2], 1, 1, 1.1)
	setObjectScale(clockObjects[2], 2.25, 1, 1.1)
	setObjectScale(clockObjects[3], 2.25, 1, 0.65)
end
function loadedPaintshop(id)
	resetVariables()
	if id then
		preparePaintshopObject(id)
		initPaintshopObjects(id)
		if not bigLoader then
			bigLoader = math.random(1, 6)
		end
		table.insert(ifps, engineLoadIFP("files/anim_crouch.ifp", "paint_crouch"))
		table.insert(ifps, engineLoadIFP("files/anim_stand.ifp", "paint_stand"))
		table.insert(ifps, engineLoadIFP("files/anim_sand_crouch.ifp", "paint_sand_crouch"))
		table.insert(ifps, engineLoadIFP("files/anim_sand_stand.ifp", "paint_sand_stand"))
		mixerTank = {
			primer = 0,
			base = {0, 0},
			color = {
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0
			}
		}
		loadingShop = true
		loadingWorks = 0
		currentWorkshop = id
		if not eventsHandled then
			addEventHandler("onClientRender", getRootElement(), renderPaintshop, true, "low-999")
			addEventHandler("onClientClick", getRootElement(), clickPaintshop)
			addEventHandler("onClientPreRender", getRootElement(), preRenderPaintshop)
			addEventHandler("onClientRestore", getRootElement(), restorePaintShop)
			addEventHandler("onClientPedsProcessed", getRootElement(), pedsProcessPaintshop, true, "high")
			addEventHandler("onClientPedsProcessed", getRootElement(), pedsProcessPaintshopEx, true, "low-99999999999")
			eventsHandled = true
		end
		for i = 1, 17 do
			processMixerMachineCasette(i)
		end
		for i = 1, #paintBoxOffsets do
			paintBoxes[i] = {}
			paintStockData[i] = {0, false}
		end
		initTextures()
		initSprayGuns(id)
		triggerLatentServerEvent("requestPaintshopInit", localPlayer)
		setLobbyLoader(false)
	end
end
addEvent("enteredPaintWorkshop", true)
addEventHandler("enteredPaintWorkshop", getRootElement(), function(id)
	loadedPaintshop(id)
end)
hasPlayerSkin = false
addEvent("setPaintshopWorkSkin", true)
addEventHandler("setPaintshopWorkSkin", getRootElement(), function(ws, id)
	if isElement(source) then
		if currentWorkshop == ws then
			if source == localPlayer then
				myWorkSkin = not tonumber(id)
				paintshopHover = false
			end
			if tonumber(id) then
				sightexports.sGroups:setDutySkinForceOff(source, false)
				setElementModel(source, id)
				if source == localPlayer then
					hasPlayerSkin = false
				end
				sightexports.sGroups:processPlayerGroupSkin(source)
			else
				sightexports.sGroups:setDutySkinForceOff(source, true)
				if source == localPlayer then
					hasPlayerSkin = true
				end
				setElementModel(source, models.paintshop_skin)
			end
			local x, y, z = getElementPosition(source)
			local sound = false
			if tonumber(id) then
				sound = playSound3D(":sGroups/files/dutyout.wav", x, y, z)
			else
				sound = playSound3D(":sGroups/files/dutyin.wav", x, y, z)
			end
			setElementInterior(sound, getElementInterior(source))
			setElementDimension(sound, getElementDimension(source))
			attachElements(sound, source)
		elseif tonumber(id) then
			sightexports.sGroups:setDutySkinForceOff(source, false)
			setElementModel(source, id)
			sightexports.sGroups:processPlayerGroupSkin(source)
		end
	end
end)
addEvent("playPaintshopTrashSound", true)
addEventHandler("playPaintshopTrashSound", getRootElement(), function(ws, liqui)
	if currentWorkshop == ws then
		local sound = playSound3D("files/trash" .. (liqui and "2" or "") .. ".mp3", wsX - 0.63279, wsY - 10.5016, wsZ + 0.870294)
		setElementInterior(sound, targetInt)
		setElementDimension(sound, currentWorkshop)
	end
end)
addEvent("paintshopNewPlayerEntered", true)
addEventHandler("paintshopNewPlayerEntered", getRootElement(), function(ws)
	if currentWorkshop == ws then
		lastParticleSync = 0
		lastParticleEffect = 0
		paintingAnim[localPlayer] = false
	end
end)
function checkDryingState(start)
	local tmp = false
	local tmp2 = false
	for i = 1, 2 do
		if paintshopWorks[i] then
			if paintshopWorks[i].state == "primer" or paintshopWorks[i].state == "paint" then
				tmp2 = paintshopWorks[i].boothClosed and true or false
			elseif paintshopWorks[i].state == "primerDry" or paintshopWorks[i].state == "paintDry" then
				if paintshopWorks[i].dryingState then
					tmp = true
				end
				if carShaders[i] then
					dxSetShaderValue(carShaders[i], "drying", paintshopWorks[i].dryingState)
					dxSetShaderValue(carShaders[i], "reflectionTexture", paintshopWorks[i].dryingState and boothDryingRefl or boothRefl)
				end
				for j = 1, 4 do
					if wheelMasks[i] and wheelMasks[i][j] then
						setElementModel(wheelMasks[i][j], paintshopWorks[i].dryingState and models.wheel_mask_drying or models.wheel_mask)
					end
				end
				unfreezeWorkCar(i)
				workCarFreezeTimers[i] = setTimer(freezeWorkCar, 2500, 1, i)
			else
				for j = 1, 4 do
					if wheelMasks[i] and wheelMasks[i][j] then
						setElementModel(wheelMasks[i][j], models.wheel_mask)
					end
				end
				unfreezeWorkCar(i)
				workCarFreezeTimers[i] = setTimer(freezeWorkCar, 2500, 1, i)
			end
		end
	end
	if tmp2 then
		tmp = false
	end
	if tmp then
		tmp2 = false
	end
	if boothClosed ~= tmp2 then
		boothClosed = tmp2
		if not start then
			local sound = false
			if tmp2 then
				sound = playSound3D("files/boothdoor2.mp3", wsX - 2.3734 - 2.46844, wsY + 7.1194, wsZ + 1.7766)
			else
				sound = playSound3D("files/boothdoor.mp3", wsX - 2.3734 - 2.46844, wsY + 7.1194, wsZ + 1.7766)
			end
			setElementInterior(sound, targetInt)
			setElementDimension(sound, currentWorkshop)
		end
	end
	if boothDrying ~= tmp then
		paintshopHover = false
		boothDrying = tmp
		if not start then
			local sound = false
			if tmp then
				sound = playSound3D("files/boothdoor2.mp3", wsX - 2.3734 - 2.46844, wsY + 7.1194, wsZ + 1.7766)
			else
				sound = playSound3D("files/boothdoor.mp3", wsX - 2.3734 - 2.46844, wsY + 7.1194, wsZ + 1.7766)
			end
			setElementInterior(sound, targetInt)
			setElementDimension(sound, currentWorkshop)
		end
		if not isElement(drySound) then
			drySound = playSound3D("files/dry.mp3", wsX - 4.8419, wsY + 0.7096, wsZ + 3.6577, true)
			setElementInterior(drySound, targetInt)
			setElementDimension(drySound, currentWorkshop)
			setSoundMaxDistance(drySound, 120)
			setSoundVolume(drySound, 0)
		end
		if isElement(drySecondarySound) then
			destroyElement(drySecondarySound)
		end
		if boothDrying then
			local sound = playSound3D("files/boothon.mp3", wsX - 1.79309, wsY + 7.33886, wsZ + 1.3518)
			setElementInterior(sound, targetInt)
			setElementDimension(sound, currentWorkshop)
			drySecondarySound = playSound3D("files/drystart.mp3", wsX - 4.8419, wsY + 0.7096, wsZ + 3.6577)
			setElementInterior(drySecondarySound, targetInt)
			setElementDimension(drySecondarySound, currentWorkshop)
			setSoundMaxDistance(drySecondarySound, 120)
			dryStart = getTickCount()
			dryStop = false
		else
			local sound = playSound3D("files/boothon.mp3", wsX - 1.79309, wsY + 7.33886, wsZ + 1.3518)
			setElementInterior(sound, targetInt)
			setElementDimension(sound, currentWorkshop)
			drySecondarySound = playSound3D("files/drystop.mp3", wsX - 4.8419, wsY + 0.7096, wsZ + 3.6577)
			setElementInterior(drySecondarySound, targetInt)
			setElementDimension(drySecondarySound, currentWorkshop)
			setSoundMaxDistance(drySecondarySound, 120)
			dryStart = false
			dryStop = getTickCount()
		end
		setElementModel(boothObj, boothDrying and models.spray_booth_drying or models.spray_booth)
		setElementModel(boothDoorObj, boothDrying and models.spray_door2_drying or models.spray_door2)
		for i = 1, #doors do
			setElementModel(doors[i], boothDrying and models.spray_door_drying or models.spray_door)
		end
	end
end
local carOffsets = {
	{
		-2.9504,
		12.1597,
		-90
	},
	{
		3.6581,
		4.819,
		0
	},
	{
		-4.8369,
		0.7096,
		0
	}
}
function getWorkCarPositionByState(id, state)
	local vehZ = wsZ - (z or -0.5) + 0.1
	if state == "primer" or state == "primerDry" or state == "paint" or state == "paintDry" then
		return wsX + carOffsets[3][1], wsY + carOffsets[3][2], vehZ, carOffsets[3][3]
	else
		return wsX + carOffsets[id][1], wsY + carOffsets[id][2], vehZ, carOffsets[id][3]
	end
end
function getWorkCarPosition(id)
	local vehZ = wsZ - (z or -0.5) + 0.1
	if isElement(workCars[id]) then
		vehZ = vehZ + (getVehicleModelWheelSize(getElementModel(workCars[id]), "front_axle") or 1) / 2
	end
	if paintshopWorks[id].state == "primer" or paintshopWorks[id].state == "primerDry" or paintshopWorks[id].state == "paint" or paintshopWorks[id].state == "paintDry" then
		return wsX + carOffsets[3][1], wsY + carOffsets[3][2], vehZ, carOffsets[3][3]
	else
		return wsX + carOffsets[id][1], wsY + carOffsets[id][2], vehZ, carOffsets[id][3]
	end
end
function unfreezeWorkCar(id)
	if isTimer(workCarFreezeTimers[id]) then
		killTimer(workCarFreezeTimers[id])
	end
	workCarFreezeTimers[id] = false
	workCarFrozen[id] = false
	if isElement(workCars[id]) then
		setElementStreamable(workCars[id], false)
		setElementFrozen(workCars[id], false)
		local players = getElementsByType("player", getRootElement(), true)
		for i = 1, #players do
			setElementCollidableWith(workCars[id], players[i], false)
		end
	end
end
function freezeWorkCar(id)
	if isTimer(workCarFreezeTimers[id]) then
		killTimer(workCarFreezeTimers[id])
	end
	workCarFreezeTimers[id] = false
	workCarFrozen[id] = true
	if isElement(workCars[id]) then
		setElementStreamable(workCars[id], false)
		setElementFrozen(workCars[id], true)
		local players = getElementsByType("player", getRootElement(), true)
		for i = 1, #players do
			setElementCollidableWith(workCars[id], players[i], true)
		end
	end
end
function createWorkCar(id, model)
	if isElement(workCars[id]) then
		destroyElement(workCars[id])
	end
	if wheelMasks[id] then
		for i = 1, #wheelMasks[id] do
			if isElement(wheelMasks[id][i]) then
				destroyElement(wheelMasks[id][i])
			end
		end
	end
	wheelMasks[id] = nil
	wheelSizes[id] = nil
	if carOffsets[id] then
		workCars[id] = createVehicle(model, wsX + carOffsets[id][1], wsY + carOffsets[id][2], wsZ + 1, 0, 0, carOffsets[id][3])
		setElementStreamable(workCars[id], false)
		setElementInterior(workCars[id], targetInt)
		setElementDimension(workCars[id], currentWorkshop)
		setVehicleColor(workCars[id], 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255)
		setElementAlpha(workCars[id], 254)
		setVehiclePlateText(workCars[id], convertPlate(paintshopWorks[id].plate))
		setVehicleDamageProof(workCars[id], true)
		setVehicleVariant(workCars[id], 255, 255)
		setVehicleComponentVisible(workCars[id], "bump_rsz_ok", false)
		setVehicleComponentVisible(workCars[id], "egyebek_ok", false)
		wheelMasks[id] = {}
		wheelSizes[id] = {}
		for i = 1, 4 do
			wheelMasks[id][i] = createObject(models.wheel_mask, 0, 0, 0)
			setElementInterior(wheelMasks[id][i], targetInt)
			setElementDimension(wheelMasks[id][i], currentWorkshop)
			setVehicleComponentVisible(workCars[id], wheels[i], false)
			setElementCollisionsEnabled(wheelMasks[id][i], false)
			if i <= 2 then
				wheelSizes[id][i] = getVehicleModelWheelSize(getElementModel(workCars[id]), "front_axle") or 1
			else
				wheelSizes[id][i] = getVehicleModelWheelSize(getElementModel(workCars[id]), "rear_axle") or 1
			end
		end
		unfreezeWorkCar(id)
		workCarFreezeTimers[id] = setTimer(freezeWorkCar, 2500, 1, id)
		local x, y, z, rz = getWorkCarPosition(id)
		setElementPosition(workCars[id], x, y, z)
		setElementRotation(workCars[id], 0, 0, rz)
	end
end
function getBrushSize(id)
	if paintshopWorks[id].state == "sanding" then
		local levelAmount = {5, 15, 25, 50, 75}
		local upgradedSize = levelAmount[workshopUpgrades[5]] or 0  
		return 32 * (1 + (upgradedSize / 100))
	end
	local levelAmount = {5, 15, 25, 50, 75}
	local upgradedSize = levelAmount[workshopUpgrades[6]] or 0  
	return 48 * (1 + (upgradedSize / 100))
end
function getBrush(id)
	if paintshopWorks[id].state == "sanding" then
		return sandbrush
	end
	return paintbrush
end
function redrawFullMask(id)
	dxSetBlendMode("modulate_add")
	dxSetRenderTarget(carMaskBgs[id], true)
	local brush = getBrush(id)
	local brushSize = getBrushSize(id)
	if syncedData[id] then
		for s, val in pairs(syncedData[id]) do
			local x, y = syncToCoord(s)
			dxDrawImage(x - brushSize / 2, y - brushSize / 2, brushSize, brushSize, brush, 0, 0, 0, tocolor(0, 0, 0, val))
		end
		drawMask(id)
	end
end
function restorePaintShop()
	for id in pairs(carMasks) do
		redrawFullMask(id)
	end
	for i = 1, #sprayGuns do
		processSprayGunRenderTarget(i)
	end
end
function mergeUnsyncedToMask(id)
	dxSetBlendMode("modulate_add")
	local brush = getBrush(id)
	local brushSize = getBrushSize(id)
	dxSetRenderTarget(carMaskBgs[id])
	for s, val in pairs(unsyncedData[id]) do
		local x, y = syncToCoord(s)
		if syncedData[id][s] then
			dxDrawImage(x - brushSize / 2, y - brushSize / 2, brushSize, brushSize, brush, 0, 0, 0, tocolor(0, 0, 0, alphaTarget(syncedData[id][s], val)))
		else
			dxDrawImage(x - brushSize / 2, y - brushSize / 2, brushSize, brushSize, brush, 0, 0, 0, tocolor(0, 0, 0, val))
		end
		syncedData[id][s] = val
		unsyncedData[id][s] = math.floor(val)
	end
	dxSetRenderTarget()
	dxSetBlendMode("blend")
end
addEvent("gotPaintshopResetSyncedData", true)
addEventHandler("gotPaintshopResetSyncedData", getRootElement(), function(ws, id, data)
	if ws == currentWorkshop and carMaskBgs[id] then
		syncedData[id] = data
		redrawFullMask(id)
	end
end)
addEvent("gotPaintshopSyncedData", true)
addEventHandler("gotPaintshopSyncedData", getRootElement(), function(ws, id, data)
	if ws == currentWorkshop and carMaskBgs[id] then
		dxSetBlendMode("modulate_add")
		dxSetRenderTarget(carMaskBgs[id])
		local brush = getBrush(id)
		local brushSize = getBrushSize(id)
		for s, val in pairs(data) do
			local x, y = syncToCoord(s)
			if syncedData[id][s] then
				dxDrawImage(x - brushSize / 2, y - brushSize / 2, brushSize, brushSize, brush, 0, 0, 0, tocolor(0, 0, 0, alphaTarget(syncedData[id][s], val)))
			else
				dxDrawImage(x - brushSize / 2, y - brushSize / 2, brushSize, brushSize, brush, 0, 0, 0, tocolor(0, 0, 0, val))
			end
			syncedData[id][s] = val
		end
		drawMask(id)
	end
end)
function syncData(id)
	mergeUnsyncedToMask(id)
	triggerLatentServerEvent("syncPaintshopData", 1500000, localPlayer, id, unsyncedData[id], unsyncedPaintGunId[id], unsyncedPaintDelta[id])
	unsyncedPaintDelta[id] = 0
	unsyncedData[id] = {}
	drawMask(id)
	dataToSync[id] = false
	lastSync[id] = getTickCount()
end
function drawMask(id)
	dxSetBlendMode("modulate_add")
	dxSetRenderTarget(carMasks[id])
	dxDrawRectangle(0, 0, 1024, 1024, tocolor(255, 255, 255))
	dxDrawImage(0, 0, 1024, 1024, carMaskBgs[id])
	local brush = getBrush(id)
	local brushSize = getBrushSize(id)
	for s, val in pairs(unsyncedData[id]) do
		local x, y = syncToCoord(s)
		if syncedData[id][s] then
			dxDrawImage(x - brushSize / 2, y - brushSize / 2, brushSize, brushSize, brush, 0, 0, 0, tocolor(0, 0, 0, alphaTarget(syncedData[id][s], val)))
		else
			dxDrawImage(x - brushSize / 2, y - brushSize / 2, brushSize, brushSize, brush, 0, 0, 0, tocolor(0, 0, 0, val))
		end
	end
	dxSetRenderTarget()
	dxSetBlendMode("blend")
end
function createCarMask(id)
	if not isElement(carMaskBgs[id]) then
		carMaskBgs[id] = dxCreateRenderTarget(1024, 1024, true)
	end
	if not isElement(carMasks[id]) then
		carMasks[id] = dxCreateRenderTarget(1024, 1024)
	end
	redrawFullMask(id)
end
function carShaderWorkMode(id, mode)
	if carShaders[id] then
		if mode then
			dxSetShaderValue(carShaders[id], "work", true)
			dxSetShaderValue(carHelperShaders[id], "work", true)
		else
			dxSetShaderValue(carShaders[id], "work", false)
			dxSetShaderValue(carHelperShaders[id], "work", false)
		end
	end
end
function createCarShader(id)
	if isElement(carShaders[id]) then
		destroyElement(carShaders[id])
	end
	carShaders[id] = nil
	if isElement(carHelperShaders[id]) then
		destroyElement(carHelperShaders[id])
	end
	carHelperShaders[id] = nil
	if isElement(reflectionTextures[id]) then
		destroyElement(reflectionTextures[id])
	end
	reflectionTextures[id] = nil
	carShaders[id] = dxCreateShader(getWorkShader(paintshopWorks[id].state, primerR, primerG, primerB, paintshopWorks[id].colorRGB[1], paintshopWorks[id].colorRGB[2], paintshopWorks[id].colorRGB[3], paintshopWorks[id].metal))
	carHelperShaders[id] = dxCreateShader(carHelperShader, 1, 0, true)
	carHideShader[id] = dxCreateShader(carHideShaderSource)
	if paintshopWorks[id].state == "primer" or paintshopWorks[id].state == "paint" then
		reflectionTextures[id] = false
		dxSetShaderValue(carShaders[id], "reflectionTexture", boothRefl)
	elseif paintshopWorks[id].state == "primerDry" or paintshopWorks[id].state == "paintDry" then
		reflectionTextures[id] = false
		dxSetShaderValue(carShaders[id], "reflectionTexture", paintshopWorks[id].dryingState and boothDryingRefl or boothRefl)
		dxSetShaderValue(carShaders[id], "drying", paintshopWorks[id].dryingState)
	else
		reflectionTextures[id] = dxCreateTexture("files/refl" .. id .. ".dds", "dxt1")
		dxSetShaderValue(carShaders[id], "reflectionTexture", reflectionTextures[id])
	end
	createCarMask(id)
	carShaderWorkMode(id, currentWorkingCar == id)
	dxSetShaderValue(carShaders[id], "maskTexture", carMasks[id])
	if carPaintjobs[id] then
		dxSetShaderValue(carShaders[id], "baseTexture", carPaintjobs[id])
		dxSetShaderValue(carShaders[id], "secondaryMask", carSecondaryMasks[id])
	end
	dxSetShaderValue(carShaders[id], "metalTexture", metalTexture)
	dxSetShaderValue(carShaders[id], "noiseTexture", noiseTexture)
	dxSetShaderValue(carShaders[id], "secondRTX", renderTargetX)
	dxSetShaderValue(carShaders[id], "secondRTY", renderTargetY)
	dxSetShaderValue(carShaders[id], "secondRTDepth", renderTargetDepth)
	dxSetShaderValue(carHelperShaders[id], "secondRT", renderTargetX)
	local model = getElementModel(workCars[id])
	engineApplyShaderToWorldTexture(carHelperShaders[id], "*", workCars[id])
	engineRemoveShaderFromWorldTexture(carHelperShaders[id], mapNames[model][1], workCars[id])
	engineRemoveShaderFromWorldTexture(carHelperShaders[id], mapNames[model][2], workCars[id])
	engineRemoveShaderFromWorldTexture(carHelperShaders[id], "plateback*", workCars[id])
	engineRemoveShaderFromWorldTexture(carHelperShaders[id], "custom_car_plate", workCars[id])
	engineApplyShaderToWorldTexture(carHideShader[id], "plateback*", workCars[id])
	engineApplyShaderToWorldTexture(carHideShader[id], "custom_car_plate", workCars[id])
	if hideTextures[model] then
		for i = 1, #hideTextures[model] do
			engineRemoveShaderFromWorldTexture(carHelperShaders[id], hideTextures[model][i], workCars[id])
			engineApplyShaderToWorldTexture(carHideShader[id], hideTextures[model][i], workCars[id])
		end
	end
	engineApplyShaderToWorldTexture(carShaders[id], mapNames[model][1], workCars[id])
	engineApplyShaderToWorldTexture(carShaders[id], mapNames[model][2], workCars[id])
	if hideComponents[model] then
		for i = 1, #hideComponents[model] do
			setVehicleComponentVisible(workCars[id], hideComponents[model][i], false)
		end
	end
end

addEvent("gotPaintshopLoadingNewWork", true)
addEventHandler("gotPaintshopLoadingNewWork", getRootElement(), function(ws, id)
	if ws == currentWorkshop then
		id = convertWorkId(currentWorkshop, id)
		if id then
			loadingWorks = loadingWorks + 1
		end
	end
end)
addEvent("gotPaintshopWorkData", true)
addEventHandler("gotPaintshopWorkData", getRootElement(), function(ws, id, state, paintjobData, maskData, syncData, workData)
	if ws == currentWorkshop then
		if id then
			if paintshopWorks[id] and paintshopWorks[id].state ~= state then
				local engineSound = state == "sanding" or state == "primer" or state == "break" or state == "paint" or state == "transportOut"
				if engineSound then
					local x, y, z, rz = getWorkCarPositionByState(id, state)
					local sound = playSound3D("files/drive.mp3", x, y, z)
					setElementInterior(sound, targetInt)
					setElementDimension(sound, currentWorkshop)
					setSoundMaxDistance(sound, 50)
				end
			end
			if not paintshopWorks[id] then
				paintshopWorks[id] = {}
			end
			paintshopWorks[id].state = state
			syncedData[id] = {}
			if not unsyncedData[id] then
				unsyncedData[id] = {}
			end
			if type(syncData) == "string" then
				for i = 1, biggestSync do 
					local syncValue = syncData:sub(i, i):byte()
					if syncValue > 0 then
						syncedData[id][i - 1] = syncValue
					end
				end
			end
			if not workData then
				workData = {}
			end
			createCarPaintjob(id, paintjobData, maskData, workData)
			createCarShader(id)
			unfreezeWorkCar(id)
			workCarFreezeTimers[id] = setTimer(freezeWorkCar, 2500, 1, id)
			local x, y, z, rz = getWorkCarPosition(id)
			setElementPosition(workCars[id], x, y, z)
			setElementRotation(workCars[id], 0, 0, rz)
			if paintshopWorks[id].dryingState or paintshopWorks[id].boothClosed then
				checkDryingState()
			end
			loadingWorks = loadingWorks - 1
		end
	end
	paintjobData = nil
	maskData = nil
	syncData = nil
	collectgarbage("collect")
end)
addEvent("refreshPaintshopWorks", true)
addEventHandler("refreshPaintshopWorks", getRootElement(), function(ws, id, datas)
	if ws == currentWorkshop then
		--local id = convertWorkId(currentWorkshop, id)
		local stateChange = false
		local dryChange = false
		if id then
			if datas then
				if paintshopWorks[id] then
					for key, value in pairs(datas) do
						if key == "checking" then
							paintshopWorks[id].lastCheckClient = getTickCount()
						elseif key == "state" or key == "transportTrailer" then
							stateChange = paintshopWorks[id].state
						elseif key == "dryingState" then
							if value then
								paintshopWorks[id].dryingStart = getTickCount()
							end
							dryChange = true
						elseif key == "boothClosed" then
							dryChange = true
						end
						paintshopWorks[id][key] = value
					end
				end
			else
				paintshopWorks[id] = nil
				stateChange = true
				unsyncedData[id] = nil
				syncedData[id] = nil
				unsyncedPaintDelta[id] = nil
				dataToSync[id] = nil
			end
		end
		if stateChange then
			local engineSound = false
			if paintshopWorks[id] then
				if stateChange ~= paintshopWorks[id].state then
					engineSound = paintshopWorks[id].state == "sanding" or paintshopWorks[id].state == "primer" or paintshopWorks[id].state == "break" or paintshopWorks[id].state == "paint" or paintshopWorks[id].state == "transportOut"
				elseif paintshopWorks[id].state == "transportOut" then
					engineSound = paintshopWorks[id].transportTrailer
				end
			end
			if engineSound then
				local x, y, z, rz = getWorkCarPosition(id)
				local sound = playSound3D("files/drive.mp3", x, y, z)
				setElementInterior(sound, targetInt)
				setElementDimension(sound, currentWorkshop)
				setSoundMaxDistance(sound, 50)
			end
			if paintshopWorks[id] and paintshopWorks[id].state ~= "transportIn" and (paintshopWorks[id].state ~= "transportOut" or not paintshopWorks[id].transportTrailer) then
				if not isElement(workCars[id]) then
					createWorkCar(id, paintshopWorks[id].model)
					triggerLatentServerEvent("requestPaintshopWorkData", localPlayer, id)
					loadingWorks = loadingWorks + 1
				else
					createCarShader(id)
				end
				unfreezeWorkCar(id)
				workCarFreezeTimers[id] = setTimer(freezeWorkCar, 2500, 1, id)
				local x, y, z, rz = getWorkCarPosition(id)
				setElementPosition(workCars[id], x, y, z)
				setElementRotation(workCars[id], 0, 0, rz)
			else
				if isElement(workCars[id]) then
					destroyElement(workCars[id])
				end
				workCars[id] = false
				if wheelMasks[id] then
					for i = 1, #wheelMasks[id] do
						if isElement(wheelMasks[id][i]) then
							destroyElement(wheelMasks[id][i])
						end
					end
				end
				wheelMasks[id] = false
				if isElement(carShaders[id]) then
					destroyElement(carShaders[id])
				end
				carShaders[id] = nil
				if isElement(carHelperShaders[id]) then
					destroyElement(carHelperShaders[id])
				end
				carHelperShaders[id] = nil
				if isElement(carHideShader[id]) then
					destroyElement(carHideShader[id])
				end
				carHideShader[id] = nil
				if isElement(reflectionTextures[id]) then
					destroyElement(reflectionTextures[id])
				end
				reflectionTextures[id] = nil
			end
		end
		if dryChange then
			checkDryingState()
		end
		if currentWorkingCar == id then
			createCarWindow()
		end
	end
end)
function newPaintshopWork(i, dat)
	paintshopWorks[i] = dat
	paintshopWorks[i].color = paintshopWorks[i].color:gsub("#", "")
	paintshopWorks[i].colorRGB = {
		hexToRGB(paintshopWorks[i].color)
	}
	if paintshopWorks[i].dryingState then
		paintshopWorks[i].dryingStart = getTickCount()
	end
	if dat.state ~= "transportIn" and (dat.state ~= "transportOut" or not dat.transportTrailer) then
		createWorkCar(i, dat.model)
		triggerLatentServerEvent("requestPaintshopWorkData", localPlayer, i)
		loadingWorks = loadingWorks + 1
	end
end
addEvent("gotNewPaintshopWork", true)
addEventHandler("gotNewPaintshopWork", getRootElement(), function(ws, i, dat)
	if ws == currentWorkshop then
		newPaintshopWork(i, dat)
	end
end)
addEvent("gotPaintshopInit", true)
addEventHandler("gotPaintshopInit", getRootElement(), function(ws, dat, guns, sanders, tank, stock, maintenance, emails, order, rented, num, sum, perm, skins, upgrades, points)
	if ws == currentWorkshop then
		paintshopWorks = {}
		workshopRatingNum = num
		workshopRatingSum = sum
		workshopPermissions = perm
		for i = 1, 2 do
			if dat[i] then
				newPaintshopWork(i, dat[i])
			end
		end
		for i = 1, #guns do
			refreshPaintGunData(i, guns[i], true)
		end
		for i = 1, #sanders do
			refreshPaintSanderData(i, sanders[i], true)
		end
		mixerTank = tank
		paintStockData = stock
		for i = 1, #paintBoxOffsets do
			processPaintStockBoxes(i)
		end
		mixerMaintenance = maintenance
		for i = 1, 17 do
			processMixerMachineCasette(i)
		end
		processMixerRenderTarget()
		workshopOrder = order
		loadingShop = false
		workshopRented = rented
		workshopUpgrades = upgrades
		workshopPoints = points
		myCid = getElementData(localPlayer, "char.ID")
		isOwner = rented.rentedBy == myCid
		boothDrying = false
		boothClosed = false
		checkDryingState(true)
		boothDoor = (boothDrying or boothClosed) and 0 or 1
		for client in pairs(skins) do
			if isElement(client) then
				sightexports.sGroups:setDutySkinForceOff(client, true)
				setElementModel(client, models.paintshop_skin)
			end
		end
		gotPaintshopEmailList(emails)
	end
end)
local gunIconPoses = {
	{
		wsX - 8.3374,
		wsY - 1.9097,
		wsZ + 1.132
	},
	{
		wsX - 8.3374,
		wsY - 1.6389,
		wsZ + 1.132
	}
}
local lastToolPick = 0
function clickPaintshop(button, state)
	if state == "up" and not isLoading() and not bigLoader then
		if paintshopHover == "useMachineCasette" then
			if playerHoldingCasette then
				triggerServerEvent("tryPutInPaintMachineCasette", localPlayer, paintshopHoverId)
			else
				if not getPlayerPermission("mixerMaintenance") then
					sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
					return
				end
				triggerServerEvent("tryGetOutPaintMachineCasette", localPlayer, paintshopHoverId)
			end
		elseif paintshopHover == "useStockBox" then
			if not getPlayerPermission("mixerMaintenance") then
				sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
				return
			end
			triggerServerEvent("tryToUsePaintStockBox", localPlayer, paintshopHoverId)
		elseif paintshopHover == "useMixer" then
			createMixerWindow()
		elseif paintshopHover == "useComputer" then
			sightexports.sChat:localActionC(localPlayer, "bekapcsolja a számítógépet.")
			createComputerWindow()
		elseif paintshopHover == "useTrash" then
			if playerHoldingCasette then
				if not getPlayerPermission("mixerMaintenance") then
					sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
					return
				end
				triggerServerEvent("emptyPaintCasetteToTrash", localPlayer, playerHoldingCasette)
			elseif tankInHand then
				if not getPlayerPermission("useMixer") then
					sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
					return
				end
				triggerServerEvent("emptyPaintTankToTrash", localPlayer, tankInHand)
			end
		elseif paintshopHover == "mixerMachine" then
			if not getPlayerPermission("useMixer") then
				sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
				return
			end
			triggerServerEvent("tryToUsePaintShopMixerMachine", localPlayer, tankInHand)
		elseif paintshopHover == "primerMachine" then
			if not getPlayerPermission("useMixer") then
				sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
				return
			end
			triggerServerEvent("tryToUsePaintShopPrimerMachine", localPlayer, tankInHand)
		elseif paintshopHover == "booth" then
			if getTickCount() - lastToolPick < 1500 then
				sightexports.sGui:showInfobox("e", "Várj egy kicsit!")
				return
			end
			if not getPlayerPermission("toggleDry") then
				sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
				return
			end
			lastToolPick = getTickCount()
			triggerServerEvent("tryToUsePaintBooth", localPlayer)
		elseif paintshopHover == "paintSkin" then
			if not getPlayerPermission("useSkin") then
				sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
				return
			end
			triggerServerEvent("paintshopSetWorkSkin", localPlayer)
		elseif paintshopHover == "socket" then
			triggerServerEvent("tryToUsePaintShopSocket", localPlayer, playerSanders[localPlayer], paintshopHoverId)
		elseif paintshopHover == "sander" then
			if getTickCount() - lastToolPick < 1500 then
				sightexports.sGui:showInfobox("e", "Várj egy kicsit!")
				return
			end
			for i = 1, 2 do
				if dataToSync[i] or 0 < (unsyncedPaintDelta[i] or 0) then
					syncData(i)
				end
			end
			lastToolPick = getTickCount()
			triggerLatentServerEvent("tryToPickPaintShopSander", localPlayer, paintshopHoverId)
		elseif paintshopHover == "tank" then
			if getTickCount() - lastToolPick < 1500 then
				sightexports.sGui:showInfobox("e", "Várj egy kicsit!")
				return
			end
			for i = 1, 2 do
				if dataToSync[i] or 0 < (unsyncedPaintDelta[i] or 0) then
					syncData(i)
				end
			end
			lastToolPick = getTickCount()
			triggerLatentServerEvent("tryToPickPaintShopGun", localPlayer, paintshopHoverId, true)
		elseif paintshopHover == "gun" then
			if getTickCount() - lastToolPick < 1500 then
				sightexports.sGui:showInfobox("e", "Várj egy kicsit!")
				return
			end
			for i = 1, 2 do
				if dataToSync[i] or 0 < (unsyncedPaintDelta[i] or 0) then
					syncData(i)
				end
			end
			lastToolPick = getTickCount()
			triggerLatentServerEvent("tryToPickPaintShopGun", localPlayer, paintshopHoverId)
		end
	end
end
function processMixerRenderTarget()
	dxSetRenderTarget(mixerRenderTarget)
	dxSetBlendMode("modulate_add")
	dxDrawRectangle(0, 0, 1024, 576, tocolor(computerColorScheme.window[1], computerColorScheme.window[2], computerColorScheme.window[3]))
	dxDrawRectangle(0, 0, 1024, 24, tocolor(59, 119, 188))
	dxDrawText("Migu Italia PAINTMIX 1.2", 6, 0, 0, 24, tocolor(255, 255, 255), mixerFontScale * 0.9, mixerFont, "left", "center")
	local w = 56.888888888888886
	if loadedMixerRecipe then
		local hasColors = true
		for i = 1, #colorPalette do
			if 0 < validColors[loadedMixerRecipe][i] and mixerTank.color[i] < validColors[loadedMixerRecipe][i] then
				hasColors = false
				break
			end
		end
		if hasColors then
			local tw = dxGetTextWidth("Válassz alapot a festék keverésének indításához!", mixerFontScale * 0.9, mixerFont) + 16
			local x = w - 16
			local y = 32
			local h = 53
			dxDrawRectangle(x, y, tw, h, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3]))
			dxDrawText("Válassz alapot a festék keverésének indításához!", x, y + 4, x + tw, 0, tocolor(0, 0, 0), mixerFontScale * 0.9, mixerFont, "center", "top")
			x = x + tw / 2 - 164
			dxDrawRectangle(x, y + h - 20 - 4, 120, 20, tocolor(0, 0, 0))
			dxDrawRectangle(x + 1, y + h - 20 - 4 + 1, 118, 18, tocolor(205, 205, 225))
			if 1 > mixerTank.base[1] then
				dxDrawText("Normál (ÜRES)", x, y + h - 20 - 4, x + 120, y + h - 4, tocolor(computerColorScheme.red[1], computerColorScheme.red[2], computerColorScheme.red[3]), mixerFontScale * 0.75, mixerFont, "center", "center")
			else
				dxDrawText("Normál", x, y + h - 20 - 4, x + 120, y + h - 4, tocolor(0, 0, 0), mixerFontScale * 0.75, mixerFont, "center", "center")
			end
			x = x + 120 + 4
			dxDrawRectangle(x, y + h - 20 - 4, 120, 20, tocolor(0, 0, 0))
			dxDrawRectangle(x + 1, y + h - 20 - 4 + 1, 118, 18, tocolor(205, 205, 225))
			if 1 > mixerTank.base[2] then
				dxDrawText("Metalic (ÜRES)", x, y + h - 20 - 4, x + 120, y + h - 4, tocolor(computerColorScheme.red[1], computerColorScheme.red[2], computerColorScheme.red[3]), mixerFontScale * 0.75, mixerFont, "center", "center")
			else
				dxDrawText("Metalic", x, y + h - 20 - 4, x + 120, y + h - 4, tocolor(0, 0, 0), mixerFontScale * 0.75, mixerFont, "center", "center")
			end
			x = x + 120 + 4
			dxDrawRectangle(x, y + h - 20 - 4, 80, 20, tocolor(0, 0, 0))
			dxDrawRectangle(x + 1, y + h - 20 - 4 + 1, 78, 18, tocolor(205, 205, 225))
			dxDrawText("Mégsem", x, y + h - 20 - 4, x + 80, y + h - 4, tocolor(0, 0, 0), mixerFontScale * 0.75, mixerFont, "center", "center")
		else
			local tw = dxGetTextWidth("Nincs elegendő alapanyag! (Lásd: piros nyilak)", mixerFontScale * 0.9, mixerFont) + 16
			local x = w - 16
			local y = 32
			local h = 53
			dxDrawRectangle(x, y, tw, h, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3]))
			dxDrawText("Nincs elegendő alapanyag! (Lásd: piros nyilak)", x, y + 4, x + tw, 0, tocolor(computerColorScheme.red[1], computerColorScheme.red[2], computerColorScheme.red[3]), mixerFontScale * 0.9, mixerFont, "center", "top")
			dxDrawRectangle(x + tw / 2 - 30, y + h - 20 - 4, 60, 20, tocolor(0, 0, 0))
			dxDrawRectangle(x + tw / 2 - 30 + 1, y + h - 20 - 4 + 1, 58, 18, tocolor(205, 205, 225))
			dxDrawText("OK", x, y + h - 20 - 4, x + tw, y + h - 4, tocolor(0, 0, 0), mixerFontScale * 0.75, mixerFont, "center", "center")
		end
	else
		dxDrawImage(w - 16, 32, 115, 53, "files/logo.dds")
	end
	if mixerMaintenance then
		local tw = dxGetTextWidth("Karbantartás mód", mixerFontScale, mixerFont) + 16
		local x = 1024 - w + 16 - 8 - tw + 8
		local y = 32
		dxDrawRectangle(x, y, tw, 53, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3]))
		local found = false
		for i = 1, 17 do
			if mixerMaintenance[i] ~= true then
				found = true
				break
			end
		end
		if found then
			dxDrawText("Karbantartás mód\nHiányzó kazetták!", x, y, 1024 - w + 16, y + 53, tocolor(computerColorScheme.red[1], computerColorScheme.red[2], computerColorScheme.red[3]), mixerFontScale, mixerFont, "center", "center")
		else
			dxDrawText("Karbantartás mód", x, y + 4, 1024 - w + 16, 0, tocolor(0, 0, 0), mixerFontScale, mixerFont, "center", "top")
			dxDrawRectangle(x + tw / 2 - 40, y + 53 - 20 - 4, 80, 20, tocolor(0, 0, 0))
			dxDrawRectangle(x + tw / 2 - 40 + 1, y + 53 - 20 - 4 + 1, 78, 18, tocolor(205, 205, 225))
			dxDrawText("Kész", x, y + 53 - 20 - 4, x + tw, y + 53 - 4, tocolor(0, 0, 0), mixerFontScale * 0.75, mixerFont, "center", "center")
		end
	elseif mixerStarted then
		local tw = dxGetTextWidth("Betöltött recept:", mixerFontScale, mixerFont)
		dxDrawRectangle(971 - w + 16 - 8 - tw - 8, 32, 53 + tw + 16, 53, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3]))
		local r, g, b = hexToRGB(mixerStarted[17])
		dxDrawRectangle(971 - w + 16 + 2, 34, 49, 49, tocolor(r, g, b))
		dxDrawText("Betöltött recept:\n" .. validColorNames[mixerStarted[17]] .. (mixerStarted[2] and " (MET)" or ""), 971 - w + 16 - 8 - tw - 8, 32, 971 - w + 16, 85, tocolor(0, 0, 0), mixerFontScale, mixerFont, "center", "center")
	elseif loadedMixerRecipe then
		local tw = dxGetTextWidth("Betöltött recept:", mixerFontScale, mixerFont)
		dxDrawRectangle(971 - w + 16 - 8 - tw - 8, 32, 53 + tw + 16, 53, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3]))
		local r, g, b = hexToRGB(loadedMixerRecipe)
		dxDrawRectangle(971 - w + 16 + 2, 34, 49, 49, tocolor(r, g, b))
		dxDrawText("Betöltött recept:\n" .. validColorNames[loadedMixerRecipe], 971 - w + 16 - 8 - tw - 8, 32, 971 - w + 16, 85, tocolor(0, 0, 0), mixerFontScale, mixerFont, "center", "center")
	end
	local h = 427
	local x = w
	dxDrawRectangle(x - 16, 544, w * 16 + 32, 2, tocolor(computerColorScheme.window2[1], computerColorScheme.window2[2], computerColorScheme.window2[3]))
	dxDrawRectangle(x - 16, 544 - h, 2, h, tocolor(computerColorScheme.window2[1], computerColorScheme.window2[2], computerColorScheme.window2[3]))
	dxDrawRectangle(x + w * 16 + 16 - 2, 544 - h, 2, h, tocolor(computerColorScheme.window2[1], computerColorScheme.window2[2], computerColorScheme.window2[3]))
	for i = 1, 20 do
		dxDrawRectangle(x - 16, 544 - i * h / 20, w * 16 + 32, i % 5 == 0 and 2 or 1, tocolor(computerColorScheme.window2[1], computerColorScheme.window2[2], computerColorScheme.window2[3]))
	end
	local a = (mixerStarted or primerMachineStarted or loadedMixerRecipe) and 125 or 255
	dxDrawText("PRIMER", x, 548, x, 0, tocolor(0, 0, 0), mixerFontScale * 0.6, mixerFont, "center", "top")
	if mixerMaintenance and mixerMaintenance[1] ~= true then
		dxDrawImage(x - 16, 508, 32, 32, "files/err.dds", 0, 0, 0, tocolor(computerColorScheme.red[1], computerColorScheme.red[2], computerColorScheme.red[3]))
	else
		local percent = math.max(0, mixerTank.primer / mixerTankMaximum.primer)
		dxDrawRectangle(x + 16, 544 - h * percent, 2, h * percent, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3], a))
		dxDrawRectangle(x - 16, 544 - h * percent, 32, h * percent, tocolor(primerR, primerG, primerB, a))
		if primerMachineStarted then
			local delta = getTickCount() - primerMachineStarted
			local f = 0.1
			local p = delta / 5000
			p = math.min(1, math.max(0, p - f))
			local plus = math.max(0, (1 - p) / mixerTankMaximum.base)
			if p < 1 then
				dxDrawImage(x - 16, 544 - h * (percent + plus) - 16 - 6, 32, 16, "files/tri.dds", 0, 0, 0, tocolor(0, 0, 0))
			end
			dxDrawRectangle(x + 16, 544 - h * (percent + plus), 2, h * plus, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3], 255))
			dxDrawRectangle(x - 16, 544 - h * (percent + plus), 32, h * plus, tocolor(primerR, primerG, primerB))
		elseif not mixerStarted and not primerMachineStarted and not loadedMixerRecipe then
			dxDrawText(math.floor(percent * 100) .. "%", x, 0, x, 544 - h * percent - 4, tocolor(0, 0, 0), mixerFontScale * 0.75, mixerFont, "center", "bottom")
		end
	end
	local a = mixerStarted and 125 or 255
	x = x + w
	dxDrawText("BASE", x, 548, x, 0, tocolor(0, 0, 0), mixerFontScale * 0.6, mixerFont, "center", "top")
	if mixerMaintenance and mixerMaintenance[2] ~= true then
		dxDrawImage(x - 16, 508, 32, 32, "files/err.dds", 0, 0, 0, tocolor(computerColorScheme.red[1], computerColorScheme.red[2], computerColorScheme.red[3]))
	else
		local percent = 0
		if loadedMixerRecipe then
			percent = math.max(0, (mixerTank.base[1] - 1) / mixerTankMaximum.base)
		else
			percent = math.max(0, mixerTank.base[1] / mixerTankMaximum.base)
		end
		dxDrawRectangle(x + 16, 544 - h * percent, 2, h * percent, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3], a))
		dxDrawRectangle(x - 16, 544 - h * percent, 32, h * percent, tocolor(255, 255, 255, a))
		if mixerStarted then
			if not mixerStarted[2] then
				local plus = math.max(0, (1 - mixerStarted[1]) / mixerTankMaximum.base)
				if mixerStarted[1] < 1 then
					dxDrawImage(x - 16, 544 - h * (percent + plus) - 16 - 6, 32, 16, "files/tri.dds", 0, 0, 0, tocolor(0, 0, 0))
				end
				dxDrawRectangle(x + 16, 544 - h * (percent + plus), 2, h * plus, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3], 255))
				dxDrawRectangle(x - 16, 544 - h * (percent + plus), 32, h * plus, tocolor(255, 255, 255))
			end
		elseif loadedMixerRecipe then
			local plus = math.min(percent, 1 / mixerTankMaximum.base)
			dxDrawRectangle(x + 16, 544 - h * (percent + plus), 2, h * plus, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3], 125))
			dxDrawRectangle(x - 16, 544 - h * (percent + plus), 32, h * plus, tocolor(255, 255, 255, 125))
		else
			dxDrawText(math.floor(percent * 100) .. "%", x, 0, x, 544 - h * percent - 4, tocolor(0, 0, 0), mixerFontScale * 0.75, mixerFont, "center", "bottom")
		end
	end
	x = x + w
	dxDrawText("METALIC", x, 548, x, 0, tocolor(0, 0, 0), mixerFontScale * 0.6, mixerFont, "center", "top")
	if mixerMaintenance and mixerMaintenance[3] ~= true then
		dxDrawImage(x - 16, 508, 32, 32, "files/err.dds", 0, 0, 0, tocolor(computerColorScheme.red[1], computerColorScheme.red[2], computerColorScheme.red[3]))
	else
		local percent = 0
		if loadedMixerRecipe then
			percent = math.max(0, (mixerTank.base[2] - 1) / mixerTankMaximum.base)
		else
			percent = math.max(0, mixerTank.base[2] / mixerTankMaximum.base)
		end
		dxDrawRectangle(x + 16, 544 - h * percent, 2, h * percent, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3], a))
		dxDrawRectangle(x - 16, 544 - h * percent, 32, h * percent, tocolor(255, 255, 255, a))
		if mixerStarted then
			if mixerStarted[2] then
				local plus = math.max(0, (1 - mixerStarted[1]) / mixerTankMaximum.base)
				if mixerStarted[1] < 1 then
					dxDrawImage(x - 16, 544 - h * (percent + plus) - 16 - 6, 32, 16, "files/tri.dds", 0, 0, 0, tocolor(0, 0, 0))
				end
				dxDrawRectangle(x + 16, 544 - h * (percent + plus), 2, h * plus, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3], 255))
				dxDrawRectangle(x - 16, 544 - h * (percent + plus), 32, h * plus, tocolor(255, 255, 255))
			end
		elseif loadedMixerRecipe then
			local plus = math.min(percent, 1 / mixerTankMaximum.base)
			dxDrawRectangle(x + 16, 544 - h * (percent + plus), 2, h * plus, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3], 125))
			dxDrawRectangle(x - 16, 544 - h * (percent + plus), 32, h * plus, tocolor(255, 255, 255, 125))
		else
			dxDrawText(math.floor(percent * 100) .. "%", x, 0, x, 544 - h * percent - 4, tocolor(0, 0, 0), mixerFontScale * 0.75, mixerFont, "center", "bottom")
		end
	end
	x = x + w
	local foundColor = false
	if mixerStarted and mixerStarted[1] < 1 then
		foundColor = true
	end
	for i = 1, #colorPalette do
		dxDrawText(colorNames[i], x, 548, x, 0, tocolor(0, 0, 0), mixerFontScale * 0.6, mixerFont, "center", "top")
		if mixerMaintenance and mixerMaintenance[i + 3] ~= true then
			dxDrawImage(x - 16, 508, 32, 32, "files/err.dds", 0, 0, 0, tocolor(computerColorScheme.red[1], computerColorScheme.red[2], computerColorScheme.red[3]))
		else
			local percent = 0
			if loadedMixerRecipe then
				percent = math.max(0, (mixerTank.color[i] - validColors[loadedMixerRecipe][i]) / mixerTankMaximum.color)
			else
				percent = math.max(0, mixerTank.color[i] / mixerTankMaximum.color)
			end
			dxDrawRectangle(x + 16, 544 - h * percent, 2, h * percent, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3], a))
			dxDrawRectangle(x - 16, 544 - h * percent, 32, h * percent, tocolor(colorPalette[i][1], colorPalette[i][2], colorPalette[i][3], a))
			if mixerStarted then
				local plus = math.max(0, mixerStarted[3][i] / mixerTankMaximum.color)
				if not foundColor and 0 < plus then
					dxDrawImage(x - 16, 544 - h * (percent + plus) - 16 - 6, 32, 16, "files/tri.dds", 0, 0, 0, tocolor(0, 0, 0))
					foundColor = true
				end
				dxDrawRectangle(x + 16, 544 - h * (percent + plus), 2, h * plus, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3], 255))
				dxDrawRectangle(x - 16, 544 - h * (percent + plus), 32, h * plus, tocolor(colorPalette[i][1], colorPalette[i][2], colorPalette[i][3], 255))
			elseif loadedMixerRecipe then
				local plus = math.max(0, validColors[loadedMixerRecipe][i] / mixerTankMaximum.color)
				if 0 < plus then
					dxDrawImage(x - 16, 544 - h * (percent + plus) - 16 - 6, 32, 16, "files/tri.dds", 0, 0, 0, plus <= mixerTank.color[i] / mixerTankMaximum.color and tocolor(0, 0, 0) or tocolor(computerColorScheme.red[1], computerColorScheme.red[2], computerColorScheme.red[3]))
				end
				dxDrawRectangle(x + 16, 544 - h * (percent + plus), 2, h * plus, tocolor(computerColorScheme.window3[1], computerColorScheme.window3[2], computerColorScheme.window3[3], 125))
				dxDrawRectangle(x - 16, 544 - h * (percent + plus), 32, h * plus, tocolor(colorPalette[i][1], colorPalette[i][2], colorPalette[i][3], 125))
			else
				dxDrawText(math.floor(percent * 100) .. "%", x, 0, x, 544 - h * percent - 4, tocolor(0, 0, 0), mixerFontScale * 0.75, mixerFont, "center", "bottom")
			end
		end
		x = x + w
	end
	if not mixerMaintenance then
		if mixerStarted then
			if not foundColor then
				dxDrawRectangle(361, 223, 303, 131, tocolor(computerColorScheme.window2[1], computerColorScheme.window2[2], computerColorScheme.window2[3]))
				dxDrawRectangle(362, 224, 300, 128, tocolor(computerColorScheme.window[1], computerColorScheme.window[2], computerColorScheme.window[3]))
				dxDrawRectangle(362, 224, 300, 24, tocolor(59, 119, 188))
				dxDrawText("Migu Italia PAINTMIX 1.2", 368, 224, 0, 248, tocolor(255, 255, 255), mixerFontScale * 0.9, mixerFont, "left", "center")
				dxDrawText("Festék keverése folyamatban...\n\nKérlek várj!", 362, 248, 662, 352, tocolor(0, 0, 0), mixerFontScale, mixerFont, "center", "center")
			end
		elseif not loadedMixerRecipe then
			local found = false
			for i = 1, #sprayGuns do
				if paintGunDatas[i].tank == "mixer" and not paintGunDatas[i].paintType and 0 >= paintGunDatas[i].paintLevel then
					local w = 300
					local h = 120
					local x = 512 - w / 2
					local y = 288 - h / 2
					dxDrawRectangle(x - 1, y - 1, w + 3, h + 3, tocolor(computerColorScheme.window2[1], computerColorScheme.window2[2], computerColorScheme.window2[3]))
					dxDrawRectangle(x, y, w, h, tocolor(computerColorScheme.window[1], computerColorScheme.window[2], computerColorScheme.window[3]))
					dxDrawRectangle(x, y, w, 24, tocolor(59, 119, 188))
					dxDrawText("Migu Italia PAINTMIX 1.2", x + 6, y, 0, y + 24, tocolor(255, 255, 255), mixerFontScale * 0.9, mixerFont, "left", "center")
					y = y + 24
					dxDrawText("Add meg a színkódot!", x, y, x + w, y + 32, tocolor(0, 0, 0), mixerFontScale, mixerFont, "center", "center")
					y = y + 32
					dxDrawRectangle(x + 8, y + 16 - 12, w - 16, 24, tocolor(0, 0, 0))
					dxDrawRectangle(x + 8 + 1, y + 16 - 12 + 1, w - 16 - 2, 22, tocolor(255, 255, 250))
					y = y + 32
					dxDrawRectangle(x + w / 2 - 30, y + 16 - 12, 60, 24, tocolor(0, 0, 0))
					dxDrawRectangle(x + w / 2 - 30 + 1, y + 16 - 12 + 1, 58, 22, tocolor(205, 205, 225))
					dxDrawText("OK", x, y, x + w, y + 32, tocolor(0, 0, 0), mixerFontScale * 0.85, mixerFont, "center", "center")
					found = true
				end
			end
			if not found then
				dxDrawRectangle(1024 - w + 16 - 150, 46.5, 150, 24, tocolor(0, 0, 0))
				dxDrawRectangle(1024 - w + 16 - 150 + 1, 47.5, 148, 22, tocolor(205, 205, 225))
				dxDrawText("Karbantartás mód", 1024 - w + 16 - 150, 32, 1024 - w + 16, 85, tocolor(0, 0, 0), mixerFontScale * 0.75, mixerFont, "center", "center")
			end
		end
	end
	dxSetBlendMode("blend")
	dxSetRenderTarget()
end
function deleteMixerWindow()
	local x, y
	if mixerWindow then
		x, y = sightexports.sGui:getGuiPosition(mixerWindow)
		sightexports.sGui:deleteGuiElement(mixerWindow)
	end
	mixerWindow = false
	mixerInput = false
	return x, y
end
addEvent("closePaintMixerWindow", false)
addEventHandler("closePaintMixerWindow", getRootElement(), function()
	deleteMixerWindow()
	processMixerRenderTarget()
end)
addEvent("cancelPaintMixerRecipe", false)
addEventHandler("cancelPaintMixerRecipe", getRootElement(), function()
	loadedMixerRecipe = false
	createMixerWindow()
end)
addEvent("startPaintMixerRecipeNormal", false)
addEventHandler("startPaintMixerRecipeNormal", getRootElement(), function()
	for i = 1, #sprayGuns do
		if paintGunDatas[i].tank == "mixer" and not paintGunDatas[i].paintType and paintGunDatas[i].paintLevel <= 0 then
			triggerServerEvent("tryToStartPaintMixing", localPlayer, i, loadedMixerRecipe, false)
			return
		end
	end
end)
addEvent("startPaintMixerRecipeMetal", false)
addEventHandler("startPaintMixerRecipeMetal", getRootElement(), function()
	for i = 1, #sprayGuns do
		if paintGunDatas[i].tank == "mixer" and not paintGunDatas[i].paintType and paintGunDatas[i].paintLevel <= 0 then
			triggerServerEvent("tryToStartPaintMixing", localPlayer, i, loadedMixerRecipe, true)
			return
		end
	end
end)
addEvent("selectPaintMixerRecipe", false)
addEventHandler("selectPaintMixerRecipe", getRootElement(), function()
	if not getPlayerPermission("useMixer") then
		sightexports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
		return
	end
	local val = sightexports.sGui:getInputValue(mixerInput)
	if val then
		val = utf8.upper(val)
		if colorNameBackward[val] then
			loadedMixerRecipe = colorNameBackward[val]
			createMixerWindow()
		else
			local sound = playSound3D("files/error.mp3", mixerX + 0.01264, mixerY + 1.83547, mixerZ + 0.162247)
			setElementInterior(sound, targetInt)
			setElementDimension(sound, currentWorkshop)
			local w = 300
			local h = 120
			local x = 512 - w / 2
			local y = 288 - h / 2
			y = y + 24
			dxSetRenderTarget(mixerRenderTarget)
			dxSetBlendMode("modulate_add")
			dxDrawRectangle(x, y, w, 32, tocolor(computerColorScheme.window[1], computerColorScheme.window[2], computerColorScheme.window[3]))
			dxDrawText("Hibás színkód!", x, y, x + w, y + 32, tocolor(computerColorScheme.red[1], computerColorScheme.red[2], computerColorScheme.red[3]), mixerFontScale, mixerFont, "center", "center")
			dxSetBlendMode("blend")
			dxSetRenderTarget()
		end
	end
end)
addEvent("toggleMixerMaintenanceMode", false)
addEventHandler("toggleMixerMaintenanceMode", getRootElement(), function()
	triggerServerEvent("tryToToggleMixerMaintenanceMode", localPlayer)
end)
function createMixerWindow()
	processMixerRenderTarget()
	local x, y = deleteMixerWindow()
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local pw, ph = 1028, 576 + titleBarHeight + 4
	mixerWindow = sightexports.sGui:createGuiElement("window", x or screenX / 2 - pw / 2, y or screenY / 2 - ph / 2, pw, ph)
	sightexports.sGui:setWindowTitle(mixerWindow, "16/BebasNeueRegular.otf", "Keverőgép")
	sightexports.sGui:setWindowCloseButton(mixerWindow, "closePaintMixerWindow")
	sightexports.sGui:setDisableClickSound(mixerWindow, false, true)
	x, y = 2, titleBarHeight + 2
	local image = sightexports.sGui:createGuiElement("image", x, y, 1024, 576, mixerWindow)
	sightexports.sGui:setImageFile(image, mixerRenderTarget)
	if mixerMaintenance then
		local tw = dxGetTextWidth("Karbantartás mód", mixerFontScale, mixerFont) + 16
		local w = 56.888888888888886
		x = x + 1024 - w + 16 - 8 - tw + 8
		y = y + 24 + 8
		local found = false
		for i = 1, 17 do
			if mixerMaintenance[i] ~= true then
				found = true
				break
			end
		end
		if not found then
			local btn = sightexports.sGui:createGuiElement("button", x + tw / 2 - 40, y + 53 - 20 - 4, 80, 20, mixerWindow)
			sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
			sightexports.sGui:setButtonText(btn, "Kész")
			sightexports.sGui:setClickEvent(btn, "toggleMixerMaintenanceMode")
			setButtonScheme(btn)
		end
	elseif not mixerStarted then
		if loadedMixerRecipe then
			local hasColors = true
			for i = 1, #colorPalette do
				if validColors[loadedMixerRecipe][i] > 0 and mixerTank.color[i] < validColors[loadedMixerRecipe][i] then
					hasColors = false
					break
				end
			end
			local w = 56.888888888888886
			local h = 53
			x = x + w - 16
			y = y + 24 + 8
			if hasColors then
				local tw = dxGetTextWidth("Válassz alapot a festék keverésének indításához!", mixerFontScale * 0.9, mixerFont) + 16
				x = x + tw / 2 - 164
				if 1 <= mixerTank.base[1] then
					local btn = sightexports.sGui:createGuiElement("button", x, y + h - 20 - 4, 120, 20, mixerWindow)
					sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
					sightexports.sGui:setButtonText(btn, "Normál")
					sightexports.sGui:setClickEvent(btn, "startPaintMixerRecipeNormal")
					setButtonScheme(btn)
				end
				x = x + 120 + 4
				if 1 <= mixerTank.base[2] then
					local btn = sightexports.sGui:createGuiElement("button", x, y + h - 20 - 4, 120, 20, mixerWindow)
					sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
					sightexports.sGui:setButtonText(btn, "Metalic")
					sightexports.sGui:setClickEvent(btn, "startPaintMixerRecipeMetal")
					setButtonScheme(btn)
				end
				x = x + 120 + 4
				local btn = sightexports.sGui:createGuiElement("button", x, y + h - 20 - 4, 80, 20, mixerWindow)
				sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
				sightexports.sGui:setButtonText(btn, "Mégsem")
				sightexports.sGui:setClickEvent(btn, "cancelPaintMixerRecipe")
				setButtonScheme(btn)
			else
				local tw = dxGetTextWidth("Nincs elegendő alapanyag! (Lásd: piros nyilak)", mixerFontScale * 0.9, mixerFont) + 16
				local btn = sightexports.sGui:createGuiElement("button", x + tw / 2 - 30, y + h - 20 - 4, 60, 20, mixerWindow)
				sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
				sightexports.sGui:setButtonText(btn, "OK")
				sightexports.sGui:setClickEvent(btn, "cancelPaintMixerRecipe")
				setButtonScheme(btn)
			end
		else
			for i = 1, #sprayGuns do
				if paintGunDatas[i].tank == "mixer" and not paintGunDatas[i].paintType and 0 >= paintGunDatas[i].paintLevel then
					local w = 300
					local h = 120
					x = x + 512 - w / 2
					y = y + 288 - h / 2
					y = y + 24 + 32
					mixerInput = sightexports.sGui:createGuiElement("input", x + 8, y + 16 - 12, w - 16, 24, mixerWindow)
					sightexports.sGui:setInputPlaceholder(mixerInput, "Színkód")
					sightexports.sGui:setInputMaxLength(mixerInput, 12)
					sightexports.sGui:setInputFont(mixerInput, "10/Ubuntu-L.ttf")
					sightexports.sGui:setInputColor(mixerInput, "#454545", "#ffffff", false, "#353535", "#000000")
					y = y + 32
					local btn = sightexports.sGui:createGuiElement("button", x + w / 2 - 30, y + 16 - 12, 60, 24, mixerWindow)
					sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
					sightexports.sGui:setButtonText(btn, "OK")
					sightexports.sGui:setClickEvent(btn, "selectPaintMixerRecipe")
					setButtonScheme(btn)
					local scan = sightexports.sGui:createGuiElement("image", 2, titleBarHeight + 2, 1024, 576, mixerWindow)
					sightexports.sGui:setImageFile(scan, ":sPaintshop/files/scan.dds")
					sightexports.sGui:setImageColor(scan, {
						255,
						255,
						255,
						150
					})
					return
				end
			end
			local w = 56.888888888888886
			local btn = sightexports.sGui:createGuiElement("button", 1026 - w + 16 - 150, titleBarHeight + 2 + 24 + 8 + 26.5 - 12, 150, 24, mixerWindow)
			sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
			sightexports.sGui:setButtonText(btn, "Karbantartás mód")
			sightexports.sGui:setClickEvent(btn, "toggleMixerMaintenanceMode")
			setButtonScheme(btn)
		end
	end
	local scan = sightexports.sGui:createGuiElement("image", 2, titleBarHeight + 2, 1024, 576, mixerWindow)
	sightexports.sGui:setImageFile(scan, ":sPaintshop/files/scan.dds")
	sightexports.sGui:setImageColor(scan, {
		255,
		255,
		255,
		150
	})
end
function renderPaintshop()
	local now = getTickCount()
	local time = getRealTime()
	local t = time.second / 60
	setElementRotation(clockObjects[1], 0, -t * 360, 0)
	t = (time.minute + t) / 60
	setElementRotation(clockObjects[2], 0, -t * 360, 0)
	t = (time.hour + t) / 24
	setElementRotation(clockObjects[3], 0, -t * 720, 0)
	if dateLabel then
		local date = string.format([[
%02d:%02d
%04d. %02d. %02d.]], time.hour, time.minute, time.year + 1900, time.month + 1, time.monthday)
		if date ~= currentDate then
			currentDate = date
			sightexports.sGui:setLabelText(dateLabel, currentDate)
		end
	end
	local px, py, pz = getElementPosition(localPlayer)
	local tmp = false
	local tmpId = false
	if boothDoor <= 0 or 1 <= boothDoor then
		local x, y, z = wsX - 1.7918, wsY + 7.352, wsZ + 1.3518
		local d = getDistanceBetweenPoints2D(px, py, x, y)
		if d < 1.5 then
			local x, y = getScreenFromWorldPosition(x, y, z, 128)
			if x then
				local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
				dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
				if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
					dxDrawImage(x - 16, y - 16, 32, 32, "files/turnon.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
					tmp = "booth"
					tmpId = i
				else
					dxDrawImage(x - 16, y - 16, 32, 32, "files/turnon.dds", 0, 0, 0, tocolor(255, 255, 255, a))
				end
			end
		end
	end
	if not playerGuns[localPlayer] and not tankInHand and not playerHoldingCasette then
		for i = 1, #sanderPosition do
			local x, y, z = wsX + sanderPosition[i][1], wsY + sanderPosition[i][2], wsZ + sanderPosition[i][3]
			local d = getDistanceBetweenPoints2D(px, py, x, y)
			if d < 1.5 then
				local canDraw = false
				if sanderMachineDatas[i] and sanderMachineDatas[i].player then
					if sanderMachineDatas[i].player == localPlayer then
						canDraw = true
					end
				elseif not playerSanders[localPlayer] then
					canDraw = true
				end
				if canDraw then
					local x, y = getScreenFromWorldPosition(x, y, z, 128)
					if x then
						local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
						dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
						if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
							dxDrawImage(x - 16, y - 16, 32, 32, "files/sander.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
							tmp = "sander"
							tmpId = i
						else
							dxDrawImage(x - 16, y - 16, 32, 32, "files/sander.dds", 0, 0, 0, tocolor(255, 255, 255, a))
						end
					end
				end
			end
		end
	end
	local sander = playerSanders[localPlayer]
	if sander then
		local i = sanderMachineDatas[sander].socket
		if i then
			local x, y, z = wsX + sanderSockets[i][1], wsY + sanderSockets[i][2], wsZ + sanderSockets[i][3]
			local d = getDistanceBetweenPoints2D(px, py, x, y)
			if d < 1.5 then
				local x, y = getScreenFromWorldPosition(x, y, z, 128)
				if x then
					local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
					dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
					if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
						dxDrawImage(x - 16, y - 16, 32, 32, "files/plug.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
						tmp = "socket"
						tmpId = i
					else
						dxDrawImage(x - 16, y - 16, 32, 32, "files/plug.dds", 0, 0, 0, tocolor(255, 255, 255, a))
					end
				end
			end
		else
			for i = 1, #sanderSockets do
				if not socketUsed[i] then
					local x, y, z = wsX + sanderSockets[i][1], wsY + sanderSockets[i][2], wsZ + sanderSockets[i][3]
					local d = getDistanceBetweenPoints2D(px, py, x, y)
					if d < 1.5 then
						local x, y = getScreenFromWorldPosition(x, y, z, 128)
						if x then
							local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
							dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
							if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
								dxDrawImage(x - 16, y - 16, 32, 32, "files/plug.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
								tmp = "socket"
								tmpId = i
							else
								dxDrawImage(x - 16, y - 16, 32, 32, "files/plug.dds", 0, 0, 0, tocolor(255, 255, 255, a))
							end
						end
					end
				end
			end
		end
	elseif not playerHoldingCasette and not mixerWindow then
		for i = 1, #gunIconPoses do
			local x, y, z = gunIconPoses[i][1], gunIconPoses[i][2], gunIconPoses[i][3]
			local d = getDistanceBetweenPoints2D(px, py, x, y)
			if d < 1.5 then
				local x, y = getScreenFromWorldPosition(x, y, z, 128)
				if x then
					local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
					if paintGunDatas[i] and paintGunDatas[i].player then
						if paintGunDatas[i].player == localPlayer then
							dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
							if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
								if paintGunDatas[i].tank then
									dxDrawImage(x - 16, y - 16, 32, 32, "files/tankin.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
									tmp = "tank"
								else
									dxDrawImage(x - 16, y - 16, 32, 32, "files/gun.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
									tmp = "gun"
								end
								tmpId = i
							elseif paintGunDatas[i].tank then
								dxDrawImage(x - 16, y - 16, 32, 32, "files/tankin.dds", 0, 0, 0, tocolor(255, 255, 255, a))
							else
								dxDrawImage(x - 16, y - 16, 32, 32, "files/gun.dds", 0, 0, 0, tocolor(255, 255, 255, a))
							end
						end
					elseif not paintGunDatas[i].tank and not playerGuns[localPlayer] then
						dxDrawRectangle(x - 18, y - 36 - 4, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
						if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 36 - 4 and cy <= y - 4 then
							dxDrawImage(x - 16, y - 36 - 4 + 2, 32, 32, "files/tankout.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
							tmp = "tank"
							tmpId = i
						else
							dxDrawImage(x - 16, y - 36 - 4 + 2, 32, 32, "files/tankout.dds", 0, 0, 0, tocolor(255, 255, 255, a))
						end
						dxDrawRectangle(x - 18, y + 4, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
						if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y + 4 and cy <= y + 4 + 36 then
							dxDrawImage(x - 16, y + 4 + 2, 32, 32, "files/gun.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
							tmp = "gun"
							tmpId = i
						else
							dxDrawImage(x - 16, y + 4 + 2, 32, 32, "files/gun.dds", 0, 0, 0, tocolor(255, 255, 255, a))
						end
					end
				end
			end
		end
	end
	if tankInHand or playerHoldingCasette then
		local x, y, z = wsX - 0.63279, wsY - 10.5016, wsZ + 0.870294
		local d = getDistanceBetweenPoints2D(px, py, x, y)
		if d < 1.5 then
			local x, y = getScreenFromWorldPosition(x, y, z, 128)
			if x then
				local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
				dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
				if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
					dxDrawImage(x - 16, y - 16, 32, 32, "files/trash.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
					tmp = "useTrash"
				else
					dxDrawImage(x - 16, y - 16, 32, 32, "files/trash.dds", 0, 0, 0, tocolor(255, 255, 255, a))
				end
			end
		end
	end
	if tankInHand then
		if not mixerMaintenance then
			if not primerMachineStarted then
				local x, y, z = mixerX - 0.0085, mixerY - 2.4809, mixerZ - 0.0488
				local d = getDistanceBetweenPoints2D(px, py, x, y)
				if d < 1.5 then
					local x, y = getScreenFromWorldPosition(x, y, z, 128)
					if x then
						local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
						dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
						if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
							dxDrawImage(x - 16, y - 16, 32, 32, "files/tankin2.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
							tmp = "primerMachine"
						else
							dxDrawImage(x - 16, y - 16, 32, 32, "files/tankin2.dds", 0, 0, 0, tocolor(255, 255, 255, a))
						end
					end
				end
			end
			if not mixerStarted then
				local x, y, z = mixerX - 0.0085, mixerY + mixerSliderPosition, mixerZ - 0.087629 + 0.165
				local d = getDistanceBetweenPoints2D(px, py, x, y)
				if d < 1.5 then
					local x, y = getScreenFromWorldPosition(x, y, z, 128)
					if x then
						local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
						dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
						if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
							dxDrawImage(x - 16, y - 16, 32, 32, "files/tankin2.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
							tmp = "mixerMachine"
						else
							dxDrawImage(x - 16, y - 16, 32, 32, "files/tankin2.dds", 0, 0, 0, tocolor(255, 255, 255, a))
						end
					end
				end
			end
		end
	else
		if playerHoldingCasette then
			local i = playerHoldingCasette
			local x, y, z
			if i == 1 then
				x, y, z = mixerX + 0.018, mixerY - 2.4809, mixerZ + 0.548
			elseif i <= 3 then
				local j = i - 1
				x, y, z = mixerX + mixerBaseOffsets[j][1], mixerY + mixerBaseOffsets[j][2], mixerZ + mixerBaseOffsets[j][3]
			else
				local j = i - 3
				x, y, z = mixerX + mixerColorOffets[j][1], mixerY + mixerColorOffets[j][2], mixerZ + mixerColorOffets[j][3]
			end
			x = x + 0.15
			local d = getDistanceBetweenPoints2D(px, py, x, y)
			if d < 1.5 then
				local x, y = getScreenFromWorldPosition(x, y, z, 128)
				if x then
					local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
					dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
					if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
						dxDrawImage(x - 16, y - 16, 32, 32, "files/machin.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
						tmp = "useMachineCasette"
						tmpId = i
					else
						dxDrawImage(x - 16, y - 16, 32, 32, "files/machin.dds", 0, 0, 0, tocolor(255, 255, 255, a))
					end
				end
			end
		elseif mixerMaintenance and not mixerWindow then
			for i = 1, 17 do
				if mixerMaintenance[i] == true then
					local x, y, z
					if i == 1 then
						x, y, z = mixerX + 0.018, mixerY - 2.4809, mixerZ + 0.548
					elseif i <= 3 then
						local j = i - 1
						x, y, z = mixerX + mixerBaseOffsets[j][1], mixerY + mixerBaseOffsets[j][2], mixerZ + mixerBaseOffsets[j][3]
					else
						local j = i - 3
						x, y, z = mixerX + mixerColorOffets[j][1], mixerY + mixerColorOffets[j][2], mixerZ + mixerColorOffets[j][3]
					end
					x = x + 0.15
					local d = getDistanceBetweenPoints2D(px, py, x, y)
					if d < 1.5 then
						local x, y = getScreenFromWorldPosition(x, y, z, 128)
						if x then
							local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
							dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
							if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
								dxDrawImage(x - 16, y - 16, 32, 32, "files/machout.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
								tmp = "useMachineCasette"
								tmpId = i
							else
								dxDrawImage(x - 16, y - 16, 32, 32, "files/machout.dds", 0, 0, 0, tocolor(255, 255, 255, a))
							end
						end
					end
				end
			end
		else
			if not primerMachineStarted then
				local x, y, z = mixerX - 0.0085, mixerY - 2.4809, mixerZ - 0.0488
				local d = getDistanceBetweenPoints2D(px, py, x, y)
				if d < 1.5 then
					for i = 1, #paintGunDatas do
						if paintGunDatas[i].tank == "primer" then
							local x, y = getScreenFromWorldPosition(x, y, z, 128)
							if x then
								local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
								dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
								if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
									dxDrawImage(x - 16, y - 16, 32, 32, "files/tankout2.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
									tmp = "primerMachine"
									break
								end
								dxDrawImage(x - 16, y - 16, 32, 32, "files/tankout2.dds", 0, 0, 0, tocolor(255, 255, 255, a))
							end
							break
						end
					end
				end
			end
			if not mixerStarted then
				local x, y, z = mixerX - 0.0085, mixerY + mixerSliderPosition, mixerZ - 0.087629 + 0.165
				local d = getDistanceBetweenPoints2D(px, py, x, y)
				if d < 1.5 then
					for i = 1, #paintGunDatas do
						if paintGunDatas[i].tank == "mixer" then
							local x, y = getScreenFromWorldPosition(x, y, z, 128)
							if x then
								local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
								dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
								if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
									dxDrawImage(x - 16, y - 16, 32, 32, "files/tankout2.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
									tmp = "mixerMachine"
									tmpId = i
									break
								end
								dxDrawImage(x - 16, y - 16, 32, 32, "files/tankout2.dds", 0, 0, 0, tocolor(255, 255, 255, a))
							end
							break
						end
					end
				end
			end
		end
		for i = 1, #paintBoxOffsets do
			if paintStockData[i][2] then
				local x, y, z = wsX + paintBoxOffsets[i][1], wsY + paintBoxOffsets[i][2], wsZ + paintBoxOffsets[i][3] + 0.25
				local d = getDistanceBetweenPoints2D(px, py, x, y)
				if d < 1.5 then
					local x, y = getScreenFromWorldPosition(x, y, z, 128)
					if x then
						local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
						dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
						local icon = "cut"
						if tonumber(paintStockData[i][2]) then
							icon = "boxout"
						end
						if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
							dxDrawImage(x - 16, y - 16, 32, 32, "files/" .. icon .. ".dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
							tmp = "useStockBox"
							tmpId = i
						else
							dxDrawImage(x - 16, y - 16, 32, 32, "files/" .. icon .. ".dds", 0, 0, 0, tocolor(255, 255, 255, a))
						end
					end
				end
			end
		end
	end
	local x, y, z = wsX + 3.0706, wsY - 3.6492, wsZ + 0.9472
	local d = getDistanceBetweenPoints2D(px, py, x, y)
	if computerWindow then
		if 1.5 < d then
			deleteComputerWindow()
		end
	elseif d < 1.5 then
		local x, y = getScreenFromWorldPosition(x, y, z, 128)
		if x then
			local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
			dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
			if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
				dxDrawImage(x - 16, y - 16, 32, 32, "files/computer.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
				tmp = "useComputer"
			else
				dxDrawImage(x - 16, y - 16, 32, 32, "files/computer.dds", 0, 0, 0, tocolor(255, 255, 255, a))
			end
		end
	end
	local x, y, z = wsX + 4.7274, wsY - 3.7523, wsZ + 1.1169
	local d = getDistanceBetweenPoints2D(px, py, x, y)
	if d < 1.5 then
		local x, y = getScreenFromWorldPosition(x, y, z, 128)
		if x then
			local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
			dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
			if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
				dxDrawImage(x - 16, y - 16, 32, 32, "files/skin.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
				tmp = "paintSkin"
			else
				dxDrawImage(x - 16, y - 16, 32, 32, "files/skin.dds", 0, 0, 0, tocolor(255, 255, 255, a))
			end
		end
	end
	local x, y, z = mixerX + 0.01264, mixerY + 1.83547, mixerZ + 0.162247
	local d = getDistanceBetweenPoints2D(px, py, x, y)
	if mixerWindow then
		if 1.5 < d then
			deleteMixerWindow()
		end
	elseif d < 1.5 then
		local x, y = getScreenFromWorldPosition(x, y, z, 128)
		if x then
			local a = 1.25 < d and 255 - 255 * (d - 1.25) / 0.25 or 255
			dxDrawRectangle(x - 18, y - 18, 36, 36, tocolor(grey1[1], grey1[2], grey1[3], a))
			if d <= 1.3 and cx and cx >= x - 18 and cx <= x + 18 and cy >= y - 18 and cy <= y + 18 then
				dxDrawImage(x - 16, y - 16, 32, 32, "files/mixer.dds", 0, 0, 0, tocolor(green[1], green[2], green[3], a))
				tmp = "useMixer"
			else
				dxDrawImage(x - 16, y - 16, 32, 32, "files/mixer.dds", 0, 0, 0, tocolor(255, 255, 255, a))
			end
		end
	end
	if tmp ~= paintshopHover or tmpId ~= paintshopHoverId then
		paintshopHover = tmp
		paintshopHoverId = tmpId
		if tmp then
			if tmp == "useTrash" then
				sightexports.sGui:showTooltip("Veszélyes hulladék szemetes")
			elseif tmp == "useMachineCasette" then
				local name
				if paintshopHoverId == 1 then
					name = "PRIMER"
				elseif paintshopHoverId == 2 then
					name = "BASE"
				elseif paintshopHoverId == 3 then
					name = "METALIC BASE"
				else
					name = colorNames[paintshopHoverId - 3]
				end
				if playerHoldingCasette then
					sightexports.sGui:showTooltip("Kazetta behelyezése a keverőgépbe (" .. name .. ")")
				else
					sightexports.sGui:showTooltip("Kazetta kivétele a keverőgépből (" .. name .. ")")
				end
			elseif tmp == "paintSkin" then
				if myWorkSkin then
					sightexports.sGui:showTooltip("Munkaruha levétele")
				else
					sightexports.sGui:showTooltip("Munkaruha felvétele")
				end
			elseif tmp == "booth" then
				if boothDrying or boothClosed then
					sightexports.sGui:showTooltip("Fényezőkamra kikapcsolása")
				else
					sightexports.sGui:showTooltip("Fényezőkamra bekapcsolása")
				end
			elseif tmp == "mixerMachine" then
				if tankInHand then
					sightexports.sGui:showTooltip("Tartály behelyezése a keverőgépbe")
				else
					sightexports.sGui:showTooltip("Tartály kivétele a keverőgépből")
				end
			elseif tmp == "primerMachine" then
				if tankInHand then
					sightexports.sGui:showTooltip("Tartály behelyezése az alapozó adagolóba")
				else
					sightexports.sGui:showTooltip("Tartály kivétele az alapozó adagolóból")
				end
			elseif tmp == "socket" then
				local sander = playerSanders[localPlayer]
				if sander then
					local i = sanderMachineDatas[sander].socket
					if i then
						sightexports.sGui:showTooltip("Kihúzás a konnektorból")
					else
						sightexports.sGui:showTooltip("Bedugás a konnektorba")
					end
				end
			elseif tmp == "sander" then
				if sanderMachineDatas[tmpId] and sanderMachineDatas[tmpId].player == localPlayer then
					sightexports.sGui:showTooltip("Csiszológép visszarakása")
				else
					sightexports.sGui:showTooltip("Csiszológép levétele")
				end
			elseif tmp == "tank" then
				if paintGunDatas[tmpId] and paintGunDatas[tmpId].player == localPlayer then
					sightexports.sGui:showTooltip("Tartály felszerelése")
				else
					sightexports.sGui:showTooltip("Tartály leszerelése")
				end
			elseif tmp == "useMixer" then
				sightexports.sGui:showTooltip("Keverőgép használata")
			elseif tmp == "useComputer" then
				sightexports.sGui:showTooltip("Számítógép használata")
			elseif tmp == "gun" then
				if paintGunDatas[tmpId] and paintGunDatas[tmpId].player == localPlayer then
					sightexports.sGui:showTooltip("Festékszóró visszarakása")
				else
					sightexports.sGui:showTooltip("Festékszóró levétele")
				end
			else
				sightexports.sGui:showTooltip(false)
			end
			sightexports.sGui:setCursorType("link")
		else
			sightexports.sGui:showTooltip(false)
			sightexports.sGui:setCursorType("normal")
		end
	end
	if (isLoading() or bigLoader) and not loaderIsLobby then
		if tonumber(bigLoader) or bigLoaderFadeOut then
			local p = 1
			local c = true
			if bigLoaderFadeOut then
				if not tonumber(bigLoaderFadeOut) and not loaderHandled then
					if bigLoader then
						bigLoaderFadeOut = now
					else
						c = false
						p = 0
						bigLoaderFadeOut = false
					end
				elseif tonumber(bigLoaderFadeOut) then
					local delta = now - bigLoaderFadeOut - 1000
					if 0 < delta then
						c = false
						p = 1 - delta / 500
						if p < 0 then
							bigLoader = false
							bigLoaderFadeOut = false
							p = 0
							if sightexports.sCarshader:getCarPaintState() then
								sightexports.sGui:showInfobox("e", "Kapcsold ki a jármű shadert a munka közben!")
							end
						end
					end
				end
			end
			disableControls(c)
			if 0 < p then
				local s = 1.5 - p * 0.5
				local sy = screenY + 2
				sy = sy * s
				local sx = math.ceil(sy * 1.7777777777777777)
				if sx < screenX then
					dxDrawRectangle(0, 0, screenX / 2 - sx / 2, screenY, tocolor(0, 0, 0, 255 * p))
					dxDrawRectangle(screenX / 2 + sx / 2, 0, screenX / 2 - sx / 2, screenY, tocolor(0, 0, 0, 255 * p))
				end
				dxDrawImage(screenX / 2 - sx / 2, screenY / 2 - sy / 2, sx, sy, "files/loading/" .. bigLoader .. ".dds", 0, 0, 0, tocolor(255, 255, 255, 255 * p))
				local sp = 90 * s
				dxDrawImage(screenX / 2 - sp / 2, screenY / 2 - sp / 2, sp, sp, "files/loading/sp2.dds", 0, 0, 0, tocolor(green[1] * 0.1, green[2] * 0.1, green[3] * 0.1, 200 * p))
				dxDrawImage(screenX / 2 - sp / 2, screenY / 2 - sp / 2, sp, sp, "files/loading/sp1.dds", -now / 4.75 % 360, 0, 0, tocolor(green[1], green[2], green[3], 255 * p))
				dxDrawText("Fényezőműhely betöltése", 0, screenY / 2 + 50 + 12, screenX, screenY / 2 + 50 + 12 + 32, tocolor(255, 255, 255, 255 * p), loaderFontScale * s, loaderFont, "center", "center")
				if loadingShop then
					dxDrawText("Előkészítés...", 0, screenY / 2 + 50 + 12 + 32, screenX, screenY / 2 + 50 + 12 + 32 + 26, tocolor(255, 255, 255, 255 * p), mixerFontScale * s, mixerFont, "center", "center")
				elseif loadingWorks and 0 < loadingWorks then
					local c = 0
					for i = 1, 2 do
						if paintshopWorks[i] then
							c = c + 1
						end
					end
					dxDrawText("Autók betöltése: " .. c - loadingWorks .. "/" .. c, 0, screenY / 2 + 50 + 12 + 32, screenX, screenY / 2 + 50 + 12 + 32 + 26, tocolor(255, 255, 255, 255 * p), mixerFontScale * s, mixerFont, "center", "center")
				elseif bigLoader and not bigLoaderFadeOut then
					for id = 1, 2 do
						if isElement(workCars[id]) then
							unfreezeWorkCar(id)
							workCarFreezeTimers[id] = setTimer(freezeWorkCar, 2500, 1, id)
							local x, y, z, rz = getWorkCarPosition(id)
							setElementPosition(workCars[id], x, y, z)
							setElementRotation(workCars[id], 0, 0, rz)
						end
					end
					bigLoaderFadeOut = true
				end
			end
		else
			local sp = 40
			local w = sp + 8 + math.ceil(dxGetTextWidth("Autó betöltése...", mixerFontScale, mixerFont)) + 16
			local y = screenY - 124 - sp - 8
			dxDrawRectangle(screenX / 2 - w / 2, y, sp + 8, sp + 8, tocolor(grey1[1], grey1[2], grey1[3]))
			dxDrawRectangle(screenX / 2 - w / 2 + sp + 8, y, w - (sp + 8), sp + 8, tocolor(grey2[1], grey2[2], grey2[3]))
			dxDrawImage(screenX / 2 - w / 2 + 4, y + 4, sp, sp, "files/loading/sp2.dds", 0, 0, 0, tocolor(green[1] * 0.1, green[2] * 0.1, green[3] * 0.1, 200))
			dxDrawImage(screenX / 2 - w / 2 + 4, y + 4, sp, sp, "files/loading/sp1.dds", -now / 4.75 % 360, 0, 0, tocolor(green[1], green[2], green[3], 255))
			dxDrawText("Autó betöltése...", screenX / 2 - w / 2 + sp + 8, y, screenX / 2 + w / 2, y + sp + 8, tocolor(255, 255, 255, 255), mixerFontScale, mixerFont, "center", "center")
		end
	end
end
function getPaintTime(x, y, z)
	local px, py, pz = getPedBonePosition(localPlayer, 24)
	local particleDisappear = 5
	local particleAppear = 15
	local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
	return math.max(d * 0.35, 1 / particleAppear + 1 / particleDisappear * 0.75) * 1000
end
local airHosePosition = {
	{
		wsX - 8.2701,
		wsY - 2.3953,
		wsZ + 1.0545
	},
	{
		wsX - 8.2701,
		wsY - 1.1533,
		wsZ + 1.0545
	}
}
function resetAirHose(i)
	local radius = 0.25
	local num = 2 * radius * math.pi / lineSegment
	local x, y = airHosePosition[i][1] + radius, airHosePosition[i][2]
	airPipes[i] = {}
	local rPlus = math.pi * 2 / num
	local r = math.pi
	local dist = getDistanceBetweenPoints3D(airHosePosition[i][1], airHosePosition[i][2], airHosePosition[i][3], x + math.cos(r) * radius, y + math.sin(r) * radius, gz)
	for j = 0, 14 / lineSegment do
		table.insert(airPipes[i], {
			x + math.cos(r) * radius,
			y + math.sin(r) * radius
		})
		if dist <= j * lineSegment then
			r = r + rPlus * (i % 2 == 0 and 1 or -1)
		end
	end
	gunPoses[i] = {
		wsX + sprayGunPoses[i][1],
		wsY + sprayGunPoses[i][2],
		wsZ + sprayGunPoses[i][3]
	}
end
function resetSprayGun(id)
	setElementPosition(sprayGuns[id], wsX + sprayGunPoses[id][1], wsY + sprayGunPoses[id][2], wsZ + sprayGunPoses[id][3])
	setElementRotation(sprayGuns[id], sprayGunPoses[id][4], sprayGunPoses[id][5], sprayGunPoses[id][6])
	setElementCollisionsEnabled(sprayGuns[id], false)
	resetAirHose(id)
end
function processSprayGunMixerTarget(id)
	local r = mixerStarted[9]
	local rad = math.rad(r)
	dxSetRenderTarget(paintGunDatas[id].paintRT, true)
	dxSetBlendMode("modulate_add")
	if mixerStarted and mixerStarted[1] > 0 then
		dxDrawRectangle(0, 0, 128, 128, tocolor(mixerStarted[14], mixerStarted[15], mixerStarted[16]))
		dxDrawImage(4, 4, 120, 120, "files/overlay.dds", 180 + r, 0, 0, tocolor(mixerStarted[11], mixerStarted[12], mixerStarted[13]))
		local n = #mixerStarted[5]
		for i = n, 1, -1 do
			local col = mixerStarted[5][i][1]
			local r = rad - mixerStarted[5][i][2]
			local d = 44 * math.max(0, 1 - mixerStarted[5][i][3])
			local x, y = 64 - math.cos(r) * d, 64 - math.sin(r) * d
			if i < n then
				if mixerStarted[5][i + 1][5] == mixerStarted[5][i][5] then
					local r2 = rad - mixerStarted[5][i + 1][2]
					local d2 = 44 * math.max(0, 1 - mixerStarted[5][i + 1][3])
					dxDrawLine(x, y, 64 - math.cos(r2) * d2, 64 - math.sin(r2) * d2, tocolor(colorPalette[col][1], colorPalette[col][2], colorPalette[col][3]), 6)
				else
					dxDrawImage(x - 3, y - 3, 6, 6, "files/circle.dds", 0, 0, 0, tocolor(colorPalette[col][1], colorPalette[col][2], colorPalette[col][3]))
				end
			else
				dxDrawImage(x - 3, y - 3, 6, 6, "files/circle.dds", 0, 0, 0, tocolor(colorPalette[col][1], colorPalette[col][2], colorPalette[col][3]))
			end
		end
		dxDrawImage(2, 2, 124, 124, "files/overlay3.dds", 180 + r, 0, 0, tocolor(255, 255, 255, mixerStarted[2] and 155 or 25))
		dxDrawImage(4, 4, 120, 120, "files/overlay2.dds", 180, 0, 0, tocolor(255, 255, 255, 130))
	end
	dxSetBlendMode("blend")
	dxSetRenderTarget()
end
function processSprayGunRenderTarget(id)
	dxSetRenderTarget(paintGunDatas[id].paintRT, true)
	if paintGunDatas[id].paintLevel and paintGunDatas[id].paintLevel > 0 then
		dxSetBlendMode("modulate_add")
		if paintGunDatas[id].paintType == "primer" then
			dxDrawRectangle(0, 0, 128, 128, tocolor(primerR, primerG, primerB))
			dxDrawImage(4, 4, 120, 120, "files/overlay2.dds", 180, 0, 0, tocolor(255, 255, 255, 130))
		elseif paintGunDatas[id].paintType then
			local r, g, b = hexToRGB(paintGunDatas[id].paintType)
			dxDrawRectangle(0, 0, 128, 128, tocolor(r, g, b))
			dxDrawImage(2, 2, 124, 124, "files/overlay3.dds", 180 + r, 0, 0, tocolor(255, 255, 255, paintGunDatas[id].paintMetal and 155 or 25))
			dxDrawImage(4, 4, 120, 120, "files/overlay2.dds", 180, 0, 0, tocolor(255, 255, 255, 130))
		end
		dxSetBlendMode("blend")
	end
	dxSetRenderTarget()
end
function resetSanderMachine(i)
	setElementModel(sanderMachines[i], models.spray_sander_shelf)
	setElementPosition(sanderMachines[i], wsX + sanderPosition[i][1], wsY + sanderPosition[i][2], wsZ + sanderPosition[i][3])
	setElementRotation(sanderMachines[i], sanderPosition[i][4], sanderPosition[i][5], sanderPosition[i][6])
	setElementCollisionsEnabled(sanderMachines[i], false)
end
function refreshPaintGunData(id, data, start)
	local wasTank = paintGunDatas[id].tank
	for key, value in pairs(data) do
		if key == "tank" and value ~= "mixer" then
			if paintGunDatas[id].tank == "mixer" and mixerStarted then
				mixerStarted = false
				if isElement(mixerSoundEffect) then
					destroyElement(mixerSoundEffect)
				end
				mixerSoundEffect = nil
				mixerSliderTarget = mixerBaseOffsets[1][2]
				setElementPosition(mixerSlider, mixerX - 0.0085, mixerY + mixerSliderTarget, mixerZ - 0.087629)
				if mixerWindow then
					createMixerWindow()
				else
					processMixerRenderTarget()
				end
			end
		elseif key == "player" and not value and paintGunDatas[id].player == localPlayer then
			tankInHand = false
		end
		paintGunDatas[id][key] = value
	end
	for key, value in pairs(data) do
		if key == "tank" then
		end
		if key == "tank" then
			setElementModel(sprayGuns[id], value and models.spray_gun_cup or models.spray_gun)
			if isElement(sprayGunBases[id]) then
				destroyElement(sprayGunBases[id])
			end
			sprayGunBases[id] = nil
			
			if value then
				sprayGunBases[id] = createObject(models.spray_gun_base, wsX + sprayGunPoses[id][1], wsY + sprayGunPoses[id][2], wsZ + sprayGunPoses[id][3], sprayGunPoses[id][4], sprayGunPoses[id][5], sprayGunPoses[id][6])
				setElementCollisionsEnabled(sprayGunBases[id], false)
				setElementInterior(sprayGunBases[id], targetInt)
				setElementDimension(sprayGunBases[id], currentWorkshop)
				if value == "primer" then
					if primerMachineStarted then
						primerMachineStarted = getTickCount()
						if not start then
							local sound = playSound3D("files/displong.mp3", mixerX - 0.008482, mixerY - 2.48086, mixerZ + 0.352758)
							setElementInterior(sound, targetInt)
							setElementDimension(sound, currentWorkshop)
						end
					end
				elseif value == "mixer" then
					loadedMixerRecipe = false
					if not start then
						local sound = playSound3D("files/prompt.mp3", mixerX + 0.01264, mixerY + 1.83547, mixerZ + 0.162247)
						setElementInterior(sound, targetInt)
						setElementDimension(sound, currentWorkshop)
					end
					if mixerWindow then
						createMixerWindow()
					else
						processMixerRenderTarget()
					end
				end
			end
			
			if wasTank == "mixer" and value ~= "mixer" then
				if mixerWindow then
					createMixerWindow()
				else
					processMixerRenderTarget()
				end
			end
		elseif key == "player" then
			if not start then
				if (wasTank and true or false) ~= (paintGunDatas[id].tank and true or false) then
					if paintGunDatas[id].tank then
						local sound = playSound3D("files/cuple.mp3", wsX + sprayGunPoses[id][1], wsY + sprayGunPoses[id][2], wsZ + sprayGunPoses[id][3])
						setElementInterior(sound, targetInt)
						setElementDimension(sound, currentWorkshop)
					else
						local sound = playSound3D("files/cupfel.mp3", wsX + sprayGunPoses[id][1], wsY + sprayGunPoses[id][2], wsZ + sprayGunPoses[id][3])
						setElementInterior(sound, targetInt)
						setElementDimension(sound, currentWorkshop)
					end
				elseif paintGunDatas[id].tank == "mixer" or wasTank == "mixer" then
					local sound = playSound3D("files/pick.mp3", mixerX - 0.0085, mixerY + mixerSliderTarget, mixerZ - 0.087629 + 0.1)
					setElementInterior(sound, targetInt)
					setElementDimension(sound, currentWorkshop)
				elseif paintGunDatas[id].tank == "primer" or wasTank == "primer" then
					local sound = playSound3D("files/pick.mp3", mixerX - 0.0085, mixerY - 2.4809, mixerZ - 0.0488)
					setElementInterior(sound, targetInt)
					setElementDimension(sound, currentWorkshop)
				else
					local sound = playSound3D("files/pick.mp3", wsX + sprayGunPoses[id][1], wsY + sprayGunPoses[id][2], wsZ + sprayGunPoses[id][3])
					setElementInterior(sound, targetInt)
					setElementDimension(sound, currentWorkshop)
				end
			end
			if isElement(value) then
				if paintGunDatas[id].tank then
					sightexports.sPattach:attach(sprayGuns[id], value, 24, 0.22161193287205, -0.0673148423284, 0.014611664303393, 0, 0, 0)
					sightexports.sPattach:setRotationQuaternion(sprayGuns[id], sprayGunCupQ)
					sightexports.sPattach:disableScreenCheck(sprayGuns[id], true)
					if value == localPlayer then
						tankInHand = id
					end
				else
					sightexports.sPattach:attach(sprayGuns[id], value, 24, 0.048446228020418, 0.021083042749036, 0.098544111362193, 0, 0, 0)
					sightexports.sPattach:setRotationQuaternion(sprayGuns[id], sprayGunQ)
					sightexports.sPattach:disableScreenCheck(sprayGuns[id], true)
					playerGuns[value] = id
				end
			else
				for p, i in pairs(playerGuns) do
					if i == id then
						playerGuns[p] = nil
					end
				end
				sightexports.sPattach:detach(sprayGuns[id])
				resetSprayGun(id)
			end
		end
	end
	dxSetShaderValue(sprayShaders[id], "paintLevel", paintGunDatas[id].paintLevel)
	dxSetShaderValue(sprayShaders[id], "mixSpeed", 0)
	processSprayGunRenderTarget(id)
end
function createSanderCables(id)
	local x, y = 6.908203125, 12.078125
	sanderCables[id] = {}
	for i = 1, sanderCableLength / lineSegment do
		table.insert(sanderCables[id], {x, y})
		y = y - lineSegment
	end
	if isElement(sanderPlugs[id]) then
		destroyElement(sanderPlugs[id])
	end
	sanderPlugs[id] = createObject(models.spray_plug, x, y, gz)
	setElementCollisionsEnabled(sanderPlugs[id], false)
	setElementInterior(sanderPlugs[id], targetInt)
	setElementDimension(sanderPlugs[id], currentWorkshop)
end
function refreshPaintSanderData(id, data, start)
	for key, value in pairs(data) do
		if key == "socket" then
			if playerSanders[localPlayer] == id then
				lastPlayerSanderSocket = getTickCount()
			end
			if not sanderMachineDatas[id][key] and value then
				local socket = value
				if not start then
					local sound = playSound3D("files/plugin.mp3", wsX + sanderSockets[socket][1], wsY + sanderSockets[socket][2], wsZ + sanderSockets[socket][3])
					setElementInterior(sound, targetInt)
					setElementDimension(sound, currentWorkshop)
				end
			elseif sanderMachineDatas[id][key] and not value then
				local socket = sanderMachineDatas[id][key]
				if not start then
					local sound = playSound3D("files/plugout.mp3", wsX + sanderSockets[socket][1], wsY + sanderSockets[socket][2], wsZ + sanderSockets[socket][3])
					setElementInterior(sound, targetInt)
					setElementDimension(sound, currentWorkshop)
				end
			end
			if value then
				if not start then
					local sound = playSound3D("files/sandstart.mp3", wsX, wsY, wsZ, false)
					setElementInterior(sound, targetInt)
					setElementDimension(sound, currentWorkshop)
					attachElements(sound, sanderMachines[id])
					setSoundMaxDistance(sound, 60)
				end
				if isElement(sandingBaseSounds[id]) then
					destroyElement(sandingBaseSounds[id])
				end
				sandingBaseSounds[id] = playSound3D("files/sandloop2.mp3", wsX, wsY, wsZ, true)
				setSoundVolume(sandingBaseSounds[id], 0)
				setSoundMaxDistance(sandingBaseSounds[id], 60)
				setElementInterior(sandingBaseSounds[id], targetInt)
				setElementDimension(sandingBaseSounds[id], currentWorkshop)
				attachElements(sandingBaseSounds[id], sanderMachines[id])
				sandingBaseStart[id] = getTickCount()
				sandingBaseEnd[id] = false
			else
				if not start then
					local sound = playSound3D("files/sandend.mp3", wsX, wsY, wsZ, false)
					setElementInterior(sound, targetInt)
					setElementDimension(sound, currentWorkshop)
					attachElements(sound, sanderMachines[id])
					setSoundMaxDistance(sound, 60)
				end
				sandingBaseStart[id] = false
				sandingBaseEnd[id] = getTickCount()
			end
		end
		sanderMachineDatas[id][key] = value
		if key == "player" then
			if not start then
				local sound = playSound3D("files/pick.mp3", wsX + sanderPosition[id][1], wsY + sanderPosition[id][2], wsZ + sanderPosition[id][3])
				setElementInterior(sound, targetInt)
				setElementDimension(sound, currentWorkshop)
			end
			if isElement(value) then
				createSanderCables(id)
				playerSanders[value] = id
				setElementModel(sanderMachines[id], models.spray_sander)
				sightexports.sPattach:attach(sanderMachines[id], value, 24, 0.072572988783442, 0.022229340556172, 0.087543803009455, 0, 0, 0)
				sightexports.sPattach:setRotationQuaternion(sanderMachines[id], spraySanderQ)
				sightexports.sPattach:disableScreenCheck(sanderMachines[id], true)
			else
				sanderCables[id] = nil
				for p, i in pairs(playerSanders) do
					if i == id then
						playerSanders[p] = nil
					end
				end
				if isElement(sanderPlugs[id]) then
					destroyElement(sanderPlugs[id])
				end
				sanderPlugs[id] = nil
				sightexports.sPattach:detach(sanderMachines[id])
				resetSanderMachine(id)
			end
		end
	end
end
function refreshPaintMixerTankData(data)
	for key, value in pairs(data) do
		if type(value) == "table" then
			for i, v in pairs(value) do
				mixerTank[key][i] = v
			end
		else
			mixerTank[key] = value
		end
	end
	processMixerRenderTarget()
end
addEvent("refreshPaintGunData", true)
addEventHandler("refreshPaintGunData", getRootElement(), function(ws, id, data)
	if ws == currentWorkshop then
		refreshPaintGunData(id, data)
		paintshopHover = false
		sightexports.sGui:showTooltip(false)
	end
end)
addEvent("refreshPaintSanderData", true)
addEventHandler("refreshPaintSanderData", getRootElement(), function(ws, id, data)
	if ws == currentWorkshop then
		refreshPaintSanderData(id, data)
		paintshopHover = false
		sightexports.sGui:showTooltip(false)
	end
end)
addEvent("refreshPaintMixerTankData", true)
addEventHandler("refreshPaintMixerTankData", getRootElement(), function(ws, data)
	if ws == currentWorkshop then
		refreshPaintMixerTankData(data)
	end
end)
function getPositionFromMatrixOffset(m, offX, offY, offZ)
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z
end
function spawnPaintParticle(id, px, py, pz, x, y, z)
	if id then
		local levelAmount = {5, 10, 15, 25, 50}
		local particleSpawnChance = levelAmount[workshopUpgrades[1]] or 0
		if math.random(1, 100) <= particleSpawnChance then
			return
		end
		local particleDisappear = 5
		local particleAppear = 15
		local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
		local time = math.max(d * 0.35, 1 / particleAppear + 1 / particleDisappear * 0.5)
		local r, g, b
		if paintshopWorks[id].state == "primer" then
			r, g, b = primerR, primerG, primerB
		elseif paintshopWorks[id].state == "paint" then
			r, g, b = paintshopWorks[id].colorRGB[1], paintshopWorks[id].colorRGB[2], paintshopWorks[id].colorRGB[3]
		end
		if r then
			table.insert(timedPaintParticles, {
				x,
				y,
				z,
				r,
				g,
				b,
				time * 1000
			})
			x = (x - px) / time
			y = (y - py) / time
			z = (z - pz) / time
			table.insert(particles, {
				px,
				py,
				pz,
				0,
				2,
				0.35 / time,
				(time - 1 / particleAppear - 1 / particleDisappear * 0.5) * 1000,
				0,
				x,
				y,
				z,
				math.random(70, 90) / 100,
				r,
				g,
				b,
				particleAppear,
				particleDisappear
			})
		end
	end
end
function spawnTimedPaintParticle(x, y, z, r, g, b)
	local time = math.random(500, 750) / 1000
	table.insert(particles, {
		x,
		y,
		z,
		0.5,
		2,
		math.random(750, 1000) / 1000 / time,
		time * 1000,
		0,
		math.random(-10, 10) / 100,
		math.random(-10, 10) / 100,
		math.random(70, 150) / 1000,
		math.random(5, 10) / 100,
		r,
		g,
		b,
		0.75,
		0.75
	})
end
function spawnSandingParticle(x, y, z, a)
	local levelAmount = {5, 10, 15, 25, 50}
	local particleSpawnChance = levelAmount[workshopUpgrades[1]] or 0
	if math.random(1, 100) <= particleSpawnChance then
		return
	end
	table.insert(particles, {
		x,
		y,
		z,
		0.5,
		2,
		math.random(300, 450) / 1000,
		math.random(1500, 2500),
		0,
		math.random(-10, 10) / 100,
		math.random(-10, 10) / 100,
		math.random(70, 150) / 1000,
		math.random(50, 65) / 100 * (0.25 + a * 0.75),
		218,
		231,
		255,
		0.25,
		0.75
	})
end
local syncEffectInterval = 800
addEvent("syncPaintshopSandingParticle", true)
addEventHandler("syncPaintshopSandingParticle", getRootElement(), function(ws, x, y, z, a, n)
	if isElement(source) and ws == currentWorkshop then
		for i = 1, n do
			if i == 1 then
				spawnSandingParticle(x, y, z, a)
			else
				setTimer(spawnSandingParticle, 600 / n * (i - 1), 1, x, y, z, a)
			end
		end
		if not paintingAnimPoses[source] then
			paintingAnimPoses[source] = {}
		end
		paintingAnimPoses[source][1] = x
		paintingAnimPoses[source][2] = y
		paintingAnimPoses[source][3] = z
	end
end)
addEvent("syncPaintshopPaintAnim", true)
addEventHandler("syncPaintshopPaintAnim", getRootElement(), function(ws, id)
	if isElement(source) and ws == currentWorkshop then
		paintingAnim[source] = id
		if id then
			if isPedDucked(source) then
				setPedAnimation(source)
				engineReplaceAnimation(source, "ped", "weapon_crouch", paintshopWorks[id].state == "sanding" and "paint_sand_crouch" or "paint_crouch", "Copbrowse_in")
			else
				setPedAnimation(source, paintshopWorks[id].state == "sanding" and "paint_sand_stand" or "paint_stand", "Copbrowse_in", -1, true, false, false, true, 100, true)
			end
		else
			engineRestoreAnimation(source, "ped", "weapon_crouch")
			paintingAnimDegrees[source] = nil
			setPedAnimation(source)
		end
	end
end)
addEvent("syncPaintshopPaintAnimPosition", true)
addEventHandler("syncPaintshopPaintAnimPosition", getRootElement(), function(ws, x, y, z)
	if isElement(source) and ws == currentWorkshop then
		if not paintingAnimPoses[source] then
			paintingAnimPoses[source] = {}
		end
		paintingAnimPoses[source][1] = x
		paintingAnimPoses[source][2] = y
		paintingAnimPoses[source][3] = z
	end
end)
function renderParticles(delta)
	local x, y, z = getWorldFromScreenPosition(screenX / 2, 0, 128)
	local x2, y2, z2 = getWorldFromScreenPosition(screenX / 2, screenY / 2, 128)
	x = x2 - x
	y = y2 - y
	z = z2 - z
	local len = math.sqrt(x * x + y * y + z * z) * 2
	x = x / len
	y = y / len
	z = z / len
	for i = #particles, 1, -1 do
		local data = particles[i]
		if data then
			data[4] = data[4] + data[6] * delta / 1000
			data[1] = data[1] + data[9] * delta / 1000
			data[2] = data[2] + data[10] * delta / 1000
			data[3] = data[3] + data[11] * delta / 1000
			if data[8] >= data[12] then
				data[7] = data[7] - delta
			end
			if 0 > data[7] then
				data[8] = data[8] - data[17] * delta / 1000
			elseif data[8] < data[12] then
				data[8] = data[8] + data[16] * delta / 1000
				if data[8] > data[12] then
					data[8] = data[12]
				end
			end
			if 0 > data[8] then
				table.remove(particles, i)
			else
				dxDrawMaterialLine3D(data[1] + x * data[4], data[2] + y * data[4], data[3] + z * data[4], data[1] - x * data[4], data[2] - y * data[4], data[3] - z * data[4], particleTextures[data[5]], data[4], tocolor(data[13], data[14], data[15], 255 * data[8]))
			end
		end
	end
end
function processSanders(now)
	socketUsed = {}
	local devMode = false
	local warned = false
	if devMode and not warned then
		print("DEVMODE ACTIVE")
		warned = true
	end
	local col = tocolor(40, 40, 40)
	for j = 1, #sanderMachines do
		if sandingBaseSounds[j] then
			if sandingBaseStart[j] then
				local delta = now - sandingBaseStart[j]
				if (devMode and 1) or 100 <= delta then
					local p = (delta - (devMode and 1 or 100)) / (devMode and 1 or 150)
					if 1 < p then
						setSoundVolume(sandingBaseSounds[j], 1)
						sandingBaseStart[j] = false
					else
						setSoundVolume(sandingBaseSounds[j], p)
					end
				else
					setSoundVolume(sandingBaseSounds[j], 0)
				end
			elseif sandingBaseEnd[j] then
				local delta = now - sandingBaseEnd[j]
				if (devMode and 1) or 330 <= delta then
					local p = (delta - (devMode and 1 or 330)) / (devMode and 1 or 425)
					if 1 < p then
						if isElement(sandingBaseSounds[j]) then
							destroyElement(sandingBaseSounds[j])
						end
						sandingBaseSounds[j] = nil
						sandingBaseEnd[j] = false
					else
						setSoundVolume(sandingBaseSounds[j], 1 - p)
					end
				else
					setSoundVolume(sandingBaseSounds[j], 1)
				end
			else
				setSoundVolume(sandingBaseSounds[j], 1)
			end
		end
		if sanderCables[j] then
			local wx, wy, wz = getElementPosition(sanderMachines[j])
			local x, y, z = wx, wy, wz
			local sx, sy, sz, endZ
			local socket = sanderMachineDatas[j].socket
			if socket then
				sx, sy, sz = wsX + sanderSockets[socket][1], wsY + sanderSockets[socket][2], wsZ + sanderSockets[socket][3]
				endZ = sz - gz
				socketUsed[socket] = true
			end
			local startZ = (z or gz) - gz
			local n = #sanderCables[j]
			sanderCables[j][1][1], sanderCables[j][1][2] = x, y
			for i = 1, n do
				local nx, ny = sanderCables[j][i][1], sanderCables[j][i][2]
				local nz = gz
				if i <= n * 0.1 then
					nz = getEasingValue(1 - i / (n * 0.1), "InQuad") * startZ + gz
				end
				if endZ and i >= n * 0.9 then
					nz = getEasingValue((i - n * 0.9) / (n - n * 0.9), "InQuad") * endZ + gz
				end
				if j == 4 and i == math.floor(n / 2) then
					local vx = (nx - x) / 6
					local vy = (ny - y) / 6
					local vz = (nz - z) / 6
					for k = 1, 6 do
						dxDrawMaterialLine3D(x + vx * (k - 1), y + vy * (k - 1), z + vz * (k - 1), x + vx * k, y + vy * k, z + vz * k, gradTexture, 0.017249999999999998, k % 2 == 0 and tocolor(180, 180, 15) or tocolor(15, 180, 15))
					end
				else
					dxDrawMaterialLine3D(x, y, z, nx, ny, nz, gradTexture, 0.015, col)
				end
				x, y, z = nx, ny, nz
			end
			setElementPosition(sanderPlugs[j], x, y, z)
			local nx, ny = sanderCables[j][n - 1][1], sanderCables[j][n - 1][2]
			if socket then
				setElementRotation(sanderPlugs[j], 0, 0, sanderSockets[socket][4])
			else
				setElementRotation(sanderPlugs[j], 0, 0, math.deg(math.atan2(ny - y, nx - x)))
			end
			for i = 2, n do
				local nx, ny = sanderCables[j][i - 1][1], sanderCables[j][i - 1][2]
				local x, y = sanderCables[j][i][1], sanderCables[j][i][2]
				local d = getDistanceBetweenPoints2D(nx, ny, x, y)
				if d > lineSegment then
					sanderCables[j][i][1] = sanderCables[j][i][1] + (nx - x) * ((d - lineSegment) / d)
					sanderCables[j][i][2] = sanderCables[j][i][2] + (ny - y) * ((d - lineSegment) / d)
				end
			end
			if socket then
				local nx, ny = sanderCables[j][n][1], sanderCables[j][n][2]
				sanderCables[j][n][1] = sx
				sanderCables[j][n][2] = sy
				for i = n - 1, 1, -1 do
					local nx, ny = sanderCables[j][i + 1][1], sanderCables[j][i + 1][2]
					local x, y = sanderCables[j][i][1], sanderCables[j][i][2]
					local d = getDistanceBetweenPoints2D(nx, ny, x, y)
					if d > lineSegment then
						sanderCables[j][i][1] = sanderCables[j][i][1] + (nx - x) * ((d - lineSegment) / d)
						sanderCables[j][i][2] = sanderCables[j][i][2] + (ny - y) * ((d - lineSegment) / d)
					end
				end
				if playerSanders[localPlayer] == j and 1000 < now - lastPlayerSanderSocket and 0.1 < getDistanceBetweenPoints2D(wx, wy, sanderCables[j][1][1], sanderCables[j][1][2]) then
					sanderMachineDatas[j].socket = nil
					triggerServerEvent("tryToUsePaintShopSocket", localPlayer, j)
				end
			end
		end
	end
end
function renderAirPipes(pipeUsed)
	for j = 1, #airPipes do
		local wx, wy, wz = airHosePosition[j][1], airHosePosition[j][2], airHosePosition[j][3]
		local l = boothDrying and 0.5 or 1
		local col = tocolor(29 * l, 186 * l, 226 * l)
		if j == 2 then
			col = tocolor(224 * l, 184 * l, 82 * l)
		end
		local x, y, z = wx, wy, wz
		local n = #airPipes[j]
		local startZ = (wz or gz) - gz
		local endZ = (airPipes[j][#airPipes[j]][3] or gz) - gz
		for i = 1, n do
			local nx, ny = airPipes[j][i][1], airPipes[j][i][2]
			local nz = gz
			if i <= n * 0.1 then
				nz = getEasingValue(1 - i / (n * 0.1), "InQuad") * startZ + gz
			end
			if i >= n * 0.9 then
				nz = getEasingValue((i - n * 0.9) / (n - n * 0.9), "InQuad") * endZ + gz
			end
			dxDrawMaterialLine3D(x, y, z, nx, ny, nz, gradTexture, 0.025, col)
			x, y, z = nx, ny, nz
		end
		if pipeUsed[j] then
			local vx, vy, vz = gunPoses[j][1] - x, gunPoses[j][2] - y, gunPoses[j][3] - z
			local sz = z
			vx = vx / 5
			vy = vy / 5
			for i = 1, 5 do
				local nz = sz + vz * getEasingValue(i / 5, vz < 0 and "OutBack" or "InBack")
				dxDrawMaterialLine3D(x, y, z, x + vx, y + vy, nz, gradTexture, 0.025, col)
				x, y, z = x + vx, y + vy, nz
			end
			for i = n - 1, 1, -1 do
				local nx, ny = airPipes[j][i + 1][1], airPipes[j][i + 1][2]
				local x, y = airPipes[j][i][1], airPipes[j][i][2]
				local d = getDistanceBetweenPoints2D(nx, ny, x, y)
				if d > lineSegment then
					airPipes[j][i][1] = airPipes[j][i][1] + (nx - x) * ((d - lineSegment) / d)
					airPipes[j][i][2] = airPipes[j][i][2] + (ny - y) * ((d - lineSegment) / d)
				end
			end
			local nx, ny = airPipes[j][1][1], airPipes[j][1][2]
			local d = getDistanceBetweenPoints2D(wx, wy, nx, ny)
			if d > lineSegment then
				airPipes[j][1][1] = airPipes[j][1][1] + (wx - nx) * ((d - lineSegment) / d)
				airPipes[j][1][2] = airPipes[j][1][2] + (wy - ny) * ((d - lineSegment) / d)
			end
			for i = 2, n do
				local nx, ny = airPipes[j][i - 1][1], airPipes[j][i - 1][2]
				local x, y = airPipes[j][i][1], airPipes[j][i][2]
				local d = getDistanceBetweenPoints2D(nx, ny, x, y)
				if d > lineSegment then
					airPipes[j][i][1] = airPipes[j][i][1] + (nx - x) * ((d - lineSegment) / d)
					airPipes[j][i][2] = airPipes[j][i][2] + (ny - y) * ((d - lineSegment) / d)
				end
			end
		else
			local vx, vy, vz = gunPoses[j][1] - x, gunPoses[j][2] - y, gunPoses[j][3] - z
			local sz = z
			vx = vx / 5
			vy = vy / 5
			for i = 1, 5 do
				local nz = sz + vz * getEasingValue(i / 5, vz < 0 and "OutQuad" or "InQuad")
				dxDrawMaterialLine3D(x, y, z, x + vx, y + vy, nz, gradTexture, 0.025, col)
				x, y, z = x + vx, y + vy, nz
			end
		end
	end
end
function processCompressor(now, delta)
	local tmp = false
	local underPressure = false
	for i = 1, #sprayGuns do
		if sprayPumping[i] then
			sprayBar[i] = sprayBar[i] + 0.5 * delta / 1000
			tmp = true
			lastCompressor = now
		end
		if 8 < sprayBar[i] then
			sprayPumping[i] = false
		else
			if sprayBar[i] < 3 then
				sprayPumping[i] = true
			end
			underPressure = true
		end
		setElementRotation(sprayNeedles[i], -278 * sprayBar[i] / 10, 0, barNeedles[i][4])
	end
	if 60000 < now - lastCompressor and underPressure then
		for i = 1, #sprayGuns do
			if sprayBar[i] < 8 then
				sprayPumping[i] = true
			end
		end
	end
	if compressorEnd then
		if not isElement(compressorSound) or getSoundPosition(compressorSound) >= compressorEnd * 0.015 then
			compressorEnd = false
			if isElement(compressorSound) then
				destroyElement(compressorSound)
			end
			compressorSound = false
			local sound = playSound3D("files/compoff.mp3", wsX - 9.8478, wsY - 1.7743, wsZ + 1.4383)
			setElementInterior(sound, targetInt)
			setElementDimension(sound, currentWorkshop)
			setSoundMaxDistance(sound, 60)
			setSoundVolume(sound, 1.5)
		end
	elseif compressorStart and 782 < now - compressorStart then
		compressorStart = false
		if isElement(compressorSound) then
			destroyElement(compressorSound)
		end
		compressorSound = playSound3D("files/comp.mp3", wsX - 9.8478, wsY - 1.7743, wsZ + 1.4383, true)
		setElementInterior(compressorSound, targetInt)
		setElementDimension(compressorSound, currentWorkshop)
		setSoundMaxDistance(compressorSound, 60)
		setSoundVolume(compressorSound, 1.5)
	end
	if compressorState ~= tmp then
		compressorState = tmp
		if compressorState then
			compressorStart = now
			compressorEnd = false
			local sound = playSound3D("files/compon.mp3", wsX - 9.8478, wsY - 1.7743, wsZ + 1.4383)
			setElementInterior(sound, targetInt)
			setElementDimension(sound, currentWorkshop)
			setSoundMaxDistance(sound, 60)
			setSoundVolume(sound, 1.5)
		else
			compressorStart = false
			if isElement(compressorSound) then
				compressorEnd = math.ceil(getSoundPosition(compressorSound) / 0.015)
			else
				compressorEnd = true
			end
		end
	end
end
function processBoothDoorsAndTimer(now, delta)
	local x, y, z = wsX - 2.3734, wsY + 7.1194, wsZ + 1.7766
	local p = (boothDrying or boothClosed) and 0 or 1
	if p > boothDoor then
		boothDoor = boothDoor + 0.3421142661648991 * delta / 1000
		if p < boothDoor then
			boothDoor = p
		end
	elseif p < boothDoor then
		boothDoor = boothDoor - 0.3421142661648991 * delta / 1000
		if p > boothDoor then
			boothDoor = p
		end
	end
	local rz = 0
	for i = 1, 2 do
		local rz = 90 * (i % 2 == 1 and -1 or 1) * getEasingValue(boothDoor, "InOutQuad") * 0.8
		setElementPosition(doors[i], x, y, z)
		setElementRotation(doors[i], 0, 0, rz)
		rz = math.rad(rz)
		x = x - 1.23422 * math.cos(rz)
		y = y - 1.23422 * math.sin(rz)
	end
	x, y, z = wsX - 2.3734 - 4.93688, wsY + 7.1194, wsZ + 1.7766
	for i = 3, 4 do
		local rz = 90 * (i % 2 == 1 and 1 or -1) * getEasingValue(boothDoor, "InOutQuad") * 0.8
		setElementRotation(doors[i], 0, 0, rz)
		rz = math.rad(rz)
		x = x + 1.23422 * math.cos(rz)
		y = y + 1.23422 * math.sin(rz)
		setElementPosition(doors[i], x, y, z)
	end
	local x, y, z = wsX - 1.7918, wsY + 7.352, wsZ + 1.9352
	y = y + 0.01
	local s = 0.05
	x = x + s * 1.75
	dxDrawMaterialSectionLine3D(x, y, z + s, x, y, z - s, 256, 0, 32, 64, segTexture, s, tocolor(50, 20, 20, 255), x, y + 1, z)
	x = x - s
	dxDrawMaterialSectionLine3D(x, y, z + s, x, y, z - s, 256, 0, 32, 64, segTexture, s, tocolor(50, 20, 20, 255), x, y + 1, z)
	x = x - s * 0.75
	dxDrawMaterialSectionLine3D(x, y, z + s, x, y, z - s, 320, 0, 32, 64, segTexture, s, tocolor(50, 20, 20, 255), x, y + 1, z)
	x = x - s * 0.75
	dxDrawMaterialSectionLine3D(x, y, z + s, x, y, z - s, 256, 0, 32, 64, segTexture, s, tocolor(50, 20, 20, 255), x, y + 1, z)
	x = x - s
	dxDrawMaterialSectionLine3D(x, y, z + s, x, y, z - s, 256, 0, 32, 64, segTexture, s, tocolor(50, 20, 20, 255), x, y + 1, z)
	if boothDrying then
		local perc = 0
		local t = false
		for i = 1, 2 do
			if paintshopWorks[i] then
				if paintshopWorks[i].state == "primerDry" then
					t = 900000
				elseif paintshopWorks[i].state == "paintDry" then
					t = 1200000
				end
				if t then
					if paintshopWorks[i].dryingState then
						perc = math.max(perc, math.min(1, paintshopWorks[i].dryingProgress + (getTickCount() - paintshopWorks[i].dryingStart) / t))
						break
					end
					perc = math.max(perc, math.min(1, paintshopWorks[i].dryingProgress))
					break
				end
			end
		end
		if t then
			local x, y, z = wsX - 1.7918, wsY + 7.352, wsZ + 1.9352
			y = y + 0.01
			x = x + s * 1.75
			local t = math.max(0, (1 - perc) * t / 1000)
			local blink = now % 1000 > 500
			if blink ~= boothBeepTmp then
				boothBeepTmp = blink
				if blink and t <= 0 then
					local sound = playSound3D("files/beep2.mp3", wsX - 1.7918, wsY + 7.352, wsZ + 1.9352)
					setElementInterior(sound, targetInt)
					setElementDimension(sound, currentWorkshop)
					setSoundMaxDistance(sound, 55)
				end
			end
			local min = math.floor(t / 60)
			local sec = t - min * 60
			dxDrawMaterialSectionLine3D(x, y + 5.0E-4, z + s, x, y + 5.0E-4, z - s, math.floor(min / 10) * 32, 0, 32, 64, segTexture, s, tocolor(255, 0, 0, 255), x, y + 1, z)
			x = x - s
			dxDrawMaterialSectionLine3D(x, y + 5.0E-4, z + s, x, y + 5.0E-4, z - s, math.floor(min % 10) * 32, 0, 32, 64, segTexture, s, tocolor(255, 0, 0, 255), x, y + 1, z)
			x = x - s * 0.75
			if blink then
				dxDrawMaterialSectionLine3D(x, y + 5.0E-4, z + s, x, y + 5.0E-4, z - s, 320, 0, 32, 64, segTexture, s, tocolor(255, 0, 0, 255), x, y + 1, z)
			end
			x = x - s * 0.75
			dxDrawMaterialSectionLine3D(x, y + 5.0E-4, z + s, x, y + 5.0E-4, z - s, math.floor(sec / 10) * 32, 0, 32, 64, segTexture, s, tocolor(255, 0, 0, 255), x, y + 1, z)
			x = x - s
			dxDrawMaterialSectionLine3D(x, y + 5.0E-4, z + s, x, y + 5.0E-4, z - s, math.floor(sec % 10) * 32, 0, 32, 64, segTexture, s, tocolor(255, 0, 0, 255), x, y + 1, z)
		end
	end
end
addEvent("startPaintMixer", true)
addEventHandler("startPaintMixer", getRootElement(), function(ws, paintType, metal)
	if ws == currentWorkshop then
		if paintType == "primer" then
			primerMachineStarted = true
			mixerTank.primer = mixerTank.primer - 1
		elseif validColors[paintType] then
			local recipe = {}
			local colorNum = {}
			local tmpNum = {}
			for i = 1, #validColors[paintType] do
				recipe[i] = validColors[paintType][i]
				mixerTank.color[i] = mixerTank.color[i] - validColors[paintType][i]
				colorNum[i] = 0
				tmpNum[i] = 0
			end
			sliderServoSpeed = 0
			mixerSoundEffect = playSound3D("files/mixer.mp3", mixerX - 0.0085, mixerY + mixerSliderPosition, mixerZ + 0.352758, true)
			setElementInterior(mixerSoundEffect, targetInt)
			setElementDimension(mixerSoundEffect, currentWorkshop)
			attachElements(mixerSoundEffect, mixerSlider, 0, 0, 0)
			if metal then
				mixerTank.base[2] = mixerTank.base[2] - 1
			else
				mixerTank.base[1] = mixerTank.base[1] - 1
			end
			loadedMixerRecipe = false
			mixerStarted = {
				0,
				metal,
				recipe,
				{},
				{},
				colorNum,
				tmpNum,
				1000,
				0,
				0,
				255,
				255,
				255,
				255,
				255,
				255,
				paintType,
				getTickCount()
			}
			if mixerWindow then
				createMixerWindow()
			else
				processMixerRenderTarget()
			end
		end
	end
end)
local mixerLedOffsets = {
	{
		0.2221,
		-2.4809,
		0.772
	},
	{
		0.2221,
		-2.0654,
		0.772
	},
	{
		0.2221,
		-1.7126,
		0.772
	},
	{
		0.0837,
		-1.4177,
		0.7493
	},
	{
		0.0837,
		-1.2044,
		0.7493
	},
	{
		0.0837,
		-0.991,
		0.7493
	},
	{
		0.0837,
		-0.7777,
		0.7493
	},
	{
		0.0837,
		-0.5644,
		0.7493
	},
	{
		0.0837,
		-0.351,
		0.7493
	},
	{
		0.0837,
		-0.1377,
		0.7493
	},
	{
		0.0837,
		0.0757,
		0.7493
	},
	{
		0.0837,
		0.289,
		0.7493
	},
	{
		0.0837,
		0.5024,
		0.7493
	},
	{
		0.0837,
		0.7157,
		0.7493
	},
	{
		0.0837,
		0.929,
		0.7493
	},
	{
		0.0837,
		1.1424,
		0.7493
	},
	{
		0.0837,
		1.3557,
		0.7493
	},
	{
		0.0565338,
		0,
		0
	}
}
function processPaintMixerAndTanks(now, delta)
	local sumPigment = 0
	local sumTmp = 0
	local sumFinal = 0
	local blink = now % 1000 / 1000 >= 0.5
	local mixerLeds = {
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1
	}
	if mixerMaintenance then
		local percent = math.max(0, mixerTank.primer / mixerTankMaximum.primer)
		if percent < 0.15 then
			mixerLeds[1] = 3
		elseif percent < 0.4 then
			mixerLeds[1] = 2
		end
		local percent = math.max(0, mixerTank.base[1] / mixerTankMaximum.base)
		if percent < 0.15 then
			mixerLeds[2] = 3
		elseif percent < 0.4 then
			mixerLeds[2] = 2
		end
		local percent = math.max(0, mixerTank.base[2] / mixerTankMaximum.base)
		if percent < 0.15 then
			mixerLeds[3] = 3
		elseif percent < 0.4 then
			mixerLeds[3] = 2
		end
		for i = 1, #colorPalette do
			local percent = math.max(0, mixerTank.color[i] / mixerTankMaximum.color)
			if percent < 0.15 then
				mixerLeds[i + 3] = 3
			elseif percent < 0.4 then
				mixerLeds[i + 3] = 2
			end
		end
		for i = 1, #mixerMaintenance do
			if mixerMaintenance[i] == true then
				mixerLeds[i] = blink and 4 or mixerLeds[i]
			else
				mixerLeds[i] = 0
			end
		end
		mixerLeds[18] = 0
	else
		if mixerStarted then
			local sumRecipe = 0
			for i = 2, #mixerLeds do
				local rec = mixerStarted[3][i - 3] or 0
				mixerLeds[i] = 0 < rec and 1 or 0
				sumRecipe = sumRecipe + rec
			end
			local spd = mixerStarted[10] / 720
			mixerLeds[18] = blink and 1 <= spd and 1 or 0
			setSoundVolume(mixerSoundEffect, spd)
			setSoundSpeed(mixerSoundEffect, 0.5 + 0.5 * spd)
			mixerStarted[9] = mixerStarted[9] + mixerStarted[10] * delta / 1000
			mixerStarted[9] = mixerStarted[9] % 360
			local rad = math.rad(mixerStarted[9])
			local size = 0.04
			for i = #mixerStarted[5], 1, -1 do
				local col = mixerStarted[5][i][1]
				local prog = mixerStarted[5][i][3]
				local amount = mixerStarted[5][i][4]
				local plusProg = math.min(1 - prog, 1.125 * delta / 1000)
				mixerStarted[5][i][3] = prog + plusProg
				sumPigment = sumPigment + amount * (1 - prog - plusProg)
				mixerStarted[7][col] = mixerStarted[7][col] + amount * plusProg
				if 1 <= mixerStarted[5][i][3] then
					table.remove(mixerStarted[5], i)
				end
			end
			for i = #mixerStarted[4], 1, -1 do
				local col = mixerStarted[4][i][1]
				local amount = mixerStarted[4][i][3] * size
				mixerStarted[4][i][2] = mixerStarted[4][i][2] + 0.45 * delta / 1000
				local z = 0.352758 - mixerStarted[4][i][2]
				if 0.352758 <= z + amount then
					mixerLeds[col + 3] = 0
				end
				local d = 0.08388775000000001 - z
				if 0 < d then
					mixerStarted[4][i][2] = mixerStarted[4][i][2] - d
					local amMinus = math.min(mixerStarted[4][i][3], d / size)
					mixerStarted[4][i][3] = mixerStarted[4][i][3] - amMinus
					table.insert(mixerStarted[5], {
						col,
						rad,
						0,
						amMinus,
						mixerStarted[4][i][4]
					})
					if 0 >= mixerStarted[4][i][3] then
						table.remove(mixerStarted[4], i)
					end
				end
				dxDrawMaterialLine3D(mixerX - 0.03545, mixerY + mixerColorOffets[col][2], mixerZ + z + amount, mixerX - 0.03545, mixerY + mixerColorOffets[col][2], mixerZ + math.max(0.1, z), dropTexture, 0.006666666666666667, tocolor(colorPalette[col][1], colorPalette[col][2], colorPalette[col][3]))
			end
			local fx, fy, fz = 0, 0, 0
			local tx, ty, tz = 0, 0, 0
			for i = 1, #colorPalette do
				local cx, cy, cz = colorPalette[i][4], colorPalette[i][5], colorPalette[i][6]
				local w = mixerStarted[6][i]
				sumFinal = sumFinal + w
				fx = fx + cx * w
				fy = fy + cy * w
				fz = fz + cz * w
				local tmp = mixerStarted[7][i]
				w = w + tmp
				sumTmp = sumTmp + w
				tx = tx + cx * w
				ty = ty + cy * w
				tz = tz + cz * w
				if 0 < tmp then
					local minus = math.min(tmp, math.max(0.5, mixerStarted[7][i] / 25) * delta / 1000)
					mixerStarted[7][i] = tmp - minus
					mixerStarted[6][i] = mixerStarted[6][i] + minus
				end
			end
			local cx, cy, cz = colorPalette[1][4], colorPalette[1][5], colorPalette[1][6]
			local w = 0.75 - sumFinal
			if 0 < w then
				fx = fx + cx * w
				fy = fy + cy * w
				fz = fz + cz * w
				sumFinal = sumFinal + w
			end
			w = 0.75 - sumTmp
			if 0 < w then
				tx = tx + cx * w
				ty = ty + cy * w
				tz = tz + cz * w
				sumTmp = sumTmp + w
			end
			fx = fx / sumFinal
			fy = fy / sumFinal
			fz = fz / sumFinal
			tx = tx / sumTmp
			ty = ty / sumTmp
			tz = tz / sumTmp
			local h, s, l = xyzToHsl(tx, ty, tz)
			mixerStarted[11], mixerStarted[12], mixerStarted[13] = convertHSLToRGB(h, s, l)
			local h, s, l = xyzToHsl(fx, fy, fz)
			mixerStarted[14], mixerStarted[15], mixerStarted[16] = convertHSLToRGB(h, s, l)
			if 0 < mixerStarted[8] then
				if 0 >= #mixerStarted[4] or mixerStarted[8] < 500 then
					mixerStarted[8] = mixerStarted[8] - delta
					if 0 > mixerStarted[8] then
						mixerStarted[8] = 0
					end
				end
				if mixerStarted[1] < 1 then
					mixerLeds[(mixerStarted[2] and 2 or 1) + 1] = 1
				end
			elseif mixerStarted[1] < 1 then
				local id = mixerStarted[2] and 2 or 1
				mixerSliderTarget = mixerBaseOffsets[id][2]
				if mixerSliderPosition == mixerSliderTarget and sliderServoSpeed <= 0 then
					mixerLeds[id + 1] = blink and 1 or 0
					if 0 >= mixerStarted[1] then
						local sound = playSound3D("files/displong.mp3", mixerX - 0.0085, mixerY + mixerSliderPosition, mixerZ + 0.352758)
						setElementInterior(sound, targetInt)
						setElementDimension(sound, currentWorkshop)
					end
					local p = mixerStarted[1] + 0.18181818181818182 * delta / 1000
					local lp = 0.1
					if 1 < p then
						p = 1
						mixerStarted[8] = 1000
					end
					local z1 = 0.352758
					local z2 = -0.00417
					if lp > p then
						z1 = 0.352758
						z2 = 0.352758 + -0.356928 * (p / lp)
					elseif p > 1 - lp then
						z1 = 0.352758 + -0.356928 * ((p - (1 - lp)) / lp)
						z2 = -0.00417
					end
					dxDrawLine3D(mixerX - 0.008482, mixerY + mixerSliderTarget, mixerZ + z1, mixerX - 0.008482, mixerY + mixerSliderTarget, mixerZ + z2, tocolor(255, 255, 255), 0.5)
					mixerStarted[1] = p
					processMixerRenderTarget()
				else
					mixerLeds[id + 1] = 1
				end
			else
				local recipe = mixerStarted[3]
				local foundColor = false
				for i = 1, #recipe do
					if 0 < recipe[i] then
						mixerSliderTarget = mixerColorOffets[i][2]
						if mixerSliderPosition == mixerSliderTarget and sliderServoSpeed <= 0 and mixerStarted[10] >= 720 then
							local minus = math.min(1, recipe[i])
							recipe[i] = recipe[i] - minus
							table.insert(mixerStarted[4], {
								i,
								0,
								minus,
								now
							})
							local sound = playSound3D("files/dispense.mp3", mixerX - 0.0085, mixerY + mixerSliderPosition, mixerZ + 0.352758)
							setElementInterior(sound, targetInt)
							setElementDimension(sound, currentWorkshop)
							processMixerRenderTarget()
							if recipe[i] <= 0 then
								mixerStarted[8] = 1000
							else
								mixerStarted[8] = 325
							end
						end
						foundColor = true
						break
					end
				end
				if not foundColor then
					mixerSliderTarget = mixerBaseOffsets[1][2]
				end
			end
			if mixerSliderPosition ~= mixerSliderTarget then
				if sliderServoSpeed < 1 then
					sliderServoSpeed = sliderServoSpeed + 1 * delta / 1000
					if 1 < sliderServoSpeed then
						sliderServoSpeed = 1
					end
					if not isElement(servoSoundEffect) then
						servoSoundEffect = playSound3D("files/servo.mp3", mixerX - 0.0085, mixerY + mixerSliderPosition, mixerZ - 0.087629, true)
						setElementInterior(servoSoundEffect, targetInt)
						setElementDimension(servoSoundEffect, currentWorkshop)
						attachElements(servoSoundEffect, mixerSlider)
					end
				end
			elseif 0 < sliderServoSpeed then
				sliderServoSpeed = sliderServoSpeed - 10 * delta / 1000
				if sliderServoSpeed <= 0 then
					sliderServoSpeed = 0
					if isElement(servoSoundEffect) then
						destroyElement(servoSoundEffect)
					end
					servoSoundEffect = false
				end
			end
			if servoSoundEffect then
				setSoundVolume(servoSoundEffect, sliderServoSpeed / 1 * 0.5)
				setSoundSpeed(servoSoundEffect, 0.75 + sliderServoSpeed / 1 * 0.25)
			end
			if mixerSliderPosition < mixerSliderTarget then
				mixerSliderPosition = mixerSliderPosition + sliderServoSpeed * delta / 1000
				if mixerSliderPosition > mixerSliderTarget then
					mixerSliderPosition = mixerSliderTarget
				end
			end
			if mixerSliderPosition > mixerSliderTarget then
				mixerSliderPosition = mixerSliderPosition - sliderServoSpeed * delta / 1000
				if mixerSliderPosition < mixerSliderTarget then
					mixerSliderPosition = mixerSliderTarget
				end
			end
			setElementPosition(mixerSlider, mixerX - 0.0085, mixerY + mixerSliderPosition, mixerZ - 0.087629)
			if sumRecipe == 0 and sumTmp == sumFinal and mixerSliderPosition == mixerSliderTarget and now - mixerStarted[18] > 93454.54545454546 then
				if 0 < mixerStarted[10] then
					mixerStarted[10] = mixerStarted[10] - 110 * delta / 1000
					if 0 > mixerStarted[10] then
						mixerStarted = false
						if isElement(mixerSoundEffect) then
							destroyElement(mixerSoundEffect)
						end
						mixerSoundEffect = nil
						mixerSliderTarget = mixerBaseOffsets[1][2]
						setElementPosition(mixerSlider, mixerX - 0.0085, mixerY + mixerSliderTarget, mixerZ - 0.087629)
						processMixerRenderTarget()
						local sound = playSound3D("files/beep.mp3", mixerX - 0.0085, mixerY + mixerSliderTarget, mixerZ - 0.087629)
						setElementInterior(sound, targetInt)
						setElementDimension(sound, currentWorkshop)
						setSoundMaxDistance(sound, 55)
					end
				end
			elseif mixerStarted[10] < 720 and 1 <= mixerStarted[1] then
				mixerStarted[10] = mixerStarted[10] + 150 * delta / 1000
				if mixerStarted[10] > 720 then
					mixerStarted[10] = 720
				end
			end
		else
			local percent = math.max(0, mixerTank.primer / mixerTankMaximum.primer)
			if percent < 0.15 then
				mixerLeds[1] = 3
			elseif percent < 0.4 then
				mixerLeds[1] = 2
			end
			if loadedMixerRecipe then
				if 1 > mixerTank.base[1] then
					mixerLeds[2] = 3
				end
				if 1 > mixerTank.base[2] then
					mixerLeds[3] = 3
				end
				for i = 1, #colorPalette do
					if 0 < validColors[loadedMixerRecipe][i] then
						if mixerTank.color[i] < validColors[loadedMixerRecipe][i] then
							mixerLeds[i + 3] = 3
						end
					else
						mixerLeds[i + 3] = 0
					end
				end
			else
				local percent = math.max(0, mixerTank.base[1] / mixerTankMaximum.base)
				if percent < 0.15 then
					mixerLeds[2] = 3
				elseif percent < 0.4 then
					mixerLeds[2] = 2
				end
				local percent = math.max(0, mixerTank.base[2] / mixerTankMaximum.base)
				if percent < 0.15 then
					mixerLeds[3] = 3
				elseif percent < 0.4 then
					mixerLeds[3] = 2
				end
				for i = 1, #colorPalette do
					local percent = math.max(0, mixerTank.color[i] / mixerTankMaximum.color)
					if percent < 0.15 then
						mixerLeds[i + 3] = 3
					elseif percent < 0.4 then
						mixerLeds[i + 3] = 2
					end
				end
			end
		end
		for i = 1, #sprayGuns do
			if paintGunDatas[i].tank == "mixer" then
				setElementPosition(sprayGuns[i], mixerX - 0.0085, mixerY + mixerSliderPosition - 0.1399, mixerZ - 0.087629 - 0.0868)
				setElementRotation(sprayGuns[i], -26.0089, 0, 0)
				if mixerStarted then
					local p = mixerStarted[1]
					if p < 1 then
						dxSetShaderValue(sprayShaders[i], "paintLevel", math.max(0, (p - 0.1) / 0.9) * 0.85)
					else
						dxSetShaderValue(sprayShaders[i], "paintLevel", 0.85 + 0.15 * (sumTmp + sumPigment) / 100)
					end
					dxSetShaderValue(sprayShaders[i], "mixSpeed", mixerStarted[10] / 720)
					processSprayGunMixerTarget(i)
				end
			elseif paintGunDatas[i].tank == "primer" then
				setElementPosition(sprayGuns[i], mixerX - 0.0085, mixerY - 2.6209, mixerZ - 0.2846)
				setElementRotation(sprayGuns[i], -26.0089, 0, 0)
				if tonumber(primerMachineStarted) then
					mixerLeds[1] = blink and 1 or 0
					local delta = now - primerMachineStarted
					local f = 0.1
					local p = delta / 5000
					local z1 = 0.352758
					local z2 = -0.108612
					if f > p then
						z1 = 0.352758
						z2 = 0.352758 + -0.46137 * (p / f)
					elseif 1 < p then
						z1 = 0.352758 + -0.46137 * ((p - 1) / f)
						z2 = -0.108612
					end
					dxDrawLine3D(mixerX - 0.008482, mixerY - 2.48086, mixerZ + z1, mixerX - 0.008482, mixerY - 2.48086, mixerZ + z2, tocolor(primerR, primerG, primerB), 0.5)
					dxSetShaderValue(sprayShaders[i], "paintLevel", math.min(1, math.max(0, p - f)))
					if 1 <= p - f then
						primerMachineStarted = false
					end
					processMixerRenderTarget()
				elseif primerMachineStarted then
					dxSetShaderValue(sprayShaders[i], "paintLevel", 0)
				else
					dxSetShaderValue(sprayShaders[i], "paintLevel", paintGunDatas[i].paintLevel)
				end
			end
		end
	end
	for i = 1, #mixerLedOffsets do
		local x, y, z = mixerX + mixerLedOffsets[i][1], mixerY + mixerLedOffsets[i][2], mixerZ + mixerLedOffsets[i][3]
		if i == 18 then
			x = x - 0.0085
			y = y + mixerSliderPosition
			z = z - 0.087629
		end
		x = x + 0.0015
		local col = false
		if mixerLeds[i] == 1 then
			col = tocolor(0, 255, 0)
		elseif mixerLeds[i] == 2 then
			col = tocolor(255, 155, 0)
		elseif mixerLeds[i] == 3 then
			col = tocolor(255, 0, 0)
		elseif mixerLeds[i] == 4 then
			col = tocolor(55, 135, 255)
		end
		if col then
			dxDrawMaterialLine3D(x, y, z - 0.0125, x, y, z + 0.0125, ledTexture, 0.025, col, x - 1, y, z)
		end
	end
end
local uvXCache = {}
local uvYCache = {}
local depthCache = {}
local cacheCX, cacheCY, cacheCZ, cacheTX, cacheTY, cacheTZ
function getPixelDepth(cx, cy)
	if depthCache[cx] and type(depthCache[cx][cy]) ~= "nil" then
		return depthCache[cx][cy]
	end
	local uvD
	local pixelDepth = dxGetTexturePixels(renderTargetDepth, cx, cy, 1, 1)
	if pixelDepth then
		uvD = calculateCoord(pixelDepth, 0, 0)
		uvD = uvD and uvD * 10
	end
	if not depthCache[cx] then
		depthCache[cx] = {}
	end
	depthCache[cx][cy] = uvD
	return uvD
end
function getPixelCoord(cx, cy)
	local uvX, uvY = false, false
	if uvXCache[cx] and type(uvXCache[cx][cy]) ~= "nil" then
		uvX = uvXCache[cx][cy]
	else
		local pixelX = dxGetTexturePixels(renderTargetX, cx, cy, 1, 1)
		if pixelX then
			uvX = calculateCoord(pixelX, 0, 0)
		end
		if not uvXCache[cx] then
			uvXCache[cx] = {}
		end
		uvXCache[cx][cy] = uvX
	end
	if uvX then
		if uvYCache[cx] and type(uvYCache[cx][cy]) ~= "nil" then
			uvY = uvYCache[cx][cy]
		else
			local pixelY = dxGetTexturePixels(renderTargetY, cx, cy, 1, 1)
			if pixelY then
				uvY = calculateCoord(pixelY, 0, 0)
			end
			if not uvYCache[cx] then
				uvYCache[cx] = {}
			end
			uvYCache[cx][cy] = uvY
		end
	end
	return uvX, uvY
end
function processCoordCache(reset)
	local cx, cy, cz, tx, ty, tz = getCameraMatrix()
	if cacheCX ~= cx then
		cacheCX = cx
		reset = true
	end
	if cacheCY ~= cy then
		cacheCY = cy
		reset = true
	end
	if cacheCZ ~= cz then
		cacheCZ = cz
		reset = true
	end
	if cacheTX ~= tx then
		cacheTX = tx
		reset = true
	end
	if cacheTY ~= ty then
		cacheTY = ty
		reset = true
	end
	if cacheTZ ~= tz then
		cacheTZ = tz
		reset = true
	end
	if reset then
		uvXCache = {}
		uvYCache = {}
		depthCache = {}
	end
end
function sendCanWorkWarning(text)
	if canWorkWarning ~= text and not paintshopHover then
		if carWindow or carPrompt then
			local x, y = sightexports.sGui:getGuiPosition(carWindow or carPrompt)
			local sx, sy = sightexports.sGui:getGuiSize(carWindow or carPrompt)
			if x <= cx and cx <= x + sx and y <= cy and cy <= y + sy then
				return
			end
		end
		sightexports.sGui:showInfobox("e", text)
		canWorkWarning = text
	end
end
function processOfficeDoor(players, delta)
	local tmp = false
	local x, y, z = wsX + 6.9973 - 0.715, wsY - 3.0941, wsZ + 1.1438
	for i = 1, #players do
		local px, py, pz = getElementPosition(players[i])
		local d = getDistanceBetweenPoints2D(px, py, x, y)
		if d < 2 then
			tmp = true
			break
		end
	end
	if tmp ~= officeDoorState then
		officeDoorState = tmp
		if tmp then
			setElementCollisionsEnabled(officeDoorObj, false)
			local sound = playSound3D("files/do.mp3", x, y, z)
				setElementInterior(sound, targetInt)
				setElementDimension(sound, currentWorkshop)
			else
				local sound = playSound3D("files/dc.mp3", x, y, z)
				setElementInterior(sound, targetInt)
				setElementDimension(sound, currentWorkshop)
			end
		end
		if officeDoorState then
			if officeDoorP < 1 then
				officeDoorP = officeDoorP + 2 * delta / 1000
				if 1 < officeDoorP then
					officeDoorP = 1
				end
				setObjectScale(officeDoorObj, 1 - 0.85 * getEasingValue(officeDoorP, "OutQuad"), 1, 1)
			end
		elseif 0 < officeDoorP then
			officeDoorP = officeDoorP - 2 * delta / 1000
			if officeDoorP < 0 then
				officeDoorP = 0
				setElementCollisionsEnabled(officeDoorObj, true)
			end
			setObjectScale(officeDoorObj, 1 - 0.85 * getEasingValue(officeDoorP, "InQuad"), 1, 1)
		end
	end
	function preRenderPaintshop(delta)
		setTime(12, 0)
		setWeather(1)
		local now = getTickCount()
		if now - lastEmailNoti < 5000 then
			local x, y, z = 2.5224609375, -3.5927734375, 5001.8046875
			dxDrawMaterialLine3D(wsX + 3.0953, wsY - 3.4848, wsZ + 1.0694, wsX + 3.0842, wsY - 3.5613, wsZ + 0.8572, false, emailTexture, 0.300154, tocolor(255, 255, 255), wsX + 3.0604, wsY - 3.7256, wsZ + 1.0378)
		end
		if loaderIcon then
			sightexports.sGui:setImageRotation(loaderIcon, now / 5 % 360)
		end
		local pipeUsed = {}
		local players = getElementsByType("player", getRootElement(), true)
		for i = 1, #players do
			local player = players[i]
			local gun = playerGuns[player]
			local sander = playerSanders[player]
			if gun and sprayGuns[gun] then
				pipeUsed[gun] = true
			end
			if tonumber(paintingAnim[player]) and paintingAnimPoses[player] then
				local id = tonumber(paintingAnim[player])
				if id then
					local x, y, z = unpack(paintingAnimPoses[player])
					local px, py, pz, fx, fy, fz
					if paintshopWorks[id] then
						if paintshopWorks[id].state == "sanding" then
							if sander and sanderMachines[sander] then
								if not machineSounds[player] then
									local x, y, z = getElementPosition(sanderMachines[sander])
									machineSounds[player] = playSound3D("files/sandloop.mp3", x, y, z, true)
									setElementInterior(machineSounds[player], targetInt)
									setElementDimension(machineSounds[player], currentWorkshop)
									setSoundVolume(machineSounds[player], 0)
									setSoundMaxDistance(machineSounds[player], 75)
									attachElements(machineSounds[player], sanderMachines[sander])
									machineStartTick[player] = now
								end
								machineEndTick[player] = now
								local m = getElementMatrix(sanderMachines[sander])
								px, py, pz = getPositionFromMatrixOffset(m, -3.2E-5, 0.111072, 0.089436)
								fx, fy, fz = m[2][1], m[2][2], m[2][3]
								px = px - fx
								py = py - fy
								pz = pz - fz
							end
						elseif (paintshopWorks[id].state == "primer" or paintshopWorks[id].state == "paint") and gun and sprayGuns[gun] then
							if not machineSounds[player] then
								local x, y, z = getElementPosition(sprayGuns[gun])
								machineSounds[player] = playSound3D("files/spray.mp3", x, y, z, true)
								setElementInterior(machineSounds[player], targetInt)
								setElementDimension(machineSounds[player], currentWorkshop)
								setSoundVolume(machineSounds[player], 0)
								attachElements(machineSounds[player], sprayGuns[gun])
								machineStartTick[player] = now
							end
							machineEndTick[player] = now
							local m = getElementMatrix(sprayGuns[gun])
							px, py, pz = getPositionFromMatrixOffset(m, 0, 0.118289, 0.14529)
							fx, fy, fz = m[2][1], m[2][2], m[2][3]
							px = px - fx
							py = py - fy
							pz = pz - fz
						end
					end
					if px then
						if not paintingAnimDegrees[player] then
							paintingAnimDegrees[player] = {0, 0}
						else
							local deg1 = math.deg(math.atan2(y - py, x - px))
							local deg2 = math.deg(math.atan2(fy, fx))
							local a = deg1 - deg2
							a = (a + 180) % 360 - 180
							abs = math.abs(a)
							local degSpd = 60
							if player == localPlayer then
								degSpd = degSpd * 2.5
							end
							if abs > 0.5 then
								local spd = degSpd * (a / abs) * delta / 1000
								if 5 > abs then
									spd = math.min(abs, math.max(-abs, spd))
								end
								paintingAnimDegrees[player][1] = math.min(90, math.max(-90, paintingAnimDegrees[player][1])) + spd
								if paintingAnimDegrees[player][1] > 45 then
									local rx, ry, rz = getElementRotation(player)
									setElementRotation(player, 0, 0, rz + 90 * delta / 1000, "default", true)
								elseif paintingAnimDegrees[player][1] < -45 then
									local rx, ry, rz = getElementRotation(player)
									setElementRotation(player, 0, 0, rz - 90 * delta / 1000, "default", true)
								end
							end
							local deg1 = math.deg(math.atan2(z - pz, getDistanceBetweenPoints2D(x, y, px, py)))
							local deg2 = math.deg(math.atan2(fz, math.sqrt(fx * fx + fy * fy)))
							local a = deg1 - deg2
							a = (a + 180) % 360 - 180
							abs = math.abs(a)
							if abs > 0.5 then
								local spd = degSpd * (a / abs) * delta / 1000
								if 5 > abs then
									spd = math.min(abs, math.max(-abs, spd))
								end
								paintingAnimDegrees[player][2] = math.min(80, math.max(-80, paintingAnimDegrees[player][2])) - spd
							end
						end
					end
					if paintshopWorks[id] and px and fx and x and (paintshopWorks[id].state == "primer" or paintshopWorks[id].state == "paint") then
						spawnPaintParticle(id, px + fx, py + fy, pz + fz, x, y, z)
						sprayBar[gun] = sprayBar[gun] - 0.045 * delta / 1000
						lastCompressor = now
					end
				end
			end
			if machineSounds[player] then
				local vol = 1
				if machineStartTick[player] then
					local p = (now - machineStartTick[player]) / 150
					if 1 <= p then
						vol = 1
						machineStartTick[player] = nil
					else
						vol = p
					end
				elseif machineEndTick[player] then
					local p = (now - machineEndTick[player]) / 150
					if 1 <= p then
						if isElement(machineSounds[player]) then
							destroyElement(machineSounds[player])
						end
						machineEndTick[player] = nil
						machineSounds[player] = nil
					else
						vol = 1 - p
					end
				end
				if machineSounds[player] then
					setSoundVolume(machineSounds[player], vol)
				end
			end
		end
		processOfficeDoor(players, delta)
		processPaintMixerAndTanks(now, delta)
		processCompressor(now, delta)
		processSanders(now)
		renderAirPipes(pipeUsed)
		renderParticles(delta)
		processBoothDoorsAndTimer(now, delta)
		local d = 4.5
		local tmp = false
		local px, py, pz = getElementPosition(localPlayer)
		local inBooth = px >= boothCoordinates[1] and py >= boothCoordinates[2] and px <= boothCoordinates[3] and py <= boothCoordinates[4]
		local outsideBoothVolume = 0.15 + boothDoor * 0.6
		local deiredBoothVolume = inBooth and 1 or outsideBoothVolume
		if deiredBoothVolume > boothVolume then
			boothVolume = boothVolume + 4 * delta / 1000
			if deiredBoothVolume < boothVolume then
				boothVolume = deiredBoothVolume
			end
		elseif deiredBoothVolume < boothVolume then
			boothVolume = boothVolume - 4 * delta / 1000
			if deiredBoothVolume > boothVolume then
				boothVolume = deiredBoothVolume
			end
		end
		if playerGuns[localPlayer] and not inBooth then
			playerGuns[localPlayer] = nil
			for i = 1, 2 do
				if dataToSync[i] or 0 < (unsyncedPaintDelta[i] or 0) then
					syncData(i)
				end
			end
			triggerLatentServerEvent("putBackPaintShopGun", localPlayer)
		end
		if dryStart then
			if isElement(drySecondarySound) then
				setSoundVolume(drySecondarySound, boothVolume)
			end
			if 550 < now - dryStart then
				local p = math.min(1, (now - dryStart - 550) / 5500)
				setSoundVolume(drySound, getEasingValue(p, "OutQuad") * boothVolume)
				if 1 <= p then
					if isElement(drySecondarySound) then
						destroyElement(drySecondarySound)
					end
					drySecondarySound = false
					dryStart = false
				end
			end
		elseif dryStop then
			if isElement(drySecondarySound) then
				setSoundVolume(drySecondarySound, boothVolume)
			end
			if 500 < now - dryStop and drySound then
				local p = math.min(1, (now - dryStop - 500) / 2250)
				setSoundVolume(drySound, (1 - getEasingValue(p, "OutQuad")) * boothVolume)
				if 10000 < now - dryStop then
					if isElement(drySecondarySound) then
						destroyElement(drySecondarySound)
					end
					drySecondarySound = false
					if isElement(drySound) then
						destroyElement(drySound)
					end
					drySound = false
					dryStop = false
				end
			end
		elseif drySound then
			setSoundVolume(drySound, boothVolume)
		end
		local doSyncInterval = 1 < #players and 3000 or 6500
		for i = 1, 2 do
			if isElement(workCars[i]) then
				if workCarFrozen[i] and not isElementFrozen(workCars[i]) then
					freezeWorkCar(i)
				end
				if carShaders[i] then
					if paintshopWorks[i].state == "paintDry" then
						dxSetShaderValue(carShaders[i], "dryRate", paintshopWorks[i].dryingProgress)
					elseif paintshopWorks[i].state == "primerDry" then
						if paintshopWorks[i].dryingState then
							dxSetShaderValue(carShaders[i], "dryRate", math.min(1, paintshopWorks[i].dryingProgress + (now - paintshopWorks[i].dryingStart) / 900000))
						else
							dxSetShaderValue(carShaders[i], "dryRate", math.min(1, paintshopWorks[i].dryingProgress))
						end
					end
				end
				for j = 1, 4 do
					setVehicleComponentVisible(workCars[i], wheels[j], false)
					local s = wheelSizes[i][j]
					local x, y, z = getVehicleComponentPosition(workCars[i], wheels[j], "world")
					local rx, ry, rz = getVehicleComponentRotation(workCars[i], wheels[j], "world")
					if not x then
						x, y, z = getElementPosition(workCars[i])
						rx, ry, rz = getElementRotation(workCars[i])
					end
					setElementPosition(wheelMasks[i][j], x, y, gz + s / 2 - 0.05)
					setElementRotation(wheelMasks[i][j], 0, 0, rz - 90)
					setObjectScale(wheelMasks[i][j], s / 0.788921, 0.75, s / 0.788921)
				end
				local x, y, z = getElementPosition(workCars[i])
				local vd = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
				if d > vd then
					d = vd
					tmp = i
				end
			end
			if (dataToSync[i] or 0 < (unsyncedPaintDelta[i] or 0)) and doSyncInterval < now - (lastSync[i] or 0) then
				syncData(i)
			end
		end
		if permissionDataToSync then
			permissionDataToSync = permissionDataToSync - delta
			if 0 > permissionDataToSync then
				syncPermissionData()
			end
		end
		if tmp ~= currentWorkingCar and not bigLoader then
			if currentWorkingCar then
				carShaderWorkMode(currentWorkingCar, false)
			end
			currentWorkingCar = tmp
			processCoordCache(true)
			createCarWindow()
			dxSetRenderTarget(renderTargetX, true)
			dxSetRenderTarget(renderTargetY, true)
			dxSetRenderTarget(renderTargetDepth, true)
			if currentWorkingCar then
				carShaderWorkMode(currentWorkingCar, true)
			end
			dxSetRenderTarget()
			lastParticleEffect = 0
		end
		for i = #timedPaintParticles, 1, -1 do
			timedPaintParticles[i][7] = timedPaintParticles[i][7] - delta
			if 0 > timedPaintParticles[i][7] then
				spawnTimedPaintParticle(timedPaintParticles[i][1], timedPaintParticles[i][2], timedPaintParticles[i][3], timedPaintParticles[i][4], timedPaintParticles[i][5], timedPaintParticles[i][6])
				table.remove(timedPaintParticles, i)
			end
		end
		for i = #timedPaint, 1, -1 do
			timedPaint[i][3] = timedPaint[i][3] - delta
			if 0 > timedPaint[i][3] then
				local id = timedPaint[i][1]
				local s = timedPaint[i][2]
				local a = timedPaint[i][4]
				local curr = unsyncedData[id][s] or syncedData[id][s] or 0
				unsyncedData[id][s] = math.min(255, curr + a)
				drawMask(id)
				dataToSync[id] = true
				table.remove(timedPaint, i)
			end
		end
		cx, cy = getCursorPosition()
		if cx then
			cx = math.floor(cx * screenX)
			cy = math.floor(cy * screenY)
		end
		if currentWorkingCar and carShaders[currentWorkingCar] then
			processCoordCache()
			local id = currentWorkingCar
			if 0 < lastParticleEffect then
				lastParticleEffect = lastParticleEffect - delta
			end
			if 0 < lastParticleSync then
				lastParticleSync = lastParticleSync - delta
			end
			if canWorkWarning and not getKeyState("mouse1") then
				canWorkWarning = false
			end
			if cx and getKeyState("mouse1") and not paintshopWorks[id].stateSwitching and not paintshopWorks[id].nextState and (paintshopWorks[id].state == "primer" or paintshopWorks[id].state == "paint" or paintshopWorks[id].state == "sanding") then
				local canWork = false
				if paintshopWorks[id].state == "primer" or paintshopWorks[id].state == "paint" then
					canWork = playerGuns[localPlayer]
					if canWork then
						if paintGunDatas[canWork] then
							if 1 == 1 then
								if paintshopWorks[id].state == "primer" then
									if paintGunDatas[canWork].paintType == "primer" then
										canWork = 0 < paintGunDatas[canWork].paintLevel and tonumber(playerGuns[localPlayer])
										if not canWork then
											sendCanWorkWarning("Üres a tartályod!")
										end
									else
										if paintGunDatas[canWork].paintLevel and 0 < paintGunDatas[canWork].paintLevel then
											sendCanWorkWarning("Csak alapozót fújhatsz erre a járműre!")
										else
											sendCanWorkWarning("Üres a tartályod!")
										end
										canWork = false
									end
								elseif paintshopWorks[id].state == "paint" then
									if paintGunDatas[canWork].paintMetal == nil then
										paintGunDatas[canWork].paintMetal = false
									end
									if paintGunDatas[canWork].paintType == paintshopWorks[id].color and paintGunDatas[canWork].paintMetal == paintshopWorks[id].metal then
										canWork = 0 < paintGunDatas[canWork].paintLevel and tonumber(playerGuns[localPlayer])
										if not canWork then
											sendCanWorkWarning("Üres a tartályod!")
										end
									else
										if paintGunDatas[canWork].paintLevel and 0 < paintGunDatas[canWork].paintLevel then
											sendCanWorkWarning("Nem megfelelő festék!")
										else
											sendCanWorkWarning("Üres a tartályod!")
										end
										canWork = false
									end
								else
									canWork = false
								end
							else
								canWork = false
								sendCanWorkWarning("Előbb zárd be a fényezőkamrát!")
							end
						else
							canWork = false
						end
					end
				elseif paintshopWorks[id].state == "sanding" then
					canWork = playerSanders[localPlayer]
					if canWork then
						canWork = sanderMachineDatas[canWork] and sanderMachineDatas[canWork].socket
						if canWork then
							canWork = tonumber(playerSanders[localPlayer])
						else
							sendCanWorkWarning("Dugd be a csiszológépet egy konnektorba!")
						end
					end
				end
				if canWork and (carWindow or carPrompt) then
					local x, y = sightexports.sGui:getGuiPosition(carWindow or carPrompt)
					local sx, sy = sightexports.sGui:getGuiSize(carWindow or carPrompt)
					if x <= cx and cx <= x + sx and y <= cy and cy <= y + sy then
						canWork = false
					end
				end
				
				if canWork and not myWorkSkin then
					sendCanWorkWarning("Előbb vedd fel a munkaruhát!")
					canWork = false
				end
				
				if canWork then
					playerAlphaSet = true
					local depth = getPixelDepth(cx, cy)
					if depth then
						local px, py, pz = getElementPosition(localPlayer)
						local x, y, z = getWorldFromScreenPosition(cx, cy, depth)
						local d = getDistanceBetweenPoints2D(x, y, px, py)
						if d <= 1.7 then
							local tx, ty = getPixelCoord(cx, cy)
							if tx and ty then
								tx = math.floor(tx * 1024)
								ty = math.floor(ty * 1024)
								if paintshopWorks[id].state == "primer" or paintshopWorks[id].state == "paint" then
									paintingAnimTime = 1000
									if not paintingAnimPoses[localPlayer] then
										paintingAnimPoses[localPlayer] = {}
									end
									paintingAnimPoses[localPlayer][1] = x
									paintingAnimPoses[localPlayer][2] = y
									paintingAnimPoses[localPlayer][3] = z
									if lastParticleEffect <= 0 then
										triggerLatentServerEvent("syncPaintshopPaintAnimPosition", localPlayer, x, y, z)
										lastParticleEffect = syncEffectInterval
									end
									if unsyncedPaintGunId[id] ~= canWork then
										if unsyncedPaintGunId[id] and (dataToSync[id] or 0 < (unsyncedPaintDelta[id] or 0)) then
											syncData(id)
										end
										unsyncedPaintGunId[id] = canWork
									end
									unsyncedPaintDelta[id] = (unsyncedPaintDelta[id] or 0) + delta / 1000
									paintGunDatas[canWork].paintLevel = paintGunDatas[canWork].paintLevel - 5 * delta / 1000 * 8.75E-4
									dxSetShaderValue(sprayShaders[canWork], "paintLevel", paintGunDatas[canWork].paintLevel)
								elseif paintshopWorks[id].state == "sanding" then
									paintingAnimTime = 1000
									if not paintingAnimPoses[localPlayer] then
										paintingAnimPoses[localPlayer] = {}
									end
									if unsyncedPaintGunId[id] ~= canWork then
										if unsyncedPaintGunId[id] and (dataToSync[id] or 0 < (unsyncedPaintDelta[id] or 0)) then
											syncData(id)
										end
										unsyncedPaintGunId[id] = canWork
									end
									paintingAnimPoses[localPlayer][1] = x
									paintingAnimPoses[localPlayer][2] = y
									paintingAnimPoses[localPlayer][3] = z
								end
								local s = coordToSync(tx, ty)
								local curr = unsyncedData[id][s] or syncedData[id][s] or 0
								if curr < 255 then
									if paintshopWorks[id].state == "sanding" and lastParticleEffect <= 0 then
										if math.random(0, 100) < 100 - particleSpawnChance then
											spawnSandingParticle(x, y, z, (curr / 255))
											unsyncedParticleNum = unsyncedParticleNum + 1
											if lastParticleSync <= 0 then
												triggerLatentServerEvent("syncPaintshopSandingParticle", localPlayer, x, y, z, curr / 255, unsyncedParticleNum)
												lastParticleSync = syncEffectInterval
												unsyncedParticleNum = 0
											end
										end
										lastParticleEffect = math.random(100, 250)
									end
									if paintshopWorks[id].state == "sanding" then
										unsyncedData[id][s] = math.min(255, curr + 382.5 * delta / 1000)
										drawMask(id)
										dataToSync[id] = true
									else
										local time = getPaintTime(x, y, z)
										table.insert(timedPaint, {
											id,
											s,
											time,
											1275 * delta / 1000
										})
									end
								end
							end
						else
							paintingAnimTime = 0
						end
					end
				end
			else
				canWorkWarning = false
				paintingAnimTime = 0
				if playerAlphaSet then
					playerAlphaSet = false
				end
				if not dataToSync[id] then
					lastSync[id] = getTickCount()
				end
			end
			local tmp = 0 < paintingAnimTime and id or false
			if tmp then
				paintingAnimTime = paintingAnimTime - delta
			end
			if paintingAnim[localPlayer] ~= tmp then
				paintingAnim[localPlayer] = tmp
				if paintingAnim[localPlayer] then
					if isPedDucked(localPlayer) then
						setPedAnimation(localPlayer)
						engineReplaceAnimation(localPlayer, "ped", "weapon_crouch", paintshopWorks[id].state == "sanding" and "paint_sand_crouch" or "paint_crouch", "Copbrowse_in")
					else
						setPedAnimation(localPlayer, paintshopWorks[id].state == "sanding" and "paint_sand_stand" or "paint_stand", "Copbrowse_in", -1, true, false, false, true, 100, true)
					end
				else
					engineRestoreAnimation(localPlayer, "ped", "weapon_crouch")
					paintingAnimDegrees[localPlayer] = nil
					setPedAnimation(localPlayer)
				end
				triggerLatentServerEvent("syncPaintshopPaintAnim", localPlayer, tmp)
			end
			dxSetRenderTarget(renderTargetX, true)
			dxSetRenderTarget(renderTargetY, true)
			dxSetRenderTarget(renderTargetDepth, true)
			dxSetRenderTarget()
		elseif paintingAnim[localPlayer] then
			paintingAnim[localPlayer] = false
			engineRestoreAnimation(localPlayer, "ped", "weapon_crouch")
			paintingAnimDegrees[localPlayer] = nil
			setPedAnimation(localPlayer)
			triggerLatentServerEvent("syncPaintshopPaintAnim", localPlayer, false)
		end
	end
	function pedsProcessPaintshop()
		local players = getElementsByType("player", getRootElement(), true)
		for i = 1, #players do
			local player = players[i]
			if tonumber(paintingAnim[player]) and paintingAnimPoses[player] and paintingAnimDegrees[player] then
				setElementBoneRotation(player, 2, math.min(80, math.max(-80, paintingAnimDegrees[player][1])), 0, 0)
				setElementBoneRotation(player, 3, 0, math.min(70, math.max(-70, paintingAnimDegrees[player][2])), 0)
				sightexports.sCore:updateElementRpHAnim(player)
			elseif playerGuns[player] then
				setElementBoneRotation(player, 22, 0, 0, -60)
				setElementBoneRotation(player, 23, 0, -90, 0)
				setElementBoneRotation(player, 32, 0, -20, 50)
				setElementBoneRotation(player, 33, 45, -90, 0)
				sightexports.sCore:updateElementRpHAnim(player)
			end
		end
	end
	function pedsProcessPaintshopEx()
		local players = getElementsByType("player", getRootElement(), true)
		for i = 1, #players do
			local player = players[i]
			local j = playerGuns[player]
			if j and sprayGuns[j] then
				local px, py, pz = getPedBonePosition(player, 35)
				local n = #airPipes[j]
				airPipes[j][n][1] = px
				airPipes[j][n][2] = py
				airPipes[j][n][3] = pz
				local x, y, z = getElementPosition(sprayGuns[j])
				gunPoses[j][1] = x
				gunPoses[j][2] = y
				gunPoses[j][3] = z
			end
		end
	end
	
	lastCheck = getTickCount() - 60000
	
	addEvent("checkPaintshopProgress", false)
	addEventHandler("checkPaintshopProgress", getRootElement(), function()
		if currentWorkingCar and paintshopWorks[currentWorkingCar] and not paintshopWorks[currentWorkingCar].checking then
			if getTickCount() - lastCheck <= 60000 then
				sightexports.sGui:showInfobox("e", "Kérlek várj még az ellenőrzéssel!")
				return
			end
			if dataToSync[currentWorkingCar] or 0 < (unsyncedPaintDelta[currentWorkingCar] or 0) then
				syncData(currentWorkingCar)
			end
			paintshopWorks[currentWorkingCar].checking = true
			createCarWindow()
			triggerLatentServerEvent("tryToCheckPaintshopProgress", localPlayer, currentWorkingCar)
			lastCheck = getTickCount()
		end
	end)
	
	nextState = getTickCount() - 30000
	
	addEvent("finalNextPaintshopState", false)
	addEventHandler("finalNextPaintshopState", getRootElement(), function()
		if currentWorkingCar and paintshopWorks[currentWorkingCar] and not paintshopWorks[currentWorkingCar].checking then
			if dataToSync[currentWorkingCar] or 0 < (unsyncedPaintDelta[currentWorkingCar] or 0) then
				syncData(currentWorkingCar)
			end
			createCarWindow()
			if not getPlayerPermission("nextState") then
				sightexports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
				return
			end
			if getTickCount() - nextState > 30000 then
				triggerLatentServerEvent("tryToNextPaintshopState", localPlayer, currentWorkingCar)
			else
				exports.sGui:showInbox("e", "Várj még a következő munkafolyamattal!")
			end
		end
	end)
	local carWindowX, carWindowY
	addEvent("tryToNextPaintshopState", false)
	addEventHandler("tryToNextPaintshopState", getRootElement(), function()
		if currentWorkingCar and paintshopWorks[currentWorkingCar] and not paintshopWorks[currentWorkingCar].checking then
			if not getPlayerPermission("nextState") then
				sightexports.sGui:showInfobox(client, "e", "Ehhez nincs jogosultságod!")
				return
			end
			local titleBarHeight = sightexports.sGui:getTitleBarHeight()
			local sandingSkip = paintshopWorks[currentWorkingCar].state == "sanding" and paintshopWorks[currentWorkingCar].lastPercent < 96
			local pw = 375
			local ph = titleBarHeight + 120 + (sandingSkip and 32 or 0)
			deleteCarWindow()
			carPrompt = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
			sightexports.sGui:setWindowTitle(carPrompt, "16/BebasNeueRegular.otf", sightexports.sVehiclenames:getCustomVehicleName(paintshopWorks[currentWorkingCar].model))
			local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - 8 - 32 - 8 - titleBarHeight, carPrompt)
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			sightexports.sGui:setLabelText(label, "Biztosan átlépsz a következő munkafolyamatra?\nFigyelem! Később nem léphetsz vissza!" .. (sandingSkip and "\n\nA csiszolás átugrásának ára [color=sightgreen]" .. sightexports.sGui:thousandsStepper(math.floor(paintshopWorks[currentWorkingCar].price * 0.35)) .. " $#ffffff." or ""))
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			local w = (pw - 24) / 2
			local btn = sightexports.sGui:createGuiElement("button", 8, ph - 8 - 32, w, 32, carPrompt)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonText(btn, "Igen")
			sightexports.sGui:setClickEvent(btn, "finalNextPaintshopState")
			local btn = sightexports.sGui:createGuiElement("button", pw - w - 8, ph - 8 - 32, w, 32, carPrompt)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightred",
				"sightred-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonText(btn, "Nem")
			sightexports.sGui:setClickEvent(btn, "createPaintshopCarWindow")
		end
	end)
	function deleteCarWindow()
		loaderIcon = false
		if carWindow then
			local x, y = sightexports.sGui:getGuiPosition(carWindow)
			local sx, sy = sightexports.sGui:getGuiSize(carWindow)
			x = x + sx / 2
			y = y + sy / 2
			carWindowX, carWindowY = x, y
			sightexports.sGui:deleteGuiElement(carWindow)
		end
		if carPrompt then
			sightexports.sGui:deleteGuiElement(carPrompt)
		end
		carPrompt = false
		carWindow = false
		return x, y
	end
	function createStarRating(x, y, rating)
		for i = 1, 5 do
			local image = sightexports.sGui:createGuiElement("image", x + (i - 1) * 20, y + 16 - 12, 24, 24, carWindow)
			if i <= rating then
				sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("star", 24))
				sightexports.sGui:setImageColor(image, "sightyellow")
			elseif i <= math.ceil(rating) then
				sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("star", 24, "regular"))
				sightexports.sGui:setImageColor(image, "sightlightgrey")
				local image = sightexports.sGui:createGuiElement("image", x + (i - 1) * 20, y + 16 - 12, 24, 24, carWindow)
				sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("star-half", 24))
				sightexports.sGui:setImageColor(image, "sightyellow")
			else
				sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("star", 24, "regular"))
				sightexports.sGui:setImageColor(image, "sightlightgrey")
			end
		end
	end
	local carWindowExtended = true
	function createWorkRow(x, y, w, h, dat, qualityIndex, currentWorkState, workId, name)
		if currentWorkState == workId then
			local rect = sightexports.sGui:createGuiElement("rectangle", x, y, w, 64, carWindow)
			sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
			if dat.checking then
				loaderIcon = sightexports.sGui:createGuiElement("image", x + w / 2 - 16, y + 32 - 16, 32, 32, carWindow)
				sightexports.sGui:setImageFile(loaderIcon, sightexports.sGui:getFaIconFilename("circle-notch", 32))
				sightexports.sGui:setImageRotation(loaderIcon, getTickCount() / 5 % 360)
			end
		elseif workId < currentWorkState then
			local image = sightexports.sGui:createGuiElement("image", x + 8, y + 16 - 12, 24, 24, carWindow)
			sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("check", 24))
			sightexports.sGui:setImageColor(image, "sightgreen")
		end
		if dat.checking and currentWorkState == workId then
			y = y + 32 + 32
			if carWindowExtended then
				local border = sightexports.sGui:createGuiElement("hr", x, y - 1, w, 2, carWindow)
			end
		else
			local iw = workId < currentWorkState and 28 or 0
			local label = sightexports.sGui:createGuiElement("label", x + 8 + iw, y, w, 32, carWindow)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, name)
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			if 0 <= dat[qualityIndex .. "Quality"] then
				if currentWorkState == workId then
					local rating = math.ceil((dat.lastPercent - 94) / 4 * 5 * 2) / 2
					createStarRating(x + w - 100 - 8, y, rating)
				else
					createStarRating(x + w - 100 - 8, y, dat[qualityIndex .. "Quality"])
				end
			end
			y = y + 32
			if currentWorkState == workId then
				local perc = math.min(1, dat.lastPercent / 94)
				local pw = w - 16 - 32
				if 1 <= perc then
					pw = pw - 32
					local btn = sightexports.sGui:createGuiElement("button", x + w - 8 - 24, y + 16 - 12, 24, 24, carWindow)
					sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
					sightexports.sGui:setGuiHover(btn, "gradient", {
						"sightgreen",
						"sightgreen-second"
					}, false, true)
					sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
					sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("arrow-right", 24))
					sightexports.sGui:setClickEvent(btn, "tryToNextPaintshopState")
					sightexports.sGui:guiSetTooltip(btn, "Következő munkafolyamat")
				elseif qualityIndex == "sanding" then
					pw = pw - 32
					local btn = sightexports.sGui:createGuiElement("button", x + w - 8 - 24, y + 16 - 12, 24, 24, carWindow)
					sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
					sightexports.sGui:setGuiHover(btn, "gradient", {
						"sightgreen",
						"sightgreen-second"
					}, false, true)
					sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
					sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("forward", 24))
					sightexports.sGui:setClickEvent(btn, "tryToNextPaintshopState")
					sightexports.sGui:guiSetTooltip(btn, "Csiszolás átugrása (" .. sightexports.sGui:thousandsStepper(math.floor(dat.price * 0.35)) .. " $)")
				end
				local btn = sightexports.sGui:createGuiElement("button", x + 8 + pw + 8, y + 16 - 12, 24, 24, carWindow)
				sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
				sightexports.sGui:setGuiHover(btn, "gradient", {
					"sightblue",
					"sightblue-second"
				}, false, true)
				sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
				sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("sync", 24))
				sightexports.sGui:setClickEvent(btn, "checkPaintshopProgress")
				sightexports.sGui:guiSetTooltip(btn, "Állapot frissítése")
				local rect = sightexports.sGui:createGuiElement("rectangle", x + 8, y + 16 - 5, pw, 10, carWindow)
				sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey2")
				sightexports.sGui:setGuiHover(rect, "none", false, false, true)
				sightexports.sGui:setGuiHoverable(rect, true)
				sightexports.sGui:guiSetTooltip(rect, math.floor(perc * 1000) / 10 .. "%")
				local rect = sightexports.sGui:createGuiElement("rectangle", x + 8, y + 16 - 5, pw * perc, 10, carWindow)
				sightexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
				y = y + 32
			end
			local border = carWindowExtended and sightexports.sGui:createGuiElement("hr", x, y - 1, w, 2, carWindow)
		end
		return y
	end
	addEvent("togglePaintshopCarWindowExtend", false)
	addEventHandler("togglePaintshopCarWindowExtend", getRootElement(), function()
		carWindowExtended = not carWindowExtended
		createCarWindow()
	end)
	function createCarWindow()
		deleteCarWindow()
		local dat = currentWorkingCar and paintshopWorks[currentWorkingCar]
		if dat and not isLoading() and not bigLoader then
			local currentWorkState = 1
			for i = 1, #workStateFlow do
				if dat.state == workStateFlow[i] then
					currentWorkState = i
					break
				end
			end
			carWindow = false
			local titleBarHeight = sightexports.sGui:getTitleBarHeight()
			local pw = carWindowExtended and 600 or 450
			local ph = titleBarHeight + 256
			if not carWindowExtended then
				ph = titleBarHeight + 64
			elseif 1 < currentWorkState and currentWorkState < 8 and currentWorkState ~= 5 then
				ph = ph + 32
			end
			if carWindowX and carWindowX + pw / 2 > screenX then
				carWindowX = screenX - pw / 2
			end
			if carWindowY and carWindowY + ph / 2 > screenY then
				carWindowY = screenY - ph / 2
			end
			if carWindowX and carWindowX < pw / 2 then
				carWindowX = pw / 2
			end
			if carWindowY and carWindowY < ph / 2 then
				carWindowY = ph / 2
			end
			carWindow = sightexports.sGui:createGuiElement("window", (carWindowX or screenX - pw / 2 - 12) - pw / 2, (carWindowY or screenY - ph / 2 - 12) - ph / 2, pw, ph)
			sightexports.sGui:setWindowTitle(carWindow, "16/BebasNeueRegular.otf", sightexports.sVehiclenames:getCustomVehicleName(dat.model))
			local image = sightexports.sGui:createGuiElement("image", pw - titleBarHeight, 0, titleBarHeight, titleBarHeight, carWindow)
			sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("angle-up", titleBarHeight))
			sightexports.sGui:setGuiHoverable(image, true)
			sightexports.sGui:setImageRotation(image, carWindowExtended and 0 or 180)
			sightexports.sGui:setGuiHover(image, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(image, "togglePaintshopCarWindowExtend")
			local border = sightexports.sGui:createGuiElement("hr", pw / 3 - 1, titleBarHeight, 2, ph - titleBarHeight, carWindow)
			local x = 0
			local y = titleBarHeight
			local col = {
				hexToRGB(dat.color)
			}
			local rect = sightexports.sGui:createGuiElement("rectangle", x + 8, y + 8, 48, 48, carWindow)
			sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
			local rect = sightexports.sGui:createGuiElement("rectangle", 2, 2, 44, 44, rect)
			sightexports.sGui:setGuiBackground(rect, "solid", col)
			col[1] = math.min(255, col[1] * 1.1)
			col[2] = math.min(255, col[2] * 1.1)
			col[3] = math.min(255, col[3] * 1.1)
			local shine = sightexports.sGui:createGuiElement("image", 0, 0, 44, 44, rect)
			sightexports.sGui:setImageFile(shine, ":sPaintshop/files/shine.dds")
			sightexports.sGui:setImageColor(shine, col)
			local label = sightexports.sGui:createGuiElement("label", x + 8 + 48 + 8, y + 8, 0, 24, carWindow)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, validColorNames[dat.color])
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			local label = sightexports.sGui:createGuiElement("label", x + 8 + 48 + 8, y + 8 + 24, 0, 24, carWindow)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, "Metál: " .. (dat.metal and "igen" or "nem"))
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
			if carWindowExtended then
				local label = sightexports.sGui:createGuiElement("label", x + 8, y + 8 + 48 + 8, 0, 24, carWindow)
				sightexports.sGui:setLabelAlignment(label, "left", "top")
				sightexports.sGui:setLabelText(label, "Elemek:")
				sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
				local fh = math.ceil(sightexports.sGui:getFontHeight("11/Ubuntu-L.ttf")) + 1
				for i = 1, #dat.partNames do
					local label = sightexports.sGui:createGuiElement("label", x + 8, y + 8 + 48 + 8 + 24 + fh * (i - 1), 0, 24, carWindow)
					sightexports.sGui:setLabelAlignment(label, "left", "top")
					sightexports.sGui:setLabelText(label, "\226\128\162 " .. dat.partNames[i])
					sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
				end
			end
			x = pw / 3
			local w = pw - x
			if dat.stateSwitching then
				loaderIcon = sightexports.sGui:createGuiElement("image", x + w / 2 - 24, y + (ph - titleBarHeight) / 2 - 24, 48, 48, carWindow)
				sightexports.sGui:setImageFile(loaderIcon, sightexports.sGui:getFaIconFilename("circle-notch", 48))
				sightexports.sGui:setImageRotation(loaderIcon, getTickCount() / 5 % 360)
			else
				if carWindowExtended or currentWorkState == 1 then
					local h = carWindowExtended and 32 or 64
					if currentWorkState == 1 then
						local rect = sightexports.sGui:createGuiElement("rectangle", x, y, w, h, carWindow)
						sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
					elseif 1 < currentWorkState then
						local image = sightexports.sGui:createGuiElement("image", x + 8, y + h / 2 - 12, 24, 24, carWindow)
						sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("check", 24))
						sightexports.sGui:setImageColor(image, "sightgreen")
					end
					local iw = 1 < currentWorkState and 28 or 0
					local label = sightexports.sGui:createGuiElement("label", x + 8 + iw, y, w, h, carWindow)
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					sightexports.sGui:setLabelText(label, "Szállítás a műhelybe")
					sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
					y = y + h
					if carWindowExtended then
						local border = sightexports.sGui:createGuiElement("hr", x, y - 1, w, 2, carWindow)
					end
				end
				if carWindowExtended or currentWorkState == 2 then
					y = createWorkRow(x, y, w, h, dat, "sanding", currentWorkState, 2, "Csiszolás")
				end
				if carWindowExtended or currentWorkState == 3 then
					y = createWorkRow(x, y, w, h, dat, "primer", currentWorkState, 3, "Alapozás")
				end
				if carWindowExtended or currentWorkState == 4 then
					if currentWorkState == 4 then
						local rect = sightexports.sGui:createGuiElement("rectangle", x, y, w, 64, carWindow)
						sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
					elseif 4 < currentWorkState then
						local image = sightexports.sGui:createGuiElement("image", x + 8, y + 16 - 12, 24, 24, carWindow)
						sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("check", 24))
						sightexports.sGui:setImageColor(image, "sightgreen")
					end
					local iw = 4 < currentWorkState and 28 or 0
					local label = sightexports.sGui:createGuiElement("label", x + 8 + iw, y, w, 32, carWindow)
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					sightexports.sGui:setLabelText(label, "Szárítás")
					sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
					y = y + 32
					if currentWorkState == 4 then
						local perc = 0
						if dat.dryingState then
							perc = math.min(1, dat.dryingProgress + (getTickCount() - dat.dryingStart) / 900000)
						else
							perc = math.min(1, dat.dryingProgress)
						end
						local pw = w - 16 - 32
						if 1 <= perc then
							pw = pw - 32
							local btn = sightexports.sGui:createGuiElement("button", x + w - 8 - 24, y + 16 - 12, 24, 24, carWindow)
							sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
							sightexports.sGui:setGuiHover(btn, "gradient", {
								"sightgreen",
								"sightgreen-second"
							}, false, true)
							sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
							sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("arrow-right", 24))
							sightexports.sGui:setClickEvent(btn, "tryToNextPaintshopState")
							sightexports.sGui:guiSetTooltip(btn, "Következő munkafolyamat")
						end
						local btn = sightexports.sGui:createGuiElement("button", x + 8 + pw + 8, y + 16 - 12, 24, 24, carWindow)
						sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
						sightexports.sGui:setGuiHover(btn, "gradient", {
							"sightblue",
							"sightblue-second"
						}, false, true)
						sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
						sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("sync", 24))
						sightexports.sGui:setClickEvent(btn, "createPaintshopCarWindow")
						sightexports.sGui:guiSetTooltip(btn, "Állapot frissítése")
						local rect = sightexports.sGui:createGuiElement("rectangle", x + 8, y + 16 - 5, pw, 10, carWindow)
						sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey2")
						sightexports.sGui:setGuiHover(rect, "none", false, false, true)
						sightexports.sGui:setGuiHoverable(rect, true)
						sightexports.sGui:guiSetTooltip(rect, math.floor(perc * 1000) / 10 .. "%")
						local rect = sightexports.sGui:createGuiElement("rectangle", x + 8, y + 16 - 5, pw * perc, 10, carWindow)
						sightexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
						y = y + 32
					end
					if carWindowExtended then
						local border = sightexports.sGui:createGuiElement("hr", x, y - 1, w, 2, carWindow)
					end
				end
				if carWindowExtended or currentWorkState == 5 then
					local h = carWindowExtended and 32 or 64
					if currentWorkState == 5 then
						local rect = sightexports.sGui:createGuiElement("rectangle", x, y, w, h, carWindow)
						sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
					elseif 5 < currentWorkState then
						local image = sightexports.sGui:createGuiElement("image", x + 8, y + h / 2 - 12, 24, 24, carWindow)
						sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("check", 24))
						sightexports.sGui:setImageColor(image, "sightgreen")
					end
					local iw = 5 < currentWorkState and 28 or 0
					local label = sightexports.sGui:createGuiElement("label", x + 8 + iw, y, w, h, carWindow)
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					sightexports.sGui:setLabelText(label, "Műhely")
					sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
					if currentWorkState == 5 then
						local btn = sightexports.sGui:createGuiElement("button", x + w - 8 - 24, y + h / 2 - 12, 24, 24, carWindow)
						sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
						sightexports.sGui:setGuiHover(btn, "gradient", {
							"sightgreen",
							"sightgreen-second"
						}, false, true)
						sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
						sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("arrow-right", 24))
						sightexports.sGui:setClickEvent(btn, "tryToNextPaintshopState")
						sightexports.sGui:guiSetTooltip(btn, "Következő munkafolyamat")
					end
					y = y + h
					if carWindowExtended then
						local border = sightexports.sGui:createGuiElement("hr", x, y - 1, w, 2, carWindow)
					end
				end
				if carWindowExtended or currentWorkState == 6 then
					y = createWorkRow(x, y, w, h, dat, "paint", currentWorkState, 6, "Fényezés")
				end
				if carWindowExtended or currentWorkState == 7 then
					if currentWorkState == 7 then
						local rect = sightexports.sGui:createGuiElement("rectangle", x, y, w, 64, carWindow)
						sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
					elseif 7 < currentWorkState then
						local image = sightexports.sGui:createGuiElement("image", x + 8, y + 16 - 12, 24, 24, carWindow)
						sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("check", 24))
						sightexports.sGui:setImageColor(image, "sightgreen")
					end
					local iw = 7 < currentWorkState and 28 or 0
					local label = sightexports.sGui:createGuiElement("label", x + 8 + iw, y, w, 32, carWindow)
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					sightexports.sGui:setLabelText(label, "Szárítás")
					sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
					y = y + 32
					if currentWorkState == 7 then
						local perc = 0
						if dat.dryingState then
							perc = math.min(1, dat.dryingProgress + (getTickCount() - dat.dryingStart) / 1200000)
						else
							perc = math.min(1, dat.dryingProgress)
						end
						local pw = w - 16 - 32
						if 1 <= perc then
							pw = pw - 32
							local btn = sightexports.sGui:createGuiElement("button", x + w - 8 - 24, y + 16 - 12, 24, 24, carWindow)
							sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
							sightexports.sGui:setGuiHover(btn, "gradient", {
								"sightgreen",
								"sightgreen-second"
							}, false, true)
							sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
							sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("arrow-right", 24))
							sightexports.sGui:setClickEvent(btn, "tryToNextPaintshopState")
							sightexports.sGui:guiSetTooltip(btn, "Következő munkafolyamat")
						end
						local btn = sightexports.sGui:createGuiElement("button", x + 8 + pw + 8, y + 16 - 12, 24, 24, carWindow)
						sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
						sightexports.sGui:setGuiHover(btn, "gradient", {
							"sightblue",
							"sightblue-second"
						}, false, true)
						sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
						sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("sync", 24))
						sightexports.sGui:setClickEvent(btn, "createPaintshopCarWindow")
						sightexports.sGui:guiSetTooltip(btn, "Állapot frissítése")
						local rect = sightexports.sGui:createGuiElement("rectangle", x + 8, y + 16 - 5, pw, 10, carWindow)
						sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey2")
						sightexports.sGui:setGuiHover(rect, "none", false, false, true)
						sightexports.sGui:setGuiHoverable(rect, true)
						sightexports.sGui:guiSetTooltip(rect, math.floor(perc * 1000) / 10 .. "%")
						local rect = sightexports.sGui:createGuiElement("rectangle", x + 8, y + 16 - 5, pw * perc, 10, carWindow)
						sightexports.sGui:setGuiBackground(rect, "solid", "sightgreen")
						y = y + 32
					end
					if carWindowExtended then
						local border = sightexports.sGui:createGuiElement("hr", x, y - 1, w, 2, carWindow)
					end
				end
				if carWindowExtended or currentWorkState == 8 then
					local h = carWindowExtended and 32 or 64
					if currentWorkState == 8 then
						local rect = sightexports.sGui:createGuiElement("rectangle", x, y, w, h, carWindow)
						sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
					elseif 8 < currentWorkState then
						local image = sightexports.sGui:createGuiElement("image", x + 8, y + h / 2 - 12, 24, 24, carWindow)
						sightexports.sGui:setImageFile(image, sightexports.sGui:getFaIconFilename("check", 24))
						sightexports.sGui:setImageColor(image, "sightgreen")
					end
					local iw = 8 < currentWorkState and 28 or 0
					local label = sightexports.sGui:createGuiElement("label", x + 8 + iw, y, w, h, carWindow)
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					sightexports.sGui:setLabelText(label, "Leszállítás az ügyfélnek")
					sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
					y = y + h
				end
			end
		end
	end
	addEvent("createPaintshopCarWindow", false)
	addEventHandler("createPaintshopCarWindow", getRootElement(), createCarWindow)
	local paintshopCache = {}
	function getPaintshopCache()
		return paintshopCache
	end
	addEvent("gotPaintshops", true)
	addEventHandler("gotPaintshops", root, function(dat)
		paintshopCache = dat
	end)
	addEvent("refreshPaintshops", true)
	addEventHandler("refreshPaintshops", root, function(dat)
		for i = #paintshopCache, 1, -1 do
			if paintshopCache[i].type == "workshop" then
				table.remove(paintshopCache, i)
			end
		end
		for i = 1, #dat do
			table.insert(paintshopCache, 1, dat[i])
		end
	end)
	addEvent("refreshGarages", true)
	addEventHandler("refreshGarages", root, function(dat)
		for i = #paintshopCache, 1, -1 do
			if paintshopCache[i].type == "garage" then
				table.remove(paintshopCache, i)
			end
		end
		for i = 1, #dat do
			table.insert(paintshopCache, dat[i])
		end
	end)
	if getElementData(localPlayer, "loggedIn") then
		triggerServerEvent("requestPaintshops", localPlayer)
	end
	addEventHandler("onClientElementDataChange", localPlayer, function(dataName, oldValue, newValue)
		if dataName == "loggedIn" and newValue then
			triggerServerEvent("requestPaintshops", localPlayer)
		end
	end)
