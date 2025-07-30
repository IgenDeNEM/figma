local sightexports = {
	sGui = false,
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
local processSightlangStaticImage = {}
sightlangStaticImageToc[0] = true
sightlangStaticImageToc[1] = true
local sightlangStatImgPre = nil
function sightlangStatImgPre()
	local now = getTickCount()
	if sightlangStaticImageUsed[0] then
		sightlangStaticImageUsed[0] = false
		sightlangStaticImageDel[0] = false
	elseif sightlangStaticImage[0] then
		if sightlangStaticImageDel[0] then
			if sightlangStaticImageDel[0] <= now then
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
			if sightlangStaticImageDel[1] <= now then
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
		sightlangStaticImage[0] = dxCreateTexture("files/white.dds", "dxt1", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end
processSightlangStaticImage[1] = function()
	if not isElement(sightlangStaticImage[1]) then
		sightlangStaticImageToc[1] = false
		sightlangStaticImage[1] = dxCreateTexture("files/stripe.dds", "dxt1", true)
	end
	if not sightlangStatImgHand then
		sightlangStatImgHand = true
		addEventHandler("onClientPreRender", getRootElement(), sightlangStatImgPre, true, "high+999999999")
	end
end

function getVehicleModel(veh)
	return getElementData(veh, "vehicle.customModel") or getElementModel(veh)
end
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		refreshVehDatas()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
local sightlangCondHandlState1 = false
local function checkPreRenderStripes(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState1 then
		sightlangCondHandlState1 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), preRenderStripes, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), preRenderStripes)
		end
	end
end

local sightlangCondHandlState2 = false
local function checkDoCheckVeh(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState2 then
		sightlangCondHandlState2 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), doCheckVeh, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), doCheckVeh)
		end
	end
end

local seat = getPedOccupiedVehicleSeat(localPlayer)
if seat == 0 then
	veh = getPedOccupiedVehicle(localPlayer)
else
	veh = false
end
local trailer = false
local currentTankMineId = false
local currentOrderMineId = false
local tankWindow = false
local mineCols = {}
addEvent("closeMineTrailerPrompt", false)
addEventHandler("closeMineTrailerPrompt", getRootElement(), function()
	if tankWindow then
		sightexports.sGui:deleteGuiElement(tankWindow)
	end
	tankWindow = nil
end)
addEvent("giveBackMineTank", false)
addEventHandler("giveBackMineTank", getRootElement(), function()
	local veh = getPedOccupiedVehicle(localPlayer)
	triggerServerEvent("returnMineFuelTank", exports.sWorkaround:getAttachedTrailer(veh))
end)
function mineColLeave(hitElement)
	if hitElement == veh then
		if tankWindow then
			sightexports.sGui:deleteGuiElement(tankWindow)
		end
		tankWindow = nil
	end
end
local currentMarkedMine = false
function markMine(mineId)
	currentMarkedMine = mineId
	refreshMarkersAndBlips()
end
function mineColHit(hitElement)
	if hitElement == localPlayer and currentMarkedMine then
		local lobby, corridor, door = getLobbyFromMineId(currentMarkedMine)
		if door == mineCols[source] and loadedMineLobby == getCorridorIdFromLobbyCorridor(lobby, corridor) then
			markMine()
		end
	elseif hitElement == veh and trailer and currentTankMineId then
		local lobby, corridor, door = getLobbyFromMineId(currentTankMineId)
		if door == mineCols[source] and loadedMineLobby == getCorridorIdFromLobbyCorridor(lobby, corridor) then
			setElementData(veh, "vehicle.gear", "N")
			if tankWindow then
				sightexports.sGui:deleteGuiElement(tankWindow)
			end
			tankWindow = nil
			local w = 300
			local h = 150
			tankWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
			sightexports.sGui:setWindowTitle(tankWindow, "16/BebasNeueRegular.otf", "Üzemanyagtartály")
			local titlebarHeight = sightexports.sGui:getTitleBarHeight()
			local label = sightexports.sGui:createGuiElement("label", 0, titlebarHeight, w, h - titlebarHeight - 30 - 6 - 6, tankWindow)
			sightexports.sGui:setLabelAlignment(label, "center", "center")
			sightexports.sGui:setLabelText(label, "Szeretnéd visszavinni a tartályt\na bányába?")
			sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
			local btnW = (w - 18) / 2
			local btn = sightexports.sGui:createGuiElement("button", 6, h - 30 - 6, btnW, 30, tankWindow)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonText(btn, "Igen")
			sightexports.sGui:setClickEvent(btn, "giveBackMineTank")
			local btn = sightexports.sGui:createGuiElement("button", w - btnW - 6, h - 30 - 6, btnW, 30, tankWindow)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightred",
				"sightred-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonText(btn, "Nem")
			sightexports.sGui:setClickEvent(btn, "closeMineTrailerPrompt")
		end
	end
