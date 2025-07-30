mineTick = 0
mineDelta = 0
cursorX = false
cursorY = false
selfPosX = 0
selfPosY = 0
selfMineX = 0
selfMineY = 0
selfCamX = 0
selfCamY = 0
selfCamZ = 0
local r1_0 = false
local r2_0 = 0
local r3_0 = nil
local r4_0 = 0
local r5_0 = false
local r6_0 = 0
local r7_0 = false
local r8_0 = false
local r9_0 = 0
local r10_0 = 0
local r11_0 = {}
local pendingEvents = {}

function addMineEventHandler(eventName, eventSource, callback) --addMineEventHandler
	if not eventSource then
		eventSource = root
	end
    addEvent(eventName, true)
	addEventHandler(eventName, eventSource, function(mineId, ...)
		if not loadingMineExit then
			if loadingMineEnter then
				if mineId == loadingMineEnter then
					table.insert(pendingMines, {
						loadingMineEnter,
						callback,
						source,
						{ ... }
					})
				end
			elseif mineId == currentMine then
				callback(mineId, ...)
			end
		end
	end)
end

staticTextures = {}
local r15_0 = nil
local r16_0 = nil
local r17_0 = nil
local r18_0 = nil
local r19_0 = nil
local r20_0 = nil
local r21_0 = nil
local r22_0 = nil
local r23_0 = false
local r24_0 = false
local r25_0 = {}
local r26_0 = {}
local r27_0 = {}
local baseVertexNeighbors = {}
local baseVertexClusters = {}
local r30_0 = {}
local r31_0 = {}
local r32_0 = {}
local r33_0 = {}
local r34_0 = {}
local r35_0 = {}
tunnelObjectRots = {}
junctionObjects = {}
threeJunctionsAt = {}
threeJunctionRots = {}
threeJunctionBombs = {}
local shaftSet = {}
local shaftCoords = {}
local shaftTunnels = {}
local shaftRotations = {}
local shaftPositions = {}
shaftBombs = {}
local r41_0 = {}
openShaftsAt = {}
local openShaftRNGs = {}
local openShaftDepths = {}
local openShaftLengths = {}
local openShaftDFFs = {}
local openShaftModels = {}
local openShaftObjects = {}
local openShaftCols = {}
local openShaftDirty = {}
local openShaftLoaded = {}
local r51_0 = {}
local openShaftExporting = {}
local r53_0 = {}
local openShaftOres = {}
local r55_0 = {}
openShaftBombs = {}
local dffExportQueue = {}
local r57_0 = false
local shaftWallModel = nil
local shaftWallTxd = nil
local shaftWallCol = nil
local shaftWallCol = nil
local r62_0 = false
local r63_0 = nil
local r64_0 = nil
local r65_0 = nil
local r66_0 = nil
local r67_0 = nil
local r68_0 = nil
local r69_0 = nil
local r70_0 = nil
local currentExtendableShaftId = nil
local currentExtendableShaftSpotX = nil
local currentExtendableShaftSpotY = nil
local currentExtendableShaftLeft = nil
local currentExtendableShaftRight = nil
local pickaxeItem = false
local r77_0 = false
local r78_0 = {}
local r79_0 = {}
local r80_0 = false
local r81_0 = {}
local r82_0 = {}
local r83_0 = {}
local r84_0 = {}
local r85_0 = {}
local r86_0 = {}
local r87_0 = {}
local r88_0 = {}
local fixOres = {}
local r90_0 = {}
local fixOreStreamed = {}
local r92_0 = false
local r93_0 = {}
local r94_0 = {}
fixOreCarts = {}
local r95_0 = {}
local r96_0 = {}
local r97_0 = {}
carryingFixOre = false
emptyingTurtle = false
bombDetonations = {}
mineMachineData = {}
mineFoundryData = {
  furnaceRunning = false,
  meltingOre = false,
  meltProgress = 0,
}
local r98_0 = {}
local r99_0 = {}
local r100_0 = {}
local r101_0 = {}
addEventHandler("onClientResourceStart", resourceRoot, function()
  -- line: [212, 223] id: 4
  refreshColors()
  engineLoadIFP("files/animations/wallhit.ifp", "mining_hit")
  engineLoadIFP("files/animations/boxpour.ifp", "mining_box_pour")
  engineLoadIFP("files/animations/filldiesel.ifp", "mining_fill_diesel")
  for r3_4, r4_4 in pairs(oreTypes) do
    r4_4.itemOutput = {}
    r4_4.itemPicture = ":sItems/files/items/" .. r4_4.itemId - 1 .. ".png"
  end
end)
addEventHandler("onClientResourceStop", resourceRoot, function()
  -- line: [227, 248] id: 5
  if loadedMineLobby then
    exports.sWeather:resetWeather()
  elseif currentMine then
    unloadMine()
  end
  if pickaxeItem then
    --exports.sItems:unuseItem(pickaxeItem)
    pickaxeItem = false
  end
  if r80_0 then
    --exports.sItems:unuseItem(r80_0)
    r80_0 = false
  end
  if tabletItem then
    --exports.sItems:unuseItem(tabletItem)
    tabletItem = false
  end
end)

currentMinePlayers = {}

addEvent("otherPlayerEnteredMine", true)
addEventHandler("otherPlayerEnteredMine", root, function(r0_6, r1_6)
  -- line: [255, 261] id: 6
  if isElement(source) and (currentMine == r0_6 or loadingMineEnter == r0_6) then
    currentMinePlayers[source] = r1_6
    local hat = exports.sClothesshop:getPlayerMiningHat(source)
    if hat then
      setStreamedHardHat(source, hat)
    end
  end
end)
addEvent("otherPlayerExitedMine", true)
addEventHandler("otherPlayerExitedMine", root, function(r0_7, r1_7)
  -- line: [266, 270] id: 7
  if currentMine == r0_7 then
    currentMinePlayers[source] = nil
    setStreamedHardHat(source, nil)
  end
end)
addEvent("enteredMine", true)
addEventHandler("enteredMine", localPlayer, function(r0_8, ...)
  -- line: [275, 287] id: 8
  if not r5_0 then
    addEventHandler("onClientPreRender", root, preRenderMineLoading)
    loadingMineEnter = r0_8
    loadingMineEnterSynced = r0_8
    r4_0 = getTickCount()
    r5_0 = coroutine.create(loadMine)
    coroutine.resume(r5_0, r0_8, ...)

    local hat = exports.sClothesshop:getPlayerMiningHat(localPlayer)
    if hat then
      setStreamedHardHat(localPlayer, hat)
    end
  end
end)
addMineEventHandler("exitMine", localPlayer, function(r0_9)
  -- line: [291, 301] id: 9
  addEventHandler("onClientPreRender", root, preRenderMineUnloading)
  loadingMineExit = true
  loadingMineExitSynced = true
  startLoader(true)
  r6_0 = getTickCount()
  r7_0 = coroutine.create(unloadMine)
  setStreamedHardHat(localPlayer, nil)
end)
function preRenderMineLoading()
  -- line: [306, 315] id: 10
  if r5_0 then
    if coroutine.status(r5_0) == "dead" then
      r5_0 = nil
    else
      r4_0 = getTickCount()
      coroutine.resume(r5_0)
    end
  end
end
function preRenderMineUnloading()
  -- line: [317, 326] id: 11
  if r7_0 then
    if coroutine.status(r7_0) == "dead" then
      r7_0 = nil
    else
      r6_0 = getTickCount()
      coroutine.resume(r7_0)
    end
  end
end

function checkMineLoadingTime()
  if coroutine.running() and 15 < getTickCount() - r4_0 then
    coroutine.yield()
  end
end
function checkMineUnloadingTime()
  -- line: [338, 344] id: 13
  if coroutine.running() and 15 < getTickCount() - r6_0 then
    coroutine.yield()
  end
end

function loadMine(mineId, charId, payloadData)
	unloadLobby()

    setMineExitMarker(mineId)

	if isElement(mineHq) then
		setElementDimension(mineHq, mineId)
	end

	calculateBase()

	loaderText = "Textúrák betöltése"

	if tabletItem then
		--exports.sItems:unuseItem(tabletItem)
		tabletItem = false
	end

	staticTextures.lcdCharset = dxCreateTexture("files/textures/charset_lcd.dds", "argb", true)

	staticTextures.mineFull = dxCreateTexture("files/textures/minefull.dds", "argb", true)
	staticTextures.mineCircle = dxCreateTexture("files/textures/minecircle.dds", "argb", true)
	staticTextures.mineAim = dxCreateTexture("files/textures/mineaim.dds", "argb", true)

	checkMineLoadingTime()

	staticTextures.smokeParticle = dxCreateTexture("files/textures/particle/smoke.dds", "argb", true)
	staticTextures.sparkParticle = dxCreateTexture("files/textures/particle/spark.dds", "argb", true)

	for i = 0, 4 do
		staticTextures["railDraw" .. i] = dxCreateTexture("files/textures/rail/" .. i .. ".dds", "argb", true)
	end

	staticTextures.arrowMarker = dxCreateTexture("files/textures/arrow.dds", "argb", true)

	for i = 3, 4 do
		staticTextures["railSwitch_" .. i] = dxCreateTexture("files/textures/switch/" .. i .. ".dds", "argb", true)

		for j = 1, 2 do
			staticTextures["railSwitch_" .. i .. "_" .. j] = dxCreateTexture("files/textures/switch/" .. i .. "_" .. j .. ".dds", "argb", true)
		end

		checkMineLoadingTime()
	end

	staticTextures.railHighlight = dxCreateTexture("files/textures/highlight.dds", "argb", true)

	if not shaftWallModel then
		shaftWallModel = poolGetModel()

		if shaftWallModel then
			shaftWallTxd = engineLoadTXD("files/models/shaftwall.txd")
			shaftWallCol = engineLoadCOL("files/models/shaftwall.col")
			shaftWallDff = engineLoadDFF("files/models/shaftwall.dff")

			engineImportTXD(shaftWallTxd, shaftWallModel)
			engineReplaceCOL(shaftWallCol, shaftWallModel)
			engineReplaceModel(shaftWallDff, shaftWallModel)

			checkMineLoadingTime()
		end

		loaderText = "Adatok betöltése"
	end

	selfCharacterId = charId

	if pickaxeItem then
		exports.sControls:toggleControl("fire", false, "minePickaxeMode")
	end

	mineTick = getTickCount()
	mineDelta = 0

	currentMine = mineId
	currentMineName = payloadData.mineName
	currentMineLocked = payloadData.doorLocked
	currentMineOwnerId = payloadData.rentedBy
	currentMineWorkers = payloadData.workerNames or {}
	currentMineWorkersList = {}
	currentMinePermissions = payloadData.workerPermissions or {}
	currentMineInventory = payloadData.inventoryData or {}
	currentMineOrder = payloadData.orderData
	currentMineOrderPaid = payloadData.orderPaid
	currentMinePlayers = {}

	if not currentMinePlayers[localPlayer] then
		currentMinePlayers[localPlayer] = charId
	end

	for workerId in pairs(currentMineWorkers) do
		table.insert(currentMineWorkersList, workerId)
	end

	updateMineInventory("railIrons", currentMineInventory.railIrons or 0)
	updateMineInventory("railWoods", currentMineInventory.railWoods or 0)
	updateMineInventory("mineLamps", currentMineInventory.mineLamps or 0)

	if payloadData.cartEmptying then
		for cartId, cartEmptier in pairs(payloadData.cartEmptying) do
			cartTurtleEmptying[cartId] = cartEmptier

			if cartEmptier == localPlayer then
				emptyingTurtle = cartId
			end
		end
	end

	revalidateTabletOrder()

	do
		local rngId = rngCreate(0)
		createShaft(0, -1, 0, 1, 0, pcos(0), psin(0), rngId)
		rngDelete(rngId)
	end

	openShaftDepths = payloadData.shaftDepths or {}
	openShaftLengths = payloadData.shaftLengths or {}

	if payloadData.shaftList then
		loaderText = "Bányajáratok betöltése"

		for shaftId = 1, #payloadData.shaftList do
			local shaftData = payloadData.shaftList[shaftId]

			if shaftData then
				local spotX, spotY, numTunnels, angleDeg, randomSeed, skipSeed = unpack(shaftData)

				local angleRad = prad(angleDeg)
				local angleCos = pcos(angleRad)
				local angleSin = psin(angleRad)

				local rngId = rngCreate(randomSeed)

				if skipSeed > 0 then
					rngSkip(rngId, skipSeed)
				end

				createShaft(shaftId, spotX, spotY, numTunnels, angleDeg, angleCos, angleSin, rngId)

				shaftCoords[shaftId] = {spotX, spotY}
				shaftTunnels[shaftId] = numTunnels
				shaftRotations[shaftId] = {angleDeg, angleRad, angleCos, angleSin}

				if openShaftDepths[shaftId] then
					openShaftRNGs[shaftId] = rngId

					if generateOpenShaftDff(shaftId, true) then
						local shaftPosX = shaftPositions[shaftId][1]
						local shaftPosY = shaftPositions[shaftId][2]

						openShaftDirty[shaftId] = true
						openShaftLoaded[shaftId] = nil
						openShaftCols[shaftId] = {}

						for blockId = 1, wallBlockCount do
							local blockPosX, blockPosY, blockPosZ = getShaftBlockPosition(shaftId, blockId)
							local blockDummy = createObject(modelIds.v4_mine_wall, blockPosX, blockPosY, blockPosZ, 0, 0, angleDeg + 180)

							if isElement(blockDummy) then
								setObjectScale(blockDummy, 0)
								setElementAlpha(blockDummy, 0)
								setElementInterior(blockDummy, 0)
								setElementDimension(blockDummy, currentMine)
								removeShaderFromObject(blockDummy)
								checkMineLoadingTime()
							end

							openShaftCols[shaftId][blockId] = blockDummy
						end
					end
				else
					rngDelete(rngId)
				end

				checkMineLoadingTime()
			end

			shaftSet[shaftId] = true
		end
	end

	openShaftOres = payloadData.shaftOres or {}

	if payloadData.junctionList then
		loaderText = "Elágazások betöltése"

		for junctionId, junctionData in pairs(payloadData.junctionList) do
			createJunction(unpack(junctionData))
			checkMineLoadingTime()
		end

		checkMineLoadingTime()
	end

	if payloadData.railTracks then
		loaderText = "Sínek betöltése"

		for railId, railData in pairs(payloadData.railTracks) do
			createRail(railId, railData)
			checkMineLoadingTime()
		end

		checkMineLoadingTime()
	end

	if payloadData.railSwitches and payloadData.railSwitchStates then
		loaderText = "Váltók betöltése"

		for switchId, switchData in pairs(payloadData.railSwitches) do
			createRailSwitch(switchId, switchData, payloadData.railSwitchStates[switchId])
			checkMineLoadingTime()
		end

		checkMineLoadingTime()
	end

	if payloadData.trainData then
		shouldRefreshJerryContent = false

		currentMineInventory.jerryCarry = payloadData.trainData.jerryCarry
		currentMineInventory.jerryContent = payloadData.trainData.jerryContent or 0
		currentMineInventory.displayedJerryContent = currentMineInventory.jerryContent

		currentMineInventory.jerryCan = false
		currentMineInventory.jerrySound = false
	end

	initMineTrain(currentMineInventory.dieselLoco, currentMineInventory.subCartNum or 0, payloadData.trainData.fuelLevel or 0)

	if payloadData.trainData then
		processRailCarSync(payloadData.trainData, true)
	end

	checkMineLoadingTime()

	if not currentMineInventory.tankOutside then
		if not currentMineInventory.fuelTankObject then
			currentMineInventory.fuelTankObject = createObject(modelIds.v4_mine_tank, minePosX - 32.7956, minePosY + 2.3363, minePosZ, 0, 0, -5)

			if isElement(currentMineInventory.fuelTankObject) then
				setElementInterior(currentMineInventory.fuelTankObject, 0)
				setElementDimension(currentMineInventory.fuelTankObject, currentMine)
			end
		end
	end

	currentMineInventory.displayedFuelTankLevel = currentMineInventory.fuelTankLevel

	mineMachineData.machineRunning = payloadData.sorterRunning
	mineMachineData.machineRunProgress = 0
	mineMachineData.sorterProgress = 0

	loaderText = "Lámpák betöltése"

	setStreamedLights(-1, 0, true)
	setStreamedLights(-2, 0, true)
	setStreamedLights(-3, 0, true)
	setStreamedLights(-4, 0, true)
	setStreamedLights(-5, 0, true)

	checkMineLoadingTime()

	setStreamedLights(-2, 1, true)
	setStreamedLights(-3, 1, true)
	setStreamedLights(-4, 1, true)
	setStreamedLights(-5, 1, true)

	checkMineLoadingTime()

	setStreamedLights(-2, -1, true)
	setStreamedLights(-3, -1, true)
	setStreamedLights(-4, -1, true)
	setStreamedLights(-5, -1, true)

	if payloadData.installedLights then
		for spotX in pairs(payloadData.installedLights) do
			for spotY in pairs(payloadData.installedLights[spotX]) do
				setStreamedLights(spotX, spotY, true)
			end
			checkMineLoadingTime()
		end
	end

	loadShaders()

	mineFoundryData.furnaceRunning = payloadData.furnaceRunning
	mineFoundryData.meltingOre = payloadData.meltingOre
	mineFoundryData.meltProgress = payloadData.meltProgress or 0

	if mineFoundryData.meltingOre then
		setMeltingOre(mineFoundryData.meltingOre)
	end

	createSortingMachine()

	local sorterPosX = machinePosX - 2.1249
	local sorterPosY = machinePosY - 0.2139
	local sorterPosZ = machinePosZ + 0.2109

	local foundryPosX = minePosX - 10.6672
	local foundryPosY = minePosY - 8.1405
	local foundryPosZ = minePosZ + 0.0059

	loaderText = "Ércek inicializálása"

	for k,v in pairs(oreTypes) do
		v.bufferContent = payloadData.bufferContent[k] or 0

		v.boxContent = 0
		v.displayedBoxContent = 0

		v.foundryContent = payloadData.foundryContent[k] or 0
		v.displayedFoundryContent = v.foundryContent

		v.carriedBy = false

		if not v.instantItem then
			v.boxPosition = {sorterPosX - v.sorterOffset, sorterPosY - 1.0574, sorterPosZ - 1.6562}
			v.boxElement = createObject(modelIds.v4_mine_box, unpack(v.boxPosition))

			if isElement(v.boxElement) then
				setElementInterior(v.boxElement, 0)
				setElementDimension(v.boxElement, currentMine)
			end

			v.boxContentElement = createObject(modelIds.v4_mine_box_content, unpack(v.boxPosition))

			if isElement(v.boxContentElement) then
				refreshOreShader(v.boxContentElement, k)
				setElementInterior(v.boxContentElement, 0)
				setElementDimension(v.boxContentElement, currentMine)
			end
		end

		checkMineLoadingTime()

		if v.meltingPoint then
			v.foundryObject = createObject(modelIds.v4_mine_furnace, foundryPosX, foundryPosY, foundryPosZ, 0, 0, 180)

			if isElement(v.foundryObject) then
				setElementInterior(v.foundryObject, 0)
				setElementDimension(v.foundryObject, currentMine)
			end

			v.foundryPosition = {foundryPosX, foundryPosY, foundryPosZ}
			v.foundryInputPosition = {foundryPosX - 1.0866, foundryPosY + 0.7895, foundryPosZ + 1.275}
			v.foundryButtonPosition = {foundryPosX - 0.3792, foundryPosY + 1.1672, foundryPosZ + 1.0768}
			v.foundryDisplayPosition = {foundryPosX - 0.3792, foundryPosY + 1.1672, foundryPosZ + 1.4624}

			v.ingotPosition = {foundryPosX, foundryPosY + 1.2368, foundryPosZ + 0.3614}

			v.meltPosition = {foundryPosX, foundryPosY + 1.2368, foundryPosZ + 0.5781}
			v.meltLightPosition = {foundryPosX, foundryPosY + 1.2368, foundryPosZ + 0.46975}

			v.furnaceSound = playSound3D("files/sounds/furnace.wav", foundryPosX, foundryPosY, foundryPosZ, true)
			v.furnaceTemperature = payloadData.furnaceTemperature[k] or 0
			v.furnaceRunProgress = 0

			if isElement(v.furnaceSound) then
				setElementInterior(v.furnaceSound, 0)
				setElementDimension(v.furnaceSound, currentMine)
				setSoundMaxDistance(v.furnaceSound, 50)
				setSoundVolume(v.furnaceSound, 0)
			end

			foundryPosX = foundryPosX - 3.2
		end

		checkOreBuffer(k, true)
		syncOreBoxCarry(k, payloadData.oreBoxCarrying[k])
	end

	loaderText = "Ércek betöltése"

	for fixOreId, fixOreData in pairs(payloadData.fixOres) do
		local fixOreType = fixOreData[3]

		local objectModel = (oreTypes[fixOreType] and oreTypes[fixOreType]["modelName"]) or "v4_mine_ore" .. math.random(1, 5)
		local objectElement = createObject(modelIds[objectModel], minePosX + fixOreData[1], minePosY + fixOreData[2], minePosZ, math.random() * 360, math.random() * 360, math.random() * 360)

		if isElement(objectElement) then
			refreshOreShader(objectElement, fixOreType)
			setElementInterior(objectElement, 0)
			setElementDimension(objectElement, currentMine)
		end

		fixOres[fixOreId] = {fixOreData[1], fixOreData[2], 0, 0, 0, objectElement, nil, nil, nil, fixOreType}
		fixOreStreamed[fixOreId] = true

		if fixOreData[4] == "cart" then
			attachFixOreToCart(fixOreId, fixOreData[5], fixOreData[6])
		elseif fixOreData[4] == "player" then
			attachFixOreToPlayer(fixOreId, fixOreData[5])
		else
			setFixOrePosition(fixOreId, fixOreData[1], fixOreData[2])
		end
	end

	loaderText = "Betöltés véglegesítése"

	while pendingEvents[1] do
		processPendingEvent(1)
		coroutine.yield()
	end

	if not mineEnvironmentSound then
		mineEnvironmentSound = playSound("files/sounds/mineloop.mp3", true)

		if isElement(mineEnvironmentSound) then
			setSoundVolume(mineEnvironmentSound, 0.5)
		end
	end

	refreshMineName()

	addEventHandler("onClientPlayerWasted", localPlayer, playerWastedMine)
	addEventHandler("onClientPedsProcessed", root, pedsProcessedMine)
	addEventHandler("onClientPreRender", root, preRenderMine)
	addEventHandler("onClientRender", root, renderMine)
	addEventHandler("onClientRestore", root, restoreMine)
	addEventHandler("onClientClick", root, clickMine)
	addEventHandler("onClientKey", root, keyMine)

	doMineLoadEnded()
end

function unloadMine()
  -- line: [777, 898] id: 15
  if tabletItem then
    --exports.sItems:unuseItem(tabletItem)
    tabletItem = false
  end
  if r5_0 then
    removeEventHandler("onClientPreRender", root, preRenderMineLoading)
    r4_0 = 0
    r5_0 = nil
  end
  while doMineJobs() do
    checkMineUnloadingTime()
  end
  setCurrentActiveOpenShaft(false)
  removeEventHandler("onClientKey", root, keyMine)
  removeEventHandler("onClientClick", root, clickMine)
  removeEventHandler("onClientRestore", root, restoreMine)
  removeEventHandler("onClientRender", root, renderMine)
  removeEventHandler("onClientPreRender", root, preRenderMine)
  removeEventHandler("onClientPedsProcessed", root, pedsProcessedMine)
  removeEventHandler("onClientPlayerWasted", localPlayer, playerWastedMine)
  exports.sWeather:resetWeather()
  exports.sDashboard:resetFogAndFarClip()
  unloadShaders()
  currentMine = nil
  currentMineName = nil
  currentMineLocked = nil
  currentMineOwnerId = nil
  currentMineWorkers = nil
  currentMineWorkersList = nil
  currentMinePermissions = nil
  currentMineOrder = nil
  currentMineOrderPaid = nil
  currentMinePlayers = nil
  loadingMineExit = false
  loadingMineExitSynced = false
  shouldRefreshUrmaMotoDevice = true
  for r3_15, r4_15 in pairs(staticTextures) do
    checkMineUnloadingTime()
    if isElement(r4_15) then
      destroyElement(r4_15)
    end
    staticTextures[r3_15] = nil
  end
  staticTextures = {}
  if isElement(r3_0) then
    destroyElement(r3_0)
  end
  for r3_15 in pairs(mineFoundryData) do
    checkMineUnloadingTime()
    local r4_15 = isElement(mineFoundryData[r3_15])
    if r4_15 then
      destroyElement(mineFoundryData[r3_15])
    end
    r4_15 = mineFoundryData
    r4_15[r3_15] = nil
  end
  unloadMineOres()
  unloadMineRails()
  unloadMineShafts()
  unloadMineInventory()
  r3_0 = nil
  carryingFixOre = false
  emptyingTurtle = false
  r63_0 = nil
  r64_0 = nil
  r65_0 = nil
  r66_0 = nil
  r67_0 = nil
  r68_0 = nil
  r69_0 = nil
  r70_0 = nil
  currentExtendableShaftId = nil
  currentExtendableShaftSpotX = nil
  currentExtendableShaftSpotY = nil
  currentExtendableShaftLeft = nil
  currentExtendableShaftRight = nil
  r83_0 = {}
  r84_0 = {}
  r85_0 = {}
  r86_0 = {}
  r87_0 = {}
  r88_0 = {}
  shouldRefreshBoxContent = false
  shouldRefreshFoundryContent = false
  mineFoundryData.furnaceRunning = false
  mineFoundryData.meltingOre = false
  mineFoundryData.meltProgress = 0
  exports.sControls:toggleControl("fire", true, "minePickaxeMode")
  exports.sControls:toggleControl({
    "fire",
    "crouch",
    "action"
  }, true, "minePickaxeAim")
  removeEventHandler("onClientPreRender", root, preRenderMineUnloading)
  collectgarbage()
  setStreamedHardHat(localPlayer, nil)
end
function unloadMineShafts()
  -- line: [900, 1076] id: 16
  for r3_16, r4_16 in pairs(openShaftObjects) do
    checkMineUnloadingTime()
    if isElement(r4_16) then
      destroyElement(r4_16)
    end
    openShaftObjects[r3_16] = nil
  end
  for r3_16, r4_16 in pairs(openShaftDFFs) do
    checkMineUnloadingTime()
    if isElement(r4_16) then
      destroyElement(r4_16)
    end
    openShaftDFFs[r3_16] = nil
  end
  for r3_16, r4_16 in pairs(openShaftModels) do
    poolFreeModel(r4_16)
  end
  for r3_16 in pairs(openShaftOres) do
    local r4_16 = pairs
    for r7_16, r8_16 in r4_16(openShaftOres[r3_16]) do
      checkMineUnloadingTime()
      if isElement(r8_16[5]) then
        destroyElement(r8_16[5])
      end
      r8_16[5] = nil
    end
  end
  for r3_16 in pairs(openShaftCols) do
    local r4_16 = pairs
    for r7_16 in r4_16(openShaftCols[r3_16]) do
      checkMineUnloadingTime()
      if isElement(openShaftCols[r3_16][r7_16]) then
        destroyElement(openShaftCols[r3_16][r7_16])
      end
      openShaftCols[r3_16][r7_16] = nil
    end
  end
  for r3_16 in pairs(openShaftRNGs) do
    rngDelete(openShaftRNGs[r3_16])
  end
  for r3_16 in pairs(r34_0) do
    local r4_16 = pairs
    for r7_16 in r4_16(r34_0[r3_16]) do
      checkMineUnloadingTime()
      if isElement(r34_0[r3_16][r7_16]) then
        destroyElement(r34_0[r3_16][r7_16])
      end
      r34_0[r3_16][r7_16] = nil
    end
    r4_16 = r34_0
    r4_16[r3_16] = nil
  end
  for r3_16 in pairs(junctionObjects) do
    local r4_16 = pairs
    for r7_16 in r4_16(junctionObjects[r3_16]) do
      checkMineUnloadingTime()
      if isElement(junctionObjects[r3_16][r7_16]) then
        destroyElement(junctionObjects[r3_16][r7_16])
      end
      junctionObjects[r3_16][r7_16] = nil
    end
    r4_16 = junctionObjects
    r4_16[r3_16] = nil
  end
  if isElement(shaftWallCol) then
    destroyElement(shaftWallCol)
  end
  if isElement(shaftWallCol) then
    destroyElement(shaftWallCol)
  end
  if isElement(shaftWallTxd) then
    destroyElement(shaftWallTxd)
  end
  if shaftWallModel then
    engineFreeModel(shaftWallModel)
  end
  clearRandomMDVD()
  for r3_16 in pairs(openShaftBombs) do
    checkMineUnloadingTime()
    local r4_16 = isElement(openShaftBombs[r3_16][1])
    if r4_16 then
      destroyElement(openShaftBombs[r3_16][1])
    end
    r4_16 = openShaftBombs[r3_16]
    r4_16[1] = nil
  end
  for r3_16 in pairs(shaftBombs) do
    local r4_16 = pairs
    for r7_16 in r4_16(shaftBombs[r3_16]) do
      for r11_16 in pairs(shaftBombs[r3_16][r7_16]) do
        checkMineUnloadingTime()
        if isElement(shaftBombs[r3_16][r7_16][r11_16][1]) then
          destroyElement(shaftBombs[r3_16][r7_16][r11_16][1])
        end
        shaftBombs[r3_16][r7_16][r11_16][1] = nil
      end
    end
  end
  for r3_16 in pairs(threeJunctionBombs) do
    local r4_16 = pairs
    for r7_16 in r4_16(threeJunctionBombs[r3_16]) do
      checkMineUnloadingTime()
      if isElement(threeJunctionBombs[r3_16][r7_16][1]) then
        destroyElement(threeJunctionBombs[r3_16][r7_16][1])
      end
      threeJunctionBombs[r3_16][r7_16][1] = nil
    end
  end
  shaftWallCol = nil
  shaftWallCol = nil
  shaftWallTxd = nil
  shaftWallModel = nil
  r34_0 = {}
  r35_0 = {}
  tunnelObjectRots = {}
  junctionObjects = {}
  threeJunctionsAt = {}
  threeJunctionRots = {}
  threeJunctionBombs = {}
  shaftSet = {}
  shaftCoords = {}
  shaftTunnels = {}
  shaftRotations = {}
  shaftPositions = {}
  shaftBombs = {}
  r41_0 = {}
  openShaftsAt = {}
  openShaftRNGs = {}
  openShaftDepths = {}
  openShaftLengths = {}
  openShaftDFFs = {}
  openShaftModels = {}
  openShaftObjects = {}
  openShaftCols = {}
  openShaftDirty = {}
  openShaftLoaded = {}
  r51_0 = {}
  openShaftExporting = {}
  r53_0 = {}
  openShaftOres = {}
  r55_0 = {}
  openShaftBombs = {}
  bombDetonations = {}
end
function unloadMineRails()
  -- line: [1078, 1120] id: 17
  deleteMineTrain()
  for r3_17, r4_17 in pairs(railTracks) do
    for r8_17, r9_17 in pairs(r4_17.objectList) do
      checkMineUnloadingTime()
      if isElement(r9_17) then
        destroyElement(r9_17)
      end
      r4_17.objectList[r8_17] = nil
    end
  end
  for r3_17, r4_17 in pairs(railSwitches) do
    checkMineUnloadingTime()
    if isElement(r4_17.objectElement) then
      destroyElement(r4_17.objectElement)
    end
    r4_17.objectElement = nil
  end
  railTracks = {}
  railsAt = {}
  railEndsAt = {}
  railSwitches = {}
  railSwitchesAt = {}
  railSwitchEnds = {}
  railSwitchRoutes = {}
  railSwitchStates = {}
  railSwitchFading = {}
  railSwitchBusy = {}
  locoSeatByPassenger = {}
  locoPassengerBySeat = {}
  cartTurtleEmptying = {}
  cartTurtleRotation = {}
end
function unloadMineOres()
  -- line: [1122, 1189] id: 18
  for r3_18, r4_18 in pairs(fixOres) do
    checkMineUnloadingTime()
    if isElement(r4_18[6]) then
      destroyElement(r4_18[6])
    end
    r4_18[6] = nil
  end
  for r3_18, r4_18 in pairs(oreTypes) do
    for r8_18, r9_18 in pairs(r4_18) do
      checkMineUnloadingTime()
      if isElement(r9_18) then
        destroyElement(r9_18)
      end
      if type(r9_18) == "userdata" then
        r4_18[r8_18] = nil
      end
    end
  end
  for r3_18 = 1, #r95_0, 1 do
    local r4_18 = r95_0[r3_18]
    if isElement(r4_18.oreElement) then
      destroyElement(r4_18.oreElement)
    end
    r4_18.oreElement = nil
  end
  for r3_18 = 1, #r96_0, 1 do
    local r4_18 = r96_0[r3_18]
    if isElement(r4_18.objectElement) then
      destroyElement(r4_18.objectElement)
    end
    r4_18.objectElement = nil
  end
  for r3_18 = 1, #r97_0, 1 do
    checkMineUnloadingTime()
    if isElement(r97_0[1]) then
      destroyElement(r97_0[1])
    end
    r97_0[1] = nil
  end
  r94_0 = {}
  fixOreCarts = {}
  fixOres = {}
  fixOreStreamed = {}
  r90_0 = {}
  r93_0 = {}
  r92_0 = nil
  r95_0 = {}
  r96_0 = {}
  r97_0 = {}
end
function unloadMineInventory()
  -- line: [1191, 1251] id: 19
  for r3_19 in pairs(r98_0) do
    checkMineUnloadingTime()
    if isElement(r98_0[r3_19]) then
      destroyElement(r98_0[r3_19])
    end
    r98_0[r3_19] = nil
  end
  r98_0 = {}
  for r3_19 in pairs(r99_0) do
    checkMineUnloadingTime()
    if isElement(r99_0[r3_19]) then
      destroyElement(r99_0[r3_19])
    end
    r99_0[r3_19] = nil
  end
  r99_0 = {}
  for r3_19 in pairs(r100_0) do
    checkMineUnloadingTime()
    if isElement(r100_0[r3_19]) then
      destroyElement(r100_0[r3_19])
    end
    r100_0[r3_19] = nil
  end
  r100_0 = {}
  for r3_19, r4_19 in pairs(mineMachineData) do
    checkMineUnloadingTime()
    if isElement(r4_19) then
      destroyElement(r4_19)
    end
    mineMachineData[r3_19] = nil
  end
  mineMachineData = {}
  for r3_19, r4_19 in pairs(currentMineInventory) do
    checkMineUnloadingTime()
    if isElement(r4_19) then
      destroyElement(r4_19)
    end
    currentMineInventory[r3_19] = nil
  end
  currentMineInventory = {}
end
function doMineLoadEnded()
  -- line: [1253, 1267] id: 20
  removeEventHandler("onClientPreRender", root, preRenderMineLoading)
  for r3_20 = 1, #pendingEvents, 1 do
    processPendingEvent(r3_20)
  end
  loadingMineEnter = false
  loadingMineEnterSynced = false
  r4_0 = 0
  r5_0 = nil
  forceRefreshTrain = true
end
function doMineJobs()
  -- line: [1271, 1300] id: 21
  if r8_0 then
    if coroutine.status(r8_0) == "dead" then
      r8_0 = nil
    else
      r10_0 = getTickCount()
      coroutine.resume(r8_0)
    end
    return true
  elseif #r11_0 > 0 then
    if r11_0[1].currentStage >= 6 then
      if #dffExportQueue > 0 then
        r8_0 = coroutine.create(processDffExportQueue)
        r9_0 = getTickCount()
      else
        r8_0 = coroutine.create(processShaftJobQueue)
        r9_0 = getTickCount()
      end
    else
      r8_0 = coroutine.create(processShaftJobQueue)
      r9_0 = getTickCount()
    end
    return true
  elseif #dffExportQueue > 0 then
    r8_0 = coroutine.create(processDffExportQueue)
    r9_0 = getTickCount()
    return true
  end
  return false
