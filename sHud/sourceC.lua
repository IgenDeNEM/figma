local sightexports = {
	sPermission = false,
	sGui = false,
	sControls = false,
	sDamage = false
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
		sightlangStaticImage[0] = dxCreateTexture("files/feather.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/featherTop.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[2] = function()
	if not isElement(sightlangStaticImage[2]) then
		sightlangStaticImageToc[2] = false
		sightlangStaticImage[2] = dxCreateTexture("files/corner.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
	if not sightlangWaiterState0 then
		local res0 = getResourceFromName("sGui")
		local res1 = getResourceFromName("sPermission")
		if res0 and res1 and getResourceState(res0) == "running" and getResourceState(res1) == "running" then
			checkRestrictedWidgets()
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
local greenColor = false
local selectColor = false
local menuFont = false
local menuFontScale = false
local layoutIcon = false
local snapOnIcon = false
local snapOffIcon = false
local undoIcon = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		greenColor = sightexports.sGui:getColorCodeToColor("sightgreen")
		selectColor = sightexports.sGui:getColorCodeToColor("sightblue")
		menuFont = sightexports.sGui:getFont("11/Ubuntu-L.ttf")
		menuFontScale = sightexports.sGui:getFontScale("11/Ubuntu-L.ttf")
		layoutIcon = sightexports.sGui:getFaIconFilename("desktop", 32)
		snapOnIcon = sightexports.sGui:getFaIconFilename("lock", 32)
		snapOffIcon = sightexports.sGui:getFaIconFilename("unlock", 32)
		undoIcon = sightexports.sGui:getFaIconFilename("undo", 32)
		faTicks = sightexports.sGui:getFaTicks()
		guiRefreshed()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()) or resourceRoot, sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
	faTicks = sightexports.sGui:getFaTicks()
end)
screenX, screenY = guiGetScreenSize()
function reMap(x, in_min, in_max, out_min, out_max)
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end
responsiveMultipler = reMap(screenX, 1024, 1920, 0.75, 1)
function resp(v)
	return v * responsiveMultipler
end
function respc(v)
	return math.ceil(v * responsiveMultipler)
end
function getResponsiveMultipler()
	return responsiveMultipler
end
local hudToggle = false
local carryingBody = false
local bodyTriggerTick = 0
addEvent("setCarryBody", true)
addEventHandler("setCarryBody", getRootElement(), function(state)
	carryingBody = state
end)
local crawlStopped = false
if getElementData(localPlayer, "loggedIn") then
	hudToggle = true
end
local radarSx, radarSy = math.max(310, math.min(512, math.floor(screenX * 0.2))), math.max(150, math.min(256, math.floor(screenY * 0.22)))
local feather = 12
local screenPadding = 16
local snappingEnabled = true
local snappingSize = 8
actionBarItemSize = 52
widgets = {
	radar = {
		icon = "map-marked-alt",
		name = "Radar",
		position = {
			screenPadding,
			screenY - radarSy - screenPadding
		},
		size = {radarSx, radarSy},
		resizable = {
			{256, 512},
			{96, 256}
		},
		fontSize = 30
	},
	gps = {
		icon = "route",
		name = "GPS",
		position = {
			screenPadding,
			screenY - radarSy - screenPadding - 54
		},
		size = {radarSx, 54},
		resizable = {
			{128, 512},
			{48, 128}
		},
		fontSize = 25,
		deleted = true
	},
	speedo = {
		icon = "tachometer-alt",
		name = "Kilóméteróra",
		position = {
			screenX - screenPadding - 320,
			screenY - 320 - screenPadding
		},
		size = {320, 320},
		resizable = {
			{280, 384},
			{280, 384}
		},
		fontSize = 30
	},
	turbo = {
		icon = "tachometer-alt",
		name = "Turbó",
		position = {
			screenX - screenPadding - 320 - 200 + 32,
			screenY - 152 - screenPadding
		},
		size = {200, 152},
		resizable = {false, false},
		fontSize = 25
	},
	charData = {
		icon = "clock/regular",
		name = "Óra és karakter adatok",
		position = {
			screenX - 300 - screenPadding,
			screenPadding
		},
		size = {300, 32},
		resizable = {
			{250, 350},
			false
		},
		fontSize = 10
	},
	charDataEx = {
		icon = "user",
		name = "Karakter adatok",
		position = {
			screenX - 300 - screenPadding,
			screenPadding
		},
		size = {300, 32},
		resizable = {
			{128, 350},
			false
		},
		fontSize = 10,
		deleted = true
	},
	bars = {
		icon = "user",
		name = "Állapotjelzők",
		position = {
			screenX - 300 - screenPadding,
			screenPadding + 32
		},
		size = {300, 44},
		resizable = {
			{128, 350},
			{40, 100}
		},
		fontSize = 20
	},
	condition = {
		icon = "user",
		name = "Állapotjelző ikonok",
		position = {
			screenX - 300 - screenPadding - 102 - 8,
			screenPadding + 32
		},
		size = {102, 44},
		resizable = {
			{92, 230},
			{40, 100}
		},
		fontSize = 15
	},
	money = {
		icon = "money-bill-alt/regular",
		name = "Készpénz",
		position = {
			screenX - 150 - screenPadding,
			screenPadding + 32 + 44
		},
		size = {150, 48},
		resizable = {
			{128, 350},
			false
		},
		fontSize = 15
	},
	ssc = {
		icon = "coin/regular",
		name = "SSC",
		position = {
			screenX / 2 - 75,
			screenY / 2 - 24
		},
		size = {150, 48},
		resizable = {
			{128, 350},
			false
		},
		fontSize = 15,
		deleted = true
	},
	pp = {
		icon = "gem/regular",
		name = "PP",
		position = {
			screenX / 2 - 75,
			screenY / 2 - 24
		},
		size = {150, 48},
		resizable = {
			{128, 350},
			false
		},
		fontSize = 15,
		deleted = true
	},
	weapon = {
		icon = "crosshairs",
		name = "Fegyver",
		position = {
			screenX - 199 - screenPadding,
			screenPadding + 32 + 44 + 48
		},
		size = {199, 80},
		resizable = {false, false},
		fontSize = 20
	},
	cameramode = {
		icon = "video",
		name = "Kamera",
		position = {
			screenPadding + radarSx / 2 - 110,
			screenY - radarSy - screenPadding - 64
		},
		size = {220, 64},
		resizable = {false, false},
		fontSize = 20
	},
	zoneName = {
		icon = "compass/regular",
		name = "Zóna név",
		position = {
			screenX / 2 - 200,
			screenY - actionBarItemSize - screenPadding - 64
		},
		size = {400, 64},
		resizable = {
			{256, 512},
			false
		},
		fontSize = 15
	},
	constantZoneName = {
		icon = "compass/regular",
		name = "Állandó zóna név",
		position = {
			screenX / 2 - 200,
			screenY - actionBarItemSize - screenPadding - 64
		},
		size = {400, 64},
		resizable = {
			{256, 512},
			false
		},
		fontSize = 15,
		deleted = true
	},
	badge = {
		icon = "badge-sheriff",
		name = "Jelvény",
		position = {
			screenX / 2 - 75,
			screenY / 2 - 24
		},
		size = {150, 48},
		resizable = {
			{128, 350},
			false
		},
		fontSize = 15,
		deleted = true
	},
	respawn = {
		icon = "hospital",
		name = "Újraéledési idő",
		position = {
			screenX / 2 - 75,
			screenY / 2 - 24
		},
		size = {200, 32},
		resizable = {
			{200, 350},
			false
		},
		fontSize = 15,
		deleted = true
	},
	actionBar = {
		icon = "dice-d6",
		name = "Actionbar",
		position = {
			screenX / 2 - actionBarItemSize * 6 / 2,
			screenY - actionBarItemSize - screenPadding
		},
		size = {
			actionBarItemSize * 6,
			actionBarItemSize
		},
		resizable = {
			{
				actionBarItemSize * 1,
				actionBarItemSize * 9
			},
			{
				actionBarItemSize * 1,
				actionBarItemSize * 9
			}
		},
		fontSize = 15
	},
	gpuData = {
		icon = "memory",
		name = "Videokártya adatok",
		position = {
			screenX / 2 - 150,
			screenY / 2 - 500
		},
		size = {300, 100},
		resizable = {false, false},
		fontSize = 20,
		deleted = true
	},
	reports = {
		icon = "file-alt",
		name = "Reportok",
		position = {
			screenX / 2 - 200,
			screenY / 2 - 200
		},
		size = {150, 150},
		resizable = {false, false},
		fontSize = 20,
		deleted = true,
		restricted = "widget:useReportWidget"
	},
	fpsGraph = {
		icon = "chart-line",
		name = "FPS grafikon",
		position = {
			screenX / 2 - 256,
			screenY / 2 - 128
		},
		size = {300, 150},
		resizable = {
			{150, 1024},
			{100, 350}
		},
		fontSize = 30,
		deleted = true,
		restricted = "widget:useFpsChart"
	},
	smallFps = {
		icon = "bolt",
		name = "FPS",
		position = {
			screenX / 2,
			screenY / 2
		},
		size = {75, 32},
		resizable = {
			{75, 128},
			false
		},
		fontSize = 15,
		deleted = true
	},
	bigClock = {
		icon = "clock",
		name = "Óra (nagy)",
		position = {
			screenX / 2,
			screenY / 2
		},
		size = {75, 48},
		resizable = {
			{75, 350},
			false
		},
		fontSize = 15,
		deleted = true
	},
	clock = {
		icon = "clock",
		name = "Óra",
		position = {
			screenX / 2,
			screenY / 2
		},
		size = {75, 32},
		resizable = {
			{75, 128},
			false
		},
		fontSize = 15,
		deleted = true
	},
	debug = {
		icon = "terminal",
		name = "Debug konzol",
		position = {
			screenX / 2 - 400,
			screenY - 320 - screenPadding
		},
		size = {800, 320},
		resizable = {
			{300, screenX},
			{128, screenY}
		},
		fontSize = 30,
		deleted = true,
		restricted = "widget:useDebug"
	},
	ruler = {
		icon = "ruler",
		name = "Vonalzó",
		position = {
			screenX / 2 - 200,
			screenY / 2200
		},
		size = {400, 400},
		resizable = {
			{
				feather * 2,
				screenX
			},
			{
				feather * 2,
				screenY
			}
		},
		fontSize = 30,
		deleted = true,
		restricted = "widget:useDebug"
	},
	oocChat = {
		icon = "comment-dots",
		name = "OOC chat",
		position = {
			screenPadding,
			getChatboxLayout().chat_lines * 15 + 16 + 25
		},
		size = {radarSx, 145},
		resizable = {
			{300, screenX},
			{145, screenY}
		},
		fontSize = 30,
		deleted = false
	},
	groupRadio = {
		icon = "broadcast-tower",
		name = "Frakció rádió",
		position = {
			screenX / 2 - radarSx / 2,
			screenY / 2 - math.max(175, radarSy) / 2
		},
		size = {
			math.max(275, radarSx),
			math.max(175, radarSy)
		},
		resizable = {
			{275, 512},
			{175, 256}
		},
		fontSize = 30,
		deleted = true
	},
	walkieTalkie = {
		icon = "walkie-talkie",
		name = "Walkie-Talkie frekvencia",
		position = {
			screenX / 2 - radarSx / 2,
			screenY / 2 - math.max(175, radarSy) / 2
		},
		size = {150, 150},
		resizable = {
			{200, 200},
			false
		},
		fontSize = 13,
		deleted = true
	},
	traffiRadar = {
		icon = "camera",
		name = "Traffipax radar",
		position = {
			screenX / 2 - radarSx / 2,
			screenY / 2 - math.max(175, radarSy) / 2
		},
		size = {384, 48},
		resizable = {
			{256, 768},
			{32, 96}
		},
		fontSize = 20,
		deleted = true
	},
	siren = {
		icon = "siren",
		name = "Sziréna",
		position = {
			screenX / 2 - radarSx / 2,
			screenY / 2 - math.max(175, radarSy) / 2
		},
		size = {288, 48},
		resizable = {
			{192, 384},
			{32, 64}
		},
		fontSize = 20,
		deleted = true
	},
	mechanic = {
		icon = "car-mechanic",
		name = "Szerelő mód",
		position = {
			screenX / 2 - radarSx / 2,
			screenY / 2 - math.max(175, radarSy) / 2
		},
		size = {32, 32},
		resizable = {
			{24, 64},
			{24, 64}
		},
		fontSize = 15,
		deleted = true
	},
	rampage = {
		icon = "pills",
		name = "Drog rampage",
		position = {
			screenX / 2 - 150,
			screenY - actionBarItemSize - screenPadding - 24
		},
		size = {300, 32},
		resizable = {
			{128, 350},
			false
		},
		fontSize = 13,
		deleted = false
	},
	radio = {
		icon = "radio",
		name = "Rádió",
		position = {
			screenX - screenPadding - 320,
			screenY - 320 - screenPadding - 55
		},
		size = {320, 55},
		resizable = {
			{128, 400},
			{24, 96}
		},
		fontSize = 13,
		deleted = false
	}
}
local currentLayout = 1
local maximumLayouts = 5
for k in pairs(widgets) do
	widgets[k].originalPosition = {}
	widgets[k].originalSize = {}
	for i = 1, 2 do
		widgets[k].originalPosition[i] = math.floor(widgets[k].position[i] + 0.5)
		widgets[k].originalSize[i] = math.floor(widgets[k].size[i] + 0.5)
	end
	widgets[k].originalDeleted = widgets[k].deleted
end
local widgetDrag = false
local widgetResize = false
local cursorType = "normal"
local currentTooltip = false
local selectRectangle = false
local selectedNum = 0
local deletedNum = 0
widgetEditMode = false
local menuPoints = {
	{
		"sync-alt",
		"Alaphelyzet"
	},
	{"trash", "Törlés"}
}
local rightMenu = false
local history = {}
local currentHistory = {}
for k = 1, maximumLayouts do
	history[k] = {}
	currentHistory[k] = 0
end
function addHistory(widgets, datas)
	for k = #history[currentLayout], currentHistory[currentLayout] + 1, -1 do
		table.remove(history[currentLayout], k)
	end
	table.insert(history[currentLayout], {widgets, datas})
	if 100 < #history[currentLayout] then
		table.remove(history[currentLayout], 1)
	end
	currentHistory[currentLayout] = #history[currentLayout]
end
function moveHistory(redo)
	local index = 2
	local state = 0 < currentHistory[currentLayout]
	if redo then
		index = 3
		state = currentHistory[currentLayout] < #history[currentLayout]
	end
	if state then
		if redo then
			currentHistory[currentLayout] = currentHistory[currentLayout] + 1
		end
		local datas = history[currentLayout][currentHistory[currentLayout]]
		if datas then
			for k = 1, #datas[1] do
				for i = 1, #datas[2] do
					local data = datas[2][i]
					if data[1] == "position" then
						widgets[datas[1][k]].position[1] = data[index][1][k]
						widgets[datas[1][k]].position[2] = data[index][2][k]
						triggerEvent("hudWidgetPosition:" .. datas[1][k], localPlayer, widgets[datas[1][k]].position, true)
					elseif data[1] == "size" then
						widgets[datas[1][k]].size[1] = data[index][1][k]
						widgets[datas[1][k]].size[2] = data[index][2][k]
						triggerEvent("hudWidgetSize:" .. datas[1][k], localPlayer, widgets[datas[1][k]].size, true)
					elseif data[1] == "selected" then
						widgets[datas[1][k]].selected = data[index][k]
					elseif data[1] == "deleted" then
						widgets[datas[1][k]].deleted = data[index][k]
						triggerEvent("hudWidgetState:" .. datas[1][k], localPlayer, hudToggle and not widgets[datas[1][k]].deleted and not widgets[datas[1][k]].disabled)
					end
				end
				saveWidget(datas[1][k])
			end
		end
		if not redo then
			currentHistory[currentLayout] = currentHistory[currentLayout] - 1
		end
	end
end
function loadLayout()
	rightMenu2Size = 0
	for k in pairs(widgets) do
		if fileExists("!hud/saves/" .. currentLayout .. "/" .. k .. ".widget") then
			local fh = fileOpen("!hud/saves/" .. currentLayout .. "/" .. k .. ".widget")
			if fh then
				local data = split(fileRead(fh, fileGetSize(fh)), "\n")
				if tonumber(data[1]) then
					widgets[k].position[1] = tonumber(data[1])
				end
				if tonumber(data[2]) then
					widgets[k].position[2] = tonumber(data[2])
				end
				if tonumber(data[3]) and widgets[k].resizable[1] then
					widgets[k].size[1] = tonumber(data[3])
				end
				if tonumber(data[4]) and widgets[k].resizable[2] then
					widgets[k].size[2] = tonumber(data[4])
				end
				if tonumber(data[5]) then
					widgets[k].deleted = tonumber(data[5]) == 1
				end
				fileClose(fh)
			end
		else
			for i = 1, 2 do
				widgets[k].position[i] = widgets[k].originalPosition[i]
				widgets[k].size[i] = widgets[k].originalSize[i]
			end
			widgets[k].deleted = widgets[k].originalDeleted
		end
		for i = 1, 2 do
			widgets[k].position[i] = math.floor(widgets[k].position[i] + 0.5)
			if widgets[k].resizable[i] then
				widgets[k].size[i] = math.max(math.min(math.floor(widgets[k].size[i] + 0.5), widgets[k].resizable[i][2]), widgets[k].resizable[i][1])
			end
		end
		triggerEvent("hudWidgetState:" .. k, localPlayer, (hudToggle or k == "debug") and not widgets[k].deleted and not widgets[k].disabled)
		triggerEvent("hudWidgetPosition:" .. k, localPlayer, widgets[k].position, true)
		triggerEvent("hudWidgetSize:" .. k, localPlayer, widgets[k].size, true)
		if widgets[k].deleted and widgets[k].smallTextWidth > rightMenu2Size then
			rightMenu2Size = widgets[k].smallTextWidth
		end
	end
end
addEvent("requestWidgetDatas", true)
addEventHandler("requestWidgetDatas", getRootElement(), function(k)
	if widgets[k] then
		triggerEvent("hudWidgetState:" .. k, localPlayer, (hudToggle or k == "debug") and not widgets[k].deleted and not widgets[k].disabled)
		triggerEvent("hudWidgetPosition:" .. k, localPlayer, widgets[k].position, true)
		triggerEvent("hudWidgetSize:" .. k, localPlayer, widgets[k].size, true)
	end
end)
function saveWidget(k)
	if fileExists("!hud/saves/" .. currentLayout .. "/" .. k .. ".widget") then
		fileDelete("!hud/saves/" .. currentLayout .. "/" .. k .. ".widget")
	end
	local fh = fileCreate("!hud/saves/" .. currentLayout .. "/" .. k .. ".widget")
	if fh then
		fileWrite(fh, widgets[k].position[1] .. "\n")
		fileWrite(fh, widgets[k].position[2] .. "\n")
		fileWrite(fh, widgets[k].size[1] .. "\n")
		fileWrite(fh, widgets[k].size[2] .. "\n")
		fileWrite(fh, (widgets[k].deleted and 1 or 0) .. "\n")
		fileClose(fh)
	end
end
function saveCurrentLayout()
	if fileExists("!hud/saves/currentLayout_sight.hud") then
		fileDelete("!hud/saves/currentLayout_sight.hud")
	end
	local fh = fileCreate("!hud/saves/currentLayout_sight.hud")
	if fh then
		fileWrite(fh, tostring(currentLayout))
		fileClose(fh)
	end
end
function saveSnapping()
	if fileExists("!hud/saves/snappingEnabled.hud") then
		fileDelete("!hud/saves/snappingEnabled.hud")
	end
	local fh = fileCreate("!hud/saves/snappingEnabled.hud")
	if fh then
		fileWrite(fh, tostring(snappingEnabled and 1 or 0))
		fileClose(fh)
	end
end
function checkRestrictedWidgets()
	for k in pairs(widgets) do
		if widgets[k].restricted then
			local tmp = not sightexports.sPermission:hasPermission(localPlayer, widgets[k].restricted)
			if widgets[k].disabled ~= tmp then
				widgets[k].disabled = tmp
				if not widgets[k].deleted then
					triggerEvent("hudWidgetState:" .. k, localPlayer, (hudToggle or k == "debug") and not widgets[k].deleted and not widgets[k].disabled)
				end
			end
		end
	end
end
function setWidgetGuiData(k)
	widgets[k].widgetFont = sightexports.sGui:getFont(widgets[k].fontSize .. "/BebasNeueRegular.otf")
	widgets[k].widgetFontH = math.ceil(sightexports.sGui:getFontHeight(widgets[k].fontSize .. "/BebasNeueRegular.otf"))
	widgets[k].widgetFontScale = sightexports.sGui:getFontScale(widgets[k].fontSize .. "/BebasNeueRegular.otf")
	local icon = split(widgets[k].icon, "/")
	widgets[k].smallIcon = sightexports.sGui:getFaIconFilename(icon[1], menuFontH, icon[2])
	widgets[k].iconImage = sightexports.sGui:getFaIconFilename(icon[1], widgets[k].widgetFontH, icon[2])
	widgets[k].textWidth = sightexports.sGui:getTextWidthFont(widgets[k].name, widgets[k].widgetFont) + widgets[k].widgetFontH
	widgets[k].smallTextWidth = sightexports.sGui:getTextWidthFont(widgets[k].name, "11/Ubuntu-L.ttf") + menuFontH + 12
end
local firstLayoutLoaded = false
function guiRefreshed()
	menuFontH = sightexports.sGui:getFontHeight("11/Ubuntu-L.ttf")
	noItemIcon = sightexports.sGui:getFaIconFilename("puzzle-piece", menuFontH)
	bcgColor = bitReplace(sightexports.sGui:getColorCodeToColor("sightgrey1"), 174, 24, 8)
	rightMenuSize = 0
	rightMenu2Size = 0
	rightMenu3Size = sightexports.sGui:getTextWidthFont("Nincs törölt HUD elem ", "11/Ubuntu-L.ttf") + menuFontH
	for k in pairs(widgets) do
		setWidgetGuiData(k)
	end
	for k, data in pairs(widgets) do
		if data.deleted and not data.disabled and data.smallTextWidth > rightMenu2Size then
			rightMenu2Size = data.smallTextWidth
		end
	end
	for k = 1, #menuPoints do
		local icon = split(menuPoints[k][1], "/")
		menuPoints[k][3] = sightexports.sGui:getFaIconFilename(icon[1], menuFontH, icon[2])
		local width = sightexports.sGui:getTextWidthFont(menuPoints[k][2], "11/Ubuntu-L.ttf") + menuFontH + 12
		if width > rightMenuSize then
			rightMenuSize = width
		end
	end
	if not firstLayoutLoaded then
		firstLayoutLoaded = true
		loadLayout()
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()) or resourceRoot, function(res)
	if fileExists("!hud/saves/currentLayout_sight.hud") then
		local fh = fileOpen("!hud/saves/currentLayout_sight.hud")
		if fh then
			local data = tonumber(fileRead(fh, fileGetSize(fh)))
			if data and 1 <= data and data <= maximumLayouts then
				currentLayout = data
				loadLayout()
			end
			fileClose(fh)
		end
	end
	if fileExists("!hud/saves/snappingEnabled.hud") then
		local fh = fileOpen("!hud/saves/snappingEnabled.hud")
		if fh then
			local data = tonumber(fileRead(fh, fileGetSize(fh))) or 1
			snappingEnabled = data == 1
			fileClose(fh)
		end
	end
