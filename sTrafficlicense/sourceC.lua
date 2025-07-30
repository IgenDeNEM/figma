local sightexports = {sGui = false, sVehiclenames = false}
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
	if sightlangStaticImageToc[0] and sightlangStaticImageToc[1] and sightlangStaticImageToc[2] and sightlangStaticImageToc[3] and sightlangStaticImageToc[4] then
		sightlangStatImgHand = false
		removeEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre)
	end
end
processsightlangStaticImage[0] = function()
	if not isElement(sightlangStaticImage[0]) then
		sightlangStaticImageToc[0] = false
		sightlangStaticImage[0] = dxCreateTexture("files/adasveteli.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/adasv.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[2] = function()
	if not isElement(sightlangStaticImage[2]) then
		sightlangStaticImageToc[2] = false
		sightlangStaticImage[2] = dxCreateTexture("files/adase.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[3] = function()
	if not isElement(sightlangStaticImage[3]) then
		sightlangStaticImageToc[3] = false
		sightlangStaticImage[3] = dxCreateTexture("files/adas2.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processsightlangStaticImage[4] = function()
	if not isElement(sightlangStaticImage[4]) then
		sightlangStaticImageToc[4] = false
		sightlangStaticImage[4] = dxCreateTexture("files/adas3.dds", "argb", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
local licenseDatas = {
	{
		"Típus",
		"BMW m5 e60 530d xDrive"
	},
	{
		"Tulajdonos",
		"Alpolgarmester Tivadar (magánszemély)"
	},
	"hr",
	{"Rendszám", "ACD-373"},
	{"Fényezés", "color"},
	"break",
	{"Üzemanyag", "Benzin"},
	{"Meghajtás", "AWD"},
	"hr",
	{
		"Műszaki érvényesség",
		"2021. 09. 26."
	},
	{
		"Kiállítás időpontja",
		"2021. 07. 26. 12:23"
	},
	"page",
	{"Motor", "venom"},
	{
		"Turbo",
		"SuperCharger",
		true
	},
	{
		"ECU",
		"állítható venom"
	},
	{"Váltó", "venom"},
	{
		"Felfüggesztés",
		"venom"
	},
	{"Fék", "venom"},
	{"Gumi", "venom"},
	{
		"Súlycsökkentés",
		"venom"
	},
	"break",
	{"Backfire", "nincs"},
	{
		"Hasmagasság",
		"gyári"
	},
	{"Paintjob", "egyedi"},
	{
		"Felni paintjob",
		"nincs"
	},
	{
		"Lámpa paintjob",
		"nincs"
	},
	{"LSD ajtó", "nincs"},
	{
		"Nitro szett",
		"nincs"
	},
	{"Spinner", "nincs"}
}
local inside = false
function deleteTrafficLicense()
	if inside then
		sightexports.sGui:deleteGuiElement(inside)
	end
	inside = false
end
local screenX, screenY = guiGetScreenSize()
local tuningLevels = {
	"profi",
	"verseny",
	"venom"
}
addEvent("gotTrafficLicenseData", true)
addEventHandler("gotTrafficLicenseData", getRootElement(), function(row)
	playSound("files/paper.mp3")
	createTrafficLicense(row)
end)
function createTrafficLicense(row, x)
	deleteTrafficLicense()
	if row then
		inside = sightexports.sGui:createGuiElement("image", x or screenX / 2 - 256, screenY / 2 - 256, 512, 512, false)
		sightexports.sGui:setImageDDS(inside, ":sTrafficlicense/files/bg.dds")
		local label = sightexports.sGui:createGuiElement("label", 80, 48, 512, 512, inside)
		sightexports.sGui:setLabelFont(label, "10/BebasNeueRegular.otf")
		sightexports.sGui:setLabelAlignment(label, "left", "top")
		sightexports.sGui:setLabelColor(label, "#46191a")
		sightexports.sGui:setLabelText(label, "SightCity")
		local label = sightexports.sGui:createGuiElement("label", 80, 62, 512, 512, inside)
		sightexports.sGui:setLabelFont(label, "15/BebasNeueBold.otf")
		sightexports.sGui:setLabelAlignment(label, "left", "top")
		sightexports.sGui:setLabelColor(label, "#46191a")
		sightexports.sGui:setLabelText(label, "FORGALMI ENGEDÉLY")
		local logo = sightexports.sGui:createGuiElement("image", 360, 48, 56, 24, inside)
		sightexports.sGui:setImageDDS(logo, ":sTrafficlicense/files/see.dds")
		local label = sightexports.sGui:createGuiElement("label", 360, 72, 56, 16, inside)
		sightexports.sGui:setLabelFont(label, "10/BebasNeueBold.otf")
		sightexports.sGui:setLabelAlignment(label, "center", "bottom")
		sightexports.sGui:setLabelColor(label, "#46191a")
		sightexports.sGui:setLabelText(label, "ID: " .. row.vehicleId)
		local border = sightexports.sGui:createGuiElement("rectangle", 80, 89, 336, 1, inside)
		sightexports.sGui:setGuiBackground(border, "solid", "#46191a")
		licenseDatas[1][2] = sightexports.sVehiclenames:getCustomVehicleName(row.model)
		licenseDatas[2][2] = row.owner
		licenseDatas[4][2] = row.numberPlate
		if row.model == "model_s" or row.model == "model_y" or row.model == "leaf" then
			licenseDatas[7][2] = "elektromos"
		else
			licenseDatas[7][2] = row.isDiesel == 1 and "dízel" or "benzin"
		end
		if row.driveType == 0 then
			licenseDatas[8][2] = "AWD"
		elseif row.driveType == 1 then
			licenseDatas[8][2] = "RWD"
		elseif row.driveType == 2 then
			licenseDatas[8][2] = "FWD"
		elseif row.driveType == 3 then
			licenseDatas[8][2] = "állítható"
		end
		local time = getRealTime(row.expireDate * 24 * 60 * 60)
		licenseDatas[10][2] = string.format("%04d. %02d. %02d.", time.year + 1900, time.month + 1, time.monthday)
		local time = getRealTime(row.creationDate)
		licenseDatas[11][2] = string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
		licenseDatas[13][2] = tuningLevels[row.engine] or "gyári"
		if row.turbo == 5 then
			licenseDatas[14][2] = "egyedi venom"
		elseif row.turbo == 4 then
			licenseDatas[14][2] = "SuperCharger"
		else
			licenseDatas[14][2] = tuningLevels[row.turbo] or "gyári"
		end
		if row.ecu == 4 then
			licenseDatas[15][2] = "állítható venom"
		else
			licenseDatas[15][2] = tuningLevels[row.ecu] or "gyári"
		end
		licenseDatas[16][2] = tuningLevels[row.transmission] or "gyári"
		licenseDatas[17][2] = tuningLevels[row.suspension] or "gyári"
		licenseDatas[18][2] = tuningLevels[row.brake] or "gyári"
		licenseDatas[19][2] = tuningLevels[row.tire] or "gyári"
		licenseDatas[20][2] = tuningLevels[row.weightReduction] or "gyári"
		if row.rideHeight == 5 then
			licenseDatas[23][2] = "AirRide"
		elseif 0 < row.rideHeight then
			licenseDatas[23][2] = "ültetőrugó " .. row.rideHeight
		else
			licenseDatas[23][2] = "gyári"
		end
		if row.paintjob == 2 then
			licenseDatas[24][2] = "egyedi"
		elseif row.paintjob == 1 then
			licenseDatas[24][2] = "normál"
		else
			licenseDatas[24][2] = "nincs"
		end
		if row.backfire == 2 then
			licenseDatas[22][2] = "egyedi"
		elseif row.backfire == 1 then
			licenseDatas[22][2] = "normál"
		else
			licenseDatas[22][2] = "nincs"
		end
		if row.model == "model_s" or row.model == "model_y" or row.model == "leaf" then
			licenseDatas[22][2] = "-"
		end
		licenseDatas[25][2] = row.wheelPaintjob == 1 and "van" or "nincs"
		licenseDatas[26][2] = row.headlightPaintjob == 1 and "van" or "nincs"
		licenseDatas[27][2] = row.lsdDoor == 1 and "van" or "nincs"
		licenseDatas[28][2] = row.nitro == 1 and "van" or "nincs"
		if row.model == "model_s" or row.model == "model_y" or row.model == "leaf" then
			licenseDatas[28][2] = "-"
		end
		licenseDatas[29][2] = row.spinner == 1 and "van" or "nincs"
		licenseDatas[4][3] = row.plateInvalidated == 1
		licenseDatas[5][3] = row.colorsInvalidated == 1
		licenseDatas[8][3] = row.driveTypeInvalidated == 1
		licenseDatas[13][3] = row.engineInvalidated == 1
		licenseDatas[14][3] = row.turboInvalidated == 1
		licenseDatas[15][3] = row.ecuInvalidated == 1
		licenseDatas[16][3] = row.transmissionInvalidated == 1
		licenseDatas[17][3] = row.suspensionInvalidated == 1
		licenseDatas[18][3] = row.brakeInvalidated == 1
		licenseDatas[19][3] = row.tireInvalidated == 1
		licenseDatas[20][3] = row.weightReductionInvalidated == 1
		licenseDatas[22][3] = row.backfireInvalidated == 1
		licenseDatas[23][3] = row.rideHeightInvalidated == 1
		licenseDatas[24][3] = row.paintjobInvalidated == 1
		licenseDatas[25][3] = row.wheelPaintjobInvalidated == 1
		licenseDatas[26][3] = row.headlightPaintjobInvalidated == 1
		licenseDatas[27][3] = row.lsdDoorInvalidated == 1
		licenseDatas[28][3] = row.nitroInvalidated == 1
		licenseDatas[29][3] = row.spinnerInvalidated == 1
		local x = 80
		local y = 94
		local ly = y
		local h = sightexports.sGui:getFontHeight("11/BebasNeueBold.otf") + 2
		for i = 1, #licenseDatas do
			if licenseDatas[i] == "page" then
				y = y + 12
				ly = y
			elseif licenseDatas[i] == "break" then
				x = 256
				y = ly
			elseif licenseDatas[i] == "hr" then
				x = 80
				local border = sightexports.sGui:createGuiElement("rectangle", x, y, 336, 1, inside)
				sightexports.sGui:setGuiBackground(border, "solid", "#46191a")
				y = y + 1 + 4
				ly = y
			else
				width = sightexports.sGui:getTextWidthFont(licenseDatas[i][1], "11/BebasNeueBold.otf") + 8
				if row.model == "model_s" or row.model == "model_y" or row.model == "leaf" then
					if licenseDatas[i][1] == "Motor" then
						width = sightexports.sGui:getTextWidthFont("Villanymotor", "11/BebasNeueBold.otf") + 8
					elseif licenseDatas[i][1] == "Turbo" then
						width = sightexports.sGui:getTextWidthFont("Akkumulátor", "11/BebasNeueBold.otf") + 8
					elseif licenseDatas[i][1] == "Váltó" then
						width = sightexports.sGui:getTextWidthFont("Inverter", "11/BebasNeueBold.otf") + 8
					end
				end
				local w = width
				local rect = sightexports.sGui:createGuiElement("rectangle", x, y, w, h, inside)
				sightexports.sGui:setGuiBackground(rect, "solid", "#46191a")
				local label = sightexports.sGui:createGuiElement("label", 0, 0, w, h, rect)
				sightexports.sGui:setLabelFont(label, "11/BebasNeueBold.otf")
				sightexports.sGui:setLabelAlignment(label, "center", "center")
				sightexports.sGui:setLabelColor(label, "#c5d8a0")
				if row.model == "model_s" or row.model == "model_y" or row.model == "leaf" then
					if licenseDatas[i][1] == "Motor" then
						sightexports.sGui:setLabelText(label, "Villanymotor")
					elseif licenseDatas[i][1] == "Turbo" then
						sightexports.sGui:setLabelText(label, "Akkumulátor")
					elseif licenseDatas[i][1] == "Váltó" then
						sightexports.sGui:setLabelText(label, "Inverter")
					else
						sightexports.sGui:setLabelText(label, licenseDatas[i][1])
					end
					
				else
					sightexports.sGui:setLabelText(label, licenseDatas[i][1])
				end
				if i == 5 then
					local col = split(row.colors, ",")
					for i = 0, 3 do
						local colorbox = sightexports.sGui:createGuiElement("rectangle", 4 + w + (h + 4) * i, 0, h, h, rect)
						sightexports.sGui:setGuiBackground(colorbox, "solid", {
							(tonumber(col[i * 3 + 1]) or 255) * 0.875,
							(tonumber(col[i * 3 + 2]) or 255) * 0.875,
							(tonumber(col[i * 3 + 3]) or 255) * 0.875
						})
						local colorshine = sightexports.sGui:createGuiElement("image", 4 + w + (h + 4) * i, 0, h, h, rect)
						sightexports.sGui:setImageDDS(colorshine, ":sTrafficlicense/files/shine.dds")
						sightexports.sGui:setImageColor(colorshine, {
							math.min((tonumber(col[i * 3 + 1]) or 255) * 1.1, 255),
							math.min((tonumber(col[i * 3 + 2]) or 255) * 1.1, 255),
							math.min((tonumber(col[i * 3 + 3]) or 255) * 1.1, 255)
						})
					end
				else
					local label = sightexports.sGui:createGuiElement("label", w + 4, 0, w, h, rect)
					sightexports.sGui:setLabelFont(label, "12/IckyticketMono-nKpJ.ttf")
					sightexports.sGui:setLabelAlignment(label, "left", "center")
					sightexports.sGui:setLabelColor(label, "#000000")
					sightexports.sGui:setLabelText(label, licenseDatas[i][2])
				end
				if licenseDatas[i][3] then
					local stamp = sightexports.sGui:createGuiElement("image", math.min(w, 70), h / 2 - 13, 104, 26, rect)
					sightexports.sGui:setImageDDS(stamp, ":sTrafficlicense/files/stamp.dds")
				end
				y = y + h + 4
			end
		end
		local img = sightexports.sGui:createGuiElement("image", 0, 0, 512, 512, inside)
		sightexports.sGui:setImageDDS(img, ":sTrafficlicense/files/fg.dds")
		sightexports.sGui:setImageColor(img, {
			255,
			255,
			255,
			150
		})
	end
end
local h = math.floor(screenY * 0.85 / 2) * 2
local w = math.floor(h * 0.7463 / 2) * 2
local s = h / 946
local x, y = screenX / 2 - w / 2, screenY / 2 - h / 2
local font = false
local font2 = false
local sellPaper = false
local sellButtons = false
local sellPaperSigned = false
function deleteSellPaper()
	deleteTrafficLicense()
	if sellButtons then
		sightexports.sGui:deleteGuiElement(sellButtons)
	end
	sellButtons = false
	if sellPaper then
		removeEventHandler("onClientRender", getRootElement(), renderSellPaper)
	end
	sellPaper = false
	if isElement(font) then
		destroyElement(font)
	end
	font = false
	if isElement(font2) then
		destroyElement(font2)
	end
	font2 = false
	sellPaperSigned = false
	triggerEvent("endVehicleSellingDashboardWindow", localPlayer)
end
local sellButtonPressed = false
addEvent("cancelVehicleSellPaper", false)
addEventHandler("cancelVehicleSellPaper", getRootElement(), function()
	triggerServerEvent("cancelVehicleSell", localPlayer)
	if sellPaper and sellPaper[1] == "seller" then
		triggerEvent("endVehicleSellingDashboardWindow", localPlayer)
	end
	deleteSellPaper()
end)
addEvent("acceptVehicleSellPaper", false)
addEventHandler("acceptVehicleSellPaper", getRootElement(), function()
	if not sellButtonPressed then
		triggerServerEvent("acceptVehicleSell", localPlayer)
		sellButtonPressed = true
	end
end)
addEvent("vehicleSellAcceptResponse", true)
addEventHandler("vehicleSellAcceptResponse", getRootElement(), function(response)
	if response then
		sellPaperSigned = getTickCount()
		playSound("files/sign.mp3")
		if sellButtons then
			sightexports.sGui:deleteGuiElement(sellButtons)
		end
		sellButtons = false
	else
		sellButtonPressed = false
	end
end)
addEvent("gotVehicleSellPaper", true)
addEventHandler("gotVehicleSellPaper", getRootElement(), function(paper, license)
	if paper and not sellPaperSigned then
		if sellPaper and not sellPaper[2] and paper[2] then
			return
		end
		playSound("files/paper.mp3")
		if not sellPaper then
			font = dxCreateFont("files/lunabar.ttf", 17, false, "antialiased")
			font2 = dxCreateFont("files/hand.otf", 14, false, "antialiased")
			addEventHandler("onClientRender", getRootElement(), renderSellPaper, true, "low-999999999999")
		end
		sellButtonPressed = false
		sellPaperSigned = false
		sellPaper = paper
		sellPaper[4] = sightexports.sGui:thousandsStepper(tonumber(sellPaper[4]) or 0)
		sellPaper[5] = sightexports.sGui:thousandsStepper(tonumber(sellPaper[5]) or 0)
		sellPaper[9] = sightexports.sGui:thousandsStepper(tonumber(sellPaper[9]) or 0)
		sellPaper[11] = sightexports.sVehiclenames:getCustomVehicleName(sellPaper[11])
		local time = getRealTime(sellPaper[12])
		sellPaper[12] = string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
		if license then
			x = screenX / 2 - (w + 352) / 2
			createTrafficLicense(license, x + w - 64)
		else
			x = screenX / 2 - w / 2
		end
		if sellButtons then
			sightexports.sGui:deleteGuiElement(sellButtons)
		end
		sellButtons = false
		if not sellPaper[2] then
			sellButtons = sightexports.sGui:createGuiElement("null", x + w / 2 - 154, y + h * 0.96, 308, 24)
			local btn = sightexports.sGui:createGuiElement("button", 0, 0, 150, 24, sellButtons)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightred",
				"sightred-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
			sightexports.sGui:setButtonTextColor(btn, "#ffffff")
			sightexports.sGui:setButtonText(btn, "Mégsem")
			sightexports.sGui:setClickEvent(btn, "cancelVehicleSellPaper")
			local btn = sightexports.sGui:createGuiElement("button", 158, 0, 150, 24, sellButtons)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
			sightexports.sGui:setButtonTextColor(btn, "#ffffff")
			sightexports.sGui:setButtonText(btn, "Szerződés aláírása")
			sightexports.sGui:setClickEvent(btn, "acceptVehicleSellPaper")
		end
	else
		deleteSellPaper()
	end
end)
function renderSellPaper()
	local penc = tocolor(57, 70, 126, 255)
	if sellPaper[2] then
		sightlangStaticImageUsed[0] = true
		if sightlangStaticImageToc[0] then
			processsightlangStaticImage[0]()
		end
		dxDrawImage(x, y, w, h, sightlangStaticImage[0])
		if sellPaper[1] == "buyer" then
			sightlangStaticImageUsed[1] = true
			if sightlangStaticImageToc[1] then
				processsightlangStaticImage[1]()
			end
			dxDrawImage(x, y, w, h, sightlangStaticImage[1])
		else
			sightlangStaticImageUsed[2] = true
			if sightlangStaticImageToc[2] then
				processsightlangStaticImage[2]()
			end
			dxDrawImage(x, y, w, h, sightlangStaticImage[2])
			penc = tocolor(25, 19, 33, 225)
		end
	else
		sightlangStaticImageUsed[3] = true
		if sightlangStaticImageToc[3] then
			processsightlangStaticImage[3]()
		end
		dxDrawImage(x, y, w, h, sightlangStaticImage[3])
		sightlangStaticImageUsed[0] = true
		if sightlangStaticImageToc[0] then
			processsightlangStaticImage[0]()
		end
		dxDrawImage(x, y, w, h, sightlangStaticImage[0])
		sightlangStaticImageUsed[4] = true
		if sightlangStaticImageToc[4] then
			processsightlangStaticImage[4]()
		end
		dxDrawImage(x, y, w, h, sightlangStaticImage[4])
		sightlangStaticImageUsed[1] = true
		if sightlangStaticImageToc[1] then
			processsightlangStaticImage[1]()
		end
		dxDrawImage(x, y, w, h, sightlangStaticImage[1])
	end
	dxDrawText(sellPaper[6], x + w * 0.376, 0, x + w * 0.717, y + h * 0.163, penc, s, font2, "center", "bottom")
	dxDrawText(sellPaper[7], x + w * 0.3, 0, x + w * 0.645, y + h * 0.189, penc, s, font2, "center", "bottom")
	dxDrawText(sellPaper[11], x + w * 0.155, 0, x + w * 0.907, y + h * 0.315, penc, s, font2, "center", "bottom")
	dxDrawText(sellPaper[3], x + w * 0.241, 0, x + w * 0.494, y + h * 0.366, penc, s, font2, "center", "bottom")
	dxDrawText(sellPaper[9] .. " km", x + w * 0.227, 0, x + w * 0.494, y + h * 0.418, penc, s, font2, "center", "bottom")
	dxDrawText(sellPaper[8], x + w * 0.687, 0, x + w * 0.907, y + h * 0.366, penc, s, font2, "center", "bottom")
	dxDrawText(sellPaper[10] and "dízel" or "benzin", x + w * 0.626, 0, x + w * 0.907, y + h * 0.418, penc, s, font2, "center", "bottom")
	dxDrawText(sellPaper[4] .. " $", x + w * 0.363, 0, x + w * 0.597, y + h * 0.53, penc, s, font2, "center", "bottom")
	dxDrawText(sellPaper[12], x + w * 0.317, 0, x + w * 0.597, y + h * 0.58, penc, s, font2, "center", "bottom")
	dxDrawText(sellPaper[5] .. " $", x + w * 0.489, 0, x + w * 0.603, y + h * 0.769, penc, s * 0.8, font2, "center", "bottom")
	if sellPaper[2] then
		dxDrawText(sellPaper[6], x + w * 0.107, 0, x + w * 0.417, y + h * 0.897, penc, s, font, "center", "bottom")
		dxDrawText(sellPaper[7], x + w * 0.572, 0, x + w * 0.883, y + h * 0.897, penc, s, font, "center", "bottom")
	elseif sellPaper[1] == "buyer" then
		dxDrawText(sellPaper[6], x + w * 0.107, 0, x + w * 0.417, y + h * 0.897, penc, s, font, "center", "bottom")
		if sellPaperSigned then
			local p = (getTickCount() - sellPaperSigned) / 3580
			local tw = dxGetTextWidth(sellPaper[7], s, font)
			dxDrawText(sellPaper[7], x + w * 0.7275 - tw / 2, 0, x + w * 0.7275 - tw / 2 + tw * p, y + h * 0.897, penc, s, font, "left", "bottom", true)
			if 1.25 <= p then
				if sellPaper[1] == "seller" then
					triggerEvent("endVehicleSellingDashboardWindow", localPlayer)
				end
				deleteSellPaper()
			end
		end
	elseif sellPaperSigned then
		local p = (getTickCount() - sellPaperSigned) / 3580
		local tw = dxGetTextWidth(sellPaper[6], s, font)
		dxDrawText(sellPaper[6], x + w * 0.262 - tw / 2, 0, x + w * 0.262 - tw / 2 + tw * p, y + h * 0.897, penc, s, font, "left", "bottom", true)
		if 1.25 <= p then
			if sellPaper[1] == "seller" then
				triggerEvent("endVehicleSellingDashboardWindow", localPlayer)
			end
			deleteSellPaper()
		end
	end
end
bindKey("e", "down", "adasveteli")
