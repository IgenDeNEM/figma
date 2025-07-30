local sightexports = {
	sModloader = false,
	sGroups = false,
	sGui = false,
	sHud = false
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
		refreshColors()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
	faTicks = sightexports.sGui:getFaTicks()
end)
local sightlangModloaderLoaded = function()
	loadModelIds()
end
addEventHandler("modloaderLoaded", getRootElement(), sightlangModloaderLoaded)
if getElementData(localPlayer, "loggedIn") or sightexports.sModloader and sightexports.sModloader:isModloaderLoaded() then
	addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangModloaderLoaded)
end
screenX, screenY = guiGetScreenSize()
matrixCache = {}
function getPositionFromElementOffset(element, offX, offY, offZ)
	if not matrixCache[element] then
		matrixCache[element] = getElementMatrix(element)
	end
	local m = matrixCache[element]
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z
end
objectModels = {}
function loadModelIds()
	objectModels = {
		drain_can = sightexports.sModloader:getModelId("oil_drain_can"),
		engineoil = sightexports.sModloader:getModelId("motoroil"),
		suspension_front = sightexports.sModloader:getModelId("suspension_front"),
		suspension_rear = sightexports.sModloader:getModelId("suspension_rear"),
		brake = sightexports.sModloader:getModelId("brakedisc"),
		wheel_align_machine = sightexports.sModloader:getModelId("wheel_align_machine"),
		wheel_align_machine2 = sightexports.sModloader:getModelId("wheel_align_machine2"),
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
		oil_drain_can = sightexports.sModloader:getModelId("oil_drain_can"),
		motoroil = sightexports.sModloader:getModelId("motoroil"),
		inspection_pad = sightexports.sModloader:getModelId("inspection_pad"),
		inspection_pad2 = sightexports.sModloader:getModelId("inspection_pad2"),
		carbon_monoxide_meter = sightexports.sModloader:getModelId("carbon_monoxide_meter"),
		impact_wrench = sightexports.sModloader:getModelId("impact_wrench"),
		kruton = sightexports.sModloader:getModelId("kruton"),
		mechanic_document = sightexports.sModloader:getModelId("mechanic_document"),
		koviubi = sightexports.sModloader:getModelId("koviubi")
	}
	local obj = createObject(objectModels.koviubi, -1910.369140625, -1671.373046875, 22.225)
	setElementCollisionsEnabled(obj, false)
	local obj = createObject(objectModels.koviubi, 2068.6166015625, -1700.1159921875, 14.3125, 0, 0, 90)
	setElementCollisionsEnabled(obj, false)
	triggerServerEvent("requestMechanicLifts", localPlayer)
