local seexports = {
	sGui = false,
	sVehicles = false,
	sVehiclenames = false,
	sHud = false,
	sControls = false,
	sModloader = false,
	sMarkers = false,
	sDashboard = false
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
local sightlangStatImgHand = false
local sightlangStaticImage = {}
local sightlangStaticImageToc = {}
local sightlangStaticImageUsed = {}
local sightlangStaticImageDel = {}
local processSightlangStaticImage = {}
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
processSightlangStaticImage[0] = function()
	if not isElement(sightlangStaticImage[0]) then
		sightlangStaticImageToc[0] = false
		sightlangStaticImage[0] = dxCreateTexture("files/shine.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/charset.dds", "argb", true)
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
			createCarshopMarkers()
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
local helpFont = false
local helpFontScale = false
local keyFont = false
local keyFontScale = false
local arrowIcon = false
local loaderIcon = false
local green = false
local greenEx = false
local blue = false
local grey1 = false
local grey2 = false
local hexv4green = false
local hexv4lightgrey = false
local hexv4blue = false
local hexv4lightgrey = false
local faTicks = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		helpFont = seexports.sGui:getFont("11/Ubuntu-R.ttf")
		helpFontScale = seexports.sGui:getFontScale("11/Ubuntu-R.ttf")
		keyFont = seexports.sGui:getFont("14/BebasNeueRegular.otf")
		keyFontScale = seexports.sGui:getFontScale("14/BebasNeueRegular.otf")
		arrowIcon = seexports.sGui:getFaIconFilename("arrow-up", 32)
		loaderIcon = seexports.sGui:getFaIconFilename("circle-notch", 32)
		green = seexports.sGui:getColorCodeToColor("sightgreen")
		greenEx = seexports.sGui:getColorCode("sightgreen")
		blue = seexports.sGui:getColorCodeToColor("sightblue")
		grey1 = seexports.sGui:getColorCode("sightgrey1")
		grey2 = seexports.sGui:getColorCode("sightgrey2")
		hexv4green = seexports.sGui:getColorCodeHex("sightgreen")
		hexv4lightgrey = seexports.sGui:getColorCodeHex("sightlightgrey")
		hexv4blue = seexports.sGui:getColorCodeHex("sightblue")
		hexv4lightgrey = seexports.sGui:getColorCodeHex("sightlightgrey")
		faTicks = seexports.sGui:getFaTicks()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
	faTicks = seexports.sGui:getFaTicks()
end)
local sightlangStrmMode = true
if seexports.sDashboard then
	local val = seexports.sDashboard:getStreamerMode()
	sightlangStrmMode = val
end
local streamerSounds = {}
function sightlangSoundDestroy()
	streamerSounds[source] = nil
end
function setStreamerModeVolume(sound, vol)
	if not sound then
		return
	end
	if not streamerSounds[sound] then
		addEventHandler("onClientElementDestroy", sound, sightlangSoundDestroy)
	end
	streamerSounds[sound] = vol
	setSoundVolume(sound, sightlangStrmMode and 0 or vol)
end
addEventHandler("streamerModeChanged", getRootElement(), function(val)
	sightlangStrmMode = val
	for sound, vol in pairs(streamerSounds) do
		setSoundVolume(sound, val and 0 or vol)
	end
end)
local white = tocolor(255, 255, 255)
local musicVolume = 0.5
local previewCarPoses = {
	{
		632.5,
		-20.5,
		1001.1
	},
	{
		632.5,
		-13,
		1001.1
	},
	{
		632.5,
		-5.5,
		1001.1
	}
}
local bgMusic = false
local previewCars = {}
local canForceExit = false
local carModelList = {}
function requestCarLogoTexutre(logo)
	logo = utf8.gsub(utf8.lower(logo), " ", "-")
	if fileExists("files/logos/" .. logo .. ".dds") then
		return "files/logos/" .. logo .. ".dds"
	else
		return "files/logos/gta-sa.dds"
	end
end
local carTables = {
	{
		631.1355821875,
		-22.8977690625,
		1001.30231,
		-0.7928896788401,
		0.17147993054207,
		0.58473976315121,
		-0.14908,
		0.03224,
		-0.2116
	},
	{
		631.1288721875,
		-15.2917990625,
		1001.30231,
		-0.8087552938262,
		0.06322963206468,
		0.5847365973984,
		-0.15206,
		0.01189,
		-0.2116
	},
	{
		631.1412321875,
		-8.0599490625,
		1001.30231,
		-0.77955060395403,
		-0.22445970098969,
		0.58473814524668,
		-0.14657,
		-0.0422,
		-0.2116
	}
}
local cx, cy, cz = 632, -13, 1002
local carSelected = false
local currentPreviewCar = 1
local previewCarInterpolation = false
local carCamOffsets = {
	-3.75,
	-2,
	3.75
}
local currentCarScroll = 0
local charset = {
	["0"] = {0, 0.390625},
	["1"] = {25, 0.28125},
	["2"] = {43, 0.359375},
	["3"] = {66, 0.359375},
	["4"] = {89, 0.390625},
	["5"] = {114, 0.375},
	["6"] = {138, 0.375},
	["7"] = {162, 0.34375},
	["8"] = {184, 0.375},
	["9"] = {208, 0.375},
	A = {232, 0.390625},
	B = {257, 0.390625},
	C = {282, 0.359375},
	D = {305, 0.390625},
	E = {330, 0.34375},
	F = {352, 0.328125},
	G = {373, 0.375},
	H = {397, 0.40625},
	I = {423, 0.1875},
	J = {435, 0.25},
	K = {451, 0.390625},
	L = {476, 0.328125},
	M = {497, 0.515625},
	N = {530, 0.40625},
	O = {556, 0.390625},
	P = {581, 0.375},
	Q = {605, 0.390625},
	R = {630, 0.390625},
	S = {655, 0.359375},
	T = {678, 0.34375},
	U = {700, 0.390625},
	V = {725, 0.375},
	W = {749, 0.53125},
	X = {783, 0.390625},
	Y = {808, 0.375},
	Z = {832, 0.34375},
	a = {854, 0.359375},
	b = {877, 0.375},
	c = {901, 0.34375},
	d = {923, 0.375},
	e = {947, 0.359375},
	f = {970, 0.265625},
	g = {987, 0.375},
	h = {1011, 0.375},
	i = {1035, 0.1875},
	j = {1047, 0.1875},
	k = {1059, 0.375},
	l = {1083, 0.1875},
	m = {1095, 0.5625},
	n = {1131, 0.375},
	o = {1155, 0.359375},
	p = {1178, 0.375},
	q = {1202, 0.375},
	r = {1226, 0.265625},
	s = {1243, 0.328125},
	t = {1264, 0.265625},
	u = {1281, 0.375},
	v = {1305, 0.34375},
	w = {1327, 0.515625},
	x = {1360, 0.359375},
	y = {1383, 0.34375},
	z = {1405, 0.328125},
	["-"] = {1426, 0.265625},
	["."] = {1443, 0.203125},
	["'"] = {1456, 0.1875},
	["$"] = {1468, 0.390625},
	["/"] = {1493, 0.375},
	["|"] = {1517, 0.296875},
	["ö"] = {1536, 0.359375},
	["ü"] = {1559, 0.375},
	["ó"] = {1583, 0.359375},
	["ő"] = {1606, 0.359375},
	["é"] = {1653, 0.359375},
	["á"] = {1676, 0.359375},
	["ű"] = {1699, 0.375},
	["Ö"] = {1723, 0.390625},
	["Ü"] = {1748, 0.390625},
	["Ó"] = {1773, 0.390625},
	["Ő"] = {1798, 0.390625},
	["Ú"] = {1823, 0.390625},
	["É"] = {1848, 0.34375},
	["Á"] = {1870, 0.390625},
	["Ű"] = {1895, 0.390625},
	[":"] = {1920, 0.203125},
	["("] = {1933, 0.265625},
	[")"] = {1950, 0.265625},
	["!"] = {1967, 0.21875},
	["?"] = {1981, 1},
	["~"] = {2045, 1},
}
local buyWindow = false
local listWindow = false
local listScroll = 0
local listScrollH = false
local listScrollBar = false
local listElements = false
local selectedColor = 1
local selectedColorBackground = false
local colorButtons = {}
local selectedPayment = false
local selectedFuelType = false
local fuelTypeButtons = {}
function refreshCarSigns(model)
	local tmp = {}
	local w = 0
	local name = carshopData[model].name
	local n = utf8.len(name)
	for i = 1, n do
		local c = utf8.sub(name, i, i)
		w = w + (charset[c] and charset[c][2] or 0.25)
		table.insert(tmp, charset[c] and c or false)
	end
	local tmp2 = {}
	local w2 = 0
	local text = false
	local limit = carshopData[model].limit
	local num = carshopData[model].modelNum or 0
	if 0 <= limit then
		if limit > num then
			text = {
				{
					seexports.sGui:thousandsStepper(carshopData[model].price) .. " $",
					green
				},
				{" | ", white},
				{
					num .. "/" .. limit,
					white
				},
				{" | ", white},
				{
					seexports.sGui:thousandsStepper(carshopData[model].premium) .. " PP",
					blue
				}
			}
		else
			text = {
				{
					"LIMIT FULL (" .. limit .. ")",
					white
				},
				{" | ", white},
				{
					"Megvásárolhatod: " .. seexports.sGui:thousandsStepper(carshopData[model].premium) .. " PP",
					blue
				}
			}
		end
	else
		text = {
			{
				seexports.sGui:thousandsStepper(carshopData[model].price) .. " $",
				green
			},
			{
				" | NO LIMIT | ",
				white
			},
			{
				seexports.sGui:thousandsStepper(carshopData[model].premium) .. " PP",
				blue
			}
		}
	end
	table.insert(text, {" | ", white})
	local ft = seexports.sVehicles:getAvailableFuelTypes(model)
	for i = 1, #ft do
		if ft[i] == "electric" then
			table.insert(text, {
				"~",
				green
			})
		else
			table.insert(text, {
				"?",
				ft[i] == "petrol" and green or tocolor(0, 0, 0)
			})
		end
	end
	carshopData[model].scol = {}
	for j = 1, #text do
		local n = utf8.len(text[j][1])
		for i = 1, n do
			local c = utf8.sub(text[j][1], i, i)
			w2 = w2 + (charset[c] and charset[c][2] or 0.25)
			table.insert(tmp2, charset[c] and c or false)
			table.insert(carshopData[model].scol, text[j][2])
		end
	end
	carshopData[model].sw = w
	carshopData[model].scont = tmp
	carshopData[model].sw2 = w2
	carshopData[model].scont2 = tmp2
end
local carTypeSorts = {
	Automobile = 1,
	Bike = 2,
	Quad = 2,
	BMX = 3
}
function sortVehicleTables(a, b)
	if carshopData[a].vehType == carshopData[b].vehType then
		return carshopData[a].name < carshopData[b].name
	else
		return carshopData[a].vehType < carshopData[b].vehType
	end