end
function processPendingEvent(r0_22)
  -- line: [1302, 1332] id: 22
  local r1_22 = table.remove(pendingEvents, r0_22)
  if not r1_22 then
    return 
  end
  if r1_22.eventName == "syncFixOreState" then
    if isElement(r1_22.sourceElement) and r1_22.sourceElement ~= resourceRoot then
      setPedAnimation(r1_22.sourceElement)
    else
      local r2_22 = r1_22.handlerFunctionParams[1]
      if isElement(r94_0[r2_22]) then
        setPedAnimation(r94_0[r2_22])
      end
    end
  elseif r1_22.eventName == "syncMineOreBoxCarry" then
    if isElement(r1_22.sourceElement) and r1_22.sourceElement ~= resourceRoot then
      setPedAnimation(r1_22.sourceElement)
    else
      local r2_22 = r1_22.handlerFunctionParams[1]
      if isElement(oreTypes[r2_22].carriedBy) then
        setPedAnimation(oreTypes[r2_22].carriedBy)
      end
    end
  end
  r1_22.handlerFunction(currentMine, unpack(r1_22.handlerFunctionParams))
end
function checkMinePermission(r0_23)
  -- line: [1334, 1352] id: 23

  return true
  --[[if not selfCharacterId or not currentMineOwnerId then
    return false
  end
  if selfCharacterId == currentMineOwnerId then
    return true
  end
  if r0_23 then
    local r1_23 = currentMinePermissions[selfCharacterId]
    if r1_23 then
      return bitTest(r1_23, r0_23)
    end
  end
  return false--]]
end
addEvent("gotMineHandItems", true)
addEventHandler("gotMineHandItems", localPlayer, function(r0_24, r1_24, r2_24)
  -- line: [1356, 1368] id: 24
  for r6_24 in pairs(r0_24) do
    triggerEvent("syncPickaxe", r6_24, true)
  end
  for r6_24 in pairs(r1_24) do
    triggerEvent("syncBagWield", r6_24, true)
  end
  for r6_24 in pairs(r2_24) do
    triggerEvent("syncMineTablet", r6_24, true)
  end
end)
function setBagWieldMode(r0_25)
  -- line: [1373, 1381] id: 25
  r80_0 = r0_25
  if r80_0 then
    exports.sControls:toggleControl("fire", not r0_25, "bagWieldMode")
  end
  return triggerServerEvent("syncBagWield", localPlayer, type(r80_0) == "number")
end
addEvent("syncBagWield", true)
addEventHandler("syncBagWield", root, function(r0_26)
  -- line: [1385, 1401] id: 26
  if isElement(source) and r0_26 then
    r81_0[source] = true
    bagStreamIn()
    addEventHandler("onClientPlayerStreamIn", source, bagStreamIn)
    addEventHandler("onClientPlayerStreamOut", source, bagStreamOut)
    addEventHandler("onClientPlayerQuit", source, bagStreamOut)
    return 
  end
  bagStreamOut()
  removeEventHandler("onClientPlayerStreamIn", source, bagStreamIn)
  removeEventHandler("onClientPlayerStreamOut", source, bagStreamOut)
  removeEventHandler("onClientPlayerQuit", source, bagStreamOut)
end)
function bagStreamIn()
  -- line: [1404, 1415] id: 27
  local hat = exports.sClothesshop:getPlayerMiningHat(source)
  if hat then
    setStreamedHardHat(source, hat)
  end
  if r81_0[source] and not r82_0[source] then
    r82_0[source] = createObject(exports.sModloader:getModelId("v4_burlap_sack"), 0, 0, 0)
    if isElement(r82_0[source]) then
      exports.sPattach:attach(r82_0[source], source, 25, -0.017693201914203, -0.091659694702951, 0.056322265779161, 0, 0, 0)
      exports.sPattach:setRotationQuaternion(r82_0[source], {
        0.74603372741722,
        -0.55551711504458,
        0.13616751367391,
        -0.34101733191787
      })
      setObjectScale(r82_0[source], 0.62763045756295, 1, 0.85229540297405)
    end
  end
end
function bagStreamOut()
  -- line: [1417, 1427] id: 28
  if eventName ~= "onClientPlayerStreamOut" then
    r81_0[source] = nil
  end
  if isElement(r82_0[source]) then
    destroyElement(r82_0[source])
  end
  r82_0[source] = nil
end
function setPickaxeMode(r0_29, pickaxeType)
  -- line: [1431, 1439] id: 29
  pickaxeItem = r0_29
  if currentMine then
    exports.sControls:toggleControl("fire", not r0_29, "minePickaxeMode")
  end
  return triggerServerEvent("syncPickaxe", localPlayer, r0_29, pickaxeType)
end

function isPlayerInMine()
  return currentMine
end

function setPlayerMineAim(r0_30, r1_30, r2_30)
  -- line: [1441, 1464] id: 30
  if r1_30 then
    if not r83_0[r0_30] then
      r83_0[r0_30] = {
        r1_30,
        r2_30
      }
    else
      r83_0[r0_30][1] = r1_30
      r83_0[r0_30][2] = r2_30
    end
  elseif r83_0[r0_30] then
    r83_0[r0_30] = nil
    if not r84_0[r0_30] then
      setPedAnimation(r0_30)
    end
  end
  if r0_30 == localPlayer then
    triggerServerEvent("syncMineAim", localPlayer, r1_30, r2_30)
    if eventName ~= "syncMineAim" then
      exports.sControls:toggleControl({
        "fire",
        "crouch",
        "action"
      }, not r1_30, "minePickaxeAim")
    end
  end
end
function setPlayerMineHit(r0_31, r1_31)
  -- line: [1466, 1480] id: 31
  if r1_31 then
    if not r84_0[r0_31] then
      r84_0[r0_31] = 0
    end
    r85_0[r0_31] = true
  else
    r85_0[r0_31] = nil
  end
  if r0_31 == localPlayer then
    triggerServerEvent("syncMineHit", localPlayer, r1_31)
  end
end
addEvent("syncPickaxe", true)
addEventHandler("syncPickaxe", root, function(r0_32, pickaxeType)
  -- line: [1484, 1500] id: 32
  iprint(pickaxeType)
  if isElement(source) and r0_32 then
    r78_0[source] = pickaxeType
    pickaxeStreamIn()
    addEventHandler("onClientPlayerStreamIn", source, pickaxeStreamIn)
    addEventHandler("onClientPlayerStreamOut", source, pickaxeStreamOut)
    addEventHandler("onClientPlayerQuit", source, pickaxeStreamOut)
    return 
  end
  pickaxeStreamOut()
  removeEventHandler("onClientPlayerStreamIn", source, pickaxeStreamIn)
  removeEventHandler("onClientPlayerStreamOut", source, pickaxeStreamOut)
  removeEventHandler("onClientPlayerQuit", source, pickaxeStreamOut)
end)
function pickaxeStreamIn()
  -- line: [1503, 1513] id: 33
  iprint(r78_0[source])
  if r78_0[source] and not r79_0[source] then
    r79_0[source] = createObject(exports.sModloader:getModelId("wep_pickaxe" .. r78_0[source]), 0, 0, 0)
    if isElement(r79_0[source]) then
      exports.sPattach:attach(r79_0[source], source, "weapon")
    end
  end
end
function pickaxeStreamOut()
  -- line: [1515, 1525] id: 34
  if eventName ~= "onClientPlayerStreamOut" then
    r78_0[source] = nil
  end
  if isElement(r79_0[source]) then
    destroyElement(r79_0[source])
  end
  r79_0[source] = nil
end
addMineEventHandler("syncMineAim", root, function(r0_35, r1_35, r2_35)
  -- line: [1528, 1532] id: 35
  if isElement(source) then
    setPlayerMineAim(source, r1_35, r2_35)
  end
end)
addMineEventHandler("syncMineHit", root, function(r0_36, r1_36)
  -- line: [1536, 1540] id: 36
  if isElement(source) then
    setPlayerMineHit(source, r1_36)
  end
end)
function playerWastedMine()
  -- line: [1545, 1557] id: 37
  if currentActiveBlockId then
    setPlayerMineAim(localPlayer, false, false)
    currentActiveBlockId = false
  end
  if r77_0 then
    setPlayerMineHit(localPlayer, false)
    r77_0 = false
  end
  forceExitLoco()
end
function pedsProcessedMine()
  -- line: [1559, 1674] id: 38
  local r0_38 = {}
  pedsProcessedTrain(r0_38)
  pedsProcessedTablet(r0_38)
  for r4_38, r5_38 in pairs(cartTurtleEmptying) do
    if isElement(r5_38) then
      local r6_38, r7_38, r8_38 = getElementPosition(cartTurtleObjects[r4_38])
      setElementPosition(r5_38, r6_38, r7_38 - 0.75, minePosZ + 1)
      setElementRotation(r5_38, 0, 0, 0, "default", true)
      setElementBoneRotation(r5_38, 2, 0, 20 * (cartTurtleRotation[r4_38] or 0), 0)
      setElementBoneRotation(r5_38, 3, 0, 15 * (cartTurtleRotation[r4_38] or 0), 0)
      setElementBoneRotation(r5_38, 22, 13.043463333793, -49.565267148225, -20.869540338931)
      setElementBoneRotation(r5_38, 23, -33.912973818572, -57.391204833984, 0.000054732612909447)
      setElementBoneRotation(r5_38, 32, -13.043463333793, -49.565267148225, 20.869540338931)
      setElementBoneRotation(r5_38, 33, -33.912973818572, -57.391204833984, 0.000054732612909447)
      r0_38[r5_38] = true
    end
  end
  for r4_38, r5_38 in pairs(r83_0) do
    if not r84_0[r4_38] and isElementStreamedIn(r4_38) then
      local r6_38, r7_38 = getPedAnimation(r4_38)
      if r6_38 ~= "mining_hit" or r7_38 ~= "bather" then
        setPedAnimation(r4_38, "mining_hit", "bather", -1, true, false, false, true, 0)
      end
      setPedAnimationSpeed(r4_38, "bather", 0)
      setPedAnimationProgress(r4_38, "bather", 0.15)
    end
    if isElementOnScreen(r4_38) then
      local r6_38 = r5_38[1]
      local r7_38 = r5_38[2]
      if openShaftDepths[r6_38] then
        local r8_38 = 0
        local r9_38 = 0
        if r62_0 == r6_38 then
          r8_38 = r64_0
          r9_38 = r65_0
        elseif shaftPositions[r6_38] then
          r8_38 = shaftPositions[r6_38][1]
          r9_38 = shaftPositions[r6_38][2]
        end
        local r10_38, r11_38, r12_38 = getShaftBlockPosition(r6_38, r7_38)
        local r13_38, r14_38, r15_38 = getElementPosition(r4_38)
        local r16_38, r17_38, r18_38 = getElementRotation(r4_38)
        local r19_38 = math.deg((math.atan2(r14_38 - r11_38, r13_38 - r10_38) + PI_2 - math.rad(r18_38) + PI) % TWO_PI - PI)
        local r20_38 = math.deg(math.asin((r12_38 - r15_38) / getDistanceBetweenPoints3D(r10_38, r11_38, r12_38, r13_38, r14_38, r15_38)))
        local r21_38 = 180 * mineDelta / 1000
        if r19_38 > 20 then
          setElementRotation(r4_38, r16_38, r17_38, r18_38 + r21_38, "default", true)
          r19_38 = r19_38 - r21_38
        elseif r19_38 < -20 then
          setElementRotation(r4_38, r16_38, r17_38, r18_38 - r21_38, "default", true)
          r19_38 = r19_38 + r21_38
        end
        if not r5_38[3] then
          r5_38[3] = r19_38
        elseif r5_38[3] ~= r19_38 then
          local r22_38 = r5_38[3] - r19_38
          if r22_38 > 0 then
            r5_38[3] = math.max(r19_38, r5_38[3] - r21_38)
          elseif r22_38 < 0 then
            r5_38[3] = math.min(r19_38, r5_38[3] + r21_38)
          end
        end
        if not r5_38[4] then
          r5_38[4] = r20_38
        elseif r5_38[4] ~= r20_38 then
          local r22_38 = r5_38[4] - r20_38
          if r22_38 > 0 then
            r5_38[4] = math.max(r20_38, r5_38[4] - r21_38)
          elseif r22_38 < 0 then
            r5_38[4] = math.min(r20_38, r5_38[4] + r21_38)
          end
        end
        local r22_38 = math.max(-20, math.min(20, r5_38[3])) - 22
        local r23_38 = math.min(20, r5_38[4] - 10)
        local r24_38, r25_38, r26_38 = getElementBoneRotation(r4_38, 2)
        local r27_38, r28_38, r29_38 = getElementBoneRotation(r4_38, 3)
        setElementBoneRotation(r4_38, 2, r24_38 + r22_38 / 2, r25_38 - r23_38, r26_38)
        setElementBoneRotation(r4_38, 3, r27_38 + r22_38 / 2, r28_38, r29_38)
        r0_38[r4_38] = true
      end
    end
  end
  for r4_38 in pairs(r0_38) do
    updateElementRpHAnim(r4_38)
  end
  processFixOrePlayers()
end
function isPlayerFreeFromAction(r0_39)
  -- line: [1676, 1697] id: 39
  if not r88_0[r0_39] and currentMineInventory.jerryCarry ~= r0_39 then
    if r0_39 == localPlayer then
      local r1_39 = carryingFixOre
      if not r1_39 then
        r1_39 = 0 < getElementHealth(localPlayer)
      else
        r1_39 = emptyingTurtle
      end
      return r1_39
    else
      for r4_39, r5_39 in pairs(r94_0) do
        if r5_39 == r0_39 then
          return false
        end
      end
      for r4_39, r5_39 in pairs(cartTurtleEmptying) do
        if r5_39 == r0_39 then
          return false
        end
      end
      return true
    end
  end
  return false
end
function preRenderMine(r0_40)
  -- line: [1699, 2898] id: 40
  -- notice: unreachable block#184
  mineTick = getTickCount()
  mineDelta = r0_40
  if not loadingMineExit then
    setTime(12, 0)
    setWeather(1)
    setSkyGradient(0, 0, 0, 0, 0, 0)
    setFarClipDistance(insideFarClipDistance)
    setFogDistance(21)
  end
  r23_0 = nil
  selfPosX, selfPosY, selfPosZ = getElementPosition(localPlayer)
  selfMineX = convertSingleMineCoordinate(selfPosX)
  selfMineY = convertSingleMineCoordinate(selfPosY)
  selfCamX, selfCamY, selfCamZ, selfCamTargetX, selfCamTargetY, selfCamTargetZ = getCameraMatrix()
  selfCamDirX = selfCamX - selfCamTargetX
  selfCamDirY = selfCamY - selfCamTargetY
  selfCamDirZ = selfCamZ - selfCamTargetZ
  local r1_40 = 1 / math.sqrt((selfCamDirX ^ 2 + selfCamDirY ^ 2 + selfCamDirZ ^ 2))
  selfCamDirX = selfCamDirX * r1_40
  selfCamDirY = selfCamDirY * r1_40
  selfCamDirZ = selfCamDirZ * r1_40
  doMineJobs()
  if convertSingleMineCoordinate(selfCamX) <= 1 then
    for r5_40 = 1, #r101_0, 1 do
      local r6_40, r7_40, r8_40, r9_40, r10_40 = unpack(r101_0[r5_40])
      dxDrawMaterialSectionLine3D(r6_40, r7_40, r8_40 + 0.095, r6_40, r7_40, r8_40 - 0.095, r9_40, 0, r10_40, 64, getTableTex(), r10_40 * 0.00296875, tocolor(0, 0, 0, 200), r6_40 - 1, r7_40, r8_40)
    end
  end
  if isPlayerFreeFromAction(localPlayer) then
    freeFromAction = true
  else
    freeFromAction = false
  end
  iprint("devmode act")
  if isElement(r3_0) then
    setSoundVolume(r3_0, 0.5 + math.max(0, math.min((selfCamX + 9) / 4, 1) * 0.5))
  end
  if not r92_0 then
    r92_0 = coroutine.create(doFixOreStreaming)
  elseif coroutine.status(r92_0) == "dead" then
    r92_0 = coroutine.create(doFixOreStreaming)
  else
    coroutine.resume(r92_0)
  end
  if currentMineInventory.fuelTankLevel ~= currentMineInventory.displayedFuelTankLevel then
    if currentMineInventory.displayedFuelTankLevel < currentMineInventory.fuelTankLevel then
      currentMineInventory.displayedFuelTankLevel = currentMineInventory.fuelTankLevel
    else
      currentMineInventory.displayedFuelTankLevel = currentMineInventory.displayedFuelTankLevel - r0_40 / 1000
      if currentMineInventory.displayedFuelTankLevel < currentMineInventory.fuelTankLevel then
        currentMineInventory.displayedFuelTankLevel = currentMineInventory.fuelTankLevel
      end
    end
  end
  if shouldRefreshJerryContent then
    local r2_40 = math.abs((currentMineInventory.jerryContent - currentMineInventory.displayedJerryContent)) / 0.5
    if currentMineInventory.displayedJerryContent < currentMineInventory.jerryContent then
      currentMineInventory.displayedJerryContent = currentMineInventory.displayedJerryContent + r0_40 / 1000
      if currentMineInventory.jerryContent < currentMineInventory.displayedJerryContent then
        currentMineInventory.displayedJerryContent = currentMineInventory.jerryContent
      end
    else
      currentMineInventory.displayedJerryContent = currentMineInventory.displayedJerryContent - r0_40 / 1000
      if currentMineInventory.displayedJerryContent < currentMineInventory.jerryContent then
        currentMineInventory.displayedJerryContent = currentMineInventory.jerryContent
      end
    end
    if r2_40 <= 0 then
      shouldRefreshJerryContent = false
      if isElement(currentMineInventory.jerrySound) then
        setSoundVolume(currentMineInventory.jerrySound, 0)
      end
    elseif isElement(currentMineInventory.jerrySound) then
      setSoundVolume(currentMineInventory.jerrySound, math.min(1, r2_40) * 0.5)
    end
  end
  if shouldRefreshBoxContent then
    local r2_40 = false
    for r6_40, r7_40 in pairs(oreTypes) do
      if not r7_40.instantItem then
        if r7_40.boxContent ~= r7_40.displayedBoxContent then
          r2_40 = true
          if r7_40.displayedBoxContent < r7_40.boxContent then
            r7_40.displayedBoxContent = r7_40.displayedBoxContent + r0_40 / 10000
            if r7_40.boxContent < r7_40.displayedBoxContent then
              r7_40.displayedBoxContent = r7_40.boxContent
            end
          else
            r7_40.displayedBoxContent = r7_40.displayedBoxContent - r0_40 / 5000
            if r7_40.displayedBoxContent < r7_40.boxContent then
              r7_40.displayedBoxContent = r7_40.boxContent
            end
          end
        end
        if r7_40.boxContent == r7_40.displayedBoxContent and checkOreBuffer(r6_40) then
          r2_40 = true
        end
        refreshOreBoxScale(r6_40)
      end
    end
    shouldRefreshBoxContent = r2_40
  end
  local r11_40 = nil	-- notice: implicit variable refs by block#[347]
  if shouldRefreshFoundryContent then
    local r2_40 = false
    for r6_40, r7_40 in pairs(oreTypes) do
      if r7_40.foundryContent ~= r7_40.displayedFoundryContent then
        r2_40 = true
        if r7_40.displayedFoundryContent < r7_40.foundryContent then
          local r9_40 = math.min(r0_40 / 2222.222222222222, r7_40.foundryContent - r7_40.displayedFoundryContent)
          r7_40.displayedFoundryContent = r7_40.displayedFoundryContent + r9_40
          r11_40 = r9_40 * 150
          r7_40.furnaceTemperature = r7_40.furnaceTemperature - r11_40
          if r7_40.furnaceTemperature < 0 then
            r7_40.furnaceTemperature = 0
          end
        else
          r7_40.displayedFoundryContent = r7_40.displayedFoundryContent - r0_40 / 10000
          if r7_40.displayedFoundryContent < r7_40.foundryContent then
            r7_40.displayedFoundryContent = r7_40.foundryContent
          end
        end
      end
    end
    shouldRefreshFoundryContent = r2_40
  end
  local r2_40 = false
  local r3_40 = false
  local r4_40 = math.huge
  if r62_0 then
    if openShaftDepths[r62_0] then
      r3_40, r4_40 = isShaftWallVisible(r62_0, true)
      if not r3_40 then
        setCurrentActiveOpenShaft(false)
      else
        if r66_0 then
          processCurrentActiveWorld()
        end
        dxDrawMaterialPrimitive3D("trianglelist", currentActiveShaftShader, "prefx", unpack(r63_0))
      end
    else
      setCurrentActiveOpenShaft(false)
    end
  end
  for r8_40 in pairs(openShaftDirty) do
    local r9_40, r10_40 = isShaftWallVisible(r8_40)
    if r9_40 then
      r11_40 = r62_0
      if not r11_40 or not r3_40 or r10_40 < r4_40 then
        r2_40 = r8_40
        r4_40 = r10_40
      end
    end
    r11_40 = r62_0
    if r11_40 ~= r8_40 and r2_40 ~= r8_40 and r9_40 then
      r11_40 = shaftPositions[r8_40]
      iprint(r8_40)
      if not openShaftObjects[r8_40] then
        if r11_40 and r11_40[1] and r11_40[2] then
          openShaftObjects[r8_40] = createObject(shaftWallModel, r11_40[1], r11_40[2], minePosZ, 0, 0, shaftRotations[r8_40][1])
          if isElement(openShaftObjects[r8_40]) then
            setElementInterior(openShaftObjects[r8_40], 0)
            setElementDimension(openShaftObjects[r8_40], currentMine)
          end
        end
      end
      if 5000 < mineTick - r53_0[r8_40] and not r8_0 then
        openShaftDirty[r8_40] = nil
        r53_0[r8_40] = mineTick
        r8_0 = coroutine.create(generateOpenShaftDff)
        r9_0 = mineTick
        r57_0 = r8_40
      end
    end
  end
  for r8_40 in pairs(openShaftModels) do
    if not openShaftExporting[r8_40] then
      if isShaftWallVisible(r8_40, true) then
        r51_0[r8_40] = nil
      else
        local r10_40 = r51_0
        r11_40 = r51_0[r8_40] or 0
        r11_40 = r11_40 + r0_40
        r10_40[r8_40] = r11_40
        if 2500 < r51_0[r8_40] or 10 < modelPoolCount then
          openShaftDirty[r8_40] = true
          if isElement(openShaftObjects[r8_40]) then
            destroyElement(openShaftObjects[r8_40])
          end
          if isElement(openShaftDFFs[r8_40]) then
            destroyElement(openShaftDFFs[r8_40])
          end
          if openShaftModels[r8_40] then
            poolFreeModel(openShaftModels[r8_40])
          end
          openShaftModels[r8_40] = nil
        end
      end
    end
  end
  r67_0 = false
  r68_0 = false
  r69_0 = false
  r70_0 = false
  if r62_0 then
    r67_0 = r62_0
    r68_0 = getDistanceBetweenPoints2D(selfPosX, selfPosY, r64_0, r65_0)
    r69_0 = r64_0
    r70_0 = r65_0
  end
  for r8_40 in pairs(openShaftDepths) do
    local r9_40, r10_40 = isShaftWallVisible(r8_40)
    if r9_40 then
      r11_40 = r68_0 or r10_40
      if r10_40 <= r11_40 then
        r67_0 = r8_40
        r68_0 = r10_40
        r69_0 = shaftPositions[r8_40][1]
        r11_40 = shaftPositions[r8_40][2]
        r70_0 = r11_40
      end
    end
  end
  local r5_40 = true
  if not pickaxeItem then
    r5_40 = false
  elseif not r67_0 then
    r5_40 = false
  elseif openShaftBombs[r67_0] then
    r5_40 = false
  elseif not checkMinePermission(permissionFlags.MINING) then
    r5_40 = false
  end
  for r9_40 in pairs(r84_0) do
    local r10_40 = math.min
    r11_40 = 1
    local r12_40 = r84_0[r9_40]
    local r13_40 = r85_0[r9_40]
    if r13_40 then
      r13_40 = r0_40 / 750
    else
      r13_40 = -r0_40 / 187.5
    end
    r10_40 = r10_40(r11_40, r12_40 + r13_40)
    if r10_40 <= 0 then
      r84_0[r9_40] = nil
      r85_0[r9_40] = nil
      r11_40 = r83_0[r9_40]
      if not r11_40 then
        setPedAnimation(r9_40)
      end
    else
      r84_0[r9_40] = r10_40
      r11_40 = isElementStreamedIn(r9_40)
      if r11_40 then
        local r11_40, r12_40 = getPedAnimation(r9_40)
        if r11_40 ~= "mining_hit" or r12_40 ~= "bather" then
          setPedAnimation(r9_40, "mining_hit", "bather", -1, true, false, false, true, 0)
        end
        setPedAnimationSpeed(r9_40, "bather", 0)
        setPedAnimationProgress(r9_40, "bather", 0.15 + math.pow(r10_40, 2) * 0.825)
      end
    end
  end
  if r5_40 then
    if getPedControlState(localPlayer, "aim_weapon") then
      local r7_40, r8_40, r9_40 = getPedTargetEnd(localPlayer)
      if r7_40 then
        local r10_40, r11_40 = getScreenFromWorldPosition(r7_40, r8_40, r9_40)
        if r10_40 then
          dxDrawRectangle(r10_40 - 12 - 5, r11_40 - 2, 12, 4, greenToColor)
          dxDrawRectangle(r10_40 + 5, r11_40 - 2, 12, 4, greenToColor)
          dxDrawRectangle(r10_40 - 5, r11_40 - 4, 2, 8, greenToColor)
          dxDrawRectangle(r10_40 + 3, r11_40 - 4, 2, 8, greenToColor)
        end
        local r12_40 = shaftRotations[r67_0][3]
        local r13_40 = shaftRotations[r67_0][4]
        local r14_40 = nil
        local r15_40 = nil
        local r16_40 = nil
        local r17_40 = nil
        local r18_40 = nil
        local r19_40 = nil
        local r20_40 = nil
        if r77_0 then
          r16_40, r17_40, r18_40 = getShaftBlockPosition(r67_0, currentActiveBlockId)
          r19_40 = openShaftDepths[r67_0][currentActiveBlockId]
          r16_40 = r16_40 - r12_40 * 0.1
          r17_40 = r17_40 - r13_40 * 0.1
          for r24_40 = 1, wallBlockCount, 1 do
            local r25_40 = openShaftDepths[r67_0][r24_40]
            if not r14_40 or r25_40 < r14_40 then
              r14_40 = r25_40
            end
          end
          r77_0 = math.min(1, r77_0 + r0_40 / 750)
          if not getKeyState("mouse1") then
            setPlayerMineHit(localPlayer, false)
            if r77_0 > 0.3 then
              triggerServerEvent("handleMineHit", localPlayer, r67_0, currentActiveBlockId, math.pow((r77_0 - 0.3) / 0.7, 2))
            end
            r77_0 = false
          end
        else
          if r68_0 < 3 then
            local r21_40 = {}
            for r25_40 = 1, wallBlockCount, 1 do
              local r26_40, r27_40, r28_40 = getShaftBlockPosition(r67_0, r25_40)
              local r29_40 = openShaftDepths[r67_0][r25_40]
              r26_40 = r26_40 - (r12_40 * 0.1)
              r27_40 = r27_40 - (r13_40 * 0.1)
              local r30_40 = computeLineDistance(r26_40, r27_40, r28_40, selfCamX, selfCamY, selfCamZ, r7_40, r8_40, r9_40)
              if r30_40 and r30_40 <= (r20_40 or r30_40) then
                r15_40 = r25_40
                r16_40 = r26_40
                r17_40 = r27_40
                r18_40 = r28_40
                r19_40 = r29_40
                r20_40 = r30_40
              end
              if not r14_40 or r29_40 < r14_40 then
                r14_40 = r29_40
              end
              r21_40[r25_40] = {
                r26_40,
                r27_40,
                r28_40
              }
            end
            for r25_40 = 1, wallBlockCount, 1 do
              if r15_40 ~= r25_40 then
                local r26_40, r27_40, r28_40 = unpack(r21_40[r25_40])
                local r29_40 = getMiningZoneColor((openShaftDepths[r67_0][r25_40] - r14_40) / wallMaximumDepth * wallMaximumDepth)
                dxDrawMaterialLine3D(r26_40, r27_40, r28_40 + 0.1, r26_40, r27_40, r28_40 - 0.1, staticTextures.mineFull, 0.2, tocolor(r29_40[1], r29_40[2], r29_40[3], 155), r26_40 - r12_40, r27_40 - r13_40, r28_40)
              end
            end
          end
          if currentActiveBlockId ~= r15_40 then
            currentActiveBlockId = r15_40
            if r15_40 then
              setPlayerMineAim(localPlayer, r67_0, r15_40)
            else
              setPlayerMineAim(localPlayer, false, false)
            end
          end
          if currentActiveBlockId and getKeyState("mouse1") and (r19_40 - r14_40) / (wallMaximumDepth * wallMaximumDepth) <= 0.9 then
            r77_0 = 0
            setPlayerMineHit(localPlayer, true)
          end
        end
        if currentActiveBlockId then
          local r21_40 = getMiningZoneColor((r19_40 - r14_40) / wallMaximumDepth * wallMaximumDepth)
          if r77_0 then
            local r22_40 = math.pow(r77_0, 2)
            if r22_40 > 0 then
              dxDrawMaterialSectionLine3D(r16_40, r17_40, r18_40 - 0.25 + 0.5 * r22_40, r16_40, r17_40, r18_40 - 0.25, 0, 128 * (1 - r22_40), 128, 128 * r22_40, staticTextures.mineCircle, 0.5, tocolor(r21_40[1], r21_40[2], r21_40[3], 200), r16_40 - r12_40, r17_40 - r13_40, r18_40)
            end
          end
          dxDrawMaterialLine3D(r16_40, r17_40, r18_40 + 0.25, r16_40, r17_40, r18_40 - 0.25, staticTextures.mineAim, 0.5, tocolor(r21_40[1], r21_40[2], r21_40[3], 155), r16_40 - r12_40, r17_40 - r13_40, r18_40)
        end
      end
    else
      if currentActiveBlockId then
        setPlayerMineAim(localPlayer, false, false)
        currentActiveBlockId = false
      end
      if r77_0 then
        setPlayerMineHit(localPlayer, false)
        r77_0 = false
      end
    end
  else
    if currentActiveBlockId then
      setPlayerMineAim(localPlayer, false, false)
      currentActiveBlockId = false
    end
    if r77_0 then
      setPlayerMineHit(localPlayer, false)
      r77_0 = false
    end
  end
  if r2_40 then
    setCurrentActiveOpenShaft(r2_40)
  end
  for r9_40, r10_40 in pairs(openShaftOres) do
    r11_40 = r62_0
    if r11_40 ~= r9_40 then
      r11_40 = isShaftWallVisible(r9_40)
    else
      r11_40 = true
    end
    if r11_40 then
      local r12_40 = openShaftLengths[r9_40]
      for r16_40 = 1, #r10_40, 1 do
        if r10_40[r16_40] then
          local r17_40, r18_40, r19_40, r20_40, r21_40, r22_40, r23_40 = unpack(r10_40[r16_40])
          if not isElement(r10_40[r16_40][5]) and r20_40 - 0.5 <= r12_40 + 1.2 then
            r25_40 = oreTypes[r22_40] and oreTypes[r22_40].modelName or "v4_mine_ore" .. math.random(1, 5)

            if not r25_40 then
                r25_40 = "v4_mine_ore" .. math.random(1, 5)
            end
            local r26_40 = createObject(modelIds[r25_40], minePosX + r17_40, minePosY + r18_40, minePosZ + r19_40, math.random() * 360, math.random() * 360, math.random() * 360)
            if isElement(r26_40) then
              refreshOreShader(r26_40, r22_40)
              setElementInterior(r26_40, 0)
              setElementDimension(r26_40, currentMine)
            end
            r10_40[r16_40][5] = r26_40
          end
        end
      end
    end
  end
  processFallingOres(r0_40 / 1000)
  processParticles(r0_40 / 1000)
  processRailCars(r0_40 / 1000)
  for r9_40, r10_40 in pairs(openShaftBombs) do
    processDynamiteEffect(r10_40, r0_40)
  end
  for r9_40 in pairs(shaftBombs) do
    local r10_40 = pairs
    r11_40 = shaftBombs[r9_40]
    for r13_40 in r10_40(r11_40) do
      for r17_40 in pairs(shaftBombs[r9_40][r13_40]) do
        processDynamiteEffect(shaftBombs[r9_40][r13_40][r17_40], r0_40)
      end
    end
  end
  for r9_40 in pairs(threeJunctionBombs) do
    local r10_40 = pairs
    r11_40 = threeJunctionBombs[r9_40]
    for r13_40 in r10_40(r11_40) do
      processDynamiteEffect(threeJunctionBombs[r9_40][r13_40], r0_40)
    end
  end
  for r9_40 = #bombDetonations, 1, -1 do
    r11_40 = 1.5 * r0_40 / 1000
    local r10_40 = bombDetonations[r9_40][4] + r11_40
    if r10_40 < 1 then
      r11_40 = bombDetonations[r9_40]
      r11_40[4] = r10_40
    else
      table.remove(bombDetonations, r9_40)
    end
  end
  local r6_40 = r88_0[localPlayer]
  if r6_40 then
    local r7_40 = oreTypes[r6_40]
    if r7_40 then
      local r8_40, r9_40, r10_40 = unpack(r7_40.foundryInputPosition)
      dxDrawMaterialLine3D(r8_40, r9_40, r10_40 + 0.125 * r2_0 + 0.5, r8_40, r9_40, r10_40 + 0.125 * r2_0 + 0.25, staticTextures.arrowMarker, 0.3, greenToColor)
    end
  end
  local r7_40 = false
  local r8_40 = false
  for r12_40 = 1, #cartTurtleObjects, 1 do
    local r13_40 = cartTurtleObjects[r12_40]
    if cartTurtleEmptying[r12_40] then
      r7_40 = true
      if (cartTurtleRotation[r12_40] or 0) <= 0 then
        local r14_40 = playSound3D("files/sounds/turtleemptying.wav", 0, 0, 0)
        if isElement(r14_40) then
          setElementInterior(r14_40, 0)
          setElementDimension(r14_40, currentMine)
          setSoundMaxDistance(r14_40, 40)
          if isElement(r13_40) then
            attachElements(r14_40, r13_40)
          end
        end
      end
      cartTurtleRotation[r12_40] = math.min(1, (cartTurtleRotation[r12_40] or 0) + r0_40 / 2000)
      if isElement(r13_40) then
        local r14_40, r15_40, r16_40 = getElementRotation(r13_40)
        if r16_40 >= 180 then
          setElementAttachedOffsets(r13_40, 0.0212, 0, 0.801, 85 * getEasingValue(cartTurtleRotation[r12_40], "InOutQuad"), 0, 0)
        else
          setElementAttachedOffsets(r13_40, 0.0212, 0, 0.801, -85 * getEasingValue(cartTurtleRotation[r12_40], "InOutQuad"), 0, 0)
        end
      end
    elseif cartTurtleRotation[r12_40] then
      if cartTurtleRotation[r12_40] >= 1 then
        local r14_40 = playSound3D("files/sounds/turtleemptyingdone.wav", 0, 0, 0)
        if isElement(r14_40) then
          setElementInterior(r14_40, 0)
          setElementDimension(r14_40, currentMine)
          setSoundMaxDistance(r14_40, 40)
          if isElement(r13_40) then
            attachElements(r14_40, r13_40)
          end
        end
      end
      cartTurtleRotation[r12_40] = cartTurtleRotation[r12_40] - r0_40 / 2000
      if cartTurtleRotation[r12_40] < 0 then
        cartTurtleRotation[r12_40] = nil
        if isElement(r13_40) then
          setElementAttachedOffsets(r13_40, 0.0212, 0, 0.801, 0, 0, 0)
        end
      elseif isElement(r13_40) then
        local r14_40, r15_40, r16_40 = getElementRotation(r13_40)
        if r16_40 >= 180 then
          setElementAttachedOffsets(r13_40, 0.0212, 0, 0.801, 85 * getEasingValue(cartTurtleRotation[r12_40], "InOutQuad"), 0, 0)
        else
          setElementAttachedOffsets(r13_40, 0.0212, 0, 0.801, -85 * getEasingValue(cartTurtleRotation[r12_40], "InOutQuad"), 0, 0)
        end
      end
    else
      local r14_40 = cartLastSlot[r12_40]
      if r14_40 and fixOres[r14_40] then
        local r16_40, r17_40, r18_40 = getElementPosition(r13_40)
        if conveyorStartX - 0.25 <= r16_40 and r16_40 <= conveyorStartX + 0.25 then
          dxDrawMaterialLine3D(r16_40, r17_40, r18_40 + r2_0 * 0.125 + 1, r16_40, r17_40, r18_40 + r2_0 * 0.125 + 0.75, staticTextures.arrowMarker, 0.3, greenToColor)
        else
          local r19_40 = math.abs(conveyorStartX - r16_40)
          if r19_40 < 4 then
            dxDrawMaterialLine3D(r16_40, r17_40, r18_40 + r2_0 * 0.125 + 1, r16_40, r17_40, r18_40 + r2_0 * 0.125 + 0.75, staticTextures.arrowMarker, 0.3, tocolor(red[1], red[2], red[3], (1 - math.max(0, (r19_40 - 3) / 1)) * 255))
          end
        end
      end
    end
  end
  if 0 < mineMachineData.machineRunProgress or 0 < #r95_0 or 0 < #r96_0 then
    for r12_40 = #r95_0, 1, -1 do
        r7_40 = true
        local r13_40 = r95_0[r12_40]
        if r13_40.animationStage == 1 then
           local r14_40 = (mineTick - r13_40.animationStart) / r13_40.animationLength
          if r14_40 >= 1 then
            r13_40.animationStage = r13_40.animationStage + 1
            r13_40.animationStart = mineTick
            spawnSmokeExSm(conveyorStartX + r13_40.oreBias, conveyorStartY, conveyorStartZ)
          elseif isElement(r13_40.oreElement) then
            setElementPosition(r13_40.oreElement, r13_40.orePosX + (conveyorStartX + r13_40.oreBias - r13_40.orePosX) * r14_40, r13_40.orePosY + (conveyorStartY - r13_40.orePosY) * r14_40, r13_40.orePosZ + (conveyorStartZ - r13_40.orePosZ) * getEasingValue(r14_40, "OutQuad"))
          end
        else
           r14_40 = r13_40.animationStage
          if r14_40 == 2 then
            r14_40 = (mineTick - r13_40.animationStart) / conveyorDuration
            if r14_40 >= 1 then
              r13_40.animationStage = r13_40.animationStage + 1
              r13_40.animationStart = mineTick
              spawnSmokeExSm(conveyorEndX + r13_40.oreBias, conveyorEndY + 1, conveyorEndZ)
            else
              if isElement(r13_40.oreElement) then
                setElementPosition(r13_40.oreElement, conveyorStartX + (conveyorEndX - conveyorStartX) * r14_40 + r13_40.oreBias, conveyorStartY + (conveyorEndY - conveyorStartY) * r14_40, conveyorStartZ + (conveyorEndZ - conveyorStartZ) * r14_40)
              end
            end
          elseif r13_40.animationStage == 3 then
            r14_40 = (mineTick - r13_40.animationStart) / (conveyorDuration / conveyorLength)
            if r14_40 >= 1 then
              table.remove(r95_0, r12_40)
              if isElement(r13_40.oreElement) then
                destroyElement(r13_40.oreElement)
              end
              local r15_40 = playSound3D("files/sounds/machinegrind.wav", conveyorEndX + r13_40.oreBias, conveyorEndY + 1, conveyorEndZ)
              if isElement(r15_40) then
                setElementInterior(r15_40, 0)
                setElementDimension(r15_40, currentMine)
                setSoundMaxDistance(r15_40, 60)
                setSoundVolume(r15_40, 2)
              end
              spawnSorterOre(r13_40.oreType, r13_40.oreAmount)
            elseif isElement(r13_40.oreElement) then
              setElementPosition(r13_40.oreElement, conveyorEndX + r13_40.oreBias, conveyorEndY + r14_40, conveyorEndZ)
            end
          else
            table.remove(r95_0, r12_40)
            if isElement(r13_40.oreElement) then
              destroyElement(r13_40.oreElement)
            end
          end
        end
    end
    mineMachineData.sorterProgress = (mineMachineData.sorterProgress + r0_40 / 200 * math.min(1, mineMachineData.machineRunProgress)) % 1
    local r9_40 = mineMachineData.sorterProgress * TWO_PI
    local r10_40 = math.cos(r9_40) * 0.02
    r11_40 = math.sin(r9_40) * 0.03
    local r12_40 = machinePosX + r10_40
    local r13_40 = machinePosY
    local r14_40 = machinePosZ + r11_40
    if isElement(mineMachineData.mineMachine2) then
      setElementPosition(mineMachineData.mineMachine2, r12_40, r13_40, r14_40)
    end
    local r15_40 = false
    if #r96_0 > 0 then
      r7_40 = true
      local r16_40 = true
      local r17_40 = r12_40 - 2.1249
      local r18_40 = r13_40 - 0.2139
      local r19_40 = r14_40 + 0.2109
      local r23_40 = r12_40 - 11.1369 - r17_40
      local r24_40 = r13_40 - 0.2139 - r18_40
      local r25_40 = r14_40 - 0.2445 - r19_40
      local r26_40 = math.sqrt(r23_40 ^ 2 + r24_40 ^ 2 + r25_40 ^ 2)
      r23_40 = r23_40 / r26_40
      r24_40 = r24_40 / r26_40
      r25_40 = r25_40 / r26_40
      local r27_40 = 0.15 + math.sin(r9_40) * 0.04
      for r31_40 = #r96_0, 1, -1 do
        local r32_40 = r96_0[r31_40]
        local r33_40 = r16_40
        local r34_40 = r32_40.currentPosition
        if r34_40 < 0.5 then
          r8_40 = true
          if r34_40 <= -0.3372985 then
            r34_40 = -0.3372985
            if isElement(r32_40.objectElement) then
              setObjectScale(r32_40.objectElement, 0)
            end
          elseif isElement(r32_40.objectElement) then
            setObjectScale(r32_40.objectElement, 1)
          end
          local r35_40 = (r34_40 - -2.849194) / 3.349194
          local r36_40 = math.pow((r35_40 - 0.8) / 0.2, 2)
          if r35_40 > 0.75 and 0.8 < r35_40 and not r32_40.oreType and not r32_40.effectPlayed then
            r32_40.effectPlayed = true
            local r37_40 = r17_40 + r23_40 * r35_40
            local r38_40 = r18_40 + r24_40 * r35_40
            local r39_40 = r19_40 + r25_40 * r35_40 + r27_40
            local r40_40 = playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", r37_40, r38_40, r39_40)
            if isElement(r40_40) then
              setElementInterior(r40_40, 0)
              setElementDimension(r40_40, currentMine)
            end
            spawnSmokeEx(r37_40, r38_40, r39_40)
          elseif not r32_40.oreType then
            r33_40 = false
          end
          local r37_40 = 0.5 + r10_40 * r36_40
          if isElement(r32_40.objectElement) then
            local r38_40 = minePosX - 12.5775
            local r39_40 = minePosY + 7.6567
            local r40_40 = minePosZ + 4.0229
            setElementPosition(r32_40.objectElement, r38_40 + (r17_40 + r23_40 * r37_40 - r10_40 * (1 - r36_40) - r38_40) * r35_40, r39_40 + (r18_40 + r24_40 * r37_40 - r39_40) * r35_40, r40_40 + (r19_40 + r25_40 * r37_40 + r27_40 * r36_40 - r11_40 * (1 - r36_40) - r40_40) * r35_40)
          end
        else
          local r35_40 = 0
          r15_40 = true
          r34_40 = r34_40 + r10_40
          if r32_40.currentPosition >= 9.023499 then
            r35_40 = (r32_40.currentPosition - 9.023499) / 0.35
            r34_40 = r34_40 - r10_40 * r35_40
          end
          if not oreTypes[r32_40.oreType] then
            r34_40 = r34_40 + 0.85 * r32_40.animationProgress
          end
          if isElement(r32_40.objectElement) then
            setElementPosition(r32_40.objectElement, r17_40 + r23_40 * r34_40 - r10_40 * r35_40, r18_40 + r24_40 * r34_40, r19_40 + r25_40 * r34_40 + r27_40 * (1 - r35_40) - r11_40 * r35_40 - r32_40.animationProgress)
            setObjectScale(r32_40.objectElement, 0.5 + (1 - r32_40.animationProgress) * 0.5)
          end
        end
        if r32_40.desiredPosition <= r32_40.currentPosition then
          r32_40.currentPosition = r32_40.desiredPosition
          r32_40.animationProgress = r32_40.animationProgress + r0_40 / 500
          local r35_40 = r32_40.animationProgress
          local r36_40 = r32_40.currentPosition
          if r36_40 >= 9.023499 then
            r36_40 = 1
          else
            r36_40 = 0.35
          end
          if r36_40 <= r35_40 then
            r35_40 = oreTypes[r32_40.oreType]
            if r35_40 then
              r35_40.bufferContent = r35_40.bufferContent + r32_40.oreAmount
              checkOreBuffer(r32_40.oreType)
            else
              r36_40 = r17_40 + r23_40 * r34_40
              local r37_40 = r18_40 + r24_40 * r34_40
              local r38_40 = r19_40 + r25_40 * r34_40 + r27_40 - 1
              local r39_40 = playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", r36_40, r37_40, r38_40)
              if isElement(r39_40) then
                setElementInterior(r39_40, 0)
                setElementDimension(r39_40, currentMine)
              end
              spawnSmokeEx(r36_40, r37_40, r38_40)
            end
            table.remove(r96_0, r31_40)
            if isElement(r32_40.objectElement) then
              destroyElement(r32_40.objectElement)
            end
            r32_40.objectElement = nil
          end
        elseif r16_40 or -0.3372985 < r34_40 then
          r32_40.currentPosition = r32_40.currentPosition + r0_40 / 200 * 0.2
        end
        r16_40 = r33_40
      end
    end
    if mineMachineData.sortingRocks ~= r15_40 then
      mineMachineData.sortingRocks = r15_40
      refreshMineMachineSound()
    end
  end
  if mineMachineData.forceMachine ~= r7_40 then
    mineMachineData.forceMachine = r7_40
    if mineMachineData.forceMachine and not mineMachineData.machineRunning then
      nextSurge = mineTick
    end
  end
  if mineMachineData.machineRunning or r7_40 then
    if mineMachineData.machineRunProgress < 1 then
      local r9_40 = mineMachineData
      local r10_40 = mineMachineData.machineRunProgress
      if r7_40 then
        r11_40 = 1000
      else
        r11_40 = 10000
      end
      r11_40 = r0_40 / r11_40
      r9_40.machineRunProgress = r10_40 + r11_40
      if mineMachineData.machineRunProgress > 1 then
        mineMachineData.machineRunProgress = 1
      end
    end
    if r8_40 and mineMachineData.machineRunProgress < 2 then
      r11_40 = r0_40 / 1000
      mineMachineData.machineRunProgress = mineMachineData.machineRunProgress + r11_40
      if mineMachineData.machineRunProgress > 2 then
        mineMachineData.machineRunProgress = 2
      end
    elseif mineMachineData.machineRunProgress > 1 then
      r11_40 = r0_40 / 1500
      mineMachineData.machineRunProgress = mineMachineData.machineRunProgress - r11_40
      if mineMachineData.machineRunProgress < 1 then
        mineMachineData.machineRunProgress = 1
      end
    end
    refreshMineMachineSound()
  elseif mineMachineData.machineRunProgress > 0 then
    r11_40 = r0_40 / 5000
    mineMachineData.machineRunProgress = mineMachineData.machineRunProgress - r11_40
    if mineMachineData.machineRunProgress < 0 then
      mineMachineData.machineRunProgress = 0
    end
    refreshMineMachineSound()
  end
  for r12_40 = #r97_0, 1, -1 do
    local r13_40, r14_40, r15_40, r16_40, r17_40, r18_40, r19_40 = unpack(r97_0[r12_40])
    --iprint(r13_40, r14_40, r15_40, r16_40, r17_40, r18_40, r19_40)
    r15_40 = r15_40 - r0_40
    if r15_40 <= 0 then
      r15_40 = 300 + math.random() * 200
      spawnSmokeExSm(r16_40, r17_40, r18_40)
    end
    r97_0[r12_40][3] = r15_40
    if isElement(r13_40) then
      local r20_40 = r14_40 - mineTick
      if r20_40 <= 0 then
        destroyElement(r13_40)
        if isElement(r19_40) then
          setPedAnimation(r19_40, "CARRY", "crry_prtial", 0, true, false, false, true)
        end
        table.remove(r97_0, r12_40)
      elseif r20_40 < 500 then
        setSoundVolume(r13_40, r20_40 / 500)
      end
    else
      table.remove(r97_0, r12_40)
    end
  end
  for r12_40, r13_40 in pairs(oreTypes) do
    if r13_40.meltingPoint then
      if mineFoundryData.furnaceRunning == r12_40 then
        r13_40.furnaceTemperature = math.min(1000, r13_40.furnaceTemperature + r0_40 / r13_40.furnaceSpeed)
        if r13_40.furnaceRunProgress < 1 then
          r13_40.furnaceRunProgress = r13_40.furnaceRunProgress + r0_40 / 2500
          if r13_40.furnaceRunProgress > 1 then
            r13_40.furnaceRunProgress = 1
          end
          if isElement(r13_40.furnaceSound) then
            setSoundSpeed(r13_40.furnaceSound, 0.75 + r13_40.furnaceRunProgress * 0.25)
            setSoundVolume(r13_40.furnaceSound, r13_40.furnaceRunProgress)
          end
        end
      else
        r13_40.furnaceTemperature = math.max(0, r13_40.furnaceTemperature - r0_40 / r13_40.furnaceSpeed * 10)
        if r13_40.furnaceRunProgress > 0 then
          r13_40.furnaceRunProgress = r13_40.furnaceRunProgress - r0_40 / 5000
          if r13_40.furnaceRunProgress < 0 then
            r13_40.furnaceRunProgress = 0
          end
          if isElement(r13_40.furnaceSound) then
            setSoundSpeed(r13_40.furnaceSound, 0.75 + r13_40.furnaceRunProgress * 0.25)
            setSoundVolume(r13_40.furnaceSound, r13_40.furnaceRunProgress)
          end
        end
      end
      local r14_40 = 0.045
      local r15_40 = r13_40.foundryDisplayPosition[1] + 0.9511 * r14_40 * 2
      local r16_40 = r13_40.foundryDisplayPosition[2] + 0.309 * r14_40 * 2
      local r17_40 = r13_40.foundryDisplayPosition[3]
      for r21_40 = 1, 5, 1 do
        local r22_40 = 11
        if mineFoundryData.furnaceRunning == r12_40 then
          local r23_40 = calculateFurnaceTemperature(r13_40.furnaceTemperature, r13_40.meltingPoint, mineTick)
          if r23_40 > 50 then
            r22_40 = math.floor(r23_40 / math.pow(10, (4 - r21_40))) % 10
          elseif mineTick % 2000 >= 1000 then
            r22_40 = false
          end
        end
        if r21_40 >= 5 then
          r22_40 = 10
        end
        if r22_40 then
          dxDrawMaterialSectionLine3D(r15_40, r16_40, r17_40 + r14_40, r15_40, r16_40, r17_40 - r14_40, r22_40 * 32, 0, 32, 64, staticTextures.lcdCharset, r14_40, tocolor(220, 10, 10), r15_40 - 0.309, r16_40 + 0.9511, r17_40)
        end
        r15_40 = r15_40 - r14_40 * 0.9511
        r16_40 = r16_40 - r14_40 * 0.309
      end
    end
  end
  if mineFoundryData.meltingOre then
    mineFoundryData.meltProgress = math.min(1, mineFoundryData.meltProgress + r0_40 / meltingTime)
    local r9_40 = mineFoundryData.meltProgress * meltingTime / 10000
    local r10_40 = math.min(1, r9_40 / 0.3)
    r11_40 = 1
    local r12_40 = math.min(1, math.max(0, (r9_40 - 0.3) / 0.7))
    local r13_40 = math.min(1, r12_40 * 4)
    local r14_40 = oreTypes[mineFoundryData.meltingOre].meltPosition
    if isElement(mineFoundryData.meltObject) then
      if r9_40 > 0.9 then
        local r15_40 = math.min(1, (r9_40 - 0.9) / 0.1)
        r11_40 = 1 - r15_40 * 0.25
        r10_40 = 1 - r15_40
        if r15_40 >= 1 then
          r11_40 = 0
        end
        setElementPosition(mineFoundryData.meltObject, r14_40[1], r14_40[2], r14_40[3] - 0.223179 * r15_40)
      else
        setElementPosition(mineFoundryData.meltObject, r14_40[1], r14_40[2], r14_40[3])
      end
      setObjectScale(mineFoundryData.meltObject, r11_40, r11_40, r10_40)
    end
    if isElement(mineFoundryData.ingotObject) then
      setObjectScale(mineFoundryData.ingotObject, r13_40, r13_40, r12_40)
    end
  end
  if not isLoading() then
    if selfPosZ >= minePosZ then
      local r9_40 = selfPosZ
      local r10_40 = minePosZ
      r11_40 = selfMineX
      if r11_40 <= 0 then
        r11_40 = 4
      else
        r11_40 = 3
      end
      if r10_40 + r11_40 < r9_40 then
        -- ::label_2847-- ::
        for r12_40 = 0, 30, 1 do
          local r13_40, r14_40 = checkValidPlayerSpot(selfMineX - r12_40, selfMineX + r12_40, selfMineY - r12_40, selfMineY + r12_40)
          if r13_40 and r14_40 then
            --setElementPosition(localPlayer, minePosX + r13_40 * 6, minePosY + r14_40 * 6, minePosZ + 1)
            break
          end
        end
      end
    else
      -- goto label_2847	-- block#415 is visited secondly
    end
  end
  if r19_0 == "railSwitch" and not railSwitchFading[r20_0] then
    r11_40 = 0
    railSwitchFading[r20_0] = r11_40
  end
  for r12_40 in pairs(railSwitchFading) do
    local r13_40 = r19_0
    if r13_40 == "railSwitch" then
      r13_40 = r20_0
      if r12_40 == r13_40 then
        railSwitchFading[r12_40] = railSwitchFading[r12_40] + r0_40 / 250
        r13_40 = railSwitchFading[r12_40]
        if r13_40 > 1 then
          r13_40 = railSwitchFading
          r13_40[r12_40] = 1
        end
      end
    else
      railSwitchFading[r12_40] = railSwitchFading[r12_40] - r0_40 / 250
      r13_40 = railSwitchFading[r12_40]
      if r13_40 < 0 then
        r13_40 = railSwitchFading
        r13_40[r12_40] = nil
      end
    end
  end
  if railEditing then
    if getDistanceBetweenPoints2D(selfPosX, selfPosY, minePosX + railEditing.baseX * 6, minePosY + railEditing.baseY * 6) >= 15 then
      railEditing = false
    else
      for _FORV_12_ = 1, #railEditing.checkList do
        if (railsAt[railEditing.checkList[_FORV_12_].spotX] and railsAt[railEditing.checkList[_FORV_12_].spotX][railEditing.checkList[_FORV_12_].spotY]) ~= railEditing.checkList[_FORV_12_].trackId then
          if (railSwitchesAt[railEditing.checkList[_FORV_12_].spotX] and railSwitchesAt[railEditing.checkList[_FORV_12_].spotX][railEditing.checkList[_FORV_12_].spotY]) ~= railEditing.checkList[_FORV_12_].switchId then
            setRailEditMode(railEditing.checkList[_FORV_12_].spotX, railEditing.checkList[_FORV_12_].spotY)
            break
          end
        end
      end
      if railEditing and 0 < #railEditing.sidesList then
        for _FORV_12_ = 1, #railEditing.sidesList do
          if (junctionObjects[railEditing.sidesList[_FORV_12_].spotX] and junctionObjects[railEditing.sidesList[_FORV_12_].spotX][railEditing.sidesList[_FORV_12_].spotY]) ~= railEditing.sidesList[_FORV_12_].junctionId then
            setRailEditMode(railEditing.sidesList[_FORV_12_].spotX, railEditing.sidesList[_FORV_12_].spotY)
            break
          end
        end
      end
      if railEditing then
        if #railEditing.sidesList > 0 then
          for r12_40 = 1, #railEditing.sidesList, 1 do
            local r13_40 = railEditing.sidesList[r12_40]
            for r17_40 = 1, #r13_40.drawList, 1 do
              local r18_40, r19_40, r20_40, r21_40, r22_40 = unpack(r13_40.drawList[r17_40])
              r18_40 = r18_40 or 0
              dxDrawMaterialLine3D(r19_40 + r22_40, r20_40 - r21_40, minePosZ + 0.1, r19_40 - r22_40, r20_40 + r21_40, minePosZ + 0.1, staticTextures["railDraw" .. r18_40], 6, blueToColor, r19_40, r20_40, minePosZ + 1)
            end
          end
        else
          railEditing = nil
        end
      end
    end
  end