end

function handleMineColShapeEnter(hitElement, matchDim)
	if matchDim and hitElement == localPlayer then
		if currentOrderMineId then
			if mineColShapes[source] == currentOrderMineId then
				triggerServerEvent("deliverMineOrder", localPlayer, currentOrderMineId)
			end
		elseif currentTankMineId then
			if mineColShapes[source] == currentTankMineId then
				mineColLeave()
			end
		elseif tankPreRequest and mineColShapes[source] == tankPreRequest then
			triggerServerEvent("trailerMineTank", localPlayer, tankPreRequest)
		end
	end
end
function handleMineColShapeLeave(hitElement, matchDim)
	if hitElement == source then
		deleteMineTankPrompt()
	end
end


addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	for i = 1, #mineCoords, 1 do
		local x, y, z = unpack(mineCoords[i])
		local colshape = createColSphere(x, y, z, 2.5)
		setElementInterior(colshape, 0)
		addEventHandler("onClientColShapeHit", colshape, mineColHit)
		addEventHandler("onClientColShapeLeave", colshape, mineColLeave)
		mineCols[colshape] = i
	end
end)
function refreshVehDatas()
	checkDoCheckVeh(veh)
	trailer = veh and getElementData(veh, "towCar")
	if trailer and isElement(trailer) then
		currentTankMineId = getElementData(trailer, "mineTankOnTrailer") and getElementData(trailer, "mineTankOnTrailer")[1]
		currentOrderMineId = getElementData(trailer, "mineOrderOnTrailer")
		if currentOrderMineId then
			currentOrderMineId = currentOrderMineId[1]
		else
			currentOrderMineId = false
		end
		if not currentTankMineId then
			if tankWindow then
				sightexports.sGui:deleteGuiElement(tankWindow)
			end
			tankWindow = nil
		end
	else
		currentTankMineId = false
		currentOrderMineId = false
		if tankWindow then
			sightexports.sGui:deleteGuiElement(tankWindow)
		end
		tankWindow = nil
	end
	refreshMarkersAndBlips()
end
function doCheckVeh()
	if getPedOccupiedVehicle(localPlayer) ~= veh then
		veh = false
		refreshVehDatas()
	end
end
addEventHandler("onClientVehicleDataChange", getRootElement(), function(key, old, new)
	if (source == veh or source == trailer) and (key == "mineTankOnTrailer" or key == "mineOrderOnTrailer" or key == "towCar") then
		refreshVehDatas()
	end
end)
addEventHandler("onClientVehicleEnter", getRootElement(), function(ped, seat)
	if ped == localPlayer and seat == 0 then
		veh = source
		refreshVehDatas()
	end
end)
tankPreRequest = false
addEvent("gotMineTankPreRequest", true)
addEventHandler("gotMineTankPreRequest", getRootElement(), function(state)
	tankPreRequest = state
	refreshMarkersAndBlips()
end)
local tankRequestBlip = false
local tankRequestMarker = false
local tankDropOffBlip = false
local tankDropOffMarker = false
local orderBlip = false
local orderLobbyMarker = false
local orderMarkBlip = false
local orderDropOffMarker = false