end
function refreshCarList()
	carModelList = {}
	for k in pairs(carshopData) do
		carshopData[k].logo = requestCarLogoTexutre(seexports.sVehiclenames:getCustomVehicleManufacturer(k))
		carshopData[k].name = seexports.sVehiclenames:getCustomVehicleName(k)
		if tonumber(k) then
			vehtype = getVehicleType(k) or "Automobile"
		else
			vehtype = "Automobile"
		end
		carshopData[k].vehType = carTypeSorts[vehtype] or 1
		carshopData[k].color = math.random(#colorTable)
		refreshCarSigns(k)
		table.insert(carModelList, k)
	end
	table.sort(carModelList, sortVehicleTables)
end
function refreshCarModel(i, force)
	local j = i + currentCarScroll * #previewCarPoses
	local model = carModelList[j]
	local diff = getElementModel(previewCars[i]) ~= model
	if model and (diff or force) then
		local vx, vy, vz = getElementPosition(previewCars[i])
		if diff then
			if not tonumber(carModelList[j]) then
				setElementModel(previewCars[i], exports.sVehiclemods:getCustomModel(carModelList[j]))
				if carModelList[j] == "model_s" or carModelList[j] == "model_y" or carModelList[j] == "leaf" then
					--setElementData(previewCars[i], "electricPreview", true)
					--setElementData(previewCars[i], "vehicle.customModel", carModelList[j])
					exports.sPlate:applyVehiclePlate(previewCars[i])
				else
					--setElementData(previewCars[i], "electricPreview", false)
					--setElementData(previewCars[i], "vehicle.customModel", false)
					exports.sPlatE:applyVehiclePlate(previewCars[i])
				end
			else
				setElementModel(previewCars[i], model)
			end
			local x, y, z = getVehicleComponentPosition(previewCars[i], "wheel_rf_dummy")
			vz = 1000 - (z or -0.5) + (getVehicleModelWheelSize(getElementModel(previewCars[i]), "front_axle") or 1) / 2
		end
		setVehicleOverrideLights(previewCars[currentPreviewCar], 1)
		setVehicleEngineState(previewCars[currentPreviewCar], false)
		setVehicleDamageProof(previewCars[currentPreviewCar], true)
		setVehiclePlateText(previewCars[i], "SIGHTCAR")
		--setElementData(previewCars[i], "vehicle.customModel", false)
		if carSelected and i == currentPreviewCar then
			setElementPosition(previewCars[i], 621.6357421875, -13.5400390625, vz)
			setElementRotation(previewCars[i], 0, 0, 0)
		else
			setElementPosition(previewCars[i], previewCarPoses[i][1], previewCarPoses[i][2], vz)
			setElementRotation(previewCars[i], 0, 0, 90)
		end
		local r, g, b = unpack(colorTable[carshopData[model].color])
		setVehicleColor(previewCars[i], r, g, b, 255, 255, 255, 255, 255, 255, 255, 255, 255)
		setVehicleVariant(previewCars[i], 255, 255)
		fixVehicle(previewCars[i])
		for j = 0, 5 do
			setVehicleDoorState(previewCars[i], j, 0)
		end
		local getComponent = getVehicleComponents(previewCars[i])
		for k in pairs(getComponent) do
			resetVehicleComponentPosition(previewCars[i], k)
		end
		setVehicleHandling(previewCars[i], true)
		local handling = false
		if handling then
			if handling.centerOfMass then
				setVehicleHandling(previewCars[i], "centerOfMass", handling.centerOfMass)
			end
			if handling.suspensionForceLevel then
				setVehicleHandling(previewCars[i], "suspensionForceLevel", handling.suspensionForceLevel)
			end
			if handling.suspensionUpperLimit then
				setVehicleHandling(previewCars[i], "suspensionUpperLimit", handling.suspensionUpperLimit)
			end
			if handling.suspensionLowerLimit then
				setVehicleHandling(previewCars[i], "suspensionLowerLimit", handling.suspensionLowerLimit)
			end
			if handling.suspensionFrontRearBias then
				setVehicleHandling(previewCars[i], "suspensionFrontRearBias", handling.suspensionFrontRearBias)
			end
		end
		carTables[i][10] = model
	end
end
local carshopCreated = false
local carshopFadeIn = false
local carshopRequested = false
local interior = false
local interiorFloor = false
local carSelectInterpolation = false
local colorPicker = 0
local colorPickerMode = false
local colorPickerHover = false
local freeCamMode = false
local freecamInterpolation = false
local freecamInterpolationSw = false
local camX = 0
local camY = 0
local desiredCamZoom = 2
local camZoom = 2
local camCursor = false
local carshopEnterInterpolation = false
local carshopEnterSkipFade = false
local carSelectSkipFade = false
local listSelectFade = false
local carshopBuyInterpolation = false
local carshopExit = false
local carshopExited = false
local carshopFadeOut = false
local buyingCar = false
addEvent("playerExitCarshop", true)
addEventHandler("playerExitCarshop", getRootElement(), function()
	if carshopCreated then
		carshopFadeOut = getTickCount()
		seexports.sHud:setHudEnabled(true, 500)
		showChat(true)
		seexports.sControls:toggleAllControls(true)
		setCameraTarget(localPlayer)
		carshopCreated = false
		carModelList = {}
		if isElement(interior) then
			destroyElement(interior)
		end
		interior = nil
		if isElement(interiorFloor) then
			destroyElement(interiorFloor)
		end
		interiorFloor = nil
		restoreWorldModel(14776, 10, 621.785, -12.5417, 1000.922)
		for i = 1, #previewCars do
			if isElement(previewCars[i]) then
				destroyElement(previewCars[i])
			end
			previewCars[i] = nil
		end
		if isElement(bgMusic) then
			destroyElement(bgMusic)
		end
		bgMusic = nil
		if buyWindow then
			seexports.sGui:deleteGuiElement(buyWindow)
		end
		buyWindow = nil
		if listWindow then
			seexports.sGui:deleteGuiElement(listWindow)
		end
		listWindow = nil
		listElements = false
		exports.sPlate:hideSearchSymbol(true)
		removeEventHandler("onClientKey", getRootElement(), carshopKey)
		removeEventHandler("onClientPreRender", getRootElement(), carshopPreRender)
	end
end)
local loading = false
local loadingA = 0
function createCarshop()
	if not carshopCreated then
		exports.sPlate:hideSearchSymbol(false)
		canForceExit = false
		currentCarScroll = 0
		previewCarInterpolation = false
		carSelected = false
		currentPreviewCar = 1
		carshopExit = false
		carSelectInterpolation = false
		colorPicker = 0
		colorPickerMode = false
		colorPickerHover = false
		freeCamMode = false
		freecamInterpolation = false
		freecamInterpolationSw = false
		camX = 0
		camY = 0
		desiredCamZoom = 2
		camZoom = 2
		camCursor = false
		carshopEnterInterpolation = false
		carshopEnterSkipFade = false
		carSelectSkipFade = false
		carshopBuyInterpolation = false
		carshopRequested = false
		carshopCreated = true
		carshopExited = false
		loading = false
		loadingA = 0
		local dim = 65535 - getElementData(localPlayer, "playerID") + 1
		interior = createObject(seexports.sModloader:getModelId("carshop_int"), 621.6357421875, -13.5400390625, 1000)
		setElementInterior(interior, 11)
		setElementDimension(interior, dim)
		setElementDoubleSided(interior, true)
		interiorFloor = createObject(seexports.sModloader:getModelId("carshop_int_floor"), 621.6357421875, -13.5400390625, 1000)
		setElementInterior(interiorFloor, 11)
		setElementDimension(interiorFloor, dim)
		setElementAlpha(interiorFloor, 235)
		removeWorldModel(14776, 10, 621.785, -12.5417, 1000.922)
		refreshCarList()
		for i = 1, #previewCarPoses do
			previewCars[i] = createVehicle(carModelList[i], previewCarPoses[i][1], previewCarPoses[i][2], previewCarPoses[i][3], 0, 0, 90)
			setElementInterior(previewCars[i], 11)
			setElementDimension(previewCars[i], dim)
			refreshCarModel(i, true)
			setTimer(refreshCarModel, 1000, 1, i, true)
		end
		bgMusic = playSound("files/music.mp3", true)
		setStreamerModeVolume(bgMusic, 0.5)
		if carshopFadeOut then
			carshopFadeOut = false
		else
			addEventHandler("onClientRender", getRootElement(), carshopRender)
		end
	end
end
function carshopKey(key, por)
	cancelEvent()
	if por then
		if key == "z" then
			musicVolume = 0 < musicVolume and 0 or 0.5
			if not carshopExit and not carshopFadeIn and not carshopBuyInterpolation then
				setStreamerModeVolume(bgMusic, musicVolume)
			end
		elseif not previewCarInterpolation and not freecamInterpolation and not carshopBuyInterpolation and not carshopExit and not carshopEnterSkipFade and not carSelectSkipFade and not listSelectFade and not buyingCar then
			if carSelectInterpolation then
				if (key == "space" or key == "enter" or key == "backspace") and carSelectInterpolation[2] < 5 then
					carSelectSkipFade = getTickCount()
				end
			elseif carshopEnterInterpolation then
				if (key == "space" or key == "enter" or key == "backspace") and carshopEnterInterpolation[2] ~= 3 then
					carshopEnterSkipFade = getTickCount()
				end
			elseif listWindow then
				if key == "backspace" then
					if listWindow then
						seexports.sGui:deleteGuiElement(listWindow)
					end
					listWindow = nil
					listElements = false
					showCursor(freeCamMode or colorPickerMode or buyWindow or listWindow and true or false)
				elseif key == "mouse_wheel_up" then
					if 0 < listScroll then
						listScroll = listScroll - 1
						refershCarshopListWindow()
					end
				elseif key == "mouse_wheel_down" and listScroll < #carModelList - 12 then
					listScroll = listScroll + 1
					refershCarshopListWindow()
				end
			elseif buyWindow then
				if key == "backspace" then
					deleteBuyWindow()
				end
			elseif carSelected then
				if key == "mouse1" then
					if 1 <= colorPicker and colorPickerHover then
						carshopData[carTables[currentPreviewCar][10]].color = colorPickerHover
						colorPickerMode = false
						showCursor(false)
					end
				elseif key == "enter" then
					selectedFuelType = false
					createBuyWindow()
					colorPickerMode = false
					if freeCamMode then
						freecamInterpolation = getTickCount()
						freecamInterpolationSw = false
					end
				elseif key == "q" then
					freecamInterpolation = getTickCount()
					freecamInterpolationSw = false
					if not freeCamMode then
						camX = 0.15
						camY = 0.42
						desiredCamZoom = 1.7
						camZoom = 1.7
						camCursor = false
					end
				elseif key == "c" and not freeCamMode then
					colorPickerMode = not colorPickerMode
					colorPickerHover = false
					showCursor(freeCamMode or colorPickerMode or buyWindow or listWindow and true or false)
					seexports.sGui:setCursorType("normal")
				elseif key == "backspace" then
					carSelectInterpolation = {
						getTickCount(),
						6
					}
				end
				if freeCamMode then
					if key == "mouse_wheel_up" then
						if 1 < desiredCamZoom then
							desiredCamZoom = desiredCamZoom - 0.1
						end
						return
					elseif key == "mouse_wheel_down" then
						if desiredCamZoom < 2 then
							desiredCamZoom = desiredCamZoom + 0.1
						end
						return
					end
				end
			elseif key == "backspace" then
				carshopExit = getTickCount()
			elseif key == "enter" then
				colorPicker = 0
				colorPickerMode = false
				carSelectInterpolation = {
					getTickCount(),
					1
				}
			elseif key == "l" then
				createCarshopListWindow()
			elseif key == "arrow_r" or key == "d" then
				if 1 < currentPreviewCar then
					previewCarInterpolation = {
						getTickCount(),
						currentPreviewCar
					}
					currentPreviewCar = currentPreviewCar - 1
				elseif 0 < currentCarScroll then
					currentCarScroll = currentCarScroll - 1
					previewCarInterpolation = {
						getTickCount(),
						currentPreviewCar,
						true,
						false
					}
					currentPreviewCar = #previewCarPoses
					refreshCarModel(currentPreviewCar)
				end
			elseif key == "arrow_l" or key == "a" then
				if currentPreviewCar < #previewCarPoses then
					if carModelList[currentPreviewCar + 1 + currentCarScroll * #previewCarPoses] then
						previewCarInterpolation = {
							getTickCount(),
							currentPreviewCar
						}
						currentPreviewCar = currentPreviewCar + 1
					end
				elseif carModelList[1 + (currentCarScroll + 1) * #previewCarPoses] then
					currentCarScroll = currentCarScroll + 1
					previewCarInterpolation = {
						getTickCount(),
						currentPreviewCar,
						true,
						true
					}
					currentPreviewCar = 1
					refreshCarModel(currentPreviewCar)
				end
			end
		elseif canForceExit and not buyWindow and not carSelected and key == "backspace" then
			carshopExit = getTickCount()
			canForceExit = false
		end
	end
end
local screenX, screenY = guiGetScreenSize()
local keyHelp = {
	buywindow = {
		{
			"Backspace",
			"Visszalépés"
		},
		{"Z", "music"}
	},
	intro = {
		{
			"Space",
			"Intro átugrása"
		},
		{"Z", "music"}
	},
	carselect = {
		{
			"Space",
			"Bemutató átugrása"
		},
		{"Z", "music"}
	},
	main = {
		{"Backspace", "Kilépés"},
		{
			"L",
			"Járműlista"
		},
		{
			"left",
			"right",
			"Navigálás"
		},
		{
			"Enter",
			"Autó kiválasztása"
		},
		{"Z", "music"}
	},
	selected = {
		{
			"Backspace",
			"Visszalépés"
		},
		{"Q", "Kamera"},
		{"mrc", "Mozgatás"},
		{"mw", "Zoom"},
		{"C", "Fényezés"},
		{
			"Enter",
			"Autó megvásárlása"
		},
		{"Z", "music"}
	}
}
function drawKeyHelp(now)
	local a = 1
	local h = 32
	local x, y = 24, screenY - h - 24
	local c = "main"
	if carshopEnterInterpolation then
		c = "intro"
	elseif buyWindow or listWindow then
		c = "buywindow"
	elseif carSelectInterpolation and (1 < carSelectInterpolation[2] or now - carSelectInterpolation[1] > 500) and carSelectInterpolation[2] <= 5 then
		c = "carselect"
	elseif carSelected then
		c = "selected"
	end
	for i = 1, #keyHelp[c] do
		local n = #keyHelp[c][i]
		if (keyHelp[c][i][1] ~= "mrc" and keyHelp[c][i][1] ~= "mw" or freeCamMode) and (keyHelp[c][i][1] ~= "C" or not freeCamMode) then
			for j = 1, n do
				local key = keyHelp[c][i][j]
				if key == "music" then
					key = 0 < musicVolume and "Zene ki" or "Zene be"
				end
				if j == n then
					local w = dxGetTextWidth(key, helpFontScale, helpFont) + 8 + 4
					if i < #keyHelp[c] then
						dxDrawRectangle(x, y, w + 8, h, tocolor(grey1[1], grey1[2], grey1[3], 255 * a))
						dxDrawText(key, x + 4, y, x + w, y + h, tocolor(255, 255, 255, 255 * a), helpFontScale, helpFont, "center", "center")
						dxDrawRectangle(x + w + 4 - 1, y + 4, 2, h - 8, tocolor(grey2[1], grey2[2], grey2[3], 255 * a))
						x = x + w + 8
					else
						dxDrawRectangle(x, y, w + 4, h, tocolor(grey1[1], grey1[2], grey1[3], 255 * a))
						dxDrawText(key, x + 4, y, x + w, y + h, tocolor(255, 255, 255, 255 * a), helpFontScale, helpFont, "center", "center")
					end
				else
					local tw = 0
					if key == "up" or key == "down" or key == "left" or key == "right" or key == "mrc" or key == "mw" then
						tw = h - 8
					else
						tw = dxGetTextWidth(key, keyFontScale, keyFont) + 8
					end
					local w = math.max(tw, h - 8)
					dxDrawRectangle(x, y, w + 8, h, tocolor(grey1[1], grey1[2], grey1[3], 255 * a))
					if key == "mrc" or key == "mw" then
						dxDrawImage(x + 4 + 2, y + 4 + 2, tw - 4, tw - 4, dynamicImage("files/" .. key .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255 * a))
					elseif key == "up" or key == "down" or key == "left" or key == "right" then
						dxDrawRectangle(x + 4, y + 4, w, h - 8, tocolor(220, 220, 220, 255 * a))
						local r = 0
						if key == "right" then
							r = 90
						elseif key == "down" then
							r = 180
						elseif key == "left" then
							r = 270
						end
						dxDrawImage(x + 4 + 2, y + 4 + 2, tw - 4, tw - 4, ":sGui/" .. arrowIcon .. (faTicks[arrowIcon] or ""), r, 0, 0, tocolor(0, 0, 0, 255 * a))
					else
						dxDrawRectangle(x + 4, y + 4, w, h - 8, tocolor(220, 220, 220, 255 * a))
						dxDrawText(key, x + 4, y, x + 4 + w, y + h, tocolor(0, 0, 0, 255 * a), keyFontScale, keyFont, "center", "center")
					end
					x = x + w + 4
				end
			end
		end
	end
end
function carshopRender()
	local now = getTickCount()
	loading = false
	local loadP = loadingA
	if carshopFadeOut then
		local p = (now - carshopFadeOut) / 500
		if 1 <= p then
			carshopFadeOut = false
			removeEventHandler("onClientRender", getRootElement(), carshopRender)
		else
			dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * (1 - p)))
		end
		loadP = 0
	elseif carshopExit then
		local p = (now - carshopExit) / 500
		if 1 <= p then
			if not carshopExited then
				carshopExited = true
				triggerServerEvent("playerExitCarshop", localPlayer)
			end
			dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255))
			setStreamerModeVolume(bgMusic, 0)
		else
			dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
			setStreamerModeVolume(bgMusic, musicVolume * (1 - p))
		end
		loadP = loadP * (1 - p)
	elseif carshopFadeIn then
		local p = (now - carshopFadeIn) / 500
		if 1 <= p then
			if not carshopRequested then
				carshopRequested = true
				triggerServerEvent("teleportInsideCarshop", localPlayer)
			end
			dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255))
			setStreamerModeVolume(bgMusic, musicVolume)
		else
			dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
			setStreamerModeVolume(bgMusic, musicVolume * p)
		end
		loadP = loadP * (1 - p)
	elseif carshopBuyInterpolation then
		local delta = now - carshopBuyInterpolation - 8000 + 500
		local p = math.min(1, math.max(0, delta / 500))
		if 1 <= p then
			if not carshopExited then
				carshopExited = true
				triggerServerEvent("playerExitCarshop", localPlayer)
			end
			setStreamerModeVolume(bgMusic, 0)
		else
			setStreamerModeVolume(bgMusic, musicVolume * (1 - p))
		end
		dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
		loadP = loadP * (1 - p)
	else
		drawKeyHelp(now)
		if carSelected and 0 < colorPicker and not freeCamMode then
			local x, y, z = 621.6357421875, -13.5400390625, 1001.0088500977
			local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(previewCars[currentPreviewCar])
			local x, y = getScreenFromWorldPosition(x + maxX, y + maxY, z - 0.5)
			if not x then
				x, y = screenX / 2, screenY / 2
			end
			local p = math.min(1, colorPicker * 2)
			local p2 = math.min(1, math.max(0, colorPicker * 2 - p))
			p = getEasingValue(p, "InOutQuad")
			p2 = getEasingValue(p2, "InOutQuad")
			dxDrawRectangle(x - 2, y, 4, 66 * p, tocolor(grey1[1], grey1[2], grey1[3]))
			y = y + 64 - 32
			local w = (#colorTable * 32 + 4) * p2
			dxDrawRectangle(x - 2, y - 2, w, 36, tocolor(grey1[1], grey1[2], grey1[3]))
			local right = x - 2 + w
			local tmp = false
			local cx, cy = getCursorPosition()
			if cx and 1 <= colorPicker then
				cx = cx * screenX
				cy = cy * screenY
			end
			for i = 1, #colorTable do
				local r, g, b = colorTable[i][1], colorTable[i][2], colorTable[i][3]
				local w = math.min(28, math.max(0, right - (x + 2)))
				dxDrawRectangle(x + 2, y + 2, w, 28, tocolor(r * 0.875, g * 0.875, b * 0.875))
				sightlangStaticImageUsed[0] = true
				if sightlangStaticImageToc[0] then
					processSightlangStaticImage[0]()
				end
				dxDrawImage(x + 2, y + 2, w, 28, sightlangStaticImage[0], 0, 0, 0, tocolor(math.min(255, r * 1.1), math.min(255, g * 1.1), math.min(255, b * 1.1)))
				if cx and x <= cx and cx <= x + w + 4 and y <= cy and cy <= y + 32 then
					tmp = i
				end
				x = x + 32
			end
			if tmp ~= colorPickerHover then
				colorPickerHover = tmp
				if colorPickerHover then
					local r, g, b = unpack(colorTable[colorPickerHover])
					setVehicleColor(previewCars[currentPreviewCar], r, g, b, 255, 255, 255, 255, 255, 255, 255, 255, 255)
				else
					local r, g, b = unpack(colorTable[carshopData[carTables[currentPreviewCar][10]].color])
					setVehicleColor(previewCars[currentPreviewCar], r, g, b, 255, 255, 255, 255, 255, 255, 255, 255, 255)
				end
				seexports.sGui:setCursorType(colorPickerHover and "link" or "normal")
			end
		end
		if carshopEnterInterpolation then
			if carshopEnterInterpolation[2] == 1 then
				local delta = now - carshopEnterInterpolation[1]
				local p = 1 - math.min(1, math.max(0, (delta - 250) / 500))
				if 7500 < delta then
					p = math.min(1, (delta - 7500) / 500)
				end
				dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
			elseif carshopEnterInterpolation[2] == 3 then
				local delta = now - carshopEnterInterpolation[1]
				local p = 1 - math.min(1, delta / 500)
				dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
			else
				local delta = now - carshopEnterInterpolation[1]
				local p = 1 - math.min(1, delta / 500)
				if 7500 < delta then
					p = math.min(1, (delta - 7500) / 500)
				end
				dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
			end
		end
		if freecamInterpolation then
			local delta = now - freecamInterpolation
			local p = math.min(1, delta / 500)
			if 500 < delta then
				if not freecamInterpolationSw then
					freeCamMode = not freeCamMode
					showCursor(freeCamMode or colorPickerMode or buyWindow or listWindow and true or false)
					freecamInterpolationSw = true
				end
				p = 1 - math.min(1, (delta - 500) / 500)
				if p <= 0 then
					freecamInterpolation = false
				end
			end
			dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
		end
		if carshopEnterSkipFade then
			local cont = true
			if carshopEnterInterpolation then
				local delta = 8000 - (getTickCount() - carshopEnterInterpolation[1])
				if delta < 500 then
					carshopEnterSkipFade = now - 500
					cont = false
				end
			end
			if cont then
				local p = (now - carshopEnterSkipFade) / 500
				if 2 <= p then
					carshopEnterSkipFade = false
					p = 0
				elseif 1 <= p then
					if carshopEnterInterpolation and carshopEnterInterpolation[2] ~= 3 then
						carshopEnterInterpolation[1] = 0
						carshopEnterInterpolation[2] = 3
					end
					p = 2 - p
				end
				dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
			end
		end
		if carSelectSkipFade then
			local p = (now - carSelectSkipFade) / 500
			if 2 <= p then
				carSelectSkipFade = false
				p = 0
			elseif 1 <= p then
				if carSelectInterpolation and carSelectInterpolation[2] ~= 5 then
					carSelectInterpolation[1] = 0
					carSelectInterpolation[2] = 5
				end
				p = 2 - p
			end
			dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
		end
		if listSelectFade then
			local p = (now - listSelectFade[1]) / 500
			if 2 <= p then
				listSelectFade = false
				p = 0
			elseif 1 <= p then
				if not listSelectFade[3] then
					listSelectFade[3] = true
					currentPreviewCar = listSelectFade[2]
					currentCarScroll = math.ceil(currentPreviewCar / #previewCarPoses) - 1
					currentPreviewCar = currentPreviewCar - currentCarScroll * #previewCarPoses
					previewCarInterpolation = {0, currentPreviewCar}
					for i = 1, #previewCarPoses do
						refreshCarModel(i)
					end
				end
				p = 2 - p
			end
			dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
		end
		if carSelectInterpolation then
			if carSelectInterpolation[2] == 1 or carSelectInterpolation[2] == 6 then
				local p = math.min(1, (now - carSelectInterpolation[1]) / 500)
				dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
			elseif 2 <= carSelectInterpolation[2] and carSelectInterpolation[2] <= 4 then
				local delta = now - carSelectInterpolation[1]
				local p = 1 - math.min(1, delta / 500)
				if 7500 < delta then
					p = math.min(1, (delta - 7500) / 500)
				end
				dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
			elseif carSelectInterpolation[2] == 5 or carSelectInterpolation[2] == 7 then
				local delta = now - carSelectInterpolation[1]
				local p = 1 - math.min(1, delta / 500)
				dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255 * p))
			end
		end
	end
