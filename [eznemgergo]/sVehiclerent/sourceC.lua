local sightexports = {
	sGui = false,
	sMarkers = false,
	sModloader = false,
	sVehiclenames = false,
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

rentalPositions = {
  {
    1560.486328125,
    -2315.5,
    13.546154022217
  }
}

local function seelangrefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		sightgrey = sightexports.sGui:getColorCode("sightgrey1")
		sightgreen = sightexports.sGui:getColorCode("sightgreen")
	end
end

addEventHandler("onGuiRefreshColors", root, seelangrefreshColors)
seelangrefreshColors()

local panelDatas = {}
local rentableVehicles = {}
local rentedVehicles = {}

local function getTableSize(tbl)
	local count = 0
	for _ in pairs(tbl) do
		count = count + 1
	end
	return count
end

local basePanelHeight = 50
local vehicleEntryHeight = 82.5

local screenSize = {guiGetScreenSize()}
local rentMarkers = {}
local rentWindow = false

function destroyRentHandler()
	if rentWindow and exports.sGui:isGuiElementValid(rentWindow) then
		sightexports.sGui:deleteGuiElement(rentWindow)
	end
end

function createRentHandler(giveOffVehicle, isLoading, rentDetails)
	local panelDatas = {
		posX = (screenSize[1] - 380) / 2,
		posY = (screenSize[2] - 120) / 2
	}

	destroyRentHandler()
	rentWindow = sightexports.sGui:createGuiElement("window", panelDatas.posX, panelDatas.posY, 380, 120 + 30 + 30 + 15)
	sightexports.sGui:setWindowTitle(rentWindow, "16/BebasNeueRegular.otf", "Bérlés kezelése")
    sightexports.sGui:setWindowCloseButton(rentWindow, "destroyVehicleRent")
	local barHeight = sightexports.sGui:getTitleBarHeight()

	if isLoading then
		local loadingIcon = sightexports.sGui:createGuiElement("image", (380 / 2) - (48 / 2), (120 / 2) + (48 / 2), 48, 48, rentWindow)
		sightexports.sGui:setImageFile(loadingIcon, sightexports.sGui:getFaIconFilename("circle-notch", 48))
		sightexports.sGui:setImageSpinner(loadingIcon, true)
		return
	end

	local rentTime = nil
	if rentDetails and rentDetails.rentTime then
		local rentHour = rentDetails.rentTime[1] or 0
		local rentMinute = rentDetails.rentTime[2] or 0
		
		local currentTime = getRealTime()
		local currentHour = currentTime.hour
		local currentMinute = currentTime.minute
	
		local rentStartTotalMinutes = (rentHour * 60) + rentMinute
		local currentTotalMinutes = (currentHour * 60) + currentMinute
	
		rentTime = currentTotalMinutes - rentStartTotalMinutes
	
		if rentTime < 0 then
			rentTime = rentTime + (24 * 60)
		end
	end

	if giveOffVehicle then
		local vehiclePlate = rentDetails.vehiclePlate or "ISMERETLEN"
		local vehicleCaution = rentDetails.cautionAmount or 5000

		local rentLabel = sightexports.sGui:createGuiElement("label", 0, barHeight + 20, 380, 120 - barHeight, rentWindow)
		sightexports.sGui:setLabelAlignment(rentLabel, "left", "center")
		sightexports.sGui:setLabelText(rentLabel, [[
			Jármű rendszám
			[color=hudwhite]Bérleti idő
			[color=hudwhite]Kaució
		]])
		sightexports.sGui:setLabelFont(rentLabel, "11/Ubuntu-R.ttf")

		local rentLabel2 = sightexports.sGui:createGuiElement("label", -10, barHeight + 20, 380, 120 - barHeight, rentWindow)
		sightexports.sGui:setLabelAlignment(rentLabel2, "right", "center")
		sightexports.sGui:setLabelText(rentLabel2, string.format([[
			[color=sightgreen]%s
			[color=sightgreen]%s perc
			[color=sightgreen]%i$
		]], vehiclePlate, rentTime, vehicleCaution))
		sightexports.sGui:setLabelFont(rentLabel2, "11/Ubuntu-R.ttf")
		
		local rentLabel3 = sightexports.sGui:createGuiElement("label", 0, barHeight + 5, 380, 120 - barHeight, rentWindow)
		sightexports.sGui:setLabelAlignment(rentLabel3, "center", "top")
		sightexports.sGui:setLabelText(rentLabel3, [[
			Biztosan leszeretnéd adni a járműved?
		]])
		sightexports.sGui:setLabelFont(rentLabel3, "11/Ubuntu-R.ttf")

		local returnButton = sightexports.sGui:createGuiElement("button", 10, barHeight + 75 + 10, 380 - 20, 30, rentWindow)
		sightexports.sGui:setButtonFont(returnButton, "13/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(returnButton, "Leadás")
		sightexports.sGui:setClickEvent(returnButton, "returnVehicle")
		sightexports.sGui:setGuiBackground(returnButton, "solid", "sightred")
		sightexports.sGui:setGuiHover(returnButton, "gradient", {
			"sightred",
			"sightred-second"
		}, false, true)

		local cancelButton = sightexports.sGui:createGuiElement("button", 10, barHeight + 75 + 15 + 30, 380 - 20, 30, rentWindow)
		sightexports.sGui:setButtonFont(cancelButton, "13/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(cancelButton, "Mégsem")
		sightexports.sGui:setClickEvent(cancelButton, "cancelReturn")
		sightexports.sGui:setGuiBackground(cancelButton, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(cancelButton, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
	else
		local rentLabel = sightexports.sGui:createGuiElement("label", 0, barHeight + 30, 380, 120 - barHeight, rentWindow)
		sightexports.sGui:setLabelAlignment(rentLabel, "left", "center")
		sightexports.sGui:setLabelText(rentLabel, [[
			[color=hudwhite]Jármű rendszám
			[color=hudwhite]Bérleti idő
		]])
		sightexports.sGui:setLabelFont(rentLabel, "11/Ubuntu-R.ttf")

		local rentLabel2 = sightexports.sGui:createGuiElement("label", -10, barHeight + 30, 380, 120 - barHeight, rentWindow)
		sightexports.sGui:setLabelAlignment(rentLabel2, "right", "center")
		sightexports.sGui:setLabelText(rentLabel2, string.format([[
			[color=sightgreen]%s
			[color=sightgreen]%s perc
		]], rentDetails.vehiclePlate, rentTime))
		sightexports.sGui:setLabelFont(rentLabel2, "11/Ubuntu-R.ttf")
		
		local priceDetails = {
			color = rentDetails.vehiclePrice == 300 and "#b64ce2" or "[color=sightgreen]",
			currency = rentDetails.vehiclePrice == 300 and " PP" or " $"
		}

		local rentLabel3 = sightexports.sGui:createGuiElement("label", -5, barHeight + 5, 380, 120 - barHeight, rentWindow)
		sightexports.sGui:setLabelAlignment(rentLabel3, "center", "top")
		sightexports.sGui:setLabelText(rentLabel3, string.format([[
			A bérleti időd lejárt! Megszeretnéd hosszabbítani?
			A meghosszabítás ára %s%s%s
		]], priceDetails.color, exports.sGui:thousandsStepper(rentDetails.vehiclePrice), priceDetails.currency))
		sightexports.sGui:setLabelFont(rentLabel3, "11/Ubuntu-R.ttf")

		local yesButton = sightexports.sGui:createGuiElement("button", 10, barHeight + 75 + 10, 380 - 20, 30, rentWindow)
		sightexports.sGui:setButtonFont(yesButton, "13/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(yesButton, "Meghosszabbítás")
		sightexports.sGui:setClickEvent(yesButton, "continueRent")
		sightexports.sGui:setClickArgument(yesButton, "NOTHING")
		sightexports.sGui:setGuiBackground(yesButton, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(yesButton, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)

		local noButton = sightexports.sGui:createGuiElement("button", 10, barHeight + 75 + 15 + 30, 380 - 20, 30, rentWindow)
		sightexports.sGui:setButtonFont(noButton, "13/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(noButton, "Bérlés lemondás")
		sightexports.sGui:setClickEvent(noButton, "stopVehicleRent")
		sightexports.sGui:setClickArgument(noButton, "NOTHING")
		sightexports.sGui:setGuiBackground(noButton, "solid", "sightred")
		sightexports.sGui:setGuiHover(noButton, "gradient", {
			"sightred",
			"sightred-second"
		}, false, true)
	end
end

addEvent("continueRentResponse", true)
addEventHandler("continueRentResponse", getRootElement(), function(continueResponse, overDue)
	if continueResponse then
		exports.sGui:showInfobox("s", "Sikeresen meghosszabítottad a jármű bérleti idejét.")
		destroyVehicleRent()
	else
		if overDue then
			destroyVehicleRent()
			rentedVehicles[localPlayer] = nil
		else
			exports.sGui:showInfobox("e", "Nincs elég fedezeted a bérlés meghosszabításához.")
		end
	end
end)

addEvent("cancelReturn", false)
addEventHandler("cancelReturn", getRootElement(), function()
	destroyVehicleRent()
end)

addEvent("returnVehicle", false)
addEventHandler("returnVehicle", getRootElement(), function()
	destroyVehicleRent()
	triggerServerEvent("cancelVehicleRent", localPlayer)
	rentedVehicles[localPlayer] = nil
end)

addEvent("continueRent", false)
addEventHandler("continueRent", getRootElement(), function()
	triggerServerEvent("continueVehicleRent", localPlayer)
end)

addEvent("stopVehicleRent", false)
addEventHandler("stopVehicleRent", getRootElement(), function()
	triggerServerEvent("stopVehicleRent", localPlayer)
	rentedVehicles[localPlayer] = nil
	destroyVehicleRent()
end)

addEvent("tryToRenewRent", true)
addEventHandler("tryToRenewRent", getRootElement(), function(rentDetails)
	createRentHandler(false, false, rentDetails)
end)

addEvent("gotRentDetails", true)
addEventHandler("gotRentDetails", getRootElement(), function(rentDetails)
	createRentHandler(true, false, rentDetails)
end)

function createVehicleRent()
	local rentedVehicle = getPedOccupiedVehicle(localPlayer) or false
	if rentedVehicles[localPlayer] and rentedVehicle and rentedVehicle == rentedVehicles[localPlayer] then
		createRentHandler(true, true)
		triggerServerEvent("getRentDetails", localPlayer, rentedVehicles[localPlayer])
		return
	end

	if rentedVehicles[localPlayer] then
		exports.sGui:showInfobox("e", "Neked már van egy bérelt járműved! Az új bérlés előtt add le azt!")
		return
	end


	if rentedVehicle and rentedVehicles[localPlayer] ~= rentedVehicle then
		exports.sGui:showInfobox("e", "Szállj ki a járműből bérlés előtt!")
		return
	end

	rentWindow = sightexports.sGui:createGuiElement("window", panelDatas.posX, panelDatas.posY, panelDatas.width, panelDatas.height)
	sightexports.sGui:setWindowTitle(rentWindow, "16/BebasNeueRegular.otf", "Jármű bérlés")
    sightexports.sGui:setWindowCloseButton(rentWindow, "destroyVehicleRent")

	local barHeight = sightexports.sGui:getTitleBarHeight()
	local borderWidth = (panelDatas.width / 4) * 3.5
	local borderX = (panelDatas.width - borderWidth) / 2
	local borderY = (barHeight + 5)
	
	local divider = sightexports.sGui:createGuiElement("hr", borderX, borderY, borderWidth, 2, rentWindow)
	
	local yOffset = barHeight + 10
	
	for vehicleIndex, vehicleData in pairs(rentableVehicles) do
		local nameLabel = sightexports.sGui:createGuiElement("label", 30, yOffset, panelDatas.width - 60, 30, rentWindow)
		sightexports.sGui:setLabelAlignment(nameLabel, "left", "center")
		sightexports.sGui:setLabelText(nameLabel, exports.sVehiclenames:getCustomVehicleName(vehicleData.vehicleModel))
		sightexports.sGui:setLabelFont(nameLabel, "12/Ubuntu-R.ttf")
		
		local priceLabel = sightexports.sGui:createGuiElement("label", 30, yOffset, panelDatas.width - 60, 30, rentWindow)
		sightexports.sGui:setLabelAlignment(priceLabel, "right", "center")
		sightexports.sGui:setLabelText(priceLabel, "Ár: [color=sightgreen]"..vehicleData.vehiclePrice.."$/10p")
		sightexports.sGui:setLabelFont(priceLabel, "10/Ubuntu-R.ttf")
		
		local cautionLabel = sightexports.sGui:createGuiElement("label", 30, yOffset + 20, panelDatas.width - 60, 30, rentWindow)
		sightexports.sGui:setLabelAlignment(cautionLabel, "right", "center")
		sightexports.sGui:setLabelText(cautionLabel, "#5c5c5cKaució: #267553"..vehicleData.cautionAmount.."$")
		sightexports.sGui:setLabelFont(cautionLabel, "9/Ubuntu-R.ttf")

		local vehicleDescription = sightexports.sGui:createGuiElement("label", 30, yOffset + 20, panelDatas.width - 60, 30, rentWindow)
		sightexports.sGui:setLabelAlignment(vehicleDescription, "left", "center")
		sightexports.sGui:setLabelText(vehicleDescription, vehicleData[1])
		sightexports.sGui:setLabelFont(vehicleDescription, "9/Ubuntu-R.ttf")
		sightexports.sGui:setLabelColor(vehicleDescription, "#5c5c5c")
		
		local rentVehicleButton = sightexports.sGui:createGuiElement("button", 30, yOffset + 51, panelDatas.width - 60, 22, rentWindow)
		sightexports.sGui:setButtonFont(rentVehicleButton, "13/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(rentVehicleButton, "Bérlés")
		sightexports.sGui:setClickEvent(rentVehicleButton, "finalizeVehicleRent")
		sightexports.sGui:setClickArgument(rentVehicleButton, vehicleData.vehicleModel)
		
		if vehicleData.isPremium then
			sightexports.sGui:setGuiBackground(rentVehicleButton, "solid", "sightpurple")
			sightexports.sGui:setGuiHover(rentVehicleButton, "gradient", {
				"sightpurple",
				"sightpurple-second"
			}, false, true)
			sightexports.sGui:setLabelText(priceLabel, "Ár: [color=sightpurple]"..vehicleData.vehiclePrice.."PP/10p")
		else
			sightexports.sGui:setGuiBackground(rentVehicleButton, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(rentVehicleButton, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
		end
		
		local divider = sightexports.sGui:createGuiElement("hr", borderX, yOffset + 80, borderWidth, 2, rentWindow)
		
		yOffset = yOffset + vehicleEntryHeight
	end
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	triggerServerEvent("requestRentableVehicles", localPlayer)
	
	for i = 1, #rentMarkers do
		if rentMarkers[i] then
			sightexports.sMarkers:deleteCustomMarker(rentMarkers[i])
		end
	end
	
	local rentMarker = sightexports.sMarkers:createCustomMarker(rentalPositions[1][1], rentalPositions[1][2], rentalPositions[1][3], 0, 0, "sightblue", "car")
	sightexports.sMarkers:setCustomMarkerInterior(rentMarker, "vehicleRental", 1, 3)
	table.insert(rentMarkers, rentMarker)
end)

addEventHandler("onClientResourceStop", resourceRoot, function()
	for i = 1, #rentMarkers do
		if rentMarkers[i] then
			sightexports.sMarkers:deleteCustomMarker(rentMarkers[i])
		end
	end
end)

addEvent("gotRentableVehicles", true)
addEventHandler("gotRentableVehicles", getRootElement(), function(receivedVehicles)
	rentableVehicles = receivedVehicles
	local vehicleCount = getTableSize(rentableVehicles)
	basePanelHeight = 50
	vehicleEntryHeight = 82.5
	
	local panelHeight = basePanelHeight + (vehicleCount * vehicleEntryHeight)
	panelDatas = {
		width = 380,
		height = panelHeight,
		posX = (screenSize[1] - 380) / 2,
		posY = (screenSize[2] - panelHeight) / 2
	}
end)

addEvent("gotRentedVehicle", true)
addEventHandler("gotRentedVehicle", getRootElement(), function(vehicleElement)
	if vehicleElement then
		rentedVehicles[source] = vehicleElement
		exports.sPlate:applyVehiclePlate(vehicleElement)
		destroyVehicleRent()
	end
end)

function getRentedOwner(vehicleElement)
	if vehicleElement and rentedVehicles[localPlayer] == vehicleElement then
		return true
	end
	return false
end

addEvent("finalizeVehicleRent", false)
addEventHandler("finalizeVehicleRent", root, function(_, _, _, _, _, vehicleIdentity)
	triggerServerEvent("tryToRentVehicle", localPlayer, vehicleIdentity)
end)

local openedPanel = false
addEvent("changeEnteredCustomMarker", false)
addEventHandler("changeEnteredCustomMarker", getRootElement(), function(currentMarker)
	if currentMarker and currentMarker == "vehicleRental" and not openedPanel then
		openedPanel = true
		createVehicleRent()
	elseif openedPanel then
		openedPanel = false
		destroyVehicleRent()
	end
end)

function destroyVehicleRent()
	if rentWindow and exports.sGui:isGuiElementValid(rentWindow) then
		sightexports.sGui:deleteGuiElement(rentWindow)
	end
end	
addEvent("destroyVehicleRent", false)
addEventHandler("destroyVehicleRent", getRootElement(), destroyVehicleRent)