function refreshMarkersAndBlips()
	if currentMarkedMine then
		local lobby, corridor, door = getLobbyFromMineId(currentMarkedMine)
		local corridorId = getCorridorIdFromLobbyCorridor(lobby, corridor)
		if loadedMineLobby == corridorId then
			local x, y, z, rx, ry = unpack(mineCoords[door])
			if isElement(orderDropOffMarker) then
				setElementPosition(orderDropOffMarker, x, y, z)
				setMarkerColor(orderDropOffMarker, yellow[1], yellow[2], yellow[3], 255)
			else
				orderDropOffMarker = createMarker(x, y, z, "cylinder", 2.5, yellow[1], yellow[2], yellow[3])
			end
			setElementInterior(orderDropOffMarker, 0)
			setElementDimension(orderDropOffMarker, corridorId)
		else
			if isElement(orderDropOffMarker) then
				destroyElement(orderDropOffMarker)
			end
			orderDropOffMarker = nil
		end
		if not loadedMineLobby and not currentMine then
			local x = lobbyCoords[lobby][1]
			local y = lobbyCoords[lobby][2]
			local z = lobbyCoords[lobby][3]
			if isElement(orderMarkBlip) then
				setElementPosition(orderMarkBlip, x, y, z + 1)
				setBlipColor(orderMarkBlip, yellow[1], yellow[2], yellow[3], 255)
			else
				orderMarkBlip = createBlip(x, y, z + 1, 34, 2, yellow[1], yellow[2], yellow[3])
				setElementData(orderMarkBlip, "tooltipText", "Bánya (Megjelölt hely)")
			end
		else
			if isElement(orderMarkBlip) then
				destroyElement(orderMarkBlip)
			end
			orderMarkBlip = nil
		end
	else
		if isElement(orderDropOffMarker) then
			destroyElement(orderDropOffMarker)
		end
		orderDropOffMarker = nil
		if isElement(orderMarkBlip) then
			destroyElement(orderMarkBlip)
		end
		orderMarkBlip = nil
	end
	if tankPreRequest and veh then
		local lobby, corridor, door = getLobbyFromMineId(tankPreRequest)
		local corridorId = getCorridorIdFromLobbyCorridor(lobby, corridor)
		if loadedMineLobby == corridorId then
			local x, y, z, rx, ry = unpack(mineCoords[door])
			if isElement(tankRequestMarker) then
				setElementPosition(tankRequestMarker, x, y, z)
				setMarkerColor(tankRequestMarker, blue[1], blue[2], blue[3], 255)
			else
				tankRequestMarker = createMarker(x, y, z, "cylinder", 2.5, blue[1], blue[2], blue[3])
			end
			setElementInterior(tankRequestMarker, 0)
			setElementDimension(tankRequestMarker, corridorId)
		else
			if isElement(tankRequestMarker) then
				destroyElement(tankRequestMarker)
			end
			tankRequestMarker = nil
		end
		if not loadedMineLobby and not currentMine then
			local x = lobbyCoords[lobby][1]
			local y = lobbyCoords[lobby][2]
			local z = lobbyCoords[lobby][3]
			if isElement(tankRequestBlip) then
				setElementPosition(tankRequestBlip, x, y, z + 1)
				setBlipColor(tankRequestBlip, blue[1], blue[2], blue[3], 255)
			else
				tankRequestBlip = createBlip(x, y, z + 1, 34, 2, blue[1], blue[2], blue[3])
				setElementData(tankRequestBlip, "tooltipText", "Bánya (Üzemanyagtartály)")
			end
		else
			if isElement(tankRequestBlip) then
				destroyElement(tankRequestBlip)
			end
			tankRequestBlip = nil
		end
	else
		if isElement(tankRequestMarker) then
			destroyElement(tankRequestMarker)
		end
		tankRequestMarker = nil
		if isElement(tankRequestBlip) then
			destroyElement(tankRequestBlip)
		end
		tankRequestBlip = nil
	end
	if currentTankMineId then
		local lobby, corridor, door = getLobbyFromMineId(currentTankMineId)
		local corridorId = getCorridorIdFromLobbyCorridor(lobby, corridor)
		if loadedMineLobby == corridorId then
			local x, y, z, rx, ry = unpack(mineCoords[door])
			if isElement(tankDropOffMarker) then
				setElementPosition(tankDropOffMarker, x, y, z)
				setMarkerColor(tankDropOffMarker, blue[1], blue[2], blue[3], 255)
			else
				tankDropOffMarker = createMarker(x, y, z, "cylinder", 2.5, blue[1], blue[2], blue[3])
			end
			setElementInterior(tankDropOffMarker, 0)
			setElementDimension(tankDropOffMarker, corridorId)
		else
			if isElement(tankDropOffMarker) then
				destroyElement(tankDropOffMarker)
			end
			tankDropOffMarker = nil
		end
		if not loadedMineLobby and not currentMine then
			local x = lobbyCoords[lobby][1]
			local y = lobbyCoords[lobby][2]
			local z = lobbyCoords[lobby][3]
			if isElement(tankDropOffBlip) then
				setElementPosition(tankDropOffBlip, x, y, z + 1)
				setBlipColor(tankDropOffBlip, blue[1], blue[2], blue[3], 255)
			else
				tankDropOffBlip = createBlip(x, y, z + 1, 34, 2, blue[1], blue[2], blue[3])
				setElementData(tankDropOffBlip, "tooltipText", "Bánya (Üzemanyagtartály)")
			end
		else
			if isElement(tankDropOffBlip) then
				destroyElement(tankDropOffBlip)
			end
			tankDropOffBlip = nil
		end
	else
		if isElement(tankDropOffMarker) then
			destroyElement(tankDropOffMarker)
		end
		tankDropOffMarker = nil
		if isElement(tankDropOffBlip) then
			destroyElement(tankDropOffBlip)
		end
		tankDropOffBlip = nil
	end
	if currentOrderMineId then
		local lobby, corridor, door = getLobbyFromMineId(currentOrderMineId)
		local corridorId = getCorridorIdFromLobbyCorridor(lobby, corridor)
		if loadedMineLobby == corridorId then
			local x, y, z, rx, ry = unpack(mineCoords[door])
			if isElement(orderLobbyMarker) then
				setElementPosition(orderLobbyMarker, x, y, z)
				setMarkerColor(orderLobbyMarker, green[1], green[2], green[3], 255)
			else
				iprint("order van")
				orderLobbyMarker = createMarker(x, y, z, "cylinder", 2.5, green[1], green[2], green[3])
			end
			setElementInterior(orderLobbyMarker, 0)
			setElementDimension(orderLobbyMarker, corridorId)
		else
			if isElement(orderLobbyMarker) then
				destroyElement(orderLobbyMarker)
			end
			orderLobbyMarker = nil
		end
		if not loadedMineLobby and not currentMine then
			local x = lobbyCoords[lobby][1]
			local y = lobbyCoords[lobby][2]
			local z = lobbyCoords[lobby][3]
			if isElement(orderBlip) then
				setElementPosition(orderBlip, x, y, z + 1)
				setBlipColor(orderBlip, green[1], green[2], green[3], 255)
			else
				orderBlip = createBlip(x, y, z + 1, 34, 2, green[1], green[2], green[3])
				setElementData(orderBlip, "tooltipText", "Bánya (Rendelés)")
			end
		else
			if isElement(orderBlip) then
				destroyElement(orderBlip)
			end
			orderBlip = nil
		end
	else
		if isElement(orderLobbyMarker) then
			destroyElement(orderLobbyMarker)
		end
		orderLobbyMarker = nil
		if isElement(orderBlip) then
			destroyElement(orderBlip)
		end
		orderBlip = nil
	end
	forceTabletDraw = true