end
function calculateFurnaceTemperature(r0_41, r1_41, r2_41)
  -- line: [2900, 2902] id: 41
  return getEasingValue(r0_41 / 1000, "InOutQuad") * r1_41 + 7.5 * math.sin(r2_41 % 30000 / 30000 * math.pi * 2)
end
function computeParticleVector()
  -- line: [2904, 2922] id: 42
  local r0_42, r1_42, r2_42 = getWorldFromScreenPosition(screenWidth / 2, 0, 128)
  local r3_42, r4_42, r5_42 = getWorldFromScreenPosition(screenWidth / 2, screenHeight / 2, 128)
  r0_42 = r3_42 - r0_42
  r1_42 = r4_42 - r1_42
  r2_42 = r5_42 - r2_42
  local r7_42 = math.sqrt((r0_42 * r0_42 + r1_42 * r1_42 + r2_42 * r2_42)) * 2
  if r7_42 ~= 0 then
    r0_42 = r0_42 / r7_42
    r1_42 = r1_42 / r7_42
    r2_42 = r2_42 / r7_42
  end
  return r0_42, r1_42, r2_42
end
function processFixOrePlayers()
  -- line: [2924, 2954] id: 43
  for r3_43, r4_43 in pairs(r94_0) do
    local r5_43 = fixOres[r3_43]
    if r5_43 then
      local r6_43 = getElementBoneMatrix(r4_43, 25)
      if r6_43 then
        local r7_43 = getElementBoneMatrix(r4_43, 35)
        local r8_43 = getElementBoneMatrix(r4_43, 23)
        r6_43[4][1] = (r6_43[4][1] + r7_43[4][1]) * 0.5 + r6_43[2][1] * 0.2
        r6_43[4][2] = (r6_43[4][2] + r7_43[4][2]) * 0.5 + r6_43[2][2] * 0.2
        r6_43[4][3] = (r6_43[4][3] + r7_43[4][3]) * 0.5 + r6_43[2][3] * 0.2
        for r12_43 = 1, 3, 1 do
          r8_43[2][r12_43] = -r8_43[2][r12_43]
          r8_43[3][r12_43] = -r8_43[3][r12_43]
        end
        if isElement(r5_43[6]) then
          setElementMatrix(r5_43[6], {
            r8_43[1],
            r8_43[2],
            r8_43[3],
            r6_43[4]
          })
        end
        setFixOrePosition(r3_43, r6_43[4][1], r6_43[4][2])
      elseif isElement(r5_43[6]) then
        setElementPosition(r5_43[6], 0, 0, -100)
      end
    end
  end
end
function processFallingOres(r0_44)
  -- line: [2956, 3055] id: 44
  local r17_44 = nil	-- notice: implicit variable refs by block#[12]
  for r4_44 = #r93_0, 1, -1 do
    local r5_44 = r93_0[r4_44]
    local r6_44 = fixOres[r5_44]
    if r6_44 then
      local r7_44 = r6_44[7]
      local r8_44 = (mineTick - r6_44[4]) / 1000
      if 15 < r8_44 or not r7_44 then
        setFixOrePosition(r5_44, minePosX + r6_44[1], minePosY + r6_44[2], minePosZ)
        table.remove(r93_0, r4_44)
        r6_44[7] = nil
      elseif r6_44[5] < r6_44[3] then
        r6_44[5] = 9.87 * r8_44 * r8_44 * 0.5
        local r9_44 = minePosX + r6_44[1]
        local r10_44 = minePosY + r6_44[2]
        local r11_44 = minePosZ + math.max(0, r6_44[3] - r6_44[5])
        setFixOrePosition(r5_44, r9_44, r10_44, r11_44)
        if r6_44[3] <= r6_44[5] then
          spawnSmokeEx(r9_44, r10_44, r11_44)
          r6_44[5] = r6_44[3]
          r6_44[7] = nil
        end
        local r12_44, r13_44, r14_44, r15_44, r16_44 = processLineOfSight(r9_44, r10_44, r11_44, r9_44, r10_44, r11_44 - 0.3, false, false, false, true, false)
        if r12_44 then
          if r16_44 then
            r17_44 = getElementModel(r16_44)
          else
            r17_44 = 0
          end
          if not tunnelModels[r17_44] then
            local r18_44 = r0_44 * 9.87 * math.max(1, r8_44)
            r6_44[1] = r6_44[1] - shaftRotations[r7_44][3] * r18_44
            r6_44[2] = r6_44[2] - shaftRotations[r7_44][4] * r18_44
          end
        end
      end
    end
  end
  for r4_44 in pairs(r55_0) do
    local r5_44 = shaftRotations[r4_44][3]
    local r6_44 = shaftRotations[r4_44][4]
    for r10_44 = #r55_0[r4_44], 1, -1 do
      local r11_44 = r55_0[r4_44][r10_44]
      local r12_44 = (mineTick - r11_44[4]) / 1000
      if r12_44 > 15 then
        if r11_44[6] then
          if isElement(r11_44[6]) then
            destroyElement(r11_44[6])
          end
          r11_44[6] = nil
        end
        table.remove(r55_0[r4_44], r10_44)
      elseif r11_44[5] < r11_44[3] then
        r11_44[5] = 9.87 * r12_44 * r12_44 * 0.5
        local r13_44 = minePosX + r11_44[1]
        local r14_44 = minePosY + r11_44[2]
        local r15_44 = minePosZ + math.max(0, r11_44[3] - r11_44[5])
        local r16_44, r17_44, r18_44, r19_44, r20_44 = processLineOfSight(r13_44, r14_44, r15_44, r13_44, r14_44, r15_44 - 0.3, false, false, false, true, false)
        local r21_44 = nil	-- notice: implicit variable refs by block#[28]
        if r16_44 then
          if r20_44 then
            r21_44 = getElementModel(r20_44)
          else
            r21_44 = 0
          end
          if not tunnelModels[r21_44] then
            local r22_44 = r0_44 * 9.87 * math.max(1, r12_44)
            r11_44[1] = r11_44[1] - r5_44 * r22_44
            r11_44[2] = r11_44[2] - r6_44 * r22_44
          end
        end
        r21_44 = r11_44[5]
        if r11_44[3] <= r21_44 then
          spawnSmokeEx(r13_44, r14_44, r15_44)
          r21_44 = r11_44[3]
          r11_44[5] = r21_44
        end
        setElementPosition(r11_44[6], r13_44, r14_44, r15_44)
      end
    end
    if #r55_0[r4_44] <= 0 then
      r55_0[r4_44] = nil
    end
  end
end
function processParticles(r0_45)
  -- line: [3057, 3143] id: 45
  if 0 < #r86_0 or 0 < #r87_0 then
    local r1_45, r2_45, r3_45 = computeParticleVector()
    for r7_45 = #r86_0, 1, -1 do
      local r8_45 = r86_0[r7_45]
      if r8_45 then
        local r9_45 = mineTick - r8_45[7]
        local r10_45 = math.min(1, r9_45 / 50)
        if r8_45[8] < r9_45 then
          r10_45 = 1 - (r9_45 - r8_45[8]) / 600
          if r10_45 <= 0 then
            table.remove(r86_0, r7_45)
            r10_45 = 0
          end
        end
        r8_45[1] = r8_45[1] + r8_45[4] * r0_45
        r8_45[2] = r8_45[2] + r8_45[5] * r0_45
        r8_45[3] = r8_45[3] + r8_45[6] * r0_45
        r8_45[10] = r8_45[10] + r8_45[11] * r0_45
        local r11_45 = r1_45 * r8_45[10]
        local r12_45 = r2_45 * r8_45[10]
        local r13_45 = r3_45 * r8_45[10]
        dxDrawMaterialLine3D(r8_45[1] - r11_45, r8_45[2] - r12_45, r8_45[3] - r13_45, r8_45[1] + r11_45, r8_45[2] + r12_45, r8_45[3] + r13_45, staticTextures.smokeParticle, r8_45[10], tocolor(40, 35, 22, r8_45[9] * r10_45))
      end
    end
    for r7_45 = #r87_0, 1, -1 do
      local r8_45 = r87_0[r7_45]
      if r8_45 then
        local r9_45 = math.min(1, (mineTick - r8_45[7]) / 50)
        local r10_45 = mineTick - r8_45[7]
        if r8_45[8] < r10_45 then
          r9_45 = 1 - (r10_45 - r8_45[8]) / 600
          if r9_45 <= 0 then
            table.remove(r87_0, r7_45)
            r9_45 = 0
          end
        end
        r8_45[1] = r8_45[1] + r8_45[4] * r0_45
        r8_45[2] = r8_45[2] + r8_45[5] * r0_45
        r8_45[3] = r8_45[3] + r8_45[6] * r0_45
        r8_45[10] = r8_45[10] + r8_45[11] * r0_45
        local r11_45 = r1_45 * r8_45[10]
        local r12_45 = r2_45 * r8_45[10]
        local r13_45 = r3_45 * r8_45[10]
        dxDrawMaterialSectionLine3D(r8_45[1] - r11_45, r8_45[2] - r12_45, r8_45[3] - r13_45, r8_45[1] + r11_45, r8_45[2] + r12_45, r8_45[3] + r13_45, 16 * math.random(0, 7), 0, 16, 16, staticTextures.sparkParticle, r8_45[10], tocolor(255, 255, 255, r8_45[9] * r9_45))
      end
    end
  end
end
function processDynamiteEffect(r0_46, r1_46)
  -- line: [3145, 3181] id: 46
  local r2_46 = r0_46[4] / detonationTime
  if r2_46 > 0.085 then
    r2_46 = 1 - math.min(1, (r2_46 - 0.085) / 0.915)
    local r3_46 = r0_46[5] + r0_46[3] * 0.5 * r2_46
    local r4_46 = r0_46[6] - r0_46[2] * 0.5 * r2_46
    local r5_46 = r0_46[7]
    dxDrawLine3D(r3_46, r4_46, r5_46, r0_46[5], r0_46[6], r0_46[7], tocolor(0, 0, 0), 1)
    addOrangeLight(r3_46, r4_46, r5_46, 0.5 + math.random() * 1.5, 1.5 + math.random() * 2.5)
    spawnSparkParticle(r3_46, r4_46, r5_46, (math.random() - 0.5) * 0.15, (math.random() - 0.5) * 0.15, 0.125 + math.random() * 0.25, 100 + math.random() * 300, 200 + math.random() * 55, 0.025 + math.random() * 0.025, 0.001 + math.random() * 0.001)
  else
    dxDrawLine3D(r0_46[5] + r0_46[3] * 0.5, r0_46[6] - r0_46[2] * 0.5, r0_46[7], r0_46[5], r0_46[6], r0_46[7], tocolor(0, 0, 0), 1)
  end
  r0_46[4] = r0_46[4] + r1_46
