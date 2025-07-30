local sightexports = {
	sGroups = false,
	bone_attach = false,
	sChat = false,
	sGui = false,
	sGoldrob = false,
	sModloader = false,
	sPattach = false,
	sControls = false,
	sTickets = false,
	sInteriors = false,
	sFarm = false,
	sPaintshop = false,
	sPumpkin = false,
	sBunny = false,
	sSanta = false,
	sChest = false,
	sGroupcall = false,
	sMetaldetector = false,
	sDrag = false,
	sVehicles = false,
	sCinema = false,
	sLicense = false,
	sDyno = false,
	sWeapons = false,
	sMechanic = false,
	sBag = false,
	sTaxi = false,
	sCompanies = false,
	sPermission = false,
	sFishing = false,
	sLottery = false,
	sHud = false,
	sItems = false,
	sNames = false,
	sMining = false,
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
local sightlangWaiterState0 = false
local function sightlangProcessResWaiters()
	if not sightlangWaiterState0 then
		local res0 = getResourceFromName("sGroups")
		if res0 and getResourceState(res0) == "running" then
			createIllegalItemPeds()
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
local catClosed = false
local catOpen = false
local closeIcon = false
local faTicks = false
local function sightlangGuiRefreshColors()
	local res = getResourceFromName("sGui")
	if res and getResourceState(res) == "running" then
		catClosed = sightexports.sGui:getFaIconFilename("caret-up", 32)
		catOpen = sightexports.sGui:getFaIconFilename("caret-down", 32)
		closeIcon = sightexports.sGui:getFaIconFilename("times", 32)
		faTicks = sightexports.sGui:getFaTicks()
		refreshColors()
	end
end
addEventHandler("onGuiRefreshColors", getRootElement(), sightlangGuiRefreshColors)
addEventHandler("onClientResourceStart", getResourceRootElement(), sightlangGuiRefreshColors)
addEventHandler("refreshFaTicks", getRootElement(), function()
	faTicks = sightexports.sGui:getFaTicks()
end)
local sightlangCondHandlState2 = false
local function sightlangCondHandl2(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState2 then
		sightlangCondHandlState2 = cond
		if cond then
			addEventHandler("onClientKey", getRootElement(), itemListScrollHandler, true, prio)
		else
			removeEventHandler("onClientKey", getRootElement(), itemListScrollHandler)
		end
	end
end
local sightlangCondHandlState1 = false
local function sightlangCondHandl1(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState1 then
		sightlangCondHandlState1 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), renderInsects, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), renderInsects)
		end
	end
end
local sightlangCondHandlState0 = false
local function sightlangCondHandl0(cond, prio)
	cond = cond and true or false
	if cond ~= sightlangCondHandlState0 then
		sightlangCondHandlState0 = cond
		if cond then
			addEventHandler("onClientPreRender", getRootElement(), movePreRender, true, prio)
		else
			removeEventHandler("onClientPreRender", getRootElement(), movePreRender)
		end
	end
end
local inNametagEditMode = false
local inNametagFakeInput = false
local cursor = "normal"
local tooltip = false
local cursorTmp = "normal"
local tooltipTmp = false
local currentRaffle = false
local raffleFont = false
local isNoteCopy = false
local copyLicenseRT = false
local copyLicenseShader = false
grayItemPictures = {}
local currentTab = "main"
local tabHover = false
local illegalItemPeds = {}
function createIllegalItemPeds()
	for i = 1, #illegalItemNpcs do
		local skin, x, y, z, rz, int, dim, group = unpack(illegalItemNpcs[i])
		local ped = createPed(skin, x, y, z, rz)
		setElementDimension(ped, dim)
		setElementInterior(ped, int)
		setElementFrozen(ped, true)
		illegalItemPeds[ped] = group
		local groupName = sightexports.sGroups:getGroupName(group)
		setElementData(ped, "visibleName", "Illegális tárgyak")
		setElementData(ped, "pedNameType", groupName)
		setElementData(ped, "invulnerable", true)
	end
end
screenX, screenY = guiGetScreenSize()
local tempNameTag = false
local renderData = {}
local inventoryState = false
itemsTableState = "player"
itemsTable = {}
itemsTable.player = {}
itemsTable.vehicle = {}
itemsTable.object = {}
function formatSerial(itemId, serial)
	local currentWeaponSerial = tonumber(serial) or 0
	local theType = serialItems[itemId] or "-"
	if itemId == 361 then
		return theType .. currentWeaponSerial
	else
		return "W" .. currentWeaponSerial .. theType
	end
end
local rollTime = false
currentItemInUse = false
currentItemRemainUses = false
currentInventoryElement = localPlayer
local startX, startY = screenX / 2, screenY / 2
local moveWidth, moveHeight = 20, 20
local isMoving = false
local moveDifferenceX, moveDifferenceY = 0, 0
local rectangleWidth = (defaultSettings.slotBoxWidth + 5) * defaultSettings.width + 5
local rectangleHeight = (defaultSettings.slotBoxHeight + 5) * math.floor(defaultSettings.slotLimit / defaultSettings.width) + 33 + 5 + 4 + 5
local currentSlotLimit = defaultSettings.slotLimit
local realSlotLimit = defaultSettings.slotLimit
local currentWeight = 0
local itemCount = 0
function recalcSlot()
	currentSlotLimit = getSlotLimit(itemsTableState, currentInventoryElement)
	realSlotLimit = currentSlotLimit
	if itemsTableState ~= "player" then
		local maxSlot = 0
		for k, v in pairs(itemsTable[itemsTableState]) do
			if maxSlot < v.slot + 1 then
				maxSlot = v.slot + 1
			end
		end
		if maxSlot > currentSlotLimit then
			currentSlotLimit = maxSlot
			currentSlotLimit = math.ceil(currentSlotLimit / 10) * 10
		end
	else
		realSlotLimit = 150
	end
	rectangleHeight = (defaultSettings.slotBoxHeight + 5) * math.floor(currentSlotLimit / defaultSettings.width) + 33 + 5 + 4 + 5
end
local currentMoving = false
local itemMoveDifferenceX, itemMoveDifferenceY = 0, 0
haveMoving = false
local amountBox = false
local currentAmount = 0
local Roboto = false
function formatWeight(kg)
	if kg < 0.25 then
		return kg * 1000 .. " g"
	else
		return kg .. " kg"
	end
end
local exitPosX, exitPosY = 0, 0
local cardState = false
local cardType = "identityCard"
local cardData = {}
local fireworkTime = false
function getPhoneBalance(num)
	for k, v in pairs(itemsTable.player) do
		if v.itemId == 9 and tonumber(v.data1) == num then
			return tonumber(v.data2) or 0
		end
	end
	return 0
end
function getCurrentWeight()
	local tempWeight = 0
	for k, v in pairs(itemsTable.player) do
		if itemList[v.itemId] and v.data3 ~= "airsoft" then
			local baseWeight = itemList[v.itemId][10]
			tempWeight = tempWeight + baseWeight * v.amount
		end
	end
	return tempWeight
end
local weaponHealth = {
	[22] = true,
	[23] = true,
	[24] = true,
	[25] = true,
	[26] = true,
	[27] = true,
	[28] = true,
	[32] = true,
	[29] = true,
	[30] = true,
	[31] = true,
	[33] = true,
	[34] = true
}
function deepcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[deepcopy(orig_key)] = deepcopy(orig_value)
		end
		setmetatable(copy, deepcopy(getmetatable(orig)))
	else
		copy = orig
	end
	return copy
end
local currentlyCrafting = false
local currentCraftingItemTable = {}
local craftingPositions = {}
craftingPositions = {
	[3] = {
		-1883.5910888672,
		-2446.9787597656,
		-3.0813355445862,
		1.75,
		1,
		3
	},
	[4] = {
		-1887.6333251953,
		-2446.9787597656,
		-3.0813355445862,
		1.75,
		1,
		3
	},
	[5] = {
		-1891.5896240234,
		-2446.9787597656,
		-3.0813355445862,
		1.75,
		1,
		3
	},
	[6] = {
		-1895.4907470703,
		-2446.9787597656,
		-3.0813355445862,
		1.75,
		1,
		3
	},
	[7] = {
		-1899.5875488281,
		-2446.9787597656,
		-3.0813355445862,
		1.75,
		1,
		3
	},
	[8] = {
		-1903.6457373046999,
		-2446.9787597656,
		-3.0813355445862,
		1.75,
		1,
		3
	},
	[9] = {
		-1883.5910888672,
		-2442.9787597656,
		-3.0813355445862,
		1.75,
		1,
		3
	},
	[10] = {
		-1887.6333251953,
		-2442.9787597656,
		-3.0813355445862,
		1.75,
		1,
		3
	},
	[11] = {
		-1891.5896240234,
		-2442.9787597656,
		-3.0813355445862,
		1.75,
		1,
		3
	},
	[12] = {
		-1895.4907470703,
		-2442.9787597656,
		-3.0813355445862,
		1.75,
		1,
		3
	},
	[13] = {
		-1899.5875488281,
		-2442.9787597656,
		-3.0813355445862,
		1.75,
		1,
		3
	},
	[14] = {
		-1903.6457373046999,
		-2442.9787597656,
		-3.0813355445862,
		1.75,
		1,
		3
	}
}
local craftingPositionElements = {}
local playerRecipes = {}
local factoryJobID = 5
local playerHasTheJob = getElementData(localPlayer, "char.Job") == factoryJobID
local cardSizeX, cardSizeY = 408, 248
local cardPosX = screenX / 2 - cardSizeX / 2
local cardPosY = screenY / 2 - cardSizeY / 2
local boxSizeX, boxSizeY = 255, 23
local boxStartX = cardPosX + 126
local boxStartY = cardPosY + 68
local boxEndX = boxStartX + boxSizeX
local namePosX = cardPosX + 50 + 126
local namePosY = cardPosY + 76
local homePosX = cardPosX + 65 + 126
local homePosY = cardPosY + 76 + boxSizeY + 2
local idPosX = cardPosX + 80 + 126
local idPosY = homePosY + boxSizeY
local expirePosX = cardPosX + 100 + 126
local expirePosY = idPosY + boxSizeY + 2
local signPosX = cardPosX + 15
local signPosY = cardPosY + 190
local picSizeX, picSizeY = 99, 100
local picPosX = cardPosX + 19
local picPosY = cardPosY + 70
local craftingMenu = {}
local recipesToSort = deepcopy(availableRecipes)
local maxRecipe = 0
for k in pairs(recipesToSort) do
	maxRecipe = math.max(maxRecipe, k)
end
for k = 1, maxRecipe do
	if not recipesToSort[k] then
		recipesToSort[k] = {"null"}
		recipesToSort[k][6] = "null"
	end
	recipesToSort[k].id = k
	for k2 = 2, 5 do
		recipesToSort[k][k2] = nil
	end
end
table.sort(recipesToSort, function(a, b)
	if not a then
		return false
	end
	if not b then
		return false
	end
	return a[6] < b[6] or a[6] == b[6] and a[1] < b[1]
end)
local categoriesAdded = {}
local categoryCollapsed = {}
local currentCaregory = false
for k = 1, maxRecipe do
	if recipesToSort[k][1] ~= "null" then
		if not categoriesAdded[recipesToSort[k][6]] then
			categoriesAdded[recipesToSort[k][6]] = true
			categoryCollapsed[recipesToSort[k][6]] = false
			table.insert(craftingMenu, {
				"category",
				recipesToSort[k][6],
				categoryCollapsed[recipesToSort[k][6]]
			})
			currentCaregory = #craftingMenu
		end
		if craftingMenu[currentCaregory][3] then
			table.insert(craftingMenu, {
				"recipe",
				recipesToSort[k].id
			})
		end
	end
end
local craftingRequested = false
local currentCraftingPosition = false
local currentRecipe = {}
local canCraft = false
local craftingItem = false
local selectedCraftingRecipe = false
local hoveringItem = false
local hoveringCategory = false
local recipesOffset = 0
addEvent("addSprayToPlayer", true)
addEventHandler("addSprayToPlayer", getRootElement(), function()
	if isElement(source) then
		local effect = createEffect("spraycan", 0, 0, 0)
		setEffectDensity(effect, 2)
		setTimer(destroyElement, 10000, 1, effect)
	end
end)
addEvent("loadItems", true)
addEventHandler("loadItems", getRootElement(), function(tableElement, insertType, openElement, openIt)
	if tableElement and type(tableElement) == "table" then
		itemsTable[insertType] = {}
		for k, v in pairs(tableElement) do
			addItem(tostring(insertType), v.dbID, v.slot, v.itemId, v.amount, v.data1, v.data2, v.data3, v.nameTag, v.serial)
		end
		if openIt then
			toggleInventory(false)
			currentInventoryElement = openElement
			itemsTableState = insertType
			recalcSlot()
			toggleInventory(true)
		end
		triggerEvent("movedItemInInv", localPlayer)
	end
end)
addEvent("addItem", true)
addEventHandler("addItem", getRootElement(), function(addType, dataTable)
	if itemsTable[addType] and dataTable and type(dataTable) == "table" then
		addItem(addType, dataTable.dbID, dataTable.slot, dataTable.itemId, dataTable.amount, dataTable.data1, dataTable.data2, dataTable.data3, dataTable.nameTag, dataTable.serial)
	end
end)
addEvent("deleteItem", true)
addEventHandler("deleteItem", getRootElement(), function(deleteType, dataTable)
	if itemsTable[deleteType] and dataTable and type(dataTable) == "table" then
		for k, v in pairs(dataTable) do
			for i = 0, currentSlotLimit * 3 - 1 do
				if itemsTable[deleteType][i] and itemsTable[deleteType][i].dbID == v then
					itemsTable[deleteType][i] = nil
					if tempNameTag == i then
						tempNameTag = false
					end
				end
			end
		end
	end
end)
function takeBullet(databaseId)
	for k, v in pairs(itemsTable.player) do
		if v.dbID == databaseId then
			itemsTable.player[v.slot].amount = math.max(0, itemsTable.player[v.slot].amount - 1)
		end
	end
end
function updateAmount(databaseId, newAmount)
	local updateType = "player"
	if itemsTable[updateType] then
		databaseId = tonumber(databaseId)
		newAmount = tonumber(newAmount)
		if databaseId and newAmount then
			for k, v in pairs(itemsTable[updateType]) do
				if v.dbID == databaseId then
					itemsTable[updateType][v.slot].amount = newAmount
				end
			end
		end
	end
end
addEvent("updateAmount", true)
addEventHandler("updateAmount", getRootElement(), function(updateType, databaseId, newAmount)
	if itemsTable[updateType] then
		databaseId = tonumber(databaseId)
		newAmount = tonumber(newAmount)
		if databaseId and newAmount then
			for k, v in pairs(itemsTable[updateType]) do
				if v.dbID == databaseId then
					itemsTable[updateType][v.slot].amount = newAmount
				end
			end
		end
	end
end)
addEvent("updateItemID", true)
addEventHandler("updateItemID", getRootElement(), function(updateType, databaseId, newId)
	if itemsTable[updateType] then
		databaseId = tonumber(databaseId)
		newId = tonumber(newId)
		if databaseId and newId then
			for k, v in pairs(itemsTable[updateType]) do
				if v.dbID == databaseId then
					itemsTable[updateType][v.slot].itemId = newId
				end
			end
		end
	end
end)
addEvent("unuseAmmo", true)
addEventHandler("unuseAmmo", getRootElement(), function()
end)
addEvent("updateData1", true)
addEventHandler("updateData1", getRootElement(), function(updateType, databaseId, data1)
	if itemsTable[updateType] then
		databaseId = tonumber(databaseId)
		data1 = tonumber(data1) or data1
		if databaseId then
			for k, v in pairs(itemsTable[updateType]) do
				if v.dbID == databaseId then
					itemsTable[updateType][v.slot].data1 = data1
				end
			end
		end
	end
end)
addEvent("updateData2Ex", true)
addEventHandler("updateData2Ex", getRootElement(), function(updateType, databaseId, data1)
	if itemsTable[updateType] then
		databaseId = tonumber(databaseId)
		if databaseId then
			for k, v in pairs(itemsTable[updateType]) do
				if v.dbID == databaseId then
					itemsTable[updateType][v.slot].data2 = data1
				end
			end
		end
	end
end)
addEvent("updateNameTag", true)
addEventHandler("updateNameTag", getRootElement(), function(databaseId, newName)
	if itemsTable.player then
		databaseId = tonumber(databaseId)
		if databaseId and newName then
			for k, v in pairs(itemsTable.player) do
				if v.dbID == databaseId then
					itemsTable.player[v.slot].nameTag = newName
				end
			end
		end
	end
end)
addEvent("updateData3", true)
addEventHandler("updateData3", getRootElement(), function(updateType, databaseId, data1)
	if itemsTable[updateType] then
		databaseId = tonumber(databaseId)
		if databaseId then
			for k, v in pairs(itemsTable[updateType]) do
				if v.dbID == databaseId then
					if not perishableItems[v.itemId] then
						return
					end
					itemsTable[updateType][v.slot].data3 = data1
					triggerServerEvent("updateData3", localPlayer, localPlayer, databaseId, data1)
				end
			end
		end
	end
end)
addEvent("updateData3Ex", true)
addEventHandler("updateData3Ex", getRootElement(), function(updateType, databaseId, data1)
	if itemsTable[updateType] then
		databaseId = tonumber(databaseId)
		if databaseId then
			for k, v in pairs(itemsTable[updateType]) do
				if v.dbID == databaseId then
					itemsTable[updateType][v.slot].data3 = data1
				end
			end
		end
	end
end)
addEvent("unLockItem", true)
addEventHandler("unLockItem", getRootElement(), function(inventoryType, slotId)
	if itemsTable[inventoryType] and itemsTable[inventoryType][slotId] and itemsTable[inventoryType][slotId].locked then
		itemsTable[inventoryType][slotId].locked = false
	end
end)
local rottenEffect = false
addEvent("rottenEffect", true)
addEventHandler("rottenEffect", getRootElement(), function(val)
	rottenEffect = {
		getTickCount(),
		val
	}
end)
addEventHandler("onClientRender", getRootElement(), function()
	if rottenEffect then
		local progress = (getTickCount() - rottenEffect[1]) / 750
		local progress2 = progress - 1
		local alpha = interpolateBetween(0, 0, 0, 150 * rottenEffect[2] + 55, 0, 0, progress, "InQuad")
		if 0 < progress2 then
			alpha = interpolateBetween(150 * rottenEffect[2] + 55, 0, 0, 0, 0, 0, progress2, "OutQuad")
		end
		if 2 < progress then
			rottenEffect = false
		end
		dxDrawRectangle(0, 0, screenX, screenY, tocolor(20, 100, 40, alpha))
	end
end)
local blowObjects = {}
local flexObjects = {}
local flexDiscs = {}
addEventHandler("onClientPlayerQuit", getRootElement(), function()
	if blowObjects[source] then
		sightexports.sGoldrob:gotBlowtorchObject(source, nil)
	end
	if isElement(blowObjects[source]) then
		destroyElement(blowObjects[source])
	end
	blowObjects[source] = nil
	if isElement(flexObjects[source]) then
		destroyElement(flexObjects[source])
	end
	flexObjects[source] = nil
	if isElement(flexDiscs[source]) then
		destroyElement(flexDiscs[source])
	end
	flexDiscs[source] = nil
end)
local blowQ = {
	0.70070990910303,
	0.032068312229164,
	0.074597512494522,
	0.70881059371684
}
local flexQ = {
	0.68589759975875,
	-0.72769807107425,
	1.2057324166135E-20,
	8.6850062541364E-18
}
local models = false
local myCharacterId = getElementData(localPlayer, "char.ID")
local myAdminLevel = getElementData(localPlayer, "acc.adminLevel")
addEventHandler("onClientElementDataChange", localPlayer, function(dataName, oldValue)
	if dataName == "char.ID" then
		myCharacterId = getElementData(localPlayer, "char.ID")
	elseif dataName == "acc.adminLevel" then
		myAdminLevel = getElementData(localPlayer, "acc.adminLevel")
	end
end)
function modelsLoaded()
	models = {
		sight_blow_torch = sightexports.sModloader:getModelId("v4_blow_torch"),
		flex = sightexports.sModloader:getModelId("flex"),
		flex_disc = sightexports.sModloader:getModelId("flex_disc")
	}
	local players = getElementsByType("player")
	for i = 1, #players do
		if getElementData(players[i], "usingBlowTorch") then
			if isElement(blowObjects[players[i]]) then
				destroyElement(blowObjects[players[i]])
			end
			blowObjects[players[i]] = createObject(models.sight_blow_torch, 0, 0, 0)
			sightexports.sGoldrob:gotBlowtorchObject(players[i], blowObjects[players[i]])
			local i = getElementInterior(players[i])
			local d = getElementDimension(players[i])
			setElementInterior(blowObjects[players[i]], i)
			setElementDimension(blowObjects[players[i]], d)
			sightexports.sPattach:attach(blowObjects[players[i]], players[i], 24, -0.25239710864494, 0.082310572397713, 0.048512647503903, 0, 0, 0)
			sightexports.sPattach:setRotationQuaternion(blowObjects[players[i]], flexQ)
		end
		if getElementData(players[i], "usingGrinder") then
			if isElement(flexObjects[players[i]]) then
				destroyElement(flexObjects[players[i]])
			end
			if isElement(flexDiscs[players[i]]) then
				destroyElement(flexDiscs[players[i]])
			end
			flexObjects[players[i]] = createObject(models.flex, 0, 0, 0)
			flexDiscs[players[i]] = createObject(models.flex_disc, 0, 0, 0)
			local i = getElementInterior(players[i])
			local d = getElementDimension(players[i])
			setElementInterior(flexObjects[players[i]], i)
			setElementDimension(flexObjects[players[i]], d)
			setElementInterior(flexDiscs[players[i]], i)
			setElementDimension(flexDiscs[players[i]], d)
			sightexports.sPattach:attach(flexObjects[players[i]], players[i], 24, -0.25239710864494, 0.082310572397713, 0.048512647503903, 0, 0, 0)
			sightexports.sPattach:attach(flexDiscs[players[i]], players[i], 24, -0.25239710864494, 0.082310572397713, 0.048512647503903, 0, 0, 0)
			sightexports.sPattach:setRotationQuaternion(flexObjects[players[i]], flexQ)
			sightexports.sPattach:setRotationQuaternion(flexDiscs[players[i]], flexQ)
		end
	end
end
addEvent("modloaderLoaded", false)
addEventHandler("modloaderLoaded", getRootElement(), modelsLoaded)
if getElementData(localPlayer, "loggedIn") then
	modelsLoaded()
end
addEventHandler("onClientElementDataChange", getRootElement(), function(dataName, oldValue, new)
	if source == localPlayer then
		if dataName == "char.inventorySlots" then
			local newValue = tonumber(getElementData(source, defaultSettings.inventorySlots))
			if newValue and 10 < newValue then
				defaultSettings.slotLimit = newValue
			end
		elseif dataName == "playerRecipes" then
			playerRecipes = getElementData(localPlayer, "playerRecipes") or {}
		end
	end
	if dataName == "usingBlowTorch" and models then
		if isElement(blowObjects[source]) then
			destroyElement(blowObjects[source])
		end
		blowObjects[source] = nil
		if new then
			blowObjects[source] = createObject(models.sight_blow_torch, 0, 0, 0)
			local i = getElementInterior(source)
			local d = getElementDimension(source)
			setElementInterior(blowObjects[source], i)
			setElementDimension(blowObjects[source], d)
			sightexports.sPattach:attach(blowObjects[source], source, 24, -0.0016959484104506, 0.042804613423093, 0.056711700385485, 0, 0, 0)
			sightexports.sPattach:setRotationQuaternion(blowObjects[source], blowQ)
		end
		sightexports.sGoldrob:gotBlowtorchObject(source, blowObjects[source])
	elseif dataName == "usingGrinder" and models then
		if isElement(flexObjects[source]) then
			destroyElement(flexObjects[source])
		end
		flexObjects[source] = nil
		if isElement(flexDiscs[source]) then
			destroyElement(flexDiscs[source])
		end
		flexDiscs[source] = nil
		if new then
			flexObjects[source] = createObject(models.flex, 0, 0, 0)
			flexDiscs[source] = createObject(models.flex_disc, 0, 0, 0)
			local i = getElementInterior(source)
			local d = getElementDimension(source)
			setElementInterior(flexObjects[source], i)
			setElementDimension(flexObjects[source], d)
			setElementInterior(flexDiscs[source], i)
			setElementDimension(flexDiscs[source], d)
			sightexports.sPattach:attach(flexObjects[source], source, 24, -0.25239710864494, 0.082310572397713, 0.048512647503903, 0, 0, 0)
			sightexports.sPattach:attach(flexDiscs[source], source, 24, -0.25239710864494, 0.082310572397713, 0.048512647503903, 0, 0, 0)
			sightexports.sPattach:setRotationQuaternion(flexObjects[source], flexQ)
			sightexports.sPattach:setRotationQuaternion(flexDiscs[source], flexQ)
		end
	end
end)
function addItem(insertType, dbID, targetSlot, itemId, amount, data1, data2, data3, nameTag, serial)
	if dbID and targetSlot and itemId and amount and not itemsTable[insertType][targetSlot] then
		itemsTable[insertType][targetSlot] = {}
		itemsTable[insertType][targetSlot].dbID = dbID
		itemsTable[insertType][targetSlot].slot = targetSlot
		itemsTable[insertType][targetSlot].itemId = itemId
		itemsTable[insertType][targetSlot].amount = amount
		itemsTable[insertType][targetSlot].data1 = data1
		itemsTable[insertType][targetSlot].data2 = data2
		itemsTable[insertType][targetSlot].data3 = data3
		itemsTable[insertType][targetSlot].locked = false
		itemsTable[insertType][targetSlot].nameTag = nameTag
		itemsTable[insertType][targetSlot].serial = serial
	end