end
function isCorridorMarked(lobby, mineId)
	local id = getLobbyMineBaseId(lobby, mineId)
	if currentOrderMineId and id < currentOrderMineId and currentOrderMineId <= id + 32 then
		return "sightgreen"
	end
	if tankPreRequest and id < tankPreRequest and tankPreRequest <= id + 32 then
		return "sightblue"
	end
	if currentTankMineId and id < currentTankMineId and currentTankMineId <= id + 32 then
		return "sightblue"
	end
	if currentMarkedMine and id < currentMarkedMine and currentMarkedMine <= id + 32 then
		return "sightyellow"
	end
end
local streamedTrailers = {}
local streamedTankObjects = {}
local streamedOrderObjects = {}
function processTankData(trailer, state)
	if state then
		if not isElement(streamedTankObjects[trailer]) then
			streamedTankObjects[trailer] = createObject(modelIds.v4_mine_tank, 0, 0, 0)
		end
		setElementCollisionsEnabled(streamedTankObjects[trailer], false)
		setElementDimension(streamedTankObjects[trailer], getElementDimension(trailer))
		setElementInterior(streamedTankObjects[trailer], getElementInterior(trailer))
		attachElements(streamedTankObjects[trailer], trailer, 0, 0.3298, 0.0051, 0, 0, 0)
	else
		if isElement(streamedTankObjects[trailer]) then
			destroyElement(streamedTankObjects[trailer])
		end
		streamedTankObjects[trailer] = nil
	end
end
function processOrderData(trailer, orderDatas)
	if streamedOrderObjects[trailer] then
		for i in pairs(streamedOrderObjects[trailer]) do
			if isElement(streamedOrderObjects[trailer][i]) then
				destroyElement(streamedOrderObjects[trailer][i])
			end
			streamedOrderObjects[trailer][i] = nil
		end
	end
	streamedOrderObjects[trailer] = nil
	iprint(orderDatas)
	if orderDatas then
		streamedOrderObjects[trailer] = {}
		for i = 2, #orderDatas, 1 do
			local id = orderDatas[i]
			local j = i - 1
			if trailerOffsets[id] and trailerOffsets[id][j] then
				local orderType, x, y, z, rx, ry, rz = unpack(trailerOffsets[id][j])
				local obj = createObject(modelIds[orderType], 0, 0, 0)
				setElementCollisionsEnabled(obj, false)
				setElementDimension(obj, getElementDimension(trailer))
				setElementInterior(obj, getElementInterior(trailer))
				attachElements(obj, trailer, x, y, z, rx, ry, rz)
				table.insert(streamedOrderObjects[trailer], obj)
			end
		end
	end
