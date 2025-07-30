local sightexports = {
	sDeath = false,
	sGui = false,
	sHud = false,
	sPlate = false,
	sNames = false,
	sSpeedo = false,
	sGps = false,
	sCrosshair = false,
	sRadar = false,
	sGroups = false,
	sBorders = false,
	sAdministration = false,
	sShader = false,
	sChat = false,
	sDof = false,
	sCarshader = false,
	sOsws = false,
	sRoadshine = false,
	sRadialblur = false,
	sWatereffects = false,
	sSsao = false,
	sVoice = false,
	sAnimpanel = false,
	sClothesshop = false,
	sPointing = false,
	sCamera = false,
	sItems = false,
	sDriveby = false,
	sBillboard = false
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
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientRender", getRootElement(), streamerModePromptToFront, true, prio)
		else
			removeEventHandler("onClientRender", getRootElement(), streamerModePromptToFront)
		end
	end
end
local sliderDatas = {}
local toggleDatas = {}
local enumDatas = {}
local enumButtons = {}
local menus = {}
local currentMenu = 1
local currentChatAnim = 1
local currentFightStyle = 1
local movieShaderPreview = false
function saveValue(name, value)
	if fileExists("!dashboard/" .. name .. ".setting") then
		fileDelete("!dashboard/" .. name .. ".setting")
	end
	local fh = fileCreate("!dashboard/" .. name .. ".setting")
	if fh then
		fileWrite(fh, tostring(value))
		fileClose(fh)
	end
end
local savedFog = false
local savedFarClip = false
function getFarClipDistanceEx()
	return savedFarClip or getFarClipDistance()
end
function getFogDistanceEx()
	return savedFog or getFogDistance()
end
function setFogDistanceEx(dist)
	savedFog = dist
	if not sightexports.sDeath:isDeath() then

		if savedFarClip < dist then
			setFogDistance(savedFarClip - 1)
		else
			setFogDistance(dist)
		end
	end
end
function setFarClipDistanceEx(dist)
	savedFarClip = dist
	if not sightexports.sDeath:isDeath() then
		setFarClipDistance(dist)
	end
	local slider = menus[5].elements[2]
	if slider then
		sliderDatas[slider][3] = dist - 100
		menus[5].settings[2][4] = dist - 100
		local fog = getFogDistanceEx()
		if fog > sliderDatas[slider][3] then
			setFogDistanceEx(sliderDatas[slider][3])
			fog = sliderDatas[slider][3]
		end
		sightexports.sGui:setLabelText(sliderDatas[slider][1], math.floor(fog + 0.5))
		sightexports.sGui:setSliderValue(slider, (fog - sliderDatas[slider][2]) / (sliderDatas[slider][3] - sliderDatas[slider][2]))
	end
end
local invCodeBtn 
local crosshairColors = {
	"hudwhite",
	"sightgreen",
	"sightgreen-second",
	"sightred",
	"sightred-second",
	"sightblue",
	"sightblue-second",
	"sightyellow",
	"sightyellow-second",
	"sightorange",
	"sightorange-second",
	"sightgrey1",
	"sightgrey4",
	"sightmidgrey",
	"sightlightgrey",
	"#ffffff",
	"#000000"
}
function getVignetteLevel()
	return sightexports.sHud:getVignetteLevel()
end
function setVignetteLevel(val)
	return sightexports.sHud:setVignetteLevel(val)
end
function getVignetteState()
	return sightexports.sHud:getVignetteState()
end
function setVignetteState(val)
	return sightexports.sHud:setVignetteState(val)
end
function setPlatesVisible(state)
	if state ~= plateState then
		plateState = state
		if plateState then
			addEventHandler("onClientRender", getRootElement(), renderPlates)
		else
			removeEventHandler("onClientRender", getRootElement(), renderPlates)
		end
	end
end
function setPlatesVisible(val)
	return sightexports.sPlate:setPlatesVisible(val)
end
function getPlatesVisible()
	return sightexports.sPlate:getPlatesVisible()
end
function setSquadsVisible(val)
	return sightexports.sNames:setSquadsVisible(val)
end
function getSquadsVisible()
	return sightexports.sNames:getSquadsVisible()
end
function getHudCommandState()
	return sightexports.sHud:getHudCommandState()
end
function setHudCommandState(val)
	return sightexports.sHud:setHudCommandState(val, 1)
end
function getInfoboxChatbox()
	return sightexports.sGui:getInfoboxChatbox()
end
function setInfoboxChatbox(val)
	return sightexports.sGui:setInfoboxChatbox(val)
end
function getInfoboxSound()
	return sightexports.sGui:getInfoboxSound()
end
function setInfoboxSound(val)
	return sightexports.sGui:setInfoboxSound(val)
end
function getSpeedoUnit()
	return sightexports.sSpeedo:getUnit()
end
function setSpeedoUnit(val)
	return sightexports.sSpeedo:setUnit(val)
end
function getGpsSoundPack()
	return sightexports.sGps:getGpsSoundPack()
end
function setGpsSoundPack(val)
	return sightexports.sGps:setGpsSoundPack(val)
end
function setCrosshair(id)
	local cData = sightexports.sCrosshair:getCrosshair()
	cData[1] = id
	return sightexports.sCrosshair:setCrosshair(cData)
end
function setCrosshairColor(col)
	local cData = sightexports.sCrosshair:getCrosshair()
	if crosshairColors[col] then
		cData[2] = crosshairColors[col]
	else
		cData[2] = "hudwhite"
	end
	return sightexports.sCrosshair:setCrosshair(cData)
end
function setColorSet(val)
	return sightexports.sGui:setColorSet(val)
end
function get3DBlipState()
	return sightexports.sRadar:get3DBlipState()
end
function set3DBlipState(val)
	return sightexports.sRadar:set3DBlipState(val)
end
function get3DBlipAlpha()
	return sightexports.sRadar:get3DBlipAlpha()
end
function set3DBlipAlpha(val)
	return sightexports.sRadar:set3DBlipAlpha(val)
end
function getD2State()
	return sightexports.sGroups:getD2State()
end
function setD2State(val)
	return sightexports.sGroups:setD2State(val)
end
function getAirfieldState()
	return sightexports.sGroups:getAirfieldState()
end
function setAirfieldState(val)
	return sightexports.sGroups:setAirfieldState(val)
end
function getTogTraffi()
	return sightexports.sGroups:getTogTraffi()
end
function setTogTraffi(val)
	return sightexports.sGroups:setTogTraffi(val)
end
function getTogGroupMsg()
	return sightexports.sGroups:getTogGroupMsg()
end
function setTogGroupMsg(val)
	return sightexports.sGroups:setTogGroupMsg(val)
end
function getTogHatar()
	return sightexports.sBorders:getBorderState()
end
function setTogHatar(val)
	return sightexports.sBorders:setBorderState(val)
end
function getTogKick()
	return sightexports.sAdministration:getTogKick()
end
function setTogKick(val)
	return sightexports.sAdministration:setTogKick(val)
end
function getBlipColorState()
	return sightexports.sRadar:getBlipColorState()
end
function setBlipColorState(val)
	return sightexports.sRadar:setBlipColorState(val)
end
function getNameSize()
	return sightexports.sNames:getNameSize()
end
function setNameSize(val)
	return sightexports.sNames:setNameSize(val)
end
function getNameAlpha()
	return sightexports.sNames:getNameAlpha()
end
function setNameAlpha(val)
	return sightexports.sNames:setNameAlpha(val)
end
function getNameFont()
	return sightexports.sNames:getNameFont()
end
function setNameFont(val)
	return sightexports.sNames:setNameFont(val)
end
function getMovieShaderState()
	return sightexports.sShader:getMovieShaderState()
end
function setCurrentMoviePreset(val)
	return sightexports.sShader:setCurrentMoviePreset(val)
end
function setNamesState(val)
	return sightexports.sNames:setNamesState(val)
end
function getNamesState()
	return sightexports.sNames:getNamesState()
end
function getOOCTimestamps()
	return sightexports.sChat:getOOCTimestamps()
end
function setOOCTimestamps(val)
	return sightexports.sChat:setOOCTimestamps(val)
end
function setMovieShaderState(val)
	local target = sightexports.sShader:setMovieShaderState(val)
	if movieShaderPreview then
		if isElement(target) then
			sightexports.sGui:setImageFile(movieShaderPreview, target)
		else
			sightexports.sGui:setImageDDS(movieShaderPreview, ":sDashboard/news/def.dds")
		end
	end
end
function getMovieShaderHue()
	return sightexports.sShader:getMovieShaderData("Hue")
end
function setMovieShaderHue(val)
	return sightexports.sShader:setMovieShaderData("Hue", val)
end
function getMovieShaderBrightness()
	return sightexports.sShader:getMovieShaderData("Brightness") * 100
end
function setMovieShaderBrightness(val)
	return sightexports.sShader:setMovieShaderData("Brightness", val / 100)
end
function getMovieShaderContrast()
	return sightexports.sShader:getMovieShaderData("Contrast") * 50
end
function setMovieShaderContrast(val)
	return sightexports.sShader:setMovieShaderData("Contrast", val / 50)
end
function getMovieShaderSaturation()
	return sightexports.sShader:getMovieShaderData("Saturation") * 50
end
function setMovieShaderSaturation(val)
	return sightexports.sShader:setMovieShaderData("Saturation", val / 50)
end
function getMovieShaderR()
	return sightexports.sShader:getMovieShaderData("R") * 50
end
function setMovieShaderR(val)
	return sightexports.sShader:setMovieShaderData("R", val / 50)
end
function getMovieShaderG()
	return sightexports.sShader:getMovieShaderData("G") * 50
end
function setMovieShaderG(val)
	return sightexports.sShader:setMovieShaderData("G", val / 50)
end
function getMovieShaderB()
	return sightexports.sShader:getMovieShaderData("B") * 50
end
function setMovieShaderB(val)
	return sightexports.sShader:setMovieShaderData("B", val / 50)
end
function getMovieShaderL()
	return sightexports.sShader:getMovieShaderData("L") * 50
end
function setMovieShaderL(val)
	return sightexports.sShader:setMovieShaderData("L", val / 50)
end
function getMovieShadernoise()
	return sightexports.sShader:getMovieShaderData("noise") * 50
end
function setMovieShadernoise(val)
	return sightexports.sShader:setMovieShaderData("noise", val / 50)
end
function setDofState(val)
	sightexports.sDof:setDofState(val)
end
function getDofState()
	return sightexports.sDof:getDofState()
end
function setCarPaintState(val)
	sightexports.sCarshader:setCarPaintState(val)
end
function getCarPaintState()
	return sightexports.sCarshader:getCarPaintState()
end
function setOswsState(val)
	sightexports.sOsws:setOswsState(val)
end
function getOswsState()
	return sightexports.sOsws:getOswsState()
end
function setRoadShineState(val)
	sightexports.sRoadshine:setRoadShineState(val)
end
function getRoadShineState()
	return sightexports.sRoadshine:getRoadShineState()
end
function setRadialBlurState(val)
	sightexports.sRadialblur:setRadialBlurState(val)
end
function getRadialBlurState()
	return sightexports.sRadialblur:getRadialBlurState()
end
function setWaterEffectState(val)
	sightexports.sWatereffects:setWaterEffectState(val)
end
function getWaterEffectState()
	return sightexports.sWatereffects:getWaterEffectState()
end
function setSSAOEffectState(val)
	return sightexports.sSsao:setSSAOEffectState(val)
end
function getSSAOEffectState()
	return sightexports.sSsao:getSSAOEffectState()
end
function getBillboardState()
	return sightexports.sBillboard:getBillboardState()
end
function setBillboardState(val)
	return sightexports.sBillboard:setBillboardState(val)
end
function getHudMovementState()
	return sightexports.sHud:getHudMovementState()
end
function setHudMovementState(val)
	return sightexports.sHud:setHudMovementState(val)
end
function setVoiceVolume(val)
	sightexports.sVoice:setVoiceVolume(val)
end
function getVoiceVolume()
	return sightexports.sVoice:getVoiceVolume()
end
local streamerMode = true
function getStreamerMode()
	return streamerMode
end
addEvent("streamerModeChanged", false)
function setStreamerMode(val)
	streamerMode = val
	triggerEvent("streamerModeChanged", localPlayer, val)
end
function getAnimCircleBind()
	return sightexports.sAnimpanel:getAnimCircleBind()
end
function setAnimCircleBind(btn)
	return sightexports.sAnimpanel:setAnimCircleBind(btn)
end
function setCustomVoiceBind(bind)
	sightexports.sVoice:setCustomBind(bind)
end
function getCustomVoiceBind()
	return sightexports.sVoice:getCustomBind()
end
function getAnimPanelBind()
	return sightexports.sAnimpanel:getAnimPanelBind()
end
function setAnimPanelBind(btn)
	return sightexports.sAnimpanel:setAnimPanelBind(btn)
end
function getCuccaimBind()
	return sightexports.sClothesshop:getCuccaimBind()
end
function setCuccaimBind(btn)
	return sightexports.sClothesshop:setCuccaimBind(btn)
end
function getTempomatToggle()
	return sightexports.sSpeedo:getCruiseKey("toggle")
end
function getTempomatIncrease()
	return sightexports.sSpeedo:getCruiseKey("increase")
end
function getTempomatDecrease()
	return sightexports.sSpeedo:getCruiseKey("decrease")
end
function getTempomatMul()
	return sightexports.sSpeedo:getCruiseKey("mul")
end
function getTempomatDiv()
	return sightexports.sSpeedo:getCruiseKey("div")
end
function setTempomatToggle(btn)
	return sightexports.sSpeedo:setCruiseKey("toggle", btn)
end
function setTempomatIncrease(btn)
	return sightexports.sSpeedo:setCruiseKey("increase", btn)
end
function setTempomatDecrease(btn)
	return sightexports.sSpeedo:setCruiseKey("decrease", btn)
end
function setTempomatMul(btn)
	return sightexports.sSpeedo:setCruiseKey("mul", btn)
end
function setTempomatDiv(btn)
	return sightexports.sSpeedo:setCruiseKey("div", btn)
end
function getSpoilerKey()
	return sightexports.sSpeedo:getSpoilerKey()
end
function setSpoilerKey(btn)
	return sightexports.sSpeedo:setSpoilerKey(btn)
end
function getCurrentChatAnim()
	if currentChatAnim == #chatAnims then
		return nil
	elseif currentChatAnim == #chatAnims - 1 then
		return math.random(1, #chatAnims - 2)
	else
		return currentChatAnim
	end
end
function setCurrentChatAnim(val)
	if val <= #chatAnims then
		currentChatAnim = val
	else
		currentChatAnim = 1
	end
end
function getPointingKey()
	return sightexports.sPointing:getPointingKey()
end
function setPointingKey(btn)
	return sightexports.sPointing:setPointingKey(btn)
end
function getFpHeight()
	return sightexports.sCamera:getFpHeight()
end
function setFpHeight(val)
	return sightexports.sCamera:setFpHeight(val)
end
function getFpHeightInCar()
	return sightexports.sCamera:getFpHeightInCar()
end
function setFpHeightInCar(val)
	return sightexports.sCamera:setFpHeightInCar(val)
end
function getFpMouseSens()
	return sightexports.sCamera:getFpMouseSens()
end
function setFpMouseSens(val)
	return sightexports.sCamera:setFpMouseSens(val)
end
function getBeltKey()
	return sightexports.sSpeedo:getBeltKey()
end
function setBeltKey(val)
	return sightexports.sSpeedo:setBeltKey(val)
end
function getDownShift()
	return sightexports.sSpeedo:getDownShift()
end
function setDownShift(val)
	return sightexports.sSpeedo:setDownShift(val)
end
function getUpShift()
	return sightexports.sSpeedo:getUpShift()
end
function setUpShift(val)
	return sightexports.sSpeedo:setUpShift(val)
end
function getTogCursorKey()
	return sightexports.sGui:getTogCursorKey()
end
function setTogCursorKey(val)
	return sightexports.sGui:setTogCursorKey(val)
end
--[[
getPullingKey,
setPullingKey,]]

function getPullingKey()
	return sightexports.sDriveby:getPullingKey()
end
function setPullingKey(val)
	return sightexports.sDriveby:setPullingKey(val)
end

function getSirenKey()
	return sightexports.sSpeedo:getSirenKey()
end
function setSirenKey(val)
	return sightexports.sSpeedo:setSirenKey(val)
end

movieShaderNames = {
	"Egyedi",
	"Csomag #1",
	"Csomag #2",
	"Csomag #3",
	"Csomag #4",
	"Csomag #5",
	"Csomag #6",
	"Csomag #7",
	"Csomag #8",
	"Csomag #9",
	"Csomag #10",
	"Csomag #11"
}
local playerInviteCode = "SIGHT"
menus = {
	{
		name = "Megjelenés",
		settings = {
			{
				"Vignette effekt",
				"toggle",
				getVignetteState,
				setVignetteState,
				true,
				"vignetteState"
			},
			{
				"Vignette erősség",
				"slider",
				0,
				100,
				getVignetteLevel,
				setVignetteLevel,
				"vignetteLevel"
			},
			{"line"},
			{
				"movieShaderStart"
			},
			{
				"SightMTA grafika",
				"toggle",
				getMovieShaderState,
				setMovieShaderState,
				true,
				"movieShaderState_v4"
			},
			{
				"Grafikai csomag",
				"movieShaderPreset"
			},
			{
				"Árnyalat",
				"slider",
				0,
				360,
				getMovieShaderHue,
				setMovieShaderHue,
				"movieShaderHue_v4"
			},
			{
				"Fényerő",
				"slider",
				-100,
				100,
				getMovieShaderBrightness,
				setMovieShaderBrightness,
				"movieShaderBrightness_v4"
			},
			{
				"Kontraszt",
				"slider",
				-100,
				100,
				getMovieShaderContrast,
				setMovieShaderContrast,
				"movieShaderContrast_v4"
			},
			{
				"Telítettség",
				"slider",
				0,
				100,
				getMovieShaderSaturation,
				setMovieShaderSaturation,
				"movieShaderSaturation_v4"
			},
			{
				"Vörös",
				"slider",
				0,
				100,
				getMovieShaderR,
				setMovieShaderR,
				"movieShaderR_v4"
			},
			{
				"Zöld",
				"slider",
				0,
				100,
				getMovieShaderG,
				setMovieShaderG,
				"movieShaderG_v4"
			},
			{
				"Kék",
				"slider",
				0,
				100,
				getMovieShaderB,
				setMovieShaderB,
				"movieShaderB_v4"
			},
			{
				"Fényesség",
				"slider",
				0,
				100,
				getMovieShaderL,
				setMovieShaderL,
				"movieShaderL_v4"
			},
			{
				"Zaj",
				"slider",
				0,
				100,
				getMovieShadernoise,
				setMovieShadernoise,
				"movieShadernoise_v4"
			},
			{
				"movieShaderEnd"
			},
			{"line"},
			{
				"Mélységélesség",
				"toggle",
				getDofState,
				setDofState,
				false,
				"dofState"
			},
			{
				"Jármű tükröződés",
				"toggle",
				getCarPaintState,
				setCarPaintState,
				false,
				"carPaint"
			},
			{
				"Víz tükröződés",
				"toggle",
				getOswsState,
				setOswsState,
				false,
				"osws"
			},
			{
				"Napfény",
				"toggle",
				getRoadShineState,
				setRoadShineState,
				false,
				"roadShine"
			},
			{
				"Mozgási elmosódás",
				"toggle",
				getRadialBlurState,
				setRadialBlurState,
				false,
				"radialBlur"
			},
			{
				"Vízcseppek",
				"toggle",
				getWaterEffectState,
				setWaterEffectState,
				false,
				"waterEffects"
			},
			{
				"Környezet árnyékai",
				"toggle",
				getSSAOEffectState,
				setSSAOEffectState,
				false,
				"SSAOEffects"
			},
			{
				"Hirdetőtáblák",
				"toggle",
				getBillboardState,
				setBillboardState,
				true,
				"billboardState"
			},
		},
		labels = {},
		elements = {}
	},
	{
		name = "Színséma",
		settings = {
			{"Színséma", "colorset"},
			{"line"},
			{
				"Példa",
				"colorsetTest"
			}
		},
		labels = {},
		elements = {}
	},
	{
		name = "Felület",
		settings = {
			{
				"HUD megjelenítése",
				"toggle",
				getHudCommandState,
				setHudCommandState,
				false,
				"hudState"
			},
			{"line"},
			{
				"Radar ikonok színe",
				"enum",
				{
					"Színes",
					"Fehér",
					"Fekete",
					"Szürke"
				},
				getBlipColorState,
				setBlipColorState,
				"radarBlipColorState"
			},
			{
				"3D blipek megjelenítése",
				"toggle",
				get3DBlipState,
				set3DBlipState,
				true,
				"radar3DBlipState"
			},
			{
				"3D blipek átlátszósága",
				"slider",
				75,
				255,
				get3DBlipAlpha,
				set3DBlipAlpha,
				"radar3DBlipAlpha"
			},
			{"line"},
			{
				"Kilóméteróra mértékegység",
				"enum",
				{"KM/H", "MPH"},
				getSpeedoUnit,
				setSpeedoUnit,
				"speedoUnit"
			},
			{"line"},
			{
				"Nevek megjelenítése",
				"toggle",
				getNamesState,
				setNamesState,
				false,
				"namesState"
			},
			{
				"Név méret",
				"slider",
				0,
				100,
				getNameSize,
				setNameSize,
				"nameSize"
			},
			{
				"Név átlátszóság",
				"slider",
				75,
				255,
				getNameAlpha,
				setNameAlpha,
				"nameAlpha"
			},
			{
				"Név betűtípus",
				"enumNameFont",
				{
					"Betűtípus #1",
					"Betűtípus #2"
				},
				getNameFont,
				setNameFont,
				"nameFont"
			},
			{"line"},
			{
				"Célkereszt",
				"crosshair"
			},
			{
				"Célkereszt színe",
				"crosshairColor"
			},
			{"line"},
			{
				"Rendszámtáblák megjelenítése",
				"toggle",
				getPlatesVisible,
				setPlatesVisible,
				false,
				"plateState"
			},
			{
				"Egységszámok megjelenítése",
				"toggle",
				getSquadsVisible,
				setSquadsVisible,
				false,
				"squadState"
			},
			{
				"Mozgó HUD",
				"toggle",
				getHudMovementState,
				setHudMovementState,
				true,
				"hudMovementState"
			},
		},
		labels = {},
		elements = {}
	},
	{
		name = "Chat",
		settings = {
			{
				"Infoboxok kiírása chatre",
				"toggle",
				getInfoboxChatbox,
				setInfoboxChatbox,
				false,
				"infoboxChatbox"
			},
			{
				"Infoboxok hangja",
				"toggle",
				getInfoboxSound,
				setInfoboxSound,
				false,
				"infoboxChatbox"
			},
			{
				"Kick üzenetek",
				"toggle",
				getTogKick,
				setTogKick,
				false,
				"togkick"
			},
			{"line"},
			{
				"Frakció üzenetek",
				"toggle",
				getTogGroupMsg,
				setTogGroupMsg,
				true,
				"toggroupmsg"
			},
			{
				"/d2 megjelenítése",
				"toggle",
				getD2State,
				setD2State,
				false,
				"d2State"
			},
			{
				"Légtér értesítések",
				"toggle",
				getAirfieldState,
				setAirfieldState,
				false,
				"airfieldState"
			},
			{
				"Traffipax értesítések (Rendvédelem)",
				"toggle",
				getTogTraffi,
				setTogTraffi,
				false,
				"togtraffi"
			},
			{
				"Határ értesítések (Rendvédelem)",
				"toggle",
				getTogHatar,
				setTogHatar,
				false,
				"toghatar"
			},
			{"line"},
			{
				"OOC Chat időbélyegek",
				"toggle",
				getOOCTimestamps,
				setOOCTimestamps,
				false,
				"oocTimestamps"
			}
		},
		labels = {},
		elements = {}
	},
	{
		name = "Karakter és játékmenet",
		settings = {
			{
				"Látóhatár",
				"slider",
				300,
				6000,
				getFarClipDistanceEx,
				setFarClipDistanceEx,
				"farClipDistance"
			},
			{
				"Köd távolság",
				"slider",
				10,
				getFarClipDistanceEx() - 100,
				getFogDistanceEx,
				setFogDistanceEx,
				"fogDistance"
			},
			{"line"},
			{
				"Voice hangerő",
				"slider",
				0,
				100,
				getVoiceVolume,
				setVoiceVolume,
				"voiceVolume"
			},
			{"line"},
			{
				"GPS hang",
				"enum",
				{
					"Női",
					"Férfi",
					"Kikapcsolva"
				},
				getGpsSoundPack,
				setGpsSoundPack,
				"gpsSoundPack"
			},
			{"line"},
			{
				"Streamer mód",
				"toggle",
				getStreamerMode,
				setStreamerMode,
				true,
				"streamerMode"
			},
			{
				"Streamer módban az összes jogvédett zene lenémításra kerül.",
				"text"
			},
			{"line"},
			{
				"Sétastílus",
				"walkingStyle"
			},
			{
				"Harcstílus",
				"fightingStyle"
			},
			{
				"Beszéd animáció",
				"chatAnim"
			},
			{"line"},
			{
				"First Person magasság",
				"slider",
				0,
				100,
				getFpHeight,
				setFpHeight,
				"fpHeight"
			},
			{
				"First Person magasság járműben",
				"slider",
				0,
				100,
				getFpHeightInCar,
				setFpHeightInCar,
				"fpHeightCar"
			},
			{
				"First Person egérérzékenység",
				"slider",
				0,
				100,
				getFpMouseSens,
				setFpMouseSens,
				"fpMouse"
			}
		},
		labels = {},
		elements = {}
	},
	{
		name = "Irányítás",
		settings = {
			{
				"Voice egyedi nyomógomb",
				"keyBind",
				getCustomVoiceBind,
				setCustomVoiceBind,
				"voice",
				"q"
			},
			{"line"},
			{
				"Animációk gyors elérése",
				"keyBind",
				getAnimCircleBind,
				setAnimCircleBind,
				"animcircle",
				"mouse3"
			},
			{
				"Animáció lista",
				"keyBind",
				getAnimPanelBind,
				setAnimPanelBind,
				"animpanel",
				"F2"
			},
			{"line"},
			{
				"Kiegészítők",
				"keyBind",
				getCuccaimBind,
				setCuccaimBind,
				"cuccaim",
				"F9"
			},
			{"line"},
			{
				"Mutatás",
				"keyBind",
				getPointingKey,
				setPointingKey,
				"pointing",
				"x"
			},
			{"line"},
			{
				"Tempomat be/ki",
				"keyBind",
				getTempomatToggle,
				setTempomatToggle,
				"tempotoggle",
				"c"
			},
			{
				"Tempomat sebesség +",
				"keyBind",
				getTempomatIncrease,
				setTempomatIncrease,
				"tempoup",
				"num_add"
			},
			{
				"Tempomat sebesség -",
				"keyBind",
				getTempomatDecrease,
				setTempomatDecrease,
				"tempodown",
				"num_sub"
			},
			{
				"Tempomat távolság +",
				"keyBind",
				getTempomatMul,
				setTempomatMul,
				"tempodistup",
				"num_mul"
			},
			{
				"Tempomat távolság -",
				"keyBind",
				getTempomatDiv,
				setTempomatDiv,
				"tempodistdown",
				"num_div"
			},
			{
				"Active Spoiler",
				"keyBind",
				getSpoilerKey,
				setSpoilerKey,
				"activespoiler",
				"num_5"
			},
			{
				"Biztonsági öv",
				"keyBind",
				getBeltKey,
				setBeltKey,
				"seatbelt",
				"F5"
			},
			{
				"Sebességváltó -",
				"keyBind",
				getDownShift,
				setDownShift,
				"downshift",
				"lctrl"
			},
			{
				"Sebességváltó +",
				"keyBind",
				getUpShift,
				setUpShift,
				"upshift",
				"lshift"
			},
			{"line"},
			{
				"Kurzor mód (nyomva tartva)",
				"keyBind",
				getTogCursorKey,
				setTogCursorKey,
				"togcursor",
				"lalt"
			},
			{"line"},
			{
				"Pullozás",
				"keyBind",
				getPullingKey,
				setPullingKey,
				"pullkey",
				"x"
			},
			{"line"},
			{
				"Villogó",
				"keyBind",
				getSirenKey,
				setSirenKey,
				"sirenKey",
				"p"
			}
		},
		labels = {},
		elements = {}
	},
	{
		name = "Meghívókód",
		settings = {
			{
				"Amennyiben a te meghívókódoddal regisztrálnak, értékes [color=sightgreen]jutalmakat [color=hudwhite]kaphatsz érte.",
				"text",
			},
			{
				"meghívókódod a rendszer [color=sightgreen]automatikusan[color=hudwhite] generálja, azonban lehetőséged van ezt személyre szabni",
				"text",
			},
			{
				"amennyiben a vezetőség [color=sightgreen]jóváhagyja, [color=hudwhite]igényelhetsz saját-egyedi [color=sightgreen]névreszóló[color=hudwhite] meghívókódot!",
				"text",
			},
			{"line"},
			{
				"Meghívókódod",
				"inviteCode",
				playerInviteCode
			},
			{"line"},
			{
				"Meghívott emberek",
				"invitedMembers"
			},
			{
				"line"
			},
			{
				"Jutalmak",
				"awardDetails"
			},
		},
		labels = {},
		elements = {}
	},
}



local inside = false
function settingsInsideDestroy()
	inside = false
	movieShaderPreview = false
	sliderDatas = {}
	toggleDatas = {}
	enumDatas = {}
	enumButtons = {}
end
local rtg = false
local sx, sy = 0, 0
local buttonsWidth = 0
local fontSize = 0
local buttonsHeight = 0
local colorSetLabel = false
local colorSetSave = false
local colorSetTmp = false
local colorSetRectangles = {}
local colorSetTestWindow = false
local colorSetTestBtn = {}
local colorSetTestRect = {}
local colorSetTestImg = {}
local colorSetTestLabel = {}
local crosshairImages = {}
local crosshairColorRect = false
local movieShaderPresetLabel = false
local walkingStyleLabel = false
local chatAnimLabel = false
local moviePresetLocation = false
local movieShaderStartY = 0
local bindInProgress = false
local bindData = {}
local bindButtonDatas = {}
local bindButtonCache = {}
function bindKeyEvent(key, por)
	if key and por then
		removeEventHandler("onClientKey", getRootElement(), bindKeyEvent)
		local x, y = sightexports.sGui:getGuiPosition(bindData.bindElement)
		local sx, sy = sightexports.sGui:getGuiSize(bindData.bindElement)
		local parent = sightexports.sGui:getGuiParent(bindData.bindElement)
		sightexports.sGui:deleteGuiElement(bindData.bindElement)
		local defaultValue = bindButtonDatas.defaultValue
		bindButtonCache[bindData.bindElement] = nil
		local fontSize = screenX < 1600 and 11 or 12
		local button = "Nincs"
		if key == "escape" then
			bindButtonDatas.setter(false)
		else
			bindButtonDatas.setter(key)
		end
		local bind = bindButtonDatas.getter()
		saveValue(bindButtonDatas.saveValue, tostring(bind))
		if bind then
			button = utf8.upper(bind)
		end
		local w = sightexports.sGui:getTextWidthFont(button, fontSize + 2 .. "/BebasNeueBold.otf") + 8
		bindData.bindElement = sightexports.sGui:createGuiElement("button", x, y, math.max(w, sy), sy, inside)
		sightexports.sGui:setButtonFont(bindData.bindElement, fontSize + 2 .. "/BebasNeueBold.otf")
		sightexports.sGui:setButtonTextColor(bindData.bindElement, "sightgrey1")
		sightexports.sGui:setButtonText(bindData.bindElement, button)
		sightexports.sGui:setGuiBackground(bindData.bindElement, "solid", "#ffffff")
		sightexports.sGui:setGuiHover(bindData.bindElement, "gradient", {
			"sightlightgrey",
			"#ffffff"
		}, true)
		sightexports.sGui:setClickEvent(bindData.bindElement, "startBindingProcess")
		bindButtonCache[bindData.bindElement] = {}
		bindButtonCache[bindData.bindElement].getter = bindButtonDatas.getter
		bindButtonCache[bindData.bindElement].setter = bindButtonDatas.setter
		bindButtonCache[bindData.bindElement].saveValue = bindButtonDatas.saveValue
		bindButtonCache[bindData.bindElement].defaultValue = bindButtonDatas.defaultValue
		if bind and utf8.lower(bind) ~= utf8.lower(defaultValue) then
			local btn2 = sightexports.sGui:createGuiElement("image", x + math.max(w, sy) + dashboardPadding[3] * 2, y, 24, 24, inside)
			sightexports.sGui:setImageFile(btn2, sightexports.sGui:getFaIconFilename("undo", 24))
			sightexports.sGui:setGuiHoverable(btn2, true)
			sightexports.sGui:setGuiHover(btn2, "solid", "sightred")
			sightexports.sGui:guiSetTooltip(btn2, "Alapértelmezett beállítás")
			sightexports.sGui:setClickEvent(btn2, "resetBind")
			bindButtonCache[btn2] = {}
			bindButtonCache[btn2].bindElement = bindData.bindElement
			bindButtonCache[btn2].setter = bindButtonDatas.setter
			bindButtonCache[btn2].saveValue = bindButtonDatas.saveValue
			bindButtonCache[btn2].value = bindButtonDatas.defaultValue
			bindButtonCache[bindData.bindElement].resetElement = btn2
		end
		bindInProgress = false
	end
	cancelEvent()
end
addEvent("startBindingProcess", true)
addEventHandler("startBindingProcess", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if not bindInProgress then
		bindInProgress = true
		bindData = {}
		bindData.bindElement = el
		bindButtonDatas.getter = bindButtonCache[el].getter
		bindButtonDatas.setter = bindButtonCache[el].setter
		bindButtonDatas.saveValue = bindButtonCache[el].saveValue
		bindButtonDatas.defaultValue = bindButtonCache[el].defaultValue
		local x, y = sightexports.sGui:getGuiPosition(el)
		local sx, sy = sightexports.sGui:getGuiSize(el)
		local parent = sightexports.sGui:getGuiParent(el)
		sightexports.sGui:deleteGuiElement(el)
		if bindButtonCache[el].resetElement then
			sightexports.sGui:deleteGuiElement(bindButtonCache[el].resetElement)
			bindButtonCache[bindButtonCache[el].resetElement] = nil
		end
		local fontSize = screenX < 1600 and 11 or 12
		bindData.bindElement = sightexports.sGui:createGuiElement("label", x, y, 1024, sy, parent)
		sightexports.sGui:setLabelFont(bindData.bindElement, fontSize .. "/Ubuntu-L.ttf")
		sightexports.sGui:setLabelAlignment(bindData.bindElement, "left", "center")
		sightexports.sGui:setLabelText(bindData.bindElement, "Nyomj egy gombot a beállításhoz, ESC gombot a bind törléséhez.")
		addEventHandler("onClientKey", getRootElement(), bindKeyEvent)
	end
end)
addEvent("resetBind", true)
addEventHandler("resetBind", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if not bindInProgress then
		local data = bindButtonCache[el]
		if data then
			sightexports.sGui:deleteGuiElement(el)
			saveValue(data.saveValue, data.value)
			data.setter(data.value)
			local fontSize = screenX < 1600 and 11 or 12
			local w = sightexports.sGui:getTextWidthFont(utf8.upper(data.value), fontSize + 2 .. "/BebasNeueBold.otf") + 8
			local x, y = sightexports.sGui:getGuiSize(data.bindElement)
			sightexports.sGui:setGuiSize(data.bindElement, math.max(y, w), y)
			sightexports.sGui:setButtonText(data.bindElement, utf8.upper(data.value))
			bindButtonCache[el] = nil
		end
	end
end)
local currentWalkingStyle = 1

awardButtons = {}
doneImages = {}
awardScrollIndex = 0
maxAwardsVisible = 10


local awardListWidth = 0
local awardScrollThumbY = 0

function processAwardsSteps()
	if not awardButtons then return end
	if not doneImages then return end

	local buttonWidth = 90
	local gap = (awardListWidth - maxAwardsVisible * buttonWidth) / (maxAwardsVisible + 1)

	for i = 1, #awardButtons do
		local isVisible = i > awardScrollIndex and i <= awardScrollIndex + maxAwardsVisible
		sightexports.sGui:setGuiRenderDisabled(awardButtons[i], not isVisible)
		sightexports.sGui:setGuiRenderDisabled(doneImages[i], not isVisible)

		local targetX = gap * i + buttonWidth * (i - 1) - awardScrollIndex * (gap + buttonWidth)
		local _, y = sightexports.sGui:getGuiPosition(awardButtons[i])
		sightexports.sGui:setGuiPosition(awardButtons[i], targetX, y)
	end

	if not awardScrollThumb then return end

	local scrollTrackWidth = awardListWidth - 2 * gap
	local totalVisible = maxAwardsVisible
	local totalAwards = #awardDetails
	local maxScrollIndex = totalAwards - totalVisible

	local thumbWidth = math.max((totalVisible / totalAwards) * scrollTrackWidth, 20)
	local thumbX = gap

	if maxScrollIndex > 0 then
		local scrollRatio = awardScrollIndex / maxScrollIndex
		thumbX = gap + (scrollTrackWidth - thumbWidth) * scrollRatio
	end

	sightexports.sGui:setGuiSize(awardScrollThumb, thumbWidth, 5)
	sightexports.sGui:setGuiPosition(awardScrollThumb, thumbX, awardScrollThumbY)
end

addEvent("onBackButtonClick", false)
addEventHandler("onBackButtonClick", root, function(button, state, absoluteX, absoluteY, el)
	if awardScrollIndex > 0 then
		awardScrollIndex = awardScrollIndex - 1
		processAwardsSteps()
	end
end)

addEvent("onForwardButtonClick", false)
addEventHandler("onForwardButtonClick", root, function(button, state, absoluteX, absoluteY, el)
	if awardScrollIndex < #awardDetails - maxAwardsVisible then
		awardScrollIndex = awardScrollIndex + 1
		processAwardsSteps()
	end
end)


invitedMembers = {}

addEvent("gotPlayerInvitations", true)
addEventHandler("gotPlayerInvitations", root, function(memberTable)
	invitedMembers = memberTable
	processInvitedMembersList()
end)

addEvent("gotPlayerAwardData", true)
addEventHandler("gotPlayerAwardData", root, function(awardTable)
	for awardIndex, awardData in pairs(awardTable) do
		if awardData.done then
			awardDetails[awardIndex].done = true
			awardDetails[awardIndex].taken = awardData.taken
			if awardButtons[awardIndex] then
				if awardDetails[awardIndex].taken then
					sightexports.sGui:setImageColor(doneImages[awardIndex], "sightyellow")
				end
				sightexports.sGui:setGuiBackground(awardButtons[awardIndex], "solid", awardDetails[awardIndex].done and (awardDetails[awardIndex].reward[2] == "premium" and "sightpurple" or "sightgreen") or "sightgrey2")
				sightexports.sGui:setGuiHover(awardButtons[awardIndex], "gradient", awardDetails[awardIndex].done and (awardDetails[awardIndex].reward[2] == "premium" and {"sightpurple", "sightpurple-second"} or {"sightgreen", "sightgreen-second"}) or {"sightgrey2", "sightgrey3"}, false, true)
			end
		end
	end	
end)

addEvent("updatePlayerAwardData", true)
addEventHandler("updatePlayerAwardData", root, function(awardIndex, state)
	awardDetails[awardIndex].taken = state
	sightexports.sGui:setImageColor(doneImages[awardIndex], "sightyellow")
end)

function convertTimestampToDate(timestamp)
    local currentTime = getRealTime()
    local timeData = getRealTime(timestamp)
    
    if not timeData then 
        return "Hibás timestamp!" 
    end

    local year = timeData.year + 1900
    local month = timeData.month + 1
    local day = timeData.monthday

    local lastLoginTimestamp = timeData.timestamp

    local timeDiff = currentTime.timestamp - lastLoginTimestamp
    local daysDiff = math.floor(timeDiff / (24 * 60 * 60))

    local formattedDate = string.format("%04d.%02d.%02d", year, month, day)

    if daysDiff > 15 then
        return string.format("[color=sightyellow]%s", formattedDate)
    else
        return formattedDate
    end
end

invitedMembersScroll = 0
invitedVisibleRows = 0
invitedRowHeight = 28
invitedListBackground = nil
invitedListWidth = 0
invitedListElements = {}
invitedListScrollBar = nil
selectedInvitedIndex = selectedInvitedIndex or 1
selectedMemberY = 0
function processInvitedMembersList()
	if not invitedListBackground or not sightexports.sGui:isGuiElementValid(invitedListBackground) then return end
	
	local totalRows = #invitedMembers
	local maxScroll = math.max(0, totalRows - invitedVisibleRows)
	if invitedMembersScroll > maxScroll then
		invitedMembersScroll = maxScroll
	end

	if totalRows == 0 then
		selectedInvitedIndex = -1
		return
	end

	if selectedInvitedIndex == -1 then return end

	for i = 1, #invitedListElements do
		for j = 1, #invitedListElements[i] do
			if sightexports.sGui:isGuiElementValid(invitedListElements[i][j]) then
				sightexports.sGui:setGuiRenderDisabled(invitedListElements[i][j], true)
			end
		end
	end
	
	invitedListElements = {}
	processSelectedInviteMember(selectedMemberY, inside)

	for i = 1, invitedVisibleRows do
		local dataIndex = i + invitedMembersScroll
		if invitedMembers[dataIndex] then
			local rowY = (i - 1) * invitedRowHeight
			
			invitedListElements[i] = {}
			
			local isSelected = dataIndex == selectedInvitedIndex
			local rowButton = sightexports.sGui:createGuiElement("button", 0, rowY, invitedListWidth, invitedRowHeight, invitedListBackground)
			sightexports.sGui:setGuiBackground(rowButton, "solid", isSelected and "sightgrey3" or "sightgrey1")
			sightexports.sGui:setGuiHover(rowButton, "gradient", {"sightgrey2", "sightgrey1"}, false, true)
			sightexports.sGui:setGuiHoverable(rowButton, not isSelected)
			sightexports.sGui:setButtonText(rowButton, "")
			sightexports.sGui:setClickEvent(rowButton, "onInvitedMemberClick")
			sightexports.sGui:setClickArgument(rowButton, dataIndex)
			table.insert(invitedListElements[i], rowButton)
			
			local nameLabel = sightexports.sGui:createGuiElement("label", 10, 0, invitedListWidth / 2 - 20, invitedRowHeight, rowButton)
			sightexports.sGui:setLabelText(nameLabel, (invitedMembers[dataIndex][10] == 1 and "[color=sightgreen]" or "[color=sightmidgrey]")..invitedMembers[dataIndex][2]:gsub("_", " "))
			sightexports.sGui:setLabelFont(nameLabel, "11/BebasNeueBold.otf")
			sightexports.sGui:setLabelAlignment(nameLabel, "left", "center")
			table.insert(invitedListElements[i], nameLabel)
			
			local dateLabel = sightexports.sGui:createGuiElement("label", invitedListWidth - 80 - 4, 0, 70, invitedRowHeight, rowButton)
			sightexports.sGui:setLabelText(dateLabel, convertTimestampToDate(invitedMembers[dataIndex][3])) --Utoljara elerheto
			sightexports.sGui:setLabelFont(dateLabel, "11/BebasNeueBold.otf")
			sightexports.sGui:setLabelAlignment(dateLabel, "right", "center")
			sightexports.sGui:setLabelColor(dateLabel, "sightgreen")
			table.insert(invitedListElements[i], dateLabel)
			
			local divider = sightexports.sGui:createGuiElement("hr", 0, invitedRowHeight - 1, invitedListWidth, 2, rowButton)
			sightexports.sGui:setGuiBackground(divider, "solid", "sightgrey2")
			table.insert(invitedListElements[i], divider)
		end
	end

	if not invitedListScrollBar or not sightexports.sGui:isGuiElementValid(invitedListScrollBar) then
		local listHeight = invitedVisibleRows * invitedRowHeight
		scrollbarBg = sightexports.sGui:createGuiElement("rectangle", invitedListWidth - 4, 0, 4, listHeight, invitedListBackground)
		sightexports.sGui:setGuiBackground(scrollbarBg, "solid", "sightgrey3")
	  
		invitedListScrollBar = sightexports.sGui:createGuiElement("rectangle", invitedListWidth - 4, 0, 4, listHeight, invitedListBackground)
		sightexports.sGui:setGuiBackground(invitedListScrollBar, "solid", "sightmidgrey")
	end

	if invitedListScrollBar and sightexports.sGui:isGuiElementValid(invitedListScrollBar) then
		local listHeight = invitedVisibleRows * invitedRowHeight

		if totalRows <= 8 then
			sightexports.sGui:setGuiRenderDisabled(invitedListScrollBar, true)
			sightexports.sGui:setGuiRenderDisabled(scrollbarBg, true)
			return
		end


		local barHeight = math.max(10, listHeight * (invitedVisibleRows / totalRows))
		local barY = (listHeight - barHeight) * (invitedMembersScroll / maxScroll)
		sightexports.sGui:setGuiSize(invitedListScrollBar, false, barHeight)
		sightexports.sGui:setGuiPosition(invitedListScrollBar, false, barY)

		sightexports.sGui:guiToFront(scrollbarBg)
		sightexports.sGui:guiToFront(invitedListScrollBar)
	end
end

addEvent("onInvitedMemberClick", false)
addEventHandler("onInvitedMemberClick", root, function(button, state, absoluteX, absoluteY, el, index)
	selectedInvitedIndex = index
	processInvitedMembersList()

	if invitedMembers[index] then
		local y = sightexports.sGui:getGuiPosition(invitedListBackground)
		local h = sightexports.sGui:getGuiSize(invitedListBackground)
		processSelectedInviteMember(selectedMemberY, inside)
	end
end)

addEvent("getAwardPrize", false)
addEventHandler("getAwardPrize", root, function(button, state, absoluteX, absoluteY, el, index)
	triggerServerEvent("givePlayerAwardPrize", localPlayer, index)	
end)

function processSelectedInviteMember(y, inside)
	local listWidth = invitedListWidth
	local listHeight = 60
	local xLine = buttonsWidth + dashboardPadding[3] * 4

	if sightexports.sGui:isGuiElementValid(invitedDataBackground) then
		sightexports.sGui:deleteGuiElement(invitedDataBackground)
	end

	invitedDataBackground = sightexports.sGui:createGuiElement("rectangle", xLine, y, listWidth, listHeight, inside)
	sightexports.sGui:setGuiBackground(invitedDataBackground, "solid", "sightgrey1")

	if selectedInvitedIndex == -1 then
		local text = sightexports.sGui:createGuiElement("label", 0, 0, listWidth, listHeight, invitedDataBackground)
		sightexports.sGui:setLabelText(text, "Még nem hívtál meg játékost a szerverre!")
		sightexports.sGui:setLabelFont(text, "11/BebasNeueBold.otf")
		sightexports.sGui:setLabelAlignment(text, "center", "center")
		sightexports.sGui:setLabelColor(text, "sightmidgrey")
	end

	if selectedInvitedIndex == -1 then
		return
	end
	local dataLabel = sightexports.sGui:createGuiElement("label", 0, 5, listWidth, listHeight, invitedDataBackground)
	sightexports.sGui:setLabelText(dataLabel, "Játékos adatai:")
	sightexports.sGui:setLabelFont(dataLabel, "11/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(dataLabel, "center", "top")
	sightexports.sGui:setLabelColor(dataLabel, "hudwhite")

	local playerName = sightexports.sGui:createGuiElement("label", 5, 8, listWidth, listHeight, invitedDataBackground)
	sightexports.sGui:setLabelText(playerName, invitedMembers[selectedInvitedIndex][2]:gsub("_", " "))
	sightexports.sGui:setLabelFont(playerName, "11/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(playerName, "left", "center")
	sightexports.sGui:setLabelColor(playerName, "hudwhite")

	local lastOnline = sightexports.sGui:createGuiElement("label", 0, 8, listWidth, listHeight, invitedDataBackground)
	sightexports.sGui:setLabelText(lastOnline, "Utoljára elérhető: "..(convertTimestampToDate(invitedMembers[selectedInvitedIndex][3]) or "[color=sightred]UNKNOWN")) --Utoljara elerheto
	sightexports.sGui:setLabelFont(lastOnline, "11/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(lastOnline, "center", "center")
	sightexports.sGui:setLabelColor(lastOnline, "hudwhite")

	local playerLevel = sightexports.sGui:createGuiElement("label", -5, 8, listWidth, listHeight, invitedDataBackground)
	sightexports.sGui:setLabelText(playerLevel, "Szint: "..(exports.sCore:getLevel(invitedMembers[selectedInvitedIndex][4]) or "[color=sightred]UNKNOWN"))
	sightexports.sGui:setLabelFont(playerLevel, "11/BebasNeueBold.otf")
	sightexports.sGui:setLabelAlignment(playerLevel, "right", "center")
	sightexports.sGui:setLabelColor(playerLevel, "hudwhite")
end

function drawSettingsMenu()
	sliderDatas = {}
	if inside then
		sightexports.sGui:deleteGuiElement(inside)
	end
	inside = sightexports.sGui:createGuiElement("null", 0, 0, sx, sy, rtg)
	local fontSize = 12
	local dh = 24
	local h = dh
	local gs = 20
	if screenX < 1600 then
		fontSize = 11
		dh = 20
		h = dh
		gs = 16
	end
	local w = 0
	local x = buttonsWidth + dashboardPadding[3] * 4
	local y = dashboardPadding[3] * 4
	local image = sightexports.sGui:createGuiElement("image", sx + dashboardPadding[3] * 8 - 512, sy + dashboardPadding[3] * 8 - 512, 512, 512, inside)
	sightexports.sGui:setImageDDS(image, ":sDashboard/files/settings_bcg_big.dds")
	local lastLine = 0
	for k = 1, #menus[currentMenu].settings do
		if menus[currentMenu].settings[k][1] == "movieShaderStart" or menus[currentMenu].settings[k][1] == "movieShaderEnd" then
		elseif menus[currentMenu].settings[k][1] == "line" then
			y = y + 2 + dashboardPadding[3] * 2
			lastLine = y
		else
			if menus[currentMenu].settings[k][2] == "crosshair" then
				h = 64
			else
				h = dh
			end
			if menus[currentMenu].settings[k][2] ~= "awardDetails" then 
				local label = sightexports.sGui:createGuiElement("label", x, y, 0, h, inside)
				sightexports.sGui:setLabelFont(label, math.max(fontSize - (menus[currentMenu].settings[k][2] == "text" and 1 or 0), 11) .. "/Ubuntu-L.ttf")
				sightexports.sGui:setLabelAlignment(label, "left", "center")
				sightexports.sGui:setLabelText(label, menus[currentMenu].settings[k][1] .. (menus[currentMenu].settings[k][2] ~= "text" and ": " or ""))
				local tw = sightexports.sGui:getLabelTextWidth(label)
				if menus[currentMenu].settings[k][2] ~= "text" and w < tw then
					w = tw
				end
				menus[currentMenu].labels[k] = label
				y = y + h + dashboardPadding[3] * 2
				if y > sy then
					y = lastLine
					x = x + w + dashboardPadding[3] * 2 + gs * 4
				end
			end
		end
	end
	y = dashboardPadding[3] * 4
	x = buttonsWidth + dashboardPadding[3] * 4 + w + dashboardPadding[3] * 2
	lastLine = 0
	for k = 1, #menus[currentMenu].settings do
		menus[currentMenu].elements[k] = false
		if menus[currentMenu].settings[k][2] == "crosshair" then
			h = 64
		else
			h = dh
		end
		if menus[currentMenu].settings[k][1] == "line" then
			local border = sightexports.sGui:createGuiElement("hr", buttonsWidth + dashboardPadding[3] * 4, y, sx - buttonsWidth - dashboardPadding[3] * 4, 2, inside)
			y = y + 2 + dashboardPadding[3] * 2
			lastLine = y
		elseif menus[currentMenu].settings[k][2] == "slider" then
			local slider = sightexports.sGui:createGuiElement("slider", x, y + h / 2 - (gs - 6) / 2, 300, gs - 6, inside)
			sightexports.sGui:setSliderChangeEvent(slider, "settingsSliderChange")
			local val = menus[currentMenu].settings[k][3]
			if menus[currentMenu].settings[k][5] then
				val = menus[currentMenu].settings[k][5]()
			end
			sightexports.sGui:setSliderValue(slider, (val - menus[currentMenu].settings[k][3]) / (menus[currentMenu].settings[k][4] - menus[currentMenu].settings[k][3]))
			local label = sightexports.sGui:createGuiElement("label", x + 300 + dashboardPadding[3] * 2, y, 0, h, inside)
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, math.floor(val + 0.5))
			menus[currentMenu].elements[k] = slider
			sliderDatas[slider] = {
				label,
				menus[currentMenu].settings[k][3],
				menus[currentMenu].settings[k][4],
				menus[currentMenu].settings[k][6],
				menus[currentMenu].settings[k][7]
			}
			y = y + h + dashboardPadding[3] * 2
		elseif menus[currentMenu].settings[k][2] == "enum" or menus[currentMenu].settings[k][2] == "enumNameFont" then
			local val = menus[currentMenu].settings[k][4]()
			enumButtons[k] = {}
			for i = 1, #menus[currentMenu].settings[k][3] do
				local btn = sightexports.sGui:createGuiElement("button", x + (i - 1) * (100 + dashboardPadding[3]), y + h / 2 - gs / 2, 100, gs, inside)
				if val == menus[currentMenu].settings[k][3][i] then
					sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
					sightexports.sGui:setGuiHover(btn, "gradient", {
						"sightgreen",
						"sightgreen-second"
					}, true)
				else
					sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
					sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, true)
				end
				if menus[currentMenu].settings[k][2] == "enumNameFont" then
					if i == 1 then
						sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
					else
						sightexports.sGui:setButtonFont(btn, "10/Ubuntu-B.ttf")
					end
				else
					sightexports.sGui:setButtonFont(btn, "11/BebasNeueRegular.otf")
				end
				sightexports.sGui:setButtonTextColor(btn, "#ffffff")
				sightexports.sGui:setClickEvent(btn, "settingsEnumClick")
				sightexports.sGui:setButtonText(btn, menus[currentMenu].settings[k][3][i])
				enumDatas[btn] = {
					menus[currentMenu].settings[k][5],
					menus[currentMenu].settings[k][3][i],
					k,
					menus[currentMenu].settings[k][6]
				}
				enumButtons[k][i] = {
					btn,
					menus[currentMenu].settings[k][3][i]
				}
			end
			y = y + h + dashboardPadding[3] * 2
		elseif menus[currentMenu].settings[k][2] == "walkingStyle" then
			menus[currentMenu].elements[k] = {}
			local btn = sightexports.sGui:createGuiElement("image", x, y - (32 - h) / 2, 32, 32, inside)
			sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("caret-left", 32))
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(btn, "dashChangeWalkStyle")
			sightexports.sGui:setClickArgument(btn, -1)
			table.insert(menus[currentMenu].elements[k], btn)
			walkingStyleLabel = sightexports.sGui:createGuiElement("label", x + 32, y, 96, h, inside)
			sightexports.sGui:setLabelFont(walkingStyleLabel, "11/BebasNeueRegular.otf")
			sightexports.sGui:setLabelAlignment(walkingStyleLabel, "center", "center")
			sightexports.sGui:setLabelText(walkingStyleLabel, walkingStyles[currentWalkingStyle][2])
			local btn = sightexports.sGui:createGuiElement("image", x + 128, y - (32 - h) / 2, 32, 32, inside)
			sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("caret-right", 32))
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(btn, "dashChangeWalkStyle")
			sightexports.sGui:setClickArgument(btn, 1)
			table.insert(menus[currentMenu].elements[k], btn)
			moviePresetLocation = k
			y = y + h + dashboardPadding[3] * 2
		elseif menus[currentMenu].settings[k][2] == "fightingStyle" then
			menus[currentMenu].elements[k] = {}
			local btn = sightexports.sGui:createGuiElement("image", x, y - (32 - h) / 2, 32, 32, inside)
			sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("caret-left", 32))
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(btn, "dashChangeFightStyle")
			sightexports.sGui:setClickArgument(btn, -1)
			table.insert(menus[currentMenu].elements[k], btn)
			fightingStyleLabel = sightexports.sGui:createGuiElement("label", x + 32, y, 96, h, inside)
			sightexports.sGui:setLabelFont(fightingStyleLabel, "11/BebasNeueRegular.otf")
			sightexports.sGui:setLabelAlignment(fightingStyleLabel, "center", "center")
			sightexports.sGui:setLabelText(fightingStyleLabel, "Stílus #" .. currentFightStyle)
			local btn = sightexports.sGui:createGuiElement("image", x + 128, y - (32 - h) / 2, 32, 32, inside)
			sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("caret-right", 32))
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(btn, "dashChangeFightStyle")
			sightexports.sGui:setClickArgument(btn, 1)
			table.insert(menus[currentMenu].elements[k], btn)
			moviePresetLocation = k
			y = y + h + dashboardPadding[3] * 2
		elseif menus[currentMenu].settings[k][2] == "chatAnim" then
			menus[currentMenu].elements[k] = {}
			local btn = sightexports.sGui:createGuiElement("image", x, y - (32 - h) / 2, 32, 32, inside)
			sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("caret-left", 32))
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(btn, "dashChangeChatAnim")
			sightexports.sGui:setClickArgument(btn, -1)
			table.insert(menus[currentMenu].elements[k], btn)
			chatAnimLabel = sightexports.sGui:createGuiElement("label", x + 32, y, 96, h, inside)
			sightexports.sGui:setLabelFont(chatAnimLabel, "11/BebasNeueRegular.otf")
			sightexports.sGui:setLabelAlignment(chatAnimLabel, "center", "center")
			if currentChatAnim == #chatAnims then
				sightexports.sGui:setLabelText(chatAnimLabel, "Kikapcsolva")
			elseif currentChatAnim == #chatAnims - 1 then
				sightexports.sGui:setLabelText(chatAnimLabel, "Véletlenszerű")
			else
				sightexports.sGui:setLabelText(chatAnimLabel, "Animáció #" .. currentChatAnim)
			end
			local btn = sightexports.sGui:createGuiElement("image", x + 128, y - (32 - h) / 2, 32, 32, inside)
			sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("caret-right", 32))
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(btn, "dashChangeChatAnim")
			sightexports.sGui:setClickArgument(btn, 1)
			table.insert(menus[currentMenu].elements[k], btn)
			moviePresetLocation = k
			y = y + h + dashboardPadding[3] * 2
		elseif menus[currentMenu].settings[k][2] == "crosshairColor" then
			local btn = sightexports.sGui:createGuiElement("image", x, y - (32 - h) / 2, 32, 32, inside)
			sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("caret-left", 32))
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(btn, "dashPreviusCrosshairColor")
			local crosshair = sightexports.sCrosshair:getCrosshair()
			local id = crosshair[1]
			local color = crosshair[2]
			crosshairColorRect = sightexports.sGui:createGuiElement("rectangle", x + 72 - 7, y + h / 2 - 7, 14, 14, inside)
			sightexports.sGui:setGuiBackground(crosshairColorRect, "solid", color)
			local btn = sightexports.sGui:createGuiElement("image", x + 96 + 16, y - (32 - h) / 2, 32, 32, inside)
			sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("caret-right", 32))
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(btn, "dashNextCrosshairColor")
			y = y + h + dashboardPadding[3] * 2
		elseif menus[currentMenu].settings[k][2] == "crosshair" then
			local crosshair = sightexports.sCrosshair:getCrosshair()
			local id = crosshair[1]
			local color = crosshair[2]
			local btn = sightexports.sGui:createGuiElement("image", x, y - (32 - h) / 2, 32, 32, inside)
			sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("caret-left", 32))
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(btn, "dashPreviusCrosshair")
			local btn = sightexports.sGui:createGuiElement("image", x + 96 + 16, y - (32 - h) / 2, 32, 32, inside)
			sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("caret-right", 32))
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(btn, "dashNextCrosshair")
			local px, py = math.floor(x + 32 + 8), math.floor(y + h / 2 - 32)
			crosshairImages = {}
			local image = sightexports.sGui:createGuiElement("image", px, py, 32, 32, inside)
			sightexports.sGui:setImageDDS(image, ":sCrosshair/files/" .. id .. ".dds")
			sightexports.sGui:setImageColor(image, color)
			table.insert(crosshairImages, image)
			local image = sightexports.sGui:createGuiElement("image", px, py + 32, 32, 32, inside)
			sightexports.sGui:setImageDDS(image, ":sCrosshair/files/" .. id .. ".dds")
			sightexports.sGui:setImageColor(image, color)
			sightexports.sGui:setImageRotation(image, 270)
			table.insert(crosshairImages, image)
			local image = sightexports.sGui:createGuiElement("image", px + 32, py, 32, 32, inside)
			sightexports.sGui:setImageDDS(image, ":sCrosshair/files/" .. id .. ".dds")
			sightexports.sGui:setImageColor(image, color)
			sightexports.sGui:setImageRotation(image, 90)
			table.insert(crosshairImages, image)
			local image = sightexports.sGui:createGuiElement("image", px + 32, py + 32, 32, 32, inside)
			sightexports.sGui:setImageDDS(image, ":sCrosshair/files/" .. id .. ".dds")
			sightexports.sGui:setImageColor(image, color)
			sightexports.sGui:setImageRotation(image, 180)
			table.insert(crosshairImages, image)
			y = y + h + dashboardPadding[3] * 2
		elseif menus[currentMenu].settings[k][1] == "movieShaderStart" then
			movieShaderStartY = y
		elseif menus[currentMenu].settings[k][1] == "movieShaderEnd" then
			local w = sx - (x + 300 + 32 + gs)
			local h = y - movieShaderStartY - dashboardPadding[3] * 2
			local iw = w - 64
			local ih = screenY * w / screenX - 64
			local px = x + 300 + 32 + gs + w / 2 - iw / 2
			local py = movieShaderStartY + h / 2 - ih / 2
			local rect = sightexports.sGui:createGuiElement("rectangle", px - 8, py - 8, iw + 16, ih + 16, inside)
			sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
			movieShaderPreview = sightexports.sGui:createGuiElement("image", px, py, iw, ih, inside)
			if isElement(sightexports.sShader:getShaderTarget()) then
				sightexports.sGui:setImageFile(movieShaderPreview, sightexports.sShader:getShaderTarget())
			else
				sightexports.sGui:setImageDDS(movieShaderPreview, ":sDashboard/files/wallp.dds")
			end
		elseif menus[currentMenu].settings[k][2] == "movieShaderPreset" then
			menus[currentMenu].elements[k] = {}
			local btn = sightexports.sGui:createGuiElement("image", x, y - (32 - h) / 2, 32, 32, inside)
			sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("caret-left", 32))
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(btn, "dashPreviusMoviePreset")
			table.insert(menus[currentMenu].elements[k], btn)
			movieShaderPresetLabel = sightexports.sGui:createGuiElement("label", x + 32, y, 96, h, inside)
			sightexports.sGui:setLabelFont(movieShaderPresetLabel, "11/BebasNeueRegular.otf")
			sightexports.sGui:setLabelAlignment(movieShaderPresetLabel, "center", "center")
			sightexports.sGui:setLabelText(movieShaderPresetLabel, movieShaderNames[sightexports.sShader:getCurrentMoviePreset()])
			local btn = sightexports.sGui:createGuiElement("image", x + 128, y - (32 - h) / 2, 32, 32, inside)
			sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("caret-right", 32))
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(btn, "dashNextMoviePreset")
			table.insert(menus[currentMenu].elements[k], btn)
			moviePresetLocation = k
			y = y + h + dashboardPadding[3] * 2
		elseif menus[currentMenu].settings[k][2] == "keyBind" then
			local button = "Nincs"
			local bind = menus[currentMenu].settings[k][3]()
			if bind then
				button = utf8.upper(bind)
			end
			local w = sightexports.sGui:getTextWidthFont(button, fontSize + 2 .. "/BebasNeueBold.otf") + 8
			local btn = sightexports.sGui:createGuiElement("button", x, y, math.max(w, h), h, inside)
			sightexports.sGui:setButtonFont(btn, fontSize + 2 .. "/BebasNeueBold.otf")
			sightexports.sGui:setButtonTextColor(btn, "sightgrey1")
			sightexports.sGui:setButtonText(btn, button)
			sightexports.sGui:setGuiBackground(btn, "solid", "#ffffff")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightlightgrey",
				"#ffffff"
			}, true)
			sightexports.sGui:setClickEvent(btn, "startBindingProcess")
			bindButtonCache[btn] = {}
			bindButtonCache[btn].getter = menus[currentMenu].settings[k][3]
			bindButtonCache[btn].setter = menus[currentMenu].settings[k][4]
			bindButtonCache[btn].saveValue = menus[currentMenu].settings[k][5]
			bindButtonCache[btn].defaultValue = menus[currentMenu].settings[k][6]
			if bind and utf8.lower(menus[currentMenu].settings[k][6]) ~= utf8.lower(bind) then
				local btn2 = sightexports.sGui:createGuiElement("image", x + math.max(w, h) + dashboardPadding[3] * 2, y, 24, 24, inside)
				sightexports.sGui:setImageFile(btn2, sightexports.sGui:getFaIconFilename("undo", 24))
				sightexports.sGui:setGuiHoverable(btn2, true)
				sightexports.sGui:setGuiHover(btn2, "solid", "sightred")
				sightexports.sGui:guiSetTooltip(btn2, "Alapértelmezett beállítás")
				sightexports.sGui:setClickEvent(btn2, "resetBind")
				bindButtonCache[btn2] = {}
				bindButtonCache[btn2].bindElement = btn
				bindButtonCache[btn2].setter = menus[currentMenu].settings[k][4]
				bindButtonCache[btn2].saveValue = menus[currentMenu].settings[k][5]
				bindButtonCache[btn2].value = menus[currentMenu].settings[k][6]
				bindButtonCache[btn].resetElement = btn2
			end
			y = y + h + dashboardPadding[3] * 2
		elseif menus[currentMenu].settings[k][2] == "inviteCode" then
			local button = menus[currentMenu].settings[k][3]
			local w = sightexports.sGui:getTextWidthFont("AAAAAA", fontSize + 2 .. "/BebasNeueBold.otf") + 8
			invCodeBtn = sightexports.sGui:createGuiElement("button", x, y, math.max(w, h), h, inside)
			sightexports.sGui:setButtonFont(invCodeBtn, fontSize + 2 .. "/BebasNeueBold.otf")
			sightexports.sGui:setButtonTextColor(invCodeBtn, "sightgrey1")
			sightexports.sGui:setButtonText(invCodeBtn, "......")
			sightexports.sGui:guiSetTooltip(invCodeBtn, "Meghívókód másolása")
			sightexports.sGui:setGuiBackground(invCodeBtn, "solid", "#ffffff")
			sightexports.sGui:setGuiHover(invCodeBtn, "gradient", {
				"sightlightgrey",
				"#ffffff"
			}, true)
			sightexports.sGui:setClickEvent(invCodeBtn, "editInviteCode")
			y = y + h + dashboardPadding[3] * 2
		elseif menus[currentMenu].settings[k][2] == "colorsetTest" then
			colorSetTestBtn = {}
			colorSetTestRect = {}
			colorSetTestImg = {}
			colorSetTestLabel = {}
			local pw = 300
			local titleBarHeight = sightexports.sGui:getTitleBarHeight()
			local ph = titleBarHeight + 80
			local rect = sightexports.sGui:createGuiElement("rectangle", x, y, pw + dashboardPadding[3] * 2, ph + dashboardPadding[3] * 2, inside)
			sightexports.sGui:setGuiBackground(rect, "solid", "#fff")
			colorSetTestWindow = sightexports.sGui:createGuiElement("window", x + dashboardPadding[3], y + dashboardPadding[3], pw, ph, inside)
			sightexports.sGui:setWindowTitle(colorSetTestWindow, "16/BebasNeueRegular.otf", "Teszt")
			sightexports.sGui:setGuiHoverable(colorSetTestWindow, false)
			local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - 8 - 32 - 8 - titleBarHeight, colorSetTestWindow)
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			sightexports.sGui:setLabelText(label, "Ez egy teszt ablak.")
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			local w = (pw - 24) / 2
			local btn = sightexports.sGui:createGuiElement("button", 8, ph - 8 - 32, w, 32, colorSetTestWindow)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonText(btn, "Igen")
			colorSetTestBtn[btn] = "sightgreen"
			local btn = sightexports.sGui:createGuiElement("button", pw - w - 8, ph - 8 - 32, w, 32, colorSetTestWindow)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonText(btn, "Nem")
			colorSetTestBtn[btn] = "sightred"
			y = y + ph + dashboardPadding[3] * 4
			local tw = sightexports.sGui:getTextWidthFont("0000100000 SSC", "22/BebasNeueBold.otf")
			local rect = sightexports.sGui:createGuiElement("rectangle", x, y, tw + dashboardPadding[3] * 2, 128 + dashboardPadding[3] * 2, inside)
			colorSetTestRect[rect] = "sightgrey1"
			y = y + dashboardPadding[3]
			local label = sightexports.sGui:createGuiElement("label", x + dashboardPadding[3], y, 0, 32, inside)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, "- 100000 $")
			sightexports.sGui:setLabelFont(label, "22/BebasNeueBold.otf")
			colorSetTestLabel[label] = "sightred"
			y = y + 32
			local label = sightexports.sGui:createGuiElement("label", x + dashboardPadding[3], y, 0, 32, inside)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, "0000")
			sightexports.sGui:setLabelFont(label, "22/BebasNeueBold.otf")
			colorSetTestLabel[label] = "hudwhite"
			local label = sightexports.sGui:createGuiElement("label", x + dashboardPadding[3] + sightexports.sGui:getLabelTextWidth(label), y, 0, 32, inside)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, "100000 $")
			sightexports.sGui:setLabelFont(label, "22/BebasNeueBold.otf")
			colorSetTestLabel[label] = "sightgreen"
			y = y + 32
			local label = sightexports.sGui:createGuiElement("label", x + dashboardPadding[3], y, 0, 32, inside)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, "0000")
			sightexports.sGui:setLabelFont(label, "22/BebasNeueBold.otf")
			colorSetTestLabel[label] = "hudwhite"
			local label = sightexports.sGui:createGuiElement("label", x + dashboardPadding[3] + sightexports.sGui:getLabelTextWidth(label), y, 0, 32, inside)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, "100000 PP")
			sightexports.sGui:setLabelFont(label, "22/BebasNeueBold.otf")
			colorSetTestLabel[label] = "sightblue"
			y = y + 32
			local label = sightexports.sGui:createGuiElement("label", x + dashboardPadding[3], y, 0, 32, inside)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, "0000")
			sightexports.sGui:setLabelFont(label, "22/BebasNeueBold.otf")
			colorSetTestLabel[label] = "hudwhite"
			local label = sightexports.sGui:createGuiElement("label", x + dashboardPadding[3] + sightexports.sGui:getLabelTextWidth(label), y, 0, 32, inside)
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, "100000 SSC")
			sightexports.sGui:setLabelFont(label, "22/BebasNeueBold.otf")
			colorSetTestLabel[label] = "sightyellow"
			y = y + 32
			y = y + dashboardPadding[3] * 3
			local rect = sightexports.sGui:createGuiElement("rectangle", x, y, 198 + dashboardPadding[3] * 2, 66 + dashboardPadding[3] * 2, inside)
			colorSetTestRect[rect] = "sightgrey1"
			local item = sightexports.sGui:createGuiElement("image", x + dashboardPadding[3], y + dashboardPadding[3], 66, 66, inside)
			sightexports.sGui:setImageDDS(item, ":sHud/files/itemHover.dds")
			colorSetTestImg[item] = "sightgreen"
			local item = sightexports.sGui:createGuiElement("image", 15, 15, 36, 36, item)
			sightexports.sGui:setImageFile(item, ":sItems/" .. sightexports.sItems:getItemPic(174))
			local item = sightexports.sGui:createGuiElement("image", x + dashboardPadding[3] + 66, y + dashboardPadding[3], 66, 66, inside)
			sightexports.sGui:setImageDDS(item, ":sHud/files/itemHover.dds")
			colorSetTestImg[item] = "sightblue"
			local item = sightexports.sGui:createGuiElement("image", 15, 15, 36, 36, item)
			sightexports.sGui:setImageFile(item, ":sItems/" .. sightexports.sItems:getItemPic(174))
			local item = sightexports.sGui:createGuiElement("image", x + dashboardPadding[3] + 132, y + dashboardPadding[3], 66, 66, inside)
			sightexports.sGui:setImageDDS(item, ":sHud/files/itemHover.dds")
			colorSetTestImg[item] = "sightpurple"
			local item = sightexports.sGui:createGuiElement("image", 15, 15, 36, 36, item)
			sightexports.sGui:setImageFile(item, ":sItems/" .. sightexports.sItems:getItemPic(174))
			y = y + 66 + dashboardPadding[3] * 3
			local rect = sightexports.sGui:createGuiElement("rectangle", x, y, 256 + dashboardPadding[3] * 2, 30 + dashboardPadding[3] * 2, inside)
			colorSetTestRect[rect] = "sightgrey1"
			local btn = sightexports.sGui:createGuiElement("button", x + dashboardPadding[3], y + dashboardPadding[3], 256, 30, inside)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueRegular.otf")
			sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("mug", 30))
			sightexports.sGui:setButtonTextColor(btn, "#000")
			sightexports.sGui:setButtonText(btn, " Sárga bögre, görbe bögre")
			colorSetTestBtn[btn] = "sightyellow"
			y = y + 30 + dashboardPadding[3] * 3
			local rect = sightexports.sGui:createGuiElement("rectangle", x, y, 256 + dashboardPadding[3] * 2, 30 + dashboardPadding[3] * 2, inside)
			colorSetTestRect[rect] = "sightgrey1"
			local btn = sightexports.sGui:createGuiElement("button", x + dashboardPadding[3], y + dashboardPadding[3], 256, 30, inside)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("lemon", 30))
			sightexports.sGui:setButtonText(btn, " Narancssárga")
			colorSetTestBtn[btn] = "sightorange"
			y = y + 30 + dashboardPadding[3] * 3
			local rect = sightexports.sGui:createGuiElement("rectangle", x, y, 256 + dashboardPadding[3] * 2, 30 + dashboardPadding[3] * 2, inside)
			colorSetTestRect[rect] = "sightgrey1"
			local btn = sightexports.sGui:createGuiElement("button", x + dashboardPadding[3], y + dashboardPadding[3], 256, 30, inside)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("seedling", 30))
			sightexports.sGui:setButtonText(btn, " Lila")
			colorSetTestBtn[btn] = "sightpurple"
			y = y + 30 + dashboardPadding[3] * 3
			doColorsetTesters()
		elseif menus[currentMenu].settings[k][2] == "colorset" then
			local colorSet = sightexports.sGui:getColorSet()
			local colors = sightexports.sGui:getColorsForPreview(colorSet)
			colorSetTmp = colorSet
			colorSetRectangles = {}
			for k = 1, #colors do
				colorSetRectangles[k] = sightexports.sGui:createGuiElement("rectangle", x + (gs - 6) * (k - 1) + h, y + h / 2 - (gs - 6) / 2, gs - 6, gs - 6, inside)
				sightexports.sGui:setGuiBackground(colorSetRectangles[k], "solid", colors[k])
			end
			local btn = sightexports.sGui:createGuiElement("image", x - (32 - h) / 2, y - (32 - h) / 2, 32, 32, inside)
			sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("caret-left", 32))
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(btn, "dashPreviusColorSet")
			local btn = sightexports.sGui:createGuiElement("image", x + (gs - 6) * #colors + h - (32 - h) / 2, y - (32 - h) / 2, 32, 32, inside)
			sightexports.sGui:setImageFile(btn, sightexports.sGui:getFaIconFilename("caret-right", 32))
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(btn, "dashNextColorSet")
			colorSetLabel = sightexports.sGui:createGuiElement("label", x + (gs - 6) * #colors + h * 2, y, 0, h, inside)
			sightexports.sGui:setLabelFont(colorSetLabel, "11/BebasNeueRegular.otf")
			sightexports.sGui:setLabelAlignment(colorSetLabel, "left", "center")
			sightexports.sGui:setLabelText(colorSetLabel, sightexports.sGui:getColorSetName(colorSet))
			local btn = sightexports.sGui:createGuiElement("button", 0, 0, 80, h, colorSetLabel)
			sightexports.sGui:setButtonFont(btn, "11/BebasNeueBold.otf")
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("save", h))
			sightexports.sGui:setButtonText(btn, " Mentés")
			sightexports.sGui:setClickEvent(btn, "dashSaveColorSet")
			colorSetSave = btn
			sightexports.sGui:setGuiRenderDisabled(colorSetSave, true)
			y = y + h + dashboardPadding[3] * 2
		elseif menus[currentMenu].settings[k][2] == "toggle" then
			local toggle = sightexports.sGui:createGuiElement("toggle", x, y + h / 2 - (gs - 6) / 2, (gs - 6) * 2, gs - 6, inside)
			local val = menus[currentMenu].settings[k][3]()
			sightexports.sGui:setToggleState(toggle, val, true)
			sightexports.sGui:setClickEvent(toggle, "settingsToggleClick")
			sightexports.sGui:setToggleColor(toggle, "sightgrey1", "sightred", "sightgreen")
			toggleDatas[toggle] = {
				menus[currentMenu].settings[k][4],
				k,
				menus[currentMenu].settings[k][5],
				menus[currentMenu].settings[k][6]
			}
			menus[currentMenu].elements[k] = toggle
			y = y + h + dashboardPadding[3] * 2
		elseif menus[currentMenu].settings[k][2] == "invitedMembers" then
			local xLine = buttonsWidth + dashboardPadding[3] * 4
			local listWidth = sx - buttonsWidth - dashboardPadding[3] * 4
			local listHeight = 196
			local yAdjusted = y + sightexports.sGui:getLabelFontHeight(menus[currentMenu].labels[k]) + 10

			invitedListBackground = sightexports.sGui:createGuiElement("rectangle", xLine, yAdjusted, listWidth, listHeight, inside)
			sightexports.sGui:setGuiBackground(invitedListBackground, "solid", "sightgrey1")
			invitedListWidth = listWidth
			invitedVisibleRows = math.floor(listHeight / invitedRowHeight)

			triggerServerEvent("requestPlayerInvitations", localPlayer)
			triggerServerEvent("requestPlayerAwardDetails", localPlayer)
			triggerServerEvent("requestPlayerInvitationCode", localPlayer)

			yAdjusted = yAdjusted + listHeight + 5
			local listHeight = 60
			selectedMemberY = yAdjusted
			menus[currentMenu].elements[k] = invitedListBackground
			yAdjusted = yAdjusted + listHeight + 5
			y = yAdjusted + dashboardPadding[3] * 2
		elseif menus[currentMenu].settings[k][2] == "awardDetails" then
			local xLine = buttonsWidth + dashboardPadding[3] * 4
			awardListWidth = sx - buttonsWidth - dashboardPadding[3] * 4
			local listHeight = 60

			local label = sightexports.sGui:createGuiElement("label", buttonsWidth + dashboardPadding[3] * 4, y, 0, h, inside)
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setLabelText(label, menus[currentMenu].settings[k][1] .. ":")
			menus[currentMenu].labels[k] = label

			local yAdjusted = y + sightexports.sGui:getLabelFontHeight(label) + 10

			awardBackground = sightexports.sGui:createGuiElement("rectangle", xLine, yAdjusted, awardListWidth, listHeight, inside)
			sightexports.sGui:setGuiBackground(awardBackground, "solid", "sightgrey1")

			local awardCount = 10
			local buttonWidth = 90
			local totalButtonsWidth = awardCount * buttonWidth
			local gap = (awardListWidth - totalButtonsWidth) / (awardCount + 1)

			awardButtons = {}
			doneImages = {}

			for i = 1, #awardDetails do
				local xPos = gap * i + buttonWidth * (i - 1)
				local yPos = 5
				local awardButton = sightexports.sGui:createGuiElement("button", xPos, yPos, buttonWidth, 15, awardBackground)
				sightexports.sGui:setGuiBackground(awardButton, "solid", awardDetails[i].done and (awardDetails[i].reward[2] == "premium" and "sightpurple" or "sightgreen") or "sightgrey2")
				sightexports.sGui:setGuiHover(awardButton, "gradient", awardDetails[i].done and (awardDetails[i].reward[2] == "premium" and {"sightpurple", "sightpurple-second"} or {"sightgreen", "sightgreen-second"}) or {"sightgrey2", "sightgrey3"}, false, true)
				sightexports.sGui:guiSetTooltip(awardButton, awardDetails[i].awardLabel)
				
				sightexports.sGui:setButtonFont(awardButton, "10/BebasNeueBold.otf")
				sightexports.sGui:setButtonText(awardButton, exports.sGui:thousandsStepper(tostring(awardDetails[i].reward[1])) .." ".. (awardDetails[i].reward[2] == "premium" and "PP" or "$"))

				local doneImage = sightexports.sGui:createGuiElement("image", buttonWidth - 20, 0, 15, 15, awardButton)

				if awardDetails[i].taken then
					sightexports.sGui:setImageFile(doneImage, sightexports.sGui:getFaIconFilename("check", 15))
			      	sightexports.sGui:setImageColor(doneImage, "sightyellow")
				else
					sightexports.sGui:setImageFile(doneImage, sightexports.sGui:getFaIconFilename("check", 15))
      				sightexports.sGui:setImageColor(doneImage, "sightmidgrey")
				end

				sightexports.sGui:setClickEvent(awardButton, "getAwardPrize")
				sightexports.sGui:setClickArgument(awardButton, i)

				local isVisible = i > awardScrollIndex and i <= awardScrollIndex + maxAwardsVisible
				sightexports.sGui:setGuiRenderDisabled(awardButton, not isVisible, true)
				sightexports.sGui:setGuiRenderDisabled(doneImage, not isVisible)
				table.insert(awardButtons, awardButton)
				table.insert(doneImages, doneImage)
			end

			local scrollTrackHeight = 5
			local scrollThumbMinWidth = 20
			local scrollThumbHeight = scrollTrackHeight
			
			local scrollTrackY = 50

			awardScrollTrack = sightexports.sGui:createGuiElement("rectangle", gap, scrollTrackY, awardListWidth - (2 * gap), scrollTrackHeight, awardBackground)
			sightexports.sGui:setGuiBackground(awardScrollTrack, "solid", "sightgrey3")
			
			local thumbWidth = math.max((maxAwardsVisible / #awardDetails) * (awardListWidth - 2 * gap), scrollThumbMinWidth)
			local thumbX = gap + ((awardScrollIndex / (#awardDetails - maxAwardsVisible)) * ((awardListWidth - 2 * gap) - thumbWidth))
			awardScrollThumb = sightexports.sGui:createGuiElement("rectangle", thumbX, scrollTrackY, thumbWidth, scrollTrackHeight, awardBackground)
			sightexports.sGui:setGuiBackground(awardScrollThumb, "solid", "sightmidgrey")
			awardScrollThumbY = scrollTrackY

			local backButton = sightexports.sGui:createGuiElement("button", gap * 1, 25, 40, 20, awardBackground)
			sightexports.sGui:setGuiHover(backButton, "gradient", {"sightgreen", "sightgreen-second"}, false, true)
			sightexports.sGui:setButtonIcon(backButton, sightexports.sGui:getFaIconFilename("caret-left", 16))
			sightexports.sGui:setClickSound(backButton, "selectdone")
			sightexports.sGui:setClickEvent(backButton, "onBackButtonClick")

			local forwardButton = sightexports.sGui:createGuiElement("button", totalButtonsWidth, 25, 40, 20, awardBackground)
			sightexports.sGui:setGuiHover(forwardButton, "gradient", {"sightgreen", "sightgreen-second"}, false, true)
			sightexports.sGui:setButtonIcon(forwardButton, sightexports.sGui:getFaIconFilename("caret-right", 16))
			sightexports.sGui:setClickSound(forwardButton, "selectdone")
			sightexports.sGui:setClickEvent(forwardButton, "onForwardButtonClick")
		else
			y = y + h + dashboardPadding[3] * 2
		end
		if y > sy then
			y = lastLine
			x = x + w + dashboardPadding[3] * 2 + gs * 4
		end
	end
	local movie = false
	for i = 1, #menus[currentMenu].settings do
		if menus[currentMenu].settings[i][2] == "toggle" and (menus[currentMenu].settings[i][6] ~= "hudMovementState" or true) then
			local el = menus[currentMenu].elements[i]
			local val = sightexports.sGui:getToggleState(el)
			if toggleDatas[el][3] then
				for k = toggleDatas[el][2] + 1, #menus[currentMenu].settings do
					if menus[currentMenu].settings[k][2] == "movieShaderPreset" then
						if val then
							--movie = k
						end
						if val then
							exports.sGui:setGuiHoverable(menus[1].elements[6][1], true)
							exports.sGui:setGuiHoverable(menus[1].elements[6][2], true)
						else
							exports.sGui:setGuiHoverable(menus[1].elements[6][1], false)
							exports.sGui:setGuiHoverable(menus[1].elements[6][2], false)
						end
						sightexports.sGui:setImageColor(menus[currentMenu].elements[k][1], val and "#ffffff" or "sightmidgrey")
						sightexports.sGui:setImageColor(menus[currentMenu].elements[k][2], val and "#ffffff" or "sightmidgrey")
						sightexports.sGui:setGuiHoverable(menus[currentMenu].elements[k][1], val)
						sightexports.sGui:setLabelColor(movieShaderPresetLabel, val and "#ffffff" or "sightmidgrey")
						sightexports.sGui:setLabelColor(menus[currentMenu].labels[k], val and "#ffffff" or "sightmidgrey")
					elseif menus[currentMenu].elements[k] then
						local el2 = menus[currentMenu].elements[k]
						sightexports.sGui:setElementDisabled(el2, not val)
						if sliderDatas[el2] then
							sightexports.sGui:setLabelColor(sliderDatas[el2][1], val and "#ffffff" or "sightmidgrey")
						end
						sightexports.sGui:setLabelColor(menus[currentMenu].labels[k], val and "#ffffff" or "sightmidgrey")
					else
						break
					end
				end
			end
		end
	end
	if movie then
		local val = sightexports.sShader:getCurrentMoviePreset() == 1
		for k = movie + 1, #menus[currentMenu].settings do
			if menus[currentMenu].elements[k] then
				local el2 = menus[currentMenu].elements[k]
				sightexports.sGui:setElementDisabled(el2, not val)
				if sliderDatas[el2] then
					sightexports.sGui:setLabelColor(sliderDatas[el2][1], val and "#ffffff" or "sightmidgrey")
				end
				sightexports.sGui:setLabelColor(menus[currentMenu].labels[k], val and "#ffffff" or "sightmidgrey")
			else
				break
			end
		end
	end
end
addEventHandler("onClientKey", root, function(key, press)
	if currentMenu ~= 7 then return end
	
	for k = 1, #menus[currentMenu].settings do
		if menus[currentMenu].settings[k][2] == "invitedMembers" and sightexports.sGui:isGuiElementValid(menus[currentMenu].elements[k]) then
			local bg = menus[currentMenu].elements[k]
			invitedListBackground = bg -- frissítjük itt is biztosra
			local x, y = sightexports.sGui:getGuiRealPosition(bg)
			local w, h = sightexports.sGui:getGuiSize(bg)
			invitedListWidth = w
			invitedVisibleRows = math.floor(h / invitedRowHeight)
			
			local cx, cy = getCursorPosition()
			if cx and cy then
				cx = cx * screenX
				cy = cy * screenY
				
				if cx >= x and cy >= y and cx <= x + w and cy <= y + h then
					local maxScroll = math.max(0, #invitedMembers - invitedVisibleRows)
					if key == "mouse_wheel_down" and invitedMembersScroll < maxScroll then
						invitedMembersScroll = invitedMembersScroll + 1
						processInvitedMembersList()
					elseif key == "mouse_wheel_up" and invitedMembersScroll > 0 then
						invitedMembersScroll = invitedMembersScroll - 1
						processInvitedMembersList()
					end
				end
			end
		end
	end
end)
function setCurrentWalkingStyle(val)
	if not walkingStyles[val] then
		val = 1
	end
	currentWalkingStyle = val
	triggerServerEvent("refreshWalkingStyle", localPlayer, val)
end
function setCurrentFightingStyle(val)
	if not fightingStyles[val] then
		val = 1
	end
	currentFightStyle = val
	triggerServerEvent("refreshFightingStyle", localPlayer, val)
end
addEvent("dashChangeWalkStyle", true)
addEventHandler("dashChangeWalkStyle", getRootElement(), function(button, state, absoluteX, absoluteY, el, n)
	local val = currentWalkingStyle + n
	if val > #walkingStyles then
		val = 1
	elseif val < 1 then
		val = #walkingStyles
	end
	sightexports.sGui:setLabelText(walkingStyleLabel, walkingStyles[val][2])
	setCurrentWalkingStyle(val)
	saveValue("walkingStyle", val)
end)
addEvent("dashChangeFightStyle", true)
addEventHandler("dashChangeFightStyle", getRootElement(), function(button, state, absoluteX, absoluteY, el, n)
	local val = currentFightStyle + n
	if val > #fightingStyles then
		val = 1
	elseif val < 1 then
		val = #fightingStyles
	end
	sightexports.sGui:setLabelText(fightingStyleLabel, "Stílus #" .. val)
	setCurrentFightingStyle(val)
	saveValue("fightingStyle", val)
end)
addEvent("dashChangeChatAnim", true)
addEventHandler("dashChangeChatAnim", getRootElement(), function(button, state, absoluteX, absoluteY, el, n)
	local val = currentChatAnim + n
	if val > #chatAnims then
		val = 1
	elseif val < 1 then
		val = #chatAnims
	end
	currentChatAnim = val
	if val == #chatAnims then
		sightexports.sGui:setLabelText(chatAnimLabel, "Kikapcsolva")
	elseif val == #chatAnims - 1 then
		sightexports.sGui:setLabelText(chatAnimLabel, "Véletlenszerű")
	else
		sightexports.sGui:setLabelText(chatAnimLabel, "Animáció #" .. currentChatAnim)
	end
	saveValue("chatAnim", val)
end)
addEvent("dashNextMoviePreset", true)
addEventHandler("dashNextMoviePreset", getRootElement(), function()
	local preset = sightexports.sShader:getCurrentMoviePreset() + 1
	if preset > #movieShaderNames then
		preset = 1
	end
	setCurrentMoviePreset(preset)
	sightexports.sGui:setLabelText(movieShaderPresetLabel, movieShaderNames[preset])
	saveValue("moviePreset_v4", preset)
	if moviePresetLocation then
		local val = preset == 1
		for k = moviePresetLocation + 1, #menus[currentMenu].settings do
			if menus[currentMenu].elements[k] then
				local el2 = menus[currentMenu].elements[k]
				sightexports.sGui:setElementDisabled(el2, not val)
				if sliderDatas[el2] then
					sightexports.sGui:setLabelColor(sliderDatas[el2][1], val and "#ffffff" or "sightmidgrey")
				end
				sightexports.sGui:setLabelColor(menus[currentMenu].labels[k], val and "#ffffff" or "sightmidgrey")
			else
				break
			end
		end
	end
end)
addEvent("dashPreviusMoviePreset", true)
addEventHandler("dashPreviusMoviePreset", getRootElement(), function()
	local preset = sightexports.sShader:getCurrentMoviePreset() - 1
	if preset < 1 then
		preset = #movieShaderNames
	end
	setCurrentMoviePreset(preset)
	sightexports.sGui:setLabelText(movieShaderPresetLabel, movieShaderNames[preset])
	saveValue("moviePreset_v4", preset)
	if moviePresetLocation then
		local val = preset == 1
		for k = moviePresetLocation + 1, #menus[currentMenu].settings do
			if menus[currentMenu].elements[k] then
				local el2 = menus[currentMenu].elements[k]
				sightexports.sGui:setElementDisabled(el2, not val)
				if sliderDatas[el2] then
					sightexports.sGui:setLabelColor(sliderDatas[el2][1], val and "#ffffff" or "sightmidgrey")
				end
				sightexports.sGui:setLabelColor(menus[currentMenu].labels[k], val and "#ffffff" or "sightmidgrey")
			else
				break
			end
		end
	end
end)
function doColorsetTesters()
	local colors = sightexports.sGui:getColorsForPreviewEx(colorSetTmp)
	sightexports.sGui:setWindowColors(colorSetTestWindow, colors.v4grey2, colors.v4grey1, colors.v4grey3, "#ffffff")
	for img, col in pairs(colorSetTestImg) do
		sightexports.sGui:setImageColor(img, colors[col])
	end
	for rect, col in pairs(colorSetTestRect) do
		sightexports.sGui:setGuiBackground(rect, "solid", colors[col])
	end
	for btn, col in pairs(colorSetTestBtn) do
		sightexports.sGui:setGuiBackground(btn, "solid", colors[col])
		sightexports.sGui:setGuiHover(btn, "gradient", {
			colors[col],
			colors[col .. "-second"]
		}, false, true)
	end
	for btn, col in pairs(colorSetTestLabel) do
		sightexports.sGui:setLabelColor(btn, colors[col])
	end
end
addEvent("dashNextColorSet", true)
addEventHandler("dashNextColorSet", getRootElement(), function()
	local colorSet = colorSetTmp + 1
	if colorSet > sightexports.sGui:getColorSetsCount() then
		colorSet = 1
	end
	colorSetTmp = colorSet
	local colors = sightexports.sGui:getColorsForPreview(colorSet)
	for k = 1, #colors do
		sightexports.sGui:setGuiBackground(colorSetRectangles[k], "solid", colors[k])
	end
	sightexports.sGui:setLabelText(colorSetLabel, sightexports.sGui:getColorSetName(colorSet))
	sightexports.sGui:setGuiRenderDisabled(colorSetSave, false)
	sightexports.sGui:setGuiPosition(colorSetSave, sightexports.sGui:getLabelTextWidth(colorSetLabel) + 8)
	doColorsetTesters()
end)
addEvent("dashPreviusColorSet", true)
addEventHandler("dashPreviusColorSet", getRootElement(), function()
	local colorSet = colorSetTmp - 1
	if colorSet < 1 then
		colorSet = sightexports.sGui:getColorSetsCount()
	end
	colorSetTmp = colorSet
	local colors = sightexports.sGui:getColorsForPreview(colorSet)
	for k = 1, #colors do
		sightexports.sGui:setGuiBackground(colorSetRectangles[k], "solid", colors[k])
	end
	sightexports.sGui:setLabelText(colorSetLabel, sightexports.sGui:getColorSetName(colorSet))
	sightexports.sGui:setGuiRenderDisabled(colorSetSave, false)
	sightexports.sGui:setGuiPosition(colorSetSave, sightexports.sGui:getLabelTextWidth(colorSetLabel) + 8)
	doColorsetTesters()
end)
addEvent("dashSaveColorSet", true)
addEventHandler("dashSaveColorSet", getRootElement(), function()
	sightexports.sGui:setGuiRenderDisabled(colorSetSave, true)
	setColorSet(colorSetTmp)
	saveValue("colorSet", colorSetTmp)
	sightexports.sGui:showInfobox("w", "A megfelelő játékélmény érdekében színséma váltás után indítsd újra a SightMTA klienst!")
	doColorsetTesters()
end)
addEvent("dashNextCrosshairColor", true)
addEventHandler("dashNextCrosshairColor", getRootElement(), function()
	local cData = sightexports.sCrosshair:getCrosshair()
	if cData[1] > 0 then
		local currentColor = 1
		for i = 1, #crosshairColors do
			if crosshairColors[i] == cData[2] then
				currentColor = i
				break
			end
		end
		currentColor = currentColor + 1
		if currentColor > #crosshairColors then
			currentColor = 1
		end
		for i = 1, #crosshairImages do
			sightexports.sGui:setImageColor(crosshairImages[i], crosshairColors[currentColor])
		end
		cData[2] = crosshairColors[currentColor]
		sightexports.sCrosshair:setCrosshair(cData)
		sightexports.sGui:setGuiBackground(crosshairColorRect, "solid", crosshairColors[currentColor])
		saveValue("crosshairColor", currentColor)
	end
end)
addEvent("dashPreviusCrosshairColor", true)
addEventHandler("dashPreviusCrosshairColor", getRootElement(), function()
	local cData = sightexports.sCrosshair:getCrosshair()
	if cData[1] > 0 then
		local currentColor = 1
		for i = 1, #crosshairColors do
			if crosshairColors[i] == cData[2] then
				currentColor = i
				break
			end
		end
		currentColor = currentColor - 1
		if currentColor < 1 then
			currentColor = #crosshairColors
		end
		for i = 1, #crosshairImages do
			sightexports.sGui:setImageColor(crosshairImages[i], crosshairColors[currentColor])
		end
		cData[2] = crosshairColors[currentColor]
		sightexports.sCrosshair:setCrosshair(cData)
		sightexports.sGui:setGuiBackground(crosshairColorRect, "solid", crosshairColors[currentColor])
		saveValue("crosshairColor", currentColor)
	end
end)
addEvent("dashNextCrosshair", true)
addEventHandler("dashNextCrosshair", getRootElement(), function()
	local cData = sightexports.sCrosshair:getCrosshair()
	local crosshair = cData[1] + 1
	if 12 < crosshair then
		crosshair = 1
	end
	cData[1] = crosshair
	sightexports.sCrosshair:setCrosshair(cData)
	for i = 1, #crosshairImages do
		sightexports.sGui:setImageDDS(crosshairImages[i], ":sCrosshair/files/" .. crosshair .. ".dds")
		sightexports.sGui:setImageColor(crosshairImages[i], cData[2])
	end
	sightexports.sGui:setGuiBackground(crosshairColorRect, "solid", cData[2])
	saveValue("crosshair", crosshair)
end)
addEvent("dashPreviusCrosshair", true)
addEventHandler("dashPreviusCrosshair", getRootElement(), function()
	local cData = sightexports.sCrosshair:getCrosshair()
	local crosshair = cData[1] - 1
	if crosshair < 1 then
		crosshair = 12
	end
	cData[1] = crosshair
	sightexports.sCrosshair:setCrosshair(cData)
	for i = 1, #crosshairImages do
		sightexports.sGui:setImageDDS(crosshairImages[i], ":sCrosshair/files/" .. crosshair .. ".dds")
		sightexports.sGui:setImageColor(crosshairImages[i], cData[2])
	end
	sightexports.sGui:setGuiBackground(crosshairColorRect, "solid", cData[2])
	saveValue("crosshair", crosshair)
end)
addEvent("settingsEnumClick", true)
addEventHandler("settingsEnumClick", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if enumDatas[el] and state == "down" then
		enumDatas[el][1](enumDatas[el][2])
		if enumDatas[el][4] then
			saveValue(enumDatas[el][4], enumDatas[el][2])
		end
		for i = 1, #enumButtons[enumDatas[el][3]] do
			local btn = enumButtons[enumDatas[el][3]][i][1]
			if enumDatas[el][2] == enumButtons[enumDatas[el][3]][i][2] then
				sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
				sightexports.sGui:setGuiHover(btn, "gradient", {
					"sightgreen",
					"sightgreen-second"
				}, true)
			else
				sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
				sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, true)
			end
		end
	end
end)
addEvent("settingsToggleClick", true)
addEventHandler("settingsToggleClick", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if toggleDatas[el] and state == "down" then
		local val = sightexports.sGui:getToggleState(el)
		if toggleDatas[el][1] then
			toggleDatas[el][1](val)
		end
		if toggleDatas[el][4] then
			saveValue(toggleDatas[el][4], val and 1 or 0)
		end
		if toggleDatas[el][3] then
			local movie = false
			for k = toggleDatas[el][2] + 1, #menus[currentMenu].settings do
				if menus[currentMenu].settings[k][2] == "movieShaderPreset" then
					if val then
						movie = k
					end
					if val then
						exports.sGui:setGuiHoverable(menus[1].elements[6][1], true)
						exports.sGui:setGuiHoverable(menus[1].elements[6][2], true)
					else
						exports.sGui:setGuiHoverable(menus[1].elements[6][1], false)
						exports.sGui:setGuiHoverable(menus[1].elements[6][2], false)
					end
					sightexports.sGui:setImageColor(menus[currentMenu].elements[k][1], val and "#ffffff" or "sightmidgrey")
					sightexports.sGui:setImageColor(menus[currentMenu].elements[k][2], val and "#ffffff" or "sightmidgrey")
					sightexports.sGui:setGuiHoverable(menus[currentMenu].elements[k][1], val)
					sightexports.sGui:setLabelColor(movieShaderPresetLabel, val and "#ffffff" or "sightmidgrey")
					sightexports.sGui:setLabelColor(menus[currentMenu].labels[k], val and "#ffffff" or "sightmidgrey")
				elseif menus[currentMenu].elements[k] then
					local el2 = menus[currentMenu].elements[k]
					sightexports.sGui:setElementDisabled(el2, not val)
					if sliderDatas[el2] then
						sightexports.sGui:setLabelColor(sliderDatas[el2][1], val and "#ffffff" or "sightmidgrey")
					end
					sightexports.sGui:setLabelColor(menus[currentMenu].labels[k], val and "#ffffff" or "sightmidgrey")
				else
					break
				end
			end
			if movie then
				local val = sightexports.sShader:getCurrentMoviePreset() == 1
				for k = movie + 1, #menus[currentMenu].settings do
					if menus[currentMenu].elements[k] then
						local el2 = menus[currentMenu].elements[k]
						sightexports.sGui:setElementDisabled(el2, not val)
						if sliderDatas[el2] then
							sightexports.sGui:setLabelColor(sliderDatas[el2][1], val and "#ffffff" or "sightmidgrey")
						end
						sightexports.sGui:setLabelColor(menus[currentMenu].labels[k], val and "#ffffff" or "sightmidgrey")
					else
						break
					end
				end
			end
		end
	end
end)
addEvent("settingsSliderChange", true)
addEventHandler("settingsSliderChange", getRootElement(), function(el, sliderValue, final)
	if sliderDatas[el] then
		local val = sliderDatas[el][2] + sliderValue * (sliderDatas[el][3] - sliderDatas[el][2])
		sightexports.sGui:setLabelText(sliderDatas[el][1], math.floor(val + 0.5))
		if sliderDatas[el][4] then
			sliderDatas[el][4](val)
		end
		if final and sliderDatas[el][5] then
			saveValue(sliderDatas[el][5], val)
		end
	end
end)
function resetFogAndFarClip()
	resetFarClipDistance()
	resetFogDistance()
	if savedFarClip then
		setFarClipDistance(savedFarClip)
	elseif fileExists("!dashboard/farClipDistance.setting") then
		local fh = fileOpen("!dashboard/farClipDistance.setting")
		if fh then
			local val = fileRead(fh, fileGetSize(fh))
			if val then
				val = tonumber(val) or val
				setFarClipDistanceEx(val)
			end
			fileClose(fh)
		end
	end
	if savedFog then
		if savedFarClip < savedFog then
			setFogDistance(savedFarClip)
		else
			setFogDistance(savedFog)
		end
	elseif fileExists("!dashboard/fogDistance.setting") then
		local fh = fileOpen("!dashboard/fogDistance.setting")
		if fh then
			local val = fileRead(fh, fileGetSize(fh))
			if val then
				val = tonumber(val) or val
				setFogDistanceEx(val)
			end
			fileClose(fh)
		end
	end
end
local streamerModePrompt = false
local streamerModeToggle = false
addEvent("streamerModePromptClose", false)
addEventHandler("streamerModePromptClose", getRootElement(), function()
	local val = sightexports.sGui:getToggleState(streamerModeToggle) or false
	setStreamerMode(val)
	saveValue("streamerMode", val and 1 or 0)
	showCursor(false)
	if streamerModePrompt then
		sightexports.sGui:deleteGuiElement(streamerModePrompt)
	end
	streamerModePrompt = nil
	streamerModeToggle = false
	sightlangCondHandl0(false)
end)
addEvent("streamerModeToggleChange", false)
addEventHandler("streamerModeToggleChange", getRootElement(), function()
	local val = sightexports.sGui:getToggleState(streamerModeToggle) or false
	setStreamerMode(val)
	saveValue("streamerMode", val and 1 or 0)
end)
local lateSettings = {
	farClipDistance = true,
	fogDistance = true,
	vignetteState = true,
	vignetteLevel = true,
	moviePreset_v4 = true,
	movieShaderState_v4 = true,
	movieShaderHue_v4 = true,
	movieShaderBrightness_v4 = true,
	movieShaderContrast_v4 = true,
	movieShaderSaturation_v4 = true,
	movieShaderR_v4 = true,
	movieShaderG_v4 = true,
	movieShaderB_v4 = true,
	movieShaderL_v4 = true,
	movieShadernoise_v4 = true,
	dofState = true,
	carPaint = true,
	osws = true,
	roadShine = true,
	radialBlur = true,
	waterEffects = true,
	colorSet = true,
	billboardState = true,
	hudMovementState = true
}
local lateSettingValues = {}
function loadLateSettings()
	for i = 1, #lateSettingValues do
		lateSettingValues[i][1](lateSettingValues[i][2])
	end
	lateSettingValues = {}
end
function loadColorset()
	for i = #lateSettingValues, 1, -1 do
		if lateSettingValues[i][3] == "colorSet" then
			local res = lateSettingValues[i][1](lateSettingValues[i][2])
			table.remove(lateSettingValues, i)
			return res
		end
	end
end
function loadSettings()
	requestPlayerVehicleList()
	if fileExists("!sVehprev.sight") then
		local fh = fileOpen("!sVehprev.sight")
		if fh then
			local val = fileRead(fh, fileGetSize(fh))
			if val then
				if vehiclePreviewTexture then
					backgroundSizes[vehiclePreviewTexture] = nil
				end
				if isElement(vehiclePreviewTexture) then
					destroyElement(vehiclePreviewTexture)
				end
				local s = dxGetPixelsSize(val)
				vehiclePreviewTexture = dxCreateTexture(val)
				if isElement(vehiclePreviewTexture) then
					local i, j = vehsPosition[1], vehsPosition[2]
					dashboardLayout[i][j].background = vehiclePreviewTexture
					backgroundSizes[vehiclePreviewTexture] = {s, s}
					if dashboardState and dashboardLayout[i][j].images and dashboardLayout[i][j].images[1] then
						sightexports.sGui:setImageFile(dashboardLayout[i][j].images[1], vehiclePreviewTexture)
					end
					local u = 0
					local v = 0
					local us = s / dashboardLayout[i][j].originalSize[1]
					local vs = s / dashboardLayout[i][j].originalSize[2]
					if us < vs then
						u = s
						v = dashboardLayout[i][j].originalSize[2] * us
					else
						u = dashboardLayout[i][j].originalSize[1] * vs
						v = s
					end
					if dashboardState and dashboardLayout[i][j].images and dashboardLayout[i][j].images[1] then
						sightexports.sGui:setImageUV(dashboardLayout[i][j].images[1], (s - u) / 2, (s - v) / 2, u, v)
						sightexports.sGui:setGuiHoverable(dashboardLayout[i][j].images[1], true, 1000)
					end
				end
			end
			fileClose(fh)
		end
	end
	local streamerModeFound = false
	for i = 1, #menus do
		for j = 1, #menus[i].settings do
			local data = menus[i].settings[j]
			if data then
				local name = false
				local func = false
				if data[2] == "colorset" then
					func = setColorSet
					name = "colorSet"
				elseif data[2] == "crosshair" then
					func = setCrosshair
					name = "crosshair"
				elseif data[2] == "keyBind" then
					func = data[4]
					name = data[5]
				elseif data[2] == "crosshairColor" then
					func = setCrosshairColor
					name = "crosshairColor"
				elseif data[2] == "movieShaderPreset" then
					func = setCurrentMoviePreset
					name = "moviePreset_v4"
				elseif data[2] == "walkingStyle" then
					func = setCurrentWalkingStyle
					name = "walkingStyle"
				elseif data[2] == "fightingStyle" then
					func = setCurrentFightingStyle
					name = "fightingStyle"
				elseif data[2] == "chatAnim" then
					func = setCurrentChatAnim
					name = "chatAnim"
				elseif data[2] == "toggle" then
					func = data[4]
					name = data[6]
				elseif data[2] == "enum" or data[2] == "enumNameFont" then
					func = data[5]
					name = data[6]
				elseif data[2] == "slider" then
					func = data[6]
					name = data[7]
				end
				if name and func and fileExists("!dashboard/" .. name .. ".setting") then
					local fh = fileOpen("!dashboard/" .. name .. ".setting")
					if fh then
						local val = fileRead(fh, fileGetSize(fh))
						if val then
							val = tonumber(val) or val
							if name == "streamerMode" then
								streamerModeFound = true
							end
							if data[2] == "keyBind" then
								val = tostring(val)
								if val == "false" then
									val = false
								end
								if lateSettings[name] then
									table.insert(lateSettingValues, {
										func,
										val,
										name
									})
								else
									func(val)
								end
							elseif data[2] == "toggle" then
								if lateSettings[name] then
									table.insert(lateSettingValues, {
										func,
										val == 1,
										name
									})
								else
									func(val == 1)
								end
							elseif lateSettings[name] then
								table.insert(lateSettingValues, {
									func,
									val,
									name
								})
							else
								func(val)
							end
						end
						fileClose(fh)
					end
				end
			end
		end
	end
	if not streamerModeFound then
		if streamerModePrompt then
			sightexports.sGui:deleteGuiElement(streamerModePrompt)
		end
		streamerModePrompt = nil
		sightlangCondHandl0(true)
		local pw = 550
		local fh1 = sightexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
		local fh2 = sightexports.sGui:getFontHeight("11/Ubuntu-L.ttf")
		local titleBarHeight = sightexports.sGui:getTitleBarHeight()
		local ph = titleBarHeight + fh2 * 2 + fh1 * 2 + 36
		showCursor(true)
		streamerModePrompt = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
		sightexports.sGui:setWindowTitle(streamerModePrompt, "16/BebasNeueRegular.otf", "Streamer mód")
		sightexports.sGui:setWindowCloseButton(streamerModePrompt, "streamerModePromptClose")
		local y = titleBarHeight + 6
		local label = sightexports.sGui:createGuiElement("label", 0, y, pw, fh1, streamerModePrompt)
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Szeretnéd bekapcsolni a streamer módot?")
		y = y + fh1 + 12
		local w = fh1 * 2 + 6 + sightexports.sGui:getTextWidthFont(" Streamer mód", "11/Ubuntu-R.ttf")
		local label = sightexports.sGui:createGuiElement("label", pw / 2 - w / 2 + fh1 * 2 + 6, y, pw, fh1, streamerModePrompt)
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, " Streamer mód")
		streamerModeToggle = sightexports.sGui:createGuiElement("toggle", pw / 2 - w / 2, y, fh1 * 2, fh1, streamerModePrompt)
		sightexports.sGui:setToggleState(streamerModeToggle, val, true)
		sightexports.sGui:setClickEvent(streamerModeToggle, "streamerModeToggleChange")
		sightexports.sGui:setToggleColor(streamerModeToggle, "sightgrey1", "sightred", "sightgreen")
		y = y + fh1 + 12
		local label = sightexports.sGui:createGuiElement("label", 0, y, pw, fh2 * 2, streamerModePrompt)
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-L.ttf")
		sightexports.sGui:setLabelText(label, "Streamer módban az összes jogvédett zene lenémításra kerül.\nKésőbb ezt a beállítást megváltoztathatod a dashboardban (HOME gomb).")
	end
	setTimer(triggerEvent, 500, 1, "extraLoaderDone", localPlayer, "loadDashSettings")
end
function streamerModePromptToFront()
	sightexports.sGui:guiToFront(streamerModePrompt)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function(res)
	if getElementData(localPlayer, "loggedIn") then
		loadSettings()
		loadLateSettings()
	end
end)
addEventHandler("onClientResourceStart", getRootElement(), function(res)
	if getResourceName(res) == "sGui" or source == getResourceRootElement() then
		local resource = getResourceFromName("sGui")
		if resource and getResourceState(resource) == "running" then
			buttonsWidth = 0
			fontSize = math.max(13, bebasSize - 10)
			buttonsHeight = sightexports.sGui:getFontHeight(fontSize .. "/BebasNeueRegular.otf") + dashboardPadding[3] * 4
			for k = 1, #menus do
				local w = sightexports.sGui:getTextWidthFont(menus[k].name, fontSize .. "/BebasNeueRegular.otf")
				if w > buttonsWidth then
					buttonsWidth = w
				end
			end
			buttonsWidth = buttonsWidth + dashboardPadding[3] * 8
			sightexports.sGui:cacheGradient(buttonsWidth, buttonsHeight, {
				"sightgreen-second",
				"sightgreen"
			})
			sightexports.sGui:cacheGradient(buttonsWidth, buttonsHeight, {"sightgrey2", "sightgrey1"})
			sightexports.sGui:cacheGradient(100, 20, {
				"sightgreen",
				"sightgreen-second"
			})
			sightexports.sGui:cacheGradient(100, 20, {"sightgrey1", "sightgrey2"})
		end
	end
end)
function settingsInsideDraw(x, y, isx, isy, i, j, irtg)
	rtg = irtg
	sx, sy = isx, isy
	local rect = sightexports.sGui:createGuiElement("rectangle", x + buttonsWidth, y, sx - buttonsWidth, sy, rtg)
	sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey2")
	for k = 1, #menus do
		menus[k].button = sightexports.sGui:createGuiElement("button", x, y, buttonsWidth, buttonsHeight, rtg)
		if currentMenu == k then
			sightexports.sGui:setGuiBackground(menus[k].button, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(menus[k].button, "gradient", {
				"sightgreen-second",
				"sightgreen"
			}, true)
		else
			sightexports.sGui:setGuiBackground(menus[k].button, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(menus[k].button, "gradient", {"sightgrey2", "sightgrey1"}, true)
		end
		sightexports.sGui:setButtonFont(menus[k].button, fontSize .. "/BebasNeueRegular.otf")
		sightexports.sGui:setButtonTextColor(menus[k].button, "#ffffff")
		sightexports.sGui:setButtonText(menus[k].button, menus[k].name)
		sightexports.sGui:setButtonTextAlign(menus[k].button, "left", "center")
		sightexports.sGui:setButtonTextPadding(menus[k].button, dashboardPadding[3] * 4, dashboardPadding[3] * 2)
		sightexports.sGui:setClickEvent(menus[k].button, "settingsMenuClick", false)
		y = y + buttonsHeight
	end
	sx = sx - dashboardPadding[3] * 8
	sy = sy - dashboardPadding[3] * 8
	drawSettingsMenu()
end
addEvent("settingsMenuClick", true)
addEventHandler("settingsMenuClick", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	for k = 1, #menus do
		if el == menus[k].button then
			currentMenu = k
			sightexports.sGui:setGuiBackground(menus[k].button, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(menus[k].button, "gradient", {
				"sightgreen-second",
				"sightgreen"
			}, true)
		else
			sightexports.sGui:setGuiBackground(menus[k].button, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(menus[k].button, "gradient", {"sightgrey2", "sightgrey1"}, true)
		end
	end
	drawSettingsMenu()
end)
addEvent("gotInvitationCode", true)
addEventHandler("gotInvitationCode", root, function(code)
	if code then
		sightexports.sGui:setButtonText(invCodeBtn, code)
	end
end)