end
function findEmptySlot(insertType)
	local lowestSlot = false
	for i = 0, currentSlotLimit - 1 do
		if not itemsTable[insertType][i] then
			lowestSlot = tonumber(i)
			break
		end
	end
	if lowestSlot then
		if lowestSlot <= currentSlotLimit then
			return tonumber(lowestSlot)
		else
			return false
		end
	else
		return false
	end
end
function isPlayerHaveFreeSlot()
	local lowestSlot = false
	for i = 0, currentSlotLimit - 1 do
		if not itemsTable.player[i] then
			lowestSlot = tonumber(i)
			break
		end
	end
	if lowestSlot then
		if lowestSlot <= currentSlotLimit then
			return true
		else
			return false
		end
	else
		return false
	end
end
local lastUsed = getTickCount()
local drunkenLevel = 0
function addDrunkenLevel(level)
	drunkenLevel = drunkenLevel + level
	processDrunkRender()
	setTimer(removeDrunkenLevel, 30000, 1, 2, 30000)
end
function removeDrunkenLevel(level, timer)
	drunkenLevel = drunkenLevel - level
	if drunkenLevel < 0 then
		drunkenLevel = 0
	end
	processDrunkRender()
	if timer and 0 < drunkenLevel then
		setTimer(removeDrunkenLevel, timer, 1, 2, timer)
	end
end
local screenSource
local interpolateForDrunkStart = 0
local currentDirection = false
local handledRenderForDrunk = false
local fuckTheControls = false
function processDrunkRender()
	if 0 < drunkenLevel then
		if not handledRenderForDrunk then
			handledRenderForDrunk = true
			addEventHandler("onClientRender", getRootElement(), drunkenRender, true, "low-1")
			screenSource = dxCreateScreenSource(screenX, screenX)
		end
	else
		if handledRenderForDrunk then
			handledRenderForDrunk = false
			removeEventHandler("onClientRender", getRootElement(), drunkenRender)
			if isElement(screenSource) then
				destroyElement(screenSource)
			end
		end
		if fuckControlsDisabledControl then
			setAnalogControlState("vehicle_left", 0)
			setAnalogControlState("vehicle_right", 0)
			sightexports.sControls:toggleControl({
				"vehicle_left",
				"vehicle_right"
			}, true)
			fuckControlsDisabledControl = false
		end
	end
end
function drunkenRender()
	dxUpdateScreenSource(screenSource)
	local elapsedTime = getTickCount() - interpolateForDrunkStart
	if 3000 <= elapsedTime then
		interpolateForDrunkStart = getTickCount()
		elapsedTime = 0
		currentDirection = not currentDirection
		if fuckControlsDisabledControl then
			setAnalogControlState("vehicle_left", 0)
			setAnalogControlState("vehicle_right", 0)
			sightexports.sControls:toggleControl({
				"vehicle_left",
				"vehicle_right"
			}, true)
			fuckControlsDisabledControl = false
		end
		if math.random(5) <= 3 then
			sightexports.sControls:toggleControl({
				"vehicle_left",
				"vehicle_right"
			}, false)
			fuckControlsDisabledControl = true
			if 5 >= math.random(10) then
				setAnalogControlState("vehicle_left", 1)
			else
				setAnalogControlState("vehicle_right", 1)
			end
		end
	end
	local progress = elapsedTime / 3000
	local x, y = 0, 0
	if currentDirection then
		x, y = interpolateBetween(0, 0, 0, -drunkenLevel * 5, -drunkenLevel * 5, 0, progress, "OutQuad")
	else
		x, y = interpolateBetween(-drunkenLevel * 5, -drunkenLevel * 5, 0, 0, 0, 0, progress, "OutQuad")
	end
	dxDrawImage(0 + x, 0 + y, screenX, screenY, screenSource, 0, 0, 0, tocolor(255, 255, 255, 200))
end
function useSpecialItem()
	if currentItemInUse then
		local tick = 5000
		local itemId = currentItemInUse.itemId
		if specialItems[itemId] and specialItems[itemId][1] == "drug" then
			tick = 60000
		end
		if lastUsed <= getTickCount() - tick then
			local itemId = currentItemInUse.itemId
			if specialItems[itemId] then
				if specialItems[itemId][1] == "pizza" or specialItems[itemId][1] == "kebab" or specialItems[itemId][1] == "hamburger" then
					triggerServerEvent("playAnimation", localPlayer, "food")
					sightexports.sChat:localActionC(localPlayer, "evett valamit.")
				elseif specialItems[itemId][1] == "beer" or specialItems[itemId][1] == "wine" or specialItems[itemId][1] == "drink" then
					triggerServerEvent("playAnimation", localPlayer, "drink")
					sightexports.sChat:localActionC(localPlayer, "ivott valamit.")
					if specialItems[itemId][1] ~= "drink" then
						addDrunkenLevel(3)
					end
				elseif specialItems[itemId][1] == "cigarette" or specialItems[itemId][1] == "cigarette2" then
					triggerServerEvent("playAnimation", localPlayer, "smoke")
					sightexports.sChat:localActionC(localPlayer, "szívott egy slukkot.")
				end
			end
			lastUsed = getTickCount()
			currentItemRemainUses = currentItemRemainUses - 1
			local slotId = currentItemInUse.slot
			local itemId = currentItemInUse.itemId
			if currentItemRemainUses > 0 then
				triggerServerEvent("useSpecialItem", localPlayer, currentItemInUse, specialItems[itemId][2], currentItemRemainUses)
			else
				triggerServerEvent("useSpecialItem", localPlayer, currentItemInUse, specialItems[itemId][2], currentItemRemainUses)
				triggerServerEvent("useSpecialItemEnd", localPlayer, currentItemInUse, specialItems[itemId][2], currentItemRemainUses)
				currentItemRemainUses = false
				currentItemInUse = false
			end
		else
			outputChatBox("[color=sightred][SightMTA]: #FFFFFFCsak " .. tick / 1000 .. " másodpercenként használhatod a tárgyat!", 255, 255, 255, true)
		end
	end
end
function getWeaponNameFromIDNew(id)
	if id == 22 then
		return "glock-17"
	elseif id == 34 then
		return "Remington 700"
	elseif id == 33 then
		return "Vadászpuska"
	else
		return getWeaponNameFromID(id)
	end
end
local nameFont = false
local signFont = false
local signFont2 = false
local tradeContractOpened = false
function mysplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	i = 1
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
local bulletZone2 = createColSphere(1972.1084, -1374.6394, 23232.85156, 2)
local bulletZone = createColSphere(1560.67, -1692.99, 10003.21, 2)
local lastUse = 0
function useItem(databaseId)
	if getTickCount() - lastUse < 300 then
		sightexports.sGui:showInfobox("e", "Várj egy kicsit!")
		return
	end
	lastUse = getTickCount()
	local adminJail = getElementData(localPlayer, "acc.adminJail") or 0
	if adminJail ~= 0 then
		return
	end
	if databaseId then
		databaseId = tonumber(databaseId)
		local slotId = false
		for k, v in pairs(itemsTable.player) do
			if v.dbID == databaseId then
				slotId = k
				break
			end
		end

		if itemsTable.player[slotId] and (newItemList[itemsTable.player[slotId].itemId].use or newItemList[itemsTable.player[slotId].itemId].simpleUse or newItemList[itemsTable.player[slotId].itemId].secondaryUse) then
			triggerServerEvent("useItem", localPlayer, itemsTable.player[slotId].dbID)
		end
	end
end
usingItem = false
usingSecondaryItems = {}
function allowedToMoveInUse(dbID)
	if usingItem == dbID then
		return false
	end
	if usingSecondaryItems[dbID] then
		return false
	end
	return true
end
addEvent("gotNewUsingItem", true)
addEventHandler("gotNewUsingItem", getRootElement(), function(use)
	usingItem = use
end)
addEvent("gotNewUsingSecondaryItem", true)
addEventHandler("gotNewUsingSecondaryItem", getRootElement(), function(use)
	usingSecondaryItems = use or {}
end)
local inectionPlayerSelectorWindow = false
addEvent("injectionPlayerSelector", false)
addEventHandler("injectionPlayerSelector", getRootElement(), function(button, state, absoluteX, absoluteY, el, client)
	if inectionPlayerSelectorWindow then
		sightexports.sGui:deleteGuiElement(inectionPlayerSelectorWindow)
	end
	inectionPlayerSelectorWindow = nil
	if isElement(client) then
		triggerServerEvent("injectionPlayerSelected", localPlayer, client)
	end
end)
function showInjectionPlayerSelector()
	if inectionPlayerSelectorWindow then
		sightexports.sGui:deleteGuiElement(inectionPlayerSelectorWindow)
	end
	inectionPlayerSelectorWindow = nil
	inectionPlayerSelectorWindow = nil
	local px, py, pz = getElementPosition(localPlayer)
	local playerList = {}
	local players = getElementsByType("player", getRootElement(), true)
	for i = 1, #players do
		if getElementData(players[i], "loggedIn") then
			local px2, py2, pz2 = getElementPosition(players[i])
			local dist = getDistanceBetweenPoints3D(px2, py2, pz2, px, py, pz)
			if dist < 5 then
				table.insert(playerList, players[i])
			end
		end
	end
	table.insert(playerList, localPlayer)
	if #playerList < 1 then
		sightexports.sGui:showInfobox("e", "Nincs senki a közeledben!")
	else
		local titleBarHeight = sightexports.sGui:getTitleBarHeight()
		local panelWidth = 250
		local panelHeight = titleBarHeight + 5 + 30 + 5 + 35 * #playerList
		inectionPlayerSelectorWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
		sightexports.sGui:setWindowTitle(inectionPlayerSelectorWindow, "16/BebasNeueRegular.otf", "Injekció beadása")
		local y = titleBarHeight + 5
		for i = 1, #playerList do
			local btn = sightexports.sGui:createGuiElement("button", 5, y, panelWidth - 10, 30, inectionPlayerSelectorWindow)
			sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
			sightexports.sGui:setGuiHover(btn, "gradient", {
				"sightgreen",
				"sightgreen-second"
			}, false, true)
			sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
			sightexports.sGui:setButtonTextColor(btn, "#ffffff")
			sightexports.sGui:setButtonText(btn, getElementData(playerList[i], "visibleName"):gsub("_", " "))
			sightexports.sGui:setClickEvent(btn, "injectionPlayerSelector")
			sightexports.sGui:setClickArgument(btn, playerList[i])
			y = y + 35
		end
		local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 35, panelWidth - 10, 30, inectionPlayerSelectorWindow)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightred",
			"sightred-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
		sightexports.sGui:setButtonTextColor(btn, "#ffffff")
		sightexports.sGui:setButtonText(btn, "Mégsem")
		sightexports.sGui:setClickEvent(btn, "injectionPlayerSelector")
	end
end
addEvent("handleClientsideItemsSimpleUse", true)
addEventHandler("handleClientsideItemsSimpleUse", getRootElement(), function(useData)
	if useData then
		local itemId = useData.itemId
		local use = newItemList[itemId].simpleUse
		local arg = newItemList[itemId].useArg
		if use then
			if use == "ticket" then
				sightexports.sTickets:openTicket(useData.data1)
			elseif use == "vitaminInjection" then
				showInjectionPlayerSelector()
			elseif use == "ticketBook" then
				sightexports.sTickets:openTicketNew(useData.data1)
			elseif use == "doorRam" then
				sightexports.sInteriors:useDoorRam(useData.dbID)
				sightexports.sFarm:tryToBreakInFarm(useData.dbID)
				sightexports.sPaintshop:tryToBreakInRentable(useData.dbID)
			elseif use == "halloweenPumpkin" then
				sightexports.sPumpkin:tryToStartPumpkinOpening(useData.dbID)
			elseif use == "bonusEgg" then
				sightexports.sBunny:tryToStartBunnyOpening(useData.dbID)
			elseif use == "santaPresent" then
				sightexports.sSanta:tryToStartSantaOpening(useData.dbID)
			elseif use == "treasureChest" then
				sightexports.sChest:openChest(itemId, useData.dbID)
			elseif use == "vacationChest" then
				sightexports.sChest:openChest(itemId, useData.dbID)
			end
		end
	end
end)
addEvent("handleClientsideItemsUnUse", true)
addEventHandler("handleClientsideItemsUnUse", getRootElement(), function(useData, force)
	if useData then
		local itemId = useData.itemId
		local use = newItemList[itemId].use
		local arg = newItemList[itemId].useArg
		if use then
			if use == "sheepCutter" then
				sightexports.sFarm:toggleSheepCutter(false)
			elseif use == "groupTablet" then
				sightexports.sGroupcall:deleteTablet()
			elseif use == "milkaMode" then
				sightexports.sFarm:toggleMilkaMode(false)
			elseif use == "metaldetector" then
				sightexports.sMetaldetector:tryToUnUseDetector(force)
			elseif use == "migumoto" then
				sightexports.sMining:setTabletMode(false)
			elseif use == "pickaxe" then
				sightexports.sMining:setPickaxeMode(false)
			elseif use == "dragSlip" then
				sightexports.sDrag:closeDragSlip()
				sightexports.sChat:localActionC(localPlayer, "elrakott egy drag verseny eredményt.")
			elseif use == "jumperCable" then
				sightexports.sVehicles:stopClipping()
				sightexports.sChat:localActionC(localPlayer, "elrakott egy bikakábelt.")
			elseif use == "cinemaTicket" then
				sightexports.sCinema:deleteTicket()
				sightexports.sChat:localActionC(localPlayer, "elrakott egy mozijegyet.")
			elseif use == "license" then
				sightexports.sLicense:hideLicense(arg, useData.data1)
			elseif use == "seedyno" then
				sightexports.sDyno:closeDynoTicket()
				sightexports.sChat:localActionC(localPlayer, "elrakott egy SightDyno eredményt.")
			elseif use == "weaponReceipt" then
				sightexports.sWeapons:deleteWeaponReceipt()
			elseif use == "serviceInvoice" then
				sightexports.sMechanic:closeServiceInvoice()
			elseif use == "raffle" then
				currentRaffle = false
				sightexports.sChat:localActionC(localPlayer, "elrakott egy tombolát.")
				if isElement(raffleFont) then
					destroyElement(raffleFont)
				end
				raffleFont = false
			elseif use == "nametag" then
				inNametagEditMode = false
			elseif use == "obd" then
				sightexports.sMechanic:openObdState(false)
			elseif use == "bagMode" then
				sightexports.sBag:setBagMode(false)
				sightexports.sMining:setBagWieldMode(false)
			elseif use == "taxiCheckout" then
				sightexports.sChat:localActionC(localPlayer, "elrakott egy taxi kasszazárás lapot.")
				sightexports.sTaxi:setTaxiCheckoutData()
			elseif use == "invoice" then
				sightexports.sChat:localActionC(localPlayer, "elrakott egy számlát.")
				sightexports.sCompanies:deleteInvoice()
			elseif use == "invoiceBook" then
				sightexports.sChat:localActionC(localPlayer, "elrakott egy számlatömböt.")
				sightexports.sCompanies:deleteInvoice()
			end
		end
	end
end)
addEvent("handleClientsideItemsUse", true)
addEventHandler("handleClientsideItemsUse", getRootElement(), function(useData)
	if useData then
		local itemId = useData.itemId
		local use = newItemList[itemId].use
		local arg = newItemList[itemId].useArg
		if use then
			if use == "sheepCutter" then
				sightexports.sFarm:toggleSheepCutter(true)
			elseif use == "groupTablet" then
				sightexports.sGroupcall:createTablet(useData.data1)
			elseif use == "milkaMode" then
				sightexports.sFarm:toggleMilkaMode(true)
			elseif use == "metaldetector" then
				sightexports.sMetaldetector:tryToUseDetector()
			elseif use == "migumoto" then
				sightexports.sMining:setTabletMode(useData.dbID)
			elseif use == "pickaxe" then
				sightexports.sMining:setPickaxeMode(useData.dbID, arg)
			elseif use == "dragSlip" then
				sightexports.sDrag:openDragSlip(fromJSON(useData.data1))
				sightexports.sChat:localActionC(localPlayer, "elővett egy drag verseny eredményt.")
			elseif use == "jumperCable" then
				sightexports.sVehicles:startClipping()
				sightexports.sChat:localActionC(localPlayer, "elővett egy bikakábelt.")
			elseif use == "cinemaTicket" then
				sightexports.sCinema:showTicket(fromJSON(useData.data1), useData.data3 == 1)
				sightexports.sChat:localActionC(localPlayer, "elővett egy mozijegyet.")
			elseif use == "license" then
				sightexports.sLicense:showLicense(arg, fromJSON(useData.data3).id)
			elseif use == "seedyno" then
				sightexports.sDyno:openDynoTicket(fromJSON(useData.data1))
				sightexports.sChat:localActionC(localPlayer, "elővett egy SightDyno eredményt.")
			elseif use == "weaponReceipt" then
				sightexports.sWeapons:createWeaponReceipt(fromJSON(useData.data1))
			elseif use == "serviceInvoice" then
				sightexports.sMechanic:openServiceInvoice(useData.data1)
			elseif use == "raffle" then
				currentRaffle = tonumber(useData.data1) or ""
				sightexports.sChat:localActionC(localPlayer, "elővett egy tombolát.")
				if not isElement(raffleFont) then
					raffleFont = dxCreateFont("files/RobotoBI.ttf", 50, false, "antialiased")
				end
			elseif use == "nametag" then
				local slotId = false
				for k, v in pairs(itemsTable.player) do
					if v.dbID == useData.dbID then
						slotId = k
						break
					end
				end
				inNametagEditMode = slotId
			elseif use == "obd" then
				sightexports.sMechanic:openObdState(true)
			elseif use == "bagMode" then
				sightexports.sBag:setBagMode(true)
				sightexports.sMining:setBagWieldMode(useData.dbID)
			elseif use == "taxiCheckout" then
				sightexports.sChat:localActionC(localPlayer, "elővett egy taxi kasszazárás lapot.")
				sightexports.sTaxi:setTaxiCheckoutData(tonumber(useData.data2), fromJSON(useData.data3))
			elseif use == "invoice" then
				sightexports.sChat:localActionC(localPlayer, "elővett egy számlát.")
				sightexports.sCompanies:createInvoice(useData.data1)
			elseif use == "invoiceBook" then
				sightexports.sChat:localActionC(localPlayer, "elővett egy számlatömböt.")
				sightexports.sCompanies:createInvoiceBook(useData.data1)
			end
		end
	end
end)
addEvent("playFireworkSound", true)
addEventHandler("playFireworkSound", getRootElement(), function(typ)
	local x, y, z = getElementPosition(source)
	if typ == "small" then
		local sound = playSound3D("files/smallfirework.mp3", x, y, z, false)
		setSoundMaxDistance(sound, 50)
	elseif typ == "large" then
		local sound = playSound3D("files/largefirework.mp3", x, y, z, false)
		setSoundMaxDistance(sound, 50)
	end
end)
local canRefreshLicense = false
local licensePrices = {
	identityCard = 100,
	fishingLicense = 200,
	carLicense = 300,
	weaponLicense = 750
}
local fixedsys = dxCreateFont("files/Fixedsys500c.ttf", 16, false, "antialiased")
local lastCursorChange = 0
local cursorState = false
local searchRoboto = dxCreateFont("files/Roboto.ttf", 22, false, "antialiased")
addEventHandler("onClientRender", getRootElement(), function()
	if currentRaffle then
		local x = math.floor(screenX / 2 - 128)
		local y = math.floor(screenY / 2 - 128)
		dxDrawImage(x, y, 256, 256, "files/raffle.png")
		dxDrawText(currentRaffle, 0, 0, screenX, screenY, tocolor(0, 0, 0), 1, raffleFont, "center", "center")
	end
	if cardState then
		if cardData.iscopy then
			dxSetRenderTarget(copyLicenseRT, true)
			screenX, screenY = 280, 372
		end
		if cardType == "identityCard" then
			if cardData then
				dxDrawImage(cardPosX, cardPosY, cardSizeX, cardSizeY, "files/identity/bg.png")
				dxDrawText(cardData.characterName:gsub("_", " "), namePosX, namePosY, boxEndX, namePosY + boxSizeY, tocolor(0, 0, 0, 255), 0.5, nameFont)
				dxDrawText("Sight City", homePosX, homePosY, boxEndX, homePosY + boxSizeY, tocolor(255, 255, 255, 255), 0.5, nameFont)
				dxDrawText(" " .. cardData.itemId, idPosX, idPosY, boxEndX, idPosY + boxSizeY, tocolor(255, 255, 255, 255), 0.5, nameFont)
				dxDrawText(cardData.expireDate, expirePosX, expirePosY, boxEndX, expirePosY + boxSizeY, tocolor(255, 255, 255, 255), 0.5, nameFont)
				dxDrawText(cardData.characterName:gsub("_", " "), signPosX, signPosY, boxEndX, namePosY + boxSizeY, tocolor(255, 255, 255, 255), 0.5, signFont)
				if fileExists("files/skins/" .. cardData.skinId .. ".jpg") then
					dxDrawImage(picPosX, picPosY, picSizeX, picSizeY, "files/skins/" .. cardData.skinId .. ".jpg")
				else
					dxDrawImage(picPosX, picPosY, picSizeX, picSizeY, "files/skins/1.jpg")
				end
			end
		elseif cardType == "carLicense" then
			if cardData then
				dxDrawImage(cardPosX, cardPosY, cardSizeX, cardSizeY, "files/identity/car.png")
				local text = "Név: " .. cardData.characterName:gsub("_", " ") .. "\n"
				text = text .. "Lakhely: Sight City\n"
				text = text .. "Azonosító: " .. cardData.itemId .. "\n"
				text = text .. "Érvényesség: " .. cardData.expireDate .. "\n"
				dxDrawText(cardData.characterName:gsub("_", " "), cardPosX + 295, cardPosY + 186, cardPosX + 378, cardPosY + 220, tocolor(0, 0, 0, 225), 0.5, signFont2, "center", "center")
				dxDrawText(text, cardPosX + 132, cardPosY + 69, boxEndX, cardPosY + 69 + 101, tocolor(0, 0, 0, 255), 0.5, nameFont, "left", "center")
				if fileExists("files/skins/" .. cardData.skinId .. ".jpg") then
					dxDrawImage(cardPosX + 17, cardPosY + 69, 101, 101, "files/skins/" .. cardData.skinId .. ".jpg")
				else
					dxDrawImage(cardPosX + 17, cardPosY + 69, 101, 101, "files/skins/1.jpg")
				end
			end
		elseif cardType == "weaponLicense" then
			if cardData then
				dxDrawImage(cardPosX, cardPosY, cardSizeX, cardSizeY, "files/identity/weapon.png")
				dxDrawText(cardData.characterName:gsub("_", " "), cardPosX + 295, cardPosY + 186, cardPosX + 378, cardPosY + 220, tocolor(0, 0, 0, 225), 0.5, signFont2, "center", "center")
				local text = "Név: " .. cardData.characterName:gsub("_", " ") .. "\n"
				text = text .. "Lakhely: Sight City\n"
				text = text .. "Azonosító: " .. cardData.itemId .. "\n"
				text = text .. "Érvényesség: " .. cardData.expireDate .. "\n"
				dxDrawText(text, cardPosX + 132, cardPosY + 69, boxEndX, cardPosY + 69 + 101, tocolor(0, 0, 0, 255), 0.5, nameFont, "left", "center")
				if fileExists("files/skins/" .. cardData.skinId .. ".jpg") then
					dxDrawImage(cardPosX + 17, cardPosY + 69, 101, 101, "files/skins/" .. cardData.skinId .. ".jpg")
				else
					dxDrawImage(cardPosX + 17, cardPosY + 69, 101, 101, "files/skins/1.jpg")
				end
			end
		elseif cardType == "fishingLicense" and cardData then
			dxDrawImage(screenX / 2 - 140, screenY / 2 - 186, 280, 373, "files/identity/fishing.png")
			dxDrawText("Név: " .. cardData.characterName:gsub("_", " "), screenX / 2 - 140 + 22, screenY / 2 - 186 + 204, 0, screenY / 2 - 186 + 241, tocolor(0, 0, 0, 225), 0.5, fixedsys, "left", "center")
			dxDrawText("Terület: " .. cardData.skinId, screenX / 2 - 140 + 22, screenY / 2 - 186 + 242, 0, screenY / 2 - 186 + 273, tocolor(0, 0, 0, 225), 0.5, fixedsys, "left", "center")
			dxDrawText("Érvényesség: " .. cardData.expireDate, screenX / 2 - 140 + 22, screenY / 2 - 186 + 274, 0, screenY / 2 - 186 + 306, tocolor(0, 0, 0, 225), 0.5, fixedsys, "left", "center")
			dxDrawText(cardData.characterName:gsub("_", " "), screenX / 2 - 140 + 80, screenY / 2 - 186 + 358, screenX / 2 - 140 + 268, screenY / 2 - 186 + 370, tocolor(20, 100, 200, 225), 0.75, signFont2, "center", "bottom")
		end
		canRefreshLicense = false
		if cardData.iscopy then
			dxSetRenderTarget()
			screenX, screenY = guiGetScreenSize()
			dxDrawRectangle(screenX / 2 - 400, screenY / 2 - 250, 800, 500, tocolor(255, 255, 255))
			dxDrawImage(screenX / 2 - 400 + 50 + cardData.iscopypos[1], screenY / 2 - 250 + cardData.iscopypos[2], 410, 410, copyLicenseShader, -cardData.iscopypos[3], 210, 210)
			dxDrawImage(screenX / 2 - 400, screenY / 2 - 250, 800, 500, "files/paper.png")
		else
			local x, y, z = 1155.2197265625, -1781.638671875, 16.0625
			local x2, y2, z2 = getElementPosition(localPlayer)
			local dist = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if dist <= 2.5 then
				local sy = cardSizeY
				if cardType == "fishingLicense" then
					sy = 373
				end
				dxDrawRectangle(screenX / 2 - 74, cardPosY + sy, 150, 32, tocolor(0, 0, 0, 200))
				local cx, cy = getCursorPosition()
				if cx then
					cx = cx * screenX
					cy = cy * screenY
					if cx >= screenX / 2 - 74 + 4 and cx <= screenX / 2 + 74 + 4 and cy >= cardPosY + sy + 4 and cy <= cardPosY + sy + 4 + 32 - 8 then
						canRefreshLicense = true
					end
				end
				if canRefreshLicense then
					dxDrawRectangle(screenX / 2 - 74 + 4, cardPosY + sy + 4, 142, 24, tocolor(124, 197, 118, 255))
				else
					dxDrawRectangle(screenX / 2 - 74 + 4, cardPosY + sy + 4, 142, 24, tocolor(124, 197, 118, 175))
				end
				dxDrawText("Megújítás (" .. math.floor(licensePrices[cardType] * 0.75) .. " $)", screenX / 2 - 74 + 4, cardPosY + sy + 4, screenX / 2 + 74 + 4, cardPosY + sy + 4 + 32 - 8, tocolor(0, 0, 0), 0.5, nameFont, "center", "center")
			end
		end
	end
end)
addEvent("playCardSound", true)
addEventHandler("playCardSound", getRootElement(), function()
	local posX, posY, posZ = getElementPosition(source)
	playSound3D("files/card.mp3", posX, posY, posZ, false)
end)
addEvent("playDiceSound", true)
addEventHandler("playDiceSound", getRootElement(), function()
	local posX, posY, posZ = getElementPosition(source)
	playSound3D("files/dice.mp3", posX, posY, posZ, false)
end)
local giveGuiState = false
local firstChar = false
local itemSearchList = false
local itemListSearchPhrase = ""
local itemListOffset = 0
function itemlistKey(button, press)
	if isCursorShowing() then
		cancelEvent()
		if button == "mouse_wheel_up" and 0 < itemListOffset then
			itemListOffset = itemListOffset - 1
		end
		if button == "mouse_wheel_down" and itemListOffset < #itemSearchList - 14 then
			itemListOffset = itemListOffset + 1
		end
		if press and button == "backspace" then
			itemListSearchPhrase = utf8.sub(itemListSearchPhrase, 1, utf8.len(itemListSearchPhrase) - 1)
			searchItems()
		end
	end