end)
addEventHandler("onClientElementDataChange", localPlayer, function(data)
	if data == "loggedIn" or data == "acc.adminLevel" or data == "acc.guardLevel" or data == "acc.helperLevel" then
		checkRestrictedWidgets()
	end
end)
function getWidgetEditMode()
	return widgetEditMode
end
addEventHandler("onClientKey", getRootElement(), function(key, por)
	if hudToggle then
		if por and key == "F1" then
			widgetEditMode = not widgetEditMode
			widgetDrag = false
			widgetResize = false
			selectRectangle = false
			if cursorType ~= "normal" then
				cursorType = "normal"
				sightexports.sGui:setCursorType(cursorType)
			end
			showCursor(widgetEditMode)
			if widgetEditMode then
				addEventHandler("onClientRender", getRootElement(), renderWidgetEdit, true, "low")
				addEventHandler("onClientClick", getRootElement(), clickWidgetEdit)
				checkRestrictedWidgets()
			else
				removeEventHandler("onClientRender", getRootElement(), renderWidgetEdit)
				removeEventHandler("onClientClick", getRootElement(), clickWidgetEdit)
			end
		end
		if widgetEditMode then
			cancelEvent()
		end
	end
end, true, "high+999999")
function clickWidgetEdit(button, state, cx, cy)
	if state == "up" then
		if widgetDrag then
			local saveToHistory = true
			local newDatas = {
				{},
				{}
			}
			for k = 1, #widgetDrag[1] do
				if widgets[widgetDrag[1][k]].position[1] == widgetDrag[4][k] and widgets[widgetDrag[1][k]].position[2] == widgetDrag[5][k] then
					saveToHistory = false
				end
				widgets[widgetDrag[1][k]].position[1] = math.floor(widgets[widgetDrag[1][k]].position[1] + 0.5)
				widgets[widgetDrag[1][k]].position[2] = math.floor(widgets[widgetDrag[1][k]].position[2] + 0.5)
				newDatas[1][k] = widgets[widgetDrag[1][k]].position[1]
				newDatas[2][k] = widgets[widgetDrag[1][k]].position[2]
				if widgets[widgetDrag[1][k]].position[1] ~= widgetDrag[4][k] or widgets[widgetDrag[1][k]].position[2] ~= widgetDrag[5][k] then
					triggerEvent("hudWidgetPosition:" .. widgetDrag[1][k], localPlayer, widgets[widgetDrag[1][k]].position, true)
					saveWidget(widgetDrag[1][k])
				end
			end
			if saveToHistory then
				addHistory(widgetDrag[1], {
					{
						"position",
						{
							widgetDrag[4],
							widgetDrag[5]
						},
						newDatas
					}
				})
			end
		end
		widgetDrag = false
		if widgetResize then
			widgets[widgetResize[1]].position[1] = math.floor(widgets[widgetResize[1]].position[1] + 0.5)
			widgets[widgetResize[1]].position[2] = math.floor(widgets[widgetResize[1]].position[2] + 0.5)
			widgets[widgetResize[1]].size[1] = math.floor(widgets[widgetResize[1]].size[1] + 0.5)
			widgets[widgetResize[1]].size[2] = math.floor(widgets[widgetResize[1]].size[2] + 0.5)
			if widgets[widgetResize[1]].position[1] ~= widgetResize[7] or widgets[widgetResize[1]].position[2] ~= widgetResize[8] then
				triggerEvent("hudWidgetPosition:" .. widgetResize[1], localPlayer, widgets[widgetResize[1]].position, true)
			end
			if widgets[widgetResize[1]].size[1] ~= widgetResize[4] or widgets[widgetResize[1]].size[2] ~= widgetResize[6] then
				triggerEvent("hudWidgetSize:" .. widgetResize[1], localPlayer, widgets[widgetResize[1]].size, true)
				saveWidget(widgetResize[1])
				addHistory({
					widgetResize[1]
				}, {
					{
						"position",
						{
							{
								widgetResize[7]
							},
							{
								widgetResize[8]
							}
						},
						{
							{
								widgets[widgetResize[1]].position[1]
							},
							{
								widgets[widgetResize[1]].position[2]
							}
						}
					},
					{
						"size",
						{
							{
								widgetResize[4]
							},
							{
								widgetResize[6]
							}
						},
						{
							{
								widgets[widgetResize[1]].size[1]
							},
							{
								widgets[widgetResize[1]].size[2]
							}
						}
					}
				})
			end
		end
		widgetResize = false
		if selectRectangle then
			local x, y = math.min(selectRectangle[1], cx), math.min(selectRectangle[2], cy)
			local sx, sy = math.max(selectRectangle[1], cx), math.max(selectRectangle[2], cy)
			local widgetNames = {}
			local oldSelected = {}
			local newSelected = {}
			for k, data in pairs(widgets) do
				if not widgets[k].deleted and not widgets[k].disabled and not (sx < data.position[1]) and not (x > data.position[1] + data.size[1]) and not (sy < data.position[2]) and not (y > data.position[2] + data.size[2]) then
					local newState = not getKeyState("lalt")
					if widgets[k].selected ~= newState then
						table.insert(widgetNames, k)
						table.insert(oldSelected, widgets[k].selected)
						table.insert(newSelected, newState)
						widgets[k].selected = newState
					end
				elseif not getKeyState("lshift") and not getKeyState("lalt") and widgets[k].selected then
					table.insert(widgetNames, k)
					table.insert(oldSelected, widgets[k].selected)
					table.insert(newSelected, false)
					widgets[k].selected = false
				end
			end
			if 0 < #widgetNames then
				addHistory(widgetNames, {
					{
						"selected",
						oldSelected,
						newSelected
					}
				})
			end
		end
		selectRectangle = false
	elseif state == "down" then
		if rightMenu then
			if button == "left" then
				if #rightMenu == 3 then
					for k = 1, #menuPoints do
						if cx >= rightMenu[2] and cy >= rightMenu[3] + (k - 1) * menuFontH and cx <= rightMenu[2] + rightMenuSize and cy <= rightMenu[3] + k * menuFontH then
							if k == 1 then
								local oldPoses = {
									{},
									{}
								}
								local oldSizes = {
									{},
									{}
								}
								local newPoses = {
									{},
									{}
								}
								local newSizes = {
									{},
									{}
								}
								for i = 1, #rightMenu[1] do
									for j = 1, 2 do
										table.insert(oldPoses[j], widgets[rightMenu[1][i]].position[j])
										table.insert(oldSizes[j], widgets[rightMenu[1][i]].size[j])
										table.insert(newPoses[j], widgets[rightMenu[1][i]].originalPosition[j])
										table.insert(newSizes[j], widgets[rightMenu[1][i]].originalSize[j])
										widgets[rightMenu[1][i]].position[j] = widgets[rightMenu[1][i]].originalPosition[j]
										widgets[rightMenu[1][i]].size[j] = widgets[rightMenu[1][i]].originalSize[j]
									end
									triggerEvent("hudWidgetPosition:" .. rightMenu[1][i], localPlayer, widgets[rightMenu[1][i]].position, true)
									triggerEvent("hudWidgetSize:" .. rightMenu[1][i], localPlayer, widgets[rightMenu[1][i]].size, true)
									saveWidget(rightMenu[1][i])
								end
								addHistory(rightMenu[1], {
									{
										"position",
										oldPoses,
										newPoses
									},
									{
										"size",
										oldSizes,
										newSizes
									}
								})
							elseif k == 2 then
								local oldDeleted = {}
								local newDeleted = {}
								local oldSelected = {}
								local newSelected = {}
								for i = 1, #rightMenu[1] do
									table.insert(oldDeleted, widgets[rightMenu[1][i]].deleted)
									table.insert(newDeleted, true)
									table.insert(oldSelected, widgets[rightMenu[1][i]].selected)
									table.insert(newSelected, false)
									widgets[rightMenu[1][i]].deleted = true
									widgets[rightMenu[1][i]].selected = false
									triggerEvent("hudWidgetState:" .. rightMenu[1][i], localPlayer, not widgets[rightMenu[1][i]].deleted)
									saveWidget(rightMenu[1][i])
								end
								addHistory(rightMenu[1], {
									{
										"deleted",
										oldDeleted,
										newDeleted
									},
									{
										"selected",
										oldSelected,
										newSelected
									}
								})
								rightMenu2Size = 0
								for k, data in pairs(widgets) do
									if data.deleted and not data.disabled and data.smallTextWidth > rightMenu2Size then
										rightMenu2Size = data.smallTextWidth
									end
								end
							end
							rightMenu = false
							return
						end
					end
				elseif #rightMenu == 4 then
					if cx >= rightMenu[3] and cy >= rightMenu[4] and cx <= rightMenu[3] + rightMenuSize and cy <= rightMenu[4] + menuFontH then
						local oldPoses = {
							{},
							{}
						}
						local oldSizes = {
							{},
							{}
						}
						local newPoses = {
							{},
							{}
						}
						local newSizes = {
							{},
							{}
						}
						local oldDeleted = {}
						local newDeleted = {}
						local oldSelected = {}
						local newSelected = {}
						local widgetNames = {}
						for k in pairs(widgets) do
							table.insert(widgetNames, k)
							for j = 1, 2 do
								table.insert(oldPoses[j], widgets[k].position[j])
								table.insert(oldSizes[j], widgets[k].size[j])
							end
							for j = 1, 2 do
								table.insert(newPoses[j], widgets[k].originalPosition[j])
								table.insert(newSizes[j], widgets[k].originalSize[j])
							end
							table.insert(oldDeleted, widgets[k].deleted or false)
							table.insert(newDeleted, widgets[k].originalDeleted or false)
							table.insert(oldSelected, widgets[k].selected or false)
							table.insert(newSelected, false)
							widgets[k].selected = false
						end
						addHistory(widgetNames, {
							{
								"position",
								oldPoses,
								newPoses
							},
							{
								"size",
								oldSizes,
								newSizes
							},
							{
								"deleted",
								oldDeleted,
								newDeleted
							},
							{
								"selected",
								oldSelected,
								newSelected
							}
						})
						for k in pairs(widgets) do
							if fileExists("!hud/saves/" .. currentLayout .. "/" .. k .. ".widget") then
								fileDelete("!hud/saves/" .. currentLayout .. "/" .. k .. ".widget")
							end
						end
						loadLayout()
						rightMenu = false
						return
					end
				elseif 1 <= deletedNum then
					local x, y = rightMenu[1], rightMenu[2]
					for k, data in pairs(widgets) do
						if data.deleted and not data.disabled then
							if cx >= x and cy >= y and cx <= x + rightMenu2Size and cy <= y + menuFontH then
								local newX, newY = math.floor(cx - widgets[k].size[1] / 2 + 0.5), math.floor(cy - widgets[k].size[2] / 2 + 0.5)
								addHistory({k}, {
									{
										"deleted",
										{true},
										{false}
									},
									{
										"position",
										{
											{
												widgets[k].position[1]
											},
											{
												widgets[k].position[2]
											}
										},
										{
											{newX},
											{newY}
										}
									}
								})
								widgets[k].position[1] = newX
								widgets[k].position[2] = newY
								widgets[k].deleted = false
								triggerEvent("hudWidgetState:" .. k, localPlayer, not widgets[k].deleted)
								triggerEvent("hudWidgetPosition:" .. k, localPlayer, widgets[k].position, true)
								saveWidget(k)
								rightMenu2Size = 0
								for k, data in pairs(widgets) do
									if data.deleted and not data.disabled and data.smallTextWidth > rightMenu2Size then
										rightMenu2Size = data.smallTextWidth
									end
								end
								rightMenu = false
								return
							end
							y = y + menuFontH
						end
					end
				end
			elseif #rightMenu == 3 then
				if cx >= rightMenu[2] and cy >= rightMenu[3] and cx <= rightMenu[2] + rightMenuSize and cy <= rightMenu[3] + #menuPoints * menuFontH then
					rightMenu = false
					return
				end
			elseif #rightMenu == 4 then
				if cx >= rightMenu[3] and cy >= rightMenu[4] and cx <= rightMenu[3] + rightMenuSize and cy <= rightMenu[4] + menuFontH then
					rightMenu = false
					return
				end
			elseif 1 <= deletedNum then
				local x, y = rightMenu[1], rightMenu[2]
				for k, data in pairs(widgets) do
					if data.deleted then
						if cx >= x and cy >= y and cx <= x + rightMenu2Size and cy <= y + menuFontH then
							rightMenu = false
							return
						end
						y = y + menuFontH
					end
				end
			end
		end
		rightMenu = false
		local x = screenX / 2 - 48 * (maximumLayouts + 3) / 2
		for k = 1, maximumLayouts + 3 do
			if cx >= x + (k - 1) * 48 and 0 <= cy and cx <= x + k * 48 and cy <= 48 then
				if k == maximumLayouts + 1 then
					snappingEnabled = not snappingEnabled
					saveSnapping()
				elseif k == maximumLayouts + 2 then
					moveHistory(false)
				elseif k == maximumLayouts + 3 then
					moveHistory(true)
				else
					if currentLayout ~= k then
						currentLayout = k
						saveCurrentLayout()
						loadLayout()
					end
					if button == "right" then
						rightMenu = {
							"layout",
							k,
							cx,
							cy
						}
					end
				end
				return
			end
		end
		local removeSelection = not getKeyState("lshift") and not getKeyState("lalt")
		if removeSelection and not selectRectangle then
			for k, data in pairs(widgets) do
				if not widgets[k].deleted and not widgets[k].disabled then
					local x, y, sx, sy = data.position[1], data.position[2], data.size[1], data.size[2]
					if 0 < selectedNum and data.selected then
						if cx >= x and cy >= y and cx <= x + sx and cy <= y + sy then
							removeSelection = false
						end
						if button == "right" then
							if not rightMenu then
								rightMenu = {
									{k},
									cx,
									cy
								}
							else
								table.insert(rightMenu[1], k)
							end
						elseif not widgetDrag then
							widgetDrag = {
								{k},
								cx,
								cy,
								{x},
								{y}
							}
						else
							table.insert(widgetDrag[1], k)
							table.insert(widgetDrag[4], x)
							table.insert(widgetDrag[5], y)
						end
					end
				end
			end
		end
		if removeSelection and 0 < selectedNum then
			local widgetNames = {}
			local oldSelected = {}
			local newSelected = {}
			for i in pairs(widgets) do
				if widgets[i].selected then
					table.insert(widgetNames, i)
					table.insert(oldSelected, widgets[i].selected)
					table.insert(newSelected, false)
					widgets[i].selected = false
				end
			end
			if 0 < #widgetNames then
				addHistory(widgetNames, {
					{
						"selected",
						oldSelected,
						newSelected
					}
				})
			end
			widgetDrag = false
			rightMenu = false
		end
		if not selectRectangle and not getKeyState("lshift") and not getKeyState("lalt") then
			for k, data in pairs(widgets) do
				if not widgets[k].deleted and not widgets[k].disabled then
					local x, y, sx, sy = data.position[1], data.position[2], data.size[1], data.size[2]
					if (selectedNum == 0 or removeSelection) and not widgetDrag and cx >= x and cy >= y and cx <= x + sx and cy <= y + sy then
						if button == "right" then
							rightMenu = {
								{k},
								cx,
								cy
							}
						elseif 0 < selectedNum and getKeyState("lalt") and data.selected then
							addHistory({k}, {
								{
									"selected",
									{
										data.selected
									},
									{false}
								}
							})
							widget[k].selected = false
						elseif getKeyState("lshift") and not data.selected then
							addHistory({k}, {
								{
									"selected",
									{
										data.selected
									},
									{true}
								}
							})
							widget[k].selected = true
						elseif data.resizable[1] and data.resizable[2] and cx >= x and cy >= y and cx <= x + feather and cy <= y + feather then
							widgetResize = {
								k,
								1,
								cx,
								sx,
								cy,
								sy,
								x,
								y
							}
						elseif data.resizable[1] and data.resizable[2] and cx >= x and cy >= y + sy - feather and cx <= x + feather and cy <= y + sy then
							widgetResize = {
								k,
								2,
								cx,
								sx,
								cy,
								sy,
								x,
								y
							}
						elseif data.resizable[1] and data.resizable[2] and cx >= x + sx - feather and cy >= y and cx <= x + sx + feather and cy <= y + feather then
							widgetResize = {
								k,
								3,
								cx,
								sx,
								cy,
								sy,
								x,
								y
							}
						elseif data.resizable[1] and data.resizable[2] and cx >= x + sx - feather and cy >= y + sy - feather and cx <= x + sx and cy <= y + sy then
							widgetResize = {
								k,
								4,
								cx,
								sx,
								cy,
								sy,
								x,
								y
							}
						elseif data.resizable[1] and cx >= x and cx <= x + feather then
							widgetResize = {
								k,
								5,
								cx,
								sx,
								cy,
								sy,
								x,
								y
							}
						elseif data.resizable[1] and cx >= x + sx - feather and cx <= x + sx then
							widgetResize = {
								k,
								6,
								cx,
								sx,
								cy,
								sy,
								x,
								y
							}
						elseif data.resizable[2] and cy >= y and cy <= y + feather then
							widgetResize = {
								k,
								7,
								cx,
								sx,
								cy,
								sy,
								x,
								y
							}
						elseif data.resizable[2] and cy >= y + sy - feather and cy <= y + sy then
							widgetResize = {
								k,
								8,
								cx,
								sx,
								cy,
								sy,
								x,
								y
							}
						else
							widgetDrag = {
								{k},
								cx,
								cy,
								{x},
								{y}
							}
						end
					end
				end
			end
		end
		if widgetDrag then
			refresSnapPoints()
		end
		if not widgetDrag and not widgetResize and not rightMenu then
			if button == "right" then
				checkRestrictedWidgets()
				rightMenu = {cx, cy}
			elseif not selectRectangle then
				selectRectangle = {cx, cy}
			end
		end
	end