end
function renderMine()
  -- line: [3183, 3556] id: 47
  cursorX, cursorY = getCursorPosition()
  if cursorX then
    cursorX = cursorX * screenWidth
    cursorY = cursorY * screenHeight
  end
  r15_0 = nil
  r16_0 = nil
  r17_0 = nil
  r18_0 = nil
  r2_0 = mineTick % 1000 / 500
  if r2_0 > 1 then
    r2_0 = 2 - r2_0
  end
  r2_0 = getEasingValue(r2_0, "InQuad")
  renderTrain()
  local r0_47 = threeJunctionsAt[selfMineX] and threeJunctionsAt[selfMineX][selfMineY]
  local currentExtendableShaft = r41_0[selfMineX] and r41_0[selfMineX][selfMineY]
  if carryingFixOre then
    for r5_47 = 1, #cartTurtleObjects, 1 do
      if isElement(cartTurtleObjects[r5_47]) and not cartTurtleEmptying[r5_47] and not cartTurtleRotation[r5_47] and (cartMaxSlots[r5_47] or 0) < #oreCartOffsets then
        local r6_47, r7_47, r8_47 = getElementPosition(cartTurtleObjects[r5_47])
        if r6_47 then
          renderActionButton("downIcon", r6_47, r7_47, r8_47 + 0.3, 2, 2.5, false, "putOreInCart", r5_47)
        end
      end
    end
  elseif freeFromAction then
    if isRailCarStationary() then
      for r5_47 = 1, #cartTurtleObjects, 1 do
        if not cartTurtleEmptying[r5_47] and not cartTurtleRotation[r5_47] then
          local r6_47 = cartLastSlot[r5_47]
          if r6_47 then
            local r7_47 = fixOres[r6_47]
            if r7_47 then
              local r8_47, r9_47, r10_47 = getElementPosition(cartTurtleObjects[r5_47])
              if conveyorStartX - 0.25 <= r8_47 and r8_47 <= conveyorStartX + 0.25 then
                renderActionButton("emptyIcon", r8_47, r9_47 - 0.55, r10_47 + 0.2, 0.5, 0.75, true, "emptyCart", r5_47)
              else
                renderActionButton("downIcon", r8_47, r9_47, r10_47 + 0.3, 2, 2.5, false, "pickUpFixOre", r6_47, r7_47[10], true)
              end
            end
          end
        end
      end
    end
    if canExtendShaftAt(selfMineX, selfMineY) and (not openShaftsAt[selfMineX] or not openShaftsAt[selfMineX][selfMineY]) and not isStreamedLight(selfMineX, selfMineY) then
      renderActionButton("bulbIcon", minePosX + selfMineX * 6, minePosY + selfMineY * 6, minePosZ + 2.5, 2, 2.5, false, "buildLight")
    end
    if r67_0 and not openShaftBombs[r67_0] and r68_0 <= 3.775 and not currentActiveBlockId then
      local r2_47, r3_47, r4_47 = getShaftBlockPosition(r67_0, math.ceil(wallBlockCount / 2))
      if r4_47 then
        renderActionButton("digIcon", r2_47, r3_47, r4_47, 2, 2.5, false, "openShaftBomb", r67_0)
      end
    end
    for r5_47, r6_47 in pairs(openShaftBombs) do
      local r7_47 = getDistanceBetweenPoints2D(r6_47[5], r6_47[6], selfPosX, selfPosY)
      if r7_47 < 3 then
        local r8_47, r9_47 = getScreenFromWorldPosition(r6_47[5], r6_47[6], r6_47[7], 16)
        if r8_47 then
          local r10_47 = 255 * (1 - math.max(0, (r7_47 - 2.75) / 0.25))
          if r10_47 > 0 then
            renderBombTimer(r6_47[4], r8_47, r9_47, r10_47)
          end
        end
      end
    end
    if r0_47 then
      local r2_47 = threeJunctionBombs[selfMineX] and threeJunctionBombs[selfMineX][selfMineY]
      local r3_47 = pcos(r0_47)
      local r4_47 = psin(r0_47)
      processExtendableShaft(false, r3_47, r4_47)
      if r2_47 then
        local r5_47 = getDistanceBetweenPoints2D(r2_47[5], r2_47[6], selfPosX, selfPosY)
        if r5_47 < 3 then
          local r6_47, r7_47 = getScreenFromWorldPosition(r2_47[5], r2_47[6], r2_47[7], 16)
          if r6_47 then
            local r8_47 = 255 * (1 - math.max(0, (r5_47 - 2.75) / 0.25))
            if r8_47 > 0 then
              renderBombTimer(r2_47[4], r6_47, r7_47, r8_47)
            end
          end
        end
      else
        local r5_47 = true
        if not currentExtendableShaftLeft then
          r5_47 = false
          for r9_47 = selfMineX - 1, 1, -1 do
            if checkValidSpot(r9_47, selfMineY) then
              r5_47 = true
              break
            end
          end
        end
        if r5_47 then
          renderActionButton("digIcon", minePosX + selfMineX * 6 - r4_47 * 1.45, minePosY + selfMineY * 6 + r3_47 * 1.45, minePosZ + 1.5, 2, 2.5, false, "extendThreeJunction")
        end
      end
    elseif currentExtendableShaft then
      local shaftId = currentExtendableShaft[1]
      local tunnelId = currentExtendableShaft[2]
      local shaftCos = shaftRotations[shaftId][3]
      local shaftSin = shaftRotations[shaftId][4]
      iprint(shaftId, shaftCos, shaftSin, selfMineX, selfMineY)
      processExtendableShaft(shaftId, shaftCos, shaftSin)
      if (not openShaftDepths[shaftId] or tunnelId <= openShaftLengths[shaftId] / 6) and shaftSet[shaftId] then
        local r6_47 = shaftBombs[shaftId] and shaftBombs[shaftId][tunnelId] and shaftBombs[shaftId][tunnelId][1]
        local r7_47 = shaftBombs[shaftId] and shaftBombs[shaftId][tunnelId] and shaftBombs[shaftId][tunnelId][0]
        if r6_47 then
          local r8_47 = getDistanceBetweenPoints2D(r6_47[5], r6_47[6], selfPosX, selfPosY)
          if r8_47 < 3 then
            local r9_47, r10_47 = getScreenFromWorldPosition(r6_47[5], r6_47[6], r6_47[7], 16)
            if r9_47 then
              local r11_47 = 255 * (1 - math.max(0, (r8_47 - 2.75) / 0.25))
              if r11_47 > 0 then
                renderBombTimer(r6_47[4], r9_47, r10_47, r11_47)
              end
            end
          end
        else
          local validSpot = not r7_47
          iprint(validSpot, currentExtendableShaftLeft, currentExtendableShaftRight, r7_47)
          -- left side
          if not currentExtendableShaftLeft then
            validSpot = false
            for spotX = selfMineX - 1, 1, -1 do
              if checkValidSpot(spotX, selfMineY) then
                validSpot = true
                break
              end
            end
          end
          if validSpot then
            renderActionButton("digIcon", minePosX + selfMineX * 6 - shaftSin * 1.45 + shaftCos * 0.5, minePosY + selfMineY * 6 + shaftCos * 1.45 + shaftSin * 0.5, minePosZ + 1.5, 2, 2.5, false, "newShaft", shaftId, tunnelId, true)
          end
        end
        if r7_47 then
          local r8_47 = getDistanceBetweenPoints2D(r7_47[5], r7_47[6], selfPosX, selfPosY)
          if r8_47 < 3 then
            local r9_47, r10_47 = getScreenFromWorldPosition(r7_47[5], r7_47[6], r7_47[7], 16)
            if r9_47 then
              local r11_47 = 255 * (1 - math.max(0, (r8_47 - 2.75) / 0.25))
              if r11_47 > 0 then
                renderBombTimer(r7_47[4], r9_47, r10_47, r11_47)
              end
            end
          end
        else
          local validSpot = not r6_47
          iprint(validSpot, currentExtendableShaftRight)
          -- right side
          if not currentExtendableShaftRight then
            validSpot = false
            for r12_47 = selfMineX - 1, 1, -1 do
              if checkValidSpot(r12_47, selfMineY) then
                validSpot = true
                break
              end
            end
          end
          if validSpot then
            renderActionButton("digIcon", minePosX + selfMineX * 6 + shaftSin * 1.45 - shaftCos * 0.5, minePosY + selfMineY * 6 - shaftCos * 1.45 - shaftSin * 0.5, minePosZ + 1.5, 2, 2.5, false, "newShaft", shaftId, tunnelId, false)
          end
        end
      end
    else
      processExtendableShaft()
    end
    iterateGrid(r90_0, selfMineX - 1, selfMineY - 1, selfMineX + 1, selfMineY + 1, function(r0_48, r1_48, r2_48)
      -- line: [3409, 3418] id: 48
      for r6_48 = 1, #r0_48, 1 do
        local r7_48 = r0_48[r6_48]
        local r8_48 = fixOres[r7_48]
        if not r8_48[7] and not fixOreCarts[r7_48] and not r94_0[r7_48] then
          renderActionButton("carryIcon", minePosX + r8_48[1], minePosY + r8_48[2], minePosZ + 0.3, 1, 1.25, true, "pickUpFixOre", r7_48, r8_48[10], false)
        end
      end
    end)
  end
  local r2_47 = railsAt[selfMineX] and railsAt[selfMineX][selfMineY]
  local r3_47 = railEndsAt[selfMineX] and railEndsAt[selfMineX][selfMineY]
  local r4_47 = railSwitchesAt[selfMineX] and railSwitchesAt[selfMineX][selfMineY]
  local r5_47 = junctionObjects[selfMineX] and junctionObjects[selfMineX][selfMineY]
  if selfMineX <= 0 then
    renderMineHQ()
  end
  for r9_47 = selfMineX - 2, selfMineX + 2, 1 do
    if railSwitchesAt[r9_47] then
      for r13_47 = selfMineY - 2, selfMineY + 2, 1 do
        renderRailSwitch(railSwitchesAt[r9_47][r13_47])
      end
    end
  end
  if r3_47 then
    renderRailEditButton()
  elseif r4_47 and #railSwitches[r4_47].trackIds <= 3 then
    renderRailEditButton()
  elseif r2_47 and r5_47 then
    for r9_47 = 0, 270, 90 do
      local r10_47 = prad(r9_47)
      iprint(checkValidSpotEx(selfMineX + pcos(r10_47), selfMineY + psin(r10_47)))
      if checkValidSpotEx(selfMineX + pcos(r10_47), selfMineY + psin(r10_47)) then
        renderRailEditButton()
      end
    end
  end
  if railEditing then
    for r9_47 = 1, #railEditing.sidesList, 1 do
      local r10_47 = railEditing.sidesList[r9_47]
      renderActionButton("constructionIcon", minePosX + r10_47.spotX * 6, minePosY + r10_47.spotY * 6, minePosZ + 0.25, 6.5, 7, false, "doConstructRail", r10_47.spotX, r10_47.spotY, r10_47.totalCost)
    end
  end
  if tabletHovering then
    r15_0 = nil
    r16_0 = nil
    r17_0 = nil
    r18_0 = nil
  end
  tabletHovering = false
  if r19_0 ~= r15_0 or r20_0 ~= r16_0 or r21_0 ~= r17_0 or r22_0 ~= r18_0 then
    r19_0 = r15_0
    r20_0 = r16_0
    r21_0 = r17_0
    r22_0 = r18_0
    if r19_0 then
      exports.sGui:setCursorType("link")
      iprint(r19_0)
      if r19_0 == "newShaft" or r19_0 == "extendThreeJunction" then
        exports.sGui:showTooltip("Új járat nyitása")
      elseif r19_0 == "openShaftBomb" then
        exports.sGui:showTooltip("Robbanótöltet felhelyezése")
      elseif r19_0 == "openRailEditMode" then
        exports.sGui:showTooltip("Sínépítés")
      elseif r19_0 == "closeRailEditMode" then
        exports.sGui:showTooltip("Sínépítés befejezése")
      elseif r19_0 == "doConstructRail" then
        local yellowHex = exports.sGui:getColorCodeHex("sightyellow")
        exports.sGui:showTooltip("Sín megépítése\n" .. yellowHex .. r22_0 * railIronCost .. "db sínszál\n" .. yellowHex .. r22_0 * railWoodCost .. "db talpfa")
      elseif r19_0 == "driveDieselLoco" then
        exports.sGui:showTooltip("Mozdony vezetése")
      elseif r19_0 == "dieselLocoPassenger" then
        exports.sGui:showTooltip("Felszállás a mozdonyra")
      elseif r19_0 == "pickUpFixOre" then
        if oreTypes[r21_0] then
          local r6_47 = exports.sGui
          local r8_47 = oreTypes[r21_0].displayName
          local r9_47 = r22_0
          if r9_47 then
            r9_47 = " kivétele a kocsiból" or " felvétele"
          else
            r9_47 = " felvétele"
          end
          r6_47:showTooltip(r8_47 .. r9_47)
        end
      elseif r19_0 == "putOreInCart" then
        local r6_47 = fixOres[carryingFixOre][10]
        if oreTypes[r6_47] then
          exports.sGui:showTooltip(oreTypes[r6_47].displayName .. " betétele a kocsiba")
        end
      elseif r19_0 == "toggleSortingMachine" then
        local r6_47 = exports.sGui
        local r8_47 = "Válogatógép "
        local r9_47 = mineMachineData.machineRunning
        if r9_47 then
          r9_47 = "ki" or "be"
        else
          r9_47 = "be"
        end
        r6_47:showTooltip(r8_47 .. r9_47 .. "kapcsolása")
      elseif r19_0 == "emptyCart" then
        exports.sGui:showTooltip("Kocsi kiürítése")
      elseif r19_0 == "sackOre" then
        exports.sGui:showTooltip(oreTypes[r20_0].displayName .. " zsákolása")
      elseif r19_0 == "pickUpOreBox" then
        exports.sGui:showTooltip("Láda felvétele (" .. oreTypes[r20_0].displayName .. ")")
      elseif r19_0 == "putDownOreBox" then
        exports.sGui:showTooltip("Láda letétele")
      elseif r19_0 == "toggleFoundry" then
        if mineFoundryData.furnaceRunning == r20_0 then
          exports.sGui:showTooltip(oreTypes[r20_0].ingotName .. "kohó kikapcsolása")
        else
          exports.sGui:showTooltip(oreTypes[r20_0].ingotName .. "kohó bekapcsolása")
        end
      elseif r19_0 == "fillFoundry" then
        exports.sGui:showTooltip(oreTypes[r20_0].ingotName .. "kohó feltöltése")
      elseif r19_0 == "makeIngot" then
        exports.sGui:showTooltip(oreTypes[r20_0].ingotName .. "rúd kiöntése")
      elseif r19_0 == "takeIngot" then
        exports.sGui:showTooltip(oreTypes[r20_0].ingotName .. "rúd kivétele")
      elseif r19_0 == "getJerryCan" then
        exports.sGui:showTooltip("Kanna felvétele")
      elseif r19_0 == "putJerryCan" then
        exports.sGui:showTooltip("Kanna visszahelyezése")
      elseif r19_0 == "fillJerryCan" then
        exports.sGui:showTooltip("Kanna megtankolása")
      elseif r19_0 == "fillLocoTank" then
        exports.sGui:showTooltip("Mozdony megtankolása")
      elseif r19_0 == "useComputer" then
        exports.sGui:showTooltip("Számítógép használata")
      elseif r19_0 == "buildLight" then
        exports.sGui:showTooltip("Lámpa építése")
      elseif r19_0 == "useFaucet" then
        exports.sGui:showTooltip("Mosakodás")
      else
        exports.sGui:showTooltip()
      end
    else
      exports.sGui:setCursorType("normal")
      exports.sGui:showTooltip()
    end
  end
end


function drawFoundryInfo(r0_49, r1_49, r2_49, r3_49)
  -- line: [3558, 3573] id: 49
  local r4_49 = r2_49.ingotName .. "kohó (" .. r2_49.meltingPoint .. " °C)\n" .. math.floor(r2_49.displayedFoundryContent) .. " rúdra elegendő nyersanyag"
  dxDrawText(r4_49, r0_49 + 1, r1_49 + 1, r0_49 + 1, r1_49 + 1, tocolor(0, 0, 0, r3_49 * 0.8), guiFontScales.oreFont, guiFonts.oreFont, "center", "center")
  dxDrawText(r4_49, r0_49, r1_49, r0_49, r1_49, tocolor(255, 255, 255, r3_49), guiFontScales.oreFont, guiFonts.oreFont, "center", "center")
  local r5_49 = 150
  local r6_49 = 8
  local r7_49 = r0_49 - r5_49 / 2
  local r8_49 = r1_49 + guiFontHeights.oreFont + 4
  dxDrawRectangle(r7_49, r8_49, r5_49, r6_49, tocolor(grey1[1], grey1[2], grey1[3], r3_49))
  dxDrawRectangle(r7_49 + 1, r8_49 + 1, r5_49 - 2, r6_49 - 2, tocolor(green[1], green[2], green[3], r3_49 / 2))
  dxDrawRectangle(r7_49 + 1, r8_49 + 1, (r5_49 - 2) * (r2_49.displayedFoundryContent % 1), r6_49 - 2, tocolor(green[1], green[2], green[3], r3_49))
  
end
function renderMineHQ()
  -- line: [3575, 3757] id: 50
  local r0_50 = r88_0[localPlayer]
  if r0_50 then
    local r1_50 = oreTypes[r0_50]
    if r1_50 then
      renderActionButton("downIcon", r1_50.boxPosition[1], r1_50.boxPosition[2], r1_50.boxPosition[3], 1.5, 2, true, "putDownOreBox")
      if mineFoundryData.meltingOre ~= r0_50 then
        local r2_50, r3_50, r4_50 = renderActionButton("intoIcon", r1_50.foundryInputPosition[1], r1_50.foundryInputPosition[2], r1_50.foundryInputPosition[3], 1, 1.5, true, "fillFoundry", r0_50)
        if r2_50 then
          drawFoundryInfo(r2_50, r3_50 - 48, r1_50, r4_50)
        end
      end
    end
  elseif freeFromAction then
    renderActionButton("toggleIcon", minePosX - 14.7006, minePosY + 6.7456, minePosZ + 1.466699999999, 0.75, 1, true, "toggleSortingMachine")
    for r4_50, r5_50 in pairs(oreTypes) do
      if not r5_50.instantItem then
        if not r5_50.carriedBy then
          local r6_50 = getDistanceBetweenPoints2D(r5_50.boxPosition[1], r5_50.boxPosition[2], selfPosX, selfPosY)
          if r6_50 < 2 then
            local r7_50, r8_50 = getScreenFromWorldPosition(r5_50.boxPosition[1], r5_50.boxPosition[2], r5_50.boxPosition[3] + 0.25, 16)
            if r7_50 then
              local r9_50 = (1 - math.max(0, (r6_50 - 1.5) / 0.5)) * 255
              if r9_50 > 0 then
                local r10_50 = 100
                local r11_50 = 8
                if r5_50.displayedBoxContent == r5_50.boxContent and not mineMachineData.machineRunning and not mineMachineData.forceMachine and r5_50.meltingPoint then
                  dxDrawRectangle(r7_50 - 16, r8_50 + 4, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], r9_50))
                  if 255 <= r9_50 and cursorX and r7_50 - 16 <= cursorX and r8_50 + 4 <= cursorY and cursorX <= r7_50 + 16 and cursorY <= r8_50 + 4 + 32 then
                    r15_0 = "pickUpOreBox"
                    r16_0 = r4_50
                    dxDrawImage(r7_50 - 12, r8_50 + 8, 24, 24, ":sGui/" .. downIcon .. faTicks[downIcon], 0, 0, 0, greenToColor)
                  else
                    dxDrawImage(r7_50 - 12, r8_50 + 8, 24, 24, ":sGui/" .. downIcon .. faTicks[downIcon], 0, 0, 0, tocolor(255, 255, 255, r9_50))
                  end
                  if r9_50 >= 255 then
                    setActionKeyBind(r6_50, "pickUpOreBox", r4_50)
                  end
                  r8_50 = r8_50 - 4
                elseif not r5_50.meltingPoint and r80_0 and r5_50.displayedBoxContent >= sackOreProportion then
                  dxDrawRectangle(r7_50 - 16, r8_50 + 4, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], r9_50))
                  if 255 <= r9_50 and cursorX and r7_50 - 16 <= cursorX and r8_50 + 4 <= cursorY and cursorX <= r7_50 + 16 and cursorY <= r8_50 + 4 + 32 then
                    r15_0 = "sackOre"
                    r16_0 = r4_50
                    dxDrawImage(r7_50 - 12, r8_50 + 8, 24, 24, ":sGui/" .. sackIcon .. faTicks[sackIcon], 0, 0, 0, greenToColor)
                  else
                    dxDrawImage(r7_50 - 12, r8_50 + 8, 24, 24, ":sGui/" .. sackIcon .. faTicks[sackIcon], 0, 0, 0, tocolor(255, 255, 255, r9_50))
                  end
                  if r9_50 >= 255 then
                    setActionKeyBind(r6_50, "sackOre", r4_50)
                  end
                  r8_50 = r8_50 - 4
                end
                local r12_50 = r7_50 - r10_50 / 2
                local r13_50 = r8_50 - r11_50 / 2
                dxDrawText(r5_50.displayName, r7_50 + 1, 0, r7_50 + 1, r8_50 - r11_50 + 1, tocolor(0, 0, 0, r9_50 * 0.8), guiFontScales.oreFont, guiFonts.oreFont, "center", "bottom")
                dxDrawText(r5_50.displayName, r7_50 + 0, 0, r7_50 + 0, r8_50 - r11_50 + 0, tocolor(255, 255, 255, r9_50), guiFontScales.oreFont, guiFonts.oreFont, "center", "bottom")
                dxDrawRectangle(r12_50, r13_50, r10_50, r11_50, tocolor(grey1[1], grey1[2], grey1[3], r9_50))
                dxDrawRectangle(r12_50 + 1, r13_50 + 1, r10_50 - 2, r11_50 - 2, tocolor(green[1], green[2], green[3], r9_50 / 2))
                dxDrawRectangle(r12_50 + 1, r13_50 + 1, (r10_50 - 2) * r5_50.displayedBoxContent, r11_50 - 2, tocolor(green[1], green[2], green[3], r9_50))
              end
            end
          end
        end
        if r5_50.meltingPoint then
          local r6_50, r7_50, r8_50 = renderActionButton("toggleIcon", r5_50.foundryButtonPosition[1], r5_50.foundryButtonPosition[2], r5_50.foundryButtonPosition[3], 2, 2.5, true, "toggleFoundry", r4_50)
          if r6_50 then
            drawFoundryInfo(r6_50, r7_50 - 48, r5_50, r8_50)
          end
          if mineFoundryData.meltingOre == r4_50 and mineFoundryData.meltProgress >= 1 then
            renderActionButton("downIcon", r5_50.meltPosition[1], r5_50.meltPosition[2], r5_50.meltPosition[3], 1.25, 1.5, true, "takeIngot", r4_50)
          elseif not mineFoundryData.meltingOre and 1000 <= r5_50.furnaceTemperature and 1 <= r5_50.displayedFoundryContent then
            renderActionButton("fillDripIcon", r5_50.meltPosition[1], r5_50.meltPosition[2], r5_50.meltPosition[3], 1.25, 1.5, true, "makeIngot", r4_50)
          end
        end
      end
    end
  end
  if (freeFromAction or currentMineInventory.jerryCarry == localPlayer) and not currentMineInventory.tankOutside then
    local r1_50 = getDistanceBetweenPoints2D(minePosX - 32.7956, minePosY + 2.3363, selfPosX, selfPosY)
    if r1_50 < 2.5 then
      local r2_50, r3_50 = getScreenFromWorldPosition(minePosX - 32.7956, minePosY + 2.3363, minePosZ + 1.15, 16)
      if r2_50 then
        local r4_50 = (1 - math.max(0, (r1_50 - 2) / 0.5)) * 255
        local r5_50 = string.format("%s/%s L", math.floor(currentMineInventory.displayedFuelTankLevel * 10) / 10, fuelTankCapacity)
        if currentMineInventory.jerryCarry == localPlayer then
          r3_50 = r3_50 - 4
        end
        dxDrawText(r5_50, r2_50 + 1, 0, r2_50 + 1, r3_50 + 1, tocolor(0, 0, 0, r4_50 * 0.8), guiFontScales.oreFont, guiFonts.oreFont, "center", "bottom")
        dxDrawText(r5_50, r2_50, 0, r2_50, r3_50, tocolor(255, 255, 255, r4_50), guiFontScales.oreFont, guiFonts.oreFont, "center", "bottom")
        if currentMineInventory.jerryCarry == localPlayer then
          dxDrawRectangle(r2_50 - 16, r3_50 + 4, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], r4_50))
          if 255 <= r4_50 and cursorX and r2_50 - 16 <= cursorX and r3_50 + 4 <= cursorY and cursorX <= r2_50 + 16 and cursorY <= r3_50 + 36 then
            dxDrawImage(r2_50 - 12, r3_50 + 8, 24, 24, ":sGui/" .. guiIcons["fuelIcon"] .. faTicks[guiIcons["fuelIcon"]], 0, 0, 0, greenToColor)
            r15_0 = "fillJerryCan"
          else
            dxDrawImage(r2_50 - 12, r3_50 + 8, 24, 24, ":sGui/" .. guiIcons["fuelIcon"] .. faTicks[guiIcons["fuelIcon"]], 0, 0, 0, tocolor(255, 255, 255, r4_50))
          end 
        end
      end
    end
  end
  for r4_50, r5_50 in pairs(oreTypes) do
    for r9_50 = #r5_50.itemOutput, 1, -1 do
      local r10_50 = nil
      local r11_50 = nil
      local r12_50 = nil
      if r5_50.ingotPosition then
        r10_50, r11_50, r12_50 = unpack(r5_50.ingotPosition)
      else
        r10_50, r11_50, r12_50 = unpack(r5_50.boxPosition)
      end
      local r13_50 = mineTick - r5_50.itemOutput[r9_50]
      local r14_50 = 0
      r12_50 = r12_50 + r13_50 / 3000
      if not r5_50.ingotPosition then
        r12_50 = r12_50 + 0.25
      end
      if r13_50 > 2000 then
        table.remove(r5_50.itemOutput, r9_50)
        r14_50 = 0
      elseif r13_50 > 1000 then
        r14_50 = 1 - (r13_50 - 1000) / 1000
      else
        r14_50 = math.min(1, r13_50 / 250)
      end
      local r15_50 = getDistanceBetweenPoints2D(r10_50, r11_50, selfPosX, selfPosY)
      if r15_50 < 5 then
        r10_50, r11_50, r12_50 = getScreenFromWorldPosition(r10_50, r11_50, r12_50, 16)
        if r10_50 then
          dxDrawImage(r10_50 - 20, r11_50 - 20, 40, 40, r5_50.itemPicture, 0, 0, 0, tocolor(255, 255, 255, (1 - math.max(0, (r15_50 - 4.5) / 0.5)) * 255 * r14_50))
        end
      end
    end
  end
  renderActionButton("computerIcon", minePosX - 32.6914, minePosY - 3.7004, minePosZ + 0.9183, 1.5, 2, false, "useComputer")
  renderActionButton("washIcon", minePosX - 27.3901, minePosY + 2.8282, minePosZ + 1.1891, 1, 1.5, false, "useFaucet")
  -- warn: not visited block [18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]
  -- block#18:
  -- dxDrawRectangle(r7_50 - 16, r8_50 + 4, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], r9_50))
  -- if 255 <= r9_50
  -- block#19:
  -- if cursorX
  -- block#20:
  -- if r7_50 - 16 <= cursorX
  -- block#21:
  -- if r8_50 + 4 <= cursorY
  -- block#22:
  -- if cursorX <= r7_50 + 16
  -- block#23:
  -- if cursorY <= r8_50 + 4 + 32
  -- block#24:
  -- -- <empty>
  -- _u2 = "sackOre"
  -- _u3 = r4_50
  -- dxDrawImage(r7_50 - 12, r8_50 + 8, 24, 24, ":sGui/" .. guiIcons.sackIcon .. guiIconTicks.sackIcon .. ".fa", 0, 0, 0, greenToColor)
  -- -- goto label_215
  -- block#25:
  -- dxDrawImage(r7_50 - 12, r8_50 + 8, 24, 24, ":sGui/" .. guiIcons.sackIcon .. guiIconTicks.sackIcon .. ".fa", 0, 0, 0, tocolor(255, 255, 255, r9_50))
  -- block#26:
  -- if 255 <= r9_50
  -- block#27:
  -- setActionKeyBind(r6_50, "sackOre", r4_50)
  -- block#28:
  -- r8_50 = r8_50 - 4
  -- -- goto label_319
end
function renderBombTimer(r0_51, r1_51, r2_51, r3_51)
  -- line: [3759, 3769] id: 51
  local r4_51 = (timerFontWidth + 8) / 2
  local r5_51 = (guiFontHeights.timerFont + 8) / 2
  local r6_51 = math.floor(math.max(0, (detonationTime - r0_51)) / 1000)
  local r7_51 = math.floor(r6_51 / 60)
  local r8_51 = r6_51 - r7_51 * 60
  dxDrawRectangle(r1_51 - r4_51, r2_51 - r5_51, r4_51 * 2, r5_51 * 2, tocolor(grey1[1], grey1[2], grey1[3], r3_51))
  dxDrawText(string.format("%02d:%02d", r7_51, r8_51), r1_51 - r4_51, r2_51 - r5_51, r1_51 + r4_51, r2_51 + r5_51, tocolor(red[1], red[2], red[3], r3_51), guiFontScales.timerFont, guiFonts.timerFont, "center", "center")
end
function renderRailSwitch(r0_52)
  -- line: [3771, 3884] id: 52
  local r1_52 = railSwitches[r0_52]
  if not r1_52 then
    return 
  end
  local r2_52 = #r1_52.trackIds
  if r2_52 <= 2 then
    return 
  end
  if not isElementOnScreen(r1_52.objectElement) then
    return 
  end
  local r4_52 = getDistanceBetweenPoints2D(selfPosX, selfPosY, r1_52.worldX, r1_52.worldY)
  if r4_52 >= 15 then
    return 
  end
  renderRailSwitchHighlight(r0_52, r2_0 * (1 - math.max(0, (r4_52 - 14) / 1)) * 255)
  if r4_52 >= 7 then
    return 
  end
  local r5_52 = 255 * (1 - math.max(0, (r4_52 - 6) / 1))
  if r5_52 <= 0 then
    return 
  end
  local r6_52, r7_52 = getScreenFromWorldPosition(r1_52.worldX, r1_52.worldY, minePosZ + 1, 128)
  if not r6_52 or not r7_52 then
    return 
  end
  local r8_52 = railSwitchFading[r0_52]
  local r9_52 = railSwitchStates[r0_52] or 1
  local r13_52 = math.floor(((math.deg(math.atan2(r1_52.worldY - selfCamY, r1_52.worldX - selfCamX)) - r1_52.angleDeg + 180) % 360 / 90 + 0.5)) * 90
  local r14_52 = 64
  local r15_52 = r7_52 - r14_52 / 2
  local r16_52 = r14_52 - 8
  local r17_52 = r7_52 - r16_52 / 2
  local r22_52 = nil	-- notice: implicit variable refs by block#[61]
  local r24_52 = nil	-- notice: implicit variable refs by block#[64]
  if r8_52 then
    local r18_52 = false
    local r19_52 = r14_52 * (1 + r8_52 * 2)
    local r20_52 = r6_52 - r19_52 / 2
    if 255 <= r5_52 and cursorX and r20_52 <= cursorX and r15_52 <= cursorY then
      r22_52 = r20_52 + r19_52
      if cursorX <= r22_52 then
        r22_52 = r15_52 + r14_52
        if cursorY <= r22_52 then
          r15_0 = "railSwitch"
          r16_0 = r0_52
          r17_0 = nil
          r18_0 = nil
          r18_52 = true
        end
      end
    end
    dxDrawRectangle(r20_52, r15_52, r19_52, r14_52, tocolor(grey1[1], grey1[2], grey1[3], r5_52))
    for r24_52 = 1, 3, 1 do
      local r25_52 = r20_52 + (r24_52 - 1) * r14_52 * r8_52
      local r26_52 = r25_52 + (r14_52 - r16_52) / 2
      local r27_52 = nil	-- notice: implicit variable refs by block#[38, 39, 46]
      if r24_52 == r9_52 then
        r27_52 = r5_52
      else
        r27_52 = r5_52 * r8_52
      end
      local r28_52 = nil	-- notice: implicit variable refs by block#[39, 46]
      if r24_52 == r9_52 then
        r28_52 = yellow
      else
        r28_52 = lightgrey
      end
      if r18_52 and r25_52 <= cursorX and cursorX <= r25_52 + r14_52 then
        dxDrawRectangle(r25_52, r15_52, r14_52, r14_52, tocolor(grey2[1], grey2[2], grey2[3], r5_52 * r8_52))
        if r8_52 >= 1 then
          r17_0 = r24_52
        else
          r17_0 = false
        end
      end
      dxDrawImage(r26_52, r17_52, r16_52, r16_52, staticTextures["railSwitch_" .. r2_52], r13_52, 0, 0, tocolor(midgrey[1], midgrey[2], midgrey[3], r27_52))
      if r24_52 == 1 then
        dxDrawImage(r26_52, r17_52, r16_52, r16_52, staticTextures["railSwitch_" .. r2_52 .. "_1"], r13_52, 0, 0, tocolor(r28_52[1], r28_52[2], r28_52[3], r27_52))
      else
        local r29_52 = dxDrawImage
        local r30_52 = r26_52
        local r31_52 = nil	-- notice: implicit variable refs by block#[43]
        if r24_52 > 2 then
          r31_52 = r16_52
        else
          r31_52 = 0
        end
        r31_52 = r17_52 + r31_52
        local r32_52 = r16_52
        local r33_52 = nil	-- notice: implicit variable refs by block#[46]
        if r24_52 > 2 then
          r33_52 = -1
        else
          r33_52 = 1
        end
        r29_52(r30_52, r31_52, r32_52, r16_52 * r33_52, staticTextures["railSwitch_" .. r2_52 .. "_2"], r13_52, 0, 0, tocolor(r28_52[1], r28_52[2], r28_52[3], r27_52))
      end
    end
  else
    local r18_52 = r6_52 - r14_52 / 2
    local r19_52 = r6_52 - r16_52 / 2
    dxDrawRectangle(r18_52, r15_52, r14_52, r14_52, tocolor(grey1[1], grey1[2], grey1[3], r5_52))
    if 255 <= r5_52 and cursorX and r18_52 <= cursorX and r15_52 <= cursorY and cursorX <= r18_52 + r14_52 and cursorY <= r15_52 + r14_52 then
      r15_0 = "railSwitch"
      r16_0 = r0_52
      r17_0 = nil
      r18_0 = nil
    end
    dxDrawImage(r19_52, r17_52, r16_52, r16_52, staticTextures["railSwitch_" .. r2_52], r13_52, 0, 0, tocolor(midgrey[1], midgrey[2], midgrey[3], r5_52))
    if r9_52 == 1 then
      dxDrawImage(r19_52, r17_52, r16_52, r16_52, staticTextures["railSwitch_" .. r2_52 .. "_1"], r13_52, 0, 0, tocolor(yellow[1], yellow[2], yellow[3], r5_52))
    else
      local r20_52 = dxDrawImage
      local r21_52 = r19_52
      if r9_52 > 2 then
        r22_52 = r16_52
      else
       r22_52 = 0
      end
      r22_52 = r17_52 + r22_52
      local r23_52 = r16_52
      if r9_52 > 2 then
        r24_52 = -1
      else
        r24_52 = 1
      end
      r20_52(r21_52, r22_52, r23_52, r16_52 * r24_52, staticTextures["railSwitch_" .. r2_52 .. "_2"], r13_52, 0, 0, tocolor(yellow[1], yellow[2], yellow[3], r5_52))
    end
  end
end
function renderRailSwitchHighlight(r0_53, r1_53)
  -- line: [3886, 3956] id: 53
  if r1_53 > 0 then
    local r2_53 = railSwitches[r0_53]
    if r2_53 then
      local r3_53 = railSwitchRoutes[r0_53]
      if r3_53 then
        local r4_53 = tocolor(yellow[1], yellow[2], yellow[3], r1_53)
        for r8_53 = 1, 4, 1 do
          local r9_53 = r3_53[r8_53]
          if r9_53 then
            for r13_53 = -1, 1, 2 do
              local r14_53 = r13_53 * 0.34708
              local r15_53 = nil
              local r16_53 = nil
              for r20_53 = 0, 0.525, 0.025 do
                local r21_53 = r2_53.worldX + r9_53.offsetX
                local r22_53 = r2_53.worldY + r9_53.offsetY
                local r23_53 = nil
                if r9_53.curveAngle then
                  r20_53 = r20_53 * 3
                  if r20_53 >= 2 then
                    r23_53 = r9_53.curveAngle + r9_53.curveDirSign * math.pi / 2
                  elseif r20_53 >= 1 then
                    r23_53 = r9_53.curveAngle + r9_53.curveDirSign * math.pi / 2 * (r20_53 - 1)
                  else
                    r23_53 = r9_53.curveAngle
                  end
                  local r24_53 = math.cos(r23_53)
                  local r25_53 = math.sin(r23_53)
                  r21_53 = r21_53 + r24_53 * (2 - r14_53)
                  r22_53 = r22_53 + r25_53 * (2 - r14_53)
                  if r20_53 >= 2 then
                    r21_53 = r21_53 - r25_53 * (r20_53 - 2) * r9_53.curveDirSign
                    r22_53 = r22_53 + r24_53 * (r20_53 - 2) * r9_53.curveDirSign
                  elseif r20_53 <= 1 then
                    r21_53 = r21_53 + r25_53 * (1 - r20_53) * r9_53.curveDirSign
                    r22_53 = r22_53 - r24_53 * (1 - r20_53) * r9_53.curveDirSign
                  end
                else
                  r21_53 = r21_53 - r9_53.offsetX * 2 * r20_53 + r9_53.offsetY / 3 * r14_53
                  r22_53 = r22_53 - r9_53.offsetY * 2 * r20_53 - r9_53.offsetX / 3 * r14_53
                end
                if r20_53 > 0 then
                  dxDrawMaterialLine3D(r15_53, r16_53, minePosZ + 0.15, r21_53, r22_53, minePosZ + 0.15, staticTextures.railHighlight, 0.2, r4_53, r21_53, r22_53, minePosZ + 1)
                end
                r15_53 = r21_53
                r16_53 = r22_53
              end
            end
          end
        end
      end
    end
  end
end
function renderRailEditButton()
  -- line: [3958, 3968] id: 54
  local r0_54 = minePosX + selfMineX * 6
  local r1_54 = minePosY + selfMineY * 6
  local r2_54 = minePosZ + 0.25
  if railEditing and railEditing.baseX == selfMineX and railEditing.baseY == selfMineY then
    renderActionButton("cancelIcon", r0_54, r1_54, r2_54, 2, 2.5, false, "closeRailEditMode")
  else
    renderActionButton("constructionIcon", r0_54, r1_54, r2_54, 2, 2.5, false, "openRailEditMode")
  end
