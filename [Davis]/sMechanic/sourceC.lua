local sightexports = {
	sGui = false,
	sChat = false,
	sWeapons = false,
	sCore = false,
	sGroups = false,
	sPattach = false,
	sCamera = false
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
sightlangStaticImageToc[3] = true
sightlangStaticImageToc[4] = true
sightlangStaticImageToc[5] = true
sightlangStaticImageToc[6] = true
sightlangStaticImageToc[7] = true
sightlangStaticImageToc[8] = true
sightlangStaticImageToc[9] = true
sightlangStaticImageToc[10] = true
sightlangStaticImageToc[11] = true
sightlangStaticImageToc[12] = true
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
	if sightlangStaticImageUsed[3] then
		sightlangStaticImageUsed[3] = false
		sightlangStaticImageDel[3] = false
	elseif sightlangStaticImage[3] then
		if sightlangStaticImageDel[3] then
			if now >= sightlangStaticImageDel[3] then
				if isElement(sightlangStaticImage[3]) then
					destroyElement(sightlangStaticImage[3])
				end
				sightlangStaticImage[3] = nil
				sightlangStaticImageDel[3] = false
				sightlangStaticImageToc[3] = true
				return
			end
		else
			sightlangStaticImageDel[3] = now + 5000
		end
	else
		sightlangStaticImageToc[3] = true
	end
	if sightlangStaticImageUsed[4] then
		sightlangStaticImageUsed[4] = false
		sightlangStaticImageDel[4] = false
	elseif sightlangStaticImage[4] then
		if sightlangStaticImageDel[4] then
			if now >= sightlangStaticImageDel[4] then
				if isElement(sightlangStaticImage[4]) then
					destroyElement(sightlangStaticImage[4])
				end
				sightlangStaticImage[4] = nil
				sightlangStaticImageDel[4] = false
				sightlangStaticImageToc[4] = true
				return
			end
		else
			sightlangStaticImageDel[4] = now + 5000
		end
	else
		sightlangStaticImageToc[4] = true
	end
	if sightlangStaticImageUsed[5] then
		sightlangStaticImageUsed[5] = false
		sightlangStaticImageDel[5] = false
	elseif sightlangStaticImage[5] then
		if sightlangStaticImageDel[5] then
			if now >= sightlangStaticImageDel[5] then
				if isElement(sightlangStaticImage[5]) then
					destroyElement(sightlangStaticImage[5])
				end
				sightlangStaticImage[5] = nil
				sightlangStaticImageDel[5] = false
				sightlangStaticImageToc[5] = true
				return
			end
		else
			sightlangStaticImageDel[5] = now + 5000
		end
	else
		sightlangStaticImageToc[5] = true
	end
	if sightlangStaticImageUsed[6] then
		sightlangStaticImageUsed[6] = false
		sightlangStaticImageDel[6] = false
	elseif sightlangStaticImage[6] then
		if sightlangStaticImageDel[6] then
			if now >= sightlangStaticImageDel[6] then
				if isElement(sightlangStaticImage[6]) then
					destroyElement(sightlangStaticImage[6])
				end
				sightlangStaticImage[6] = nil
				sightlangStaticImageDel[6] = false
				sightlangStaticImageToc[6] = true
				return
			end
		else
			sightlangStaticImageDel[6] = now + 5000
		end
	else
		sightlangStaticImageToc[6] = true
	end
	if sightlangStaticImageUsed[7] then
		sightlangStaticImageUsed[7] = false
		sightlangStaticImageDel[7] = false
	elseif sightlangStaticImage[7] then
		if sightlangStaticImageDel[7] then
			if now >= sightlangStaticImageDel[7] then
				if isElement(sightlangStaticImage[7]) then
					destroyElement(sightlangStaticImage[7])
				end
				sightlangStaticImage[7] = nil
				sightlangStaticImageDel[7] = false
				sightlangStaticImageToc[7] = true
				return
			end
		else
			sightlangStaticImageDel[7] = now + 5000
		end
	else
		sightlangStaticImageToc[7] = true
	end
	if sightlangStaticImageUsed[8] then
		sightlangStaticImageUsed[8] = false
		sightlangStaticImageDel[8] = false
	elseif sightlangStaticImage[8] then
		if sightlangStaticImageDel[8] then
			if now >= sightlangStaticImageDel[8] then
				if isElement(sightlangStaticImage[8]) then
					destroyElement(sightlangStaticImage[8])
				end
				sightlangStaticImage[8] = nil
				sightlangStaticImageDel[8] = false
				sightlangStaticImageToc[8] = true
				return
			end
		else
			sightlangStaticImageDel[8] = now + 5000
		end
	else
		sightlangStaticImageToc[8] = true
	end
	if sightlangStaticImageUsed[9] then
		sightlangStaticImageUsed[9] = false
		sightlangStaticImageDel[9] = false
	elseif sightlangStaticImage[9] then
		if sightlangStaticImageDel[9] then
			if now >= sightlangStaticImageDel[9] then
				if isElement(sightlangStaticImage[9]) then
					destroyElement(sightlangStaticImage[9])
				end
				sightlangStaticImage[9] = nil
				sightlangStaticImageDel[9] = false
				sightlangStaticImageToc[9] = true
				return
			end
		else
			sightlangStaticImageDel[9] = now + 5000
		end
	else
		sightlangStaticImageToc[9] = true
	end
	if sightlangStaticImageUsed[10] then
		sightlangStaticImageUsed[10] = false
		sightlangStaticImageDel[10] = false
	elseif sightlangStaticImage[10] then
		if sightlangStaticImageDel[10] then
			if now >= sightlangStaticImageDel[10] then
				if isElement(sightlangStaticImage[10]) then
					destroyElement(sightlangStaticImage[10])
				end
				sightlangStaticImage[10] = nil
				sightlangStaticImageDel[10] = false
				sightlangStaticImageToc[10] = true
				return
			end
		else
			sightlangStaticImageDel[10] = now + 5000
		end
	else
		sightlangStaticImageToc[10] = true
	end
	if sightlangStaticImageUsed[11] then
		sightlangStaticImageUsed[11] = false
		sightlangStaticImageDel[11] = false
	elseif sightlangStaticImage[11] then
		if sightlangStaticImageDel[11] then
			if now >= sightlangStaticImageDel[11] then
				if isElement(sightlangStaticImage[11]) then
					destroyElement(sightlangStaticImage[11])
				end
				sightlangStaticImage[11] = nil
				sightlangStaticImageDel[11] = false
				sightlangStaticImageToc[11] = true
				return
			end
		else
			sightlangStaticImageDel[11] = now + 5000
		end
	else
		sightlangStaticImageToc[11] = true
	end
	if sightlangStaticImageUsed[12] then
		sightlangStaticImageUsed[12] = false
		sightlangStaticImageDel[12] = false
	elseif sightlangStaticImage[12] then
		if sightlangStaticImageDel[12] then
			if now >= sightlangStaticImageDel[12] then
				if isElement(sightlangStaticImage[12]) then
					destroyElement(sightlangStaticImage[12])
				end
				sightlangStaticImage[12] = nil
				sightlangStaticImageDel[12] = false
				sightlangStaticImageToc[12] = true
				return
			end
		else
			sightlangStaticImageDel[12] = now + 5000
		end
	else
		sightlangStaticImageToc[12] = true
	end
	if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] and sightlangStaticImageToc[5] and sightlangStaticImageToc[6] and sightlangStaticImageToc[7] and sightlangStaticImageToc[8] and sightlangStaticImageToc[9] and sightlangStaticImageToc[10] and sightlangStaticImageToc[11] and sightlangStaticImageToc[12] then
		sightlangStatImgHand = false
		removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
	end
end
processsightlangStaticImage[0] = function()
	if not isElement(sightlangStaticImage[0]) then
		sightlangStaticImageToc[0] = false
		sightlangStaticImage[0] = dxCreateTexture("files/screen.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/brake.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[2] = function()
	if not isElement(sightlangStaticImage[2]) then
		sightlangStaticImageToc[2] = false
		sightlangStaticImage[2] = dxCreateTexture("files/suspension.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[3] = function()
	if not isElement(sightlangStaticImage[3]) then
		sightlangStaticImageToc[3] = false
		sightlangStaticImage[3] = dxCreateTexture("files/kruton2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[4] = function()
	if not isElement(sightlangStaticImage[4]) then
		sightlangStaticImageToc[4] = false
		sightlangStaticImage[4] = dxCreateTexture("files/kruton.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[5] = function()
	if not isElement(sightlangStaticImage[5]) then
		sightlangStaticImageToc[5] = false
		sightlangStaticImage[5] = dxCreateTexture("files/tread.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[6] = function()
	if not isElement(sightlangStaticImage[6]) then
		sightlangStaticImageToc[6] = false
		sightlangStaticImage[6] = dxCreateTexture("files/steering.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[7] = function()
	if not isElement(sightlangStaticImage[7]) then
		sightlangStaticImageToc[7] = false
		sightlangStaticImage[7] = dxCreateTexture("files/print.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[8] = function()
	if not isElement(sightlangStaticImage[8]) then
		sightlangStaticImageToc[8] = false
		sightlangStaticImage[8] = dxCreateTexture("files/krutonicon.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[9] = function()
	if not isElement(sightlangStaticImage[9]) then
		sightlangStaticImageToc[9] = false
		sightlangStaticImage[9] = dxCreateTexture("files/alignoff.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[10] = function()
	if not isElement(sightlangStaticImage[10]) then
		sightlangStaticImageToc[10] = false
		sightlangStaticImage[10] = dxCreateTexture("files/wrench.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[11] = function()
	if not isElement(sightlangStaticImage[11]) then
		sightlangStaticImageToc[11] = false
		sightlangStaticImage[11] = dxCreateTexture("files/align.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[12] = function()
	if not isElement(sightlangStaticImage[12]) then
		sightlangStaticImageToc[12] = false
		sightlangStaticImage[12] = dxCreateTexture("files/swap.dds", "argb", true)
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
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		alignFont = sightexports.sGui:getFont("20/BebasNeueRegular.otf")
		alignFontScale = sightexports.sGui:getFontScale("20/BebasNeueRegular.otf")
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local endJobVeh = false
local endJobWindow = false
local inspectionWindow = false
local lastLift = 0
local liftId = false
local liftWindow = false
local lifting = false
addEvent("hideLiftGui", true)
addEventHandler("hideLiftGui", getRootElement(), function()
	if lifting and liftId then
		triggerServerEvent("stopCarLift", getRootElement(), liftId)
		lifting = false
	end
	liftId = false
	if liftWindow then
		sightexports.sGui:deleteGuiElement(liftWindow)
	end
	liftWindow = false
end)
addEvent("showLiftGui", true)
addEventHandler("showLiftGui", getRootElement(), function(i)
	liftId = i
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local panelWidth = 88
	local panelHeight = titleBarHeight + 32 + 8 + 8
	liftWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
	sightexports.sGui:setWindowTitle(liftWindow, "16/BebasNeueRegular.otf", "Emelő")
	local btn = sightexports.sGui:createGuiElement("button", 8, titleBarHeight + 8, 32, 32, liftWindow)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	})
	sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
	sightexports.sGui:setButtonTextColor(btn, "#000")
	sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("arrow-down", 32))
	sightexports.sGui:setClickEvent(btn, "startCarLiftDown")
	local btn = sightexports.sGui:createGuiElement("button", 48, titleBarHeight + 8, 32, 32, liftWindow)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	})
	sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
	sightexports.sGui:setButtonTextColor(btn, "#000")
	sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("arrow-up", 32))
	sightexports.sGui:setClickEvent(btn, "startCarLiftUp")
end)
addEvent("startCarLiftUp", true)
addEventHandler("startCarLiftUp", getRootElement(), function()
	if liftId and getTickCount() - lastLift > 1000 then
		lastLift = getTickCount()
		triggerServerEvent("startCarLiftUp", getRootElement(), liftId)
		lifting = true
	end
end)
addEvent("startCarLiftDown", true)
addEventHandler("startCarLiftDown", getRootElement(), function()
	if liftId and getTickCount() - lastLift > 1000 then
		lastLift = getTickCount()
		triggerServerEvent("startCarLiftDown", getRootElement(), liftId)
		lifting = true
	end
end)
local resetTmps = {}
function resetTmpStreamIn()
	if resetTmps[source] then
		local veh = resetTmps[source][1]
		if isElement(veh) and isElement(source) then
			local comp = resetTmps[source][2]
			if type(comp) == "table" then
				for i = 1, #comp do
					local x, y, z = getVehicleComponentPosition(source, comp[i])
					if x then
						setVehicleComponentPosition(veh, comp[i], x, y, z)
					end
				end
			else
				local x, y, z = getVehicleComponentPosition(source, comp)
				if x then
					setVehicleComponentPosition(veh, comp, x, y, z)
				end
			end
		end
	end
	destroyElement(source)
end
function resetVehicleComponentPosition(veh, comp)
	local x, y, z = getElementPosition(localPlayer)
	local model = exports.sVehiclemods:getCustomModel(getElementData(veh, "vehicle.customModel")) or getElementModel(veh)
	local tmp = createVehicle(model, x, y, z - 5)
	setElementCollisionsEnabled(tmp, false)
	setElementAlpha(tmp, 0)
	if isElement(tmp) then
		addEventHandler("onClientElementStreamIn", tmp, resetTmpStreamIn)
		resetTmps[tmp] = {veh, comp}
	end
end
local alignObj = false
local alignPoses = false
local wheelAlignCol = false
local alignmentSensors = {}
local alignmentSensorPoses = {}
local alignmentSensorPlaced = {}
local wheelAligned = {}
local laserPoses = {}
local inspectionBrakeSound = false
local inspectionShakerSound = false
local inspectionPad = false
local wheelShakerL = false
local wheelShakerR = false
local inspectionCol = false
local brakeInspectionPoses = {}
local shakerPoses = {}
local oilObject = false
local oilTexture
local canPlaceSensors = false
local wheelAlignVeh = false
local inspectionVeh = false
local inspectionState = 1
local wheelAlignRT = dxCreateRenderTarget(256, 166)
local wheelAlignShader = dxCreateShader("files/texturechanger.fx")
if wheelAlignShader then
	dxSetShaderValue(wheelAlignShader, "gTexture", wheelAlignRT)
	engineApplyShaderToWorldTexture(wheelAlignShader, "wheeladjust_screen")
end
local inspectionRT = dxCreateRenderTarget(256, 166)
local inspectionShader = dxCreateShader("files/texturechanger.fx")
if inspectionShader then
	dxSetShaderValue(inspectionShader, "gTexture", inspectionRT)
	engineApplyShaderToWorldTexture(inspectionShader, "inspection_screen")
end
local wheels = {
	"rf",
	"rb",
	"lf",
	"lb"
}
local wheelRotations = {0, 0}
local lastWheelSet = {}
local wheelCalibrated = {}
local placedSensorNum = 0
local pullingValue = false
local wheelCalibrationDone = false
addEvent("placeWheelAlignSensor", true)
addEventHandler("placeWheelAlignSensor", getRootElement(), function(veh, data)
	if veh == wheelAlignVeh then
		alignmentSensorPlaced = data
		for i = 1, 4 do
			if not alignmentSensorPlaced[i] then
				wheelCalibrationDone = false
				pullingValue = false
				wheelRotations = {0, 0}
				wheelCalibrated = {}
				return
			end
		end
	end
end)
addEvent("reCalibrateWheels", true)
addEventHandler("reCalibrateWheels", getRootElement(), function(veh)
	if veh == wheelAlignVeh then
		wheelCalibrationDone = false
		pullingValue = false
		wheelRotations = {0, 0}
		wheelCalibrated = {}
	end
end)
addEvent("alignWheelOnVehicle", true)
addEventHandler("alignWheelOnVehicle", getRootElement(), function(veh, data)
	if veh == wheelAlignVeh then
		for i = 1, 4 do
			if not data[i] then
				wheelAligned[i] = nil
			elseif not wheelAligned[i] then
				wheelAligned[i] = getTickCount()
			end
		end
	end
	if isElement(source) and isElementStreamedIn(source) then
		local x, y, z = getElementPosition(source)
		local sound = playSound3D("files/wheel.wav", x, y, z)
		attachElements(sound, source)
	end
end)
addEvent("wheelCalibrationDone", true)
addEventHandler("wheelCalibrationDone", getRootElement(), function(veh, pull)
	if veh == wheelAlignVeh then
		wheelCalibrationDone = true
		pullingValue = pull
	end
end)
local inspectionStartTick = 0
local canStartInspectState = false
local inspectionStarted = false
local inspectionStartTick = false
local inspectionHealths = {}
local coMeter = false
addEvent("vehicleInspectStateChange", true)
addEventHandler("vehicleInspectStateChange", getRootElement(), function(veh, state, started, hp)
	if veh == inspectionVeh and inspectionPad then
		local was = inspectionState
		inspectionState = state
		inspectionStarted = started
		if started then
			inspectionStartTick = getTickCount()
		end
		local rx, ry, rz = getElementRotation(inspectionPad)
		rz = math.rad(rz)
		local x, y, z = getElementPosition(inspectionPad)
		setElementPosition(wheelShakerL, x + math.cos(rz) * 0.916732, y + math.sin(rz) * 0.916732, z)
		setElementPosition(wheelShakerR, x + math.cos(rz) * -0.916732, y + math.sin(rz) * -0.916732, z)
		inspectionHealths = hp or {}
		if isElement(coMeter) then
			destroyElement(coMeter)
		end
		coMeter = false
		if isElement(inspectionSound) then
			destroyElement(inspectionSound)
		end
		if started then
			if state == 1 or state == 3 then
				inspectionBrakeSound = playSound3D("files/brakepad.mp3", brakeInspectionPoses[3][1], brakeInspectionPoses[3][2], brakeInspectionPoses[3][3])
				setSoundMaxDistance(inspectionBrakeSound, 50)
			elseif state == 2 or state == 4 then
				inspectionShakerSound = playSound3D("files/shaker.mp3", shakerPoses[3][1], shakerPoses[3][2], shakerPoses[3][3])
				setSoundMaxDistance(inspectionShakerSound, 50)
			elseif state == 5 then
				coMeter = createObject(objectModels.carbon_monoxide_meter, 0, 0, 0)
				setElementCollisionsEnabled(coMeter, false)
			end
		elseif state == 1 or state == 3 then
			if isElement(inspectionBrakeSound) then
				destroyElement(inspectionBrakeSound)
			end
			inspectionBrakeSound = false
		elseif state == 2 or state == 4 then
			if isElement(inspectionShakerSound) then
				destroyElement(inspectionShakerSound)
			end
			inspectionShakerSound = false
		end
	end
end)
local closestOnGround = false
local closestVeh = false
local examMode = false
addEvent("mechanicInspectionExam", true)
addEventHandler("mechanicInspectionExam", getRootElement(), function()
	sightexports.sChat:localActionC(localPlayer, "elkezd egy műszaki vizsgát.")
	examMode = true
	inspectionState = 1
	deleteInspectionWindow()
end)
addEvent("mechanicInspection", true)
addEventHandler("mechanicInspection", getRootElement(), function()
	sightexports.sChat:localActionC(localPlayer, "elkezd egy gépjármű átvizsgálást.")
	examMode = false
	inspectionState = 1
	deleteInspectionWindow()
end)
function mechanicRTRender()
	local now = getTickCount()
	dxSetRenderTarget(inspectionRT)
	local vehs = getElementsWithinColShape(inspectionCol, "vehicle")
	sightlangStaticImageUsed[0] = true
	if sightlangStaticImageToc[0] then
		processsightlangStaticImage[0]()
	end
	dxDrawImage(0, 0, 256, 166, sightlangStaticImage[0])
	if isElement(vehs[1]) then
		if inspectionVeh ~= vehs[1] then
			inspectionState = 0
			canStartInspectState = false
			inspectionStarted = false
			inspectionStartTick = false
			examMode = false
			inspectionHealths = {}
			inspectionVeh = vehs[1]
			if getVehicleController(inspectionVeh) == localPlayer then
				createInspectionWindow()
			end
		end
		local tmp = false
		if inspectionState == 1 then
			local wheelRX, wheelRY, wheelRZ = getVehicleComponentPosition(vehs[1], "wheel_rf_dummy", "world")
			local wheelLX, wheelLY, wheelLZ = getVehicleComponentPosition(vehs[1], "wheel_lf_dummy", "world")
			local d1 = getDistanceBetweenPoints2D(wheelRX, wheelRY, brakeInspectionPoses[1][1], brakeInspectionPoses[1][2])
			local d2 = getDistanceBetweenPoints2D(wheelLX, wheelLY, brakeInspectionPoses[2][1], brakeInspectionPoses[2][2])
			dxDrawText("Fék (első tengely):", 0, 0, 256, 40, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "center", "center")
			if inspectionStarted then
				dxDrawText("Mérés folyamatban...", 0, 50, 256, 80, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				local p = math.max(0, math.min(1, inspectionStartTick and (now - inspectionStartTick) / 14000 or 0))
				dxDrawRectangle(64, 95, 128, 20, tocolor(60, 179, 79, 100))
				dxDrawRectangle(64, 95, 128 * p, 20, tocolor(60, 179, 79))
			else
				if d2 < 0.25 then
					dxDrawText("BAL:\n#3cb34f\226\156\148", 0, 50, 128, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				else
					dxDrawText("BAL:\n#c93232\226\156\150", 0, 50, 128, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				end
				if d1 < 0.25 then
					dxDrawText("JOBB:\n#3cb34f\226\156\148", 128, 50, 256, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				else
					dxDrawText("JOBB:\n#c93232\226\156\150", 128, 50, 256, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				end
			end
			tmp = d1 < 0.25 and d2 < 0.25
		elseif inspectionState == 2 then
			local wheelRX, wheelRY, wheelRZ = getVehicleComponentPosition(vehs[1], "wheel_rf_dummy", "world")
			local wheelLX, wheelLY, wheelLZ = getVehicleComponentPosition(vehs[1], "wheel_lf_dummy", "world")
			local d1 = getDistanceBetweenPoints2D(wheelRX, wheelRY, shakerPoses[1][1], shakerPoses[1][2])
			local d2 = getDistanceBetweenPoints2D(wheelLX, wheelLY, shakerPoses[2][1], shakerPoses[2][2])
			dxDrawText("Futómű (első tengely):", 0, 0, 256, 40, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "center", "center")
			if inspectionStarted then
				local rnd = -0.05 + math.random(100) / 100 * 0.075
				local rx, ry, rz = getElementRotation(inspectionPad)
				rz = math.rad(rz)
				local x, y, z = getElementPosition(inspectionPad)
				setElementPosition(wheelShakerL, x + math.cos(rz) * 0.916732, y + math.sin(rz) * 0.916732, z - rnd)
				setElementPosition(wheelShakerR, x + math.cos(rz) * -0.916732, y + math.sin(rz) * -0.916732, z + rnd)
				dxDrawText("Mérés folyamatban...", 0, 50, 256, 80, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				local p = math.max(0, math.min(1, inspectionStartTick and (now - inspectionStartTick) / 10000 or 0))
				dxDrawRectangle(64, 95, 128, 20, tocolor(60, 179, 79, 100))
				dxDrawRectangle(64, 95, 128 * p, 20, tocolor(60, 179, 79))
			else
				if d2 < 0.25 then
					dxDrawText("BAL:\n#3cb34f\226\156\148", 0, 50, 128, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				else
					dxDrawText("BAL:\n#c93232\226\156\150", 0, 50, 128, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				end
				if d1 < 0.25 then
					dxDrawText("JOBB:\n#3cb34f\226\156\148", 128, 50, 256, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				else
					dxDrawText("JOBB:\n#c93232\226\156\150", 128, 50, 256, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				end
			end
			tmp = d1 < 0.25 and d2 < 0.25
		elseif inspectionState == 3 then
			local wheelRX, wheelRY, wheelRZ = getVehicleComponentPosition(vehs[1], "wheel_rb_dummy", "world")
			local wheelLX, wheelLY, wheelLZ = getVehicleComponentPosition(vehs[1], "wheel_lb_dummy", "world")
			local d1 = getDistanceBetweenPoints2D(wheelRX, wheelRY, brakeInspectionPoses[1][1], brakeInspectionPoses[1][2])
			local d2 = getDistanceBetweenPoints2D(wheelLX, wheelLY, brakeInspectionPoses[2][1], brakeInspectionPoses[2][2])
			dxDrawText("Fék (hátsó tengely):", 0, 0, 256, 40, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "center", "center")
			if inspectionStarted then
				dxDrawText("Mérés folyamatban...", 0, 50, 256, 80, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				local p = math.max(0, math.min(1, inspectionStartTick and (now - inspectionStartTick) / 14000 or 0))
				dxDrawRectangle(64, 95, 128, 20, tocolor(60, 179, 79, 100))
				dxDrawRectangle(64, 95, 128 * p, 20, tocolor(60, 179, 79))
			else
				if d2 < 0.25 then
					dxDrawText("BAL:\n#3cb34f\226\156\148", 0, 50, 128, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				else
					dxDrawText("BAL:\n#c93232\226\156\150", 0, 50, 128, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				end
				if d1 < 0.25 then
					dxDrawText("JOBB:\n#3cb34f\226\156\148", 128, 50, 256, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				else
					dxDrawText("JOBB:\n#c93232\226\156\150", 128, 50, 256, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				end
			end
			tmp = d1 < 0.25 and d2 < 0.25
		elseif inspectionState == 4 then
			local wheelRX, wheelRY, wheelRZ = getVehicleComponentPosition(vehs[1], "wheel_rb_dummy", "world")
			local wheelLX, wheelLY, wheelLZ = getVehicleComponentPosition(vehs[1], "wheel_lb_dummy", "world")
			local d1 = getDistanceBetweenPoints2D(wheelRX, wheelRY, shakerPoses[1][1], shakerPoses[1][2])
			local d2 = getDistanceBetweenPoints2D(wheelLX, wheelLY, shakerPoses[2][1], shakerPoses[2][2])
			dxDrawText("Futómű (hátsó tengely):", 0, 0, 256, 40, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "center", "center")
			if inspectionStarted then
				local rnd = -0.05 + math.random(100) / 100 * 0.075
				local rx, ry, rz = getElementRotation(inspectionPad)
				rz = math.rad(rz)
				local x, y, z = getElementPosition(inspectionPad)
				setElementPosition(wheelShakerL, x + math.cos(rz) * 0.916732, y + math.sin(rz) * 0.916732, z - rnd)
				setElementPosition(wheelShakerR, x + math.cos(rz) * -0.916732, y + math.sin(rz) * -0.916732, z + rnd)
				dxDrawText("Mérés folyamatban...", 0, 50, 256, 80, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				local p = math.max(0, math.min(1, inspectionStartTick and (now - inspectionStartTick) / 10000 or 0))
				dxDrawRectangle(64, 95, 128, 20, tocolor(60, 179, 79, 100))
				dxDrawRectangle(64, 95, 128 * p, 20, tocolor(60, 179, 79))
			else
				if d2 < 0.25 then
					dxDrawText("BAL:\n#3cb34f\226\156\148", 0, 50, 128, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				else
					dxDrawText("BAL:\n#c93232\226\156\150", 0, 50, 128, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				end
				if d1 < 0.25 then
					dxDrawText("JOBB:\n#3cb34f\226\156\148", 128, 50, 256, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				else
					dxDrawText("JOBB:\n#c93232\226\156\150", 128, 50, 256, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				end
			end
			tmp = d1 < 0.25 and d2 < 0.25
		elseif inspectionState == 5 then
			tmp = true
			dxDrawText("Károsanyag kibocsájtás:", 0, 0, 256, 40, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "center", "center")
			if inspectionStarted then
				dxDrawText("Mérés folyamatban...", 0, 50, 256, 80, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
				local p = math.max(0, math.min(1, inspectionStartTick and (now - inspectionStartTick) / 10000 or 0))
				dxDrawRectangle(64, 95, 128, 20, tocolor(60, 179, 79, 100))
				dxDrawRectangle(64, 95, 128 * p, 20, tocolor(60, 179, 79))
			end
			if coMeter then
				local x, y, z = getComponentPosition(inspectionVeh, "exhaust")
				local rx, ry, rz = getElementRotation(inspectionVeh)
				setElementPosition(coMeter, x, y, z)
				setElementRotation(coMeter, rx, ry, rz)
			end
		elseif inspectionState == 6 then
			dxDrawText("Hibakódok:", 0, 0, 256, 40, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "center", "center")
			dxDrawText("Csatlakozatsd az OBD\nscannert, és válaszd\na hibakód olvasást!", 0, 40, 256, 146, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "center", "center")
		elseif inspectionState == 7 then
			dxDrawText("Mérés kész #3cb34f\226\156\148", 0, 0, 256, 40, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "center", "center", false, false, false, true)
			local c = {
				255,
				255,
				255
			}
			if inspectionHealths[1] then
				c = getPartColor(inspectionHealths[1])
			end
			sightlangStaticImageUsed[1] = true
			if sightlangStaticImageToc[1] then
				processsightlangStaticImage[1]()
			end
			dxDrawImage(50, 47.5, 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(c[1], c[2], c[3]))
			local c = {
				255,
				255,
				255
			}
			if inspectionHealths[3] then
				c = getPartColor(inspectionHealths[3])
			end
			sightlangStaticImageUsed[2] = true
			if sightlangStaticImageToc[2] then
				processsightlangStaticImage[2]()
			end
			dxDrawImage(50, 71.5, 24, 24, sightlangStaticImage[2], 0, 0, 0, tocolor(c[1], c[2], c[3]))
			local c = {
				255,
				255,
				255
			}
			if inspectionHealths[2] then
				c = getPartColor(inspectionHealths[2])
			end
			sightlangStaticImageUsed[1] = true
			if sightlangStaticImageToc[1] then
				processsightlangStaticImage[1]()
			end
			dxDrawImage(50, 110.5, 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(c[1], c[2], c[3]))
			local c = {
				255,
				255,
				255
			}
			if inspectionHealths[5] then
				c = getPartColor(inspectionHealths[5])
			end
			sightlangStaticImageUsed[2] = true
			if sightlangStaticImageToc[2] then
				processsightlangStaticImage[2]()
			end
			dxDrawImage(50, 134.5, 24, 24, sightlangStaticImage[2], 0, 0, 0, tocolor(c[1], c[2], c[3]))
			local c = {
				255,
				255,
				255
			}
			if inspectionHealths[1] then
				c = getPartColor(inspectionHealths[1])
			end
			sightlangStaticImageUsed[1] = true
			if sightlangStaticImageToc[1] then
				processsightlangStaticImage[1]()
			end
			dxDrawImage(182, 47.5, 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(c[1], c[2], c[3]))
			local c = {
				255,
				255,
				255
			}
			if inspectionHealths[4] then
				c = getPartColor(inspectionHealths[4])
			end
			sightlangStaticImageUsed[2] = true
			if sightlangStaticImageToc[2] then
				processsightlangStaticImage[2]()
			end
			dxDrawImage(182, 71.5, 24, 24, sightlangStaticImage[2], 0, 0, 0, tocolor(c[1], c[2], c[3]))
			local c = {
				255,
				255,
				255
			}
			if inspectionHealths[2] then
				c = getPartColor(inspectionHealths[2])
			end
			sightlangStaticImageUsed[1] = true
			if sightlangStaticImageToc[1] then
				processsightlangStaticImage[1]()
			end
			dxDrawImage(182, 110.5, 24, 24, sightlangStaticImage[1], 0, 0, 0, tocolor(c[1], c[2], c[3]))
			local c = {
				255,
				255,
				255
			}
			if inspectionHealths[6] then
				c = getPartColor(inspectionHealths[6])
			end
			sightlangStaticImageUsed[2] = true
			if sightlangStaticImageToc[2] then
				processsightlangStaticImage[2]()
			end
			dxDrawImage(182, 134.5, 24, 24, sightlangStaticImage[2], 0, 0, 0, tocolor(c[1], c[2], c[3]))
			dxDrawText((inspectionHealths[1] or "n/a") .. "%\n" .. (inspectionHealths[3] or "n/a") .. "%", 80, 40, 0, 103, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "left", "center", false, false, false, true)
			dxDrawText((inspectionHealths[2] or "n/a") .. "%\n" .. (inspectionHealths[5] or "n/a") .. "%", 80, 103, 0, 166, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "left", "center", false, false, false, true)
			dxDrawText((inspectionHealths[1] or "n/a") .. "%\n" .. (inspectionHealths[4] or "n/a") .. "%", 0, 40, 176, 103, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "right", "center", false, false, false, true)
			dxDrawText((inspectionHealths[2] or "n/a") .. "%\n" .. (inspectionHealths[6] or "n/a") .. "%", 0, 103, 176, 166, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "right", "center", false, false, false, true)
		end
		if 1 <= inspectionState and inspectionState <= 5 then
			if getVehicleController(inspectionVeh) == localPlayer then
				if tmp ~= canStartInspectState then
					canStartInspectState = tmp
					inspectionStartTick = now
				end
				if inspectionStartTick then
					if canStartInspectState and 1500 < now - inspectionStartTick then
						if not inspectionStarted then
							inspectionStarted = true
							inspectionStartTick = false
							triggerServerEvent("vehicleInspectStateChange", localPlayer, inspectionVeh, inspectionState, true, examMode)
						else
							local t = 10000
							if inspectionState == 1 or inspectionState == 3 then
								t = 14000
							end
							if inspectionStartTick and t < now - inspectionStartTick then
								inspectionStarted = false
								canStartInspectState = false
								inspectionStartTick = false
								triggerServerEvent("vehicleInspectStateChange", localPlayer, inspectionVeh, inspectionState + 1, inspectionState + 1 == 5, examMode)
								inspectionState = inspectionState + 1
							end
						end
					elseif not canStartInspectState and inspectionStarted then
						inspectionStarted = false
						triggerServerEvent("vehicleInspectStateChange", localPlayer, inspectionVeh, inspectionState, false, examMode)
					end
				end
			end
			sightlangStaticImageUsed[3] = true
			if sightlangStaticImageToc[3] then
				processsightlangStaticImage[3]()
			end
			dxDrawImage(0, 0, 256, 166, sightlangStaticImage[3])
		elseif 6 <= inspectionState and inspectionState <= 7 then
			sightlangStaticImageUsed[3] = true
			if sightlangStaticImageToc[3] then
				processsightlangStaticImage[3]()
			end
			dxDrawImage(0, 0, 256, 166, sightlangStaticImage[3])
		else
			sightlangStaticImageUsed[4] = true
			if sightlangStaticImageToc[4] then
				processsightlangStaticImage[4]()
			end
			dxDrawImage(0, 0, 256, 166, sightlangStaticImage[4])
		end
	else
		if inspectionVeh then
			deleteInspectionWindow()
			if getVehicleController(inspectionVeh) == localPlayer then
				triggerServerEvent("vehicleInspectStateChange", localPlayer, inspectionVeh, false, false)
			end
			inspectionState = 1
			inspectionStarted = false
			canStartInspectState = false
			inspectionVeh = false
			inspectionStartTick = false
			inspectionHealths = {}
			if isElement(inspectionBrakeSound) then
				destroyElement(inspectionBrakeSound)
			end
			inspectionBrakeSound = false
			if isElement(inspectionShakerSound) then
				destroyElement(inspectionShakerSound)
			end
			inspectionShakerSound = false
			if isElement(coMeter) then
				destroyElement(coMeter)
			end
			coMeter = false
		end
		sightlangStaticImageUsed[4] = true
		if sightlangStaticImageToc[4] then
			processsightlangStaticImage[4]()
		end
		dxDrawImage(0, 0, 256, 166, sightlangStaticImage[4])
	end
	dxSetRenderTarget(wheelAlignRT)
	local vehs = getElementsWithinColShape(wheelAlignCol, "vehicle")
	sightlangStaticImageUsed[0] = true
	if sightlangStaticImageToc[0] then
		processsightlangStaticImage[0]()
	end
	dxDrawImage(0, 0, 256, 166, sightlangStaticImage[0])
	if isElement(vehs[1]) then
		if wheelAlignVeh ~= vehs[1] then
			if isElement(wheelAlignVeh) and getVehicleController(wheelAlignVeh) == localPlayer then
				triggerServerEvent("resetVehicleWheelAlign", localPlayer)
			end
			wheelCalibrationDone = false
			wheelRotations = {0, 0}
			lastWheelSet = {}
			wheelCalibrated = {}
			placedSensorNum = 0
			pullingValue = false
			alignmentSensorPlaced = {}
			wheelAligned = {}
			wheelAlignVeh = vehs[1]
		end
		local wheelRX, wheelRY, wheelRZ = getVehicleComponentPosition(vehs[1], "wheel_rf_dummy", "world")
		local wheelLX, wheelLY, wheelLZ = getVehicleComponentPosition(vehs[1], "wheel_lf_dummy", "world")
		local wheelRRX, wheelRRY, wheelRRZ = getVehicleComponentRotation(vehs[1], "wheel_rf_dummy")
		local wheelLRX, wheelLRY, wheelLRZ = getVehicleComponentRotation(vehs[1], "wheel_lf_dummy")
		wheelLRZ = wheelLRZ - 180
		if 180 < wheelRRZ then
			wheelRRZ = wheelRRZ - 360
		else
		end
		rz = -(wheelLRZ + wheelRRZ)
		local d1 = getDistanceBetweenPoints2D(wheelRX, wheelRY, alignPoses[1][1], alignPoses[1][2])
		local d2 = getDistanceBetweenPoints2D(wheelLX, wheelLY, alignPoses[2][1], alignPoses[2][2])
		if d1 < 0.25 and d2 < 0.25 then
			canPlaceSensors = true
		else
			canPlaceSensors = false
		end
		if wheelCalibrated[1] and wheelCalibrated[2] and getTickCount() - lastWheelSet[1] > 2000 and getTickCount() - lastWheelSet[2] > 2000 and not wheelCalibrationDone and getVehicleController(wheelAlignVeh) == localPlayer then
			wheelCalibrationDone = true
			triggerServerEvent("wheelCalibrationDone", localPlayer, wheelAlignVeh)
		end
		if wheelCalibrationDone and pullingValue then
			local col = tocolor(42, 42, 226)
			local deg = pullingValue[1] / 100 * 16 * (1 + pullingValue[2] / 100)
			if not wheelAligned[3] then
				col = 1 < math.abs(deg) and tocolor(201, 50, 50) or tocolor(60, 179, 79)
			else
				col = tocolor(42, 42, 226)
			end
			local lx = math.cos(math.rad(deg) - math.pi / 2) * 25
			local ly = math.sin(math.rad(deg) - math.pi / 2) * 25
			dxDrawLine(96 + lx, 36 + ly, 96, 36, col, 2)
			sightlangStaticImageUsed[5] = true
			if sightlangStaticImageToc[5] then
				processsightlangStaticImage[5]()
			end
			dxDrawImage(84, 24, 24, 24, sightlangStaticImage[5], deg, 0, 0, col)
			deg = math.floor(deg * 100) / 100
			if 0 < deg then
				deg = "+" .. deg
			end
			if wheelAligned[3] then
				dxDrawText("? ", 0, 36, 84, 36, col, alignFontScale * 0.5, alignFont, "right", "center")
			else
				dxDrawText(deg .. "° ", 0, 36, 84, 36, col, alignFontScale * 0.5, alignFont, "right", "center")
			end
			local deg = pullingValue[1] / 100 * 16 * (1 + pullingValue[4] / 100)
			if not wheelAligned[1] then
				col = 1 < math.abs(deg) and tocolor(201, 50, 50) or tocolor(60, 179, 79)
			else
				col = tocolor(42, 42, 226)
			end
			local lx = math.cos(math.rad(deg) - math.pi / 2) * 25
			local ly = math.sin(math.rad(deg) - math.pi / 2) * 25
			dxDrawLine(160 + lx, 36 + ly, 160, 36, col, 2)
			sightlangStaticImageUsed[5] = true
			if sightlangStaticImageToc[5] then
				processsightlangStaticImage[5]()
			end
			dxDrawImage(148, 24, 24, 24, sightlangStaticImage[5], deg, 0, 0, col)
			deg = math.floor(deg * 100) / 100
			if 0 < deg then
				deg = "+" .. deg
			end
			if wheelAligned[1] then
				dxDrawText(" ?", 172, 36, 0, 36, col, alignFontScale * 0.5, alignFont, "left", "center")
			else
				dxDrawText(" " .. deg .. "°", 172, 36, 0, 36, col, alignFontScale * 0.5, alignFont, "left", "center")
			end
			local deg = pullingValue[1] / 100 * 32
			col = 1 < math.abs(deg) and tocolor(201, 50, 50) or tocolor(60, 179, 79)
			local lx = math.cos(math.rad(deg) - math.pi / 2) * 45
			local ly = math.sin(math.rad(deg) - math.pi / 2) * 45
			dxDrawLine(128 + lx, 60 + ly, 128, 60, col, 2)
			sightlangStaticImageUsed[6] = true
			if sightlangStaticImageToc[6] then
				processsightlangStaticImage[6]()
			end
			dxDrawImage(116, 48, 24, 24, sightlangStaticImage[6], deg, 0, 0, col)
			deg = math.floor(deg * 100) / 100
			if 0 < deg then
				deg = "+" .. deg
			end
			dxDrawText(deg .. "°", 128, 76, 128, 0, col, alignFontScale * 0.5, alignFont, "center", "top")
			local deg = pullingValue[1] / 100 * 16 * (1 + pullingValue[3] / 100)
			if not wheelAligned[4] then
				col = 1 < math.abs(deg) and tocolor(201, 50, 50) or tocolor(60, 179, 79)
			else
				col = tocolor(42, 42, 226)
			end
			local lx = math.cos(math.rad(deg) - math.pi / 2) * 25
			local ly = math.sin(math.rad(deg) - math.pi / 2) * 25
			dxDrawLine(96 + lx, 130 + ly, 96, 130, col, 2)
			sightlangStaticImageUsed[5] = true
			if sightlangStaticImageToc[5] then
				processsightlangStaticImage[5]()
			end
			dxDrawImage(84, 118, 24, 24, sightlangStaticImage[5], deg, 0, 0, col)
			deg = math.floor(deg * 100) / 100
			if 0 < deg then
				deg = "+" .. deg
			end
			if wheelAligned[4] then
				dxDrawText("? ", 0, 130, 84, 130, col, alignFontScale * 0.5, alignFont, "right", "center")
			else
				dxDrawText(deg .. "° ", 0, 130, 84, 130, col, alignFontScale * 0.5, alignFont, "right", "center")
			end
			local deg = pullingValue[1] / 100 * 16 * (1 + pullingValue[5] / 100)
			if not wheelAligned[2] then
				col = 1 < math.abs(deg) and tocolor(201, 50, 50) or tocolor(60, 179, 79)
			else
				col = tocolor(42, 42, 226)
			end
			local lx = math.cos(math.rad(deg) - math.pi / 2) * 25
			local ly = math.sin(math.rad(deg) - math.pi / 2) * 25
			dxDrawLine(160 + lx, 130 + ly, 160, 130, col, 2)
			sightlangStaticImageUsed[5] = true
			if sightlangStaticImageToc[5] then
				processsightlangStaticImage[5]()
			end
			dxDrawImage(148, 118, 24, 24, sightlangStaticImage[5], deg, 0, 0, col)
			deg = math.floor(deg * 100) / 100
			if 0 < deg then
				deg = "+" .. deg
			end
			if wheelAligned[2] then
				dxDrawText(" ?", 172, 130, 0, 130, col, alignFontScale * 0.5, alignFont, "left", "center")
			else
				dxDrawText(" " .. deg .. "°", 172, 130, 0, 130, col, alignFontScale * 0.5, alignFont, "left", "center")
			end
		elseif placedSensorNum == 4 then
			local crz = math.floor(rz)
			dxDrawText("Kalibrálás:", 0, 0, 256, 40, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "center", "center")
			sightlangStaticImageUsed[6] = true
			if sightlangStaticImageToc[6] then
				processsightlangStaticImage[6]()
			end
			dxDrawImage(96, 50, 64, 64, sightlangStaticImage[6], rz)
			if wheelCalibrated[2] and wheelCalibrated[1] then
				dxDrawText("#3cb34f\226\156\148 Kész", 0, 114, 256, 166, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "center", "center", false, false, false, true)
			elseif wheelCalibrated[2] then
				dxDrawText("<< Tekerd balra", 0, 114, 256, 166, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "center", "center")
			else
				dxDrawText("Tekerd jobbra >>", 0, 114, 256, 166, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "center", "center")
			end
			local lx = math.cos(math.rad(rz) - math.pi / 2) * 45
			local ly = math.sin(math.rad(rz) - math.pi / 2) * 45
			dxDrawLine(128 + lx, 82 + ly, 128, 82, tocolor(255, 255, 255), 2)
			for i = 1, 2 do
				local lx = math.cos(math.rad(wheelRotations[i]) - math.pi / 2) * 45
				local ly = math.sin(math.rad(wheelRotations[i]) - math.pi / 2) * 45
				if wheelCalibrated[i] then
					dxDrawLine(128 + lx, 82 + ly, 128, 82, tocolor(60, 179, 79), 2)
				else
					dxDrawLine(128 + lx, 82 + ly, 128, 82, tocolor(255, 255, 255), 2)
				end
			end
			if crz < wheelRotations[1] then
				wheelRotations[1] = crz
				lastWheelSet[1] = now
			elseif wheelRotations[1] < -5 and now - lastWheelSet[1] > 500 then
				wheelCalibrated[1] = true
			end
			if crz > wheelRotations[2] then
				wheelRotations[2] = crz
				lastWheelSet[2] = now
			elseif wheelRotations[2] > 5 and now - lastWheelSet[2] > 500 then
				wheelCalibrated[2] = true
			end
			if not wheelCalibrated[1] then
				wheelRotations[1] = crz
			end
			if not wheelCalibrated[2] then
				wheelRotations[2] = crz
			end
		elseif 0 < placedSensorNum then
			dxDrawText("Szenzorok:", 0, 0, 256, 40, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "center", "center")
			dxDrawText(placedSensorNum .. "/4", 0, 50, 256, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
			wheelRotations = {0, 0}
			wheelCalibrated = {}
		else
			dxDrawText("Első kerekek helyzete:", 0, 0, 256, 40, tocolor(255, 255, 255), alignFontScale * 0.75, alignFont, "center", "center")
			if d2 < 0.25 then
				dxDrawText("BAL:\n#3cb34f\226\156\148", 0, 50, 128, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
			else
				dxDrawText("BAL:\n#c93232\226\156\150", 0, 50, 128, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
			end
			if d1 < 0.25 then
				dxDrawText("JOBB:\n#3cb34f\226\156\148", 128, 50, 256, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
			else
				dxDrawText("JOBB:\n#c93232\226\156\150", 128, 50, 256, 120, tocolor(255, 255, 255), alignFontScale, alignFont, "center", "center", false, false, false, true)
			end
		end
		sightlangStaticImageUsed[3] = true
		if sightlangStaticImageToc[3] then
			processsightlangStaticImage[3]()
		end
		dxDrawImage(0, 0, 256, 166, sightlangStaticImage[3])
	else
		if wheelAlignVeh then
			if isElement(wheelAlignVeh) and getVehicleController(wheelAlignVeh) == localPlayer then
				triggerServerEvent("resetVehicleWheelAlign", localPlayer)
			end
			wheelCalibrationDone = false
			wheelRotations = {0, 0}
			lastWheelSet = {}
			wheelCalibrated = {}
			placedSensorNum = 0
			pullingValue = false
			alignmentSensorPlaced = {}
			wheelAligned = {}
		end
		wheelAlignVeh = false
		sightlangStaticImageUsed[4] = true
		if sightlangStaticImageToc[4] then
			processsightlangStaticImage[4]()
		end
		dxDrawImage(0, 0, 256, 166, sightlangStaticImage[4])
	end
	local rx, ry, rz = getElementRotation(alignObj)
	placedSensorNum = 0
	for i = 1, #alignmentSensors do
		if wheelAlignVeh and alignmentSensorPlaced[i] then
			placedSensorNum = placedSensorNum + 1
			local x, y, z = getVehicleComponentPosition(wheelAlignVeh, "wheel_" .. wheels[i] .. "_dummy", "world")
			local rx, ry, rz = getVehicleComponentRotation(wheelAlignVeh, "wheel_" .. wheels[i] .. "_dummy", "world")
			setElementPosition(alignmentSensors[i], x, y, z)
			setElementRotation(alignmentSensors[i], math.ceil(i / 2) * 180, ry, rz + 180)
			local r1 = math.rad(rz)
			if 2 < i then
				dxDrawLine3D(laserPoses[math.ceil(i / 2)][1], laserPoses[math.ceil(i / 2)][2], laserPoses[math.ceil(i / 2)][3], x + math.cos(r1) * 0.35 + math.cos(r1 - math.pi / 2) * 0.025, y + math.sin(r1) * 0.35 + math.sin(r1 - math.pi / 2) * 0.025, z, tocolor(255, 0, 0, 25 + math.random(75)), 0.75)
			else
				dxDrawLine3D(laserPoses[math.ceil(i / 2)][1], laserPoses[math.ceil(i / 2)][2], laserPoses[math.ceil(i / 2)][3], x + math.cos(r1) * 0.35 + math.cos(r1 + math.pi / 2) * 0.025, y + math.sin(r1) * 0.35 + math.sin(r1 + math.pi / 2) * 0.025, z, tocolor(255, 0, 0, 25 + math.random(75)), 0.75)
			end
		else
			setElementPosition(alignmentSensors[i], alignmentSensorPoses[i][1], alignmentSensorPoses[i][2], alignmentSensorPoses[i][3])
			setElementRotation(alignmentSensors[i], rx, ry, rz + 193 + math.ceil(i / 2) * 180)
		end
	end
	dxSetRenderTarget()
end
local immaterialsSelected = {}
screwingWheel = false
local screwMinigame = false
local titleBarHeight = false
local panelWidth, panelHeight = false, false
local orderWindow = false
local loadingRect = false
local loadingIcon = false
currentWorkshop = false
currentWorkshopPerm = false
function getCurrentWorkshopGroup()
	return currentWorkshop and workshops[currentWorkshop][7]
end
local selectedManufacturer = false
local selectedModel = false
local selectedCategory = false
local selectedPart = false
local manufacturerButtons = {}
local modelButtons = {}
local categoryButtons = {}
local partButtons = {}
local partCheckboxes = {}
local topSelectedLabel = false
local mechanicMinigameObject = false
local engineParts = {}
local vehicleObjects = {}
local wheelsOff = {}
local originalWheelsOff = {}
local wheelOffInterpolation = {}
local tireSide = {}
local lastClickedWheel = false
local hoveredWheel = false
local hoveredPart = false
repairingPart = false
local repairingResponse = false
local partAnimation = false
local originalState = {}
local spectatorStates = {}
local spectatorFunctions = {}
local repairJobs = {}
local repairParts = {}
local categories = {}
local manufacturerScroll = 0
local modelScroll = 0
local orderScroll = 0
local lastOrderScroll = 0
local mechanicMenus = {
	"Új rendelés",
	"Rendelések követése"
}
local currentMenu = 2
local menuButtons = {}
local manufacturerBar = false
local modelBar = false
local orderBar = false
local sendingOffer = false
local marginButtons = {}
local wageButtons = {}
local selectedPriceMargin = 1
local selectedWage = 1
local priceMargins = basePriceMargins
local wages = baseWages
for k, v in pairs(partCategories) do
	table.insert(categories, k)
end
table.sort(categories)
local carPartElements = {}
local carBar = false
local carPartsList = {}
local carPartSwap = {}
local unlistedPartsEx = {}
local unlistedParts = ""
local carPartsScroll = 0
local carScrollNum = 0
local smallPw = false
local smallPh = false
local carWindow = false
local offerTotal = 0
local offerList = {}
local offerBar = false
local offerScroll = 0
local offerWindow = false
function resetVehicleMechanicData(veh)
	if isElement(veh) then
		setElementAlpha(veh, 255)
		if repairingPart and repairingPart[1] == veh then
			repairingPart = false
			createMinigameObj(false)
		end
		if screwMinigame and screwMinigame[1] == veh then
			screwMinigame = false
		end
		if partAnimation and partAnimation[1] == veh then
			partAnimation = false
		end
		setVehicleComponentVisible(veh, "wheel_lf_dummy", true)
		setVehicleComponentVisible(veh, "wheel_rf_dummy", true)
		setVehicleComponentVisible(veh, "wheel_lb_dummy", true)
		setVehicleComponentVisible(veh, "wheel_rb_dummy", true)
		if veh == closestVeh then
			closestVeh = false
			createVehicleObjects(false)
			createMinigameObj(false)
			resetVehicleComponentPosition(veh, {
				"bump_front_dummy",
				"bump_rear_dummy",
				"bonnet_dummy",
				"boot_dummy",
				"door_lf_dummy",
				"door_rf_dummy",
				"door_lr_dummy",
				"door_rr_dummy"
			})
		end
		spectatorStates[veh] = nil
		carPartSwap[veh] = nil
		repairParts[veh] = nil
		repairJobs[veh] = nil
		wheelOffInterpolation[veh] = nil
		wheelsOff[veh] = nil
	end
end
addEvent("resetVehicleMechanicData", true)
addEventHandler("resetVehicleMechanicData", getRootElement(), resetVehicleMechanicData)
local vehDbIdCache = {}
addEventHandler("onClientVehicleDestroy", getRootElement(), function()
	resetVehicleMechanicData(source)
	vehDbIdCache[source] = nil
end)
addEventHandler("onClientVehicleStreamOut", getRootElement(), function()
	vehDbIdCache[source] = nil
end)
local hexSizes = {
	8,
	10,
	12,
	13,
	14,
	15,
	17,
	19
}
currentHexSize = false
local hexWindow = false
local hexButtons = {}
local krutonObjects = {}
local printTexture = false
addEvent("playerWorkshopChange", true)
addEventHandler("playerWorkshopChange", getRootElement(), function(ws)
	if not currentWorkshop and ws then
		for i = 1, #workshops[ws][6] - 2 do
			if workshops[ws][6][i][4] then
				local rz = workshops[ws][6][i][4] + 180
				local x, y, z = workshops[ws][6][i][1], workshops[ws][6][i][2], workshops[ws][6][i][3] - 1
				local obj = createObject(objectModels.kruton, x, y, z, 0, 0, rz)
				setElementDoubleSided(obj, true)
				table.insert(krutonObjects, obj)
			end
		end
		local rz = workshops[ws][4][4]
		local x, y, z = workshops[ws][4][1], workshops[ws][4][2], workshops[ws][4][3]
		if isElement(inspectionPad) then
			destroyElement(inspectionPad)
		end
		inspectionPad = createObject(objectModels.inspection_pad, x, y, z, 0, 0, rz)
		setElementDoubleSided(inspectionPad, true)
		if isElement(wheelShakerL) then
			destroyElement(wheelShakerL)
		end
		wheelShakerL = createObject(objectModels.inspection_pad2, x + math.cos(math.rad(rz)) * 0.916732, y + math.sin(math.rad(rz)) * 0.916732, z, 0, 0, rz)
		if isElement(wheelShakerR) then
			destroyElement(wheelShakerR)
		end
		wheelShakerR = createObject(objectModels.inspection_pad2, x + math.cos(math.rad(rz)) * -0.916732, y + math.sin(math.rad(rz)) * -0.916732, z, 0, 0, rz)
		brakeInspectionPoses = {
			{
				getPositionFromElementOffset(inspectionPad, 0.914893, -3.13167, 0.125933)
			},
			{
				getPositionFromElementOffset(inspectionPad, -0.914893, -3.13167, 0.125933)
			},
			{
				getPositionFromElementOffset(inspectionPad, 0, -3.13167, 0.125933)
			}
		}
		shakerPoses = {
			{
				getPositionFromElementOffset(inspectionPad, 0.914893, -2.09859, 0.125933)
			},
			{
				getPositionFromElementOffset(inspectionPad, -0.914893, -2.09859, 0.125933)
			},
			{
				getPositionFromElementOffset(inspectionPad, 0, -2.09859, 0.125933)
			}
		}
		local x1, y1 = getPositionFromElementOffset(inspectionPad, 1.32242, 3.6, 0.15)
		local x2, y2 = getPositionFromElementOffset(inspectionPad, 1.32242, -7, 0.15)
		local x3, y3 = getPositionFromElementOffset(inspectionPad, -1.32242, -7, 0.15)
		local x4, y4 = getPositionFromElementOffset(inspectionPad, -1.32242, 3.6, 0.15)
		if isElement(inspectionCol) then
			destroyElement(inspectionCol)
		end
		inspectionCol = createColPolygon(x1, y1, x1, y1, x2, y2, x3, y3, x4, y4)
		local rz = workshops[ws][5][4]
		local x, y, z = workshops[ws][5][1], workshops[ws][5][2], workshops[ws][5][3]
		if isElement(alignObj) then
			destroyElement(alignObj)
		end
		alignObj = createObject(objectModels.wheel_align_machine, x, y, z, 0, 0, rz)
		setElementDoubleSided(alignObj, true)
		alignPoses = {
			{
				getPositionFromElementOffset(alignObj, 0.916732, 2.30897, 0.15)
			},
			{
				getPositionFromElementOffset(alignObj, -0.916732, 2.30897, 0.15)
			}
		}
		alignmentSensorPoses = {
			{
				getPositionFromElementOffset(alignObj, -1.57297, 5.20453, 0.44764)
			},
			{
				getPositionFromElementOffset(alignObj, -1.57297, 5.20453, 0.942951)
			},
			{
				getPositionFromElementOffset(alignObj, -0.890815, 5.35563, 0.44764)
			},
			{
				getPositionFromElementOffset(alignObj, -0.890815, 5.35563, 0.942951)
			}
		}
		laserPoses = {
			{
				getPositionFromElementOffset(alignObj, 1.34162, 5.78047, 2.67497)
			},
			{
				getPositionFromElementOffset(alignObj, -1.29176, 5.78047, 2.67497)
			}
		}
		local x1, y1 = getPositionFromElementOffset(alignObj, 1.32242, 3.6, 0.15)
		local x2, y2 = getPositionFromElementOffset(alignObj, 1.32242, -3.6, 0.15)
		local x3, y3 = getPositionFromElementOffset(alignObj, -1.32242, -3.6, 0.15)
		local x4, y4 = getPositionFromElementOffset(alignObj, -1.32242, 3.6, 0.15)
		if isElement(wheelAlignCol) then
			destroyElement(wheelAlignCol)
		end
		wheelAlignCol = createColPolygon(x1, y1, x1, y1, x2, y2, x3, y3, x4, y4)
		for i = 1, #alignmentSensors do
			if isElement(alignmentSensors[i]) then
				destroyElement(alignmentSensors[i])
			end
		end
		alignmentSensors = {}
		local obj = createObject(objectModels.wheel_align_machine2, x, y, z)
		setElementCollisionsEnabled(obj, false)
		table.insert(alignmentSensors, obj)
		local obj = createObject(objectModels.wheel_align_machine2, x, y, z)
		setElementCollisionsEnabled(obj, false)
		table.insert(alignmentSensors, obj)
		local obj = createObject(objectModels.wheel_align_machine2, x, y, z)
		setElementCollisionsEnabled(obj, false)
		table.insert(alignmentSensors, obj)
		local obj = createObject(objectModels.wheel_align_machine2, x, y, z)
		setElementCollisionsEnabled(obj, false)
		table.insert(alignmentSensors, obj)
		sightexports.sWeapons:setWrenchState(currentHexSize)
		addEventHandler("onClientRender", getRootElement(), mechanicRender)
		addEventHandler("onClientKey", getRootElement(), scrollKey)
		addEventHandler("onClientClick", getRootElement(), mechanicClick, true, "high+99999999")
		carPartSwap = {}
		repairJobs = {}
		repairParts = {}
		partHealthCache = {}
		triggerServerEvent("requestWorkshopCache", localPlayer, ws)
	elseif currentWorkshop and not ws then
		if isElement(inspectionCol) then
			destroyElement(inspectionCol)
		end
		inspectionCol = nil
		if isElement(wheelAlignCol) then
			destroyElement(wheelAlignCol)
		end
		wheelAlignCol = nil
		if isElement(inspectionPad) then
			destroyElement(inspectionPad)
		end
		inspectionPad = nil
		if isElement(wheelShakerL) then
			destroyElement(wheelShakerL)
		end
		wheelShakerL = nil
		if isElement(wheelShakerR) then
			destroyElement(wheelShakerR)
		end
		wheelShakerR = nil
		if isElement(alignObj) then
			destroyElement(alignObj)
		end
		alignObj = nil
		for i = 1, #alignmentSensors do
			if isElement(alignmentSensors[i]) then
				destroyElement(alignmentSensors[i])
			end
		end
		alignmentSensors = {}
		for i = 1, #krutonObjects do
			if isElement(krutonObjects[i]) then
				destroyElement(krutonObjects[i])
			end
		end
		krutonObjects = {}
		sightexports.sWeapons:setWrenchState(false)
		removeEventHandler("onClientRender", getRootElement(), mechanicRender)
		removeEventHandler("onClientKey", getRootElement(), scrollKey)
		removeEventHandler("onClientClick", getRootElement(), mechanicClick)
		if repairingPart then
			repairingPart = false
			createMinigameObj(false)
		end
		if screwMinigame then
			screwMinigame = false
		end
		if partAnimation then
			partAnimation = false
		end
		for veh in pairs(wheelsOff) do
			if isElement(veh) then
				for wheel = 1, #wheelsOff[veh] do
					if wheelsOff[veh][wheel] then
						local comp = false
						if wheel == 1 then
							comp = "wheel_lf_dummy"
						elseif wheel == 2 then
							comp = "wheel_rf_dummy"
						elseif wheel == 3 then
							comp = "wheel_lb_dummy"
						elseif wheel == 4 then
							comp = "wheel_rb_dummy"
						end
						resetVehicleComponentPosition(veh, comp)
						setVehicleComponentVisible(veh, comp, true)
					end
				end
			end
		end
		wheelsOff = {}
		wheelOffInterpolation = {}
		for veh in pairs(spectatorStates) do
			if isElement(veh) then
				resetVehicleComponentPosition(veh, "bump_front_dummy")
				resetVehicleComponentPosition(veh, "bump_rear_dummy")
				resetVehicleComponentPosition(veh, "bonnet_dummy")
				resetVehicleComponentPosition(veh, "boot_dummy")
				resetVehicleComponentPosition(veh, "door_lf_dummy")
				resetVehicleComponentPosition(veh, "door_rf_dummy")
				resetVehicleComponentPosition(veh, "door_lr_dummy")
				resetVehicleComponentPosition(veh, "door_rr_dummy")
			end
		end
		spectatorStates = {}
		carPartSwap = {}
		repairJobs = {}
		repairParts = {}
		partHealthCache = {}
		deleteCarWindow()
		deleteMechanicOrderGui()
		deleteOfferWindow()
		deleteCarEndWindow()
		deleteInspectionWindow()
	end
	currentWorkshop = ws
	checkWorkshopPerm()
end)
spectatorFunctions.frontTires = {}
spectatorFunctions.rearTires = {}
spectatorFunctions.frontBrakes = {}
spectatorFunctions.rearBrakes = {}
spectatorFunctions.frontLeftSuspension = {}
spectatorFunctions.frontRightSuspension = {}
spectatorFunctions.rearLeftSuspension = {}
spectatorFunctions.rearRightSuspension = {}
spectatorFunctions.frontBumper = {}
spectatorFunctions.rearBumper = {}
spectatorFunctions.hood = {}
spectatorFunctions.trunk = {}
spectatorFunctions.frontLeftDoor = {}
spectatorFunctions.frontRightDoor = {}
spectatorFunctions.rearLeftDoor = {}
spectatorFunctions.rearRightDoor = {}
spectatorFunctions.frontLeftLight = {}
spectatorFunctions.frontRightLight = {}
spectatorFunctions.rearLeftLight = {}
spectatorFunctions.rearRightLight = {}
spectatorFunctions.oilChangeKit = {}
spectatorFunctions.engineTimingKit = {}
spectatorFunctions.engineRepairKit = {}
spectatorFunctions.engineGeneralKit = {}
spectatorFunctions.battery = {}
spectatorFunctions.engineRepairKit[1] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		createMinigameObj("engine")
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"valve",
			false,
			false,
			true,
			{
				1,
				1,
				1,
				1,
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1,
				1,
				1,
				1,
				1
			}
		}
	end
end
spectatorFunctions.engineRepairKit[2] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"valveoff",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineRepairKit[3] = function()
	if isElement(engineParts.valve_cover) then
		destroyElement(engineParts.valve_cover)
	end
	engineParts.valve_cover = nil
	if isElement(engineParts.valve_gasket) then
		destroyElement(engineParts.valve_gasket)
	end
	engineParts.valve_gasket = nil
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"timing",
		false,
		false,
		true,
		{
			1,
			1,
			1
		},
		{
			1,
			1,
			1
		}
	}
end
spectatorFunctions.engineRepairKit[4] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"timingoff",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineRepairKit[5] = function()
	if isElement(engineParts.timing_belt) then
		destroyElement(engineParts.timing_belt)
	end
	engineParts.timing_belt = nil
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"head",
		false,
		false,
		true,
		{
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
		},
		{
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
	}
end
spectatorFunctions.engineRepairKit[6] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"headoff",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineRepairKit[7] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		if isElement(engineParts.cylinder_head) then
			destroyElement(engineParts.cylinder_head)
		end
		engineParts.cylinder_head = nil
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"headgasket",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineRepairKit[8] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		if isElement(engineParts.cylinder_head) then
			destroyElement(engineParts.cylinder_head)
		end
		engineParts.cylinder_head = createObject(objectModels.cylinder_head, 0, 0, 0)
		setElementDoubleSided(engineParts.cylinder_head, true)
		setElementCollisionsEnabled(engineParts.cylinder_head, false)
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"headon",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineRepairKit[9] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"head",
		false,
		false,
		false,
		{
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
		},
		{
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
end
spectatorFunctions.engineRepairKit[10] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		if isElement(engineParts.timing_belt) then
			destroyElement(engineParts.timing_belt)
		end
		engineParts.timing_belt = createObject(objectModels.timing_belt, 0, 0, 0)
		setElementDoubleSided(engineParts.timing_belt, true)
		setElementCollisionsEnabled(engineParts.timing_belt, false)
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"timingon",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineRepairKit[11] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"timing",
		false,
		false,
		false,
		{
			0,
			0,
			0
		},
		{
			0,
			0,
			0
		}
	}
end
spectatorFunctions.engineRepairKit[12] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		if isElement(engineParts.valve_cover) then
			destroyElement(engineParts.valve_cover)
		end
		engineParts.valve_cover = createObject(objectModels.valve_cover, 0, 0, 0)
		setElementDoubleSided(engineParts.valve_cover, true)
		setElementCollisionsEnabled(engineParts.valve_cover, false)
		if isElement(engineParts.valve_gasket) then
			destroyElement(engineParts.valve_gasket)
		end
		engineParts.valve_gasket = createObject(objectModels.valve_gasket, 0, 0, 0)
		setElementDoubleSided(engineParts.valve_gasket, true)
		setElementCollisionsEnabled(engineParts.valve_gasket, false)
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"valveon",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineRepairKit[13] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"valve",
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
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
end
spectatorFunctions.frontBumper[1] = function()
	local x, y, z = getComponentPosition(closestVeh, "bump_front_dummy")
	if x then
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"frontBumper",
			false,
			false,
			true,
			{
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1
			}
		}
	end
end
spectatorFunctions.frontBumper[2] = function()
	originalState.frontBumper = getVehiclePanelState(closestVeh, 5)
	local x, y, z = getVehicleComponentPosition(closestVeh, "bump_front_dummy", "root")
	screwMinigame = false
	partAnimation = {
		closestVeh,
		"frontBumper",
		getTickCount(),
		x,
		y,
		z,
		false
	}
end
spectatorFunctions.frontBumper[3] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"frontBumper",
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0
		}
	}
end
spectatorFunctions.rearBumper[1] = function()
	local x, y, z = getComponentPosition(closestVeh, "bump_rear_dummy")
	if x then
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"rearBumper",
			false,
			false,
			true,
			{
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1
			}
		}
	end
end
spectatorFunctions.rearBumper[2] = function()
	originalState.rearBumper = getVehiclePanelState(closestVeh, 6)
	local x, y, z = getVehicleComponentPosition(closestVeh, "bump_rear_dummy", "root")
	screwMinigame = false
	partAnimation = {
		closestVeh,
		"rearBumper",
		getTickCount(),
		x,
		y,
		z,
		false
	}
end
spectatorFunctions.rearBumper[3] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"rearBumper",
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0
		}
	}
end
spectatorFunctions.hood[1] = function()
	local x, y, z = getComponentPosition(closestVeh, "bonnet_dummy")
	if x then
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"hood",
			false,
			false,
			true,
			{
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1
			}
		}
	end
end
spectatorFunctions.hood[2] = function()
	originalState.hood = getVehiclePanelState(closestVeh, 6)
	local x, y, z = getVehicleComponentPosition(closestVeh, "bonnet_dummy", "root")
	screwMinigame = false
	partAnimation = {
		closestVeh,
		"hood",
		getTickCount(),
		x,
		y,
		z,
		false
	}
end
spectatorFunctions.hood[3] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"hood",
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0
		}
	}
end
spectatorFunctions.trunk[1] = function()
	local x, y, z = getComponentPosition(closestVeh, "boot_dummy")
	if x then
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"trunk",
			false,
			false,
			true,
			{
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1
			}
		}
	end
end
spectatorFunctions.trunk[2] = function()
	originalState.trunk = getVehiclePanelState(closestVeh, 6)
	local x, y, z = getVehicleComponentPosition(closestVeh, "boot_dummy", "root")
	screwMinigame = false
	partAnimation = {
		closestVeh,
		"trunk",
		getTickCount(),
		x,
		y,
		z,
		false
	}
end
spectatorFunctions.trunk[3] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"trunk",
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0
		}
	}
end
spectatorFunctions.frontLeftDoor[1] = function()
	local x, y, z = getComponentPosition(closestVeh, "door_lf_dummy")
	if x then
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"frontLeftDoor",
			false,
			false,
			true,
			{
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1
			}
		}
	end
end
spectatorFunctions.frontLeftDoor[2] = function()
	originalState.frontLeftDoor = getVehiclePanelState(closestVeh, 6)
	local x, y, z = getVehicleComponentPosition(closestVeh, "door_lf_dummy", "root")
	screwMinigame = false
	partAnimation = {
		closestVeh,
		"frontLeftDoor",
		getTickCount(),
		x,
		y,
		z,
		false
	}
end
spectatorFunctions.frontLeftDoor[3] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"frontLeftDoor",
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0
		}
	}
end
spectatorFunctions.frontRightDoor[1] = function()
	local x, y, z = getComponentPosition(closestVeh, "door_rf_dummy")
	if x then
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"frontRightDoor",
			false,
			false,
			true,
			{
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1
			}
		}
	end
end
spectatorFunctions.frontRightDoor[2] = function()
	originalState.frontRightDoor = getVehiclePanelState(closestVeh, 6)
	local x, y, z = getVehicleComponentPosition(closestVeh, "door_rf_dummy", "root")
	screwMinigame = false
	partAnimation = {
		closestVeh,
		"frontRightDoor",
		getTickCount(),
		x,
		y,
		z,
		false
	}
end
spectatorFunctions.frontRightDoor[3] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"frontRightDoor",
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0
		}
	}
end
spectatorFunctions.rearLeftDoor[1] = function()
	local x, y, z = getComponentPosition(closestVeh, "door_lr_dummy")
	if x then
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"rearLeftDoor",
			false,
			false,
			true,
			{
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1
			}
		}
	end
end
spectatorFunctions.rearLeftDoor[2] = function()
	originalState.rearLeftDoor = getVehiclePanelState(closestVeh, 6)
	local x, y, z = getVehicleComponentPosition(closestVeh, "door_lr_dummy", "root")
	screwMinigame = false
	partAnimation = {
		closestVeh,
		"rearLeftDoor",
		getTickCount(),
		x,
		y,
		z,
		false
	}
end
spectatorFunctions.rearLeftDoor[3] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"rearLeftDoor",
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0
		}
	}
end
spectatorFunctions.rearRightDoor[1] = function()
	local x, y, z = getComponentPosition(closestVeh, "door_rr_dummy")
	if x then
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"rearRightDoor",
			false,
			false,
			true,
			{
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1
			}
		}
	end
end
spectatorFunctions.rearRightDoor[2] = function()
	originalState.rearRightDoor = getVehiclePanelState(closestVeh, 6)
	local x, y, z = getVehicleComponentPosition(closestVeh, "door_rr_dummy", "root")
	screwMinigame = false
	partAnimation = {
		closestVeh,
		"rearRightDoor",
		getTickCount(),
		x,
		y,
		z,
		false
	}
end
spectatorFunctions.rearRightDoor[3] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"rearRightDoor",
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0
		}
	}
end
function speclight1()
	local comp = false
	if spectatorStates[closestVeh][1] == "frontLeftLight" then
		comp = "headlights_left"
	elseif spectatorStates[closestVeh][1] == "frontRightLight" then
		comp = "headlights_right"
	elseif spectatorStates[closestVeh][1] == "rearLeftLight" then
		comp = "taillights_left"
	elseif spectatorStates[closestVeh][1] == "rearRightLight" then
		comp = "taillights_right"
	end
	local x, y, z = getComponentPosition(closestVeh, comp)
	if x then
		partAnimation = false
		screwMinigame = {
			closestVeh,
			spectatorStates[closestVeh][1],
			false,
			false,
			true,
			{1, 1},
			{1, 1}
		}
	end
end
function speclight2()
	local comp = false
	if spectatorStates[closestVeh][1] == "frontLeftLight" then
		comp = "headlights_left"
	elseif spectatorStates[closestVeh][1] == "frontRightLight" then
		comp = "headlights_right"
	elseif spectatorStates[closestVeh][1] == "rearLeftLight" then
		comp = "taillights_left"
	elseif spectatorStates[closestVeh][1] == "rearRightLight" then
		comp = "taillights_right"
	end
	local x, y, z = getComponentPosition(closestVeh, comp)
	if x then
		partAnimation = false
		screwMinigame = {
			closestVeh,
			spectatorStates[closestVeh][1],
			false,
			false,
			false,
			{0, 0},
			{0, 0}
		}
	end
end
spectatorFunctions.frontLeftLight[1] = speclight1
spectatorFunctions.frontLeftLight[2] = speclight2
spectatorFunctions.frontRightLight[1] = speclight1
spectatorFunctions.frontRightLight[2] = speclight2
spectatorFunctions.rearLeftLight[1] = speclight1
spectatorFunctions.rearLeftLight[2] = speclight2
spectatorFunctions.rearRightLight[1] = speclight1
spectatorFunctions.rearRightLight[2] = speclight2
function spectires1(tireSide)
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"wheel_" .. tireSide[1],
		false,
		false,
		true,
		{
			1,
			1,
			1,
			1,
			1
		},
		{
			1,
			1,
			1,
			1,
			1
		}
	}
end
function spectires2(tireSide)
	partAnimation = false
	screwMinigame = false
	setWheelOffState(closestVeh, tireSide[1], true)
end
function spectires3(tireSide)
	partAnimation = false
	setWheelOffState(closestVeh, tireSide[1], false)
	screwMinigame = {
		closestVeh,
		"wheel_" .. tireSide[1],
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0,
			0
		}
	}
end
function spectires4(tireSide)
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"wheel_" .. tireSide[2],
		false,
		false,
		true,
		{
			1,
			1,
			1,
			1,
			1
		},
		{
			1,
			1,
			1,
			1,
			1
		}
	}
end
function spectires5(tireSide)
	partAnimation = false
	screwMinigame = false
	setWheelOffState(closestVeh, tireSide[2], true)
end
function spectires6(tireSide)
	partAnimation = false
	setWheelOffState(closestVeh, tireSide[2], false)
	if repairingPart and repairingPart[1] then
		if originalWheelsOff[repairingPart[1]] then
			for i = 1, 4 do
				setWheelOffState(repairingPart[1], i, originalWheelsOff[repairingPart[1]][i])
			end
		end
	end
	screwMinigame = {
		closestVeh,
		"wheel_" .. tireSide[2],
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0,
			0
		}
	}
end
spectatorFunctions.frontTires[1] = spectires1
spectatorFunctions.frontTires[2] = spectires2
spectatorFunctions.frontTires[3] = spectires3
spectatorFunctions.frontTires[4] = spectires4
spectatorFunctions.frontTires[5] = spectires5
spectatorFunctions.frontTires[6] = spectires6
spectatorFunctions.rearTires[1] = spectires1
spectatorFunctions.rearTires[2] = spectires2
spectatorFunctions.rearTires[3] = spectires3
spectatorFunctions.rearTires[4] = spectires4
spectatorFunctions.rearTires[5] = spectires5
spectatorFunctions.rearTires[6] = spectires6
function specbrake1(tireSide)
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"brake_" .. tireSide[1],
		false,
		false,
		true,
		{
			1,
			1,
			1,
			1,
			1
		},
		{
			1,
			1,
			1,
			1,
			1
		}
	}
end
function specbrake2(tireSide)
	if tireSide[1] == 1 then
		obj = "brake_fl"
	elseif tireSide[1] == 2 then
		obj = "brake_fr"
	elseif tireSide[1] == 3 then
		obj = "brake_rl"
	elseif tireSide[1] == 4 then
		obj = "brake_rr"
	end
	if obj and isElement(vehicleObjects[obj]) then
		local x, y, z = getElementPosition(vehicleObjects[obj])
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"brake" .. tireSide[1],
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
function specbrake3(tireSide)
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"brake_" .. tireSide[1],
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0,
			0
		}
	}
end
function specbrake4(tireSide)
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"brake_" .. tireSide[2],
		false,
		false,
		true,
		{
			1,
			1,
			1,
			1,
			1
		},
		{
			1,
			1,
			1,
			1,
			1
		}
	}
end
function specbrake5(tireSide)
	local obj = false
	if tireSide[2] == 1 then
		obj = "brake_fl"
	elseif tireSide[2] == 2 then
		obj = "brake_fr"
	elseif tireSide[2] == 3 then
		obj = "brake_rl"
	elseif tireSide[2] == 4 then
		obj = "brake_rr"
	end
	if obj and isElement(vehicleObjects[obj]) then
		screwMinigame = false
		local x, y, z = getElementPosition(vehicleObjects[obj])
		partAnimation = {
			closestVeh,
			"brake" .. tireSide[2],
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
function specbrake6(tireSide)
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"brake_" .. tireSide[2],
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0,
			0
		}
	}
end
spectatorFunctions.frontBrakes[1] = specbrake1
spectatorFunctions.frontBrakes[2] = specbrake2
spectatorFunctions.frontBrakes[3] = specbrake3
spectatorFunctions.frontBrakes[4] = specbrake4
spectatorFunctions.frontBrakes[5] = specbrake5
spectatorFunctions.frontBrakes[6] = specbrake6
spectatorFunctions.rearBrakes[1] = specbrake1
spectatorFunctions.rearBrakes[2] = specbrake2
spectatorFunctions.rearBrakes[3] = specbrake3
spectatorFunctions.rearBrakes[4] = specbrake4
spectatorFunctions.rearBrakes[5] = specbrake5
spectatorFunctions.rearBrakes[6] = specbrake6
function specsusp1()
	local id = false
	if spectatorStates[closestVeh][1] == "frontLeftSuspension" then
		id = 1
	elseif spectatorStates[closestVeh][1] == "frontRightSuspension" then
		id = 2
	elseif spectatorStates[closestVeh][1] == "rearLeftSuspension" then
		id = 3
	elseif spectatorStates[closestVeh][1] == "rearRightSuspension" then
		id = 4
	end
	if id then
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"brake_" .. id,
			false,
			false,
			true,
			{
				1,
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1,
				1
			}
		}
	end
end
function specsusp2()
	local id = false
	local obj = false
	if spectatorStates[closestVeh][1] == "frontLeftSuspension" then
		id = 1
		obj = "brake_fl"
	elseif spectatorStates[closestVeh][1] == "frontRightSuspension" then
		id = 2
		obj = "brake_fr"
	elseif spectatorStates[closestVeh][1] == "rearLeftSuspension" then
		id = 3
		obj = "brake_rl"
	elseif spectatorStates[closestVeh][1] == "rearRightSuspension" then
		id = 4
		obj = "brake_rr"
	end
	if id and isElement(vehicleObjects[obj]) then
		local x, y, z = getElementPosition(vehicleObjects[obj])
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"brake" .. id .. "off",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
function specsusp3()
	local id = false
	local obj = false
	if spectatorStates[closestVeh][1] == "frontLeftSuspension" then
		id = 1
		obj = "brake_fl"
	elseif spectatorStates[closestVeh][1] == "frontRightSuspension" then
		id = 2
		obj = "brake_fr"
	elseif spectatorStates[closestVeh][1] == "rearLeftSuspension" then
		id = 3
		obj = "brake_rl"
	elseif spectatorStates[closestVeh][1] == "rearRightSuspension" then
		id = 4
		obj = "brake_rr"
	end
	if isElement(vehicleObjects[obj]) then
		destroyElement(vehicleObjects[obj])
	end
	vehicleObjects[obj] = nil
	if id then
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"suspension_" .. id,
			false,
			false,
			true,
			{
				1,
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1,
				1
			}
		}
	end
end
function specsusp4()
	local id = false
	local obj = false
	if spectatorStates[closestVeh][1] == "frontLeftSuspension" then
		id = 1
		obj = "suspension_fl"
	elseif spectatorStates[closestVeh][1] == "frontRightSuspension" then
		id = 2
		obj = "suspension_fr"
	elseif spectatorStates[closestVeh][1] == "rearLeftSuspension" then
		id = 3
		obj = "suspension_rl"
	elseif spectatorStates[closestVeh][1] == "rearRightSuspension" then
		id = 4
		obj = "suspension_rr"
	end
	if id and isElement(vehicleObjects[obj]) then
		local x, y, z = getElementPosition(vehicleObjects[obj])
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"suspension" .. id,
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
function specsusp5()
	local id = false
	if spectatorStates[closestVeh][1] == "frontLeftSuspension" then
		id = 1
	elseif spectatorStates[closestVeh][1] == "frontRightSuspension" then
		id = 2
	elseif spectatorStates[closestVeh][1] == "rearLeftSuspension" then
		id = 3
	elseif spectatorStates[closestVeh][1] == "rearRightSuspension" then
		id = 4
	end
	if id then
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"suspension_" .. id,
			false,
			false,
			false,
			{
				0,
				0,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				0,
				0
			}
		}
	end
end
function specsusp6()
	local id = false
	local obj = false
	if spectatorStates[closestVeh][1] == "frontLeftSuspension" then
		id = 1
		obj = "brake_fl"
	elseif spectatorStates[closestVeh][1] == "frontRightSuspension" then
		id = 2
		obj = "brake_fr"
	elseif spectatorStates[closestVeh][1] == "rearLeftSuspension" then
		id = 3
		obj = "brake_rl"
	elseif spectatorStates[closestVeh][1] == "rearRightSuspension" then
		id = 4
		obj = "brake_rr"
	end
	if isElement(vehicleObjects[obj]) then
		destroyElement(vehicleObjects[obj])
	end
	vehicleObjects[obj] = createObject(objectModels.brake, 0, 0, 0)
	setElementCollisionsEnabled(vehicleObjects[obj], false)
	processVehicleObjects()
	if id and isElement(vehicleObjects[obj]) then
		local x, y, z = getElementPosition(vehicleObjects[obj])
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"brake" .. id .. "on",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
function specsusp7()
	local id = false
	if spectatorStates[closestVeh][1] == "frontLeftSuspension" then
		id = 1
	elseif spectatorStates[closestVeh][1] == "frontRightSuspension" then
		id = 2
	elseif spectatorStates[closestVeh][1] == "rearLeftSuspension" then
		id = 3
	elseif spectatorStates[closestVeh][1] == "rearRightSuspension" then
		id = 4
	end
	if id then
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"brake_" .. id,
			false,
			false,
			false,
			{
				0,
				0,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				0,
				0
			}
		}
	end
end
spectatorFunctions.frontLeftSuspension[1] = specsusp1
spectatorFunctions.frontRightSuspension[1] = specsusp1
spectatorFunctions.rearLeftSuspension[1] = specsusp1
spectatorFunctions.rearRightSuspension[1] = specsusp1
spectatorFunctions.frontLeftSuspension[2] = specsusp2
spectatorFunctions.frontRightSuspension[2] = specsusp2
spectatorFunctions.rearLeftSuspension[2] = specsusp2
spectatorFunctions.rearRightSuspension[2] = specsusp2
spectatorFunctions.frontLeftSuspension[3] = specsusp3
spectatorFunctions.frontRightSuspension[3] = specsusp3
spectatorFunctions.rearLeftSuspension[3] = specsusp3
spectatorFunctions.rearRightSuspension[3] = specsusp3
spectatorFunctions.frontLeftSuspension[4] = specsusp4
spectatorFunctions.frontRightSuspension[4] = specsusp4
spectatorFunctions.rearLeftSuspension[4] = specsusp4
spectatorFunctions.rearRightSuspension[4] = specsusp4
spectatorFunctions.frontLeftSuspension[5] = specsusp5
spectatorFunctions.frontRightSuspension[5] = specsusp5
spectatorFunctions.rearLeftSuspension[5] = specsusp5
spectatorFunctions.rearRightSuspension[5] = specsusp5
spectatorFunctions.frontLeftSuspension[6] = specsusp6
spectatorFunctions.frontRightSuspension[6] = specsusp6
spectatorFunctions.rearLeftSuspension[6] = specsusp6
spectatorFunctions.rearRightSuspension[6] = specsusp6
spectatorFunctions.frontLeftSuspension[7] = specsusp7
spectatorFunctions.frontRightSuspension[7] = specsusp7
spectatorFunctions.rearLeftSuspension[7] = specsusp7
spectatorFunctions.rearRightSuspension[7] = specsusp7
spectatorFunctions.oilChangeKit[1] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		createMinigameObj("engine")
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"oil1",
			false,
			false,
			true,
			{1},
			{1}
		}
	end
end
spectatorFunctions.oilChangeKit[2] = function(arg, sound)
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = createObject(objectModels.oil_drain_can, 0, 0, 0)
	setElementCollisionsEnabled(oilObject, false)
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = dxCreateTexture("files/oiltexture.dds")
	screwMinigame = false
	partAnimation = {
		closestVeh,
		"oil",
		getTickCount(),
		0,
		0,
		0,
		false
	}
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x and sound then
		playSound3D("files/oildrain.mp3", x, y, z)
	end
end
spectatorFunctions.oilChangeKit[3] = function()
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = false
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = false
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"oil1",
		false,
		false,
		false,
		{0},
		{0}
	}
end
spectatorFunctions.oilChangeKit[4] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"oil2",
		false,
		false,
		true,
		{1},
		{1}
	}
end
spectatorFunctions.oilChangeKit[5] = function(arg, sound)
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = createObject(objectModels.motoroil, 0, 0, 0)
	setElementCollisionsEnabled(oilObject, false)
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = dxCreateTexture("files/oiltexture2.dds")
	screwMinigame = false
	partAnimation = {
		closestVeh,
		"oilin",
		getTickCount(),
		0,
		0,
		0,
		false
	}
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x and sound then
		playSound3D("files/oilin.mp3", x, y, z)
	end
end
spectatorFunctions.oilChangeKit[6] = function()
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = false
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = false
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"oil2",
		false,
		false,
		false,
		{0},
		{0}
	}
end
spectatorFunctions.engineTimingKit[1] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		createMinigameObj("engine")
		screwMinigame = {
			closestVeh,
			"valve",
			false,
			false,
			true,
			{
				1,
				1,
				1,
				1,
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1,
				1,
				1,
				1,
				1
			}
		}
	end
end
spectatorFunctions.engineTimingKit[2] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"valveoff",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineTimingKit[3] = function()
	partAnimation = false
	if isElement(engineParts.valve_cover) then
		destroyElement(engineParts.valve_cover)
	end
	engineParts.valve_cover = nil
	if isElement(engineParts.valve_gasket) then
		destroyElement(engineParts.valve_gasket)
	end
	engineParts.valve_gasket = nil
	screwMinigame = {
		closestVeh,
		"timing",
		false,
		false,
		true,
		{
			1,
			1,
			1
		},
		{
			1,
			1,
			1
		}
	}
end
spectatorFunctions.engineTimingKit[4] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"timing",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineTimingKit[5] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"timing",
		false,
		false,
		false,
		{
			0,
			0,
			0
		},
		{
			0,
			0,
			0
		}
	}
end
spectatorFunctions.engineTimingKit[6] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		if isElement(engineParts.valve_cover) then
			destroyElement(engineParts.valve_cover)
		end
		engineParts.valve_cover = createObject(objectModels.valve_cover, 0, 0, 0)
		setElementDoubleSided(engineParts.valve_cover, true)
		setElementCollisionsEnabled(engineParts.valve_cover, false)
		if isElement(engineParts.valve_gasket) then
			destroyElement(engineParts.valve_gasket)
		end
		engineParts.valve_gasket = createObject(objectModels.valve_gasket, 0, 0, 0)
		setElementDoubleSided(engineParts.valve_gasket, true)
		setElementCollisionsEnabled(engineParts.valve_gasket, false)
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"valveon",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineTimingKit[7] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"valve",
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
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
end
spectatorFunctions.engineGeneralKit[1] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		createMinigameObj("engine")
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"valve",
			false,
			false,
			true,
			{
				1,
				1,
				1,
				1,
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1,
				1,
				1,
				1,
				1
			}
		}
	end
end
spectatorFunctions.engineGeneralKit[2] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"valveoff",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineGeneralKit[3] = function()
	if isElement(engineParts.valve_cover) then
		destroyElement(engineParts.valve_cover)
	end
	engineParts.valve_cover = nil
	if isElement(engineParts.valve_gasket) then
		destroyElement(engineParts.valve_gasket)
	end
	engineParts.valve_gasket = nil
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"timing",
		false,
		false,
		true,
		{
			1,
			1,
			1
		},
		{
			1,
			1,
			1
		}
	}
end
spectatorFunctions.engineGeneralKit[4] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"timingoff",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineGeneralKit[5] = function()
	if isElement(engineParts.timing_belt) then
		destroyElement(engineParts.timing_belt)
	end
	engineParts.timing_belt = nil
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"head",
		false,
		false,
		true,
		{
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
		},
		{
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
	}
end
spectatorFunctions.engineGeneralKit[6] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"headoff",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineGeneralKit[7] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		if isElement(engineParts.cylinder_head) then
			destroyElement(engineParts.cylinder_head)
		end
		engineParts.cylinder_head = nil
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"headgasketoff",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineGeneralKit[8] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		if isElement(engineParts.gasket) then
			destroyElement(engineParts.gasket)
		end
		engineParts.gasket = nil
		partAnimation = false
		screwMinigame = {
			closestVeh,
			"oil1",
			false,
			false,
			true,
			{1},
			{1}
		}
	end
end
spectatorFunctions.engineGeneralKit[9] = function(arg, sound)
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = createObject(objectModels.oil_drain_can, 0, 0, 0)
	setElementCollisionsEnabled(oilObject, false)
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = dxCreateTexture("files/oiltexture.dds")
	screwMinigame = false
	partAnimation = {
		closestVeh,
		"oil",
		getTickCount(),
		0,
		0,
		0,
		false
	}
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x and sound then
		playSound3D("files/oildrain.mp3", x, y, z)
	end
end
spectatorFunctions.engineGeneralKit[10] = function()
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = false
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = false
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"sump",
		false,
		false,
		true,
		{
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
		},
		{
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
	}
end
spectatorFunctions.engineGeneralKit[11] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"sumpoff",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineGeneralKit[12] = function()
	if isElement(engineParts.oil_sump) then
		destroyElement(engineParts.oil_sump)
	end
	engineParts.oil_sump = nil
	if isElement(engineParts.oil_gasket) then
		destroyElement(engineParts.oil_gasket)
	end
	engineParts.oil_gasket = nil
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"piston",
		false,
		false,
		true,
		{
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1
		},
		{
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1
		}
	}
end
spectatorFunctions.engineGeneralKit[13] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"piston",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineGeneralKit[14] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"piston",
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
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
end
spectatorFunctions.engineGeneralKit[15] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		if isElement(engineParts.oil_sump) then
			destroyElement(engineParts.oil_sump)
		end
		engineParts.oil_sump = createObject(objectModels.oil_sump, 0, 0, 0)
		setElementDoubleSided(engineParts.oil_sump, true)
		setElementCollisionsEnabled(engineParts.oil_sump, false)
		if isElement(engineParts.oil_gasket) then
			destroyElement(engineParts.oil_gasket)
		end
		engineParts.oil_gasket = createObject(objectModels.oil_gasket, 0, 0, 0)
		setElementDoubleSided(engineParts.oil_gasket, true)
		setElementCollisionsEnabled(engineParts.oil_gasket, false)
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"sumpon",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineGeneralKit[16] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"sump",
		false,
		false,
		false,
		{
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
		},
		{
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
end
spectatorFunctions.engineGeneralKit[17] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"oil1",
		false,
		false,
		false,
		{0},
		{0}
	}
end
spectatorFunctions.engineGeneralKit[18] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		if isElement(engineParts.gasket) then
			destroyElement(engineParts.gasket)
		end
		engineParts.gasket = createObject(objectModels.gasket, 0, 0, 0)
		setElementDoubleSided(engineParts.gasket, true)
		setElementCollisionsEnabled(engineParts.gasket, false)
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"headgasketon",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineGeneralKit[19] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		if isElement(engineParts.cylinder_head) then
			destroyElement(engineParts.cylinder_head)
		end
		engineParts.cylinder_head = createObject(objectModels.cylinder_head, 0, 0, 0)
		setElementDoubleSided(engineParts.cylinder_head, true)
		setElementCollisionsEnabled(engineParts.cylinder_head, false)
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"headon",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineGeneralKit[20] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"head",
		false,
		false,
		false,
		{
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
		},
		{
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
end
spectatorFunctions.engineGeneralKit[21] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		if isElement(engineParts.timing_belt) then
			destroyElement(engineParts.timing_belt)
		end
		engineParts.timing_belt = createObject(objectModels.timing_belt, 0, 0, 0)
		setElementDoubleSided(engineParts.timing_belt, true)
		setElementCollisionsEnabled(engineParts.timing_belt, false)
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"timingon",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineGeneralKit[22] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"timing",
		false,
		false,
		false,
		{
			0,
			0,
			0
		},
		{
			0,
			0,
			0
		}
	}
end
spectatorFunctions.engineGeneralKit[23] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		if isElement(engineParts.valve_cover) then
			destroyElement(engineParts.valve_cover)
		end
		engineParts.valve_cover = createObject(objectModels.valve_cover, 0, 0, 0)
		setElementDoubleSided(engineParts.valve_cover, true)
		setElementCollisionsEnabled(engineParts.valve_cover, false)
		if isElement(engineParts.valve_gasket) then
			destroyElement(engineParts.valve_gasket)
		end
		engineParts.valve_gasket = createObject(objectModels.valve_gasket, 0, 0, 0)
		setElementDoubleSided(engineParts.valve_gasket, true)
		setElementCollisionsEnabled(engineParts.valve_gasket, false)
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"valveon",
			getTickCount(),
			x,
			y,
			z,
			false
		}
	end
end
spectatorFunctions.engineGeneralKit[24] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"valve",
		false,
		false,
		false,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
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
end
spectatorFunctions.engineGeneralKit[25] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"oil2",
		false,
		false,
		true,
		{1},
		{1}
	}
end
spectatorFunctions.engineGeneralKit[26] = function(arg, sound)
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = createObject(objectModels.motoroil, 0, 0, 0)
	setElementCollisionsEnabled(oilObject, false)
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = dxCreateTexture("files/oiltexture2.dds")
	screwMinigame = false
	partAnimation = {
		closestVeh,
		"oilin",
		getTickCount(),
		0,
		0,
		0,
		false
	}
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x and sound then
		playSound3D("files/oilin.mp3", x, y, z)
	end
end
spectatorFunctions.engineGeneralKit[27] = function()
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = false
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = false
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"oil2",
		false,
		false,
		false,
		{0},
		{0}
	}
end
spectatorFunctions.battery[1] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		local model = getElementData(closestVeh, "vehicle.customModel") or getElementModel(closestVeh)
		if evVehicles[model] then
			createMinigameObj("battery")
		else
			createMinigameObj("engine")
		end
		screwMinigame = {
			closestVeh,
			"battery",
			false,
			false,
			true,
			{1, 1},
			{1, 1}
		}
	end
end
spectatorFunctions.battery[2] = function()
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		screwMinigame = false
		partAnimation = {
			closestVeh,
			"battery",
			getTickCount(),
			0,
			0,
			0,
			false
		}
	end
end
spectatorFunctions.battery[3] = function()
	partAnimation = false
	screwMinigame = {
		closestVeh,
		"battery",
		false,
		false,
		false,
		{0, 0},
		{0, 0}
	}
end
addEvent("syncSpectatorScrews", true)
addEventHandler("syncSpectatorScrews", getRootElement(), function(veh, screw)
	if isElement(source) and isElement(veh) and not repairingPart and spectatorStates[veh] then
		spectatorStates[veh][3] = screw
		if veh == closestVeh and screwMinigame and screw and #screw == #screwMinigame[6] then
			screwMinigame[6] = screw
		end
	end
end)
addEvent("syncSpectatorState", true)
addEventHandler("syncSpectatorState", getRootElement(), function(veh, name, state, screw, arg)
	if isElement(source) and isElement(veh) and not repairingPart then
		if name then
			local reCreate = not spectatorStates[veh] or spectatorStates[veh][1] ~= name
			spectatorStates[veh] = {
				name,
				state,
				screw,
				arg
			}
			if veh == closestVeh and spectatorFunctions[name] and spectatorFunctions[name][state] then
				for i = reCreate and 1 or state, state do
					if spectatorFunctions[name][i] then
						spectatorFunctions[name][i](arg, true)
					end
				end
				if screwMinigame and screw and #screw == #screwMinigame[6] then
					screwMinigame[6] = screw
				end
			end
		else
			if spectatorStates[veh] then
				if spectatorStates[veh][1] == "frontBumper" then
					resetVehicleComponentPosition(veh, "bump_front_dummy")
				elseif spectatorStates[veh][1] == "rearBumper" then
					resetVehicleComponentPosition(veh, "bump_rear_dummy")
				elseif spectatorStates[veh][1] == "hood" then
					resetVehicleComponentPosition(veh, "bonnet_dummy")
				elseif spectatorStates[veh][1] == "trunk" then
					resetVehicleComponentPosition(veh, "boot_dummy")
				elseif spectatorStates[veh][1] == "frontLeftDoor" then
					resetVehicleComponentPosition(veh, "door_lf_dummy")
				elseif spectatorStates[veh][1] == "frontRightDoor" then
					resetVehicleComponentPosition(veh, "door_rf_dummy")
				elseif spectatorStates[veh][1] == "rearLeftDoor" then
					resetVehicleComponentPosition(veh, "door_lr_dummy")
				elseif spectatorStates[veh][1] == "rearRightDoor" then
					resetVehicleComponentPosition(veh, "door_rr_dummy")
				end
			end
			spectatorStates[veh] = nil
			if veh == closestVeh then
				createMinigameObj(false)
				partAnimation = false
				screwMinigame = false
				if isElement(oilObject) then
					destroyElement(oilObject)
				end
				oilObject = false
				if isElement(oilTexture) then
					destroyElement(oilTexture)
				end
				oilTexture = false
			end
			setElementAlpha(veh, 255)
		end
	end
end)
local repairFunctions = {}
repairFunctions.frontTires = {}
repairFunctions.rearTires = {}
repairFunctions.frontBrakes = {}
repairFunctions.rearBrakes = {}
repairFunctions.frontLeftSuspension = {}
repairFunctions.frontRightSuspension = {}
repairFunctions.rearLeftSuspension = {}
repairFunctions.rearRightSuspension = {}
repairFunctions.frontBumper = {}
repairFunctions.rearBumper = {}
repairFunctions.hood = {}
repairFunctions.trunk = {}
repairFunctions.frontLeftDoor = {}
repairFunctions.frontRightDoor = {}
repairFunctions.rearLeftDoor = {}
repairFunctions.rearRightDoor = {}
repairFunctions.frontLeftLight = {}
repairFunctions.frontRightLight = {}
repairFunctions.rearLeftLight = {}
repairFunctions.rearRightLight = {}
repairFunctions.oilChangeKit = {}
repairFunctions.engineTimingKit = {}
repairFunctions.engineRepairKit = {}
repairFunctions.engineGeneralKit = {}
repairFunctions.battery = {}
function createVehicleObjectsWithId(veh, id)
	local dat = wheelsOff[veh] or {}
	if id == 1 then
		if isElement(vehicleObjects.suspension_fl) then
			destroyElement(vehicleObjects.suspension_fl)
		end
		vehicleObjects.suspension_fl = nil
		if dat[1] then
			vehicleObjects.suspension_fl = createObject(objectModels.suspension_front, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.suspension_fl, false)
		end
	elseif id == 2 then
		if isElement(vehicleObjects.suspension_fr) then
			destroyElement(vehicleObjects.suspension_fr)
		end
		vehicleObjects.suspension_fr = nil
		if dat[2] then
			vehicleObjects.suspension_fr = createObject(objectModels.suspension_front, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.suspension_fr, false)
		end
	elseif id == 3 then
		if isElement(vehicleObjects.suspension_rl) then
			destroyElement(vehicleObjects.suspension_rl)
		end
		vehicleObjects.suspension_rl = nil
		if dat[3] then
			vehicleObjects.suspension_rl = createObject(objectModels.suspension_rear, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.suspension_rl, false)
		end
	elseif id == 4 then
		if isElement(vehicleObjects.suspension_rr) then
			destroyElement(vehicleObjects.suspension_rr)
		end
		vehicleObjects.suspension_rr = nil
		if dat[4] then
			vehicleObjects.suspension_rr = createObject(objectModels.suspension_rear, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.suspension_rr, false)
		end
	end
	if id == 1 then
		if isElement(vehicleObjects.brake_fl) then
			destroyElement(vehicleObjects.brake_fl)
		end
		vehicleObjects.brake_fl = nil
		if dat[1] then
			vehicleObjects.brake_fl = createObject(objectModels.brake, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.brake_fl, false)
		end
	elseif id == 2 then
		if isElement(vehicleObjects.brake_fr) then
			destroyElement(vehicleObjects.brake_fr)
		end
		vehicleObjects.brake_fr = nil
		if dat[2] then
			vehicleObjects.brake_fr = createObject(objectModels.brake, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.brake_fr, false)
		end
	elseif id == 3 then
		if isElement(vehicleObjects.brake_rl) then
			destroyElement(vehicleObjects.brake_rl)
		end
		vehicleObjects.brake_rl = nil
		if dat[3] then
			vehicleObjects.brake_rl = createObject(objectModels.brake, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.brake_rl, false)
		end
	elseif id == 4 then
		if isElement(vehicleObjects.brake_rr) then
			destroyElement(vehicleObjects.brake_rr)
		end
		vehicleObjects.brake_rr = nil
		if dat[4] then
			vehicleObjects.brake_rr = createObject(objectModels.brake, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.brake_rr, false)
		end
	end
end
function createVehicleObjects(veh)
	for i in pairs(vehicleObjects) do
		if isElement(vehicleObjects[i]) then
			destroyElement(vehicleObjects[i])
		end
	end
	vehicleObjects = {}
	if isElement(veh) then
		local dat = wheelsOff[veh] or {}
		if dat[1] then
			vehicleObjects.suspension_fl = createObject(objectModels.suspension_front, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.suspension_fl, false)
		end
		if dat[2] then
			vehicleObjects.suspension_fr = createObject(objectModels.suspension_front, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.suspension_fr, false)
		end
		if dat[3] then
			vehicleObjects.suspension_rl = createObject(objectModels.suspension_rear, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.suspension_rl, false)
		end
		if dat[4] then
			vehicleObjects.suspension_rr = createObject(objectModels.suspension_rear, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.suspension_rr, false)
		end
		if dat[1] then
			vehicleObjects.brake_fl = createObject(objectModels.brake, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.brake_fl, false)
		end
		if dat[2] then
			vehicleObjects.brake_fr = createObject(objectModels.brake, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.brake_fr, false)
		end
		if dat[3] then
			vehicleObjects.brake_rl = createObject(objectModels.brake, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.brake_rl, false)
		end
		if dat[4] then
			vehicleObjects.brake_rr = createObject(objectModels.brake, 0, 0, 0)
			setElementCollisionsEnabled(vehicleObjects.brake_rr, false)
		end
	end
end
function createMinigameObj(model)
	if isElement(mechanicMinigameObject) then
		destroyElement(mechanicMinigameObject)
	end
	for i in pairs(engineParts) do
		if isElement(engineParts[i]) then
			destroyElement(engineParts[i])
		end
	end
	engineParts = {}
	if model then
		if model == "engine" then
			engineParts.cylinder_head = createObject(objectModels.cylinder_head, 0, 0, 0)
			setElementDoubleSided(engineParts.cylinder_head, true)
			setElementCollisionsEnabled(engineParts.cylinder_head, false)
			engineParts.timing_belt = createObject(objectModels.timing_belt, 0, 0, 0)
			setElementDoubleSided(engineParts.timing_belt, true)
			setElementCollisionsEnabled(engineParts.timing_belt, false)
			engineParts.engine_block = createObject(objectModels.engine_block, 0, 0, 0)
			setElementDoubleSided(engineParts.engine_block, true)
			setElementCollisionsEnabled(engineParts.engine_block, false)
			engineParts.gasket = createObject(objectModels.gasket, 0, 0, 0)
			setElementDoubleSided(engineParts.gasket, true)
			setElementCollisionsEnabled(engineParts.gasket, false)
			engineParts.oil_sump = createObject(objectModels.oil_sump, 0, 0, 0)
			setElementDoubleSided(engineParts.oil_sump, true)
			setElementCollisionsEnabled(engineParts.oil_sump, false)
			engineParts.pistons = createObject(objectModels.pistons, 0, 0, 0)
			setElementDoubleSided(engineParts.pistons, true)
			setElementCollisionsEnabled(engineParts.pistons, false)
			engineParts.valve_cover = createObject(objectModels.valve_cover, 0, 0, 0)
			setElementDoubleSided(engineParts.valve_cover, true)
			setElementCollisionsEnabled(engineParts.valve_cover, false)
			engineParts.valve_gasket = createObject(objectModels.valve_gasket, 0, 0, 0)
			setElementDoubleSided(engineParts.valve_gasket, true)
			setElementCollisionsEnabled(engineParts.valve_gasket, false)
			engineParts.oil_gasket = createObject(objectModels.oil_gasket, 0, 0, 0)
			setElementDoubleSided(engineParts.oil_gasket, true)
			setElementCollisionsEnabled(engineParts.oil_gasket, false)
			engineParts.car_battery = createObject(objectModels.car_battery, 0, 0, 0)
			setElementDoubleSided(engineParts.car_battery, true)
			setElementCollisionsEnabled(engineParts.car_battery, false)
		elseif model == "battery" then
			engineParts.car_battery = createObject(objectModels.car_battery, 0, 0, 0)
			setElementDoubleSided(engineParts.car_battery, true)
			setElementCollisionsEnabled(engineParts.car_battery, false)
		else
			mechanicMinigameObject = createObject(model, 0, 0, 0)
			setElementCollisionsEnabled(mechanicMinigameObject, false)
		end
	else
		mechanicMinigameObject = false
		engineParts = {}
	end
end
function susp1()
	if repairingPart then
		local id = false
		if repairingPart[2] == "frontLeftSuspension" then
			id = 1
		elseif repairingPart[2] == "frontRightSuspension" then
			id = 2
		elseif repairingPart[2] == "rearLeftSuspension" then
			id = 3
		elseif repairingPart[2] == "rearRightSuspension" then
			id = 4
		end
		if id then
			sightexports.sGui:showInfobox("i", "Szereld le a féket!")
			screwMinigame = {
				repairingPart[1],
				"brake_" .. id,
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{
					1,
					1,
					1,
					1,
					1
				},
				{
					1,
					1,
					1,
					1,
					1
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		end
	end
end
function susp2()
	if repairingPart and (repairingPart[2] == "frontLeftSuspension" or repairingPart[2] == "frontRightSuspension" or repairingPart[2] == "rearLeftSuspension" or repairingPart[2] == "rearRightSuspension") then
		local id = false
		local obj = false
		if repairingPart[2] == "frontLeftSuspension" then
			id = 1
			obj = "brake_fl"
		elseif repairingPart[2] == "frontRightSuspension" then
			id = 2
			obj = "brake_fr"
		elseif repairingPart[2] == "rearLeftSuspension" then
			id = 3
			obj = "brake_rl"
		elseif repairingPart[2] == "rearRightSuspension" then
			id = 4
			obj = "brake_rr"
		end
		if id and isElement(vehicleObjects[obj]) then
			local x, y, z = getElementPosition(vehicleObjects[obj])
			partAnimation = {
				repairingPart[1],
				"brake" .. id .. "off",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions[repairingPart[2]][3]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
		else
			repairFunctions[repairingPart[2]][3]()
		end
	end
end
function susp3()
	if repairingPart then
		local id = false
		local obj = false
		if repairingPart[2] == "frontLeftSuspension" then
			id = 1
			obj = "brake_fl"
		elseif repairingPart[2] == "frontRightSuspension" then
			id = 2
			obj = "brake_fr"
		elseif repairingPart[2] == "rearLeftSuspension" then
			id = 3
			obj = "brake_rl"
		elseif repairingPart[2] == "rearRightSuspension" then
			id = 4
			obj = "brake_rr"
		end
		if isElement(vehicleObjects[obj]) then
			destroyElement(vehicleObjects[obj])
		end
		vehicleObjects[obj] = nil
		if id then
			sightexports.sGui:showInfobox("i", "Szereld le a régi felfüggesztést!")
			screwMinigame = {
				repairingPart[1],
				"suspension_" .. id,
				repairFunctions[repairingPart[2]][4],
				false,
				true,
				{
					1,
					1,
					1,
					1,
					1
				},
				{
					1,
					1,
					1,
					1,
					1
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3)
		end
	end
end
function susp4()
	if repairingPart and (repairingPart[2] == "frontLeftSuspension" or repairingPart[2] == "frontRightSuspension" or repairingPart[2] == "rearLeftSuspension" or repairingPart[2] == "rearRightSuspension") then
		local id = false
		local obj = false
		if repairingPart[2] == "frontLeftSuspension" then
			id = 1
			obj = "suspension_fl"
		elseif repairingPart[2] == "frontRightSuspension" then
			id = 2
			obj = "suspension_fr"
		elseif repairingPart[2] == "rearLeftSuspension" then
			id = 3
			obj = "suspension_rl"
		elseif repairingPart[2] == "rearRightSuspension" then
			id = 4
			obj = "suspension_rr"
		end
		if id and isElement(vehicleObjects[obj]) then
			local x, y, z = getElementPosition(vehicleObjects[obj])
			partAnimation = {
				repairingPart[1],
				"suspension" .. id,
				getTickCount(),
				x,
				y,
				z,
				repairFunctions[repairingPart[2]][5]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 4)
		else
			repairFunctions[repairingPart[2]][5]()
		end
	end
end
function susp5()
	if repairingPart then
		local id = false
		if repairingPart[2] == "frontLeftSuspension" then
			id = 1
		elseif repairingPart[2] == "frontRightSuspension" then
			id = 2
		elseif repairingPart[2] == "rearLeftSuspension" then
			id = 3
		elseif repairingPart[2] == "rearRightSuspension" then
			id = 4
		end
		if id then
			sightexports.sGui:showInfobox("i", "Szereld fel az új felfüggesztést!")
			screwMinigame = {
				repairingPart[1],
				"suspension_" .. id,
				repairFunctions[repairingPart[2]][6],
				false,
				false,
				{
					0,
					0,
					0,
					0,
					0
				},
				{
					0,
					0,
					0,
					0,
					0
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 5)
		end
	end
end
function susp6()
	if repairingPart and (repairingPart[2] == "frontLeftSuspension" or repairingPart[2] == "frontRightSuspension" or repairingPart[2] == "rearLeftSuspension" or repairingPart[2] == "rearRightSuspension") then
		local id = false
		local obj = false
		if repairingPart[2] == "frontLeftSuspension" then
			id = 1
			obj = "brake_fl"
		elseif repairingPart[2] == "frontRightSuspension" then
			id = 2
			obj = "brake_fr"
		elseif repairingPart[2] == "rearLeftSuspension" then
			id = 3
			obj = "brake_rl"
		elseif repairingPart[2] == "rearRightSuspension" then
			id = 4
			obj = "brake_rr"
		end
		if isElement(vehicleObjects[obj]) then
			destroyElement(vehicleObjects[obj])
		end
		vehicleObjects[obj] = createObject(objectModels.brake, 0, 0, 0)
		setElementCollisionsEnabled(vehicleObjects[obj], false)
		processVehicleObjects()
		if id and isElement(vehicleObjects[obj]) then
			local x, y, z = getElementPosition(vehicleObjects[obj])
			partAnimation = {
				repairingPart[1],
				"brake" .. id .. "on",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions[repairingPart[2]][7]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 6)
		else
			repairFunctions[repairingPart[2]][7]()
		end
	end
end
function susp7()
	if repairingPart then
		local id = false
		if repairingPart[2] == "frontLeftSuspension" then
			id = 1
		elseif repairingPart[2] == "frontRightSuspension" then
			id = 2
		elseif repairingPart[2] == "rearLeftSuspension" then
			id = 3
		elseif repairingPart[2] == "rearRightSuspension" then
			id = 4
		end
		if id then
			sightexports.sGui:showInfobox("i", "Szereld vissza a féket!")
			screwMinigame = {
				repairingPart[1],
				"brake_" .. id,
				repairFunctions[repairingPart[2]][8],
				false,
				false,
				{
					0,
					0,
					0,
					0,
					0
				},
				{
					0,
					0,
					0,
					0,
					0
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 7)
		end
	end
end
function susp8()
	if repairingPart and (repairingPart[2] == "frontLeftSuspension" or repairingPart[2] == "frontRightSuspension" or repairingPart[2] == "rearLeftSuspension" or repairingPart[2] == "rearRightSuspension") then
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		setVehicleDoorOpenRatio(repairingPart[1], 0, 0)
		setElementAlpha(repairingPart[1], 255)
		repairingPart = false
	end
end
repairFunctions.frontLeftSuspension[1] = susp1
repairFunctions.frontRightSuspension[1] = susp1
repairFunctions.rearLeftSuspension[1] = susp1
repairFunctions.rearRightSuspension[1] = susp1
repairFunctions.frontLeftSuspension[2] = susp2
repairFunctions.frontRightSuspension[2] = susp2
repairFunctions.rearLeftSuspension[2] = susp2
repairFunctions.rearRightSuspension[2] = susp2
repairFunctions.frontLeftSuspension[3] = susp3
repairFunctions.frontRightSuspension[3] = susp3
repairFunctions.rearLeftSuspension[3] = susp3
repairFunctions.rearRightSuspension[3] = susp3
repairFunctions.frontLeftSuspension[4] = susp4
repairFunctions.frontRightSuspension[4] = susp4
repairFunctions.rearLeftSuspension[4] = susp4
repairFunctions.rearRightSuspension[4] = susp4
repairFunctions.frontLeftSuspension[5] = susp5
repairFunctions.frontRightSuspension[5] = susp5
repairFunctions.rearLeftSuspension[5] = susp5
repairFunctions.rearRightSuspension[5] = susp5
repairFunctions.frontLeftSuspension[6] = susp6
repairFunctions.frontRightSuspension[6] = susp6
repairFunctions.rearLeftSuspension[6] = susp6
repairFunctions.rearRightSuspension[6] = susp6
repairFunctions.frontLeftSuspension[7] = susp7
repairFunctions.frontRightSuspension[7] = susp7
repairFunctions.rearLeftSuspension[7] = susp7
repairFunctions.rearRightSuspension[7] = susp7
repairFunctions.frontLeftSuspension[8] = susp8
repairFunctions.frontRightSuspension[8] = susp8
repairFunctions.rearLeftSuspension[8] = susp8
repairFunctions.rearRightSuspension[8] = susp8
function tires1()
	if repairingPart and (repairingPart[2] == "frontTires" or repairingPart[2] == "rearTires") then
		if repairingPart[2] == "frontTires" then
			if lastClickedWheel == 1 then
				tireSide = {1, 2}
			else
				tireSide = {2, 1}
			end
		elseif lastClickedWheel == 3 then
			tireSide = {3, 4}
		else
			tireSide = {4, 3}
		end
		sightexports.sGui:showInfobox("i", "Szereld le a régi kereket!")
		screwMinigame = {
			repairingPart[1],
			"wheel_" .. tireSide[1],
			repairFunctions[repairingPart[2]][2],
			false,
			true,
			{
				1,
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1,
				1
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1, false, tireSide)
	end
end
function tires2()
	if repairingPart and (repairingPart[2] == "frontTires" or repairingPart[2] == "rearTires") then
		setWheelOffState(repairingPart[1], tireSide[1], true)
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2, false, tireSide)
		setTimer(function()
			if repairingPart and (repairingPart[2] == "frontTires" or repairingPart[2] == "rearTires") then
				triggerServerEvent("temporaryCosmeticFix", localPlayer, tireSide[1])
				setWheelOffState(repairingPart[1], tireSide[1], false)
				sightexports.sGui:showInfobox("i", "Szereld fel az új kereket!")
				screwMinigame = {
					repairingPart[1],
					"wheel_" .. tireSide[1],
					repairFunctions[repairingPart[2]][3],
					false,
					false,
					{
						0,
						0,
						0,
						0,
						0
					},
					{
						0,
						0,
						0,
						0,
						0
					}
				}
				triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3, false, tireSide)
			end
		end, 1000, 1)
	end
end
function tires3()
	if repairingPart and (repairingPart[2] == "frontTires" or repairingPart[2] == "rearTires") then
		screwMinigame = {
			repairingPart[1],
			"wheel_" .. tireSide[2],
			repairFunctions[repairingPart[2]][4],
			false,
			true,
			{
				1,
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1,
				1
			}
		}
		sightexports.sGui:showInfobox("i", "Szereld le a régi kereket!")
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 4, false, tireSide)
	end
end
function tires4()
	if repairingPart and (repairingPart[2] == "frontTires" or repairingPart[2] == "rearTires") then
		setWheelOffState(repairingPart[1], tireSide[2], true)
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 5, false, tireSide)
		setTimer(function()
			if repairingPart and (repairingPart[2] == "frontTires" or repairingPart[2] == "rearTires") then
				--triggerServerEvent("temporaryCosmeticFix", localPlayer, tireSide[2])
				setWheelOffState(repairingPart[1], tireSide[2], false)
				if originalWheelsOff[repairingPart[1]] then
					for i = 1, 4 do
						setWheelOffState(repairingPart[1], i, originalWheelsOff[repairingPart[1]][i])
					end
				end
				sightexports.sGui:showInfobox("i", "Szereld fel az új kereket!")
				screwMinigame = {
					repairingPart[1],
					"wheel_" .. tireSide[2],
					repairFunctions[repairingPart[2]][5],
					false,
					false,
					{
						0,
						0,
						0,
						0,
						0
					},
					{
						0,
						0,
						0,
						0,
						0
					}
				}
				triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 6, false, tireSide)
			end
		end, 1000, 1)
	end
end
function tires5()
	if repairingPart and (repairingPart[2] == "frontTires" or repairingPart[2] == "rearTires") then
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
repairFunctions.frontTires[1] = tires1
repairFunctions.frontTires[2] = tires2
repairFunctions.frontTires[3] = tires3
repairFunctions.frontTires[4] = tires4
repairFunctions.frontTires[5] = tires5
repairFunctions.rearTires[1] = tires1
repairFunctions.rearTires[2] = tires2
repairFunctions.rearTires[3] = tires3
repairFunctions.rearTires[4] = tires4
repairFunctions.rearTires[5] = tires5
function brake1()
	if repairingPart and (repairingPart[2] == "frontBrakes" or repairingPart[2] == "rearBrakes") then
		if repairingPart[2] == "frontBrakes" then
			if lastClickedWheel == 1 then
				tireSide = {1, 2}
			else
				tireSide = {2, 1}
			end
		elseif lastClickedWheel == 3 then
			tireSide = {3, 4}
		else
			tireSide = {4, 3}
		end
		sightexports.sGui:showInfobox("i", "Szereld le a régi fékeket!")
		screwMinigame = {
			repairingPart[1],
			"brake_" .. tireSide[1],
			repairFunctions[repairingPart[2]][2],
			false,
			true,
			{
				1,
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1,
				1
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1, false, tireSide)
	end
end
function brake2()
	if repairingPart and repairingPart and (repairingPart[2] == "frontBrakes" or repairingPart[2] == "rearBrakes") then
		local obj = false
		if tireSide[1] == 1 then
			obj = "brake_fl"
		elseif tireSide[1] == 2 then
			obj = "brake_fr"
		elseif tireSide[1] == 3 then
			obj = "brake_rl"
		elseif tireSide[1] == 4 then
			obj = "brake_rr"
		end
		if obj and isElement(vehicleObjects[obj]) then
			local x, y, z = getElementPosition(vehicleObjects[obj])
			partAnimation = {
				repairingPart[1],
				"brake" .. tireSide[1],
				getTickCount(),
				x,
				y,
				z,
				repairFunctions[repairingPart[2]][3]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2, false, tireSide)
		else
			repairFunctions[repairingPart[2]][3]()
		end
	end
end
function brake3()
	if repairingPart and (repairingPart[2] == "frontBrakes" or repairingPart[2] == "rearBrakes") then
		sightexports.sGui:showInfobox("i", "Szereld fel az új fékeket!")
		screwMinigame = {
			repairingPart[1],
			"brake_" .. tireSide[1],
			repairFunctions[repairingPart[2]][4],
			false,
			false,
			{
				0,
				0,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				0,
				0
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3, false, tireSide)
	end
end
function brake4()
	if repairingPart and (repairingPart[2] == "frontBrakes" or repairingPart[2] == "rearBrakes") then
		sightexports.sGui:showInfobox("i", "Szereld le a régi fékeket!")
		screwMinigame = {
			repairingPart[1],
			"brake_" .. tireSide[2],
			repairFunctions[repairingPart[2]][5],
			false,
			true,
			{
				1,
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1,
				1
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 4, false, tireSide)
	end
end
function brake5()
	if repairingPart and repairingPart and (repairingPart[2] == "frontBrakes" or repairingPart[2] == "rearBrakes") then
		local obj = false
		if tireSide[2] == 1 then
			obj = "brake_fl"
		elseif tireSide[2] == 2 then
			obj = "brake_fr"
		elseif tireSide[2] == 3 then
			obj = "brake_rl"
		elseif tireSide[2] == 4 then
			obj = "brake_rr"
		end
		if obj and isElement(vehicleObjects[obj]) then
			local x, y, z = getElementPosition(vehicleObjects[obj])
			partAnimation = {
				repairingPart[1],
				"brake" .. tireSide[2],
				getTickCount(),
				x,
				y,
				z,
				repairFunctions[repairingPart[2]][6]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 5, false, tireSide)
		else
			repairFunctions[repairingPart[2]][6]()
		end
	end
end
function brake6()
	if repairingPart and (repairingPart[2] == "frontBrakes" or repairingPart[2] == "rearBrakes") then
		sightexports.sGui:showInfobox("i", "Szereld fel az új fékeket!")
		screwMinigame = {
			repairingPart[1],
			"brake_" .. tireSide[2],
			repairFunctions[repairingPart[2]][7],
			false,
			false,
			{
				0,
				0,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				0,
				0
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 6, false, tireSide)
	end
end
function brake7()
	if repairingPart and (repairingPart[2] == "frontBrakes" or repairingPart[2] == "rearBrakes") then
		setElementAlpha(repairingPart[1], 255)
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
repairFunctions.frontBrakes[1] = brake1
repairFunctions.frontBrakes[2] = brake2
repairFunctions.frontBrakes[3] = brake3
repairFunctions.frontBrakes[4] = brake4
repairFunctions.frontBrakes[5] = brake5
repairFunctions.frontBrakes[6] = brake6
repairFunctions.frontBrakes[7] = brake7
repairFunctions.rearBrakes[1] = brake1
repairFunctions.rearBrakes[2] = brake2
repairFunctions.rearBrakes[3] = brake3
repairFunctions.rearBrakes[4] = brake4
repairFunctions.rearBrakes[5] = brake5
repairFunctions.rearBrakes[6] = brake6
repairFunctions.rearBrakes[7] = brake7
repairFunctions.frontBumper[1] = function()
	if repairingPart and repairingPart[2] == "frontBumper" then
		local x, y, z = getComponentPosition(repairingPart[1], "bump_front_dummy")
		if x then
			sightexports.sGui:showInfobox("i", "Szereld le a régi lökhárítót!")
			screwMinigame = {
				repairingPart[1],
				"frontBumper",
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{
					1,
					1,
					1,
					1
				},
				{
					1,
					1,
					1,
					1
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		else
			repairFunctions.frontBumper[4]()
		end
	end
end
repairFunctions.frontBumper[2] = function()
	originalState.frontBumper = getVehiclePanelState(repairingPart[1], 5)
	local x, y, z = getVehicleComponentPosition(repairingPart[1], "bump_front_dummy", "root")
	partAnimation = {
		repairingPart[1],
		"frontBumper",
		getTickCount(),
		x,
		y,
		z,
		repairFunctions.frontBumper[3]
	}
	triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
end
repairFunctions.frontBumper[3] = function()
	if repairingPart and repairingPart[2] == "frontBumper" then
		triggerServerEvent("temporaryCosmeticFix", localPlayer)
		sightexports.sGui:showInfobox("i", "Szereld fel az új lökhárítót!")
		screwMinigame = {
			repairingPart[1],
			"frontBumper",
			repairFunctions[repairingPart[2]][4],
			false,
			false,
			{
				0,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				0
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3)
	end
end
repairFunctions.frontBumper[4] = function()
	if repairingPart and repairingPart[2] == "frontBumper" then
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
repairFunctions.rearBumper[1] = function()
	if repairingPart and repairingPart[2] == "rearBumper" then
		local x, y, z = getComponentPosition(repairingPart[1], "bump_rear_dummy")
		if x then
			sightexports.sGui:showInfobox("i", "Szereld le a régi lökhárítót!")
			screwMinigame = {
				repairingPart[1],
				"rearBumper",
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{
					1,
					1,
					1,
					1
				},
				{
					1,
					1,
					1,
					1
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		else
			repairFunctions.rearBumper[4]()
		end
	end
end
repairFunctions.rearBumper[2] = function()
	originalState.rearBumper = getVehiclePanelState(repairingPart[1], 6)
	local x, y, z = getVehicleComponentPosition(repairingPart[1], "bump_rear_dummy", "root")
	partAnimation = {
		repairingPart[1],
		"rearBumper",
		getTickCount(),
		x,
		y,
		z,
		repairFunctions.rearBumper[3]
	}
	triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
end
repairFunctions.rearBumper[3] = function()
	if repairingPart and repairingPart[2] == "rearBumper" then
		triggerServerEvent("temporaryCosmeticFix", localPlayer)
		sightexports.sGui:showInfobox("i", "Szereld fel az új lökhárítót!")
		screwMinigame = {
			repairingPart[1],
			"rearBumper",
			repairFunctions[repairingPart[2]][4],
			false,
			false,
			{
				0,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				0
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3)
	end
end
repairFunctions.rearBumper[4] = function()
	if repairingPart and repairingPart[2] == "rearBumper" then
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
repairFunctions.hood[1] = function()
	if repairingPart and repairingPart[2] == "hood" then
		local x, y, z = getComponentPosition(repairingPart[1], "bonnet_dummy")
		if x then
			sightexports.sGui:showInfobox("i", "Szereld le a régi motorháztetőt!")
			screwMinigame = {
				repairingPart[1],
				"hood",
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{
					1,
					1,
					1,
					1
				},
				{
					1,
					1,
					1,
					1
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		else
			repairFunctions.hood[4]()
		end
	end
end
repairFunctions.hood[2] = function()
	originalState.hood = getVehiclePanelState(repairingPart[1], 6)
	local x, y, z = getVehicleComponentPosition(repairingPart[1], "bonnet_dummy", "root")
	partAnimation = {
		repairingPart[1],
		"hood",
		getTickCount(),
		x,
		y,
		z,
		repairFunctions.hood[3]
	}
	triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
end
repairFunctions.hood[3] = function()
	if repairingPart and repairingPart[2] == "hood" then
		triggerServerEvent("temporaryCosmeticFix", localPlayer)
		sightexports.sGui:showInfobox("i", "Szereld fel az új motorháztetőt!")
		screwMinigame = {
			repairingPart[1],
			"hood",
			repairFunctions[repairingPart[2]][4],
			false,
			false,
			{
				0,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				0
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3)
	end
end
repairFunctions.hood[4] = function()
	if repairingPart and repairingPart[2] == "hood" then
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
repairFunctions.trunk[1] = function()
	if repairingPart and repairingPart[2] == "trunk" then
		local x, y, z = getComponentPosition(repairingPart[1], "boot_dummy")
		if x then
			sightexports.sGui:showInfobox("i", "Szereld le a régi csomagtartót!")
			screwMinigame = {
				repairingPart[1],
				"trunk",
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{
					1,
					1,
					1,
					1
				},
				{
					1,
					1,
					1,
					1
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		else
			repairFunctions.trunk[4]()
		end
	end
end
repairFunctions.trunk[2] = function()
	originalState.trunk = getVehiclePanelState(repairingPart[1], 6)
	local x, y, z = getVehicleComponentPosition(repairingPart[1], "boot_dummy", "root")
	partAnimation = {
		repairingPart[1],
		"trunk",
		getTickCount(),
		x,
		y,
		z,
		repairFunctions.trunk[3]
	}
	triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
end
repairFunctions.trunk[3] = function()
	if repairingPart and repairingPart[2] == "trunk" then
		triggerServerEvent("temporaryCosmeticFix", localPlayer)
		sightexports.sGui:showInfobox("i", "Szereld fel az új csomagtartót!")
		screwMinigame = {
			repairingPart[1],
			"trunk",
			repairFunctions[repairingPart[2]][4],
			false,
			false,
			{
				0,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				0
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3)
	end
end
repairFunctions.trunk[4] = function()
	if repairingPart and repairingPart[2] == "trunk" then
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
repairFunctions.frontLeftDoor[1] = function()
	if repairingPart and repairingPart[2] == "frontLeftDoor" then
		local x, y, z = getComponentPosition(repairingPart[1], "door_lf_dummy")
		if x then
			sightexports.sGui:showInfobox("i", "Szereld le a régi ajtót!")
			screwMinigame = {
				repairingPart[1],
				"frontLeftDoor",
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{
					1,
					1,
					1,
					1
				},
				{
					1,
					1,
					1,
					1
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		else
			repairFunctions.frontLeftDoor[4]()
		end
	end
end
repairFunctions.frontLeftDoor[2] = function()
	originalState.frontLeftDoor = getVehiclePanelState(repairingPart[1], 6)
	local x, y, z = getVehicleComponentPosition(repairingPart[1], "door_lf_dummy", "root")
	partAnimation = {
		repairingPart[1],
		"frontLeftDoor",
		getTickCount(),
		x,
		y,
		z,
		repairFunctions.frontLeftDoor[3]
	}
	triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
end
repairFunctions.frontLeftDoor[3] = function()
	if repairingPart and repairingPart[2] == "frontLeftDoor" then
		sightexports.sGui:showInfobox("i", "Szereld fel az új ajtót!")
		screwMinigame = {
			repairingPart[1],
			"frontLeftDoor",
			repairFunctions[repairingPart[2]][4],
			false,
			false,
			{
				0,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				0
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3)
	end
end
repairFunctions.frontLeftDoor[4] = function()
	if repairingPart and repairingPart[2] == "frontLeftDoor" then
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
repairFunctions.frontRightDoor[1] = function()
	if repairingPart and repairingPart[2] == "frontRightDoor" then
		local x, y, z = getComponentPosition(repairingPart[1], "door_rf_dummy")
		if x then
			sightexports.sGui:showInfobox("i", "Szereld le a régi ajtót!")
			screwMinigame = {
				repairingPart[1],
				"frontRightDoor",
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{
					1,
					1,
					1,
					1
				},
				{
					1,
					1,
					1,
					1
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		else
			repairFunctions.frontRightDoor[4]()
		end
	end
end
repairFunctions.frontRightDoor[2] = function()
	originalState.frontRightDoor = getVehiclePanelState(repairingPart[1], 6)
	local x, y, z = getVehicleComponentPosition(repairingPart[1], "door_rf_dummy", "root")
	partAnimation = {
		repairingPart[1],
		"frontRightDoor",
		getTickCount(),
		x,
		y,
		z,
		repairFunctions.frontRightDoor[3]
	}
	triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
end
repairFunctions.frontRightDoor[3] = function()
	if repairingPart and repairingPart[2] == "frontRightDoor" then
		triggerServerEvent("temporaryCosmeticFix", localPlayer)
		sightexports.sGui:showInfobox("i", "Szereld fel az új ajtót!")
		screwMinigame = {
			repairingPart[1],
			"frontRightDoor",
			repairFunctions[repairingPart[2]][4],
			false,
			false,
			{
				0,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				0
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3)
	end
end
repairFunctions.frontRightDoor[4] = function()
	if repairingPart and repairingPart[2] == "frontRightDoor" then
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
repairFunctions.rearLeftDoor[1] = function()
	if repairingPart and repairingPart[2] == "rearLeftDoor" then
		local x, y, z = getComponentPosition(repairingPart[1], "door_lr_dummy")
		if x then
			sightexports.sGui:showInfobox("i", "Szereld le a régi ajtót!")
			screwMinigame = {
				repairingPart[1],
				"rearLeftDoor",
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{
					1,
					1,
					1,
					1
				},
				{
					1,
					1,
					1,
					1
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		else
			repairFunctions.rearLeftDoor[4]()
		end
	end
end
repairFunctions.rearLeftDoor[2] = function()
	originalState.rearLeftDoor = getVehiclePanelState(repairingPart[1], 6)
	local x, y, z = getVehicleComponentPosition(repairingPart[1], "door_lr_dummy", "root")
	partAnimation = {
		repairingPart[1],
		"rearLeftDoor",
		getTickCount(),
		x,
		y,
		z,
		repairFunctions.rearLeftDoor[3]
	}
	triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
end
repairFunctions.rearLeftDoor[3] = function()
	if repairingPart and repairingPart[2] == "rearLeftDoor" then
		triggerServerEvent("temporaryCosmeticFix", localPlayer)
		sightexports.sGui:showInfobox("i", "Szereld fel az új ajtót!")
		screwMinigame = {
			repairingPart[1],
			"rearLeftDoor",
			repairFunctions[repairingPart[2]][4],
			false,
			false,
			{
				0,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				0
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3)
	end
end
repairFunctions.rearLeftDoor[4] = function()
	if repairingPart and repairingPart[2] == "rearLeftDoor" then
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
repairFunctions.rearRightDoor[1] = function()
	if repairingPart and repairingPart[2] == "rearRightDoor" then
		local x, y, z = getComponentPosition(repairingPart[1], "door_rr_dummy")
		if x then
			sightexports.sGui:showInfobox("i", "Szereld le a régi ajtót!")
			screwMinigame = {
				repairingPart[1],
				"rearRightDoor",
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{
					1,
					1,
					1,
					1
				},
				{
					1,
					1,
					1,
					1
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		else
			repairFunctions.rearRightDoor[4]()
		end
	end
end
repairFunctions.rearRightDoor[2] = function()
	originalState.rearRightDoor = getVehiclePanelState(repairingPart[1], 6)
	local x, y, z = getVehicleComponentPosition(repairingPart[1], "door_rr_dummy", "root")
	partAnimation = {
		repairingPart[1],
		"rearRightDoor",
		getTickCount(),
		x,
		y,
		z,
		repairFunctions.rearRightDoor[3]
	}
	triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
end
repairFunctions.rearRightDoor[3] = function()
	if repairingPart and repairingPart[2] == "rearRightDoor" then
		triggerServerEvent("temporaryCosmeticFix", localPlayer)
		sightexports.sGui:showInfobox("i", "Szereld fel az új ajtót!")
		screwMinigame = {
			repairingPart[1],
			"rearRightDoor",
			repairFunctions[repairingPart[2]][4],
			false,
			false,
			{
				0,
				0,
				0,
				0
			},
			{
				0,
				0,
				0,
				0
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3)
	end
end
repairFunctions.rearRightDoor[4] = function()
	if repairingPart and repairingPart[2] == "rearRightDoor" then
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
function light1()
	if repairingPart and (repairingPart[2] == "frontLeftLight" or repairingPart[2] == "frontRightLight" or repairingPart[2] == "rearLeftLight" or repairingPart[2] == "rearRightLight") then
		local comp = false
		if repairingPart[2] == "frontLeftLight" then
			comp = "headlights_left"
		elseif repairingPart[2] == "frontRightLight" then
			comp = "headlights_right"
		elseif repairingPart[2] == "rearLeftLight" then
			comp = "taillights_left"
		elseif repairingPart[2] == "rearRightLight" then
			comp = "taillights_right"
		end
		local x, y, z = getComponentPosition(repairingPart[1], comp)
		if x then
			sightexports.sGui:showInfobox("i", "Szereld le a régi fényszórót!")
			screwMinigame = {
				repairingPart[1],
				repairingPart[2],
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{1, 1},
				{1, 1}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		else
			repairFunctions[repairingPart[2]][3]()
		end
	end
end
function light2()
	if repairingPart and (repairingPart[2] == "frontLeftLight" or repairingPart[2] == "frontRightLight" or repairingPart[2] == "rearLeftLight" or repairingPart[2] == "rearRightLight") then
		triggerServerEvent("temporaryCosmeticFix", localPlayer)
		sightexports.sGui:showInfobox("i", "Szereld fel az új fényszórót!")
		screwMinigame = {
			repairingPart[1],
			repairingPart[2],
			repairFunctions[repairingPart[2]][3],
			false,
			false,
			{0, 0},
			{0, 0}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
	end
end
function light3()
	if repairingPart and (repairingPart[2] == "frontLeftLight" or repairingPart[2] == "frontRightLight" or repairingPart[2] == "rearLeftLight" or repairingPart[2] == "rearRightLight") then
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
repairFunctions.frontLeftLight[1] = light1
repairFunctions.frontLeftLight[2] = light2
repairFunctions.frontLeftLight[3] = light3
repairFunctions.frontRightLight[1] = light1
repairFunctions.frontRightLight[2] = light2
repairFunctions.frontRightLight[3] = light3
repairFunctions.rearLeftLight[1] = light1
repairFunctions.rearLeftLight[2] = light2
repairFunctions.rearLeftLight[3] = light3
repairFunctions.rearRightLight[1] = light1
repairFunctions.rearRightLight[2] = light2
repairFunctions.rearRightLight[3] = light3
repairFunctions.engineTimingKit[1] = function()
	if repairingPart and repairingPart[2] == "engineTimingKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			createMinigameObj("engine")
			sightexports.sGui:showInfobox("i", "Szereld le a szelepfedelet!")
			screwMinigame = {
				repairingPart[1],
				"valve",
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{
					1,
					1,
					1,
					1,
					1,
					1,
					1,
					1
				},
				{
					1,
					1,
					1,
					1,
					1,
					1,
					1,
					1
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		else
			repairFunctions.engineTimingKit[8]()
		end
	end
end
repairFunctions.engineTimingKit[2] = function()
	if repairingPart and repairingPart[2] == "engineTimingKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			partAnimation = {
				repairingPart[1],
				"valveoff",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineTimingKit[3]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
		else
			repairFunctions.engineTimingKit[3]()
		end
	end
end
repairFunctions.engineTimingKit[3] = function()
	if repairingPart and repairingPart[2] == "engineTimingKit" then
		if isElement(engineParts.valve_cover) then
			destroyElement(engineParts.valve_cover)
		end
		engineParts.valve_cover = nil
		if isElement(engineParts.valve_gasket) then
			destroyElement(engineParts.valve_gasket)
		end
		engineParts.valve_gasket = nil
		sightexports.sGui:showInfobox("i", "Szereld le a régi vezérlést!")
		screwMinigame = {
			repairingPart[1],
			"timing",
			repairFunctions[repairingPart[2]][4],
			false,
			true,
			{
				1,
				1,
				1
			},
			{
				1,
				1,
				1
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3)
	end
end
repairFunctions.engineTimingKit[4] = function()
	if repairingPart and repairingPart[2] == "engineTimingKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			partAnimation = {
				repairingPart[1],
				"timing",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineTimingKit[5]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 4)
		else
			repairFunctions.engineTimingKit[5]()
		end
	end
end
repairFunctions.engineTimingKit[5] = function()
	if repairingPart and repairingPart[2] == "engineTimingKit" then
		sightexports.sGui:showInfobox("i", "Szereld fel az új vezérlést!")
		screwMinigame = {
			repairingPart[1],
			"timing",
			repairFunctions[repairingPart[2]][6],
			false,
			false,
			{
				0,
				0,
				0
			},
			{
				0,
				0,
				0
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 5)
	end
end
repairFunctions.engineTimingKit[6] = function()
	if repairingPart and repairingPart[2] == "engineTimingKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			if isElement(engineParts.valve_cover) then
				destroyElement(engineParts.valve_cover)
			end
			engineParts.valve_cover = createObject(objectModels.valve_cover, 0, 0, 0)
			setElementDoubleSided(engineParts.valve_cover, true)
			setElementCollisionsEnabled(engineParts.valve_cover, false)
			if isElement(engineParts.valve_gasket) then
				destroyElement(engineParts.valve_gasket)
			end
			engineParts.valve_gasket = createObject(objectModels.valve_gasket, 0, 0, 0)
			setElementDoubleSided(engineParts.valve_gasket, true)
			setElementCollisionsEnabled(engineParts.valve_gasket, false)
			partAnimation = {
				repairingPart[1],
				"valveon",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineTimingKit[7]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 6)
		else
			repairFunctions.engineTimingKit[3]()
		end
	end
end
repairFunctions.engineTimingKit[7] = function()
	if repairingPart and repairingPart[2] == "engineTimingKit" then
		sightexports.sGui:showInfobox("i", "Szereld fel a szelepfedelet!")
		screwMinigame = {
			repairingPart[1],
			"valve",
			repairFunctions[repairingPart[2]][8],
			false,
			false,
			{
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0
			},
			{
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
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 7)
	end
end
repairFunctions.engineTimingKit[8] = function()
	if repairingPart and repairingPart[2] == "engineTimingKit" then
		createMinigameObj(false)
		setElementAlpha(repairingPart[1], 255)
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
repairFunctions.engineRepairKit[1] = function()
	if repairingPart and repairingPart[2] == "engineRepairKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			createMinigameObj("engine")
			sightexports.sGui:showInfobox("i", "Szereld le a szelepfedelet!")
			screwMinigame = {
				repairingPart[1],
				"valve",
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{
					1,
					1,
					1,
					1,
					1,
					1,
					1,
					1
				},
				{
					1,
					1,
					1,
					1,
					1,
					1,
					1,
					1
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		else
			repairFunctions.engineRepairKit[8]()
		end
	end
end
repairFunctions.engineRepairKit[2] = function()
	if repairingPart and repairingPart[2] == "engineRepairKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			partAnimation = {
				repairingPart[1],
				"valveoff",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineRepairKit[3]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
		else
			repairFunctions.engineRepairKit[3]()
		end
	end
end
repairFunctions.engineRepairKit[3] = function()
	if repairingPart and repairingPart[2] == "engineRepairKit" then
		if isElement(engineParts.valve_cover) then
			destroyElement(engineParts.valve_cover)
		end
		engineParts.valve_cover = nil
		if isElement(engineParts.valve_gasket) then
			destroyElement(engineParts.valve_gasket)
		end
		engineParts.valve_gasket = nil
		sightexports.sGui:showInfobox("i", "Szereld le a vezérlést!")
		screwMinigame = {
			repairingPart[1],
			"timing",
			repairFunctions[repairingPart[2]][4],
			false,
			true,
			{
				1,
				1,
				1
			},
			{
				1,
				1,
				1
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3)
	end
end
repairFunctions.engineRepairKit[4] = function()
	if repairingPart and repairingPart[2] == "engineRepairKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			partAnimation = {
				repairingPart[1],
				"timingoff",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineRepairKit[5]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 4)
		else
			repairFunctions.engineRepairKit[5]()
		end
	end
end
repairFunctions.engineRepairKit[5] = function()
	if repairingPart and repairingPart[2] == "engineRepairKit" then
		if isElement(engineParts.timing_belt) then
			destroyElement(engineParts.timing_belt)
		end
		engineParts.timing_belt = nil
		sightexports.sGui:showInfobox("i", "Szereld le a hengerfejet, hogy ki tudd cserélni a tömítést!")
		screwMinigame = {
			repairingPart[1],
			"head",
			repairFunctions[repairingPart[2]][6],
			false,
			true,
			{
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
			},
			{
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
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 5)
	end
end
repairFunctions.engineRepairKit[6] = function()
	if repairingPart and repairingPart[2] == "engineRepairKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			partAnimation = {
				repairingPart[1],
				"headoff",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineRepairKit[7]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 6)
		else
			repairFunctions.engineRepairKit[7]()
		end
	end
end
repairFunctions.engineRepairKit[7] = function()
	if repairingPart and repairingPart[2] == "engineRepairKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			if isElement(engineParts.cylinder_head) then
				destroyElement(engineParts.cylinder_head)
			end
			engineParts.cylinder_head = nil
			partAnimation = {
				repairingPart[1],
				"headgasket",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineRepairKit[8]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 7)
		else
			repairFunctions.engineRepairKit[8]()
		end
	end
end
repairFunctions.engineRepairKit[8] = function()
	if repairingPart and repairingPart[2] == "engineRepairKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			if isElement(engineParts.cylinder_head) then
				destroyElement(engineParts.cylinder_head)
			end
			engineParts.cylinder_head = createObject(objectModels.cylinder_head, 0, 0, 0)
			setElementDoubleSided(engineParts.cylinder_head, true)
			setElementCollisionsEnabled(engineParts.cylinder_head, false)
			partAnimation = {
				repairingPart[1],
				"headon",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineRepairKit[9]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 8)
		else
			repairFunctions.engineRepairKit[9]()
		end
	end
end
repairFunctions.engineRepairKit[9] = function()
	if repairingPart and repairingPart[2] == "engineRepairKit" then
		sightexports.sGui:showInfobox("i", "Szereld vissza a hengerfejet!")
		screwMinigame = {
			repairingPart[1],
			"head",
			repairFunctions[repairingPart[2]][10],
			false,
			false,
			{
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
			},
			{
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
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 9)
	end
end
repairFunctions.engineRepairKit[10] = function()
	if repairingPart and repairingPart[2] == "engineRepairKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			if isElement(engineParts.timing_belt) then
				destroyElement(engineParts.timing_belt)
			end
			engineParts.timing_belt = createObject(objectModels.timing_belt, 0, 0, 0)
			setElementDoubleSided(engineParts.timing_belt, true)
			setElementCollisionsEnabled(engineParts.timing_belt, false)
			partAnimation = {
				repairingPart[1],
				"timingon",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineRepairKit[11]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 10)
		else
			repairFunctions.engineRepairKit[11]()
		end
	end
end
repairFunctions.engineRepairKit[11] = function()
	if repairingPart and repairingPart[2] == "engineRepairKit" then
		sightexports.sGui:showInfobox("i", "Szereld fel a vezérlést!")
		screwMinigame = {
			repairingPart[1],
			"timing",
			repairFunctions[repairingPart[2]][12],
			false,
			false,
			{
				0,
				0,
				0
			},
			{
				0,
				0,
				0
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 11)
	end
end
repairFunctions.engineRepairKit[12] = function()
	if repairingPart and repairingPart[2] == "engineRepairKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			if isElement(engineParts.valve_cover) then
				destroyElement(engineParts.valve_cover)
			end
			engineParts.valve_cover = createObject(objectModels.valve_cover, 0, 0, 0)
			setElementDoubleSided(engineParts.valve_cover, true)
			setElementCollisionsEnabled(engineParts.valve_cover, false)
			if isElement(engineParts.valve_gasket) then
				destroyElement(engineParts.valve_gasket)
			end
			engineParts.valve_gasket = createObject(objectModels.valve_gasket, 0, 0, 0)
			setElementDoubleSided(engineParts.valve_gasket, true)
			setElementCollisionsEnabled(engineParts.valve_gasket, false)
			partAnimation = {
				repairingPart[1],
				"valveon",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineRepairKit[13]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 12)
		else
			repairFunctions.engineRepairKit[13]()
		end
	end
end
repairFunctions.engineRepairKit[13] = function()
	if repairingPart and repairingPart[2] == "engineRepairKit" then
		sightexports.sGui:showInfobox("i", "Szereld fel a szelepfedelet!")
		screwMinigame = {
			repairingPart[1],
			"valve",
			repairFunctions[repairingPart[2]][14],
			false,
			false,
			{
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0
			},
			{
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
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 13)
	end
end
repairFunctions.engineRepairKit[14] = function()
	if repairingPart and repairingPart[2] == "engineRepairKit" then
		createMinigameObj(false)
		setElementAlpha(repairingPart[1], 255)
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
repairFunctions.engineGeneralKit[1] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			createMinigameObj("engine")
			sightexports.sGui:showInfobox("i", "Szereld le a szelepfedelet!")
			screwMinigame = {
				repairingPart[1],
				"valve",
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{
					1,
					1,
					1,
					1,
					1,
					1,
					1,
					1
				},
				{
					1,
					1,
					1,
					1,
					1,
					1,
					1,
					1
				}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		else
			repairFunctions.engineGeneralKit[8]()
		end
	end
end
repairFunctions.engineGeneralKit[2] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			partAnimation = {
				repairingPart[1],
				"valveoff",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineGeneralKit[3]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
		else
			repairFunctions.engineGeneralKit[3]()
		end
	end
end
repairFunctions.engineGeneralKit[3] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		if isElement(engineParts.valve_cover) then
			destroyElement(engineParts.valve_cover)
		end
		engineParts.valve_cover = nil
		if isElement(engineParts.valve_gasket) then
			destroyElement(engineParts.valve_gasket)
		end
		engineParts.valve_gasket = nil
		sightexports.sGui:showInfobox("i", "Szereld le a régi vezérlést!")
		screwMinigame = {
			repairingPart[1],
			"timing",
			repairFunctions[repairingPart[2]][4],
			false,
			true,
			{
				1,
				1,
				1
			},
			{
				1,
				1,
				1
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3)
	end
end
repairFunctions.engineGeneralKit[4] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			partAnimation = {
				repairingPart[1],
				"timingoff",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineGeneralKit[5]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 4)
		else
			repairFunctions.engineGeneralKit[5]()
		end
	end
end
repairFunctions.engineGeneralKit[5] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		if isElement(engineParts.timing_belt) then
			destroyElement(engineParts.timing_belt)
		end
		engineParts.timing_belt = nil
		sightexports.sGui:showInfobox("i", "Szereld le a régi hengerfejet!")
		screwMinigame = {
			repairingPart[1],
			"head",
			repairFunctions[repairingPart[2]][6],
			false,
			true,
			{
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
			},
			{
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
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 5)
	end
end
repairFunctions.engineGeneralKit[6] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			partAnimation = {
				repairingPart[1],
				"headoff",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineGeneralKit[7]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 6)
		else
			repairFunctions.engineGeneralKit[7]()
		end
	end
end
repairFunctions.engineGeneralKit[7] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			if isElement(engineParts.cylinder_head) then
				destroyElement(engineParts.cylinder_head)
			end
			engineParts.cylinder_head = nil
			partAnimation = {
				repairingPart[1],
				"headgasketoff",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineGeneralKit[8]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 7)
		else
			repairFunctions.engineGeneralKit[8]()
		end
	end
end
repairFunctions.engineGeneralKit[8] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			if isElement(engineParts.gasket) then
				destroyElement(engineParts.gasket)
			end
			engineParts.gasket = nil
			sightexports.sGui:showInfobox("i", "Tekerd ki az olajleeresztő csavart!")
			if isVehicleOnGround(repairingPart[1]) then
				sightexports.sGui:showInfobox("i", "A csavar kitekeréséhez fel kell emelned az autót!")
			end
			screwMinigame = {
				repairingPart[1],
				"oil1",
				repairFunctions[repairingPart[2]][9],
				false,
				true,
				{1},
				{1}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 8)
		else
			repairFunctions.engineGeneralKit[9]()
		end
	end
end
repairFunctions.engineGeneralKit[9] = function()
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = createObject(objectModels.oil_drain_can, 0, 0, 0)
	setElementCollisionsEnabled(oilObject, false)
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = dxCreateTexture("files/oiltexture.dds")
	partAnimation = {
		repairingPart[1],
		"oil",
		getTickCount(),
		0,
		0,
		0,
		repairFunctions.engineGeneralKit[10]
	}
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		playSound3D("files/oildrain.mp3", x, y, z)
	end
	triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 9)
end
repairFunctions.engineGeneralKit[10] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		if isElement(oilObject) then
			destroyElement(oilObject)
		end
		oilObject = false
		if isElement(oilTexture) then
			destroyElement(oilTexture)
		end
		oilTexture = false
		sightexports.sGui:showInfobox("i", "Szereld le a régi olajteknőt!")
		if isVehicleOnGround(repairingPart[1]) then
			sightexports.sGui:showInfobox("i", "A olajteknő leszereléséhez fel kell emelned az autót!")
		end
		screwMinigame = {
			repairingPart[1],
			"sump",
			repairFunctions[repairingPart[2]][11],
			false,
			true,
			{
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
			},
			{
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
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 10)
	end
end
repairFunctions.engineGeneralKit[11] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			partAnimation = {
				repairingPart[1],
				"sumpoff",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineGeneralKit[12]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 11)
		else
			repairFunctions.engineGeneralKit[12]()
		end
	end
end
repairFunctions.engineGeneralKit[12] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		if isElement(engineParts.oil_sump) then
			destroyElement(engineParts.oil_sump)
		end
		engineParts.oil_sump = nil
		if isElement(engineParts.oil_gasket) then
			destroyElement(engineParts.oil_gasket)
		end
		engineParts.oil_gasket = nil
		sightexports.sGui:showInfobox("i", "Szereld ki a régi dugattyúkat!")
		screwMinigame = {
			repairingPart[1],
			"piston",
			repairFunctions[repairingPart[2]][13],
			false,
			true,
			{
				1,
				1,
				1,
				1,
				1,
				1,
				1,
				1
			},
			{
				1,
				1,
				1,
				1,
				1,
				1,
				1,
				1
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 12)
	end
end
repairFunctions.engineGeneralKit[13] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			partAnimation = {
				repairingPart[1],
				"piston",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineGeneralKit[14]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 13)
		else
			repairFunctions.engineGeneralKit[14]()
		end
	end
end
repairFunctions.engineGeneralKit[14] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		sightexports.sGui:showInfobox("i", "Szereld be az új dugattyúkat!")
		screwMinigame = {
			repairingPart[1],
			"piston",
			repairFunctions[repairingPart[2]][15],
			false,
			false,
			{
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0
			},
			{
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
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 14)
	end
end
repairFunctions.engineGeneralKit[15] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			if isElement(engineParts.oil_sump) then
				destroyElement(engineParts.oil_sump)
			end
			engineParts.oil_sump = createObject(objectModels.oil_sump, 0, 0, 0)
			setElementDoubleSided(engineParts.oil_sump, true)
			setElementCollisionsEnabled(engineParts.oil_sump, false)
			if isElement(engineParts.oil_gasket) then
				destroyElement(engineParts.oil_gasket)
			end
			engineParts.oil_gasket = createObject(objectModels.oil_gasket, 0, 0, 0)
			setElementDoubleSided(engineParts.oil_gasket, true)
			setElementCollisionsEnabled(engineParts.oil_gasket, false)
			partAnimation = {
				repairingPart[1],
				"sumpon",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineGeneralKit[16]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 15)
		else
			repairFunctions.engineGeneralKit[16]()
		end
	end
end
repairFunctions.engineGeneralKit[16] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		sightexports.sGui:showInfobox("i", "Szereld fel az új olajteknőt!")
		screwMinigame = {
			repairingPart[1],
			"sump",
			repairFunctions[repairingPart[2]][17],
			false,
			false,
			{
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
			},
			{
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
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 16)
	end
end
repairFunctions.engineGeneralKit[17] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		sightexports.sGui:showInfobox("i", "Tekerd be az új olajleeresztő csavart!")
		screwMinigame = {
			repairingPart[1],
			"oil1",
			repairFunctions[repairingPart[2]][18],
			false,
			false,
			{0},
			{0}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 17)
	end
end
repairFunctions.engineGeneralKit[18] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			if isElement(engineParts.gasket) then
				destroyElement(engineParts.gasket)
			end
			engineParts.gasket = createObject(objectModels.gasket, 0, 0, 0)
			setElementDoubleSided(engineParts.gasket, true)
			setElementCollisionsEnabled(engineParts.gasket, false)
			partAnimation = {
				repairingPart[1],
				"headgasketon",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineGeneralKit[19]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 18)
		else
			repairFunctions.engineGeneralKit[19]()
		end
	end
end
repairFunctions.engineGeneralKit[19] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			if isElement(engineParts.cylinder_head) then
				destroyElement(engineParts.cylinder_head)
			end
			engineParts.cylinder_head = createObject(objectModels.cylinder_head, 0, 0, 0)
			setElementDoubleSided(engineParts.cylinder_head, true)
			setElementCollisionsEnabled(engineParts.cylinder_head, false)
			partAnimation = {
				repairingPart[1],
				"headon",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineGeneralKit[20]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 19)
		else
			repairFunctions.engineGeneralKit[20]()
		end
	end
end
repairFunctions.engineGeneralKit[20] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		sightexports.sGui:showInfobox("i", "Szereld fel az új hengerfejet!")
		screwMinigame = {
			repairingPart[1],
			"head",
			repairFunctions[repairingPart[2]][21],
			false,
			false,
			{
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
			},
			{
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
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 20)
	end
end
repairFunctions.engineGeneralKit[21] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			if isElement(engineParts.timing_belt) then
				destroyElement(engineParts.timing_belt)
			end
			engineParts.timing_belt = createObject(objectModels.timing_belt, 0, 0, 0)
			setElementDoubleSided(engineParts.timing_belt, true)
			setElementCollisionsEnabled(engineParts.timing_belt, false)
			partAnimation = {
				repairingPart[1],
				"timingon",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineGeneralKit[22]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 21)
		else
			repairFunctions.engineGeneralKit[22]()
		end
	end
end
repairFunctions.engineGeneralKit[22] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		sightexports.sGui:showInfobox("i", "Szereld fel az új vezérlést!")
		screwMinigame = {
			repairingPart[1],
			"timing",
			repairFunctions[repairingPart[2]][23],
			false,
			false,
			{
				0,
				0,
				0
			},
			{
				0,
				0,
				0
			}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 22)
	end
end
repairFunctions.engineGeneralKit[23] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			if isElement(engineParts.valve_cover) then
				destroyElement(engineParts.valve_cover)
			end
			engineParts.valve_cover = createObject(objectModels.valve_cover, 0, 0, 0)
			setElementDoubleSided(engineParts.valve_cover, true)
			setElementCollisionsEnabled(engineParts.valve_cover, false)
			if isElement(engineParts.valve_gasket) then
				destroyElement(engineParts.valve_gasket)
			end
			engineParts.valve_gasket = createObject(objectModels.valve_gasket, 0, 0, 0)
			setElementDoubleSided(engineParts.valve_gasket, true)
			setElementCollisionsEnabled(engineParts.valve_gasket, false)
			partAnimation = {
				repairingPart[1],
				"valveon",
				getTickCount(),
				x,
				y,
				z,
				repairFunctions.engineGeneralKit[24]
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 23)
		else
			repairFunctions.engineGeneralKit[24]()
		end
	end
end
repairFunctions.engineGeneralKit[24] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		sightexports.sGui:showInfobox("i", "Szereld fel a szelepfedelet!")
		screwMinigame = {
			repairingPart[1],
			"valve",
			repairFunctions[repairingPart[2]][25],
			false,
			false,
			{
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0
			},
			{
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
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 24)
	end
end
repairFunctions.engineGeneralKit[25] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		sightexports.sGui:showInfobox("i", "Vedd le az olajbeöntő sapkát!")
		screwMinigame = {
			repairingPart[1],
			"oil2",
			repairFunctions[repairingPart[2]][26],
			false,
			true,
			{1},
			{1}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 25)
	end
end
repairFunctions.engineGeneralKit[26] = function()
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = createObject(objectModels.motoroil, 0, 0, 0)
	setElementCollisionsEnabled(oilObject, false)
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = dxCreateTexture("files/oiltexture2.dds")
	partAnimation = {
		repairingPart[1],
		"oilin",
		getTickCount(),
		0,
		0,
		0,
		repairFunctions.engineGeneralKit[27]
	}
	triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 26)
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		playSound3D("files/oilin.mp3", x, y, z)
	end
end
repairFunctions.engineGeneralKit[27] = function()
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = false
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = false
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		sightexports.sGui:showInfobox("i", "Tedd vissza az olajbeöntő sapkát!")
		screwMinigame = {
			repairingPart[1],
			"oil2",
			repairFunctions[repairingPart[2]][28],
			false,
			false,
			{0},
			{0}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 27)
	end
end
repairFunctions.engineGeneralKit[28] = function()
	if repairingPart and repairingPart[2] == "engineGeneralKit" then
		createMinigameObj(false)
		setElementAlpha(repairingPart[1], 255)
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
repairFunctions.oilChangeKit[1] = function()
	if repairingPart and repairingPart[2] == "oilChangeKit" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			createMinigameObj("engine")
			sightexports.sGui:showInfobox("i", "Tekerd ki az olajleeresztő csavart!")
			if isVehicleOnGround(repairingPart[1]) then
				sightexports.sGui:showInfobox("i", "A csavar leszereléséhez fel kell emelned az autót!")
			end
			screwMinigame = {
				repairingPart[1],
				"oil1",
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{1},
				{1}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		else
			repairFunctions.oilChangeKit[7]()
		end
	end
end
repairFunctions.oilChangeKit[2] = function()
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = createObject(objectModels.oil_drain_can, 0, 0, 0)
	setElementCollisionsEnabled(oilObject, false)
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = dxCreateTexture("files/oiltexture.dds")
	partAnimation = {
		repairingPart[1],
		"oil",
		getTickCount(),
		0,
		0,
		0,
		repairFunctions.oilChangeKit[3]
	}
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		playSound3D("files/oildrain.mp3", x, y, z)
	end
	triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
end
repairFunctions.oilChangeKit[3] = function()
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = false
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = false
	if repairingPart and repairingPart[2] == "oilChangeKit" then
		sightexports.sGui:showInfobox("i", "Tekerd be az új olajleeresztő csavart!")
		screwMinigame = {
			repairingPart[1],
			"oil1",
			repairFunctions[repairingPart[2]][4],
			false,
			false,
			{0},
			{0}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3)
	end
end
repairFunctions.oilChangeKit[4] = function()
	if repairingPart and repairingPart[2] == "oilChangeKit" then
		sightexports.sGui:showInfobox("i", "Vedd le az olajbeöntő sapkát!")
		screwMinigame = {
			repairingPart[1],
			"oil2",
			repairFunctions[repairingPart[2]][5],
			false,
			true,
			{1},
			{1}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 4)
	end
end
repairFunctions.oilChangeKit[5] = function()
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = createObject(objectModels.motoroil, 0, 0, 0)
	setElementCollisionsEnabled(oilObject, false)
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = dxCreateTexture("files/oiltexture2.dds")
	partAnimation = {
		repairingPart[1],
		"oilin",
		getTickCount(),
		0,
		0,
		0,
		repairFunctions.oilChangeKit[6]
	}
	local x, y, z = getComponentPosition(closestVeh, "engine")
	if x then
		playSound3D("files/oilin.mp3", x, y, z)
	end
	triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 5)
end
repairFunctions.oilChangeKit[6] = function()
	if isElement(oilObject) then
		destroyElement(oilObject)
	end
	oilObject = false
	if isElement(oilTexture) then
		destroyElement(oilTexture)
	end
	oilTexture = false
	if repairingPart and repairingPart[2] == "oilChangeKit" then
		sightexports.sGui:showInfobox("i", "Tedd vissza az olajbeöntő sapkát!")
		screwMinigame = {
			repairingPart[1],
			"oil2",
			repairFunctions[repairingPart[2]][7],
			false,
			false,
			{0},
			{0}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 6)
	end
end
repairFunctions.oilChangeKit[7] = function()
	if repairingPart and repairingPart[2] == "oilChangeKit" then
		createMinigameObj(false)
		setElementAlpha(repairingPart[1], 255)
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
repairFunctions.battery[1] = function()
	if repairingPart and repairingPart[2] == "battery" then
		local x, y, z = getComponentPosition(repairingPart[1], "engine")
		if x then
			local model = getElementData(repairingPart[1], "vehicle.customModel") or getElementModel(repairingPart[1])
			if evVehicles[model] then
				createMinigameObj("battery")
			else
				createMinigameObj("engine")
			end
			sightexports.sGui:showInfobox("i", "Szereld ki a régi akkumulátort!")
			screwMinigame = {
				repairingPart[1],
				"battery",
				repairFunctions[repairingPart[2]][2],
				false,
				true,
				{1, 1},
				{1, 1}
			}
			triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 1)
		else
			repairFunctions.battery[7]()
		end
	end
end
repairFunctions.battery[2] = function()
	local x, y, z = getComponentPosition(repairingPart[1], "engine")
	if x then
		partAnimation = {
			repairingPart[1],
			"battery",
			getTickCount(),
			0,
			0,
			0,
			repairFunctions.battery[3]
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 2)
	else
		repairFunctions.battery[3]()
	end
end
repairFunctions.battery[3] = function()
	if repairingPart and repairingPart[2] == "battery" then
		sightexports.sGui:showInfobox("i", "Szereld be az új akkumulátort!")
		screwMinigame = {
			repairingPart[1],
			"battery",
			repairFunctions[repairingPart[2]][4],
			false,
			false,
			{0, 0},
			{0, 0}
		}
		triggerServerEvent("syncSpectatorState", localPlayer, repairingPart[1], repairingPart[2], 3)
	end
end
repairFunctions.battery[4] = function()
	if repairingPart and repairingPart[2] == "battery" then
		createMinigameObj(false)
		setElementAlpha(repairingPart[1], 255)
		triggerServerEvent("finalRepairPart", localPlayer, repairingPart[1], repairingPart[2])
		repairingPart = false
	end
end
addEvent("repairingPart", true)
addEventHandler("repairingPart", getRootElement(), function(veh, part)
	if veh and part then
		repairingPart = {veh, part}
		if repairFunctions[part] then
			repairFunctions[part][1]()
		else
			triggerServerEvent("finalRepairPart", localPlayer, veh, part)
			repairingPart = false
		end
	else
		repairingPart = false
	end
	repairingResponse = false
end)
addEvent("selectManufacturer", false)
addEventHandler("selectManufacturer", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if manufacturerButtons[el] and selectedManufacturer ~= manufacturerButtons[el] then
		selectedManufacturer = manufacturerButtons[el] + manufacturerScroll
		selectedModel = false
		selectedPart = false
		modelScroll = 0
		createMechanicOrderGui()
	end
end)
addEvent("selectModel", false)
addEventHandler("selectModel", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if modelButtons[el] and selectedModel ~= modelButtons[el] then
		selectedModel = modelButtons[el] + modelScroll
		selectedPart = false
		createMechanicOrderGui()
	end
end)
addEvent("selectCategory", false)
addEventHandler("selectCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if categoryButtons[el] and selectedCategory ~= categoryButtons[el] then
		selectedCategory = categoryButtons[el]
		selectedPart = selectedPart and 0 or false
		createMechanicOrderGui()
	end
end)
addEvent("selectPart", false)
addEventHandler("selectPart", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if partButtons[el] and selectedPart ~= partButtons[el] then
		selectedPart = partButtons[el]
		createMechanicOrderGui()
	end
end)
addEvent("backToModel", false)
addEventHandler("backToModel", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if selectedPart then
		selectedPart = false
		createMechanicOrderGui()
	end
end)
local orderedPartsList = {}
local orderedParts = {}
local orderedPartsCost = 0
local orderPerMake = {}
local orderPerModel = {}
local orderPerCategory = {}
local orderPerPart = {}
local stockInformation = {}
local stockLabels = {}
local orderStockLabels = {}
local stockLabelsEx = {}
local partCheckboxesEx = {}
addEvent("gotMechanicPartStock", true)
addEventHandler("gotMechanicPartStock", getRootElement(), function(data)
	for i = 1, #data do
		stockInformation[data[i][1]] = {
			data[i][2],
			data[i][3],
			data[i][4],
			data[i][5],
			data[i][6]
		}
		local label = stockLabelsEx[data[i][1]]
		if label then
			local col = false
			if data[i][2] <= 0 then
				col = sightexports.sGui:getColorCodeHex("sightred")
			else
				col = sightexports.sGui:getColorCodeHex("sightgreen")
			end
			sightexports.sGui:setLabelText(label, col .. "Elérhető: " .. data[i][2] .. sightexports.sGui:getColorCodeHex("sightlightgrey") .. " / Lefoglalva: " .. data[i][6])
		end
		local labels = stockLabels[data[i][1]]
		if labels then
			local col = false
			if data[i][2] <= 0 then
				col = sightexports.sGui:getColorCodeHex("sightred")
			else
				col = sightexports.sGui:getColorCodeHex("sightgreen")
			end
			sightexports.sGui:setLabelText(labels[1], col .. "Elérhető: " .. data[i][2] .. sightexports.sGui:getColorCodeHex("sightlightgrey") .. " / Lefoglalva: " .. data[i][6] .. " / SightNIX: " .. data[i][3])
			if data[i][3] > 0 then
				if data[i][4] >= 6 then
					sightexports.sGui:setLabelText(labels[2], "~ " .. math.ceil(data[i][4] / 6) .. " óra")
				else
					sightexports.sGui:setLabelText(labels[2], "~ " .. data[i][4] * 10 .. " perc")
				end
				sightexports.sGui:setLabelColor(labels[2], "sightgreen")
			else
				if data[i][5] >= 6 then
					sightexports.sGui:setLabelText(labels[2], "~ " .. math.ceil(data[i][5] / 6) .. " óra")
				else
					sightexports.sGui:setLabelText(labels[2], "~ " .. data[i][5] * 10 .. " perc")
				end
				sightexports.sGui:setLabelColor(labels[2], "sightred")
			end
		end
		local label = orderStockLabels[data[i][1]]
		if label then
			if data[i][3] >= orderedParts[data[i][1]] then
				if data[i][4] >= 6 then
					sightexports.sGui:setLabelText(label, data[i][3] .. "db / ~" .. math.ceil(data[i][4] / 6) .. "ó")
				else
					sightexports.sGui:setLabelText(label, data[i][3] .. "db / ~" .. data[i][4] * 10 .. "p")
				end
			elseif data[i][5] >= 6 then
				sightexports.sGui:setLabelText(label, data[i][3] .. "db / ~" .. math.ceil(data[i][5] / 6) .. "ó")
			else
				sightexports.sGui:setLabelText(label, data[i][3] .. "db / ~" .. data[i][5] * 10 .. "p")
			end
			if data[i][3] > orderedParts[data[i][1]] then
				sightexports.sGui:setLabelColor(label, "sightgreen")
			elseif data[i][3] == orderedParts[data[i][1]] then
				sightexports.sGui:setLabelColor(label, "sightorange")
			else
				sightexports.sGui:setLabelColor(label, "sightred")
			end
		end
	end
end)
local orderPage = false
addEvent("toggleMechanicOrderPage", false)
addEventHandler("toggleMechanicOrderPage", getRootElement(), function()
	orderPage = not orderPage
	if orderPage then
		orderScroll = 0
		--triggerLatentServerEvent("requestMechanicStockForOrder", localPlayer, orderedPartsList)
	end
	createMechanicOrderGui()
end)
local finalizingOrder = false
addEvent("deleteOrderedParts", false)
addEventHandler("deleteOrderedParts", getRootElement(), function()
	if not finalizingOrder then
		orderedPartsList = {}
		orderedParts = {}
		orderedPartsCost = 0
		orderPerMake = {}
		orderPerModel = {}
		orderPerCategory = {}
		orderPerPart = {}
		createMechanicOrderGui()
	end
end)
addEvent("finalOrderResponse", true)
addEventHandler("finalOrderResponse", getRootElement(), function(success)
	finalizingOrder = false
	if success then
		orderedPartsList = {}
		orderedParts = {}
		orderedPartsCost = 0
		orderPerMake = {}
		orderPerModel = {}
		orderPerCategory = {}
		orderPerPart = {}
		orderPage = false
		currentMenu = 1
		createMechanicOrderGui()
	end
end)
addEvent("finalOrderParts", false)
addEventHandler("finalOrderParts", getRootElement(), function()
	if not finalizingOrder then
		finalizingOrder = true
		sightexports.sGui:showInfobox("i", "Rendelés leadása folyamatban...")
		triggerLatentServerEvent("finalOrderParts", localPlayer, orderedParts)
	end
end)
addEvent("selectPartForOrder", false)
addEventHandler("selectPartForOrder", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	local part = partCheckboxes[el]
	if part and partBackwards[part] then
		local was = orderedParts[part]
		local new = sightexports.sGui:isCheckboxChecked(el) and 1 or nil
		if was ~= new then
			orderedParts[part] = new
			local dat = partBackwards[part]
			if not orderPerCategory[dat[1]] then
				orderPerCategory[dat[1]] = {}
			end
			if not orderPerPart[dat[1]] then
				orderPerPart[dat[1]] = {}
			end
			if was and not new then
				orderedPartsCost = orderedPartsCost - partPrices[part] * was
				orderPerMake[makeAndModel[dat[1]][1]] = (orderPerMake[makeAndModel[dat[1]][1]] or 0) - 1
				orderPerModel[dat[1]] = (orderPerModel[dat[1]] or 0) - 1
				orderPerCategory[dat[1]][dat[2]] = (orderPerCategory[dat[1]][dat[2]] or 0) - 1
				orderPerPart[dat[1]][dat[3]] = (orderPerPart[dat[1]][dat[3]] or 0) - 1
				for i = #orderedPartsList, 1, -1 do
					if orderedPartsList[i] == part then
						table.remove(orderedPartsList, i)
					end
				end
			elseif not was and new then
				orderedPartsCost = orderedPartsCost + partPrices[part] * new
				orderPerMake[makeAndModel[dat[1]][1]] = (orderPerMake[makeAndModel[dat[1]][1]] or 0) + 1
				orderPerModel[dat[1]] = (orderPerModel[dat[1]] or 0) + 1
				orderPerCategory[dat[1]][dat[2]] = (orderPerCategory[dat[1]][dat[2]] or 0) + 1
				orderPerPart[dat[1]][dat[3]] = (orderPerPart[dat[1]][dat[3]] or 0) + 1
				table.insert(orderedPartsList, part)
			end
			if #orderedPartsList == 0 then
				orderedPartsCost = 0
			end
			for btn, i in pairs(categoryButtons) do
				if categories[i] == dat[2] then
					local num = orderPerCategory[vehicleModels[manufacturerList[selectedManufacturer]][selectedModel][2]] and orderPerCategory[vehicleModels[manufacturerList[selectedManufacturer]][selectedModel][2]][categories[i]]
					if num and 0 < num then
						sightexports.sGui:setButtonText(btn, categories[i] .. " (" .. num .. ")")
					else
						sightexports.sGui:setButtonText(btn, categories[i])
					end
				end
			end
			for btn, i in pairs(partButtons) do
				if partCategories[categories[selectedCategory]][i] == dat[3] then
					local num = orderPerPart[vehicleModels[manufacturerList[selectedManufacturer]][selectedModel][2]] and orderPerPart[vehicleModels[manufacturerList[selectedManufacturer]][selectedModel][2]][partCategories[categories[selectedCategory]][i]]
					if num and 0 < num then
						sightexports.sGui:setButtonText(btn, partTypes[partCategories[categories[selectedCategory]][i]].name .. " (" .. num .. ")")
					else
						sightexports.sGui:setButtonText(btn, partTypes[partCategories[categories[selectedCategory]][i]].name)
					end
				end
			end
			sightexports.sGui:setLabelText(topSelectedLabel, #orderedPartsList .. " kiválasztott alkatrész (" .. sightexports.sGui:thousandsStepper(orderedPartsCost) .. " $)")
		end
	end
end)
local orderPartLabels = {}
local orderPartButtons = {}
addEvent("oderPartInputChanged", false)
addEventHandler("oderPartInputChanged", getRootElement(), function(val, el)
	if orderPartButtons[el] then
		local part = orderedPartsList[orderPartButtons[el] + orderScroll]
		if part and orderedParts[part] then
			local was = orderedParts[part]
			local new = tonumber(val) or 0
			if 0 < new then
				orderedPartsCost = orderedPartsCost + partPrices[part] * (new - was)
				orderedParts[part] = new
			end
			refreshOrderPage()
		end
	end
end)
addEvent("openPartPageFromLabel", false)
addEventHandler("openPartPageFromLabel", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if orderPartLabels[el] then
		local part = orderPartLabels[el]
		if part and partBackwards[part] then
			orderPage = false
			currentMenu = 1
			selectedManufacturer = false
			selectedModel = false
			selectedCategory = false
			selectedPart = false
			for i = 1, #categories do
				for j = 1, #partCategories[categories[i]] do
					if partCategories[categories[i]][j] == partBackwards[part][3] then
						selectedCategory = i
						selectedPart = j
						break
					end
				end
				if selectedPart then
					break
				end
			end
			for i = 1, #manufacturerList do
				for j = 1, #vehicleModels[manufacturerList[i]] do
					if vehicleModels[manufacturerList[i]][j][2] == partBackwards[part][1] then
						selectedManufacturer = i
						selectedModel = j
						break
					end
				end
				if selectedModel then
					break
				end
			end
			createMechanicOrderGui()
		end
	end
end)
addEvent("selectMechanicMenu", false)
addEventHandler("selectMechanicMenu", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if menuButtons[el] then
		currentMenu = menuButtons[el]
		createMechanicOrderGui()
	end
end)
function refreshManufacturers()
	local titleBarHeight = 24
	local y = titleBarHeight + 8 + 24 + 24 + 4
	local sh = (panelHeight - titleBarHeight - 16 - 24 - 24 - 4) / math.max(1, #manufacturerList - 20 + 1)
	for btn, i in pairs(manufacturerButtons) do
		sightexports.sGui:setGuiBackground(btn, "solid", i + manufacturerScroll == selectedManufacturer and "sightgrey1" or "sightgrey3")
		if i + manufacturerScroll == selectedManufacturer then
			sightexports.sGui:setGuiHoverable(btn, false)
		else
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
		end
		local num = orderPerMake[manufacturerList[i + manufacturerScroll]]
		if num and 0 < num then
			sightexports.sGui:setButtonText(btn, manufacturerList[i + manufacturerScroll] .. " (" .. num .. ")")
		else
			sightexports.sGui:setButtonText(btn, manufacturerList[i + manufacturerScroll])
		end
	end
	sightexports.sGui:setGuiPosition(manufacturerBar, false, y + sh * manufacturerScroll)
end
function refreshModels()
	local titleBarHeight = 24
	local y = titleBarHeight + 8 + 24 + 24 + 4
	local sh = (panelHeight - titleBarHeight - 16 - 24 - 24 - 4) / math.max(1, #vehicleModels[manufacturerList[selectedManufacturer]] - 20 + 1)
	for btn, i in pairs(modelButtons) do
		sightexports.sGui:setGuiBackground(btn, "solid", i + modelScroll == selectedModel and "sightgrey1" or "sightgrey3")
		if i + modelScroll == selectedModel then
			sightexports.sGui:setGuiHoverable(btn, false)
		else
			sightexports.sGui:setGuiHoverable(btn, true)
			sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
		end
		local num = orderPerModel[vehicleModels[manufacturerList[selectedManufacturer]][i + modelScroll][2]]
		if num and 0 < num then
			sightexports.sGui:setButtonText(btn, vehicleModels[manufacturerList[selectedManufacturer]][i + modelScroll][1] .. " (" .. num .. ")")
		else
			sightexports.sGui:setButtonText(btn, vehicleModels[manufacturerList[selectedManufacturer]][i + modelScroll][1])
		end
	end
	sightexports.sGui:setGuiPosition(modelBar, false, y + sh * modelScroll)
end
local lastOrderOpened = {}
local lastOrderData = {}
local lastOrderDataEx = {}
local lastOrderElements = {}
local lastOrderBar = false
addEvent("expandLastOrder", false)
addEventHandler("expandLastOrder", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	for i = 1, 16 do
		if el == lastOrderElements[i][1] then
			lastOrderOpened[lastOrderDataEx[i + lastOrderScroll][2] .. lastOrderDataEx[i + lastOrderScroll][3]] = not lastOrderOpened[lastOrderDataEx[i + lastOrderScroll][2] .. lastOrderDataEx[i + lastOrderScroll][3]]
			refreshOrderedOpen()
			refreshOrderedPage()
			return
		end
	end
end)
function refreshOrderedOpen()
	lastOrderDataEx = {}
	local lastDate = 0
	local lastOrderBy = ""
	local count = 0
	local sum = 0
	local delivered = 0
	local tmp = {}
	for i = 1, #lastOrderData do
		if lastOrderData[i][2] ~= lastOrderBy or lastOrderData[i][3] ~= lastDate then
			if 0 < count then
				table.insert(lastOrderDataEx, {
					count,
					lastOrderBy,
					lastDate,
					sum,
					(delivered == count and sightexports.sGui:getColorCodeHex("sightgreen") or sightexports.sGui:getColorCodeHex("sightblue")) .. delivered .. "/" .. count
				})
			end
			lastOrderBy = lastOrderData[i][2]
			lastDate = lastOrderData[i][3]
			count = 0
			sum = 0
			delivered = 0
			for j = 1, #tmp do
				table.insert(lastOrderDataEx, tmp[j])
			end
			tmp = {}
		end
		count = count + 1
		sum = sum + lastOrderData[i][4]
		if not lastOrderData[i][5] then
			delivered = delivered + 1
		end
		if lastOrderOpened[lastOrderData[i][2] .. lastOrderData[i][3]] then
			table.insert(tmp, lastOrderData[i])
		end
	end
	if 0 < count then
		table.insert(lastOrderDataEx, {
			count,
			lastOrderBy,
			lastDate,
			sum,
			(delivered == count and sightexports.sGui:getColorCodeHex("sightgreen") or sightexports.sGui:getColorCodeHex("sightblue")) .. delivered .. "/" .. count
		})
	end
	for j = 1, #tmp do
		table.insert(lastOrderDataEx, tmp[j])
	end
	tmp = {}
end
function refreshOrderedPage()
	if lastOrderScroll > #lastOrderDataEx - 16 then
		lastOrderScroll = math.max(0, #lastOrderDataEx - 16)
	end
	local titleBarHeight = 24
	local y = titleBarHeight + 8 + 24 + 4
	local h = (panelHeight - titleBarHeight - 16 - 24 - 4) / 17
	local sh = h * 16 / math.max(1, #lastOrderDataEx - 16 + 1)
	sightexports.sGui:setGuiPosition(lastOrderBar, false, y + h + sh * lastOrderScroll)
	sightexports.sGui:setGuiSize(lastOrderBar, false, sh)
	local data = lastOrderDataEx
	for i = 1, 16 do
		local label = false
		if data[i + lastOrderScroll] then
			local part = data[i + lastOrderScroll][1]
			if tonumber(part) then
				label = lastOrderElements[i][1]
				sightexports.sGui:setClickEvent(label, "expandLastOrder")
				if lastOrderOpened[data[i + lastOrderScroll][2] .. data[i + lastOrderScroll][3]] then
					sightexports.sGui:setLabelText(label, part .. " db \226\150\188")
				else
					sightexports.sGui:setLabelText(label, part .. " db \226\150\182")
				end
				sightexports.sGui:guiSetTooltip(label, false)
				label = lastOrderElements[i][2]
				sightexports.sGui:setLabelText(label, data[i + lastOrderScroll][2]:gsub("_", " "))
				local time = getRealTime(data[i + lastOrderScroll][3])
				local date = string.format("%04d. %02d. %02d. %02d:%02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute, time.second)
				label = lastOrderElements[i][3]
				sightexports.sGui:setLabelText(label, date)
			else
				label = lastOrderElements[i][1]
				sightexports.sGui:setClickEvent(label, "openPartPageFromLabel")
				sightexports.sGui:setLabelText(label, part)
				orderPartLabels[label] = part
				local model = partBackwards[part][1]
				sightexports.sGui:guiSetTooltip(label, partTypes[partBackwards[part][3]].name .. " - " .. sightexports.sGui:getColorCodeHex("sightblue") .. partBackwards[part][4] .. "#ffffff - " .. sightexports.sGui:getColorCodeHex("sightgreen") .. makeAndModel[model][1] .. "/" .. makeAndModel[model][2])
				label = lastOrderElements[i][2]
				sightexports.sGui:setLabelText(label, "")
				label = lastOrderElements[i][3]
				sightexports.sGui:setLabelText(label, "")
			end
			label = lastOrderElements[i][4]
			sightexports.sGui:setLabelText(label, data[i + lastOrderScroll][4] .. " db")
			label = lastOrderElements[i][5]
			if tonumber(data[i + lastOrderScroll][5]) then
				if data[i + lastOrderScroll][5] >= 6 then
					sightexports.sGui:setLabelText(label, "~ " .. math.ceil(data[i + lastOrderScroll][5] / 6) .. " óra")
				else
					sightexports.sGui:setLabelText(label, "~ " .. data[i + lastOrderScroll][5] * 10 .. " perc")
				end
				sightexports.sGui:setLabelColor(label, data[i + lastOrderScroll][5] >= 12 and "sightorange" or "sightblue")
			elseif data[i + lastOrderScroll][5] then
				sightexports.sGui:setLabelText(label, data[i + lastOrderScroll][5])
				sightexports.sGui:setLabelColor(label, "#ffffff")
			else
				sightexports.sGui:setLabelText(label, "Kiszállítva")
				sightexports.sGui:setLabelColor(label, "sightgreen")
			end
		else
			label = lastOrderElements[i][1]
			sightexports.sGui:setLabelText(label, "")
			label = lastOrderElements[i][2]
			sightexports.sGui:setLabelText(label, "")
			label = lastOrderElements[i][3]
			sightexports.sGui:setLabelText(label, "")
			label = lastOrderElements[i][4]
			sightexports.sGui:setLabelText(label, "")
			label = lastOrderElements[i][5]
			sightexports.sGui:setLabelText(label, "")
		end
	end
end
function sortOrdersEx(a, b)
	return a[5] < b[5]
end
function sortOrders(a, b)
	if a[5] and b[5] and a[3] == b[3] then
		return a[5] < b[5]
	else
		return a[3] > b[3]
	end
end
addEvent("gotMechanicLastOrders", true)
addEventHandler("gotMechanicLastOrders", getRootElement(), function(data)
	if currentMenu == 2 then
		table.sort(data, sortOrders)
		lastOrderData = data
		refreshOrderedOpen()
		refreshOrderedPage()
		if loadingRect then
			sightexports.sGui:deleteGuiElement(loadingRect)
		end
		loadingRect = false
		if loadingIcon then
			sightexports.sGui:deleteGuiElement(loadingIcon)
		end
		loadingIcon = false
	end
end)
local orderCostLabel = false
local orderElements = {}
function refreshOrderPage()
	local titleBarHeight = 24
	sightexports.sGui:setLabelText(orderCostLabel, sightexports.sGui:thousandsStepper(orderedPartsCost) .. " $")
	orderStockLabels = {}
	for i = 1, 15 do
		local label = false
		if orderElements[i] and orderedPartsList[i + orderScroll] then
			local part = orderedPartsList[i + orderScroll]
			local model = partBackwards[part][1]
			label = orderElements[i][1]
			sightexports.sGui:setLabelText(label, part)
			sightexports.sGui:guiSetTooltip(label, partTypes[partBackwards[part][3]].name .. " - " .. sightexports.sGui:getColorCodeHex("sightblue") .. partBackwards[part][4] .. "#ffffff - " .. sightexports.sGui:getColorCodeHex("sightgreen") .. makeAndModel[model][1] .. "/" .. makeAndModel[model][2])
			label = orderElements[i][2]
			sightexports.sGui:setLabelText(label, makeAndModel[model][1] .. "/" .. makeAndModel[model][2])
			label = orderElements[i][3]
			sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(partPrices[part]) .. " $")
			local input = orderElements[i][4]
			sightexports.sGui:setInputValue(input, tostring(orderedParts[part]))
			label = orderElements[i][5]
			if stockInformation[part][2] >= orderedParts[part] then
				if stockInformation[part][3] >= 6 then
					sightexports.sGui:setLabelText(label, stockInformation[part][2] .. "db / ~" .. math.ceil(stockInformation[part][3] / 6) .. "ó")
				else
					sightexports.sGui:setLabelText(label, stockInformation[part][2] .. "db / ~" .. stockInformation[part][3] * 10 .. "p")
				end
			elseif stockInformation[part][4] >= 6 then
				sightexports.sGui:setLabelText(label, stockInformation[part][2] .. "db / ~" .. math.ceil(stockInformation[part][4] / 6) .. "ó")
			else
				sightexports.sGui:setLabelText(label, stockInformation[part][2] .. "db / ~" .. stockInformation[part][4] * 10 .. "p")
			end
			if stockInformation[part][2] > orderedParts[part] then
				sightexports.sGui:setLabelColor(label, "sightgreen")
			elseif stockInformation[part][2] == orderedParts[part] then
				sightexports.sGui:setLabelColor(label, "sightorange")
			else
				sightexports.sGui:setLabelColor(label, "sightred")
			end
			orderStockLabels[part] = label
			label = orderElements[i][6]
			sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(partPrices[part] * orderedParts[part]) .. " $")
		end
	end
	local h = (panelHeight - titleBarHeight - 16 - 24 - 24 - 4) / 17
	local sh = h * 15 / math.max(1, #orderedPartsList - 15 + 1)
	local y = titleBarHeight + 8 + 24 + 24 + 4
	sightexports.sGui:setGuiPosition(orderBar, false, y + h + sh * orderScroll)
end
function scrollKey(key, press)
	if key == "mouse_wheel_down" or key == "mouse_wheel_up" then
		if offerWindow then
			if key == "mouse_wheel_down" then
				if offerScroll < #offerList - 16 then
					offerScroll = offerScroll + 1
					refreshOfferList()
				end
			elseif key == "mouse_wheel_up" and 0 < offerScroll then
				offerScroll = offerScroll - 1
				refreshOfferList()
			end
		elseif orderWindow then
			local titleBarHeight = 24
			if currentMenu == 2 then
				if key == "mouse_wheel_down" then
					if lastOrderScroll < #lastOrderDataEx - 16 then
						lastOrderScroll = lastOrderScroll + 1
						refreshOrderedPage()
					end
				elseif key == "mouse_wheel_up" and 0 < lastOrderScroll then
					lastOrderScroll = lastOrderScroll - 1
					refreshOrderedPage()
				end
			elseif currentMenu == 1 then
				if orderPage then
					if key == "mouse_wheel_down" then
						if orderScroll < #orderedPartsList - 15 then
							orderScroll = orderScroll + 1
							refreshOrderPage()
						end
					elseif key == "mouse_wheel_up" and 0 < orderScroll then
						orderScroll = orderScroll - 1
						refreshOrderPage()
					end
				elseif not selectedPart then
					local x, y = sightexports.sGui:getGuiRealPosition(orderWindow)
					local cx, cy = getCursorPosition()
					if cx and cy then
						cx = cx * screenX - x
						cy = cy * screenY - y
						local w = (panelWidth - 38) / 4.75
						local h = (panelHeight - titleBarHeight - 16 - 24 - 24 - 4) / 20
						if cy >= titleBarHeight + 8 + 24 + 24 + 4 and cy <= titleBarHeight + 8 + panelHeight - titleBarHeight - 16 then
							if 8 <= cx and cx <= 8 + w then
								if key == "mouse_wheel_down" then
									if manufacturerScroll < #manufacturerList - 20 then
										manufacturerScroll = manufacturerScroll + 1
										refreshManufacturers()
									end
								elseif key == "mouse_wheel_up" and 0 < manufacturerScroll then
									manufacturerScroll = manufacturerScroll - 1
									refreshManufacturers()
								end
							elseif cx >= 8 + w + 8 and cx <= 8 + w + 8 + w and selectedManufacturer then
								if key == "mouse_wheel_down" then
									if modelScroll < #vehicleModels[manufacturerList[selectedManufacturer]] - 20 then
										modelScroll = modelScroll + 1
										refreshModels()
									end
								elseif key == "mouse_wheel_up" and 0 < modelScroll then
									modelScroll = modelScroll - 1
									refreshModels()
								end
							end
						end
					end
				end
			end
		elseif carWindow and not sendingOffer then
			if key == "mouse_wheel_down" then
				if carPartsScroll < carScrollNum then
					carPartsScroll = carPartsScroll + 1
					refreshCarPartsList()
				end
			elseif key == "mouse_wheel_up" and 0 < carPartsScroll then
				carPartsScroll = carPartsScroll - 1
				refreshCarPartsList()
			end
		end
	elseif (key == "q" or key == "e") and press and not sightexports.sGui:getActiveInput() and not isChatBoxInputActive() and not isConsoleActive() and currentHexSize then
		local tmp = currentHexSize
		if key == "q" then
			for i = 1, #hexSizes do
				if tmp <= hexSizes[i] then
					break
				else
					currentHexSize = hexSizes[i]
				end
			end
			if currentHexSize ~= tmp then
				sightexports.sWeapons:setWrenchState(currentHexSize)
				playSound("files/change" .. math.random(1, 3) .. ".mp3")
			end
		elseif key == "e" then
			for i = 1, #hexSizes do
				if tmp < hexSizes[i] then
					currentHexSize = hexSizes[i]
					break
				end
			end
			if currentHexSize ~= tmp then
				sightexports.sWeapons:setWrenchState(currentHexSize)
				playSound("files/change" .. math.random(1, 3) .. ".mp3")
			end
		end
	end
end
addEvent("closeMechanicNixPanel", false)
addEventHandler("closeMechanicNixPanel", getRootElement(), function()
	currentMenu = false
	manufacturerButtons = {}
	modelButtons = {}
	categoryButtons = {}
	partButtons = {}
	partCheckboxes = {}
	stockLabels = {}
	orderStockLabels = {}
	orderPartLabels = {}
	orderPartButtons = {}
	orderElements = {}
	lastOrderElements = {}
	orderCostLabel = false
	manufacturerBar = false
	modelBar = false
	orderBar = false
	lastOrderBar = false
	deleteMechanicOrderGui()
	createKrutonScreen()
end)
function deleteMechanicOrderGui()
	local x, y = false, false
	if orderWindow then
		x, y = sightexports.sGui:getGuiPosition(orderWindow)
		sightexports.sGui:deleteGuiElement(orderWindow)
	end
	orderWindow = false
	loadingRect = false
	loadingIcon = false
	manufacturerButtons = {}
	modelButtons = {}
	categoryButtons = {}
	partButtons = {}
	partCheckboxes = {}
	stockLabels = {}
	orderStockLabels = {}
	orderPartLabels = {}
	orderPartButtons = {}
	orderElements = {}
	lastOrderElements = {}
	orderCostLabel = false
	manufacturerBar = false
	modelBar = false
	orderBar = false
	lastOrderBar = false
	return x, y
end
function createMechanicOrderGui()
	deleteMechanicOrderGui()
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local padding = 4
	panelWidth = 1000
	panelHeight = 638
	orderWindow = sightexports.sGui:createGuiElement("rectangle", padding, titleBarHeight + padding, panelWidth, panelHeight, krutonWindow)
	sightexports.sGui:setGuiBackground(orderWindow, "solid", {
		40,
		120,
		170
	})
	local rect = sightexports.sGui:createGuiElement("rectangle", 38, panelHeight, 36, 32, orderWindow)
	sightexports.sGui:setGuiBackground(rect, "solid", {
		40,
		120,
		170
	})
	local logo = sightexports.sGui:createGuiElement("image", 2, 0, 32, 32, rect)
	sightexports.sGui:setImageDDS(logo, ":sMechanic/files/nix.dds")
	if krutonInside then
		sightexports.sGui:deleteGuiElement(krutonInside)
	end
	krutonInside = false
	local titleBarHeight = 24
	local rect = sightexports.sGui:createGuiElement("rectangle", 1, titleBarHeight, panelWidth - 2, panelHeight - 1 - titleBarHeight, orderWindow)
	sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey2")
	local label = sightexports.sGui:createGuiElement("label", 6, -titleBarHeight, 0, titleBarHeight, rect)
	sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelText(label, "SightNIX Alkatrészek - Telephely: " .. workshops[currentWorkshop][1])
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	local icon = sightexports.sGui:createGuiElement("image", panelWidth - titleBarHeight, -titleBarHeight, titleBarHeight, titleBarHeight, rect)
	sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("times", titleBarHeight, "solid"))
	sightexports.sGui:setImageColor(icon, "#ffffff")
	sightexports.sGui:setGuiHoverable(icon, true)
	sightexports.sGui:setGuiHover(icon, "solid", "sightred")
	sightexports.sGui:setClickEvent(icon, "closeMechanicNixPanel")
	local rect = sightexports.sGui:createGuiElement("rectangle", 1, titleBarHeight - 2, panelWidth - 2, 30, orderWindow)
	sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
	local x = 8
	local y = titleBarHeight + 8 + 24 + 24 + 4
	menuButtons = {}
	for i = 1, #mechanicMenus do
		local btnW = math.ceil(sightexports.sGui:getTextWidthFont(mechanicMenus[i], "13/BebasNeueRegular.otf", 1, true) + 20 + 12)
		local btn = sightexports.sGui:createGuiElement("button", x, titleBarHeight + 4, btnW, 24, orderWindow)
		local isCurrent = i == currentMenu
		if isCurrent then
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
			sightexports.sGui:setGuiHoverable(btn, false)
		else
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
			sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, true)
		end
		sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
		sightexports.sGui:setButtonTextColor(btn, isCurrent and "#ffffff" or "#a0a0a0")
		sightexports.sGui:setButtonText(btn, mechanicMenus[i])
		sightexports.sGui:setClickEvent(btn, "selectMechanicMenu")
		menuButtons[btn] = i
		x = x + btnW
	end
	x = 8
	local w = (panelWidth - 38) / 4.75
	local h = (panelHeight - titleBarHeight - 16 - 24 - 24 - 4) / 20
	local fh = math.ceil(sightexports.sGui:getFontHeight("10/Ubuntu-R.ttf") / 2) * 2
	manufacturerButtons = {}
	modelButtons = {}
	categoryButtons = {}
	partButtons = {}
	partCheckboxes = {}
	stockLabels = {}
	orderStockLabels = {}
	orderPartLabels = {}
	orderPartButtons = {}
	orderElements = {}
	lastOrderElements = {}
	orderCostLabel = false
	manufacturerBar = false
	modelBar = false
	orderBar = false
	lastOrderBar = false
	if currentMenu == 2 then
		local w = (panelWidth - 16 - 8) / 5
		local y = titleBarHeight + 8 + 24 + 4
		local h = (panelHeight - titleBarHeight - 16 - 24 - 4) / 17
		local rect = sightexports.sGui:createGuiElement("rectangle", panelWidth - 8 - 2, y + h, 2, h * 16, orderWindow)
		sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
		lastOrderBar = sightexports.sGui:createGuiElement("rectangle", panelWidth - 8 - 2, y + h, 2, h * 16, orderWindow)
		sightexports.sGui:setGuiBackground(lastOrderBar, "solid", "sightmidgrey")
		local rect = sightexports.sGui:createGuiElement("rectangle", 8, y + 1, w * 5, h - 2, orderWindow)
		sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
		local border = sightexports.sGui:createGuiElement("hr", 8, y, 2, h * 17, orderWindow)
		local label = sightexports.sGui:createGuiElement("label", 8, y, w * 1.25, h, orderWindow)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Cikkszám")
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		local border = sightexports.sGui:createGuiElement("hr", 8 + w * 1.25, y, 2, h * 17, orderWindow)
		local label = sightexports.sGui:createGuiElement("label", 8 + w * 1.25, y, w * 1.25, h, orderWindow)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Megrendelő")
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		local border = sightexports.sGui:createGuiElement("hr", 8 + w * 2.5, y, 2, h * 17, orderWindow)
		local label = sightexports.sGui:createGuiElement("label", 8 + w * 2.5, y, w * 1, h, orderWindow)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Leadva")
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		local border = sightexports.sGui:createGuiElement("hr", 8 + w * 3.5, y, 2, h * 17, orderWindow)
		local label = sightexports.sGui:createGuiElement("label", 8 + w * 3.5, y, w * 0.75, h, orderWindow)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Mennyiség")
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		local border = sightexports.sGui:createGuiElement("hr", 8 + w * 4.25, y, 2, h * 17, orderWindow)
		local label = sightexports.sGui:createGuiElement("label", 8 + w * 4.25, y, w * 0.75, h, orderWindow)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Szállítás")
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		local border = sightexports.sGui:createGuiElement("hr", 8 + w * 5, y, 2, h * 17, orderWindow)
		local border = sightexports.sGui:createGuiElement("hr", 8, y - 1, w * 5, 2, orderWindow)
		local border = sightexports.sGui:createGuiElement("hr", 8, y + h - 1, w * 5, 2, orderWindow)
		for i = 1, 16 do
			y = y + h
			lastOrderElements[i] = {}
			local label = sightexports.sGui:createGuiElement("label", 8, y, w * 1.25, h, orderWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
			sightexports.sGui:setLabelText(label, "")
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			sightexports.sGui:setGuiHoverable(label, true)
			sightexports.sGui:setClickEvent(label, "openPartPageFromLabel")
			table.insert(lastOrderElements[i], label)
			local label = sightexports.sGui:createGuiElement("label", 8 + w * 1.25, y, w * 1.25, h, orderWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
			sightexports.sGui:setLabelText(label, "")
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			table.insert(lastOrderElements[i], label)
			local label = sightexports.sGui:createGuiElement("label", 8 + w * 2.5, y, w * 1, h, orderWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
			sightexports.sGui:setLabelText(label, "")
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			table.insert(lastOrderElements[i], label)
			local label = sightexports.sGui:createGuiElement("label", 8 + w * 3.5, y, w * 0.75, h, orderWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
			sightexports.sGui:setLabelText(label, "")
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			table.insert(lastOrderElements[i], label)
			local label = sightexports.sGui:createGuiElement("label", 8 + w * 4.25, y, w * 0.75, h, orderWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
			sightexports.sGui:setLabelText(label, "")
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			table.insert(lastOrderElements[i], label)
			local border = sightexports.sGui:createGuiElement("hr", 8, y + h - 1, w * 5, 2, orderWindow)
		end
		loadingRect = sightexports.sGui:createGuiElement("rectangle", 8, titleBarHeight + 8 + 24 + 4, panelWidth - 16, h * 17, orderWindow)
		sightexports.sGui:setGuiBackground(loadingRect, "solid", {
			0,
			0,
			0,
			150
		})
		loadingIcon = sightexports.sGui:createGuiElement("image", panelWidth / 2 - 32, titleBarHeight + 8 + 24 + 4 + h * 17 / 2 - 32, 64, 64, orderWindow)
		sightexports.sGui:setImageFile(loadingIcon, sightexports.sGui:getFaIconFilename("circle-notch", 64))
		sightexports.sGui:setImageSpinner(loadingIcon, true)
		triggerLatentServerEvent("requestMechanicLastOrders", localPlayer)
	elseif currentMenu == 1 then
		if orderPage then
			local icon = sightexports.sGui:createGuiElement("image", 8, titleBarHeight + 24 + 4 + 16 - 8, 16, 16, orderWindow)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("backspace", 16))
			sightexports.sGui:setImageColor(icon, "#ffffff")
			sightexports.sGui:setGuiHoverable(icon, true)
			sightexports.sGui:setGuiHover(icon, "solid", "#ffffff")
			sightexports.sGui:setClickEvent(icon, "backToModel")
			local label = sightexports.sGui:createGuiElement("label", 28, titleBarHeight + 24 + 4 + 16 - fh / 2, panelWidth / 2 - 8, fh, orderWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(label, "Vissza a katalógushoz")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			sightexports.sGui:setGuiHoverable(label, true)
			sightexports.sGui:setClickEvent(label, "toggleMechanicOrderPage")
			local w = (panelWidth - 16 - 8) / 6
			local h = (panelHeight - titleBarHeight - 16 - 24 - 24 - 4) / 17
			local rect = sightexports.sGui:createGuiElement("rectangle", panelWidth - 8 - 2, y + h, 2, h * 15, orderWindow)
			sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
			local sh = h * 15 / math.max(1, #orderedPartsList - 15 + 1)
			orderBar = sightexports.sGui:createGuiElement("rectangle", panelWidth - 8 - 2, y + h + sh * orderScroll, 2, sh, orderWindow)
			sightexports.sGui:setGuiBackground(orderBar, "solid", "sightmidgrey")
			local rect = sightexports.sGui:createGuiElement("rectangle", 8, y + 1, w * 6, h - 2, orderWindow)
			sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
			local border = sightexports.sGui:createGuiElement("hr", 8, y, 2, h * 16, orderWindow)
			local label = sightexports.sGui:createGuiElement("label", 8, y, w * 1.5, h, orderWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(label, "Cikkszám")
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			local border = sightexports.sGui:createGuiElement("hr", 8 + w * 1.5, y, 2, h * 16, orderWindow)
			local label = sightexports.sGui:createGuiElement("label", 8 + w * 1.5, y, w * 1.5, h, orderWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(label, "Jármű")
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			local border = sightexports.sGui:createGuiElement("hr", 8 + w * 3, y, 2, h * 16, orderWindow)
			local label = sightexports.sGui:createGuiElement("label", 8 + w * 3, y, w * 0.75, h, orderWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(label, "Egységár")
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			local border = sightexports.sGui:createGuiElement("hr", 8 + w * 3.75, y, 2, h * 16, orderWindow)
			local label = sightexports.sGui:createGuiElement("label", 8 + w * 3.75, y, w * 0.75, h, orderWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(label, "Mennyiség")
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			local border = sightexports.sGui:createGuiElement("hr", 8 + w * 4.5, y, 2, h * 16, orderWindow)
			local label = sightexports.sGui:createGuiElement("label", 8 + w * 4.5, y, w * 0.75, h, orderWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(label, "SightNIX")
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			local border = sightexports.sGui:createGuiElement("hr", 8 + w * 5.25, y, 2, h * 16, orderWindow)
			local label = sightexports.sGui:createGuiElement("label", 8 + w * 5.25, y, w * 0.75, h, orderWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(label, "Ár")
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			local border = sightexports.sGui:createGuiElement("hr", 8 + w * 6, y, 2, h * 16, orderWindow)
			local border = sightexports.sGui:createGuiElement("hr", 8, y - 1, w * 6, 2, orderWindow)
			local border = sightexports.sGui:createGuiElement("hr", 8, y + h - 1, w * 6, 2, orderWindow)
			y = y + h
			for i = 1, 15 do
				if orderedPartsList[i + orderScroll] then
					orderElements[i] = {}
					local part = orderedPartsList[i + orderScroll]
					local model = partBackwards[part][1]
					local label = sightexports.sGui:createGuiElement("label", 8, y, w * 1.5, h, orderWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
					sightexports.sGui:setLabelText(label, part)
					sightexports.sGui:setLabelAlignment(label, "center", "center")
					sightexports.sGui:setGuiHoverable(label, true)
					sightexports.sGui:guiSetTooltip(label, partTypes[partBackwards[part][3]].name .. " - " .. sightexports.sGui:getColorCodeHex("sightblue") .. partBackwards[part][4] .. "#ffffff - " .. sightexports.sGui:getColorCodeHex("sightgreen") .. makeAndModel[model][1] .. "/" .. makeAndModel[model][2])
					sightexports.sGui:setClickEvent(label, "openPartPageFromLabel")
					orderPartLabels[label] = part
					table.insert(orderElements[i], label)
					local label = sightexports.sGui:createGuiElement("label", 8 + w * 1.5, y, w * 1.5, h, orderWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
					sightexports.sGui:setLabelText(label, makeAndModel[model][1] .. "/" .. makeAndModel[model][2])
					sightexports.sGui:setLabelAlignment(label, "center", "center")
					sightexports.sGui:setLabelColor(label, "sightlightgrey")
					table.insert(orderElements[i], label)
					local label = sightexports.sGui:createGuiElement("label", 8 + w * 3, y, w * 0.75, h, orderWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
					sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(partPrices[part]) .. " $")
					sightexports.sGui:setLabelAlignment(label, "center", "center")
					sightexports.sGui:setLabelColor(label, "sightgreen")
					table.insert(orderElements[i], label)
					local input = sightexports.sGui:createGuiElement("input", 8 + w * 3.75 + 2, y + 2, w * 0.75 - 4, h - 4, orderWindow)
					sightexports.sGui:setInputPlaceholder(input, "SSC összeg")
					sightexports.sGui:setInputValue(input, tostring(orderedParts[part]))
					sightexports.sGui:setInputFont(input, "10/Ubuntu-R.ttf")
					sightexports.sGui:setInputMaxLength(input, 6)
					sightexports.sGui:setInputNumberOnly(input, true)
					sightexports.sGui:setInputChangeEvent(input, "oderPartInputChanged")
					table.insert(orderElements[i], input)
					orderPartButtons[input] = i
					local label = sightexports.sGui:createGuiElement("label", 8 + w * 4.5, y, w * 0.75, h, orderWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
					sightexports.sGui:setLabelAlignment(label, "center", "center")
					if stockInformation[part][2] >= orderedParts[part] then
						if 6 <= stockInformation[part][3] then
							sightexports.sGui:setLabelText(label, stockInformation[part][2] .. "db / ~" .. math.ceil(stockInformation[part][3] / 6) .. "ó")
						else
							sightexports.sGui:setLabelText(label, stockInformation[part][2] .. "db / ~" .. stockInformation[part][3] * 10 .. "p")
						end
					elseif stockInformation[part][4] >= 6 then
						sightexports.sGui:setLabelText(label, stockInformation[part][2] .. "db / ~" .. math.ceil(stockInformation[part][4] / 6) .. "ó")
					else
						sightexports.sGui:setLabelText(label, stockInformation[part][2] .. "db / ~" .. stockInformation[part][4] * 10 .. "p")
					end
					if stockInformation[part][2] > orderedParts[part] then
						sightexports.sGui:setLabelColor(label, "sightgreen")
					elseif stockInformation[part][2] == orderedParts[part] then
						sightexports.sGui:setLabelColor(label, "sightorange")
					else
						sightexports.sGui:setLabelColor(label, "sightred")
					end
					orderStockLabels[part] = label
					table.insert(orderElements[i], label)
					local label = sightexports.sGui:createGuiElement("label", 8 + w * 5.25, y, w * 0.75 - 8, h, orderWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
					sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(partPrices[part] * orderedParts[part]) .. " $")
					sightexports.sGui:setLabelAlignment(label, "right", "center")
					sightexports.sGui:setLabelColor(label, "sightgreen")
					table.insert(orderElements[i], label)
				end
				local border = sightexports.sGui:createGuiElement("hr", 8, y + h - 1, w * 6, 2, orderWindow)
				y = y + h
			end
			if 0 < #orderedPartsList then
				local btn = sightexports.sGui:createGuiElement("button", 8, y + 8, 150, panelHeight - y - 16, orderWindow)
				sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
				sightexports.sGui:setGuiHover(btn, "gradient", {
					"sightgreen",
					"sightgreen-second"
				})
				sightexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
				sightexports.sGui:setButtonTextColor(btn, "#ffffff")
				sightexports.sGui:setButtonText(btn, "Rendelés leadása")
				sightexports.sGui:setClickEvent(btn, "finalOrderParts")
				local btn = sightexports.sGui:createGuiElement("button", 166, y + 8, 150, panelHeight - y - 16, orderWindow)
				sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
				sightexports.sGui:setGuiHover(btn, "gradient", {
					"sightred",
					"sightred-second"
				})
				sightexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
				sightexports.sGui:setButtonTextColor(btn, "#ffffff")
				sightexports.sGui:setButtonText(btn, "Rendelés törlése")
				sightexports.sGui:setClickEvent(btn, "deleteOrderedParts")
			end
			orderCostLabel = sightexports.sGui:createGuiElement("label", 8 + w * 5.25, y, w * 0.75 - 8, h, orderWindow)
			sightexports.sGui:setLabelFont(orderCostLabel, "10/Ubuntu-L.ttf")
			sightexports.sGui:setLabelText(orderCostLabel, sightexports.sGui:thousandsStepper(orderedPartsCost) .. " $")
			sightexports.sGui:setLabelAlignment(orderCostLabel, "right", "center")
			sightexports.sGui:setLabelColor(orderCostLabel, "sightgreen")
		else
			if selectedPart then
				local icon = sightexports.sGui:createGuiElement("image", 8, titleBarHeight + 24 + 4 + 16 - 8, 16, 16, orderWindow)
				sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("backspace", 16))
				sightexports.sGui:setImageColor(icon, "#ffffff")
				sightexports.sGui:setGuiHoverable(icon, true)
				sightexports.sGui:setGuiHover(icon, "solid", "#ffffff")
				sightexports.sGui:setClickEvent(icon, "backToModel")
				local label = sightexports.sGui:createGuiElement("label", 28, titleBarHeight + 24 + 4, panelWidth / 2 - 8 - 16 - 4, 32, orderWindow)
				sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
				sightexports.sGui:setLabelText(label, manufacturerList[selectedManufacturer] .. "/" .. vehicleModels[manufacturerList[selectedManufacturer]][selectedModel][1])
				sightexports.sGui:setLabelAlignment(label, "left", "center")
				sightexports.sGui:setGuiHoverable(label, true)
				sightexports.sGui:setClickEvent(label, "backToModel")
			else
				local label = sightexports.sGui:createGuiElement("label", 8, titleBarHeight + 24 + 4, panelWidth, 32, orderWindow)
				sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
				sightexports.sGui:setLabelText(label, "Válassz járművet!")
				sightexports.sGui:setLabelAlignment(label, "left", "center")
			end
			topSelectedLabel = sightexports.sGui:createGuiElement("label", panelWidth / 2, titleBarHeight + 24 + 4 + 16 - fh / 2, panelWidth / 2 - 8 - 16 - 4, fh, orderWindow)
			sightexports.sGui:setLabelFont(topSelectedLabel, "10/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(topSelectedLabel, #orderedPartsList .. " kiválasztott alkatrész (" .. sightexports.sGui:thousandsStepper(orderedPartsCost) .. " $)")
			sightexports.sGui:setLabelAlignment(topSelectedLabel, "right", "center")
			sightexports.sGui:setGuiHoverable(topSelectedLabel, true)
			sightexports.sGui:setClickEvent(topSelectedLabel, "toggleMechanicOrderPage")
			local icon = sightexports.sGui:createGuiElement("image", panelWidth - 8 - 16, titleBarHeight + 24 + 4 + 16 - 8, 16, 16, orderWindow)
			sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("shopping-cart", 16, "regular"))
			sightexports.sGui:setImageColor(icon, "#ffffff")
			sightexports.sGui:setGuiHoverable(icon, true)
			sightexports.sGui:setGuiHover(icon, "solid", "#ffffff")
			sightexports.sGui:setClickEvent(icon, "toggleMechanicOrderPage")
			local rect = sightexports.sGui:createGuiElement("rectangle", x, y, w, h * 20, orderWindow)
			sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
			x = x + 8 + w
			if selectedManufacturer then
				if not selectedPart then
					local rect = sightexports.sGui:createGuiElement("rectangle", x, y, w, h * 20, orderWindow)
					sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
					x = x + 8 + w
				end
				if selectedModel then
					if not selectedPart then
						local rect = sightexports.sGui:createGuiElement("rectangle", x, y, w, h * 20, orderWindow)
						sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
						x = x + 8 + w
					end
					if selectedCategory then
						local rect = sightexports.sGui:createGuiElement("rectangle", x, y, w * 1.75, h * 20, orderWindow)
						sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey3")
						x = x + 8 + w * 1.75
					end
				end
			end
			if selectedPart and 0 < selectedPart then
				local part = partCategories[categories[selectedCategory]][selectedPart]
				local model = vehicleModels[manufacturerList[selectedManufacturer]][selectedModel][2]
				local manufacturers = partTypes[part].manufacturers
				triggerServerEvent("requestMechanicPartStock", localPlayer, model, part)
				local h = 72
				for j = 1, #manufacturers do
					local y = y + (j - 1) * h
					local part = perVehicleParts[model][part][manufacturers[j][1]]
					local bbox = sightexports.sGui:createGuiElement("rectangle", x, y, w * 2, h, orderWindow)
					sightexports.sGui:setGuiBackground(bbox, "solid", {
						0,
						0,
						0,
						0
					})
					sightexports.sGui:setGuiHover(bbox, "none", {
						0,
						0,
						0,
						0
					})
					sightexports.sGui:setGuiHoverable(bbox, true)
					local label = sightexports.sGui:createGuiElement("label", x + h / 3 + 8, y, w * 2, h / 3, orderWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightexports.sGui:setLabelText(label, manufacturers[j][1])
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					local quality = "Felújított"
					local color = "sightred"
					if manufacturers[j][2] > 100 then
						quality = "Professzionális"
						color = "sightblue-second"
					elseif manufacturers[j][2] == 100 then
						quality = "Gyári"
						color = "sightgreen"
					elseif manufacturers[j][2] >= 85 then
						quality = "Utángyártott"
						color = "sightorange-second"
					end
					local label = sightexports.sGui:createGuiElement("label", x, y, w * 2, h / 3, orderWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightexports.sGui:setLabelText(label, quality)
					sightexports.sGui:setLabelColor(label, color)
					sightexports.sGui:setLabelAlignment(label, "right", "center")
					stockLabels[part] = {}
					local label = sightexports.sGui:createGuiElement("label", x + h / 3 + 8, y + h / 3, w * 2, h / 3, orderWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
					if stockInformation[part] then
						local col = false
						if 0 >= stockInformation[part][1] then
							col = sightexports.sGui:getColorCodeHex("sightred")
						else
							col = sightexports.sGui:getColorCodeHex("sightgreen")
						end
						sightexports.sGui:setLabelText(label, col .. "Elérhető: " .. stockInformation[part][1] .. sightexports.sGui:getColorCodeHex("sightlightgrey") .. " / Lefoglalva: " .. stockInformation[part][5] .. " / SightNIX: " .. stockInformation[part][2])
					else
						sightexports.sGui:setLabelText(label, "Elérhető: ? / Lefoglalva: ? / SightNIX: ?")
					end
					sightexports.sGui:setLabelColor(label, "sightlightgrey")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					stockLabels[part][1] = label
					local label = sightexports.sGui:createGuiElement("label", x, y + h / 3, w * 2, h / 3, orderWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
					if stockInformation[part] then
						if stockInformation[part][2] > 0 then
							if 6 <= stockInformation[part][3] then
								sightexports.sGui:setLabelText(label, "~ " .. math.ceil(stockInformation[part][3] / 6) .. " óra")
							else
								sightexports.sGui:setLabelText(label, "~ " .. stockInformation[part][3] * 10 .. " perc")
							end
							sightexports.sGui:setLabelColor(label, "sightred")
						else
							if stockInformation[part][4] >= 6 then
								sightexports.sGui:setLabelText(label, "~ " .. math.ceil(stockInformation[part][4] / 6) .. " óra")
							else
								sightexports.sGui:setLabelText(label, "~ " .. stockInformation[part][4] * 10 .. " perc")
							end
							sightexports.sGui:setLabelColor(label, "sightgreen")
						end
					else
						sightexports.sGui:setLabelText(label, "? óra")
					end
					sightexports.sGui:setLabelColor(label, "sightlightgrey")
					sightexports.sGui:setLabelAlignment(label, "right", "center")
					stockLabels[part][2] = label
					local label = sightexports.sGui:createGuiElement("label", x + h / 3 + 8, y + h / 3 * 2, w * 2, h / 3, orderWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
					sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(partPrices[part]) .. " $")
					sightexports.sGui:setLabelColor(label, "sightgreen")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					local label = sightexports.sGui:createGuiElement("label", x, y + h / 3 * 2, w * 2, h / 3, orderWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
					sightexports.sGui:setLabelText(label, part)
					sightexports.sGui:setLabelColor(label, "sightlightgrey")
					sightexports.sGui:setLabelAlignment(label, "right", "center")
					local checkbox = sightexports.sGui:createGuiElement("checkbox", x, y + h / 4, h / 3, h / 3, orderWindow)
					sightexports.sGui:setGuiColorScheme(checkbox, "darker")
					sightexports.sGui:setCheckboxChecked(checkbox, orderedParts[part])
					sightexports.sGui:setClickEvent(checkbox, "selectPartForOrder")
					sightexports.sGui:setGuiBoundingBox(checkbox, bbox)
					partCheckboxes[checkbox] = part
					local border = sightexports.sGui:createGuiElement("hr", x, y + h - 1, w * 2, 2, orderWindow)
				end
			end
			if not selectedPart then
				local rect = sightexports.sGui:createGuiElement("rectangle", 8 + w - 2, y, 2, h * 20, orderWindow)
				sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
				local sh = h * 20 / math.max(1, #manufacturerList - 20 + 1)
				manufacturerBar = sightexports.sGui:createGuiElement("rectangle", 8 + w - 2, y + sh * manufacturerScroll, 2, sh, orderWindow)
				sightexports.sGui:setGuiBackground(manufacturerBar, "solid", "sightmidgrey")
				if selectedManufacturer then
					local rect = sightexports.sGui:createGuiElement("rectangle", (8 + w) * 2 - 2, y, 2, h * 20, orderWindow)
					sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
					local sh = h * 20 / math.max(1, #vehicleModels[manufacturerList[selectedManufacturer]] - 20 + 1)
					modelBar = sightexports.sGui:createGuiElement("rectangle", (8 + w) * 2 - 2, y + sh * modelScroll, 2, sh, orderWindow)
					sightexports.sGui:setGuiBackground(modelBar, "solid", "sightmidgrey")
				end
			end
			for i = 1, 20 do
				x = 8
				if not selectedPart then
					if manufacturerList[i + manufacturerScroll] then
						local btn = sightexports.sGui:createGuiElement("button", x, y + h * (i - 1), w - 2, h, orderWindow)
						sightexports.sGui:setGuiBackground(btn, "solid", i + manufacturerScroll == selectedManufacturer and "sightgrey1" or "sightgrey3")
						if i + manufacturerScroll == selectedManufacturer then
							sightexports.sGui:setGuiHoverable(btn, false)
						else
							sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
						end
						sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
						sightexports.sGui:setButtonTextColor(btn, "#ffffff")
						local num = orderPerMake[manufacturerList[i + manufacturerScroll]]
						if num and 0 < num then
							sightexports.sGui:setButtonText(btn, manufacturerList[i + manufacturerScroll] .. " (" .. num .. ")")
						else
							sightexports.sGui:setButtonText(btn, manufacturerList[i + manufacturerScroll])
						end
						sightexports.sGui:setClickEvent(btn, "selectManufacturer")
						manufacturerButtons[btn] = i
					end
					x = x + 8 + w
				end
				if selectedManufacturer then
					if not selectedPart then
						if vehicleModels[manufacturerList[selectedManufacturer]][i + modelScroll] then
							local btn = sightexports.sGui:createGuiElement("button", x, y + h * (i - 1), w - 2, h, orderWindow)
							sightexports.sGui:setGuiBackground(btn, "solid", i + modelScroll == selectedModel and "sightgrey1" or "sightgrey3")
							if i + modelScroll == selectedModel then
								sightexports.sGui:setGuiHoverable(btn, false)
							else
								sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
							end
							sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
							sightexports.sGui:setButtonTextColor(btn, "#ffffff")
							local num = orderPerModel[vehicleModels[manufacturerList[selectedManufacturer]][i + modelScroll][2]]
							if num and 0 < num then
								sightexports.sGui:setButtonText(btn, vehicleModels[manufacturerList[selectedManufacturer]][i + modelScroll][1] .. " (" .. num .. ")")
							else
								sightexports.sGui:setButtonText(btn, vehicleModels[manufacturerList[selectedManufacturer]][i + modelScroll][1])
							end
							sightexports.sGui:setClickEvent(btn, "selectModel")
							modelButtons[btn] = i
						end
						x = x + 8 + w
					end
					if selectedModel then
						if categories[i] then
							local btn = sightexports.sGui:createGuiElement("button", x, y + h * (i - 1), w, h, orderWindow)
							sightexports.sGui:setGuiBackground(btn, "solid", i == selectedCategory and "sightgrey1" or "sightgrey3")
							if i == selectedCategory then
								sightexports.sGui:setGuiHoverable(btn, false)
							else
								sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
							end
							sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
							sightexports.sGui:setButtonTextColor(btn, "#ffffff")
							local num = orderPerCategory[vehicleModels[manufacturerList[selectedManufacturer]][selectedModel][2]] and orderPerCategory[vehicleModels[manufacturerList[selectedManufacturer]][selectedModel][2]][categories[i]]
							if num and 0 < num then
								sightexports.sGui:setButtonText(btn, categories[i] .. " (" .. num .. ")")
							else
								sightexports.sGui:setButtonText(btn, categories[i])
							end
							sightexports.sGui:setClickEvent(btn, "selectCategory")
							categoryButtons[btn] = i
						end
						x = x + 8 + w
						if selectedCategory and partCategories[categories[selectedCategory]][i] then
							local btn = sightexports.sGui:createGuiElement("button", x, y + h * (i - 1), w * 1.75, h, orderWindow)
							sightexports.sGui:setGuiBackground(btn, "solid", i == selectedPart and "sightgrey1" or "sightgrey3")
							if i == selectedPart then
								sightexports.sGui:setGuiHoverable(btn, false)
							else
								sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
							end
							sightexports.sGui:setButtonFont(btn, "10/Ubuntu-R.ttf")
							sightexports.sGui:setButtonTextColor(btn, "#ffffff")
							local num = orderPerPart[vehicleModels[manufacturerList[selectedManufacturer]][selectedModel][2]] and orderPerPart[vehicleModels[manufacturerList[selectedManufacturer]][selectedModel][2]][partCategories[categories[selectedCategory]][i]]
							if num and 0 < num then
								sightexports.sGui:setButtonText(btn, partTypes[partCategories[categories[selectedCategory]][i]].name .. " (" .. num .. ")")
							else
								sightexports.sGui:setButtonText(btn, partTypes[partCategories[categories[selectedCategory]][i]].name)
							end
							sightexports.sGui:setClickEvent(btn, "selectPart")
							partButtons[btn] = i
						end
						x = x + 8 + w * 1.75
					end
				end
			end
		end
	end
end
addEvent("openNixPanel", false)
addEventHandler("openNixPanel", getRootElement(), function()
	currentMenu = 1
	createMechanicOrderGui()
end)
local partComponents = {
	frontLeftPanel = {
		"wing_lf_dummy"
	},
	frontRightPanel = {
		"wing_rf_dummy"
	},
	rearLeftPanel = {
		"wing_lb_dummy"
	},
	rearRightPanel = {
		"wing_rb_dummy"
	},
	windscreen = {
		"windscreen_dummy"
	},
	frontBumper = {
		"bump_front_dummy"
	},
	rearBumper = {
		"bump_rear_dummy"
	},
	hood = {
		"bonnet_dummy"
	},
	trunk = {"boot_dummy"},
	frontLeftDoor = {
		"door_lf_dummy"
	},
	frontRightDoor = {
		"door_rf_dummy"
	},
	rearLeftDoor = {
		"door_lr_dummy"
	},
	rearRightDoor = {
		"door_rr_dummy"
	},
	frontTires = {
		"wheel_lf_dummy",
		"wheel_rf_dummy"
	},
	rearTires = {
		"wheel_lb_dummy",
		"wheel_rb_dummy"
	},
	frontLeftLight = {
		"headlights_left"
	},
	frontRightLight = {
		"headlights_right"
	},
	rearLeftLight = {
		"taillights_left"
	},
	rearRightLight = {
		"taillights_right"
	},
	oilChangeKit = {"engine"},
	engineRepairKit = {"engine"},
	engineGeneralKit = {"engine"},
	engineTimingKit = {"engine"},
	battery = {"engine"},
	fuelRepairKit = {"engine"},
	frontBrakes = {
		"wheel_lf_dummy",
		"wheel_rf_dummy"
	},
	rearBrakes = {
		"wheel_lb_dummy",
		"wheel_rb_dummy"
	},
	frontLeftSuspension = {
		"wheel_lf_dummy"
	},
	frontRightSuspension = {
		"wheel_rf_dummy"
	},
	rearLeftSuspension = {
		"wheel_lb_dummy"
	},
	rearRightSuspension = {
		"wheel_rb_dummy"
	}
}
local partIcons = {
	frontLeftPanel = "fender",
	frontRightPanel = "fender",
	rearLeftPanel = "fender",
	rearRightPanel = "fender",
	windscreen = "windshield",
	frontBumper = "bumper",
	rearBumper = "bumper",
	hood = "hood",
	trunk = "trunk",
	frontLeftDoor = "door",
	frontRightDoor = "door",
	rearLeftDoor = "door",
	rearRightDoor = "door",
	frontTires = "tire",
	rearTires = "tire",
	frontLeftLight = "bulb",
	frontRightLight = "bulb",
	rearLeftLight = "bulb",
	rearRightLight = "bulb",
	oilChangeKit = "oil",
	engineRepairKit = "repair",
	engineGeneralKit = "general",
	engineTimingKit = "timing",
	battery = "battery",
	fuelRepairKit = "fuel",
	frontBrakes = "brake",
	rearBrakes = "brake",
	frontLeftSuspension = "suspension",
	frontRightSuspension = "suspension",
	rearLeftSuspension = "suspension",
	rearRightSuspension = "suspension"
}
local componentList = {}
local componentParts = {}
for k, v in pairs(partComponents) do
	for i = 1, #v do
		if not componentParts[v[i]] then
			componentParts[v[i]] = {}
			table.insert(componentList, v[i])
		end
		table.insert(componentParts[v[i]], k)
	end
end
local tooltipText = false
local partHealthCache = {}
addEvent("acceptMechanicOffer", false)
addEventHandler("acceptMechanicOffer", getRootElement(), function()
	triggerServerEvent("mechanicOfferResponse", localPlayer, true, offerTotal)
	deleteOfferWindow()
end)
addEvent("declineMechanicOffer", false)
addEventHandler("declineMechanicOffer", getRootElement(), function()
	triggerServerEvent("mechanicOfferResponse", localPlayer, false)
	deleteOfferWindow()
end)
addEvent("gotVehiclePartConditionCache", true)
addEventHandler("gotVehiclePartConditionCache", getRootElement(), function(ws, cache)
	if ws == currentWorkshop then
		partHealthCache = {}
		for i = 1, #cache do
			if cache[i] then
				local veh = cache[i][1]
				local part = cache[i][2]
				local hp = cache[i][3]
				if isElement(veh) and tonumber(hp) then
					if not partHealthCache[veh] then
						partHealthCache[veh] = {}
					end
					partHealthCache[veh][part] = hp
					if veh == currentVeh and carPartSwap[veh] and carPartSwap[veh][part] or unlistedPartsEx[part] then
						refreshCarPartsList()
					end
				end
			end
		end
	end
end)
addEvent("gotVehiclePartCondition", true)
addEventHandler("gotVehiclePartCondition", getRootElement(), function(veh, part, hp)
	if isElement(veh) and tonumber(hp) then
		if not partHealthCache[veh] then
			partHealthCache[veh] = {}
		end
		partHealthCache[veh][part] = hp
		if veh == currentVeh and carPartSwap[veh] and carPartSwap[veh][part] or unlistedPartsEx[part] then
			refreshCarPartsList()
		end
	end
end)
local offerListElements = {}
function deleteOfferWindow()
	if offerWindow then
		sightexports.sGui:deleteGuiElement(offerWindow)
	end
	offerWindow = false
	offerBar = false
end
function refreshOfferList()
	for i = 1, #offerListElements do
		if offerList[i + offerScroll] then
			local label = false
			label = offerListElements[i][1]
			sightexports.sGui:setLabelText(label, offerList[i + offerScroll][1])
			label = offerListElements[i][2]
			if offerList[i + offerScroll][2] then
				sightexports.sGui:setGuiHoverable(label, true)
				sightexports.sGui:guiSetTooltip(label, partBackwards[offerList[i + offerScroll][2]][4])
				sightexports.sGui:setLabelText(label, offerList[i + offerScroll][2])
				sightexports.sGui:setLabelColor(label, "#ffffff")
			else
				sightexports.sGui:setGuiHoverable(label, false)
				sightexports.sGui:setLabelText(label, "-")
				sightexports.sGui:setLabelColor(label, "sightlightgrey")
			end
			label = offerListElements[i][3]
			if offerList[i + offerScroll][3] then
				if offerList[i + offerScroll][3] > 100 then
					sightexports.sGui:setLabelText(label, "Professzionális")
					sightexports.sGui:setLabelColor(label, "sightblue-second")
				elseif offerList[i + offerScroll][3] == 100 then
					sightexports.sGui:setLabelText(label, "Gyári")
					sightexports.sGui:setLabelColor(label, "sightgreen")
				elseif offerList[i + offerScroll][3] >= 85 then
					sightexports.sGui:setLabelText(label, "Utángyártott")
					sightexports.sGui:setLabelColor(label, "sightorange-second")
				else
					sightexports.sGui:setLabelText(label, "Felújított")
					sightexports.sGui:setLabelColor(label, "sightred")
				end
			else
				sightexports.sGui:setLabelText(label, "-")
				sightexports.sGui:setLabelColor(label, "sightlightgrey")
			end
			label = offerListElements[i][4]
			sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(offerList[i + offerScroll][4]) .. " $")
			if 1 < i then
				sightexports.sGui:setGuiRenderDisabled(offerListElements[i][5], offerList[i + offerScroll][5])
			end
		end
	end
	if offerBar then
		local n = 17
		local ph = 650
		local h = (ph - titleBarHeight - 8 - 96) / n
		local sh = h * (n - 1) / math.max(1, #offerList - (n - 1) + 1)
		sightexports.sGui:setGuiPosition(offerBar, false, titleBarHeight + 64 + h + sh * offerScroll)
	end
end
function createOfferWindow(veh, mechanic, date, margin, wage)
	deleteOfferWindow()
	titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local pw, ph = 1000, 650
	offerWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
	sightexports.sGui:setWindowTitle(offerWindow, "16/BebasNeueRegular.otf", "Árajánlat")
	local n = 17
	local w = (pw - 16 - 8) / 5.5
	local h = (ph - titleBarHeight - 8 - 96) / n
	local x = 8
	local y = titleBarHeight
	local time = getRealTime(date)
	local label = sightexports.sGui:createGuiElement("label", 8, y, pw, 32, offerWindow)
	local model = getElementData(veh, "vehicle.customModel") or getElementData(veh, "vehicle.customModel") or getElementModel(veh)
	local plate = getVehiclePlateText(veh) or ""
	local tmp = {}
	plate = split(plate, "-")
	for i = 1, #plate do
		if 1 <= utf8.len(plate[i]) then
			table.insert(tmp, plate[i])
		end
	end
	local plate = table.concat(tmp, "-")
	sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelText(label, "Kiállította: " .. mechanic:gsub("_", " ") .. ", " .. string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute) .. " | Jármű: " .. makeAndModel[model][1] .. " " .. makeAndModel[model][2] .. " (" .. plate .. ")")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	y = y + 32
	local label = sightexports.sGui:createGuiElement("label", 8, y, pw, 32, offerWindow)
	sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelText(label, "Árrés: " .. margin .. "% | Munkadíj: " .. sightexports.sGui:thousandsStepper(wage) .. " $ / normaóra")
	sightexports.sGui:setLabelAlignment(label, "left", "center")
	y = y + 32
	local border = sightexports.sGui:createGuiElement("hr", x, y - 1, w * 5.5, 2, offerWindow)
	local border = sightexports.sGui:createGuiElement("hr", x, y + h - 1, w * 5.5, 2, offerWindow)
	local rect = sightexports.sGui:createGuiElement("rectangle", x, y + 1, w * 5.5, h - 2, offerWindow)
	sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
	local border = sightexports.sGui:createGuiElement("hr", x, y, 2, h * n, offerWindow)
	local label = sightexports.sGui:createGuiElement("label", x, y, w * 2, h, offerWindow)
	sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelText(label, "Megnevezés")
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	x = x + w * 2
	local border = sightexports.sGui:createGuiElement("hr", x, y, 2, h * n, offerWindow)
	local label = sightexports.sGui:createGuiElement("label", x, y, w * 1.5, h, offerWindow)
	sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelText(label, "Cikkszám")
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	x = x + w * 1.5
	local border = sightexports.sGui:createGuiElement("hr", x, y, 2, h * n, offerWindow)
	local label = sightexports.sGui:createGuiElement("label", x, y, w * 1, h, offerWindow)
	sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelText(label, "Minőség")
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	x = x + w * 1
	local border = sightexports.sGui:createGuiElement("hr", x, y, 2, h * n, offerWindow)
	local label = sightexports.sGui:createGuiElement("label", x, y, w * 1, h, offerWindow)
	sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelText(label, "Ár")
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	x = x + w * 1
	local border = sightexports.sGui:createGuiElement("hr", x, y, 2, h * n, offerWindow)
	y = y + h
	offerScroll = 0
	local rect = sightexports.sGui:createGuiElement("rectangle", pw - 8 - 2, y, 2, h * (n - 1), offerWindow)
	sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
	local sh = h * (n - 1) / math.max(1, #offerList - (n - 1) + 1)
	offerBar = sightexports.sGui:createGuiElement("rectangle", pw - 8 - 2, y + sh * offerScroll, 2, sh, offerWindow)
	sightexports.sGui:setGuiBackground(offerBar, "solid", "sightmidgrey")
	for i = 1, n - 1 do
		x = 8
		local border = sightexports.sGui:createGuiElement("hr", 8, y - 1, w * 5.5, 2, offerWindow)
		offerListElements[i] = {}
		local label = sightexports.sGui:createGuiElement("label", x, y, w * 2, h, offerWindow)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
		sightexports.sGui:setLabelText(label, "")
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		table.insert(offerListElements[i], label)
		x = x + w * 2
		local label = sightexports.sGui:createGuiElement("label", x, y, w * 1.5, h, offerWindow)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
		sightexports.sGui:setLabelText(label, "")
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		table.insert(offerListElements[i], label)
		x = x + w * 1.5
		local label = sightexports.sGui:createGuiElement("label", x, y, w * 1, h, offerWindow)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
		sightexports.sGui:setLabelText(label, "")
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		table.insert(offerListElements[i], label)
		x = x + w * 1
		local label = sightexports.sGui:createGuiElement("label", x, y, w * 1 - 8, h, offerWindow)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
		sightexports.sGui:setLabelText(label, "")
		sightexports.sGui:setLabelColor(label, "sightgreen")
		sightexports.sGui:setLabelAlignment(label, "right", "center")
		table.insert(offerListElements[i], label)
		table.insert(offerListElements[i], border)
		y = y + h
	end
	local border = sightexports.sGui:createGuiElement("hr", 8, y - 1, w * 5.5, 2, offerWindow)
	refreshOfferList()
	local label = sightexports.sGui:createGuiElement("label", 8 + w * 4.5, y, w * 1 - 8, h, offerWindow)
	sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
	sightexports.sGui:setLabelText(label, "Fizetendő: " .. sightexports.sGui:thousandsStepper(offerTotal) .. " $")
	sightexports.sGui:setLabelColor(label, "sightgreen")
	sightexports.sGui:setLabelAlignment(label, "right", "center")
	local btn = sightexports.sGui:createGuiElement("button", 8, y + 20 - 12, 150, 24, offerWindow)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightred",
		"sightred-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
	sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	sightexports.sGui:setButtonText(btn, "Ajánlat elutasítása")
	sightexports.sGui:setClickEvent(btn, "declineMechanicOffer")
	local btn = sightexports.sGui:createGuiElement("button", 166, y + 20 - 12, 150, 24, offerWindow)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
	sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	sightexports.sGui:setButtonText(btn, "Ajánlat elfogadása")
	sightexports.sGui:setClickEvent(btn, "acceptMechanicOffer")
end
local repairNames = {
	frontLeftPanel = "Bal első panel csere",
	frontRightPanel = "Jobb első panel csere",
	rearLeftPanel = "Bal hátsó panel csere",
	rearRightPanel = "Jobb hátsó panel csere",
	windscreen = "Szélvédő csere",
	frontBumper = "Első lökhárító csere",
	rearBumper = "Hátsó lökhárító csere",
	hood = "Motorháztető csere",
	trunk = "Csomagtartó csere",
	frontLeftDoor = "Bal első ajtó csere",
	frontRightDoor = "Jobb első ajtó csere",
	rearLeftDoor = "Bal hátsó ajtó csere",
	rearRightDoor = "Jobb hátsó ajtó csere",
	frontTires = "Gumicsere (első)",
	rearTires = "Gumicsere (hátsó)",
	frontWinterTires = "Gumicsere (első)",
	rearWinterTires = "Gumicsere (hátsó)",
	frontLeftLight = "Bal első fényszóró csere",
	frontRightLight = "Jobb első fényszóró csere",
	rearLeftLight = "Bal hátsó fényszóró csere",
	rearRightLight = "Jobb hátsó fényszóró csere",
	oilChangeKit = "Olajcsere",
	engineRepairKit = "Motor javítás",
	engineGeneralKit = "Motorgenerál",
	engineTimingKit = "Vezérlés csere",
	battery = "Akkumulátor csere",
	fuelRepairKit = "Üzemanyagrendszer tisztítás és javítás",
	frontBrakes = "Első fék csere",
	rearBrakes = "Hátsó fék csere",
	frontLeftSuspension = "Bal első felfüggesztés csere",
	frontRightSuspension = "Jobb első felfüggesztés csere",
	rearLeftSuspension = "Bal hátsó felfüggesztés csere",
	rearRightSuspension = "Jobb hátsó felfüggesztés csere"
}
addEvent("gotMechanicOffer", true)
addEventHandler("gotMechanicOffer", getRootElement(), function(offer)
	if not offer then
		deleteOfferWindow()
		return
	end
	local veh = offer[1]
	offerTotal = 0
	offerList = {}
	if isElement(veh) and isElement(offer[5]) then
		local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
		local margin = math.max(0, offer[3])
		local wage = math.max(0, offer[4])
		for i = 1, #offer[2] do
			if offer[2][i][1] == "immaterial" then
				local price = math.floor(immaterials[offer[2][i][2]][2]) + math.floor(wage * immaterials[offer[2][i][2]][3] + 0.5)
				table.insert(offerList, {
					immaterials[offer[2][i][2]][1],
					false,
					false,
					price
				})
				offerTotal = offerTotal + price
			elseif offer[2][i][1] == "part" then
				local num = offer[2][i][2]
				if num and partBackwards[num] and partBackwards[num][1] == model then
					local part = partBackwards[num][3]
					local wageForPart = math.floor(wage * partTypes[part].wage + 0.5)
					local partPrice = math.floor(partPrices[num] * (1 + margin / 100) + 0.5)
					table.insert(offerList, {
						partTypes[part].name,
						num,
						partBackwards[num][6],
						partPrice
					})
					if wageForPart and 0 < wageForPart then
						if repairNames[part] then
							table.insert(offerList, {
								"Munkadíj (" .. repairNames[part] .. ")",
								false,
								false,
								wageForPart,
								true
							})
						else
							table.insert(offerList, {
								"Munkadíj",
								false,
								false,
								wageForPart,
								true
							})
						end
					end
					offerTotal = offerTotal + wageForPart + partPrice
				end
			end
		end
		createOfferWindow(veh, getElementData(offer[5], "visibleName"), offer[6], margin, wage)
	end
end)
local partSwapWindow = false
local selectedForSwap = false
local partToSwap = false
local winterTires = false
function processPartSwap(hoveredPart)
	partToSwap = hoveredPart
	if closestVeh and carPartSwap[closestVeh] then
		selectedForSwap = carPartSwap[closestVeh][partToSwap]
		local part = partToSwap
		if winterTires then
			if part == "frontTires" then
				part = "frontWinterTires"
			elseif part == "rearTires" then
				part = "rearWinterTires"
			end
		end
		triggerServerEvent("requestMechanicPartStock", localPlayer, getElementData(closestVeh, "vehicle.customModel") or getElementModel(closestVeh), part)
		createPartSwapWindow()
	end
end
addEvent("swapPartGuiButton", false)
addEventHandler("swapPartGuiButton", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if closestVeh then
		local n = math.min(#carPartsList, 10)
		for i = 1, n do
			local list = carPartsList[i + carPartsScroll]
			if list[2] == "unlisted" and carPartElements[i][2] == el or list[2] == "part" and carPartElements[i][3] == el then
				processPartSwap(list[1])
				return
			end
		end
	end
end)
addEvent("examinePartGuiButton", false)
addEventHandler("examinePartGuiButton", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if closestVeh then
		local n = math.min(#carPartsList, 10)
		for i = 1, n do
			local list = carPartsList[i + carPartsScroll]
			if list[2] == "unlisted" and carPartElements[i][3] == el then
				triggerServerEvent("checkVehiclePart", localPlayer, closestVeh, list[1])
				return
			end
		end
	end
end)
local immaterialCheckboxes = {}
addEvent("selectImmaterialMechanic", false)
addEventHandler("selectImmaterialMechanic", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if closestVeh and immaterialCheckboxes[el] then
		immaterialsSelected[immaterialCheckboxes[el]] = sightexports.sGui:isCheckboxChecked(el)
		recalcOther()
		createCarWindow()
	end
end)
addEvent("deletePartGuiButton", false)
addEventHandler("deletePartGuiButton", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if closestVeh then
		local n = math.min(#carPartsList, 10)
		for i = 1, n do
			local list = carPartsList[i + carPartsScroll]
			if list[2] == "swap" and carPartElements[i][3] == el then
				local part = partBackwards[list[1]][3]
				carPartSwap[closestVeh][part] = nil
				triggerServerEvent("swapVehiclePart", localPlayer, closestVeh, part, false)
				createCarWindow()
				return
			end
		end
	end
end)
local lastCheck = {}
function mechanicClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	if lifting and state == "up" and liftId then
		triggerServerEvent("stopCarLift", getRootElement(), liftId)
		lifting = false
		return
	end
	if partSwapWindow then
		return
	end
	if state == "down" and hoveredPart == "kruton" then
		local x, y, z = workshops[currentWorkshop][6][hoveredWheel][1], workshops[currentWorkshop][6][hoveredWheel][2], workshops[currentWorkshop][6][hoveredWheel][3]
		openKrutonComputer(x, y, z)
	elseif state == "down" and closestVeh and not isPedInVehicle(localPlayer) then
		if sendingOffer then
			if clickedElement and getElementType(clickedElement) == "player" then
				local px, py, pz = getElementPosition(localPlayer)
				local x, y, z = getElementPosition(clickedElement)
				if getDistanceBetweenPoints3D(x, y, z, px, py, pz) <= 5 then
					sendingOffer = false
					createCarWindow()
					triggerServerEvent("tryToSendMechanicOffer", localPlayer, clickedElement, closestVeh, immaterialsSelected, selectedPriceMargin, selectedWage)
				else
					sightexports.sGui:showInfobox("e", "Túl messze vagy a kiválasztott játékostól!")
				end
			end
		elseif hoveredPart and not repairingPart then
			if utf8.sub(hoveredPart, 1, 9) == "wheel_off" then
				local num = tonumber(utf8.sub(hoveredPart, 11, utf8.len(hoveredPart)))
				if num then
					if wheelsOff[closestVeh] and wheelsOff[closestVeh][num] then
						setWheelOffState(closestVeh, num, false)
						screwingWheel = true
						screwMinigame = {
							closestVeh,
							"wheel_" .. num,
							endWheelOn,
							num,
							false,
							{
								0,
								0,
								0,
								0,
								0
							},
							{
								0,
								0,
								0,
								0,
								0
							}
						}
					else
						screwingWheel = true
						screwMinigame = {
							closestVeh,
							"wheel_" .. num,
							endWheelOff,
							num,
							true,
							{
								1,
								1,
								1,
								1,
								1
							},
							{
								1,
								1,
								1,
								1,
								1
							}
						}
					end
				end
			elseif hoveredPart == "placesensor" then
				triggerServerEvent("placeWheelAlignSensor", localPlayer, wheelAlignVeh, hoveredWheel)
			elseif hoveredPart == "removesensor" then
				triggerServerEvent("removeWheelAlignSensor", localPlayer, wheelAlignVeh, hoveredWheel)
			elseif hoveredPart == "alignwheel" then
				triggerServerEvent("alignWheelOnVehicle", localPlayer, wheelAlignVeh, hoveredWheel)
			elseif repairParts[closestVeh] then
				if not repairingResponse then
					if repairParts[closestVeh][hoveredPart] == 1 then
						sightexports.sGui:showInfobox("e", "Már meg van javítva ez az alkatrész!")
					elseif repairParts[closestVeh][hoveredPart] == 0 then
						if hoveredPart == "frontTires" then
							if wheelsOff[closestVeh] and (wheelsOff[closestVeh][1] or wheelsOff[closestVeh][2]) then
								sightexports.sGui:showInfobox("e", "Mindkettő keréknek az autón kell lennie!")
								return
							end
						elseif hoveredPart == "rearTires" then
							if wheelsOff[closestVeh] and (wheelsOff[closestVeh][3] or wheelsOff[closestVeh][4]) then
								sightexports.sGui:showInfobox("e", "Mindkettő keréknek az autón kell lennie!")
								return
							end
						elseif hoveredPart == "frontBrakes" then
							if not (wheelsOff[closestVeh] and wheelsOff[closestVeh][1]) or not wheelsOff[closestVeh][2] then
								sightexports.sGui:showInfobox("e", "Mindkettő kereket le kell szerelni az autóról!")
								return
							end
						elseif hoveredPart == "rearBrakes" and (not (wheelsOff[closestVeh] and wheelsOff[closestVeh][3]) or not wheelsOff[closestVeh][4]) then
							sightexports.sGui:showInfobox("e", "Mindkettő kereket le kell szerelni az autóról!")
							return
						end
						triggerServerEvent("tryToRepairPart", localPlayer, closestVeh, hoveredPart)
						lastClickedWheel = hoveredWheel
						repairingResponse = true
					end
				end
			else
				if getTickCount() - (lastCheck[button .. tostring(hoveredPart)] or 0) < 1000 then
					return
				end
				lastCheck[button .. tostring(hoveredPart)] = getTickCount()
				if button == "left" then
					triggerServerEvent("checkVehiclePart", localPlayer, closestVeh, hoveredPart)
				else
					processPartSwap(hoveredPart)
				end
			end
		end
	end
end
addEvent("repairInvisiblePart", true)
addEventHandler("repairInvisiblePart", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	local n = math.min(#carPartsList, 10)
	for i = 1, n do
		if carPartElements[i] and el == carPartElements[i][3] then
			local list = carPartsList[i + carPartsScroll]
			if list[2] == "repair" and unlistedPartsEx[list[1]] then
				triggerServerEvent("tryToRepairPart", localPlayer, closestVeh, list[1])
			end
			return
		end
	end
end)
addEvent("gotVehiclePartSwapCache", true)
addEventHandler("gotVehiclePartSwapCache", getRootElement(), function(ws, cache)
	if ws == currentWorkshop then
		for i = 1, #cache do
			if cache[i] then
				local veh = cache[i][1]
				local part = cache[i][2]
				local num = cache[i][3]
				if isElement(veh) and (partBackwards[num] or not num) then
					local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
					local partBackward = partBackwards[num] and partBackwards[num][3]
					if partBackward == "frontWinterTires" then
						partBackward = "frontTires"
					elseif partBackward == "rearWinterTires" then
						partBackward = "rearTires"
					end
					if not num or partBackwards[num][1] == model and partBackward == part then
						if not carPartSwap[veh] then
							carPartSwap[veh] = {}
						end
						carPartSwap[veh][part] = num
						if veh == closestVeh then
							createCarWindow()
						end
					end
				end
			end
		end
	end
end)
addEvent("gotVehPartSwapped", true)
addEventHandler("gotVehPartSwapped", getRootElement(), function(veh, part, num)
	if isElement(veh) and (partBackwards[num] or not num) then
		local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
		local partBackward = partBackwards[num] and partBackwards[num][3]
		if partBackward == "frontWinterTires" then
			partBackward = "frontTires"
		elseif partBackward == "rearWinterTires" then
			partBackward = "rearTires"
		end
		if not num or partBackwards[num][1] == model and partBackward == part then
			if not carPartSwap[veh] then
				carPartSwap[veh] = {}
			end
			carPartSwap[veh][part] = num
			if veh == closestVeh then
				createCarWindow()
				if partToSwap then
					createPartSwapWindow()
				end
			end
		end
	end
end)
addEvent("finalPartSwapButton", false)
addEventHandler("finalPartSwapButton", getRootElement(), function()
	if (carPartSwap[closestVeh][partToSwap] or false) ~= (selectedForSwap or false) then
		triggerServerEvent("swapVehiclePart", localPlayer, closestVeh, partToSwap, selectedForSwap)
	end
	partToSwap = false
	selectedForSwap = false
	deletePartSwapWindow()
end)
addEvent("selectPartForSwap", false)
addEventHandler("selectPartForSwap", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	local checked = sightexports.sGui:isCheckboxChecked(el)
	if checked then
		for checkbox, part in pairs(partCheckboxesEx) do
			if checkbox ~= el then
				sightexports.sGui:setCheckboxChecked(checkbox, false)
			end
		end
		selectedForSwap = partCheckboxesEx[el]
	else
		selectedForSwap = false
		for checkbox, part in pairs(partCheckboxesEx) do
			sightexports.sGui:setCheckboxChecked(checkbox, not part)
		end
	end
end)
function deletePartSwapWindow()
	if partSwapWindow then
		sightexports.sGui:deleteGuiElement(partSwapWindow)
	end
	stockLabelsEx = {}
	partCheckboxesEx = {}
	partSwapWindow = false
end
addEvent("swapTireWinter", false)
addEventHandler("swapTireWinter", getRootElement(), function()
	if partToSwap == "frontTires" or partToSwap == "rearTires" then
		winterTires = not winterTires
		local part = partToSwap
		if winterTires then
			if part == "frontTires" then
				part = "frontWinterTires"
			elseif part == "rearTires" then
				part = "rearWinterTires"
			end
		end
		triggerServerEvent("requestMechanicPartStock", localPlayer, getElementData(closestVeh, "vehicle.customModel") or getElementModel(closestVeh), part)
		createPartSwapWindow()
	end
end)
function createPartSwapWindow()
	deletePartSwapWindow()
	stockLabelsEx = {}
	partCheckboxesEx = {}
	if isElement(closestVeh) and partToSwap then
		local model = getElementData(closestVeh, "vehicle.customModel") or getElementModel(closestVeh)
		titleBarHeight = sightexports.sGui:getTitleBarHeight()
		local pw = 400
		local part = partToSwap
		local tires = partToSwap == "frontTires" or partToSwap == "rearTires"
		if winterTires then
			if part == "frontTires" then
				part = "frontWinterTires"
			elseif part == "rearTires" then
				part = "rearWinterTires"
			end
		end
		local manufacturers = partTypes[part].manufacturers
		local ph = titleBarHeight + 32 + 72 * #manufacturers + 48
		if tires then
			ph = ph + 32
		end
		partSwapWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
		sightexports.sGui:setWindowTitle(partSwapWindow, "16/BebasNeueRegular.otf", makeAndModel[model][1] .. " " .. makeAndModel[model][2] .. " - " .. partsOnVehicle[partToSwap].name)
		local w = pw - 16
		local x = 8
		local y = titleBarHeight
		if tires then
			local btn = sightexports.sGui:createGuiElement("button", 0, y, pw / 2, 32, partSwapWindow)
			if not winterTires then
				sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
				sightexports.sGui:setGuiHoverable(btn, false)
			else
				sightexports.sGui:setClickEvent(btn, "swapTireWinter")
				sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
				sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"})
			end
			sightexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
			sightexports.sGui:setButtonTextColor(btn, "#ffffff")
			sightexports.sGui:setButtonText(btn, "Nyári")
			sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("sun", 32))
			local btn = sightexports.sGui:createGuiElement("button", pw / 2, y, pw / 2, 32, partSwapWindow)
			if winterTires then
				sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
				sightexports.sGui:setGuiHoverable(btn, false)
			else
				sightexports.sGui:setClickEvent(btn, "swapTireWinter")
				sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
				sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"})
			end
			sightexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
			sightexports.sGui:setButtonTextColor(btn, "#ffffff")
			sightexports.sGui:setButtonText(btn, "Téli")
			sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("snowflake", 32))
			y = y + 32
		end
		local h = 72
		local bbox = sightexports.sGui:createGuiElement("rectangle", x, y, w, 32, partSwapWindow)
		sightexports.sGui:setGuiBackground(bbox, "solid", {
			0,
			0,
			0,
			0
		})
		sightexports.sGui:setGuiHover(bbox, "none", {
			0,
			0,
			0,
			0
		})
		sightexports.sGui:setGuiHoverable(bbox, true)
		local label = sightexports.sGui:createGuiElement("label", x + h / 3 + 8, y, w, 32, partSwapWindow)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelText(label, "Nincs csere")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		local checkbox = sightexports.sGui:createGuiElement("checkbox", x, y + 16 - h / 3 / 2, h / 3, h / 3, partSwapWindow)
		sightexports.sGui:setGuiColorScheme(checkbox, "darker")
		sightexports.sGui:setCheckboxChecked(checkbox, not selectedForSwap)
		sightexports.sGui:setClickEvent(checkbox, "selectPartForSwap")
		sightexports.sGui:setGuiBoundingBox(checkbox, bbox)
		partCheckboxesEx[checkbox] = false
		local border = sightexports.sGui:createGuiElement("hr", x, y + 32 - 1, w, 2, partSwapWindow)
		for j = 1, #manufacturers do
			local y = y + 32 + (j - 1) * h
			local wage = partTypes[part].wage
			local part = perVehicleParts[model][part][manufacturers[j][1]]
			local bbox = sightexports.sGui:createGuiElement("rectangle", x, y, w, h, partSwapWindow)
			sightexports.sGui:setGuiBackground(bbox, "solid", {
				0,
				0,
				0,
				0
			})
			sightexports.sGui:setGuiHover(bbox, "none", {
				0,
				0,
				0,
				0
			})
			sightexports.sGui:setGuiHoverable(bbox, true)
			local label = sightexports.sGui:createGuiElement("label", x + h / 3 + 8, y, w, h / 3, partSwapWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(label, manufacturers[j][1])
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			local quality = "Felújított"
			local color = "sightred"
			if manufacturers[j][2] > 100 then
				quality = "Professzionális"
				color = "sightblue-second"
			elseif manufacturers[j][2] == 100 then
				quality = "Gyári"
				color = "sightgreen"
			elseif manufacturers[j][2] >= 85 then
				quality = "Utángyártott"
				color = "sightorange-second"
			end
			local label = sightexports.sGui:createGuiElement("label", x, y, w, h / 3, partSwapWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
			sightexports.sGui:setLabelText(label, quality)
			sightexports.sGui:setLabelColor(label, color)
			sightexports.sGui:setLabelAlignment(label, "right", "center")
			local label = sightexports.sGui:createGuiElement("label", x + h / 3 + 8, y + h / 3, w, h / 3, partSwapWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
			if stockInformation[part] then
				local col = false
				if stockInformation[part][1] <= 0 then
					col = sightexports.sGui:getColorCodeHex("sightred")
				else
					col = sightexports.sGui:getColorCodeHex("sightgreen")
				end
				sightexports.sGui:setLabelText(label, col .. "Elérhető: " .. stockInformation[part][1] .. sightexports.sGui:getColorCodeHex("sightlightgrey") .. " / Lefoglalva: " .. stockInformation[part][5])
			else
				sightexports.sGui:setLabelText(label, "Elérhető: ? / Lefoglalva: ?")
				sightexports.sGui:setLabelColor(label, "sightlightgrey")
			end
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			stockLabelsEx[part] = label
			local label = sightexports.sGui:createGuiElement("label", x, y + h / 3, w, h / 3, partSwapWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
			sightexports.sGui:setLabelText(label, "Besz. ár: " .. sightexports.sGui:thousandsStepper(partPrices[part]) .. " $")
			sightexports.sGui:setLabelColor(label, "sightgreen")
			sightexports.sGui:setLabelAlignment(label, "right", "center")
			local wageForPart = math.floor(wages[selectedWage] * wage + 0.5)
			local partPrice = math.floor(partPrices[part] * (1 + priceMargins[selectedPriceMargin] / 100) + 0.5)
			local label = sightexports.sGui:createGuiElement("label", x + h / 3 + 8, y + h / 3 * 2, w / 2, h / 3, partSwapWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
			sightexports.sGui:setLabelText(label, "Ügyfél ár: " .. sightexports.sGui:thousandsStepper(partPrice + wageForPart) .. " $ (" .. wage .. " h)")
			sightexports.sGui:setLabelColor(label, "sightgreen")
			sightexports.sGui:setLabelAlignment(label, "left", "center")
			local label = sightexports.sGui:createGuiElement("label", x, y + h / 3 * 2, w, h / 3, partSwapWindow)
			sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
			sightexports.sGui:setLabelText(label, part)
			sightexports.sGui:setLabelColor(label, "sightlightgrey")
			sightexports.sGui:setLabelAlignment(label, "right", "center")
			local checkbox = sightexports.sGui:createGuiElement("checkbox", x, y + h / 4, h / 3, h / 3, partSwapWindow)
			sightexports.sGui:setGuiColorScheme(checkbox, "darker")
			sightexports.sGui:setClickEvent(checkbox, "selectPartForSwap")
			sightexports.sGui:setGuiBoundingBox(checkbox, bbox)
			partCheckboxesEx[checkbox] = part
			sightexports.sGui:setCheckboxChecked(checkbox, selectedForSwap == part)
			local border = sightexports.sGui:createGuiElement("hr", x, y + h - 1, w, 2, partSwapWindow)
		end
		local btn = sightexports.sGui:createGuiElement("button", pw / 2 - pw * 0.5 / 2, ph - 24 - 12, pw * 0.5, 24, partSwapWindow)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightgreen",
			"sightgreen-second"
		})
		sightexports.sGui:setButtonFont(btn, "12/BebasNeueRegular.otf")
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, "Kiválasztás")
		sightexports.sGui:setClickEvent(btn, "finalPartSwapButton")
	end
end
function deleteCarWindow()
	deletePartSwapWindow()
	local x, y = false, false
	if carWindow then
		x, y = sightexports.sGui:getGuiPosition(carWindow)
		y = y + smallPh / 2
		sightexports.sGui:deleteGuiElement(carWindow)
	end
	carWindow = false
	carPartElements = {}
	carBar = false
	return x, y
end
function processVehicleObjects(hoodX, hoodY, hoodZ)
	if not hoodZ then
		hoodX, hoodY, hoodZ = getVehicleComponentPosition(closestVeh, "bonnet_dummy", "world")
		if not hoodZ then
			hoodX, hoodY, hoodZ = getComponentPosition(closestVeh, "engine")
		end
		hoodZ = hoodZ or z + 0.35
		hoodZ = hoodZ - 0.1
	end
	if isElement(vehicleObjects.suspension_fl) and (not wheelOffInterpolation[closestVeh] or not wheelOffInterpolation[closestVeh][1]) then
		local x, y, z = getVehicleComponentPosition(closestVeh, "wheel_lf_dummy", "world")
		local rx, ry, rz = getVehicleComponentRotation(closestVeh, "wheel_lf_dummy", "world")
		local rad = math.rad(rz)
		z = z - 0.075
		local d = getDistanceBetweenPoints3D(x, y, z, x - math.cos(rad) * 0.25, y - math.sin(rad) * 0.25, hoodZ - 0.052)
		local partRot = math.deg(math.atan(0.25 / math.abs(hoodZ - z)))
		setElementPosition(vehicleObjects.suspension_fl, x, y, z + 0.075)
		setElementRotation(vehicleObjects.suspension_fl, 0, partRot, rz + 180)
		setObjectScale(vehicleObjects.suspension_fl, 1, 1, d / 0.5)
	end
	if isElement(vehicleObjects.suspension_fr) and (not wheelOffInterpolation[closestVeh] or not wheelOffInterpolation[closestVeh][2]) then
		local x, y, z = getVehicleComponentPosition(closestVeh, "wheel_rf_dummy", "world")
		local rx, ry, rz = getVehicleComponentRotation(closestVeh, "wheel_rf_dummy", "world")
		local rad = math.rad(rz)
		z = z - 0.075
		local d = getDistanceBetweenPoints3D(x, y, z, x - math.cos(rad) * 0.25, y - math.sin(rad) * 0.25, hoodZ - 0.052)
		local partRot = math.deg(math.atan(0.25 / math.abs(hoodZ - z)))
		setElementPosition(vehicleObjects.suspension_fr, x, y, z + 0.075)
		setElementRotation(vehicleObjects.suspension_fr, 0, partRot, rz + 180)
		setObjectScale(vehicleObjects.suspension_fr, 1, 1, d / 0.5)
	end
	if isElement(vehicleObjects.suspension_rr) and (not wheelOffInterpolation[closestVeh] or not wheelOffInterpolation[closestVeh][4]) then
		local x, y, z = getVehicleComponentPosition(closestVeh, "wheel_rb_dummy", "world")
		local rx, ry, rz = getVehicleComponentRotation(closestVeh, "wheel_rb_dummy", "world")
		local rad = math.rad(rz)
		local d = getDistanceBetweenPoints3D(x, y, z, x - math.cos(rad) * 0.2, y - math.sin(rad) * 0.2, z + 0.45)
		local partRot = math.deg(math.atan(0.4444444444444445))
		setElementPosition(vehicleObjects.suspension_rr, x, y, z)
		setElementRotation(vehicleObjects.suspension_rr, 0, partRot, rz + 180)
		setObjectScale(vehicleObjects.suspension_rr, 1, 1, d / 0.5)
	end
	if isElement(vehicleObjects.suspension_rl) and (not wheelOffInterpolation[closestVeh] or not wheelOffInterpolation[closestVeh][3]) then
		local x, y, z = getVehicleComponentPosition(closestVeh, "wheel_lb_dummy", "world")
		local rx, ry, rz = getVehicleComponentRotation(closestVeh, "wheel_lb_dummy", "world")
		local rad = math.rad(rz)
		local d = getDistanceBetweenPoints3D(x, y, z, x - math.cos(rad) * 0.2, y - math.sin(rad) * 0.2, z + 0.45)
		local partRot = math.deg(math.atan(0.4444444444444445))
		setElementPosition(vehicleObjects.suspension_rl, x, y, z)
		setElementRotation(vehicleObjects.suspension_rl, 0, partRot, rz + 180)
		setObjectScale(vehicleObjects.suspension_rl, 1, 1, d / 0.5)
	end
	if isElement(vehicleObjects.brake_rl) and (not wheelOffInterpolation[closestVeh] or not wheelOffInterpolation[closestVeh][3]) then
		local x, y, z = getVehicleComponentPosition(closestVeh, "wheel_lb_dummy", "world")
		local rx, ry, rz = getVehicleComponentRotation(closestVeh, "wheel_lb_dummy", "world")
		setElementPosition(vehicleObjects.brake_rl, x, y, z)
		setObjectScale(vehicleObjects.brake_rl, 0.75, -0.75, 0.75)
		setElementDoubleSided(vehicleObjects.brake_rl, true)
		setElementRotation(vehicleObjects.brake_rl, 0, 0, rz + 180)
	end
	if isElement(vehicleObjects.brake_rr) and (not wheelOffInterpolation[closestVeh] or not wheelOffInterpolation[closestVeh][4]) then
		local x, y, z = getVehicleComponentPosition(closestVeh, "wheel_rb_dummy", "world")
		local rx, ry, rz = getVehicleComponentRotation(closestVeh, "wheel_rb_dummy", "world")
		setElementPosition(vehicleObjects.brake_rr, x, y, z)
		setObjectScale(vehicleObjects.brake_rr, 0.75, 0.75, 0.75)
		setElementRotation(vehicleObjects.brake_rr, 0, 0, rz + 180)
	end
	if isElement(vehicleObjects.brake_fl) and (not wheelOffInterpolation[closestVeh] or not wheelOffInterpolation[closestVeh][1]) then
		local x, y, z = getVehicleComponentPosition(closestVeh, "wheel_lf_dummy", "world")
		local rx, ry, rz = getVehicleComponentRotation(closestVeh, "wheel_lf_dummy", "world")
		setElementPosition(vehicleObjects.brake_fl, x, y, z)
		setObjectScale(vehicleObjects.brake_fl, 0.75, -0.75, 0.75)
		setElementDoubleSided(vehicleObjects.brake_fl, true)
		setElementRotation(vehicleObjects.brake_fl, 0, 0, rz + 180)
	end
	if isElement(vehicleObjects.brake_fr) and (not wheelOffInterpolation[closestVeh] or not wheelOffInterpolation[closestVeh][2]) then
		local x, y, z = getVehicleComponentPosition(closestVeh, "wheel_rf_dummy", "world")
		local rx, ry, rz = getVehicleComponentRotation(closestVeh, "wheel_rf_dummy", "world")
		setElementPosition(vehicleObjects.brake_fr, x, y, z)
		setObjectScale(vehicleObjects.brake_fr, 0.75, 0.75, 0.75)
		setElementRotation(vehicleObjects.brake_fr, 0, 0, rz + 180)
	end
end
function refreshCarPartsList()
	local titleBarHeight = 24
	local n = math.min(#carPartsList, 10)
	carScrollNum = math.max(0, #carPartsList - n)
	if carPartsScroll > carScrollNum then
		carPartsScroll = carScrollNum
	end
	local ph = 32
	if carBar then
		local sh = (ph * n - 8) / (carScrollNum + 1)
		sightexports.sGui:setGuiPosition(carBar, false, sh * carPartsScroll)
	end
	for i = 1, n do
		if carPartElements[i] then
			local list = carPartsList[i + carPartsScroll]
			if list[2] == "repair" then
				sightexports.sGui:setLabelFont(carPartElements[i][1], "10/Ubuntu-R.ttf")
				sightexports.sGui:setLabelColor(carPartElements[i][1], "#ffffff")
				sightexports.sGui:setLabelText(carPartElements[i][1], partsOnVehicle[list[1]].name)
				sightexports.sGui:setGuiHoverable(carPartElements[i][1], false)
				sightexports.sGui:setGuiRenderDisabled(carPartElements[i][2], true)
				if unlistedPartsEx[list[1]] then
					sightexports.sGui:setGuiRenderDisabled(carPartElements[i][3], false)
					sightexports.sGui:setClickEvent(carPartElements[i][3], "repairInvisiblePart")
					sightexports.sGui:setImageFile(carPartElements[i][3], sightexports.sGui:getFaIconFilename("wrench", ph - 8))
					sightexports.sGui:setImageColor(carPartElements[i][3], "sightlightgrey")
					sightexports.sGui:setGuiHover(carPartElements[i][3], "solid", "sightgreen")
				else
					sightexports.sGui:setGuiRenderDisabled(carPartElements[i][3], true)
				end
				sightexports.sGui:setGuiRenderDisabled(carPartElements[i][4], true)
			elseif list[2] == "repairImmaterial" then
				sightexports.sGui:setLabelFont(carPartElements[i][1], "10/Ubuntu-R.ttf")
				sightexports.sGui:setLabelColor(carPartElements[i][1], "#ffffff")
				sightexports.sGui:setLabelText(carPartElements[i][1], list[1])
				sightexports.sGui:setGuiHoverable(carPartElements[i][1], false)
				sightexports.sGui:setGuiRenderDisabled(carPartElements[i][2], true)
				sightexports.sGui:setGuiRenderDisabled(carPartElements[i][3], true)
				sightexports.sGui:setGuiRenderDisabled(carPartElements[i][4], false)
				sightexports.sGui:setGuiHoverable(carPartElements[i][4], false)
				sightexports.sGui:setCheckboxChecked(carPartElements[i][4], true)
			elseif list[2] == "repairSwap" then
				sightexports.sGui:setLabelFont(carPartElements[i][1], "10/Ubuntu-L.ttf")
				sightexports.sGui:setLabelColor(carPartElements[i][1], "sightlightgrey")
				sightexports.sGui:setLabelText(carPartElements[i][1], ">> " .. partBackwards[list[1]][4])
				sightexports.sGui:setGuiHoverable(carPartElements[i][1], true)
				sightexports.sGui:guiSetTooltip(carPartElements[i][1], list[1])
				sightexports.sGui:setGuiRenderDisabled(carPartElements[i][2], true)
				sightexports.sGui:setGuiRenderDisabled(carPartElements[i][3], true)
				sightexports.sGui:setGuiRenderDisabled(carPartElements[i][4], false)
				sightexports.sGui:setGuiHoverable(carPartElements[i][4], false)
				sightexports.sGui:setCheckboxChecked(carPartElements[i][4], list[3])
			elseif list[2] == "swap" then
				sightexports.sGui:setLabelFont(carPartElements[i][1], "10/Ubuntu-L.ttf")
				sightexports.sGui:setLabelColor(carPartElements[i][1], "sightlightgrey")
				sightexports.sGui:setLabelText(carPartElements[i][1], ">> " .. partBackwards[list[1]][4] .. " - " .. sightexports.sGui:getColorCodeHex("sightgreen") .. sightexports.sGui:thousandsStepper(math.floor(wages[selectedWage] * partTypes[partBackwards[list[1]][3]].wage + 0.5) + math.floor(partPrices[list[1]] * (1 + priceMargins[selectedPriceMargin] / 100) + 0.5)) .. " $")
				sightexports.sGui:setGuiHoverable(carPartElements[i][1], true)
				sightexports.sGui:guiSetTooltip(carPartElements[i][1], list[1])
				sightexports.sGui:setGuiRenderDisabled(carPartElements[i][2], true)
				sightexports.sGui:setGuiRenderDisabled(carPartElements[i][3], false)
				sightexports.sGui:setGuiRenderDisabled(carPartElements[i][4], true)
				sightexports.sGui:setClickEvent(carPartElements[i][3], "deletePartGuiButton")
				sightexports.sGui:setImageFile(carPartElements[i][3], sightexports.sGui:getFaIconFilename("trash-alt", ph - 8))
				sightexports.sGui:setImageColor(carPartElements[i][3], "sightlightgrey")
				sightexports.sGui:setGuiHover(carPartElements[i][3], "solid", "sightred")
			elseif list[2] == "unlisted" or list[2] == "part" then
				local c = {
					255,
					255,
					255
				}
				local part = list[1]
				if partHealthCache[closestVeh] and partHealthCache[closestVeh][part] then
					c = getPartColor(partHealthCache[closestVeh][part])
				end
				sightexports.sGui:setLabelFont(carPartElements[i][1], "10/Ubuntu-R.ttf")
				sightexports.sGui:setLabelColor(carPartElements[i][1], c)
				sightexports.sGui:setGuiHoverable(carPartElements[i][1], false)
				if partHealthCache[closestVeh] and partHealthCache[closestVeh][part] then
					if partHealthCache[closestVeh][part] < 0 then
						sightexports.sGui:setLabelText(carPartElements[i][1], partsOnVehicle[part].name .. " (" .. math.floor(math.abs(partHealthCache[closestVeh][part]) + 0.5) .. "%, téli)")
					else
						sightexports.sGui:setLabelText(carPartElements[i][1], partsOnVehicle[part].name .. " (" .. math.floor(math.abs(partHealthCache[closestVeh][part]) + 0.5) .. "%)")
					end
				else
					sightexports.sGui:setLabelText(carPartElements[i][1], partsOnVehicle[part].name)
				end
				sightexports.sGui:setImageColor(carPartElements[i][3], "#ffffff")
				sightexports.sGui:setGuiHover(carPartElements[i][3], "solid", "sightgreen")
				if list[2] == "unlisted" then
					sightexports.sGui:setGuiRenderDisabled(carPartElements[i][2], false)
					sightexports.sGui:setGuiRenderDisabled(carPartElements[i][3], false)
					sightexports.sGui:setGuiRenderDisabled(carPartElements[i][4], true)
					sightexports.sGui:setClickEvent(carPartElements[i][2], "swapPartGuiButton")
					sightexports.sGui:setClickEvent(carPartElements[i][3], "examinePartGuiButton")
					sightexports.sGui:setImageFile(carPartElements[i][2], sightexports.sGui:getFaIconFilename("exchange-alt", ph - 8))
					sightexports.sGui:setImageFile(carPartElements[i][3], sightexports.sGui:getFaIconFilename("search", ph - 8))
				else
					sightexports.sGui:setGuiRenderDisabled(carPartElements[i][2], true)
					sightexports.sGui:setGuiRenderDisabled(carPartElements[i][3], false)
					sightexports.sGui:setGuiRenderDisabled(carPartElements[i][4], true)
					sightexports.sGui:setClickEvent(carPartElements[i][3], "swapPartGuiButton")
					sightexports.sGui:setImageFile(carPartElements[i][3], sightexports.sGui:getFaIconFilename("exchange-alt", ph - 8))
				end
			end
			if carPartElements[i][5] then
				sightexports.sGui:setGuiRenderDisabled(carPartElements[i][5], list[2] == "swap" or list[2] == "repairSwap")
			end
		end
	end
end
addEvent("selectMechanicWage", false)
addEventHandler("selectMechanicWage", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if wageButtons[el] then
		selectedWage = wageButtons[el]
		if not wages[selectedWage] then
			selectedWage = 1
		end
		local toSwap = partToSwap
		createCarWindow()
		partToSwap = toSwap
		createPartSwapWindow()
	end
end)
addEvent("selectMechanicPriceMargin", false)
addEventHandler("selectMechanicPriceMargin", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if marginButtons[el] then
		selectedPriceMargin = marginButtons[el]
		if not priceMargins[selectedPriceMargin] then
			selectedPriceMargin = 1
		end
		local toSwap = partToSwap
		createCarWindow()
		partToSwap = toSwap
		createPartSwapWindow()
	end
end)
local partSum = 0
local partProfits = 0
local partWages = 0
addEvent("sendMechanicOffer", false)
addEventHandler("sendMechanicOffer", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if 0 < partProfits + partWages or sendingOffer then
		sendingOffer = not sendingOffer
		createCarWindow()
	else
		sightexports.sGui:showInfobox("e", "Üres árajánlatot nem küldhetsz!")
	end
end)
addEvent("gotRepairJobCache", true)
addEventHandler("gotRepairJobCache", getRootElement(), function(ws, cache)
	if ws == currentWorkshop then
		for i = 1, #cache do
			if cache[i] then
				local veh = cache[i][1]
				local items = cache[i][2]
				if isElement(veh) then
					setElementAlpha(veh, 255)
					partHealthCache[veh] = nil
					carPartSwap[veh] = {}
					repairJobs[veh] = items
					if items then
						local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
						repairParts[veh] = {}
						for i = 1, #items do
							if items[i][1] == "part" then
								local num = items[i][2]
								if num and partBackwards[num] and partBackwards[num][1] == model then
									local part = partBackwards[num][3]
									if part == "frontWinterTires" then
										part = "frontTires"
									elseif part == "rearWinterTires" then
										part = "rearTires"
									end
									repairParts[veh][part] = items[i][4] and 1 or 0
								end
							end
						end
					else
						repairParts[veh] = nil
					end
					if veh == closestVeh then
						createCarWindow()
					end
				end
			end
		end
	end
end)
addEvent("gotVehicleRepairJob", true)
addEventHandler("gotVehicleRepairJob", getRootElement(), function(veh, items)
	if isElement(veh) then
		partHealthCache[veh] = nil
		carPartSwap[veh] = {}
		if repairingPart and repairingPart[1] == veh then
			repairingPart = false
			createMinigameObj(false)
		end
		if screwMinigame and screwMinigame[1] == veh then
			screwMinigame = false
		end
		if partAnimation and partAnimation[1] == veh then
			partAnimation = false
		end
		if veh == closestVeh then
			closestVeh = false
			createVehicleObjects(false)
			createMinigameObj(false)
			resetVehicleComponentPosition(veh, {
				"bump_front_dummy",
				"bump_rear_dummy",
				"bonnet_dummy",
				"boot_dummy",
				"door_lf_dummy",
				"door_rf_dummy",
				"door_lr_dummy",
				"door_rr_dummy"
			})
		end
		spectatorStates[veh] = nil
		carPartSwap[veh] = nil
		repairParts[veh] = nil
		repairJobs[veh] = nil
		repairJobs[veh] = items
		if items then
			local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
			repairParts[veh] = {}
			for i = 1, #items do
				if items[i][1] == "part" then
					local num = items[i][2]
					if num and partBackwards[num] and partBackwards[num][1] == model then
						local part = partBackwards[num][3]
						if part == "frontWinterTires" then
							part = "frontTires"
						elseif part == "rearWinterTires" then
							part = "rearTires"
						end
						repairParts[veh][part] = items[i][4] and 1 or 0
					end
				end
			end
		else
			repairParts[veh] = nil
		end
		if veh == closestVeh then
			createCarWindow()
		end
	end
end)
function deleteCarEndWindow()
	if endJobWindow then
		sightexports.sGui:deleteGuiElement(endJobWindow)
	end
	endJobVeh = false
	endJobWindow = false
end
function createCarEndWindow(car)
	deleteCarEndWindow()
	if isElement(car) then
		endJobVeh = car
		endJobWindow = false
		local model = getElementData(car, "vehicle.customModel") or getElementModel(car)
		local plate = getVehiclePlateText(car) or ""
		local tmp = {}
		plate = split(plate, "-")
		for i = 1, #plate do
			if 1 <= utf8.len(plate[i]) then
				table.insert(tmp, plate[i])
			end
		end
		local plate = table.concat(tmp, "-")
		titleBarHeight = sightexports.sGui:getTitleBarHeight()
		local h = titleBarHeight + 8 + 24 + 8 + 24 + 8
		endJobWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - smallPw / 2, screenY - h - 128, smallPw, h)
		sightexports.sGui:setWindowTitle(endJobWindow, "16/BebasNeueRegular.otf", makeAndModel[model][1] .. " " .. makeAndModel[model][2] .. " (" .. plate .. ")")
		local btn = sightexports.sGui:createGuiElement("button", 8, titleBarHeight + 8, smallPw - 16, 24, endJobWindow)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
		sightexports.sGui:setButtonText(btn, "Szerelés folytatása")
		sightexports.sGui:setClickEvent(btn, "continueMechanicRepairJob")
		local btn = sightexports.sGui:createGuiElement("button", 8, titleBarHeight + 8 + 24 + 8, smallPw - 16, 24, endJobWindow)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightred",
			"sightred-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
		sightexports.sGui:setButtonText(btn, "Szerelés befejezése")
		sightexports.sGui:setClickEvent(btn, "endMechanicRepairJob")
	end
end
function deleteInspectionWindow()
	if endJobWindow then
		sightexports.sGui:deleteGuiElement(endJobWindow)
	end
	endJobVeh = false
	endJobWindow = false
end
function createInspectionWindow(car)
	deleteInspectionWindow()
	if isElement(inspectionVeh) and currentWorkshopPerm then
		local model = getElementData(inspectionVeh, "vehicle.customModel") or getElementModel(inspectionVeh)
		local plate = getVehiclePlateText(inspectionVeh) or ""
		local tmp = {}
		plate = split(plate, "-")
		for i = 1, #plate do
			if 1 <= utf8.len(plate[i]) then
				table.insert(tmp, plate[i])
			end
		end
		local plate = table.concat(tmp, "-")
		titleBarHeight = sightexports.sGui:getTitleBarHeight()
		local h = titleBarHeight + 8 + 24 + 8
		local perm = true
		if perm then
			h = h + 24 + 8
		end
		endJobWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - smallPw / 2, screenY / 2 - h / 2, smallPw, h)
		sightexports.sGui:setWindowTitle(endJobWindow, "16/BebasNeueRegular.otf", makeAndModel[model][1] .. " " .. makeAndModel[model][2] .. " (" .. plate .. ")")
		local y = titleBarHeight + 8
		if perm then
			local btn = sightexports.sGui:createGuiElement("button", 8, y, smallPw - 16, 24, endJobWindow)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
			sightexports.sGui:setButtonText(btn, "Műszaki vizsga (" .. sightexports.sGui:thousandsStepper(examPrice) .. " $)")
			sightexports.sGui:setClickEvent(btn, "mechanicInspectionExam")
			y = y + 24 + 8
		end
		local btn = sightexports.sGui:createGuiElement("button", 8, y, smallPw - 16, 24, endJobWindow)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightblue",
			"sightblue-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
		sightexports.sGui:setButtonText(btn, "Állapotfelmérés")
		sightexports.sGui:setClickEvent(btn, "mechanicInspection")
	end
end
local carWindowCategory = 1
local categoryButtons = {}
addEvent("selectCarWindowCategory", false)
addEventHandler("selectCarWindowCategory", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if categoryButtons[el] then
		carWindowCategory = categoryButtons[el]
		createCarWindow()
	end
end)
function recalcOther()
	for btn, theType in pairs(categoryButtons) do
		if theType == 3 then
			local count = 0
			for k, v in pairs(immaterialsSelected) do
				if v then
					count = count + 1
				end
			end
			if 0 < count then
				sightexports.sGui:setButtonText(btn, "Egyéb (" .. count .. ")")
			end
		end
	end
end
function createCarWindow()
	titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local x, y = deleteCarWindow()
	if currentWorkshopPerm then
		carPartElements = {}
		wageButtons = {}
		marginButtons = {}
		carBar = false
		if isElement(closestVeh) then
			local model = getElementData(closestVeh, "vehicle.customModel") or getElementModel(closestVeh)
			local plate = getVehiclePlateText(closestVeh) or ""
			local tmp = {}
			plate = split(plate, "-")
			for i = 1, #plate do
				if 1 <= utf8.len(plate[i]) then
					table.insert(tmp, plate[i])
				end
			end
			local plate = table.concat(tmp, "-")
			smallPw = 325
			if sendingOffer then
				smallPh = titleBarHeight + 48 + 32 + 8
				carWindow = sightexports.sGui:createGuiElement("window", x or screenX - smallPw - 64, (y or screenY / 2) - smallPh / 2, smallPw, smallPh)
				sightexports.sGui:setWindowTitle(carWindow, "16/BebasNeueRegular.otf", makeAndModel[model][1] .. " " .. makeAndModel[model][2] .. " (" .. plate .. ")")
				y = titleBarHeight
				local label = sightexports.sGui:createGuiElement("label", 8, y, smallPw - 16, 48, carWindow)
				sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
				sightexports.sGui:setLabelText(label, "Kattints egy játékosra\naz árajánlat kiküldéséhez!")
				sightexports.sGui:setLabelAlignment(label, "center", "center")
				y = y + 48
				local btn = sightexports.sGui:createGuiElement("button", 8, y + 16 - 12, smallPw - 16, 24, carWindow)
				sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
				sightexports.sGui:setGuiHover(btn, "gradient", {
					"sightred",
					"sightred-second"
				}, false, true)
				sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
				sightexports.sGui:setButtonText(btn, "Mégsem")
				sightexports.sGui:setClickEvent(btn, "sendMechanicOffer")
			else
				carPartsList = {}
				smallPh = titleBarHeight
				if repairJobs[closestVeh] then
					local items = repairJobs[closestVeh]
					for i = 1, #items do
						if items[i][1] == "part" then
							local num = items[i][2]
							if num and partBackwards[num] and partBackwards[num][1] == model then
								local part = partBackwards[num][3]
								if part == "frontWinterTires" then
									part = "frontTires"
								elseif part == "rearWinterTires" then
									part = "rearTires"
								end
								table.insert(carPartsList, {
									part,
									"repair",
									items[i][4]
								})
								table.insert(carPartsList, {
									num,
									"repairSwap",
									items[i][4]
								})
							end
						elseif items[i][1] == "immaterial" then
							table.insert(carPartsList, {
								immaterials[items[i][2]][1],
								"repairImmaterial"
							})
						end
					end
				else
					smallPh = smallPh + 8 + 128 + 8 + 64
					if carWindowCategory == 2 then
						for i = 1, #listOfCarParts do
							if unlistedPartsEx[listOfCarParts[i]] then
								table.insert(carPartsList, {
									listOfCarParts[i],
									"unlisted"
								})
								if carPartSwap[closestVeh][listOfCarParts[i]] then
									table.insert(carPartsList, {
										carPartSwap[closestVeh][listOfCarParts[i]],
										"swap"
									})
								end
							end
						end
					elseif carWindowCategory == 1 then
						for i = 1, #listOfCarParts do
							if not unlistedPartsEx[listOfCarParts[i]] and carPartSwap[closestVeh][listOfCarParts[i]] then
								table.insert(carPartsList, {
									listOfCarParts[i],
									"part"
								})
								if carPartSwap[closestVeh][listOfCarParts[i]] then
									table.insert(carPartsList, {
										carPartSwap[closestVeh][listOfCarParts[i]],
										"swap"
									})
								end
							end
						end
					end
				end
				local n = math.min(#carPartsList, 10)
				local ph = 32
				smallPh = smallPh + 32 + 8 + 8
				if repairJobs[closestVeh] then
					smallPh = smallPh + ph * n
				else
					if carWindowCategory == 3 then
						smallPh = smallPh + ph * #immaterials
					else
						smallPh = smallPh + ph * n
					end
					smallPh = smallPh + 24
				end
				carWindow = sightexports.sGui:createGuiElement("window", x or screenX - smallPw - 64, (y or screenY / 2) - smallPh / 2, smallPw, smallPh)
				sightexports.sGui:setWindowTitle(carWindow, "16/BebasNeueRegular.otf", makeAndModel[model][1] .. " " .. makeAndModel[model][2] .. " (" .. plate .. ")")
				local y = titleBarHeight
				categoryButtons = {}
				if not repairJobs[closestVeh] then
					local btn = sightexports.sGui:createGuiElement("button", 0, y, smallPw / 3, 24, carWindow)
					if carWindowCategory == 1 then
						sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
						sightexports.sGui:setGuiHoverable(btn, false)
					else
						sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
						sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
					end
					sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
					sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("eye", 24, "regular"))
					sightexports.sGui:setButtonText(btn, "Látható")
					sightexports.sGui:setClickEvent(btn, "selectCarWindowCategory")
					categoryButtons[btn] = 1
					local btn = sightexports.sGui:createGuiElement("button", smallPw / 3, y, smallPw / 3, 24, carWindow)
					if carWindowCategory == 2 then
						sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
						sightexports.sGui:setGuiHoverable(btn, false)
					else
						sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
						sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
					end
					sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
					sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("eye-slash", 24, "regular"))
					sightexports.sGui:setButtonText(btn, "Nem látható")
					sightexports.sGui:setClickEvent(btn, "selectCarWindowCategory")
					categoryButtons[btn] = 2
					local btn = sightexports.sGui:createGuiElement("button", smallPw / 3 * 2, y, smallPw / 3, 24, carWindow)
					if carWindowCategory == 3 then
						sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey2")
						sightexports.sGui:setGuiHoverable(btn, false)
					else
						sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey3")
						sightexports.sGui:setGuiHover(btn, "gradient", {"sightgrey1", "sightgrey2"}, false, true)
					end
					sightexports.sGui:setButtonFont(btn, "12/BebasNeueBold.otf")
					sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("boxes", 24))
					sightexports.sGui:setButtonText(btn, "Egyéb (0)")
					sightexports.sGui:setClickEvent(btn, "selectCarWindowCategory")
					categoryButtons[btn] = 3
					recalcOther()
					y = y + 24
				end
				carScrollNum = math.max(0, #carPartsList - n)
				if carPartsScroll > carScrollNum then
					carPartsScroll = carScrollNum
				end
				if n < #carPartsList then
					local rect = sightexports.sGui:createGuiElement("rectangle", smallPw - 4 - 1, y + 4, 2, ph * n - 8, carWindow)
					sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
					local sh = (ph * n - 8) / (carScrollNum + 1)
					carBar = sightexports.sGui:createGuiElement("rectangle", 0, sh * carPartsScroll, 2, sh, rect)
					sightexports.sGui:setGuiBackground(carBar, "solid", "sightmidgrey")
				end
				for i = 1, n do
					carPartElements[i] = {}
					local label = sightexports.sGui:createGuiElement("label", 8, y, smallPw - 16 - ph * 2, ph, carWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightexports.sGui:setLabelText(label, "")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					table.insert(carPartElements[i], label)
					local icon = sightexports.sGui:createGuiElement("image", smallPw - ph * 2, y + 4, ph - 8, ph - 8, carWindow)
					sightexports.sGui:setImageFile(icon, sightexports.sGui:getFaIconFilename("exchange-alt", ph - 8))
					sightexports.sGui:setImageColor(icon, "#ffffff")
					sightexports.sGui:setGuiHoverable(icon, true)
					sightexports.sGui:setGuiHover(icon, "solid", "sightgreen")
					table.insert(carPartElements[i], icon)
					local icon2 = sightexports.sGui:createGuiElement("image", smallPw - ph, y + 4, ph - 8, ph - 8, carWindow)
					sightexports.sGui:setImageFile(icon2, sightexports.sGui:getFaIconFilename("search", ph - 8))
					sightexports.sGui:setImageColor(icon2, "#ffffff")
					sightexports.sGui:setGuiHoverable(icon2, true)
					sightexports.sGui:setGuiHover(icon2, "solid", "sightgreen")
					table.insert(carPartElements[i], icon2)
					local checkbox = sightexports.sGui:createGuiElement("checkbox", smallPw - ph, y + 4, ph - 8, ph - 8, carWindow)
					sightexports.sGui:setGuiColorScheme(checkbox, "darker")
					table.insert(carPartElements[i], checkbox)
					if 1 < i then
						local border = sightexports.sGui:createGuiElement("hr", 8, y - 1, smallPw - 16, 2, carWindow)
						table.insert(carPartElements[i], border)
					end
					y = y + ph
				end
				immaterialCheckboxes = {}
				if carWindowCategory == 3 and not repairJobs[closestVeh] then
					for i = 1, #immaterials do
						local label = sightexports.sGui:createGuiElement("label", 8, y, smallPw - 16 - ph * 2, ph, carWindow)
						sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
						sightexports.sGui:setLabelText(label, immaterials[i][1] .. " - (" .. immaterials[i][3] .. " h) - " .. sightexports.sGui:getColorCodeHex("sightgreen") .. sightexports.sGui:thousandsStepper(math.floor(immaterials[i][2]) + math.floor(wages[selectedWage] * immaterials[i][3] + 0.5)) .. " $")
						sightexports.sGui:setLabelAlignment(label, "left", "center")
						local checkbox = sightexports.sGui:createGuiElement("checkbox", smallPw - ph, y + 4, ph - 8, ph - 8, carWindow)
						sightexports.sGui:setGuiColorScheme(checkbox, "darker")
						sightexports.sGui:setClickEvent(checkbox, "selectImmaterialMechanic")
						sightexports.sGui:setCheckboxChecked(checkbox, immaterialsSelected[i])
						immaterialCheckboxes[checkbox] = i
						if 1 < i then
							local border = sightexports.sGui:createGuiElement("hr", 8, y - 1, smallPw - 16, 2, carWindow)
						end
						y = y + ph
					end
				end
				if 0 < n or carWindowCategory == 3 then
					local border = sightexports.sGui:createGuiElement("hr", 8, y - 1, smallPw - 16, 2, carWindow)
				end
				y = y + 8
				if not repairJobs[closestVeh] then
					local x = 8
					local label = sightexports.sGui:createGuiElement("label", x, y, smallPw, 32, carWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightexports.sGui:setLabelText(label, "M: ")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					x = x + sightexports.sGui:getLabelTextWidth(label) + 8
					for i = 1, #wages do
						local t = math.floor(wages[i] / 1000 * 10) / 10 .. "k $"
						local w = sightexports.sGui:getTextWidthFont(t, "9/Ubuntu-R.ttf") + 6
						local btn = sightexports.sGui:createGuiElement("button", x, y + 16 - 12, w, 24, carWindow)
						local col = 0 < wages[i] and "sightgreen" or "sightred"
						if i == selectedWage then
							sightexports.sGui:setGuiBackground(btn, "solid", col)
							sightexports.sGui:setGuiHoverable(btn, false)
						else
							sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
							sightexports.sGui:setGuiHover(btn, "gradient", {
								col,
								col .. "-second"
							}, false, true)
							sightexports.sGui:setClickEvent(btn, "selectMechanicWage")
							wageButtons[btn] = i
						end
						sightexports.sGui:setButtonFont(btn, "9/Ubuntu-R.ttf")
						sightexports.sGui:setButtonTextColor(btn, "#ffffff")
						sightexports.sGui:guiSetTooltip(btn, sightexports.sGui:thousandsStepper(wages[i]) .. " $")
						sightexports.sGui:setButtonText(btn, t)
						x = x + w + 6
					end
					y = y + 32
					local x = 8
					local label = sightexports.sGui:createGuiElement("label", x, y, smallPw, 32, carWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightexports.sGui:setLabelText(label, "Á: ")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					x = x + sightexports.sGui:getLabelTextWidth(label) + 8
					for i = 1, #priceMargins do
						local w = sightexports.sGui:getTextWidthFont(priceMargins[i] .. " %", "9/Ubuntu-R.ttf") + 6
						local btn = sightexports.sGui:createGuiElement("button", x, y + 16 - 12, w, 24, carWindow)
						local col = 0 < priceMargins[i] and "sightgreen" or "sightred"
						if i == selectedPriceMargin then
							sightexports.sGui:setGuiBackground(btn, "solid", col)
							sightexports.sGui:setGuiHoverable(btn, false)
						else
							sightexports.sGui:setGuiBackground(btn, "solid", "sightgrey1")
							sightexports.sGui:setGuiHover(btn, "gradient", {
								col,
								col .. "-second"
							}, false, true)
							sightexports.sGui:setClickEvent(btn, "selectMechanicPriceMargin")
							marginButtons[btn] = i
						end
						sightexports.sGui:setButtonFont(btn, "9/Ubuntu-R.ttf")
						sightexports.sGui:setButtonTextColor(btn, "#ffffff")
						sightexports.sGui:setButtonText(btn, priceMargins[i] .. " %")
						x = x + w + 6
					end
					partSum = 0
					partProfits = 0
					partWages = 0
					for i = 1, #listOfCarParts do
						local part = carPartSwap[closestVeh][listOfCarParts[i]]
						if part and partBackwards[part] then
							local wageForPart = math.floor(wages[selectedWage] * partTypes[partBackwards[part][3]].wage + 0.5)
							local partPriceProfit = math.floor(partPrices[part] * (1 + priceMargins[selectedPriceMargin] / 100) + 0.5)
							local partPrice = partPrices[part]
							partSum = partSum + partPrice
							partProfits = partProfits + partPriceProfit
							partWages = partWages + wageForPart
						end
					end
					for i = 1, #immaterials do
						if immaterialsSelected[i] then
							partSum = partSum + math.floor(immaterials[i][2])
							partProfits = partProfits + math.floor(immaterials[i][2])
							partWages = partWages + math.floor(wages[selectedWage] * immaterials[i][3] + 0.5)
						end
					end
					y = y + 32 + 8
					local border = sightexports.sGui:createGuiElement("hr", 8, y - 1, smallPw - 16, 2, carWindow)
					local label = sightexports.sGui:createGuiElement("label", 8, y, smallPw, 32, carWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightexports.sGui:setLabelText(label, "Alkatrészek: ")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					local label = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(label), y, smallPw, 32, carWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
					sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(partSum) .. " $")
					sightexports.sGui:setLabelColor(label, 0 < partSum and "sightgreen" or "sightred")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					y = y + 32
					local label = sightexports.sGui:createGuiElement("label", 8, y, smallPw, 32, carWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightexports.sGui:setLabelText(label, "Árrés: ")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					local label = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(label), y, smallPw, 32, carWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
					sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(partProfits - partSum) .. " $")
					sightexports.sGui:setLabelColor(label, 0 < partProfits - partSum and "sightgreen" or "sightred")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					y = y + 32
					local label = sightexports.sGui:createGuiElement("label", 8, y, smallPw, 32, carWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightexports.sGui:setLabelText(label, "Munkadíj: ")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					local label = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(label), y, smallPw, 32, carWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
					sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(partWages) .. " $")
					sightexports.sGui:setLabelColor(label, 0 < partWages and "sightgreen" or "sightred")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					y = y + 32
					local label = sightexports.sGui:createGuiElement("label", 8, y, smallPw, 32, carWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightexports.sGui:setLabelText(label, "Fizetendő: ")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					local label = sightexports.sGui:createGuiElement("label", 8 + sightexports.sGui:getLabelTextWidth(label), y, smallPw, 32, carWindow)
					sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
					sightexports.sGui:setLabelText(label, sightexports.sGui:thousandsStepper(partProfits + partWages) .. " $")
					sightexports.sGui:setLabelColor(label, 0 < partProfits + partWages and "sightgreen" or "sightred")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					y = y + 32
					local border = sightexports.sGui:createGuiElement("hr", 8, y - 1, smallPw - 16, 2, carWindow)
					y = y + 8
					local btn = sightexports.sGui:createGuiElement("button", 8, y + 16 - 12, smallPw - 16, 24, carWindow)
					sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
					sightexports.sGui:setGuiHover(btn, "gradient", {
						"sightgreen",
						"sightgreen-second"
					}, false, true)
					sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
					sightexports.sGui:setButtonText(btn, "Árajánlat küldése")
					sightexports.sGui:setClickEvent(btn, "sendMechanicOffer")
				else
					local btn = sightexports.sGui:createGuiElement("button", 8, y + 16 - 12, smallPw - 16, 24, carWindow)
					sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
					sightexports.sGui:setGuiHover(btn, "gradient", {
						"sightred",
						"sightred-second"
					}, false, true)
					sightexports.sGui:setButtonFont(btn, "13/BebasNeueRegular.otf")
					sightexports.sGui:setButtonText(btn, "Szerelés befejezése")
					sightexports.sGui:setClickEvent(btn, "tryToEndMechanicRepairJobPrompt")
				end
				refreshCarPartsList()
			end
		end
	end
end
function getPartColor(hp)
	hp = math.abs(hp)
	local q = 50
	if hp < q then
		return {
			red[1] + (orange[1] - red[1]) * (hp / q),
			red[2] + (orange[2] - red[2]) * (hp / q),
			red[3] + (orange[3] - red[3]) * (hp / q)
		}
	elseif hp < 100 then
		return {
			orange[1] + (green[1] - orange[1]) * ((hp - q) / q),
			orange[2] + (green[2] - orange[2]) * ((hp - q) / q),
			orange[3] + (green[3] - orange[3]) * ((hp - q) / q)
		}
	elseif hp < 0 then
		return red
	else
		return green
	end
end
local noBonnetCars = {
	[411] = true,
	[415] = true,
	[451] = true,
	[474] = true,
	[480] = true,
	[494] = true,
	[506] = true,
	[533] = true
}
function isPartVisible(veh, comp, part)
	local wheel = wheelsOff[veh] or {}
	if comp == "engine" then
		if not getVehicleComponentPosition(veh, "bonnet_dummy") then
			return true
		elseif getVehicleDoorState(veh, 0) == 4 then
			return true
		else
			local model = getElementData(veh, "vehicle.customModel") or getElementModel(veh)
			if noBonnetCars[model] then
				return true
			end
			return getVehicleDoorOpenRatio(veh, 0) > 0.75
		end
	elseif part == "frontLeftSuspension" or part == "frontRightSuspension" or part == "rearLeftSuspension" or part == "rearRightSuspension" or part == "frontBrakes" or part == "rearBrakes" then
		if comp == "wheel_lf_dummy" then
			return wheel[1]
		elseif comp == "wheel_rf_dummy" then
			return wheel[2]
		elseif comp == "wheel_lb_dummy" then
			return wheel[3]
		elseif comp == "wheel_rb_dummy" then
			return wheel[4]
		end
	elseif part == "frontTires" or part == "rearTires" then
		if comp == "wheel_lf_dummy" then
			return not wheel[1]
		elseif comp == "wheel_rf_dummy" then
			return not wheel[2]
		elseif comp == "wheel_lb_dummy" then
			return not wheel[3]
		elseif comp == "wheel_rb_dummy" then
			return not wheel[4]
		end
	end
	return true
end
local canEndScrew = 0
local screwP = 0
local lastDeltaTime = getTickCount()
function deleteHexWindow()
	local x, y = false, false
	if hexWindow then
		x, y = sightexports.sGui:getGuiPosition(hexWindow)
		sightexports.sGui:deleteGuiElement(hexWindow)
	end
	hexWindow = false
	return x, y
end
addEvent("continueMechanicRepairJob", false)
addEventHandler("continueMechanicRepairJob", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	deleteCarEndWindow()
end)
addEvent("tryToEndMechanicRepairJobPrompt", false)
addEventHandler("tryToEndMechanicRepairJobPrompt", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if isElement(closestVeh) then
		createCarEndWindow(closestVeh)
	end
end)
addEvent("endMechanicRepairJob", false)
addEventHandler("endMechanicRepairJob", getRootElement(), function(button, state, absoluteX, absoluteY, el)
	if isElement(endJobVeh) then
		local found = false
		local px, py, pz = getElementPosition(localPlayer)
		for i = 1, #workshops[currentWorkshop][6] do
			if workshops[currentWorkshop][6][i][4] then
				local x, y = workshops[currentWorkshop][6][i][1], workshops[currentWorkshop][6][i][2]
				local d = getDistanceBetweenPoints2D(x, y, px, py)
				if d < 3 then
					found = true
					break
				end
			end
		end
		if found then
			triggerServerEvent("tryToEndRepairJob", localPlayer, endJobVeh)
			deleteCarEndWindow()
		else
			sightexports.sGui:showInfobox("e", "A szerelést csak egy Kruton-terminálnál tudod befejezni.")
		end
	end
end)
function createHexWindow()
	local x, y = deleteHexWindow()
	hexButtons = {}
	titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local w = 48
	local panelWidth = w * #hexSizes
	local panelHeight = titleBarHeight + w + 24
	hexWindow = sightexports.sGui:createGuiElement("window", x or screenX / 2 - panelWidth / 2, y or screenY - 128 - panelHeight, panelWidth, panelHeight)
	sightexports.sGui:setWindowTitle(hexWindow, "16/BebasNeueRegular.otf", "Bitfejek")
	for i = 1, #hexSizes do
		local iw = (w - 16) / 19 * hexSizes[i]
		local bbox = sightexports.sGui:createGuiElement("rectangle", w * (i - 1), titleBarHeight, w, w + 24, hexWindow)
		sightexports.sGui:setGuiHoverable(bbox, true)
		sightexports.sGui:setGuiHover(bbox, "none")
		sightexports.sGui:setGuiBackground(bbox, "solid", {
			0,
			0,
			0,
			0
		})
		local label = sightexports.sGui:createGuiElement("label", w * (i - 1), titleBarHeight + w - 4, w, 28, hexWindow)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
		sightexports.sGui:setLabelText(label, "M" .. hexSizes[i])
		sightexports.sGui:setLabelColor(label, hexSizes[i] == currentHexSize and "sightgreen" or "#ffffff")
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		local icon = sightexports.sGui:createGuiElement("image", w * (i - 0.5) - iw / 2, titleBarHeight + w / 2 - iw / 2, iw, iw, hexWindow)
		sightexports.sGui:setImageDDS(icon, ":sMechanic/files/hex.dds")
		if currentHexSize == hexSizes[i] then
			sightexports.sGui:setImageColor(icon, "sightgreen")
		else
			sightexports.sGui:setImageColor(icon, "#ffffff")
			sightexports.sGui:setGuiHoverable(icon, true)
			sightexports.sGui:setGuiBoundingBox(icon, bbox)
			sightexports.sGui:setGuiHover(icon, "solid", "sightgreen")
			sightexports.sGui:setClickEvent(icon, "selectHexSize")
			hexButtons[icon] = hexSizes[i]
		end
	end
end
local sounds = {}
local gunStates = {}
local wrenchObjects = {}
addEventHandler("onClientPlayerDataChange", getRootElement(), function(data, old, new)
	if data == "wrenchState" then
		if new then
			if isElementStreamedIn(source) and not isElement(wrenchObjects[source]) then
				wrenchObjects[source] = createObject(objectModels.impact_wrench, 0, 0, 0)
				setElementCollisionsEnabled(wrenchObjects[source], false)
				sightexports.sPattach:attach(wrenchObjects[source], source, "right-hand", -0.025, 0.05, 0, 0, 0, 110)
			end
		else
			if isElement(wrenchObjects[source]) then
				destroyElement(wrenchObjects[source])
			end
			wrenchObjects[source] = nil
		end
		if source == localPlayer then
			currentHexSize = new and 13 or false
			sightexports.sWeapons:setWrenchState(currentHexSize)
		end
	end
end)
addEventHandler("onClientPlayerStreamIn", getRootElement(), function()
	if getElementData(source, "wrenchState") and not isElement(wrenchObjects[source]) then
		wrenchObjects[source] = createObject(objectModels.impact_wrench, 0, 0, 0)
		setElementCollisionsEnabled(wrenchObjects[source], false)
		sightexports.sPattach:attach(wrenchObjects[source], source, "right-hand", -0.025, 0.05, 0, 0, 0, 110)
	end
end)
addEventHandler("onClientPlayerStreamOut", getRootElement(), function()
	if isElement(wrenchObjects[source]) then
		destroyElement(wrenchObjects[source])
	end
	wrenchObjects[source] = nil
	if sounds[source] then
		if isElement(sounds[source]) then
			destroyElement(sounds[source])
		end
		sounds[source] = nil
	end
	gunStates[source] = nil
end)
addEventHandler("onClientPlayerQuit", getRootElement(), function()
	if isElement(wrenchObjects[source]) then
		destroyElement(wrenchObjects[source])
	end
	wrenchObjects[source] = nil
	if sounds[source] then
		if isElement(sounds[source]) then
			destroyElement(sounds[source])
		end
		sounds[source] = nil
	end
	gunStates[source] = nil
end)
addEvent("impactGunState", true)
addEventHandler("impactGunState", getRootElement(), function(state, dir)
	if isElement(source) then
		gunStates[source] = state
		if state then
			if source ~= localPlayer or sightexports.sCamera:getCurrentCamera() ~= "fp" then
				setPedAnimation(source, "drill" .. dir, "gun_stand")
			end
		else
			setPedAnimation(source)
		end
	end
end)
local click = false
local brakeScrewMatrix = {
	{
		1.5707963267948966,
		0.75,
		1.5707963267948966,
		0.75,
		-0.1875,
		0,
		-1.5
	},
	{
		1.5707963267948966,
		1.8375000000000001,
		1.5707963267948966,
		1.8375000000000001,
		0.3375,
		3.141592653589793,
		-1.125
	},
	{
		1.5707963267948966,
		1.0499999999999998,
		1.5707963267948966,
		1.0499999999999998,
		1.5,
		3.141592653589793,
		-1.125
	}
}
local wheelScrewMatrix = {
	{
		0,
		0,
		0,
		0,
		0.96
	},
	{
		-1.5707963267948966,
		1,
		-1.5707963267948966,
		1,
		0.2
	},
	{
		1.5707963267948966,
		1,
		1.5707963267948966,
		1,
		0.2
	},
	{
		-1.5707963267948966,
		0.5,
		-1.5707963267948966,
		0.5,
		-1
	},
	{
		1.5707963267948966,
		0.5,
		1.5707963267948966,
		0.5,
		-1
	}
}
function resetWheelsOff(veh)
	if veh and originalWheelsOff[veh] and wheelsOff[veh] then
		for j = 1, 4 do
			wheelsOff[veh][j] = originalWheelsOff[veh][j]
			local comp = false
			if j == 1 then
				comp = "wheel_lf_dummy"
			elseif j == 2 then
				comp = "wheel_rf_dummy"
			elseif j == 3 then
				comp = "wheel_lb_dummy"
			elseif j == 4 then
				comp = "wheel_rb_dummy"
			end
			setVehicleComponentVisible(veh, comp, not wheelsOff[veh][j])
		end
	end
end
local lastClick = {}
local liftSounds = {}
local liftStates = {}
addEvent("toggleLiftState", true)
addEventHandler("toggleLiftState", getRootElement(), function(i, state)
	if currentWorkshop and state and (not liftSounds[i] or not isElement(liftSounds[i][1])) then
		liftSounds[i] = {
			playSound3D("files/lift.mp3", lifts[i][1], lifts[i][2], lifts[i][3], true),
			lifts[i][1],
			lifts[i][2],
			lifts[i][3]
		}
	end
	liftStates[i] = state
end)
local krutonPrints = {}
addEvent("krutonPrint", true)
addEventHandler("krutonPrint", getRootElement(), function(id, num)
	for k = 1, #krutonPrints do
		if krutonPrints[k][1] == id then
			krutonPrints[k][2] = krutonPrints[k][2] + num
			return
		end
	end
	local x = workshops[currentWorkshop][6][id][1] + math.cos(math.rad(workshops[currentWorkshop][6][id][4]) - 1.5707963267948966) * -0.15000000000000002
	local y = workshops[currentWorkshop][6][id][2] + math.sin(math.rad(workshops[currentWorkshop][6][id][4]) - 1.5707963267948966) * -0.15000000000000002
	local z = workshops[currentWorkshop][6][id][3] - 0.375 + 0.1
	local obj = createObject(objectModels.mechanic_document, x, y, z, -3, 0, workshops[currentWorkshop][6][id][4])
	setElementDoubleSided(obj, true)
	setElementCollisionsEnabled(obj, false)
	setObjectScale(obj, 0.95)
	table.insert(krutonPrints, {
		id,
		num,
		0,
		obj
	})
end)
function partAnimationHandler(now, delta)
	if partAnimation then
		if isElement(partAnimation[1]) then
			if partAnimation[2] == "oilin" then
				local p = (now - partAnimation[3]) / 650
				local p2 = 1
				if 10 < p then
					p2 = 1 - (p - 10)
				end
				if 1 < p then
					p = 1
				end
				local x, y, z = getComponentPosition(partAnimation[1], "engine")
				local rx, ry, rz = getElementRotation(partAnimation[1])
				for i in pairs(engineParts) do
					setElementPosition(engineParts[i], x, y, z - 0.35)
					setElementRotation(engineParts[i], rx, ry, rz)
				end
				local rad = math.rad(rz)
				x = x + math.cos(rad) * -0.165
				y = y + math.sin(rad) * -0.165
				z = z + 0.5
				if oilObject then
					setElementPosition(oilObject, x, y, z - 0.075)
					setElementRotation(oilObject, 0, 0, rz - 90)
				end
				if p2 < 0 then
					p2 = 0
					local fn = partAnimation[7]
					partAnimation = false
					if fn then
						fn()
					end
				elseif oilTexture then
					dxDrawMaterialSectionLine3D(x, y, z - 0.075 - 0.4 * (1 - p2), x, y, z - 0.075 - 0.4 * p, 0, 24 + 488 * (1 - p2), 64, 488 * p * p2, oilTexture, 0.05)
				end
			elseif partAnimation[2] == "oil" then
				local p = (now - partAnimation[3]) / 2000
				local p2 = 1
				if 5 < p then
					p2 = 1 - (p - 5)
				end
				if 1 < p then
					p = 1
				end
				local x, y, z = getComponentPosition(partAnimation[1], "engine")
				local rx, ry, rz = getElementRotation(partAnimation[1])
				for i in pairs(engineParts) do
					setElementPosition(engineParts[i], x, y, z - 0.35)
					setElementRotation(engineParts[i], rx, ry, rz)
				end
				if oilObject then
					local gz = getGroundPosition(x, y, z - 0.5)
					setElementPosition(oilObject, x, y, gz)
					setElementRotation(oilObject, 0, 0, rz)
				end
				z = z - 0.35 - 0.3 + 0.1
				if p2 < 0 then
					p2 = 0
					local fn = partAnimation[7]
					partAnimation = false
					if fn then
						fn()
					end
				elseif oilTexture then
					dxDrawMaterialSectionLine3D(x, y, z - 0.075 - 3.2 * (1 - p2), x, y, z - 0.075 - 3.2 * p, 0, 2048 * (1 - p2), 64, 2048 * p * p2, oilTexture, 0.1)
				end
			else
				local progress = (now - partAnimation[3]) / 650
				local prog2 = 0
				if 1 < progress then
					if partAnimation[2] == "frontBumper" then
						setVehiclePanelState(partAnimation[1], 5, 0)
					elseif partAnimation[2] == "rearBumper" then
						setVehiclePanelState(partAnimation[1], 6, 0)
					elseif partAnimation[2] == "hood" then
						setVehicleDoorState(partAnimation[1], 0, 0)
						setVehicleDoorOpenRatio(partAnimation[1], 0, 1)
					elseif partAnimation[2] == "trunk" then
						setVehicleDoorState(partAnimation[1], 1, 0)
						setVehicleDoorOpenRatio(partAnimation[1], 1, 1)
					elseif partAnimation[2] == "frontLeftDoor" then
						setVehicleDoorState(partAnimation[1], 2, 0)
						setVehicleDoorOpenRatio(partAnimation[1], 2, 1)
					elseif partAnimation[2] == "frontRightDoor" then
						setVehicleDoorState(partAnimation[1], 3, 0)
						setVehicleDoorOpenRatio(partAnimation[1], 3, 1)
					elseif partAnimation[2] == "rearLeftDoor" then
						setVehicleDoorState(partAnimation[1], 4, 0)
						setVehicleDoorOpenRatio(partAnimation[1], 4, 1)
					elseif partAnimation[2] == "rearRightDoor" then
						setVehicleDoorState(partAnimation[1], 5, 0)
						setVehicleDoorOpenRatio(partAnimation[1], 5, 1)
					end
					if partAnimation[2] == "valveoff" or partAnimation[2] == "valveon" or partAnimation[2] == "headgasketoff" or partAnimation[2] == "headgasketon" or partAnimation[2] == "sumpoff" or partAnimation[2] == "sumpon" or partAnimation[2] == "headoff" or partAnimation[2] == "headon" or partAnimation[2] == "timingoff" or partAnimation[2] == "timingon" or partAnimation[2] == "brake1off" or partAnimation[2] == "brake2off" or partAnimation[2] == "brake3off" or partAnimation[2] == "brake4off" or partAnimation[2] == "brake1on" or partAnimation[2] == "brake2on" or partAnimation[2] == "brake3on" or partAnimation[2] == "brake4on" then
						prog2 = progress - 1
						progress = 1
					else
						if not partAnimation[8] then
							partAnimation[8] = true
						end
						progress = 2 - progress
					end
				end
				local x, y, z = partAnimation[4], partAnimation[5], partAnimation[6]
				local endAnim = false
				if progress < 0 then
					progress = 0
					endAnim = true
				end
				if partAnimation[2] == "frontBumper" then
					setVehicleComponentPosition(partAnimation[1], "bump_front_dummy", x, y + 1 * progress, z)
				elseif partAnimation[2] == "rearBumper" then
					setVehicleComponentPosition(partAnimation[1], "bump_rear_dummy", x, y - 1 * progress, z)
				elseif partAnimation[2] == "hood" then
					setVehicleComponentPosition(partAnimation[1], "bonnet_dummy", x, y, z + 1 * progress)
				elseif partAnimation[2] == "trunk" then
					setVehicleComponentPosition(partAnimation[1], "boot_dummy", x, y, z + 1 * progress)
				elseif partAnimation[2] == "frontLeftDoor" then
					setVehicleComponentPosition(partAnimation[1], "door_lf_dummy", x - 1 * progress, y, z)
				elseif partAnimation[2] == "frontRightDoor" then
					setVehicleComponentPosition(partAnimation[1], "door_rf_dummy", x + 1 * progress, y, z)
				elseif partAnimation[2] == "rearLeftDoor" then
					setVehicleComponentPosition(partAnimation[1], "door_lr_dummy", x - 1 * progress, y, z)
				elseif partAnimation[2] == "rearRightDoor" then
					setVehicleComponentPosition(partAnimation[1], "door_rr_dummy", x + 1 * progress, y, z)
				elseif partAnimation[2] == "suspension1" or partAnimation[2] == "suspension2" or partAnimation[2] == "suspension3" or partAnimation[2] == "suspension4" then
					local id = false
					if partAnimation[2] == "suspension1" then
						id = "suspension_fl"
					elseif partAnimation[2] == "suspension2" then
						id = "suspension_fr"
					elseif partAnimation[2] == "suspension3" then
						id = "suspension_rl"
					elseif partAnimation[2] == "suspension4" then
						id = "suspension_rr"
					end
					if isElement(vehicleObjects[id]) then
						setElementPosition(vehicleObjects[id], x, y, z - 1 * progress)
					end
				elseif partAnimation[2] == "headoff" then
					local x, y, z = getComponentPosition(partAnimation[1], "engine")
					z = z - 0.35
					local rx, ry, rz = getElementRotation(partAnimation[1])
					for i in pairs(engineParts) do
						setElementPosition(engineParts[i], x, y, z)
						setElementRotation(engineParts[i], rx, ry, rz)
					end
					setElementPosition(engineParts.cylinder_head, x, y, z + 1 * progress)
					setElementRotation(engineParts.cylinder_head, rx, ry, rz)
					if 1 <= progress then
						local fn = partAnimation[7]
						partAnimation = false
						if fn then
							fn()
						end
					end
				elseif partAnimation[2] == "headon" then
					local x, y, z = getComponentPosition(partAnimation[1], "engine")
					z = z - 0.35
					local rx, ry, rz = getElementRotation(partAnimation[1])
					for i in pairs(engineParts) do
						setElementPosition(engineParts[i], x, y, z)
						setElementRotation(engineParts[i], rx, ry, rz)
					end
					setElementPosition(engineParts.cylinder_head, x, y, z + 1 * (1 - progress))
					setElementRotation(engineParts.cylinder_head, rx, ry, rz)
					if 1 <= progress then
						local fn = partAnimation[7]
						partAnimation = false
						if fn then
							fn()
						end
					end
				elseif partAnimation[2] == "headgasket" then
					local x, y, z = getComponentPosition(partAnimation[1], "engine")
					z = z - 0.35
					local rx, ry, rz = getElementRotation(partAnimation[1])
					for i in pairs(engineParts) do
						setElementPosition(engineParts[i], x, y, z)
						setElementRotation(engineParts[i], rx, ry, rz)
					end
					setElementPosition(engineParts.gasket, x, y, z + 1 * progress)
					setElementRotation(engineParts.gasket, rx, ry, rz)
				elseif partAnimation[2] == "headgasketoff" then
					local x, y, z = getComponentPosition(partAnimation[1], "engine")
					z = z - 0.35
					local rx, ry, rz = getElementRotation(partAnimation[1])
					for i in pairs(engineParts) do
						setElementPosition(engineParts[i], x, y, z)
						setElementRotation(engineParts[i], rx, ry, rz)
					end
					setElementPosition(engineParts.gasket, x, y, z + 1 * progress)
					setElementRotation(engineParts.gasket, rx, ry, rz)
					if 1 <= progress then
						local fn = partAnimation[7]
						partAnimation = false
						if fn then
							fn()
						end
					end
				elseif partAnimation[2] == "headgasketon" then
					local x, y, z = getComponentPosition(partAnimation[1], "engine")
					z = z - 0.35
					local rx, ry, rz = getElementRotation(partAnimation[1])
					for i in pairs(engineParts) do
						setElementPosition(engineParts[i], x, y, z)
						setElementRotation(engineParts[i], rx, ry, rz)
					end
					setElementPosition(engineParts.gasket, x, y, z + 1 * (1 - progress))
					setElementRotation(engineParts.gasket, rx, ry, rz)
					if 1 <= progress then
						local fn = partAnimation[7]
						partAnimation = false
						if fn then
							fn()
						end
					end
				elseif partAnimation[2] == "battery" then
					local x, y, z = getComponentPosition(partAnimation[1], "engine")
					z = z - 0.35
					local rx, ry, rz = getElementRotation(partAnimation[1])
					for i in pairs(engineParts) do
						setElementPosition(engineParts[i], x, y, z)
						setElementRotation(engineParts[i], rx, ry, rz)
					end
					setElementPosition(engineParts.car_battery, x, y, z + 1 * progress)
					setElementRotation(engineParts.car_battery, rx, ry, rz)
				elseif partAnimation[2] == "piston" then
					local x, y, z = getComponentPosition(partAnimation[1], "engine")
					z = z - 0.35
					local rx, ry, rz = getElementRotation(partAnimation[1])
					for i in pairs(engineParts) do
						setElementPosition(engineParts[i], x, y, z)
						setElementRotation(engineParts[i], rx, ry, rz)
					end
					setElementPosition(engineParts.pistons, x, y, z + 1 * progress)
					setElementRotation(engineParts.pistons, rx, ry, rz)
				elseif partAnimation[2] == "valveoff" then
					local x, y, z = getComponentPosition(partAnimation[1], "engine")
					z = z - 0.35
					local rx, ry, rz = getElementRotation(partAnimation[1])
					for i in pairs(engineParts) do
						setElementPosition(engineParts[i], x, y, z)
						setElementRotation(engineParts[i], rx, ry, rz)
					end
					setElementPosition(engineParts.valve_cover, x, y, z + 1 * progress)
					setElementPosition(engineParts.valve_gasket, x, y, z + 1 * prog2)
					setElementRotation(engineParts.valve_cover, rx, ry, rz)
					setElementRotation(engineParts.valve_gasket, rx, ry, rz)
					if 1 <= prog2 then
						local fn = partAnimation[7]
						partAnimation = false
						if fn then
							fn()
						end
					end
				elseif partAnimation[2] == "valveon" then
					local x, y, z = getComponentPosition(partAnimation[1], "engine")
					z = z - 0.35
					local rx, ry, rz = getElementRotation(partAnimation[1])
					for i in pairs(engineParts) do
						setElementPosition(engineParts[i], x, y, z)
						setElementRotation(engineParts[i], rx, ry, rz)
					end
					setElementPosition(engineParts.valve_cover, x, y, z + 1 * (1 - prog2))
					setElementPosition(engineParts.valve_gasket, x, y, z + 1 * (1 - progress))
					setElementRotation(engineParts.valve_cover, rx, ry, rz)
					setElementRotation(engineParts.valve_gasket, rx, ry, rz)
					if 1 <= prog2 then
						local fn = partAnimation[7]
						partAnimation = false
						if fn then
							fn()
						end
					end
				elseif partAnimation[2] == "timingon" then
					local x, y, z = getComponentPosition(partAnimation[1], "engine")
					z = z - 0.35
					local rx, ry, rz = getElementRotation(partAnimation[1])
					for i in pairs(engineParts) do
						setElementPosition(engineParts[i], x, y, z)
						setElementRotation(engineParts[i], rx, ry, rz)
					end
					local rad = math.rad(rz)
					setElementPosition(engineParts.timing_belt, x + math.cos(rad) * 1 * (1 - progress), y + math.sin(rad) * 1 * (1 - progress), z)
					setElementRotation(engineParts.timing_belt, rx, ry, rz)
					if 1 <= progress then
						local fn = partAnimation[7]
						partAnimation = false
						if fn then
							fn()
						end
					end
				elseif partAnimation[2] == "timingoff" then
					local x, y, z = getComponentPosition(partAnimation[1], "engine")
					z = z - 0.35
					local rx, ry, rz = getElementRotation(partAnimation[1])
					for i in pairs(engineParts) do
						setElementPosition(engineParts[i], x, y, z)
						setElementRotation(engineParts[i], rx, ry, rz)
					end
					local rad = math.rad(rz)
					setElementPosition(engineParts.timing_belt, x + math.cos(rad) * 1 * progress, y + math.sin(rad) * 1 * progress, z)
					setElementRotation(engineParts.timing_belt, rx, ry, rz)
					if 1 <= progress then
						local fn = partAnimation[7]
						partAnimation = false
						if fn then
							fn()
						end
					end
				elseif partAnimation[2] == "timing" then
					local x, y, z = getComponentPosition(partAnimation[1], "engine")
					z = z - 0.35
					local rx, ry, rz = getElementRotation(partAnimation[1])
					for i in pairs(engineParts) do
						setElementPosition(engineParts[i], x, y, z)
						setElementRotation(engineParts[i], rx, ry, rz)
					end
					local rad = math.rad(rz)
					setElementPosition(engineParts.timing_belt, x + math.cos(rad) * 1 * progress, y + math.sin(rad) * 1 * progress, z)
					setElementRotation(engineParts.timing_belt, rx, ry, rz)
				elseif partAnimation[2] == "sumpoff" then
					local x, y, z = getComponentPosition(partAnimation[1], "engine")
					z = z - 0.35
					local rx, ry, rz = getElementRotation(partAnimation[1])
					for i in pairs(engineParts) do
						setElementPosition(engineParts[i], x, y, z)
						setElementRotation(engineParts[i], rx, ry, rz)
					end
					setElementPosition(engineParts.oil_sump, x, y, z - 1 * progress)
					setElementPosition(engineParts.oil_gasket, x, y, z - 1 * prog2)
					setElementRotation(engineParts.oil_sump, rx, ry, rz)
					setElementRotation(engineParts.oil_gasket, rx, ry, rz)
					if 1 <= prog2 then
						local fn = partAnimation[7]
						partAnimation = false
						if fn then
							fn()
						end
					end
				elseif partAnimation[2] == "sumpon" then
					local x, y, z = getComponentPosition(partAnimation[1], "engine")
					z = z - 0.35
					local rx, ry, rz = getElementRotation(partAnimation[1])
					for i in pairs(engineParts) do
						setElementPosition(engineParts[i], x, y, z)
						setElementRotation(engineParts[i], rx, ry, rz)
					end
					setElementPosition(engineParts.oil_sump, x, y, z - 1 * (1 - prog2))
					setElementPosition(engineParts.oil_gasket, x, y, z - 1 * (1 - progress))
					setElementRotation(engineParts.oil_sump, rx, ry, rz)
					setElementRotation(engineParts.oil_gasket, rx, ry, rz)
					if 1 <= prog2 then
						local fn = partAnimation[7]
						partAnimation = false
						if fn then
							fn()
						end
					end
				elseif partAnimation[2] == "brake1" or partAnimation[2] == "brake2" or partAnimation[2] == "brake3" or partAnimation[2] == "brake4" then
					local rx, ry, rz = getElementRotation(partAnimation[1])
					local rad = math.rad(rz)
					if partAnimation[2] == "brake1" or partAnimation[2] == "brake3" then
						rad = rad + math.pi
					end
					local id = false
					if partAnimation[2] == "brake1" then
						id = "brake_fl"
					elseif partAnimation[2] == "brake2" then
						id = "brake_fr"
					elseif partAnimation[2] == "brake3" then
						id = "brake_rl"
					elseif partAnimation[2] == "brake4" then
						id = "brake_rr"
					end
					if isElement(vehicleObjects[id]) then
						setElementPosition(vehicleObjects[id], x + math.cos(rad) * 1 * progress, y + math.sin(rad) * 1 * progress, z)
					end
				elseif partAnimation[2] == "brake1off" or partAnimation[2] == "brake2off" or partAnimation[2] == "brake3off" or partAnimation[2] == "brake4off" then
					local rx, ry, rz = getElementRotation(partAnimation[1])
					local rad = math.rad(rz)
					if partAnimation[2] == "brake1off" or partAnimation[2] == "brake3off" then
						rad = rad + math.pi
					end
					local id = false
					if partAnimation[2] == "brake1off" then
						id = "brake_fl"
					elseif partAnimation[2] == "brake2off" then
						id = "brake_fr"
					elseif partAnimation[2] == "brake3off" then
						id = "brake_rl"
					elseif partAnimation[2] == "brake4off" then
						id = "brake_rr"
					end
					if isElement(vehicleObjects[id]) then
						setElementPosition(vehicleObjects[id], x + math.cos(rad) * 1 * progress, y + math.sin(rad) * 1 * progress, z)
					end
					if 1 <= progress then
						local fn = partAnimation[7]
						partAnimation = false
						if fn then
							fn()
						end
					end
				elseif partAnimation[2] == "brake1on" or partAnimation[2] == "brake2on" or partAnimation[2] == "brake3on" or partAnimation[2] == "brake4on" then
					local rx, ry, rz = getElementRotation(partAnimation[1])
					local rad = math.rad(rz)
					if partAnimation[2] == "brake1on" or partAnimation[2] == "brake3on" then
						rad = rad + math.pi
					end
					local id = false
					if partAnimation[2] == "brake1on" then
						id = "brake_fl"
					elseif partAnimation[2] == "brake2on" then
						id = "brake_fr"
					elseif partAnimation[2] == "brake3on" then
						id = "brake_rl"
					elseif partAnimation[2] == "brake4on" then
						id = "brake_rr"
					end
					if isElement(vehicleObjects[id]) then
						setElementPosition(vehicleObjects[id], x + math.cos(rad) * 1 * (1 - progress), y + math.sin(rad) * 1 * (1 - progress), z)
					end
					if 1 <= progress then
						local fn = partAnimation[7]
						partAnimation = false
						if fn then
							fn()
						end
					end
				end
				if endAnim then
					if partAnimation[2] == "frontBumper" then
						resetVehicleComponentPosition(partAnimation[1], "bump_front_dummy")
					elseif partAnimation[2] == "rearBumper" then
						resetVehicleComponentPosition(partAnimation[1], "bump_rear_dummy")
					elseif partAnimation[2] == "hood" then
						resetVehicleComponentPosition(partAnimation[1], "bonnet_dummy")
					elseif partAnimation[2] == "trunk" then
						resetVehicleComponentPosition(partAnimation[1], "boot_dummy")
					elseif partAnimation[2] == "frontLeftDoor" then
						resetVehicleComponentPosition(partAnimation[1], "door_lf_dummy")
					elseif partAnimation[2] == "frontRightDoor" then
						resetVehicleComponentPosition(partAnimation[1], "door_rf_dummy")
					elseif partAnimation[2] == "rearLeftDoor" then
						resetVehicleComponentPosition(partAnimation[1], "door_lr_dummy")
					elseif partAnimation[2] == "rearRightDoor" then
						resetVehicleComponentPosition(partAnimation[1], "door_rr_dummy")
					end
					local fn = partAnimation[7]
					partAnimation = false
					if fn then
						fn()
					end
				end
			end
		else
			partAnimation = false
		end
	end
end
function mechanicRender()
	matrixCache = {}
	local now = getTickCount()
	delta = now - lastDeltaTime
	lastDeltaTime = now
	mechanicRTRender()
	if endJobVeh and not isElement(endJobVeh) then
		deleteCarEndWindow()
	end
	local tmpClick = false
	local wrenchCursor = false
	local players = getElementsByType("player", getRootElement(), true)
	for i = #krutonPrints, 1, -1 do
		if krutonPrints[i] then
			local id = krutonPrints[i][1]
			local x = workshops[currentWorkshop][6][id][1]
			local y = workshops[currentWorkshop][6][id][2]
			local z = workshops[currentWorkshop][6][id][3]
			local rz = math.rad(workshops[currentWorkshop][6][id][4]) + 1.5707963267948966
			sightlangStaticImageUsed[7] = true
			if sightlangStaticImageToc[7] then
				processsightlangStaticImage[7]()
			end
			dxDrawMaterialLine3D(x + math.cos(rz) * -0.2675, y + math.sin(rz) * -0.2675, z + 1.075, x + math.cos(rz) * -0.2675, y + math.sin(rz) * -0.2675, z + 0.475, sightlangStaticImage[7], 0.925, tocolor(255, 255, 255), false, x + math.cos(rz), y + math.sin(rz), z + 1)
			local p = (now - krutonPrints[i][3]) / 4800
			if 1 < p then
				krutonPrints[i][3] = getTickCount()
				krutonPrints[i][2] = krutonPrints[i][2] - 1
				if krutonPrints[i][2] < 0 then
					if isElement(krutonPrints[i][4]) then
						destroyElement(krutonPrints[i][4])
					end
					table.remove(krutonPrints, i)
				else
					playSound3D("files/printer.mp3", x, y, z)
				end
			else
				p = math.min(1, p / 0.9)
				if p % 0.075 < 0.0375 then
					local f = math.floor(p / 0.075) * 0.075
					p = f + (p - f) * 2
				else
					p = math.ceil(p / 0.075) * 0.075
				end
				local x = x + math.cos(rz) * (0.25 - 0.3 * (1 - p))
				local y = y + math.sin(rz) * (0.25 - 0.3 * (1 - p))
				local z = z - 0.4 + 0.025 * (1 - p)
				setElementPosition(krutonPrints[i][4], x, y, z)
			end
		else
			table.remove(krutonPrints, i)
		end
	end
	for i = 1, #lifts do
		if liftSounds[i] then
			if isElement(liftSounds[i][1]) then
				local delta = getSoundPosition(liftSounds[i][1]) * 1000
				if liftStates[i] then
					if 1110 < delta then
						setSoundPosition(liftSounds[i][1], 0.638 + (delta - 1100) % 1100 / 1000)
					end
					if 638 < delta and now - (lastClick[i] or 0) > 2500 then
						lastClick[i] = now
						local sound = playSound3D("files/lift2.mp3", liftSounds[i][2], liftSounds[i][3], liftSounds[i][4], false)
						setSoundVolume(sound, 0.75)
					end
				else
					if delta < 1100 then
						setSoundPosition(liftSounds[i][1], 1.1 + (delta - 638) / 1000)
					end
					if 2092 < delta then
						destroyElement(liftSounds[i][1])
						liftSounds[i] = nil
					end
				end
			else
				liftSounds[i] = nil
			end
		end
	end
	for i = 1, #players do
		local mouse = gunStates[players[i]]
		if mouse and not isElement(sounds[players[i]]) then
			local x, y, z = getElementPosition(localPlayer)
			sounds[players[i]] = playSound3D("files/wrench.mp3", x, y, z, true)
			attachElements(sounds[players[i]], players[i])
		end
		if sounds[players[i]] then
			local delta = getSoundPosition(sounds[players[i]]) * 1000
			if mouse then
				if 730 < delta then
					setSoundPosition(sounds[players[i]], 0)
				elseif 430 < delta then
					setSoundPosition(sounds[players[i]], 0.13 + (delta - 430) % 430 / 1000)
				end
			else
				if delta < 430 then
					setSoundPosition(sounds[players[i]], 0.43 + (delta - 130) % 430 / 1000)
				end
				if 1120 < delta then
					if isElement(sounds[players[i]]) then
						destroyElement(sounds[players[i]])
					end
					sounds[players[i]] = false
				end
			end
		end
	end
	partAnimationHandler(now, delta)
	local cx, cy = getCursorPosition()
	if cx then
		cx = cx * screenX
		cy = cy * screenY
	else
		cx = -9999
		cy = -9999
	end
	local vehicles = getElementsByType("vehicle", getRootElement(), true)
	local px, py, pz = getElementPosition(localPlayer)
	local minD = 7.5
	local tmp = false
	for i = 1, #vehicles do
		local veh = vehicles[i]
		if getVehicleType(veh) == "Automobile" then
			if not vehDbIdCache[veh] then
				vehDbIdCache[veh] = getElementData(veh, "vehicle.dbID") or 0
			elseif 0 < vehDbIdCache[veh] then
				local x, y, z = getElementPosition(veh)
				local d = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
				if minD > d then
					minD = d
					tmp = veh
				end
				if wheelsOff[veh] and wheelOffInterpolation[veh] then
					for j = 1, 4 do
						if wheelOffInterpolation[veh] and wheelOffInterpolation[veh][j] then
							local comp = false
							local dx = 0
							if j == 1 then
								comp = "wheel_lf_dummy"
								dx = -0.25
							elseif j == 2 then
								comp = "wheel_rf_dummy"
								dx = 0.25
							elseif j == 3 then
								comp = "wheel_lb_dummy"
								dx = -0.25
							elseif j == 4 then
								comp = "wheel_rb_dummy"
								dx = 0.25
							end
							local p = (now - wheelOffInterpolation[veh][j][1]) / 500
							if 1 < p then
								p = 1
							end
							local x, y, z = wheelOffInterpolation[veh][j][2], wheelOffInterpolation[veh][j][3], wheelOffInterpolation[veh][j][4]
							if wheelsOff[veh][j] then
								setVehicleComponentPosition(veh, comp, x + dx * p, y, z, "root")
							else
								setVehicleComponentPosition(veh, comp, x + dx * (1 - p), y, z, "root")
							end
							if 1 <= p then
								resetVehicleComponentPosition(veh, comp)
								setVehicleComponentVisible(veh, comp, not wheelsOff[veh][j])
								wheelOffInterpolation[veh][j] = nil
							end
						end
					end
				end
			end
		end
	end
	if tmp ~= closestVeh then
		if repairingPart then
			if repairingPart[1] == tmp then
				closestVeh = tmp
			else
				closestVeh = false
			end
		else
			screwingWheel = false
			screwMinigame = false
			resetWheelsOff(closestVeh)
			if isElement(oilObject) then
				destroyElement(oilObject)
			end
			oilObject = false
			if isElement(oilTexture) then
				destroyElement(oilTexture)
			end
			oilTexture = false
			if isElement(closestVeh) then
				setElementAlpha(closestVeh, 255)
				resetVehicleComponentPosition(closestVeh, {
					"bump_front_dummy",
					"bump_rear_dummy",
					"bonnet_dummy",
					"boot_dummy",
					"door_lf_dummy",
					"door_rf_dummy",
					"door_lr_dummy",
					"door_rr_dummy"
				})
			end
			partAnimation = false
			closestVeh = tmp
			originalState = {}
			if closestVeh and not carPartSwap[closestVeh] then
				carPartSwap[closestVeh] = {}
			end
			unlistedParts = false
			if not closestVeh then
				deleteCarWindow()
			end
			sendingOffer = false
			createVehicleObjects(closestVeh)
			createMinigameObj(false)
			if isElement(closestVeh) and spectatorStates[closestVeh] then
				local name = spectatorStates[closestVeh][1]
				local state = spectatorStates[closestVeh][2]
				local screw = spectatorStates[closestVeh][3]
				local arg = spectatorStates[closestVeh][4]
				if spectatorFunctions[name] and spectatorFunctions[name][state] then
					for i = 1, state do
						spectatorFunctions[name][i](arg)
					end
					if screwMinigame and screw and #screw == #screwMinigame[6] then
						screwMinigame[6] = screw
						screwMinigame[7] = screw
					end
				end
			end
		end
	end
	local tmpTooltip = false
	hoveredPart = false
	hoveredWheel = false
	if currentWorkshopPerm and not krutonWindow then
		for i = 1, #workshops[currentWorkshop][6] - 2 do
			local x, y, z = workshops[currentWorkshop][6][i][1], workshops[currentWorkshop][6][i][2], workshops[currentWorkshop][6][i][3]
			if 2 > getDistanceBetweenPoints3D(x, y, z, px, py, pz) then
				local x, y = getScreenFromWorldPosition(x, y, z + 0.5, 48)
				if x then
					dxDrawRectangle(x - 26, y - 26, 52, 52, tocolor(grey1[1], grey1[2], grey1[3]))
					if not hoveredPart and cx and cx <= x + 26 and cx >= x - 26 and cy >= y - 26 and cy <= y + 26 then
						sightlangStaticImageUsed[8] = true
						if sightlangStaticImageToc[8] then
							processsightlangStaticImage[8]()
						end
						dxDrawImage(x - 24, y - 24, 48, 48, sightlangStaticImage[8], 0, 0, 0, tocolor(green[1], green[2], green[3]))
						tmpTooltip = "Kruton-terminál használata"
						hoveredWheel = i
						hoveredPart = "kruton"
					else
						sightlangStaticImageUsed[8] = true
						if sightlangStaticImageToc[8] then
							processsightlangStaticImage[8]()
						end
						dxDrawImage(x - 24, y - 24, 48, 48, sightlangStaticImage[8])
					end
				end
			end
		end
	end
	local tmpUnlisted = {}
	closestOnGround = true
	if closestVeh then
		closestOnGround = isVehicleWheelOnGround(closestVeh, 0)
		local hoodX, hoodY, hoodZ = getVehicleComponentPosition(closestVeh, "bonnet_dummy", "world")
		if not hoodZ then
			hoodX, hoodY, hoodZ = getComponentPosition(closestVeh, "engine")
		end
		hoodZ = hoodZ or z + 0.35
		hoodZ = hoodZ - 0.1
		if not partAnimation then
			processVehicleObjects(hoodX, hoodY, hoodZ)
		end
		if screwMinigame then
			if isElement(screwMinigame[1]) then
				if closestVeh == screwMinigame[1] then
					local screwSpeedup = 2
					local p = screwP
					local comp = false
					local id = 0
					if screwMinigame[2] == "wheel_1" or screwMinigame[2] == "brake_1" or screwMinigame[2] == "suspension_1" then
						comp = "wheel_lf_dummy"
						id = 1
					elseif screwMinigame[2] == "wheel_2" or screwMinigame[2] == "brake_2" or screwMinigame[2] == "suspension_2" then
						comp = "wheel_rf_dummy"
						id = 2
					elseif screwMinigame[2] == "wheel_3" or screwMinigame[2] == "brake_3" or screwMinigame[2] == "suspension_3" then
						comp = "wheel_lb_dummy"
						id = 3
					elseif screwMinigame[2] == "wheel_4" or screwMinigame[2] == "brake_4" or screwMinigame[2] == "suspension_4" then
						comp = "wheel_rb_dummy"
						id = 4
					elseif screwMinigame[2] == "frontBumper" then
						comp = "bump_front_dummy"
					elseif screwMinigame[2] == "rearBumper" then
						comp = "bump_rear_dummy"
					elseif screwMinigame[2] == "hood" then
						comp = "bonnet_dummy"
					elseif screwMinigame[2] == "trunk" then
						comp = "boot_dummy"
					elseif screwMinigame[2] == "frontLeftDoor" then
						comp = "door_lf_dummy"
					elseif screwMinigame[2] == "frontRightDoor" then
						comp = "door_rf_dummy"
					elseif screwMinigame[2] == "rearLeftDoor" then
						comp = "door_lr_dummy"
					elseif screwMinigame[2] == "rearRightDoor" then
						comp = "door_rr_dummy"
					elseif screwMinigame[2] == "frontLeftLight" then
						comp = "headlights_left"
					elseif screwMinigame[2] == "frontRightLight" then
						comp = "headlights_right"
					elseif screwMinigame[2] == "rearLeftLight" then
						comp = "taillights_left"
					elseif screwMinigame[2] == "rearRightLight" then
						comp = "taillights_right"
					elseif screwMinigame[2] == "oil1" or screwMinigame[2] == "oil2" or screwMinigame[2] == "valve" or screwMinigame[2] == "battery" or screwMinigame[2] == "piston" or screwMinigame[2] == "head" or screwMinigame[2] == "timing" or screwMinigame[2] == "sump" then
						comp = "engine"
					end
					if comp then
						local x, y, z, rx, ry, rz
						if comp == "headlights_left" or comp == "headlights_right" or comp == "taillights_left" or comp == "taillights_right" or comp == "engine" then
							x, y, z = getComponentPosition(closestVeh, comp)
							rx, ry, rz = getElementRotation(closestVeh)
						else
							x, y, z = getVehicleComponentPosition(closestVeh, comp, "world")
							rx, ry, rz = getVehicleComponentRotation(closestVeh, comp, "world")
						end
						local rad = math.rad(rz)
						local n = 0
						local sump = 0
						local suma = 0
						local cancelWheel1 = false
						local cancelWheel2 = false
						local cancelWheel3 = false
						local click = getKeyState("mouse1")
						if screwMinigame[2] == "battery" then
							n = 2
							z = z - 0.35
							for i = 1, n do
								local hexSize = 8
								local legSize = 0.75
								local s = 0.0026666666666666666 * hexSize
								local p = screwMinigame[6][i]
								sump = sump + p
								if p <= 0 and screwMinigame[5] then
									if screwMinigame[7][i] > 0 then
										screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
										if screwMinigame[7][i] < 0 then
											screwMinigame[7][i] = 0
										end
									end
								elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
									screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
									if 1 < screwMinigame[7][i] then
										screwMinigame[7][i] = 1
									end
								end
								if not repairingPart and not screwingWheel then
									p = 1
								end
								local a = screwMinigame[7][i]
								suma = suma + a
								local draw = false
								local xp = math.cos(rad) * (-0.16 - 0.2 * (i - 1)) + math.cos(rad + 1.5707963267948966) * -0.243
								local yp = math.sin(rad) * (-0.16 - 0.2 * (i - 1)) + math.sin(rad + 1.5707963267948966) * -0.243
								local zp = 0.54216
								draw = drawScrew(x + xp - math.cos(rad + 3.141592653589793 * (i - 1)) * s * legSize * (-1 + p - (1 - a)), y + yp - math.sin(rad + 3.141592653589793 * (i - 1)) * s * legSize * (-1 + p - (1 - a)), z + zp, rad - 1.5707963267948966 + 3.141592653589793 * (i - 1), math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, legSize)
								if draw then
									tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
									wrenchCursor = true
									if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
										click = false
										tmpClick = draw
										screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
										if screwMinigame[6][i] <= 0 then
											screwMinigame[6][i] = 0
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
										if 1 <= screwMinigame[6][i] then
											screwMinigame[6][i] = 1
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
									end
								end
							end
							setVehicleDoorOpenRatio(closestVeh, 0, 1)
							setElementAlpha(closestVeh, 102)
							for i in pairs(engineParts) do
								setElementPosition(engineParts[i], x, y, z)
								setElementRotation(engineParts[i], rx, ry, rz)
							end
						elseif screwMinigame[2] == "piston" then
							n = 8
							z = z - 0.35
							for i = 1, n do
								local hexSize = 10
								local legSize = 0.75
								local s = 0.0026666666666666666 * hexSize
								local p = screwMinigame[6][i]
								sump = sump + p
								if p <= 0 and screwMinigame[5] then
									if screwMinigame[7][i] > 0 then
										screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
										if screwMinigame[7][i] < 0 then
											screwMinigame[7][i] = 0
										end
									end
								elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
									screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
									if 1 < screwMinigame[7][i] then
										screwMinigame[7][i] = 1
									end
								end
								if not repairingPart and not screwingWheel then
									p = 1
								end
								local a = screwMinigame[7][i]
								suma = suma + a
								local draw = false
								local xp = math.cos(rad + 1.5707963267948966) * (-0.043 + 0.068 * math.floor((i - 1) / 4)) + math.cos(rad) * (0.23 - 0.1715 * (i % 4))
								local yp = math.sin(rad + 1.5707963267948966) * (-0.043 + 0.068 * math.floor((i - 1) / 4)) + math.sin(rad) * (0.23 - 0.1715 * (i % 4))
								draw = drawScrewTop(x + xp, y + yp, z - 0.135 - s * legSize * 1 + s * legSize * (p - (1 - a)), math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, legSize)
								if draw then
									if closestOnGround then
										tmpTooltip = "Emeld fel az autót!"
									else
										tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
										wrenchCursor = true
										if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
											click = false
											tmpClick = draw
											screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
											if screwMinigame[6][i] <= 0 then
												screwMinigame[6][i] = 0
												tmpClick = false
												if repairingPart then
													triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
												end
											end
											if 1 <= screwMinigame[6][i] then
												screwMinigame[6][i] = 1
												tmpClick = false
												if repairingPart then
													triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
												end
											end
										end
									end
								end
							end
							setVehicleDoorOpenRatio(closestVeh, 0, 1)
							setElementAlpha(closestVeh, 102)
							for i in pairs(engineParts) do
								setElementPosition(engineParts[i], x, y, z)
								setElementRotation(engineParts[i], rx, ry, rz)
							end
						elseif screwMinigame[2] == "sump" then
							n = 14
							z = z - 0.35
							for i = 1, n do
								local hexSize = 8
								local legSize = 0.75
								local s = 0.0026666666666666666 * hexSize
								local p = screwMinigame[6][i]
								sump = sump + p
								if p <= 0 and screwMinigame[5] then
									if screwMinigame[7][i] > 0 then
										screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
										if screwMinigame[7][i] < 0 then
											screwMinigame[7][i] = 0
										end
									end
								elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
									screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
									if 1 < screwMinigame[7][i] then
										screwMinigame[7][i] = 1
									end
								end
								if not repairingPart and not screwingWheel then
									p = 1
								end
								local a = screwMinigame[7][i]
								suma = suma + a
								local draw = false
								local xp = 0
								local yp = 0
								if i <= 5 then
									xp = math.cos(rad) * (0.345 - (i - 1) % 5 * 0.175) + math.cos(rad + 1.5707963267948966) * -0.22
									yp = math.sin(rad) * (0.345 - (i - 1) % 5 * 0.175) + math.sin(rad + 1.5707963267948966) * -0.22
								elseif i <= 10 then
									xp = math.cos(rad) * (0.345 - (i - 1) % 5 * 0.175) + math.cos(rad + 1.5707963267948966) * 0.2
									yp = math.sin(rad) * (0.345 - (i - 1) % 5 * 0.175) + math.sin(rad + 1.5707963267948966) * 0.2
								else
									xp = math.cos(rad) * 0.345 + math.cos(rad + 1.5707963267948966) * (-0.22 + (i - 10) * 0.08)
									yp = math.sin(rad) * 0.345 + math.sin(rad + 1.5707963267948966) * (-0.22 + (i - 10) * 0.08)
								end
								draw = drawScrewTop(x + xp, y + yp, z - 0.12 - s * legSize * 1 + s * legSize * (p - (1 - a)), math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, legSize)
								if draw then
									if closestOnGround then
										tmpTooltip = "Emeld fel az autót!"
									else
										tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
										wrenchCursor = true
										if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
											click = false
											tmpClick = draw
											screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
											if screwMinigame[6][i] <= 0 then
												screwMinigame[6][i] = 0
												tmpClick = false
												if repairingPart then
													triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
												end
											end
											if 1 <= screwMinigame[6][i] then
												screwMinigame[6][i] = 1
												tmpClick = false
												if repairingPart then
													triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
												end
											end
										end
									end
								end
							end
							setVehicleDoorOpenRatio(closestVeh, 0, 1)
							setElementAlpha(closestVeh, 102)
							for i in pairs(engineParts) do
								setElementPosition(engineParts[i], x, y, z)
								setElementRotation(engineParts[i], rx, ry, rz)
							end
						elseif screwMinigame[2] == "timing" then
							n = 3
							z = z - 0.35
							for i = 1, n do
								local hexSize = 2 < i and 17 or 13
								local legSize = 1.65
								local s = 0.0026666666666666666 * hexSize
								local p = screwMinigame[6][i]
								sump = sump + p
								if p <= 0 and screwMinigame[5] then
									if screwMinigame[7][i] > 0 then
										screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
										if screwMinigame[7][i] < 0 then
											screwMinigame[7][i] = 0
										end
									end
								elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
									screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
									if 1 < screwMinigame[7][i] then
										screwMinigame[7][i] = 1
									end
								end
								if not repairingPart and not screwingWheel then
									p = 1
								end
								local a = screwMinigame[7][i]
								suma = suma + a
								local draw = false
								local xp = 0
								local yp = 0
								local zp = 0
								if i == 1 then
									xp = math.cos(rad - 1.5707963267948966) * -0.047839 + math.cos(rad) * 0.39
									yp = math.sin(rad - 1.5707963267948966) * -0.047839 + math.sin(rad) * 0.39
									zp = 0.395214
								elseif i == 2 then
									xp = math.cos(rad - 1.5707963267948966) * 0.065947 + math.cos(rad) * 0.39
									yp = math.sin(rad - 1.5707963267948966) * 0.065947 + math.sin(rad) * 0.39
									zp = 0.395214
								else
									xp = math.cos(rad - 1.5707963267948966) * 0.008628 + math.cos(rad) * 0.39
									yp = math.sin(rad - 1.5707963267948966) * 0.008628 + math.sin(rad) * 0.39
									zp = -0.050262
								end
								draw = drawScrew(x + xp - math.cos(rad) * s * legSize * (-1 + p - (1 - a)), y + yp - math.sin(rad) * s * legSize * (-1 + p - (1 - a)), z + zp, rad - 1.5707963267948966, math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, legSize)
								if draw then
									tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
									wrenchCursor = true
									if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
										click = false
										tmpClick = draw
										screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
										if screwMinigame[6][i] <= 0 then
											screwMinigame[6][i] = 0
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
										if 1 <= screwMinigame[6][i] then
											screwMinigame[6][i] = 1
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
									end
								end
							end
							setVehicleDoorOpenRatio(closestVeh, 0, 1)
							setElementAlpha(closestVeh, 102)
							for i in pairs(engineParts) do
								setElementPosition(engineParts[i], x, y, z)
								setElementRotation(engineParts[i], rx, ry, rz)
							end
						elseif screwMinigame[2] == "head" then
							n = 10
							z = z - 0.35
							for i = 1, n do
								local hexSize = 12
								local legSize = 5
								local s = 0.0026666666666666666 * hexSize
								local p = screwMinigame[6][i]
								sump = sump + p
								if p <= 0 and screwMinigame[5] then
									if screwMinigame[7][i] > 0 then
										screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
										if screwMinigame[7][i] < 0 then
											screwMinigame[7][i] = 0
										end
									end
								elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
									screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
									if 1 < screwMinigame[7][i] then
										screwMinigame[7][i] = 1
									end
								end
								if not repairingPart and not screwingWheel then
									p = 1
								end
								local a = screwMinigame[7][i]
								suma = suma + a
								local draw = false
								local xp = math.cos(rad) * (0.312273 - i % 5 * 0.15) + math.cos(rad + 1.5707963267948966) * (-0.02 - (math.floor((i - 1) / 5) - 1) * 0.04)
								local yp = math.sin(rad) * (0.312273 - i % 5 * 0.15) + math.sin(rad + 1.5707963267948966) * (-0.02 - (math.floor((i - 1) / 5) - 1) * 0.04)
								draw = drawScrewTop(x + xp, y + yp, z + 0.38 + s * legSize * 1 - s * legSize * (p - (1 - a)), math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, -legSize)
								if draw then
									tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
									wrenchCursor = true
									if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
										click = false
										tmpClick = draw
										screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup * 2
										if screwMinigame[6][i] <= 0 then
											screwMinigame[6][i] = 0
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
										if 1 <= screwMinigame[6][i] then
											screwMinigame[6][i] = 1
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
									end
								end
							end
							setVehicleDoorOpenRatio(closestVeh, 0, 1)
							setElementAlpha(closestVeh, 102)
							for i in pairs(engineParts) do
								setElementPosition(engineParts[i], x, y, z)
								setElementRotation(engineParts[i], rx, ry, rz)
							end
						elseif screwMinigame[2] == "valve" then
							n = 8
							z = z - 0.35
							for i = 1, n do
								local hexSize = 8
								local legSize = 1
								local s = 0.0026666666666666666 * hexSize
								local p = screwMinigame[6][i]
								sump = sump + p
								if p <= 0 and screwMinigame[5] then
									if screwMinigame[7][i] > 0 then
										screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
										if screwMinigame[7][i] < 0 then
											screwMinigame[7][i] = 0
										end
									end
								elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
									screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
									if 1 < screwMinigame[7][i] then
										screwMinigame[7][i] = 1
									end
								end
								if not repairingPart and not screwingWheel then
									p = 1
								end
								local a = screwMinigame[7][i]
								suma = suma + a
								local draw = false
								local xp = math.cos(rad) * (0.345 - i % 4 * 0.24) + math.cos(rad + 1.5707963267948966) * (-0.125 - (math.floor((i - 1) / 4) - 1) * 0.25)
								local yp = math.sin(rad) * (0.345 - i % 4 * 0.24) + math.sin(rad + 1.5707963267948966) * (-0.125 - (math.floor((i - 1) / 4) - 1) * 0.25)
								draw = drawScrewTop(x + xp, y + yp, z + 0.41 + s * legSize * 2 - s * legSize * (p - (1 - a)), math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, -legSize)
								if draw then
									tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
									wrenchCursor = true
									if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
										click = false
										tmpClick = draw
										screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
										if screwMinigame[6][i] <= 0 then
											screwMinigame[6][i] = 0
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
										if 1 <= screwMinigame[6][i] then
											screwMinigame[6][i] = 1
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
									end
								end
							end
							setVehicleDoorOpenRatio(closestVeh, 0, 1)
							setElementAlpha(closestVeh, 102)
							for i in pairs(engineParts) do
								setElementPosition(engineParts[i], x, y, z)
								setElementRotation(engineParts[i], rx, ry, rz)
							end
						elseif screwMinigame[2] == "oil2" then
							n = 1
							setVehicleDoorOpenRatio(closestVeh, 0, 1)
							z = z - 0.35
							for i in pairs(engineParts) do
								setElementPosition(engineParts[i], x, y, z)
								setElementRotation(engineParts[i], rx, ry, rz)
							end
							local i = 1
							local hexSize = 31
							local legSize = 0.3
							local s = 0.0026666666666666666 * hexSize
							local p = screwMinigame[6][i]
							sump = sump + p
							if p <= 0 and screwMinigame[5] then
								if screwMinigame[7][i] > 0 then
									screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
									if screwMinigame[7][i] < 0 then
										screwMinigame[7][i] = 0
									end
								end
							elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
								screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
								if 1 < screwMinigame[7][i] then
									screwMinigame[7][i] = 1
								end
							end
							if not repairingPart and not screwingWheel then
								p = 1
							end
							local a = screwMinigame[7][i]
							suma = suma + a
							local draw = false
							draw = drawScrewTop(x + math.cos(rad) * -0.185 + math.cos(rad + 1.5707963267948966) * 0.025, y + math.sin(rad) * -0.185 + math.sin(rad + 1.5707963267948966) * 0.025, z + 0.55 - s * legSize * (p - (1 - a)), math.rad(p * 180), s, cx, cy, a, hexSize, 0)
							if draw then
								tmpTooltip = "Olajbeöntő sapka"
								if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) then
									click = false
									screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
									if screwMinigame[6][i] <= 0 then
										screwMinigame[6][i] = 0
										if repairingPart then
											triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
										end
									end
									if 1 <= screwMinigame[6][i] then
										screwMinigame[6][i] = 1
										if repairingPart then
											triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
										end
									end
								end
							end
						elseif screwMinigame[2] == "oil1" then
							n = 1
							setElementAlpha(closestVeh, 102)
							z = z - 0.35
							for i in pairs(engineParts) do
								setElementPosition(engineParts[i], x, y, z)
								setElementRotation(engineParts[i], rx, ry, rz)
							end
							local i = 1
							local hexSize = 10
							local legSize = 1
							local s = 0.0026666666666666666 * hexSize
							local p = screwMinigame[6][i]
							sump = sump + p
							if p <= 0 and screwMinigame[5] then
								if screwMinigame[7][i] > 0 then
									screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
									if screwMinigame[7][i] < 0 then
										screwMinigame[7][i] = 0
									end
								end
							elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
								screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
								if 1 < screwMinigame[7][i] then
									screwMinigame[7][i] = 1
								end
							end
							if not repairingPart and not screwingWheel then
								p = 1
							end
							local a = screwMinigame[7][i]
							suma = suma + a
							local draw = false
							draw = drawScrewTop(x, y, z - 0.3 + s * legSize * (-1 + p - (1 - a)), math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, legSize)
							if draw then
								if closestOnGround then
									tmpTooltip = "Emeld fel az autót!"
								else
									tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
									wrenchCursor = true
									if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
										click = false
										tmpClick = draw
										screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
										if screwMinigame[6][i] <= 0 then
											screwMinigame[6][i] = 0
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
										if 1 <= screwMinigame[6][i] then
											screwMinigame[6][i] = 1
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
									end
								end
							end
						elseif screwMinigame[2] == "frontLeftLight" or screwMinigame[2] == "frontRightLight" or screwMinigame[2] == "rearLeftLight" or screwMinigame[2] == "rearRightLight" then
							n = 2
							for i = 1, 2 do
								local hexSize = 8
								local legSize = 1
								local s = 0.0026666666666666666 * hexSize
								local p = screwMinigame[6][i]
								sump = sump + p
								if p <= 0 and screwMinigame[5] then
									if screwMinigame[7][i] > 0 then
										screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
										if screwMinigame[7][i] < 0 then
											screwMinigame[7][i] = 0
										end
									end
								elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
									screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
									if 1 < screwMinigame[7][i] then
										screwMinigame[7][i] = 1
									end
								end
								if not repairingPart and not screwingWheel then
									p = 1
								end
								local a = screwMinigame[7][i]
								suma = suma + a
								local draw = false
								draw = drawScrewTop(x + math.cos(rad) * ((i - 1) * 0.2 - 0.1), y + math.sin(rad) * ((i - 1) * 0.2 - 0.1), z + s * legSize * 2 - s * legSize * (p - (1 - a)), math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, -legSize)
								if draw then
									tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
									wrenchCursor = true
									if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
										click = false
										tmpClick = draw
										screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
										if screwMinigame[6][i] <= 0 then
											screwMinigame[6][i] = 0
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
										if 1 <= screwMinigame[6][i] then
											screwMinigame[6][i] = 1
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
									end
								end
							end
						elseif screwMinigame[2] == "frontLeftDoor" or screwMinigame[2] == "frontRightDoor" or screwMinigame[2] == "rearLeftDoor" or screwMinigame[2] == "rearRightDoor" then
							n = 2
							if screwMinigame[2] == "frontLeftDoor" then
								setVehicleDoorOpenRatio(closestVeh, 2, 1)
							elseif screwMinigame[2] == "frontRightDoor" then
								setVehicleDoorOpenRatio(closestVeh, 3, 1)
							elseif screwMinigame[2] == "rearLeftDoor" then
								setVehicleDoorOpenRatio(closestVeh, 4, 1)
							elseif screwMinigame[2] == "rearRightDoor" then
								setVehicleDoorOpenRatio(closestVeh, 5, 1)
							end
							for i = 1, 2 do
								local hexSize = 15
								local legSize = 1
								local s = 0.0026666666666666666 * hexSize
								local p = screwMinigame[6][i]
								sump = sump + p
								if p <= 0 and screwMinigame[5] then
									if screwMinigame[7][i] > 0 then
										screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
										if screwMinigame[7][i] < 0 then
											screwMinigame[7][i] = 0
										end
									end
								elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
									screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
									if 1 < screwMinigame[7][i] then
										screwMinigame[7][i] = 1
									end
								end
								if not repairingPart and not screwingWheel then
									p = 1
								end
								local a = screwMinigame[7][i]
								suma = suma + a
								local draw = false
								if i == 1 then
									draw = drawScrewTop(x, y, z + s * legSize * 2 - s * legSize * (p - (1 - a)), math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, -legSize)
								else
									draw = drawScrewTop(x, y, z - s * legSize * 2 + s * legSize * (p - (1 - a)), math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, legSize)
								end
								if draw then
									tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
									wrenchCursor = true
									if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
										click = false
										tmpClick = draw
										screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
										if screwMinigame[6][i] <= 0 then
											screwMinigame[6][i] = 0
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
										if 1 <= screwMinigame[6][i] then
											screwMinigame[6][i] = 1
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
									end
								end
							end
						elseif screwMinigame[2] == "trunk" then
							n = 4
							local px, py, pz = getVehicleComponentPosition(closestVeh, comp, "root")
							local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(closestVeh)
							setVehicleDoorOpenRatio(closestVeh, 1, 1)
							for i = 1, 4 do
								local x, y, z = false, false, false
								if 2 < i then
									x, y, z = getPositionFromElementOffset(closestVeh, minX * 0.7, py - 0.1 * (i % 2), pz)
								else
									x, y, z = getPositionFromElementOffset(closestVeh, maxX * 0.7, py - 0.1 * (i % 2), pz)
								end
								local hexSize = 10
								local legSize = 1
								local s = 0.0026666666666666666 * hexSize
								local p = screwMinigame[6][i]
								sump = sump + p
								if p <= 0 and screwMinigame[5] then
									if screwMinigame[7][i] > 0 then
										screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
										if screwMinigame[7][i] < 0 then
											screwMinigame[7][i] = 0
										end
									end
								elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
									screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
									if 1 < screwMinigame[7][i] then
										screwMinigame[7][i] = 1
									end
								end
								if not repairingPart and not screwingWheel then
									p = 1
								end
								local a = screwMinigame[7][i]
								suma = suma + a
								local draw = false
								draw = drawScrewTop(x, y, z - s * legSize * (p - (1 - a)), math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, -legSize)
								if draw then
									tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
									wrenchCursor = true
									if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
										click = false
										tmpClick = draw
										screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
										if screwMinigame[6][i] <= 0 then
											screwMinigame[6][i] = 0
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
										if 1 <= screwMinigame[6][i] then
											screwMinigame[6][i] = 1
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
									end
								end
							end
						elseif screwMinigame[2] == "hood" then
							n = 4
							local px, py, pz = getVehicleComponentPosition(closestVeh, comp, "root")
							local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(closestVeh)
							setVehicleDoorOpenRatio(closestVeh, 0, 1)
							for i = 1, 4 do
								local x, y, z = false, false, false
								if 2 < i then
									x, y, z = getPositionFromElementOffset(closestVeh, minX * 0.7, py + 0.1 * (i % 2), pz)
								else
									x, y, z = getPositionFromElementOffset(closestVeh, maxX * 0.7, py + 0.1 * (i % 2), pz)
								end
								local hexSize = 10
								local legSize = 1
								local s = 0.0026666666666666666 * hexSize
								local p = screwMinigame[6][i]
								sump = sump + p
								if p <= 0 and screwMinigame[5] then
									if screwMinigame[7][i] > 0 then
										screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
										if screwMinigame[7][i] < 0 then
											screwMinigame[7][i] = 0
										end
									end
								elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
									screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
									if 1 < screwMinigame[7][i] then
										screwMinigame[7][i] = 1
									end
								end
								if not repairingPart and not screwingWheel then
									p = 1
								end
								local a = screwMinigame[7][i]
								suma = suma + a
								local draw = false
								draw = drawScrewTop(x, y, z - s * legSize * (p - (1 - a)), math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, -legSize)
								if draw then
									tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
									wrenchCursor = true
									if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
										click = false
										tmpClick = draw
										screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
										if screwMinigame[6][i] <= 0 then
											screwMinigame[6][i] = 0
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
										if 1 <= screwMinigame[6][i] then
											screwMinigame[6][i] = 1
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
									end
								end
							end
						elseif screwMinigame[2] == "frontBumper" or screwMinigame[2] == "rearBumper" then
							n = 4
							local yp = -0.2
							if screwMinigame[2] == "rearBumper" then
								rad = rad + 3.141592653589793
								yp = 0.2
							end
							local x, y, z = getVehicleComponentPosition(closestVeh, comp, "root")
							local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(closestVeh)
							local minX, minY, minZ = getPositionFromElementOffset(closestVeh, minX * 0.8, y + yp, z)
							local maxX, maxY, maxZ = getPositionFromElementOffset(closestVeh, maxX * 0.8, y + yp, z)
							for i = 1, 4 do
								local hexSize = 10
								local legSize = 1.25
								local s = 0.0026666666666666666 * hexSize
								local p = screwMinigame[6][i]
								sump = sump + p
								if p <= 0 and screwMinigame[5] then
									if screwMinigame[7][i] > 0 then
										screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
										if screwMinigame[7][i] < 0 then
											screwMinigame[7][i] = 0
										end
									end
								elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
									screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
									if 1 < screwMinigame[7][i] then
										screwMinigame[7][i] = 1
									end
								end
								if not repairingPart and not screwingWheel then
									p = 1
								end
								local a = screwMinigame[7][i]
								suma = suma + a
								local draw = false
								local x = 2 < i and maxX or minX
								local y = 2 < i and maxY or minY
								local z = 2 < i and maxZ or minZ
								draw = drawScrew(x - math.cos(rad + 1.5707963267948966) * s * legSize * (-1 + p - (1 - a)), y - math.sin(rad + 1.5707963267948966) * s * legSize * (-1 + p - (1 - a)), z + i % 2 * 0.075, rad, math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, legSize)
								if draw then
									tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
									wrenchCursor = true
									if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
										click = false
										tmpClick = draw
										screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
										if screwMinigame[6][i] <= 0 then
											screwMinigame[6][i] = 0
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
										if 1 <= screwMinigame[6][i] then
											screwMinigame[6][i] = 1
											tmpClick = false
											if repairingPart then
												triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
											end
										end
									end
								end
							end
						elseif screwMinigame[2] == "suspension_1" or screwMinigame[2] == "suspension_2" then
							n = 5
							setVehicleDoorOpenRatio(closestVeh, 0, 1)
							if not wheelOffInterpolation[closestVeh] or not wheelOffInterpolation[closestVeh][id] then
								z = z - 0.075
								setElementAlpha(closestVeh, 127.5)
								for i = 1, 5 do
									local hexSize = 2 < i and 13 or 19
									local legSize = 2 < i and 1 or 1.5
									local s = 0.0026666666666666666 * hexSize
									local p = screwMinigame[6][i]
									sump = sump + p
									if p <= 0 and screwMinigame[5] then
										if screwMinigame[7][i] > 0 then
											screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
											if screwMinigame[7][i] < 0 then
												screwMinigame[7][i] = 0
											end
										end
									elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
										screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
										if 1 < screwMinigame[7][i] then
											screwMinigame[7][i] = 1
										end
									end
									if not repairingPart and not screwingWheel then
										p = 1
									end
									local a = screwMinigame[7][i]
									suma = suma + a
									local draw = false
									if 2 < i then
										draw = drawScrewTop(x - math.cos(rad + 1.5707963267948966) * 0.05 - math.cos(rad) * 0.25 + math.cos(2.0943951023931953 * (i - 2)) * 0.05, y - math.sin(rad + 1.5707963267948966) * 0.05 - math.sin(rad) * 0.25 + math.sin(2.0943951023931953 * (i - 2)) * 0.05, hoodZ - s * legSize * (p - (1 - a)), math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, -legSize)
									else
										draw = drawScrew(x - math.cos(rad + 1.5707963267948966) * s * legSize * (-1 + p - (1 - a)), y - math.sin(rad + 1.5707963267948966) * s * legSize * (-1 + p - (1 - a)), z + i * 0.075, rad, math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, legSize)
									end
									if draw then
										tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
										wrenchCursor = true
										if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
											click = false
											tmpClick = draw
											screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
											if screwMinigame[6][i] <= 0 then
												screwMinigame[6][i] = 0
												tmpClick = false
												if repairingPart then
													triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
												end
											end
											if 1 <= screwMinigame[6][i] then
												screwMinigame[6][i] = 1
												tmpClick = false
												if repairingPart then
													triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
												end
											end
										end
									end
								end
								cancelWheel1 = true
								cancelWheel3 = true
							end
						elseif screwMinigame[2] == "suspension_3" or screwMinigame[2] == "suspension_4" then
							n = 2
							if not wheelOffInterpolation[closestVeh] or not wheelOffInterpolation[closestVeh][id] then
								local hexSize = 17
								local legSize = 2
								local s = 0.0026666666666666666 * hexSize
								setElementAlpha(closestVeh, 127.5)
								for i = 1, 2 do
									local p = screwMinigame[6][i]
									sump = sump + p
									if p <= 0 and screwMinigame[5] then
										if screwMinigame[7][i] > 0 then
											screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
											if screwMinigame[7][i] < 0 then
												screwMinigame[7][i] = 0
											end
										end
									elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
										screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
										if 1 < screwMinigame[7][i] then
											screwMinigame[7][i] = 1
										end
									end
									if not repairingPart and not screwingWheel then
										p = 1
									end
									local a = screwMinigame[7][i]
									suma = suma + a
									local draw = drawScrew(x - math.cos(rad + 1.5707963267948966) * s * legSize * (-1 + p - (1 - a)) - math.cos(rad) * 0.2 * (i - 1), y - math.sin(rad + 1.5707963267948966) * s * legSize * (-1 + p - (1 - a)) - math.sin(rad) * 0.2 * (i - 1), z + (i - 1) * 0.45, rad, math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, legSize)
									if draw then
										tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
										wrenchCursor = true
										if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
											click = false
											tmpClick = draw
											screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
											if screwMinigame[6][i] <= 0 then
												screwMinigame[6][i] = 0
												tmpClick = false
												if repairingPart then
													triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
												end
											end
											if 1 <= screwMinigame[6][i] then
												screwMinigame[6][i] = 1
												tmpClick = false
												if repairingPart then
													triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
												end
											end
										end
									end
								end
								cancelWheel1 = true
								cancelWheel3 = true
							end
						elseif screwMinigame[2] == "brake_1" or screwMinigame[2] == "brake_2" or screwMinigame[2] == "brake_3" or screwMinigame[2] == "brake_4" then
							n = #brakeScrewMatrix
							if not wheelOffInterpolation[closestVeh] or not wheelOffInterpolation[closestVeh][id] then
								local d = 0.1
								setElementAlpha(closestVeh, 127.5)
								for i = 1, n do
									local legSize = i == 1 and 1 or 2
									local hexSize = i == 1 and 8 or 13
									local s = 0.0026666666666666666 * hexSize
									local rad = rad + brakeScrewMatrix[i][6]
									local r3 = rad
									local r2 = rad - 1.5707963267948966
									if screwMinigame[2] == "brake_1" or screwMinigame[2] == "brake_3" then
										rad = rad - 3.141592653589793
									end
									local p = screwMinigame[6][i]
									sump = sump + p
									if p <= 0 and screwMinigame[5] then
										if screwMinigame[7][i] > 0 then
											screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
											if screwMinigame[7][i] < 0 then
												screwMinigame[7][i] = 0
											end
										end
									elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
										screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
										if 1 < screwMinigame[7][i] then
											screwMinigame[7][i] = 1
										end
									end
									if not repairingPart and not screwingWheel then
										p = 1
									end
									local a = screwMinigame[7][i]
									suma = suma + a
									local draw = drawScrew(x - math.cos(r3) * s * legSize * (brakeScrewMatrix[i][7] + p - (1 - a)) + math.cos(rad + brakeScrewMatrix[i][1]) * brakeScrewMatrix[i][2] * d, y - math.sin(r3) * s * legSize * (brakeScrewMatrix[i][7] + p - (1 - a)) + math.sin(rad + brakeScrewMatrix[i][3]) * brakeScrewMatrix[i][4] * d, z + d * brakeScrewMatrix[i][5], r2, math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, legSize)
									if draw then
										tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
										wrenchCursor = true
										if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
											click = false
											tmpClick = draw
											screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
											if screwMinigame[6][i] <= 0 then
												screwMinigame[6][i] = 0
												tmpClick = false
												if repairingPart then
													triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
												end
											end
											if 1 <= screwMinigame[6][i] then
												screwMinigame[6][i] = 1
												tmpClick = false
												if repairingPart then
													triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
												end
											end
										end
									end
								end
							end
						elseif screwMinigame[2] == "wheel_1" or screwMinigame[2] == "wheel_2" or screwMinigame[2] == "wheel_3" or screwMinigame[2] == "wheel_4" then
							n = #wheelScrewMatrix
							if not wheelOffInterpolation[closestVeh] or not wheelOffInterpolation[closestVeh][id] then
								local d = 0.1
								if id == 1 or id == 2 then
									d = getVehicleModelWheelSize( getElementModel(closestVeh), "front_axle") * 0.15
								else
									d = getVehicleModelWheelSize(getElementModel(closestVeh), "rear_axle") * 0.15
								end
								for i = 1, n do
									local legSize = 0.75
									local hexSize = 19
									local s = 0.0026666666666666666 * hexSize
									local p = screwMinigame[6][i]
									sump = sump + p
									if p <= 0 and screwMinigame[5] then
										if screwMinigame[7][i] > 0 then
											screwMinigame[7][i] = screwMinigame[7][i] - delta / 500
											if screwMinigame[7][i] < 0 then
												screwMinigame[7][i] = 0
											end
										end
									elseif (repairingPart or 1 <= p or screwingWheel) and 1 > screwMinigame[7][i] then
										screwMinigame[7][i] = screwMinigame[7][i] + delta / 500
										if 1 < screwMinigame[7][i] then
											screwMinigame[7][i] = 1
										end
									end
									if not repairingPart and not screwingWheel then
										p = 1
									end
									local a = screwMinigame[7][i]
									suma = suma + a
									local draw = drawScrew(x - math.cos(rad) * s * legSize * (-4.5 + p - (1 - a)) + math.cos(rad + wheelScrewMatrix[i][1]) * wheelScrewMatrix[i][2] * d, y - math.sin(rad) * s * legSize * (-4.5 + p - (1 - a)) + math.sin(rad + wheelScrewMatrix[i][3]) * wheelScrewMatrix[i][4] * d, z + d * wheelScrewMatrix[i][5], rad - 1.5707963267948966, math.rad(p * 5 * 360 * legSize), s, cx, cy, a, hexSize, legSize)
									if draw then
										tmpTooltip = "M" .. hexSize .. " csavar (" .. math.floor(p * 100) .. "%)"
										wrenchCursor = true
										if click and (screwMinigame[5] and screwMinigame[6][i] > 0 or not screwMinigame[5] and 1 > screwMinigame[6][i]) and currentHexSize == hexSize then
											click = false
											tmpClick = draw
											screwMinigame[6][i] = screwMinigame[6][i] + delta / 1000 * 0.5 * (screwMinigame[5] and -1 or 1) * 1 / legSize * screwSpeedup
											if screwMinigame[6][i] <= 0 then
												screwMinigame[6][i] = 0
												tmpClick = false
												if repairingPart then
													triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
												end
											end
											if 1 <= screwMinigame[6][i] then
												screwMinigame[6][i] = 1
												tmpClick = false
												if repairingPart then
													triggerServerEvent("syncSpectatorScrews", localPlayer, screwMinigame[1], screwMinigame[6])
												end
											end
										end
									end
								end
								cancelWheel1 = true
								cancelWheel2 = true
							end
						end
						if repairingPart or screwingWheel then
							if cancelWheel1 and closestOnGround then
								screwMinigame = false
								resetWheelsOff(closestVeh)
								if repairingPart then
									triggerServerEvent("cancelPartRepair", localPlayer)
									sightexports.sGui:showInfobox("e", "Megszakadt a szerelési folyamat!")
									createMinigameObj(false)
									setElementAlpha(closestVeh, 255)
									repairingPart = false
								end
							elseif cancelWheel2 and wheelsOff[closestVeh] and wheelsOff[closestVeh][id] then
								screwMinigame = false
								resetWheelsOff(closestVeh)
								if repairingPart then
									triggerServerEvent("cancelPartRepair", localPlayer)
									sightexports.sGui:showInfobox("e", "Megszakadt a szerelési folyamat!")
									createMinigameObj(false)
									setElementAlpha(closestVeh, 255)
									repairingPart = false
								end
							elseif cancelWheel3 and (not wheelsOff[closestVeh] or not wheelsOff[closestVeh][id]) then
								screwMinigame = false
								resetWheelsOff(closestVeh)
								if repairingPart then
									triggerServerEvent("cancelPartRepair", localPlayer)
									sightexports.sGui:showInfobox("e", "Megszakadt a szerelési folyamat!")
									createMinigameObj(false)
									setElementAlpha(closestVeh, 255)
									repairingPart = false
								end
							elseif screwMinigame[5] then
								if suma <= 0 then
									if now - canEndScrew > 500 or screwMinigame[2] == "oil1" then
										local fn = screwMinigame[3]
										local arg = screwMinigame[4]
										screwMinigame = false
										if fn then
											fn(arg, closestVeh)
										end
									end
								else
									canEndScrew = now
								end
							elseif n <= sump then
								if now - canEndScrew > 1000 then
									local fn = screwMinigame[3]
									local arg = screwMinigame[4]
									screwMinigame = false
									if fn then
										fn(arg, closestVeh)
									end
								end
							else
								canEndScrew = now
							end
						end
					end
				end
			else
				screwMinigame = false
			end
		elseif not repairingPart and not screwingWheel and not partAnimation and not spectatorStates[closestVeh] and currentWorkshopPerm then
			if wheelAlignVeh == closestVeh then
				if wheelCalibrationDone and pullingValue then
					for j = 1, 4 do
						local comp = false
						local comp = "wheel_" .. wheels[j] .. "_dummy"
						local x, y, z = getComponentPosition(closestVeh, comp)
						if x then
							local d = getDistanceBetweenPoints2D(px, py, x, y)
							local x, y = getScreenFromWorldPosition(x, y, z, 256)
							if x and y then
								if wheelAligned[j] then
									local p = math.max(0, (now - wheelAligned[j]) / 5500)
									if p >= 0 and p <= 1 then
										dxDrawRectangle(x - 70, y - 5, 140, 10, sightexports.sGui:getColorCodeToColor("sightgrey1"))
										dxDrawRectangle(x - 70, y - 5, 140 * p, 10, sightexports.sGui:getColorCodeToColor("sightgreen"))
									elseif not hoveredPart and d <= 2 and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
										tmpTooltip = "Szenzor levétele"
										hoveredPart = "removesensor"
										hoveredWheel = j
										sightlangStaticImageUsed[9] = true
										if sightlangStaticImageToc[9] then
											processsightlangStaticImage[9]()
										end
										dxDrawImage(x - 16, y - 16, 32, 32, sightlangStaticImage[9], 0, 0, 0, tocolor(255, 255, 255, 255))
									else
										sightlangStaticImageUsed[9] = true
										if sightlangStaticImageToc[9] then
											processsightlangStaticImage[9]()
										end
										dxDrawImage(x - 16, y - 16, 32, 32, sightlangStaticImage[9], 0, 0, 0, tocolor(255, 255, 255, 150))
									end
								else
									if not hoveredPart and d <= 2 and cx >= x - 32 - 4 and cy >= y - 16 and cx <= x - 4 and cy <= y + 16 then
										tmpTooltip = "Kerék beállítása"
										hoveredPart = "alignwheel"
										hoveredWheel = j
										sightlangStaticImageUsed[10] = true
										if sightlangStaticImageToc[10] then
											processsightlangStaticImage[10]()
										end
										dxDrawImage(x - 32 - 4, y - 16, 32, 32, sightlangStaticImage[10], 0, 0, 0, tocolor(255, 255, 255, 255))
									else
										sightlangStaticImageUsed[10] = true
										if sightlangStaticImageToc[10] then
											processsightlangStaticImage[10]()
										end
										dxDrawImage(x - 32 - 4, y - 16, 32, 32, sightlangStaticImage[10], 0, 0, 0, tocolor(255, 255, 255, 150))
									end
									if not hoveredPart and d <= 2 and cx >= x + 4 and cy >= y - 16 and cx <= x + 4 + 32 and cy <= y + 16 then
										tmpTooltip = "Szenzor levétele"
										hoveredPart = "removesensor"
										hoveredWheel = j
										sightlangStaticImageUsed[9] = true
										if sightlangStaticImageToc[9] then
											processsightlangStaticImage[9]()
										end
										dxDrawImage(x + 4, y - 16, 32, 32, sightlangStaticImage[9], 0, 0, 0, tocolor(255, 255, 255, 255))
									else
										sightlangStaticImageUsed[9] = true
										if sightlangStaticImageToc[9] then
											processsightlangStaticImage[9]()
										end
										dxDrawImage(x + 4, y - 16, 32, 32, sightlangStaticImage[9], 0, 0, 0, tocolor(255, 255, 255, 150))
									end
								end
							end
						end
					end
				elseif canPlaceSensors then
					for j = 1, 4 do
						local comp = false
						local comp = "wheel_" .. wheels[j] .. "_dummy"
						local x, y, z = getComponentPosition(closestVeh, comp)
						if x then
							local d = getDistanceBetweenPoints2D(px, py, x, y)
							local x, y = getScreenFromWorldPosition(x, y, z, 256)
							if x and y then
								if not hoveredPart and d <= 2 and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
									hoveredWheel = j
									if alignmentSensorPlaced[j] then
										tmpTooltip = "Szenzor levétele"
										hoveredPart = "removesensor"
										sightlangStaticImageUsed[9] = true
										if sightlangStaticImageToc[9] then
											processsightlangStaticImage[9]()
										end
										dxDrawImage(x - 16, y - 16, 32, 32, sightlangStaticImage[9], 0, 0, 0, tocolor(255, 255, 255, 255))
									else
										tmpTooltip = "Szenzor felhelyezése"
										hoveredPart = "placesensor"
										sightlangStaticImageUsed[11] = true
										if sightlangStaticImageToc[11] then
											processsightlangStaticImage[11]()
										end
										dxDrawImage(x - 16, y - 16, 32, 32, sightlangStaticImage[11], 0, 0, 0, tocolor(255, 255, 255, 255))
									end
								elseif alignmentSensorPlaced[j] then
									sightlangStaticImageUsed[9] = true
									if sightlangStaticImageToc[9] then
										processsightlangStaticImage[9]()
									end
									dxDrawImage(x - 16, y - 16, 32, 32, sightlangStaticImage[9], 0, 0, 0, tocolor(255, 255, 255, 150))
								else
									sightlangStaticImageUsed[11] = true
									if sightlangStaticImageToc[11] then
										processsightlangStaticImage[11]()
									end
									dxDrawImage(x - 16, y - 16, 32, 32, sightlangStaticImage[11], 0, 0, 0, tocolor(255, 255, 255, 150))
								end
							end
						end
					end
				else
					for j = 1, 4 do
						local comp = false
						local comp = "wheel_" .. wheels[j] .. "_dummy"
						local x, y, z = getComponentPosition(closestVeh, comp)
						if x then
							local d = getDistanceBetweenPoints2D(px, py, x, y)
							local x, y = getScreenFromWorldPosition(x, y, z, 256)
							if x and y then
								if not hoveredPart and d <= 2 and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
									hoveredWheel = j
									if alignmentSensorPlaced[j] then
										tmpTooltip = "Szenzor levétele"
										hoveredPart = "removesensor"
										sightlangStaticImageUsed[9] = true
										if sightlangStaticImageToc[9] then
											processsightlangStaticImage[9]()
										end
										dxDrawImage(x - 16, y - 16, 32, 32, sightlangStaticImage[9], 0, 0, 0, tocolor(255, 255, 255, 255))
									end
								elseif alignmentSensorPlaced[j] then
									sightlangStaticImageUsed[9] = true
									if sightlangStaticImageToc[9] then
										processsightlangStaticImage[9]()
									end
									dxDrawImage(x - 16, y - 16, 32, 32, sightlangStaticImage[9], 0, 0, 0, tocolor(255, 255, 255, 150))
								end
							end
						end
					end
				end
			elseif inspectionVeh ~= closestVeh and not obdState then
				local wheel = wheelsOff[closestVeh] or {}
				for j = 1, #componentList do
					local comp = componentList[j]
					local interpolation = false
					if wheelOffInterpolation[closestVeh] then
						if comp == "wheel_lf_dummy" then
							interpolation = wheelOffInterpolation[closestVeh][1]
						elseif comp == "wheel_rf_dummy" then
							interpolation = wheelOffInterpolation[closestVeh][2]
						elseif comp == "wheel_lb_dummy" then
							interpolation = wheelOffInterpolation[closestVeh][3]
						elseif comp == "wheel_rb_dummy" then
							interpolation = wheelOffInterpolation[closestVeh][4]
						end
					end
					if not interpolation then
						local x, y, z = getComponentPosition(closestVeh, comp)
						if x then
							local d = getDistanceBetweenPoints2D(px, py, x, y)
							local x, y = getScreenFromWorldPosition(x, y, z, 256)
							if x and y then
								local n = 0
								local visible = {}
								for k = 1, #componentParts[comp] do
									visible[componentParts[comp][k]] = isPartVisible(closestVeh, comp, componentParts[comp][k])
									if not repairParts[closestVeh] then
										n = n + (visible[componentParts[comp][k]] and 1 or 0)
									elseif repairParts[closestVeh] and repairParts[closestVeh][componentParts[comp][k]] and (not closestOnGround or comp ~= "wheel_lf_dummy" and comp ~= "wheel_rf_dummy" and comp ~= "wheel_rb_dummy" and comp ~= "wheel_lb_dummy") then
										n = n + (visible[componentParts[comp][k]] and 1 or 0)
									end
								end
								if not closestOnGround and (comp == "wheel_lf_dummy" or comp == "wheel_rf_dummy" or comp == "wheel_rb_dummy" or comp == "wheel_lb_dummy") then
									n = n + 1
								end
								x = x - 40 * math.min(3, n) * 0.5 + 16 + 4
								y = y - 40 * math.ceil(n / 3) * 0.5 + 16 + 4
								if not closestOnGround and (comp == "wheel_lf_dummy" or comp == "wheel_rf_dummy" or comp == "wheel_rb_dummy" or comp == "wheel_lb_dummy") then
									local c = {
										255,
										255,
										255
									}
									local off = "off"
									local name = ""
									local wid = false
									if comp == "wheel_lf_dummy" then
										off = wheel[1] and "on" or "off"
										wid = 1
									elseif comp == "wheel_rf_dummy" then
										off = wheel[2] and "on" or "off"
										wid = 2
									elseif comp == "wheel_lb_dummy" then
										off = wheel[3] and "on" or "off"
										wid = 3
									elseif comp == "wheel_rb_dummy" then
										off = wheel[4] and "on" or "off"
										wid = 4
									end
									if wid then
										name = "wheel_off_" .. wid
									end
									if not hoveredPart and d <= 2 and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
										tmpTooltip = "Kerék " .. (off == "off" and "le" or "fel") .. "szerelése"
										hoveredPart = name
										hoveredWheel = wid
										dxDrawImage(x - 16, y - 16, 32, 32, dynamicImage("files/wheel_" .. off .. ".dds"), 0, 0, 0, tocolor(c[1], c[2], c[3], 255))
									else
										dxDrawImage(x - 16, y - 16, 32, 32, dynamicImage("files/wheel_" .. off .. ".dds"), 0, 0, 0, tocolor(c[1], c[2], c[3], 150))
									end
									x = x + 32 + 8
								end
								local count = 0
								for k = 1, #componentParts[comp] do
									local part = componentParts[comp][k]
									local isVehEV = false
									local isVehEV = evVehicles[getElementData(closestVeh, "vehicle.customModel")] and true or false
									if isVehEV and (part == "engineTimingKit" or part == "engineGeneralKit" or part == "fuelRepairKit" or part == "oilChangeKit" or part == "engineRepairKit") then
										visible[part] = false
									end
									if visible[part] then
										if not repairParts[closestVeh] then
											local c = {
												255,
												255,
												255
											}
											if partHealthCache[closestVeh] and partHealthCache[closestVeh][part] then
												c = getPartColor(partHealthCache[closestVeh][part])
											end
											if not hoveredPart and d <= 2 and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
												hoveredPart = part
												dxDrawImage(x - 16, y - 16, 32, 32, dynamicImage("files/" .. partIcons[hoveredPart] .. ".dds"), 0, 0, 0, tocolor(c[1], c[2], c[3], 255))
												tmpTooltip = partsOnVehicle[hoveredPart].name
												if partHealthCache[closestVeh] and partHealthCache[closestVeh][hoveredPart] then
													tmpTooltip = tmpTooltip .. " (" .. math.floor(math.abs(partHealthCache[closestVeh][hoveredPart]) + 0.5) .. "%"
													if partHealthCache[closestVeh][hoveredPart] < 0 then
														tmpTooltip = tmpTooltip .. ", téli"
													end
													tmpTooltip = tmpTooltip .. ")"
												end
												if carPartSwap[closestVeh] and carPartSwap[closestVeh][part] then
													tmpTooltip = tmpTooltip .. [[
                          
>> ]] .. partBackwards[carPartSwap[closestVeh][part]][4] .. " (" .. carPartSwap[closestVeh][part] .. ")"
													tmpTooltip = tmpTooltip .. " - " .. sightexports.sGui:getColorCodeHex("sightgreen") .. sightexports.sGui:thousandsStepper(math.floor(wages[selectedWage] * partTypes[part].wage + 0.5) + math.floor(partPrices[carPartSwap[closestVeh][part]] * (1 + priceMargins[selectedPriceMargin] / 100) + 0.5)) .. " $"
												end
												if carPartSwap[closestVeh] and carPartSwap[closestVeh][part] then
													sightlangStaticImageUsed[12] = true
													if sightlangStaticImageToc[12] then
														processsightlangStaticImage[12]()
													end
													dxDrawImage(x - 16, y - 16, 32, 32, sightlangStaticImage[12], 0, 0, 0, tocolor(blue[1], blue[2], blue[3], 255))
												end
											elseif carPartSwap[closestVeh] and carPartSwap[closestVeh][part] then
												dxDrawImage(x - 16, y - 16, 32, 32, dynamicImage("files/" .. partIcons[part] .. ".dds"), 0, 0, 0, tocolor(c[1], c[2], c[3], 180))
												sightlangStaticImageUsed[12] = true
												if sightlangStaticImageToc[12] then
													processsightlangStaticImage[12]()
												end
												dxDrawImage(x - 16, y - 16, 32, 32, sightlangStaticImage[12], 0, 0, 0, tocolor(blue[1], blue[2], blue[3], 180))
											else
												dxDrawImage(x - 16, y - 16, 32, 32, "files/" .. partIcons[part] .. ".dds", 0, 0, 0, tocolor(c[1], c[2], c[3], 150))
											end
											count = count + 1
											x = x + 32 + 8
											if count % 3 == 0 then
												x = x - 120
												y = y + 32 + 8
											end
										elseif repairParts[closestVeh][part] and (not closestOnGround or comp ~= "wheel_lf_dummy" and comp ~= "wheel_rf_dummy" and comp ~= "wheel_rb_dummy" and comp ~= "wheel_lb_dummy") then
											local c = red
											if repairParts[closestVeh][part] == 1 then
												c = green
											end
											if not hoveredPart and d <= 2 and cx >= x - 16 and cy >= y - 16 and cx <= x + 16 and cy <= y + 16 then
												hoveredPart = part
												if comp == "wheel_lf_dummy" then
													hoveredWheel = 1
												elseif comp == "wheel_rf_dummy" then
													hoveredWheel = 2
												elseif comp == "wheel_lb_dummy" then
													hoveredWheel = 3
												elseif comp == "wheel_rb_dummy" then
													hoveredWheel = 4
												end
												tmpTooltip = repairNames[hoveredPart] or partsOnVehicle[hoveredPart].name
												dxDrawImage(x - 16, y - 16, 32, 32, dynamicImage("files/" .. partIcons[part] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 255))
												sightlangStaticImageUsed[12] = true
												if sightlangStaticImageToc[12] then
													processsightlangStaticImage[12]()
												end
												dxDrawImage(x - 16, y - 16, 32, 32, sightlangStaticImage[12], 0, 0, 0, tocolor(c[1], c[2], c[3], 255))
											else
												dxDrawImage(x - 16, y - 16, 32, 32, dynamicImage("files/" .. partIcons[part] .. ".dds"), 0, 0, 0, tocolor(255, 255, 255, 180))
												sightlangStaticImageUsed[12] = true
												if sightlangStaticImageToc[12] then
													processsightlangStaticImage[12]()
												end
												dxDrawImage(x - 16, y - 16, 32, 32, sightlangStaticImage[12], 0, 0, 0, tocolor(c[1], c[2], c[3], 180))
											end
											count = count + 1
											x = x + 32 + 8
											if count % 3 == 0 then
												x = x - 120
												y = y + 32 + 8
											end
										end
									end
								end
							end
						else
							for k = 1, #componentParts[comp] do
								if not repairParts[closestVeh] or repairParts[closestVeh][componentParts[comp][k]] then
									table.insert(tmpUnlisted, componentParts[comp][k])
								end
							end
						end
					end
				end
			end
			tmpUnlisted = table.concat(tmpUnlisted, ";")
			if tmpUnlisted ~= unlistedParts then
				unlistedParts = tmpUnlisted
				local tmp2 = split(unlistedParts, ";")
				unlistedPartsEx = {}
				for i = 1, #tmp2 do
					unlistedPartsEx[tmp2[i]] = true
				end
				createCarWindow()
			end
		end
	end
	if tmpTooltip ~= tooltipText then
		tooltipText = tmpTooltip
		if tooltipText then
			sightexports.sGui:setCursorType(wrenchCursor and "wrench" or "link")
			sightexports.sGui:showTooltip(tooltipText)
		else
			sightexports.sGui:setCursorType("normal")
			sightexports.sGui:showTooltip(false)
		end
	end
	if (tmpClick and true or false) ~= click then
		click = tmpClick and true or false
		sightexports.sWeapons:setWrenchRotation(click and (screwMinigame[5] and 1 or -1) or false)
		local x, y, z = getPedBonePosition(localPlayer, 3)
		local deg = 0
		if tmpClick then
			local d = getDistanceBetweenPoints3D(x, y, z, tmpClick[1], tmpClick[2], tmpClick[3])
			local d2 = z - tmpClick[3]
			deg = math.deg(math.asin(d2 / d))
			local t = math.deg(math.atan2(tmpClick[2] - y, tmpClick[1] - x))
			t = t - 90
			setElementRotation(localPlayer, 0, 0, t, "default", true)
		end
		triggerServerEvent("impactGunState", localPlayer, click, deg >= 30 and "dn" or deg <= -35 and "up" or "")
	end
end
function drawScrewTop(x, y, z, r2, s, cx, cy, a, hexSize, leg)
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
		local x, y = getScreenFromWorldPosition(x + poses[i][1], y + poses[i][2], z, 256)
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
	if (repairingPart or screwingWheel) and cx >= minX - 4 and cy >= minY - 4 and cx <= maxX + 4 and cy <= maxY + 4 then
		local px, py, pz = getElementPosition(localPlayer)
		if getDistanceBetweenPoints2D(wx, wy, px, py) <= 1.75 then
			hover = {
				wx,
				wy,
				wz
			}
			if currentHexSize == hexSize or 20 < hexSize then
				c = tocolor(green[1], green[2], green[3], 200 * a)
			else
				c = tocolor(red[1], red[2], red[3], 200 * a)
			end
		end
	end
	for i = 1, #primitive do
		primitive[i][3] = c
	end
	local x2, y2 = getScreenFromWorldPosition(x, y + sy / 2, z + s * leg, 256)
	local x, y, d = getScreenFromWorldPosition(x, y + sy / 2, z, 256)
	if x and x2 then
		dxDrawLine(x, y, x2, y2, c, 1 / d * s * 350)
	end
	dxDrawPrimitive("trianglestrip", false, unpack(primitive))
	return hover
end
function setWheelOffState(veh, wheel, state)
	wheel = tonumber(wheel)
	if isElement(veh) and wheel and 1 <= wheel and wheel <= 4 then
		if not wheelsOff[veh] then
			wheelsOff[veh] = {}
		end
		if not wheelOffInterpolation[veh] then
			wheelOffInterpolation[veh] = {}
		end
		state = state and true or nil
		if wheelsOff[veh][wheel] ~= state then
			wheelsOff[veh][wheel] = state
			if veh == closestVeh then
				createVehicleObjectsWithId(veh, wheel)
			end
			local comp = false
			if wheel == 1 then
				comp = "wheel_lf_dummy"
			elseif wheel == 2 then
				comp = "wheel_rf_dummy"
			elseif wheel == 3 then
				comp = "wheel_lb_dummy"
			elseif wheel == 4 then
				comp = "wheel_rb_dummy"
			end
			resetVehicleComponentPosition(veh, comp)
			setVehicleComponentVisible(veh, comp, true)
			local x, y, z = getVehicleComponentPosition(veh, comp, "root")
			wheelOffInterpolation[veh][wheel] = {
				getTickCount(),
				x,
				y,
				z
			}
		end
	end
end
addEvent("gotWheelOffCache", true)
addEventHandler("gotWheelOffCache", getRootElement(), function(ws, cache)
	if ws == currentWorkshop then
		for i = 1, #cache do
			if cache[i] then
				local veh = cache[i][1]
				local wheel = cache[i][2]
				local state = cache[i][3]
				if not originalWheelsOff[veh] then
					originalWheelsOff[veh] = {}
				end
				originalWheelsOff[veh][wheel] = state
				setWheelOffState(veh, wheel, state)
			end
		end
	end
end)
addEvent("setWheelOffState", true)
addEventHandler("setWheelOffState", getRootElement(), function(veh, wheel, state)
	if isElement(veh) then
		if not originalWheelsOff[veh] then
			originalWheelsOff[veh] = {}
		end
		originalWheelsOff[veh][wheel] = state
		for i = 1, 4 do
			setWheelOffState(veh, i, originalWheelsOff[veh][i])
		end
	end
end)
function endWheelOn(arg, veh)
	screwingWheel = false
	triggerServerEvent("setWheelOffState", localPlayer, veh, arg, false)
end
function endWheelOff(arg, veh)
	screwingWheel = false
	triggerServerEvent("setWheelOffState", localPlayer, veh, arg, true)
end