end
local snapPoints = {
	{
		screenPadding,
		screenX / 2,
		screenX - screenPadding
	},
	{
		screenPadding,
		screenY / 2,
		screenY - screenPadding
	}
}
function refresSnapPoints()
	snapPoints = {
		{
			screenPadding,
			screenX / 2,
			screenX - screenPadding
		},
		{
			screenPadding,
			screenY / 2,
			screenY - screenPadding
		},
		{
			false,
			true,
			false
		},
		{
			"screen",
			"screen",
			"screen"
		}
	}
	local tmp = {}
	if widgetDrag then
		for k = 1, #widgetDrag[1] do
			tmp[widgetDrag[1][k]] = true
		end
	end
	for k, data in pairs(widgets) do
		if not data.deleted and not data.disabled and not tmp[k] and (not widgetResize or widgetResize[1] ~= k) then
			for j = 0, 2 do
				table.insert(snapPoints[1], data.position[1] + data.size[1] / 2 * j)
				table.insert(snapPoints[2], data.position[2] + data.size[2] / 2 * j)
				table.insert(snapPoints[3], j == 1)
				table.insert(snapPoints[4], k)
			end
		end
	end
end
function renderWidgetEdit()
	local cx, cy = getCursorPosition()
	if cx then
		cx = cx * screenX
		cy = cy * screenY
	end
	local targetCursorType = "normal"
	local targetTooltip = false
	local x = screenX / 2 - 48 * (maximumLayouts + 3) / 2
	dxDrawRectangle(x, 0, 48 * (maximumLayouts + 3), 48, bcgColor)
	for k = 1, maximumLayouts + 3 do
		if k == maximumLayouts + 1 then
			local color = tocolor(255, 255, 255)
			if cx >= x + (k - 1) * 48 and 0 <= cy and cx <= x + k * 48 and cy <= 48 then
				color = greenColor
				targetCursorType = "link"
				targetTooltip = "Pozíció automatikus igazítás " .. (snappingEnabled and "kikapcsolása" or "bekapcsolása")
			end
			dxDrawImage(x + (k - 1) * 48 + 8, 8, 32, 32, ":sGui/" .. (snappingEnabled and snapOnIcon or snapOffIcon) .. (faTicks[snappingEnabled and snapOnIcon or snapOffIcon] or ""), 0, 0, 0, color)
		elseif k == maximumLayouts + 2 then
			local color = tocolor(255, 255, 255)
			if 0 < currentHistory[currentLayout] then
				if cx >= x + (k - 1) * 48 and 0 <= cy and cx <= x + k * 48 and cy <= 48 then
					color = greenColor
					targetCursorType = "link"
					targetTooltip = "Visszalépés"
				end
			else
				color = tocolor(255, 255, 255, 100)
			end
			dxDrawImage(x + (k - 1) * 48 + 8, 8, 32, 32, ":sGui/" .. undoIcon .. (faTicks[undoIcon] or ""), 0, 0, 0, color)
		elseif k == maximumLayouts + 3 then
			local color = tocolor(255, 255, 255)
			if currentHistory[currentLayout] < #history[currentLayout] then
				if cx >= x + (k - 1) * 48 and 0 <= cy and cx <= x + k * 48 and cy <= 48 then
					color = greenColor
					targetCursorType = "link"
					targetTooltip = "Előrelépés"
				end
			else
				color = tocolor(255, 255, 255, 100)
			end
			dxDrawImage(x + (k - 1) * 48 + 8 + 32, 8, -32, 32, ":sGui/" .. undoIcon .. (faTicks[undoIcon] or ""), 0, 0, 0, color)
		else
			if currentLayout == k then
				dxDrawRectangle(x + (k - 1) * 48, 0, 48, 48, greenColor)
			elseif cx >= x + (k - 1) * 48 and 0 <= cy and cx <= x + k * 48 and cy <= 48 then
				dxDrawRectangle(x + (k - 1) * 48, 0, 48, 48, bitReplace(greenColor, 174, 24, 8))
				targetCursorType = "link"
				targetTooltip = "Elrendezés " .. k
			end
			dxDrawImage(x + (k - 1) * 48 + 8, 8, 32, 32, ":sGui/" .. layoutIcon .. (faTicks[layoutIcon] or ""))
		end
	end
	if widgetDrag then
		if cx then
			local od = {
				cx - widgetDrag[2],
				cy - widgetDrag[3]
			}
			local d = {
				od[1],
				od[2]
			}
			local snapAxis = {true, true}
			if getKeyState("lctrl") then
				if math.abs(math.floor(od[1] / feather + 0.5)) > math.abs(math.floor(od[2] / feather + 0.5)) then
					d = {
						od[1],
						0
					}
					snapAxis = {true, false}
				else
					d = {
						0,
						od[2]
					}
					snapAxis = {false, true}
				end
			end
			if snappingEnabled then
				for l = 1, 2 do
					if snapAxis[l] then
						local snapped = false
						local x = false
						local xMax = false
						for k = 1, #widgetDrag[1] do
							local pos = d[l] + widgetDrag[4 + l - 1][k]
							if not x or x > pos then
								x = pos
							end
							pos = pos + widgets[widgetDrag[1][k]].size[l]
							if not xMax or xMax < pos then
								xMax = pos
							end
						end
						local size = xMax - x
						for i = 1, #snapPoints[l] do
							if snapped then
								break
							end
							local poses = {
								1,
								0,
								2
							}
							for k = 1, #poses do
								local j = poses[k]
								if snapped then
									break
								end
								if x + size * j / 2 <= snapPoints[l][i] + snappingSize and x + size * j / 2 >= snapPoints[l][i] - snappingSize and j == 1 == snapPoints[3][i] then
									d[l] = snapPoints[l][i] - (x - od[l]) - size * j / 2
									snapped = true
									if l == 1 then
										dxDrawLine(snapPoints[l][i], 0, snapPoints[l][i], screenY, selectColor, snapPoints[4][i] == "screen" and 2 or 1)
									else
										dxDrawLine(0, snapPoints[l][i], screenX, snapPoints[l][i], selectColor, snapPoints[4][i] == "screen" and 2 or 1)
									end
								end
							end
						end
					end
				end
			end
			local dx, dy = d[1], d[2]
			for k = 1, #widgetDrag[1] do
				widgets[widgetDrag[1][k]].position[1] = math.floor(dx + widgetDrag[4][k] + 0.5)
				widgets[widgetDrag[1][k]].position[2] = math.floor(dy + widgetDrag[5][k] + 0.5)
				triggerEvent("hudWidgetPosition:" .. widgetDrag[1][k], localPlayer, widgets[widgetDrag[1][k]].position, false)
			end
			targetCursorType = "move"
		else
			widgetDrag = false
		end
	elseif widgetResize then
		if cx then
			local d = {0, 0}
			if widgetResize[2] == 1 or widgetResize[2] == 2 or widgetResize[2] == 5 then
				d[1] = widgetResize[3] - cx
			elseif widgetResize[2] == 3 or widgetResize[2] == 4 or widgetResize[2] == 6 then
				d[1] = cx - widgetResize[3]
			end
			if widgetResize[2] == 1 or widgetResize[2] == 3 or widgetResize[2] == 7 then
				d[2] = widgetResize[5] - cy
			elseif widgetResize[2] == 2 or widgetResize[2] == 4 or widgetResize[2] == 8 then
				d[2] = cy - widgetResize[5]
			end
			local newPos = {
				widgets[widgetResize[1]].position[1],
				widgets[widgetResize[1]].position[2]
			}
			local newSize = {
				widgets[widgetResize[1]].size[1],
				widgets[widgetResize[1]].size[2]
			}
			if widgetResize[2] == 1 or widgetResize[2] == 2 or widgetResize[2] == 5 or widgetResize[2] == 3 or widgetResize[2] == 4 or widgetResize[2] == 6 then
				newSize[1] = math.max(math.min(d[1] + widgetResize[4], widgets[widgetResize[1]].resizable[1][2]), widgets[widgetResize[1]].resizable[1][1])
			end
			if widgetResize[2] == 1 or widgetResize[2] == 2 or widgetResize[2] == 5 then
				newPos[1] = widgetResize[7] + widgetResize[4] - newSize[1]
			end
			if widgetResize[2] == 1 or widgetResize[2] == 3 or widgetResize[2] == 7 or widgetResize[2] == 2 or widgetResize[2] == 4 or widgetResize[2] == 8 then
				newSize[2] = math.max(math.min(d[2] + widgetResize[6], widgets[widgetResize[1]].resizable[2][2]), widgets[widgetResize[1]].resizable[2][1])
			end
			if widgetResize[2] == 1 or widgetResize[2] == 3 or widgetResize[2] == 7 then
				newPos[2] = widgetResize[8] + widgetResize[6] - newSize[2]
			end
			if widgetResize[2] == 1 or widgetResize[2] == 4 then
				targetCursorType = "resize1"
			elseif widgetResize[2] == 2 or widgetResize[2] == 3 then
				targetCursorType = "resize2"
			elseif widgetResize[2] == 5 or widgetResize[2] == 6 then
				targetCursorType = "resize4"
			elseif widgetResize[2] == 7 or widgetResize[2] == 8 then
				targetCursorType = "resize3"
			end
			if newPos[1] ~= widgets[widgetResize[1]].position[1] or newPos[2] ~= widgets[widgetResize[1]].position[2] then
				widgets[widgetResize[1]].position[1] = math.floor(newPos[1] + 0.5)
				widgets[widgetResize[1]].position[2] = math.floor(newPos[2] + 0.5)
				triggerEvent("hudWidgetPosition:" .. widgetResize[1], localPlayer, widgets[widgetResize[1]].position, false)
			end
			if widgets[widgetResize[1]].resizable[1] then
				widgets[widgetResize[1]].size[1] = math.floor(newSize[1] + 0.5)
			end
			if widgets[widgetResize[1]].resizable[2] then
				widgets[widgetResize[1]].size[2] = math.floor(newSize[2] + 0.5)
			end
			triggerEvent("hudWidgetSize:" .. widgetResize[1], localPlayer, widgets[widgetResize[1]].size, false)
		else
			widgetResize = false
		end
	end
	selectedNum = 0
	deletedNum = 0
	for k, data in pairs(widgets) do
		if not data.disabled then
			if data.deleted then
				deletedNum = deletedNum + 1
			elseif data.selected then
				selectedNum = selectedNum + 1
			end
		end
	end
	for k, data in pairs(widgets) do
		if not widgets[k].deleted and not widgets[k].disabled then
			local x, y, sx, sy = data.position[1], data.position[2], data.size[1], data.size[2]
			local color = bcgColor
			local textColor = greenColor
			if widgets[k].selected then
				color = bitReplace(greenColor, 174, 24, 8)
				textColor = bitReplace(bcgColor, 174, 24, 8)
			end
			sightlangStaticImageUsed[0] = true
			if sightlangStaticImageToc[0] then
				processsightlangStaticImage[0]()
			end
			dxDrawImage(x, y + feather, feather, sy - feather * 2, sightlangStaticImage[0], 180, 0, 0, color)
			sightlangStaticImageUsed[0] = true
			if sightlangStaticImageToc[0] then
				processsightlangStaticImage[0]()
			end
			dxDrawImage(x + sx - feather, y + feather, feather, sy - feather * 2, sightlangStaticImage[0], 0, 0, 0, color)
			sightlangStaticImageUsed[1] = true
			if sightlangStaticImageToc[1] then
				processsightlangStaticImage[1]()
			end
			dxDrawImage(x + feather, y, sx - feather * 2, feather, sightlangStaticImage[1], 180, 0, 0, color)
			sightlangStaticImageUsed[1] = true
			if sightlangStaticImageToc[1] then
				processsightlangStaticImage[1]()
			end
			dxDrawImage(x + feather, y + sy - feather, sx - feather * 2, feather, sightlangStaticImage[1], 0, 0, 0, color)
			sightlangStaticImageUsed[2] = true
			if sightlangStaticImageToc[2] then
				processsightlangStaticImage[2]()
			end
			dxDrawImage(x, y, feather, feather, sightlangStaticImage[2], 270, 0, 0, color)
			sightlangStaticImageUsed[2] = true
			if sightlangStaticImageToc[2] then
				processsightlangStaticImage[2]()
			end
			dxDrawImage(x + sx - feather, y, feather, feather, sightlangStaticImage[2], 0, 0, 0, color)
			sightlangStaticImageUsed[2] = true
			if sightlangStaticImageToc[2] then
				processsightlangStaticImage[2]()
			end
			dxDrawImage(x, y + sy - feather, feather, feather, sightlangStaticImage[2], 180, 0, 0, color)
			sightlangStaticImageUsed[2] = true
			if sightlangStaticImageToc[2] then
				processsightlangStaticImage[2]()
			end
			dxDrawImage(x + sx - feather, y + sy - feather, feather, feather, sightlangStaticImage[2], 90, 0, 0, color)
			dxDrawRectangle(x + feather, y + feather, sx - feather * 2, sy - feather * 2, color)
			if sx < widgets[k].textWidth then
				dxDrawImage(x + sx / 2 - data.widgetFontH / 2, y + sy / 2 - data.widgetFontH / 2, data.widgetFontH, data.widgetFontH, ":sGui/" .. data.iconImage .. (faTicks[data.iconImage] or ""), 0, 0, 0, textColor)
			else
				dxDrawImage(x + sx / 2 - data.textWidth / 2, y + sy / 2 - data.widgetFontH / 2, data.widgetFontH, data.widgetFontH, ":sGui/" .. data.iconImage .. (faTicks[data.iconImage] or ""), 0, 0, 0, textColor)
				dxDrawText(data.name, x + sx / 2 - data.textWidth / 2 + data.widgetFontH, y, 0, y + sy, textColor, data.widgetFontScale, data.widgetFont, "left", "center")
			end
			if targetCursorType == "normal" and not widgetResize and not widgetDrag and cx and cy and cx >= x and cy >= y and cx <= x + sx and cy <= y + sy then
				targetCursorType = "move"
				if not data.selected then
					if data.resizable[1] and data.resizable[2] and cx >= x and cy >= y and cx <= x + feather and cy <= y + feather then
						targetCursorType = "resize1"
					elseif data.resizable[1] and data.resizable[2] and cx >= x and cy >= y + sy - feather and cx <= x + feather and cy <= y + sy then
						targetCursorType = "resize2"
					elseif data.resizable[1] and data.resizable[2] and cx >= x + sx - feather and cy >= y and cx <= x + sx + feather and cy <= y + feather then
						targetCursorType = "resize2"
					elseif data.resizable[1] and data.resizable[2] and cx >= x + sx - feather and cy >= y + sy - feather and cx <= x + sx and cy <= y + sy then
						targetCursorType = "resize1"
					elseif data.resizable[1] and cx >= x and cx <= x + feather then
						targetCursorType = "resize4"
					elseif data.resizable[1] and cx >= x + sx - feather and cx <= x + sx then
						targetCursorType = "resize4"
					elseif data.resizable[2] and cy >= y and cy <= y + feather then
						targetCursorType = "resize3"
					elseif data.resizable[2] and cy >= y + sy - feather and cy <= y + sy then
						targetCursorType = "resize3"
					end
				end
			end
		end
	end
	if rightMenu then
		if #rightMenu == 3 then
			local x, y = rightMenu[2], rightMenu[3]
			dxDrawRectangle(x, y, rightMenuSize, #menuPoints * menuFontH, tocolor(0, 0, 0, 174))
			for k = 1, #menuPoints do
				if cx >= x and cy >= y and cx <= x + rightMenuSize and cy <= y + menuFontH then
					dxDrawRectangle(x, y, rightMenuSize, menuFontH, greenColor)
					targetCursorType = "link"
				end
				dxDrawImage(x + 4, y, menuFontH, menuFontH, ":sGui/" .. menuPoints[k][3] .. (faTicks[menuPoints[k][3]] or ""))
				dxDrawText(menuPoints[k][2], x + menuFontH + 8, y, 0, y + menuFontH, tocolor(255, 255, 255), menuFontScale, menuFont, "left", "center")
				y = y + menuFontH
			end
		elseif #rightMenu == 4 then
			local x, y = rightMenu[3], rightMenu[4]
			dxDrawRectangle(x, y, rightMenuSize, menuFontH, tocolor(0, 0, 0, 174))
			local k = 1
			if cx >= x and cy >= y and cx <= x + rightMenuSize and cy <= y + menuFontH then
				dxDrawRectangle(x, y, rightMenuSize, menuFontH, greenColor)
				targetCursorType = "link"
			end
			dxDrawImage(x + 4, y, menuFontH, menuFontH, ":sGui/" .. menuPoints[k][3] .. (faTicks[menuPoints[k][3]] or ""))
			dxDrawText(menuPoints[k][2], x + menuFontH + 8, y, 0, y + menuFontH, tocolor(255, 255, 255), menuFontScale, menuFont, "left", "center")
		else
			local x, y = rightMenu[1], rightMenu[2]
			dxDrawRectangle(x, y, deletedNum < 1 and rightMenu3Size or rightMenu2Size, math.max(1, deletedNum) * menuFontH, tocolor(0, 0, 0, 174))
			if deletedNum < 1 then
				dxDrawImage(x, y, menuFontH, menuFontH, ":sGui/" .. noItemIcon .. (faTicks[noItemIcon] or ""))
				dxDrawText("Nincs törölt HUD elem", x + menuFontH, y, 0, y + menuFontH, tocolor(255, 255, 255), menuFontScale, menuFont, "left", "center")
			else
				for k, data in pairs(widgets) do
					if data.deleted and not data.disabled then
						if cx >= x and cy >= y and cx <= x + rightMenu2Size and cy <= y + menuFontH then
							dxDrawRectangle(x, y, rightMenu2Size, menuFontH, greenColor)
							targetCursorType = "link"
						end
						dxDrawImage(x + 4, y, menuFontH, menuFontH, ":sGui/" .. data.smallIcon .. (faTicks[data.smallIcon] or ""))
						dxDrawText(data.name, x + menuFontH + 8, y, 0, y + menuFontH, tocolor(255, 255, 255), menuFontScale, menuFont, "left", "center")
						y = y + menuFontH
					end
				end
			end
		end
	end
	if selectRectangle then
		if cx then
			local x, y = math.min(selectRectangle[1], cx), math.min(selectRectangle[2], cy)
			local sx, sy = math.max(selectRectangle[1], cx), math.max(selectRectangle[2], cy)
			dxDrawRectangle(x, y, 1, sy - y, selectColor)
			dxDrawRectangle(x, y, sx - x, 1, selectColor)
			dxDrawRectangle(sx - 1, y, 1, sy - y, selectColor)
			dxDrawRectangle(x, sy - 1, sx - x, 1, selectColor)
			dxDrawRectangle(x, y, sx - x, sy - y, bitReplace(selectColor, 174, 24, 8))
			targetCursorType = "normal"
		else
			selectRectangle = false
		end
	end
	if targetCursorType ~= "link" then
		if getKeyState("lalt") then
			if 0 < selectedNum then
				targetCursorType = "minus"
			end
		elseif getKeyState("lshift") then
			targetCursorType = "plus"
		end
	end
	if currentTooltip ~= targetTooltip then
		currentTooltip = targetTooltip
		sightexports.sGui:showTooltip(targetTooltip)
	end
	if cursorType ~= targetCursorType then
		cursorType = targetCursorType
		sightexports.sGui:setCursorType(cursorType)
	end
end
local vignetteLevel = 102
local vignetteState = true
function getVignetteLevel()
	return vignetteLevel / 255 * 100
end
function setVignetteLevel(level)
	vignetteLevel = level / 100 * 255
end
function getVignetteState()
	return vignetteState
end
function setVignetteState(state)
	if vignetteState ~= state then
		vignetteState = state
		if state then
			addEventHandler("onClientRender", getRootElement(), renderVignette, true, "high+99999999")
		else
			removeEventHandler("onClientRender", getRootElement(), renderVignette)
		end
	end
end
function renderVignette()
	dxDrawImage(0, 0, screenX, screenY, "files/vignette.png", 0, 0, 0, tocolor(255, 255, 255, vignetteLevel))
end
addEventHandler("onClientRender", getRootElement(), renderVignette, true, "high+99999999")
local togHudTick = false
local togHudTime = 1500
local toghudCommand = true
function getHudCommandState()
	return toghudCommand
end
function setHudCommandState(state)
	if toghudCommand ~= state then
		toghudCommand = state
		sourceResource = false
		setHudEnabled(toghudCommand)
	end
end
addCommandHandler("toghud", function()
	if not widgetEditMode then
		toghudCommand = not toghudCommand
		sourceResource = false
		setHudEnabled(toghudCommand)
	end
end)
local hudDisabledByRes = {}
if not getElementData(localPlayer, "loggedIn") then
	hudDisabledByRes.sAccounts = true
end
function setHudEnabled(state, time)
	local resource = sourceResource and getResourceName(sourceResource) or "def"
	hudDisabledByRes[resource] = not state
	local newState = true
	for k, v in pairs(hudDisabledByRes) do
		if v then
			newState = false
			break
		end
	end
	setHudState(newState, time)
end
function getHudDisabled()
	for k, v in pairs(hudDisabledByRes) do
		if v then
			return true
		end
	end
	return false
end
local hudAnimationHandled = false
function setHudState(state, time)
	if hudToggle ~= state then
		hudToggle = not hudToggle
		showChat(hudToggle)
		togHudTime = time or 1500
		togHudTick = getTickCount()
		if not hudAnimationHandled then
			hudAnimationHandled = true
			addEventHandler("onClientRender", getRootElement(), renderHudToggleAnimation)
		end
		for k, data in pairs(widgets) do
			if not data.deleted and not data.disabled and k ~= "debug" then
				if hudToggle then
					triggerEvent("hudWidgetState:" .. k, localPlayer, hudToggle and not widgets[k].deleted and not widgets[k].disabled)
					local pos = {}
					pos[1] = data.position[1] + (data.position[1] > screenX / 2 and screenX or -screenX)
					pos[2] = data.position[2] + (data.position[2] > screenY / 2 and screenY or -screenY)
					triggerEvent("hudWidgetPosition:" .. k, localPlayer, pos, true)
				else
					triggerEvent("hudWidgetPosition:" .. k, localPlayer, widgets[k].position, true)
				end
			end
		end
	end
end
function renderHudToggleAnimation()
	local progress = (getTickCount() - togHudTick) / togHudTime
	if 1 <= progress then
		progress = 1
		togHudTick = false
		removeEventHandler("onClientRender", getRootElement(), renderHudToggleAnimation)
		hudAnimationHandled = false
	end
	local prog = progress
	if hudToggle then
		prog = 1 - prog
	end
	prog = getEasingValue(prog, "InOutQuad")
	for k, data in pairs(widgets) do
		if not data.deleted and not data.disabled and k ~= "debug" then
			local pos = {}
			if 1 <= progress then
				if hudToggle then
					triggerEvent("hudWidgetPosition:" .. k, localPlayer, widgets[k].position, true)
				else
					triggerEvent("hudWidgetState:" .. k, localPlayer, false)
				end
			else
				pos[1] = data.position[1] + (data.position[1] > screenX / 2 and screenX * prog or -screenX * prog)
				pos[2] = data.position[2] + (data.position[2] > screenY / 2 and screenY * prog or -screenY * prog)
				triggerEvent("hudWidgetPosition:" .. k, localPlayer, pos, true)
			end
		end
	end
end
local hitTick = false
local collisionMultipler = 1
local hitHandled = false
local hitControls = false
local screenShader = false
local screenSrc = false
local shaderSource = [[
texture texture0; 
float factor; 
float Saturation; 
float Contrast;
float Dark;
  
sampler Sampler0 = sampler_state 
{ 
    Texture = (texture0); 
    AddressU = MIRROR; 
    AddressV = MIRROR; 
}; 
  
struct PSInput 
{ 
  float2 TexCoord : TEXCOORD0; 
}; 
  
float4 PixelShader_Background(PSInput PS) : COLOR0 
{ 
		//const float3 lumCoeff = float3(0.2125, 0.7154, 0.0721);

        float4 sum = tex2D(Sampler0, PS.TexCoord); 
      	
      	float xc = (PS.TexCoord.x-0.5)/0.5;
		float yc = (PS.TexCoord.x-0.5)/0.5;

		for (float i = 1; i < 3; i++) { 

			sum += tex2D(Sampler0, float2(PS.TexCoord.x, PS.TexCoord.y + (i * factor)*yc)); 
			sum += tex2D(Sampler0, float2(PS.TexCoord.x, PS.TexCoord.y - (i * factor)*yc)); 
			sum += tex2D(Sampler0, float2(PS.TexCoord.x - (i * factor)*xc, PS.TexCoord.y)); 
			sum += tex2D(Sampler0, float2(PS.TexCoord.x + (i * factor)*xc, PS.TexCoord.y)); 
		} 

		//sum.rgb = (sum.rgb - 0.5) *(Contrast + 1.0) + 0.5;  

    	//float3 intensity;     
    	//intensity = float(dot(sum.rgb, lumCoeff));
        //sum.rgb = lerp(intensity, sum.rgb, Saturation );
        //sum.rgb = sum.rgb - Dark;

        sum /= 9; 
        sum.a = 1.0; 

        return sum; 
} 
  
technique complercated 
{ 
    pass P0 
    { 
        PixelShader = compile ps_2_0 PixelShader_Background(); 
    } 
} 
  
technique simple 
{ 
    pass P0 
    { 
        Texture[0] = texture0; 
    } 
} 

]]
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()) or resourceRoot, function()
	screenSrc = dxCreateScreenSource(screenX, screenY)
	screenShader = dxCreateShader(shaderSource)
	dxSetShaderValue(screenShader, "UVSize", screenX, screenY)
	dxSetShaderValue(screenShader, "factor", 0)
	dxSetShaderValue(screenShader, "texture0", screenSrc)