end
function trailerDimensionChange(old, new)
	if isElement(streamedTankObjects[veh]) then
		setElementDimension(streamedTankObjects[veh], new)
		if streamedOrderObjects[veh] then
			for i in pairs(streamedOrderObjects[veh]) do
				setElementDimension(streamedOrderObjects[veh][i], new)
			end
		end
	end
end
function trailerInteriorChange(old, new)
	if isElement(streamedTankObjects[veh]) then
		setElementInterior(streamedTankObjects[veh], new)
		if streamedOrderObjects[veh] then
			for i in pairs(streamedOrderObjects[veh]) do
				setElementInterior(streamedOrderObjects[veh][i], new)
			end
		end
	end
end
function destroyTrailerObjects(trailer)
	if isElement(streamedTankObjects[trailer]) then
		destroyElement(streamedTankObjects[trailer])
	end
	streamedTankObjects[trailer] = nil
	if streamedOrderObjects[trailer] then
		for i in pairs(streamedOrderObjects[trailer]) do
			if isElement(streamedOrderObjects[trailer][i]) then
				destroyElement(streamedOrderObjects[trailer][i])
			end
			streamedOrderObjects[trailer][i] = nil
		end
	end
	streamedOrderObjects[trailer] = nil
end
function trailerDataChange(key, old, new)
	if key == "mineTankOnTrailer" then
		processTankData(source, new)
	elseif key == "mineOrderOnTrailer" then
		processOrderData(source, new)
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	local streamedInVehicles = getElementsByType("vehicle", getRootElement(), true)
	for i = 1, #streamedInVehicles, 1 do
		if getVehicleModel(streamedInVehicles[i]) == 611 and not streamedTrailers[streamedInVehicles[i]] then
			addEventHandler("onClientElementDataChange", streamedInVehicles[i], trailerDataChange)
			addEventHandler("onClientElementDimensionChange", streamedInVehicles[i], trailerDimensionChange)
			addEventHandler("onClientElementInteriorChange", streamedInVehicles[i], trailerInteriorChange)
			processTankData(streamedInVehicles[i], getElementData(streamedInVehicles[i], "mineTankOnTrailer"))
			processOrderData(streamedInVehicles[i], getElementData(streamedInVehicles[i], "mineOrderOnTrailer"))
			streamedTrailers[streamedInVehicles[i]] = true
		end
	end