end
local pih = math.pi / 2
function getPositionFromMatrixOffset(m, offX, offY, offZ)
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z
end
function cameraMovement(p, p2, minX, minY, maxX, maxY, maxZ, d)
	local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(previewCars[currentPreviewCar])
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
	local m = getElementMatrix(previewCars[currentPreviewCar])
	local cx, cy, cz = getPositionFromMatrixOffset(m, x, y, z)
	local tx, ty, tz = getPositionFromMatrixOffset(m, x2, y2, z2)
	return cx, cy, cz, tx, ty, tz
end
function carshopPreRender(delta)
	local now = getTickCount()
	canForceExit = false
	if loading then
		if loadingA < 1 then
			loadingA = loadingA + delta / 500
			if 1 < loadingA then
				loadingA = 1
			end
		end
	elseif 0 < loadingA then
		loadingA = loadingA - delta / 500
		if loadingA < 0 then
			loadingA = 0
		end
	end
	if carSelected then
		local t = colorPickerMode and 1 or 0
		if t < colorPicker then
			colorPicker = colorPicker - 1 * delta / 1000
			if t > colorPicker then
				colorPicker = t
			end
		elseif t > colorPicker then
			colorPicker = colorPicker + 1 * delta / 1000
			if t < colorPicker then
				colorPicker = t
			end
		end
	end
	if carSelectInterpolation then
		local t = 500
		if 2 <= carSelectInterpolation[2] and carSelectInterpolation[2] <= 5 then
			t = 8000
		end
		local p = math.min(1, (now - carSelectInterpolation[1]) / t)
		if carSelectInterpolation[2] == 2 then
			local x, y, z = 621.6357421875, -13.5400390625, 1001.0088500977
			local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(previewCars[currentPreviewCar])
			minY = minY * 1.25
			maxY = maxY * 1.25
			y = y + (minY + (maxY - minY) * p)
			setCameraMatrix(x + maxX * 1.25 + 4.5, y, z, x, y, z)
		elseif carSelectInterpolation[2] == 3 then
			local x, y, z = 621.6357421875, -13.5400390625, 1001.0088500977
			local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(previewCars[currentPreviewCar])
			minY = minY * 1.25
			maxY = maxY * 1.25
			y = y + (minY + (maxY - minY) * p)
			setCameraMatrix(x, y - 4, z + maxZ + 1.25, x, y - 2, z + maxZ + 0.25)
		elseif carSelectInterpolation[2] == 4 then
			local x, y, z = 621.6357421875, -13.5400390625, 1001.0088500977
			local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(previewCars[currentPreviewCar])
			setCameraMatrix(x + minX - 4 + 2 * (1 - p), y + maxY + 4 + 2 * (1 - p), z + 5 * (1 - p), x, y, z)
		elseif carSelectInterpolation[2] == 5 then
			p = getEasingValue(p, "OutQuad")
			local x, y, z = 621.6357421875, -13.5400390625, 1001.0088500977
			local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(previewCars[currentPreviewCar])
			y = y + minY * (1 - p)
			local vx, vy, vz = x + minX + 5, y + maxY + 5, z
			x = x - 7.5
			y = y + minY * (1 - p)
			y = y + math.max(carshopData[carTables[currentPreviewCar][10]].sw2 * 0.175, carshopData[carTables[currentPreviewCar][10]].sw * 0.35) * 3 / 2 * -1
			setCameraMatrix(vx, vy, vz - 0.1, x, y, z + 0.25)
		end
		if 1 <= p then
			if carSelectInterpolation[2] == 1 then
				carSelected = true
				refreshCarModel(currentPreviewCar, true)
			elseif carSelectInterpolation[2] == 5 then
				carSelectInterpolation = false
				setVehicleOverrideLights(previewCars[currentPreviewCar], 2)
				if getVehicleType(previewCars[currentPreviewCar]) ~= "Bike" and getVehicleType(previewCars[currentPreviewCar]) ~= "BMX" and not getElementData(previewCars[currentPreviewCar], "electricPreview") then
					setVehicleEngineState(previewCars[currentPreviewCar], true)
				end
			elseif carSelectInterpolation[2] == 6 then
				freeCamMode = false
				carSelected = false
				showCursor(false)
				seexports.sGui:setCursorType("normal")
				refreshCarModel(currentPreviewCar, true)
				local cs = math.min(-3, math.max(-5, -getElementRadius(previewCars[currentPreviewCar]) or 0))
				local d = math.min(1.3, cs / -3)
				setCameraMatrix(cx + cs * 0.9 - 4.35, cy + carCamOffsets[currentPreviewCar] * d, cz, previewCarPoses[currentPreviewCar][1] + cs * 0.4, previewCarPoses[currentPreviewCar][2], previewCarPoses[currentPreviewCar][3])
			elseif carSelectInterpolation[2] == 7 then
				carSelectInterpolation = false
			end
			if carSelectInterpolation then
				carSelectInterpolation[1] = now
				carSelectInterpolation[2] = carSelectInterpolation[2] + 1
			end
		end
	elseif carshopBuyInterpolation then
		local p = math.min(1, (now - carshopBuyInterpolation) / 8000)
		p = 1 - getEasingValue(p, "InQuad")
		local x, y, z = 621.6357421875, -13.5400390625, 1001.0088500977
		local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(previewCars[currentPreviewCar])
		if minX and minY then
			y = y + minY * (1 - p)
			local vx, vy, vz = x + minX + 5, y + maxY + 5, z
			x = x - 7.5
			y = y + minY * (1 - p)
			y = y + math.max(carshopData[carTables[currentPreviewCar][10]].sw2 * 0.175, carshopData[carTables[currentPreviewCar][10]].sw * 0.35) * 3 / 2 * -1
			setCameraMatrix(vx, vy, vz - 0.1, x, y, z + 0.25)
		end
	elseif carSelected then
		if freeCamMode then
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
			local zoom = camZoom
			if carshopData[carTables[currentPreviewCar][10]].vehType ~= 1 then
				zoom = zoom + 0.5
			end
			local x = camX
			local y = camY
			local cx, cy, cz, tx, ty, tz = cameraMovement(x, y, minX, minY, maxX, maxY, maxZ, zoom)
			r = 0
			setCameraMatrix(cx, cy, cz, tx, ty, tz, r)
			local cx, cy = getCursorPosition()
			if getKeyState("mouse2") and cx then
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
			local x, y, z = 621.6357421875, -13.5400390625, 1001.0088500977
			local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(previewCars[currentPreviewCar])
			local vx, vy, vz = x + minX + 5, y + maxY + 5, z
			x = x - 7.5
			y = y + math.max(carshopData[carTables[currentPreviewCar][10]].sw2 * 0.175, carshopData[carTables[currentPreviewCar][10]].sw * 0.35) * 3 / 2 * -1
			setCameraMatrix(vx, vy, vz - 0.1, x, y, z + 0.25)
		end
	elseif previewCarInterpolation then
		local p = (now - previewCarInterpolation[1]) / 1500
		if 1 <= p then
			p = 1
		end
		local x, y, z = interpolateBetween(previewCarPoses[previewCarInterpolation[2]][1], previewCarPoses[previewCarInterpolation[2]][2], previewCarPoses[previewCarInterpolation[2]][3], previewCarPoses[currentPreviewCar][1], previewCarPoses[currentPreviewCar][2], previewCarPoses[currentPreviewCar][3], p, "InOutQuad")
		local i = carCamOffsets[previewCarInterpolation[2]] + (carCamOffsets[currentPreviewCar] - carCamOffsets[previewCarInterpolation[2]]) * getEasingValue(p, "InOutQuad")
		local cs1 = math.min(-3, math.max(-5, -(getElementRadius(previewCars[previewCarInterpolation[2]]) or 0)))
		local cs2 = math.min(-3, math.max(-5, -(getElementRadius(previewCars[currentPreviewCar]) or 0)))
		local j = cs1 + (cs2 - cs1) * getEasingValue(p, "InOutQuad")
		if 1 <= p then
			if previewCarInterpolation[3] then
				for i = 1, #previewCarPoses do
					refreshCarModel(i)
				end
			end
			previewCarInterpolation = false
		end
		setCameraMatrix(cx + j * 0.9 - 4.35, cy + i * math.min(1.3, j / -3), cz, x + j * 0.4, y, z)
	elseif carshopEnterInterpolation then
		local p = math.min(1, (now - carshopEnterInterpolation[1]) / 8000)
		if carshopEnterInterpolation[2] == 1 then
			setCameraMatrix(615.5595703125, -4.33203125 - 4 * p, 1001.8072509766, 605.5595703125, -4.33203125 - 12 * p, 1001.8072509766)
		elseif carshopEnterInterpolation[2] == 2 then
			local x, y, z = interpolateBetween(615.65625, -7.73046875, 1002.8077392578, 613.65625, -7.73046875, 1002.8077392578, p, "Linear")
			local tx, ty, tz = interpolateBetween(630.1748046875, -23.744140625, 1005.2076416016, 616.1748046875, -23.744140625, 1005.2076416016, p, "Linear")
			setCameraMatrix(x, y, z, tx, ty, tz)
		elseif carshopEnterInterpolation[2] == 3 then
			local cs = math.min(-3, math.max(-5, -getElementRadius(previewCars[currentPreviewCar]) or 0))
			local d = math.min(1.3, cs / -3)
			local x, y, z = interpolateBetween(624.4873046875, -8.087890625, 1002.2, cx + cs * 0.9 - 4.35, cy + carCamOffsets[currentPreviewCar] * d, cz, p, "OutQuad")
			setCameraMatrix(x, y, z, previewCarPoses[currentPreviewCar][1] + cs * 0.4, previewCarPoses[currentPreviewCar][2] + 12 - 12 * getEasingValue(p, "OutQuad"), previewCarPoses[currentPreviewCar][3])
			if 1 <= p then
				carshopEnterInterpolation = false
			end
		end
		if 1 <= p and carshopEnterInterpolation then
			local continue = true
			if continue then
				carshopEnterInterpolation[1] = now
				carshopEnterInterpolation[2] = carshopEnterInterpolation[2] + 1
			end
		end
	else
		local cs = math.min(-3, math.max(-5, -(getElementRadius(previewCars[currentPreviewCar]) or 0)))
		local d = math.min(1.3, cs / -3)
		setCameraMatrix(cx + cs * 0.9 - 4.35, cy + carCamOffsets[currentPreviewCar] * d, cz, previewCarPoses[currentPreviewCar][1] + cs * 0.4, previewCarPoses[currentPreviewCar][2], previewCarPoses[currentPreviewCar][3])
	end
	sightlangStaticImageUsed[1] = true
	if sightlangStaticImageToc[1] then
		processSightlangStaticImage[1]()
	end
	local charsetTex = sightlangStaticImage[1]
	for i = 1, #carTables do
		local x, y, z = carTables[i][1], carTables[i][2], carTables[i][3]
		local nx, ny, nz = carTables[i][4], carTables[i][5], carTables[i][6]
		local tx, ty, tz = carTables[i][7] * 0.9, carTables[i][8] * 0.9, carTables[i][9] * 0.9
		x = x + nx * 0.005
		y = y + ny * 0.005
		z = z + nz * 0.005
		local model = carTables[i][10]
		dxDrawMaterialLine3D(x - tx, y - ty, z - tz, x + tx, y + ty, z + tz, dynamicImage(carshopData[model].logo), 0.4695147, tocolor(255, 255, 255), x + nx, y + ny, z + nz)
		local oy = 0
		local fx = 0
		local s = 1
		local d = 1
		if carSelected and i == currentPreviewCar then
			x, oy, z = 621.6357421875, -13.5400390625, 1001.0088500977
			x = x - 7.5
			z = z - 1.25
			fx = x + 1
			d = -1
			s = 3
		else
			x, z = previewCarPoses[i][1] - (getElementRadius(previewCars[i]) or 0), 1000
			oy = previewCarPoses[i][2]
			fx = x - 1
		end
		z = z + 0.1 * s
		y = oy + carshopData[model].sw2 * 0.175 * s / 2 * d
		for j = 1, #carshopData[model].scont2 do
			if carshopData[model].scont2[j] then
				local w = charset[carshopData[model].scont2[j]]
				local lw = w[2] * 0.175 * s
				dxDrawMaterialSectionLine3D(x, y - lw / 2 * d, z + 0.175 * s, x, y - lw / 2 * d, z, w[1], 0, w[2] * 64, 64, charsetTex, lw, carshopData[model].scol[j], fx, y - lw / 2 * d, z)
				y = y - lw * d
			else
				y = y - 0.04375 * s * d
			end
		end
		z = z + 0.175 * s
		y = oy + carshopData[model].sw * 0.35 * s / 2 * d
		for j = 1, #carshopData[model].scont do
			if carshopData[model].scont[j] then
				local w = charset[carshopData[model].scont[j]]
				local lw = w[2] * 0.35 * s
				dxDrawMaterialSectionLine3D(x, y - lw / 2 * d, z + 0.35 * s, x, y - lw / 2 * d, z, w[1], 0, w[2] * 64, 64, charsetTex, lw, tocolor(255, 255, 255), fx, y - lw / 2 * d, z)
				y = y - lw * d
			else
				y = y - 0.0875 * s * d
			end
		end
	end