end
function drawScrew(x, y, z, r, r2, s, cx, cy, a, hexSize, leg)
	local sy = s
	local sx = s * 0.92
	local poses = {
		{0, 0},
		{
			0 + sx / 2,
			0 + sy * 0.25
		},
		{
			0 - sx / 2,
			0 + sy * 0.25
		},
		{
			0 + sx / 2,
			0 + sy * 0.75
		},
		{
			0 - sx / 2,
			0 + sy * 0.75
		},
		{
			0,
			0 + sy
		}
	}
	for i = 1, #poses do
		local x, y = poses[i][1], poses[i][2]
		poses[i][1] = x * math.cos(r2) - (y - sy / 2) * math.sin(r2)
		poses[i][2] = sy / 2 + x * math.sin(r2) + (y - sy / 2) * math.cos(r2)
	end
	local primitive = {}
	local minX, minY = screenX, screenY
	local maxX, maxY = 0, 0
	local wx, wy, wz = x, y, z
	for i = 1, #poses do
		local x, y = getScreenFromWorldPosition(x + math.cos(r) * poses[i][1], y + math.sin(r) * poses[i][1], z - sy / 2 + poses[i][2], 256)
		if not x then
			return
		else
			if minX > x then
				minX = x
			end
			if minY > y then
				minY = y
			end
			if maxX < x then
				maxX = x
			end
			if maxY < y then
				maxY = y
			end
			table.insert(primitive, {x, y})
		end
	end
	local hover = false
	local c = tocolor(blue[1], blue[2], blue[3], 150 * a)
	if (repairingPart or screwingWheel) and cx >= minX and cy >= minY and cx <= maxX and cy <= maxY then
		local px, py, pz = getElementPosition(localPlayer)
		if getDistanceBetweenPoints2D(wx, wy, px, py) <= 1.75 then
			hover = {
				x,
				y,
				z
			}
			if currentHexSize == hexSize then
				c = tocolor(green[1], green[2], green[3], 200 * a)
			else
				c = tocolor(red[1], red[2], red[3], 200 * a)
			end
		end
	end
	for i = 1, #primitive do
		primitive[i][3] = c
	end
	local x2, y2 = getScreenFromWorldPosition(x + math.cos(r - math.pi / 2) * s * leg, y + math.sin(r - math.pi / 2) * s * leg, z, 256)
	local x, y, d = getScreenFromWorldPosition(x, y, z, 256)
	if x and x2 then
		dxDrawLine(x, y, x2, y2, c, 1 / d * s * 350)
	end
	dxDrawPrimitive("trianglestrip", false, unpack(primitive))
	return hover
end
local workshopState = true
local hasPerm = false
function checkWorkshopPerm()
	if currentWorkshop and workshops[currentWorkshop] then
		hasPerm = sightexports.sGroups:isPlayerInGroup(workshops[currentWorkshop][7])
		if workshopState then
			currentWorkshopPerm = hasPerm
		else
			currentWorkshopPerm = false
		end
	else
		currentWorkshopPerm = false
	end
end
addEvent("gotPlayerGroupMembership", true)
addEventHandler("gotPlayerGroupMembership", getRootElement(), function()
	checkWorkshopPerm()
end)
function getComponentPosition(veh, comp)
	if comp == "headlights_left" or comp == "headlights_right" then
		local x, y, z = getVehicleDummyPosition(veh, "light_front_main")
		if x then
			if comp == "headlights_left" then
				x = -math.abs(x)
			elseif comp == "headlights_right" then
				x = math.abs(x)
			end
		end
		if x then
			return getPositionFromElementOffset(veh, x, y, z)
		end
	elseif comp == "taillights_left" or comp == "taillights_right" then
		local x, y, z = getVehicleDummyPosition(veh, "light_rear_main")
		if x then
			if comp == "taillights_left" then
				x = -math.abs(x)
			elseif comp == "taillights_right" then
				x = math.abs(x)
			end
		end
		if x then
			return getPositionFromElementOffset(veh, x, y, z)
		end
	elseif comp == "exhaust" then
		local x, y, z = getVehicleDummyPosition(veh, "exhaust")
		if x then
			return getPositionFromElementOffset(veh, x, y, z)
		end
	elseif comp == "engine" then
		local x, y, z = getVehicleDummyPosition(veh, "engine")
		if x then
			return getPositionFromElementOffset(veh, 0, y, z)
		end
	elseif comp == "bump_front_dummy" or comp == "bump_rear_dummy" then
		local x, y, z = getVehicleComponentPosition(veh, comp, "root")
		if x then
			return getPositionFromElementOffset(veh, 0, y, z)
		end
	else
		return getVehicleComponentPosition(veh, comp, "world")
	end
end
green = false
red = false
orange = false
blue = false
grey1 = false
local togIcon1 = false
local togIcon2 = false
function refreshColors()
	green = sightexports.sGui:getColorCode("sightgreen")
	red = sightexports.sGui:getColorCode("sightred")
	orange = sightexports.sGui:getColorCode("sightorange")
	blue = sightexports.sGui:getColorCode("sightblue")
	grey1 = sightexports.sGui:getColorCode("sightgrey1")
	togIcon1 = sightexports.sGui:getFaIconFilename("car-mechanic", 64, "solid")
	togIcon2 = sightexports.sGui:getFaIconFilename("car-mechanic", 64, "light")