end
function itemlistCharacter(character)
	if isCursorShowing() then
		itemListSearchPhrase = itemListSearchPhrase .. character
		searchItems()
	end
end
function searchItems()
	itemSearchList = {}
	if utf8.len(itemListSearchPhrase) < 1 then
		for k = 1, #itemList do
			table.insert(itemSearchList, k)
		end
		itemListOffset = 0
	elseif tonumber(itemListSearchPhrase) then
		if itemList[tonumber(itemListSearchPhrase)] then
			table.insert(itemSearchList, tonumber(itemListSearchPhrase))
		end
		itemListOffset = 0
	else
		for k = 1, #itemList do
			if utf8.find(utf8.lower(itemList[k][1]), utf8.lower(itemListSearchPhrase), nil, true) then
				table.insert(itemSearchList, k)
			end
		end
		itemListOffset = 0
	end
end
local theX = screenX / 2
local theY = screenY / 2
local dragging = false
function renderGiveGui()
	local cx, cy = getCursorPosition()
	cx = cx * screenX
	cy = cy * screenY
	local exitAlpha = 175
	if cx >= theX + 400 - 100 and cy >= theY + 300 - 30 and cx <= theX + 400 - 10 and cy <= theY + 300 - 10 then
		exitAlpha = 225
		if getKeyState("mouse1") then
			giveGuiState = false
			removeEventHandler("onClientRender", getRootElement(), renderGiveGui)
			removeEventHandler("onClientCharacter", getRootElement(), itemlistCharacter)
			removeEventHandler("onClientKey", getRootElement(), itemlistKey)
			showCursor(false)
			return
		end
	end
	if not dragging then
		if getKeyState("mouse1") and cx >= theX - 400 and cx <= theX + 400 and cy >= theY - 300 and cy <= theY + 300 then
			dragging = {
				cx,
				cy,
				theX,
				theY
			}
		end
	elseif getKeyState("mouse1") then
		theX = cx - dragging[1] + dragging[3]
		theY = cy - dragging[2] + dragging[4]
	else
		dragging = false
	end
	dxDrawRectangle(theX - 400, theY - 300, 800, 600, tocolor(0, 0, 0, 150))
	dxDrawRectangle(theX - 400 + 8, theY - 300 + 8, 784, 30, tocolor(0, 0, 0, 100))
	dxDrawText(itemListSearchPhrase, theX - 400 + 16, theY - 300 + 8, 0, theY - 300 + 38, tocolor(255, 255, 255), craftFontScale, craftFont, "left", "center")
	local oneHeight = 39.57142857142857
	local x = theX - 400
	local y = theY - 300 + 8 + 38
	for k = 1, 14 do
		local a = 50
		if k % 2 == 1 then
			a = 75
		end
		dxDrawRectangle(x, y, 800, oneHeight, tocolor(0, 0, 0, a))
		if itemSearchList[k + itemListOffset] then
			dxDrawImage(x + 4, y + 4, oneHeight - 8, oneHeight - 8, getItemPic(itemSearchList[k + itemListOffset]))
			local ext = ""
			dxDrawText("[" .. itemSearchList[k + itemListOffset] .. "] " .. itemList[itemSearchList[k + itemListOffset]][1] .. ext, x + oneHeight, y, 0, y + oneHeight / 2 + 3, tocolor(255, 255, 255), craftFontScale, craftFont, "left", "center")
			dxDrawText(itemList[itemSearchList[k + itemListOffset]][2], x + oneHeight, y + oneHeight / 2 - 3, 0, y + oneHeight, tocolor(255, 255, 255), craftFontScale * 0.9, craftFont, "left", "center")
		end
		y = y + oneHeight
	end
	dxDrawRectangle(theX + 400 - 100, theY + 300 - 30, 90, 20, tocolor(215, 89, 89, exitAlpha))
	dxDrawText("Bezárás", theX + 400 - 100, theY + 300 - 30, theX + 400 - 10, theY + 300 - 10, tocolor(0, 0, 0), craftFontScale * 0.9, craftFont, "center", "center")