end)
addEventHandler("onClientVehicleStreamIn", getRootElement(), function()
	if getVehicleModel(source) == 611 and not streamedTrailers[source] then
		addEventHandler("onClientElementDataChange", source, trailerDataChange)
		addEventHandler("onClientElementDimensionChange", source, trailerDimensionChange)
		addEventHandler("onClientElementInteriorChange", source, trailerInteriorChange)
		processTankData(source, getElementData(source, "mineTankOnTrailer"))
		processOrderData(source, getElementData(source, "mineOrderOnTrailer"))
		streamedTrailers[source] = true
	end
end)
addEventHandler("onClientVehicleStreamOut", getRootElement(), function()
	if streamedTrailers[source] then
		removeEventHandler("onClientElementDataChange", source, trailerDataChange)
		removeEventHandler("onClientElementDimensionChange", source, trailerDimensionChange)
		removeEventHandler("onClientElementInteriorChange", source, trailerInteriorChange)
		streamedTrailers[source] = nil
		destroyTrailerObjects(source)
	end
end)
addEventHandler("onClientVehicleDestroy", getRootElement(), function()
	if streamedTrailers[source] then
		removeEventHandler("onClientElementDataChange", source, trailerDataChange)
		removeEventHandler("onClientElementDimensionChange", source, trailerDimensionChange)
		removeEventHandler("onClientElementInteriorChange", source, trailerInteriorChange)
		streamedTrailers[source] = nil
		destroyTrailerObjects(source)
	end
end)
local orderNpcs = {}
function preRenderStripes()
	sightlangStaticImageUsed[0] = true
	if sightlangStaticImageToc[0] then
		processSightlangStaticImage[0]()
	end
	sightlangStaticImageUsed[1] = true
	if sightlangStaticImageToc[1] then
		processSightlangStaticImage[1]()
	end
	local refresh = true
	for i = 1, #orderPoses, 1 do
		local x, y, z, w, h, col, pickUpCol = unpack(orderPoses[i])
		if isElementWithinColShape(localPlayer, col) then
			refresh = false
			local color = tocolor(255, 255, 255)
			if trailer then
				if isElementWithinColShape(trailer, pickUpCol) then
					color = greenToColor or redToColor
				else
					color = redToColor
				end
			else
				local vehs = getElementsWithinColShape(orderPoses[i][7], "vehicle")
				for i = 1, #vehs, 1 do
					if getVehicleModel(vehs[i]) == 611 then
						color = greenToColor
						break
					end
				end
			end
			dxDrawMaterialLine3D(x, y + 0.1, z, x, y + h - 0.1, z, sightlangStaticImage[0], 0.2, color, x, y + h / 2, z + 1)
			dxDrawMaterialLine3D(x + w, y + 0.1, z, x + w, y + h - 0.1, z, sightlangStaticImage[0], 0.2, color, x + w, y + h / 2, z + 1)
			dxDrawMaterialLine3D(x - 0.1, y, z, x + w + 0.1, y, z, sightlangStaticImage[0], 0.2, color, x + w / 2, y, z + 1)
			dxDrawMaterialLine3D(x - 0.1, y + h, z, x + w + 0.1, y + h, z, sightlangStaticImage[0], 0.2, color, x + w / 2, y + h, z + 1)
			dxDrawMaterialSectionLine3D(x + w / 2, y + 0.1, z, x + w / 2, y + h - 0.1, z, 0, 0, w * 2 * 64, h * 2 * 64, sightlangStaticImage[1], w - 0.2, color, x + w / 2, y + h / 2, z + 1)
		end
	end
	if refresh then
		checkPreRenderStripes(false)
	end
end

function orderColHit()
	checkPreRenderStripes(true)
end

local orderPayWindow = false
local orderWindow = false
local currentOrderNpc = false
function createMineOrderWindow(orders)
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local w = 350
	local h = titleBarHeight
	if orders then
		h = h + math.max(#orders, 1) * 48
	else
		h = h + 96
	end
	if orderWindow then
		sightexports.sGui:deleteGuiElement(orderWindow)
	end
	orderWindow = nil
	if orderPayWindow then
		sightexports.sGui:deleteGuiElement(orderPayWindow)
	end
	orderPayWindow = nil
	orderWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
	sightexports.sGui:setWindowTitle(orderWindow, "16/BebasNeueRegular.otf", "Rendelésátvétel")
	sightexports.sGui:setWindowCloseButton(orderWindow, "closeMineOrderWindow")
	sightexports.sGui:setWindowElementMaxDistance(orderWindow, currentOrderNpc, 2.5, "closeMineOrderWindow")
	if orders then
		if #orders >= 1 then
			local y = titleBarHeight
			for i = 1, #orders, 1 do
				local isPP = orders[i].isPremium
				if isPP then
					color = "sightblue"
				else
					color = "sightgreen"
				end
				if not orders[i].inTransit then
					local btn = sightexports.sGui:createGuiElement("button", w - 32 - 8, y + 8, 32, 32, orderWindow)
					if orders[i].isPaid then
						sightexports.sGui:setGuiBackground(btn, "solid", "sightblue")
						sightexports.sGui:setGuiHover(btn, "gradient", {
							"sightblue",
							"sightblue-second"
						}, false, true)
						sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
						sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("box-open", 32))
						sightexports.sGui:guiSetTooltip(btn, "Rendelés felrakodása")
						sightexports.sGui:setClickEvent(btn, "trailerMineOrder")
					else
						sightexports.sGui:setGuiBackground(btn, "solid", color)
						sightexports.sGui:setGuiHover(btn, "gradient", {
							color,
							color .. "-second"
						}, false, true)
						sightexports.sGui:setButtonFont(btn, "14/BebasNeueBold.otf")
						sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("cash-register", 32))
						sightexports.sGui:guiSetTooltip(btn, "Rendelés kifizetése")
						sightexports.sGui:setClickEvent(btn, "payMineOrder")
					end
					sightexports.sGui:setClickArgument(btn, orders[i])
				end
				local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, orderWindow)
				sightexports.sGui:setLabelAlignment(label, "left", "center")
				sightexports.sGui:setLabelColor(label, "sightyellow")
				sightexports.sGui:setLabelFont(label, "11/Ubuntu-B.ttf")
				sightexports.sGui:setLabelText(label, "(" .. orders[i].mineId .. ") " .. orders[i].mineName)
				y = y + 24
				local label = sightexports.sGui:createGuiElement("label", 8, y, 0, 24, orderWindow)
				sightexports.sGui:setLabelAlignment(label, "left", "center")
				sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
				if orders[i].isPaid then
					text = " #ffffff(fizetve)"
				else
					text = ""
				end
				sightexports.sGui:setLabelText(label, "[color=" .. color .. "]" .. orders[i].totalPrice .. text)
				y = y + 24
				if i < #orders then
					sightexports.sGui:createGuiElement("hr", 8, y - 1, w - 16, 2, orderWindow)
				end
			end
		else
			local y = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, w, h - titleBarHeight, orderWindow)
			sightexports.sGui:setLabelAlignment(y, "center", "center")
			sightexports.sGui:setLabelColor(y, "sightlightgrey")
			sightexports.sGui:setLabelFont(y, "11/Ubuntu-LI.ttf")
			sightexports.sGui:setLabelText(y, "Nincs aktív megrendelés.")
		end
	else
		local y = sightexports.sGui:createGuiElement("image", w / 2 - 24, titleBarHeight + (h - titleBarHeight) / 2 - 24, 48, 48, orderWindow)
		sightexports.sGui:setImageFile(y, sightexports.sGui:getFaIconFilename("circle-notch", 48))
		sightexports.sGui:setImageSpinner(y, true)
	end