end
function renderActionButton(r0_55, r1_55, r2_55, r3_55, r4_55, r5_55, r6_55, ...)
  -- line: [3970, 4005] id: 55
  local r8_55 = getDistanceBetweenPoints2D(r1_55, r2_55, selfPosX, selfPosY)
  if r8_55 < r5_55 then
    local r9_55, r10_55 = getScreenFromWorldPosition(r1_55, r2_55, r3_55, 16)
    if r9_55 then
      local r11_55 = 255 * (1 - math.max(0, (r8_55 - r4_55) / (r5_55 - r4_55)))
      if r11_55 > 0 then
        local r12_55 = nil
        if 255 <= r11_55 and cursorX and r9_55 - 16 <= cursorX and r10_55 - 16 <= cursorY and cursorX <= r9_55 + 16 and cursorY <= r10_55 + 16 then
          r12_55 = greenToColor
        else
          r12_55 = tocolor(255, 255, 255, r11_55)
        end
        dxDrawRectangle(r9_55 - 16, r10_55 - 16, 32, 32, tocolor(grey1[1], grey1[2], grey1[3], r11_55))
        dxDrawImage(r9_55 - 12, r10_55 - 12, 24, 24, ":sGui/" .. guiIcons[r0_55] .. faTicks[guiIcons[r0_55]], 0, 0, 0, r12_55)
        if r11_55 >= 255 then
          if r12_55 == greenToColor then
            r15_0, r16_0, r17_0, r18_0 = ...
          end
          if r6_55 then
            setActionKeyBind(r8_55, ...)
          end
        end
        return r9_55, r10_55, r11_55
      end
    end
  end
end
function restoreMine()
  -- line: [4007, 4011] id: 56
  if r62_0 then
    processCurrentActiveWorld()
  end
end
function clickMine(r0_57, r1_57)
  -- line: [4013, 4017] id: 57
  if r1_57 == "up" then
    doInteraction(r19_0, r20_0, r21_0, r22_0)
  end
end
local r102_0 = {}
function triggerRemoteEvent(r0_58, ...)
  -- line: [4020, 4032] id: 58
  local r2_58 = getTickCount()
  if r102_0[r0_58] and r2_58 - r102_0[r0_58] < 1000 then
    exports.sGui:showInfobox("e", "Várj egy kicsit!")
    return 
  end
  triggerServerEvent(r0_58, ...)
  r102_0[r0_58] = r2_58
end
function doInteraction(r0_59, r1_59, r2_59, r3_59)
  -- line: [4034, 4194] id: 59
  if r0_59 == "newShaft" then
    if checkMinePermission(permissionFlags.USE_BOMB) then
      triggerRemoteEvent("createNewMineShaft", localPlayer, r1_59, r2_59, r3_59)
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "extendThreeJunction" then
    if checkMinePermission(permissionFlags.USE_BOMB) then
      triggerRemoteEvent("extendMineThreeJunction", localPlayer, selfMineX, selfMineY)
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "openShaftBomb" then
    if checkMinePermission(permissionFlags.USE_BOMB) then
      triggerRemoteEvent("handleMineDetonate", localPlayer, r1_59)
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "openRailEditMode" then
    if checkMinePermission(permissionFlags.CONSTRUCT_RAIL) then
      setRailEditMode(selfMineX, selfMineY)
      if not railEditing then
        exports.sGui:showInfobox("e", "Nem lehet új sínt létrehozni ezen a helyen!")
      end
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "closeRailEditMode" then
    railEditing = nil
  elseif r0_59 == "doConstructRail" then
    if checkMinePermission(permissionFlags.CONSTRUCT_RAIL) then
      if r3_59 * railIronCost <= currentMineInventory.railIrons and r3_59 * railWoodCost <= currentMineInventory.railWoods then
        triggerRemoteEvent("createNewMineRailTrack", localPlayer, r1_59, r2_59)
      else
        exports.sGui:showInfobox("e", "Nincs elég anyag az építéshez!")
      end
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "railSwitch" and railSwitches[r1_59] and r2_59 and railSwitchStates[r1_59] ~= r2_59 then
    if checkMinePermission(permissionFlags.USE_SWITCHES) then
      if not railSwitchBusy[r1_59] then
        triggerRemoteEvent("setMineRailSwitch", localPlayer, r1_59, r2_59)
      else
        exports.sGui:showInfobox("e", "Addig nem válthatod át, amíg rajta áll a vonat!")
      end
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "driveDieselLoco" then
    if checkMinePermission(permissionFlags.USE_RAILCAR) then
      driveLocomotive()
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "dieselLocoPassenger" then
    triggerRemoteEvent("standMineLocoPassenger", localPlayer, r1_59)
  elseif r0_59 == "pickUpFixOre" then
    if checkMinePermission(permissionFlags.PICK_ORES) then
      triggerRemoteEvent("pickUpMineFixOre", localPlayer, r1_59)
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "putOreInCart" then
    triggerRemoteEvent("putOreInMineCart", localPlayer, r1_59)
  elseif r0_59 == "toggleSortingMachine" then
    if checkMinePermission(permissionFlags.USE_SORTER_MACHINE) then
      if not mineMachineData.forceMachine then
        triggerRemoteEvent("toggleMineSortingMachine", localPlayer)
      else
        exports.sGui:showInfobox("e", "A válogatógép jelenleg nem kapcsolható ki!")
      end
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "emptyCart" then
    if checkMinePermission(permissionFlags.USE_SORTER_MACHINE) then
      if mineMachineData.machineRunning then
        triggerRemoteEvent("emptyMineCart", localPlayer, r1_59)
      else
        exports.sGui:showInfobox("e", "Előbb kapcsold be a válogatógépet!")
      end
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "sackOre" then
    if checkMinePermission(permissionFlags.COLLECT_PRODUCT) then
      triggerRemoteEvent("sackMineOre", localPlayer, r1_59)
      exports.sBag:setBagMode(false)
      setBagWieldMode(false)
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "pickUpOreBox" then
    if checkMinePermission(permissionFlags.USE_FOUNDRY) then
      triggerRemoteEvent("pickUpMineOreBox", localPlayer, r1_59)
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "putDownOreBox" then
    triggerRemoteEvent("putDownMineOreBox", localPlayer)
  elseif r0_59 == "toggleFoundry" then
    if checkMinePermission(permissionFlags.USE_FOUNDRY) then
      if mineFoundryData.meltingOre then
        if mineFoundryData.meltProgress >= 0.9 then
          exports.sGui:showInfobox("e", "Előbb vedd ki a kihűlt fémet az öntőformából!")
        else
          exports.sGui:showInfobox("e", "Előbb várd meg a fém kiöntését!")
        end
      else
        triggerRemoteEvent("toggleMineFoundry", localPlayer, r1_59)
      end
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "fillFoundry" then
    local r4_59 = oreTypes[r1_59]
    if r4_59 then
      triggerRemoteEvent("fillMineFoundry", localPlayer, r4_59.boxContent)
    end
  elseif r0_59 == "makeIngot" then
    if checkMinePermission(permissionFlags.USE_FOUNDRY) then
      triggerRemoteEvent("makeMineIngot", localPlayer, r1_59)
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "takeIngot" then
    if checkMinePermission(permissionFlags.COLLECT_PRODUCT) then
      triggerRemoteEvent("takeMineIngot", localPlayer, r1_59)
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "getJerryCan" then
    triggerRemoteEvent("getMineJerrycan", localPlayer)
  elseif r0_59 == "putJerryCan" then
    triggerRemoteEvent("putMineJerrycan", localPlayer)
  elseif r0_59 == "fillJerryCan" then
    triggerRemoteEvent("fillMineJerrycan", localPlayer)
  elseif r0_59 == "fillLocoTank" then
    triggerRemoteEvent("fillMineLocoTank", localPlayer)
  elseif r0_59 == "useComputer" then
    createComputer()
  elseif r0_59 == "buildLight" then
    if checkMinePermission(permissionFlags.CONSTRUCT_LAMP) then
      if currentMineInventory.mineLamps > 0 then
        triggerRemoteEvent("buildMineLight", localPlayer, selfMineX, selfMineY)
      else
        exports.sGui:showInfobox("e", "Nincs elég lámpa készleten!")
      end
    else
      exports.sGui:showInfobox("e", "Ehhez nincs jogosultságod!")
    end
  elseif r0_59 == "useFaucet" then
    triggerRemoteEvent("useMineFaucet", localPlayer)
  end
end
function keyMine(r0_60, r1_60)
  -- line: [4196, 4237] id: 60
  if r1_60 and not isCursorShowing() and not isChatBoxInputActive() and not isConsoleActive() then
    if r0_60 == "f" then
      if carryingFixOre then
        local r2_60 = nil
        local r3_60 = 2
        for r7_60 = 1, #cartTurtleObjects, 1 do
          if not cartTurtleEmptying[r7_60] and not cartTurtleRotation[r7_60] and (cartMaxSlots[r7_60] or 0) < #oreCartOffsets then
            local r8_60, r9_60, r10_60 = getElementPosition(cartTurtleObjects[r7_60])
            local r11_60 = getDistanceBetweenPoints2D(r8_60, r9_60, selfPosX, selfPosY)
            if r11_60 <= r3_60 then
              r2_60 = r7_60
              r3_60 = r11_60
            end
          end
        end
        local r4_60 = fixOres[carryingFixOre][10]
        if r2_60 and not oreTypes[r4_60].instantItem then
          triggerRemoteEvent("putOreInMineCart", localPlayer, r2_60)
        else
          triggerRemoteEvent("putDownMineFixOre", localPlayer)
        end
      elseif r23_0 then
        doInteraction(unpack(r23_0))
      end
    elseif r0_60 == "e" then
      if carryingFixOre and oreTypes[fixOres[carryingFixOre][10]].instantItem then
        triggerRemoteEvent("giveInstantOre", localPlayer)
      end
    else
      doRailCarInteraction(r0_60)
    end
  end
end
function setActionKeyBind(r0_61, ...)
  -- line: [4239, 4243] id: 61
  if not r23_0 or r0_61 < r23_0.actionDistance then
    r23_0 = {
      actionDistance = r0_61,
      ...
    }
  end
end
function checkValidSpot(x, y)
	local spotValue = tunnelObjectRots[x]
	if spotValue then
	  spotValue = tunnelObjectRots[x][y] or (junctionObjects[x] and junctionObjects[x][y])
	end
	return spotValue
end
function checkValidSpotEx(_ARG_0_, _ARG_1_)
  if checkValidSpot(_ARG_0_, _ARG_1_) and (not openShaftsAt[_ARG_0_] or not openShaftsAt[_ARG_0_][_ARG_1_]) then
    return true
  end
  return false
end
function checkValidPlayerSpot(r0_64, r1_64, r2_64, r3_64)
  -- line: [4258, 4284] id: 64
  for r7_64 = r0_64, r1_64, 1 do
    if checkValidSpotEx(r7_64, r2_64) then
      return r7_64, r2_64
    end
  end
  for r7_64 = r0_64, r1_64, 1 do
    if checkValidSpotEx(r7_64, r3_64) then
      return r7_64, r3_64
    end
  end
  for r7_64 = r2_64 - 1, r3_64 - 1, 1 do
    if checkValidSpotEx(r0_64, r7_64) then
      return r0_64, r7_64
    end
  end
  for r7_64 = r2_64 - 1, r3_64 - 1, 1 do
    if checkValidSpotEx(r1_64, r7_64) then
      return r1_64, r7_64
    end
  end
  return false
end
function setRailEditMode(r0_65, r1_65)
  -- line: [4286, 4479] id: 65
  local r2_65 = {}
  railEditing = {
    baseX = r0_65,
    baseY = r1_65,
    sidesList = {},
    checkList = {},
  }
  for r6_65 = 0, 270, 90 do
    local r7_65 = prad(r6_65)
    local r8_65 = pcos(r7_65)
    local r9_65 = psin(r7_65)
    local r10_65 = r0_65 + r8_65
    local r11_65 = r1_65 + r9_65
    if canConstructRail(railsAt, railSwitchesAt, r10_65, r11_65) and (tunnelObjectRots[r10_65] and tunnelObjectRots[r10_65][r11_65] or junctionObjects[r10_65] and junctionObjects[r10_65][r11_65]) and (not openShaftsAt[(r10_65)] or not openShaftsAt[(r10_65)][(r11_65)]) then
      local r13_65 = junctionObjects[r10_65] and junctionObjects[r10_65][r11_65]
      if not r2_65[r10_65] then
        r2_65[r10_65] = {}
      end
      r2_65[r10_65][r11_65] = true
      for r17_65 = 0, 270, 90 do
        local r18_65 = prad(r17_65)
        local r19_65 = pcos(r18_65)
        local r20_65 = psin(r18_65)
        local r21_65 = r10_65 + r19_65
        local r22_65 = r11_65 + r20_65
        if not r2_65[r21_65] then
          r2_65[r21_65] = {}
        end
        r2_65[r21_65][r22_65] = true
      end
      local r14_65 = doConstructRail(nil, railsAt, railSwitchesAt, r10_65, r11_65, r13_65) or {}
      iprint(r14_65)
      local r15_65 = {}
      local r16_65 = {}
      for r20_65 = 1, #r14_65, 1 do
        local r21_65 = r14_65[r20_65]
        iprint(r21_65)
        if r21_65[1] == "extend" then
          local r23_65 = railTracks[r21_65[2]]
          if r23_65 then
            local r24_65 = r23_65.spotX
            local r25_65 = r23_65.spotY
            local r26_65 = r23_65.angleCos
            local r27_65 = r23_65.angleSin
            table.insert(r15_65, {
              1,
              r24_65,
              r25_65,
              r26_65,
              r27_65
            })
            r24_65 = r24_65 + r26_65
            r25_65 = r25_65 + r27_65
            local r28_65 = table.insert
            local r29_65 = r15_65
            local r30_65 = {}
            local r31_65 = r21_65[3]
            if r31_65 then
              r31_65 = 0
            else
              r31_65 = 1
            end
            local r32_65 = r24_65
            local r33_65 = r25_65
            local r34_65 = r26_65
            local r35_65 = r27_65
            -- setlist for #30 failed
            iprint(r31_65, r24_65, r25_65, r26_65, r27_65)
            table.insert(r15_65, {r31_65, r24_65, r25_65, r26_65, r27_65})
            if not r16_65[r24_65] then
              r16_65[r24_65] = {}
            end
            r16_65[r24_65][r25_65] = true
          end
        elseif r21_65[1] == "openup" then
          local r23_65 = railTracks[r21_65[2]]
          if r23_65 then
            table.insert(r15_65, {
              1,
              r23_65.spotX,
              r23_65.spotY,
              r23_65.angleCos,
              r23_65.angleSin
            })
          end
        elseif r21_65[1] == "single" then
          local r22_65 = r21_65[2]
          local r23_65 = r21_65[3]
          local r24_65 = prad(r21_65[4])
          local r25_65 = pcos(r24_65)
          local r26_65 = psin(r24_65)
          local r27_65 = table.insert
          local r28_65 = r15_65
          local r29_65 = {}
          local r30_65 = r21_65[5]
          if r30_65 then
            r30_65 = 0
          else
            r30_65 = 1
          end
          local r31_65 = r22_65
          local r32_65 = r23_65
          local r33_65 = r25_65
          local r34_65 = r26_65
          -- setlist for #29 failed
          -- ezeknél table insertet jóra
        table.insert(r15_65, {r30_65, r31_65, r32_65, r33_65, r34_65})
          if not r16_65[r22_65] then
            r16_65[r22_65] = {}
          end
          r16_65[r22_65][r23_65] = true
        elseif r21_65[1] == "linked" then
          local r22_65 = r21_65[2]
          local r23_65 = r21_65[3]
          local r24_65 = r21_65[4]
          local r25_65 = r21_65[5]
          local r26_65 = math.atan2(r25_65 - r23_65, r24_65 - r22_65)
          local r27_65 = pcos(r26_65)
          local r28_65 = psin(r26_65)
          local r29_65 = table.insert
          local r30_65 = r15_65
          local r31_65 = {}
          local r32_65 = r21_65[5]
          if r32_65 then
            r32_65 = 1
          else
            r32_65 = 0
          end
          local r33_65 = r24_65
          local r34_65 = r25_65
          local r35_65 = r27_65
          local r36_65 = r28_65
          -- setlist for #31 failed
            table.insert(r15_65, {r32_65, r33_65, r34_65, r35_65, r36_65})

          r29_65 = r22_65
          r30_65 = r24_65
          if r24_65 < r22_65 then
            r31_65 = -1
          else
            r31_65 = 1
          end
          for r32_65 = r29_65, r30_65, r31_65 do
            if not r16_65[r32_65] then
              r16_65[r32_65] = {}
            end
            r33_65 = r23_65
            r34_65 = r25_65
            if r25_65 < r23_65 then
              r35_65 = -1
            else
              r35_65 = 1
            end
            for r36_65 = r33_65, r34_65, r35_65 do
              r16_65[r32_65][r36_65] = true
            end
          end
        elseif r21_65[1] == "switch" then
          local r22_65, r23_65, r24_65 = processSwitch(r21_65[2], r21_65[3], r16_65)
          if r22_65 then
            table.insert(r15_65, {
              r22_65,
              r21_65[2],
              r21_65[3],
              r23_65,
              r24_65
            })
          end
        elseif r21_65[1] == "extend-switch" then
          local r23_65 = railSwitches[r21_65[2]]
          if r23_65 then
            local r24_65, r25_65, r26_65 = processSwitch(r23_65.spotX, r23_65.spotY, r16_65)
            if r24_65 then
              table.insert(r15_65, {
                r24_65,
                r23_65.spotX,
                r23_65.spotY,
                r25_65,
                r26_65
              })
            end
          end
        elseif r21_65[1] == "merge" then
          local r22_65 = r21_65[2]
          if not railTracks[r22_65] then
            r22_65 = r21_65[3]
          end
          local r23_65 = railTracks[r22_65]
          if r23_65 then
            local r24_65 = r21_65[4]
            local r25_65 = r21_65[5]
            local r26_65 = r23_65.angleCos
            local r27_65 = r23_65.angleSin
            table.insert(r15_65, {
              1,
              r24_65 - r26_65,
              r25_65 - r27_65,
              r26_65,
              r27_65
            })
            table.insert(r15_65, {
              1,
              r24_65,
              r25_65,
              r26_65,
              r27_65
            })
            table.insert(r15_65, {
              1,
              r24_65 + r26_65,
              r25_65 + r27_65,
              r26_65,
              r27_65
            })
          end
        end
      end
      for r20_65 = 1, #r15_65, 1 do
        r15_65[r20_65][2] = minePosX + r15_65[r20_65][2] * 6
        r15_65[r20_65][3] = minePosY + r15_65[r20_65][3] * 6
        r15_65[r20_65][4] = r15_65[r20_65][4] * 3
        r15_65[r20_65][5] = r15_65[r20_65][5] * 3
      end
      table.insert(railEditing.sidesList, {
        junctionId = r13_65,
        spotX = r10_65,
        spotY = r11_65,
        drawList = r15_65,
        totalCost = findRailConstructionCost(r14_65),
      })
    end
  end
  if #railEditing.sidesList > 0 then
    for r6_65 in pairs(r2_65) do
      for r10_65 in pairs(r2_65[r6_65]) do
        local r11_65 = table.insert
        local r12_65 = railEditing.checkList
        local r13_65 = {
          spotX = r6_65,
          spotY = r10_65,
          railId = railsAt[r6_65] and railsAt[r6_65][r10_65],
          switchId = railSwitchesAt[r6_65] and railSwitchesAt[r6_65][r10_65],
        }
        r11_65(r12_65, r13_65)
      end
    end
  else
    railEditing = nil
  end