end
addEvent("changeBuyWindowFuelType", false)
addEventHandler("changeBuyWindowFuelType", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if fuelTypeButtons[el] then
		selectedFuelType = fuelTypeButtons[el]
		local ft = seexports.sVehicles:getAvailableFuelTypes(carTables[currentPreviewCar][10])
		if getElementData(previewCars[currentPreviewCar], "electricPreview") then
			ft = "electric"
		end
		for k, i in pairs(fuelTypeButtons) do
			seexports.sGui:setCheckboxChecked(k, i == selectedFuelType)
		end
	end
end)
addEvent("changeBuyWindowVehicleColor", false)
addEventHandler("changeBuyWindowVehicleColor", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if colorButtons[el] then
		selectedColor = colorButtons[el]
		carshopData[carTables[currentPreviewCar][10]].color = selectedColor
		local r, g, b = unpack(colorTable[carshopData[carTables[currentPreviewCar][10]].color])
		setVehicleColor(previewCars[currentPreviewCar], r, g, b, 255, 255, 255, 255, 255, 255, 255, 255, 255)
		local pw = 400
		local cw = (pw - 8) / #colorTable
		seexports.sGui:setGuiPosition(selectedColorBackground, 4 + (selectedColor - 1) * cw + 1, false)
	end
end)
function refershCarshopListWindow()
	local fh = seexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
	for i = 1, 12 do
		local model = carModelList[i + listScroll]
		if model then
			local data = carshopData[model]
			local logo = listElements[i][1]
			seexports.sGui:setImageDDS(logo, ":sCarshop/" .. data.logo)
			local label = listElements[i][2]
			seexports.sGui:setLabelText(label, data.name)
			local limit = hexv4lightgrey .. "Limit: nincs"
			if carshopData[model].limit > 0 then
				limit = "#ffffffLimit: " .. math.min(carshopData[model].modelNum, carshopData[model].limit) .. "/" .. carshopData[model].limit
			elseif carshopData[model].limit == 0 then
				limit = "#ffffffLimit: 0"
			end
			local label = listElements[i][3]
			seexports.sGui:setLabelText(label, hexv4green .. seexports.sGui:thousandsStepper(carshopData[model].price) .. " $" .. hexv4lightgrey .. " | " .. hexv4blue .. seexports.sGui:thousandsStepper(carshopData[model].premium) .. " PP" .. hexv4lightgrey .. " | " .. limit)
			
			local ft = seexports.sVehicles:getAvailableFuelTypes(model)
			local isPetrol = false
			local isDiesel = false
			local isElectric = false
			for i = 1, #ft do
			  if ft[i] == "petrol" then
				isPetrol = true
			  elseif ft[i] == "diesel" then
				isDiesel = true
			  end
			end

			if model == "model_s" or model == "model_y" or model == "leaf" then
				isElectric = true
				isPetrol = false
				isDiesel = false
			end

			local tw = seexports.sGui:getLabelTextWidth(label) + 8
			local icon = listElements[i][4]
			if isPetrol then
			  seexports.sGui:setGuiRenderDisabled(icon, false)
			  seexports.sGui:setGuiPosition(icon, tw)
			  tw = tw + fh
			else
			  seexports.sGui:setGuiRenderDisabled(icon, true)
			end
			local icon = listElements[i][5]
			if isDiesel then
			  seexports.sGui:setGuiRenderDisabled(icon, false)
			  seexports.sGui:setGuiPosition(icon, tw)
			else
			  seexports.sGui:setGuiRenderDisabled(icon, true)
			end
			
			local icon = listElements[i][7]
			if isElectric then
			  seexports.sGui:setGuiRenderDisabled(icon, false)
			  seexports.sGui:setGuiPosition(icon, tw)
			else
			  seexports.sGui:setGuiRenderDisabled(icon, true)
			end

			local btn = listElements[i][6]
			seexports.sGui:setClickArgument(btn, model)
		end
	end
	local sh = listScrollH / math.max(1, #carModelList - 12 + 1)
	seexports.sGui:setGuiPosition(listScrollBar, false, sh * listScroll)
	seexports.sGui:setGuiSize(listScrollBar, false, sh)
end
function createCarshopListWindow()
	if listWindow then
		seexports.sGui:deleteGuiElement(listWindow)
	end
	listWindow = nil
	listElements = {}
	local pw = 465
	local ph = 600
	listWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
	seexports.sGui:setWindowTitle(listWindow, "16/BebasNeueRegular.otf", "Járműlista")
	seexports.sGui:setWindowCloseButton(listWindow, "closeCarshopListWindow")
	local titleBarHeight = seexports.sGui:getTitleBarHeight()
	local y = titleBarHeight + 8
	local h = (ph - titleBarHeight - 16) / 12
	local fh = seexports.sGui:getFontHeight("11/Ubuntu-R.ttf")
	listScrollH = h * 12
	local rect = seexports.sGui:createGuiElement("rectangle", pw - 8 - 2, y, 2, listScrollH, listWindow)
	seexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
	listScrollBar = seexports.sGui:createGuiElement("rectangle", 0, 0, 2, listScrollH, rect)
	seexports.sGui:setGuiBackground(listScrollBar, "solid", "sightmidgrey")
	for i = 1, 12 do
		listElements[i] = {}
		local logo = seexports.sGui:createGuiElement("image", 8, y + 4, h - 8, h - 8, listWindow)
		listElements[i][1] = logo
		local label = seexports.sGui:createGuiElement("label", 8 + h, y, pw - 16 - 8 - h, h / 2, listWindow)
		seexports.sGui:setLabelAlignment(label, "left", "center")
		seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
		listElements[i][2] = label
		local label = seexports.sGui:createGuiElement("label", 8 + h, y + h / 2, pw - 16 - 8 - h, h / 2, listWindow)
		seexports.sGui:setLabelAlignment(label, "left", "center")
		seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		listElements[i][3] = label
		local icon = seexports.sGui:createGuiElement("image", 0, h / 4 - fh / 2, fh, fh, label)
		seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("gas-pump", fh))
		seexports.sGui:setImageColor(icon, "sightgreen")
		seexports.sGui:setGuiHoverable(icon, true)
		seexports.sGui:guiSetTooltip(icon, "Benzin")
		listElements[i][4] = icon
		local icon = seexports.sGui:createGuiElement("image", 0, h / 4 - fh / 2, fh, fh, label)
		seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("gas-pump", fh))
		seexports.sGui:setImageColor(icon, "#000000")
		seexports.sGui:setGuiHoverable(icon, true)
		seexports.sGui:guiSetTooltip(icon, "Diesel")
		listElements[i][5] = icon
		local btn = seexports.sGui:createGuiElement("image", pw - 16 - 8 - fh * 1.5, y + h / 2 - fh * 1.5 / 2, fh * 1.5, fh * 1.5, listWindow)
		seexports.sGui:setImageFile(btn, seexports.sGui:getFaIconFilename("chevron-double-right", fh * 1.5))
		seexports.sGui:setGuiHoverable(btn, true)
		seexports.sGui:setClickEvent(btn, "carshopSelectListCar")
		seexports.sGui:guiSetTooltip(btn, "Autó kiválasztása")
		listElements[i][6] = btn

		local icon = seexports.sGui:createGuiElement("image", 0, h / 4 - fh / 2, fh, fh, label)
		seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("bolt", fh))
		seexports.sGui:setImageColor(icon, "sightgreen")
		seexports.sGui:setGuiHoverable(icon, true)
		seexports.sGui:guiSetTooltip(icon, "Elektromos")
		listElements[i][7] = icon
		y = y + h
		if i < 12 then
			local border = seexports.sGui:createGuiElement("hr", 8, y - 1, pw - 16 - 8, 2, listWindow)
		end
	end
	showCursor(true)
	refershCarshopListWindow()