end
addEvent("payMineOrderFinal", true)
addEventHandler("payMineOrderFinal", getRootElement(), function(_, _, _, _, _, datas)
	createMineOrderWindow()
	triggerServerEvent("payMineOrder", localPlayer, datas)
	
	if not datas.isPaid then
		triggerLatentServerEvent("payMineOrder", localPlayer, datas.mineId)
	else
		triggerLatentServerEvent("trailerMineOrder", localPlayer, datas.mineId, datas.trailerId)
	end
end)
addEvent("payMineOrder", true)
addEventHandler("payMineOrder", getRootElement(), function(_, _, _, _, _, orderDatas)
	if orderPayWindow then
		sightexports.sGui:deleteGuiElement(orderPayWindow)
	end
	orderPayWindow = nil
	local w = 360
	local h = 170
	orderPayWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
	sightexports.sGui:setWindowTitle(orderPayWindow, "16/BebasNeueRegular.otf", "Rendelés kifizetése")
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, w, h - titleBarHeight - 30 - 6 - 6, orderPayWindow)
	sightexports.sGui:setLabelAlignment(label, "center", "center")
	local isPP = orderDatas.isPremium
	if isPP then
		color = "sightblue"
	else
		color = "sightgreen"
	end
	sightexports.sGui:setLabelText(label, "Biztosan szeretnéd kifizetni?\n\nRendelés: [color=sightyellow](" .. orderDatas.mineId .. ") " .. orderDatas.mineName .. "#ffffff\nFizetendő: " .. "[color=" .. color .. "]" .. orderDatas.totalPrice)
	sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
	btnW = (w - 18) / 2
	local btn = sightexports.sGui:createGuiElement("button", 6, h - 30 - 6, btnW, 30, orderPayWindow)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(btn, "Igen")
	sightexports.sGui:setClickEvent(btn, "payMineOrderFinal")
	sightexports.sGui:setClickArgument(btn, orderDatas)
	btn = sightexports.sGui:createGuiElement("button", w - btnW - 6, h - 30 - 6, btnW, 30, orderPayWindow)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightred",
		"sightred-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(btn, "Nem")
	sightexports.sGui:setClickEvent(btn, "closeMineOrderPrompt")