end
function processSwitch(r0_66, r1_66, r2_66)
  -- line: [4481, 4534] id: 66
  local r3_66 = getNearTracks(railsAt, r0_66, r1_66, r2_66)
  if #r3_66 == 2 then
    local r4_66 = r3_66[1]
    local r5_66 = r3_66[2]
    if (patan2(r1_66 - r4_66.trackY, r0_66 - r4_66.trackX) - patan2(r1_66 - r5_66.trackY, r0_66 - r5_66.trackX) + PI) % TWO_PI - PI > 0 then
      local r9_66 = patan2(r5_66.trackY - r1_66, r5_66.trackX - r0_66)
      return 2, psin(r9_66), -pcos(r9_66)
    else
      local r9_66 = patan2(r4_66.trackY - r1_66, r4_66.trackX - r0_66)
      return 2, psin(r9_66), -pcos(r9_66)
    end
  else
    local r4_66 = {}
    for r8_66 = 1, #r3_66, 1 do
      local r9_66 = r3_66[r8_66]
      if r9_66 then
        table.insert(r4_66, {
          r9_66.trackId,
          patan2(r1_66 - r9_66.trackY, r0_66 - r9_66.trackX),
          r9_66.trackX,
          r9_66.trackY
        })
      end
    end
    table.sort(r4_66, function(r0_67, r1_67)
      -- line: [4519, 4521] id: 67
      return r1_67[2] < r0_67[2]
    end)
    while r4_66[1][2] % PI ~= r4_66[3][2] % PI do
      table.insert(r4_66, 1, table.remove(r4_66, #r4_66))
    end
    local r5_66 = patan2(r4_66[2][4] - r1_66, r4_66[2][3] - r0_66)
    return #r4_66, psin(r5_66), -pcos(r5_66)
  end
end
addMineEventHandler("executeMineRailConstruction", root, function(r0_68, r1_68, r2_68, r3_68, r4_68, r5_68)
  -- line: [4537, 4622] id: 68
  local r6_68 = {}
  if not r6_68[r2_68] then
    r6_68[r2_68] = {}
  end
  r6_68[r2_68][r3_68] = true
  for r10_68 = 1, #r1_68, 1 do
    local r11_68 = r1_68[r10_68]
    local r12_68 = nil
    local r13_68 = nil
    if r11_68[1] == "extend" then
      r12_68, r13_68 = extendRail(r11_68[2], r11_68[3])
    elseif r11_68[1] == "single" then
      r12_68, r13_68 = createRail(r11_68[6], {
        r11_68[2],
        r11_68[3],
        r11_68[4],
        r11_68[5]
      })
    elseif r11_68[1] == "linked" then
      r12_68, r13_68 = createRail(r11_68[7], {
        r11_68[2],
        r11_68[3],
        r11_68[4],
        r11_68[5],
        r11_68[6]
      })
    elseif r11_68[1] == "split" then
      r12_68, r13_68 = splitRail(r11_68[2], r11_68[3], r11_68[4])
    elseif r11_68[1] == "switch" then
      r12_68, r13_68 = createRailSwitch(r11_68[5], {
        r11_68[2],
        r11_68[3],
        unpack(r11_68[4])
      })
    elseif r11_68[1] == "extend-switch" then
      local r14_68 = r11_68[2]
      local r15_68 = railSwitches[r14_68]
      if r15_68 then
        r12_68, r13_68 = createRailSwitch(r14_68, {
          r15_68.spotX,
          r15_68.spotY,
          unpack(r11_68[3])
        })
      end
    elseif r11_68[1] == "merge" then
      mergeRails(r11_68[2], r11_68[3], r11_68[4], r11_68[5])
    elseif r11_68[1] == "openup" then
      r12_68, r13_68 = openUpRail(r11_68[2])
    end
    if r12_68 and r13_68 then
      if not r6_68[r12_68] then
        r6_68[r12_68] = {}
      end
      r6_68[r12_68][r13_68] = true
    end
  end
  if railEditing then
    if source == localPlayer or railEditing.baseX == r2_68 and railEditing.baseY == r3_68 then
      setRailEditMode(r2_68, r3_68)
    else
      local r7_68 = railEditing.baseX
      local r8_68 = railEditing.baseY
      for r12_68 = 1, #railEditing.checkList, 1 do
        local r13_68 = railEditing.checkList[r12_68]
        local r14_68 = r13_68.spotX
        local r15_68 = r13_68.spotY
        if r6_68[r14_68] and r6_68[r14_68][r15_68] then
          setRailEditMode(r7_68, r8_68)
          break
        end
      end
    end
  end
  local r7_68 = playSound3D("files/sounds/railconstruct.mp3", minePosX + r2_68 * 6, minePosY + r3_68 * 6, minePosZ + 0.25)
  if isElement(r7_68) then
    setElementInterior(r7_68, 0)
    setElementDimension(r7_68, currentMine)
    setSoundMaxDistance(r7_68, 50)
  end
  updateMineInventory("railIrons", r4_68)
  updateMineInventory("railWoods", r5_68)
  forceRefreshTrain = true
end)
addMineEventHandler("setMineRailSwitch", root, function(r0_69, r1_69, r2_69)
  -- line: [4626, 4647] id: 69
  local r3_69 = railSwitches[r1_69]
  if r2_69 then
    railSwitchStates[r1_69] = r2_69
  end
  if r3_69 then
    if isElement(railSwitchSound) then
      destroyElement(railSwitchSound)
    end
    railSwitchSound = playSound3D("files/sounds/railswitch.mp3", r3_69.worldX, r3_69.worldY, minePosZ)
    if isElement(railSwitchSound) then
      setElementInterior(railSwitchSound, 0)
      setElementDimension(railSwitchSound, currentMine)
    end
    processRailSwitchRoutes(r1_69)
  end
end)
addMineEventHandler("mineRailSyncing", root, function(r0_70, r1_70)
  -- line: [4651, 4653] id: 70
  processRailCarSync(r1_70, true)
end)
addMineEventHandler("mineRailHorn", root, function(r0_71)
  -- line: [4657, 4659] id: 71
  playLocoHorn()
end)
addMineEventHandler("syncMineLocoPassenger", root, function(r0_72, r1_72)
  -- line: [4663, 4665] id: 72
  processLocoPassenger(source, r1_72)
end)
addMineEventHandler("syncMineSortingMachineState", root, function(r0_73, r1_73)
  -- line: [4669, 4686] id: 73
  mineMachineData.machineRunning = r1_73
  if r1_73 then
    nextSurge = getTickCount()
  end
  local r2_73 = playSound3D("files/sounds/machinebutton.mp3", minePosX - 14.7006, minePosY + 6.7456, minePosZ + 1.4667)
  if isElement(r2_73) then
    setElementInterior(r2_73, 0)
    setElementDimension(r2_73, currentMine)
  end
  if r19_0 == "toggleSortingMachine" then
    local r3_73 = exports.sGui
    local r5_73 = "Válogatógép "
    local r6_73 = mineMachineData.machineRunning
    if r6_73 then
      r6_73 = "ki"
    else
      r6_73 = "be"
    end
    r3_73:showTooltip(r5_73 .. r6_73 .. "kapcsolása")
  end
end)
addMineEventHandler("updateMineInventory", root, function(r0_74, r1_74, r2_74)
  -- line: [4690, 4718] id: 74
  updateMineInventory(r1_74, r2_74)
  if r1_74 == "dieselLoco" or r1_74 == "subCartNum" then
    initMineTrain(currentMineInventory.dieselLoco, currentMineInventory.subCartNum or 0)
    if currentMineInventory.dieselLoco then
      exports.sControls:toggleControl({
        "fire",
        "crouch",
        "aim_weapon",
        "jump",
        "jog"
      }, true, "minecartPush")
    end
  elseif r1_74 == "tankOutside" and not currentMineInventory.fuelTankObject then
    currentMineInventory.fuelTankObject = createObject(modelIds.v4_mine_tank, minePosX - 32.7956, minePosY + 2.3363, minePosZ, 0, 0, -5)
    if isElement(currentMineInventory.fuelTankObject) then
      setElementInterior(currentMineInventory.fuelTankObject, 0)
      setElementDimension(currentMineInventory.fuelTankObject, currentMine)
    end
  end
  shouldRefreshUrmaMotoDevice = true
  -- warn: not visited block [10, 11]
  -- block#10:
  -- destroyElement(currentMineInventory.fuelTankObject)
  -- block#11:
  -- currentMineInventory.fuelTankObject = nil
  -- -- goto label_90
end)
function updateMineInventory(r0_75, r1_75)
  -- line: [4721, 4799] id: 75
  currentMineInventory[r0_75] = r1_75
  if r0_75 == "railIrons" then
    local r2_75 = math.min(#railIronOffsets, math.ceil(r1_75 / railIronStack))
    for r6_75 = r2_75 + 1, #r98_0, 1 do
      if isElement(r98_0[r6_75]) then
        destroyElement(r98_0[r6_75])
      end
      r98_0[r6_75] = nil
    end
    for r6_75 = 1, r2_75, 1 do
      local r7_75 = railIronOffsets[r6_75]
      if not r98_0[r6_75] then
        local r8_75 = createObject(modelIds.v4_mine_cargo_rail, mineHqX + r7_75[1], mineHqY + r7_75[2], mineHqZ + r7_75[3], r7_75[4], r7_75[5], r7_75[6])
        if isElement(r8_75) then
          setElementInterior(r8_75, 0)
          setElementDimension(r8_75, currentMine)
        end
        r98_0[r6_75] = r8_75
      end
    end
  elseif r0_75 == "railWoods" then
    local r2_75 = math.min(#railWoodOffsets, math.ceil(r1_75 / railWoodStack))
    for r6_75 = r2_75 + 1, #r99_0, 1 do
      if isElement(r99_0[r6_75]) then
        destroyElement(r99_0[r6_75])
      end
      r99_0[r6_75] = nil
    end
    for r6_75 = 1, r2_75, 1 do
      local r7_75 = railWoodOffsets[r6_75]
      if not r99_0[r6_75] then
        local r8_75 = createObject(modelIds.v4_mine_cargo_wood, mineHqX + r7_75[1], mineHqY + r7_75[2], mineHqZ + r7_75[3], r7_75[4], r7_75[5], r7_75[6])
        if isElement(r8_75) then
          setElementInterior(r8_75, 0)
          setElementDimension(r8_75, currentMine)
        end
        r99_0[r6_75] = r8_75
      end
    end
  elseif r0_75 == "mineLamps" then
    local r2_75 = math.min(#mineLampOffsets, math.ceil(r1_75 / mineLampStack))
    for r6_75 = r2_75 + 1, #r100_0, 1 do
      if isElement(r100_0[r6_75]) then
        destroyElement(r100_0[r6_75])
      end
      r100_0[r6_75] = nil
    end
    for r6_75 = 1, r2_75, 1 do
      local r7_75 = mineLampOffsets[r6_75]
      if not r100_0[r6_75] then
        local r8_75 = createObject(modelIds.v4_mine_cargo_lamp, mineHqX + r7_75[1], mineHqY + r7_75[2], mineHqZ + r7_75[3], r7_75[4], r7_75[5], r7_75[6])
        if isElement(r8_75) then
          setElementInterior(r8_75, 0)
          setElementDimension(r8_75, currentMine)
        end
        r100_0[r6_75] = r8_75
      end
    end
  end
  revalidateTabletOrder()
end
addMineEventHandler("handleMineHit", root, function(r0_76, r1_76, r2_76, r3_76, r4_76, r5_76)
  -- line: [4802, 4806] id: 76
  doHandleMineHit(r1_76, r2_76, r3_76, r4_76)
  doHandleMineHitCollision(r1_76, r2_76, r5_76)
  doHandleMineHitAfter(r1_76)
end)
addMineEventHandler("handleMineDetonate", root, function(r0_77, r1_77, r2_77, r3_77, r4_77)
  -- line: [4810, 4827] id: 77
  if r2_77 then
    doHandleMineHit(r1_77, r2_77, r3_77, r4_77, true)
  else
    local r5_77 = true
    for r9_77 = 1, wallBlockCount, 1 do
      if not doHandleMineHitCollision(r1_77, r9_77) then
        r5_77 = false
        break
      end
    end
    if r5_77 then
      doHandleMineHitAfter(r1_77)
    end
  end
end)
addMineEventHandler("closeMergedMineShafts", root, function(r0_78, r1_78, r2_78, r3_78, r4_78, r5_78)
  -- line: [4831, 4841] id: 78
  if r5_78 then
    createJunction(r3_78, r4_78, r5_78)
  end
  if r2_78 then
    closeMergedShaft(r2_78)
  end
  closeMergedShaft(r1_78)
end)
function closeMergedShaft(r0_79)
  -- line: [4844, 4896] id: 79
  if openShaftOres[r0_79] then
    for r4_79 in pairs(openShaftOres[r0_79]) do
      if isElement(openShaftOres[r0_79][r4_79][5]) then
        destroyElement(openShaftOres[r0_79][r4_79][5])
      end
    end
  end
  if openShaftCols[r0_79] then
    for r4_79 = 1, wallBlockCount, 1 do
      if isElement(openShaftCols[r0_79][r4_79]) then
        destroyElement(openShaftCols[r0_79][r4_79])
      end
    end
  end
  if isElement(openShaftDFFs[r0_79]) then
    destroyElement(openShaftDFFs[r0_79])
  end
  if openShaftModels[r0_79] then
    poolFreeModel(openShaftModels[r0_79])
  end
  if isElement(openShaftObjects[r0_79]) then
    destroyElement(openShaftObjects[r0_79])
  end
  if openShaftRNGs[r0_79] then
    rngDelete(openShaftRNGs[r0_79])
  end
  setOpenShaftAt(shaftCoords[r0_79][1] + shaftRotations[r0_79][3] * (shaftTunnels[r0_79] - 1), shaftCoords[r0_79][2] + shaftRotations[r0_79][4] * (shaftTunnels[r0_79] - 1))
  openShaftDFFs[r0_79] = nil
  openShaftModels[r0_79] = nil
  openShaftObjects[r0_79] = nil
  openShaftLengths[r0_79] = nil
  openShaftDepths[r0_79] = nil
  openShaftCols[r0_79] = nil
  shaftPositions[r0_79] = nil
  openShaftOres[r0_79] = nil
  openShaftDirty[r0_79] = nil
  openShaftLoaded[r0_79] = nil
  r53_0[r0_79] = nil
  openShaftRNGs[r0_79] = nil
  removeFromDffExportQueue(r0_79)
end
function removeFromDffExportQueue(r0_80)
  -- line: [4898, 4918] id: 80
  for r4_80 = #dffExportQueue, 1, -1 do
    local r5_80 = dffExportQueue[r4_80]
    if r5_80.shaftId == r0_80 then
      if r5_80.modelId then
        poolFreeModel(r5_80.modelId)
      end
      if isElement(r5_80.dffData) then
        destroyElement(r5_80.dffData)
      end
      if isElement(r5_80.objectElement) then
        destroyElement(r5_80.objectElement)
      end
      table.remove(dffExportQueue, r4_80)
    end
  end
end
addMineEventHandler("gotExtendedMineShaft", root, function(r0_81, r1_81, r2_81)
  -- line: [4921, 4956] id: 81
  local r3_81 = openShaftRNGs[r1_81]
  if r3_81 then
    local r4_81 = shaftCoords[r1_81]
    local r5_81 = shaftRotations[r1_81]
    local r6_81 = r4_81[1] + r5_81[3] * (shaftTunnels[r1_81] - 1)
    local r7_81 = r4_81[2] + r5_81[4] * (shaftTunnels[r1_81] - 1)
    setOpenShaftAt(r6_81, r7_81)
    r6_81 = r6_81 + r5_81[3]
    r7_81 = r7_81 + r5_81[4]
    setOpenShaftAt(r6_81, r7_81, r1_81)
    if r5_81[1] then
      createTunnelObject(r3_81, r6_81, r7_81, r5_81[1])
    end
    shaftTunnels[r1_81] = shaftTunnels[r1_81] + 1
    if canExtendShaftAt(r6_81, r7_81) then
      setExtendableShaft(r6_81, r7_81, r1_81, shaftTunnels[r1_81])
    end
    if not openShaftOres[r1_81] then
      openShaftOres[r1_81] = {}
    end
    for r11_81 = 1, #r2_81, 1 do
      table.insert(openShaftOres[r1_81], r2_81[r11_81])
    end
  end
end)
addMineEventHandler("gotNewMineShaft", root, function(r0_82, r1_82, r2_82, r3_82, r4_82, r5_82, r6_82, r7_82, r8_82, r9_82, r10_82, r11_82, r12_82, r13_82)
  -- line: [4960, 5001] id: 82
  local r14_82 = prad(r3_82)
  if r4_82 then
    shaftSet[r4_82] = nil
  end
  if r7_82 then
    shaftSet[r7_82] = nil
  end
  if r8_82 then
    shaftSet[r8_82] = nil
  end
  local r15_82 = table.insert
  local r16_82 = r11_0
  local r17_82 = {
    currentStage = 1,
    shaftId = r4_82,
    shaftX = r1_82,
    shaftY = r2_82,
    shaftDeg = r3_82,
    shaftRad = r14_82,
    shaftCos = pcos(r14_82),
  }
  local r18_82 = psin(r14_82)
  r17_82.shaftSin = r18_82
  r17_82.mainId = r7_82
  r17_82.sideId = r8_82
  r17_82.newShaftTunnels = r5_82
  if r6_82 then
    r18_82 = "left"
  else
    r18_82 = "right"
  end
  r17_82.newShaftSide = r18_82
  r17_82.newShaftOres = r11_82
  r17_82.newRandomSeed = r10_82
  r17_82.newJunctionType = r9_82
  r17_82.shaftToClose = r12_82
  r17_82.shaftWallMoveForward = r13_82
  r15_82(r16_82, r17_82)
  setExtendableShaft(r1_82, r2_82, false)
end)
function processShaftJobQueue()
  -- line: [5004, 5286] id: 83
  local r0_83 = r11_0[1]
  local r1_83 = r0_83.shaftId
  local r2_83 = r0_83.mainId
  local r3_83 = r0_83.sideId
  if r0_83.currentStage == 1 and r1_83 and r2_83 then
    local r4_83 = r0_83.shaftX
    local r5_83 = r0_83.shaftY
    local r6_83 = r0_83.shaftDeg
    local r7_83 = prad(r6_83)
    local r8_83 = pcos(r7_83)
    local r9_83 = psin(r7_83)
    openShaftDirty[r2_83] = openShaftDirty[r1_83]
    openShaftLoaded[r2_83] = nil
    removeFromDffExportQueue(r1_83)
    openShaftCols[r2_83] = openShaftCols[r1_83]
    shaftPositions[r2_83] = shaftPositions[r1_83]
    openShaftObjects[r2_83] = openShaftObjects[r1_83]
    openShaftModels[r2_83] = openShaftModels[r1_83]
    openShaftDFFs[r2_83] = openShaftDFFs[r1_83]
    r53_0[r2_83] = r53_0[r1_83]
    openShaftDepths[r2_83] = openShaftDepths[r1_83]
    if r0_83.shaftWallMoveForward then
      if openShaftOres[r1_83] then
        for r13_83 in pairs(openShaftOres[r1_83]) do
          checkCoroutineTime()
          if isElement(openShaftOres[r1_83][r13_83][5]) then
            destroyElement(openShaftOres[r1_83][r13_83][5])
          end
          openShaftOres[r1_83][r13_83] = nil
        end
        openShaftOres[r1_83] = {}
      end
      openShaftLengths[r2_83] = 0
      for r13_83 = 1, wallBlockCount, 1 do
        openShaftDepths[r2_83][r13_83] = 0
      end
    else
      if openShaftLengths[r1_83] then
        openShaftLengths[r2_83] = openShaftLengths[r1_83] - r0_83.newShaftTunnels * 6
      end
      openShaftOres[r2_83] = openShaftOres[r1_83]
    end
    r55_0[r2_83] = r55_0[r1_83]
    openShaftDirty[r1_83] = nil
    r53_0[r1_83] = nil
    openShaftLoaded[r1_83] = nil
    openShaftLengths[r1_83] = nil
    openShaftDepths[r1_83] = nil
    openShaftCols[r1_83] = nil
    shaftPositions[r1_83] = nil
    openShaftOres[r1_83] = nil
    r55_0[r1_83] = nil
    openShaftModels[r1_83] = nil
    openShaftDFFs[r1_83] = nil
    openShaftRNGs[r2_83] = openShaftRNGs[r1_83]
    shaftCoords[r2_83] = {
      r4_83 + r8_83,
      r5_83 + r9_83
    }
    shaftRotations[r2_83] = {
      r6_83,
      r7_83,
      r8_83,
      r9_83
    }
    shaftTunnels[r2_83] = math.max(1, shaftTunnels[r1_83] - r0_83.newShaftTunnels)
    setOpenShaftAt(r4_83, r5_83)
    if shaftTunnels[r1_83] - r0_83.newShaftTunnels <= 0 then
      local r10_83 = openShaftRNGs[r2_83]
      local r11_83 = false
      if not r10_83 then
        r10_83 = rngCreate(0)
        r11_83 = true
      end
      createTunnelObject(r10_83, r4_83 + r8_83, r5_83 + r9_83, r6_83)
      if r11_83 then
        rngDelete(r10_83)
      end
      if canExtendShaftAt(r4_83, r5_83) then
        setExtendableShaft(r4_83, r5_83, r2_83, 1)
      end
    end
    for r13_83 = 1, shaftTunnels[r2_83], 1 do
      r4_83 = r4_83 + r8_83
      r5_83 = r5_83 + r9_83
      if canExtendShaftAt(r4_83, r5_83) then
        setExtendableShaft(r4_83, r5_83, r2_83, r13_83)
      end
    end
    shaftTunnels[r1_83] = r0_83.newShaftTunnels - 1
    openShaftRNGs[r1_83] = nil
  elseif r0_83.currentStage == 2 then
    local r4_83 = r0_83.shaftX
    local r5_83 = r0_83.shaftY
    if r0_83.newRandomSeed then
      local r6_83 = r0_83.shaftDeg
      local r7_83 = rngCreate(r0_83.newRandomSeed)
      if r0_83.newShaftSide == "left" then
        r4_83 = r4_83 - r0_83.shaftSin
        r5_83 = r5_83 + r0_83.shaftCos
        r6_83 = (r6_83 + 90) % 360
      elseif r0_83.newShaftSide == "right" then
        r4_83 = r4_83 + r0_83.shaftSin
        r5_83 = r5_83 - r0_83.shaftCos
        r6_83 = (r6_83 - 90) % 360
      end
      local r8_83 = prad(r6_83)
      local r9_83 = pcos(r8_83)
      local r10_83 = psin(r8_83)
      r0_83.shaftCos = r9_83
      r0_83.shaftSin = r10_83
      openShaftDepths[r3_83] = {}
      openShaftLengths[r3_83] = 0
      for r14_83 = 1, wallBlockCount, 1 do
        openShaftDepths[r3_83][r14_83] = 0
      end
      createShaft(r3_83, r4_83, r5_83, 1, r6_83, r9_83, r10_83, r7_83)
      shaftCoords[r3_83] = {
        r4_83,
        r5_83
      }
      shaftTunnels[r3_83] = 1
      shaftRotations[r3_83] = {
        r6_83,
        r8_83,
        r9_83,
        r10_83
      }
      openShaftRNGs[r3_83] = r7_83
      checkCoroutineTime()
    else
      r0_83.currentStage = 5
      if openShaftDepths[r2_83] then
        setOpenShaftAt(r4_83 + pcos(prad(r0_83.shaftDeg)), r5_83 + psin(prad(r0_83.shaftDeg)), r2_83)
      end
    end
  elseif r0_83.currentStage == 3 then
    generateOpenShaftDff(r3_83, true, true)
    openShaftDirty[r3_83] = true
    openShaftLoaded[r3_83] = nil
    checkCoroutineTime()
  elseif r0_83.currentStage == 4 then
    openShaftCols[r3_83] = {}
    for r7_83 = 1, wallBlockCount, 1 do
      local r8_83, r9_83, r10_83 = getShaftBlockPosition(r3_83, r7_83)
      local r11_83 = createObject(modelIds.v4_mine_wall, r8_83, r9_83, r10_83, 0, 0, shaftRotations[r3_83][1] + 180)
      if isElement(r11_83) then
        setObjectScale(r11_83, 0)
        setElementAlpha(r11_83, 0)
        setElementInterior(r11_83, 0)
        setElementDimension(r11_83, currentMine)
        removeShaderFromObject(r11_83)
        checkCoroutineTime()
      end
      openShaftCols[r3_83][r7_83] = r11_83
    end
    checkCoroutineTime()
  elseif r0_83.currentStage == 5 then
    if not openShaftOres[r3_83] then
      openShaftOres[r3_83] = {}
    end
    for r7_83 = 1, #r0_83.newShaftOres, 1 do
      table.insert(openShaftOres[r3_83], r0_83.newShaftOres[r7_83])
    end
  elseif r0_83.currentStage == 6 then
    local r4_83 = r0_83.shaftX
    local r5_83 = r0_83.shaftY
    deleteTunnelObject(r4_83, r5_83)
    if not r3_83 and r2_83 and r0_83.newShaftOres then
      if not openShaftOres[r2_83] then
        openShaftOres[r2_83] = {}
      end
      for r9_83 = 1, #r0_83.newShaftOres, 1 do
        table.insert(openShaftOres[r2_83], r0_83.newShaftOres[r9_83])
      end
    end
    if r0_83.shaftWallMoveForward then
      generateOpenShaftDff(r2_83, true, true)
      openShaftDirty[r2_83] = true
      openShaftLoaded[r2_83] = nil
      for r9_83 = 1, wallBlockCount, 1 do
        local r10_83, r11_83, r12_83 = getShaftBlockPosition(r2_83, r9_83)
        if isElement(openShaftCols[r2_83][r9_83]) then
          setElementPosition(openShaftCols[r2_83][r9_83], r10_83, r11_83, r12_83)
        end
        checkCoroutineTime()
      end
    end
    if r1_83 then
      if r0_83.newShaftSide == "left" then
        createJunction(r4_83, r5_83, r0_83.newJunctionType, (r0_83.shaftDeg + 180) % 360)
      else
        createJunction(r4_83, r5_83, r0_83.newJunctionType, r0_83.shaftDeg)
      end
    else
      r0_83.currentStage = 7
      collectgarbage()
      return 
    end
    if r1_83 then
      shaftSet[r1_83] = true
    end
    if r2_83 then
      shaftSet[r2_83] = true
    end
    if r3_83 then
      shaftSet[r3_83] = true
    end
    if r0_83.shaftToClose then
      closeMergedShaft(r0_83.shaftToClose)
    end
    table.remove(r11_0, 1)
    return 
  elseif r0_83.currentStage == 7 then
    deleteTunnelObject(r0_83.shaftX, r0_83.shaftY)
    if r1_83 then
      shaftSet[r1_83] = true
    end
    if r2_83 then
      shaftSet[r2_83] = true
    end
    if r3_83 then
      shaftSet[r3_83] = true
    end
    createJunction(r0_83.shaftX, r0_83.shaftY, r0_83.newJunctionType)
    if r0_83.shaftToClose then
      closeMergedShaft(r0_83.shaftToClose)
    end
    table.remove(r11_0, 1)
    return 
  end
  r0_83.currentStage = r0_83.currentStage + 1
end
function getShaftBlockPosition(r0_84, r1_84)
  -- line: [5288, 5310] id: 84
  local r2_84 = r33_0[r1_84]
  if r2_84 then
    local r3_84 = shaftPositions[r0_84]
    if r3_84 then
      local r4_84 = shaftRotations[r0_84]
      if r4_84 then
        local r5_84 = r2_84[1] * wallMeshWidth - wallMeshWidth / 2
        local r6_84 = openShaftDepths[r0_84][r1_84]
        return r3_84[1] + r5_84 * r4_84[4] + r6_84 * r4_84[3], r3_84[2] - r5_84 * r4_84[3] + r6_84 * r4_84[4], minePosZ + r2_84[2] * wallMeshHeight
      end
    end
  end
end
addMineEventHandler("syncFixOreDelete", root, function(r0_85, r1_85)
  -- line: [5313, 5328] id: 85
  for r5_85 = 1, #r1_85, 1 do
    local r6_85 = r1_85[r5_85]
    if fixOres[r6_85] then
      detachFixOre(r6_85)
      removeFixOreSync(r6_85)
      if isElement(fixOres[r6_85][6]) then
        destroyElement(fixOres[r6_85][6])
      end
    end
    fixOres[r6_85] = nil
  end
end)
addMineEventHandler("syncFixOreState", root, function(r0_86, r1_86, r2_86, r3_86, r4_86, r5_86, r6_86, r7_86)
  -- line: [5332, 5424] id: 86
  detachFixOre(r1_86)
  if r2_86 == "player" then
    attachFixOreToPlayer(r1_86, source)
  elseif r2_86 == "ground" and fixOres[r1_86] then
    setFixOrePosition(r1_86, r3_86, r4_86, minePosZ)
    local r9_86 = playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", r3_86, r4_86, minePosZ)
    if isElement(r9_86) then
      setElementInterior(r9_86, 0)
      setElementDimension(r9_86, currentMine)
      if isElement(fixOres[r1_86][6]) then
        attachElements(r9_86, fixOres[r1_86][6])
      end
    end
    spawnSmokeExSm(r3_86, r4_86, minePosZ)
  elseif r2_86 == "cart" then
    local r8_86 = fixOres[r1_86]
    if r8_86 then
      attachFixOreToCart(r1_86, r5_86, r6_86)
      local r9_86, r10_86, r11_86 = getElementPosition(r8_86[6])
      local r12_86 = playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", r9_86, r10_86, r11_86)
      if isElement(r12_86) then
        setElementInterior(r12_86, 0)
        setElementDimension(r12_86, currentMine)
        attachElements(r12_86, r8_86[6])
      end
      spawnSmokeExSm(r9_86, r10_86, r11_86)
      if source ~= resourceRoot then
        setPedHeadingTo(source, cartTurtleObjects[r5_86])
      end
    end
  elseif r2_86 == "conveyor" then
    local r8_86 = fixOres[r1_86]
    removeFixOreSync(r1_86)
    if r8_86 then
      local r9_86 = r8_86[6]
      if isElement(r9_86) then
        local r10_86, r11_86, r12_86 = getElementPosition(r9_86)
        local r13_86 = playSound3D("files/sounds/orefall" .. math.random(1, 4) .. ".wav", r10_86, r11_86, r12_86)
        if isElement(r13_86) then
          setElementInterior(r13_86, 0)
          setElementDimension(r13_86, currentMine)
          attachElements(r13_86, r9_86)
        end
        detachElements(r9_86)
        setElementInterior(r9_86, 0)
        setElementDimension(r9_86, currentMine)
        table.insert(r95_0, {
          oreElement = r9_86,
          orePosX = r10_86,
          orePosY = r11_86,
          orePosZ = r12_86,
          animationStage = 1,
          animationLength = math.min(3000, getDistanceBetweenPoints3D(conveyorStartX, conveyorStartY, conveyorStartZ, r10_86, r11_86, r12_86) * 400),
          animationStart = getTickCount(),
          oreBias = math.min(0.25, math.max(-0.25, r10_86 - conveyorStartX)),
          oreType = r8_86[10],
          oreAmount = r7_86,
        })
      end
      fixOres[r1_86] = nil
    end
  elseif r2_86 == "delete" then
    local r8_86 = fixOres[r1_86]
    removeFixOreSync(r1_86)
    if r8_86 then
      if isElement(r8_86[6]) then
        destroyElement(r8_86[6])
      end
      fixOres[r1_86] = nil
    end
  end
end)
addMineEventHandler("syncOreEmptying", root, function(r0_87, r1_87, r2_87)
  -- line: [5428, 5438] id: 87
  if cartTurtleEmptying[r1_87] == localPlayer then
    emptyingTurtle = false
  end
  cartTurtleEmptying[r1_87] = r2_87
  if r2_87 == localPlayer then
    emptyingTurtle = r1_87
  end
end)
function attachFixOreToCart(r0_88, r1_88, r2_88)
  -- line: [5441, 5473] id: 88
  local r3_88 = fixOres[r0_88]
  if r3_88 then
    detachFixOre(r0_88)
    if not fixOreStreamed[r0_88] then
      fixOreStreamed[r0_88] = true
      if isElement(r3_88[6]) then
        setElementInterior(r3_88[6], 0)
        setElementDimension(r3_88[6], currentMine)
      end
    end
    local r4_88, r5_88 = getElementPosition(cartTurtleObjects[r1_88])
    if isElement(r3_88[6]) then
      setElementModel(r3_88[6], modelIds["v4_mine_ore" .. oreCartOffsets[r2_88][1]])
      attachElements(r3_88[6], cartTurtleObjects[r1_88], unpack(oreCartOffsets[r2_88], 2))
      setElementCollisionsEnabled(r3_88[6], false)
    end
    fixOreCarts[r0_88] = {
      r1_88,
      r2_88
    }
    if (cartMaxSlots[r1_88] or 0) < r2_88 then
      cartMaxSlots[r1_88] = r2_88
      cartLastSlot[r1_88] = r0_88
    end
    setFixOrePosition(r0_88, r4_88, r5_88)
  end
end
function attachFixOreToPlayer(r0_89, r1_89)
  -- line: [5475, 5504] id: 89
  local r2_89 = fixOres[r0_89]
  if r2_89 then
    detachFixOre(r0_89)
    if isElement(r2_89[6]) then
      setElementCollisionsEnabled(r2_89[6], false)
    end
    r94_0[r0_89] = r1_89
    if r1_89 == localPlayer then
      exports.sGui:showInfobox("i", "A letételhez nyomj [F] gombot.")
      if oreTypes[r2_89[10]].instantItem then
        exports.sGui:showInfobox("i", "Az [E] gomb megnyomásával elteheted az inventorydba.")
      end
      carryingFixOre = r0_89
    end
    processTablet(r1_89, false)
    setPedAnimation(r1_89, "CARRY", "CRRY_PRTIAL", 0, true, false, false, true)
    if isElement(r2_89[6]) then
      setPedHeadingTo(r1_89, r2_89[6])
    end
  end
end
function detachFixOre(r0_90)
  -- line: [5506, 5549] id: 90
  if carryingFixOre == r0_90 then
    carryingFixOre = false
  end
  local r1_90 = false
  if isElement(r94_0[r0_90]) then
    r1_90 = r94_0[r0_90]
  end
  local r2_90 = fixOres[r0_90]
  if fixOreCarts[r0_90] then
    local r3_90 = fixOreCarts[r0_90][1]
    if isElement(r2_90[6]) then
      if isElement(cartTurtleObjects[r3_90]) then
        detachElements(r2_90[6], cartTurtleObjects[r3_90])
      end
      setElementCollisionsEnabled(r2_90[6], true)
    end
    cartMaxSlots[r3_90] = 0
    cartLastSlot[r3_90] = nil
    fixOreCarts[r0_90] = nil
    for r7_90 in pairs(fixOreCarts) do
      local r8_90, r9_90 = unpack(fixOreCarts[r7_90])
      if cartMaxSlots[r8_90] < r9_90 then
        cartMaxSlots[r3_90] = r9_90
        cartLastSlot[r3_90] = r7_90
      end
    end
  end
  r94_0[r0_90] = nil
  if r1_90 then
    processTablet(r1_90)
  end
end
function removeFixOreSync(r0_91)
  -- line: [5551, 5571] id: 91
  local r1_91 = fixOres[r0_91]
  if r1_91 then
    local r2_91 = r1_91[8]
    local r3_91 = r1_91[9]
    if r2_91 and r3_91 and r90_0[r2_91] and r90_0[r2_91][r3_91] then
      for r7_91 = #r90_0[r2_91][r3_91], 1, -1 do
        if r90_0[r2_91][r3_91][r7_91] == r0_91 then
          table.remove(r90_0[r2_91][r3_91], r7_91)
          break
        end
      end
    end
  end
  fixOreStreamed[r0_91] = nil
end
function doFixOreStreaming()
  -- line: [5573, 5629] id: 92
  local r0_92 = {}
  iterateGrid(r90_0, selfMineX - 5, selfMineY - 5, selfMineX + 5, selfMineY + 5, function(r0_93)
    -- line: [5577, 5603] id: 93
    for r4_93 = 1, #r0_93, 1 do
      local r5_93 = r0_93[r4_93]
      if r5_93 then
        local r6_93 = fixOres[r5_93]
        if r6_93 then
          local r8_93 = nil	-- notice: implicit variable refs by block#[6, 7, 8]
          if getDistanceBetweenPoints2D(selfPosX, selfPosY, r6_93[1], r6_93[2]) < 25 then
            r8_93 = true
          else
            r8_93 = nil
          end
          r0_92[r5_93] = true
          if fixOreStreamed[r5_93] ~= r8_93 then
            fixOreStreamed[r5_93] = r8_93
            if isElement(r6_93[6]) then
              setElementInterior(r6_93[6], 0)
              local r9_93 = setElementDimension
              local r10_93 = r6_93[6]
              local r11_93 = nil	-- notice: implicit variable refs by block#[11]
              if r8_93 then
                r11_93 = currentMine
              else
                r11_93 = 0
              end
              r9_93(r10_93, r11_93)
            end
            coroutine.yield()
          end
        end
      end
    end
  end)
  for jj = 1, 1 do
    local r1_92 = true
    for r5_92 in pairs(fixOreStreamed) do
      if not r0_92[r5_92] then
        fixOreStreamed[r5_92] = nil
        if isElement(fixOres[r5_92][6]) then
          setElementInterior(fixOres[r5_92][6], 0)
          setElementDimension(fixOres[r5_92][6], 0)
        end
        r1_92 = false
        break
      end
    end
    if r1_92 then
      break
    end
    coroutine.yield()
  end
end
function setFixOrePosition(r0_94, r1_94, r2_94, r3_94)
  -- line: [5631, 5671] id: 94
  local r4_94, r5_94 = convertMineCoordinates(r1_94, r2_94)
  if r3_94 and isElement(fixOres[r0_94][6]) then
    setElementPosition(fixOres[r0_94][6], r1_94, r2_94, r3_94)
  end
  fixOres[r0_94][1] = r1_94
  fixOres[r0_94][2] = r2_94
  local r6_94 = fixOres[r0_94][8]
  local r7_94 = fixOres[r0_94][9]
  if r4_94 ~= r6_94 or r5_94 ~= r7_94 then
    if r6_94 and r7_94 and r90_0[r6_94] and r90_0[r6_94][r7_94] then
      for r11_94 = #r90_0[r6_94][r7_94], 1, -1 do
        if r90_0[r6_94][r7_94][r11_94] == r0_94 then
          table.remove(r90_0[r6_94][r7_94], r11_94)
          break
        end
      end
    end
    fixOres[r0_94][8] = r4_94
    fixOres[r0_94][9] = r5_94
    if not r90_0[r4_94] then
      r90_0[r4_94] = {}
    end
    if not r90_0[r4_94][r5_94] then
      r90_0[r4_94][r5_94] = {}
    end
    table.insert(r90_0[r4_94][r5_94], r0_94)
  end
end
function doHandleMineHit(r0_95, r1_95, r2_95, r3_95, r4_95)
  -- line: [5673, 5754] id: 95
  openShaftDepths[r0_95][r1_95] = openShaftDepths[r0_95][r1_95] + r2_95
  if r3_95 then
    local r5_95 = openShaftOres[r0_95]
    if r5_95 then
      if not r55_0[r0_95] then
        r55_0[r0_95] = {}
      end
      for r9_95 = #r5_95, 1, -1 do
        local r10_95, r11_95, r12_95, r13_95, r14_95, r15_95, r16_95 = unpack(r5_95[r9_95])
        if r16_95 then
          local r17_95 = r3_95[r16_95]
          if r17_95 then
            local r18_95 = oreTypes[r15_95]
            if r18_95 then
              r18_95 = oreTypes[r15_95].modelName
            else
              r18_95 = "v4_mine_ore" .. math.random(1, 5)
            end
            if not isElement(r14_95) and r18_95 then
              r14_95 = createObject(modelIds[r18_95], minePosX + r10_95, minePosY + r11_95, minePosZ + r12_95, math.random() * 360, math.random() * 360, math.random() * 360)
              if isElement(r14_95) then
                refreshOreShader(r14_95, r15_95)
                setElementInterior(r14_95, 0)
                setElementDimension(r14_95, currentMine)
              end
            end
            local r19_95 = nil
            local r20_95 = nil
            if type(r17_95) == "table" then
              r19_95 = r17_95[1]
              r20_95 = r17_95[2]
            end
            if r5_95[r9_95][5] ~= r14_95 or r15_95 ~= r20_95 then
              r5_95[r9_95][5] = r14_95
              r5_95[r9_95][6] = r20_95
              refreshOreShader(r14_95, r20_95)
            end
            if not r4_95 then
              local r21_95 = playSound3D("files/sounds/orefall" .. math.random(1, 7) .. ".wav", minePosX + r10_95, minePosY + r11_95, minePosZ + r12_95)
              if isElement(r21_95) then
                attachElements(r21_95, r14_95)
                setElementInterior(r21_95, 0)
                setElementDimension(r21_95, currentMine)
              end
            end
            if type(r17_95) == "table" then
              removeFixOreSync(r19_95)
              if fixOres[r19_95] then
                if isElement(fixOres[r19_95][6]) then
                  destroyElement(fixOres[r19_95][6])
                end
                fixOres[r19_95][6] = nil
              end
              fixOres[r19_95] = {
                r10_95,
                r11_95,
                r12_95,
                getTickCount(),
                0,
                r14_95,
                r0_95,
                nil,
                nil,
                r20_95
              }
              fixOreStreamed[r19_95] = true
              if r19_95 then
                setFixOrePosition(r19_95, r10_95, r11_95, r12_95)
              end
              table.insert(r93_0, r19_95)
            else
              table.insert(r55_0[r0_95], {
                r10_95,
                r11_95,
                r12_95,
                getTickCount(),
                0,
                r14_95
              })
            end
            table.remove(openShaftOres[r0_95], r9_95)
          end
        end
      end
    end
  end
end
function doHandleMineHitCollision(r0_96, r1_96, r2_96)
  -- line: [5756, 5777] id: 96
  local r3_96, r4_96, r5_96 = getShaftBlockPosition(r0_96, r1_96)
  if r3_96 then
    if isElement(openShaftCols[r0_96][r1_96]) then
      setElementPosition(openShaftCols[r0_96][r1_96], r3_96, r4_96, r5_96)
    end
    if r2_96 ~= nil then
      local r6_96 = playSound3D
      local r7_96 = "files/sounds/pickaxehit"
      local r8_96 = math.random
      local r9_96 = nil	-- notice: implicit variable refs by block#[10]
      if r2_96 then
        r9_96 = 16
      else
        r9_96 = 1
      end
      local r10_96 = nil	-- notice: implicit variable refs by block#[10]
      if r2_96 then
        r10_96 = 20
      else
        r10_96 = 15
      end
      r6_96 = r6_96(r7_96 .. r8_96(r9_96, r10_96) .. ".wav", r3_96, r4_96, r5_96)
      if isElement(r6_96) then
        setElementInterior(r6_96, 0)
        setElementDimension(r6_96, currentMine)
      end
      spawnSmoke(r3_96, r4_96, r5_96, r2_96)
    end
  end
  return r3_96, r4_96, r5_96
end
function doHandleMineHitAfter(r0_97)
  -- line: [5779, 5812] id: 97
  local r1_97 = false
  for r5_97 = 1, wallBlockCount, 1 do
    local r6_97 = openShaftDepths[r0_97][r5_97]
    if not r1_97 or r6_97 < r1_97 then
      r1_97 = r6_97
    end
  end
  if r1_97 > 0 then
    openShaftLengths[r0_97] = openShaftLengths[r0_97] + r1_97
    shaftPositions[r0_97] = {
      minePosX + shaftCoords[r0_97][1] * 6 + (openShaftLengths[r0_97] - 3) * shaftRotations[r0_97][3],
      minePosY + shaftCoords[r0_97][2] * 6 + (openShaftLengths[r0_97] - 3) * shaftRotations[r0_97][4]
    }
    for r5_97 = 1, wallBlockCount, 1 do
      openShaftDepths[r0_97][r5_97] = openShaftDepths[r0_97][r5_97] - r1_97
    end
    if isElement(openShaftObjects[r0_97]) then
      setElementPosition(openShaftObjects[r0_97], shaftPositions[r0_97][1], shaftPositions[r0_97][2], minePosZ)
    end
  end
  openShaftDirty[r0_97] = true
  openShaftLoaded[r0_97] = nil
  if r62_0 == r0_97 then
    r66_0 = true
  end
end
function spawnSmoke(r0_98, r1_98, r2_98, r3_98)
  -- line: [5814, 5842] id: 98
  for r7_98 = 1, math.random(10, 30), 1 do
    spawnSmokeParticle(r0_98, r1_98, r2_98, math.random() - 0.5, math.random() - 0.5, math.random() - 0.5, 1000 + math.random() * 2000, 150 + math.random() * 55, 0.4 + math.random() * 0.4, 0.2 + math.random() * 0.2)
  end
  if r3_98 then
    for r7_98 = 1, math.random(10, 30), 1 do
      spawnSparkParticle(r0_98, r1_98, r2_98, (math.random() - 0.5) * 4, (math.random() - 0.5) * 4, (math.random() - 0.5) * 4, 500 + math.random() * 1000, 200 + math.random() * 55, 0.025 + math.random() * 0.025, 0.001 + math.random() * 0.001)
    end
  end
end
function spawnSmokeEx(r0_99, r1_99, r2_99)
  -- line: [5844, 5857] id: 99
  for r6_99 = 1, math.random(20, 50), 1 do
    spawnSmokeParticle(r0_99, r1_99, r2_99, math.random() - 0.5, math.random() - 0.5, math.random() * 0.5, 2000 + math.random() * 2000, 150 + math.random() * 55, 0.6 + math.random() * 0.6, 0.25 + math.random() * 0.25)
  end
end
function spawnSmokeExSm(r0_100, r1_100, r2_100)
  -- line: [5859, 5872] id: 100
  for r6_100 = 1, math.random(20, 50), 1 do
    spawnSmokeParticle(r0_100, r1_100, r2_100, math.random() - 0.5, math.random() - 0.5, math.random() * 0.5, 1000 + math.random() * 1500, 150 + math.random() * 55, 0.3 + math.random() * 0.3, 0.125 + math.random() * 0.125)
  end
end
function spawnSmokeExBg(r0_101, r1_101, r2_101, r3_101)
  -- line: [5874, 5904] id: 101
  for r7_101 = 1, math.random(100, 150), 1 do
    spawnSmokeParticle(r0_101 + (math.random() - 0.5) * 2, r1_101 + (math.random() - 0.5) * 2, r2_101 + (math.random() - 0.5) * 2, (math.random() - 0.5) * 0.25, (math.random() - 0.5) * 0.25, (math.random() - 0.5) * 0.25, 4000 + math.random() * 4000, 150 + math.random() * 55, 0.8 + math.random() * 0.8, 0.4 + math.random() * 0.4)
  end
  if r3_101 then
    for r7_101 = 1, math.random(20, 40), 1 do
      spawnSparkParticle(r0_101, r1_101, r2_101, (math.random() - 0.5) * 4, (math.random() - 0.5) * 4, (math.random() - 0.5) * 4, 500 + math.random() * 1000, 200 + math.random() * 55, 0.025 + math.random() * 0.025, 0.001 + math.random() * 0.001)
    end
  end
end
function spawnSmokeParticle(r0_102, r1_102, r2_102, r3_102, r4_102, r5_102, r6_102, r7_102, r8_102, r9_102)
  -- line: [5906, 5908] id: 102
  table.insert(r86_0, {
    r0_102,
    r1_102,
    r2_102,
    r3_102,
    r4_102,
    r5_102,
    getTickCount(),
    r6_102,
    r7_102,
    r8_102,
    r9_102
  })
end
function spawnSparkParticle(r0_103, r1_103, r2_103, r3_103, r4_103, r5_103, r6_103, r7_103, r8_103, r9_103)
  -- line: [5910, 5912] id: 103
  table.insert(r87_0, {
    r0_103,
    r1_103,
    r2_103,
    r3_103,
    r4_103,
    r5_103,
    getTickCount(),
    r6_103,
    r7_103,
    r8_103,
    r9_103
  })
end
function getMiningZoneColor(r0_104)
  -- line: [5914, 5933] id: 104
  r0_104 = math.min(1, r0_104)
  if r0_104 >= 0.9 then
    r0_104 = (r0_104 - 0.9) / 0.1
    return {
      orange[1] * (1 - r0_104) + red[1] * r0_104,
      orange[2] * (1 - r0_104) + red[2] * r0_104,
      orange[3] * (1 - r0_104) + red[3] * r0_104
    }
  end
  r0_104 = math.pow(r0_104 / 0.9, 1.5)
  return {
    green[1] * (1 - r0_104) + orange[1] * r0_104,
    green[2] * (1 - r0_104) + orange[2] * r0_104,
    green[3] * (1 - r0_104) + orange[3] * r0_104
  }
end
function disableControls(r0_105)
  -- line: [5937, 5943] id: 105
  if r1_0 ~= r0_105 then
    r1_0 = r0_105
    exports.sControls:toggleControl("all", not r0_105)
    setElementFrozen(localPlayer, r0_105)
  end
end
function setCurrentActiveOpenShaft(r0_106)
  -- line: [5947, 5998] id: 106
  if r0_106 ~= r62_0 then
    if isElement(openShaftObjects[r62_0]) then
      setElementInterior(openShaftObjects[r62_0], 0)
      setElementDimension(openShaftObjects[r62_0], currentMine)
    end
    r62_0 = r0_106
    if r0_106 then
      local r1_106 = false
      if not currentActiveNormalRT then
        currentActiveNormalRT = dxCreateRenderTarget(wallTextureWidth, wallTextureHeight)
        r1_106 = true
      end
      if not currentActiveDepthRT then
        currentActiveDepthRT = dxCreateRenderTarget(wallTextureWidth, wallTextureHeight)
        r1_106 = true
      end
      r63_0 = {}
      if isElement(openShaftObjects[r0_106]) then
        setElementInterior(openShaftObjects[r0_106], 0)
        setElementDimension(openShaftObjects[r0_106], 0)
      end
      if r1_106 then
        refreshActiveShaftShader()
      end
      processCurrentActiveWorld()
    else
      r63_0 = nil
      r66_0 = false
      if isElement(currentActiveNormalRT) then
        destroyElement(currentActiveNormalRT)
      end
      currentActiveNormalRT = nil
      if isElement(currentActiveDepthRT) then
        destroyElement(currentActiveDepthRT)
      end
      currentActiveDepthRT = nil
    end
  end
end
function processCurrentActiveWorld()
  -- line: [6000, 6110] id: 107
  local r0_107 = r62_0
  local r1_107 = shaftPositions[r0_107][1]
  local r2_107 = shaftPositions[r0_107][2]
  local r3_107 = shaftRotations[r0_107][3]
  local r4_107 = shaftRotations[r0_107][4]
  local r5_107 = {}
  local r6_107 = {}
  generateRandomMDVD(r0_107, r6_107, r5_107)
  for r10_107 = 1, wallBlockCount, 1 do
    processZoneDistance(r0_107, openShaftDepths[r0_107], r6_107, r5_107, r10_107)
  end
  local r7_107 = {}
  local r8_107 = {}
  local r9_107 = {}
  for r13_107 = 1, wallVertexCount, 1 do
    local r14_107, r15_107 = unpack(r25_0[r13_107])
    r14_107 = r14_107 / wallTextureWidth
    r15_107 = r15_107 / wallTextureHeight
    local r16_107 = (r14_107 - 0.5) * wallMeshWidth
    local r17_107 = r5_107[r13_107]
    r63_0[r13_107] = {
      r1_107 + r16_107 * r4_107 + r17_107 * r3_107,
      r2_107 - r16_107 * r3_107 + r17_107 * r4_107,
      minePosZ + r15_107 * wallMeshHeight,
      4294967295,
      -r14_107,
      -r15_107
    }
  end
  local r10_107 = wallMaximumDepth
  for r14_107 = 1, wallVertexCount, 1 do
    r10_107 = math.min(r10_107, r5_107[r14_107])
  end
  for r14_107 = 1, wallVertexCount, 1 do
    local r15_107 = 255 * math.max(0, (r5_107[r14_107] - r10_107) / wallMaximumDepth)
    r7_107[r14_107] = {
      r25_0[r14_107][1],
      r25_0[r14_107][2],
      tocolor(r15_107, r15_107, r15_107, 255)
    }
  end
  for r14_107 = 1, wallVertexCount, 3 do
    r9_107[r14_107] = {
      calculateSurfaceNormal(r63_0[r14_107], r63_0[r14_107 + 1], r63_0[r14_107 + 2])
    }
  end
  for r14_107 in pairs(r27_0) do
    local r15_107 = 0
    local r16_107 = 0
    local r17_107 = 0
    for r21_107 = 1, #r27_0[r14_107], 1 do
      local r23_107 = r9_107[r27_0[r14_107][r21_107]]
      r15_107 = r15_107 + r23_107[1]
      r16_107 = r16_107 + r23_107[2]
      r17_107 = r17_107 + r23_107[3]
    end
    local r18_107 = math.sqrt(r15_107 * r15_107 + r16_107 * r16_107 + r17_107 * r17_107)
    r8_107[r14_107] = {
      r25_0[r14_107][1],
      r25_0[r14_107][2],
      tocolor(math.floor((-r15_107 / r18_107 * 0.5 + 0.5) * 255 + 0.5), math.floor((-r16_107 / r18_107 * 0.5 + 0.5) * 255 + 0.5), math.floor((-r17_107 / r18_107 * 0.5 + 0.5) * 255 + 0.5))
    }
  end
  for r14_107 = 1, wallVertexCount, 1 do
    r8_107[r14_107] = r8_107[baseVertexNeighbors[r14_107]]
  end
  r64_0 = minePosX + shaftCoords[r0_107][1] * 6 + (openShaftLengths[r0_107] + r10_107 - 3) * r3_107
  r65_0 = minePosY + shaftCoords[r0_107][2] * 6 + (openShaftLengths[r0_107] + r10_107 - 3) * r4_107
  refreshActiveShaftShaderBase(r64_0 - r4_107 * wallMeshWidth / 2, r65_0 + r3_107 * wallMeshWidth / 2, r4_107, -r3_107)
  dxSetRenderTarget(currentActiveDepthRT)
  dxDrawPrimitive("trianglelist", false, unpack(r7_107))
  dxSetRenderTarget(currentActiveNormalRT)
  dxDrawPrimitive("trianglelist", false, unpack(r8_107))
  dxSetRenderTarget()
  r66_0 = false
end
function isShaftWallVisible(r0_108, r1_108)
  -- line: [6114, 6137] id: 108
  local r2_108 = shaftPositions[r0_108]
  if r2_108 then
    local r3_108 = getDistanceBetweenPoints2D(r2_108[1], r2_108[2], selfPosX, selfPosY)
    local r4_108 = false
    if r3_108 <= 50 then
      if r1_108 then
        r4_108 = true
      elseif isElement(openShaftObjects[r0_108]) then
        if isElementOnScreen(openShaftObjects[r0_108]) then
          r4_108 = true
        end
      else
        r4_108 = true
      end
    end
    return r4_108, r3_108
  end
  return false
end
function createShaft(r0_109, r1_109, r2_109, r3_109, r4_109, r5_109, r6_109, r7_109)
  -- line: [6139, 6157] id: 109
  for r11_109 = 1, r3_109, 1 do
    createTunnelObject(r7_109, r1_109, r2_109, r4_109)
    if canExtendShaftAt(r1_109, r2_109) then
      setExtendableShaft(r1_109, r2_109, r0_109, r11_109)
    end
    r1_109 = r1_109 + r5_109
    r2_109 = r2_109 + r6_109
  end
  r1_109 = r1_109 - r5_109
  r2_109 = r2_109 - r6_109
  if openShaftDepths[r0_109] then
    setOpenShaftAt(r1_109, r2_109, r0_109)
  end
end
function setOpenShaftAt(r0_110, r1_110, r2_110)
  -- line: [6159, 6177] id: 110
  if r34_0[r0_110] and isElement(r34_0[r0_110][r1_110]) then
    local r3_110 = "v4_mine_tunnel" .. r35_0[r0_110][r1_110]
    if r2_110 then
      r3_110 = r3_110 .. "_columnless"
    end
    setElementModel(r34_0[r0_110][r1_110], modelIds[r3_110])
  end
  if not openShaftsAt[r0_110] then
    openShaftsAt[r0_110] = {}
  end
  openShaftsAt[r0_110][r1_110] = r2_110
end

function setExtendableShaft(r0_111, r1_111, r2_111, r3_111)
  -- line: [6179, 6193] id: 111
  if r2_111 and r3_111 then
    if not r41_0[r0_111] then
      r41_0[r0_111] = {}
    end
    r41_0[r0_111][r1_111] = {
      r2_111,
      r3_111
    }
  elseif r41_0[r0_111] and r41_0[r0_111][r1_111] then
    r41_0[r0_111][r1_111] = nil
  end
end
function processExtendableShaft(shaftId, shaftCos, shaftSin)
  local spotX = false
  local spotY = false

  if not shaftId then
    spotX = selfMineX
    spotY = selfMineY
  end
  if currentExtendableShaftId ~= shaftId or currentExtendableShaftSpotX ~= spotX or currentExtendableShaftSpotY ~= spotY then
    currentExtendableShaftId = shaftId
    currentExtendableShaftSpotX = spotX
    currentExtendableShaftSpotY = spotY
    if shaftId then
      if shaftSin == 0 then
        currentExtendableShaftLeft = true
        currentExtendableShaftRight = true
      elseif shaftSin > 0 then
        currentExtendableShaftLeft = false
        currentExtendableShaftRight = true
      elseif shaftSin < 0 then
        currentExtendableShaftLeft = true
        currentExtendableShaftRight = false
      end
    else
      if shaftSin == 0 then
        currentExtendableShaftLeft = true
      else
        currentExtendableShaftLeft = false
      end
      currentExtendableShaftRight = false
    end
  end
  iprint("processed new shaft, shaftID:", shaftId, "shaftLeft", currentExtendableShaftLeft, "shaftRight", currentExtendableShaftRight, "shaftSin", shaftSin)
end
function deleteTunnelObject(r0_113, r1_113)
  -- line: [6233, 6248] id: 113
  if r34_0[r0_113] then
    if isElement(r34_0[r0_113][r1_113]) then
      destroyElement(r34_0[r0_113][r1_113])
    end
    r34_0[r0_113][r1_113] = nil
  end
  if tunnelObjectRots[r0_113] then
    tunnelObjectRots[r0_113][r1_113] = nil
  end
  if r35_0[r0_113] then
    r35_0[r0_113][r1_113] = nil
  end
end
function createTunnelObject(r0_114, r1_114, r2_114, r3_114)
  -- line: [6250, 6292] id: 114
  local r4_114 = rngGetValue(r0_114)
  local r5_114 = math.floor(r4_114 * 5) + 1
  local r6_114 = false
  if openShaftsAt[r1_114] and openShaftsAt[r1_114][r2_114] then
    r6_114 = modelIds["v4_mine_tunnel" .. r5_114 .. "_columnless"]
  else
    r6_114 = modelIds["v4_mine_tunnel" .. r5_114]
  end
  if not r34_0[r1_114] then
    r34_0[r1_114] = {}
  end
  if not r34_0[r1_114][r2_114] then
    r34_0[r1_114][r2_114] = createObject(r6_114, minePosX + r1_114 * 6, minePosY + r2_114 * 6, minePosZ, 0, 0, 0)
    if isElement(r34_0[r1_114][r2_114]) then
      setElementInterior(r34_0[r1_114][r2_114], 0)
      setElementDimension(r34_0[r1_114][r2_114], currentMine)
    end
  elseif isElement(r34_0[r1_114][r2_114]) then
    setElementModel(r34_0[r1_114][r2_114], r6_114)
  end
  if isElement(r34_0[r1_114][r2_114]) then
    local r7_114 = setElementRotation
    local r8_114 = r34_0[r1_114][r2_114]
    local r9_114 = 0
    local r10_114 = 0
    local r11_114 = nil	-- notice: implicit variable refs by block#[15]
    if r4_114 >= 0.5 then
      r11_114 = 180
    else
      r11_114 = 0
    end
    r7_114(r8_114, r9_114, r10_114, r11_114 + r3_114)
  end
  if not r35_0[r1_114] then
    r35_0[r1_114] = {}
  end
  r35_0[r1_114][r2_114] = r5_114
  if not tunnelObjectRots[r1_114] then
    tunnelObjectRots[r1_114] = {}
  end
  tunnelObjectRots[r1_114][r2_114] = r3_114
end
function createJunction(r0_115, r1_115, r2_115, r3_115)
  -- line: [6294, 6349] id: 115
  local r4_115 = false
  if not junctionObjects[r0_115] then
    junctionObjects[r0_115] = {}
  end
  if r3_115 then
    r4_115 = "v4_mine_tunnel_left"
  else
    r4_115 = "v4_mine_tunnel_crossing"
  end
  r4_115 = modelIds[r4_115 .. r2_115]
  if not junctionObjects[r0_115][r1_115] then
    junctionObjects[r0_115][r1_115] = createObject(r4_115, minePosX + r0_115 * 6, minePosY + r1_115 * 6, minePosZ, 0, 0, r3_115 or 0)
    if isElement(junctionObjects[r0_115][r1_115]) then
      setElementInterior(junctionObjects[r0_115][r1_115], 0)
      setElementDimension(junctionObjects[r0_115][r1_115], currentMine)
    end
  elseif isElement(junctionObjects[r0_115][r1_115]) then
    setElementModel(junctionObjects[r0_115][r1_115], r4_115)
  end
  if isElement(junctionObjects[r0_115][r1_115]) then
    setElementRotation(junctionObjects[r0_115][r1_115], 0, 0, r3_115 or 0)
  end
  if threeJunctionsAt[r0_115] then
    threeJunctionsAt[r0_115][r1_115] = nil
  end
  if r3_115 then
    if not threeJunctionRots[r0_115] then
      threeJunctionRots[r0_115] = {}
    end
    threeJunctionRots[r0_115][r1_115] = r3_115
    if not threeJunctionsAt[r0_115] then
      threeJunctionsAt[r0_115] = {}
    end
    threeJunctionsAt[r0_115][r1_115] = prad(r3_115)
  elseif threeJunctionsAt[r0_115] and not next(threeJunctionsAt[r0_115]) then
    threeJunctionsAt[r0_115] = nil
    if threeJunctionRots[r0_115] then
      threeJunctionRots[r0_115][r1_115] = nil
    end
  end
end
local r103_0 = {}
local r104_0 = {}
local r105_0 = {}
function clearRandomMDVD()
  -- line: [6357, 6361] id: 116
  r103_0 = {}
  r104_0 = {}
  r105_0 = {}
end
function generateRandomMDVD(r0_117, r1_117, r2_117)
  -- line: [6363, 6391] id: 117
  if r103_0[r0_117] and r104_0[r0_117] then
    for r6_117, r7_117 in pairs(baseVertexClusters) do
      for r11_117 = 1, #r7_117, 1 do
        local r12_117 = r7_117[r11_117]
        r2_117[r12_117] = r104_0[r0_117][r12_117]
        r1_117[r12_117] = r103_0[r0_117][r12_117]
      end
    end
  else
    r104_0[r0_117] = {}
    r103_0[r0_117] = {}
    for r6_117, r7_117 in pairs(baseVertexClusters) do
      local r8_117 = math.random() * wallMinimumDepth
      local r9_117 = wallMaximumDepth - math.random() * wallMinimumDepth
      for r13_117 = 1, #r7_117, 1 do
        local r14_117 = r7_117[r13_117]
        r2_117[r14_117] = math.max(0, r8_117)
        r1_117[r14_117] = math.max(0, r9_117)
        r104_0[r0_117][r14_117] = r2_117[r14_117]
        r103_0[r0_117][r14_117] = r1_117[r14_117]
      end
    end
  end
end
function processZoneDistance(r0_118, r1_118, r2_118, r3_118, r4_118)
  -- line: [6393, 6427] id: 118
  local r5_118 = r1_118[r4_118]
  if not r105_0[r0_118] then
    r105_0[r0_118] = {}
  end
  if not r105_0[r0_118][r4_118] then
    r105_0[r0_118][r4_118] = {}
  end
  for r9_118, r10_118 in pairs(baseVertexClusters) do
    local r11_118 = r32_0[r9_118][r4_118]
    if r11_118 > 0 then
      local r12_118 = r3_118[r9_118]
      local r13_118 = r2_118[r9_118]
      local r15_118 = r1_118[r25_0[r9_118][5]] * (1 - r11_118) + r5_118 * r11_118
      if r12_118 < r15_118 then
        if not r105_0[r0_118][r4_118][r9_118] then
          r105_0[r0_118][r4_118][r9_118] = math.random()
        end
        r12_118 = r15_118 + r105_0[r0_118][r4_118][r9_118] * wallMinimumDepth
      end
      for r19_118 = 1, #r10_118, 1 do
        r3_118[r10_118[r19_118]] = math.min(r13_118, r12_118)
      end
    end
  end
end
function calculateSurfaceNormal(r0_119, r1_119, r2_119)
  -- line: [6429, 6451] id: 119
  local r3_119 = r1_119[1] - r0_119[1]
  local r4_119 = r1_119[2] - r0_119[2]
  local r5_119 = r1_119[3] - r0_119[3]
  local r6_119 = r2_119[1] - r0_119[1]
  local r7_119 = r2_119[2] - r0_119[2]
  local r8_119 = r2_119[3] - r0_119[3]
  local r9_119 = r4_119 * r8_119 - r5_119 * r7_119
  local r10_119 = r5_119 * r6_119 - r3_119 * r8_119
  local r11_119 = r3_119 * r7_119 - r4_119 * r6_119
  local r12_119 = math.sqrt(r9_119 * r9_119 + r10_119 * r10_119 + r11_119 * r11_119)
  if r12_119 ~= 0 then
    r9_119 = r9_119 / r12_119
    r10_119 = r10_119 / r12_119
    r11_119 = r11_119 / r12_119
  end
  return r9_119, r10_119, r11_119
end
function computeLineDistance(r0_120, r1_120, r2_120, r3_120, r4_120, r5_120, r6_120, r7_120, r8_120)
  -- line: [6453, 6465] id: 120
  local r9_120 = getDistanceBetweenPoints3D(r6_120, r7_120, r8_120, r3_120, r4_120, r5_120)
  local r10_120 = (r6_120 - r3_120) / r9_120
  local r11_120 = (r7_120 - r4_120) / r9_120
  local r12_120 = (r8_120 - r5_120) / r9_120
  local r13_120 = (r0_120 - r3_120) * r10_120 + (r1_120 - r4_120) * r11_120 + (r2_120 - r5_120) * r12_120
  local r14_120 = r3_120 + r13_120 * r10_120
  local r15_120 = r4_120 + r13_120 * r11_120
  local r16_120 = r5_120 + r13_120 * r12_120
  return getDistanceBetweenPoints3D(r14_120, r15_120, r16_120, r0_120, r1_120, r2_120), r14_120, r15_120, r16_120
end
function checkCoroutineTime()
  -- line: [6469, 6480] id: 121
  if coroutine.running() and r10_0 then
    local r0_121 = getTickCount() - r9_0
    if 0 < getTickCount() - r10_0 and r0_121 < 4000 then
      coroutine.yield()
    end
  end
end
function generateOpenShaftDff(r0_122, r1_122, r2_122)
  -- line: [6482, 6638] id: 122
  local r3_122 = r2_122 or r57_0
  if not r1_122 then
    r0_122 = r57_0 or r0_122
  end
  openShaftDirty[r0_122] = nil
  if openShaftLoaded[r0_122] then
    removeFromDffExportQueue(r0_122)
    table.insert(dffExportQueue, {
      shaftId = r0_122,
      exportStage = 0,
    })
    return true
  end
  if r3_122 then
    checkCoroutineTime()
  end
  local r4_122 = {}
  local r5_122 = {}
  generateRandomMDVD(r0_122, r5_122, r4_122)
  for r9_122 = 1, wallBlockCount, 1 do
    processZoneDistance(r0_122, openShaftDepths[r0_122], r5_122, r4_122, r9_122)
    if r3_122 then
      checkCoroutineTime()
    end
  end
  local r6_122 = wallMaximumDepth
  for r10_122 = 1, wallVertexCount, 1 do
    r6_122 = math.min(r6_122, r4_122[r10_122])
  end
  if r6_122 > 0 then
    for r10_122 = 1, wallVertexCount, 1 do
      r4_122[r10_122] = math.max(0, r4_122[r10_122] - r6_122)
    end
    openShaftLengths[r0_122] = openShaftLengths[r0_122] + r6_122
    for r10_122 = 1, wallBlockCount, 1 do
      openShaftDepths[r0_122][r10_122] = openShaftDepths[r0_122][r10_122] - r6_122
    end
  end
  if r3_122 then
    checkCoroutineTime()
  end
  local r7_122 = {}
  local r8_122 = {}
  local r9_122 = {}
  local r10_122 = shaftRotations[r0_122][3]
  local r11_122 = shaftRotations[r0_122][4]
  for r15_122 = 1, wallVertexCount, 1 do
    local r16_122, r17_122 = unpack(r25_0[r15_122])
    r16_122 = r16_122 / wallTextureWidth
    r17_122 = r17_122 / wallTextureHeight
    local r18_122 = (r16_122 - 0.5) * wallMeshWidth
    local r19_122 = r4_122[r15_122]
    r7_122[r15_122] = {
      0 + r18_122 * r11_122 + r19_122 * r10_122,
      0 - r18_122 * r10_122 + r19_122 * r11_122,
      0 + r17_122 * wallMeshHeight,
      0,
      -r16_122,
      -r17_122
    }
    if r3_122 then
      checkCoroutineTime()
    end
  end
  for r15_122 = 1, wallVertexCount, 3 do
    r9_122[r15_122] = {
      calculateSurfaceNormal(r7_122[r15_122], r7_122[r15_122 + 1], r7_122[r15_122 + 2])
    }
    if r3_122 then
      checkCoroutineTime()
    end
  end
  for r15_122 in pairs(r27_0) do
    local r16_122 = 0
    local r17_122 = 0
    local r18_122 = 0
    for r22_122 = 1, #r27_0[r15_122], 1 do
      local r24_122 = r9_122[r27_0[r15_122][r22_122]]
      r16_122 = r16_122 + r24_122[1]
      r17_122 = r17_122 + r24_122[2]
      r18_122 = r18_122 + r24_122[3]
      if r3_122 then
        checkCoroutineTime()
      end
    end
    local r19_122 = math.sqrt(r16_122 * r16_122 + r17_122 * r17_122 + r18_122 * r18_122)
    r8_122[r15_122] = {
      -r16_122 / r19_122,
      -r17_122 / r19_122,
      -r18_122 / r19_122
    }
    if r3_122 then
      checkCoroutineTime()
    end
  end
  shaftPositions[r0_122] = {
    minePosX + shaftCoords[r0_122][1] * 6 + (openShaftLengths[r0_122] - 3) * r10_122,
    minePosY + shaftCoords[r0_122][2] * 6 + (openShaftLengths[r0_122] - 3) * r11_122
  }
  if r3_122 then
    checkCoroutineTime()
  end
  if not r1_122 then
    removeFromDffExportQueue(r0_122)
    table.insert(dffExportQueue, {
      shaftId = r0_122,
      vertexData = r7_122,
      vertexNormals = r8_122,
      exportStage = 0,
      exportBuffer = {},
      exportSize = 0,
      numVertices = 0,
      numTriangles = 0,
    })
  end
  r53_0[r0_122] = getTickCount()
  collectgarbage()
  return true
end

function processDffExportQueue()
	local currentItem = dffExportQueue[1]

	if currentItem then
		currentItem.exportStage = currentItem.exportStage + 1

		if openShaftLoaded[currentItem.shaftId] then
			if currentItem.exportStage < 10 then
				currentItem.exportStage = 10
				currentItem.exportBuffer = nil
			end
		end

		local cacheFile = "cache/" .. currentItem.shaftId .. ".see"

		-- Remap vertex indices & calculate mesh center
		if currentItem.exportStage == 1 then
			local vertexCount = 0
			local vertexIndices = {}

			openShaftLoaded[currentItem.shaftId] = nil
			openShaftExporting[currentItem.shaftId] = true

			local sumX = 0
			local sumY = 0
			local sumZ = 0

			for vertexId in pairs(baseVertexClusters) do
				local vertexData = currentItem.vertexData[vertexId]

				sumX = sumX + vertexData[1]
				sumY = sumY + vertexData[2]
				sumZ = sumZ + vertexData[3]

				vertexIndices[vertexId] = vertexCount
				vertexCount = vertexCount + 1

				checkCoroutineTime()
			end

			currentItem.vertexIds = vertexIndices

			currentItem.centerX = sumX / vertexCount
			currentItem.centerY = sumY / vertexCount
			currentItem.centerZ = sumZ / vertexCount

			currentItem.numVertices = vertexCount
			currentItem.numTriangles = math.floor(wallVertexCount / 3)

			currentItem.exportSize = 8 + 32 * currentItem.numVertices + 16 + 8 * currentItem.numTriangles
		-- Write header and some structs
		elseif currentItem.exportStage == 2 then
			currentItem.exportBuffer[1] = "\16\0\0\0"

			currentItem.exportBuffer[2] = convertUInt32(456 + currentItem.exportSize)
			currentItem.exportBuffer[3] = ("\255\255\3\24\1\0\0\0\12\0\0\0\255\255\3\24\1\0\0\0\0\0\0\0\0\0\0\0\14\0\0\0\104\0\0\0\255\255\3\24\1\0\0\0\60\0\0\0\255\255\3\24\1\0\0\0\0\0\128\63\0\0\0\0\0\0\0\0\0\0\0\0\0\0\128\63\0\0\0\0\0\0\0\0\0\0\0\0\0\0\128\63\0\0\0\0\0\0\0\0\0\0\0\0\255\255\255\255\0\0\0\0\3\0\0\0\20\0\0\0\255\255\3\24\254\242\83\2\8\0\0\0\255\255\3\24Plane\0\0\0\26\0\0\0")
			checkCoroutineTime()

			currentItem.exportBuffer[4] = convertUInt32(240 + currentItem.exportSize)
			currentItem.exportBuffer[5] = ("\255\255\3\24\1\0\0\0\4\0\0\0\255\255\3\24\1\0\0\0\15\0\0\0")
			checkCoroutineTime()

			currentItem.exportBuffer[6] = convertUInt32(212 + currentItem.exportSize)
			currentItem.exportBuffer[7] = ("\255\255\3\24\1\0\0\0")
			checkCoroutineTime()

			currentItem.exportBuffer[8] = convertUInt32(16 + currentItem.exportSize)
			currentItem.exportBuffer[9] = ("\255\255\3\24\118\0\0\0")
			checkCoroutineTime()

			currentItem.exportBuffer[10] = convertUInt32(currentItem.numTriangles)
			currentItem.exportBuffer[11] = convertUInt32(currentItem.numVertices)
			currentItem.exportBuffer[12] = ("\1\0\0\0")
			checkCoroutineTime()
		-- Write texture coordinates
		elseif currentItem.exportStage == 3 then
			for vertexId in pairs(baseVertexClusters) do
				local vertexData = currentItem.vertexData[vertexId]

				table.insert(currentItem.exportBuffer, convertFloat32(vertexData[5])) -- U
				table.insert(currentItem.exportBuffer, convertFloat32(vertexData[6])) -- V

				checkCoroutineTime()
			end
		-- Write faces
		elseif currentItem.exportStage == 4 then
			for i = 1, wallVertexCount, 3 do
				table.insert(currentItem.exportBuffer, convertUInt16(currentItem.vertexIds[baseVertexNeighbors[i + 1]])) -- Vertex 2
				table.insert(currentItem.exportBuffer, convertUInt16(currentItem.vertexIds[baseVertexNeighbors[i + 2]])) -- Vertex 1
				checkCoroutineTime()

				table.insert(currentItem.exportBuffer, convertUInt16(0)) -- Material ID
				table.insert(currentItem.exportBuffer, convertUInt16(currentItem.vertexIds[baseVertexNeighbors[i]])) -- Vertex 3
				checkCoroutineTime()
			end
		-- Write morph targets
		elseif currentItem.exportStage == 5 then
			local sphereRadius = 0

			for vertexId in pairs(baseVertexClusters) do
				local vertexData = currentItem.vertexData[vertexId]
				local vertexDistance = getDistanceBetweenPoints3D(currentItem.centerX, currentItem.centerY, currentItem.centerZ, vertexData[1], vertexData[2], vertexData[3])

				if vertexDistance > sphereRadius then
					sphereRadius = vertexDistance
				end

				checkCoroutineTime()
			end

			table.insert(currentItem.exportBuffer, convertFloat32(currentItem.centerX))
			table.insert(currentItem.exportBuffer, convertFloat32(currentItem.centerY))
			table.insert(currentItem.exportBuffer, convertFloat32(currentItem.centerZ))
			table.insert(currentItem.exportBuffer, convertFloat32(sphereRadius))
			table.insert(currentItem.exportBuffer, "\1\0\0\0\1\0\0\0") -- hasPositions & hasNormals

			checkCoroutineTime()
		-- Write vertices
		elseif currentItem.exportStage == 6 then
			for vertexId in pairs(baseVertexClusters) do
				local vertexData = currentItem.vertexData[vertexId]

				table.insert(currentItem.exportBuffer, convertFloat32(vertexData[1]))
				table.insert(currentItem.exportBuffer, convertFloat32(vertexData[2]))
				table.insert(currentItem.exportBuffer, convertFloat32(vertexData[3]))

				checkCoroutineTime()
			end
		-- Write normals
		elseif currentItem.exportStage == 7 then
			for vertexId in pairs(baseVertexClusters) do
				local vertexNormal = currentItem.vertexNormals[vertexId]

				table.insert(currentItem.exportBuffer, convertFloat32(vertexNormal[1]))
				table.insert(currentItem.exportBuffer, convertFloat32(vertexNormal[2]))
				table.insert(currentItem.exportBuffer, convertFloat32(vertexNormal[3]))

				checkCoroutineTime()
			end
		-- Write material list & extension
		elseif currentItem.exportStage == 8 then
			currentItem.exportBuffer[#currentItem.exportBuffer + 1] = ("\8\0\0\0\160\0\0\0\255\255\3\24\1\0\0\0\8\0\0\0\255\255\3\24\1\0\0\0\255\255\255\255\7\0\0\0\128\0\0\0\255\255\3\24\1\0\0\0\28\0\0\0\255\255\3\24\0\0\0\0\255\255\255\255\1\0\0\0\1\0\0\0\0\0\128\63\0\0\0\63\0\0\0\63\6\0\0\0\64\0\0\0\255\255\3\24\1\0\0\0\4\0\0\0\255\255\3\24\0\0\0\0\2\0\0\0\8\0\0\0\255\255\3\24wall\0\0\0\0\2\0\0\0\4\0\0\0\255\255\3\24\0\0\0\0\3\0\0\0\0\0\0\0\255\255\3\24\3\0\0\0\0\0\0\0\255\255\3\24\3\0\0\0\0\0\0\0\255\255\3\24\20\0\0\0\40\0\0\0\255\255\3\24\1\0\0\0\16\0\0\0\255\255\3\24\0\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\3\0\0\0\0\0\0\0\255\255\3\24\3\0\0\0\0\0\0\0\255\255\3\24")
			currentItem.exportBuffer = table.concat(currentItem.exportBuffer)
		-- Save to file
		elseif currentItem.exportStage == 9 then
			local fileHandle = fileCreate(cacheFile)

			if fileHandle then
				fileWrite(fileHandle, currentItem.exportBuffer)
				fileClose(fileHandle)
			end

			openShaftLoaded[currentItem.shaftId] = true
		-- Get a free model and apply the base collision and texture
		elseif currentItem.exportStage == 10 then
			currentItem.modelId = poolGetModel()

			if currentItem.modelId then
				engineImportTXD(shaftWallTxd, currentItem.modelId)
				engineReplaceCOL(shaftWallCol, currentItem.modelId)
			end

			checkCoroutineTime()
		-- Load the DFF either from the cache or the buffer
		elseif currentItem.exportStage == 11 then
			currentItem.dffData = engineLoadDFF(currentItem.exportBuffer or cacheFile)

			if currentItem.dffData then
				engineReplaceModel(currentItem.dffData, currentItem.modelId)
			end

			currentItem.exportBuffer = nil
		-- Create the generated object
		elseif currentItem.exportStage == 12 then
			local shaftPosition = shaftPositions[currentItem.shaftId]

			if not currentItem.objectElement then
				local objectElement = createObject(currentItem.modelId, shaftPosition[1], shaftPosition[2], minePosZ)

				if isElement(objectElement) then
					setElementInterior(objectElement, 0)
					setElementDimension(objectElement, currentMine)
					setElementCollisionsEnabled(objectElement, false)
				end

				currentItem.objectElement = objectElement
			end
		-- Update datas and queue
		elseif currentItem.exportStage == 13 then
			local shaftPosition = shaftPositions[currentItem.shaftId]

			if isElement(openShaftDFFs[currentItem.shaftId]) then
				destroyElement(openShaftDFFs[currentItem.shaftId])
			end

			if openShaftModels[currentItem.shaftId] then
				poolFreeModel(openShaftModels[currentItem.shaftId])
			end

			if isElement(openShaftObjects[currentItem.shaftId]) then
				destroyElement(openShaftObjects[currentItem.shaftId])
			end

			checkCoroutineTime()

			openShaftDFFs[currentItem.shaftId] = currentItem.dffData
			openShaftModels[currentItem.shaftId] = currentItem.modelId
			openShaftObjects[currentItem.shaftId] = currentItem.objectElement
			openShaftExporting[currentItem.shaftId] = nil

			if isElement(currentItem.objectElement) then
				setElementPosition(currentItem.objectElement, shaftPosition[1], shaftPosition[2], minePosZ)

				if currentItem.shaftId == currentActiveOpenShaft then
					setElementInterior(openShaftObjects[currentActiveOpenShaft], 0)
					setElementDimension(openShaftObjects[currentActiveOpenShaft], 0)
				end
			end

			table.remove(dffExportQueue, 1)
		end
	end

	collectgarbage()
end

function convertFloat32(r0_124)
  -- line: [6866, 6906] id: 124
  if r0_124 == 0 then
    return string.char(0, 0, 0, 0)
  elseif r0_124 ~= r0_124 then
    return string.char(255, 255, 255, 255)
  else
    local r1_124 = 0
    if r0_124 < 0 then
      r1_124 = 128
      r0_124 = -r0_124
    end
    local r2_124, r3_124 = math.frexp(r0_124)
    r3_124 = r3_124 + 127
    if r3_124 <= 0 then
      r2_124 = math.ldexp(r2_124, r3_124 - 1)
      r3_124 = 0
    elseif r3_124 > 0 then
      if r3_124 >= 255 then
        return string.char(r1_124 + 127, 128, 0, 0)
      elseif r3_124 == 1 then
        r3_124 = 0
      else
        r2_124 = r2_124 * 2 - 1
        r3_124 = r3_124 - 1
      end
    end
    r2_124 = math.floor(math.ldexp(r2_124, 23) + 0.5)
    return string.char(r2_124 % 256, math.floor(r2_124 / 256) % 256, r3_124 % 2 * 128 + math.floor(r2_124 / 65536), r1_124 + math.floor(r3_124 / 2))
  end
end
function convertUInt16(r0_125)
  -- line: [6908, 6912] id: 125
  return string.char(r0_125 % 256) .. string.char(math.floor(r0_125 / 256) % 256)
end
function convertUInt32(r0_126)
  -- line: [6914, 6920] id: 126
  return string.char(r0_126 % 256) .. string.char(math.floor(r0_126 / 256) % 256) .. string.char(math.floor(r0_126 / 65536) % 256) .. string.char(math.floor(r0_126 / 16777216) % 256)
end
function calculateBase()
  -- line: [6924, 7122] id: 127
  if r24_0 then
    return 
  end
  local r0_127 = wallTextureWidth / wallVertexNumX
  local r1_127 = wallTextureHeight / wallVertexNumY
  for r5_127 = 1, wallVertexNumX, 1 do
    checkMineLoadingTime()
    for r9_127 = 1, wallVertexNumY, 1 do
      table.insert(r25_0, {
        r0_127 * r5_127,
        r1_127 * (r9_127 - 1),
        r5_127,
        r9_127
      })
      table.insert(r25_0, {
        r0_127 * (r5_127 - 1),
        r1_127 * (r9_127 - 1),
        r5_127,
        r9_127
      })
      table.insert(r25_0, {
        r0_127 * (r5_127 - 1),
        r1_127 * r9_127,
        r5_127,
        r9_127
      })
      table.insert(r25_0, {
        r0_127 * r5_127,
        r1_127 * (r9_127 - 1),
        r5_127,
        r9_127
      })
      table.insert(r25_0, {
        r0_127 * (r5_127 - 1),
        r1_127 * r9_127,
        r5_127,
        r9_127
      })
      table.insert(r25_0, {
        r0_127 * r5_127,
        r1_127 * r9_127,
        r5_127,
        r9_127
      })
      checkMineLoadingTime()
    end
  end
  wallVertexCount = #r25_0
  for r5_127 = 1, wallVertexCount, 3 do
    checkMineLoadingTime()
    for r9_127 = 0, 2, 1 do
      r26_0[r5_127 + r9_127] = r5_127
    end
  end
  for r5_127 = 1, wallVertexCount, 1 do
    local r6_127 = false
    local r7_127 = false
    for r11_127 = 1, wallVertexCount, 1 do
      local r12_127 = getDistanceBetweenPoints2D(r25_0[r5_127][1], r25_0[r5_127][2], r25_0[r11_127][1], r25_0[r11_127][2])
      if not r7_127 or r12_127 < r7_127 then
        r7_127 = r12_127
        r6_127 = r11_127
      end
      checkMineLoadingTime()
    end
    loaderText = "Bányafal előkészítése (" .. math.floor(r5_127 / wallVertexCount * 100) .. "%)"
    if not r27_0[r6_127] then
      r27_0[r6_127] = {}
    end
    baseVertexNeighbors[r5_127] = r6_127
    if not baseVertexClusters[r6_127] then
      baseVertexClusters[r6_127] = {
        r5_127
      }
    else
      table.insert(baseVertexClusters[r6_127], r5_127)
    end
    checkMineLoadingTime()
  end
  for r5_127 = 1, wallVertexCount, 1 do
    local r6_127 = r26_0[r5_127]
    local r7_127 = baseVertexNeighbors[r5_127]
    for r11_127 = #r27_0[r7_127], 1, -1 do
      checkMineLoadingTime()
      if r27_0[r7_127][r11_127] == r6_127 then
        table.remove(r27_0[r7_127], r11_127)
      end
    end
    table.insert(r27_0[r7_127], r6_127)
  end
  local r2_127 = wallVertexNumX / wallBlockNumX
  local r3_127 = wallVertexNumY / wallBlockNumY
  for r7_127 in pairs(baseVertexClusters) do
    local r8_127 = math.ceil(r25_0[r7_127][3] / r2_127) + (math.ceil(r25_0[r7_127][4] / r3_127) - 1) * wallBlockNumY
    if not r30_0[r8_127] then
      r30_0[r8_127] = {
        r7_127
      }
    else
      table.insert(r30_0[r8_127], r7_127)
    end
    r25_0[r7_127][5] = r8_127
  end
  for r7_127 = 1, wallBlockCount, 1 do
    checkMineLoadingTime()
    r31_0[r7_127] = {
      r30_0[r7_127][1],
      r30_0[r7_127][1],
      r30_0[r7_127][1],
      r30_0[r7_127][1]
    }
    local r8_127 = 0
    local r9_127 = 0
    local r10_127 = 0
    for r14_127 = 1, #r30_0[r7_127], 1 do
      local r15_127 = r30_0[r7_127][r14_127]
      local r16_127 = r25_0[r15_127]
      local r17_127 = r25_0[r31_0[r7_127][1]]
      local r18_127 = r25_0[r31_0[r7_127][2]]
      local r19_127 = r25_0[r31_0[r7_127][3]]
      local r20_127 = r25_0[r31_0[r7_127][4]]
      if r16_127[3] < r17_127[3] or r16_127[4] < r17_127[4] then
        r31_0[r7_127][1] = r15_127
      end
      if r18_127[3] < r16_127[3] or r16_127[4] < r18_127[4] then
        r31_0[r7_127][2] = r15_127
      end
      if r16_127[3] < r19_127[3] or r19_127[4] < r16_127[4] then
        r31_0[r7_127][3] = r15_127
      end
      if r20_127[3] < r16_127[3] or r20_127[4] < r16_127[4] then
        r31_0[r7_127][4] = r15_127
      end
      checkMineLoadingTime()
      r8_127 = r8_127 + r16_127[1] / wallTextureWidth
      r9_127 = r9_127 + r16_127[2] / wallTextureHeight
      r10_127 = r10_127 + 1
    end
    r33_0[r7_127] = {
      r8_127 / r10_127,
      r9_127 / r10_127
    }
  end
  for r7_127 in pairs(baseVertexClusters) do
    local r8_127 = r25_0[r7_127]
    local r9_127 = r8_127[5]
    local r10_127 = r8_127[1] / wallTextureWidth * wallMeshWidth
    local r11_127 = r8_127[2] / wallTextureHeight * wallMeshHeight
    r32_0[r7_127] = {}
    for r15_127 = 1, wallBlockCount, 1 do
      if r15_127 == r9_127 then
        r32_0[r7_127][r15_127] = 1
      else
        local r16_127 = r31_0[r15_127][1]
        local r17_127 = r31_0[r15_127][4]
        local r22_127 = math.max(r25_0[r16_127][1] / wallTextureWidth * wallMeshWidth - r10_127, 0, r10_127 - r25_0[r17_127][1] / wallTextureWidth * wallMeshWidth)
        local r23_127 = math.max(r25_0[r16_127][2] / wallTextureHeight * wallMeshHeight - r11_127, 0, r11_127 - r25_0[r17_127][2] / wallTextureHeight * wallMeshHeight)
        r32_0[r7_127][r15_127] = 1 - math.sqrt((r22_127 * r22_127 + r23_127 * r23_127)) / 0.5
      end
      checkMineLoadingTime()
    end
    checkMineLoadingTime()
  end
  loaderText = false
  r24_0 = true
end
function createSortingMachine()
  -- line: [7126, 7198] id: 128
  if not mineMachineData.mineMachine then
    mineMachineData.mineMachine = createObject(modelIds.v4_mine_machine, minePosX - 13.7135, minePosY + 7.6567, minePosZ + 1.5229, 0, 0, 180)
    if isElement(mineMachineData.mineMachine) then
      setElementInterior(mineMachineData.mineMachine, 0)
      setElementDimension(mineMachineData.mineMachine, currentMine)
    end
  end
  if not mineMachineData.mineMachine2 then
    mineMachineData.mineMachine2 = createObject(modelIds.v4_mine_machine2, minePosX - 13.7135, minePosY + 7.6567, minePosZ + 1.5229, 0, 0, 180)
    if isElement(mineMachineData.mineMachine2) then
      setElementInterior(mineMachineData.mineMachine2, 0)
      setElementDimension(mineMachineData.mineMachine2, currentMine)
    end
  end
  if not mineMachineData.mineMachine3 then
    mineMachineData.mineMachine3 = createObject(modelIds.v4_mine_machine_crusher, minePosX - 13.3831, minePosY + 7.6567, minePosZ + 2.6847, 0, 0, 180)
    if isElement(mineMachineData.mineMachine3) then
      setElementInterior(mineMachineData.mineMachine3, 0)
      setElementDimension(mineMachineData.mineMachine3, currentMine)
    end
  end
  if not mineMachineData.mineSilo then
    mineMachineData.mineSilo = createObject(modelIds.v4_mine_silo, minePosX - 20.9844, minePosY + 9.342, minePosZ + 1.9068, 0, 0, 0)
    if isElement(mineMachineData.mineSilo) then
      setElementInterior(mineMachineData.mineSilo, 0)
      setElementDimension(mineMachineData.mineSilo, currentMine)
    end
  end
  if not mineMachineData.motorSound then
    mineMachineData.motorSound = playSound3D("files/sounds/machinemotor.wav", minePosX - 12.8197, minePosY + 7.6608, minePosZ + 0.6527, true)
    if isElement(mineMachineData.motorSound) then
      setElementInterior(mineMachineData.motorSound, 0)
      setElementDimension(mineMachineData.motorSound, currentMine)
      setSoundVolume(mineMachineData.motorSound, 0)
      setSoundMaxDistance(mineMachineData.motorSound, 80)
    end
  end
  if not mineMachineData.beltSound then
    mineMachineData.beltSound = playSound3D("files/sounds/machinebelt.wav", minePosX - 12.8377, minePosY + 3.556, minePosZ + 1.1937, true)
    if isElement(mineMachineData.beltSound) then
      setElementInterior(mineMachineData.beltSound, 0)
      setElementDimension(mineMachineData.beltSound, currentMine)
      setSoundVolume(mineMachineData.beltSound, 0)
      setSoundMaxDistance(mineMachineData.beltSound, 45)
    end
  end
  if not mineMachineData.rockSound then
    mineMachineData.rockSound = playSound3D("files/sounds/machinerock.wav", minePosX - 20.4574, minePosY + 7.4428, minePosZ + 1.3851, true)
    if isElement(mineMachineData.rockSound) then
      setElementInterior(mineMachineData.rockSound, 0)
      setElementDimension(mineMachineData.rockSound, currentMine)
      setSoundVolume(mineMachineData.rockSound, 0)
      setSoundMaxDistance(mineMachineData.rockSound, 80)
    end
  end
  if not mineMachineData.vibrationSound then
    mineMachineData.vibrationSound = playSound3D("files/sounds/machinevibration.wav", minePosX - 20.4574, minePosY + 7.4428, minePosZ + 1.3851, true)
    if isElement(mineMachineData.vibrationSound) then
      setElementInterior(mineMachineData.vibrationSound, 0)
      setElementDimension(mineMachineData.vibrationSound, currentMine)
      setSoundVolume(mineMachineData.vibrationSound, 0)
      setSoundMaxDistance(mineMachineData.vibrationSound, 80)
    end
  end
end
function refreshMineMachineSound()
  -- line: [7200, 7226] id: 129
  local r0_129 = math.min(1, mineMachineData.machineRunProgress)
  local r1_129 = math.max(0, mineMachineData.machineRunProgress - 1)
  local r2_129 = math.min(1, r0_129 / 0.75) * 0.55 + 0.45
  local r3_129 = math.min(1, r0_129 / 0.25)
  if isElement(mineMachineData.motorSound) then
    setSoundSpeed(mineMachineData.motorSound, r2_129 + r1_129 * 1)
    setSoundVolume(mineMachineData.motorSound, r3_129 * 1.25 + r1_129 * 0.35)
  end
  if isElement(mineMachineData.beltSound) then
    setSoundSpeed(mineMachineData.beltSound, r2_129)
    setSoundVolume(mineMachineData.beltSound, r3_129 * 0.6)
  end
  if isElement(mineMachineData.vibrationSound) then
    setSoundSpeed(mineMachineData.vibrationSound, r2_129)
    setSoundVolume(mineMachineData.vibrationSound, r3_129 * 1.2)
  end
  if isElement(mineMachineData.rockSound) then
    setSoundSpeed(mineMachineData.rockSound, r2_129 * 1.75)
    local r4_129 = setSoundVolume
    local r5_129 = mineMachineData.rockSound
    local r6_129 = mineMachineData.sortingRocks
    if r6_129 then
      r6_129 = 1 
    else
      r6_129 = 0
    end
    r4_129(r5_129, r3_129 * r6_129 * 0.25)
  end
end
function spawnSorterOre(r0_130, r1_130)
  -- line: [7228, 7258] id: 130
  local r2_130 = createObject(modelIds.v4_mine_ore_debris, machinePosX, machinePosY, machinePosZ, 0, -6, 0)
  local r3_130 = createObject(modelIds.v4_mine_ore_debris2, machinePosX, machinePosY, machinePosZ, 0, -6, 0)
  if isElement(r3_130) then
    setElementInterior(r3_130, 0)
    setElementDimension(r3_130, currentMine)
  end
  table.insert(r96_0, {
    objectElement = r3_130,
    currentPosition = -2.849194,
    desiredPosition = 9.373499,
    animationProgress = 0,
  })
  if isElement(r2_130) then
    refreshOreShader(r2_130, r0_130)
    setElementInterior(r2_130, 0)
    setElementDimension(r2_130, currentMine)
  end
  table.insert(r96_0, {
    objectElement = r2_130,
    currentPosition = -2.849194,
    desiredPosition = oreTypes[r0_130].sorterOffset,
    animationProgress = 0,
    oreType = r0_130,
    oreAmount = r1_130,
  })
end
function checkOreBuffer(r0_131, r1_131)
  -- line: [7260, 7292] id: 131
  local r2_131 = oreTypes[r0_131]
  if 0 < r2_131.bufferContent and not r2_131.carriedBy then
    local r3_131 = math.min(1 - r2_131.boxContent, r2_131.bufferContent)
    if r3_131 > 0 then
      shouldRefreshBoxContent = true
      r2_131.bufferContent = r2_131.bufferContent - r3_131
      r2_131.boxContent = r2_131.boxContent + r3_131
      if r1_131 then
        r2_131.displayedBoxContent = r2_131.boxContent
      else
        local r4_131 = minePosX - 15.8384 - r2_131.sorterOffset
        local r5_131 = minePosY + 7.4428 - 1.0574
        local r6_131 = minePosZ + 1.7338 - 1.6562
        local r7_131 = playSound3D("files/sounds/orepour" .. math.random(1, 2) .. ".wav", r4_131, r5_131, r6_131, true)
        if isElement(r7_131) then
          setElementInterior(r7_131, 0)
          setElementDimension(r7_131, currentMine)
        end
        table.insert(r97_0, {
          r7_131,
          getTickCount() + r3_131 * 10000,
          0,
          r4_131,
          r5_131,
          r6_131
        })
      end
      return true
    end
  end
end
function refreshOreBoxScale(r0_132)
  -- line: [7294, 7310] id: 132
  local r1_132 = oreTypes[r0_132]
  if r1_132 then
    local r2_132 = r1_132.carriedBy
    if r2_132 then
      r2_132 = 0.75
    else
      r2_132 = 1
    end
    if isElement(r1_132.boxContentElement) then
      if r1_132.displayedBoxContent > 0.05 then
        setObjectScale(r1_132.boxContentElement, r2_132, r2_132, (0.085 + (r1_132.displayedBoxContent - 0.05) / 0.95 * 0.915) * r2_132)
      elseif r1_132.displayedBoxContent > 0 then
        setObjectScale(r1_132.boxContentElement, r2_132, r2_132, 0.085 * r1_132.displayedBoxContent / 0.05 * r2_132)
      else
        setObjectScale(r1_132.boxContentElement, r2_132, r2_132, 0)
      end
    end
  end
end
addMineEventHandler("syncMineOreItemOutput", root, function(r0_133, r1_133)
  -- line: [7313, 7334] id: 133
  local r2_133 = oreTypes[r1_133]
  if r2_133 then
    local r3_133 = nil
    local r4_133 = nil
    local r5_133 = nil
    if r2_133.ingotPosition then
      r3_133, r4_133, r5_133 = unpack(r2_133.ingotPosition)
    else
      r3_133, r4_133, r5_133 = unpack(r2_133.boxPosition)
    end
    local r6_133 = playSound3D("files/sounds/furnacedonepick.wav", r3_133, r4_133, r5_133 + 0.25)
    if isElement(r6_133) then
      setElementInterior(r6_133, 0)
      setElementDimension(r6_133, currentMine)
    end
    table.insert(r2_133.itemOutput, getTickCount())
  end
end)
addMineEventHandler("syncMineOreStorageRemove", root, function(r0_134, r1_134, r2_134, r3_134)
  -- line: [7338, 7375] id: 134
  local r4_134 = oreTypes[r1_134]
  if r4_134 then
    local r5_134 = nil
    local r6_134 = nil
    local r7_134 = nil
    if r4_134.foundryInputPosition then
      r5_134, r6_134, r7_134 = unpack(r4_134.foundryInputPosition)
    else
      r5_134, r6_134, r7_134 = unpack(r4_134.boxPosition)
    end
    local r8_134 = playSound3D("files/sounds/orepour" .. math.random(1, 2) .. ".wav", r5_134, r6_134, r7_134, true)
    if isElement(r8_134) then
      setElementInterior(r8_134, 0)
      setElementDimension(r8_134, currentMine)
    end
    local r9_134 = table.insert
    local r10_134 = r97_0
    local r11_134 = {}
    local r12_134 = r8_134
    local r13_134 = getTickCount() + r2_134 * 5000
    local r14_134 = 0
    local r15_134 = r5_134
    local r16_134 = r6_134
    local r17_134 = r7_134
    local r18_134 = r3_134 and source
    -- setlist for #11 failed
    table.insert(r97_0, {r8_134,getTickCount() + r2_134 * 5000 , 0, r5_134, r6_134, r7_134, r3_134 and source})
    if r3_134 and isElement(source) then
      setPedHeadingTo(source, r5_134, r6_134)
      setPedAnimation(source, "mining_box_pour", "crry_prtial", -1, true, false, false, false)
    end
    r4_134.boxContent = r4_134.boxContent - r2_134
    if r4_134.boxContent < 0 then
      r4_134.bufferContent = r4_134.bufferContent + r4_134.boxContent
      r4_134.boxContent = 0
    end
    shouldRefreshBoxContent = true
  end
end)
addMineEventHandler("syncMineFoundryStorage", root, function(r0_135, r1_135, r2_135)
  -- line: [7379, 7387] id: 135
  local r3_135 = oreTypes[r1_135]
  if r3_135 then
    r3_135.foundryContent = r2_135
  end
  shouldRefreshFoundryContent = true
end)
function syncOreBoxCarry(r0_136, r1_136)
  -- line: [7390, 7456] id: 136
  local r2_136 = oreTypes[r0_136]
  if r2_136 then
    local r3_136 = false
    exports.sPattach:detach(r2_136.boxElement)
    exports.sPattach:detach(r2_136.boxContentElement)
    if r2_136.carriedBy then
      if isElement(r2_136.boxElement) then
        setObjectScale(r2_136.boxElement, 1)
        setElementPosition(r2_136.boxElement, unpack(r2_136.boxPosition))
        setElementRotation(r2_136.boxElement, 0, 0, 0)
        setElementInterior(r2_136.boxElement, 0)
        setElementDimension(r2_136.boxElement, currentMine)
      end
      if isElement(r2_136.boxContentElement) then
        setElementPosition(r2_136.boxContentElement, unpack(r2_136.boxPosition))
        setElementRotation(r2_136.boxContentElement, 0, 0, 0)
        setElementInterior(r2_136.boxContentElement, 0)
        setElementDimension(r2_136.boxContentElement, currentMine)
      end
      if isElement(r2_136.carriedBy) then
        r3_136 = r2_136.carriedBy
        r88_0[r3_136] = nil
        setPedHeadingTo(r3_136, unpack(r2_136.boxPosition))
      end
    end
    r2_136.carriedBy = r1_136
    if r3_136 and r3_136 ~= r1_136 then
      processTablet(r3_136)
    end
    if r1_136 then
      r88_0[r1_136] = r0_136
      if isElement(r2_136.boxElement) then
        exports.sPattach:attach(r2_136.boxElement, r1_136, 24, 0.13359006135468, 0.0069286946121183, 0.074790295543729, 0, 0, 0)
        exports.sPattach:setRotationQuaternion(r2_136.boxElement, {
          0.59285355717957,
          0.79791822465736,
          0.079090005564662,
          0.0748059992177
        })
        setObjectScale(r2_136.boxElement, 0.75)
      end
      processTablet(r1_136)
      if isElement(r2_136.boxContentElement) then
        exports.sPattach:attach(r2_136.boxContentElement, r1_136, 24, 0.13359006135468, 0.0069286946121183, 0.074790295543729, 0, 0, 0)
        exports.sPattach:setRotationQuaternion(r2_136.boxContentElement, {
          0.59285355717957,
          0.79791822465736,
          0.079090005564662,
          0.0748059992177
        })
      end
      setPedAnimation(r1_136, "carry", "crry_prtial", 0, true, false, false, true)
      setPedHeadingTo(r1_136, unpack(r2_136.boxPosition))
    elseif not r2_136.instantItem then
      checkOreBuffer(r0_136)
    end
    if not r2_136.instantItem then
      refreshOreBoxScale(r0_136)
    end
  end
end
addMineEventHandler("syncMineOreBoxCarry", root, function(r0_137, r1_137)
  -- line: [7459, 7490] id: 137
  local r2_137 = r88_0[source]
  if r2_137 then
    local r3_137, r4_137, r5_137 = unpack(oreTypes[r2_137].boxPosition)
    local r6_137 = playSound3D("files/sounds/boxdrop.mp3", r3_137, r4_137, r5_137)
    if isElement(r6_137) then
      setElementInterior(r6_137, 0)
      setElementDimension(r6_137, currentMine)
    end
    syncOreBoxCarry(r2_137)
    r88_0[source] = nil
  end
  if r1_137 then
    if isElement(source) and source ~= resourceRoot then
      local r3_137, r4_137, r5_137 = unpack(oreTypes[r1_137].boxPosition)
      local r6_137 = playSound3D("files/sounds/boxpick.mp3", r3_137, r4_137, r5_137)
      if isElement(r6_137) then
        setElementInterior(r6_137, 0)
        setElementDimension(r6_137, currentMine)
      end
      syncOreBoxCarry(r1_137, source)
    else
      syncOreBoxCarry(r1_137)
    end
  end
end)
addMineEventHandler("gotMineOpenShaftBomb", root, function(r0_138, r1_138)
  -- line: [7494, 7525] id: 138
  local r2_138, r3_138, r4_138 = getShaftBlockPosition(r1_138, math.ceil(wallBlockCount / 2))
  local r5_138 = shaftRotations[r1_138][3]
  local r6_138 = shaftRotations[r1_138][4]
  r2_138 = r2_138 - r5_138 * 0.25
  r3_138 = r3_138 - r6_138 * 0.25
  if not openShaftBombs[r1_138] then
    local r7_138 = createObject(modelIds.v4_mine_dynamite, r2_138, r3_138, r4_138, 0, 0, shaftRotations[r1_138][1] - 90)
    if isElement(r7_138) then
      setObjectScale(r7_138, 3)
      setElementInterior(r7_138, 0)
      setElementDimension(r7_138, currentMine)
    end
    local r8_138 = playSound3D("files/sounds/tntfuse.mp3", r2_138, r3_138, r4_138)
    if isElement(r8_138) then
      setElementInterior(r8_138, 0)
      setElementDimension(r8_138, currentMine)
    end
    openShaftBombs[r1_138] = {
      r7_138,
      r6_138,
      -r5_138,
      0,
      r2_138,
      r3_138,
      r4_138
    }
  end
  if source ~= resourceRoot then
    setPedHeadingTo(source, r2_138, r3_138)
  end
end)
addMineEventHandler("detonateMineOpenShaftBomb", root, function(r0_139, r1_139)
  -- line: [7529, 7546] id: 139
  local r2_139 = openShaftBombs[r1_139]
  if r2_139 then
    table.insert(bombDetonations, {
      r2_139[5],
      r2_139[6],
      r2_139[7],
      0
    })
    spawnSmokeExBg(r2_139[5], r2_139[6], r2_139[7], true)
    detonateDamage(r2_139[5], r2_139[6], r2_139[7])
    if isElement(r2_139[1]) then
      destroyElement(r2_139[1])
    end
    r2_139[1] = nil
  end
  openShaftBombs[r1_139] = nil
end)
addMineEventHandler("gotMineShaftBomb", root, function(r0_140, r1_140, r2_140, r3_140)
  -- line: [7550, 7598] id: 140
  if not shaftBombs[r1_140] then
    shaftBombs[r1_140] = {}
  end
  if not shaftBombs[r1_140][r2_140] then
    shaftBombs[r1_140][r2_140] = {}
  end
  local r4_140 = shaftRotations[r1_140][1]
  local r5_140 = shaftRotations[r1_140][3]
  local r6_140 = shaftRotations[r1_140][4]
  local r7_140 = shaftCoords[r1_140][1] * 6 + r5_140 * (r2_140 - 1) * 6
  local r8_140 = shaftCoords[r1_140][2] * 6 + r6_140 * (r2_140 - 1) * 6
  if r3_140 ~= 1 then
    r5_140 = -r5_140
    r6_140 = -r6_140
    r4_140 = r4_140 + 180
  end
  local r9_140 = minePosX + r7_140 - r6_140 * 1.45 + r5_140 * 0.5
  local r10_140 = minePosY + r8_140 + r5_140 * 1.45 + r6_140 * 0.5
  local r11_140 = minePosZ + 1.5
  if not shaftBombs[r1_140][r2_140][r3_140] then
    local r12_140 = createObject(modelIds.v4_mine_dynamite, r9_140, r10_140, r11_140, 0, 0, r4_140)
    if isElement(r12_140) then
      setObjectScale(r12_140, 3)
      setElementInterior(r12_140, 0)
      setElementDimension(r12_140, currentMine)
    end
    local r13_140 = playSound3D("files/sounds/tntfuse.mp3", r9_140, r10_140, r11_140)
    if isElement(r13_140) then
      setElementInterior(r13_140, 0)
      setElementDimension(r13_140, currentMine)
    end
    shaftBombs[r1_140][r2_140][r3_140] = {
      r12_140,
      r5_140,
      r6_140,
      0,
      r9_140,
      r10_140,
      r11_140
    }
  end
  if source ~= resourceRoot then
    setPedHeadingTo(source, r9_140, r10_140)
  end
end)
addMineEventHandler("detonateMineShaftBomb", root, function(r0_141, r1_141, r2_141, r3_141)
  -- line: [7602, 7627] id: 141
  local r4_141 = shaftBombs[r1_141] and shaftBombs[r1_141][r2_141] and shaftBombs[r1_141][r2_141][r3_141]
  if r4_141 then
    table.insert(bombDetonations, {
      r4_141[5],
      r4_141[6],
      r4_141[7],
      0
    })
    spawnSmokeExBg(r4_141[5], r4_141[6], r4_141[7], true)
    detonateDamage(r4_141[5], r4_141[6], r4_141[7])
    if isElement(r4_141[1]) then
      destroyElement(r4_141[1])
    end
    r4_141[1] = nil
  end
  if shaftBombs[r1_141][r2_141] and shaftBombs[r1_141][r2_141][r3_141] then
    shaftBombs[r1_141][r2_141][r3_141] = nil
  end
  if not next(shaftBombs[r1_141][r2_141]) then
    shaftBombs[r1_141][r2_141] = nil
    if not next(shaftBombs[r1_141]) then
      shaftBombs[r1_141] = nil
    end
  end
end)
addMineEventHandler("gotMineThreeJunctionBomb", root, function(r0_142, r1_142, r2_142)
  -- line: [7631, 7666] id: 142
  local r3_142 = threeJunctionsAt[r1_142][r2_142]
  local r4_142 = pcos(r3_142)
  local r5_142 = psin(r3_142)
  local r6_142 = minePosX + r1_142 * 6 - r5_142 * 1.45
  local r7_142 = minePosY + r2_142 * 6 + r4_142 * 1.45
  local r8_142 = minePosZ + 1.5
  if not threeJunctionBombs[r1_142] then
    threeJunctionBombs[r1_142] = {}
  end
  if not threeJunctionBombs[r1_142][r2_142] then
    local r9_142 = createObject(modelIds.v4_mine_dynamite, r6_142, r7_142, r8_142, 0, 0, math.deg(r3_142))
    if isElement(r9_142) then
      setObjectScale(r9_142, 3)
      setElementInterior(r9_142, 0)
      setElementDimension(r9_142, currentMine)
    end
    local r10_142 = playSound3D("files/sounds/tntfuse.mp3", r6_142, r7_142, r8_142)
    if isElement(r10_142) then
      setElementInterior(r10_142, 0)
      setElementDimension(r10_142, currentMine)
    end
    threeJunctionBombs[r1_142][r2_142] = {
      r9_142,
      r4_142,
      r5_142,
      0,
      r6_142,
      r7_142,
      r8_142
    }
  end
  if source ~= resourceRoot then
    setPedHeadingTo(source, r6_142, r7_142)
  end
end)
addMineEventHandler("detonateMineThreeJunctionBomb", root, function(r0_143, r1_143, r2_143)
  -- line: [7670, 7691] id: 143
  local r3_143 = threeJunctionBombs[r1_143] and threeJunctionBombs[r1_143][r2_143]
  if r3_143 then
    table.insert(bombDetonations, {
      r3_143[5],
      r3_143[6],
      r3_143[7],
      0
    })
    spawnSmokeExBg(r3_143[5], r3_143[6], r3_143[7], true)
    detonateDamage(r3_143[5], r3_143[6], r3_143[7])
    if isElement(r3_143[1]) then
      destroyElement(r3_143[1])
    end
    r3_143[1] = nil
  end
  threeJunctionBombs[r1_143][r2_143] = nil
  if not next(threeJunctionBombs[r1_143]) then
    threeJunctionBombs[r1_143] = nil
  end
end)
function detonateDamage(r0_144, r1_144, r2_144)
  -- line: [7694, 7709] id: 144
  local r3_144 = getDistanceBetweenPoints2D(selfPosX, selfPosY, r0_144, r1_144)
  local r4_144 = playSound3D("files/sounds/tnt" .. math.random(1, 5) .. ".wav", r0_144, r1_144, r2_144)
  if isElement(r4_144) then
    setElementInterior(r4_144, 0)
    setElementDimension(r4_144, currentMine)
    setSoundMaxDistance(r4_144, 150)
    setSoundVolume(r4_144, 2)
  end
  local r5_144 = (1 - r3_144 / 12) * 120
  if r5_144 > 0 then
    setElementHealth(localPlayer, math.max(0, getElementHealth(localPlayer) - r5_144))
  end
end
addMineEventHandler("syncMineFurnaceRunning", root, function(r0_145, r1_145, r2_145)
  -- line: [7712, 7760] id: 145
  if not r1_145 then
    local r3_145 = mineFoundryData.furnaceRunning
    if r3_145 then
      local r4_145 = oreTypes[r3_145]
      if r4_145 then
        local r5_145, r6_145, r7_145 = unpack(r4_145.foundryButtonPosition)
        local r8_145 = playSound3D("files/sounds/machinebutton.mp3", r5_145, r6_145, r7_145)
        if isElement(r8_145) then
          setElementInterior(r8_145, 0)
          setElementDimension(r8_145, currentMine)
        end
        if source ~= resourceRoot then
          setPedHeadingTo(source, r5_145, r6_145)
        end
      end
    end
  end
  mineFoundryData.furnaceRunning = r1_145
  if r1_145 then
    local r3_145 = oreTypes[r1_145]
    if r3_145 then
      local r4_145, r5_145, r6_145 = unpack(r3_145.foundryButtonPosition)
      local r7_145 = playSound3D("files/sounds/machinebutton.mp3", r4_145, r5_145, r6_145)
      if isElement(r7_145) then
        setElementInterior(r7_145, 0)
        setElementDimension(r7_145, currentMine)
      end
      r3_145.furnaceTemperature = r2_145
      if source ~= resourceRoot then
        setPedHeadingTo(source, r4_145, r5_145)
      end
      nextSurge = getTickCount()
    end
  end
  shouldRefreshUrmaMotoDevice = true
end)
addMineEventHandler("syncMineOreMelting", root, function(r0_146, r1_146)
  -- line: [7764, 7767] id: 146
  mineFoundryData.meltProgress = 0
  setMeltingOre(r1_146)
end)
function setMeltingOre(r0_147)
  -- line: [7770, 7805] id: 147
  mineFoundryData.meltingOre = r0_147
  if isElement(mineFoundryData.ingotObject) then
    destroyElement(mineFoundryData.ingotObject)
  end
  if isElement(mineFoundryData.meltObject) then
    destroyElement(mineFoundryData.meltObject)
  end
  if r0_147 then
    local r1_147 = oreTypes[r0_147]
    if r1_147 then
      mineFoundryData.ingotObject = createObject(modelIds.v4_mine_ingot, r1_147.ingotPosition[1], r1_147.ingotPosition[2], r1_147.ingotPosition[3], 0, 0, 180)
      if isElement(mineFoundryData.ingotObject) then
        setElementInterior(mineFoundryData.ingotObject, 0)
        setElementDimension(mineFoundryData.ingotObject, currentMine)
      end
      mineFoundryData.meltObject = createObject(modelIds.v4_mine_flow, r1_147.meltPosition[1], r1_147.meltPosition[2], r1_147.meltPosition[3], 0, 0, 180)
      if isElement(mineFoundryData.meltObject) then
        setElementInterior(mineFoundryData.meltObject, 0)
        setElementDimension(mineFoundryData.meltObject, currentMine)
      end
      setMeltingMetal(r0_147)
    end
  else
    mineFoundryData.meltObject = nil
    mineFoundryData.ingotObject = nil
  end
end
addMineEventHandler("gotMineJerrycan", root, function(r0_148, r1_148)
  -- line: [7808, 7810] id: 148
  processJerrycanSync(r1_148)
end)
addMineEventHandler("syncMineJerryContent", root, function(r0_149, r1_149)
  -- line: [7814, 7828] id: 149
  currentMineInventory.jerryContent = r1_149
  if isElement(currentMineInventory.jerryCan) then
    local r2_149, r3_149, r4_149 = getElementPosition(currentMineInventory.jerryCan)
    local r5_149 = playSound3D("files/sounds/jerryballon.wav", r2_149, r3_149, r4_149)
    if isElement(r5_149) then
      setElementInterior(r5_149, 0)
      setElementDimension(r5_149, currentMine)
    end
  end
  shouldRefreshJerryContent = true
end)
addMineEventHandler("syncMineLocoFuel", root, function(r0_150, r1_150, r2_150)
  -- line: [7832, 7834] id: 150
  processLocoFuelSync(r1_150, r2_150)
end)
addMineEventHandler("buildMineLight", root, function(r0_151, r1_151, r2_151, r3_151)
  -- line: [7838, 7841] id: 151
  setStreamedLights(r1_151, r2_151)
  updateMineInventory("mineLamps", r3_151)
end)
addMineEventHandler("gotMineRentDataInside", root, function(r0_152, r1_152, r2_152)
  -- line: [7845, 7850] id: 152
  if r1_152 == "mineName" then
    currentMineName = r2_152
    refreshMineName()
  end
end)
function refreshMineName()
  -- line: [7853, 7910] id: 153
  local r0_153 = -1
  local r1_153 = 0
  local r2_153 = minePosX - 9.1837 + r0_153 * 0.015
  local r3_153 = minePosY + 0.048 + r1_153 * 0.015
  local r4_153 = minePosZ + 2.755
  local r5_153 = 0.083125
  local r6_153 = 0
  r101_0 = {}
  for r10_153 = 1, #currentMineName, 1 do
    local r11_153 = utf8.upper(currentMineName[r10_153])
    for r16_153 = 1, utf8.len(r11_153), 1 do
      local r18_153 = charset[utf8.sub(r11_153, r16_153, r16_153)]
      if r18_153 then
        local r19_153 = r18_153[2] * 0.00296875 / 2
        r2_153 = r2_153 - r1_153 * r19_153
        r3_153 = r3_153 + r0_153 * r19_153
        table.insert(r101_0, {
          r2_153,
          r3_153,
          r4_153,
          r18_153[1],
          r18_153[2]
        })
        r2_153 = r2_153 - r1_153 * r19_153
        r3_153 = r3_153 + r0_153 * r19_153
        r6_153 = r6_153 + r19_153 * 2
      else
        r2_153 = r2_153 - r1_153 * r5_153
        r3_153 = r3_153 + r0_153 * r5_153
        r6_153 = r6_153 + r5_153
      end
    end
    if r10_153 < #currentMineName then
      r2_153 = r2_153 - r1_153 * r5_153
      r3_153 = r3_153 + r0_153 * r5_153
      r6_153 = r6_153 + r5_153
    end
  end
  r6_153 = r6_153 / 2
  for r10_153 = 1, #r101_0, 1 do
    if r101_0[r10_153] then
      r101_0[r10_153][1] = r101_0[r10_153][1] + r1_153 * r6_153
      r101_0[r10_153][2] = r101_0[r10_153][2] - r0_153 * r6_153
    end
  end
end
addMineEventHandler("addMinePermissions", root, function(r0_154, r1_154, r2_154)
  -- line: [7913, 7927] id: 154
  shouldRefreshUrmaMotoDevice = true
  currentMineWorkers[r1_154] = r2_154
  currentMinePermissions[r1_154] = 0
  for r6_154 = #currentMineWorkersList, 1, -1 do
    if currentMineWorkersList[r6_154] == r1_154 then
      table.remove(currentMineWorkersList, r6_154)
      break
    end
  end
  table.insert(currentMineWorkersList, r1_154)
end)
addMineEventHandler("removeMinePermissions", root, function(r0_155, r1_155)
  -- line: [7931, 7943] id: 155
  currentMineWorkers[r1_155] = nil
  currentMinePermissions[r1_155] = nil
  for r5_155 = #currentMineWorkersList, 1, -1 do
    if currentMineWorkersList[r5_155] == r1_155 then
      table.remove(currentMineWorkersList, r5_155)
      break
    end
  end
  shouldRefreshUrmaMotoDevice = true
end)
addMineEventHandler("updateMinePermissions", root, function(r0_156, r1_156)
  -- line: [7947, 7954] id: 156
  for r5_156, r6_156 in pairs(r1_156) do
    if currentMineWorkers[r5_156] then
      currentMinePermissions[r5_156] = r6_156
      shouldRefreshUrmaMotoDevice = true
    end
  end
end)
addMineEventHandler("updateMineWorkerName", root, function(r0_157, r1_157, r2_157)
  -- line: [7958, 7963] id: 157
  if currentMineWorkers[r1_157] then
    currentMineWorkers[r1_157] = r2_157
    shouldRefreshUrmaMotoDevice = true
  end
end)
addMineEventHandler("gotMineOrder", root, function(r0_158, r1_158, r2_158)
  -- line: [7967, 7972] id: 158
  currentMineOrder = r1_158
  currentMineOrdering = {}
  currentMineOrderPaid = r2_158
  shouldRefreshUrmaMotoDevice = true
end)
addMineEventHandler("gotMineOrderPaid", root, function(r0_159, r1_159)
  -- line: [7976, 7979] id: 159
  currentMineOrderPaid = r1_159
  shouldRefreshUrmaMotoDevice = true
end)
addMineEventHandler("playMineFaucetSound", root, function(r0_160)
  -- line: [7983, 7990] id: 160
  local r1_160 = playSound3D("files/sounds/wash.wav", minePosX - 27.3901, minePosY + 2.8282, minePosZ + 1.1891)
  if isElement(r1_160) then
    setElementInterior(r1_160, 0)
    setElementDimension(r1_160, currentMine)
  end
end)