end
addEvent("carshopSelectListCar", false)
addEventHandler("carshopSelectListCar", getRootElement(), function(button, state, absoluteX, absoluteY, el, arg)
	if listWindow then
		seexports.sGui:deleteGuiElement(listWindow)
	end
	listWindow = nil
	listElements = false
	showCursor(freeCamMode or colorPickerMode or buyWindow or listWindow and true or false)
	for i = 1, 12 do
		local j = i + listScroll
		local model = carModelList[j]
		if model == arg then
			listSelectFade = {
				getTickCount(),
				j
			}
		end
	end
end)
addEvent("closeCarshopListWindow", false)
addEventHandler("closeCarshopListWindow", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if listWindow then
		seexports.sGui:deleteGuiElement(listWindow)
	end
	listWindow = nil
	listElements = false
	showCursor(freeCamMode or colorPickerMode or buyWindow or listWindow and true or false)
end)
function deleteBuyWindow()
	selectedPayment = false
	fuelTypeButtons = {}
	selectedColor = carshopData[carTables[currentPreviewCar][10]].color
	selectedColorBackground = false
	colorButtons = {}
	if buyWindow then
		seexports.sGui:deleteGuiElement(buyWindow)
	end
	buyWindow = nil
	showCursor(freeCamMode or colorPickerMode or buyWindow or listWindow and true or false)