end)
addEvent("trailerMineOrderFinal", true)
addEventHandler("trailerMineOrderFinal", getRootElement(), function(_, _, _, _, _, datas)
	createMineOrderWindow()
	triggerServerEvent("trailerMineOrder", localPlayer, datas[1], datas[2])
end)
addEvent("trailerMineOrder", true)
addEventHandler("trailerMineOrder", getRootElement(), function(_, _, _, _, _, datas)
	if orderPayWindow then
		sightexports.sGui:deleteGuiElement(orderPayWindow)
	end
	orderPayWindow = nil
	local foundTrailer = false
	local elements = getElementsWithinColShape(orderPoses[orderNpcs[currentOrderNpc]][7], "vehicle")
	for i = 1, #elements, 1 do
		if getVehicleModel(elements[i]) == 611 then
			foundTrailer = elements[i]
			break
		end
	end
	if foundTrailer then
		local plateText = table.concat(split(utf8.upper(getVehiclePlateText(foundTrailer)), "-"), "-")
		local w = 360
		local h = 170
		orderPayWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - w / 2, screenY / 2 - h / 2, w, h)
		sightexports.sGui:setWindowTitle(orderPayWindow, "16/BebasNeueRegular.otf", "Rendelés kifizetése")
		local titleBarHeight = sightexports.sGui:getTitleBarHeight()
		local label = sightexports.sGui:createGuiElement("label", 0, titleBarHeight, w, h - titleBarHeight - 30 - 6 - 6, orderPayWindow)
		sightexports.sGui:setLabelAlignment(label, "center", "center")
		sightexports.sGui:setLabelText(label, "Biztosan szeretnéd felrakodni?\n\nRendelés: [color=sightyellow](" .. datas.mineId .. ") " .. datas.mineName .. "#ffffff\nRendszám: " .. "[color=sightblue]" .. plateText)
		sightexports.sGui:setLabelFont(label, "11/Ubuntu-R.ttf")
		local btnW = (w - 18) / 2
		local btn = sightexports.sGui:createGuiElement("button", 6, h - 30 - 6, btnW, 30, orderPayWindow)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(btn, "Igen")
		sightexports.sGui:setClickEvent(btn, "trailerMineOrderFinal")
		sightexports.sGui:setClickArgument(btn, {
			datas.mineId,
			foundTrailer
		})
		local btn = sightexports.sGui:createGuiElement("button", w - btnW - 6, h - 30 - 6, btnW, 30, orderPayWindow)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightred",
			"sightred-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(btn, "Nem")
		sightexports.sGui:setClickEvent(btn, "closeMineOrderPrompt")
	else
		sightexports.sGui:showInfobox("e", "Nem áll utánfutó a zónán belül.")
	end
end)

addEvent("gotMineListForOrders", true)
addEventHandler("gotMineListForOrders", getRootElement(), function(data)
	if orderWindow then
		createMineOrderWindow(data)
	end
end)

addEventHandler("onClientClick", getRootElement(), function(button, state, _, _, _, _, _, clickedElement)
	if orderNpcs[clickedElement] and not orderWindow and state == "down" then
		local px, py, pz = getElementPosition(localPlayer)
		local x, y, z = getElementPosition(clickedElement)
		if getDistanceBetweenPoints3D(px, py, pz, x, y, z) < 2.5 then
			currentOrderNpc = clickedElement
			createMineOrderWindow()
			triggerServerEvent("requestMineListForOrders", localPlayer)
		end
	end
end, true, "high+99999999")

addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	for i = 1, #orderPoses, 1 do
		local x, y, z, rx, skinId, name, colX, colY, colZ, colW, colH = unpack(orderPoses[i])
		local ped = createPed(skinId, x, y, z, rx)
		setElementData(ped, "invulnerable", true)
		setElementData(ped, "visibleName", name)
		setElementData(ped, "pedNameType", "Sight Mining Co. rendelésátvétel")
		setElementFrozen(ped, true)
		orderNpcs[ped] = i
		local col = createColSphere(colX + colW / 2, colY + colH / 2, colZ, 50)
		addEventHandler("onClientLocalColShapeHit", col, orderColHit)
		orderPoses[i] = {
			colX,
			colY,
			colZ,
			colW,
			colH,
			col,
			createColCuboid(colX, colY, colZ, colW, colH, 2.5),
			ped
		}
	end
end)

addEvent("closeMineOrderPrompt", false)
addEventHandler("closeMineOrderPrompt", getRootElement(), function()
	if orderPayWindow then
		sightexports.sGui:deleteGuiElement(orderPayWindow)
	end
	orderPayWindow = nil
end)

addEvent("closeMineOrderWindow", false)
addEventHandler("closeMineOrderWindow", getRootElement(), function()
	if orderWindow then
		sightexports.sGui:deleteGuiElement(orderWindow)
	end
	orderWindow = nil
	if orderPayWindow then
		sightexports.sGui:deleteGuiElement(orderPayWindow)
	end
	orderPayWindow = nil
end)