end
addEventHandler("onClientResourceStart", getRootElement(), function(res)
	if source == getResourceRootElement() then
		engineLoadIFP("files/drill.ifp", "drill")
		engineLoadIFP("files/drilldn.ifp", "drilldn")
		engineLoadIFP("files/drillup.ifp", "drillup")
	end
end)
local mechanicWidgetState = false
local widgetPos = {}
local widgetSize = {}
local widgetHover = false
function renderMechanicWidget()
	if currentWorkshop and hasPerm then
		local x, y = unpack(widgetPos)
		local sx, sy = unpack(widgetSize)
		x = x + sx / 2
		y = y + sy / 2
		local is = math.min(sx, sy)
		local cx, cy = getCursorPosition()
		if cx then
			cx = cx * screenX
			cy = cy * screenY
		end
		local tmp = cx and cx >= x - is / 2 and cx <= x + is / 2 and cy >= y - is / 2 and cy <= y + is / 2
		if tmp ~= widgetHover then
			widgetHover = tmp
			sightexports.sGui:setCursorType(widgetHover and "link" or "normal")
			sightexports.sGui:showTooltip(widgetHover and "Szerelő mód " .. (workshopState and "ki" or "be") .. "kapcsolása")
		end
		if workshopState then
			dxDrawImage(x - is / 2, y - is / 2, is, is, ":sGui/" .. togIcon1 .. (faTicks[togIcon1] or ""), 0, 0, 0, tocolor(green[1], green[2], green[3]))
		else
			dxDrawImage(x - is / 2, y - is / 2, is, is, ":sGui/" .. togIcon2 .. (faTicks[togIcon2] or ""), 0, 0, 0, tocolor(red[1], red[2], red[3]))
		end
	end
end
function isInsideWorkshop()
	return currentWorkshop and hasPerm
end
function getWorkshopState()
	return workshopState
end
function clickMechanicWidget(button, state)
	if state == "down" and widgetHover and not sightexports.sHud:getWidgetEditMode() then
		workshopState = not workshopState
		checkWorkshopPerm()
		widgetHover = false
	end
end
addEvent("hudWidgetState:mechanic", true)
addEventHandler("hudWidgetState:mechanic", getRootElement(), function(state)
	if mechanicWidgetState ~= state then
		mechanicWidgetState = state
		if mechanicWidgetState then
			addEventHandler("onClientRender", getRootElement(), renderMechanicWidget)
			addEventHandler("onClientClick", getRootElement(), clickMechanicWidget)
		else
			removeEventHandler("onClientRender", getRootElement(), renderMechanicWidget)
			removeEventHandler("onClientClick", getRootElement(), clickMechanicWidget)
			sightexports.sGui:setCursorType("normal")
			sightexports.sGui:showTooltip(false)
		end
	end
end)
addEvent("hudWidgetPosition:mechanic", true)
addEventHandler("hudWidgetPosition:mechanic", getRootElement(), function(pos, final)
	widgetPos = pos
end)
addEvent("hudWidgetSize:mechanic", true)
addEventHandler("hudWidgetSize:mechanic", getRootElement(), function(size, final)
	widgetSize = size
end)
triggerEvent("requestWidgetDatas", localPlayer, "mechanic")

addEvent("gotMechanicLifts", true)
function gotMechanicLifts(lifts)
	for k, v in pairs(lifts) do
		setElementModel(v[1], sightexports.sModloader:getModelId("emelo_block"))
		setElementModel(v[2], sightexports.sModloader:getModelId("emelo_kar"))
	end
end
addEventHandler("gotMechanicLifts", root, gotMechanicLifts)