end
addEvent("closeCarshopBuyWindow", false)
addEventHandler("closeCarshopBuyWindow", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	deleteBuyWindow()
end)
addEvent("carshopBuyWithCash", false)
addEventHandler("carshopBuyWithCash", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	selectedPayment = "cash"
	createBuyPrompt()
end)
addEvent("carshopBuyWithPP", false)
addEventHandler("carshopBuyWithPP", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	selectedPayment = "pp"
	createBuyPrompt()
end)
addEvent("carshopBuyYes", false)
addEventHandler("carshopBuyYes", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	buyingCar = true
	triggerServerEvent("tryToBuyCarshopVehicle", localPlayer, carTables[currentPreviewCar][10], selectedColor, selectedFuelType == "diesel", selectedPayment)
	deleteBuyWindow()
end)
local guiCarshopWindow = false
addEvent("carshopBuyResponse", true)
addEventHandler("carshopBuyResponse", getRootElement(), function(resp)
	buyingCar = false
	if resp then
		carshopBuyInterpolation = getTickCount()
	end
	if guiCarshopWindow then
		if resp then
			deleteGuiCarshop()
		else
			createGuiCarshop()
		end
	end
end)
addEvent("carshopBuyNo", false)
addEventHandler("carshopBuyNo", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	createBuyWindow()
end)
local ppBalance = 0
addEvent("gotPremiumData", true)
addEventHandler("gotPremiumData", getRootElement(), function(balance)
	ppBalance = seexports.sGui:thousandsStepper(balance)
end)
local charMoney = 0
addEvent("refreshMoney", true)
addEventHandler("refreshMoney", getRootElement(), function(amount)
	charMoney = seexports.sGui:thousandsStepper(amount)
end)
function createBuyPrompt()
	if selectedPayment then
		if buyWindow then
			seexports.sGui:deleteGuiElement(buyWindow)
		end
		buyWindow = nil
		local model = carTables[currentPreviewCar][10]
		local pw = 300
		local ph = 230
		buyWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
		seexports.sGui:setWindowTitle(buyWindow, "16/BebasNeueRegular.otf", "Autó megvásárlása")
		local titleBarHeight = seexports.sGui:getTitleBarHeight()
		local label = seexports.sGui:createGuiElement("label", 0, titleBarHeight, pw, ph - titleBarHeight - 32 - 8 - 8, buyWindow)
		seexports.sGui:setLabelAlignment(label, "center", "center")
		seexports.sGui:setLabelText(label, "Biztosan szeretnéd megvásárolni?\n\n" .. "Jármű: [color=sightgreen]" .. seexports.sVehiclenames:getCustomVehicleName(model) .. "\n" .. "#ffffffÜzemanyag: " .. (selectedFuelType == "electric" and "Elektromos" or selectedFuelType == "petrol" and "Benzin" or "Dízel") .. [[
		
		
]] .. "#ffffffFizetés módja: " .. (selectedPayment == "cash" and "[color=sightgreen]Készpénz" or "[color=sightblue]PrémiumPont") .. "\n" .. "#ffffffFizetendő: " .. (selectedPayment == "cash" and "[color=sightgreen]" .. seexports.sGui:thousandsStepper(carshopData[model].price) .. " $" or "[color=sightblue]" .. seexports.sGui:thousandsStepper(carshopData[model].premium) .. " PP"))
		seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		local btn = seexports.sGui:createGuiElement("button", 8, ph - 32 - 8, pw / 2 - 12, 32, buyWindow)
		seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
		seexports.sGui:setGuiHover(btn, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
		seexports.sGui:setButtonText(btn, "Igen")
		seexports.sGui:setClickEvent(btn, "carshopBuyYes")
		local btn = seexports.sGui:createGuiElement("button", pw / 2 + 4, ph - 32 - 8, pw / 2 - 12, 32, buyWindow)
		seexports.sGui:setGuiBackground(btn, "solid", "sightred")
		seexports.sGui:setGuiHover(btn, "gradient", {
			"sightred",
			"sightred-second"
		}, false, true)
		seexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
		seexports.sGui:setButtonText(btn, "Nem")
		seexports.sGui:setClickEvent(btn, "carshopBuyNo")
	end
end
function createBuyWindow()
	deleteBuyWindow()
	showCursor(true)
	local model = carTables[currentPreviewCar][10]
	local ft = seexports.sVehicles:getAvailableFuelTypes(model)
	local titleBarHeight = seexports.sGui:getTitleBarHeight()
	local pw = 400
	local cw = (pw - 8) / #colorTable
	local ph = 400
	buyWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
	seexports.sGui:setWindowTitle(buyWindow, "16/BebasNeueRegular.otf", "Autó megvásárlása")
	seexports.sGui:setWindowCloseButton(buyWindow, "closeCarshopBuyWindow")
	local y = titleBarHeight
	local label = seexports.sGui:createGuiElement("label", 0, y, pw, 48, buyWindow)
	seexports.sGui:setLabelAlignment(label, "center", "center")
	seexports.sGui:setLabelText(label, seexports.sVehiclenames:getCustomVehicleName(model))
	seexports.sGui:setLabelFont(label, "20/BebasNeueBold.otf")
	y = y + 48
	local border = seexports.sGui:createGuiElement("hr", 8, y + 4 - 1, pw - 16, 2, buyWindow)
	y = y + 8
	local label = seexports.sGui:createGuiElement("label", 8, y, pw, 32, buyWindow)
	seexports.sGui:setLabelAlignment(label, "left", "center")
	seexports.sGui:setLabelText(label, "Elérhető motorváltozatok:")
	seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	y = y + 32
	for i = 1, #ft do
		if not selectedFuelType then
			selectedFuelType = ft[i]
		end
		if model == "model_s" or model == "model_y" or model == "leaf" then
			ft[i] = "electric"
		end

		local bbox = seexports.sGui:createGuiElement("rectangle", pw / #ft * (i - 1), y, pw / #ft, 40, buyWindow)
		seexports.sGui:setGuiBackground(bbox, "solid", {
			0,
			0,
			0,
			0
		})
		local checkbox = seexports.sGui:createGuiElement("checkbox", 8, 8, 24, 24, bbox)
		seexports.sGui:setGuiColorScheme(checkbox, "darker")
		seexports.sGui:setCheckboxChecked(checkbox, ft[i] == selectedFuelType)
		seexports.sGui:setGuiBoundingBox(checkbox, bbox)
		seexports.sGui:setClickEvent(checkbox, "changeBuyWindowFuelType")

		local label = seexports.sGui:createGuiElement("label", 76, 0, pw, 40, bbox)
		seexports.sGui:setLabelAlignment(label, "left", "center")
		local fuelType = ft[i] == "electric" and "Elektromos" or ft[i] == "petrol" and "Benzin" or "Dízel"
		if fuelType == "Elektromos" then
			icon = seexports.sGui:createGuiElement("image", 40, 6, 28, 28, bbox)
			seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("bolt", 28))
			seexports.sGui:setImageColor(icon, "sightgreen")
		else
			icon = seexports.sGui:createGuiElement("image", 40, 6, 28, 28, bbox)
			seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("gas-pump", 28))
			seexports.sGui:setImageColor(icon, ft[i] == "petrol" and "sightgreen" or "#000000")
		end

		seexports.sGui:setLabelText(label, fuelType)
		seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		fuelTypeButtons[checkbox] = ft[i]
	end
	y = y + 40
	local border = seexports.sGui:createGuiElement("hr", 8, y + 4 - 1, pw - 16, 2, buyWindow)
	y = y + 8
	local label = seexports.sGui:createGuiElement("label", 8, y, pw, 32, buyWindow)
	seexports.sGui:setLabelAlignment(label, "left", "center")
	seexports.sGui:setLabelText(label, "Fényezés:")
	seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	y = y + 32
	selectedColorBackground = seexports.sGui:createGuiElement("rectangle", 4 + (selectedColor - 1) * cw + 1, y + 1, cw - 2, cw - 2, buyWindow)
	seexports.sGui:setGuiBackground(selectedColorBackground, "solid", "sightgreen")
	local rect = seexports.sGui:createGuiElement("rectangle", 2, 2, cw - 6, cw - 6, selectedColorBackground)
	seexports.sGui:setGuiBackground(rect, "solid", "#000000")
	for i = 1, #colorTable do
		local colorbox = seexports.sGui:createGuiElement("rectangle", 4 + (i - 1) * cw + 4, y + 4, cw - 8, cw - 8, buyWindow)
		seexports.sGui:setGuiBackground(colorbox, "solid", {
			colorTable[i][1] * 0.875,
			colorTable[i][2] * 0.875,
			colorTable[i][3] * 0.875
		})
		seexports.sGui:setGuiHover(colorbox, "none", false, false, true)
		seexports.sGui:setGuiHoverable(colorbox, true)
		seexports.sGui:setClickEvent(colorbox, "changeBuyWindowVehicleColor")
		colorButtons[colorbox] = i
		local colorshine = seexports.sGui:createGuiElement("image", 4 + (i - 1) * cw + 4, y + 4, cw - 8, cw - 8, buyWindow)
		seexports.sGui:setImageDDS(colorshine, ":sCarshop/files/shine.dds")
		seexports.sGui:setImageColor(colorshine, {
			math.min(colorTable[i][1] * 1.1, 255),
			math.min(colorTable[i][2] * 1.1, 255),
			math.min(colorTable[i][3] * 1.1, 255)
		})
	end
	y = y + cw + 8
	local border = seexports.sGui:createGuiElement("hr", 8, y + 4 - 1, pw - 16, 2, buyWindow)
	y = y + 8
	local label = seexports.sGui:createGuiElement("label", 8, y, pw, 32, buyWindow)
	seexports.sGui:setLabelAlignment(label, "left", "center")
	seexports.sGui:setLabelText(label, "Fizetés módja:")
	seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	y = y + 32
	local limit = carshopData[model].limit
	local num = carshopData[model].modelNum or 0
	if limit > num or limit < 0 then
		local label = seexports.sGui:createGuiElement("label", 0, y, pw / 2, ph - y - 32 - 8 - 8, buyWindow)
		seexports.sGui:setLabelAlignment(label, "center", "center")
		seexports.sGui:setLabelText(label, [=[
Egyenleged:
[color=sightgreen]]=] .. seexports.sGui:thousandsStepper(charMoney) .. " $")
		seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		local label = seexports.sGui:createGuiElement("label", pw / 2, y, pw / 2, ph - y - 32 - 8 - 8, buyWindow)
		seexports.sGui:setLabelAlignment(label, "center", "center")
		seexports.sGui:setLabelText(label, [=[
Egyenleged:
[color=sightblue]]=] .. seexports.sGui:thousandsStepper(ppBalance) .. " PP")
		seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		local btn = seexports.sGui:createGuiElement("button", 8, ph - 32 - 8, pw / 2 - 12, 32, buyWindow)
		seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
		seexports.sGui:setGuiHover(btn, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		seexports.sGui:setButtonFont(btn, "15/BebasNeueRegular.otf")
		seexports.sGui:setButtonTextColor(btn, "#ffffff")
		seexports.sGui:setButtonText(btn, " " .. seexports.sGui:thousandsStepper(carshopData[model].price) .. " $")
		seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("dollar-sign", 32))
		seexports.sGui:setClickEvent(btn, "carshopBuyWithCash")
		local btn = seexports.sGui:createGuiElement("button", pw / 2 + 4, ph - 32 - 8, pw / 2 - 12, 32, buyWindow)
		seexports.sGui:setGuiBackground(btn, "solid", "sightblue")
		seexports.sGui:setGuiHover(btn, "gradient", {
			"sightblue",
			"sightblue-second"
		}, false, true)
		seexports.sGui:setButtonFont(btn, "15/BebasNeueRegular.otf")
		seexports.sGui:setButtonTextColor(btn, "#ffffff")
		seexports.sGui:setButtonText(btn, " " .. seexports.sGui:thousandsStepper(carshopData[model].premium) .. " PP")
		seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("gem", 32))
		seexports.sGui:setClickEvent(btn, "carshopBuyWithPP")
	else
		local label = seexports.sGui:createGuiElement("label", 0, y, pw, ph - y - 32 - 8 - 8, buyWindow)
		seexports.sGui:setLabelAlignment(label, "center", "center")
		seexports.sGui:setLabelText(label, [=[
Egyenleged:
[color=sightblue]]=] .. seexports.sGui:thousandsStepper(ppBalance) .. " PP")
		seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		local btn = seexports.sGui:createGuiElement("button", 8, ph - 32 - 8, pw - 16, 32, buyWindow)
		seexports.sGui:setGuiBackground(btn, "solid", "sightblue")
		seexports.sGui:setGuiHover(btn, "gradient", {
			"sightblue",
			"sightblue-second"
		}, false, true)
		seexports.sGui:setButtonFont(btn, "15/BebasNeueRegular.otf")
		seexports.sGui:setButtonTextColor(btn, "#ffffff")
		seexports.sGui:setButtonText(btn, " " .. seexports.sGui:thousandsStepper(carshopData[model].premium) .. " PP")
		seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("gem", 32))
		seexports.sGui:setClickEvent(btn, "carshopBuyWithPP")
	end
end
local guiCarshopTable = false
local guiCarshopLimitLabels = {}
local guiColorButtons = {}
local selectedGuiCarshopModel = false
local selectedGuiCarshopColor = false
local selectedGuiCarshopPayMethod = false
function deleteGuiCarshop()
	guiCarshopLimitLabels = {}
	guiColorButtons = {}
	if guiCarshopWindow then
		seexports.sGui:deleteGuiElement(guiCarshopWindow)
	end
	guiCarshopWindow = nil
