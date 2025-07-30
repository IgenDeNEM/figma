local sightexports = {
	sCustompj = false,
	sGui = false,
	sSpeedo = false,
	sVehicles = false,
	sPaintjob = false,
	sBackfire = false,
	sCustomhorn = false,
	sSpinner = false,
	sNeon = false,
	sModloader = false,
	sHud = false,
	sControls = false,
	sWeather = false,
	sMarkers = false,
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
		sightlangStaticImage[0] = dxCreateTexture("files/pp.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/icons/wrench.dds", "argb", true)
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
		local res0 = getResourceFromName("sMarkers")
		if res0 and getResourceState(res0) == "running" then
			markersReady()
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
local streamerMode = false
local sightlangModloaderLoaded = function()
	loadModelIds()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
streamerMode = true
if sightexports.sDashboard then
	local val = sightexports.sDashboard:getStreamerMode()
	streamerMode = val
end
addEventHandler("streamerModeChanged", getRootElement(), function(val)
	streamerMode = val
end)
local screenX, screenY = guiGetScreenSize()
local tuningState = false
local isGratisPJ = false
local inPjEditorMode = false
local shaderSource = " texture secondRT < string renderTarget = \"yes\"; >; texture gTexture0 < string textureState=\"0,Texture\"; >; sampler Sampler0 = sampler_state { Texture = (gTexture0); }; struct PSInput { float4 Position : POSITION0; float4 Diffuse : COLOR0; float2 TexCoord0 : TEXCOORD0; }; struct Pixel { float4 Color : COLOR0; float4 Extra : COLOR1; }; float outlineP = 0; float outlineR = 0; float outlineG = 0; float outlineB = 0; Pixel PixelShaderFunction(PSInput PS) { Pixel output; float4 texel = tex2D(Sampler0, PS.TexCoord0); float4 finalColor = texel * PS.Diffuse; output.Extra = saturate(finalColor); if(output.Extra.a > 0.1) { if(output.Extra.a < 0.5) { output.Extra.r = output.Extra.r + (outlineR - output.Extra.r)*outlineP; output.Extra.g = output.Extra.g + (outlineG - output.Extra.g)*outlineP; output.Extra.b = output.Extra.b + (outlineB - output.Extra.b)*outlineP; output.Extra.a = 1; } output.Color = float4(0, 0, 0, 1); } else { output.Color = float4(0, 0, 0, 0); output.Extra = float4(0, 0, 0, 0); } return output; } technique fx_pre_object_MRT { pass P0 { AlphaBlendEnable = true; AlphaRef = 1; SeparateAlphaBlendEnable = true; SrcBlendAlpha = SrcAlpha; DestBlendAlpha = One; PixelShader = compile ps_2_0 PixelShaderFunction(); } } technique fallback { pass P0 { } } "
local w = math.max(256, math.floor(screenX * 0.15))
local h = 0
local objectModels = {}
local activeMenu = false
local menuInterpolation = false
local menus = false
local previousMenus = false
local previousTitles = false
local previousActive = false
local currentTitle = false
local currentMenu = false
local closingInterpolation = false
local openingInterpolation = false
local valueScroll = false
local valueScrollH = false
local activeValue = false
local equippedValue = false
local values = false
local maximumValueNum = false
local valueInterpolation = false
local valueOpenInterpolation = false
local valueCloseInterpolation = false
local playerIsController = false
local wsX, wsY, wsZ = false, nil, nil
local vehZ = 0
local veh = false
local vehType = false
addEvent("finalPaintjobEditorExit", true)
addEventHandler("finalPaintjobEditorExit", getRootElement(), function()
	if inPjEditorMode then
		triggerServerEvent("previewTuningServer", localPlayer, "color", "reset")
		inPjEditorMode = false
		sightexports.sCustompj:stopPaintjobEditor()
	end
end)
local tuningIntro = false
local nightTime = false
local endNightTime = false
local nightShader = false
local nightSource = false
local menuOpen = false
local overrideIntroP = false
local introSpeed = false
local lastP = false
local cameraTarget = false
local cameraTargetInterpolation = false
local currentCamera = false
local cameraInterpolation = false
local buyingTuning = false
local buyPromptAnimation = false
local buyPrompt = false
local buyPromptValue = false
local colorPickerMode = false
local colorPickerR, colorPickerG, colorPickerB = 255, 255, 255
local textInputValue = ""
local adjustingInterpolation = false
local adjustingValue = false
local adjustableValues = false
local valueScrollSpeed = false
local selectedAdjustValue = false
local lastBackfireTest = false
local shader = false
local vehicleObjects = {}
local currentObjectState = false
local renderTarget = false
local faTicks = false
local yesIcon = false
local noIcon = false
local cashIcon = false
local ppIcon = false
local arrowIcon = false
local exitingTuning = false
local workshopObjects = {}
local colors = {}
local fonts = {}
function initColorsAndFonts()
	colors.blue = sightexports.sGui:getColorCode("sightblue")
	colors.green = sightexports.sGui:getColorCode("sightgreen")
	colors.yellow = sightexports.sGui:getColorCode("sightyellow")
	colors.purple = sightexports.sGui:getColorCode("sightpurple")
	colors.red = sightexports.sGui:getColorCode("sightred")
	colors.grey1 = sightexports.sGui:getColorCode("sightgrey1")
	colors.grey2 = sightexports.sGui:getColorCode("sightgrey2")
	colors.grey3 = sightexports.sGui:getColorCode("sightgrey3")
	colors.lightgrey = sightexports.sGui:getColorCode("sightlightgrey")
	fonts.headerFont = sightexports.sGui:getFont("17/BebasNeueBold.otf")
	fonts.headerFontScale = sightexports.sGui:getFontScale("17/BebasNeueBold.otf")
	fonts.header2Font = sightexports.sGui:getFont("17/BebasNeueRegular.otf")
	fonts.header2FontScale = sightexports.sGui:getFontScale("17/BebasNeueRegular.otf")
	fonts.keyFont = sightexports.sGui:getFont("14/BebasNeueRegular.otf")
	fonts.keyFontScale = sightexports.sGui:getFontScale("14/BebasNeueRegular.otf")
	fonts.valueFont = sightexports.sGui:getFont("11/Ubuntu-L.ttf")
	fonts.valueFontScale = sightexports.sGui:getFontScale("11/Ubuntu-L.ttf")
	fonts.valueFontH = math.ceil(sightexports.sGui:getFontHeight("11/Ubuntu-L.ttf"))
	fonts.value2Font = sightexports.sGui:getFont("11/Ubuntu-R.ttf")
	fonts.value2FontScale = sightexports.sGui:getFontScale("11/Ubuntu-R.ttf")
	fonts.value2FontH = math.ceil(sightexports.sGui:getFontHeight("11/Ubuntu-R.ttf"))
end
local tuningMusic = false
local tuningMusicMuted = false
local tuningAmbient1 = false
local tuningAmbient2 = false
function destroyTuning()
	tuningMusicMuted = false
	showCursor(false)
	sightexports.sSpeedo:toggleTuningState(false)
	deleteScenario()
	lsdPreview = false
	deleteColorPicker()
	deleteTextInput()
	if inPjEditorMode then
		sightexports.sCustompj:stopPaintjobEditor()
	end
	inPjEditorMode = false
	if isElement(veh) then
		local occupants = getVehicleOccupants(veh)
		for k, v in pairs(occupants) do
			setElementAlpha(v, 255)
		end
	end
	setElementAlpha(localPlayer, 255)
	veh = false
	playerIsController = false
	if isElement(tuningMusic) then
		destroyElement(tuningMusic)
	end
	tuningMusic = nil
	if isElement(tuningAmbient1) then
		destroyElement(tuningAmbient1)
	end
	tuningAmbient1 = nil
	if isElement(tuningAmbient2) then
		destroyElement(tuningAmbient2)
	end
	tuningAmbient2 = nil
	if isElement(nightSource) then
		destroyElement(nightSource)
	end
	nightSource = nil
	if isElement(nightShader) then
		destroyElement(nightShader)
	end
	nightShader = nil
	for i in pairs(workshopObjects) do
		if isElement(workshopObjects[i]) then
			destroyElement(workshopObjects[i])
		end
	end
	workshopObjects = {}
	for i in pairs(vehicleObjects) do
		if isElement(vehicleObjects[i]) then
			destroyElement(vehicleObjects[i])
		end
	end
	vehicleObjects = {}
	if isElement(shader) then
		destroyElement(shader)
	end
	shader = false
	if isElement(renderTarget) then
		destroyElement(renderTarget)
	end
	renderTarget = false
	cameraInterpolation = false
	buyingTuning = false
	buyPromptAnimation = false
	buyPrompt = false
	deleteTuningCustomPrompt()
	buyPromptValue = true
	adjustingInterpolation = false
	adjustingValue = false
	adjustableValues = false
	valueScrollSpeed = false
	selectedAdjustValue = false
	sightexports.sVehicles:resetPreviewSuperchargers()
end
local currentVehMode = false
local movieShaderSource = " texture sBaseTexture; float Brightness; float Contrast; sampler Samp = sampler_state { Texture = (sBaseTexture); AddressU = MIRROR; AddressV = MIRROR; }; float4 PixelShaderFunction(float2 uv : TEXCOORD) : COLOR { float4 outputColor = tex2D(Samp, uv); outputColor.rgb = (outputColor.rgb - 0.5) * (Contrast + 1.0) + 0.5; outputColor.rgb = outputColor.rgb + Brightness; return outputColor; } technique movie { pass P0 { PixelShader = compile ps_2_0 PixelShaderFunction(); } } technique fallback { pass P0 { } } "
local camX = false
local camY = false
local desiredCamZoom = false
local camZoom = false
local camCursor = false
local freeCamMode = false
local freecamInterpolation = false
local minX, minY, minZ, maxX, maxY, maxZ = false, nil, nil, nil, nil, nil
function resetVars()
	currentTitle = "SightMTA Tuning"
	currentMenu = false
	closingInterpolation = false
	openingInterpolation = false
	valueScroll = false
	valueScrollH = false
	activeValue = false
	equippedValue = false
	values = false
	maximumValueNum = 8
	valueInterpolation = false
	valueOpenInterpolation = false
	valueCloseInterpolation = false
	tuningIntro = getTickCount()
	nightTime = true
	menuOpen = false
	camX = 0.5
	camY = 0
	desiredCamZoom = 1.75
	camZoom = 1.75
	camCursor = false
	freeCamMode = false
	freecamInterpolation = false
end
function initTuning(cont)
	destroyTuning()
	sightexports.sSpeedo:toggleTuningState(true)
	endNightTime = false
	veh = getPedOccupiedVehicle(localPlayer)
	playerIsController = cont
	if cont then
		setElementPosition(veh, 1.71875, 40.40625, 1200.902734375)
	end
	if not wsX and not wsY and not wsZ then
		wsX, wsY, wsZ = getElementPosition(localPlayer)
	end
	vehZ = wsZ + getElementDistanceFromCentreOfMassToBaseOfModel(veh)
	local dim = getElementDimension(localPlayer)
	local int = 1
	tuningAmbient1 = playSound3D("files/ambient1.mp3", 12.62109375, 30.826171875, 1201.34375, true)
	setSoundVolume(tuningAmbient1, 0.5)
	setSoundMaxDistance(tuningAmbient1, 150)
	setSoundEffectEnabled(tuningAmbient1, "i3dl2reverb", true)
	setElementDimension(tuningAmbient1, dim)
	setElementInterior(tuningAmbient1, int)
	setSoundPosition(tuningAmbient1, math.random(getSoundLength(tuningAmbient1)))
	tuningAmbient2 = playSound3D("files/ambient2.mp3", -7.3369140625, 32.3056640625, 1201.34375, true)
	setSoundVolume(tuningAmbient2, 0.5)
	setSoundMaxDistance(tuningAmbient2, 150)
	setSoundEffectEnabled(tuningAmbient2, "i3dl2reverb", true)
	setElementDimension(tuningAmbient2, dim)
	setElementInterior(tuningAmbient2, int)
	setSoundPosition(tuningAmbient2, math.random(getSoundLength(tuningAmbient2)))
	workshopObjects[2] = createObject(objectModels.tuning_workshop_props, wsX, wsY, wsZ)
	local playerPosition = {getElementPosition(localPlayer)}
	setElementDoubleSided(workshopObjects[2], true)
	setElementDimension(workshopObjects[2], dim)
	setElementInterior(workshopObjects[2], int)
	workshopObjects[3] = createObject(objectModels.tuning_workshop_props2, wsX, wsY, wsZ)
	setElementDoubleSided(workshopObjects[3], true)
	setElementDimension(workshopObjects[3], dim)
	setElementInterior(workshopObjects[3], int)
	workshopObjects[4] = createObject(objectModels.tuning_workshop_transparents, wsX, wsY, wsZ)
	setElementDoubleSided(workshopObjects[4], true)
	setElementDimension(workshopObjects[4], dim)
	setElementInterior(workshopObjects[4], int)
	initColorsAndFonts()
	activeMenu = 1
	exitingTuning = false
	currentVehMode = false
	menuInterpolation = false
	menus = {}
	previousMenus = {}
	previousTitles = {}
	previousActive = {}
	resetVars()
	if isElement(nightSource) then
		destroyElement(nightSource)
	end
	if isElement(nightShader) then
		destroyElement(nightShader)
	end
	nightSource = dxCreateScreenSource(screenX, screenY)
	nightShader = dxCreateShader(movieShaderSource)
	dxSetShaderValue(nightShader, "sBaseTexture", nightSource)
	dxSetShaderValue(nightShader, "Brightness", 0)
	dxSetShaderValue(nightShader, "Contrast", 0.125)
	overrideIntroP = false
	introSpeed = 0
	lastP = 1
	cameraTarget = {
		wsX,
		wsY,
		wsZ
	}
	cameraTargetInterpolation = false
	currentCamera = {}
	lastBackfireTest = 0
	renderTarget = dxCreateRenderTarget(screenX, screenY, true)
	shader = dxCreateShader(shaderSource)
	dxSetShaderValue(shader, "secondRT", renderTarget)
	vehicleObjects = {}
	currentObjectState = false
	yesIcon = sightexports.sGui:getFaIconFilename("check", 32)
	noIcon = sightexports.sGui:getFaIconFilename("times", 32)
	cashIcon = sightexports.sGui:getFaIconFilename("money-bill-wave", 32)
	ppIcon = sightexports.sGui:getFaIconFilename("gem", 32, "regular")
	arrowIcon = sightexports.sGui:getFaIconFilename("arrow-up", 32)
	faTicks = sightexports.sGui:getFaTicks()
	triggerServerEvent("requestPremiumData", localPlayer)
	triggerServerEvent("requestTuningValuesFromServer", localPlayer)
end
function formatPrice(price)
	if price then
		if price[1] == "cash" then
			return sightexports.sGui:thousandsStepper(price[2]) .. " $"
		elseif price[1] == "pp" then
			return sightexports.sGui:thousandsStepper(price[2]) .. " PP"
		end
	end
	return "Ingyenes"
end
function loadCurrentMenu(menu)
	currentMenu = {}
	for i = 1, #menu do
		if menu[i] and isTuningVisible(veh, menu[i].tuningId, menu[i].menuVisibilityName) then
			table.insert(currentMenu, menu[i])
		end
	end
end
function loadTuningMenu(i)
	local animMenu = false
	if i and currentMenu and currentMenu[i] and currentMenu[i].submenus then
		table.insert(previousMenus, currentMenu)
		table.insert(previousTitles, currentTitle)
		table.insert(previousActive, activeMenu)
		currentTitle = currentMenu[i].name
		loadCurrentMenu(currentMenu[i].submenus)
		activeMenu = 1
		playSound("files/cammoveout.mp3")
		playSound("files/em.wav")
	else
		if previousMenus[#previousMenus] then
			currentMenu = previousMenus[#previousMenus]
			if previousTitles[#previousTitles] then
				currentTitle = previousTitles[#previousTitles]
			else
				currentTitle = "SightMTA Tuning"
			end
			if previousActive[#previousActive] then
				activeMenu = previousActive[#previousActive]
			else
				activeMenu = 1
			end
			animMenu = activeMenu
		else
			loadCurrentMenu(tuningMenus)
			currentTitle = "SightMTA Tuning"
			activeMenu = 1
		end
		if 0 < #previousMenus then
			table.remove(previousMenus, #previousMenus)
		end
		if 0 < #previousTitles then
			table.remove(previousTitles, #previousTitles)
		end
		if 0 < #previousActive then
			table.remove(previousActive, #previousActive)
		end
		playSound("files/cammovein.mp3")
		playSound("files/em.wav")
	end
	if playerIsController then
		triggerServerEvent("syncTuningSpectatorData", localPlayer, "title", currentTitle)
		triggerServerEvent("syncTuningSpectatorData", localPlayer, "activeMenu", currentMenu[activeMenu].icon, currentMenu[activeMenu].name)
	end
	menus = {}
	for k = 1, #currentMenu do
		local veh = getPedOccupiedVehicle(localPlayer)
		local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
		if electricVehicles[model] then
			if currentMenu[k].name == "MOTOR" then
				name = "VILLANYMOTOR"
			elseif currentMenu[k].name == "TURBO" then
				name = "AKKUMULÁTOR"
			elseif currentMenu[k].name == "VÁLTÓ" then
				name = "INVERTER"
			else
				name = currentMenu[k].name
			end
		else
			name = currentMenu[k].name
		end
		table.insert(menus, {
			currentMenu[k].icon,
			name
		})
	end
	if currentMenu[activeMenu] and currentMenu[activeMenu].camera and (not currentMenu[activeMenu].keepDefaultOnOthers or vehType == "Automobile") then
		setCamera(currentMenu[activeMenu].camera, 750)
	else
		setCamera(defaultCamera, 750)
	end
	if currentMenu[activeMenu] and currentMenu[activeMenu].cameraTarget and (not currentMenu[activeMenu].keepDefaultOnOthers or vehType == "Automobile") then
		setCamTarget(currentMenu[activeMenu].cameraTarget, 750)
	else
		setCamTarget(false, 750)
	end
	if currentMenu[activeMenu] and currentMenu[activeMenu].vehicleMode and (not currentMenu[activeMenu].keepDefaultOnOthers or vehType == "Automobile") then
		setVehicleMode(currentMenu[activeMenu].vehicleMode)
	else
		setVehicleMode(false)
	end
	if currentMenu[activeMenu] and currentMenu[activeMenu].outlineObjects and (not currentMenu[activeMenu].keepDefaultOnOthers or vehType == "Automobile") then
		setOutlineObjects(currentMenu[activeMenu].outlineObjects)
	else
		setOutlineObjects(false)
	end
	openingInterpolation = {
		getTickCount(),
		h,
		48 * (1 + #menus),
		animMenu
	}
end
local valuesFromServer = {}
function getTuningValue(v, name)
	if v == veh then
		return valuesFromServer[name]
	end
end
function refreshServerValue(name)
	if currentMenu and currentMenu[activeMenu] and name == currentMenu[activeMenu].tuningId and values then
		local val = valuesFromServer[name]
		local tmp = false
		for i = 1, #values do
			if values[i][5] == val then
				tmp = i
			end
		end
		if tmp ~= equippedValue then
			equippedValue = tmp
			if playerIsController then
				triggerServerEvent("syncTuningSpectatorData", localPlayer, "value", values[activeValue], activeValue == equippedValue)
			end
		end
	end
end
addEvent("gotTuningValuesFromServer", true)
addEventHandler("gotTuningValuesFromServer", getRootElement(), function(veh, tmp)
	if veh and getPedOccupiedVehicle(localPlayer) == veh then
		for i = 1, #tmp do
			if tmp[i] and tmp[i][1] and tmp[i][2] then
				valuesFromServer[tmp[i][1]] = tmp[i][2]
			end
			refreshServerValue(tmp[i][1])
		end
	end
end)
function getDynamicValues(tuningId)
	if tuningId == "variant" then
		local tmp = {}
		table.insert(tmp, {
			icon = "variant",
			name = "Nincs",
			value = 0
		})
		local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
		local c = 0
		for i = 1, 6 do
			if not checkDisabledVariant(model, i) then
				c = c + 1
				table.insert(tmp, {
					icon = "variant",
					name = c .. ". variáns",
					value = i
				})
			end
		end
		return tmp
	elseif tuningId == "paintjob" then
		local tmp = {}
		table.insert(tmp, {
			icon = "fenyezes",
			name = "Nincsen paintjob",
			value = false
		})
		local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
		if sightexports.sCustompj:getCustomPjTextureName(model) then
			if isGratisPJ then
				sightexports.sGui:showInfobox("i", "Mivel az előző verzióban volt paintjob ezen a járművön, így egyszer ingyen használhatod az egyedi paintjobot.")
				tuningPrices.paintjob.custom = false
			else
				tuningPrices.paintjob.custom = {
					"pp",
					sightexports.sCustompj:getCustomPjPrice()
				}
			end
			table.insert(tmp, {
				icon = "fenyezes",
				name = "Egyedi paintjob",
				canBuyAgain = true,
				value = true,
				purple = true
			})
		end
		return tmp
	elseif tuningId == "wheelPaintjob" then
		local tmp = {}
		table.insert(tmp, {
		icon = "felni",
		name = "Nincsen paintjob",
		value = false
		})
		local model = false
		local wheelTuning = getVehicleUpgradeOnSlot(veh, 12)
		if 0 < wheelTuning then
		model = wheelTuning
		else
		model = getElementModel(veh)
		end
		local c = sightexports.sPaintjob:getWheelPaintJobCount(model)
		if c then
		for i = 1, c do
			table.insert(tmp, {
			icon = "felni",
			name = "Paintjob #" .. i,
			value = i,
			blue = true
			})
		end
		end
		return tmp
	elseif tuningId == "headlightPaintjob" then
		local tmp = {}
		table.insert(tmp, {
			icon = "izzo",
			name = "Nincsen paintjob",
			value = false
		})
		local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
		local c = sightexports.sPaintjob:getHeadlightPaintJobCount(model)
		if c then
			for i = 1, c do
				table.insert(tmp, {
					icon = "izzo",
					name = "Paintjob #" .. i,
					value = i,
					blue = true
				})
			end
		end
		return tmp
	else
		return {}
	end
end
function loadValues()
	values = {}
	equippedValue = false
	local val = currentMenu[activeMenu].tuningId and valuesFromServer[currentMenu[activeMenu].tuningId]
	local gotNotFit = false
	if currentMenu[activeMenu].dynamicValues then
		currentMenu[activeMenu].values = getDynamicValues(currentMenu[activeMenu].tuningId)
	end
	for i = 1, #currentMenu[activeMenu].values do
		if canTuningFitted(veh, currentMenu[activeMenu].tuningId, currentMenu[activeMenu].values[i].value) then
			local veh = getPedOccupiedVehicle(localPlayer)
			local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
			if electricVehicles[model] then
				if utf8.find(currentMenu[activeMenu].values[i].name, "motor") then
					name = pregReplace(currentMenu[activeMenu].values[i].name, "motor", "villanymotor")
				elseif utf8.find(currentMenu[activeMenu].values[i].name, "váltó") then
					name = pregReplace(currentMenu[activeMenu].values[i].name, "váltó", "inverter")
				elseif utf8.find(currentMenu[activeMenu].values[i].name, "turbo") then
					name = pregReplace(currentMenu[activeMenu].values[i].name, "turbo", "akkumulátor")
				else
					name = currentMenu[activeMenu].values[i].name
				end
			else
				name = currentMenu[activeMenu].values[i].name
			end
			if name ~= "Egyedi Venom akkumulátor" then
				table.insert(values, {
					currentMenu[activeMenu].values[i].icon,
					name,
					formatPrice(getTuningPrice(currentMenu[activeMenu].tuningId, currentMenu[activeMenu].values[i].value, veh)),
					(not currentMenu[activeMenu].values[i].blue or not "blue") and currentMenu[activeMenu].values[i].purple and "purple",
					currentMenu[activeMenu].values[i].value,
					currentMenu[activeMenu].values[i].adjustables,
					currentMenu[activeMenu].values[i].canBuyAgain
				})
			end
			if currentMenu[activeMenu].values[i].value == val then
				equippedValue = #values
			end
		else
			gotNotFit = true
		end
	end
	if gotNotFit and currentMenu[activeMenu].notFitWarning then
		sightexports.sGui:showInfobox("w", currentMenu[activeMenu].notFitWarning)
	end
	if #values <= 0 then
		return false
	end
	local delta = screenY * 0.85 - (24 + 48 * activeMenu)
	maximumValueNum = math.min(8, math.max(2, math.floor(delta / 48)))
	if #values > maximumValueNum then
		valueScrollH = 48 * maximumValueNum / (#values - maximumValueNum + 1)
	end
	valueScroll = 0
	activeValue = 1
	if playerIsController then
		triggerServerEvent("syncTuningSpectatorData", localPlayer, "value", values[activeValue], activeValue == equippedValue)
		if currentMenu[activeMenu].serverPreview then
			triggerServerEvent("previewTuningServer", localPlayer, currentMenu[activeMenu].tuningId, values[activeValue][5])
		elseif currentMenu[activeMenu].clientPreview then
			clientPreviewTuning(currentMenu[activeMenu].tuningId, values[activeValue][5])
		end
	end
	return true
end
addEvent("tuningTryToBuyResponse", true)
addEventHandler("tuningTryToBuyResponse", getRootElement(), function(success)
	buyingTuning = false
	if success then
		if currentMenu[activeMenu].paintSound then
			playSound("files/paint.mp3")
		else
			playSound("files/buy.mp3")
		end
		buyPromptAnimation = {
			getTickCount(),
			4
		}
	else
		buyPromptAnimation = {
			getTickCount(),
			2
		}
	end
end)
function getAdjustableValue(name)
	for i = 1, #values[activeValue][6] do
		if values[activeValue][6][i][2] == name then
			return adjustableValues[i]
		end
	end
end
addEvent("syncTuningSpectatorAltHandler", true)
addEventHandler("syncTuningSpectatorAltHandler", getRootElement(), function(index, data)
	if source == veh and not playerIsController then
		if index == "turbo" then
			sightexports.sVehicles:previewTurboSound(veh, data[1], data[2], data[3], data[4])
		elseif index == "backfire" then
			sightexports.sBackfire:popDown(veh, bitAnd(getVehicleHandling(veh).modelFlags, 8192) == 8192, false, data[1], data[2], data[3])
		end
	end
end)
function adjustingValueAltHandler()
	if currentMenu[activeMenu].tuningId == "performance.turbo" and values[activeValue][5] == 5 then
		local id = getAdjustableValue("turbo.sound")
		local boff = getAdjustableValue("turbo.blowoff")
		local sv = getAdjustableValue("turbo.soundVolume")
		local bv = getAdjustableValue("turbo.blowoffVolume")
		sightexports.sVehicles:previewTurboSound(veh, id, boff, sv, bv)
		if playerIsController then
			triggerServerEvent("syncTuningSpectatorAltHandler", localPlayer, "turbo", {
				id,
				boff,
				sv,
				bv
			})
		end
	elseif currentMenu[activeMenu].tuningId == "backfire" and values[activeValue][5] == 2 and getTickCount() - lastBackfireTest > 0 then
		local snd = getAdjustableValue("backfire.sound")
		local spd = getAdjustableValue("backfire.speed")
		local num = getAdjustableValue("backfire.num")
		local t = sightexports.sBackfire:popDown(veh, bitAnd(getVehicleHandling(veh).modelFlags, 8192) == 8192, false, snd, spd, num)
		lastBackfireTest = getTickCount() + t
		if playerIsController then
			triggerServerEvent("syncTuningSpectatorAltHandler", localPlayer, "backfire", {
				snd,
				spd,
				num
			})
		end
	end
end
function clientPreviewTuning(tuningId, value)
	if tuningId == "customHorn" then
		if tonumber(value) then
			sightexports.sCustomhorn:playHornForVeh(veh, value)
		else
			sightexports.sCustomhorn:playHornForVeh(veh)
		end
	elseif tuningId == "spinner" then
		if value == "reset" then
			sightexports.sSpinner:refreshSpinners(veh)
		elseif value then
			if value % 2 == 0 then
				sightexports.sSpinner:refreshSpinners(veh, {
					value,
					255,
					255,
					255
				})
			else
				sightexports.sSpinner:refreshSpinners(veh, value)
			end
		else
			sightexports.sSpinner:refreshSpinners(veh, false)
		end
	elseif tuningId == "lsdDoor" then
		if value == "reset" then
			lsdPreview = false
			resetVehicleComponentRotation(veh, "door_lf_dummy")
			resetVehicleComponentRotation(veh, "door_rf_dummy")
		elseif value then
			lsdPreview = true
		else
			lsdPreview = false
			resetVehicleComponentRotation(veh, "door_lf_dummy")
			resetVehicleComponentRotation(veh, "door_rf_dummy")
		end
	elseif tuningId == "headlightColor" then
		local r = tonumber("0x" .. value:sub(1, 2))
		local g = tonumber("0x" .. value:sub(3, 4))
		local b = tonumber("0x" .. value:sub(5, 6))
		setVehicleHeadLightColor(veh, r, g, b)
	elseif tuningId == "neon" then
		if value == "reset" then
			sightexports.sNeon:initNeon(veh)
		elseif value == "custom" then
			sightexports.sNeon:initNeon(veh, true, "white", "white")
		elseif value then
			sightexports.sNeon:initNeon(veh, true, value, false)
		else
			sightexports.sNeon:initNeon(veh, true, false, false)
		end
	elseif tuningId == "performance.supercharger" then
		if value == "reset" then
			sightexports.sVehicles:processSuperCharger(veh, true)
		elseif value then
			sightexports.sVehicles:createPreviewSupercharger(veh)
		else
			sightexports.sVehicles:deleteSuperCharger(veh)
		end
	elseif tuningId == "nitro" then
		if value and value ~= "reset" then
			triggerEvent("nosEffectState", veh, "test", true)
		end
	elseif tuningId == "nosrefill" then
		if value and value ~= "reset" then
			triggerEvent("nosEffectState", veh, "test", value == 2)
		end
	elseif tuningId == "paintjob" then
		if value == "reset" then
			sightexports.sPaintjob:removeVehicleCurrentPjTexture(veh)
			sightexports.sPaintjob:maybeApplyVehicleStoredPj(veh)
		elseif tonumber(value) then
			sightexports.sPaintjob:maybeApplyVehicleStoredPj(veh, tonumber(value))
		else
			sightexports.sPaintjob:removeVehicleCurrentPjTexture(veh)
		end
	elseif tuningId == "headlightPaintjob" then
		if value == "reset" then
			sightexports.sPaintjob:removeVehicleCurrentHeadlightTexture(veh)
			sightexports.sPaintjob:maybeApplyVehicleStoredHeadlight(veh)
		elseif tonumber(value) then
			sightexports.sPaintjob:maybeApplyVehicleStoredHeadlight(veh, tonumber(value))
		else
			sightexports.sPaintjob:removeVehicleCurrentHeadlightTexture(veh)
		end
	elseif tuningId == "wheelPaintjob" then
		if value == "reset" then
			sightexports.sPaintjob:removeVehicleCurrentWheelTexture(veh)
			sightexports.sPaintjob:maybeApplyVehicleStoredWheel(veh)
		elseif tonumber(value) then
			sightexports.sPaintjob:maybeApplyVehicleStoredWheel(veh, tonumber(value))
		else
			sightexports.sPaintjob:removeVehicleCurrentWheelTexture(veh)
		end
	end
end
local customTuningPrompt = false
function deleteTuningCustomPrompt()
	if customTuningPrompt then
		sightexports.sGui:deleteGuiElement(customTuningPrompt)
	end
	customTuningPrompt = nil
	showCursor(false)
end
addEvent("tuningCustomPromptResponse", false)
addEventHandler("tuningCustomPromptResponse", getRootElement(), function(button, state, absoluteX, absoluteY, el, dat)
	deleteTuningCustomPrompt()
	if dat then
		buyingTuning = true
		triggerServerEvent("tryToBuyTuning", localPlayer, currentMenu[activeMenu].tuningId, dat[1], dat[2])
	else
		buyingTuning = false
		buyPromptAnimation = {
			getTickCount(),
			2
		}
		if currentMenu[activeMenu].hexPicker and values[activeValue][5] == "hexpicker" then
			createColorPicker("hexpicker")
		end
	end
end)
function createTuningCustomPrompt(dat)
	deleteTuningCustomPrompt()
	showCursor(true)
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local pw = 400
	local fh = sightexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
	local ph = titleBarHeight + 16 + fh * 6 + 32 + 8
	customTuningPrompt = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
	sightexports.sGui:setWindowTitle(customTuningPrompt, "16/BebasNeueRegular.otf", "Tuning - Egyedi beállítások")
	local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, 16 + fh * 6, customTuningPrompt)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "Figyelem!\n\nEnnél a tuningnál beállított egyedi értékeket\ncsak újravásárlással tudod megváltoztatni.\n\nBiztosan szeretnéd megvenni?")
	sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	local btn = sightexports.sGui:createGuiElement("button", 8, ph - 32 - 8, (pw - 16) / 2 - 4, 32, customTuningPrompt)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setClickEvent(btn, "tuningCustomPromptResponse")
	sightexports.sGui:setClickArgument(btn, dat)
	sightexports.sGui:setButtonText(btn, "Igen")
	local btn = sightexports.sGui:createGuiElement("button", pw / 2 + 4, ph - 32 - 8, (pw - 16) / 2 - 4, 32, customTuningPrompt)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightred",
		"sightred-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setClickEvent(btn, "tuningCustomPromptResponse")
	sightexports.sGui:setClickArgument(btn, false)
	sightexports.sGui:setButtonText(btn, "Nem")
end
function tuningKey(key, por)
	cancelEvent()
	if por and menuOpen and not freecamInterpolation and not menuInterpolation and not closingInterpolation and not openingInterpolation and not valueInterpolation and not valueOpenInterpolation and not valueCloseInterpolation and not buyPromptAnimation and not buyingTuning and not adjustingInterpolation and not exitingTuning and (not sightexports.sGui:getActiveInput() or key == "enter") then
		if key == "u" then
			switchTuningMusic()
		elseif key == "z" then
			tuningMusicMuted = not tuningMusicMuted
		elseif not inPjEditorMode then
			if key == "q" then
				freeCamMode = not freeCamMode
				freecamInterpolation = getTickCount()
				if freeCamMode then
					camX = 0.15
					camY = 0.42
					desiredCamZoom = 2
					camZoom = 2
					camCursor = false
					minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(veh)
				end
				showCursor(freeCamMode)
				playSound("files/freecam.mp3")
				return
			end
			if freeCamMode then
				if key == "mouse_wheel_up" then
					if 1 < desiredCamZoom then
						desiredCamZoom = desiredCamZoom - 0.1
					end
					return
				elseif key == "mouse_wheel_down" then
					if desiredCamZoom < 2.75 then
						desiredCamZoom = desiredCamZoom + 0.1
					end
					return
				end
			end
			if playerIsController then
				if buyPrompt then
					if key == "enter" then
						if buyPromptValue then
							if activeValue then
								buyingTuning = true
								local tmp = adjustableValues
								local val = values[activeValue][5]
								local prompt = false
								if currentMenu[activeMenu].hexPicker and val == "hexpicker" then
									val = utf8.lower(utf8.sub(sightexports.sGui:getColorCodeHex({
										colorPickerR,
										colorPickerG,
										colorPickerB
									}), 2, 7))
									prompt = true
								elseif currentMenu[activeMenu].textinput then
									tmp = textInputValue
								elseif currentMenu[activeMenu].colorpicker then
									tmp = {
										colorPickerR,
										colorPickerG,
										colorPickerB
									}
								end
								if tmp or prompt then
									createTuningCustomPrompt({val, tmp})
								else
									deleteTuningCustomPrompt()
									triggerServerEvent("tryToBuyTuning", localPlayer, currentMenu[activeMenu].tuningId, val, tmp)
								end
								adjustableValues = false
							end
						else
							deleteTuningCustomPrompt()
							buyPromptAnimation = {
								getTickCount(),
								2
							}
							if currentMenu[activeMenu].hexPicker and values[activeValue][5] == "hexpicker" then
								createColorPicker("hexpicker")
							end
						end
					elseif key == "backspace" then
						buyPromptAnimation = {
							getTickCount(),
							2
						}
						if currentMenu[activeMenu].hexPicker and values[activeValue][5] == "hexpicker" then
							createColorPicker("hexpicker")
						end
					elseif key == "arrow_l" then
						if not buyPromptValue then
							buyPromptValue = true
							buyPromptAnimation = {
								getTickCount(),
								3
							}
						end
					elseif key == "arrow_r" and buyPromptValue then
						buyPromptValue = false
						buyPromptAnimation = {
							getTickCount(),
							3
						}
					end
				elseif currentTextInput then
					if key == "backspace" then
						deleteTextInput()
					elseif key == "enter" then
						if currentTextInput == currentMenu[activeMenu].textinput then
							if utf8.len(textInputValue) <= 0 then
								sightexports.sGui:showInfobox("e", "Nem lehet üres a mező!")
								return
							end
							buyPromptAnimation = {
								getTickCount(),
								1
							}
							buyPrompt = true
							buyPromptValue = true
						end
						deleteTextInput()
					end
				elseif colorPickerMode and colorPickerMode ~= "hexpicker" then
					if key == "backspace" then
						deleteColorPicker()
					elseif key == "enter" then
						if colorPickerMode == "hexpicker" or colorPickerMode == currentMenu[activeMenu].colorpicker .. tostring(values[activeValue][5]) then
							buyPromptAnimation = {
								getTickCount(),
								1
							}
							buyPrompt = true
							buyPromptValue = true
						end
						deleteColorPicker()
					end
				elseif adjustingValue then
					if key == "lalt" then
						adjustingValueAltHandler()
					elseif key == "arrow_u" then
						if 1 < selectedAdjustValue then
							adjustingInterpolation = {
								getTickCount(),
								5,
								selectedAdjustValue,
								selectedAdjustValue - 1
							}
							selectedAdjustValue = selectedAdjustValue - 1
						end
					elseif key == "arrow_d" then
						if selectedAdjustValue < #values[activeValue][6] then
							adjustingInterpolation = {
								getTickCount(),
								5,
								selectedAdjustValue,
								selectedAdjustValue + 1
							}
							selectedAdjustValue = selectedAdjustValue + 1
						end
					elseif key == "arrow_r" then
						if adjustableValues[selectedAdjustValue] < values[activeValue][6][selectedAdjustValue][4] then
							if not valueScrollSpeed then
								valueScrollSpeed = 1
							end
							local was = adjustableValues[selectedAdjustValue]
							adjustableValues[selectedAdjustValue] = adjustableValues[selectedAdjustValue] + values[activeValue][6][selectedAdjustValue][5] * valueScrollSpeed
							if values[activeValue][6][selectedAdjustValue][6] then
								adjustableValues[selectedAdjustValue] = math.floor(adjustableValues[selectedAdjustValue])
							end
							if adjustableValues[selectedAdjustValue] > values[activeValue][6][selectedAdjustValue][4] then
								adjustableValues[selectedAdjustValue] = values[activeValue][6][selectedAdjustValue][4]
							end
							adjustingInterpolation = {
								getTickCount(),
								6,
								was,
								adjustableValues[selectedAdjustValue]
							}
						else
							valueScrollSpeed = false
						end
					elseif key == "arrow_l" then
						if adjustableValues[selectedAdjustValue] > values[activeValue][6][selectedAdjustValue][3] then
							if not valueScrollSpeed then
								valueScrollSpeed = 1
							end
							local was = adjustableValues[selectedAdjustValue]
							adjustableValues[selectedAdjustValue] = adjustableValues[selectedAdjustValue] - values[activeValue][6][selectedAdjustValue][5] * valueScrollSpeed
							if values[activeValue][6][selectedAdjustValue][6] then
								adjustableValues[selectedAdjustValue] = math.ceil(adjustableValues[selectedAdjustValue])
							end
							if adjustableValues[selectedAdjustValue] < values[activeValue][6][selectedAdjustValue][3] then
								adjustableValues[selectedAdjustValue] = values[activeValue][6][selectedAdjustValue][3]
							end
							adjustingInterpolation = {
								getTickCount(),
								6,
								was,
								adjustableValues[selectedAdjustValue]
							}
						else
							valueScrollSpeed = false
						end
					elseif key == "enter" then
						adjustingInterpolation = {
							getTickCount(),
							3,
							true
						}
					elseif key == "backspace" then
						adjustingInterpolation = {
							getTickCount(),
							3
						}
					end
				elseif key == "arrow_u" then
					if activeValue then
						if 1 < activeValue then
							valueInterpolation = {
								getTickCount(),
								activeValue,
								activeValue - 1
							}
							activeValue = activeValue - 1
							playSound("files/nav.mp3")
							if currentMenu[activeMenu].hexPicker then
								if values[activeValue][5] == "hexpicker" then
									createColorPicker("hexpicker")
								else
									deleteColorPicker()
								end
							end
							if playerIsController then
								triggerServerEvent("syncTuningSpectatorData", localPlayer, "value", values[activeValue], activeValue == equippedValue)
							end
							if currentMenu[activeMenu].serverPreview then
								triggerServerEvent("previewTuningServer", localPlayer, currentMenu[activeMenu].tuningId, values[activeValue][5])
							elseif currentMenu[activeMenu].clientPreview then
								clientPreviewTuning(currentMenu[activeMenu].tuningId, values[activeValue][5])
							end
							if activeValue - valueScroll < 1 then
								valueInterpolation[4] = valueScroll
								valueInterpolation[5] = valueScroll - 1
								valueScroll = valueScroll - 1
							end
							if currentMenu[activeMenu].switchDriveType then
								processVehicleDriveType(values[activeValue][5])
							else
								setOutlineObjects(currentMenu[activeMenu].outlineObjects, values[activeValue][5])
							end
						end
					elseif 1 < activeMenu then
						menuInterpolation = {
							getTickCount(),
							activeMenu,
							activeMenu - 1
						}
						activeMenu = activeMenu - 1
						if freeCamMode then
							freeCamMode = false
							freecamInterpolation = getTickCount()
						end
						if currentMenu[activeMenu] and currentMenu[activeMenu].camera and (not currentMenu[activeMenu].keepDefaultOnOthers or vehType == "Automobile") then
							setCamera(currentMenu[activeMenu].camera, 300)
						else
							setCamera(defaultCamera, 300)
						end
						if currentMenu[activeMenu] and currentMenu[activeMenu].cameraTarget and (not currentMenu[activeMenu].keepDefaultOnOthers or vehType == "Automobile") then
							setCamTarget(currentMenu[activeMenu].cameraTarget, 300)
						else
							setCamTarget(false, 300)
						end
						playSound("files/cammovemenu1.mp3")
						playSound("files/nav.mp3")
						if currentMenu[activeMenu] and currentMenu[activeMenu].vehicleMode and (not currentMenu[activeMenu].keepDefaultOnOthers or vehType == "Automobile") then
							setVehicleMode(currentMenu[activeMenu].vehicleMode)
						else
							setVehicleMode(false)
						end
						if currentMenu[activeMenu] and currentMenu[activeMenu].outlineObjects and (not currentMenu[activeMenu].keepDefaultOnOthers or vehType == "Automobile") then
							setOutlineObjects(currentMenu[activeMenu].outlineObjects)
						else
							setOutlineObjects(false)
							if currentMenu[activeMenu].switchDriveType then
								processVehicleDriveType()
							end
						end
						if playerIsController then
							triggerServerEvent("syncTuningSpectatorData", localPlayer, "activeMenu", currentMenu[activeMenu].icon, currentMenu[activeMenu].name)
						end
					end
				elseif key == "arrow_d" then
					if activeValue then
						if activeValue < #values then
							valueInterpolation = {
								getTickCount(),
								activeValue,
								activeValue + 1
							}
							activeValue = activeValue + 1
							if currentMenu[activeMenu].hexPicker then
								if values[activeValue][5] == "hexpicker" then
									createColorPicker("hexpicker")
								else
									deleteColorPicker()
								end
							end
							playSound("files/nav.mp3")
							if playerIsController then
								triggerServerEvent("syncTuningSpectatorData", localPlayer, "value", values[activeValue], activeValue == equippedValue)
							end
							if currentMenu[activeMenu].serverPreview then
								triggerServerEvent("previewTuningServer", localPlayer, currentMenu[activeMenu].tuningId, values[activeValue][5])
							elseif currentMenu[activeMenu].clientPreview then
								clientPreviewTuning(currentMenu[activeMenu].tuningId, values[activeValue][5])
							end
							if activeValue - valueScroll > maximumValueNum then
								valueInterpolation[4] = valueScroll
								valueInterpolation[5] = valueScroll + 1
								valueScroll = valueScroll + 1
							end
							if currentMenu[activeMenu].switchDriveType then
								processVehicleDriveType(values[activeValue][5])
							else
								setOutlineObjects(currentMenu[activeMenu].outlineObjects, values[activeValue][5])
							end
						end
					elseif activeMenu < #menus then
						menuInterpolation = {
							getTickCount(),
							activeMenu,
							activeMenu + 1
						}
						activeMenu = activeMenu + 1
						if freeCamMode then
							freeCamMode = false
							freecamInterpolation = getTickCount()
						end
						if currentMenu[activeMenu] and currentMenu[activeMenu].camera and (not currentMenu[activeMenu].keepDefaultOnOthers or vehType == "Automobile") then
							setCamera(currentMenu[activeMenu].camera, 300)
						else
							setCamera(defaultCamera, 300)
						end
						if currentMenu[activeMenu] and currentMenu[activeMenu].cameraTarget and (not currentMenu[activeMenu].keepDefaultOnOthers or vehType == "Automobile") then
							setCamTarget(currentMenu[activeMenu].cameraTarget, 300)
						else
							setCamTarget(false, 300)
						end
						playSound("files/cammovemenu2.mp3")
						playSound("files/nav.mp3")
						if currentMenu[activeMenu] and currentMenu[activeMenu].vehicleMode and (not currentMenu[activeMenu].keepDefaultOnOthers or vehType == "Automobile") then
							setVehicleMode(currentMenu[activeMenu].vehicleMode)
						else
							setVehicleMode(false)
						end
						if currentMenu[activeMenu] and currentMenu[activeMenu].outlineObjects and (not currentMenu[activeMenu].keepDefaultOnOthers or vehType == "Automobile") then
							setOutlineObjects(currentMenu[activeMenu].outlineObjects)
						else
							setOutlineObjects(false)
							if currentMenu[activeMenu].switchDriveType then
								processVehicleDriveType()
							end
						end
						if playerIsController then
							triggerServerEvent("syncTuningSpectatorData", localPlayer, "activeMenu", currentMenu[activeMenu].icon, currentMenu[activeMenu].name)
						end
					end
				elseif key == "arrow_l" or key == "backspace" then
					if activeValue then
						valueCloseInterpolation = {
							getTickCount(),
							2
						}
						playSound("files/em.wav")
						if currentMenu[activeMenu].hexPicker then
							deleteColorPicker()
						end
						if currentMenu[activeMenu].switchDriveType then
							processVehicleDriveType()
						else
							setOutlineObjects(currentMenu[activeMenu].outlineObjects)
						end
					elseif 0 < #previousMenus then
						closingInterpolation = {
							getTickCount(),
							false
						}
						playSound("files/lm.wav")
					elseif key == "backspace" then
						exitingTuning = true
						sightexports.sSpeedo:toggleTuningIntro(false)
						triggerServerEvent("tryToExitTuningWorkshop", localPlayer)
					end
				elseif key == "arrow_r" or key == "enter" then
					if activeValue then
						if currentMenu[activeMenu].customPj and values[activeValue][5] == true then
							if not inPjEditorMode and sightexports.sCustompj:startPaintjobEditor(veh, isGratisPJ) then
								inPjEditorMode = true
							end
						elseif currentMenu[activeMenu].textinput and values[activeValue][5] then
							createTextInput(currentMenu[activeMenu].textinput)
						elseif currentMenu[activeMenu].colorpicker and values[activeValue][5] then
							createColorPicker(currentMenu[activeMenu].colorpicker .. tostring(values[activeValue][5]))
						elseif values[activeValue][6] then
							adjustableValues = {}
							for i = 1, #values[activeValue][6] do
								adjustableValues[i] = tonumber(valuesFromServer[values[activeValue][6][i][2]]) or values[activeValue][6][i][3]
							end
							adjustingValue = true
							selectedAdjustValue = 1
							adjustingInterpolation = {
								getTickCount(),
								1
							}
						elseif equippedValue ~= activeValue or values[activeValue][7] then
							if currentMenu[activeMenu].hexPicker then
								deleteColorPicker()
							end
							buyPromptAnimation = {
								getTickCount(),
								1
							}
							buyPrompt = true
							buyPromptValue = true
						end
					elseif currentMenu[activeMenu] then
						if currentMenu[activeMenu].submenus then
							closingInterpolation = {
								getTickCount(),
								activeMenu
							}
							playSound("files/lm.wav")
						elseif currentMenu[activeMenu].values and loadValues() then
							if currentMenu[activeMenu].tuningId then
								triggerServerEvent("requestTuningValuesFromServer", localPlayer, currentMenu[activeMenu].tuningId)
							end
							valueOpenInterpolation = {
								getTickCount(),
								1
							}
							playSound("files/lm.wav")
							equippedValue = false
							if currentMenu[activeMenu].switchDriveType then
								processVehicleDriveType(values[activeValue][5])
							else
								setOutlineObjects(currentMenu[activeMenu].outlineObjects, values[activeValue][5])
							end
						end
					end
				end
			end
		end
	end
end
function getVehicleSpeed(currentElement, forceUnit)
	if isElement(currentElement) then
		local testUnit = forceUnit or unit
		local x, y, z = getElementVelocity(currentElement)
		local speed = math.sqrt(x ^ 2 + y ^ 2 + z ^ 2)
		if testUnit == "MPH" then
			speed = speed * 116.5 * 1.1
		else
			speed = speed * 180 * 1.1
		end
		return speed
	end
	return 0
end
function getPositionFromElementOffset(element, offX, offY, offZ)
	local m = getElementMatrix(element)
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z
end
function getPositionFromMatrixOffset(m, offX, offY, offZ)
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z
end
function processVehicleObjects(state, force, arg)
	if state == currentObjectState and not force then
		return
	end
	local dim = getElementDimension(localPlayer)
	local int = 1
	currentObjectState = state
	for k, v in pairs(vehicleObjects) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	vehicleObjects = {}
	local m = getElementMatrix(veh)
	local rx, ry, rz = getElementRotation(veh)
	if state == "engine" then
		local x, y, z = getVehicleDummyPosition(veh, "engine")
		x, y, z = getPositionFromMatrixOffset(m, 0.3, y, z)
		z = z - 0.35
		if not isElement(vehicleObjects.cylinder_head) then
			vehicleObjects.cylinder_head = createObject(objectModels.cylinder_head, x, y, z, 0, 0, rz)
			setElementDimension(vehicleObjects.cylinder_head, dim)
			setElementInterior(vehicleObjects.cylinder_head, int)
			setElementCollisionsEnabled(vehicleObjects.cylinder_head, false)
			setElementDoubleSided(vehicleObjects.cylinder_head, false)
		end
		if not isElement(vehicleObjects.timing_belt) then
			vehicleObjects.timing_belt = createObject(objectModels.timing_belt, x, y, z, 0, 0, rz)
			setElementDimension(vehicleObjects.timing_belt, dim)
			setElementInterior(vehicleObjects.timing_belt, int)
			setElementCollisionsEnabled(vehicleObjects.timing_belt, false)
			setElementDoubleSided(vehicleObjects.timing_belt, false)
		end
		if not isElement(vehicleObjects.engine_block) then
			vehicleObjects.engine_block = createObject(objectModels.engine_block, x, y, z, 0, 0, rz)
			setElementDimension(vehicleObjects.engine_block, dim)
			setElementInterior(vehicleObjects.engine_block, int)
			setElementCollisionsEnabled(vehicleObjects.engine_block, false)
			setElementDoubleSided(vehicleObjects.engine_block, false)
		end
		if not isElement(vehicleObjects.oil_sump) then
			vehicleObjects.oil_sump = createObject(objectModels.oil_sump, x, y, z, 0, 0, rz)
			setElementDimension(vehicleObjects.oil_sump, dim)
			setElementInterior(vehicleObjects.oil_sump, int)
			setElementCollisionsEnabled(vehicleObjects.oil_sump, false)
			setElementDoubleSided(vehicleObjects.oil_sump, false)
		end
		if not isElement(vehicleObjects.valve_cover) then
			vehicleObjects.valve_cover = createObject(objectModels.valve_cover, x, y, z, 0, 0, rz)
			setElementDimension(vehicleObjects.valve_cover, dim)
			setElementInterior(vehicleObjects.valve_cover, int)
			setElementCollisionsEnabled(vehicleObjects.valve_cover, false)
			setElementDoubleSided(vehicleObjects.valve_cover, false)
		end
		if not isElement(vehicleObjects.ecu) then
			vehicleObjects.ecu = createObject(objectModels.ecu, x, y, z, 0, 0, rz)
			setElementDimension(vehicleObjects.ecu, dim)
			setElementInterior(vehicleObjects.ecu, int)
			setElementCollisionsEnabled(vehicleObjects.ecu, false)
			setElementDoubleSided(vehicleObjects.ecu, false)
		end
		if not isElement(vehicleObjects.exhaust_manifold) then
			vehicleObjects.exhaust_manifold = createObject(objectModels.exhaust_manifold, x, y, z, 0, 0, rz)
			setElementDimension(vehicleObjects.exhaust_manifold, dim)
			setElementInterior(vehicleObjects.exhaust_manifold, int)
			setElementCollisionsEnabled(vehicleObjects.exhaust_manifold, false)
			setElementDoubleSided(vehicleObjects.exhaust_manifold, false)
		end
		if not isElement(vehicleObjects.intake_manifold) then
			vehicleObjects.intake_manifold = createObject(objectModels.intake_manifold, x, y, z, 0, 0, rz)
			setElementDimension(vehicleObjects.intake_manifold, dim)
			setElementInterior(vehicleObjects.intake_manifold, int)
			setElementCollisionsEnabled(vehicleObjects.intake_manifold, false)
			setElementDoubleSided(vehicleObjects.intake_manifold, false)
		end
		if valuesFromServer["performance.turbo"] == 4 then
			if isElement(vehicleObjects.turbo) then
				destroyElement(vehicleObjects.turbo)
			end
			vehicleObjects.turbo = nil
		elseif not isElement(vehicleObjects.turbo) then
			vehicleObjects.turbo = createObject(objectModels.turbo, x, y, z, 0, 0, rz)
			setElementDimension(vehicleObjects.turbo, dim)
			setElementInterior(vehicleObjects.turbo, int)
			setElementCollisionsEnabled(vehicleObjects.turbo, false)
			setElementDoubleSided(vehicleObjects.turbo, false)
		end
		if not isElement(vehicleObjects.transmission) then
			vehicleObjects.transmission = createObject(objectModels.transmission, x, y, z, 0, 0, rz)
			setElementDimension(vehicleObjects.transmission, dim)
			setElementInterior(vehicleObjects.transmission, int)
			setElementCollisionsEnabled(vehicleObjects.transmission, false)
			setElementDoubleSided(vehicleObjects.transmission, false)
		end
	end
	if state == "wheels" or state == "powertrain" then
		if not isElement(vehicleObjects.brake_rl) then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_lb_dummy", "world")
			local rx, ry, rz = getVehicleComponentRotation(veh, "wheel_lb_dummy", "world")
			vehicleObjects.brake_rl = createObject(objectModels.brakedisc, x, y, z, 0, 0, rz + 180)
			setElementDimension(vehicleObjects.brake_rl, dim)
			setElementInterior(vehicleObjects.brake_rl, int)
			setObjectScale(vehicleObjects.brake_rl, 0.75, -0.75, 0.75)
			setElementCollisionsEnabled(vehicleObjects.brake_rl, false)
			setElementDoubleSided(vehicleObjects.brake_rl, true)
		end
		if not isElement(vehicleObjects.brake_rr) then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_rb_dummy", "world")
			local rx, ry, rz = getVehicleComponentRotation(veh, "wheel_rb_dummy", "world")
			vehicleObjects.brake_rr = createObject(objectModels.brakedisc, x, y, z, 0, 0, rz + 180)
			setElementDimension(vehicleObjects.brake_rr, dim)
			setElementInterior(vehicleObjects.brake_rr, int)
			setObjectScale(vehicleObjects.brake_rr, 0.75, 0.75, 0.75)
			setElementCollisionsEnabled(vehicleObjects.brake_rr, false)
		end
		if not isElement(vehicleObjects.brake_fl) then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_lf_dummy", "world")
			local rx, ry, rz = getVehicleComponentRotation(veh, "wheel_lf_dummy", "world")
			vehicleObjects.brake_fl = createObject(objectModels.brakedisc, x, y, z, 0, 0, rz + 180)
			setElementDimension(vehicleObjects.brake_fl, dim)
			setElementInterior(vehicleObjects.brake_fl, int)
			setObjectScale(vehicleObjects.brake_fl, 0.75, -0.75, 0.75)
			setElementCollisionsEnabled(vehicleObjects.brake_fl, false)
			setElementDoubleSided(vehicleObjects.brake_fl, true)
		end
		if not isElement(vehicleObjects.brake_fr) then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_rf_dummy", "world")
			local rx, ry, rz = getVehicleComponentRotation(veh, "wheel_rf_dummy", "world")
			vehicleObjects.brake_fr = createObject(objectModels.brakedisc, x, y, z, 0, 0, rz + 180)
			setElementDimension(vehicleObjects.brake_fr, dim)
			setElementInterior(vehicleObjects.brake_fr, int)
			setObjectScale(vehicleObjects.brake_fr, 0.75, 0.75, 0.75)
			setElementCollisionsEnabled(vehicleObjects.brake_fr, false)
		end
		local hoodZ = false
		if not hoodZ then
			hoodX, hoodY, hoodZ = getVehicleComponentPosition(veh, "bonnet_dummy", "world")
			if not hoodZ then
				hoodX, hoodY, hoodZ = getVehicleComponentPosition(veh, "engine")
			end
			if not hoodZ then
				local x, y, z = getVehicleDummyPosition(veh, "engine")
				x, y, z = getPositionFromMatrixOffset(m, x, y, z)
				hoodZ = z
			end
			hoodZ = hoodZ - 0.1
		end
		if not isElement(vehicleObjects.suspension_fl) then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_lf_dummy", "world")
			local rx, ry, rz = getVehicleComponentRotation(veh, "wheel_lf_dummy", "world")
			local rad = math.rad(rz)
			z = z - 0.075
			local d = getDistanceBetweenPoints3D(x, y, z, x - math.cos(rad) * 0.25, y - math.sin(rad) * 0.25, hoodZ - 0.052)
			local partRot = math.deg(math.atan(0.25 / math.abs(hoodZ - z)))
			vehicleObjects.suspension_fl = createObject(objectModels.suspension_front, x, y, z + 0.075, 0, partRot, rz + 180)
			setElementDimension(vehicleObjects.suspension_fl, dim)
			setElementInterior(vehicleObjects.suspension_fl, int)
			setObjectScale(vehicleObjects.suspension_fl, 1, 1, d / 0.5)
			setElementCollisionsEnabled(vehicleObjects.suspension_fl, false)
		end
		if not isElement(vehicleObjects.suspension_fr) then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_rf_dummy", "world")
			local rx, ry, rz = getVehicleComponentRotation(veh, "wheel_rf_dummy", "world")
			local rad = math.rad(rz)
			z = z - 0.075
			local d = getDistanceBetweenPoints3D(x, y, z, x - math.cos(rad) * 0.25, y - math.sin(rad) * 0.25, hoodZ - 0.052)
			local partRot = math.deg(math.atan(0.25 / math.abs(hoodZ - z)))
			vehicleObjects.suspension_fr = createObject(objectModels.suspension_front, x, y, z + 0.075, 0, partRot, rz + 180)
			setElementDimension(vehicleObjects.suspension_fr, dim)
			setElementInterior(vehicleObjects.suspension_fr, int)
			setObjectScale(vehicleObjects.suspension_fr, 1, 1, d / 0.5)
			setElementCollisionsEnabled(vehicleObjects.suspension_fr, false)
		end
		if not isElement(vehicleObjects.suspension_rr) then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_rb_dummy", "world")
			local rx, ry, rz = getVehicleComponentRotation(veh, "wheel_rb_dummy", "world")
			local rad = math.rad(rz)
			local d = getDistanceBetweenPoints3D(x, y, z, x - math.cos(rad) * 0.2, y - math.sin(rad) * 0.2, z + 0.45)
			local partRot = math.deg(math.atan(0.4444444444444445))
			vehicleObjects.suspension_rr = createObject(objectModels.suspension_rear, x, y, z, 0, partRot, rz + 180)
			setElementDimension(vehicleObjects.suspension_rr, dim)
			setElementInterior(vehicleObjects.suspension_rr, int)
			setObjectScale(vehicleObjects.suspension_rr, 1, 1, d / 0.5)
			setElementCollisionsEnabled(vehicleObjects.suspension_rr, false)
		end
		if not isElement(vehicleObjects.suspension_rl) then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_lb_dummy", "world")
			local rx, ry, rz = getVehicleComponentRotation(veh, "wheel_lb_dummy", "world")
			local rad = math.rad(rz)
			local d = getDistanceBetweenPoints3D(x, y, z, x - math.cos(rad) * 0.2, y - math.sin(rad) * 0.2, z + 0.45)
			local partRot = math.deg(math.atan(0.4444444444444445))
			vehicleObjects.suspension_rl = createObject(objectModels.suspension_rear, x, y, z, 0, partRot, rz + 180)
			setElementDimension(vehicleObjects.suspension_rl, dim)
			setElementInterior(vehicleObjects.suspension_rl, int)
			setObjectScale(vehicleObjects.suspension_rl, 1, 1, d / 0.5)
			setElementCollisionsEnabled(vehicleObjects.suspension_rl, false)
		end
	end
	if state == "powertrain" then
		local ex, ey, ez = getVehicleDummyPosition(veh, "engine")
		ez = ez - 0.3
		if not isElement(vehicleObjects.halfshaft_rl) then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_lb_dummy", "root")
			local d = math.abs(x) - 0.05
			local rot = math.deg(math.atan((ez - z) / d))
			local x, y, z = getVehicleComponentPosition(veh, "wheel_lb_dummy", "world")
			local rx, ry, rz = getVehicleComponentRotation(veh, "wheel_lb_dummy", "world")
			vehicleObjects.halfshaft_rl = createObject(objectModels.half_shaft, x, y, z, 0, rot, rz)
			setElementDimension(vehicleObjects.halfshaft_rl, dim)
			setElementInterior(vehicleObjects.halfshaft_rl, int)
			setObjectScale(vehicleObjects.halfshaft_rl, d / 0.5, -1, 1)
			setElementCollisionsEnabled(vehicleObjects.halfshaft_rl, false)
			setElementDoubleSided(vehicleObjects.halfshaft_rl, true)
		end
		if not isElement(vehicleObjects.halfshaft_rr) then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_rb_dummy", "root")
			local d = math.abs(x) - 0.05
			local rot = math.deg(math.atan((ez - z) / d))
			local x, y, z = getVehicleComponentPosition(veh, "wheel_rb_dummy", "world")
			local rx, ry, rz = getVehicleComponentRotation(veh, "wheel_rb_dummy", "world")
			vehicleObjects.halfshaft_rr = createObject(objectModels.half_shaft, x, y, z, 0, rot, rz)
			setElementDimension(vehicleObjects.halfshaft_rr, dim)
			setElementInterior(vehicleObjects.halfshaft_rr, int)
			setObjectScale(vehicleObjects.halfshaft_rr, d / 0.5, 1, 1)
			setElementCollisionsEnabled(vehicleObjects.halfshaft_rr, false)
		end
		if not isElement(vehicleObjects.cardan) then
			local x, y2, z = getVehicleComponentPosition(veh, "wheel_rf_dummy", "root")
			local x, y, z = getVehicleComponentPosition(veh, "wheel_rb_dummy", "root")
			local d = math.abs(y2 - y) - 0.2 - 0.1
			local x, y, z = getPositionFromMatrixOffset(m, 0, y + 0.2, ez)
			vehicleObjects.cardan = createObject(objectModels.cardan_shaft, x, y, z, 0, 0, rz - 90)
			setElementDimension(vehicleObjects.cardan, dim)
			setElementInterior(vehicleObjects.cardan, int)
			setObjectScale(vehicleObjects.cardan, d / 1, 3, 3)
			setElementCollisionsEnabled(vehicleObjects.cardan, false)
		end
		if not isElement(vehicleObjects.differential) then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_rb_dummy", "root")
			local x, y, z = getPositionFromMatrixOffset(m, 0, y, ez)
			vehicleObjects.differential = createObject(objectModels.differential, x, y, z, 0, 0, rz - 90)
			setElementDimension(vehicleObjects.differential, dim)
			setElementInterior(vehicleObjects.differential, int)
			setObjectScale(vehicleObjects.differential, 1.25, 1.25, 1.25)
			setElementCollisionsEnabled(vehicleObjects.differential, false)
		end
		if not isElement(vehicleObjects.transfer_case) then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_rf_dummy", "root")
			local x, y, z = getPositionFromMatrixOffset(m, -0.15, y, ez)
			vehicleObjects.transfer_case = createObject(objectModels.transfer_case, x, y, z, 0, 0, rz + 90)
			setElementDimension(vehicleObjects.transfer_case, dim)
			setElementInterior(vehicleObjects.transfer_case, int)
			setObjectScale(vehicleObjects.transfer_case, 1.25, 1.25, 1.25)
			setElementCollisionsEnabled(vehicleObjects.transfer_case, false)
		end
		if not isElement(vehicleObjects.halfshaft_fl) then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_lf_dummy", "root")
			local d = math.abs(x) - 0.05 - 0.31
			local rot = math.deg(math.atan((ez - z) / d))
			local x, y, z = getVehicleComponentPosition(veh, "wheel_lf_dummy", "world")
			local rx, ry, rz = getVehicleComponentRotation(veh, "wheel_lf_dummy", "world")
			vehicleObjects.halfshaft_fl = createObject(objectModels.half_shaft, x, y, z, 0, rot, rz)
			setElementDimension(vehicleObjects.halfshaft_fl, dim)
			setElementInterior(vehicleObjects.halfshaft_fl, int)
			setObjectScale(vehicleObjects.halfshaft_fl, d / 0.5, -1, 1)
			setElementCollisionsEnabled(vehicleObjects.halfshaft_fl, false)
			setElementDoubleSided(vehicleObjects.halfshaft_fl, true)
		end
		if not isElement(vehicleObjects.halfshaft_fr) then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_rf_dummy", "root")
			local d = math.abs(x) - 0.05 + 0.05
			local rot = math.deg(math.atan((ez - z) / d))
			local x, y, z = getVehicleComponentPosition(veh, "wheel_rf_dummy", "world")
			local rx, ry, rz = getVehicleComponentRotation(veh, "wheel_rf_dummy", "world")
			vehicleObjects.halfshaft_fr = createObject(objectModels.half_shaft, x, y, z, 0, rot, rz)
			setElementDimension(vehicleObjects.halfshaft_fr, dim)
			setElementInterior(vehicleObjects.halfshaft_fr, int)
			setObjectScale(vehicleObjects.halfshaft_fr, d / 0.5, 1, 1)
			setElementCollisionsEnabled(vehicleObjects.halfshaft_fr, false)
		end
		processVehicleDriveType()
	end
end
local outlineColor = "green"
function processVehicleDriveType(arg)
	local driveType = arg or valuesFromServer.driveType
	engineRemoveShaderFromWorldTexture(shader, "*")
	for k, v in pairs(vehicleObjects) do
		engineApplyShaderToWorldTexture(shader, "*", v)
	end
	outlineColor = driveType == "set" and "blue" or "green"
	if isElement(vehicleObjects.halfshaft_rl) then
		setElementAlpha(vehicleObjects.halfshaft_rl, 255 * ((driveType == "rwd" or driveType == "awd" or driveType == "set") and 0.4 or 0))
	end
	if isElement(vehicleObjects.halfshaft_rr) then
		setElementAlpha(vehicleObjects.halfshaft_rr, 255 * ((driveType == "rwd" or driveType == "awd" or driveType == "set") and 0.4 or 0))
	end
	if isElement(vehicleObjects.cardan) then
		setElementAlpha(vehicleObjects.cardan, 255 * ((driveType == "rwd" or driveType == "awd" or driveType == "set") and 0.4 or 0))
	end
	if isElement(vehicleObjects.differential) then
		setElementAlpha(vehicleObjects.differential, 255 * ((driveType == "rwd" or driveType == "awd" or driveType == "set") and 0.4 or 0))
	end
	if isElement(vehicleObjects.halfshaft_fl) then
		setElementAlpha(vehicleObjects.halfshaft_fl, 255 * ((driveType == "fwd" or driveType == "awd" or driveType == "set") and 0.4 or 0))
	end
	if isElement(vehicleObjects.halfshaft_fr) then
		setElementAlpha(vehicleObjects.halfshaft_fr, 255 * ((driveType == "fwd" or driveType == "awd" or driveType == "set") and 0.4 or 0))
	end
	if playerIsController then
		triggerServerEvent("syncTuningSpectatorData", localPlayer, "driveType", driveType)
	end
end
local outlineObjectsCache = false
function setOutlineObjects(objects, value, col)
	local colTmp = "green"
	if col then
		colTmp = col
	elseif currentMenu[activeMenu].outlineColors and currentMenu[activeMenu].tuningId then
		local val = value or valuesFromServer[currentMenu[activeMenu].tuningId]
		colTmp = currentMenu[activeMenu].outlineColors[val] or "green"
	end
	if objects ~= outlineObjectsCache or outlineColor ~= colTmp then
		outlineObjectsCache = objects
		outlineColor = colTmp
		engineRemoveShaderFromWorldTexture(shader, "*")
		for k, v in pairs(vehicleObjects) do
			if objects and objects[k] then
				engineApplyShaderToWorldTexture(shader, "*", v)
				setElementAlpha(v, 102)
			else
				engineApplyShaderToWorldTexture(shader, "*", v)
				setElementAlpha(v, 255)
			end
		end
		if playerIsController then
			triggerServerEvent("syncTuningSpectatorData", localPlayer, "outline", objects, outlineColor)
		end
	end
end
function setVehicleMode(mode)
	if currentVehMode ~= mode then
		if mode == "engine" then
			setElementAlpha(veh, 127.5)
			local occupants = getVehicleOccupants(veh)
			for k, v in pairs(occupants) do
				setElementAlpha(v, 0)
			end
			setVehicleDoorOpenRatio(veh, 0, 1, 500)
			processVehicleObjects("engine")
		elseif mode == "wheels" then
			setElementAlpha(veh, 127.5)
			local occupants = getVehicleOccupants(veh)
			for k, v in pairs(occupants) do
				setElementAlpha(v, 0)
			end
			setVehicleDoorOpenRatio(veh, 0, 0, 500)
			processVehicleObjects("wheels")
		elseif mode == "powertrain" then
			setElementAlpha(veh, 127.5)
			local occupants = getVehicleOccupants(veh)
			for k, v in pairs(occupants) do
				setElementAlpha(v, 0)
			end
			setVehicleDoorOpenRatio(veh, 0, 0, 500)
			processVehicleObjects("powertrain")
		else
			setElementAlpha(veh, 255)
			local occupants = getVehicleOccupants(veh)
			for k, v in pairs(occupants) do
				setElementAlpha(v, 255)
			end
			for i = 0, 5 do
				setVehicleDoorOpenRatio(veh, i, 0, 500)
			end
			processVehicleObjects(false)
		end
		if playerIsController then
			triggerServerEvent("syncTuningSpectatorData", localPlayer, "mode", mode)
		end
		currentVehMode = mode
	end
end
function setCamTarget(target, time)
	if not target then
		target = {
			wsX,
			wsY,
			wsZ
		}
	elseif target == "wheel" then
		local x, y, z = getVehicleComponentPosition(veh, "wheel_rf_dummy", "world")
		target = {
			x,
			y,
			z
		}
	elseif target == "engine" then
		local x, y, z = getVehicleDummyPosition(veh, "engine")
		x, y, z = getPositionFromElementOffset(veh, x, y, z)
		target = {
			x,
			y,
			z
		}
	elseif target == "front" then
		local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(veh)
		x, y, z = getPositionFromElementOffset(veh, 0, maxY, 0)
		target = {
			x,
			y,
			z
		}
	elseif target == "rear" then
		local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(veh)
		x, y, z = getPositionFromElementOffset(veh, 0, minY, 0)
		target = {
			x,
			y,
			z
		}
	elseif target == "exhaust" then
		local x, y, z = getVehicleModelExhaustFumesPosition(getElementModel(veh))
		x, y, z = getPositionFromElementOffset(veh, 0, y, z)
		target = {
			x,
			y,
			z
		}
	end
	if cameraTarget[1] ~= target[1] or cameraTarget[2] ~= target[2] or cameraTarget[3] ~= target[3] then
		cameraTargetInterpolation = {
			getTickCount(),
			cameraTarget[1],
			cameraTarget[2],
			cameraTarget[3],
			target[1],
			target[2],
			target[3],
			time
		}
		if playerIsController then
			triggerServerEvent("syncTuningSpectatorData", localPlayer, "camTarget", target, time)
		end
	end
end
function setCamera(cam, time)
	if currentCamera[1] ~= cam[1] or currentCamera[2] ~= cam[2] or currentCamera[3] ~= cam[3] or currentCamera[4] ~= cam[4] or currentCamera[5] ~= cam[5] or currentCamera[6] ~= cam[6] or currentCamera[7] ~= cam[7] or currentCamera[8] ~= cam[8] then
		cameraInterpolation = {
			getTickCount(),
			currentCamera[1],
			currentCamera[2],
			currentCamera[3],
			currentCamera[4],
			currentCamera[5],
			currentCamera[6],
			currentCamera[7],
			currentCamera[8],
			cam[1],
			cam[2],
			cam[3],
			cam[4],
			cam[5],
			cam[6],
			cam[7],
			cam[8],
			time
		}
		if playerIsController then
			triggerServerEvent("syncTuningSpectatorData", localPlayer, "camera", cam, time)
		end
	end
end
local pih = math.pi / 2
function cameraMovement(p, p2, minX, minY, maxX, maxY, maxZ, d)
	local x, y, z = 0, 0, 0
	local x2, y2, z2 = 0, 0, 0
	local sideA = maxX - minX
	local sideB = maxY - minY
	local sum = sideA * 2 + sideB * 2
	local pA = sideA / sum
	local pB = sideB / sum
	local r = -pih * 1.5
	if p <= pA and 0 <= p then
		local p2 = p / pA
		x2 = minX + (maxX - minX) * p2
		y2 = minY
		r = r + pih * p2
	elseif pB >= p - pA and 0 <= p - pA then
		local p2 = (p - pA) / pB
		x2 = maxX
		y2 = minY + (maxY - minY) * p2
		r = r + pih * (1 + p2)
	elseif pA >= p - pA - pB and 0 <= p - pA - pB then
		local p2 = (p - pA - pB) / pA
		x2 = maxX + (minX - maxX) * p2
		y2 = maxY
		r = r + pih * (2 + p2)
	else
		local p2 = (p - pA - pB - pA) / pB
		x2 = minX
		y2 = maxY + (minY - maxY) * p2
		r = r + pih * (3 + p2)
	end
	local circle = 2 * d * pih * 2 / 4
	minZ = minZ * 0.25
	local d2 = d * 1.25
	r = pih * 4 * p
	r2 = 0 + pih - pih * 0.75 * p2
	x2 = 0
	y2 = 0
	x = math.cos(r) * d2 * (sideA / 2 + sideB / 4)
	y = math.sin(r) * d2 * (sideB / 2 + sideA / 4)
	z = d2 * math.cos(r2)
	x = x * math.sin(r2)
	y = y * math.sin(r2)
	local m = getElementMatrix(veh)
	local cx, cy, cz = getPositionFromMatrixOffset(m, x, y, z)
	local tx, ty, tz = getPositionFromMatrixOffset(m, x2, y2, z2)
	return cx, cy, cz, tx, ty, tz
end
local lastMusic = false
addEvent("gotTuningMusic", true)
addEventHandler("gotTuningMusic", getRootElement(), function(id)
	if tuningState and tonumber(id) then
		if isElement(tuningMusic) then
			destroyElement(tuningMusic)
		end
		tuningMusic = playSound("files/music/" .. id .. ".mp3")
		setSoundVolume(tuningMusic, 0)
		setSoundEffectEnabled(tuningMusic, "i3dl2reverb", true)
	end
end)
function switchTuningMusic()
	if tuningState and playerIsController then
		local nextMusic = math.random(1, 23)
		while nextMusic == lastMusic do
			nextMusic = math.random(1, 23)
		end
		lastMusic = nextMusic
		if isElement(tuningMusic) then
			destroyElement(tuningMusic)
		end
		tuningMusic = playSound("files/music/" .. nextMusic .. ".mp3")
		setSoundVolume(tuningMusic, 0)
		setSoundEffectEnabled(tuningMusic, "i3dl2reverb", true)
		triggerServerEvent("syncTuningMusic", localPlayer, nextMusic)
	end
end
function preRenderTuning(delta)
	local now = getTickCount()
	local vx, vy, vz = getElementPosition(veh)
	if nightTime or values and currentMenu[activeMenu].nightTime then
		setTime(0, 0)
		setWeather(1)
	else
		setTime(12, 0)
		setWeather(10)
	end
	if tuningIntro then
		local d = vy - wsY
		local d2 = getDistanceBetweenPoints2D(vx, vy, wsX, wsY)
		if 15000 < now - tuningIntro and (0.1 < d or 0.2 < d2) then
			tuningIntro = false
			sightexports.sSpeedo:toggleTuningIntro(false)
			endNightTime = getTickCount() + 1500
			setTimer(playSound, 1500, 1, "files/light.mp3")
			setTimer(switchTuningMusic, 1500, 1)
			currentCamera = {
				defaultCamera[1],
				defaultCamera[2],
				defaultCamera[3],
				defaultCamera[4],
				defaultCamera[5],
				defaultCamera[6],
				defaultCamera[7],
				defaultCamera[8]
			}
			cameraInterpolation = false
			cameraTargetInterpolation = false
		end
		local p2 = d / 20
		local p = 1 - p2
		local cx, cy = wsX, wsY
		if p < 0.9 then
			introSpeed = math.abs((p - lastP) / delta)
			lastP = p
			overrideIntroP = false
		else
			if not overrideIntroP then
				overrideIntroP = p
			end
			overrideIntroP = overrideIntroP + (introSpeed or 0) * delta
			if 1 < overrideIntroP then
				overrideIntroP = 1
				if d <= 0.1 and 1000 < now - tuningIntro then
					tuningIntro = false
					sightexports.sSpeedo:toggleTuningIntro(false)
					endNightTime = getTickCount() + 1500
					setTimer(playSound, 1500, 1, "files/light.mp3")
					setTimer(switchTuningMusic, 1500, 1)
					currentCamera = {
						defaultCamera[1],
						defaultCamera[2],
						defaultCamera[3],
						defaultCamera[4],
						defaultCamera[5],
						defaultCamera[6],
						defaultCamera[7],
						defaultCamera[8]
					}
					cameraInterpolation = false
					cameraTargetInterpolation = false
				end
			end
			p = overrideIntroP
			p2 = 1 - p
		end
		local r = math.pi / 4 * p2 + defaultCamera[1] * p
		local rx, ry = math.cos(r) * (defaultCamera[2] + 5 * p2), math.sin(r) * (defaultCamera[3] + 5 * p2)
		setCameraMatrix(wsX + rx, wsY + ry, wsZ + defaultCamera[4] + 4 * p2, wsX + defaultCamera[6] * p, wsY + defaultCamera[7] * p, wsZ + defaultCamera[8], defaultCamera[5] * p)
		if tuningIntro and now - tuningIntro <= 1000 then
			local x, y, z = getVehicleComponentPosition(veh, "wheel_rf_dummy")
			if not z then
				x, y, z = getVehicleComponentPosition(veh, "wheel_front")
			end
			vehZ = wsZ - (z or -0.5) + (getVehicleModelWheelSize(getElementModel(veh), "front_axle") or 1) / 2
			if playerIsController then
				setElementPosition(veh, wsX, wsY + 20, vehZ)
				setElementRotation(veh, 0, 0, 180)
			end
		end
	else
		if playerIsController then
			local d2 = getDistanceBetweenPoints2D(vx, vy, wsX, wsY)
			if 0.3 < d2 and not exitingTuning then
				setElementPosition(veh, wsX, wsY, vehZ)
				setElementRotation(veh, 0, 0, 180)
			end
		end
		if tuningMusic then
			if isElement(tuningMusic) then
				local vol = 0
				if not tuningMusicMuted and not streamerMode then
					if values and currentMenu[activeMenu].lowerMusic then
						vol = 0.25
					else
						vol = 0.75
					end
					local length = getSoundLength(tuningMusic)
					local pos = getSoundPosition(tuningMusic)
					if pos < 2 then
						vol = vol * (pos / 2)
					elseif pos > length - 2 then
						vol = vol * (1 - (pos - (length - 2)) / 2)
					end
				end
				setSoundVolume(tuningMusic, vol)
			elseif playerIsController then
				switchTuningMusic()
			end
		end
		if cameraTargetInterpolation then
			local p = math.min((now - cameraTargetInterpolation[1]) / cameraTargetInterpolation[8], 1)
			if 1 < p then
				p = 1
			end
			p = getEasingValue(p, "InOutQuad")
			cameraTarget[1] = cameraTargetInterpolation[2] + (cameraTargetInterpolation[5] - cameraTargetInterpolation[2]) * p
			cameraTarget[2] = cameraTargetInterpolation[3] + (cameraTargetInterpolation[6] - cameraTargetInterpolation[3]) * p
			cameraTarget[3] = cameraTargetInterpolation[4] + (cameraTargetInterpolation[7] - cameraTargetInterpolation[4]) * p
			if 1 <= p then
				cameraTargetInterpolation = false
			end
		end
		if cameraInterpolation then
			local p = math.min((now - cameraInterpolation[1]) / cameraInterpolation[18], 1)
			if 1 < p then
				p = 1
			end
			p = getEasingValue(p, "InOutQuad")
			currentCamera[1] = cameraInterpolation[2] + (cameraInterpolation[10] - cameraInterpolation[2]) * p
			currentCamera[2] = cameraInterpolation[3] + (cameraInterpolation[11] - cameraInterpolation[3]) * p
			currentCamera[3] = cameraInterpolation[4] + (cameraInterpolation[12] - cameraInterpolation[4]) * p
			currentCamera[4] = cameraInterpolation[5] + (cameraInterpolation[13] - cameraInterpolation[5]) * p
			currentCamera[5] = cameraInterpolation[6] + (cameraInterpolation[14] - cameraInterpolation[6]) * p
			currentCamera[6] = cameraInterpolation[7] + (cameraInterpolation[15] - cameraInterpolation[7]) * p
			currentCamera[7] = cameraInterpolation[8] + (cameraInterpolation[16] - cameraInterpolation[8]) * p
			currentCamera[8] = cameraInterpolation[9] + (cameraInterpolation[17] - cameraInterpolation[9]) * p
			if 1 <= p then
				cameraInterpolation = false
			end
		end
		local rx, ry = math.cos(currentCamera[1]) * currentCamera[2], math.sin(currentCamera[1]) * currentCamera[3]
		if not inPjEditorMode then
			if camZoom < desiredCamZoom then
				camZoom = camZoom + 1.1 * delta / 1000
				if camZoom > desiredCamZoom then
					camZoom = desiredCamZoom
				end
			elseif camZoom > desiredCamZoom then
				camZoom = camZoom - 1.1 * delta / 1000
				if camZoom < desiredCamZoom then
					camZoom = desiredCamZoom
				end
			end
			if freeCamMode or freecamInterpolation then
				local zoom = camZoom
				if vehType ~= "Automobile" then
					zoom = zoom + 0.5
				end
				local x = camX
				local y = camY
				local cx, cy, cz, tx, ty, tz = cameraMovement(x, y, minX, minY, maxX, maxY, maxZ, zoom)
				r = 0
				if freecamInterpolation then
					local p = (getTickCount() - freecamInterpolation) / 375
					if 1 <= p then
						freecamInterpolation = false
						p = 1
					end
					if not freeCamMode then
						p = 1 - p
					end
					r = currentCamera[5] * (1 - p)
					local tcx = cameraTarget[1] + rx
					cx = tcx + (cx - tcx) * p
					local tcy = cameraTarget[2] + ry
					cy = tcy + (cy - tcy) * p
					local tcz = cameraTarget[3] + currentCamera[4]
					cz = tcz + (cz - tcz) * p
					local ttx = cameraTarget[1] + currentCamera[6]
					tx = ttx + (tx - ttx) * p
					local tty = cameraTarget[2] + currentCamera[7]
					ty = tty + (ty - tty) * p
					local ttz = cameraTarget[3] + currentCamera[8]
					tz = ttz + (tz - ttz) * p
				end
				setCameraMatrix(cx, cy, cz, tx, ty, tz, r)
				local cx, cy = getCursorPosition()
				if getKeyState("mouse2") and cx and not freecamInterpolation then
					if not camCursor then
						camCursor = {cx, cy}
					else
						local val = cx - camCursor[1]
						camX = camX + 10 * delta / 1000 * math.pow(math.min(0.15, math.abs(val)), 1.5) * (val < 0 and -1 or 1)
						local val = cy - camCursor[2]
						camY = camY + 10 * delta / 1000 * math.pow(math.min(0.15, math.abs(val)), 1.5) * (val < 0 and 1 or -1)
						camX = camX % 1
						camY = math.min(1, math.max(0, camY))
						if camX < 0 then
							camX = 1 + camX
						end
					end
				else
					if camCursor then
					end
					camCursor = false
				end
			else
				setCameraMatrix(cameraTarget[1] + rx, cameraTarget[2] + ry, cameraTarget[3] + currentCamera[4], cameraTarget[1] + currentCamera[6], cameraTarget[2] + currentCamera[7], cameraTarget[3] + currentCamera[8], currentCamera[5])
			end
		end
	end
	dxSetRenderTarget(renderTarget, true)
	dxSetRenderTarget()
end
local spectatorTitle = "SightMTA Tuning"
local spectatorTitleInterpolation = false
local spectatorMenuName = ""
local spectatorMenuIcon = "teljesitmeny"
local spectatorMenuInterpolation = false
local spectatorValue = false
local spectatorValueEquipped = false
local spectatorValueInterpolation = false
addEvent("syncTuningSpectatorData", true)
addEventHandler("syncTuningSpectatorData", getRootElement(), function(data, value, arg)
	if (source == veh or not veh) and not playerIsController then
		if data == "title" then
			spectatorTitleInterpolation = {
				getTickCount(),
				spectatorTitle
			}
			spectatorTitle = value
		elseif data == "mode" then
			setVehicleMode(value)
		elseif data == "camTarget" then
			setCamTarget(value, arg)
		elseif data == "camera" then
			setCamera(value, arg)
		elseif data == "outline" then
			setOutlineObjects(value, false, arg)
		elseif data == "activeMenu" then
			spectatorMenuInterpolation = {
				getTickCount(),
				spectatorMenuIcon,
				spectatorMenuName
			}
			
			local veh = getPedOccupiedVehicle(localPlayer)
			local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
			if electricVehicles[model] then
				if arg == "MOTOR" then
					name = "VILLANYMOTOR"
				elseif arg == "TURBO" then
					name = "AKKUMULÁTOR"
				elseif arg == "VÁLTÓ" then
					name = "INVERTER"
				else
					name = arg
				end
			else
				name = arg
			end
			
			spectatorMenuIcon = value
			spectatorMenuName = name
			playSound("files/cammovemenu1.mp3")
			playSound("files/nav.mp3")
		elseif data == "value" then
			local tmp = false
			if spectatorValue then
				tmp = {}
				for k, v in pairs(spectatorValue) do
					tmp[k] = v
				end
			end
			spectatorValueInterpolation = {
				getTickCount(),
				tmp,
				spectatorValueEquipped
			}
			spectatorValue = value
			spectatorValueEquipped = arg
			playSound("files/nav.mp3")
		elseif data == "driveType" then
			processVehicleDriveType(value)
		end
	end
end)
function renderSpectatorMode(now)
	local h = 96
	dxDrawRectangle(24, 24, w, h, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
	if spectatorTitleInterpolation then
		local p = (now - spectatorTitleInterpolation[1]) / 500
		if 1 < p then
			p = 1
		end
		p = getEasingValue(p, "InOutQuad")
		dxDrawText(spectatorTitle, 24, 24, 24 + w, 72, tocolor(255, 255, 255, 255 * p), fonts.headerFontScale, fonts.headerFont, "center", "center")
		dxDrawText(spectatorTitleInterpolation[2], 24, 24, 24 + w, 72, tocolor(255, 255, 255, 255 * (1 - p)), fonts.headerFontScale, fonts.headerFont, "center", "center")
		if 1 <= p then
			spectatorTitleInterpolation = false
		end
	else
		dxDrawText(spectatorTitle, 24, 24, 24 + w, 72, tocolor(255, 255, 255, 255), fonts.headerFontScale, fonts.headerFont, "center", "center")
	end
	local y = 72
	dxDrawRectangle(36, y - 1, w - 24, 1, tocolor(colors.grey2[1], colors.grey2[2], colors.grey2[3]))
	if spectatorMenuInterpolation then
		local p = (now - spectatorMenuInterpolation[1]) / 200
		if 1 < p then
			p = 1
		end
		p = getEasingValue(p, "InOutQuad")
		dxDrawText(spectatorMenuName, 0, y, 24 + w - 8, y + 48, tocolor(255, 255, 255, 255 * p), fonts.header2FontScale, fonts.header2Font, "right", "center")
		dxDrawImage(32, y + 24 - 16, 32, 32, dynamicImage("files/icons/" .. spectatorMenuIcon .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * p))
		dxDrawText(spectatorMenuInterpolation[3], 0, y, 24 + w - 8, y + 48, tocolor(255, 255, 255, 255 * (1 - p)), fonts.header2FontScale, fonts.header2Font, "right", "center")
		dxDrawImage(32, y + 24 - 16, 32, 32, dynamicImage("files/icons/" .. spectatorMenuInterpolation[2] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * (1 - p)))
		if 1 <= p then
			spectatorMenuInterpolation = false
		end
	else
		dxDrawText(spectatorMenuName, 0, y, 24 + w - 8, y + 48, tocolor(255, 255, 255), fonts.header2FontScale, fonts.header2Font, "right", "center")
		dxDrawImage(32, y + 24 - 16, 32, 32, dynamicImage("files/icons/" .. spectatorMenuIcon .. ".dds"))
	end
	y = y + 48
	if spectatorValueInterpolation then
		local p = (now - spectatorValueInterpolation[1]) / 200
		if 1 < p then
			p = 1
		end
		p = getEasingValue(p, "InOutQuad")
		if spectatorValue and spectatorValueInterpolation[2] then
			dxDrawRectangle(24, y, w, 48, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
		end
		if spectatorValue then
			local col = spectatorValue[4] and (spectatorValue[4] == "blue" and colors.blue or colors.purple) or colors.green
			dxDrawRectangle(24, y, w, 48, tocolor(col[1], col[2], col[3], 255 * p))
			if spectatorValue[4] then
				sightlangStaticImageUsed[0] = true
				if sightlangStaticImageToc[0] then
					processsightlangStaticImage[0]()
				end
				dxDrawImage(24 + w - 48, y, 48, 48, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 50 * p))
			end
			dxDrawImage(32, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, dynamicImage("files/icons/" .. spectatorValue[1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * p))
			dxDrawText(spectatorValue[2], 32 + fonts.valueFontH + 4, y, 0, y + 48, tocolor(255, 255, 255, 255 * p), fonts.value2FontScale, fonts.value2Font, "left", "center")
			if spectatorValueEquipped then
				if spectatorValue[7] then
					local ptw = dxGetTextWidth(spectatorValue[3], fonts.value2FontScale, fonts.value2Font) + 8
					sightlangStaticImageUsed[1] = true
					if sightlangStaticImageToc[1] then
						processsightlangStaticImage[1]()
					end
					dxDrawImage(24 + w - 8 - fonts.valueFontH - ptw, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255, 255 * p))
					dxDrawText(spectatorValue[3], 0, y, 24 + w - 8, y + 48, tocolor(255, 255, 255, 255 * p), fonts.value2FontScale, fonts.value2Font, "right", "center")
				else
					sightlangStaticImageUsed[1] = true
					if sightlangStaticImageToc[1] then
						processsightlangStaticImage[1]()
					end
					dxDrawImage(24 + w - 8 - fonts.valueFontH, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255, 255 * p))
				end
			else
				dxDrawText(spectatorValue[3], 0, y, 24 + w - 8, y + 48, tocolor(255, 255, 255, 255 * p), fonts.value2FontScale, fonts.value2Font, "right", "center")
			end
		end
		p = 1 - p
		if spectatorValueInterpolation[2] then
			local spectatorValue = spectatorValueInterpolation[2]
			local col = spectatorValue[4] and (spectatorValue[4] == "blue" and colors.blue or colors.purple) or colors.green
			dxDrawRectangle(24, y, w, 48, tocolor(col[1], col[2], col[3], 255 * p))
			if spectatorValue[4] then
				sightlangStaticImageUsed[0] = true
				if sightlangStaticImageToc[0] then
					processsightlangStaticImage[0]()
				end
				dxDrawImage(24 + w - 48, y, 48, 48, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 50 * p))
			end
			dxDrawImage(32, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, dynamicImage("files/icons/" .. spectatorValue[1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * p))
			dxDrawText(spectatorValue[2], 32 + fonts.valueFontH + 4, y, 0, y + 48, tocolor(255, 255, 255, 255 * p), fonts.value2FontScale, fonts.value2Font, "left", "center")
			if spectatorValueInterpolation[3] then
				if spectatorValue[7] then
					local ptw = dxGetTextWidth(spectatorValue[3], fonts.value2FontScale, fonts.value2Font) + 8
					sightlangStaticImageUsed[1] = true
					if sightlangStaticImageToc[1] then
						processsightlangStaticImage[1]()
					end
					dxDrawImage(24 + w - 8 - fonts.valueFontH - ptw, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255, 255 * p))
					dxDrawText(spectatorValue[3], 0, y, 24 + w - 8, y + 48, tocolor(255, 255, 255, 255 * p), fonts.value2FontScale, fonts.value2Font, "right", "center")
				else
					sightlangStaticImageUsed[1] = true
					if sightlangStaticImageToc[1] then
						processsightlangStaticImage[1]()
					end
					dxDrawImage(24 + w - 8 - fonts.valueFontH, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255, 255 * p))
				end
			else
				dxDrawText(spectatorValue[3], 0, y, 24 + w - 8, y + 48, tocolor(255, 255, 255, 255 * p), fonts.value2FontScale, fonts.value2Font, "right", "center")
			end
		end
		if p <= 0 then
			spectatorValueInterpolation = false
		end
	elseif spectatorValue then
		local col = spectatorValue[4] and (spectatorValue[4] == "blue" and colors.blue or colors.purple) or colors.green
		dxDrawRectangle(24, y, w, 48, tocolor(col[1], col[2], col[3]))
		if spectatorValue[4] then
			sightlangStaticImageUsed[0] = true
			if sightlangStaticImageToc[0] then
				processsightlangStaticImage[0]()
			end
			dxDrawImage(24 + w - 48, y, 48, 48, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 50))
		end
		dxDrawImage(32, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, dynamicImage("files/icons/" .. spectatorValue[1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255))
		dxDrawText(spectatorValue[2], 32 + fonts.valueFontH + 4, y, 0, y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "left", "center")
		if spectatorValueEquipped then
			if spectatorValue[7] then
				local ptw = dxGetTextWidth(spectatorValue[3], fonts.value2FontScale, fonts.value2Font) + 8
				sightlangStaticImageUsed[1] = true
				if sightlangStaticImageToc[1] then
					processsightlangStaticImage[1]()
				end
				dxDrawImage(24 + w - 8 - fonts.valueFontH - ptw, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
				dxDrawText(spectatorValue[3], 0, y, 24 + w - 8, y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "right", "center")
			else
				sightlangStaticImageUsed[1] = true
				if sightlangStaticImageToc[1] then
					processsightlangStaticImage[1]()
				end
				dxDrawImage(24 + w - 8 - fonts.valueFontH, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
			end
		else
			dxDrawText(spectatorValue[3], 0, y, 24 + w - 8, y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "right", "center")
		end
	end
end
local ppBalance = 0
addEvent("gotPremiumData", true)
addEventHandler("gotPremiumData", getRootElement(), function(balance)
	ppBalance = sightexports.sGui:thousandsStepper(balance)
end)
local charMoney = 0
addEvent("refreshMoney", true)
addEventHandler("refreshMoney", getRootElement(), function(amount)
	charMoney = sightexports.sGui:thousandsStepper(amount)
end)
function drawMoneyBar()
	local h = 64
	local tw = dxGetTextWidth(charMoney, fonts.headerFontScale, fonts.headerFont)
	local tw2 = dxGetTextWidth(ppBalance, fonts.headerFontScale, fonts.headerFont)
	local w = math.max(tw, tw2) + 16 + 24 + h / 2
	local x, y = screenX - 24 - w, 24
	dxDrawRectangle(x, y, w, h, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
	dxDrawRectangle(x, y + h / 2, w, h / 2, tocolor(colors.blue[1], colors.blue[2], colors.blue[3]))
	dxDrawImage(x + 4, y + 4, h / 2 - 8, h / 2 - 8, ":sGui/" .. cashIcon .. (faTicks[cashIcon] or ""))
	dxDrawImage(x + 4, y + h / 2 + 4, h / 2 - 8, h / 2 - 8, ":sGui/" .. ppIcon .. (faTicks[ppIcon] or ""))
	dxDrawText("$", x + w - 24, y, 0, y + h / 2, tocolor(255, 255, 255, 255), fonts.headerFontScale, fonts.headerFont, "left", "center")
	dxDrawText("PP", x + w - 24, y + h / 2, 0, y + h, tocolor(255, 255, 255, 255), fonts.headerFontScale, fonts.headerFont, "left", "center")
	dxDrawText(charMoney, 0, y, x + w - 8 - 24, y + h / 2, tocolor(255, 255, 255, 255), fonts.headerFontScale, fonts.headerFont, "right", "center")
	dxDrawText(ppBalance, 0, y + h / 2, x + w - 8 - 24, y + h, tocolor(255, 255, 255, 255), fonts.headerFontScale, fonts.headerFont, "right", "center")
end
local keyHelp = {
	spectator = {
		{"Q", "Kamera"},
		{"Z", "Zene"}
	},
	spectator_fc = {
		{"Q", "Kamera"},
		{"mrc", "Mozgatás"},
		{"mw", "Zoom"},
		{"Z", "Zene"}
	},
	main = {
		{"Q", "Kamera"},
		{"mrc", "Mozgatás"},
		{"mw", "Zoom"},
		{"Z", "Zene"},
		{
			"U",
			"Következő zene"
		},
		{
			"Backspace",
			"Kilépés a tuningból"
		},
		{
			"up",
			"down",
			"Navigálás"
		},
		{
			"Enter",
			"right",
			"Kiválasztás"
		}
	},
	menu = {
		{"Q", "Kamera"},
		{"mrc", "Mozgatás"},
		{"mw", "Zoom"},
		{"Z", "Zene"},
		{
			"U",
			"Következő zene"
		},
		{
			"Backspace",
			"left",
			"Visszalépés"
		},
		{
			"up",
			"down",
			"Navigálás"
		},
		{
			"Enter",
			"right",
			"Kiválasztás"
		}
	},
	value = {
		{"Q", "Kamera"},
		{"mrc", "Mozgatás"},
		{"mw", "Zoom"},
		{"Z", "Zene"},
		{
			"U",
			"Következő zene"
		},
		{
			"Backspace",
			"left",
			"Visszalépés"
		},
		{
			"up",
			"down",
			"Navigálás"
		},
		{
			"Enter",
			"right",
			"Beszerelés"
		}
	},
	buyPromptYes = {
		{"Q", "Kamera"},
		{"mrc", "Mozgatás"},
		{"mw", "Zoom"},
		{"Z", "Zene"},
		{
			"U",
			"Következő zene"
		},
		{
			"Backspace",
			"Visszalépés"
		},
		{
			"left",
			"right",
			"Igen/Nem"
		},
		{
			"Enter",
			"Megvásárlás"
		}
	},
	buyPromptNo = {
		{"Q", "Kamera"},
		{"mrc", "Mozgatás"},
		{"mw", "Zoom"},
		{"Z", "Zene"},
		{
			"U",
			"Következő zene"
		},
		{
			"Backspace",
			"Visszalépés"
		},
		{
			"left",
			"right",
			"Igen/Nem"
		},
		{"Enter", "Mégsem"}
	},
	adjusting = {
		{"Q", "Kamera"},
		{"mrc", "Mozgatás"},
		{"mw", "Zoom"},
		{"Z", "Zene"},
		{
			"U",
			"Következő zene"
		},
		{
			"Backspace",
			"Visszalépés"
		},
		{
			"left",
			"right",
			"Érték állítása"
		},
		{
			"up",
			"down",
			"Érték Kiválasztása"
		},
		{
			"Alt",
			"Beállítás kipróbálása"
		},
		{
			"Enter",
			"Beszerelés"
		}
	},
	picker = {
		{"Q", "Kamera"},
		{"mrc", "Mozgatás"},
		{"mw", "Zoom"},
		{"Z", "Zene"},
		{
			"U",
			"Következő zene"
		},
		{
			"backspace",
			"Visszalépés"
		},
		{
			"Enter",
			"Beszerelés"
		}
	}
}
function drawKeyHelp()
	local h = 32
	local x, y = 24, screenY - h - 24
	local c = "main"
	if not playerIsController then
		if freeCamMode then
			c = "spectator_fc"
		else
			c = "spectator"
		end
	elseif currentTextInput or colorPickerMode then
		c = "picker"
	elseif adjustingValue then
		c = "adjusting"
	elseif buyPrompt then
		c = buyPromptValue and "buyPromptYes" or "buyPromptNo"
	elseif activeValue then
		c = "value"
	elseif 0 < #previousMenus then
		c = "menu"
	end
	for i = 1, #keyHelp[c] do
		local n = #keyHelp[c][i]
		if keyHelp[c][i][1] ~= "mrc" and keyHelp[c][i][1] ~= "mw" or freeCamMode then
			for j = 1, n do
				local key = keyHelp[c][i][j]
				if j == n then
					local w = dxGetTextWidth(key, fonts.value2FontScale, fonts.value2Font) + 8 + 4
					if i < #keyHelp[c] then
						dxDrawRectangle(x, y, w + 8, h, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
						dxDrawText(key, x + 4, y, x + w, y + h, tocolor(255, 255, 255, 255), fonts.value2FontScale, fonts.value2Font, "center", "center")
						dxDrawRectangle(x + w + 4 - 1, y + 4, 2, h - 8, tocolor(colors.grey2[1], colors.grey2[2], colors.grey2[3]))
						x = x + w + 8
					else
						dxDrawRectangle(x, y, w + 4, h, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
						dxDrawText(key, x + 4, y, x + w, y + h, tocolor(255, 255, 255, 255), fonts.value2FontScale, fonts.value2Font, "center", "center")
					end
				else
					local tw = 0
					if key == "up" or key == "down" or key == "left" or key == "right" or key == "mrc" or key == "mw" then
						tw = h - 8
					else
						tw = dxGetTextWidth(key, fonts.keyFontScale, fonts.keyFont) + 8
					end
					local w = math.max(tw, h - 8)
					dxDrawRectangle(x, y, w + 8, h, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
					if key == "mrc" or key == "mw" then
						dxDrawImage(x + 4 + 2, y + 4 + 2, tw - 4, tw - 4, dynamicImage("files/" .. key .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255))
					elseif key == "up" or key == "down" or key == "left" or key == "right" then
						dxDrawRectangle(x + 4, y + 4, w, h - 8, tocolor(220, 220, 220))
						local r = 0
						if key == "right" then
							r = 90
						elseif key == "down" then
							r = 180
						elseif key == "left" then
							r = 270
						end
						dxDrawImage(x + 4 + 2, y + 4 + 2, tw - 4, tw - 4, ":sGui/" .. arrowIcon .. (faTicks[arrowIcon] or ""), r, 0, 0, tocolor(0, 0, 0, 255))
					else
						dxDrawRectangle(x + 4, y + 4, w, h - 8, tocolor(220, 220, 220))
						dxDrawText(key, x + 4, y, x + 4 + w, y + h, tocolor(0, 0, 0, 255), fonts.keyFontScale, fonts.keyFont, "center", "center")
					end
					x = x + w + 4
				end
			end
		end
	end
end
function renderTuning()
	if inPjEditorMode then
		drawMoneyBar()
		return
	end
	local now = getTickCount()
	local p = now % 1000 / 500
	if 1 < p then
		p = 2 - p
	end
	p = getEasingValue(p, "InOutQuad")
	dxSetShaderValue(shader, "outlineP", p * 0.25)
	if outlineColor == "lightgrey" then
		col = colors.lightgrey
	elseif outlineColor == "yellow" then
		col = colors.yellow
	elseif outlineColor == "purple" then
		col = colors.purple
	elseif outlineColor == "blue" then
		col = colors.blue
	else
		col = colors.green
	end
	dxSetShaderValue(shader, "outlineR", col[1] / 255 / 0.25)
	dxSetShaderValue(shader, "outlineG", col[2] / 255 / 0.25)
	dxSetShaderValue(shader, "outlineB", col[3] / 255 / 0.25)
	dxDrawImage(0, 0, screenX, screenY, renderTarget)
	if menuOpen then
		if not playerIsController then
			drawKeyHelp()
			renderSpectatorMode(now)
		else
			drawMoneyBar()
			drawKeyHelp()
			local ppBorderTime = 0
			local mp = 0
			if openingInterpolation then
				mp = (now - openingInterpolation[1]) / 750
				if 1 < mp then
					mp = 1
				end
				mp = getEasingValue(mp, "InOutQuad")
				h = openingInterpolation[2] + (openingInterpolation[3] - openingInterpolation[2]) * mp
			elseif closingInterpolation then
				mp = (now - closingInterpolation[1]) / 750
				if 1 < mp then
					mp = 1
				end
				mp = getEasingValue(1 - mp, "InOutQuad")
			end
			dxDrawRectangle(24, 24, w, h, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
			if closingInterpolation and closingInterpolation[2] then
				dxDrawText(currentTitle, 24, 24, 24 + w, 72, tocolor(255, 255, 255, 255 * mp), fonts.headerFontScale, fonts.headerFont, "center", "center")
			elseif openingInterpolation and openingInterpolation[4] then
				dxDrawText(currentTitle, 24, 24, 24 + w, 72, tocolor(255, 255, 255, 255 * mp), fonts.headerFontScale, fonts.headerFont, "center", "center")
			else
				dxDrawText(currentTitle, 24, 24, 24 + w, 24 + math.min(h, 48), tocolor(255, 255, 255, 255), fonts.headerFontScale, fonts.headerFont, "center", "center", true)
			end
			for i = 1, #menus do
				if closingInterpolation or openingInterpolation then
					dxDrawRectangle(36, 24 + 48 * i - 1, (w - 24) * mp, 1, tocolor(colors.grey2[1], colors.grey2[2], colors.grey2[3], 255))
				else
					dxDrawRectangle(36, 24 + 48 * i - 1, w - 24, 1, tocolor(colors.grey2[1], colors.grey2[2], colors.grey2[3]))
				end
			end
			local menuY = 0
			if closingInterpolation then
				if closingInterpolation[2] then
					dxDrawRectangle(24 - 4 * mp, 24 + 48 * activeMenu * mp, w + 8 * mp, 48, tocolor(colors.green[1], colors.green[2], colors.green[3], 255 * mp))
				else
					dxDrawRectangle(20, 24 + 48 * activeMenu, (w + 8) * mp, 48, tocolor(colors.green[1], colors.green[2], colors.green[3], 255))
				end
			elseif openingInterpolation then
				if openingInterpolation[4] then
					dxDrawRectangle(24 - 4 * mp, 24 + 48 * openingInterpolation[4] * mp, w + 8 * mp, 48, tocolor(colors.green[1], colors.green[2], colors.green[3], 255 * mp))
				else
					dxDrawRectangle(20, 24 + 48 * activeMenu, (w + 8) * mp, 48, tocolor(colors.green[1], colors.green[2], colors.green[3], 255))
				end
			elseif menuInterpolation then
				mp = (now - menuInterpolation[1]) / 300
				if 1 < mp then
					mp = 1
				end
				mp = getEasingValue(mp, "InOutQuad")
				menuY = 24 + 48 * (menuInterpolation[2] + (menuInterpolation[3] - menuInterpolation[2]) * mp)
				dxDrawRectangle(20, menuY, w + 8, 48, tocolor(colors.green[1], colors.green[2], colors.green[3]))
			elseif activeValue then
				dxDrawRectangle(20, 24 + 48 * activeMenu, w + 8, 48, tocolor(colors.grey2[1], colors.grey2[2], colors.grey2[3]))
			else
				dxDrawRectangle(20, 24 + 48 * activeMenu, w + 8, 48, tocolor(colors.green[1], colors.green[2], colors.green[3]))
			end
			if activeValue then
				local y = 24 + 48 * activeMenu
				local n = math.min(maximumValueNum + 1, #values + 1)
				if valueInterpolation then
					mp = (now - valueInterpolation[1]) / 200
					if 1 < mp then
						mp = 1
					end
					mp = getEasingValue(mp, "InOutQuad")
				end

				if currentMenu[activeMenu].tuningId == "wheelsettings" and adjustingValue then
					if getAdjustableValue("wheel.angle.front") then
						local frontAngle = getAdjustableValue("wheel.angle.front")
						local frontOffset = getAdjustableValue("wheel.offset.front")
						local frontWidth = getAdjustableValue("wheel.width.front")
						local front = getElementData(veh, "tuning.wheels.front") or {id=0, width=1, angle=0, color={255,255,255}, offset=0}
						setElementData(veh, "tuning.wheels.front", {id = front.id, width = frontWidth, angle = frontAngle, color = front.color, offset = frontOffset}, false)
					elseif getAdjustableValue("wheel.angle.back") then
						local frontAngle = getAdjustableValue("wheel.angle.back")
						local frontOffset = getAdjustableValue("wheel.offset.back")
						local frontWidth = getAdjustableValue("wheel.width.back")
						local front = getElementData(veh, "tuning.wheels.back") or {id=0, width=1, angle=0, color={255,255,255}, offset=0}
						setElementData(veh, "tuning.wheels.back", {id = front.id, width = frontWidth, angle = frontAngle, color = front.color, offset = frontOffset}, false)
					end
				end
				if valueCloseInterpolation then
					if valueCloseInterpolation[2] == 2 then
						mp = (now - valueCloseInterpolation[1]) / 500
						if #values == 1 then
							mp = 1
						end
						if 1 < mp then
							mp = 1
						end
						mp = getEasingValue(1 - mp, "InOutQuad")
						if valueScrollH then
							dxDrawRectangle(24 + w + 4 + w + 8, y, 4, 48 + 48 * (n - 2) * mp, tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3]))
							dxDrawRectangle(24 + w + 4 + w + 8, y + valueScroll * valueScrollH * mp, 4, valueScrollH * mp, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
						end
						dxDrawRectangle(24 + w + 4, y, w + 8, 48 * (1 + (n - 2) * mp), tocolor(colors.grey2[1], colors.grey2[2], colors.grey2[3]))
						for i = 1, n - 2 do
							dxDrawRectangle(24 + w + 4, y + (48 * i - 2) * mp, w + 8, 1, tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3]))
							dxDrawRectangle(24 + w + 4, y + (48 * i - 1) * mp, w + 8, 1, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
						end
					end
				elseif valueOpenInterpolation then
					if valueOpenInterpolation[2] == 2 then
						mp = (now - valueOpenInterpolation[1]) / 500
						if #values == 1 then
							mp = 1
						end
						if 1 < mp then
							mp = 1
						end
						mp = getEasingValue(mp, "InOutQuad")
						if valueScrollH then
							dxDrawRectangle(24 + w + 4 + w + 8, y, 4, 48 + 48 * (n - 2) * mp, tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3]))
							dxDrawRectangle(24 + w + 4 + w + 8, y + valueScroll * valueScrollH * mp, 4, valueScrollH * mp, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
						end
						dxDrawRectangle(24 + w + 4, y, w + 8, 48 * (1 + (n - 2) * mp), tocolor(colors.grey2[1], colors.grey2[2], colors.grey2[3]))
						for i = 1, n - 2 do
							dxDrawRectangle(24 + w + 4, y + (48 * i - 2) * mp, w + 8, 1, tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3]))
							dxDrawRectangle(24 + w + 4, y + (48 * i - 1) * mp, w + 8, 1, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
						end
					end
				else
					dxDrawRectangle(24 + w + 4, y, w + 8, 48 * (n - 1), tocolor(colors.grey2[1], colors.grey2[2], colors.grey2[3]))
					if valueInterpolation and valueInterpolation[4] then
						if valueScrollH then
							dxDrawRectangle(24 + w + 4 + w + 8, y, 4, 48 * (n - 1), tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3]))
							dxDrawRectangle(24 + w + 4 + w + 8, y + (valueInterpolation[4] + (valueInterpolation[5] - valueInterpolation[4]) * mp) * valueScrollH, 4, valueScrollH, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
						end
						if valueInterpolation[4] < valueInterpolation[5] then
							for i = 1, n - 1 do
								local ly = y + 48 * i - 48 * mp
								if y <= ly - 2 then
									dxDrawRectangle(24 + w + 4, ly - 2, w + 8, 1, tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3]))
								end
								if y <= ly - 1 then
									dxDrawRectangle(24 + w + 4, ly - 1, w + 8, 1, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
								end
							end
						else
							for i = 1, n - 2 do
								local ly = y + 48 * i + 48 * mp
								dxDrawRectangle(24 + w + 4, ly - 2, w + 8, 1, tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3]))
								dxDrawRectangle(24 + w + 4, ly - 1, w + 8, 1, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
							end
						end
					else
						if valueScrollH then
							dxDrawRectangle(24 + w + 4 + w + 8, y, 4, 48 * (n - 1), tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3]))
							dxDrawRectangle(24 + w + 4 + w + 8, y + valueScroll * valueScrollH, 4, valueScrollH, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
						end
						for i = 1, n - 2 do
							dxDrawRectangle(24 + w + 4, y + 48 * i - 2, w + 8, 1, tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3]))
							dxDrawRectangle(24 + w + 4, y + 48 * i - 1, w + 8, 1, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
						end
					end
				end
				local menuX = 24 + w + 4
				if valueCloseInterpolation then
					if valueCloseInterpolation[2] == 1 then
						mp = (now - valueCloseInterpolation[1]) / 750
						if 1 < mp then
							mp = 1
						end
						mp = getEasingValue(1 - mp, "InOutQuad")
						local col = colors.green
						if values[activeValue][4] == "blue" then
							col = {
								colors.green[1] + (colors.blue[1] - colors.green[1]) * mp,
								colors.green[2] + (colors.blue[2] - colors.green[2]) * mp,
								colors.green[3] + (colors.blue[3] - colors.green[3]) * mp
							}
						elseif values[activeValue][4] == "purple" then
							col = {
								colors.green[1] + (colors.purple[1] - colors.green[1]) * mp,
								colors.green[2] + (colors.purple[2] - colors.green[2]) * mp,
								colors.green[3] + (colors.purple[3] - colors.green[3]) * mp
							}
						end
						if valueScrollH then
							dxDrawRectangle(20 + (w + 8 + 4) * mp, 24 + 48 * activeMenu, w + 8, 48, tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3]))
						end
						dxDrawRectangle(20 + (w + 8) * mp, 24 + 48 * activeMenu, w + 8, 48, tocolor(col[1], col[2], col[3]))
						menuX = 20 + (w + 8) * mp + w + 8
					end
				elseif valueOpenInterpolation then
					if valueOpenInterpolation[2] == 1 then
						mp = (now - valueOpenInterpolation[1]) / 750
						if 1 < mp then
							mp = 1
						end
						mp = getEasingValue(mp, "InOutQuad")
						local col = colors.green
						if values[activeValue][4] == "blue" then
							col = {
								colors.green[1] + (colors.blue[1] - colors.green[1]) * mp,
								colors.green[2] + (colors.blue[2] - colors.green[2]) * mp,
								colors.green[3] + (colors.blue[3] - colors.green[3]) * mp
							}
						elseif values[activeValue][4] == "purple" then
							col = {
								colors.green[1] + (colors.purple[1] - colors.green[1]) * mp,
								colors.green[2] + (colors.purple[2] - colors.green[2]) * mp,
								colors.green[3] + (colors.purple[3] - colors.green[3]) * mp
							}
						end
						if valueScrollH then
							dxDrawRectangle(20 + (w + 8 + 4) * mp, 24 + 48 * activeMenu, w + 8, 48, tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3]))
						end
						dxDrawRectangle(20 + (w + 8) * mp, 24 + 48 * activeMenu, w + 8, 48, tocolor(col[1], col[2], col[3]))
						menuX = 20 + (w + 8) * mp + w + 8
					end
				elseif valueInterpolation then
					local col = colors.green
					if values[valueInterpolation[2]][4] and values[valueInterpolation[3]][4] then
						if values[valueInterpolation[2]][4] == values[valueInterpolation[3]][4] then
							col = colors.blue
						else
							local c1 = values[valueInterpolation[2]][4] == "blue" and colors.blue or colors.purple
							local c2 = values[valueInterpolation[3]][4] == "blue" and colors.blue or colors.purple
							col = {
								c1[1] + (c2[1] - c1[1]) * mp,
								c1[2] + (c2[2] - c1[2]) * mp,
								c1[3] + (c2[3] - c1[3]) * mp
							}
						end
					elseif values[valueInterpolation[2]][4] then
						local c = values[valueInterpolation[2]][4] == "blue" and colors.blue or colors.purple
						col = {
							c[1] + (colors.green[1] - c[1]) * mp,
							c[2] + (colors.green[2] - c[2]) * mp,
							c[3] + (colors.green[3] - c[3]) * mp
						}
					elseif values[valueInterpolation[3]][4] then
						local c = values[valueInterpolation[3]][4] == "blue" and colors.blue or colors.purple
						col = {
							colors.green[1] + (c[1] - colors.green[1]) * mp,
							colors.green[2] + (c[2] - colors.green[2]) * mp,
							colors.green[3] + (c[3] - colors.green[3]) * mp
						}
					end
					if valueInterpolation[4] then
						dxDrawRectangle(24 + w + 4, 24 + 48 * (activeMenu + activeValue - valueScroll - 1), w + 8, 48, tocolor(col[1], col[2], col[3]))
					else
						dxDrawRectangle(24 + w + 4, 24 + 48 * (activeMenu + (valueInterpolation[2] + (valueInterpolation[3] - valueInterpolation[2]) * mp) - valueScroll - 1), w + 8, 48, tocolor(col[1], col[2], col[3]))
					end
				else
					local vx, vy, vsx, vsy = 24 + w + 4, 24 + 48 * (activeMenu + activeValue - valueScroll - 1), w + 8, 48
					if adjustingValue and values[activeValue][6] then
						local x = 24 + w + 4 + 8
						mp = 1
						if adjustingInterpolation and (adjustingInterpolation[2] == 2 or adjustingInterpolation[2] == 3) then
							mp = (now - adjustingInterpolation[1]) / 750
							if 1 < mp then
								mp = 1
							end
							if adjustingInterpolation[2] == 3 then
								mp = 1 - mp
							end
							mp = getEasingValue(mp, "InOutQuad")
							x = x + w
						elseif adjustingInterpolation and (adjustingInterpolation[2] == 1 or adjustingInterpolation[2] == 4) then
							mp = (now - adjustingInterpolation[1]) / 750
							if 1 < mp then
								mp = 1
							end
							if adjustingInterpolation[2] == 4 then
								mp = 1 - mp
							end
							mp = getEasingValue(mp, "InOutQuad")
							x = x + w * mp
						else
							x = x + w
						end
						local y = 24 + 48 * (activeMenu + activeValue - valueScroll - 1)
						if adjustingInterpolation and (adjustingInterpolation[2] == 1 or adjustingInterpolation[2] == 4) then
							local tx = x + 8 + (w - 24 - 16 - 24) * ((adjustableValues[1] - values[activeValue][6][1][3]) / (values[activeValue][6][1][4] - values[activeValue][6][1][3]))
							vx = vx + (tx - vx) * mp
							vy = vy + (y + 24 + 6 - 5 - vy) * mp
							vsx = vsx + (24 - vsx) * mp
							vsy = vsy + (10 - vsy) * mp
						else
							local yp = 0
							if adjustingInterpolation and adjustingInterpolation[2] == 5 then
								mp = (now - adjustingInterpolation[1]) / 150
								if 1 < mp then
									mp = 1
								end
								mp = getEasingValue(mp, "InOutQuad")
								local val = adjustingInterpolation[3] + (adjustingInterpolation[4] - adjustingInterpolation[3]) * mp
								yp = 48 * (val - 1)
								local tx1 = x + 8 + (w - 24 - 16 - 24) * ((adjustableValues[adjustingInterpolation[3]] - values[activeValue][6][adjustingInterpolation[3]][3]) / (values[activeValue][6][adjustingInterpolation[3]][4] - values[activeValue][6][adjustingInterpolation[3]][3]))
								local tx2 = x + 8 + (w - 24 - 16 - 24) * ((adjustableValues[adjustingInterpolation[4]] - values[activeValue][6][adjustingInterpolation[4]][3]) / (values[activeValue][6][adjustingInterpolation[4]][4] - values[activeValue][6][adjustingInterpolation[4]][3]))
								vx = tx1 + (tx2 - tx1) * mp
							else
								yp = 48 * (selectedAdjustValue - 1)
								if adjustingInterpolation and adjustingInterpolation[2] == 6 then
									mp = (now - adjustingInterpolation[1]) / 150
									if 1 < mp then
										mp = 1
									end
									local val = adjustingInterpolation[3] + (adjustingInterpolation[4] - adjustingInterpolation[3]) * mp
									local tx = x + 8 + (w - 24 - 16 - 24) * ((val - values[activeValue][6][selectedAdjustValue][3]) / (values[activeValue][6][selectedAdjustValue][4] - values[activeValue][6][selectedAdjustValue][3]))
									vx = tx
								else
									local tx = x + 8 + (w - 24 - 16 - 24) * ((adjustableValues[selectedAdjustValue] - values[activeValue][6][selectedAdjustValue][3]) / (values[activeValue][6][selectedAdjustValue][4] - values[activeValue][6][selectedAdjustValue][3]))
									vx = tx
								end
							end
							if adjustingInterpolation and (adjustingInterpolation[2] == 2 or adjustingInterpolation[2] == 3) then
								local tx1 = x + 8 + (w - 24 - 16 - 24) * ((adjustableValues[1] - values[activeValue][6][1][3]) / (values[activeValue][6][1][4] - values[activeValue][6][1][3]))
								local tx2 = x + 8 + (w - 24 - 16 - 24) * ((adjustableValues[selectedAdjustValue] - values[activeValue][6][selectedAdjustValue][3]) / (values[activeValue][6][selectedAdjustValue][4] - values[activeValue][6][selectedAdjustValue][3]))
								vy = y + yp * mp + 24 + 6 - 5
								vx = tx1 + (tx2 - tx1) * mp
							else
								vy = y + yp + 24 + 6 - 5
							end
							vsx = 24
							vsy = 10
						end
						if not adjustingInterpolation or adjustingInterpolation[2] > 4 then
							dxDrawRectangle(x, y, w - 24, 48 * #values[activeValue][6], tocolor(colors.grey2[1], colors.grey2[2], colors.grey2[3]))
						end
						for j = #values[activeValue][6], 1, -1 do
							local y = y
							if adjustingInterpolation and (adjustingInterpolation[2] == 2 or adjustingInterpolation[2] == 3) then
								y = y + 48 * (j - 1) * mp
							elseif not adjustingInterpolation or adjustingInterpolation[2] ~= 1 and adjustingInterpolation[2] ~= 4 then
								y = y + 48 * (j - 1)
							end
							if adjustingInterpolation and adjustingInterpolation[2] <= 4 then
								dxDrawRectangle(x, y, w - 24, 48, tocolor(colors.grey2[1], colors.grey2[2], colors.grey2[3]))
							end
							if j < #values[activeValue][6] then
								if adjustingInterpolation and (adjustingInterpolation[2] == 1 or adjustingInterpolation[2] == 4) then
									dxDrawRectangle(x, y + 48 - 1, w - 24, 1, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3], 255 * mp))
									dxDrawRectangle(x, y + 48, w - 24, 1, tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3], 255 * mp))
								else
									dxDrawRectangle(x, y + 48 - 1, w - 24, 1, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
									dxDrawRectangle(x, y + 48, w - 24, 1, tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3]))
								end
							end
							dxDrawText(values[activeValue][6][j][1], x + 8, y + 4, 0, y + 24, tocolor(255, 255, 255), fonts.value2FontScale * 0.9, fonts.value2Font, "left", "center")
							dxDrawText(math.floor(adjustableValues[j] * 100) / 100, 0, y + 4, x + w - 24 - 8, y + 24, tocolor(colors.lightgrey[1], colors.lightgrey[2], colors.lightgrey[3], 255), fonts.value2FontScale * 0.9, fonts.value2Font, "right", "center")
							dxDrawRectangle(x + 8, y + 24 + 6 - 2, w - 24 - 16, 4, tocolor(colors.grey1[1], colors.grey1[2], colors.grey1[3]))
							if j == selectedAdjustValue and adjustingInterpolation and adjustingInterpolation[2] == 6 then
								dxDrawRectangle(vx, y + 24 + 6 - 5, 24, 10, tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3]))
							else
								local tx = x + 8 + (w - 24 - 16 - 24) * ((adjustableValues[j] - values[activeValue][6][j][3]) / (values[activeValue][6][j][4] - values[activeValue][6][j][3]))
								dxDrawRectangle(tx, y + 24 + 6 - 5, 24, 10, tocolor(colors.grey3[1], colors.grey3[2], colors.grey3[3]))
							end
						end
						if adjustingInterpolation and adjustingInterpolation[2] == 1 then
							dxDrawRectangle(24 + w + 4, 24 + 48 * (activeMenu + activeValue - valueScroll - 1), w + 8, 48, tocolor(colors.grey2[1], colors.grey2[2], colors.grey2[3]))
						end
					end
					if buyPrompt then
						mp = 1
						local alpha = 255
						local pbar = 0
						if buyPromptAnimation then
							local t = 750
							if buyPromptAnimation[2] == 4 then
								mp = 1
								local p = (now - buyPromptAnimation[1]) / 200
								if 1 < p then
									p = 1
									pbar = (now - (buyPromptAnimation[1] + 200)) / 2100
								end
								if 1 < pbar then
									pbar = 1
									mp = 1 - (now - (buyPromptAnimation[1] + 200 + 2100)) / t
									if mp < 0 then
										mp = 0
									end
									mp = getEasingValue(mp, "InOutQuad")
								end
								alpha = 255 * (1 - p)
							else
								if buyPromptAnimation[2] == 3 then
									t = 200
								end
								mp = (now - buyPromptAnimation[1]) / t
								if 1 < mp then
									mp = 1
								end
								if buyPromptAnimation[2] == 2 then
									mp = 1 - mp
								end
								mp = getEasingValue(mp, "InOutQuad")
							end
						end
						local x = 24 + w + 4 + 8
						if buyPromptAnimation and buyPromptAnimation[2] == 3 then
							x = x + w
						else
							x = x + w * mp
						end
						local y = 24 + 48 * (activeMenu + activeValue - valueScroll - 1)
						dxDrawRectangle(x, y, w - 24, 48, tocolor(colors.grey2[1], colors.grey2[2], colors.grey2[3]))
						if buyPromptAnimation and buyPromptAnimation[2] == 3 then
							if buyPromptValue then
								local col1 = {
									colors.red[1] + (colors.green[1] - colors.red[1]) * mp,
									colors.red[2] + (colors.green[2] - colors.red[2]) * mp,
									colors.red[3] + (colors.green[3] - colors.red[3]) * mp
								}
								local col2 = {
									colors.green[1] + (255 - colors.green[1]) * mp,
									colors.green[2] + (255 - colors.green[2]) * mp,
									colors.green[3] + (255 - colors.green[3]) * mp
								}
								local col3 = {
									255 + (colors.red[1] - 255) * mp,
									255 + (colors.red[2] - 255) * mp,
									255 + (colors.red[3] - 255) * mp
								}
								dxDrawRectangle(x + w - 24 - 48 - 48 * mp, y, 48, 48, tocolor(col1[1], col1[2], col1[3]))
								dxDrawImage(x + w - 24 - 48 + 24 - 16, y + 24 - 16, 32, 32, ":sGui/" .. noIcon .. (faTicks[noIcon] or ""), 0, 0, 0, tocolor(col3[1], col3[2], col3[3]))
								dxDrawImage(x + w - 24 - 96 + 24 - 16, y + 24 - 16, 32, 32, ":sGui/" .. yesIcon .. (faTicks[yesIcon] or ""), 0, 0, 0, tocolor(col2[1], col2[2], col2[3]))
							else
								local col1 = {
									colors.green[1] + (colors.red[1] - colors.green[1]) * mp,
									colors.green[2] + (colors.red[2] - colors.green[2]) * mp,
									colors.green[3] + (colors.red[3] - colors.green[3]) * mp
								}
								local col2 = {
									colors.red[1] + (255 - colors.red[1]) * mp,
									colors.red[2] + (255 - colors.red[2]) * mp,
									colors.red[3] + (255 - colors.red[3]) * mp
								}
								local col3 = {
									255 + (colors.green[1] - 255) * mp,
									255 + (colors.green[2] - 255) * mp,
									255 + (colors.green[3] - 255) * mp
								}
								dxDrawRectangle(x + w - 24 - 48 - 48 * (1 - mp), y, 48, 48, tocolor(col1[1], col1[2], col1[3]))
								dxDrawImage(x + w - 24 - 48 + 24 - 16, y + 24 - 16, 32, 32, ":sGui/" .. noIcon .. (faTicks[noIcon] or ""), 0, 0, 0, tocolor(col2[1], col2[2], col2[3]))
								dxDrawImage(x + w - 24 - 96 + 24 - 16, y + 24 - 16, 32, 32, ":sGui/" .. yesIcon .. (faTicks[yesIcon] or ""), 0, 0, 0, tocolor(col3[1], col3[2], col3[3]))
							end
						elseif buyPromptValue then
							dxDrawRectangle(x + w - 24 - 96, y, 48, 48, tocolor(colors.green[1], colors.green[2], colors.green[3], alpha))
							dxDrawImage(x + w - 24 - 48 + 24 - 16, y + 24 - 16, 32, 32, ":sGui/" .. noIcon .. (faTicks[noIcon] or ""), 0, 0, 0, tocolor(colors.red[1], colors.red[2], colors.red[3], alpha))
							dxDrawImage(x + w - 24 - 96 + 24 - 16, y + 24 - 16, 32, 32, ":sGui/" .. yesIcon .. (faTicks[yesIcon] or ""), 0, 0, 0, tocolor(255, 255, 255, alpha))
						else
							dxDrawRectangle(x + w - 24 - 48, y, 48, 48, tocolor(colors.red[1], colors.red[2], colors.red[3], alpha))
							dxDrawImage(x + w - 24 - 48 + 24 - 16, y + 24 - 16, 32, 32, ":sGui/" .. noIcon .. (faTicks[noIcon] or ""), 0, 0, 0, tocolor(255, 255, 255, alpha))
							dxDrawImage(x + w - 24 - 96 + 24 - 16, y + 24 - 16, 32, 32, ":sGui/" .. yesIcon .. (faTicks[yesIcon] or ""), 0, 0, 0, tocolor(colors.green[1], colors.green[2], colors.green[3], alpha))
						end
						dxDrawText("Biztosan szeretnéd\nbeszerelni?", x + 8, y, 0, y + 48, tocolor(255, 255, 255, alpha), fonts.value2FontScale, fonts.value2Font, "left", "center")
						if buyPromptAnimation and buyPromptAnimation[2] == 4 then
							dxDrawRectangle(x, y, (w - 24) * pbar, 48, tocolor(colors.green[1], colors.green[2], colors.green[3], 255 - alpha))
							dxDrawText("Beszerelés...", x + 8, y, x + w - 24, y + 48, tocolor(255, 255, 255, 255 - alpha), fonts.value2FontScale, fonts.value2Font, "center", "center")
						end
					end
					local col = values[activeValue][4] and (values[activeValue][4] == "blue" and colors.blue or colors.purple) or colors.green
					dxDrawRectangle(vx, vy, vsx, vsy, tocolor(col[1], col[2], col[3]))
				end
				for i = n, 1, -1 do
					if i == n then
						if valueInterpolation and valueInterpolation[4] then
							if valueInterpolation[4] < valueInterpolation[5] then
								local ty = y
								local y = y - 48 + 48 * (1 - mp)
								if values[valueScroll][4] then
									local iy = y
									local ih = math.max(0, math.min(48, iy + 48 - ty))
									local col = values[valueScroll][4] == "blue" and colors.blue or colors.purple
									sightlangStaticImageUsed[0] = true
									if sightlangStaticImageToc[0] then
										processsightlangStaticImage[0]()
									end
									dxDrawImageSection(24 + w + 4 + 8 + w - 48, math.max(ty, iy), 48, ih, 0, 48 - ih, 48, ih, sightlangStaticImage[0], 0, 0, 0, tocolor(col[1], col[2], col[3], 110))
								end
								local iy = y + 24 - fonts.valueFontH / 2
								local ih = math.max(0, math.min(fonts.valueFontH, iy + fonts.valueFontH - ty))
								dxDrawImageSection(24 + w + 4 + 8, math.max(ty, iy), fonts.valueFontH, ih, 0, 32 - ih / fonts.valueFontH * 32, 32, ih / fonts.valueFontH * 32, dynamicImage("files/icons/" .. values[valueScroll][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 175))
								dxDrawText(values[valueScroll][2], 24 + w + 4 + 8 + fonts.valueFontH + 4, ty, screenX, y + 24 + fonts.valueFontH / 2, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "left", "bottom", true)
								if equippedValue == valueScroll then
									local col = values[activeValue][4] and (values[activeValue][4] == "blue" and colors.blue or colors.purple) or colors.green
									if values[valueScroll][7] then
										local ptw = dxGetTextWidth(values[valueScroll][3], fonts.valueFontScale, fonts.valueFont) + 8
										sightlangStaticImageUsed[1] = true
										if sightlangStaticImageToc[1] then
											processsightlangStaticImage[1]()
										end
										dxDrawImageSection(24 + w + 4 + w - fonts.valueFontH - ptw, math.max(ty, iy), fonts.valueFontH, ih, 0, 24 - ih / fonts.valueFontH * 24, 24, ih / fonts.valueFontH * 24, sightlangStaticImage[1], 0, 0, 0, tocolor(col[1], col[2], col[3]))
										dxDrawText(values[valueScroll][3], 0, ty, 24 + w + 4 + w, y + 24 + fonts.valueFontH / 2, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "right", "bottom", true)
									else
										sightlangStaticImageUsed[1] = true
										if sightlangStaticImageToc[1] then
											processsightlangStaticImage[1]()
										end
										dxDrawImageSection(24 + w + 4 + w - fonts.valueFontH, math.max(ty, iy), fonts.valueFontH, ih, 0, 24 - ih / fonts.valueFontH * 24, 24, ih / fonts.valueFontH * 24, sightlangStaticImage[1], 0, 0, 0, tocolor(col[1], col[2], col[3]))
									end
								else
									dxDrawText(values[valueScroll][3], 0, ty, 24 + w + 4 + w, y + 24 + fonts.valueFontH / 2, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "right", "bottom", true)
								end
							else
								local y = y + 48 * n - 48 * (2 - mp)
								local by = y + 48 * (1 - mp)
								local iy = y
								local ih = math.max(0, math.min(48, by - iy))
								if values[valueScroll + n][4] then
									local col = values[valueScroll + n][4] == "blue" and colors.blue or colors.purple
									sightlangStaticImageUsed[0] = true
									if sightlangStaticImageToc[0] then
										processsightlangStaticImage[0]()
									end
									dxDrawImageSection(24 + w + 4 + 8 + w - 48, iy, 48, ih, 0, 0, 48, ih, sightlangStaticImage[0], 0, 0, 0, tocolor(col[1], col[2], col[3], 110))
								end
								local iy = y + 24 - fonts.valueFontH / 2
								local ih = math.max(0, math.min(fonts.valueFontH, by - iy))
								dxDrawImageSection(24 + w + 4 + 8, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, ih, 0, 0, 32, ih / fonts.valueFontH * 32, dynamicImage("files/icons/" .. values[valueScroll + n][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 175))
								dxDrawText(values[valueScroll + n][2], 24 + w + 4 + 8 + fonts.valueFontH + 4, y + 24 - fonts.valueFontH / 2, screenX, by, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "left", "top", true)
								if equippedValue == valueScroll + n then
									local col = values[valueScroll + n][4] and (values[valueScroll + n][4] == "blue" and colors.blue or colors.purple) or colors.green
									if values[valueScroll + n][7] then
										local ptw = dxGetTextWidth(values[valueScroll + n][3], fonts.valueFontScale, fonts.valueFont) + 8
										sightlangStaticImageUsed[1] = true
										if sightlangStaticImageToc[1] then
											processsightlangStaticImage[1]()
										end
										dxDrawImageSection(24 + w + 4 + w - fonts.valueFontH - ptw, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, ih, 0, 0, 24, ih / fonts.valueFontH * 24, sightlangStaticImage[1], 0, 0, 0, tocolor(col[1], col[2], col[3]))
										dxDrawText(values[valueScroll + n][3], 0, y + 24 - fonts.valueFontH / 2, 24 + w + 4 + w, by, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "right", "top", true)
									else
										sightlangStaticImageUsed[1] = true
										if sightlangStaticImageToc[1] then
											processsightlangStaticImage[1]()
										end
										dxDrawImageSection(24 + w + 4 + w - fonts.valueFontH, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, ih, 0, 0, 24, ih / fonts.valueFontH * 24, sightlangStaticImage[1], 0, 0, 0, tocolor(col[1], col[2], col[3]))
									end
								else
									dxDrawText(values[valueScroll + n][3], 0, y + 24 - fonts.valueFontH / 2, 24 + w + 4 + w, by, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "right", "top", true)
								end
							end
						end
					elseif valueCloseInterpolation then
						if i + valueScroll == activeValue then
							if valueCloseInterpolation[2] == 1 then
								if values[i + valueScroll][4] then
									local x = 24 + w + 4 + 8 + w - 48
									local iw = math.max(0, math.min(48, menuX - x))
									sightlangStaticImageUsed[0] = true
									if sightlangStaticImageToc[0] then
										processsightlangStaticImage[0]()
									end
									dxDrawImageSection(x, y, iw, 48, 0, 0, iw, 48, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 50))
								end
								local x = 24 + w + 4 + 8
								local iw = math.max(0, math.min(fonts.valueFontH, menuX - x))
								dxDrawImageSection(x, y + 24 - fonts.valueFontH / 2, iw, fonts.valueFontH, 0, 0, iw / fonts.valueFontH * 32, 32, dynamicImage("files/icons/" .. values[i + valueScroll][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255))
								local x = 24 + w + 4 + 8 + fonts.valueFontH + 4
								dxDrawText(values[i + valueScroll][2], x, y, math.max(menuX, x), y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "left", "center", true)
								local tw = dxGetTextWidth(values[i + valueScroll][3], fonts.value2FontScale, fonts.value2Font)
								if equippedValue == i + valueScroll then
									local x = 24 + w + 4 + w - fonts.valueFontH
									if values[i + valueScroll][7] then
										local ptw = dxGetTextWidth(values[i + valueScroll][3], fonts.value2FontScale, fonts.value2Font) + 8
										x = x - ptw
										dxDrawText(values[i + valueScroll][3], 24 + w + 4 + w - tw, y, math.max(menuX, x), y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "left", "center", true)
									end
									local w = math.max(0, math.min(fonts.valueFontH, menuX - x))
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImageSection(x, y + 24 - fonts.valueFontH / 2, w, fonts.valueFontH, 0, 0, w / fonts.valueFontH * 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
								else
									dxDrawText(values[i + valueScroll][3], 24 + w + 4 + w - tw, y, math.max(menuX, x), y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "left", "center", true)
								end
							end
						elseif valueCloseInterpolation[2] == 2 then
							local y = y + 48 * (i - 1) * mp
							if values[i + valueScroll][4] then
								local col = values[i + valueScroll][4] and (values[i + valueScroll][4] == "blue" and colors.blue or colors.purple) or colors.green
								sightlangStaticImageUsed[0] = true
								if sightlangStaticImageToc[0] then
									processsightlangStaticImage[0]()
								end
								dxDrawImage(24 + w + 4 + 8 + w - 48, y, 48, 48, sightlangStaticImage[0], 0, 0, 0, tocolor(col[1], col[2], col[3], 110))
							end
							dxDrawImage(24 + w + 4 + 8, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, dynamicImage("files/icons/" .. values[i + valueScroll][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 175))
							dxDrawText(values[i + valueScroll][2], 24 + w + 4 + 8 + fonts.valueFontH + 4, y, 0, y + 48, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "left", "center")
							if equippedValue == i + valueScroll then
								local col = values[i + valueScroll][4] and (values[i + valueScroll][4] == "blue" and colors.blue or colors.purple) or colors.green
								if values[i + valueScroll][7] then
									local ptw = dxGetTextWidth(values[i + valueScroll][3], fonts.valueFontScale, fonts.valueFont) + 8
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImage(24 + w + 4 + w - fonts.valueFontH - ptw, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(col[1], col[2], col[3]))
									dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "right", "center")
								else
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImage(24 + w + 4 + w - fonts.valueFontH, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(col[1], col[2], col[3]))
								end
							else
								dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "right", "center")
							end
						end
					elseif valueOpenInterpolation then
						if i + valueScroll == activeValue then
							local y = y + 48 * (i - 1)
							if valueOpenInterpolation[2] == 1 then
								if values[i + valueScroll][4] then
									local x = 24 + w + 4 + 8 + w - 48
									local iw = math.max(0, math.min(48, menuX - x))
									sightlangStaticImageUsed[0] = true
									if sightlangStaticImageToc[0] then
										processsightlangStaticImage[0]()
									end
									dxDrawImageSection(x, y, iw, 48, 0, 0, iw, 48, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 50))
								end
								local x = 24 + w + 4 + 8
								local iw = math.max(0, math.min(fonts.valueFontH, menuX - x))
								dxDrawImageSection(x, y + 24 - fonts.valueFontH / 2, iw, fonts.valueFontH, 0, 0, iw / fonts.valueFontH * 32, 32, dynamicImage("files/icons/" .. values[i + valueScroll][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255))
								local x = 24 + w + 4 + 8 + fonts.valueFontH + 4
								dxDrawText(values[i + valueScroll][2], x, y, math.max(menuX, x), y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "left", "center", true)
								local tw = dxGetTextWidth(values[i + valueScroll][3], fonts.value2FontScale, fonts.value2Font)
								if equippedValue == i + valueScroll then
									local x = 24 + w + 4 + w - fonts.valueFontH
									if values[i + valueScroll][7] then
										local ptw = dxGetTextWidth(values[i + valueScroll][3], fonts.value2FontScale, fonts.value2Font) + 8
										x = x - ptw
										dxDrawText(values[i + valueScroll][3], 24 + w + 4 + w - tw, y, math.max(menuX, x), y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "left", "center", true)
									end
									local iw = math.max(0, math.min(fonts.valueFontH, menuX - x))
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImageSection(x, y + 24 - fonts.valueFontH / 2, iw, fonts.valueFontH, 0, 0, iw / fonts.valueFontH * 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
								else
									dxDrawText(values[i + valueScroll][3], 24 + w + 4 + w - tw, y, math.max(menuX, x), y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "left", "center", true)
								end
							else
								local col = values[activeValue][4] and (values[activeValue][4] == "blue" and colors.blue or colors.purple) or colors.green
								dxDrawRectangle(24 + w + 4, 24 + 48 * (activeMenu + activeValue - 1), w + 8, 48, tocolor(col[1], col[2], col[3]))
								if values[i + valueScroll][4] then
									sightlangStaticImageUsed[0] = true
									if sightlangStaticImageToc[0] then
										processsightlangStaticImage[0]()
									end
									dxDrawImage(24 + w + 4 + 8 + w - 48, y, 48, 48, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 50))
								end
								dxDrawImage(24 + w + 4 + 8, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, dynamicImage("files/icons/" .. values[i + valueScroll][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255))
								dxDrawText(values[i + valueScroll][2], 24 + w + 4 + 8 + fonts.valueFontH + 4, y, 0, y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "left", "center")
								if equippedValue == i + valueScroll then
									if values[i + valueScroll][7] then
										local ptw = dxGetTextWidth(values[i + valueScroll][3], fonts.value2FontScale, fonts.value2Font) + 8
										sightlangStaticImageUsed[1] = true
										if sightlangStaticImageToc[1] then
											processsightlangStaticImage[1]()
										end
										dxDrawImage(24 + w + 4 + w - fonts.valueFontH - ptw, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
										dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "right", "center")
									else
										sightlangStaticImageUsed[1] = true
										if sightlangStaticImageToc[1] then
											processsightlangStaticImage[1]()
										end
										dxDrawImage(24 + w + 4 + w - fonts.valueFontH, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
									end
								else
									dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "right", "center")
								end
							end
						elseif valueOpenInterpolation[2] == 2 then
							local y = y + 48 * (i - 1) * mp
							if values[i + valueScroll][4] then
								local col = values[i + valueScroll][4] and (values[i + valueScroll][4] == "blue" and colors.blue or colors.purple) or colors.green
								sightlangStaticImageUsed[0] = true
								if sightlangStaticImageToc[0] then
									processsightlangStaticImage[0]()
								end
								dxDrawImage(24 + w + 4 + 8 + w - 48, y, 48, 48, sightlangStaticImage[0], 0, 0, 0, tocolor(col[1], col[2], col[3], 110))
							end
							dxDrawImage(24 + w + 4 + 8, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, dynamicImage("files/icons/" .. values[i + valueScroll][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 175))
							dxDrawText(values[i + valueScroll][2], 24 + w + 4 + 8 + fonts.valueFontH + 4, y, 0, y + 48, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "left", "center")
							if equippedValue == i + valueScroll then
								local col = values[i + valueScroll][4] and (values[i + valueScroll][4] == "blue" and colors.blue or colors.purple) or colors.green
								if values[i + valueScroll][7] then
									local ptw = dxGetTextWidth(values[i + valueScroll][3], fonts.valueFontScale, fonts.valueFont) + 8
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImage(24 + w + 4 + w - fonts.valueFontH - ptw, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(col[1], col[2], col[3]))
									dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "right", "center")
								else
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImage(24 + w + 4 + w - fonts.valueFontH, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(col[1], col[2], col[3]))
								end
							else
								dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "right", "center")
							end
						end
					else
						local y = y + 48 * (i - 1)
						if valueInterpolation and valueInterpolation[4] then
							if valueInterpolation[4] < valueInterpolation[5] then
								y = y + 48 * (1 - mp)
							else
								y = y - 48 * (1 - mp)
							end
						end
						if valueInterpolation and valueInterpolation[2] == i + valueScroll then
							if values[i + valueScroll][4] then
								local col = values[i + valueScroll][4] and (values[i + valueScroll][4] == "blue" and colors.blue or colors.purple) or colors.green
								col = {
									255 + (col[1] - 255) * mp,
									255 + (col[2] - 255) * mp,
									255 + (col[3] - 255) * mp,
									50 + 60 * mp
								}
								sightlangStaticImageUsed[0] = true
								if sightlangStaticImageToc[0] then
									processsightlangStaticImage[0]()
								end
								dxDrawImage(24 + w + 4 + 8 + w - 48, y, 48, 48, sightlangStaticImage[0], 0, 0, 0, tocolor(col[1], col[2], col[3], col[4]))
							end
							dxDrawImage(24 + w + 4 + 8, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, dynamicImage("files/icons/" .. values[i + valueScroll][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 175 + 80 * (1 - mp)))
							dxDrawText(values[i + valueScroll][2], 24 + w + 4 + 8 + fonts.valueFontH + 4, y, 0, y + 48, tocolor(255, 255, 255, 255 * (1 - mp)), fonts.value2FontScale, fonts.value2Font, "left", "center")
							dxDrawText(values[i + valueScroll][2], 24 + w + 4 + 8 + fonts.valueFontH + 4, y, 0, y + 48, tocolor(255, 255, 255, 255 * mp), fonts.valueFontScale, fonts.valueFont, "left", "center")
							if equippedValue == i + valueScroll then
								local col = values[i + valueScroll][4] and (values[i + valueScroll][4] == "blue" and colors.blue or colors.purple) or colors.green
								col = {
									255 + (col[1] - 255) * mp,
									255 + (col[2] - 255) * mp,
									255 + (col[3] - 255) * mp
								}
								if values[i + valueScroll][7] then
									local ptw1 = dxGetTextWidth(values[i + valueScroll][3], fonts.value2FontScale, fonts.value2Font) + 8
									local ptw2 = dxGetTextWidth(values[i + valueScroll][3], fonts.valueFontScale, fonts.valueFont) + 8
									local ptw = ptw1 + (ptw2 - ptw1) * mp
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImage(24 + w + 4 + w - fonts.valueFontH - ptw, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(col[1], col[2], col[3]))
									dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255, 255 * (1 - mp)), fonts.value2FontScale, fonts.value2Font, "right", "center")
									dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255, 255 * mp), fonts.valueFontScale, fonts.valueFont, "right", "center")
								else
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImage(24 + w + 4 + w - fonts.valueFontH, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(col[1], col[2], col[3]))
								end
							else
								dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255, 255 * (1 - mp)), fonts.value2FontScale, fonts.value2Font, "right", "center")
								dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255, 255 * mp), fonts.valueFontScale, fonts.valueFont, "right", "center")
							end
						elseif valueInterpolation and valueInterpolation[3] == i + valueScroll then
							if valueInterpolation and valueInterpolation[4] then
								if valueInterpolation[4] < valueInterpolation[5] then
									local by = y + 48 * mp
									local iy = y
									local ih = math.max(0, math.min(48, by - iy))
									if values[i + valueScroll][4] then
										sightlangStaticImageUsed[0] = true
										if sightlangStaticImageToc[0] then
											processsightlangStaticImage[0]()
										end
										dxDrawImageSection(24 + w + 4 + 8 + w - 48, iy, 48, ih, 0, 0, 48, ih, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 50))
									end
									local iy = y + 24 - fonts.valueFontH / 2
									local ih = math.max(0, math.min(fonts.valueFontH, by - iy))
									dxDrawImageSection(24 + w + 4 + 8, iy, fonts.valueFontH, ih, 0, 0, 32, ih / fonts.valueFontH * 32, dynamicImage("files/icons/" .. values[i + valueScroll][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 175 + 80 * mp))
									dxDrawText(values[i + valueScroll][2], 24 + w + 4 + 8 + fonts.valueFontH + 4, y + 24 - fonts.value2FontH / 2, screenX, by, tocolor(255, 255, 255, 255 * mp), fonts.value2FontScale, fonts.value2Font, "left", "top", true)
									if equippedValue == i + valueScroll then
										if values[i + valueScroll][7] then
											local ptw = dxGetTextWidth(values[i + valueScroll][3], fonts.value2FontScale, fonts.value2Font) + 8
											sightlangStaticImageUsed[1] = true
											if sightlangStaticImageToc[1] then
												processsightlangStaticImage[1]()
											end
											dxDrawImageSection(24 + w + 4 + w - fonts.valueFontH - ptw, iy, fonts.valueFontH, ih, 0, 0, 24, ih / fonts.valueFontH * 24, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
											dxDrawText(values[i + valueScroll][3], 0, y + 24 - fonts.value2FontH / 2, 24 + w + 4 + w, by, tocolor(255, 255, 255, 255 * mp), fonts.value2FontScale, fonts.value2Font, "right", "top", true)
										else
											sightlangStaticImageUsed[1] = true
											if sightlangStaticImageToc[1] then
												processsightlangStaticImage[1]()
											end
											dxDrawImageSection(24 + w + 4 + w - fonts.valueFontH, iy, fonts.valueFontH, ih, 0, 0, 24, ih / fonts.valueFontH * 24, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
										end
									else
										dxDrawText(values[i + valueScroll][3], 0, y + 24 - fonts.value2FontH / 2, 24 + w + 4 + w, by, tocolor(255, 255, 255, 255 * mp), fonts.value2FontScale, fonts.value2Font, "right", "top", true)
									end
								else
									local ty = y + 48 * (1 - mp)
									local iy = y
									local ih = math.max(0, math.min(48, iy + 48 - ty))
									if values[i + valueScroll][4] then
										sightlangStaticImageUsed[0] = true
										if sightlangStaticImageToc[0] then
											processsightlangStaticImage[0]()
										end
										dxDrawImageSection(24 + w + 4 + 8 + w - 48, math.max(ty, iy), 48, ih, 0, 48 - ih, 48, ih, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 50))
									end
									local iy = y + 24 - fonts.valueFontH / 2
									local ih = math.max(0, math.min(fonts.valueFontH, iy + fonts.valueFontH - ty))
									dxDrawImageSection(24 + w + 4 + 8, math.max(ty, iy), fonts.valueFontH, ih, 0, 32 - ih / fonts.valueFontH * 32, 32, ih / fonts.valueFontH * 32, dynamicImage("files/icons/" .. values[i + valueScroll][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 175))
									dxDrawText(values[i + valueScroll][2], 24 + w + 4 + 8 + fonts.valueFontH + 4, ty, screenX, y + 24 + fonts.value2FontH / 2, tocolor(255, 255, 255, 255 * mp), fonts.value2FontScale, fonts.value2Font, "left", "bottom", true)
									if equippedValue == i + valueScroll then
										if values[i + valueScroll][7] then
											local ptw = dxGetTextWidth(values[i + valueScroll][3], fonts.value2FontScale, fonts.value2Font) + 8
											sightlangStaticImageUsed[1] = true
											if sightlangStaticImageToc[1] then
												processsightlangStaticImage[1]()
											end
											dxDrawImageSection(24 + w + 4 + w - fonts.valueFontH - ptw, math.max(ty, iy), fonts.valueFontH, ih, 0, 24 - ih / fonts.valueFontH * 24, 24, ih / fonts.valueFontH * 24, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
											dxDrawText(values[i + valueScroll][3], 0, ty, 24 + w + 4 + w, y + 24 + fonts.value2FontH / 2, tocolor(255, 255, 255, 255 * mp), fonts.value2FontScale, fonts.value2Font, "right", "bottom", true)
										else
											sightlangStaticImageUsed[1] = true
											if sightlangStaticImageToc[1] then
												processsightlangStaticImage[1]()
											end
											dxDrawImageSection(24 + w + 4 + w - fonts.valueFontH, math.max(ty, iy), fonts.valueFontH, ih, 0, 24 - ih / fonts.valueFontH * 24, 24, ih / fonts.valueFontH * 24, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
										end
									else
										dxDrawText(values[i + valueScroll][3], 0, ty, 24 + w + 4 + w, y + 24 + fonts.value2FontH / 2, tocolor(255, 255, 255, 255 * mp), fonts.value2FontScale, fonts.value2Font, "right", "bottom", true)
									end
								end
							else
								if values[i + valueScroll][4] then
									local col = values[i + valueScroll][4] and (values[i + valueScroll][4] == "blue" and colors.blue or colors.purple) or colors.green
									col = {
										col[1] + (255 - col[1]) * mp,
										col[2] + (255 - col[2]) * mp,
										col[3] + (255 - col[3]) * mp,
										110 + -60 * mp
									}
									sightlangStaticImageUsed[0] = true
									if sightlangStaticImageToc[0] then
										processsightlangStaticImage[0]()
									end
									dxDrawImage(24 + w + 4 + 8 + w - 48, y, 48, 48, sightlangStaticImage[0], 0, 0, 0, tocolor(col[1], col[2], col[3], col[4]))
								end
								dxDrawImage(24 + w + 4 + 8, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, dynamicImage("files/icons/" .. values[i + valueScroll][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 175 + 80 * mp))
								dxDrawText(values[i + valueScroll][2], 24 + w + 4 + 8 + fonts.valueFontH + 4, y, 0, y + 48, tocolor(255, 255, 255, 255 * mp), fonts.value2FontScale, fonts.value2Font, "left", "center")
								dxDrawText(values[i + valueScroll][2], 24 + w + 4 + 8 + fonts.valueFontH + 4, y, 0, y + 48, tocolor(255, 255, 255, 255 * (1 - mp)), fonts.valueFontScale, fonts.valueFont, "left", "center")
								if equippedValue == i + valueScroll then
									local col = values[i + valueScroll][4] and (values[i + valueScroll][4] == "blue" and colors.blue or colors.purple) or colors.green
									col = {
										col[1] + (255 - col[1]) * mp,
										col[2] + (255 - col[2]) * mp,
										col[3] + (255 - col[3]) * mp
									}
									if values[i + valueScroll][7] then
										local ptw1 = dxGetTextWidth(values[i + valueScroll][3], fonts.valueFontScale, fonts.valueFont) + 8
										local ptw2 = dxGetTextWidth(values[i + valueScroll][3], fonts.value2FontScale, fonts.value2Font) + 8
										local ptw = ptw1 + (ptw2 - ptw1) * mp
										dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255, 255 * mp), fonts.value2FontScale, fonts.value2Font, "right", "center")
										dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255, 255 * (1 - mp)), fonts.valueFontScale, fonts.valueFont, "right", "center")
										sightlangStaticImageUsed[1] = true
										if sightlangStaticImageToc[1] then
											processsightlangStaticImage[1]()
										end
										dxDrawImage(24 + w + 4 + w - fonts.valueFontH - ptw, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(col[1], col[2], col[3]))
									else
										sightlangStaticImageUsed[1] = true
										if sightlangStaticImageToc[1] then
											processsightlangStaticImage[1]()
										end
										dxDrawImage(24 + w + 4 + w - fonts.valueFontH, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(col[1], col[2], col[3]))
									end
								else
									dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255, 255 * mp), fonts.value2FontScale, fonts.value2Font, "right", "center")
									dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255, 255 * (1 - mp)), fonts.valueFontScale, fonts.valueFont, "right", "center")
								end
							end
						elseif i + valueScroll == activeValue then
							if values[i + valueScroll][4] then
								sightlangStaticImageUsed[0] = true
								if sightlangStaticImageToc[0] then
									processsightlangStaticImage[0]()
								end
								dxDrawImage(24 + w + 4 + 8 + w - 48, y, 48, 48, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 50))
							end
							dxDrawImage(24 + w + 4 + 8, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, dynamicImage("files/icons/" .. values[i + valueScroll][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255))
							dxDrawText(values[i + valueScroll][2], 24 + w + 4 + 8 + fonts.valueFontH + 4, y, 0, y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "left", "center")
							if equippedValue == i + valueScroll then
								if values[i + valueScroll][7] then
									local ptw = dxGetTextWidth(values[i + valueScroll][3], fonts.value2FontScale, fonts.value2Font) + 8
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImage(24 + w + 4 + w - fonts.valueFontH - ptw, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
									dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "right", "center")
								else
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImage(24 + w + 4 + w - fonts.valueFontH, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
								end
							else
								dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "right", "center")
							end
						else
							if values[i + valueScroll][4] then
								local col = values[i + valueScroll][4] and (values[i + valueScroll][4] == "blue" and colors.blue or colors.purple) or colors.green
								sightlangStaticImageUsed[0] = true
								if sightlangStaticImageToc[0] then
									processsightlangStaticImage[0]()
								end
								dxDrawImage(24 + w + 4 + 8 + w - 48, y, 48, 48, sightlangStaticImage[0], 0, 0, 0, tocolor(col[1], col[2], col[3], 110))
							end
							dxDrawImage(24 + w + 4 + 8, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, dynamicImage("files/icons/" .. values[i + valueScroll][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 175))
							dxDrawText(values[i + valueScroll][2], 24 + w + 4 + 8 + fonts.valueFontH + 4, y, 0, y + 48, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "left", "center", false, false, false, true)
							if equippedValue == i + valueScroll then
								local col = values[i + valueScroll][4] and (values[i + valueScroll][4] == "blue" and colors.blue or colors.purple) or colors.green
								if values[i + valueScroll][7] then
									local ptw = dxGetTextWidth(values[i + valueScroll][3], fonts.valueFontScale, fonts.valueFont) + 8
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImage(24 + w + 4 + w - fonts.valueFontH - ptw, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(col[1], col[2], col[3]))
									dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "right", "center")
								else
									sightlangStaticImageUsed[1] = true
									if sightlangStaticImageToc[1] then
										processsightlangStaticImage[1]()
									end
									dxDrawImage(24 + w + 4 + w - fonts.valueFontH, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(col[1], col[2], col[3]))
								end
							else
								dxDrawText(values[i + valueScroll][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255), fonts.valueFontScale, fonts.valueFont, "right", "center")
							end
						end
					end
				end
				if valueCloseInterpolation and valueCloseInterpolation[2] == 2 then
					local y = y + (activeValue - valueScroll - 1) * 48 * mp
					local col = values[activeValue][4] and (values[activeValue][4] == "blue" and colors.blue or colors.purple) or colors.green
					dxDrawRectangle(24 + w + 4, y, w + 8, 48, tocolor(col[1], col[2], col[3]))
					if values[activeValue][4] then
						sightlangStaticImageUsed[0] = true
						if sightlangStaticImageToc[0] then
							processsightlangStaticImage[0]()
						end
						dxDrawImage(24 + w + 4 + 8 + w - 48, y, 48, 48, sightlangStaticImage[0], 0, 0, 0, tocolor(255, 255, 255, 50))
					end
					dxDrawImage(24 + w + 4 + 8, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, dynamicImage("files/icons/" .. values[activeValue][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255))
					dxDrawText(values[activeValue][2], 24 + w + 4 + 8 + fonts.valueFontH + 4, y, 0, y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "left", "center")
					if equippedValue == activeValue then
						if values[activeValue][7] then
							local ptw = dxGetTextWidth(values[activeValue][3], fonts.value2FontScale, fonts.value2Font) + 8
							sightlangStaticImageUsed[1] = true
							if sightlangStaticImageToc[1] then
								processsightlangStaticImage[1]()
							end
							dxDrawImage(24 + w + 4 + w - fonts.valueFontH - ptw, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
							dxDrawText(values[activeValue][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "right", "center")
						else
							sightlangStaticImageUsed[1] = true
							if sightlangStaticImageToc[1] then
								processsightlangStaticImage[1]()
							end
							dxDrawImage(24 + w + 4 + w - fonts.valueFontH, y + 24 - fonts.valueFontH / 2, fonts.valueFontH, fonts.valueFontH, sightlangStaticImage[1], 0, 0, 0, tocolor(255, 255, 255))
						end
					else
						dxDrawText(values[activeValue][3], 0, y, 24 + w + 4 + w, y + 48, tocolor(255, 255, 255), fonts.value2FontScale, fonts.value2Font, "right", "center")
					end
				end
			end
			local y = 72
			for i = 1, #menus do
				if openingInterpolation then
					if openingInterpolation[4] == i then
						local tw = dxGetTextWidth(menus[i][2], fonts.header2FontScale, fonts.header2Font)
						local x1 = 24 + w / 2 + tw / 2
						local x2 = 24 + w - 8
						local tw = dxGetTextWidth(menus[i][2], fonts.headerFontScale, fonts.headerFont)
						local x3 = 24 + w / 2 + tw / 2
						local x4 = 24 + w - 8
						local y = 24 + 48 * i * mp
						dxDrawText(menus[i][2], 0, y, x1 + (x2 - x1) * mp, y + 48, tocolor(255, 255, 255, 255 * mp), fonts.header2FontScale, fonts.header2Font, "right", "center")
						dxDrawText(menus[i][2], 0, y, x1 + (x4 - x3) * mp, y + 48, tocolor(255, 255, 255, 255 * (1 - mp)), fonts.headerFontScale, fonts.headerFont, "right", "center")
						dxDrawImage(32, y + 24 - 16, 32, 32, dynamicImage("files/icons/" .. menus[i][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * mp))
					elseif activeMenu == i then
						dxDrawImage(32, y + 24 - 16, 32, 32, dynamicImage("files/icons/" .. menus[i][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * mp))
						dxDrawText(menus[i][2], 24, y, 24 + w - 8 - w * (1 - mp), y + 48, tocolor(255, 255, 255), fonts.header2FontScale, fonts.header2Font, "right", "center", true)
					else
						local tw = dxGetTextWidth(menus[i][2], fonts.header2FontScale, fonts.header2Font)
						dxDrawText(menus[i][2], 24, y, 24 + w / 2 + tw / 2 - w * (1 - mp), y + 48, tocolor(255, 255, 255), fonts.header2FontScale, fonts.header2Font, "right", "center", true)
					end
				elseif closingInterpolation then
					if closingInterpolation[2] == i then
						local tw = dxGetTextWidth(menus[i][2], fonts.header2FontScale, fonts.header2Font)
						local x1 = 24 + w / 2 + tw / 2
						local x2 = 24 + w - 8
						local tw = dxGetTextWidth(menus[i][2], fonts.headerFontScale, fonts.headerFont)
						local x3 = 24 + w / 2 + tw / 2
						local x4 = 24 + w - 8
						local y = 24 + 48 * i * mp
						dxDrawText(menus[i][2], 0, y, x1 + (x2 - x1) * mp, y + 48, tocolor(255, 255, 255, 255 * mp), fonts.header2FontScale, fonts.header2Font, "right", "center")
						dxDrawText(menus[i][2], 0, y, x1 + (x4 - x3) * mp, y + 48, tocolor(255, 255, 255, 255 * (1 - mp)), fonts.headerFontScale, fonts.headerFont, "right", "center")
						dxDrawImage(32, y + 24 - 16, 32, 32, dynamicImage("files/icons/" .. menus[i][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * mp))
					elseif activeMenu == i then
						dxDrawImage(32, y + 24 - 16, 32, 32, dynamicImage("files/icons/" .. menus[i][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * mp))
						dxDrawText(menus[i][2], 24, y, 24 + w - 8 - w * (1 - mp), y + 48, tocolor(255, 255, 255), fonts.header2FontScale, fonts.header2Font, "right", "center", true)
					else
						local tw = dxGetTextWidth(menus[i][2], fonts.header2FontScale, fonts.header2Font)
						dxDrawText(menus[i][2], 24, y, 24 + w / 2 + tw / 2 - w * (1 - mp), y + 48, tocolor(255, 255, 255), fonts.header2FontScale, fonts.header2Font, "right", "center", true)
					end
				elseif menuInterpolation and menuInterpolation[2] == i then
					local tw = dxGetTextWidth(menus[i][2], fonts.header2FontScale, fonts.header2Font)
					local x1 = 24 + w - 8
					local x2 = 24 + w / 2 + tw / 2
					dxDrawText(menus[i][2], 0, y, x1 + (x2 - x1) * mp, y + 48, tocolor(255, 255, 255), fonts.header2FontScale, fonts.header2Font, "right", "center")
					dxDrawImage(32, menuY + 24 - 16, 32, 32, dynamicImage("files/icons/" .. menus[i][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * (1 - mp)))
				elseif menuInterpolation and menuInterpolation[3] == i then
					local tw = dxGetTextWidth(menus[i][2], fonts.header2FontScale, fonts.header2Font)
					local x1 = 24 + w / 2 + tw / 2
					local x2 = 24 + w - 8
					dxDrawText(menus[i][2], 0, y, x1 + (x2 - x1) * mp, y + 48, tocolor(255, 255, 255), fonts.header2FontScale, fonts.header2Font, "right", "center")
					dxDrawImage(32, menuY + 24 - 16, 32, 32, dynamicImage("files/icons/" .. menus[i][1] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * mp))
				elseif activeMenu == i then
					dxDrawText(menus[i][2], 0, y, 24 + w - 8, y + 48, tocolor(255, 255, 255), fonts.header2FontScale, fonts.header2Font, "right", "center")
					dxDrawImage(32, y + 24 - 16, 32, 32, dynamicImage("files/icons/" .. menus[i][1] .. ".dds"))
				else
					dxDrawText(menus[i][2], 24, y, 24 + w, y + 48, tocolor(255, 255, 255), fonts.header2FontScale, fonts.header2Font, "center", "center")
				end
				y = y + 48
			end
			local animEndKeyHandler = false
			if closingInterpolation then
				if mp <= 0 then
					loadTuningMenu(closingInterpolation[2])
					closingInterpolation = false
					animEndKeyHandler = true
				end
			elseif valueCloseInterpolation then
				if mp <= 0 then
					valueCloseInterpolation[1] = now
					valueCloseInterpolation[2] = valueCloseInterpolation[2] - 1
					if 1 > valueCloseInterpolation[2] then
						valueCloseInterpolation = false
						valueScroll = false
						activeValue = false
						equippedValue = false
						values = false
						valueScrollH = false
						animEndKeyHandler = true
						if playerIsController then
							triggerServerEvent("syncTuningSpectatorData", localPlayer, "value", false)
							if currentMenu[activeMenu].serverPreview then
								triggerServerEvent("previewTuningServer", localPlayer, currentMenu[activeMenu].tuningId, "reset")
							elseif currentMenu[activeMenu].clientPreview then
								clientPreviewTuning(currentMenu[activeMenu].tuningId, "reset")
							end
						end
					else
						playSound("files/lm.wav")
					end
				end
			elseif adjustingInterpolation then
				if adjustingInterpolation[2] == 1 then
					if 1 <= mp then
						adjustingInterpolation[1] = now
						adjustingInterpolation[2] = 2
					end
				elseif adjustingInterpolation[2] == 2 then
					if 1 <= mp then
						adjustingInterpolation = false
					end
				elseif adjustingInterpolation[2] == 3 then
					if mp <= 0 then
						adjustingInterpolation[1] = now
						adjustingInterpolation[2] = 4
					end
				elseif adjustingInterpolation[2] == 4 then
					if mp <= 0 then
						if adjustingInterpolation[3] then
							buyPromptAnimation = {
								getTickCount(),
								1
							}
							buyPrompt = true
							buyPromptValue = true
						end
						adjustingInterpolation = false
						adjustingValue = false
					end
				elseif adjustingInterpolation[2] == 5 and 1 <= mp then
					adjustingInterpolation = false
				end
			elseif buyPromptAnimation then
				if buyPromptAnimation[2] == 2 or buyPromptAnimation[2] == 4 then
					if mp <= 0 then
						buyPromptAnimation = false
						buyPrompt = false
						deleteTuningCustomPrompt()
						animEndKeyHandler = true
					end
				elseif 1 <= mp then
					buyPromptAnimation = false
				end
			elseif valueOpenInterpolation then
				if 1 <= mp then
					valueOpenInterpolation[1] = now
					valueOpenInterpolation[2] = valueOpenInterpolation[2] + 1
					if 2 < valueOpenInterpolation[2] then
						valueOpenInterpolation = false
						animEndKeyHandler = true
					else
						playSound("files/em.wav")
					end
				end
			elseif valueInterpolation then
				if 1 <= mp then
					valueInterpolation = false
					animEndKeyHandler = true
				end
			elseif openingInterpolation then
				if 1 <= mp then
					openingInterpolation = false
					animEndKeyHandler = true
				end
			elseif menuInterpolation and 1 <= mp then
				menuInterpolation = false
				animEndKeyHandler = true
			end
			if adjustingInterpolation and adjustingInterpolation[2] == 6 and 1 <= mp then
				adjustingInterpolation = false
				if getKeyState("arrow_r") then
					tuningKey("arrow_r", true)
					valueScrollSpeed = (valueScrollSpeed or 1) + 0.5
				elseif getKeyState("arrow_l") then
					tuningKey("arrow_l", true)
					valueScrollSpeed = (valueScrollSpeed or 1) + 0.5
				else
					valueScrollSpeed = false
				end
			end
			if animEndKeyHandler then
				if getKeyState("arrow_u") then
					tuningKey("arrow_u", true)
				elseif getKeyState("arrow_d") then
					tuningKey("arrow_d", true)
				end
			end
		end
	end
	if endNightTime then
		endNightHandler()
	end
	if nightShader then
		dxUpdateScreenSource(nightSource, true)
		dxDrawImage(0, 0, screenX, screenY, nightShader)
	end
	if tuningIntro and now - tuningIntro < 2000 then
		local d = now - tuningIntro
		local p = 1
		if 1000 < d then
			p = 1 - (d - 1000) / 1000
		end
		dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
	end
end
function endNightHandler()
	local now = getTickCount()
	local delta = now - endNightTime
	if 0 < delta then
		local p = delta / 100
		if 3 < p then
			p = 1 - (p - 3) / 20
			dxSetShaderValue(nightShader, "Brightness", p * 0.9)
			dxSetShaderValue(nightShader, "Contrast", 0.125 * p)
		elseif 1 < p then
			local vx, vy, vz = getElementPosition(veh)
			local d = vy - wsY
			local d2 = getDistanceBetweenPoints2D(vx, vy, wsX, wsY)
			if (0.1 < d or 0.2 < d2) and playerIsController then
				setElementPosition(veh, wsX, wsY, vehZ)
				setElementRotation(veh, 0, 0, 180)
			end
			dxSetShaderValue(nightShader, "Brightness", 0.9)
			p = 1
			nightTime = false
		else
			dxSetShaderValue(nightShader, "Brightness", p * 0.9)
		end
		if p < 0 then
			p = 0
			endNightTime = false
			if isElement(nightSource) then
				destroyElement(nightSource)
			end
			nightSource = nil
			if isElement(nightShader) then
				destroyElement(nightShader)
			end
			nightShader = nil
			h = 0
			menuOpen = true
			if playerIsController then
				loadTuningMenu()
			end
		end
	end
end
local exteriors = {}
function loadModelIds()
	objectModels = {
		tuning_workshop = sightexports.sModloader:getModelId("tuning_workshop"),
		tuning_workshop_props = sightexports.sModloader:getModelId("tuning_workshop_props"),
		tuning_workshop_props2 = sightexports.sModloader:getModelId("tuning_workshop_props2"),
		tuning_workshop_transparents = sightexports.sModloader:getModelId("tuning_workshop_transparents"),
		cylinder_head = sightexports.sModloader:getModelId("cylinder_head"),
		timing_belt = sightexports.sModloader:getModelId("timing_belt"),
		engine_block = sightexports.sModloader:getModelId("engine_block"),
		gasket = sightexports.sModloader:getModelId("gasket"),
		oil_sump = sightexports.sModloader:getModelId("oil_sump"),
		pistons = sightexports.sModloader:getModelId("pistons"),
		valve_cover = sightexports.sModloader:getModelId("valve_cover"),
		oil_gasket = sightexports.sModloader:getModelId("oil_gasket"),
		valve_gasket = sightexports.sModloader:getModelId("valve_gasket"),
		car_battery = sightexports.sModloader:getModelId("car_battery"),
		exhaust_manifold = sightexports.sModloader:getModelId("exhaust_manifold"),
		intake_manifold = sightexports.sModloader:getModelId("intake_manifold"),
		transmission = sightexports.sModloader:getModelId("transmission"),
		turbo = sightexports.sModloader:getModelId("turbo"),
		brakedisc = sightexports.sModloader:getModelId("brakedisc"),
		suspension_front = sightexports.sModloader:getModelId("suspension_front"),
		suspension_rear = sightexports.sModloader:getModelId("suspension_rear"),
		cardan_shaft = sightexports.sModloader:getModelId("cardan_shaft"),
		half_shaft = sightexports.sModloader:getModelId("half_shaft"),
		differential = sightexports.sModloader:getModelId("differential"),
		transfer_case = sightexports.sModloader:getModelId("transfer_case"),
		ecu = sightexports.sModloader:getModelId("ecu"),
		tuning_workshop_exterior = sightexports.sModloader:getModelId("tuning_workshop_exterior"),
		tuning_workshop_exteriorLOD = sightexports.sModloader:getModelId("tuning_workshop_exteriorLOD"),
		tuning_workshop_exteriorglass = sightexports.sModloader:getModelId("tuning_workshop_exteriorglass"),
		tuning_workshop_exterioralpha = sightexports.sModloader:getModelId("tuning_workshop_exterioralpha")
	}
	for i = 1, #exteriors do
		if isElement(exteriors[i]) then
			destroyElement(exteriors[i])
		end
	end
	exteriors = {}
	for i = 1, #workshopLocations do
		local exterior = createObject(objectModels.tuning_workshop_exterior, workshopLocations[i][9], workshopLocations[i][10], workshopLocations[i][11], 0, 0, workshopLocations[i][12])
		setElementDimension(exterior, -1)
		local exteriorLOD = createObject(objectModels.tuning_workshop_exteriorLOD, workshopLocations[i][9], workshopLocations[i][10], workshopLocations[i][11], 0, 0, workshopLocations[i][12], true)
		setElementDimension(exteriorLOD, -1)
		setLowLODElement(exterior, exteriorLOD)
		local exteriorglass = createObject(objectModels.tuning_workshop_exteriorglass, workshopLocations[i][9], workshopLocations[i][10], workshopLocations[i][11], 0, 0, workshopLocations[i][12])
		setElementDimension(exteriorglass, -1)
		local exterioralpha = createObject(objectModels.tuning_workshop_exterioralpha, workshopLocations[i][9], workshopLocations[i][10], workshopLocations[i][11], 0, 0, workshopLocations[i][12])
		setElementDimension(exterioralpha, -1)
		table.insert(exteriors, exterior)
	end
end
local workshopSpotlights = {}
local spotlightState = false
function processWorkshopSpotlight()
	local h = getTime()
	local tmp = 21 <= h or h <= 8
	if spotlightState ~= tmp then
		spotlightState = tmp
		for i = 1, #workshopSpotlights do
			if isElement(workshopSpotlights[i]) then
				destroyElement(workshopSpotlights[i])
			end
			workshopSpotlights[i] = nil
		end
		workshopSpotlights = {}
		if tmp then
			for i = 1, #workshopLocations do
				local rad = math.rad(workshopLocations[i][12] + 180)
				local cos = math.cos(rad)
				local sin = math.sin(rad)
				local startX, startY, startZ = workshopLocations[i][9] + cos * workshopSpotlightData[1] + sin * workshopSpotlightData[2], workshopLocations[i][10] + sin * workshopSpotlightData[1] - cos * workshopSpotlightData[2], workshopLocations[i][11] + workshopSpotlightData[3]
				local spotlight = createSearchLight(startX, startY, startZ, workshopLocations[i][9] + cos * workshopSpotlightData[4] + sin * workshopSpotlightData[5], workshopLocations[i][10] + sin * workshopSpotlightData[4] - cos * workshopSpotlightData[5], workshopLocations[i][11] + workshopSpotlightData[6], workshopSpotlightData[7], workshopSpotlightData[8])
				table.insert(workshopSpotlights, spotlight)
				local spotLightSound = playSound3D("files/light.mp3", startX, startY, startZ, false)
				setSoundMaxDistance(spotLightSound, 40)
				setSoundVolume(spotLightSound, 2)
			end
		end
	end
end
processWorkshopSpotlight()
setTimer(processWorkshopSpotlight, 60000, 0)
addEvent("resetGratisPaintjob", true)
addEventHandler("resetGratisPaintjob", getRootElement(), function()
	if source == getPedOccupiedVehicle(localPlayer) then
		isGratisPJ = false
		tuningPrices.paintjob.custom = {
			"pp",
			sightexports.sCustompj:getCustomPjPrice()
		}
		if activeValue then
			valueCloseInterpolation = {
				getTickCount(),
				2
			}
		end
	end
end)
addEvent("tuningGuiState", true)
addEventHandler("tuningGuiState", getRootElement(), function(ws, controller, scenario, gratis)
	if ws and workshopLocations[ws] then
		if source == getPedOccupiedVehicle(localPlayer) then
			isGratisPJ = gratis
			setPedCanBeKnockedOffBike(localPlayer, false)
			veh = source
			vehType = getVehicleType(veh)
			if not tuningState then
				addEventHandler("onClientRender", getRootElement(), renderTuning)
				addEventHandler("onClientPreRender", getRootElement(), preRenderTuning, true, "low-999999999999")
				addEventHandler("onClientKey", getRootElement(), tuningKey)
			end
			wsX, wsY, wsZ = 1.71875, 30.40625, 1200.34375

			removeWorldModel(1563, 0.25, 0.5703, 26.6719, 1199.8125)
			removeWorldModel(1563, 0.25, 0.6016, 24.375, 1199.8125)
			removeWorldModel(1562, 0.25, 0.6016, 24.7188, 1199.2656)
			removeWorldModel(1562, 0.25, 0.5703, 27.0156, 1199.2656)
			removeWorldModel(1562, 0.25, 0.6016, 29.3516, 1199.2656)
			removeWorldModel(1563, 0.25, 0.6016, 29.6953, 1199.8125)
			removeWorldModel(1564, 0.25, 1.6328, 25.0547, 1202)
			removeWorldModel(1565, 0.25, 1.6328, 25.0547, 1202.0234)
			removeWorldModel(1564, 0.25, 1.6328, 26.9063, 1202)
			removeWorldModel(1565, 0.25, 1.6328, 26.9063, 1202.0234)
			removeWorldModel(1563, 0.25, 2.8594, 25.4375, 1199.8125)
			removeWorldModel(1562, 0.25, 2.8594, 25.7813, 1199.2656)
			removeWorldModel(1563, 0.25, 2.8594, 27.7109, 1199.8125)
			removeWorldModel(1562, 0.25, 2.8594, 28.0547, 1199.2656)
			removeWorldModel(1564, 0.25, 1.6328, 28.875, 1202)
			removeWorldModel(1565, 0.25, 1.6328, 28.875, 1202.0234)
			removeWorldModel(14405, 0.25, 1.7266, 30.0547, 1199.2656)
			removeWorldModel(1562, 0.25, 2.8594, 30.3984, 1199.2656)
			removeWorldModel(1563, 0.25, 2.8594, 30.7422, 1199.8125)
			removeWorldModel(1564, 0.25, 1.6328, 30.7578, 1202)
			removeWorldModel(1565, 0.25, 1.6328, 30.7578, 1202.0234)
			setInteriorSoundsEnabled(false)
			tuningIntro = getTickCount()
			sightexports.sSpeedo:toggleTuningIntro(true)
			initTuning(controller, false)
			deleteScenario()
			if type(scenario) == "table" and #scenario > 0 then
				createScenarioCar(1, scenario[1], scenario[5])
				createScenarioCar(2, scenario[2], scenario[6])
				createScenarioCar(3, scenario[3], scenario[7])
				createScenarioCar(4, scenario[4], scenario[8])
				createScenarioPed(1, scenario[9])
				createScenarioPed(2, scenario[10])
				createScenarioPed(3, scenario[11])
			end
			setElementPosition(veh, wsX, wsY + 20, vehZ)
			setElementRotation(veh, 0, 0, 180)
			tuningState = ws
			sightexports.sHud:setHudEnabled(false, 1000)
			showChat(false)
			sightexports.sControls:toggleAllControls(false)
		end
	elseif tuningState then
		setPedCanBeKnockedOffBike(localPlayer, true)
		removeEventHandler("onClientRender", getRootElement(), renderTuning)
		removeEventHandler("onClientPreRender", getRootElement(), preRenderTuning, true, "low-999999999999")
		removeEventHandler("onClientKey", getRootElement(), tuningKey)
		sightexports.sHud:setHudEnabled(true, 1000)
		showChat(true)
		sightexports.sControls:toggleAllControls(true)
		setInteriorSoundsEnabled(true)
		restoreWorldModel(1563, 0.25, 0.5703, 26.6719, 1199.8125)
		restoreWorldModel(1563, 0.25, 0.6016, 24.375, 1199.8125)
		restoreWorldModel(1562, 0.25, 0.6016, 24.7188, 1199.2656)
		restoreWorldModel(1562, 0.25, 0.5703, 27.0156, 1199.2656)
		restoreWorldModel(1562, 0.25, 0.6016, 29.3516, 1199.2656)
		restoreWorldModel(1563, 0.25, 0.6016, 29.6953, 1199.8125)
		restoreWorldModel(1564, 0.25, 1.6328, 25.0547, 1202)
		restoreWorldModel(1565, 0.25, 1.6328, 25.0547, 1202.0234)
		restoreWorldModel(1564, 0.25, 1.6328, 26.9063, 1202)
		restoreWorldModel(1565, 0.25, 1.6328, 26.9063, 1202.0234)
		restoreWorldModel(1563, 0.25, 2.8594, 25.4375, 1199.8125)
		restoreWorldModel(1562, 0.25, 2.8594, 25.7813, 1199.2656)
		restoreWorldModel(1563, 0.25, 2.8594, 27.7109, 1199.8125)
		restoreWorldModel(1562, 0.25, 2.8594, 28.0547, 1199.2656)
		restoreWorldModel(1564, 0.25, 1.6328, 28.875, 1202)
		restoreWorldModel(1565, 0.25, 1.6328, 28.875, 1202.0234)
		restoreWorldModel(14405, 0.25, 1.7266, 30.0547, 1199.2656)
		restoreWorldModel(1562, 0.25, 2.8594, 30.3984, 1199.2656)
		restoreWorldModel(1563, 0.25, 2.8594, 30.7422, 1199.8125)
		restoreWorldModel(1564, 0.25, 1.6328, 30.7578, 1202)
		restoreWorldModel(1565, 0.25, 1.6328, 30.7578, 1202.0234)
		playerIsController = false
		destroyTuning()
		setCameraTarget(localPlayer)
		tuningState = false
		sightexports.sWeather:resetWeather()
		sightexports.sSpeedo:toggleTuningIntro(false)
	end
end)
local tuningMarkers = {}
function markersReady()
	for i = 1, #tuningMarkers do
		sightexports.sMarkers:deleteCustomMarker(tuningMarkers[i])
	end
	tuningMarkers = {}
	for i = 1, #workshopLocations do
		local marker = sightexports.sMarkers:createCustomMarker(workshopLocations[i][1], workshopLocations[i][2], workshopLocations[i][3] + 0.35, 0, 0, "#ffffff", "tuning")
		table.insert(tuningMarkers, marker)
	end
end
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
	for i = 1, #tuningMarkers do
		sightexports.sMarkers:deleteCustomMarker(tuningMarkers[i])
	end
end)
addEventHandler("onClientResourceStop", getRootElement(), function(res)
	if res == getThisResource() or getResourceName(res) == "sVehicles" then
		if tuningState then
			sightexports.sHud:setHudEnabled(true, 1000)
			sightexports.sControls:toggleAllControls(true)
			sightexports.sWeather:resetWeather()
			sightexports.sSpeedo:toggleTuningIntro(false)
			sightexports.sSpeedo:toggleTuningState(false)
			setPedCanBeKnockedOffBike(localPlayer, true)
			setInteriorSoundsEnabled(true)
			setCameraTarget(localPlayer)
			showChat(true)
		end
	end
end)
local bcgH1 = false
local bcgH2 = false
local bcgH3 = false
local sliderH = false
local bcgS1 = false
local bcgS2 = false
local sliderS = false
local bcgL1 = false
local bcgL2 = false
local bcgL3 = false
local sliderL = false
local colorHexInput = false
function deleteTextInput()
	if not freeCamMode then
		showCursor(false)
	end
	currentTextInput = false
	if textInputBcg then
		sightexports.sGui:deleteGuiElement(textInputBcg)
	end
	textInputBcg = false
	textInput = false
end
function deleteColorPicker()
	if not freeCamMode then
		showCursor(false)
	end
	if colorPicker then
		sightexports.sGui:deleteGuiElement(colorPicker)
	end
	colorPickerMode = false
	colorPicker = false
	bcgH1 = false
	bcgH2 = false
	bcgH3 = false
	sliderH = false
	bcgS1 = false
	bcgS2 = false
	sliderS = false
	bcgL1 = false
	bcgL2 = false
	bcgL3 = false
	sliderL = false
	colorHexInput = false
end
function refreshColorPickerBcg(refreshInput)
	local h = sightexports.sGui:getSliderValue(sliderH)
	local s = sightexports.sGui:getSliderValue(sliderS)
	local l = sightexports.sGui:getSliderValue(sliderL)
	local fR, fG, fB = convertHSLToRGB(h, s, l)
	sightexports.sGui:setGuiBackground(bcgH1, "solid", {
		convertHSLToRGB(0, 0, l)
	})
	sightexports.sGui:setImageColor(bcgH2, {
		255,
		255,
		255,
		s * 255
	})
	local r, g, b = convertHSLToRGB(0, 0, l)
	local a = math.abs(l - 0.5) / 0.5 * 255
	sightexports.sGui:setGuiBackground(bcgH3, "solid", {
		r,
		g,
		b,
		a
	})
	sightexports.sGui:setGuiBackground(bcgS1, "solid", {
		convertHSLToRGB(h, 0, l)
	})
	sightexports.sGui:setImageColor(bcgS2, {
		convertHSLToRGB(h, 1, l)
	})
	sightexports.sGui:setImageColor(bcgL3, {
		convertHSLToRGB(h, s, 0.5)
	})
	local col = {
		fR,
		fG,
		fB
	}
	colorPickerR, colorPickerG, colorPickerB = fR, fG, fB
	sightexports.sGui:setSliderColor(sliderH, {
		0,
		0,
		0,
		0
	}, col)
	sightexports.sGui:setSliderColor(sliderS, {
		0,
		0,
		0,
		0
	}, col)
	sightexports.sGui:setSliderColor(sliderL, {
		0,
		0,
		0,
		0
	}, col)
	local hex = utf8.sub(sightexports.sGui:getColorCodeHex(col), 2, 7)
	if refreshInput then
		sightexports.sGui:setInputValue(colorHexInput, hex)
	end
	local col = {
		getVehicleColor(veh, true)
	}
	if colorPickerMode == "col1" then
		col[1], col[2], col[3] = fR, fG, fB
		setVehicleColor(veh, unpack(col))
	elseif colorPickerMode == "col2" then
		col[4], col[5], col[6] = fR, fG, fB
		setVehicleColor(veh, unpack(col))
	elseif colorPickerMode == "col3" then
		col[7], col[8], col[9] = fR, fG, fB
		setVehicleColor(veh, unpack(col))
	elseif colorPickerMode == "col4" then
		col[10], col[11], col[12] = fR, fG, fB
		setVehicleColor(veh, unpack(col))
	elseif colorPickerMode == "hexpicker" then
		clientPreviewTuning(currentMenu[activeMenu].tuningId, hex)
	elseif utf8.find(colorPickerMode, "spinner") then
		sightexports.sSpinner:refreshSpinnerColor(veh, fR, fG, fB)
	end
end
function hue2rgb(m1, m2, h)
	if h < 0 then
		h = h + 1
	elseif 1 < h then
		h = h - 1
	end
	if 1 > h * 6 then
		return m1 + (m2 - m1) * h * 6
	elseif 1 > h * 2 then
		return m2
	elseif 2 > h * 3 then
		return m1 + (m2 - m1) * (0.6666666666666666 - h) * 6
	else
		return m1
	end
end
function convertHSLToRGB(h, s, l)
	local m2
	if l < 0.5 then
		m2 = l * (s + 1)
	else
		m2 = l + s - l * s
	end
	local m1 = l * 2 - m2
	local r = hue2rgb(m1, m2, h + 0.3333333333333333) * 255
	local g = hue2rgb(m1, m2, h) * 255
	local b = hue2rgb(m1, m2, h - 0.3333333333333333) * 255
	return math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5)
end
function convertRGBToHSL(r, g, b)
	r = r / 255
	g = g / 255
	b = b / 255
	local max = math.max(r, g, b)
	local min = math.min(r, g, b)
	local h, s
	local l = (max + min) / 2
	if max == min then
		h = 0
		s = 0
	else
		local d = max - min
		s = 0.5 < l and d / (2 - max - min) or d / (max + min)
		if max == r then
			h = (g - b) / d + (g < b and 6 or 0)
		end
		if max == g then
			h = (b - r) / d + 2
		end
		if max == b then
			h = (r - g) / d + 4
		end
		h = h / 6
	end
	return h, s, l
end
addEvent("tuningColorPickerChanged", false)
addEventHandler("tuningColorPickerChanged", getRootElement(), function()
	refreshColorPickerBcg(true)
end)
addEvent("refreshTuningColorHexInput", false)
addEventHandler("refreshTuningColorHexInput", getRootElement(), function(val)
	sightexports.sGui:setInputValue(colorHexInput, utf8.upper(val))
	local r = tonumber("0x" .. val:sub(1, 2))
	local g = tonumber("0x" .. val:sub(3, 4))
	local b = tonumber("0x" .. val:sub(5, 6))
	if r and g and b then
		local h, s, l = convertRGBToHSL(r, g, b)
		sightexports.sGui:setSliderValue(sliderH, h)
		sightexports.sGui:setSliderValue(sliderS, s)
		sightexports.sGui:setSliderValue(sliderL, l)
		refreshColorPickerBcg()
	end
end)
function createColorPicker(mode)
	deleteColorPicker()
	showCursor(true)
	colorPickerMode = mode
	local x = 0
	local y = 8
	local sw = 400
	local sh = y * 2 + 84 + 24
	colorPicker = sightexports.sGui:createGuiElement("rectangle", screenX / 2 - sw / 2, screenY - sh - 24, sw, sh)
	sightexports.sGui:setGuiBackground(colorPicker, "solid", "sightgrey4")
	bcgH1 = sightexports.sGui:createGuiElement("rectangle", x + 8 + 10, y + 10 - 6, sw - 16 - 20, 12, colorPicker)
	bcgH2 = sightexports.sGui:createGuiElement("image", x + 8 + 10, y + 10 - 6, sw - 16 - 20, 12, colorPicker)
	sightexports.sGui:setImageDDS(bcgH2, ":sTuning/files/col3.dds")
	bcgH3 = sightexports.sGui:createGuiElement("rectangle", x + 8 + 10, y + 10 - 6, sw - 16 - 20, 12, colorPicker)
	sliderH = sightexports.sGui:createGuiElement("slider", x + 8, y, sw - 16, 20, colorPicker)
	sightexports.sGui:setSliderSize(sliderH, 20)
	sightexports.sGui:setSliderBorder(sliderH, {
		0,
		0,
		0
	}, 1)
	sightexports.sGui:setSliderChangeEvent(sliderH, "tuningColorPickerChanged")
	y = y + 20 + 8
	bcgS1 = sightexports.sGui:createGuiElement("rectangle", x + 8 + 10, y + 10 - 6, sw - 16 - 20, 12, colorPicker)
	bcgS2 = sightexports.sGui:createGuiElement("image", x + 8 + 10, y + 10 - 6, sw - 16 - 20, 12, colorPicker)
	sightexports.sGui:setImageDDS(bcgS2, ":sTuning/files/col1.dds")
	sliderS = sightexports.sGui:createGuiElement("slider", x + 8, y, sw - 16, 20, colorPicker)
	sightexports.sGui:setSliderSize(sliderS, 20)
	sightexports.sGui:setSliderBorder(sliderS, {
		0,
		0,
		0
	}, 1)
	sightexports.sGui:setSliderChangeEvent(sliderS, "tuningColorPickerChanged")
	y = y + 20 + 8
	bcgL1 = sightexports.sGui:createGuiElement("rectangle", x + 8 + 10, y + 10 - 6, (sw - 16 - 20) / 2, 12, colorPicker)
	sightexports.sGui:setGuiBackground(bcgL1, "solid", {
		0,
		0,
		0
	})
	bcgL2 = sightexports.sGui:createGuiElement("rectangle", x + 8 + 10 + (sw - 16 - 20) / 2, y + 10 - 6, (sw - 16 - 20) / 2, 12, colorPicker)
	sightexports.sGui:setGuiBackground(bcgL2, "solid", {
		255,
		255,
		255
	})
	bcgL3 = sightexports.sGui:createGuiElement("image", x + 8 + 10, y + 10 - 6, sw - 16 - 20, 12, colorPicker)
	sightexports.sGui:setImageDDS(bcgL3, ":sTuning/files/col2.dds")
	sliderL = sightexports.sGui:createGuiElement("slider", x + 8, y, sw - 16, 20, colorPicker)
	sightexports.sGui:setSliderSize(sliderL, 20)
	sightexports.sGui:setSliderBorder(sliderL, {
		0,
		0,
		0
	}, 1)
	sightexports.sGui:setSliderChangeEvent(sliderL, "tuningColorPickerChanged")
	y = y + 20 + 8
	colorHexInput = sightexports.sGui:createGuiElement("input", x + sw / 2 - 50, y, 100, 24, colorPicker)
	sightexports.sGui:setInputPlaceholder(colorHexInput, "HEX színkód")
	sightexports.sGui:setInputValue(colorHexInput, "FF0000")
	sightexports.sGui:setInputFont(colorHexInput, "10/Ubuntu-R.ttf")
	sightexports.sGui:setInputIcon(colorHexInput, "hashtag")
	sightexports.sGui:setInputMaxLength(colorHexInput, 6)
	sightexports.sGui:setInputChangeEvent(colorHexInput, "refreshTuningColorHexInput")
	local h, s, l = 0, 0, 1
	local col = {
		getVehicleColor(veh, true)
	}
	if mode == "col1" then
		h, s, l = convertRGBToHSL(col[1], col[2], col[3])
	elseif mode == "col2" then
		h, s, l = convertRGBToHSL(col[4], col[5], col[6])
	elseif mode == "col3" then
		h, s, l = convertRGBToHSL(col[7], col[8], col[9])
	elseif mode == "col4" then
		h, s, l = convertRGBToHSL(col[10], col[11], col[12])
	else
		h, s, l = convertRGBToHSL(colorPickerR, colorPickerG, colorPickerB)
	end
	sightexports.sGui:setSliderValue(sliderH, h)
	sightexports.sGui:setSliderValue(sliderS, s)
	sightexports.sGui:setSliderValue(sliderL, l)
	refreshColorPickerBcg(true)
end
addEvent("refreshTuningTextInput", false)
addEventHandler("refreshTuningTextInput", getRootElement(), function(val)
	if currentTextInput == "plate" then
		val = utf8.upper(val)
		val = val:gsub("[^%a%d-]", "")
		sightexports.sGui:setInputValue(textInput, val)
		if utf8.len(val) <= 0 then
			setVehiclePlateText(veh, "-")
		else
			setVehiclePlateText(veh, val)
		end
		textInputValue = val
	end
end)
function createTextInput(mode)
	deleteTextInput()
	showCursor(true)
	currentTextInput = mode
	local sw = 250
	local sh = 48
	textInputBcg = sightexports.sGui:createGuiElement("rectangle", screenX / 2 - sw / 2, screenY - sh - 96, sw, sh)
	sightexports.sGui:setGuiBackground(textInputBcg, "solid", "sightgrey4")
	textInput = sightexports.sGui:createGuiElement("input", 8, 8, sw - 16, 32, textInputBcg)
	sightexports.sGui:setInputFont(textInput, "10/Ubuntu-R.ttf")
	sightexports.sGui:setInputChangeEvent(textInput, "refreshTuningTextInput")
	if mode == "plate" then
		sightexports.sGui:setInputPlaceholder(textInput, "Rendszám")
		sightexports.sGui:setInputValue(textInput, getVehiclePlateText(veh))
		sightexports.sGui:setInputIcon(textInput, "car")
		sightexports.sGui:setInputMaxLength(textInput, 8)
	end
	textInputValue = sightexports.sGui:getInputValue(textInput)
	sightexports.sGui:setActiveInput(textInput)
end
local scenarioCarPositions = {
	{
		-10.081,
		8.63406,
		0.556359,
		-60
	},
	{
		-10.081,
		-0.138044,
		2.28871,
		-60,
		true
	},
	{
		-10.081,
		-8.91015,
		0.556359,
		-60
	},
	{
		9.48225,
		7.56005,
		0.556359,
		120
	}
}
local scenarioElements = {}
function createScenarioCar(id, scenario, rand)
	local model = 0
	if scenario == 1 then
		model = 549
	elseif scenario == 2 then
		model = 560
	elseif scenario == 3 then
		model = 562
	elseif scenario == 4 then
		model = 411
	elseif scenario == 5 then
		model = 439
	end
	local x, y, z = 1.71875 + scenarioCarPositions[id][1], 30.40625 + scenarioCarPositions[id][2], 1200.34375 + scenarioCarPositions[id][3]
	local r = scenarioCarPositions[id][4]
	local veh = createVehicle(model, x, y, z, 0, 0, r)
	local rad = math.rad(r)
	table.insert(scenarioElements, veh)
	setElementInterior(veh, getElementInterior(localPlayer))
	setElementDimension(veh, getElementDimension(localPlayer))
	setElementFrozen(veh, scenarioCarPositions[id][5] and true or false)
	if scenario == 1 then
		if rand == 1 then
			setVehicleColor(veh, 255, 255, 255)
		elseif rand == 2 then
			setVehicleColor(veh, 0, 0, 0)
		elseif rand == 3 then
			setVehicleColor(veh, 15, 50, 30)
		elseif rand == 4 then
			setVehicleColor(veh, 0, 15, 60)
		end
		if scenarioCarPositions[id][5] then
			setVehicleWheelStates(veh, 2, 0, 2, 0)
			local ped = createPed(rand % 2 == 1 and 268 or 309, x + math.cos(rad + pih * 0.45) * 3, y + math.sin(rad + pih * 0.45) * 3, z, r + 90)
			setElementInterior(ped, getElementInterior(localPlayer))
			setElementDimension(ped, getElementDimension(localPlayer))
			setPedAnimation(ped, "cop_ambient", "coplook_think", -1, true, false, false)
			table.insert(scenarioElements, ped)
		else
			setVehicleDoorOpenRatio(veh, 0, 1)
			local ped = createPed(rand % 2 == 1 and 268 or 50, x + math.cos(rad + pih) * 4.6, y + math.sin(rad + pih) * 4.6, z, r)
			setElementInterior(ped, getElementInterior(localPlayer))
			setElementDimension(ped, getElementDimension(localPlayer))
			setPedAnimation(ped, "car", "fixn_car_loop", -1, true, false, false)
			table.insert(scenarioElements, ped)
		end
	elseif scenario == 2 then
		setVehicleColor(veh, 255, 255, 255)
		if rand % 2 == 0 then
			addVehicleUpgrade(veh, 1028)
			addVehicleUpgrade(veh, 1169)
			addVehicleUpgrade(veh, 1141)
			addVehicleUpgrade(veh, 1032)
			addVehicleUpgrade(veh, 1030)
			addVehicleUpgrade(veh, 1014)
		elseif rand % 2 == 1 then
			addVehicleUpgrade(veh, 1029)
			addVehicleUpgrade(veh, 1032)
			addVehicleUpgrade(veh, 1001)
		end
		if not scenarioCarPositions[id][5] then
			sightexports.sNeon:initNeon(veh, true, "red", "red")
		end
		if scenarioCarPositions[id][5] then
			local ped = createPed(rand % 2 == 1 and 309 or 50, -8.3, 33.5, 1201.34375, 265)
			setElementInterior(ped, getElementInterior(localPlayer))
			setElementDimension(ped, getElementDimension(localPlayer))
			setPedAnimation(ped, "cop_ambient", "copbrowse_loop", -1, true, false, false)
			table.insert(scenarioElements, ped)
		elseif 2 < rand then
			setVehicleDoorOpenRatio(veh, 0, 1)
			local ped = createPed(rand % 2 == 1 and 268 or 309, x + math.cos(rad + pih) * 3.25, y + math.sin(rad + pih) * 3.25, z, r + 180)
			setElementInterior(ped, getElementInterior(localPlayer))
			setElementDimension(ped, getElementDimension(localPlayer))
			setPedAnimation(ped, "CASINO", "Roulette_loop", -1, true, false, false)
			table.insert(scenarioElements, ped)
		end
	elseif scenario == 3 then
		setVehicleColor(veh, 255, 255, 255)
		if rand % 2 == 0 then
			addVehicleUpgrade(veh, 1034)
			addVehicleUpgrade(veh, 1171)
			addVehicleUpgrade(veh, 1148)
			addVehicleUpgrade(veh, 1041)
			addVehicleUpgrade(veh, 1146)
		elseif rand % 2 == 1 then
			addVehicleUpgrade(veh, 1037)
			addVehicleUpgrade(veh, 1149)
			addVehicleUpgrade(veh, 1040)
		end
		if not scenarioCarPositions[id][5] then
			sightexports.sNeon:initNeon(veh, true, "orange", "orange")
		end
		if scenarioCarPositions[id][5] then
			local ped = createPed(rand % 2 == 1 and 268 or 309, -8.3, 33.5, 1201.34375, 265)
			setElementInterior(ped, getElementInterior(localPlayer))
			setElementDimension(ped, getElementDimension(localPlayer))
			setPedAnimation(ped, "cop_ambient", "copbrowse_loop", -1, true, false, false)
			table.insert(scenarioElements, ped)
		elseif 2 < rand then
			setVehicleDoorOpenRatio(veh, 0, 1)
			local ped = createPed(rand % 2 == 1 and 268 or 50, x + math.cos(rad + pih) * 2.75, y + math.sin(rad + pih) * 2.75, z, r + 180)
			setElementInterior(ped, getElementInterior(localPlayer))
			setElementDimension(ped, getElementDimension(localPlayer))
			setPedAnimation(ped, "cop_ambient", "copbrowse_loop", -1, true, false, false)
			table.insert(scenarioElements, ped)
		end
	elseif scenario == 4 then
		if rand == 1 then
			setVehicleColor(veh, 255, 5, 5, 255, 255, 255, 0, 0, 0)
		elseif rand == 2 then
			setVehicleColor(veh, 255, 215, 5, 0, 0, 0, 255, 255, 255)
		elseif rand == 3 then
			setVehicleColor(veh, 255, 255, 255, 5, 0, 60, 5, 0, 60)
		elseif rand == 4 then
			setVehicleColor(veh, 255, 5, 5, 255, 5, 5, 255, 5, 5)
		end
		if scenarioCarPositions[id][5] then
			setVehicleWheelStates(veh, 2, 0, 2, 0)
			local ped = createPed(268, x + math.cos(rad + pih * 0.45) * 3, y + math.sin(rad + pih * 0.45) * 3, z, r + 90 + 20)
			setElementInterior(ped, getElementInterior(localPlayer))
			setElementDimension(ped, getElementDimension(localPlayer))
			setPedAnimation(ped, "cop_ambient", "coplook_shake", -1, true, false, false)
			table.insert(scenarioElements, ped)
		else
			setVehicleDoorOpenRatio(veh, 0, 1)
			local ped = createPed(rand % 2 == 1 and 268 or 50, x + math.cos(rad + pih) * 3, y + math.sin(rad + pih) * 3, z, r + 180)
			setElementInterior(ped, getElementInterior(localPlayer))
			setElementDimension(ped, getElementDimension(localPlayer))
			setPedAnimation(ped, "cop_ambient", "copbrowse_loop", -1, true, false, false)
			table.insert(scenarioElements, ped)
		end
	elseif scenario == 5 then
		setVehicleColor(veh, 255, 255, 255)
		if rand <= 2 then
			setElementData(veh, "superCharger", true)
		end
		if scenarioCarPositions[id][5] then
			setVehicleWheelStates(veh, 0, 2, 0, 2)
			local ped = createPed(309, x + math.cos(rad - pih * 0.5) * 3, y + math.sin(rad - pih * 0.5) * 3, z, r + 90 - 20)
			setElementInterior(ped, getElementInterior(localPlayer))
			setElementDimension(ped, getElementDimension(localPlayer))
			setPedAnimation(ped, "cop_ambient", "coplook_think", -1, true, false, false)
			table.insert(scenarioElements, ped)
		elseif 2 < rand then
			setVehicleDoorOpenRatio(veh, 0, 1)
			local ped = createPed(rand % 2 == 1 and 268 or 50, x + math.cos(rad + pih) * 4.25, y + math.sin(rad + pih) * 4.25, z, r)
			setElementInterior(ped, getElementInterior(localPlayer))
			setElementDimension(ped, getElementDimension(localPlayer))
			setPedAnimation(ped, "car", "fixn_car_loop", -1, true, false, false)
			table.insert(scenarioElements, ped)
		end
	end
end
function createScenarioPed(id, rand)
	local skin = 268
	if rand == 2 then
		skin = 50
	elseif rand == 3 then
		skin = 309
	end
	if id == 1 then
		local ped = createPed(skin, 13.73046875, 32.1787109375, 1201.34375, 270)
		setElementInterior(ped, getElementInterior(localPlayer))
		setElementDimension(ped, getElementDimension(localPlayer))
		setPedAnimation(ped, "shop", "shp_serve_loop", -1, true, false, false)
		table.insert(scenarioElements, ped)
	elseif id == 2 then
		local ped = createPed(skin, 7.447265625, 39.90625, 1201.34375, 241)
		setElementInterior(ped, getElementInterior(localPlayer))
		setElementDimension(ped, getElementDimension(localPlayer))
		setPedAnimation(ped, "cop_ambient", "copbrowse_loop", -1, true, false, false)
		table.insert(scenarioElements, ped)
	elseif id == 3 then
		local ped = createPed(skin, 10.876953125, 19.712890625, 1201.34375, 180)
		setElementInterior(ped, getElementInterior(localPlayer))
		setElementDimension(ped, getElementDimension(localPlayer))
		setPedAnimation(ped, "cop_ambient", "coplook_shake", -1, true, false, false)
		table.insert(scenarioElements, ped)
	end
end
function deleteScenario()
	for i = 1, #scenarioElements do
		if isElement(scenarioElements[i]) then
			destroyElement(scenarioElements[i])
		end
	end
	scenarioElements = {}
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	if getElementData(localPlayer, "loggedIn") then
		triggerServerEvent("requestMoney", localPlayer)
	end
end)

local playerWarning = {}

addEvent("warnPlayerTuning", true)
addEventHandler("warnPlayerTuning", root, function(string1, string2, datas)
	playerWarning = datas
	createTuningWarning(string1, string2, "acceptWarning")
end)

function deleteWarningPrompt()
	if warningPrompt then
		sightexports.sGui:deleteGuiElement(warningPrompt)
	end
	warningPrompt = nil
	showCursor(false)
end

addEvent("declineWarning", false)
addEventHandler("declineWarning", root, function()
	buyingTuning = false
	deleteWarningPrompt()
end)

addEvent("acceptWarning", false)
addEventHandler("acceptWarning", root, function()
	buyingTuning = false
	deleteWarningPrompt()
	triggerServerEvent("tryToBuyTuning", localPlayer, playerWarning[2], playerWarning[3], false, true)
end)

function createTuningWarning(string1, string2, dat)
	deleteWarningPrompt()
	showCursor(true)
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local pw = 500
	local fh = sightexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
	local ph = titleBarHeight + 16 + fh * 6 + 32 + 8
	warningPrompt = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
	sightexports.sGui:setWindowTitle(warningPrompt, "16/BebasNeueRegular.otf", "Tuning - Figyelmeztetés")
	local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, 16 + fh * 6, warningPrompt)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelText(label, "Figyelem!\n\nMivel a járművedben található [color=sightblue]".. string1 .."[color=hudwhite], ezért a(z) [color=sightgreen]".. string2 .." \n[color=hudwhite]csak úgy beszerelhető ha az előbbi [color=sightred]kiszerelésre[color=hudwhite] kerül.\nAmennyiben elfogadod nyomd meg az [color=sightgreen]'Igen'[color=hudwhite] gombot")
	sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	local btn = sightexports.sGui:createGuiElement("button", 8, ph - 32 - 8, (pw - 16) / 2 - 4, 32, warningPrompt)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setClickEvent(btn, "acceptWarning")
	sightexports.sGui:setClickArgument(btn, dat)
	sightexports.sGui:setButtonText(btn, "Igen")
	local btn = sightexports.sGui:createGuiElement("button", pw / 2 + 4, ph - 32 - 8, (pw - 16) / 2 - 4, 32, warningPrompt)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightred",
		"sightred-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setClickEvent(btn, "declineWarning")
	sightexports.sGui:setClickArgument(btn, false)
	sightexports.sGui:setButtonText(btn, "Nem")
end