end
local bodySearchList = {}
local oldMoney = 0
local searchName = ""
local bodySearchHandled = false
addEvent("bodySearchGotDatas", true)
addEventHandler("bodySearchGotDatas", getRootElement(), function(player, money, name)
	bodySearchList = {}
	for k, v in pairs(player) do
		bodySearchList[v.slot] = {
			itemId = v.itemId,
			amount = v.amount,
			data1 = v.data1,
			data2 = v.data2,
			data3 = v.data3,
			nameTag = v.nameTag,
			serial = v.serial
		}
	end
	oldMoney = money
	searchName = name
	if not bodySearchHandled then
		addEventHandler("onClientRender", getRootElement(), bodySearch)
	end
end)
local bodyChangeX, bodyChangeY = 400, 400
local bodyMoveStartX, bodyMoveStartY
local bodySearchTab = "main"
local bodySearchHover = false
function processTooltip(absX, absY, theItemName, itemId, itemData, rtrender, justCalculate)
	theItemName = theItemName or itemList[itemId][1]
	if itemId == 361 then
		theItemName = theItemName .. " #8e8e8e[" .. serialItems[itemData.itemId] .. itemData.serial .. "]"
	elseif tonumber(itemData.serial) and itemData.serial > 0 then
		theItemName = theItemName .. " #8e8e8e[W" .. itemData.serial .. serialItems[itemData.itemId] .. "]"
	end
	if itemData.nameTag then
		theItemName = theItemName .. redHex .. " (" .. itemData.nameTag .. ")"
	end
	if checkDutyData3(itemData.data3) then
		local group = utf8.sub(tostring(itemData.data3), 6)
		theItemName = theItemName .. orangeHex .. " (Duty: " .. sightexports.sGroups:getGroupName(group) .. ")"
	end
	if itemId == 365 then
		theItemName = theItemName .. " #8e8e8e[" .. itemData.data1 .. "]"
	end
	if newItemList[itemId].tooltip then
		return showTooltip(absX, absY, theItemName, newItemList[itemId].tooltip, rtrender, justCalculate)
	elseif newItemList[itemId].skillBook then
		return showTooltip(absX, absY, theItemName, blueHex .. "Fegyverek: #ffffff" .. newItemList[itemId].skillBook, rtrender, justCalculate)
	elseif newItemList[itemId].use == "fish" then
		local data1 = tonumber(itemData.data1) or 0
		local percentage = math.floor(100 - (itemData.data3 or 0) / perishableItems[itemId] * 100)
		local color = redHex
		if percentage <= 100 and 65 < percentage then
			color = greenHex
		elseif percentage <= 65 and 20 < percentage then
			color = orangeHex
		end
		return showTooltip(absX, absY, theItemName, "Súly: " .. blueHex .. math.floor(data1 * 10) / 10 .. [[
 kg
#ffffffHossz: ]] .. blueHex .. sightexports.sFishing:calculateFishLength(newItemList[itemId].useArg, data1) .. " cm\n#ffffffÁllapot: " .. color .. percentage .. "%", rtrender, justCalculate)
	elseif itemId == 313 then
		local time = getRealTime(itemData.data3)
		local date = string.format("%04d. %02d. %02d. %02d:%02d", time.year + 1900, time.month + 1, time.monthday, time.hour, time.minute)
		return showTooltip(absX, absY, theItemName, greenHex .. sightexports.sGui:thousandsStepper(itemData.data2) .. " $\n#ffffffFizetési határidő: " .. blueHex .. date, rtrender, justCalculate)
	elseif itemId == 195 then
		return showTooltip(absX, absY, theItemName, "Még " .. greenHex .. 20 - (tonumber(itemData.data1) or 0) .. "#ffffff fújásra elég", rtrender, justCalculate)
	elseif itemId == 370 then
		return showTooltip(absX, absY, theItemName, "Sorszám: " .. blueHex .. itemData.data1, rtrender, justCalculate)
	elseif itemId == 314 then
		return showTooltip(absX, absY, theItemName, sightexports.sGroups:getGroupName(itemData.data1), rtrender, justCalculate)
	elseif itemId == 127 then
		return showTooltip(absX, absY, theItemName, sightexports.sGroups:getGroupName(itemData.data1), rtrender, justCalculate)
	elseif itemId == 439 then
		return showTooltip(absX, absY, theItemName, itemData.data2 .. "\nRendszám: " .. sightexports.sGui:getColorCodeHex("sightgreen") .. itemData.data3, rtrender, justCalculate)
	elseif newItemList[itemId].isMoneyStack then
		return showTooltip(absX, absY, theItemName, sightexports.sGui:thousandsStepper(itemData.data1) .. " $", rtrender, justCalculate)
	elseif perishableItems[itemId] then
		local percentage = math.floor(100 - itemData.data3 / perishableItems[itemId] * 100)
		local color = redHex
		if percentage <= 100 and 65 < percentage then
			color = greenHex
		elseif percentage <= 65 and 20 < percentage then
			color = orangeHex
		end
		return showTooltip(absX, absY, theItemName, "Állapot: " .. color .. percentage .. "%", rtrender, justCalculate)
	elseif itemId == 312 then
		local percentage = math.floor(100 - (itemData.data1 or 100) / 100 * 100)
		local color = redHex
		if percentage <= 100 and 65 < percentage then
			color = greenHex
		elseif percentage <= 65 and 20 < percentage then
			color = orangeHex
		end
		return showTooltip(absX, absY, theItemName, "Állapot: " .. color .. percentage .. "%", rtrender, justCalculate)
	elseif itemId == 1 or itemId == 2 or itemId == 3 or itemId == 154 then
		return showTooltip(absX, absY, theItemName, "(( Azonosító: " .. itemData.data1 .. "))", rtrender, justCalculate)
	elseif itemId == 442 then
		return showTooltip(absX, absY, theItemName, itemData.data2, rtrender, justCalculate)
	elseif itemId == 309 then
		return showTooltip(absX, absY, theItemName, itemData.data3 .. "\nRendszám: " .. greenHex .. itemData.data2, rtrender, justCalculate)
	elseif itemId == 443 then
		local title = sightexports.sGroups:getGroupBadgeTitle(itemData.data1) or itemData.data1
		return showTooltip(absX, absY, theItemName, blueHex .. title .. " # " .. itemData.data2, rtrender, justCalculate)
	elseif itemId == 206 then
		local title = sightexports.sGroups:getGroupBadgeTitle(itemData.data1) or itemData.data1
		return showTooltip(absX, absY, theItemName, yellowHex .. title .. " # " .. itemData.data2, rtrender, justCalculate)
	elseif itemId == 289 or itemId == 288 then
		return showTooltip(absX, absY, theItemName, itemData.data2 .. "\nRendszám: " .. greenHex .. itemData.data3, rtrender, justCalculate)
	elseif itemId == 299 then
		local dat = tonumber(itemData.data1) or 1
		if not availableRecipes[dat] then
			dat = 1
		end
		return showTooltip(absX, absY, theItemName, availableRecipes[dat][1], rtrender, justCalculate)
	elseif itemId == 115 then
		local dat = tonumber(itemData.data1) or 0
		return showTooltip(absX, absY, theItemName, "Még " .. 10 - dat .. " ajtót törhetsz be vele." .. "\n#ffffffSúly: " .. blueHex .. formatWeight(itemList[itemId][10] * itemData.amount), rtrender, justCalculate)
	elseif itemId == 100 then
		local dat = tonumber(itemData.data1) or 0
		return showTooltip(absX, absY, theItemName, "Még " .. 10 - dat .. " használat." .. "\n#ffffffSúly: " .. blueHex .. formatWeight(itemList[itemId][10] * itemData.amount), rtrender, justCalculate)
	elseif newItemList[itemId].stackOfItem then
		local remainder = newItemList[itemId].stackOfItemCount - (tonumber(itemData.data1) or 0)
		showTooltip(absX, absY, theItemName, "Még " .. remainder .. "db " .. getItemName(newItemList[itemId].stackOfItem) .. " van benne." .. "\n#ffffffSúly: " .. blueHex .. formatWeight(itemList[itemId][10] * itemData.amount), rtrender, justCalculate)
	elseif newItemList[itemId].weaponList then
		return showTooltip(absX, absY, theItemName, blueHex .. table.concat(newItemList[itemId].weaponList, ", ") .. "\n#ffffffSúly: " .. blueHex .. formatWeight(itemList[itemId][10] * itemData.amount), rtrender, justCalculate)
	elseif newItemList[itemId].weapon then
		local percentage = 100 - (tonumber(itemData.data1) or 0)
		percentage = math.floor(percentage * 100) / 100
		local color = redHex
		if percentage <= 100 and 65 < percentage then
			color = greenHex
		elseif percentage <= 65 and 20 < percentage then
			color = orangeHex
		end
		local warn = tonumber(itemData.data2) or 0
		if 3 <= warn then
			warn = redHex .. warn
		elseif 0 < warn then
			warn = orangeHex .. warn
		else
			warn = greenHex .. warn
		end
		if newItemList[itemId].ammoName then
			return showTooltip(absX, absY, theItemName, "Lőszer: " .. blueHex .. newItemList[itemId].ammoName .. "\n#ffffffÁllapot: " .. color .. percentage .. "%\n#ffffffFigyelmeztetések: " .. warn .. "\n#ffffffSúly: " .. blueHex .. formatWeight(itemList[itemId][10] * itemData.amount), rtrender, justCalculate)
		else
			return showTooltip(absX, absY, theItemName, "Állapot: " .. color .. percentage .. "%\n#ffffffFigyelmeztetések: " .. warn .. "\n#ffffffSúly: " .. blueHex .. formatWeight(itemList[itemId][10] * itemData.amount), rtrender, justCalculate)
		end
	elseif itemId == 61 or itemId == 62 or itemId == 63 then
		return showTooltip(absX, absY, itemList[itemId][2], "Súly: " .. blueHex .. formatWeight(itemList[itemId][10] * itemData.amount), rtrender, justCalculate)
	elseif itemId == 207 or itemId == 208 or itemId == 308 or itemId == 310 then
		return showTooltip(absX, absY, theItemName, "Név: " .. blueHex .. (itemData.data2 or "N/A"), rtrender, justCalculate)
	elseif itemId == 597 then
		local invoiceId = tostring(itemData.data1)
		local companyName = tostring(itemData.data2)
		local money = tonumber(itemData.data3) or 0
		local vat = math.floor(money * 0.2)
		return showTooltip(absX, absY, theItemName, blueHex .. invoiceId .. [[
    
#ffffff]] .. companyName .. "\n" .. greenHex .. "Bruttó " .. sightexports.sGui:thousandsStepper(money + vat) .. " $", rtrender, justCalculate)
	elseif itemId == 598 then
		local invoiceId = tostring(itemData.data1)
		local companyName = tostring(itemData.data2)
		return showTooltip(absX, absY, theItemName, blueHex .. invoiceId .. [[
    
#ffffff]] .. companyName, rtrender, justCalculate)
	elseif itemId == 596 then
		local companyId = tonumber(itemData.data1)
		local tooltip = false
		if companyId then
			local dat2 = tostring(itemData.data2)
			local owner = tostring(itemData.data3)
			local vatNumber = utf8.sub(dat2, 1, 13)
			local companyName = utf8.sub(dat2, 14)
			tooltip = blueHex .. companyName
			tooltip = tooltip .. " #ffffff(Ny. sz: " .. blueHex .. companyId .. "#ffffff)\n"
			tooltip = tooltip .. "#ffffffAdószám: " .. blueHex .. vatNumber .. "\n"
			tooltip = tooltip .. "#ffffffCégtulajdonos: " .. blueHex .. owner
		end
		return showTooltip(absX, absY, theItemName, tooltip or "N/A", rtrender, justCalculate)
	elseif itemId == 595 then
		return showTooltip(absX, absY, theItemName, (itemData.data1 or "N/A") .. "\n" .. sightexports.sGui:thousandsStepper(itemData.data2 or 0) .. " $", rtrender, justCalculate)
	elseif itemId == 584 then
		local leftText = tonumber(itemData.data2) ~= -1 and itemData.data2 or false
		local rightText = tonumber(itemData.data3) ~= -1 and itemData.data3 or false
		if leftText and rightText then
			return showTooltip(absX, absY, theItemName, leftText .. "\n" .. rightText, rtrender, justCalculate)
		elseif leftText then
			return showTooltip(absX, absY, theItemName, leftText, rtrender, justCalculate)
		elseif rightText then
			return showTooltip(absX, absY, theItemName, rightText, rtrender, justCalculate)
		else
			return showTooltip(absX, absY, theItemName, "", rtrender, justCalculate)
		end
	elseif newItemList[itemId].use == "fishingRod" then
		local data1 = tonumber(itemData.data1) or 0
		local data2 = tonumber(itemData.data2) or 0
		local data3 = tonumber(itemData.data3) or 0
		local line = false
		local col = sightexports.sFishing:getFishingLineColor(data1)
		if col then
			line = sightexports.sGui:getColorCodeHex({
				col[1],
				col[2],
				col[3]
			}) .. col[4]
		end
		local floater = redHex .. "nincs"
		if sightexports.sFishing:isFloatSkinValid(data3) then
			floater = blueHex .. data3
		end
		return showTooltip(absX, absY, theItemName, "Damil: " .. (line and line .. "\n#ffffffDamil állapota: " .. blueHex .. math.floor(100 - data2) .. "%" or redHex .. "nincs") .. "#ffffff\nÚszó: " .. floater, rtrender, justCalculate)
	else
		return showTooltip(absX, absY, theItemName, "Súly: " .. blueHex .. formatWeight(itemList[itemId][10] * itemData.amount), rtrender, justCalculate)
	end
end
function isTheItemCopy(data)
	return false
end
local hoverItem = false
local hoverItemId = false
local hoverSec = {}
function bodySearch()
	if not inventoryState then
		cursorTmp = "normal"
		tooltipTmp = false
	end
	local absX, absY = -9999, -9999
	if isCursorShowing() then
		local relativeX, relativeY, worldX, worldY, worldZ = getCursorPosition()
		absX = relativeX * screenX
		absY = relativeY * screenY
	end
	local sx, sy = rectangleWidth, rectangleHeight
	local x, y = bodyChangeX, bodyChangeY
	if absX >= x and absY >= y and absX <= x + sx and absY <= y + 33 and not bodyMoveStartX and not bodyMoveStartY then
		cursorTmp = "move"
		if getKeyState("mouse1") then
			bodyMoveStartX, bodyMoveStartY = absX - x, absY - y
		end
	end
	if bodyMoveStartX and bodyMoveStartY then
		cursorTmp = "move"
		if not getKeyState("mouse1") or not isCursorShowing() then
			bodyMoveStartX, bodyMoveStartY = false, false
		else
			bodyChangeX, bodyChangeY = absX - bodyMoveStartX, absY - bodyMoveStartY
			x, y = bodyChangeX, bodyChangeY
		end
	end
	local currentLine = 0
	local oldLine = 0
	local currentSlot = 0
	for i = 0, currentSlotLimit - 1 do
		currentLine = math.floor(i / defaultSettings.width)
		if currentLine ~= oldLine then
			currentSlot = 0
		end
		oldLine = currentLine
		currentSlot = currentSlot + 1
	end
	dxDrawRectangle(x, y, sx, sy, background)
	dxDrawRectangle(x, y, sx, 32, titlebar)
	dxDrawRectangle(x, y + 32, sx, 1, lightercolor)
	if absX >= x and absX <= x + sx and absY >= y and absY <= y + 33 then
		cursorTmp = "move"
	end
	local bodyCurrentWeight = 0
	for k, v in pairs(bodySearchList) do
		if itemList[v.itemId] then
			local baseWeight = itemList[v.itemId][10]
			bodyCurrentWeight = bodyCurrentWeight + baseWeight * v.amount
		end
	end
	local weight = getWeightLimit(itemsTableState, currentInventoryElement)
	local renderWeight = tonumber(bodyCurrentWeight) or weight
	if weight < renderWeight then
		renderWeight = weight
	elseif renderWeight < 0 then
		renderWeight = 0
	end
	local multipler = renderWeight / getWeightLimit("player", localPlayer)
	dxDrawRectangle(x + 5, y + rectangleHeight - 4 - 5, rectangleWidth - 10, 4, lightestgrey)
	dxDrawRectangle(x + 5, y + rectangleHeight - 4 - 5, (rectangleWidth - 10) * multipler, 4, useColor)
	if absX >= x + 5 and absX <= x + rectangleWidth - 5 and absY >= y + rectangleHeight - 4 - 5 and absY <= y + rectangleHeight - 5 then
		tooltipTmp = math.ceil(renderWeight) .. "/" .. getWeightLimit("player", localPlayer) .. "kg"
	end
	dxDrawText(searchName, x + 6, y, 0, y + 32, useColor, titlebarFontScale, titlebarFont, "left", "center", false, false, false, true)
	local w = dxGetTextWidth(searchName, titlebarFontScale, titlebarFont, true)
	if absX >= x and absY >= y and absX <= x + w + 6 + 6 and absY <= y + 33 then
		cursorTmp = "link"
		if 0 < oldMoney then
			tooltipTmp = "Készpénz: " .. greenHex .. sightexports.sGui:thousandsStepper(oldMoney) .. " $"
		else
			tooltipTmp = "Készpénz: " .. redHex .. sightexports.sGui:thousandsStepper(oldMoney) .. " $"
		end
	end
	bodySearchHover = false
	local picX = x + sx
	local picY = y + 4
	picX = picX - 10 - 20
	if absX >= picX and absY >= picY and absX <= picX + 20 and absY <= picY + 24 then
		cursorTmp = "link"
		tooltipTmp = "Bezárás"
		dxDrawImage(picX, picY, 24, 24, ":sGui/" .. closeIcon .. (faTicks[closeIcon] or ""), 0, 0, 0, tocolor(255, 255, 255, 255))
		if getKeyState("mouse1") then
			cursorTmp = "normal"
			tooltipTmp = false
			removeEventHandler("onClientRender", getRootElement(), bodySearch)
			bodySearchHandled = false
		end
	else
		dxDrawImage(picX, picY, 24, 24, ":sGui/" .. closeIcon .. (faTicks[closeIcon] or ""), 0, 0, 0, tocolor(255, 255, 255, 125))
	end
	picX = picX - 10 - 20
	if absX >= picX and absY >= picY and absX <= picX + 20 and absY <= picY + 24 then
		bodySearchHover = "papers"
		cursorTmp = "link"
		tooltipTmp = "Iratok"
	end
	if bodySearchTab == "papers" then
		dxDrawImage(picX, picY, 20, 24, "files/wallet.dds", 0, 0, 0, useColor)
	elseif bodySearchHover == "papers" then
		dxDrawImage(picX, picY, 20, 24, "files/wallet.dds", 0, 0, 0, tocolor(255, 255, 255, 255))
	else
		dxDrawImage(picX, picY, 20, 24, "files/wallet.dds", 0, 0, 0, tocolor(255, 255, 255, 125))
	end
	picX = picX - 10 - 20
	if absX >= picX and absY >= picY and absX <= picX + 20 and absY <= picY + 24 then
		bodySearchHover = "keys"
		cursorTmp = "link"
		tooltipTmp = "Kulcsok"
	end
	if bodySearchTab == "keys" then
		dxDrawImage(picX, picY, 20, 24, "files/key.dds", 0, 0, 0, useColor)
	elseif bodySearchHover == "keys" then
		dxDrawImage(picX, picY, 20, 24, "files/key.dds", 0, 0, 0, tocolor(255, 255, 255, 255))
	else
		dxDrawImage(picX, picY, 20, 24, "files/key.dds", 0, 0, 0, tocolor(255, 255, 255, 125))
	end
	picX = picX - 10 - 20
	if absX >= picX and absY >= picY and absX <= picX + 20 and absY <= picY + 24 then
		bodySearchHover = "main"
		cursorTmp = "link"
		tooltipTmp = "Tárgyak"
	end
	if bodySearchTab == "main" then
		dxDrawImage(picX, picY, 20, 24, "files/bag.dds", 0, 0, 0, useColor)
	elseif bodySearchHover == "main" then
		dxDrawImage(picX, picY, 20, 24, "files/bag.dds", 0, 0, 0, tocolor(255, 255, 255, 255))
	else
		dxDrawImage(picX, picY, 20, 24, "files/bag.dds", 0, 0, 0, tocolor(255, 255, 255, 125))
	end
	local weightTextPosX = startX + 20
	local weightTextPosY = startY + rectangleHeight - 32
	for i = 0, currentSlotLimit - 1 do
		currentLine = math.floor(i / defaultSettings.width)
		if currentLine ~= oldLine then
			currentSlot = 0
		end
		if itemsTableState == "player" and bodySearchTab == "keys" then
			i = i + currentSlotLimit
		end
		if itemsTableState == "player" and bodySearchTab == "papers" then
			i = i + currentSlotLimit * 2
		end
		bcg = slotColor
		if bodySearchList and bodySearchList[i] and hoverSec[bodySearchList[i].itemId] then
			bcg = hoverColor2
		end
		local rectanglePosX = bodyChangeX + (defaultSettings.slotBoxWidth + 5) * currentSlot + 5
		local rectanglePosY = bodyChangeY + (defaultSettings.slotBoxHeight + 5) * currentLine + 33 + 5
		if absX >= rectanglePosX and absX <= rectanglePosX + defaultSettings.slotBoxWidth and absY >= rectanglePosY and absY <= rectanglePosY + defaultSettings.slotBoxHeight then
			bcg = hoverColor
			cursorTmp = "link"
			if not currentMoving and bodySearchList and bodySearchList[i] then
				local itemId = bodySearchList[i].itemId
				if itemList[itemId] then
					local theItemName = itemList[itemId][1]
					processTooltip(absX, absY, theItemName, itemId, bodySearchList[i], false)
				end
			end
		end
		dxDrawRectangle(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, bcg)
		if bodySearchList and bodySearchList[i] then
			local picPath = "files/items/nopic.png"
			if fileExists("files/items/" .. tostring(tonumber(bodySearchList[i].itemId - 1)) .. ".png") then
				picPath = "files/items/" .. tostring(tonumber(bodySearchList[i].itemId - 1)) .. ".png"
			end
			if inNametagEditMode == i or inNametagFakeInput and inNametagFakeInput[8] == i or tempNameTag == i then
				picPath = "files/items/314_2.png"
			end
			local perishable = false
			local alpha = 255
			if perishableItems[bodySearchList[i].itemId] then
				alpha = 255 * (1 - bodySearchList[i].data3 / perishableItems[bodySearchList[i].itemId])
				perishable = grayItemPictures[bodySearchList[i].itemId]
			end
			if copyableItems[bodySearchList[i].itemId] and isTheItemCopy(bodySearchList[i]) then
				alpha = 0
				perishable = grayItemPictures[bodySearchList[i].itemId]
			end
			if perishable then
				dxDrawImage(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, perishable)
			end
			dxDrawImage(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, picPath, 0, 0, 0, tocolor(255, 255, 255, alpha))
			local dose = 1
			if doseItems[bodySearchList[i].itemId] then
				dose = tonumber(bodySearchList[i].data1)
				if dose then
					dose = 1 - dose / doseItems[bodySearchList[i].itemId]
				else
					dose = 1
				end
			end
			if dose < 1 then
				dxDrawRectangle(rectanglePosX + 3, rectanglePosY + defaultSettings.slotBoxHeight - 8 - 1, defaultSettings.slotBoxWidth - 6, 6, titlebar)
				dxDrawRectangle(rectanglePosX + 4, rectanglePosY + defaultSettings.slotBoxHeight - 8, (defaultSettings.slotBoxWidth - 8) * dose, 4, useColor)
			else
				dxDrawText(bodySearchList[i].amount, rectanglePosX + defaultSettings.slotBoxWidth - 6, rectanglePosY + defaultSettings.slotBoxHeight - 15, rectanglePosX + defaultSettings.slotBoxWidth, rectanglePosY + defaultSettings.slotBoxHeight - 15 + 5, tocolor(255, 255, 255, 255), craftFontScale * 0.75, craftFont, "right")
			end
		end
		oldLine = currentLine
		currentSlot = currentSlot + 1
	end
	if not inventoryState then
		if tooltipTmp ~= tooltip then
			tooltip = tooltipTmp
			sightexports.sGui:showTooltip(tooltip)
		end
		if cursorTmp ~= cursor then
			cursor = cursorTmp
			sightexports.sGui:setCursorType(cursor)
		end
	end
end
function toggleInventory(state)
	if inventoryState ~= state then
		setElementData(localPlayer, "inventoryState", state)
		if state then
			checkRecipeHaveItem()
			if amountBox then
				sightexports.sGui:deleteGuiElement(amountBox)
			end
			currentAmount = 0
			local currentLine = 0
			local oldLine = 0
			local currentSlot = 0
			for i = 0, currentSlotLimit - 1 do
				currentLine = math.floor(i / defaultSettings.width)
				if currentLine ~= oldLine then
					currentSlot = 0
				end
				oldLine = currentLine
				currentSlot = currentSlot + 1
			end
			amountBox = sightexports.sGui:createGuiElement("input", startX + rectangleWidth - 64 - 5, startY + 5, 64, 22)
			sightexports.sGui:setInputFont(amountBox, "10/Ubuntu-R.ttf")
			sightexports.sGui:setInputIcon(amountBox, "boxes")
			sightexports.sGui:setInputMaxLength(amountBox, 5)
			sightexports.sGui:setInputNumberOnly(amountBox, true)
			sightexports.sGui:setInputChangeEvent(amountBox, "changeInventoryAmountValue")
			sightexports.sGui:setInventoryPosition(startX, startY + 32, rectangleWidth, rectangleHeight)
			addEventHandler("onClientRender", getRootElement(), onRender, true, "low-99999999999999999")
			sightlangCondHandl0(true)
			inventoryState = true
		else
			currentAmount = 0
			if itemsTableState == "vehicle" or itemsTableState == "object" then
				triggerServerEvent("closeInventory", localPlayer, currentInventoryElement, getElementsByType("player", getRootElement(), true))
			end
			if amountBox then
				sightexports.sGui:deleteGuiElement(amountBox)
			end
			sightexports.sGui:setInventoryPosition(-1, -1, 0, 0)
			amountBox = false
			removeEventHandler("onClientRender", getRootElement(), onRender)
			sightlangCondHandl0(false)
			inventoryState = false
			sightexports.sGui:showTooltip(false)
			sightexports.sGui:setCursorType("normal")
		end
	end
end
function round2(num, idp)
	return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end
addEvent("changeInventoryAmountValue", true)
addEventHandler("changeInventoryAmountValue", getRootElement(), function(value)
	value = tonumber(value)
	if value then
		if 0 <= value then
			currentAmount = round2(value)
		else
			currentAmount = 0
		end
	else
		currentAmount = 0
	end
end)
addEvent("toggleVehicleTrunk", true)
addEventHandler("toggleVehicleTrunk", getRootElement(), function(state, vehicleElement)
	if isElement(vehicleElement) then
		local posX, posY, posZ = getElementPosition(vehicleElement)
		if state == "open" then
			playSound3D("files/dooropen.mp3", posX, posY, posZ, false)
		elseif state == "close" then
			playSound3D("files/doorclose.mp3", posX, posY, posZ, false)
		end
	end
end)
function findEmptySlotOfKeys(insertType)
	local lowestSlot = false
	for i = currentSlotLimit, currentSlotLimit * 2 - 1 do
		if not itemsTable[insertType][i] then
			lowestSlot = tonumber(i)
			break
		end
	end
	if lowestSlot then
		if lowestSlot <= currentSlotLimit * 2 then
			return tonumber(lowestSlot)
		else
			return false
		end
	else
		return false
	end
end
function findEmptySlotOfPaper(insertType)
	local lowestSlot = false
	for i = currentSlotLimit * 2, currentSlotLimit * 3 - 1 do
		if not itemsTable[insertType][i] then
			lowestSlot = tonumber(i)
			break
		end
	end
	if lowestSlot then
		if lowestSlot <= currentSlotLimit * 3 then
			return tonumber(lowestSlot)
		else
			return false
		end
	else
		return false
	end
end
function applyRecipe(recipe)
	currentRecipe = recipe
	currentCraftingItemTable = {}
	if recipe then
		checkRecipeHaveItem()
	end
end
function checkRecipeHaveItem()
	if currentTab == "crafting" and currentRecipe then
		local hasItemTable = {}
		for k, v in pairs(itemsTable[itemsTableState]) do
			hasItemTable[v.itemId] = true
		end
		for k = 1, 3 do
			currentCraftingItemTable[k] = {}
			if currentRecipe[k] then
				for k2 = 1, 3 do
					if currentRecipe[k][k2] then
						currentCraftingItemTable[k][k2] = {
							currentRecipe[k][k2],
							hasItemTable[currentRecipe[k][k2]]
						}
					end
				end
			end
		end
	end
end
function isHavePen()
	for k, v in pairs(itemsTable.player) do
		if v.itemId == 312 then
			return true
		end
	end
	return false
end
function playerHasItem(id)
	for k, v in pairs(itemsTable.player) do
		if v.itemId == id then
			return true
		end
	end
	return false
end
function playerHasItemWithData(id, data1)
	data1 = tonumber(data1) or data1
	for k, v in pairs(itemsTable.player) do
		if v.itemId == id then
			local vdata1 = tonumber(v.data1) or v.data1
			if vdata1 == data1 then
				return true
			end
		end
	end
	return false
end
function playerHasItemWithAmount(id, amount)
	amount = tonumber(data1) or amount
	local allAmount = 0
	for k, v in pairs(itemsTable.player) do
		if v.itemId == id then
			allAmount = allAmount + v.amount
		end
	end
	return allAmount >= amount
end
function penSetData()
	for k, v in pairs(itemsTable.player) do
		if v.itemId == 312 then
			local data1 = v.data1 + 1
			if 100 <= data1 then
				triggerServerEvent("takeItem", localPlayer, localPlayer, "dbID", v.dbID)
				sightexports.sGui:showInfobox("e", "Kifogyott a tollad, ezért eldobtad.")
				break
			end
			triggerServerEvent("damagePen", localPlayer, v.dbID, data1)
			break
		end
	end
	return false
end
addEvent("requestCrafting", true)
addEventHandler("requestCrafting", getRootElement(), function(recipeId, permitted, withoutNotify)
	if recipeId and availableRecipes[recipeId] then
		if permitted then
			currentlyCrafting = getTickCount()
			craftingItem = availableRecipes[recipeId][3]
			setTimer(craftDone, 10000, 1, craftingItem, withoutNotify)
		end
		craftingRequested = false
	end
end)
function craftDone(doneItem, withoutNotify)
	local itemId = doneItem[1]
	local amount = doneItem[2]
	if itemId and amount then
		local dat1 = false
		if doneItem[3] then
			dat1 = doneItem[3]
			if doneItem[4] then
				dat1 = math.random(doneItem[3], doneItem[4])
			end
		end
		if not withoutNotify then
			outputChatBox("[color=sightgreen][SightMTA]: #FFFFFFSikeresen elkészítetted a kiválasztott receptet! [color=sightblue](" .. itemList[itemId][1] .. ")", 255, 255, 255, true)
			sightexports.sGui:showInfobox("success", "Sikeresen elkészítetted a kiválasztott receptet! (" .. itemList[itemId][1] .. ")")
		end
	end
end
local bigVehicles = {
	[407] = true,
	[544] = true,
	[552] = true,
	[413] = true,
	[409] = true,
	[456] = true,
	[543] = true
}
function bootCheck(element)
	local lX, lY, lZ = getElementPosition(localPlayer)
	local eX, eY, eZ = getElementPosition(element)
	local eX, eY, eZ = getVehicleComponentPosition(element, "boot_dummy", "world")
	local _, _, rZ = getElementRotation(element)
	local multiplier = 1.5
	if not (eX and eY) or getVehicleType(element) ~= "Automobile" or bigVehicles[getElementModel(element)] then
		return true
	end
	eX, eY = eX + math.cos(math.rad(270 + rZ)) * 1.5, eY + math.sin(math.rad(270 + rZ)) * 1.5
	if getDistanceBetweenPoints3D(lX, lY, lZ, eX, eY, eZ) < 2 then
		return true
	end
	return false
end
addEventHandler("onClientKey", getRootElement(), function(key, state)
	if currentTab == "crafting" then
		if key == "mouse_wheel_up" and state then
			if 0 < recipesOffset then
				recipesOffset = recipesOffset - 1
			end
		elseif key == "mouse_wheel_down" and state then
			local lines = 8
			if recipesOffset < #craftingMenu - lines then
				recipesOffset = recipesOffset + 1
			end
		end
	end
end)
local lastItemShow = 0
function isTrashModel(clickedElement)
	local model = getElementModel(clickedElement)
	for i = 1, 7 do
		if sightexports.sModloader:getModelId("v4_trashcan" .. i) == model then
			return true
		end
	end
	return model == trashModel or model == 1439 or model == 1372 or model == 1334 or model == 1330 or model == 1331 or model == 1339 or model == 1343 or model == 1227 or model == 1246 or model == 1329 or model == 1328 or model == 2770 or model == 1358 or model == 1415 or model == 3035
end
function putDownHifi(id)
	local relativeX, relativeY, x, y, z = getCursorPosition()
	local px, py, pz = getElementPosition(localPlayer)
	local camX, camY, camZ = getCameraMatrix()
	x, y, z = x - camX, y - camY, z - camZ
	local len = math.sqrt(x * x + y * y + z * z)
	x, y, z = camX + x / len * 1000, camY + y / len * 1000, camZ + z / len * 1000
	local hit, hx, hy, hz = processLineOfSight(camX, camY, camZ, x, y, z, true, true, false, true, true, false, false, false, localPlayer)
	if hit and hx and getDistanceBetweenPoints3D(hx, hy, hz, px, py, pz) < 5 then
		local r = math.deg(math.atan2(hy - py, hx - px)) - 90
		triggerServerEvent("useItem", localPlayer, id, {
			hx,
			hy,
			hz,
			r
		})
	else
		sightexports.sGui:showInfobox("e", "Ilyen messzire nem teheted le!")
	end
end
function getVehicleOccupantsEx(veh)
	local occupants = getVehicleOccupants(veh)
	if not occupants then
		return false
	end
	local tmp = {}
	for k, v in pairs(occupants) do
		if localPlayer ~= v then
			table.insert(tmp, v)
		end
	end
	return tmp
end
local inventoryPrompt = false
local promptDbId = false
addEvent("selectInventoryListPrompt", false)
addEventHandler("selectInventoryListPrompt", getRootElement(), function(button, state, absoluteX, absoluteY, el, clickedElement)
	if isElement(clickedElement) then
		moveItemToElement(clickedElement, promptDbId)
	end
	if inventoryPrompt then
		sightexports.sGui:deleteGuiElement(inventoryPrompt)
	end
	inventoryPrompt = nil
	promptDbId = false
end)
function createVehicleListPrompt(clickedElement, occupants, dbID)
	promptDbId = dbID
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	if inventoryPrompt then
		sightexports.sGui:deleteGuiElement(inventoryPrompt)
	end
	inventoryPrompt = nil
	local selfVeh = getPedOccupiedVehicle(localPlayer) == clickedElement
	local panelWidth = 325
	local panelHeight = titleBarHeight + 35 * (#occupants + 1 + (selfVeh and 0 or 1)) + 5
	inventoryPrompt = sightexports.sGui:createGuiElement("window", screenX / 2 - panelWidth / 2, screenY / 2 - panelHeight / 2, panelWidth, panelHeight)
	sightexports.sGui:setWindowTitle(inventoryPrompt, "16/BebasNeueRegular.otf", "Item átadás")
	if not selfVeh then
		local btn = sightexports.sGui:createGuiElement("button", 5, titleBarHeight + 5, panelWidth - 10, 30, inventoryPrompt)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(btn, " Jármű")
		sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("car", 30))
		sightexports.sGui:setClickEvent(btn, "selectInventoryListPrompt")
		sightexports.sGui:setClickArgument(btn, clickedElement)
	end
	for i = 1, #occupants do
		local btn = sightexports.sGui:createGuiElement("button", 5, titleBarHeight + 5 + 35 * (i - (selfVeh and 1 or 0)), panelWidth - 10, 30, inventoryPrompt)
		sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(btn, "gradient", {
			"sightgreen",
			"sightgreen-second"
		}, false, true)
		sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
		sightexports.sGui:setButtonText(btn, " " .. getElementData(occupants[i], "visibleName"):gsub("_", " "))
		sightexports.sGui:setButtonIcon(btn, sightexports.sGui:getFaIconFilename("user", 30))
		sightexports.sGui:setClickEvent(btn, "selectInventoryListPrompt")
		sightexports.sGui:setClickArgument(btn, occupants[i])
	end
	local btn = sightexports.sGui:createGuiElement("button", 5, panelHeight - 30 - 5, panelWidth - 10, 30, inventoryPrompt)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightred")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightred",
		"sightred-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "15/BebasNeueBold.otf")
	sightexports.sGui:setButtonText(btn, "Mégsem")
	sightexports.sGui:setClickEvent(btn, "selectInventoryListPrompt")
end
function moveItemToElement(clickedElement, fromPrompt)
	local tstate = itemsTableState
	if fromPrompt then
		tstate = "player"
		currentMoving = false
		for i, v in pairs(itemsTable[tstate]) do
			if v.dbID == fromPrompt then
				currentMoving = i
			end
		end
		if not currentMoving then
			return
		end
	end
	if itemsTable[tstate][currentMoving] and not itemsTable[tstate][currentMoving].locked and allowedToMoveInUse(itemsTable[tstate][currentMoving].dbID) and not onActionBar and not onInventory then
		if isElement(clickedElement) then
			local sourcePosX, sourcePosY, sourcePosZ = getElementPosition(localPlayer)
			local targetPosX, targetPosY, targetPosZ = getElementPosition(clickedElement)
			if getElementType(clickedElement) == "object" and isTrashModel(clickedElement) and not getElementAttachedTo(clickedElement) and tstate == "player" then
				if getDistanceBetweenPoints3D(sourcePosX, sourcePosY, sourcePosZ, targetPosX, targetPosY, targetPosZ) <= 2 then
					if itemsTable[tstate][currentMoving].itemId == 313 then
						outputChatBox("[color=sightred][SightMTA - Hiba]: [color=hudwhite]Ezt az tárgyat nem dobhatod ki")
						return
					end

					if itemList[itemsTable[tstate][currentMoving].itemId] then
						local theItemName = itemList[itemsTable[tstate][currentMoving].itemId][1]
						if itemsTable[tstate][currentMoving].nameTag then
							theItemName = theItemName .. " (" .. itemsTable[tstate][currentMoving].nameTag .. ")"
						end
						local finalItemName = ""
						if 1 < itemsTable[tstate][currentMoving].amount then
							finalItemName = itemsTable[tstate][currentMoving].amount .. " darab " .. theItemName
						else
							finalItemName = theItemName
						end
						sightexports.sChat:localActionC(localPlayer, "kidobott egy tárgyat a szemetesbe. (" .. finalItemName .. ")")
						triggerServerEvent("playTrashSound", localPlayer, getElementModel(clickedElement), {itemsTable[tstate][currentMoving].dbID, theItemName, itemsTable[tstate][currentMoving].itemId, itemsTable[tstate][currentMoving].amount })
					else
						sightexports.sChat:localActionC(localPlayer, "kidobott egy tárgyat a szemetesbe.")
					end
					triggerServerEvent("takeItem", localPlayer, localPlayer, "dbID", itemsTable[tstate][currentMoving].dbID)
				end
			else
				if checkDutyData3(itemsTable[tstate][currentMoving].data3) then
					outputChatBox("[color=sightred][SightMTA]: #FFFFFFSzolgálati eszközzel ezt nem teheted meg!", 255, 255, 255, true)
					currentMoving = false
					haveMoving = false
					playSound("files/sounds/moveerror.wav")
					return
				end
				if (itemsTable[tstate][currentMoving].data3) == "airsoft" then
					outputChatBox("[color=sightred][SightMTA]: #FFFFFFAirsoft fegyverrel ezt nem teheted meg!", 255, 255, 255, true)
					currentMoving = false
					haveMoving = false
					playSound("files/sounds/moveerror.wav")
					return
				end
				local dist = 4
				if getElementModel(clickedElement) == 454 then
					dist = 8
				end
				if dist >= getDistanceBetweenPoints3D(sourcePosX, sourcePosY, sourcePosZ, targetPosX, targetPosY, targetPosZ) then
					local group = illegalItemPeds[clickedElement]
					if group then
						local itemId = itemsTable[tstate][currentMoving].itemId
						local dbID = itemsTable[tstate][currentMoving].dbID
						currentMoving = false
						haveMoving = false
						if illegalItemDropoffs[itemId] then
							triggerServerEvent("deleteIllegalItemFromPlayer", localPlayer, group, dbID)
						else
							sightexports.sGui:showInfobox("e", "Ez a tárgy nem adható le!")
						end
						return
					end
					local elementType = getElementType(clickedElement)
					local elementId = false
					if elementType == "player" then
						elementId = getElementData(clickedElement, defaultSettings.characterId)
					elseif elementType == "vehicle" then
						elementId = getElementData(clickedElement, defaultSettings.vehicleId)
					elseif elementType == "object" then
						elementId = getElementData(clickedElement, defaultSettings.objectId)
					end
					elementId = tonumber(elementId)
					if getElementModel(clickedElement) == sightexports.sModloader:getModelId("farm:crate") and sightexports.sFarm:canPlaceItemToCrate(clickedElement, itemsTable[tstate][currentMoving].itemId, itemsTable[tstate][currentMoving].amount) then
						triggerServerEvent("placeItemToFarmCrate", localPlayer, clickedElement, itemsTable[tstate][currentMoving].dbID)
						currentMoving = false
						haveMoving = false
						return
					end
					if elementType == "ped" then
						if getElementData(clickedElement, "farmDealer") then
							if getElementData(clickedElement, "farmDealer") == itemsTable[tstate][currentMoving].itemId then
								sightexports.sFarm:startFarmDeal(itemsTable[tstate][currentMoving].dbID, itemsTable[tstate][currentMoving].itemId, itemsTable[tstate][currentMoving].amount, clickedElement)
								currentMoving = false
								haveMoving = false
								return
							else
								outputChatBox("[color=sightred][SightMTA]: #FFFFFFEzt a termést egy másik NPC-nél adhatod el!", 255, 255, 255, true)
								currentMoving = false
								haveMoving = false
								return
							end
						end
						if getElementData(clickedElement, "moneyStackBuyer") and newItemList[itemsTable[tstate][currentMoving].itemId].isMoneyStack then
							triggerServerEvent("tryToSellMoneyStack", localPlayer, false, itemsTable[tstate][currentMoving].dbID)
                            currentMoving = false
                            haveMoving = false
                            return
                          end
						if getElementData(clickedElement, "isLottery") then
							if itemsTable[tstate][currentMoving].itemId == 294 then
								triggerServerEvent("tryToConvertLottery", localPlayer, itemsTable[tstate][currentMoving].dbID)
								currentMoving = false
								haveMoving = false
								return
							elseif itemsTable[tstate][currentMoving].itemId == 295 then
								triggerServerEvent("checkLotteryWin", localPlayer, itemsTable[tstate][currentMoving].dbID)
								currentMoving = false
								haveMoving = false
								return
							end
						end
						if getElementData(clickedElement, "isScratchPed") and sightexports.sLottery:isScratchTicket(itemsTable[tstate][currentMoving].itemId) then
							sightexports.sLottery:verifyScratch(itemsTable[tstate][currentMoving].itemId, itemsTable[tstate][currentMoving].dbID, itemsTable[tstate][currentMoving].data2)
							currentMoving = false
							haveMoving = false
							return
						end
					elseif elementType == "player" and clickedElement == localPlayer and tstate == "player" then
						currentMoving = false
						haveMoving = false
						playSound("files/sounds/moveerror.wav")
						return
					end
					if getElementType(currentInventoryElement) == "vehicle" or getElementType(currentInventoryElement) == "object" then
						if elementType ~= "player" then
							outputChatBox("[color=sightred][SightMTA]: #FFFFFFJárműből / széfből csak a saját inventorydba pakolhatsz.", 255, 255, 255, true)
							currentMoving = false
							haveMoving = false
							playSound("files/sounds/moveerror.wav")
							return
						elseif clickedElement ~= localPlayer then
							outputChatBox("[color=sightred][SightMTA]: #FFFFFFJárműből / széfből csak a saját inventorydba pakolhatsz.", 255, 255, 255, true)
							currentMoving = false
							haveMoving = false
							playSound("files/sounds/moveerror.wav")
							return
						end
					end
					if getElementType(clickedElement) == "vehicle" and not fromPrompt then
						local occupants = getVehicleOccupantsEx(clickedElement)
						if 0 < #occupants then
							createVehicleListPrompt(clickedElement, occupants, itemsTable[tstate][currentMoving].dbID)
							return
						end
					end
					if elementId or getElementData(clickedElement, "sightmarket:buyerped") == getElementData(localPlayer, "char.ID") then
						itemsTable[tstate][currentMoving].locked = true
						triggerServerEvent("moveItem", localPlayer, itemsTable[tstate][currentMoving].dbID, itemsTable[tstate][currentMoving].itemId, currentMoving, clickedSlot, currentAmount, currentInventoryElement, clickedElement)
						currentMoving = false
						haveMoving = false
						return
					elseif tstate == "player" and newItemList[itemsTable[tstate][currentMoving].itemId].simpleUse == "hifi" then
						putDownHifi(itemsTable[tstate][currentMoving].dbID)
					else
						outputChatBox("[color=sightred][SightMTA]: #FFFFFFA kiválasztott elem nem rendelkezik önálló tárterülettel!", 255, 255, 255, true)
						playSound("files/sounds/moveerror.wav")
					end
				elseif tstate == "player" and newItemList[itemsTable[tstate][currentMoving].itemId].simpleUse == "hifi" then
					putDownHifi(itemsTable[tstate][currentMoving].dbID)
				end
			end
		elseif tstate == "player" and newItemList[itemsTable[tstate][currentMoving].itemId].simpleUse == "hifi" then
			putDownHifi(itemsTable[tstate][currentMoving].dbID)
			currentMoving = false
			haveMoving = false
			return
		elseif tstate == "player" then
			currentMoving = false
			haveMoving = false
			return
		end
	end
end
addEventHandler("onClientClick", getRootElement(), function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	if inNametagFakeInput then
		if inNametagFakeInput[6] and state == "up" then
			if inNametagFakeInput[6] == "ok" then
				if inNametagFakeInput[3] == inNametagFakeInput[9] then
					sightexports.sGui:showInfobox("e", "Nem lehet ugyan az a név, mint volt!")
					return
				end
				if utf8.len(inNametagFakeInput[3]) >= 1 then
					tempNameTag = itemsTable.player[inNametagFakeInput[8]].dbID
					triggerServerEvent("tryToRenameItem", localPlayer, inNametagFakeInput[3], inNametagFakeInput[7], tempNameTag)
				else
					sightexports.sGui:showInfobox("e", "Nem lehet üres a név!")
					return
				end
			end
			inNametagFakeInput = false
		end
		return
	end
	if inNametagEditMode then
		if state == "up" then
			local clickedSlot, originalX, originalY = findSlot(absoluteX, absoluteY)
			if clickedSlot and itemsTable.player[clickedSlot] then
				if itemsTable.player[clickedSlot].amount ~= 1 then
					sightexports.sGui:showInfobox("e", "Stackelt itemet nem lehet elnevezni.")
					return
				end
				if checkDutyData3(itemsTable.player[clickedSlot].data3) then
					sightexports.sGui:showInfobox("e", "Duty itemet nem lehet elnevezni.")
					return
				end
				if itemsTable.player[clickedSlot].itemId == 61 or itemsTable.player[clickedSlot].itemId == 62 or itemsTable.player[clickedSlot].itemId == 63 or itemsTable.player[clickedSlot].itemId == 150 then
					sightexports.sGui:showInfobox("e", "Ezt az itemet nem lehet elnevezni.")
					return
				end
				if itemsTable.player[clickedSlot].itemId ~= 315 then
					inNametagFakeInput = {
						absoluteX,
						absoluteY,
						itemsTable.player[clickedSlot].nameTag or "",
						getTickCount(),
						true,
						false,
						itemsTable.player[clickedSlot].dbID,
						inNametagEditMode,
						itemsTable.player[clickedSlot].nameTag or ""
					}
				end
			end
			if tabHover then
				if currentTab ~= tabHover then
					currentTab = tabHover
					itemCount = 0
					currentWeight = 0
					for k, v in pairs(itemsTable[itemsTableState]) do
						if itemList[v.itemId] then
							local baseWeight = itemList[v.itemId][10]
							currentWeight = currentWeight + baseWeight * v.amount
						end
						if itemsTableState == "player" then
							if currentTab == "keys" then
								if v.slot >= 50 and v.slot < 100 then
									itemCount = itemCount + 1
								end
							elseif currentTab == "papers" then
								if v.slot >= 100 then
									itemCount = itemCount + 1
								end
							elseif v.slot < 50 then
								itemCount = itemCount + 1
							end
						else
							itemCount = itemCount + 1
						end
					end
					recalcSlot()
					playSound("files/sounds/tabswitch.wav")
					playSound("files/sounds/moveselect.wav")
				end
			else
				inNametagEditMode = false
			end
		end
		return
	end
	if button == "left" then
		if state == "down" and bodySearchHover then
			bodySearchTab = bodySearchHover
			return
		end
		if inventoryState then
			if not isMoving then
				if state == "down" then
					if absoluteX >= startX and absoluteX < startX + rectangleWidth and absoluteY >= startY and absoluteY < startY + 33 and not tabHover then
						moveDifferenceX = absoluteX - startX
						moveDifferenceY = absoluteY - startY
						isMoving = true
						return
					end
					if itemsTableState == "player" and tabHover then
						if currentTab ~= tabHover then
							currentTab = tabHover
							itemCount = 0
							currentWeight = 0
							recalcSlot()
							for k, v in pairs(itemsTable[itemsTableState]) do
								if itemList[v.itemId] then
									local baseWeight = itemList[v.itemId][10]
									currentWeight = currentWeight + baseWeight * v.amount
								end
								if itemsTableState == "player" then
									if currentTab == "keys" then
										if v.slot >= 50 and v.slot < 100 then
											itemCount = itemCount + 1
										end
									elseif currentTab == "papers" then
										if v.slot >= 100 then
											itemCount = itemCount + 1
										end
									elseif v.slot < 50 then
										itemCount = itemCount + 1
									end
								else
									itemCount = itemCount + 1
								end
							end
							playSound("files/sounds/tabswitch.wav")
							playSound("files/sounds/moveselect.wav")
						end
						if currentTab == "crafting" then
							checkRecipeHaveItem()
						end
					end
					if currentTab == "crafting" and canCraft and not craftingRequested then
						playSound("files/craftstart.mp3")
						if not playerRecipes[selectedCraftingRecipe] and not defaultKnownRecipes[selectedCraftingRecipe] and (availableRecipes[selectedCraftingRecipe][4] ~= "job" or not playerHasTheJob) then
							outputChatBox("[color=sightred][SightMTA]: #FFFFFFEzt a receptet még nem tanultad meg!", 255, 255, 255, true)
							return
						end
						if availableRecipes[selectedCraftingRecipe][5] then
							local foundPosition = false
							if type(availableRecipes[selectedCraftingRecipe][5]) == "table" then
								for k, v in pairs(availableRecipes[selectedCraftingRecipe][5]) do
									if currentCraftingPosition and currentCraftingPosition == k then
										foundPosition = true
										break
									end
								end
							else
								foundPosition = true
							end
							if not foundPosition then
								sightexports.sGui:showInfobox("e", "Csak a megfelelő helyszínen készítheted el ezt a receptet!")
								return
							end
						end
						triggerServerEvent("requestCrafting", localPlayer, selectedCraftingRecipe)
						return
					end
					if currentTab == "crafting" and hoveringCategory then
						categoryCollapsed[hoveringCategory] = not categoryCollapsed[hoveringCategory]
						craftingMenu = {}
						local categoriesAdded = {}
						local currentCaregory = false
						for k = 1, maxRecipe do
							if recipesToSort[k][1] ~= "null" then
								if not categoriesAdded[recipesToSort[k][6]] then
									categoriesAdded[recipesToSort[k][6]] = true
									table.insert(craftingMenu, {
										"category",
										recipesToSort[k][6],
										categoryCollapsed[recipesToSort[k][6]]
									})
									currentCaregory = #craftingMenu
								end
								if craftingMenu[currentCaregory][3] then
									table.insert(craftingMenu, {
										"recipe",
										recipesToSort[k].id
									})
								elseif selectedCraftingRecipe == recipesToSort[k].id then
									selectedCraftingRecipe = false
									applyRecipe(false)
								end
							end
						end
						if 8 < #craftingMenu then
							if recipesOffset > #craftingMenu - 8 then
								recipesOffset = #craftingMenu - 8
							end
						else
							recipesOffset = 0
						end
					end
					if currentTab == "crafting" and hoveringItem and hoveringItem ~= selectedCraftingRecipe and not currentlyCrafting and not craftingRequested then
						selectedCraftingRecipe = hoveringItem
						applyRecipe(availableRecipes[selectedCraftingRecipe][2])
						playSound("files/sounds/moveselect.wav")
					end
					local clickedSlot, originalX, originalY = findSlot(absoluteX, absoluteY)
					if clickedSlot and itemsTable[itemsTableState][clickedSlot] then
						if currentTab == "crafting" and itemsTableState ~= "vehicle" and itemsTableState ~= "object" then
							return
						end
						if allowedToMoveInUse(itemsTable[itemsTableState][clickedSlot].dbID) then
							itemMoveDifferenceX = absoluteX - originalX
							itemMoveDifferenceY = absoluteY - originalY
							currentMoving = clickedSlot
							haveMoving = clickedSlot
							playSound("files/sounds/moveselect.wav")
						else
							outputChatBox("#DC143C[SightMTA]: #FFFFFFA használatban lévő itemet nem mozgathatsz!", 255, 255, 255, true)
						end
					end
				elseif state == "up" then
					if currentMoving then
						if absoluteX >= startX + rectangleWidth / 2 - 32 and absoluteY >= startY - 5 - 64 and absoluteX <= startX + rectangleWidth / 2 + 32 and absoluteY <= startY - 5 then
							if getTickCount() - lastItemShow > 6000 then
								if itemList[itemsTable[itemsTableState][currentMoving].itemId] then
									sightexports.sChat:localActionC(localPlayer, "felmutat egy tárgyat: " .. itemList[itemsTable[itemsTableState][currentMoving].itemId][1] .. ".")
								else
									sightexports.sChat:localActionC(localPlayer, "felmutat egy tárgyat.")
								end
								lastItemShow = getTickCount()
								triggerServerEvent("showTheItem", localPlayer, itemsTable[itemsTableState][currentMoving], getElementsByType("player", getRootElement(), true))
							end
							currentMoving = false
							haveMoving = false
							return
						end
						if tonumber(itemsTable[itemsTableState][currentMoving].itemId) == 370 and clickedElement and clickedElement ~= localPlayer and not clickedSlot and (not (getElementType(clickedElement) == "object" and isTrashModel(clickedElement)) or getElementAttachedTo(clickedElement) or itemsTableState ~= "player") then
							outputChatBox("[color=sightred][SightMTA]: #FFFFFFEzt az itemet csak a kukába dobhatod.", 255, 255, 255, true)
							return
						end
						local clickedSlot = findSlot(absoluteX, absoluteY)
						if clickedSlot then
							local currentAmount = currentAmount
							if itemsTable[itemsTableState][currentMoving].itemId == 55 or itemsTable[itemsTableState][currentMoving].itemId == 429 then
								currentAmount = 0
							end
							if itemsTableState == "player" and isKeyItem(itemsTable[itemsTableState][currentMoving].itemId) and clickedSlot < currentSlotLimit then
								clickedSlot = findEmptySlotOfKeys("player")
								if not clickedSlot then
									return
								end
								outputChatBox("[color=sightred][SightMTA]: #FFFFFFEz az item átkerült a kulcsokhoz!", 255, 255, 255, true)
							end
							if itemsTableState == "player" and isPaperItem(itemsTable[itemsTableState][currentMoving].itemId) and clickedSlot < currentSlotLimit then
								clickedSlot = findEmptySlotOfPaper("player")
								if not clickedSlot then
									return
								end
								outputChatBox("[color=sightred][SightMTA]: #FFFFFFEz az item átkerült az iratokhoz!", 255, 255, 255, true)
							end
							if currentMoving ~= clickedSlot and itemsTable[itemsTableState][currentMoving] then
								if clickedSlot >= currentSlotLimit * 2 and not isPaperItem(itemsTable[itemsTableState][currentMoving].itemId) then
									outputChatBox("[color=sightred][SightMTA]: #FFFFFFEz nem irat!", 255, 255, 255, true)
									clickedSlot = findEmptySlot("player")
								elseif clickedSlot >= currentSlotLimit and clickedSlot < currentSlotLimit * 2 and not isKeyItem(itemsTable[itemsTableState][currentMoving].itemId) then
									outputChatBox("[color=sightred][SightMTA]: #FFFFFFEz nem kulcs item!", 255, 255, 255, true)
									clickedSlot = findEmptySlot("player")
								end
								if not itemsTable[itemsTableState][currentMoving].locked and allowedToMoveInUse(itemsTable[itemsTableState][currentMoving].dbID) then
									if not itemsTable[itemsTableState][clickedSlot] then
										if 0 <= currentAmount then
											if clickedSlot and clickedSlot > realSlotLimit then
												sightexports.sGui:showInfobox("e", "Ezt a slotot nem használhatod!")
												currentMoving = false
												return
											end
											triggerServerEvent("moveItem", localPlayer, itemsTable[itemsTableState][currentMoving].dbID, itemsTable[itemsTableState][currentMoving].itemId, currentMoving, clickedSlot, currentAmount, currentInventoryElement, currentInventoryElement)
											playSound("files/sounds/movesucces.wav")
											if currentAmount >= itemsTable[itemsTableState][currentMoving].amount or currentAmount <= 0 then
												itemsTable[itemsTableState][clickedSlot] = itemsTable[itemsTableState][currentMoving]
												itemsTable[itemsTableState][clickedSlot].slot = clickedSlot
												itemsTable[itemsTableState][currentMoving] = nil
											elseif 0 < currentAmount then
												itemsTable[itemsTableState][currentMoving].amount = itemsTable[itemsTableState][currentMoving].amount - currentAmount
											end
										end
									else
										local movingItemId = itemsTable[itemsTableState][currentMoving].itemId
										local toItemId = itemsTable[itemsTableState][clickedSlot].itemId
										if newItemList[movingItemId].fishingLine then
											if itemsTableState ~= "player" then
												sightexports.sGui:showInfobox("e", "Nem használhatod széfben/járműben.")
											elseif newItemList[toItemId].use == "fishingRod" then
												triggerServerEvent("useFishingLine", localPlayer, itemsTable[itemsTableState][currentMoving].dbID, itemsTable[itemsTableState][clickedSlot].dbID)
											else
												sightexports.sGui:showInfobox("e", "A damilt csak horgászbotra szerelheted fel.")
											end
										elseif newItemList[movingItemId].fishingFloat then
											if itemsTableState ~= "player" then
												sightexports.sGui:showInfobox("e", "Nem használhatod széfben/járműben.")
											elseif newItemList[toItemId].use == "fishingRod" then
												triggerServerEvent("useFishingFloater", localPlayer, itemsTable[itemsTableState][currentMoving].dbID, itemsTable[itemsTableState][clickedSlot].dbID)
											else
												sightexports.sGui:showInfobox("e", "Az úszót csak horgászbotra szerelheted fel.")
											end
										elseif movingItemId == 406 then
											if itemsTableState ~= "player" then
												sightexports.sGui:showInfobox("e", "Nem használhatod széfben/járműben.")
											else
												triggerServerEvent("fixSkinWeapon", localPlayer, itemsTable[itemsTableState][currentMoving].dbID, itemsTable[itemsTableState][clickedSlot].dbID)
											end
										elseif movingItemId == 430 then
											if itemsTableState ~= "player" then
												sightexports.sGui:showInfobox("e", "Nem használhatod széfben/járműben.")
											elseif toItemId == 55 then
												triggerServerEvent("setWaterCanToSpecial", localPlayer, itemsTable[itemsTableState][currentMoving].dbID, itemsTable[itemsTableState][clickedSlot].dbID)
											else
												sightexports.sGui:showInfobox("e", "Csak vizes kannába tehetsz tápszert.")
											end
										elseif movingItemId == toItemId and isItemStackable(toItemId) and toItemId ~= 429 and toItemId ~= 55 then
											if itemsTable[itemsTableState][clickedSlot].nameTag then
												sightexports.sGui:showInfobox("e", "Elnevezett itemet nem lehet stackelni.")
											elseif itemsTable[itemsTableState][currentMoving].nameTag then
												sightexports.sGui:showInfobox("e", "Elnevezett itemet nem lehet stackelni.")
											elseif 0 <= currentAmount then
												if doseItems[movingItemId] and 0 < (tonumber(itemsTable[itemsTableState][currentMoving].data1) or 0) then
													sightexports.sGui:showInfobox("e", "Megkezdett itemet nem lehet stackelni.")
													return
												end
												if doseItems[toItemId] and 0 < (tonumber(itemsTable[itemsTableState][clickedSlot].data1) or 0) then
													sightexports.sGui:showInfobox("e", "Megkezdett itemet nem lehet stackelni.")
													return
												end
												local localAmount = currentAmount
												if currentAmount <= 0 or currentAmount >= itemsTable[itemsTableState][currentMoving].amount then
													localAmount = itemsTable[itemsTableState][currentMoving].amount
												end
												if (checkDutyData3(itemsTable[itemsTableState][currentMoving].data3) or checkDutyData3(itemsTable[itemsTableState][clickedSlot].data3)) and itemsTable[itemsTableState][currentMoving].data3 ~= itemsTable[itemsTableState][clickedSlot].data3 then
													outputChatBox("[color=sightred][SightMTA]: #FFFFFFSzolgálati eszközzel ezt nem teheted meg!", 255, 255, 255, true)
													currentMoving = false
													haveMoving = false
													return
												end
												playSound("files/sounds/movesucces.wav")
												if 0 < itemsTable[itemsTableState][currentMoving].amount - localAmount then
													triggerServerEvent("stackItem", localPlayer, currentInventoryElement, itemsTable[itemsTableState][currentMoving].dbID, itemsTable[itemsTableState][clickedSlot].dbID, localAmount)
												else
													triggerServerEvent("stackItem", localPlayer, currentInventoryElement, itemsTable[itemsTableState][currentMoving].dbID, itemsTable[itemsTableState][clickedSlot].dbID, localAmount)
												end
											end
										end
									end
								end
							end
						else
							local actionBarSlot = findActionBarSlot(absoluteX, absoluteY)
							if actionBarSlot then
								if itemsTableState == "player" then
									if itemsTable[itemsTableState][currentMoving].itemId == 315 then
										sightexports.sGui:showInfobox("e", "Névcédulát nem helyezhetsz az actionbarra.")
									else
										putOnActionBar(actionBarSlot, itemsTable[itemsTableState][currentMoving])
										playSound("files/sounds/movesucces.wav")
									end
								end
							else
								local onActionBar = isPointOnActionBar(absoluteX, absoluteY)
								local onInventory = isPointOnInventory(absoluteX, absoluteY)
								moveItemToElement(clickedElement)
							end
						end
						currentMoving = false
						haveMoving = false
					elseif not (absoluteX >= exitPosX and absoluteX <= exitPosX + 60 and absoluteY >= exitPosY) or absoluteY <= exitPosY + 25 then
					end
				end
			elseif inventoryState and state == "up" then
				isMoving = false
			end
		end
	elseif button == "right" and state == "up" then
		local clickedSlot = false
		if inventoryState then
			clickedSlot = findSlot(absoluteX, absoluteY)
			if clickedSlot and currentInventoryElement == localPlayer and itemsTable.player[clickedSlot] then
				useItem(itemsTable.player[clickedSlot].dbID)
				currentMoving = false
				haveMoving = false
			end
		end
		if not clickedSlot and isElement(clickedElement) and clickedElement ~= localPlayer then
			local sourcePosX, sourcePosY, sourcePosZ = getElementPosition(localPlayer)
			local targetPosX, targetPosY, targetPosZ = getElementPosition(clickedElement)
			local worldItemId = tonumber(getElementData(clickedElement, "worldItem"))
			if not worldItemId then
				local dist = 4
				if getElementModel(clickedElement) == 454 then
					dist = 8
				end
				local counted = getDistanceBetweenPoints3D(sourcePosX, sourcePosY, sourcePosZ, targetPosX, targetPosY, targetPosZ)
				if dist >= counted then
					local elementType = getElementType(clickedElement)
					local elementId = false
					if elementType == "vehicle" then
						elementId = getElementData(clickedElement, defaultSettings.vehicleId)
						if getElementModel(clickedElement) == 448 then
							return
						end
						if getElementModel(clickedElement) == 498 then
							return
						end
						if sightexports.sHud:getWidgetEditMode() then
							return
						end
						if not bootCheck(clickedElement) then
							local ws = exports.sPaintshop:isPlayerInWorkshop()
							if not sightexports.sHud:getHudDisabled() and not ws then
								sightexports.sGui:showInfobox("error", "Csak a jármű csomagtartójánál állva nézhetsz bele a csomagterébe!")
							end
							return
						end
						if getElementData(localPlayer, "cuffed") then
							sightexports.sGui:showInfobox("e", "Bilincsben nem nézhetsz bele a csomagtartóba!")
							return
						end
						if getPedOccupiedVehicle(localPlayer) then
							if not sightexports.sHud:getHudDisabled() then
								outputChatBox("[color=sightred][SightMTA]: #FFFFFFJárműben ülve nem nézhetsz bele a csomagtartóba!", 255, 255, 255, true)
							end
							return
						end
						if isVehicleLocked(clickedElement) then
							if not sightexports.sHud:getHudDisabled() then
								outputChatBox("[color=sightred][SightMTA]: #FFFFFFA jármű zárva van!", 255, 255, 255, true)
							end
							return
						end
					elseif elementType == "object" then
						elementId = getElementData(clickedElement, defaultSettings.objectId)
					end
					elementId = tonumber(elementId)
					if elementId then
						triggerServerEvent("requestItems", localPlayer, clickedElement, elementId, elementType, getElementsByType("player", getRootElement(), true))
					else
					end
				end
			elseif 5 >= getDistanceBetweenPoints3D(sourcePosX, sourcePosY, sourcePosZ, targetPosX, targetPosY, targetPosZ) then
				triggerServerEvent("pickUpItem", localPlayer, worldItemId)
			else
				outputChatBox("[color=sightred][SightMTA]: #FFFFFFA kiválasztott tárgy túl messze van tőled!", 255, 255, 255, true)
			end
		end
	end
end)
function findSlot(absoluteX, absoluteY)
	if inventoryState then
		local currentLine = 0
		local oldLine = 0
		local currentSlot = 0
		local foundSlot, originalX, originalY = false, false, false
		for i = 0, currentSlotLimit - 1 do
			currentLine = math.floor(i / defaultSettings.width)
			if currentLine ~= oldLine then
				currentSlot = 0
			end
			local rectanglePosX = startX + (defaultSettings.slotBoxWidth + 5) * currentSlot + 5
			local rectanglePosY = startY + (defaultSettings.slotBoxHeight + 5) * currentLine + 33 + 5
			if absoluteX >= rectanglePosX and absoluteX <= rectanglePosX + defaultSettings.slotBoxWidth and absoluteY >= rectanglePosY and absoluteY <= rectanglePosY + defaultSettings.slotBoxHeight then
				originalX = rectanglePosX
				originalY = rectanglePosY
				foundSlot = i
				break
			end
			oldLine = currentLine
			currentSlot = currentSlot + 1
		end
		if foundSlot then
			if itemsTableState == "player" and currentTab == "keys" then
				foundSlot = foundSlot + currentSlotLimit
			end
			if itemsTableState == "player" and currentTab == "papers" then
				foundSlot = foundSlot + currentSlotLimit * 2
			end
			return tonumber(foundSlot), originalX, originalY
		else
			return false
		end
	else
		return false
	end
end
function isPointOnInventory(absoluteX, absoluteY)
	if inventoryState then
		local currentLine = 0
		local oldLine = 0
		local currentSlot = 0
		for i = 0, currentSlotLimit - 1 do
			currentLine = math.floor(i / defaultSettings.width)
			if currentLine ~= oldLine then
				currentSlot = 0
			end
			oldLine = currentLine
			currentSlot = currentSlot + 1
		end
		if absoluteX >= startX and absoluteX <= startX + rectangleWidth and absoluteY >= startY and absoluteY <= startY + 33 then
			return true
		else
			return false
		end
	else
		return false
	end
end
function getLocalPlayerItems()
	return itemsTable.player
end
function getLocalPlayerItemsEx()
	local dat = sightexports.sItems:getLocalPlayerItems()
	local list = {}
	for k, v in pairs(dat) do
		table.insert(list, {
			v,
			itemList[v.itemId] and itemList[v.itemId][1] or "n/a",
			itemList[v.itemId] and itemList[v.itemId][2] or "n/a"
		})
	end
	return list
end
function setHoverItem(i, data)
	if hoverItem ~= i then
		hoverItem = i
		hoverItemId = false
		for j in pairs(hoverSec) do
			hoverSec[j] = nil
		end
		if i then
			if data then
				local id = data.itemId
				hoverItemId = id
				if newItemList[id].ammoId then
					hoverSec[newItemList[id].ammoId] = true
				end
				if newItemList[id].weaponItemIds then
					for j = 1, #newItemList[id].weaponItemIds do
						hoverSec[newItemList[id].weaponItemIds[j]] = true
					end
				end
			end
			playSound("files/sounds/hover.wav")
		end
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	for k, v in pairs(perishableItems) do
		local texture = dxCreateTexture(getItemPic(k), "argb")
		grayItemPictures[k] = dxCreateShader("files/blackwhite.fx")
		dxSetShaderValue(grayItemPictures[k], "screenSource", texture)
	end
	for k, v in pairs(copyableItems) do
		local texture = dxCreateTexture(getItemPic(k), "argb")
		grayItemPictures[k] = dxCreateShader("files/blackwhite.fx")
		dxSetShaderValue(grayItemPictures[k], "screenSource", texture)
	end
	removeWorldModel(14449, 100, 2565.55078125, -1293.3515625, 1060.984375, 2)
end)
local insectPlayers = {}
addEventHandler("onClientElementDataChange", getRootElement(), function(data)
	if data == "insectPlayers" then
		if isElement(insectPlayers[source]) then
			destroyElement(insectPlayers[source])
		end
		if getElementData(source, data) then
			insectPlayers[source] = createEffect("insects", 0, 0, 0)
			setEffectDensity(insectPlayers[source], 2)
			sightlangCondHandl1(true)
		else
			insectPlayers[source] = nil
		end
	end
end)
function renderInsects()
	for k, v in pairs(insectPlayers) do
		if not isElement(k) then
			if isElement(v) then
				destroyElement(v)
			end
			insectPlayers[k] = nil
			return
		end
		local x, y, z = getElementPosition(k)
		setElementPosition(v, x, y, z)
		local int = getElementInterior(k)
		local dim = getElementDimension(k)
		setElementInterior(v, int)
		setElementDimension(v, dim)
	end
	for k, v in pairs(insectPlayers) do
		return
	end
	sightlangCondHandl1(false)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function(data)
	for k, v in ipairs(getElementsByType("player")) do
		local data = "insectPlayers"
		if isElement(insectPlayers[v]) then
			destroyElement(insectPlayers[v])
		end
		if getElementData(v, data) then
			insectPlayers[v] = createEffect("insects", 0, 0, 0)
			setEffectDensity(insectPlayers[v], 2)
			sightlangCondHandl1(true)
		else
			insectPlayers[v] = nil
		end
	end
end)
local showItem = {}
local SItemRoboto = false
local showItemState = false
addEvent("showTheItem", true)
addEventHandler("showTheItem", getRootElement(), function(item)
	local rt = dxCreateRenderTarget(512, 96 + defaultSettings.slotBoxHeight, true)
	table.insert(showItem, {
		source,
		getTickCount(),
		item,
		rt
	})
	processShowItem()
end)
function drawShowItem(itemData, sx, plusY)
	local itemX = math.floor(sx / 2 - defaultSettings.slotBoxWidth * 1.1 / 2)
	local itemY = plusY
	local perishable = false
	local alpha = 255
	if perishableItems[itemData.itemId] then
		alpha = 255 * (1 - itemData.data3 / perishableItems[itemData.itemId])
		perishable = grayItemPictures[itemData.itemId]
	end
	if copyableItems[itemData.itemId] and isTheItemCopy(itemData) then
		alpha = 0
		perishable = grayItemPictures[itemData.itemId]
	end
	local picPath = getItemPic(itemData)
	if perishable then
		dxDrawImage(itemX, itemY, defaultSettings.slotBoxWidth * 1.1, defaultSettings.slotBoxHeight * 1.1, perishable, 0, 0, 0, tocolor(255, 255, 255, 255))
	end
	dxDrawImage(itemX, itemY, defaultSettings.slotBoxWidth * 1.1, defaultSettings.slotBoxHeight * 1.1, picPath, 0, 0, 0, tocolor(255, 255, 255, alpha))
	local dose = 1
	if doseItems[itemData.itemId] then
		dose = tonumber(itemData.data1)
		if dose then
			dose = 1 - dose / doseItems[itemData.itemId]
		else
			dose = 1
		end
	end
	if dose < 1 then
		dxDrawRectangle(itemX + 3, itemY + defaultSettings.slotBoxHeight * 1.1 - 8 - 1, defaultSettings.slotBoxWidth * 1.1 - 6, 6, titlebar)
		dxDrawRectangle(itemX + 4, itemY + defaultSettings.slotBoxHeight * 1.1 - 8, (defaultSettings.slotBoxWidth * 1.1 - 8) * dose, 4, useColor)
	elseif currentAmount < itemData.amount then
		if 0 < currentAmount then
			dxDrawText(currentAmount, itemX + defaultSettings.slotBoxWidth * 1.1 - 6, itemY + defaultSettings.slotBoxHeight * 1.1 - 15, itemX + defaultSettings.slotBoxWidth * 1.1, itemY + defaultSettings.slotBoxHeight * 1.1 - 15 + 5, tocolor(255, 255, 255, 255), craftFontScale * 0.75, craftFont, "right", "top")
		else
			dxDrawText(itemData.amount, itemX + defaultSettings.slotBoxWidth * 1.1 - 6, itemY + defaultSettings.slotBoxHeight * 1.1 - 15, itemX + defaultSettings.slotBoxWidth * 1.1, itemY + defaultSettings.slotBoxHeight * 1.1 - 15 + 5, tocolor(255, 255, 255, 255), craftFontScale * 0.75, craftFont, "right", "top")
		end
	else
		dxDrawText(itemData.amount, itemX + defaultSettings.slotBoxWidth * 1.1 - 6, itemY + defaultSettings.slotBoxHeight * 1.1 - 15, itemX + defaultSettings.slotBoxWidth * 1.1, itemY + defaultSettings.slotBoxHeight * 1.1 - 15 + 5, tocolor(255, 255, 255, 255), craftFontScale * 0.75, craftFont, "right", "top")
	end
	local itemId = itemData.itemId
	if itemList[itemId] then
		local theItemName = itemList[itemId][1]
		local absX = sx / 2
		local absY = defaultSettings.slotBoxHeight + 16 + plusY
		return processTooltip(absX, absY, theItemName, itemId, itemData, true, false)
	end
end
function processShowItem(disableRedraw)
	if showItem and 0 < #showItem then
		if not showItemState then
			addEventHandler("onClientRender", getRootElement(), renderShowItem)
			addEventHandler("onClientRestore", getRootElement(), processShowItem)
			showItemState = true
		end
		if not disableRedraw and showItem then
			for k = 1, #showItem do
				local item = showItem[k]
				if item then
					dxSetRenderTarget(item[4], true)
					drawShowItem(item[3], 512, 0)
				end
			end
			dxSetRenderTarget()
		end
	elseif showItemState then
		removeEventHandler("onClientRender", getRootElement(), renderShowItem)
		removeEventHandler("onClientRestore", getRootElement(), processShowItem)
		showItemState = false
	end
	sightexports.sNames:updateItemShowList(showItem)
end
function renderShowItem()
	if showItem then
		for k = #showItem, 1, -1 do
			local item = showItem[k]
			if item then
				local elasped = getTickCount() - item[2]
				if 6000 < elasped then
					table.remove(showItem, k)
					processShowItem(true)
				elseif item[1] == localPlayer then
					local p = elasped / 1000
					if 5 < p then
						p = 1 - (p - 5) / 0.5
					elseif p < 0.5 then
						p = p / 0.5
					else
						p = 1
					end
					if 0 < p then
						local x, y, z = getPedBonePosition(localPlayer, 5)
						z = z + 0.2
						local sx, sy = getScreenFromWorldPosition(x, y, z, 256)
						if sx then
							dxDrawImage(sx - 256, sy - 132, 512, 132, item[4], 0, 0, 0, tocolor(255, 255, 255, 230 * p))
						end
					end
				end
			end
		end
	end
end
titlebar = false
background = false
slotColor = false
useColor = false
redColor = false
useColor2 = false
redColor2 = false
hoverColor = false
hoverColor2 = false
lightercolor = false
lightestgrey = false
titlebarFont = false
titlebarFont2 = false
titlebarFontScale = 0
titlebarFontScale2 = 0
craftFont = false
craftFontScale = 0
hudWhite = false
greenHex = false
redHex = false
orangeHex = false
yellowHex = false
blueHex = false
slotColorOverLimit = false
warningTriangle = false
orange = false
function refreshColors()
	hudWhite = sightexports.sGui:getColorCodeToColor("hudwhite")
	titlebarFont = sightexports.sGui:getFont("15/BebasNeueBold.otf")
	titlebarFont2 = sightexports.sGui:getFont("15/BebasNeueRegular.otf")
	titlebarFontScale = sightexports.sGui:getFontScale("15/BebasNeueBold.otf")
	titlebarFontScale2 = sightexports.sGui:getFontScale("15/BebasNeueRegular.otf")
	craftFont = sightexports.sGui:getFont("11/Ubuntu-R.ttf")
	craftFontScale = sightexports.sGui:getFontScale("11/Ubuntu-R.ttf")
	titlebar = sightexports.sGui:getColorCodeToColor("sightgrey1")
	background = sightexports.sGui:getColorCodeToColor("sightgrey2")
	lightercolor = sightexports.sGui:getColorCodeToColor("sightgrey3")
	lightestgrey = sightexports.sGui:getColorCodeToColor("sightlightgrey")
	slotColor = sightexports.sGui:getColorCodeToColor("sightgrey1")
	slotColorOverLimit = sightexports.sGui:getColorCodeToColor("sightgrey3")
	useColor = sightexports.sGui:getColorCodeToColor("sightgreen")
	redColor = sightexports.sGui:getColorCodeToColor("sightred")
	useColor2 = sightexports.sGui:getColorCodeToColor("sightgreen-second")
	redColor2 = sightexports.sGui:getColorCodeToColor("sightred-second")
	hoverColor = sightexports.sGui:getColorCodeToColor("sightblue")
	hoverColor2 = sightexports.sGui:getColorCodeToColor("sightblue-second")
	greenHex = sightexports.sGui:getColorCodeHex("sightgreen")
	redHex = sightexports.sGui:getColorCodeHex("sightred")
	orangeHex = sightexports.sGui:getColorCodeHex("sightorange")
	orange = sightexports.sGui:getColorCode("sightorange")
	yellowHex = sightexports.sGui:getColorCodeHex("sightyellow")
	blueHex = sightexports.sGui:getColorCodeHex("sightblue")
	warningTriangle = sightexports.sGui:getFaIconFilename("exclamation-triangle", defaultSettings.slotBoxWidth / 2)
end
local urmatext2 = {
	{
		{
			1,
			0,
			0,
			0,
			1
		},
		{
			1,
			0,
			0,
			0,
			1
		},
		{
			1,
			0,
			0,
			0,
			1
		},
		{
			1,
			0,
			0,
			0,
			1
		},
		{
			1,
			1,
			1,
			1,
			1
		}
	},
	{
		{
			1,
			1,
			1,
			1,
			0
		},
		{
			1,
			0,
			0,
			1,
			0
		},
		{
			1,
			1,
			1,
			0,
			0
		},
		{
			1,
			0,
			0,
			1,
			1
		},
		{
			1,
			0,
			0,
			0,
			1
		}
	},
	{
		{
			1,
			0,
			0,
			0,
			1
		},
		{
			1,
			1,
			0,
			1,
			1
		},
		{
			1,
			0,
			1,
			0,
			1
		},
		{
			1,
			0,
			0,
			0,
			1
		},
		{
			1,
			0,
			0,
			0,
			1
		}
	},
	{
		{
			1,
			1,
			1,
			1,
			1
		},
		{
			1,
			0,
			0,
			0,
			1
		},
		{
			1,
			1,
			1,
			1,
			1
		},
		{
			1,
			0,
			0,
			0,
			1
		},
		{
			1,
			0,
			0,
			0,
			1
		}
	},
	{
		{
			1,
			1,
			0,
			1,
			1
		},
		{
			1,
			1,
			1,
			1,
			1
		},
		{
			0,
			1,
			1,
			1,
			0
		},
		{
			0,
			0,
			1,
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
	},
	{
		{
			0,
			0,
			0,
			0,
			0
		},
		{
			1,
			1,
			0,
			1,
			1
		},
		{
			1,
			1,
			1,
			1,
			1
		},
		{
			0,
			1,
			1,
			1,
			0
		},
		{
			0,
			0,
			1,
			0,
			0
		}
	},
	{
		{
			1,
			1,
			0,
			1,
			1
		},
		{
			1,
			1,
			1,
			1,
			1
		},
		{
			0,
			1,
			1,
			1,
			0
		},
		{
			0,
			0,
			1,
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
}
function movePreRender()
	if isCursorShowing() then
		local relativeX, relativeY, worldX, worldY, worldZ = getCursorPosition()
		absX = relativeX * screenX
		absY = relativeY * screenY
		if isMoving then
			startX = absX - moveDifferenceX
			startY = absY - moveDifferenceY
		end
	end
	if isMoving then
		sightexports.sGui:setGuiPosition(amountBox, startX + rectangleWidth - 64 - 5, startY + 5)
		sightexports.sGui:setInventoryPosition(startX, startY + 32, rectangleWidth, rectangleHeight)
	end
end
function onRender()
	local hoverItemTmp = false
	cursorTmp = "normal"
	tooltipTmp = false
	local absX, absY = -9999, -9999
	if currentMoving and not isCursorShowing() then
		currentMoving = false
		haveMoving = false
	end
	if isCursorShowing() then
		local relativeX, relativeY, worldX, worldY, worldZ = getCursorPosition()
		absX = relativeX * screenX
		absY = relativeY * screenY
	end
	local currentLine = 0
	local oldLine = 0
	local currentSlot = 0
	for i = 0, currentSlotLimit - 1 do
		currentLine = math.floor(i / defaultSettings.width)
		if currentLine ~= oldLine then
			currentSlot = 0
		end
		oldLine = currentLine
		currentSlot = currentSlot + 1
	end
	local sx, sy = rectangleWidth, rectangleHeight
	local x, y = startX, startY
	dxDrawRectangle(x, y + 32, sx, sy - 32, background)
	dxDrawRectangle(x, y, rectangleWidth - 64 - 5, 32, titlebar)
	dxDrawRectangle(x + rectangleWidth - 64 - 5, y, 64, 5, titlebar)
	dxDrawRectangle(x + rectangleWidth - 64 - 5, y + 5 + 32 - 10, 64, 5, titlebar)
	dxDrawRectangle(x + rectangleWidth - 5, y, 5, 32, titlebar)
	dxDrawRectangle(x, y + 32, sx, 1, lightercolor)
	if absX >= x and absX <= x + sx and absY >= y and absY <= y + 33 then
		cursorTmp = "move"
	end
	local weight = getWeightLimit(itemsTableState, currentInventoryElement)
	local renderWeight = tonumber(currentWeight) or weight
	if weight < renderWeight then
		renderWeight = weight
	elseif renderWeight < 0 then
		renderWeight = 0
	end
	local multipler = renderWeight / getWeightLimit(itemsTableState, currentInventoryElement)
	dxDrawRectangle(x + 5, y + rectangleHeight - 4 - 5, rectangleWidth - 10, 4, lightestgrey)
	dxDrawRectangle(x + 5, y + rectangleHeight - 4 - 5, (rectangleWidth - 10) * multipler, 4, useColor)
	if absX >= x + 5 and absX <= x + rectangleWidth - 5 and absY >= y + rectangleHeight - 4 - 5 and absY <= y + rectangleHeight - 5 then
		tooltipTmp = math.ceil(renderWeight) .. "/" .. getWeightLimit(itemsTableState, currentInventoryElement) .. "kg"
	end
	invTypText = "TÁRGYAK"
	if currentTab == "crafting" then
		invTypText = "CRAFT"
		if jutiudv then
			invTypText = "DICSŐ MIGUJUTI \226\153\165"
		elseif fenyjatek then
			invTypText = "MAGYAR FÉNYJÁTÉK"
		end
	end
	if currentTab == "papers" then
		invTypText = "IRATOK"
	end
	if itemsTableState == "vehicle" then
		invTypText = "JÁRMŰ"
		local id = getElementData(currentInventoryElement, defaultSettings.vehicleId)
		if id then
			invTypText = invTypText .. " (" .. id .. ")"
		end
	elseif itemsTableState == "object" then
		invTypText = "SZÉF"
		local id = getElementData(currentInventoryElement, defaultSettings.objectId)
		if id then
			invTypText = invTypText .. " (" .. id .. ")"
		end
	elseif currentTab == "keys" then
		invTypText = "KULCSOK"
	end
	dxDrawText(invTypText, x + 6, y, 0, y + 32, tocolor(255, 255, 255, 255), titlebarFontScale, titlebarFont, "left", "center")
	local tx = x + 6 + dxGetTextWidth(invTypText .. " ", titlebarFontScale, titlebarFont)
	if itemsTableState == "player" and currentTab == "crafting" then
		if selectedCraftingRecipe then
			dxDrawText(availableRecipes[selectedCraftingRecipe][1], tx, y, 0, y + 32, useColor, titlebarFontScale2, titlebarFont2, "left", "center")
		end
	else
		dxDrawText(itemCount, tx, y, 0, y + 32, useColor, titlebarFontScale2, titlebarFont2, "left", "center")
		dxDrawText(" / " .. currentSlotLimit, tx + dxGetTextWidth(itemCount, titlebarFontScale2, titlebarFont2), y, 0, y + 32, lightestgrey, titlebarFontScale2, titlebarFont2, "left", "center")
	end
	tabHover = false
	local picX = x + sx - 64 - 5
	local picY = y + 4
	if itemsTableState == "vehicle" then
	elseif itemsTableState == "object" then
	else
		picX = picX - 10 - 20
		if absX >= picX and absY >= picY and absX <= picX + 20 and absY <= picY + 24 then
			tabHover = "crafting"
			cursorTmp = "link"
			tooltipTmp = "Craft"
		end
		if currentTab == "crafting" then
			dxDrawImage(picX, picY, 20, 24, "files/craft.dds", 0, 0, 0, useColor)
		elseif tabHover == "crafting" then
			dxDrawImage(picX, picY, 20, 24, "files/craft.dds", 0, 0, 0, tocolor(255, 255, 255, 255))
		else
			dxDrawImage(picX, picY, 20, 24, "files/craft.dds", 0, 0, 0, tocolor(255, 255, 255, 125))
		end
		picX = picX - 10 - 20
		if absX >= picX and absY >= picY and absX <= picX + 20 and absY <= picY + 24 then
			tabHover = "papers"
			cursorTmp = "link"
			tooltipTmp = "Iratok"
		end
		if currentTab == "papers" then
			dxDrawImage(picX, picY, 20, 24, "files/wallet.dds", 0, 0, 0, useColor)
		elseif tabHover == "papers" then
			dxDrawImage(picX, picY, 20, 24, "files/wallet.dds", 0, 0, 0, tocolor(255, 255, 255, 255))
		else
			dxDrawImage(picX, picY, 20, 24, "files/wallet.dds", 0, 0, 0, tocolor(255, 255, 255, 125))
		end
		picX = picX - 10 - 20
		if absX >= picX and absY >= picY and absX <= picX + 20 and absY <= picY + 24 then
			tabHover = "keys"
			cursorTmp = "link"
			tooltipTmp = "Kulcsok"
		end
		if currentTab == "keys" then
			dxDrawImage(picX, picY, 20, 24, "files/key.dds", 0, 0, 0, useColor)
		elseif tabHover == "keys" then
			dxDrawImage(picX, picY, 20, 24, "files/key.dds", 0, 0, 0, tocolor(255, 255, 255, 255))
		else
			dxDrawImage(picX, picY, 20, 24, "files/key.dds", 0, 0, 0, tocolor(255, 255, 255, 125))
		end
		picX = picX - 10 - 20
		if absX >= picX and absY >= picY and absX <= picX + 20 and absY <= picY + 24 then
			tabHover = "main"
			cursorTmp = "link"
			tooltipTmp = "Tárgyak"
		end
		if currentTab == "main" then
			dxDrawImage(picX, picY, 20, 24, "files/bag.dds", 0, 0, 0, useColor)
		elseif tabHover == "main" then
			dxDrawImage(picX, picY, 20, 24, "files/bag.dds", 0, 0, 0, tocolor(255, 255, 255, 255))
		else
			dxDrawImage(picX, picY, 20, 24, "files/bag.dds", 0, 0, 0, tocolor(255, 255, 255, 125))
		end
	end
	local weightTextPosX = startX + 20
	local weightTextPosY = startY + rectangleHeight - 32
	if currentInventoryElement ~= localPlayer and isElement(currentInventoryElement) then
		local playerX, playerY, playerZ = getElementPosition(localPlayer)
		local targetX, targetY, targetZ = getElementPosition(currentInventoryElement)
		local dist = 5
		if getElementModel(currentInventoryElement) == 454 then
			dist = 10
		end
		if dist <= getDistanceBetweenPoints3D(playerX, playerY, playerZ, targetX, targetY, targetZ) then
			toggleInventory(false)
			return
		end
	end
	if currentTab == "crafting" and itemsTableState ~= "vehicle" and itemsTableState ~= "object" then
		local hasAll = true
		for i = 0, 24 do
			currentLine = math.floor(i / 5)
			if currentLine ~= oldLine then
				currentSlot = 0
			end
			local rectanglePosX = startX + (defaultSettings.slotBoxWidth + 5) * currentSlot + 5
			local rectanglePosY = startY + (defaultSettings.slotBoxHeight + 5) * currentLine + 33 + 5
			local col = lightercolor
			if currentLine == 0 or currentLine == 4 or currentSlot == 0 or currentSlot == 4 then
				col = slotColor
			end
			if jutiudv then
				local t = getTickCount() % (#urmatext2 * 750)
				local j = math.floor(t / 750) + 1
				if urmatext2[j][currentLine + 1][currentSlot + 1] == 1 then
					col = redColor
				else
					col = slotColor
				end
			elseif fenyjatek and col ~= slotColor then
				if currentLine == 1 then
					col = redColor
				elseif currentLine == 2 then
					col = tocolor(255, 255, 255)
				elseif currentLine == 3 then
					col = useColor
				end
			end
			if currentCraftingItemTable and 1 <= currentLine and currentLine <= 3 and 1 <= currentSlot and currentSlot <= 3 and currentCraftingItemTable[currentLine] and currentCraftingItemTable[currentLine][currentSlot] then
				local usedNum = ""
				if currentCraftingItemTable[currentLine][currentSlot][2] then
					dxDrawRectangle(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, useColor)
				else
					dxDrawRectangle(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, redColor)
					usedNum = "2"
					hasAll = false
				end
				local id = currentCraftingItemTable[currentLine][currentSlot][1]
				local picPath = getItemPic(id)
				dxDrawImage(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, picPath)
				if absX >= rectanglePosX and absX <= rectanglePosX + defaultSettings.slotBoxWidth and absY >= rectanglePosY and absY <= rectanglePosY + defaultSettings.slotBoxHeight then
					if craftDoNotTakeItems[id] then
						tooltipTmp = itemList[id][1] .. "\nSzükséges a recepthez, többször használható"
					else
						tooltipTmp = itemList[id][1] .. "\nSzükséges a recepthez"
					end
				end
			else
				dxDrawRectangle(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, col)
			end
			oldLine = currentLine
			currentSlot = currentSlot + 1
		end
		local h = sy - 38 - 14 - 21 + 1
		local w1 = (defaultSettings.slotBoxWidth + 5) * 5
		local w = sx - w1 - 10
		local oh = math.ceil(h / 8) - 1
		dxDrawRectangle(x + w1 + 5, y + 33 + 5, w, oh * 8 - 1, lightercolor)
		for k = 1, 8 do
			local rx, ry = x + w1 + 5, y + 33 + 5 + oh * (k - 1)
			dxDrawRectangle(rx, ry, w, oh - 1, slotColor)
			if craftingMenu[k + recipesOffset] then
				if craftingMenu[k + recipesOffset][1] == "category" then
					local a = 150
					local color = tocolor(255, 255, 255, 255)
					if absX >= rx and absY >= ry and absX <= rx + w and absY <= ry + oh then
						cursorTmp = "link"
						dxDrawRectangle(rx, ry, w, oh - 1, lightercolor)
						if hoveringCategory ~= craftingMenu[k + recipesOffset][2] then
							hoveringCategory = craftingMenu[k + recipesOffset][2]
							playSound("files/sounds/hover.wav")
						end
					elseif hoveringCategory == craftingMenu[k + recipesOffset][2] then
						hoveringCategory = false
					end
					if craftingMenu[k + recipesOffset][3] then
						dxDrawImage(rx, ry, oh, oh, ":sGui/" .. catClosed .. (faTicks[catClosed] or ""))
					else
						dxDrawImage(rx, ry, oh, oh, ":sGui/" .. catOpen .. (faTicks[catOpen] or ""))
					end
					dxDrawText(craftingMenu[k + recipesOffset][2], rx + oh, ry, 0, ry + oh - 1, tocolor(255, 255, 255), craftFontScale * 0.9, craftFont, "left", "center")
				elseif craftingMenu[k + recipesOffset][1] == "recipe" and craftingMenu[k + recipesOffset][2] then
					local recipeID = craftingMenu[k + recipesOffset][2]
					if selectedCraftingRecipe == recipeID then
						dxDrawRectangle(rx, ry, w, oh - 1, lightercolor)
					end
					if availableRecipes[recipeID] then
						if absX >= rx and absY >= ry and absX <= rx + w and absY <= ry + oh then
							if selectedCraftingRecipe ~= recipeID then
								cursorTmp = "link"
								if hoveringItem ~= recipeID then
									hoveringItem = recipeID
									playSound("files/sounds/hover.wav")
								end
								dxDrawRectangle(rx, ry, w, oh - 1, lightercolor)
							end
							local groupText = availableRecipes[recipeID][4] and sightexports.sGui:getColorCodeHex("sightorange") .. "szükséges" or sightexports.sGui:getColorCodeHex("sightgreen") .. "nem szükséges"
							local positionText = availableRecipes[recipeID][5] and sightexports.sGui:getColorCodeHex("sightorange") .. "szükséges" or sightexports.sGui:getColorCodeHex("sightgreen") .. "nem szükséges"
							if availableRecipes[recipeID][5] and availableRecipes[recipeID][5] == "hydraulic" then
								positionText = sightexports.sGui:getColorCodeHex("sightorange") .. "hidraulikus prés"
							end
							if availableRecipes[recipeID][4] == "job" then
								tooltipTmp = "#ffffffMunka: " .. sightexports.sGui:getColorCodeHex("sightorange") .. "szükséges#ffffff\nPozíció: " .. positionText
							else
								tooltipTmp = "#ffffffCsoport: " .. groupText .. "#ffffff\nPozíció: " .. positionText
							end
							if 6 <= myAdminLevel then
								tooltipTmp = tooltipTmp .. [[
                
BP: ]] .. recipeID
							end
						elseif hoveringItem == recipeID then
							hoveringItem = false
						end
					else
						hoveringItem = false
					end
					if availableRecipes[recipeID] then
						local color = tocolor(255, 255, 255, 150)
						if playerRecipes[recipeID] or defaultKnownRecipes[recipeID] or availableRecipes[recipeID][4] == "job" and playerHasTheJob then
							color = tocolor(255, 255, 255)
						end
						dxDrawText(availableRecipes[recipeID][1], rx + 4, ry, 0, ry + oh - 1, color, craftFontScale * 0.9, craftFont, "left", "center")
					end
				end
			end
		end
		if 8 < #craftingMenu then
			local height = oh * 8 - 1
			local scrollsize = height / (#craftingMenu - 8 + 1)
			dxDrawRectangle(x + sx - 5 - 2, y + 33 + 5, 2, height, lightercolor)
			dxDrawRectangle(x + sx - 5 - 2, y + 33 + 5 + recipesOffset * scrollsize, 2, scrollsize, useColor)
		end
		local bx, by = x + w1 + 5, y + sy - 14 - 16
		local hover = false
		if absX >= bx and absY >= by and absX <= bx + w and absY <= by + 16 then
			hover = true
		end
		if selectedCraftingRecipe then
			local canCraftEx = true
			if not hasAll or currentlyCrafting or not playerRecipes[selectedCraftingRecipe] and not defaultKnownRecipes[selectedCraftingRecipe] and (availableRecipes[selectedCraftingRecipe][4] ~= "job" or not playerHasTheJob) then
				canCraft = false
				canCraftEx = false
			elseif hover then
				canCraft = true
			else
				canCraft = false
			end
			if currentlyCrafting then
				local elasped = getTickCount() - currentlyCrafting
				local percentage = elasped / 10000
				if 1 < percentage then
					percentage = 1
					currentlyCrafting = false
				end
				dxDrawRectangle(bx, by, w, 16, slotColor)
				dxDrawRectangle(bx, by, w * percentage, 16, useColor)
				dxDrawText("Elkészítés folyamatban...", bx, by, bx + w, by + 16, color, craftFontScale * 0.9, craftFont, "center", "center")
			elseif playerRecipes[selectedCraftingRecipe] or defaultKnownRecipes[selectedCraftingRecipe] or availableRecipes[selectedCraftingRecipe][4] == "job" and playerHasTheJob then
				if hover and canCraftEx then
					cursorTmp = "link"
					dxDrawRectangle(bx, by, w, 16, useColor2)
				else
					dxDrawRectangle(bx, by, w, 16, canCraftEx and useColor or redColor)
				end
				dxDrawText(hasAll and "Elkészítés" or "Hiányzó alapanyag", bx, by, bx + w, by + 16, color, craftFontScale * 0.9, craftFont, "center", "center")
			else
				dxDrawRectangle(bx, by, w, 16, redColor)
				if availableRecipes[selectedCraftingRecipe][4] == "job" then
					dxDrawText("Nincs felvéve a munka!", bx, by, bx + w, by + 16, color, craftFontScale * 0.9, craftFont, "center", "center")
				else
					dxDrawText("Nincs elsajátítva a recept!", bx, by, bx + w, by + 16, color, craftFontScale * 0.9, craftFont, "center", "center")
				end
			end
		else
			dxDrawRectangle(bx, by, w, 16, redColor)
			dxDrawText("Válassz egy receptet!", bx, by, bx + w, by + 16, color, craftFontScale * 0.9, craftFont, "center", "center")
		end
	else
		altState = getKeyState("lalt")
		currentSlot = 0
		for i = 0, currentSlotLimit - 1 do
			currentLine = math.floor(i / defaultSettings.width)
			if currentLine ~= oldLine then
				currentSlot = 0
			end
			if itemsTableState == "player" and currentTab == "keys" then
				i = i + currentSlotLimit
			end
			if itemsTableState == "player" and currentTab == "papers" then
				i = i + currentSlotLimit * 2
			end
			bcg = slotColor
			local rectanglePosX = startX + (defaultSettings.slotBoxWidth + 5) * currentSlot + 5
			local rectanglePosY = startY + (defaultSettings.slotBoxHeight + 5) * currentLine + 33 + 5
			if itemsTable[itemsTableState] and itemsTable[itemsTableState][i] and usingItem == itemsTable[itemsTableState][i].dbID then
				bcg = useColor
			elseif itemsTable[itemsTableState] and itemsTable[itemsTableState][i] and usingSecondaryItems[itemsTable[itemsTableState][i].dbID] then
				bcg = useColor2
			end
			if itemsTable[itemsTableState] and itemsTable[itemsTableState][i] then
				local itemId = itemsTable[itemsTableState][i].itemId
				if altState then
					if itemId == hoverItemId then
						bcg = hoverColor2
					end
				elseif hoverSec[itemId] then
					bcg = hoverColor2
				end
			end
			if absX >= rectanglePosX and absX <= rectanglePosX + defaultSettings.slotBoxWidth and absY >= rectanglePosY and absY <= rectanglePosY + defaultSettings.slotBoxHeight then
				bcg = hoverColor
				cursorTmp = "link"
				if not currentMoving and itemsTable[itemsTableState] and itemsTable[itemsTableState][i] then
					local itemId = itemsTable[itemsTableState][i].itemId
					if itemList[itemId] then
						local theItemName = itemList[itemId][1]
						processTooltip(absX, absY, theItemName, itemId, itemsTable[itemsTableState][i], false)
						hoverItemTmp = i
					end
				end
			end
			if i + 1 > realSlotLimit then
				dxDrawRectangle(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, slotColorOverLimit)
			else
				dxDrawRectangle(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, bcg)
			end
			if itemsTable[itemsTableState] then
				if itemsTable[itemsTableState][i] then
					local picPath = getItemPic(itemsTable[itemsTableState][i])
					if inNametagEditMode == i or inNametagFakeInput and inNametagFakeInput[8] == i or tempNameTag == i then
						picPath = "files/items/314_2.png"
					end
					local perishable = false
					local alpha = 255
					if perishableItems[itemsTable[itemsTableState][i].itemId] then
						alpha = 255 * (1 - itemsTable[itemsTableState][i].data3 / perishableItems[itemsTable[itemsTableState][i].itemId])
						perishable = grayItemPictures[itemsTable[itemsTableState][i].itemId]
					end
					if copyableItems[itemsTable[itemsTableState][i].itemId] and isTheItemCopy(itemsTable[itemsTableState][i]) then
						alpha = 0
						perishable = grayItemPictures[itemsTable[itemsTableState][i].itemId]
					end
					local dose = 1
					if doseItems[itemsTable[itemsTableState][i].itemId] then
						dose = tonumber(itemsTable[itemsTableState][i].data1)
						if dose then
							dose = 1 - dose / doseItems[itemsTable[itemsTableState][i].itemId]
						else
							dose = 1
						end
					end
					if currentMoving then
						if currentMoving ~= i then
							if perishable then
								dxDrawImage(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, perishable)
							end
							dxDrawImage(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, picPath, 0, 0, 0, tocolor(255, 255, 255, alpha))
							if dose < 1 then
								dxDrawRectangle(rectanglePosX + 3, rectanglePosY + defaultSettings.slotBoxHeight - 8 - 1, defaultSettings.slotBoxWidth - 6, 6, titlebar)
								dxDrawRectangle(rectanglePosX + 4, rectanglePosY + defaultSettings.slotBoxHeight - 8, (defaultSettings.slotBoxWidth - 8) * dose, 4, useColor)
							else
								dxDrawText(itemsTable[itemsTableState][i].amount, rectanglePosX + defaultSettings.slotBoxWidth - 6, rectanglePosY + defaultSettings.slotBoxHeight - 15, rectanglePosX + defaultSettings.slotBoxWidth, rectanglePosY + defaultSettings.slotBoxHeight - 15 + 5, tocolor(255, 255, 255, 255), craftFontScale * 0.75, craftFont, "right")
							end
						elseif currentAmount < itemsTable[itemsTableState][i].amount and 0 < currentAmount then
							if perishable then
								dxDrawImage(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, perishable)
							end
							dxDrawImage(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, picPath, 0, 0, 0, tocolor(255, 255, 255, alpha))
							if dose < 1 then
								dxDrawRectangle(rectanglePosX + 3, rectanglePosY + defaultSettings.slotBoxHeight - 8 - 1, defaultSettings.slotBoxWidth - 6, 6, titlebar)
								dxDrawRectangle(rectanglePosX + 4, rectanglePosY + defaultSettings.slotBoxHeight - 8, (defaultSettings.slotBoxWidth - 8) * dose, 4, useColor)
							else
								dxDrawText(itemsTable[itemsTableState][i].amount, rectanglePosX + defaultSettings.slotBoxWidth - 6, rectanglePosY + defaultSettings.slotBoxHeight - 15, rectanglePosX + defaultSettings.slotBoxWidth, rectanglePosY + defaultSettings.slotBoxHeight - 15 + 5, tocolor(255, 255, 255, 255), craftFontScale * 0.75, craftFont, "right")
							end
						end
					else
						if perishable then
							dxDrawImage(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, perishable)
						end
						dxDrawImage(rectanglePosX, rectanglePosY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, picPath, 0, 0, 0, tocolor(255, 255, 255, alpha))
						if dose < 1 then
							dxDrawRectangle(rectanglePosX + 3, rectanglePosY + defaultSettings.slotBoxHeight - 8 - 1, defaultSettings.slotBoxWidth - 6, 6, titlebar)
							dxDrawRectangle(rectanglePosX + 4, rectanglePosY + defaultSettings.slotBoxHeight - 8, (defaultSettings.slotBoxWidth - 8) * dose, 4, useColor)
						else
							if itemsTable[itemsTableState][i].amount < 0 then
								dxDrawText(1, rectanglePosX + defaultSettings.slotBoxWidth - 6, rectanglePosY + defaultSettings.slotBoxHeight - 15, rectanglePosX + defaultSettings.slotBoxWidth, rectanglePosY + defaultSettings.slotBoxHeight - 15 + 5, tocolor(255, 255, 255, 255), craftFontScale * 0.75, craftFont, "right")
							else
								dxDrawText(itemsTable[itemsTableState][i].amount, rectanglePosX + defaultSettings.slotBoxWidth - 6, rectanglePosY + defaultSettings.slotBoxHeight - 15, rectanglePosX + defaultSettings.slotBoxWidth, rectanglePosY + defaultSettings.slotBoxHeight - 15 + 5, tocolor(255, 255, 255, 255), craftFontScale * 0.75, craftFont, "right")
							end
						end
					end
				end
				if i + 1 > realSlotLimit then
					dxDrawImage(rectanglePosX + defaultSettings.slotBoxWidth / 2 / 2, rectanglePosY + defaultSettings.slotBoxWidth / 2 / 2, defaultSettings.slotBoxWidth / 2, defaultSettings.slotBoxHeight / 2, ":sGui/" .. warningTriangle .. (faTicks[warningTriangle] or ""), 0, 0, 0, tocolor(orange[1], orange[2], orange[3], 255))
				end
			end
			oldLine = currentLine
			currentSlot = currentSlot + 1
		end
	end
	if currentMoving then
		dxDrawImage(startX + rectangleWidth / 2 - 32, startY - 5 - 64, 64, 64, "files/eye.dds", 0, 0, 0, tocolor(255, 255, 255, 125))
		if absX >= startX + rectangleWidth / 2 - 32 and absY >= startY - 5 - 64 and absX <= startX + rectangleWidth / 2 + 32 and absY <= startY - 5 and getTickCount() - lastItemShow > 6000 then
			dxDrawImage(startX + rectangleWidth / 2 - 32, startY - 5 - 64, 64, 64, "files/eye.dds", 0, 0, 0, tocolor(255, 255, 255, 200))
		end
		local perishable = false
		local alpha = 255
		if perishableItems[itemsTable[itemsTableState][currentMoving].itemId] then
			alpha = 255 * (1 - itemsTable[itemsTableState][currentMoving].data3 / perishableItems[itemsTable[itemsTableState][currentMoving].itemId])
			perishable = grayItemPictures[itemsTable[itemsTableState][currentMoving].itemId]
		end
		if copyableItems[itemsTable[itemsTableState][currentMoving].itemId] and isTheItemCopy(itemsTable[itemsTableState][currentMoving]) then
			alpha = 0
			perishable = grayItemPictures[itemsTable[itemsTableState][currentMoving].itemId]
		end
		local picPath = getItemPic(itemsTable[itemsTableState][currentMoving])
		if perishable then
			dxDrawImage(absX - itemMoveDifferenceX, absY - itemMoveDifferenceY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, perishable, 0, 0, 0, tocolor(255, 255, 255, 255))
		end
		dxDrawImage(absX - itemMoveDifferenceX, absY - itemMoveDifferenceY, defaultSettings.slotBoxWidth, defaultSettings.slotBoxHeight, picPath, 0, 0, 0, tocolor(255, 255, 255, alpha))
		local dose = 1
		if doseItems[itemsTable[itemsTableState][currentMoving].itemId] then
			dose = tonumber(itemsTable[itemsTableState][currentMoving].data1)
			if dose then
				dose = 1 - dose / doseItems[itemsTable[itemsTableState][currentMoving].itemId]
			else
				dose = 1
			end
		end
		if dose < 1 then
			dxDrawRectangle(absX - itemMoveDifferenceX + 3, absY - itemMoveDifferenceY + defaultSettings.slotBoxHeight - 8 - 1, defaultSettings.slotBoxWidth - 6, 6, titlebar)
			dxDrawRectangle(absX - itemMoveDifferenceX + 4, absY - itemMoveDifferenceY + defaultSettings.slotBoxHeight - 8, (defaultSettings.slotBoxWidth - 8) * dose, 4, useColor)
		elseif currentAmount < itemsTable[itemsTableState][currentMoving].amount then
			if 0 < currentAmount then
				dxDrawText(currentAmount, absX - itemMoveDifferenceX + defaultSettings.slotBoxWidth - 6, absY - itemMoveDifferenceY + defaultSettings.slotBoxHeight - 15, absX - itemMoveDifferenceX + defaultSettings.slotBoxWidth, absY - itemMoveDifferenceY + defaultSettings.slotBoxHeight - 15 + 5, tocolor(255, 255, 255, 255), craftFontScale * 0.75, craftFont, "right", "top")
			else
				dxDrawText(itemsTable[itemsTableState][currentMoving].amount, absX - itemMoveDifferenceX + defaultSettings.slotBoxWidth - 6, absY - itemMoveDifferenceY + defaultSettings.slotBoxHeight - 15, absX - itemMoveDifferenceX + defaultSettings.slotBoxWidth, absY - itemMoveDifferenceY + defaultSettings.slotBoxHeight - 15 + 5, tocolor(255, 255, 255, 255), craftFontScale * 0.75, craftFont, "right", "top")
			end
		else
			dxDrawText(itemsTable[itemsTableState][currentMoving].amount, absX - itemMoveDifferenceX + defaultSettings.slotBoxWidth - 6, absY - itemMoveDifferenceY + defaultSettings.slotBoxHeight - 15, absX - itemMoveDifferenceX + defaultSettings.slotBoxWidth, absY - itemMoveDifferenceY + defaultSettings.slotBoxHeight - 15 + 5, tocolor(255, 255, 255, 255), craftFontScale * 0.75, craftFont, "right", "top")
		end
	end
	if isCursorShowing() then
		if inNametagEditMode then
			dxDrawImage(absX, absY, 32, 32, "files/nametag.dds")
			cursorTmp = "none"
		end
	elseif inNametagEditMode then
		inNametagEditMode = false
		--triggerServerEvent("cancelNametagEdit", localPlayer)
	end
	if inNametagFakeInput then
		local x, y = inNametagFakeInput[1], inNametagFakeInput[2]
		local val = inNametagFakeInput[3]
		if getTickCount() - inNametagFakeInput[4] >= 750 then
			inNametagFakeInput[4] = getTickCount()
			inNametagFakeInput[5] = not inNametagFakeInput[5]
		end
		inNametagFakeInput[6] = false
		dxDrawRectangle(x, y, 200, 24, tocolor(0, 0, 0, 200))
		local c = redColor
		if absX >= x + 200 - 32 and absY >= y + 3 and absX <= x + 200 - 32 + 28 and absY <= y + 3 + 18 then
			c = redColor2
			inNametagFakeInput[6] = "close"
		end
		dxDrawRectangle(x + 200 - 32 + 1, y + 3, 28, 18, c)
		dxDrawText("X", x + 200 - 32, y + 3, x + 200 - 32 + 28, y + 3 + 18, tocolor(255, 255, 255), craftFontScale, craftFont, "center", "center")
		local c = useColor
		if absX >= x + 200 - 64 and absY >= y + 3 and absX <= x + 200 - 64 + 28 and absY <= y + 3 + 18 then
			c = useColor2
			inNametagFakeInput[6] = "ok"
		end
		dxDrawRectangle(x + 200 - 64, y + 3, 28, 18, c)
		dxDrawText("✓", x + 200 - 64, y + 3, x + 200 - 64 + 28, y + 3 + 18, tocolor(255, 255, 255), craftFontScale, craftFont, "center", "center")
		if inNametagFakeInput[5] then
			dxDrawText(val .. "|", x + 2, y, 0, y + 24, tocolor(255, 255, 255), craftFontScale, craftFont, "left", "center")
		else
			dxDrawText(val, x + 2, y, 0, y + 24, tocolor(255, 255, 255), craftFontScale, craftFont, "left", "center")
		end
	end
	if tooltipTmp ~= tooltip then
		tooltip = tooltipTmp
		sightexports.sGui:showTooltip(tooltip)
	end
	if cursorTmp ~= cursor then
		cursor = cursorTmp
		sightexports.sGui:setCursorType(cursor)
	end
	setHoverItem(hoverItemTmp, hoverItemTmp and itemsTable[itemsTableState][hoverItemTmp])
end
addEventHandler("onClientKey", getRootElement(), function(key, state)
	if inNametagFakeInput then
		cancelEvent()
		if key == "backspace" and state then
			inNametagFakeInput[3] = utf8.sub(inNametagFakeInput[3], 1, utf8.len(inNametagFakeInput[3]) - 1)
		end
	end
end)
addEventHandler("onClientCharacter", getRootElement(), function(char)
	if inNametagFakeInput and utf8.len(inNametagFakeInput[3]) < 16 then
		inNametagFakeInput[3] = inNametagFakeInput[3] .. char
	end
end, true, "low-199")
bindKey("i", "down", function(key, keyState)
	if getElementData(localPlayer, "goldrob.holdingGoldBox") then
		return outputChatBox("[color=sightred][SightMTA]: #FFFFFFBiztonsági ládával a kezedben nem használhatod az inventoryt!", 255, 255, 255, true)
	end
	if getElementData(localPlayer, "loggedIn") then
		toggleInventory(not inventoryState)
		itemsTableState = "player"
		currentInventoryElement = localPlayer
		itemCount = 0
		currentWeight = 0
		recalcSlot()
		for k, v in pairs(itemsTable[itemsTableState]) do
			if itemList[v.itemId] then
				local baseWeight = itemList[v.itemId][10]
				currentWeight = currentWeight + baseWeight * v.amount
			end
			if itemsTableState == "player" then
				if currentTab == "keys" then
					if v.slot >= 50 and v.slot < 100 then
						itemCount = itemCount + 1
					end
				elseif currentTab == "papers" then
					if v.slot >= 100 then
						itemCount = itemCount + 1
					end
				elseif v.slot < 50 then
					itemCount = itemCount + 1
				end
			else
				itemCount = itemCount + 1
			end
		end
		currentMoving = false
		haveMoving = false
	end
end)
local renderUsed = {}
renderUsed.width = 318
renderUsed.height = 163
renderUsed.posX = screenX - renderUsed.width - 20
renderUsed.posY = 20
renderUsed.picOneX = renderUsed.posX + 196
renderUsed.picOneY = renderUsed.posY + renderUsed.height - 36 - 10
renderUsed.picTwoX = renderUsed.picOneX + 36 + 10
renderUsed.picTwoY = renderUsed.posY + renderUsed.height - 36 - 10
addEvent("deleteItemsByIDsC", true)
addEventHandler("deleteItemsByIDsC", getRootElement(), function(dbIDs)
	for k, v in pairs(itemsTable.player) do
		if dbIDs[v.dbID] then
			itemsTable.player[v.slot] = nil
		end
	end
end)
local craftingSoundOf = {}
addEvent("crafting3dSound", true)
addEventHandler("crafting3dSound", getRootElement(), function(typeOf)
	if isElement(craftingSoundOf[source]) then
		destroyElement(craftingSoundOf[source])
	end
	if typeOf then
		local x, y, z = getElementPosition(source)
		local int = getElementInterior(source)
		local dim = getElementDimension(source)
		craftingSoundOf[source] = playSound3D("files/" .. typeOf .. ".mp3", x, y, z)
		setElementInterior(craftingSoundOf[source], int)
		setElementDimension(craftingSoundOf[source], dim)
		attachElements(craftingSoundOf[source], source)
		setTimer(function(p)
			craftingSoundOf[p] = nil
		end, 10000, 1, source)
	end
end)
local perishableTimer = false
function processPerishableItems()
	for k, v in pairs(itemsTable.player) do
		if perishableItems[v.itemId] then
			local data3 = tonumber(v.data3) or 0
			data3 = data3 + 1
			if data3 <= perishableItems[v.itemId] then
				triggerEvent("updateData3", localPlayer, "player", v.dbID, data3)
			else
				triggerEvent("updateData3", localPlayer, "player", v.dbID, perishableItems[v.itemId])
				if perishableEvent[v.itemId] then
					triggerServerEvent(perishableEvent[v.itemId], localPlayer, v.dbID)
				end
			end
		end
	end
end
addEventHandler("onClientElementDataChange", localPlayer, function(data)
	if data == "char.Job" then
		playerHasTheJob = getElementData(localPlayer, "char.Job") == factoryJobID
	end
	if data == "loggedIn" and getElementData(source, data) then
		if isTimer(perishableTimer) then
			killTimer(perishableTimer)
		end
		perishableTimer = setTimer(processPerishableItems, 60000, 0)
	end
end)
local craftingCols = {}
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	if getElementData(localPlayer, "loggedIn") then
		local t = 60
		setTimer(function()
			triggerServerEvent("requestCache", localPlayer)
		end, t * 1000, 1)
		if isTimer(perishableTimer) then
			killTimer(perishableTimer)
		end
		perishableTimer = setTimer(processPerishableItems, 60000, 0)
	end
	setTimer(function()
		toggleControl("next_weapon", false)
		toggleControl("previous_weapon", false)
	end, 1000, 0)
	for k, v in pairs(craftingPositions) do
		if k <= 2 then
			for k2 = 1, #v[5] do
				local d = v[5][k2]
				craftingPositionElements[k] = createColSphere(v[1], v[2], v[3], v[6])
				if isElement(craftingPositionElements[k]) then
					setElementInterior(craftingPositionElements[k], v[4])
					setElementDimension(craftingPositionElements[k], d)
					craftingCols[craftingPositionElements[k]] = k
				end
			end
		else
			craftingPositionElements[k] = createColCuboid(v[1], v[2], v[3], v[4], v[5], v[6])
			if isElement(craftingPositionElements[k]) then
				craftingCols[craftingPositionElements[k]] = k
			end
		end
	end
	playerRecipes = getElementData(localPlayer, "playerRecipes") or {}
end)
addEventHandler("onClientColShapeHit", getResourceRootElement(), function(hitElement, matchingDimension)
	if hitElement == localPlayer and matchingDimension then
		local craftingPosition = craftingCols[source]
		if craftingPosition then
			currentCraftingPosition = craftingPosition
			setElementData(localPlayer, "currentCraftingPosition", currentCraftingPosition)
		end
	end
end)
addEventHandler("onClientColShapeLeave", getResourceRootElement(), function(hitElement, matchingDimension)
	if hitElement == localPlayer then
		local craftingPosition = craftingCols[source]
		if craftingPosition then
			currentCraftingPosition = false
			setElementData(localPlayer, "currentCraftingPosition", currentCraftingPosition)
		end
	end
end)
local sideWeaponList = {
	[85] = true,
	[86] = true,
	[87] = true,
	[88] = true,
	[81] = true,
	[79] = true,
	[80] = true,
	[83] = true,
	[74] = true,
	[78] = true,
	[265] = true,
	[266] = true,
	[267] = true,
	[268] = true,
	[269] = true,
	[270] = true,
	[271] = true,
	[272] = true,
	[273] = true,
	[414] = true,
	[274] = true,
	[275] = true,
	[276] = true,
	[277] = true,
	[278] = true,
	[279] = true,
	[280] = true,
	[281] = true,
	[282] = true,
	[283] = true,
	[284] = true,
	[285] = true,
	[286] = true,
	[407] = true,
	[408] = true,
	[409] = true,
	[69] = true,
	[71] = true,
	[410] = true,
	[411] = true,
	[412] = true,
	[413] = true,
	[82] = true,
	[84] = true
}
addEvent("movedItemInInv", true)
addEventHandler("movedItemInInv", getRootElement(), function(disweapon)
	checkRecipeHaveItem()
	refreshAbData()
	itemCount = 0
	currentWeight = 0
	recalcSlot()
	for k, v in pairs(itemsTable[itemsTableState]) do
		if itemList[v.itemId] then
			local baseWeight = itemList[v.itemId][10]
			currentWeight = currentWeight + baseWeight * v.amount
		end
		if itemsTableState == "player" then
			if currentTab == "keys" then
				if v.slot >= 50 and v.slot < 100 then
					itemCount = itemCount + 1
				end
			elseif currentTab == "papers" then
				if v.slot >= 100 then
					itemCount = itemCount + 1
				end
			elseif v.slot < 50 then
				itemCount = itemCount + 1
			end
		else
			itemCount = itemCount + 1
		end
	end
	sightexports.sHud:refreshItemWeight(currentWeight)
	if not disweapon then
	end
end)
addEvent("playTrashSound", true)
addEventHandler("playTrashSound", getRootElement(), function(soundType, x, y, z, interior, dimension)
	if x and y and z then
		local sound = playSound3D("files/trash" .. soundType, x, y, z, false)
		setElementInterior(sound, interior)
		setElementDimension(sound, dimension)
		setSoundMaxDistance(sound, 30)
	end
end)
addEvent("playUseSound", true)
addEventHandler("playUseSound", getRootElement(), function(soundType, x, y, z, interior, dimension)
	if x and y and z then
		local sound = playSound3D("files/sounds/use/inv" .. soundType .. ".wav", x, y, z, false)
		setElementInterior(sound, interior)
		setElementDimension(sound, dimension)
		setSoundMaxDistance(sound, 15)
	end
end)
local newItemlistWindow = false
local itemlistElements = {}
local guiItemlistItems = {}
local cachedItemList = {}
local itemListScroll = 0
local currentItemList = {}
local maxElements = 14
local itemSearch = ""
function processItemList()
	local seeRestrictedItems = sightexports.sPermission:hasPermission(localPlayer, "seeRestrictedItems")
	for i = 1, #itemlistElements do
		local dat = currentItemList[i + itemListScroll]
		if dat then
			sightexports.sGui:setLabelText(itemlistElements[i][1], "[" .. dat .. "] " .. getItemName(dat))
			local desc = itemList[dat][2] or ""
			sightexports.sGui:setLabelText(itemlistElements[i][2], desc)
			sightexports.sGui:setLabelColor(itemlistElements[i][2], "#ffffff")
			if seeRestrictedItems and restrictedItemIds[dat] then
				sightexports.sGui:setGuiRenderDisabled(itemlistElements[i][4], false)
			else
				sightexports.sGui:setGuiRenderDisabled(itemlistElements[i][4], true)
			end
			if fileExists(":sItems/files/items/" .. dat - 1 .. ".png") then
				sightexports.sGui:setImageFile(itemlistElements[i][3], ":sItems/files/items/" .. dat - 1 .. ".png")
			else
				sightexports.sGui:setImageFile(itemlistElements[i][3], ":sItems/files/items/nopic.png")
			end
			sightexports.sGui:setClickEvent(itemlistElements[i][3], "giveItem")
			sightexports.sGui:setClickArgument(itemlistElements[i][3], dat)
			sightexports.sGui:setGuiHoverable(itemlistElements[i][3], true)
		end
	end
	local n = #currentItemList - #itemlistElements
	local sh = (48 * maxElements - 8) / math.max(1, n + 1)
	sightexports.sGui:setGuiSize(itemListScrollBar, false, sh)
	sightexports.sGui:setGuiPosition(itemListScrollBar, false, sh * itemListScroll)
end
addEvent("searchItemlist", true)
addEventHandler("searchItemlist", getRootElement(), function(value)
	cachedItemList = {}
	local value = value and utf8.lower(value)
	if itemSearch ~= value then
		itemSearch = value
		if itemSearch and utf8.len(itemSearch) > 0 then
			itemListScroll = 0
			for i = 1, #guiItemlistItems do
				if utf8.find(utf8.lower(getItemName(guiItemlistItems[i])), utf8.lower(itemSearch), nil, true) then
					table.insert(cachedItemList, guiItemlistItems[i])
				elseif tonumber(itemSearch) then
					if tonumber(guiItemlistItems[i]) == tonumber(itemSearch) then
						table.insert(cachedItemList, guiItemlistItems[i])
					elseif utf8.find(tostring(guiItemlistItems[i]), utf8.lower(itemSearch)) then
						table.insert(cachedItemList, guiItemlistItems[i])
					end
				end
			end
			currentItemList = cachedItemList
			createItemlistElements()
			processItemList()
		else
			currentItemList = guiItemlistItems
			createItemlistElements()
			processItemList()
		end
	else
		currentItemList = guiItemlistItems
		createItemlistElements()
		processItemList()
	end
end)
addEvent("closeItemlistWindow", false)
addEventHandler("closeItemlistWindow", getRootElement(), function()
	if newItemlistWindow then
		sightexports.sGui:deleteGuiElement(newItemlistWindow)
	end
	newItemlistWindow = nil
	itemlistElements = {}
	itemListScrollBar = false
	guiItemlistItems = {}
	itemSearch = false
	sightlangCondHandl2(false)
	showCursor(false)
end)
function createItemlistElements()
	for i = 1, #itemlistElements do
		if itemlistElements[i][1] then
			sightexports.sGui:deleteGuiElement(itemlistElements[i][1])
		end
		itemlistElements[i][1] = nil
		if itemlistElements[i][2] then
			sightexports.sGui:deleteGuiElement(itemlistElements[i][2])
		end
		itemlistElements[i][2] = nil
		if itemlistElements[i][3] then
			sightexports.sGui:deleteGuiElement(itemlistElements[i][3])
		end
		itemlistElements[i][3] = nil
		if itemlistElements[i][4] then
			sightexports.sGui:deleteGuiElement(itemlistElements[i][4])
		end
		itemlistElements[i][4] = nil
	end
	local n = 14
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local pw = 800
	local ph = titleBarHeight + 48 + 48 * n
	local y = titleBarHeight + 48
	for i = 1, n do
		if i < n then
			local border = sightexports.sGui:createGuiElement("hr", 8, y + 48 * i - 1, pw - 4 - 2 - 4 - 8, 2, newItemlistWindow)
		end
	end
	n = math.min(n, #currentItemList)
	for i = 1, n do
		itemlistElements[i] = {}
		local img = sightexports.sGui:createGuiElement("image", 8, y + 6, 36, 36, newItemlistWindow)
		sightexports.sGui:setImageFile(img, ":sItems/files/items/1.png")
		local label = sightexports.sGui:createGuiElement("label", 52, y, 0, 24, newItemlistWindow)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-R.ttf")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		itemlistElements[i][1] = label
		local label = sightexports.sGui:createGuiElement("label", 52, y + 24, pw - 150 - 4 - 2 - 16, 24, newItemlistWindow)
		sightexports.sGui:setLabelFont(label, "10/Ubuntu-L.ttf")
		sightexports.sGui:setLabelAlignment(label, "left", "center")
		sightexports.sGui:setLabelColor(label, "sightlightgrey")
		itemlistElements[i][2] = label
		itemlistElements[i][3] = img
		local restrict = sightexports.sGui:createGuiElement("image", pw - 12 - 36, y + 6, 36, 36, newItemlistWindow)
		sightexports.sGui:setImageFile(restrict, sightexports.sGui:getFaIconFilename("user-lock", 36))
		sightexports.sGui:setImageColor(restrict, "sightgrey3")
		sightexports.sGui:setGuiRenderDisabled(restrict, true)
		itemlistElements[i][4] = restrict
		y = y + 48
	end
	local rect = sightexports.sGui:createGuiElement("rectangle", pw - 4 - 2, titleBarHeight + 48, 2, 48 * n - 8, newItemlistWindow)
	sightexports.sGui:setGuiBackground(rect, "solid", "sightgrey1")
	itemListScrollBar = sightexports.sGui:createGuiElement("rectangle", 0, 0, 2, 48 * n - 8, rect)
	sightexports.sGui:setGuiBackground(itemListScrollBar, "solid", "sightmidgrey")
end
function itemListScrollHandler(key)
	if key == "mouse_wheel_up" then
		if 0 < itemListScroll then
			itemListScroll = itemListScroll - 1
			processItemList()
		end
	elseif key == "mouse_wheel_down" then
		local n = #currentItemList - #itemlistElements
		if n > itemListScroll then
			itemListScroll = itemListScroll + 1
			processItemList()
		end
	end
end
local jumpWindow = false
local jumpIdText = false
local lastJumpText = false
function jumpToId(id)
	for i = 1, #currentItemList do
		if currentItemList[i] == id then
			itemListScroll = i - 1
			processItemList()
			return
		end
	end
end
addEvent("closeJumpWindow", false)
addEventHandler("closeJumpWindow", getRootElement(), function()
	if jumpWindow then
		sightexports.sGui:deleteGuiElement(jumpWindow)
	end
	jumpWindow = false
end)
addEvent("jumpToId", false)
addEventHandler("jumpToId", getRootElement(), function()
	local inputText = sightexports.sGui:getInputValue(jumpIdText)
	local value = utf8.lower(inputText)
	local foundItem = false
	if value and utf8.len(value) > 0 then
		for i = itemListScroll + 2, #guiItemlistItems do
			if utf8.find(utf8.lower(getItemName(guiItemlistItems[i])), utf8.lower(value), nil, true) then
				foundItem = i
				break
			elseif tonumber(value) then
				if tonumber(guiItemlistItems[i]) == tonumber(value) then
					foundItem = i
					break
				elseif utf8.find(tostring(guiItemlistItems[i]), utf8.lower(value)) then
					foundItem = i
					break
				end
			end
		end
		if not foundItem then
			for i = 1, itemListScroll + 1 do
				if utf8.find(utf8.lower(getItemName(guiItemlistItems[i])), utf8.lower(value), nil, true) then
					foundItem = i
					break
				elseif tonumber(value) then
					if tonumber(guiItemlistItems[i]) == tonumber(value) then
						foundItem = i
						break
					elseif utf8.find(tostring(guiItemlistItems[i]), utf8.lower(value)) then
						foundItem = i
						break
					end
				end
			end
		end
	end
	if not foundItem then
		sightexports.sGui:showInfobox("e", "Nincs találat!")
		return
	else
		lastJumpText = inputText
	end
	currentItemList = guiItemlistItems
	createItemlistElements()
	processItemList()
	jumpToId(foundItem)
	if jumpWindow then
		sightexports.sGui:deleteGuiElement(jumpWindow)
	end
	jumpWindow = false
end)
addEvent("openJumpToId", false)
addEventHandler("openJumpToId", getRootElement(), function()
	if jumpWindow then
		sightexports.sGui:deleteGuiElement(jumpWindow)
	end
	if itemSearch then
		itemSearch = false
		currentItemList = guiItemlistItems
		itemListScroll = 0
		createItemlistElements()
		processItemList()
		sightexports.sGui:setInputValue(searchInput, "")
	end
	local titleBarHeight = sightexports.sGui:getTitleBarHeight()
	local pw, ph = 300, titleBarHeight + 32 + 8 + 48 + 8
	jumpWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
	sightexports.sGui:setWindowTitle(jumpWindow, "16/BebasNeueRegular.otf", "Ugrás")
	sightexports.sGui:setWindowCloseButton(jumpWindow, "closeJumpWindow")
	local input = sightexports.sGui:createGuiElement("input", 8, titleBarHeight + 8, pw - 16, 32, jumpWindow)
	sightexports.sGui:setInputMaxLength(input, 5)
	sightexports.sGui:setInputPlaceholder(input, "Név/ID")
	sightexports.sGui:setInputIcon(input, "search")
	if lastJumpText then
		sightexports.sGui:setInputValue(input, lastJumpText)
	end
	sightexports.sGui:setActiveInput(input)
	local btn = sightexports.sGui:createGuiElement("button", 8, titleBarHeight + 48 + 8, pw - 16, 32, jumpWindow)
	sightexports.sGui:setGuiBackground(btn, "solid", "sightgreen")
	sightexports.sGui:setGuiHover(btn, "gradient", {
		"sightgreen",
		"sightgreen-second"
	}, false, true)
	sightexports.sGui:setButtonFont(btn, "13/BebasNeueBold.otf")
	sightexports.sGui:setButtonTextColor(btn, "#ffffff")
	sightexports.sGui:setButtonText(btn, "Ugrás")
	sightexports.sGui:setClickEvent(btn, "jumpToId", true)
	jumpIdText = input
end)
function createItemlist()
	if sightexports.sPermission:hasPermission(localPlayer, "itemlist") then
		if newItemlistWindow then
			triggerEvent("closeItemlistWindow", localPlayer)
			return
		end
		guiItemlistItems = {}
		for i = 1, #newItemList do
			table.insert(guiItemlistItems, i)
		end
		currentItemList = guiItemlistItems
		itemListScroll = 0
		local titleBarHeight = sightexports.sGui:getTitleBarHeight()
		local n = 14
		local pw = 800
		local ph = titleBarHeight + 48 + 48 * n
		newItemlistWindow = sightexports.sGui:createGuiElement("window", screenX / 2 - pw / 2, screenY / 2 - ph / 2, pw, ph)
		sightexports.sGui:setWindowTitle(newItemlistWindow, "16/BebasNeueRegular.otf", "Tárgyak listája")
		sightexports.sGui:setWindowCloseButton(newItemlistWindow, "closeItemlistWindow")
		local y = titleBarHeight
		local searchInput = sightexports.sGui:createGuiElement("input", 8, y + 8, pw - 24 - 48, 32, newItemlistWindow)
		sightexports.sGui:setInputPlaceholder(searchInput, "Keresés (ID, Név)")
		sightexports.sGui:setInputIcon(searchInput, "search")
		sightexports.sGui:setInputChangeEvent(searchInput, "searchItemlist")
		sightexports.sGui:setActiveInput(searchInput)
		showCursor(true)
		local jumpBtn = sightexports.sGui:createGuiElement("button", pw - 8 - 48, y + 8, 48, 32, newItemlistWindow)
		sightexports.sGui:setButtonIcon(jumpBtn, sightexports.sGui:getFaIconFilename("eye", 32))
		sightexports.sGui:setGuiBackground(jumpBtn, "solid", "sightgreen")
		sightexports.sGui:setGuiHover(jumpBtn, "gradient", {"sightgreen", "sightgreen-second"}, false, true)
		sightexports.sGui:guiSetTooltip(jumpBtn, "Ugrás")
		sightexports.sGui:setClickEvent(jumpBtn, "openJumpToId")
		createItemlistElements()
		processItemList()
		sightlangCondHandl2(true)
	end
end
addCommandHandler("itemlist", createItemlist)

addEvent("giveItem", false)
addEventHandler("giveItem", root, function(button, state, absoluteX, absoluteY, el, itemId)
	triggerServerEvent("requestToGiveItemViaPanel", localPlayer, itemId)
end)