end
addEvent("closeGuiCarshopWindow", false)
addEventHandler("closeGuiCarshopWindow", getRootElement(), function()
	if selectedGuiCarshopPayMethod then
		selectedGuiCarshopPayMethod = false
		createGuiCarshop()
	elseif selectedGuiCarshopModel then
		selectedGuiCarshopModel = false
		createGuiCarshop()
	else
		deleteGuiCarshop()
	end
end)
addEvent("magnifyCarshopPhoto", false)
addEventHandler("magnifyCarshopPhoto", getRootElement(), function(button, state, absoluteX, absoluteY, el, k)
	if fileExists("files/others/s" .. k .. ".dds") then
		seexports.sGui:setDDSPreview(":sCarshop/files/others/s" .. k .. ".dds", "dxt1")
	else
		seexports.sGui:setDDSPreview(":sCarshop/files/others/" .. k .. ".dds", "dxt1")
	end
end)
addEvent("carshopGuiPayMethod", false)
addEventHandler("carshopGuiPayMethod", getRootElement(), function(button, state, absoluteX, absoluteY, el, meth)
	if not selectedGuiCarshopColor then
		seexports.sGui:showInfobox("e", "Válassz színt!")
		return
	end
	selectedGuiCarshopPayMethod = meth
	createGuiCarshop()
end)
addEvent("selectGuiCarshopModel", false)
addEventHandler("selectGuiCarshopModel", getRootElement(), function(button, state, absoluteX, absoluteY, el, k)
	selectedGuiCarshopModel = k
	selectedGuiCarshopColor = false
	selectedGuiCarshopPayMethod = false
	createGuiCarshop()
end)
addEvent("changeGuiCarshopColor", false)
addEventHandler("changeGuiCarshopColor", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	selectedGuiCarshopColor = guiColorButtons[el]
	seexports.sGui:setGuiRenderDisabled(currentColorRectangle, false, true)
	local x = seexports.sGui:getGuiPosition(el)
	seexports.sGui:setGuiPosition(currentColorRectangle, x - 3, false)
end)
addEvent("finalCarshopGuiBuy", false)
addEventHandler("finalCarshopGuiBuy", getRootElement(), function()
	buyingCar = true
	triggerServerEvent("tryToBuyCarshopVehicle", localPlayer, selectedGuiCarshopModel, selectedGuiCarshopColor, false, selectedGuiCarshopPayMethod)
	createGuiCarshop()
	selectedGuiCarshopPayMethod = false
end)
local guiCarshopLimitData = {}
addEvent("gotLimitsForGuiShop", true)
addEventHandler("gotLimitsForGuiShop", getRootElement(), function(data)
	if guiCarshopWindow then
		for model, c in pairs(data) do
			if guiCarshopLimitLabels[model] then
				local limit = getCarshopLimit(model)
				if limit and 0 < limit then
					guiCarshopLimitData[model] = math.min(limit, c)
					seexports.sGui:setLabelText(guiCarshopLimitLabels[model], "Limit: " .. guiCarshopLimitData[model] .. "/" .. limit)
				end
			end
		end
	end
end)
function createGuiCarshop()
	deleteGuiCarshop()
	local titleBarHeight = seexports.sGui:getTitleBarHeight()
	local h = 96
	local ih = 80
	local iw = ih * 1.4666666666666666
	local l = (h - 16) / 4
	if buyingCar then
		local ph = 250
		local pw = 400
		guiCarshopWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
		seexports.sGui:setWindowTitle(guiCarshopWindow, "16/BebasNeueRegular.otf", "Kereskedés")
		local loadingIcon = seexports.sGui:createGuiElement("image", pw / 2 - 24, titleBarHeight + (ph - titleBarHeight) / 2 - 24, 48, 48, guiCarshopWindow)
		seexports.sGui:setImageFile(loadingIcon, seexports.sGui:getFaIconFilename("circle-notch", 48))
		seexports.sGui:setImageSpinner(loadingIcon, true)
	elseif selectedGuiCarshopModel then
		local fh = seexports.sGui:getFontHeight("11/Ubuntu-R.ttf") * 2 + 16
		local pw = 400
		local cw = (pw - 8) / #colorTable
		local ph = titleBarHeight + fh + 32 + 8 + h + cw + 8
		guiCarshopWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
		seexports.sGui:setWindowTitle(guiCarshopWindow, "16/BebasNeueRegular.otf", "Kereskedés")
		seexports.sGui:setWindowCloseButton(guiCarshopWindow, "closeGuiCarshopWindow")
		local y = titleBarHeight
		local rect = seexports.sGui:createGuiElement("rectangle", 8, y + 8, iw, ih, guiCarshopWindow)
		seexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
		if fileExists("files/others/s" .. selectedGuiCarshopModel .. "_p.dds") then
			local image = seexports.sGui:createGuiElement("image", 0, 0, iw, ih, rect)
			seexports.sGui:setImageDDS(image, ":sCarshop/files/others/s" .. selectedGuiCarshopModel .. "_p.dds", "dxt1", nil, true)
			seexports.sGui:setGuiHoverable(image, true)
			seexports.sGui:guiSetTooltip(image, "Kattints a kép kinagyításához.")
			seexports.sGui:setClickEvent(image, "magnifyCarshopPhoto")
			seexports.sGui:setClickArgument(image, selectedGuiCarshopModel)
		elseif fileExists("files/others/" .. selectedGuiCarshopModel .. "_p.dds") then
			local image = seexports.sGui:createGuiElement("image", 0, 0, iw, ih, rect)
			seexports.sGui:setImageDDS(image, ":sCarshop/files/others/" .. selectedGuiCarshopModel .. "_p.dds", "dxt1", nil, true)
			seexports.sGui:setGuiHoverable(image, true)
			seexports.sGui:guiSetTooltip(image, "Kattints a kép kinagyításához.")
			seexports.sGui:setClickEvent(image, "magnifyCarshopPhoto")
			seexports.sGui:setClickArgument(image, selectedGuiCarshopModel)
		end
		local label = seexports.sGui:createGuiElement("label", 8 + iw + 8, y + 8, 0, l, guiCarshopWindow)
		seexports.sGui:setLabelAlignment(label, "left", "center")
		seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
		seexports.sGui:setLabelText(label, seexports.sVehiclenames:getCustomVehicleName(selectedGuiCarshopModel))
		local label = seexports.sGui:createGuiElement("label", 8 + iw + 8, y + 8 + l, 0, l, guiCarshopWindow)
		seexports.sGui:setLabelAlignment(label, "left", "center")
		seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		seexports.sGui:setLabelColor(label, "sightgreen")
		seexports.sGui:setLabelText(label, seexports.sGui:thousandsStepper(getCarshopPrice(selectedGuiCarshopModel)) .. " $")
		local label = seexports.sGui:createGuiElement("label", 8 + iw + 8, y + 8 + l * 2, 0, l, guiCarshopWindow)
		seexports.sGui:setLabelAlignment(label, "left", "center")
		seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		seexports.sGui:setLabelColor(label, "sightblue")
		seexports.sGui:setLabelText(label, seexports.sGui:thousandsStepper(getCarshopPremium(selectedGuiCarshopModel)) .. " PP")
		local label = seexports.sGui:createGuiElement("label", 8 + iw + 8, y + 8 + l * 3, 0, l, guiCarshopWindow)
		seexports.sGui:setLabelAlignment(label, "left", "center")
		seexports.sGui:setLabelFont(label, "11/Ubuntu-LI.ttf")
		local limit = getCarshopLimit(selectedGuiCarshopModel)
		if limit and 0 <= limit then
			if guiCarshopLimitData[selectedGuiCarshopModel] then
				seexports.sGui:setLabelText(label, "Limit: " .. guiCarshopLimitData[selectedGuiCarshopModel] .. "/" .. limit)
			else
				seexports.sGui:setLabelText(label, "Limit: " .. limit)
			end
			guiCarshopLimitLabels[selectedGuiCarshopModel] = label
		else
			seexports.sGui:setLabelText(label, "Nincs limit")
			seexports.sGui:setLabelColor(label, "sightlightgrey")
		end
		local border = seexports.sGui:createGuiElement("hr", 8, y + h - 1, pw - 16, 2, guiCarshopWindow)
		y = y + h + 4
		currentColorRectangle = seexports.sGui:createGuiElement("rectangle", 0, y + 4 - 3, cw - 8 + 6, cw - 8 + 6, guiCarshopWindow)
		seexports.sGui:setGuiBackground(currentColorRectangle, "solid", "sightgreen")
		local rect = seexports.sGui:createGuiElement("rectangle", 2, 2, cw - 8 + 2, cw - 8 + 2, currentColorRectangle)
		seexports.sGui:setGuiBackground(rect, "solid", "#000")
		if selectedGuiCarshopColor then
			seexports.sGui:setGuiPosition(currentColorRectangle, 4 + (selectedGuiCarshopColor - 1) * cw + 4 - 3, false)
		else
			seexports.sGui:setGuiRenderDisabled(currentColorRectangle, true, true)
		end
		for i = 1, #colorTable do
			local colorbox = seexports.sGui:createGuiElement("rectangle", 4 + (i - 1) * cw + 4, y + 4, cw - 8, cw - 8, guiCarshopWindow)
			seexports.sGui:setGuiBackground(colorbox, "solid", {
				colorTable[i][1] * 0.875,
				colorTable[i][2] * 0.875,
				colorTable[i][3] * 0.875
			})
			if not selectedGuiCarshopPayMethod then
				seexports.sGui:setGuiHover(colorbox, "none", false, false, true)
				seexports.sGui:setGuiHoverable(colorbox, true)
				seexports.sGui:setClickEvent(colorbox, "changeGuiCarshopColor")
			end
			guiColorButtons[colorbox] = i
			local colorshine = seexports.sGui:createGuiElement("image", 4 + (i - 1) * cw + 4, y + 4, cw - 8, cw - 8, guiCarshopWindow)
			seexports.sGui:setImageDDS(colorshine, ":sCarshop/files/shine.dds")
			seexports.sGui:setImageColor(colorshine, {
				math.min(colorTable[i][1] * 1.1, 255),
				math.min(colorTable[i][2] * 1.1, 255),
				math.min(colorTable[i][3] * 1.1, 255)
			})
		end
		local border = seexports.sGui:createGuiElement("hr", 8, y + cw + 4 - 1, pw - 16, 2, guiCarshopWindow)
		if selectedGuiCarshopPayMethod then
			local label = seexports.sGui:createGuiElement("label", 0, ph - 32 - 8 - fh, pw, fh, guiCarshopWindow)
			seexports.sGui:setLabelAlignment(label, "center", "center")
			if selectedGuiCarshopPayMethod == "pp" then
				seexports.sGui:setLabelText(label, "Biztosan szeretnéd megvásárolni?\nÁr: [color=sightblue]" .. seexports.sGui:thousandsStepper(getCarshopPremium(selectedGuiCarshopModel)) .. " PP")
			else
				seexports.sGui:setLabelText(label, "Biztosan szeretnéd megvásárolni?\nÁr: [color=sightgreen]" .. seexports.sGui:thousandsStepper(getCarshopPrice(selectedGuiCarshopModel)) .. " $")
			end
			seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			local btn = seexports.sGui:createGuiElement("button", 8, ph - 32 - 8, pw / 2 - 12, 32, guiCarshopWindow)
			seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			seexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			seexports.sGui:setButtonFont(btn, "15/BebasNeueRegular.otf")
			seexports.sGui:setButtonTextColor(btn, "#ffffff")
			seexports.sGui:setButtonText(btn, "Igen")
			seexports.sGui:setClickEvent(btn, "finalCarshopGuiBuy")
			local btn = seexports.sGui:createGuiElement("button", pw / 2 + 4, ph - 32 - 8, pw / 2 - 12, 32, guiCarshopWindow)
			seexports.sGui:setGuiBackground(btn, "solid", "sightred")
			seexports.sGui:setGuiHover(btn, "gradient", {
				"sightred",
				"sightred-second"
			}, false, true)
			seexports.sGui:setButtonFont(btn, "15/BebasNeueRegular.otf")
			seexports.sGui:setButtonTextColor(btn, "#ffffff")
			seexports.sGui:setButtonText(btn, "Nem")
			seexports.sGui:setClickEvent(btn, "closeGuiCarshopWindow")
		else
			local limit = getCarshopLimit(selectedGuiCarshopModel)
			local num = guiCarshopLimitData[selectedGuiCarshopModel] or 0
			if limit > num or limit < 0 then
				local label = seexports.sGui:createGuiElement("label", 0, ph - 32 - 8 - fh, pw / 2, fh, guiCarshopWindow)
				seexports.sGui:setLabelAlignment(label, "center", "center")
				seexports.sGui:setLabelText(label, [=[
Egyenleged:
[color=sightgreen]]=] .. seexports.sGui:thousandsStepper(charMoney) .. " $")
				seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
				local label = seexports.sGui:createGuiElement("label", pw / 2, ph - 32 - 8 - fh, pw / 2, fh, guiCarshopWindow)
				seexports.sGui:setLabelAlignment(label, "center", "center")
				seexports.sGui:setLabelText(label, [=[
Egyenleged:
[color=sightblue]]=] .. seexports.sGui:thousandsStepper(ppBalance) .. " PP")
				seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
				local btn = seexports.sGui:createGuiElement("button", 8, ph - 32 - 8, pw / 2 - 12, 32, guiCarshopWindow)
				seexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
				seexports.sGui:setGuiHover(btn, "gradient", {
					"sightgreen",
					"sightgreen-second"
				}, false, true)
				seexports.sGui:setButtonFont(btn, "15/BebasNeueRegular.otf")
				seexports.sGui:setButtonTextColor(btn, "#ffffff")
				seexports.sGui:setButtonText(btn, " " .. seexports.sGui:thousandsStepper(getCarshopPrice(selectedGuiCarshopModel)) .. " $")
				seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("dollar-sign", 32))
				seexports.sGui:setClickEvent(btn, "carshopGuiPayMethod")
				seexports.sGui:setClickArgument(btn, "cash")
				local btn = seexports.sGui:createGuiElement("button", pw / 2 + 4, ph - 32 - 8, pw / 2 - 12, 32, guiCarshopWindow)
				seexports.sGui:setGuiBackground(btn, "solid", "sightblue")
				seexports.sGui:setGuiHover(btn, "gradient", {
					"sightblue",
					"sightblue-second"
				}, false, true)
				seexports.sGui:setButtonFont(btn, "15/BebasNeueRegular.otf")
				seexports.sGui:setButtonTextColor(btn, "#ffffff")
				seexports.sGui:setButtonText(btn, " " .. seexports.sGui:thousandsStepper(getCarshopPremium(selectedGuiCarshopModel)) .. " PP")
				seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("gem", 32))
				seexports.sGui:setClickEvent(btn, "carshopGuiPayMethod")
				seexports.sGui:setClickArgument(btn, "pp")
			else
				local label = seexports.sGui:createGuiElement("label", 0, ph - 32 - 8 - fh, pw, fh, guiCarshopWindow)
				seexports.sGui:setLabelAlignment(label, "center", "center")
				seexports.sGui:setLabelText(label, [=[
Egyenleged:
[color=sightblue]]=] .. seexports.sGui:thousandsStepper(ppBalance) .. " PP")
				seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
				local btn = seexports.sGui:createGuiElement("button", 8, ph - 32 - 8, pw - 16, 32, guiCarshopWindow)
				seexports.sGui:setGuiBackground(btn, "solid", "sightblue")
				seexports.sGui:setGuiHover(btn, "gradient", {
					"sightblue",
					"sightblue-second"
				}, false, true)
				seexports.sGui:setButtonFont(btn, "15/BebasNeueRegular.otf")
				seexports.sGui:setButtonTextColor(btn, "#ffffff")
				seexports.sGui:setButtonText(btn, " " .. seexports.sGui:thousandsStepper(getCarshopPremium(selectedGuiCarshopModel)) .. " PP")
				seexports.sGui:setButtonIcon(btn, seexports.sGui:getFaIconFilename("gem", 32))
				seexports.sGui:setClickEvent(btn, "carshopGuiPayMethod")
				seexports.sGui:setClickArgument(btn, "pp")
			end
		end
	elseif guiCarshopTable then
		local n = 0
		for k in pairs(guiCarshopTable) do
			n = n + 1
		end
		local ph = titleBarHeight + h * n
		local pw = 400
		guiCarshopWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
		seexports.sGui:setWindowTitle(guiCarshopWindow, "16/BebasNeueRegular.otf", "Kereskedés")
		seexports.sGui:setWindowCloseButton(guiCarshopWindow, "closeGuiCarshopWindow")
		local i = 0
		for k in pairs(guiCarshopTable) do
			i = i + 1
			local y = titleBarHeight + h * (i - 1)
			local rect = seexports.sGui:createGuiElement("rectangle", 8, y + 8, iw, ih, guiCarshopWindow)
			seexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
			if fileExists("files/others/s" .. k .. "_p.dds") then
				local image = seexports.sGui:createGuiElement("image", 0, 0, iw, ih, rect)
				seexports.sGui:setImageDDS(image, ":sCarshop/files/others/s" .. k .. "_p.dds", "dxt1", nil, true)
				seexports.sGui:setGuiHoverable(image, true)
				seexports.sGui:guiSetTooltip(image, "Kattints a kép kinagyításához.")
				seexports.sGui:setClickEvent(image, "magnifyCarshopPhoto")
				seexports.sGui:setClickArgument(image, k)
			elseif fileExists("files/others/" .. k .. "_p.dds") then
				local image = seexports.sGui:createGuiElement("image", 0, 0, iw, ih, rect)
				seexports.sGui:setImageDDS(image, ":sCarshop/files/others/" .. k .. "_p.dds", "dxt1", nil, true)
				seexports.sGui:setGuiHoverable(image, true)
				seexports.sGui:guiSetTooltip(image, "Kattints a kép kinagyításához.")
				seexports.sGui:setClickEvent(image, "magnifyCarshopPhoto")
				seexports.sGui:setClickArgument(image, k)
			end
			local label = seexports.sGui:createGuiElement("label", 8 + iw + 8, y + 8, 0, l, guiCarshopWindow)
			seexports.sGui:setLabelAlignment(label, "left", "center")
			seexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
			seexports.sGui:setLabelText(label, seexports.sVehiclenames:getCustomVehicleName(k))
			local label = seexports.sGui:createGuiElement("label", 8 + iw + 8, y + 8 + l, 0, l, guiCarshopWindow)
			seexports.sGui:setLabelAlignment(label, "left", "center")
			seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			seexports.sGui:setLabelColor(label, "sightgreen")
			seexports.sGui:setLabelText(label, seexports.sGui:thousandsStepper(getCarshopPrice(k)) .. " $")
			local label = seexports.sGui:createGuiElement("label", 8 + iw + 8, y + 8 + l * 2, 0, l, guiCarshopWindow)
			seexports.sGui:setLabelAlignment(label, "left", "center")
			seexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			seexports.sGui:setLabelColor(label, "sightblue")
			seexports.sGui:setLabelText(label, seexports.sGui:thousandsStepper(getCarshopPremium(k)) .. " PP")
			local label = seexports.sGui:createGuiElement("label", 8 + iw + 8, y + 8 + l * 3, 0, l, guiCarshopWindow)
			seexports.sGui:setLabelAlignment(label, "left", "center")
			seexports.sGui:setLabelFont(label, "11/Ubuntu-LI.ttf")
			local limit = getCarshopLimit(k)
			if limit and 0 <= limit then
				if guiCarshopLimitData[k] then
					seexports.sGui:setLabelText(label, "Limit: " .. guiCarshopLimitData[k] .. "/" .. limit)
				else
					seexports.sGui:setLabelText(label, "Limit: " .. limit)
				end
				guiCarshopLimitLabels[k] = label
			else
				seexports.sGui:setLabelText(label, "Nincs limit")
				seexports.sGui:setLabelColor(label, "sightlightgrey")
			end
			local bbox = seexports.sGui:createGuiElement("rectangle", pw - 8 - 56, y + h / 2 - 16, 56, 32, guiCarshopWindow)
			local icon = seexports.sGui:createGuiElement("image", pw - 8 - 56, y + h / 2 - 16, 32, 32, guiCarshopWindow)
			seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("shopping-cart", 32))
			seexports.sGui:setGuiHoverable(icon, true)
			seexports.sGui:setGuiHover(icon, "solid", "sightgreen")
			seexports.sGui:setClickEvent(icon, "selectGuiCarshopModel")
			seexports.sGui:setGuiBoundingBox(icon, bbox)
			seexports.sGui:setClickArgument(icon, k)
			local icon = seexports.sGui:createGuiElement("image", pw - 8 - 32, y + h / 2 - 16, 32, 32, guiCarshopWindow)
			seexports.sGui:setImageFile(icon, seexports.sGui:getFaIconFilename("chevron-right", 32))
			seexports.sGui:setGuiHoverable(icon, true)
			seexports.sGui:setGuiHover(icon, "solid", "sightgreen")
			seexports.sGui:setClickEvent(icon, "selectGuiCarshopModel")
			seexports.sGui:setGuiBoundingBox(icon, bbox)
			seexports.sGui:setClickArgument(icon, k)
			if n > i then
				local border = seexports.sGui:createGuiElement("hr", 8, y + h - 1, pw - 16, 2, guiCarshopWindow)
			end
		end
	end