end)
local colAngle = 0
function calculateAttackerImageAngle()
	local x, y, z, tx, ty, tz = getCameraMatrix()
	local angle2 = findRotation(x, y, tx, ty)
	if colAngle and angle2 then
		local imgAngle = colAngle - angle2
		return -imgAngle
	end
end
function findRotation(x1, y1, x2, y2)
	local t = -math.deg(math.atan2(x2 - x1, y2 - y1))
	if t < 0 then
		t = t + 360
	end
	return t
end
addEventHandler("onClientVehicleCollision", root, function(collider, force, bodyPart, x, y, z, nx, ny, nz)
	if source == getPedOccupiedVehicle(localPlayer) and 60 < force then
		force = force / 1000 + 1
		if not hitControls then
			hitControls = true
			sightexports.sControls:toggleAllControls(false)
		end
		if force > collisionMultipler then
			local px, py, pz = getElementPosition(localPlayer)
			colAngle = findRotation(px, py, x, y)
			collisionMultipler = force
			createExplosion(px, py, pz - 50, 12, false, 1.15 * collisionMultipler, false)
			if not hitHandled then
				hitHandled = true
				addEventHandler("onClientRender", getRootElement(), renderHudHit, true, "low-999999")
			end
			hitTick = getTickCount()
		end
	end
end)
function getVehicleSpeed(currentElement)
	if isElement(currentElement) then
		local x, y, z = getElementVelocity(currentElement)
		return math.sqrt(x ^ 2 + y ^ 2 + z ^ 2) * 187.5
	end