end
local markerPoses = {
	{
		carshopX,
		carshopY,
		carshopZ,
		"carsale"
	},
	{
		715.4560546875,
		-1625.8193359375,
		2.4296875,
		"boatsale"
	},
	{
		1888.0068359375,
		-2191.2802734375,
		16.367897033691,
		"helisale"
	}
}
local carshopMarkers = {}
function createCarshopMarkers()
	for i = 1, #carshopMarkers do
		seexports.sMarkers:deleteCustomMarker(carshopMarkers[i])
	end
	carshopMarkers = {}
	for i = 1, #markerPoses do
		carshopMarkers[i] = seexports.sMarkers:createCustomMarker(markerPoses[i][1], markerPoses[i][2], markerPoses[i][3], 0, 0, "sightgreen", markerPoses[i][4])
		seexports.sMarkers:setCustomMarkerInterior(carshopMarkers[i], markerPoses[i][4], false, 1.5)
	end
end
addEventHandler("onClientResourceStop", getResourceRootElement(), function()
	for i = 1, #carshopMarkers do
		seexports.sMarkers:deleteCustomMarker(carshopMarkers[i])
	end
end)
local loaderWindow = false
function setCarshopLoader(state)
	if loaderWindow then
		seexports.sGui:deleteGuiElement(loaderWindow)
	end
	loaderWindow = nil
	seexports.sControls:toggleAllControls(not state)
	if state then
		local titleBarHeight = seexports.sGui:getTitleBarHeight()
		local ph = 120
		local pw = 250
		loaderWindow = seexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
		seexports.sGui:setWindowTitle(loaderWindow, "16/BebasNeueRegular.otf", "Autókereskedés betöltése...")
		local loadingIcon = seexports.sGui:createGuiElement("image", pw / 2 - 24, titleBarHeight + (ph - titleBarHeight) / 2 - 24, 48, 48, loaderWindow)
		seexports.sGui:setImageFile(loadingIcon, seexports.sGui:getFaIconFilename("circle-notch", 48))
		seexports.sGui:setImageSpinner(loadingIcon, true)
	end
end
addEvent("changeEnteredCustomMarker", false)
addEventHandler("changeEnteredCustomMarker", getRootElement(), function(theType)
	local inVeh = isPedInVehicle(localPlayer)
	if theType == "boatsale" and not inVeh then
		guiCarshopTable = boatshopData
		createGuiCarshop()
		if not buyingCar then
			triggerServerEvent("requestLimitsForGuiShop", localPlayer, "boat")
		end
	elseif theType == "helisale" and not inVeh then
		guiCarshopTable = helishopData
		createGuiCarshop()
		if not buyingCar then
			triggerServerEvent("requestLimitsForGuiShop", localPlayer, "heli")
		end
	else
		selectedGuiCarshopModel = false
		guiCarshopTable = nil
		deleteGuiCarshop()
		if theType == "carsale" and not inVeh then
			setCarshopLoader(true)
			setTimer(triggerServerEvent, 1000 + math.random() * 1000, 1, "carshopMarkerHit", localPlayer)
		end
	end
end)
addEvent("loadTheCarshop", true)
addEventHandler("loadTheCarshop", getRootElement(), function(carshopModelCount)
	setCarshopLoader(false)
	if not carshopCreated and carshopModelCount then
		for model in pairs(carshopData) do
			carshopData[model].modelNum = carshopModelCount[model]
		end
		createCarshop()
		carshopFadeIn = getTickCount()
		seexports.sHud:setHudEnabled(false, 500)
		showChat(false)
		seexports.sControls:toggleAllControls(false)
	end
end)
addEvent("teleportInsideCarshop", true)
addEventHandler("teleportInsideCarshop", getRootElement(), function()
	if carshopFadeIn then
		carshopFadeIn = false
		addEventHandler("onClientKey", getRootElement(), carshopKey)
		addEventHandler("onClientPreRender", getRootElement(), carshopPreRender)
		carshopEnterInterpolation = {
			getTickCount(),
			1
		}
	end
end)
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	if getElementData(localPlayer, "loggedIn") then
		triggerServerEvent("requestSSC", localPlayer)
		triggerServerEvent("requestPremiumData", localPlayer)
		triggerServerEvent("requestMoney", localPlayer)
	end
end)
addEvent("clickclipboard", true)
addEventHandler("clickclipboard", root, function(text)
	setClipboard(text)
end)