end
local hudVehHandled = false
local lastSpeed = 0
local accelerations = {}
function renderHudHit()
	local progress = (getTickCount() - hitTick) / math.min(15000, math.max(1000, 1500 * collisionMultipler))
	if 0.3 < progress and hitControls then
		hitControls = false
		sightexports.sControls:toggleAllControls(true)
	end
	if 1 <= progress then
		collisionMultipler = 0
		progress = 1
	end
	if progress <= 0.15 then
		prog = progress / 0.15
	else
		prog = 1 - (progress - 0.15) / 0.85
	end
	if 0 > prog then
		prog = 0
	end
	dxUpdateScreenSource(screenSrc, true)
	dxSetShaderValue(screenShader, "factor", 50 * collisionMultipler * prog / 10000)
	dxDrawImage(0, 0, screenX, screenY, screenShader)
	if 1 <= progress then
		hitTick = false
		hitHandled = false
		removeEventHandler("onClientRender", getRootElement(), renderHudHit, true, "low-999999")
	end
end
local hudMovementState = trueobs
function getHudMovementState()
	return hudMovementState or false
end
function setHudMovementState(val)
	hudMovementState = val
end
function preRenderHudVehicle(delta)
	if not hudMovementState then
		return
	end
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
		local rx, ry, rz = getElementRotation(localPlayer)
		local speed = getVehicleSpeed(veh)
		local acceleration = speed - lastSpeed
		lastSpeed = speed
		local smooth = math.floor(1000 / delta * 0.95 / 5 + 0.5) * 5
		table.insert(accelerations, acceleration * 1.5 + math.min(1, speed / 250))
		if smooth < #accelerations then
			for i = 1, math.min(2, #accelerations - smooth) do
				table.remove(accelerations, 1)
			end
		end
		local avg = 0
		local pow = 0
		local n = #accelerations
		local q = math.floor(n * 0.25)
		local t = math.floor(n * 0.925)
		for i = 1, n do
			local p = 1
			if i < q then
				p = i / q
			end
			if i > t then
				p = 1 - (i - t) / (n - t + 1)
			end
			avg = avg + accelerations[i] * p
			pow = pow + p
		end
		if 0 < pow then
			avg = avg / pow
		else
			avg = 0
		end
		local pn = avg
		avg = math.abs(avg)
		if 0 < avg then
			pn = pn / avg
			local a1 = math.min(1, avg)
			local a2 = math.max(0, avg - 1)
			avg = (a1 * a1 + a2) * pn
		end
		local vx = math.sin(math.rad(ry)) * -screenX * 0.15 * math.min(1, speed / 150)
		local vy = avg * screenY * 0.01
		if hitTick then
			local prog = (getTickCount() - hitTick) / math.max(100, 200 - 50 * collisionMultipler)
			if 2 < prog then
				prog = 1 - (prog - 2) / 4
				if prog < 0 then
					prog = 0
				end
			elseif 1 < prog then
				prog = 1
			end
			if not hudAnimationHandled then
				for k, data in pairs(widgets) do
					if not data.deleted and not data.disabled and k ~= "debug" and k ~= "oocChat" then
						local pos = {}
						local a = calculateAttackerImageAngle()
						local r = math.rad(a) + math.pi / 2
						pos[1] = data.position[1] + 32 * math.cos(r) * collisionMultipler * prog + vx
						pos[2] = data.position[2] + 32 * math.sin(r) * collisionMultipler * prog + vy
						triggerEvent("hudWidgetPosition:" .. k, localPlayer, pos, true, true)
					end
				end
			end
		end
		if not hudAnimationHandled and not hitTick then
			for k, data in pairs(widgets) do
				if not data.deleted and not data.disabled and k ~= "debug" and k ~= "oocChat" then
					if math.abs(vx) == 0 and math.abs(vy) == 0 then
						triggerEvent("hudWidgetPosition:" .. k, localPlayer, widgets[k].position, true, true)
					else
						local pos = {}
						pos[1] = data.position[1] + vx
						pos[2] = data.position[2] + vy
						triggerEvent("hudWidgetPosition:" .. k, localPlayer, pos, true, true)
					end
				end
			end
		end
	else
		removeEventHandler("onClientPreRender", getRootElement(), preRenderHudVehicle)
		hudVehHandled = false
		for k, data in pairs(widgets) do
			if not data.deleted and not data.disabled and k ~= "debug" and k ~= "oocChat" then
				triggerEvent("hudWidgetPosition:" .. k, localPlayer, data.position, true, true)
			end
		end
	end
end
if getPedOccupiedVehicle(localPlayer) then
	lastSpeed = getVehicleSpeed(getPedOccupiedVehicle(localPlayer))
	if not hudVehHandled then
		hudVehHandled = true
		addEventHandler("onClientPreRender", getRootElement(), preRenderHudVehicle)
	end
end
addEventHandler("onClientVehicleEnter", getRootElement(), function(player)
	if player == localPlayer and getPedOccupiedVehicle(localPlayer) then
		lastSpeed = getVehicleSpeed(getPedOccupiedVehicle(localPlayer))
		if not hudVehHandled then
			hudVehHandled = true
			addEventHandler("onClientPreRender", getRootElement(), preRenderHudVehicle)
		end
	end
end)
function moveWholeHud(x, y)
	if not hudMovementState then
		return
	end
	if not hudAnimationHandled and not hitTick then
		for k, data in pairs(widgets) do
			if not data.deleted and not data.disabled and k ~= "debug" and k ~= "oocChat" then
				if math.abs(x) == 0 and math.abs(y) == 0 then
					triggerEvent("hudWidgetPosition:" .. k, localPlayer, widgets[k].position, true)
				else
					local pos = {}
					pos[1] = data.position[1] + x
					pos[2] = data.position[2] + y
					triggerEvent("hudWidgetPosition:" .. k, localPlayer, pos, true)
				end
			end
		end
	end
end
local sprintKeys = getBoundKeys("sprint")
local lastX, lastY, lastZ = 0, 0, 0
local lastSprint = 0
local sprinting = false
local staminaPower = {
	stand = 0,
	walk = 0,
	powerwalk = 0.35,
	jog = 0.35,
	roll = 0.35,
	sprint = 2,
	crouch = 0,
	crawl = 0,
	jump = 3,
	fall = 0,
	climb = 1.25
}
local drugEffects = {
	lsd = {0.55, 1.1},
	shroom = {0.45, 1.05},
	coke = {0.15, 1.25},
	speed = {0.05, 1.35},
	weed = {1.15, 0.9},
	ex = {0.075, 1.3},
	para = {0.1, 1.3}
}
local currentDrug = false
local currentDose = 0
function staminaDrug(drug, dose)
	currentDrug = drug
	currentDose = dose
end
local currentPow = 0
local powerUp = 0
local targetPowerUp = 0
local lowStamina = false
local tiredAnim = false
local lastTiredSync = 0
local controlsSprint = true
local controlsJog = true
function sprintControls(sprint, jog)
	controlsSprint = sprint
	controlsJog = jog
end
local itemWeight = 0
function refreshItemWeight(weight)
	itemWeight = weight
end
local pushingVehicle = false
function refreshVehiclePush(push)
	pushingVehicle = push
end

local staminaMul = 1

function setStaminaMul(mul)
	if mul == 1 then
		mul = 100
	end
	staminaMul = mul / 100
end

local moveDisabledPush = false
addEventHandler("onClientPreRender", getRootElement() or resourceRoot, function(delta)
	local now = getTickCount()
	local x, y, z = getElementPosition(localPlayer)
	local d = getDistanceBetweenPoints2D(x, y, lastX, lastY) / delta * 1000
	local zMul = 0
	if d < 20 then
		zMul = math.max(0, (z - lastZ) / delta * 1000)
	end
	lastX, lastY, lastZ = x, y, z
	local pow = 0
	local mState = getPedMoveState(localPlayer)
	local sTask = getPedSimplestTask(localPlayer)
	local swim = false
	if sTask == "TASK_SIMPLE_SWIM" then
		pow = d / 3
		swim = true
	else
		local task = getPedTask(localPlayer, "secondary", 0)
		if task == "TASK_SIMPLE_FIGHT" then
			pow = staminaPower.jump * 0.45
		end
		if task ~= "TASK_SIMPLE_NAMED_ANIM" then
			local task = getPedTask(localPlayer, "primary", 1)
			if task ~= "TASK_COMPLEX_IN_AIR_AND_LAND" then
				pow = math.max(pow, (staminaPower[mState] or 0) * (1 + zMul / 5))
			end
		end
		if pushingVehicle then
			pow = math.max(pow, staminaPower.jog * (1 + zMul / 5))
		end
		if carryingBody then
			pow = pow + 5
			if 0 >= stamina or 20 >= getElementHealth(localPlayer) then
				carryingBody = false
				triggerServerEvent("endBodyCarry", localPlayer)
				bodyTriggerTick = getTickCount()
			end
		end
		if sightexports.sDamage:isCrawling() or false then
			pow = pow + 30
			if 0 >= stamina then
				if not crawlStopped then
					sightexports.sControls:toggleControl({
						"forwards",
						"backwards",
						"left",
						"right"
					}, false)
					crawlStopped = true
				end
			elseif 20 < stamina and crawlStopped then
				sightexports.sControls:toggleControl({
					"forwards",
					"backwards",
					"left",
					"right"
				}, true)
				crawlStopped = false
			end
		elseif crawlStopped then
			sightexports.sControls:toggleControl({
				"forwards",
				"backwards",
				"left",
				"right"
			}, true)
			crawlStopped = false
		end
	end
	if d < 0.5 then
		pow = 0
	end
	if currentDrug then
		pow = pow * (1 + (drugEffects[currentDrug][1] - 1) * currentDose)
	end
	pow = pow * (staminaMul)
	pow = pow * (1 + itemWeight / 20 * 0.2)
	if pow > currentPow then
		currentPow = currentPow + 2.5 * delta / 1000
		if pow < currentPow then
			currentPow = pow
		end
	elseif pow < currentPow then
		currentPow = currentPow - 2.5 * delta / 1000
		if pow > currentPow then
			currentPow = pow
		end
	end
	local atmp = tiredAnim
	if 0 < currentPow then
		if stamina > -5 then
			stamina = stamina - currentPow * delta / 1000 * 2
			if stamina < -5 then
				stamina = -5
			end
		end
		if 0 < powerUp then
			powerUp = powerUp - 1 * delta / 1000
			if powerUp < 0 then
				powerUp = 0
			end
		end
	elseif stamina < 100 then
		targetPowerUp = (mState == "stand" or mState == "fall" or mState == "crouch" or isPedInVehicle(localPlayer)) and (lowStamina and 1.5 or 2) or lowStamina and 0 or 1
		if currentDrug then
			targetPowerUp = targetPowerUp * (1 + (drugEffects[currentDrug][2] - 1) * currentDose)
		end
		targetPowerUp = targetPowerUp * (1 - itemWeight / 20 * 0.125)
		if powerUp < targetPowerUp then
			powerUp = powerUp + 0.5 * delta / 1000
			if powerUp > targetPowerUp then
				powerUp = targetPowerUp
			end
		elseif powerUp > targetPowerUp then
			powerUp = powerUp - 1 * delta / 1000
			if powerUp < targetPowerUp then
				powerUp = targetPowerUp
			end
		end
		local p = powerUp
		if 0 < p and (mState == "stand" or mState == "fall") and lowStamina and sTask ~= "TASK_SIMPLE_GO_TO_POINT" and utf8.sub(sTask, 1, 16) ~= "TASK_SIMPLE_CAR_" and not isPedDucked(localPlayer) and not isPedInVehicle(localPlayer) then
			local a, b = getPedAnimation(localPlayer)
			if a ~= "ped" or b ~= "idle_tired" then
				setPedAnimation(localPlayer, "ped", "idle_tired", -1, true, false, true)
				atmp = true
			end
		else
			local a, b = getPedAnimation(localPlayer)
			if a == "ped" and b == "idle_tired" then
				setPedAnimation(localPlayer)
				atmp = false
			end
		end
		if powerUp < 1 then
			p = getEasingValue(powerUp, "InQuad")
		end
		stamina = stamina + p * delta / 1000 * 2
		if stamina > 100 then
			stamina = 100
		end
	else
		local a, b = getPedAnimation(localPlayer)
		if a == "ped" and b == "idle_tired" then
			setPedAnimation(localPlayer)
			atmp = false
		end
	end
	local tmp = false
	if sprintKeys then
		for key, state in pairs(sprintKeys) do
			if not sightexports.sGui:getActiveInput() and not isChatBoxInputActive() and not isConsoleActive() and getKeyState(key) then
				tmp = true
				break
			end
		end
	end
	if tmp ~= sprinting then
		sprinting = tmp
		lastSprint = now
	end
	if atmp ~= tiredAnim and 1000 < now - lastTiredSync then
		tiredAnim = atmp
		lastTiredSync = now
		triggerServerEvent("syncTiredAnim", localPlayer, atmp)
	end
	if not isPedWearingJetpack(localPlayer) and not isPedDucked(localPlayer) then
		if sprinting and 0 < stamina and controlsJog then
			setPedControlState(localPlayer, "walk", false)
			local canSprint = not lowStamina and controlsSprint and (swim and true or now - lastSprint < 100)
			setPedControlState(localPlayer, "sprint", canSprint)
		else
			setPedControlState(localPlayer, "walk", true)
			setPedControlState(localPlayer, "sprint", false)
		end
	end
	if lowStamina and stamina > 30 then
		lowStamina = false
		setElementData(localPlayer, "lowStamina", nil)
		sightexports.sControls:toggleControl("sprint", true)
		sightexports.sControls:toggleControl("jump", true)
	elseif not lowStamina and 20 > stamina then
		lowStamina = true
		setElementData(localPlayer, "lowStamina", true)
		sightexports.sControls:toggleControl("sprint", false)
		sightexports.sControls:toggleControl("jump", false)
		sightexports.sGui:showInfobox("i", "Elfáradtál, ezért nem tudsz ugrani, sprintelni és autót tolni.")
	end
	if lowStamina and mState == "climb" then
		local x, y, z = getElementPosition(localPlayer)
		setElementPosition(localPlayer, x, y, z)
	end
	if not hudToggle and isChatVisible() then
		showChat(false)
	end
end)
function getStamina()
	return stamina
end
